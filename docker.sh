#!/bin/bash

# Update the apt package index
echo "Updating package index..."
sudo apt-get update -y

# Install required packages
echo "Installing required packages..."
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker’s official GPG key
echo "Adding Docker's GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release && echo "$ID")/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the repository
echo "Setting up Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$(. /etc/os-release && echo "$ID") \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the apt package index again
echo "Updating package index again..."
sudo apt-get update -y

# Install Docker Engine, CLI, and containerd
echo "Installing Docker..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add current user to the docker group
echo "Adding user $(whoami) to docker group..."
sudo usermod -aG docker $(whoami)

# Start and enable Docker service
docker --version
echo "Starting and enabling Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

echo "Docker installation and setup complete!"
echo "You may need to log out and log back in for group changes to take effect."
