terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.72.1"
    }
  }
}

provider "aws" {
  region     = "us-west-1"
  access_key = "*********************"
  secret_key = "*****************************************"
}

data "aws_ami" "wantedami" {
  most_recent = true
  owners      = ["amazon"] # Amazon AMI
}

data "aws_security_group" "sgname" {
  tags = {
    Name = "default"
  }
}

data "aws_vpc" "wantedVpc" {
  tags = {
    isDefault = "Yes"
    Name      = "default"
  }
}

data "aws_subnet" "subnetdetails" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.wantedVpc.id]
  }

  tags = {
    name = "instancesub"
  }
}

data "aws_availability_zones" "wantedZones" {
  state = "available"
}

data "aws_region" "regioninfo" {
}

data "aws_caller_identity" "callerinfo" {
}

resource "aws_instance" "nginxServer" {
  ami             = data.aws_ami.wantedami.id
  instance_type   = "t2.micro"
  subnet_id       = data.aws_subnet.subnetdetails.id
  security_groups = [data.aws_security_group.sgname.id]
  # user_data = "${file("script.sh")}"
  user_data = file("script.sh")

  tags = {
    Name = "NginxServer"
  }
}

output "amidetail" {
  value = data.aws_ami.wantedami.id
}

output "sgdetail" {
  value = data.aws_security_group.sgname.id
}

output "vpcdetail" {
  value = data.aws_vpc.wantedVpc.id
}

output "Zonesdetail" {
  value = data.aws_availability_zones.wantedZones
}

output "regiondetail" {
  value = data.aws_region.regioninfo
}

output "callerdetail" {
  value = data.aws_caller_identity.callerinfo
}
