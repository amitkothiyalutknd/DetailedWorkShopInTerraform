terraform {}

#Number list
variable "numList" {
  type    = list(number)
  default = [1, 2, 3, 4, 5]
}

#Object list Of Person
variable "personList" {
  type = list(object({
    fName = string
    lName = string
  }))
  default = [{
    fName = "Jeff"
    lName = "Bezos"
    }, {
    fName = "Elon"
    lName = "Musk"
    }, {
    fName = "Sunder"
    lName = "Pichai"
  }]
}

variable "mapList" {
  type = map(number)
  default = {
    "one"   = 1
    "two"   = 2
    "three" = 3
    "four"  = 4
    "five"  = 5
  }
}

#Calculation
locals {
  prod = 54 * 2
  sub  = 666 - 66
  add  = 108 * 786
  eqq  = 2 != 4 //Expression

  #double the list
  double = [for num in var.numList : num * 2]
  #Odd Number Only
  odd = [for num in var.numList : num if num % 2 != 0]
  #To get only fname from person list
  fnamelist = [for person in var.personList : person.fName]
  #Work with map
  mapkeyInfo   = [for key, value in var.mapList : key]
  mapvalueInfo = [for key, value in var.mapList : value]

  mapprod = { for key, value in var.mapList : key => value * 5 }
}

output "prod" {
  value = local.prod
}
output "sub" {
  value = local.sub
}
output "add" {
  value = local.add
}
output "eqq" {
  value = local.eqq
}

output "numList" {
  value = var.numList
}

output "ListTwicing" {
  value = local.double
}
output "OddList" {
  value = local.odd
}
output "fnames" {
  value = local.fnamelist
}
output "mapkeyinfo" {
  value = local.mapkeyInfo
}
output "mapvalueinfo" {
  value = local.mapvalueInfo
}
output "mapprod" {
  value = local.mapprod
}
