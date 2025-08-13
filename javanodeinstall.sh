#!/bin/bash
set -e

echo "Updating package list..."
sudo apt-get update -y

echo "Installing Java JDK 17..."
sudo apt-get install -y openjdk-17-jdk

echo "Verifying Java installation..."
java -version
javac -version

echo "Installing Maven..."
sudo apt-get install -y maven
mvn -version

echo "Installing Node.js (LTS) and npm..."
sudo apt-get install -y curl
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Verifying Node.js and npm..."
node -v
npm -v

echo "Installing Angular CLI globally..."
sudo npm install -g @angular/cli

echo "Verifying Angular CLI..."
ng version

echo "✅ All tools installed successfully!"
