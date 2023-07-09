#!/bin/bash

# Kullanıcıya sudo yetkisi verme
password=$(zenity --password --title "Sudo Hesabı" --text "Sudo parolasını girin:")

echo "$password" | sudo -S echo "Sudo yetkisi doğrulandı."

# Disk listesinin alınması
disks=($(lsblk -o NAME,SIZE -n -l | awk '{print $1}'))
sizes=($(lsblk -o NAME,SIZE -n -l | awk '{print $2}'))

# Disk seçimi için dizi oluşturma
options=()
for ((i=0; i<${#disks[@]}; i++)); do
    options+=("${disks[$i]}" "${sizes[$i]}")
done

# Disk seçimi için dialog penceresi
selected_disk=$(zenity --list --title "Disk Seçimi" --text "Hangi diski seçmek istiyorsunuz?" --column "Diskler" --column "Boyutlar" "${options[@]}" --height 300)

# Seçilen diskin varlığının kontrolü
sudo fdisk -l "/dev/$selected_disk"

if [ $? == 0 ]; then
    zenity --info --title "Disk Kontrolü" --text "Seçilen disk: /dev/$selected_disk\n\nDisk kontrolü başarılı."
else
    zenity --error --title "Disk Kontrolü" --text "HATA: Disk bulunamadı."
    exit 1
fi

# Disk bölümlendirme
(echo p; echo n; echo p; echo 1; echo 2048; echo; echo;p ) | sudo fdisk "/dev/$selected_disk"

# Dosya sistemi oluşturma ve kontrol
(sleep 5; echo;yes ) | sudo mkfs -t ext4 "/dev/$selected_disk"
sudo fsck "/dev/$selected_disk" -f -y

# Yeni bir dizin oluşturma
directoryName=$(zenity --entry --title "Yeni Dizin" --text "Yeni bir dizin adı girin:")

if [ -z "$directoryName" ]; then
    zenity --error --title "Hata" --text "Dizin adı boş olamaz."
    exit 1
fi

sudo mkdir -p "/mnt/$directoryName"
sudo mount -t ext4 "/dev/$selected_disk" "/mnt/$directoryName"

# UUID alınması ve fstab dosyasına eklenmesi
uuid=$(sudo blkid -s UUID -o value "/dev/$selected_disk")
echo "UUID=$uuid /mnt/$directoryName auto rw,user,auto 0 0" | sudo tee -a /etc/fstab

zenity --info --title "Disk Setup Tamamlandı" --text "Disk setup işlemi başarıyla tamamlandı."