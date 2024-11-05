# terraform-aws-vpc

## Overview

This terraform module creates an AWS VPC with a given CIDR block. It also creates multiple subnets (public and private), and for public subnets, it sets up an Internet Gateway (IGW) and appropriate route tables.

## Features

- Creates a VPC with a specified CIDR block
- Creates public and private subnets
- Creates an Internet Gateway (IGW) for public subnets
- Sets up route tables for public subnets

## Usage
```
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

```