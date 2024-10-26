terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.72.1"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-west-1"
}

locals {
  project = "DevOps"
}

resource "aws_vpc" "DevOps" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "${local.project}-VPC"
  }
}

resource "aws_subnet" "DevOpsSubnet" {
  vpc_id     = aws_vpc.DevOps.id
  cidr_block = "192.168.${count.index}.0/24"
  count      = 2

  tags = {
    Name = "${local.project}-Subnet-${count.index}"
  }
}

resource "aws_instance" "DevOpsInstance" {
  # =======================METHOD1=========================
  #   ami           = "ami-0cf4e1fcfd8494d5b"
  #   instance_type = "t2.micro"
  #   count         = 4
  #   subnet_id     = element(aws_subnet.DevOpsSubnet[*].id, count.index % length(aws_subnet.DevOpsSubnet))

  # =======================METHOD2=========================
  #   count         = length(var.ec2Config)
  #   ami           = var.ec2Config[count.index].ami
  #   instance_type = var.ec2Config[count.index].instance_type

  #   subnet_id = element(aws_subnet.DevOpsSubnet[*].id, count.index % length(aws_subnet.DevOpsSubnet))

  # =======================METHOD3=========================
  for_each = var.ec2Configmap

  ami           = each.value.ami
  instance_type = each.value.instance_type

  subnet_id = element(aws_subnet.DevOpsSubnet[*].id, index(keys(var.ec2Configmap), each.key) % length(aws_subnet.DevOpsSubnet))

  tags = {
    Name = "${local.project}-Instance-${each.key}"
  }
}

output "aws_subnet_id" {
  # value = aws_subnet.DevOpsSubnet[0].id
  value = aws_subnet.DevOpsSubnet[1].id
}
