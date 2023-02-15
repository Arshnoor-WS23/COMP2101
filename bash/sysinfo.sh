#!/bin/bash

#This script displays important identity information about the computer 
#in a concise and human-friendly manner.

#Get the hostname and fully qualified domain name
HOSTNAME=$(hostname)
FQDN=$(hostname -f)

#Get the operating system name and version
OS=$(cat /etc/*-release | grep -m1 PRETTY_NAME | cut -d= -f2 | sed 's/"//g')

#Get the default IP address used for sending and receiving data
IP=$(ip route get 8.8.8.8 | awk 'NR==1 {print $7}')

#Get the amount of free disk space on the root filesystem in a human-friendly format
ROOT_FREE=$(df -h / | awk 'NR==2 {print $4}')

#Use an output template to display the information in a labeled and easy-to-read format
OUTPUT_TEMPLATE="Report for $HOSTNAME\n===============\nFQDN: $FQDN\nOperating System name and version: $OS\nIP Address: $IP\nRoot Filesystem Free Space: $ROOT_FREE\n===============\n"
echo -e "\n$OUTPUT_TEMPLATE" # The -e option enables interpretation of backslash escapes

#The script ends here.
