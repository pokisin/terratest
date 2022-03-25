variable "vpc_cidr" {
    type = string
}

variable "vpcname" {
    type = string
}

variable "az" {
  type = string
}

variable "subnet_cidr" {
  type = string
}

variable "subnet_names" {
  type = string
}

variable "ec2_private_ip" {
  type = list(string)
}