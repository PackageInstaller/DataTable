__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TipsType = readonly({
  TipsType_100001_Desc = {
    Text = "Çözünürlüğü değiştirmek için istemcinin yeniden başlatılması gerekir. Devam edilsin mi?"
  },
  TipsType_100001_LeftBtnDesc = {Text = "İptal"},
  TipsType_100001_RightBtnDesc = {Text = "Onayla"},
  TipsType_100001_Title = {
    Text = "Çözünürlük Değişimini Onayla"
  },
  TipsType_100002_Desc = {
    Text = "{s1} davetini kabul etmesi için Bekleyiş..."
  },
  TipsType_100002_RightBtnDesc = {Text = "İptal"},
  TipsType_100002_Title = {
    Text = "Bir El Daha"
  },
  TipsType_100003_Desc = {
    Text = "{s1} seni bir el daha oynamaya davet ediyor."
  },
  TipsType_100003_LeftBtnDesc = {Text = "Reddet"},
  TipsType_100003_RightBtnDesc = {Text = "Kabul Et"},
  TipsType_100003_Title = {
    Text = "Bir El Daha"
  },
  TipsType_100004_Desc = {
    Text = "Zaten mevcut yurt arka planı olarak ayarlanmış."
  },
  TipsType_100005_Desc = {
    Text = "Traphase Henüz Alınabilir Değil"
  },
  TipsType_100006_Desc = {
    Text = "Diğer oyuncu Traphase modunun kilidini açmamış."
  },
  TipsType_100007_Desc = {
    Text = "Dostluk Maçı başlatmak için birbirinizi takip etmelisiniz."
  },
  TipsType_100008_Desc = {
    Text = "Diğer taraf çevrimdışı."
  },
  TipsType_100009_Desc = {
    Text = "Diğer oyuncu şu anda bir soruşturmada."
  },
  TipsType_100010_Desc = {
    Text = "Dostluk Maçı isteğinin süresi doldu."
  },
  TipsType_100011_Desc = {
    Text = "Dostluk Maçını iptal ettin."
  },
  TipsType_100012_Desc = {
    Text = "Dostluk Maçı daveti reddedildi."
  },
  TipsType_100012_LeftBtnDesc = {Text = "Onayla"},
  TipsType_100012_Title = {
    Text = "Soruşturma Devam Ediyor"
  },
  TipsType_100013_Desc = {
    Text = "Diğer taraf çevrimdışı."
  },
  TipsType_100014_Desc = {
    Text = "Diğer oyuncu başka bir oyun moduna girdi."
  },
  TipsType_100015_Desc = {
    Text = "Davetler çok sık gönderildi. {s1} sn sonra tekrar dene."
  },
  TipsType_100016_Desc = {
    Text = "Diğer oyuncu Dostluk Maçını iptal etti."
  },
  TipsType_100016_LeftBtnDesc = {Text = "Onayla"},
  TipsType_100016_Title = {
    Text = "Soruşturma Devam Ediyor"
  },
  TipsType_100017_Desc = {
    Text = "Bu oyuncu şu anda bir Dostluk Maçında."
  },
  TipsType_100017_LeftBtnDesc = {Text = "Onayla"},
  TipsType_100017_Title = {
    Text = "Soruşturma Devam Ediyor"
  },
  TipsType_100018_Desc = {
    Text = "Bu ekipte süreyle sınırlı kartlar var. Devam etmek için bu Sezonun Temel Konularını açman gerekiyor. Seninle yeniden omuz omuza savaşmayı dört gözle bekliyorum!\nŞimdi Temel Konuları açmak ister misin?"
  },
  TipsType_100018_LeftBtnDesc = {Text = "İptal"},
  TipsType_100018_RightBtnDesc = {Text = "Onayla"},
  TipsType_100018_Title = {
    Text = "Üst Düzey Konuların süresi doldu"
  },
  TipsType_10001_Desc = {
    Text = "Başarılı"
  },
  TipsType_100020_Desc = {
    Text = "Devam eden soruşturmaya devam etmek istiyor musunuz?"
  },
  TipsType_100020_LeftBtnDesc = {Text = "İptal"},
  TipsType_100020_RightBtnDesc = {Text = "Onayla"},
  TipsType_100020_Title = {
    Text = "Soruşturma Devam Ediyor"
  },
  TipsType_10002_Desc = {
    Text = "Yapılandırma verisi hatası"
  },
  TipsType_10003_Desc = {
    Text = "İstemci veri girişi hatası"
  },
  TipsType_10004_Desc = {
    Text = "Sunucu Başlatılmadı"
  },
  TipsType_10005_Desc = {
    Text = "Karakter verisi hatası"
  },
  TipsType_10006_Desc = {
    Text = "Uyanışçı verisi bulunamadı"
  },
  TipsType_10007_Desc = {
    Text = "Uyanan en yüksek seviyeye ulaştı."
  },
  TipsType_10008_Desc = {
    Text = "Yeterli Konu Puanı Yok"
  },
  TipsType_10009_Desc = {
    Text = "Uyanışçı azami seviyeye ulaşmadı ve Aydınlanma gerçekleştirilemez."
  },
  TipsType_100100_Desc = {
    Text = "Yeni bir sürüm mevcut. Güncelleme otomatik olarak başlamazsa, lütfen güncellemeleri kontrol etmek için Steam'i yeniden başlatmayı deneyin."
  },
  TipsType_100100_RightBtnDesc = {Text = "Onayla"},
  TipsType_100100_Title = {
    Text = "Güncelleme İpucu"
  },
  TipsType_10010_Desc = {
    Text = "Aydınlanma Tamamlandı"
  },
  TipsType_10011_Desc = {
    Text = "Henüz hiçbir karakter yaratılmadı."
  },
  TipsType_10012_Desc = {
    Text = "Mevcut Karakterler"
  },
  TipsType_10013_Desc = {
    Text = "Yinelenen Karakter Adı"
  },
  TipsType_10014_Desc = {
    Text = "Gizli Diyar Alan Hatası"
  },
  TipsType_10015_Desc = {
    Text = "Gizli Diyar alanı bulunamıyor."
  },
  TipsType_10016_Desc = {
    Text = "Mevcut HP çok düşük."
  },
  TipsType_10017_Desc = {
    Text = "{s1} ile {s2} arasında kilit açılır"
  },
  TipsType_10018_Desc = {
    Text = "Bu Gizli Diyar’ın ikinci katına 1 kez ulaştıktan sonra Hızlı Soruşturma yapabilirsin."
  },
  TipsType_10019_Desc = {
    Text = "Etkinlik Tamamlandı"
  },
  TipsType_10020_Desc = {
    Text = "Etkinlik yapılandırma tablosunda hatalı tür girişi."
  },
  TipsType_10021_Desc = {
    Text = "Etkinlik Mevcut Değil"
  },
  TipsType_10022_Desc = {
    Text = "Satın alma için yeterli Kara Mühür yok."
  },
  TipsType_10023_Desc = {
    Text = "Bu kart güçlendirilemez."
  },
  TipsType_10024_Desc = {
    Text = "Bu kart en yüksek güçlendirme sınırına ulaştı."
  },
  TipsType_10025_Desc = {
    Text = "Tüccar bu eşyayı satmıyor."
  },
  TipsType_10026_Desc = {
    Text = "Böyle bir Ödül Yok"
  },
  TipsType_10027_Desc = {
    Text = "Ödül Alındı"
  },
  TipsType_10028_Desc = {
    Text = "Etkinlik verisi hatası"
  },
  TipsType_10029_Desc = {
    Text = "Zaten satın alındı"
  },
  TipsType_10030_Desc = {
    Text = "Geçerli enerji Kapı’yı etkinleştirmek için yetersiz. Kapı’yı etkinleştirmek için {s1} enerji gerekir."
  },
  TipsType_10031_Desc = {
    Text = "Hiçbir Hikâye Diyaloğu Etkinliği Bulunamadı"
  },
  TipsType_10032_Desc = {
    Text = "Etkinlik için yeterli Komut Kartı seçilmedi."
  },
  TipsType_10033_Desc = {
    Text = "Etkinlik için çok fazla Komut Kartı seçildi."
  },
  TipsType_10034_Desc = {
    Text = "Etkinlik seçimi Komut Kartı mevcut değil."
  },
  TipsType_10035_Desc = {
    Text = "Rastgele etkinlik havuzunda veri yok."
  },
  TipsType_10036_Desc = {
    Text = "Tüccar bu eşyayı satmıyor."
  },
  TipsType_10037_Desc = {
    Text = "Etkinlik için seçilen Kalıntılar yetersiz"
  },
  TipsType_10038_Desc = {
    Text = "Etkinlik için çok fazla Kalıntı seçildi."
  },
  TipsType_10039_Desc = {
    Text = "Etkinlik için seçilen Kalıntı mevcut değil"
  },
  TipsType_10040_Desc = {
    Text = "Etkinlik Düğümü Bulunamadı"
  },
  TipsType_10041_Desc = {
    Text = "Tüccar Yenileme sayısı Tüketme edildi."
  },
  TipsType_10042_Desc = {
    Text = "Savaş ganimeti Komut Kartı Yenileme sayısı Tüketme durumuna ulaştı."
  },
  TipsType_10043_Desc = {
    Text = "Savaş ganimeti Kalıntı Yenileme deneme sayıları Tüketme durumuna ulaştı."
  },
  TipsType_10044_Desc = {
    Text = "Kavşak işlevi kilitli"
  },
  TipsType_10045_Desc = {
    Text = "Etkinlik bölgesi uyuşmazlığı! Geçerli bölge: {s1}, etkinlikte yapılandırılan bölge: {s2}."
  },
  TipsType_10046_Desc = {
    Text = "Etkinlik mağazasında kart kaldırma girişimleri Tüketme edildi"
  },
  TipsType_10047_Desc = {
    Text = "Konu Birim Verisi Bulunamadı"
  },
  TipsType_10048_Desc = {
    Text = "Birim gönderildi. Yeniden göndermeye gerek yok."
  },
  TipsType_10049_Desc = {
    Text = "Birim altındaki tüm görevler henüz tamamlanmadı. Gönderim yapılamıyor."
  },
  TipsType_10050_Desc = {
    Text = "Rota Modülü Bulunamadı"
  },
  TipsType_10051_Desc = {
    Text = "Aşamanın hiçbir Meydan Okuma verisi yok."
  },
  TipsType_10052_Desc = {
    Text = "Bu Gizli Diyar için alınabilir rota yok."
  },
  TipsType_10053_Desc = {
    Text = "Kredi yetersiz, ödüller talep edilemiyor."
  },
  TipsType_10054_Desc = {
    Text = "Kredi ödülü koşulları henüz karşılanmadı."
  },
  TipsType_10055_Desc = {
    Text = "Konu bölümünde görev bulunamadı."
  },
  TipsType_10056_Desc = {
    Text = "Alt Görev Tamamlandı"
  },
  TipsType_10057_Desc = {
    Text = "Proje alt görevleri içindeki alt görevler tamamlanmadı."
  },
  TipsType_10058_Desc = {
    Text = "NPC Tetiklendi"
  },
  TipsType_10059_Desc = {
    Text = "NPC veri hatası"
  },
  TipsType_10060_Desc = {
    Text = "NPC mevcut değil"
  },
  TipsType_10061_Desc = {
    Text = "Gizli Diyar’da Keşif yapılmadı"
  },
  TipsType_10062_Desc = {
    Text = "Rezonans verisi bulunamadı"
  },
  TipsType_10063_Desc = {
    Text = "Rezonans en yüksek seviyeye ulaştı."
  },
  TipsType_10064_Desc = {
    Text = "Rezonans Seviyesi ile ilgili veri bulunamadı."
  },
  TipsType_10065_Desc = {
    Text = "Sıfırlama denemesi kalmadı"
  },
  TipsType_10066_Desc = {
    Text = "Rezonans etkinleştirme koşulları karşılanmadı."
  },
  TipsType_10067_Desc = {
    Text = "Yetersiz Rezonans Parçacığı"
  },
  TipsType_10068_Desc = {
    Text = "Aydınlanma tamamlandı, tekrar Aydınlanma yapılamaz."
  },
  TipsType_10069_Desc = {
    Text = "Aydınlanma için gereken malzemeler yetersiz."
  },
  TipsType_10070_Desc = {
    Text = "Uyandırıcıyı Yükseltme için malzeme yetersiz."
  },
  TipsType_10071_Desc = {
    Text = "Uyandırıcıyı Yükseltme için Rose Scrip yetersiz."
  },
  TipsType_10072_Desc = {
    Text = "Uyandırıcıyı Yükseltme için Rose Scrip yetersiz."
  },
  TipsType_10073_Desc = {
    Text = "Uyandırıcı Becerisi yok"
  },
  TipsType_10074_Desc = {
    Text = "Uyandırıcı Becerileri henüz kilitlenmemiş"
  },
  TipsType_10075_Desc = {
    Text = "Uyanış için gereken \"Gümüş\" yetersiz."
  },
  TipsType_10076_Desc = {
    Text = "Eşya yetersiz"
  },
  TipsType_10077_Desc = {
    Text = "Günlük satın alma sınırına ulaştınız"
  },
  TipsType_10078_Desc = {
    Text = "Eşya kullanılamaz"
  },
  TipsType_10079_Desc = {
    Text = "Eşya kullanım miktarı hatalı"
  },
  TipsType_10080_Desc = {
    Text = "Beceri en yüksek seviyeye ulaştı"
  },
  TipsType_10081_Desc = {
    Text = "Yükseltme için Malzeme yetersiz"
  },
  TipsType_10082_Desc = {
    Text = "Yükseltme için Para birimi yetersiz"
  },
  TipsType_10083_Desc = {
    Text = "Uyandırıcı bağ oranı en yüksek Seviyeye ulaştı."
  },
  TipsType_10084_Desc = {
    Text = "Bu Uyandırıcının Köken Ruhu yetersiz."
  },
  TipsType_10085_Desc = {
    Text = "Yükseltme Yolunda yapılandırılmış bir karakter kimliği yok"
  },
  TipsType_10086_Desc = {
    Text = "Belirtilen özel Kart bilgisi bulunamıyor"
  },
  TipsType_10087_Desc = {
    Text = "Belirlenen özel kart kilidi açılmamış"
  },
  TipsType_10088_Desc = {
    Text = "Bu özel kart için UUID bulunamıyor"
  },
  TipsType_10089_Desc = {
    Text = "Bölüm ödülleri gereken puana ulaşmadı"
  },
  TipsType_10090_Desc = {
    Text = "Bölüm ödülleri alındı"
  },
  TipsType_10091_Desc = {
    Text = "Seçilen hikâye hattının kilidi henüz açılmadı"
  },
  TipsType_10092_Desc = {
    Text = "Seçilen senaryo henüz açılmadı"
  },
  TipsType_10093_Desc = {
    Text = "Senaryo bölgesi henüz açılmadı"
  },
  TipsType_10094_Desc = {
    Text = "Hikâye süpürme henüz açılmadı"
  },
  TipsType_10095_Desc = {
    Text = "Bu senaryo meydan okuması için hikâye bulunamadı"
  },
  TipsType_10096_Desc = {
    Text = "Senaryo meydan okumaları için hikâye görevleri bulunamadı"
  },
  TipsType_10097_Desc = {
    Text = "Meydan okuma Tamamlandı. Ödüller tekrar alınamaz."
  },
  TipsType_10098_Desc = {
    Text = "Meydan okuma tamamlanmadı. Ödüller alınamaz."
  },
  TipsType_10099_Desc = {
    Text = "Bina mevcut değil"
  },
  TipsType_10100_Desc = {
    Text = "Bina en yüksek seviyeye ulaştı"
  },
  TipsType_10101_Desc = {
    Text = "Binaları Yükseltme/kurma koşulları yetersiz"
  },
  TipsType_10102_Desc = {
    Text = "Bina zaten mevcut, tekrar inşa edilemez"
  },
  TipsType_10103_Desc = {
    Text = "Yükseltme/inşa için yeterli eşya yok"
  },
  TipsType_10104_Desc = {
    Text = "Konum zaten bir Uyandıran tarafından işgal edilmiş, girilemez"
  },
  TipsType_10105_Desc = {
    Text = "Gerekli eşyayı üretmek için malzeme yetersiz"
  },
  TipsType_10106_Desc = {
    Text = "Eşyayı üretmek için para birimi yetersiz"
  },
  TipsType_10107_Desc = {
    Text = "Sentez eşyasının kilidi açılmamış"
  },
  TipsType_10108_Desc = {
    Text = "Sunucuya bağlanılamadı. Lütfen ağını kontrol edip yeniden dene."
  },
  TipsType_10109_Desc = {
    Text = "Kamp zaten bir işlev seçti, başka bir seçim yapılamaz"
  },
  TipsType_10110_Desc = {
    Text = "Kamp işlevinin kalan kullanımı yok"
  },
  TipsType_10111_Desc = {
    Text = "Geçiş yapmak için özel kartı yükselt"
  },
  TipsType_10112_Desc = {
    Text = "Geçiş yapmak için özel kartı değiştir"
  },
  TipsType_10113_Desc = {
    Text = "Özel kart değiştirilemedi"
  },
  TipsType_10114_Desc = {
    Text = "Uyandırıcı elde edildi {s1}"
  },
  TipsType_10115_Desc = {
    Text = "{s1} tekrar elde edildi, {s2}{s3}’e dönüştürüldü."
  },
  TipsType_10116_Desc = {
    Text = "{s1} hatıra sınırı aşıldı ve {s2}{s3}’e dönüştürüldü."
  },
  TipsType_10117_Desc = {
    Text = "Günlük Başarıyla Yüklendi"
  },
  TipsType_10118_Desc = {
    Text = "Talimat uyuşmazlığı; şu anda {s1} talimatı için Nöbet içindesin, ancak {s2} alındı."
  },
  TipsType_10119_Desc = {
    Text = "Kayıp Kart:{s1}; uid:{s2}"
  },
  TipsType_10120_Desc = {
    Text = "Serbest Bırakma yapılamıyor"
  },
  TipsType_10121_Desc = {
    Text = "Böyle bir Beceri yok"
  },
  TipsType_10122_Desc = {
    Text = "Beceri Bekleme Süresinde"
  },
  TipsType_10123_Desc = {
    Text = "Beceri Kullanımları Tükendi"
  },
  TipsType_10124_Desc = {
    Text = "Bina Tid {s1} için bina yükseltme sırasının döngüsel olup olmadığını kontrol et."
  },
  TipsType_10125_Desc = {
    Text = "Bina Tid {s1} için ilişkili bir yapılandırma olup olmadığını kontrol et."
  },
  TipsType_10126_Desc = {
    Text = "Bina Tid {s1} gerçek Seviyesi {s2} olmalı, ancak {s3} olarak yapılandırılmış."
  },
  TipsType_10127_Desc = {
    Text = "Bina Türü Yapılandırması Bulunamadı"
  },
  TipsType_10128_Desc = {
    Text = "Bina yapılandırması bulunamadı ya da hiçbir bina türü belirtilmemiş."
  },
  TipsType_10129_Desc = {
    Text = "Bu Hikâye görev görevi henüz Kilitli."
  },
  TipsType_10130_Desc = {
    Text = "Başarıyla Kaldırıldı"
  },
  TipsType_10131_Desc = {
    Text = "\"Menofin\" × {s1} başarıyla elde edildi."
  },
  TipsType_10132_Desc = {
    Text = "Düzeltme Tamamlandı"
  },
  TipsType_10133_Desc = {
    Text = "GM, eşya adı [\"..arg1..\"] ile eşya ekledi; eşleşen hiçbir Eşya bulunamadı."
  },
  TipsType_10134_Desc = {
    Text = "Etkinlik [\"..arg1..\"] mevcut değil."
  },
  TipsType_10135_Desc = {
    Text = "Şu An: {s1} tuşuna bas"
  },
  TipsType_10136_Desc = {
    Text = "Yetenek Yükseltildi"
  },
  TipsType_10137_Desc = {
    Text = "Başarıyla Oluşturuldu"
  },
  TipsType_10138_Desc = {
    Text = "Sunucu zamanı başarıyla güncellendi."
  },
  TipsType_10139_Desc = {
    Text = "Sunucu Zamanı Değiştirilemedi"
  },
  TipsType_10140_Desc = {
    Text = "Toplam Bina: 17\nBu geçici sürümde yalnızca bazı binalar alınabilir."
  },
  TipsType_10141_Desc = {
    Text = "Bina açma koşulları karşılanmadı."
  },
  TipsType_10142_Desc = {
    Text = "Bina: {s1} yapılandırması için arayüz mevcut değil {s2}."
  },
  TipsType_10143_Desc = {
    Text = "Bu üretim tarifi şu anda kilitli."
  },
  TipsType_10144_Desc = {
    Text = "Yetersiz malzeme"
  },
  TipsType_10145_Desc = {
    Text = "Üretim Başarılı"
  },
  TipsType_10146_Desc = {
    Text = "Yükseltildi"
  },
  TipsType_10147_Desc = {
    Text = "Canavar yuvası boş, savaşa girilemez."
  },
  TipsType_10148_Desc = {
    Text = "Menofin\" Geri Kazanımı"
  },
  TipsType_10149_Desc = {
    Text = "Girilen karakter kimliği yinelenmiş; Savaş’a giremez."
  },
  TipsType_10150_Desc = {
    Text = "Girdiğiniz {s1} kimliği mevcut değil ve Savaş’a giremez."
  },
  TipsType_10151_Desc = {
    Text = "Canavarın karşılık gelen bir eylemi yok."
  },
  TipsType_10152_Desc = {
    Text = "Henüz alınabilir değil"
  },
  TipsType_10153_Desc = {
    Text = "Mevcut destede hiç kart yok."
  },
  TipsType_10154_Desc = {
    Text = "Diğer Kartlar etkide, Kart Oynanamaz."
  },
  TipsType_10155_Desc = {
    Text = "Elde değil, oynanamaz."
  },
  TipsType_10156_Desc = {
    Text = "Bu kart oynanamaz."
  },
  TipsType_10157_Desc = {
    Text = "Bu kart için hiçbir beceri yapılandırılmamış."
  },
  TipsType_10158_Desc = {
    Text = "Bu kart oynanamaz."
  },
  TipsType_10159_Desc = {
    Text = "Yetersiz Arithmetica"
  },
  TipsType_10160_Desc = {
    Text = "Sahada karşılık gelen bir Uyandıran yok."
  },
  TipsType_10161_Desc = {
    Text = "Kalan deneme sayısı yetersiz"
  },
  TipsType_10162_Desc = {
    Text = "Bir Keşif Becerisi Kullan"
  },
  TipsType_10163_Desc = {
    Text = "Seçilen %d Komut Kartı"
  },
  TipsType_10164_Desc = {
    Text = "Miktar Sınırına Ulaşıldı"
  },
  TipsType_10165_Desc = {
    Text = "Henüz Seçilmedi"
  },
  TipsType_10166_Desc = {
    Text = "Bu Kart, Arithmetica harcanarak oynanamaz."
  },
  TipsType_10167_Desc = {
    Text = "Toplam Tüketim Aşıldı"
  },
  TipsType_10168_Desc = {
    Text = "Seçilen {s1} Kart"
  },
  TipsType_10169_Desc = {
    Text = "Dokunaç Sayısı en yüksek sınıra ulaştı."
  },
  TipsType_10170_Desc = {
    Text = "Başarıyla Kaldırıldı"
  },
  TipsType_10171_Desc = {
    Text = "Geliştirilmiş"
  },
  TipsType_10172_Desc = {
    Text = "Dönüşüm Başarılı"
  },
  TipsType_10173_Desc = {
    Text = "Kopyalandı"
  },
  TipsType_10174_Desc = {
    Text = "Komut Kartı Elde Edildi"
  },
  TipsType_10175_Desc = {
    Text = "Kaldırma sayısı Tüketme sınırına ulaştı."
  },
  TipsType_10176_Desc = {
    Text = "Geliştirme sayısı Tüketme sınırına ulaştı."
  },
  TipsType_10177_Desc = {
    Text = "Dönüşüm sayısı Tüketme sınırına ulaştı."
  },
  TipsType_10178_Desc = {
    Text = "Kopyalama sayısı Tüketme sınırına ulaştı."
  },
  TipsType_10179_Desc = {
    Text = "Komut Kartı Seçim Sınırına Ulaşıldı"
  },
  TipsType_10180_Desc = {
    Text = "Hiç Komut Kartı Seçilmedi"
  },
  TipsType_10181_Desc = {
    Text = "Mağaza henüz açılmadı. Beklemede kalın."
  },
  TipsType_10182_Desc = {
    Text = "Takipte kalın"
  },
  TipsType_10183_Desc = {
    Text = "Hedef bölge çok uzak, tespit edilemiyor."
  },
  TipsType_10184_Desc = {
    Text = "Hedefin bölgesi ıskalandı, tamamlanamıyor."
  },
  TipsType_10185_Desc = {
    Text = "Bu konu henüz kilitli."
  },
  TipsType_10186_Desc = {
    Text = "Daha fazla soruşturmanın kilidini açmak için Gizli Diyarları keşfet."
  },
  TipsType_10187_Desc = {
    Text = "Daha fazla Soruşturma kilidini açmak için önkoşul Görevleri tamamlayın."
  },
  TipsType_10188_Desc = {
    Text = "Gönderim başarılı, araştırma puanı +{s1}."
  },
  TipsType_10189_Desc = {
    Text = "Teslim edilecek Görev yok"
  },
  TipsType_10190_Desc = {
    Text = "Henüz alınabilir değil. Lütfen zindan açılış programını kontrol edin."
  },
  TipsType_10191_Desc = {
    Text = "Aşama Kilidi Açma Koşulları Henüz Karşılanmadı"
  },
  TipsType_10192_Desc = {
    Text = "{s1} boş olamaz"
  },
  TipsType_10193_Desc = {
    Text = "{s1} ve {s2} boş olamaz."
  },
  TipsType_10194_Desc = {
    Text = "Yenileme sayısı Tüketme sınırına ulaştı; Yenileme yapılamıyor."
  },
  TipsType_10195_Desc = {
    Text = "Edinme yöntemi henüz Kilitli."
  },
  TipsType_10196_Desc = {
    Text = "Alınabilir zaman aralığında değil."
  },
  TipsType_10197_Desc = {
    Text = "Dönüştürülecek bir Kalıntı seç"
  },
  TipsType_10198_Desc = {
    Text = "Başarıyla Kaldırıldı"
  },
  TipsType_10199_Desc = {
    Text = "Kaldırma sayısı Tüketme sınırına ulaştı."
  },
  TipsType_10200_Desc = {
    Text = "Dönüşüm sayısı Tüketme sınırına ulaştı."
  },
  TipsType_10201_Desc = {
    Text = "Kaldırılacak bir Kalıntı seç"
  },
  TipsType_10202_Desc = {
    Text = "Miktar Sınıra Ulaştı"
  },
  TipsType_10203_Desc = {
    Text = "Lütfen en az {s1} Kalıntı seç."
  },
  TipsType_10204_Desc = {
    Text = "Kalan Anahtar Yok"
  },
  TipsType_10205_Desc = {
    Text = "Tüm özel Kartlar en yüksek Seviyeye Yükseltme edildi."
  },
  TipsType_10206_Desc = {
    Text = "Mevcut itme seviyesi 0; daha fazla düşürülemez."
  },
  TipsType_10207_Desc = {
    Text = "Henüz alınabilir değil"
  },
  TipsType_10208_Desc = {
    Text = "Geliştirmek için yeterli Ruh-Bağlama Çapası yok."
  },
  TipsType_10209_Desc = {
    Text = "Aydınlanma gerçekleştirmek için {s1}’in Seviye {s2}’ye ulaşması gerekir."
  },
  TipsType_10210_Desc = {
    Text = "\"{s1}\" yetersiz"
  },
  TipsType_10211_Desc = {
    Text = "Şu anda \"{s1}\"e sahip değilsin"
  },
  TipsType_10212_Desc = {
    Text = "Maksimum Seviyeye Ulaşıldı"
  },
  TipsType_10213_Desc = {
    Text = "Lütfen önce bir Malzeme seç"
  },
  TipsType_10214_Desc = {
    Text = "\"{s1}\" yetersiz"
  },
  TipsType_10215_Desc = {
    Text = "Yükseltildi"
  },
  TipsType_10216_Desc = {
    Text = "Gnosis İksiri Eklendi"
  },
  TipsType_10217_Desc = {
    Text = "Aydınlanma Sınırına Ulaşıldı"
  },
  TipsType_10218_Desc = {
    Text = "Yükseltme Başarısız"
  },
  TipsType_10219_Desc = {
    Text = "Yükseltme için Yetersiz Eşya"
  },
  TipsType_10220_Desc = {Text = "Sv. MAKS"},
  TipsType_10221_Desc = {
    Text = "Yetenek Yükseltildi"
  },
  TipsType_10222_Desc = {
    Text = "Satın alma için yeterli Kara Mühür yok."
  },
  TipsType_10223_Desc = {Text = "Tükendi"},
  TipsType_10224_Desc = {
    Text = "Komut Kartı’nı kaldırmak için yeterli Kara Mühür yok."
  },
  TipsType_10225_Desc = {
    Text = "{s1} Komut Kartı kaldır"
  },
  TipsType_10226_Desc = {
    Text = "Bu yön henüz alınabilir değil ve Geliştirilemez."
  },
  TipsType_10227_Desc = {
    Text = "Bu yön en yüksek Seviyeye kadar Geliştirildi."
  },
  TipsType_10228_Desc = {
    Text = "Lütfen önce özel Kartınızı hangi yönde Geliştirmek istediğinizi seçin."
  },
  TipsType_10229_Desc = {
    Text = "Geliştirmek için yeterli Ruh-Bağlama Çapası yok."
  },
  TipsType_10230_Desc = {
    Text = "Bu Diyar için henüz bir Uyandırıcıya sahip değilsin ve onu seçemezsin."
  },
  TipsType_10231_Desc = {
    Text = "Bir Takım Oluştur"
  },
  TipsType_10232_Desc = {
    Text = "Takım adı {s1} karakteri geçemez."
  },
  TipsType_10233_Desc = {
    Text = "Takım adı boş olamaz"
  },
  TipsType_10234_Desc = {
    Text = "Kurtuluş Başarılı"
  },
  TipsType_10235_Desc = {
    Text = "Daha fazla \"Gümüş\" Kalmadı"
  },
  TipsType_10236_Desc = {
    Text = "Daha Fazla Azaltılamaz"
  },
  TipsType_10237_Desc = {
    Text = "{s1} henüz Alınabilir değil. Takipte kal."
  },
  TipsType_10238_Desc = {
    Text = "Çağrı henüz Alınabilir değil. Takipte kal."
  },
  TipsType_10239_Desc = {
    Text = "Kampüs mini-harita özelliği henüz Alınabilir değil."
  },
  TipsType_10240_Desc = {
    Text = "Konu Seviyesi {s1} olduğunda Kilit Açılır"
  },
  TipsType_10241_Desc = {
    Text = "Kriterlere Uyan Kart Yok"
  },
  TipsType_10242_Desc = {
    Text = "Tüm Diyar Kartları Yükseltildi."
  },
  TipsType_10243_Desc = {
    Text = "Yükseltme için Alınabilir Komut Kartı yok."
  },
  TipsType_10244_Desc = {
    Text = "Yeni bir ışınlanma noktası keşfedildi! Artık {s1} konumuna seyahat edebilirsin."
  },
  TipsType_10245_Desc = {
    Text = "Zaten sahiplenilmiş. Yeniden elde edilemez."
  },
  TipsType_10246_Desc = {
    Text = "Kurtarma Başarılı"
  },
  TipsType_10247_Desc = {
    Text = "Başarıyla Kaldırıldı"
  },
  TipsType_10248_Desc = {
    Text = "Sırt Çantası Arayüzünü Aç"
  },
  TipsType_10249_Desc = {
    Text = "Son oturumundan anormal bir bağlantı kesilmesi tespit edildi. \"Menofin\"in ve kazandığın tüm erzaklar iade edildi. Onları görmek için envanterini kontrol et."
  },
  TipsType_10250_Desc = {
    Text = "AVG sürümü yalnızca seçili binaları sunar; buradaki toplam bina sayısı 17'dir."
  },
  TipsType_10251_Desc = {
    Text = "AVG sürümü yalnızca seçili binaları sunar; buradaki toplam bina sayısı 17'dir."
  },
  TipsType_10252_Desc = {
    Text = "AVG sürümü yalnızca seçili binaları sunar; buradaki toplam bina sayısı 17'dir."
  },
  TipsType_10253_Desc = {
    Text = "AVG sürümü yalnızca seçili binaları sunar; buradaki toplam bina sayısı 17'dir."
  },
  TipsType_10254_Desc = {
    Text = "AVG sürümü yalnızca seçili binaları sunar; buradaki toplam bina sayısı 17'dir."
  },
  TipsType_10255_Desc = {
    Text = "AVG sürümü yalnızca seçili binaları sunar; buradaki toplam bina sayısı 17'dir."
  },
  TipsType_10256_Desc = {
    Text = "AVG sürümü yalnızca seçili binaları sunar; buradaki toplam bina sayısı 17'dir."
  },
  TipsType_10257_Desc = {
    Text = "AVG sürümü yalnızca seçili binaları sunar; buradaki toplam bina sayısı 17'dir."
  },
  TipsType_10258_Desc = {
    Text = "AVG sürümü yalnızca seçili binaları sunar; buradaki toplam bina sayısı 17'dir."
  },
  TipsType_10259_Desc = {
    Text = "AVG sürümü yalnızca seçili binaları sunar; buradaki toplam bina sayısı 17'dir."
  },
  TipsType_10260_Desc = {
    Text = "AVG sürümü yalnızca seçili binaları sunar; buradaki toplam bina sayısı 17'dir."
  },
  TipsType_10261_Desc = {
    Text = "AVG sürümü yalnızca seçili binaları sunar; buradaki toplam bina sayısı 17'dir."
  },
  TipsType_10262_Desc = {
    Text = "AVG sürümü yalnızca seçili binaları sunar; buradaki toplam bina sayısı 17'dir."
  },
  TipsType_10263_Desc = {
    Text = "AVG sürümü yalnızca seçili binaları sunar; buradaki toplam bina sayısı 17'dir."
  },
  TipsType_10264_Desc = {
    Text = "AVG sürümü yalnızca seçili binaları sunar; buradaki toplam bina sayısı 17'dir."
  },
  TipsType_10265_Desc = {
    Text = "AVG sürümü yalnızca seçili binaları sunar; buradaki toplam bina sayısı 17'dir."
  },
  TipsType_10266_Desc = {
    Text = "AVG sürümü yalnızca seçili binaları sunar; buradaki toplam bina sayısı 17'dir."
  },
  TipsType_10267_Desc = {
    Text = "Koşullar Karşılanmadı"
  },
  TipsType_10268_Desc = {
    Text = "Koruyucu Seviye 2'de Hızlı Soruşturma kilidini aç"
  },
  TipsType_10269_Desc = {
    Text = "Bağlantı Koptu"
  },
  TipsType_10270_Desc = {
    Text = "Sunucu bağlantısı kesildi. Kısa süre içinde giriş ekranına döneceksin."
  },
  TipsType_10271_Desc = {Text = "Onayla"},
  TipsType_10272_Desc = {
    Text = "Sunucu henüz Alınabilir değil. Lütfen daha sonra tekrar dene."
  },
  TipsType_10273_Desc = {
    Text = "Başarılı"
  },
  TipsType_10274_Desc = {
    Text = "Gizli Diyar bulunamadı"
  },
  TipsType_10275_Desc = {
    Text = "Gizli Diyar Etkinliği Tamamlandı"
  },
  TipsType_10276_Desc = {
    Text = "Gizli Diyar Etkinliği Yapılandırma Türü Hatalı"
  },
  TipsType_10277_Desc = {
    Text = "Gizli Diyar Etkinliği Mevcut Değil"
  },
  TipsType_10278_Desc = {
    Text = "Satın alma için yeterli Kara Mühür yok."
  },
  TipsType_10279_Desc = {
    Text = "Bu kart güçlendirilemez."
  },
  TipsType_10280_Desc = {
    Text = "Bu kart en yüksek güçlendirme sınırına ulaştı."
  },
  TipsType_10281_Desc = {
    Text = "Tüccar bu eşyayı satmıyor."
  },
  TipsType_10282_Desc = {
    Text = "Böyle bir Ödül Yok"
  },
  TipsType_10283_Desc = {
    Text = "Ödül Alındı"
  },
  TipsType_10284_Desc = {
    Text = "Yapılandırma verisi hatası"
  },
  TipsType_10285_Desc = {
    Text = "Etkinlik verisi hatası"
  },
  TipsType_10286_Desc = {
    Text = "Zaten satın alındı"
  },
  TipsType_10287_Desc = {
    Text = "Konu Birim Verisi Bulunamadı"
  },
  TipsType_10288_Desc = {
    Text = "Birim gönderildi. Yeniden göndermeye gerek yok."
  },
  TipsType_10289_Desc = {
    Text = "Birim altındaki tüm görevler henüz tamamlanmadı. Gönderim yapılamıyor."
  },
  TipsType_10290_Desc = {
    Text = "Konu İçin Modül Yok"
  },
  TipsType_10291_Desc = {
    Text = "Aşama Konu Verisi Boş"
  },
  TipsType_10292_Desc = {
    Text = "İstemci veri girişi hatası"
  },
  TipsType_10293_Desc = {
    Text = "Hizmet başlatılmadı"
  },
  TipsType_10294_Desc = {
    Text = "Karakter verisi hatası"
  },
  TipsType_10295_Desc = {
    Text = "Karakter bulunamadı. Lütfen bir karakter oluştur."
  },
  TipsType_10296_Desc = {
    Text = "Karakter zaten mevcut; yeniden oluşturulmasına gerek yok."
  },
  TipsType_10297_Desc = {
    Text = "Yinelenen Karakter Adı"
  },
  TipsType_10298_Desc = {
    Text = "Gizli Diyar Hatası"
  },
  TipsType_10299_Desc = {
    Text = "Bu hikâye hattının kilidi henüz açılmadı."
  },
  TipsType_10300_Desc = {
    Text = "Arazi Etkilerini ve düşman bilgilerini görüntüle."
  },
  TipsType_10301_Desc = {
    Text = "{s1}, {s3} kilidini açmak için {s2} erişimine ulaşır."
  },
  TipsType_10302_Desc = {
    Text = "{s1}, {s3} kilidini açmak için {s2} erişimine ulaşır."
  },
  TipsType_10303_Desc = {
    Text = "Bina açma koşulları karşılanmadı."
  },
  TipsType_10304_Desc = {
    Text = "Bina yükseltme gereksinimleri karşılanmadı."
  },
  TipsType_10305_Desc = {
    Text = "Binayı yükseltmek için yetersiz malzeme."
  },
  TipsType_10306_Desc = {
    Text = "Alınabilir görev ödülleri var."
  },
  TipsType_10307_Desc = {
    Text = "(HP <Negative:%10> azalacak)"
  },
  TipsType_10308_Desc = {
    Text = "Her turun sonunda, mevcut Güçlendirilmiş yığın sayısına eşit miktarda <BuffTipBlock:Karakter Kalkanı> kazanırsın. Hasar aldığında, Güçlendirilmiş her seferinde <BuffTip:1> yığın azalır."
  },
  TipsType_10309_Desc = {
    Text = "Çoklu Muhafaza"
  },
  TipsType_10310_Desc = {
    Text = "Sağlık Alarm değerinin altında, soruşturma riski arttı."
  },
  TipsType_10311_Desc = {
    Text = "Sağlık Alarm eşiğinin altında. Soruşturma riski son derece yüksek. Zor kullanarak devam etmek istiyor musun?"
  },
  TipsType_10312_Desc = {
    Text = "Mevcut Dayanıklılık, Gizli Diyar’a girmek için çok düşük."
  },
  TipsType_10313_Desc = {
    Text = "Lütfen aynı seviyede özel bir kart seçerek değiştir."
  },
  TipsType_10314_Desc = {
    Text = "Bu yön, Uyandırıcı Aydınlanma Seviyesi 2'ye ulaştığında açılır."
  },
  TipsType_10315_Desc = {
    Text = "Bu yön, Uyandırıcı Aydınlanma Seviyesi 3'e ulaştığında açılır."
  },
  TipsType_10316_Desc = {Text = "Mevcut"},
  TipsType_10317_Desc = {
    Text = "Tüm Uyandırıcıların Becerileri Kilitli ve Şarj olamazlar."
  },
  TipsType_10318_Desc = {
    Text = "Tüm Uyandırıcı Becerileri tamamen şarj oldu."
  },
  TipsType_10319_Desc = {
    Text = "Kullanıldı"
  },
  TipsType_10320_Desc = {
    Text = "Yetersiz Kara Mühür"
  },
  TipsType_10321_Desc = {
    Text = "Yetersiz Kara Mühür"
  },
  TipsType_10322_Desc = {
    Text = "Yetersiz Kara Mühür"
  },
  TipsType_10323_Desc = {
    Text = "Zaten sahip olduğun bir Kalıntıyı elde edemezsin."
  },
  TipsType_10324_Desc = {
    Text = "Yeterli Yenileme yok"
  },
  TipsType_10325_Desc = {
    Text = "Müttefiklere {s1} Hasar verir."
  },
  TipsType_10326_Desc = {Text = "SLD"},
  TipsType_10327_Desc = {
    Text = "Burada Aşamanın bir mini harita ön izlemesi gösterilecek; böylece oyuncular önceden Strateji planlayabilecek."
  },
  TipsType_10328_Desc = {
    Text = "Günlük zindanda bir aşamayı tamamlamak için 10 dakika harcadın; burada benzersiz bir oynanış deneyimi yaşadın ve aşama tasarımı sayesinde tür hakkındaki kavrayışını güçlendirdin."
  },
  TipsType_10329_Desc = {
    Text = "Mevcut HP sınırı, Maksimum HP'nin %50'sinin altında; lütfen temkinli ol."
  },
  TipsType_10330_Desc = {
    Text = "Uyandırıcının varlığını sürdüren enerji. Hasar almak HP'yi azaltır ve HP sıfıra indiğinde Soruşturma başarısız olur."
  },
  TipsType_10331_Desc = {
    Text = "Uyandırıcının Saldırı şiddetinin bir ölçüsü. Güç ne kadar yüksekse, Komut Kartları kullanıldığında düşmanlara verilen Hasar da o kadar artar."
  },
  TipsType_10332_Desc = {
    Text = "Uyandırıcının savunma kabiliyetinin bir yansıması. Alarm ne kadar yüksekse, Komut Kartları kullanıldığında kazanılan Karakter Kalkanı da o kadar fazladır."
  },
  TipsType_10333_Desc = {
    Text = "Devam etmek için herhangi bir yere tıkla"
  },
  TipsType_10334_Desc = {
    Text = "Henüz tamamlanmış hiçbir görev soruşturma eşyası yok."
  },
  TipsType_10335_Desc = {
    Text = "Değerlendirme"
  },
  TipsType_10336_Desc = {
    Text = "1 Özel Kart’a Vahiy Ruhu bahşet."
  },
  TipsType_10337_Desc = {
    Text = "Özel kart için güçlendirme yönünü seç."
  },
  TipsType_10338_Desc = {
    Text = "Ana şehrin mini haritası henüz Alınabilir değil. Takipte kal."
  },
  TipsType_10339_Desc = {
    Text = "{s1}{s2} Değeri"
  },
  TipsType_10340_Desc = {
    Text = "{s1} Sade Deste Seviye Yükseltme"
  },
  TipsType_10341_Desc = {
    Text = "<Positive:Afinite:>"
  },
  TipsType_10342_Desc = {
    Text = "Uyandıran ile kurulan duygusal bağın bir tezahürü. Afinite derinleştikçe, Uyandıran’ı daha yakından tanıyabilirsin."
  },
  TipsType_10343_Desc = {
    Text = "<Positive:Mevcut Seviye:>{s1}"
  },
  TipsType_10344_Desc = {
    Text = "<Positive:Sade Deste:>"
  },
  TipsType_10345_Desc = {
    Text = "Bir Diyar’ın zindana girerken sahip olduğu başlangıç destesidir."
  },
  TipsType_10346_Desc = {
    Text = "<Positive:Destede Ulaşılan En Yüksek Seviye:>{s1} Seviye"
  },
  TipsType_10347_Desc = {
    Text = "<Positive:Deste Seviyesi:>"
  },
  TipsType_10348_Desc = {
    Text = "Bu Diyar’daki belirtilen sayıda Uyandıran, hedeflenen Afinite Seviyesine ulaştığında, temel deste Yükseltilebilir."
  },
  TipsType_10349_Desc = {
    Text = "<Positive:Yükseltme İçeriği:>"
  },
  TipsType_10350_Desc = {
    Text = "Her Yükseltme, bir Komut Kartı’nın temel değerini güçlendirir."
  },
  TipsType_10351_Desc = {
    Text = "{s1} Yakınlık Arttı"
  },
  TipsType_10352_Desc = {
    Text = "Gizli Diyarın Sessizliğinde"
  },
  TipsType_10353_Desc = {
    Text = "Gizli Diyarlar Davetsizleri Geri Püskürtür"
  },
  TipsType_10354_Desc = {
    Text = "Gizli Diyar İtimi Arttı"
  },
  TipsType_10355_Desc = {
    Text = "İtki {s1} değerine ulaştı, Gizli Diyar seni izliyor."
  },
  TipsType_10356_Desc = {
    Text = "1 Aydınlanma"
  },
  TipsType_10357_Desc = {
    Text = "Bu Beceriyi Kavra"
  },
  TipsType_10358_Desc = {
    Text = "Aynı anda var olabilecek azami Dokunaç sayısı."
  },
  TipsType_10359_Desc = {
    Text = "Dokunaç Saldırısı gücünün bir ölçüsü. Dokunaç ne kadar Güçlü olursa, tetiklendiğinde düşmanlara o kadar fazla Hasar verir."
  },
  TipsType_10360_Desc = {
    Text = "Hiç Komut Kartı Seçilmedi"
  },
  TipsType_10361_Desc = {
    Text = "Dönüşüm Başarılı"
  },
  TipsType_10362_Desc = {
    Text = "Hiç Komut Kartı Seçilmedi"
  },
  TipsType_10363_Desc = {
    Text = "Kopyalama Başarılı"
  },
  TipsType_10364_Desc = {
    Text = "{s1} Komut Kartı seçildi"
  },
  TipsType_10365_Desc = {
    Text = "Hiç Komut Kartı Seçilmedi"
  },
  TipsType_10366_Desc = {
    Text = "Hiç Komut Kartı Seçilmedi"
  },
  TipsType_10367_Desc = {
    Text = "Yükseltildi"
  },
  TipsType_10368_Desc = {
    Text = "Kalıntı Envanteri arayüzü geliştirme aşamasında. Lütfen takipte kalın."
  },
  TipsType_10369_Desc = {
    Text = "Dönüştürülecek bir Kalıntı seç"
  },
  TipsType_10370_Desc = {
    Text = "Oyun güncellendi. Lütfen yeniden indirip kur."
  },
  TipsType_10371_Desc = {
    Text = "Gelişmiş Etki"
  },
  TipsType_10372_Desc = {
    Text = "Gizli Diyar Bilgisi"
  },
  TipsType_10373_Desc = {
    Text = "Her 1 Hasar Kartı oynandığında, bir Dokunaç rastgele bir düşmana {s1} Hasar verir."
  },
  TipsType_10374_Desc = {
    Text = "Şu Anda Bekleyen Konu Yok"
  },
  TipsType_10375_Desc = {
    Text = "Henüz Arşivlenmiş Konu Yok"
  },
  TipsType_10376_Desc = {
    Text = "Bu Soruşturmadan Tamamlanmamış Görevler"
  },
  TipsType_10377_Desc = {
    Text = "Geri Alınamaz"
  },
  TipsType_10378_Desc = {
    Text = "(Aşağıdaki başlıklar otomatik olarak arşivlendi.)"
  },
  TipsType_10379_Desc = {
    Text = "Hedef Konu Tamamlandı"
  },
  TipsType_10380_Desc = {
    Text = "Eşya sahip değil"
  },
  TipsType_10381_Desc = {
    Text = "Geçersiz indeks değeri"
  },
  TipsType_10382_Desc = {Text = "Kilitli"},
  TipsType_10383_Desc = {
    Text = "Özel kart yükseltme denemesi kalmadı"
  },
  TipsType_10384_Desc = {
    Text = "1 Kalıntı Sakla yuvası açıldı."
  },
  TipsType_10385_Desc = {
    Text = "Bağlantı Oranı Artışı"
  },
  TipsType_10386_Desc = {
    Text = "Yuvalara dair bilgi yok"
  },
  TipsType_10387_Desc = {
    Text = "Yetersiz Para Birimi"
  },
  TipsType_10388_Desc = {
    Text = "Maksimum seviye erişildi"
  },
  TipsType_10389_Desc = {
    Text = "Geliştirme aşamasında, lütfen takipte kalın."
  },
  TipsType_10390_Desc = {
    Text = "Daha fazla el ile yükseltme yuvası yok"
  },
  TipsType_10391_Desc = {
    Text = "Bir Mağaza’da ya da kampta mühür açıldıktan sonra kullanılabilir."
  },
  TipsType_10392_Desc = {
    Text = "Bu Savaş {s1} Dayanıklığa mal olur"
  },
  TipsType_10393_Desc = {
    Text = "Uyandıran enerjisi dolu ve daha fazla artırılamaz."
  },
  TipsType_10394_Desc = {
    Text = "Tüm Uyandıranların enerjisi tamamen yükseltildi."
  },
  TipsType_10395_Desc = {
    Text = "\"Onun Gözleri\" gereklidir, Kilidi Açmak için"
  },
  TipsType_10396_Desc = {
    Text = "Dua başarıyla kazındı"
  },
  TipsType_10397_Desc = {
    Text = "{s1} Uyandıran konuşlandırıldı, ekip {s2} Diyar özelliği taşıyacak."
  },
  TipsType_10398_Desc = {
    Text = "Grup Tarafsız hâle gelir ve hiçbir Diyar özelliği taşımaz."
  },
  TipsType_10399_Desc = {
    Text = "Küçük Döngü sistemi doğrulaması, 4. Bölüm Aşamalarında açılır."
  },
  TipsType_10400_Desc = {
    Text = "En fazla {s1} Kalıntı devralabilirsin. Lütfen önce seçili Kalıntı sayısını azalt."
  },
  TipsType_10401_Desc = {
    Text = "İşaretlenmemiş Kalıntılar miras alınamaz."
  },
  TipsType_10405_Desc = {Text = "{s1} kazan"},
  TipsType_10406_Desc = {
    Text = "Sahadaki Uyandıran sayısı azami sınıra ulaştı."
  },
  TipsType_10407_Desc = {
    Text = "Bu Altın Kuleye meydan okunamaz."
  },
  TipsType_10408_Desc = {
    Text = "Bu Altın Kule Kilitli. Lütfen belirtilen soruşturma zindanını Tamamla."
  },
  TipsType_10409_Desc = {
    Text = "Konuşlandırmak için bir Uyandırma seç"
  },
  TipsType_10410_Desc = {
    Text = "Uyandırıcılar görevleri tamamlamakla meşgul. Ödüllerini almak için sonra geri dön."
  },
  TipsType_10411_Desc = {
    Text = "{s1} Gül Senedi alındı"
  },
  TipsType_10412_Desc = {
    Text = "Zaman ödüllerinin birikmesi için zamana ihtiyaç vardır."
  },
  TipsType_10413_Desc = {
    Text = "Yetersiz \"Gümüş\""
  },
  TipsType_10414_Desc = {
    Text = "Meydan okuma denemesi kalmadı"
  },
  TipsType_10415_Desc = {
    Text = "Meydan okuma bekleme süresinde"
  },
  TipsType_10416_Desc = {
    Text = "Meydan okunacak rakip yok"
  },
  TipsType_10417_Desc = {
    Text = "Konuşlandırmak için bir Uyandırma seç"
  },
  TipsType_10418_Desc = {
    Text = "Yetersiz Gnosis İksiri, seviye yükseltmeye devam edilemiyor."
  },
  TipsType_10419_Desc = {
    Text = "Mevcut Seviye en yüksek düzeye ulaştı."
  },
  TipsType_10420_Desc = {
    Text = "Uyandıran Kilitli"
  },
  TipsType_10421_Desc = {
    Text = "Koleksiyonlardan başarıyla kaldırıldı."
  },
  TipsType_10422_Desc = {
    Text = "Hikâye meydan okumaları için yetersiz satın alma denemesi"
  },
  TipsType_10423_Desc = {
    Text = "Süpürme için yeterli hikâye Yıldızlar’ı yok"
  },
  TipsType_10424_Desc = {
    Text = "Soruşturma zindanı ekibi için Diyar yapılandırması hatalı."
  },
  TipsType_10425_Desc = {
    Text = "Yetersiz \"Gümüş\""
  },
  TipsType_10426_Desc = {
    Text = "Günlük Kupon Satın Alma Sınırına Ulaşıldı"
  },
  TipsType_10427_Desc = {
    Text = "Gizli Diyar’ı 3 yıldızla tamamlayınca kilidi açılır."
  },
  TipsType_10428_Desc = {
    Text = "{s1} kupon başarıyla alındı."
  },
  TipsType_10429_Desc = {
    Text = "{s1} meydan okuma hakkı başarıyla alındı."
  },
  TipsType_10430_Desc = {
    Text = "Kilidi açmak için Soruşturma 4-6’yı tamamla"
  },
  TipsType_10431_Desc = {
    Text = "Yetersiz Kupon"
  },
  TipsType_10432_Desc = {
    Text = "Yetersiz kupon satın alma denemesi"
  },
  TipsType_10433_Desc = {
    Text = "Aydınlanma Seviyesi en yüksek düzeye ulaştı."
  },
  TipsType_10434_Desc = {
    Text = "\"{s1}\" yetersiz"
  },
  TipsType_10435_Desc = {
    Text = "Satışta böyle bir eşya yok"
  },
  TipsType_10436_Desc = {
    Text = "Bu türde bir mağaza yok"
  },
  TipsType_10437_Desc = {
    Text = "Satıştaki eşya tükendi"
  },
  TipsType_10438_Desc = {
    Text = "Mağaza verisi alınabilir değil"
  },
  TipsType_10439_Desc = {
    Text = "Yenileme denemesi kalmadı"
  },
  TipsType_10440_Desc = {
    Text = "Bugünkü \"Menofin\" satın alma sınırına ulaşıldı."
  },
  TipsType_10441_Desc = {
    Text = "Yetersiz Uyandıran Kırık Parçası"
  },
  TipsType_10442_Desc = {
    Text = "Aydınlanma Etkinleştirildi"
  },
  TipsType_10443_Desc = {
    Text = "Gerekli Aydınlanma Etkinleştirilmemiş"
  },
  TipsType_10444_Desc = {
    Text = "\"Menofin\" × {s1} başarıyla satın alındı."
  },
  TipsType_10445_Desc = {
    Text = "\"Menofin\" Sınırına Ulaşıldı"
  },
  TipsType_10446_Desc = {
    Text = "Kilidi açmak için Soruşturma 1-12’yi tamamla"
  },
  TipsType_10447_Desc = {
    Text = "Kilidi açmak için Prolog’u tamamla"
  },
  TipsType_10448_Desc = {
    Text = "Kilidi açmak için Prolog’u tamamla"
  },
  TipsType_10449_Desc = {
    Text = "Kilidi açmak için Soruşturma 2-14’ü tamamla"
  },
  TipsType_10450_Desc = {
    Text = "Bu Beceri en yüksek Seviyeye ulaştı"
  },
  TipsType_10451_Desc = {
    Text = "Yüceltme Kademesi Yetersiz"
  },
  TipsType_10452_Desc = {
    Text = "Yetersiz malzeme"
  },
  TipsType_10453_Desc = {
    Text = "Kilidi açmak için Soruşturma 3-15’i tamamla"
  },
  TipsType_10454_Desc = {
    Text = "Kilidi açmak için Soruşturma 3-7’yi tamamla"
  },
  TipsType_10455_Desc = {
    Text = "Beceri yükseltme koşulları karşılanmadı"
  },
  TipsType_10456_Desc = {
    Text = "Test sürümü, her bir şarj eşyası için yalnızca 1 şarj operasyonuna izin verir."
  },
  TipsType_10457_Desc = {
    Text = "Bu Uyandıran'ın Köken Varışı bekleme süresinde; onu bir sonraki turda serbest bırak."
  },
  TipsType_10458_Desc = {
    Text = "Şarj ayarlarında böyle bir yapılandırma yok"
  },
  TipsType_10459_Desc = {
    Text = "Ücretsiz doldurmayı zaten aldınız, tekrar şarj edemezsiniz"
  },
  TipsType_10460_Desc = {
    Text = "Rezonans zaten etkin. Yeniden etkinleştirmeye gerek yok."
  },
  TipsType_10461_Desc = {
    Text = "{s1} için fiyat değişti. Lütfen onayla."
  },
  TipsType_10462_Desc = {
    Text = "Yetersiz Gül Senedi"
  },
  TipsType_10463_Desc = {
    Text = "Yetersiz \"Tatbikat Rozeti\""
  },
  TipsType_10464_Desc = {
    Text = "Kilidi açmak için Soruşturma 3-4’ü tamamla"
  },
  TipsType_10465_Desc = {
    Text = "Kilidi açmak için Soruşturma 2-16’yı tamamla"
  },
  TipsType_10466_Desc = {
    Text = "Kilidi açmak için Soruşturma 3-16’yı tamamla"
  },
  TipsType_10467_Desc = {
    Text = "Kilidi açmak için Soruşturma 4-12’yi tamamla"
  },
  TipsType_10468_Desc = {
    Text = "Kilidi açmak için Soruşturma 5-12’yi tamamla"
  },
  TipsType_10469_Desc = {
    Text = "Kilidi açmak için Soruşturma 6-12’yi tamamla"
  },
  TipsType_10470_Desc = {
    Text = "Kilidi açmak için Soruşturma 1-7’yi tamamla"
  },
  TipsType_10471_Desc = {
    Text = "Başarıyla Kuşanıldı"
  },
  TipsType_10472_Desc = {
    Text = "Başarıyla Çıkarıldı"
  },
  TipsType_10473_Desc = {
    Text = "Maksimum Seviyeye Ulaşıldı"
  },
  TipsType_10474_Desc = {
    Text = "Yetersiz Gül Senedi"
  },
  TipsType_10475_Desc = {
    Text = "Lütfen Malzeme Seç"
  },
  TipsType_10476_Desc = {
    Text = "Şu anda kilitli ve korunuyor. Lütfen önce kilidini açın."
  },
  TipsType_10477_Desc = {
    Text = "Aşama Alınabilir Değil"
  },
  TipsType_10478_Desc = {
    Text = "Savaş Dışında Kullanılamaz"
  },
  TipsType_10479_Desc = {
    Text = "Atılmış Kart Destesi Boş"
  },
  TipsType_10480_Desc = {
    Text = "RPG savaş ayarlaması devam ediyor, şu anda doğrudan zafer olarak sonuçlanıyor"
  },
  TipsType_10482_Desc = {
    Text = "Kader Çarkı Kilitli"
  },
  TipsType_10483_Desc = {
    Text = "Kader Çarkı Bulunamadı"
  },
  TipsType_10484_Desc = {
    Text = "Kader Çarkı en yüksek Seviyeye ulaştı."
  },
  TipsType_10485_Desc = {
    Text = "Kader Çarkı Kuşanıldı"
  },
  TipsType_10486_Desc = {
    Text = "Kader Çarkı Uyumsuz"
  },
  TipsType_10487_Desc = {
    Text = "Kader Çarkı Kilidi Açıldı"
  },
  TipsType_10488_Desc = {
    Text = "\"Dizilim\", \"Destek\" veya \"Ahit Planı\"nda bulunan Ahitler sökülemez."
  },
  TipsType_10489_Desc = {
    Text = "\"Dizilim\" veya \"Destek\"te bulunan Kader Çarkları sökülemez."
  },
  TipsType_10490_Desc = {
    Text = "Taşkınlığı serbest bırakmak için yeterli Aliemus yok."
  },
  TipsType_10491_Desc = {
    Text = "Lütfen önce önceki hediye paketini alın."
  },
  TipsType_10492_Desc = {
    Text = "Geçerli Ahit kilitli. Malzeme olarak kullanmak için kilidini açın."
  },
  TipsType_10493_Desc = {
    Text = "Geçerli Kader Çarkı kilitli. Malzeme olarak kullanmak için kilidini açın."
  },
  TipsType_10494_Desc = {
    Text = "Kilidi açmak için Soruşturma 1-7’yi tamamla"
  },
  TipsType_10495_Desc = {
    Text = "Kilidi açmak için Soruşturma 1-13’ü Tamamlayın"
  },
  TipsType_10496_Desc = {
    Text = "Mevcut Ahit seviyesi en yüksek düzeye ulaştı."
  },
  TipsType_10497_Desc = {
    Text = "Mağaza Sıfırlama"
  },
  TipsType_10498_Desc = {
    Text = "Değiştirildi"
  },
  TipsType_10499_Desc = {
    Text = "Favorilere eklendi"
  },
  TipsType_10500_Desc = {
    Text = "Yükseltildi"
  },
  TipsType_10501_Desc = {
    Text = "Mevcut Meydan Okuma Kilitli"
  },
  TipsType_10502_Desc = {
    Text = "Geçerli Uyandıran, {s1} içindeki başka bir Aşamaya zaten meydan okudu ve tekrar görevlendirilemez."
  },
  TipsType_10503_Desc = {
    Text = "Savaştaki Uyandıran sayısı 4'ten az, meydan okuma yapılamıyor."
  },
  TipsType_10504_Desc = {
    Text = "Kilidi açmak için Soruşturma 3-7’yi tamamla"
  },
  TipsType_10505_Desc = {
    Text = "Kilidi açmak için 1. Katta 3 Yıldız’a Erişim"
  },
  TipsType_10506_Desc = {
    Text = "Kilidi açmak için 2. Katta 3 Yıldız’a Erişim"
  },
  TipsType_10507_Desc = {
    Text = "Kilidi açmak için 3. Katta 3 Yıldız’a Erişim"
  },
  TipsType_10508_Desc = {
    Text = "Kilidi açmak için 4. Katta 3 Yıldız’a Erişim"
  },
  TipsType_10509_Desc = {
    Text = "Kilidi açmak için 5. Katta 3 Yıldız’a Erişim"
  },
  TipsType_10510_Desc = {
    Text = "Kilidi açmak için 6. Katta 3 Yıldız’a Erişim"
  },
  TipsType_10511_Desc = {
    Text = "Kilidi açmak için 7. Katta 3 Yıldız’a Erişim"
  },
  TipsType_10512_Desc = {
    Text = "Kilidi açmak için 8. Katta 3 Yıldız’a Erişim"
  },
  TipsType_10513_Desc = {
    Text = "Lütfen güçlendirmek istediğiniz Ahit’i seçin."
  },
  TipsType_10514_Desc = {Text = "Alındı"},
  TipsType_10515_Desc = {
    Text = "Kilidi açmak için Soruşturma 2-14’ü tamamla"
  },
  TipsType_10516_Desc = {
    Text = "Kilidi açmak için Soruşturma 4-7’yi Tamamlayın"
  },
  TipsType_10517_Desc = {
    Text = "Kilidi açmak için Soruşturma 4-7’yi Tamamlayın"
  },
  TipsType_10518_Desc = {
    Text = "Düzen Kaydedildi"
  },
  TipsType_10519_Desc = {
    Text = "Hareket etmek için Parlayan Alana Dokunun"
  },
  TipsType_10520_Desc = {
    Text = "Takım adları yalnızca Çince karakterler, İngilizce harfler ve rakamlar içerebilir."
  },
  TipsType_10521_Desc = {
    Text = "Takım adı uzunluğu 8 karakteri aşamaz"
  },
  TipsType_10522_Desc = {
    Text = "Takımdaki Uyandıran sayısı {s1}'den az, Soruşturma yapılamıyor."
  },
  TipsType_10523_Desc = {
    Text = "Bu Uyandıran, bu Işıksız Diyar katındaki diğer Gizli Diyarlarda zaten savaşa katıldı."
  },
  TipsType_10524_Desc = {
    Text = "Takımınızda aynı Diyar'dan zaten iki Uyandıran var, bu yüzden başka bir Diyar'ın Uyandıranı seçilemez."
  },
  TipsType_10525_Desc = {
    Text = "Bir Uyandırıcı Seç"
  },
  TipsType_10526_Desc = {
    Text = "Seçilebilecek en fazla Uyandırıcı sayısına ulaşıldı"
  },
  TipsType_10527_Desc = {
    Text = "Yetiştirme Notu: Hayali Dalış'ta Uyandıran'ın Seviyesi ve Beceri seviyeleri Seviye 1'e ayarlanır."
  },
  TipsType_10528_Desc = {
    Text = "Takım Adı Boş Bırakılamaz"
  },
  TipsType_10529_Desc = {
    Text = "Partide artık savaşamayacak kadar tükenmiş bir Uyandıran var."
  },
  TipsType_10530_Desc = {
    Text = "Posta kutusundaki tüm ekler alındı."
  },
  TipsType_10531_Desc = {
    Text = "Ana Hikâye Prolog tamamlandıktan sonra açılır"
  },
  TipsType_10532_Desc = {
    Text = "Envanter dolu. Bazı eşyalar toplanamadı. Lütfen envanteri boşaltıp tekrar deneyin."
  },
  TipsType_10533_Desc = {
    Text = "Envanter dolu. Ödülleriniz posta kutunuza gönderilecek."
  },
  TipsType_10534_Desc = {
    Text = "Envanter dolu. Bazı eşyalar toplanamadı. Lütfen envanteri boşaltıp tekrar deneyin."
  },
  TipsType_10535_Desc = {
    Text = "Posta eki yok"
  },
  TipsType_10536_Desc = {
    Text = "Lütfen Önce Kalıntıyı Çözümleyin"
  },
  TipsType_10537_Desc = {
    Text = "Kilidi açmak için Soruşturma 2-14’ü tamamla"
  },
  TipsType_10538_Desc = {
    Text = "Kilidi açmak için Soruşturma 1-12’yi tamamla"
  },
  TipsType_10539_Desc = {
    Text = "Kilidi açmak için Soruşturma 1-12’yi tamamla"
  },
  TipsType_10540_Desc = {
    Text = "Kilidi açmak için Soruşturma 1-12’yi tamamla"
  },
  TipsType_10541_Desc = {
    Text = "Kilidi açmak için 9. Katta 3 Yıldız’a Erişim"
  },
  TipsType_10542_Desc = {
    Text = "Kilidi açmak için 10. Katta 3 Yıldız’a Erişim"
  },
  TipsType_10543_Desc = {
    Text = "Kilidi açmak için 11. Katta 3 Yıldız’a Erişim"
  },
  TipsType_10544_Desc = {
    Text = "Kilidi açmak için 12. Katta 3 Yıldız’a Erişim"
  },
  TipsType_10545_Desc = {
    Text = "Kilidi açmak için 13. Katta 3 Yıldız’a Erişim"
  },
  TipsType_10546_Desc = {
    Text = "Kilidi açmak için 14. Katta 3 Yıldız’a Erişim"
  },
  TipsType_10547_Desc = {
    Text = "Bu Özellik Yakında Kaldırılacak"
  },
  TipsType_10548_Desc = {
    Text = "Kilidi açmak için Soruşturma 1-7’yi tamamla"
  },
  TipsType_10549_Desc = {
    Text = "Daha Fazla Kalıntı Elde Edilemez"
  },
  TipsType_10550_Desc = {
    Text = "{s1} Bağı tamamladı ve artık ona savaşta komuta edebilir."
  },
  TipsType_10551_Desc = {
    Text = "{s1}'in Seviye ve Beceri Seviyesi, Gnosis Yükselticisi'nin sağlayabileceğinin üzerinde ve kullanılamıyor."
  },
  TipsType_10552_Desc = {
    Text = "Uyandırma Seviyesi ve Beceri Seviyesi, Gnosis Yükselticisi’nin sağladığı Seviyeyi aştı ve kullanılamaz."
  },
  TipsType_10553_Desc = {
    Text = "Takipte kalın"
  },
  TipsType_10554_Desc = {
    Text = "Önceki Aşama tamamlandıktan sonra kilidi açılır."
  },
  TipsType_10555_Desc = {
    Text = "Kırılgan Yol’da Geri Dönüş Yok"
  },
  TipsType_10556_Desc = {
    Text = "Henüz Alınabilir değil. Takipte kalın."
  },
  TipsType_10557_Desc = {
    Text = "Bu Kalıntıya zaten sahipsiniz, yeniden elde edemezsiniz."
  },
  TipsType_10558_Desc = {
    Text = "Sistem panosundaki içerik alınarak <Positive:[Paste]> işlemi gerçekleştirilecek\nEmin misiniz?"
  },
  TipsType_10558_LeftBtnDesc = {Text = "İptal"},
  TipsType_10558_RightBtnDesc = {Text = "Onayla"},
  TipsType_10558_Title = {
    Text = "Yapıştırmayı Etkinleştir"
  },
  TipsType_10559_Desc = {
    Text = "Yetersiz Malzeme"
  },
  TipsType_10560_Desc = {
    Text = "Zaten Başlangıç Durumunda"
  },
  TipsType_10561_Desc = {
    Text = "Yetersiz Gül Senedi"
  },
  TipsType_10562_Desc = {
    Text = "Yükseltilmemiş"
  },
  TipsType_10563_Desc = {
    Text = "Rezonans Sıfırlama Başarılı"
  },
  TipsType_10564_Desc = {
    Text = "Koruyucu Seviye {s1}'e ulaş"
  },
  TipsType_10565_Desc = {
    Text = "Mühürlü Aliemus Serbest Bırakılamaz"
  },
  TipsType_1056601_Desc = {
    Text = "Gümüş İletişim hatası, lütfen ağınızı kontrol edip tekrar deneyin({s1})."
  },
  TipsType_10566_Desc = {
    Text = "Gümüş İletişim hatası, lütfen daha sonra tekrar deneyin({s1})."
  },
  TipsType_10567_Desc = {
    Text = "Sunucu bilgisi alınamadı! {s1}."
  },
  TipsType_10568_Desc = {
    Text = "Lütfen Önce bir Sunucu Seçin"
  },
  TipsType_10569_Desc = {
    Text = "Henüz kilitli değil"
  },
  TipsType_10570_Desc = {
    Text = "\"Lütfen hesabınızı girin\""
  },
  TipsType_10571_Desc = {
    Text = "Yetersiz Rezonans Etkinleştirme Malzemesi"
  },
  TipsType_10572_Desc = {
    Text = "Gerekli Rezonans Yükseltilmemiş"
  },
  TipsType_10573_Desc = {
    Text = "Seviye Maksimumda"
  },
  TipsType_10574_Desc = {
    Text = "Yükseltildi"
  },
  TipsType_10575_Desc = {
    Text = "Bu Uyandırma Uzmanı Değiştirilemez"
  },
  TipsType_10576_Desc = {
    Text = "Bu Yuva Konuşlandırma İçin Alınabilir Değil"
  },
  TipsType_10577_Desc = {
    Text = "Yeterli Uyandırma Uzmanı Yok, Meydan Okunamıyor"
  },
  TipsType_10578_Desc = {
    Text = "Sonraki Aşama Kilitli"
  },
  TipsType_10579_Desc = {
    Text = "Zaten Son Aşama"
  },
  TipsType_10580_Desc = {
    Text = "EXP Sınırına Ulaşıldı, Eklenemiyor"
  },
  TipsType_10581_Desc = {
    Text = "Kader Çarkı Yuvaları Dolu, Eklenemiyor"
  },
  TipsType_10582_Desc = {
    Text = "Hızlı yerleştirme için alınabilir malzeme yok."
  },
  TipsType_10583_Desc = {
    Text = "Lütfen malzemeleri Kader Çarkı yuvasına yerleştirin."
  },
  TipsType_10584_Desc = {
    Text = "Kuşanılacak Alınabilir Kader Çarkı Yok"
  },
  TipsType_10585_Desc = {
    Text = "Kilidi Açmak İçin Soruşturma 2-8 Tamamlanmalı"
  },
  TipsType_10586_Desc = {
    Text = "Kilidi açmak için Soruşturma 2-14’ü tamamla"
  },
  TipsType_10587_Desc = {
    Text = "Kilidi açmak için Soruşturma 3-16’yı tamamla"
  },
  TipsType_10588_Desc = {
    Text = "Kilidi açmak için Soruşturma 4-12’yi tamamla"
  },
  TipsType_10589_Desc = {
    Text = "Kilidi açmak için Soruşturma 5-12’yi tamamla"
  },
  TipsType_10590_Desc = {
    Text = "Kilidi açmak için Soruşturma 6-12’yi tamamla"
  },
  TipsType_10591_Desc = {
    Text = "Kilidi Açmak İçin Soruşturma 2-12 Tamamlanmalı"
  },
  TipsType_10592_Desc = {
    Text = "Bu hesap için giriş yasağı uygulanmıştır. Sorularınız varsa lütfen müşteri hizmetleriyle iletişime geçin."
  },
  TipsType_10593_Desc = {
    Text = "Oturum süreniz doldu. Lütfen yeniden giriş yapın."
  },
  TipsType_10594_Desc = {
    Text = "Yetersiz \"Menofin\""
  },
  TipsType_10595_Desc = {
    Text = "\"{s1}\" etkinleştirilsin mi?"
  },
  TipsType_10595_Title = {
    Text = "Yetenek Etkinleştir"
  },
  TipsType_10596_Desc = {
    Text = "Bu Uyandırma Uzmanı Henüz Elde Edilmedi"
  },
  TipsType_10597_Desc = {
    Text = "Geliştirilecek Alınabilir Kader Çarkı Yok"
  },
  TipsType_10598_Desc = {
    Text = "Bu hesap, ilgili düzenlemelerin ihlali nedeniyle {s1} tarihine kadar girişten men edilmiştir. Sorularınız varsa lütfen müşteri hizmetleriyle iletişime geçin."
  },
  TipsType_10599_Desc = {
    Text = "Kilidi Açmak İçin Soruşturma 2-15 Tamamlanmalı"
  },
  TipsType_10600_Desc = {
    Text = "Maksimum Seviye, Daha Fazla Eklenemiyor"
  },
  TipsType_10601_Desc = {
    Text = "Soruşturma 1-7 Tamamlandıktan sonra Koruyucu’nun Yolculuk Kaydı açılır."
  },
  TipsType_10602_Desc = {
    Text = "Soruşturma 1-7 Tamamlandıktan sonra Diyar Ustalığı görevleri açılır."
  },
  TipsType_10603_Desc = {
    Text = "Hiçbir Malzeme Seçilmedi"
  },
  TipsType_10604_Desc = {
    Text = "Hareketsizlik nedeniyle senaryodan otomatik olarak çıkılıyor."
  },
  TipsType_10605_Desc = {
    Text = "Anket tamamlandı. Desteğiniz için teşekkür ederiz."
  },
  TipsType_10606_Desc = {
    Text = "Etkinleştirmek İçin Yeterli Malzeme Yok"
  },
  TipsType_10607_Desc = {
    Text = "Bu hafta için ödül sınırına ulaşıldı. Mücadeleyi tamamlasa­nız bile ödül alamayacaksınız. Yine de devam edilsin mi?"
  },
  TipsType_10607_LeftBtnDesc = {Text = "İptal"},
  TipsType_10607_RightBtnDesc = {Text = "Onayla"},
  TipsType_10607_Title = {
    Text = "Meydan Okuma İpucu"
  },
  TipsType_10608_Desc = {
    Text = "Kampüs bakımı sürüyor. Lütfen Tamamlandı olmasını bekleyin."
  },
  TipsType_10609_Desc = {
    Text = "{s1} başarıyla yurdunuza davet edildi."
  },
  TipsType_10610_Desc = {
    Text = "{s1} zaten yurdunuzda."
  },
  TipsType_10611_Desc = {
    Text = "Wi-Fi ağına bağlı değilsiniz. İndirmeye devam etmek için mobil veri kullanmak istiyor musunuz?"
  },
  TipsType_10611_LeftBtnDesc = {Text = "İptal"},
  TipsType_10611_RightBtnDesc = {Text = "Onayla"},
  TipsType_10611_Title = {
    Text = "İndirmeyi Onayla"
  },
  TipsType_10612_Desc = {
    Text = "Tüm kartlar zaten kazınmış."
  },
  TipsType_10613_Desc = {
    Text = "Ağ Hatası, Lütfen Bekleyin"
  },
  TipsType_10614_Desc = {
    Text = "Mevcut Meydan Okuma Kilitli"
  },
  TipsType_10615_Desc = {
    Text = "Bekleme süresinde, bir sonraki tura kadar serbest bırakılamaz."
  },
  TipsType_10616_Desc = {
    Text = "Seçim sırasında, yalnızca seçim tamamlandıktan sonra Serbest Bırakılabilir."
  },
  TipsType_10617_Desc = {
    Text = "Mühürlü durumda, Taşkınlık serbest bırakılamaz."
  },
  TipsType_10618_Desc = {
    Text = "Mevcut ekibin ortalama seviyesi {s1}, önerilen seviye {s2} değerinden düşük. Soruşturma ciddi zorluklarla karşılaşabilir. Yine de devam edilsin mi?"
  },
  TipsType_10618_LeftBtnDesc = {
    Text = "Uyananları Geliştir"
  },
  TipsType_10618_RightBtnDesc = {Text = "Onayla"},
  TipsType_10618_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_10619_Desc = {
    Text = "Koruyucu Seviye {s1}'e ulaş"
  },
  TipsType_10620_Desc = {
    Text = "Zayıf ağ koşulları. Lütfen Steam bağlantınızı kontrol edin veya Steam’i yeniden başlatıp tekrar deneyin."
  },
  TipsType_10621_Desc = {
    Text = "<WeaponEffect_Num:{s1}> adını kullanmak istediğinizden emin misiniz?"
  },
  TipsType_10621_LeftBtnDesc = {Text = "İptal"},
  TipsType_10621_RightBtnDesc = {Text = "Onayla"},
  TipsType_10621_Title = {
    Text = "İsmini Doğrula"
  },
  TipsType_10622_Desc = {
    Text = "Kazıma bekleme süresinde. İsminiz {s1} saat ve {s2} dakika sonra yeniden kazınabilir."
  },
  TipsType_10623_Desc = {
    Text = "Kazıma Başarılı"
  },
  TipsType_10624_Desc = {
    Text = "İsimler yalnızca Çince karakterler, İngilizce harfler ve rakamlar içerebilir."
  },
  TipsType_10625_Desc = {
    Text = "Bu Kart Az Sonra Atılacak"
  },
  TipsType_10626_Desc = {
    Text = "Lütfen Steam’de aşağıdaki seçeneği etkinleştirin:\n[Steam Settings - In-Game - Enable the Steam Overlay while in-game]\nve değişikliklerin etkili olması için oyunu yeniden başlatın."
  },
  TipsType_10626_RightBtnDesc = {Text = "Onayla"},
  TipsType_10626_Title = {
    Text = "Soruşturma Devam Ediyor"
  },
  TipsType_10628_Desc = {
    Text = "Yeni ad mevcut adla aynı olamaz."
  },
  TipsType_10629_Desc = {
    Text = "Lütfen {s1}~{s2} karakter girin"
  },
  TipsType_10630_Desc = {
    Text = "3 Yıldız elde edildikten sonra {s1} Yeniden Canlandırma alınabilir."
  },
  TipsType_10631_Desc = {
    Text = "Hesabınız, ilgili hüküm ve koşulların ihlali nedeniyle zorla oturumdan çıkarıldı."
  },
  TipsType_10631_RightBtnDesc = {Text = "Onayla"},
  TipsType_10631_Title = {Text = "Not"},
  TipsType_10632_Desc = {
    Text = "Mücadeleyi tamamladıktan sonra, bugün Yeniden Canlandırma yapabilirsiniz."
  },
  TipsType_10633_Desc = {
    Text = "Aşağıdaki eşyalar tüketilecek ve <Blue:bu işlem geri alınamaz>. Çözünmeyi onaylıyor musun?"
  },
  TipsType_10633_LeftBtnDesc = {Text = "İptal"},
  TipsType_10633_RightBtnDesc = {Text = "Onayla"},
  TipsType_10633_Title = {
    Text = "Sökme İşlemini Onayla"
  },
  TipsType_10634_Desc = {
    Text = "Mevcut aylık kartın bitmesine {s1} günden fazla kaldı, birikim yapılamaz."
  },
  TipsType_10635_Desc = {
    Text = "“Gümüş Çekirdek Özü” yetersiz. Özsu Çıkarımı’na gitmek ister misiniz?"
  },
  TipsType_10635_LeftBtnDesc = {Text = "İptal"},
  TipsType_10635_RightBtnDesc = {Text = "Onayla"},
  TipsType_10635_Title = {
    Text = "Gümüş Çekirdek Özü yetersiz"
  },
  TipsType_10636_Desc = {
    Text = "Boşta Alınabilir Kader Çarkı Yok"
  },
  TipsType_10637_Desc = {
    Text = "Boşta Ahit yok"
  },
  TipsType_10638_Desc = {
    Text = "Alınabilir Ahit yuvası yok. Lütfen bir Ahit çıkarıp yeniden deneyin."
  },
  TipsType_10640_Desc = {
    Text = "Bu Uyandırıcıdan tüm Ahitleri kaldırmak istediğinizden emin misiniz?"
  },
  TipsType_10640_LeftBtnDesc = {Text = "İptal"},
  TipsType_10640_RightBtnDesc = {Text = "Onayla"},
  TipsType_10640_Title = {
    Text = "Soruşturma Devam Ediyor"
  },
  TipsType_10641_Desc = {
    Text = "Yeni dil ayarlarının uygulanması için istemcinin yeniden başlatılması gerekiyor. Onaylıyor musunuz?"
  },
  TipsType_10641_LeftBtnDesc = {Text = "İptal"},
  TipsType_10641_RightBtnDesc = {Text = "Onayla"},
  TipsType_10641_Title = {
    Text = "Dil Değişimini Onayla"
  },
  TipsType_10642_Desc = {
    Text = "Oyuncu seviyesi yetersiz"
  },
  TipsType_10643_Desc = {
    Text = "Çözünme ile dolu bir alana girildiğinde, CP {s1} azalır."
  },
  TipsType_10644_Desc = {
    Text = "Bu Müfreze Seçildi"
  },
  TipsType_10645_Desc = {
    Text = "Bu Müfreze Henüz Elde Edilmedi"
  },
  TipsType_10646_Desc = {
    Text = "\"{s1}\" yetersiz"
  },
  TipsType_10647_Desc = {
    Text = "Soruşturma Etkinliği henüz başlamadı, {s1}."
  },
  TipsType_10648_Desc = {
    Text = "Dönüşüm Aralığı Güncellendi"
  },
  TipsType_10649_Desc = {
    Text = "Görev sınırına ulaşıldı."
  },
  TipsType_10650_Desc = {
    Text = "Hiçbir SSR karakter henüz kilidi açılmadı."
  },
  TipsType_10651_Desc = {
    Text = "Yalnızca belirli bir miktar toplandıktan sonra kullanılabilir."
  },
  TipsType_10652_Desc = {
    Text = "Tüm avatarlar ve Düello İfadeleri elde edildi."
  },
  TipsType_10701_Desc = {
    Text = "Şu anda bir Kader Çarkı takılı. Lütfen onu çıkarıp yeniden deneyin."
  },
  TipsType_10702_Desc = {
    Text = "Donanımlı SSR Kader Çarklarının toplam ek Yükselişi 12’ye ulaştığında, aynı anda iki SSR Kader Çarkı kuşanabilirsiniz."
  },
  TipsType_10703_Desc = {
    Text = "Uyandırıcı zaten aynı Kader Çarkını kuşanmış durumda ve tekrar kuşanamaz."
  },
  TipsType_10704_Desc = {
    Text = "Ahit Seviyesi En Üst Düzeye Ulaştı"
  },
  TipsType_10705_Desc = {
    Text = "Malzeme Tüketimi En Üst Düzeye Ulaştı"
  },
  TipsType_10706_Desc = {
    Text = "En fazla iki Alt Özelliği kilitleyebilirsin"
  },
  TipsType_10707_Desc = {
    Text = "Yetersiz Malzeme"
  },
  TipsType_10708_Desc = {
    Text = "Yüceltme Kademesi {s1} ile Açılır"
  },
  TipsType_10709_Desc = {
    Text = "\"{s1}\" yetersiz"
  },
  TipsType_10710_Desc = {Text = "Tükendi"},
  TipsType_10711_Desc = {
    Text = "Bu Eşya Kilitli"
  },
  TipsType_10712_Desc = {
    Text = "Malzeme Deposu Dolu"
  },
  TipsType_10713_Desc = {
    Text = "Kader Çarkı Yükselişi en yüksek düzeye ulaştı."
  },
  TipsType_10714_Desc = {
    Text = "Etkinlik koşulları karşılanmadı, seçilemez."
  },
  TipsType_10715_Desc = {
    Text = "Lütfen paylaşmadan önce ilgili uygulamayı yükleyin."
  },
  TipsType_10716_Desc = {
    Text = "Daha fazla Kader Çarkı seçilemez."
  },
  TipsType_10717_Desc = {
    Text = "Daha fazla Müfreze seçilemez."
  },
  TipsType_10718_Desc = {
    Text = "Etkinleştirme Başarılı"
  },
  TipsType_10719_Desc = {
    Text = "Yetersiz Bin Yüz Mührü. \"Borsa Ayarları\"ndan malzemeleri otomatik dönüştürebilirsiniz."
  },
  TipsType_10720_Desc = {
    Text = "Hız 1x’e alındı."
  },
  TipsType_10721_Desc = {
    Text = "Hız 2x’ye alındı."
  },
  TipsType_10722_Desc = {
    Text = "Kampüs girişi tıkalı, lütfen daha sonra yeniden deneyin."
  },
  TipsType_10723_Desc = {
    Text = "Başarıyla kaydedildi."
  },
  TipsType_10724_Desc = {
    Text = "Kaydetme başarısız. Albüm izinleri etkin değil ya da depolama alanı yetersiz."
  },
  TipsType_10725_Desc = {
    Text = "Yetersiz üretim malzemesi."
  },
  TipsType_10726_Desc = {
    Text = "Lütfen bir Kart seçin."
  },
  TipsType_10727_Desc = {
    Text = "Bu Uyandırıcı devre dışı bırakıldı."
  },
  TipsType_10728_Desc = {
    Text = "Köken Uyandırıcıları görevlendirilemez. Lütfen yeniden seçim yap."
  },
  TipsType_10736_Desc = {
    Text = "\"Menofin\" yeterli, takviyeye gerek yok."
  },
  TipsType_10737_Desc = {
    Text = "Yeni bir oyun sürümü tespit edildi. Güncellemek ve akıcı bir deneyim sağlamak için lütfen oyunu yeniden başlat."
  },
  TipsType_10738_Desc = {
    Text = "Mevcut tüm eğitimleri okudunuz."
  },
  TipsType_10739_Desc = {
    Text = "{s1} zaten {s2} etkinliğine katıldı ve yeniden giremez."
  },
  TipsType_10740_Desc = {
    Text = "Ekibinizin ortalama seviyesi {s1}, önerilen seviye {s2} değerinden düşük. Soruşturma ciddi zorluklarla karşılaşabilir. Yine de devam edilsin mi?"
  },
  TipsType_10740_LeftBtnDesc = {Text = "İptal"},
  TipsType_10740_RightBtnDesc = {Text = "Onayla"},
  TipsType_10740_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_10741_Desc = {
    Text = "Ekibinizin ortalama seviyesi {s1} ve Koruyucu seviyeniz {s2} bu aşama için çok düşük. Soruşturma ciddi zorluklarla karşılaşabilir. Yine de devam edilsin mi?"
  },
  TipsType_10741_LeftBtnDesc = {Text = "İptal"},
  TipsType_10741_RightBtnDesc = {Text = "Onayla"},
  TipsType_10741_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_10742_Desc = {
    Text = "Aynı Kader Çarkı etkileri biriktirilemez. Şu anda <Blue:{s1}> adlı karakterin etkin olmayan bir Kader Çarkı bulunuyor. Kader Çarkı kadronuzu ayarlamanız önerilir.\nYine de devam edilsin mi?"
  },
  TipsType_10742_LeftBtnDesc = {Text = "İptal"},
  TipsType_10742_RightBtnDesc = {Text = "Onayla"},
  TipsType_10742_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_10743_Desc = {
    Text = "Bölgesel D-Etkisi Yasak Bölgesi’nde kalan hiçbir Destek yok"
  },
  TipsType_10744_Desc = {
    Text = "Takip sınırına ulaşıldı."
  },
  TipsType_10745_Desc = {
    Text = "Geçersiz doğum tarihi, ayarlanamıyor."
  },
  TipsType_10746_Desc = {
    Text = "Kopyalandı"
  },
  TipsType_10747_Desc = {
    Text = "Beğenme başarılı."
  },
  TipsType_10748_Desc = {
    Text = "{s1} zaten bir Destek Uyandırıcı."
  },
  TipsType_10749_Desc = {
    Text = "Destek Uyandırıcı boş bırakılamaz."
  },
  TipsType_10750_Desc = {
    Text = "Bugün bu Koruyucuyu zaten beğendiniz."
  },
  TipsType_10751_Desc = {
    Text = "En fazla 4 Uyandırıcı gösterilebilir."
  },
  TipsType_10752_Desc = {
    Text = "Diyar gereksinimleri karşılamıyor ve sahaya sürülemez."
  },
  TipsType_10753_Desc = {
    Text = "{s1} zaten kadroda ve yeniden seçilemez."
  },
  TipsType_10754_Desc = {
    Text = "{s1} sıfırlandı."
  },
  TipsType_10755_Desc = {
    Text = "Başarıyla kilit açıldı."
  },
  TipsType_10756_Desc = {
    Text = "Alınabilir Yükseliş malzemesi yok."
  },
  TipsType_10757_Desc = {
    Text = "{s1} bugünkü etkinlik mücadelesine zaten katıldı ve yeniden yarışamaz."
  },
  TipsType_10758_Desc = {
    Text = "Müfreze Diyar gereksinimleri karşılanmadı."
  },
  TipsType_10761_Desc = {
    Text = "Köken formundaki bir Uyandıran, normal formuyla aynı anda sahaya sürülemez."
  },
  TipsType_10762_Desc = {
    Text = "Bir Uyandıran'ın Köken formu ile normal formu aynı anda görüntülenemez."
  },
  TipsType_10799_Desc = {
    Text = "Şu anda <Blue:{s1}> adlı karakterin Ahit tam set etkisi, <Blue:Takım Benzersiz> kısıtlaması nedeniyle aktif değil. Ahit kadronuzu ayarlamanız önerilir.\nYine de devam edilsin mi?"
  },
  TipsType_10799_LeftBtnDesc = {Text = "İptal"},
  TipsType_10799_RightBtnDesc = {Text = "Onayla"},
  TipsType_10799_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_10801_Desc = {
    Text = "Ahit Planı sınırına ulaşıldı."
  },
  TipsType_10802_Desc = {
    Text = "{s1} başka bir Ahit Planında zaten kullanılıyor ve kaydedilemez."
  },
  TipsType_10803_Desc = {
    Text = "Ahit Planı adı boş bırakılamaz."
  },
  TipsType_10804_Desc = {
    Text = "Geçersiz karakterler içeriyor, lütfen yeniden girin."
  },
  TipsType_10805_Desc = {
    Text = "Kaydedildi."
  },
  TipsType_10806_Desc = {
    Text = "Geçerli Ahit zaten {s1} içinde etkin."
  },
  TipsType_10807_Desc = {
    Text = "Kuşanılmış"
  },
  TipsType_10808_Desc = {
    Text = "Ekipman çıkarıldı."
  },
  TipsType_10809_Desc = {
    Text = "Geçerli takım zaten görevlendirilmiş."
  },
  TipsType_10810_Desc = {
    Text = "Ahit Planı boş bırakılamaz."
  },
  TipsType_10811_Desc = {
    Text = "Bu plan hâlihazırda kuşanılmış."
  },
  TipsType_10812_Desc = {
    Text = "Kuşanılmış"
  },
  TipsType_10813_Desc = {
    Text = "[{s1}] planını silmek istediğinizden emin misiniz?"
  },
  TipsType_10813_LeftBtnDesc = {Text = "İptal"},
  TipsType_10813_RightBtnDesc = {Text = "Onayla"},
  TipsType_10814_Desc = {
    Text = "Bu soruşturmada görevlendirilen Uyandıranlar, takım gereksinimlerini karşılamıyor."
  },
  TipsType_10815_Desc = {
    Text = "Mevcut Uyandıran, Hikâye için özel olarak tasarlanmıştır ve ayrıntıları görüntülenemez."
  },
  TipsType_10816_Desc = {
    Text = "Yetersiz \"Vekâlet Belgesi\""
  },
  TipsType_10817_Desc = {
    Text = "Herhangi bir yerleşim kaydı bulunamadı. Lütfen önce \"Meydan Oku\" ve ardından günlük sıfırlama saati olan 09:00’dan sonra yeniden dene."
  },
  TipsType_10818_Desc = {
    Text = "Bugün için Vekil tamamlandı. Yeniden oynatılamaz."
  },
  TipsType_10821_Desc = {
    Text = "Şu anda alınabilir erzak yok, lütfen daha sonra tekrar kontrol et."
  },
  TipsType_10822_Desc = {
    Text = "Etkinlik sona erdi."
  },
  TipsType_10823_Desc = {
    Text = "Özel tohumlar, yalnızca tamamen tükendikten sonra mağazada yeniden stoklanabilir."
  },
  TipsType_10824_Desc = {
    Text = "Tüm yeniden stok haklarını tükettin—envanterde hiçbir şey kalmadı."
  },
  TipsType_10825_Desc = {
    Text = "\"{s1}\" yetersiz"
  },
  TipsType_10826_Desc = {
    Text = "Özel tohumlar tükendi. Sıfırlamak için onları ekmeyi seçebilirsin."
  },
  TipsType_10827_Desc = {
    Text = "Özel Tohum sıfırlandı."
  },
  TipsType_10828_Desc = {
    Text = "Tüm eşyalar Borsa’da değiştirildi. Lütfen Sıfırla’yı seç."
  },
  TipsType_10829_Desc = {
    Text = "Sıfırlama başarılı."
  },
  TipsType_10830_Desc = {
    Text = "Takımda sahaya sürülemeyen Uyandırıcılar var. Soruşturma başlatılamıyor."
  },
  TipsType_10831_Desc = {
    Text = "Takımda aynı Kader Çarkı bulunuyor ve Bölgesel D-Etkisi Yasak Bölgesi’ne giremez."
  },
  TipsType_10832_Desc = {
    Text = "Hiç Müfreze kuşanılmamış. Soruşturma başlatılamıyor."
  },
  TipsType_10833_Desc = {
    Text = "Takımda kuşanılamayan Kader Çarkları var. Soruşturma başlatılamıyor."
  },
  TipsType_10834_Desc = {
    Text = "Kader Çarkı, Destek Uyanan’a kuşanılamaz."
  },
  TipsType_10835_Desc = {
    Text = "Ahit, Destek Uyandırıcıya kuşanılamaz."
  },
  TipsType_10836_Desc = {
    Text = "Kader Çarkı, hikâye için önceden ayarlanmış Uyanan’a kuşanılamaz."
  },
  TipsType_10837_Desc = {
    Text = "Hikâye için önceden ayarlanmış Uyandırıcıya Ahit kuşanılamaz."
  },
  TipsType_10838_Desc = {
    Text = "Donatılmış ifade sayısı en üst sınıra ulaştı."
  },
  TipsType_10839_Desc = {
    Text = "İfade kullanımda. Kaldırmak için bir ifadeye tıkla."
  },
  TipsType_10840_Desc = {
    Text = "Çok fazla ifade gönderiyorsun. Yavaşla :)"
  },
  TipsType_10841_Desc = {
    Text = "İfade planı boş olamaz."
  },
  TipsType_10842_Desc = {
    Text = "İfade planı güncellendi."
  },
  TipsType_10843_Desc = {
    Text = "Bu Girdi Hâlâ Kilitli"
  },
  TipsType_10844_Desc = {
    Text = "Henüz kilitli değil"
  },
  TipsType_10850_Desc = {
    Text = "Takımda kuşanılamayan Çete bulunuyor. Soruşturma başlatılamıyor."
  },
  TipsType_10901_Desc = {Text = "Felç"},
  TipsType_10902_Desc = {Text = "Baygın"},
  TipsType_10903_Desc = {
    Text = "Henüz Sahip Değilsin: {s1}"
  },
  TipsType_10904_Desc = {
    Text = "Bu bölümün \"Normal\" modunu tamamlayarak \"Hikâye\" modunu aç ve Hikâyeyi izle."
  },
  TipsType_10905_Desc = {
    Text = "\"Soruşturma Operasyonu\" 1-15: Normal tamamlandıktan sonra açılır ve \"Anımsama\" hikâye dizisini açar."
  },
  TipsType_10906_Desc = {
    Text = "Yetersiz Gerçeklik Sınırı"
  },
  TipsType_10907_Desc = {
    Text = "Kilidi Açıldı"
  },
  TipsType_10908_Desc = {
    Text = "{s1} Aydınlanma Seviyesi en üst düzeye ulaştı. Sonraki kazançlar <TipsHighlightText:\"Rafine Gnosis Parçası\" × 2>, <TipsHighlightText:\"Gnosis Parçası\" × 6>, <TipsHighlightText:\"Kök Tortusu\" × 250>'e dönüştürülecek. Uyandırmayı onaylıyor musun?"
  },
  TipsType_10908_LeftBtnDesc = {Text = "İptal"},
  TipsType_10908_RightBtnDesc = {Text = "Onayla"},
  TipsType_10908_Title = {Text = "Onaylama"},
  TipsType_10909_Desc = {
    Text = "{s1} uyandırıldı. Sonraki kazanımlar <TipsHighlightText:Parça: {s2}*1> ve <TipsHighlightText:Kök Tortusu*50>’ye dönüştürülecek. Uyandırmayı onaylıyor musun?"
  },
  TipsType_10909_LeftBtnDesc = {Text = "İptal"},
  TipsType_10909_RightBtnDesc = {Text = "Onayla"},
  TipsType_10909_Title = {Text = "Onaylama"},
  TipsType_10910_Desc = {
    Text = "<TipsHighlightText:{s1}> uyanışını onaylıyor musun?"
  },
  TipsType_10910_LeftBtnDesc = {Text = "İptal"},
  TipsType_10910_RightBtnDesc = {Text = "Onayla"},
  TipsType_10910_Title = {Text = "Onaylama"},
  TipsType_10911_Desc = {
    Text = "Yetersiz Alan"
  },
  TipsType_10912_Desc = {
    Text = "Ultra Uzay’da kullanılabilir Komut Kartı yok. Kullanılamıyor."
  },
  TipsType_10913_Desc = {
    Text = "Bu Turda Yeniden Kullanılamaz"
  },
  TipsType_10914_Desc = {
    Text = "<TipsHighlightText:{s1}> seçimini onaylıyor musun?"
  },
  TipsType_10914_LeftBtnDesc = {Text = "İptal"},
  TipsType_10914_RightBtnDesc = {Text = "Onayla"},
  TipsType_10914_Title = {
    Text = "Seçimi Onayla"
  },
  TipsType_10915_Desc = {
    Text = "Dizilişler sırayla açılmalıdır. Kilitli Dizilişler atlanamaz."
  },
  TipsType_10916_Desc = {
    Text = "Kilidi açmak için <Blue: {s1} × {s2}> harcansın mı?"
  },
  TipsType_10916_LeftBtnDesc = {Text = "İptal"},
  TipsType_10916_RightBtnDesc = {Text = "Onayla"},
  TipsType_10916_Title = {
    Text = "Kilidi Açma Onayı"
  },
  TipsType_10917_Desc = {
    Text = "{s1} Kilitli Değil"
  },
  TipsType_10918_Desc = {
    Text = "{s1} kilidi açıldı. Tüm Dizilimlerin kilidi açıldı."
  },
  TipsType_10919_Desc = {
    Text = "[{s1}: {s2}] tamamlandıktan sonra açılır. Şimdi [{s1}] konumuna gidilsin mi?"
  },
  TipsType_10919_LeftBtnDesc = {Text = "İptal"},
  TipsType_10919_RightBtnDesc = {Text = "Onayla"},
  TipsType_10919_Title = {
    Text = "Kilitli Değil"
  },
  TipsType_10920_Desc = {
    Text = "Süreli \"Faz Tersine Çevirme\" etkinliğinde \"Sihirli Palamut\" × {s1} biriktirerek kilidi aç. \"Faz Tersine Çevirme\"ye gitmek istiyor musun?"
  },
  TipsType_10920_LeftBtnDesc = {Text = "İptal"},
  TipsType_10920_RightBtnDesc = {Text = "Onayla"},
  TipsType_10920_Title = {
    Text = "Kilitli Değil"
  },
  TipsType_10921_Desc = {
    Text = "Aynı niteliğe sahip iki Kader Çarkı aynı anda kuşanılamaz."
  },
  TipsType_20001_Desc = {
    Text = "Onay Kutulu Çift Doğrulama ile"
  },
  TipsType_20001_LeftBtnDesc = {Text = "Onayla"},
  TipsType_20001_Title = {Text = "Unvan"},
  TipsType_20002_Desc = {
    Text = "Onay Kutulu Çift Doğrulama olmadan"
  },
  TipsType_20002_LeftBtnDesc = {Text = "İptal"},
  TipsType_20002_RightBtnDesc = {Text = "Onayla"},
  TipsType_20002_Title = {Text = "Unvan"},
  TipsType_20003_Desc = {
    Text = "Hesabınız başka bir cihazda oturum açtı."
  },
  TipsType_20003_RightBtnDesc = {Text = "Onayla"},
  TipsType_20003_Title = {
    Text = "Bağlantı Kesilmesi İpucu"
  },
  TipsType_20004_Desc = {
    Text = "Sunucuyla bağlantı kesildi. Lütfen yeniden giriş yapın."
  },
  TipsType_20004_RightBtnDesc = {Text = "Onayla"},
  TipsType_20004_Title = {
    Text = "Bağlantı Kesilmesi İpucu"
  },
  TipsType_20005_Desc = {
    Text = "Senkronizasyon Başarısız. Yeniden denensin mi?"
  },
  TipsType_20005_LeftBtnDesc = {Text = "İptal"},
  TipsType_20005_RightBtnDesc = {Text = "Onayla"},
  TipsType_20005_Title = {
    Text = "Senkronizasyon Başarısız"
  },
  TipsType_20006_Desc = {
    Text = "Senkron kayboldu, daha sonra giriş ekranına dönülecek."
  },
  TipsType_20006_RightBtnDesc = {Text = "Onayla"},
  TipsType_20006_Title = {
    Text = "Senkronizasyon Başarısız"
  },
  TipsType_20007_Desc = {
    Text = "Senkron kayboldu, daha sonra giriş ekranına dönülecek."
  },
  TipsType_20007_RightBtnDesc = {Text = "Onayla"},
  TipsType_20007_Title = {
    Text = "Senkronizasyon Başarısız"
  },
  TipsType_20008_Desc = {
    Text = "Bu Soruşturma <Positive:{s1}> Dayanıklılığa mal olur. Bitirmek istediğinizden emin misiniz?"
  },
  TipsType_20008_LeftBtnDesc = {Text = "İptal"},
  TipsType_20008_RightBtnDesc = {Text = "Onayla"},
  TipsType_20008_Title = {
    Text = "Keşfi Sonlandır"
  },
  TipsType_20009_Desc = {
    Text = "Yenileme, Yakarışları ve Kalıntıları güncelleyecek. Uyandırıcı Uyanışları ve Komut Kartı satış sayıları sıfırlanmayacak. Onaylıyor musunuz?"
  },
  TipsType_20009_LeftBtnDesc = {Text = "İptal"},
  TipsType_20009_RightBtnDesc = {Text = "Onayla"},
  TipsType_20009_Title = {
    Text = "Yenilemeyi Onayla"
  },
  TipsType_20010_Desc = {
    Text = "Bu Diyar’daki Uyandırıcı sayısı yetersiz. Takımı oluşturmaya devam etmek istiyor musunuz?"
  },
  TipsType_20010_LeftBtnDesc = {Text = "İptal"},
  TipsType_20010_RightBtnDesc = {Text = "Onayla"},
  TipsType_20011_Desc = {
    Text = "Hiç Uyandırıcı seçilmedi, kadro Saklanmayacak."
  },
  TipsType_20011_LeftBtnDesc = {
    Text = "Çıkışı Onayla"
  },
  TipsType_20011_RightBtnDesc = {
    Text = "Dizilişe Devam Et"
  },
  TipsType_20012_Desc = {
    Text = "Hiçbir Uyandıran Seçilmedi"
  },
  TipsType_20012_RightBtnDesc = {Text = "Onayla"},
  TipsType_20013_Desc = {
    Text = "Diziliş eksik. Yine de başlansın mı?"
  },
  TipsType_20013_LeftBtnDesc = {Text = "Dönüş"},
  TipsType_20013_RightBtnDesc = {Text = "Yola Çık"},
  TipsType_20014_Desc = {
    Text = "Takım sınırına ulaşıldı."
  },
  TipsType_20014_RightBtnDesc = {Text = "Onayla"},
  TipsType_20015_Desc = {
    Text = "Bu Takım silinsin mi?"
  },
  TipsType_20015_LeftBtnDesc = {Text = "İptal"},
  TipsType_20015_RightBtnDesc = {Text = "Onayla"},
  TipsType_20016_Desc = {
    Text = "{s1} Tamamlandıktan sonra Kilit Açılır"
  },
  TipsType_20016_RightBtnDesc = {Text = "Onayla"},
  TipsType_20017_Desc = {
    Text = "Burada harita bilgilerini ve yenilmiş Canavar bilgilerini görebilirsiniz. Bu özellik mevcut sürümde henüz Alınabilir değil."
  },
  TipsType_20017_RightBtnDesc = {Text = "Onayla"},
  TipsType_20018_Desc = {
    Text = "Aşama Kilidi Açma Koşulları Henüz Karşılanmadı"
  },
  TipsType_20018_RightBtnDesc = {Text = "Onayla"},
  TipsType_20018_Title = {
    Text = "Hızlı Anket"
  },
  TipsType_20019_Desc = {
    Text = "\"Gümüş\" yetersiz. Mağazaya gidip daha fazla satın almak ister misin?"
  },
  TipsType_20019_LeftBtnDesc = {Text = "İptal"},
  TipsType_20019_RightBtnDesc = {Text = "İlerle"},
  TipsType_20020_Desc = {
    Text = "Gelişmiş {s1} tamamlandıktan sonra bu ileri zorluk seviyesini kilidini açın."
  },
  TipsType_20020_RightBtnDesc = {Text = "Onayla"},
  TipsType_20021_Desc = {
    Text = "Normal Modu tamamladıktan sonra {s1} Gelişmiş Eğitimi Kilidi Açılır."
  },
  TipsType_20021_RightBtnDesc = {Text = "Onayla"},
  TipsType_20022_Desc = {
    Text = "\"Gümüş\" yetersiz. Satın alma işlemine devam etmek ister misin"
  },
  TipsType_20022_LeftBtnDesc = {Text = "İptal"},
  TipsType_20022_RightBtnDesc = {Text = "Onayla"},
  TipsType_20022_Title = {
    Text = "Gümüş yetersiz"
  },
  TipsType_20023_Desc = {
    Text = "Bu Yükseltme, {s1} EXP’yi İsraf edecek (geri ödeme yoktur) ve karakterler Seviye sınırına ulaştıktan sonra EXP kazanamaz. Devam etmek istiyor musunuz?"
  },
  TipsType_20023_LeftBtnDesc = {Text = "İptal"},
  TipsType_20023_RightBtnDesc = {Text = "Onayla"},
  TipsType_20024_Desc = {
    Text = "Grup tam değil ve instansa giremez."
  },
  TipsType_20024_RightBtnDesc = {Text = "Onayla"},
  TipsType_20026_Desc = {
    Text = "Aliemus Dolumu onaylansın mı?"
  },
  TipsType_20026_LeftBtnDesc = {Text = "İptal"},
  TipsType_20026_RightBtnDesc = {Text = "Onayla"},
  TipsType_20027_Desc = {
    Text = "HP yenilemeyi onaylıyor musun?"
  },
  TipsType_20027_LeftBtnDesc = {Text = "İptal"},
  TipsType_20027_RightBtnDesc = {Text = "Onayla"},
  TipsType_20028_Desc = {
    Text = "Bu pencereyi kapatmak, [{s1}] hakkından vazgeçmenize neden olacak. Yine de devam edilsin mi?"
  },
  TipsType_20028_LeftBtnDesc = {Text = "İptal"},
  TipsType_20028_RightBtnDesc = {Text = "Onayla"},
  TipsType_20029_Desc = {
    Text = "Bu ekranı kapatırsan mevcut etkinlik atlanacak (Kalıntı kaldırılmayacak). Onaylıyor musun?"
  },
  TipsType_20029_LeftBtnDesc = {Text = "İptal"},
  TipsType_20029_RightBtnDesc = {Text = "Onayla"},
  TipsType_20030_Desc = {
    Text = "Seçilen Kalıntılar devredilmeyecek. Mirastan vazgeçilsin mi?"
  },
  TipsType_20030_LeftBtnDesc = {Text = "İptal"},
  TipsType_20030_RightBtnDesc = {Text = "Onayla"},
  TipsType_20031_Desc = {
    Text = "Savaştan çıkılsın mı?"
  },
  TipsType_20031_LeftBtnDesc = {Text = "İptal"},
  TipsType_20031_RightBtnDesc = {Text = "Onayla"},
  TipsType_20032_Desc = {
    Text = "Mevcut seviye henüz kilitli. Koruyucu Seviyesini tamamlayarak kilidini açmak ister misiniz?"
  },
  TipsType_20032_LeftBtnDesc = {Text = "İptal"},
  TipsType_20032_RightBtnDesc = {Text = "Onayla"},
  TipsType_20032_Title = {
    Text = "Kilitli Değil"
  },
  TipsType_20033_Desc = {
    Text = "Meydan okuma denemeleri yetersiz. Sıfırlamak için 500 Gümüş harcansın mı?"
  },
  TipsType_20033_LeftBtnDesc = {Text = "İptal"},
  TipsType_20033_RightBtnDesc = {Text = "Onayla"},
  TipsType_20034_Desc = {
    Text = "Mevcut meydan okuma bekleme süresinde. Sıfırlamak için \"Gümüş\" × 50 harcamak istiyor musun?"
  },
  TipsType_20034_LeftBtnDesc = {Text = "İptal"},
  TipsType_20034_RightBtnDesc = {Text = "Onayla"},
  TipsType_20035_Desc = {
    Text = "Önerilen Seviye {s1}, mevcut ekibin ortalama Seviyesi {s2}. Soruşturma engellerle karşılaşacak. Devam etmek istiyor musun?"
  },
  TipsType_20035_LeftBtnDesc = {Text = "İptal"},
  TipsType_20035_RightBtnDesc = {Text = "Onayla"},
  TipsType_20035_Title = {
    Text = "Düşük Güç"
  },
  TipsType_20036_Desc = {
    Text = "Mevcut süpürme sayısı {s1} olarak ayarlı, ancak zindana meydan okumak yalnızca {s2} dayanıklılık harcayarak 1 ödül kazandıracak. Yine de devam edilsin mi?"
  },
  TipsType_20036_LeftBtnDesc = {Text = "İptal"},
  TipsType_20036_RightBtnDesc = {Text = "Onayla"},
  TipsType_20036_Title = {
    Text = "Meydan Okumayı Onayla"
  },
  TipsType_20037_Desc = {
    Text = "Geliştirme malzemeleri arasında ileri seviye malzemeler de var. Geliştirme yapmak istediğinden emin misin?"
  },
  TipsType_20037_LeftBtnDesc = {Text = "İptal"},
  TipsType_20037_RightBtnDesc = {Text = "Onayla"},
  TipsType_20037_Title = {
    Text = "Geliştirmeyi Onayla"
  },
  TipsType_20038_Desc = {
    Text = "Bu ekipman şu anda kilitli. Kilidi açmak ister misin?"
  },
  TipsType_20038_LeftBtnDesc = {Text = "İptal"},
  TipsType_20038_RightBtnDesc = {Text = "Onayla"},
  TipsType_20039_Desc = {
    Text = "Soruşturma başarısız olacak ve sonraki tüm ödüllerden feragat edilecektir. Yine de devam edilsin mi?"
  },
  TipsType_20039_LeftBtnDesc = {Text = "İptal"},
  TipsType_20039_RightBtnDesc = {Text = "Onayla"},
  TipsType_20039_Title = {Text = "Çık"},
  TipsType_20040_Desc = {
    Text = "<WeaponEffect_Num:Şimdi çıkmak sana {s1} Menofin'e mal olacak.> Soruşturma başarısız olacak ve sonraki tüm ödüllerden feragat edilecektir. Yine de devam edilsin mi?"
  },
  TipsType_20040_LeftBtnDesc = {Text = "İptal"},
  TipsType_20040_RightBtnDesc = {Text = "Onayla"},
  TipsType_20040_Title = {Text = "Çık"},
  TipsType_20041_BottomDesc = {
    Text = "Mevcut Zaman Sıkıştırma İzni Sayısı: {s1}"
  },
  TipsType_20041_Desc = {
    Text = "Hızlandırmak için {s1} Zaman Sıkıştırma İzni harcansın mı?"
  },
  TipsType_20041_LeftBtnDesc = {Text = "İptal"},
  TipsType_20041_RightBtnDesc = {Text = "Onayla"},
  TipsType_20041_Title = {
    Text = "Hızlandırmayı Onayla"
  },
  TipsType_20042_Desc = {
    Text = "RPG savaş ayarlaması devam ediyor, şu anda doğrudan zafer olarak sonuçlanıyor"
  },
  TipsType_20042_LeftBtnDesc = {Text = "İptal"},
  TipsType_20042_RightBtnDesc = {Text = "Onayla"},
  TipsType_20043_Desc = {
    Text = "Mevcut görevi yenilemek için {s1} Gümüş harcansın mı?"
  },
  TipsType_20043_LeftBtnDesc = {Text = "İptal"},
  TipsType_20043_RightBtnDesc = {Text = "Onayla"},
  TipsType_20043_Title = {
    Text = "Görevi Yenile"
  },
  TipsType_20044_BottomDesc = {
    Text = "Tüketilecek: {s1} araştırma izni"
  },
  TipsType_20044_Desc = {
    Text = "{s1} üzerinde araştırma yapılsın mı?\nAraştırma Etkisi: {s2}"
  },
  TipsType_20044_LeftBtnDesc = {Text = "İptal"},
  TipsType_20044_RightBtnDesc = {Text = "Onayla"},
  TipsType_20044_Title = {
    Text = "Araştırmayı Onayla"
  },
  TipsType_20045_BottomDesc = {
    Text = "Araştırmayı iptal etmek, şimdiye dek kaydedilen ilerlemenin Saklanmasını sağlamaz."
  },
  TipsType_20045_Desc = {
    Text = "{s1} üzerindeki araştırma iptal edilsin mi? (Tüm Araştırma İzinleri iade edilecektir.)"
  },
  TipsType_20045_LeftBtnDesc = {Text = "İptal"},
  TipsType_20045_RightBtnDesc = {Text = "Onayla"},
  TipsType_20045_Title = {
    Text = "Araştırmayı İptal Et"
  },
  TipsType_20046_Desc = {
    Text = "Hızlandırmak için {s1} \"Gümüş\" harcansın mı?"
  },
  TipsType_20046_LeftBtnDesc = {Text = "İptal"},
  TipsType_20046_RightBtnDesc = {Text = "Onayla"},
  TipsType_20046_Title = {
    Text = "Hızlandırmayı Onayla"
  },
  TipsType_20047_Desc = {
    Text = "{s1} <Blue:\"{s2}\"> eksik, satın almak için <Blue:\"Gümüş\"×{s3}> harcansın mı?"
  },
  TipsType_20047_LeftBtnDesc = {Text = "İptal"},
  TipsType_20047_RightBtnDesc = {Text = "Onayla"},
  TipsType_20047_Title = {
    Text = "Satın Alma Onayı"
  },
  TipsType_20048_Desc = {
    Text = "{s1} <Blue:\"{s2}\"> eksik, satın almak için <Blue:\"Gümüş\"×{s3}> harcansın mı?"
  },
  TipsType_20048_LeftBtnDesc = {Text = "İptal"},
  TipsType_20048_RightBtnDesc = {Text = "Onayla"},
  TipsType_20048_Title = {
    Text = "Satın Alma Onayı"
  },
  TipsType_20049_Desc = {
    Text = "<Blue:\"{s1}\"> hâlihazırda <Blue:\"{s2}\"> tarafından kuşanılmış. Yedeği onaylıyor musun?"
  },
  TipsType_20049_LeftBtnDesc = {Text = "İptal"},
  TipsType_20049_RightBtnDesc = {Text = "Onayla"},
  TipsType_20049_Title = {
    Text = "İpucunu Değiştir"
  },
  TipsType_20050_Desc = {
    Text = "Kullandığın Kader Çarkı Yükseliş geçirdi. Devam edilsin mi?"
  },
  TipsType_20050_LeftBtnDesc = {Text = "İptal"},
  TipsType_20050_RightBtnDesc = {Text = "Onayla"},
  TipsType_20050_Title = {Text = "Duyuru"},
  TipsType_20051_Desc = {
    Text = "Yükseliş rütbesi üst sınıra ulaşacak. Fazla Yükselişler buna göre iade edilecek. Devam edilsin mi?"
  },
  TipsType_20051_LeftBtnDesc = {Text = "İptal"},
  TipsType_20051_RightBtnDesc = {Text = "Onayla"},
  TipsType_20051_Title = {Text = "Duyuru"},
  TipsType_20052_Desc = {
    Text = "Önerilen Seviye {s1}, mevcut ekibin ortalama Seviyesi {s2}. Soruşturma ciddi engellerle karşılaşacak. Yine de devam edilsin mi?"
  },
  TipsType_20052_LeftBtnDesc = {Text = "İptal"},
  TipsType_20052_RightBtnDesc = {Text = "Onayla"},
  TipsType_20052_Title = {
    Text = "Düşük Güç"
  },
  TipsType_20053_Desc = {
    Text = "Önerilen Seviye {s1}, mevcut ekibin ortalama Seviyesi {s2}. Soruşturma aşırı engellerle karşılaşacak. Yine de devam edilsin mi?"
  },
  TipsType_20053_LeftBtnDesc = {Text = "İptal"},
  TipsType_20053_RightBtnDesc = {Text = "Onayla"},
  TipsType_20053_Title = {
    Text = "Düşük Güç"
  },
  TipsType_20054_Desc = {
    Text = "Tüm meydan okuma ödülleri alındı. Meydan okumaya devam etmek ek ödül kazandırmayacak. Yine de devam edilsin mi?"
  },
  TipsType_20054_LeftBtnDesc = {Text = "İptal"},
  TipsType_20054_RightBtnDesc = {Text = "Onayla"},
  TipsType_20054_Title = {
    Text = "Meydan Okumayı Onayla"
  },
  TipsType_20055_Desc = {
    Text = "Sıfırlama, bu aşama için kazanılan tüm Yıldızları silecek ve Uyandırıcı savaş kayıtlarını yok edecek. Sıfırlamayı onaylıyor musun?"
  },
  TipsType_20055_LeftBtnDesc = {Text = "İptal"},
  TipsType_20055_RightBtnDesc = {Text = "Onayla"},
  TipsType_20055_Title = {
    Text = "Sıfırlamayı Onayla"
  },
  TipsType_20056_Desc = {
    Text = "Zafer kazanıldığında, mevcut dizilimdeki 4 Uyandırıcı başka hiçbir {s1} Aşamasına katılamayacak. Meydan okumayı onaylıyor musun?"
  },
  TipsType_20056_LeftBtnDesc = {Text = "İptal"},
  TipsType_20056_RightBtnDesc = {Text = "Onayla"},
  TipsType_20056_Title = {
    Text = "Meydan Okumayı Onayla"
  },
  TipsType_20057_Desc = {
    Text = "Ekip bileşimi, Akademi El Kitabı’ndaki önerilen yönergelere aykırı. Yine de meydan okumaya devam etmek istiyor musun?"
  },
  TipsType_20057_LeftBtnDesc = {Text = "İptal"},
  TipsType_20057_RightBtnDesc = {Text = "Onayla"},
  TipsType_20057_Title = {
    Text = "Dizilimi Onayla"
  },
  TipsType_20058_Desc = {
    Text = "Mevcut Aşama başarıyla tamamlandı. Ona yeniden meydan okumak için, mevcut Aşama ilerlemesini 0 yıldıza sıfırlaman gerekiyor. Uyandırıcı’nın savaş kaydı da silinecek. Sıfırlamayı onaylıyor musun?"
  },
  TipsType_20058_LeftBtnDesc = {Text = "İptal"},
  TipsType_20058_RightBtnDesc = {Text = "Onayla"},
  TipsType_20058_Title = {
    Text = "Sıfırlamayı Onayla"
  },
  TipsType_20059_Desc = {
    Text = "Mevcut ekipte 4 Uyandırıcı yok ve Savaş’a girilemiyor."
  },
  TipsType_20059_Title = {
    Text = "Dizilimi Kaydet"
  },
  TipsType_20060_BottomDesc = {
    Text = "Onayladıktan sonra yeniden Uyanış gerçekleştiremeyeceksiniz."
  },
  TipsType_20060_Desc = {
    Text = "Bu Uyanış sonucunu seçtiğinizi onaylıyor musunuz? (bu Uyanıştan tüm Uyananları ve Kader Çarklarını elde edeceksiniz)"
  },
  TipsType_20060_LeftBtnDesc = {Text = "İptal"},
  TipsType_20060_RightBtnDesc = {Text = "Onayla"},
  TipsType_20060_Title = {
    Text = "Seçimi Onayla"
  },
  TipsType_20061_BottomDesc = {
    Text = "Mevcut Gümüş: {s1}"
  },
  TipsType_20061_Desc = {
    Text = "Tekrar Uyanış için {s1} \"Gümüş\" harcansın mı?\nYeniden Uyanış, mevcut Çekme Destesi sonuçlarını Saklamayacak."
  },
  TipsType_20061_LeftBtnDesc = {Text = "İptal"},
  TipsType_20061_RightBtnDesc = {Text = "Onayla"},
  TipsType_20061_Title = {Text = "Uyanış"},
  TipsType_20062_Desc = {
    Text = "Okunmuş tüm postalar silinsin mi?\nAlınmamış ekleri olan postalar silinmeyecek."
  },
  TipsType_20062_LeftBtnDesc = {Text = "İptal"},
  TipsType_20062_RightBtnDesc = {Text = "Onayla"},
  TipsType_20062_Title = {
    Text = "Okunanları Sil"
  },
  TipsType_20063_Desc = {
    Text = "Silme Onaylansın mı?"
  },
  TipsType_20063_LeftBtnDesc = {Text = "İptal"},
  TipsType_20063_RightBtnDesc = {Text = "Onayla"},
  TipsType_20063_Title = {
    Text = "Geçerli Postayı Sil"
  },
  TipsType_20064_Desc = {
    Text = "Hatıra Kutusu’ndan silinen postalar geri getirilemez.\nBu postayı silmek istiyor musun?"
  },
  TipsType_20064_LeftBtnDesc = {Text = "İptal"},
  TipsType_20064_RightBtnDesc = {Text = "Onayla"},
  TipsType_20064_Title = {
    Text = "Mektupları Sil"
  },
  TipsType_20065_Desc = {
    Text = "<Blue:{s1}> harcayarak <Blue:{s2}> üretmeyi onaylıyor musun?"
  },
  TipsType_20065_LeftBtnDesc = {Text = "İptal"},
  TipsType_20065_RightBtnDesc = {Text = "Onayla"},
  TipsType_20065_Title = {
    Text = "Sentezi Onayla"
  },
  TipsType_20066_Desc = {
    Text = "<Blue:{s1} sökülerek {s2} alınmasını> onaylıyor musun?"
  },
  TipsType_20066_LeftBtnDesc = {Text = "İptal"},
  TipsType_20066_RightBtnDesc = {Text = "Onayla"},
  TipsType_20066_Title = {
    Text = "Sökme İşlemini Onayla"
  },
  TipsType_20067_Desc = {
    Text = "<Blue:{s1}> SSR Ahit harcayarak <Blue:{s2}> <Blue:{s3}> yeniden basmayı onaylıyor musun?"
  },
  TipsType_20067_LeftBtnDesc = {Text = "İptal"},
  TipsType_20067_RightBtnDesc = {Text = "Onayla"},
  TipsType_20067_Title = {
    Text = "Yeniden Yakarışı Onayla"
  },
  TipsType_20068_Desc = {
    Text = "Tüm Uyananlar devrildi.\n\nEy yalnız Koruyucu,\nŞimdi neyi seçeceksin?"
  },
  TipsType_20068_LeftBtnDesc = {
    Text = "Savaşı Yeniden Dene"
  },
  TipsType_20068_RightBtnDesc = {
    Text = "Geçici Geri Çekilme"
  },
  TipsType_20068_Title = {
    Text = "Soruşturma Başarısız"
  },
  TipsType_20069_Desc = {
    Text = "Şu anda seçili Uyanışçı’nın Aliemus’u dolu. Yine de bu Uyanışçı’yı seçmek istediğinden emin misin?"
  },
  TipsType_20069_LeftBtnDesc = {Text = "İptal"},
  TipsType_20069_RightBtnDesc = {Text = "Onayla"},
  TipsType_20069_Title = {
    Text = "Seçimi Onayla"
  },
  TipsType_20070_Desc = {
    Text = "{s1} kullanmak istediğinden emin misin?\nUyanışçı üzerinde hâlihazırda yükseltilmiş seviye ve beceriler iade edilmeyecektir."
  },
  TipsType_20070_LeftBtnDesc = {Text = "İptal"},
  TipsType_20070_RightBtnDesc = {Text = "Onayla"},
  TipsType_20070_Title = {
    Text = "Geliştirmeyi Onayla"
  },
  TipsType_20071_Desc = {
    Text = "Koruyucu Seviyesi ile sınırlı olarak, Uyanışçı’nın seviyesi {s1} seviyesine yükseltilecektir. Eksik Yükseltme Envanteri iade edilmeyecektir. Devam edilsin mi?"
  },
  TipsType_20071_LeftBtnDesc = {Text = "İptal"},
  TipsType_20071_RightBtnDesc = {Text = "Onayla"},
  TipsType_20071_Title = {
    Text = "Geliştirmeyi Onayla"
  },
  TipsType_20072_Desc = {
    Text = "\"Bu bölümdeki tüm Hikaye atlanacak mı?\nNot: Hikayeyi izlemek için daha sonra bu Aşamaya tekrar girebilirsiniz.\""
  },
  TipsType_20072_LeftBtnDesc = {Text = "İptal"},
  TipsType_20072_RightBtnDesc = {Text = "Onayla"},
  TipsType_20072_Title = {
    Text = "Hikâyeyi Geç"
  },
  TipsType_20073_Desc = {
    Text = "Mevcut Ahit güçlendirildi ve onu parçalamak güçlendirme eşyalarını geri vermeyecek.\n{s2} elde etmek için {s1} çözünmesini onaylıyor musun?"
  },
  TipsType_20073_LeftBtnDesc = {Text = "İptal"},
  TipsType_20073_RightBtnDesc = {Text = "Onayla"},
  TipsType_20073_Title = {
    Text = "Sökme İşlemini Onayla"
  },
  TipsType_20074_Desc = {
    Text = "Seçili Kader Çarkı yüksek nadirlikte.\n{s2} elde etmek için {s1} çözünmesini onaylıyor musun?"
  },
  TipsType_20074_LeftBtnDesc = {Text = "İptal"},
  TipsType_20074_RightBtnDesc = {Text = "Onayla"},
  TipsType_20074_Title = {
    Text = "Sökme İşlemini Onayla"
  },
  TipsType_20075_BottomDesc = {
    Text = "Tüketilecek: {s1} araştırma izni"
  },
  TipsType_20075_Desc = {
    Text = "{s1} Araştırmasına Başla?\nÜretim Verimliliği: Her 6 saatte {s2} Rose Scrip\n     —>Her 6 saatte {s3} Rose Scrip"
  },
  TipsType_20075_LeftBtnDesc = {Text = "İptal"},
  TipsType_20075_RightBtnDesc = {Text = "Onayla"},
  TipsType_20075_Title = {
    Text = "Araştırmayı Onayla"
  },
  TipsType_20076_BottomDesc = {
    Text = "Tüketilecek: {s1} araştırma izni"
  },
  TipsType_20076_Desc = {
    Text = "{s1} üzerinde araştırma başlatılsın mı?\nÜretim Verimliliği: 6 saatte {s2} Gnosis İksiri\n     —>6 saatte {s3} Gnosis İksiri"
  },
  TipsType_20076_LeftBtnDesc = {Text = "İptal"},
  TipsType_20076_RightBtnDesc = {Text = "Onayla"},
  TipsType_20076_Title = {
    Text = "Araştırmayı Onayla"
  },
  TipsType_20077_BottomDesc = {
    Text = "Tüketilecek: {s1} araştırma izni"
  },
  TipsType_20077_Desc = {
    Text = "{s1} üzerinde araştırma başlatılsın mı?\nÜretim Verimliliği: 6 saatte {s2} Ahit İzleri\n     —>6 saatte {s3} Ahit İzleri"
  },
  TipsType_20077_LeftBtnDesc = {Text = "İptal"},
  TipsType_20077_RightBtnDesc = {Text = "Onayla"},
  TipsType_20077_Title = {
    Text = "Araştırmayı Onayla"
  },
  TipsType_20078_Desc = {
    Text = "\"Bu bölümdeki tüm Hikaye atlanacak mı?\nNot: Hikayeyi izlemek için daha sonra bu Aşamaya tekrar girebilirsiniz.\""
  },
  TipsType_20078_LeftBtnDesc = {Text = "İptal"},
  TipsType_20078_RightBtnDesc = {Text = "Onayla"},
  TipsType_20078_Title = {
    Text = "Hikâyeyi Geç"
  },
  TipsType_20079_Desc = {
    Text = "Gümüş Anahtar ölümcül bir kriz algılıyor. Acil Gnosis Birimi etkinleştirilsin mi?\n(Diriliş 1 Acil Gnosis Birimi tüketecektir. Her gün saat 9’da 1 adet alırsın. Kalan kullanım: {s1}/{s2})"
  },
  TipsType_20079_LeftBtnDesc = {Text = "İptal"},
  TipsType_20079_RightBtnDesc = {Text = "Onayla"},
  TipsType_20079_Title = {
    Text = "Şimdi Canlandır?"
  },
  TipsType_20080_Desc = {
    Text = "Gümüş Anahtar ölümcül bir kriz algılıyor. Acil Gnosis Birimi etkinleştirilsin mi?\n(Diriliş 1 Acil Gnosis Birimi tüketecektir. Her gün saat 9’da 1 adet alırsın. Kalan kullanım: {s1}/{s2})"
  },
  TipsType_20080_RightBtnDesc = {Text = "Onayla"},
  TipsType_20080_Title = {
    Text = "Şimdi Canlandır?"
  },
  TipsType_20081_Desc = {
    Text = "Oyun başlatılamadı. {s1}."
  },
  TipsType_20081_RightBtnDesc = {Text = "Onayla"},
  TipsType_20081_Title = {
    Text = "Giriş Hatası İpucu"
  },
  TipsType_20082_Desc = {
    Text = "<Blue: {s2} > seviye satın almak için <Blue:\"Gümüş\" × {s1} > harcamak ister misin?"
  },
  TipsType_20082_LeftBtnDesc = {Text = "İptal"},
  TipsType_20082_RightBtnDesc = {Text = "Onayla"},
  TipsType_20082_Title = {
    Text = "Seviye Atla"
  },
  TipsType_20083_Desc = {
    Text = "Kader Çarkı {s1} tüketilecek. Güçlendirmeyi onaylıyor musun?"
  },
  TipsType_20083_LeftBtnDesc = {Text = "İptal"},
  TipsType_20083_RightBtnDesc = {Text = "Onayla"},
  TipsType_20083_Title = {Text = "Onaylama"},
  TipsType_20084_Desc = {
    Text = "Ekibinizin ortalama seviyesi bu aşama için çok düşük. Soruşturma ciddi zorluklarla karşılaşabilir. Yine de devam edilsin mi?"
  },
  TipsType_20084_LeftBtnDesc = {
    Text = "Uyananları Geliştir"
  },
  TipsType_20084_RightBtnDesc = {Text = "Onayla"},
  TipsType_20084_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20085_Desc = {
    Text = "Çıkışı Onayla"
  },
  TipsType_20085_LeftBtnDesc = {Text = "İptal"},
  TipsType_20085_RightBtnDesc = {Text = "Onayla"},
  TipsType_20085_Title = {
    Text = "Oyundan Çık"
  },
  TipsType_20086_Desc = {
    Text = "Sunucu Bakımda"
  },
  TipsType_20086_RightBtnDesc = {Text = "Onayla"},
  TipsType_20086_Title = {
    Text = "Bağlantı Kesilmesi İpucu"
  },
  TipsType_20087_Desc = {
    Text = "<TipsHighlightText:{s3}> kilidini açmak için <TipsHighlightText:{s1} × {s2}> harcamayı onaylıyor musun?"
  },
  TipsType_20087_LeftBtnDesc = {Text = "İptal"},
  TipsType_20087_RightBtnDesc = {Text = "Onayla"},
  TipsType_20087_Title = {
    Text = "Etkinleştirmeyi Onayla"
  },
  TipsType_20088_Desc = {
    Text = "Alım yaptıktan sonra \"Menofin\" Taşma durumuna geçecek ve {s1} değerini aşan miktar elde edilemeyecek.\nAlmaya devam etmek istiyor musun?"
  },
  TipsType_20088_LeftBtnDesc = {Text = "İptal"},
  TipsType_20088_RightBtnDesc = {Text = "Onayla"},
  TipsType_20088_Title = {
    Text = "Menofin Taşması"
  },
  TipsType_20089_Desc = {
    Text = "Envanteri yenilemek için <Blue:{s1}> Gül Senedi harca\nKalan yenileme sayısı: <Blue:{s2}>\nYenileme sayısı arttıkça, gereken Gül Senedi miktarı da artar."
  },
  TipsType_20089_LeftBtnDesc = {Text = "İptal"},
  TipsType_20089_RightBtnDesc = {Text = "Onayla"},
  TipsType_20089_Title = {
    Text = "Stoğu Yenile"
  },
  TipsType_20090_Desc = {
    Text = "Kader Çarkı sayısı sınıra ulaştı. Uyandırma işlemi için önce bazı Kader Çarklarını temizlemeniz gerekiyor. Oraya gitmek ister misiniz?\n\n<color=#ADC0CB>*SR/R sınıfı Kader Çarklarını \"Ayarlar\" bölümünden otomatik sökülecek şekilde ayarlayabilirsiniz.</color>"
  },
  TipsType_20090_LeftBtnDesc = {Text = "İptal"},
  TipsType_20090_RightBtnDesc = {
    Text = "Şimdi Temizle"
  },
  TipsType_20090_Title = {
    Text = "Temizlik İpucu"
  },
  TipsType_20091_Desc = {
    Text = "Ahit sınırına ulaşıldı. Soruşturmadan önce bazı Ahitleri temizlemeniz gerekiyor. Devam edilsin mi?"
  },
  TipsType_20091_LeftBtnDesc = {Text = "İptal"},
  TipsType_20091_RightBtnDesc = {
    Text = "Şimdi Temizle"
  },
  TipsType_20091_Title = {
    Text = "Temizlik İpucu"
  },
  TipsType_20092_Desc = {
    Text = "Geçerli Uyandırıcının donanımından tüm Kader Çarklarını çıkarmak istediğinizden emin misiniz?"
  },
  TipsType_20092_LeftBtnDesc = {Text = "İptal"},
  TipsType_20092_RightBtnDesc = {Text = "Onayla"},
  TipsType_20092_Title = {
    Text = "Ekipmanı Çıkarmayı Onayla"
  },
  TipsType_20093_Desc = {
    Text = "Tüketilecek Ahit Yükseltme geçirmiş. Onaylıyor musunuz?"
  },
  TipsType_20093_LeftBtnDesc = {Text = "İptal"},
  TipsType_20093_RightBtnDesc = {Text = "Onayla"},
  TipsType_20093_Title = {
    Text = "Yükseltmeyi Onayla"
  },
  TipsType_20094_Desc = {
    Text = "Bu Ahit’te kilitlenmemiş bir Azami-Değer Alt Özelliği var. Devam ederseniz üzerine yazılacak."
  },
  TipsType_20094_LeftBtnDesc = {Text = "İptal"},
  TipsType_20094_RightBtnDesc = {Text = "Onayla"},
  TipsType_20094_Title = {
    Text = "Alt Özellikler Değiştirilsin mi?"
  },
  TipsType_20095_Desc = {
    Text = "Beklemede bir Azami-Değer Alt Özelliği var. Yazıma devam ederseniz kaybolacak."
  },
  TipsType_20095_LeftBtnDesc = {Text = "İptal"},
  TipsType_20095_RightBtnDesc = {Text = "Onayla"},
  TipsType_20095_Title = {
    Text = "Yazıya Dökmeye Devam Edilsin mi?"
  },
  TipsType_20096_Desc = {
    Text = "Bu Ahit'i yükseltmek seviye sınırını aşacaktır. Fazla kısım transkripsiyon malzemesi olarak iade edilecektir. Onaylıyor musunuz?"
  },
  TipsType_20096_LeftBtnDesc = {Text = "İptal"},
  TipsType_20096_RightBtnDesc = {Text = "Onayla"},
  TipsType_20096_Title = {
    Text = "Yükseltmeyi Onayla"
  },
  TipsType_20097_Desc = {
    Text = "Bu Uyandırıcı tamamen Aydınlanmış.\nSeçimden sonra yalnızca \"Gnosis Parçası\" × 3 ve \"Rafine Gnosis Parçası\" ×1 alacaksın."
  },
  TipsType_20097_LeftBtnDesc = {Text = "İptal"},
  TipsType_20097_RightBtnDesc = {Text = "Devam et"},
  TipsType_20097_Title = {
    Text = "Seçimi Onayla"
  },
  TipsType_20098_Desc = {
    Text = "Bu eşya <Blue:{s1}> Mithril Ticaret Belgesi kullanılarak satın alınabilir"
  },
  TipsType_20098_LeftBtnDesc = {
    Text = "Nakit Ödeme"
  },
  TipsType_20098_RightBtnDesc = {
    Text = "Kuponla Ödeme"
  },
  TipsType_20098_Title = {
    Text = "Yerleşim Yöntemi"
  },
  TipsType_20099_Desc = {
    Text = "Oyundan çıkılsın mı?"
  },
  TipsType_20099_LeftBtnDesc = {Text = "İptal"},
  TipsType_20099_RightBtnDesc = {Text = "Onayla"},
  TipsType_20099_Title = {
    Text = "Soruşturma Devam Ediyor"
  },
  TipsType_20100_Desc = {
    Text = "Yeni bir oyun sürümü tespit edildi. Kaynakları güncellemek için lütfen oyunu yeniden başlat."
  },
  TipsType_20100_RightBtnDesc = {Text = "Onayla"},
  TipsType_20100_Title = {
    Text = "Güncelleme İpucu"
  },
  TipsType_20101_Desc = {
    Text = "Soruşturma tamamlandı. Hikâyeyi atlamak ister misiniz?"
  },
  TipsType_20101_LeftBtnDesc = {
    Text = "Hikâyeyi Geç"
  },
  TipsType_20101_RightBtnDesc = {
    Text = "Hikâyeyi Oku"
  },
  TipsType_20101_Title = {
    Text = "Hikâyeyi Onayla"
  },
  TipsType_20102_Desc = {
    Text = "{s1} hesabını takipten çıkarmak istediğinizden emin misiniz?"
  },
  TipsType_20102_LeftBtnDesc = {Text = "İptal"},
  TipsType_20102_RightBtnDesc = {Text = "Onayla"},
  TipsType_20102_Title = {
    Text = "Takibi Bırak"
  },
  TipsType_20103_Desc = {
    Text = "Etkinlik süresince <WeaponEffect_Num:ücretsiz olarak sınırlı süreli aç> kilidi. Kilidini açmak istiyor musun?"
  },
  TipsType_20103_LeftBtnDesc = {Text = "İptal"},
  TipsType_20103_RightBtnDesc = {Text = "Onayla"},
  TipsType_20103_Title = {
    Text = "Etkinlik Ödülleri"
  },
  TipsType_20105_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20105_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20105_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20105_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20106_Desc = {
    Text = "Satın almak için <Blue:\"Gümüş Çekirdek Özü\" ×  {s1} > harcansın mı?"
  },
  TipsType_20106_LeftBtnDesc = {Text = "İptal"},
  TipsType_20106_RightBtnDesc = {Text = "Satın Al"},
  TipsType_20106_Title = {
    Text = "Satın Alma Onayı"
  },
  TipsType_20107_Desc = {
    Text = "<Blue:{s1}> seçmek istediğinden emin misin?"
  },
  TipsType_20107_LeftBtnDesc = {Text = "İptal"},
  TipsType_20107_RightBtnDesc = {Text = "Onayla"},
  TipsType_20107_Title = {
    Text = "Seçimi Onayla"
  },
  TipsType_20108_Desc = {
    Text = "Bu eylem nadir eşya \"Zaman Döngüsü Kopyası\" nı tüketir.\nDevam edilsin mi?"
  },
  TipsType_20108_LeftBtnDesc = {Text = "İptal"},
  TipsType_20108_RightBtnDesc = {Text = "Onayla"},
  TipsType_20108_Title = {Text = "Onaylama"},
  TipsType_20109_Desc = {
    Text = "Bu savaşı yeniden başlatmak istediğinden emin misin?"
  },
  TipsType_20109_LeftBtnDesc = {Text = "İptal"},
  TipsType_20109_RightBtnDesc = {Text = "Onayla"},
  TipsType_20109_Title = {
    Text = "Savaşı Yeniden Dene"
  },
  TipsType_20110_Desc = {
    Text = "Doğum gününü {s1}/{s2} olarak ayarla?\nBu daha sonra değiştirilemez."
  },
  TipsType_20110_LeftBtnDesc = {Text = "İptal"},
  TipsType_20110_RightBtnDesc = {Text = "Onayla"},
  TipsType_20110_Title = {
    Text = "Doğum Günü Onayı"
  },
  TipsType_20111_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20111_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20111_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20111_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20112_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20112_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20112_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20112_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20113_Desc = {
    Text = "Tüm kilidi açılmış eğitimleri okundu olarak işaretleyip ödülleri almak istiyor musun? (Yeni Koruyucuların önce eğitimleri gözden geçirmesi Bugünün Önerisi~)"
  },
  TipsType_20113_LeftBtnDesc = {Text = "İptal"},
  TipsType_20113_RightBtnDesc = {Text = "Onayla"},
  TipsType_20113_Title = {
    Text = "Tümünü Okumayı Onayla"
  },
  TipsType_20114_Desc = {
    Text = "Gelişim Sıfırlamayı etkinleştirmek için <WeaponEffect_Num:{s1}> seçimini onaylıyor musun?\nBu işlem geri alınamaz. Lütfen dikkatle onayla."
  },
  TipsType_20114_LeftBtnDesc = {Text = "İptal"},
  TipsType_20114_RightBtnDesc = {Text = "Onayla"},
  TipsType_20114_Title = {
    Text = "Sıfırlama Seçimini Onayla"
  },
  TipsType_201151_Desc = {
    Text = "Mevcut Uyandırıcı Aydınlanma Sv.0'dadır. Aydınlanma Sıfırlama'ya gerek yok."
  },
  TipsType_20115_Desc = {
    Text = "Mevcut Uyandırıcı üzerinde hiçbir gelişim yapılmamış, bu yüzden Gelişim Sıfırlamaya gerek yok."
  },
  TipsType_20116_Desc = {
    Text = "<WeaponEffect_Num:{s1}>Gelişim Sıfırlama etkinleştirildi.\nSıfırlamaya şimdi devam etmek istiyor musun?"
  },
  TipsType_20116_LeftBtnDesc = {Text = "İptal"},
  TipsType_20116_RightBtnDesc = {Text = "İlerle"},
  TipsType_20116_Title = {
    Text = "Kilidi Açma Başarılı"
  },
  TipsType_20117_Desc = {
    Text = "Uyandırıcı'nın Seviye, Yüceltme, Beceri, Yetenek ve Gnostik İlerleme durumları sıfırlanır. Harcanan tüm Malzemeler iade edilir.\n<WeaponEffect_Num:{s1}> için Gelişim Sıfırlama'yı onaylıyor musun?"
  },
  TipsType_20117_LeftBtnDesc = {Text = "İptal"},
  TipsType_20117_RightBtnDesc = {Text = "Onayla"},
  TipsType_20117_Title = {
    Text = "Gelişim Sıfırlama"
  },
  TipsType_20118_Desc = {
    Text = "Uyandırıcı'nın Aydınlanma durumu sıfırlanır ve Aydınlanma maliyetleri iade edilir.\nAydınlanma Sıfırlama'yı onayla <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20118_LeftBtnDesc = {Text = "İptal"},
  TipsType_20118_RightBtnDesc = {Text = "Onayla"},
  TipsType_20118_Title = {
    Text = "Aydınlanma Sıfırlama"
  },
  TipsType_20119_Desc = {
    Text = "Uyandırıcı'nın Seviye, Yüceltme, Beceri, Yetenek, Aydınlanma ve Gnostik İlerleme durumları sıfırlanır. Bu Uyandırıcı Karanlık Havuz'a geri dönecektir.\n<WeaponEffect_Num:{s1}> için Yaratılış Dönüşü'nü onaylıyor musun?"
  },
  TipsType_20119_LeftBtnDesc = {Text = "İptal"},
  TipsType_20119_RightBtnDesc = {Text = "Onayla"},
  TipsType_20119_Title = {
    Text = "Yaratılış Dönüşü"
  },
  TipsType_20120_Desc = {
    Text = "Özel Uyandırıcılar sıfırlanamaz."
  },
  TipsType_20121_Desc = {
    Text = "Yükseliş durumu sıfırlanmak ve tüm maliyetler iade edilmek üzere.\n<WeaponEffect_Num:{s1}> için sıfırlamayı onaylıyor musun?"
  },
  TipsType_20121_LeftBtnDesc = {Text = "İptal"},
  TipsType_20121_RightBtnDesc = {Text = "Onayla"},
  TipsType_20121_Title = {
    Text = "Yığın İz Sürme"
  },
  TipsType_20122_Desc = {
    Text = "Yükseliş durumu sıfırlanmak, tüm maliyetler iade edilmek ve Kader Çarkı Köken Havuzu’na geri gönderilmek üzere.\n<WeaponEffect_Num:{s1}> için Yaratılış Dönüşü’nü onaylıyor musun?"
  },
  TipsType_20122_LeftBtnDesc = {Text = "İptal"},
  TipsType_20122_RightBtnDesc = {Text = "Onayla"},
  TipsType_20122_Title = {
    Text = "Yaratılış Dönüşü"
  },
  TipsType_20123_Desc = {
    Text = "Meydan okuma tamamlandıktan sonra, takımdaki Uyandırıcılar, Kader Çarkları ve Müfreze diğer Bölgesel D-Etkisi Yasak Bölgeleri’ne katılamayacak. Onaylıyor musun?"
  },
  TipsType_20123_LeftBtnDesc = {Text = "İptal"},
  TipsType_20123_RightBtnDesc = {Text = "Onayla"},
  TipsType_20123_Title = {
    Text = "Meydan Okumayı Onayla"
  },
  TipsType_20124_Desc = {
    Text = "Sıfırlamanın ardından, Soruşturma ekibindeki Uyandırıcılar, Kader Çarkı ve Anahtarlar yeniden görevlendirilebilir, ancak bu aşamadan kazanılan Eğitim Değeri düşülecektir."
  },
  TipsType_20124_LeftBtnDesc = {Text = "İptal"},
  TipsType_20124_RightBtnDesc = {Text = "Onayla"},
  TipsType_20124_Title = {
    Text = "Sıfırlamayı Onayla"
  },
  TipsType_20125_Desc = {
    Text = "Mevcut Kader Çarkı Yükseliş seviyesi 0, Yükseliş sıfırlamasına gerek yok."
  },
  TipsType_20126_Desc = {
    Text = "Şu anki Uyandırıcı bir Görevde. Sıfırlamadan ya da geri dönmeden önce lütfen onu geri çağır."
  },
  TipsType_20127_Desc = {
    Text = "Mevcut Kader Çarkı kilitli. Lütfen sıfırlamadan önce kilidi aç."
  },
  TipsType_20128_Desc = {
    Text = "{s1} tamamlandı. Yeniden denemek için sıfırlansın mı?\n(Sıfırlamanın ardından, Soruşturma ekibindeki Uyandırıcılar, Kader Çarkı ve Anahtarlar yeniden görevlendirilebilir, ancak bu aşamadan kazanılan Eğitim Değeri düşülecektir.)"
  },
  TipsType_20128_LeftBtnDesc = {Text = "İptal"},
  TipsType_20128_RightBtnDesc = {Text = "Onayla"},
  TipsType_20128_Title = {
    Text = "Sıfırlamayı Onayla"
  },
  TipsType_20129_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20129_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20129_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20129_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20130_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20130_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20130_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20130_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20131_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20131_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20131_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20131_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20132_Desc = {
    Text = "Yeterli <TipsHighlightText:Ahit Parçaları> alınabilir durumdaysa, öncelikle onlar kullanılacaktır.\nTedarik yetersizse, bunun yerine <TipsHighlightText:\"{s1}\"> tüketilecektir."
  },
  TipsType_20132_LeftBtnDesc = {Text = "İptal"},
  TipsType_20132_RightBtnDesc = {Text = "Onayla"},
  TipsType_20132_Title = {
    Text = "Otomatik İkame"
  },
  TipsType_20133_Desc = {
    Text = "<TipsHighlightText:\"{s1}\"> üzerinde Gnostik İlerleme gerçekleştirilsin mi?"
  },
  TipsType_20133_LeftBtnDesc = {Text = "İptal"},
  TipsType_20133_RightBtnDesc = {Text = "Onayla"},
  TipsType_20133_Title = {
    Text = "Gnostik İlerleme"
  },
  TipsType_20134_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20134_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20134_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20134_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20137_Desc = {
    Text = "Bu İz Düzenini <Blue:\"{s1}\"*{s2}> ile kilit aç?"
  },
  TipsType_20137_LeftBtnDesc = {Text = "İptal"},
  TipsType_20137_RightBtnDesc = {Text = "Onayla"},
  TipsType_20137_Title = {
    Text = "Kilidi Açma Onayı"
  },
  TipsType_20138_Desc = {
    Text = "Sınırlı süreliğine <Blue:Ücretsiz Kilit Açma>. Şimdi kilidini aç?"
  },
  TipsType_20138_LeftBtnDesc = {Text = "İptal"},
  TipsType_20138_RightBtnDesc = {Text = "Onayla"},
  TipsType_20138_Title = {
    Text = "Kilidi Açma Onayı"
  },
  TipsType_20139_Desc = {
    Text = "<Blue:\"{s2}\"> kilidini <Blue:\"{s1}\"*{s3}> ile aç?"
  },
  TipsType_20139_LeftBtnDesc = {Text = "İptal"},
  TipsType_20139_RightBtnDesc = {Text = "Onayla"},
  TipsType_20139_Title = {
    Text = "Kilidi Açma Onayı"
  },
  TipsType_20140_Desc = {
    Text = "<Blue:{s1}> sayısının azami sınırına ulaştın. Daha fazlasını almak ek eşya sağlamayacak. Yine de talep edilsin mi?"
  },
  TipsType_20140_LeftBtnDesc = {Text = "İptal"},
  TipsType_20140_RightBtnDesc = {Text = "Onayla"},
  TipsType_20140_Title = {
    Text = "Almayı Onayla"
  },
  TipsType_20141_Desc = {
    Text = "Maksimum Canının %30’unu ({s1}) harcayıp\nsavaşı atlayarak düşmanı anında yok etmek istiyor musun?\n\nMevcut Can: {s2}"
  },
  TipsType_20141_LeftBtnDesc = {Text = "İptal"},
  TipsType_20141_RightBtnDesc = {Text = "Onayla"},
  TipsType_20141_Title = {
    Text = "Kas Hafızası"
  },
  TipsType_20142_Desc = {
    Text = "<color=#BB646D>{s1}</color> HP tüketerek {s2} Kara Mühür elde edilsin mi?"
  },
  TipsType_20142_LeftBtnDesc = {Text = "İptal"},
  TipsType_20142_RightBtnDesc = {Text = "Onayla"},
  TipsType_20142_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20145_LeftBtnDesc = {Text = "İptal"},
  TipsType_20145_Title = {
    Text = "Giriş Ödülleri"
  },
  TipsType_20151_Desc = {
    Text = "Sıfırlamadan sonra, \"Özel Eşyalar\"ın kalan miktarı en yüksek değere sıfırlanacak. Emin misin?"
  },
  TipsType_20151_LeftBtnDesc = {Text = "İptal"},
  TipsType_20151_RightBtnDesc = {Text = "Onayla"},
  TipsType_20151_Title = {
    Text = "Sıfırlamayı Onayla"
  },
  TipsType_20152_Desc = {
    Text = "{s1} yetersiz, telafi için Gül Senedi *{s2} kullanılsın mı?"
  },
  TipsType_20152_LeftBtnDesc = {Text = "İptal"},
  TipsType_20152_RightBtnDesc = {Text = "Onayla"},
  TipsType_20152_Title = {
    Text = "Etkinleştirmeyi Onayla"
  },
  TipsType_20153_Desc = {
    Text = "Sıfırlamadan sonra, \"Özel Eşyalar\" ve \"Sıradan Eşyalar\"ın kalan miktarları en yüksek değere sıfırlanacak.\n{s1}. kezden itibaren \"Özel Eşyalar\" artık sıfırlanmayacak.\nEmin misin?"
  },
  TipsType_20153_LeftBtnDesc = {Text = "İptal"},
  TipsType_20153_RightBtnDesc = {Text = "Onayla"},
  TipsType_20153_Title = {
    Text = "Sıfırlamayı Onayla"
  },
  TipsType_20154_Desc = {
    Text = "Sıfırlamadan sonra, “Özel Eşyalar” ve “Sıradan Eşyalar”ın kalan miktarları en yüksek değere sıfırlanacak.\n3. kezden itibaren “Özel Eşyalar” artık sıfırlanmayacak.\n<Blue:“Sıradan Eşyalar”ın hâlâ elinde bulunuyor>, emin misin?"
  },
  TipsType_20154_LeftBtnDesc = {Text = "İptal"},
  TipsType_20154_RightBtnDesc = {Text = "Onayla"},
  TipsType_20154_Title = {
    Text = "Sıfırlamayı Onayla"
  },
  TipsType_20155_Desc = {
    Text = "Yükseliş malzemeleri arasında kilitli bir Kader Çarkı var. Yükseliş için onu tüketmeyi onaylıyor musun?"
  },
  TipsType_20155_LeftBtnDesc = {Text = "İptal"},
  TipsType_20155_RightBtnDesc = {Text = "Onayla"},
  TipsType_20155_Title = {
    Text = "Yükselişi Onayla"
  },
  TipsType_20156_Desc = {
    Text = "Kilidi açmak için <TipsHighlightText:Gerçeklik Sınırı*1> kullanmak istediğinden emin misin?\n(Şehvetli Arzular etkinliği sırasında, gereken Gerçeklik Sınırı sayısı {s1}’den {s2}’ye düşürülür.)"
  },
  TipsType_20156_LeftBtnDesc = {Text = "İptal"},
  TipsType_20156_RightBtnDesc = {Text = "Onayla"},
  TipsType_20156_Title = {
    Text = "Kilidi Açma Onayı"
  },
  TipsType_20157_Desc = {
    Text = "Kilidi açmak için <TipsHighlightText:Gerçeklik Sınırı*{s1}> kullanmak istediğinden emin misin?"
  },
  TipsType_20157_LeftBtnDesc = {Text = "İptal"},
  TipsType_20157_RightBtnDesc = {Text = "Onayla"},
  TipsType_20157_Title = {
    Text = "Kilidi Açma Onayı"
  },
  TipsType_20158_Desc = {
    Text = "Mevcut aşamanın süresi dolmuş. Tamamlasan bile ödül verilmeyecek. Çıkmak istiyor musun?"
  },
  TipsType_20158_LeftBtnDesc = {Text = "İptal"},
  TipsType_20158_RightBtnDesc = {Text = "Onayla"},
  TipsType_20158_Title = {
    Text = "Çıkış Onayı"
  },
  TipsType_20159_Desc = {
    Text = "<TipsHighlightText:\"{s1}\"> sınırı <TipsHighlightText: {s2}> aştı, her biri <Blue:\"Biçimsiz Olanın Davetiyesi\" × 1>e dönüştürülecek."
  },
  TipsType_20159_Title = {
    Text = "Dönüşüm İpucu"
  },
  TipsType_20160_Desc = {
    Text = "Şunu açtın: <TipsHighlightText:\"{s1}\">\nÜcretsiz açılış bonusu olarak aşağıdaki telafiyi alacaksın."
  },
  TipsType_20160_RightBtnDesc = {Text = "Onayla"},
  TipsType_20160_Title = {
    Text = "Tazminat İpucu"
  },
  TipsType_20161_Desc = {
    Text = "Sahip olduğun <TipsHighlightText:{s1}> miktarı <TipsHighlightText:{s2}> kadar taşmış durumda. Fazladan olan her bir eşya <Blue:Gül Senedi*5000>'e dönüştürüldü."
  },
  TipsType_20161_Title = {
    Text = "Dönüşüm İpucu"
  },
  TipsType_20162_Desc = {
    Text = "Uyandırıcı'nın Seviye, Yüceltme, Beceri, Yetenek ve Gnostik İlerleme durumları sıfırlanır. Harcanan tüm Malzemeler iade edilir.\n<WeaponEffect_Num:{s1}> için Gelişim Sıfırlama'yı onaylıyor musun?"
  },
  TipsType_20162_LeftBtnDesc = {Text = "İptal"},
  TipsType_20162_RightBtnDesc = {Text = "Onayla"},
  TipsType_20162_Title = {
    Text = "Gelişim Sıfırlama"
  },
  TipsType_20163_Desc = {
    Text = "Gelişim Sıfırlama yapılsın mı? \nAydınlanma sıfırlanacak ve {s1} için harcanan maliyetler iade edilecek. Sıfırlamayı onaylıyor musun?"
  },
  TipsType_20163_LeftBtnDesc = {Text = "İptal"},
  TipsType_20163_RightBtnDesc = {Text = "Onayla"},
  TipsType_20163_Title = {
    Text = "Aydınlanma Sıfırlama"
  },
  TipsType_20164_Desc = {
    Text = "Uyandırıcı'nın Seviye, Yüceltme, Beceri, Yetenek, Aydınlanma ve Gnostik İlerleme durumları sıfırlanır. Bu Uyandırıcı Karanlık Havuz'a geri dönecektir.\n<WeaponEffect_Num:{s1}> için Yaratılış Dönüşü'nü onaylıyor musun?"
  },
  TipsType_20164_LeftBtnDesc = {Text = "İptal"},
  TipsType_20164_RightBtnDesc = {Text = "Onayla"},
  TipsType_20164_Title = {
    Text = "Yaratılış Dönüşü"
  },
  TipsType_20165_Desc = {
    Text = "<WeaponEffect_Num:{s1}>, Özel bir Uyanan’dır. Yalnızca Seviyesi, Terbiyesi, Yetenekleri, Yetenekleri ve Gnostik İlerleme durumları sıfırlanabilir. <Red:Aydınlanma durumu> sıfırlanamaz. Bu Uyanan üzerinde <WeaponEffect_Num:{s1}> kullanmak istediğinizden emin misiniz?\nBu operasyon geri alınamaz."
  },
  TipsType_20165_LeftBtnDesc = {Text = "İptal"},
  TipsType_20165_RightBtnDesc = {Text = "Onayla"},
  TipsType_20165_Title = {
    Text = "Sıfırlama Seçimini Onayla"
  },
  TipsType_20166_Desc = {
    Text = "Aydınlanma Sıfırlama, Özel Uyandırıcılar için alınabilir değildir."
  },
  TipsType_20167_Desc = {
    Text = "Sıfırlama Kullanılamıyor. \nGelişim Sıfırlama zaten kullanıldı. Lütfen bir sonraki sıfırlama döngüsünü bekle."
  },
  TipsType_20168_Desc = {
    Text = "Bu Sıfırlama Etkinliği sırasında zaten Aydınlanma Sıfırlama gerçekleştirdin. Lütfen bir dahaki sefere tekrar dene."
  },
  TipsType_20169_BottomDesc = {
    Text = "<Blue:Note: Seçimini yaptıktan sonra, bu etkinlik süresince değiştirilemez!>"
  },
  TipsType_20169_Desc = {
    Text = "Uyandırıcı <OrangeQuality:\"{s1}\"> ve önerilen Kader Çarkı <OrangeQuality:\"{s2}\"> seçimini bu dönem etkinliğinin yönlendirilmiş UP'ı olarak onaylıyor musunuz?"
  },
  TipsType_20169_LeftBtnDesc = {Text = "İptal"},
  TipsType_20169_RightBtnDesc = {Text = "Onayla"},
  TipsType_20169_Title = {
    Text = "Seçimi Onayla"
  },
  TipsType_20170_Desc = {
    Text = "Günlük meydan okuma sınırına ulaşıldı, lütfen yarın tekrar meydan okumaya gel!"
  },
  TipsType_20171_Desc = {
    Text = "\"Hayali Dalış\" kilidi açıldı!"
  },
  TipsType_20173_Desc = {
    Text = "\"Traphase\" kilidi açıldı!"
  },
  TipsType_20174_Desc = {
    Text = "\"Soruşturma: Zor\" kilidi açıldı!"
  },
  TipsType_20175_Desc = {
    Text = "\"Gizemli Hakimiyet\" kilidi açıldı!"
  },
  TipsType_20176_Desc = {
    Text = "\"Bölgesel D-Etkisi Yasak Bölgesi\" kilidi açıldı!"
  },
  TipsType_20177_Desc = {
    Text = "\"Üreme Çılgınlığı\" kilidi açıldı!"
  },
  TipsType_20178_Desc = {
    Text = "\"İkinci Kader Çarkı\" kilidi açıldı!"
  },
  TipsType_20179_Desc = {
    Text = "\"Kaos Kümesi\" kilidi açıldı!"
  },
  TipsType_20180_Desc = {
    Text = "\"Yasak Ahitname\" kilidi açıldı!"
  },
  TipsType_20181_Desc = {
    Text = "\"Ahit Yükseltme\" kilidi açıldı!"
  },
  TipsType_20182_Desc = {
    Text = "\"Ahit Transkripsiyonu\" kilidi açıldı!"
  },
  TipsType_20183_Desc = {
    Text = "Mevcut etkinlik sona erdi."
  },
  TipsType_20184_Desc = {
    Text = "\"Kılavuz\" açıldı!"
  },
  TipsType_20185_Desc = {
    Text = "Hikâye bölümünü atla?"
  },
  TipsType_20185_LeftBtnDesc = {Text = "İptal"},
  TipsType_20185_RightBtnDesc = {Text = "Onayla"},
  TipsType_20185_Title = {
    Text = "Hikâyeyi Geç"
  },
  TipsType_20186_Desc = {
    Text = "Oyun Verileri İndirilsin mi? \nGerekli dosyalar hazır. Devam edilsin mi? \n*(Wi-Fi önerilir)*"
  },
  TipsType_20186_LeftBtnDesc = {Text = "İptal"},
  TipsType_20186_RightBtnDesc = {Text = "Onayla"},
  TipsType_20187_Desc = {
    Text = "İndirme tamamlandı."
  },
  TipsType_20187_LeftBtnDesc = {Text = "Onayla"},
  TipsType_20188_Desc = {
    Text = "Depolama Neredeyse Dolu. \nVeri kaybını önlemek için en az {s1} gereklidir. Yine de devam edilsin mi?"
  },
  TipsType_20188_LeftBtnDesc = {Text = "İptal"},
  TipsType_20188_RightBtnDesc = {Text = "Onayla"},
  TipsType_20189_Desc = {
    Text = "İndirme başarısız. Yeniden denensin mi?"
  },
  TipsType_20189_LeftBtnDesc = {Text = "İptal"},
  TipsType_20189_RightBtnDesc = {Text = "Onayla"},
  TipsType_20190_Desc = {
    Text = "<TipsHighlightText:{s1}> taşma! Sınırı aşan <TipsHighlightText: {s2}>, her biri <Blue:{s3}>e dönüştürüldü."
  },
  TipsType_20190_Title = {
    Text = "Dönüşüm İpucu"
  },
  TipsType_20191_Desc = {
    Text = "\"Etkinlik\" artık Alınabilir!"
  },
  TipsType_20192_Desc = {
    Text = "Prolog Verisini İndir \nSonraki içerikler için gereklidir. \nBoyut: {s1} \n*(Wi-Fi önerilir)*"
  },
  TipsType_20192_LeftBtnDesc = {Text = "İptal"},
  TipsType_20192_RightBtnDesc = {Text = "İndir"},
  TipsType_20193_Desc = {
    Text = "\"Görev\" artık Alınabilir!"
  },
  TipsType_20194_Desc = {
    Text = "\"\"İletişimci\"\" artık Alınabilir!"
  },
  TipsType_20195_Desc = {
    Text = "\"Müfredat\" artık Alınabilir!"
  },
  TipsType_20196_Desc = {
    Text = "\"Işıksız Diyar\" artık Alınabilir!"
  },
  TipsType_20197_Desc = {
    Text = "Maksimum Uyandırma sayısına ulaşıldı. Lütfen görev ödüllerini al!"
  },
  TipsType_20198_Desc = {
    Text = "Görev tamamlanmadı. Ödülleri almak için hedefi tamamla."
  },
  TipsType_20199_Desc = {
    Text = "Alındıktan sonra \"Vekâlet Belgesi\" sahiplik sınırını aşacak,\nve fazlalık kısım elde edilmeyecek.\nDevam etmek istiyor musun?"
  },
  TipsType_20199_LeftBtnDesc = {Text = "İptal"},
  TipsType_20199_RightBtnDesc = {Text = "Onayla"},
  TipsType_20199_Title = {
    Text = "Almayı Onayla"
  },
  TipsType_20200_Desc = {
    Text = "Günlük Görev’i anında tamamlamak için <Blue:Vekâlet Belgesi*1> kullanmayı onaylıyor musun?"
  },
  TipsType_20200_LeftBtnDesc = {Text = "İptal"},
  TipsType_20200_RightBtnDesc = {Text = "Onayla"},
  TipsType_20200_Title = {
    Text = "Vekil Onayı"
  },
  TipsType_20201_Desc = {
    Text = "Şu anda aşağıdaki Ahit donatılmış durumda. Değiştirmek istiyor musun?"
  },
  TipsType_20201_LeftBtnDesc = {Text = "İptal"},
  TipsType_20201_RightBtnDesc = {Text = "Onayla"},
  TipsType_20201_Title = {
    Text = "Alt Özellikler Değiştirilsin mi?"
  },
  TipsType_20202_Desc = {
    Text = "Geçerli plan {s1} içinde etkin. Yine de {s2} planını silmek istiyor musun?"
  },
  TipsType_20202_LeftBtnDesc = {Text = "İptal"},
  TipsType_20202_RightBtnDesc = {Text = "Onayla"},
  TipsType_20202_Title = {
    Text = "Silme Onayı"
  },
  TipsType_20203_Desc = {
    Text = "Aynı Kader Çarkı Etkileri aynı takımda istiflenemez. {s1} zaten donatılmış. Yine de donatılsın mı?"
  },
  TipsType_20203_LeftBtnDesc = {Text = "İptal"},
  TipsType_20203_RightBtnDesc = {Text = "Onayla"},
  TipsType_20203_Title = {
    Text = "Ekipmanı Onayla"
  },
  TipsType_20204_Desc = {
    Text = "Mevcut Ahit, hâlihazırda {s1} içinde kullanılıyor. Onu sökmek, bu kurulumdan kaldırılmasına yol açacak. Yine de devam edilsin mi?"
  },
  TipsType_20204_LeftBtnDesc = {Text = "İptal"},
  TipsType_20204_RightBtnDesc = {Text = "Onayla"},
  TipsType_20204_Title = {
    Text = "Silme Onayı"
  },
  TipsType_20205_Desc = {
    Text = "Mevcut Ahit, hâlihazırda {s1} Kadrosunda kullanılıyor. Onu sökmek, bu Ahit’in çıkarılmasına yol açacak. Yine de devam edilsin mi?"
  },
  TipsType_20205_LeftBtnDesc = {Text = "İptal"},
  TipsType_20205_RightBtnDesc = {Text = "Onayla"},
  TipsType_20205_Title = {
    Text = "Silme Onayı"
  },
  TipsType_20206_Desc = {
    Text = "Mevcut Kader Çarkı, hâlihazırda {s1} Kadrosunda kullanılıyor. Onu sökmek, Kadrodan kaldırılmasına yol açacak. Yine de devam edilsin mi?"
  },
  TipsType_20206_LeftBtnDesc = {Text = "İptal"},
  TipsType_20206_RightBtnDesc = {Text = "Onayla"},
  TipsType_20206_Title = {
    Text = "Silme Onayı"
  },
  TipsType_20207_Desc = {
    Text = "Kaydedilmemiş değişiklikler çıkış yaparsan kaybolacak. Yine de ayrılmak istiyor musun?"
  },
  TipsType_20207_LeftBtnDesc = {Text = "İptal"},
  TipsType_20207_RightBtnDesc = {Text = "Onayla"},
  TipsType_20207_Title = {
    Text = "Dizilimi Uygula"
  },
  TipsType_20208_Desc = {
    Text = "Ödüller alındı! Diğer alınabilir görevlere göz at."
  },
  TipsType_20209_Desc = {
    Text = "Görev süresi doldu."
  },
  TipsType_20210_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20210_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20210_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20210_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20211_Desc = {
    Text = "{s1}g {s2}sa içinde kilit açılacak"
  },
  TipsType_20212_Desc = {
    Text = "{s1}sa {s2}dk sonra açılacak"
  },
  TipsType_20213_Desc = {
    Text = "{s1}, Sınır Ötesi Nedensellik’i tetikledi. Geri sarma, bu Etkiyi geçersiz kılacak ve birimi kadronundan kaldıracak. \nGeri Sarma ile devam edilsin mi? (Bu işlem geri alınamaz)"
  },
  TipsType_20213_LeftBtnDesc = {Text = "İptal"},
  TipsType_20213_RightBtnDesc = {Text = "Onayla"},
  TipsType_20213_Title = {
    Text = "Sıfırlama Seçimini Onayla"
  },
  TipsType_20214_Desc = {
    Text = "Yükseliş Geri Alınsın mı? \nTüm maliyetleri iade etmek için {s1} sıfırlansın. Sınır Ötesi Nedensellik devre dışı bırakılacak ve birim dizilimden kaldırılacak. Onaylıyor musun?"
  },
  TipsType_20214_LeftBtnDesc = {Text = "İptal"},
  TipsType_20214_RightBtnDesc = {Text = "Onayla"},
  TipsType_20214_Title = {
    Text = "Yığın İz Sürme"
  },
  TipsType_20215_Desc = {
    Text = "Yaratılış Dönüşü? \n{s1} sıfırlansın ve Kara Havuz’a geri gönderilsin. Tüm maliyetler iade edilecek ve birim dizilimden kaldırılacak. Onaylıyor musun?"
  },
  TipsType_20215_LeftBtnDesc = {Text = "İptal"},
  TipsType_20215_RightBtnDesc = {Text = "Onayla"},
  TipsType_20215_Title = {
    Text = "Yaratılış Dönüşü"
  },
  TipsType_20216_Desc = {
    Text = "<Blue:{s1} × {s2}> ile satın al?"
  },
  TipsType_20216_LeftBtnDesc = {Text = "İptal"},
  TipsType_20216_RightBtnDesc = {Text = "Satın Al"},
  TipsType_20216_Title = {
    Text = "Satın Alma Onayı"
  },
  TipsType_20217_Desc = {
    Text = "{s1}, {s2} sonrasında açılacak."
  },
  TipsType_20218_Desc = {
    Text = "Önceden seçilmiş Uyandırıcı kaldırılamaz. Yalnızca aynı Uyandırıcı ile değiştirebilirsin."
  },
  TipsType_20219_Desc = {
    Text = "Aynı Uyandırıcı zaten konuşlandırılmış. Yeniden seçilemez."
  },
  TipsType_20220_Desc = {
    Text = "Wi-Fi Algılanmadı. \n({s1}) indirmek hücresel verini tüketecek. Devam edilsin mi?"
  },
  TipsType_20220_LeftBtnDesc = {Text = "İptal"},
  TipsType_20220_RightBtnDesc = {Text = "İndir"},
  TipsType_20221_Desc = {
    Text = "İndirme tamamlandı."
  },
  TipsType_20221_LeftBtnDesc = {Text = "Onayla"},
  TipsType_20222_Desc = {
    Text = "Depolama Neredeyse Dolu. \nVeri kaybını önlemek için en az {s1} gereklidir. Yine de devam edilsin mi?"
  },
  TipsType_20222_LeftBtnDesc = {Text = "İptal"},
  TipsType_20222_RightBtnDesc = {Text = "Onayla"},
  TipsType_20223_Desc = {
    Text = "İndirme başarısız. Yeniden denensin mi?"
  },
  TipsType_20223_LeftBtnDesc = {Text = "İptal"},
  TipsType_20223_RightBtnDesc = {Text = "Onayla"},
  TipsType_20224_Desc = {
    Text = "Prolog Verisini İndir \nSonraki içerikler için gereklidir. \nBoyut: {s1} \n*(Wi-Fi önerilir)*"
  },
  TipsType_20224_LeftBtnDesc = {Text = "İptal"},
  TipsType_20224_RightBtnDesc = {Text = "İndir"},
  TipsType_20225_Desc = {
    Text = "{s1} tamamlandı! \nEk {s2} Eğitim Puanları için fazladan meydan okumayı kabul etmek ister misin?"
  },
  TipsType_20225_LeftBtnDesc = {Text = "İptal"},
  TipsType_20225_RightBtnDesc = {Text = "Onayla"},
  TipsType_20225_Title = {
    Text = "Ekstra Meydan Okuma"
  },
  TipsType_20226_Desc = {
    Text = "Sıfırladıktan sonra, ek meydan okuma ekibinin Uyandırıcıları, Müfrezeleri ve Kader Çarkı yeniden savaş alanına girebilir, ancak bu aşamanın tamamlanmasından elde edilen Eğitim Puanları da düşülecektir (bu, ödül durumunu etkilemez). Sıfırlamak istediğinizden emin misiniz?"
  },
  TipsType_20226_LeftBtnDesc = {Text = "İptal"},
  TipsType_20226_RightBtnDesc = {Text = "Onayla"},
  TipsType_20226_Title = {
    Text = "Sıfırlamayı Onayla"
  },
  TipsType_20227_Desc = {
    Text = "Sıfırlama sonrasında, mevcut soruşturma ekibinin Uyandırıcısı, Çetesi ve Kader Çarkı yeniden görevlendirilebilir. Ayrıca, ek zorluk ekibi mevcut soruşturma ekibinin yerini alacaktır, ancak bu aşamayı ek zorluk olarak tamamlayarak elde edilen Eğitim Puanları da düşülecektir (bu, ödül durumunu etkilemez). Sıfırlamak istediğinden emin misin?"
  },
  TipsType_20227_LeftBtnDesc = {Text = "İptal"},
  TipsType_20227_RightBtnDesc = {Text = "Onayla"},
  TipsType_20227_Title = {
    Text = "Sıfırlamayı Onayla"
  },
  TipsType_20228_Desc = {
    Text = "Daha fazla duyuru için aşağı kaydır."
  },
  TipsType_20229_Desc = {
    Text = "<Blue:{s1}> en yüksek Uyanış seviyesine ulaştı.\nYine de satın alınsın mı?\nKalan adet: {s2}"
  },
  TipsType_20229_LeftBtnDesc = {Text = "İptal"},
  TipsType_20229_RightBtnDesc = {Text = "Onayla"},
  TipsType_20229_Title = {
    Text = "Satın Alma Onayı"
  },
  TipsType_20230_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20230_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20230_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20230_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20231_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20231_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20231_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20231_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20232_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20232_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20232_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20232_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20233_Desc = {
    Text = "Gerekli malzemeler yetersiz.\nBunun yerine aşağıdaki malzemeleri tüketmek ister misiniz?"
  },
  TipsType_20233_LeftBtnDesc = {Text = "İptal"},
  TipsType_20233_RightBtnDesc = {Text = "Onayla"},
  TipsType_20233_Title = {
    Text = "Tamamlanma Onayı"
  },
  TipsType_20234_Desc = {
    Text = "Bu Aşamada yalnızca kuşanılmış Müfreze kullanılabilir ve değiştirilemez."
  },
  TipsType_20235_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20235_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20235_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20235_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20236_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20236_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20236_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20236_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20237_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20237_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20237_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20237_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20238_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20238_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20238_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20238_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20239_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20239_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20239_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20239_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20240_Desc = {
    Text = "Onarım tamamlandı. Lütfen oyunu yeniden başlat."
  },
  TipsType_20240_RightBtnDesc = {Text = "Onayla"},
  TipsType_20240_Title = {Text = "Not"},
  TipsType_20241_Desc = {
    Text = "Tam yükselmek için {s1} adet daha \"<Blue:{s2}>\" gerekiyor.\nSatın almaya devam etmek ister misin?"
  },
  TipsType_20241_LeftBtnDesc = {Text = "İptal"},
  TipsType_20241_RightBtnDesc = {Text = "Onayla"},
  TipsType_20241_Title = {
    Text = "Satın Alma Onayı"
  },
  TipsType_20250_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20250_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20250_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20250_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20251_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20251_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20251_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20251_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20252_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_20252_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_20252_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_20252_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20259_Desc = {
    Text = "\"Bin Yüz Mührü\" yetersiz olduğunda kullanılmak üzere Borsa ayarları kaydedildi."
  },
  TipsType_20300_Desc = {
    Text = "Zaten {s1} Traphase Rol Uyandırıcısına sahipsin; aynı Traphase Rol Uyandırıcısını aynı takımda kullanamazsın."
  },
  TipsType_20301_Desc = {
    Text = "Eğitim Görevleri"
  },
  TipsType_20351_Desc = {
    Text = "Yetersiz {s1}. \n{s2} {s3} karşılığında {s4} {s5} ile takas edilsin mi?"
  },
  TipsType_20351_LeftBtnDesc = {Text = "İptal"},
  TipsType_20351_RightBtnDesc = {Text = "Onayla"},
  TipsType_20351_Title = {
    Text = "Yetersiz {s1}"
  },
  TipsType_20352_Desc = {
    Text = "Bu Muhafız ile bağ kurulsun mu? \nNot: Bu işlem kalıcıdır."
  },
  TipsType_20352_LeftBtnDesc = {Text = "İptal"},
  TipsType_20352_RightBtnDesc = {Text = "Onayla"},
  TipsType_20352_Title = {
    Text = "Davetiyeyi Onayla"
  },
  TipsType_20353_Desc = {
    Text = "Davet kodu kopyalandı!"
  },
  TipsType_20354_Desc = {
    Text = "Bu kullanıcıyı zaten davet ettiniz."
  },
  TipsType_20355_Desc = {
    Text = "Kendi kodunu kullanamazsın. Lütfen başka bir Muhafızdan alınmış bir kod gir."
  },
  TipsType_20356_Desc = {
    Text = "Prolog hikâyesini ve öğreticiyi yeniden deneyimlemek için tekrar oynayabilirsin!\nAncak, aynı ödülleri gerçekten tekrar alamayacaksın.\nYine de devam edilsin mi?"
  },
  TipsType_20356_LeftBtnDesc = {Text = "İptal"},
  TipsType_20356_RightBtnDesc = {Text = "Onayla"},
  TipsType_20356_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_20357_Desc = {
    Text = "Seçilen {s1} Koruyucular takipten çıkarılsın mı?"
  },
  TipsType_20357_LeftBtnDesc = {Text = "İptal"},
  TipsType_20357_RightBtnDesc = {Text = "Onayla"},
  TipsType_20357_Title = {
    Text = "Takibi Bırak"
  },
  TipsType_20358_Desc = {
    Text = "Onaylanmamış bir takipten çıkma var. Ayrılıp takipten çıkmayı iptal et?"
  },
  TipsType_20358_LeftBtnDesc = {Text = "İptal"},
  TipsType_20358_RightBtnDesc = {Text = "Onayla"},
  TipsType_20358_Title = {
    Text = "Çıkış Onayı"
  },
  TipsType_20400_Desc = {
    Text = "Yetersiz <WeaponEffect_Num:{s1}>. Daha fazlası için Borsa kullanılsın mı?"
  },
  TipsType_20400_LeftBtnDesc = {Text = "İptal"},
  TipsType_20400_RightBtnDesc = {Text = "Onayla"},
  TipsType_20400_Title = {
    Text = "Yetersiz Piyango Eşyası"
  },
  TipsType_300001_Desc = {
    Text = "\"Gümüş Şafak Parıltısı\" yalnızca bir ücretsiz Uyanış hakkı sunar. Bunu kullanmak istediğinden emin misin?"
  },
  TipsType_300001_LeftBtnDesc = {Text = "İptal"},
  TipsType_300001_RightBtnDesc = {Text = "Onayla"},
  TipsType_300001_Title = {Text = "Onaylama"},
  TipsType_300002_Desc = {
    Text = "Bu Uyanışın sonucunu onaylıyor musunuz? Onaylandığında, ücretsiz Uyanış hakkı tüketilecektir."
  },
  TipsType_300002_LeftBtnDesc = {Text = "İptal"},
  TipsType_300002_RightBtnDesc = {Text = "Onayla"},
  TipsType_300002_Title = {Text = "Onaylama"},
  TipsType_30001_Desc = {
    Text = "Simge olmadan yan ipucu"
  },
  TipsType_30003_Desc = {
    Text = "{s1} Kilitli Değil"
  },
  TipsType_30004_Desc = {
    Text = "{s1} Gelişmiş Mod Kilidi Açıldı"
  },
  TipsType_30005_Desc = {
    Text = "{s1} (Zor) Kilidi Açıldı"
  },
  TipsType_31000_Desc = {
    Text = "Doğum Tarihini Onayla? \nBir kez onaylandıktan sonra doğum günün değiştirilemez."
  },
  TipsType_31000_LeftBtnDesc = {Text = "İptal"},
  TipsType_31000_RightBtnDesc = {Text = "Onayla"},
  TipsType_31000_Title = {
    Text = "Yaşı Doğrula"
  },
  TipsType_31001_Desc = {
    Text = "Bu ay <Blue:{s1}> TL bakiye yüklediniz, üst sınır <Blue:{s2}> TL'dir. Lütfen gelecek ay tekrar deneyin veya daha düşük bir miktar seçin."
  },
  TipsType_31002_Desc = {
    Text = "Lütfen önce yaş doğrulamasını tamamla"
  },
  TipsType_31003_Desc = {
    Text = "Acil Gnosis Birimi etkinleştirilsin mi? \nŞimdi Canlanma yapılsın mı? (1 Gnosis tüketir; her gün 09:00’da yenilenir). \nKalan: {s1} \n<Blue:(İlk diriliş ücretsiz!)>"
  },
  TipsType_31003_LeftBtnDesc = {Text = "İptal"},
  TipsType_31003_RightBtnDesc = {Text = "Onayla"},
  TipsType_31003_Title = {
    Text = "Şimdi Canlandır?"
  },
  TipsType_31004_Desc = {
    Text = "Acil Gnosis Birimi etkinleştirilsin mi? \nŞimdi Canlanma yapılsın mı? (1 Gnosis tüketir; her gün 09:00’da yenilenir). \nKalan: {s1} \n<Blue:(İlk diriliş ücretsiz!)>"
  },
  TipsType_31004_RightBtnDesc = {Text = "Onayla"},
  TipsType_31004_Title = {
    Text = "Şimdi Canlandır?"
  },
  TipsType_40001_Desc = {
    Text = "HP 0’a ulaştığında soruşturma derhâl sonlanır."
  },
  TipsType_40001_Title = {Text = "Can"},
  TipsType_40002_Desc = {
    Text = "Hareket etmek ve Olaylar Stres üretir, bu da Zihinsel Semptomlara dönüşür.\nHer hareket edilen kare 10 Stres ekler. Her 100 Stres 1 Semptoma neden olur.\n500 Stres'te her hareket Can'ı %10 azaltır."
  },
  TipsType_40002_Title = {Text = "Stres"},
  TipsType_40003_Desc = {
    Text = "Daha yüksek Görev seviyeleri daha büyük zorluk, ama daha iyi ödüller anlamına gelir."
  },
  TipsType_40003_Title = {
    Text = "Görev Seviyesi"
  },
  TipsType_40004_Desc = {
    Text = "Her tur oynanan ilk Komut Kartı, Ultra Uzay’da geçici bir kopya yaratır.\nTam dolduğunda, 1 fazladan Ultra Tur kazan ve önceki turdan kalan Kalkanını koru.\nDiyar Ustalığı Etkisi: Tur başlarında ele 1 \"Insight\" ekleme şansı vardır."
  },
  TipsType_40004_Title = {Text = "Ultra Uzay"},
  TipsType_40005_Desc = {
    Text = "Koruyucular, Soruşturmalar, Perde Araları ve meydan okumalar yoluyla Koruyucu EXP’si kazanır. Daha yüksek Koruyucu Seviyeleri daha fazla oynanış seçeneğinin kilidini açar."
  },
  TipsType_40005_Title = {
    Text = "Koruyucu TP"
  },
  TipsType_40006_Desc = {
    Text = "Komut Kartları Arithmetica harcar. Kullanılmayan puanlar devretmez. Arithmetica her turun başında tamamen yenilenir."
  },
  TipsType_40006_Title = {
    Text = "Arithmetica"
  },
  TipsType_40007_Desc = {
    Text = "Gümüş Anahtar özel bir enerji algılıyor. Burada değerli bir şey gizlenmiş olabilir..."
  },
  TipsType_40007_Title = {
    Text = "Gizli Kaynak"
  },
  TipsType_40008_Desc = {
    Text = "Ölümcül krizler sırasında etkinleşir (1 kullanım harcanır).\nTakım HP’sini ve Uyananların Aliemus’unu en üst seviyeye yeniler.\nGünlük yenileme: Saat 9:00’da 1."
  },
  TipsType_40008_Title = {
    Text = "Acil Gnosis Birimi"
  },
  TipsType_40009_Desc = {
    Text = "Komut Kartları Arithmetica tüketir. Kullanılmayan puanlar sona erer.\nTur başı: +1 sınır, sınıra kadar yenile. Mevcut tur: {s1}."
  },
  TipsType_40009_Title = {
    Text = "Arithmetica"
  },
  TipsType_AbyssChallengeResetTips_Desc = {
    Text = "Bölgesel D-Etkisi Yasak Bölgesi sıfırlandı, devam eden meydan okuma hemen sona erecek."
  },
  TipsType_AbyssChallengeResetTips_RightBtnDesc = {Text = "Onayla"},
  TipsType_AbyssChallengeResetTips_Title = {
    Text = "Soruşturma Devam Ediyor"
  },
  TipsType_AbyssChallengeRevivalTips_Desc = {
    Text = "Gümüş Anahtar ölümcül bir tehlike hissediyor. Acil Gnosis etkinleştirilsin mi?\n(Diriliş 1 Acil Gnosis tüketir. Her gün sabah 9'da 1 tane alırsınız.)"
  },
  TipsType_AbyssChallengeRevivalTips_LeftBtnDesc = {Text = "İptal"},
  TipsType_AbyssChallengeRevivalTips_RightBtnDesc = {Text = "Onayla"},
  TipsType_AbyssChallengeRevivalTips_Title = {
    Text = "Şimdi Canlandır?"
  },
  TipsType_AcceptConfirm_Desc = {
    Text = "<Blue:{s1}>'in <Blue:{s2}> davetini kabul ediyor musun?"
  },
  TipsType_AcceptConfirm_LeftBtnDesc = {Text = "Reddet"},
  TipsType_AcceptConfirm_RightBtnDesc = {Text = "Kabul Et"},
  TipsType_AcceptConfirm_Title = {
    Text = "Şifre Modu"
  },
  TipsType_ActivitySignRewardTaskNotCompleteTips_Desc = {
    Text = "Uyandırmak için Görevleri Tamamla"
  },
  TipsType_AlreadyIsBackgroundMusicTips_Desc = {
    Text = "Zaten geçerli BGM olarak ayarlı"
  },
  TipsType_AwakerAutoInsertCoinNotEnoughTips_Desc = {
    Text = "\"Altın Gül\" mevcut \"Gnosis İksiri\"ni tam olarak kullanmak için yeterli değil. \"Altın Gül\" ekleyip tekrar deneyebilirsiniz."
  },
  TipsType_AwakerNotOpenTips_Desc = {
    Text = "Uyandırıcı henüz kullanılamıyor. Takipte kalın!"
  },
  TipsType_AwakerRandomChestConfirm_Desc = {
    Text = "1 <Blue:rastgele> Uyandırıcı elde etmek için <Blue:{s1}> kullanmayı onaylıyor musunuz?"
  },
  TipsType_AwakerRandomChestConfirm_LeftBtnDesc = {Text = "İptal"},
  TipsType_AwakerRandomChestConfirm_RightBtnDesc = {Text = "Onayla"},
  TipsType_AwakerRandomChestConfirm_Title = {
    Text = "Kullanım Onayı"
  },
  TipsType_BattleCreateFail_Desc = {
    Text = "Savaş Oluşturma Başarısız"
  },
  TipsType_BattlePassAllCompleteTips_Desc = {
    Text = "Mevcut Arşivler tamamen tamamlandı."
  },
  TipsType_BestExperienceTips_Chapter3_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_BestExperienceTips_Chapter3_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_BestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_BestExperienceTips_Chapter3_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_BestExperienceTips_Chapter7_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_BestExperienceTips_Chapter7_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_BestExperienceTips_Chapter7_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_BestExperienceTips_Chapter7_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_BestExperienceTips_Chapter8_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_BestExperienceTips_Chapter8_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_BestExperienceTips_Chapter8_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_BestExperienceTips_Chapter8_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_BestExperienceTips_ChapterS2_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_BestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_BestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_BestExperienceTips_ChapterS2_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_BestExperienceTips_ChapterS3_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_BestExperienceTips_ChapterS3_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_BestExperienceTips_ChapterS3_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_BestExperienceTips_ChapterS3_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_BestExperienceTips_ChapterS4_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_BestExperienceTips_ChapterS4_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_BestExperienceTips_ChapterS4_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_BestExperienceTips_ChapterS4_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_BestExperienceTips_ChapterS5_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_BestExperienceTips_ChapterS5_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_BestExperienceTips_ChapterS5_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_BestExperienceTips_ChapterS5_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_BestExperienceTips_MainStoryS1_6_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_BestExperienceTips_TwoAnniversarySubStage_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_CancelCollectAwakerTips_Desc = {
    Text = "Favorilerden çıkarıldı"
  },
  TipsType_CoinBulkBuyConfirm_Desc = {
    Text = "\"Gül Altın Kuponu\" × {s1} harcayarak satın almak istiyor musunuz?"
  },
  TipsType_CoinBulkBuyConfirm_LeftBtnDesc = {Text = "İptal"},
  TipsType_CoinBulkBuyConfirm_RightBtnDesc = {Text = "Onayla"},
  TipsType_CoinBulkBuyConfirm_Title = {
    Text = "Satın Alma Onayı"
  },
  TipsType_CollectAwakerTips_Desc = {
    Text = "Favorilere eklendi"
  },
  TipsType_CommonUseBattleHelpLimitTips_Desc = {
    Text = "\"Çok fazla Sık Kullanılan Destek eklediniz. Lütfen listeyi düzenleyin.\""
  },
  TipsType_DiskIsFullOrViolation_Desc = {
    Text = "Dosyalar yüklenemedi. Lütfen depolama alanınızı kontrol edin."
  },
  TipsType_DiskIsFullOrViolation_RightBtnDesc = {Text = "Onayla"},
  TipsType_DiskSpaceNotEnough_Desc = {
    Text = "Yetersiz depolama alanı. İndirmeye devam edilsin mi?"
  },
  TipsType_DiskSpaceNotEnough_LeftBtnDesc = {Text = "İptal"},
  TipsType_DiskSpaceNotEnough_RightBtnDesc = {Text = "Onayla"},
  TipsType_DoubleExBPBuyConfirm_Desc = {
    Text = "<Blue:{s1}> Gümüş Çekirdek Özü ile satın al?\n <color=#ACBFCA>Bu, Özel bir Müfredat Sezonu. Üst Düzey Temel Konular indirimdedir.</color>"
  },
  TipsType_DoubleExBPBuyConfirm_LeftBtnDesc = {Text = "İptal"},
  TipsType_DoubleExBPBuyConfirm_RightBtnDesc = {Text = "Satın Al"},
  TipsType_DoubleExBPBuyConfirm_Title = {
    Text = "Satın Alma Onayı"
  },
  TipsType_EnterSix_DigitPasswordTips_Desc = {
    Text = "Lütfen <color=#5EF2FF>Parola</color> girin"
  },
  TipsType_FilterMaxAwakerCountTips_Desc = {
    Text = "Filtrelemek için en fazla {s1} Uyandırıcı seçin"
  },
  TipsType_FollowBackConfirm_Desc = {
    Text = "Bu sayfadaki <color=#5EF2FF>{s1}</color> takipçiyi takip et?\n\n<color=#96947F>Şu anda takip edilen </color>{s2}<color=#A0A0A0>/{s3}\nBu miktardan daha fazla Koruyucu takip edemezsiniz. </color>"
  },
  TipsType_FollowBackConfirm_LeftBtnDesc = {Text = "İptal"},
  TipsType_FollowBackConfirm_RightBtnDesc = {Text = "Onayla"},
  TipsType_FollowBackConfirm_Title = {
    Text = "Geri Takip Edilsin mi?"
  },
  TipsType_FrenziedOmenUpgradeConfirm_Desc = {
    Text = "Bu işlem büyük miktarda kaynak tüketecektir; Uyandırıcı'nın yeteneklerini sınıra kadar geliştirmek isteyenler için uygundur. \"Delilik Alameti\" Güçlendirmesini onaylıyor musunuz?"
  },
  TipsType_FrenziedOmenUpgradeConfirm_LeftBtnDesc = {Text = "İptal"},
  TipsType_FrenziedOmenUpgradeConfirm_RightBtnDesc = {Text = "Onayla"},
  TipsType_FrenziedOmenUpgradeConfirm_Title = {
    Text = "Geliştirmeyi Onayla"
  },
  TipsType_GnosticPotentialUpgradeConfirm_Desc = {
    Text = "Bu işlem büyük miktarda kaynak tüketecektir; Uyandırıcı'nın yeteneklerini sınıra kadar geliştirmek isteyenler için uygundur. \"Gnostik Potansiyel\" Güçlendirmesini onaylıyor musunuz?"
  },
  TipsType_GnosticPotentialUpgradeConfirm_LeftBtnDesc = {Text = "İptal"},
  TipsType_GnosticPotentialUpgradeConfirm_RightBtnDesc = {Text = "Onayla"},
  TipsType_GnosticPotentialUpgradeConfirm_Title = {
    Text = "Geliştirmeyi Onayla"
  },
  TipsType_InCharging_Desc = {
    Text = "Siparişiniz işleniyor. Lütfen yinelenen ödeme yapmayın.\n\n• Ödeme tamamlandı mı? Ödüllerinizin teslim edilmesini bekleyin.\nÖdeme tamamlanmadı mı? Lütfen oyunu yeniden başlatıp tekrar deneyin.\n\nHerhangi bir sorun yaşarsanız, lütfen Müşteri Hizmetleri ile iletişime geçin."
  },
  TipsType_InCharging_RightBtnDesc = {Text = "Onayla"},
  TipsType_InCharging_Title = {Text = "Not"},
  TipsType_KeyShortNameDownLoadTips_Desc = {
    Text = "Çok dilli anahtar indiriliyor. Lütfen biraz bekle."
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_Desc = {
    Text = "Bu Uyandırıcı tamamen Aydınlanmış.\nSeçimden sonra yalnızca 6 Gnosis Parçası ve 2 Rafine Gnosis Parçası alacaksın."
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_LeftBtnDesc = {Text = "İptal"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_RightBtnDesc = {Text = "Devam et"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_Title = {
    Text = "Seçimi Onayla"
  },
  TipsType_MainResetBG_Desc = {
    Text = "Yurt arka planındaki <Blue:Görüntü> ve <Blue:Müzik> Varsayılan hâline geri yüklensin mi?"
  },
  TipsType_MainResetBG_LeftBtnDesc = {Text = "İptal"},
  TipsType_MainResetBG_RightBtnDesc = {Text = "Onayla"},
  TipsType_MainResetBG_Title = {
    Text = "Varsayılanı Geri Yükle"
  },
  TipsType_MultiSelectBox_FixItemTips_Desc = {
    Text = "Garantili eşya. Değiştirilemez."
  },
  TipsType_MultiSelectBox_SelectTips_Desc = {
    Text = "Lütfen satın alma işlemine geçmeden önce tüm kendi seçtiğiniz öğelerin seçimini tamamlayın"
  },
  TipsType_OppositeSideCancelMatchTips_Desc = {
    Text = "Rakip eşleştirmeyi iptal etti"
  },
  TipsType_OppositeSideRejectTips_Desc = {
    Text = "Rakip <Blue:{s1}> davetini reddetti, lütfen bir mod daha seç."
  },
  TipsType_PVEExceedMaxRoundsTips_Desc = {
    Text = "Savaş tur sayısı üst sınıra ulaştı\n\nTek Koruyucu\nBundan sonra nasıl bir seçim yapacaksın?"
  },
  TipsType_PVEExceedMaxRoundsTips_LeftBtnDesc = {
    Text = "Savaşı Yeniden Dene"
  },
  TipsType_PVEExceedMaxRoundsTips_RightBtnDesc = {
    Text = "Geçici Geri Çekilme"
  },
  TipsType_PVEExceedMaxRoundsTips_Title = {
    Text = "Soruşturma Başarısız"
  },
  TipsType_PVEReplayErrorTips_Desc = {
    Text = "Savaş tekrar oynatması alınırken hata oluştu, lütfen daha sonra yeniden deneyin."
  },
  TipsType_PVEReplayMaxRounds_Desc = {
    Text = "Tekrar Oynatma 25 tur olan maksimum sınıra ulaştı.\nTekrar Oynatma sona erdi."
  },
  TipsType_PVEReplayMaxRounds_RightBtnDesc = {Text = "Onayla"},
  TipsType_PVEReplayMaxRounds_Title = {Text = "Onaylama"},
  TipsType_PVEReplayNoDataTips_Desc = {
    Text = "Soruşturma Kaydı Yok"
  },
  TipsType_PVEReplayRepeatClickTips_Desc = {
    Text = "Savaş tekrar oynatması yükleniyor, lütfen işlemleri tekrarlamayın."
  },
  TipsType_PVEReplaySpecialTeamAssignTips_Desc = {
    Text = "Özel dizilimlerin savaş tekrar oynatması şu anda desteklenmiyor."
  },
  TipsType_PVEReplayTimeoutTips_Desc = {
    Text = "Savaş tekrarını alma zaman aşımına uğradı"
  },
  TipsType_PVEReplayUnableOperateTips_Desc = {
    Text = "Savaş tekrar oynatılırken hiçbir Operasyon gerçekleştirilemez."
  },
  TipsType_PVETeamShareCodeCopyTips_Desc = {
    Text = "Kopyalandı"
  },
  TipsType_PVETeamShareCodeError_Desc = {
    Text = "Panoda hiçbir <color=#5EF2FF>Soruşturma</color> Dizilimi bulunamadı."
  },
  TipsType_PVETeamShareCodeSaveTips_Desc = {
    Text = "Dizilim kodundaki dizilimi uygulansın mı?\nSahip olunmayan öğeler boş bırakılacaktır."
  },
  TipsType_PVETeamShareCodeSaveTips_LeftBtnDesc = {Text = "İptal"},
  TipsType_PVETeamShareCodeSaveTips_RightBtnDesc = {Text = "Onayla"},
  TipsType_PVETeamShareCodeSaveTips_Title = {
    Text = "Dizilimi Uygula"
  },
  TipsType_PVETeamShareCodeSpecialTeamAssignTips_Desc = {
    Text = "Bu takım önceden ayarlanmış bir Uyanan içeriyor. Dizilim kodu kopyalanamaz veya içe aktarılamaz."
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_Desc = {
    Text = "Karşılaşma tur üst sınırına ulaştı, birinci hamle tarafı karşılaşmayı sonlandıramadı ve mağlup ilan edildi."
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_RightBtnDesc = {Text = "Onayla"},
  TipsType_PVPExceedMaxRoundsTips_Loser_Title = {
    Text = "Karşılaşma Sona Erdi"
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_Desc = {
    Text = "Karşılaşma tur üst sınırına ulaştı, ikinci hamle tarafı oyunun sonuna kadar başarıyla direndi ve galip ilan edildi."
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_RightBtnDesc = {Text = "Onayla"},
  TipsType_PVPExceedMaxRoundsTips_Winner_Title = {
    Text = "Karşılaşma Sona Erdi"
  },
  TipsType_PVPSurrenderConfirm_Desc = {
    Text = "Teslim oluyor musun?"
  },
  TipsType_PVPSurrenderConfirm_LeftBtnDesc = {Text = "İptal"},
  TipsType_PVPSurrenderConfirm_RightBtnDesc = {Text = "Onayla"},
  TipsType_PVPSurrenderConfirm_Title = {
    Text = "Teslimiyet Onayı"
  },
  TipsType_PVPTeamShareCodeError_Desc = {
    Text = "Panoda hiçbir <color=#5EF2FF>Traphase</color> Dizilimi bulunamadı."
  },
  TipsType_PVP_PasswordBattle_BlockTips_Desc = {
    Text = "Bu Koruyucu’yu engellemen gerekiyor mu?"
  },
  TipsType_PVP_PasswordBattle_BlockTips_LeftBtnDesc = {Text = "Reddet"},
  TipsType_PVP_PasswordBattle_BlockTips_RightBtnDesc = {Text = "Kabul Et"},
  TipsType_PVP_PasswordBattle_BlockTips_Title = {Text = "Engelleme?"},
  TipsType_PVP_PasswordBattle_GameStartedTips_Desc = {
    Text = "Bu Şifre Modu zaten başlatılmış."
  },
  TipsType_PVP_PasswordBattle_OthersEnterTips_Desc = {
    Text = "Bu kriptografik savaşın bu turuna yeni bir muhafız girdi."
  },
  TipsType_PVP_PasswordBattle_QueueTips_Desc = {
    Text = "Şu anda sıradasın..."
  },
  TipsType_PVP_PasswordBattle_QuitTips_Desc = {
    Text = "Şifreli savaştan çıkmak istiyor musun?"
  },
  TipsType_PVP_PasswordBattle_QuitTips_LeftBtnDesc = {Text = "İptal"},
  TipsType_PVP_PasswordBattle_QuitTips_RightBtnDesc = {Text = "Çıkış"},
  TipsType_PVP_PasswordBattle_QuitTips_Title = {
    Text = "Çıkış Onayı"
  },
  TipsType_PVP_PasswordBattle_RejectedTips_Desc = {
    Text = "Rakip seninle savaşmayı reddetti"
  },
  TipsType_PassportHoistTips1_Desc = {
    Text = "\"Temel Aktif İyon\"\n·Kilidini açtıktan sonra, bu sezon boyunca \"Günlük Tatbikatlar\"daki \"Temel Aktif İyon\" birikimli ödüllerinden elde edilen \"Gerçeklik Başlangıç Noktası\", \"Saf Çekirdek\", \"EXP\" ve \"Gümüş\" 3 katına çıkar. \"Premium Konular\" satın alındıktan sonra, bu sezonda daha önce alınan \"Temel Aktif İyon\" birikimli ödüllerinin ek çarpan kısmı geriye dönük olarak verilir."
  },
  TipsType_PassportHoistTips2_Desc = {
    Text = "Zaman Akışı Tersine Dönüş:\nSavaş sırasında son 25 turdan herhangi birine geri dön. Bu özellik, meydan okumayı yeniden denedikten sonra bile kullanılabilir durumda kalır."
  },
  TipsType_PassportHoistTips3_Desc = {
    Text = "Traphase:\nBu Müfredat Sezonu boyunca, Traphase’te tüm kartların kilidi açıktır (elde edilmemiş olanlar dâhil)."
  },
  TipsType_Password_CopiedTips_Desc = {
    Text = "<color=#5EF2FF>Şifre</color> panoya kopyalandı"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_Desc = {
    Text = "<Blue:\"Gümüş Özsu\" × {s1} >harcayarak satın almak ister misiniz?\n\n<size=30><color=#ACBFCA>\"Gümüş Özsu\" harcanırken önce hediye edilen \"Gümüş Özsu\" düşülür.\n(Çıkarılan: {s2}, Hediye edilen: {s3})</color></size>"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_LeftBtnDesc = {Text = "İptal"},
  TipsType_PayMoneyBuyConfirmDescDetail_RightBtnDesc = {Text = "Satın Al"},
  TipsType_PayMoneyBuyConfirmDescDetail_Title = {
    Text = "Satın Alma Onayı"
  },
  TipsType_PublishEmptyCommentTips_Desc = {
    Text = "Yorum içeriği boş olamaz."
  },
  TipsType_PvpCollectionCommentDeleteTips_Desc = {
    Text = "Bu yorumu silmek istiyor musun?"
  },
  TipsType_PvpCollectionCommentDeleteTips_LeftBtnDesc = {Text = "İptal"},
  TipsType_PvpCollectionCommentDeleteTips_RightBtnDesc = {Text = "Onayla"},
  TipsType_PvpCollectionCommentDeleteTips_Title = {
    Text = "Silme Onayı"
  },
  TipsType_PvpHideCommentConfirm_Desc = {
    Text = "Bu Koruyucu'dan gelen tüm yorumlar gizlensin mi?"
  },
  TipsType_PvpHideCommentConfirm_LeftBtnDesc = {Text = "Hayır"},
  TipsType_PvpHideCommentConfirm_RightBtnDesc = {Text = "Evet"},
  TipsType_PvpHideCommentConfirm_Title = {Text = "Gizli"},
  TipsType_PvpMatchingInterruptTips_Desc = {
    Text = "Ağ hatası tespit edildi, eşleştirme kesintiye uğradı."
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Desc = {
    Text = "Hâlâ savaş devam ediyor, önceki savaşa devam edilsin mi? \n\"Hızlı Koşan Haz Treni\" sezonu güncellendi. Meydan okumaya devam ederek en yeni sezon görevlerini tamamlayabilirsiniz, ancak \"VIP Listesi\"ne giremezsiniz."
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_LeftBtnDesc = {Text = "İptal"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_RightBtnDesc = {Text = "Onayla"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Title = {
    Text = "Soruşturma Devam Ediyor"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Desc = {
    Text = "Son meydan okuma ilerlemeniz {s1} - {s2}. Aşama - {s3}. Savaş olup \"VIP Puanı\" × {s4} kazanıldı.\nSezon güncellendi. Meydan okumaya devam ederek en yeni sezon görevlerini tamamlayabilirsiniz, ancak \"VIP Listesi\"ne giremezsiniz. Meydan okumaya devam etmek istiyor musunuz?"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_LeftBtnDesc = {Text = "İptal"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_RightBtnDesc = {Text = "Onayla"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Title = {
    Text = "Mücadeleye Devam Et"
  },
  TipsType_RailWayContinueSaveStage_Desc = {
    Text = "İlerlemeyi Sürdür: {s1} - Aşama {s2} - Savaş {s3}.\nKazanılan VIP Puanı: {s4}.\nMeydan okumaya devam edilsin mi?"
  },
  TipsType_RailWayContinueSaveStage_LeftBtnDesc = {Text = "İptal"},
  TipsType_RailWayContinueSaveStage_RightBtnDesc = {Text = "Onayla"},
  TipsType_RailWayContinueSaveStage_Title = {
    Text = "Mücadeleye Devam Et"
  },
  TipsType_RailWayHaveSaveStage_Desc = {
    Text = "Yeni bir mücadeleye başlamadan önce önceki kaydedilmiş mücadeleyi bitirmeniz gerekiyor"
  },
  TipsType_RailWaySaveAndExitInBattleTips_Desc = {
    Text = "Meydan okumadan çıkılsın mı?\nİlerleme kaydedilecek. Devam ettiğinde mevcut savaş yeniden başlayacak."
  },
  TipsType_RailWaySaveAndExitInBattleTips_LeftBtnDesc = {Text = "İptal"},
  TipsType_RailWaySaveAndExitInBattleTips_RightBtnDesc = {Text = "Onayla"},
  TipsType_RailWaySaveAndExitInBattleTips_Title = {
    Text = "Kaydet ve Çık"
  },
  TipsType_RailWaySaveAndExitTips_Desc = {
    Text = "Şimdi çıkılsın mı?\nMevcut ilerleme kaydedilecek ve bir dahaki sefere buradan devam etmeyi seçebileceksiniz."
  },
  TipsType_RailWaySaveAndExitTips_LeftBtnDesc = {Text = "İptal"},
  TipsType_RailWaySaveAndExitTips_RightBtnDesc = {Text = "Onayla"},
  TipsType_RailWaySaveAndExitTips_Title = {
    Text = "Kaydet ve Çık"
  },
  TipsType_RailWaySeasonSwitchTips_Desc = {
    Text = "Sezon güncellendi. Meydan okumaya devam ederek en yeni sezon görevlerini tamamlayabilirsiniz, ancak \"VIP Listesi\"ne giremezsiniz."
  },
  TipsType_ReplayNullTips_Desc = {
    Text = "Tekrar oynatma bilgisi boş olamaz"
  },
  TipsType_SchoolConflictTips_Desc = {
    Text = "Diyar Çatışması. Lütfen dizilimi yeniden ayarla."
  },
  TipsType_SelectedAwakensAndCardsExceedLimit_Desc = {
    Text = "Seçilen sayı aşıldı"
  },
  TipsType_ServerRankDataLoading_Desc = {
    Text = "Sıralama verileri henüz yüklenmedi. Lütfen daha sonra arayüzü tekrar açın."
  },
  TipsType_ServerRankDataLoading_RightBtnDesc = {Text = "Onayla"},
  TipsType_ServerRankDataLoading_Title = {
    Text = "Sunucu Sıralama Verileri Başlatılıyor"
  },
  TipsType_ShopBulkBuyConfirm_Desc = {
    Text = "<Blue:{s3}> {s4} ile takas yapmak için <Blue:{s1}> {s2} kullanılacak. Satın almayı onaylıyor musunuz?"
  },
  TipsType_ShopBulkBuyConfirm_LeftBtnDesc = {Text = "İptal"},
  TipsType_ShopBulkBuyConfirm_RightBtnDesc = {Text = "Onayla"},
  TipsType_ShopBulkBuyConfirm_Title = {
    Text = "Kurtuluş Onayı"
  },
  TipsType_SocialRecordHideTips_Desc = {
    Text = "Savaş kayıtları gizlendi"
  },
  TipsType_SteamOverlayEnabledTips_Desc = {
    Text = "Lütfen Steam \"Ayarlar-Oyun İçi\" ve bu oyunun \"Özellikler-Genel\" bölümünden \"Oyun içinde Steam arayüzünü etkinleştir\" seçeneğini açın, ardından oyunu yeniden başlatarak tekrar deneyin."
  },
  TipsType_SteamOverlayEnabledTips_LeftBtnDesc = {Text = "Onayla"},
  TipsType_SteamOverlayEnabledTips_Title = {Text = "Not"},
  TipsType_SteamRestartTips_Desc = {
    Text = "Steam yetkilendirme hatası, lütfen Steam istemcisini yeniden başlatıp tekrar deneyin"
  },
  TipsType_SteamRestartTips_RightBtnDesc = {Text = "Onayla"},
  TipsType_SteamRestartTips_Title = {
    Text = "Giriş Hatası"
  },
  TipsType_SubBestExperienceTips_Chapter3_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_SubBestExperienceTips_Chapter3_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_SubBestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_SubBestExperienceTips_Chapter3_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_SubBestExperienceTips_Chapter5_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_SubBestExperienceTips_Chapter5_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_SubBestExperienceTips_Chapter5_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_SubBestExperienceTips_Chapter5_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Desc = {
    Text = "En iyi deneyim için önce aşağıdaki aşamaları tamamlayın"
  },
  TipsType_SubBestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "Çıkış"},
  TipsType_SubBestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "Yine de Devam Et"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Title = {
    Text = "Soruşturmaya Devam Edilsin mi?"
  },
  TipsType_SummonFailureTips_Desc = {
    Text = "Uyandırma malzeme maliyetleri değişti, lütfen Yeniden Uyandırma'yı deneyin"
  },
  TipsType_SummonPriorityNotEnoughTips_Desc = {
    Text = "{s1} <Blue:\"{s2}\"> eksik. Bunun yerine <Blue:{s4} × {s3} > harcansın mı?"
  },
  TipsType_SummonPriorityNotEnoughTips_LeftBtnDesc = {Text = "İptal"},
  TipsType_SummonPriorityNotEnoughTips_RightBtnDesc = {Text = "Onayla"},
  TipsType_SummonPriorityNotEnoughTips_Title = {
    Text = "Kurtuluş Onayı"
  },
  TipsType_SummonType_14SelectConfirm_BottomDesc = {
    Text = "<Blue:Note: Seçimini yaptıktan sonra, bu etkinlik süresince değiştirilemez!>"
  },
  TipsType_SummonType_14SelectConfirm_Desc = {
    Text = "Uyandıran <OrangeQuality:{s1}, {s2}, {s3}, {s4}> seçimini onayla?"
  },
  TipsType_SummonType_14SelectConfirm_LeftBtnDesc = {Text = "İptal"},
  TipsType_SummonType_14SelectConfirm_RightBtnDesc = {Text = "Onayla"},
  TipsType_SummonType_14SelectConfirm_Title = {
    Text = "Seçimi Onayla"
  },
  TipsType_SummonType_14SelectLimitTips_BottomDesc = {
    Text = "<Blue:Note: Seçimini yaptıktan sonra, bu etkinlik süresince değiştirilemez!>"
  },
  TipsType_SummonType_14SelectLimitTips_Desc = {
    Text = "Seçim sınırına ulaşıldı"
  },
  TipsType_SummonType_17IncompleteSelectionTips_Desc = {
    Text = "Lütfen tekrar denemeden önce tüm seçim türlerini tamamlayın"
  },
  TipsType_SummonType_17SelectConfirm_Desc = {
    Text = "Belirlenen Uyandırıcı seçimi tamamlansın mı?\nOnaylandıktan sonra bu dönemin seçimi bir daha değiştirilemez."
  },
  TipsType_SummonType_17SelectConfirm_LeftBtnDesc = {Text = "İptal"},
  TipsType_SummonType_17SelectConfirm_RightBtnDesc = {Text = "Onayla"},
  TipsType_SummonType_17SelectConfirm_Title = {
    Text = "Seçimi Onayla"
  },
  TipsType_SupportListLatestTips_Desc = {
    Text = "En güncel Durum bu, daha fazla Destek seçeneği edinmek için daha fazla mezun arkadaşını takip et!"
  },
  TipsType_TrinketAutoRefineExitTips_Desc = {
    Text = "Otomatik Transkripsiyon devam ediyor, işlem kullanılamaz."
  },
  TipsType_TrinketAutoRefineTips_BottomDesc = {
    Text = "(Kilidi açılmış bir stat 8'e ulaştığında Otomatik Transkripsiyon durur.)"
  },
  TipsType_TrinketAutoRefineTips_Desc = {
    Text = [[
En fazla {s1} kez kopyala
En fazla harca]]
  },
  TipsType_TrinketAutoRefineTips_LeftBtnDesc = {Text = "İptal"},
  TipsType_TrinketAutoRefineTips_RightBtnDesc = {Text = "Onayla"},
  TipsType_TrinketAutoRefineTips_Title = {
    Text = "Otomatik Transkripsiyon Onayı"
  },
  TipsType_TrinketBagFullTips_Desc = {
    Text = "Ahit çantası dolu"
  },
  TipsType_TrinketBatchUnbindTips_Desc = {
    Text = "Tüm Ahitlerin bağı kaldırılsın mı?"
  },
  TipsType_TrinketBatchUnbindTips_LeftBtnDesc = {Text = "İptal"},
  TipsType_TrinketBatchUnbindTips_RightBtnDesc = {Text = "Onayla"},
  TipsType_TrinketBatchUnbindTips_Title = {
    Text = "Bağı Kaldırma Onayı"
  },
  TipsType_TrinketBindSaveTips_Desc = {
    Text = "Bağlı Ahitler var, plan olarak kaydedilemez!"
  },
  TipsType_TrinketBindTips_Desc = {
    Text = "Aşağıdaki Ahit birleştirilsin mi? Başka bir Uyandırıcı tarafından donanılmış olan veya ekip/plan/destek içinde bulunan Ahitler otomatik olarak çıkarılacaktır."
  },
  TipsType_TrinketBindTips_LeftBtnDesc = {Text = "İptal"},
  TipsType_TrinketBindTips_RightBtnDesc = {Text = "Onayla"},
  TipsType_TrinketBindTips_Title = {
    Text = "Bağlamayı Değiştirme Onayı"
  },
  TipsType_TrinketChangeBindTips_Desc = {
    Text = "Bağlama değiştirilsin mi?"
  },
  TipsType_TrinketChangeBindTips_LeftBtnDesc = {Text = "İptal"},
  TipsType_TrinketChangeBindTips_RightBtnDesc = {Text = "Onayla"},
  TipsType_TrinketChangeBindTips_Title = {
    Text = "Bağlamayı Değiştirme Onayı"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_Desc = {
    Text = "Tüm Ahit setlerinin bağı kaldırılsın mı?\n\n<color=#9BA3A2><size=30>+12 Ahit parçası harcanacak.</size></color>"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_LeftBtnDesc = {Text = "İptal"},
  TipsType_TrinketHighLevelBatchUnbindTips_RightBtnDesc = {Text = "Onayla"},
  TipsType_TrinketHighLevelBatchUnbindTips_Title = {
    Text = "Bağı Kaldırma Onayı"
  },
  TipsType_TrinketHighLevelChangeBindTips_Desc = {
    Text = "Değişiklik onaylansın mı?\n\n<color=#9BA3A2><size=30>+12 Ahit parçası harcanacak.</size></color>"
  },
  TipsType_TrinketHighLevelChangeBindTips_LeftBtnDesc = {Text = "İptal"},
  TipsType_TrinketHighLevelChangeBindTips_RightBtnDesc = {Text = "Onayla"},
  TipsType_TrinketHighLevelChangeBindTips_Title = {
    Text = "Bağlamayı Değiştirme Onayı"
  },
  TipsType_TrinketHighLevelUnbindTips_Desc = {
    Text = "Bu Ahit seti çözülsün mü?\n\n<color=#9BA3A2><size=30>+12 Ahit parçası harcanacak.</size></color>"
  },
  TipsType_TrinketHighLevelUnbindTips_LeftBtnDesc = {Text = "İptal"},
  TipsType_TrinketHighLevelUnbindTips_RightBtnDesc = {Text = "Onayla"},
  TipsType_TrinketHighLevelUnbindTips_Title = {
    Text = "Bağı Kaldırma Onayı"
  },
  TipsType_TrinketUnbindTips_Desc = {
    Text = "Bu Ahit'in bağı kaldırılsın mı?"
  },
  TipsType_TrinketUnbindTips_LeftBtnDesc = {Text = "İptal"},
  TipsType_TrinketUnbindTips_RightBtnDesc = {Text = "Onayla"},
  TipsType_TrinketUnbindTips_Title = {
    Text = "Bağı Kaldırma Onayı"
  },
  TipsType_TryAgainLaterTips_Desc = {
    Text = "<color=#5EF2FF>Şifre</color> şu anda kullanımda, lütfen daha sonra tekrar dene"
  },
  TipsType_WaitOppositeSideAccept_Desc = {
    Text = [[
Bekleniyor:
{s1}
<Blue:{s2}> davetini kabul etsin...]]
  },
  TipsType_WaitOppositeSideAccept_LeftBtnDesc = {Text = "İptal"},
  TipsType_WaitOppositeSideAccept_Title = {
    Text = "Şifre Modu"
  },
  TipsType_WaitOthersEnter_Desc = {
    Text = "Diğer Koruyucuların girmesi bekleniyor\n<Blue:{s1}>\nŞifreli Eşleşme Savaşı"
  },
  TipsType_WaitOthersEnter_LeftBtnDesc = {Text = "İptal"},
  TipsType_WaitOthersEnter_RightBtnDesc = {
    Text = "<color=#5EF2FF>Şifreyi</color> kopyala"
  },
  TipsType_WaitOthersEnter_Title = {
    Text = "Şifre Modu"
  },
  TipsType_WeaponRandomChestConfirm_Desc = {
    Text = "1 <Blue:rastgele> Kader Çarkı elde etmek için <Blue:{s1}> kullanmayı onaylıyor musunuz?"
  },
  TipsType_WeaponRandomChestConfirm_LeftBtnDesc = {Text = "İptal"},
  TipsType_WeaponRandomChestConfirm_RightBtnDesc = {Text = "Onayla"},
  TipsType_WeaponRandomChestConfirm_Title = {
    Text = "Kullanım Onayı"
  },
  TipsType_WeekChallengeSweepTips_Desc = {
    Text = "Bu hafta elde edilen ödül sayısı tükendi, yeniden canlandırma yapılamıyor."
  }
})
return Text_TipsType
