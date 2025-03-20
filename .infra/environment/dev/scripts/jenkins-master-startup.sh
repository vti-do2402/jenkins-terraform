#!/bin/bash

set -e  # Exit on any error

# Set hostname
hostnamectl set-hostname "${hostname}"

# Update system packages
yum update -y

# Install Docker
yum install -y docker
systemctl start docker
systemctl enable docker

# Grant Jenkins Agent access to Docker
groupadd -f docker  # Prevents errors if the group already exists
usermod -aG docker ec2-user
chmod 660 /var/run/docker.sock
chown root:docker /var/run/docker.sock

# Set up Jenkins home directory
mkdir -p "${jenkins_home}"
chown -R 1001:1001 "${jenkins_home}"
chmod -R 775 "${jenkins_home}"

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Create Docker Compose file for Jenkins
cat <<EOF | tee /opt/docker-compose.yml
services:
  jenkins:
    container_name: jenkins
    image: bitnami/jenkins:latest
    environment:
      - JENKINS_USERNAME=${jenkins_username}
      - JENKINS_PASSWORD=${jenkins_password}
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - "${jenkins_home}:/bitnami/jenkins"
EOF

# Start Jenkins container
cd /opt
docker-compose up -d --build