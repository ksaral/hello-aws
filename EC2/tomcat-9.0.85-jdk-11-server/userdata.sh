#!/bin/bash
yum update -y
yum install java-11-amazon-corretto -y
cd /opt
wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz
tar -xvf apache-tomcat-9.0.85.tar.gz
mv apache-tomcat-9.0.85 tomcat
chown -R ec2-user:ec2-user /opt/tomcat
wget https://tomcat.apache.org/tomcat-9.0-doc/appdev/sample/sample.war
mv sample.war /opt/tomcat/webapps
cd /opt/tomcat/bin
./startup.sh
