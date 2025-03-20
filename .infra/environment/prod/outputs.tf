output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the Jenkins VPC"
}

# Output Public Subnets
output "public_subnets" {
  value       = module.vpc.public_subnet_ids
  description = "List of public subnet IDs in the Jenkins VPC"
}

output "security_group_id" {
  value       = module.vpc.jenkins_security_group_id
  description = "Security Group ID for Jenkins"
}

output "jenkins_master" {
  value = {
    instance_id  = module.jenkins_master.instance_id
    public_ip    = module.jenkins_master.public_ip
    private_ip   = module.jenkins_master.private_ip
    ssh_key_path = module.jenkins_master.ssh_key_path
  }
  description = "Jenkins Master instance details"
}

output "jenkins_agents" {
  value = {
    for key, agent in module.jenkins_agents :
    key => {
      instance_id = agent.instance_id
      public_ip   = agent.public_ip
      private_ip  = agent.private_ip
    }
  }
  description = "Jenkins Agents instance details"
}