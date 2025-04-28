# Docker
vim docker.sh

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
echo "Starting and enabling Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

echo "Docker installation and setup complete!"
echo "You may need to log out and log back in for group changes to take effect." 

docker --version

# Explanation:

# 1. Update the apt package index

sudo apt-get update -y
apt-get update refreshes the list of available packages.

It ensures we download the latest versions from Ubuntu/Debian repositories.

# 2. Install required packages

sudo apt-get install -y ca-certificates curl gnupg lsb-release
These packages are needed before installing Docker:

ca-certificates: Helps in verifying SSL certificates.

curl: Used to download files from the internet.

gnupg: Needed for managing GPG keys (security).

lsb-release: Shows details about the Linux distribution.

# 3. Add Docker’s official GPG key

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release && echo "$ID")/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
GPG keys are used to verify that the software (Docker) comes from a trusted source.

We create a folder /etc/apt/keyrings to store the key safely.

curl downloads Docker’s official GPG key.

gpg --dearmor converts it into a format that Ubuntu/Debian can use.

# 4. Set up the Docker repository

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$(. /etc/os-release && echo "$ID") $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
Adds Docker’s official software source (repository) to our system.

dpkg --print-architecture tells the system architecture (like amd64).

lsb_release -cs gives the Ubuntu/Debian version codename (like jammy, bullseye).

This tells the system where to download Docker from.

# 5. Update apt package index again

sudo apt-get update -y
Now that Docker’s repo is added, we update the package list again to include Docker packages.

# 6. Install Docker Engine and related packages

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
Installs:

docker-ce → Docker Community Edition.

docker-ce-cli → Docker Command Line Interface.

containerd.io → Container runtime that Docker uses internally.

docker-buildx-plugin → Advanced builder for Docker images.

docker-compose-plugin → Used to run multi-container apps.

# 7. Add the current user to the docker group

sudo usermod -aG docker $(whoami)
Adds your user to the docker group.

Without this, you would have to type sudo docker every time.

After this, you can simply type docker commands.

Important: You must log out and log back in for this change to apply.

# 8. Start and enable Docker service

sudo systemctl start docker
sudo systemctl enable docker
systemctl start docker → Starts the Docker service immediately.

systemctl enable docker → Makes Docker start automatically after reboot.

# 9. Final Message

echo "Docker installation and setup complete!"
echo "You may need to log out and log back in for group changes to take effect."
Prints a message so the user knows everything is done.

# Reminds that logout/login is needed for group changes to apply.

