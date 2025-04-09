pipeline {
    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    agent any
    stages {
        stage('Checkout') {
            steps {
                dir("terraform") {
                    git "https://github.com/yeshwanthlm/Terraform-Jenkins.git"
                }
            }
        }
        stage('Plan') {
            steps {
                sh 'cd terraform/ && terraform init'
                sh 'cd terraform/ && terraform plan -out=tfplan'
                sh 'cd terraform/ && terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('Apply') {
            steps {
                sh 'cd terraform/ && terraform apply -input=false tfplan'
            }
        }
    }
    // Approval outside of stages
    post {
        beforeInput {
            // Conditional approval prompt
            script {
                if (!params.autoApprove) {
                    def plan = readFile 'terraform/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                          parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }
    }
}
