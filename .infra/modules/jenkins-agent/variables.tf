variable "admin_ip" {
  description = "CIDR block of Admin to access instance"
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "instance_type" {
  description = "Instance type for the Jenkins EC2 instance"
  type        = string
  default     = "t2.medium"
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be launched"
  type        = string
}

variable "jenkins_home" {
  type = string
  default = "/opt/jenkins"
}

variable "jenkins_name" {
  type = string
}

variable "jenkins_secret" {
  type = string
}

variable "jenkins_url" {
    description = "Jenkins URL in full format (e.g., http://<jenkins_master_public_ip>:8080)"
    type = string
  
}

variable "jnlp_cidr" {
  type = string
  description = "CIDR blocks allows JNLP communications"
  default = "0.0.0.0/0"
}

# variable "run_agent" {
#   type = bool
#   description = "Run agent jar. Default 0"
#   default = false
# }


variable "tags" {
  description = "Tags to apply to all resources created by this module"
  type        = map(string)
  default     = {}
}
