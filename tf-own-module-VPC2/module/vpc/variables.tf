variable "vpcConfig" {
  description = "To get the CIDR & Name of VPC from the user"
  type = object({
    cidr_block = string
    name       = string
  })
  validation {
    condition     = can(cidrnetmask(var.vpcConfig.cidr_block))
    error_message = "Invalid CIDR Format -> ${var.vpcConfig.cidr_block}"
  }
}

variable "subnetConfig" {
  description = "To get the CIDR & Name of VPC from the subnet"
  type = map(object({
    cidr_block = string
    az         = string
    public     = optional(bool, false)
  }))
  validation {
    #sub1 = {cidr=..} sub2={cidr=..} [true, true]
    condition     = alltrue([for config in var.subnetConfig : can(cidrnetmask(config.cidr_block))])
    error_message = "Invalid CIDR Format of subnet"
  }
}
