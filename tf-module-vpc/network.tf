provider "aws" {
  region = "us-west-1"
}

data "aws_availability_zones" "zoneName" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.14.0"

  name = "ModuleVPC"
  cidr = "192.168.0.0/16"

  azs             = data.aws_availability_zones.zoneName.names
  public_subnets  = ["192.168.0.0/24"]
  private_subnets = ["192.168.1.0/24"]

  tags = {
    Name = "testVPCmodule"
  }
}
