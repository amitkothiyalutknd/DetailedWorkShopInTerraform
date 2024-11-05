#EC2 Key
resource "aws_key_pair" "devec2key" {
  key_name   = "devec2key"
  public_key = file("E:/TerraformDetailedWorkshop/tf-architecture/devstageec2.pub")
}

#Default VPC
resource "aws_default_vpc" "defaultVPC" {
  tags = {
    Name = "DefaultVPC"
  }
}

#Security Group
resource "aws_security_group" "devec2sg" {
  description = "This Security Group Is Open To Port 22 for internet connection with devec2."
  name        = "devec2sg"
  vpc_id      = aws_default_vpc.defaultVPC.id #Interpolation
  #Incoming traffic
  ingress {
    description = "This is for accessing of ssh."
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #0.0.0.0/0 means all IP addresses
  }

  #Outgoing traffic
  egress {
    description = "This is for outgoing internet traffic."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "devec2" {
  ami             = "ami-0866a3c8686eaeeba"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.devec2key.key_name
  security_groups = [aws_security_group.devec2sg.name]
  tags = {
    Name = "DevStageEC2"
  }
}
