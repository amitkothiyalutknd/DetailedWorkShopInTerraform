resource "aws_s3_bucket" "bucket" {
  bucket = "${var.environment}-stagebucket"
  tags = {
    Name        = "${var.environment}-stagebucket"
    environment = var.environment
  }
}
