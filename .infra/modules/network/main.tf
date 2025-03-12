module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.17.0"

  name               = var.vpc_name
  cidr               = var.vpc_cidr
  azs                = var.azs
  public_subnets     = var.vpc_public_subnets
  enable_nat_gateway = false
  create_igw         = true

  tags = var.tags
}




