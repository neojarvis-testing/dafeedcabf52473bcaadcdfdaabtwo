#!/bin/bash
set -e

echo "Updating package list..."
sudo apt update

echo "Installing prerequisites..."
sudo apt install -y wget lsb-release gnupg

echo "Downloading MySQL APT repository config..."
wget https://dev.mysql.com/get/mysql-apt-config_0.8.29-1_all.deb

echo "Configuring MySQL APT repo for Debian 11 (works with Debian 12) and MySQL 8.0..."
sudo DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_0.8.29-1_all.deb

# Preconfigure MySQL version
sudo bash -c 'echo "mysql-apt-config mysql-apt-config/select-server select mysql-8.0" | debconf-set-selections'
sudo bash -c 'echo "mysql-apt-config mysql-apt-config/repo-codename select bullseye" | debconf-set-selections'

echo "Updating package list with MySQL repo..."
sudo apt update

echo "Installing MySQL server..."
sudo apt install -y mysql-server