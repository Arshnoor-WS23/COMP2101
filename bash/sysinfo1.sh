#!/bin/bash

# Display the fully-qualified domain name
echo "FQDN: $(hostname -f)"

# Display operating system information
echo "Host Information:"
hostnamectl

# Display IP addresses
echo "IP Addresses:"
ip addr show | grep "inet " | awk '{ if ($2 != "127.0.0.1/8") print $2 }'

# Display root filesystem status
echo "Root Filesystem Status:"
df -h / | awk '{ print $1, $2, $3, $4, $5, $6 }'
