__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Activity = readonly({
  Activity_100432_ActivityName = {
    Text = "Hipnotik Shaggai"
  },
  Activity_100432_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n \"Hipnotik Shaggai\" etkinliği süresince Koruyucular, Clementine'i içeren sistem tarafından önceden ayarlanmış takım dizilişlerini kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\n Etkinlik aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcı değiştirilemez.\n<Title:Etkinlik Ödülleri>\n Bir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_100433_ActivityName = {
    Text = "Hayırsever Başrahip"
  },
  Activity_100433_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n \"Merhemlerin Piskoposu\" etkinliği süresince Koruyucular, Salvador'u içeren sistem tarafından önceden ayarlanmış takım dizilişini kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcı değiştirilemez. \n<Title:Etkinlik Ödülleri>\n Aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_116469_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_116470_ActivityName = {
    Text = "Ebedi Gündüzün Son Gecesi"
  },
  Activity_116470_ActivityPlot = {
    Text = "Yazgıyla çizilmiş yollarının sonunda, birbirlerini bir kez daha ıskaladılar.\nSaat yeniden tik tak etmeye başladı, ama artık çok geçti.\nKutsal Kalbi pişmanlıkla kan akıtma içinde kalan o, Karanlıkta irin bağlayan bütün pisliği temizlemeye ant içti."
  },
  Activity_116470_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Kutsama Ayini\" Alınabilir."
  },
  Activity_116470_ActivityTips = {
    Text = "<Title:Etkinlik Genel Bakış>\n1. Etkinlik süresince, Gözetmenler, süreli oynanış \"Kaynaşan Acı Kan\" ve \"Başarı Ödülleri\" aracılığıyla etkinlik para birimleri \"Huzura Varış Adağı\", \"Tövbe Sunusu\" ve \"Sadakat Sunusu\" nu toplayabilir. \"Huzura Varış Adağı\", \"Tövbe Sunusu\" ve \"Sadakat Sunusu\", \"Kutsama Ayini\" içinde, etkinliğe özel SR Kader Çarkı \"Divus’un Çehresi\", Lümen Çekirdeği, Saf Çekirdek ve daha fazlasını satın almak için kullanılabilir. \n2. Etkinlik süresince, \"Düş Diyarı: Göklerin Ötesinde·Bölüm II\" ye Süreli ücretsiz erişim sunulacaktır. Etkinlik başarılarını tamamlamak, etkinliğe özel avatar \"Gümüş Anahtar Adına: Pollux\" u da kazandıracaktır!\n\n<Title:Etkinlik Süresi>\n1. 20 Ekim, 9:00 - 3 Kasım, 9:00(GMT+8) arasında tüm etkinlik oynanışlarına katılınabilir. \n2. 3 Kasım, 9:00 - 10 Kasım, 9:00(GMT+8) arasında yalnızca \"Kutsama Ayini\" ve Başarı Ödülleri’ne katılınabilir. \n\n<Title:Kaynaşan Acı Kan>\n1. \"Kaynaşan Acı Kan\" 7 aşamadan oluşur, her gün 1 aşama kendiliğinden açılır. \n2. Her meydan okuma 120 Menophin tüketir ve başarılı bir meydan okuma etkinlik para birimi kazandırır. \n3. Bir aşama tamamlandıktan sonra, o aşama için \"Yeniden Canlandır\" işlevi açılır. Lütfen dikkat: \"Yeniden Canlandır\" işlevini kullanmak Yakınlık kazandırmaz. \n4. Aşamaları daha kolay geçmek için Alumnis kullanabilirsiniz. \n\n<Title:Anı Girdabı>\n Etkinlik başladıktan sonra, her saat otomatik olarak 60 \"Huzura Varış Adağı\" alacaksınız; en fazla 25 saatlik birikim yapılabilir. \n\n<Title:Kutsama Ayini>\n1. \"Kutsama Ayini\" nin üç dükkânı vardır ve açılış zamanları şöyledir:\n \"Bedenin Arınması\": 20 Ekim 9:00’da açılır.\n \"Ruhun Tövbesi\": 21 Ekim 9:00’da açılır.\n \"Günahların Arındırılması\": 22 Ekim 9:00’da açılır. \n2. Her takas, 750 \"Huzura Varış Adağı\"/\"Tövbe Sunusu\"/\"Sadakat Sunusu\" tüketir ve stüdyodan rastgele beş eşya ödülü elde edilir. \n3. Her stüdyodaki eşya ödülleri \"Özel Eşyalar\" ve \"Sıradan Eşyalar\" olarak ikiye ayrılır. Sıfırlamalar, \"Özel Eşyalar\"ın kalan miktarını azami sınıra geri yükleyebilir; özel kurallar aşağıdaki gibidir: \n(1) İlk 2 sıfırlama için: Kalan \"Özel Eşyalar\" olmadığında, Gözetmen sıfırlamayı seçebilir; bu, \"Özel Eşyalar\" ve \"Sıradan Eşyalar\"ın kalan miktarlarını azami sınıra geri yükler; ya da takasa devam edebilir. Kalan \"Sıradan Eşyalar\" kalmadığında, takasa devam etmek için mutlaka sıfırlama yapılmalıdır. \n(2) 3. sıfırlamadan itibaren: Yalnızca kalan \"Sıradan Eşyalar\" kalmadığında sıfırlama yapılabilir. Sıfırlama, \"Sıradan Eşyalar\"ın kalan miktarını azami sınıra geri yükler ve \"Özel Eşyalar\" artık sıfırlanmaz. \n\n<Title:Etkinlik Bonusları>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan(dizilimde bulunmaları gerekmez) Gözetmenler, \"Kaynaşan Acı Kan\" görevlerinden \"Huzura Varış Adağı\", \"Tövbe Sunusu\" ve \"Sadakat Sunusu\" için ek düşüş bonusları elde edebilir. Özel bonuslar şöyledir:\nUyanan \"Pollux\": Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\nSSR Kader Çarkı \"Bükülmüş Şövalye Baladı\": Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\nSR Kader Çarkı \"Divus’un Çehresi\": Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50. \n2. Farklı Uyananların veya Kader Çarklarının \"etkinlik bonusları\" kümülatif olarak hesaplanır. \n3. Özellikle, Delilik Zorluğu’nun ilk tamamlama ödülleri \"etkinlik bonusları\" ndan etkilenmez. \n\n<Title:Düş Diyarı>\n1. Etkinlik süresince, \"Düş Diyarı: Göklerin Ötesinde·Bölüm II\"ücretsiz olarak açılabilir. \n2. Etkinlik sona erdikten sonra, \"Düş Diyarı: Göklerin Ötesinde·Bölüm II\" nin soruşturma ilerlemesi korunacaktır. Etkinlik sırasında tamamlanmamış soruşturma olaylarının etkinlik süresinde tamamlanması, etkinlik dönemiyle tutarlı soruşturma ödülleri kazandıracaktır. \"Düş Diyarı: Göklerin Ötesinde·Bölüm II\" etkinlik sırasında açılmadıysa, etkinlikten sonra da \"Gerçeklik Sınırı\"*7 tüketilerek açılabilir. \n3. Etkinlik sırasında olsun ya da olmasın, \"Düş Diyarı: Göklerin Ötesinde·Bölüm II\" nin tamamlanması \"Posse: Kanayan Kutsal Kalp\" kazandıracaktır."
  },
  Activity_116470_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_116765_ActivityName = {
    Text = "Yeni Yolculuğun Başlangıcı"
  },
  Activity_116765_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular belirlenen arşiv görevlerini tamamladıktan sonra \"Yeni Yolculuğun Başlangıcı\" etkinliğinden ödülleri talep edebilir.\n2. \"Premium Arşivler\" açıldıktan sonra görev tamamlandığında ek ödüller talep edilebilir.\n3. Bu \"Premium Arşivler\"in satın alma süresi sınırlıdır ve son tarihten sonra satın alınamaz. Koruyucular 3 Kasım saat 09:00'dan önce bilinçli bir şekilde satın alma yapmalıdır.\n4. Lütfen dikkat: Bu etkinlik süresince açılan \"Premium Arşivler\" yalnızca bu etkinlik için geçerlidir. Koruyucuların mantıklı harcama yapması tavsiye edilir."
  },
  Activity_116765_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_116818_ActivityName = {
    Text = "Kadere Karşı: II"
  },
  Activity_116818_ActivityPlot = {
    Text = "Yıldızlar Onun gözleridir, sadece izlemekle kalmaz, var olan her şeyi gözetler.\nOnun bakışlarından kaçtığınıza inanıyorsunuz, ama gerçek şu ki—hâlâ Onun rüyasında hapsiniz.\n\"Yakaladım... seni...\"\nSizi yakaladıklarında, Yıldızlar alçak, tatmin olmuş bir iç çekiş bıraktı."
  },
  Activity_116818_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi."
  },
  Activity_116818_ActivityTips = {
    Text = "<Title: Kadere Karşı: II>\n\"Kadere Karşı: II\" etkinliği, Kadim Vizyon ile doğrudan yüzleşilen, tekrar meydan okunamayan 7 aşamadan oluşur. İlk iki günde birer aşama açılır, üçüncü gün üç aşama açılır ve sonrasında her gün bir ek aşama açılır.\nİlgili Astral Kadim Vizyon'u her yenişinizde bir ödül alırsınız.\nHer Astral Kadim Vizyon türünün çok sayıda Avatarı vardır. Herhangi bir tür bir Koruyucu tarafından yenildiğinde, \"Kalan Sayısı\" 1 azalır. Kalan Sayısı sıfıra ulaştığında, o aşama kalıcı olarak kapanır.\nHer aşama farklı Kalıntılar sağlayarak size güçlü bonuslar verir.\nTüm aşamalar bir Yardım gerektirir. Takip ettiğiniz her Koruyucu, etkinlik boyunca size yalnızca bir kez yardım edebilir. Yardım kullanmak, nihai Afinite ödülünü temel ödülün %50'si kadar artırır.\nHer Uyandırıcı ve Kader Çarkı günde yalnızca bir kez konuşlandırılabilir.\nBu etkinliğe katılmak için Koruyucuların Operasyon 2-9'u tamamlamış olması gerekir.\n\n<Title: Seviye Telafisi>\n\"Kadere Karşı: II\" tüm Koruyucuların omuz omuza savaşabilmesini sağlamak için bir Seviye Telafisi sistemi içerir!\nTelafi kuralları şu şekildedir:\nOperasyon ekibinde, 60. seviyenin altındaki Uyandırıcı bedenleri meydan okuma için Seviye 60'a telafi edilecektir.\n5. seviyenin altındaki Uyandırıcı beceri seviyeleri meydan okuma için Seviye 5'e telafi edilecektir.\n6. seviyenin altındaki Uyandırıcı \"Delilik Alameti\" seviyeleri meydan okuma için Seviye 6'ya telafi edilecektir.\n5. seviyenin altındaki Uyandırıcı \"Ruh Dövme Yeteneği\" seviyeleri meydan okuma için Seviye 5'e telafi edilecektir.\nKoruyucu seviyeniz 60'ın altındaysa, meydan okuma için Seviye 60'a telafi edilecektir.\n\n<Title: Özel Operasyonlar>\n1. \"Özel Operasyonlar: Göksel Arya\" etkinliği, etkinlik süresince ücretsiz olarak açılabilir.\n2. Etkinlik sona erdikten sonra, \"Özel Operasyonlar: Göksel Arya\" operasyon ilerlemeniz korunur. Tamamlanmamış operasyon etkinliklerini tamamlayarak etkinlik ödüllerini almaya devam edebilirsiniz. Etkinlik sırasında Özel Operasyonları açmadıysanız, önce \"Operasyon- Astral Hükümdarlık- Dördüncü Bölüm\"ü tamamlamanız ve \"Göksel Arya\"yı açmak için 7 \"Gerçeklik Başlangıç Noktası\" harcamanız gerekir.\n3. İster etkinlik sırasında ister sonrasında olsun, \"Özel Operasyonlar: Göksel Arya\"yı tamamlamak size \"Müfreze: Kavuşma Dileği\" ödülünü verecektir."
  },
  Activity_116818_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_117836_ActivityName = {
    Text = "Kırmızılı Madam"
  },
  Activity_117836_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Kırmızılı Madam\" etkinliği süresince Koruyucular, Sorel'i içeren sistem tarafından önceden ayarlanmış takımı kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarında Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödülü talep edilebilir."
  },
  Activity_117837_ActivityName = {
    Text = "Derinlerin Hanımefendisi"
  },
  Activity_117837_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Derinlerin Hanımefendisi\" etkinliği süresince Koruyucular, Murphy'yi içeren sistem tarafından önceden ayarlanmış takımı kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarında Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödülü talep edilebilir."
  },
  Activity_117838_ActivityName = {
    Text = "Divus: Oniks Tüy"
  },
  Activity_117838_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Divus: Oniks Tüy\" etkinliği süresince Koruyucular, Castor'u içeren sistem tarafından önceden ayarlanmış takımı kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarında Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödülü talep edilebilir."
  },
  Activity_117839_ActivityName = {
    Text = "Kapının Anahtarı"
  },
  Activity_117839_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Kapının Anahtarı\" etkinliği süresince Koruyucular, Tawil'i içeren sistem tarafından önceden ayarlanmış takımı kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarında Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödülü talep edilebilir."
  },
  Activity_119662_ActivityName = {
    Text = "Balçık Çiçeği"
  },
  Activity_119662_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Balçık Çiçeği\" etkinliği süresince Koruyucular, Lily'yi içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini oynarken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_119663_ActivityName = {
    Text = "Bereket Nefesi"
  },
  Activity_119663_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Bereket Nefesi\" etkinliği süresince, Koruyucular Thais içeren sistem tarafından hazırlanmış takımları kullanarak belirlenen bölümleri sınırsız sayıda deneyimleyebilir.\nEtkinlik bölümlerini oynarken, takım dizilişindeki Uyandırıcı üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBir bölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_119693_ActivityName = {
    Text = "Gümüş Anahtar Adına"
  },
  Activity_119693_ActivityPlot = {
    Text = "Görevi tamamlayarak istediğiniz 1 Sınırlı Uyandırıcıyı talep edin!"
  },
  Activity_119693_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\nEtkinlik süresince, her Koruyucu Müfreze becerisini 200 kez kullandıktan sonra 8 sınırlı SSR Uyandırıcı arasından 1 Uyandırıcı seçebilir.\nListe şunları içerir: Doll: Cehennem, Clementine, Corposant, Castor, Doresain, Kathigu-Ra, Pickman ve Pollux.\nBir Koruyucu zaten sahip olduğu bir Uyandırıcıyı seçtiğinde, sonraki kopyalar (2. ile 16. arası) 1 Uyandırıcı Parçası ve 50 Kök Tortusu'na dönüştürülür.\n17. kopyadan itibaren, sınırlı SSR Uyandırıcı 2 Rafine Gnosis Parçası, 6 Gnosis Parçası ve 250 Kök Tortusu'na dönüştürülür."
  },
  Activity_119693_BannerText = {
    Text = "Ücretsiz Sınırlı Uyandıran"
  },
  Activity_119694_ActivityName = {
    Text = "Şafak Getiren'in Rehberliği"
  },
  Activity_119694_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n1. Koruyucular, belirlenen arşiv görevlerini tamamladıktan sonra \"Şafak Getiren'in Rehberliği\" bölümünden ödülleri talep edebilir.\n2. \"Premium Arşivler\" açıldıktan sonra, görev tamamlandığında ek ödüller talep edilebilir.\n3. Bu \"Premium Arşivler\" satın alımı süre sınırlıdır ve son tarihten sonra satın alınamaz. Koruyucuların 26 Ocak sabah 09:00'dan önce satın alma kararlarını dikkatli bir şekilde vermeleri gerekmektedir.\n4. Lütfen dikkat: Bu etkinlik sırasında açılan \"Premium Arşivler\" yalnızca bu etkinlik için geçerlidir. Koruyucuların mantıklı harcama yapmaları tavsiye edilir."
  },
  Activity_119694_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_119857_ActivityName = {
    Text = "Uyuyan Hükümdar"
  },
  Activity_119857_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Uyuyan Hükümdar\" etkinliği süresince, Koruyucular Tulu içeren sistem tarafından hazırlanmış takımları kullanarak belirlenen bölümleri sınırsız sayıda deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken, takım dizilişindeki Uyandırıcılar üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra, oyuncular etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_120495_ActivityName = {
    Text = "Yankılanan Hac: Astral Saltanat IV"
  },
  Activity_120495_ActivityPlot = {
    Text = "Yanılsama Hafıza mühürlenip arşivlendi, geçmişe kaydedilen bir yolculuk. Anımsama anlarında, saygılı Haracınızı sunmayı unutmayın."
  },
  Activity_120496_ActivityName = {
    Text = "Zaman Döngüsü Arşivleri"
  },
  Activity_120496_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Zaman Döngüsü Arşivleri'nde ödüller almak için görevleri tamamlayın\n2. Necrovia Arşivleri kalıcı olarak erişilebilir kalır\n3. Görev tamamlandığında ekstra ödüller kazanmak için Premium Arşivleri açın\nNot: Etkinleştirilen Premium Arşivler yalnızca bu Arşiv etkinliğinde geçerlidir."
  },
  Activity_120954_ActivityName = {
    Text = "Göksel Arya"
  },
  Activity_122195_ActivityName = {
    Text = "Sisle Örtülü Ayin"
  },
  Activity_122195_ActivityPlot = {
    Text = "Şafağın ışığı, dindarların ıstıraplarını çözüp dağıtırken, yıldızlar birer kap hâline gelir, kardeşleri yüceltilmiş âleme taşır.\nKaybolmuş kuzu, ebedî ilahî mahkemenin kapısında, yıldız-mumlarla bezenmiş hâlde dans eder, şarkılar söyler.\nOysa kapının ardındaki sis, çoktan çağrıya icabet etmiştir; bu sis, yalnızca kendi çarpık heveslerini tatmin etmek için aldatır, oyunlar oynar.\nBöylece \"şafağı\" mühürler, Kurtuluş’a giden Fitil Yolu’nu tıkar.\nBurada, o bir dünyanın daha sonunu seyredecektir."
  },
  Activity_122195_ActivityStageEndContent = {
    Text = "Etkinlik Sona Erdi. Şu anda yalnızca \"Mouchette'in Kulübesi\" Alınabilir."
  },
  Activity_122195_ActivityTips = {
    Text = "<Title:Etkinlik Genel Bakış>\n1. Etkinlik süresince, Muhafızlar sınırlı süreli “Kayıp Benlik” ve “Başarı Ödülleri” oynanışları aracılığıyla etkinlik para birimleri olan \"Sis\" Görüşü, \"Sis\" Rüyası ve \"Sis\" Özü toplayabilir. \"Sis\" Görüşü, \"Sis\" Rüyası ve \"Sis\" Özü, Mouchette'in Kulübesi’nde etkinliğe özel SR Kader Çarkı “Zekânın Işığı”, Lümen Çekirdeği, Saf Çekirdek ve daha fazlasını içeren eşyaları satın almak için kullanılabilir. \n2. Etkinlik süresince, “Çok Boyutlu Bağlantı: Gümüş ve Kanın Vaftizi” geçici olarak ücretsiz açılacaktır. Etkinlik başarılarını tamamlamak, sana etkinliğe özel avatar “Gümüş Anahtar Adına: Mouchette”i de kazandıracaktır!\n\n<Title:Etkinlik Süresi>\n1. 29 Aralık, 9:00 - 12 Ocak, 9:00 (GMT+8), tüm etkinlik oynanışlarına erişilebilecektir. \n2. 12 Ocak, 9:00 - 19 Ocak, 9:00 (GMT+8), yalnızca “Mouchette'in Kulübesi” ve Başarı Ödülleri erişilebilir olacaktır. \n\n<Title:Kayıp Benlik>\n1. “Kayıp Benlik” 7 aşamadan oluşur ve her gün 1 aşama otomatik olarak açılır. \n2. Her meydan okuma 120 Menophin tüketecek, başarılı meydan okumalar etkinlik para birimi kazandıracaktır. \n3. Bir aşamayı temizledikten sonra, o aşama için “Yeniden Canlandır” özelliği açılır. Lütfen dikkat: “Yeniden Canlandır” özelliğini kullanmak Yakınlık kazandırmaz. \n4. Aşamaları daha kolay geçmek için Mezun Yardımı’nı kullanabilirsin. \n\n<Title:Mouchette'in Kulübesi>\nMouchette'in Kulübesi’nde aşağıdaki zamanlarda açılan üç dükkân vardır: \n “Malzeme Deposu”: 29 Aralık, 9:00’da açılır. \n “Rüya Odası”: 30 Aralık, 9:00’da açılır. \n “Öz Atölyesi”: 31 Aralık, 9:00’da açılır. \nDükkânlarda doğrudan satın almak üzere eşyaları seçebilirsin. \n\n<Title:Etkinlik Bonusları>\n1. Belirli Uyananlar’a veya Kader Çarkları’na sahip olan (savaşa sokulmaları gerekmez) Muhafızlar, “Kayıp Benlik” sahne görevlerinde \"Sis\" Görüşü, \"Sis\" Rüyası ve \"Sis\" Özü için ek düşüş bonusları elde edebilir; özel bonuslar şöyledir: \n Uyanan “Mouchette”: Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50. \n SSR Kader Çarkı “Kıyamet Azgınlığı”: Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50. \n SR Kader Çarkı “Zekânın Işığı”: Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50. \n2. Farklı Uyananlar’ın veya Kader Çarkları’nın “Etkinlik Bonusları” kümülatif olarak hesaplanır. \n3. Özellikle, Delilik Zorluğu için ilk tamamlama meydan okuma ödülleri “Etkinlik Bonusları”ndan etkilenmeyecektir. \n\n<Title:Çok Boyutlu Bağlantı>\n1. Etkinlik süresince, “Çok Boyutlu Bağlantı: Gümüş ve Kanın Vaftizi” ücretsiz olarak açılabilir. \n2. Etkinlik sona erdikten sonra, “Çok Boyutlu Bağlantı: Gümüş ve Kanın Vaftizi” için Soruşturma ilerlemesi korunacaktır. Etkinlik süresince tamamlanmamış Soruşturma Olaylarını tamamlamak, etkinlik dönemindekiyle aynı Soruşturma ödüllerini kazandıracaktır. “Çok Boyutlu Bağlantı: Gümüş ve Kanın Vaftizi” etkinlik sırasında açılmamışsa, etkinlikten sonra da 3 adet “Gerçeklik Sınırı” harcayarak açılabilir. \n3. Etkinlik sırasında olsun ya da olmasın, “Çok Boyutlu Bağlantı: Gümüş ve Kanın Vaftizi”ni temizlemek “Çete: Sis Diyarından” ödülünü kazandıracaktır."
  },
  Activity_122195_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_122196_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_122520_ActivityName = {
    Text = "Yağmur Kasabasının Hayaleti·Etkinlik Yeniden Gösterim"
  },
  Activity_122520_ActivityPlot = {
    Text = "Kaderin yazdığı bir karşılaşma, nemli ve puslu yağmurun içinde seni bekliyor. Adını da yüzünü de biliyorsun; sesi hâlâ seni bir huzur duygusuna uyutuyor.\nAma unutma—insan arzularını böylesine doyurmaya hevesli olanlar yalnızca tanrılar ve şeytanlardır.\nTahmin et. O hangisi?"
  },
  Activity_122520_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Artık yalnızca \"Cadının Hazinesi\"ne katılabilirsin."
  },
  Activity_122520_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli \"Cadının Dükkânı\" oynanışı ve \"Başarı Ödülleri\" aracılığıyla etkinlik para birimi toplayabilir. Etkinlik para birimi, \"Cadının Hazinesi\"nde, etkinliğe özel SR Kader Çarkı \"Cadının Geniş Kenarlı Şapkası\", Felsefe Taşı, Saf Çekirdek, Lümen Çekirdeği ve daha fazlasını içeren eşya ödülleriyle takas edilebilir.\n2. Etkinlik süresince \"Özel Görev Kayıtları: Yağmurlu Kasabanın Gölgesi\" ücretsiz olarak erişime açılacak, ve etkinlik başarılarını tamamlamak size ayrıca \"Gümüş Anahtar Adına: \"Daffodil\"\" etkinliğe özel avatarını kazandıracaktır!\n\n<Title:Etkinlik Zamanı>\n1. 12 Ocak, 9:00 (GMT+8) - 26 Ocak, 9:00 (GMT+8) arasında tüm etkinlik içeriklerine katılım mümkündür.\n2. 26 Ocak, 9:00 (GMT+8) - 2 Şubat, 9:00 (GMT+8) arasında yalnızca \"Cadının Hazinesi\" ve \"Başarı Ödülleri\" erişime açık kalacak, diğer içerikler sona erecek ve katılım mümkün olmayacaktır.\n\n<Title: Cadının Dükkânı>\n1. \"Cadının Dükkânı\" 5 seviyeden oluşur; her 2 günde bir seviye otomatik olarak açılır.\n2. Her meydan okuma 120 Nöropeptid puanı tüketecek, ve başarılı meydan okumalar etkinlik para birimi kazandıracaktır.\n3. Bir seviye tamamlandıktan sonra, o seviye için \"Reenact\" özelliği açılır. Lütfen dikkat: \"Reenact\" özelliğini kullanmak senkronizasyon oranı kazandırmaz.\n4. Seviyeleri daha kolay geçmek için Mezun Yardımı’nı kullanabilirsiniz.\n\n<Title: Etkinlik Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan (savaşta bulunmaları gerekmez) Muhafızlar, \"Cadının Dükkânı\" görevinde \"Solgun Canavar Kafatası\", \"Gölge Canavar Kafatası\" ve \"Kızıl Canavar Kafatası\" ödülleri için ek düşüş bonusları alabilir; özel bonuslar şöyledir:\n Uyanan \"\"Daffodil\"\": Uyanış 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n SSR Çark \"Most Precious Collection\": Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n SR Çark \"Cadının Geniş Kenarlı Şapkası\": Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n2. Farklı Uyananlar veya Kader Çarklarının \"Etkinlik Bonusları\" kümülatif olarak hesaplanır.\n3. Özellikle, Çılgınlık Zorluğu meydan okumasının ilk tamamlama ödülleri \"Etkinlik Bonusları\"ndan etkilenmeyecektir.\n\n<Title: Cadının Hazinesi>\n1. Üç \"Cadının Hazinesi\" vardır ve açılış zamanları şöyledir:\n \"Kaygı Giderici Eşyalar\": 12 Ocak, 9:00 - 2 Şubat, 9:00.\n \"Görkemli Hazineler\": 14 Ocak, 9:00 - 2 Şubat, 9:00.\n \"Koleksiyonluk Nadirlikler\": 16 Ocak, 9:00 - 2 Şubat, 9:00.\n2. Her takas, 750 \"Solgun Canavar Kafatası\"/\"Gölge Canavar Kafatası\"/\"Kızıl Canavar Kafatası\" tüketerek hazineden rastgele beş eşya ödülü verir.\n3. Her hazinedeki eşya ödülleri \"Özel Eşyalar\" ve \"Sıradan Eşyalar\" olarak ikiye ayrılır. Sıfırlamalar sırasında, belirtilen eşya ödüllerinin kalan miktarı azami sınıra döndürülebilir; ayrıntılı kurallar şöyledir:\n(1) İlk iki sıfırlama için: Kalan \"Özel Eşyalar\" olmadığında, Muhafız sıfırlamayı seçebilir. Sıfırlama sonrasında hem \"Özel Eşyalar\"ın hem de \"Sıradan Eşyalar\"ın kalan miktarları azami sınıra döner; ya da Muhafız takasa devam etmeyi seçebilir ve \"Sıradan Eşyalar\" da tükendiğinde, takasa devam etmek için mutlaka sıfırlama yapılmalıdır.\n(2) Üçüncü sıfırlamadan itibaren: Yalnızca kalan \"Sıradan Eşyalar\" kalmadığında sıfırlama yapılabilir; bu işlem, \"Sıradan Eşyalar\"ın kalan miktarını azami sınıra döndürürken, \"Özel Eşyalar\" artık sıfırlanmayacaktır.\n\n<Title: Özel Görev Kayıtları>\n1. Etkinlik süresince \"Özel Görev Kayıtları: Yağmurlu Kasabanın Gölgesi\" ücretsiz olarak erişime açılacaktır.\n2. Etkinlik sona erdikten sonra, \"Özel Görev Kayıtları: Yağmurlu Kasabanın Gölgesi\" soruşturma ilerlemesi korunacaktır. Eğer \"Özel Görev Kayıtları: Yağmurlu Kasabanın Gölgesi\" etkinlik sırasında açılmadıysa, etkinlik sonrasında da \"Gerçeklik Başlangıç Noktası\" *7 harcanarak açılabilir.\n3. Etkinlik sırasında olsun ya da olmasın, \"Özel Görev Kayıtları: Yağmurlu Kasabanın Gölgesi\"nin tamamlanması \"Anahtar: Gri Sisin Gerçek Sureti\"ni verir."
  },
  Activity_122520_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_122521_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_122803_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_122803_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Mouchette\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_122804_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_122804_ActivityPlot = {
    Text = "Satın alma sonrasında \"Mouchette\", <BlueQuality:Aydınlanma 3> özelliğini etkinleştirebilir"
  },
  Activity_122827_ActivityName = {
    Text = "Çoğalma Lütfu"
  },
  Activity_122827_ActivityTips = {
    Text = "<Title:Genel Bakış>\nEtkinlik süresince, koruyucular belirlenen hedefleri tamamladıklarında \"Çoğalma Lütfu\"nda karşılık gelen ödülleri alabilirler."
  },
  Activity_122827_BannerText = {
    Text = "Kostümü ücretsiz al!"
  },
  Activity_123150_ActivityName = {
    Text = "Kafatası Avcısı Cadı"
  },
  Activity_123150_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Kafatası Avcısı Cadı\" etkinliği süresince, Koruyucular Nergis'i içeren sistem tarafından hazırlanmış takımları kullanarak belirlenen bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken, takım kadrosundaki Uyandırıcılarda değişiklik yapılmasına izin verilmez.\n<Title:Etkinlik Ödülleri>\nBölüm mücadelesini ilk kez başarıyla tamamladıktan sonra, oyuncular etkinlik arayüzünden deneme ödüllerini alabilir."
  },
  Activity_123151_ActivityName = {
    Text = "Necrovia'nın Efendisi"
  },
  Activity_123151_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Necrovia'nın Efendisi\" etkinliği süresince, Koruyucular Doresain içeren sistem tarafından hazırlanmış takımı kullanarak belirlenen bölümü sınırsız sayıda deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken, takım dizilişindeki Uyandırıcılar üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez tamamladığınızda, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_123152_ActivityName = {
    Text = "Denizin Havarisi"
  },
  Activity_123152_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Denizin Havarisi\" etkinliği süresince Koruyucular, Miryam'ı içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_123322_ActivityName = {
    Text = "Gümüş Ayaz Arşivleri"
  },
  Activity_123322_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n1. Koruyucular belirlenen arşiv görevlerini tamamladıktan sonra \"Gümüş Ayaz Arşivleri\" etkinliğinden ödülleri talep edebilir.\n2. \"Gümüş Ayaz Arşivleri\" 12 Ocak saat 15:00'te (GMT+8) sona erecektir.\n3. \"Premium Arşivler\" açıldıktan sonra görev tamamlandığında ek ödüller talep edilebilir.\n4. Lütfen dikkat: Bu etkinlik süresince açılan \"Premium Arşivler\" yalnızca bu etkinlik için geçerlidir. Koruyucuların mantıklı harcama yapması tavsiye edilir."
  },
  Activity_123322_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_123323_ActivityName = {
    Text = "Altın Keçi'nin Dansı"
  },
  Activity_123323_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n1. Koruyucular belirlenen arşiv görevlerini tamamladıktan sonra \"Altın Keçinin Dansı\" etkinliğinden ödülleri talep edebilir.\n2. \"Altın Keçinin Dansı\" 26 Ocak saat 09:00'da (GMT+8) sona erecektir.\n3. \"Premium Arşivler\" açıldıktan sonra görevleri tamamladığınızda ekstra ödüller talep edebilirsiniz.\n4. Lütfen dikkat: Bu etkinlikte açılan \"Premium Arşivler\" yalnızca bu etkinlik süresince geçerlidir. Koruyucular bilinçli ve mantıklı tüketim yapmalıdır."
  },
  Activity_123323_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_124049_ActivityName = {
    Text = "Çürümüş Beyin"
  },
  Activity_124049_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Çürümüş Beyin\" etkinliği süresince Koruyucular, \"Doll: Cehennem\"i içeren sistem tarafından belirlenen takımı kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini denerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez tamamladıktan sonra etkinlik arayüzünden demo ödüllerini talep edebilirsiniz."
  },
  Activity_124050_ActivityName = {
    Text = "Denizin Havarisi"
  },
  Activity_124050_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Denizin Havarisi\" etkinliği süresince Koruyucular, Miryam'ı içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_124051_ActivityName = {
    Text = "Uçurum Kurbanı: Tekrar"
  },
  Activity_124051_ActivityPlot = {
    Text = "Derin okyanusun yansısında, Kralı’nın düşü dağılır ve Tanrı Diyarı çürür.\nKadim düşlerden sıyrılıp, çöken bir geleceğin harabelerine adım atar.\nUçuruma soru sorar, ama Uçurum suskun kalır.\nUçuruma kurbanlar sunar, yalnızca kendi yankısını duyar."
  },
  Activity_124051_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Uçurumdan Gelen Yanıt\" kullanılabilir."
  },
  Activity_124051_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli \"Tanrı Diyarının Doğuşu\", \"Tanrı Kralın Fermanı\" ve \"Başarı Ödülleri\" oynanışları aracılığıyla etkinlik parası toplayabilir. Etkinlik parası, \"Uçurumun Yanıtı\"nda sunular için kullanılarak, sınırlı süreli SR Kader Çarkı \"Derin Denizin Çağrısı\", Eter Taşı, Saf Öz, Işıltılı Öz ve daha fazlası dâhil eşya ödülleri elde etmek için harcanabilir.\n2. Etkinlik süresince \"Düşdiyar: Kirlet\" ücretsiz olacaktır. Etkinlik başarılarını tamamlamak, sınırlı süreli avatar \"Gümüş Anahtar Adına: Miryam\"ı da kazandıracaktır!\n\n<Title:Etkinlik Zamanı>\n1. 9 Mart 9:00 - 23 Mart 9:00 (GMT+8) arasında tüm etkinlik içeriğine katılınabilir.\n2. 23 Mart 9:00 - 30 Mart 9:00 (GMT+8) arasında yalnızca \"Uçurumun Yanıtı\" ve \"Başarı Ödülleri\" kalacak, diğer içerikler sona erecek ve katılım mümkün olmayacaktır.\n\n<Title:Tanrı Diyarının Doğuşu>\n1. \"Tanrı Diyarının Doğuşu\" 5 aşamadan oluşur; her 2 günde bir 1 aşama otomatik olarak açılır.\n2. Her meydan okuma 120 Menofin tüketir ve başarılı meydan okumalar etkinlik parası kazandırır.\n3. Bir aşama temizlendikten sonra o aşama için \"Yeniden Canlandır\" özelliği açılır. Lütfen dikkat: \"Yeniden Canlandır\" özelliğini kullanmak Yakınlık kazandırmaz.\n4. Mezunlar Birliği desteğini ve \"Ritüel: Uçurum Sunusu\"nu kullanarak aşamaları daha kolay temizleyebilirsiniz.\n\n<Title:Adak Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan Muhafızlar (dizilimde olmaları gerekmez), \"Tanrı Diyarının Doğuşu\" aşama görev ödüllerinde (Yeniden Canlandır dâhil) \"Adak Sunucunun Gözyaşları\", \"Adak Sunucunun Kanı\" ve \"Adak Sunucunun İliği\" için ek düşüş bonusu kazanabilir. Bonuslar şöyledir:\nUyanan \"Miryam\": Aydınlanma 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus\nSSR Kader Çarkı \"Dindarın Gücü\": Yükseliş 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus\nSR Kader Çarkı \"Derin Denizin Çağrısı\": Yükseliş 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus\n2. Farklı Uyananların veya Kader Çarklarının \"Adak Bonusu\" kümülatif olarak hesaplanır.\n3. Özellikle, Delilik Zorluğu için ilk tamamlama meydan okuma ödülü \"Adak Bonusu\"ndan etkilenmez.\n\n<Title:Rezonans: Uçurum Sunusu>\n1. Muhafızlar, etkinlik başarılarını tamamlayarak \"Bağlılık Kalbi\" elde edebilir.\n2. \"Bağlılık Kalbi\" tüketmek, \"Rezonans: Uçurum Sunusu\"nu etkinleştirerek şu bonusları sağlar:\n(1) Muhafızları \"Tanrı Diyarının Doğuşu\" etkinlik oynanışında güçlendirir, meydan okumaları kolaylaştırır.\n(2) \"Tanrı Diyarının Doğuşu\" meydan okumalarını tamamladıktan sonra elde edilen etkinlik parasını artırır.\n(3) \"Tanrı Kralın Fermanı\" etkinlik oynanışını etkinleştirir.\n\n<Title:Tanrı Kralın Fermanı>\n\"Adakla Sınav\" rezonansını etkinleştirdikten sonra, saatte otomatik olarak 60 \"Adak Sunucunun Gözyaşları\" alırsınız; en fazla 25 saatlik stok birikebilir.\n\n<Title:Uçurumun Yanıtı>\n1. \"Uçurumun Yanıtı\"nda üç sunak bulunur ve açılış zamanları şöyledir:\n\"Gözyaşı Sunağı\": 9 Mart 9:00 ~ 30 Mart 9:00.\n\"Kan Sunağı\": 11 Mart 9:00 ~ 30 Mart 9:00.\n\"Ruhlar Sunağı\": 13 Mart 9:00 ~ 30 Mart 9:00.\n2. Her sunu, 750 \"Adak Sunucunun Gözyaşları\"/\"Adak Sunucunun Kanı\"/\"Adak Sunucunun İliği\" tüketir ve sunaktan rastgele beş eşya ödülü verir.\n3. Her sunağın eşya ödülleri \"Özel Eşyalar\" ve \"Sıradan Eşyalar\" olarak sınıflandırılır. Sıfırlama sırasında, seçilen eşya ödüllerinin kalan miktarını azami sınıra geri yükleyebilirsiniz; özel kurallar şöyledir:\n(1) İlk 3 sıfırlama için: \"Özel Eşyalar\"ın kalan miktarı kalmadığında, Muhafızlar sıfırlamayı seçebilir; bu, \"Özel Eşyalar\" ve \"Sıradan Eşyalar\"ın kalan miktarlarını azami sınıra geri yükler. Ayrıca sunu yapmaya devam etmeyi de seçebilirler. \"Sıradan Eşyalar\"ın da kalan miktarı kalmadığında, sunuya devam etmek için sıfırlama gereklidir.\n(2) 4. sıfırlamadan itibaren: Sıfırlama yalnızca \"Sıradan Eşyalar\"ın kalan miktarı kalmadığında yapılabilir; bu, \"Sıradan Eşyalar\"ın kalan miktarını azami sınıra geri yükler ve \"Özel Eşyalar\" artık sıfırlanmaz.\n\n<Title:Düşdiyar>\n1. Etkinlik süresince \"Düşdiyar: Kirlet\" ücretsiz olacaktır.\n2. Etkinlik sona erdikten sonra \"Düşdiyar: Kirlet\" için soruşturma ilerlemesi korunur. \"Düşdiyar: Kirlet\" etkinlik sırasında açılmadıysa, etkinlik sonrasında da \"Gerçeklik Sınırı\" *7 harcanarak açılabilir.\n3. Etkinlik dönemi fark etmeksizin, \"Düşdiyar: Kirlet\"i temizlemek \"Çete: Gelgit Festivali\" kazandırır.\n\n<Title:Yeniden Yayın Telafisi>\n1. Daha önce \"Düşdiyar: Kirlet\"i açmış olan Muhafızlar, bu yeniden yayın etkinliğinde yeniden açtıklarında \"Adak Sunucunun Gözyaşları\" *700 telafisi alacaklardır.\n2. Daha önce sınırlı süreli avatar \"Gümüş Anahtar Adına: Miryam\"ı elde etmiş olan Muhafızlar için, tekrar elde edildiğinde otomatik olarak \"Biçimsiz Olanın Davetiyesi\" *1'e dönüştürülecektir.\n3. Daha önce rezonans etkinleştirme malzemesi \"Bağlılık Kalbi\"ni elde etmiş olan Muhafızlar için, her ekstra \"Bağlılık Kalbi\" otomatik olarak \"Gül Senedi\" *5000'e dönüştürülecektir.\n"
  },
  Activity_124051_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_124052_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_124053_ActivityName = {
    Text = "Dikenlerin Kraliçesi"
  },
  Activity_124053_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Dikenlerin Kraliçesi\" etkinliği süresince Koruyucular, Wanda'yı içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_124800_ActivityName = {Text = "Sıram"},
  Activity_124801_ActivityName = {
    Text = "Faz Tersine Çevirme"
  },
  Activity_124801_ActivityPlot = {
    Text = "Herkesin Kozmik Kartlar oynamasını istiyorum!\nBaşka bir zaman çizgisinden gelen bir ziyaretçi, yanlışlıkla Traphase uzamına adım attı ve burayı, eskiden olduğundan büsbütün farklı bir şeye dönüştürdü.\nBu uzamı bir kez daha geri çevirmek için, farklı zaman çizgilerinden gelen Koruyucular, aralarındaki en güçlünün kim olduğunu saptamalı ve bu ziyaretçiye meydan okumalı."
  },
  Activity_124801_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince, Muhafızlar \"Traphase\"e katılarak \"Başarı Ödülleri\"ndeki başarıları tamamlayabilir ve \"Sihirli Palamutlar\" kazanabilir.\n2. \"Sihirli Palamutlar\", \"Yuvarlak Harikalar\"da bol ödüller almak için kullanılabilir; bunların arasında etkinliğe özel avatar \"Sıram: Kozmik Kart\", etkinliğe özel 10 ifade, ayrıca \"Parçalanmış Düş Kalıntısı\", \"Yıldız Düş Kıvılcımı\" ve daha fazlası bulunur.\n3. Etkinlik süresince, \"Çok Boyutlu Bağ: Sıram\" ücretsiz olarak Alınabilir olacaktır!\n4. Etkinlik süresince, \"Çok Boyutlu Bağ: Sıram: Yabancı Diyardan Gelen Misafir\"i tamamlamış olan Muhafızların \"Traphase\" savaş arka planı geçici olarak \"Sıram: Zihin Manzarası\" ile değiştirilecektir.\n\n<Title: Başarı Ödülleri>\n1. \"Başarı Ödülleri\", \"Gizem Denemesi\", \"Onur Denemesi\" ve \"Eşik Denemesi\"ni içerir. Muhafızlar başarı hedeflerini tamamlayarak \"Sihirli Palamutlar\" alabilir.\n2. \"Gizem Denemesi\" başarılarında, her 3 düşman Uyanmış Takipçi yenildiğinde 10 \"Sihirli Palamut\" kazanılır, en fazla 50 kez. Her 6 Aliemus Patlaması serbest bırakıldığında 10 \"Sihirli Palamut\" kazanılır, en fazla 50 kez. Her 20 Kart oynandığında 10 \"Sihirli Palamut\" kazanılır, en fazla 50 kez.\n3. Temel Konular aracılığıyla geçici olarak açılan Uyanmışlar, Kader Çarkları ve Çeteler, zafer sayımlarına ve kart oynama sayımlarına normal şekilde dâhil edilir.\n\n<Title: Yuvarlak Harikalar>\n1. Muhafızlar, ilgili ödülleri almak için \"Sihirli Palamut\" biriktirebilir. 3.600 \"Sihirli Palamut\" biriktirmek tüm çekirdek ödüllerin, 6.000 \"Sihirli Palamut\" biriktirmek ise tüm ödüllerin kilidini açar!\n2. \"Sıram: Yabancı Diyardan Gelen Misafir\"i tamamlamak, 100–900 \"Sihirli Palamut\" biriktirme ödüllerinin; \"Sıram: Evreni Yeniden Şekillendiren An\"ı tamamlamak ise 1.000–6.000 \"Sihirli Palamut\" biriktirme ödüllerinin kilidini açar.\n\n<Title: Çok Boyutlu Bağ>\n1. Etkinlik süresince, \"Çok Boyutlu Bağ: Sıram\" ücretsiz olarak Alınabilir olacaktır.\n2. Etkinlik sona erdikten sonra, \"Çok Boyutlu Bağ: Sıram\"ın soruşturma ilerlemesi korunur. Eğer \"Çok Boyutlu Bağ: Sıram\" etkinlik sırasında açılmadıysa, etkinlik bittikten sonra da 3 adet \"Gerçeklik Sınırı\" harcanarak açılabilir.\n3. Etkinlik döneminde olsun ya da olmasın, \"Çok Boyutlu Bağ: Sıram\"ı tamamlamak \"Çete: Tavernanın Kapısı\" ödülünü verir.\n\n<Title:Etkinlik Süresi>\nBu etkinlik yalnızca 16 Mart 9:00’dan 30 Mart 9:00’a kadar (GMT+8) mevcuttur. Etkinlik, 30 Mart 9:00’dan (GMT+8) sonra sona erer. Muhafızlar, lütfen ödüllerinizi \"Yuvarlak Harikalar\"dan almayı unutmayın."
  },
  Activity_124801_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_124801_UnlockConditionExplanation = {
    Text = "\"Soruşturma Operasyonu\" 3-2 · Normal tamamlandıktan sonra açılır"
  },
  Activity_124834_ActivityName = {
    Text = "Siste Buluşma"
  },
  Activity_124834_ActivityPlot = {
    Text = "Morimens × Mist Sequence\nÖzel Ortak Daveti\n\"Adım Mouchette, şu... şeyin müfettişi... Ah evet, artık A.U.G.E.'nin öncüsü değilim. Kendimi yeniden tanıtayım—Ben Mouchette, sadece tatlı, sevimli bir kızım.\""
  },
  Activity_124834_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Siste Buluşma\" etkinliği süresince Solmuş Miras Böl. 1 \"Doğu Bölge Sırrı\"nı tamamlayarak yeni Sınırlı SSR Uyandırıcı \"Mouchette\"i ücretsiz olarak alın!\nAynı SSR Uyandırıcıyı 2. ile 16. kez elde ettiğinizde, her biri 1 ilgili Uyandırıcı Parçası ve 50 Kök Tortusu'na dönüştürülecektir; 17. kez ve sonrasında, sınırlı SSR Uyandırıcı 2 Rafine Gnosis Parçası, 6 Gnosis Parçası ve 250 Kök Tortusu'na dönüştürülecektir."
  },
  Activity_124834_BannerText = {
    Text = "Ücretsiz Sınırlı Uyandıran"
  },
  Activity_124981_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_124982_ActivityName = {
    Text = "Disosiyatif Hasta: Kaos"
  },
  Activity_124982_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Disosiyatif Hasta: Kaos\" etkinliği süresince Koruyucular, \"24\"ü içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini oynarken takım kadrosundaki Uyandırıcıda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra etkinlik arayüzünden demo ödüllerini talep edebilirsiniz."
  },
  Activity_124983_ActivityName = {
    Text = "Disosiyatif Hasta: Caro"
  },
  Activity_124983_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Disosiyatif Hasta: Caro\" etkinliği süresince Koruyucular, \"24\"ü içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_124984_ActivityName = {
    Text = "İsimsiz Şiir"
  },
  Activity_124984_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"İsimsiz Şiir\" etkinliği süresince Koruyucular, Horla'yı içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden demo ödüllerini talep edebilir."
  },
  Activity_124985_ActivityName = {
    Text = "Disosiyatif Hasta: Aequor"
  },
  Activity_124985_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Disosiyatif Hasta: Aequor\" etkinliği süresince Koruyucular, \"24\"ü içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini oynarken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_124986_ActivityName = {
    Text = "Disosiyatif Hasta: Ultra"
  },
  Activity_124986_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Disosiyatif Hasta: Ultra\" etkinliği süresince Koruyucular, \"24\"ü içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_124987_ActivityName = {
    Text = "Çoklu Şifa: Tekrar"
  },
  Activity_124987_ActivityPlot = {
    Text = "Histeri. Adına istersen mania de, istersen zihnin paramparça oluşu; bu çağda bu teşhis, bir idam fermanıdır. Neyse ki Mythag’ın bilim insanları ve Müfettişleri, kendilerine özgü bir delilikle maluldür: Bu dehşeti alt etmeye kararlıdırlar."
  },
  Activity_124987_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Ego Tahlili\" alınabilir."
  },
  Activity_124987_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince, Muhafızlar sınırlı süreli oynanışlar olan \"Hafıza Kodu\", \"Çılgın Birikim\" ve \"Başarı Ödülleri\" aracılığıyla etkinlik parası \"Hafıza Bulmacası\" toplayabilir. \"Hafıza Bulmacası\", \"Ego Tahlili\" içindeki eşyaları satın almak için kullanılabilir; bunlara etkinliğe özel SR Kader Çarkı \"Gümüş Morina'nın Kararlılığı\", Lümen Çekirdeği, Saf Çekirdek ve daha fazlası dahildir. \n2. Etkinlik süresince, \"Özel Görev Kayıtları: Dingin Bölünme\" geçici olarak ücretsiz açılacak ve etkinlik başarılarını tamamlamak, etkinliğe özel avatar \"Gümüş Anahtar Adına: '24'\"ü de kazandıracaktır!\n\n<Title:Etkinlik Zamanı>\n1. 23 Şubat, 9:00 - 9 Mart, 9:00 (GMT+8), tüm etkinlik oynanışları erişime açıktır. \n2. 9 Mart, 9:00 - 16 Mart, 9:00 (GMT+8), yalnızca \"Ego Tahlili\" ve Başarı Ödülleri erişime açık olacaktır. \n\n<Title:Hafıza Kodu>\n1. \"Hafıza Kodu\" 5 aşamadan oluşur; her 2 günde 1 aşama otomatik olarak açılır. \n2. Her meydan okuma 120 Menofin tüketecek, başarılı meydan okumalar etkinlik parası kazandıracaktır. \n3. Bir aşama temizlendikten sonra, o aşama için \"Yeniden Canlandır\" işlevi açılır. Lütfen dikkat: \"Yeniden Canlandır\" işlevini kullanmak Yakınlık kazandırmaz. \n4. Aşamaları daha kolay geçmek için Mezun Desteği ve \"Rezonans: Dissosiyatif Sendrom\"dan yararlanabilirsiniz. \n\n<Title:Akli Prim>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan Muhafızlar (sahaya sürülmeleri gerekmez), \"Hafıza Kodu\" görev ödüllerinde \"Hafıza Bulmacası\" için ek düşüş primi alabilir. Belirli primler şöyledir: \n Uyanan \"24\": Aydınlanma 0/1/2/3 ve üzeri, prim %20/%30/%40/%50. \n SSR Kader Çarkı \"Sapkın Yutma\": Yükseliş 0/1/2/3 ve üzeri, prim %20/%30/%40/%50. \n SR Kader Çarkı \"Gümüş Morina'nın Kararlılığı\": Yükseliş 0/1/2/3 ve üzeri, prim %20/%30/%40/%50. \n2. Farklı Uyananların veya Kader Çarklarının \"Akli Prim\"leri toplamsal biçimde hesaplanacaktır. \n3. Özellikle, Delilik Zorluğu meydan okumalarının ilk tamamlama ödülü \"Akli Prim\"den etkilenmeyecektir. \n\n<Title:Rezonans: Dissosiyatif Sendrom>\n1. Muhafızlar, etkinlik başarılarını tamamlayarak \"Bölünme Kalbi\" elde edebilir. \n2. \"Bölünme Kalbi\" tüketerek \"Rezonans: Dissosiyatif Sendrom\"u etkinleştirmek aşağıdaki primleri sağlar: \n(1) Muhafızları \"Hafıza Kodu\" ve \"Özel Görev Kayıtları: Dingin Bölünme\" etkinlik oynanışlarında güçlendirerek meydan okumaları kolaylaştırır. \n(2) \"Hafıza Kodu\" meydan okumalarını tamamladıktan sonra elde edilen ödülleri artırır. \n(3) \"Çılgın Birikim\" etkinlik oynanışını etkinleştirir. \n\n<Title:Çılgın Birikim>\n1. \"Teşhis: Parçalanmış Benlik\" rezonansını etkinleştirdikten sonra, her saat otomatik olarak 60 \"Hafıza Bulmacası α\" alırsınız; en fazla 25 saatlik birikim depolanabilir. \n2. \"Bilişsel Senkronizasyon\" rezonansını etkinleştirdikten sonra, her saat otomatik olarak 30 \"Hafıza Bulmacası β\" alırsınız; en fazla 25 saatlik birikim depolanabilir. \n\n<Title:Özel Görev Kayıtları>\n1. Etkinlik süresince, \"Özel Görev Kayıtları: Dingin Bölünme\" ücretsiz olarak açılabilir. \n2. Etkinlik sona erdikten sonra, \"Özel Görev Kayıtları: Dingin Bölünme\" için soruşturma ilerlemesi korunur ve etkinlik süresince tamamlanmamış soruşturma olaylarını tamamlamak, etkinlik dönemiyle tutarlı soruşturma ödülleri kazandırmaya devam eder. Eğer \"Özel Görev Kayıtları: Dingin Bölünme\" etkinlik süresince açılmadıysa, etkinlikten sonra 7 adet \"Gerçeklik Sınırı\" tüketilerek yine açılabilir. \n3. Etkinlik döneminde olsun ya da olmasın, \"Özel Görev Kayıtları: Dingin Bölünme\"yi temizlemek \"Takım: Onun Her Şeyi\"ni kazandırır. \n\n<Title:Yeniden Yayım Telafisi>\n1. Daha önce \"Özel Görev Kayıtları: Dingin Bölünme\"yi açmış olan Muhafızlar, bu yeniden yayım etkinliğinde yeniden açtıklarında 700 adet \"Hafıza Bulmacası α\" telafisi alacaktır. \n2. Daha önce etkinliğe özel avatar \"Gümüş Anahtar Adına: '24'\"ü elde etmiş olan Muhafızların fazlalıkları, otomatik olarak 1 adet \"Biçimsiz Olanın Davetiyesi\"ne dönüştürülecektir. \n3. Daha önce etkinleştirme malzemesi \"Bölünme Kalbi\"ni elde etmiş olan Muhafızların her fazla \"Bölünme Kalbi\", otomatik olarak 5000 adet \"Gül Senedi\"ne dönüştürülecektir. \n"
  },
  Activity_124987_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_124988_ActivityName = {
    Text = "Ruh Biçicisi"
  },
  Activity_124988_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Ruh Biçicisi\" etkinliği süresince Koruyucular, Helot-catena'yı içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden demo ödüllerini talep edebilir."
  },
  Activity_125364_ActivityName = {
    Text = "Huangpu Fısıltıları"
  },
  Activity_125364_ActivityPlot = {
    Text = "Güç, şehvet ve yaldızlı bir çürüme. Malikânenin derinliklerinde, cansız bedenlerle bezenmiş sunu masasının üzerinde, kadim varlık yavaşça Onun Gözlerini açtı.\nAh, ama bu korkunç bir hikâye değil. O seni \"seviyor\", seni sonsuza dek \"koruyacak\"... Sana \"en iyinin de ötesinde\" olan her şeyi bahşetmeye niyetli."
  },
  Activity_125364_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Issız Sunu\" Alınabilir."
  },
  Activity_125364_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\nEtkinlik süresince, Muhafızlar sınırlı süreli oynanışlar olan \"Obsidian Matriarch\" ve \"Başarı Ödülleri\" aracılığıyla etkinlik parası \"Armut Şurubu Şekeri\" toplayabilir. \"Armut Şurubu Şekeri\", \"Issız Sunu\" içinde etkinliğe özel SR Kader Çarkı \"Magnolia'nın Cazibesi\", Lümen Çekirdeği, Saf Çekirdek, Eter Taşı Kırıntısı, Taklit Kristali ve daha fazlası ile takas edilebilir.\n\n<Title:Obsidian Matriarch>\n1. \"Obsidian Matriarch\", keşif olmadan doğrudan savaşılabilen 9 malzeme aşamasından oluşur ve her gün bir aşama açılır.\n2. Her meydan okuma 120 Menofin tüketir ve başarılı meydan okumalar yetiştirme malzemeleri ile etkinlik parasını kazandırır.\n3. Bir aşama temizlendikten sonra, o aşama için \"Yeniden Canlandır\" özelliği açılır. Lütfen dikkat: \"Yeniden Canlandır\" özelliğini kullanmak Afinite kazandırmaz.\n4. Aşamaları daha kolay geçmek için Mezun Yardımı'nı kullanabilirsiniz.\n\n<Title:Etkinlik Bonusları>\n1. Belirli Uyanmışlara veya Kader Çarklarına sahip olan Muhafızlar (sahaya sürülmeleri gerekmez), \"Obsidian Matriarch\" aşama görevlerinde (Yeniden Canlandır dahil) \"Armut Şurubu Şekeri\" için ek düşüş bonusları elde edebilir. Özel bonuslar aşağıdaki gibidir:\n Uyanmış \"Xu\": Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n SSR Kader Çarkı \"Boş Pişmanlıklar\": Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n SR Kader Çarkı \"Magnolia'nın Cazibesi\": Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n2. Farklı Uyanmışların veya Kader Çarklarının \"Etkinlik Bonusları\" toplamalı şekilde hesaplanır.\n3. Özellikle, Delilik Zorluğu için ilk tamamlama meydan okuma ödülleri, yukarıda bahsedilen bonuslardan etkilenmez.\n\n<Title:Issız Sunu>\n1. Her bir \"Sunu\" 750 \"Armut Şurubu Şekeri\" tüketir ve \"Issız Sunu\" havuzundan rastgele beş eşya ödülü verir.\n2. \"Issız Sunu\"dan gelen eşya ödülleri \"Özel Eşyalar\" ve \"Sıradan Eşyalar\" olarak ikiye ayrılır. Sıfırlama sırasında, özel eşya ödüllerinin kalan miktarı limite kadar sıfırlanabilir; özel kurallar aşağıdaki gibidir:\n(1) İlk 5 sıfırlama için: Hiç \"Özel Eşya\" kalmadığında, Muhafızlar sıfırlamayı seçebilir; bu, \"Özel Eşyalar\" ve \"Sıradan Eşyalar\"ın kalan miktarlarını limite sıfırlar; Muhafızlar takasa devam etmeyi de seçebilir ve \"Sıradan Eşyalar\" tükendiğinde, takasa devam edebilmek için sıfırlama yapılması zorunludur.\n(2) 6. sıfırlamadan itibaren: Yalnızca hiç \"Sıradan Eşya\" kalmadığında sıfırlama yapılabilir ve bu sıfırlama yalnızca \"Sıradan Eşyalar\"ın kalan miktarını limite sıfırlar; \"Özel Eşyalar\" artık sıfırlanmaz.\n\n<Title:Psişe Derin Dalışı>\n1. Etkinlik süresince, \"Yelpazenin Ardındaki Fısıltılar\" ücretsiz olarak açılabilir.\n2. Etkinlik sona erdikten sonra, \"Yelpazenin Ardındaki Fısıltılar\" için soruşturma ilerlemesi korunur. Etkinlik sırasında tamamlanmamış herhangi bir soruşturma olayını sonradan tamamlamak, etkinlik sırasındakiyle aynı soruşturma ödüllerini verir. Eğer \"Yelpazenin Ardındaki Fısıltılar\" etkinlik sırasında açılmadıysa, etkinlik bittikten sonra da \"Reality Verge\"*3 harcayarak açılabilir.\n3. İster etkinlik sırasında ister sonrasında olsun, \"Psişe Derin Dalışı: Yelpazenin Ardındaki Fısıltılar\"ı temizlemek size \"Çete: Konak Yankıları\"nı kazandırır.\n\n<Title:Etkinlik Süresi>\n1. 26 Ocak, 9:00 - 9 Şubat, 9:00 (GMT+8) arasında, etkinlik özetindeki tüm içeriklere katılım mümkündür.\n2. 9 Şubat, 9:00 - 16 Şubat, 9:00 (GMT+8) arasında yalnızca \"Issız Sunu\" ve \"Başarı Ödülleri\" kalır; diğer tüm içerikler sona erer ve katılıma kapalıdır.\n3. 16 Şubat, 9:00 (GMT+8) sonrasında, kullanılmamış tüm \"Armut Şurubu Şekeri\" 40 \"Rose Scrip\" oranıyla geri alınacaktır. Lütfen zamanında almak için gelen kutunuzu kontrol edin."
  },
  Activity_125364_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_125366_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_125366_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Xu\" şunları etkinleştirebilir:\n<BlueQuality:Kişilik Derinleşmesi +4, Aşırı Yüceltme Patlaması'nı Aç>."
  },
  Activity_125367_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_125368_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_125368_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Xu\" <BlueQuality:Aydınlanma 3>'ü etkinleştirebilir."
  },
  Activity_126275_ActivityName = {
    Text = "Bağlı Dokumacı"
  },
  Activity_126275_ActivityPlot = {
    Text = "Çark usulca döner, çağlar boyunca durmaksızın döner. Gümüş iplikler boyunca dans et, Ey Büyük Dokumacı. Zira kader, asla kaçamayacağın bir sahnedir.\nYargıç. Kurtarıcı. Efendiçe. Tutsak…\nBu sahneye adım attığın andan itibaren, oynayacağın rol artık senin seçimin değildi."
  },
  Activity_126275_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Tiyatro Hediyelikleri\" kullanılabilir."
  },
  Activity_126275_ActivityTips = {
    Text = "<Title:Etkinlik Genel Bakış>\nEtkinlik süresince Koruyucular, süreli oynanış \"Kukla Sahnesi\" ve \"Başarım\" aracılığıyla etkinlik para birimi \"A-Rezerve Bilet\" toplayabilir. \"A-Rezerve Bilet\", özel SR Kader Çarkı \"Rota Fortunae\", Ruhani Çekirdek, Saf Çekirdek, Eterik Parça, Mimetik Kristal ve daha fazlasını içeren \"Tiyatro Hediyelikleri\" bölümünde ödüllerle takas edilebilir.\n\n<Title:Kukla Sahnesi>\n1. \"Kukla Sahnesi\" 5 aşama içerir ve her 2 günde 1 aşama açılır.\n2. Her meydan okuma \"Menofin\" × 120 harcar. Bir meydan okumayı başarıyla tamamlamak, yetiştirme malzemeleri ve etkinlik para birimi ödülü verir.\n3. Bir aşamayı tamamladıktan sonra o aşamanın \"Yeniden Canlandırma\" özelliği açılır. Lütfen dikkat: \"Yeniden Canlandırma\" özelliği kullanılırken Afinite kazanılamaz.\n4. Aşamaları daha kolay tamamlamanıza yardımcı olması için Mezun Desteği kullanabilirsiniz.\n\n<Title:Etkinlik Bonusu>\n1. Belirli Uyandırıcılara veya Kader Çarklarına sahip olan Koruyucular (konuşlandırılmaları gerekmez), \"Kukla Sahnesi\" aşama görev ödüllerinde (Yeniden Canlandırma dahil) \"A-Rezerve Bilet\" için ek düşüş bonusu kazanabilir. Spesifik bonuslar aşağıdaki gibidir:\n·Uyandırıcı \"Arachne\": Aydınlanma 0/1/2/3 veya üzeri, bonus %20/%30/%40/%50\n·SSR Kader Çarkı \"Eternal Weave\": Yükseliş 0/1/2/3 veya üzeri, bonus %20/%30/%40/%50\n·SR Kader Çarkı \"Rota Fortunae\": Yükseliş 0/1/2/3 veya üzeri, bonus %20/%30/%40/%50\n2. Farklı Uyandırıcılar veya Kader Çarklarından gelen \"Etkinlik Bonusu\" birikerek hesaplanır.\n3. Özellikle, Delilik Zorluğu için ilk tamamlama meydan okuma ödülleri yukarıdaki bonuslardan etkilenmez.\n\n<Title: Tiyatro Hediyelikleri>\n1. Her \"Hediyelik Takası\" 750 \"A-Rezerve Bilet\" harcar ve \"Tiyatro Hediyelikleri\"nden rastgele beş eşya ödülü verir.\n2. \"Tiyatro Hediyelikleri\"ndeki eşya ödülleri \"Özel Eşyalar\" ve \"Normal Eşyalar\" olarak ayrılır. Sıfırlama, Özel Eşya ödüllerinin kalan miktarını maksimuma geri yükleyebilir. Spesifik kurallar aşağıdaki gibidir:\n(1) İlk 5 Sıfırlama: \"Özel Eşyalar\"ın kalan miktarı olmadığında, Koruyucular sıfırlamayı seçebilir; bu, hem \"Özel Eşyalar\" hem de \"Normal Eşyalar\"ın kalan miktarlarını limite sıfırlar; veya takas etmeye devam etmeyi seçebilirler. \"Normal Eşyalar\"ın da kalan miktarı olmadığında, takas etmeye devam etmek için sıfırlama yapılmalıdır.\n(2) 6. Sıfırlamadan itibaren: Sıfırlama yalnızca \"Normal Eşyalar\"ın kalan miktarı olmadığında yapılabilir. Sıfırlama, \"Normal Eşyalar\"ın kalan miktarını limite geri yükler, ancak \"Özel Eşyalar\" artık sıfırlanmaz.\n\n<Title:Etkinlik Süresi>\n1. 20 Nisan, 9:00 – 18 Mayıs, 9:00 (GMT+8): Tüm etkinlik oynanışları kullanılabilir.\n2. 4 Mayıs, 9:00 – 11 Mayıs, 9:00 (GMT+8): Yalnızca \"Tiyatro Hediyelikleri\" ve \"Başarım\" kullanılabilir.\n3. 11 Mayıs, 9:00 (GMT+8) sonrası: Kullanılmamış kalan \"A-Rezerve Bilet\"ler, bilet başına \"Altın Gül\" × 40 oranında dönüştürülecektir. Lütfen ödüllerinizi kontrol etmeyi unutmayın."
  },
  Activity_126275_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_126365_ActivityName = {
    Text = "Kader Arşivleri"
  },
  Activity_126365_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Belirlenen görevleri tamamlayarak Kader Arşivleri'nde ödüller alın.\n2. Görevler gruplar halindedir ve etkinlik başladıktan sonra her gün bir grup açılır.\n3. Hac Arşivlerini açmak, görev tamamlama için ek ödüller sağlar.\n4. Not: Etkinleştirilen Premium Arşivler yalnızca bu Arşiv etkinliğinde geçerlidir."
  },
  Activity_126366_ActivityName = {
    Text = "Yolculuk Anma Sunusu: Yıldız Bölümü V"
  },
  Activity_126366_ActivityPlot = {
    Text = "Yanılsama Hafıza mühürlenip arşivlendi, geçmişe kaydedilen bir yolculuk. Anımsama anlarında, saygılı Haracınızı sunmayı unutmayın."
  },
  Activity_126492_ActivityName = {
    Text = "Panlong İç Dökmeleri"
  },
  Activity_126492_ActivityTips = {
    Text = "<Title:Panlong Monologları>\nBu Kayıtlar etkinliğiyle birlikte 8 hediye paketi gelir; ilk hediye paketi ücretsiz olarak alınabilir.\n“Panlong Monologları”nı satın aldıktan sonra, 2. hediye paketini hemen alabilir ve 3–8. paketleri belirli bekleme sürelerinin ardından açabilirsiniz.\nToplamda “Gümüş” *20.000, “Lümen Çekirdeği” *30, “Zaman Döngüsü Kopyası”, “Prototip Ufuk” ve daha fazlasını alabilirsiniz. 26 Ocak saat 09:00’dan önce satın alarak ayrıca “Yelpazesinin Ardında” özel avatarını ve “Biçimsiz Olanın Davetiyesi” *10 elde edin!\nBu saatten sonra yapılan satın alımlar bu süreli özel ödülleri içermeyecektir. Satın alma sonrasında, kayıt süresi Kalıcı hâle gelir ve yalnızca tüm hediye paketlerini aldıktan sonraki gün kapanır.\n“Panlong Monologları” sınırlı bir süre için Alınabilir; lütfen satın alma işleminizi 23 Şubat saat 09:00’dan önce tamamlayın."
  },
  Activity_126492_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_127173_ActivityName = {Text = "Ressam"},
  Activity_127173_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n \"Ressam\" etkinliği süresince Koruyucular, Pickman'i içeren sistem tarafından önceden ayarlanmış takım dizilişlerini kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\n Etkinlik aşamalarını deneyimlerken Takım Dizilişinizdeki Uyandırıcıları değiştiremezsiniz.\n<Title:Etkinlik Ödülleri>\n Aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_129488_ActivityName = {
    Text = "Çılgın Gökyüzü Rayı"
  },
  Activity_129488_ActivityPlot = {
    Text = "Çılgın komutlar salonu delip geçti, trenin sabit uğultusunu bastırdı.\n\"Salvador, üçüncü vagona destek lazım, lütfen!\"\n\"Wanda, kontrol ettiğin kuklalarını arkaya it; bize yetişiyorlar!\"\n\"Ryker! Flört etmeyi bırak! Gel de camımın dışındaki o tırtığı def etmeme yardım et!\"\nLüks kompartımanda, cebinize küçük bir figürün süzüldüğünü fark edemeyecek kadar bunalmıştınız.\n\"Hehe, işte şimdi işler eğlenceli olmaya başlıyor.\"\n\"Birinci sınıf görüntüler yakaladım~ Küçük yardımcı 'N'nin sahneye çıkma zamanı!\""
  },
  Activity_129488_ActivityTips = {
    Text = "<Title:Etkinlik Genel Bakış>\nEtkinlik süresince \"İz Sürme\" ile özel ödüller kazanın. Etkinlik sona erdiğinde bu sınırlı süreli ödüller artık mevcut olmayacaktır, bu yüzden zamanında aldığınızdan emin olun.\nKatılım, takımınız için seviye telafisi sağlar: Seviye 60'ın, Beceri Seviyesi 5'in, Delilik Alameti Seviyesi 6'nın veya Ruh Dövme Yeteneği Seviyesi 5'in altındaki Uyandırıcılar bu minimum seviyelere yükseltilecektir. Seviye 60'ın altındaki Koruyucular da bu meydan okuma süresince Seviye 60'a telafi edilecektir.\n\n<Title:Özel Operasyonlar>\nEtkinlik süresince \"Özel Operasyonlar: Bahar Festivali Ekspresi\" ücretsiz erişime açıktır.\nEtkinlik sona erdikten sonra ilerlemeniz korunur. Etkinlik süresince açılmadıysa, \"Bahar Festivali Ekspresi\"ne daha sonra 7 \"Gerçeklik Başlangıç Noktası\" harcayarak erişilebilir.\n\"Bahar Festivali Ekspresi\"ni tamamlamak, etkinlik zamanlamasından bağımsız olarak \"Müfreze: Yıl Sonu Kıvılcımları\" ödülünü verecektir.\n<Title:Çılgın Gökyüzü Rayı>\n\"Astral Hüküm\" kurallarına dayanan kalıcı bir meydan okuma. Dinamik, rastgele karşılaşmalarla çeşitli soruşturma patronlarıyla yüzleşin!\nKalıntı kapasiteniz genişletildi ve aynı anda 36 kalıntıya kadar taşıyabilirsiniz.\nKoruyucular artık 3 farklı soruşturma eyleminden güçlü \"Rezonans\" efektlerine sahip olabilir ve bunları geliştirebilir.\nAcil Durum Gnosis her kullanıldığında, bu meydan okumada %20 daha az VIP Puanı kazanırsınız; lütfen taktik stratejilerinizi ekstra dikkatle planlayın.\nİlerlemenizi kaydetmek için ara çıkabilirsiniz, ancak takım istatistikleri harici yükseltmelerle senkronize olmayacaktır. İlerleme, son oturumunuzdan sonra 7 gün boyunca korunur; bu süre içinde devam edilmezse, koşu terk edilmiş sayılacaktır.\n\n<Title:VIP Listesi>\n1. Etkinlik süresince \"VIP Listesi\"ndeki kayıtlar korunacak ve etkinlik sona erdikten sonra Mythag Etkinlikleri döngüsüne göre sıfırlanacaktır.\n2. \"VIP Listesi\", meydan okumalarda mükemmel performans gösteren Koruyucuları kaydedecektir. Her Mythag Etkinliği döneminde bir kez meydan okuyup başarıyla \"VIP Puanı\" kazanan Koruyucular \"VIP Listesi\"ne girecektir.\n3. \"VIP Listesi\"ndeki sıralama, tek bir meydan okumada kazanılan maksimum \"VIP Puanı\" ve kullanılan minimum \"Tur\" sayısına göre belirlenecektir. Sıralamayı iyileştirmek için yeniden meydan okunabilir.\n\n<Title:Etkinlik Süresi>\n1. 9 Şubat 09:00 - 9 Mart 09:00 (GMT+8), tüm etkinlik içeriği katılıma açıktır.\n2. 9 Mart 09:00 (GMT+8) sonrasında etkinlik \"Atari Salonu\"nda arşivlenecek ve \"İz Sürme\"deki ödüller artık talep edilemeyecektir."
  },
  Activity_129488_BannerText = {
    Text = "Yeni Oynanış Etkinliği Mevcut!"
  },
  Activity_129508_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_129509_ActivityName = {
    Text = "Uğurlu Kırık Parçalar"
  },
  Activity_129509_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Her gün giriş yaptıktan sonra \"Uğurlu Parçalar\"dan günlük ödüllerinizi alın.\n2. Ödüller, toplam giriş sayınıza göre sırayla açılacak ve günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_129509_BannerText = {
    Text = "Giriş Yaparak Gümüş ve Ödüller Kazanın"
  },
  Activity_129705_ActivityName = {
    Text = "Yaşayan Alev"
  },
  Activity_129705_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Yaşayan Alev\" etkinliği süresince Koruyucular, Kathigu-Ra'yı içeren önceden ayarlanmış takımları kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nAşama görevini ilk kez tamamladığınızda, etkinlik arayüzünden deneme ödülleri talep edilebilir."
  },
  Activity_129706_ActivityName = {
    Text = "Hayırsever Başrahip"
  },
  Activity_129706_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n \"Merhemlerin Piskoposu\" etkinliği süresince Koruyucular, Salvador'u içeren sistem tarafından önceden ayarlanmış takım dizilişini kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcı değiştirilemez. \n<Title:Etkinlik Ödülleri>\n Aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_130174_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_130175_ActivityName = {
    Text = "Baş Aşağı Yeniden Doğuş"
  },
  Activity_130175_ActivityPlot = {
    Text = "Dünya fazlasıyla yalnız, dünya fazlasıyla ıssız. Lütfen dinleyin, lütfen tanık olun.\nÇığlık atan beden uzun sessizlikte bekliyor, çölde karahindiba açmasını bekliyor.\nSonra parlak sevgiyle dolacak ve bir kez daha Yeniden Doğuş'a kavuşacak."
  },
  Activity_130175_ActivityStageEndContent = {
    Text = "Etkinlik Sona Erdi. Şu anda yalnızca \"Karahindiba Bahçesi\" kullanılabilir."
  },
  Activity_130175_ActivityTips = {
    Text = "<Title:Etkinlik Tanıtımı>\n1, Etkinlik süresince, Koruyucular sınırlı süreli oyun modu \"Karanlık Oda Notları\" ve \"Başarım Ödülleri\" aracılığıyla etkinlik para birimi \"Saf Beyaz Pul Tozu\", \"Kırmızı Pul Tozu\" ve \"Parlak Pul Tozu\" toplayabilir; \"Karahindiba Bahçesi\" nde ürünlerle takas yapabilirler. Takas edilebilecek ürünler arasında etkinliğe özel SR Kader Çarkı \"Çamurdaki Peri Masalı\", Işıltılı Çekirdek, Saf Çekirdek ve daha fazlası yer almaktadır.\n2, Etkinlik süresince, \"Boyutsal Telgraf: Unutulmuş Aşk Tohumları\" sınırlı süreyle ücretsiz olarak açılacaktır. Etkinlik başarımlarını tamamlayarak etkinliğe özel profil resmi \"Gümüş Anahtar Adına: Saya\" yı da kazanabilirsiniz!\n\n<Title:Etkinlik Süresi>\n1,30 Mayıs 09:00 - 24 Ağustos 09:00(GMT+8) tarihleri arasında tüm etkinlik oyun modlarına katılabilirsiniz.\n2,24 Ağustos 09:00 - 31 Ağustos 09:00(GMT+8) tarihleri arasında yalnızca \"Karahindiba Bahçesi\" ve Başarım Ödüllerine katılabilirsiniz.\n\n<Title:Karanlık Oda Notları>\n1,\"Karanlık Oda Notları\" 7 bölüm içermekte olup her gün otomatik olarak 1 bölüm açılır.\n2, Her meydan okuma \"Gnosis İksiri\" × 120 tüketir; meydan okumayı başarıyla tamamlamak etkinlik para birimi kazandırır.\n3, Bir bölümü geçtikten sonra o bölümün \"Yeniden Oyna\"özelliği açılır. Lütfen dikkat: \"Yeniden Oyna\"özelliği kullanıldığında Uyum Oranı kazanılamaz.\n4, Geçişleri daha kolay hale getirmek için Mezun Birliği destek karakterlerini kullanabilirsiniz.\n\n<Title:Karahindiba Bahçesi>\n1,\"Karahindiya Bahçesi\" nde toplam üç mağaza bulunmakta olup açılış saatleri aşağıdaki gibidir:\n·\"Yetiştirme Bahçesi\": 30 Mayıs saat 09:00'da açılır.\n·\"Büyüyen Bahçe\": 31 Mayıs saat 09:00'da açılır.\n·\"Çiçek Açan Bahçe\": 1 Haziran saat 09:00'da açılır.\n2, Her takas işlemi \"Saf Beyaz Pul Tozu\"/ \"Kırmızı Pul Tozu\"/ \"Parlak Pul Tozu\" × 750 tüketir ve \"Karahindiba Bahçesi\" ndeki beş ürün ödülünden rastgele kazanılır.\n3, Her \"Karahindiba Bahçesi\" nin ürün ödülleri \"Özel Eşyalar\" ve \"Sıradan Eşyalar\" olmak üzere iki türe ayrılır. Sıfırlama yapıldığında Özel Eşya ödüllerinin kalan miktarı üst sınıra sıfırlanabilir. Ayrıntılı kurallar şu şekildedir:\n(1)İlk 2 sıfırlamada: \"Özel Eşyalar\"ın kalan miktarı tükendiğinde Koruyucu sıfırlamayı seçebilir; sıfırlama sonrasında hem \"Özel Eşyalar\" hem de \"Sıradan Eşyalar\"ın kalan miktarı üst sınıra sıfırlanır. Alternatif olarak takas yapmaya devam edebilir; \"Sıradan Eşyalar\" da tükendiğinde takas yapmaya devam edebilmek için sıfırlama zorunlu hale gelir.\n(2)3. sıfırlamadan itibaren: Sıfırlama yalnızca \"Sıradan Eşyalar\"ın kalan miktarı tükendiğinde yapılabilir. Sıfırlama, \"Sıradan Eşyalar\"ın kalan miktarını üst sınıra sıfırlar; \"Özel Eşyalar\" artık sıfırlanmaz.\n\n<Title:Etkinlik Bonusu>\n1, Koruyucuların belirli Uyandırıcılara veya Kader Çarklarına sahip olması(sahaya çıkarılması gerekmez) \"Karanlık Oda Notları\" bölüm görevi ödüllerindeki üç tür etkinlik para biriminin düşme miktarına ek bonus sağlar:\n·Uyandırıcı \"Saya\": Uyanış 0/1/2/3 ve üzeri için %20/%30/%40/%50 bonus.\n·SSR Kader Çarkı \"Dünya Kokuya Dönüşsün\": Yığın 0/1/2/3 ve üzeri için %20/%30/%40/%50 bonus.\n·SR Kader Çarkı \"Çamurdaki Peri Masalı\": Yığın 0/1/2/3 ve üzeri için %20/%30/%40/%50 bonus.\n2, Birden fazla \"Etkinlik Bonusu\" kümülatif olarak hesaplanabilir.\n3, Dikkat: Delilik Zorluğu ilk tamamlama meydan okuma ödülleri \"Etkinlik Bonusu\" ndan etkilenmez.\n\n<Title:Boyutsal Telgraf>\n1, Etkinlik süresince, \"Boyutsal Telgraf: Unutulmuş Aşk Tohumları\"ücretsiz olarak açılabilir.\n2, Etkinlik sona erdikten sonra araştırma ilerlemesi korunacaktır; etkinlik süresince tamamlanmayan araştırma olayları etkinlik sonrasında tamamlandığında da ilgili ödüller kazanılabilir. Etkinlik süresince açılmadıysa, etkinlik bittikten sonra \"Gerçeklik Başlangıç Noktası\" × 3 harcayarak açılmaya devam edilebilir.\n3, Etkinlik süresinde olup olmadığından bağımsız olarak, \"Boyutsal Telgraf: Unutulmuş Aşk Tohumları\" nı tamamlamak \"Yeni Dünya İçin\" anahtarını kazandırır."
  },
  Activity_130175_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_130176_ActivityName = {
    Text = "Çiçek Açan Agape"
  },
  Activity_130176_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Çiçek Açan Agape\" etkinliği süresince Koruyucular, Saya'yı içeren sistem tarafından önceden ayarlanmış takım dizilişini kullanarak belirlenen Sahneleri sınırsız kez deneyimleyebilir.\nEtkinlik Sahnelerini deneyimlerken, Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir Sahne meydan okumasını ilk kez tamamladıktan sonra, deneme ödülleri etkinlik arayüzünden talep edilebilir."
  },
  Activity_130376_ActivityName = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_130376_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Köken: Egemenlik\" etkinliği süresince Koruyucular, Köken: Egemenlik'i içeren sistem tarafından önceden belirlenmiş ekipleri kullanarak belirlenen seviyeleri sınırsız sayıda deneyimleyebilir.\nEtkinlik seviyelerini deneyimlerken ekip kadrosundaki Uyandırıcılar üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nSeviye meydan okumasını ilk kez tamamladıktan sonra etkinlik arayüzünde demo ödüllerini talep edebilirsiniz."
  },
  Activity_130403_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_130403_ActivityPlot = {
    Text = "Satın alımdan sonra \"Genesis Ogier\" etkinleştirebilir:\n<BlueQuality:Kişilik Derinleşmesi +4, Aşırı Yüceltme Patlaması Açılır>"
  },
  Activity_130404_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_130404_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Tsathoggua\" aktive edebilir\n<BlueQuality:Ruhsal Dalgalanma +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_130406_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_130406_ActivityPlot = {
    Text = "Satın alma sonrasında \"Tsathoggua\", <BlueQuality:Aydınlanma 3> özelliğini etkinleştirebilir"
  },
  Activity_130407_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_130407_ActivityPlot = {
    Text = "Satın alımdan sonra \"Genesis Ogier\" <BlueQuality:Aydınlanma 3>'ü etkinleştirebilir."
  },
  Activity_130408_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_130408_ActivityPlot = {
    Text = "Satın alımdan sonra \"Saya\" <BlueQuality:Aydınlanma 3>'ü etkinleştirebilir."
  },
  Activity_130409_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_130409_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Saya\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_130921_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_130922_ActivityName = {
    Text = "Moskstraumen"
  },
  Activity_130922_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Moskstraumen\" etkinliği süresince, Koruyucular Vortice içeren sistem tarafından hazırlanmış takım dizilişini kullanarak belirlenen bölümleri sınırsız sayıda deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken, takım dizilişindeki Uyandırıcılar üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBir bölüm meydan okumasını ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödülleri talep edilebilir."
  },
  Activity_130923_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_130923_ActivityPlot = {
    Text = "Satın alımdan sonra \"Vortice\" etkinleştirebilir:\n<BlueQuality:Kişilik Derinleşmesi +4, Aşırı Yüceltme Patlaması Açılır>"
  },
  Activity_130924_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_130924_ActivityPlot = {
    Text = "Satın alma sonrasında \"Vortice\", <BlueQuality:Aydınlanma 3> özelliğini etkinleştirebilir"
  },
  Activity_130925_ActivityName = {
    Text = "Moskstraumen'in Çağrısı"
  },
  Activity_130925_ActivityPlot = {
    Text = "Okyanusun derinliklerinde, girdap her şeyi yutar.\nMoskstraumen’in altındaki iblis ağzını açar—yaklaşmaya cüret eden her canlıya bir davet uzatır.\nGün be gün döner, yeniden ve yeniden ulur, nihayet gelecek olanı çağırır.\nGel. Gel. \"Yosunlar\" seni kucaklayacak; \"resifler\" sana eşlik edecek. Işıksız derinlikte, felaketle dans etmeye yazgılısın—\nve felaket... son yakarışına kulak verecek.\nEve hoş geldin, Seçilmiş Olan. Senin... asla bir seçimin olmadı.\n"
  },
  Activity_130925_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Vortice'nin Hazinesi\" alınabilir."
  },
  Activity_130925_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli “Vortice ve Deniz” oynanışı ve “Başarı” aracılığıyla “Birinci Deniz Kabuğu”, “İkinci Deniz Kabuğu” ve “Üçüncü Deniz Kabuğu” adlı etkinlik para birimlerini toplayabilir. “Birinci Deniz Kabuğu”, “İkinci Deniz Kabuğu” ve “Üçüncü Deniz Kabuğu”, “Vortice’nin Hazinesi”nde eşya satın almak için kullanılabilir; bunların arasında özel SR Kader Çarkı “Hapsedilmiş Delilik”, Lümen Çekirdeği, Saf Çekirdek ve daha fazlası bulunur.\n2. Etkinlik süresince “Zihin Dalgıçlığı: Artık Kıyı Yok” geçici olarak ücretsiz açılır. Etkinlik başarılarını tamamlayarak özel avatar “Gümüş Anahtar Adına: Vortice”yi de elde edebilirsiniz!\n\n<Title:Etkinlik Süresi>\n1. 9 Mart, 9:00 - 6 Nisan, 9:00 (GMT+8): Tüm etkinlik oynanışları açıktır.\n2. 6 Nisan, 9:00 - 13 Nisan, 9:00 (GMT+8): Yalnızca “Vortice’nin Hazinesi” ve Başarı Ödülleri açıktır.\n\n<Title:Vortice ve Deniz>\n1. “Vortice ve Deniz” 7 aşama içerir; her gün 1 aşama otomatik olarak açılır.\n2. Her meydan okuma 120 Menofin tüketir. Meydan okumayı başarıyla tamamlamak etkinlik para birimleri kazandırır.\n3. Bir aşama temizlendikten sonra, o aşama için “Yeniden Canlandır” işlevi açılır. Lütfen dikkat: “Yeniden Canlandır” işlevi kullanıldığında Yakınlık kazanılamaz.\n4. Aşamaları daha kolay geçmek için Mezun Desteği’ni kullanabilirsiniz.\n\n<Title: Vortice’nin Hazinesi>\n1. “Vortice’nin Hazinesi”nin üç dükkânı vardır; açılış zamanları şöyledir:\n“Birinci Hazine”: 23 Şubat 9:00’da açılır.\n“İkinci Hazine”: 24 Şubat 9:00’da açılır.\n“Üçüncü Hazine”: 25 Şubat 9:00’da açılır.\n2. Her takas, “Birinci Deniz Kabuğu”/“İkinci Deniz Kabuğu”/“Üçüncü Deniz Kabuğu”ndan 750 tüketerek “Vortice’nin Hazinesi”nden rastgele beş eşya ödülü elde eder.\n3. Her “Vortice’nin Hazinesi”ndeki eşya ödülleri iki türe ayrılır: “Özel Eşyalar” ve “Sıradan Eşyalar”. Sıfırlama sırasında, Özel Eşya ödüllerinin kalan miktarı sınırına kadar sıfırlanabilir. Özel kurallar şöyledir:\n(1) İlk 2 Sıfırlama: “Özel Eşyalar”ın kalan miktarı kalmadığında, Muhafızlar sıfırlama yapmayı seçebilir; bu, hem “Özel Eşyalar”ın hem de “Sıradan Eşyalar”ın kalan miktarını sınırına kadar sıfırlar; ya da takasa devam etmeyi seçebilirler. “Sıradan Eşyalar”ın da kalan miktarı kalmadığında, takasa devam etmek için mutlaka sıfırlama yapılmalıdır.\n(2) 3. Sıfırlamadan itibaren: Yalnızca “Sıradan Eşyalar”ın kalan miktarı kalmadığında sıfırlama yapılabilir. Sıfırlama, “Sıradan Eşyalar”ın kalan miktarını sınırına kadar geri yüklerken, “Özel Eşyalar” artık sıfırlanmaz.\n\n<Title:Etkinlik Bonusu>\n1. Belirli Uyanmışlara veya Kader Çarklarına sahip olan (sahaya yerleştirilmeleri gerekmez) Muhafızlar, “Vortice’nin Hazinesi” aşama görev ödüllerinde “Birinci Deniz Kabuğu”, “İkinci Deniz Kabuğu” ve “Üçüncü Deniz Kabuğu” için ek düşüş bonusları elde edebilir. Özel bonuslar şöyledir:\nUyanmış “Vortice”: Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\nSSR Kader Çarkı “Uzak Cennet”: Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\nSR Kader Çarkı “Hapsedilmiş Delilik”: Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\n2. Farklı Uyanmışlardan veya Kader Çarklarından gelen “Etkinlik Bonusu” istiflenerek hesaplanır.\n3. Özellikle, Delilik Zorluğu meydan okumalarının ilk-temizleme ödülleri “Etkinlik Bonusu”ndan etkilenmez.\n\n<Title:Zihin Dalgıçlığı>\n1. Etkinlik süresince “Zihin Dalgıçlığı: Artık Kıyı Yok” ücretsiz olarak açılabilir.\n2. Etkinlik sona erdikten sonra “Zihin Dalgıçlığı: Artık Kıyı Yok”un soruşturma ilerlemesi korunur. Etkinlik sırasında tamamlanmamış Soruşturma Olaylarını tamamlamak, etkinlik sırasındakiyle aynı soruşturma ödüllerini kazandırmaya devam eder. “Zihin Dalgıçlığı: Artık Kıyı Yok” etkinlik sırasında açılmadıysa, etkinlik bittikten sonra da “Gerçeklik Sınırı” *3 tüketilerek açılabilir.\n3. Etkinlik döneminde olsun ya da olmasın, “Zihin Dalgıçlığı: Artık Kıyı Yok”u temizlemek “Çete: Boğulmuş Masumiyet” ödülünü verir."
  },
  Activity_130925_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_131090_ActivityName = {
    Text = "Alevlerin Şöleni: Tekrar"
  },
  Activity_131090_ActivityPlot = {
    Text = "Göldeki Şehir Isarawu’nun, Wanda’nın memleketi olduğu söylenir.\nBu kez Rüya Kapısı’ndan geçecek ve saat dilleriyle dolu kadim kulelere varacaksın..."
  },
  Activity_131090_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Wanda'nın Hazine Sandığı\" kullanılabilir."
  },
  Activity_131090_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli “Alevlerin Şöleni” oynanışı ve “Başarı Ödülleri” aracılığıyla “Orijinal Kaval Kemiği”, “Tornoceras” ve “Sarmal Kalıntılar” adlı etkinlik para birimlerini toplayabilir. Etkinlik para birimleri, “Wanda’nın Hazine Mahzeni”nde eşya satın almak için kullanılabilir; bunların arasında özel SR Kader Çarkı “Isarawu'nun Bakışı”, Lümen Çekirdeği, Saf Çekirdek ve daha fazlası bulunur.\n2. Etkinlik süresince “Zihin Dalgıçlığı: Alevlerin Şöleni” geçici olarak ücretsiz açılır. Etkinlik başarılarını tamamlayarak özel avatar “Gümüş Anahtar Adına: Wanda”yı da elde edebilirsiniz!\n\n<Title:Etkinlik Süresi>\n1. 6 Nisan, 9:00 - 20 Nisan, 9:00 (GMT+8): Tüm etkinlik oynanışları açıktır.\n2. 20 Nisan, 9:00 - 27 Nisan, 9:00 (GMT+8): Yalnızca “Wanda’nın Hazine Mahzeni” ve Başarı Ödülleri açıktır.\n\n<Title:Göldeki Şehir>\n1. “Göldeki Şehir” 7 aşamadan oluşur; her gün 1 aşama otomatik olarak açılır.\n2. Her meydan okuma 120 Menofin tüketir. Meydan okumayı başarıyla tamamlamak etkinlik para birimleri kazandırır.\n3. Bir aşama temizlendikten sonra, o aşama için “Yeniden Canlandır” işlevi açılır. Lütfen dikkat: “Yeniden Canlandır” işlevi kullanıldığında Yakınlık kazanılamaz.\n4. Aşamaları daha kolay geçmek için Mezun Desteği ve “Rezonans: Gizli Vekâlet Emri”ni kullanabilirsiniz.\n\n<Title:Hazine Bonusu>\n1. Belirli Uyanmışlara veya Kader Çarklarına sahip olan (sahaya yerleştirilmeleri gerekmez) Muhafızlar, “Göldeki Şehir” aşama görev ödüllerinde etkinlik para birimleri için ek düşüş bonusları elde edebilir. Özel bonuslar şöyledir:\nUyanmış “Wanda”: Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\nSSR Kader Çarkı “Kraliçenin Fermanı”: Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\nSR Kader Çarkı “Isarawu'nun Bakışı”: Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\n2. Farklı Uyanmışlardan veya Kader Çarklarından gelen “Hazine Bonusu” istiflenerek hesaplanır.\n3. Özellikle, Delilik Zorluğu meydan okumalarının ilk-temizleme ödülleri “Hazine Bonusu”ndan etkilenmez.\n\n<Title:Rezonans: Gizli Vekâlet Emri>\n1. Muhafızlar, etkinlik başarılarını tamamlayarak “Hedonizm Kalbi” elde edebilir.\n2. “Hedonizm Kalbi” tüketerek “Rezonans: Gizli Vekâlet Emri”ni etkinleştirmek, Muhafızları “Göldeki Şehir”de daha güçlü kılar, meydan okumaları kolaylaştırır; ayrıca aşamaları temizlerken ek etkinlik para birimleri kazandırır.\n\n<Title:Zihin Dalgıçlığı>\n1. Etkinlik süresince “Alevlerin Şöleni” ücretsiz olarak açılabilir.\n2. Etkinlik sona erdikten sonra “Alevlerin Şöleni”nin soruşturma ilerlemesi korunur. Etkinlik sırasında tamamlanmamış Soruşturma Olaylarını tamamlamak, etkinlik sırasındakiyle aynı soruşturma ödüllerini kazandırmaya devam eder. “Alevlerin Şöleni” etkinlik sırasında açılmadıysa, etkinlik bittikten sonra da “Gerçeklik Sınırı” *3 tüketilerek açılabilir.\n3. Etkinlik döneminde olsun ya da olmasın, “Alevlerin Şöleni”ni temizlemek “Çete: Çürüme Şöleni” ödülünü verir.\n\n<Title:Yeniden Yayın Telafisi>\n1. Daha önce “Zihin Dalgıçlığı: Alevlerin Şöleni”ni açmış olan Muhafızlar, bu yeniden yayın etkinliği sırasında tekrar açtıklarında “Orijinal Kaval Kemiği” *300 telafisi alacaktır.\n2. Daha önce özel avatar “Gümüş Anahtar Adına: Wanda”yı elde etmiş olan Muhafızların, onu yeniden elde ettiklerinde avatarları otomatik olarak 1 “Biçimsiz Olanın Davetiyesi”ne dönüştürülür.\n3. Daha önce Rezonans etkinleştirme malzemesi “Hedonizm Kalbi”ni elde etmiş olan Muhafızların, her fazla “Hedonizm Kalbi” otomatik olarak “Gül Senedi” *5000’e dönüştürülür.\n"
  },
  Activity_131090_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_131091_ActivityName = {
    Text = "Alevlerin Şöleni"
  },
  Activity_131370_ActivityName = {
    Text = "Şanslı Kazanan"
  },
  Activity_131370_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Belirlenen Arşiv görevlerini tamamladıktan sonra Koruyucular \"Şanslı Kazanan\" etkinliğinden ödülleri talep edebilir.\n2. \"Şanslı Kazanan\" 6 Nisan saat 9:00'da sona erecektir.\n3. Görevleri tamamladığınızda ekstra ödüller talep etmek için \"Premium Arşivler\"i açın.\n4. Lütfen dikkat: Bu etkinlikte açılan \"Premium Arşivler\" yalnızca bu etkinlik için geçerlidir. Koruyucular, lütfen bilinçli tüketim yapın."
  },
  Activity_131370_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_131849_ActivityName = {
    Text = "sonsuz hafıza"
  },
  Activity_131849_ActivityTips = {
    Text = "<Title:sonsuz hafıza>\n\nBu Sınırlı Arşivler 8 hediye paketi içerir. İlk hediye paketi doğrudan ücretsiz olarak talep edilebilirken, 2–8 arası hediye paketleri talep edilebilmesi için \"sonsuz hafıza\"nın satın alınması gerekir.\n\n\"sonsuz hafıza\" satın alındıktan sonra, 2. hediye paketinin ödülleri hemen talep edilebilir; sonraki hediye paketleri talep edilebilmesi için belirli bir süre beklenmesi gerekir.\n\n\"sonsuz hafıza\"yı 30 Mayıs 9:00'dan önce satın almak ayrıca ek ödüller kazandıracaktır: özel avatar \"Afiyet Olsun\" ve \"Biçimsiz Olan'ın Daveti\" ×10! 30 Mayıs 9:00'dan sonra satın almak artık sınırlı süreli özel ödülleri kazandırmayacaktır.\n\nLütfen dikkat: \"sonsuz hafıza\" 29 Haziran 9:00'a kadar satın alınabilir olacaktır."
  },
  Activity_131849_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_132331_ActivityName = {
    Text = "Kırmızılı Madam"
  },
  Activity_132331_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Kırmızılı Madam\" etkinliği süresince, Koruyucular \"Sorel\" içeren sistem tarafından hazırlanmış takım dizilişini kullanarak belirlenen Bölümleri sınırsız sayıda deneyimleyebilir.\nEtkinlik Bölümlerini deneyimlerken, takım dizilişindeki Uyandırıcılar üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBir Bölüm meydan okumasını ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_132332_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_132333_ActivityName = {
    Text = "Tanrı Kralın Dönüşü"
  },
  Activity_132333_ActivityPlot = {
    Text = "Dileklerin sonsuz arzusu içinde, uzun Hafif Uykusundan kısaca uyanır ve bu donuk dünyaya gerçek bir bakış fırlatır.\nEbedi bir yaşamda, bu bakış öylesine kısadır ki"
  },
  Activity_132333_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Farkındalık Uçurumu\" Alınabilir."
  },
  Activity_132333_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli oynanışlar \"Derin Deniz Bakışı\" ve \"Başarı Ödülleri\" aracılığıyla etkinlik para birimleri \"Yorgun Düşünceler\", \"Kederli Düşünceler\" ve \"Neşeli Düşünceler\" toplayabilirler. Etkinlik para birimleri, \"Uçurum Aydınlanması\"nda etkinliğe özel SR Kader Çarkı \"Mavi Taş Tahtı\", Lümen Çekirdeği, Saf Çekirdek, Eter Taşı Kırıntısı, Taklit Kristali ve daha fazlasını satın almak için kullanılabilir.\n2. Etkinlik süresince, etkinlik başarılarını tamamlamak ayrıca size etkinliğe özel avatar \"Gümüş Anahtar Adına: Tulu\", etkinliğe özel SR Kader Çarkı \"Mavi Taş Tahtı\", Gümüş ve büyük miktarda etkinlik para birimi kazandırır!\n\n<Title:Etkinlik Süresi>\n1. 6 Nisan, 9:00 – 4 Mayıs, 9:00 (GMT+8): Tüm etkinlik oynanışları Alınabilir.\n2. 4 Mayıs, 9:00 – 11 Mayıs, 9:00 (GMT+8): Yalnızca \"Uçurum Aydınlanması\" ve Başarı Ödülleri Alınabilir.\n\n<Title:Derin Deniz Bakışı>\n1. \"Derin Deniz Bakışı\" 5 aşamadan oluşur, her 2 günde bir aşama kendiliğinden açılır.\n2. Her meydan okuma denemesi Menophin × 120 tüketir. Meydan okumayı başarıyla tamamlamak etkinlik para birimleri kazandırır.\n3. Bir aşama temizlendikten sonra, o aşama için \"Yeniden Canlandır\" özelliği açılır. Lütfen dikkat: \"Yeniden Canlandır\" özelliği kullanıldığında Yakınlık kazanılamaz.\n4. Aşamaları daha kolay temizlemek için mezun Desteği kullanabilirsiniz.\n\n<Title:Teemmül Bonusu>\n1. Bir Muhafız belirli Uyananlara veya Kader Çarklarına sahipse (sahaya sürülmeleri gerekmez), \"Derin Deniz Bakışı\" aşama görev ödüllerindeki etkinlik para birimi düşüşleri ek düşüş bonusları alabilir. Belirli bonuslar aşağıdaki gibidir:\n·Uyanan \"Tulu\": Aydınlanma 0/1/2/3 veya üzeri, bonus %20/%30/%40/%50.\n·SSR Kader Çarkı \"Tanrı Kralın İlahisi\": Yükseliş 0/1/2/3 veya üzeri, bonus %20/%30/%40/%50.\n·SR Kader Çarkı \"Mavi Taş Tahtı\": Yükseliş 0/1/2/3 veya üzeri, bonus %20/%30/%40/%50.\n2. Farklı Uyananlar veya Kader Çarklarından gelen \"Teemmül Bonusu\" istiflenerek hesaplanır.\n3. Özellikle, Delilik Zorluğu için ilk-temizleme meydan okuma ödülleri \"Teemmül Bonusu\"ndan etkilenmez.\n\n<Title: Uçurum Aydınlanması>\n1. \"Uçurum Aydınlanması\" yalnızca 6 Nisan, 9:00 – 11 Mayıs, 9:00 (GMT+8) tarihleri arasında Alınabilir.\n2. 11 Mayıs, 9:00 (GMT+8) sonrasında, kullanılmamış kalan \"Yorgun Düşünceler\", \"Kederli Düşünceler\" ve \"Neşeli Düşünceler\" her bir para birimi başına Gül Senedi × 40 oranında dönüştürülerek posta yoluyla gönderilecektir. Lütfen gelen kutunuzu kontrol etmeyi unutmayın.\n\n<Title:Ruh Derin Dalışı>\n1. Etkinlik süresince \"Ruh Derin Dalışı: Taç Giyme Günü\" ücretsiz olarak açılabilir.\n2. Etkinlik sona erdikten sonra, \"Ruh Derin Dalışı: Taç Giyme Günü\"nün soruşturma ilerlemesi korunur. Etkinlik sırasında tamamlanmamış herhangi bir Soruşturma Olayını tamamlamak, etkinlik sırasındakiyle aynı soruşturma ödüllerini kazandırmaya devam eder. \"Ruh Derin Dalışı: Taç Giyme Günü\" etkinlik sırasında açılmadıysa, etkinlik sona erdikten sonra da Gerçeklik Sınırı × 3 harcanarak açılabilir.\n3. Etkinlik döneminde olsun ya da olmasın, \"Ruh Derin Dalışı: Taç Giyme Günü\"nü temizlemek size \"Takım: Yıldızların Kutsaması\" ödülünü verir.\n\n<Title:Yeniden Gösterim Telafisi>\n1. Daha önce \"Ruh Derin Dalışı: Taç Giyme Günü\"nü açmış olan Muhafızlar, bu yeniden gösterim etkinliği sırasında tekrar açtıklarında telafi olarak Yorgun Düşünceler × 300 alacaklardır.\n2. Daha önce etkinliğe özel avatar \"Gümüş Anahtar Adına: Tulu\"yu elde etmiş olan Muhafızlar, onu tekrar elde ettiklerinde otomatik olarak Biçimsiz Olanın Davetiyesi × 1’e dönüştürülecektir."
  },
  Activity_132333_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_132334_ActivityName = {
    Text = "Uyuyan Hükümdar"
  },
  Activity_132334_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Uyuyan Hükümdar\" etkinliği süresince, Koruyucular \"Tulu\" içeren sistem tarafından hazırlanmış takım dizilişini kullanarak belirlenen bölümleri sınırsız sayıda deneyimleyebilir.\nDeneme bölümlerinde, Takım Dizilişindeki Uyandırıcılar üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödülleri talep edilebilir."
  },
  Activity_132688_ActivityName = {
    Text = "İletişim Değişimi"
  },
  Activity_132688_ActivityTips = {
    Text = "<Title:Etkinlik Tanıtımı>\n 1, Koruyucular etkinlikte belirtilen görevleri tamamladıktan sonra \"Işıltılı Çekirdek\", etkinliğe özel profil fotoğrafları \"Winkle·Büyük Terminal\", \"Erica·Taşınabilir Terminal\" ve \"Koleksiyoncu Damgası: Koruyucu\" talep edebilir; ayrıca yeni 1 yıldızlı fantezi kıyafet \"Nautila·Sarmal Anımsama\", \"Helot·Zincir Kırıcı\" gibi etkinliğe özel ödüller de kazanılabilir! \n 2, Bu etkinlik kalıcı olarak açıktır. Etkinlikteki tüm görevler tamamlanıp ödüller alındıktan sonra, ertesi gün 9:00(GMT+8) itibarıyla etkinlik sona erer ve artık görüntülenmez.\n 3, Daha önce giriş ödülleri bölümünde \"PC cihazıyla giriş yap\" veya \"Mobil cihazla giriş yap\" görevlerini tamamladıysanız, bu görevler burada tekrar tamamlanmış olarak sayılmaz."
  },
  Activity_132908_ActivityName = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_132908_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Belirlenen arşiv görevlerini tamamladıktan sonra Koruyucular \"Önerilen Çeviri\" etkinliğinden ödülleri talep edebilir.\n2. \"Premium Arşivler\" açıldıktan sonra görevleri tamamlamak ek ödüller kazandıracaktır.\n3. Bu etkinliğin \"Premium Arşivler\" satın alma süresi sınırlıdır. Son tarihten sonra artık satın alınamayacaktır. Lütfen 20 Mayıs saat 9:00'dan önce kendi takdirinize göre satın alın.\n6. Lütfen dikkat: Bu etkinlikte açılan \"Premium Arşivler\" yalnızca bu etkinlik için geçerlidir. Lütfen bilinçli harcama yapın."
  },
  Activity_132908_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_132934_ActivityName = {
    Text = "Sümbülteber ve Mür ile"
  },
  Activity_132934_ActivityTips = {
    Text = "<Title:Giriş>\n·Etkinlik süresince Koruyucular, belirlenen hedefleri tamamladıktan sonra \"Sümbülteber ve Mür ile\" bölümünden ilgili ödülleri alabilir."
  },
  Activity_132934_BannerText = {
    Text = "Kostümü ücretsiz al!"
  },
  Activity_133271_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_133272_ActivityName = {
    Text = "Büyük Fetih: Tekrar"
  },
  Activity_133272_ActivityPlot = {
    Text = "Bir ihtişam çağı zamana yenik düşebilir, fakat savaşçılarının ruhu ebediyen sürer.\nHiçbir mezar onları tutamaz; hiçbir zincir onları bağlayamaz.\nYeni ufuklar çağırdığında, kızarmış etin kokusu yollarını çizer—altın, parıltılı—ve onlar, kanlı elleriyle şanı kapmak için ileri atılır.\nSöyle o hâlde! Söyle, kırılmamış cesaret için, ebedî imparatorluk için!\nRoma! Ey Roma!"
  },
  Activity_133272_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Artık yalnızca \"Haraç Sunma\"ya katılabilirsiniz."
  },
  Activity_133272_ActivityTips = {
    Text = "<Title:Etkinlik Genel Bakış>\n1. Etkinlik süresince Koruyucular, sınırlı süreli oynanış olan \"İlahi Av\" aracılığıyla etkinlik para birimi \"Leonian Izgara\"yı toplayabilir. \"Leonian Izgara\", \"Haraç Sun\" bölümünde Ruhani Çekirdek, Saf Çekirdek ve daha fazlası dahil olmak üzere eşya satın almak için kullanılabilir.\n2. Etkinlik süresince, \"Düş Diyarı: Mutfak Hâkimiyeti\" geçici olarak ücretsiz açılır.\n\n<Title:Etkinlik Süresi>\n1. 4 Mayıs 9:00 – 18 Mayıs 9:00 (GMT+8): Tüm etkinlik oynanışı kullanılabilir.\n2. 18 Mayıs 9:00 – 25 Mayıs 9:00 (GMT+8): Yalnızca \"Haraç Sun\" ve Başarım Ödülleri kullanılabilir.\n\n<Title:İlahi Av>\n1. \"İlahi Av\" 5 aşama içerir ve her 2 günde bir otomatik olarak 1 aşama açılır.\n2. Her meydan okuma Menophin × 120 tüketir ve başarılı tamamlama etkinlik para birimi ödüllendirir.\n3. Bir aşamayı tamamladıktan sonra, o aşama için \"Yeniden Canlandır\" özelliği açılır. Lütfen dikkat: \"Yeniden Canlandır\" özelliği kullanılırken Yakınlık kazanılamaz.\n4. Aşamaları daha kolay tamamlamanıza yardımcı olması için Mezunlar Desteğini kullanabilirsiniz.\n\n<Title: Haraç Sun>\n\"Haraç Sun\" mağazasında, etkinlik para birimi \"Leonian Izgara\"yı kullanarak eşyaları seçip doğrudan satın alabilirsiniz.\n\n<Title:Düş Diyarı>\n1. Etkinlik süresince, \"Düş Diyarı: Mutfak Hâkimiyeti\" ücretsiz olarak açılabilir.\n2. Etkinlik sona erdikten sonra, \"Düş Diyarı: Mutfak Hâkimiyeti\"nin soruşturma ilerlemesi korunacaktır. Etkinlik süresince tamamlanmamış Soruşturma Olaylarını tamamlamak, etkinlik sırasındakiyle aynı soruşturma ödüllerini kazandıracaktır. Etkinlik süresince \"Düş Diyarı: Mutfak Hâkimiyeti\" açılmadıysa, etkinlik sona erdikten sonra \"Gerçeklik Başlangıç Noktası\" × 7 tüketerek açılabilir.\n3. Etkinlik süresinde olup olmadığına bakılmaksızın, \"Düş Diyarı: Mutfak Hâkimiyeti\"ni tamamlamak \"Müfreze: Yırtıcı Kararlılık\" ödüllendirecektir."
  },
  Activity_133272_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_133301_ActivityName = {
    Text = "L'Heure du Thé"
  },
  Activity_133301_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n1. Belirlenmiş Arşivler görevlerini tamamladıktan sonra Koruyucular, \"L'Heure du Thé\"de ödülleri talep edebilir.\n2. \"L'Heure du Thé\" 18 Mayıs 9:00'da sona erecektir.\n3. Görevleri tamamladığınızda ekstra ödüller talep etmek için \"Premium Arşivler\"i açın.\n4. Lütfen dikkat: Bu etkinlikte açılan \"Premium Arşivler\" yalnızca bu etkinlik için geçerlidir. Koruyucular, lütfen bilinçli tüketim yapın."
  },
  Activity_133301_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_134393_ActivityName = {
    Text = "Yıldızlara Doğru"
  },
  Activity_134393_ActivityPlot = {
    Text = "Hatıra sınırlı SSR Kader Çarkı \"Ex Stellaris\"i talep etmek için her gün giriş yapın, toplamda 16 adet!"
  },
  Activity_134393_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n·Etkinlik süresince Koruyucular, \"Yıldızlara Doğru\" bölümünden her gün giriş yaparak hatıra sınırlı SSR Kader Çarkı \"Yıldızlara Doğru\"yu talep edebilir, toplamda 16 talep hakkı bulunmaktadır.\n·Ödüller, Koruyucunun toplam giriş sayısına göre sırayla açılacaktır. Günlük giriş ödülleri her gün 9:00'da (GMT+8) yenilenecektir."
  },
  Activity_134393_BannerText = {
    Text = "Ücretsiz Sınırlı SSR YK"
  },
  Activity_138582_ActivityName = {
    Text = "Çiçek Sarayı"
  },
  Activity_138582_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n1. Belirtilen arşiv görevlerini tamamladıktan sonra Koruyucular, \"Çiçek Sarayı\"nda ödülleri talep edebilir.\n2. \"Çiçek Sarayı\" 15 Haziran 09:00'da sona erecektir.\n3. \"Premium Arşivler\"i açtıktan sonra, görevleri tamamladığınızda ek ödüller talep edilebilir.\n4. Lütfen dikkat: Bu etkinlikte açılan \"Premium Arşivler\" yalnızca bu etkinlik için geçerlidir. Lütfen kendi takdirinize göre akıllıca harcayın."
  },
  Activity_138582_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_139116_ActivityName = {
    Text = "Rüya Gibi Buluşma"
  },
  Activity_139116_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n·Koruyucular, belirlenen görevleri tamamladıktan sonra \"Rüya Gibi Buluşma\" bölümünden ödülleri talep edebilir.\n·\"Premium Arşivler\" açıldıktan sonra, görevler tamamlandığında ek ödüller talep edilebilir.\n·Bu sefer \"Premium Arşivler\" satın almak için süre sınırı bulunmaktadır. Son tarihten sonra satın alınamaz. Lütfen 29 Haziran 9:00'dan (GMT+8) önce kendi takdirinize göre satın alın.\n·Lütfen dikkat: Bu etkinlik süresince açılan \"Premium Arşivler\" yalnızca bu etkinlik için geçerlidir. Koruyucuların akıllıca harcama yapmaları tavsiye edilir."
  },
  Activity_139116_BannerText = {
    Text = "Yepyeni sınırlı bir Uyandırıcı'yı ücretsiz kazan!"
  },
  Activity_139117_ActivityName = {
    Text = "Rüya Gibi Sunu"
  },
  Activity_139117_ActivityTips = {
    Text = "<Title:Tanıtım>\n·Etkinlik süresince belirtilen hedefleri tamamladıktan sonra Koruyucular, \"Rüya Gibi Sunu\" bölümünden ilgili ödülleri talep edebilir."
  },
  Activity_139117_BannerText = {
    Text = "Ücretsiz Düş Kıvılcımı kazan!"
  },
  Activity_139591_ActivityName = {
    Text = "Miyavlı Teşekkürler!"
  },
  Activity_139591_ActivityPlot = {
    Text = "\"Acil duyuru: Tüm öğretim üyeleri ve öğrenciler, lütfen mevcut görevlerinizi derhal bırakın ve kaçan deney deneklerinin yakalanmasına yardım edin.\"\n\"Tekrar ediyorum: Tüm öğretim üyeleri ve öğrenciler, lütfen mevcut görevlerinizi derhal bırakın ve kaçan deney deneklerinin yakalan—Kahretsin! Kediler içeri girdi!\"\n\nYayından gelen panikli sesi duyduğunuzda, tüm kampüs çoktan siyah kürke bürünmüştü ve herkes laboratuvardan kaçan bu küçük baş belalarını yakalamaya çalışırken telaşlanıyordu.\nSanki Bahar Festivali'nin intikamını almak istercesine, bu kara kediler yavaş yavaş ve metodik bir şekilde yurdunuza doğru ilerliyordu.\n\nAma yine de... üzerlerinde taşıdıkları büyük miktarda Altın Gül ve Gümüş düşünüldüğünde, intikam için mi yoksa iyiliğe karşılık vermek için mi geldiklerini söylemek zor.\nYine de onları fazla yakalamamaya dikkat edin."
  },
  Activity_139591_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi."
  },
  Activity_139591_ActivityTips = {
    Text = "<Title: Miyavlı Teşekkürler!>\nMiyavlı Teşekkürler! doğrudan meydan okunması gereken 7 benzersiz, tekrarlanamaz sahne içerir. Her gün bir yeni sahne açılır.\nHer meydan okumada ilgili \"Boyutsal Kara Kedi\"yi yenmek etkinlik ilerlemesine katkıda bulunur. Ödüller \"Kedi Yakalama Günlüğü\" üzerinden talep edilebilir.\nHer \"Boyutsal Kara Kedi\"nin çok sayıda kopyası vardır—etkinlik boyunca sınırsız sayıda meydan okuma denenebilir ve otomatik savaş desteklenir.\nHer sahne güçlü bonuslar sağlayan farklı Kalıntılar sunar.\nTüm sahneler bir Destek Koruyucu gerektirir. Etkinlik boyunca, karşılıklı takip edilen her Koruyucu size yalnızca bir kez destek sağlayabilir.\n\n\n<Title: Seviye Telafisi>\nMiyavlı Teşekkürler! tüm Koruyucuların yan yana savaşabilmesi için bir seviye telafi sistemi içerir!\nTelafi kuralları aşağıdaki gibidir:\nTakımınızdaki 60. seviyenin altındaki Uyandırıcılar, meydan okuma süresince 60. seviyeye telafi edilecektir.\nTakımınızdaki beceri seviyesi 5'in altındaki Uyandırıcılar, meydan okuma süresince beceri seviyesi 5'e telafi edilecektir.\nTakımınızdaki Delilik Alameti seviyesi 6'nın altındaki Uyandırıcılar, meydan okuma süresince seviye 6'ya telafi edilecektir.\nTakımınızdaki Ruh Dövme Yeteneği seviyesi 5'in altındaki Uyandırıcılar, meydan okuma süresince seviye 5'e telafi edilecektir.\n60. seviyenin altındaki Koruyucular, meydan okuma süresince 60. seviyeye telafi edilecektir.\n\n<Title: Kara Kedi Yakalama Günlüğü>\nEtkinlik süresince, ilgili \"Boyutsal Kara Kedi\"yi yenmek görev ilerlemesini biriktirir ve Koruyucuların \"Kedi Yakalama Günlüğü\" üzerinden ödül talep etmesini sağlar. Günlük iki bölüme ayrılmıştır: \"Kişisel Yakalama Günlüğü\" ve \"Kampüs Yakalama Günlüğü\". \"Kişisel Yakalama Günlüğü\" her Koruyucunun bireysel ilerlemesini takip eder. \"Kampüs Yakalama Günlüğü\" tüm Koruyucuların kampüs genelindeki toplam ilerlemesini takip eder.\n\n<Title: Yakalama Sıralamaları>\nEtkinlik süresince Koruyucular, \"Yakalama Sıralamaları\" altında \"Koruyucu Sıralaması\" ve \"Destek Sıralaması\"nı görüntüleyebilir.\n\n<Title: Etkinlik Süresi>\nKoruyucular, 15 Haziran saat 9:00'dan (GMT+8) önce etkinlik sayfasına erişebilir ve meydan okumaya katılabilir. Bu saatten sonra yeni Koruyucu kabul edilmeyecektir. Zaten katılmış olan Koruyucular, etkinlik henüz sona ermediyse katılmaya devam edebilir.\n\"Toplam Yakalama Sayısı\"na 15 Haziran saat 9:00'dan (GMT+8) önce ulaşılırsa, etkinlik 29 Haziran saat 9:00'da (GMT+8) sona erecektir. \"Toplam Yakalama Sayısı\"na o zamana kadar ulaşılmazsa, etkinlik \"Toplam Yakalama Sayısı\"na ulaşıldıktan 14 gün sonra sona erecektir."
  },
  Activity_139591_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_139922_ActivityName = {
    Text = "Hipnotik Shaggai"
  },
  Activity_139922_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n \"Hipnotik Shaggai\" etkinliği süresince Koruyucular, Clementine'i içeren sistem tarafından önceden ayarlanmış takım dizilişlerini kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\n Etkinlik aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcı değiştirilemez.\n<Title:Etkinlik Ödülleri>\n Bir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_139923_ActivityName = {
    Text = "Görünmez Senfoni"
  },
  Activity_139923_ActivityPlot = {
    Text = "Senfoni bir dokuma sanatıdır; farklı enstrümanların yolları karmaşık bir desen oluşturacak şekilde iç içe geçer.\nOnun ağında her nota rolünü oynar.\nDinle, eşsiz bir senfoni başlamak üzere."
  },
  Activity_139923_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Uyku Sarayı\" kullanılabilir."
  },
  Activity_139923_ActivityTips = {
    Text = "<Title:Etkinlik Tanıtımı>\n1. Etkinlik süresince Koruyucular, sınırlı süreli oynanışlar olan \"Kükreyen Makineler\" ve \"Başarımlar\" aracılığıyla etkinlik para birimi \"Aria'nın Zirvesi\"ni toplayabilir. \"Aria'nın Zirvesi\", \"Somnus Kalesi\"nde etkinliğe özel SR Kader Çarkı \"Bitmeyen Performans,\" \"Saf Çekirdek,\" \"Işıltılı Çekirdek,\" \"Eterik Parça,\" \"Mimetik Kristal\" ve daha fazlası dahil olmak üzere cömert ödüllerle takas edilebilir.\n2. Etkinlik süresince, \"Başarımlar\" görevlerini tamamlamak etkinliğe özel avatar \"Gümüş Anahtar Adına: Hameln,\" etkinliğe özel SR Kader Çarkı \"Bitmeyen Performans,\" Gümüş ve büyük miktarda etkinlik para birimi \"Aria'nın Zirvesi\" kazandıracaktır.\n\n<Title:Etkinlik Süresi>\n1. 15 Haziran 9:00 - 13 Temmuz 9:00 (GMT+8): Tüm etkinlik içeriği kullanılabilir.\n2. 13 Temmuz 9:00 - 20 Temmuz 9:00 (GMT+8): Yalnızca \"Somnus Kalesi\" ve \"Başarımlar\" kullanılabilir kalacaktır. Diğer tüm içerikler Sona Ermiş olacak ve erişilemeyecektir.\n\n<Title: Kükreyen Makineler>\n1. \"Kükreyen Makineler\" 9 Sahne içerir ve her gün otomatik olarak 1 tanesi açılır.\n2. Her meydan okuma girişimi Neurobrew × 120 tüketir. Farklı Sahnelere meydan okumak farklı malzeme düşüşleri ve etkinlik para birimi \"Aria'nın Zirvesi\" kazandırır.\n3. Bu etkinliğin Sahneleri doğrudan savaş malzeme Sahneleridir. Tamamladıktan sonra tekrar oynatılabilir! Her tekrar oynatma Neurobrew × 120 tüketir.\n4. Lütfen dikkat: Tekrar oynatma işlevi kullanılırken Senkronizasyon Oranı elde edilemez.\n\n<Title: Aria Bonusu>\n1. Belirli Uyandırıcılara veya Kader Çarklarına sahip olan Koruyucular (konuşlandırma gerekmez), \"Kükreyen Makineler\" Sahne görev ödüllerinden (tekrar oynatmalar dahil) bonus \"Aria'nın Zirvesi\" düşüşü alabilir. Belirli bonuslar aşağıdaki gibidir:\n·Uyandırıcı \"Hameln\": Aydınlanma 0/1/2/3 veya üzeri, bonus 20%/30%/40%/50%\n·SSR Kader Çarkı \"Ebedi Ağıt\": Yükseliş 0/1/2/3 veya üzeri, bonus 20%/30%/40%/50%\n·SR Kader Çarkı \"Bitmeyen Performans\": Yükseliş 0/1/2/3 veya üzeri, bonus 20%/30%/40%/50%\n2. Farklı Uyandırıcılar veya Kader Çarklarından gelen \"Aria Bonusu\" toplanarak hesaplanır.\n3. Özellikle, Delilik Zorluğu ilk Temizle meydan okuma ödülleri \"Aria Bonusu\"ndan etkilenmez.\n\n<Title: Somnus Kalesi>\n1. \"Somnus Kalesi\" yalnızca 15 Haziran 9:00 - 13 Temmuz 9:00 (GMT+8) arasında açıktır.\n2. 20 Temmuz 9:00'dan (GMT+8) sonra, takas edilmemiş kalan \"Aria'nın Zirvesi\" birim başına Altın Gül × 40 oranında dönüştürülecektir. Lütfen postanızı kontrol edin."
  },
  Activity_139923_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_139924_ActivityName = {
    Text = "Ebedi Sanatçı"
  },
  Activity_139924_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Ebedi Sanatçı\" etkinliği süresince Koruyucular, Hameln'i içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_139925_ActivityName = {
    Text = "Derinlerin Hanımefendisi"
  },
  Activity_139925_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Derinlerin Hanımefendisi\" etkinliği süresince Koruyucular, Murphy'yi içeren sistem tarafından önceden ayarlanmış takımı kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarında Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödülü talep edilebilir."
  },
  Activity_140080_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_140081_ActivityName = {
    Text = "Yaşayan Alev"
  },
  Activity_140081_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Yaşayan Alev\" etkinliği süresince Koruyucular, Kathigu-Ra'yı içeren önceden ayarlanmış takımları kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nAşama görevini ilk kez tamamladığınızda, etkinlik arayüzünden deneme ödülleri talep edilebilir."
  },
  Activity_140082_ActivityName = {
    Text = "Bir Milyon Güneş Alçalır: Tekrar"
  },
  Activity_140082_ActivityPlot = {
    Text = "Hiç Sönmeyen Efendileri için bir litani söylerler; asla unutmayacaklarına dair söz veren bir koro.\nEn yüce gökten, parlak ışıklardan oluşan bir fırtınayla iner O; sesi, ebedi görkemi ilan eder. Ayakları toprağa değdiğinde, kehribar bir ışık dünyanın üzerine düşer.\nBu, O’nun sunduğu cenazedir."
  },
  Activity_140082_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi, şu anda yalnızca \"Gizli Kale\"ye katılabilirsiniz"
  },
  Activity_140082_ActivityTips = {
    Text = "<Title:Etkinlik Tanıtımı>\n1, Etkinlik süresince, Koruyucular sınırlı süreli oynanış \"Kavrulmuşların Avı\", \"Sessiz Kamp Ateşi\" ve \"Başarı Ödülleri\" aracılığıyla etkinlik para birimi \"Zenginliğin\" Mührü\"\", \"Ölümün\" Mührü\"\", \"Savaşın\" Mührü\"\" toplayabilir; \"Zenginliğin\" Mührü\"\", \"Ölümün\" Mührü\"\", \"Savaşın\" Mührü\"\"\"Gizli Bir Üs\" mağazasında ürün satın almak için kullanılabilir; bu ürünler arasında etkinliğe özel SR Kader Çarkı \"Yaklaşan Güneş\", Işıltılı Çekirdek, Saf Çekirdek ve daha fazlası yer almaktadır.\n2, Etkinlik süresince, \"Sönmeyen Keder\" sınırlı süreliğine ücretsiz açılır; etkinlik başarımlarını tamamlayarak etkinliğe özel avatar \"Gümüş Anahtarla: Kathigu-Ra\" elde edebilirsiniz!\n\n<Title:Etkinlik Süresi>\n1,7 Eylül 9:00 - 5 Ekim 9:00(GMT+8), tüm etkinlik oynanışlarına katılabilirsiniz.\n2,5 Ekim 9:00 - 12 Ekim 9:00(GMT+8), yalnızca \"Gizli Bir Üs\" ve Başarı Ödülleri'ne katılabilirsiniz.\n\n<Title:Kavrulmuşların Avı>\n1,\"Kavrulmuşların Avı\" 7 sahne içerir; her 1 günde 1 sahne otomatik olarak açılır.\n2, Her meydan okuma \"Menofin\" × 120 tüketir; meydan okumayı başarıyla tamamlamak etkinlik para birimi kazandırır.\n3, Sahneyi temizledikten sonra o sahnenin \"Yeniden Canlandırma\"özelliği açılır. Lütfen dikkat: \"Yeniden Canlandırma\"özelliği kullanılırken Afinite kazanılamaz.\n4, Geçişi daha kolay tamamlamak için mezunlar derneği Destek'ini kullanabilirsiniz.\n\n<Title: Gizli Bir Üs>\n\"Gizli Bir Üs\"ün üç mağazası bulunmaktadır; açılış saatleri aşağıdaki gibidir:\n·\"Hazine Kasası\": 7 Eylül saat 9'da açılır.\n·\"Komisyon Odası\": 8 Eylül saat 9'da açılır.\n·\"Savaş Kampı\": 9 Eylül saat 9'da açılır.\nMağazada ürünleri seçerek doğrudan satın alabilirsiniz.\n\n<Title:Etkinlik Bonusu>\n1, Koruyucuların belirli Uyandırıcılara veya Kader Çarklarına sahip olması(sahaya sürülmesi gerekmez) \"Kavrulmuşların Avı\" sahne görevi ödüllerindeki \"Zenginliğin\" Mührü\"\", \"Ölümün\" Mührü\"\", \"Savaşın\" Mührü\"\" için ekstra düşme bonusu sağlar; ayrıntılı bonuslar aşağıdaki gibidir:\n·Uyandırıcı \"Kathigu-Ra\": Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\n·SSR Kader Çarkı \"Kehribar Renkli Ölüm\": Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\n·SR Kader Çarkı \"Yaklaşan Güneş\": Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\n2, Farklı Uyandırıcı veya Kader Çarklarının \"Etkinlik Bonusu\" birikimli olarak hesaplanır.\n3,Özellikle, Delilik Zorluğu ilk geçiş meydan okuma ödülleri \"Etkinlik Bonusu\" ndan etkilenmez.\n\n<Title: Sessiz Kamp Ateşi>\n1, Her saat otomatik olarak 60 \"Zenginliğin\" Mührü\"\" kazanılır; en fazla 25 saat depolanabilir.\n\n<Title:Gezinti>\n1, Etkinlik süresince, \"Sönmeyen Keder\"ücretsiz olarak açılabilir.\n2, Etkinlik sona erdikten sonra, \"Sönmeyen Keder\" in soruşturma ilerlemesi korunur; etkinlik süresince tamamlanmayan Soruşturma Olaylarını tamamladıktan sonra da etkinlik süresindekiyle aynı soruşturma ödülleri alınabilir. Etkinlik süresince \"Sönmeyen Keder\" açılmadıysa, etkinlik sona erdikten sonra \"Gerçeklik Başlangıç Noktası\" ×3 harcayarak açılabilir.\n3, Etkinlik süresinde olsun ya da olmasın, \"Gezinti: Sönmeyen Keder\" i temizledikten sonra \"Müfreze: Ölümsüz Güneş\" elde edilebilir."
  },
  Activity_140082_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_140188_ActivityName = {
    Text = "Tutku Akıntısı"
  },
  Activity_140188_ActivityTips = {
    Text = "<Title:Tanıtım>\n·Etkinlik süresince Koruyucu, \"Asli Özütleme\"de belirtilen miktarda Gümüş Asıl toplu olarak özütledikten sonra \"Tutku Akıntısı\"ndan ilgili ödülleri talep edebilir.\n·Lütfen \"Asli Özütleme\"de hediye edilen Gümüş Asıl miktarının, etkinlik kapsamındaki toplu Gümüş Asıl özütleme miktarına dahil edilmeyeceğini unutmayın."
  },
  Activity_140188_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_140462_ActivityName = {
    Text = "Tüm Şeylerin Uvertürü"
  },
  Activity_140462_ActivityTips = {
    Text = "<Title:Tanıtım>\n·Etkinlik süresince belirtilen hedefleri tamamladıktan sonra Koruyucular, \"Doğanın Uvertürü\"nden ilgili ödülleri talep edebilir."
  },
  Activity_140462_BannerText = {
    Text = "Kostümü ücretsiz al!"
  },
  Activity_140760_ActivityName = {
    Text = "Divus: Beyaz Gece"
  },
  Activity_140760_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Divus: Beyaz Gece\" etkinliği süresince Koruyucular, Pollux'u içeren sistem tarafından önceden ayarlanmış takımı kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarında Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödülü talep edilebilir."
  },
  Activity_140761_ActivityName = {
    Text = "Deniz Işıltısı"
  },
  Activity_140761_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Deniz Işıltısı\" etkinliği süresince Koruyucular, Corposant'ı içeren sistem tarafından önceden ayarlanmış takımları kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_140762_ActivityName = {
    Text = "Sisin İçindeki Canavar"
  },
  Activity_140762_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Sisin İçindeki Canavar\" etkinliği süresince, Koruyucular Mouchette içeren sistem tarafından hazırlanmış takımları kullanarak belirlenen bölümleri sınırsız sayıda deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken, takım dizilişindeki Uyandırıcılar üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_140763_ActivityName = {
    Text = "İsimsiz Şiir"
  },
  Activity_140763_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"İsimsiz Şiir\" etkinliği süresince Koruyucular, Horla'yı içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden demo ödüllerini talep edebilir."
  },
  Activity_140764_ActivityName = {
    Text = "Necrovia'nın Efendisi"
  },
  Activity_140764_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Necrovia'nın Efendisi\" etkinliği süresince, Koruyucular Doresain içeren sistem tarafından hazırlanmış takımı kullanarak belirlenen bölümü sınırsız sayıda deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken, takım dizilişindeki Uyandırıcılar üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez tamamladığınızda, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_141306_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_141306_ActivityPlot = {
    Text = "Satın aldıktan sonra, \"Pontos\" <BlueQuality:Aydınlanma 3>'ü etkinleştirebilir"
  },
  Activity_141307_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_141307_ActivityPlot = {
    Text = "Satın aldıktan sonra, \"Pontos\" etkinleştirebilir\n<BlueQuality:Ruh Dalgası +4, Aşırı Yüceltme'nin kilidini açar>"
  },
  Activity_141308_ActivityName = {
    Text = "Yarık Kaynağı"
  },
  Activity_141308_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Yarık Kaynağı\" etkinliği açık olduğu süre boyunca, Koruyucular Pontos'u içeren sistem tarafından hazırlanmış takımları kullanarak belirtilen sahneleri sınırsız kez deneyimleyebilir.\nEtkinlik sahneleri deneyimlenirken Takım Dizilişindeki Uyandırıcılar ayarlanamaz.\n<Title:Etkinlik Ödülleri>\nSahne meydan okumasını ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödülleri alınabilir."
  },
  Activity_141460_ActivityName = {
    Text = "Divus: Oniks Tüy"
  },
  Activity_141460_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Divus: Oniks Tüy\" etkinliği süresince Koruyucular, Castor'u içeren sistem tarafından önceden ayarlanmış takımı kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarında Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödülü talep edilebilir."
  },
  Activity_141462_ActivityName = {
    Text = "Uyuyan Hükümdar"
  },
  Activity_141462_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Uyuyan Hükümdar\" etkinliği süresince, Koruyucular Tulu içeren sistem tarafından hazırlanmış takımları kullanarak belirlenen bölümleri sınırsız sayıda deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken, takım dizilişindeki Uyandırıcılar üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra, oyuncular etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_141464_ActivityName = {
    Text = "Lady Qian Shan"
  },
  Activity_141464_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Lady Qian Shan\" etkinliği süresince, Koruyucular Xu içeren sistem tarafından hazırlanmış takım dizilişlerini kullanarak belirlenen bölümleri sınırsız sayıda deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken, takım dizilişindeki Uyandırıcılar üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_141466_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_141467_ActivityName = {
    Text = "Ayna Mahkûmu: Tekrar"
  },
  Activity_141467_ActivityPlot = {
    Text = "Kuş, ey kuş, neden kırık prangalar hâlâ ayaklarına yapışıp kalmış?\nKuş, ey kuş, neden uçsuz bucaksız, ıssız gökte tek başına şarkı söylersin?\nDikenleri yırtıp attın, kafesten kaçtın; kanatların sonsuz çölü kucakladı, yine de o yaslı şarkın hiç susmadı.\nÖzlediğin sadık yoldaş kim? Aradığın gerçek yuva nerede saklı?"
  },
  Activity_141467_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Bilgi Arzusu\"na katılınabilir."
  },
  Activity_141467_ActivityTips = {
    Text = "<Title:Etkinlik Tanıtımı>\n1, Etkinlik süresince, Koruyucular sınırlı süreli oynanış \"Gökyüzünde Süzülmek\", \"Düş Yolculuğu\" ve \"Başarı Ödülleri\" aracılığıyla etkinlik para birimi \"Genel Kültür Ders Kitabı\", \"Matematik Ders Kitabı\", \"Edebiyat Ders Kitabı\" toplayabilir; \"Genel Kültür Ders Kitabı\", \"Matematik Ders Kitabı\", \"Edebiyat Ders Kitabı\"\"Bilgi Susuzluğu\" mağazasında ürün satın almak için kullanılabilir; bu ürünler arasında etkinliğe özel SR Kader Çarkı \"Yalnız Tüy\", Işıltılı Çekirdek, Saf Çekirdek ve daha fazlası yer almaktadır.\n2, Etkinlik süresince, \"Düş Diyarı: Göklerin Ötesinde: Bölüm I\" sınırlı süreliğine ücretsiz açılır; etkinlik başarımlarını tamamlayarak etkinliğe özel avatar \"Gümüş Anahtarla: Castor\" elde edebilirsiniz!\n\n<Title:Etkinlik Süresi>\n1,10 Ekim 9:00 - 2 Kasım 9:00(GMT+8), tüm etkinlik oynanışlarına katılabilirsiniz.\n2,2 Kasım 9:00 - 9 Kasım 9:00(GMT+8), yalnızca \"Bilgi Susuzluğu\" ve Başarı Ödülleri'ne katılabilirsiniz.\n\n<Title:Gökyüzünde Süzülmek>\n1,\"Gökyüzünde Süzülmek\" 7 sahne içerir; her 1 günde 1 sahne otomatik olarak açılır.\n2, Her meydan okuma \"Menofin\" × 120 tüketir; meydan okumayı başarıyla tamamlamak etkinlik para birimi kazandırır.\n3, Sahneyi temizledikten sonra o sahnenin \"Yeniden Canlandırma\"özelliği açılır. Lütfen dikkat: \"Yeniden Canlandırma\"özelliği kullanılırken Afinite kazanılamaz.\n4, Geçişi daha kolay tamamlamak için mezunlar derneği Destek'ini kullanabilirsiniz.\n\n<Title: Bilgi Susuzluğu>\n\"Bilgi Susuzluğu\" nun üç mağazası bulunmaktadır; açılış saatleri aşağıdaki gibidir:\n·\"Genel Seçmeli\": 5 Ekim saat 9'da açılır.\n·\"Fen Seçmeli Dersi\": 6 Ekim saat 9'da açılır.\n·\"Edebiyat Seçmeli Dersi\": 7 Ekim saat 9'da açılır.\nMağazada ürünleri seçerek doğrudan satın alabilirsiniz.\n\n<Title:Etkinlik Bonusu>\n1, Koruyucuların belirli Uyandırıcılara veya Kader Çarklarına sahip olması(sahaya sürülmesi gerekmez) \"Gökyüzünde Süzülmek\" sahne görevi ödüllerindeki \"Genel Kültür Ders Kitabı\", \"Matematik Ders Kitabı\", \"Edebiyat Ders Kitabı\" için ekstra düşme bonusu sağlar; ayrıntılı bonuslar aşağıdaki gibidir:\n·Uyandırıcı \"Castor\": Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\n·SSR Kader Çarkı \"Dayanılmaz Özgürlük\": Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\n·SR Kader Çarkı \"Yalnız Tüy\": Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\n2, Farklı Uyandırıcı veya Kader Çarklarının \"Etkinlik Bonusu\" birikimli olarak hesaplanır.\n3,Özellikle, Delilik Zorluğu ilk geçiş meydan okuma ödülleri \"Etkinlik Bonusu\" ndan etkilenmez.\n\n<Title: Düş Yolculuğu>\n1, Her saat otomatik olarak 60 \"Genel Kültür Ders Kitabı\" kazanılır; en fazla 25 saat depolanabilir.\n\n<Title:Düş Diyarı>\n1, Etkinlik süresince, \"Düş Diyarı: Göklerin Ötesinde: Bölüm I\"ücretsiz olarak açılabilir.\n2, Etkinlik sona erdikten sonra, \"Düş Diyarı: Göklerin Ötesinde: Bölüm I\" nin soruşturma ilerlemesi korunur; etkinlik süresince tamamlanmayan Soruşturma Olaylarını tamamladıktan sonra da etkinlik süresindekiyle aynı soruşturma ödülleri alınabilir. Etkinlik süresince \"Düş Diyarı: Göklerin Ötesinde: Bölüm I\" açılmadıysa, etkinlik sona erdikten sonra \"Gerçeklik Başlangıç Noktası\" ×7 harcayarak açılabilir.\n3, Etkinlik süresinde olsun ya da olmasın, \"Düş Diyarı: Göklerin Ötesinde: Bölüm I\" ni temizledikten sonra \"Müfreze: Kaderin Alayı\" elde edilebilir."
  },
  Activity_141467_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_141509_ActivityName = {
    Text = "Gizli Diyar Seyahati"
  },
  Activity_141509_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n1, Koruyucular belirtilen arşiv görevlerini tamamladıktan sonra \"Gizli Diyar Seyahati\" nden ödülleri alabilir.\n2,\"Gizli Diyar Seyahati\" 27 Temmuz 09:00'da sona erecektir.\n3,\"Premium Arşivler\" açıldıktan sonra, görevleri tamamlayarak ek ödüller alınabilir.\n4, Lütfen dikkat: Bu etkinlikte açılan \"Premium Arşivler\" yalnızca bu etkinlik için geçerlidir. Koruyucular harcamalarını dikkatli ve bilinçli şekilde yapmalıdır."
  },
  Activity_141509_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_141533_ActivityName = {
    Text = "Ebwynnos Evermore"
  },
  Activity_141533_ActivityPlot = {
    Text = "Yüksek sesle gülelim, geceyi kutlamayla geçirelim.\nPençelerimiz düşmanın boğazına saplanırken, sıradan zamanlar derin yarıklarda paslanıp gitsin.\nArtık hiçbir zaman yaşlılık, sıradanlık ve yalnızlık bizi yakalayamayacak.\nBurası Ebwynnos; biz sonsuza dek mutluyuz, sonsuza dek bir aradayız.\nHiç ayrılmayacağız."
  },
  Activity_141533_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi, şu anda yalnızca \"Av Alanları\" kullanılabilir."
  },
  Activity_141533_ActivityTips = {
    Text = "<Title:Etkinlik Tanıtımı>\n1, Etkinlik süresince, Koruyucular sınırlı süreli oynanış \"Yüksek Ev Avı\" ve \"Başarı Ödülleri\" aracılığıyla etkinlik para birimleri \"Taze\" Av \"\", \"Devasa\" Av \"\" ve \"İlksel\" Av \"\" toplayabilir; \"Av Alanları\" nda etkinliğe özel sınırlı SR Kader Çarkı \"Başıboş Pusula\", Işıltılı Çekirdek, Saf Çekirdek ve daha fazlasını içeren ürünlerle takas yapabilirler.\n2, Etkinlik süresince, \"Gezinti: Ebwynnos Evermore\" sınırlı süreliğine ücretsiz açılıyor; etkinlik başarımlarını tamamlayarak etkinliğe özel avatar \"Gümüş Anahtarla: Pontos\" u da kazanabilirsiniz!\n\n<Title:Etkinlik Süresi>\n1,29 Haziran 09:00 - 27 Temmuz 09:00(GMT+8), tüm etkinlik oynanışlarına katılabilirsiniz.\n2,27 Temmuz 09:00 - 3 Ağustos 09:00(GMT+8), yalnızca \"Av Alanları\" ve Başarı Ödüllerine katılabilirsiniz.\n\n<Title:Yüksek Ev Avı>\n1,\"Yüksek Ev Avı\" 7 sahne içermekte olup her gün otomatik olarak 1 sahne açılır.\n2, Her meydan okuma \"Menofin\" × 120 tüketir; meydan okumayı başarıyla tamamlamak etkinlik para birimi kazandırır.\n3, Sahneyi temizledikten sonra o sahnenin \"Yeniden Canlandırma\"özelliği açılır. Lütfen dikkat: \"Yeniden Canlandırma\"özelliği kullanılırken Afinite kazanılamaz.\n4, Sahneleri daha kolay geçmek için mezun birliği Desteğini kullanabilirsiniz.\n\n<Title: Av Alanları>\n\"Av Alanları\" nda üç mağaza bulunmakta olup açılış süreleri aşağıdaki gibidir:\n·\"Soğuk Demir\": 29 Haziran saat 9'da açılır.\n·\"Ateş ve Kükürt\": 30 Haziran saat 9'da açılır.\n·\"Büyücülük\": 1 Temmuz saat 9'da açılır.\nMağazada ürünleri seçerek doğrudan satın alabilirsiniz.\n\n<Title:Etkinlik Bonusu>\n1, Koruyucuların belirli Uyandırıcılara veya Kader Çarklarına sahip olması(savaşa dahil edilmesi gerekmez), \"Yüksek Ev Avı\" sahne görevi ödüllerindeki üç tür etkinlik para biriminin düşüşüne ek bonus sağlar:\n·Uyandırıcı \"Pontos\": Aydınlanma 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus.\n·SSR Kader Çarkı \"Canlı Kafes\": Yükseliş 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus.\n·SR Kader Çarkı \"Başıboş Pusula\": Yükseliş 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus.\n2, Farklı Uyandırıcı veya Kader Çarklarının \"Etkinlik Bonusları\" birikimli olarak hesaplanır.\n3,Özellikle, Delilik Zorluğu ilk tamamlama ödülleri \"Etkinlik Bonusu\" ndan etkilenmez.\n\n<Title:Gezinti>\n1, Etkinlik süresince, \"Gezinti: Ebwynnos Evermore\"ücretsiz olarak açılabilir.\n2, Etkinlik sona erdikten sonra, soruşturma ilerlemesi korunacaktır; etkinlik süresince tamamlanmayan Soruşturma Olayları etkinlik sonrasında da tamamlanarak ilgili ödüller kazanılabilir. Etkinlik süresince açılmamışsa, etkinlik bittikten sonra \"Gerçeklik Başlangıç Noktası\" × 3 tüketerek açmak hâlâ mümkündür.\n3, Etkinlik süresinde olsun ya da olmasın, \"Gezinti: Ebwynnos Evermore\" u temizledikten sonra \"Müfreze: Boş Olan\" elde edilebilir."
  },
  Activity_141533_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_141534_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_141535_ActivityName = {
    Text = "Kara Güneş Altında Yaz: Tekrar"
  },
  Activity_141535_ActivityPlot = {
    Text = "Yaz, deniz kıyısı, parlak güneş ve birçok tanıdık yüz.\nKara güneşin aydınlığında her şeyi unut, tüm fantezileri gerçekleştiren bu karnaval rüyasında boğul."
  },
  Activity_141535_ActivityTips = {
    Text = "<Title:Etkinlik Tanıtımı>\n1, Etkinlik süresince, \"Düş Diyarı: Varolmayan Ülkede Görüşürüz\" sınırlı süreliğine ücretsiz açılıyor!\n2, Etkinlik süresince toplam 7 gün giriş yaparak \"Yaz Şenliği\" nde \"Işıltılı Çekirdek\" × 10 kazanabilirsiniz; 7. gün ek olarak sınırlı savaş avatarı \"Voleybol 'Generali'\" elde edilebilir.\n\n<Title:Etkinlik Süresi>\n1,6 Temmuz 09:00 - 20 Temmuz 09:00(GMT+8), tüm etkinliklere katılabilirsiniz.\n\n<Title:Düş Diyarı>\n1, Etkinlik süresince, \"Düş Diyarı: Varolmayan Ülkede Görüşürüz\"ücretsiz olarak açılabilir.\n2, Etkinlik sona erdikten sonra, \"Düş Diyarı: Varolmayan Ülkede Görüşürüz\"ün soruşturma ilerlemesi korunacaktır; etkinlik süresince tamamlanmayan Soruşturma Olayları etkinlik sonrasında da tamamlanarak aynı soruşturma ödülleri kazanılabilir. Etkinlik süresince açılmamışsa, etkinlik bittikten sonra \"Gerçeklik Başlangıç Noktası\" × 7 tüketerek açmak hâlâ mümkündür.\n3, Etkinlik süresinde olsun ya da olmasın, \"Düş Diyarı: Varolmayan Ülkede Görüşürüz\"ü temizledikten sonra \"Müfreze: Sahil Hatırası\" elde edilebilir."
  },
  Activity_141535_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_141536_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_142866_ActivityName = {
    Text = "Lemurya Deipara'sı"
  },
  Activity_142866_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Lemurya Deipara'sı\" etkinliği süresince Koruyucular, \"Murphy: Sahte Doğumlu\"yu içeren sistem tarafından önceden ayarlanmış takım dizilişlerini kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\n Etkinlik aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nAşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_142867_ActivityName = {
    Text = "Kafatası Avcısı Cadı"
  },
  Activity_142867_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Kafatası Avcısı Cadı\" etkinliği süresince, Koruyucular Nergis'i içeren sistem tarafından hazırlanmış takımları kullanarak belirlenen bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken, takım kadrosundaki Uyandırıcılarda değişiklik yapılmasına izin verilmez.\n<Title:Etkinlik Ödülleri>\nBölüm mücadelesini ilk kez başarıyla tamamladıktan sonra, oyuncular etkinlik arayüzünden deneme ödüllerini alabilir."
  },
  Activity_143933_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_144359_ActivityName = {
    Text = "Her Şeye Tanık"
  },
  Activity_144359_ActivityTips = {
    Text = "<Title:Etkinliğe Genel Bakış>\n1. Belirlenen Arşivler görevlerini tamamladıktan sonra, Koruyucular \"Her Şeye Tanık\"ta ödülleri talep edebilir.\n2. \"Her Şeye Tanık\" 24 Ağustos saat 09:00'da sona erecektir.\n3. Görevleri tamamladığınızda ekstra ödüller talep etmek için \"Premium Arşivler\"i açın.\n4. Lütfen dikkat: Bu etkinlikte açılan \"Premium Arşivler\" yalnızca bu etkinlik için geçerlidir. Koruyucular, lütfen makul şekilde tüketin."
  },
  Activity_144359_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_145382_ActivityName = {
    Text = "Balina Düşüşü"
  },
  Activity_145382_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Balina Düşüşü\" etkinliği süresince, Koruyucular \"Lotan: Cetarchon\" içeren sistem tarafından önceden ayarlanmış kadroları kullanarak belirlenen aşamaları sınırsız sayıda deneyimleyebilir.\n Etkinlik aşamalarını deneyimlerken kadrodaki Uyandırıcılar ayarlanamaz.\n<Title:Etkinlik Ödülleri>\nAşama meydan okumasını ilk kez tamamladıktan sonra, etkinlik arayüzünde deneme ödüllerini talep edebilirsiniz."
  },
  Activity_145383_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_145383_ActivityPlot = {
    Text = "Satın alımın ardından, \"Lotan: Cetarchon\" <BlueQuality:Aydınlanma 3>'ü etkinleştirebilir"
  },
  Activity_145384_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_145384_ActivityPlot = {
    Text = "Satın alımın ardından, \"Lotan: Cetarchon\" şunları etkinleştirebilir:\n<BlueQuality:Ruh Dalgası +4, Aşırı Yüceltme'nin Kilidi Açılır>"
  },
  Activity_145458_ActivityName = {
    Text = "Leviathan'ın Oyunu"
  },
  Activity_145458_ActivityPlot = {
    Text = "Açgözlü kahramanlar ölümsüz tahtlar arzular, çaresiz anneler diriltilmiş çocuklar arar, deli büyücüler yasak bilgiye susar—hepsi O'nun önünde diz çöker, on bin yılı aşkın süredir duyduğu aynı sözlerle yalvarır.\nO, hepsine her şeyi verir; yalnızca her şeylerini kaybettiklerini izlemek için. Dört bin acımasız yarışmaya tanıklık etmiştir, yine de doyumsuz kalır.\nBu sefer arenанın kapıları senin için açılıyor. Gel, O'na söyle—ne arzu ediyorsun?\nO'na, o dört bin düşmüş ruhtan nasıl farklı olduğunu anlat."
  },
  Activity_145458_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Geçici Metin\" kullanılabilir."
  },
  Activity_145458_ActivityTips = {
    Text = "<Title:Etkinliğe Genel Bakış>\nEtkinlik süresince, Koruyucular sınırlı süreli oyun modu \"Açgözlülük ve Kan Hırsı\" ve \"Başarımlar\" aracılığıyla etkinlik para birimi \"Kızıl Adak\" toplayabilir. \"Kızıl Adak\", \"Arena Sunağı\"nda ödüllerle değiştirilebilir; bu ödüller arasında özel SR Kader Çarkı \"Ölümsüz Açlık Kemiği\", Işıltılı Çekirdek, Saf Çekirdek, Eterik Parça, Mimetik Kristal ve daha fazlası yer almaktadır.\n\n<Title:Açgözlülük ve Kan Hırsı>\n1. \"Açgözlülük ve Kan Hırsı\" 5 aşamadan oluşur ve her 2 günde bir aşama otomatik olarak açılır.\n2. Her meydan okuma 120 Menofin tüketir. Bir meydan okumayı başarıyla tamamlamak, etkinlik para birimi \"Kızıl Adak\" ödülü verir.\n3. Bir aşamayı temizledikten sonra, o aşama için \"Yeniden Canlandırma\" işlevi açılır. Lütfen dikkat: \"Yeniden Canlandırma\" işlevi kullanılırken Afinite elde edilemez.\n4. Aşamaları daha kolay temizlemek için Mezun Desteği'nden yararlanabilirsiniz.\n\n<Title:Etkinlik Bonusu>\n1. Belirli Uyandırıcılara veya Kader Çarklarına sahip Koruyucular (konuşlandırılmaları gerekmez), \"Açgözlülük ve Kan Hırsı\" aşama görevi ödüllerinde (Yeniden Canlandırma dahil) \"Kızıl Adak\" için ek düşürme bonusu kazanabilir. Belirli bonuslar aşağıdaki gibidir:\nUyandırıcı \"Lotan: Cetarchon\": Aydınlanma 0/1/2/3 veya üzeri, bonus %20/%30/%40/%50.\nSSR Kader Çarkı \"Cetus Occasus\": Yükseliş 0/1/2/3 veya üzeri, bonus %20/%30/%40/%50.\nSR Kader Çarkı \"Ölümsüz Açlık Kemiği\": Yükseliş 0/1/2/3 veya üzeri, bonus %20/%30/%40/%50.\n2. Farklı Uyandırıcılardan veya Kader Çarklarından gelen \"Etkinlik Bonusları\" kümülatif olarak hesaplanır.\n3. Özellikle, Delilik Zorluğu meydan okumalarının ilk temizleme ödülleri yukarıdaki bonuslardan etkilenmez.\n\n<Title:Gezinti>\n1. Etkinlik süresince, \"Gezinti: Cetus Düşene Dek\" ücretsiz olarak açılabilir.\n2. Etkinlik sona erdikten sonra, \"Gezinti: Cetus Düşene Dek\" soruşturma ilerlemesi korunacaktır. Etkinlik süresince tamamlanmamış Soruşturma Olaylarını tamamlamak, etkinlik dönemindekiyle aynı soruşturma ödüllerini vermeye devam edecektir. Etkinlik süresince \"Gezinti: Cetus Düşene Dek\" açılmadıysa, etkinlik bittikten sonra \"Gerçeklik Başlangıç Noktası\" ×3 harcayarak açılabilir.\n3. Etkinlik döneminde olsun ya da olmasın, \"Gezinti: Cetus Düşene Dek\"i temizlemek \"Müfreze: Cetus'u Yutan Fırtına\" ödülü verecektir.\n\n<Title:Etkinlik Süresi>\n1. 27 Temmuz, 09:00 - 24 Ağustos, 09:00 (GMT+8): Etkinliğe Genel Bakış'taki tüm içerikler kullanılabilir.\n2. 24 Ağustos, 09:00 - 31 Ağustos, 09:00 (GMT+8): Yalnızca \"Arena Sunağı\" ve \"Başarı Ödülleri\" kullanılabilir; diğer tüm içerikler sona ermiş ve artık erişilemez durumdadır.\n3. 31 Ağustos, 09:00 (GMT+8) sonrasında, değiştirilmemiş kalan \"Kızıl Adak\" birim başına 40 Altın Gül oranında dönüştürülecektir. Lütfen postanızı kontrol edin, Koruyucular."
  },
  Activity_145458_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_145459_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_145465_ActivityName = {
    Text = "Hayat Her Zamanki Gibi Olsaydı: Tekrar"
  },
  Activity_145465_ActivityPlot = {
    Text = "Hiç felaket hiç yaşanmamış olsaydı, herkesin hayatının nasıl olacağını hayal ettin mi?\nDünyayı kurtarma gücünün kullanılacak bir yeri yok; her gününü sıradan bir kampüs hayatı ve üç beş kuruşluk kredi kazanma telaşıyla tüketiyorsun. Oyun alanı artık savaş eğitimi alan siluetlerle dolu değil; onun yerine kulüp etkinlikleri için kurulmuş sıra sıra bez çadırlar, üye toplama sesleri ve neşeli çığlıklar var. Okul zili çaldığında, aç öğrenciler anında yemekhaneyi dolduruyor...\nEğer değer verdiklerinin kapısını çalsan, seni nasıl gülümseyen yüzler karşılar?"
  },
  Activity_145465_ActivityStageEndContent = {
    Text = "\"Her Şey Eskisi Gibiyse\" Etkinliği sona erdi. Şu anda yalnızca \"Öğrenci Konseyi Binası\"na katılım Alınabilir."
  },
  Activity_145465_ActivityTips = {
    Text = "<Title:Etkinliğe Genel Bakış>\n1. Etkinlik süresince, sınırlı süreli oyun modu \"Güneşin Altında Yeni Şey\" aracılığıyla etkinlik para birimi \"Sahil Kabukları\" toplayabilirsiniz. \"Sahil Kabukları\"nı \"Öğrenci Birliği Binası\"nda Işıltılı Çekirdek, Saf Çekirdek, Eterik Parça ve daha fazlasını satın almak için kullanabilirsiniz.\n2. Etkinlik süresince, \"Düş Diyarı: Hoşça Kal, Varolmayan Ülke\" sınırlı süreli ücretsiz erişime açık olacak!\n\n<Title:Etkinlik Süresi>\n1. 3 Ağustos, 09:00 - 17 Ağustos, 09:00 (GMT+8): Tüm etkinlik oyun modları kullanılabilir.\n2. 17 Ağustos, 09:00 - 24 Ağustos, 09:00 (GMT+8): Yalnızca \"Öğrenci Birliği Binası\"na katılabilir ve Başarı Ödüllerini talep edebilirsiniz.\n\n<Title:Güneşin Altında Yeni Şey>\n1. \"Güneşin Altında Yeni Şey\" 5 bölümden oluşur ve her 2 günde bir bölüm otomatik olarak açılır.\n2. Her meydan okuma 120 Menofin tüketir ve başarılı meydan okumalar size etkinlik para birimi kazandırır.\n3. Bir bölümü tamamladıktan sonra, o bölüm için \"Yeniden Canlandırma\" özelliği açılır. Not: \"Yeniden Canlandırma\" özelliğini kullandığınızda Afinite elde edemezsiniz.\n4. Bölümleri daha kolay geçmek için Mezunların yardımından faydalanabilirsiniz.<Title:Öğrenci Birliği Binası>\n\"Öğrenci Birliği Binası\"nda 3 Ağustos saat 09:00'da açılan bir mağaza bulunmaktadır.\nMağazada, doğrudan satın almak için ürünler seçebilirsiniz.\n\n<Title:Düş Diyarı>\n1. Etkinlik süresince, \"Düş Diyarı: Hoşça Kal, Varolmayan Ülke\"yi ücretsiz olarak açabilirsiniz.\n2. Etkinlik sona erdikten sonra, \"Düş Diyarı: Hoşça Kal, Varolmayan Ülke\" için soruşturma ilerlemeniz korunacaktır. Etkinlik döneminde tamamlanmamış soruşturma olaylarını tamamlamak, etkinlik dönemindekiyle tutarlı soruşturma ödülleri kazandırmaya devam edecektir. Etkinlik süresince \"Düş Diyarı: Hoşça Kal, Varolmayan Ülke\"yi açmadıysanız, etkinlik bittikten sonra \"Gerçeklik Başlangıç Noktası\" *7 harcayarak açabilirsiniz.\n3. Etkinlik döneminde olsun ya da olmasın, \"Düş Diyarı: Hoşça Kal, Varolmayan Ülke\"yi tamamlamak size \"Müfreze: Geçici Bir Rüya\" kazandıracaktır."
  },
  Activity_145465_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_145466_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_145717_ActivityName = {
    Text = "Yeni Ay ve Derin Kar"
  },
  Activity_145717_ActivityPlot = {
    Text = "Yedili ibadet ayini, üçlü kutsal yemin—saf beyaz periye derin bir imanla sarılarak gökyüzü ile karın buluştuğu yere tırman, o da her dileğini yerine getirecektir. Her birini. Her ruhun bir amacı vardır ve her amacın altında kendi yalanı yatar. Onları kazı. Gün yüzüne çıkar... onun anlatısının kusursuz yüzeyine teslim olmadan önce. Bu derin kara, onun yanında batma."
  },
  Activity_145717_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Peri'nin Ritüelleri\" kullanılabilir."
  },
  Activity_145717_ActivityTips = {
    Text = "<Title:Etkinliğe Genel Bakış>\n1. Etkinlik süresince Koruyucular, sınırlı süreli oyun içerikleri \"Umapati'nin Hazineleri\" ve \"Başarımlar\" aracılığıyla etkinlik para birimleri \"Kızıl Elma\", \"Altın Elma\" ve \"Şekerli Elma\" toplayabilir; bunları \"Peri Töreni\"nde mal karşılığında değiştirebilir. Bu ödüller arasında özel SR Kader Çarkı \"Dingin Hakikat\", Işıltılı Çekirdek, Saf Çekirdek ve daha fazlası yer almaktadır.\n2. Etkinlik süresince etkinlik başarımlarını tamamlamak, özel avatar \"Gümüş Anahtarla: Caraboo\"yu da kazandırır!\n\n<Title:Etkinlik Süresi>\n1. 24 Ağustos 09:00 - 21 Eylül 09:00 (GMT+8): Tüm etkinlik içerikleri kullanılabilir.\n2. 21 Eylül 09:00 - 28 Eylül 09:00 (GMT+8): Yalnızca \"Peri'nin Ritüelleri\" ve başarım ödülleri kullanılabilir.\n<Title:Umapati'nin Hazineleri>\n1. \"Umapati'nin Hazineleri\" 7 bölüm içerir; her gün 1 bölüm otomatik olarak açılır.\n2. Her meydan okuma 120 Menofin tüketir. Meydan okumayı başarıyla tamamlamak etkinlik para birimi kazandırır.\n3. Bir bölümü temizledikten sonra o bölüm için \"Yeniden Canlandırma\" işlevi açılır. Lütfen dikkat: \"Yeniden Canlandırma\" işlevi kullanılırken Afinite elde edilemez.\n4. Bölümleri daha kolay temizlemek için Mezun Desteği'nden yararlanabilirsiniz.\n\n<Title: Peri'nin Ritüelleri>\n1. \"Peri'nin Ritüelleri\"nin üç dükkanı vardır; açılış saatleri aşağıdaki gibidir:\n\"Kar Bereketi\": 24 Ağustos 09:00'da açılır.\n\"Ayaz Bereketi\": 25 Ağustos 09:00'da açılır.\n\"Beyaz Bereket\": 26 Ağustos 09:00'da açılır.\n2. Her \"Bereket Al\" işlemi, \"Peri'nin Ritüelleri\"nden rastgele beş eşya ödülü elde etmek için 750 \"Kızıl Elma\"/\"Altın Elma\"/\"Şekerli Elma\" tüketir.\n3. Her \"Peri'nin Ritüelleri\"ndeki eşya ödülleri iki türe ayrılır: \"Özel Eşyalar\" ve \"Sıradan Eşyalar\". Sıfırlama sırasında Özel Eşya ödüllerinin kalan miktarı limite sıfırlanabilir. Belirli kurallar aşağıdaki gibidir:\n(1) İlk 2 Sıfırlama: \"Özel Eşyalar\"ın kalan miktarı kalmadığında, Koruyucular sıfırlamayı seçebilir; bu işlem hem \"Özel Eşyalar\" hem de \"Sıradan Eşyalar\"ın kalan miktarını limite sıfırlar. Ya da değiş tokuşa devam etmeyi seçebilirler. \"Sıradan Eşyalar\"ın da kalan miktarı kalmadığında, değiş tokuşa devam etmek için sıfırlama yapılması zorunludur.\n(2) 3. Sıfırlamadan İtibaren: Sıfırlama yalnızca \"Sıradan Eşyalar\"ın kalan miktarı kalmadığında yapılabilir. Sıfırlama, \"Sıradan Eşyalar\"ın kalan miktarını limite geri yükler; \"Özel Eşyalar\" artık sıfırlanmaz.\n\n<Title:Etkinlik Bonusu>\n1. Belirli Uyandırıcılara veya Kader Çarklarına sahip Koruyucular (konuşlandırılmış olmaları gerekmez), \"Umapati'nin Hazineleri\" bölüm görevi ödüllerinde üç etkinlik para birimi için de ek düşürme bonusu kazanabilir:\nUyandırıcı \"Caraboo\": Aydınlanma 0/1/2/3 veya üzeri, bonus %20/%30/%40/%50.\nSSR Kader Çarkı \"Ballı Aldatmaca\": Yükseliş 0/1/2/3 veya üzeri, bonus %20/%30/%40/%50.\nSR Kader Çarkı \"Dingin Hakikat\": Yükseliş 0/1/2/3 veya üzeri, bonus %20/%30/%40/%50.\n2. Birden fazla \"Etkinlik Bonusu\" üst üste eklenebilir ve birlikte hesaplanır.\n3. Lütfen dikkat: Delilik Zorluğu meydan okumalarının ilk temizleme ödülleri \"Etkinlik Bonusu\"ndan etkilenmez."
  },
  Activity_145717_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_146540_ActivityName = {
    Text = "Yankılanan Hac·Yıldız Hükümranlığı VI"
  },
  Activity_146540_ActivityPlot = {
    Text = "Yanılsama Hafıza mühürlenip arşivlendi, geçmişe kaydedilen bir yolculuk. Anımsama anlarında, saygılı Haracınızı sunmayı unutmayın."
  },
  Activity_146541_ActivityName = {
    Text = "Hyperborea Arşivleri"
  },
  Activity_146541_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Hyperborea Arşivleri'nde ödül almak için görevleri tamamlayın\n2. Hyperborea Arşivleri kalıcı olarak erişilebilir durumda kalır\n3. Görev tamamlandığında ekstra ödüller kazanmak için Premium Arşivler'i açın\nNot: Etkinleştirilen Premium Arşivler yalnızca bu Arşiv etkinliğinde geçerlidir."
  },
  Activity_146799_ActivityName = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_146799_ActivityPlot = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_146799_ActivityStageEndContent = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_146799_ActivityTips = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_146799_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_147423_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_147423_ActivityPlot = {
    Text = "Satın aldıktan sonra, \"Tinct: Vespera\" etkinleştirebilir: <BlueQuality:Aydınlanma 3>"
  },
  Activity_147424_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_147424_ActivityPlot = {
    Text = "Satın aldıktan sonra, \"Tinct: Vespera\" etkinleştirebilir:\n<BlueQuality:Kişilik Derinleşmesi +4, Aşırı Yüceltme kilidini açar>"
  },
  Activity_147425_ActivityName = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_147425_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Köken: Egemenlik\" etkinliği süresince Koruyucular, Köken: Egemenlik'i içeren sistem tarafından önceden belirlenmiş ekipleri kullanarak belirlenen seviyeleri sınırsız sayıda deneyimleyebilir.\nEtkinlik seviyelerini deneyimlerken ekip kadrosundaki Uyandırıcılar üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nSeviye meydan okumasını ilk kez tamamladıktan sonra etkinlik arayüzünde demo ödüllerini talep edebilirsiniz."
  },
  Activity_147426_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_148119_ActivityName = {
    Text = "Ders Dışı Zaman"
  },
  Activity_148119_ActivityTips = {
    Text = "<Title:Etkinliğe Genel Bakış>\n1. Belirlenen Arşiv görevlerini tamamladıktan sonra Koruyucular, \"Okul Sonrası Saatler\"de ödüllerini talep edebilir.\n2. \"Okul Sonrası Saatler\" 21 Eylül 09:00'da sona erecektir.\n3. Görevleri tamamladığınızda ekstra ödüller almak için \"Premium Arşivler\"i açın.\n4. Lütfen dikkat: Bu etkinlikte açılan \"Premium Arşivler\" yalnızca bu etkinlik için geçerlidir. Koruyucular, lütfen bilinçli bir şekilde tüketin."
  },
  Activity_148119_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_148889_ActivityName = {
    Text = "Köken Ogier"
  },
  Activity_148889_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n·\"Köken Ogier\" etkinliği süresince Koruyucular, Köken Ogier içeren sistem tarafından önceden ayarlanmış takımları kullanarak belirlenmiş Aşamaları sınırsız sayıda deneyimleyebilir.\n·Etkinlik Aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\n·Bir Aşama görevini ilk kez tamamladığınızda, deneme ödülleri etkinlik sayfasından talep edilebilir."
  },
  Activity_15788_ActivityName = {
    Text = "Simya Estetiği"
  },
  Activity_15788_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Simya Estetiği\" etkinliği süresince, Koruyucu \"Altın Gül Avı\"nı tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_15791_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_15791_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucu \"İksir Tavlama\"yı tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_15793_ActivityName = {
    Text = "Yağmur Kasabasının Hayaleti"
  },
  Activity_15793_ActivityPlot = {
    Text = "Her yağmurlu gece hayal kırıklığı ve yalnızlıkla birlikte gelir.\nKimi aşkını kaybeder, kimi onurunu.\nKimi de kafasını."
  },
  Activity_15793_ActivityTips = {
    Text = "<Title:Katılım Koşulları>\n\"Soruşturma Operasyonu\" 2-9 (Normal) tamamlanarak katılım sağlanabilir.\n<Title:Soruşturma Etkinliği>\nEtkinlik süresince, \"Yağmur Kasabası'nın Gölgeleri\" bölümünde her gün yeni bir soruşturma etkinliği başlatılacaktır. Koruyucular envanter harcamadan kilitleri açabilir ve soruşturma yapabilir. Soruşturma etkinliğini tamamladıktan sonra Saf Çekirdek, Soruşturma Rozeti ve Koruyucu Deneyimi gibi ödüller elde edilebilir.\nEtkinlik sona erdikten sonra \"Yağmur Kasabası'nın Gölgeleri\" soruşturma ilerlemesi korunacaktır. Koruyucular, Özel Operasyonlarda D-Mücevher harcayarak tamamlanmamış soruşturmaların kilidini açabilir. Etkinlik süresince tamamlanmamış soruşturma etkinliklerini tamamlamak da etkinlik sırasındakilerle tutarlı ödüller verecektir.<Title:Sınırlı Süreli Ödüller>\nEtkinlik süresince sınırlı süreli ödüller mevcut olacaktır. Koruyucular, \"Yağmur Kasabası'nın Gölgeleri\" (Normal mod) bölümünü tamamladıktan ve \"Yağmur Kasabası'nın Gölgeleri\" soruşturma etkinliklerini bitirdikten sonra Saf Çekirdek, Felsefe Taşı ve Gümüş elde edebilir! Sınırlı süreli ödüller yalnızca etkinlik süresince geçerlidir ve etkinlik sona erdikten sonra tamamlanamaz veya talep edilemez."
  },
  Activity_15793_UnlockConditionExplanation = {
    Text = "Ana Hikâye 2-9: Normal tamamlandıktan sonra açılır"
  },
  Activity_15797_ActivityName = {
    Text = "Uyuyan Hükümdar"
  },
  Activity_15797_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Uyuyan Hükümdar\" etkinliği süresince, Koruyucular Tulu içeren sistem tarafından hazırlanmış takımları kullanarak belirlenen bölümleri sınırsız sayıda deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken, takım dizilişindeki Uyandırıcılar üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra, oyuncular etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_15805_ActivityName = {
    Text = "Büyük Duman Arşivleri"
  },
  Activity_15805_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Büyük Duman Arşivleri'nde ödülleri talep etmek için görevleri tamamlayın\n2. Büyük Duman Arşivleri kalıcı olarak erişilebilir kalır\n3. Görev tamamlandığında ek ödüller kazanmak için Premium Arşivleri açın\nNot: Etkinleştirilen Premium Arşivler yalnızca bu Arşiv etkinliğinde geçerlidir."
  },
  Activity_15809_ActivityName = {
    Text = "Yıldız Tohumu (Süresi Dolmuş)"
  },
  Activity_15809_ActivityTips = {
    Text = "Etkinlik Kuralları:\nKoruyucu belirlenen görevleri tamamladıktan sonra ödüller \"Yıldız Filizi\"nden talep edilebilir."
  },
  Activity_15818_ActivityName = {
    Text = "Oymacı (Süresi Doldu)"
  },
  Activity_15818_ActivityTips = {
    Text = "Etkinlik Kuralları:\nKoruyucu belirlenen görevleri tamamladıktan sonra ödüller \"Heykeltıraş\" bölümünden talep edilebilir."
  },
  Activity_15821_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_15821_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_15825_ActivityName = {
    Text = "İsimsiz Şiir (Süresi Doldu)"
  },
  Activity_15825_ActivityTips = {
    Text = "Etkinlik Kuralları:\nKoruyucu belirlenen görevleri tamamladıktan sonra ödüller \"İsimsiz Şiir\" bölümünden talep edilebilir."
  },
  Activity_15828_ActivityName = {
    Text = "Giriş Töreni"
  },
  Activity_15828_ActivityTips = {
    Text = "\nEtkinlik Kuralları:\n1. Koruyucular, Koruyucu Seviyesi 5/15/25/35/45/55'e ulaştığında \"Giriş Töreni\"nden ödülleri toplayabilir.\n2. Koruyucu Deneyimi, ana hikâye ve ara bölüm aşamalarını tamamlayarak elde edilebilir."
  },
  Activity_20344_ActivityName = {
    Text = "Işıksız Karşılaşma"
  },
  Activity_20344_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Işıksız Karşılaşma'da ödüller almak için görevleri tamamlayın\n2. Işıksız Karşılaşma kalıcı olarak erişilebilir kalır"
  },
  Activity_20683_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_20683_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Aydınlatma Performansı\" etkinliği süresince, Koruyucu \"Kozmik Kalıntı\"yı tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_20684_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_20684_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucu \"Schwarzschild Boğazı\"nı tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_20685_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_20685_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Aydınlatma Performansı\" etkinliği süresince, Koruyucu \"Kanlı Kalıntı\"yı tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_20686_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_20686_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucu \"Pohnpei Harabeleri\"ni tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_20687_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_20687_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucu \"Kaos Kümesi\"ni tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_20688_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_20688_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucu \"Solucan Yuvası\"nı tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_20689_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_20689_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Aydınlatma Performansı\" etkinliği süresince, Koruyucu \"Uçurum Kalıntısı\"nı tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_20690_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_20690_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Aydınlatma Performansı\" etkinliği süresince, Koruyucu \"Kaotik Kalıntı\"yı tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_20691_ActivityName = {
    Text = "Kafatası Avcısı Cadı"
  },
  Activity_20691_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Kafatası Avcısı Cadı\" etkinliği süresince, Koruyucular Nergis'i içeren sistem tarafından hazırlanmış takımları kullanarak belirlenen bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken, takım kadrosundaki Uyandırıcılarda değişiklik yapılmasına izin verilmez.\n<Title:Etkinlik Ödülleri>\nBölüm mücadelesini ilk kez başarıyla tamamladıktan sonra, oyuncular etkinlik arayüzünden deneme ödüllerini alabilir."
  },
  Activity_21502_ActivityName = {
    Text = "Denizin Havarisi"
  },
  Activity_21502_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Denizin Havarisi\" etkinliği süresince Koruyucular, Miryam'ı içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_21781_ActivityName = {
    Text = "Yardım Seçimi"
  },
  Activity_21781_ActivityPlot = {
    Text = "Görevleri tamamlayın, 1 SSR \"Diyar Çalışması\" Uyandırıcı veya \"Dönüşüm Yönü\" Kader Çarkı talep edin!"
  },
  Activity_21781_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. 50 Uyanış biriktirmek, 3 gün giriş yapmak ve 7 gün giriş yapmak \"İlk Cennet\" ödülleri verecektir. \"İlk Cennet\", \"Malzemeler: Sarf Malzemeleri\" bölümünde kullanılabilir. Kullanıldığında, \"Diyar Çalışması\"ndan 1 belirli Uyandırıcı seçerek Uyandırma yapabilirsiniz.\n2. 300 Uyanış, 1000 Uyanış biriktirmek ve 30 gün giriş yapmak \"Dönüşüm Kitabı\" ödülleri verecektir. \"Dönüşüm Kitabı\", \"Malzemeler: Sarf Malzemeleri\" bölümünde kullanılabilir. Kullanıldığında, \"Dönüşüm Çarkları\"ndan 1 belirli Kader Çarkı seçerek elde edebilirsiniz."
  },
  Activity_22367_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_22367_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucular \"İksir İşleme\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23671_ActivityName = {
    Text = "Derin Dalış Düellosu"
  },
  Activity_23671_ActivityPlot = {
    Text = "Etkinlik süresince, Koruyucunun \"Hayali Dalış\" ve \"Traphase\" aracılığıyla kazandığı Koruyucu Deneyimi iki katına çıkar ve günlük üst sınır 480 puana yükseltilir."
  },
  Activity_23671_ActivityTips = {
    Text = "\nEtkinlik Kuralları:\n1. \"Hayali Dalış ve Traphase\" etkinliği süresince, Koruyucu \"Hayali Dalış\" ve \"Traphase\" aracılığıyla iki katı Koruyucu Deneyimi kazanır ve günlük üst sınır 480 puana yükseltilir. Çekirdek konu da açılmışsa, bu yoldan kazanılan Koruyucu Deneyimi tekrar iki katına çıkar ve günlük üst sınır 480 puanda kalır.\n2. Gün içinde kullanılmayan çift Koruyucu Deneyimi ertesi gün sabah 9:00'da (GMT+8) sıfırlanır, bu yüzden zamanında kullanmayı unutma, Koruyucu~"
  },
  Activity_23693_ActivityName = {
    Text = "Solgun Torun"
  },
  Activity_23693_ActivityPlot = {
    Text = "Efsaneye göre Londinium'un altında tek bir Kapı bulunur.\nKül Hanımefendisi'nin diyarına açılır…"
  },
  Activity_23693_ActivityTips = {
    Text = "<Title:Katılım Koşulları>\n\"Şövalyenin Dileği\" bilinç gezintisinin normal modunu tamamladıktan sonra katılım sağlanabilir.\n<Title:Soruşturma Etkinlikleri>\nEtkinlik süresince, \"Solgun Torun\" bölümünde her gün yeni bir soruşturma etkinliği başlatılacaktır. Koruyucular envanter harcamadan kilitleri açabilir ve soruşturma yapabilir; soruşturma etkinliklerini tamamlamak Saf Çekirdek, Soruşturma Rozeti ve Koruyucu Deneyimi gibi ödüller kazandıracaktır.\nEtkinlik sona erdikten sonra \"Solgun Torun\" soruşturma ilerlemesi korunacaktır. Koruyucular, bilinç gezintisinde D-Mücevher harcayarak kilitli soruşturmaların kilidini açabilir ve etkinlik süresince tamamlanmamış soruşturma etkinliklerini tamamlamak da etkinlik sırasındakilerle tutarlı soruşturma ödülleri verecektir.<Title:Sınırlı Süreli Ödüller>\nEtkinlik süresince sınırlı süreli ödüller mevcut olacaktır. Koruyucular, \"Solgun Torun\" normal modunu tamamladıktan ve soruşturma etkinliklerini bitirdikten sonra Karanlık Kilit ve Gümüş ödüllerini alabilir! Sınırlı süreli ödüller yalnızca etkinlik süresince geçerlidir ve etkinlik sona erdikten sonra tamamlanamaz veya talep edilemez."
  },
  Activity_23693_UnlockConditionExplanation = {
    Text = "Kilidi açmak için \"Şövalyenin Dileği\" Gezintisini tamamlayın"
  },
  Activity_23723_ActivityName = {
    Text = "Fırtına Yaklaşıyor"
  },
  Activity_23723_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Etkinlik süresince Operasyon Bölüm 5 geçici olarak kapatılmıştır. Müfreze \"Ebedi Saplantı\", Operasyon Bölüm 4'ü tamamlayarak geçici olarak elde edilebilir.\n2. Etkinlik sona erdikten sonra Operasyon Bölüm 5 yeniden açılacak ve Müfreze \"Ebedi Saplantı\" yine Operasyon Bölüm 5'i tamamlamayı gerektirecektir.\n3. Ayrıca, daha önce kazanılmış tüm Bölüm 5 Başarı Ödülleri, Aşama Başarıları, keşif ödülleri ve Tamamlama Ödülleri korunacaktır. Yeniden açıldığında (şu anda 27 Aralık olarak planlanmaktadır), ilgili tamamlanmış ilerleme mümkün olduğunca aktarılacaktır, bu yüzden tekrar yapmanıza gerek yoktur."
  },
  Activity_23870_ActivityName = {
    Text = "Traphase Çıkarımı"
  },
  Activity_23870_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Etkinlik süresince, ödüller almak için etkinlik görevlerini tamamlayın.\n2. Etkinlik sona erdikten sonra, talep edilmemiş etkinlik ödülleri artık alınamaz. Koruyucular, lütfen ödüllerinizi zamanında almayı unutmayın~"
  },
  Activity_23936_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23936_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Abissal Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23937_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23937_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Kaos Kümesi\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 malzeme ödülü kazanır (Koruyucu Deneyimi ve Altın Gül hariç), günlük sınır yoktur."
  },
  Activity_23938_ActivityName = {
    Text = "Derin Dalış Düellosu"
  },
  Activity_23938_ActivityPlot = {
    Text = "Etkinlik süresince, Koruyucunun \"Hayali Dalış\" ve \"Traphase\" aracılığıyla kazandığı Koruyucu Deneyimi iki katına çıkar ve günlük üst sınır 480 puana yükseltilir."
  },
  Activity_23938_ActivityTips = {
    Text = "\nEtkinlik Kuralları:\n1. \"Hayali Dalış ve Traphase\" etkinliği süresince, Koruyucu \"Hayali Dalış\" ve \"Traphase\" aracılığıyla iki katı Koruyucu Deneyimi kazanır ve günlük üst sınır 480 puana yükseltilir. Çekirdek konu da açılmışsa, bu yoldan kazanılan Koruyucu Deneyimi tekrar iki katına çıkar ve günlük üst sınır 480 puanda kalır.\n2. Gün içinde kullanılmayan çift Koruyucu Deneyimi ertesi gün sabah 9:00'da (GMT+8) sıfırlanır, bu yüzden zamanında kullanmayı unutma, Koruyucu~"
  },
  Activity_23939_ActivityName = {
    Text = "Derin Dalış Düellosu"
  },
  Activity_23939_ActivityPlot = {
    Text = "Etkinlik süresince, Koruyucunun \"Hayali Dalış\" ve \"Traphase\" aracılığıyla kazandığı Koruyucu Deneyimi iki katına çıkar ve günlük üst sınır 480 puana yükseltilir."
  },
  Activity_23939_ActivityTips = {
    Text = "\nEtkinlik Kuralları:\n1. \"Hayali Dalış ve Traphase\" etkinliği süresince, Koruyucu \"Hayali Dalış\" ve \"Traphase\" aracılığıyla iki katı Koruyucu Deneyimi kazanır ve günlük üst sınır 480 puana yükseltilir. Çekirdek konu da açılmışsa, bu yoldan kazanılan Koruyucu Deneyimi tekrar iki katına çıkar ve günlük üst sınır 480 puanda kalır.\n2. Gün içinde kullanılmayan çift Koruyucu Deneyimi ertesi gün sabah 9:00'da (GMT+8) sıfırlanır, bu yüzden zamanında kullanmayı unutma, Koruyucu~"
  },
  Activity_23940_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_23940_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucu \"İksir Tavlama\"yı tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_23941_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23941_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Schwarzschild Boğazı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 malzeme ödülü kazanır (Koruyucu Deneyimi ve Altın Gül hariç), günlük sınır yoktur."
  },
  Activity_23942_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23942_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucu \"Solucan Yuvası\"nı tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_23943_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23943_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Edify Performance\" etkinliği süresince, Koruyucular \"Kozmik Kalıntı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23944_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23944_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kanlı Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23945_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23945_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Aydınlatma Performansı\" etkinliği süresince, Koruyucu \"Kaotik Kalıntı\"yı tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_23946_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23946_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Edify Performance\" etkinliği süresince, Koruyucular \"Kozmik Kalıntı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23947_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23947_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Pohnpei Harabeleri\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23948_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23948_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Kaos Kümesi\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23949_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23949_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kaotik Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23950_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23950_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Abissal Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23951_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23951_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Kaos Kümesi\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23953_ActivityName = {
    Text = "Derin Dalış Düellosu"
  },
  Activity_23953_ActivityPlot = {
    Text = "Etkinlik süresince, Koruyucunun \"Hayali Dalış\" ve \"Traphase\" aracılığıyla kazandığı Koruyucu Deneyimi iki katına çıkar ve günlük üst sınır 480 puana yükseltilir."
  },
  Activity_23953_ActivityTips = {
    Text = "\nEtkinlik Kuralları:\n1. \"Hayali Dalış ve Traphase\" etkinliği süresince, Koruyucu \"Hayali Dalış\" ve \"Traphase\" aracılığıyla iki katı Koruyucu Deneyimi kazanır ve günlük üst sınır 480 puana yükseltilir. Çekirdek konu da açılmışsa, bu yoldan kazanılan Koruyucu Deneyimi tekrar iki katına çıkar ve günlük üst sınır 480 puanda kalır.\n2. Gün içinde kullanılmayan çift Koruyucu Deneyimi ertesi gün sabah 9:00'da (GMT+8) sıfırlanır, bu yüzden zamanında kullanmayı unutma, Koruyucu~"
  },
  Activity_23954_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23954_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Kaos Kümesi\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23955_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23955_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Abissal Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 malzeme ödülü kazanır (Koruyucu Deneyimi ve Altın Gül hariç), günlük sınır yoktur."
  },
  Activity_23956_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23956_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Pohnpei Harabeleri\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23957_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_23957_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucular \"İksir İşleme\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23958_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23958_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kanlı Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23959_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23959_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Schwarzschild Boğazı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23960_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23960_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Pohnpei Harabeleri\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23961_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23961_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Kaos Kümesi\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23962_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_23962_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucular \"İksir İşleme\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23963_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23963_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Abissal Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23964_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23964_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Edify Performance\" etkinliği süresince, Koruyucular \"Kozmik Kalıntı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23965_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23965_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Kaos Kümesi\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23966_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23966_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Edify Performance\" etkinliği süresince, Koruyucular \"Kozmik Kalıntı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23967_ActivityName = {
    Text = "Derin Dalış Düellosu"
  },
  Activity_23967_ActivityPlot = {
    Text = "Etkinlik süresince, Koruyucunun \"Hayali Dalış\" ve \"Traphase\" aracılığıyla kazandığı Koruyucu Deneyimi iki katına çıkar ve günlük üst sınır 480 puana yükseltilir."
  },
  Activity_23967_ActivityTips = {
    Text = "\nEtkinlik Kuralları:\n1. \"Hayali Dalış ve Traphase\" etkinliği süresince, Koruyucu \"Hayali Dalış\" ve \"Traphase\" aracılığıyla iki katı Koruyucu Deneyimi kazanır ve günlük üst sınır 480 puana yükseltilir. Çekirdek konu da açılmışsa, bu yoldan kazanılan Koruyucu Deneyimi tekrar iki katına çıkar ve günlük üst sınır 480 puanda kalır.\n2. Gün içinde kullanılmayan çift Koruyucu Deneyimi ertesi gün sabah 9:00'da (GMT+8) sıfırlanır, bu yüzden zamanında kullanmayı unutma, Koruyucu~"
  },
  Activity_23968_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_23968_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucular \"İksir İşleme\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23969_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23969_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Schwarzschild Boğazı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23970_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23970_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Abissal Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23971_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23971_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Edify Performance\" etkinliği süresince, Koruyucular \"Kozmik Kalıntı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23972_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23972_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Solucan Yuvası\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23973_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23973_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kaotik Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 malzeme ödülü kazanır (Koruyucu Deneyimi ve Altın Gül hariç), günlük sınır yoktur."
  },
  Activity_23974_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_23974_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucular \"İksir İşleme\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23975_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23975_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Aydınlatma Performansı\" etkinliği süresince, Koruyucu \"Kanlı Kalıntı\"yı tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_23976_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23976_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Abissal Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23977_ActivityName = {
    Text = "Simya Estetiği"
  },
  Activity_23977_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Simya Estetiği\" etkinliği süresince, Koruyucular \"Altın Gül Avı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23978_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_23978_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucular \"İksir İşleme\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23979_ActivityName = {
    Text = "Simya Estetiği"
  },
  Activity_23979_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Simya Estetiği\" etkinliği süresince, Koruyucu \"Altın Gül Avı\"nı tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_23980_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23980_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucu \"Kaos Kümesi\"ni tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_23981_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23981_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Edify Performance\" etkinliği süresince, Koruyucular \"Kozmik Kalıntı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23982_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23982_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Solucan Yuvası\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23983_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23983_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Aydınlatma Performansı\" etkinliği süresince, Koruyucu \"Kozmik Kalıntı\"yı tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_23984_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23984_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Solucan Yuvası\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23985_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_23985_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucular \"İksir İşleme\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23986_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23986_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kaotik Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23987_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_23987_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucular \"İksir İşleme\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23988_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23988_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kaotik Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23989_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23989_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Solucan Yuvası\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23990_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23990_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Schwarzschild Boğazı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23991_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23991_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Solucan Yuvası\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23992_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23992_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Abissal Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23993_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23993_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kanlı Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_23994_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23994_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Kaos Kümesi\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23995_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23995_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Schwarzschild Boğazı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23996_ActivityName = {
    Text = "Derin Dalış Düellosu"
  },
  Activity_23996_ActivityPlot = {
    Text = "Etkinlik süresince, Koruyucunun \"Hayali Dalış\" ve \"Traphase\" aracılığıyla kazandığı Koruyucu Deneyimi iki katına çıkar ve günlük üst sınır 480 puana yükseltilir."
  },
  Activity_23996_ActivityTips = {
    Text = "\nEtkinlik Kuralları:\n1. \"Hayali Dalış ve Traphase\" etkinliği süresince, Koruyucu \"Hayali Dalış\" ve \"Traphase\" aracılığıyla iki katı Koruyucu Deneyimi kazanır ve günlük üst sınır 480 puana yükseltilir. Çekirdek konu da açılmışsa, bu yoldan kazanılan Koruyucu Deneyimi tekrar iki katına çıkar ve günlük üst sınır 480 puanda kalır.\n2. Gün içinde kullanılmayan çift Koruyucu Deneyimi ertesi gün sabah 9:00'da (GMT+8) sıfırlanır, bu yüzden zamanında kullanmayı unutma, Koruyucu~"
  },
  Activity_23997_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23997_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Pohnpei Harabeleri\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_23998_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_23998_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kanlı Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 malzeme ödülü kazanır (Koruyucu Deneyimi ve Altın Gül hariç), günlük sınır yoktur."
  },
  Activity_23999_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_23999_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Schwarzschild Boğazı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24000_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24000_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Abissal Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24001_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24001_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Kaos Kümesi\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24002_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24002_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kanlı Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24003_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24003_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Solucan Yuvası\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24004_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24004_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Edify Performance\" etkinliği süresince, Koruyucular \"Kozmik Kalıntı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24005_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24005_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Schwarzschild Boğazı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24006_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24006_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Pohnpei Harabeleri\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24007_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24007_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucu \"Pohnpei Harabeleri\"ni tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_24009_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24009_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kanlı Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24010_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24010_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kaotik Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24011_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_24011_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucular \"İksir İşleme\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24012_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24012_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kanlı Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24013_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24013_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Schwarzschild Boğazı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24014_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24014_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kaotik Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24015_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_24015_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucular \"İksir İşleme\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24016_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24016_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Abissal Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24017_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24017_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Schwarzschild Boğazı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24018_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24018_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kaotik Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24019_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24019_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Aydınlatma Performansı\" etkinliği süresince, Koruyucu \"Uçurum Kalıntısı\"nı tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_24020_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_24020_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucular \"İksir İşleme\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24021_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24021_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Pohnpei Harabeleri\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24022_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_24022_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucular \"İksir İşleme\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24023_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24023_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucu \"Schwarzschild Boğazı\"nı tamamladıktan sonra bazı malzeme ödülleri iki katına çıkar, günde en fazla 3 kez.\n2. Gün içinde kullanılmayan çift ödül hakları ertesi gün saat 9:00'da (GMT+8) sıfırlanır, zamanında kullanmayı unutmayın~"
  },
  Activity_24025_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24025_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Pohnpei Harabeleri\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24026_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24026_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Solucan Yuvası\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 malzeme ödülü kazanır (Koruyucu Deneyimi ve Altın Gül hariç), günlük sınır yoktur."
  },
  Activity_24027_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24027_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Solucan Yuvası\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24028_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24028_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kanlı Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24029_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24029_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Schwarzschild Boğazı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24030_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24030_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kaotik Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24031_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_24031_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucular \"İksir İşleme\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24032_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24032_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Abissal Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24033_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24033_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kanlı Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24034_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24034_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Pohnpei Harabeleri\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24035_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24035_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Solucan Yuvası\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24036_ActivityName = {
    Text = "Derin Dalış Düellosu"
  },
  Activity_24036_ActivityPlot = {
    Text = "Etkinlik süresince, Koruyucunun \"Hayali Dalış\" ve \"Traphase\" aracılığıyla kazandığı Koruyucu Deneyimi iki katına çıkar ve günlük üst sınır 480 puana yükseltilir."
  },
  Activity_24036_ActivityTips = {
    Text = "\nEtkinlik Kuralları:\n1. \"Hayali Dalış ve Traphase\" etkinliği süresince, Koruyucu \"Hayali Dalış\" ve \"Traphase\" aracılığıyla iki katı Koruyucu Deneyimi kazanır ve günlük üst sınır 480 puana yükseltilir. Çekirdek konu da açılmışsa, bu yoldan kazanılan Koruyucu Deneyimi tekrar iki katına çıkar ve günlük üst sınır 480 puanda kalır.\n2. Gün içinde kullanılmayan çift Koruyucu Deneyimi ertesi gün sabah 9:00'da (GMT+8) sıfırlanır, bu yüzden zamanında kullanmayı unutma, Koruyucu~"
  },
  Activity_24037_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24037_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kozmik Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 malzeme ödülü kazanır (Koruyucu Deneyimi ve Altın Gül hariç), günlük sınır yoktur."
  },
  Activity_24038_ActivityName = {
    Text = "Derin Dalış Düellosu"
  },
  Activity_24038_ActivityPlot = {
    Text = "Etkinlik süresince, Koruyucunun \"Hayali Dalış\" ve \"Traphase\" aracılığıyla kazandığı Koruyucu Deneyimi iki katına çıkar ve günlük üst sınır 480 puana yükseltilir."
  },
  Activity_24038_ActivityTips = {
    Text = "\nEtkinlik Kuralları:\n1. \"Hayali Dalış ve Traphase\" etkinliği süresince, Koruyucu \"Hayali Dalış\" ve \"Traphase\" aracılığıyla iki katı Koruyucu Deneyimi kazanır ve günlük üst sınır 480 puana yükseltilir. Çekirdek konu da açılmışsa, bu yoldan kazanılan Koruyucu Deneyimi tekrar iki katına çıkar ve günlük üst sınır 480 puanda kalır.\n2. Gün içinde kullanılmayan çift Koruyucu Deneyimi ertesi gün sabah 9:00'da (GMT+8) sıfırlanır, bu yüzden zamanında kullanmayı unutma, Koruyucu~"
  },
  Activity_24039_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24039_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Solucan Yuvası\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24040_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_24040_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucular \"İksir İşleme\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24041_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_24041_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucular \"İksir İşleme\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 Gnosis İksiri ödülü kazanır, günlük sınır yoktur."
  },
  Activity_24042_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24042_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Edify Performance\" etkinliği süresince, Koruyucular \"Kozmik Kalıntı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24043_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_24043_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucular \"İksir İşleme\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24044_ActivityName = {
    Text = "Simya Estetiği"
  },
  Activity_24044_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Simya Estetiği\" etkinliği süresince, Koruyucular \"Altın Gül Avı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 Altın Gül ödülü kazanır, günlük sınır yoktur."
  },
  Activity_24045_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24045_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Kaos Kümesi\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24046_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_24046_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucular \"İksir İşleme\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24047_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24047_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Pohnpei Harabeleri\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 malzeme ödülü kazanır (Koruyucu Deneyimi ve Altın Gül hariç), günlük sınır yoktur."
  },
  Activity_24049_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24049_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kanlı Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24050_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24050_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Pohnpei Harabeleri\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24051_ActivityName = {
    Text = "Yoğun Eğitim"
  },
  Activity_24051_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yoğun Eğitim\" etkinliği süresince, Koruyucular \"Kaos Kümesi\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24052_ActivityName = {
    Text = "Gnosis Patlaması"
  },
  Activity_24052_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Gnosis Patlaması\" etkinliği süresince, Koruyucular \"İksir İşleme\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24053_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24053_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kaotik Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24054_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24054_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Eğitim Performansı\" etkinliği süresince, Koruyucular \"Kaotik Kalıntı\" bölümünde araştırma yaparken veya Yeniden Canlandırma gerçekleştirirken ekstra %50 ödül kazanır (Koruyucu Deneyimi hariç), günlük sınır yoktur."
  },
  Activity_24055_ActivityName = {
    Text = "Aydınlatma Performansı"
  },
  Activity_24055_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Edify Performance\" etkinliği süresince, Koruyucular \"Kozmik Kalıntı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra ödül (Koruyucu Deneyimi hariç) kazanır, günlük sınır yoktur."
  },
  Activity_24194_ActivityName = {
    Text = "Kırmızılı Madam"
  },
  Activity_24194_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Kırmızılı Madam\" etkinliği süresince Koruyucular, Sorel'i içeren sistem tarafından önceden ayarlanmış takımı kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarında Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödülü talep edilebilir."
  },
  Activity_24195_ActivityName = {
    Text = "Balçık Çiçeği"
  },
  Activity_24195_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Balçık Çiçeği\" etkinliği süresince Koruyucular, Lily'yi içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini oynarken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_24992_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_24992_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_25011_ActivityName = {
    Text = "Bir Adım Ötede"
  },
  Activity_25011_ActivityPlot = {
    Text = "Bir adım öne atar ve başka bir zaman ile mekâna geçersin."
  },
  Activity_25011_ActivityTips = {
    Text = "<Title:Katılım Koşulları>\n\"Şövalyenin Dileği\" bilinç gezintisinin Normal modunu tamamlayarak katılım sağlanabilir.\n<Title:Soruşturma Etkinliği>\nEtkinlik süresince, \"Bir Adım Ötede\" bölümünden her gün yeni bir soruşturma etkinliği başlatılacaktır. Koruyucular envanter harcamadan kilitleri açabilir ve soruşturma yapabilir. Soruşturma etkinliğini tamamladıktan sonra Saf Çekirdek, Soruşturma Rozeti ve Koruyucu Deneyimi gibi ödüller elde edilebilir.\nEtkinlik sona erdikten sonra \"Bir Adım Ötede\" soruşturma ilerlemesi korunacaktır ve Koruyucular, bilinç gezintisinde D-Mücevher harcayarak tamamlanmamış soruşturmaların kilidini açabilir. Etkinlik süresince tamamlanmamış soruşturma etkinliklerini tamamlamak da etkinlik sırasındakilerle tutarlı ödüller verecektir.<Title:Sınırlı Süreli Ödüller>\nEtkinlik süresince sınırlı süreli ödüller mevcut olacaktır. Koruyucular, \"Bir Adım Ötede\" Normal modunu tamamladıktan ve soruşturma etkinliklerini bitirdikten sonra Şans Şekeri ve Gümüş elde edebilir! Sınırlı süreli ödüller yalnızca etkinlik süresince geçerlidir ve etkinlik sona erdikten sonra tamamlanamaz veya talep edilemez."
  },
  Activity_25011_UnlockConditionExplanation = {
    Text = "Kilidi açmak için \"Şövalyenin Dileği\" Gezintisini tamamlayın"
  },
  Activity_25012_ActivityName = {
    Text = "Güle Övgü"
  },
  Activity_25012_ActivityPlot = {
    Text = "Bayanlar ve baylar.\nYumuşak gece perdesini araladı—en seçkin içkinizi hazırlayın.\nBu uzun bir hikâye. İzin verin, onu ağır ağır anlatalım."
  },
  Activity_25012_ActivityTips = {
    Text = "<Title:Katılım Koşulları>\n\"Soruşturma Operasyonu\" 2-9 (Normal) tamamlanarak katılım sağlanabilir.\n<Title:Soruşturma Etkinliği>\nEtkinlik süresince, \"Güle Saygı\" bölümünden her gün yeni bir soruşturma etkinliği başlatılacaktır. Koruyucular envanter harcamadan kilitleri açabilir ve soruşturma yapabilir. Soruşturma etkinliğini tamamladıktan sonra Saf Çekirdek, Soruşturma Rozeti ve Koruyucu Deneyimi gibi ödüller elde edilebilir.\nEtkinlik sona erdikten sonra \"Güle Saygı\" soruşturma ilerlemesi korunacaktır ve Koruyucular, Özel Operasyonlarda D-Mücevher harcayarak tamamlanmamış soruşturmaların kilidini açabilir. Etkinlik süresince tamamlanmamış soruşturma etkinliklerini tamamlamak da etkinlik sırasındakilerle tutarlı ödüller verecektir.<Title:Sınırlı Süreli Ödüller>\nEtkinlik süresince sınırlı süreli ödüller mevcut olacaktır. Koruyucular, \"Güle Saygı\" (Normal) modunu tamamladıktan ve \"Güle Saygı\" soruşturma etkinliklerini bitirdikten sonra Saf Çekirdek, Felsefe Taşı ve Gümüş elde edebilir! Sınırlı süreli ödüller yalnızca etkinlik süresince geçerlidir ve etkinlik sona erdikten sonra tamamlanamaz veya talep edilemez."
  },
  Activity_25012_UnlockConditionExplanation = {
    Text = "Ana Hikâye 2-9: Normal tamamlandıktan sonra açılır"
  },
  Activity_34754_ActivityName = {
    Text = "Hikâye Anlatımının Büyüsü"
  },
  Activity_34754_ActivityTips = {
    Text = "<Title:Katılım Koşulları>\n\" Soruşturma Operasyonu\" 2-9'u (Normal) tamamlayarak katılın.\n<Title:Soruşturma Olayı>\nEtkinlik süresince, \"Hikâyelerin Büyüsü\"nden her gün yeni bir soruşturma olayı başlatılacaktır. Koruyucular, envanter tüketmeden kilidini açıp soruşturma yürütebilir. Soruşturma olayını tamamladıktan sonra Saf Çekirdek, Soruşturma Rozeti ve Koruyucu Deneyimi gibi ödüller elde edilebilir.\nEtkinlik sona erdikten sonra, \"Hikâyelerin Büyüsü\"nün soruşturma ilerlemesi korunacaktır. Koruyucular, Özel Görev Kayıtları'nda D-Mücevher harcayarak tamamlanmamış soruşturmaların kilidini açabilir. Etkinlik süresince tamamlanmamış soruşturma olaylarını tamamlamak, etkinlik sırasında verilenlerle tutarlı ödüller kazandıracaktır.<Title:Sınırlı Süreli Ödüller>\nEtkinlik süresince sınırlı süreli ödüller alınabilir olacaktır. Koruyucular, \"Hikâyelerin Büyüsü\"nü (Normal mod) temizleyip soruşturma olaylarını tamamladıktan sonra Saf Çekirdek, Felsefe Taşı ve Gümüş elde edebilir! Sınırlı süreli ödüller yalnızca etkinlik süresince alınabilir, etkinlik sona erdikten sonra tamamlanamaz veya talep edilemez."
  },
  Activity_34755_ActivityName = {
    Text = "Hikâye Anlatımının Büyüsü"
  },
  Activity_34755_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\nEtkinlik süresince \"Kurgulanmış Gizem\" oyun modu süreli olarak erişime açılacak ve \"Özel Görev Kayıtları: Hikâyelerin Büyüsü\" ücretsiz olarak kilidi açılacaktır!\n\n<Title:Kurgulanmış Gizem>\n\"Kurgulanmış Gizem\" 9 zorluk seviyesinden oluşur; önerilen seviye aralığı 30 ila 70'tir. Daha yüksek zorluk seviyeleri, alt seviyeler tamamlandıktan sonra açılır.\nHer meydan okuma 60 Menofin tüketir ve her aşamayı tamamlamak size etkinlik para birimi \"Savrulan İlham\" kazandırır. Zorluk ne kadar yüksekse, kazanabileceğiniz \"Savrulan İlham\" da o kadar fazladır!\n\"Savrulan İlham\", \"Gizemli Kodex Eczanesi\"nde büyük miktarda Uyanan yetiştirme malzemesiyle takas edilebilir ve ayrıca gelecekte yeniden yayımlanabilecek veya kalıcı uyanışlara eklenebilecek etkinliğe özel SR Kader Çarkı \"35mm Sihir\" ile de takas edilebilir.\nHer meydan okuma sırasında, boss dışında düşmanlar, olaylar ve haritalar değişebilir ve seviyelerde daha fazla Kalıntı ortaya çıkabilir!\n\"Kurgulanmış Gizem\"de Mezun yardımı kullanabilirsiniz.\n\n<Title:Rezonans ve Başarımlar>\n\"Çıkarım Kalbi\" harcayıp \"Rezonans: Yönetmen Parolası\"nı etkinleştirerek Koruyucular, \"Kurgulanmış Gizem\"de daha da güçlenir ve meydan okumalar kolaylaşır.\nKoruyucular, Etkinlik Başarımlarını elde ederek \"Çıkarım Kalbi\" kazanabilir; ayrıca bu başarımlar aracılığıyla etkinliğe özel avatar \"Gümüş Anahtar Adına: Lily\"yi de alabilirler!\n\n<Title:Özel Görev Kayıtları>\nEtkinlik süresince \"Hikâyelerin Büyüsü\"nden yeni bir Soruşturma olayı her gün yayımlanacak ve Koruyucular, Soruşturmaların kilidini kaynak harcamadan açabilecektir; Soruşturma olayını tamamladıklarında Saf Çekirdek, Soruşturma Rozetleri ve Koruyucu EXP gibi ödüller elde ederler.\nEtkinlik sona erdikten sonra \"Hikâyelerin Büyüsü\"nün Soruşturma ilerlemesi korunur ve Koruyucular, tamamlanmamış Soruşturmaların kilidini açmak için D-Mücevheri kullanabilir. Etkinlik sırasında tamamlanmamış Soruşturmaları sonradan tamamlamak, etkinlik sırasındakiyle aynı ödülleri verir.\nEtkinlik süresince süreli Başarım ödülleri yayımlanacaktır. Koruyucular, \"Hikâyelerin Büyüsü\"nün normal modunu ve Soruşturma olaylarını tamamladıktan sonra Etkinlik Başarımlarında Gümüş ödüller alabilir! Başarım ödülleri yalnızca etkinlik süresince mevcuttur; etkinlik sona erdikten sonra tamamlanamaz veya talep edilemez."
  },
  Activity_34764_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34765_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34766_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34767_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34768_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34769_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34770_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34771_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34772_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34773_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34774_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34775_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34776_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34777_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34778_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34779_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34780_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34781_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34782_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34783_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34784_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34785_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34786_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34787_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34788_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34789_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34790_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34791_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34792_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34793_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34794_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34795_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34796_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34797_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34798_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34799_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34800_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34801_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34802_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34803_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34804_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34805_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34806_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34807_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34808_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34809_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34810_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34811_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34812_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34813_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34814_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34815_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34816_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34817_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34818_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34819_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34820_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34821_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34822_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34823_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34824_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34825_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34826_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34827_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_34828_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_35844_ActivityName = {
    Text = "Derinlerin Hanımefendisi"
  },
  Activity_35844_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Derinlerin Hanımefendisi\" etkinliği süresince Koruyucular, Murphy'yi içeren sistem tarafından önceden ayarlanmış takımı kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarında Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödülü talep edilebilir."
  },
  Activity_35983_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_35983_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_36841_ActivityName = {
    Text = "Eadem Omnia"
  },
  Activity_36841_ActivityPlot = {
    Text = "Bu, Aurita için basit ve mutlu bir gün. Bu, Onun her günü."
  },
  Activity_36841_ActivityTips = {
    Text = "<Title:Katılım Koşulları>\n\"Şövalyenin Dileği\" bilinç gezintisinin Normal modunu tamamlayarak katılım sağlanabilir.\n<Title:Soruşturma Etkinliği>\nEtkinlik süresince, Koruyucular envanter harcamadan kilitleri açabilir ve soruşturma yapabilir. Soruşturma etkinliğini tamamladıktan sonra Saf Çekirdek, Soruşturma Rozeti ve Koruyucu Deneyimi gibi ödüller elde edilebilir.\nEtkinlik sona erdikten sonra \"Her Şey Her Zamanki Gibi\" soruşturma ilerlemesi korunacaktır. Koruyucular, bilinç gezintisinde D-Mücevher harcayarak tamamlanmamış soruşturmaların kilidini açabilir. Etkinlik süresince tamamlanmamış soruşturma etkinliklerini tamamlamak da etkinlik sırasındakilerle tutarlı ödüller verecektir.<Title:Sınırlı Süreli Ödüller>\nEtkinlik süresince sınırlı süreli ödüller mevcut olacaktır. Koruyucular, \"Her Şey Her Zamanki Gibi\" Normal modunu tamamladıktan ve \"Her Şey Her Zamanki Gibi\" soruşturma etkinliklerini bitirdikten sonra Abanoz Zincirler ve Gümüş elde edebilir! Sınırlı süreli ödüller yalnızca etkinlik süresince geçerlidir ve etkinlik sona erdikten sonra tamamlanamaz veya talep edilemez."
  },
  Activity_36841_UnlockConditionExplanation = {
    Text = "Kilidi açmak için \"Şövalyenin Dileği\" Gezintisini tamamlayın"
  },
  Activity_36885_ActivityName = {
    Text = "Alevlerin Şöleni"
  },
  Activity_36886_ActivityName = {
    Text = "Dikenlerin Kraliçesi"
  },
  Activity_36886_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Dikenlerin Kraliçesi\" etkinliği süresince Koruyucular, Wanda'yı içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_38716_ActivityName = {
    Text = "Operasyon Yeniden Başladı"
  },
  Activity_38716_ActivityTips = {
    Text = "<Title:Etkinlik Tanıtımı>\nKoruyucular, \"Okula Dönüş Ödülleri\"nde \"Yeniden Başlama İkmali\" ödüllerini doğrudan talep edebilir.\n\"Operasyon Yeniden Başlatma\" etkinliğinde ödül almak için belirlenen eğitim görevlerini tamamlayın.\nTüm eğitim görevlerini tamamlamak ek ödüller de kazandıracaktır."
  },
  Activity_38717_ActivityName = {
    Text = "Okula Dönüş Girişi"
  },
  Activity_38717_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\nKoruyucular, her gün giriş yaptıktan sonra \"Okula Dönüş Raporu\"nda günlük giriş ödülünü talep edebilir.\nÖdüller, Koruyucuların toplam giriş sayısına göre sırayla açılacak ve günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_38805_ActivityName = {
    Text = "Alevlerin Şöleni"
  },
  Activity_38805_ActivityPlot = {
    Text = "Göldeki Şehir Isarawu’nun, Wanda’nın memleketi olduğu söylenir.\nBu kez Rüya Kapısı’ndan geçecek ve saat dilleriyle dolu kadim kulelere varacaksın..."
  },
  Activity_38805_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\nEtkinlik süresince, \"Alevlerin Şöleni\" oynanışı sınırlı bir süre için alınabilir olacak ve \"Psişe Derin Dalışı: Alevlerin Şöleni\" ücretsiz olarak açılacak!\n\n<Title:Göldeki Şehir>\n\"Göldeki Şehir\" 7 aşamadan oluşur ve her 2 günde 1 aşama açılır! Her aşamadaki düşmanlar ve olaylar rastgele değişebilir.\nLütfen dikkat edin, aşama ödülü malzemelerinin türü, miktarı ve karışım oranı değişiklik gösterebilir. Daha erken açılan aşamalarda malzeme türleri daha basitken, daha geç açılan aşamalarda türler daha çeşitlidir ve toplam miktar daha fazladır. Lütfen stratejinizi buna göre belirleyin!\nHer aşama 7 zorluk seviyesi içerir; önerilen seviyeler 15~65 aralığındadır. Tüm zorluklar varsayılan olarak açıktır.\nHer deneme 120 Menofin tüketir. Daha yüksek zorluklar daha iyi ödüller sunar, bu yüzden size en uygun zorluk seviyesini seçin.\nAşamalarda elde edilen malzemeler, \"Wanda'nın Hazine Mahzeni\"nde büyük miktarda Uyanan yetiştirme malzemesi ve etkinliğe özel avatar \"Gümüş Anahtar Adına: Wanda\" ile takas edilebilir.\nAşamaları daha kolay geçmek için Alumnis yardımını ve \"Rezonans: Gizli Vekâlet Emri\"ni kullanabilirsiniz.\n\n<Title:Rezonans ve Başarılar>\n\"Hedonizm Kalbi\" harcayarak \"Rezonans: Gizli Vekâlet Emri\"ni etkinleştirmek, \"Göldeki Şehir\"de Gözetmen’i güçlendirir ve meydan okumaları kolaylaştırır; ayrıca aşamalar tamamlandığında ek etkinlik parası kazandırır.\nGözetmenler, \"Hedonizm Kalbi\"ni etkinlik başarılarını tamamlayarak veya \"Wanda'nın Hazine Mahzeni\"nde takas ederek elde edebilir.\n\n<Title:Psişe Derin Dalışı>\nEtkinlik süresince, \"Alevlerin Şöleni\" ücretsiz olarak açılabilir. Her gün, \"Alevlerin Şöleni\"nden yeni bir soruşturma olayı yayınlanacak ve bu olayları tamamlamak Saf Çekirdek, Soruşturma Rozeti ve Gözetmen DP’si gibi ödüller kazandıracaktır.\nEtkinlik sona erdikten sonra, \"Alevlerin Şöleni\"ndeki soruşturma ilerlemesi korunacaktır. Etkinlik sonrasında tamamlanmamış soruşturma olaylarını bitirmek, etkinlik sırasındakiyle aynı ödülleri kazandırmaya devam edecektir. \"Alevlerin Şöleni\" etkinlik sırasında açılmamışsa, etkinlikten sonra 3 \"Gerçeklik Sınırı\" harcanarak yine açılabilir.\nEtkinlik süresince, sınırlı süreli başarı ödülleri alınabilir olacaktır. \"Alevlerin Şöleni\"ndeki soruşturma olaylarını tamamlayan Gözetmenler, Etkinlik Başarıları’ndan Gümüş ödüller alabilir! Başarı ödülleri yalnızca etkinlik süresince alınabilir; etkinlik sonrasında tamamlanamaz veya talep edilemez.\n"
  },
  Activity_41378_ActivityName = {
    Text = "Önleyici Eğitim"
  },
  Activity_41378_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Önleyici Eğitim'de ödüller almak için görevleri tamamlayın\n2. Önleyici Eğitim kalıcı olarak erişilebilir kalır\n3. Görev tamamlandığında ekstra ödüller kazanmak için Premium Arşivleri açın\nNot: Etkinleştirilen Premium Arşivler yalnızca bu Arşiv etkinliğinde geçerlidir."
  },
  Activity_43569_ActivityName = {
    Text = "Uzak Denizler Arşivleri"
  },
  Activity_43569_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Uzak Denizler Arşivleri'nde ödülleri talep etmek için görevleri tamamlayın\n2. Uzak Denizler Arşivleri kalıcı olarak erişilebilir kalır\n3. Görev tamamlandığında ek ödüller kazanmak için Premium Arşivleri açın\nNot: Etkinleştirilen Premium Arşivler yalnızca bu Arşiv etkinliğinde geçerlidir."
  },
  Activity_43570_ActivityName = {
    Text = "Kar Kasabası Arşivleri"
  },
  Activity_43570_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Kar Kasabası Arşivleri'nde ödülleri talep etmek için görevleri tamamlayın\n2. Kar Kasabası Arşivleri kalıcı olarak erişilebilir kalır\n3. Görev tamamlandığında ek ödüller kazanmak için Premium Arşivleri açın\nNot: Etkinleştirilen Premium Arşivler yalnızca bu Arşiv etkinliğinde geçerlidir."
  },
  Activity_43572_ActivityName = {
    Text = "Simya Estetiği"
  },
  Activity_43572_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Simya Estetiği\" etkinliği süresince, Koruyucular \"Altın Gül Avı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %100 ekstra bonus (Koruyucu Deneyimi hariç) kazanır, günde 6 kez ile sınırlıdır."
  },
  Activity_43573_ActivityName = {
    Text = "Simya Estetiği"
  },
  Activity_43573_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Simya Estetiği\" etkinliği süresince, Koruyucular \"Altın Gül Avı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra Altın Gül bonusu kazanır."
  },
  Activity_43574_ActivityName = {
    Text = "Simya Estetiği"
  },
  Activity_43574_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Simya Estetiği\" etkinliği süresince, Koruyucular \"Altın Gül Avı\" bölümünde soruşturma veya Yeniden Canlandırma yaparken %50 ekstra Altın Gül bonusu kazanır."
  },
  Activity_44273_ActivityName = {
    Text = "Ruh Çobanı"
  },
  Activity_44273_ActivityPlot = {
    Text = "Senin için acı çekti, felaketlerini üstlendi.\nOnun bedeniyle şifa buldun;\nOnun hayatıyla bağışlandın"
  },
  Activity_44273_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Koruyucular, süreli etkinlikler \"Kilise Yolu\", \"Sivil Merhamet\" ve \"Başarı Ödülleri\" aracılığıyla etkinlik para birimi \"Hayır Kuponları\" toplayabilir. \"Hayır Kuponları\", \"Kilise Hayır Satışı\"nda rastgele eşyalarla takas edilebilir; bunlar arasında etkinliğe özel SR Kader Çarkı \"Aynadaki Adam\", Saf Çekirdek, Lümen Çekirdeği ve daha fazlası bulunur.\n2. \"Özel Kayıt: Kanın Rengi\"ni tamamlayarak yeni Çete \"Mucizenin Gelişi\"ni elde edebilirsiniz. Etkinlik süresince \"Özel Kayıt: Kanın Rengi\"ne süreli ücretsiz erişim sağlanır ve etkinlik başarımlarını tamamlamak, ayrıca etkinliğe özel avatar \"Gümüş Anahtar Adına: Salvador\"u da kazandırır!\n\n<Title:Kilise Yolu>\n1. \"Kilise Yolu\" 5 aşamadan oluşur; Koruyucular, \"Özel Kayıt: Kanın Rengi\"nin 2/4/6/7/9. aşamalarını tamamlayarak bunların kilidini tek tek açabilir.\n2. Her aşamada, önerilen seviye aralığı 15-65 olan 7 zorluk seviyesi bulunur ve tüm zorluklar varsayılan olarak açıktır. Her aşamadaki düşmanlar ve olaylar rastgele değişebilir.\n3. Mezun yardımı ve \"Rezonans: Ruhun Çatalı\"nı kullanarak aşamaları geçmek kolaylaştırılabilir.\n4. Her meydan okuma 120 Menofin tüketir; zorluk arttıkça elde edilen \"Hayır Kuponları\" da artar. Koruyucular, 240 Menofin tüketerek Çifte Meydan Okuma'yı seçebilir ve böylece iki kat \"Hayır Kuponu\" ile Koruyucu Deneyimi kazanabilir.\n\n<Title:Parıltı Bonusu>\n1. \"Ruhun Parıltısı\"nın etkisi altında, Uyanan \"Salvador\", SSR Kader Çarkı \"Kutsal Söz Levhası\" ve SR Kader Çarkı \"Aynadaki Adam\", \"Kilise Yolu\" aşama ödüllerinde ek \"Hayır Kuponu\" düşüşü sağlayabilir. Ayrıntılı bonuslar şöyledir:\n(1) Yöntem Bir: Koruyucunun belirli Uyanan veya Kader Çarkına sahip olması (sahaya sürülmesi gerekmez)\nUyanan \"Salvador\": Aydınlanma 0/1/2/3 ve üzeri, Bonus %30/%40/%50/%60.\nSSR Kader Çarkı \"Kutsal Söz Levhası\": Yığın 0/1/2/3 ve üzeri, Bonus %30/%40/%50/%60.\nSR Kader Çarkı \"Aynadaki Adam\": Yığın 0/1/2/3 ve üzeri, Bonus %15/%20/%25/%30.\n(2) Yöntem İki: Belirli Uyanan veya Kader Çarkını yardım için kullanmak\nUyanan \"Salvador\": Bonus %10.\nSSR Kader Çarkı \"Kutsal Söz Levhası\": Bonus %10.\nSR Kader Çarkı \"Aynadaki Adam\": Bonus %5.\n2. Aynı Uyanan veya Kader Çarkı için, iki yöntemden yalnızca daha yüksek olan \"Parıltı Bonusu\" geçerlidir; birikimli değildir.\n3. Farklı Uyananların veya Kader Çarklarının \"Parıltı Bonus\"ları üst üste eklenebilir; böylece Koruyucular yukarıdaki kurallara göre en fazla %150 \"Parıltı Bonusu\" elde edebilir!\n\n<Title:Rezonans: Ruhun Çatalı>\n1. Koruyucular, etkinlik başarımlarını tamamlayarak \"İtiraf Kalbi\" elde edebilir.\n2. \"İtiraf Kalbi\" harcayarak \"Rezonans: Ruhun Çatalı\"nı etkinleştirdiğinizde aşağıdaki faydaları elde edersiniz:\n(1) Koruyucuları \"Kilise Yolu\" ve \"Özel Kayıt: Kanın Rengi\" etkinlik oyunlarında güçlendirir, meydan okumaları kolaylaştırır.\n(2) \"Kilise Yolu\" meydan okumalarını tamamladıktan sonra kazanılan Yakınlığı artırır.\n(3) \"Sivil Merhamet\" etkinlik oyununu etkinleştirir.\n\n<Title:Sivil Merhamet>\n1. Rezonans \"Yolun Rahatlığı\" etkinleştirildikten sonra, saatte otomatik olarak 60 \"Hayır Kuponu\" kazanılır; en fazla 25 saatlik birikim yapılabilir.\n2. Rezonans \"Kefaret, Kefaret\" etkinleştirildikten sonra, ek olarak saatte 1800 Gül Senedi otomatik olarak kazanılır.\n\n<Title:Kilise Hayır Satışı>\n1. Koruyucular, \"Kilise Hayır Satışı\" dükkânında \"Hayır Kuponları\"nı kullanarak rastgele eşyalarla takas yapabilir; etkinliğe özel SR Kader Çarkı \"Aynadaki Adam\", Lümen Çekirdeği ve Saf Çekirdek sizi bekliyor~\n2. Kilise Hayır Satışı'nda üç dükkân bulunur ve açılışları şöyledir:\nDükkân \"Bayan Gray'in Mağazası\": Başlangıçta açıktır.\nDükkân \"Büyük John'un Harika Hayır Kurumu\": Etkinliğin 4. gününde açılır.\nDükkân \"Smith'in Özel İndirimi\": Etkinliğin 7. gününde açılır.\n3. Farklı dükkânlar farklı eşyalar sunar; Koruyucular ihtiyaçlarına göre seçim yapabilir.\n4. Her dükkânda hem özel hem de normal eşyalar bulunur; her takas 600 \"Hayır Kuponu\" karşılığında dükkândan rastgele beş eşya verir.\n5. Bir dükkândaki tüm özel eşyalar takas edildikten sonra, Koruyucular dükkânın yeniden stoklanmasını talep edebilir veya takasa devam edebilir. Bir dükkândaki tüm eşyalar takas edildiğinde, devam etmek için yeniden stoklama seçilmelidir.\n6. İlk iki yeniden stoklamada, dükkândaki tüm eşyaların kalan miktarı maksimuma yenilenir. Üçüncü yeniden stoklamadan itibaren yalnızca normal eşyalar yenilenir. Yeniden stoklamadan önce takas edilmemiş eşyaların miktarı korunmaz. Koruyucular yeniden stoklamadan önce dikkatle karar vermelidir~\n\n<Title:Özel Kayıt>\n1. Etkinlik süresince \"Özel Kayıt: Kanın Rengi\" ücretsizdir. \"Kanın Rengi\"ne ait yeni soruşturma olayları her 2 günde bir yayımlanacaktır. Bunları tamamlamak, Çete \"Mucizenin Gelişi\", Saf Çekirdek, Soruşturma Rozeti ve Koruyucu Deneyimi kazandırır.\n2. Etkinlikten sonra \"Kanın Rengi\"nin soruşturma ilerlemesi korunur. Etkinlik sonrasında tamamlanmamış soruşturma olaylarını tamamlamak aynı ödülleri verir. \"Kanın Rengi\" etkinlik sırasında açılmadıysa, etkinlikten sonra 7 \"Gerçeklik Sınırı\" karşılığında yine de açılabilir.\n3. Etkinlik süresince süreli başarı ödülleri mevcuttur. \"Kanın Rengi\"ndeki tüm soruşturma olaylarını tamamlamak, etkinlik başarımlarında \"Gümüş Anahtar Adına: Salvador\" avatarını kazandırır. Başarım ödülleri yalnızca etkinlik süresince alınabilir; etkinlik sona erdikten sonra tamamlanamaz veya talep edilemez.\n\n"
  },
  Activity_44626_ActivityName = {
    Text = "Ruh Çobanı"
  },
  Activity_44705_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_44705_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_44706_ActivityName = {
    Text = "Hayırsever Başrahip"
  },
  Activity_44706_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n \"Merhemlerin Piskoposu\" etkinliği süresince Koruyucular, Salvador'u içeren sistem tarafından önceden ayarlanmış takım dizilişini kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcı değiştirilemez. \n<Title:Etkinlik Ödülleri>\n Aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_44716_ActivityName = {
    Text = "Uyuyan Hükümdar"
  },
  Activity_44716_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Uyuyan Hükümdar\" etkinliği süresince, Koruyucular Tulu içeren sistem tarafından hazırlanmış takımları kullanarak belirlenen bölümleri sınırsız sayıda deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken, takım dizilişindeki Uyandırıcılar üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra, oyuncular etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_45664_ActivityName = {
    Text = "Devin Düşüşü"
  },
  Activity_45664_ActivityPlot = {
    Text = "Sonsuz Derin Deniz, kavurucu güneş, sürgün edilmiş bir Perizit kahraman ve tek hizmetkârı.\nBu, \"arayış\" hakkında bir hikâye."
  },
  Activity_45664_ActivityTips = {
    Text = "<Title:Katılım Koşulları>\n\"Şövalyenin Dileği\" Gezinti Normal modunu tamamlayarak katılabilirsiniz.\n<Title:Operasyon Etkinliği>\nEtkinlik süresince Koruyucular, envanter harcamadan kilidini açabilir ve operasyona başlayabilir. Operasyon etkinliğini tamamladıktan sonra Saf Çekirdek, Soruşturma Rozeti ve Koruyucu Deneyimi gibi ödüller kazanılabilir.\nEtkinlik sona erdikten sonra \"Devin Düşüşü\"nün kilit açma durumu ve operasyon ilerlemesi korunacaktır. Etkinlik süresince tamamlanmamış operasyon etkinliklerinin tamamlanması da etkinlik sırasındakiyle aynı ödülleri verecektir; etkinlik süresince kilidi açılmadıysa, etkinlik sona erdikten sonra Gerçeklik Başlangıç Noktası *3 harcayarak kilidi açılabilir.<Title:Sınırlı Süreli Ödüller>\nEtkinlik süresince sınırlı süreli ödüller mevcut olacaktır. Koruyucular, \"Devin Düşüşü\" Normal modunu geçtikten ve \"Devin Düşüşü\" operasyon etkinliklerini tamamladıktan sonra Boyut Kristali ve Gümüş ödülleri kazanabilir! Sınırlı süreli ödüller yalnızca etkinlik süresince geçerlidir ve etkinlik sona erdikten sonra tamamlanamaz veya talep edilemez."
  },
  Activity_45664_UnlockConditionExplanation = {
    Text = "Kilidi açmak için \"Şövalyenin Dileği\" Gezintisini tamamlayın"
  },
  Activity_46167_ActivityName = {
    Text = "Disosiyatif Hasta: Kaos"
  },
  Activity_46167_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Disosiyatif Hasta: Kaos\" etkinliği süresince Koruyucular, \"24\"ü içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini oynarken takım kadrosundaki Uyandırıcıda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra etkinlik arayüzünden demo ödüllerini talep edebilirsiniz."
  },
  Activity_46168_ActivityName = {
    Text = "Kafatası Avcısı Cadı"
  },
  Activity_46168_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Kafatası Avcısı Cadı\" etkinliği süresince, Koruyucular Nergis'i içeren sistem tarafından hazırlanmış takımları kullanarak belirlenen bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken, takım kadrosundaki Uyandırıcılarda değişiklik yapılmasına izin verilmez.\n<Title:Etkinlik Ödülleri>\nBölüm mücadelesini ilk kez başarıyla tamamladıktan sonra, oyuncular etkinlik arayüzünden deneme ödüllerini alabilir."
  },
  Activity_46609_ActivityName = {
    Text = "Çoklu Şifa"
  },
  Activity_46609_ActivityPlot = {
    Text = "Histeri. Adına istersen mania de, istersen zihnin paramparça oluşu; bu çağda bu teşhis, bir idam fermanıdır. Neyse ki Mythag’ın bilim insanları ve Müfettişleri, kendilerine özgü bir delilikle maluldür: Bu dehşeti alt etmeye kararlıdırlar."
  },
  Activity_46609_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Ego Tahlili\" alınabilir."
  },
  Activity_46609_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Koruyucular, süreli oyun modları \"Hafıza Kodlaması\", \"Sınır Deposu\" ve \"Başarı Ödülleri\" aracılığıyla etkinlik para birimi \"Hafıza Bulmacası\" toplayabilir. \"Hafıza Bulmacası\", \"Kişilik Analizi\" içinde etkinliğe özel SR Kader Çarkı \"Gümüş Morina'nın Kararlılığı\", Lümen Çekirdeği, Saf Çekirdek, Eter Taşı ve bol miktarda yetiştirme malzemesi satın almak için kullanılabilir.\n2. \"Görev Kaydı: Sakin Bölünme\"yi tamamlamak, yeni Çete \"Onun Her Şeyi\"ni kazandırır. Etkinlik süresince \"Görev Kaydı: Sakin Bölünme\"ye süreli ücretsiz erişim sağlanır ve etkinlik başarımlarını tamamlamak, ayrıca etkinliğe özel avatar \"Gümüş Anahtar Adına: '24'!\"ü verir.\n\n<Title:Etkinlik Süresi>\n1. 27 Nisan, 9:00 - 18 Mayıs, 9:00 (GMT+8): Tüm etkinlik oyun modlarına erişilebilir ve \"Görev Kaydı: Sakin Bölünme\"ye süreli ücretsiz erişim sağlanır.\n2. 18 Mayıs, 9:00 - 25 Mayıs, 9:00 (GMT+8): Yalnızca \"Kişilik Analizi\" ve Başarı Ödülleri erişime açıktır. \"Görev Kaydı: Sakin Bölünme\"nin kilidini açmak için 7 Gerçeklik Sınırı harcanması gerekir.\n\n<Title:Hafıza Kodlaması>\n1. \"Hafıza Kodlaması\" 5 seviyeden oluşur. Koruyucular, \"Görev Kaydı: Sakin Bölünme\"nin 2/4/6/8/10. seviyelerini tamamlayarak bu seviyelerin kilidini sırasıyla açabilir.\n2. Her seviyede, önerilen seviye aralığı 15 ila 65 olan 7 zorluk ayarı bulunur. Tüm zorluklar varsayılan olarak açıktır. Her seviyedeki düşmanlar ve olaylar rastgele değişebilir.\n3. Mezun yardımı ve \"Rezonans: Dissosiyatif Sendrom\" seviyeleri daha kolay geçmeye yardımcı olabilir.\n4. Her deneme 120 Menofin tüketir. Zorluk arttıkça, tamamlandığında elde edilen \"Hafıza Bulmacası\" da artar. Ayrıca Koruyucular, 240 Menofin harcayarak meydan okumayı ikiye katlamayı seçebilir ve böylece iki kat \"Hafıza Bulmacası\" ile Koruyucu Deneyimi kazanabilir.\n\n<Title:Akılcı Bonus>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan Koruyucular (sahaya sürülmeleri gerekmez), \"Hafıza Kodlaması\" seviye görevlerinin ödüllerinde \"Hafıza Bulmacası\" için ek düşüş bonusları alabilir; ayrıntılar şöyledir:\nUyanan \"24\": Aydınlanma 0/1/2/3 ve üzeri, bonus %15/%20/%25/%30.\nUyanan \"Daffodil\": Aydınlanma 0/1/2/3 ve üzeri, bonus %15/%20/%25/%30.\nSSR Kader Çarkı \"Sapkın Yutma\": Yığın Seviyesi 0/1/2/3 ve üzeri, bonus %15/%20/%25/%30.\nSSR Kader Çarkı \"En Değerli Koleksiyon\": Yığın Seviyesi 0/1/2/3 ve üzeri, bonus %15/%20/%25/%30.\nSR Kader Çarkı \"Gümüş Morina'nın Kararlılığı\": Yığın Seviyesi 0/1/2/3 ve üzeri, bonus %15/%20/%25/%30.\n2. Farklı Uyananların veya Kader Çarklarının \"Akılcı Bonus\"ları toplamalı olarak hesaplanır.\n\n<Title:Rezonans: Dissosiyatif Sendrom>\n1. Koruyucular, etkinlik başarımlarını tamamlayarak \"Bölünmüş Kalp\" elde edebilir.\n2. \"Bölünmüş Kalp\" harcayarak \"Rezonans: Dissosiyatif Sendrom\"u etkinleştirmek aşağıdaki bonusları sağlar:\n(1) Koruyucuları \"Hafıza Kodlaması\" ve \"Görev Kaydı: Sakin Bölünme\" etkinlik oyun modlarında güçlendirir, meydan okumaları kolaylaştırır.\n(2) \"Hafıza Kodlaması\" meydan okumalarını tamamladıktan sonra elde edilen ödülleri artırır.\n(3) \"Sınır Deposu\" etkinlik oyun modunu etkinleştirir.\n\n<Title:Sınır Deposu>\nRezonans \"Teşhis: Parçalanmış Benlik\" etkinleştirildikten sonra, her saat otomatik olarak 60 \"Hafıza Bulmacası α\" elde edilir; en fazla 25 saatlik birikim yapılabilir.\n\n<Title:Görev Kaydı>\n1. Etkinlik süresince \"Görev Kaydı: Sakin Bölünme\" ücretsiz olarak açılabilir. \"Sakin Bölünme\"ye ait yeni soruşturma olayları her 2 günde bir yayımlanacaktır. Soruşturma olaylarını tamamlamak, Çete \"Onun Her Şeyi\", Saf Çekirdek, Soruşturma Rozetleri ve Koruyucu Deneyimi gibi ödüller kazandırır.\n2. Etkinlik sona erdikten sonra \"Görev Kaydı: Sakin Bölünme\"nin soruşturma ilerlemesi korunur. Etkinlik süresince tamamlanmamış soruşturma olaylarını sonrasında tamamlamak, aynı soruşturma ödüllerini verir. \"Görev Kaydı: Sakin Bölünme\" etkinlik sırasında açılmadıysa, etkinlikten sonra da 7 Gerçeklik Sınırı harcanarak açılabilir.\n3. Etkinlik süresince süreli başarı ödülleri sunulacaktır. Koruyucular, \"Görev Kaydı: Sakin Bölünme\"nin tüm soruşturma olaylarını tamamladıktan sonra \"Gümüş Anahtar Adına: '24'\" avatarını etkinlik başarımlarından alabilir. Başarım ödülleri yalnızca etkinlik süresince mevcuttur; etkinlik sona erdikten sonra tamamlanamaz veya talep edilemez.\n\n\n"
  },
  Activity_46609_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_47534_ActivityName = {
    Text = "Dingin Bölünme"
  },
  Activity_48136_ActivityName = {
    Text = "Disosiyatif Hasta: Aequor"
  },
  Activity_48136_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Disosiyatif Hasta: Aequor\" etkinliği süresince Koruyucular, \"24\"ü içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini oynarken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_48137_ActivityName = {
    Text = "Disosiyatif Hasta: Caro"
  },
  Activity_48137_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Disosiyatif Hasta: Caro\" etkinliği süresince Koruyucular, \"24\"ü içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_48138_ActivityName = {
    Text = "Disosiyatif Hasta: Ultra"
  },
  Activity_48138_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Disosiyatif Hasta: Ultra\" etkinliği süresince Koruyucular, \"24\"ü içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_48719_ActivityName = {
    Text = "Bedensel Arzular"
  },
  Activity_48719_ActivityPlot = {
    Text = "Düşler, bastırılmış arzuların vahyidir. Onlarda oyalananlar, şehvetin dalgalarınca sarılıp birer şehvet havarisi hâline gelir—tabii eğer…"
  },
  Activity_48719_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Arzu Üremesi\" kullanılabilir."
  },
  Activity_48719_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli “Kaotik Arzu” oynanışı ve “Başarı Ödülleri” aracılığıyla “Ana Tohum” adlı etkinlik para birimini toplayabilir. “Ana Tohum”, “Arzu Dalgası”nda Lümen Çekirdeği, Saf Çekirdek ve bol miktarda yetiştirme malzemesiyle takas edilebilir.\n2. Etkinlik süresince “Operasyon 2-9: Normal”i tamamlayarak, Uyanmışın Yakınlık gereksinimini karşılamadan “Üreme Çılgınlığı”na da katılabilirsiniz. Dahası, tüketilen “Gerçeklik Sınırı” sayısı yalnızca 1 olur!\n3. Gizemli bir Gücün gelişi, Uyanmışla daha derin bir bağ kurmanıza yardım ediyor gibi görünüyor ve etkinlik boyunca elde edilen tüm Yakınlık miktarı ikiye katlanıyor!\n\n<Title:Etkinlik Süresi>\n1. 18 Mayıs 9:00 – 3 Haziran 9:00 (GMT+8) arasında, Etkinlik Özetinde yer alan tüm içeriklere katılınabilir.\n2. 3 Haziran 9:00 – 10 Haziran 9:00 (GMT+8) arasında yalnızca “Arzu Dalgası” ve “Başarı Ödülleri” erişilebilir durumda kalır; diğer tüm içerikler sona erer ve erişilemez.\n\n<Title:Kaotik Arzu>\n1. “Kaotik Arzu”, keşif gerektirmeyen ve doğrudan Savaşa girilen 10 malzeme aşamasından oluşur; her gün bir aşama açılır.\n2. Bu malzeme aşamalarında tüm Uyanmışları doğrudan Uyandıracak, önceden ayarlanmış Kalıntılar alacak ve 6. turdan sonra Thais’in yardımını göreceksiniz.\n3. Her meydan okuma 60 Menophin Tüketir ve bir kez temizlendikten sonra bu malzeme aşamaları yeniden yaratmayı destekler.\n4. Mezun kullanımı, aşamaları daha kolay temizlemenize yardımcı olabilir.\n\n<Title:Açgözlülük Bonusu>\n1. Belirli Uyanmışlara veya Kader Çarklarına sahip olan Muhafızlar (savaşa sokmaları gerekmez), “Kaotik Arzu” aşama görevlerinde fazladan “Ana Tohum” düşürebilir (yeniden yaratmalar dâhil); özel bonuslar şöyledir:\nUyanmış “Thais”: Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSSR Çark “Merhametli Beslenme”: Yığın 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSR Çark “Yanan Veda”: Yığın 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n2. Farklı Uyanmışların veya Çarkların “Açgözlülük Bonusları” toplamalı olarak Hesaplama’ya katılır.\n\n<Title:Üreme Çılgınlığı>\n1. “Operasyon 7-3: Normal” temizlendikten sonra, “Üreme Çılgınlığı” adlı yeni bir özel Soruşturma içeriği açılır!\n2. “Arzu Dalgası” etkinliğinin gelişiyle, Uyanmışlar gizemli Gücün etkisine girerek “Üreme Çılgınlığı” hâline düşer… Muhafızlar, dikkatli olun!\n3. Bir Uyanmışın Yakınlığı seviye 10’a ulaştığında, o Uyanmış için “Üreme Çılgınlığı Etkinliği”ni 7 “Gerçeklik Sınırı” harcayarak açabilirsiniz; tamamlamak 1 “Saf Çekirdek” kazandırır!\n4. “Arzu Dalgası” etkinliği süresince (3 Haziran 9:00’dan önce), koşullar “Operasyon 2-9: Normal”in temizlenmesine kadar gevşetilir ve Uyanmışlar Yakınlık gereksinimi olmadan “Üreme Çılgınlığı Etkinliği”ni açabilir; ayrıca “Gerçeklik Sınırı” tüketim gereksinimi yalnızca 1 olur!\n\n<Title:Yakınlık İki Kat>\n1. Gizemli bir Gücün gelişi, Uyanmışla daha derin bir ilişki kurmanıza yardım ediyor gibi görünüyor; etkinlik boyunca elde edilen tüm Yakınlık ikiye katlanır!\n2. Diğer Yakınlık bonus ödülleriyle birlikte, Hesaplama çarpma yöntemiyle yapılır; örneğin yardım Yakınlık bonusu kullanıldığında.\n<Title:Başarı Ödülleri>\n1. Tüm görevleri tamamlamak size şu ödülleri kazandırır: 800 Gümüş, büyük miktarda “Ana Tohum”, etkinlik sınırlı SR Çark “Yanan Veda” *16, etkinlik sınırlı avatar “Gümüş Anahtar Adına: Thais”.\n2. 16 görev içerir: “Kaotik Arzu”nun her aşamasını bir kez temizlemek, “Kaotik Arzu”da 10/20/30/40/50 yeniden yaratım biriktirmek, tüm Etkinlik Başarımlarını tamamlamak."
  },
  Activity_48719_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_48825_ActivityName = {
    Text = "Okul Kedisinin Minnettarlığı"
  },
  Activity_48825_ActivityPlot = {
    Text = "Koruyucular aşağıdaki sınırlı Uyandırıcılardan 1 tanesini seçerek Uyandırabilir!"
  },
  Activity_48825_ActivityTips = {
    Text = "<Title:Genel Bakış>\nHevesli uyanıklığınız olmasaydı, Mythag sonsuza dek uzun gecenin içinde gömülü kalabilirdi. Şimdi sözümüzü tuttuk, zorlukları aştık ve yarı yıl dönümü anına ulaştık. Bunun için okul kedisi, başından beri süren yoldaşlığınıza bir teşekkür nişanesi olarak size özel bir hediye sunacak.\n\n<Title:Etkinlik Kuralları>\nEtkinlik süresince, her Koruyucu 8 sınırlı SSR Uyandırıcı arasından 1 Uyandırıcı seçebilir: Tulu, Nergis, Sorel, Lily, Murphy, Wanda, Salvador ve \"24\".\nBir Koruyucu zaten uyandırılmış bir Uyandırıcı seçtiğinde, ilgili Parça*1 ve Kök Tortusu*50'ye dönüştürülür; ilgili Uyandırıcının Aydınlanma seviyesi doluysa, Gnosis Parçası*1 ve Kök Tortusu*150'ye dönüştürülür."
  },
  Activity_48825_BannerText = {
    Text = "Ücretsiz Sınırlı Uyandıran"
  },
  Activity_48826_ActivityName = {
    Text = "Kutup Gecesi ve Şafak Vakti"
  },
  Activity_48826_ActivityPlot = {
    Text = "Anı niteliğindeki sınırlı SSR Kader Çarkı \"Kutup Gecesi ve Şafak Vakti\"ni almak için her gün giriş yapın, toplamda 16 adede kadar!"
  },
  Activity_48826_ActivityTips = {
    Text = "<Title:Giriş>\nBu, oyunculara adanmış bir şiirdir; idealler, inanç ve birlikte geçirilen zaman hakkında. Samimi kalp asla atmayı bırakmasın ve Gümüş Anahtar ileriye giden yolu aydınlatsın.\n\n<Title:Etkinlik Kuralları>\nEtkinlik süresince, Koruyucular \"Kutup Gecesi ve Şafak Vakti\" bölümünden her gün giriş yaparak anı niteliğindeki sınırlı SSR Kader Çarkı \"Kutup Gecesi ve Şafak Vakti\"ni alabilir, toplamda en fazla 16 talep hakkı vardır.\nÖdüller, Koruyucuların kümülatif günlük giriş sayısına göre sırayla açılır ve günlük giriş ödülleri sabah 09:00'da (GMT+8) yenilenir."
  },
  Activity_48826_BannerText = {
    Text = "Ücretsiz Sınırlı SSR YK"
  },
  Activity_48827_ActivityName = {
    Text = "Şapkadaki Gümüş"
  },
  Activity_48827_ActivityPlot = {
    Text = "Eksik istatistiklere göre, son altı ayda Okul Kedisinin şapkası Öğrenciler tarafından binlerce kez okşanmış ve birçok küçük, göze çarpmayan Gümüş fark edilmeden yere düşmüş. Temizlikçiler bu durumdan oldukça rahatsız olmuş. Okul artık bu Gümüşleri topladı ve iyice temizleyerek kayıp eşya bürosunda sakladı. Sahiplerinin en kısa sürede gelip talep etmeleri tavsiye edilir."
  },
  Activity_48827_ActivityTips = {
    Text = "<Title:Genel Bakış>\nEksik istatistiklere göre, son altı ayda öğrenciler okul kedisinin şapkasının binlerce fotoğrafını çekmiş. Küçük ve göze çarpmayan birçok gümüş parçası yere düşmüş ancak sahipsiz kalmış. Temizlikten sorumlu hizmetliler bu durumdan oldukça rahatsız. Okul artık bu gümüş parçalarını topladı, iyice temizledi ve kayıp eşya bürosunda sakladı. Hak sahiplerinin gelip talep etmeleri rica olunur.\n\n<Title:Etkinlik Kuralları>\nEtkinlik süresince, Koruyucular \"Şapkadaki Gümüş\" bölümünden her gün giriş yaparak 1000 Gümüş talep edebilir, en fazla 5 talep hakkı vardır.\nÖdüller, Koruyucuların kümülatif giriş sayısına göre sırayla açılır ve günlük giriş ödülleri sabah 09:00'da (GMT+8) yenilenir."
  },
  Activity_48827_BannerText = {
    Text = "Giriş yaparak bol miktarda Gümüş kazanın"
  },
  Activity_48849_ActivityName = {
    Text = "Denizin Havarisi"
  },
  Activity_48849_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Denizin Havarisi\" etkinliği süresince Koruyucular, Miryam'ı içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_48850_ActivityName = {
    Text = "Bereket Nefesi"
  },
  Activity_48850_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Bereket Nefesi\" etkinliği süresince, Koruyucular Thais içeren sistem tarafından hazırlanmış takımları kullanarak belirlenen bölümleri sınırsız sayıda deneyimleyebilir.\nEtkinlik bölümlerini oynarken, takım dizilişindeki Uyandırıcı üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBir bölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_48851_ActivityName = {
    Text = "Derinlerin Hanımefendisi"
  },
  Activity_48851_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Derinlerin Hanımefendisi\" etkinliği süresince Koruyucular, Murphy'yi içeren sistem tarafından önceden ayarlanmış takımı kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarında Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödülü talep edilebilir."
  },
  Activity_48852_ActivityName = {
    Text = "Dikenlerin Kraliçesi"
  },
  Activity_48852_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Dikenlerin Kraliçesi\" etkinliği süresince Koruyucular, Wanda'yı içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_48853_ActivityName = {
    Text = "İsimsiz Şiir"
  },
  Activity_48853_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"İsimsiz Şiir\" etkinliği süresince Koruyucular, Horla'yı içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden demo ödüllerini talep edebilir."
  },
  Activity_48854_ActivityName = {
    Text = "Şanslı Dedektif"
  },
  Activity_48854_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n \"Şanslı Dedektif\" etkinliği süresince Koruyucular, Ryker'ı içeren sistem tarafından önceden ayarlanmış takım dizilişlerini kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcılar değiştirilemez. \n<Title:Etkinlik Ödülleri>\n Aşama görevini ilk kez başarıyla tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_48855_ActivityName = {
    Text = "Balçık Çiçeği"
  },
  Activity_48855_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Balçık Çiçeği\" etkinliği süresince Koruyucular, Lily'yi içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini oynarken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_48856_ActivityName = {
    Text = "Kırmızılı Madam"
  },
  Activity_48856_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Kırmızılı Madam\" etkinliği süresince Koruyucular, Sorel'i içeren sistem tarafından önceden ayarlanmış takımı kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarında Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödülü talep edilebilir."
  },
  Activity_49249_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_49249_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_49405_ActivityName = {
    Text = "İtiraf Etkinliği İndirim Kilidi Aktivitesi"
  },
  Activity_49406_ActivityName = {
    Text = "Afinite İki Katı Etkinliği"
  },
  Activity_51127_ActivityName = {
    Text = "Hikâye büyüsü: hafif kopya"
  },
  Activity_51127_ActivityPlot = {
    Text = "Bebek’in verdiği görevler asla basit değildir.\nHerkese defalarca “eğlenin” diye hatırlatmasına rağmen, bir grup Uyanan’ı ilk kez dışarı çıkaran Koruyucu nasıl gergin olmasın?\nAma unutma, “eğlenmek” gerek, tamam mı."
  },
  Activity_51127_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Büyü Yazıtı Dükkanı\" kullanılabilir."
  },
  Activity_51127_ActivityTips = {
    Text = "<Title:Etkinlik Genel Bakış>\n1. \"Hikayelerin Büyüsü\" oynanış etkinliği sınırlı bir süre için geri döndü! Koruyucular, etkinliğe özel Kader Çarkı \"35mm Sihir\" ve etkinliğe özel avatar \"Gümüş Anahtarla: Lily\"yi tekrar elde etmek için \"Sihirli Senaryo Dükkânı\" ve \"Başarım Ödülleri\"ne erişebilir!\n2. Etkinlik süresince, \"Özel Operasyon: Hikayelerin Büyüsü\" sınırlı süreli ücretsiz erişim için kullanılabilir olacaktır.\n\n<Title:Etkinlik Zamanı>\n1. 3 Haziran 9:00'dan 17 Haziran 9:00'a kadar (GMT+8), etkinlik tanıtımındaki tüm içeriklere katılınabilir.\n2. 17 Haziran 9:00'dan 24 Haziran 9:00'a kadar (GMT+8), yalnızca \"Sihirli Senaryo Dükkânı\" ve \"Başarım Ödülleri\" erişilebilir kalacaktır; diğer içerikler sona ermiş olacak ve katılınamayacaktır.\n\n<Title:Senaryo Gizemi>\n1. \"Senaryo Gizemi\" 9 malzeme seviyesinden oluşur, her gün bir seviye otomatik olarak açılır. Açıldıktan sonra, meydan okumak için önceki Özel Operasyon seviyesini temizlemeniz gerekir.\n2. Her meydan okuma 60 Menofin puanı harcar. Başarılı meydan okumalar, etkinlik para birimi \"Sürüklenen İlham\" ve yetiştirme malzemeleri ile ödüllendirilir. Bu etkinlikteki malzeme seviyelerini temizlemek yeniden canlandırmayı destekler.\n3. Seviyeleri daha kolay temizlemek için Mezunlar desteğini ve \"Rezonans: Yönetmen Şifresi\"ni kullanabilirsiniz.\n\n<Title:İlham Bonusu>\n1. Belirli Uyandırıcılara veya Kader Çarklarına sahip olan Koruyucular (takım dizilişinde olması gerekli değildir), \"Senaryo Gizemi\"nin görev ödüllerinde (yeniden canlandırma dahil) \"Sürüklenen İlham\" için ek düşürme bonusu kazanır. Belirli bonuslar aşağıdaki gibidir:\nUyandırıcı \"Lily\": Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSSR Kader Çarkı \"Acıyı Aşmak\": Yığınlama 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSR Kader Çarkı \"35mm Sihir\": Yığınlama 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n2. Farklı Uyandırıcılar veya Kader Çarklarının \"İlham Bonusları\" birikimli olarak hesaplanır.\n\n<Title:Rezonans: Yönetmen Şifresi>\n1. Koruyucular, etkinlik başarımlarını tamamlayarak \"Çıkarım Kalbi\" elde edebilir.\n2. \"Çıkarım Kalbi\" harcayarak \"Rezonans: Yönetmen Şifresi\"ni etkinleştirmek, Koruyucuları \"Senaryo Gizemi\" ve \"Özel Operasyon: Hikayelerin Büyüsü\" etkinlik oynanışında daha güçlü kılar ve \"Senaryo Gizemi\" meydan okumalarını tamamladıktan sonra elde edilen \"Sürüklenen İlham\" ve Afinite ödüllerini artırır.\n\n<Title:Başarım Ödülleri>\n1. Başarım görevlerini tamamlamak, etkinliğe özel avatar \"Gümüş Anahtarla: Lily\", etkinlik para birimi \"Sürüklenen İlham\" ve Gümüş kazandırır.\n2. 25 görev içerir: \"Senaryo Gizemi\"nin her seviyesini bir kez temizlemek, her Diyar takımıyla \"Senaryo Gizemi\"ni 1/2 kez temizlemek, \"Özel Operasyon: Hikayelerin Büyüsü\"ndeki her soruşturma olayını bir kez temizlemek ve tüm etkinlik başarımlarını tamamlamak.\n\n<Title:Özel Operasyon>\n1. Etkinlik süresince, \"Özel Operasyon: Hikayelerin Büyüsü\" ücretsiz olarak açılabilir.\n2. \"Özel Operasyon: Hikayelerin Büyüsü\"nde Koruyucular, hikaye ön ayarı \"Lily\"yi içeren özel bir takım yapılandırması kullanarak meydan okuyacaktır.\n\n<Title:Diriliş Telafisi>\n1. Daha önce \"Özel Operasyon: Hikayelerin Büyüsü\"nü açmış olan Koruyucular, bu diriliş etkinliğinde tekrar açtıklarında \"Sürüklenen İlham\" *1000 telafisi alacaktır.\nDaha önce etkinliğe özel avatar \"Gümüş Anahtarla: Lily\"yi elde etmiş olan Koruyucular, tekrarlanan ödülleri otomatik olarak \"Sürüklenen İlham\" *3000'e dönüştürecektir.\nDaha önce Rezonans etkinleştirme malzemesi \"Çıkarım Kalbi\"ni elde etmiş olan Koruyucular, elde edilen her ek \"Çıkarım Kalbi\"ni otomatik olarak \"Altın Gül\" *5000'e dönüştürecektir.\n"
  },
  Activity_51127_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_51611_ActivityName = {
    Text = "Hikâye Anlatımının Büyüsü"
  },
  Activity_51611_ActivityTips = {
    Text = "<Title:Katılım Koşulları>\n\" Soruşturma Operasyonu\" 2-9'u (Normal) tamamlayarak katılın.\n<Title:Soruşturma Olayı>\nEtkinlik süresince, \"Hikâyelerin Büyüsü\"nden her gün yeni bir soruşturma olayı başlatılacaktır. Koruyucular, envanter tüketmeden kilidini açıp soruşturma yürütebilir. Soruşturma olayını tamamladıktan sonra Saf Çekirdek, Soruşturma Rozeti ve Koruyucu Deneyimi gibi ödüller elde edilebilir.\nEtkinlik sona erdikten sonra, \"Hikâyelerin Büyüsü\"nün soruşturma ilerlemesi korunacaktır. Koruyucular, Özel Görev Kayıtları'nda D-Mücevher harcayarak tamamlanmamış soruşturmaların kilidini açabilir. Etkinlik süresince tamamlanmamış soruşturma olaylarını tamamlamak, etkinlik sırasında verilenlerle tutarlı ödüller kazandıracaktır.<Title:Sınırlı Süreli Ödüller>\nEtkinlik süresince sınırlı süreli ödüller alınabilir olacaktır. Koruyucular, \"Hikâyelerin Büyüsü\"nü (Normal mod) temizleyip soruşturma olaylarını tamamladıktan sonra Saf Çekirdek, Felsefe Taşı ve Gümüş elde edebilir! Sınırlı süreli ödüller yalnızca etkinlik süresince alınabilir, etkinlik sona erdikten sonra tamamlanamaz veya talep edilemez."
  },
  Activity_51888_ActivityName = {Text = "Tahrip Et"},
  Activity_51905_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_51905_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_52040_ActivityName = {
    Text = "Uçurum Kurbanı"
  },
  Activity_52040_ActivityPlot = {
    Text = "Derin okyanusun yansısında, Kralı’nın düşü dağılır ve Tanrı Diyarı çürür.\nKadim düşlerden sıyrılıp, çöken bir geleceğin harabelerine adım atar.\nUçuruma soru sorar, ama Uçurum suskun kalır.\nUçuruma kurbanlar sunar, yalnızca kendi yankısını duyar."
  },
  Activity_52040_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Uçurumdan Gelen Yanıt\" kullanılabilir."
  },
  Activity_52040_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Koruyucular, süreli oyunlar \"İlahi Âlemin Zuhuru\", \"Kralın Fermanı\" ve \"Başarı Ödülleri\" üzerinden etkinlik parası toplayabilir. Etkinlik parası, \"Uçurum Yankısı\"nda, etkinliğe özel SR Kader Çarkı \"Derinliğin Çağrısı\", Felsefe Taşı, Saf Çekirdek ve Lümen Çekirdeği dâhil eşya ödülleri elde etmek için kullanılabilir.\n2. \"Düş Diyarı: Hürmetsizlik\" etkinlik süresince serbestçe erişilebilir olacaktır.\n\n<Title:Etkinlik Süresi>\n1. 17 Haziran 9:00’dan 1 Temmuz 9:00’a kadar (GMT+8) tüm etkinlik içeriği alınabilir olacaktır.\n2. 1 Temmuz 9:00’dan 8 Temmuz 9:00’a kadar (GMT+8) yalnızca \"Uçurum Yankısı\" ve \"Başarı Ödülleri\" alınabilir olacak; diğer içeriklere erişilemeyecektir.\n\n<Title:İlahi Âlemin Zuhuru>\n1. \"İlahi Âlemin Zuhuru\" 5 aşamadan oluşur, her 2 günde bir aşama açılır.\n2. Her meydan okuma 120 Menofin’e mal olur ve başarılı meydan okumalar etkinlik parası \"Adak Sunucunun Gözyaşları\", \"Adak Sunucunun Kanı\" ve \"Adak Sunucunun İliği\" kazandırır. Çift ödül için 240 Menofin gereklidir; görev ödülleri ikiye katlanırken, Afinite ödülleri değişmeden kalır.\n3. %100 \"Başarı Ödülleri\"ne ulaştıktan sonra, temizlenmiş aşamalar için \"Yeniden Canlandır\" işlevini açarsınız. Her \"Yeniden Canlandırma\" 120 Menofin tüketir. Not: \"Yeniden Canlandırma\" ile Afinite kazanılmaz.\n4. Aşamaları temizlemeye yardımcı olmak için Mezun yardımı ve \"Rezonans: Uçurum Ayini\"ni kullanabilirsiniz.\n\n<Title:Sunu Bonusu>\n1. Koruyucuların sahip olduğu belirli Uyananlar veya Kader Çarkları (sahaya sürülmeleri gerekmez), \"İlahi Âlemin Zuhuru\"nda (yeniden canlandırma dâhil) \"Adak Sunucunun Gözyaşları\", \"Adak Sunucunun Kanı\" ve \"Adak Sunucunun İliği\"nin düşme oranını artırır. Bonuslar şöyledir:\nUyanan \"Miryam\": Aydınlanma 0/1/2/3+; Bonus %20/%30/%40/%50\nSSR Kader Çarkı \"Sadık Güç\": Güçlendirme 0/1/2/3+; Bonus %20/%30/%40/%50\nSR Kader Çarkı \"Derinliğin Çağrısı\": Güçlendirme 0/1/2/3+; Bonus %20/%30/%40/%50\n2. Farklı Uyananlar veya Kader Çarklarından gelen bonuslar üst üste eklenir.\n\n<Title:Rezonans: Uçurum Ayini>\n1. Koruyucular, etkinlik başarılarını tamamlayarak \"Sadık Kalp\" elde edebilir.\n2. \"Sadık Kalp\" kullanarak \"Rezonans: Uçurum Ayini\"ni etkinleştirmek şu bonusları sağlar:\n(1) \"İlahi Âlemin Zuhuru\"ndaki Koruyucuları Güçlendirme, meydan okumaları kolaylaştırır.\n(2) \"İlahi Âlemin Zuhuru\" meydan okumalarından elde edilen etkinlik parasını artırma.\n(3) \"Kralın Fermanı\" adlı etkinlik oyununu açma.\n\n<Title:Kralın Fermanı>\n\"Sunu Sınavı\" rezonansını etkinleştirmek, her saat 60 \"Adak Sunucunun Gözyaşları\" kazandırır ve en fazla 25 saate kadar birikir.\n\n<Title:Uçurum Yankısı>\n1. \"Uçurum Yankısı\" üç sunak içerir ve şu şekilde açılır:\n\"Gözyaşları Sunak\": 17 Haziran 9:00’da açılır.\n\"Kan Sunak\": 19 Haziran 9:00’da açılır.\n\"Ruhlar Sunak\": 21 Haziran 9:00’da açılır.\n2. Her sunu, 500 \"Adak Sunucunun Gözyaşları\"/\"Adak Sunucunun Kanı\"/\"Adak Sunucunun İliği\" tüketir ve sunaktan rastgele beş eşya ödülü verir.\n3. Her sunağın eşya ödülleri \"İlahi Âlemin Kutsamaları\" ve \"Sıradan Ödüller\" olarak sınıflandırılır. Sıfırlama, belirli eşya miktarlarını yenileyebilir:\n(1) İlk iki sıfırlama: \"İlahi Âlemin Kutsamaları\" tükendiğinde, Koruyucular sıfırlamayı seçebilir; bu, \"İlahi Âlemin Kutsamaları\" ve \"Sıradan Ödüller\"in miktarlarını yeniler; \"Sıradan Ödüller\" tükenene kadar sunulara devam edilebilir, sonrasında devam etmek için sıfırlama gerekir.\n(2) Üçüncü sıfırlamadan itibaren: Sıfırlama yalnızca \"Sıradan Ödüller\"i yeniler, \"İlahi Âlemin Kutsamaları\" yenilenmez.\n\n<Title:Düş Diyarı>\n1. \"Düş Diyarı\", tipik hikâye oynanışından çok metinsel temsile vurgu yapan yeni bir soruşturma türüdür.\n2. \"Düş Diyarı: Hürmetsizlik\"te, Miryam’ın ruhuyla bağ kurarak onun anılarını okuyacak, Lemurya’daki çocukluk mücadelelerine, inancının doğurduğu şaşkınlık ve çırpınışlarına ve bir kurtarıcı ve Yıkımcı’ya dönüşen yoluna tanıklık edeceksiniz...\n3. \"Düş Diyarı: Hürmetsizlik\" etkinlik süresince ücretsiz olacaktır. Her 2 günde bir yeni olaylar başlayacak ve burayı temizlemek, yalnızca etkinlik süresince alınabilen Gümüş ve etkinliğe özel SR Kader Çarkı \"Derinliğin Çağrısı\"nı Başarı Ödülleri içinde kazandıracaktır.\n4. Etkinlikten sonra, \"Düş Diyarı: Hürmetsizlik\" ilerlemesi korunacaktır. Etkinlik sırasında açılmadıysa, etkinlik sonrası 7 \"Gerçeklik Sınırı\" kullanılarak açılabilir.\n5. Etkinlik süresinden bağımsız olarak, \"Düş Diyarı: Hürmetsizlik\"i temizlemek bir \"Çete: Deniz Kurbanı\" kazandırır.\n\n\n\n"
  },
  Activity_52040_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_53727_ActivityName = {
    Text = "Okula Dönüş Günü"
  },
  Activity_53727_ActivityTips = {
    Text = "<Title:Etkinlik Tanıtımı>\n\"Okula Dönüş Günü\" görevleri 4 gruba ayrılmıştır ve etkinliğin 1., 2., 3. ve 4. günlerinde açılır.\nKoruyucular, \"Okula Dönüş Günü\" görevlerini tamamlayarak \"Okula Dönüş Davetiyesi\" elde edebilir.\n\"Okula Dönüş Davetiyesi\" kullanarak Koruyucular, \"Okula Dönüş Mağazası\"nda cömert ödüller alabilir."
  },
  Activity_53728_ActivityName = {
    Text = "Hacı Yolu Yardımı"
  },
  Activity_53728_ActivityTips = {
    Text = "<Title:Etkinlik Genel Bakış>\n \"Hacı Yolu Yardımı\" etkinliği süresince, Koruyucular \"İksir Tavlama,\" \"Kaotik Kalıntı,\" \"Uçurum Kalıntısı,\" \"Kanlı Kalıntı,\" \"Kozmik Kalıntı,\" \"Kaos Kümesi,\" \"Pohnpei Harabeleri,\" \"Solucan Yuvası\" ve \"Schwarzschild Boğazı\" bölümlerini tamamladıktan sonra çift Altın Gül ve malzeme ödülü alacaktır. Her gün toplam 6 çift ödül hakkından yararlanılabilir.\nGün içinde kullanılmayan çift ödül hakları ertesi gün saat 09:00'da (GMT+8) sıfırlanacaktır. Koruyucular, lütfen bunları zamanında kullanmayı unutmayın!"
  },
  Activity_53729_ActivityName = {
    Text = "Okula Dönüş Girişi"
  },
  Activity_53729_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\nKoruyucular, her gün giriş yaptıktan sonra \"Okula Dönüş Raporu\"nda günlük giriş ödülünü talep edebilir.\nÖdüller, Koruyucuların toplam giriş sayısına göre sırayla açılacak ve günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_53829_ActivityName = {
    Text = "Güle Mektup"
  },
  Activity_53829_ActivityPlot = {
    Text = "Göz alıcı altın elmaslar, göz kamaştıran inciler...\nSayısız lüks süs ona bir imparatoriçe olduğu yanılsamasını verdi.\nŞimdi, bu yanılsamayı sonsuza dek korumaya kararlı."
  },
  Activity_53829_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Altın Kırmızı Kutlama\" kullanılabilir."
  },
  Activity_53829_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, süreli oynanış \"Gül Anıları\" ve \"Başarı Ödülleri\" aracılığıyla \"Ruh Kuşu Yelpazeleri\" adlı etkinlik parasını toplayabilir. \"Ruh Kuşu Yelpazeleri\", \"Altın Kutlama\"da etkinliğe özel SR Kader Çarkı \"Milyon Sevgi Dolu Bakış\", Saf Çekirdek, Lümen Çekirdeği, Eter Taşı Kırıntıları, Taklit Kristalleri ve daha fazlasıyla takas edilebilir.\n2. Etkinlik süresince \"Başarı Ödülleri\" görevlerini tamamlamak, etkinliğe özel avatar \"Gümüş Anahtar Adına: Sorel\", etkinliğe özel SR Kader Çarkı \"Milyon Sevgi Dolu Bakış\", Gümüş ve bol miktarda etkinlik parası \"Ruh Kuşu Yelpazeleri\" kazandırır.\n3. Etkinlik süresince \"Özel Görev Raporu: Gül Ağıdı\" ücretsiz erişime açılacaktır.\n\n<Title:Etkinlik Süresi>\n1. 1 Temmuz 9:00’dan 15 Temmuz 9:00’a kadar (GMT+8) tüm etkinlik içeriği kullanılabilir.\n2. 15 Temmuz 9:00’dan 22 Temmuz 9:00’a kadar (GMT+8) yalnızca \"Altın Kutlama\" ve \"Başarı Ödülleri\" erişilebilir kalacak; diğer içeriklere artık erişilemeyecektir.\n\n<Title:Gül Anıları>\n1. \"Gül Anıları\" 9 aşamadan oluşur; her gün bir aşama açılır.\n2. Her meydan okuma 120 Menofin tüketir; farklı malzemelerle birlikte etkinlik parası \"Ruh Kuşu Yelpazeleri\" verir.\n3. Bu etkinliğin aşamaları doğrudan savaş malzeme aşamalarıdır. Temizlendiklerinde \"Tekrar Oynat\" özelliği açılır! Her \"Tekrar Oynat\" 120 Menofin tüketir.\n4. Not: \"Tekrar Oynat\" kullanmak Yakınlık kazandırmaz.\n\n<Title:Yelpaze Güçlendirmeleri>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olmak (savaşa sürülmeleri gerekmez), \"Gül Anıları\" aşamalarından (tekrar oynatmalar dâhil) düşen \"Ruh Kuşu Yelpazeleri\"ni aşağıdaki şekilde artırır:\nUyanan \"Sorel\": Aydınlanma 0/1/2/3+, güçlendirme %20/%30/%40/%50\nSSR Kader Çarkı \"Gül Adına\": Yığın Sv. 0/1/2/3+, güçlendirme %20/%30/%40/%50\nSR Kader Çarkı \"Milyon Sevgi Dolu Bakış\": Yığın Sv. 0/1/2/3+, güçlendirme %20/%30/%40/%50\n2. Farklı Uyananlar veya Kader Çarklarından gelen Yelpaze Güçlendirmeleri birbirine eklenir.\n\n<Title:Özel Görev Raporu>\n1. Etkinlik süresince, daha önce \"Özel Görev Raporu: Gül Ağıdı\"nı açmış olan Muhafızlar, yeniden kilitleme sırasında 600 \"Ruh Kuşu Yelpazesi\" telafisi alacaktır.\n2. \"Gül Ağıdı\"nda Muhafızlar, önceden belirlenmiş hikâye \"Sorel\" ile özel bir kadro kullanarak meydan okumalara girer.\n"
  },
  Activity_53829_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_54375_ActivityName = {
    Text = "Güle Övgü"
  },
  Activity_54375_ActivityPlot = {
    Text = "Bayanlar ve baylar.\nYumuşak gece perdesini araladı—en seçkin içkinizi hazırlayın.\nBu uzun bir hikâye. İzin verin, onu ağır ağır anlatalım."
  },
  Activity_54375_ActivityTips = {
    Text = "<Title:Katılım Koşulları>\n\"Soruşturma Operasyonu\" 2-9 (Normal) tamamlanarak katılım sağlanabilir.\n<Title:Soruşturma Etkinliği>\nEtkinlik süresince, \"Güle Saygı\" bölümünden her gün yeni bir soruşturma etkinliği başlatılacaktır. Koruyucular envanter harcamadan kilitleri açabilir ve soruşturma yapabilir. Soruşturma etkinliğini tamamladıktan sonra Saf Çekirdek, Soruşturma Rozeti ve Koruyucu Deneyimi gibi ödüller elde edilebilir.\nEtkinlik sona erdikten sonra \"Güle Saygı\" soruşturma ilerlemesi korunacaktır ve Koruyucular, Özel Operasyonlarda D-Mücevher harcayarak tamamlanmamış soruşturmaların kilidini açabilir. Etkinlik süresince tamamlanmamış soruşturma etkinliklerini tamamlamak da etkinlik sırasındakilerle tutarlı ödüller verecektir.<Title:Sınırlı Süreli Ödüller>\nEtkinlik süresince sınırlı süreli ödüller mevcut olacaktır. Koruyucular, \"Güle Saygı\" (Normal) modunu tamamladıktan ve \"Güle Saygı\" soruşturma etkinliklerini bitirdikten sonra Saf Çekirdek, Felsefe Taşı ve Gümüş elde edebilir! Sınırlı süreli ödüller yalnızca etkinlik süresince geçerlidir ve etkinlik sona erdikten sonra tamamlanamaz veya talep edilemez."
  },
  Activity_54402_ActivityName = {
    Text = "Disosiyatif Hasta: Kaos"
  },
  Activity_54402_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Disosiyatif Hasta: Kaos\" etkinliği süresince Koruyucular, \"24\"ü içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini oynarken takım kadrosundaki Uyandırıcıda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra etkinlik arayüzünden demo ödüllerini talep edebilirsiniz."
  },
  Activity_54403_ActivityName = {
    Text = "Kapının Anahtarı"
  },
  Activity_54403_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Kapının Anahtarı\" etkinliği süresince Koruyucular, Tawil'i içeren sistem tarafından önceden ayarlanmış takımı kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarında Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödülü talep edilebilir."
  },
  Activity_54404_ActivityName = {
    Text = "Hayırsever Başrahip"
  },
  Activity_54404_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n \"Merhemlerin Piskoposu\" etkinliği süresince Koruyucular, Salvador'u içeren sistem tarafından önceden ayarlanmış takım dizilişini kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcı değiştirilemez. \n<Title:Etkinlik Ödülleri>\n Aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_54405_ActivityName = {
    Text = "Disosiyatif Hasta: Ultra"
  },
  Activity_54405_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Disosiyatif Hasta: Ultra\" etkinliği süresince Koruyucular, \"24\"ü içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_54406_ActivityName = {
    Text = "Denizin Havarisi"
  },
  Activity_54406_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Denizin Havarisi\" etkinliği süresince Koruyucular, Miryam'ı içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_54407_ActivityName = {
    Text = "Ebedi Sanatçı"
  },
  Activity_54407_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Ebedi Sanatçı\" etkinliği süresince Koruyucular, Hameln'i içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_54408_ActivityName = {
    Text = "Ruh Biçicisi"
  },
  Activity_54408_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Ruh Biçicisi\" etkinliği süresince Koruyucular, Helot-catena'yı içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden demo ödüllerini talep edebilir."
  },
  Activity_54409_ActivityName = {
    Text = "Disosiyatif Hasta: Aequor"
  },
  Activity_54409_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Disosiyatif Hasta: Aequor\" etkinliği süresince Koruyucular, \"24\"ü içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini oynarken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_54410_ActivityName = {
    Text = "Disosiyatif Hasta: Caro"
  },
  Activity_54410_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Disosiyatif Hasta: Caro\" etkinliği süresince Koruyucular, \"24\"ü içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_54411_ActivityName = {
    Text = "Çürümüş Beyin"
  },
  Activity_54411_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Çürümüş Beyin\" etkinliği süresince Koruyucular, \"Doll: Cehennem\"i içeren sistem tarafından belirlenen takımı kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini denerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez tamamladıktan sonra etkinlik arayüzünden demo ödüllerini talep edebilirsiniz."
  },
  Activity_54521_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_54521_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_54522_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_54522_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_54523_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_54523_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_54524_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_54524_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_54525_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_54525_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_54526_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_54526_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_54527_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_54527_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_54596_ActivityName = {
    Text = "Bilgi Armağanı"
  },
  Activity_54596_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Belirlenen etkinlik görevlerini tamamladıktan sonra Koruyucular; Protoparadise, Dönüşüm Kitabı, Prototip Ufuk, Döngü Ustası, Yeniden Doğuş Çekirdeği, Kader Geri Sarma Çekirdeği gibi cömert ödüllerin yanı sıra Solmuş Miras sınırlı Uyandırıcılar ve Kader Çarkları, Astral Saltanat sınırlı Uyandırıcılar ve Kader Çarkları ile etkinliğe özel avatar çerçevesi \"Gümüş Matris\", Koruyucu Deneyimi artışları ve diğer özel ödülleri talep edebilir!\n2. Bu etkinlik kalıcı olarak mevcuttur. Tüm görevler tamamlanıp tüm ödüller talep edildikten sonra etkinlik sona erecek ve ertesi gün saat 9:00'dan (GMT+8) itibaren artık görüntülenmeyecektir.\n\n<Title:Yüce Haraç>\n1. Belirlenen etkinlik görevlerini tamamlamak, Koruyucu Deneyimi kazanımını en fazla %100'e kadar hızlandıran \"Yüce Haraç\" Etkisini verir. Birden fazla \"Yüce Haraç\" Etkisi aynı anda aktif olduğunda, en yüksek hızlandırma Etkisi uygulanır.\n2. Daha yüksek seviyeli bir \"Yüce Haraç\" Etkisi açıldığında veya elde edildiğinde, hızlandırma oranına ve hızlandırma için uygun mevcut toplam Koruyucu Deneyimine göre anında bonus Koruyucu Deneyimi verilecektir.\n3. \"Yüce Haraç\" açıldıktan sonra, Koruyucu her Koruyucu Deneyimi kazandığında, hızlandırma oranına karşılık gelen ek Koruyucu Deneyimi de kazanılacaktır.\n4. Lütfen \"Yüce Haraç\"tan elde edilen bonus Koruyucu Deneyiminin, hızlandırma için uygun toplam Koruyucu Deneyimine dahil edilmeyeceğini unutmayın.\n5. Hızlandırma için uygun mevcut toplam Koruyucu Deneyimi: {s1}.\n6. Hızlandırmadan elde edilen toplam bonus Koruyucu Deneyimi: {s2} ({s3}%)."
  },
  Activity_55110_ActivityName = {
    Text = "Bahar Solmadan Önce"
  },
  Activity_55110_ActivityPlot = {
    Text = "Ateş başlamadan önce kız çocukların kahkahaları bahçede yankılanır.\nBu güzel geçmiş için dur biraz, dostum.\nSolmamış baharın öykülerini dinle, usulca anlatılan."
  },
  Activity_55110_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Colette'in Çiçek Evi\" alınabilir."
  },
  Activity_55110_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince, Muhafızlar sınırlı süreli “Garden Memories”, “Muse's Kiss” ve “Başarı Ödülleri” oynanışları aracılığıyla üç tür “Şiir” toplayabilir. Şiirler, “Colette's Flowerhouse”ta etkinliğe özel SR Kader Çarkı “Geçmişin Çiçekleri ve Şiirleri”, Saf Çekirdek, Işıyan Çekirdek, Eter Taşı Kırıntısı, Taklit Kristali vb. eşya ödülleriyle takas edilebilir.\n2. “Task Record: Rose Habitat” etkinlik boyunca ücretsiz erişime açık olacaktır.\n\n<Title:Etkinlik Süresi>\n1. 15 Temmuz 9:00 - 29 Temmuz 9:00 (GMT+8): Tüm etkinlik içerikleri erişime açık.\n2. 29 Temmuz 9:00 - 5 Ağustos 9:00 (GMT+8): Yalnızca “Colette's Flowerhouse” ve “Başarı Ödülleri” erişime açık kalır; diğer içerikler sona erer.\n\n<Title:Garden Memories>\n1. “Garden Memories” 5 bölümden oluşur; her bölüm 2 günde bir açılır.\n2. Her meydan okuma 120 Menophin tüketir. Başarılı meydan okumalar, etkinlik parası “Hüzün Şiirleri”, “Pişmanlık Şiirleri” ve “Neşe Şiirleri” kazandırır.\n3. Bir bölümü temizledikten sonra “Tekrar Oynat” işlevi açılır. Not: “Tekrar Oynat” Yakınlık kazandırmaz.\n4. Mezun yardımı ve “Rezonans: Garden Elegy” bölümleri daha kolay temizlemenize yardımcı olabilir.\n5. Bir bölüm açıldıktan sonraki ikinci günde, o bölüm için Delilik Zorluğu açılır. Delilik Zorluğu’nun ilk kez temizlenmesi, bol miktarda etkinlik parası ödülü verir.\n6. Not: Delilik Zorluğu Menophin tüketmez, yeniden oynanamaz ve ilk temizlemeden sonraki meydan okumalar için etkinlik parası vermez.\n\n<Title:Şiir Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan Muhafızlar (savaşa sürülmeleri gerekmez), “Garden Memories” bölüm ödüllerinden (Tekrar Oynat modu dahil) “Hüzün Şiirleri”, “Pişmanlık Şiirleri” ve “Neşe Şiirleri” için bonus düşüş elde eder. Bonuslar şöyledir:\nUyanan “Horla”: Aydınlanma 0/1/2/3+, Bonus %20/%30/%40/%50\nSSR Kader Çarkı “Son Dize”: Yığın 0/1/2/3+, Bonus %20/%30/%40/%50\nSR Kader Çarkı “Geçmişin Çiçekleri ve Şiirleri”: Yığın 0/1/2/3+, Bonus %20/%30/%40/%50\n2. Farklı Uyananlar veya Kader Çarklarından gelen bonuslar üst üste biner.\n3. Özellikle, Delilik Zorluğu’nun ilk temizleme ödülleri Şiir Bonusu’ndan etkilenmez.\n\n<Title:Rezonans: Garden Elegy>\n1. Muhafızlar, etkinlik başarılarını tamamlayarak “Küllerin Kalbi” elde edebilir.\n2. “Küllerin Kalbi” tüketerek “Rezonans: Garden Elegy”yi etkinleştirmek aşağıdaki bonusları sağlar:\n(1) “Garden Memories”te Muhafızları güçlendirerek meydan okumaları kolaylaştırır.\n(2) “Garden Memories” meydan okumalarından elde edilen etkinlik parası ödüllerini artırır.\n(3) “Muse's Kiss” etkinlik oynanışını açar.\n\n<Title:Muse's Kiss>\n“Rezonans: Everything Grows” etkinleştirildikten sonra, her saat otomatik olarak 60 “Hüzün Şiirleri” elde edilir; en fazla 25 saat birikebilir.\n“Rezonans: Exchange Poem for Flower” etkinleştirildikten sonra, “Muse's Kiss” her saat ayrıca 60 “Pişmanlık Şiirleri” de üretir.\n\n<Title:Colette's Flowerhouse>\n1. “Colette's Flowerhouse”ta açılış zamanları aşağıdaki gibi olan üç bahçe bulunur:\n“Iris garden”: 15 Temmuz 9:00’da açılır.\n“Platycodon Flower Bed”: 17 Temmuz 9:00’da açılır.\n“Rose garden”: 19 Temmuz 9:00’da açılır.\n2. Her takas, 1000 “Hüzün Şiirleri”/“Pişmanlık Şiirleri”/“Neşe Şiirleri” tüketir ve bahçeden rastgele beş eşya ödülü verir.\n3. Her bahçenin eşya ödülleri “Özel Eşyalar” ve “Sıradan Eşyalar” olarak ayrılır. Sıfırlama, kalan özel eşyaların miktarını geri yükler; kurallar şöyledir:\n(1) İlk 2 sıfırlama: Hiç “Özel Eşya” kalmadığında, Muhafızlar sıfırlamayı seçebilir; bu, kalan “Özel” ve “Sıradan Eşyalar”ın miktarlarını geri yükler; Muhafızlar takasa devam etmeyi de seçebilir. Hiç “Sıradan Eşya” kalmadığında, takasa devam etmek için sıfırlama zorunludur.\n(2) 3. sıfırlamadan itibaren: Sıfırlama yalnızca hiç “Sıradan Eşya” kalmadığında yapılabilir; bu, yalnızca “Sıradan Eşyalar”ı geri yükler; “Özel Eşyalar” sıfırlanmaz.\n4. 5 Ağustos 9:00’da (GMT+8), kullanılmamış “Şiirler” her 200 Şiir için 5000 “Rose Scrip”e dönüştürülerek oyun içi posta yoluyla gönderilir.\n\n<Title:Task Record>\n1. “Task Record: Rose Habitat” etkinlik boyunca ücretsiz erişime açık olacaktır. Her 2 günde bir yeni bir etkinlik başlar. “Task Record: Rose Habitat”ı temizlemek, Başarı Ödülleri’nde Gümüş, etkinliğe özel SR Kader Çarkı “Geçmişin Çiçekleri ve Şiirleri” vb. kazandırır. Başarı ödülleri yalnızca etkinlik süresince erişilebilir; etkinlik sona erdikten sonra tamamlanamaz veya talep edilemez.\n2. Etkinlikten sonra, “Task Record: Rose Habitat”ın soruşturma ilerlemesi korunur. “Task Record: Rose Habitat” etkinlik sırasında kilidi açılmamışsa, etkinlikten sonra 7 “Reality Verge” harcayarak yine de kilidi açılabilir.\n3. Etkinlik süresinden bağımsız olarak, “Task Record: Rose Habitat”ı temizlemek “Posse: Spring's Verse” kazandırır."
  },
  Activity_55110_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_55457_ActivityName = {
    Text = "Dingin Bölünme"
  },
  Activity_56427_ActivityName = {
    Text = "Ruh Çobanı: Tekrar"
  },
  Activity_56427_ActivityPlot = {
    Text = "Senin için acı çekti, felaketlerini üstlendi.\nOnun bedeniyle şifa buldun;\nOnun hayatıyla bağışlandın"
  },
  Activity_56427_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Kilise Hayır Satışı\" kullanılabilir."
  },
  Activity_56427_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, süreli “Kilise Yolu”, “Sivil İyi Niyet” ve “Başarı Ödülleri” etkinliklerine katılarak etkinlik para birimi “Hayır Kuponları”nı toplayabilir. “Hayır Kuponları”, “Kilise Hayır Pazarı”nda rastgele eşyalarla takas edilebilir; bu eşyalar arasında etkinliğe özel SR Kader Çarkı “Aynadaki Adam”, Saf Çekirdek, Lümen Çekirdeği vb. bulunur.\n2. Etkinlik süresince “Özel Kayıt: Kanın Rengi”ne ücretsiz erişim sağlanacaktır. Etkinlik başarılarını tamamlamak, ayrıca etkinliğe özel avatar “Gümüş Anahtar Adına: Salvador”u kazandırır!\n\n<Title:Etkinlik Süresi>\n1. 26 Ağustos 09:00’dan 9 Eylül 09:00’a kadar (GMT+8) tüm etkinlik içerikleri erişime açık olacaktır.\n2. 9 Eylül 09:00’dan 16 Eylül 09:00’a kadar (GMT+8) yalnızca “Kilise Hayır Pazarı” ve “Başarı Ödülleri” erişilebilir olacak, diğer içerikler sona erecek ve kullanılamayacaktır.\n\n<Title:Kilise Yolu>\n1. “Kilise Yolu” 5 seviyeden oluşur; her 2 günde bir seviye açılır.\n2. Her meydan okuma 120 Menophin tüketir. Meydan okumayı başarıyla tamamlamak size “Hayır Kuponları” kazandırır.\n3. Bir seviye temizlendikten sonra o seviyenin “Tekrar Oynat” özelliği açılır. Not: “Tekrar Oynat” özelliğini kullanmak Yakınlık kazandırmaz.\n4. Seviyeleri daha kolay temizlemek için Mezun desteğini ve “Rezonans: Ruhun Çatalı”nı kullanabilirsiniz.\n\n<Title:Parıltı Güçlendirmesi>\n1. “Ruhun Parıltısı”nın etkisi altında, belirli Uyananlara veya Kader Çarklarına sahip Muhafızlar (sahaya sürülmeleri gerekmez), “Kilise Yolu” seviye ödüllerinden (Tekrar Oynat dâhil) ek “Hayır Kuponu” düşüşü elde edebilir. Özel güçlendirmeler şöyledir:\nUyanan “Salvador”: Aydınlanma 0/1/2/3 ve üzeri, güçlendirme %20/%30/%40/%50.\nSSR Kader Çarkı “Kutsal Yazıt Levhası”: Yığın 0/1/2/3 ve üzeri, güçlendirme %20/%30/%40/%50.\nSR Kader Çarkı “Aynadaki Adam”: Yığın 0/1/2/3 ve üzeri, güçlendirme %20/%30/%40/%50.\n2. Farklı Uyananların veya Kader Çarklarının “Parıltı Güçlendirmesi” etkilere eklenir.\n3. Özellikle, Delilik Zorluğu meydan okumasının ilk tamamlama ödülü “Parıltı Güçlendirmesi”nden etkilenmez.\n\n<Title:Rezonans: Ruhun Çatalı>\n1. Muhafızlar, etkinlik başarılarını tamamlayarak “Tövbe Kalbi” elde edebilir.\n2. “Tövbe Kalbi”ni kullanarak “Rezonans: Ruhun Çatalı”nı etkinleştirin ve şu güçlendirmeleri kazanın:\n(1) Muhafızları “Kilise Yolu” ve “Özel Kayıt: Kanın Rengi” etkinliklerinde güçlendirerek meydan okumaları kolaylaştırır.\n(2) “Kilise Yolu” meydan okumalarını tamamladıktan sonra kazanılan Yakınlığı artırır.\n(3) “Sivil İyi Niyet” etkinliğini etkinleştirir.\n\n<Title:Sivil İyi Niyet>\n1. “Kolay Yöntem” rezonansını etkinleştirdikten sonra, saatte otomatik olarak 60 “Hayır Kuponu” alırsınız; en fazla 25 saatlik stok birikebilir.\n2. “Kefaret, Kefaret” rezonansını etkinleştirdikten sonra, ek olarak saatte 1800 Gül Senedi alırsınız.\n\n<Title:Kilise Hayır Pazarı>\n1. “Kilise Hayır Pazarı”nda üç dükkân vardır ve şu zamanlarda açılır:\n“Bayan Gray’in Küçük Dükkânı”: 26 Ağustos 09:00’da açılır.\n“Büyük John’un Harikalar Pazarı”: 29 Ağustos 09:00’da açılır.\n“Smith’in Satışları”: 1 Eylül 09:00’da açılır.\n2. Her takas 1000 “Hayır Kuponu” tüketir ve dükkândan rastgele beş eşya verir.\n3. Her dükkânın eşya ödülleri “Özel Eşyalar” ve “Sıradan Eşyalar” olarak ikiye ayrılır. Sıfırlama kuralları şöyledir:\n(1) İlk 2 sıfırlama: “Özel Eşyalar” tükendiğinde, Muhafızlar sıfırlamayı seçebilir; bu, hem “Özel Eşyalar”ın hem de “Sıradan Eşyalar”ın stoklarını yeniler. Ayrıca takasa devam edebilirsiniz; “Sıradan Eşyalar” tükendiğinde, takasa devam etmek için sıfırlama zorunlu hâle gelir.\n(2) 3. sıfırlamadan itibaren: Sıfırlama yalnızca “Sıradan Eşyalar” tükendiğinde yapılabilir. Bu, “Sıradan Eşyalar”ın stoklarını yeniler, ancak “Özel Eşyalar” artık sıfırlanmaz.\n4. 16 Eylül 09:00’dan (GMT+8) sonra kalan “Hayır Kuponları”, 200 kupon başına 5000 Gül Senedi oranıyla geri dönüştürülecektir. Ayrıntılar için lütfen posta kutunuzu kontrol edin.\n\n<Title:Özel Kayıt>\n1. “Özel Kayıt: Kanın Rengi” etkinlik süresince ücretsiz olacaktır.\n2. Etkinlik sonrasında “Özel Kayıt: Kanın Rengi” için Soruşturma ilerlemesi korunur. Etkinlik sırasında açılmazsa, sonrasında 7 “Gerçeklik Sınırı” harcanarak açılabilir.\n3. Etkinlik sırasında olsun ya da olmasın, “Özel Kayıt: Kanın Rengi”ni temizlemek “Çete: Mucizenin Şafağı” ödülünü verir.\n\n<Title:Yeniden Baskı Telafisi>\n1. Daha önce “Özel Kayıt: Kanın Rengi”ni açmış olan Muhafızlar, bu yeniden baskı etkinliğinde tekrar açmaları hâlinde 700 “Hayır Kuponu” telafi alacaktır.\n2. Daha önce etkinliğe özel avatar “Gümüş Anahtar Adına: Salvador”u elde etmiş olan Muhafızlar, yeniden elde etmeleri durumunda 2000 “Hayır Kuponu” telafi alacaktır.\n3. Daha önce etkinleştirme malzemesi “Tövbe Kalbi”ni elde etmiş olan Muhafızlar, her fazla “Tövbe Kalbi” için 5000 Gül Senedi alacaktır."
  },
  Activity_56427_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_56428_ActivityName = {
    Text = "Uçurum Kurbanı: Tekrar"
  },
  Activity_56428_ActivityPlot = {
    Text = "Derin okyanusun yansısında, Kralı’nın düşü dağılır ve Tanrı Diyarı çürür.\nKadim düşlerden sıyrılıp, çöken bir geleceğin harabelerine adım atar.\nUçuruma soru sorar, ama Uçurum suskun kalır.\nUçuruma kurbanlar sunar, yalnızca kendi yankısını duyar."
  },
  Activity_56428_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Uçurumdan Gelen Yanıt\" kullanılabilir."
  },
  Activity_56428_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli modlar olan “İlahi Diyarın İnişi”, “Kralın Fermanı” ve “Başarı Ödülleri” aracılığıyla etkinlik para birimi toplayabilir. Etkinlik para birimi, “Derinlerin Yankısı”nda etkinlik sınırlı SR Kader Çarkı “Derinliğin Çağrısı”, Felsefe Taşı, Saf Çekirdek ve Lümen Çekirdeği de dâhil olmak üzere eşya ödülleri almak için kullanılabilir.\n2. Etkinlik süresince “Düş Diyarı: Desecra”ya erişim ücretsiz olacaktır. Etkinlik başarımlarını tamamlayarak etkinliğe özel avatar “Gümüş Anahtar Adına: Miryam”ı elde edebilirsiniz!\n\n<Title:Etkinlik Süresi>\n1. 4 Kasım 9:00 – 18 Kasım 9:00 (GMT+8) arasında, tüm etkinlik içeriklerine erişilebilir.\n2. 18 Kasım 9:00 – 25 Kasım 9:00 (GMT+8) arasında yalnızca “Derinlerin Yankısı” ve “Başarı Ödülleri” erişilebilir durumda kalır; diğer içerikler sona erer.\n\n<Title:İlahi Diyarın İnişi>\n1. “İlahi Diyarın İnişi” 5 aşamadan oluşur, her 2 günde bir aşama açılır.\n2. Her meydan okuma 120 Menophin tüketir; başarı, etkinlik para birimi kazandırır.\n3. Bir aşama temizlendiğinde o aşama için “Tekrar Oynat” işlevi açılır. Not: “Tekrar Oynat” kullanmak yakınlık kazandırmaz.\n4. Mezun yardımlarını ve “Rezonans: Derinlerin Ayini”ni kullanarak aşamaları daha kolay temizleyin.\n\n<Title:Adak Bonusları>\n1. Belirli Uyanmışlara veya Kader Çarklarına sahip olmak (savaşa sokmaya gerek yoktur), “İlahi Diyarın İnişi” aşamalarında (tekrar oynatmalar dâhil) “Adak Sunucunun Gözyaşları”, “Adak Sunucunun Kanı” ve “Adak Sunucunun İliği”nin fazladan düşmesini sağlar. Bonuslar şöyledir:\nUyanmış “Miryam”: Aydınlanma 0/1/2/3+, bonus %20/%30/%40/%50\nSSR Kader Çarkı “İnançlı Kudret”: Yığın seviyesi 0/1/2/3+, bonus %20/%30/%40/%50\nSR Kader Çarkı “Derinliğin Çağrısı”: Yığın seviyesi 0/1/2/3+, bonus %20/%30/%40/%50\n2. Farklı Uyanmışlardan veya Kader Çarklarından gelen bonuslar üst üste eklenir.\n3. Delilik Zorluğu için ilk tamamlama ödülleri Adak Bonuslarından etkilenmez.\n\n<Title:Rezonans: Derinlerin Ayini>\n1. Etkinlik başarımlarını tamamlayarak “Adanmışlık Kalbi” elde edin.\n2. “Adanmışlık Kalbi”ni kullanarak “Rezonans: Derinlerin Ayini”ni etkinleştirin; bu rezonans şunları sağlar:\n(1) “İlahi Diyarın İnişi”ndeki Muhafızları güçlendirerek meydan okumaları kolaylaştırmak.\n(2) “İlahi Diyarın İnişi” meydan okumalarından kazanılan etkinlik para birimini artırmak.\n(3) “Kralın Fermanı” adlı etkinlik modunu etkinleştirmek.\n\n<Title:Kralın Fermanı>\n“Adak Sınavı” Rezonansını etkinleştirdikten sonra, saatte otomatik olarak 60 “Adak Sunucunun Gözyaşları” alırsınız; en fazla 25 saatlik birikim yapılabilir.\n\n<Title:Derinlerin Yankısı>\n1. “Derinlerin Yankısı”nda üç sunak bulunur ve şu tarihlerde açılır:\n“Gözyaşı Sunakları”: 4 Kasım 9:00 – 25 Kasım 9:00.\n“Kan Sunakları”: 6 Kasım 9:00 – 25 Kasım 9:00.\n“Ruh Sunakları”: 8 Kasım 9:00 – 25 Kasım 9:00.\n2. Her adak, 1000 “Adak Sunucunun Gözyaşları”/“Kanı”/“İliği” tüketir ve rastgele beş eşya verir.\n3. Ödüller “Özel Eşyalar” ve “Sıradan Eşyalar” olarak ayrılır. Sıfırlama kuralları şöyledir:\n(1) İlk 2 sıfırlama: “Özel Eşyalar” tükendiğinde, Muhafızlar sıfırlamayı seçebilir veya adak sunmaya devam edebilir. “Sıradan Eşyalar” tükendiğinde, devam edebilmek için sıfırlama zorunludur.\n(2) 3. sıfırlamadan itibaren: Yalnızca “Sıradan Eşyalar” tükendiğinde sıfırlama yapılabilir; “Özel Eşyalar” bir daha sıfırlanmaz.\n\n<Title:Düş Diyarı>\n1. Etkinlik süresince “Düş Diyarı: Desecra” ücretsizdir.\n2. Etkinlik sonrasında “Düş Diyarı: Desecra” ilerlemesi korunur. Etkinlik sırasında açılmadıysa 7 “Gerçeklik Sınırı” kullanılarak kilidi açılabilir.\n3. “Düş Diyarı: Desecra”yı herhangi bir zamanda temizlemek “Çete: Gelgit Festivali” ödülünü verir.\n\n<Title:Yeniden Yayın Telafisi>\n1. Daha önce “Düş Diyarı: Desecra”yı açmış olan Muhafızlar, yeniden etkinleştirme telafisi olarak 700 “Adak Sunucunun Gözyaşları” alacaktır.\n2. Etkinlik avatarı “Gümüş Anahtar Adına: Miryam”a hâlihazırda sahip olan Muhafızlar, avatarı tekrar elde etmeleri hâlinde 2000 “Adak Sunucunun Gözyaşları” kazanacaktır.\n3. Önceki etkinliklerden kalan fazla “Adanmışlık Kalbi”, her biri 5000 “Gül Senedi”ne dönüştürülecektir."
  },
  Activity_56428_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_56429_ActivityName = {
    Text = "Yarım Adım Ötede"
  },
  Activity_56429_ActivityPlot = {
    Text = "O, dünyanın hep bir adım önünde yürür.\nBir adım, iki adım—ayak izleri herkes için Fitil Yolu’nu aydınlatır.\nAma ahmaklar çok çabuk unutur:\nDeha ile Delilik arasındaki mesafe\nyalnızca yarım adımdır."
  },
  Activity_56429_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi; şu anda yalnızca \"Üstadın Öğretisi\"ne katılabilirsiniz."
  },
  Activity_56429_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\nEtkinlik süresince Koruyucular, sınırlı süreli oynanışlar olan \"Unutuş Kapısı\" ve \"Başarı Ödülleri\" aracılığıyla etkinlik parası \"Kukla Parçaları\" toplayabilir. \"Kukla Parçaları\", \"Üstadın Öğretileri\" içinde, etkinliğe özel SR Kader Çarkı \"Çobanın Asası\", Lümen Çekirdeği, Saf Çekirdek, Bilge Taşı Parçaları, Taklit Kristali vb. ödüllerle takas edilebilir.\n\n<Title:Unutuş Kapısı>\n1. \"Unutuş Kapısı\", keşif gerektirmeyen doğrudan savaşlardan oluşan 9 malzeme seviyesi içerir ve her gün 1 seviye açılır.\n2. Her meydan okuma 120 Menophin tüketir; başarıyla tamamlandığında yetiştirme malzemeleri ve etkinlik parası verir.\n3. Bir seviye temizlendikten sonra, o seviye için \"Yeniden Canlandır\" işlevi açılır. Not: \"Yeniden Canlandır\" kullanmak Yakınlık kazandırmaz.\n4. Seviyeleri daha kolay geçmek için Mezun yardımı kullanabilirsiniz.\n\n<Title:Kukla Parçaları Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan Koruyucular (savaşa sokmaları gerekmez), \"Unutuş Kapısı\" seviye görevlerinde (yeniden canlandırma dahil) \"Kukla Parçaları\" için ek düşüş bonusları elde eder, şu şekilde:\nUyanan \"Doll: Cehennem\": Aydınlanma 0/1/2/3 ve üzeri, Bonus %20/%30/%40/%50\nSSR Kader Çarkı \"Unutuşun Kuklaları\": Katman 0/1/2/3 ve üzeri, Bonus %20/%30/%40/%50\nSR Kader Çarkı \"Çobanın Asası\": Katman 0/1/2/3 ve üzeri, Bonus %20/%30/%40/%50\n2. Farklı Uyananlar veya Kader Çarklarından gelen \"Kukla Parçaları\" bonusları birikir.\n3. Not: Delilik Zorluğu için ilk tamamlama ödülü, yukarıdaki bonuslardan etkilenmez.\n\n<Title:Üstadın Öğretileri>\n1. Her \"Parça Takası\", 750 \"Kukla Parçaları\" tüketir ve \"Üstadın Öğretileri\"nden rastgele beş ödül verir.\n2. \"Üstadın Öğretileri\" ödülleri \"Özel Eşyalar\" ve \"Sıradan Eşyalar\" olarak ayrılır. Sıfırlama sırasında, özel eşya ödüllerinin kalan miktarı aşağıdaki kurallara göre en yüksek değere döndürülebilir:\n(1) İlk 5 sıfırlama: \"Özel Eşyalar\"ın kalan miktarı kalmadığında, Koruyucular sıfırlamayı seçebilir; bu, hem \"Özel\" hem de \"Sıradan\" eşyaların miktarlarını en yüksek değere döndürür. Alternatif olarak, \"Sıradan Eşyalar\" da tükenene kadar takasa devam edebilirler; bu noktada, takasa devam etmek için sıfırlama zorunlu hale gelir.\n(2) 6. sıfırlamadan itibaren: Sıfırlama yalnızca \"Sıradan Eşyalar\"ın kalan miktarı kalmadığında yapılabilir ve yalnızca onların miktarını en yüksek değere döndürür; \"Özel Eşyalar\" sıfırlanmaz.\n\n<Title:Etkinlik Süresi>\n1. 17 Şubat 09:00 - 3 Mart 09:00 (GMT+8) arasında, etkinlik özetindeki tüm içerikler erişime açıktır.\n2. 3 Mart 09:00 - 10 Mart 09:00 (GMT+8) arasında yalnızca \"Üstadın Öğretileri\" ve \"Başarı Ödülleri\" erişilebilir; diğer tüm içerikler sona erer ve kullanılamaz.\n3. 10 Mart 09:00 (GMT+8) sonrasında, kalan \"Kukla Parçaları\" \"her takas için 40 Gül Senedi\" oranıyla geri dönüştürülecektir. Lütfen, Koruyucular, postanızı kontrol etmeyi unutmayın."
  },
  Activity_56429_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_56430_ActivityName = {
    Text = "Görünmez Senfoni"
  },
  Activity_56430_ActivityPlot = {
    Text = "Senfoni bir dokuma sanatıdır; farklı enstrümanların yolları karmaşık bir desen oluşturacak şekilde iç içe geçer.\nOnun ağında her nota rolünü oynar.\nDinle, eşsiz bir senfoni başlamak üzere."
  },
  Activity_56430_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Uyku Sarayı\" kullanılabilir."
  },
  Activity_56430_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli oynanış “Çınlayan Ses” ve “Başarı Ödülleri” aracılığıyla etkinlik parası “Coşku Sonatı” toplayabilir. “Coşku Sonatı”, “Düş Sarayı”nda etkinliğe özel SR Kader Çarkı “Sonsuz Performans”, Saf Çekirdek, Lümen Çekirdeği, Bilge Taşı Parçaları ve Taklit Kristalleri de dahil olmak üzere cömert ödüllerle takas edilebilir.\n2. Etkinlik süresince “Başarı Ödülleri”ndeki görevleri tamamlamak, etkinliğe özel avatar “Gümüş Anahtar Adına: Hameln”i, etkinliğe özel SR Kader Çarkı “Sonsuz Performans”ı, Gümüş ve büyük miktarda etkinlik parası “Coşku Sonatı” kazandırır.\n\n<Title:Etkinlik Süresi>\n1. 9 Eylül 09:00’dan 23 Eylül 09:00’a kadar (GMT+8) tüm etkinlik içeriğine katılım mümkündür.\n2. 23 Eylül 09:00’dan 30 Eylül 09:00’a kadar (GMT+8) yalnızca “Düş Sarayı” ve “Başarı Ödülleri” açık kalacak, diğer içerikler artık erişilebilir olmayacaktır.\n\n<Title:Çınlayan Ses>\n1. “Çınlayan Ses” 9 bölümden oluşur, her gün bir bölüm kendiliğinden açılır.\n2. Her meydan okuma 120 Menofin tüketir. Farklı bölümlere meydan okuyarak farklı malzeme düşüşleri elde etmenin yanı sıra, katılımcılar etkinlik parası “Coşku Sonatı” da kazanacaktır.\n3. Etkinlik bölümleri doğrudan çatışma malzeme bölümleridir ve tamamlandıktan sonra tekrar oynanabilir! Her “Tekrar Oyna” 120 Menofin tüketir.\n4. Lütfen dikkat: “Tekrar Oyna” işlevi kullanıldığında Afinite kazanılamaz.\n\n<Title:Sonat Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan Muhafızlar (savaşa sürülmeleri gerekmez), “Çınlayan Ses” bölümlerinin görev ödüllerinde (tekrarlar dahil) ek “Coşku Sonatı” düşüşleri elde edebilir. Özel bonuslar şöyledir:\nUyanan “Hameln”: Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSSR Kader Çarkı “Ebedi Ağıt”: Yığın seviyesi 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSR Kader Çarkı “Sonsuz Performans”: Yığın seviyesi 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n2. Farklı Uyananlardan veya Kader Çarklarından gelen “Sonat Bonusu” kümülatif olarak hesaplanır.\n3. Özellikle, Delilik Zorluğu için ilk tamamlama meydan okuma ödülü “Sonat Bonusu”ndan etkilenmez.\n\n<Title:Düş Sarayı>\n1. “Düş Sarayı” yalnızca 9 Eylül 09:00’dan 30 Eylül 09:00’a kadar (GMT+8) açıktır.\n2. 30 Eylül 09:00’dan (GMT+8) sonra, takas edilmemiş “Coşku Sonatı”lar, takas başına “Gül Senedi *40” oranıyla geri alınacaktır. Muhafızların postalarını kontrol etmeleri tavsiye edilir."
  },
  Activity_56430_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_56431_ActivityName = {
    Text = "Yıldızlar Yerinde"
  },
  Activity_56431_ActivityPlot = {
    Text = "Yıldızların Hizalanma saati yaklaşıyor, göğsündeki hareket davul sesi gibi hissediliyor.\nOnu yıllardır eziyet eden karanlık kabuslar, sayısız takipçinin gözyaşlarıyla son buluyor.\nOnun@1 karanlığından@2, yüce olan@3 dünyaya Gelişini gerçekleştiriyor."
  },
  Activity_56431_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Kutsal Embriyo Kuluçkası\" kullanılabilir."
  },
  Activity_56431_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli oynanış “Karanlık Rahim” ve “Başarı Ödülleri” aracılığıyla üç tür “Cenin” toplayabilir. “Cenin”ler, “Kutsal Cenin Kuluçkası”nda etkinliğe özel SR Kader Çarkı “Buzulun Altındaki Uyku”, Saf Çekirdek, Lümen Çekirdeği, Eter Taşı Kırıntıları, Taklit Kristalleri vb. eşya ödülleriyle takas edilebilir.\n2. Etkinlik süresince “Başarı Ödülleri” görevlerini tamamlamak, etkinliğe özel avatar “Gümüş Anahtar Adına: Goliath”ı, etkinliğe özel SR Kader Çarkı “Buzulun Altındaki Uyku”yu ve çok sayıda “Cenin” kazandırır.\n\n<Title:Etkinlik Süresi>\n1. 29 Temmuz 09:00’dan 12 Ağustos 09:00’a kadar (GMT+8) tüm etkinlik içeriği erişime açık olacaktır.\n2. 12 Ağustos 09:00’dan 19 Ağustos 09:00’a kadar (GMT+8) yalnızca “Kutsal Cenin Kuluçkası” ve “Başarı Ödülleri” erişilebilir olacak; diğer içerikler sona erecek ve kullanılamayacaktır.\n\n<Title:Karanlık Rahim>\n1. “Karanlık Rahim” 7 bölümden oluşur, her gün bir bölüm açılır.\n2. Her deneme 120 Menofin tüketir. Başarılı meydan okumalar, etkinlik parası “Bilinçsiz Cenin”, “Arzusuz Cenin” ve “Doymak Bilmez Cenin” kazandırır.\n3. Bir bölümü tamamladıktan sonra o bölüm için “Tekrar Oyna” özelliği açılır. Not: “Tekrar Oyna” kullanmak Afinite kazandırmaz.\n4. Bölümleri daha kolay temizlemek için Mezun yardımı kullanabilirsiniz.\n5. Herhangi bir zorluk derecesi temizlendikten sonra, o bölüm için Delilik Zorluğu açılır. Delilik Zorluğunu ilk kez tamamlamak, yüklü miktarda etkinlik parası kazandırır.\n6. Not: Delilik Zorluğu Menofin tüketmez, tekrar oynanamaz ve ilk tamamlama sonrasında yinelendiğinde ek etkinlik parası vermez.\n\n<Title:Cenin Bonusları>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan Muhafızlar (savaşa sürülmeleri gerekmez), “Karanlık Rahim” bölüm ödüllerinden (tekrarlar dahil) “Bilinçsiz Cenin”, “Arzusuz Cenin” ve “Doymak Bilmez Cenin” için ek düşüş bonusları elde edebilir; ayrıntılar şöyledir:\nUyanan “Murphy”: Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSSR Kader Çarkı “Örtülü Doğuş”: Yığın 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSR Kader Çarkı “Buzulun Altındaki Uyku”: Yığın 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n2. Farklı Uyananlardan veya Kader Çarklarından gelen bonuslar üst üste eklenir.\n3. Özellikle, Delilik Zorluğu ilk-tamamlama ödülleri “Cenin Bonusları”ndan etkilenmez.\n\n<Title:Kutsal Cenin Kuluçkası>\n1. “Kutsal Cenin Kuluçkası” yalnızca 29 Temmuz 09:00’dan 19 Ağustos 09:00’a kadar (GMT+8) açıktır.\n2. 19 Ağustos 09:00’dan (GMT+8) sonra, takas edilmemiş “Cenin”ler, Cenin başına 40 Gül Senedi oranıyla geri dönüştürülecektir. Muhafızlar posta kutularını kontrol etmelidir."
  },
  Activity_56431_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_56432_ActivityName = {
    Text = "Karlar Eridiğinde"
  },
  Activity_56432_ActivityPlot = {
    Text = "Elworth'taki kar asla erimez, tıpkı onun nefreti gibi.\nGeleceğin ve geçmişin elleri birbirine kenetlendiğinde, savaşçı kılıcını kaldıracak ve intikam için kadere karşı hücum edecektir.\nKara dalgalarla yüzleştiğinde, sen onun sancağısın."
  },
  Activity_56432_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Dağın Dev Çenesi\" kullanılabilir."
  },
  Activity_56432_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli oynanış \"Canavar Hırsı\" ve \"Başarı Ödülleri\" aracılığıyla üç tür \"Tomurcuk\" toplayabilir. Bu \"Tomurcuklar\", \"Dağ Geçidi\"nde etkinliğe özel SR Kader Çarkı \"Karlar Eriyince\", Saf Öz, Işıltılı Öz, Eter Parçası, Taklit Kristali ve daha fazlası dâhil olmak üzere eşya ödülleriyle takas edilebilir.\n2. \"Özel Sevk Kaydı: Elworth'un Dönüşü\" etkinlik süresince ücretsiz olacaktır.\n\n<Title:Etkinlik Süresi>\n1. 7 Ekim 9:00'dan 21 Ekim 9:00'a kadar (GMT+8) tüm etkinlik içeriğine erişilebilir.\n2. 21 Ekim 9:00'dan 28 Ekim 9:00'a kadar (GMT+8) yalnızca \"Dağ Geçidi\" ve \"Başarı Ödülleri\" erişilebilir durumda kalacak; diğer içerikler sona erecek ve erişilemez olacaktır.\n\n<Title:Canavar Hırsı>\n1. \"Canavar Hırsı\" 5 aşamadan oluşur; her 2 günde bir aşama açılır.\n2. Her meydan okuma 120 Menofin tüketir ve başarılı meydan okumalar etkinlik parası olan \"Soğuk Kırağı Tomurcuğu\", \"Gümüş Kırağı Tomurcuğu\" ve \"Güneş Işığı Tomurcuğu\" kazandırır.\n3. Bir aşama temizlendikten sonra \"Tekrar Oynat\" işlevi açılır. Not: \"Tekrar Oynat\" kullanmak Yakınlık kazandırmaz.\n4. Mezun Desteği ve \"Rezonans: Dağı Yutan\" aşamaları daha kolay temizlemenize yardımcı olabilir.\n5. Bir aşama açıldıktan sonraki ikinci günde Delilik zorluğu kullanılabilir hâle gelir ve ilk tamamlamada bol etkinlik parası ödülü sunar.\n6. Not: Delilik zorluğu meydan okumaları Menofin tüketmez, tekrar oynanamaz ve sonraki tamamlamalar etkinlik parası kazandırmaz.\n\n<Title:Tomurcuk Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan Muhafızlar (sahaya sürülmeleri gerekmez), \"Canavar Hırsı\" aşama ödüllerinde (tekrarlar dâhil) \"Soğuk Kırağı Tomurcuğu\", \"Gümüş Kırağı Tomurcuğu\" ve \"Güneş Işığı Tomurcuğu\" için ek düşüş bonusu alırlar:\nUyanan \"Helot: Catena\": Aydınlanma 0/1/2/3+, %20/%30/%40/%50 bonus\nSSR Çark \"Kızılda Boğulan\": Yığın 0/1/2/3+, %20/%30/%40/%50 bonus\nSR Çark \"Karlar Eriyince\": Yığın 0/1/2/3+, %20/%30/%40/%50 bonus\n2. Farklı Uyananların veya Çarkların \"Tomurcuk Bonusları\" üst üste eklenir.\n3. Özel not: Delilik zorluğundaki ilk tamamlama ödülü \"Tomurcuk Bonusu\"ndan etkilenmez.\n\n<Title:Rezonans: Dağı Yutan>\n1. Muhafızlar, etkinlik başarılarını tamamlayarak \"Yutkun Kalbi\" elde edebilir.\n2. \"Yutkun Kalbi\" tüketmek, \"Rezonans: Dağı Yutan\"ı etkinleştirir; bu da Muhafızları \"Canavar Hırsı\"nda güçlendirir ve meydan okumaları kolaylaştırır.\n\n<Title:Dağ Geçidi>\n1. \"Dağ Geçidi\"nde üç takas dükkânı bulunur ve açılışları şöyledir:\n\"Yutkun Hırs\": 7 Ekim 9:00'da açılır.\n\"İntikam Savaş Ruhu\": 9 Ekim 9:00'da açılır.\n\"Yeniden Doğuş Umudu\": 11 Ekim 9:00'da açılır.\n2. Her takas, 1000 \"Soğuk Kırağı Tomurcuğu\"/\"Gümüş Kırağı Tomurcuğu\"/\"Güneş Işığı Tomurcuğu\" tüketir ve dükkândan rastgele beş eşya verir.\n3. Her dükkânda \"Özel Eşyalar\" ve \"Sıradan Eşyalar\" bulunur. Sıfırlama, kalan özel eşya miktarını aşağıdaki kurallara göre limite geri yükler:\n(1) İlk 2 sıfırlama: \"Özel Eşyalar\" tükendiğinde Muhafızlar sıfırlamayı seçebilir; bu, hem \"Özel Eşyalar\"ı hem de \"Sıradan Eşyalar\"ı limitlerine geri yükler. Alternatif olarak, \"Sıradan Eşyalar\" da tükenene kadar takasa devam edebilirler; sonrasında devam etmek için sıfırlama gerekir.\n(2) 3. sıfırlamadan itibaren: Sıfırlama yalnızca \"Sıradan Eşyalar\" tükendiğinde yapılabilir; bu, \"Sıradan Eşyalar\"ı limitine geri yüklerken \"Özel Eşyalar\"ı değiştirmez.\n4. 28 Ekim 9:00'dan (GMT+8) sonra kalan tüm \"Tomurcuklar\" Tomurcuk başına 40 Gül Senedi oranıyla geri alınacaktır. Ayrıntılar için postanızı kontrol edin.\n\n<Title:Özel Sevk Kaydı>\n1. \"Özel Sevk Kaydı: Elworth'un Dönüşü\" etkinlik süresince ücretsiz olacaktır. Her 2 günde bir yeni bölümler açılacaktır. \"Özel Sevk Kaydı: Elworth'un Dönüşü\"nü temizlemek, Gümüş ve yalnızca etkinlik süresince elde edilebilen etkinliğe özel SR Çark \"Karlar Eriyince\" dâhil olmak üzere Başarı Ödülleri kazandırır. Etkinlik sona erdikten sonra tamamlanma veya alınabilir ödül olmayacaktır.\n2. Etkinlik sona erdikten sonra \"Özel Sevk Kaydı: Elworth'un Dönüşü\"nün soruşturma ilerlemesi korunur. Etkinlik sırasında açılmadıysa, yine de 7 Gerçeklik Sınırı harcayarak açılabilir.\n3. Etkinlik dönemi fark etmeksizin, \"Özel Sevk Kaydı: Elworth'un Dönüşü\"nü temizlemek \"Çete: Dağ Vahyi\" kazandırır."
  },
  Activity_56432_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_56433_ActivityName = {
    Text = "Dedektif El Kitabı"
  },
  Activity_56433_ActivityPlot = {
    Text = "Bu sayfaların içinde, bir ömrü gizem çözmekle geçmiş usta bir Dedektifin katılaşmış kavrayışları yatıyor.\nMütevazı Müfettişlerin sezgisini tutuşturup zekâsını bilemek için tasarlanmış bir rehber."
  },
  Activity_56433_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Şans Kulübü\" Alınabilir."
  },
  Activity_56433_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince, Muhafızlar, süreli oynanış \"Mehtap masalları\" ve \"Başarı Ödülleri\" aracılığıyla etkinlik parası \"Kazanan Fiş\" toplayabilir. \"Kazanan Fiş\", \"Şans Kulübü\"nde etkinliğe özel SR Kader Çarkı \"Kader Ruleti\", Saf Çekirdek, Lümen Çekirdeği, Eter Taşı Kırıntısı, Taklit Kristali vb. dâhil cömert ödüllerle takas edilebilir.\n2. Etkinlik süresince, \"Başarı Ödülleri\"ndeki görevleri tamamlamak, etkinliğe özel avatar \"Gümüş Anahtar Adına: Ryker\", etkinliğe özel SR Kader Çarkı \"Kader Ruleti\", Gümüş ve yüklü miktarda etkinlik parası \"Kazanan Fiş\" kazandırır.\n3. Etkinlik süresince, \"Görev Kaydı: İyi Avlar!\" süreli ücretsiz erişim ile açılır.\n\n<Title:Etkinlik Süresi>\n1. 12 Ağustos 09:00 - 26 Ağustos 09:00 (GMT+8) arasında tüm etkinlik içeriklerine katılım mümkündür.\n2. 26 Ağustos 09:00 - 2 Eylül 09:00 (GMT+8) arasında yalnızca \"Şans Kulübü\" ve \"Başarı Ödülleri\" kalır, diğer içeriklere artık katılım sağlanamaz.\n\n<Title:Mehtap masalları>\n1. \"Mehtap masalları\" 9 bölümden oluşur, her gün 1 bölüm kendiliğinden açılır.\n2. Her meydan okuma 120 Menofin puanı tüketir ve farklı bölümlere meydan okumak, farklı malzeme düşüşlerinin yanı sıra etkinlik parası \"Kazanan Fiş\" verir.\n3. Bu etkinlikteki bölümler, temizlendikten sonra tekrar oynanabilen doğrudan savaş malzeme bölümleridir! Her \"Yeniden Oyna\" 120 Menofin puanı tüketir.\n4. Not: \"Yeniden Oyna\" işlevini kullanmak Afinite kazandırmaz.\n\n<Title:Fiş Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan Muhafızlar (kadroda bulunmaları gerekmez), \"Mehtap masalları\" görev ödüllerinde (yeniden oynama dâhil) ek \"Kazanan Fiş\" düşüşü elde eder. Özel bonuslar şöyledir:\nUyanan \"Ryker\": Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSSR Kader Çarkı \"Şans Saati\": Yığılma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSR Kader Çarkı \"Kader Ruleti\": Yığılma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n2. Farklı Uyananların veya Kader Çarklarının \"Fiş Bonusu\" toplamsal olarak hesaplanır.\n3. Özellikle, Delilik Zorluğu'nun ilk meydan okuma ödülü \"Fiş Bonusu\"ndan etkilenmez.\n\n<Title:Şans Kulübü>\n1. \"Şans Kulübü\" yalnızca 12 Ağustos 09:00 - 2 Eylül 09:00 (GMT+8) arasında açıktır.\n2. 2 Eylül 09:00'dan (GMT+8) sonra, takas edilmemiş kalan \"Kazanan Fiş\"ler, her takas için \"Gül Senedi *40\" oranıyla geri alınacaktır. Muhafızlar posta kutularını kontrol etmelidir.\n\n<Title:Görev Kaydı>\n1. \"Görev Kaydı: İyi Avlar!\"da, Muhafızlar, hikâye ön ayarlı \"Ryker\"ı da içeren özel bir takımla meydan okumaya çıkar.\n2. \"Görev Kaydı: İyi Avlar!\"ı temizlemek, yeni kilit eşya \"Bir Silahın Çığlığı\"nı ödül olarak verir."
  },
  Activity_56433_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_56434_ActivityName = {
    Text = "Tüm Diyarların Kapısı"
  },
  Activity_56434_ActivityPlot = {
    Text = "Hiç kimse, Son Sınırın Kapısı'nda sessiz nöbetini ne kadar süredir sürdürdüğünü bilmez.\nNe somut bir dünyada vücut bulmayı amaçladı, ne de herhangi bir uzam-zaman akıntısına kapılmayı.\nOrada, Kapı'da, rahatsız edilmeden kaldı—\nTa ki gözleri seninkilerle kesiştiği ana dek."
  },
  Activity_56434_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Yankı\" kullanılabilir."
  },
  Activity_56434_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli oynanış “Son Sınav” ve “Başarı Ödülleri” aracılığıyla etkinlik parası “Son İbre” toplayabilir. “Son İbre”, “Yankı”da etkinliğe özel SR Kader Çarkı “Hakikat Kapısı”, Saf Çekirdek, Lümen Çekirdeği, Bilge Kırıntısı, Taklit Kristali ve daha fazlası da dahil olmak üzere cömert ödüllerle takas edilebilir.\n2. Etkinlik süresince “Başarı Ödülleri” görevlerini tamamlamak, etkinliğe özel avatar “Gümüş Anahtar Adına: \"Tawil\"”i, etkinliğe özel SR Kader Çarkı “Hakikat Kapısı”nı, Gümüş ve büyük miktarda etkinlik parası “Son İbre” kazandırır.\n\n<Title:Etkinlik Süresi>\n1. 18 Kasım 09:00’dan 2 Aralık 09:00’a kadar (GMT+8) tüm etkinlik içeriğine katılım mümkündür.\n2. 2 Aralık 09:00’dan 9 Aralık 09:00’a kadar (GMT+8) yalnızca “Yankı” ve “Başarı Ödülleri” korunacak; diğer içerikler sona ermiş olacak ve artık katılıma açık olmayacaktır.\n\n<Title:Son Sınav>\n1. “Son Sınav” 9 bölüm içerir, her gün bir bölüm kendiliğinden açılır.\n2. Her meydan okuma 120 Menofin tüketecek ve farklı bölümlere meydan okuyarak oyuncular yalnızca farklı malzeme düşüşleri elde etmekle kalmayıp etkinlik parası “Son İbre” de kazanacaktır.\n3. Bu etkinliğin bölümleri doğrudan çatışma malzeme bölümleridir ve tamamlandıktan sonra tekrar oynanabilir! Her “Tekrar Oyna” 120 Menofin’e mal olur.\n4. Lütfen dikkat: “Tekrar Oyna” işlevi kullanıldığında Afinite kazanılamaz.\n\n<Title:Son İbre Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan Muhafızlar (Düzen’de bulunmaları gerekmez), “Son Sınav” bölüm görev ödüllerinde (tekrarlar dahil) “Son İbre” için ek düşüş bonusları elde edebilir; ayrıntılar şöyledir:\nUyanan “\"Tawil\"”: Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSSR Kader Çarkı “Görünmez Çark”: Yığın 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSR Kader Çarkı “Hakikat Kapısı”: Yığın 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n2. Farklı Uyananlardan veya Kader Çarklarından gelen “Son İbre Bonusu” üst üste eklenerek hesaplanır.\n3. Özellikle, Delilik Zorluğu için ilk kez meydan okuma ödülü “Son İbre Bonusu”ndan etkilenmez.\n\n<Title:Yankı>\n1. “Yankı” yalnızca 18 Kasım 09:00’dan 9 Aralık 09:00’a kadar (GMT+8) açıktır.\n2. 9 Aralık 09:00’dan (GMT+8) sonra, takas edilmemiş “Son İbre”ler, takas başına “Gül Senedi *40” oranıyla geri alınacaktır. Lütfen ayrıntılar için postanızı kontrol edin, Muhafızlar."
  },
  Activity_56434_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_56435_ActivityName = {
    Text = "Çoklu Şifa: Tekrar"
  },
  Activity_56435_ActivityPlot = {
    Text = "Histeri. Adına istersen mania de, istersen zihnin paramparça oluşu; bu çağda bu teşhis, bir idam fermanıdır. Neyse ki Mythag’ın bilim insanları ve Müfettişleri, kendilerine özgü bir delilikle maluldür: Bu dehşeti alt etmeye kararlıdırlar."
  },
  Activity_56435_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Ego Tahlili\" alınabilir."
  },
  Activity_56435_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, süreli modlar olan \"Hafıza Kodlaması\", \"Sınır Deposu\" ve \"Başarı Ödülleri\" aracılığıyla \"Hafıza Bulmacası\" adlı etkinlik parasını toplayabilir. \"Hafıza Bulmacası\", \"Persona Analizi\"nde etkinliğe özel SR Kader Çarkı \"Gümüş Morina’nın Kararı\", Lümen Çekirdeği, Saf Çekirdek vb. eşyaları satın almak için kullanılabilir.\n2. Etkinlik süresince \"Özel Kayıt: Sakin Bölünme\" süreli ücretsiz erişime açılır. Etkinlik başarımlarını tamamlamak, ayrıca etkinliğe özel avatar \"Gümüş Anahtar Adına: '24'\" kazandırır.\n\n<Title:Etkinlik Süresi>\n1. 21 Ekim 9:00’dan 4 Kasım 9:00’a kadar (GMT+8) tüm etkinlik modları kullanılabilir.\n2. 4 Kasım 9:00’dan 11 Kasım 9:00’a kadar (GMT+8) yalnızca \"Persona Analizi\" ve Başarı Ödülleri erişilebilir olacaktır.\n\n<Title:Hafıza Kodlaması>\n1. \"Hafıza Kodlaması\" 5 aşamadan oluşur; her 2 günde bir aşama açılır.\n2. Her meydan okuma 120 Menofin tüketir ve başarılı meydan okumalar etkinlik parası kazandırır.\n3. Bir aşama temizlendikten sonra o aşama için \"Yeniden Canlandır\" özelliği açılır. Not: \"Yeniden Canlandır\" kullanmak yakınlık kazandırmaz.\n4. Mezun Yardımı ve \"Rezonans: Ayrışma Sendromu\"nu kullanarak aşamaları daha kolay temizleyin.\n\n<Title:Akli Prim>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan Muhafızlar (savaşa sürülmeleri gerekmez), \"Hafıza Kodlaması\" görevlerinden ek \"Hafıza Bulmacası\" düşüşü elde eder; ayrıntılar şöyledir:\nUyanan \"24\": Aydınlanma 0/1/2/3+, bonus %20/%30/%40/%50.\nSSR Kader Çarkı \"Sapkın Yutma\": Yığın 0/1/2/3+, bonus %20/%30/%40/%50.\nSR Kader Çarkı \"Gümüş Morina’nın Kararı\": Yığın 0/1/2/3+, bonus %20/%30/%40/%50.\n2. Farklı Uyananlar veya Kader Çarklarından gelen Akli Primler üst üste eklenir.\n3. Özel not: Delilik Zorluğu için ilk tamamlama ödülleri Akli Prim’den etkilenmez.\n\n<Title:Rezonans: Ayrışma Sendromu>\n1. Muhafızlar, etkinlik başarımlarını tamamlayarak \"Bölünme Kalbi\" elde edebilir.\n2. \"Bölünme Kalbi\" harcanarak \"Rezonans: Ayrışma Sendromu\" etkinleştirildiğinde şu faydalar sağlanır:\n(1) Muhafızın \"Hafıza Kodlaması\" ve \"Özel Kayıt: Sakin Bölünme\"deki gücünü artırır, meydan okumaları kolaylaştırır.\n(2) \"Hafıza Kodlaması\" meydan okumalarından alınan ödülleri artırır.\n(3) \"Sınır Deposu\" etkinlik modunu etkinleştirir.\n\n<Title:Sınır Deposu>\n1. \"Rezonans: Bilişsel Rezonans\" etkinleştirildikten sonra, saatte otomatik olarak 60 \"Hafıza Bulmacası α\" kazanılır; en fazla 25 saate kadar birikir.\n2. \"Rezonans: Bilişsel Yakınlık\" etkinleştirildikten sonra, saatte otomatik olarak 30 \"Hafıza Bulmacası β\" kazanılır; en fazla 25 saate kadar birikir.\n\n<Title:Özel Kayıt>\n1. Etkinlik süresince \"Özel Kayıt: Sakin Bölünme\"yi açmak ücretsizdir.\n2. Etkinlik sonrasında \"Özel Kayıt: Sakin Bölünme\"deki ilerleme korunur ve tamamlanmamış soruşturmalar hâlâ aynı ödülleri verebilir. \"Özel Kayıt: Sakin Bölünme\" etkinlik sırasında açılmadıysa, etkinlikten sonra da 7 Gerçeklik Sınırı karşılığında açılabilir.\n3. Etkinlik zamanından bağımsız olarak, \"Özel Kayıt: Sakin Bölünme\"yi temizlemek her zaman \"Çete: Onun Bütünü\"nü kazandırır.\n\n<Title:Yeniden Yayım Telafisi>\n1. Daha önce \"Özel Kayıt: Sakin Bölünme\"yi açmış olan Muhafızlar, bu yeniden yayım etkinliği sırasında telafi olarak 700 \"Hafıza Bulmacası α\" alacaktır.\n2. Daha önce etkinliğe özel avatar \"Gümüş Anahtar Adına: '24'\"ü elde etmiş olan Muhafızlar, yinelenen edinim üzerine 2000 \"Hafıza Bulmacası α\" alacaktır.\n3. Daha önce rezonans malzemesi \"Bölünme Kalbi\"ni edinmiş olan Muhafızlar, her fazla \"Bölünme Kalbi\" için 5000 Gül Senedi alacaktır.\n"
  },
  Activity_56435_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_56436_ActivityName = {
    Text = "Alevlerin Şöleni: Tekrar"
  },
  Activity_56436_ActivityPlot = {
    Text = "Göldeki Şehir Isarawu’nun, Wanda’nın memleketi olduğu söylenir.\nBu kez Rüya Kapısı’ndan geçecek ve saat dilleriyle dolu kadim kulelere varacaksın..."
  },
  Activity_56436_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Wanda'nın Hazine Sandığı\" kullanılabilir."
  },
  Activity_56436_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, süreli oynanış “Alevlerin Şöleni” ve “Başarı Ödülleri” aracılığıyla etkinlik para birimleri “İlkel Kaval Kemiği”, “Tornoceras” ve “Sarmal Kalıntılar”ı toplayabilir. Bu para birimleri, “Wanda’nın Hazine Mahzeni”nde etkinliğe özel SR Kader Çarkı “Isarawu'nun Bakışı”, Lümen Çekirdeği, Saf Çekirdek vb. eşyaları satın almak için kullanılabilir.\n2. Etkinlik süresince “Zihin Dalgınlığı: Alevlerin Şöleni”ne süreli ücretsiz erişim sağlanacak ve etkinlik başarılarını tamamlamak, etkinliğe özel avatar “Gümüş Anahtar Adına: Wanda”yı kazandıracaktır!\n\n<Title:Etkinlik Süresi>\n1. 23 Eylül 09:00’dan 7 Ekim 09:00’a kadar (GMT+8) tüm etkinlik oynanışları erişime açık olacaktır.\n2. 7 Ekim 09:00’dan 14 Ekim 09:00’a kadar (GMT+8) yalnızca “Wanda’nın Hazine Mahzeni” ve başarı ödüllerine erişilebilecektir.\n\n<Title:Göldeki Şehir>\n1. “Göldeki Şehir”de 7 safha vardır; her gün bir safha kendiliğinden açılır.\n2. Her meydan okuma 120 Menophin tüketir ve başarıyla tamamlanan meydan okumalar etkinlik para birimi kazandırır.\n3. Bir safha temizlendikten sonra o safhanın “Yeniden Canlandır” işlevi açılır. Not: “Yeniden Canlandır” kullanmak Yakınlık kazandırmaz.\n4. Safhaları daha kolay tamamlamak için Mezun desteğini ve “Rezonans: Gizli Vekâlet Emri”ni kullanabilirsiniz.\n\n<Title:Nadir Armağan>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olmak (savaşta bulunmaları gerekmez), “Göldeki Şehir” safhalarında ek etkinlik para birimi düşüşü sağlar; özel bonuslar şöyledir:\nUyanan “Wanda”: Aydınlanma seviyeleri 0/1/2/3+, bonuslar %20/%30/%40/%50.\nSSR Kader Çarkı “Kraliçenin Fermanı”: Yükseliş seviyeleri 0/1/2/3+, bonuslar %20/%30/%40/%50.\nSR Kader Çarkı “Isarawu'nun Bakışı”: Yükseliş seviyeleri 0/1/2/3+, bonuslar %20/%30/%40/%50.\n2. Farklı Uyananların veya Kader Çarklarının “Nadir Armağan”ları Hesaplama sırasında birikir.\n3. Dikkat: Delilik Zorluğu’ndaki ilk tamamlama ödülü, Nadir Armağanlardan etkilenmez.\n\n<Title:Rezonans: Gizli Vekâlet Emri>\n1. Muhafızlar, etkinlik başarılarını tamamlayarak “Hedonizm Kalbi” elde edebilir.\n2. “Hedonizm Kalbi” kullanmak, “Rezonans: Gizli Vekâlet Emri”ni etkinleştirir; bu da Muhafızları güçlendirir ve “Göldeki Şehir”de fazladan etkinlik para birimi kazandırır.\n\n<Title:Zihin Dalgınlığı>\n1. Etkinlik süresince “Alevlerin Şöleni” ücretsiz olarak açılacaktır.\n2. Etkinlik sonrasında “Alevlerin Şöleni”ndeki ilerleme korunur ve tamamlanmamış Soruşturma Olayları aynı ödülleri vermeye devam eder. “Alevlerin Şöleni” etkinlik sırasında açılmazsa, sonrasında 3 “Gerçeklik Sınırı” harcanarak erişilebilir.\n3. “Alevlerin Şöleni”ni tamamlamak, etkinlik döneminden bağımsız olarak “Çete: Çürüme Şöleni” kazandırır.\n\n<Title:Yeniden Yayın Telafisi>\n1. Daha önce “Zihin Dalgınlığı: Alevlerin Şöleni”ni açmış olan Muhafızlar, bu yeniden yayında tekrar açmaları hâlinde 300 “İlkel Kaval Kemiği” telafi alacaktır.\n2. Daha önce elde edilmiş etkinliğe özel avatar “Gümüş Anahtar Adına: Wanda”nın kopyaları, 2000 “İlkel Kaval Kemiği”ne dönüştürülür.\n3. Daha önce elde edilmiş etkinleştirme rezonans malzemesi “Hedonizm Kalbi”nin her fazlası, 5000 “Gül Senedi”ne dönüştürülür.\n"
  },
  Activity_56436_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_56477_ActivityName = {Text = "Tahrip Et"},
  Activity_56478_ActivityName = {
    Text = "İyi Avlar!"
  },
  Activity_56479_ActivityName = {
    Text = "Ruh Çobanı"
  },
  Activity_56480_ActivityName = {
    Text = "Alevlerin Şöleni"
  },
  Activity_56481_ActivityName = {
    Text = "Elworth'ün Geri Döneni"
  },
  Activity_56482_ActivityName = {
    Text = "Dingin Bölünme"
  },
  Activity_59841_ActivityName = {
    Text = "Değer Büyüme Paketi (Üretimden Kaldırıldı)"
  },
  Activity_59841_ActivityPlot = {
    Text = "Satın aldıktan sonra \"Nergis\"\n<BlueQuality:Lv50>, <BlueQuality:Tüm Yetenekler Lv4> seviyesine ulaşabilir"
  },
  Activity_59842_ActivityName = {
    Text = "Değer Büyüme Paketi (Üretimden Kaldırıldı)"
  },
  Activity_59842_ActivityPlot = {
    Text = "Satın aldıktan sonra \"Wanda\"\n<BlueQuality:Lv50>, <BlueQuality:Tüm Yetenekler Lv4> seviyesine ulaşabilir"
  },
  Activity_59843_ActivityName = {
    Text = "Değer Büyüme Paketi (Üretimden Kaldırıldı)"
  },
  Activity_59843_ActivityPlot = {
    Text = "Satın aldıktan sonra \"Tulu\"\n<BlueQuality:Lv50>, <BlueQuality:Tüm Yetenekler Lv4> seviyesine ulaşabilir"
  },
  Activity_59844_ActivityName = {
    Text = "Değer Büyüme Paketi (Üretimden Kaldırıldı)"
  },
  Activity_59844_ActivityPlot = {
    Text = "Satın aldıktan sonra \"Thais\"\n<BlueQuality:Lv50>, <BlueQuality:Tüm Yetenekler Lv4> seviyesine ulaşabilir"
  },
  Activity_59845_ActivityName = {
    Text = "Değer Büyüme Paketi (Üretimden Kaldırıldı)"
  },
  Activity_59845_ActivityPlot = {
    Text = "Satın aldıktan sonra \"Miryam\"\n<BlueQuality:Lv50>, <BlueQuality:Tüm Yetenekler Lv4> seviyesine ulaşabilir"
  },
  Activity_59846_ActivityName = {
    Text = "Değer Büyüme Paketi (Üretimden Kaldırıldı)"
  },
  Activity_59846_ActivityPlot = {
    Text = "Satın aldıktan sonra \"Hameln\"\n<BlueQuality:Lv50>, <BlueQuality:Tüm Yetenekler Lv4> seviyesine ulaşabilir"
  },
  Activity_59847_ActivityName = {
    Text = "Yankılanan Hac VIII"
  },
  Activity_59847_ActivityPlot = {
    Text = "Yanılsama Hafıza mühürlenip arşivlendi, geçmişe kaydedilen bir yolculuk. Anımsama anlarında, saygılı Haracınızı sunmayı unutmayın."
  },
  Activity_59848_ActivityName = {
    Text = "Yankılanan Hac III"
  },
  Activity_59848_ActivityPlot = {
    Text = "Yanılsama Hafıza mühürlenip arşivlendi, geçmişe kaydedilen bir yolculuk. Anımsama anlarında, saygılı Haracınızı sunmayı unutmayın."
  },
  Activity_59849_ActivityName = {
    Text = "Değer Büyüme Paketi (Üretimden Kaldırıldı)"
  },
  Activity_59849_ActivityPlot = {
    Text = "Satın aldıktan sonra \"Helot-catena\"\n<BlueQuality:Lv50>, <BlueQuality:Tüm Yetenekler Lv4> seviyesine ulaşabilir"
  },
  Activity_59850_ActivityName = {
    Text = "Yankılanan Hac I"
  },
  Activity_59850_ActivityPlot = {
    Text = "Yanılsama Hafıza mühürlenip arşivlendi, geçmişe kaydedilen bir yolculuk. Anımsama anlarında, saygılı Haracınızı sunmayı unutmayın."
  },
  Activity_59851_ActivityName = {
    Text = "Yankılanan Hac: Başlangıç"
  },
  Activity_59851_ActivityPlot = {
    Text = "Yanılsama Hafıza mühürlenip arşivlendi, geçmişe kaydedilen bir yolculuk. Anımsama anlarında, saygılı Haracınızı sunmayı unutmayın."
  },
  Activity_59852_ActivityName = {
    Text = "Yankılanan Hac VII"
  },
  Activity_59852_ActivityPlot = {
    Text = "Yanılsama Hafıza mühürlenip arşivlendi, geçmişe kaydedilen bir yolculuk. Anımsama anlarında, saygılı Haracınızı sunmayı unutmayın."
  },
  Activity_59853_ActivityName = {
    Text = "Yankılanan Hac VI"
  },
  Activity_59853_ActivityPlot = {
    Text = "Yanılsama Hafıza mühürlenip arşivlendi, geçmişe kaydedilen bir yolculuk. Anımsama anlarında, saygılı Haracınızı sunmayı unutmayın."
  },
  Activity_59854_ActivityName = {
    Text = "Yankılanan Hac V"
  },
  Activity_59854_ActivityPlot = {
    Text = "Yanılsama Hafıza mühürlenip arşivlendi, geçmişe kaydedilen bir yolculuk. Anımsama anlarında, saygılı Haracınızı sunmayı unutmayın."
  },
  Activity_59855_ActivityName = {
    Text = "Yankılanan Hac IV"
  },
  Activity_59855_ActivityPlot = {
    Text = "Yanılsama Hafıza mühürlenip arşivlendi, geçmişe kaydedilen bir yolculuk. Anımsama anlarında, saygılı Haracınızı sunmayı unutmayın."
  },
  Activity_59856_ActivityName = {
    Text = "Değer Büyüme Paketi (Üretimden Kaldırıldı)"
  },
  Activity_59856_ActivityPlot = {
    Text = "Satın aldıktan sonra \"Murphy\"\n<BlueQuality:Lv50>, <BlueQuality:Tüm Yetenekler Lv4> seviyesine ulaşabilir"
  },
  Activity_59857_ActivityName = {
    Text = "Değer Büyüme Paketi (Üretimden Kaldırıldı)"
  },
  Activity_59857_ActivityPlot = {
    Text = "Satın aldıktan sonra \"Ryker\"\n<BlueQuality:Lv50>, <BlueQuality:Tüm Yetenekler Lv4> seviyesine ulaşabilir"
  },
  Activity_59858_ActivityName = {
    Text = "Yankılanan Hac II"
  },
  Activity_59858_ActivityPlot = {
    Text = "Yanılsama Hafıza mühürlenip arşivlendi, geçmişe kaydedilen bir yolculuk. Anımsama anlarında, saygılı Haracınızı sunmayı unutmayın."
  },
  Activity_59859_ActivityName = {
    Text = "Değer Büyüme Paketi (Üretimden Kaldırıldı)"
  },
  Activity_59859_ActivityPlot = {
    Text = "Satın aldıktan sonra \"Sorel\"\n<BlueQuality:Lv50>, <BlueQuality:Tüm Yetenekler Lv4> seviyesine ulaşabilir"
  },
  Activity_59860_ActivityName = {
    Text = "Değer Büyüme Paketi (Üretimden Kaldırıldı)"
  },
  Activity_59860_ActivityPlot = {
    Text = "Satın aldıktan sonra \"Horla\"\n<BlueQuality:Lv50>, <BlueQuality:Tüm Yetenekler Lv4> seviyesine ulaşabilir"
  },
  Activity_59861_ActivityName = {
    Text = "Değer Büyüme Paketi (Üretimden Kaldırıldı)"
  },
  Activity_59861_ActivityPlot = {
    Text = "Satın aldıktan sonra \"Salvador\"\n<BlueQuality:Lv50>, <BlueQuality:Tüm Yetenekler Lv4> seviyesine ulaşabilir"
  },
  Activity_59862_ActivityName = {
    Text = "Değer Büyüme Paketi (Üretimden Kaldırıldı)"
  },
  Activity_59862_ActivityPlot = {
    Text = "Satın aldıktan sonra \"Tawil\"\n<BlueQuality:Lv50>, <BlueQuality:Tüm Yetenekler Lv4> seviyesine ulaşabilir"
  },
  Activity_59863_ActivityName = {
    Text = "Değer Büyüme Paketi (Üretimden Kaldırıldı)"
  },
  Activity_59863_ActivityPlot = {
    Text = "Satın aldıktan sonra \"Lily\"\n<BlueQuality:Lv50>, <BlueQuality:Tüm Yetenekler Lv4> seviyesine ulaşabilir"
  },
  Activity_59864_ActivityName = {
    Text = "Değer Büyüme Paketi (Üretimden Kaldırıldı)"
  },
  Activity_59864_ActivityPlot = {
    Text = "Satın aldıktan sonra \"24\"\n<BlueQuality:Lv50>, <BlueQuality:Tüm Yetenekler Lv4> seviyesine ulaşabilir"
  },
  Activity_59865_ActivityName = {
    Text = "Değer Büyüme Paketi (Üretimden Kaldırıldı)"
  },
  Activity_59865_ActivityPlot = {
    Text = "Satın aldıktan sonra \"Doll: Cehennem\" şu seviyeye yükseltilebilir:\n<BlueQuality:Sv50>, <BlueQuality:Tüm Beceriler Sv4>"
  },
  Activity_61156_ActivityName = {
    Text = "Final Arşivleri"
  },
  Activity_61156_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Final Arşivleri'nde ödülleri talep etmek için görevleri tamamlayın\n2. Final Arşivleri kalıcı olarak erişilebilir kalır\n3. Görev tamamlandığında ek ödüller kazanmak için Premium Arşivleri açın\nNot: Etkinleştirilen Premium Arşivler yalnızca bu Arşiv etkinliğinde geçerlidir."
  },
  Activity_61369_ActivityName = {
    Text = "Artan Ritim"
  },
  Activity_61369_ActivityPlot = {
    Text = "Koruyucular aşağıdaki sınırlı Kader Çarklarından birini ücretsiz olarak Uyandırabilir!"
  },
  Activity_61369_ActivityTips = {
    Text = "<Title:Genel Bakış>\nEntrikaların bulut gibi döndüğü gizemli Kara Havuz'da, Kader Çarkı durmaksızın dönüyor. Hameln'in müziğinin rehberliğinde, sayısız melodi yolculuğunuzun Çarkı'nda uyum içinde birleşiyor. Onların yardımı, kapanış senfonisinin son notasına kadar sizinle birlikte olsun.\n\n<Title:Etkinlik Kuralları>\nEtkinlik süresince, bir gün giriş yaparak aşağıdaki 12 sınırlı Çark'tan birini seçip uyandırabilirsiniz: Tanrı Kralın İlahisi, En Değerli Koleksiyon, Gül Adına, Acıyı Aşmak, Örtülü Doğuş, Kraliçenin Fermanı, Kutsal Söz Levhası, Sapkın Yutma, Dindarın Gücü, Son Dize, Merhametli Beslenme ve Şans Saati."
  },
  Activity_61369_BannerText = {
    Text = "Sınırlı bir Kader Çarkı'nı ücretsiz olarak alın"
  },
  Activity_61370_ActivityName = {
    Text = "Gümüş Kalp"
  },
  Activity_61370_ActivityPlot = {
    Text = "Her gün giriş yaparak hatıra sınırlı SSR Kader Çarkı \"Saf Gümüş Kalp\" talep edin, toplamda 16 adede kadar!"
  },
  Activity_61370_ActivityTips = {
    Text = "<Title:Giriş>\nDünya ne kadar altüst olursa olsun, herkes orijinal, saf gümüş kalbini koruduğu sürece, hikâye kaçınılmaz olarak tekrar edecek ve ıssız topraklar üzerinde yeni hayat yeniden doğacaktır.\n\n<Title:Etkinlik Kuralları>\nEtkinlik süresince, Koruyucular her gün giriş yaparak sınırlı sayıda SSR Kader Çarkı \"Saf Gümüş Kalp\" talep edebilir, toplamda 16 talep hakkı vardır.\nÖdüller, Koruyucuların kümülatif girişlerine göre sırayla açılacak ve günlük giriş ödülleri sabah 9'da (GMT+8) yenilenecektir."
  },
  Activity_61370_BannerText = {
    Text = "Ücretsiz Sınırlı SSR YK"
  },
  Activity_61371_ActivityName = {
    Text = "Altı Kanatlı Dualar"
  },
  Activity_61371_ActivityPlot = {
    Text = "Kara Havuz'un kargaşası ortasında, sonsuz Boyutlardan gelen Gümüş, boyutsal yarıklar aracılığıyla kıyılarına saçıldı. Tawil onları özenle topladı ve Kara Havuz'un bir köşesine yerleştirdi. Bu Gümüşler Çözünme'nin yayılmasını durduramasa da, içlerinde barındırdıkları duygular ve hisler sonsuza dek parlak bir şekilde ışıldayacaktır."
  },
  Activity_61371_ActivityTips = {
    Text = "<Title:Genel Bakış>\nKara Havuz'un kargaşası ortasında, sonsuz Boyutlardan boyutsal yarıklar aracılığıyla saçılan Gümüş, Kara Havuz'un kenarında yatıyor. Tawil onları özenle topluyor ve Kara Havuz'un bir köşesine yerleştiriyor. Bu Gümüşler Çözünme'nin yayılmasını durduramasa da, barındırdıkları anılar ve duygular her zaman parlak bir şekilde ışıldayacaktır.\n\n<Title:Etkinlik Kuralları>\nEtkinlik süresince Koruyucular, etkinlik boyunca her gün giriş yaparak 1000 Gümüş alabilir, maksimum 6 talep hakkı vardır.\n7. kümülatif giriş gününde, Koruyucular sınırlı Uyandırıcı \"Tawil\"i doğrudan talep edebilir!\nÖdüller, Koruyucuların kümülatif günlük girişlerine göre sırayla açılacak ve günlük giriş ödülleri sabah 9'da (GMT+8) yenilenecektir."
  },
  Activity_61371_BannerText = {
    Text = "Giriş yaparak bol miktarda Gümüş kazanın"
  },
  Activity_61482_ActivityName = {
    Text = "Terfi Anma Hediyesi V"
  },
  Activity_61482_ActivityPlot = {
    Text = "Yol uzun uzadıya uzanıyor, Çözünme'nin karanlığına bürünmüş.\nGümüş Anahtar'ın ışığı hepimize yol gösterecek."
  },
  Activity_61483_ActivityName = {
    Text = "Terfi Anma Hediyesi IV"
  },
  Activity_61483_ActivityPlot = {
    Text = "Yol uzun uzadıya uzanıyor, Çözünme'nin karanlığına bürünmüş.\nGümüş Anahtar'ın ışığı hepimize yol gösterecek."
  },
  Activity_61484_ActivityName = {
    Text = "Terfi Anma Hediyesi VII"
  },
  Activity_61484_ActivityPlot = {
    Text = "Yol uzun uzadıya uzanıyor, Çözünme'nin karanlığına bürünmüş.\nGümüş Anahtar'ın ışığı hepimize yol gösterecek."
  },
  Activity_61485_ActivityName = {
    Text = "Terfi Anma Hediyesi VI"
  },
  Activity_61485_ActivityPlot = {
    Text = "Yol uzun uzadıya uzanıyor, Çözünme'nin karanlığına bürünmüş.\nGümüş Anahtar'ın ışığı hepimize yol gösterecek."
  },
  Activity_61486_ActivityName = {
    Text = "Terfi Anma Hediyesi I"
  },
  Activity_61486_ActivityPlot = {
    Text = "Yol uzun uzadıya uzanıyor, Çözünme'nin karanlığına bürünmüş.\nGümüş Anahtar'ın ışığı hepimize yol gösterecek."
  },
  Activity_61487_ActivityName = {
    Text = "Terfi Anma Hediyesi III"
  },
  Activity_61487_ActivityPlot = {
    Text = "Yol uzun uzadıya uzanıyor, Çözünme'nin karanlığına bürünmüş.\nGümüş Anahtar'ın ışığı hepimize yol gösterecek."
  },
  Activity_61488_ActivityName = {
    Text = "Terfi Anma Hediyesi II"
  },
  Activity_61488_ActivityPlot = {
    Text = "Yol uzun uzadıya uzanıyor, Çözünme'nin karanlığına bürünmüş.\nGümüş Anahtar'ın ışığı hepimize yol gösterecek."
  },
  Activity_61489_ActivityName = {
    Text = "Terfi Anma Hediyesi VIII"
  },
  Activity_61489_ActivityPlot = {
    Text = "Yol uzun uzadıya uzanıyor, Çözünme'nin karanlığına bürünmüş.\nGümüş Anahtar'ın ışığı hepimize yol gösterecek."
  },
  Activity_61517_ActivityName = {
    Text = "Operasyon İkmal Kutusu"
  },
  Activity_61517_ActivityPlot = {
    Text = "Mythag İdari Ofisi tarafından sağlanan Operasyon İkmalleri. Alistair tarafından Kara Havuz'un enkazından arıtılmıştır."
  },
  Activity_61546_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61546_ActivityPlot = {
    Text = "Satın alma sonrasında \"Tulu\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Açılır>"
  },
  Activity_61547_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61547_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Horla\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61548_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61548_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Faros\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61549_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61549_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Alva\" şunları aktive edebilir:\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Aç>"
  },
  Activity_61550_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61550_ActivityPlot = {
    Text = "Satın alma sonrasında \"Jenkin\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Açılır>"
  },
  Activity_61551_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61551_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Pandia\" şunları aktive edebilir:\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Aç>"
  },
  Activity_61552_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61552_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Celeste\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61553_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61553_ActivityPlot = {
    Text = "Satın alındıktan sonra \"24\", <BlueQuality:Aydınlanma 3> aktive edebilir"
  },
  Activity_61554_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61554_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Faint\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61555_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61555_ActivityPlot = {
    Text = "Satın alma sonrasında \"Tinktur\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Açılır>"
  },
  Activity_61556_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61556_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Casiah\", <BlueQuality:Aydınlanma 3> aktive edebilir"
  },
  Activity_61557_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61557_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Salvador\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61558_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61558_ActivityPlot = {
    Text = "Satın alma sonrasında \"Salvador\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Açılır>"
  },
  Activity_61559_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61559_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Thais\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61560_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61560_ActivityPlot = {
    Text = "Satın alma sonrasında \"Lily\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4>, Aşırı Yüceltme açılır"
  },
  Activity_61561_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61561_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Golyat\" <BlueQuality:Aydınlanma> 3 aktifleştirebilir"
  },
  Activity_61562_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61562_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Lily\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61563_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61563_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Sanga\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61564_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61564_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Nergis\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61565_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61565_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Nautila\" şunları aktive edebilir:\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Aç>"
  },
  Activity_61566_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61566_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Karen\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61567_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61567_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Alva\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61568_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61568_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Leigh\" <BlueQuality:Aydınlanma 3> aktifleştirebilir"
  },
  Activity_61569_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61569_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Tulu\", <BlueQuality:Aydınlanma 3> aktive edebilir"
  },
  Activity_61570_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61570_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Caecus\" <BlueQuality:Aydınlanma 3> aktifleştirebilir"
  },
  Activity_61571_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61571_ActivityPlot = {
    Text = "Satın alma sonrasında \"Winkle\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Açılır>"
  },
  Activity_61572_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61572_ActivityPlot = {
    Text = "Satın alma sonrasında \"Wanda\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Açılır>"
  },
  Activity_61573_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61573_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Golyat\" şunları aktive edebilir:\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Aç>"
  },
  Activity_61574_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61574_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Ryker\", <BlueQuality:Aydınlanma 3> aktive edebilir"
  },
  Activity_61575_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61575_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Nymphaea\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61576_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61576_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Caecus\" şunları aktive edebilir:\n<BlueQuality:Ruh Dalgalanması +4>, Aşırı Yüceltme kilidi açılır"
  },
  Activity_61577_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61577_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Miryam\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61578_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61578_ActivityPlot = {
    Text = "Satın alma sonrasında \"Ryker\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Açılır>"
  },
  Activity_61579_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61579_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Sanga\" şunları aktive edebilir:\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Aç>"
  },
  Activity_61580_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61580_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Tinktur\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61581_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61581_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Leigh\" şunları aktive edebilir:\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Aç>"
  },
  Activity_61582_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61582_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Liz\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61583_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61583_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Helot\" şunları aktive edebilir:\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Aç>"
  },
  Activity_61584_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61584_ActivityPlot = {
    Text = "Satın alma sonrasında \"Casiah\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme açılır>"
  },
  Activity_61585_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61585_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Faros\" şunları aktive edebilir:\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Aç>"
  },
  Activity_61586_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61586_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Agrippa\" şunları aktive edebilir:\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Aç>"
  },
  Activity_61587_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61587_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Nautila\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61588_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61588_ActivityPlot = {
    Text = "Satın alma sonrasında \"Nergis\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Açılır>"
  },
  Activity_61589_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61589_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Hameln\", <BlueQuality:Aydınlanma 3> aktive edebilir"
  },
  Activity_61590_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61590_ActivityPlot = {
    Text = "Satın alma sonrasında \"Liz\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme açılır>"
  },
  Activity_61591_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61591_ActivityPlot = {
    Text = "Satın alma sonrasında \"Miryam\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4>, Aşırı Yüceltme açılır"
  },
  Activity_61592_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61592_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Wanda\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61593_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61593_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Karen\" şunları aktive edebilir:\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Aç>"
  },
  Activity_61594_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61594_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Uvhash\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61595_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61595_ActivityPlot = {
    Text = "Satın alma sonrasında \"Thais\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Açılır>"
  },
  Activity_61596_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61596_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Uvhash\" şunları aktive edebilir:\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Aç>"
  },
  Activity_61597_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61597_ActivityPlot = {
    Text = "Satın alma sonrasında \"Hameln\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Açılır>"
  },
  Activity_61598_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61598_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Murphy\", <BlueQuality:Aydınlanma 3> aktive edebilir"
  },
  Activity_61599_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61599_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Sorel\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61600_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61600_ActivityPlot = {
    Text = "Satın alma sonrasında \"Sorel\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Açılır>"
  },
  Activity_61601_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61601_ActivityPlot = {
    Text = "Satın alımdan sonra, \"\"Helot\"\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61602_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61602_ActivityPlot = {
    Text = "Satın alma sonrasında \"Horla\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Açılır>"
  },
  Activity_61603_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61603_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Tawil\", <BlueQuality:Aydınlanma 3> aktive edebilir"
  },
  Activity_61604_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61604_ActivityPlot = {
    Text = "Satın alma sonrasında \"24\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Açılır>"
  },
  Activity_61605_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61605_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Agrippa\" <BlueQuality:Aydınlanma 3> aktifleştirebilir"
  },
  Activity_61606_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61606_ActivityPlot = {
    Text = "Satın alımdan sonra, \"\"Pandia\"\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61607_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61607_ActivityPlot = {
    Text = "Satın alma sonrasında \"Helot-catena\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Açılır>"
  },
  Activity_61608_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61608_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Jenkin\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61609_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61609_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Nymphaea\" şunları aktive edebilir:\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Aç>"
  },
  Activity_61610_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61610_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Winkle\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_61611_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61611_ActivityPlot = {
    Text = "Satın alma sonrasında \"Faint\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme açılır>"
  },
  Activity_61612_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61612_ActivityPlot = {
    Text = "Satın alma sonrasında \"Murphy\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Açılır>"
  },
  Activity_61613_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61613_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Tawil\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_61614_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_61614_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Helot-catena\", <BlueQuality:Aydınlanma 3> aktive edebilir"
  },
  Activity_61615_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_61615_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Celeste\" şunları aktive edebilir:\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Aç>"
  },
  Activity_65387_ActivityName = {
    Text = "Okul Kedisinin Özrü"
  },
  Activity_65387_ActivityPlot = {
    Text = "Okulun koruma önlemlerindeki son açıklar nedeniyle, <Del:\"Önerilen Çeviri, Kırmızı Nokta\"> kampüsteki Çözünme Taciz olayları artmış ve öğrencilere büyük rahatsızlık vermiştir. Bu nedenle okul yönetimi, tazminat olarak malzeme dağıtmak üzere birden fazla tedarik noktası kurmuştur. (Tesis yönetimi ihmalinin sorumluluğu göz önüne alındığında, bu seferkitüm tedarik malzemeleri tamamen Okul Kedisi tarafından taşınacaktır.)"
  },
  Activity_65387_ActivityTips = {
    Text = "<Title:Genel Bakış>\nSon zamanlarda okulun koruma önlemlerindeki açıklar nedeniyle, kampüste <Del>\"geçici metin, kırmızı nokta\"> çözünme olayları artmış ve öğrencilere büyük rahatsızlık vermiştir. Bu nedenle okul yönetimi, tazminat olarak envanter dağıtmak üzere birden fazla tedarik noktası kurmuştur. (Tesis yönetimi hatalarının sorumluluğu nedeniyle, malzeme dağıtımı tamamen okul kedisi tarafından yapılacaktır.)\n\n<Title:Etkinlik Kuralları>\nEtkinlik süresince, Koruyucular her gün giriş yaparak \"Okul Kedisinin Özrü\" bölümünden 500 Gümüş talep edebilir, maksimum 5 talep hakkı vardır.\nÖdüller, Koruyucuların kümülatif günlük girişlerine göre sırayla açılacak ve günlük giriş ödülleri sabah 9'da (GMT+8) yenilenecektir."
  },
  Activity_65387_BannerText = {
    Text = "Giriş yaparak Gümüş kazanın"
  },
  Activity_65502_ActivityName = {
    Text = "İlerleyen Ritim: Düet"
  },
  Activity_65502_ActivityPlot = {
    Text = "Koruyucular aşağıdaki sınırlı Kader Çarklarından birini ücretsiz olarak Uyandırabilir!"
  },
  Activity_65502_ActivityTips = {
    Text = "<Title:Genel Bakış>\nEntrikaların bulut gibi döndüğü gizemli Kara Havuz'da, Kader Çarkı durmaksızın dönüyor. Hameln'in müziğinin rehberliğinde, sayısız melodi yolculuğunuzun Çarkı'nda uyum içinde birleşiyor. Onların yardımı, kapanış senfonisinin son notasına kadar sizinle birlikte olsun.\n\n<Title:Etkinlik Kuralları>\nEtkinlik süresince, bir gün giriş yaparak aşağıdaki 12 sınırlı Çark'tan birini seçip uyandırabilirsiniz: Tanrı Kralın İlahisi, En Değerli Koleksiyon, Gül Adına, Acıyı Aşmak, Örtülü Doğuş, Kraliçenin Fermanı, Kutsal Söz Levhası, Sapkın Yutma, Dindarın Gücü, Son Dize, Merhametli Beslenme ve Şans Saati."
  },
  Activity_65502_BannerText = {
    Text = "Sınırlı bir Kader Çarkı'nı ücretsiz olarak alın"
  },
  Activity_65521_ActivityName = {
    Text = "Operasyon İkmal Kutusu"
  },
  Activity_65521_ActivityPlot = {
    Text = "Mythag İdari Ofisi tarafından sağlanan Operasyon İkmalleri. Alistair tarafından Kara Havuz'un enkazından arıtılmıştır."
  },
  Activity_65949_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65949_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65950_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65950_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65951_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65951_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65952_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65952_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65953_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65953_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65954_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65954_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65955_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65955_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65956_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65956_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65957_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65957_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65958_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65958_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65959_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65959_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65960_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65960_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65961_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65961_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65962_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65962_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65963_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65963_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65964_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65964_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65965_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65965_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65966_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65966_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65967_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65967_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65968_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65968_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65969_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65969_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65970_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65970_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65971_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65971_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65972_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65972_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65973_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65973_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65974_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65974_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65975_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65975_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65976_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65976_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65977_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65977_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65978_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65978_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65979_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65979_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65980_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65980_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65981_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65981_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65982_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65982_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65983_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65983_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65984_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65984_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65985_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65985_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65986_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65986_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65987_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65987_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65988_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65988_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65989_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65989_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65990_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65990_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65991_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65991_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65992_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65992_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65993_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65993_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65994_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65994_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65995_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65995_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65996_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65996_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65997_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65997_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65998_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65998_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_65999_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_65999_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_66000_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_66000_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_66001_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_66001_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_66002_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_66002_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_66003_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_66003_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_66004_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_66004_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_66005_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_66005_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_66006_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_66006_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_66007_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_66007_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_66008_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_66008_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_66009_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_66009_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_66010_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_66010_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_66011_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_66011_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_66012_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_66012_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_66013_ActivityName = {
    Text = "Mythag'dan Hediyeler"
  },
  Activity_66013_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular her gün giriş yaptıktan sonra \"Mythag'dan Hediyeler\" bölümünden günlük giriş ödüllerini talep edebilir.\n2. Ödüller, Koruyucunun toplam giriş günlerine göre sırayla açılacaktır. Günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_66375_ActivityName = {
    Text = "Belirleyici: İlksel Gölge"
  },
  Activity_66375_ActivityPlot = {
    Text = "Bakışları sayısız boyutu tarıyor, sayısız gümüş figür gözleriyle buluşuyor.\nKüçücükler, kırılganlar. Ölene dek hatırlamak için savaşıyorlar"
  },
  Activity_66375_ActivityStageEndContent = {
    Text = "Etkinlik tamamlandı. Soruşturmaya devam edin."
  },
  Activity_66375_ActivityTips = {
    Text = "<Title:Ortak Savaş: İlkel>\n \"Ortak Savaş: İlkel\", İlkel’in Vizyonu’nu doğrudan hedef alan, tekrar edilemeyen 7 bölümden oluşur. Etkinliğin ilk gününde ilk 3 bölüm açılacak, ardından her 3 günde bir yeni bir bölüm açılacaktır.\nİlkel’in ilgili Vizyonu’na her başarılı meydan okumanızda, buna karşılık gelen ödülü alırsınız.\nHer tür İlkel Vizyonu’nun birden fazla klonu vardır. Herhangi bir Koruyucu belirli bir tür İlkel Vizyonu’nu başarıyla alt ettiğinde, o türe ait \"Dünya Tortusu Sayısı\" 1 azalır. O türe ait tüm klonlar yok edildiğinde, ilgili bölüm kapanır ve bir daha meydan okunamaz.\nTüm bölümler \"Bölgesel D-Etkisi’nin D-Dalgası: Son\" dan etkilenir, ancak her bölüm size farklı \"Saf Çekirdek\" Kalıntıları sunar; bunlar size güçlü güçlendirmeler sağlar. Ayrıca her bölüm, Tawil’e savaşın başında 120 Aliemus veren ve Tawil’in verdiği tüm Hasar, Kalkan ve İyileştirme etkilerini %50 artıran bir \"Gnosis’in Gözü\" Kalıntısı da sağlar.\nTüm bölümlerde yardım seçmek zorunludur. Etkinlik boyunca, karşılıklı takipte olduğunuz her Koruyucu size yalnızca bir kez yardım sağlayabilir. Yardım kullanımı sayesinde, gerçek Afinite ödülü temel ödülün üzerine ek olarak %50 daha artar.\nKoruyucuların bu etkinliğe katılabilmek için en az Soruşturma Operasyonları 2-9’u tamamlamış olmaları gerekir.\n\n<Title:Soruşturma Operasyonu: Son Bölüm>\nHer bir İlkel Vizyonu’nun asıl gövdesi, hâlâ Soruşturma Operasyonları 9-5’ten 9-11’e kadar olan bölümlerde bizzat sizin tarafınızdan yenilmelidir. Bu özel bölümlerde başarılar yoktur, yıldız derecelendirmesi yoktur, \"Gnosis’in Gözü\" Kalıntısı veya yardım kullanılamaz ve zorlukları daha yüksektir.\n \"Ortak Savaş: İlkel\" etkinliği sona erdikten sonra, \"Soruşturma Operasyonu: Son Bölüm\"ün sonraki bölümleri açılacaktır. Diğer Koruyucularla birlikte çeşitli İlkel Vizyonu klonlarının hepsini topluca yok ettiğinizde, Soruşturma Operasyonları 9-5’ten 9-11’e kadar olan ilgili bölümleri önceden açabilirsiniz."
  },
  Activity_66375_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_66908_ActivityName = {
    Text = "Bereket Nefesi"
  },
  Activity_66908_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Bereket Nefesi\" etkinliği süresince, Koruyucular Thais içeren sistem tarafından hazırlanmış takımları kullanarak belirlenen bölümleri sınırsız sayıda deneyimleyebilir.\nEtkinlik bölümlerini oynarken, takım dizilişindeki Uyandırıcı üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBir bölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_67077_ActivityName = {
    Text = "Yankılanan Hac IX"
  },
  Activity_67077_ActivityPlot = {
    Text = "Yanılsama Hafıza mühürlenip arşivlendi, geçmişe kaydedilen bir yolculuk. Anımsama anlarında, saygılı Haracınızı sunmayı unutmayın."
  },
  Activity_67718_ActivityName = {
    Text = "Bahar Solmadan Önce: Tekrar"
  },
  Activity_67718_ActivityPlot = {
    Text = "Ateş başlamadan önce kız çocukların kahkahaları bahçede yankılanır.\nBu güzel geçmiş için dur biraz, dostum.\nSolmamış baharın öykülerini dinle, usulca anlatılan."
  },
  Activity_67718_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Colette'in Çiçek Evi\" alınabilir."
  },
  Activity_67718_ActivityTips = {
    Text = "<Title:Etkinlik Tanıtımı>\n1, Etkinlik süresince, Koruyucular sınırlı süreli oynanış \"Anılar Bahçesi\", \"İlham Perisi'nin Öpücüğü\" ve \"Başarı Ödülleri\" aracılığıyla üç tür \"Şiir\" toplayabilir; \"Şiir\" ler \"Colette'in Çiçek Evi\" nde takas edilerek eşya ödülleri kazanmak için kullanılabilir; bu ödüller arasında etkinliğe özel SR Kader Çarkı \"Geçmişin Çiçekleri ve Şiirleri\", \"Saf Çekirdek\", \"Işıltılı Çekirdek\", \"Eterik Parça\", \"Mimetik Kristal\" ve daha fazlası yer almaktadır.\n2, Etkinlik süresince \"Özel Harekat: Rose'un Meskeni\"ücretsiz olarak açılacaktır.\n\n<Title:Etkinlik Süresi>\n1,10 Ağustos 9:00 - 7 Eylül 9:00(GMT+8), tüm etkinlik içeriklerine katılabilirsiniz.\n2,7 Eylül 9:00 - 14 Eylül 9:00(GMT+8), yalnızca \"Colette'in Çiçek Evi\" ve \"Başarı Ödülleri\" korunur; diğer içerikler Sona Erdi ve katılılamaz.\n\n<Title: Anılar Bahçesi>\n1,\"Anılar Bahçesi\" 5 sahne içerir; her 2 günde 1 sahne otomatik olarak açılır.\n2, Her meydan okuma \"Menofin\" × 120 tüketir; meydan okumayı başarıyla tamamlamak etkinlik para birimi \"Keder Şiirleri\", \"Pişmanlık Şiirleri\" ve \"Neşe Şiirleri\" kazandırır.\n3, Sahneyi temizledikten sonra o sahnenin \"Yeniden Canlandırma\"özelliği açılır. Lütfen dikkat: \"Yeniden Canlandırma\"özelliği kullanılırken Afinite kazanılamaz.\n4, Geçişi daha kolay tamamlamak için mezunlar derneği Destek'ini ve \"Rezonans: Bahçe Ağıtı\" nı kullanabilirsiniz.\n5, Sahne açıldıktan 2. gün, o sahnenin Delilik Zorluğu açılır. Delilik Zorluğu'nu ilk kez tamamlamak bol miktarda etkinlik para birimi ödülü kazandırır.\n6, Lütfen dikkat: Delilik Zorluğu meydan okuması Menofin tüketmez, Yeniden Canlandırılamaz ve ilk geçişten sonra tekrar meydan okumak etkinlik para birimi ödülü kazandırmaz.\n\n<Title: Şiir Bonusu>\n1, Koruyucuların belirli Uyandırıcılara veya Kader Çarklarına sahip olması(sahaya sürülmesi gerekmez) \"Anılar Bahçesi\" sahne görevi ödüllerindeki \"Keder Şiirleri\", \"Pişmanlık Şiirleri\" ve \"Neşe Şiirleri\" için ekstra düşme bonusu sağlar(Yeniden Canlandırma dahil); ayrıntılı bonuslar aşağıdaki gibidir:\n·Uyandırıcı \"Horla\": Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n·SSR Kader Çarkı \"Son Dize\": Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n·SR Kader Çarkı \"Geçmişin Çiçekleri ve Şiirleri\": Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n2, Farklı Uyandırıcı veya Kader Çarklarının \"Şiir Bonusu\" birikimli olarak hesaplanır.\n3,Özellikle, Delilik Zorluğu ilk geçiş meydan okuma ödülleri \"Şiir Bonusu\" ndan etkilenmez.\n\n<Title:Rezonans: Bahçe Ağıtı>\n1, Koruyucular etkinlik başarımlarını tamamlayarak \"Kül Kalbi\" elde edebilir.\n2,\"Kül Kalbi\" harcayarak \"Rezonans: Bahçe Ağıtı\" nı etkinleştirmek aşağıdaki bonusları sağlar:\n(1) Koruyucuyu etkinlik oynanışı \"Anılar Bahçesi\" nde daha güçlü kılar ve meydan okumaları daha kolay hale getirir.\n(2) \"Anılar Bahçesi\" meydan okumasını tamamladıktan sonra kazanılan etkinlik para birimini artırır.\n(3) Etkinlik oynanışı \"İlham Perisi'nin Öpücüğü\" nü etkinleştirir.\n\n<Title: İlham Perisi'nin Öpücüğü>\n·\"Her Şey Büyür\" Rezonansı etkinleştirildikten sonra, her saat otomatik olarak \"Keder Şiirleri\" × 60 kazanılır; en fazla 25 saat depolanabilir.\n·\"Çiçekler İçin Dize\" Rezonansı etkinleştirildikten sonra, \"İlham Perisi'nin Öpücüğü\" her saat ekstra \"Pişmanlık Şiirleri\" × 60 kazandırır.\n\n<Title: Colette'in Çiçek Evi>\n1,\"Colette'in Çiçek Evi\" nin üç çiçek tarhı bulunmaktadır; açılış saatleri aşağıdaki gibidir:\n·\"Süsen Tarhı\": 10 Ağustos saat 9'da açılır.\n·\"Baloncuk Çiçeği Tarhı\": 12 Ağustos saat 9'da açılır.\n·\"Gül Tarhı\": 14 Ağustos saat 9'da açılır.\n2, Her takas \"Keder Şiirleri\"/\"Pişmanlık Şiirleri\"/\"Neşe Şiirleri\" × 750 tüketir; tarhtan rastgele beş eşya ödülü kazanılır.\n3, Her çiçek tarhının eşya ödülleri \"Özel Eşyalar\" ve \"Sıradan Eşyalar\" olmak üzere iki türe ayrılır; sıfırlama yapıldığında Özel Eşya ödüllerinin Kalan miktarı üst sınıra sıfırlanabilir; ayrıntılı kurallar şöyledir:\n(1) İlk 2 sıfırlamada: \"Özel Eşyalar\"ın Kalan miktarı kalmadığında Koruyucu sıfırlamayı seçebilir; sıfırlandığında \"Özel Eşyalar\" ve \"Sıradan Eşyalar\"ın Kalan miktarı üst sınıra sıfırlanır; ya da takas etmeye devam etmeyi seçebilir; \"Sıradan Eşyalar\"ın da Kalan miktarı kalmadığında takas etmeye devam etmek için sıfırlama yapılması gerekir.\n(2) 3. sıfırlamadan itibaren: Yalnızca \"Sıradan Eşyalar\"ın Kalan miktarı kalmadığında sıfırlama yapılabilir; sıfırlama \"Sıradan Eşyalar\"ın Kalan miktarını üst sınıra sıfırlar; \"Özel Eşyalar\" artık sıfırlanmaz.\n4,14 Eylül 9:00(GMT+8) sonrasında, takas edilmemiş Kalan \"Şiir\" ler her biri \"Altın Gül\" × 40 oranında geri toplanacaktır; Koruyucuların postalarını kontrol etmesini öneririz.\n\n<Title: Özel Harekat>\n1, Etkinlik süresince \"Özel Harekat: Rose'un Meskeni\"ücretsiz olarak açılacaktır. Her 2 günde bir yeni olay yayınlanır; \"Özel Harekat: Rose'un Meskeni\" ni temizledikten sonra Başarı Ödülleri'nden Gümüş, etkinliğe özel SR Kader Çarkı \"Geçmişin Çiçekleri ve Şiirleri\" ve diğer ödüller kazanılabilir; Başarı Ödülleri yalnızca etkinlik süresince açıktır, etkinlik sona erdikten sonra tamamlanamaz ve alınamaz.\n2, Etkinlik sona erdikten sonra, \"Özel Harekat: Rose'un Meskeni\" nin soruşturma ilerlemesi korunur; etkinlik süresince \"Özel Harekat: Rose'un Meskeni\" açılmadıysa, etkinlik sona erdikten sonra \"Gerçeklik Başlangıç Noktası\" ×7 harcayarak açılabilir.\n3, Etkinlik süresinde olsun ya da olmasın, \"Özel Harekat: Rose'un Meskeni\" ni temizledikten sonra \"Müfreze: Bahar Şiiri\" elde edilebilir."
  },
  Activity_67718_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_67719_ActivityName = {
    Text = "İtiraf Etkinliği İndirim Kilidi Aktivitesi"
  },
  Activity_67721_ActivityName = {
    Text = "Bahar Solmadan Önce: Tekrar"
  },
  Activity_67721_ActivityPlot = {
    Text = "Ateş başlamadan önce kız çocukların kahkahaları bahçede yankılanır.\nBu güzel geçmiş için dur biraz, dostum.\nSolmamış baharın öykülerini dinle, usulca anlatılan."
  },
  Activity_67721_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Colette'in Çiçek Evi\" alınabilir."
  },
  Activity_67721_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli oynanışlar olan \"Bahçe Hatıraları\", \"Musa'nın Öpücüğü\" ve \"Başarı Ödülleri\" aracılığıyla üç tür \"Şiir\" toplayabilir. Bu Şiirler, \"Colette'in Çiçekçi Dükkânı\"nda etkinliğe özel SR Kader Çarkı \"Geçmişin Çiçekleri ve Şiirleri\", Saflaştırılmış Çekirdek, Lümen Çekirdeği, Eter Taşı Kırıntısı, Taklit Kristali ve daha fazlasını içeren eşya ödülleriyle takas edilebilir.\n2. Etkinlik süresince \"Özel Operasyonlar: Gülün Yurdu\" ücretsiz olarak erişime açık olacaktır.\n\n<Title:Etkinlik Süresi>\n1. 25 Ağustos 9:00 - 8 Eylül 9:00 (GMT+8) arasında tüm etkinlik içerikleri erişime açık olacaktır.\n2. 8 Eylül 9:00 - 15 Eylül 9:00 (GMT+8) arasında yalnızca \"Colette'in Çiçekçi Dükkânı\" ve \"Başarı Ödülleri\" erişilebilir olacaktır. Diğer tüm içeriklere artık ulaşılamaz.\n\n<Title: Bahçe Hatıraları>\n1. \"Bahçe Hatıraları\" 5 aşamadan oluşur; her 2 günde bir yeni bir aşama kendiliğinden açılır.\n2. Her meydan okuma 120 Menophin tüketir. Meydan okumayı başarıyla tamamlamak, etkinlik parası olan \"Hüzün Şiirleri\", \"Pişmanlık Şiirleri\" ve \"Sevinç Şiirleri\" kazandırır.\n3. Bir aşama tamamlandıktan sonra o aşamanın \"Yeniden Canlandır\" işlevi açılır. Lütfen dikkat: \"Yeniden Canlandır\" işlevini kullanmak Yakınlık kazandırmaz.\n4. Yardım için Alumnis kullanabilir ve aşamaları daha kolay geçmek için \"Rezonans: Bahçe Ağıdı\"nı etkinleştirebilirsiniz.\n\n<Title: Şiir Bonusları>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olmak (savaşa sokulmaları gerekmez), \"Bahçe Hatıraları\" aşama ödüllerinden (Yeniden Canlandır dâhil) \"Hüzün Şiirleri\", \"Pişmanlık Şiirleri\" ve \"Sevinç Şiirleri\" için ek düşüş bonusları sağlar. Bonuslar şöyledir:\n Uyanan \"Horla\": Aydınlanma 0/1/2/3+, Bonus %20/%30/%40/%50\n SSR Kader Çarkı \"Son Dize\": Yükseliş 0/1/2/3+, Bonus %20/%30/%40/%50\n SR Kader Çarkı \"Geçmişin Çiçekleri ve Şiirleri\": Yükseliş 0/1/2/3+, Bonus %20/%30/%40/%50\n2. Farklı Uyananlar veya Kader Çarklarından gelen Şiir Bonusları üst üste eklenir.\n3. Özel Not: Delilik Zorluğu’ndaki ilk kez tamamlama ödülleri Şiir Bonuslarından etkilenmez.\n\n<Title: Rezonans: Bahçe Ağıdı>\n1. Muhafızlar, etkinlik başarımlarını tamamlayarak \"Küllerin Kalbi\" elde edebilir.\n2. \"Küllerin Kalbi\"ni tüketerek \"Rezonans: Bahçe Ağıdı\"nı etkinleştirmek aşağıdaki bonusları sağlar:\n(1) Muhafızları \"Bahçe Hatıraları\" etkinlik oynanışında güçlendirir, meydan okumaları kolaylaştırır.\n(2) \"Bahçe Hatıraları\" meydan okumalarını tamamladıktan sonra elde edilen etkinlik parası miktarını artırır.\n(3) \"Musa'nın Öpücüğü\" etkinlik oynanışını açar.\n\n<Title: Musa'nın Öpücüğü>\n Rezonans \"Her Şey Filizlenir\" etkinleştirildikten sonra, saatte otomatik olarak 60 \"Hüzün Şiiri\" kazanılır; en fazla 25 saatlik birikim yapılabilir.\n Rezonans \"Çiçekler İçin Dize\" etkinleştirildikten sonra, \"Musa'nın Öpücüğü\" saatte fazladan 60 \"Pişmanlık Şiiri\" daha kazandırır.\n\n<Title: Colette'in Çiçekçi Dükkânı>\n1. \"Colette'in Çiçekçi Dükkânı\"nda üç bahçe bulunur; açılış zamanları şöyledir:\n Süseni Bahçesi: 25 Ağustos 9:00’da açılır.\n Çan Çiçeği Bahçesi: 27 Ağustos 9:00’da açılır.\n Gül Bahçesi: 29 Ağustos 9:00’da açılır.\n2. Her takas 750 \"Hüzün Şiiri\"/\"Pişmanlık Şiiri\"/\"Sevinç Şiiri\" tüketir ve bahçedeki beş eşyadan birini rastgele ödül olarak verir.\n3. Her bahçenin ödülleri \"Özel Eşyalar\" ve \"Sıradan Eşyalar\" olarak ikiye ayrılır. Sıfırlama yapıldığında, kalan Özel Eşyaların sayısı yeniden azami seviyeye döndürülebilir. Ayrıntılı kurallar şöyledir:\n(1) İlk 2 Sıfırlama: Hiç \"Özel Eşya\" kalmadığında Muhafızlar sıfırlamayı seçebilir; bu, hem \"Özel Eşyalar\"ın hem de \"Sıradan Eşyalar\"ın sayısını azami seviyeye geri getirir; ya da takasa devam etmeyi seçebilirler. \"Sıradan Eşyalar\" da tükendiğinde, takasa devam etmek için sıfırlama zorunludur.\n(2) 3. Sıfırlamadan itibaren: Sıfırlama yalnızca \"Sıradan Eşyalar\" tükendiğinde yapılabilir. Sıfırlama, \"Sıradan Eşyalar\"ın kalan sayısını azami seviyeye döndürür, ancak \"Özel Eşyalar\" artık sıfırlanmaz.\n4. 15 Eylül 9:00’dan (GMT+8) sonra, takas edilmeden kalan tüm \"Şiirler\" sabit oranda otomatik olarak \"Gül Senedi*40\"a dönüştürülecektir. Lütfen oyun içi postanızı kontrol edin.\n\n<Title: Özel Operasyonlar>\n1. Etkinlik süresince \"Özel Operasyonlar: Gülün Yurdu\" ücretsiz olarak erişime açık olacaktır. Her 2 günde bir yeni görevler yayınlanacaktır. \"Özel Operasyonlar: Gülün Yurdu\"nu tamamlamak, Gümüş ve etkinliğe özel SR Kader Çarkı \"Geçmişin Çiçekleri ve Şiirleri\" gibi ödülleri Başarı Ödülleri üzerinden elde etmenizi sağlar. Başarı Ödülleri yalnızca etkinlik süresince mevcuttur; etkinlik sona erdikten sonra tamamlanamaz veya talep edilemez.\n2. Etkinlikten sonra \"Özel Operasyonlar: Gülün Yurdu\"nun soruşturma ilerlemesi korunur. Etkinlik sırasında \"Özel Operasyonlar: Gülün Yurdu\"nu açmadıysanız, etkinlik sonrasında 7 \"Gerçeklik Sınırı\" tüketerek yine de açabilirsiniz.\n3. İster etkinlik sırasında ister sonrasında olsun, \"Özel Operasyonlar: Gülün Yurdu\"nu tamamlamak her zaman \"Çete: Bahar’ın Sunusu\" ödülünü verir."
  },
  Activity_67721_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_67723_ActivityName = {
    Text = "İtiraf Etkinliği İndirim Kilidi Aktivitesi"
  },
  Activity_67725_ActivityName = {
    Text = "Afinite İki Katı Etkinliği"
  },
  Activity_67726_ActivityName = {
    Text = "Ruh Çobanı: Tekrar"
  },
  Activity_67726_ActivityPlot = {
    Text = "Senin için acı çekti, felaketlerini üstlendi.\nOnun bedeniyle şifa buldun;\nOnun hayatıyla bağışlandın"
  },
  Activity_67726_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Kilise Hayır Satışı\" kullanılabilir."
  },
  Activity_67726_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli \"Kilise Yolu\", \"Vatandaşların İyi Niyeti\" ve \"Başarı Ödülleri\" oynanışları aracılığıyla etkinlik para birimi \"Hayır Kuponu\" toplayabilir. Bu \"Hayır Kuponları\", \"Kilise Hayır Pazarı\"nda, etkinliğe özel SR Kader Çarkı \"Aynadaki Adam\", Saf Çekirdek ve Lümen Çekirdeği de dâhil olmak üzere rastgele eşyalarla takas edilebilir.\n2. Etkinlik süresince \"Özel Sevk: Kanın Rengi\" ücretsiz olarak erişime açılacaktır. Etkinlik başarımlarını tamamlamak, size etkinliğe özel avatar \"Gümüş Anahtar Adına: Salvador\"u da kazandırabilir!\n\n<Title:Etkinlik Süresi>\n1. 24 Mart 9:00 - 7 Nisan 9:00 (GMT+8) tarihleri arasında tüm etkinlik içeriklerine katılım mümkündür.\n2. 7 Nisan 9:00 - 14 Nisan 9:00 (GMT+8) tarihleri arasında yalnızca \"Kilise Hayır Pazarı\" ve \"Başarı Ödülleri\" erişilebilir olacak, diğer tüm içerikler sonlanacak ve erişilemez hâle gelecektir.\n\n<Title:Kilise Yolu>\n1. \"Kilise Yolu\" 5 aşamadan oluşur, her 2 günde bir aşama açılır.\n2. Her meydan okuma 120 Menophin tüketir ve başarıyla tamamlanan meydan okumalar size etkinlik para birimi \"Hayır Kuponu\" kazandırır.\n3. Bir aşamayı tamamladıktan sonra o aşama için \"Yeniden Canlandır\" işlevi açılır. Not: \"Yeniden Canlandır\" işlevini kullanırken Yakınlık kazanamazsınız.\n4. Aşamaları daha kolay geçmek için Mezun desteğini ve \"Rezonans: Ruhun Çatalı\"nı kullanabilirsiniz.\n\n<Title:Parıltı Bonusu>\n1. \"Ruh Parıltısı\"nın etkisi altında, belirli Uyananlara veya Kader Çarklarına sahip olan (sahaya sürülmeleri gerekmez) Muhafızlar, \"Kilise Yolu\" aşama ödüllerinden, \"Yeniden Canlandır\" dâhil, \"Hayır Kuponu\" için ek düşüş bonusları elde edebilir. Özel bonuslar şöyledir:\nUyanan \"Salvador\": Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\nSSR Kader Çarkı \"Tablet of Scriptures\": Yığın 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\nSR Kader Çarkı \"Aynadaki Adam\": Yığın 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\n2. Farklı Uyananların veya Kader Çarklarının \"Parıltı Bonusları\" birikimli olarak hesaplanır.\n3. Delilik Zorluğu ilk-temizleme meydan okuma ödülleri \"Parıltı Bonusları\"ndan etkilenmez.\n\n<Title:Rezonans: Ruhun Çatalı>\n1. Muhafızlar, etkinlik başarımlarını tamamlayarak \"Tövbe Kalbi\" elde edebilir.\n2. \"Tövbe Kalbi\" tüketerek \"Rezonans: Ruhun Çatalı\"nı etkinleştirebilir ve şu avantajları kazanabilirsiniz:\n(1) Muhafızları \"Kilise Yolu\" ve \"Özel Sevk: Kanın Rengi\" etkinlik oynanışlarında güçlendirerek meydan okumaları kolaylaştırır.\n(2) \"Kilise Yolu\" meydan okumalarını tamamladıktan sonra kazanılan Yakınlığı artırır.\n(3) \"Vatandaşların İyi Niyeti\" etkinlik oynanışını etkinleştirir.\n\n<Title:Vatandaşların İyi Niyeti>\n1. \"Kolay Yöntem\" rezonansını etkinleştirdikten sonra, saatte otomatik olarak 60 \"Hayır Kuponu\" elde edilir, en fazla 25 saatlik birikim yapılabilir.\n2. \"Kefaret, Kefaret\" rezonansını etkinleştirdikten sonra, saatte ek olarak 1800 Altın gül kuponu otomatik olarak elde edilir.\n\n<Title:Kilise Hayır Pazarı>\n1. \"Kilise Hayır Pazarı\"nda üç dükkân bulunur, açılış saatleri şöyledir:\n\"Mrs. Gray'in Küçük Dükkânı\": 24 Mart 9:00'da açılır.\n\"Big John'un Harika Hayır Satışı\": 27 Mart 9:00'da açılır.\n\"Smith'in Özel İndirimi\": 30 Mart 9:00'da açılır.\n2. Her takas 750 \"Hayır Kuponu\" tüketir ve dükkândan rastgele beş eşya ödülü verir.\n3. Her dükkândaki eşya ödülleri \"Özel Eşyalar\" ve \"Sıradan Eşyalar\" olarak ayrılır. Sıfırlama sırasında, Özel Eşyaların kalan stoğu aşağıdaki kurallara göre azamiye yenilenebilir:\n(1) İlk 2 sıfırlama: \"Özel Eşyalar\"ın kalan adedi kalmadığında, Muhafızlar sıfırlamayı seçebilir. Sıfırlama sonrasında hem \"Özel Eşyalar\" hem de \"Sıradan Eşyalar\"ın kalan adetleri azamiye döner; ayrıca takasa devam etmeyi de seçebilirler, bu durumda \"Sıradan Eşyalar\"ın da kalan adedi kalmadığında, devam edebilmek için mutlaka sıfırlama yapılmalıdır.\n(2) 3. sıfırlamadan itibaren: Yalnızca \"Sıradan Eşyalar\"ın kalan adedi kalmadığında sıfırlama yapılabilir; bu sıfırlama \"Sıradan Eşyalar\"ın kalan adetlerini azamiye döndürür, \"Özel Eşyalar\" ise sıfırlanmaz.\n4. 14 Nisan 9:00 (GMT+8) sonrasında, kalan \"Hayır Kuponları\" her bir kupon için \"Altın gül kuponu*40\" oranında geri alınacaktır. Dönüşümler için lütfen posta kutunuzu kontrol edin, Muhafızlar.\n\n<Title:Özel Sevk>\n1. Etkinlik süresince \"Özel Sevk: Kanın Rengi\" ücretsiz olarak erişime açık olacaktır.\n2. Etkinlik sona erdikten sonra, \"Özel Sevk: Kanın Rengi\"nin Soruşturma ilerlemesi korunur; etkinlik sırasında açılmamışsa, sonrasında da \"Gerçeklik Sınırı\"*7 tüketilerek açılabilir.\n3. İster etkinlik sırasında ister sonrasında olsun, \"Özel Sevk: Kanın Rengi\"ni tamamlamak \"Çete: Mucizenin Şafağı\"nı kazandırır.\n\n<Title:Yeniden Baskı Telafisi>\n1. Daha önce \"Özel Sevk: Kanın Rengi\"ni açmış olan Muhafızlar, bu yeniden baskı etkinliğinde tekrar açmaları hâlinde 700 \"Hayır Kuponu\" telafisi alacaktır.\n2. Daha önce etkinliğe özel avatar \"Gümüş Anahtar Adına: Salvador\"u elde etmiş olan Muhafızların, bunu yeniden elde etmeleri durumunda avatar, otomatik olarak 1 \"Biçimsiz Olanın Davetiyesi\"ne dönüştürülecektir.\n3. Daha önce etkinleştirme rezonansı malzemesi \"Tövbe Kalbi\"ni elde etmiş olan Muhafızların, sonradan elde ettikleri her bir ek \"Tövbe Kalbi\" otomatik olarak \"Altın gül kuponu\"*5000'e dönüştürülecektir."
  },
  Activity_67726_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_67727_ActivityName = {
    Text = "Bedensel Arzular: Tekrar"
  },
  Activity_67727_ActivityPlot = {
    Text = "Düşler, bastırılmış arzuların vahyidir. Onlarda oyalananlar, şehvetin dalgalarınca sarılıp birer şehvet havarisi hâline gelir—tabii eğer…"
  },
  Activity_67727_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Arzu Üremesi\" kullanılabilir."
  },
  Activity_67727_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli oynanış “Kaotik Arzu” ve “Başarı Ödülleri” aracılığıyla etkinlik para birimi “Ana Tohum”u toplayabilir. “Ana Tohum”, “Üreme Arzusu”nda etkinliğe özel SR Kader Çarkı “Veda Öpücüğü”, Lümen Çekirdeği, Saf Çekirdek, Eter Taşı Kırıntısı, Taklit Kristali vb. ödüllerle takas edilebilir.\n2. Etkinlik süresince, “Üreme Çılgınlığı”na katılım şartı “Soruşturma” 2-9 Normal’i tamamlama seviyesine düşürülmüştür. Uyananların Afinite şartı “Üreme Çılgınlığı Etkinliği”nin kilidini açmak için gerekli değildir. Ayrıca, gereken “Gerçeklik Sınırı” sayısı yalnızca 1’e indirilmiştir!\n3. Gizemli bir gücün gelişi, Uyananlarla daha derin bağlar kurmana yardım ediyor gibi. Etkinlik süresince, tüm yollarla kazanılan Afinite ikiye katlanır!\n\n<Title:Kaotik Arzu>\n1. “Kaotik Arzu”, keşif gerektirmeyen, yalnızca savaştan oluşan 10 malzeme aşaması içerir; her gün 1 aşama açılır.\n2. Bu malzeme aşamalarında, tüm Uyananları doğrudan Uyandıracak ve önceden ayarlanmış Kalıntılar elde edeceksin. Ayrıca 6 tur sonra bir kez Thais’ten yardım alacaksın.\n3. Her mücadele 120 Menofin tüketir ve başarılı mücadeleler yetiştirme malzemeleri ile etkinlik para birimi kazandırır.\n4. Bir aşama temizlendikten sonra, o aşama için “Yeniden Canlandır” işlevi açılır. Lütfen dikkat: “Yeniden Canlandır” işlevini kullanmak Afinite kazandırmaz.\n5. Aşamaları daha kolay temizlemek için Mezun desteğinden yararlanabilirsin.\n\n<Title:Açgözlülük Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan (savaşta bulunmaları gerekmez) Muhafızlar, “Kaotik Arzu” aşama ödüllerinde (Yeniden Canlandır dahil) “Ana Tohum” için ek düşüş artışı elde edebilir. Belirli artışlar şöyledir:\nUyanan “Thais”: Aydınlanma 0/1/2/3 ve üzeri, artış %20/%30/%40/%50\nSSR Kader Çarkı “Merhametli Beslenme”: Yükseliş 0/1/2/3 ve üzeri, artış %20/%30/%40/%50\nSR Kader Çarkı “Veda Öpücüğü”: Yükseliş 0/1/2/3 ve üzeri, artış %20/%30/%40/%50\n2. Farklı Uyananların veya Kader Çarklarının “Açgözlülük Bonusu” kümülatif olarak hesaplanır.\n3. Özellikle, Delilik Zorluğu’ndaki ilk mücadele ödülleri yukarıdaki bonustan etkilenmez.\n\n<Title:Üreme Arzusu>\n1. Her “Tohum Takası” 1000 “Ana Tohum” tüketir ve “Üreme Arzusu”ndan rastgele beş eşya ödülü elde edilir.\n3. “Üreme Arzusu”ndaki eşya ödülleri “Özel Eşyalar” ve “Normal Eşyalar” olarak ikiye ayrılır. Sıfırlama sonrasında, kalan Özel Eşya ödüllerinin sayısı sınıra kadar yenilenebilir; belirli kurallar şöyledir:\n(1) İlk 4 sıfırlama için: Hiç “Özel Eşya” kalmadığında, Muhafız sıfırlamayı seçebilir. Sıfırlama, kalan “Özel Eşyalar” ve “Normal Eşyalar”ın sayısını sınıra kadar yeniler. Takas etmeye devam etmeyi de seçebilirsin. “Normal Eşyalar” da kalmadığında, takasa devam etmek için sıfırlama zorunludur.\n(2) 5. sıfırlamadan itibaren: Sıfırlama yalnızca hiç “Normal Eşya” kalmadığında yapılabilir. Sıfırlama, kalan “Normal Eşyalar”ın sayısını sınıra kadar yenilerken, “Özel Eşyalar” artık sıfırlanmaz.\n\n<Title:Etkinlik Süresi>\n1. 16 Aralık 9:00 - 30 Aralık 9:00 (GMT+8) arasında, etkinlik özetindeki tüm içeriklere katılım sağlanabilir.\n2. 30 Aralık 9:00 - 6 Ocak 9:00 (GMT+8) arasında yalnızca “Üreme Arzusu” ve “Başarı Ödülleri” kalır; diğer tüm içerikler sona erer ve katılım sağlanamaz.\n3. 6 Ocak 9:00 (GMT+8) sonrasında, değiştirilmemiş kalan tüm “Ana Tohum”lar, tohum başına “Gül Senedi*40” dönüşüm oranıyla geri alınacaktır. Muhafızlar, lütfen postanızı kontrol edin."
  },
  Activity_67727_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_67728_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_67729_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_67731_ActivityName = {
    Text = "Alevlerin Şöleni: Tekrar"
  },
  Activity_67731_ActivityPlot = {
    Text = "Göldeki Şehir Isarawu’nun, Wanda’nın memleketi olduğu söylenir.\nBu kez Rüya Kapısı’ndan geçecek ve saat dilleriyle dolu kadim kulelere varacaksın..."
  },
  Activity_67731_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Wanda'nın Hazine Sandığı\" kullanılabilir."
  },
  Activity_67731_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, süreli oynanış “Alevlerin Şöleni” ve “Başarı Ödülleri” aracılığıyla etkinlik para birimleri “İlkel Kaval Kemiği”, “Tornoceras” ve “Sarmal Kalıntılar”ı toplayabilir. Bu para birimleri, “Wanda’nın Hazine Mahzeni”nde etkinliğe özel SR Kader Çarkı “Isarawu'nun Bakışı”, Lümen Çekirdeği, Saf Çekirdek vb. eşyaları satın almak için kullanılabilir.\n2. Etkinlik süresince “Zihin Dalgınlığı: Alevlerin Şöleni”ne süreli ücretsiz erişim sağlanacak ve etkinlik başarılarını tamamlamak, etkinliğe özel avatar “Gümüş Anahtar Adına: Wanda”yı kazandıracaktır!\n\n<Title:Etkinlik Süresi>\n1. 23 Eylül 09:00’dan 7 Ekim 09:00’a kadar (GMT+8) tüm etkinlik oynanışları erişime açık olacaktır.\n2. 7 Ekim 09:00’dan 14 Ekim 09:00’a kadar (GMT+8) yalnızca “Wanda’nın Hazine Mahzeni” ve başarı ödüllerine erişilebilecektir.\n\n<Title:Göldeki Şehir>\n1. “Göldeki Şehir”de 7 safha vardır; her gün bir safha kendiliğinden açılır.\n2. Her meydan okuma 120 Menophin tüketir ve başarıyla tamamlanan meydan okumalar etkinlik para birimi kazandırır.\n3. Bir safha temizlendikten sonra o safhanın “Yeniden Canlandır” işlevi açılır. Not: “Yeniden Canlandır” kullanmak Yakınlık kazandırmaz.\n4. Safhaları daha kolay tamamlamak için Mezun desteğini ve “Rezonans: Gizli Vekâlet Emri”ni kullanabilirsiniz.\n\n<Title:Nadir Armağan>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olmak (savaşta bulunmaları gerekmez), “Göldeki Şehir” safhalarında ek etkinlik para birimi düşüşü sağlar; özel bonuslar şöyledir:\nUyanan “Wanda”: Aydınlanma seviyeleri 0/1/2/3+, bonuslar %20/%30/%40/%50.\nSSR Kader Çarkı “Kraliçenin Fermanı”: Yükseliş seviyeleri 0/1/2/3+, bonuslar %20/%30/%40/%50.\nSR Kader Çarkı “Isarawu'nun Bakışı”: Yükseliş seviyeleri 0/1/2/3+, bonuslar %20/%30/%40/%50.\n2. Farklı Uyananların veya Kader Çarklarının “Nadir Armağan”ları Hesaplama sırasında birikir.\n3. Dikkat: Delilik Zorluğu’ndaki ilk tamamlama ödülü, Nadir Armağanlardan etkilenmez.\n\n<Title:Rezonans: Gizli Vekâlet Emri>\n1. Muhafızlar, etkinlik başarılarını tamamlayarak “Hedonizm Kalbi” elde edebilir.\n2. “Hedonizm Kalbi” kullanmak, “Rezonans: Gizli Vekâlet Emri”ni etkinleştirir; bu da Muhafızları güçlendirir ve “Göldeki Şehir”de fazladan etkinlik para birimi kazandırır.\n\n<Title:Zihin Dalgınlığı>\n1. Etkinlik süresince “Alevlerin Şöleni” ücretsiz olarak açılacaktır.\n2. Etkinlik sonrasında “Alevlerin Şöleni”ndeki ilerleme korunur ve tamamlanmamış Soruşturma Olayları aynı ödülleri vermeye devam eder. “Alevlerin Şöleni” etkinlik sırasında açılmazsa, sonrasında 3 “Gerçeklik Sınırı” harcanarak erişilebilir.\n3. “Alevlerin Şöleni”ni tamamlamak, etkinlik döneminden bağımsız olarak “Çete: Çürüme Şöleni” kazandırır.\n\n<Title:Yeniden Yayın Telafisi>\n1. Daha önce “Zihin Dalgınlığı: Alevlerin Şöleni”ni açmış olan Muhafızlar, bu yeniden yayında tekrar açmaları hâlinde 300 “İlkel Kaval Kemiği” telafi alacaktır.\n2. Daha önce elde edilmiş etkinliğe özel avatar “Gümüş Anahtar Adına: Wanda”nın kopyaları, 2000 “İlkel Kaval Kemiği”ne dönüştürülür.\n3. Daha önce elde edilmiş etkinleştirme rezonans malzemesi “Hedonizm Kalbi”nin her fazlası, 5000 “Gül Senedi”ne dönüştürülür.\n"
  },
  Activity_67731_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_67732_ActivityName = {
    Text = "Dedektif El Kitabı: Tekrar"
  },
  Activity_67732_ActivityPlot = {
    Text = "Bu sayfaların içinde, bir ömrü gizem çözmekle geçmiş usta bir Dedektifin katılaşmış kavrayışları yatıyor.\nMütevazı Müfettişlerin sezgisini tutuşturup zekâsını bilemek için tasarlanmış bir rehber."
  },
  Activity_67732_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Şans Kulübü\" Alınabilir."
  },
  Activity_67732_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince, Muhafızlar, süreli oynanış \"Mehtap masalları\" ve \"Başarı Ödülleri\" aracılığıyla etkinlik parası \"Kazanan Fiş\" toplayabilir. \"Kazanan Fiş\", \"Şans Kulübü\"nde etkinliğe özel SR Kader Çarkı \"Kader Ruleti\", Saf Çekirdek, Lümen Çekirdeği, Eter Taşı Kırıntısı, Taklit Kristali vb. dâhil cömert ödüllerle takas edilebilir.\n2. Etkinlik süresince, \"Başarı Ödülleri\"ndeki görevleri tamamlamak, etkinliğe özel avatar \"Gümüş Anahtar Adına: Ryker\", etkinliğe özel SR Kader Çarkı \"Kader Ruleti\", Gümüş ve yüklü miktarda etkinlik parası \"Kazanan Fiş\" kazandırır.\n3. Etkinlik süresince, \"Görev Kaydı: İyi Avlar!\" süreli ücretsiz erişim ile açılır.\n\n<Title:Etkinlik Süresi>\n1. 12 Ağustos 09:00 - 26 Ağustos 09:00 (GMT+8) arasında tüm etkinlik içeriklerine katılım mümkündür.\n2. 26 Ağustos 09:00 - 2 Eylül 09:00 (GMT+8) arasında yalnızca \"Şans Kulübü\" ve \"Başarı Ödülleri\" kalır, diğer içeriklere artık katılım sağlanamaz.\n\n<Title:Mehtap masalları>\n1. \"Mehtap masalları\" 9 bölümden oluşur, her gün 1 bölüm kendiliğinden açılır.\n2. Her meydan okuma 120 Menofin puanı tüketir ve farklı bölümlere meydan okumak, farklı malzeme düşüşlerinin yanı sıra etkinlik parası \"Kazanan Fiş\" verir.\n3. Bu etkinlikteki bölümler, temizlendikten sonra tekrar oynanabilen doğrudan savaş malzeme bölümleridir! Her \"Yeniden Oyna\" 120 Menofin puanı tüketir.\n4. Not: \"Yeniden Oyna\" işlevini kullanmak Afinite kazandırmaz.\n\n<Title:Fiş Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan Muhafızlar (kadroda bulunmaları gerekmez), \"Mehtap masalları\" görev ödüllerinde (yeniden oynama dâhil) ek \"Kazanan Fiş\" düşüşü elde eder. Özel bonuslar şöyledir:\nUyanan \"Ryker\": Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSSR Kader Çarkı \"Şans Saati\": Yığılma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSR Kader Çarkı \"Kader Ruleti\": Yığılma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n2. Farklı Uyananların veya Kader Çarklarının \"Fiş Bonusu\" toplamsal olarak hesaplanır.\n3. Özellikle, Delilik Zorluğu'nun ilk meydan okuma ödülü \"Fiş Bonusu\"ndan etkilenmez.\n\n<Title:Şans Kulübü>\n1. \"Şans Kulübü\" yalnızca 12 Ağustos 09:00 - 2 Eylül 09:00 (GMT+8) arasında açıktır.\n2. 2 Eylül 09:00'dan (GMT+8) sonra, takas edilmemiş kalan \"Kazanan Fiş\"ler, her takas için \"Gül Senedi *40\" oranıyla geri alınacaktır. Muhafızlar posta kutularını kontrol etmelidir.\n\n<Title:Görev Kaydı>\n1. \"Görev Kaydı: İyi Avlar!\"da, Muhafızlar, hikâye ön ayarlı \"Ryker\"ı da içeren özel bir takımla meydan okumaya çıkar.\n2. \"Görev Kaydı: İyi Avlar!\"ı temizlemek, yeni kilit eşya \"Bir Silahın Çığlığı\"nı ödül olarak verir."
  },
  Activity_67732_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_67733_ActivityName = {
    Text = "Uçurum Kurbanı: Tekrar"
  },
  Activity_67733_ActivityPlot = {
    Text = "Derin okyanusun yansısında, Kralı’nın düşü dağılır ve Tanrı Diyarı çürür.\nKadim düşlerden sıyrılıp, çöken bir geleceğin harabelerine adım atar.\nUçuruma soru sorar, ama Uçurum suskun kalır.\nUçuruma kurbanlar sunar, yalnızca kendi yankısını duyar."
  },
  Activity_67733_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Uçurumdan Gelen Yanıt\" kullanılabilir."
  },
  Activity_67733_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince, Muhafızlar sınırlı süreli “Tanrı Diyarının Doğuşu”, “Tanrı Kralın Fermanı” ve “Başarı Ödülleri” oynanışları aracılığıyla etkinlik parası toplayabilir. Etkinlik parası, “Uçurumun Yanıtı”nda adak sunmak ve etkinliğe özel SR Kader Çarkı “Derin Denizin Çağrısı”, Eter Taşı, Saf Çekirdek, Işıyan Çekirdek ve daha fazlası gibi eşya ödülleri elde etmek için kullanılabilir.\n2. Etkinlik süresince “Dreamscape: Desecrate” ücretsiz olacaktır. Etkinlik başarılarını tamamlamak, etkinliğe özel avatar “Gümüş Anahtar Adına: Miryam”ı elde etmenizi de sağlar!\n\n<Title:Etkinlik Süresi>\n1. 28 Temmuz 9:00 - 18 Ağustos 9:00 (GMT+8), tüm etkinlik içerikleri erişime açık olacaktır.\n2. 18 Ağustos 9:00 - 25 Ağustos 9:00 (GMT+8), yalnızca “Uçurumun Yanıtı” ve “Başarı Ödülleri” erişime açık kalır. Diğer tüm içeriklere artık erişilemez.\n\n<Title:Tanrı Diyarının Doğuşu>\n1. “Tanrı Diyarının Doğuşu” 5 aşamadan oluşur; her 2 günde bir yeni bir aşama kendiliğinden açılır.\n2. Her meydan okuma 120 Menophin tüketir. Meydan okumayı başarıyla tamamlamak etkinlik parası kazandırır.\n3. Bir aşama temizlendiğinde, o aşamanın “Yeniden Canlandır” işlevi açılır. Lütfen dikkat: “Yeniden Canlandır” işlevi kullanıldığında Yakınlık kazanılmaz.\n4. Aşamaları daha kolay temizlemek için Mezun Yardımı ve “Rezonans: Gelgit Festivali”ni kullanabilirsiniz.\n\n<Title:Adak Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olmak (savaşa sürülmeleri gerekmez), “Tanrı Diyarının Doğuşu” aşama ödüllerinden (Yeniden Canlandır dahil) elde edilen “Adak Sunucunun Gözyaşları”, “Adak Sunucunun Kanı” ve “Adak Sunucunun İliği” için ek düşüş oranı bonusları sağlar. Özel bonuslar şöyledir:\nUyanan “Miryam”: Aydınlanma 0/1/2/3+, bonus %20/%30/%40/%50\nSSR Kader Çarkı “Dindarın Gücü”: Yükseliş 0/1/2/3+, bonus %20/%30/%40/%50\nSR Kader Çarkı “Derin Denizin Çağrısı”: Yükseliş 0/1/2/3+, bonus %20/%30/%40/%50\n2. Farklı Uyananlar veya Kader Çarklarından gelen “Adak Bonusu” üst üste biner.\n3. Özel Not: Delilik Zorluğu’ndaki ilk kez ödülleri “Adak Bonusu”ndan etkilenmez.\n\n<Title:Rezonans: Gelgit Festivali>\n1. Muhafızlar, etkinlik başarılarını tamamlayarak “Bağlılık Kalbi” elde edebilir.\n2. “Bağlılık Kalbi” tüketerek “Rezonans: Gelgit Festivali”ni etkinleştirmek aşağıdaki bonusları sağlar:\n(1) “Tanrı Diyarının Doğuşu” etkinlik oynanışında Muhafızı güçlendirerek meydan okumaları kolaylaştırır.\n(2) “Tanrı Diyarının Doğuşu” meydan okumalarını tamamladıktan sonra elde edilen etkinlik parası miktarını artırır.\n(3) “King's Decree” etkinlik oynanışını açar.\n\n<Title:Adak Bonusu>\n“Rezonans: Kurban Sınavı” etkinleştirildikten sonra, her saat otomatik olarak 60 “Adak Sunucunun Gözyaşları” elde edilir; en fazla 25 saat birikebilir.\n\n<Title:Uçurumun Yanıtı>\n1. “Uçurumun Yanıtı”nda üç sunak bulunur; açılış zamanları şöyledir:\n“Crystal Tear Altar”: 28 Temmuz 9:00 ~ 25 Ağustos 9:00.\n“Crimson Altar of Blood”: 30 Temmuz 9:00 ~ 25 Ağustos 9:00.\n“Spirit Marrow Altar”: 1 Ağustos 9:00 ~ 25 Ağustos 9:00.\n2. Her adak, 1000 “Adak Sunucunun Gözyaşları”/“Adak Sunucunun Kanı”/“Adak Sunucunun İliği” tüketir ve sunaktan rastgele beş eşya ödülünden birini verir.\n3. Her sunağın eşya ödülleri “Özel Eşyalar” ve “Sıradan Eşyalar” olarak ayrılır. Sıfırlama, belirtilen eşya ödüllerinin kalan miktarını azami seviyesine geri yükler. Ayrıntılı kurallar şöyledir:\n(1) İlk 3 sıfırlama: “Özel Eşyalar”ın kalan miktarı kalmadığında, Muhafız sıfırlamayı seçebilir; bu, hem “Özel Eşyalar”ın hem de “Sıradan Eşyalar”ın kalan miktarlarını azami seviyeye geri yükler; ya da adak sunmaya devam edebilir. “Sıradan Eşyalar” da tükendiğinde, adak sunmaya devam etmek için sıfırlama zorunludur.\n(2) 4. sıfırlamadan itibaren: Sıfırlama yalnızca “Sıradan Eşyalar” tükendiğinde yapılabilir. Sıfırlama, “Sıradan Eşyalar”ın miktarını azami seviyeye geri yükler; ancak “Özel Eşyalar” artık sıfırlanmaz.\n\n<Title:Dreamscape>\n1. Etkinlik süresince “Dreamscape: Desecrate” ücretsiz olacaktır.\n2. Etkinlikten sonra, “Dreamscape: Desecrate”in soruşturma ilerlemesi korunur. “Dreamscape: Desecrate” etkinlik sırasında kilidi açılmamışsa, etkinlikten sonra 7 “Reality Verge” harcayarak yine de kilidi açılabilir.\n3. Etkinlik sırasında olsun olmasın, “Dreamscape: Desecrate”i tamamlamak “Posse: Festival of Tides” kazandırır.\n\n<Title:Yeniden Yayın Telafisi>\n1. Daha önce “Dreamscape: Desecrate”in kilidini açmış olan Muhafızlar, bu yeniden yayın etkinliğinde yeniden kilidini açtıklarında telafi olarak 700 “Adak Sunucunun Gözyaşları” alacaktır.\n2. Daha önce etkinliğe özel avatar “Gümüş Anahtar Adına: Miryam”ı elde etmiş olan Muhafızlar için, tekrar elde etmeler otomatik olarak 1 “Biçimsiz Olanın Davetiyesi”ne dönüştürülür.\n3. Daha önce rezonans etkinleştirme malzemesi “Bağlılık Kalbi”ni elde etmiş olan Muhafızlar için, her ek “Bağlılık Kalbi” otomatik olarak 5000 “Rose Scrip”e dönüştürülür."
  },
  Activity_67733_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_67734_ActivityName = {
    Text = "Görünmez Senfoni: Tekrar"
  },
  Activity_67734_ActivityPlot = {
    Text = "Senfoni bir dokuma sanatıdır; farklı enstrümanların yolları karmaşık bir desen oluşturacak şekilde iç içe geçer.\nOnun ağında her nota rolünü oynar.\nDinle, eşsiz bir senfoni başlamak üzere."
  },
  Activity_67734_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Uyku Sarayı\" kullanılabilir."
  },
  Activity_67734_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli oynanış “Çınlayan Ses” ve “Başarı Ödülleri” aracılığıyla etkinlik parası “Coşku Sonatı” toplayabilir. “Coşku Sonatı”, “Düş Sarayı”nda etkinliğe özel SR Kader Çarkı “Sonsuz Performans”, Saf Çekirdek, Lümen Çekirdeği, Bilge Taşı Parçaları ve Taklit Kristalleri de dahil olmak üzere cömert ödüllerle takas edilebilir.\n2. Etkinlik süresince “Başarı Ödülleri”ndeki görevleri tamamlamak, etkinliğe özel avatar “Gümüş Anahtar Adına: Hameln”i, etkinliğe özel SR Kader Çarkı “Sonsuz Performans”ı, Gümüş ve büyük miktarda etkinlik parası “Coşku Sonatı” kazandırır.\n\n<Title:Etkinlik Süresi>\n1. 9 Eylül 09:00’dan 23 Eylül 09:00’a kadar (GMT+8) tüm etkinlik içeriğine katılım mümkündür.\n2. 23 Eylül 09:00’dan 30 Eylül 09:00’a kadar (GMT+8) yalnızca “Düş Sarayı” ve “Başarı Ödülleri” açık kalacak, diğer içerikler artık erişilebilir olmayacaktır.\n\n<Title:Çınlayan Ses>\n1. “Çınlayan Ses” 9 bölümden oluşur, her gün bir bölüm kendiliğinden açılır.\n2. Her meydan okuma 120 Menofin tüketir. Farklı bölümlere meydan okuyarak farklı malzeme düşüşleri elde etmenin yanı sıra, katılımcılar etkinlik parası “Coşku Sonatı” da kazanacaktır.\n3. Etkinlik bölümleri doğrudan çatışma malzeme bölümleridir ve tamamlandıktan sonra tekrar oynanabilir! Her “Tekrar Oyna” 120 Menofin tüketir.\n4. Lütfen dikkat: “Tekrar Oyna” işlevi kullanıldığında Afinite kazanılamaz.\n\n<Title:Sonat Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan Muhafızlar (savaşa sürülmeleri gerekmez), “Çınlayan Ses” bölümlerinin görev ödüllerinde (tekrarlar dahil) ek “Coşku Sonatı” düşüşleri elde edebilir. Özel bonuslar şöyledir:\nUyanan “Hameln”: Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSSR Kader Çarkı “Ebedi Ağıt”: Yığın seviyesi 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSR Kader Çarkı “Sonsuz Performans”: Yığın seviyesi 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n2. Farklı Uyananlardan veya Kader Çarklarından gelen “Sonat Bonusu” kümülatif olarak hesaplanır.\n3. Özellikle, Delilik Zorluğu için ilk tamamlama meydan okuma ödülü “Sonat Bonusu”ndan etkilenmez.\n\n<Title:Düş Sarayı>\n1. “Düş Sarayı” yalnızca 9 Eylül 09:00’dan 30 Eylül 09:00’a kadar (GMT+8) açıktır.\n2. 30 Eylül 09:00’dan (GMT+8) sonra, takas edilmemiş “Coşku Sonatı”lar, takas başına “Gül Senedi *40” oranıyla geri alınacaktır. Muhafızların postalarını kontrol etmeleri tavsiye edilir."
  },
  Activity_67734_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_67735_ActivityName = {
    Text = "Bedensel Arzular: Tekrar"
  },
  Activity_67735_ActivityPlot = {
    Text = "Düşler, bastırılmış arzuların vahyidir. Onlarda oyalananlar, şehvetin dalgalarınca sarılıp birer şehvet havarisi hâline gelir—tabii eğer…"
  },
  Activity_67735_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Arzu Üremesi\" kullanılabilir."
  },
  Activity_67735_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince, Muhafızlar sınırlı süreli oynanış “Kaotik Arzu” ve “Başarı Ödülleri” aracılığıyla etkinlik parası “Bereket Çekirdeği” toplayabilir. “Bereket Çekirdeği”, “Şehvet Tohumu” içinde, etkinliğe özel SR Kader Çarkı “Veda Öpücüğü”, Lümen Çekirdeği, Saf Çekirdek, Eter Taşı Kırıntısı ve Taklit Kristali dâhil olmak üzere çeşitli ödüllerle takas edilebilir. \n2. Etkinlik süresince, “Üreme Çılgınlığı”na katılım şartları, Ana Hikâye: 1-2: Normal’i geçecek şekilde gevşetilir ve “Üreme Çılgınlığı Etkinliği”nin kilidini açmak için Uyanan afinite şartı aranmaz. Ayrıca, gereken “Gerçeklik Eşiği” sayısı 1’e düşürülür! \n3. Gizemli bir güç, Uyananlarla daha derin bir bağ kurmana yardım ediyor gibi görünüyor; etkinlik boyunca tüm yollarla kazanılan afinite ikiye katlanır! \n\n<Title:Kaotik Arzu>\n1. “Kaotik Arzu”, keşif gerektirmeyen ve doğrudan çatışma içeren 10 malzeme aşamasından oluşur; her gün bir aşama açılır. \n2. Bu malzeme aşamalarında tüm Uyananlar uyandırılır ve önceden ayarlanmış Kalıntılarla donatılır. Ayrıca, 6 tur sonra bir kez Thais’ten yardım alırsın. \n3. Her deneme 120 Menophin tüketecek ve başarılı denemeler malzeme ile etkinlik parası kazandıracaktır. \n4. Bir aşamayı temizledikten sonra, o aşama için “Yeniden Canlandır” işlevinin kilidi açılır. Lütfen dikkat: “Yeniden Canlandır” işlevini kullanmak afinite kazandırmaz. \n5. Aşamaları daha kolay temizlemek için destek kullanabilirsin. \n\n<Title:Arzu Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan Muhafızlar (savaşa sokulmaları gerekmez), “Kaotik Arzu” aşama görev ödüllerinde (yeniden canlandırma dâhil) “Bereket Çekirdeği” için ek düşüş bonusları alabilir; belirli bonuslar şöyledir: \nUyanan “Thais”: Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50 \nSSR Kader Çarkı “Merhametli Beslenme”: Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50 \nSR Kader Çarkı “Veda Öpücüğü”: Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50 \n2. Farklı Uyananların veya Kader Çarklarının “Arzu Bonusu” toplamsal olarak hesaplanır. \n3. Özellikle, Delilik Zorluğu için ilk kez tamamlama ödülleri yukarıdaki bonuslardan etkilenmeyecektir. \n\n<Title:Şehvet Tohumu>\n1. Her “Çekirdek Takası”, 750 “Bereket Çekirdeği” tüketecek ve “Şehvet Tohumu”ndan rastgele beş eşya ödülü verecektir. \n3. “Şehvet Tohumu”ndaki eşya ödülleri “Özel Eşyalar” ve “Sıradan Eşyalar” olarak ikiye ayrılır. Sıfırlama yapıldığında, kalan özel eşya ödüllerinin miktarı üst sınıra kadar yenilenebilir; özel kurallar şöyledir: \n(1) İlk 4 sıfırlama için: Hiç “Özel Eşya” kalmadığında, Muhafızlar sıfırlamayı seçebilir; bu, kalan “Özel Eşyalar” ve “Sıradan Eşyalar”ın miktarını üst sınıra sıfırlar. Ayrıca takasa devam etmeyi de seçebilirler; “Sıradan Eşya” kalmadığında, takasa devam etmek için mutlaka bir sıfırlama yapılmalıdır. \n(2) 5. sıfırlama ve sonrasında: Yalnızca hiç “Sıradan Eşya” kalmadığında sıfırlama yapılabilir; bu, kalan “Sıradan Eşyalar”ın miktarını üst sınıra sıfırlar; “Özel Eşyalar” ise sıfırlanmaz. \n\n<Title:Etkinlik Süresi>\n1. 15 Aralık, 9:00 - 29 Aralık, 9:00 (GMT+8) arasında, etkinlik özetindeki tüm içeriklere katılınabilir. \n2. 29 Aralık, 9:00 - 5 Ocak, 9:00 (GMT+8) arasında yalnızca “Şehvet Tohumu” ve “Başarı Ödülleri” kalacak, diğer içeriklere artık katılım mümkün olmayacaktır. \n3. 5 Ocak, 9:00 (GMT+8) sonrasında, kullanılmamış tüm “Bereket Çekirdeği”ler, her takas için “Gül Senedi *40” oranından geri dönüştürülecektir; lütfen bildirimler için postalarınızı kontrol edin."
  },
  Activity_67735_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_67736_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_67737_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_67738_ActivityName = {
    Text = "Afinite İki Katı Etkinliği"
  },
  Activity_67739_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_67741_ActivityName = {
    Text = "Hikâyelerin Büyüsü·Tekrar"
  },
  Activity_67741_ActivityPlot = {
    Text = "Bebek’in verdiği görevler asla basit değildir.\nHerkese defalarca “eğlenin” diye hatırlatmasına rağmen, bir grup Uyanan’ı ilk kez dışarı çıkaran Koruyucu nasıl gergin olmasın?\nAma unutma, “eğlenmek” gerek, tamam mı."
  },
  Activity_67741_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Büyü Yazıtı Dükkanı\" kullanılabilir."
  },
  Activity_67741_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. \"Hikâyelerin Büyüsü\" oynanış etkinliği geçici olarak yeniden açıldı. Muhafızlar, \"Gizemli Kodex Emanetçisi\" ve \"Başarı Ödülleri\" aracılığıyla etkinliğe özel Kader Çarkı \"35mm Büyü\"yü ve etkinliğe özel avatar \"Gümüş Anahtar Adına: Lily\"yi yeniden elde edebilir!\n2. Etkinlik süresince \"Özel Kayıt: Hikâyelerin Büyüsü\" süreli ücretsiz erişime açılacaktır.\n\n<Title:Senaryo Gizemi>\n1. \"Senaryo Gizemi\" 9 malzeme seviyesinden oluşur; her gün 1 seviye otomatik olarak açılır.\n2. Her meydan okuma 120 Menophin tüketir ve başarılı meydan okumalar etkinlik parası kazandırır.\n3. Bir seviye temizlendikten sonra, o seviye için \"Yeniden Canlandır\" işlevi açılır. Not: \"Yeniden Canlandır\" işlevini kullanmak Yakınlık kazandırmaz.\n4. Seviyeleri daha kolay geçmek için Alumnis yardımını ve \"Rezonans: Yönetmen Parolası\"nı kullanabilirsiniz.\n\n<Title:İlham Bonusu>\n1. Belirli Uyanmışlara veya Kader Çarklarına sahip olan Muhafızlar (savaşa sokulmaları gerekmez), \"Senaryo Gizemi\" seviye görevlerinde (Yeniden Canlandır dâhil) \"Savrulan İlham\" için ek düşüş bonusu kazanabilir. Ayrıntılar şöyledir:\nUyanmış \"Lily\": Aydınlanma 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus.\nSSR Kader Çarkı \"Acıyı Aşmak\": Yığılma 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus.\nSR Kader Çarkı \"35mm Büyü\": Yığılma 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus.\n2. Farklı Uyanmışlar veya Kader Çarklarından gelen \"İlham Bonusları\" toplanarak hesaplanır.\n3. Özellikle, Delilik Zorluğu için ilk tamamlama ödülü yukarıdaki bonuslardan etkilenmez.\n\n<Title:Rezonans: Yönetmen Parolası>\n1. Muhafızlar, etkinlik başarımlarını tamamlayarak \"Çıkarım Kalbi\" elde edebilir.\n2. \"Çıkarım Kalbi\" tüketerek \"Rezonans: Yönetmen Parolası\"nı etkinleştirmek, Muhafızların \"Senaryo Gizemi\" ve \"Özel Kayıt: Hikâyelerin Büyüsü\" etkinliklerinde güçlenmesini sağlar.\n\n<Title:Yeniden Açılış Telafisi>\n1. Daha önce \"Özel Kayıt: Hikâyelerin Büyüsü\"nü açmış olan Muhafızlar, bu yeniden açılış etkinliği sırasında tekrar açtıklarında \"Savrulan İlham\" *700 telafisi alacaktır.\nDaha önce etkinliğe özel avatar \"Gümüş Anahtar Adına: Lily\"yi elde etmiş olan Muhafızlar, tekrar elde ettiklerinde bu avatar otomatik olarak \"Savrulan İlham\" *2000’e dönüştürülecektir.\nDaha önce rezonans etkinleştirme malzemesi \"Çıkarım Kalbi\"ni elde etmiş olan Muhafızların fazla her bir \"Çıkarım Kalbi\", otomatik olarak \"Gül Senedi\" *5000’e dönüştürülecektir.\n\n<Title:Etkinlik Süresi>\n1. 13 Ocak 9:00 - 27 Ocak 9:00 (GMT+8) arasında, etkinlik özetindeki tüm içeriklere katılım mümkündür.\n2. 27 Ocak 9:00 - 3 Şubat 9:00 (GMT+8) arasında, yalnızca \"Gizemli Kodex Emanetçisi\" ve \"Başarı Ödülleri\" erişime açık kalacak; diğer içerikler sona erecek ve katılım mümkün olmayacaktır.\n3. 3 Şubat 9:00 (GMT+8) sonrasında, elde kalmış ve takas edilmemiş \"Savrulan İlham\"lar, her takas başına 40 \"Gül Senedi\" oranıyla geri alınacaktır. Lütfen postalarınızı takip edin, Muhafızlar."
  },
  Activity_67741_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_67742_ActivityName = {
    Text = "Güle Mektup: Tekrar"
  },
  Activity_67742_ActivityPlot = {
    Text = "Göz alıcı altın elmaslar, göz kamaştıran inciler...\nSayısız lüks süs ona bir imparatoriçe olduğu yanılsamasını verdi.\nŞimdi, bu yanılsamayı sonsuza dek korumaya kararlı."
  },
  Activity_67742_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Altın Kırmızı Kutlama\" kullanılabilir."
  },
  Activity_67742_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince, Muhafızlar süreli oynanış \"Gül Anıları\" ve \"Başarı Ödülleri\" aracılığıyla etkinlik para birimi \"Ruhçuluk Kuş Tüyü Yelpazesi\"ni toplayabilirler. \"Ruhçuluk Kuş Tüyü Yelpazesi\", \"Altın Kızıl Şölen\"de etkinliğe özel SR Kader Çarkı \"Milyon Sevgi Dolu Bakış\", Saf Çekirdek, Işıltılı Çekirdek, Eterik Parça ve Taklit Kristali dâhil cömert ödüllerle takas edilebilir.\n2. Etkinlik süresince, \"Başarı Ödülleri\" görevlerini tamamlamak, size etkinliğe özel avatar \"Gümüş Anahtar Adına: Sorel\", etkinliğe özel SR Kader Çarkı \"Milyon Sevgi Dolu Bakış\", Gümüş ve büyük miktarda etkinlik para birimi \"Ruhçuluk Kuş Tüyü Yelpazesi\" kazandıracaktır.\n3. Etkinlik süresince, \"Özel Harekât: Güle Övgü\"ye erişim ücretsiz olacaktır.\n\n<Title:Gül Anıları>\n1. \"Gül Anıları\" 9 bölüm içerir, her gün 1 bölüm kendiliğinden açılır.\n2. Her meydan okuma 120 Menofin puanı tüketecektir. Farklı bölümlere meydan okumak farklı malzeme düşüşleri sağlayacak ve ayrıca etkinlik para birimi \"Ruhçuluk Kuş Tüyü Yelpazesi\" kazandıracaktır.\n3. Bir bölümü tamamladıktan sonra, o bölüm için \"Yeniden Canlandır\" işlevi açılır. Lütfen dikkat: \"Yeniden Canlandır\" işlevini kullanmak Yakınlık kazandırmaz.\n4. Bölümleri daha kolay geçmek için Mezun yardımı kullanabilirsiniz.\n\n<Title:Yelpaze Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip Muhafızlar (savaş alanında olmaları gerekmez), \"Gül Anıları\" görev ödüllerinde (Yeniden Canlandır dâhil) \"Ruhçuluk Kuş Tüyü Yelpazesi\" için ek düşüş bonusları alabilirler; ayrıntılar şöyledir:\nUyanan \"Sorel\": Aydınlanma 0/1/2/3+, bonus %20/%30/%40/%50\nSSR Kader Çarkı \"Yalnız Gül Adına\": Yığılma 0/1/2/3+, bonus %20/%30/%40/%50\nSR Kader Çarkı \"Milyon Sevgi Dolu Bakış\": Yığılma 0/1/2/3+, bonus %20/%30/%40/%50\n2. Farklı Uyananlar veya Kader Çarklarından gelen \"Yelpaze Bonusu\" toplamsal olarak hesaplanır.\n3. Özellikle, Delilik Zorluğu için ilk kez meydan okuma ödülleri yukarıdaki bonuslardan etkilenmeyecektir.\n\n<Title:Yeniden Yayın Telafisi>\n1. Etkinlik süresince, daha önce \"Özel Harekât: Güle Övgü\"nün kilidini açmış olan Muhafızlar, yeniden kilidini açtıklarında \"Ruhçuluk Kuş Tüyü Yelpazesi\" *700 telafisi alacaklardır.\nDaha önce etkinliğe özel avatar \"Gümüş Anahtar Adına: Sorel\"i elde etmiş olan Muhafızların tekrar kazançları otomatik olarak \"Ruhçuluk Kuş Tüyü Yelpazesi\" *2000’e dönüştürülecektir.\n\n<Title:Etkinlik Süresi>\n1. 27 Ocak 9:00 - 10 Şubat 9:00 (GMT+8), tüm etkinlik içeriklerine katılım mümkündür.\n2. 10 Şubat 9:00 - 17 Şubat 9:00 (GMT+8), yalnızca \"Altın Kızıl Şölen\" ve \"Başarı Ödülleri\" devam eder, diğer içerikler sona erer ve katılım mümkün olmaz.\n3. 17 Şubat 9:00 (GMT+8) sonrasında, takas edilmemiş kalan tüm \"Ruhçuluk Kuş Tüyü Yelpazesi\", her takas için \"Gül Altın Kuponu *40\" oranıyla geri alınacaktır. Muhafızların postalarını kontrol etmeleri tavsiye edilir."
  },
  Activity_67742_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_67743_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_67744_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_67744_ActivityPlot = {
    Text = "Bayanlar ve baylar.\nYumuşak gece perdesini araladı—en seçkin içkinizi hazırlayın.\nBu uzun bir hikâye. İzin verin, onu ağır ağır anlatalım."
  },
  Activity_67745_ActivityName = {
    Text = "Karlar Eridiğinde: Tekrar"
  },
  Activity_67745_ActivityPlot = {
    Text = "Elworth'taki kar asla erimez, tıpkı onun nefreti gibi.\nGeleceğin ve geçmişin elleri birbirine kenetlendiğinde, savaşçı kılıcını kaldıracak ve intikam için kadere karşı hücum edecektir.\nKara dalgalarla yüzleştiğinde, sen onun sancağısın."
  },
  Activity_67745_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Dağın Dev Çenesi\" kullanılabilir."
  },
  Activity_67745_ActivityTips = {
    Text = "<Title:Etkinlik Tanıtımı>\n1, Etkinlik süresince, Koruyucular sınırlı süreli oynanış \"Vahşi Hırs\" ve \"Başarı Ödülleri\" aracılığıyla üç tür \"Tomurcuk\" toplayabilir. \"Tomurcuklar\", \"Dağ Ağzı\" nda eşya ödülleri karşılığında kullanılabilir; bunlar arasında etkinliğe özel sınırlı SR Kader Çarkı \"Kar Eriyene Dek\", \"Saf Çekirdek\", \"Işıltılı Çekirdek\", \"Eterik Parça\", \"Mimetik Kristal\" ve daha fazlası yer almaktadır.\n2, Etkinlik süresince \"Özel Harekat: Elworth'un Döneni\"ücretsiz olarak açılacaktır.\n\n<Title:Etkinlik Süresi>\n1,13 Temmuz 09:00 - 10 Ağustos 09:00(GMT+8), tüm etkinlik içeriklerine katılabilirsiniz.\n2,10 Ağustos 09:00 - 17 Ağustos 09:00(GMT+8), yalnızca \"Dağ Ağzı\" ve \"Başarı Ödülleri\" erişilebilir olacak, diğer içerikler sona ermiş olacaktır.\n\n<Title: Vahşi Hırs>\n1,\"Vahşi Hırs\" 5 sahne içermekte olup her 2 günde bir otomatik olarak 1 sahne açılır.\n2, Her meydan okuma \"Menofin\" × 120 tüketir; meydan okumayı başarıyla tamamlamak \"Donmuş Tomurcuk\", \"Gümüş Ayaz Tomurcuğu\" ve \"Güneş Işığı Tomurcuğu\" etkinlik para birimlerini kazandırır.\n3, Sahneyi temizledikten sonra o sahnenin \"Yeniden Canlandırma\"özelliği açılır. Lütfen dikkat: \"Yeniden Canlandırma\"özelliği kullanılırken Afinite kazanılamaz.\n4, Sahneleri daha kolay temizlemek için mezun birliği Desteği ve \"Rezonans: Yutma Dağları\" nı kullanabilirsiniz.\n5, Lütfen dikkat: Delilik Zorluğu meydan okumaları Menofin tüketmez, yeniden canlandırılamaz ve ilk tamamlamanın ardından tekrarlanan meydan okumalar etkinlik para birimi ödülü kazandırmaz.\n\n<Title: Tomurcuk Bonusu>\n1, Koruyucuların belirli Uyandırıcılara veya Kader Çarklarına sahip olması(savaşa dahil edilmesi gerekmez), \"Vahşi Hırs\" sahne görevi ödüllerindeki \"Donmuş Tomurcuk\", \"Gümüş Ayaz Tomurcuğu\" ve \"Güneş Işığı Tomurcuğu\" düşüşlerine ek bonus sağlar(Yeniden Canlandırma dahil). Ayrıntılı bonuslar aşağıdaki gibidir:\n·Uyandırıcı \"Helot-catena\": Aydınlanma 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus\n·SSR Kader Çarkı \"Kızıla Batış\": Yükseliş 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus\n·SR Kader Çarkı \"Kar Eriyene Dek\": Yükseliş 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus\n2, Farklı Uyandırıcı veya Kader Çarklarının \"Tomurcuk Bonusları\" birikimli olarak hesaplanır.\n3,Özellikle, Delilik Zorluğu ilk tamamlama ödülleri \"Tomurcuk Bonusu\" ndan etkilenmez.\n\n<Title:Rezonans: Yutma Dağları>\n1, Koruyucular etkinlik başarımlarını tamamlayarak \"Yutma Kalbi\" elde edebilir.\n2,\"Yutma Kalbi\" tüketerek \"Rezonans: Yutma Dağları\" nı etkinleştirmek, Koruyucuların etkinlik oynanışı \"Vahşi Hırs\" ta daha güçlü olmasını ve meydan okumaları daha kolay tamamlamasını sağlar.\n\n<Title: Dağ Ağzı>\n1,\"Dağ Ağzı\" nda üç takas mağazası bulunmakta olup açılış süreleri aşağıdaki gibidir:\n·\"Doyumsuz Hırs\": 13 Temmuz saat 9'da açılır.\n·\"İntikam Öfkesi\": 15 Temmuz saat 9'da açılır.\n·\"Yeniden Doğuş Umudu\": 17 Temmuz saat 9'da açılır.\n2, Her takas \"Donmuş Tomurcuk\"/\"Gümüş Ayaz Tomurcuğu\"/\"Güneş Işığı Tomurcuğu\" × 750 tüketir ve takas mağazasındaki beş eşya ödülünden rastgele birini kazandırır.\n3, Her takas mağazasının eşya ödülleri \"Özel Eşyalar\" ve \"Sıradan Eşyalar\" olarak ikiye ayrılır; sıfırlama yapıldığında özel eşya ödüllerinin kalan miktarı üst sınıra sıfırlanabilir. Ayrıntılı kurallar şu şekildedir:\n(1)İlk 2 sıfırlamada: \"Özel Eşyalar\"ın kalan miktarı tükendiğinde, Koruyucular sıfırlamayı seçebilir; sıfırlama sonrasında \"Özel Eşyalar\" ve \"Sıradan Eşyalar\"ın kalan miktarı üst sınıra sıfırlanır. Ayrıca takas etmeye devam etmeyi de seçebilirler; \"Sıradan Eşyalar\" da tükendiğinde, takas etmeye devam etmek için sıfırlama yapılması gerekir.\n(2)3. sıfırlamadan itibaren: Sıfırlama yalnızca \"Sıradan Eşyalar\"ın kalan miktarı tükendiğinde yapılabilir; sıfırlama \"Sıradan Eşyalar\"ın kalan miktarını üst sınıra sıfırlar, \"Özel Eşyalar\" artık sıfırlanmaz.\n4,17 Ağustos 09:00(GMT+8) sonrasında, kalan takas edilmemiş \"Tomurcuklar\" her biri \"Altın Gül\" × 40 oranında geri toplanacaktır; lütfen Koruyucular postalarını kontrol etmeyi unutmasın.\n\n<Title: Özel Harekat>\n1, Etkinlik süresince \"Özel Harekat: Elworth'un Döneni\"ücretsiz olarak açılacaktır. \"Özel Harekat: Elworth'un Döneni\" ni temizledikten sonra Başarı Ödüllerinden \"Gümüş\", etkinliğe özel sınırlı SR Kader Çarkı \"Kar Eriyene Dek\" ve diğer ödüller alınabilir. Başarı Ödülleri yalnızca etkinlik süresince açık olup etkinlik sona erdikten sonra tamamlanamaz ve alınamaz.\n2, Etkinlik sona erdikten sonra \"Özel Harekat: Elworth'un Döneni\" nin soruşturma ilerlemesi korunacaktır. Etkinlik süresince \"Özel Harekat: Elworth'un Döneni\" açılmamışsa, etkinlik bittikten sonra \"Gerçeklik Başlangıç Noktası\" × 7 tüketerek açmak hâlâ mümkündür.\n3, Etkinlik süresinde olsun ya da olmasın, \"Özel Harekat: Elworth'un Döneni\" ni temizledikten sonra \"Müfreze: Dağların Kararlılığı\" elde edilebilir."
  },
  Activity_67745_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_67746_ActivityName = {
    Text = "Tüm Diyarların Kapısı: Tekrar"
  },
  Activity_67746_ActivityPlot = {
    Text = "Hiç kimse, Son Sınırın Kapısı'nda sessiz nöbetini ne kadar süredir sürdürdüğünü bilmez.\nNe somut bir dünyada vücut bulmayı amaçladı, ne de herhangi bir uzam-zaman akıntısına kapılmayı.\nOrada, Kapı'da, rahatsız edilmeden kaldı—\nTa ki gözleri seninkilerle kesiştiği ana dek."
  },
  Activity_67746_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Yankı\" kullanılabilir."
  },
  Activity_67746_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince, Muhafızlar sınırlı süreli oynanış “Son Sınav” ve “Başarı Ödülleri” aracılığıyla etkinlik parası “Son İbre” toplayabilir. “Son İbre”, “Yankı” içinde etkinliğe özel SR Kader Çarkı “Hakikat Kapısı”, Saf Çekirdek, Lümen Çekirdeği, Eter Taşı Kırıntısı, Taklit Kristali vb. cömert ödüllerle takas edilebilir.\n2. Etkinlik süresince “Başarı Ödülleri” görevlerini tamamlamak, etkinliğe özel avatar “Gümüş Anahtar Adına: Tawil”, etkinliğe özel SR Kader Çarkı “Hakikat Kapısı”, Gümüş ve büyük miktarda etkinlik parası “Son İbre” kazandırır.\n\n<Title:Etkinlik Süresi>\n1. 3 Kasım 9:00 - 17 Kasım 9:00 (GMT+8) arasında tüm etkinlik içeriklerine katılım mümkündür.\n2. 17 Kasım 9:00 - 24 Kasım 9:00 (GMT+8) arasında yalnızca “Yankı” ve “Başarı Ödülleri” açık kalacak, diğer içeriklere artık katılım mümkün olmayacaktır.\n\n<Title:Son Sınav>\n1. “Son Sınav” 9 bölüm içerir, her gün 1 bölüm otomatik olarak açılır.\n2. Her meydan okuma 120 Menophin puanı tüketir; farklı bölümlere meydan okumak, farklı malzeme düşüşleri ve etkinlik parası “Son İbre” kazandırır.\n3. Bu etkinlikteki bölümler, tamamlandıktan sonra tekrar oynanabilen doğrudan savaş malzeme bölümleridir! Her “Yeniden Canlandırma” 120 Menophin puanı tüketir.\n4. Not: “Yeniden Canlandırma” işlevini kullanmak Afinite kazandırmaz.\n\n<Title:Son İbre Bonusu>\n1. Belirli Uyanış Sahiplerine veya Kader Çarklarına sahip olan (düzen içinde bulunmaları gerekmez) Muhafızlar, “Son Sınav” görev ödüllerinde (yeniden oynama dahil) ek “Son İbre” düşüşü elde edebilir. Özel bonuslar şöyledir:\nUyanış Sahibi “Tawil”: Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSSR Kader Çarkı “Görünmez Çark”: Yığılma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSR Kader Çarkı “Hakikat Kapısı”: Yığılma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n2. Farklı Uyanış Sahipleri veya Kader Çarklarının “Son İbre Bonusu” toplamalı biçimde hesaplanır.\n3. Özellikle, Delilik Zorluğu’nun ilk kez tamamlama ödülü “Son İbre Bonusu”ndan etkilenmez.\n\n<Title:Yankı>\n1. “Yankı” yalnızca 3 Kasım 9:00 - 24 Kasım 9:00 (GMT+8) arasında açıktır.\n2. 24 Kasım 9:00 (GMT+8) sonrasında, kullanılmamış tüm “Son İbre”ler, her takas için “Gül Senedi *40” oranıyla dönüştürülecektir. Lütfen postanızı kontrol edin ve bunları zamanında alın."
  },
  Activity_67746_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_67746_UnlockConditionExplanation = {
    Text = "Ana Hikâye 2-9: Normal tamamlandıktan sonra açılır"
  },
  Activity_67748_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_67749_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_68349_ActivityName = {
    Text = "Yıldızların Ötesinde: Sınırlı Ön Sipariş"
  },
  Activity_68349_ActivityTips = {
    Text = "<Title:Yıldızların Ötesinde: Sınırlı Ön Sipariş>\nBu sınırlı ön sipariş etkinliği 8 hediye paketi içerir. İlk paket hemen ücretsiz olarak talep edilebilirken, 2. ile 8. paketlerin talep edilebilmesi için \"Yıldızların Ötesinde: Sınırlı Ön Sipariş\" satın alınması gerekmektedir.\n\"Yıldızların Ötesinde: Sınırlı Ön Sipariş\" satın alındığında, 2. hediye paketinin ödülünü hemen alacaksınız. Sonraki paketler belirli bir bekleme süresinin ardından talep edilmelidir.\n\"Yıldızların Ötesinde: Sınırlı Ön Sipariş\" satın alma süresi sınırlıdır ve son tarihten sonra tamamlanamaz. Koruyucu olarak kararınızı verirken lütfen bunu göz önünde bulundurun."
  },
  Activity_68374_ActivityName = {
    Text = "Gündönümü Geçidi Hediye Kutusu"
  },
  Activity_68374_ActivityPlot = {
    Text = "Gündönümü Geçidi kutlaması için Mythag tarafından sağlanan bir hediye kutusu. Ne rüzgâr ne de ayaz, Mythag'ın Çözünme'ye karşı direnme iradesini yıkabilir. Kutlama ateşinin ışığında, birbirini destekleyen ruhlar, Kader'e boyun eğmeyi reddeden herkesi koruyacaktır."
  },
  Activity_68375_ActivityName = {
    Text = "Yıl Dönümü Özel Hediye Kutusu"
  },
  Activity_68375_ActivityPlot = {
    Text = "Gümüş çip teknolojisi ile yeniden şekillendirilmiş, Bakış'ı size eşlik etmek için yeni formlar alıyor. Geçen yılın her anında, O sizinle birlikteydi."
  },
  Activity_68404_ActivityName = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_68404_ActivityPlot = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_68404_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Geçici Metin\" kullanılabilir."
  },
  Activity_68404_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\nGeçici Metin"
  },
  Activity_68404_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_68405_ActivityName = {
    Text = "Tanrı Kralın Dönüşü"
  },
  Activity_68405_ActivityPlot = {
    Text = "Dileklerin sonsuz arzusu içinde, uzun Hafif Uykusundan kısaca uyanır ve bu donuk dünyaya gerçek bir bakış fırlatır.\nEbedi bir yaşamda, bu bakış öylesine kısadır ki"
  },
  Activity_68405_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Farkındalık Uçurumu\" Alınabilir."
  },
  Activity_68405_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli oynanış “Aequor Bakışı” ve “Başarı Ödülleri” aracılığıyla etkinlik para birimleri “Miskin Düşünceler”, “Kederli Düşünceler” ve “Neşeli Düşünceler”i toplayabilir. Bu para birimleri, “Şuurlu Uçurum”da etkinliğe özel SR Kader Çarkı “Mavi Taş Tahtı”, Lümen Çekirdeği, Saf Çekirdek, Bilge Taşı Kırıntıları ve Simulacra Kristalleri gibi eşyaları satın almak için kullanılabilir.\n2. Etkinlik süresince, etkinlik başarımlarını tamamlamak ayrıca sana etkinliğe özel Avatar “Gümüş Anahtar Adına: Tulu”yu, etkinliğe özel SR Kader Çarkı “Mavi Taş Tahtı”nı, Gümüş ve bol miktarda etkinlik para birimi kazandırır!\n\n<Title:Etkinlik Süresi>\n1. 30 Aralık 9:00’dan 13 Ocak 9:00’a kadar (GMT+8), tüm etkinlik faaliyetleri açıktır.\n2. 13 Ocak 9:00’dan 20 Ocak 9:00’a kadar (GMT+8), yalnızca “Şuurlu Uçurum” ve başarı ödülleri açıktır.\n\n<Title:Aequor Bakışı>\n1. “Aequor Bakışı” 5 aşamadan oluşur, her 2 günde bir aşama kendiliğinden açılır.\n2. Her mücadele 120 Menofin tüketir ve başarılı mücadeleler etkinlik para birimi kazandırır.\n3. Bir aşama temizlendiğinde, o aşama için “Prova” özelliği açılır. Not: “Prova” özelliğini kullanırken Afinite kazanılamaz.\n4. Aşamaları daha kolay temizlemek için Mezun yardımı kullanabilirsin.\n\n<Title:Düşünceler Artışı>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan (sahaya sürülmeleri gerekmez) Muhafızlar, “Aequor Bakışı”nın aşama görevlerinde etkinlik para birimi için ek düşüş artışı elde edebilir. Belirli artışlar şöyledir:\nUyanan “Tulu”: Aydınlanma 0/1/2/3 ve üzeri, artış %20/%30/%40/%50.\nSSR Kader Çarkı “Tanrı Kralın İlahisi”: Katman 0/1/2/3 ve üzeri, artış %20/%30/%40/%50.\nSR Kader Çarkı “Mavi Taş Tahtı”: Katman 0/1/2/3 ve üzeri, artış %20/%30/%40/%50.\n2. Farklı Uyananların veya Kader Çarklarının “Düşünceler Artışı” kümülatif olarak hesaplanır.\n3. Özellikle, Delilik Zorluğu mücadelesinin ilk tamamlama ödülü “Düşünceler Artışı”ndan etkilenmez.\n\n<Title:Şuurlu Uçurum>\n1. “Şuurlu Uçurum” yalnızca 30 Aralık 9:00’dan 20 Ocak 9:00’a kadar (GMT+8) açıktır.\n2. 20 Ocak 9:00’dan (GMT+8) sonra, takas edilmemiş kalan tüm “Miskin Düşünceler”, “Kederli Düşünceler” ve “Neşeli Düşünceler”, her biri için “Gül Senedi Bileti*40” oranıyla geri alınacaktır. Muhafızlar, lütfen postanızı kontrol edin."
  },
  Activity_68405_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_68406_ActivityName = {
    Text = "Hafızanın Altına Gömülü"
  },
  Activity_68406_ActivityPlot = {
    Text = "İnsanlar arzularını anılarının derinliklerine gömer, dünyaya uyum sağlamak için hayali maskeler takar.\nDinle, et ve kemik kabuğunun altında örtülen çığlıklar hafızanın sisinde yankılanıyor.\nZihnini boşalt, bedeni terk et, gerçek benliğinle yüzleş."
  },
  Activity_68406_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi, şu anda yalnızca \"Nöral Terapi Odası\"na katılabilirsiniz"
  },
  Activity_68406_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\nEtkinlik süresince Muhafızlar, sınırlı süreli \"Korku Tedavisi\" oynanışı ve \"Başarı Ödülleri\" aracılığıyla etkinlik parası toplayabilir. Etkinlik parası, \"Nöral Terapi Odası\"nda, etkinliğe özel SR Kader Çarkı \"Hipnotik Sarkaç\", Felsefe Taşı, Saf Çekirdek, Lümen Çekirdeği ve daha fazlasını içeren eşya ödülleriyle takas edilebilir.\n\n<Title:Etkinlik Süresi>\n1. 7 Nisan 9:00 - 21 Nisan 9:00 (GMT+8): Tüm etkinlik içeriklerine katılım mümkündür.\n2. 21 Nisan 9:00 - 28 Nisan 9:00 (GMT+8): Yalnızca \"Nöral Terapi Odası\" ve \"Başarı Ödülleri\" kalır, diğer tüm içerikler sona erer ve artık erişilemez.\n\n<Title:Korku Tedavisi>\n1. \"Korku Tedavisi\" 5 aşama içerir, her 2 günde bir 1 aşama otomatik olarak açılır.\n2. Her meydan okuma 120 Menofin tüketir ve meydan okumayı başarıyla tamamlamak etkinlik parası kazandırır.\n3. Bir aşama temizlendiğinde, o aşama için \"Yeniden Canlandır\" özelliği açılır. Not: \"Yeniden Canlandır\" özelliğini kullanmak Afinite kazandırmaz.\n4. Aşamaları daha kolay temizlemek için Mezunlar Birliği desteğinden yararlanabilirsiniz.\n\n<Title:Etkinlik Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan Muhafızlar (savaşa sokulmaları gerekmez), \"Korku Tedavisi\" aşama görevlerinde (Yeniden Canlandır dâhil) \"Teşhis Raporu\" düşüşlerine ekstra bonus elde edebilir. Özel bonuslar şöyledir:\nUyanan \"\"Clementine\"\": Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSSR Kader Çarkı \"Örtülü Acı\": Yükseliş Rütbesi 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSR Kader Çarkı \"Hipnotik Sarkaç\": Yükseliş Rütbesi 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n2. Farklı Uyananlar veya Kader Çarklarından gelen \"Etkinlik Bonusu\" üst üste eklenerek hesaplanır.\n3. Özellikle, Delilik Zorluğu meydan okumalarındaki ilk tamamlama ödülü \"Etkinlik Bonusu\"ndan etkilenmez.\n\n<Title:Nöral Terapi Odası>\n1. Her \"Rapor Gönder\", 1.000 \"Teşhis Raporu\" tüketir ve \"Nöral Terapi Odası\"ndan rastgele beş eşya ödülü verir.\n2. \"Nöral Terapi Odası\"ndaki eşya ödülleri \"Özel Eşyalar\" ve \"Sıradan Eşyalar\" olarak ikiye ayrılır. Sıfırlama, kalan özel eşya ödülü miktarlarının üst sınıra kadar yenilenmesini sağlar. Ayrıntılı kurallar şöyledir:\n(1) İlk 5 sıfırlama: Hiç \"Özel Eşya\" kalmadığında, Muhafızlar sıfırlamayı seçerek kalan \"Özel Eşyalar\" ve \"Sıradan Eşyalar\"ın miktarlarını üst sınıra döndürebilir; ayrıca takasa devam etmeyi de seçebilirler ve \"Sıradan Eşya\" miktarı da kalmadığında, takasa devam etmek için sıfırlama zorunlu hâle gelir.\n(2) 6. sıfırlamadan itibaren: Sıfırlama yalnızca hiç \"Sıradan Eşya\" kalmadığında yapılabilir; sıfırlama, kalan \"Sıradan Eşyalar\"ın miktarını üst sınıra döndürür, \"Özel Eşyalar\" ise artık sıfırlanmaz.\n3. 28 Nisan 9:00 (GMT+8) sonrasında, kullanılmamış kalan \"Teşhis Raporu\" her biri için \"Gül Senedi*40\" oranıyla geri alınacaktır. Muhafızlar, lütfen postanızı kontrol etmeyi unutmayın."
  },
  Activity_68406_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_68407_ActivityName = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_68407_ActivityPlot = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_68407_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Geçici Metin\" kullanılabilir."
  },
  Activity_68407_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\nGeçici Metin"
  },
  Activity_68407_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_68409_ActivityName = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_68409_ActivityPlot = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_68409_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Geçici Metin\" kullanılabilir."
  },
  Activity_68409_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\nGeçici Metin"
  },
  Activity_68409_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_68410_ActivityName = {
    Text = "Yağmur Kasabasının Hayaleti"
  },
  Activity_68410_ActivityPlot = {
    Text = "Kaderin yazdığı bir karşılaşma, nemli ve puslu yağmurun içinde seni bekliyor. Adını da yüzünü de biliyorsun; sesi hâlâ seni bir huzur duygusuna uyutuyor.\nAma unutma—insan arzularını böylesine doyurmaya hevesli olanlar yalnızca tanrılar ve şeytanlardır.\nTahmin et. O hangisi?"
  },
  Activity_68410_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Artık yalnızca \"Cadının Hazinesi\"ne katılabilirsin."
  },
  Activity_68410_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli \"Cadının Dükkânı\" oynanışı ve \"Başarı Ödülleri\" aracılığıyla etkinlik parası toplayabilir. Etkinlik parası, \"Cadının Hazinesi\"nde etkinliğe özel SR Kader Çarkı \"Cadının Geniş Kenarlı Şapkası\", Felsefe Taşı, Saf Çekirdek ve Lümen Çekirdeği gibi eşya ödülleriyle takas edilebilir.\n2. Etkinlik süresince \"Özel Sevk Kaydı: Yağmurlu Kasaba Gölgesi\" ücretsiz olarak açık olacak ve etkinlik başarımlarını tamamlamak size etkinliğe özel avatar \"Gümüş Anahtar Adına: Nergis\"i de kazandıracaktır!\n\n<Title:Etkinlik Süresi>\n1. 24 Şubat 9:00’dan 10 Mart 9:00’a kadar (GMT+8) tüm etkinlik içeriklerine katılım mümkündür.\n2. 10 Mart 9:00’dan 17 Mart 9:00’a kadar (GMT+8) yalnızca \"Cadının Hazinesi\" ve \"Başarı Ödülleri\" erişilebilir; diğer içerikler sona ermiş olacak ve kullanılamayacaktır.\n\n<Title:Cadının Dükkânı>\n1. \"Cadının Dükkânı\" 5 seviyeden oluşur; her 2 günde bir 1 seviye kendiliğinden açılır.\n2. Her meydan okuma 120 Menophin tüketir ve başarılı meydan okumalar etkinlik parası kazandırır.\n3. Seviye temizlendikten sonra o seviyenin \"Yeniden Ziyaret\" işlevi açılır. Not: \"Yeniden Ziyaret\" işlevini kullanmak Yakınlık kazandırmaz.\n4. Seviyeleri daha kolay geçmek için Mezun yardımı kullanabilirsiniz.\n\n<Title:Etkinlik Bonusları>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan Muhafızlar (savaşa sokulmaları gerekmez), \"Cadının Dükkânı\" görev ödüllerinde (Yeniden Ziyaret dâhil) \"Solgun Canavar Kafatası\", \"Gölge Canavar Kafatası\" ve \"Kızıl Canavar Kafatası\" için ek düşüş bonusları kazanır. Özel bonuslar şöyledir:\nUyanan \"Nergis\": Aydınlanma 0/1/2/3 veya üzeri, bonus: %20/%30/%40/%50\nSSR Kader Çarkı \"En Kıymetli Koleksiyon\": Yığın Konumu 0/1/2/3 veya üzeri, bonus: %20/%30/%40/%50\nSR Kader Çarkı \"Cadının Geniş Kenarlı Şapkası\": Yığın Konumu 0/1/2/3 veya üzeri, bonus: %20/%30/%40/%50\n2. Farklı Uyananlar veya Kader Çarklarından gelen \"Etkinlik Bonusları\" kümülatif olarak hesaplanır.\n3. Özellikle, Delilik zorluğundaki meydan okumaların ilk kez tamamlama ödülleri \"Etkinlik Bonusları\"ndan etkilenmeyecektir.\n\n<Title:Cadının Hazinesi>\n1. Üç adet \"Cadının Hazinesi\" vardır ve açılış zamanları şöyledir:\n\"Tesellinin Keyfi\": 24 Şubat 9:00 ~ 17 Mart 9:00.\n\"Gösterişli Sırlar\": 26 Şubat 9:00 ~ 17 Mart 9:00.\n\"Kıymetli Emtia\": 28 Şubat 9:00 ~ 17 Mart 9:00.\n2. Her takas 750 \"Solgun Canavar Kafatası\"/\"Gölge Canavar Kafatası\"/\"Kızıl Canavar Kafatası\" tüketir ve hazineden rastgele beş eşya ödülü elde edilir.\n3. Her hazinenin eşya ödülleri \"Özel Eşyalar\" ve \"Sıradan Eşyalar\" olarak ayrılır ve sıfırlama, belirtilen eşya ödüllerinin kalan miktarının sınırına kadar yeniden ayarlanmasına imkân tanır. Özel kurallar şunlardır:\n(1) İlk 2 sıfırlama için: \"Özel Eşyalar\"ın kalan miktarı tükendiğinde, Muhafızlar sıfırlamayı seçebilir; bu, \"Özel Eşyalar\"ın ve \"Sıradan Eşyalar\"ın kalan miktarını sınırına kadar geri yükler; ayrıca takasa devam etmeyi de seçebilirler. \"Sıradan Eşyalar\"ın da kalan miktarı tükendiğinde, takasa devam etmek için sıfırlama zorunludur.\n(2) 3. sıfırlamadan itibaren: Sıfırlama yalnızca \"Sıradan Eşyalar\"ın kalan miktarı tükendiğinde yapılabilir ve \"Sıradan Eşyalar\"ın kalan miktarını sınırına kadar geri yükler; \"Özel Eşyalar\" artık sıfırlanmaz.\n\n<Title:Özel Sevk Kaydı>\n1. Etkinlik süresince \"Özel Sevk Kaydı: Yağmurlu Kasaba Gölgesi\" ücretsiz olarak açık olacaktır.\n2. Etkinlik sona erdikten sonra \"Özel Sevk Kaydı: Yağmurlu Kasaba Gölgesi\"nin soruşturma ilerlemesi korunur. Etkinlik sırasında açılmadıysa, etkinlik sonrasında \"Gerçeklik Sınırı\"*7 tüketerek yine de açılabilir.\n3. İster etkinlik sırasında ister sonrasında olsun, \"Özel Sevk Kaydı: Yağmurlu Kasaba Gölgesi\"ni temizlemek her zaman \"Çete: Sis’in Gerçek Sureti\" ödülünü verir."
  },
  Activity_68410_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_68411_ActivityName = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_68411_ActivityPlot = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_68411_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Geçici Metin\" kullanılabilir."
  },
  Activity_68411_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\nGeçici Metin"
  },
  Activity_68411_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_70438_ActivityName = {
    Text = "Uzza Kedi Yasası"
  },
  Activity_70438_ActivityPlot = {
    Text = "Dilek Yeni Yıl Festivali yaklaşırken herkes kutlama hazırlıklarına odaklanmış, köşelerdeki karanlık lekelerin gizlice kıpırdandığını fark etmemiştir. Minik mahkum sıvılaşarak kafesinden kaçmıştır.\nBoyutsal yarıkların titreşimiyle siyah tüy yumağı bölünmeye başlar... Devasa bir kara kedi seli tüm kampüsü yutmaktadır!\nBaşlangıçta bunu görmezden gelip tuhaf olayı okul idaresine havale etmeyi düşündünüz.\nAma Gümüş ve Altın Bilet düşürdüklerini fark edince fikrinizi değiştirdiniz."
  },
  Activity_70438_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n\"Ozza Kedi Yasası\" adlı oynanış etkinliği sınırlı bir süre için Alınabilir! Etkinlik süresince, Koruyucular “Kaotik Kedi Dansı”nda kampüs kedilerini pataklayarak yüklü miktarda Gümüş ve Gül Senet Kuponu kazanabilir!\n\n<Title:Etkinlik Süresi>\n24 Ocak, 9:00 - 5 Şubat, 9:00 (GMT+8). Etkinlik süresince, her gün açılan “Kaotik Kedi Dansı” bölümlerine katılabilirsiniz. Tamamlanan bölümler yeniden oynanamaz.\n\n<Title:Kaotik Kedi Dansı>\n1. “Kaotik Kedi Dansı” 12 bölümden oluşur ve her gün farklı bölümler açılır. Tamamlanan bölümler yeniden oynanamaz.\n2. Her meydan okuma Menofin tüketmez ve bir bölümü tamamladığınızda Saf Çekirdekler, Gümüş ve Gül Senet Kuponları alırsınız.\n3. Bu bölümlerde Mezun yardımı kullanılamaz.\n4. Günün bölümlerinde her Uyanan yalnızca bir kez katılabilir.\n5. Her günün bölümleri, meydan okumalar için belirli diyarlar gerektirir:\n24 Ocak: Kaos Diyarı\n25 Ocak: Aequor Diyarı\n26 Ocak: Caro Diyarı\n27 Ocak: Ultra Diyar\n28 Ocak: Kısıtlama Yok\n29 Ocak: Kısıtlama Yok\n30 Ocak: Kaos Diyarı ve Aequor Diyarı\n31 Ocak: Caro Diyarı ve Ultra Diyar\n1 Şubat: Kaos Diyarı ve Caro Diyarı\n2 Şubat: Aequor Diyarı ve Ultra Diyar\n3 Şubat: Kaos Diyarı ve Ultra Diyar\n4 Şubat: Caro Diyarı ve Aequor Diyarı"
  },
  Activity_70438_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_71095_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_71095_ActivityTips = {
    Text = "<Title:Katılım Koşulları>\n\" Soruşturma Operasyonu\" 2-9'u (Normal) tamamlayarak katılın.\n<Title:Soruşturma Olayı>\nEtkinlik süresince, \"Hikâyelerin Büyüsü\"nden her gün yeni bir soruşturma olayı başlatılacaktır. Koruyucular, envanter tüketmeden kilidini açıp soruşturma yürütebilir. Soruşturma olayını tamamladıktan sonra Saf Çekirdek, Soruşturma Rozeti ve Koruyucu Deneyimi gibi ödüller elde edilebilir.\nEtkinlik sona erdikten sonra, \"Hikâyelerin Büyüsü\"nün soruşturma ilerlemesi korunacaktır. Koruyucular, Özel Görev Kayıtları'nda D-Mücevher harcayarak tamamlanmamış soruşturmaların kilidini açabilir. Etkinlik süresince tamamlanmamış soruşturma olaylarını tamamlamak, etkinlik sırasında verilenlerle tutarlı ödüller kazandıracaktır.<Title:Sınırlı Süreli Ödüller>\nEtkinlik süresince sınırlı süreli ödüller alınabilir olacaktır. Koruyucular, \"Hikâyelerin Büyüsü\"nü (Normal mod) temizleyip soruşturma olaylarını tamamladıktan sonra Saf Çekirdek, Felsefe Taşı ve Gümüş elde edebilir! Sınırlı süreli ödüller yalnızca etkinlik süresince alınabilir, etkinlik sona erdikten sonra tamamlanamaz veya talep edilemez."
  },
  Activity_71097_ActivityName = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_71097_ActivityPlot = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_71097_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Geçici Metin\" kullanılabilir."
  },
  Activity_71097_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\nGeçici Metin"
  },
  Activity_71097_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_71098_ActivityName = {
    Text = "Yarım Adım Ötede·Tekrar"
  },
  Activity_71098_ActivityPlot = {
    Text = "O, dünyanın hep bir adım önünde yürür.\nBir adım, iki adım—ayak izleri herkes için Fitil Yolu’nu aydınlatır.\nAma ahmaklar çok çabuk unutur:\nDeha ile Delilik arasındaki mesafe\nyalnızca yarım adımdır."
  },
  Activity_71098_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi; şu anda yalnızca \"Üstadın Öğretisi\"ne katılabilirsiniz."
  },
  Activity_71098_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\nEtkinlik süresi boyunca Muhafızlar, sınırlı süreli \"Unutuş Kapısı\" ve \"Başarı Ödülleri\" oynanışları aracılığıyla etkinlik para birimi \"Kukla Parçaları\" toplayabilir. \"Kukla Parçaları\", \"Üstadın Öğretileri\"nde etkinliğe özel SR Kader Çarkı \"Çobanın Asası\", Lümen Çekirdekleri, Saf Çekirdekler, Bilge Taşı Parçaları, Taklit Kristalleri ve daha fazlası ile takas edilebilir.\n\n<Title:Unutuş Kapısı>\n1. \"Unutuş Kapısı\", keşif olmaksızın doğrudan savaş içeren 9 malzeme aşaması barındırır ve her gün bir aşama açılır.\n2. Her meydan okuma 120 Menophin tüketir; başarıyla tamamlanan meydan okumalar eğitim malzemeleri ve etkinlik para birimi kazandırır.\n3. Bir aşama tamamlandıktan sonra o aşama için \"Yeniden Canlandır\" özelliği açılır. Not: \"Yeniden Canlandır\" özelliği Yakınlık kazandırmaz.\n4. Aşamaları daha kolay geçmek için Mezun desteğini kullanabilirsiniz.\n\n<Title:Kukla Parçası Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan (sahaya sürülmeleri gerekmez) Muhafızlar, \"Unutuş Kapısı\" aşama ödüllerinde (Yeniden Canlandır dâhil) \"Kukla Parçaları\" için ek düşüş bonusları elde edebilir. Özel bonuslar şöyledir:\nUyanan \"Doll: Cehennem\": Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSSR Kader Çarkı \"Unutuşun Kuklaları\": Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSR Kader Çarkı \"Çobanın Asası\": Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n2. Farklı Uyananların veya Kader Çarklarının \"Kukla Parçası Bonusları\" birikimli olarak hesaplanır.\n3. Özellikle, Delilik Zorluğu ilk-temizleme ödülleri bu bonuslardan etkilenmez.\n\n<Title:Üstadın Öğretileri>\n1. Her \"Parça Takası\" 750 \"Kukla Parçası\" tüketir ve \"Üstadın Öğretileri\"nden rastgele beş eşya verir.\n2. \"Üstadın Öğretileri\"ndeki eşya ödülleri \"Özel Eşyalar\" ve \"Sıradan Eşyalar\" olarak ikiye ayrılır. Sıfırlama sırasında, özel eşya ödüllerinin kalan miktarı azamiye sıfırlanabilir. Özel kurallar şöyledir:\n(1) İlk 5 sıfırlama: \"Özel Eşyalar\" tükendiğinde, Muhafızlar sıfırlamayı seçebilir; bu, hem \"Özel Eşyalar\"ın hem de \"Sıradan Eşyalar\"ın kalan miktarını azamiye döndürür; ayrıca takasa devam etmeyi de seçebilirler. \"Sıradan Eşyalar\" tükendiğinde, takasa devam edebilmek için sıfırlama zorunludur.\n(2) 6. sıfırlamadan itibaren: Yalnızca \"Sıradan Eşyalar\" tükendiğinde sıfırlama yapılabilir; bu, \"Sıradan Eşyalar\"ın kalan miktarını azamiye döndürürken, \"Özel Eşyalar\" sıfırlanmaz.\n\n<Title:Etkinlik Süresi>\n1. 16 Haziran 9:00 - 30 Haziran 9:00 (GMT+8) arasında, Etkinlik Özetinde yer alan tüm içerikler erişime açıktır.\n2. 30 Haziran 9:00 - 7 Temmuz 9:00 (GMT+8) arasında yalnızca \"Üstadın Öğretileri\" ve \"Başarı Ödülleri\" kalır, diğer tüm içerikler sona erer ve erişilemez hâle gelir.\n3. 7 Temmuz 9:00 (GMT+8) sonrasında, takas edilmemiş kalan \"Kukla Parçaları\" her bir parça başına 40 Gül Senedi oranıyla geri dönüştürülecektir. Lütfen postalarınızı kontrol edin, Muhafızlar."
  },
  Activity_71098_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_71100_ActivityName = {
    Text = "Tanrı Kralın Dönüşü"
  },
  Activity_71100_ActivityPlot = {
    Text = "Dileklerin sonsuz arzusu içinde, uzun Hafif Uykusundan kısaca uyanır ve bu donuk dünyaya gerçek bir bakış fırlatır.\nEbedi bir yaşamda, bu bakış öylesine kısadır ki"
  },
  Activity_71100_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Farkındalık Uçurumu\" Alınabilir."
  },
  Activity_71100_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli “Aequor Bakışı” mekaniği ve “Başarı Ödülleri” aracılığıyla etkinlik para birimleri “Yorgun Düşünceler”, “Hüzünlü Düşünceler” ve “Neşeli Düşünceler”i toplayabilir. Etkinlik para birimleri, “Uçurum Aydınlanması” içinde etkinliğe özel SR Kader Çarkı “Mavi Taş Tahtı”, Lümen Çekirdeği, Saf Çekirdek, Eter Taşı Kırıntısı, Taklit Kristali vb. eşyaları satın almak için kullanılabilir.\n2. Etkinlik süresince, etkinlik başarımlarını tamamlamak ayrıca etkinliğe özel avatar “Gümüş Anahtar Adına: Caecus”u, etkinliğe özel SR Kader Çarkı “Mavi Taş Tahtı”nı, Gümüş ve büyük miktarda etkinlik para birimi kazandırır!\n\n<Title:Etkinlik Süresi>\n1. 30 Aralık 9:00 - 13 Ocak 9:00 (GMT+8) arasında, tüm etkinlik mekaniklerine katılım sağlanabilir.\n2. 13 Ocak 9:00 - 20 Ocak 9:00 (GMT+8) arasında yalnızca “Uçurum Aydınlanması” ve başarı ödüllerine katılım sağlanabilir.\n\n<Title:Aequor Bakışı>\n1. “Aequor Bakışı” 5 seviyeden oluşur, her 2 günde bir seviye kendiliğinden açılır.\n2. Her mücadele 120 Menofin tüketir ve başarılı bir mücadele etkinlik para birimi kazandırır.\n3. Bir seviye temizlendiğinde, o seviyenin “Yeniden Canlandır” işlevi açılır. Lütfen dikkat: “Yeniden Canlandır” işlevini kullanmak Afinite kazandırmaz.\n4. Seviyeleri daha kolay geçmek için Alumnis yardımı kullanabilirsiniz.\n\n<Title:Düşünce Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan (dizilimde bulunmaları gerekmez) Muhafızlar, “Aequor Bakışı” seviye görevlerindeki etkinlik para birimi ödüllerine ek düşüş bonusu kazandırabilir; belirli bonuslar şöyledir:\nUyanan “Tulu”: Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\nSSR Kader Çarkı “Tanrı Kralın İlahisi”: Yığın 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\nSR Kader Çarkı “Mavi Taş Tahtı”: Yığın 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\n2. Farklı Uyananların veya Kader Çarklarının “Düşünce Bonusu” toplamsal olarak hesaplanır.\n3. Özellikle, Delilik Zorluğu mücadelelerinin ilk tamamlama ödülü “Düşünce Bonusu”ndan etkilenmez.\n\n<Title:Uçurum Aydınlanması>\n1. “Uçurum Aydınlanması” yalnızca 30 Aralık 9:00 - 20 Ocak 9:00 (GMT+8) arasında açıktır.\n2. 20 Ocak 9:00 (GMT+8) sonrasında, değiştirilmemiş tüm “Yorgun Düşünceler”, “Hüzünlü Düşünceler” ve “Neşeli Düşünceler” “her takas için 40 Gül Senedi” oranıyla geri alınacaktır. Muhafızların bildirimler için postalarını kontrol etmeleri tavsiye edilir."
  },
  Activity_71100_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_71101_ActivityName = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_71101_ActivityPlot = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_71101_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Geçici Metin\" kullanılabilir."
  },
  Activity_71101_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\nGeçici Metin"
  },
  Activity_71101_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_71102_ActivityName = {
    Text = "Hikâyelerin Büyüsü·Tekrar"
  },
  Activity_71102_ActivityPlot = {
    Text = "Bebek’in verdiği görevler asla basit değildir.\nHerkese defalarca “eğlenin” diye hatırlatmasına rağmen, bir grup Uyanan’ı ilk kez dışarı çıkaran Koruyucu nasıl gergin olmasın?\nAma unutma, “eğlenmek” gerek, tamam mı."
  },
  Activity_71102_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Büyü Yazıtı Dükkanı\" kullanılabilir."
  },
  Activity_71102_ActivityTips = {
    Text = "<Title:Etkinlik Genel Bakış>\n1. \"Hikayelerin Büyüsü\" oynanış etkinliği sınırlı bir süre için geri döndü! Koruyucular, etkinliğe özel Kader Çarkı \"35mm Sihir\" ve etkinliğe özel avatar \"Gümüş Anahtarla: Lily\"yi tekrar elde etmek için \"Sihirli Senaryo Dükkânı\" ve \"Başarım Ödülleri\"ne erişebilir!\n2. Etkinlik süresince, \"Özel Operasyon: Hikayelerin Büyüsü\" sınırlı süreli ücretsiz erişim için kullanılabilir olacaktır.\n\n<Title:Etkinlik Zamanı>\n1. 3 Haziran 9:00'dan 17 Haziran 9:00'a kadar (GMT+8), etkinlik tanıtımındaki tüm içeriklere katılınabilir.\n2. 17 Haziran 9:00'dan 24 Haziran 9:00'a kadar (GMT+8), yalnızca \"Sihirli Senaryo Dükkânı\" ve \"Başarım Ödülleri\" erişilebilir kalacaktır; diğer içerikler sona ermiş olacak ve katılınamayacaktır.\n\n<Title:Senaryo Gizemi>\n1. \"Senaryo Gizemi\" 9 malzeme seviyesinden oluşur, her gün bir seviye otomatik olarak açılır. Açıldıktan sonra, meydan okumak için önceki Özel Operasyon seviyesini temizlemeniz gerekir.\n2. Her meydan okuma 60 Menofin puanı harcar. Başarılı meydan okumalar, etkinlik para birimi \"Sürüklenen İlham\" ve yetiştirme malzemeleri ile ödüllendirilir. Bu etkinlikteki malzeme seviyelerini temizlemek yeniden canlandırmayı destekler.\n3. Seviyeleri daha kolay temizlemek için Mezunlar desteğini ve \"Rezonans: Yönetmen Şifresi\"ni kullanabilirsiniz.\n\n<Title:İlham Bonusu>\n1. Belirli Uyandırıcılara veya Kader Çarklarına sahip olan Koruyucular (takım dizilişinde olması gerekli değildir), \"Senaryo Gizemi\"nin görev ödüllerinde (yeniden canlandırma dahil) \"Sürüklenen İlham\" için ek düşürme bonusu kazanır. Belirli bonuslar aşağıdaki gibidir:\nUyandırıcı \"Lily\": Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSSR Kader Çarkı \"Acıyı Aşmak\": Yığınlama 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSR Kader Çarkı \"35mm Sihir\": Yığınlama 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n2. Farklı Uyandırıcılar veya Kader Çarklarının \"İlham Bonusları\" birikimli olarak hesaplanır.\n\n<Title:Rezonans: Yönetmen Şifresi>\n1. Koruyucular, etkinlik başarımlarını tamamlayarak \"Çıkarım Kalbi\" elde edebilir.\n2. \"Çıkarım Kalbi\" harcayarak \"Rezonans: Yönetmen Şifresi\"ni etkinleştirmek, Koruyucuları \"Senaryo Gizemi\" ve \"Özel Operasyon: Hikayelerin Büyüsü\" etkinlik oynanışında daha güçlü kılar ve \"Senaryo Gizemi\" meydan okumalarını tamamladıktan sonra elde edilen \"Sürüklenen İlham\" ve Afinite ödüllerini artırır.\n\n<Title:Başarım Ödülleri>\n1. Başarım görevlerini tamamlamak, etkinliğe özel avatar \"Gümüş Anahtarla: Lily\", etkinlik para birimi \"Sürüklenen İlham\" ve Gümüş kazandırır.\n2. 25 görev içerir: \"Senaryo Gizemi\"nin her seviyesini bir kez temizlemek, her Diyar takımıyla \"Senaryo Gizemi\"ni 1/2 kez temizlemek, \"Özel Operasyon: Hikayelerin Büyüsü\"ndeki her soruşturma olayını bir kez temizlemek ve tüm etkinlik başarımlarını tamamlamak.\n\n<Title:Özel Operasyon>\n1. Etkinlik süresince, \"Özel Operasyon: Hikayelerin Büyüsü\" ücretsiz olarak açılabilir.\n2. \"Özel Operasyon: Hikayelerin Büyüsü\"nde Koruyucular, hikaye ön ayarı \"Lily\"yi içeren özel bir takım yapılandırması kullanarak meydan okuyacaktır.\n\n<Title:Diriliş Telafisi>\n1. Daha önce \"Özel Operasyon: Hikayelerin Büyüsü\"nü açmış olan Koruyucular, bu diriliş etkinliğinde tekrar açtıklarında \"Sürüklenen İlham\" *1000 telafisi alacaktır.\nDaha önce etkinliğe özel avatar \"Gümüş Anahtarla: Lily\"yi elde etmiş olan Koruyucular, tekrarlanan ödülleri otomatik olarak \"Sürüklenen İlham\" *3000'e dönüştürecektir.\nDaha önce Rezonans etkinleştirme malzemesi \"Çıkarım Kalbi\"ni elde etmiş olan Koruyucular, elde edilen her ek \"Çıkarım Kalbi\"ni otomatik olarak \"Altın Gül\" *5000'e dönüştürecektir.\n"
  },
  Activity_71102_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_71325_ActivityName = {
    Text = "İsimsiz Şiir"
  },
  Activity_71325_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"İsimsiz Şiir\" etkinliği süresince Koruyucular, Horla'yı içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden demo ödüllerini talep edebilir."
  },
  Activity_71329_ActivityName = {
    Text = "Balçık Çiçeği"
  },
  Activity_71329_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Balçık Çiçeği\" etkinliği süresince Koruyucular, Lily'yi içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini oynarken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_71743_ActivityName = {
    Text = "Kafatası Avcısı Cadı"
  },
  Activity_71743_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Kafatası Avcısı Cadı\" etkinliği süresince, Koruyucular Nergis'i içeren sistem tarafından hazırlanmış takımları kullanarak belirlenen bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken, takım kadrosundaki Uyandırıcılarda değişiklik yapılmasına izin verilmez.\n<Title:Etkinlik Ödülleri>\nBölüm mücadelesini ilk kez başarıyla tamamladıktan sonra, oyuncular etkinlik arayüzünden deneme ödüllerini alabilir."
  },
  Activity_71744_ActivityName = {
    Text = "Hayırsever Başrahip"
  },
  Activity_71744_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n \"Merhemlerin Piskoposu\" etkinliği süresince Koruyucular, Salvador'u içeren sistem tarafından önceden ayarlanmış takım dizilişini kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcı değiştirilemez. \n<Title:Etkinlik Ödülleri>\n Aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_71745_ActivityName = {
    Text = "Kırmızılı Madam"
  },
  Activity_71745_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Kırmızılı Madam\" etkinliği süresince Koruyucular, Sorel'i içeren sistem tarafından önceden ayarlanmış takımı kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarında Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödülü talep edilebilir."
  },
  Activity_71746_ActivityName = {
    Text = "Derinlerin Hanımefendisi"
  },
  Activity_71746_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Derinlerin Hanımefendisi\" etkinliği süresince Koruyucular, Murphy'yi içeren sistem tarafından önceden ayarlanmış takımı kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarında Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödülü talep edilebilir."
  },
  Activity_71747_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_71956_ActivityName = {
    Text = "Terfi Anma Hediyesi X"
  },
  Activity_71956_ActivityPlot = {
    Text = "Yol uzun uzadıya uzanıyor, Çözünme'nin karanlığına bürünmüş.\nGümüş Anahtar'ın ışığı hepimize yol gösterecek."
  },
  Activity_71957_ActivityName = {
    Text = "Terfi Anma Hediyesi IX"
  },
  Activity_71957_ActivityPlot = {
    Text = "Yol uzun uzadıya uzanıyor, Çözünme'nin karanlığına bürünmüş.\nGümüş Anahtar'ın ışığı hepimize yol gösterecek."
  },
  Activity_71982_ActivityName = {
    Text = "Ruh Rezonansı Hediyesi"
  },
  Activity_71982_ActivityPlot = {
    Text = "Müdürün ofisine varıyorsun, ancak odanın boş olduğunu keşfediyorsun. Görünüşe göre mektup sadece bir şakaymış.\nTam ayrılmak üzereyken, görüş alanının köşesinde zarif bir hediye kutusu ve üzerinde bir not fark ediyorsun — Sevgilime."
  },
  Activity_71983_ActivityName = {
    Text = "Kaderle Belirlenmiş Vahiy Hediyesi"
  },
  Activity_71983_ActivityPlot = {
    Text = "Sessiz odada bir tıklama sesi yankılanıyor. İncelemek için ileri adım attığında, açık pencere \"Davetsiz Misafir\"in çoktan gittiğini ortaya koyuyor.\nSıcak güneş ışığı masadaki fazladan bir hediye kutusunun üzerine düşüyor, zarif el yazısı gümüş bir ışıltıyla parlıyor — Kader Seni Sonsuza Dek Kutsasın."
  },
  Activity_72101_ActivityName = {
    Text = "Faz Tersine Çevirme"
  },
  Activity_72101_ActivityPlot = {
    Text = "Herkesin Kozmik Kartlar oynamasını istiyorum!\nBaşka bir zaman çizgisinden gelen bir ziyaretçi, yanlışlıkla Traphase uzamına adım attı ve burayı, eskiden olduğundan büsbütün farklı bir şeye dönüştürdü.\nBu uzamı bir kez daha geri çevirmek için, farklı zaman çizgilerinden gelen Koruyucular, aralarındaki en güçlünün kim olduğunu saptamalı ve bu ziyaretçiye meydan okumalı."
  },
  Activity_72101_ActivityTips = {
    Text = "<Title:Etkinlik Genel Bakış>\n1. Etkinlik süresince Koruyucular, “Traphase”e katılarak “Başarı Ödülleri”ndeki başarıları tamamlayabilir ve “Sihirli Palamutlar” elde edebilir.\n2. “Sihirli Palamutlar”, “Ters Dönüş Şöleni”nde etkinliğe özel avatar “Ters Dönüş: Evrensel Kart”, 10 etkinliğe özel İfade ve “Paramparça Kalıntı Nüsha”, “Yıldızsal Kalıntı Nüsha” vb. dâhil olmak üzere zengin ödüllerle takas edilebilir.\n3. Etkinlik süresince “Çoklu-Bağ: Ters Dönüş” ücretsiz olarak açık olacaktır!\n4. Etkinlik süresince, “Çoklu-Bağ: Ters Dönüş: Başka Bir Dünyadan Ziyaretçiler”i tamamlamış olan Koruyucular için, “Traphase”in savaş arka planı geçici olarak “Ters Dönüş: Şuur Uzamı” ile değiştirilecektir.\n\n<Title:Başarı Ödülleri>\n1. “Başarı Ödülleri”; “Uyanan” zafer başarılarını, “Kader Çarkı” zafer başarılarını, “Çete” zafer başarılarını ve kart oynama başarılarını içerir; Koruyucular başarıları tamamlayarak “Sihirli Palamutlar” alabilir.\n2. “Traphase”te, farklı mesleklerden Uyananlar kullanın; her 25 kart oynadığınızda 30 “Sihirli Palamut” kazanırsınız. Her mesleğin “kart oynama” başarısı en fazla 80 kez tamamlanabilir.\n3. “Uyanan” başarıları: Her “Uyanan”, “Traphase”te 1/3/6/10 zafer elde ettiğinde 10 “Sihirli Palamut” kazanabilir.\n4. “Kader Çarkı” başarıları: Her “Kader Çarkı”, “Traphase”te 1/3/6 zafer elde ettiğinde 10 “Sihirli Palamut” kazanabilir.\n5. “Çete” başarıları: Her “Çete”, “Traphase”te 1/3/6 zafer elde ettiğinde 10 “Sihirli Palamut” kazanabilir.\n6. Çekirdek temalar tarafından geçici olarak kilidi açılan “Uyananlar”, “Kader Çarkları” ve “Çeteler” etkinlik süresince zafer ve kart oynama sayımlarını normal şekilde biriktirir; ancak ilgili ödüller yalnızca karşılık gelen “Uyanan”, “Kader Çarkı”, “Çete” elde edildikten sonra talep edilebilir.\n\n<Title:Ters Dönüş Şöleni>\n1. Koruyucular “Sihirli Palamut” biriktirerek karşılık gelen ödülleri alabilir; 2.500 “Sihirli Palamut” biriktirmek tüm çekirdek ödülleri, 5.000 “Sihirli Palamut” biriktirmek ise tüm ödülleri almanızı sağlar!\n2. “Ters Dönüş: Başka Bir Dünyadan Ziyaretçiler” tamamlandıktan sonra, 100–900 “Sihirli Palamut” biriktirme ödülleri açılır; “Ters Dönüş: Sonsuzluğun Tersine Dönüş Anı” tamamlandıktan sonra ise 1.000–5.000 “Sihirli Palamut” biriktirme ödülleri açılır.\n\n<Title:Çoklu-Bağ>\n1. Etkinlik süresince “Çoklu-Bağ: Ters Dönüş” ücretsiz olarak açık olacaktır.\n2. Etkinlik süresince “Ters Dönüş: Mutlak İrade”nin kilidini açmak için 1.000 “Sihirli Palamut” biriktirilmesi gerekir.\n3. Etkinlik sonrasında, “Çoklu-Bağ: Ters Dönüş”ün Soruşturma ilerlemesi Sakla nacaktır. “Çoklu-Bağ: Ters Dönüş” etkinlik sırasında kilidi açılmamışsa, etkinlik sonrasında da 3 adet “Gerçeklik Sınırı” harcayarak kilidi açılabilir.\n4. Etkinlik sırasında olsun ya da olmasın, “Çoklu-Bağ: Ters Dönüş”ü tamamlamak “Çete: Mevlevihane Kapısı” kazandırır.\n\n<Title:Etkinlik Süresi>\nBu etkinlik yalnızca 18 Mart 9:00’dan 1 Nisan 9:00’a kadar (GMT+8) açık olacaktır. 1 Nisan 9:00’dan (GMT+8) sonra etkinlik sona erecektir. Lütfen etkinlik bitmeden önce “Ters Dönüş Şöleni”ndeki ödüllerinizi almayı unutmayın!"
  },
  Activity_72101_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_72101_UnlockConditionExplanation = {
    Text = "\"Soruşturma Operasyonu\" 3-2 · Normal tamamlandıktan sonra açılır"
  },
  Activity_73680_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_73680_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Doll: Cehennem\" aktive edebilir.\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_73681_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_73681_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Doll: Cehennem\", <BlueQuality:Aydınlanma 3> aktive edebilir"
  },
  Activity_73879_ActivityName = {
    Text = "Yıldızlar Yerinde: Tekrar"
  },
  Activity_73879_ActivityPlot = {
    Text = "Yıldızların Hizalanma saati yaklaşıyor, göğsündeki hareket davul sesi gibi hissediliyor.\nOnu yıllardır eziyet eden karanlık kabuslar, sayısız takipçinin gözyaşlarıyla son buluyor.\nOnun@1 karanlığından@2, yüce olan@3 dünyaya Gelişini gerçekleştiriyor."
  },
  Activity_73879_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Kutsal Embriyo Kuluçkası\" kullanılabilir."
  },
  Activity_73879_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince, Koruyucular sınırlı süreli oynanışlar olan \"Karanlık Rahim\" ve \"Başarı Ödülleri\" aracılığıyla üç tür \"Cenin\" toplayabilir. Bu \"Ceninler\", \"Kutsal Cenin Kuluçkası\"nda etkinliğe özel SR Kader Çarkı \"Buzulun Altında Uyuyan\", Saf Çekirdek, Lumen Çekirdeği, Bilge Parçaları, Taklit Buz Kristali ve daha fazlası dâhil çeşitli eşya ödülleriyle takas edilebilir.\n2. Etkinlik süresince, \"Başarı Ödülleri\"ndeki görevleri tamamlamak, etkinliğe özel avatar çerçevesi \"Gümüş Anahtar Adına: Murphy\", etkinliğe özel SR Kader Çarkı \"Buzulun Altında Uyuyan\" ve büyük miktarda \"Cenin\" kazandırır.\n\n<Title:Etkinlik Süresi>\n1. 10 Mart 9:00'dan 24 Mart 9:00'a kadar (GMT+8) tüm etkinlik içerikleri alınabilir.\n2. 24 Mart 9:00'dan 31 Mart 9:00'a kadar (GMT+8) yalnızca \"Kutsal Cenin Kuluçkası\" ve \"Başarı Ödülleri\" açık kalacak, diğer tüm içerikler sona erecek ve katılıma kapalı olacaktır.\n\n<Title:Karanlık Rahim>\n1. \"Karanlık Rahim\"de, her gün biri otomatik olarak açılan 7 aşama bulunur.\n2. Her meydan okuma 120 Menofin tüketir. Meydan okumaları başarıyla tamamlamak, etkinlik parası olan \"Cehalet Cenini\", \"Arzusuzluk Cenini\" ve \"Doymazlık Cenini\" ile ödüllendirir.\n3. Bir aşama temizlendiğinde, o aşama için \"Yeniden Canlandır\" işlevi açılır. Not: \"Yeniden Canlandır\" işlevini kullanarak Afinite kazanamazsınız.\n4. Aşamaları daha kolay temizlemek için Mezun yardımı kullanabilirsiniz.\n5. Herhangi bir zorlukta bir aşamayı temizledikten sonra, o aşamanın Delilik Zorluğu açılır. Delilik Zorluğunu ilk kez tamamlamak, bol miktarda etkinlik parası kazandırır.\n6. Lütfen dikkat: Delilik Zorluğu meydan okumaları Menofin tüketmez, yeniden canlandırılamaz ve ilk tamamlamadan sonraki tekrar meydan okumalar ek etkinlik parası vermez.\n\n<Title:Cenin Bonusları>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan Koruyucular (kadroya alınmaları gerekmez), \"Karanlık Rahim\"de (yeniden canlandırma dâhil) aşama ödülleri olarak \"Cehalet Cenini\", \"Arzusuzluk Cenini\" ve \"Doymazlık Cenini\"nin düşme oranını artırabilir. Belirli bonuslar şunlardır:\nUyanan \"Murphy\": Aydınlanma 0/1/2/3 veya üzeri seviyelerde bonuslar %20/%30/%40/%50\nSSR Kader Çarkı \"Gizli Doğum\": Yığın 0/1/2/3 veya üzeri seviyelerde bonuslar %20/%30/%40/%50\nSR Kader Çarkı \"Buzulun Altında Uyuyan\": Yığın 0/1/2/3 veya üzeri seviyelerde bonuslar %20/%30/%40/%50\n2. Farklı Uyananlar veya Kader Çarkları için bonuslar birikimlidir.\n3. Özellikle, Delilik Zorluğundaki ilk meydan okuma için verilen ödül \"Cenin Bonusları\"ndan etkilenmez.\n\n<Title:Kutsal Cenin Kuluçkası>\n1. \"Kutsal Cenin Kuluçkası\" yalnızca 10 Mart 9:00 ile 31 Mart 9:00 (GMT+8) arasında açıktır.\n2. 31 Mart 9:00'dan (GMT+8) sonra, kullanılmamış tüm \"Ceninler\" her bir cenin için \"Gül Senedi Kuponu *40\" oranıyla geri alınacaktır. Lütfen, Koruyucular, postanızı kontrol etmeyi unutmayın."
  },
  Activity_73879_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_74213_ActivityName = {
    Text = "Yankılanan Hac: Astral Saltanat I"
  },
  Activity_74213_ActivityPlot = {
    Text = "Yanılsama Hafıza mühürlenip arşivlendi, geçmişe kaydedilen bir yolculuk. Anımsama anlarında, saygılı Haracınızı sunmayı unutmayın."
  },
  Activity_74340_ActivityName = {Text = "Sıram"},
  Activity_74364_ActivityName = {
    Text = "Dedektif El Kitabı: Tekrar"
  },
  Activity_74364_ActivityPlot = {
    Text = "Bu sayfaların içinde, bir ömrü gizem çözmekle geçmiş usta bir Dedektifin katılaşmış kavrayışları yatıyor.\nMütevazı Müfettişlerin sezgisini tutuşturup zekâsını bilemek için tasarlanmış bir rehber."
  },
  Activity_74364_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Şans Kulübü\" Alınabilir."
  },
  Activity_74364_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince, Muhafızlar süreli oynanış \"Mehtap masalları\" ve \"Başarı Ödülleri\" aracılığıyla etkinlik parası \"Kazanan Fişler\" toplayabilir. \"Kazanan Fişler\", \"Şans Kulübü\"nde etkinliğe özel SR Kader Çarkı \"Kader Ruleti\", Saf Çekirdek, Lümen Çekirdeği, Eter Taşı Kırıntıları ve Taklit Kristali vb. dâhil zengin ödüllerle takas edilebilir.\n2. Etkinlik süresince, \"Başarı Ödülleri\"ndeki görevleri tamamlamak, etkinliğe özel avatar \"Gümüş Anahtar Adına: Ryker\", etkinliğe özel SR Kader Çarkı \"Kader Ruleti\", Gümüş ve yüklü miktarda etkinlik parası \"Kazanan Fişler\" kazandırır.\n3. Etkinlik süresince, \"Özel Görev Kaydı: İyi Avlar!\" süreli ücretsiz erişim ile açılır.\n\n<Title:Etkinlik Süresi>\n1. 16 Haziran 09:00 - 30 Haziran 09:00 (GMT+8): Tüm etkinlik içeriklerine erişilebilir.\n2. 30 Haziran 09:00 - 7 Temmuz 09:00 (GMT+8): Yalnızca \"Şans Kulübü\" ve \"Başarı Ödülleri\" erişilebilir durumda kalır; diğer içerikler sona erer ve artık erişilemez.\n\n<Title:Mehtap masalları>\n1. \"Mehtap masalları\" 9 bölümden oluşur, her gün bunlardan biri kendiliğinden açılır.\n2. Her meydan okuma 120 Menofin puanı tüketir ve farklı bölümlere meydan okumak, farklı malzeme düşüşlerinin yanı sıra etkinlik parası \"Kazanan Fişler\" verir.\n3. Bu etkinliğin bölümleri, savaş odaklı malzeme bölümleridir ve temizlendikten sonra \"yeniden oynanabilir\"! Her \"yeniden oynama\" 120 Menofin puanı tüketir.\n4. Not: \"Yeniden oynama\" özelliği kullanıldığında Afinite kazanılmaz.\n\n<Title:Fiş Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan Muhafızlar (kadroda olmaları gerekmez), \"Mehtap masalları\" bölüm görev ödüllerinde (yeniden oynamalar dâhil) ek \"Kazanan Fişler\" düşüşü elde eder; ayrıntılar şöyledir:\nUyanan \"Ryker\": Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSSR Kader Çarkı \"Şans Saati\": Yığılma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSR Kader Çarkı \"Kader Ruleti\": Yığılma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n2. Farklı Uyananların veya Kader Çarklarının \"Fiş Bonusu\" kümülatif olarak hesaplanır.\n3. Özellikle, \"Delilik\" zorluğunun ilk meydan okuma ödülleri \"Fiş Bonusu\"ndan etkilenmez.\n\n<Title:Şans Kulübü>\n1. \"Şans Kulübü\" yalnızca 16 Haziran 09:00 - 7 Temmuz 09:00 (GMT+8) arasında açıktır.\n2. 7 Temmuz 09:00'dan (GMT+8) sonra, takas edilmemiş kalan tüm \"Kazanan Fişler\", her takas için \"Gül Senedi *40\" oranıyla geri dönüştürülecektir. Muhafızların posta kutularını kontrol etmeleri tavsiye edilir.\n\n<Title:Özel Görev Kaydı>\n1. \"Özel Görev Kaydı: İyi Avlar!\"da, Muhafızlar, hikâye ön ayarlı \"Ryker\"ı da içeren özel bir takımla meydan okumaya çıkar.\n2. \"Özel Görev Kaydı: İyi Avlar!\"ı temizlemek, yepyeni Çete \"Bir Silahın Çığlığı\"nı kazandırır."
  },
  Activity_74364_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_74365_ActivityName = {
    Text = "İyi Avlar!"
  },
  Activity_76217_ActivityName = {
    Text = "Ötedünya Arşivleri"
  },
  Activity_76217_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Ötedünya Arşivleri'nde ödüller almak için görevleri tamamlayın\n2. Ötedünya Arşivleri kalıcı olarak erişilebilir kalır\n3. Görev tamamlandığında ekstra ödüller kazanmak için Premium Arşivleri açın\nNot: Etkinleştirilen Premium Arşivler yalnızca bu Arşiv etkinliğinde geçerlidir."
  },
  Activity_76218_ActivityName = {
    Text = "Varış Arşivleri"
  },
  Activity_76218_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Varış Arşivleri'nde ödüller almak için görevleri tamamlayın\n2. Varış Arşivleri kalıcı olarak erişilebilir kalır\n3. Görev tamamlandığında ekstra ödüller kazanmak için Premium Arşivleri açın\nNot: Etkinleştirilen Premium Arşivler yalnızca bu Arşiv etkinliğinde geçerlidir."
  },
  Activity_77970_ActivityName = {
    Text = "Divus: Beyaz Gece"
  },
  Activity_77970_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Divus: Beyaz Gece\" etkinliği süresince Koruyucular, Pollux'u içeren sistem tarafından önceden ayarlanmış takımı kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarında Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödülü talep edilebilir."
  },
  Activity_77972_ActivityName = {
    Text = "Hipnotik Shaggai"
  },
  Activity_77972_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n \"Hipnotik Shaggai\" etkinliği süresince Koruyucular, Clementine'i içeren sistem tarafından önceden ayarlanmış takım dizilişlerini kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\n Etkinlik aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcı değiştirilemez.\n<Title:Etkinlik Ödülleri>\n Bir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_77974_ActivityName = {
    Text = "Deniz Işıltısı"
  },
  Activity_77974_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Deniz Işıltısı\" etkinliği süresince Koruyucular, Corposant'ı içeren sistem tarafından önceden ayarlanmış takımları kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_77977_ActivityName = {
    Text = "Peri Pamuk Prenses"
  },
  Activity_77977_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Peri Pamuk Prenses\" etkinliği süresince Koruyucular, \"Caraboo\"yu içeren sistem tarafından önceden belirlenmiş kadroları kullanarak belirlenen bölümleri sınırsız sayıda deneyimleyebilir.\n Etkinlik bölümlerini deneyimlerken kadrodaki Uyandırıcılar ayarlanamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez tamamladıktan sonra etkinlik arayüzünde deneme ödüllerini talep edebilirsiniz."
  },
  Activity_77979_ActivityName = {
    Text = "Yaşayan Alev"
  },
  Activity_77979_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Yaşayan Alev\" etkinliği süresince Koruyucular, Kathigu-Ra'yı içeren önceden ayarlanmış takımları kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nAşama görevini ilk kez tamamladığınızda, etkinlik arayüzünden deneme ödülleri talep edilebilir."
  },
  Activity_77980_ActivityName = {
    Text = "Tela Perpetua"
  },
  Activity_77980_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Tela Perpetua\" etkinliği süresince Koruyucular, Arachne içeren sistem tarafından önceden ayarlanmış takımları kullanarak belirlenen seviyeleri sınırsız sayıda deneyimleyebilir.\nEtkinlik seviyelerini deneyimlerken, takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nSeviye meydan okumasını ilk kez tamamladıktan sonra, etkinlik arayüzünde deneme ödüllerini talep edebilirsiniz."
  },
  Activity_77984_ActivityName = {Text = "Ressam"},
  Activity_77984_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n \"Ressam\" etkinliği süresince Koruyucular, Pickman'i içeren sistem tarafından önceden ayarlanmış takım dizilişlerini kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\n Etkinlik aşamalarını deneyimlerken Takım Dizilişinizdeki Uyandırıcıları değiştiremezsiniz.\n<Title:Etkinlik Ödülleri>\n Aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_78501_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_78501_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Nephren-Ka\" aktive edebilir\n<BlueQuality:Ruhsal Dalgalanma +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_78502_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_78502_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Arachne\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_78503_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_78503_ActivityPlot = {
    Text = "Satın alma sonrasında \"Corposant\", <BlueQuality:Aydınlanma 3> özelliğini etkinleştirebilir"
  },
  Activity_78505_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_78505_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Clementine\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_78506_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_78506_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Nephren-Ka\" <BlueQuality:Aydınlanma 3> aktive edebilir"
  },
  Activity_78507_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_78507_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Akbaba\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_78508_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_78508_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Aforgomon\" <BlueQuality:Aydınlanma 3> aktive edebilir"
  },
  Activity_78509_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_78509_ActivityPlot = {
    Text = "Satın alma sonrasında \"Pollux\", <BlueQuality:Aydınlanma 3> özelliğini etkinleştirebilir"
  },
  Activity_78511_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_78511_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Caraboo\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_78513_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_78513_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Arachne\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_78514_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_78514_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Pickman\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_78515_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_78515_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Pickman\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_78516_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_78516_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Clementine\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_78517_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_78517_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Corposant\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_78518_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_78518_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Vulture\" aktive edebilir\n<BlueQuality:Ruhsal Dalgalanma +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_78519_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_78519_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Shantak\" aktive edebilir\n<BlueQuality:Ruhsal Dalgalanma +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_78521_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_78521_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Pollux\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_78523_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_78523_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Aforgomon\" aktive edebilir\n<BlueQuality:Ruhsal Dalgalanma +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_78524_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_78524_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Rhan-Tegoth\" aktive edebilir\n<BlueQuality:Ruhsal Dalgalanma +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_78525_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_78525_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Castor\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_78526_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_78526_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Kathigu-Ra\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_78531_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_78531_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Shantak\" <BlueQuality:Aydınlanma 3> aktive edebilir"
  },
  Activity_78532_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_78532_ActivityPlot = {
    Text = "Satın alma sonrasında \"Caraboo\", <BlueQuality:Aydınlanma 3> özelliğini etkinleştirebilir"
  },
  Activity_78533_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_78533_ActivityPlot = {
    Text = "Satın alımdan sonra, \"Castor\" <BlueQuality:Aydınlanma 3> etkinleştirebilir"
  },
  Activity_78534_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_78534_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Rhan-Tegoth\" <BlueQuality:Aydınlanma 3> aktive edebilir"
  },
  Activity_78536_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_78536_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Kathigu-Ra\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_78651_ActivityName = {
    Text = "Dingin Bölünme"
  },
  Activity_78652_ActivityName = {
    Text = "Çoklu Şifa: Tekrar"
  },
  Activity_78652_ActivityPlot = {
    Text = "Histeri. Adına istersen mania de, istersen zihnin paramparça oluşu; bu çağda bu teşhis, bir idam fermanıdır. Neyse ki Mythag’ın bilim insanları ve Müfettişleri, kendilerine özgü bir delilikle maluldür: Bu dehşeti alt etmeye kararlıdırlar."
  },
  Activity_78652_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Ego Tahlili\" alınabilir."
  },
  Activity_78652_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince, Gözetmenler “Hafıza Kodlaması”, “Sınır Deposu” ve “Başarı Ödülleri” gibi süreli etkinlikler aracılığıyla “Hafıza Bulmacası” adlı etkinlik parasını toplayabilir. “Hafıza Bulmacası”, “Persona Analizi”nde, etkinliğe özel SR Kader Çarkı “Gümüş Morina’nın Kararlılığı”, Saf Çekirdek ve Lümen Çekirdeği de dâhil olmak üzere çeşitli eşyaları satın almak için kullanılabilir.\n2. Etkinlik süresince, “Özel Kayıt: Sakin Bölünme” süreli ücretsiz erişime Açılabilir. Etkinlik Başarımlarını tamamlamak, ayrıca size etkinliğe özel “Gümüş Anahtar Adına: ‘24’” avatarını kazandırır!\n\n<Title:Etkinlik Süresi>\n1. 21 Nisan, 9:00 - 5 Mayıs, 9:00 (GMT+8), tüm etkinlik faaliyetleri Alınabilir.\n2. 5 Mayıs, 9:00 - 12 Mayıs, 9:00 (GMT+8), yalnızca “Persona Analizi” ve Başarı Ödülleri Alınabilir.\n\n<Title:Hafıza Kodlaması>\n1. “Hafıza Kodlaması” 5 aşamadan oluşur; her 2 günde bir aşama otomatik olarak açılır.\n2. Her meydan okuma 120 Menophin tüketir ve başarılı meydan okumalar etkinlik parasını kazandırır.\n3. Bir aşamayı tamamladıktan sonra, o aşamanın “Tekrar Oynat” işlevi açılır. Not: “Tekrar Oynat” işlevini kullanmak Yakınlık kazandırmaz.\n4. Mezun yardımı ve “Rezonans: Ayrışma Belirtisi”ni kullanarak meydan okumaları hafifletebilirsiniz.\n\n<Title:Akli İkramiyeler>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan (savaşa sokulmaları gerekmez) Gözetmenler, “Hafıza Kodlaması” aşama ödüllerinde “Hafıza Bulmacası” için ek düşüş bonusları kazanabilir. Ayrıntılı bonuslar şöyledir:\nUyanan “24”: Aydınlanma 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus.\nSSR Kader Çarkı “Sapkın Yutma”: Yığın 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus.\nSR Kader Çarkı “Gümüş Morina’nın Kararlılığı”: Yığın 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus.\n2. Farklı Uyananlar veya Kader Çarklarından gelen Akli İkramiyeler, toplamsal olarak birikir.\n3. Özellikle, Delilik Zorluğu’ndaki ilk-tamamlama meydan okuma ödülleri Akli İkramiyelerden etkilenmez.\n\n<Title:Rezonans: Ayrışma Belirtisi>\n1. Gözetmenler, etkinlik başarımlarını tamamlayarak “Bölünme Kalbi” elde edebilir.\n2. “Bölünme Kalbi” tüketerek “Rezonans: Ayrışma Belirtisi”ni etkinleştirmek aşağıdaki bonusları sağlar:\n(1) Gözetmeni “Hafıza Kodlaması” ve “Özel Kayıt: Sakin Bölünme” etkinliklerinde güçlendirir, meydan okumaları kolaylaştırır.\n(2) “Hafıza Kodlaması” meydan okumalarını tamamladıktan sonra elde edilen ödülleri artırır.\n(3) “Sınır Deposu” adlı etkinlik faaliyetini etkinleştirir.\n\n<Title:Sınır Deposu>\n1. “Teşhis: Parçalanmış Benlik” rezonansını etkinleştirdikten sonra, saatte otomatik olarak 60 “Hafıza Bulmacası α” kazanılır; en fazla 25 saat biriktirilebilir.\n2. “Bilişsel Rezonans” rezonansını etkinleştirdikten sonra, saatte otomatik olarak 30 “Hafıza Bulmacası β” kazanılır; en fazla 25 saat biriktirilebilir.\n\n<Title:Özel Kayıt>\n1. Etkinlik süresince, “Özel Kayıt: Sakin Bölünme” ücretsiz olarak Açılabilir.\n2. Etkinlik sonrasında, “Özel Kayıt: Sakin Bölünme” Soruşturmalarındaki ilerleme korunur ve etkinlik dönemi sırasında tamamlanmamış Soruşturmaları tamamlamak, etkinlik dönemiyle tutarlı ödüller kazandırır. “Özel Kayıt: Sakin Bölünme” etkinlik süresince Açılmadıysa, etkinlik sonrasında da “Gerçeklik Sınırı” *7 tüketilerek Açılabilir.\n3. Etkinlik döneminden bağımsız olarak, “Özel Kayıt: Sakin Bölünme”yi tamamlamak “Çete: Onun Her Şeyi” ödülünü verir.\n\n<Title:Kopya Telafisi>\n1. Bu tekrar eden etkinlik sırasında daha önce “Özel Kayıt: Sakin Bölünme”yi Açmış olan Gözetmenler, telafi olarak “Hafıza Bulmacası α” *700 alacaktır.\n2. Daha önce etkinliğe özel “Gümüş Anahtar Adına: ‘24’” avatarını elde etmiş olan Gözetmenlerin, onu yeniden aldıklarında avatarları otomatik olarak 1 “Biçimsiz Olanın Davetiyesi”ne dönüştürülür.\n3. Daha önce etkinleştirme rezonansı malzemesi “Bölünme Kalbi”ni elde etmiş olan Gözetmenlerin, ellerinde kalan her fazla “Bölünme Kalbi” otomatik olarak “Gül Senedi” *5000’e dönüştürülür."
  },
  Activity_78652_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_78722_ActivityName = {
    Text = "Böceklerin Şarkıları: Sınırlı Ön Sipariş"
  },
  Activity_78722_ActivityTips = {
    Text = "<Title:Karanlık Gelgit Böcek Şarkısı: Sınırlı Ön Sipariş>\nBu sınırlı ön sipariş etkinliği 8 paket içerir. İlk paket ücretsiz olarak talep edilebilirken, 2. ile 8. paketlerin alınabilmesi için \"Karanlık Gelgit Böcek Şarkısı: Sınırlı Ön Sipariş\" satın alınması gerekmektedir.\n\"Karanlık Gelgit Böcek Şarkısı: Sınırlı Ön Sipariş\" satın alındıktan sonra 2. paket ödülünü hemen talep edebilirsiniz; sonraki paketler belirli bir süre bekledikten sonra talep edilmelidir.\n\"Karanlık Gelgit Böcek Şarkısı: Sınırlı Ön Sipariş\" satın alma süresi sınırlıdır ve son tarihten sonra artık mevcut olmayacaktır. Lütfen Koruyucu olarak 7 Nisan saat 9:00'dan önce satın almayı unutmayın."
  },
  Activity_78751_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_78751_ActivityPlot = {
    Text = "Satın alma sonrasında \"Tulu: Tanrı Kral\", <BlueQuality:Aydınlanma 3> özelliğini etkinleştirebilir"
  },
  Activity_78752_ActivityName = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_78752_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Köken: Egemenlik\" etkinliği süresince Koruyucular, Köken: Egemenlik'i içeren sistem tarafından önceden belirlenmiş ekipleri kullanarak belirlenen seviyeleri sınırsız sayıda deneyimleyebilir.\nEtkinlik seviyelerini deneyimlerken ekip kadrosundaki Uyandırıcılar üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nSeviye meydan okumasını ilk kez tamamladıktan sonra etkinlik arayüzünde demo ödüllerini talep edebilirsiniz."
  },
  Activity_78753_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_78753_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Tulu: Tanrı Kral\" aktive edebilir\n<BlueQuality:Ruhsal Dalgalanma +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_78776_ActivityName = {
    Text = "Lemurya Deipara'sı"
  },
  Activity_78776_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Lemurya Deipara'sı\" etkinliği süresince Koruyucular, \"Murphy: Sahte Doğumlu\"yu içeren sistem tarafından önceden ayarlanmış takım dizilişlerini kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\n Etkinlik aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nAşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_78777_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_78777_ActivityPlot = {
    Text = "Satın alma sonrasında \"Murphy: Sahte Doğumlu\", <BlueQuality:Aydınlanma 3> özelliğini etkinleştirebilir"
  },
  Activity_78778_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_78778_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Murphy: Sahte Doğumlu\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_78790_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_78791_ActivityName = {
    Text = "Karlar Eridiğinde: Tekrar"
  },
  Activity_78791_ActivityPlot = {
    Text = "Elworth'taki kar asla erimez, tıpkı onun nefreti gibi.\nGeleceğin ve geçmişin elleri birbirine kenetlendiğinde, savaşçı kılıcını kaldıracak ve intikam için kadere karşı hücum edecektir.\nKara dalgalarla yüzleştiğinde, sen onun sancağısın."
  },
  Activity_78791_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Dağın Dev Çenesi\" kullanılabilir."
  },
  Activity_78791_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, sınırlı süreli \"Canavar Hırsı\" ve \"Başarı Ödülleri\" oynanışları aracılığıyla üç tür \"Tomurcuk\" toplayabilir. Bu \"Tomurcuklar\", \"Dağ Geçidi\"nde etkinliğe özel SR Kader Çarkı \"Karlı Dağ Eriyince\", Saf Çekirdek, Lümen Çekirdeği, Bilge Taşı Parçaları ve Taklit Kristali de dâhil olmak üzere eşya ödülleriyle takas edilebilir.\n2. Etkinlik süresince \"Özel Sevk Kaydı: Elworth'ün Geri Döneni\" ücretsiz olarak açılacaktır.\n\n<Title:Etkinlik Süresi>\n1. 19 Mayıs 9:00 - 2 Haziran 9:00 (GMT+8) tarihleri arasında tüm etkinlik içeriklerine katılım mümkündür.\n2. 2 Haziran 9:00 - 9 Haziran 9:00 (GMT+8) tarihleri arasında yalnızca \"Dağ Geçidi\" ve \"Başarı Ödülleri\" kalır, diğer içerikler sona erer ve katılım mümkün olmaz.\n\n<Title:Canavar Hırsı>\n1. \"Canavar Hırsı\" 5 seviyeden oluşur, her 2 günde bir seviye otomatik olarak açılır.\n2. Her meydan okuma 120 Menophin tüketir ve başarıyla tamamlanan meydan okumalar size etkinlik para birimi \"Donmuş Tomurcuk\", \"Gümüş Kırağı Tomurcuğu\" ve \"Güneş Işığı Tomurcuğu\" kazandırır.\n3. Seviye temizlendikten sonra o seviye için \"Tekrar Oynat\" işlevi açılır. Not: \"Tekrar Oynat\" işlevini kullanmak Yakınlık kazandırmaz.\n4. Seviyeleri daha kolay temizlemek için Mezun yardımlarını ve \"Rezonans: Dağı Yiyip Bitir\"i kullanabilirsiniz.\n5. Açılıştan sonraki ikinci günde, seviyenin Delilik zorluğu açılır. Delilik zorluğunu ilk kez tamamlamak, hatırı sayılır miktarda etkinlik para birimi ödülü kazandırır.\n6. Not: Delilik zorluğu meydan okumaları Menophin tüketmez, tekrar oynatılamaz ve ilk tamamlamadan sonraki tekrar denemeler etkinlik para birimi ödülü vermez.\n\n<Title:Tomurcuk Bonusu>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olan (sahaya sürülmeleri gerekmez) Muhafızlar, \"Canavar Hırsı\" seviye ödüllerinde (tekrar oynatma dâhil) \"Donmuş Tomurcuk\", \"Gümüş Kırağı Tomurcuğu\" ve \"Güneş Işığı Tomurcuğu\" için ek düşüş bonusları elde edebilir; ayrıntılar şöyledir:\nUyanan \"Helot: Catena\": Aydınlanma 0/1/2/3 veya üzeri, bonus %20/%30/%40/%50\nSSR Kader Çarkı \"Sunk into Crimson\": Yığın konumu 0/1/2/3 veya üzeri, bonus %20/%30/%40/%50\nSR Kader Çarkı \"Karlı Dağ Eriyince\": Yığın konumu 0/1/2/3 veya üzeri, bonus %20/%30/%40/%50\n2. Farklı Uyananların veya Kader Çarklarının \"Tomurcuk Bonusu\" birikimli şekilde hesaplanır.\n3. Özellikle, Delilik zorluğunun ilk meydan okuma ödülü \"Tomurcuk Bonusu\"ndan etkilenmez.\n\n<Title:Rezonans: Dağı Yiyip Bitir>\n1. Muhafızlar, etkinlik başarımlarını tamamlayarak \"Yiyip Bitirme Kalbi\" elde edebilir.\n2. \"Yiyip Bitirme Kalbi\"ni tüketerek \"Rezonans: Dağı Yiyip Bitir\"i etkinleştirmek, Muhafızları \"Canavar Hırsı\" oynanışında güçlendirerek meydan okumaları kolaylaştırır.\n\n<Title:Dağ Geçidi>\n1. \"Dağ Geçidi\"nde üç takas dükkânı bulunur, açılış saatleri şöyledir:\n\"Yiyip Bitirmenin İştahı\" 19 Mayıs 9:00'da açılır.\n\"İntikamın Savaş İradesi\" 21 Mayıs 9:00'da açılır.\n\"Yeniden Doğuş Umudu\" 23 Mayıs 9:00'da açılır.\n2. Her takas 750 \"Donmuş Tomurcuk\"/\"Gümüş Kırağı Tomurcuğu\"/\"Güneş Işığı Tomurcuğu\" tüketir ve takas dükkânından rastgele beş eşya ödülü verir.\n3. Her takas dükkânındaki eşya ödülleri \"Özel Eşyalar\" ve \"Sıradan Eşyalar\" olarak ayrılır. Sıfırlama sırasında, özel eşyaların kalan miktarı üst sınıra kadar sıfırlanabilir. Özel kurallar şöyledir:\n(1) İlk 2 sıfırlama: \"Özel Eşyalar\"ın kalan miktarı kalmadığında, Muhafızlar sıfırlamayı seçebilir. Sıfırlama sonrasında hem \"Özel Eşyalar\" hem de \"Sıradan Eşyalar\"ın kalan miktarı üst sınıra döner; ya da takasa devam etmeyi seçebilirler, bu durumda \"Sıradan Eşyalar\"ın da kalan miktarı kalmadığında, devam edebilmek için sıfırlama zorunlu hâle gelir.\n(2) 3. sıfırlamadan itibaren: Yalnızca \"Sıradan Eşyalar\"ın kalan miktarı kalmadığında sıfırlama yapılabilir. Sıfırlama, \"Sıradan Eşyalar\"ın kalan miktarını üst sınıra döndürür, \"Özel Eşyalar\" ise artık sıfırlanmaz.\n4. 9 Haziran 9:00 (GMT+8) sonrasında, takas edilmemiş \"Tomurcuklar\" her biri için \"Gül Senedi*40\" oranıyla geri alınacaktır. Lütfen postalarınızı dikkatle kontrol edin.\n\n<Title:Özel Sevk Kaydı>\n1. Etkinlik süresince \"Özel Sevk Kaydı: Elworth'ün Geri Döneni\" ücretsiz olarak açık olacaktır. \"Özel Sevk Kaydı: Elworth'ün Geri Döneni\"ni temizlemek, yalnızca etkinlik süresince mevcut olan başarı ödüllerinde etkinliğe özel SR Kader Çarkı \"Karlı Dağ Eriyince\"yi kazandırır. Etkinlik sonrasında tamamlanamaz ve talep edilemez.\n2. Etkinlik sonrasında, \"Özel Sevk Kaydı: Elworth'ün Geri Döneni\"nin soruşturma ilerlemesi korunur. Etkinlik sırasında açılmamışsa, etkinlikten sonra da \"Gerçeklik Sınırı\"*7 tüketilerek açılabilir.\n3. Etkinlik döneminden bağımsız olarak, \"Özel Sevk Kaydı: Elworth'ün Geri Döneni\"ni temizlemek \"Çete: Dağların Uyanışı\"nı kazandırır."
  },
  Activity_78791_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_79851_ActivityName = {
    Text = "Yeni Başlayan Özel Teklifi"
  },
  Activity_79851_ActivityPlot = {
    Text = "Gümüş parıltı, her Yeniden Doğuş Koruyucusunun yolculuğuna içten Kutsama bahşeder. Gümüş Anahtar yolunuzu aydınlatsın.\n*Satın aldıktan sonra \"Malzemeler - Sarf Malzemeleri\" bölümünde kullanılabilir."
  },
  Activity_80163_ActivityName = {
    Text = "Disosiyatif Hasta: Ultra"
  },
  Activity_80163_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Disosiyatif Hasta: Ultra\" etkinliği süresince Koruyucular, \"24\"ü içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_80164_ActivityName = {
    Text = "Disosiyatif Hasta: Caro"
  },
  Activity_80164_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Disosiyatif Hasta: Caro\" etkinliği süresince Koruyucular, \"24\"ü içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_80165_ActivityName = {
    Text = "Disosiyatif Hasta: Aequor"
  },
  Activity_80165_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Disosiyatif Hasta: Aequor\" etkinliği süresince Koruyucular, \"24\"ü içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini oynarken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_80166_ActivityName = {
    Text = "Disosiyatif Hasta: Kaos"
  },
  Activity_80166_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Disosiyatif Hasta: Kaos\" etkinliği süresince Koruyucular, \"24\"ü içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini oynarken takım kadrosundaki Uyandırıcıda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra etkinlik arayüzünden demo ödüllerini talep edebilirsiniz."
  },
  Activity_80167_ActivityName = {
    Text = "Ruh Biçicisi"
  },
  Activity_80167_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Ruh Biçicisi\" etkinliği süresince Koruyucular, Helot-catena'yı içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden demo ödüllerini talep edebilir."
  },
  Activity_80311_ActivityName = {
    Text = "Yankılanan Hac: Astral Saltanat II"
  },
  Activity_80311_ActivityPlot = {
    Text = "Yanılsama Hafıza mühürlenip arşivlendi, geçmişe kaydedilen bir yolculuk. Anımsama anlarında, saygılı Haracınızı sunmayı unutmayın."
  },
  Activity_80312_ActivityName = {
    Text = "Sanatoryum Arşivleri"
  },
  Activity_80312_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Sanatoryum Arşivleri'nde ödüller almak için görevleri tamamlayın\n2. Sanatoryum Arşivleri kalıcı olarak erişilebilir kalır\n3. Görev tamamlandığında ekstra ödüller kazanmak için Premium Arşivleri açın\nNot: Etkinleştirilen Premium Arşivler yalnızca bu Arşiv etkinliğinde geçerlidir."
  },
  Activity_81019_ActivityName = {
    Text = "Süpürge ve Harika"
  },
  Activity_81019_ActivityPlot = {
    Text = "Rüya gibi Kadath'ta süzülerek efendisi için ortalığı temizleyen kim? \nKaren~ Karen! \nÇözünme'yi temizle~ Rüya'yı havalandır~ Boyut'u dezenfekte et~ her şeyi tertemiz yap~ \nSonuçta temizlik konusunda ben, Karen, bir profesyonelim! \nEfendim de denemek ister mi? Karen, temizlik hakkında her şeyi efendisine çekinmeden öğretecek!"
  },
  Activity_81019_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Koruyucular \"Temizlik İlerlemesi\"ne katılabilir ve \"Temizlik Araçları\" kazanabilir.\n2. Belirli miktarda \"Temizlik Araçları\" biriktirdikten sonra, \"Toz Temizleme Ödeneği\" bölümünden etkinliğe özel avatar \"Temizlik Ustası\", Gümüş, Saf Çekirdek ve Bilgelik Taşı Parçaları gibi zengin ödüller talep edebilirsiniz.\n\n<Title:Temizlik İlerlemesi>\n1. \"Temizlik İlerlemesi\" birden fazla farklı türde temizlik görevi içerir ve Koruyucular temizlik görevlerini tamamlayarak \"Temizlik Araçları\" kazanabilir. Her gün tüm temizlik görev türlerini tamamlamak için ekstra bir ödül de bulunmaktadır!\n2. Etkinlik süresince, her temizlik görevinin ilk başarılı tamamlanmasında gizli hikaye dizileri oynatılacaktır.\n3. \"Temizlik İlerlemesi\" etkinlik süresince her gün saat 9:00'da (GMT+8) sıfırlanacaktır.\n\n<Title:Toz Temizleme Ödeneği>\n1. Koruyucular \"Temizlik Araçları\" biriktirerek ilgili ödülleri talep edebilir. Her 1000 \"Temizlik Araçları\" biriktirildiğinde önemli envanter ödülleri talep edilebilir ve 10000 \"Temizlik Araçları\" biriktirmek, Temizlik Yolculuğu'na özel \"Temizlik Ustası\" avatarını kazandırır.\n\n<Title:Karen'ın Minnettarlığı>\nEtkinlik süresince, \"Karen'ın Minnettarlığı\" bölümünde giriş yaparak Karen'ın Koruyucular için hazırladığı hediyeleri alabilirsiniz!\n\n<Title:Etkinlik Süresi>\nBu etkinlik yalnızca 28 Nisan saat 9:00'dan 12 Mayıs saat 9:00'a kadar (GMT+8) açıktır. 12 Mayıs saat 9:00'dan (GMT+8) sonra etkinlik sona erecektir. Tüm Koruyucuların \"Toz Temizleme Ödeneği\" bölümündeki ödülleri talep etmeyi unutmaması rica olunur!"
  },
  Activity_81019_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_81178_ActivityName = {
    Text = "Fırtınanın Altında Salınış"
  },
  Activity_81178_ActivityPlot = {
    Text = "Yağmur gri gökyüzünden şiddetle yağıyor, denizi çatırdayan bir sesle sıçratıyor.\nAcımasız şimşekler özgürce kükreyerek, denizin yüzeyinin altındaki sınırsız dehşetin gelişini müjdeliyor.\nGörkemli Nautilus, küçük bir çocuk gibi güçsüzce sallanıyor, kabaran dalgaların arasında titreyerek.\nKimse kaderlerinin nasıl şekilleneceğini bilmiyor, tıpkı öngörülemeyen deniz gazabını gösterdiğinde, insanların ne kadar önemsiz olduklarını fark etmeleri gibi."
  },
  Activity_81178_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi, şu anda yalnızca \"Mürettebatın Hazinesi\"ne katılabilirsiniz"
  },
  Activity_81178_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\nEtkinlik süresince Muhafızlar, sınırlı süreli “Derin Denizde Kayıp” ve “Başarı Ödülleri” oynanışları aracılığıyla “Sinyal Bayrakları” adlı etkinlik para birimini toplayabilir. Sinyal Bayrakları, “Mürettebatın Hazineleri”nde etkinliğe özel SR Kader Çarkı “Deniz Kılavuzu”, Lümen Çekirdeği, Saf Çekirdek, Eter Taşı Kırıntıları, Taklit Kristalleri vb. ödüllerle takas edilebilir.\n\n<Title:Derin Denizde Kayıp>\n1. “Derin Denizde Kayıp”, keşif gerektirmeyen ve doğrudan savaşa girilen 9 malzeme aşamasından oluşur; her gün bir aşama açılır.\n2. Her meydan okuma 120 Menophin tüketir. Başarılı bir meydan okuma, yetiştirme malzemeleri ve etkinlik para birimi kazandırır.\n3. Bir aşama tamamlandıktan sonra o aşama için “Yeniden Canlandır” işlevi açılır. Not: “Yeniden Canlandır” işlevini kullanmak hiçbir Yakınlık kazandırmaz.\n4. Aşamaları daha kolay geçmek için Destek Uyanmış kullanabilirsiniz.\n\n<Title:Sinyal Bayrağı Bonusu>\n1. Belirli Uyanmışlara veya Kader Çarklarına sahip olan Muhafızlar (savaşa sokmaları gerekmez), “Derin Denizde Kayıp” aşama ödüllerinden (yeniden canlandırmalar dâhil) fazladan “Sinyal Bayrakları” düşürebilir. Özel bonuslar şöyledir:\nUyanmış “Corposant”: Aydınlanma Seviyesi 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSSR Kader Çarkı “Kutsal Ateşin Rehberi”: Yükseliş Seviyesi 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\nSR Kader Çarkı “Deniz Kılavuzu”: Yükseliş Seviyesi 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50\n2. Farklı Uyanmışlardan veya Kader Çarklarından gelen “Sinyal Bayrağı Bonusları” üst üste eklenir.\n3. Özellikle, Delilik Zorluğu meydan okumalarının ilk tamamlama ödülü, yukarıda belirtilen bonuslardan etkilenmez.\n\n<Title:Mürettebatın Hazineleri>\n1. Her “Bayrak Teslimi”, 750 “Sinyal Bayrağı” tüketir ve “Mürettebatın Hazineleri”nden rastgele beş eşya verir.\n2. “Mürettebatın Hazineleri”ndeki eşya ödülleri “Özel Eşyalar” ve “Sıradan Eşyalar” olarak ikiye ayrılır. Sıfırlama sırasında, kalan özel eşya miktarı aşağıdaki kurallara göre azami sınıra sıfırlanabilir:\n(1) İlk 5 sıfırlama: Hiç “Özel Eşya” kalmadığında, Muhafızlar sıfırlamayı seçebilir; bu, hem “Özel Eşyalar”ı hem de “Sıradan Eşyalar”ı azami sınırlarına sıfırlar. Ayrıca, “Sıradan Eşyalar” tükenene kadar takasa devam etmeyi de seçebilirler; bu noktada devam etmek için sıfırlama zorunlu hâle gelir.\n(2) 6. ve sonraki sıfırlamalar: Sıfırlama yalnızca hiç “Sıradan Eşya” kalmadığında yapılabilir. Sıfırlama, kalan “Sıradan Eşyalar”ı azami sınıra döndürür, ancak “Özel Eşyalar” artık sıfırlanmaz.\n\n<Title:Etkinlik Takvimi>\n1. 5 Mayıs 9:00 – 19 Mayıs 9:00 (GMT+8) arasında, etkinlik özetinde belirtilen tüm içerikler erişilebilir.\n2. 19 Mayıs 9:00 – 26 Mayıs 9:00 (GMT+8) arasında yalnızca “Mürettebatın Hazineleri” ve “Başarı Ödülleri” erişilebilir durumda kalır; diğer içerikler sona erer ve katılım mümkün değildir.\n3. 26 Mayıs 9:00 (GMT+8) sonrasında, takas edilmemiş kalan tüm “Sinyal Bayrakları” her bir bayrak için 40 Gül Senedi oranıyla geri alınacaktır. Lütfen postanızı kontrol edin, Muhafızlar."
  },
  Activity_81178_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_81179_ActivityName = {
    Text = "Son Kılavuzluk"
  },
  Activity_81771_ActivityName = {
    Text = "Kutsal Diyarı Gözetleyen Gölge"
  },
  Activity_81771_ActivityPlot = {
    Text = "Hiç kimse İlahi Diyar’ın kutsal ihtişamını görmedi, fakat kazara sızan hakikat kırıntılarından, insanlar İlahi Diyar’ın gölgesini sezebiliyor.\nOrada var, daima orada, ve sayısız sadık mümin onu gerçekten gelmeye zorlayacak.\nNe kadar ağır günahların bedel olarak işlenmesi gerekirse gereksin."
  },
  Activity_81771_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi."
  },
  Activity_81771_ActivityTips = {
    Text = "<Title:Kasvetli Gelgit>\n\"Kasvetli Gelgit\" 7 aşamadan oluşur; ilk 3'ü etkinliğin ilk gününde açılır ve sonrasında her 3 günde 1 aşama daha kilit açar. Her aşama, kendine özgü cömert ödüller sunar!\nHer \"Kasvetli Gelgit\" türü, sayısız küme içerir. Herhangi bir Muhafız bir küme türüne başarıyla meydan okuduğunda, o türün küme sayısı 1 azalır. Bir türün tüm kümeleri yok edildiğinde, ilgili aşama kalıcı olarak kapanır.\nHer Muhafız, etkinlik süresince \"Kasvetli Gelgit\" kümelerini günde en fazla 20 kez püskürtebilir; sıfırlama etkinlik süresince her gün saat 9:00'da (GMT+8) gerçekleşir.\nHer aşama, güçlü güçlendirmeler sunan farklı Kalıntılar sağlar.\nTüm aşamalar için yardım seçilmelidir. Etkinlik boyunca, karşılıklı takipte olduğunuz Muhafızlar yalnızca bir kez yardım sağlayabilir.\nMuhafızların bu etkinliğe katılabilmesi için Soruşturma Operasyonu 2-9'u tamamlamış olmaları gerekir.\n\n<Title:Seviye Telafisi>\n\"Kutsal Diyarı Gözetleyen Gölge: Kasvetli Gelgit\", tüm Muhafızların istilaya birlikte direnmesine yardımcı olmak için bir seviye telafi sistemi içerir!\nTelafi kuralları şöyledir:\nSoruşturma ekibindeki seviyesi 60'ın altında olan herhangi bir Uyanan, bu meydan okuma süresince seviye 60'a telafi edilecektir.\nSoruşturma ekibindeki beceri seviyesi 5'in altında olan herhangi bir Uyanan, bu meydan okuma süresince beceri seviyesi 5'e telafi edilecektir.\nSoruşturma ekibindeki \"Delilik Alametleri\" seviyesi 6'nın altında olan herhangi bir Uyanan, bu meydan okuma süresince seviye 6'ya telafi edilecektir.\nSoruşturma ekibindeki \"Ruh Dövme Yeteneği\" seviyesi 5'in altında olan herhangi bir Uyanan, bu meydan okuma süresince seviye 5'e telafi edilecektir.\nMuhafızın seviyesi 60'ın altındaysa, bu meydan okuma süresince seviye 60'a telafi edilecektir.\n\n<Title:Süreli Görevler>\nEtkinlik süresince, Kasvetli Gelgit'i 30 kez püskürtmek süreli görevleri tamamlayacak ve size \"Sade Kostüm Kuponu (1. Aşama)\" *1 kazandıracaktır!\n26 Mayıs 9:00 - 9 Haziran 9:00 (GMT+8) tarihleri arasında, \"Sade Kostüm Kuponu (1. Aşama)\"yı \"Mağaza: Kostüm Siparişi\"nde kullanarak sade kostümlerle takas edebilirsiniz.\n\"Sade Kostüm Kuponu (1. Aşama)\"nı elde etmenin yolları hakkında daha fazla bilgiyi topluluk kanalları ve duyurular aracılığıyla öğrenin."
  },
  Activity_81771_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_83305_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83306_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83307_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83308_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83309_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83310_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83311_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83312_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83313_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83314_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83315_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83316_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83317_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83318_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83319_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83320_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83321_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83322_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83323_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83324_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83325_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83326_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83327_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83328_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83329_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83330_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83331_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83332_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83333_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83334_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83335_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83336_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83337_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_83338_ActivityName = {
    Text = "Çözünmüş Uçurum"
  },
  Activity_84175_ActivityName = {
    Text = "Özyinelemeli Arşivler"
  },
  Activity_84175_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Belirlenen görevleri tamamladıktan sonra Özyinelemeli Arşivler'den ödüllerinizi alın.\n2. Görevler gruplar halindedir ve etkinlik başladıktan sonra her gün bir grup açılır.\n3. Hac Arşivleri'ni açmak, görev tamamlama için ek ödüller sağlar.\n4. Not: Etkinleştirilen Hac Arşivleri yalnızca bu Arşiv etkinliğinde geçerlidir."
  },
  Activity_84176_ActivityName = {
    Text = "Ouroboros Kodeksi"
  },
  Activity_84176_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Belirlenen görevleri tamamladıktan sonra Ouroboros Kodeksi'nden ödüllerinizi alın.\n2. Görevler gruplar halindedir ve etkinlik başladıktan sonra her gün bir grup açılır.\n3. Premium Arşivler'i açmak, görev tamamlama için ek ödüller sağlar.\n4. Not: Etkinleştirilen Premium Arşivler yalnızca bu Arşiv etkinliğinde geçerlidir."
  },
  Activity_89008_ActivityName = {
    Text = "Boyutlar Arası Rehberlik"
  },
  Activity_89008_ActivityPlot = {
    Text = "Sayısız Boyutu, sayısız dünyayı aştı ve sayısız umut ve umutsuzluk yaşadı, ama asla durmayacak. Çünkü varış noktasının tam olarak nerede olduğunu biliyor — senin olduğun her yer."
  },
  Activity_89008_ActivityTips = {
    Text = "<Title:Genel Bakış>\n1. Etkinlik süresince, Koruyucular her gün giriş yaptıktan sonra \"Boyutlar Arası Rehberlik\" bölümünden günlük giriş ödüllerini alabilir.\n2. Ödüller, Koruyucuların kümülatif girişlerine göre sırayla açılacak ve günlük giriş ödülleri 9:00'da (GMT+8) yenilenecektir.\n\n<Title:Sınırlı Süreli Görevler>\nEtkinlik süresince, toplam 7 gün giriş yapmak sınırlı süreli görevi tamamlayacak ve size \"Temel Kostüm Kuponu (Aşama 1)\" *1 ödülü verecektir!\n26 Mayıs 9:00 - 9 Haziran 9:00 (GMT+8) tarihleri arasında, \"Mağaza: İllüzyon Kıyafet Siparişi\" bölümünde \"Temel Kostüm Kuponu (Aşama 1)\" kullanarak temel illüzyon kıyafetleriyle takas yapabilirsiniz.\n\"Temel Kostüm Kuponu (Aşama 1)\" elde etmenin daha fazla yolu topluluk ve duyurularda bulunabilir."
  },
  Activity_89008_BannerText = {
    Text = "Giriş yaparak bol miktarda Saf Çekirdek kazanın"
  },
  Activity_89576_ActivityName = {
    Text = "Umut Yeniden Çiçek Açsın"
  },
  Activity_89576_ActivityPlot = {
    Text = "Her gün giriş yaparak hatıra sınırlı SSR Kader Çarkı \"Küller Arasından Yeniden Doğuş\"tan 16 adede kadar alın!"
  },
  Activity_89576_ActivityTips = {
    Text = "<Title:Genel Bakış>\nDünya çöküyor. Böyle bir dünyada umutsuzluk normaldir, acı normaldir. Buna alışmalıyım. Ama... kalbimde hâlâ fışkırmayı bekleyen uyuyan bir sıcaklık var.\n\n<Title:Etkinlik Kuralları>\nEtkinlik süresince, Koruyucular her gün giriş yaptıktan sonra \"Umut Yeniden Çiçek Açsın\" bölümünden sınırlı SSR Kader Çarkı \"Küller Arasından Yeniden Doğuş\" alabilir, toplamda 16 talep hakkı vardır.\nÖdüller, Koruyucuların kümülatif girişlerine göre sırayla açılacaktır. Günlük giriş ödülleri sabah 9'da (GMT+8) yenilenecektir."
  },
  Activity_89576_BannerText = {
    Text = "Ücretsiz Sınırlı SSR YK"
  },
  Activity_89729_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_89730_ActivityName = {
    Text = "Yansımanın Tutsağı"
  },
  Activity_89730_ActivityPlot = {
    Text = "Kuş, ey kuş, neden kırık prangalar hâlâ ayaklarına yapışıp kalmış?\nKuş, ey kuş, neden uçsuz bucaksız, ıssız gökte tek başına şarkı söylersin?\nDikenleri yırtıp attın, kafesten kaçtın; kanatların sonsuz çölü kucakladı, yine de o yaslı şarkın hiç susmadı.\nÖzlediğin sadık yoldaş kim? Aradığın gerçek yuva nerede saklı?"
  },
  Activity_89730_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Bilgi Arzusu\"na katılınabilir."
  },
  Activity_89730_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince, Muhafızlar süreli oynanış \"Göklerin Ötesinde\", \"Düşyurdu Devriyesi\" ve \"Başarı Ödülleri\" aracılığıyla \"Bilgi Kitabı\", \"Matematik Kitabı\" ve \"Edebiyat Kitabı\" etkinlik para birimlerini toplayabilirler. Bu para birimleri, \"Bilgi Arzusu\"nda etkinliğe özel SR Kader Çarkı \"Yalnız Tüy\", Işıltılı Çekirdek, Saf Çekirdek vb. eşyaları satın almak için kullanılabilir.\n2. Etkinlik süresince, \"Düşyurdu: Göklerin Ötesinde Bölüm I\" süreli ücretsiz erişime açılacak ve etkinlik başarılarını tamamlamak size etkinliğe özel avatar \"Gümüş Anahtar Adına: Castor\"u da kazandıracaktır!\n\n<Title:Etkinlik Süresi>\n1. 2 Haziran 9:00 - 16 Haziran 9:00 (GMT+8), tüm etkinlik oynanışlarına katılım mümkündür.\n2. 16 Haziran 9:00 - 23 Haziran 9:00 (GMT+8), yalnızca \"Bilgi Arzusu\" ve Başarı Ödülleri’ne katılım mümkündür.\n\n<Title:Göklerin Ötesinde>\n1. \"Göklerin Ötesinde\" 7 bölümden oluşur, her gün 1 bölüm kendiliğinden açılır.\n2. Her meydan okuma 120 Menofin tüketecek ve başarılı meydan okumalar etkinlik para birimi kazandıracaktır.\n3. Bir bölümü tamamladıktan sonra, o bölüm için \"Yeniden Ziyaret\" özelliği açılır. Lütfen dikkat: \"Yeniden Ziyaret\" özelliğini kullanmak Yakınlık kazandırmaz.\n4. Bölümleri daha kolay geçmek için Mezun yardımı kullanabilirsiniz.\n\n<Title:Bilgi Arzusu>\n\"Bilgi Arzusu\"nun üç dükkânı vardır ve şu zamanlarda açılır:\n\"Genel Seçmeli Ders\": 2 Haziran saat 9:00’da açılır.\n\"Fen Seçmeli Dersi\": 4 Haziran saat 9:00’da açılır.\n\"Edebiyat Seçmeli Dersi\": 6 Haziran saat 9:00’da açılır.\nEşyaları doğrudan dükkânların içinden seçip satın alabilirsiniz.\n\n<Title:Etkinlik Bonusları>\n1. Belirli Uyananlara veya Kader Çarklarına sahip Muhafızlar (sahaya sürülmeleri gerekmez), \"Göklerin Ötesinde\" bölüm görevlerinde \"Bilgi Kitabı\", \"Matematik Kitabı\" ve \"Edebiyat Kitabı\" ödülleri için ek düşüş bonusları alabilirler; ayrıntılı bonuslar şöyledir:\nUyanan \"Castor\": Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\nSSR Kader Çarkı \"Dayanılmaz Özgürlük\": Yakınlık 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\nSR Kader Çarkı \"Yalnız Tüy\": Yakınlık 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\n2. Farklı Uyananlar veya Kader Çarklarından gelen \"Etkinlik Bonusları\" toplamsal olarak hesaplanır.\n3. Özellikle, Delilik Zorluğu’ndaki ilk başarılı meydan okuma ödülleri \"Etkinlik Bonusları\"ndan etkilenmeyecektir.\n\n<Title:Düşyurdu Devriyesi>\n1. Her saat otomatik olarak 60 \"Bilgi Kitabı\" alacaksınız; en fazla 25 saatlik birikim depolanabilir.\n\n<Title:Düşyurdu>\n1. Etkinlik süresince, \"Düşyurdu: Göklerin Ötesinde Bölüm I\" ücretsiz olarak kilidi açılabilir.\n2. Etkinlik sona erdikten sonra, \"Düşyurdu: Göklerin Ötesinde Bölüm I\" için soruşturma ilerlemesi korunacak ve etkinlik süresince tamamlanmamış soruşturma olaylarını tamamlamak, etkinlik süresiyle tutarlı soruşturma ödülleri kazandırmaya devam edecektir. \"Düşyurdu: Göklerin Ötesinde Bölüm I\" etkinlik sırasında kilidi açılmamışsa, etkinlikten sonra da \"Gerçeklik Sınırı\" *7 harcayarak kilidi açılabilir.\n3. Etkinlik süresinde olsun ya da olmasın, \"Düşyurdu: Göklerin Ötesinde Bölüm I\"i geçtikten sonra \"Çete: Kaderin Alayı\"nı elde edeceksiniz."
  },
  Activity_89730_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_89899_ActivityName = {
    Text = "Kıyafet Dikimi"
  },
  Activity_89899_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Koruyucular, Kostüm çekmek için \"Hayali Monoküler\" kullanabilir. Her çekiliş için gereken \"Hayali Monoküler\" miktarı artacaktır.\n2. Üst Düzey Kostüm, 5. denemeden itibaren düşebilir. 10 çekilişi tamamlamak, mevcut Üst Düzey Kostümü garanti eder.\n3. Etkinlik sona erdikten sonra kalan tüm \"Hayali Monoküler\" ler otomatik olarak Gümüş Çekirdek Özüne dönüştürülecektir."
  },
  Activity_89899_BannerText = {
    Text = "Kostüm Piyangosu Açık!"
  },
  Activity_90052_ActivityName = {
    Text = "Çürümüş Beyin"
  },
  Activity_90052_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Çürümüş Beyin\" etkinliği süresince Koruyucular, \"Doll: Cehennem\"i içeren sistem tarafından belirlenen takımı kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini denerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez tamamladıktan sonra etkinlik arayüzünden demo ödüllerini talep edebilirsiniz."
  },
  Activity_90493_ActivityName = {
    Text = "Savaş Eğitimi"
  },
  Activity_90493_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucular, ilgili Sahnelerde savaş içeriklerini öğrenebilir ve pratik yapabilir.\n2. Koruyucular ilgili pratik eğitim Sahnelerini Temizlediğinde, \"Pratik Eğitim\"de ödüller talep edilebilir."
  },
  Activity_90861_ActivityName = {
    Text = "Birleşik Kaderler"
  },
  Activity_90861_ActivityTips = {
    Text = "<Title:Birleşik Kaderler>\nBu Süreli Kayıtlar, 8 hediye paketi içerir. İlk hediye paketi doğrudan ücretsiz olarak alınabilirken, 2–8. hediye paketlerinin alınabilmesi için önce \"Birleşik Kaderler\"in satın alınması gerekir.\n\"Birleşik Kaderler\" satın alındıktan sonra, 2. hediye paketinin ödülleri hemen alınabilir; sonraki hediye paketlerinin alınabilmesi için belirli bir süre beklenmesi gerekir.\n20 Nisan saat 9:00'dan önce \"Birleşik Kaderler\"i satın almak, ayrıca şu ek ödülleri de kazandırır: özel avatar \"Moirae Weaver\" ve \"Biçimsiz Olanın Davetiyesi\" ×10! 20 Nisan saat 9:00'dan sonra yapılan satın alımlar, artık bu süreli özel ödülleri sağlamaz.\nSatın alma işleminin ardından, bu Süreli Kayıtlar'ın süresi kalıcı hale gelir ve tüm hediye paketleri alındıktan sonraki gün etkinlik kapanır.\n\"Birleşik Kaderler\" 18 Mayıs saat 9:00'a kadar satın alınabilir olacaktır."
  },
  Activity_90861_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_90862_ActivityName = {
    Text = "Ana istatistik, Krit. Oranı, Krit. Hasar, Anahtar Parıltısı Yenilenme Seviyesi veya Aliemus Dolum Seviyesi arasından rastgele seçilir."
  },
  Activity_90862_ActivityTips = {
    Text = "<Title: Geçici Metin>\n· Bu süreli ön sipariş etkinliği 8 paket içerir; ilki ücretsiz olarak talep edilebilir, 2-8 arası paketler ise talep edilebilmesi için \"Geçici Metin\" satın alınmasını gerektirir.\n· \"Geçici Metin\" satın alındıktan sonra ikinci paket ödülü hemen talep edilebilir; sonraki paketler talep edilmeden önce belirli bir süre beklenmesini gerektirir.\n· \"Geçici Metin\" satın alımı süre sınırlıdır ve son tarihten sonra satın alınamaz. Koruyucular 7 Nisan saat 9:00'a kadar satın almayı değerlendirmelidir."
  },
  Activity_90862_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_90863_ActivityName = {
    Text = "Sayısız Dilek Sanatı"
  },
  Activity_90863_ActivityTips = {
    Text = "<Title:Sayısız Dilek Sanatı>\nBu Arşivler etkinliği 8 hediye paketi içerir; ilk hediye paketi ücretsiz olarak talep edilebilir.\n\"Sayısız Dilek Sanatı\"nı satın aldıktan sonra, 2. hediye paketini hemen talep edebilir ve belirli bekleme sürelerinin ardından 3-8. paketleri açabilirsiniz.\n24 Ağustos saat 09:00'dan önce satın alarak özel avatar \"Hareket Halinde Hile\" ve \"Biçimsiz Olan'ın Daveti\" ×10'u ek olarak alın!\nBu süreden sonra yapılan satın alımlar bu sınırlı süreli özel ödülleri içermeyecektir. \"Sayısız Dilek Sanatı\" sınırlı süreli olarak mevcuttur; lütfen 21 Eylül saat 09:00'dan önce satın alımınızı tamamlayın. Satın alımın ardından, Arşivler etkinliğinin bitiş süresi 28 Eylül saat 09:00'a uzatılacak ve tüm Koruyuculara ödüllerini talep etmek için yeterli zaman tanınacaktır!"
  },
  Activity_90863_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_90864_ActivityName = {
    Text = "Kemik Ağıtı: Süreli Kayıtlar"
  },
  Activity_90864_ActivityTips = {
    Text = "<Title:Kemik Mezarlığı İlahisi: Sınırlı Arşivler>\nBu Sınırlı Arşivler etkinliği 8 paket içerir. İlk paket doğrudan ücretsiz olarak talep edilebilirken, 2. ile 8. paketler yalnızca \"Kemik Mezarlığı İlahisi: Sınırlı Arşivler\" satın alındıktan sonra talep edilebilir.\n\"Kemik Mezarlığı İlahisi: Sınırlı Arşivler\" satın alındıktan sonra 2. paket ödülünü hemen talep edebilirsiniz; sonraki paketlerin talep edilebilmesi için belirli bir süre beklenmesi gerekecektir.\n14 Temmuz 09:00'dan (GMT+8) önce satın alarak Özel Avatar: \"Ebedi Gecenin Açlığı\" ve \"İsimsiz Olanın Daveti\" ×10 kazanın!\nBitiş tarihi: 11 Ağustos 09:00 (GMT+8)."
  },
  Activity_90865_ActivityName = {
    Text = "Uçurum Kıpırtısı: Süreli Kayıtlar"
  },
  Activity_90865_ActivityTips = {
    Text = "<Title:Uçurum Kıpırtısı: Süreli Kayıtlar>\nBu Süreli Kayıt, 8 hediye paketi içerir. İlk paket ücretsizdir.\n2’den 8’e kadar olan paketlerin alınabilmesi için “Uçurum Kıpırtısı: Süreli Kayıtlar”ın satın alınması gerekir.\nSatın alındıktan sonra 2. paketi hemen alabilirsiniz. Kalan paketler belirli bekleme sürelerinin ardından alınabilir.\nÖzel bir bonus olarak, 17 Kasım saat 09:00’dan önce satın alarak “Derin Denizin Ağıdı” avatarını ve 10 adet “Biçimsiz Olanın Davetiyesi” elde edebilirsiniz. Bu teklif sınırlıdır ve son tarihten sonra geçerli olmayacaktır.\nLütfen dikkat: “Uçurum Kıpırtısı: Süreli Kayıtlar”ın kendisi de yalnızca sınırlı bir süre için Alınabilir ve 15 Aralık saat 09:00’dan sonra artık satın alınamaz."
  },
  Activity_91026_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_91027_ActivityName = {
    Text = "Büyük Fetih"
  },
  Activity_91027_ActivityPlot = {
    Text = "Bir ihtişam çağı zamana yenik düşebilir, fakat savaşçılarının ruhu ebediyen sürer.\nHiçbir mezar onları tutamaz; hiçbir zincir onları bağlayamaz.\nYeni ufuklar çağırdığında, kızarmış etin kokusu yollarını çizer—altın, parıltılı—ve onlar, kanlı elleriyle şanı kapmak için ileri atılır.\nSöyle o hâlde! Söyle, kırılmamış cesaret için, ebedî imparatorluk için!\nRoma! Ey Roma!"
  },
  Activity_91027_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Artık yalnızca \"Haraç Sunma\"ya katılabilirsiniz."
  },
  Activity_91027_ActivityTips = {
    Text = "<Title:Etkinlik Genel Bakış>\n1. Etkinlik süresince, Muhafızlar sınırlı süreli oynanış \"Kutsal Av\" üzerinden etkinlik parası \"Leonian Barbekü\" toplayabilir. Bu para, \"Haraç Sunma\" içinde Lümen Çekirdekleri, Saf Çekirdekler vb. eşyaları satın almak için kullanılabilir.\n2. Etkinlik süresince, \"Mutfak Hükümranlığı\"na Süreli ücretsiz erişim sağlanacaktır.\n\n<Title:Etkinlik Süresi>\n1. 30 Haziran 9:00 - 14 Temmuz 9:00 (GMT+8) arasında tüm etkinlik oynanışlarına katılım mümkündür.\n2. 14 Temmuz 9:00 - 21 Temmuz 9:00 (GMT+8) arasında yalnızca \"Haraç Sunma\" ve Başarı Ödülleri oynanışlarına katılım mümkündür.\n\n<Title:Kutsal Av>\n1. \"Kutsal Av\" 5 bölümden oluşur; her 2 günde bir bölüm kendiliğinden açılır.\n2. Her meydan okuma 120 Menophin tüketecek, başarılı meydan okumalar etkinlik parası kazandıracaktır.\n3. Bir bölümü tamamladıktan sonra, o bölüm için \"Yeniden Ziyaret\" işlevi açılır. Lütfen dikkat: \"Yeniden Canlandır\" işlevini kullanmak Yakınlık kazandırmaz.\n4. Bölümleri daha kolay geçmek için Mezun yardımı kullanabilirsiniz.\n\n<Title:Haraç Sunma> Etkinlik dükkânında \"Leonian Barbekü\" ile istediğiniz eşyaları seçip satın alabilirsiniz.\n\n<Title:Düş Diyarı>\n1. Etkinlik süresince, \"Düş Diyarı: Mutfak Hükümranlığı\" ücretsiz olarak açılabilir.\n2. Etkinlik sona erdikten sonra, \"Düş Diyarı: Mutfak Hükümranlığı\"na ait soruşturma ilerlemesi korunacaktır; etkinlik süresince tamamlanmamış soruşturma olaylarını sonradan tamamlamak da, etkinlik süresiyle tutarlı soruşturma ödülleri kazandıracaktır. Eğer \"Düş Diyarı: Mutfak Hükümranlığı\" etkinlik sırasında açılmadıysa, etkinlik sona erdikten sonra da \"Gerçeklik Sınırı\" *7 harcanarak açılabilir.\n3. Etkinlik süresinde olsun olmasın, \"Düş Diyarı: Mutfak Hükümranlığı\"nı geçtikten sonra \"Çete: Yırtıcı Kararlılık\" elde edeceksiniz."
  },
  Activity_91027_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_91112_ActivityName = {
    Text = "Sisin İçindeki Canavar"
  },
  Activity_91112_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Sisin İçindeki Canavar\" etkinliği süresince, Koruyucular Mouchette içeren sistem tarafından hazırlanmış takımları kullanarak belirlenen bölümleri sınırsız sayıda deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken, takım dizilişindeki Uyandırıcılar üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_91355_ActivityName = {
    Text = "Yankılanan Hac: Astral Saltanat III"
  },
  Activity_91355_ActivityPlot = {
    Text = "Yanılsama Hafıza mühürlenip arşivlendi, geçmişe kaydedilen bir yolculuk. Anımsama anlarında, saygılı Haracınızı sunmayı unutmayın."
  },
  Activity_91356_ActivityName = {
    Text = "Kemiklik Arşivleri"
  },
  Activity_91356_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Kemiklik Arşivleri'nde ödüller almak için görevleri tamamlayın\n2. Kemiklik Arşivleri kalıcı olarak erişilebilir kalır\n3. Görev tamamlandığında ekstra ödüller kazanmak için Premium Arşivleri açın\nNot: Etkinleştirilen Premium Arşivler yalnızca bu Arşiv etkinliğinde geçerlidir."
  },
  Activity_91719_ActivityName = {
    Text = "Sade Kostüm Kuponu (2. Dönem)"
  },
  Activity_91719_ActivityPlot = {
    Text = "Sade Kostüm Kuponu (2. Dönem)"
  },
  Activity_91719_ActivityTips = {
    Text = "<Title:Etkinlik Tanıtımı>\n1. Etkinlik süresince Koruyucular, belirli etkinlik görevlerini tamamlayarak Sade Kostüm Kuponu elde edebilir."
  },
  Activity_91728_ActivityName = {
    Text = "Denizin Havarisi"
  },
  Activity_91728_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Denizin Havarisi\" etkinliği süresince Koruyucular, Miryam'ı içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_94858_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_94859_ActivityName = {
    Text = "Yaz Arşivleri"
  },
  Activity_94859_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. \"Yaz Arşivleri\"nde ödülleri talep etmek için görevleri tamamlayın.\n2. \"Premium Arşivler\" açıldıktan sonra görevler tamamlandığında ek ödüller talep edilebilir.\n3. Bu \"Premium Arşivler\" satın alımı süre sınırlıdır; son tarihten sonra satın alınamaz. Koruyucular 6 Ekim saat 09:00'dan önce satın almayı değerlendirmelidir.\n4. Lütfen dikkat: Bu etkinlik süresince açılan \"Premium Arşivler\" yalnızca bu etkinlik süresince geçerlidir. Koruyucular akıllıca ve mantıklı harcama yapmalıdır."
  },
  Activity_94859_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_94860_ActivityName = {
    Text = "Kara Güneş Altında Sonsuz Yaz"
  },
  Activity_94860_ActivityPlot = {
    Text = "Yaz, deniz kıyısı, parlak güneş ve birçok tanıdık yüz.\nKara güneşin aydınlığında her şeyi unut, tüm fantezileri gerçekleştiren bu karnaval rüyasında boğul."
  },
  Activity_94860_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince, \"Düş Diyarı: Varolmayan Diyarda Görüşürüz\" süreli ücretsiz erişim için alınabilir!\n2. Etkinlik süresince, toplam 7 gün giriş yaparak \"Yaz Şenliği\"nde \"Lümen Çekirdeği\" *10 al, 7. günde ise bunlara ek olarak sınırlı savaş avatarı \"Voleybol 'General'\"i elde et.\n\n<Title:Etkinlik Süresi>\n1. 1 Eylül 09:00'dan 6 Ekim 09:00'a kadar (GMT+8) tüm etkinliklere katılım mümkündür.\n\n<Title:Düş Diyarı>\n1. Etkinlik süresince, \"Düş Diyarı: Varolmayan Diyarda Görüşürüz\" ücretsiz olarak açılabilir.\n2. Etkinlik sona erdikten sonra, \"Düş Diyarı: Varolmayan Diyarda Görüşürüz\" için olan soruşturma ilerlemesi Sakla edilir ve etkinlik sırasında tamamlanmamış soruşturma olaylarını etkinlik sonrasında tamamlamak, etkinlik dönemindekiyle aynı soruşturma ödüllerini verir. Eğer \"Düş Diyarı: Varolmayan Diyarda Görüşürüz\" etkinlik sırasında açılmadıysa, etkinlikten sonra \"Gerçeklik Sınırı\" *7 harcanarak yine de açılabilir.\n3. Etkinlik sırasında olsun ya da olmasın, \"Düş Diyarı: Varolmayan Diyarda Görüşürüz\"ü tamamlamak, \"Çete: Yaz Ortası Hatırası\" verir."
  },
  Activity_94860_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_95190_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_95191_ActivityName = {
    Text = "Yere İnen Bin Güneş"
  },
  Activity_95191_ActivityPlot = {
    Text = "Hiç Sönmeyen Efendileri için bir litani söylerler; asla unutmayacaklarına dair söz veren bir koro.\nEn yüce gökten, parlak ışıklardan oluşan bir fırtınayla iner O; sesi, ebedi görkemi ilan eder. Ayakları toprağa değdiğinde, kehribar bir ışık dünyanın üzerine düşer.\nBu, O’nun sunduğu cenazedir."
  },
  Activity_95191_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi, şu anda yalnızca \"Gizli Kale\"ye katılabilirsiniz"
  },
  Activity_95191_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, süreli oynanışlar olan \"Kül Avı\", \"Huzurlu Şölen\" ve \"Başarı Ödülleri\" aracılığıyla etkinlik parası Zenginlik \"Mührü\", Ölümün\"Mührü\"ve Savaş \"Mührü\" toplayabilir. Bu paralar, etkinliğe özel SR Kader Çarkı \"Yaklaşan Güneş\", Işıltılı Çekirdek, Saf Çekirdek ve daha fazlasını içeren \"Gizli Bir Sığınak\"taki eşyaları satın almak için kullanılabilir.\n2. Etkinlik süresince \"Ölümsüz Gündönümü\" ücretsiz olarak erişime açılacak ve etkinlik başarımlarını tamamlamak, etkinliğe özel avatar \"Gümüş Anahtar Adına: Kathigu-Ra\"yı da kazandıracaktır!\n\n<Title:Etkinlik Süresi>\n1. 18 Ağustos 9:00 - 1 Eylül 9:00 (GMT+8), tüm etkinlik oynanışları erişime açık.\n2. 1 Eylül 9:00 - 8 Eylül 9:00 (GMT+8), yalnızca \"Gizli Bir Sığınak\" ve Başarı Ödülleri erişime açık.\n\n<Title:Kül Avı>\n1. \"Kül Avı\" 7 aşamadan oluşur; her gün 1 aşama otomatik olarak açılır.\n2. Her meydan okuma 120 Menophin tüketir ve başarıyla tamamlandığında etkinlik parası verir.\n3. Bir aşama temizlendiğinde, o aşamanın \"Yeniden Canlandır\" işlevi açılır. Lütfen dikkat: \"Yeniden Canlandır\" işlevini kullanırken Yakınlık kazanılmaz.\n4. Temizlemeyi kolaylaştırmak için Alumnis yardımını kullanabilirsiniz.\n\n<Title:Gizli Bir Sığınak>\n\"Gizli Bir Sığınak\"ta üç dükkân vardır ve açılış zamanları şöyledir:\nHazine Mahzeni: 18 Ağustos 9:00’da açılır.\nGörev Odası: 20 Ağustos 9:00’da açılır.\nSavaş Kampı: 22 Ağustos 9:00’da açılır.\nDükkânlardaki eşyaları seçip doğrudan satın alabilirsiniz.\n\n<Title:Etkinlik Bonusları>\n1. Belirli Uyanmışlara veya Kader Çarklarına sahip olmak (savaşa sokulmaları gerekmez), \"Kül Avı\" aşama ödüllerinde Zenginlik \"Mührü\", Ölümün\"Mührü\"ve Savaş \"Mührü\" için ek düşüş bonusu sağlar. Özel bonuslar şöyledir:\nUyanmış \"Kathigu-Ra\": Aydınlanma 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus.\nSSR Kader Çarkı \"Kehribar Renkli Ölüm\": Yükseliş 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus.\nSR Kader Çarkı \"Yaklaşan Güneş\": Yükseliş 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus.\n2. Farklı Uyanmışlar veya Kader Çarklarından gelen bonuslar birikir.\n3. Özel not: Delilik Zorluğu için ilk-temizleme ödülleri etkinlik bonuslarından etkilenmez.\n\n<Title:Huzurlu Şölen>\n1. Her saat otomatik olarak 60 adet Zenginlik \"Mührü\" kazanılır; en fazla 25 saatlik birikim yapılabilir.\n\n<Title:Ruh Dalgası Derin Dalışı>\n1. Etkinlik süresince \"Ölümsüz Gündönümü\" ücretsiz olarak açılabilir.\n2. Etkinlik sona erdikten sonra \"Ölümsüz Gündönümü\" soruşturma ilerlemesi korunur. Etkinlik sonrasında tamamlanmamış soruşturma olaylarını bitirmek, etkinlik sırasında olduğu gibi aynı soruşturma ödüllerini verir. \"Ölümsüz Gündönümü\" etkinlik sırasında açılmadıysa, etkinlikten sonra 3 Reality Verge harcanarak yine açılabilir.\n3. Etkinlik sırasında olsun ya da olmasın, \"Ruh Dalgası Derin Dalışı: Ölümsüz Gündönümü\"nü temizlemek \"Çete: Sönmeyen Güneş\" kazandırır."
  },
  Activity_95191_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_95492_ActivityName = {
    Text = "Majestelerinin Lütfu"
  },
  Activity_95492_ActivityPlot = {
    Text = "O, ölüm diyarını yöneten cömert, yumuşak huylu ve merhametli hükümdardır. Hoş Geldin, henüz ölmemiş yabancı; mis kokun onun lütfunu kazandı, lütfen bu ödülü kabul et, bu kalenin kapıları senin için daima açık kalacak."
  },
  Activity_95492_ActivityTips = {
    Text = "<Title:Giriş>\n1. Etkinlik süresince Koruyucular, \"Majestelerinin Lütfu\" etkinliğinde günlük giriş ödülünü almak için her gün giriş yapabilir.\n2. Ödüller, Koruyucunun toplam giriş sayısına göre sırayla açılacak ve günlük giriş ödülü saat 09:00'da (GMT+8) yenilenecektir.\n"
  },
  Activity_95492_BannerText = {
    Text = "Giriş yaparak bol miktarda Saf Çekirdek kazanın"
  },
  Activity_95977_ActivityName = {
    Text = "Ölümsüzlerin Estetiği"
  },
  Activity_95977_ActivityPlot = {
    Text = "Ölüm, hayatın sonu değil, dönüşümüdür.\nBilinmeyen Yaratık'tan korkma, sevgili Konuk.\nKarnavalın görkemli ayininde, o nazik ev sahibinin rehberliğinde, ölümsüzlerin ürpertici güzelliğine tanık olacaksın."
  },
  Activity_95977_ActivityStageEndContent = {
    Text = "Etkinlik Sona Erdi, şu anda yalnızca \"Kemik Sarayı Ziyafet Salonu\" na katılınabilir."
  },
  Activity_95977_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\nEtkinlik süresince Muhafızlar, sınırlı süreli \"Ruh Ziyafeti\" ve \"Başarı Ödülleri\" oynanışları aracılığıyla etkinlik parası toplayabilir. Etkinlik parası, \"Kemik Sarayı Ziyafet Salonu\"nda etkinliğe özel SR Kader Çarkı \"Makabre Lezzetler\", Eter Taşı, Saf Çekirdek, Lümen Çekirdeği ve daha fazlasını içeren eşya ödülleriyle takas edilebilir.\n\n<Title:Etkinlik Süresi>\n1. 21 Temmuz 9:00 - 4 Ağustos 9:00 (GMT+8) arasında tüm etkinlik içerikleri erişime açıktır.\n2. 4 Ağustos 9:00 - 11 Ağustos 9:00 (GMT+8) arasında yalnızca \"Kemik Sarayı Ziyafet Salonu\" ve \"Başarı Ödülleri\" etkin kalır; diğer tüm içerikler sona erer ve kullanılamaz.\n\n<Title:Ruh Ziyafeti>\n1. \"Ruh Ziyafeti\" 5 aşama içerir; her biri 2 günde bir kendiliğinden açılır.\n2. Her meydan okuma 120 Menophin tüketir. Meydan okumayı başarıyla tamamlamak etkinlik parası kazandırır.\n3. Bir aşama temizlendiğinde, o aşamanın \"Yeniden Canlandır\" işlevi açılır. Lütfen dikkat: \"Yeniden Canlandır\" işlevini kullanmak Yakınlık kazandırmaz.\n4. Aşamaları daha kolay geçmek için Mezun Ortak Oyununu kullanarak yardım alabilirsiniz.\n\n<Title:Etkinlik Bonusları>\n1. Belirli Uyananlara veya Kader Çarklarına sahip olmak (savaşa sokulmaları gerekmez), \"Ruh Ziyafeti\" aşama ödüllerinde (Yeniden Canlandır dâhil) \"Çürümüş Parmak Kemikleri\" için ek düşüş bonusları sağlar. Ayrıntılar şöyledir:\nUyanan \"Doresain\": Aydınlanma 0/1/2/3+, bonus %20/%30/%40/%50\nSSR Kader Çarkı \"Huzur Öpücüğü\": Yükseliş 0/1/2/3+, bonus %20/%30/%40/%50\nSR Kader Çarkı \"Makabre Lezzetler\": Yükseliş 0/1/2/3+, bonus %20/%30/%40/%50\n2. Farklı Uyananlar veya Kader Çarklarından gelen bonuslar üst üste eklenir.\n3. Özel Not: Delilik Zorluğu’ndaki ilk kez tamamlama ödülleri bu etkinlik bonuslarından etkilenmez.\n\n<Title:Kemik Sarayı Ziyafet Salonu>\n1. Her \"Yemek İsteği\" 850 \"Çürümüş Parmak Kemiği\" tüketir ve \"Kemik Sarayı Ziyafet Salonu\"ndaki beş olası eşya ödülünden birini rastgele verir.\n2. \"Kemik Sarayı Ziyafet Salonu\"ndaki eşya ödülleri \"Özel Eşyalar\" ve \"Sıradan Eşyalar\" olarak ikiye ayrılır. Sıfırlama, kalan özel eşyaların miktarını azami sınırına kadar geri yükler. Ayrıntılı kurallar şöyledir:\n(1) İlk 5 Sıfırlama: Hiç \"Özel Eşya\" kalmadığında Muhafızlar sıfırlamayı seçebilir; bu, hem \"Özel Eşyalar\"ın hem de \"Sıradan Eşyalar\"ın miktarını azami seviyeye döndürür; ya da takasa devam etmeyi seçebilirler. \"Sıradan Eşyalar\" da tükendiğinde, daha fazla takas yapmadan önce sıfırlama zorunludur.\n(2) 6. Sıfırlamadan itibaren: Sıfırlama yalnızca hiç \"Sıradan Eşya\" kalmadığında yapılabilir. Sıfırlama sonrasında \"Sıradan Eşyalar\" azami miktarına geri yüklenir, ancak \"Özel Eşyalar\" artık yenilenmez.\n3. 11 Ağustos 9:00’dan (GMT+8) sonra, takas edilmemiş tüm \"Çürümüş Parmak Kemikleri\" sabit oranda \"Gül Senedi*40\"a dönüştürülecektir. Bu dönüşüm için lütfen posta kutunuzu kontrol edin."
  },
  Activity_95977_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_95978_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu I"
  },
  Activity_95978_ActivityPlot = {
    Text = "Satın alma sonrasında \"Doresain\", <BlueQuality:Aydınlanma 3> özelliğini etkinleştirebilir"
  },
  Activity_95979_ActivityName = {
    Text = "Necrovia'nın Efendisi"
  },
  Activity_95979_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Necrovia'nın Efendisi\" etkinliği süresince, Koruyucular Doresain içeren sistem tarafından hazırlanmış takımı kullanarak belirlenen bölümü sınırsız sayıda deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken, takım dizilişindeki Uyandırıcılar üzerinde değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez tamamladığınızda, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_95980_ActivityName = {
    Text = "Ruh Çekirdeği Hediye Kutusu II"
  },
  Activity_95980_ActivityPlot = {
    Text = "Satın alındıktan sonra \"Doresain\" aktive edebilir\n<BlueQuality:Ruh Dalgalanması +4, Aşırı Yüceltme Kilidi Açılır>"
  },
  Activity_96174_ActivityName = {
    Text = "Şanslı Dedektif"
  },
  Activity_96174_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n \"Şanslı Dedektif\" etkinliği süresince Koruyucular, Ryker'ı içeren sistem tarafından önceden ayarlanmış takım dizilişlerini kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcılar değiştirilemez. \n<Title:Etkinlik Ödülleri>\n Aşama görevini ilk kez başarıyla tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_96617_ActivityName = {
    Text = "Kızıl Öz Odun"
  },
  Activity_96617_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n1. Koruyucular belirlenen görevleri tamamladıktan sonra \"Kızıl Öz Odun\" etkinliğinden ödülleri talep edebilir.\n2. \"Kızıl Öz Odun\" 23 Mart saat 21:00'de (GMT+8) sona erecektir.\n3. \"Premium Arşivler\" açıldıktan sonra görevleri tamamladığınızda ek ödüller talep edilebilir.\n4. Lütfen dikkat: Bu etkinlikte açılan \"Premium Arşivler\" yalnızca bu etkinlik için geçerlidir. Koruyucuların bilinçli tüketim yapması tavsiye edilir."
  },
  Activity_96617_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_96838_ActivityName = {
    Text = "Tuvalin Karanlık Yüzü"
  },
  Activity_96838_ActivityPlot = {
    Text = "Bir renk felaketi, bir biçim cinneti.\nNeredeyse tanıdık bir tuval, kan fırça darbeleriyle lekelenmiş,\nPalet bıçağının altında, tuvalin karanlık yüzünden titreyip fısıldayan ruhların bulunduğu.\nEn gerçek ve en kusursuz sanat, deliliğin peçesinin ardına gizlenmiştir,\nÇünkü ancak o kaotik maskeyi yırtarak, dünyanın ham, iç yüzüne göz atılabilir."
  },
  Activity_96838_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi. Şu anda yalnızca \"Pickman'ın Atölyesi\" alınabilir."
  },
  Activity_96838_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince Muhafızlar, süreli oynanış \"Tuhaf Eskiz\" ve \"Başarı Ödülleri\" aracılığıyla etkinlik paraları \"Gerçeğin Boyası\", \"Rüya Boyası\" ve \"Deliliğin Boyası\"nı toplayabilir. \"Gerçeğin Boyası\", \"Rüya Boyası\" ve \"Deliliğin Boyası\", etkinliğe özel SR Kader Çarkı \"Susamış Fırça\", Işıltılı Çekirdek, Saf Çekirdek ve daha fazlasını içeren \"Pickman'ın Atölyesi\"ndeki eşyaları satın almak için kullanılabilir.\n2. Etkinlik süresince \"Ruh Dalgası Derin Dalışı: Çarpık Dünya Tablosu\" süreli ücretsiz erişime açılacaktır. Etkinlik başarımlarını tamamlamak, etkinliğe özel avatar \"Gümüş Anahtar Adına: Pickman\"ı da kazandıracaktır!\n\n<Title:Etkinlik Süresi>\n1. 8 Eylül 9:00 - 22 Eylül 9:00 (GMT+8), tüm etkinlik oynanışlarına katılım mümkündür.\n2. 22 Eylül 9:00 - 29 Eylül 9:00 (GMT+8), yalnızca \"Pickman'ın Atölyesi\" ve Başarı Ödüllerine katılım mümkündür.\n\n<Title:Tuhaf Eskiz>\n1. \"Tuhaf Eskiz\" 7 seviyeden oluşur; her gün 1 seviye otomatik olarak açılır.\n2. Her meydan okuma 120 Menophin tüketir ve başarılı meydan okumalar etkinlik parası kazandırır.\n3. Bir seviye temizlendikten sonra, o seviye için \"Yeniden Canlandır\" işlevi açılır. Lütfen dikkat: \"Yeniden Canlandır\" işlevini kullanmak Yakınlık kazandırmaz.\n4. Seviyeleri daha kolay temizlemek için Alumnis yardımını kullanabilirsiniz.\n\n<Title:Pickman'ın Atölyesi>\n1. \"Pickman'ın Atölyesi\"nde aşağıdaki zamanlarda açılan üç dükkân bulunur:\n \"Gerçek Atölyesi\": 8 Eylül 9:00’da açılır.\n \"Rüya Atölyesi\": 10 Eylül 9:00’da açılır.\n \"Delilik Atölyesi\": 12 Eylül 9:00’da açılır.\n2. Her takas, 750 \"Gerçeğin Boyası\"/\"Rüya Boyası\"/\"Deliliğin Boyası\" tüketir ve atölyeden rastgele beş eşya ödülü verir.\n3. Her atölyedeki eşya ödülleri \"Özel Eşyalar\" ve \"Normal Eşyalar\" olarak ikiye ayrılır. Sıfırlamalar sırasında, kalan özel eşya ödüllerinin miktarı aşağıdaki kurallara göre maksimum sınıra sıfırlanabilir:\n(1) İlk iki sıfırlamada: Kalan özel eşya kalmadığında, Muhafızlar, hem \"Özel Eşyalar\" hem de \"Normal Eşyalar\"ın kalan miktarlarını maksimum sınıra döndürecek bir sıfırlama yapmayı seçebilir veya takasa devam edebilir. Kalan normal eşya kalmadığında, takasa devam edebilmek için mutlaka sıfırlama yapılmalıdır.\n(2) Üçüncü sıfırlamadan itibaren: Yalnızca kalan normal eşya kalmadığında sıfırlama yapılabilir; bu sıfırlama normal eşyaların kalan miktarlarını maksimum sınıra döndürür. Özel eşyalar artık sıfırlanmaz.\n\n<Title:Etkinlik Bonusları>\n1. Belirli Uyanmışlara veya Kader Çarklarına sahip olan Muhafızlar (savaşa sokulmaları gerekmez), \"Tuhaf Eskiz\" görev ödüllerinde \"Gerçeğin Boyası\", \"Rüya Boyası\" ve \"Deliliğin Boyası\" için ek düşüş bonusu alabilir. Özel bonuslar şöyledir:\n Uyanmış \"Pickman\": Aydınlanma 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus.\n SSR Kader Çarkı \"Gerçekçilik Paradoksu\": Yükseliş 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus.\n SR Kader Çarkı \"Susamış Fırça\": Yükseliş 0/1/2/3 ve üzeri, %20/%30/%40/%50 bonus.\n2. Farklı Uyanmışlar veya Kader Çarklarından gelen \"Etkinlik Bonusları\" toplanarak hesaplanır.\n3. Özellikle, Delilik Zorluğu için ilk meydan okuma ödülleri \"Etkinlik Bonusları\"ndan etkilenmez.\n\n<Title:Ruh Dalgası Derin Dalışı>\n1. Etkinlik süresince \"Ruh Dalgası Derin Dalışı: Çarpık Dünya Tablosu\" ücretsiz olarak açılabilir.\n2. Etkinlik sona erdikten sonra \"Ruh Dalgası Derin Dalışı: Çarpık Dünya Tablosu\"nun soruşturma ilerlemesi korunur. Etkinlik sırasında tamamlanmamış soruşturma olaylarını tamamlamak, etkinlik sırasındakiyle tutarlı soruşturma ödülleri kazandırmaya devam eder. \"Ruh Dalgası Derin Dalışı: Çarpık Dünya Tablosu\" etkinlik sırasında açılmadıysa, etkinlikten sonra 3 \"Reality Verge\" harcanarak yine açılabilir.\n3. Etkinlik sırasında olsun olmasın, \"Ruh Dalgası Derin Dalışı: Çarpık Dünya Tablosu\"nu temizledikten sonra \"Çete: Boşluk Tonları\"nı elde edebilirsiniz."
  },
  Activity_96838_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_96839_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_97190_ActivityName = {
    Text = "Necrovia Arşivleri"
  },
  Activity_97190_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Necrovia Arşivleri'nde ödülleri talep etmek için görevleri tamamlayın\n2. Necrovia Arşivleri kalıcı olarak erişilebilir durumdadır\n3. Görev tamamlandığında ekstra ödüller kazanmak için Premium Arşivler'i açın\nNot: Etkinleştirilen Premium Arşivler yalnızca bu Arşivler etkinliğinde geçerlidir."
  },
  Activity_97190_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_97297_ActivityName = {
    Text = "Dikenlerin Kraliçesi"
  },
  Activity_97297_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Dikenlerin Kraliçesi\" etkinliği süresince Koruyucular, Wanda'yı içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız kez deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm meydan okumasını ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_97672_ActivityName = {
    Text = "Kutsal Doğumun Ayini"
  },
  Activity_97672_ActivityPlot = {
    Text = "Bu görkemli kurbanın geçmişi için ağlama.\nKan ve kemik sun. Ruh ve et sun.\nÖzgürlüğünü sun. Hayatını sun.\nOnun kaderi ölçülemez bir görkeme ve katlanılamaz bir ızdıraba yazılıdır.\nO, Tanrı’nın Kızı’dır. O, Tanrı’nın Anası’dır.\nVe bu dehşetli, tiksinti uyandıran kaderi—kendi rızasıyla kabul etmiştir."
  },
  Activity_97672_ActivityStageEndContent = {
    Text = "Etkinlik sona erdi, şu anda yalnızca \"Yaratılışın Yedi Günü\" etkinliğine katılabilirsiniz"
  },
  Activity_97672_ActivityTips = {
    Text = "<Title:Etkinlik Genel Bakış>\n1. Etkinlik süresince, Muhafızlar sınırlı süreli “Teofani Haftası” oynanışı ve “Başarı Ödülleri” aracılığıyla “Rahatlatıcı Tütsü”, “Kabus Kovucu Tütsü” ve “Düş Kapan Tütsüsü” adlı etkinlik paralarını toplayabilir. “Rahatlatıcı Tütsü”, “Kabus Kovucu Tütsü” ve “Düş Kapan Tütsüsü”, “Kutsal Yatak Odası”nda, etkinliğe özel SR Kader Çarkı “Mavi Halka Zehri”, Lümen Çekirdeği, Saf Çekirdek ve daha fazlasını satın almak için kullanılabilir.\n2. Etkinlik sırasında etkinlik başarılarını tamamlamak, etkinliğe özel avatar “Gümüş Anahtar Adına: Murphy: Sahte Doğumlu”yu da kazandıracaktır!\n\n<Title:Etkinlik Süresi>\n1. 24 Kasım 09:00’dan, 15 Aralık 09:00’a kadar (GMT+8), tüm etkinlik oynanışları Alınabilir olacaktır.\n2. 15 Aralık 09:00’dan, 22 Aralık 09:00’a kadar (GMT+8), yalnızca “Kutsal Yatak Odası” ve Başarı Ödülleri Alınabilir olacaktır.\n\n<Title:Teofani Haftası>\n1. “Teofani Haftası” 7 aşamadan oluşur; her gün bir aşama kendiliğinden açılır.\n2. Her meydan okuma 120 Menophin puanı tüketecek, başarılı meydan okumalar etkinlik parası kazandıracaktır.\n3. Bir aşama temizlendikten sonra, o aşama için “Yeniden Canlandır” özelliği açılır. Not: “Yeniden Canlandır” özelliğini kullanmak Yakınlık kazandırmaz.\n4. Aşamaları daha kolay temizlemek için Alumnis yardımı kullanabilirsiniz.\n\n<Title:Küfür Karnavalı>\nEtkinlik başladıktan sonra, her saat otomatik olarak 60 “Rahatlatıcı Tütsü” alacaksınız; en fazla 25 saatlik birikim depolanabilir.\n\n<Title:Kutsal Yatak Odası>\n1. “Kutsal Yatak Odası”nda açılış zamanları aşağıdaki gibi olan üç dükkân bulunur:\n“Tatlı Düş Yolculuğu”: 24 Kasım 09:00’da açılır.\n“Tanrı Doğuşunun Derin Rüyası”: 25 Kasım 09:00’da açılır.\n“Umutsuzluk Kabusu”: 26 Kasım 09:00’da açılır.\n2. Her adak, 750 “Rahatlatıcı Tütsü”/“Kabus Kovucu Tütsü”/“Düş Kapan Tütsüsü” tüketecek ve yatak odasından rastgele beş eşya ödülü bahşedecektir.\n3. Her yatak odasındaki eşya ödülleri “Özel Eşyalar” ve “Sıradan Eşyalar” olarak ayrılır. Sıfırlama sırasında, özel eşya ödüllerinin kalan miktarını sınıra kadar sıfırlayabilirsiniz. Ayrıntılı kurallar şöyledir:\n(1) İlk 2 sıfırlama için: Hiç “Özel Eşya” kalmadığında, Muhafızlar sıfırlamayı seçebilir; bu işlem hem “Özel Eşyalar”ın hem de “Sıradan Eşyalar”ın kalan miktarlarını sınıra döndürür. Adak sunmaya devam etmeyi de seçebilirler; ancak hiç “Sıradan Eşya” kalmadığında, adaklara devam edebilmek için sıfırlama zorunludur.\n(2) 3. sıfırlamadan itibaren: Sıfırlama yalnızca hiç “Sıradan Eşya” kalmadığında yapılabilir; bu işlem “Sıradan Eşyalar”ın kalan miktarlarını sınıra döndürür. “Özel Eşyalar” artık sıfırlanmaz.\n\n<Title:Etkinlik Bonusları>\n1. Belirli Uyananlara veya Kader Çarkları’na sahip olan (sahaya sürülmeleri gerekmez) Muhafızlar, “Teofani Haftası” aşama görev ödüllerinde “Rahatlatıcı Tütsü”, “Kabus Kovucu Tütsü” ve “Düş Kapan Tütsüsü” için ek düşüş bonusları elde edebilir. Ayrıntılı bonuslar şöyledir:\nUyanan “Murphy: Sahte Doğumlu”: Aydınlanma 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\nSSR Kader Çarkı “Karanlıktaki Huzur”: Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\nSR Kader Çarkı “Mavi Halka Zehri”: Yükseliş 0/1/2/3 ve üzeri, bonus %20/%30/%40/%50.\n2. Farklı Uyananların veya Kader Çarkları’nın “Etkinlik Bonusları” kümülatif olarak hesaplanır.\n3. Özellikle, Delilik Zorluğu için ilk tamamlama meydan okuma ödülleri “Etkinlik Bonusları”ndan etkilenmez."
  },
  Activity_97672_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_97853_ActivityName = {
    Text = "Her Şey Eskisi Gibiyse"
  },
  Activity_97853_ActivityPlot = {
    Text = "Hiç felaket hiç yaşanmamış olsaydı, herkesin hayatının nasıl olacağını hayal ettin mi?\nDünyayı kurtarma gücünün kullanılacak bir yeri yok; her gününü sıradan bir kampüs hayatı ve üç beş kuruşluk kredi kazanma telaşıyla tüketiyorsun. Oyun alanı artık savaş eğitimi alan siluetlerle dolu değil; onun yerine kulüp etkinlikleri için kurulmuş sıra sıra bez çadırlar, üye toplama sesleri ve neşeli çığlıklar var. Okul zili çaldığında, aç öğrenciler anında yemekhaneyi dolduruyor...\nEğer değer verdiklerinin kapısını çalsan, seni nasıl gülümseyen yüzler karşılar?"
  },
  Activity_97853_ActivityStageEndContent = {
    Text = "\"Her Şey Eskisi Gibiyse\" Etkinliği sona erdi. Şu anda yalnızca \"Öğrenci Konseyi Binası\"na katılım Alınabilir."
  },
  Activity_97853_ActivityTips = {
    Text = "<Title:Etkinlik Özeti>\n1. Etkinlik süresince, süreli oynanış \"Güneş Altında Yeni Şey\" aracılığıyla \"Sahil Özel Kabukları\" adlı etkinlik parasını toplayabilirsiniz. \"Sahil Özel Kabukları\" nı, \"Öğrenci Konseyi Binası\" nda bulunan \"Lümen Çekirdeği\", \"Saf Çekirdek\", \"Eter Taşı Kırıntısı\" ve daha fazlasını satın almak için kullanabilirsiniz.\n2. Etkinlik süresince, \"Düş Diyarı: Görüşürüz, Varolmayan Diyar\" süreli ücretsiz erişime açılacaktır!\n\n<Title:Etkinlik Süresi>\n1. 6 Ekim, 09:00 - 20 Ekim, 09:00(GMT+8): tüm etkinlik oynanışları kullanılabilir.\n2. 20 Ekim, 09:00 - 27 Ekim, 09:00(GMT+8): yalnızca \"Öğrenci Konseyi Binası\" na katılabilir ve Başarı Ödülleri’ni alabilirsiniz.\n\n<Title:Güneş Altında Yeni Şey>\n1. \"Güneş Altında Yeni Şey\" 5 bölümden oluşur; her 2 günde bir bölüm kendiliğinden açılır.\n2. Her meydan okuma 120 Menofin tüketir ve başarılı meydan okumalar size etkinlik parası kazandırır.\n3. Bir bölümü tamamladıktan sonra, o bölüm için \"Yeniden Canlandır\"özelliği açılır. Not: \"Yeniden Canlandır\"özelliğini kullandığınızda Afinite kazanamazsınız.\n4. Bölümleri geçmeyi kolaylaştırmak için Mezunların yardımını çağırabilirsiniz.\n\n<Title:Etkinlik Bonusları>\n1. \"Psikiyatrist Arşivleri\" içindeki \"Gelişmiş Seyahat Kayıtları\" nı açarak %100 \"Sahil Özel Kabukları\" düşüş bonusunu etkinleştirebilirsiniz(yeniden canlandırma dâhil)\n\n<Title:Öğrenci Konseyi Binası>\n \"Öğrenci Konseyi Binası\" ndaki mağaza 6 Ekim saat 09:00’da açılır.\nMağazada, doğrudan satın almak üzere eşyaları seçebilirsiniz.\n\n<Title:Düş Diyarı>\n1. Etkinlik süresince, \"Düş Diyarı: Görüşürüz, Varolmayan Diyar\"ı ücretsiz olarak açabilirsiniz.\n2. Etkinlik sona erdikten sonra, \"Düş Diyarı: Görüşürüz, Varolmayan Diyar\" için yürüttüğünüz soruşturma ilerlemesi korunacaktır. Etkinlik döneminden kalma, tamamlanmamış herhangi bir Soruşturma Olayı’nı tamamlamak, size etkinlik dönemiyle tutarlı soruşturma ödülleri kazandırmaya devam edecektir. Etkinlik sırasında \"Düş Diyarı: Görüşürüz, Varolmayan Diyar\"ı açmadıysanız, etkinlikten sonra da 7 adet \"Gerçeklik Sınırı\" harcayarak açabilirsiniz.\n3. Etkinlikte olsun ya da olmasın, \"Düş Diyarı: Görüşürüz, Varolmayan Diyar\"ı tamamlamak size \"Çete: Bir Anlık Güzel Düş\" kazandırır."
  },
  Activity_97853_BannerText = {
    Text = "Süreli Etkinlik Şimdi Alınabilir!"
  },
  Activity_97854_ActivityName = {
    Text = "Yan Görev Ücretsiz Kilit Açma"
  },
  Activity_97950_ActivityName = {
    Text = "Tatil Arşivleri"
  },
  Activity_97950_ActivityPromotionalText1 = {
    Text = "\"Sahil Deniz Kabukları\" %100 düşüş bonusu alıyor!"
  },
  Activity_97950_ActivityTips = {
    Text = "Etkinlik Kuralları:\n1. Koruyucu belirlenen arşiv görevlerini tamamladıktan sonra \"Tatil Arşivleri\"nden ödülleri talep edebilir.\n2. \"Premium Arşivler\" açıldıktan sonra görev tamamlandığında ek ödüller talep edilebilir.\n3. \"Premium Arşivler\" açıldıktan sonra \"Güneş Altında Yeni Şey\" aşamasının görev ödüllerinde (yeniden canlandırma dahil) \"Sahil Deniz Kabuğu\" için ek %100 düşüş elde edebilirsiniz.\n4. Özellikle, Delilik Zorluğundaki ilk geçiş meydan okuma ödülleri \"Etkinlik Bonusu\"ndan etkilenmeyecektir.\n5. Bu \"Premium Arşivler\" satın alımı süre sınırlıdır; son tarihten sonra satın alınamaz. Koruyucular 20 Ekim saat 09:00'dan önce satın almayı değerlendirmelidir.\n4. Lütfen dikkat: Bu etkinlikte açılan \"Premium Arşivler\" yalnızca bu etkinlik süresince geçerlidir."
  },
  Activity_97950_BannerText = {
    Text = "Özel Arşivler Alınabilir!"
  },
  Activity_97995_ActivityName = {
    Text = "Büyük Balkabağı'nın Çağrısı"
  },
  Activity_97995_ActivityTips = {
    Text = "<Title:Giriş>\nUğursuz mum ışıkları, şenlikli bir gece şöleni, hayaletlerle çevrili küçük cadı, şeker avına çıkarak görkemli bir giriş yapar!\n\"Eller yukarı! Bütün karamellerinizi, çikolatalarınızı, sütlü şekerlerinizi, meyveli yumuşak şekerlerinizi istiyorum... Aslında, elinizdeki son şeker tanesine kadar hepsini verin!\"\n\"Pamuk şekerin paketlemek için fazla dağınık olduğunu mu söylüyorsun? Off, ver şunu! Hemen şimdi yerim.\"\n\n<Title:Etkinlik Kuralları>\n1. Etkinlik süresince, Murphy’nin yepyeni 4 yıldızlı kıyafeti \"Şeker Soygunu\"nu elde etmek için \"Tuhaf Balkabağı Şekeri\" ile Kostüm Çekilişi’ne katılın!\n2. İlk çekiliş ücretsizdir! Her bir \"Tuhaf Balkabağı Şekeri\" satın alımı için \"Gümüş Çekirdek Özü\" ×60 gerekir ve 2. ila 10. çekilişler için sırasıyla 1/2/2/3/5/5/5/5/5 adet \"Tuhaf Balkabağı Şekeri\" gerekir.\n3. 5. çekilişten itibaren, 4 Yıldızlı Uyanan Kostümü elde etme şansı vardır. Kostüm, 10 çekiliş içinde garanti olarak düşer.\n4. Etkinlik sona erdikten sonra, kalan \"Tuhaf Balkabağı Şekeri\"ler posta yoluyla toplanacak ve Gümüş Çekirdek Özü cinsinden, orijinal fiyatından iade edilecektir."
  },
  Activity_97995_BannerText = {
    Text = "Süreli Kostüm Çekilişi Şimdi Alınabilir!"
  },
  Activity_98445_ActivityName = {
    Text = "Ebedi Sanatçı"
  },
  Activity_98445_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Ebedi Sanatçı\" etkinliği süresince Koruyucular, Hameln'i içeren sistem tarafından belirlenen takımları kullanarak belirlenmiş bölümleri sınırsız deneyimleyebilir.\nEtkinlik bölümlerini deneyimlerken takım kadrosundaki Uyandırıcılarda değişiklik yapılamaz.\n<Title:Etkinlik Ödülleri>\nBölüm görevini ilk kez başarıyla tamamladıktan sonra oyuncular, etkinlik arayüzünden deneme ödüllerini talep edebilir."
  },
  Activity_98446_ActivityName = {
    Text = "Deniz Işıltısı"
  },
  Activity_98446_ActivityTips = {
    Text = "<Title:Etkinlik Kuralları>\n\"Deniz Işıltısı\" etkinliği süresince Koruyucular, Corposant'ı içeren sistem tarafından önceden ayarlanmış takımları kullanarak belirlenmiş aşamaları sınırsız sayıda deneyimleyebilir.\nEtkinlik aşamalarını deneyimlerken Takım Dizilişindeki Uyandırıcılar değiştirilemez.\n<Title:Etkinlik Ödülleri>\nBir aşama görevini ilk kez tamamladıktan sonra, etkinlik arayüzünden deneme ödüllerini talep edebilirsiniz."
  },
  Activity_99296_ActivityName = {
    Text = "Tekrar Buluşacağız"
  },
  Activity_99296_ActivityPlot = {
    Text = "Günlük giriş ödülleri arasında hatıra sınırlı SSR Kader Çarkı \"Tekrar Buluşacağız\" bulunmaktadır, toplamda 16 adet talep edilebilir!"
  },
  Activity_99296_ActivityTips = {
    Text = "<Title:Giriş>\nBu sana adanmış bir şiir; idealler, inanç ve birlikte geçirdiğimiz zaman hakkında. Samimi kalp asla atmayı bırakmasın ve Gümüş Anahtar yolumuzu aydınlatsın.\n\n<Title:Etkinlik Kuralları>\nEtkinlik süresince Koruyucular, hatıra sınırlı SSR Kader Çarkı \"Tekrar Buluşacağız\"ı almak için her gün giriş yapabilir, toplamda 16 kopya alınabilir. \nÖdüller, Koruyucuların toplam giriş sayısına göre sırayla açılacak ve günlük giriş ödülleri saat 09:00'da (GMT+8) yenilenecektir."
  },
  Activity_99296_BannerText = {
    Text = "Ücretsiz Sınırlı SSR YK"
  }
})
return Text_Activity
