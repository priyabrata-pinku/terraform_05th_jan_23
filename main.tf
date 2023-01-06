module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = var.vpc_cidr_blocks

  azs             = [var.avail_zone]
  public_subnets  = [var.subnet_cidr_blocks]

  tags = {
    Name = "${var.env_prefix}-vpc"
  }

  public_subnet_tags = {
    Name = "${var.env_prefix}-subnet"
  }
}

module "myapp-server" {
  source = "./modules/webservers"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnets[0]
  avail_zone = var.avail_zone
  env_prefix = var.env_prefix
  my_ip = var.my_ip
  instance_type = var.instance_type
  public_key_location = var.public_key_location
  image_name = var.image_name
}