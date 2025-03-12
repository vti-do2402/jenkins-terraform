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


variable "metadata" {
  type = map(string)
  default = {
    "home"         = "/opt/jenkins"
    "username"     = "user"
    "password"     = "bitnami"
    # "plugins"      = "git,workflow-aggregator,docker,pipeline-utility-steps,pipeline-input-notification"
  }
}

variable "user" {
  description = "User in the server (e.g., ec2-user)"
  type = string
  default = "ec2-user"
}

variable "jnlp_cidr" {
  type = string
  description = "CIDR blocks allows JNLP communications"
  default = "0.0.0.0/0"
}

variable "run_jenkins" {
  type = bool
  default = false
}

variable "tags" {
  description = "Tags to apply to all resources created by this module"
  type        = map(string)
  default     = {}
}