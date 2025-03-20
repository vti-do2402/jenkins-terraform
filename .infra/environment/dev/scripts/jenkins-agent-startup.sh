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

# curl -sO http://54.218.167.173:8080/jnlpJars/agent.jar
# java -jar agent.jar -url http://54.218.167.173:8080/ -secret 7466313ef12af05a7b2805a9d5ae17f442db444e2c4f87f23e8e4775e2f2b12a -name first -webSocket -workDir "/opt/jenkins"

# curl -sO http://10.0.1.201:8080/jnlpJars/agent.jar
# java -jar agent.jar -url http://10.0.1.201:8080/ -secret 7466313ef12af05a7b2805a9d5ae17f442db444e2c4f87f23e8e4775e2f2b12a -name first -workDir "/opt/jenkins"
