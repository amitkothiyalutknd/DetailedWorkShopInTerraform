terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.72.1"
    }
  }
  backend "s3" {
    bucket = "testingbucket147852369-9f966710a9477f3cfc564e21b91bf574"
    key    = "backend.tfstate"
    region = "us-west-1"
  }
}

provider "aws" {
  # Configuration options
  region = "us-west-1"
  # region = var.region
}

resource "aws_instance" "TestingServer" {
  ami           = "ami-0cf4e1fcfd8494d5b"
  instance_type = "t2.micro"

  tags = {
    Name = "SuccessTesting"
  }
}
