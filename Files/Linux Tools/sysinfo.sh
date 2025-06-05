#!/bin/bash

echo "====== SYSTEM INFORMATION ======"
hostnamectl
echo

echo "====== NETWORK CONFIGURATION ======"
ip a
echo

echo "====== DEFAULT GATEWAY ======"
ip route | grep default
echo

echo "====== DNS Servers ======"
cat /etc/resolv.conf
