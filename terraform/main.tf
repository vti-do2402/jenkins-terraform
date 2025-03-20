terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

locals {
  azs            = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets = [for i, az in local.azs : cidrsubnet("172.31.0.0/16", 8, i)]

  tags = {
    Code    = "do2402"
    Owner   = "Quentin"
    Project = "quentin-hw3"
  }
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.17.0"

  name               = "test-vpc"
  cidr               = "172.31.0.0/16"
  azs                = local.azs
  public_subnets     = local.public_subnets
  enable_nat_gateway = false
  create_igw         = false

  tags = local.tags
}
