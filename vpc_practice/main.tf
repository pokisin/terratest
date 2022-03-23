provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.subnet_cidr[0]
  availability_zone = var.az[1]
  tags = {
    Name = var.subnet_name[1]
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.subnet_cidr[2]
  availability_zone = var.az[2]
  tags = {
    Name = var.subnet_name[2]
  }
}