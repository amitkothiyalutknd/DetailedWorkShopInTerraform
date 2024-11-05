resource "aws_s3_bucket" "devs3" {
  bucket = "devstages3bucket"
  tags = {
    Name = "devstages3bucket"
  }
}
