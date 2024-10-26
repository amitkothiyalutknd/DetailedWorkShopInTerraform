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

resource "aws_vpc" "demovpc" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "UsefulVPC"
  }
}

resource "aws_subnet" "privateSubnet" {
  cidr_block = "192.168.1.0/24"
  vpc_id     = aws_vpc.demovpc.id

  tags = {
    Name = "PrivateSubnet"
  }
}

resource "aws_subnet" "publicSubnet" {
  cidr_block = "192.168.2.0/24"
  vpc_id     = aws_vpc.demovpc.id

  tags = {
    Name = "PublicSubnet"
  }
}

resource "aws_internet_gateway" "vpcigw" {
  vpc_id = aws_vpc.demovpc.id

  tags = {
    Name = "VPC Internet Gateway"
  }
}

resource "aws_route_table" "vpcrtble" {
  vpc_id = aws_vpc.demovpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpcigw.id
  }
}

resource "aws_route_table_association" "rtbleactn" {
  route_table_id = aws_route_table.vpcrtble.id
  subnet_id      = aws_subnet.publicSubnet.id
}

resource "aws_instance" "DemoVPCServer" {
  ami           = "ami-*****************"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.publicSubnet.id

  tags = {
    Name = "Demo VPC Server"
  }
}

output "vpcName" {
  value = aws_vpc.demovpc.arn
}
