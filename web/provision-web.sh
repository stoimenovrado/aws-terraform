#!/bin/bash

#Install and start Nginx
sudo yum install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx 

#Install git, php
sudo yum update -y
sudo yum install git -y
sudo yum install php -y
sudo yum install php-curl -y
sudo yum install php-mysqlnd -y
sudo systemctl restart nginx

#Copy the git project and clone the web part
sudo mkdir bgapp
cd bgapp
sudo git clone https://github.com/shekeriev/bgapp
sudo cp bgapp/web/* /usr/share/nginx/html/
sudo mv /usr/share/nginx/html/index.html /usr/share/nginx/html/index.html-old

#Configure db host
sudo sh -c 'echo "10.10.10.117 db.host db" >> /etc/hosts'
