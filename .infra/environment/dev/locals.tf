locals {
  azs            = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets = [for i, az in local.azs : cidrsubnet(var.vpc_cidr, 8, i + 1)]

  tags = {
    Code    = "do2402"
    Owner   = "Quentin"
    Project = "quentin-hw3"
  }
}