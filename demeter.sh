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
touch uuid.txt
touch uuid2.txt
touch endUuid.txt
ls -l /dev/disk/by-uuid/ > uuid.txt
grep $diskName uuid.txt > uuid2.txt
cat uuid2.txt | awk '{print $9}' > endUuid.txt
cat endUuid.txt

echo $directoryName
echo endUuid > check.txt
#echo -n "UUID=" > deneme4.txt | cat endUuid.txt |  | tee -a deneme4.txt 
echo -n "UUID=" > check.txt | cat endUuid.txt | tee -a check.txt 
echo -n ""  /mnt/$directoryName auto rw,user,auto 0 0 >> check.txt | tee -a check.txt
awk 1 ORS='' check.txt > check.csv
cat check.csv > check.txt

cat check.txt | tee -a /etc/fstab 
