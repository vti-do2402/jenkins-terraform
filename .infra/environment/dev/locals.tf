locals {
  azs            = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets = [for i, az in local.azs : cidrsubnet(var.vpc_cidr, 8, i + 1)]

  prefix = "${local.tags.Owner}-${local.tags.Project}"
  tags = {
    # Code    = "do2402"
    Owner   = "quentin"
    Project = "jenkins"
  }
}