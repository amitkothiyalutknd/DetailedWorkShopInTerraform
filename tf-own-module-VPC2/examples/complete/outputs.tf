
output "VPC" {
  value = module.moduledVPC.VPC
}

output "PublicSubnet" {
  value = module.moduledVPC.publicSubnets
}

output "PrivateSubnet" {
  value = module.moduledVPC.privateSubnet
}
