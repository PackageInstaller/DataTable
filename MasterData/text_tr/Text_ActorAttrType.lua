__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ActorAttrType = readonly({
  ActorAttrType_121209_AttributeDesc = {
    Text = "Yasak Bilgi Seviyesi (YB), Koruyucu Seviyesine (KS) eşit olarak başlar ve üç araştırma derinliğinin gücünü belirler. Uyandırıcıların ve Koruyucu Seviyesinin ortalaması KS'den büyükse, YB bu ortalamaya eşitlenir.\nBedensel Araştırma: <Blue:{s1}>\nUyandırıcının KON değerinin her 100 puanı için ne kadar Takım Can kazanılacağını belirler.\nEzoterik Araştırma: <Blue:{s2}>\nKalıntılar, Mühürler ve Müfrezeler tarafından sağlanan GÜÇ Üretimi, Dokunaç Hasarı, Kalkan, HP Yenilenmesi ve GÜÇ Azaltma etkilerinin gücünü belirler.\nOkült Araştırma: <Blue:{s3}>\nKalıntılar, Mühürler ve Müfrezeler tarafından sağlanan Sabit Zehir, Sabit Karşı Saldırı, Sabit Hasar ve Sabit Kanama etkilerinin gücünü belirler.\n"
  },
  ActorAttrType_121209_Text = {
    Text = "Yasak Bilgi"
  },
  ActorAttrType_18103_Text = {Text = "Kalkan"},
  ActorAttrType_18104_Text = {
    Text = "Vuruş Hasarı % Ayarı"
  },
  ActorAttrType_18105_AttributeUpText = {
    Text = "Kritik Hasar +{s1}"
  },
  ActorAttrType_18105_Text = {
    Text = "Kritik Hasar"
  },
  ActorAttrType_18106_Text = {
    Text = "Kalkan Artışı"
  },
  ActorAttrType_18107_AttributeUpText = {Text = "SLD+{s1}"},
  ActorAttrType_18107_Text = {Text = "SLD"},
  ActorAttrType_18108_Text = {Text = "KON"},
  ActorAttrType_18109_Text = {
    Text = "Kart Hasarı % Ayarı"
  },
  ActorAttrType_18110_Text = {
    Text = "Kırılgan % Ayarı"
  },
  ActorAttrType_18111_Text = {
    Text = "Alınan Kalkan % Ayarı"
  },
  ActorAttrType_18112_AttributeUpText = {
    Text = "Savunma +{s1}"
  },
  ActorAttrType_18112_Text = {Text = "Savunma+"},
  ActorAttrType_18113_AttributeDesc = {
    Text = "Uyandırıcının Aliemus Yenilenmesi"
  },
  ActorAttrType_18113_Text = {
    Text = "Başlangıç Aliemus"
  },
  ActorAttrType_18114_AttributeDesc = {
    Text = "KON ne kadar yüksekse Uyandırıcı'nın Maksimum canı da o kadar yüksek olur.\nKoruyucu Seviyeniz ne kadar yüksekse KON'un Uyandırıcı'nın Maksimum canı üzerindeki etkisi de o kadar güçlü olur."
  },
  ActorAttrType_18114_AttributeUpText = {Text = "KON+{s1}"},
  ActorAttrType_18114_Text = {Text = "KON"},
  ActorAttrType_18115_AttributeDesc = {
    Text = "Taşkınlık sonrası iade edilen Aliemus"
  },
  ActorAttrType_18115_AttributeUpText = {
    Text = "Aliemus Maliyeti-{s1}"
  },
  ActorAttrType_18115_Text = {
    Text = "Aliemus Maliyeti-"
  },
  ActorAttrType_18116_AttributeDesc = {
    Text = "KON ne kadar yüksekse Uyandırıcı'nın Maksimum canı da o kadar yüksek olur.\nKoruyucu Seviyeniz ne kadar yüksekse KON'un Uyandırıcı'nın Maksimum canı üzerindeki etkisi de o kadar güçlü olur."
  },
  ActorAttrType_18116_AttributeUpText = {Text = "KON+{s1}"},
  ActorAttrType_18116_Text = {Text = "KON+"},
  ActorAttrType_18117_Text = {
    Text = "Dokunaç Hasarı"
  },
  ActorAttrType_18118_Text = {
    Text = "Ultra Yuvalar"
  },
  ActorAttrType_18119_Text = {
    Text = "Alınan Hasar % Ayarı"
  },
  ActorAttrType_18120_AttributeDesc = {
    Text = "Uyandırıcının Maksimum Aliemus Sınırı ve Taşkınlık Aliemus Maliyeti, Temel Aliemus değerine eşittir."
  },
  ActorAttrType_18120_AttributeUpText = {
    Text = "Aliemus Sınırı +{s1}"
  },
  ActorAttrType_18120_Text = {
    Text = "Temel Aliemus"
  },
  ActorAttrType_18121_AttributeDesc = {
    Text = "Beceri 2 Seviyesi"
  },
  ActorAttrType_18121_AttributeUpText = {
    Text = "Beceri 2 Seviyesi +{s1}"
  },
  ActorAttrType_18121_Text = {
    Text = "Beceri 2 Seviyesi"
  },
  ActorAttrType_18122_AttributeDesc = {
    Text = "Savunma Seviyesi"
  },
  ActorAttrType_18122_AttributeUpText = {
    Text = "Savunma Seviyesi +{s1}"
  },
  ActorAttrType_18122_Text = {
    Text = "Savunma Seviyesi"
  },
  ActorAttrType_18123_Text = {
    Text = "Vuruş Sayısı Ayarı"
  },
  ActorAttrType_18124_Text = {
    Text = "Kalkan Değeri Ayarı"
  },
  ActorAttrType_18125_Text = {
    Text = "Alınan Kalkan Sayı Ayarı"
  },
  ActorAttrType_18126_AttributeDesc = {
    Text = "Takımın Diyar Ustalığı, takımdaki Uyandırıcıların Diyar Ustalığının toplamına eşittir. Diyar Ustalığı, takımın Yetenek etkilerini güçlendirebilir. Mevcut takım \"Saf Aequor/Saf Caro/Saf Ultra\" ise, Diyar Ustalığı etkileri iki katına çıkar.\n<Blue:Kaos> Diyarındaki bir takım için, her 1 Diyar Ustalığı puanı başına, bir Müfreze serbest bırakıldığında tüm Uyandırıcılar ek olarak <Blue:0,05> Aliemus kazanır.\n<Blue:Aequor> Diyarındaki bir takım için, her 1 Diyar Ustalığı puanı başına, bir Taşkınlık serbest bırakıldıktan sonra ek bir Dokunaç Toplama yığını kazanma şansı <Blue:%0,25> artar (olasılık %100'ü aşarsa birden fazla yığın elde edilebilir). \"Durgun Deniz\"e geçildiğinde kazanılan kalkan Maksimum canın +<Blue:%0,01>'i kadar artar ve \"Öfkeli Dalgalar\"da Aktif Hasar tarafından tetiklenen Dokunaç Saldırıları, Dokunaç Hasarını <Blue:%0,02> artırır.\n<Blue:Caro> Diyarındaki bir takım için, her 1 Diyar Ustalığı puanı başına, her turda ilk kez Yutma tetiklendiğinde Maksimum canın <Blue:%0,01>'i kadar Kalkan ve <Blue:%0,005> Geçici GÜÇ kazanılır (kaybedilen Can ile artar, en fazla %100).\n<Blue:Ultra> Diyarındaki bir takım için, her 1 Diyar Ustalığı puanı başına, tur başlangıcında 1 \"Kavrayış\" kazanma şansı <Blue:%0,125> artar (olasılık %100'ü aşarsa birden fazla kazanılabilir)."
  },
  ActorAttrType_18126_AttributeUpText = {
    Text = "Diyar Ustalığı +{s1}"
  },
  ActorAttrType_18126_Text = {
    Text = "Diyar Ustalığı"
  },
  ActorAttrType_18127_Text = {Text = "Can"},
  ActorAttrType_18128_AttributeUpText = {Text = "SLD+{s1}"},
  ActorAttrType_18128_Text = {Text = "SLD+"},
  ActorAttrType_18129_AttributeDesc = {
    Text = "Temel Hasar Bonusu ne kadar yüksekse, Uyandırıcı o kadar fazla Hasar verir"
  },
  ActorAttrType_18129_AttributeUpText = {
    Text = "Temel Hasar +{s1}"
  },
  ActorAttrType_18129_Text = {
    Text = "Temel Hasar"
  },
  ActorAttrType_18130_Text = {
    Text = "Koruyucu TP"
  },
  ActorAttrType_18131_AttributeDesc = {
    Text = "Tur sonunda otomatik olarak yenilenen Aliemus miktarı"
  },
  ActorAttrType_18131_AttributeUpText = {
    Text = "Aliemus Otomatik İyileşme +{s1}"
  },
  ActorAttrType_18131_Text = {
    Text = "Aliemus Otomatik Yenilenme"
  },
  ActorAttrType_18132_Text = {
    Text = "Aydınlanma Seviyesi"
  },
  ActorAttrType_18133_Text = {
    Text = "Alınan Aliemus % Ayarı"
  },
  ActorAttrType_18134_Text = {
    Text = "Embriyo Füzyonu Limiti"
  },
  ActorAttrType_18135_Text = {
    Text = "Mevcut Aliemus"
  },
  ActorAttrType_18136_Text = {
    Text = "Alınan Hasar Sayı Ayarı"
  },
  ActorAttrType_18137_AttributeDesc = {
    Text = "Uyandırıcıların ürettiği Kalkanı ve iyileştirilen Canı yüzdesel olarak artırır"
  },
  ActorAttrType_18137_AttributeUpText = {
    Text = "Kalkan ve İyileştirme Güçlendirmesi +{s1}"
  },
  ActorAttrType_18137_Text = {
    Text = "Kalkan ve İyileştirme Güçlendirmesi"
  },
  ActorAttrType_18138_Text = {
    Text = "İyileştirme Artışı"
  },
  ActorAttrType_18139_AttributeDesc = {
    Text = "Bir Komut Kartı oynadığında veya Uyanış gerçekleştiğinde, harcanan her 1 Arithmetica başına {s1} S-Enerjisi kazanırsın. Bu özellik arttıkça, ek olarak kazanılan S-Enerjisi miktarı giderek azalır."
  },
  ActorAttrType_18139_AttributeUpText = {
    Text = "Anahtar Parıltısı Yenilenmesi +{s1}"
  },
  ActorAttrType_18139_Text = {
    Text = "Gümüş Anahtar Şarjı Seviyesi"
  },
  ActorAttrType_18140_Text = {
    Text = "Ölüm Direnci Sayısı"
  },
  ActorAttrType_18141_AttributeDesc = {
    Text = "Saldırı Seviyesi"
  },
  ActorAttrType_18141_AttributeUpText = {
    Text = "Saldırı Seviyesi +{s1}"
  },
  ActorAttrType_18141_Text = {
    Text = "Saldırı Seviyesi"
  },
  ActorAttrType_18142_AttributeDesc = {
    Text = "Tüm Uyandırıcıların \"Temel Hasarını\", \"Sabit Değer Zehir\" ve \"Sabit Değer Karşı Saldırı\" yığınlarını ve başlangıç Dokunaç Hasarını yüzdesel olarak artırır."
  },
  ActorAttrType_18142_AttributeUpText = {
    Text = "Hasar Güçlendirmesi +{s1}"
  },
  ActorAttrType_18142_Text = {
    Text = "Hasar Güçlendirmesi"
  },
  ActorAttrType_18143_Text = {
    Text = "Taşkınlık Hasarı % Ayarı"
  },
  ActorAttrType_18144_AttributeDesc = {
    Text = "Uyandırıcılar tarafından saldırıya uğradığında gelen Kritik Vuruşa direnme şansı"
  },
  ActorAttrType_18144_AttributeUpText = {
    Text = "Krit. Direnci +{s1}"
  },
  ActorAttrType_18144_Text = {
    Text = "Krit. Direnci"
  },
  ActorAttrType_18145_AttributeDesc = {
    Text = "Taşkınlık Seviyesi"
  },
  ActorAttrType_18145_AttributeUpText = {
    Text = "Taşkınlık Sv. +{s1}"
  },
  ActorAttrType_18145_Text = {
    Text = "Taşkınlık Seviyesi"
  },
  ActorAttrType_18146_Text = {
    Text = "Alınan İyileştirme Sayı Ayarı"
  },
  ActorAttrType_18147_AttributeUpText = {
    Text = "Şanslı Orison Oranı +{s1}"
  },
  ActorAttrType_18147_Text = {
    Text = "Şanslı Mühür Oranı"
  },
  ActorAttrType_18148_Text = {
    Text = "İyileştirme Değeri Ayarı"
  },
  ActorAttrType_18149_Text = {Text = "KON+"},
  ActorAttrType_18150_Text = {
    Text = "Semptom: Zayıflık % Ayarı"
  },
  ActorAttrType_18151_AttributeDesc = {
    Text = "Takımınızın Direnci, takımdaki tüm Uyandırıcıların Direncinin toplamına eşittir. Savaşta ölümcül bir darbe aldığınızda, Direncin tetiklenme ve 1 Can puanı ile hayatta kalma şansı vardır. Tetiklendikten sonra, bir sonraki turda ek olarak 2 Arithmetica kazanır ve 2 kart çekersiniz. Mevcut ve sonraki Direnç yüzdesi, Operasyon sona erene kadar yarıya düşer."
  },
  ActorAttrType_18151_AttributeUpText = {
    Text = "Direnç +{s1}"
  },
  ActorAttrType_18151_Text = {Text = "Direnç"},
  ActorAttrType_18152_Text = {
    Text = "Aliemus % Ayarı"
  },
  ActorAttrType_18154_Text = {
    Text = "Dokunaç Sınırı"
  },
  ActorAttrType_18155_AttributeDesc = {
    Text = "Kara Mühür düşüşünü yüzdesel olarak artırır"
  },
  ActorAttrType_18155_AttributeUpText = {
    Text = "Mühür Hasadı +{s1}"
  },
  ActorAttrType_18155_Text = {
    Text = "Mühür Hasadı"
  },
  ActorAttrType_18156_Text = {
    Text = "Alınan Aliemus Sayı Ayarı"
  },
  ActorAttrType_18157_Text = {
    Text = "Gizli Niyetler"
  },
  ActorAttrType_18158_Text = {
    Text = "Hasar Değeri Ayarı"
  },
  ActorAttrType_18159_AttributeUpText = {
    Text = "Kritik Oranı +{s1}"
  },
  ActorAttrType_18159_Text = {
    Text = "Kritik Oranı"
  },
  ActorAttrType_18160_AttributeDesc = {
    Text = "Beceri 1 Seviyesi"
  },
  ActorAttrType_18160_AttributeUpText = {
    Text = "Beceri 1 Seviyesi +{s1}"
  },
  ActorAttrType_18160_Text = {
    Text = "Beceri 1 Seviyesi"
  },
  ActorAttrType_18161_Text = {
    Text = "Koruyucu TP"
  },
  ActorAttrType_18162_Text = {
    Text = "Hasar Artışı"
  },
  ActorAttrType_18163_Text = {
    Text = "Dokunaç Sayısı"
  },
  ActorAttrType_18164_Text = {
    Text = "Alınan İyileştirme % Ayarı"
  },
  ActorAttrType_18165_Text = {
    Text = "Maksimum Arithmetica"
  },
  ActorAttrType_18166_Text = {
    Text = "Savunmasız % Ayarı"
  },
  ActorAttrType_18167_AttributeUpText = {
    Text = "Savunma +{s1}"
  },
  ActorAttrType_18167_Text = {Text = "Savunma"},
  ActorAttrType_18168_AttributeDesc = {
    Text = "Uyanış Seviyesi"
  },
  ActorAttrType_18168_AttributeUpText = {
    Text = "Uyanış Seviyesi +{s1}"
  },
  ActorAttrType_18168_Text = {
    Text = "Uyanış Seviyesi"
  },
  ActorAttrType_21322_Text = {
    Text = "Gümüş Anahtar Şarjı"
  },
  ActorAttrType_22207_AttributeDesc = {
    Text = "Her Taşkınlık sonrasında {s1} Aliemus yenilenir. Bu Nitelik arttıkça ekstra Aliemus yenilenme bonusu azalır."
  },
  ActorAttrType_22207_AttributeUpText = {
    Text = "Aliemus Yenilenme Seviyesi +{s1}"
  },
  ActorAttrType_22207_Text = {
    Text = "Aliemus Yenilenme Seviyesi"
  },
  ActorAttrType_22214_Text = {
    Text = "Aliemus Yenilenmesi"
  }
})
return Text_ActorAttrType
