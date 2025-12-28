#!/bin/bash

# This is a safety feature. It tells the script to exit immediately if any command fails. 
# This prevents the script from half-installing things if something goes wrong.
set -e

# Log everything to a file for debugging
exec > >(tee /var/log/user-data.log) # stdout → console + log file
exec 2>&1 # stderr → wherever stdout goes


echo "Starting user data script..."

# Update system packages
yum update -y

# Install Docker
yum install -y docker

# Start Docker service
systemctl start docker
systemctl enable docker

# Add ec2-user to docker group (so you can run docker without sudo)
usermod -a -G docker ec2-user

# Pull the Flask app image from Docker Hub
docker pull ${docker_image}

# Run the Flask container
docker run -d \
  --name flask-app \
  --restart unless-stopped \
  -p 5000:5000 \
  -e APP_VERSION="${app_version}" \
  -e ENVIRONMENT="${environment}" \
  -e PORT=5000 \
  ${docker_image}

# Verify if container is running
sleep 5
docker ps

echo "User data script completed successfully."