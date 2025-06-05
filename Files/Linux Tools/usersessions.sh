#!/bin/bash

echo "====== CURRENTLY LOGGED IN USERS ======"
who
echo

echo "====== LAST LOGINS ======"
last -a | head -n 10
