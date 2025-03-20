variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "Default value for VPC CIDR"
  type        = string
  default     = "172.31.0.0/16"
}

variable "azs" {
  description = "Availability zones for the region"
  type        = list(string)
  default     = []
}

variable "vpc_public_subnets" {
  description = "Public subnets for the VPC"
  type        = list(string)
  default     = []
}

variable "admin_ip" {
  description = "CIDR block of Admin to access instance"
  type        = string
}

variable "jenkins_master" {
  description = "Jenkins Master configuration"
  type = object({
    instance_type = string
    key_name      = string
    volume_size   = number
    username      = string
    password      = string
  })
}

variable "jenkins_agents" {
  description = "List of Jenkins agents to create"
  type = list(object({
    create_ec2    = bool
    run_agent     = bool
    instance_type = string
    key_name      = string
    name          = string
    secret        = string
    work_dir      = string
  }))
}

variable "tags" {
  description = "Tags to apply to all resources created by this module"
  type        = map(string)
  default     = {}
}