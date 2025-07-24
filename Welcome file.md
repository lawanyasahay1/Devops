
  

# 🌐 Hosting a Website Locally with NGINX on Ubuntu (via WSL)

  

## 📝 Overview

  

This guide walks you through the process of:

  

- ✅ Installing Ubuntu using WSL (Windows Subsystem for Linux)

- ✅ Installing and configuring NGINX

- ✅ Hosting a custom HTML portfolio website

- ✅ (Optional) Managing firewall and permissions using UFW

  

---

  

## 🧰 Step 1: Install Ubuntu on Windows Using WSL

  

### 1.1 Enable WSL

  

Open **PowerShell** as Administrator and run:

  

```bash

wsl  --install

```

  

This installs **WSL 2** and the default Ubuntu distribution.

  

---

  

### 1.2 Install Ubuntu from Microsoft Store

  

- Open the **Microsoft Store**

- Search for **"Ubuntu"** (e.g., Ubuntu 22.04 LTS)

- Click **Install**

- Launch Ubuntu from the **Start Menu**

- Set your **username** and **password**

  

---

  

### 1.3 Verify Installation

  

On Ubuntu, run:

  

```bash

lsb_release  -a

```

  

Expected output:

  

```text

Distributor ID: Ubuntu

Description: Ubuntu 22.04 LTS

```

  

---

  

## 🔧 Step 2: Install NGINX Web Server

  

### 2.1 Update the System

  

```bash

sudo  apt  update && sudo  apt  upgrade  -y

```

  

### 2.2 Install NGINX

  

```bash

sudo  apt  install  nginx  -y

```

  

### 2.3 Start and Enable NGINX (WSL compatible)

  

```bash

sudo  systemctl  start  nginx

sudo  systemctl  enable  nginx

sudo  systemctl  status  nginx

```

  

---

  

## 🔐 Step 3: Firewall Configuration (Optional)

  

WSL handles the firewall via Windows, so you usually don't need to configure UFW. Skip this if you're not using a full Linux VM.

  

### 3.1 Install UFW on Ubuntu

  

```bash

sudo  apt  install  ufw  -y

```

  

### 3.2 Enable UFW

  

```bash

sudo  ufw  enable

```

  

⚠️ If you're connected via SSH, allow it **before** enabling UFW:

  

```bash

sudo  ufw  allow  OpenSSH

```

  

### 3.3 Allow NGINX Through Firewall

  

```bash

sudo  ufw  allow  'Nginx Full'

```

  

### 3.4 Check UFW Status

  

```bash

sudo  ufw  status

```

  

Expected output:

  

```text

Nginx Full ALLOW Anywhere

OpenSSH ALLOW Anywhere

```

  

---

  

## 🌍 Step 4: Host a Custom Website

  

### 4.1 Create Website Directory and HTML Page

  

```bash

mkdir  -p  ~/mywebsite

nano  ~/mywebsite/index.html

```

  

Paste the following HTML content (custom portfolio):

  

```html

<!DOCTYPE  html>

<html  lang="en">

<head>

<meta  charset="UTF-8">

<meta  name="viewport"  content="width=device-width, initial-scale=1.0">

<title>Lawanya Sahay Portfolio</title>

<link  href="https://fonts.googleapis.com/css2?family=Hanken+Grotesk&display=swap"  rel="stylesheet">

<style>

body {

margin: 0;

font-family: 'HK Modular', 'Hanken Grotesk', sans-serif;

background: linear-gradient(to bottom, #43025c, #1d0b28);

color: #fff;

display: flex;

justify-content: center;

align-items: center;

height: 100vh;

overflow: hidden;

}

.container {

text-align: center;

max-width: 900px;

padding: 2rem;

background: rgba(0, 0, 0, 0.3);

border-radius: 20px;

box-shadow: 0  0  40px rgba(255, 0, 255, 0.2);

}

.title {

font-size: 3rem;

font-weight: bold;

background: linear-gradient(to right, #ff7ce5, #ffaaff);

-webkit-background-clip: text;

-webkit-text-fill-color: transparent;

margin-bottom: 1rem;

}

.subtitle {

font-size: 1.2rem;

color: #ccc;

margin-top: 1rem;

}

</style>

</head>

<body>

<div  class="container">

<div  class="title">LAWANYA SAHAY<br>PORTFOLIO</div>

<div  class="subtitle">Exploring my journey through innovation<br>and technology</div>

</div>

</body>

</html>

```

  

Save with `Ctrl + O`, press `Enter`, then exit with `Ctrl + X`.

  

---

  

### 4.2 Configure NGINX to Use Your Website

  

Edit the default config:

  

```bash

sudo  nano  /etc/nginx/sites-available/default

```

  

Find and modify:

  

```nginx

root /var/www/html;

```

  

To:

  

```nginx

root /home/<your-username>/mywebsite;

```

  

💡 Replace `<your-username>` with the result of:

  

```bash

whoami

```

  

Also, ensure this line exists:

  

```nginx

index index.html index.htm;

```

  

---

  

### ⚙️ Understanding NGINX Symlinks (Optional Concept)

  

You can enable your custom site config with:

  

```bash

sudo  ln  -s  /etc/nginx/sites-available/mywebsite  /etc/nginx/sites-enabled/

```

  

#### What this does:

-  `ln -s`: creates a symbolic (soft) link

-  `/sites-available/`: where all available configs live

-  `/sites-enabled/`: where NGINX reads active configs

  

✅ This is how admins activate sites without duplicating files.

  

---

  

### 4.3 Restart NGINX and Set Permissions

  

```bash

sudo  nginx  -t

sudo  systemctl  reload  nginx

chmod  -R  755  ~/mywebsite

chmod  +x  ~

```

  

-  `chmod -R 755 ~/mywebsite`: Gives NGINX permission to access website files

-  `chmod +x ~`: Ensures home directory is accessible

  

---

  

### 4.4 View Website in Your Browser

  

Get your WSL IP address:

  

```bash

hostname  -I

```

  

Example output:

  

```text

172.22.218.170

```

  

Now open your browser and go to:

  

```text

http://172.22.218.170

```

  

🎉 You should see your custom **Lawanya Sahay Portfolio** site!

  

---

  

## ✅ Done!

  

You've successfully hosted a custom website using NGINX inside Ubuntu via WSL on Windows!
