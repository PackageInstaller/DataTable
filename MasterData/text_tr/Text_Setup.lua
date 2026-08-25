__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Setup = readonly({
  Setup_117381_SetupTitle = {
    Text = "(Çevirmenler İçin) Metin Anahtarını Değiştir"
  },
  Setup_126062_SetupTitle = {Text = "Anahat"},
  Setup_132685_SetupDesc = {
    Text = "Mevcut dilinizde hangi bölümlerin insan tarafından çevrildiğini görün!"
  },
  Setup_132685_SetupTitle = {
    Text = "Resmi çevirisi tamamlanan Soruşturma bölümleri için etiket göster"
  },
  Setup_134015_SetupTitle = {
    Text = "Giriş Arka Planını Değiştir"
  },
  Setup_148459_SetupDesc = {
    Text = "Afinite Seviyesi 20'ye ulaşıldığında, bu Uyandırıcı Operasyon ve Traphase savaşlarında özel bir kart görünümü sergileyecektir."
  },
  Setup_148459_SetupTitle = {
    Text = "\"Scintilla\" Etkisi"
  },
  Setup_18433_SetupTitle = {Text = "Oyun Metni"},
  Setup_18434_SetupTitle = {
    Text = "Kenar Yumuşatma"
  },
  Setup_18436_SetupTitle = {
    Text = "Görüntü İşleme Kalitesi"
  },
  Setup_18438_SetupTitle = {
    Text = "Kızıl-Mavi Kayma"
  },
  Setup_18439_SetupTitle = {Text = "Yansıtma"},
  Setup_18441_SetupTitle = {
    Text = "Menofin Yenilendi"
  },
  Setup_18443_SetupTitle = {
    Text = "Taşkınlık ve Müfreze Onayı"
  },
  Setup_18444_SetupTitle = {
    Text = "Görüntü Kalitesi"
  },
  Setup_18445_SetupTitle = {
    Text = "Alan Derinliği"
  },
  Setup_18448_SetupTitle = {
    Text = "Sahne Etkileri"
  },
  Setup_18449_SetupTitle = {
    Text = "Kullanıcı Merkezi"
  },
  Setup_18453_SetupTitle = {Text = "Ses"},
  Setup_18454_SetupTitle = {Text = "Müzik"},
  Setup_18455_SetupTitle = {
    Text = "Görev Tamamlandı"
  },
  Setup_18456_SetupTitle = {Text = "Tomurcuk"},
  Setup_18458_SetupTitle = {
    Text = "Gerçek Zamanlı Aydınlatma"
  },
  Setup_18459_SetupTitle = {
    Text = "Ses Efektleri"
  },
  Setup_18460_SetupTitle = {
    Text = "Kullanıcı Sözleşmesi"
  },
  Setup_18461_SetupTitle = {
    Text = "Bulanık Kenar Kırpma"
  },
  Setup_18462_SetupTitle = {
    Text = "Ses Düzeyi"
  },
  Setup_18463_SetupTitle = {
    Text = "Kurtuluş Kodu"
  },
  Setup_18466_SetupTitle = {
    Text = "Özel Efekt Kalitesi"
  },
  Setup_18469_SetupDesc = {
    Text = "30 FPS daha az enerji harcar, 60 FPS ise daha akıcıdır."
  },
  Setup_18469_SetupTitle = {
    Text = "Hedef Kare Hızı"
  },
  Setup_21931_SetupTitle = {
    Text = "Destek ile İletişime Geç"
  },
  Setup_24952_SetupDesc = {
    Text = "Etkinleştirildiğinde, Ana Arayüz, Soruşturma Arayüzü ve diğerleri jiroskoptan etkilenecektir."
  },
  Setup_24952_SetupTitle = {Text = "Jiroskop"},
  Setup_54468_SetupTitle = {
    Text = "Grafik Ayarları"
  },
  Setup_54469_SetupTitle = {
    Text = "Çözünürlük"
  },
  Setup_54664_SetupTitle = {
    Text = "Kısayolları Göster"
  },
  Setup_54673_SetupTitle = {
    Text = "Kart 8’i Seç"
  },
  Setup_54674_SetupTitle = {
    Text = "Kart 9’u Seç"
  },
  Setup_54675_SetupTitle = {
    Text = "Kart 2’yi Seç"
  },
  Setup_54676_SetupTitle = {
    Text = "Kart 3’ü Seç"
  },
  Setup_54677_SetupTitle = {Text = "Müfreze"},
  Setup_54678_SetupTitle = {
    Text = "Kart 6’yı Seç"
  },
  Setup_54679_SetupTitle = {
    Text = "Kart 7’yi Seç"
  },
  Setup_54680_SetupTitle = {
    Text = "Kart 4’ü Seç"
  },
  Setup_54681_SetupTitle = {
    Text = "Kart 5’i Seç"
  },
  Setup_54682_SetupTitle = {
    Text = "Taşkınlık 1"
  },
  Setup_54683_SetupTitle = {
    Text = "Taşkınlık 2"
  },
  Setup_54684_SetupTitle = {
    Text = "Taşkınlık 3"
  },
  Setup_54685_SetupTitle = {
    Text = "Taşkınlık 4"
  },
  Setup_54686_SetupTitle = {
    Text = "Çekme Desteğini Görüntüle"
  },
  Setup_54687_SetupTitle = {
    Text = "Kart 20’yi Seç"
  },
  Setup_54688_SetupTitle = {Text = "Eli Bitir"},
  Setup_54689_SetupTitle = {
    Text = "Kart 1’i Seç"
  },
  Setup_54690_SetupTitle = {
    Text = "İptal ve Ayarlar"
  },
  Setup_54691_SetupTitle = {
    Text = "Diyar Yeteneği 1"
  },
  Setup_54692_SetupTitle = {
    Text = "Kart 10’u Seç"
  },
  Setup_54693_SetupTitle = {
    Text = "Kart 11’i Seç"
  },
  Setup_54694_SetupTitle = {
    Text = "Kart 12’yi Seç"
  },
  Setup_54695_SetupTitle = {
    Text = "Kart 13’ü Seç"
  },
  Setup_54696_SetupTitle = {
    Text = "Kart 14’ü Seç"
  },
  Setup_54697_SetupTitle = {
    Text = "Kart 15’i Seç"
  },
  Setup_54698_SetupTitle = {
    Text = "Kart 16’yı Seç"
  },
  Setup_54699_SetupTitle = {
    Text = "Kart 17’yi Seç"
  },
  Setup_54700_SetupTitle = {
    Text = "Kart 18’i Seç"
  },
  Setup_54701_SetupTitle = {
    Text = "Kart 19’u Seç"
  },
  Setup_55509_SetupTitle = {
    Text = "Oyundan Çık"
  },
  Setup_70541_SetupTitle = {
    Text = "Arka Planda Oynatma"
  },
  Setup_72153_SetupTitle = {
    Text = "Diyar Yeteneği 2"
  },
  Setup_94404_SetupTitle = {Text = "Kart Oyna"},
  Setup_94405_SetupTitle = {
    Text = "Önceki Kart"
  },
  Setup_94406_SetupTitle = {
    Text = "Sonraki Kart"
  },
  Setup_94566_SetupTitle = {
    Text = "Savaş Dinamik Arka Planı"
  }
})
return Text_Setup
