__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MapNodeType = readonly({
  MapNodeType_116420_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_116420_Name = {
    Text = "Rastgele Düğüm"
  },
  MapNodeType_116421_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_116421_Name = {
    Text = "Rastgele Savaş"
  },
  MapNodeType_116422_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_116422_Name = {
    Text = "Rastgele Etkinlik"
  },
  MapNodeType_121329_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_121329_Name = {
    Text = "Murphy'nin İllüzyonu"
  },
  MapNodeType_128222_Name = {
    Text = "Komut Düğümü"
  },
  MapNodeType_130326_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_130326_Name = {
    Text = "Kader Tiyatrosu"
  },
  MapNodeType_149067_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_149067_Name = {
    Text = "Gökyüzü Serabi"
  },
  MapNodeType_18391_Desc = {
    Text = "Tehlike mi fırsat mı, seçim senin."
  },
  MapNodeType_18391_Name = {Text = "Etkinlik"},
  MapNodeType_18392_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_18392_Name = {Text = "Tuhaf Apse"},
  MapNodeType_18393_Desc = {
    Text = "Ruh sisi elle tutulamaz ama katı, hiçbir geçişe izin vermez."
  },
  MapNodeType_18393_Name = {
    Text = "Gelip Geçici"
  },
  MapNodeType_18394_Desc = {
    Text = "Tehlike mi fırsat mı, seçim senin."
  },
  MapNodeType_18394_Name = {Text = "Etkinlik"},
  MapNodeType_18395_Desc = {
    Text = "Bir karşılaşma, bir kriz ya da bir hafıza."
  },
  MapNodeType_18395_Name = {Text = "Hikâye"},
  MapNodeType_18396_Desc = {
    Text = "Sonunda, en güçlü düşman. Bu soruşturmayı sonlandırmak için onu alt et."
  },
  MapNodeType_18396_Name = {
    Text = "Final savaş"
  },
  MapNodeType_18397_Desc = {
    Text = "Kara Mühürlerini alıp karşılığında sana güç sunan esrarengiz bir varlığın bulunduğu D-İzi Mağazası'na gir."
  },
  MapNodeType_18397_Name = {
    Text = "Özel D-iz Hatıra Eşyası"
  },
  MapNodeType_18398_Desc = {
    Text = "Tetiklendiğinde Mythag Üniversitesi’nden yardım al, HP’yi yenile."
  },
  MapNodeType_18398_Name = {Text = "Kavşak"},
  MapNodeType_18399_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_18399_Name = {
    Text = "Bal Şarabı"
  },
  MapNodeType_18400_Desc = {
    Text = "Gölge Havuzu’nun derinlikleri kavranamaz ve Bilinmeyen Yaratık’la doludur. Onu tetiklemek rastgele ödüller kazandırır."
  },
  MapNodeType_18400_Name = {
    Text = "Gölge Havuzu"
  },
  MapNodeType_18401_Desc = {
    Text = "Tehlike mi fırsat mı, seçim senin."
  },
  MapNodeType_18401_Name = {Text = "Etkinlik"},
  MapNodeType_18402_Desc = {
    Text = "Oyuncu başlangıç noktası. Bu düğümü görmemen gerekirdi. Eğer görüyorsan, bu bir HATA!"
  },
  MapNodeType_18402_Name = {Text = "Başla"},
  MapNodeType_18403_Desc = {
    Text = "Işık Gölge Gösterisi"
  },
  MapNodeType_18403_Name = {
    Text = "Işık Gölge Gösterisi"
  },
  MapNodeType_18404_Desc = {
    Text = "Düş Diyarı’nda bir para birimi olan Kara Mühür kazan."
  },
  MapNodeType_18404_Name = {
    Text = "Kara Mühür"
  },
  MapNodeType_18405_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_18405_Name = {
    Text = "Tamamlanmamış Heykel"
  },
  MapNodeType_18406_Desc = {
    Text = "Tek Yön Geçit’in çıkışı. Çoktan çökmüş; geri dönmek artık imkânsız."
  },
  MapNodeType_18406_Name = {
    Text = "Gizli Geçit Çıkışı"
  },
  MapNodeType_18407_Desc = {
    Text = "Kalıntı elde et."
  },
  MapNodeType_18407_Name = {Text = "Kalıntı"},
  MapNodeType_18408_Desc = {
    Text = "Dengesiz bir Tek Yönlü Geçit; içine girildiğinde, çıkıştan Dönüş yoktur."
  },
  MapNodeType_18408_Name = {
    Text = "Tek Yönlü Geçit"
  },
  MapNodeType_18409_Desc = {
    Text = "Test Kristal Küre"
  },
  MapNodeType_18409_Name = {
    Text = "Test Kristal Küre"
  },
  MapNodeType_18410_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_18410_Name = {
    Text = "Vekâlet Ayini"
  },
  MapNodeType_18411_Desc = {
    Text = "Orta zorluktaki bazı düşmanlar, daha çetin bir savaşı tetikleyecektir."
  },
  MapNodeType_18411_Name = {Text = "Elit"},
  MapNodeType_18412_Desc = {
    Text = "Kara Mühürlerini alıp karşılığında sana güç sunan esrarengiz bir varlığın bulunduğu D-İzi Mağazası'na gir."
  },
  MapNodeType_18412_Name = {
    Text = "Özel D-iz Yakarışı"
  },
  MapNodeType_18413_Desc = {
    Text = "Mythag Üniversitesi'nden yardım almak için tetikle: Can yenile veya bir Uyandıran'ı Uyandır."
  },
  MapNodeType_18413_Name = {Text = "Kavşak"},
  MapNodeType_18414_Desc = {
    Text = "Kara Mühürlerini alıp karşılığında sana güç sunan esrarengiz bir varlığın bulunduğu D-İzi Mağazası'na gir."
  },
  MapNodeType_18414_Name = {
    Text = "Yakarış D-iz"
  },
  MapNodeType_18415_Desc = {
    Text = "Gizli Ödül"
  },
  MapNodeType_18415_Name = {
    Text = "Gizli Ödül"
  },
  MapNodeType_18416_Desc = {
    Text = "Kara Mühürlerini alıp karşılığında sana güç sunan esrarengiz bir varlığın bulunduğu D-İzi Mağazası'na gir."
  },
  MapNodeType_18416_Name = {
    Text = "Kalıntı D-iz"
  },
  MapNodeType_18417_Desc = {
    Text = "Zifiri karanlık yol Bilinmeyen Yaratık’a çıkar; içeri adım attığında seni Geçit’in öteki ucuna taşıyacaktır."
  },
  MapNodeType_18417_Name = {Text = "Tünel"},
  MapNodeType_18419_Desc = {
    Text = "Test Zamanlı Çöken Zemin"
  },
  MapNodeType_18419_Name = {
    Text = "Zamanlı Çöken Zemin"
  },
  MapNodeType_18420_Desc = {
    Text = "Gizli Geçidi Sına"
  },
  MapNodeType_18420_Name = {
    Text = "Gizli Geçidi Sına"
  },
  MapNodeType_18421_Desc = {
    Text = "Etrafı saran yoğun sisi dağıtabilen kadim bir aydınlatma aygıtı."
  },
  MapNodeType_18421_Name = {Text = "Projektör"},
  MapNodeType_18422_Desc = {
    Text = "Sağlam, sessiz bir kapı. Açmak için bir Paslı Anahtar gerekir."
  },
  MapNodeType_18422_Name = {
    Text = "Paslı Kapı"
  },
  MapNodeType_18423_Desc = {
    Text = "Kara Mühürlerini alıp karşılığında sana güç sunan esrarengiz bir varlığın bulunduğu D-İzi Mağazası'na gir."
  },
  MapNodeType_18423_Name = {Text = "D-iz"},
  MapNodeType_18424_Desc = {
    Text = "Çürük Zemin"
  },
  MapNodeType_18424_Name = {
    Text = "Çürük Zemin"
  },
  MapNodeType_18425_Desc = {
    Text = "Sabırla kendi Kapısı’nı arıyor."
  },
  MapNodeType_18425_Name = {
    Text = "Paslı Anahtar"
  },
  MapNodeType_18426_Desc = {
    Text = "Avatar Yedek"
  },
  MapNodeType_18426_Name = {
    Text = "Avatar Yedek"
  },
  MapNodeType_18427_Desc = {
    Text = "Bükülmüş bir düş yolunu tıkar; onu kırmayı seçersen, seni bilinmeyen bir semptomla enfekte edecektir."
  },
  MapNodeType_18427_Name = {Text = "İllüzyon"},
  MapNodeType_18428_Desc = {
    Text = "Havadan biraz Gümüş özütle."
  },
  MapNodeType_18428_Name = {Text = "Gümüş"},
  MapNodeType_18429_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_18429_Name = {
    Text = "İyi Niyetin Hediyesi"
  },
  MapNodeType_18430_Desc = {
    Text = "Özel dükkân düğümünü test et. Bunu görüyorsan resmî bir aşamada değilsin."
  },
  MapNodeType_18430_Name = {
    Text = "Özel Dükkan"
  },
  MapNodeType_18431_Desc = {
    Text = "Beklenmedik bazı düşmanlar bir Savaş tetikleyecek."
  },
  MapNodeType_18431_Name = {Text = "Savaş"},
  MapNodeType_18432_Desc = {
    Text = "Tehlikeli Çözünme Bölgesi, sakın hafife alıp girmeyin."
  },
  MapNodeType_18432_Name = {
    Text = "Uğursuz Bataklık"
  },
  MapNodeType_24876_Desc = {
    Text = "Orta zorluktaki bazı düşmanlar, daha çetin bir savaşı tetikleyecektir."
  },
  MapNodeType_24876_Name = {Text = "Elit"},
  MapNodeType_35056_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_35056_Name = {
    Text = "Producer's Myth"
  },
  MapNodeType_35889_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_35889_Name = {
    Text = "Solgun Yelkenler"
  },
  MapNodeType_37987_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_37987_Name = {Text = "Vekil Kodu"},
  MapNodeType_38711_Desc = {
    Text = "Kara Mühürlerini alıp karşılığında sana güç sunan esrarengiz bir varlığın bulunduğu D-İzi Mağazası'na gir."
  },
  MapNodeType_38711_Name = {
    Text = "Charich Pazarı"
  },
  MapNodeType_44838_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_44838_Name = {Text = "Arzu"},
  MapNodeType_44839_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_44839_Name = {Text = "Kurtuluş"},
  MapNodeType_44840_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_44840_Name = {Text = "Tövbe"},
  MapNodeType_46149_Desc = {
    Text = "Kara Mühürlerini alıp karşılığında sana güç sunan esrarengiz bir varlığın bulunduğu D-İzi Mağazası'na gir."
  },
  MapNodeType_46149_Name = {Text = "D-iz"},
  MapNodeType_47473_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_47473_Name = {
    Text = "Berrak Rüya"
  },
  MapNodeType_47474_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_47474_Name = {
    Text = "Çekirdek Kaynaşması"
  },
  MapNodeType_47475_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_47475_Name = {
    Text = "Hipnotik Yılan"
  },
  MapNodeType_48144_Desc = {
    Text = "Tehlike mi fırsat mı, seçim senin."
  },
  MapNodeType_48144_Name = {
    Text = "Öz Farkındalık"
  },
  MapNodeType_49058_Desc = {
    Text = "Havuzda gizlenmiş bir şey var gibi; Ana Rengi siyaha çalan koyu bir kırmızı."
  },
  MapNodeType_49058_Name = {Text = "Kan Gölü"},
  MapNodeType_49100_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_49100_Name = {
    Text = "Besleyici Ana"
  },
  MapNodeType_52484_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_52484_Name = {Text = "Felaket"},
  MapNodeType_52485_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_52485_Name = {Text = "Felaket"},
  MapNodeType_52486_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_52486_Name = {Text = "Felaket"},
  MapNodeType_52487_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_52487_Name = {
    Text = "Nihai Kurban"
  },
  MapNodeType_55797_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_55797_Name = {
    Text = "Baharın Armağanı"
  },
  MapNodeType_55798_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_55798_Name = {
    Text = "Muzus'un Lütfu"
  },
  MapNodeType_57740_Desc = {
    Text = "Her türlü engelden yoksun bu bölge, Komite’nin gözetimine bütünüyle açıktır."
  },
  MapNodeType_57740_Name = {
    Text = "Gözetleme Noktası"
  },
  MapNodeType_57741_Desc = {
    Text = "Komite’nin muhafızları gevşek; belki de bu, kullanılabilir bir yol olabilir?"
  },
  MapNodeType_57741_Name = {
    Text = "Tutuklama Noktası"
  },
  MapNodeType_57742_Desc = {
    Text = "Juliette'in infazcıları tükenmek bilmiyor. Bir başka Komite Ajanı timi yolunu kesiyor."
  },
  MapNodeType_57742_Name = {
    Text = "Komite'nin Ajanı"
  },
  MapNodeType_59662_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_59662_Name = {
    Text = "Kabul Töreni"
  },
  MapNodeType_65469_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_65469_Name = {
    Text = "Güvenli Tahliye Noktası"
  },
  MapNodeType_74221_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_74221_Name = {
    Text = "Lingering Consciousness"
  },
  MapNodeType_76256_Desc = {
    Text = "Limoria'nın batık harabeleri; arkalarındaki varlık, elindeki Kara Mühür karşılığında esrarengiz güçler takas etmeyi arzuluyor."
  },
  MapNodeType_76256_Name = {
    Text = "Kül Harabeleri"
  },
  MapNodeType_76417_Desc = {
    Text = "Siyah D-balçığın içinde yarıya kadar gömülü, solgun bir kemik parçası."
  },
  MapNodeType_76417_Name = {
    Text = "Solmuş Kemik"
  },
  MapNodeType_80599_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_80599_Name = {
    Text = "Ruh Göçü"
  },
  MapNodeType_90661_Desc = {
    Text = "Gümüş Anahtar seni buraya kadar getirdi. Bu yerde var olanla birlikte titreş."
  },
  MapNodeType_90661_Name = {
    Text = "Kusursuz Tat"
  }
})
return Text_MapNodeType
