#!/bin/bash

# Update package list
sudo apt update

# Install Nginx
sudo apt install nginx

# Start Nginx service
sudo systemctl start nginx

# Enable Nginx to start on boot
sudo systemctl enable nginx

# Remove the default Nginx configuration
sudo unlink /etc/nginx/sites-enabled/default

# Create a new Nginx configuration file for reverse proxy
sudo tee /etc/nginx/sites-available/reverse-proxy > /dev/null <<EOF
server {
    listen 80;
    server_name localhost;
    location / {
        proxy_pass http://10.128.0.39:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF

# Create a symbolic link to enable the reverse proxy configuration
sudo ln -s /etc/nginx/sites-available/reverse-proxy /etc/nginx/sites-enabled/

# Reload Nginx to apply changes
sudo systemctl reload nginx
