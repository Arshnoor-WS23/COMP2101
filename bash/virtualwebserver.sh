#!/bin/bash

echo " "

echo "Checking if lxd is installed"
if [ -e "/var/snap/lxd" ];
then
	echo "lxd is present"
	echo " "
else
	echo "Installing lxd"
	sudo snap install lxd
	echo " "
fi

echo "Checking if lxdbr0 interface exist"
if ip l | grep lxdbr0 >/dev/null;
then
	echo "lxdbr0 interface is present"
	echo " "
else
	echo "Initializing lxd"
	lxd init --auto
	echo " "
fi

echo "Checking if lxd container is running"
if lxc list | grep COMP2101-S22 >/dev/null;
then
	echo "lxd container COMP2101-S22 present"
	echo " "
else
	echo "Launching lxd container"
	lxc launch ubuntu:22.04 COMP2101-S22
	echo " "
fi

echo "Checking if hosts file already has an entry"
if grep -q COMP2101-S22 /etc/hosts >/dev/null;
then
	echo "COMP2101-S22 host entry present"
	echo " "
else
	echo "Adding COMP2101-S22 entry in hosts file"
	IP=$(lxc list | grep COMP2101-S22 | egrep -o "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+")
	echo "$IP COMP2101-S22" | sudo tee -a /etc/hosts
	echo " "
fi

echo "Checking if apache2 is installed in container"
if lxc exec COMP2101-S22 service apache2 status >/dev/null;
then
	echo "apache2 present"
	echo " "
else
	echo "Installing apache2 in COMP2101-S22"
	lxc exec COMP2101-S22 -- apt install apache2
	echo " "
fi

echo "Checking if able to retrieve default webpage"
if curl -s COMP2101-S22 >/dev/null;
then
	echo "Successfully retrieved the default web page"
else
	echo "Error not able to fetch the default webpage"
fi

echo " "
