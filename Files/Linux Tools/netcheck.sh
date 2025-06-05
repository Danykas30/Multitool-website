#!/bin/bash

echo "====== PING TEST ======"
ping -c 4 8.8.8.8

echo
echo "====== DNS RESOLUTION TEST ======"
ping -c 2 google.com

echo
echo "====== TRACEROUTE TO GOOGLE ======"
traceroute google.com
