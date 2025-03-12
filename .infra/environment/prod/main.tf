module "jenkins_vpc" {
  source = "../../modules/network"

  vpc_name           = "${var.prefix}-vpc"
  vpc_cidr           = var.vpc_cidr
  azs                = length(var.azs) > 0 ? var.azs : local.azs
  vpc_public_subnets = length(var.vpc_public_subnets) > 0 ? var.vpc_public_subnets : local.public_subnets

  tags = merge(local.tags, var.tags)

}

module "jenkins_master" {
  source = "../../modules/jenkins-master"

  admin_ip      = var.admin_ip
  instance_type = var.jenkins_master_instance_type
  subnet_id     = module.jenkins_vpc.vpc.public_subnets[0]
  vpc_id        = module.jenkins_vpc.vpc.vpc_id
  jnlp_cidr     = module.jenkins_vpc.vpc.public_subnets_cidr_blocks[0] // agent subnet

  run_jenkins = var.run_jenkins_master
  tags        = merge(local.tags, var.tags)
}

module "jenkins_agent" {
  depends_on = [module.jenkins_master]
  source     = "../../modules/jenkins-agent"
  count      = var.run_agent ? 1 : 0

  admin_ip      = var.admin_ip
  instance_type = var.jenkins_agent_instance_type
  subnet_id     = module.jenkins_vpc.vpc.public_subnets[0]
  vpc_id        = module.jenkins_vpc.vpc.vpc_id
  jenkins_url   = "http://${module.jenkins_master.private_ip}:8080"
  jnlp_cidr     = module.jenkins_vpc.vpc.public_subnets_cidr_blocks[0] // agent subnet

  jenkins_home   = var.jenkins_agent_metadata.home
  jenkins_name   = var.jenkins_agent_metadata.name
  jenkins_secret = var.jenkins_agent_metadata.secret

  tags = merge(local.tags, var.tags)

}

