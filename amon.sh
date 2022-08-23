#!/bin/bash
#bash icin yol dizinidir. 

#Bu bash scripti Windows uzerinden gelistirildigi icin derleme konusunda problem yasanacaktir. Bu scriptten once "dos2unix"
#yaziliminin kurulmasi gerekmektedir. 

#sudo apt-get install dos2unix parametresi girilerek bu program kurulabilir. Daha sonra, derleme yapilacak. Adimlar asagida mevcuttur.
#dos2unix <script ismi>
#chmod +x <script ismi>
#./<script ismi>

#mate arayuz kurulumu icin gerekli adimdir. arayuz spesifik olarak secilmistir. Optimize icin uygundur.

sudo apt-get install ubuntu-mate-desktop -y 
sudo systemctl set-default graphical.target 

sudo dpkg --configure -a 
#bu komutun calistirilma amaci, diger kisma gecerken eksik olan dosyalarin konfigurasyonu icindir. 

#rdp baglantisinda kullanacagimiz xfce4 arayuzunu kuruyoruz. 
sudo apt-get install xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils -y
sudo apt install xrdp -y

#rdp baglantisinda acilacak pencerenin conf. islemi .xsession dosyasinin icine yazdiriyoruz. 
#xfce4 en optimize calistigi icin bu tercih edilmistir. Tercihler degisebilir.

echo "xfce4-session" >> ~/.xsession
#xrdp servisini restart ediyoruz. 

sudo systemctl xrdp restart

#sudo xrdp sisteminin calisabilmesi icin xrdp servisini aktif ediyoruz.
sudo systemctl enable xrdp

#restart.
sudo reboot 
