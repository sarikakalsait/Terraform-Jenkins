provider "aws" {
    region = "us-east-1"  
}

resource "aws_instance" "myec2" {
  ami           = "ami-002f6e91abff6eb96"
  instance_type = "t2.micro"
  tags = {
      Name = "TF-Instance"
  }
}
