variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "prefix" {
  description = "Name for the VPC"
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

variable "jenkins_master_instance_type" {
  description = "Instance type for the Jenkins EC2 instance"
  type        = string
  default     = "t2.medium"
}

variable "run_jenkins_master" {
  type    = bool
  default = false
}

variable "jenkins_agent_instance_type" {
  description = "Instance type for the Jenkins EC2 instance"
  type        = string
  default     = "t2.medium"
}

variable "jenkins_agent_metadata" {
  type = map(string)

}
variable "run_agent" {
  type    = bool
  default = false
}



variable "tags" {
  description = "Tags to apply to all resources created by this module"
  type        = map(string)
  default     = {}
}