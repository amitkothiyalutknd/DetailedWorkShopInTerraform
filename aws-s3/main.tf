terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.72.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-west-1"
}

resource "random_id" "randomID" {
  byte_length = 16
}

resource "aws_s3_bucket" "DemoBucket" {
  bucket        = "demobucketname-${random_id.randomID.hex}"
  force_destroy = true

  tags = {
    Name = "Demo Bucket"
  }
}

resource "aws_s3_object" "goal" {
  bucket = aws_s3_bucket.DemoBucket.bucket
  source = "./myfile.txt"
  key    = "myfile.txt"
}

output "bucketName" {
  value = aws_s3_bucket.DemoBucket.id
}

output "randomID" {
  value = random_id.randomID.hex
}
