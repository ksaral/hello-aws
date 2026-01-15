#!/bin/bash
# NAT Instance Setup Script for Amazon Linux 2

# Exit immediately if a command exits with a non-zero status
set -e

# Enable IP forwarding immediately
sysctl -w net.ipv4.ip_forward=1

# Make IP forwarding persistent across reboots
if ! grep -q "net.ipv4.ip_forward" /etc/sysctl.conf; then
  echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
else
  sed -i 's/^net.ipv4.ip_forward.*/net.ipv4.ip_forward = 1/' /etc/sysctl.conf
fi

# Apply settings immediately.
sysctl -p

# Install iptables services if not already present
yum install -y iptables-services

# Flush existing rules
iptables -F
iptables -t nat -F
iptables -F FORWARD

# Set up NAT masquerading on the primary interface (enX0)
iptables -t nat -A POSTROUTING -o enX0 -j MASQUERADE

# Allow established/related connections back in
iptables -A FORWARD -i enX0 -o enX0 -m state --state RELATED,ESTABLISHED -j ACCEPT

# Allow new outbound connections from private subnet
iptables -A FORWARD -i enX0 -o enX0 -j ACCEPT

# Save iptables rules
service iptables save

# Enable iptables service at boot
systemctl enable iptables
systemctl start iptables

echo "NAT setup complete. IP forwarding enabled, masquerade rule applied on enX0."