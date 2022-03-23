terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
    vpc_id = "${aws_vpc.my_vpc.id}"
    cidr_block = "10.0.1.0/24"
}

resource "aws_instance" "master-instance" {
    ami = "ami-04505e74c0741db8d"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.public.id}"
}
resource "aws_instance" "slave-instance" {
    ami = "ami-04505e74c0741db8d"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.public.id}"
    depends_on = ["aws_instance.master-instance"]
    tags = { 
        master_hostname = "${aws_instance.master-instance.private_dns}"
        Name = "slave-instance" 
    }
    lifecycle { 
        ignore_changes = ["tags"]
    }
}