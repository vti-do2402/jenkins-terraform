output "vpc_id" {
  value = module.jenkins_vpc.vpc.vpc_id
  description = "The ID of the Jenkins VPC"
}

# Output Public Subnets
output "public_subnets" {
  value       = module.jenkins_vpc.vpc.public_subnets
  description = "List of public subnet IDs in the Jenkins VPC"
}

# Output the public IP of the Jenkins Master
output "jenkins_master_public_ip" {
  value       = module.jenkins_master.public_ip
  description = "The public IP address of the Jenkins Master instance"
}

# Output the public IP of the Jenkins Master
output "jenkins_master_private_ip" {
  value       = module.jenkins_master.private_ip
  description = "The private IP address of the Jenkins Master instance"
}

# Output Jenkins Master Security Group ID
output "jenkins_master_security_group_id" {
  value       = module.jenkins_master.security_group_id
  description = "Security Group ID for the Jenkins Master instance"
}

# Conditional Output for Jenkins Agent (Only if `var.run_agent` is true)
output "jenkins_agent_public_ip" {
  value       = var.run_agent ? module.jenkins_agent[0].public_ip : null
  description = "Public IP address of the Jenkins Agent instance (if deployed)"
}

output "jenkins_agent_private_ip" {
  value       = var.run_agent ? module.jenkins_agent[0].private_ip : null
  description = "Private IP address of the Jenkins Agent instance (if deployed)"
}

output "jenkins_agent_security_group_id" {
  value       = var.run_agent ? module.jenkins_agent[0].security_group_id : null
  description = "Security Group ID for the Jenkins Agent instance (if deployed)"
}