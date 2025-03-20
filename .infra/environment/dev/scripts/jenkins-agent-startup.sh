#!/bin/bash

set -e  # Exit on any error

# Update system packages
yum update -y

# Install Dependencies
yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

# Install Dependencies
yum install -y \
    java-17-amazon-corretto \
    git \
    terraform \
    docker

# Start Docker
systemctl start docker
systemctl enable docker

# Grant Jenkins Agent access to Docker
groupadd -f docker  # Prevents errors if the group already exists
usermod -aG docker ec2-user
chmod 660 /var/run/docker.sock
chown root:docker /var/run/docker.sock
