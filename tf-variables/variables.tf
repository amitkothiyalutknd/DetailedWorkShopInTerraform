# $Env:TF_VAR_aws_instance_type="t2.micro"  //Can be direct execute on console


variable "ami" {
  description = "Which ami machine you want to in your server?"
  type        = string
  default     = "ami-0819a8650d771b8be"
}

variable "aws_instance_type" {
  description = "Which type of instance you want to create?"
  type        = string
  # default     = "t2.micro"

  validation {
    condition     = var.aws_instance_type == "t2.micro" || var.aws_instance_type == "t3.micro"
    error_message = "Only t2 or t3 micro allowed."
  }
}

# variable "volume_size" {
#     description = "What should be size of volume?"
#     type = number
#     # default = 20

#     validation {
#       condition = var.volume_size <= 20
#       error_message = "Volume size should be atmost 20 GB."
#     }
# }

# variable "volume_type" {
#     description = "What should be size of volume?"
#     type = string
#     default = "gp2"
# }

variable "ec2_config" {
  type = object({
    volume_size = number
    volume_type = string
  })
  default = {
    volume_size = 20
    volume_type = "gp2"
  }
}

variable "additional_tags" {
  type    = map(string)
  default = {}
}
