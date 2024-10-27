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

resource "aws_s3_bucket" "websitebucket" {
  bucket = "websitebucket-${random_id.randomID.hex}"

  tags = {
    Name = "Website Bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "websiteaccess" {
  bucket = aws_s3_bucket.websitebucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "websitebucketpolicy" {
  bucket = aws_s3_bucket.websitebucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.websitebucket.id}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "webconfiguration" {
  bucket = aws_s3_bucket.websitebucket.id

  index_document {
    suffix = "home.html"
  }
  #   error_document {
  #     key = "error.html"
  #   }
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.websitebucket.bucket
  source       = "./index.html"
  key          = "home.html"
  content_type = "text/html"
}

resource "aws_s3_object" "styles_css" {
  bucket       = aws_s3_bucket.websitebucket.bucket
  source       = "./styles.css"
  key          = "styles.css"
  content_type = "text/css"
}

output "bucketName" {
  value = aws_s3_bucket.websitebucket.id
}

output "randomID" {
  value = random_id.randomID.hex
}

output "webconfigurl" {
  value = aws_s3_bucket_website_configuration.webconfiguration.website_endpoint
}
