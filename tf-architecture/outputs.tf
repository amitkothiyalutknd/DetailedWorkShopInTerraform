output "devec2pubip" {
  value = aws_instance.devec2.public_ip
}

output "devec2priip" {
  value = aws_instance.devec2.private_ip
}
