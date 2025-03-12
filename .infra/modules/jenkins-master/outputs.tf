# Output the public IP of the Jenkins Master
output "public_ip" {
  value       = module.ec2_instance.public_ip
  description = "The public IP address of the Jenkins Master instance"
}

# Output the public IP of the Jenkins Master
output "private_ip" {
  value       = module.ec2_instance.private_ip
  description = "The private IP address of the Jenkins Master instance"
}

output "security_group_id" {
  value = module.security_group.security_group_id
}

output "ssh_key_path" {
  value = local_file.ssh_private_key.filename
}