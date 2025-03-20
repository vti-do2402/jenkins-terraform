variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID to launch the instance in"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the instance"
  type        = string
}

variable "key_name" {
  description = "SSH key name for the instance"
  type        = string
}

variable "iam_role" {
  description = "IAM Role for the instance"
  type        = string
  default     = ""
}

variable "volume_size" {
  description = "Root volume size (GB)"
  type        = number
  default     = 20
}

variable "volume_type" {
  description = "Root volume type"
  type        = string
  default     = "gp3"
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "user_data" {
  description = "User data to run at instance launch"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags for the EC2 instance"
  type        = map(string)
  default     = {}
}
