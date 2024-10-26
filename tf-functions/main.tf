terraform {}

locals {
  value = "Hello World!"
}

variable "stringList" {
  type    = list(string)
  default = ["USA", "Canada", "Australia", "Canada"]
}

output "output" {
  # value = lower(local.value)
  # value = upper(local.value)
  # value = startswith(local.value, "hello")
  # value = split(" ", local.value)
  # value = min(58, 87, 35, 180, 175)
  # value = max(58, 87, 35, 180, 175)
  # value = abs(-373)
  # value = length(var.stringList)
  # value = join(":", var.stringList)
  # value = contains(var.stringList, "Canada")
  # value = var.stringList
  value = toset(var.stringList)
}
