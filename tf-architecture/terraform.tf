# Terraform Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.74.0"
    }
  }
}

#AWS Provider Block
provider "aws" {
  region = "us-east-1"
}
