provider "aws" {
  region = "us-east-1"
}

module "moduledVPC" {
  source = "./module/vpc"

  vpcConfig = {
    cidr_block = "192.168.0.0/16"
    name       = "myOwnVPC"
  }

  subnetConfig = {
    public_subnet1 = {
      cidr_block = "192.168.1.0/24"
      az         = "us-east-1a"
      public     = true
    }

    public_subnet2 = {
      cidr_block = "192.168.2.0/24"
      az         = "us-east-1a"
      public     = true
    }

    private_subnet = {
      cidr_block = "192.168.3.0/24"
      az         = "us-east-1b"
    }
  }
}
