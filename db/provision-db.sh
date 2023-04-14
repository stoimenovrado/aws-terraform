#!/bin/bash

#Install mariadb and git
sudo apt-get update -y
sudo apt-get install mariadb-server -y
sudo mysql_secure_installation
sudo apt-get install git -y

#Start MariaDB
sudo systemctl enable mariadb
sudo systemctl start mariadb

#Allow DB to listen on all ports
sudo sed -i.bak s/127.0.0.1/0.0.0.0/g /etc/mysql/mariadb.conf.d/50-server.cnf
sudo systemctl restart mariadb

#Downloading project
sudo mkdir bgapp
cd bgapp
sudo git clone https://github.com/shekeriev/bgapp

#Create and load the database
sudo mysql -u root < bgapp/db/db_setup.sql
