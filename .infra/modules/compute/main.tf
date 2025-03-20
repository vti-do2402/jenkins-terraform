resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = aws_key_pair.key_pair.key_name

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  user_data = var.user_data

  tags = merge(var.tags, {
    Name = var.instance_name
  })
}

###
# KEY PAIR #
###

resource "tls_private_key" "jenkins_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name_prefix = var.key_name
  public_key = tls_private_key.jenkins_key.public_key_openssh
}

resource "local_sensitive_file" "ssh_private_key" {
  content = tls_private_key.jenkins_key.private_key_pem
  filename = "${path.root}/.ssh/${var.key_name}.pem"
  file_permission = "0600"
}