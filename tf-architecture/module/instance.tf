resource "aws_instance" "instance" {
  count         = var.quantity
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = "${var.environment}-stageinstance"
  }
}
