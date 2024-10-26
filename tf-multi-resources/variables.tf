# =======================METHOD2=========================
variable "ec2Config" {
  type = list(object({
    ami           = string
    instance_type = string
  }))
}
# =======================METHOD3=========================
variable "ec2Configmap" {
    type = map(object({
        ami = string
        instance_type = string
    }))
}