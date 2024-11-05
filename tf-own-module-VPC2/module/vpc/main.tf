resource "aws_vpc" "mainVPC" {
  cidr_block = var.vpcConfig.cidr_block
  tags = {
    Name = var.vpcConfig.name
  }
}

resource "aws_subnet" "mainSubnet" {
  vpc_id   = aws_vpc.mainVPC.id
  for_each = var.subnetConfig #key={cidr,az} each.key each.value

  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = each.key
  }
}

locals {
  publicSubnet = {
    #key={} if public is true in subnet_config
    for key, config in var.subnetConfig : key => config if config.public
  }
  privateSubnet = {
    #key={} if public is true in subnet_config
    for key, config in var.subnetConfig : key => config if !config.public
  }
}

resource "aws_internet_gateway" "moduledIGW" {
  vpc_id = aws_vpc.mainVPC.id
  count  = length(local.publicSubnet) > 0 ? 1 : 0 #Execute only if count value is more than 0
}

resource "aws_route_table" "moduledRTBL" {
  count  = length(local.publicSubnet) > 0 ? 1 : 0 #Execute only if count value is more than 0
  vpc_id = aws_vpc.mainVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.moduledIGW[0].id
  }
}

resource "aws_route_table_association" "moduledASRTBL" {
  for_each = local.publicSubnet

  subnet_id      = aws_subnet.mainSubnet[each.key].id
  route_table_id = aws_route_table.moduledRTBL[0].id
}
