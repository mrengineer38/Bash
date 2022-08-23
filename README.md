# Amon.sh
Amon.sh, Ubuntu sunucular için Ubuntu Mate ve RDP kurulum işlemlerini kolaylıkla yapılandırılmasını amaçlayan bir script kodudur. Bilindiği üzere Ubuntu Server genelde çekirdek sürümle kurulur. Buna GUI kazandırmak isteyen(Her ne kadar güvenlik açığının biraz payı da olsa bu tarz işlemler genelde güvenlik zaafiyetinden dolayı RDP'ye açılmamaktadır.) Bu script, Windows üzerinden derlendiği için diğer sistemlerde problem yaratacaktır. Bunun önüne geçmek için aşağıdaki komut serisini takip ediniz.

sudo apt-get install dos2unix
dos2unix <script ismi>
chmod +x <script ismi>
./<script ismi>

Not: Script içerisinde yazan kodlar aktif olarak çalışmaktadır.  Bu kodların doğuracağı sonuçlardan yalnızca kullanıcı sorumludur.  
