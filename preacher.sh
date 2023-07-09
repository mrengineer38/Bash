#!/bin/bash

# Kullanıcı adını belirleyin
USERNAME="test1"

# Parola değişim periyodu (30 dakika)
CHANGE_PERIOD=1800

# Şu anki tarihi al
CURRENT_DATE=$(date +%s)

# Kullanıcının son parola değiştirme tarihini ve son değişiklik tarihini kontrol etmek için bir dosya
PASSWORD_CHANGE_FILE="/home/$USERNAME/password_change_date.txt"

# Kullanıcının parolasını değiştirme işlemini kontrol et
if [ -f "$PASSWORD_CHANGE_FILE" ]; then
   LAST_CHANGE_DATE=$(cat "$PASSWORD_CHANGE_FILE" | awk 'NR==1')
   LAST_CHANGE_TIME=$(cat "$PASSWORD_CHANGE_FILE" | awk 'NR==2')
else
   # Dosya yoksa veya zamanı sıfırlamak istediğinizde, varsayılan bir tarih atayın (scripti ilk kez çalıştırdığınızda kullanılır)
   LAST_CHANGE_DATE=0
   LAST_CHANGE_TIME=0
fi

# Parola değiştirme süresini kontrol et
if [ $((CURRENT_DATE - LAST_CHANGE_DATE)) -ge $CHANGE_PERIOD ]; then
   # Parola değiştirme tarihini ve saatini güncelle
   echo -e "$CURRENT_DATE\n$(date +"%Y-%m-%d %H:%M:%S")" > "$PASSWORD_CHANGE_FILE"

   # 9 harfli bir rastgele parola oluştur
   NEW_PASSWORD=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w9 | head -n1)

   # Parolayı değiştir
   echo -e "$NEW_PASSWORD\n$NEW_PASSWORD" | passwd $USERNAME

   # Zenity arayüzünde yeni parolayı ve değişiklik tarihini göster
   zenity --info --title "Parola Degisti" --text "$(echo -e "Yeni parolaniz: $NEW_PASSWORD\nSon degisiklik tarihi: $(date +"%Y-%m-%d %H:%M:%S")")"
else
   # Zamanı sıfırlamak için mevcut tarih ve saati sıfırla
   echo -e "0\n0" > "$PASSWORD_CHANGE_FILE"
   echo "Parola degisim zamanini sifirladiniz."
fi
