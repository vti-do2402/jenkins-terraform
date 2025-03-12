#!/bin/bash
set -e

if ! command docker-compose &> /dev/null; then
    # Install docker-compose
    # Ref: https://gist.github.com/npearce/6f3c7826c7499587f00957fee62f8ee9
    sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    sleep 2

    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

docker-compose up -d --build