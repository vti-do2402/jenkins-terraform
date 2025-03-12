module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.7.1"

  name                        = "${var.tags.Project}-${var.tags.Environment}-jenkins-agent"
  instance_type               = var.instance_type
  key_name                    = module.key_pair.key_pair_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [module.security_group.security_group_id]
  associate_public_ip_address = true

  # root_block_device = [{
  #   encrypted   = true
  #   volume_type = "gp3"
  #   volume_size = 8
  # }]

  user_data = templatefile("${path.module}/scripts/startup.sh", {
    hostname     = "jenkins-agent"
    jenkins_home = var.jenkins_home
    jenkins_url  = var.jenkins_url
    jenkins_secret = var.jenkins_secret
    jenkins_name = var.jenkins_name
  })

  tags = merge(var.tags, { Role : "jenkins-agent" })
}

module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "~> 2.0.3"


  key_name           = "${var.tags.Project}-${var.tags.Environment}-jenkins-agent-key" # "${var.name}-devops-key"
  create_private_key = true
}

resource "local_file" "ssh_private_key" {

  content  = module.key_pair.private_key_pem
  file_permission = "0600"
  filename = "${path.root}/.ssh/${module.key_pair.key_pair_name}.pem" # "./ssh_keys/${var.name}-devops-key.pem"
}


module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.3.0"


  name        = "${var.tags.Project}-${var.tags.Environment}-jenkins-agent-sg"
  description = "Jenkins Master Security Group"
  vpc_id      = var.vpc_id

  # ingress_cidr_blocks = ["0.0.0.0/0"]
  # ingress_rules       = ["smtps-465-tcp", "https-443-tcp"]

  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = var.admin_ip
    },
    {
      rule        = "http-8080-tcp"
      cidr_blocks = var.admin_ip
    },
    {
      protocol    = "tcp"
      from_port   = 50000
      to_port     = 50000
      description = "JNLP Agent Communication"
      cidr_blocks = var.jnlp_cidr
    },
  ]

  egress_rules = ["all-all"]


}