module "devinfra" {
  source        = "./module"
  environment   = "dev"
  instance_type = "t2.micro"
  quantity      = 1
  ami_id        = "ami-0866a3c8686eaeeba"

}

module "stageinfra" {
  source        = "./module"
  environment   = "stage"
  instance_type = "t2.micro"
  quantity      = 2
  ami_id        = "ami-0866a3c8686eaeeba"
}

module "prodinfra" {
  source        = "./module"
  environment   = "prod"
  instance_type = "t2.micro"
  quantity      = 3
  ami_id        = "ami-0866a3c8686eaeeba"
}
