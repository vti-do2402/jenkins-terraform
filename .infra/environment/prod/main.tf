module "vpc" {
  source              = "../../modules/networking"
  vpc_cidr            = var.vpc_cidr
  availability_zones  = length(var.azs) > 0 ? var.azs : local.azs
  public_subnet_cidrs = var.vpc_public_subnets
  cluster_name        = "${local.tags.Owner}-${local.tags.Project}"
  admin_ip            = var.admin_ip

  tags = merge(local.tags, var.tags)
}

module "jenkins_master" {
  source            = "../../modules/compute"
  instance_name     = "${local.prefix}-jenkins-master"
  ami_id            = data.aws_ami.amazon_linux.id
  instance_type     = var.jenkins_master.instance_type
  key_name          = var.jenkins_master.key_name
  subnet_id         = module.vpc.public_subnet_ids[0]
  volume_size       = var.jenkins_master.volume_size
  security_group_id = module.vpc.jenkins_security_group_id
  user_data = templatefile("${path.module}/scripts/jenkins-master-startup.sh", {
    hostname         = "jenkins-master"
    jenkins_home     = "/opt/jenkins"
    jenkins_username = var.jenkins_master.username
    jenkins_password = var.jenkins_master.password
  })

  tags = merge(local.tags, var.tags)
}

module "jenkins_agents" {
  depends_on = [module.jenkins_master]
  source     = "../../modules/compute"

  for_each          = { for idx, agent in var.jenkins_agents : idx => agent }
  instance_name     = "${local.prefix}-jenkins-agent-${each.key + 1}"
  ami_id            = data.aws_ami.amazon_linux.id
  instance_type     = each.value.instance_type
  key_name          = "${each.value.key_name}-${each.key + 1}"
  subnet_id         = module.jenkins_master.subnet_id
  security_group_id = module.vpc.jenkins_security_group_id
  user_data         = file("${path.module}/scripts/jenkins-agent-startup.sh")

  tags = merge(local.tags, var.tags)
}