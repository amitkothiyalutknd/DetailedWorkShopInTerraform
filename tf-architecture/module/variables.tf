variable "environment" {
  description = "This is environment Infra"
  type        = string
}

variable "ami_id" {
  description = "This is the AMI id for EC2"
  type        = string
}

variable "instance_type" {
  description = "This is the type of instance for EC2"
  type        = string
}

variable "quantity" {
  description = "How many instance should be create?"
  type        = number
}
