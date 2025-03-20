output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "jenkins_security_group_id" {
  description = "Security Group ID for Jenkins"
  value       = aws_security_group.jenkins.id
}