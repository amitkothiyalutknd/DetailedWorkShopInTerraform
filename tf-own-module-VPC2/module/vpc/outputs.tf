
output "VPC" {
  value = aws_vpc.mainVPC.id
}

locals {
  public_subnet_output = {
    for key, config in local.publicSubnet : key => {
      subnet_id = aws_subnet.mainSubnet[key].id
      az        = aws_subnet.mainSubnet[key].availability_zone
    }
  }
  private_subnet_output = {
    for key, config in local.privateSubnet : key => {
      subnet_id = aws_subnet.mainSubnet[key].id
      az        = aws_subnet.mainSubnet[key].availability_zone
    }
  }
}

output "publicSubnets" {
  value = local.public_subnet_output
}

output "privateSubnet" {
  value = local.private_subnet_output
}
