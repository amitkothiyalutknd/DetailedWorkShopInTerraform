resource "aws_dynamodb_table" "dynamotable" {
  name         = "${var.environment}-stagetable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"
  attribute {
    name = "id"
    type = "S"
  }
}
