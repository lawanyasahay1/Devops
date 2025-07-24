
# 🚀 Quick Commands and EC2 Deployment Guide

## 🛠️ Local Setup Task Table

| Task                   | Command / Action                                      |
|------------------------|--------------------------------------------------------|
| Install WSL            | `wsl --install`                                        |
| Install Ubuntu         | Install from Microsoft Store                           |
| Update System          | `sudo apt update && sudo apt upgrade -y`               |
| Install NGINX          | `sudo apt install nginx -y`                            |
| Start NGINX (WSL)      | `sudo service nginx start`                             |
| Create HTML Page       | `nano ~/mywebsite/index.html`                          |
| Configure NGINX        | `sudo nano /etc/nginx/sites-available/default`         |
| Test & Restart NGINX   | `sudo nginx -t && sudo service nginx restart`          |

---

# 🌍 Deploying a Website to Amazon EC2 (Amazon Linux) with NGINX

## Step 1: Launch an EC2 Instance with Amazon Linux and a Key Pair

### 1.1 Open AWS EC2 Dashboard

- Go to the [AWS Management Console](https://aws.amazon.com/console/).
- Search for **EC2** and open the service.
- Click **"Launch Instance"**.

### 1.2 Choose a Name for Your Instance

Example: `my-website-server`

### 1.3 Choose an Amazon Machine Image (AMI)

- Select: **Amazon Linux 2023 AMI (HVM), Kernel 6.1, SSD Volume Type (64-bit x86)**

### 1.4 Choose Instance Type

- Select: **t2.micro (Free Tier eligible)**

### 1.5 Configure Key Pair (Important for SSH Access)

- Create or select a key pair (download the `.pem` file).
- Example: `my-ec2-key.pem`

⚠️ Keep your `.pem` file safe. It is required to SSH into your instance.

### 1.6 Configure Network Settings (Security Group)

| Type   | Protocol | Port | Source           | Purpose                        |
|--------|----------|------|------------------|--------------------------------|
| SSH    | TCP      | 22   | My IP            | Connect via SSH                |
| HTTP   | TCP      | 80   | Anywhere (0.0.0.0/0) | Serve website via browser |
| HTTPS  | TCP      | 443  | Anywhere         | (Optional) Secure access       |

### 1.7 Storage Settings

- Default: **8 GiB General Purpose SSD (gp2 or gp3)**

### 1.8 Launch Your Instance

- Click **"Launch Instance"**
- Then **View all instances** to monitor status

### 1.9 Locate Public IP of Your Instance

- After instance is running, copy the **Public IPv4** address

---

## Step 2: Connect to EC2 Instance via SSH

```bash
ssh -i your-key.pem ec2-user@<your-ec2-public-ip>
```

Replace `your-key.pem` and `<your-ec2-public-ip>` with actual values.

---

## Step 3: Install NGINX on Amazon Linux

```bash
sudo yum update -y
sudo amazon-linux-extras enable nginx1
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
```

---

## Step 4: Upload Your Website Files

On your local machine:

```bash
scp -i your-key.pem index.html ec2-user@<your-ec2-public-ip>:/tmp
```

On the EC2 instance:

```bash
sudo mv /tmp/index.html /usr/share/nginx/html/
sudo systemctl reload nginx
```

To upload a full folder:

```bash
scp -r -i your-key.pem mywebsite/ ec2-user@<your-ec2-public-ip>:/tmp
```

Then:

```bash
sudo rm -rf /usr/share/nginx/html/*
sudo mv /tmp/mywebsite/* /usr/share/nginx/html/
```

---

## Step 5: View Your Website

Open in browser:

```
http://<your-ec2-public-ip>
```

✅ Example: `http://16.171.136.227/`

You should now see your custom website hosted on EC2!
