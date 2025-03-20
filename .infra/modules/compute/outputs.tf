output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.ec2.id
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.ec2.public_ip
}

output "private_ip" {
  description = "Private IP of the EC2 instance"
  value       = aws_instance.ec2.private_ip
}

output "subnet_id" {
  description = "Subnet ID of the EC2 instance"
  value = aws_instance.ec2.subnet_id
}

output "ssh_key_path" {
  description = "Path to the SSH private key"
  value = local_sensitive_file.ssh_private_key.filename
}
