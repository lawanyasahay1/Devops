# Hosting a Website with NGINX on Ubuntu (via WSL)

## ✨ Overview

This guide explains how to:

1. Install Ubuntu using **WSL (Windows Subsystem for Linux)**
2. Install and configure NGINX
3. Host a custom HTML website
4. (Optional) Manage firewall and permissions

---

## 🖥️ Step 1: Install Ubuntu on Windows Using WSL

### ✅ 1.1 Enable WSL
Open **PowerShell as Administrator** and run:

```powershell
wsl --install
```

This installs WSL 2 and the default Ubuntu distribution.

---

### ✅ 1.2 Install Ubuntu from Microsoft Store
1. Open the **Microsoft Store**
2. Search for "Ubuntu" (e.g., Ubuntu 22.04 LTS)
3. Click **Install**

Launch Ubuntu from the Start menu and set your **username and password**.

---

### ✅ 1.3 Verify Installation
Run:

```bash
lsb_release -a
```

You should see something like:
```
Distributor ID: Ubuntu
Description:    Ubuntu 22.04 LTS
```

---

## 🌐 Step 2: Install NGINX Web Server

### 2.1 Update the System
```bash
sudo apt update && sudo apt upgrade -y
```

### 2.2 Install NGINX
```bash
sudo apt install nginx -y
```

### 2.3 Start NGINX (WSL compatible)
```bash
sudo service nginx start
```

---

## 🔥 Step 3: Firewall Configuration (Optional)

WSL handles firewall via Windows, so you usually don't need to configure `ufw`. Skip unless you're using a full Linux VM.

---

## 🌍 Step 4: Host a Custom Website

### 4.1 Create Website Directory and HTML Page
```bash
mkdir -p ~/mywebsite
nano ~/mywebsite/index.html
```

Paste:

```html
<!DOCTYPE html>
<html>
<head>
  <title>My First Site</title>
</head>
<body>
  <h1>Hello from My Custom Website!</h1>
</body>
</html>
```

Save (`Ctrl + O`, Enter) and exit (`Ctrl + X`).

---

### 4.2 Configure NGINX to Use Your Website

Edit the default NGINX config:
```bash
sudo nano /etc/nginx/sites-available/default
```

Change:
```nginx
root /var/www/html;
```
To:
```nginx
root /home/your-username/mywebsite;
```

Make sure this line exists:
```nginx
index index.html index.htm;
```

> Replace `your-username` with output from `whoami`

---

### 4.3 Restart NGINX and Apply Config
```bash
sudo nginx -t
sudo service nginx restart
```

---

### 4.4 View Website in Browser

Get your WSL IP address:
```bash
hostname -I
```

Visit in your browser:
```
http://<your-ip-address>
```

You should now see your **custom website**.

---

## 📂 Summary Table

| Task                          | Command / Action                            |
|------------------------------|---------------------------------------------|
| Install WSL                  | `wsl --install`                             |
| Install Ubuntu               | From Microsoft Store                        |
| Update System                | `sudo apt update && sudo apt upgrade -y`    |
| Install NGINX                | `sudo apt install nginx -y`                 |
| Start NGINX (WSL)            | `sudo service nginx start`                 |
| Create HTML Page             | `nano ~/mywebsite/index.html`               |
| Configure NGINX              | `sudo nano /etc/nginx/sites-available/default` |
| Test & Reload NGINX          | `sudo nginx -t && sudo service nginx restart` |

---


