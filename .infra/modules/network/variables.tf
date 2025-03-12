variable "vpc_name" {
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



variable "tags" {
  description = "Tags to apply to all resources created by this module"
  type        = map(string)
  default     = {}
}