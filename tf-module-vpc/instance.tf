module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.1"
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "moduleInstance"

  ami           = "ami-0da424eb883458071"
  instance_type = "t2.micro"
  #   key_name               = "InstanceKey"
  #   monitoring             = true
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Name = "ModuleProject"
    # Terraform   = "true"
    Environment = "dev"
  }
}
