terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # version = "~> 4.0"
      version = "5.72.1"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

locals {
  owner = "USA"
  name  = "Opportunities"
}

resource "aws_instance" "richserver" {
  ami           = var.ami
  instance_type = var.aws_instance_type

  root_block_device {
    delete_on_termination = true
    # volume_size = var.volume_size
    # volume_type = var.volume_type
    volume_size = var.ec2_config.volume_size
    volume_type = var.ec2_config.volume_type
  }

  # tags = {
  #   Name = "SampleServer"
  # }

  # tags = merge(var.additional_tags, {Name = "SampleSerever"})
  tags = merge(var.additional_tags, { Name = local.name })

}
