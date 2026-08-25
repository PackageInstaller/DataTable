__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TrinketSuitEffect = readonly({
  TrinketSuitEffect_18335_Name = {
    Text = "Nisan Övgüsü"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_1 = {
    Text = "Krit. Hasar +%7,2"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Takıma Özel>: Tur başında, düşmanların toplam HP'si %75'in üzerindeyse, Kuşananın Geçici Kritik Oranı ve Krit. Hasarı %35 artar."
  },
  TrinketSuitEffect_18336_Name = {
    Text = "Dairesel Şiir (Tamamlanmamış)"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_1 = {
    Text = "Ölüm Direnci +%16,8"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_2 = {
    Text = "Çift sayılı turların başında, Elde bulunan rastgele bir kartın Arithmetica Maliyeti 1 azaltılır."
  },
  TrinketSuitEffect_18337_Name = {
    Text = "Dönüş Hattı"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_1 = {
    Text = "Diyar Ustalığı +12"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Takıma Özel>: Bir sonraki savaşın başında, kullananın SLD’sinin %12’sine eşit GÜÇ kazan. Mevcut Diyar Aequor ise, etki şu şekilde değişir: \"Tur başında, (50 + 0.25 * takımın Diyar Ustalığı)% ihtimalle 1 yığın Dokunaç Toplanması kazan. Olasılık %100’ü aşarsa birden fazla yığın kazanılabilir ve Reis Savaşı sırasında bu ihtimal ikiye katlanır.\""
  },
  TrinketSuitEffect_18338_Name = {
    Text = "Lanetli Tavşan"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_1 = {
    Text = "Diyar Ustalığı +12"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_2 = {
    Text = "Kuşananın Kalkanı ve HP Yenilenmesi %12 artar."
  },
  TrinketSuitEffect_18339_Name = {Text = "Paradoks"},
  TrinketSuitEffect_18339_SuitEffectDesc_1 = {
    Text = "Anahtar Parıltısı Yenilenme Seviyesi +7,2"
  },
  TrinketSuitEffect_18339_SuitEffectDesc_2 = {
    Text = "<TeamUnique:Takıma Özel>: Kuşananın Temel Aliemus'unu 20 artırır. Kuşananın Komut Kartlarının Krit. Oranı, Krit. Hasarı, Karakter Kalkanı ve HP Yenilenmesini %20 artırır."
  },
  TrinketSuitEffect_18340_Name = {
    Text = "Organik Form"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_1 = {
    Text = "Mühür Hasadı +%3,6"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Takıma Özel>. Keşif başlangıcında, en fazla %100 Ölüm Direnci azalt. Azaltılan her %1 için, Kuşanan’ın Aliemus’unu %0,15 artır."
  },
  TrinketSuitEffect_18341_Name = {
    Text = "Kızıl Çarpıntı"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_1 = {
    Text = "Krit. Hasar +%7,2"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_2 = {
    Text = "Çeteyi serbest bıraktıktan sonra, Kuşanan %30 Geçici Kritik Oranı kazanır."
  },
  TrinketSuitEffect_18342_Name = {
    Text = "Standart Ahit SSR"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_1 = {
    Text = "Ölüm Direnci +%16,8"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_2 = {
    Text = "Kuşananın ürettiği Hasar, İyileştirme ve Kalkan %15 artırılır."
  },
  TrinketSuitEffect_18343_Name = {
    Text = "Standart Ahit R"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_1 = {
    Text = "Ölüm Direnci +%16,8"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_2 = {
    Text = "Kuşananın ürettiği Hasar, İyileştirme ve Kalkan %15 artırılır."
  },
  TrinketSuitEffect_18344_Name = {
    Text = "Deus Ex Machina"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_1 = {
    Text = "Diyar Ustalığı +12"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_2 = {
    Text = "Her savaşın ilk turunda 1 Arithmetica kazan, ve Reis Savaşları sırasında her 4 turda bir ek 1 Arithmetica daha kazan."
  },
  TrinketSuitEffect_18345_Name = {
    Text = "Fotosentez Ayini"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_1 = {
    Text = "Hasar Güçlendirmesi +%7,2"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Takım Özgünlüğü>: Kullananın Komut Kartı Ultra Uzay'a girdikten sonra, Embriyo Füzyonu +25~50 kazandırır. Mevcut Can ne kadar düşükse, kazanılan Embriyo Füzyonu o kadar yüksek olur."
  },
  TrinketSuitEffect_18346_Name = {
    Text = "Yeniden Evrim"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_1 = {
    Text = "Aliemus Dolum Seviyesi +2.4"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_2 = {
    Text = "<TeamUnique:Takıma Özel>: Keşif başlangıcında 35 Aliemus kazan. Bu savaşta Yüceltme kullandıktan sonra, tur sonunda 2 Aliemus kazan. Bu Etki en fazla 3 yığına kadar birikebilir."
  },
  TrinketSuitEffect_18347_Name = {
    Text = "Yaşam Gücü Emilimi"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_1 = {
    Text = "Anahtar Parıltısı Yenilenme Seviyesi +7,2"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Takım Özgünlüğü>: Tur sonunda, kullananın Gümüş Anahtar Şarjının %200'üne eşit Keyflare kazan. Mevcut Diyar \"Caro\" ise, Etki şu şekilde değişir: her 5 puan Gümüş Anahtar Şarjı için Embriyo Füzyonu +1."
  },
  TrinketSuitEffect_18348_Name = {
    Text = "İlacın Rüyası"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_1 = {
    Text = "Hasar Güçlendirmesi +%4,8"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_2 = {
    Text = "<TeamUnique:Takıma Özel>: Savaş bittikten sonra 8 Kara Mühür kaybedersin. Savaşın başında, kuşananın doğuştan Komut Kartlarının her birinin (Darbe ve Savunma hariç) özgün bir kopyasını Çekme Desteğine karıştır."
  },
  TrinketSuitEffect_18349_Name = {
    Text = "Tatlı Sümüklüböcek"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_1 = {
    Text = "Ölüm Direnci +%25,2"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Takım Özgünlüğü>: 1 tur içinde hem \"Yok Oluş\" kullanılmış hem de Dokunaç Duruşu değiştirilmişse, kullananın bu turda verdiği Kalkan, Can İyileştirmesi ve Final Hasar +%25 artar; 3 tur bekleme süresi."
  },
  TrinketSuitEffect_18350_Name = {
    Text = "Tiyatro Kedisi (Tamamlanmamış)"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_1 = {
    Text = "Ölüm Direnci +%16,8"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_2 = {
    Text = "Kuşananın saldırıları, HP’si %75’ten fazla olan düşmanlara karşı her zaman kritik isabet sağlar."
  },
  TrinketSuitEffect_18351_Name = {
    Text = "36. Oda Yüzüğü"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_1 = {
    Text = "Aliemus Dolum Seviyesi +2.4"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Takıma Özel>. Keyflare üst sınırı ve Çete Keyflare maliyeti +200. Taşkınlık Krit. Oranı, Krit. Hasar, Karakter Kalkanı ve HP Yenilenmesi +%30."
  },
  TrinketSuitEffect_18352_Name = {
    Text = "Bükülmüş İkizler: Beyaz"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_1 = {
    Text = "Ölüm Direnci +%16,8"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_2 = {
    Text = "Çift numaralı turların başında: Kuşananın \"Savunma\"sını <NothingnessIconKeywords:Fleeting> ve <DepleteIconKeywords:Tüketme> ile eline ekle."
  },
  TrinketSuitEffect_18353_Name = {
    Text = "Kızıl Kucaklayış"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_1 = {
    Text = "Krit. Oran +%4,8"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_2 = {
    Text = "Kuşanan Hasar verdiğinde 35 Keyflare, Krit. Hasar verdiğinde ise 70 Keyflare kazanır. Bu Etki tur başına en fazla 3 kez tetiklenebilir."
  },
  TrinketSuitEffect_18354_Name = {
    Text = "Standart Ahit SR"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_1 = {
    Text = "Ölüm Direnci +%16,8"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_2 = {
    Text = "Kuşananın ürettiği Hasar, İyileştirme ve Kalkan %15 artırılır."
  },
  TrinketSuitEffect_18355_Name = {
    Text = "Lekesiz Vahiyname"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_1 = {
    Text = "Anahtar Parıltısı Yenilenme Seviyesi +7,2"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Takıma Özel>: Posse kullandıktan sonra, Kuşananın DAY'ının %12'sine eşit HP yenile; bu değer kaybedilen HP yüzdesiyle artarak Kuşananın DAY'ının en fazla %24'üne kadar çıkar."
  },
  TrinketSuitEffect_18356_Name = {
    Text = "Steppenwolf"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_1 = {
    Text = "Hasar Güçlendirmesi +%4,8"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_2 = {
    Text = "Kuşananın verdiği Temel Hasar %20 artar ve verdiği <IntoxicationIconKeywords:Zehir> ile <RetaliateIconKeywords:Sayaç> %10 artar."
  },
  TrinketSuitEffect_18357_Name = {
    Text = "Uzaklardan Gelen Şölen"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_1 = {
    Text = "Mühür Hasadı +%3,6"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_2 = {
    Text = "Keşfin başında 10 Kara Mühür kazan. Kuşananın \"Savunma\"sı Kalkanı %60 artırır."
  },
  TrinketSuitEffect_18358_Name = {
    Text = "Bükülmüş İkizler: Siyah"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_1 = {
    Text = "Krit. Oran +%4,8"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_2 = {
    Text = "Tek sayılı turların başında, kuşananın \"Darbe\"sini <NothingnessIconKeywords:Fleeting> ve <DepleteIconKeywords:Tüketme> ile eline ekle."
  },
  TrinketSuitEffect_18359_Name = {
    Text = "Kızın Kozası"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_1 = {
    Text = "Kritik Oranı +%7,2"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Takım Özgünlüğü>: kullanan her tur ilk kez Embriyo tükettiğinde, sahip olduğu her 1 Dokunaç için %8 Geçici Krit. Hasar kazanır, maksimum %80."
  },
  TrinketSuitEffect_18360_Name = {
    Text = "Mezarlığın Fısıltıları"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_1 = {
    Text = "Ölüm Direnci +%16,8"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_2 = {
    Text = "Seviyenin başında, <DeathResistanceIconKeywords:Ölüm Direnci> %25 artar. Ölüm Direnci tetiklendikten sonra, kuşanan 50 Aliemus kazanır."
  },
  TrinketSuitEffect_99234_Name = {Text = "Humus"},
  TrinketSuitEffect_99234_SuitEffectDesc_1 = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  TrinketSuitEffect_99234_SuitEffectDesc_2 = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  TrinketSuitEffect_99235_Name = {Text = "Yükseliş"},
  TrinketSuitEffect_99235_SuitEffectDesc_1 = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  TrinketSuitEffect_99235_SuitEffectDesc_2 = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  TrinketSuitEffect_99236_Name = {Text = "Stiks"},
  TrinketSuitEffect_99236_SuitEffectDesc_1 = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  TrinketSuitEffect_99236_SuitEffectDesc_2 = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  }
})
return Text_TrinketSuitEffect
