provider "aws" {
  region = "us-east-1"
}

variable "vpc_id" {
    default = "vpc-f7291b8d"
} 

data "aws_vpc" "default" { 
    id = var.vpc_id 
}

resource "tls_private_key" "key" {
    algorithm = "RSA"
}

resource "local_file" "private_key" {
    filename = "${path.module}/key1.pem"
    sensitive_content = tls_private_key.key.private_key_pem
    file_permission = "0400"
}

resource "aws_key_pair" "key_pair" {
    key_name = "key1"
    public_key = tls_private_key.key.public_key_openssh
}

resource "aws_security_group" "allow_ssh" {
    vpc_id = data.aws_vpc.default.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["187.226.216.167/32"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "intanceWeb" {
    ami   = "ami-04505e74c0741db8d"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]
    key_name = aws_key_pair.key_pair.key_name

    tags = {
        Name = "Instance Web"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo apt update -y",
            "sudo apt install -y software-properties-common",
            "sudo apt-add-repository --yes --update ppa:ansible/ansible",
            "sudo apt install -y ansible",
            "yes | sudo apt-get install apache2",
            "sudo systemctl enable --now apache2"
        ]

        connection {
            type = "ssh"
            user = "ubuntu"
            host = self.public_ip
            private_key = tls_private_key.key.private_key_pem
        }
    }

    provisioner "local-exec" {
        command = "ping -n 10 ${aws_instance.intanceWeb.public_ip}"
    }
}

output "PrivateIP" { 
    value = "${aws_instance.intanceWeb.private_ip}"
}
output "PublicIP" {
    value = "${aws_instance.intanceWeb.public_ip}"
}