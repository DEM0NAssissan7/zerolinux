#!/bin/bash

clear
echo Welcome to the Zero Linux install script!
echo
echo -FYI- -This is not made for newbies-
echo
read -p "Press enter to continue..."
timedatectl set-ntp true
rm -r /tmp/zerolinux
cp -r ../zerolinux /tmp

#Chmodding the scripts
chmod +x /tmp/zerolinux/shells/*
chmod +x begin.sh
chmod +x end.sh
chmod +x /tmp/zerolinux/begin.sh
chmod +x /tmp/zerolinux/end.sh

#Executing the scripts

bash /tmp/zerolinux/begin.sh
bash /tmp/zerolinux/end.sh
