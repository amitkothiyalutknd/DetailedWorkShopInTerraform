terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-west-1"
}

resource "aws_security_group" "main" {
  name = "minesg"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VirtualSGTesting"
  }

}

resource "aws_instance" "main" {
  ami           = "ami-0cf4e1fcfd8494d5b"
  instance_type = "t2.micro"
  #   vpc_security_group_ids = [aws_security_group.main.id]
  depends_on = [aws_security_group.main]
  count      = 1

  lifecycle {
    create_before_destroy = true
    # prevent_destroy = true
    # ignore_changes = [password_length, password_reset_required, pgp_key]
    # replace_triggered_by = [aws_security_group.main, aws_security_group.main.ingress]
  }


  tags = {
    Name = "VirtualEC2Testing"
  }
}
