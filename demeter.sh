#!/bin/bash

echo "Please enter your Password. "
echo "Please continue typing your password." 
echo "Since the password is hidden, the password you type will not be visible."
echo "========================================================================"

echo "Specify the disk you want to add. (sda sdb sdc etc.)"
read diskName
sudo fdisk -l /dev/$diskName

if [ $? == 0 ]
then
echo "======================================================"
  echo "============================OK================================="
else
  echo "ERROR. THE DISK NOT FOUND"
  exit
fi

(echo p; echo n; echo p; echo 1; echo 2048; echo; echo;p ) | fdisk /dev/$diskName

(sleep 5; echo;yes ) | mkfs -t ext4 /dev/$diskName

fsck /dev/$diskName -f -y

echo "Make a new Directory. Please directory name"
read directoryName
sleep 5;
mkdir -p /mnt/$directoryName
mount -t ext4 /dev/$diskName /mnt/$directoryName
df

