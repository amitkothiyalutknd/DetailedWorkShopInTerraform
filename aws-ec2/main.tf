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
  # region = "us-west-1"
  region = var.region
}

resource "aws_instance" "TestingServer" {
  ami           = "ami-0cf4e1fcfd8494d5b"
  instance_type = "t2.micro"

  tags = {
    Name = "SuccessTesting"
  }
}
