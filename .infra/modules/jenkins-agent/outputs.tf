output "public_ip" {
  value = module.ec2_instance.public_ip
}

output "private_ip" {
  value = module.ec2_instance.private_ip
}

output "security_group_id" {
  value = module.security_group.security_group_id
}