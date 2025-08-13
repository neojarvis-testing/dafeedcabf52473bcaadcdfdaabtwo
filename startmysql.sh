#!/bin/bash
set -e

echo "Checking if MySQL is already running..."
if pgrep mysqld > /dev/null; then
    echo "MySQL is already running. PID: $(pgrep mysqld)"
    exit 0
fi

echo "Preparing MySQL runtime directories..."
sudo mkdir -p /var/run/mysqld
sudo mkdir -p /var/log/mysql

echo "Setting proper ownership and permissions..."
sudo chown -R mysql:mysql /var/lib/mysql/
sudo chown -R mysql:mysql /var/run/mysqld/
sudo chown -R mysql:mysql /var/log/mysql/
sudo chmod 755 /var/run/mysqld

echo "Starting MySQL manually..."
sudo mysqld --user=mysql --pid-file=/var/run/mysqld/mysqld.pid --socket=/var/run/mysqld/mysqld.sock --datadir=/var/lib/mysql &

# Wait a moment for MySQL to start
sleep 3

echo "Checking if MySQL started successfully..."
if pgrep mysqld > /dev/null; then
    echo "MySQL started successfully! PID: $(pgrep mysqld)"
    echo "You can now connect with: mysql -u root -p"
else
    echo "Failed to start MySQL. Check the logs:"
    echo "sudo tail /var/log/mysql/error.log"
    exit 1
fi