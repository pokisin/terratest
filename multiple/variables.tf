variable "ami" { 
    type = map
    default = {
        "us-east-1" = "ami-04169656fea786776"
        "us-west-1" = "ami-006fce2a9625b177f" 
    }
}

variable "instance_count" {
    type = string 
    default = "2"
} 

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "aws_region" {
    type = string
    default = "us-east-1"
}