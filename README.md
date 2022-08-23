# Amon.sh
Amon.sh, Ubuntu sunucular için Ubuntu Mate ve RDP kurulum işlemlerini kolaylıkla yapılandırılmasını amaçlayan bir script kodudur. Bilindiği üzere Ubuntu Server genelde çekirdek sürümle kurulur. Buna GUI kazandırmak isteyen kullanıcılar için böyle bir kod hazırladım. Bu kod aktif olarak çalışıyor. Kodun içeriğini cat veya more yazarak listeleyebilirsiniz. Kod içerisinde açıklamalar mevcuttur. (Her ne kadar güvenlik açığının biraz payı da olsa bu tarz işlemler genelde güvenlik zaafiyetinden dolayı RDP'ye açılmaz. Ancak bu kod test için idealdir.) Bu script, Windows üzerinden derlendiği için diğer sistemlerde problem yaratacaktır. Bunun önüne geçmek için aşağıdaki komut serisini takip ediniz.

sudo apt-get install dos2unix
dos2unix <script ismi>
chmod +x <script ismi>
./<script ismi>

Not: Script içerisinde yazan kodlar aktif olarak çalışmaktadır.  Bu kodların doğuracağı sonuçlardan yalnızca kullanıcı sorumludur.  
