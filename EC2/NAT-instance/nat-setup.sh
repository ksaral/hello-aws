#!/bin/bash
# NAT Instance Setup Script for Amazon Linux 2

# Enable IP forwarding immediately
sysctl -w net.ipv4.ip_forward=1

# Make IP forwarding persistent across reboots
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

# Install iptables services if not already present
yum install -y iptables-services

# Flush existing rules
iptables -F
iptables -t nat -F

# Set up NAT masquerading on the primary interface (eth0)
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Save iptables rules
service iptables save

# Enable iptables service at boot
systemctl enable iptables
systemctl start iptables
