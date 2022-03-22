terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" { 
    access_key = "xxxxxxxxxxxxxxxx" 
    secret_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    region = "us-east-1" 
}

resource "aws_instance" "hello-instance" {
    ami = "ami-04505e74c0741db8d"
    instance_type = "t2.micro"
    tags = {
        Name = "hello-instance"
    }
}