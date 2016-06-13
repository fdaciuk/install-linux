#!/bin/sh

##
## Bash install script for mongo 3.2 for Ubuntu 15.04, because of
## the replacement of upstart with systemd
##
## - AUTHOR:  Alexandru Budurovici <https://w0rldart.com>
## - VERSION: 1.0
##

# Make sure we're running with root permissions
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Install Mongo
# https://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list
apt-get update
apt-get install -y mongodb-org

# Create the SystemD dependant files
echo '[Unit]
Description=High-performance, schema-free document-oriented database
After=syslog.target
After=network.target
[Service]
# Type=forking
# User=mongodb
# Group=mongodb
# PermissionsStartOnly=true
# PIDFile=/var/run/mongodb.pid
ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf
[Install]
WantedBy=multi-user.target' > /lib/systemd/system/mongod.service

# Anticipate to the log issue
touch /var/log/mongodb/mongod.log
chown -R mongodb:mongodb /var/log/mongodb/

# Start the new service and enable it on boot
systemctl daemon-reload
systemctl enable mongod.service
systemctl start mongod.service
