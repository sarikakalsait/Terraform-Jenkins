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
                script {
                    dir("terraform") {
                        git "https://github.com/sarikakalsait/Terraform-Jenkins.git"
                    }
                }
            }
        }
        stage('Plan') {
            steps {
                sh '''
                    cd terraform/
                    terraform init
                    terraform plan -out=tfplan
                    terraform show -no-color tfplan > tfplan.txt
                '''
            }
        }
        stage('Apply') {
            steps {
                sh '''
                    cd terraform/
                    terraform apply -input=false tfplan
                '''
            }
        }
    }
}
