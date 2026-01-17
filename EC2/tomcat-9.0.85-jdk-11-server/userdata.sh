#!/bin/bash

# Define log file
LOGFILE="/var/log/tomcat-setup.log"

# Redirect stdout and stderr to log file
exec > >(tee -a ${LOGFILE}) 2>&1

echo "===== Starting Tomcat setup at $(date) ====="

echo "Updating system packages..."
yum update -y

echo "Installing Java 11 Amazon Corretto..."
yum install java-11-amazon-corretto -y

echo "Changing to /opt directory..."
cd /opt

echo "Downloading Tomcat 9.0.85..."
wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz

echo "Extracting Tomcat archive..."
tar -xvf apache-tomcat-9.0.85.tar.gz

echo "Renaming Tomcat directory..."
mv apache-tomcat-9.0.85 tomcat

echo "Changing ownership to ec2-user..."
chown -R ec2-user:ec2-user /opt/tomcat

echo "Downloading sample WAR file..."
wget https://tomcat.apache.org/tomcat-9.0-doc/appdev/sample/sample.war

echo "Moving sample WAR to Tomcat webapps..."
mv sample.war /opt/tomcat/webapps

echo "Starting Tomcat..."
cd /opt/tomcat/bin
./startup.sh

echo "===== Tomcat setup completed at $(date) ====="
