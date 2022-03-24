terraform {
  cloud {
    organization = "wussines"

    workspaces {
      name = "InstanceCLI"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}

provider "aws" {
  region     = "us-east-1"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

resource "aws_instance" "instanceCLI" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  tags = {
    Name = "instanceCLI"
  }
}