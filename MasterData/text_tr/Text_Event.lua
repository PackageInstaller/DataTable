__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Event = readonly({
  Event_116371_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116371_Desc = {
    Text = "Okuldan gelen bir iletişim isteğini kabul ettin. Tanıdık Ses zihnini sakinleştiriyor. Kendini toparlayıp ilerliyorsun."
  },
  Event_116371_Name = {Text = "Kavşak"},
  Event_116372_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116372_Desc = {
    Text = "Bilinmeyen bir odayı tetikledin."
  },
  Event_116372_Name = {Text = "Bilinmeyen"},
  Event_116373_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116373_Desc = {
    Text = "Hazineyi buldun."
  },
  Event_116373_Name = {
    Text = "Gizli Hazine"
  },
  Event_116374_ChoiceDesc1 = {
    Text = "[Connect] Arg2 HP Yenile."
  },
  Event_116374_Desc = {
    Text = "Sis ağır ağır yapışırken, rozetin solgun bir gümüş titreşimle yanıp sönüyor. İletişimci cızırtıyla hayata dönüyor. Biri arıyor."
  },
  Event_116374_Name = {Text = "Kavşak"},
  Event_116389_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116389_Desc = {
    Text = "Pinch hâlâ uyuyor...zzZZ"
  },
  Event_116389_Name = {Text = "Pinch"},
  Event_116429_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116429_Desc = {
    Text = "Rastgele olay 3'ü tetikledin."
  },
  Event_116429_Name = {
    Text = "Rastgele Olay 3"
  },
  Event_116430_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116430_Desc = {
    Text = "Rastgele olay 1'i tetikledin."
  },
  Event_116430_Name = {
    Text = "Rastgele Olay 1"
  },
  Event_116431_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116431_Desc = {
    Text = "Rastgele olay 2'yi tetikledin."
  },
  Event_116431_Name = {
    Text = "Rastgele Olay 2"
  },
  Event_117279_ChoiceDesc1 = {
    Text = "[You Once Longed for Innocence] 3 adet [(Skill.Arg1)] kartını destesine yerleştir."
  },
  Event_117279_Desc = {
    Text = "\nDenizden solgun beyaz bir sis yükselir, her şeyi bir pus perdesine sarar.\nYaşamla ölüm arasındaki sınırı aşarak, kapının içiyle dışı arasındaki mesafeyi kat ederek, çoktan solmuş anılar boyunca yürürken, ışığa karşı güneş şemsiyesi tutan bir hanımefendinin siluetini görürsün.\nOnunla geçirilen zaman çoktan akıp gitmiştir; tıpkı narin ama canlı gençlik renkleri gibi.\nSahte güneş nihayet doğduğunda, sis hiçliğe parçalanır; onun silueti düşte sallanır, ışığa ve hayali kabarcıklara dönüşerek sana sessiz bir veda fısıldar."
  },
  Event_117279_Name = {
    Text = "Murphy'nin İllüzyonu"
  },
  Event_117280_ChoiceDesc1 = {
    Text = "[You Once Longed for Innocence] [Uçurum Yankısı] Duasını vermek için 2 Kart seç."
  },
  Event_117280_Desc = {
    Text = "\nDenizden solgun beyaz bir sis yükselir, her şeyi bir pus perdesine sarar.\nYaşamla ölüm arasındaki sınırı aşarak, kapının içiyle dışı arasındaki mesafeyi kat ederek, çoktan solmuş anılar boyunca yürürken, ışığa karşı güneş şemsiyesi tutan bir hanımefendinin siluetini görürsün.\nOnunla geçirilen zaman çoktan akıp gitmiştir; tıpkı narin ama canlı gençlik renkleri gibi.\nSahte güneş nihayet doğduğunda, sis hiçliğe parçalanır; onun silueti düşte sallanır, ışığa ve hayali kabarcıklara dönüşerek sana sessiz bir veda fısıldar."
  },
  Event_117280_Name = {
    Text = "Murphy'nin İllüzyonu"
  },
  Event_118414_ChoiceDesc1 = {
    Text = "[Three Points]"
  },
  Event_118414_ChoiceDesc2 = {
    Text = "[Six Points]"
  },
  Event_118414_ChoiceDesc3 = {
    Text = "[One Point]"
  },
  Event_118414_Desc = {
    Text = "Zarlar yuvarlanıyor, gluk gluk eden bir ses çıkarıyor.\nNe zaman duracak?\nBilmiyorsun, ama bir cevap vermek zorundasın."
  },
  Event_118414_Name = {
    Text = "Kader Oyunu"
  },
  Event_118415_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118415_Desc = {
    Text = "Cevabın \"Gökyüzü\" nü yumuşatır.\nUsulca alnını öper.\nVe orada, dalga biçimli bir çiçek açar."
  },
  Event_118415_Name = {
    Text = "Denizin Kucağı"
  },
  Event_118416_ChoiceDesc1 = {
    Text = "[Hayale Dal] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_118416_ChoiceDesc2 = {
    Text = "[Maintain Sanity] 50 veya daha fazla Aliemus’a sahip her Uyanan için 15 Kara Mühür kazan"
  },
  Event_118416_ChoiceDesc3 = {
    Text = "[Leave by Force] 3 Dilekten 1'ini kazan"
  },
  Event_118416_Desc = {
    Text = "Belki de uzun süren Savaş seni sersemletti, ya da belki zihnin bedenine ihanet etti.\nDüşüncelerini bir ağırlıksızlık hissi doldurur.\nBir anda zihnin bir Kaleydoskop’a dönüşür—göz kamaştırıcı, parlak, her renkle çakan.\nSayısız Kavrayış, düşünce ve hayal zihnine hücum eder, her bir kıvrımı doldurur.\nBöyle devam ederse, beynin bu kaostan yakında patlayacak."
  },
  Event_118416_Name = {
    Text = "Düşünce Kaleydoskopu"
  },
  Event_118417_ChoiceDesc1 = {
    Text = "[Join the Gamble] [(Skill.Arg1)] geliştir, kumara gir"
  },
  Event_118417_ChoiceDesc2 = {
    Text = "[Forget It] 25 Kara Mühür elde et"
  },
  Event_118417_Desc = {
    Text = "Sersemlik hâlinde, bilincin sis katmanları arasında sürüklendi, saçılarak bilinmeyen uzama dağıldı.\nÖnünde iki zar atıldı, fakat seni zorla buraya sürükleyen o bilinmeyen varlık görünmedi.\nYalnızca her yönden gelen kaotik sesleri işitebildin.\n \"Geri dönmek mi istiyorsun? Öyleyse bir el oynayalım.\"\n \"Bahis olarak hayatını koy, kaderle kumar başlasın.\""
  },
  Event_118417_Name = {
    Text = "Kader Oyunu"
  },
  Event_118418_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118418_Desc = {
    Text = "Aşkın deneyimler uçucudur. Habersiz gelir, aynı aniyle yok olur.\nAma en azından başın yerinde duruyor—gerçekten patlamadı."
  },
  Event_118418_Name = {
    Text = "Düşünce Kaleydoskopu"
  },
  Event_118419_ChoiceDesc1 = {
    Text = "[Leave] [(RelicConfig.Arg1)] Gümüş Kalıntıyı edin"
  },
  Event_118419_Desc = {
    Text = "Kaybetmedin, ama kazanmadın da; sonuç ne iyi ne kötü.\n\"Berabere...\"\nBilinmeyen Yaratık iç çekti, ama sesinde en ufak bir pişmanlık yoktu.\n\"Ne hoş bir küçük oyalanma.\""
  },
  Event_118419_Name = {
    Text = "Kader Oyunu"
  },
  Event_118420_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118420_Desc = {
    Text = "Çılgın melodi yavaşça uyumlu ve kutsal bir şeye dönüşüyor.\nNeden “Mükemmel İlahi” diye adlandırıldığını sonunda anlıyorsun—\nçünkü o, gerçekte, kusursuz."
  },
  Event_118420_Name = {
    Text = "\"Mükemmel\" İlahi"
  },
  Event_118421_ChoiceDesc1 = {
    Text = "[Perceive the Brain] 3 Komut Kartı arasından 1 seçerek Yakarış: [(EnchantConfig.Arg1)] kazan"
  },
  Event_118421_ChoiceDesc2 = {
    Text = "[Perceive the Soul] [(Skill.Arg1)] geliştir, yeniden Damga bas, en fazla 2 kez"
  },
  Event_118421_Desc = {
    Text = "İnsanın ilk kafesi, kendi bedenidir.\nBu kafesin içinde, beyin son ve en önemli zindandır.\n“Tatlım, yalnızca hayatta olup nefes aldığın için güvende olduğunu mu sanıyorsun?”\nBeynin ruhuna ihanet ettiğinde, dünyadaki en acı verici azabı tadacaksın.\nVe bu azap, bir ömür boyu sana eşlik edecek."
  },
  Event_118421_Name = {
    Text = "Beyin Zindanı"
  },
  Event_118422_ChoiceDesc1 = {
    Text = "[Touch the Butterfly] 2 kart sil"
  },
  Event_118422_ChoiceDesc2 = {
    Text = "[Drive Away the Butterfly] \"(RelicConfig.Arg1)\" adlı Lanetli Kalıntı’yı elde et, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_118422_ChoiceDesc3 = {
    Text = "[Leave] Arg1 Kara Mühür al"
  },
  Event_118422_Desc = {
    Text = "Derin denizde kelebek yoktur. Onlar, bir odaya hapsolmuş bir kızın düşleridir.\nNe kadar güzel, havada özgürce dans ediyorlar.\n \"Keşke... ben de onlar gibi uçup gidebilsem...\"\nBir kelebek hıçkırır; çığlığı, kanat çırpışlarının ve daktiloların takırtısının arasında boğulur."
  },
  Event_118422_Name = {
    Text = "Ruh Bir Kelebek Gibi Dans Ediyor"
  },
  Event_118423_ChoiceDesc1 = {
    Text = "[Cut the Rope] \"(Skill.Arg1)\" Geliştir, Lanetli Kalıntı \"(RelicConfig.Arg2)\" elde et"
  },
  Event_118423_ChoiceDesc2 = {
    Text = "[Loosen His Bonds] \"(Skill.Arg1)\"i iki kez Geliştir, Gümüş Kalıntılar \"(RelicConfig.Arg2)\" ve \"(RelicConfig.Arg3)\" elde et"
  },
  Event_118423_ChoiceDesc3 = {
    Text = "[Help Him Break Free] Gümüş Kalıntı [(RelicConfig.Arg1)] elde et"
  },
  Event_118423_Desc = {
    Text = "“Bazıları, sonu gelmeyen arzunun ilerlemenin itici gücü olduğunu söyler.\nAma o arzu öyle güçlenir ki artık ne görmezden gelinebilir ne de koparılabilir hale geldiğinde… içimde bir kafese dönüştüğünü hissediyorum.”\nKaranlıktan zayıf bir ses belirdi. Konuşanın yüzünü göremiyordun, yalnızca bağlanmış iki el seçilebiliyordu.\n“Bu arzular korkumla, zayıflığımla, umudumla, acımla besleniyor… ve böylece yalnızca daha da güçleniyorlar.”\nSes, son bir umutsuz yakarışta bulundu.\n“Her şeyi feda etmeye hazırım! Merhametli ruh, lütfen… beni kurtar. Ya da bana nihai kurtuluşu bahşet.”"
  },
  Event_118423_Name = {
    Text = "Bağlayan Arzular"
  },
  Event_118424_ChoiceDesc1 = {
    Text = "[Perceive the Brain] 3 Komut Kartı arasından 1 seçerek Yakarış: [(EnchantConfig.Arg1)] kazan"
  },
  Event_118424_Desc = {
    Text = "Beyin dokunda bir seğirme hissettin.\n“Bunun özel bir anlamı var mı?”\nDiye kendine sordun, ama beynin sessiz kaldı.\nİnsanın kendine yönelttiği her Soru bir yanıt vermez."
  },
  Event_118424_Name = {
    Text = "Beyin Zindanı"
  },
  Event_118425_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118425_Desc = {
    Text = "Çaresizce yukarı doğru yüzüp suyun yüzeyini yararsın.\nDeniz kokusuyla ağırlaşmış hava ciğerlerine dolar—tehlikenin hâlâ pusuda beklediğini hatırlatan bir işaret.\nAma gerçek gökyüzünün yukarıda olduğunu bilirsin.\nTıpkı Gerçek gibi, nazik yalanlarla örtülemez."
  },
  Event_118425_Name = {
    Text = "Denizin Kucağı"
  },
  Event_118426_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118426_Desc = {
    Text = "Arzu’nun halatına dokunduğun an, ruhunun derinliklerinden keskin bir acı fışkırır.\nKorkun, Zayıflığın, umudun ve ıstırabın kabarır; ellerini bağlayan kanlı bir urgan hâline bükülür.\nO anda, kötücül bir sevinçle tezahür eden bir ses duyarsın.\n \"İyi yürekli olan, hem ödüllendirilecek... hem de lanetlenecek.\""
  },
  Event_118426_Name = {
    Text = "Bağlayan Arzular"
  },
  Event_118427_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118427_Desc = {
    Text = "Dokunuşun Kelebekleri titretiyor.\nYaratıldıklarından beri böyle bir nezaketi hiç bilmemişlerdi.\nAltüst olmuş hâlde, uçmayı unuturlar.\nSayısız Kelebek aşağıya savrulur ve kanatlarının altında saklı duran Daktilo’yu açığa çıkarır.\nArtık cansız olan o zavallı aygıt, son gücünü harcayıp tek bir kelime yazmıştır: \"özgürlük.\""
  },
  Event_118427_Name = {
    Text = "Ruh Bir Kelebek Gibi Dans Ediyor"
  },
  Event_118428_ChoiceDesc1 = {
    Text = "[Savaşa Hazırlan] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_118428_ChoiceDesc2 = {
    Text = "[Try to Detour] 25 Kara Mühür kazan"
  },
  Event_118428_Desc = {
    Text = "Yıldızlarla bezeli derinlikte, Denizciler yüzyıllardır hafif uykudadır.\nSonsuz deniz, onların deliliğine, dayanışına ve en sadık inançlarına tanıklık etmiştir.\nHiç kimse Tanrılarının büyük gelişini engelleyemez.\nYollarına çıkanlar, Denizcilerin gazabıyla küle dönecektir."
  },
  Event_118428_Name = {
    Text = "Yıldızlar Altında Bekleyiş"
  },
  Event_118429_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118429_Desc = {
    Text = "İçgüdüsel olarak kulaklarını kapatırsın.\nMucize eseri, ruhunun derinliklerinden gelen ses susar.\nAma bu yalnızca geçicidir."
  },
  Event_118429_Name = {
    Text = "Saygısızlık Melodisi"
  },
  Event_118430_ChoiceDesc1 = {
    Text = "[Revisit the Past] 3 İleri Dua arasından 1 tane elde et"
  },
  Event_118430_ChoiceDesc2 = {
    Text = "[Gaze into the Future] Altın Kalıntı \"(RelicConfig.Arg1)\" kazan, fakat \"(Skill.Arg2)\" geliştir"
  },
  Event_118430_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_118430_Desc = {
    Text = "Bu dünyada hiçbir şey değişmeden kalmaz—\nİlahi Ana’nın şekillendirdiği Paradise bile.\nBir anlığına, zamanın çatlağından bir şey görürsün.\nGeçmiş, şimdi ve gelecek o çatlakta birbirine dolanır, durmaksızın şekil değiştirir,\nmeraklı bakışını bekler."
  },
  Event_118430_Name = {
    Text = "Zaman Yarığı"
  },
  Event_118431_ChoiceDesc1 = {
    Text = "[Tune] 100 Kara Mühür al"
  },
  Event_118431_ChoiceDesc2 = {
    Text = "[Rastgele 2 Komut Kartı Mühür kazanır: \"(EnchantConfig.Arg1)\"]"
  },
  Event_118431_Desc = {
    Text = "Şekilsiz irade seçimini reddediyor. Yönünü değiştirmen için sana bir şans daha sunuyor—\nDikkat et, şekilsiz bir melodi bile canlar alabilir."
  },
  Event_118431_Name = {
    Text = "\"Mükemmel\" İlahi"
  },
  Event_118432_ChoiceDesc1 = {
    Text = "[Feed the Rats] Gümüş Kalıntı [(RelicConfig.Arg1)] kazan, 1 Semptom geliştir"
  },
  Event_118432_ChoiceDesc2 = {
    Text = "[Drive the Rats Away] 3 kart arasından 1’ine Yakarış kazı: \"(EnchantConfig.Arg1)\", ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_118432_ChoiceDesc3 = {
    Text = "[Ignore the Rats] 25 Kara Mühür kazan"
  },
  Event_118432_Desc = {
    Text = "Bu gemideki her şey Zaman Döngüsü’ne hapsolmuş.\nBurada hayatta kalmak için debelenen o iğrenç, tüylü küçük yaratıklar bile kaderlerinden kaçamaz.\nDöngü üstüne döngü, gözlerinin gördüğü her şeyi Yutarlar, ama açlıkları asla dinmez.\n \"Çok... açız...\"\nSürü sürü sıçan, hastalıklı, delici Çığlıklar salar.\nBitmek bilmeyen döngüler onları Açlıktan Kıvranan ve çılgın bırakmıştır—bir şey yemeliler.\nŞimdi. Hemen."
  },
  Event_118432_Name = {
    Text = "Aç Fare Sürüsü"
  },
  Event_118433_ChoiceDesc1 = {
    Text = "[Avoid Their Gaze] Altın Kalıntı \"(RelicConfig.Arg1)\" kazan, ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_118433_ChoiceDesc2 = {
    Text = "[Stare into the Eyes] Rastgele 2 Uyanan’ı uyandır, ancak [(Skill.Arg1)]i iki kez geliştir."
  },
  Event_118433_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_118433_Desc = {
    Text = "Gökteki yıldızlar gibi, derin denizde de kuşkusuz sayısız göz vardır.\nO gözler, okyanus tabanında yaşayan balıklara, saygısızlığa uğramış solungaçlı türlere ve bizzat okyanusun kendisine aittir.\nŞşşt, onları rahatsız etme.\nEtme, derin denizin deliliğini rahatsız etme."
  },
  Event_118433_Name = {
    Text = "Derin Denizin Gözü"
  },
  Event_118434_ChoiceDesc1 = {
    Text = "[Ignore the Whispers]"
  },
  Event_118434_ChoiceDesc2 = {
    Text = "[Listen to the Whispers]"
  },
  Event_118434_ChoiceDesc3 = {
    Text = "[Make Something Up]"
  },
  Event_118434_Desc = {
    Text = "\"Tanrı’nın lütfunu mu arzuluyorsun? Kendi önemini bilmek mi istiyorsun?\"\nKulağının dibinde bir iç çekiş yankılandı; aklı bozulmuş birinin kendi kendine fısıltısı gibi, ya da biçimsiz bir şeyin mahrem fısıltısı gibi.\nAkıl ve Uyanıklıkla o sesi reddediyorsun, ama o kendi kendine konuşmayı sürdürüyor.\n\"Lütfen sabırla dinle. Bileceğin şey, dünyanın yazgısına dair Gerçek olacak...\""
  },
  Event_118434_Name = {
    Text = "Soyutun Vaazı"
  },
  Event_118435_ChoiceDesc1 = {
    Text = "[Perceive the Brain] 3 Komut Kartı arasından 1 seçerek Yakarış: [(EnchantConfig.Arg1)] kazan"
  },
  Event_118435_ChoiceDesc2 = {
    Text = "[Perceive the Soul] [(Skill.Arg1)] geliştir, rastgele yeniden Damga bas"
  },
  Event_118435_Desc = {
    Text = "Kafatasının içinde güvenle korunan beyin, sana bazı mesajlar iletti.\nBu mesajların, nörotransmitterlere dönüşürken ve biyoelektrik akımlar taşınırken aşınıp aşınmadığını bilmiyorsun.\nTek kesin gerçek şu ki, bilgiyi aldın ve varlığını, bedeninin nesnel mevcudiyeti aracılığıyla hissettin."
  },
  Event_118435_Name = {
    Text = "Beyin Zindanı"
  },
  Event_118436_ChoiceDesc1 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_118436_Desc = {
    Text = "“Güzel cevap, ama ne yazık ki doğru cevap değil.”\n“Peki doğru cevap nedir?”\nBilinmeyen Yaratık soruna cevap vermedi, yalnızca küçümseyen bir kahkaha salıverdi.\n“Kim söyledi sana kaderin doğru bir cevabı olduğunu?”"
  },
  Event_118436_Name = {
    Text = "Kader Oyunu"
  },
  Event_118437_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118437_Desc = {
    Text = "\"Onları koparmaya çalışmadığımı mı sanıyorsun? Hayır—arzuya direnmek onu sadece daha da güçlendiriyor!\"\nArzu ipleri sıkılaştıkça, eti keserken, ses umutsuz bir ulumaya dönüşüyor.\n\"Onlardan asla kurtulamayacağım... asla!\""
  },
  Event_118437_Name = {
    Text = "Bağlayan Arzular"
  },
  Event_118438_ChoiceDesc1 = {
    Text = "[Listen to the Singing] 25 Kara Mühür kazan, fakat [(Skill.Arg2)] geliştir, seçmeye devam et"
  },
  Event_118438_ChoiceDesc2 = {
    Text = "[Ignore It] Ayrıl"
  },
  Event_118438_Desc = {
    Text = "Zifiri siyah karga ağlıyor.\nZifiri siyah karga çığlık atıyor.\nZifiri siyah karga uluyor.\nYine de insanlara, yalnızca şarkı söylüyormuş gibi gelir.\n“Ah, ne kaygısız bir şarkı. Keşke ben de bir karga olsaydım, dünyanın dertlerinden uzakta.”"
  },
  Event_118438_Name = {
    Text = "Algılanmayan Feryat"
  },
  Event_118439_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118439_Desc = {
    Text = "Kelebekler silinirken, sonunda aşağıdaki daktiloyu görürsün.\nO zavallı, cansız şey, son nefesini kullanarak iki kelime yazmıştır: \"Hemen git.\""
  },
  Event_118439_Name = {
    Text = "Ruh Bir Kelebek Gibi Dans Ediyor"
  },
  Event_118440_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118440_Desc = {
    Text = "Geçmişin gölgesinde, kabarık paltolu bir kız sana el sallar.\nSözlerini duyamazsın, ama gülümseyişini görürsün."
  },
  Event_118440_Name = {
    Text = "Zaman Yarığı"
  },
  Event_118441_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118441_Desc = {
    Text = "Derin deniz yeniden sessizliğe ve gölgeye gömülür.\nO durgunlukta, kalp atışını bir kez daha duyarsın.\nBu kez, ses içinden gelmektedir.\nBaşkaları için sen, uçurumda sürüklenen çarpan bir kalpten ibaretsin."
  },
  Event_118441_Name = {
    Text = "Güçlü Olan Hayatta Kalır"
  },
  Event_118442_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118442_Desc = {
    Text = "Bu kez küle dönen, engel değil, Denizcilerin kendisi olur.\nYıldızlar, yüzyıllardır yaptıkları gibi, sahneye sessizce bakar; hiçbir karşılık sunmazlar."
  },
  Event_118442_Name = {
    Text = "Yıldızlar Altında Bekleyiş"
  },
  Event_118443_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118443_Desc = {
    Text = "Sayıları çok olsa da, pis sıçanlar güçten çok cesarete sahip.\nSenin azimli duruşundan yılgınlığa kapılır, paniğe kapılıp sağa sola saçılırlar."
  },
  Event_118443_Name = {
    Text = "Aç Fare Sürüsü"
  },
  Event_118444_ChoiceDesc1 = {
    Text = "[Reach Out a Helping Hand] Rastgele 1 Uyandırıcıyı Uyandır, fakat [(Skill.Arg1)] geliştir"
  },
  Event_118444_ChoiceDesc2 = {
    Text = "[Silently Observing] 3 Dilekten 1'ini elde et"
  },
  Event_118444_Desc = {
    Text = "Zifiri karanlık derinlikte çarpan bir kalp sürükleniyor.\nYüzen bir balığa ya da solungaçlı bir yaratığa ait olabilir.\nNet göremiyorsun—yalnızca atan kalbi ve arkasında yavaşça açılan kanlı bir çeneyi.\nAvlamak ya da avlanmak, doğanın yasasıdır,\nkarada da olsa, denizde de."
  },
  Event_118444_Name = {
    Text = "Güçlü Olan Hayatta Kalır"
  },
  Event_118445_ChoiceDesc1 = {
    Text = "[El Sallayarak Uzaklaştır] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_118445_ChoiceDesc2 = {
    Text = "[Let It Stay] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_118445_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_118445_Desc = {
    Text = "Karanlıktan hafif bir ses Belirir.\nBir Kelebek’tir, nazikçe sorar:\n \"Avucunda dinlenebilir miyim?\"\n \"Yalnızca çok yorgunum... Bir an dinlenmek istiyorum.\"\nSözlerini fısıldarken, Kelebek karanlığın içinden sana doğru sarmal çizerek yaklaşır.\nKanatlarından siyah, koyu bir sıvı damlar—geçip geldiği Gölgelerden getirdiği bir armağan."
  },
  Event_118445_Name = {
    Text = "Kelebeğin İsteği"
  },
  Event_118446_ChoiceDesc1 = {
    Text = "[Leave] Altın Kalıntı [(RelicConfig.Arg1)]yı elde et"
  },
  Event_118446_Desc = {
    Text = "Kısa bir sessizliğin ardından, kollarına bir şey fırlatıldı.\n“Al bunu ve git.”\n“Kader, talihlilere karşı daima cömerttir.”"
  },
  Event_118446_Name = {
    Text = "Kader Oyunu"
  },
  Event_118447_ChoiceDesc1 = {
    Text = "[Rehberliği Takip Et] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte et"
  },
  Event_118447_ChoiceDesc2 = {
    Text = "[Rehberliği Yoksay] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte et"
  },
  Event_118447_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_118447_Desc = {
    Text = "Şölen başlamıştır.\nRuhani alevler ve kana bulanmış lütuflar arasında sayısız mümin yaşayan meşalelere dönüşmüştür—\nEterik ruhlar, yol gösteren periler gibi etrafında saçılır, ışıldar, senin seçimini bekler."
  },
  Event_118447_Name = {Text = "Ruh Feneri"},
  Event_118448_ChoiceDesc1 = {
    Text = "[Leave] 50 Kara Mühür elde et, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_118448_Desc = {
    Text = "\"Cahil insanlar!\"\nO ses, öfkeye varmasa da, hüsranla dolu bir serzeniş savurdu.\nÇünkü bilir ki, cahillerin dahi mutlaka bir aydınlanma anı olur.\nTek yapması gereken, o günün gelişini beklemektir.\nVe o gün gelmeden önce, ruhunun aidiyetini teyit etmek için seni Tanrı’nın mührüyle damgalayacaktır."
  },
  Event_118448_Name = {
    Text = "Soyutun Vaazı"
  },
  Event_118449_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118449_Desc = {
    Text = "[@2 of @3……]\nBir bilgi seli, o küfürkâr ezgi eşliğinde beynine hücum eder.\nAma ölümlü bedenin seni sınırlar, kozmik bilgeliği idrakinin ötesine iter.\nNe acı bir pişmanlık."
  },
  Event_118449_Name = {
    Text = "Saygısızlık Melodisi"
  },
  Event_118450_ChoiceDesc1 = {
    Text = "[Leave] 50 Kara Mühür elde et, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_118450_Desc = {
    Text = "“Aslında, ben de sana dünya hakkında anlatmak istediğim bir gerçek biliyorum…”\n“Dünya, ikisi de bilge köfte gözlerinden oluşan ve sonsuz yeteneği simgeleyen makarnadan müteşekkil uçan bir makarna tanrısı tarafından yaratıldı…”\nCiddi bir tavırla, duyduğun komik bir hikâyeyi uydurup anlatıyor, karşı tarafın tepkisini bekliyorsun.\nAma uzun bir süre geçmesine rağmen, karşı taraf sessiz kalıyor.\n“Ah, demek ki ateşli müminler mizahı anlamıyor.”\nİç çekerek, yalnızca oradan ayrılabiliyorsun."
  },
  Event_118450_Name = {
    Text = "Soyutun Vaazı"
  },
  Event_118451_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118451_Desc = {
    Text = "Ayarların, kaotik hecelere uyum getirmeyi başaramıyor.\nYine de görünmeyen irade çabanı kabul ediyor.\nBu, bir başlangıç."
  },
  Event_118451_Name = {
    Text = "\"Mükemmel\" İlahi"
  },
  Event_118452_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118452_Desc = {
    Text = "Üç siluet titredi, sessizce ağladı.\nİnançları senin tarafından sorgulandı ve bu, bir fanatiğin asla tahammül edemeyeceği en büyük hakaretti."
  },
  Event_118452_Name = {
    Text = "En İyi Kurban"
  },
  Event_118453_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118453_Desc = {
    Text = "Geleceğin imgesinde, dokunaçlı kız sana küçümseyerek baktı ve azarladı.\n\"İlahi Ana’nın gerçek suretine saygısızlık edilemez.\"\nSonra imge dağıldı, zaman-mekân yarığı bir anda kapandı ve seni az önceki sahneyi hatırlamakla baş başa bıraktı."
  },
  Event_118453_Name = {
    Text = "Zaman Yarığı"
  },
  Event_118454_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118454_Desc = {
    Text = "Denizcilerden sıyrılıp yoluna devam edersin.\nYukarıda, yıldızlar binyıllardır olduğu gibi usulca parıldar."
  },
  Event_118454_Name = {
    Text = "Yıldızlar Altında Bekleyiş"
  },
  Event_118455_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118455_Desc = {
    Text = "Bilinmeyen Yaratık sana engel olmadı.\n\"Bir gün, yeniden döneceksin.\"\n\"Hiç kimse kaderden kaçamaz.\""
  },
  Event_118455_Name = {
    Text = "Kader Oyunu"
  },
  Event_118456_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118456_Desc = {
    Text = "Tek, hızlı ve kararlı bir hamleyle eller gevşiyor.\nAma diğerinin son nefesini kaçırmıyorsun.\nNihayet, bitmek bilmeyen arzularından kurtuluyor."
  },
  Event_118456_Name = {
    Text = "Bağlayan Arzular"
  },
  Event_118457_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118457_Desc = {
    Text = "Algılanmamak, dünyanın kaçınılmaz yazgısıdır.\nHiç kimse bir başka varlıkla bütünüyle empati kuramaz."
  },
  Event_118457_Name = {
    Text = "Algılanmayan Feryat"
  },
  Event_118458_ChoiceDesc1 = {
    Text = "[Listen to the Singing] 35 Kara Mühür kazan, fakat [(Skill.Arg2)] geliştir, seçmeye devam et"
  },
  Event_118458_ChoiceDesc2 = {
    Text = "[Ignore It] Ayrıl"
  },
  Event_118458_Desc = {
    Text = "Zifiri siyah karga ağlıyor.\nZifiri siyah karga çığlık atıyor.\nZifiri siyah karga uluyor.\nYine de insanlara, yalnızca şarkı söylüyormuş gibi gelir.\n“Ah, ne kaygısız bir şarkı. Keşke ben de bir karga olsaydım, dünyanın dertlerinden uzakta.”"
  },
  Event_118458_Name = {
    Text = "Algılanmayan Feryat"
  },
  Event_118459_ChoiceDesc1 = {
    Text = "[Listen Closely] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ama \"(Skill.Arg2)\" geliştir."
  },
  Event_118459_ChoiceDesc2 = {
    Text = "[Plug Ears] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_118459_Desc = {
    Text = "Şekilsiz çılgınlığın içinde, bir piyano seçersin.\nBelirsiz bir çift el, dokunulmaz tuşlar üzerinde dans eder, küfürkâr bir melodi çalar.\nBu tuhaf müzik, ruhunun derinliklerinden yankılanarak damarlarında dolaşır, titreyen zihnine ulaşır."
  },
  Event_118459_Name = {
    Text = "Saygısızlık Melodisi"
  },
  Event_118460_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118460_Desc = {
    Text = "O ilhamlar, düşünceler ve hayaller birbirine dolanır, karışarak tasavvur edilebilecek en parlak renklere bürünür.\nBedeninin içinde uzayın katlandığını, zamanın buyruğunla girdaplar çizdiğini görürsün.\nBu anda, her şeye kadirsin, her şeyi bilensin—zaman ve mekânla bir olmuşsundur.\nAma böyle bir güç, daima bir bedel ister."
  },
  Event_118460_Name = {
    Text = "Düşünce Kaleydoskopu"
  },
  Event_118461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118461_Desc = {
    Text = "Kaotik ruh, tiz çığlıklarıyla yolunu gösterir.\nGüvenli mi? Bilemezsin.\nTek seçeneğin ileri gitmektir."
  },
  Event_118461_Name = {Text = "Ruh Feneri"},
  Event_118462_ChoiceDesc1 = {
    Text = "[Listen to the Singing] 40 Kara Mühür kazan, fakat [(Skill.Arg2)] geliştir, seçmeye devam et"
  },
  Event_118462_ChoiceDesc2 = {
    Text = "[Ignore It] 25 Kara Mühür elde et ve ayrıl."
  },
  Event_118462_Desc = {
    Text = "Zifiri siyah karga ağlıyor.\nZifiri siyah karga çığlık atıyor.\nZifiri siyah karga uluyor.\nYine de insanlara, yalnızca şarkı söylüyormuş gibi gelir.\n“Ah, ne kaygısız bir şarkı. Keşke ben de bir karga olsaydım, dünyanın dertlerinden uzakta.”"
  },
  Event_118462_Name = {
    Text = "Algılanmayan Feryat"
  },
  Event_118463_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118463_Desc = {
    Text = "Kaotik ruh, kederli bir iç çekiş salar.\nYavaşça silinir, ama neredeyse elle tutulur o hüzünlü ses, kalbinin üzerine çöker.\nGüm, güm—kalp atışın, ayinin ezgisiyle eşzamanlı hale gelir."
  },
  Event_118463_Name = {Text = "Ruh Feneri"},
  Event_118464_ChoiceDesc1 = {
    Text = "[Leave] [(RelicConfig.Arg1)] Gümüş Kalıntıyı edin"
  },
  Event_118464_Desc = {
    Text = "\"Ah, ah, ne kadar da mümin bir kuzu bu!\"\nO ses içi coşkulu övgüyle dolu bir iç çekişle konuşur.\n \"Rabbim uyandığında, senin gibi kuzular elbet o Yüce ve muazzam İlahi Âlem’de barınacak bir yer bulacaktır...\""
  },
  Event_118464_Name = {
    Text = "Soyutun Vaazı"
  },
  Event_118465_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118465_Desc = {
    Text = "\"Gök\" senin dizginsizliğini kucaklar.\nBir gün, kaybolmuş çocuk yeniden annenin kollarına dönecek.\nÇünkü kaçacak yerin yok."
  },
  Event_118465_Name = {
    Text = "Denizin Kucağı"
  },
  Event_118466_ChoiceDesc1 = {
    Text = "[Accept the Embrace] Gümüş Kalıntı \"(RelicConfig.Arg1)\" kazan, ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_118466_ChoiceDesc2 = {
    Text = "[Reject the Embrace] Gümüş Kalıntı \"(RelicConfig.Arg1)\" kazan, ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_118466_ChoiceDesc3 = {
    Text = "[Swim to the Surface] 25 Kara Mühür kazan"
  },
  Event_118466_Desc = {
    Text = "Dünya, gözlerinden dışarı taşmaktadır.\nBu anda, seni saran derin deniz \"Gökyüzü\" ne dönüşür.\nBoğulmaya ramak kalmış acının içinde, bu koyu mavi \"Gökyüzü\" yaklaşır, seni kucaklamaya niyetlidir.\nYargılamaz—yalnızca verir."
  },
  Event_118466_Name = {
    Text = "Denizin Kucağı"
  },
  Event_118467_ChoiceDesc1 = {
    Text = "[Scold Them] Lanetli Kalıntı \"(RelicConfig.Arg1)\" kazan, fakat \"(Skill.Arg2)\" geliştir"
  },
  Event_118467_ChoiceDesc2 = {
    Text = "[Onlara Karşılık Ver] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: [(EnchantConfig.Arg1)]"
  },
  Event_118467_ChoiceDesc3 = {
    Text = "[Ignore Them] 50 Kara Mühür kazan"
  },
  Event_118467_Desc = {
    Text = "Üç belirsiz şekilli ruh yolunu kesti.\nİçlerinden biri sana derin bir saygıyla eğildi, senden kan bağışlamanı dileyerek. Akıp giden kanın, tanrılar için en iyi kurbandı.\nBir diğeri soğukkanlılıkla sana bir bıçak kaldırdı, etini oymaya niyetli. Henüz mutasyona uğramamış insan eti, tanrıların lütfunu mutlaka kazanacaktı.\nSonuncusu ise sessizce seni seyretti, en sadık imanı kanıtlamak için kendi canına kıymanı umut ederek."
  },
  Event_118467_Name = {
    Text = "En İyi Kurban"
  },
  Event_118468_ChoiceDesc1 = {
    Text = "[Listen to the Singing] 30 Kara Mühür kazan, fakat [(Skill.Arg2)] geliştir, seçmeye devam et"
  },
  Event_118468_ChoiceDesc2 = {
    Text = "[Ignore It] Ayrıl"
  },
  Event_118468_Desc = {
    Text = "Zifiri siyah karga ağlıyor.\nZifiri siyah karga çığlık atıyor.\nZifiri siyah karga uluyor.\nYine de insanlara, yalnızca şarkı söylüyormuş gibi gelir.\n“Ah, ne kaygısız bir şarkı. Keşke ben de bir karga olsaydım, dünyanın dertlerinden uzakta.”"
  },
  Event_118468_Name = {
    Text = "Algılanmayan Feryat"
  },
  Event_118469_ChoiceDesc1 = {
    Text = "[Leave] [(Skill.Arg1)] Semptomunu Geliştir"
  },
  Event_118469_ChoiceDesc2 = {
    Text = "[Leave] [(Skill.Arg1)] Semptomunu Geliştir"
  },
  Event_118469_ChoiceDesc3 = {
    Text = "[Leave] [(Skill.Arg1)] Semptomunu Geliştir"
  },
  Event_118469_Desc = {
    Text = "\"Hayır! Bunu reddediyoruz! Biz çok daha... leziz bir şey arzuluyoruz.\"\n\"Öyleyse olacak olan... kanın ve etin!\"\nBir sıçan sürüsü çığlıklar atarak sana doğru hücum ediyor.\nGörünüşe göre taşan iyi bir yürek, bazen ferahlıktan çok bela getiriyor."
  },
  Event_118469_Name = {
    Text = "Aç Fare Sürüsü"
  },
  Event_118470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118470_Desc = {
    Text = "Saygınlığın, görünmeyen gözlerin teveccühünü kazanır.\nYok olmadan önce, kabaran denizlerden bir armağan yollarlar:\nDerin Deniz’in senin üzerinde hak iddia eden bir işareti."
  },
  Event_118470_Name = {
    Text = "Derin Denizin Gözü"
  },
  Event_118471_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118471_Desc = {
    Text = "Sarsılmaz bakışlarının altında, derin deniz yavaşça kıpırdanır.\nEtrafında, tarif edilemez mırıltılar taşıyan kaotik dalgalar kabarır.\nUçurumun gazabını hisset—iç içe geçmiş bir lütuf ve lanet."
  },
  Event_118471_Name = {
    Text = "Derin Denizin Gözü"
  },
  Event_118472_ChoiceDesc1 = {
    Text = "[Listen to the Singing] 20 Kara Mühür kazan, fakat [(Skill.Arg2)] geliştir"
  },
  Event_118472_ChoiceDesc2 = {
    Text = "[Ignore It] Ayrıl"
  },
  Event_118472_Desc = {
    Text = "Zifiri siyah karga ağlıyor.\nZifiri siyah karga çığlık atıyor.\nZifiri siyah karga uluyor.\nYine de insanlara, yalnızca şarkı söylüyormuş gibi gelir.\n“Ah, ne kaygısız bir şarkı. Keşke ben de bir karga olsaydım, dünyanın dertlerinden uzakta.”"
  },
  Event_118472_Name = {
    Text = "Algılanmayan Feryat"
  },
  Event_118473_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118473_Desc = {
    Text = "Kan, et, hayat.\nKurban hazır, şimdi tek yapman gereken ilahi şöleni sessizce beklemek."
  },
  Event_118473_Name = {
    Text = "En İyi Kurban"
  },
  Event_118474_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118474_Desc = {
    Text = "Kelebek, reddini anlar.\nZifoyla kaplı kanatları, karanlıkta sendeleyerek uçarken bir kez daha titrer.\nÇok geçmeden gölgeler onu yeniden yutar. Bu kez, mücadele edecek gücü yoktur."
  },
  Event_118474_Name = {
    Text = "Kelebeğin İsteği"
  },
  Event_118475_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118475_Desc = {
    Text = "Kelebek, renkli kanatlarından sızan kara sıvıyla birlikte avucuna konar.\nİç çekerken, canlı kanatlar yavaşça erir, katranla birleşip belirsiz, kaotik bir şekle dönüşür.\nBu kelebek bir daha asla Karanlık bilmeyecek.\nElinde huzurla uyur."
  },
  Event_118475_Name = {
    Text = "Kelebeğin İsteği"
  },
  Event_118477_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118477_Desc = {
    Text = "Kısık sesli karga sonunda gözlerini kapadı.\nKabul görmeyen, fark edilmeyen Kin içinde son nefesini verdi ve bir parça kara pelteye dönüştü."
  },
  Event_118477_Name = {
    Text = "Algılanmayan Feryat"
  },
  Event_118478_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118478_Desc = {
    Text = "\"Teşekkür ederim...\"\nÇarpan kalp ufka doğru sıçradı.\nÇok geçmeden, zifiri karanlık Aequor’dan et çiğnenme sesleri yankılandı."
  },
  Event_118478_Name = {
    Text = "Güçlü Olan Hayatta Kalır"
  },
  Event_118479_ChoiceDesc1 = {
    Text = "[Accept the Invitation] \"(Skill.Arg1)\" geliştir, Lanetli Kalıntı \"(RelicConfig.Arg2)\" kazan"
  },
  Event_118479_ChoiceDesc2 = {
    Text = "[Refuse the Invitation] 1 Kalıntı Beden yok etmeyi seç ve 1 Ödül kazan"
  },
  Event_118479_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_118479_Desc = {
    Text = "“Bu gemideki her şey, sonsuzca çözünüp yeniden başlayan bu cennetin bir parçası olmalı.”\nÇılgın melodiler zihninde yankılandı; maddesiz bir iradeden gelen bir vahiydi bu.\n“Burada gözyaşı yok, hüzün yok; yalnızca saf, kutsal müzik ve ebedi kahkaha var.”\n“Paradise’a katılmak, bu kusursuz melodinin bir parçası olmak ister misin?”"
  },
  Event_118479_Name = {
    Text = "\"Mükemmel\" İlahi"
  },
  Event_118480_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118480_Desc = {
    Text = "Senin sessizliğinde, ruhlar sessizce dağılır.\nMüminleri anlamayanlar, onların zamanına değmez."
  },
  Event_118480_Name = {
    Text = "En İyi Kurban"
  },
  Event_123616_ChoiceDesc1 = {
    Text = "[Claim Standard Relic]"
  },
  Event_123616_Desc = {
    Text = "Tüm Uyananların Aliemus’unu 100’e, Keyflare’i 1000’e ve Can’ı %80’e ayarla.\n2 Kartı kaldır ve 3 Semptom kartı ekle.\nKızıl Ocak’ı %12,5’e ayarla, Ultra Uzay’a yerleştirmek için 4 Kart seç.\nStandart Kalıntı Paketi elde et."
  },
  Event_123616_Name = {
    Text = "Fitil Yolu’nu Atla"
  },
  Event_125696_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125696_Desc = {
    Text = "Sebepsiz bir öfke sizi ele geçirir. Elinizi kaldırır, onları dağıtmak için vurursunuz. Bilmecelerde çok uzun oyalandınız; belki amansız bir savaş özlüyorsunuz, ya da sadece bir son...\nAma kargalar hiçbir şey yapmaz. Bakışlarınız altında uçurum çözülür.\nSürü sahnenin sonuna doğru kaybolur—gitmeniz gereken yere."
  },
  Event_125696_Name = {
    Text = "Kargaların Uçurumu"
  },
  Event_125697_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125697_Desc = {
    Text = "\"Korkak.\" Kahkahasındaki alaycılığı gizlemeye bile çalışmıyor.\n\"Git o zaman. Ne kadar uzağa, o kadar iyi.\""
  },
  Event_125697_Name = {
    Text = "Kaderin Zincirleri"
  },
  Event_125698_ChoiceDesc1 = {
    Text = "[Uzaklaştır] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_125698_ChoiceDesc2 = {
    Text = "[Listen] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_125698_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_125698_Desc = {
    Text = "Karanlıktan hafif bir hışırtı yükseliyor. Bir kelebek avucunuza düşüyor. Onu hatırlıyorsunuz.\n\"Leydim Arachne... bizi hiçbir zaman gerçekten terk etmediniz, değil mi?\"\nKanatlarındaki güzel desenler yanınızdakine doğru dönüyor."
  },
  Event_125698_Name = {
    Text = "Bir Kelebeğin Alacakaranlığı"
  },
  Event_125699_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125699_Desc = {
    Text = "Sesler ve yazılar, bir arı kovanı gibi zihninize işliyor. Nefesinizi tutarak bilincinizden işe yaramaz parazitleri temizliyorsunuz.\nGörmezden gelmek, okumaktan çok daha zorlu—ama başardınız."
  },
  Event_125699_Name = {
    Text = "Boyutsal Telgraf"
  },
  Event_125700_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125700_Desc = {
    Text = "Bu, düşman tarafından yaratılmış bir illüzyon!\nBaşını sallıyorsun, berraklık geri geliyor ve Gümüş Anahtar'a olan tutuşunu sıkılaştırıyorsun."
  },
  Event_125700_Name = {
    Text = "Camdaki Yansıma"
  },
  Event_125701_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125701_Desc = {
    Text = "Bakışlarınızı o göze dikiyorsunuz, izlemeye, dinlemeye çabalıyorsunuz. Aktörün kalbine adım atmaya ve çektiği ıstırabı hissetmeye çalışıyorsunuz.\nYaklaşıyorsunuz, daha da yaklaşıyorsunuz. Bedeninin içinden geçiyor ve ruhuna dokunuyorsunuz...\nGözlerinizi açtığınızda kendinizi sahnenin ortasında buluyorsunuz, gözyaşları parmaklarınızdan süzülüyor.\nSeyircilere sunduğunuz itiraf budur."
  },
  Event_125701_Name = {
    Text = "Bir Aktörün İtirafı"
  },
  Event_125702_ChoiceDesc1 = {
    Text = "[Onunla Tartış] Bir Komut Kartını İmha Et ve Arg1 Kara Mühür al"
  },
  Event_125702_ChoiceDesc2 = {
    Text = "[Sessiz Kal]"
  },
  Event_125702_Desc = {
    Text = "\"Mutlu son güzel, ama böyle içi boş bir sevinç seyircinin yüreğine asla dokunamaz...\"\nOyun yazarı gözlerini kapatıp düşünceye dalıyor. Bu sonuçtan memnun değil."
  },
  Event_125702_Name = {
    Text = "Oyunun Sonu"
  },
  Event_125703_ChoiceDesc1 = {
    Text = "[Listen to the Singing] 35 Kara Mühür kazan, fakat [(Skill.Arg2)] geliştir, seçmeye devam et"
  },
  Event_125703_ChoiceDesc2 = {
    Text = "[Ignore It] Ayrıl"
  },
  Event_125703_Desc = {
    Text = "\"Gıcır—gıcır—Kader Tanrıçası çıkrığını çeviriyor.\nGıcır—gıcır—Kader İplikleri ellerinde birleşiyor.\""
  },
  Event_125703_Name = {
    Text = "Son Kehanet"
  },
  Event_125704_ChoiceDesc1 = {
    Text = "[Self] Desteden rastgele 3 Komut Kartından 1'ini kopyala"
  },
  Event_125704_ChoiceDesc2 = {
    Text = "[William] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_125704_ChoiceDesc3 = {
    Text = "[Kimse Yok] 25 Kara Mühür al"
  },
  Event_125704_Desc = {
    Text = "Sarhoş olmadığından eminsin, ama içkinin içine baktığında kendini sakin bir göle batarken buluyorsun.\nKadehin içinde zarif bir figür beliriyor. Kim bu?"
  },
  Event_125704_Name = {
    Text = "Camdaki Yansıma"
  },
  Event_125705_ChoiceDesc1 = {
    Text = "[Listen] [(RelicConfig.Arg1)] Gümüş Kalıntısını edin"
  },
  Event_125705_ChoiceDesc2 = {
    Text = "[Dispel] 75 Kara Mühür alın, ancak [(Skill.Arg2)] Semptomunu geliştirin"
  },
  Event_125705_Desc = {
    Text = "İçindeki Çağ'ın gücüne yaklaştıkça, zihninde bir karga sürüsü beliriyor, çalkantılı ruh âleminde daireler çiziyor.\n\nKargalar etrafında dönerek yukarıda ters asılı duran bir uçurum girdabı gibi sarmallanıyor.\nYüz binlerce karga aynı anda bağırıyor, alay dolu bir kehanet gibi."
  },
  Event_125705_Name = {
    Text = "Kargaların Uçurumu"
  },
  Event_125706_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125706_Desc = {
    Text = "Siz ve Arachne, yanınızda çökmekte olan kaderi sabitlemeye çabalıyorsunuz. Çabalarınız çok az sonuç veriyor, ama yeterli.\nPahalıya satın alınan zamanı kullanarak Nefraea'ya yaklaşmaya devam ediyorsunuz.\nOna kurtuluş bahşetmek için buraya geldiniz."
  },
  Event_125706_Name = {
    Text = "Kader Ağı İçin Son Perde"
  },
  Event_125707_ChoiceDesc1 = {
    Text = "[Listen to the Singing] 20 Kara Mühür kazan, fakat [(Skill.Arg2)] geliştir"
  },
  Event_125707_ChoiceDesc2 = {
    Text = "[Ignore It] Ayrıl"
  },
  Event_125707_Desc = {
    Text = "\"Büyük ağla birlikte ölüyorlar, sessizce.\""
  },
  Event_125707_Name = {
    Text = "Son Kehanet"
  },
  Event_125708_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125708_Desc = {
    Text = "Uçuruma hitaben yazılmış bir telgraf.\n\"Endişelenmeyin, çocuklarım. Hapishanenin kapıları yakında ardına kadar açılacak; kurtuluşunuz yakındır.\""
  },
  Event_125708_Name = {
    Text = "Boyutsal Telgraf"
  },
  Event_125709_ChoiceDesc1 = {
    Text = "[Kovala] Rastgele 1 Komut Kartı Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_125709_ChoiceDesc2 = {
    Text = "[Listen] 3 Komut Kartı'ndan 1'ine [(EnchantConfig.Arg1)] Mühür'ünü kazı"
  },
  Event_125709_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_125709_Desc = {
    Text = "Bir kelebek nazikçe avucunuza konar. Zarif desenleri, kırpılmayan gözler gibi sessizce size bakıyor.\nBelki de size bir şey anlatmak istiyor?"
  },
  Event_125709_Name = {
    Text = "Bir Kelebeğin Huzuru"
  },
  Event_125710_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125710_Desc = {
    Text = "Yirmi çift kederli göz sana dikilir. Karga şarkısını keser ve bu çökmekte olan ağdan son kehanetiyle ayrılır."
  },
  Event_125710_Name = {
    Text = "Son Kehanet"
  },
  Event_125711_ChoiceDesc1 = {
    Text = "[Lean Out] \"(RelicConfig.Arg2)\" adlı Altın Kalıntıyı edin, fakat \"(Skill.Arg1)\"i geliştir."
  },
  Event_125711_ChoiceDesc2 = {
    Text = "[Give Up Checking] 50 Kara Mühür al"
  },
  Event_125711_Desc = {
    Text = "Sokak köşesinden geçerken mütevazı bir gösterim salonu fark ediyorsunuz. Londinium'da böyle bir yerin var olduğunu hatırlamıyorsunuz."
  },
  Event_125711_Name = {
    Text = "Anı Sineması"
  },
  Event_125712_ChoiceDesc1 = {
    Text = "[Kaderi Kabul Et] 3 Komut Kartından 1'ine [(EnchantConfig.Arg1)] Mührünü kazı"
  },
  Event_125712_ChoiceDesc2 = {
    Text = "[Kadere Meydan Oku] [(Skill.Arg1)] Semptomunu geliştir ve Mühür'ü kazımaya dönüştür.(Kullanım: 2/2)"
  },
  Event_125712_Desc = {
    Text = "\"Ah, yine karşılaştık, sevgilim.\"\nO hanımefendinin zihninizde yankılanan sesinden keyif almaya başlarsınız. Şefkatli ve baştan çıkarıcı, sinekleri yakalamak için örülmüş bir ağ gibi.\n\"Gel, söyle bana—kaderini kucaklamaya hazır mısın?\""
  },
  Event_125712_Name = {
    Text = "Kaderin Kafesi"
  },
  Event_125713_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125713_Desc = {
    Text = "\"Aptal insan, biz tanışıyor muyuz?\"\nKara kedi küçümseyerek gözlerini devirir ve arkasını döner.\n\"Git buradan. Ve bir daha bu kadar aptalca bir şey yapma.\""
  },
  Event_125713_Name = {
    Text = "Değişen Biçimler"
  },
  Event_125714_ChoiceDesc1 = {
    Text = "[Fotoğraf Çek] 3 Komut Kartından 1'ine [(EnchantConfig.Arg1)] Mührünü kazı"
  },
  Event_125714_ChoiceDesc2 = {
    Text = "[Poz Değiştir] [(Skill.Arg1)] Semptomunu geliştir ve kazınacak Mührü değiştir.(Kullanım: 2/2)"
  },
  Event_125714_Desc = {
    Text = "Sahnenin üzerinde yalnız bir kamera duruyor, zifiri karanlık merceği, mekanik bir tanrının işlediği esrarengiz bir bileşik göz gibi size dikilmiş.\nBu tiyatro çok uzun süredir boş... Hoş geldiniz! Hoş geldiniz! Gelin, bir fotoğraf çektirin! Tamamen ücretsiz!\nKamera heyecandan çığlık atıyor. Bu terk edilmiş sahnede, tek başrol oyuncusu o."
  },
  Event_125714_Name = {
    Text = "Tribün Anlık Görüntüleri"
  },
  Event_125715_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125715_Desc = {
    Text = "\"Kaderden hiçbir şey istemeyen biri, kaderin cevabını nasıl umabilir?\""
  },
  Event_125715_Name = {
    Text = "Kaderin Zincirleri"
  },
  Event_125716_ChoiceDesc1 = {
    Text = "[Bir Çıkış Yolu Bul] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştirin"
  },
  Event_125716_ChoiceDesc2 = {
    Text = "[Oluruna Bırak] Altın Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" ve \"(Skill.Arg3)\" geliştirin"
  },
  Event_125716_ChoiceDesc3 = {
    Text = "[Surface] 25 Kara Mühür al"
  },
  Event_125716_Desc = {
    Text = "Yeni bir sahne. İç içe geçmiş iki hayat... Memurlardan kaçarken, Arachne'nin sizinle paylaştığı gerçekleri düzenliyorsunuz.\nKarmaşık düşüncelerin arasında, sakin ve derin bir denize dalıyorsunuz."
  },
  Event_125716_Name = {Text = "Sakin"},
  Event_125717_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125717_Desc = {
    Text = "Kelebek omzunuza süzülüyor, kulağınıza yaklaşıyor. Dikkatle dinliyorsunuz, ama yalnızca kanatların hafif titreşimini duyuyorsunuz—sessiz bir iç çekişe benzeyen bir ses.\nDinlerken, yanardöner kanatlar çözülmeye başlıyor ve kelebek omzunuzda ebedi bir uykuya dalıyor.\nTaşıdığı mesaj sizin için sonsuza dek yitip gidiyor."
  },
  Event_125717_Name = {
    Text = "Bir Kelebeğin Alacakaranlığı"
  },
  Event_125718_ChoiceDesc1 = {
    Text = "[Isır] 1 rastgele Uyandırıcı'yı Uyandır, ancak [(Skill.Arg1)] geliştirilir"
  },
  Event_125718_ChoiceDesc2 = {
    Text = "[Refuse] 3 Yakarıştan 1’ini Oyarak Kazı"
  },
  Event_125718_Desc = {
    Text = "\"Acıktın mı, sevgili konuğum?\"\nBarın arkasından yapışkan bir ses yükseliyor. Dönüyorsun, ama hiçbir şey göremiyorsun.\n\"Gece Yarısı Maskeli Balosu'nun atıştırmalıkları da oldukça ünlüdür. Bir tadına bakmak ister misin?\""
  },
  Event_125718_Name = {
    Text = "Kaderin Tadı"
  },
  Event_125719_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125719_Desc = {
    Text = "İçindeki yazıyı okumaya cesaret edemezsiniz, bunun yerine zarif zarfı incelemeyi tercih edersiniz.\nMühür mumu üzerinde bulanık bir arma bulunur, üzerinde zarif el yazısıyla şunlar yazar:\n\"Yeni doğan Bayan Arachne'ye.\"\n\"Sadık uşağınız, Edgar.\""
  },
  Event_125719_Name = {
    Text = "İyi Geceler, Bay Edgar"
  },
  Event_125720_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125720_Desc = {
    Text = "\"Anlıyorum. Şimdi anladım, abla...\"\n\"Bir oyun yazarı, bir karakterin sonunu asla yeniden yazamaz. O sefil kader çoktan mühürlenmişti; sen bile onu değiştiremezdin...\"\nHüzünlü hıçkırıklar sönüyor. Oyun yazarının daktilosi kelebeklere dönüşüyor, boş Kader Tiyatrosu'na saçılarak iz bırakmadan yok oluyor."
  },
  Event_125720_Name = {
    Text = "Oyunun Sonu"
  },
  Event_125721_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125721_Desc = {
    Text = "Bilinmeyen aktörler, tehlikeli adımlar... ne önemi var? Hiçbir şey kaderin kendisinden daha kötü olamaz.\nElini uzatıp sahneye çıkıyorsun. Kuklalar elini tutuyor ve seni neşeli bir dansa çekiyor.\nAlkışları duyuyorsun."
  },
  Event_125721_Name = {
    Text = "Üçlü Pas"
  },
  Event_125722_ChoiceDesc1 = {
    Text = "[Listen to the Singing] 25 Kara Mühür kazan, fakat [(Skill.Arg2)] geliştir, seçmeye devam et"
  },
  Event_125722_ChoiceDesc2 = {
    Text = "[Ignore It] Ayrıl"
  },
  Event_125722_Desc = {
    Text = "\"Dans ediyorlar. Şarkı söylüyorlar. Gıcır—gıcır—\""
  },
  Event_125722_Name = {
    Text = "Son Kehanet"
  },
  Event_125723_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125723_Desc = {
    Text = "Rehber, yoldaş—bu yalnız boyuttaki tek arkadaş.\nBuradaki her şeyi birlikte çözecek ve Kadath'a döneceksiniz. Bunu hiç sorgulamadın."
  },
  Event_125723_Name = {
    Text = "Camdaki Yansıma"
  },
  Event_125724_ChoiceDesc1 = {
    Text = "[Take a Gamble] [(Skill.Arg1)] geliştir ve talihini yokla"
  },
  Event_125724_ChoiceDesc2 = {
    Text = "[Forget It] 25 Kara Mühür elde et"
  },
  Event_125724_Desc = {
    Text = "Bir ara sokak köşesinde, bir çift kirli el yolunuzu kesiyor.\nParçalanmış giysiler içindeki bir dilenci yaklaşıyor, gözleri leş koklayan bir sırtlan kadar açgözlü.\n\"Gel! Bir el! Bilmek istediğin her şeyi anlatacağım... yeter ki kazan...\""
  },
  Event_125724_Name = {
    Text = "Sokak Kumarı"
  },
  Event_125725_ChoiceDesc1 = {
    Text = "[Ignore] Bir Komut Kartı'nı İmha Et ve 25 Kara Mühür al"
  },
  Event_125725_ChoiceDesc2 = {
    Text = "[Read] Desteden 1 Kart'ı kopyala, ancak [(Skill.Arg1)] Semptomu geliştirilir"
  },
  Event_125725_Desc = {
    Text = "Tık, tık, tık... Tık, tık, tık...\nBarın köşesi ıssız; faks makinesi zarif bir piyano sonatı gibi net, ritmik bir kadansla çalıyor."
  },
  Event_125725_Name = {
    Text = "Boyutsal Telgraf"
  },
  Event_125726_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125726_Desc = {
    Text = "\"Sessiz ol. Ben bir kediyim. Senin sıkıcı hikâyelerinle ilgilenmiyorum.\"\n\nKedi iç çeker ve arkasını döner.\n\n\"Git buradan. Ve bir daha bu kadar aptalca bir şey yapma.\""
  },
  Event_125726_Name = {
    Text = "Değişen Biçimler"
  },
  Event_125727_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125727_Desc = {
    Text = "Belki de haklı. Bu sensin—ruhunun derinliklerindeki en gizli, en iğrenç düşünceler.\nHer insan bencildir; sen hiçbir zaman başkalarının inandığı kadar asil değildin.\nO sefil acıyı tadıyorsun. Geçmişin gittiğini ve kurtuluşunun önünde olduğunu biliyorsun."
  },
  Event_125727_Name = {
    Text = "Yayılan Izdırap"
  },
  Event_125728_ChoiceDesc1 = {
    Text = "[Onunla Tartış] Bir Komut Kartını İmha Et ve Arg1 Kara Mühür al"
  },
  Event_125728_ChoiceDesc2 = {
    Text = "[Sessiz Kal]"
  },
  Event_125728_Desc = {
    Text = "\"Trajik bir son gerçekçi, ama gerçekliğimiz zaten bu kadar sefil. Bir hikâyenin içinde bile ona daha yumuşak bir kader bahşedemez miyiz...?\"\nOyun yazarı gözlerini kapatıp düşünceye dalıyor. Bu sonuçtan memnun değil."
  },
  Event_125728_Name = {
    Text = "Oyunun Sonu"
  },
  Event_125729_ChoiceDesc1 = {
    Text = "[Leave] Altın Kalıntı [(RelicConfig.Arg1)]yı elde et"
  },
  Event_125729_Desc = {
    Text = "Takır tukur. Zarlar bardağın içinde çılgınca dans ediyor, tükenene kadar dönüyorlar.\n\n\"Neden... neden kimse kazanamıyor?!\""
  },
  Event_125729_Name = {
    Text = "Sokak Kumarı"
  },
  Event_125730_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125730_Desc = {
    Text = "Fısıltısını duymak için yaklaşıyorsunuz.\nKelebek kanatlarını çırpıp avucunuzdan ayrılıyor.\nHiçbir şey duymuyorsunuz."
  },
  Event_125730_Name = {
    Text = "Bir Kelebeğin Huzuru"
  },
  Event_125731_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125731_Desc = {
    Text = "Kelebek jestlerinize aldırmıyor.\nSessiz bir ısrarla avucunuzun peşinden geliyor—ve ancak kolunuzu son bir kez kaldırdığınızda ayrılmayı seçiyor.\nBir pişmanlık kıpırtısı uyanıyor. Belki de... dinlemeliydiniz?"
  },
  Event_125731_Name = {
    Text = "Bir Kelebeğin Huzuru"
  },
  Event_125732_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125732_Desc = {
    Text = "Kara sis ıssızlık içinde ürperiyor; dilencinin acı dolu feryatları yürek parçalayıcı.\nBir göz kırpımında zarlar ve dilenci kayboluyor. Yırtık pırtık şapkanın içinde oyunun ödülü duruyor."
  },
  Event_125732_Name = {
    Text = "Sokak Kumarı"
  },
  Event_125733_ChoiceDesc1 = {
    Text = "[Şölene Katıl] Lanetli Kalıntı \"(RelicConfig.Arg2)\" edin, ancak \"(Skill.Arg1)\" geliştir"
  },
  Event_125733_ChoiceDesc2 = {
    Text = "[Müziği Durdur] 1 Kalıntı İmha Et ve 1 ödül kazan"
  },
  Event_125733_ChoiceDesc3 = {
    Text = "[Kulaklarını Kapat] 50 Kara Mühür al"
  },
  Event_125733_Desc = {
    Text = "\"Ah! Müzik! Müzik olmadan büyük bir gösteri nasıl olabilir!!\"\nParçalanmış tiyatroda uyumsuz bir senfoni yükseliyor, kaosun şöleni gibi. Uçurum'dan gelen aktörler bu düzensiz övgüde dans edip tezahürat yapıyor, onları ayakta tutan notalarda kendilerinden geçiyorlar."
  },
  Event_125733_Name = {
    Text = "Kadere Övgü"
  },
  Event_125734_ChoiceDesc1 = {
    Text = "[Tune] 100 Kara Mühür al"
  },
  Event_125734_ChoiceDesc2 = {
    Text = "[Rastgele 2 Komut Kartı Mühür kazanır: \"(EnchantConfig.Arg1)\"]"
  },
  Event_125734_Desc = {
    Text = "Görünmez kader iplikleri notaların arasında dans ediyor. O kaotik gürültüde, büyüleyici melodinin ipliğini izlemeye başlıyorsun—evet, kaderin gerçek sesi işte bu.\nUçurum'un terk edilmişleri senin için tezahürat yapıyor, etrafında toplanıyor, seni düzensiz şölenlerine çekiyor.\nTebrikler, şanslı seyirci! Şimdi, kaderin final sahnesinde aktörlere katılacaksın."
  },
  Event_125734_Name = {
    Text = "Kadere Övgü"
  },
  Event_125735_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125735_Desc = {
    Text = "Bu sesin anlamını çözemiyorsun, ama durması gerektiğini biliyorsun.\nGümüş ışık çılgına dönmüş bir kılıç gibi yarıyor. Ritmi, bir şekilde, notalarla mükemmel bir uyum içine düşüyor.\nFarkına varmadan müzik kesildi. Artık hiçbir şey duymuyorsun. Sadece gece görüyorsun; sadece sessizlik duyuyorsun.\nDüzensiz kakofoni mi yoksa mutlak sessizlik mi—hangisi daha korkutucu... Koruyucu?"
  },
  Event_125735_Name = {
    Text = "Kadere Övgü"
  },
  Event_125736_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125736_Desc = {
    Text = "Elini uzatıyorsun; bir kelebek nazikçe eline konuyor.\nGerçekten de. Ölüm, çözünme, zamanın geçişi... Kelebek kozadan doğar; ızdırap, sanatın ebedi toprağıdır.\nMükemmel bir seyirci olarak, bu anlamanız gereken bir gerçektir."
  },
  Event_125736_Name = {
    Text = "Çözünmede Açan Çiçek"
  },
  Event_125737_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125737_Desc = {
    Text = "Belki de bu, Nefraea'nın hilelerinden bir tanesi daha.\nKelebek sözlerinizi anlıyor; karanlıkta sessiz bir iç çekiş yankılanıyor. Siyah balçıkla kaplı kanatlar titriyor ve çok geçmeden ağır bedeni sonsuz karanlık tarafından yutuluveriyor.\nTaşıdığı mesaj sizin için sonsuza dek yitip gidiyor."
  },
  Event_125737_Name = {
    Text = "Bir Kelebeğin Alacakaranlığı"
  },
  Event_125738_ChoiceDesc1 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_125738_Desc = {
    Text = "Takır tukur. Zarlar bardağın içinde çılgınca dans ediyor, tükenene kadar dönüyorlar.\n\n\"Neden... neden kimse kazanamıyor?!\""
  },
  Event_125738_Name = {
    Text = "Sokak Kumarı"
  },
  Event_125739_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125739_Desc = {
    Text = "Düşüncelerinizin şu an başıboş dolaşmasına izin vermek tehlikeli. Başınızı sallayıp derhal yüzeye çıkıyorsunuz."
  },
  Event_125739_Name = {Text = "Sakin"},
  Event_125740_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125740_Desc = {
    Text = "Her nota bir dinleyici gerektirmez; her kader bir cevap gerektirmez.\nEllerini sıkıca kulaklarına bastırıp gürültülü sahneden ayrılıyorsun.\nO uyumsuz müziğin anlamını merak etmeye devam ediyorsun, ama doğru olan tek seçimi yaptığını biliyorsun."
  },
  Event_125740_Name = {
    Text = "Kadere Övgü"
  },
  Event_125741_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125741_Desc = {
    Text = "Gümüş ışık yanılsamayı deler; kara kediler siyah çamur birikintilerine dönüşür.\nSaklanmak için kedi formuna bürünmek... canavar sizin gözlerinizden kaçamaz."
  },
  Event_125741_Name = {
    Text = "Değişen Biçimler"
  },
  Event_125742_ChoiceDesc1 = {
    Text = "[Kaderi Kabul Et] 3 Komut Kartından 1'ine [(EnchantConfig.Arg1)] Mührünü kazı"
  },
  Event_125742_Desc = {
    Text = "\"Hiç kimse kadere gerçekten meydan okuyamaz, canım. Seçme hakkına hiçbir zaman sahip olmadık.\"\nSes kederli ve uzak bir hal alır. Sana mı yoksa tamamen başka bir şeye mi konuştuğundan emin değilsin."
  },
  Event_125742_Name = {
    Text = "Kaderin Kafesi"
  },
  Event_125743_ChoiceDesc1 = {
    Text = "[Listen to the Singing] 30 Kara Mühür kazan, fakat [(Skill.Arg2)] geliştir, seçmeye devam et"
  },
  Event_125743_ChoiceDesc2 = {
    Text = "[Ignore It] Ayrıl"
  },
  Event_125743_Desc = {
    Text = "\"Kuklalar girişleri için sıraya giriyor, kaderin büyük ağına adım atıyor.\""
  },
  Event_125743_Name = {
    Text = "Son Kehanet"
  },
  Event_125744_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125744_Desc = {
    Text = "Uçurumun girdabına bakarsınız, kargaların kehanetini duymaya çalışırsınız.\nAma hiçbir şey söylemezler. Bakışlarınız altında uçurum çözülür.\nSürü sahnenin sonuna doğru kaybolur—gitmeniz gereken yere."
  },
  Event_125744_Name = {
    Text = "Kargaların Uçurumu"
  },
  Event_125745_ChoiceDesc1 = {
    Text = "[Agree] 2 Kart Kaldır"
  },
  Event_125745_ChoiceDesc2 = {
    Text = "[Disagree] Lanetli Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_125745_ChoiceDesc3 = {
    Text = "[Leave] Arg1 Kara Mühür al"
  },
  Event_125745_Desc = {
    Text = "Sahne perdesi rüzgârda titreşiyor. Düşmüş bir cesetten sızan siyah çamurun arasında bir kelebek kümesi fark ediyorsun.\n\"Gerçek sanat her zaman çözünmede açar... öyle değil mi, Koruyucu?\"\nDansçının cesedi sana gülümsüyor. Kanat çırpışlarını duyuyorsun."
  },
  Event_125745_Name = {
    Text = "Çözünmede Açan Çiçek"
  },
  Event_125746_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125746_Desc = {
    Text = "Safsata seni asla yolundan çeviremez. Yürüdüğün yolu ve aradığın varış noktasını açıkça biliyorsun.\nDikenler içinde eriyor. Her zaman olduğu gibi yola koyuluyorsun."
  },
  Event_125746_Name = {
    Text = "Yayılan Izdırap"
  },
  Event_125747_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125747_Desc = {
    Text = "Arkana dönüyorsun, ardındaki gözleri unutmaya çalışıyorsun. Ama bedeninin artık eskisi kadar özgürce hareket etmediğini fark ediyorsun.\nBiliyorsun—o dikilen bakışlardan asla kaçamayacaksın."
  },
  Event_125747_Name = {
    Text = "Huzura Kabul"
  },
  Event_125748_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125748_Desc = {
    Text = "Saygıdan mı yoksa korkudan mı bilinmez, onu rahatsız etmeye kendinizi getiremiyorsunuz ve zarfı yerine geri koyuyorsunuz. Ayrılmak için döndüğünüzde, mektubun arkasındaki gölgelerden boğuk ama nazik bir ses yükseliyor:\n\"Beni hâlâ hatırladığınız için teşekkür ederim, Bayan Arachne...\""
  },
  Event_125748_Name = {
    Text = "İyi Geceler, Bay Edgar"
  },
  Event_125749_ChoiceDesc1 = {
    Text = "[Koruma Gücü] [(RelicConfig.Arg1)] Gümüş Kalıntı'sını edin"
  },
  Event_125749_ChoiceDesc2 = {
    Text = "[Kaçış Özgürlüğü] 1 rastgele Komut Kartı'na [(EnchantConfig.Arg1)] Mührü'nü kazı"
  },
  Event_125749_ChoiceDesc3 = {
    Text = "[Cevap Vermeyi Reddet] 50 Kara Mühür al"
  },
  Event_125749_Desc = {
    Text = "Gece Yarısı Maskeli Balo'nun likörü, sıkıca sarılan zincirler gibi zihnine sızıyor. Soğuk demir halkaların boyunca, genç bir kadının sesi bilincine musallat oluyor.\n\"Söyle bana, canım. Gerçekten hangi kaderi arzuluyorsun?\""
  },
  Event_125749_Name = {
    Text = "Kaderin Zincirleri"
  },
  Event_125750_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125750_Desc = {
    Text = "En karmaşık meseleler bile sizin elinizle çözülmek zorunda.\nYük ağırlaşıyor, ama onunla birlikte yeni ve yabancı bir güç yükseliyor."
  },
  Event_125750_Name = {Text = "Sakin"},
  Event_125751_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125751_Desc = {
    Text = "Bilinmeyen aktörler, tehlikeli adımlar. Gerçekten de kaçış tek güvenli liman.\nDönüp koşuyorsun, tiyatro perdelerini yırtarak geçiyorsun—ama kendini sahnede buluyorsun. Kuklalar elini tutuyor ve seni neşeli bir dansa çekiyor.\nKaderin sahnesinde asla bir seçenek yoktur."
  },
  Event_125751_Name = {
    Text = "Üçlü Pas"
  },
  Event_125752_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125752_Desc = {
    Text = "Şimdi film izlemenin sırası değil."
  },
  Event_125752_Name = {
    Text = "Anı Sineması"
  },
  Event_125753_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125753_Desc = {
    Text = "Yolculuğun tehlikeleri aklınıza bile gelmiyor. Çöken kaderin kırıkları arasında yürüyerek Nefraea'ya giderek yaklaşıyorsunuz.\nOna kurtuluş bahşetmek için buraya geldiniz."
  },
  Event_125753_Name = {
    Text = "Kader Ağı İçin Son Perde"
  },
  Event_125754_ChoiceDesc1 = {
    Text = "[Zarfı Oku] \"(RelicConfig.Arg1)\" Altın Kalıntısını edin, ancak \"(Skill.Arg2)\" geliştirin"
  },
  Event_125754_ChoiceDesc2 = {
    Text = "[Mektubu Oku] 3 Komut Kartından 1'ine [(EnchantConfig.Arg1)] Mührünü kazıyın"
  },
  Event_125754_ChoiceDesc3 = {
    Text = "[Put it back] 50 Kara Mühür kazan"
  },
  Event_125754_Desc = {
    Text = "Hareketleriniz yoğun örümcek ağlarını yırtar; ipekten eskimiş bir mektup düşer.\nAğırlığı, ince bir kağıdın taşıması gerekenden çok daha fazladır."
  },
  Event_125754_Name = {
    Text = "İyi Geceler, Bay Edgar"
  },
  Event_125755_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125755_Desc = {
    Text = "Karganın gözlerinden yaşlar dökülür. Gagasından kan akar. Son nefesiyle karga, senin için son kehanetini söyler."
  },
  Event_125755_Name = {
    Text = "Son Kehanet"
  },
  Event_125756_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125756_Desc = {
    Text = "\"Hehe... Hahahaha!\"\n\"Nasıl, sevgili konuğum? Kaderin tadı... kendinizi çılgınca, sonu gelmeksizin ona hasret bulacaksınız…\""
  },
  Event_125756_Name = {
    Text = "Kaderin Tadı"
  },
  Event_125757_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125757_Desc = {
    Text = "\"Sıkıcı.\" Tembel bir esneme yapıyor.\n\"Al gücünü de git kulüpte kavga et.\""
  },
  Event_125757_Name = {
    Text = "Kaderin Zincirleri"
  },
  Event_125758_ChoiceDesc1 = {
    Text = "[Kader Ağını Sabitle] 3'ten 1 İleri Dua kazan"
  },
  Event_125758_ChoiceDesc2 = {
    Text = "[Tehlikeyi Görmezden Gel] Altın Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_125758_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_125758_Desc = {
    Text = "O, zarafetin gözdesidir. O, kaderin bulunmuş çocuğudur. O, uçurumdan sürünerek çıkan, loş bir ışık kıvılcımını takip eden intikamcıdır. Şimdi herkese kurtuluş getirmek için geliyor.\nKader Ağı etrafınızda çöküyor ve çürüyor. Tiyatro sahnesinde duruyorsunuz, sizinle Nefraea arasındaki mesafe daralıyor."
  },
  Event_125758_Name = {
    Text = "Kader Ağı İçin Son Perde"
  },
  Event_125759_ChoiceDesc1 = {
    Text = "[Indifferent] [(RelicConfig.Arg1)] Gümüş Kalıntısını edin"
  },
  Event_125759_ChoiceDesc2 = {
    Text = "[Empathetic] Altın Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_125759_Desc = {
    Text = "Sahneden keskin çığlıklar yükseliyor, tek spot ışığı yalnız bir figürün üzerine düşüyor.\nSize en içten performansını sunuyor—göğsünü açarak iç organlarını her seyirciye gösteriyor.\nBu karakteri bu denli acı çektiren nedir?"
  },
  Event_125759_Name = {
    Text = "Bir Aktörün İtirafı"
  },
  Event_125760_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125760_Desc = {
    Text = "Elini sağa uzatıyorsun.\nOrada geleceğin yatıyor—en yoğun özlemin, nihai sığınağın ve eninde sonunda ulaşacağın varış noktası.\nVarlığın yalnızca öndeki güneşi kovalamaya hizmet eder."
  },
  Event_125760_Name = {
    Text = "Geçmiş, Gelecek"
  },
  Event_125761_ChoiceDesc1 = {
    Text = "[Three Points]"
  },
  Event_125761_ChoiceDesc2 = {
    Text = "[Six Points]"
  },
  Event_125761_ChoiceDesc3 = {
    Text = "[One Point]"
  },
  Event_125761_Desc = {
    Text = "Öylece çekip gidebilirdin, ama zarın zarafeti seni tamamen büyülüyor.\nArkandaki takipçileri unutarak, onu saygıyla eline alıp silindir şapkanın içine atıyorsun—"
  },
  Event_125761_Name = {
    Text = "Sokak Kumarı"
  },
  Event_125762_ChoiceDesc1 = {
    Text = "[Leave] [(RelicConfig.Arg1)] Gümüş Kalıntıyı edin"
  },
  Event_125762_Desc = {
    Text = "Takır tukur. Zarlar bardağın içinde çılgınca dans ediyor, tükenene kadar dönüyorlar.\n\n\"Neden... neden kimse kazanamıyor?!\""
  },
  Event_125762_Name = {
    Text = "Sokak Kumarı"
  },
  Event_125763_ChoiceDesc1 = {
    Text = "[Kaderi Kabul Et] 3 Komut Kartından 1'ine [(EnchantConfig.Arg1)] Mührünü kazı"
  },
  Event_125763_ChoiceDesc2 = {
    Text = "[Kadere Meydan Oku] [(Skill.Arg1)] Semptomunu geliştir ve Mühür'ü kazımaya dönüştür.(Kullanım: 1/2)"
  },
  Event_125763_Desc = {
    Text = "\"Ah, yaramaz biri. Kader her zaman merhametlidir... ama her direnişin bir bedeli vardır. Şimdi, bunu kabul etmeye hazır mısın?\""
  },
  Event_125763_Name = {
    Text = "Kaderin Kafesi"
  },
  Event_125764_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125764_Desc = {
    Text = "Etrafındaki bakışlara göz gezdiriyorsun ve selamlayarak elini kaldırıyorsun.\nYakında, onlara hikâyenin doruk noktasını sunacaksın."
  },
  Event_125764_Name = {
    Text = "Huzura Kabul"
  },
  Event_125765_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125765_Desc = {
    Text = "\"Sevgili Bayan Arachne, bugün sizin doğum gününüz. Efendi, Hanımefendi ve sizin için büyük sevinç duyuyorum. Bu güzel dünyaya hoş geldiniz. Size bu nazik ninniyi sunuyorum, bu günden itibaren kaygısız bir hayat diliyorum...\""
  },
  Event_125765_Name = {
    Text = "İyi Geceler, Bay Edgar"
  },
  Event_125766_ChoiceDesc1 = {
    Text = "[Fotoğraf Çek] 3 Komut Kartından 1'ine [(EnchantConfig.Arg1)] Mührünü kazı"
  },
  Event_125766_ChoiceDesc2 = {
    Text = "[Tekrar Değiştir] [(Skill.Arg1)] Semptomunu geliştir ve kazınacak Mührü değiştir.(Kullanım: 1/2)"
  },
  Event_125766_Desc = {
    Text = "Merceğin önünde hafif bir ürperti hissediyorsunuz. Belki şu poz daha iyi olur? Ya da bu?"
  },
  Event_125766_Name = {
    Text = "Tribün Anlık Görüntüleri"
  },
  Event_125767_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125767_Desc = {
    Text = "İçeriği görmek istiyorsunuz, ancak ekran boş. Salonda yalnızca dönen filmin sesi yankılanıyor.\nMakaralarda ne olduğunu öğrenmeniz belki de uzun zaman alacak."
  },
  Event_125767_Name = {
    Text = "Anı Sineması"
  },
  Event_125768_ChoiceDesc1 = {
    Text = "[Avoid Gaze] Rastgele bir Uyandırıcıyı Uyanışa Çağır"
  },
  Event_125768_ChoiceDesc2 = {
    Text = "[Stare] Uyanışa geçirecek bir Uyandırıcı seç, o Kartın Arithmetica Maliyetini 2 azalt, ancak [(Skill.Arg1)]yi geliştir."
  },
  Event_125768_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_125768_Desc = {
    Text = "Sahneye adım attığında, bir fısıltı dalgası duyuyorsun. Dönüyorsun; on binlerce çift göz sahnenin etrafında süzülüyor, sana bakıyor.\nGel! diyorlar. Bu enfes drama burada bitmez, değil mi?\nDans et! diyorlar. Bize bu dansın doruk noktasını getir!"
  },
  Event_125768_Name = {
    Text = "Huzura Kabul"
  },
  Event_125769_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125769_Desc = {
    Text = "Onun acısını anlamıyorsunuz, anlamaya ihtiyacınız da yok.\nTiyatroda birçok sahne var ve sahnelerde birçok kukla; siz de onlardan yalnızca birisiniz.\nYapmanız gereken daha önemli şeyler var."
  },
  Event_125769_Name = {
    Text = "Bir Aktörün İtirafı"
  },
  Event_125770_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125770_Desc = {
    Text = "Ölüm, çözünme, zamanın geçişi... Sanat acı vermek için var değildir. Güzellik yalnızca acıda bulunuyorsa, böyle bir güzellik doğmamış olmayı hak eder.\nOnları dağıtmak için vuruş yapıyorsun. Kelebekler dağılıyor, geride hüzünlü bir ceset bırakıyor."
  },
  Event_125770_Name = {
    Text = "Çözünmede Açan Çiçek"
  },
  Event_125771_ChoiceDesc1 = {
    Text = "[Listen to the Singing] 40 Kara Mühür kazan, fakat [(Skill.Arg2)] geliştir, seçmeye devam et"
  },
  Event_125771_ChoiceDesc2 = {
    Text = "[Ignore It] 25 Kara Mühür elde et ve ayrıl."
  },
  Event_125771_Desc = {
    Text = "Yolunuza çıkan dağınık kargalar bir araya geliyor. Önünüze tüneyip şarkı söylüyor, melodisi ıssız—son bir kehanet gibi."
  },
  Event_125771_Name = {
    Text = "Son Kehanet"
  },
  Event_125772_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125772_Desc = {
    Text = "Elini sola uzatıyorsun.\nOrada geçmişin yatıyor—en değerli anıların, bir zamanlar yürüdüğün yol ve eninde sonunda döneceğin yer.\nOlmuş olan her şey, sen olan her şeyi oluşturur."
  },
  Event_125772_Name = {
    Text = "Geçmiş, Gelecek"
  },
  Event_125773_ChoiceDesc1 = {
    Text = "[Fotoğraf Çek] 3 Komut Kartından 1'ine [(EnchantConfig.Arg1)] Mührünü kazı"
  },
  Event_125773_Desc = {
    Text = "Merceğin önünde hafif bir ürperti hissediyorsunuz. Belki şu poz daha iyi olur? Ya da bu?\nHâlâ kararsızsınız, ama kameranın artan sinirini hissedebiliyorsunuz."
  },
  Event_125773_Name = {
    Text = "Tribün Anlık Görüntüleri"
  },
  Event_125774_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125774_Desc = {
    Text = "Kameranın önünde bir poz veriyorsunuz—sakin, meraklı, kendini kaptırmış. Gerçek bir seyirci gibi.\nGurultu—\nDeklanşör tıklıyor. Kameranın gövdesinden siyah bir çamur fışkırıyor, tüm sahneye sıçrıyor.\nKameranın gövdesinin boş merkezinde, film hâlâ boş duruyor."
  },
  Event_125774_Name = {
    Text = "Tribün Anlık Görüntüleri"
  },
  Event_125775_ChoiceDesc1 = {
    Text = "[Accept] 3 Gümüş Kalıntıdan 1 tanesini edin"
  },
  Event_125775_ChoiceDesc2 = {
    Text = "[Flee] \"(RelicConfig.Arg1)\" ve \"(RelicConfig.Arg2)\" Gümüş Kalıntılarını edin, ancak \"(Skill.Arg3)\" iki kez gelişir"
  },
  Event_125775_Desc = {
    Text = "Tak-tak, tak-tak... Topuklar sahne tahtalarına parlak, neşeli bir çıtırtıyla vuruyor.\nOkul üniformalı iki kukla sahnede dans ediyor. Aniden adımlarını durduruyor—ve ellerini sana doğru uzatıyorlar."
  },
  Event_125775_Name = {
    Text = "Üçlü Pas"
  },
  Event_125776_ChoiceDesc1 = {
    Text = "[Izdıraba Tahammül Et] Maksimum canı Arg1 artır"
  },
  Event_125776_ChoiceDesc2 = {
    Text = "[Acıya İtiraz Et] Rastgele 1 Komut Kartı Mühür kazan: \"(EnchantConfig.Arg1)\", 1 \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_125776_Desc = {
    Text = "\"Liz'in ölümünü hiç umursamadın. Hiç kimseyi umursamadın.\"\n\"Sadece kendini önemsiyorsun... etrafındaki herkes, özgürlüğe ve huzura giden yolculuğunda birer araçtan ibaret.\"\n\"Öyle değil mi... Koruyucu?\"\nSunucunun fısıltısı kulağını tırmalıyor. Kalbini bir pençe sıkıyor; onun sözleriyle keskin bir Izdırap bedenine yayılıyor..."
  },
  Event_125776_Name = {
    Text = "Yayılan Izdırap"
  },
  Event_125777_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125777_Desc = {
    Text = "İnişe teslim olun; denizin kendi kaldırma kuvveti vardır ve kader ikiniz için yolu gösterecektir."
  },
  Event_125777_Name = {Text = "Sakin"},
  Event_125778_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125778_Desc = {
    Text = "Bu sensin. Gücün kaynağı, görevin taşıyıcısı, sadakatin tek nesnesi.\nYalnızca sana ait olan yolda ilerliyorsun."
  },
  Event_125778_Name = {
    Text = "Camdaki Yansıma"
  },
  Event_125779_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125779_Desc = {
    Text = "\"Ne yazık, sevgili konuğum. Kaderin tadı... bir daha onu tatma şansınız olmayacak...\""
  },
  Event_125779_Name = {
    Text = "Kaderin Tadı"
  },
  Event_125780_ChoiceDesc1 = {
    Text = "[Onunla Tartış] Bir Komut Kartını İmha Et ve Arg1 Kara Mühür al"
  },
  Event_125780_ChoiceDesc2 = {
    Text = "[Sessiz Kal]"
  },
  Event_125780_Desc = {
    Text = "\"Ne hüzünlü bir oyun... O zavallı kız, sevdiği kişi tarafından terk mi edildi, abla?\"\nO tanıdık seste ne delilik ne de kötülük var. Berrak ve kederli, ormandaki nazik bir dere gibi.\n\"Şarkıcı, çaresizce sürüklenen solmuş bir yaprak, kaderin insafına bırakılmış... Ne acınası bir ruh...\"\n\"Abla, eğer yazar ben olsaydım... onun için nasıl bir son yazmalıydım?\""
  },
  Event_125780_Name = {
    Text = "Oyunun Sonu"
  },
  Event_125781_ChoiceDesc1 = {
    Text = "[Onları Sev] %50 ihtimalle 125 Kara Mühür kazanın; %50 ihtimalle [(Skill.Arg2)] geliştirin"
  },
  Event_125781_ChoiceDesc2 = {
    Text = "[Explain] %75 ihtimalle 100 Kara Mühür kazanın; %25 ihtimalle [(Skill.Arg2)] geliştirin"
  },
  Event_125781_ChoiceDesc3 = {
    Text = "[Gerçeği Gör] 50 Kara Mühür kazanın"
  },
  Event_125781_Desc = {
    Text = "Canavarı barın arka sokağına kadar takip ederken, silueti kaybolur. Bir grup kara kedi yolunuzu keser.\n\"Hey, sen.\" Bir kara kedi patisini yalayarak size doğru bakar.\n\"Bizim bölgemizde ne yapıyorsun?\""
  },
  Event_125781_Name = {
    Text = "Değişen Biçimler"
  },
  Event_125782_ChoiceDesc1 = {
    Text = "[Geçmişi Kucakla] \"(RelicConfig.Arg1)\" Altın Kalıntısını edin, ancak \"(Skill.Arg2)\" gelişir"
  },
  Event_125782_ChoiceDesc2 = {
    Text = "[Geleceği Karşıla] 3 Altın Kalıntıdan 1 tanesini edin, ancak [(Skill.Arg1)] Semptomu gelişir"
  },
  Event_125782_ChoiceDesc3 = {
    Text = "[Leave] [(RelicConfig.Arg1)] Gümüş Kalıntıyı edin"
  },
  Event_125782_Desc = {
    Text = "Nefraea'nın varlığı ipleri bozdu. Çarpıtılmış kaderin içinde iki bulanık hayalet görüyorsun.\nBiri senin geçmişin; diğeri, geleceğin. Onlara doğru yürüyorsun ve elini uzatıyorsun..."
  },
  Event_125782_Name = {
    Text = "Geçmiş, Gelecek"
  },
  Event_125855_ChoiceDesc1 = {
    Text = "[Perceive] 1 Kalıntıyı [(RelicConfig.Arg1)] Altın Kalıntısına yükselt"
  },
  Event_125855_ChoiceDesc2 = {
    Text = "[Stare] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_125855_ChoiceDesc3 = {
    Text = "[Ignore] 25 Kara Mühür al"
  },
  Event_125855_Desc = {
    Text = "Kasalim sokaklarında, bir kristal dükkânının göz kamaştırıcı parıltısı sizi içeri çeker. Vitrin önünde durur ve Gümüş Çekirdek şeklinde bir kristal alırsınız."
  },
  Event_125855_Name = {
    Text = "Kristalin Sırrı"
  },
  Event_125856_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125856_Desc = {
    Text = "Gözlerinizi kapatır, onu dikkatle hissedersiniz.\nBilincinizdeki bir ışık parıltısı titreşir, sanki size bir şey anlatmak ister gibi..."
  },
  Event_125856_Name = {
    Text = "Kristalin Sırrı"
  },
  Event_125857_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125857_Desc = {
    Text = "Kadere karşı herhangi bir direniş ya da onu kurcalama çabası nafile. Sessizce gözlerini kapatıyorsun, kaderin seni götürmesi gereken yere götürmesine izin veriyorsun."
  },
  Event_125857_Name = {
    Text = "Kaderin Tuzağı"
  },
  Event_125858_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125858_Desc = {
    Text = "\"Duygu, varoluşun anlamıdır. Seçiminden asla pişman olmayasın.\""
  },
  Event_125858_Name = {
    Text = "Seçimin Bedeli"
  },
  Event_125859_ChoiceDesc1 = {
    Text = "[Emotion] Arg1 Can yenile"
  },
  Event_125859_ChoiceDesc2 = {
    Text = "[Reason] 1 rastgele Komut Kartı'na [(EnchantConfig.Arg1)] Mührü'nü kazı"
  },
  Event_125859_ChoiceDesc3 = {
    Text = "[Refuse to Choose] 25 Kara Mühür al"
  },
  Event_125859_Desc = {
    Text = "Sahnenin üzerinde bir terazi belirir.\n\"Beyin ve kalp, akıl ve duygu, gri ve kırmızı... seçimden kaçamayız; bu bizim kaderimiz.\"\n\"Sahnenin sonu çoktan çizildi. Şimdi, bu gösterinin yürüyeceği yolu seç.\""
  },
  Event_125859_Name = {
    Text = "Seçimin Bedeli"
  },
  Event_125860_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125860_Desc = {
    Text = "\"Yukarı bakma. Buradan ayrıl.\"\nKaderin sesini duyarsınız. Gökyüzüne bakmayı çok istemenize rağmen, onun haklı olduğunu bilirsiniz."
  },
  Event_125860_Name = {
    Text = "Yukarı Bakmak"
  },
  Event_125861_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125861_Desc = {
    Text = "Kaderi asla kabul etmezsin. Esareti asla kabul etmezsin.\nVar gücünle çırpınırsın. Bir güvenin uzuvlarını feda ettikten sonra, sonunda kaçmayı başarırsın..."
  },
  Event_125861_Name = {
    Text = "Kaderin Tuzağı"
  },
  Event_125862_ChoiceDesc1 = {
    Text = "[Friendship] 50 Kara Mühür al"
  },
  Event_125862_ChoiceDesc2 = {
    Text = "[Help] 75 Kara Mühür al, ancak [(Skill.Arg2)] Semptomu gelişir"
  },
  Event_125862_Desc = {
    Text = "Barın arka sokağında, o kara kedilerle bir kez daha karşılaşıyorsun.\n\"Duydum. O siyah balçıklar bizim kılığımıza girip sana epey sorun çıkarmış.\"\n\"Bir özür olarak söyle bana—ne istiyorsun?\"\nKara kediler bacaklarının etrafında iki kez dönüyor, başlarını kaldırıp sana bakıyorlar."
  },
  Event_125862_Name = {
    Text = "İlk Karşılaşmanın Hediyesi"
  },
  Event_125863_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125863_Desc = {
    Text = "Kaba kuvvet kaderi çözemez, ama belki bilgelik çözebilir?\nAğı yakından inceliyorsun, içinde kaderin tasarımına dair bir iplik arıyorsun..."
  },
  Event_125863_Name = {
    Text = "Kaderin Tuzağı"
  },
  Event_125864_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125864_Desc = {
    Text = "Eğilir, ona dikkatle bakarsınız.\nGözlerinizdeki bir ışık parıltısı titreşir, sanki size bir şey anlatmak ister gibi..."
  },
  Event_125864_Name = {
    Text = "Kristalin Sırrı"
  },
  Event_125865_ChoiceDesc1 = {
    Text = "[Struggle] 3 rastgele Komut Kartı'ndan 1'ini İmha Et ve 75 Kara Mühür al"
  },
  Event_125865_ChoiceDesc2 = {
    Text = "[Rest] 3 Komut Kartı'ndan 1'ini kopyala ve 25 Kara Mühür al"
  },
  Event_125865_ChoiceDesc3 = {
    Text = "[Rest] 50 Kara Mühür al"
  },
  Event_125865_Desc = {
    Text = "Tanıdık bir his seni kuşatıyor. Ama bu sefer, o yapışkan dokunuş ve çaresizlik içgüdüsü daha yoğun, daha öldürücü.\nGüve örümcek ağına düşer. Ve sen çoktan sahneye adım attın."
  },
  Event_125865_Name = {
    Text = "Kaderin Tuzağı"
  },
  Event_125866_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125866_Desc = {
    Text = "\"Akıl, varoluşun anlamıdır. Seçiminden asla pişman olmayasın.\""
  },
  Event_125866_Name = {
    Text = "Seçimin Bedeli"
  },
  Event_125867_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125867_Desc = {
    Text = "Merak alevlenir. Kalabalığa karışır ve onlar gibi başınızı kaldırırsınız.\nOrada hiçbir şey yok, ama nedense gözlerinizi ayırmak istemezsiniz. Böyle izlemek istersiniz—sonsuza dek izlemek..."
  },
  Event_125867_Name = {
    Text = "Yukarı Bakmak"
  },
  Event_125868_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125868_Desc = {
    Text = "\"Seçimi reddetmek de başlı başına bir seçimdir—bu kaderin laneti. Yaptığın seçimden asla pişman olmayasın.\""
  },
  Event_125868_Name = {
    Text = "Seçimin Bedeli"
  },
  Event_125869_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125869_Desc = {
    Text = "\"Artık o senin.\"\nKediler bacağınıza sürtünüyor ve kısa sürede kayboluyor.\nKayboldukları yerde bir hediye sizi bekliyor."
  },
  Event_125869_Name = {
    Text = "İlk Karşılaşmanın Hediyesi"
  },
  Event_125870_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125870_Desc = {
    Text = "\"Artık o senin.\"\nKediler bacağınıza sürtünüyor ve kısa sürede kayboluyor.\nKayboldukları yerde bir hediye sizi bekliyor."
  },
  Event_125870_Name = {
    Text = "İlk Karşılaşmanın Hediyesi"
  },
  Event_125871_ChoiceDesc1 = {
    Text = "[Başını Kaldır] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_125871_ChoiceDesc2 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_125871_Desc = {
    Text = "Kakofoni bir anlığına kaybolur. Sokaktaki kalabalıklar sessizliğe gömülür ve başlarını gökyüzüne kaldırır."
  },
  Event_125871_Name = {
    Text = "Yukarı Bakmak"
  },
  Event_129176_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129176_Name = {
    Text = "Unutuş Bölüm 1@"
  },
  Event_129177_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129177_Name = {
    Text = "Astral Hüküm Bölüm 1@"
  },
  Event_129178_ChoiceDesc1 = {
    Text = "[Indicate Direction] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_129178_ChoiceDesc2 = {
    Text = "[Birlikte Dua Et] 3'ten 1 seçimli Mühür iki kez kazan"
  },
  Event_129178_Desc = {
    Text = "Piyano ve orgun sesleri, loş rüzgârın içinde birbirine karışır. Sanki büyülü ezgiler, ıssız sokaklarda sürüklenip dolaşmaktadır.\nAdsız bir rahibe, müziğin ortasında dua eder.\n \"Basit dualar için görkemli törenlere gerek yok. Ulu Baba, bir zamanlar bize bağnaz öğretilerini bahşettiği gibi, bize yine umut tohumları ekecektir.\""
  },
  Event_129178_Name = {
    Text = "Organ Duası"
  },
  Event_129179_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129179_Name = {
    Text = "Astral Hüküm Bölüm 1@"
  },
  Event_129180_ChoiceDesc1 = {
    Text = "[Face It] Lanetli Kalıntı \"(RelicConfig.Arg1)\"yı elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_129180_ChoiceDesc2 = {
    Text = "[Surrender] 3 Komut Kartı arasından 1 tanesini seçerek iki kez Mühür kazı: [(EnchantConfig.Arg1)]"
  },
  Event_129180_ChoiceDesc3 = {
    Text = "[Run Away] 50 Kara Mühür al"
  },
  Event_129180_Desc = {
    Text = "Birkaç balmumu heykel bloğu yolunu kapatıyor.\nEğri büğrü ve kaba görünüyorlar; Rogers’tan beklenen ustalığa hiç benzemiyorlar.\n“Emirler... efendinin emirleri...”"
  },
  Event_129180_Name = {Text = "Taslak"},
  Event_129181_ChoiceDesc1 = {
    Text = "[Quit Thinking] Lanetli Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_129181_ChoiceDesc2 = {
    Text = "[İlhamı Yakala] Rastgele 1 Komut Kartı Mühür kazanır: [(EnchantConfig.Arg1)] iki kez"
  },
  Event_129181_Desc = {
    Text = "Liman Saldırı altında, gizemli bir yük gemisi girip çıkıyor ve yüzgeçli 'yeni arkadaşlar' dolaşıyor... Bu ince ince hazırlanmış bir tuzak mı? Yoksa yine beklenmedik ölçüde tehlikeli bir yolculuk mu?\nGerçeklik ve akıl birbirini çekiştirip büküyor, zihinden sayısız İlham ve düşünce kabarıyor."
  },
  Event_129181_Name = {
    Text = "İlham Patlaması"
  },
  Event_129182_ChoiceDesc1 = {
    Text = "[Join] \"(Skill.Arg1)\" iki kez geliştir, rastgele 1 Komut Kartına Kazıma: \"(EnchantConfig.Arg2)\" iki kez"
  },
  Event_129182_ChoiceDesc2 = {
    Text = "[Dispel] \"(Skill.Arg1)\" iki kez geliştir, rastgele 1 Komut Kartına Kazıma: \"(EnchantConfig.Arg2)\" iki kez"
  },
  Event_129182_ChoiceDesc3 = {
    Text = "[Disregard] 3 Komut Kartı arasından 1 tanesini seçerek Kazıma: [(EnchantConfig.Arg1)] iki kez"
  },
  Event_129182_Desc = {
    Text = "Uzaklardan gelen hafif bir kemik borusu sesi duyarsın.\nSiyah çamurdan, sesin çekimine kapılmış sıçan sürüleri çıkar; kurumuş nehir yatağında yatan isimsiz cesedi kemirmeye başlar.\nBir çember oluştururlar—merkezde içi boş kalıntı beden, çevresinde ise unutuş yasasıyla yönetilen yeni bir krallığın sınırları vardır.\nVe sen, bu krallığın eşiğinde durmaktasın."
  },
  Event_129182_Name = {
    Text = "Sürgün Krallığı"
  },
  Event_129183_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129183_Name = {
    Text = "Unutuş Bölüm 5@"
  },
  Event_129184_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129184_Name = {
    Text = "Unutuş Bölüm 8@"
  },
  Event_129185_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129185_Name = {
    Text = "Unutuş Bölüm 1@"
  },
  Event_129186_ChoiceDesc1 = {
    Text = "[Portreyi Kurtar] 3 Komut Kartı arasından 1 tanesini seçerek Kazıma: \"(EnchantConfig.Arg1)\" iki kez, \"(Skill.Arg2)\" iki kez geliştir"
  },
  Event_129186_ChoiceDesc2 = {
    Text = "[Boşluğu Kabul Et] 3 Komut Kartı arasından 1 tanesini seçerek Kazıma: \"(EnchantConfig.Arg1)\" iki kez, \"(Skill.Arg2)\" iki kez geliştir"
  },
  Event_129186_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_129186_Desc = {
    Text = "Pickman’ın Armağanı’nın önünde durursun.\nBu, kanla boyanmış bir portredir; zifiri siyah alevler sessizce yanmaktadır.\nTablodaki figürün boş göz çukurlarından şunu görürsün—\nKendi Anıların kabarıp yanmakta, uzayıp bükülmekte, parıldamaktadır; sanki biçimsiz bir ateş zihninin koridorlarını yalayıp geçmektedir. Sersemlik içinde bir ses duyarsın.\n \"Pişirme vakti geldi. Isı tam kıvamında.\"\nBu, bizzat senin imal ettiğin anının ta kendisidir—alevlerin içinde kıvranır ve burkulursun."
  },
  Event_129186_Name = {
    Text = "Yanan Portre"
  },
  Event_129187_ChoiceDesc1 = {
    Text = "[Ne Kadar Bedel Ödemeye Razısınız?] Rastgele 1 Kartın Mühür kalitesini iki kez artır"
  },
  Event_129187_ChoiceDesc2 = {
    Text = "[Onlara Son Kullanma Tarihi Geçmiş Bir Kan Mary Ismarla] 3 Komut Kartı arasından 1 tanesini seçerek iki kez Mühür kazı: \"(EnchantConfig.Arg1)\", iki kez \"(Skill.Arg2)\" geliştir"
  },
  Event_129187_Desc = {
    Text = "\"Hoş Geldin, kıymetli konuğum. Çekinmeden seç; bu göz kamaştırıcı çeşitliliğin hepsi seni beklemek için var.\"\n\"Şey, rahatsız ettim kusura bakmayın, sorabilir miyim... Siz Leydi Nergis'in ikiz kız kardeşi misiniz?\"\n\"Ben bizzat Leydi Nergis'im. Sorabilir miyim, bugün sizi buraya getiren nedir...?\"\n\"Affedersiniz, affedersiniz, eskisinden bile daha büyüleyici olmuşsunuz. Sizi tanıyamadım. Hatırlıyor musunuz? Yirmi yıl önce, barımdan bir ucubeyi kovmuştunuz... Dün, o karabasan geri döndü. Barı ele geçirdi, yanında da sayısız türdeşini getirdi...\"\""
  },
  Event_129187_Name = {
    Text = "Anı Parçası: Eski Rüyanın Yeniden Belirişi"
  },
  Event_129188_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129188_Name = {
    Text = "Astral Hüküm Bölüm 3@"
  },
  Event_129189_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129189_Name = {
    Text = "Unutuş Bölüm 8@"
  },
  Event_129190_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129190_Name = {
    Text = "Unutuş Bölüm 1@"
  },
  Event_129191_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129191_Name = {
    Text = "Unutuş Bölüm 6@"
  },
  Event_129192_ChoiceDesc1 = {
    Text = "[Grasp the Spark] Azami HP’yi Arg1 kadar artır"
  },
  Event_129192_ChoiceDesc2 = {
    Text = "[İç Dünyayla Yüzleş] Rastgele 2 Komut Kartı Mühür kazanır: \"(EnchantConfig.Arg1)\" iki kez, 2 \"(Skill.Arg2)\" iki kez enfekte et"
  },
  Event_129192_Desc = {
    Text = "Bu büyük avda, Golyat’ın Av’ı karanlıktaki bir canavar gibidir; tüm umudu Her Şeyi Yutmak için nişan alır. Ne var ki bu amansız takip seni Dondurmaz; tam tersine, derinlerinde bir kıvılcım çakar, göğsünde Yayılma ile daha da hararetle yanar."
  },
  Event_129192_Name = {
    Text = "Işık Avcısı"
  },
  Event_129193_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129193_Name = {
    Text = "Unutuş Bölüm 6@"
  },
  Event_129194_ChoiceDesc1 = {
    Text = "[Önceki Yolu Oku] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_129194_ChoiceDesc2 = {
    Text = "[Write Your Own Path] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_129194_ChoiceDesc3 = {
    Text = "[Stare into Darkness] 25 Kara Mühür al"
  },
  Event_129194_Desc = {
    Text = "Gizli Diyar’ı tek başına keşfediyor olsaydın, yolundan şu anki kadar emin olamazdın.\nGizli Diyar’daki ayak izleri üç yola ayrılmış; atılan her adım, görünmeyen bir geleceği yazıyor."
  },
  Event_129194_Name = {
    Text = "Çıkış Yolu"
  },
  Event_129195_ChoiceDesc1 = {
    Text = "[Hatayı Belirt] 3 Komut Kartı arasından 1 tanesini seçerek iki kez Mühür kazı: \"(EnchantConfig.Arg1)\", iki kez \"(Skill.Arg2)\" geliştir"
  },
  Event_129195_ChoiceDesc2 = {
    Text = "[Listen to the Performance] 50 veya daha fazla Aliemus’a sahip her Uyandırıcı için 15 Kara Mühür al."
  },
  Event_129195_ChoiceDesc3 = {
    Text = "[Leave] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_129195_Desc = {
    Text = "Balmumu Heykel Oğlan piyanonun başına oturmuş, alıştırma yapıyor.\nÖğretmeni—o da bir Balmumu Heykel—hemen yanında ona rehberlik ediyor.\n133, 355, 244...\nYanlış, her nota yanlış."
  },
  Event_129195_Name = {
    Text = "Piyano Dersi"
  },
  Event_129196_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129196_Name = {
    Text = "Unutuş Bölüm 5@"
  },
  Event_129197_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129197_Name = {
    Text = "Astral Hüküm Bölüm 4@"
  },
  Event_129198_ChoiceDesc1 = {
    Text = "[Kederi Dinle] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\" iki kez, \"(Skill.Arg2)\" iki kez enfekte et"
  },
  Event_129198_ChoiceDesc2 = {
    Text = "[Hear Joy] 50 veya daha fazla Aliemus’a sahip her Uyandırıcı için 15 Kara Mühür al."
  },
  Event_129198_ChoiceDesc3 = {
    Text = "[Leave] 3'ten 1 seçimli Mühür iki kez kazınır"
  },
  Event_129198_Desc = {
    Text = "Melodik, lirik, neşeli, hüzünlü... Ezgi, kaynağı belirsiz biçimde Gizli Diyar'da yankılanıyor.\nBu, hayalet geminin ses sisteminden gelen bir senfoni mi, yoksa Gizli Diyar'a zincirlenmiş bir gece yarısı Rapsodi'si mi?"
  },
  Event_129198_Name = {
    Text = "İsimsiz Yankı"
  },
  Event_129199_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129199_Name = {
    Text = "Astral Hüküm Bölüm 1@"
  },
  Event_129200_ChoiceDesc1 = {
    Text = "[Open the Envelope] Altın Kalıntı \"(RelicConfig.Arg1)\" edin, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_129200_ChoiceDesc2 = {
    Text = "[Read] 3 Komut Kartı arasından 1 tanesini seçerek Kazıma: [(EnchantConfig.Arg1)] iki kez"
  },
  Event_129200_ChoiceDesc3 = {
    Text = "[Put it back] 50 Kara Mühür kazan"
  },
  Event_129200_Desc = {
    Text = "İhmal edilmiş bir köşede, geride bırakılmış bir mektup duruyor.\nMektuptaki birçok kelime artık seçilemiyor, ama bir kelime kalmış. Kâğıdı delip geçiyor.\nO kelime “Anne”."
  },
  Event_129200_Name = {
    Text = "Fading Longing"
  },
  Event_129201_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129201_Name = {
    Text = "Astral Hüküm Bölüm 4@"
  },
  Event_129202_ChoiceDesc1 = {
    Text = "[Dikkatlice Dinle] 3 Komut Kartından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\" iki kez, \"(Skill.Arg2)\" iki kez enfekte et"
  },
  Event_129202_ChoiceDesc2 = {
    Text = "[Cover Ears] 50 veya daha fazla Aliemus’a sahip her Uyandırıcı için 15 Kara Mühür al."
  },
  Event_129202_ChoiceDesc3 = {
    Text = "[Examine] 3'ten 1 seçimli Mühür iki kez kazan"
  },
  Event_129202_Desc = {
    Text = "Kalıntı bedenin katına girdiğinde, boş ve terk edilmiş Fabrika’da birden melodik bir çan sesi yankılanır. Piyanonun berrak tınısı, paslanmış çelik harabelerle keskin bir tezat oluşturur."
  },
  Event_129202_Name = {
    Text = "Esrarengiz Dizi"
  },
  Event_129203_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129203_Name = {
    Text = "Unutuş Bölüm 3@"
  },
  Event_129204_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129204_Name = {
    Text = "Unutuş Bölüm 6@"
  },
  Event_129205_ChoiceDesc1 = {
    Text = "[Spare Her] Lanetli Kalıntı \"(RelicConfig.Arg1)\"yı elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_129205_ChoiceDesc2 = {
    Text = "[Ona Yardım Et] 3 Komut Kartı arasından 1 tanesini seçerek iki kez Mühür kazı: [(EnchantConfig.Arg1)]"
  },
  Event_129205_ChoiceDesc3 = {
    Text = "[Walk My Own Path] 50 Kara Mühür Al"
  },
  Event_129205_Desc = {
    Text = "Üç karanlık, gelip geçici siluet yolunu kesiyor.\n \"Onu bırakabilirsin,\" diyor, D-balçık damlayan bir oyuncak ayı tutan, \"o sadece ürkek, kötü değil. Kimseye zarar vermek istemiyor.\"\n \"Ona yardım edebilirsin,\" diyor, güzelce paketlenmiş bir Şeker torbası tutan, \"onun yapamadığını sen yapabilirsin. Bütün bunlara bir son verebilirsin.\"\n \"Bizi dinlemek zorunda değilsin,\" diyor, elleri boş olan, \"senin kendine ait bir yolun var.\""
  },
  Event_129205_Name = {
    Text = "Çatallanan Patikalar"
  },
  Event_129206_ChoiceDesc1 = {
    Text = "[Feed the Rats] Gümüş Kalıntı [(RelicConfig.Arg1)] kazan, 1 Semptom geliştir"
  },
  Event_129206_ChoiceDesc2 = {
    Text = "[Fareleri Kovala] 3 Komut Kartı arasından 1 tanesine \"(EnchantConfig.Arg1)\" Mühürünü iki kez kazı, ancak \"(Skill.Arg2)\" iki kez gelişir."
  },
  Event_129206_ChoiceDesc3 = {
    Text = "[Ignore the Rats] 25 Kara Mühür kazan"
  },
  Event_129206_Desc = {
    Text = "Bu gemideki her şey Zaman Döngüsü’ne hapsolmuş.\nBurada hayatta kalmak için debelenen o iğrenç, tüylü küçük yaratıklar bile kaderlerinden kaçamaz.\nDöngü üstüne döngü, gözlerinin gördüğü her şeyi Yutarlar, ama açlıkları asla dinmez.\n \"Çok... açız...\"\nSürü sürü sıçan, hastalıklı, delici Çığlıklar salar.\nBitmek bilmeyen döngüler onları Açlıktan Kıvranan ve çılgın bırakmıştır—bir şey yemeliler.\nŞimdi. Hemen."
  },
  Event_129206_Name = {
    Text = "Aç Fare Sürüsü"
  },
  Event_129207_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129207_Name = {
    Text = "Unutuş Bölüm 8@"
  },
  Event_129208_ChoiceDesc1 = {
    Text = "[Beyne Dokun] Rastgele 1 Komut Kartına Kazıma: [(EnchantConfig.Arg1)] iki kez"
  },
  Event_129208_ChoiceDesc2 = {
    Text = "[Touch the Heart] Maksimum HP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_129208_Desc = {
    Text = "Hiçbir fısıltının oyalanmadığı, sessiz, gri salona adım atarsın ve karanlık sise karışmış solgun bir terazi belirir.\nSolda, göl kadar sakin bir beyin vardır; gümüş beyazı kıvrımları hafifçe parıldar; sağda ise, kızıl bir kalp sıcak sıcak buhar salar.\nAnsızın, burnuna hoş bir koku gelir. Doymak bilmez bir arzu içinde kabarır, aklın Onun sınırsız Karanlığı tarafından sıkıştırılır.\nElini uzatırsın."
  },
  Event_129208_Name = {
    Text = "Açlık Oyunları"
  },
  Event_129209_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129209_Name = {
    Text = "Unutuş Bölüm 4@"
  },
  Event_129210_ChoiceDesc1 = {
    Text = "[Gölgeyi Kes] 3 Komut Kartından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\" iki kez, \"(Skill.Arg2)\" iki kez enfekte et"
  },
  Event_129210_ChoiceDesc2 = {
    Text = "[Embriyoyu Ezdur] 3 Komut Kartından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\" iki kez, \"(Skill.Arg2)\" iki kez enfekte et"
  },
  Event_129210_ChoiceDesc3 = {
    Text = "[Close Your Eyes] 25 Kara Mühür al"
  },
  Event_129210_Desc = {
    Text = "Sersemlik içinde, Aram'da bir zamanlar tanıştığın insanların sana yaklaştığını görüyorsun.\nGülüyorlar ve seni içmeye, dans etmeye, ziyafetten zevk almaya davet ediyorlar.\nSonra etleri tabaka tabaka soyulmaya başlıyor, yere düşüp kıvranarak yeni Embriyolara dönüşüyor.\nSana ellerini uzatıyorlar, et ve yeniden doğuş kutlamasına katılmanı istiyorlar."
  },
  Event_129210_Name = {
    Text = "Geçmişin Gölgeleri"
  },
  Event_129211_ChoiceDesc1 = {
    Text = "[Feed Them] Gümüş Kalıntı [(RelicConfig.Arg1)]i elde et, fakat 3 Semptomdan 1’ini geliştir."
  },
  Event_129211_ChoiceDesc2 = {
    Text = "[Aldırma] 3 Komut Kartından 1 tanesini seçerek Kazıma: \"(EnchantConfig.Arg1)\" iki kez, \"(Skill.Arg2)\" iki kez geliştir"
  },
  Event_129211_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_129211_Desc = {
    Text = "Sakinler gelir gider, ama fare sürüsü sonsuza dek uzayıp gidiyor.\nİnsanlarla kıyaslandığında, bu kalenin gerçek “yerlileri” onlardır.\nYine de insanların içeri taşınmasına hiçbir itirazları yoktur.\nÇünkü o yumuşak ve beyaz, çirkin şeyler onlara aynı derecede yumuşak ve beyaz, çirkin şeyler yedirecektir.\n“Ve sen, çirkin şey, hangi türe aitsin?”"
  },
  Event_129211_Name = {
    Text = "Citadel's Secret"
  },
  Event_129212_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129212_Name = {
    Text = "Unutuş Bölüm 5@"
  },
  Event_129213_ChoiceDesc1 = {
    Text = "[Discern Man's Voice] 3 Komut Kartından 1’ini kopyala."
  },
  Event_129213_ChoiceDesc2 = {
    Text = "[Kadının Sesini Ayırt Et] 3 Komut Kartından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\" iki kez, \"(Skill.Arg2)\" iki kez enfekte et"
  },
  Event_129213_ChoiceDesc3 = {
    Text = "[Discern the Elder's Voice] 25 Kara Mühür al."
  },
  Event_129213_Desc = {
    Text = "Karanlık bir bataklıkta yapayalnız duruyorsun.\nPusun arasından, gelgitler gibi üst üste binen kaotik mırıltılar duyuyorsun—bazıları titreyen yaşlılardan, bazıları gevezelik eden çocuklardan, bazıları endişeli kadınlardan ve bazıları isimsiz bir dehşetin pençesindeki erkeklerden..."
  },
  Event_129213_Name = {
    Text = "Last Words' Whisper"
  },
  Event_129214_ChoiceDesc1 = {
    Text = "[Dikkatlice Bak] 3 seçenekten 1 Mühür kazıma işlemini iki kez gerçekleştir"
  },
  Event_129214_ChoiceDesc2 = {
    Text = "[Afişi Yırt] Rastgele 1 Komut Kartına iki kez Mühür kazı: \"(EnchantConfig.Arg1)\", iki kez \"(Skill.Arg2)\" geliştir"
  },
  Event_129214_Desc = {
    Text = "Balmumu Müzesi’nde sıkça görülen bir şamdan.\nUğursuz turuncu parıltının ışığında, duvarda el çizimi bir afiş fark edersin."
  },
  Event_129214_Name = {
    Text = "Karanlıktaki Kahkaha"
  },
  Event_129215_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129215_Name = {
    Text = "Unutuş Bölüm 4@"
  },
  Event_129216_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129216_Name = {
    Text = "Unutuş Bölüm 7@"
  },
  Event_129217_ChoiceDesc1 = {
    Text = "[Stare] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_129217_ChoiceDesc2 = {
    Text = "[Ignore] 3'ten 1 seçimli Mühür iki kez kazan"
  },
  Event_129217_Desc = {
    Text = "Aramlılar kum fırtınasının içinde diz çöker.\nFırtına bedenlerini kamçılar, kum onların Sadık Kalplerini yutar.\nDönen toz bulutlarının içinde, sayısız dev göz, bükülmüş diyara tepeden bakıyormuş gibi görünür."
  },
  Event_129217_Name = {Text = "Toz Devi"},
  Event_129218_ChoiceDesc1 = {
    Text = "[Kelebekleri Kovala] Rastgele 1 Komut Kartına Kazıma: \"(EnchantConfig.Arg1)\" iki kez, \"(Skill.Arg2)\" iki kez geliştir"
  },
  Event_129218_ChoiceDesc2 = {
    Text = "[Dileği Dinle] 3 Komut Kartı arasından 1 tanesini seçerek Kazıma: [(EnchantConfig.Arg1)] iki kez"
  },
  Event_129218_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_129218_Desc = {
    Text = "Küçük kelebek birçok rüya taşır.\nBu rüyalar çiçek denizine, koğuşa ve @2'nin kan ve etiyle dolu sunağa saçılır.\nSonunda, bağını bekledi; küçücük, minicik dileğini dinlemeye istekli olup olmadığınızı bilmeden."
  },
  Event_129218_Name = {
    Text = "Kelebek Rüyası"
  },
  Event_129219_ChoiceDesc1 = {
    Text = "[Rehberi Takip Et] 3 Komut Kartı arasından 1 tanesine \"(EnchantConfig.Arg1)\" Mühürünü iki kez kazı, ancak \"(Skill.Arg2)\" iki kez gelişir."
  },
  Event_129219_ChoiceDesc2 = {
    Text = "[Rehberi Yoksay] 3 Komut Kartı arasından 1 tanesine \"(EnchantConfig.Arg1)\" Mühürünü iki kez kazı, ancak \"(Skill.Arg2)\" iki kez gelişir."
  },
  Event_129219_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_129219_Desc = {
    Text = "Şölen başlamıştır.\nRuhani alevler ve kana bulanmış lütuflar arasında sayısız mümin yaşayan meşalelere dönüşmüştür—\nEterik ruhlar, yol gösteren periler gibi etrafında saçılır, ışıldar, senin seçimini bekler."
  },
  Event_129219_Name = {Text = "Ruh Feneri"},
  Event_129220_ChoiceDesc1 = {
    Text = "[Zili Duymazdan Gel] 3'ten 1 seçimli İleri Dua iki kez kazınır"
  },
  Event_129220_ChoiceDesc2 = {
    Text = "[Pick up the Receiver] Altın Kalıntı \"(RelicConfig.Arg1)\" elde et, ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_129220_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_129220_Desc = {
    Text = "Çalmamış olması gerekirdi—tuvalin arkasına kıvrılmış telefonun.\nKordon, paslanmış bir göbek bağı gibi, hantal makinenin gövdesine dolanmış; sanki senin zihninden uzanıyormuş gibi.\nTitreşimin frekansını dikkatle ayırt ediyorsun; tedirgin edici ses, Pickman’ın sürreal sanatını andırıyor."
  },
  Event_129220_Name = {
    Text = "Cevapsız Arama"
  },
  Event_129221_ChoiceDesc1 = {
    Text = "[Hepimiz İyiyiz] 3 Komut Kartı arasından 1 tanesini seçerek iki kez Mühür kazı: \"(EnchantConfig.Arg1)\", iki kez \"(Skill.Arg2)\" geliştir"
  },
  Event_129221_ChoiceDesc2 = {
    Text = "[Sen Kimsin?] 3 Komut Kartı arasından 1 tanesini seçerek iki kez Mühür kazı: \"(EnchantConfig.Arg1)\", iki kez \"(Skill.Arg2)\" geliştir"
  },
  Event_129221_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_129221_Desc = {
    Text = "Daktilo aniden mürekkep fışkırtır, göz tırmalayan sayıda ünlem işaretiyle.\n\"Bebek, iyi misin??? Neden Koruyucu da ortadan kaybolmuşken sen de yok oldun??? Lütfen, eğer güvendeysen bir mesaj yolla!!! William'ın saçları daha fazla beklersek dökülecek!!!\""
  },
  Event_129221_Name = {
    Text = "Acil Mektup"
  },
  Event_129222_ChoiceDesc1 = {
    Text = "[Cut the Red Ribbon] Bir Komut Kartı’nı İmha Et ve Arg1 Kara Mühür al."
  },
  Event_129222_ChoiceDesc2 = {
    Text = "[Resist] Bir Komut Kartı’nı kopyala, ancak [(Skill.Arg1)] Semptomu’nu geliştir."
  },
  Event_129222_ChoiceDesc3 = {
    Text = "[Ramona'yı Çağır] 3 Komut Kartından 1 tanesini seçerek Mühür kazan: [(EnchantConfig.Arg1)] iki kez"
  },
  Event_129222_Desc = {
    Text = "Casiah kırmızı bir ipek kurdele fırlatır; kurdele anında evrak çantanıza dolanır."
  },
  Event_129222_Name = {
    Text = "Entangled Silk"
  },
  Event_129223_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129223_Name = {
    Text = "Unutuş Bölüm 6@"
  },
  Event_129224_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129224_Name = {
    Text = "Astral Hüküm Bölüm 3@"
  },
  Event_129225_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129225_Name = {
    Text = "Unutuş Bölüm 3@"
  },
  Event_129226_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129226_Name = {
    Text = "Unutuş Bölüm 4@"
  },
  Event_129227_ChoiceDesc1 = {
    Text = "[El Sallayarak Kovala] 3 Komut Kartı arasından 1 tanesini seçerek Kazıma: \"(EnchantConfig.Arg1)\" iki kez, \"(Skill.Arg2)\" iki kez geliştir"
  },
  Event_129227_ChoiceDesc2 = {
    Text = "[Let It Stay] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_129227_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_129227_Desc = {
    Text = "Karanlıktan hafif bir ses Belirir.\nBir Kelebek’tir, nazikçe sorar:\n \"Avucunda dinlenebilir miyim?\"\n \"Yalnızca çok yorgunum... Bir an dinlenmek istiyorum.\"\nSözlerini fısıldarken, Kelebek karanlığın içinden sana doğru sarmal çizerek yaklaşır.\nKanatlarından siyah, koyu bir sıvı damlar—geçip geldiği Gölgelerden getirdiği bir armağan."
  },
  Event_129227_Name = {
    Text = "Kelebeğin İsteği"
  },
  Event_129228_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129228_Name = {
    Text = "Unutuş Bölüm 7@"
  },
  Event_129229_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129229_Name = {
    Text = "Unutuş Bölüm 7@"
  },
  Event_129230_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129230_Name = {
    Text = "Unutuş Bölüm 1@"
  },
  Event_129231_ChoiceDesc1 = {
    Text = "[Recognize Lyrics] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_129231_ChoiceDesc2 = {
    Text = "[Hafifçe Mırıldan] 3'ten 1 seçimli Mühür iki kez kazan"
  },
  Event_129231_Desc = {
    Text = "Kadim denizci türküleri gizli diyarda yankılanıyor.\nHapsedilmiş anılar, dalgaları, gökleri ve sert içkileri, kimsenin duymadığı bir dilde söylüyor."
  },
  Event_129231_Name = {
    Text = "Denizci Türküsü"
  },
  Event_129232_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129232_Name = {
    Text = "Unutuş Bölüm 8@"
  },
  Event_129233_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129233_Name = {
    Text = "Astral Hüküm Bölüm 1@"
  },
  Event_129234_ChoiceDesc1 = {
    Text = "[Avucu Kes] 3 Komut Kartı arasından 1 tanesini seçerek Kazıma: \"(EnchantConfig.Arg1)\" iki kez, \"(Skill.Arg2)\" iki kez geliştir"
  },
  Event_129234_ChoiceDesc2 = {
    Text = "[Accept Growth] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_129234_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_129234_Desc = {
    Text = "O kelebek içeri uçmadı; yavaşça avucunun içinden büyüdü.\nÖnce bunun sadece ter olduğunu sandın, ama parmaklarının arasında, damarların tersine akışı gibi sızan siyah bir sıvı gördün; soğuk, atan kanatlara pıhtılaşıyordu.\nHer kanat çırpışında, kan dolaşımında dalgalar yayılır."
  },
  Event_129234_Name = {Text = "Parazit"},
  Event_129235_ChoiceDesc1 = {
    Text = "[Okumaya Devam Et] Rastgele 1 Komut Kartına iki kez Mühür kazı: [(EnchantConfig.Arg1)]"
  },
  Event_129235_ChoiceDesc2 = {
    Text = "[Leave] Maksimum HP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_129235_Desc = {
    Text = "Tartmak için bir terazi.\nArkasında, sayısız organ kırmızı formalinde bekletiliyor.\nDepo raflarına düzenlice istiflenmişler.\nSen de yanındaki bir defteri rastgele eline alıp karıştırıyorsun:\n\"Kalp: 8 ons, Beyin: 50 ons...\""
  },
  Event_129235_Name = {
    Text = "Organ Kaydı"
  },
  Event_129236_ChoiceDesc1 = {
    Text = "[Detour] Bir Komut Kartı İmha Et ve Arg1 Kara Mühür kazan."
  },
  Event_129236_ChoiceDesc2 = {
    Text = "[Ask Why It Sank] Bir Komut Kartını kopyala, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_129236_ChoiceDesc3 = {
    Text = "[Mürettebat Üyesine Selam Ver] 3 Komut Kartından 1 tanesini seçerek Mühür kazan: [(EnchantConfig.Arg1)] iki kez"
  },
  Event_129236_Desc = {
    Text = "\nMakine dairesine doğru yürürken, alana çivilenmiş bazı \"anılar\" la yeniden karşılaşırsın.\nOnlar birer hayalet değil, yalnızca Kaptan Elton’un kayıp mürettebata dair kalıntı düşünceleridir."
  },
  Event_129236_Name = {
    Text = "Sona-Nyl'ın Efendisi"
  },
  Event_129237_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129237_Name = {
    Text = "Unutuş Bölüm 3@"
  },
  Event_129238_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129238_Name = {
    Text = "Astral Hüküm Bölüm 1@"
  },
  Event_129239_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129239_Name = {
    Text = "Unutuş Bölüm 6@"
  },
  Event_129240_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129240_Name = {
    Text = "Unutuş Bölüm 5@"
  },
  Event_129241_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129241_Name = {
    Text = "Astral Hüküm Bölüm 4@"
  },
  Event_129242_ChoiceDesc1 = {
    Text = "[Onun İçin Çal] 3 Komut Kartından 1 tanesini seçerek Kazıma: \"(EnchantConfig.Arg1)\" iki kez, \"(Skill.Arg2)\" iki kez geliştir"
  },
  Event_129242_ChoiceDesc2 = {
    Text = "[Listening to the Strings] 50 veya daha fazla Aliemus’a sahip her Uyandırıcı için 15 Kara Mühür al."
  },
  Event_129242_ChoiceDesc3 = {
    Text = "[Leave] 3'ten 1 seçimli Mühür iki kez kazınır"
  },
  Event_129242_Desc = {
    Text = "\"Sevgili John:\nSon zamanlarda, bize en son piyano çaldığından bu yana birkaç yıl geçtiğini aniden fark ettim.\nBu yıl 81 yaşındayım ve yaşlandıkça gençliğimin Anıları’nı gitgide daha çok değerli buluyorum.\nBu mektubu alırsan, lütfen bir dahaki Londinium’dan geçişinde daireme uğra ve benim için bir parça çal.\""
  },
  Event_129242_Name = {
    Text = "Pişmanlık Sonatı"
  },
  Event_129243_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129243_Name = {
    Text = "Astral Hüküm Bölüm 3@"
  },
  Event_129244_ChoiceDesc1 = {
    Text = "[Cüzdanı Olmadığını Söyle] 3 seçenekten 1 Mühür kazıma işlemini iki kez gerçekleştir"
  },
  Event_129244_ChoiceDesc2 = {
    Text = "[Ağı Yırt] Rastgele 1 Komut Kartına iki kez Mühür kazı: \"(EnchantConfig.Arg1)\", iki kez \"(Skill.Arg2)\" geliştir"
  },
  Event_129244_Desc = {
    Text = "Sarı-turuncu bir ağ havada sessizce süzülüyor; seyrek delikleri, duvar dibine yuvalanmış örümcek-örgülü akrabalarınınkinden çok daha az girift.\nDayanamayıp elini uzatıyorsun; Kırılgan ağ anında çözünüyor ve kulaklarında çocuk kahkahaları yankılanıyor.\n \"Altın, gümüş, sarı, kırmızı, bütün cüzdanlar bizim!\""
  },
  Event_129244_Name = {
    Text = "Vagus Ağı"
  },
  Event_129245_ChoiceDesc1 = {
    Text = "[Choose Emotion] Arg1 YP Kurtar"
  },
  Event_129245_ChoiceDesc2 = {
    Text = "[Aklını Koru] Rastgele 1 Komut Kartına Kazıma: [(EnchantConfig.Arg1)] iki kez"
  },
  Event_129245_ChoiceDesc3 = {
    Text = "[Refuse to Choose] 25 Kara Mühür al"
  },
  Event_129245_Desc = {
    Text = "“Seç, seç.”\nKoşarcasına akıp giden karanlıkta sayısız fısıltı yankılandı.\nSes hafifçe hipnotiktir, sende çılgın bir fantazma uyandıran sonsuz bir büyü taşıyormuş gibidir.\nBeyninin deliliğe gömülüp bedenden kıvranarak uzaklaştığını, kalbinin ise bir tür bilinç kazanmış gibi çığlık atıp seni çağırdığını hissediyorsun.\n“Seç, seç.”\n“Akılcılığı mı yoksa duyguyu mu koruyacaksın; bir seçim yapmak zorundasın.”"
  },
  Event_129245_Name = {
    Text = "Humanity's Toll"
  },
  Event_129246_ChoiceDesc1 = {
    Text = "[Destroy Offering] Lanetli Kalıntı \"(RelicConfig.Arg1)\"yı elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_129246_ChoiceDesc2 = {
    Text = "[İpi Çöz] 3 Komut Kartından 1 tanesini seçerek Mühür kazan: [(EnchantConfig.Arg1)] iki kez"
  },
  Event_129246_ChoiceDesc3 = {
    Text = "[Keep Going] 50 Kara Mühür al"
  },
  Event_129246_Desc = {
    Text = "Üç Aramlı yüksek bir platforma bağlanmıştı.\nBebeklerin teninde gördüğün, koyu, kabuk benzeri desenler, büyüler mırıldanırlarken onların üzerinde belirdi."
  },
  Event_129246_Name = {Text = "Üç Sunu"},
  Event_129247_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129247_Name = {
    Text = "Astral Hüküm Bölüm 3@"
  },
  Event_129248_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129248_Name = {
    Text = "Unutuş Bölüm 6@"
  },
  Event_129249_ChoiceDesc1 = {
    Text = "[Struggle Forward] Bir Komut Kartı’nı İmha Et ve Arg1 Kara Mühür al."
  },
  Event_129249_ChoiceDesc2 = {
    Text = "[Snap the Thread] Bir Komut Kartını kopyala, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_129249_ChoiceDesc3 = {
    Text = "[Sabırla Bekle] 3 Komut Kartından 1 tanesini seçerek Mühür kazan: [(EnchantConfig.Arg1)] iki kez"
  },
  Event_129249_Desc = {
    Text = "Boylu boyunca ileri itiliyorsun, her seçimin görünmez ipliklerce yönlendiriliyor.\nÖnem verdiğin her şeyi kavramak için çırpınıyorsun.\nDünyanın kaderi parmak uçlarının hemen önünde sallanıyor.\nSayısız iplik birbirine dolanıyor, tüm bedenini bağlayıp sarıyor."
  },
  Event_129249_Name = {
    Text = "Puppet Hands"
  },
  Event_129250_ChoiceDesc1 = {
    Text = "[Ona Yol Sor] 3 Komut Kartı arasından 1 tanesini seçerek iki kez Mühür kazı: \"(EnchantConfig.Arg1)\", iki kez \"(Skill.Arg2)\" geliştir"
  },
  Event_129250_ChoiceDesc2 = {
    Text = "[Onu Terk Et] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_129250_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_129250_Desc = {
    Text = "Gölge, uzun sokak lambasının altında duruyor.\n\"Bir ateş alabilir miyim, bayım?\"\n@2 alışkanlığın yok, ama biraz ‘sihir’ kullanmaktan da gocunmuyorsun.\nYardımınla, gölge @2’i tutuşturacak ve onu o akıl almaz siyah girdabın derinliklerine saplayacak.\nÇok geçmeden, beyaz dumanların yükseldiğini görüyorsun.\n\"Ah—\"\nGölge, memnun bir iç çekiş bırakıyor."
  },
  Event_129250_Name = {
    Text = "Sokak Lambasının Altındaki Silüet"
  },
  Event_129251_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129251_Name = {
    Text = "Unutuş Bölüm 1@"
  },
  Event_129252_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129252_Name = {
    Text = "Unutuş Bölüm 8@"
  },
  Event_129253_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129253_Name = {
    Text = "Unutuş Bölüm 3@"
  },
  Event_129254_ChoiceDesc1 = {
    Text = "[Fantazmayı Kabul Et] Rastgele 1 Komut Kartına iki kez Mühür kazı: \"(EnchantConfig.Arg1)\", iki kez \"(Skill.Arg2)\" geliştir"
  },
  Event_129254_ChoiceDesc2 = {
    Text = "[Fantazmayı Reddet] 3 Komut Kartı arasından 1 tanesini seçerek iki kez Mühür kazı: [(EnchantConfig.Arg1)]"
  },
  Event_129254_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_129254_Desc = {
    Text = "Ağır, karanlık demir köprünün altında, sazlarla kaplanmış sessiz bir nehir kıyısında, parıldayan bir kelebek aniden havalandı.\nKelebek usulca avucuna kondu. Dehşet verici ulumalar kesildi; yerlerini paslı raylarda ilerleyen bir trenin gümbürtüsü, yanan kömürün çıtırtısı ve dönen dingillerin metalik çığlığı aldı..."
  },
  Event_129254_Name = {
    Text = "Demiryolu Serabı"
  },
  Event_129255_ChoiceDesc1 = {
    Text = "[Refuse] Bir Komut Kartı İmha Et ve Arg1 Kara Mühür kazan."
  },
  Event_129255_ChoiceDesc2 = {
    Text = "[Comply] Bir Komut Kartını kopyala, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_129255_ChoiceDesc3 = {
    Text = "[Kucaklamayı Seç] 3 Komut Kartı arasından 1 tanesini seçerek Kazıma: [(EnchantConfig.Arg1)] iki kez"
  },
  Event_129255_Desc = {
    Text = "\"Ben kafese kapatılmış bir kuşum, birçok odadan oluşan bir avluya hapsedilmiş.\"\nKaranlıkta belirsiz silüetler dolaşır—ölülerin Takıntı’larından geriye kalan Kalıntı Nüsha’lar.\n\"Adına akıl hastanesi diyorlar, ama biliyorum ki bu, toplumsal Kurallar’a boyun eğmeyen özgür kuşları tutsak eden, insanlara özgü özel bir kafes.\"\n\"Ama bir kuş uçamıyorsa, hâlâ kuş sayılır mı?\"\nTakıntı’lar etrafında toplanır, Kurtuluş için yalvarır.\n\"Lütfen kanatlarımı Kırılma’ya uğrat, uçmaktan yoruldum.\""
  },
  Event_129255_Name = {
    Text = "İçi Boş İnsan"
  },
  Event_129256_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129256_Name = {
    Text = "Unutuş Bölüm 2@"
  },
  Event_129257_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129257_Name = {
    Text = "Astral Hüküm Bölüm 2@"
  },
  Event_129258_ChoiceDesc1 = {
    Text = "[Kelebeği Serbest Bırak] 3 Komut Kartından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\" iki kez, \"(Skill.Arg2)\" iki kez enfekte et"
  },
  Event_129258_ChoiceDesc2 = {
    Text = "[Become a Butterfly] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_129258_ChoiceDesc3 = {
    Text = "[Swallow Back] 25 Kara Mühür al"
  },
  Event_129258_Desc = {
    Text = "Bu gece çok şey oldu.\nİskeledeki Hücum, hayalet yük gemisi, Denizci, Tulu, Murphy, Ramona… her şey bir girdapta dönüp durdu, Mythag’ın lokantasındaki sabah 7 yulaf lapasına karıştı.\nÖnündeki Uyanan’a bir şeyler sormak istiyorsun ama nereden başlayacağını bilemiyorsun; boğazında bir düğüm—ya da midende uçuşan kelebekler hissediyorsun."
  },
  Event_129258_Name = {
    Text = "Kelebek Etkisi"
  },
  Event_129259_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129259_Name = {
    Text = "Unutuş Bölüm 8@"
  },
  Event_129260_ChoiceDesc1 = {
    Text = "[Kalmaya Bırak] 3 Komut Kartı arasından 1 tanesini seçerek iki kez Mühür kazı: \"(EnchantConfig.Arg1)\", iki kez \"(Skill.Arg2)\" geliştir"
  },
  Event_129260_ChoiceDesc2 = {
    Text = "[Wave Away] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntı'yı edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_129260_ChoiceDesc3 = {
    Text = "[Welcome the Butterflies] 25 Kara Mühür al"
  },
  Event_129260_Desc = {
    Text = "Soğuk sanatoryumda dolaşırsın; mevsime inat var olmaması gereken siyah bir kelebek yanından süzülür.\nKanatları, üzerini kaplayan siyah sümüksü sıvıyla, uçarken titrer; rüzgârda katılaşıp soyulan katman katman siyah tortular döker.\nTükenmiş halde, gelip parmak ucuna konar."
  },
  Event_129260_Name = {
    Text = "Var Olmaması Gereken"
  },
  Event_129261_ChoiceDesc1 = {
    Text = "[Geçmişi Yeniden Yaşa] 3'ten 1 İleri Mühür seçerek iki kez kazı."
  },
  Event_129261_ChoiceDesc2 = {
    Text = "[Gaze into the Future] Altın Kalıntı \"(RelicConfig.Arg1)\" kazan, fakat \"(Skill.Arg2)\" geliştir"
  },
  Event_129261_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_129261_Desc = {
    Text = "Bu dünyada hiçbir şey değişmeden kalmaz—\nİlahi Ana’nın şekillendirdiği Paradise bile.\nBir anlığına, zamanın çatlağından bir şey görürsün.\nGeçmiş, şimdi ve gelecek o çatlakta birbirine dolanır, durmaksızın şekil değiştirir,\nmeraklı bakışını bekler."
  },
  Event_129261_Name = {
    Text = "Zaman Yarığı"
  },
  Event_129262_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129262_Name = {
    Text = "Unutuş Bölüm 7@"
  },
  Event_129263_ChoiceDesc1 = {
    Text = "[Görmezden Gel] 3'ten 1 seçimli Mühür iki kez kazınır"
  },
  Event_129263_ChoiceDesc2 = {
    Text = "[Dokun] Rastgele 1 Komut Kartına Kazıma: \"(EnchantConfig.Arg1)\" iki kez, \"(Skill.Arg2)\" iki kez geliştir"
  },
  Event_129263_Desc = {
    Text = "Sporlara benzeyen tuhaf bir şey dikkatini çekti.\nEt ve kandan yapılmış narin bir denizanasını andırıyordu; aynı zamanda beynin derinliklerinde sinyaller taşıyan sinir liflerine de benziyordu.\n“Gel, dokun bana,” diye sessizce ayartıyor, “sana zalim bir anı göstereceğim.”"
  },
  Event_129263_Name = {
    Text = "Derin Hafıza"
  },
  Event_129264_ChoiceDesc1 = {
    Text = "[Hayale Dal] 3 Komut Kartı arasından 1 tanesini seçerek Kazıma: \"(EnchantConfig.Arg1)\" iki kez, \"(Skill.Arg2)\" iki kez geliştir"
  },
  Event_129264_ChoiceDesc2 = {
    Text = "[Maintain Sanity] 50 veya daha fazla Aliemus’a sahip her Uyanan için 15 Kara Mühür kazan"
  },
  Event_129264_ChoiceDesc3 = {
    Text = "[Zorla Ayrıl] 3'ten 1 Mühür seçerek iki kez kazı."
  },
  Event_129264_Desc = {
    Text = "Belki de uzun süren Savaş seni sersemletti, ya da belki zihnin bedenine ihanet etti.\nDüşüncelerini bir ağırlıksızlık hissi doldurur.\nBir anda zihnin bir Kaleydoskop’a dönüşür—göz kamaştırıcı, parlak, her renkle çakan.\nSayısız Kavrayış, düşünce ve hayal zihnine hücum eder, her bir kıvrımı doldurur.\nBöyle devam ederse, beynin bu kaostan yakında patlayacak."
  },
  Event_129264_Name = {
    Text = "Düşünce Kaleydoskopu"
  },
  Event_129265_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129265_Name = {
    Text = "Unutuş Bölüm 5@"
  },
  Event_129266_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129266_Name = {
    Text = "Unutuş Bölüm 4@"
  },
  Event_129267_ChoiceDesc1 = {
    Text = "[Listen] 3'ten 1 seçimli İleri Dua iki kez kazan"
  },
  Event_129267_ChoiceDesc2 = {
    Text = "[Call Out] Altın Kalıntı \"(RelicConfig.Arg1)\" elde et, ancak \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_129267_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_129267_Desc = {
    Text = "Kazadan bu yana partnerinizden hiçbir haber almadınız.\nSayısız iletişim girişimi, denize taş atmak gibi karşılıksız kaldı.\nTüm umudunuzu yitirdiğinizde, iletişim cihazı aniden bir ses çıkarıyor.\nBavulu açıyor, alıcıyı kulağınıza yaklaştırıyorsunuz.\n\"Koruyucu...\"\nBir an için, özlediğiniz o sesi duyuyorsunuz, boşlukta uzaklardan yankılanıyor."
  },
  Event_129267_Name = {
    Text = "Özlemin Yankısı"
  },
  Event_129268_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129268_Name = {
    Text = "Unutuş Bölüm 1@"
  },
  Event_129269_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129269_Name = {
    Text = "Astral Hüküm Bölüm 1@"
  },
  Event_129270_ChoiceDesc1 = {
    Text = "[Stare Down the Hellhound Source] Altın Kalıntı \"(RelicConfig.Arg1)\" elde et, ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_129270_ChoiceDesc2 = {
    Text = "[Savaşa Odaklan] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: [(EnchantConfig.Arg1)] iki kez"
  },
  Event_129270_Desc = {
    Text = "Cehennem Köpeği’nin silueti kıpırdanır.\nBedeni, duvarlardaki çatlakları birbirine bağlayarak tekinsiz Düşleri açığa çıkarır."
  },
  Event_129270_Name = {
    Text = "From Perspective"
  },
  Event_129271_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129271_Name = {
    Text = "Unutuş Bölüm 2@"
  },
  Event_129272_ChoiceDesc1 = {
    Text = "[Combine Pages] \"(RelicConfig.Arg1)\" adlı Altın Kalıntıyı edin, fakat \"(Skill.Arg2)\"yi geliştir."
  },
  Event_129272_ChoiceDesc2 = {
    Text = "[Read] 3 Komut Kartı arasından 1 tanesini seçerek Kazıma: [(EnchantConfig.Arg1)] iki kez"
  },
  Event_129272_ChoiceDesc3 = {
    Text = "[Discard It] 50 Kara Mühür al"
  },
  Event_129272_Desc = {
    Text = "Işık Taşıyıcı Tarikatçısı'nın cübbesinden sararmış bir sayfa düştü.\nÜzerini garip yazılar kaplamış; kimisi hiyeroglife benzer, kimisi tuhaf biçimde eğik, kimisi de birbirinin üstüne binmiş. Ancak birkaç kelime güçlükle seçilebiliyor.\nBaşlığı: \"@2 Divus'un Doğuşu\""
  },
  Event_129272_Name = {
    Text = "Şifreli Emir·Bölüm II"
  },
  Event_129273_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129273_Name = {
    Text = "Unutuş Bölüm 2@"
  },
  Event_129274_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129274_Name = {
    Text = "Astral Hüküm Bölüm 2@"
  },
  Event_129275_ChoiceDesc1 = {
    Text = "[Savaşa Hazırlan] 3 Komut Kartı arasından 1 tanesine \"(EnchantConfig.Arg1)\" Mühürünü iki kez kazı, ancak \"(Skill.Arg2)\" iki kez gelişir."
  },
  Event_129275_ChoiceDesc2 = {
    Text = "[Try to Detour] 25 Kara Mühür kazan"
  },
  Event_129275_Desc = {
    Text = "Yıldızlarla bezeli derinlikte, Denizciler yüzyıllardır hafif uykudadır.\nSonsuz deniz, onların deliliğine, dayanışına ve en sadık inançlarına tanıklık etmiştir.\nHiç kimse Tanrılarının büyük gelişini engelleyemez.\nYollarına çıkanlar, Denizcilerin gazabıyla küle dönecektir."
  },
  Event_129275_Name = {
    Text = "Yıldızlar Altında Bekleyiş"
  },
  Event_129276_ChoiceDesc1 = {
    Text = "[Play a Few Notes] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_129276_ChoiceDesc2 = {
    Text = "[Kapağı Kapat] 3 seçenekten 1 Mühür kazıma işlemini iki kez gerçekleştir"
  },
  Event_129276_Desc = {
    Text = "Duvarın yanındaki piyanonun kapağı açıktır. Tuşları sararmış, kenarları çatlamış, altındaki ahşabı açığa vurmuştur; ama her bir tuş özenle silinmiştir.\nNice kişi için bir sevinç kaynağıdır."
  },
  Event_129276_Name = {Text = "Ninni"},
  Event_129277_ChoiceDesc1 = {
    Text = "[Fantazmayı Kabul Et] 3 Komut Kartı arasından 1 tanesini seçerek iki kez Mühür kazı: \"(EnchantConfig.Arg1)\", iki kez \"(Skill.Arg2)\" geliştir"
  },
  Event_129277_ChoiceDesc2 = {
    Text = "[Deny the Illusion] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_129277_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_129277_Desc = {
    Text = "Ağır, karanlık demir köprünün altında, sessiz, sazlarla kaplı nehir kıyısından birden parıltılı bir kelebek havalanıyor.\nKelebek usulca avucuna konuyor, dehşet verici ulumaları susturuyor. Onun yerine, çelik taşıyan işçilerin ritmik ilahilerini, çekiç darbelerinin gümlemesini ve perçinlerin berrak şakırtısını işitiyorsun..."
  },
  Event_129277_Name = {
    Text = "Çelik Köprü Serabı"
  },
  Event_129278_ChoiceDesc1 = {
    Text = "[Laneti Göster] 3 Komut Kartı arasından 1 tanesini seçerek iki kez Mühür kazı: \"(EnchantConfig.Arg1)\", iki kez \"(Skill.Arg2)\" geliştir"
  },
  Event_129278_ChoiceDesc2 = {
    Text = "[Kargayı Reddet] 3 seçenekten 1 Mühür kazan, iki kez"
  },
  Event_129278_ChoiceDesc3 = {Text = "[Ignore]"},
  Event_129278_Desc = {
    Text = "Zifiri siyah, hastalıklı, çok başlı bir kuzgun, bir Işık Taşıyıcı Tarikatçısı'nın siyah cübbesinden fırlar ve omzuna konar.\n\"Başımı görüyor musun? Lanetin tadını aldığım sürece yeni bir baş çıkarırım. Bakalım, senin lanetin nasılmış!\""
  },
  Event_129278_Name = {
    Text = "Lanetli Karga"
  },
  Event_129279_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129279_Name = {
    Text = "Unutuş Bölüm 7@"
  },
  Event_129280_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129280_Name = {
    Text = "Unutuş Bölüm 3@"
  },
  Event_129281_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129281_Name = {
    Text = "Unutuş Bölüm 4@"
  },
  Event_129282_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129282_Name = {
    Text = "Unutuş Bölüm 2@"
  },
  Event_129283_ChoiceDesc1 = {
    Text = "[Placeholder]Geçici metin."
  },
  Event_129283_Name = {
    Text = "Astral Hüküm Bölüm 2@"
  },
  Event_129900_ChoiceDesc1 = {
    Text = "[Bury] Bir Komut Kartı yok et ve Arg2 HP yenile. [ExDesc1]"
  },
  Event_129900_ChoiceDesc2 = {
    Text = "[Pray] Altın Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştirin."
  },
  Event_129900_Desc = {
    Text = "Zifiri karanlık D-balçığa yarıya kadar gömülmüş solgun bir iskelet."
  },
  Event_129900_Name = {
    Text = "Solmuş Kemik"
  },
  Event_130337_ChoiceDesc1 = {
    Text = "[Yerinize Oturun] Destenize [kukla] karıştırın."
  },
  Event_130337_Desc = {
    Text = "Tiyatronun basamaklarına ayak bastığınız an, bakışlarınız bir daha asla bu sahneden koparılamaz.\nKaderin iplikleri sayısız hikâyeyi buradaki girdaplarına çeker—geçmişin tozu, şimdinin titreyen ışığı ve geleceğin sisleri sahne üzerinde durmaksızın çalkalanır.\nHem kökeninizi hem de varış noktanızı unuttunuz. \"Benlik\"in her izi, ağır perdelerin gölgelerinde erir. Bu saatte, siz hem koltukta oturan sessiz seyirci, hem de sahne tahtalarında yanan oyuncusunuz.\nVarlığınızın tamamı iki tekil ize indirgenir: seyretmek ve sahnelemek."
  },
  Event_130337_Name = {
    Text = "Kaderin Sahnesi"
  },
  Event_131264_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131264_Desc = {
    Text = "Gücü seçiyorsun. Sarsılmaz inancı ve daima ileri gitme cesaretini seçiyorsun.\nAma bedeli... Bir bedelin asıl amacı ödenmek değil midir?"
  },
  Event_131264_Name = {
    Text = "Geçmişe Bakış"
  },
  Event_131265_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131265_Desc = {
    Text = "Zihnindeki ıstıraba katlanarak, sürüklenen, sivri kırıklara sıkıca tutunuyorsun. Kararlı sabrınla, yarıklar kapanmaya başlıyor.\nHatırlamak için ayrıldın ve hatırlamak için savaşıyorsun. Hiçbir anının kaybolmasına izin vermeyeceksin."
  },
  Event_131265_Name = {
    Text = "Paramparça Anılar"
  },
  Event_131266_ChoiceDesc1 = {
    Text = "[Anıyı Koru] 3 Mühür'den 1 tanesini kazı"
  },
  Event_131266_ChoiceDesc2 = {
    Text = "[Yarığı Mühürle] \"(EnchantConfig.Arg1)\" Mühür'ünü 3 Komut Kartı'ndan 1 tanesine kazı, ancak \"(Skill.Arg2)\" yeteneğini geliştir"
  },
  Event_131266_Desc = {
    Text = "Anılarından hiç şüphe duymadın. Sıcaktılar, dayanıklıydılar—en güvenli limanın ve en değerli hazinendilar.\nAma şimdi, Uçurum'un müdahalesi altında, o anılar çatlamaya ve parçalanmaya başlıyor."
  },
  Event_131266_Name = {
    Text = "Paramparça Anılar"
  },
  Event_131267_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131267_Desc = {
    Text = "Bir ruhani enerji dalgası zihnini dolduruyor, korkunç yırtıkları dikişliyor. Tüm iradenle, kırıkları bütünlüğe kavuşturuyorsun.\nHatırlamak için ayrıldın ve hatırlamak için savaşıyorsun. Hiçbir anının kaybolmasına izin vermeyeceksin."
  },
  Event_131267_Name = {
    Text = "Paramparça Anılar"
  },
  Event_131268_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131268_Desc = {
    Text = "\"Ooh... Hahahha!!\"\nSorunuzu kimse anlamıyor. Ağlayarak ve tiz kahkahalarla cevap veriyorlar."
  },
  Event_131268_Name = {
    Text = "Terk Edilmiş"
  },
  Event_131269_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131269_Desc = {
    Text = "Onlara geri bakıyorsun. İplikler kıpırdanıyor; nazik bakışların anıları yakına çekiyor, onları bir kucaklaşmaya sarıyor.\nKaderin kuklacısını sessizce izliyorsun. Bir şans daha verilse, hangi seçimi yapardı?"
  },
  Event_131269_Name = {
    Text = "Geçmişe Bakış"
  },
  Event_131270_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131270_Desc = {
    Text = "\"Ooh... Hahahha!!\"\nÇığlıklar ve kahkahalar yavaşça sönüyor, havada eriyor. Hiçbir ruh size zarar vermek için ayağa kalkmıyor—görünmez olmakla yaşamayı çoktan öğrenmişler."
  },
  Event_131270_Name = {
    Text = "Terk Edilmiş"
  },
  Event_131271_ChoiceDesc1 = {
    Text = "[Anıya Bak] Altın Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_131271_ChoiceDesc2 = {
    Text = "[Anıyı Terk Et] 2 rastgele Uyandırıcıyı Uyandır, ancak [(Skill.Arg1)] yeteneğini iki kez geliştir"
  },
  Event_131271_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_131271_Desc = {
    Text = "Kızın kabının içinde, kırılan porselenin sesi yankılanıyor. Anılar kaplarından kurtulup yanınıza süzülüyor.\nÇocukluk oyun arkadaşları, ebeveyn hediyeleri, bulutların ve kuşların saf hayalleri, açık gökyüzü kadar berrak idealler... Tüm anılar gözlerini açıyor, sessizce size bakıyor.\nSorguluyorlar. Ağlıyorlar. Bekliyorlar."
  },
  Event_131271_Name = {
    Text = "Geçmişe Bakış"
  },
  Event_131272_ChoiceDesc1 = {
    Text = "[Sor] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte et"
  },
  Event_131272_ChoiceDesc2 = {
    Text = "[Yoksay] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte et"
  },
  Event_131272_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_131272_Desc = {
    Text = "Kulakları tırmalayan keskin feryatlar; önünde, acı çeken ruhlar kendi yüzlerini ve biçimlerini parçalıyor...\nOnlar kim? Uçurumun mahkûmları mı? Bir kenara atılmış kaderler mi? Geçmişin yankıları mı, belki?"
  },
  Event_131272_Name = {
    Text = "Terk Edilmiş"
  },
  Event_133380_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_133380_Desc = {
    Text = "Kadife koltuğunuza yerleştiniz ve kızıl perdeler fısıltıyla aralanıyor.\nSevgili seyirci, sahne her beklentinizi karşılamak için yükselecek.\nBu oyunun başrol oyuncusu çoktan yerini aldı."
  },
  Event_133380_Name = {
    Text = "Kaderin Sahnesi"
  },
  Event_141995_ChoiceDesc1 = {
    Text = "[Basit Deneme] En fazla 5 adet istediğin Kartı sil"
  },
  Event_141995_ChoiceDesc2 = {
    Text = "[Ona Bırak] Rastgele 5 Komut Kartı sil, Mübarek Kalıntı [(RelicConfig.Arg1)] kazan."
  },
  Event_141995_ChoiceDesc3 = {
    Text = "[Ters Düşünce?] En fazla iki Uyandırıcı seç, onların tam temel kart setini oluşturup desteye ekle"
  },
  Event_141995_Desc = {
    Text = "Bir meydana geldin; pek çok insan telaşla oradan oraya koşuyor, belki burada ilginç şeyler bulunabilir.\nSarı ışıkların yandığı bir odanın kapısını çaldın; içeriden Araştırmacı kıyafetli biri başını uzattı. Pek çok tanımadık bilimsel alet gördün; seni tutup oturttu ve kendisinin bir \"evrimci\" olduğunu söyledi. Yüzü Şevkle doluydu; sana \"bilimsel yöntemini\" ısrarla tavsiye etti.\n\"İnsandaki sıkıcı fazlalıkları ancak silerek gerçek evrim yoluna ulaşılabilir!\""
  },
  Event_141995_Name = {Text = "Evrimci"},
  Event_141996_ChoiceDesc1 = {
    Text = "[Saldırı Odaklı Özel Antrenman] Mühür taşımayan tüm Temel Saldırılara rastgele Mühür ekle"
  },
  Event_141996_ChoiceDesc2 = {
    Text = "[Savunma Odaklı Özel Antrenman] Mühür taşımayan tüm Temel DEF'lere rastgele Mühür ekle"
  },
  Event_141996_ChoiceDesc3 = {
    Text = "[Gözü Kara Antrenman] Rastgele 15 Komut Kartına rastgele Mühür ekle, 5 adet rastgele Semptom kartı kazan"
  },
  Event_141996_Desc = {
    Text = "Bir meydana geldin; pek çok kişi telaşla oradan oraya koşuşturuyordu, belki burada ilginç şeyler bulunabilirdi.\nMetal çarpışmalarının tiz sesi açık alanda yankılanıyordu; birkaç kişi burada birbirleriyle dövüşerek savaş becerilerini geliştiriyordu. Eski tarz zırh giyen genç bir adam seni fark etti ve bir kılıç fırlatarak onlarla birlikte antrenman yapman için seni davet etti."
  },
  Event_141996_Name = {
    Text = "Özel Antrenman Zamanı"
  },
  Event_141997_ChoiceDesc1 = {
    Text = "[Büyük Bahis] %50 ihtimalle rastgele Mühür kazan ve yeniden bahis yap, %50 ihtimalle 75 Kara Mühür kazan"
  },
  Event_141997_ChoiceDesc2 = {
    Text = "[Küçük Bahis] %50 ihtimalle rastgele Mühür kazan ve yeniden bahis yap, %50 ihtimalle 75 Kara Mühür kazan"
  },
  Event_141997_Desc = {
    Text = "Garson değişmeyen gülümsemesini koruyarak zar kabını kaldırıyor; berrak bir ses Yankılanıyor ve diğer oyuncular kendi seçimlerini yapıyor. \"Bahisler kapandı,\" diyor, \"lütfen bahsinizi yapın—\""
  },
  Event_141997_Name = {
    Text = "Gürültülü Kumarhane"
  },
  Event_141998_ChoiceDesc1 = {
    Text = "[Dürüstçe Bahis Yap] Bir Komut Kartı sil"
  },
  Event_141998_ChoiceDesc2 = {
    Text = "[Hile Dene] Bir Semptom kartı sil"
  },
  Event_141998_ChoiceDesc3 = {Text = "[Leave]"},
  Event_141998_Desc = {
    Text = "Son derece kalabalık bir yere geliyorsun; herkesin yüzünde mutluluk parıldıyor, geceyi köşeye sıkıştıran renkli ışıklar her yanda Göz Kırpıyor. Her köşedeki tabelalar şunu yazıyor: \"Karnavala hoş geldiniz! Buradaki Rüyaların Sonu yok, buradaki Hazın perdesi kapanmaz!\"\nKalabalığın itip kakmasıyla görkemli bir binanın içine sürükleniyorsun; salon altın yaldızlı, insan sesleri birbirine karışmış, havada tatlı bir şarap kokusu yayılıyor. Bir zar tam ayaklarının dibine yuvarlanıyor; garson yaltakçı bir gülümsemeyle bunun şans işareti olduğunu söylüyor. Merakla bir adım öne atıyorsun; belki bu oyunda kendini gösterme fırsatı bulabilirsin."
  },
  Event_141998_Name = {
    Text = "Gürültülü Kumarhane"
  },
  Event_141999_ChoiceDesc1 = {
    Text = "[Takas] 1 Kalıntı kaldır, %50 olasılıkla 3'ten 1 Altın Kalıntı kazan, %50 olasılıkla 25 Kara Mühür kazan"
  },
  Event_141999_ChoiceDesc2 = {Text = "[Leave]"},
  Event_141999_Desc = {
    Text = "Son derece kalabalık bir yere geldin; herkesin çehresinde mutluluk parlıyor, her yeri aydınlatan renkli ışıklar geceye yer bırakmıyordu. Her köşede görülen tabelalar şunu yazıyordu: \"Karnavala hoş geldiniz! Buradaki Rüyaların Sonu yoktur, buradaki Haz hiç Perde Kapanmaz!\"\nKalabalığın içinde, üstü başı perişan ama inanılmaz büyüklükte bir bohçası olan bir Tüccar sana el salladı; yanındaki bohçaya vurdu, yaklaşıp sesini alçaltarak sana Takas teklifinde bulundu. O eski püskü bez bohça, konuştukça hafifçe sallandı ve zaman zaman çıtırtılı sesler çıkardı."
  },
  Event_141999_Name = {
    Text = "Perişan Tüccar"
  },
  Event_142000_ChoiceDesc1 = {
    Text = "[Dilek Dile] Mevcut Can'ın %50'sini harca, 2 adet rastgele Altın Kalıntı kazan"
  },
  Event_142000_ChoiceDesc2 = {
    Text = "[Tüm Kalbinle Dilek Dile] Mevcut Can'ın %99'unu harca, Krono Sarkaç [(RelicConfig.Arg2)] kazan"
  },
  Event_142000_ChoiceDesc3 = {
    Text = "[Havuzun Dibini El Yordamıyla Ara] Altın Kalıntı [(RelicConfig.Arg1)] kazan"
  },
  Event_142000_Desc = {
    Text = "Rüzgâr kırdan geçti, her yer sessizliğe büründü; yalnızca ağaçların hışırtısı duyuluyordu.\nAniden, bir şeyin şırıl şırıl aktığını duydun; sesi takip ettin ve keskin tatlı bir kan kokusu seni önce karşıladı. Sonunda o su sesinin kaynağını gördün — içi kırmızıyla dolu bir dilek havuzu; sayısız insanın kanı havuzda Dalgalanıyor, Sanki sıvının altında bir şey fırlamak üzereymiş gibi.\nBir ses yüreğinin derinliklerinden yükseldi: \"Kanını sun, sana lütuf bağışlayacağım.\""
  },
  Event_142000_Name = {
    Text = "Kan Pınarı"
  },
  Event_142001_ChoiceDesc1 = {
    Text = "[Sade Sunu] 2 Kalıntı silmeyi seç, Günahkâr Kalıntı [(RelicConfig.Arg1)] kazan"
  },
  Event_142001_ChoiceDesc2 = {
    Text = "[Adanmış Sunu] 4 Kalıntı silmeyi seç, Mübarek Kalıntı [(RelicConfig.Arg1)] kazan"
  },
  Event_142001_ChoiceDesc3 = {
    Text = "[Biraz Adak Çal, Kimse Bilmez] Altın Kalıntı [(RelicConfig.Arg1)] kazan"
  },
  Event_142001_Desc = {
    Text = "Rüzgâr kırdan geçti, her yer sessizliğe büründü; yalnızca ağaçların hışırtısı duyuluyordu.\nFarkında olmadan eski bir sunağın önüne geldin; devasa heykel seni yukarıdan aşağıya Bakışlarıyla süzdü, sanki elinden bir şey almak istiyordu. Sunağın tam altında bulanık harflerle şunlar yazıyordu: \"Kazanç ve Kayıp Dengede Olmalı\"."
  },
  Event_142001_Name = {
    Text = "Kazanç ve Kayıp Sunağı"
  },
  Event_142002_ChoiceDesc1 = {
    Text = "[Ücretsiz Deneyim] Rastgele Arg2 Gümüş Kalıntı Yükseltmesi"
  },
  Event_142002_ChoiceDesc2 = {
    Text = "[Standart Hizmet] Arg1 Kara Mühür harca: Rastgele Arg2 Gümüş Kalıntı Yükseltmesi"
  },
  Event_142002_ChoiceDesc3 = {
    Text = "[Lüks Hizmet] Arg1 Kara Mühür harca: Rastgele Arg2 Gümüş Kalıntı Yükseltmesi"
  },
  Event_142002_Desc = {
    Text = "Bir meydana geldin; pek çok insan telaşla oradan oraya koşuyor, belki burada ilginç şeyler bulunabilir.\nMeydanın bir köşesinde sıcak ışıklar yanan küçük bir bina sessizce yükseliyor; görünüşe göre üst düzey bir kulüp, ancak duvarda asılı koyu renkli tabelada açıkça şunlar yazıyor: \"Bu işletme yalnızca biyolojik varlıkların dışındakilere hizmet vermektedir.\""
  },
  Event_142002_Name = {
    Text = "Özel Kulüp"
  },
  Event_142003_ChoiceDesc1 = {
    Text = "[Bir Kez Çek] Bir Semptom kartı kazan"
  },
  Event_142003_ChoiceDesc2 = {
    Text = "[Ayrıl] 75 Kara Mühür kazan"
  },
  Event_142003_Desc = {
    Text = "Son derece kalabalık bir yere geliyorsun; herkesin yüzünde mutluluk parıldıyor, geceyi köşeye sıkıştıran renkli ışıklar her yanda Göz Kırpıyor. Her köşedeki tabelalar şunu yazıyor: \"Karnavala hoş geldiniz! Buradaki Rüyaların Sonu yok, buradaki Hazın perdesi kapanmaz!\"\nYol kenarında bir çekiliş tezgahı olduğunu fark ediyorsun; etrafı insan dolu, Herkesin Bakışı sıkıca örtülmüş büyük ödülde toplanmış — Satıcı onun nadirliğini hararetle övüyor, insanlar birbirleriyle yarışarak katılmaya çalışıyor."
  },
  Event_142003_Name = {
    Text = "Çekiliş Meydan Okuması"
  },
  Event_142004_ChoiceDesc1 = {
    Text = "[Bir Süreliğine Kullan]"
  },
  Event_142004_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142004_Desc = {
    Text = "Rüzgâr kırların üzerinden eserken her yer sessizliğe büründü, yalnızca ağaçların hışırtısı duyuluyordu.\nBir anda, ortasında bir örs duran harap bir saman kulübesi gördün; yanında ise paslanmış pek çok metal silah vardı. Burası uzun süredir terk edilmiş bir demirci dükkanına benziyordu. Örsün yanında ayrıntılı bir kullanım kılavuzu bırakılmıştı; Kalıntıları buraya getirerek dönüştürebileceğini açıklıyordu."
  },
  Event_142004_Name = {
    Text = "Demirci Dükkanı"
  },
  Event_142005_ChoiceDesc1 = {
    Text = "[Dürüstçe Bahis Yap] Bir Komut Kartı sil"
  },
  Event_142005_ChoiceDesc2 = {
    Text = "[Hile Dene] Bir Semptom kartı sil"
  },
  Event_142005_ChoiceDesc3 = {Text = "[Leave]"},
  Event_142005_Desc = {
    Text = "Çevrendeki Şerefe sesleri zaferini ilan ediyor; gürültülü kalabalığın arasında Sen de onlar gibi, her şeyi ortaya koyduğun bu tuhaf ve görkemli Rüyaya kapılıyorsun. Elindeki jetonlara bakıyorsun; Sanki onlar sana şan getiren en sadık dostlarınmış gibi. Bahis masasının derinliklerinden bir Fısıltı yükseliyor, belirsiz bir ricayı beraberinde getiriyor: \"tekrar yap, bir kez daha kazan.\""
  },
  Event_142005_Name = {
    Text = "Gürültülü Kumarhane"
  },
  Event_142013_ChoiceDesc1 = {
    Text = "[Büyük Bahis] %50 ihtimalle rastgele Gümüş Kalıntı kazan ve yeniden bahis yap, %50 ihtimalle 75 Kara Mühür kazan ve Elit savaşına gir"
  },
  Event_142013_ChoiceDesc2 = {
    Text = "[Küçük Bahis] %50 ihtimalle rastgele Gümüş Kalıntı kazan ve yeniden bahis yap, %50 ihtimalle 75 Kara Mühür kazan ve Elit savaşına gir"
  },
  Event_142013_Desc = {
    Text = "Garson değişmeyen gülümsemesini koruyarak zar kabını kaldırıyor; berrak bir ses Yankılanıyor ve diğer oyuncular kendi seçimlerini yapıyor. \"Bahisler kapandı,\" diyor, \"lütfen bahsinizi yapın—\""
  },
  Event_142013_Name = {
    Text = "Gürültülü Kumarhane"
  },
  Event_142073_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142073_Desc = {
    Text = "Garson zar kabını kaldırıyor; birkaç saniyeliğine hava Sanki Durağanlaşıyor. Cevap açıklandığı an, zafer çığlıkları ile hayal kırıklığı iniltilerinin iç içe geçtiğini duyuyorsun. Şans sana Lütuf göstermedi; masada sessizce yatan birkaç zar sana zıt bir cevap verdi. Son bir kez etrafına bakıyorsun, o Deliliğe kapılmış kumarbazlara bir göz atıyorsun. Gitme vakti geldi."
  },
  Event_142073_Name = {
    Text = "Gürültülü Kumarhane"
  },
  Event_142074_ChoiceDesc1 = {
    Text = "[Savaşa Gir]"
  },
  Event_142074_Desc = {
    Text = "Heyecanla bahis masasına odaklanmışken bileğin aniden sıkıca kavranıyor; başını kaldırıp baktığında kumarhanenin Boss'u seni tepeden süzüyor, kurallara uymayan herkesi dışarı çıkarmaya hazırlanıyor. Bir anda tüm bakışlar sende toplanıyor; şaşkın, düşmanca, şamata çıkarmaktan zevk alan bakışlar... Anlıyorsun ki bir insan belki defalarca hile yapabilir, ama Yeter Ki bir kez Keşfedilsin, tam bir çöküşle yüzleşmek zorunda kalır."
  },
  Event_142074_Name = {
    Text = "Gürültülü Kumarhane"
  },
  Event_142103_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142103_Desc = {
    Text = "Fiziksel yollarla kumarhaneden başarıyla sıyrılıyorsun; Kalabalığın gürültüsünü geride bırakarak adımlarını hızlandırıyorsun — bu dağınıklığa gelince, onu toplayacak biri mutlaka çıkar."
  },
  Event_142103_Name = {
    Text = "Gürültülü Kumarhane"
  },
  Event_142105_ChoiceDesc1 = {
    Text = "[Bir Kez Daha Çek] Bir Semptom kartı kazan"
  },
  Event_142105_ChoiceDesc2 = {
    Text = "[Ayrıl] 75 Kara Mühür kazan"
  },
  Event_142105_Desc = {
    Text = "Bir kez çekmeyi deniyorsun; hiçbir şey olmuyor. Ama kartın arkasında şunlar yazıyor: \"Bir sonraki daha kolay\"\n......Bir kez daha denemeli misin?"
  },
  Event_142105_Name = {
    Text = "Çekiliş Meydan Okuması"
  },
  Event_142106_ChoiceDesc1 = {
    Text = "[Bir Kez Daha Çek] Bir Semptom kartı kazan"
  },
  Event_142106_ChoiceDesc2 = {
    Text = "[Ayrıl] 75 Kara Mühür kazan"
  },
  Event_142106_Desc = {
    Text = "Bir kez çekmeyi deniyorsun; hiçbir şey olmuyor. Ama kartın arkasında şunlar yazıyor: \"Bir sonraki daha kolay\"\n......Bir kez daha denemeli misin?"
  },
  Event_142106_Name = {
    Text = "Çekiliş Meydan Okuması"
  },
  Event_142107_ChoiceDesc1 = {
    Text = "[Bir Kez Daha Çek] Bir Semptom kartı kazan"
  },
  Event_142107_Desc = {
    Text = "Bir kez çekmeyi deniyorsun; hiçbir şey olmuyor. Ama kartın arkasında şunlar yazıyor: \"Bir sonraki daha kolay\"\n......Bir kez daha denemeli misin?"
  },
  Event_142107_Name = {
    Text = "Çekiliş Meydan Okuması"
  },
  Event_142108_ChoiceDesc1 = {
    Text = "[Bir Kez Daha Çek] Bir Semptom kartı kazan"
  },
  Event_142108_ChoiceDesc2 = {
    Text = "[Ayrıl] 75 Kara Mühür kazan"
  },
  Event_142108_Desc = {
    Text = "Bir kez çekmeyi deniyorsun; hiçbir şey olmuyor. Ama kartın arkasında şunlar yazıyor: \"Bir sonraki daha kolay\"\n......Bir kez daha denemeli misin?"
  },
  Event_142108_Name = {
    Text = "Çekiliş Meydan Okuması"
  },
  Event_142109_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142109_Desc = {
    Text = "Kalp atışlarını dinlerken çekiliş biletini açtın ve göz alıcı altın renkli harfler gözlerine çarptı. Satıcı heyecanla zili salladı, tüm yoldan geçenler sana imrenerek baktı.\n\"Büyük ödül çekildi!\""
  },
  Event_142109_Name = {
    Text = "Çekiliş Meydan Okuması"
  },
  Event_142110_ChoiceDesc1 = {
    Text = "[Bir Kez Daha Çek] Bir Semptom kartı kazan"
  },
  Event_142110_ChoiceDesc2 = {
    Text = "[Ayrıl] 75 Kara Mühür kazan"
  },
  Event_142110_Desc = {
    Text = "Bir kez çekmeyi deniyorsun; hiçbir şey olmuyor. Ama kartın arkasında şunlar yazıyor: \"Bir sonraki daha kolay\"\n......Bir kez daha denemeli misin?"
  },
  Event_142110_Name = {
    Text = "Çekiliş Meydan Okuması"
  },
  Event_142118_ChoiceDesc1 = {
    Text = "[Takas] 1 Kalıntı kaldır, %25 olasılıkla 3'ten 1 Krono Sarkaç kazan, %50 olasılıkla rastgele 2 Altın Kalıntı kazan, %25 olasılıkla 25 Kara Mühür kazan"
  },
  Event_142118_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142118_Desc = {
    Text = "Tüccar, uzattığın eşyayı aldı ve ay ışığına tutarak defalarca inceledi; gözleri neredeyse fırlayacaktı. Uzun süre bekledin; sonunda köşe bucak sırıttı ve çantasından paslı bir demir kutu çıkardı. \"Haydi aç bakalım, bu sıralar en moda kör kutu bu.\"\nAçtın; ancak içinde yalnızca pek de hoş olmayan birkaç Kara Mühür olduğunu keşfettin. Tüccar ellerini ovuşturdu ve özür dolu gözlerle bir kez daha deneyebileceğini söyledi."
  },
  Event_142118_Name = {
    Text = "Perişan Tüccar"
  },
  Event_142119_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142119_Desc = {
    Text = "Tüccar, uzattığın eşyayı aldı ve ay ışığına tutarak defalarca inceledi; gözleri neredeyse fırlayacaktı. Uzun süre bekledin; sonunda köşe bucak sırıttı ve çantasından paslı bir demir kutu çıkardı. \"Haydi aç bakalım, bu sıralar en moda kör kutu bu.\"\nAçtın; içinde bir şey yatıyordu."
  },
  Event_142119_Name = {
    Text = "Perişan Tüccar"
  },
  Event_142120_ChoiceDesc1 = {
    Text = "[Takas] 1 Altın Kalıntı kaldır, %50 olasılıkla 3'ten 1 Krono Sarkaç kazan, %50 olasılıkla 3'ten 1 Mübarek Kalıntı kazan"
  },
  Event_142120_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142120_Desc = {
    Text = "Kör kutuyu bir kez daha açtın; ancak yine istediğin eşyayı bulamadın. Tüccar hemen gülümseyerek özür diledi ve bir demir kutu daha çıkarıp iki eliyle sana uzattı.\n\"Kızma müşteri! Yemin ederim, bu sefer kesinlikle harika bir şey var içinde...\" diye konuşurken bir elini usulca geri çekti ve sana açık tuttu: \"Elbette, hazine hazineyle değişilir.\""
  },
  Event_142120_Name = {
    Text = "Perişan Tüccar"
  },
  Event_142138_ChoiceDesc1 = {
    Text = "[Bir Süreliğine Kullan]"
  },
  Event_142138_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142138_Desc = {
    Text = "Bu aletleri başarıyla kullandın; biraz hasar görmüş olsalar da hâlâ kullanılabilir görünüyorlar."
  },
  Event_142138_Name = {
    Text = "Demirci Dükkanı"
  },
  Event_142139_ChoiceDesc1 = {
    Text = "[Parçala ve Dök] 1 Altın Kalıntı seçerek sil, 2 Gümüş Kalıntı kazan, 50 Kara Mühür kazan"
  },
  Event_142139_ChoiceDesc2 = {
    Text = "[Arındır] 2 Kalıntı seçerek sil, Altın Kalıntı [(RelicConfig.Arg1)] kazan."
  },
  Event_142139_ChoiceDesc3 = {
    Text = "[Premium Arındırma] 2 Altın Kalıntı seçerek sil, Krono Sarkaç [(RelicConfig.Arg1)] kazan."
  },
  Event_142139_Desc = {
    Text = "Bir yanda duran çekici aldın ve..."
  },
  Event_142139_Name = {
    Text = "Demirci Dükkanı"
  },
  Event_142140_ChoiceDesc1 = {
    Text = "[Bir Süreliğine Kullan]"
  },
  Event_142140_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142140_Desc = {
    Text = "Bu aletleri başarıyla kullandın; biraz hasar görmüş olsalar da hâlâ kullanılabilir görünüyorlar."
  },
  Event_142140_Name = {
    Text = "Demirci Dükkanı"
  },
  Event_142141_ChoiceDesc1 = {
    Text = "[Parçala ve Dök] 1 Altın Kalıntı seçerek sil, 2 Gümüş Kalıntı kazan, 50 Kara Mühür kazan"
  },
  Event_142141_ChoiceDesc2 = {
    Text = "[Arındır] 2 Kalıntı seçerek sil, Altın Kalıntı [(RelicConfig.Arg1)] kazan."
  },
  Event_142141_ChoiceDesc3 = {
    Text = "[Premium Arındırma] 2 Altın Kalıntı seçerek sil, Krono Sarkaç [(RelicConfig.Arg1)] kazan."
  },
  Event_142141_Desc = {
    Text = "Bir yanda duran çekici aldın ve..."
  },
  Event_142141_Name = {
    Text = "Demirci Dükkanı"
  },
  Event_142142_ChoiceDesc1 = {
    Text = "[Parçala ve Dök] 1 Altın Kalıntı seçerek sil, 2 Gümüş Kalıntı kazan, 50 Kara Mühür kazan"
  },
  Event_142142_ChoiceDesc2 = {
    Text = "[Arındır] 2 Kalıntı seçerek sil, Altın Kalıntı [(RelicConfig.Arg1)] kazan."
  },
  Event_142142_ChoiceDesc3 = {
    Text = "[Premium Arındırma] 2 Altın Kalıntı seçerek sil, Krono Sarkaç [(RelicConfig.Arg1)] kazan."
  },
  Event_142142_Desc = {
    Text = "Bir yanda duran çekici aldın ve..."
  },
  Event_142142_Name = {
    Text = "Demirci Dükkanı"
  },
  Event_142167_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142167_Desc = {
    Text = "Üç kez kullanımın ardından örs tamamen çöktü, çekiç de aşınmalarla doldu; artık kullanılamaz hâle gelmiş gibi görünüyor."
  },
  Event_142167_Name = {
    Text = "Demirci Dükkanı"
  },
  Event_142235_ChoiceDesc1 = {
    Text = "[İlerlemeye Devam Edeceğim] \"Lekesizlik\" kazan—tüm Komut Kartları kalıcı olarak 20 yığın Güçlendirme alır."
  },
  Event_142235_ChoiceDesc2 = {
    Text = "[Geri Dönmeyeceğim] \"Yüceleşme\" kazan—S-Enerjisi ve Aliemus Sınırı kalıcı olarak -%20."
  },
  Event_142235_Desc = {
    Text = "Gözlerinin önü aniden bir sisle kaplandı, dünya bulanıklaşmaya başladı; o baş dönmesi içinde, kalbinin derinliklerinden bir ses yükseldi:\n\"Hâlâ ilerlemeye devam edecek misin?\""
  },
  Event_142235_Name = {
    Text = "Son Durak Yaklaşıyor"
  },
  Event_142925_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142925_Desc = {
    Text = "Kulübün çalışanı ücreti kabul ederek sana temel hizmeti sundu. Teslim ettiğin eşyaları simsiyah bir bölmeye götürdü; bekleme süresi uzun değildi; yeniden ortaya çıktığında eşyalar tepside yerini almıştı ve eskisinden biraz farklı görünüyordu."
  },
  Event_142925_Name = {
    Text = "Özel Kulüp"
  },
  Event_142926_ChoiceDesc1 = {
    Text = "[Bir Altın Kalıntı Sil] (Altın Kalıntı gerektirir)"
  },
  Event_142926_ChoiceDesc2 = {
    Text = "[Güçlendirme (Forged) Kalıntısı Seçilebilir]"
  },
  Event_142926_ChoiceDesc3 = {Text = "[Leave]"},
  Event_142926_Desc = {
    Text = "\"Kalıntı Miktarı\" \"Kalıntı Listesi Seç\" testi"
  },
  Event_142927_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142927_Desc = {
    Text = "Kulübün çalışanı ücreti kabul ederek sana lüks hizmeti sundu. Eşyalarını özenle bir kutuya yerleştirip simsiyah bir bölmeye götürdü. Uzun süre bekledin; ta ki yeniden ortaya çıkıp eşyaları iki eliyle sana sunana kadar; yüzündeki ifade her zamanki gibi sakindi."
  },
  Event_142927_Name = {
    Text = "Özel Kulüp"
  },
  Event_142928_ChoiceDesc1 = {
    Text = "[En Fazla 2 Uyandırıcı Seç, Aliemus'u Doldur]"
  },
  Event_142928_ChoiceDesc2 = {
    Text = "[2 Uyandırıcı'nın Aliemus ile dolu olması zorunludur]"
  },
  Event_142928_ChoiceDesc3 = {Text = "[Leave]"},
  Event_142928_Desc = {
    Text = "\"Koşullu Uyandırıcı Seçimi\" testi"
  },
  Event_142929_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142929_Desc = {
    Text = "Araştırmacı etrafında defalarca döndü, uzun süre dikkatle inceledi, ardından çalışmaya başladı — görüşünü sormadı. Bir süre geçtikten sonra, bu tuhaf araştırma odasından ayrılmaya hazırlanırken pek çok şeyi gerçekten kaybettiğini fark ettin; ama o ellerini çırparak seni kutladı: \"İşte evrimin özü bu!\""
  },
  Event_142929_Name = {Text = "Evrimci"},
  Event_142930_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142930_Desc = {
    Text = "Elini uzatarak Kızıl renkli havuz suyunun içine daldırdın ve işe yarar bir şeye dokundun."
  },
  Event_142930_Name = {
    Text = "Kan Pınarı"
  },
  Event_142931_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142931_Desc = {
    Text = "Ses uzaklaştı, kalbin kararlılıkla doldu ve içinde Gücün Belirdiğini hissettin."
  },
  Event_142931_Name = {
    Text = "Son Durak Yaklaşıyor"
  },
  Event_142932_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142932_Desc = {
    Text = "Ses uzaklaştı, kalbin kararlılıkla doldu ve zihnin daha da berraklaştı."
  },
  Event_142932_Name = {
    Text = "Son Durak Yaklaşıyor"
  },
  Event_142933_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142933_Desc = {
    Text = "Dağ gibi yığılmış adakların arasından biraz aldın, ardından hızla sıvıştın; ayrılırken heykelin gözleri sanki kıpırdadı."
  },
  Event_142933_Name = {
    Text = "Kazanç ve Kayıp Sunağı"
  },
  Event_142934_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142934_Desc = {
    Text = "Savunma yönüne odaklı antrenman yaptın; rakibinin pusularına karşı silahınla sürekli direndin ve savunma yeteneğin ile reflekslerin gelişti."
  },
  Event_142934_Name = {
    Text = "Özel Antrenman Zamanı"
  },
  Event_142935_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142935_Desc = {
    Text = "Araştırmacı eldivenlerini taktı, dolabın üzerinden garip şekilli bazı aletler aldı ve önünde bir süre bunlarla hareketler yaptı. Ne yaptığını tam olarak anlamadın, ama gerçekten biraz rahatladığını hissettin."
  },
  Event_142935_Name = {Text = "Evrimci"},
  Event_142936_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142936_Desc = {
    Text = "Belirli bir yön seçmek yerine, vücudunun sınırlarını hiçe sayarak başkalarıyla dövüş pratiği yaptın; ta ki herkes bitap düşene kadar. Çok şey kazandığını biliyorsun, ama aynı zamanda bunun bedelini de ödedin."
  },
  Event_142936_Name = {
    Text = "Özel Antrenman Zamanı"
  },
  Event_142937_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142937_Desc = {
    Text = "Çantandan rastgele birkaç şey alıp sunağa bıraktın ve karşılığında eşdeğer bir ödül aldın."
  },
  Event_142937_Name = {
    Text = "Kazanç ve Kayıp Sunağı"
  },
  Event_142938_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142938_Desc = {
    Text = "Değerli adaklar sundun ve karşılığında eşdeğer bir ödül aldın."
  },
  Event_142938_Name = {
    Text = "Kazanç ve Kayıp Sunağı"
  },
  Event_142939_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142939_Desc = {
    Text = "Onun araştırma yöntemlerine dair derin sorgulamalarla dolduydu için; uzun bir tartışmanın ardından bu aletleri kendin kullanmana ve \"evrimi\" farklı bir yoldan aramanı kabul etti.\nAynı aletlerle, yanlışlıkla \"silinmesi\" gereken şeyleri büyük miktarda \"çoğalttın\"; ayrılmadan önce Araştırmacının feryatlarını duydun."
  },
  Event_142939_Name = {Text = "Evrimci"},
  Event_142940_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142940_Desc = {
    Text = "Kulübün çalışanı sana ücretsiz hizmet sundu; teslim ettiğin eşyaları simsiyah bir bölmeye götürdü, kısa bir süre sonra geri döndü, eşyaları sessizce ellerine bıraktı ve tek kelime etmedi."
  },
  Event_142940_Name = {
    Text = "Özel Kulüp"
  },
  Event_142941_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142941_Desc = {
    Text = "Dilek havuzuna bol miktarda Kan sundun, havuzun içinden değerli bir armağan belirdi."
  },
  Event_142941_Name = {
    Text = "Kan Pınarı"
  },
  Event_142942_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142942_Desc = {
    Text = "Saldırı yönüne odaklı antrenman yaptın; çelik çarpışmalarında vuruş tekniğin ve hızın gelişti."
  },
  Event_142942_Name = {
    Text = "Özel Antrenman Zamanı"
  },
  Event_142943_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142943_Desc = {
    Text = "Dilek havuzuna az miktarda Kan sundun, havuzun içinden bir armağan belirdi."
  },
  Event_142943_Name = {
    Text = "Kan Pınarı"
  },
  Event_142944_ChoiceDesc1 = {
    Text = "[Yükseltilecek Kalıntıyı Seç]"
  },
  Event_142944_ChoiceDesc2 = {
    Text = "[Rastgele Kalıntı Yükselt]"
  },
  Event_142944_ChoiceDesc3 = {
    Text = "[Ayrıl (Test)]"
  },
  Event_142944_Desc = {
    Text = "\"Kalıntı Yükseltme Özelliği\" testi, Kalıntı kendi ekler"
  },
  Event_146258_ChoiceDesc1 = {
    Text = "[Ona Seslен] Lanetli Kalıntı \"(RelicConfig.Arg1)\" kazan, \"(Skill.Arg2)\" Enfekte Et"
  },
  Event_146258_ChoiceDesc2 = {
    Text = "[Onlara Karşılık Ver] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: [(EnchantConfig.Arg1)]"
  },
  Event_146258_ChoiceDesc3 = {
    Text = "[Ignore Them] 50 Kara Mühür kazan"
  },
  Event_146258_Desc = {
    Text = "Sunakta Juliette'in beyaz cüppesi yoğun dumana bulanmış, tütsü külü tatlı, bakırlı bir kokuyla karışmış.\n\n\"Işık Taşıyıcı bu dünyanın günahkâr çocuklarına acır...\" sesi yüksek değil, ama tapınağın fısıldayan dualarını açıkça kesiyor, \"...seven bir annenin kucağındaki bebeğe acıması gibi.\"\n\nMum ışığında sunaktaki adaklar yağla parlıyor. Mavi duman kıvrımları onların hatları boyunca yukarı doğru bükülerek aşağıdaki kalabalığın yüzlerini bulanıklaştırıyor.\n\nO sallanan sis arasından Pollux'a bakıyorsun. Cemaatin arasında duruyor, gözleri yerde, yüzünde mükemmel biçimde prova edilmiş, görev bilinciyle dolu bir dindarlık ifadesi var."
  },
  Event_146258_Name = {
    Text = "Eski Bir Rüya: III"
  },
  Event_146259_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146259_Desc = {
    Text = "Aldırma. Bu yalnızca kar rüzgarının uluması, donmuş gölün iç çekişi ya da zirvelerin yasıdır.\n\nKuru, ölü dalların birbirine sürtünürken fısıldamasıdır.\n\nBuzlu yarıklarda can veren her öncü için ebedi, hüzünlü bir kederle mırıldanıyorlar."
  },
  Event_146259_Name = {
    Text = "Donmuş Gölün Aryası"
  },
  Event_146260_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146260_Desc = {
    Text = "Adalet mutlak bir eşitlik anlamına geliyorsa, Helot-catena'nın dilek dileme hakkını seninle paylaşması gerekir mi?\n\nEğer öyleyse, seni geçip rakipleri devre dışı bırakmasını umursamazdan gelmeli misin?\n\n\"Hayal kurmayı bırak ve tırmanmaya devam et!\" diye bağırıyor Caraboo'nun sesi kulağında."
  },
  Event_146260_Name = {
    Text = "Saçma Adalet"
  },
  Event_146261_ChoiceDesc1 = {
    Text = "[Dağ Açlıktan Korkar]"
  },
  Event_146261_ChoiceDesc2 = {
    Text = "[Dağ Kayıptan Korkar]"
  },
  Event_146261_ChoiceDesc3 = {
    Text = "[Dağ Ölümden Korkar]"
  },
  Event_146261_Desc = {
    Text = "Dağın bedeni üzerinde yürüyorsun. Titremeleri sırlarını ele veriyor. Dağın arzuladığı şey, dağın korktuğu şeyi tanımlar."
  },
  Event_146261_Name = {
    Text = "Dağın Sırrı"
  },
  Event_146262_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146262_Desc = {
    Text = "Kendini ipek gibi tüylerinde kaybediyorsun, kendi arzularının istekli bir tutsağı olarak. Kediyi okşamak bu kadar tatmin edici. Derinin altında ne yattığının ne önemi var? Gerçekten önemli mi ki?"
  },
  Event_146262_Name = {
    Text = "Sürünen Siyah Kedi"
  },
  Event_146263_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146263_Desc = {
    Text = "İpliğin ucunu sessizce alıp bileğine bağlıyorsun.\n\nPollux da aynısını yapıyor. Kısa süre sonra ince bir kırmızı çizgi ikinizi birbirine bağlıyor.\n\nKatabileceğiniz mesafeyi kısıtlıyor, ama zaten hep birlikte yaşayıp birlikte ölmek için yaratılmadınız mı?\n\nGerisini kadere bırakacaksın."
  },
  Event_146263_Name = {
    Text = "Eski Bir Rüya: I"
  },
  Event_146264_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146264_Desc = {
    Text = "\"Bunun zor olduğunu biliyorum, evladım. Elbette biliyorum. Ama dünya hiçbirimiz için hiçbir zaman nazik bir yer olmadı.\"\n\n\"Bir gün, kelebek avucundan kaçacak ve sonsuza dek gidecek.\""
  },
  Event_146264_Name = {
    Text = "Yanılsama, Gerçek Değil"
  },
  Event_146265_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146265_Desc = {
    Text = "William başını kaldırıyor, bakışları seni süzüp uzaktaki karla kaplı sırtlara takılıyor.\n\n\"Özür dilemeni gerektiren bir şey yok,\" diyor sessizce ama kararlılıkla. \"Bazı sorular yalnızca bana ait ve yalnızca ben yanıtlayabilirim.\"\n\n\"Ama teşekkür ederim. Keskin gözlerin için."
  },
  Event_146265_Name = {
    Text = "Nazik Dalış"
  },
  Event_146266_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146266_Desc = {
    Text = "William'ın gözleri titriyor.\n\nAğzını açıyorsun ama hiçbir şey söylememeyi tercih ediyorsun. Burada sessizlik daha iyi bir seçim. İkiniz arasında hâlâ nadir, sessiz bir anlayış var; bunu mahvetmeye gerek yok."
  },
  Event_146266_Name = {
    Text = "Nazik Dalış"
  },
  Event_146267_ChoiceDesc1 = {
    Text = "[Leave] [(RelicConfig.Arg1)] Gümüş Kalıntıyı edin"
  },
  Event_146267_Desc = {
    Text = "\"Geri ver, geri ver! Bu benim gücüm!\"\n\nDağ ağlıyor; dağ feryat ediyor. Bir zamanlar sahip olduğu her şeyden soyulup atılmaya dayanamıyor."
  },
  Event_146267_Name = {
    Text = "Dağın Sırrı"
  },
  Event_146268_ChoiceDesc1 = {
    Text = "[Koşmaya Devam Et] \"(EnchantConfig.Arg1)\" Mühürünü 3 Komut Kartından 1'ine Kazı, ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_146268_ChoiceDesc2 = {
    Text = "[Zamanını Bekle] 3 Mühürden 1'ini edin"
  },
  Event_146268_ChoiceDesc3 = {
    Text = "[Yavaşça Sıvış]"
  },
  Event_146268_Desc = {
    Text = "\"Dikkatli ol, Castor. Karga izliyor.\"\n\nÖne doğru acele ediyorsun, Pollux sırtında. Onun paniğe kapılmış gözleri her karanlık köşeyi tarıyor, hiçbir şey bulamıyor.\n\n\"Üstümüzde!\"\n\nAniden bir ürperti geçiyor içinden. Yukarı bakıyorsun.\n\nSaçağın gölgesinde sessizce çömelmiş bir karga var. Tüm vücudunu kaplayan iğrenç gözler her yöne bakıyor; şimdi tüm bakışlarını ikinize odaklıyor."
  },
  Event_146268_Name = {
    Text = "Eski Bir Rüya: II"
  },
  Event_146269_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146269_Desc = {
    Text = "Eğitimden hatırladığın uyarılar aklına geliyor: emniyet halatına tamamen güvenme.\n\nDik kayadan iterek umutsuzca inişini dengelemeyi başarıyorsun. Ama çantandan bir şey kayıp düşüyor, kayalıktan aşağı yuvarlanarak küçücük, görünmez bir noktaya dönüşüyor.\n\nNe önemi var. En azından hayattasın."
  },
  Event_146269_Name = {
    Text = "Sessiz Düşüş"
  },
  Event_146270_ChoiceDesc1 = {
    Text = "[Listen Closely] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ama \"(Skill.Arg2)\" geliştir."
  },
  Event_146270_ChoiceDesc2 = {
    Text = "[Plug Ears] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_146270_Desc = {
    Text = "Rüzgar ve kar kaya yüzeyine çarpıyor, buzun derinliklerinden gelen hayalet gibi hafif çatırtılarla karışarak bir dizi ağlayan iç çekişe dönüşüyor.\n\nSessiz yüksekliklerde yapayalnız dururken dağın melodisini aniden duyuyorsun.\n\nIssız ve ağırbaşlı — yalnızca ölüler için söylenmiş alçak, derin bir ilahi."
  },
  Event_146270_Name = {
    Text = "Doğanın Fantazyası"
  },
  Event_146271_ChoiceDesc1 = {
    Text = "[Bu Zil Sesi] \"(Skill.Arg1)\" geliştir, 1 rastgele Komut Kartına \"(EnchantConfig.Arg2)\" Mühürünü işle"
  },
  Event_146271_ChoiceDesc2 = {
    Text = "[Bu Yiyecek] \"(Skill.Arg1)\" geliştir, 1 rastgele Komut Kartına \"(EnchantConfig.Arg2)\" Mühürünü işle"
  },
  Event_146271_ChoiceDesc3 = {
    Text = "[Bu Köpeğin Beklentisi] 1 rastgele Komut Kartına \"(EnchantConfig.Arg1)\" Mühürünü işle"
  },
  Event_146271_Desc = {
    Text = "\"Pavlov zili çalar, sonra köpeği besler. Zamanla, yalnızca zilin sesi köpeğin ağzını sulandırır.\"\n\n\"Peki. Köpeğin ağzını gerçekten sulandıran nedir?\""
  },
  Event_146271_Name = {
    Text = "Pavlov Refleksi"
  },
  Event_146272_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146272_Desc = {
    Text = "Arkana bakma. William tam orada, bir kol mesafesinde. Kederin seni yutmasına izin verme. Çok şeyi kaçırdın, ama bunu hâlâ düzeltebilirsin."
  },
  Event_146272_Name = {
    Text = "Öte Yakadan"
  },
  Event_146273_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146273_Desc = {
    Text = "\"Elini kapat.\"\n\n\"Bir zamanlar narin olan her şey, avucunun içinde kara bir çamurdan başka bir şeye dönüşmeden erimeyecek.\""
  },
  Event_146273_Name = {
    Text = "Yanılsama, Gerçek Değil"
  },
  Event_146274_ChoiceDesc1 = {
    Text = "[Hey! Geri Dön!] 50 Kara Mühür kazan"
  },
  Event_146274_ChoiceDesc2 = {
    Text = "[Kediyi Okşa] 75 Kara Mühür kazan, ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_146274_Desc = {
    Text = "<Italic:\"Miyav.\"> Parlak yeşim taşı renkli gözlere sahip siyah bir kedi, sessiz ve hafif adımlarla başını baldırına sürtüyor.\n\nO anda, \"N\"nin gittiğini fark ediyorsun."
  },
  Event_146274_Name = {
    Text = "Sürünen Siyah Kedi"
  },
  Event_146275_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146275_Desc = {
    Text = "Ses çıkarmıyorsun. Sadece bakışlarının sis içinde süzülmesine izin vererek Pollux'un gözlerine takılıyorsun, gözlerini kaçırmayı reddediyorsun.\n\nO da bakışlarından kaçınmıyor. Kardeşin hep böyleydi — iliklerine kadar inatçı, başını ilk eğen olmayı reddeden.\n\nSalondaki ilahi, kül kokusu, Juliette'in merhamet ve fedakârlık üzerine vaazı... aniden hepsi uzaklaşıyor. Sanki yalnızca ikiniz kalıyorsunuz, bu boş acıma salonunda, zamanın uçsuz bucaksız genişliğinde birbirinize bakarak."
  },
  Event_146275_Name = {
    Text = "Eski Bir Rüya: III"
  },
  Event_146276_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146276_Desc = {
    Text = "Bu anda, uzun ve soluk anılarının tek nöbetçisisin.\n\nWendigo, dal gibi pençelerini uzatarak doğruca kalbine nişan alıyor, ama onu saf irade gücünle geri püskürtüyorsun.\n\nSendeler, yutan sise geri çekiliyor; geride yalnızca kuru, hırıltılı bir fısıltı bırakıyor:\n\n\"Er ya da geç, onları bana sunacaksın... ve bunu isteyerek yapacaksın.\""
  },
  Event_146276_Name = {Text = "Yutıcı"},
  Event_146277_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146277_Desc = {
    Text = "Uzak bir rüya. Çocukluğundan bir rüya.\n\n\"Kendine gel,\" diye hatırlatıyorsun kendine. \"Artık orada değiliz.\"\n\nGerçeğe dönüyorsun, yalnızca dondurucu karda ayakta durduğunu, etrafının tarikat üyeleriyle çevrili olduğunu ve Pollux'un bıçağının doğrudan göğsüne yöneldiğini görüyorsun."
  },
  Event_146277_Name = {
    Text = "Eski Bir Rüya: I"
  },
  Event_146278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146278_Desc = {
    Text = "\"Ölümün gelmesi gerektiğini kabul ediyorum.\"\n\n\"Kemiklerimi bu zorlu hac yolculuğuna isteyerek sunuyorum.\"\n\n\"Uçurumun altında, gökyüzü ve yeryüzü benim anıtımı inşa edecek.\""
  },
  Event_146278_Name = {
    Text = "Ölüm Alameti"
  },
  Event_146279_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146279_Desc = {
    Text = "Yansıma, ışığın bir oyunundan başka bir şey değil. Tinktur'un gördüğü muhtemelen kendi gölgesiydi.\n\nAna gezegeni milyonlarca ışık yılı uzakta; seyrüseferdeki en ufak bir hata onları farklı galaksilere savurabilirdi. Bu düşüncelerle kendini teselli ederek ayaklarının altında ne yattığını kafana takmaktan vazgeçiyorsun."
  },
  Event_146279_Name = {
    Text = "Batık Yansıma"
  },
  Event_146280_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146280_Desc = {
    Text = "Yıldızlardan geliyor. Zamanın derin şafağından. İnsanlığın henüz bilmediği ve belki hiç bilemeyeceği şeylerden.\n\nOnlardan cevap isteme.\n\nBedelini bilmiyorsun."
  },
  Event_146280_Name = {
    Text = "Donmuş Gölün Aryası"
  },
  Event_146281_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146281_Desc = {
    Text = "Duraksıyorsun, o kasvetli müziğin kulaklarını doldurmasına izin veriyorsun.\n\nRüzgar bir kemandır, ısıran kar bir davul ritmidir, uzaktan gelen buzun çatırdaması ise uzun süredir bastırılmış alçak bir armonidir.\n\nTemini çözemiyorsun, ama geçmişte de gelecekte de burada gömülü sayısız yolcu için çalmaya devam edeceğini biliyorsun."
  },
  Event_146281_Name = {
    Text = "Doğanın Fantazyası"
  },
  Event_146283_ChoiceDesc1 = {
    Text = "[Gözler Gökyüzüne] Tüm Uyandırıcılar Arg1 Aliemus kazanır"
  },
  Event_146283_ChoiceDesc2 = {
    Text = "[Donmuş Zirveyi Çiğne] 2 Uyandırıcıyı Uyandırmayı seç"
  },
  Event_146283_Desc = {
    Text = "Zirve, bulut ve sis perdesinin ardında sessizce parıldar. Uçurumlar, dik kayalıklar, uğuldayan fırtınalar—burada yaşayan hiçbir şey ölümlü gözler için tasarlanmamıştır. Tüm bunların karşısında sen son derece kırılgansın."
  },
  Event_146283_Name = {
    Text = "Zirveye Dokunmak"
  },
  Event_146284_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146284_Desc = {
    Text = "\"Hayır, senin suçun değil. Sen yalnızca kader tarafından kurulmuş bir saat oyuncağısın.\""
  },
  Event_146284_Name = {
    Text = "Obur Sıçan"
  },
  Event_146285_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146285_Desc = {
    Text = "\"Anlıyorum. Sen nesnel deneyime güvenen türdensin. Ama unutma: bazen, özdeş yüzeylerin altında, bambabambaşka gerçekler kıvrılıp yatar.\"\n\nZilin kahkahası uzaklara karışıyor."
  },
  Event_146285_Name = {
    Text = "Pavlov Refleksi"
  },
  Event_146286_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146286_Desc = {
    Text = "Adalet, iyinin ve kötünün hak ettiğini bulması anlamına geliyorsa, bu yargıyı kim veriyor?\n\nAnubis ve terazisi mi? Ölüler diyarının yerçekimi fizik yasalarına uyuyorsa, kalbimin onun tüyünden hafif olduğundan pek emin değilim."
  },
  Event_146286_Name = {
    Text = "Saçma Adalet"
  },
  Event_146287_ChoiceDesc1 = {
    Text = "[Cevap Ara] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, \"(Skill.Arg2)\" geliştir"
  },
  Event_146287_ChoiceDesc2 = {
    Text = "[Sessiz Kal] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, \"(Skill.Arg2)\" geliştir"
  },
  Event_146287_ChoiceDesc3 = {
    Text = "[Özür Dile] 25 Kara Mühür kazan"
  },
  Event_146287_Desc = {
    Text = "\"Kıdemli William, Wendigo'nun büyüsü diğer herkesi etkisi altına aldığında, sen ilk kendine gelen gibi görünüyordun. Onlarla doğrudan yüzleşmek üzereyiz. Bir tavsiyeniz var mı?\n\"\nWilliam'ın gözleri titriyor. Onlarda anlık bir şey yakalıyorsun; ele geçmez, hüzünlü ve dingin — güneş ışığıyla aydınlanan sularda sürüklenen, karanlık deniz tabanına doğru yavaşça batan bir beden gibi.\n\n\"Üzgünüm,\" diyor. \"Korkarım bu konuda sana yardımcı olamam.\""
  },
  Event_146287_Name = {
    Text = "Nazik Dalış"
  },
  Event_146288_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146288_Desc = {
    Text = "\"Sanata bu kadar kör, bu kadar korkunç derecede kör,\" diye mırıldanıyor karanlık bir gölge, karanlıktan çıkarken başını sallayarak. \"Gerçek zehir olabilir. Bazen, özenle korunan bir yanılsama, kırılgan mutluluğumuzu ayakta tutan tek şeydir, değil mi?\""
  },
  Event_146288_Name = {
    Text = "Sürünen Siyah Kedi"
  },
  Event_146290_ChoiceDesc1 = {
    Text = "[Katil Kim?] \"(Skill.Arg1)\" geliştir, 1 rastgele karta \"(EnchantConfig.Arg2)\" Mühürünü işle"
  },
  Event_146290_ChoiceDesc2 = {
    Text = "[Bu Benim Hatam] \"(Skill.Arg1)\" geliştir, 1 rastgele karta \"(EnchantConfig.Arg2)\" Mühürünü işle"
  },
  Event_146290_ChoiceDesc3 = {
    Text = "[Bu Oburluğun Bedeli] 3 Komut Kartından 1'ine \"(EnchantConfig.Arg1)\" Mühürünü işle"
  },
  Event_146290_Desc = {
    Text = "<Italic:\"Koş koş, küçük fare,\n\nUzun ve karanlık lağımlardan geç.\n\nHavayı koklayıp tatlıyı hisset—\n\nYemek için güzel bir peynir kabuğu.\n\"\n\n\n\"Sürükle eve, koş, koş, koş,\n\nŞimdi vızıltı başladı.\n\nVızıltı, vızıltı kafanda,\n\nVızıltı, vızıltı, korku dolu.\n\"\n\n\n\"İt kapıyı, it kapıyı,\n\nArtık kimse fısıldamıyor.\n\"\n\n\"Kardeşler, kız kardeşler, sıra sıra,\n\nBak ne kadar hareketsiz durabiliyorlar.\n\nHer karında bir delik var,\n\nBoş bir delik, boş bir delik.\">"
  },
  Event_146290_Name = {
    Text = "Obur Sıçan"
  },
  Event_146291_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146291_Desc = {
    Text = "Diz çöküyor ve yanağındaki ıslaklığı siliyorsun. Gözyaşlarının gerçek olup olmadığını sormuyorsun.\n\"Gerçek olup olmadığı önemli değil,\" diyorsun. \"Kimseye hiçbir şey kanıtlamak zorunda değilsin.\"\nCaraboo ağzını açıyor, ama hazırladığı zekice, pürüzsüz yanıt boğazında kalıyor. Bunun yerine, baraj yıkılıyor. Gözyaşları ansızın dökülüyor, elinin sırtına sıcak ve ağır biçimde."
  },
  Event_146291_Name = {
    Text = "Timsah Gözyaşları"
  },
  Event_146292_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146292_Desc = {
    Text = "\"Sormamak daha iyi. Yanıt gerektirmeyen sorular vardır.\""
  },
  Event_146292_Name = {
    Text = "Obur Sıçan"
  },
  Event_146293_ChoiceDesc1 = {
    Text = "[Seslен] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, \"(Skill.Arg2)\" geliştir"
  },
  Event_146293_ChoiceDesc2 = {
    Text = "[Dinlemeye Devam Et] Tüm Uyandırıcılar 50 Aliemus kazanır, \"(Skill.Arg1)\" geliştir"
  },
  Event_146293_ChoiceDesc3 = {
    Text = "[Görmezden Gel] 3 Mühürden 1 tanesini edin"
  },
  Event_146293_Desc = {
    Text = "Naraka'nın düştüğü yerde yalnızca karanlık kaldı.\n\nBataklıktan nemli bir melodi süzülüyor; yanakların üzerinde uzun uzun gezen bir çift el gibi soğuk ve solgun.\n\nAlçak bir fısıltıyla şarkı söylüyor: \"Gel bana. Gecenin sessizliğinde gel bana.\""
  },
  Event_146293_Name = {
    Text = "Kalıcı Yankılar"
  },
  Event_146294_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146294_Desc = {
    Text = "Başını eğiyorsun, dumanın Pollux'un siluetini bulanıklaştırmasına, ifadesini gri-beyaz sisin içinde gizlemesine izin veriyorsun.\n\nBu en güvenlisi, diyorsun kendi kendine. Bakmaya gerek yok, düşünmeye gerek yok.\n\nJuliette'in vaazı üstüne akmaya devam ediyor. Gözlerini kavuşturulmuş ellerine dikiyorsun, sessiz.\n\nAncak ritüel çanı çaldığında gözlerini yeniden kaldırmaya cesaret edebiliyorsun.\n\nPollux boyunca dindar duruşunu korumuş.\n\nZamanın ve yanılsamanın uçsuz bucaksız genişliğinde, tam o anda bir şeyin kayıp gidip gitmediğinden emin olamıyorsun."
  },
  Event_146294_Name = {
    Text = "Eski Bir Rüya: III"
  },
  Event_146295_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146295_Desc = {
    Text = "\"Pollux!\"\nİsim boğazından çıkmadan önce onu yutuyorsun. Tütsü dumanına hafif, nefes gibi bir iç çekiş olarak karışıp dağılıyor.\n\nEtrafındaki inananların ilahisi sekteye uğramıyor, ama birkaç sessiz, neredeyse fark edilmez bakış sana dönüyor.\n\nPollux anında gerilip gözlerinde bir panik parıltısı beliriyor, ancak bu hızla o alışılmış, boyun eğen ifadenin arkasına gizleniyor.\n\nCevap vermiyor. Sadece gözlerini yerde tutuyor, ama parmakları kolunun içinde sessizce sıkışıyor. Seni duyduğunu biliyorsun."
  },
  Event_146295_Name = {
    Text = "Eski Bir Rüya: III"
  },
  Event_146297_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146297_Desc = {
    Text = "En azından, o zamanlar onu tek başına kovulurken seyirci kalamazdın. Bugünün sorunlarını bugünkü benliğine bırak."
  },
  Event_146297_Name = {
    Text = "Çarklar İçinde Çarklar"
  },
  Event_146298_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146298_Desc = {
    Text = "\"Pollux, ayrılmalıyız. Ormanın kenarını bu şekilde daha kolay buluruz.\n\"\n\"Ama seni nasıl bulurum, ağabey?\n\"\nAnıların sisinin içinden onun kederli yüzünü görüyorsun. Yüreğini keskin bir sancı kıvırıyor. Derin, yavaş bir nefes alıyorsun.\n\n\"Merak etme. İkiziz; birbirimizin kalp atışlarını duyabiliriz.\n\"\n\"Aslında hiç ayrı değiliz.\""
  },
  Event_146298_Name = {
    Text = "Eski Bir Rüya: I"
  },
  Event_146299_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146299_Desc = {
    Text = "Yargılıyor. Sorguluyor. Ona meydan okumaya cesaret edenlerin hepsine dondurucu, sessiz bir son sunuyor."
  },
  Event_146299_Name = {
    Text = "Kar Sınırının Hükmü"
  },
  Event_146300_ChoiceDesc1 = {
    Text = "[Baştan Başla] \"(EnchantConfig.Arg1)\" Mühürünü 3 Komut Kartından 1'ine Kazı, ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_146300_ChoiceDesc2 = {
    Text = "[Zor Gerçekten] Gümüş Kalıntı kazan: \"(RelicConfig.Arg1),\" ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_146300_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_146300_Desc = {
    Text = "Solucan ona yalan sanatını öğretti. Bunun ötesinde, hayatta kalmak için hiçbir şey öğrenmedi.\n\nYine de bir yalan her zaman yalandır; bir gün iskele ortadan kalkmak zorundadır ve insan onu olmadan ayakta durmayı öğrenmelidir."
  },
  Event_146300_Name = {
    Text = "Yanılsama, Gerçek Değil"
  },
  Event_146301_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146301_Desc = {
    Text = "\"Gerçekten. Ama bu kadar küçük bir fare, açlığının bedelini nasıl bilebilir ki?\""
  },
  Event_146301_Name = {
    Text = "Obur Sıçan"
  },
  Event_146302_ChoiceDesc1 = {
    Text = "[Kırmızı İpliği Bağla] 1 Komut Kartını Sil, Arg1 Kara Mühür kazan"
  },
  Event_146302_ChoiceDesc2 = {
    Text = "[Kırmızı İpliği Reddet] 1 Komut Kartını Kopyala, ancak \"(Skill.Arg1)\" geliştir"
  },
  Event_146302_ChoiceDesc3 = {
    Text = "[Gerçeğe Dönüş] 3 Komut Kartından 1'ine \"(EnchantConfig.Arg1)\" Mühürünü işle"
  },
  Event_146302_Desc = {
    Text = "İlk rüya. Orman. Sen ve kardeşin, henüz on yaşındayken, Fener Hanım tarafından derin, karanlık ormanda terk ediliyorsunuz.\n\n<Italic:\"Gece çökünce, uyuyan canavarlar avlanmaya başlayacak. Ondan önce kaçın. Sadece çıkmayı başaranlar benim iyi çocuklarım olabilir.>\n\nKardeşin elini tutuyor ve bir parça kırmızı iplik çıkarıyor.\n\n\"Castor, ellerimizi birbirimize bağlayalım. Böylece birbirimizi kaybetmeyiz.\""
  },
  Event_146302_Name = {
    Text = "Eski Bir Rüya: I"
  },
  Event_146304_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146304_Desc = {
    Text = "Kahkaha duyuyorsun.\n\nNeşeli, alay dolu, eğlenceyle yüklü.\n\nİnsanlığın evreni keşfetmek için verdiği çaresiz mücadele, onların gözünde karıncaların sürünmesinden başka bir şey değil."
  },
  Event_146304_Name = {
    Text = "Bakışın Altındakiler"
  },
  Event_146306_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146306_Desc = {
    Text = "Arındırıyor. Siliyor. Tırmanıp bir daha geri dönmeyenlerin hepsini sessiz kucağında topluyor."
  },
  Event_146306_Name = {
    Text = "Kar Sınırının Hükmü"
  },
  Event_146307_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146307_Desc = {
    Text = "Sen ve karga birbirinize dik dik bakıyorsunuz.\n\nBu çıkmaza kazanamayacağın açık.\n\nAma sonuçta, Juliette karşısında hiçbir zaman kazanamamış gibi hissediyorsun."
  },
  Event_146307_Name = {
    Text = "Eski Bir Rüya: II"
  },
  Event_146308_ChoiceDesc1 = {
    Text = "[Beni Kim İzliyor?] Rastgele 1 Uyandırıcıyı Uyandır, \"(Skill.Arg1)\" geliştir"
  },
  Event_146308_ChoiceDesc2 = {
    Text = "[Şimdiye Odaklan] 3 Komut Kartından 1 tanesini seçerek Kazı: \"(EnchantConfig.Arg1)\""
  },
  Event_146308_Desc = {
    Text = "İnsan ayağının basmadığı bu yüksek kutsal mekânda dondurucu, karla yüklü bir rüzgar uluyor.\n\nYukarı bakıyorsun. Daha da yüksekte, yalnızca ebedi, gözlerini kırpmayan güneş var.\n\nAma bir yerde daha yüksekte, daha da ötede, sayısız gözün açılıp kapandığını biliyorsun.\n\nVe o gözlerin birkaçı, ayaklarının altındaki tüm dünyaya sessizce bakıyor."
  },
  Event_146308_Name = {
    Text = "Bakışın Altındakiler"
  },
  Event_146309_ChoiceDesc1 = {
    Text = "[Hâlâ Bırakamıyorum] Lanetli Kalıntı kazan: \"(RelicConfig.Arg1),\" ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_146309_ChoiceDesc2 = {
    Text = "[Unuttum] \"(EnchantConfig.Arg1)\" Mühürünü 1 rastgele karta Kazı"
  },
  Event_146309_Desc = {
    Text = "Bellek odalarını kapatmaya çalışıyorsun. O gizli sandığın içinde seni tanımlayan tüm cevaplar yatıyor—her utanç verici dürtü, her gizli fantezi. Ama arzu bilinçdışı bir lanet, direnilemeyecek kadar tatlı bir saplantı."
  },
  Event_146309_Name = {
    Text = "Bilinçaltı Laneti"
  },
  Event_146310_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146310_Desc = {
    Text = "William gözlerini kaçırıyor.\n\"Zihin, yanılsamaya karşı tek kalkanımızdır. Ama bir zihin, bir ömür boyu süren deneyimlerle şekillenir. Paylaşılamaz ve öğretilemez.\"\n\n\"Sana söyleyebileceğim tek şey şu: Kendi zayıflığının seni yutmasına izin verme.\""
  },
  Event_146310_Name = {
    Text = "Nazik Dalış"
  },
  Event_146311_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146311_Desc = {
    Text = "\"Anlıyorum. Sen filozof olmak isteyen türdensin. Ama unutma: umudun yokluğu, acının yokluğu anlamına gelmez.\"\nZilin kahkahası uzaklara karışıyor."
  },
  Event_146311_Name = {
    Text = "Pavlov Refleksi"
  },
  Event_146312_ChoiceDesc1 = {
    Text = "[Leave] 50 Kara Mühür elde et, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_146312_Desc = {
    Text = "\"Aç, çok aç.\"\n\n\nDağ ağlıyor; dağ feryat ediyor. Karnındaki o uçsuz bucaksız, boş uçuruma dayanamıyor."
  },
  Event_146312_Name = {
    Text = "Dağın Sırrı"
  },
  Event_146313_ChoiceDesc1 = {
    Text = "[Tutunmaya Çalış] 1 Komut Kartını sil, Arg1 Can iyileştir"
  },
  Event_146313_ChoiceDesc2 = {
    Text = "[Güvenlik İpini Yakala] Altın Kalıntı \"(RelicConfig.Arg1)\" edin, \"(Skill.Arg2)\" geliştir"
  },
  Event_146313_Desc = {
    Text = "Zihninde bir kaos girdabı gibi dönen halüsinasyonlar.\n\nÖnce gevşek toz. Sonra çöken bir saçak.\n\nKayışını durduramıyorsun; emniyet halatı tokasına çarparak kör edici kıvılcımlar saçarken kayıp gidiyor. Ama dağların önünde bu kadar küçük, bu kadar kırılgan."
  },
  Event_146313_Name = {
    Text = "Sessiz Düşüş"
  },
  Event_146314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146314_Desc = {
    Text = "Rüyalarında gel bana. Bir kez daha yaşamama izin ver.\n\nGramofon inleyerek bir iç çekiş bırakıyor. Ardından nefes sesi karanlığa karışıp yok oluyor. Geriye yalnızca yankı kalıyor. Sadece yankı."
  },
  Event_146314_Name = {
    Text = "Kalıcı Yankılar"
  },
  Event_146315_ChoiceDesc1 = {
    Text = "[Seçimden Pişman Ol] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin"
  },
  Event_146315_ChoiceDesc2 = {
    Text = "[Kadere Bırak] Altın Kalıntı \"(RelicConfig.Arg1)\" edin, \"(Skill.Arg2)\" geliştir"
  },
  Event_146315_Desc = {
    Text = "Bu yolculuğun basit olmayacağını hep biliyordun. Bu seferdeki tırmanıcıların çoğu kendi karanlık hesaplarını taşıyor.\n\nYine de Caraboo'nun yüzüne yayılan çılgın, alay dolu sırıtışa bakınca göğsünde bir şeyin keskin ve ani bir çatırtıyla kırıldığını hissediyorsun.\n\nBelki Naraka onu gruptan atmak istediğinde farklı bir seçim yapmalıydın."
  },
  Event_146315_Name = {
    Text = "Çarklar İçinde Çarklar"
  },
  Event_146316_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146316_Desc = {
    Text = "Bu yer kaç kişiyi yuttu acaba?\n\nKalın, yapışkan havuzdan siyah eller uzanıyor, seni kendi dünyalarına çekmeye çalışıyorlar. Ama sen yürümeye devam ediyorsun. Seni durdurmaya teşebbüs etmiyorlar, sessizce derinliklere geri kayıyorlar.\n\nZirve hâlâ önünde seni bekliyor."
  },
  Event_146316_Name = {
    Text = "Kalıcı Yankılar"
  },
  Event_146317_ChoiceDesc1 = {
    Text = "[Gözlerini Çevir] 25 Kara Mühür kazan"
  },
  Event_146317_ChoiceDesc2 = {
    Text = "[Daha Yakından Bak] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, \"(Skill.Arg2)\" geliştir"
  },
  Event_146317_Desc = {
    Text = "Tinktur'un bakışını takip ederek gözlerini gölün derinliklerine dikiyorsun.\n\nOnu bu kadar büyüleyen ne olabilir ki?\n\nAnlayamıyorsun. Buz bulanık ve karanlık; yalnızca kendi gölgeni yansıtıyor."
  },
  Event_146317_Name = {
    Text = "Batık Yansıma"
  },
  Event_146318_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146318_Desc = {
    Text = "Açlığı durdurmanın tek yolu bırakmak. Kimse elinde tutmadığı şeyi kaybetmez. Wendigo dişlerini gösteriyor, sinirli bir hırıltı bırakıyor ve sise geri süzülüyor."
  },
  Event_146318_Name = {
    Text = "Bilinçaltı Laneti"
  },
  Event_146319_ChoiceDesc1 = {
    Text = "[Kar Beni Arındırsın] Rastgele 1 Kartın Mühür kalitesini yükselt"
  },
  Event_146319_ChoiceDesc2 = {
    Text = "[Kar Beni Yargılasın] 3 Komut Kartından 1 tanesini seçerek Kazı: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" geliştir"
  },
  Event_146319_Desc = {
    Text = "Önünde son tırmanış uzanıyor; soğuk ve sonsuz kar sınırı uzaklara doğru yayılıyor.\n\nKar göz alıcı, parlak bir beyaz. Burada ölüm bile temiz görünüyor."
  },
  Event_146319_Name = {
    Text = "Kar Sınırının Hükmü"
  },
  Event_146320_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146320_Desc = {
    Text = "Vizyonun hiçbir ayrıntısını kaçırma. Onları zihnine kazı. Ansızın gelen boşluğu, içi boş sızıyı ve ardından gelen keskin kederi kazı. Asla, asla bırakma."
  },
  Event_146320_Name = {
    Text = "Öte Yakadan"
  },
  Event_146321_ChoiceDesc1 = {
    Text = "[Birlikte Savaş] Gümüş Kalıntı kazan: \"(RelicConfig.Arg1)\""
  },
  Event_146321_ChoiceDesc2 = {
    Text = "[Onu Teselli Et] Altın Kalıntı kazan: \"(RelicConfig.Arg1),\" ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_146321_Desc = {
    Text = "Dağ sarsılıyor, can çekişen bir canavar gibi. Eklemli, soluk etler çatlak taşlardan fışkırıyor, kıvrılıp tırmanarak Caraboo'yu yere fırlatıyor.\n\nAyağa kalktığında, toz lekeli yanakları üzerinde ıslak izler beliriyor. Acı gözyaşları mı bunlar? Söyleyemezsin.\n\nDudaklarından bu kadar çok yalan döküldü; timsahın gözyaşlarına kim güvenebilir ki?"
  },
  Event_146321_Name = {
    Text = "Timsah Gözyaşları"
  },
  Event_146322_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146322_Desc = {
    Text = "Soru sormuyorsun. Sadece onun yanında yerini alıyorsun.\n\"Kalk,\" diyorsun. \"Oyununun henüz yarısındasın. Şimdi bırakma.\"\nCaraboo tereddüt ediyor, sonra yüzünü sert ve ani bir hareketle siliyor. Silahına beyaz parmak eklemleriyle tutunarak sendeleyerek ayağa kalkıyor ve seninle birlikte açık, kızıl ağzın karşısına geçiyor.\nO kadar çok yalan söyledi ki hangi gözyaşlarının su, hangilerinin tuz olduğunu kendisi bile ayırt edemiyor. Ama şimdilik, kimse saymıyor."
  },
  Event_146322_Name = {
    Text = "Timsah Gözyaşları"
  },
  Event_146323_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146323_Desc = {
    Text = "\"Anlıyorum. Sen yanılsamayı gördüğünü düşünerek övünen türdensin. Ama unutma: o kısa gerçeklik anında, yiyecek yalnızca hafızanda ve arzunda vardı.\"\nZilin kahkahası uzaklara karışıyor."
  },
  Event_146323_Name = {
    Text = "Pavlov Refleksi"
  },
  Event_146324_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146324_Desc = {
    Text = "Adımlarını yavaşlatıyorsun, ayak seslerini kısıyorsun.\n\nYumuşakça, ağır ağır, tek bir ses çıkarmadan...\n\nBir sonraki köşeyi dönüp kayboluyorsun.\n\nKarga hiç takip etti mi?\n\nArtık hatırlamıyorsun."
  },
  Event_146324_Name = {
    Text = "Eski Bir Rüya: II"
  },
  Event_146325_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146325_Desc = {
    Text = "Melodi kesiliyor.\n\nKara bataklığın içinden istekli, ıslak bir çift göz açılıp sana bakıyor. Anlayamadığın kelimeler fısıldıyorlar, sonra yavaş yavaş kapanıyorlar."
  },
  Event_146325_Name = {
    Text = "Kalıcı Yankılar"
  },
  Event_146326_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146326_Desc = {
    Text = "Oyalanmıyorsun. Melodiyi geride bırakarak botların karı eziyor, rüzgarın kendisinden daha aceleci bir ses çıkarıyor.\n\nNe kadar hızlı yürürsen yür, o ıssız ezgi inatla topuklarına yapışıyor, hiç geride kalmıyor.\n\nOndan kaçamazsın — o dağın nefesinin ta kendisi. Ve sen yalnızca onu tesadüfen duyan küçücük, geçici bir dinleyicisin."
  },
  Event_146326_Name = {
    Text = "Doğanın Fantazyası"
  },
  Event_146327_ChoiceDesc1 = {
    Text = "[Dinle] 3 Komut Kartından 1'ini Kazı: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" geliştir"
  },
  Event_146327_ChoiceDesc2 = {
    Text = "[Umursamа] Aliemus'u 50 veya üzerinde olan her Uyandırıcı için 15 Kara Mühür kazan"
  },
  Event_146327_ChoiceDesc3 = {
    Text = "[Leave by Force] 3 Dilekten 1'ini kazan"
  },
  Event_146327_Desc = {
    Text = "Uzaktan bir şarkı rüzgarda süzülüyor.\n\nHer yönden geliyor gibi, ya da belki yerin derinliklerinden.\n\nOnu takip etmek için hangi yöne dönersen dön, aynı amansız yoğunlukla kulaklarında yankılanıyor."
  },
  Event_146327_Name = {
    Text = "Donmuş Gölün Aryası"
  },
  Event_146328_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146328_Desc = {
    Text = "\"Ey uğursuz yıldız, bu senin parlamanın vakti değil.\"\n\n\"Hac yolculuğumun henüz ulaşmadığı sonları var.\"\n\n\"Sön, en azından şimdilik, ve bu gecenin gökyüzüne huzuru geri getir.\""
  },
  Event_146328_Name = {
    Text = "Ölüm Alameti"
  },
  Event_146329_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146329_Desc = {
    Text = "Boş bir pişmanlık dalgası üzerine çöküyor. Ama sonuçta, geçmişteki benliğimizin bıraktığı dağınıklığı her zaman temizlemek zorunda kalıyoruz."
  },
  Event_146329_Name = {
    Text = "Çarklar İçinde Çarklar"
  },
  Event_146330_ChoiceDesc1 = {
    Text = "[Isır] 1 rastgele Uyandırıcı'yı Uyandır, ancak [(Skill.Arg1)] geliştirilir"
  },
  Event_146330_ChoiceDesc2 = {
    Text = "[Refuse] 3 Yakarıştan 1’ini Oyarak Kazı"
  },
  Event_146330_Desc = {
    Text = "Karla boğulmuş sisin derinliklerinde, belirgin kaburgaları üzerine gergin biçimde gerilmiş kuru, çatlak derisiyle iskelet gibi bir figür çömelmiş. Başının tepesinde, düğümlü, solmuş boynuzlar sisi delerek yükseliyor. İçinden içi boş, açgözlü bir uğultu yankılanıyor.\n\nGözleriniz buluştuğunda, çökmüş gözlerinin içinde parçalanmış imgeler dönerek beliriyor—senin anıların. Kokuyu çoktan almış; onları çoktan tatmış.\n\n\"Yetmez, hiç yetmez...\" diye inliyor, kuru, hırıltılı bir sesle. Solmuş elini uzatıyor, duruşu neredeyse... yalvaran biri gibi."
  },
  Event_146330_Name = {Text = "Yutıcı"},
  Event_146332_ChoiceDesc1 = {
    Text = "[Gök Defni Gerçekleştir] Gümüş Kalıntı kazan: \"(RelicConfig.Arg1)\""
  },
  Event_146332_ChoiceDesc2 = {
    Text = "[Dispel] 75 Kara Mühür alın, ancak [(Skill.Arg2)] Semptomunu geliştirin"
  },
  Event_146332_Desc = {
    Text = "Termal yükseliş akıntılarında sakallı akbabalar daireler çizerek bölgelerini devriye geziyor. Tırmanıcılar arasında bu her zaman uğursuz bir işaret olmuştur.\n\n\"Yiyecek arıyorlar. Bir akbaba ölümün yaklaştığını koklar.\""
  },
  Event_146332_Name = {
    Text = "Ölüm Alameti"
  },
  Event_146333_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146333_Desc = {
    Text = "Bacaklarına güven. Bu zirveyi fethedeceksin."
  },
  Event_146333_Name = {
    Text = "Zirveye Dokunmak"
  },
  Event_146334_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146334_Desc = {
    Text = "Özlem alevlendiği anda, bununla savaşamayacağını anlıyorsun. Sadece izleyebiliyorsun; zihninin uzun süredir mühürlü kasalarını aşarken. Soluk, keskin dişler şakaklarına saplanıyor, anılarını kökünden, kare kare koparıp alıyor."
  },
  Event_146334_Name = {
    Text = "Bilinçaltı Laneti"
  },
  Event_146335_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146335_Desc = {
    Text = "Yaklaşıyor, burnu neredeyse alnına değecek, seni içine çekiyor; sanki en tatlı balın ta kendisiymişsin gibi coşkulu, sarhoş bir adanmışlıkla.\n\nDinmeyen, çalkalanan kaygıların zihninden yalayıp temizleniyor.\n\nTatmin olmuş, alçak bir mırıltıyla geri çekiliyor; içi boş gözlerinde vahşi, baştan çıkarıcı bir ışık titreşiyor. Göğsün şimdi boş hissettiriyor, eksik bir parça—yine de, tuhaf biçimde, daha hafif hissediyorsun."
  },
  Event_146335_Name = {Text = "Yutıcı"},
  Event_146336_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146336_Desc = {
    Text = "\"Adımlarına dikkat et. Her adımın sağlam olduğundan emin ol,\" Naraka'nın sesi kulağında çınlıyor. \"Düştüğünde seni tutacak birine güvenme.\""
  },
  Event_146336_Name = {
    Text = "Bakışın Altındakiler"
  },
  Event_146337_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146337_Desc = {
    Text = "İnsanlık göklere aittir. Gerçek bir amaç, alttaki derin düşüşü unutturur. Gökyüzü açık, hemen yukarıda seni bekliyor."
  },
  Event_146337_Name = {
    Text = "Zirveye Dokunmak"
  },
  Event_146338_ChoiceDesc1 = {
    Text = "[Anıları Bırak] Altın Kalıntı kazan: \"(RelicConfig.Arg1),\" ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_146338_ChoiceDesc2 = {
    Text = "[Acıya Tutun] 3 Altın Kalıntıdan 1'ini edin, ancak \"(Skill.Arg1)\" geliştir"
  },
  Event_146338_ChoiceDesc3 = {
    Text = "[Leave] [(RelicConfig.Arg1)] Gümüş Kalıntıyı edin"
  },
  Event_146338_Desc = {
    Text = "Bir zamanlar William'ı öldüren kişi şimdi karşında duruyor.\n\nAram'ın çadırının durgun, bunaltıcı havasında, anılar hayalet gibi yükseliyor: William'ın kansız, süzülen bedeni; soluk, yukarı dönük yüzü; ve masanın üzerinde, o küçük fenerden geriye kalan teşrih edilmiş, içi boş kabuk."
  },
  Event_146338_Name = {
    Text = "Öte Yakadan"
  },
  Event_146339_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146339_Desc = {
    Text = "Emniyet halatı ağırlığın altında anında kopuyor.\n\nBir kar yığınına ağır bir şekilde çarpıyorsun, her organın sağır edici, dayanılmaz bir acıyla feryat ediyor. Baş döndürücü acıya rağmen gözlerini zorla açıyorsun, yalnızca isimsiz bir iskeletle yüz yüze geldiğini fark ediyorsun.\n\nBoş, çukur göz yuvalarının derinliklerinde bir şey parıldıyor."
  },
  Event_146339_Name = {
    Text = "Sessiz Düşüş"
  },
  Event_146340_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146340_Desc = {
    Text = "Kaçış yolu yok. Dişlerini sıkıp koşmaya başlıyorsun, gözlemcinden kaçmak için çılgınca çabalıyorsun. Karga sert bir çığlık atıyor, kanatlarını çırpıyor ve seni yukarıdan zahmetsizce takip ediyor, hatta seninle alay etmek için geri dönüp daireler çiziyor. Onun bakışları altında derine işleyen soğuk bir umutsuzluk tüm bedenine yayılıyor.\n\nOnlardan kaçamazsın."
  },
  Event_146340_Name = {
    Text = "Eski Bir Rüya: II"
  },
  Event_146341_ChoiceDesc1 = {
    Text = "[Ektiğini Biçersin] Rastgele bir Komut Kartı Mühür kazanır: \"(EnchantConfig.Arg1)\""
  },
  Event_146341_ChoiceDesc2 = {
    Text = "[Mutlak Eşitlik] Maksimum canı Arg1 artır, \"(Skill.Arg2)\" geliştir"
  },
  Event_146341_Desc = {
    Text = "Dik kayalıktan sarkarken aklına tamamen alakasız bir soru geliyor: Adalet nedir?"
  },
  Event_146341_Name = {
    Text = "Saçma Adalet"
  },
  Event_146342_ChoiceDesc1 = {
    Text = "[Leave] 50 Kara Mühür elde et, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_146342_Desc = {
    Text = "\"Ölmeyebilirim! Henüz değil!\"\nDağ ağlıyor; dağ feryat ediyor. Doyumsuz açgözlülüğüyle kendi yarınını yutup bitirmiş."
  },
  Event_146342_Name = {
    Text = "Dağın Sırrı"
  },
  Event_146343_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146343_Desc = {
    Text = "Yanağın buza değene kadar eğiliyorsun.\n\nDerin ve keskin bir soğuk derininden kemiklerine işliyor, seni titremeye zorluyor. Donmuş yüzeyin altında uçsuz bucaksız ve ağır bir şey dönüyor. Bu bir akıntı mı, yoksa canlı bir varlık mı?\n\nHer ne olursa olsun, yolculuğunla bir ilgisi yok."
  },
  Event_146343_Name = {
    Text = "Batık Yansıma"
  },
  Event_148532_ChoiceDesc1 = {
    Text = "[Bereketi Al] Savaşın başında, destene 1 rastgele \"Değişken Meyve\" ekle."
  },
  Event_148532_Desc = {
    Text = "Uçsuz bucaksız kar ovası gözün görebildiği yere kadar uzanır; soğuk rüzgar tek bir ses kırıntısı bile taşımaz. Nereden geldiği bilinmeyen bir hayalet sessizce belirir ve ılık bir meyve uzatır.\nTatlı koku sisle birlikte, donarak uyuşmuş yolcunun burnuna dolar. \nBu kar yurdu çoktan ölümün sularına batmıştır; havada çürüme ve buz kesici bir mide bulandırıcı koku dolaşır. Yalnızca avuçtaki bu meyve dolgun ve pırıl pırıldır; sanki genç bir kızın baştan çıkarıcı bir vaadi gibi."
  },
  Event_148532_Name = {
    Text = "Gökyüzü Serabi"
  },
  Event_20778_ChoiceDesc1 = {
    Text = "[Leave It to Her] Tüm Uyanışçılar Arg1 Aliemus kazanır"
  },
  Event_20778_ChoiceDesc2 = {
    Text = "[Require Support] 2 Uyanışçı’yı Uyandır"
  },
  Event_20778_Desc = {
    Text = "\"Bu, Mythag’dan gelen bir ileti. Uyanan’da anormal Gnosis İndeksi dalgalanması tespit edildi. Desteğe ihtiyacınız var mı?\""
  },
  Event_20778_Name = {
    Text = "Destek İletişimi"
  },
  Event_20779_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20779_Desc = {
    Text = "“Acil yardım sağlandı. Teslim aldıktan sonra lütfen broşa üç kez dokunarak onaylayın.”"
  },
  Event_20779_Name = {
    Text = "Destek İletişimi"
  },
  Event_20780_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20780_Desc = {
    Text = "Elworth'un yarıklarında gizlenmiş, uzak bir gelecekten gelen bir fantazma."
  },
  Event_20780_Name = {
    Text = "Yanardağ Hayaleti"
  },
  Event_20781_ChoiceDesc1 = {
    Text = "[Gaze at Phantasm] Tüm Uyandırıcılar Arg1 Aliemus kazanır"
  },
  Event_20781_ChoiceDesc2 = {
    Text = "[Approach Phantasm] 2 Uyanışçı’yı Uyandır"
  },
  Event_20781_Desc = {
    Text = "Uzakta, sanki bir volkan konisi patlamış, fırtınalı göğe insan biçimli bir duman yükseliyor.\nOysa burası, yalnızca sonsuz, başdöndürücü Sıradağlar ve kireçtaşı karst mağaralarından oluşan Elworth.\nSüregiden anormallikler seni ruhsal bir Şaşkınlığa mı sürükledi?"
  },
  Event_20781_Name = {
    Text = "Yanardağ Hayaleti"
  },
  Event_20782_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20782_Desc = {
    Text = "Fantazma kaybolmadan önce sana el sallar. Geriye yalnızca soğuk kar ve baş döndüren sıradağlar kalır."
  },
  Event_20782_Name = {
    Text = "Yanardağ Hayaleti"
  },
  Event_20783_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20783_Desc = {
    Text = "\"Anlaşıldı. Sade kaynakları teslim edeceğiz. Lütfen kontrol edin.\""
  },
  Event_20783_Name = {
    Text = "Destek İletişimi"
  },
  Event_21398_ChoiceDesc1 = {
    Text = "[Pick up the Photo] 3 Komut Kartı’ndan 1’ine [(EnchantConfig.Arg1)] Yakarı’nı kazır."
  },
  Event_21398_Desc = {
    Text = "Makineler söküldü, gerçek açığa çıktı.\nCıvıl cıvıl hayat hiçliğe silinirken, seni yalnızca gerçeği ortaya çıkarmanın verdiği tatmin duygusu ile baş başa bırakıyor."
  },
  Event_21398_Name = {
    Text = "Görgü Tanığı İfadesi"
  },
  Event_21399_ChoiceDesc1 = {
    Text = "[Pick up the Photo] 3 Komut Kartı’ndan 1’ine [(EnchantConfig.Arg1)] Yakarı’nı kazır."
  },
  Event_21399_ChoiceDesc2 = {
    Text = "[Check Film] [(Skill.Arg1)] Semptomunu geliştir ve kazınacak Yakarışı değiştir.(Kullanım: 1/2)"
  },
  Event_21399_Desc = {
    Text = "Merakınla sürüklenerek Gölge Havuzu'na eğilirsin.\nİmgeler al kızıl sıvının içinde boğulmuş, kara pisliğe bulanmış günahkârın yüzü ise seninkinin birebir aynısı."
  },
  Event_21399_Name = {
    Text = "Görgü Tanığı İfadesi"
  },
  Event_21400_ChoiceDesc1 = {Text = "[Leave]"},
  Event_21400_Desc = {
    Text = "Makineler söküldü, gerçek açığa çıktı.\nCıvıl cıvıl hayat hiçliğe silinirken, seni yalnızca gerçeği ortaya çıkarmanın verdiği tatmin duygusu ile baş başa bırakıyor."
  },
  Event_21400_Name = {
    Text = "Görgü Tanığı İfadesi"
  },
  Event_21811_ChoiceDesc1 = {Text = "[Leave]"},
  Event_21811_Desc = {
    Text = "\n\"Yirmi beş yıl... evet, beni yirmi beş yıl uyuttu.\"\nKız, sana karanlık ve kısık bir sesle karşılık verir.\nUyandığında, çocukluğundan beri ona bakanlar yıllar içinde tam teşekküllü Denizciler olmuşlardır.\nArtık kimse onun ıstırabını anlamaz, kimse acısına aldırmaz; onu tarikatın içinde yapayalnız bırakırlar.\nKeşke uykusuna yatmadan önceki gün, \"Yıldız Hizalanması Günü\" olsaydı."
  },
  Event_21811_Name = {
    Text = "Zincirlenmiş Hayat"
  },
  Event_22058_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22058_Desc = {
    Text = "\n“Hayır, aç değilim.”\nSıcak daveti kibarca geri çevirdin.\nRuhunu bunun için ipotek etmeye asla razı olmayacaktın."
  },
  Event_22058_Name = {
    Text = "Flesh Banquet"
  },
  Event_22059_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22059_Desc = {
    Text = "Kan Akıtma içindeki çöreği açlıkla ısırırsın; hamura işlenmiş, biberli bir kalbin kokusu duyularını tanıdık bir rayihayla doldurur.\n“Güç kazanmanın bir bedeli vardır.”\nSon kan damlasını da içersin."
  },
  Event_22059_Name = {
    Text = "Flesh Banquet"
  },
  Event_22060_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22060_Desc = {
    Text = "Çorbayı ve eti bir dikişte mideye indirip, kalanını kolunun yenine silersin.\nEt yumuşaktı, çorba lezzetliydi; ama bir zamanlar kime aitti?\nBu, yitirdiklerinin yalnızca buzdağının görünen ucuydu."
  },
  Event_22060_Name = {
    Text = "Flesh Banquet"
  },
  Event_22061_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22061_Desc = {
    Text = "Rüzgâr çanına kazınmış kadim Yakarışları dikkatle incelersin.\nAkıl almaz ölçüde çarpıtılmışlardır; sanki anlaşılmaz kalmaları için yazılmış gibidirler.\nAnlaşılmıyorsa, rahatsız edilmemelidir."
  },
  Event_22061_Name = {
    Text = "Rusted Chime"
  },
  Event_22062_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22062_Desc = {
    Text = "\"Fena değil, oldukça tedbirlisin.\"\nBirden, rüzgâr çanlarından uzak bir ses geldi.\n\"Tedbir sana küçük bir ödül getirecek, ama hepsi bu.\""
  },
  Event_22062_Name = {
    Text = "Rusted Chime"
  },
  Event_22063_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22063_Desc = {
    Text = "Rüzgâr çanına kazınmış kadim Orison’a dokunursun.\nİnsan kavrayışının ötesinde bükülürler, anlaşılmayı reddederler.\nYanlış anlaşılmak, rahatsız edilmeden kalmak demektir."
  },
  Event_22063_Name = {
    Text = "Rusted Chime"
  },
  Event_22064_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22064_Desc = {
    Text = "\"Ah, ne yazık... Sanırım tek kişilik performansıma devam edeceğim.\" Kanunun ve ellerin ne zaman kaybolduğunu bilmiyorsun, ama su gibi akan melodi sonsuza dek kalbinde yankılanıyor."
  },
  Event_22064_Name = {
    Text = "Arp'ın Hayaleti"
  },
  Event_22065_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22065_Desc = {
    Text = "“Ah, böyle bir dosta sahip olmak ne büyük onur!” O eller coşkuyla harekete geçti ve sen hızlarına yetişemedin. Gösteri bittikten çok sonra bile, o coşturucu ses hâlâ yüreğini titretiyordu."
  },
  Event_22065_Name = {
    Text = "Arp'ın Hayaleti"
  },
  Event_22175_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22175_Desc = {
    Text = "Ruh çağırma tahtasındaki gösterge kendinden emin bir şekilde hareket ederken, bakışların her kıpırdayışını izler.\nNe var ki, zavallı bir çığlık eşliğinde, daha iki harfi zar zor işaret etmişken, koyu kıvamlı siyah bir pelteye çözünüp dağılır."
  },
  Event_22175_Name = {
    Text = "Spirit Board"
  },
  Event_22176_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22176_Desc = {
    Text = "\n\"Matematik! Matematik!!\"\nKadın dişlerini sıktı, kehanet tahtası sayılar arasında hızla kayarken sert bir ahşap sürtünme sesi çıkardı.\n\"Matematiğini gözümün önünden çek!\""
  },
  Event_22176_Name = {
    Text = "Spirit Board"
  },
  Event_22177_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22177_Desc = {
    Text = [[
"Bekle, bekle!!"
"Sor bana! Neden sormuyorsun!"]]
  },
  Event_22177_Name = {
    Text = "Spirit Board"
  },
  Event_22178_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22178_Desc = {
    Text = "Hiçbir zaman şu anki kadar canlı atmamıştı, ama buna karşılık, kalbimin içindeki boşluk paramparça ediliyor..."
  },
  Event_22178_Name = {
    Text = "Lanetli Özlem"
  },
  Event_22179_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22179_Desc = {
    Text = "Ruh ve tin ciğerlerini doldurur, sessizlik içinde yukarı süzülürsün.\nDünyanın sesleri yavaşça belirir, hayatın senfonisini örer."
  },
  Event_22179_Name = {
    Text = "Lethe'nin Akışı"
  },
  Event_22180_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22180_Desc = {
    Text = "Her zamanki gibi, Yıkım söz verildiği gibi gelir. Kıymetli eşyalar, yanmamış kalıntı nüshaların içine gömülür; gölgelerde göz kamaştırıcı bir ışıkla parlarlar."
  },
  Event_22180_Name = {
    Text = "Beyond the Needle"
  },
  Event_22181_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22181_Desc = {
    Text = "Karşılaşma, ayrılık ve gelip geçiş."
  },
  Event_22181_Name = {
    Text = "Astral Harmonies"
  },
  Event_22182_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22182_Desc = {
    Text = "Kalp yavaş yavaş ağırlaşıp sakinleşiyor, ama belki de \"vicdan\" az da olsa bir teselli bulmuştur..."
  },
  Event_22182_Name = {
    Text = "Lanetli Özlem"
  },
  Event_22183_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22183_Desc = {
    Text = "Gözlerini kapatıp bu nadir Düş ve özgürlük anının tadını çıkardın. Yavaş yavaş, dünyanın Sessizlikten doğduğunu, hayatın sessizce filizlendiğini hissettin."
  },
  Event_22183_Name = {
    Text = "Lethe'nin Akışı"
  },
  Event_22184_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22184_Desc = {
    Text = "İğneyi durdurursun, gümüş kıymıklar yumuşak avucuna saplanırken parıldar. Yıkım henüz gelmemiştir, ama ayaklarının altındaki gölge mürekkep karası bir Karanlık tarafından Yutulma üzeredir."
  },
  Event_22184_Name = {
    Text = "Beyond the Needle"
  },
  Event_22185_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22185_Desc = {
    Text = "\n“Kaçamazsın; hiç kimse içindeki kötülüğe direnemez.”\nKötücül düşünceler sinirlerini parçalıyor, seni uçuruma sürüklemeye çalışıyor. Ama acı, zihnini eşi benzeri görülmemiş bir berraklığa kavuşturuyor.\nKötülük seni ele geçiremiyor; sen, sen olarak kalacaksın."
  },
  Event_22185_Name = {
    Text = "Unbidden Thought"
  },
  Event_22186_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22186_Desc = {
    Text = "\"Neden olmasın?\"\nO dehşet verici düşünceleri bir kez kucakladığında, tüm zorluklar kolayca çözülecek ve dünyada artık \"etik\" denen bir paradoks kalmayacak."
  },
  Event_22186_Name = {
    Text = "Unbidden Thought"
  },
  Event_22187_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22187_Desc = {
    Text = "Gözlerimin önünde gümüş bir ışık çaktı ve kör bir rüzgâr tüm sesleri süpürüp götürdü."
  },
  Event_22187_Name = {
    Text = "Unbidden Thought"
  },
  Event_22188_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22188_Desc = {
    Text = "Değişken, soğuk ve uzak."
  },
  Event_22188_Name = {
    Text = "Astral Harmonies"
  },
  Event_22189_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22189_Desc = {
    Text = "Genişleme, daralma, uçurumun eşiğinde."
  },
  Event_22189_Name = {
    Text = "Astral Harmonies"
  },
  Event_22190_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22190_Desc = {
    Text = "Neden biraz pervasız olmuyorsun?\nTüm bariyerleri kırıp finiş çizgisine doğru hücum et.\nDüşünceler gölünde fırtınalar koparsan da, güneşi kovalayan İkarus’a dönüşsen de, en azından amacına ulaştın, değil mi?"
  },
  Event_22190_Name = {
    Text = "Zihin Labirenti"
  },
  Event_22191_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22191_Desc = {
    Text = "Beyninin kendisi bir labirent ve sen onun Ariadne’sisin.\nBu evrende, labirenti senden iyi bilen yok.\nHiç kimse."
  },
  Event_22191_Name = {
    Text = "Zihin Labirenti"
  },
  Event_22192_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22192_Desc = {
    Text = "Doğru ayarlamayla, uyumsuz aralıklar biraz yumuşadı.\nAma belki yapabileceğin daha fazlası vardır."
  },
  Event_22192_Name = {Text = "Uyumsuzluk"},
  Event_22193_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22193_Desc = {
    Text = "Hem bir müzik üstadısın hem de sıradan, kulaksız bir insansın.\nSenin rehberliğinde notalar rollerini yerine getirir ve nihayet yaşam, Gizli Diyar’ın içinde yankı bulur."
  },
  Event_22193_Name = {Text = "Uyumsuzluk"},
  Event_22194_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22194_Desc = {
    Text = "Sesin Sessizlik tarafından yutulur. Sessizlik giderek daha gür, daha yoğun hâle gelir; ta ki parçalanıp geride yalnızca Kalıntı Nüsha’lar bırakana dek."
  },
  Event_22194_Name = {
    Text = "Lethe'nin Akışı"
  },
  Event_22195_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22195_Desc = {
    Text = "Kandırılmadın. Kararlılıkla arkanı döndün ve uzaklaştın."
  },
  Event_22195_Name = {
    Text = "Sürünen Çatlak"
  },
  Event_22293_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22293_Desc = {
    Text = "Kalemi eline aldığın anda, mektup Gizli Diyar’da tutuşur, Küller avucuna dökülür.\nKendine geldiğinde, mektupla birlikte bir şeyin de yok olduğunu fark edersin."
  },
  Event_22293_Name = {
    Text = "İç Monolog"
  },
  Event_22294_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22294_Desc = {
    Text = "Mektup Mıntıka’da dağılıp giderken, yumuşak ama zayıf bir kaygı ifadesi duyuyorsun.\n\"Böyle bir durumda beni hatırlaman, bir öğretmenin olarak benim için bir onur.\nNe var ki, Mıntıka’da en son yürüyüşümün üzerinden çok uzun zaman geçti. Şimdi sana ancak bu kadar yardımcı olabilirim...\""
  },
  Event_22294_Name = {
    Text = "İç Monolog"
  },
  Event_22295_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22295_Desc = {
    Text = "Mektup Boyut içinde dağılırken, acil bir haykırış duydun.\n\"Koruyucu, eğer en ufak bir rahatsızlık hissedersen, lütfen mutlaka bana söyle.\nOrtağın olarak, sana yardım etmek için hiçbir çabadan kaçınmayacağım.\""
  },
  Event_22295_Name = {
    Text = "İç Monolog"
  },
  Event_22296_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22296_Desc = {
    Text = "Mektup Alan’da dağılırken, soğuk bir iç çekiş duyarsın.\n“Keşke sınavlardan kalınca yardım istemeye bu kadar hevesli olsaydın.”"
  },
  Event_22296_Name = {
    Text = "İç Monolog"
  },
  Event_22397_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22397_Desc = {
    Text = "Varışın gölgeleri afallattı. Bir yıldız ışığı huzmesi ayak parmaklarının ucundan süzüldü ve Kalabalık aniden dağıldı; elinde yalnızca en yoğun gölge kaldı."
  },
  Event_22397_Name = {
    Text = "Yıldızî Yemin"
  },
  Event_22398_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22398_Desc = {
    Text = "Gürültülü fısıltılar aniden kesilir. Mürekkep karası gölgeler sana doğru dönüp bakar. Yüzsüz çehrelerinden, hafif bir alay sezersin..."
  },
  Event_22398_Name = {
    Text = "Yıldızî Yemin"
  },
  Event_22399_ChoiceDesc1 = {
    Text = "[Soğukkanlılıkla Gözlemle] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_22399_ChoiceDesc2 = {
    Text = "[Ask Aloud] 25 Kara Mühür al"
  },
  Event_22399_Desc = {
    Text = "Yıldızlarla ayın birbirine dolandığı yerde fısıltılar dinmez.\n \"Bu mu? @4’nin insanı...\"\n \"İnsan bedeni, nihayetinde hâlâ @3...\""
  },
  Event_22399_Name = {
    Text = "Yıldızî Yemin"
  },
  Event_22411_ChoiceDesc1 = {
    Text = "[Mission Accomplished]"
  },
  Event_22411_Desc = {
    Text = "Ucuz ama etkili tuzaklar!"
  },
  Event_22411_Name = {
    Text = "Tuzak Yapımı"
  },
  Event_24254_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24254_Desc = {
    Text = "Gnosis fırtınası Tulu’yu kuşatıyor. Onunla göz göze gelirsin ve peş peşe Karanlık’a adım atarsınız."
  },
  Event_24254_Name = {
    Text = "Denizden Gelen"
  },
  Event_24255_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24255_Desc = {
    Text = "Gnosis fırtınası Tulu’yu kuşatırken, dinmeyen ağıt ve suçluluk tüm mekâna yayılıyor."
  },
  Event_24255_Name = {
    Text = "Uçurumla Yüzleş"
  },
  Event_24256_ChoiceDesc1 = {
    Text = "[Hold the Tentacle] Tulu’nun yardımını kabul et"
  },
  Event_24256_Desc = {
    Text = "Heybetli varlığı, devasa bir cismin denize çakılması gibi gizli diyar boyunca yankılanır.\nBu güç kadimdir, zamansızdır, tüm çağları Aşar.\nNeyse ki, en azından şimdilik, sen onun düşmanı değilsin."
  },
  Event_24256_Name = {
    Text = "Denizden Gelen"
  },
  Event_24257_ChoiceDesc1 = {
    Text = "[Hold the Tentacle] Tulu ile git"
  },
  Event_24257_Desc = {
    Text = "Tulu derin bir nefes alır ve uzakta Miryam’a bakar.\nSanki tarihi, eski dostları ve kendi hayatını anımsıyormuş gibi...\nYüzündeki karmaşık ifade, bakışlarını Miryam’dan çevirene dek yalnızca bir anlığına kalır.\n“Gidelim, bırak onu.”"
  },
  Event_24257_Name = {
    Text = "Uçurumla Yüzleş"
  },
  Event_24277_ChoiceDesc1 = {
    Text = "[Close the Hatch]"
  },
  Event_24277_Desc = {
    Text = "Ramona, dışarıdan içeri dalan öğrenciyi yakaladı.\nO korkusuz ve güçlü Koruyucu, her ne kadar dağınık görünse de, gözlüğünün ardındaki mavi gözlerinde bulanık bir siluet gibi duruyordu.\nAncak elini tuttuğu anda Ramona emin oldu: yeniden bir araya gelmiştiniz."
  },
  Event_24277_Name = {
    Text = "Joyous Reunion"
  },
  Event_24278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24278_Desc = {
    Text = "Ramona sana kendini açıklama fırsatı vermedi. Seni loş kamaraya çekti ve kapıyı özenle kapattı..."
  },
  Event_24278_Name = {
    Text = "Joyous Reunion"
  },
  Event_24540_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24540_Desc = {
    Text = "\"O, senin sarsılmaz kalkanın, elindeki kılıçtır.\nO, senin ortağın, yoldaşın, güvenilir dostundur—nasıl değişirse değişsin.\""
  },
  Event_24540_Name = {
    Text = "Strange-Yet-Familiar"
  },
  Event_24541_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24541_Desc = {
    Text = "\n \"Sen... Sen misin... Hayır, olamaz. Bu tecessüdün çoktan... Ve ben de, ben de çoktan...\"\nSes, siluetiyle birlikte solup gitti, siste yalnızca bir hüzün asılı kaldı."
  },
  Event_24541_Name = {
    Text = "Tanıdık Ama Yabancı Silüet"
  },
  Event_24542_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24542_Desc = {
    Text = "“Dünya için, İnsanlığın Işığı için, değer verdiğimiz her şey için.\nElbette, en önemlisi şu ki—o senin için var.”"
  },
  Event_24542_Name = {
    Text = "Strange-Yet-Familiar"
  },
  Event_24543_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24543_Desc = {
    Text = "Daha yanına bile yaklaşmamışken seni fark eder. Şaşkına dönmüş gibi donar, ardından derin bir keder tarafından yutulmuşçasına görünür.\nDaha tek kelime edemeden, sisle birlikte yok olur."
  },
  Event_24543_Name = {
    Text = "Tanıdık Ama Yabancı Silüet"
  },
  Event_24544_ChoiceDesc1 = {
    Text = "[Who is She?] 3 Komut Kartından 1’ini Çoğalt"
  },
  Event_24544_ChoiceDesc2 = {
    Text = "[Ona Neden Böyle Oldu?] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_24544_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_24544_Desc = {
    Text = "Bir başka sis, bir başka siluet. Ama bu kez, karşındakini net biçimde görebiliyorsun.\nTıpkı senin gibi bir siluet, tıpkı seninki gibi bir üniforma, tıpkı seninki gibi bir yüz.\n\"Burada olmanın nedenini biliyorsun,\" dedi o kişi, \"tıpkı onun neden böyle olduğunun farkında olduğun gibi.\""
  },
  Event_24544_Name = {
    Text = "Strange-Yet-Familiar"
  },
  Event_24545_ChoiceDesc1 = {
    Text = "[Console] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_24545_ChoiceDesc2 = {
    Text = "[Approach] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_24545_ChoiceDesc3 = {
    Text = "[Turn and Leave] 25 Kara Mühür al"
  },
  Event_24545_Desc = {
    Text = "Yolunu sis örtüyor.\nPuslu gölgelerin içinden bir siluet beliriyor; gözlerini kısarsın ama yüzünü seçemez, yalnızca kesik kesik fısıltılar duyarsın.\n\"Neden... neden kurtaramıyorum... Kader gerçekten değiştirilemez mi...\""
  },
  Event_24545_Name = {
    Text = "Tanıdık Ama Yabancı Silüet"
  },
  Event_35039_ChoiceDesc1 = {
    Text = "[Ortaktan Yardım İste] 3 seçenekten 1 İleri Dua kazan"
  },
  Event_35039_ChoiceDesc2 = {
    Text = "[Manage the set] [(RelicConfig.Arg1)] adlı Altın Kalıntıyı edin."
  },
  Event_35039_ChoiceDesc3 = {
    Text = "[Phenomenal Frenzy] [(RelicConfig.Arg1)] adlı Kalıntıyı edin."
  },
  Event_35039_Desc = {
    Text = "\"‘Usta Houdini’nin Sinema Rehberi’nde’ açıkça belirtilmiştir ki Casiah, yani ben, yapımcı ve yönetmen olarak, tüm filmi denetleme görev ve gücüne sahibim. Bu nedenle, Casiah’nın cesur çalışanları, lütfen bir sonraki eylem takviminizi seçin!\"\n\"Takvim mi? Bir dakika, ben ne zaman senin çalışanların oldum?!\"\n\"Fırsat kapıyı yalnızca bir kez çalar, tereddüt etmeyin!\""
  },
  Event_35039_Name = {
    Text = "Producer's Myth"
  },
  Event_35103_ChoiceDesc1 = {
    Text = "[Connect] Arg2 YP yenile. [ExDesc1] [ExDesc2]"
  },
  Event_35103_ChoiceDesc2 = {
    Text = "[Meditate] Bir Uyandırıcıyı Uyanış’a geçir."
  },
  Event_35103_ChoiceDesc3 = {
    Text = "[Expel] En fazla 3 Semptom kartını İmha Et ve Arg2 Kara Mühür elde et."
  },
  Event_35103_Desc = {
    Text = "Sis ağır ağır yapışırken, rozetin solgun bir gümüş titreşimle yanıp sönüyor. İletişimci cızırtıyla hayata dönüyor. Biri arıyor."
  },
  Event_35103_Name = {Text = "Kavşak"},
  Event_35103_Tips3 = {
    Text = "Şu anda hiçbir Semptom göstermiyorsun."
  },
  Event_35165_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35165_Desc = {
    Text = "Tereddüt anında, inisiyatifi alıp gizemli hayırseverle iletişime geçtin.\n \"Artık bu noktadan sonra geri dönüş yok. Lütfen, Asil olan, cömert davran...\"\nGümüş iletişimci’nin diğer ucundan gür bir kahkaha yankılandı ve sonunda gülümseyerek isteğini kabul ettiler.\n \"Bu arada, bunu Ramona’dan sakladığından emin ol.\""
  },
  Event_35165_Name = {
    Text = "Producer's Myth"
  },
  Event_35236_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35236_Desc = {
    Text = "\"Bir prodüksiyon koordinatörü ne yapar? Casiah'ın farkında olmadan Gnosis Aktarıcısı'na sıkıştırdığı bir tomar belgeyi çıkardın ve dikkatle incelemeye başladın.\nSonra başın ağrımaya başladı.\nLotan'ın set düzenlemesi sırasında yaptığı harcamalar, Aurita ve Brown'un tükettiği atıştırmalıklar, Casiah'ın satın aldığı büyü küreleri için masraf iadesi talebi... Her bir Yerleşim önüne serilmiş, seni acı içinde çömelip Hesaplama yapmaya zorluyordu.\nBu arada, Casiah'ın büyü küreleri de neyin nesi?\""
  },
  Event_35236_Name = {
    Text = "Producer's Myth"
  },
  Event_35259_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] [ExDesc1][ExDesc2] Semptomunu geliştir."
  },
  Event_35259_ChoiceDesc2 = {Text = "[Leave]"},
  Event_35259_Desc = {
    Text = "Bulanık yüzler aniden belirir; seni sarar ve var olmayan ses telleriyle umutsuzca inlerler."
  },
  Event_35259_Name = {Text = "İllüzyon"},
  Event_35497_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35497_Desc = {
    Text = "Aşırı fanatizm olgusunun ardında mutlaka bir kolaylaştırıcı vardır ve “kolaylaştırıcı” denince akla hep yeşil saçlı bir kız gelir.\n\"Mythag Üniversitesi’nin bir numaralı simsarı, Hannah Peaslee hizmetinizde!\"\n\"Eğer bu Koruyucu’nun ilk hizmet talebiyse, yalnızca üç öğün yemekhane körisi bedeli ödemeniz yeterli!\""
  },
  Event_35497_Name = {
    Text = "Producer's Myth"
  },
  Event_35887_ChoiceDesc1 = {
    Text = "[Move Forward]"
  },
  Event_35887_Desc = {
    Text = "Yelkeni kaldırırsınız, ama altında hiçbir şey olmadığını görürsünüz. Kendinize geldiğinizde, yelken çoktan kaybolmuştur.\nSaf beyaz yelken ve bir kızın silik yüzü bir mesaj oluşturur; size, yol ne kadar uzun olursa olsun, aslında yalnız olmadığınızı hatırlatır."
  },
  Event_35887_Name = {
    Text = "Solgun Yelkenler"
  },
  Event_35888_ChoiceDesc1 = {
    Text = "[Raise the Sail]"
  },
  Event_35888_Desc = {
    Text = "Burada rüzgâr yok, yine de bembeyaz, tertemiz bir yelkenli, yelkeni gururla çekili halde, dingin mavi denize demir atmış duruyor.\nGenç bir kızın yüzünü silik silik seçersin; sanki ince bir sisin ya da dalgalanan bir su yüzeyinin ardından bakıyormuşsun gibi hatları bulanıktır. Varlığı, etrafındaki her şeyden yalıtılmış gibidir, ama yine de bu sahnenin odak noktası odur.\nGörüntüsü kimi zaman berraklaşır, kimi zaman silikleşir; ama hiç kuşku yok—onun kim olduğunu biliyorsun."
  },
  Event_35888_Name = {
    Text = "Solgun Yelkenler"
  },
  Event_35894_ChoiceDesc1 = {
    Text = "[Fall Downwards] 35 Kara Mühür al, [(Skill.Arg2)] becerisini geliştir ve seçim yapmaya devam et."
  },
  Event_35894_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_35894_Desc = {
    Text = "Kızın sesi havada eriyip dağılır; bir baloncuk gibi belirsiz ve uzak."
  },
  Event_35894_Name = {
    Text = "Ölümün Eşiği"
  },
  Event_35895_ChoiceDesc1 = {
    Text = "[Cycle Again] 30 Kara Mühür al, [(Skill.Arg2)] becerisini geliştir ve seçim yapmaya devam et."
  },
  Event_35895_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_35895_Desc = {
    Text = "Uzuvlar olağanüstü ağırlaşır, sis zayıf bedeni sıkıca sarar."
  },
  Event_35895_Name = {
    Text = "Ölümün Eşiği"
  },
  Event_35896_ChoiceDesc1 = {
    Text = "[Önceki Yolu Oku] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_35896_ChoiceDesc2 = {
    Text = "[Write Your Own Path] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_35896_ChoiceDesc3 = {
    Text = "[Stare into Darkness] 25 Kara Mühür al"
  },
  Event_35896_Desc = {
    Text = "Gizli Diyar’ı tek başına keşfediyor olsaydın, yolundan şu anki kadar emin olamazdın.\nGizli Diyar’daki ayak izleri üç yola ayrılmış; atılan her adım, görünmeyen bir geleceği yazıyor."
  },
  Event_35896_Name = {
    Text = "Çıkış Yolu"
  },
  Event_35897_ChoiceDesc1 = {
    Text = "[Support Her]"
  },
  Event_35897_ChoiceDesc2 = {
    Text = "[Look at her]"
  },
  Event_35897_Desc = {
    Text = "Mırıldanarak döne döne sana kadar gelir.\nBirisi onun hafif uykusunu bozmuştur; bilinci gerçekliğe bağlanmış, ruhu ise unutulmuş bir âlemde kalmıştır."
  },
  Event_35897_Name = {
    Text = "Yitik Hayalet"
  },
  Event_35898_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35898_Desc = {
    Text = "Bu ayrışmamış karanlığın içinde, bulanık ayak izlerinden oluşan bir dizi uzanıyor; sanki görünmeyen bir çölden geçen gece yolcusunun geride bıraktıkları gibi."
  },
  Event_35898_Name = {
    Text = "Çıkış Yolu"
  },
  Event_35899_ChoiceDesc1 = {
    Text = "[Ayrıl] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_35899_Desc = {
    Text = "Gözlerinde yansıyan, karanlığın eşiğinde tek başına duran uzak bir deniz feneri; gece denizinde bir rehber gibi, sükûnetli kıyıya doğru kaybolmuş ruhları çağıran, zayıf ama azimli bir ışık yayıyor.\nKendini onu takip ederken buluyorsun, fakat aniden ayaklarının altındaki zemin artık sağlam değil.\nGizlenmiş, sulu bir alana adım atıyorsun. Suyun yüzeyi ipek kadar pürüzsüz, sessizce ayak seslerini yutuyor."
  },
  Event_35899_Name = {
    Text = "Göz Kırpışı"
  },
  Event_35900_ChoiceDesc1 = {
    Text = "[Listen to Her]"
  },
  Event_35900_ChoiceDesc2 = {
    Text = "[Ignore Her]"
  },
  Event_35900_Desc = {
    Text = "Işığın kaynağını görüyorsun—kadın siluetli bir karakter.\nYabansı başından bir ışık seli akıyor, Bilinmeyen Yaratık’a giden bir yol döşüyor.\n \"Dönüş... Lemu@2a’ya...\""
  },
  Event_35900_Name = {
    Text = "Ebedi Işık"
  },
  Event_35901_ChoiceDesc1 = {
    Text = "[Approach the Lighthouse]"
  },
  Event_35901_ChoiceDesc2 = {
    Text = "[Stay away from the Lighthouse]"
  },
  Event_35901_Desc = {
    Text = "Gerçekle düşlerin iç içe geçtiği köşeyi döndüğünde, gözlerinin önünde bir anlığına dehşet verici bir fırtına manzarası açılır. Görünmez bir dev el tarafından havaya kaldırılmışçasına, rüzgâr azgın bir canavar gibi kükreyerek hem tozu hem umudu savurur. Gökyüzü ağır ve ezicidir.\n\nFırtınanın kalbinde, var olmaması gereken bir deniz feneri yükselir; hem hayalin bir ürünü, hem de kadim bir efsanenin yadigârı gibi. Öfkeli kasırganın sahnesinde, solgun bir ışık saçar; yalnız ve inatçı."
  },
  Event_35901_Name = {
    Text = "Fırtınanın Gözü"
  },
  Event_35902_ChoiceDesc1 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_35902_Desc = {
    Text = "\"Alan’da, ebedi ışıklar, dokunaçlı hayaletler...\"\nTulu gözlerini kapatır, bir an düşünür, sonra derin bir iç çekiş bırakır.\n\"Lemuria Koruyucusu... hizmetkârlarımdan biri. Sonunda, takıntılarının zincirlerinden kaçamaz.\""
  },
  Event_35902_Name = {
    Text = "Sona-Nyl'ın Batışı"
  },
  Event_35903_ChoiceDesc1 = {
    Text = "[Touch the Silver Light] 25 Kara Mühür al"
  },
  Event_35903_ChoiceDesc2 = {
    Text = "[Talk to Silverlight] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ama \"(Skill.Arg2)\" geliştir."
  },
  Event_35903_Desc = {
    Text = "Sıkıca mühürlenmiş iletişimci zorla açıldı, loş ışığın sızmasına izin verdi—muhtemelen Gümüş ile dış dünya arasında, içeriye mühürlendiğinden beri gerçekleşen ilk konuşma."
  },
  Event_35903_Name = {
    Text = "Mithril Anıtı"
  },
  Event_35904_ChoiceDesc1 = {
    Text = "[Leave] [(RelicConfig.Arg1)] Kalıntısını Edin"
  },
  Event_35904_Desc = {
    Text = "\"Parlayan kafalı bir kadın mı?\" Elton şaşkınlıkla bakar. Belli ki yük gemisi alanında ara sıra görülen o figürü duymuştur—ama—\n\"Sona-Nyl battığı gece... Celeste’i Uyandırdığım o gece, fırtınada böyle bir gölge görmüştüm.\"\n\"Evet, eminim görmüştüm.\""
  },
  Event_35904_Name = {
    Text = "Sona-Nyl'ın Batışı"
  },
  Event_35905_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35905_Desc = {
    Text = "Önündeki gizli diyar tehlikelerle dolu, akıl almaz bir derinlikte.\nGözlerin görünmeyen kaosa kilitlenmiş, ama o seni yutmadan önce, peşindekilerle işini bitirmiş olan Ramona kolundan yakalayıp seni başka bir yöne doğru çekiyor."
  },
  Event_35905_Name = {
    Text = "Çıkış Yolu"
  },
  Event_35906_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35906_Desc = {
    Text = "Bu, gizemli ruhunun meyvesi mi? Yaşadığın her şey, benlik ile üst-benliğin çarpışması mı?\nDüşündükçe, kafandaki gürültü berraklaşır. Görüş Alanın sisi deler; fakat içindeki silueti görebileceğin anda ruh seni reddeder."
  },
  Event_35906_Name = {
    Text = "Inverted Fate"
  },
  Event_35907_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35907_Desc = {
    Text = "İçinde kabarır, korkusuz bir güce dönüşür; seni sisi yarıp geçmeye, korkuyu paramparça etmeye destekler."
  },
  Event_35907_Name = {
    Text = "Işık Avcısı"
  },
  Event_35908_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35908_Desc = {
    Text = "Zihin odaklanıp içsel kaos dinerken, karmakarışık düşler yavaşça çözünmeye, çekilen bir gelgit gibi geri çekilmeye başlar.\nSonunda, beyindeki gürültü iz bırakmadan yok olur—ama ne kadarını özleyeceksin? Bu, bilinmezliğini korur."
  },
  Event_35908_Name = {
    Text = "Gelecek Uyarısı"
  },
  Event_35909_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35909_Desc = {
    Text = "Ruhun, çınlamanın içinde bütünüyle kaybolmuş; çırpınarak kurtulmaya, acının anlamını çözmeye çalışıyorsun, ama yalnızca bilincin kıyısında oyalanabiliyorsun..."
  },
  Event_35909_Name = {
    Text = "Ölümün Eşiği"
  },
  Event_35910_ChoiceDesc1 = {
    Text = "[Leave] 3 Altın Kalıntıdan 1’ini edin, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_35910_Desc = {
    Text = "Fener kulesinden çıkan her ışık huzmesini hissedebiliyorsun; fırtınada yanıp sıçrıyorlar, sanki ruhun derinliklerinden gelen bir çağrı gibi, en şiddetli korkunun ortasında bile eve dönüş yolunu göstermeye adanmış görevlerinden asla vazgeçmiyorlar."
  },
  Event_35910_Name = {
    Text = "Fırtınanın Gözü"
  },
  Event_35911_ChoiceDesc1 = {
    Text = "[Leave] 3 İleri Yakarıştan 1’ini Oyarak Yaz"
  },
  Event_35911_Desc = {
    Text = "Bir umut simgesi mi, yoksa bir yıkım habercisi mi?\nArtık ona bakmıyorsun; sanki varlığı, ince ince işlenmiş bir düşten ibaretmiş gibi."
  },
  Event_35911_Name = {
    Text = "Fırtınanın Gözü"
  },
  Event_35912_ChoiceDesc1 = {
    Text = "[Sink into Oblivion] 20 Kara Mühür al, ancak [(Skill.Arg2)] becerisini geliştir."
  },
  Event_35912_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_35912_Desc = {
    Text = "Sonra, alışılmadık gri bir örtü gözlerini kaplar. Birkaç an sonra, bunun yarı saydam üst göz kapağın olduğunu fark edersin."
  },
  Event_35912_Name = {
    Text = "Ölümün Eşiği"
  },
  Event_35913_ChoiceDesc1 = {
    Text = "[Leave] Rastgele bir Uyandırıcıyı Uyanışa geçir, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_35913_Desc = {
    Text = "Tarifsiz bir Rezonans hissediyorsun.\nAma mantık sana fısıldıyor: Onu Görmezden Gel."
  },
  Event_35913_Name = {
    Text = "Ebedi Işık"
  },
  Event_35914_ChoiceDesc1 = {
    Text = "[Ayrıl] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_35914_Desc = {
    Text = "Sözleri hiçbir bilinen stelaya kazınmamıştır, yine de havada en derin pişmanlık ve çağrı olarak katılaşır. Sanki başka bir zamandan süzülüp gelmiş, yılların tortullaşmasını aşarak uzak bir Beyaz Kuş Diyarı’na duyulan derin özlemi taşımaktadır."
  },
  Event_35914_Name = {
    Text = "Ebedi Işık"
  },
  Event_35915_ChoiceDesc1 = {
    Text = "[Hold Her Hand] Rastgele bir Gümüş Kalıntıyı Altın Kalıntı [(RelicConfig.Arg1)]ya Yükselt"
  },
  Event_35915_ChoiceDesc2 = {
    Text = "[Express Concern] Gümüş Kalıntı \"(RelicConfig.Arg1)\" elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_35915_ChoiceDesc3 = {
    Text = "[Gaze at Her] 25 Kara Mühür al"
  },
  Event_35915_Desc = {
    Text = "Murphy takımın arkasında, Celeste ile yan yana yürüyor.\nKendinizi sık sık arkaya bakarken buluyorsunuz, ama Murphy gözlerini ayakkabılarından ayırmıyor, ifadesini gizlilik içinde saklıyor."
  },
  Event_35915_Name = {
    Text = "Acı Yönetimi"
  },
  Event_35915_Tips1 = {
    Text = "Henüz edinilmemiş Gümüş Kalıntı"
  },
  Event_35916_ChoiceDesc1 = {
    Text = "[No Way Out] 40 Kara Mühür al, [(Skill.Arg2)] becerisini geliştir ve seçim yapmaya devam et."
  },
  Event_35916_ChoiceDesc2 = {
    Text = "[Embrace Reality] 25 Kara Mühür al ve ayrıl."
  },
  Event_35916_Desc = {
    Text = "@1@1canlanır; ruh, @2 sınırında dolaşır, yine de bütünüyle bedeni kucaklamaz.\nMurphy’nin kaygılı sözleri bilincinden silinir; kulakta oyalanan ama daima zihnin bariyerlerine çarpıp kalan kargaların feryatları gibi."
  },
  Event_35916_Name = {
    Text = "Ölümün Eşiği"
  },
  Event_35917_ChoiceDesc1 = {
    Text = "[Leave] Bir Komut Kartını kopyala, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_35917_Desc = {
    Text = "O, gerçekte oyalanan bir hayaletten ibaret; dokunulamayan, ama unutulmayı reddeden kadim bir Parça."
  },
  Event_35917_Name = {
    Text = "Yitik Hayalet"
  },
  Event_35918_ChoiceDesc1 = {
    Text = "[Leave] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_35918_Desc = {
    Text = "O anda, ruhunun derinliklerinde hafif bir çatırdama duyarsın. Duman gibi dağılarak, onun sureti bulanıklaşır ve gerçekliğini yitirir.\nO gerçekte orada değildir; yalnızca Kaptan Elton’un bir Yansıtma’sıdır.\nYine de, geride kalan kayıp ve şaşkınlık hissi bütünüyle gerçektir."
  },
  Event_35918_Name = {
    Text = "Yitik Hayalet"
  },
  Event_35919_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35919_Desc = {
    Text = "Parmak uçların temas ettiği anda, karmaşık bir his kabarır—hem yakıcı hem dondurucu.\nDünya tarafından unutulmuş ruhlar, sonsuzluğu arayarak ulur."
  },
  Event_35919_Name = {
    Text = "Mithril Anıtı"
  },
  Event_35920_ChoiceDesc1 = {
    Text = "[Grasp the Spark] Azami HP’yi Arg1 kadar artır"
  },
  Event_35920_ChoiceDesc2 = {
    Text = "[İç Dünyayla Yüzleş] Rastgele 2 Komut Kartı Mühür kazan: \"(EnchantConfig.Arg1)\", 2 \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_35920_Desc = {
    Text = "Bu büyük avda, Golyat’ın Av’ı karanlıktaki bir canavar gibidir; tüm umudu Her Şeyi Yutmak için nişan alır. Ne var ki bu amansız takip seni Dondurmaz; tam tersine, derinlerinde bir kıvılcım çakar, göğsünde Yayılma ile daha da hararetle yanar."
  },
  Event_35920_Name = {
    Text = "Işık Avcısı"
  },
  Event_35921_ChoiceDesc1 = {
    Text = "[Decipher It] 3 Komut Kartından 1’ini Çoğalt"
  },
  Event_35921_ChoiceDesc2 = {
    Text = "[Ona Dönüş] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_35921_ChoiceDesc3 = {
    Text = "[Disregard It] 25 Kara Mühür al"
  },
  Event_35921_Desc = {
    Text = "Bir adım attığında, görünmez bir titreşim zihnini yakalar, bakışını zorla Gizli Diyar’ın kaotik ve aldatıcı sınırına çevirtir."
  },
  Event_35921_Name = {
    Text = "Gelecek Uyarısı"
  },
  Event_35922_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35922_Desc = {
    Text = "Gözlerinin önünde göz kamaştırıcı renkler dans eder, kulaklarını fısıltılar doldurur; yüzleri bulanık, gelip geçen sahneler birbirine dolanır, sanki bilinmeyen hikâyeler anlatıyormuşçasına. Bu düşler, seni gerçeklikten koparır, hem tanıdık hem yabancı bir Düş Diyarı’na çeker."
  },
  Event_35922_Name = {
    Text = "Gelecek Uyarısı"
  },
  Event_35923_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35923_Desc = {
    Text = "Bu sarsıntı dışarıdan gelen bir gürültüden ya da fiziksel bir titreşimden değil, tarif edilemez, derin bir iç önseziden kaynaklanıyor. Bilincinde atan, geleceğin içinden gelen bir çağrı gibi."
  },
  Event_35923_Name = {
    Text = "Gelecek Uyarısı"
  },
  Event_35924_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35924_Desc = {
    Text = "Eli, boğucu hissi bastırmaya çalışır gibi içgüdüsel olarak göğsüne gider.\nKorku, dişlerini sıkmasına neden olur; göğsündeki saplanıp kalan acıyı görmezden gelmeye kendini zorlar. Murphy’nin yüzündeki en ufak bir buruşma bile hızla gizlenir, acıyı sakar bir maskenin ardına saklar.\n—Ta ki elini tuttuğun ana kadar; o an, ifadesi şaşkınlıkla renklenir."
  },
  Event_35924_Name = {
    Text = "Acı Yönetimi"
  },
  Event_35925_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35925_Desc = {
    Text = "\n \"Murphy? İyi misin?\"\n— Sana karşılık vermez.\nElle tutulur tuhaflık kalbini aşındırır, nefes almasını neredeyse imkânsız kılar."
  },
  Event_35925_Name = {
    Text = "Acı Yönetimi"
  },
  Event_35926_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35926_Desc = {
    Text = "Artık tereddüt etmiyor ve zifiri karanlık bilinmeyene adım atıyorsun. Nereye gidersen git, soluk bir Parıltı’ya uzanan bir patika önünde açılıyor."
  },
  Event_35926_Name = {
    Text = "Çıkış Yolu"
  },
  Event_35927_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35927_Desc = {
    Text = "\nÖnünde nabız atan bir ateş var.\nHararetli, canlı; titreşen soğuk bir alevi sarmalıyor, o uyumsuz sesleri parlak bir şekilde dağıtıyor.\nKendine geldiğinde, Murphy’nin sana şaşkınlıkla baktığını görürsün —\n \"Gerçekten iyi misin?\""
  },
  Event_35927_Name = {
    Text = "Ölümün Eşiği"
  },
  Event_35928_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35928_Desc = {
    Text = "Bilinçlerinin ayrılmaya başladığını, yavaşça bedeninden çekilip alındığını hissediyorsun.\nRuhunun, Gümüş’ün bilincinin kalıntılarıyla dans ettiğini, sonra görünmez bir uçuruma battığını görüyorsun...\nOrada saf Düş yatıyor."
  },
  Event_35928_Name = {
    Text = "Mithril Anıtı"
  },
  Event_35929_ChoiceDesc1 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_35929_Desc = {
    Text = "Işığın kaynağını daha fazla araştırmaya fırsat bulamadan, birden titrer ve havada paramparça olur.\nIşık, Gizli Diyar boyunca dalgalar halinde yayılır.\nSonra, geriye hiçbir şey kalmaz."
  },
  Event_35929_Name = {
    Text = "Göz Kırpışı"
  },
  Event_35930_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35930_Desc = {
    Text = "Bu nasıl sen olabilirsin?\nEğer o sen olsaydın, ağıt çöktüğünde Neden seni kurtarmadı?\nEğer o sen olsaydın, Neden seni sıkıntılarından çekip çıkarmadı?\nDemek ki hepsi bir düş."
  },
  Event_35930_Name = {
    Text = "Inverted Fate"
  },
  Event_35931_ChoiceDesc1 = {
    Text = "[Ask the Captain]"
  },
  Event_35931_ChoiceDesc2 = {Text = "[Ask Tulu]"},
  Event_35931_Desc = {
    Text = "Yine o esrarengiz figürün, hiçbir iz bırakmadan bölme duvarının içine karışarak kaybolduğunu görürsün. Işıltılı uzun saçları yere değen birkaç dokunaç hâline gelerek aşağı süzülür.\nBiliyorsun; Denizci olmasa bile, mutlaka Kayıp Ulus’la güçlü bağları olmalı."
  },
  Event_35931_Name = {
    Text = "Sona-Nyl'ın Batışı"
  },
  Event_35932_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35932_Desc = {
    Text = "Korkuyorsun; hepsi Adrenalin yüzünden.\nAldığın kararların, karanlığı seninle paylaşan ruhlara zarar vermesinden korkuyorsun."
  },
  Event_35932_Name = {
    Text = "Işık Avcısı"
  },
  Event_35933_ChoiceDesc1 = {
    Text = "[Nowhere to Run] 25 Kara Mühür al, [(Skill.Arg2)] becerisini geliştir ve seçim yapmaya devam et."
  },
  Event_35933_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_35933_Desc = {
    Text = "Her sinir, @2 için yanıp tutuşan bir özlemle çığlık atıyor."
  },
  Event_35933_Name = {
    Text = "Ölümün Eşiği"
  },
  Event_35934_ChoiceDesc1 = {Text = "[Chase]"},
  Event_35934_ChoiceDesc2 = {
    Text = "[Ignore It]"
  },
  Event_35934_Desc = {
    Text = "Mıntıkanın uzağında, soluk ve büyüleyici bir ışık beliriyor.\nSuda dans eden güneş ışığı, titreşen yıldız tozu ya da bir mum alevi gibi parıldıyor...\nYaklaştığında, ışık aniden sönüyor.\nSanki seni içeri çekmek istiyor; tıpkı bir güveyin içgüdüsel olarak alevi araması gibi."
  },
  Event_35934_Name = {
    Text = "Göz Kırpışı"
  },
  Event_35935_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35935_Desc = {
    Text = "Bunları düşünmenin ne faydası var?\nKader rüzgârlarının ittiği, havada asılı bir yaprak gibisin. Hepsi bu."
  },
  Event_35935_Name = {
    Text = "Inverted Fate"
  },
  Event_35936_ChoiceDesc1 = {
    Text = "[Self-Deprecation] Gümüş Kalıntı \"(RelicConfig.Arg1)\"i elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_35936_ChoiceDesc2 = {
    Text = "[Pursue] Altın Kalıntı \"(RelicConfig.Arg1)\"i elde et, fakat \"(Skill.Arg2)\" ve \"(Skill.Arg3)\" geliştir."
  },
  Event_35936_ChoiceDesc3 = {
    Text = "[Stop Thinking] 25 Kara Mühür al"
  },
  Event_35936_Desc = {
    Text = "Yaşamın rüzgârı ruhuna dokunur, seni gerçekliğin girdabında sarsar ve sisle örtülü bilinmeyene doğru çeker.\nKafandaki sese sormadan edemezsin: “Bu ben miyim?”"
  },
  Event_35936_Name = {
    Text = "Inverted Fate"
  },
  Event_36146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36146_Desc = {
    Text = "\nMurphy sonunda bakışını fark eder; belki de gerçekten fazla yoğundur.\nBirkaç derin nefes alır, burnundan hafif bir \"hımm\"çıkarır. Sonunda Celeste’i de çekip yanına alır, sana sıkıca arka safta eşlik eder."
  },
  Event_36146_Name = {
    Text = "Acı Yönetimi"
  },
  Event_36722_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36722_Desc = {
    Text = "Parmak uçların temas ettiği anda, karmaşık bir his kabarır—hem yakıcı hem dondurucu.\nDünya tarafından unutulmuş ruhlar, sonsuzluğu arayarak ulur."
  },
  Event_36722_Name = {
    Text = "Gnosis Anıtı"
  },
  Event_36723_ChoiceDesc1 = {
    Text = "[Touch it] Rastgele bir Uyandırıcıyı Uyanışa geçir, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_36723_ChoiceDesc2 = {
    Text = "[Join the Spin] 3 Yakarıştan 1’ini Oyarak Kazı"
  },
  Event_36723_Desc = {
    Text = "Bir adım attığında, ruhunun en derin yerinde sessizce bir çatlak oluşur. Tarif edilemez, derin bir aura sızar, düşüncelerini dalgalandırır.\nİçinde sessizce dönen ve büyüyen Gümüş bir kaos Gezegen’i hissetmeye başlarsın."
  },
  Event_36723_Name = {
    Text = "Gnosis Anıtı"
  },
  Event_36724_ChoiceDesc1 = {
    Text = "[Follow them] Gümüş Kalıntı \"(RelicConfig.Arg1)\"i elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_36724_ChoiceDesc2 = {
    Text = "[Pet Them] Altın Kalıntı \"(RelicConfig.Arg1)\"i elde et, fakat \"(Skill.Arg2)\" ve \"(Skill.Arg3)\" geliştir."
  },
  Event_36724_ChoiceDesc3 = {
    Text = "[Do Not Disturb] 25 Kara Mühür al"
  },
  Event_36724_Desc = {
    Text = "Beklenmedik bir köşeyi döndüğünde, tuhaf bir manzara gözüne çarpıyor.\nBirkaç kedi benzeri gölge, soğuk gövde boyunca belirsizce süzülüyor."
  },
  Event_36724_Name = {
    Text = "Gemi Kedileri"
  },
  Event_36725_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36725_Desc = {
    Text = "\"Anılar\" karşılık vermez. Kamara duvarına yapışıp kalırlar, sen bir sonraki köşeyi dönene dek sana bakarlar."
  },
  Event_36725_Name = {
    Text = "Sona-Nyl'ın Efendisi"
  },
  Event_36726_ChoiceDesc1 = {
    Text = "[Detour] Bir Komut Kartı İmha Et ve Arg1 Kara Mühür kazan."
  },
  Event_36726_ChoiceDesc2 = {
    Text = "[Ask Why It Sank] Bir Komut Kartını kopyala, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_36726_ChoiceDesc3 = {
    Text = "[Greet the Crew] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_36726_Desc = {
    Text = "\nMakine dairesine doğru yürürken, alana çivilenmiş bazı \"anılar\" la yeniden karşılaşırsın.\nOnlar birer hayalet değil, yalnızca Kaptan Elton’un kayıp mürettebata dair kalıntı düşünceleridir."
  },
  Event_36726_Name = {
    Text = "Sona-Nyl'ın Efendisi"
  },
  Event_36727_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36727_Desc = {
    Text = "\n \"Anılar\" bölme duvarından sıyrılır, yüzleri çarpılıp acı bir feryat koparırlar.\n—Fener.\n—Yalıtılmış deniz feneri onları fırtınanın içine sürükledi."
  },
  Event_36727_Name = {
    Text = "Sona-Nyl'ın Efendisi"
  },
  Event_36728_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36728_Desc = {
    Text = "Nazik ve özgür ruhların çizdiği fitil yolu izlemeyi seçtin, önünde karanlığın bıraktığı tuzaklar olsa bile."
  },
  Event_36728_Name = {
    Text = "Gemi Kedileri"
  },
  Event_36729_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36729_Desc = {
    Text = "Ne ölüyü rahatsız et, ne de hafif uykudakilerin anılarını kurcala."
  },
  Event_36729_Name = {
    Text = "Sona-Nyl'ın Efendisi"
  },
  Event_36730_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36730_Desc = {
    Text = "Bilinçlerinin ayrılmaya başladığını, yavaşça bedeninden çekilip alındığını hissedersin.\nRuhunun Gezegen’le dans ettiğini, ardından görünmez bir uçuruma battığını görürsün...\nOrada saf bir hiçlik yatar."
  },
  Event_36730_Name = {
    Text = "Gnosis Anıtı"
  },
  Event_36731_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36731_Desc = {
    Text = "Nazik varlıklar olarak, bu Alan’da yasak bir lükstürler, yalnızca birer fantazma.\nBunu bilsen de, kalbinde hafif bir sıcaklık dalgası yine de titreşir."
  },
  Event_36731_Name = {
    Text = "Gemi Kedileri"
  },
  Event_36732_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36732_Desc = {
    Text = "Silüetleri bulanıktır; sanki zaman ve mekânın selleriyle yıkanıp silinmiş bir tablo gibi. Derin siyah lekeler, gece göğünde sürüklenen bulutları andırır; ama gözleri, uzak yıldızların parıltısı gibi parlar, esrarengiz ve derin bir ışıma yayar.\nOnların cazibesine karşı koyamaz, elini bir Düş diyarına uzatırsın."
  },
  Event_36732_Name = {
    Text = "Gemi Kedileri"
  },
  Event_36733_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36733_Desc = {
    Text = "Tökezlesen de, düşsen de, ilerlemeye devam etmen gerektiğini biliyorsun."
  },
  Event_36733_Name = {
    Text = "Bedensel Acı"
  },
  Event_36734_ChoiceDesc1 = {
    Text = "[Attempt to Call Him] Azami CP’yi Arg1 kadar Artır"
  },
  Event_36734_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36734_Desc = {
    Text = "Burası gizlenmiş arzular ve el değmemiş korkularla dolu; onun düşleri ve Anılarıyla örülmüş zengin bir dokuma."
  },
  Event_36734_Name = {
    Text = "Evrimin Dönüşümü"
  },
  Event_36735_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36735_Desc = {
    Text = "\"Muhafız, eğer dayanamıyorsan, lütfen acıyı tek başına yüklenme.\"\nAcıdan kaçınmayacaksın, çünkü o, gelip geçen hayatın bir parçası.\nGecenin gölgelerinden korkmayacaksın, çünkü karanlığı tarafından yutulmaktan ürkmüyorsun."
  },
  Event_36735_Name = {
    Text = "Bedensel Acı"
  },
  Event_36736_ChoiceDesc1 = {
    Text = "[Keep Calling Him] Azami CP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_36736_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36736_Desc = {
    Text = "Bu dünya, saf karalamalardan oluşuyor."
  },
  Event_36736_Name = {
    Text = "Evrimin Dönüşümü"
  },
  Event_36737_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36737_Desc = {
    Text = "Denizcilerin saygı duruşu etrafta yankılanır, delirtici ve boğucudur.\nAma iradeni etkilemeyecekler, asla."
  },
  Event_36737_Name = {
    Text = "Denizden Gelen"
  },
  Event_36738_ChoiceDesc1 = {
    Text = "[Pick up the Photo] 3 Komut Kartı’ndan 1’ine [(EnchantConfig.Arg1)] Yakarı’nı kazır."
  },
  Event_36738_Desc = {
    Text = "Bakışları derin ve berrak, Derin Deniz'deki ışık gibi parlak ve sıcak.\nKonuşmazlar, görünmezler; ama varlıklarını hissedersin, yaz esintisinin nazik okşayışı gibi."
  },
  Event_36738_Name = {
    Text = "İyi Niyetli Bakış"
  },
  Event_36739_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36739_Desc = {
    Text = "Kendini, içinde bulunduğun krize odaklanmaya zorluyor, acıyı görmezden gelmeni sertçe emrediyorsun."
  },
  Event_36739_Name = {
    Text = "Bedensel Acı"
  },
  Event_36740_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36740_Desc = {
    Text = "Onlar yaşamın izleri, varoluşun kanıtıdır. Hikâyeler anlatırlar ama fırtınanın gazabı altında yavaş yavaş seslerini yitirirler."
  },
  Event_36740_Name = {
    Text = "Hoşça Kal, İkaros"
  },
  Event_36741_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36741_Desc = {
    Text = "Bakışları derin ve berrak, Derin Deniz'deki ışık gibi parlak ve sıcak.\nKonuşmazlar, görünmezler; ama varlıklarını hissedersin, yaz esintisinin nazik okşayışı gibi."
  },
  Event_36741_Name = {
    Text = "İyi Niyetli Bakış"
  },
  Event_36742_ChoiceDesc1 = {
    Text = "[The Last Call] Azami CP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_36742_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36742_Desc = {
    Text = "Dünya, acı verici yarıklardan oluşuyor."
  },
  Event_36742_Name = {
    Text = "Evrimin Dönüşümü"
  },
  Event_36743_ChoiceDesc1 = {
    Text = "[Embrace Pain] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" Becerisini geliştir."
  },
  Event_36743_ChoiceDesc2 = {
    Text = "[Refuse Pain] Altın Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" ve \"(Skill.Arg3)\" Becerilerini geliştir."
  },
  Event_36743_ChoiceDesc3 = {
    Text = "[Ignore Pain] 25 Kara Mühür al"
  },
  Event_36743_Desc = {
    Text = "Acı, zihnine inatçı bir kaya gibi kök salmış. Yayılıp duran ıstırap her siniri Sarmalamakta, bilincini bükmektedir."
  },
  Event_36743_Name = {
    Text = "Bedensel Acı"
  },
  Event_36744_ChoiceDesc1 = {
    Text = "[Firm Call] Azami HP’yi Arg1 kadar artır, fakat [(Skill.Arg2)] Semptomu’nu geliştir."
  },
  Event_36744_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36744_Desc = {
    Text = "Tanınma arzusu bu dünyayı şekillendiriyor."
  },
  Event_36744_Name = {
    Text = "Evrimin Dönüşümü"
  },
  Event_36745_ChoiceDesc1 = {
    Text = "[Watch Them] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_36745_ChoiceDesc2 = {
    Text = "[Seek Help] [(Skill.Arg1)] Semptomunu geliştir ve kazınacak Yakarışı değiştir.(Kullanım: 2/2)"
  },
  Event_36745_Desc = {
    Text = "Alan’ın akışkan renkleri içinde, esrarengiz bir bakışı hissedersin—şekli olmayan gözler, onun muammalı kıvrımlarının içinde gizlenmiştir.\nBakışlarını üzerine çevirdikleri anda, kalbinin derinliklerinden güçlü bir arzu kabarır."
  },
  Event_36745_Name = {
    Text = "İyi Niyetli Bakış"
  },
  Event_36746_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36746_Desc = {
    Text = "Onları anlayamazsan, bu kaotik alev cehenneminden kaçamayacaksın.\nYıldızlar suyun yüzeyine yansıdığında, o atan dilekler ve yakarışlar, o dualar, denize doğru kabarcıklar gibi yükselir, yalnızca sessizce karanlık tarafından yutulmak için."
  },
  Event_36746_Name = {
    Text = "Denizden Gelen"
  },
  Event_36747_ChoiceDesc1 = {
    Text = "[Eager Call] Azami CP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_36747_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36747_Desc = {
    Text = "Çirkin sözler kuruyor bu dünyayı."
  },
  Event_36747_Name = {
    Text = "Evrimin Dönüşümü"
  },
  Event_36748_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36748_Desc = {
    Text = "Onun önünde duruyor, ruhunun tuhaf anılar tarafından yutuluşunu izliyorsun."
  },
  Event_36748_Name = {
    Text = "Evrimin Dönüşümü"
  },
  Event_36749_ChoiceDesc1 = {
    Text = "[Tears of Sorrow] Bir Kartı İmha Et"
  },
  Event_36749_ChoiceDesc2 = {
    Text = "[That's Blood] \"(RelicConfig.Arg1)\" Kalıntısını elde et, fakat \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_36749_Desc = {
    Text = "Birkaç damla sıvı güverte boyunca serbestçe yayılır, sessizce çatlaklardan sızar.\nİzler yumuşak ama azimlidir; her ıslak leke bir kesinlik duygusu taşır, uğuldayan deniz rüzgârı ve gıcırdayan yelkenler arasında yaşamla ölümü, dinginlikle kaosu dokuyan bir resim örer."
  },
  Event_36749_Name = {
    Text = "Hoşça Kal, İkaros"
  },
  Event_36750_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36750_Desc = {
    Text = "Yavaşça yayılan lekeleri seyrederek, doğalarını anlamaya çalışırsınız. Gökle yerin birleştiği sınırda, yağmurla kan arasındaki ayrım bulanıklaşır.\nBunlar yağmur damlaları mı? Yoksa okyanusun gözyaşları mı?\nBilmiyorsunuz."
  },
  Event_36750_Name = {
    Text = "Hoşça Kal, İkaros"
  },
  Event_36751_ChoiceDesc1 = {
    Text = "[Reject the Synchrony] 3 Gümüş Kalıntı arasından 1 tane edin"
  },
  Event_36751_ChoiceDesc2 = {
    Text = "[Join the Synchrony] \"(RelicConfig.Arg1)\" ve \"(RelicConfig.Arg2)\" Gümüş Kalıntılarını edin, ancak \"(Skill.Arg3)\" becerisini iki kez geliştir"
  },
  Event_36751_Desc = {
    Text = "Denizcilerin fısıltıları, \"Kutsal Cenin\"in kalp atışıyla iç içe geçerek gizli bir senfoni yaratır. Her titreşim, hudutsuz sıvı evrende uğuldayan bir kükremeyi tetikler."
  },
  Event_36751_Name = {
    Text = "Denizden Gelen"
  },
  Event_36752_ChoiceDesc1 = {
    Text = "[Pick up the Photo] 3 Komut Kartı’ndan 1’ine [(EnchantConfig.Arg1)] Yakarı’nı kazır."
  },
  Event_36752_ChoiceDesc2 = {
    Text = "[Check Film] [(Skill.Arg1)] Semptomunu geliştir ve kazınacak Yakarışı değiştir.(Kullanım: 1/2)"
  },
  Event_36752_Desc = {
    Text = "Kötü niyet taşımazlar; bu duygu yalnızca içgüdüseldir, kemiklerine işlemiştir.\nBu yüzden gardını indirir ve bu gizli gözlemcilerden yardım istemeye çalışırsın: şaşkınlığını ve arzularını o muğlak varlıkla paylaşırsın, sanki bir Eski Dost’a içini döker gibi içtenlikle konuşarak."
  },
  Event_36752_Name = {
    Text = "İyi Niyetli Bakış"
  },
  Event_36874_ChoiceDesc1 = {
    Text = "[Narrate school stories] [(RelicConfig.Arg1)] adlı Gümüş Kalıntıyı elde et."
  },
  Event_36874_ChoiceDesc2 = {
    Text = "[Uneducated] 75 Kara Mühür al, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_36874_Desc = {
    Text = "Bir harabenin yanından geçerken Aurita’nın gözleri birden parladı.\n“Büyükannem, buranın eskiden bir okul olduğunu, ama öğrenciler olmadığı için çoktan terk edildiğini söylemişti!”\n“Aurita hiç okula gitmedi. Peki ya sen, dostum? Sen hiç okula gittin mi?”"
  },
  Event_36874_Name = {
    Text = "Yitik Neşe"
  },
  Event_36875_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36875_Desc = {
    Text = "Senden olumsuz bir cevap alan Aurita, kederle başını salladı.\n\"Demek dış dünyada da öğrenciler yok... O hâlde en başta okulların kurulmasının amacı neydi?\""
  },
  Event_36875_Name = {
    Text = "Yitik Neşe"
  },
  Event_36876_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36876_Desc = {
    Text = "\"Yoksullar Evi, Küçük Fare, Balmumu Heykel... Yaşasın! Macera, bu bir macera!\"\nAurita dedi, başının üzerinde görünmez bir soru işareti süzülürken.\n \"Yalnız, Büyükanne, okulun Aurita’yı daha akıllı yapacak bir yer olduğunu söylemişti ama...\"\nAurita düşüncesini sürdüremeden, onu hızla bir başka köşeden döndürdün."
  },
  Event_36876_Name = {
    Text = "Yitik Neşe"
  },
  Event_36877_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36877_Desc = {
    Text = "\n“ N-neden?”\nAurita, senin tarafından ürkmüş, sert bir ifadeyle seni yönlendirmeye devam ediyordu.\n“Burası Aurita’nın evi. Aurita biliyor ki meydan—hemen içeride!”"
  },
  Event_36877_Name = {
    Text = "Görülemeyen Karanlık"
  },
  Event_36878_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36878_Desc = {
    Text = "\"Bu güzergâhtan gitmek istemiyorum. Aurita meydana giden başka bir yol biliyor mu?\"\nAurita dudaklarını büküp kafası karışmış gibi baktı, ama sonunda pelerininin ucundan çekiştirip seni başka bir yöne doğru götürdü."
  },
  Event_36878_Name = {
    Text = "Görülemeyen Karanlık"
  },
  Event_36879_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36879_Desc = {
    Text = "Bu bir rüya, sadece bir rüya.\nKendini durmadan azarlıyor, belki de teselli ediyorsun; Aurita’yı görünmeyen Karanlık’a doğru sürüklüyorsun."
  },
  Event_36879_Name = {
    Text = "Görülemeyen Karanlık"
  },
  Event_36880_ChoiceDesc1 = {
    Text = "[Listen to Her] \"(EnchantConfig.Arg1)\" Yakarışını 3 Komut Kartından 1’ine kazı, ancak \"(Skill.Arg2)\" Becerisini geliştir."
  },
  Event_36880_ChoiceDesc2 = {
    Text = "[Oppose Her] Bir Uyandırıcıyı Uyanışa geçir, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_36880_ChoiceDesc3 = {
    Text = "[Negotiate with Her] 25 Kara Mühür al"
  },
  Event_36880_Desc = {
    Text = "Aurita pelerininize tutunarak ayak izlerinizi takip ederek adım adım ilerler.\n\"Hey... hayır! Meydan o tarafta!\"\nBaşınızı Aurita'nın işaret ettiği yöne çevirirsiniz ve Gizli Diyar'daki yollar zifiri karanlıktır. D-sümüğü ve sapkınlıklar birbirine dolanıp kıvranarak gerçek dünyayı Uçuruma sürükler."
  },
  Event_36880_Name = {
    Text = "Görülemeyen Karanlık"
  },
  Event_37983_ChoiceDesc1 = {
    Text = "[Secure Funding] Arg1 Kara Mühür Elde Et"
  },
  Event_37983_ChoiceDesc2 = {
    Text = "[Secure Funding] Arg1 Kara Mühür elde et [ExDesc1]"
  },
  Event_37983_Desc = {
    Text = "\"Hiçbir lord, hele ki bir keşiş, gizemli bir konuğu gözetimsiz bırakmaz.\"\nKraliçe, Taht'ında yüksekte oturuyordu; Onun Gözleri'nde tiranlığın bir titreşimi yanıp söndü.\n\"Yararlılığını kanıtla, yoksa...\"\nYararlılık mı? Pencereden dışarıdaki kısır toprağa göz gezdiriyorsun, bir düşünce birden beliriyor: belki ekonomik Bilgi'ni kullanarak Wanda'ya mülkü yönetmede yardım edebilirsin?\nZihnini zorlayıp derslerini hatırlamaya çalışıyorsun—Mythag'da iktisat sadece küçük bir seçmeli dersti...\nSabır tükeniyor. Kraliçe esniyor.\n\"Hayal kırıklığı. İnfaz edin—\"\nGiyotin tam düşerken, Adam Smith, Malthus, David Ricardo ve diğer büyük öncüllerin ruhları zihnine iniyor.\nİşbölümü! Vergilendirme! Nüfus, lanet olası nüfus!\nBelki hatırlarsın..."
  },
  Event_37983_Name = {Text = "Vekil Kodu"},
  Event_37984_ChoiceDesc1 = {Text = "[Leave]"},
  Event_37984_Desc = {
    Text = "İsteksizce fermanı sunarsın.\nKraliçe göz ucuyla bakar ve soğuk bir gülümsemeyle der ki:\n\"Eğer işe yaramazsa, ne olacağını biliyorsun.\""
  },
  Event_37984_Name = {Text = "Vekil Kodu"},
  Event_37985_ChoiceDesc1 = {
    Text = "[Propose Decree] [(RelicConfig.Arg1)] adlı Gümüş Kalıntı’yı elde et"
  },
  Event_37985_ChoiceDesc2 = {
    Text = "[Propose Decree] [(RelicConfig.Arg1)] adlı Lanetli Kalıntı’yı elde et"
  },
  Event_37985_ChoiceDesc3 = {
    Text = "[Propose Decree] [(RelicConfig.Arg1)] adlı Altın Kalıntı’yı elde et"
  },
  Event_37985_Desc = {
    Text = "\n \"Paramı aldıysan, bana hizmet etmek zorundasın.\"\nKraliçe çenesini eline dayamış, seni umursamaz bir tavırla süzüyordu.\nKabul etse de etmese de, buna gerçekten merak duyduğu açıktı.\n \"Şimdi söyle bakalım, büyük reformcu, planın nedir?\""
  },
  Event_37985_Name = {Text = "Vekil Kodu"},
  Event_38700_ChoiceDesc1 = {
    Text = "[Connect] Arg2 YP yenile. [ExDesc1]"
  },
  Event_38700_ChoiceDesc2 = {
    Text = "[Meditate] Bir Uyandırıcıyı Uyanış’a geçir."
  },
  Event_38700_ChoiceDesc3 = {
    Text = "[Expel] En fazla 3 Semptom kartını İmha Et ve Arg2 Kara Mühür elde et."
  },
  Event_38700_Desc = {
    Text = "Sis ağır ağır yapışırken, rozetin solgun bir gümüş titreşimle yanıp sönüyor. İletişimci cızırtıyla hayata dönüyor. Biri arıyor."
  },
  Event_38700_Name = {Text = "Kavşak"},
  Event_38700_Tips3 = {
    Text = "Şu anda hiçbir Semptom göstermiyorsun."
  },
  Event_38707_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Rastgele bir Semptom geliştir."
  },
  Event_38707_ChoiceDesc2 = {
    Text = "[Absorb Illusion] Arg1 HP kaybet ve Arg2 Kara Mühür elde et"
  },
  Event_38707_ChoiceDesc3 = {Text = "[Leave]"},
  Event_38707_Desc = {
    Text = "Bulanık yüzler aniden belirir; seni sarar ve var olmayan ses telleriyle umutsuzca inlerler."
  },
  Event_38707_Name = {Text = "İllüzyon"},
  Event_38715_ChoiceDesc1 = {
    Text = "[Propose Decree] \"(RelicConfig.Arg1)\" ve \"(RelicConfig.Arg2)\" adlı Gümüş Kalıntılar’ı elde et"
  },
  Event_38715_ChoiceDesc2 = {
    Text = "[Propose Decree] [(RelicConfig.Arg1)] adlı Lanetli Kalıntı’yı elde et"
  },
  Event_38715_ChoiceDesc3 = {
    Text = "[Propose Decree] [(RelicConfig.Arg1)] adlı Altın Kalıntı’yı elde et"
  },
  Event_38715_Desc = {
    Text = "\n \"Paramı aldıysan, bana hizmet etmek zorundasın.\"\nKraliçe çenesini eline dayamış, seni umursamaz bir tavırla süzüyordu.\nKabul etse de etmese de, buna gerçekten merak duyduğu açıktı.\n \"Şimdi söyle bakalım, büyük reformcu, planın nedir?\""
  },
  Event_38715_Name = {Text = "Vekil Kodu"},
  Event_40452_ChoiceDesc1 = {
    Text = "[Kimliği Sor] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: [(EnchantConfig.Arg1)]"
  },
  Event_40452_ChoiceDesc2 = {
    Text = "[Leave] Rastgele 3 Komut Kartına \"(EnchantConfig.Arg1)\" Yakarışını kazı, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_40452_Desc = {
    Text = "Üç hayalet yolu kesti.\nKumar masasını çevrelediler, gözleri zarların üzerindeydi.\n“Gulp, gulp.”\nZarlar sayısız kez atıldı ve düştü.\nBu, sonu olmayan bir kumardır."
  },
  Event_40452_Name = {
    Text = "Sonsuz Kumar"
  },
  Event_40453_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40453_Desc = {
    Text = "\n \"Merhaba, biz Wanda’nın birinci, ikinci ve üçüncü kocalarıyız.\"\n \"Ne? Dördüncü kocanın nerede olduğunu mu soruyorsunuz?\nŞey... dürüst olmak gerekirse, John’un mizah anlayışı yoktu, bu yüzden hanımefendi onu bir Kör Gözlü Hizmetkâr’a dönüştürdü.\"\n \"Onu kaybettiğimize hepimiz üzülüyoruz. Elbette, sadece biraz.\""
  },
  Event_40453_Name = {
    Text = "Sonsuz Kumar"
  },
  Event_40454_ChoiceDesc1 = {
    Text = "[Shake Hands] Rastgele bir Uyandırıcıyı Uyanışa geçir, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_40454_ChoiceDesc2 = {
    Text = "[Leave] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_40454_Desc = {
    Text = "Bir kafesin yanından geçerlerken, içerden bir el uzandı.\n“Beni bırakma, Rebecca...”\nSesi yaşlı ve solgundu, yıpranmış körükler gibi."
  },
  Event_40454_Name = {Text = "Tutsak"},
  Event_40455_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40455_Desc = {
    Text = "Avucun yapış yapış—bu D-balçık.\nSesin sahibi kaybolmuştur, gölgeli köşelere gizlenmiştir."
  },
  Event_40455_Name = {Text = "Tutsak"},
  Event_40456_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40456_Desc = {
    Text = "Umursamadan oradan ayrıldın, mektubun arkasındaki dramatik hikâyeyi kaçırdın.\nAma bunun ne önemi var?\nUçsuz bucaksız okyanuslar, şafaklar ve alacakaranlıklar, ekvator çölleri...\nDaha fazlasıyla karşılaşacak, daha fazlasını kaçıracaksın."
  },
  Event_40456_Name = {
    Text = "Sevgili Hanımefendiye"
  },
  Event_40457_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40457_Desc = {
    Text = "Bir bakıma, bu Tutsak’tan farkın yok.\nŞimdi alarmı yükseltme zamanı değil.\nTutsak’ın yalvarışlarını görmezden gelip uzaklaşıyorsun."
  },
  Event_40457_Name = {Text = "Tutsak"},
  Event_40458_ChoiceDesc1 = {
    Text = "[Tear Letter] Bir Kalıntıyı Lanetli Kalıntı [(RelicConfig.Arg1)]ya dönüştür."
  },
  Event_40458_ChoiceDesc2 = {
    Text = "[Ignore the Letter] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_40458_ChoiceDesc3 = {
    Text = "[Reply] 25 Kara Mühür al"
  },
  Event_40458_Desc = {
    Text = "I. John Cambrian'dan Wanda'ya Mektup (B.F. @2)\n\nBir kocanın karısını tasarruf etme hakkı vardır, en azından Cambrian'da.\nAma senin deliliğini açıkça hafife almışım. Şimdi neredeyse körüm ve uzuvlarım kesilmek üzere.\nŞerrin kızı... Hayır, sen bizzat şerrin kendisisin.\nSeni lanetliyorum @1, seni lanetliyorum @2, seni lanetliyorum, seni lanetliyorum..."
  },
  Event_40458_Name = {
    Text = "Sevgili Hanımefendiye"
  },
  Event_40459_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40459_Desc = {
    Text = "Laneti bozmak için en basit yöntemi kullandın.\nHiçbir şey olmadı. Kâğıt cansızca yere süzüldü.\nOmuz silkip uzaklaştın, ama içini kemiren bir terslik duygusundan kurtulamadın."
  },
  Event_40459_Name = {
    Text = "Sevgili Hanımefendiye"
  },
  Event_40460_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40460_Desc = {
    Text = "Kumar masasının yanından, ikinci bir düşünce bile olmadan geçip gidersin.\nArkanı dönerken, hayaletler hep bir ağızdan konuşur:\n“Ortak eski karımız Bayan Wanda’ya selamlarımızı iletin.”"
  },
  Event_40460_Name = {
    Text = "Sonsuz Kumar"
  },
  Event_40461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40461_Desc = {
    Text = "Cevabını mektubun sonuna itinayla yazıyorsun:\n“Lanet alındı. Sana her şeyin en iyisini diliyorum.”\nSon çizgi düşerken, kâğıt üzerinde öfkeli mavi alevler tutuşuyor.\nKülü topluyorsun."
  },
  Event_40461_Name = {
    Text = "Sevgili Hanımefendiye"
  },
  Event_44187_ChoiceDesc1 = {
    Text = "[Face the Darkness] [ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc2 = {
    Text = "[Face the Darkness] [ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc3 = {
    Text = "[Flee the Darkness] Rastgele bir Altın Kalıntı Edin"
  },
  Event_44187_Desc = {
    Text = "Önündeki ruh karanlık ve lekeli—içinde ışık ve Karanlık bir arada var. Üstünlük için çarpışıyorlar, ruhu Şaşkınlık içinde bırakıyorlar.\n\"Onlara acıyorum, her şeyini yitirmiş o zavallı ruhlara, ama dünya böyle işlemiyor mu zaten?\n\"Birinin kazanması için, bir başkasının kaybetmesi gerekir.\n\"Başkalarının sevinci uğruna kendi mutluluğumu Kurban mı etmeliyim?\""
  },
  Event_44187_Name = {
    Text = "İçindeki Karanlık"
  },
  Event_44188_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44188_Desc = {
    Text = "Bu benim günahım, benim yüküm. Çelişkilerle dolu ruhum, seni nasıl kurtarabilirim?"
  },
  Event_44188_Name = {
    Text = "İçindeki Karanlık"
  },
  Event_44299_ChoiceDesc1 = {
    Text = "[Plea to the Bishop] Bir Günahkâr Kalıntı’yı Arındırma. Eğer hiç yoksa, rastgele bir Altın Kalıntı elde et."
  },
  Event_44299_Desc = {
    Text = "\"İstediğim hayatı elde etmek için aldattım ve manipüle ettim—para, sıradan sayılara dönüştü; nefis yemekler günlük öğünlerim oldu; iş dünyasında son sözü ben söyledim ve politikada güçlü bir nüfuz kullandım. Ama neden, neden o insanları, her şeylerini aldığım o insanları unutamıyorum? Neden yüzlerindeki o umutsuzluğu unutamıyorum?\n\" Alkol yalnızca kısa bir Kaçış sunuyor; ruhum kendi kendini parçalıyor ve Pain neredeyse beni boğuyor.\n \"Ne yapmalıyım?\""
  },
  Event_44299_Name = {
    Text = "Suçluluk ve Bağışlama"
  },
  Event_44301_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44301_Desc = {
    Text = "\"Acıların yolunda yürüyorsun, Yaratıcı Tanrı'nın görkeminden saparak.\n\"Dön, kayıp kuzu. Yaratıcı Tanrı'nın öğretilerine kulak ver ve doğru yolu bul.\""
  },
  Event_44301_Name = {
    Text = "Suçluluk ve Bağışlama"
  },
  Event_44395_ChoiceDesc1 = {
    Text = "[Want for the Worldly] Arg1 Kara Mühür al. Eğer sende varsa, Piskopos bir Semptom alır."
  },
  Event_44395_ChoiceDesc2 = {
    Text = "[Want for Blood] Piskopos 2 Semptom alır. [(EnchantConfig.Arg1)] adlı Yakarış’ı oyarak işle."
  },
  Event_44395_ChoiceDesc3 = {
    Text = "[Want for More] 4 veya daha fazla Semptomun varsa, Piskopos daha fazlasını alabilir."
  },
  Event_44395_Desc = {
    Text = "\nİllüzyonvari ruh, silik bir siluet hâlinde şekillendi; kırık bedenini ve kararmış kalbinin Kalıntı Nüsha’sını sergilemek için piskoposun önünde diz çöktü.\n“Bana rehberlik, bağışlanma ve kurtuluş sundunuz; fakat merhametli piskopos, bu asla yeterli değil.\n“Yoksulum ve Veba ile lanetlenmişim. Hayatım pamuk ipliğine bağlı ve siz benim tek kurtuluşumsunuz. Lütfen beni kurtarın, piskopos, artık acı çekmeyeyim.”"
  },
  Event_44395_Name = {
    Text = "The Bishop's \"Blessing\""
  },
  Event_44396_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_44396_Desc = {
    Text = "Piskopos yüzüğünü ve broşunu çıkardı. Yaratıcı Tanrı’yı simgeleyen mavi taşlar, tek tek ruhun ellerine bırakıldı. Piskopos eğildi, zavallı ruhun ellerini kavradı.\n \"Altınımı ve gümüşümü al, tüm mal varlığımı al—eğer ihtiyacın olan buysa. Yaratıcı Tanrı’nın öğretileri, yaşamam için bana yeter.\""
  },
  Event_44396_Name = {
    Text = "The Bishop's \"Blessing\""
  },
  Event_44400_ChoiceDesc1 = {
    Text = "[Indulge] Rastgele bir Uyandırıcı’yı Uyanış’a geçir, ancak [(Skill.Arg1)] Semptomu’nu geliştir."
  },
  Event_44400_ChoiceDesc2 = {Text = "[Give Up]"},
  Event_44400_Desc = {
    Text = "Kayıp ruh karanlığı terk etmeyi reddediyor.\nOnu neyin beklediğini biliyorsun. Saçma bir hayat az sonra başlayacak ve tek seyircisi sensin."
  },
  Event_44400_Name = {
    Text = "İçindeki Karanlık"
  },
  Event_44401_ChoiceDesc1 = {
    Text = "[Quick Reflexes] Arg1 Kara Mühür al"
  },
  Event_44401_ChoiceDesc2 = {
    Text = "[Seize Freely] 3 Gelişmiş Yakarış arasından 1 tanesini oyarak işle, ancak [(Skill.Arg1)] Semptomu’nu geliştir."
  },
  Event_44401_Desc = {
    Text = "Alan’da bulunan siyah bir işaret, Yadigârlar ya da diğer ruhsal yansıtımlar için D-Mark’a kurban edilebilir. Mevcut bölgeden ayrıldıktan kısa süre sonra siyah bir çamura çözünerek yok olacaktır."
  },
  Event_44401_Name = {
    Text = "Kara Mühür"
  },
  Event_44407_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Rastgele bir Semptom geliştir."
  },
  Event_44407_ChoiceDesc2 = {
    Text = "[Embrace Delusion] Arg1 Kara Mühür al, ancak rastgele 2 Semptom geliştir."
  },
  Event_44407_ChoiceDesc3 = {Text = "[Leave]"},
  Event_44407_Desc = {
    Text = "Bulanık yüzler aniden belirir; seni sarar ve var olmayan ses telleriyle umutsuzca inlerler."
  },
  Event_44407_Name = {Text = "İllüzyon"},
  Event_44445_ChoiceDesc1 = {
    Text = "[Leave] Projektör Ara"
  },
  Event_44445_ChoiceDesc2 = {
    Text = "[Break into Mist] Arg2 HP kaybet"
  },
  Event_44445_ChoiceDesc3 = {
    Text = "[Discard Extraneous Items] 5 Kara Mühür kaybet ve desteye 1 [Kavrayış] ekle."
  },
  Event_44445_Desc = {
    Text = "İleride yoğun, siyah bir sis uzanıyor; düşüncesizce içine dalmak felaket getirir.\nBelki de sisi dağıtmak için bir \"Projektör\" bulmalısın."
  },
  Event_44445_Name = {Text = "???"},
  Event_44469_ChoiceDesc1 = {
    Text = "[Want for Caro] Piskopos 4 Semptom alır. 3 Altın Kalıntı+ arasından 1 tane elde et."
  },
  Event_44469_ChoiceDesc2 = {
    Text = "[Want for Sanctity] Piskopos 6 Semptom alır. 3 Krono Sarkaç arasından 1 tane elde et."
  },
  Event_44469_ChoiceDesc3 = {Text = "[Return]"},
  Event_44469_Desc = {
    Text = "\nİllüzyonvari ruh, silik bir siluet hâlinde şekillendi; kırık bedenini ve kararmış kalbinin Kalıntı Nüsha’sını sergilemek için piskoposun önünde diz çöktü.\n“Bana rehberlik, bağışlanma ve kurtuluş sundunuz; fakat merhametli piskopos, bu asla yeterli değil.\n“Yoksulum ve Veba ile lanetlenmişim. Hayatım pamuk ipliğine bağlı ve siz benim tek kurtuluşumsunuz. Lütfen beni kurtarın, piskopos, artık acı çekmeyeyim.”"
  },
  Event_44469_Name = {
    Text = "The Bishop's \"Blessing\""
  },
  Event_44474_ChoiceDesc1 = {
    Text = "[Plea] Piskoposun Lütfunu Al"
  },
  Event_44474_ChoiceDesc2 = {
    Text = "[Plea] Piskoposun Lütfunu Al"
  },
  Event_44474_ChoiceDesc3 = {Text = "[Leave]"},
  Event_44474_Desc = {
    Text = "Bu benim günahım, benim yüküm. Çelişkilerle dolu ruhum, seni nasıl kurtarabilirim?"
  },
  Event_44474_Name = {
    Text = "İçindeki Karanlık"
  },
  Event_44911_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44911_Desc = {
    Text = "\n \"Hepsi, hepsi... Evet, hepsini istiyorum...!\"\nRuh elini uzattı, boş havayı nafile kavradı.\nBir şey kazandı ama her şeyi yitirdi."
  },
  Event_44911_Name = {
    Text = "Ne Kazandın?"
  },
  Event_44913_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44913_Desc = {
    Text = "\"Yalnızca en önemli olanı... en hayati olanı...\"\nRuh çömeldi, Düş toprağından ışıldayan bir Dilek kazıp çıkardı ve avuçlarının içinde Beşik gibi salladı."
  },
  Event_44913_Name = {
    Text = "Ne Kazandın?"
  },
  Event_44916_ChoiceDesc1 = {
    Text = "[Hepsini Yakala] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: [(EnchantConfig.Arg1)]"
  },
  Event_44916_ChoiceDesc2 = {
    Text = "[Learn to Let Go] Rastgele 3 Komut Kartına \"(EnchantConfig.Arg1)\" Yakarışını kazı, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_44916_Desc = {
    Text = "Solgun ruh azap içinde.\nTüm olası seçimler ve sonuçları arasında şaşkınlıkla dolaşıyor.\n“Ne seçmeliyim?” diye fısıldıyor, “Ne yapmalıyım?”\n“Nasıl hepsine birden sahip olabilirim?”"
  },
  Event_44916_Name = {
    Text = "Ne Kazandın?"
  },
  Event_44919_ChoiceDesc1 = {
    Text = "[Self-Reflection] Rastgele bir Uyandırıcıyı Uyanışa geçir, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_44919_ChoiceDesc2 = {
    Text = "[Look Around] 3 Yakarıştan 1’ini Oyarak Yaz"
  },
  Event_44919_Desc = {
    Text = "Yüzen ruh bir ikileme yakalanmış.\nDurur, arzular arasında bocalar.\n“Ne seçmeliyim?” diye fısıldar usulca, “Ne yapmalıyım?”\n“Hangisi benim gerçek arzum?”"
  },
  Event_44919_Name = {
    Text = "Arzun Nedir?"
  },
  Event_44920_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44920_Desc = {
    Text = "\n\"Sen haklısın, görmem gerek, görmem gerek...\"\nBaşını eğer, ellerini göğüs boşluğuna daldırır, oradan hayaletimsi bir kalp çıkarır: bir yarısı mürekkep kadar siyah, diğer yarısı yıldız kadar parlaktır."
  },
  Event_44920_Name = {
    Text = "Arzun Nedir?"
  },
  Event_44921_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44921_Desc = {
    Text = "\n\"Evet, evet... İnsanlar başkalarının bir yansıma olabileceğini söyler... Görmem gerek...\"\nYüzsüz çehresiyle sana daha da yaklaştı.\n\"Neden huzursuz değilsin? Ne kadar kıskanıyorum, ne kadar kıskanıyorum...\""
  },
  Event_44921_Name = {
    Text = "Arzun Nedir?"
  },
  Event_44998_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44998_Desc = {
    Text = "\"Derler ki, şu anki acı geçicidir ve ölümden sonra Yaratıcı Tanrı'nın kollarında sonsuza dek sevinç duyacağız.\n\"Ben ölümden sonrasını beklemek istemiyorum.\"\nGölgeler açgözlülükle her şeyi yutar; ruhlar solar, neredeyse çevredeki karanlıkla bir olur.\nHarekete geçmek istersin, ama kendini güçsüz hissedersin."
  },
  Event_44998_Name = {
    Text = "İçindeki Karanlık"
  },
  Event_45000_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_45000_Desc = {
    Text = "Piskopos keskin bir bıçakla avucunu yardı ve tablete damlayan kan, iyileştirici mavi bir ışığa dönüşerek ruhun eksik kanını tamamladı.\n \"Kanımı al, hayatını doldur—eğer ihtiyacın olan buysa. Ulu Baba’nın bana yapmamı buyurduğu şey budur.\""
  },
  Event_45000_Name = {
    Text = "The Bishop's \"Blessing\""
  },
  Event_45001_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_45001_Desc = {
    Text = "Piskopos ruhunu göğsünün derinliklerinden çekip çıkardı. Yumuşak ışık tabletle birleşerek, ruhun her çatlağını dolduran iyileştirici mavi bir parıltıya dönüştü.\n \"Bunu kabul et; bu Yaratıcı Tanrı’dan bir armağan, O’nun sevgisinin bir nişanıdır. Bedenin sağlıklı, ruhun bütün olsun ve tüm acılardan azade kal.\""
  },
  Event_45001_Name = {
    Text = "The Bishop's \"Blessing\""
  },
  Event_45002_ChoiceDesc1 = {Text = "[Leave]"},
  Event_45002_Desc = {
    Text = "O yüzlere doğru yürürsün ve gözlerini yeniden açtığında, her şey karanlığa gömülmüştür. Yalnızca kökeni bilinmeyen bir kahkahanın yankıları seni çevreler."
  },
  Event_45002_Name = {Text = "İllüzyon"},
  Event_45036_ChoiceDesc1 = {
    Text = "[Delete All Relics]"
  },
  Event_45036_Desc = {
    Text = "Bu benim günahım, benim yüküm. Çelişkilerle dolu ruhum, seni nasıl kurtarabilirim?"
  },
  Event_45036_Name = {
    Text = "İçindeki Karanlık"
  },
  Event_45196_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_45196_Desc = {
    Text = "Piskopos, keskin bir bıçakla kemik ve eti oyup çıkardı. Solgun kemikler ve kızıl et, tabletle birleşerek çatlamış ruhu onaran, iyileştirici mavi bir ışığa dönüştü.\n \"Eksik bedenini tamamlamak için kemiklerimi ve etimi al—eğer buna ihtiyacın varsa. Yaratıcı Tanrı benden bunu istiyor.\""
  },
  Event_45196_Name = {
    Text = "The Bishop's \"Blessing\""
  },
  Event_46144_ChoiceDesc1 = {
    Text = "[Leave] Üç Gümüş Kalıntıdan birini elde et, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_46144_Desc = {
    Text = "Silik siluet yavaş yavaş netleşir; ne bir Serseri'dir ne de bir Felaket belirtisi, kanatsız, normal görünen bir Clementine'dir.\n“Ne tesadüf, sen de ay ışığının tadını çıkarmaya mı geldin?” diye gülümseyerek sorar; başından bir baş dönmesi dalgası geçer. “Sisli gecelerde dikkatli olmalısın.\nBuradaki ufaklıklar pek uslu görünmüyor.”"
  },
  Event_46144_Name = {
    Text = "Sisin İçindeki Silüet"
  },
  Event_46145_ChoiceDesc1 = {
    Text = "[Leave] 3 Altın Kalıntıdan 1’ini edin, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_46145_Desc = {
    Text = "Sakin ve soğukkanlı kaldın. Bir Aristokrat Kadın aniden sahneye fırladı.\nÇocuğun ağzını çılgınca açıp zorla bir çubuk tıkıştırdı.\n\"Konuş, benimle konuş.\"\nÇocuğun ağzından kara kan aktı. O ise mırıldanmaya devam etti.\n\"Annem için bir şarkı...\""
  },
  Event_46145_Name = {
    Text = "Son Perde III"
  },
  Event_47309_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47309_Desc = {
    Text = "O gün, tanrılar Filistin’i kudretli ve güçlü kılıçlarıyla cezalandıracak,\nçünkü işledikleri \"katliam\" yüzünden.\nNe? Bunun adil olmadığını mı söylüyorsun?\nHayır, bu avcının yazgısıdır."
  },
  Event_47309_Name = {
    Text = "Denizcilerin Şarkısı"
  },
  Event_47310_ChoiceDesc1 = {
    Text = "[Keep Listening] Lanetli Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_47310_ChoiceDesc2 = {
    Text = "[Ayrıl] Rastgele 1 Komut Kartı Mühür kazanır: [(EnchantConfig.Arg1)]"
  },
  Event_47310_Desc = {
    Text = "Tanrı dedi ki: Adı Filistin olsun.\nOnu katliam göreviyle yükle, onu açgözlülükle lanetle.\nYolu parlasın ki başkaları uçurumu ak saç gibi görsün.\nUçsuz bucaksız okyanusta, ondan büyük köpekbalığı olmasın.\nTüm yaratıklar ondan korksun ve ona tapınsın,\nYargı günü gelene dek."
  },
  Event_47310_Name = {
    Text = "Denizcilerin Şarkısı"
  },
  Event_47311_ChoiceDesc1 = {
    Text = "[Leave] [(Skill.Arg1)] Semptomunu Geliştir"
  },
  Event_47311_ChoiceDesc2 = {
    Text = "[Leave] [(Skill.Arg1)] Semptomunu Geliştir"
  },
  Event_47311_ChoiceDesc3 = {
    Text = "[Leave] [(Skill.Arg1)] Semptomunu Geliştir"
  },
  Event_47311_Desc = {
    Text = "Çocuk, aşağılık bir köleydi.\nEfendisi ona öz evladı gibi davranmış, ama yatakta bıçaklanarak öldürülmüştü.\n \"Seni seviyorum, baba. Sadece artık köle olmak istemiyorum.\"\nSonra çocuk, \"babasının\" mezarı önünde durdu ve rahibin sözlerini hatırladı:\n<Small:Seni besleyip büyüten topraklardan ayrılma.\nVakti geldiğinde ellerin kana bulanacak ve onursuzca öleceksin.\nYaban köpekleri, akbabalar ve deniz balıkları senden tiksinecek.>\nIglenn adındaki çocuk yine de ayrıldı.\nKendi kötü şöhretli hikâyesini kendisi yazacaktı."
  },
  Event_47311_Name = {
    Text = "Boy in the Barrel"
  },
  Event_47312_ChoiceDesc1 = {
    Text = "[Turn Page Forward] [(RelicConfig.Arg1)] Gümüş Kalıntı’yı elde et, ancak 3 Semptomdan 1’ini geliştir."
  },
  Event_47312_ChoiceDesc2 = {
    Text = "[Turn Page Backward] 3 Komut Kartından 1’ine \"(EnchantConfig.Arg1)\" Yakarışını kazı, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_47312_ChoiceDesc3 = {
    Text = "[Discard] 25 Kara Mühür al"
  },
  Event_47312_Desc = {
    Text = "Papirüsle ciltlenmiş bir kitap buluyorsun:\n..\nBir oğlan bir fıçının içine saklanır, sürüklenerek bir Filistin adasına varır.\nZayıf, aşağılık ve hırslıdır.\nÖlümsüz devin görkemi Herkes’i hayranlığa boğduğunda,\nOğlan gölgede kalır, o ışığı kendinden uzak tutar.\nSonraları Golyat ona önemli bir görev emanet eder.\nSebebine gelince—"
  },
  Event_47312_Name = {
    Text = "Boy in the Barrel"
  },
  Event_47313_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47313_Desc = {
    Text = "Dev ardından şöyle dedi:\n\"Onu yanımda tutarım, çünkü hem melankolik hem gülünçtür.\nVe beni asla öldüremez.\""
  },
  Event_47313_Name = {
    Text = "Boy in the Barrel"
  },
  Event_47314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47314_Desc = {
    Text = "\nSon kısmını duymadın, ama sözleri sana başka bir şarkıyı hatırlattı:\n\"Bu nadir dev köpekbalığı, fırtına ve yağmur ortasında,\nOkyanus onun yuvası,\nGüç adalet olduğundan, o kudretin devi,\nSonsuz okyanusun kralı.\""
  },
  Event_47314_Name = {
    Text = "Denizcilerin Şarkısı"
  },
  Event_47315_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47315_Desc = {
    Text = "Şimdi okumak için iyi bir zaman değil.\nKitabı hızla bir kenara fırlatır, son satırları kaçırırsın:\n..\nGölgelere saklanır, kıskançlıktan değil,\nkatıksız korkudan.\nBir kez ışığa çıktığında, o değersiz ruhu tamamen yok olacaktır.\nGeride kül bile kalmayacak."
  },
  Event_47315_Name = {
    Text = "Boy in the Barrel"
  },
  Event_47463_ChoiceDesc1 = {
    Text = "[Enter Hypnosis] Bir Uyanan seç ve Ruh Bölünmesi’ne uğrat; başlangıçtaki dört Komut Kartını kaybeder."
  },
  Event_47463_Desc = {
    Text = "Doktor, devasa kitap yığınından başını kaldırdı:\n“Sen nadir bir örneksin, bu yüzden senden ücret almayacağım.\nAma başka tür bir ödeme istiyorum: hipnoz.\nBu, hiçbir şey saklamayan, bütünüyle çıplak bir bilinci ortaya çıkaran yeni bir terapi yöntemi.\nEe, ne dersin? Denemek ister misin?”"
  },
  Event_47463_Name = {
    Text = "\"Hypnosis Snake\""
  },
  Event_47464_ChoiceDesc1 = {
    Text = "[Shining Memory] [ExDesc1][ExDesc2]"
  },
  Event_47464_ChoiceDesc2 = {
    Text = "[Faded Memory] Kazınmış tüm Topluluk Yakarışlarının Yakarış niteliğini güçlendir."
  },
  Event_47464_Desc = {
    Text = "Bilinç Denizi'nin kıyısında dolaşıyor.\nDalgaların etekleri ayaklarını yalıyor, saçılmış anıları kıyıya taşıyor.\nBazıları parlak, bazıları soluk, bazılarıysa Londinium'un yağmur mevsiminin kokusunu taşıyor.\nHangi hafızayı almayı seçeceksin? Bilinç Denizi'nin kıyısında dolaşıyor."
  },
  Event_47464_Name = {
    Text = "\"Çekirdek Füzyonu\""
  },
  Event_47465_ChoiceDesc1 = {
    Text = "[Denemeyi Reddet] Rastgele 1 Komut Kartı Mühür kazanır: [(EnchantConfig.Arg1)]"
  },
  Event_47465_ChoiceDesc2 = {
    Text = "[Smash the Solvent] Bir Günahkâr Kalıntıyı Arındırma"
  },
  Event_47465_ChoiceDesc3 = {
    Text = "[Accept Experiment] [(RelicConfig.Arg1)] Edin"
  },
  Event_47465_Desc = {
    Text = "Doktor, zümrüt renkli çözeltiyi heyecanla çalkaladı ve ona şöyle dedi:\n“Bir yudum iç, ve bir berrak rüyaya gireceksin.\nBu, kolektif bilinçdışının psişik tezahürüdür.\nŞimdi, sayısız varlıkla aynı bilinç denizini paylaşacaksın.\nDenemek ister misin?”"
  },
  Event_47465_Name = {
    Text = "\"Berrak Rüya\""
  },
  Event_47466_ChoiceDesc1 = {
    Text = "[Answer Voice] Ruh Bölünmesi Uyandırıcısı'ndan 1 Komut Kartı elde et."
  },
  Event_47466_Desc = {
    Text = "Beden bir kafes, parçalanmış kişilikleri hapseden bir zindan.\n“24” denen hapishane artık tıka basa dolu.\n“Uyuma, huzur bulma.”\nKaranlıkta, yumuşak bir ses fısıldıyor."
  },
  Event_47466_Name = {
    Text = "\"Öz Farkındalık\""
  },
  Event_47848_ChoiceDesc1 = {
    Text = "[Close Your Eyes] 3 Altın Kalıntı arasından 1 tane elde et"
  },
  Event_47848_ChoiceDesc2 = {
    Text = "[Sneak a Peek] 2 Uyandırıcı’yı Uyanış’a geçir. Uyanış kartlarının Arithmetica Maliyeti’ni 1 azalt."
  },
  Event_47848_ChoiceDesc3 = {
    Text = "[Open Your Eyes] \"(RelicConfig.Arg1)\", \"(RelicConfig.Arg2)\" ve \"(RelicConfig.Arg3)\" adlı Gümüş Kalıntılar’ı elde et."
  },
  Event_47848_Desc = {
    Text = "Hipnoza girmeden önce doktor şöyle demişti:\n\"İznim olmadan gözlerini açma.\"\nBu yüzden gözlerini kapalı tuttu, nefes aldı... verdi...\nYarı uykulu haldeyken bir \"tıss\" sesi duymuş gibi oldu.\nSonra soğuk gözlerin bakışını hissetti—\nBir şey onu izliyordu.\nGizlice göz atmalı mıydı?"
  },
  Event_47848_Name = {
    Text = "\"Hypnosis Snake\""
  },
  Event_47876_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47876_Desc = {
    Text = "Parıldayan anıları almak için eğildi.\nBir, iki... sayısız sevinç içeri doldu.\nKollarını açtı ve onların arasında dönmeye başladı."
  },
  Event_47876_Name = {
    Text = "\"Çekirdek Füzyonu\""
  },
  Event_47877_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47877_Desc = {
    Text = "Soluk anıları toplamak için eğildi.\nBir, iki... sayısız küçük an içine doldu,\nKollarını açtı ve hepsini kucakladı."
  },
  Event_47877_Name = {
    Text = "\"Çekirdek Füzyonu\""
  },
  Event_47878_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47878_Desc = {
    Text = "Bu tuhaf çözücülerin kurbanı olmayı reddediyorsun.\nDoktor biraz hayal kırıklığına uğruyor, ama seni zorlamıyor.\n\"İnsanlığın korkaklığını ve dar görüşlülüğünü affediyorum.\""
  },
  Event_47878_Name = {
    Text = "\"Berrak Rüya\""
  },
  Event_47879_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47879_Desc = {
    Text = "Çatırtı! Şişeyi paramparça edersin.\nYeşil çözelti hızla zemini aşındırır.\n“Bu, cehaletin pervasızlığıydı. Ama umarım bir dahası olmaz.\nYoksa, üzüntüden gözyaşı dökebilirim.”"
  },
  Event_47879_Name = {
    Text = "\"Berrak Rüya\""
  },
  Event_47880_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47880_Desc = {
    Text = "Onu tek yudumda içtin.\nGulp, gulp... Beyninde ve boğazında kabarcıklar patladı.\nMinik, çıtırdayan havai fişekler gibi.\n\"Seni övüyorum, cesur insan. Sonsuzluğa dokunma fırsatın olacak.\nVe ben buna tanıklık edeceğim.\""
  },
  Event_47880_Name = {
    Text = "\"Berrak Rüya\""
  },
  Event_47881_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47881_Desc = {
    Text = "Gözlerini açtı ve şöyle dedi:\n \"Evet, her şey yanlış.\nGözyaşları dökülmeli, direnç gösterilmeli.\"\nKaranlığın içinde, paslı bir hışırtı duyuldu; bu, nazik bir karşılığın işaretiydi."
  },
  Event_47881_Name = {
    Text = "\"Öz Farkındalık\""
  },
  Event_47900_ChoiceDesc1 = {
    Text = "[I Saw a Snake] [(RelicConfig.Arg1)] adlı Altın Kalıntı+’yı elde et"
  },
  Event_47900_ChoiceDesc2 = {
    Text = "[I Saw You] [(RelicConfig.Arg1)] adlı Günahkâr Kalıntı’yı elde et"
  },
  Event_47900_Desc = {
    Text = "Şak.\nHafif bir parmak şıklatması onu gerçekliğe geri çekti.\nDoktor, ne zaman olduysa, yüzünü ona yaklaştırmış, kobalt sarısı gözleri heyecanla parlıyordu.\n \"Söyle bana, az önce ne gördün?\""
  },
  Event_47900_Name = {
    Text = "\"Hypnosis Snake\""
  },
  Event_47901_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47901_Desc = {
    Text = "Gözlerini açtı.\nIşık ve gölgenin puslu dansında, karanlıkta kıvrılmış, ağır ağır süzülen sakin, beyaz bir yılan gördüğünü sandı.\nVe gözleri—\nTertemiz, lekesiz altın.\nNe keder, ne sevinç, ne yargı,\nBir fındık faresini bile yaz ortası bir karabasandan uyandırmaya yetecek türden."
  },
  Event_47901_Name = {
    Text = "\"Hypnosis Snake\""
  },
  Event_47909_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47909_Desc = {
    Text = "Sessizce tek gözünü araladı.\nGördüğü şey, karanlıkta yavaşça kıvranan bulanık bir beyaz ışıktı.\nIşığın içinde soluk bir altın parıltı titreşiyor, sanki ona işlediği günahı hatırlatıyordu.\nDaha fazlasına bakmaya cesaret edemedi."
  },
  Event_47909_Name = {
    Text = "\"Hypnosis Snake\""
  },
  Event_47910_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47910_Desc = {
    Text = "Doktorun talimatlarına uydu, gözlerini asla açmadı.\nEtrafında soğuk bir esinti dolaştı, yüzünde oyalanarak geçti.\nBir süre sonra her şey eski hâline döndü.\nSanki hiçbir şey olmamış gibi."
  },
  Event_47910_Name = {
    Text = "\"Hypnosis Snake\""
  },
  Event_47911_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47911_Desc = {
    Text = "\n\"Ben... çok güzel bir yılan gördüm.\"\nDoktor bir an duraksadı, kalemi elinde.\n\"Ne tür bir yılan?\"\n\"Çok güzel! Bembeyaz, üzerinde altın desenler var...\"\nDoktor başka bir şey söylemedi, dudaklarının kenarında belli belirsiz bir gülümseme belirdi.\n\"Teşekkür ederim.\""
  },
  Event_47911_Name = {
    Text = "\"Hypnosis Snake\""
  },
  Event_47912_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47912_Desc = {
    Text = "Doktorun kobalt-sarı gözlerinin içine dümdüz bakar.\n \"Görüyorum ki bir yılana dönüşmüşsün.\"\n \"Öyle mi. Bundan bu kadar emin olmanın sebebi ne?\"\nÇünkü o esrarengiz, kıpırtısız ve karmaşık.\nVe...\nSanki bin yıllık bir kış uykusundan yeni uyanmış gibi yorgun görünüyor."
  },
  Event_47912_Name = {
    Text = "\"Hypnosis Snake\""
  },
  Event_47992_ChoiceDesc1 = {
    Text = "[Connect] Arg2 HP Yenile."
  },
  Event_47992_ChoiceDesc2 = {
    Text = "[Meditate] Bir Uyandırıcıyı Uyanış’a geçir."
  },
  Event_47992_ChoiceDesc3 = {
    Text = "[Expel] En fazla 3 Semptom kartını İmha Et ve Arg2 Kara Mühür elde et."
  },
  Event_47992_Desc = {
    Text = "Sis ağır ağır yapışırken, rozetin solgun bir gümüş titreşimle yanıp sönüyor. İletişimci cızırtıyla hayata dönüyor. Biri arıyor."
  },
  Event_47992_Name = {Text = "Kavşak"},
  Event_47992_Tips3 = {
    Text = "Şu anda hiçbir Semptom göstermiyorsun."
  },
  Event_47993_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47993_ChoiceDesc2 = {
    Text = "[Leave] Rastgele bir Komut Kartını kopyala ve kopyaya [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_47993_Desc = {
    Text = "Okuldan gelen bir iletişim isteğini kabul ettin. Tanıdık Ses zihnini sakinleştiriyor. Kendini toparlayıp ilerliyorsun."
  },
  Event_47993_Name = {Text = "Kavşak"},
  Event_48225_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48225_Desc = {
    Text = "Kedi mutlulukla elinin arkasını yaladı.\n“Teşekkür ederim. Benim için endişelenme, miyav.\nBuradaki kişilikler hep ölür ve yeniden doğar.\nKesinlikle geri geleceğim!\nMiyav miyav, miyav miyav miyav!”"
  },
  Event_48225_Name = {
    Text = "Son Sözler"
  },
  Event_48226_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48226_Desc = {
    Text = "Kedi seni anlamadığını sanıp eline sokuluyor.\n“Eğer kabul edersen, tüm sakladığım atıştırmalıkları sana veririm.\nHepsi Cambre Bölgesi @2’de güvenle saklı...”"
  },
  Event_48226_Name = {
    Text = "Son Sözler"
  },
  Event_48227_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48227_Desc = {
    Text = "George'dan içtenlikle özür diledin.\n\"Hımpf, en azından biraz görgün var.\nGeorge, lanetin gücünü %10 azaltmayı düşünecek,\n%15'e kadar—George'un sınırı bu.\""
  },
  Event_48227_Name = {
    Text = "George'un Hayaleti"
  },
  Event_48228_ChoiceDesc1 = {
    Text = "[Agree] \"(RelicConfig.Arg1)\" Altın Kalıntıyı edin, ancak \"(Skill.Arg2)\" becerisini geliştir"
  },
  Event_48228_ChoiceDesc2 = {
    Text = "[Reject It] 3 Altın Kalıntı arasından 1 tane edin, ancak [(Skill.Arg1)] Semptomunu geliştir"
  },
  Event_48228_ChoiceDesc3 = {
    Text = "[Stay Silent] [(RelicConfig.Arg1)] Gümüş Kalıntıyı edin"
  },
  Event_48228_Desc = {
    Text = "\n“Kedi 24 ağır yaralıdır, güçlükle sana şunları söyler:\n“Miyav... vaktim tükeniyor...\nBir arkadaşım var, gümüş bir morina miyav.\nEğer bir gün onu görürsen, ona çok uzaklara gittiğimi söyle, miyav.\nÇok uzun süre yok olacağım, miyav.\nKızarmış balık olmadan bir sürü patates kızartması getireceğim, miyav.\nOna mutlaka söylemelisin!”"
  },
  Event_48228_Name = {
    Text = "Son Sözler"
  },
  Event_48229_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48229_Desc = {
    Text = "Kedi biraz hayal kırıklığına uğramıştı.\nAma o hep uslu, itaatkâr bir kedicikti, kimseyi asla zorlamazdı.\nSonunda, pişmanlıkla gözlerini kapattı."
  },
  Event_48229_Name = {
    Text = "Son Sözler"
  },
  Event_48230_ChoiceDesc1 = {
    Text = "[Apologize to It] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\"yi geliştir."
  },
  Event_48230_ChoiceDesc2 = {
    Text = "[Taunt It] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_48230_ChoiceDesc3 = {
    Text = "[Disregard It] 25 Kara Mühür al"
  },
  Event_48230_Desc = {
    Text = "Bir hayalet, George'un Hayaleti, üzerinde süzülüyor.\n\"George onursuzca öldü.\nAma önemi yok. George bu aşağılanmayı daima hatırlayacak.\nKoruyucu, başın büyük dertte, he he he...\""
  },
  Event_48230_Name = {
    Text = "George'un Hayaleti"
  },
  Event_48231_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48231_Desc = {
    Text = "\"Hehe, George'la dalga geçmeye nasıl cüret edersin.\nMerak etme, ister yerken, ister uyurken, ister şarkı söylerken...\nGeorge hep etrafında süzülecek, seni hatırlatıp duracak, seni rahatsız edecek.\nBöylece günahlarını sonsuza dek hatırlayacaksın.\nAsla bir hayaleti yakalayamayacaksın, la la la~\""
  },
  Event_48231_Name = {
    Text = "George'un Hayaleti"
  },
  Event_48232_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48232_Desc = {
    Text = "George’un lanetini geride bırakarak ileriye doğru yürüdün.\nArdından hıçkırık sesleri duyuldu; George yüksek sesle ağlıyordu.\n“Vuu... Benim gibi güzel biri nasıl olur da—\nİğrenç! İğrenç!\nGeorge, Pandia’nın kamçısının altında ölmeyi tercih eder!”"
  },
  Event_48232_Name = {
    Text = "George'un Hayaleti"
  },
  Event_49055_ChoiceDesc1 = {
    Text = "[Summon Awakeners] Tüm Uyandıranlar 100 Aliemus kaybeder. Bir Semptom kartını İmha Et."
  },
  Event_49055_ChoiceDesc2 = {
    Text = "[Struggle] Arg1 HP yenile, ancak [(Skill.Arg2)]yi iki kez geliştir."
  },
  Event_49055_ChoiceDesc3 = {
    Text = "[Harness Silver Key] Tüm Keyflare’i kaybet."
  },
  Event_49055_Desc = {
    Text = "Titreşen kan sıçramaları havuzuna adım attığında, gerçek sureti açığa çıkıyor.\nKızıl-siyah kan, sayısız kol uzatarak bileklerine yapışıyor ve seni amansızca akıl almaz uçuruma doğru sürüklüyor."
  },
  Event_49055_Name = {Text = "Kan Gölü"},
  Event_49097_ChoiceDesc1 = {
    Text = "[Move Forward]"
  },
  Event_49097_Desc = {
    Text = "Karnın şiddetle burkuluyor, ama mucizevi biçimde birkaç saniye sonra yatışıyor. Tuhaf bir şekilde, içinde bir kalp atışının daha çarptığını duyuyor gibisin..."
  },
  Event_49097_Name = {
    Text = "Besleyici Ana"
  },
  Event_49098_ChoiceDesc1 = {
    Text = "[Bir Dikişte İç] [ExDesc3][ExDesc4] adet Komut Kartı seç ve Mühür kazan: [(EnchantConfig.Arg1)][ExDesc1][ExDesc2]"
  },
  Event_49098_Desc = {
    Text = "Aşınmış bir tencere, alçak taş duvardaki yarıktan seni izliyor.\nÇölde su, en değerli Envanterdir; alkol ise deliliğe ve Düş’e açılan bir kapı.\nBu çorak diyarda, aklı başında herhangi birinin onun cazibesine karşı koyması zordur."
  },
  Event_49098_Name = {
    Text = "Besleyici Ana"
  },
  Event_49312_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49312_Desc = {
    Text = "Gümüş Anahtar parıldar; kollar, bir güçten ürkmüş gibi havuza çekilir ve ardından yok olur."
  },
  Event_49312_Name = {Text = "Kan Gölü"},
  Event_49313_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49313_Desc = {
    Text = "Umutsuzca çabalarsın, ama daha da derine batarsın; zihninde lanetli fısıltılar tarafından işkenceye uğrarsın.\nKendine geldiğinde, kan kırmızısı dokunaçlar geri çekilmiş, doymuştur. Garip bir şekilde yenilenmiş hissedersin, ama sanki bir şey sonsuza dek yitip gitmiştir..."
  },
  Event_49313_Name = {Text = "Kan Gölü"},
  Event_49314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49314_Desc = {
    Text = "Yeni uyanan Uyandırıcı, tereddüt etmeden seni kan havuzundan çekip çıkarır. Birbirine kenetli kolun yırtılır, çamurlu su sıçrar ve sanki bir şeyleri arzulayıp yiyorlarmış gibi, suda sayısız, zar zor seçilen yaratık kıvranır."
  },
  Event_49314_Name = {Text = "Kan Gölü"},
  Event_49867_ChoiceDesc1 = {
    Text = "Rastgele bir Uyandırıcı 50 Aliemus kazanır."
  },
  Event_49867_Name = {Text = "Etkinlik"},
  Event_49907_ChoiceDesc1 = {
    Text = "[Ask If They're Real]"
  },
  Event_49907_ChoiceDesc2 = {
    Text = "[Request to Touch]"
  },
  Event_49907_Desc = {
    Text = "\"Neden boynuzlarıma hep merakla bakıyorsun? Bir sorun mu var?\"\nThais aniden omzuna doğru eğiliyor, bal rengi boncuklar usulca yanağını okşuyor."
  },
  Event_49907_Name = {
    Text = "Boynuzlu Olan"
  },
  Event_49908_ChoiceDesc1 = {Text = "[Look Up]"},
  Event_49908_ChoiceDesc2 = {
    Text = "[Approach Thais]"
  },
  Event_49908_Desc = {
    Text = "Harabelerde toz savrulur ve kırık bir pencerenin dışında Thais aniden belirir. Tozlu pencere pervazına rahatça yaslanır, gizemli bir şekilde yukarıdaki kirişi işaret eder."
  },
  Event_49908_Name = {
    Text = "Gizlice Doğan"
  },
  Event_49909_ChoiceDesc1 = {
    Text = "[Leave] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_49909_Desc = {
    Text = "Başını kaldırdığında, paslı bakır boruların tepede dev bir örümcek ağı gibi yayıldığını görüyorsun. Bir gölge hızla süzülüyor—yiyecek arayan vahşi bir kedi mi, yoksa gölgelerde pusuda bekleyen bir canavar mı?\nGeri döndüğünde, Thais ortadan kaybolmuş oluyor."
  },
  Event_49909_Name = {
    Text = "Gizlice Doğan"
  },
  Event_49910_ChoiceDesc1 = {
    Text = "[Stare at Her]"
  },
  Event_49910_ChoiceDesc2 = {Text = "[Call Her]"},
  Event_49910_Desc = {
    Text = "O \"Fantazma\"yı yine görürsün.\nBu kez, adını zaten biliyorsundur.\nThais, uzaktaki Ana Ağaç’ın altında durmakta, ona kendini adamışçasına dua etmektedir.\nSilüeti belirsizdir, Ana Ağaç’ın fantazmasıyla iç içe geçmiştir."
  },
  Event_49910_Name = {
    Text = "Dilek Sahibi"
  },
  Event_49911_ChoiceDesc1 = {
    Text = "[Leave] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_49911_Desc = {
    Text = "Thais’in siluetine bakıyorsun; kıyamet fırtınasının ortasında, azametli ve kutsal yalnız bir zirveyi andırıyor, kuduran kum fırtınası bile ihtişamını azaltamıyor.\nAdımları yavaş ama sarsılmaz, duruşu soylu ve dokunulmaz; seni büyülenmiş halde bırakıyor."
  },
  Event_49911_Name = {
    Text = "Ölmeyen Olan"
  },
  Event_49912_ChoiceDesc1 = {
    Text = "[Leave] Bir Komut Kartını Kopyala"
  },
  Event_49912_Desc = {
    Text = "\n“Ne tahmin ediyorsun?”\n“Şşş,” diye fısıldar, sana doğru eğilir. Boynuzunun ucunun yanağını sıyırdığını hissedersin; serin ve karıncalandıran bir his bırakır..."
  },
  Event_49912_Name = {
    Text = "Boynuzlu Olan"
  },
  Event_49913_ChoiceDesc1 = {
    Text = "[Ayrıl] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_49913_Desc = {
    Text = "\"Dokunmak istiyorsan, açıkça söyle. Sana hayır mı derim?\"\nElini tutarken hafifçe kıkırdar; parmak uçlarının sıcaklığı ve pürüzsüzlüğü seni neredeyse transa sokar..."
  },
  Event_49913_Name = {
    Text = "Boynuzlu Olan"
  },
  Event_49914_ChoiceDesc1 = {
    Text = "[Leave] Bir Uyandırıcıyı Uyanışa geçir, o Kartın Arithmetica Maliyetini 1 azalt, ancak [(Skill.Arg1)]yi geliştir."
  },
  Event_49914_Desc = {
    Text = "Diğerleriyle birlikte diz çökersin.\n\"Biliyordum, biliyordum! Kraliçe, Majesteleri bizi her zaman korudu!\"\nSevinç gözyaşları ve uzun çığlıkların sesi, uluyan rüzgârla karışır; kafatasının içinde yankılanıp titreşir.\nBelirsizce, hayati bir düşünce zihninden gelip geçer, ama onu yakalayamazsın."
  },
  Event_49914_Name = {
    Text = "Ölmeyen Olan"
  },
  Event_49915_ChoiceDesc1 = {
    Text = "[Leave] Üç Gümüş Kalıntıdan birini elde et, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_49915_Desc = {
    Text = "Ona el sallarsın.\n\"Ne yapıyorsun?\" Ramona sana şaşkınlıkla bakar.\n\"Şurada...\"\nCümleni bitiremeden, uzaktaki kadın çoktan kaybolmuştur.\nYoksa bir düş müydü?"
  },
  Event_49915_Name = {
    Text = "Suya Eğilen"
  },
  Event_49916_ChoiceDesc1 = {
    Text = "[Respond to Her]"
  },
  Event_49916_ChoiceDesc2 = {Text = "[Hesitate]"},
  Event_49916_Desc = {
    Text = "Uzakta, nehir kıyısında su çeken bir kadın görürsün.\nBakışını hissetmiş gibi dönüp sana el sallar.\nDönüşündeki tuhaflığı fark edersin."
  },
  Event_49916_Name = {
    Text = "Suya Eğilen"
  },
  Event_49917_ChoiceDesc1 = {
    Text = "[Leave] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_49917_Desc = {
    Text = "Sen tereddüt ederken kadın arkasını dönüp vaha’ya atlar ve gözden kaybolur.\nGözlerine inanamazsın... Onun keçi toynakları mı vardı?"
  },
  Event_49917_Name = {
    Text = "Suya Eğilen"
  },
  Event_49918_ChoiceDesc1 = {
    Text = "[Leave] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_49918_Desc = {
    Text = "\"Ey Anne Ağaç, lütfen @1'ın duasını işit. Sütünde yıkanacağım ve yeniden doğacağım, senin elçin olacağım, kumların üzerinde senin adına yürüyeceğim, köklerinin Remouahe'nin her köşesine ulaşmasına izin vereceğim...\"\n\nBirbirini takip eden masum dualar tüm mekânda yankılanır."
  },
  Event_49918_Name = {
    Text = "Dilek Sahibi"
  },
  Event_49919_ChoiceDesc1 = {
    Text = "[Leave] Rastgele bir Uyanışçı’yı uyandır"
  },
  Event_49919_Desc = {
    Text = "Thais’in muğlak ve esrarengiz bakışı dikkatini çeker. Tuhaf ve tekinsiz bir güç seni büyüler; sanki karşı konulmaz biçimde ona doğru çekiliyorsundur.\n\"Gerçekten de, görünmeyen şey yine de var olur.\"\nKulağına yumuşak bir fısıltıyla söyler. Sanki bir şeyi kavramışsındır, ama beyaz tüllerden bir yığının ardında kalmış, hâlâ seçilememektedir.\nBu bir tür kehanet midir? Göz açıp kapayıncaya dek Thais iz bırakmadan kaybolur."
  },
  Event_49919_Name = {
    Text = "Gizlice Doğan"
  },
  Event_49920_ChoiceDesc1 = {Text = "[Gaze]"},
  Event_49920_ChoiceDesc2 = {Text = "[Kneel]"},
  Event_49920_Desc = {
    Text = "Koyunun kara toynakları kumlu toprağa basıyor.\nThais, bilinmeyen bir dua mırıldanıyor ve sayısız Aramlılar, onun yürüdüğü yöne doğru diz çöküyor."
  },
  Event_49920_Name = {
    Text = "Ölmeyen Olan"
  },
  Event_49921_ChoiceDesc1 = {
    Text = "[Leave] 3 Altın Kalıntıdan 1’ini edin, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_49921_Desc = {
    Text = "Dev ağaç, binlerce kalın dalını uzatır; birbirine dolanmış Dokunaçlar gibi Thais’in bileklerini ve ayak bileklerini bağlar, çırpınışlarını umursamadan bedenini zorla ağacın şişkin gövdesinin içine çeker...\n\nUzak bir düş olsa bile, onun acısı dalgalanan su aracılığıyla kalbinde yankı bulur."
  },
  Event_49921_Name = {
    Text = "Dilek Sahibi"
  },
  Event_49922_ChoiceDesc1 = {
    Text = "[Leave] [(RelicConfig.Arg1)] Kalıntısını Edin"
  },
  Event_49922_Desc = {
    Text = "\nGevşek uzuvlar, dallar boyunca ağaç özsuyu gibi akıyor; o var gücüyle çabalıyor, ama bedeni, söz dinlemeyen sendeleyen, bükülmüş bir solucan gibi davranıyor.\n\"Kemikler tamamen çözünmüş,\" hüzünlü bir ifade Thais'in yüzünü süslüyor, \"artık ağacın bir parçası oldu.\"\n\"Bunu tersine çevirecek bir güce ihtiyacımız var... zamanı aşan bir güce.\""
  },
  Event_49922_Name = {
    Text = "Yozlaşmış Olan"
  },
  Event_49923_ChoiceDesc1 = {
    Text = "[Leave] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_49923_Desc = {
    Text = "\"Ve şu ‘Ters Göz Bebeği Olmayan Göz’... ruhtan, en derinden bir şeyleri kımıldatıyor...\"\n \"Ha? Benden mi söz ediyorsun?\"\n \"Medinet, senin Hikâye anlatma yeteneğinden sayıklayıp duruyor.\"\n\nO gece, sessizce yanan kamp ateşinin başında, bardağını yeniden doldurdu."
  },
  Event_49923_Name = {
    Text = "Yozlaşmış Olan"
  },
  Event_49924_ChoiceDesc1 = {
    Text = "[Cut the Tumor]"
  },
  Event_49924_ChoiceDesc2 = {Text = "[Recall]"},
  Event_49924_Desc = {
    Text = "Bir ağaç tümörü.\nKötücül ve şişkin bir ritimle nabız gibi atıyor ve kırılgan, saydam, kan kırmızısı derisinin ardından, sanki kozadan kurtulmak üzereymiş gibi, çarpılmış ve acı dolu bir yüz beliriyor.\n \"Medinite.\" Thais, o yüze hitap ederken adını usulca fısıldadı, yüzünde bir Ağıt ifadesiyle."
  },
  Event_49924_Name = {
    Text = "Yozlaşmış Olan"
  },
  Event_49939_ChoiceDesc1 = {
    Text = "[Trust Ryker] Tüm Uyandırıcıların Aliemus’unu Arg1 kadar artır"
  },
  Event_49939_ChoiceDesc2 = {
    Text = "[Worry About Ryker] 2 Uyandırıcıyı Uyanışa Çağır"
  },
  Event_49939_Desc = {
    Text = "\"Şansıma güveniyorum.\""
  },
  Event_49939_Name = {
    Text = "Şanslı Dedektif"
  },
  Event_49940_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49940_Desc = {
    Text = "Ryker üç şeyde ustadır: keşif, dinleme ve zar atma.\nBaşka bir deyişle, savaşta pek yetenekli değildir.\nKaygın dizginlenemez biçimde büyür ve delilik yayılır."
  },
  Event_49940_Name = {
    Text = "Şanslı Dedektif"
  },
  Event_49941_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49941_Desc = {
    Text = "İnanan bir yürek sihirdir; önündeki tüm engelleri mutlaka aşacaktır."
  },
  Event_49941_Name = {
    Text = "Şanslı Dedektif"
  },
  Event_49943_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49943_Desc = {
    Text = "Kendini mahcup hissedersin ama yine de hasta Ramona’ya umutla bakarsın.\n“Ben hallederim.”\nYanakları kızararak, sonsuz kapasiteli el çantasından yeni bir toplama şişesi çıkarır ve hızla örümceğin üzerine kapatır."
  },
  Event_49943_Name = {
    Text = "Zehir Örümceği"
  },
  Event_49944_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49944_Desc = {
    Text = "Ryker parmak şaklatır, sonra tüylü işaret parmağını ön ayaklarını kaldırmış bir örümceğe doğru uzatır.\nRenkli desenlere sahip bu türler çoğu zaman zehirlidir. Onu uyarmak üzeresindir ki, az önce saldırgan olan örümcek hafifçe parmağının ucuna sıçrayıp kıvrılır.\nEh, kader dediğin de budur."
  },
  Event_49944_Name = {
    Text = "Zehir Örümceği"
  },
  Event_49945_ChoiceDesc1 = {
    Text = "[Look at Ramona] 3 Yakarıştan 1’ini Oyarak Yaz"
  },
  Event_49945_ChoiceDesc2 = {
    Text = "[Look at Ryker] 3 Komut Kartından 1’ine \"(EnchantConfig.Arg1)\" Yakarışını kazı, ancak \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_49945_Desc = {
    Text = "Birden çok bileşik göz sana kilitlenir.\nYaratık geri adım atar, seni sindirmek istercesine dişlerini ve pençelerini gösterir.\nKalkık bacakları ve pedipalpeleriyle, ayrıca bedenini taşıyan iki çift uzvuyla, bunun son derece nadir bir örümceğimsiler türü olduğu açıktır.\nCzort’un veda sözleri zihninde yankılanır: \"Ek görev: yerel tür örnekleri topla ve yerel gözlem istasyonunda depola.\"\nSırt çantandaki, haftalar süren yürüyüşlerden sonra çoktan böceklerle dolup taşan toplama şişesini sallarsın."
  },
  Event_49945_Name = {
    Text = "Zehir Örümceği"
  },
  Event_49946_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49946_Desc = {
    Text = "\"Zamanı umursamayan açgözlülük bir hastalıktır.\""
  },
  Event_49946_Name = {
    Text = "Senin Cevabın"
  },
  Event_49947_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49947_Desc = {
    Text = "\"Metni ezberden okumak sana sevgi kazandırmaz, evlat.\""
  },
  Event_49947_Name = {
    Text = "Senin Cevabın"
  },
  Event_49948_ChoiceDesc1 = {
    Text = "[Golden Key] \"(RelicConfig.Arg1)\" Altın Kalıntıyı edin, ancak \"(Skill.Arg2)\" becerisini geliştir"
  },
  Event_49948_ChoiceDesc2 = {
    Text = "[Iron Key] 3 Altın Kalıntı arasından 1 tane edin, ancak [(Skill.Arg1)] Semptomunu geliştir"
  },
  Event_49948_ChoiceDesc3 = {
    Text = "[Silver Key] [(RelicConfig.Arg1)] Gümüş Kalıntıyı edin"
  },
  Event_49948_Desc = {
    Text = "Öğle vakti, Kutsal Nehir’den yükselen buhar, iki boşluk fantazmasına yoğunlaşır.\nFantazmadan gelen puslu bir ses sana sorar: Düşürdüğün şey bu altın anahtar mı, gümüş anahtar mı, yoksa demir anahtar mı?"
  },
  Event_49948_Name = {
    Text = "Senin Cevabın"
  },
  Event_49949_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49949_Desc = {
    Text = "\"Dürüstlük çoğu zaman daha güvenli sonuçlara götürür, ama aynı zamanda bir şeyleri kaçırmana da neden olabilir.\""
  },
  Event_49949_Name = {
    Text = "Senin Cevabın"
  },
  Event_50013_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50013_Desc = {
    Text = "Kişinin yüzünü seçmeye çalışırsın, ama suyla birlikte dalgalanır, bulanık kalır.\n\nNe kadar çok odaklanırsan, nefesin o kadar düzensizleşir; baş döndürücü bir oksijen yoksunluğu zihnini bulandırır. Ancak Ramona'nın adını seslendiğini duyduğunda güçlükle gerçeğe geri dönersin.\nGüneşin sudaki yansıması göz alıcıdır, ama yüzeyin altında bir şey parıldıyormuş gibi görünür."
  },
  Event_50013_Name = {
    Text = "Ölüm Serabı"
  },
  Event_50014_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50014_Desc = {
    Text = "Fantazma ellerinden bir anda yok olur, geriye yalnızca şakağındaki keskin bir sızı kalır.\nSuda yansıyan güneş göz alıcıdır, ama yüzeyin altında bir şey sanki parıldıyormuş gibi görünür."
  },
  Event_50014_Name = {
    Text = "Ölüm Serabı"
  },
  Event_50015_ChoiceDesc1 = {
    Text = "[Strive to Recognize] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_50015_ChoiceDesc2 = {
    Text = "[Reach out and Touch] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_50015_ChoiceDesc3 = {
    Text = "[Rub Your Eyes] 25 Kara Mühür al"
  },
  Event_50015_Desc = {
    Text = "Nubia seni iter ve bacağının yarısı Kutsal Nehir’e gömülür.\nDengeni bulmak için çabalarsın ama dalgalanan suda beklenmedik bir yansıma görürsün.\nBereket Ana Ağacı üniforması giymiş uzun boylu bir Genç Adam’dır bu; cansız bedeni kutsal nehrin akıntısına gömülmüştür."
  },
  Event_50015_Name = {
    Text = "Ölüm Serabı"
  },
  Event_50016_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50016_Desc = {
    Text = "Panik zihnini kemiriyor, acı bilincini bulandırıyor. Çırpınıp duruyorsun, ama sarmaşıklar daha da sıkılıyor; pis kokulu sümüksü sıvı burun deliklerine sızıyor, her nefesin yapışkan bir umutsuzlukla doluyor.\nRamona darbeyi indirir. Nubya, kopmuş bir ayakla kaçışa geçer. Çamurlu etle kaplı yüzüne yapışmış son Dokunaç’ı koparıp atıyorsun."
  },
  Event_50016_Name = {
    Text = "Yaklaşan Saldırı"
  },
  Event_50017_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50017_Desc = {
    Text = "Gümüş ışık Nubia’nın bedenini deler, etin patlama hissi Gümüş Anahtar boyunca parmak uçlarınıza ve bileğinize kadar yayılır.\nNubia’nın bükülmüş uzuvları göğe doğru yükselir, dehşet verici, acı dolu bir çığlık salarak bütünüyle yapışkan, Bilinmeyen bir sıvıya dönüşür."
  },
  Event_50017_Name = {
    Text = "Yaklaşan Saldırı"
  },
  Event_50018_ChoiceDesc1 = {
    Text = "[Tear] Lanetli Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_50018_ChoiceDesc2 = {
    Text = "[Delme] Rastgele 1 Komut Kartı Mühür kazanır: [(EnchantConfig.Arg1)]"
  },
  Event_50018_Desc = {
    Text = "Nubia'nın asma benzeri uzantıları kıvrılıp dans eder, fırsatı yakalayıp yüzüne şaplak gibi iner, şiddetle ağzına ve burnuna sızar."
  },
  Event_50018_Name = {
    Text = "Yaklaşan Saldırı"
  },
  Event_50019_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50019_Desc = {
    Text = "Suyun yüzeyi dalgalı ışıklarla titreşiyor.\nIslanmış bacaklarını kaldırıp ayakkabılarının içindeki nemli kumu boşaltıyorsun.\nAz önceki görüntü hâlâ zihninde asılı duruyor, silinmeyi reddediyor."
  },
  Event_50019_Name = {
    Text = "Ölüm Serabı"
  },
  Event_50029_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50029_Desc = {
    Text = "“Geri dönecek mi? Yoksa seni bu uçsuz bucaksız çöldе sonsuza dek terk mi edecek?”\n“Seni bulabilecek mi? Yoksa değişen rüzgârlar ve kum tepeleri, onun senin koordinatlarını yitirmesine mi neden olacak?”\n“Başkalarına yüklediğin umut gerçekten güvenilir mi?”"
  },
  Event_50029_Name = {
    Text = "Kayıp Sığlık"
  },
  Event_50030_ChoiceDesc1 = {
    Text = "[Seek Rescue] Rastgele bir Uyandırıcıyı Uyanışa geçir, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_50030_ChoiceDesc2 = {
    Text = "[Move Forward] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_50030_Desc = {
    Text = "Kadim ve uzak bir ses, akan suyun şırıltısına karışarak sana bir soru yöneltir.\n\"Sen, sonsuz kumların ortasında kayboldun.\"\n\"İki seçeneğin var. Yoldaşın senden hızlı; yiyecek ve suyu alıp yardım aramaya gidebilir, sen de geride kalıp tüketimi en aza indirebilirsin.\"\n\"Ya da her şeyi paylaşıp birlikte ilerlemeye devam edebilirsiniz.\""
  },
  Event_50030_Name = {
    Text = "Kayıp Sığlık"
  },
  Event_50031_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50031_Desc = {
    Text = "\"Daha ileri gidemeyebilirsin, ama ruhun ve etin sıkıca birbirine bağlanmış, birbirinden güç alıyor.\"\n\"Bu, senin seçimin.\"\nBu sözler söylenirken, tepede kavuran güneş, yukarıdaki tek gözünü kapatır."
  },
  Event_50031_Name = {
    Text = "Kayıp Sığlık"
  },
  Event_50064_ChoiceDesc1 = {
    Text = "[Cut the Red Ribbon] Bir Komut Kartı’nı İmha Et ve Arg1 Kara Mühür al."
  },
  Event_50064_ChoiceDesc2 = {
    Text = "[Resist] Bir Komut Kartı’nı kopyala, ancak [(Skill.Arg1)] Semptomu’nu geliştir."
  },
  Event_50064_ChoiceDesc3 = {
    Text = "[Call Ramona] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_50064_Desc = {
    Text = "Casiah kırmızı bir ipek kurdele fırlatır; kurdele anında evrak çantanıza dolanır."
  },
  Event_50064_Name = {
    Text = "Entangled Silk"
  },
  Event_50065_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50065_Desc = {
    Text = "Aralıklı, berrak tıkırtılar, başının üzerindeki çapraz borularda yankılanır; sanki bu ölü sessizlikte kollarını güçsüzce sallayan, tek başına dans eden bir hayalet gibidir.\nBu hayal, içinde kadim, Derin Aşınma Korkusu’nu uyandırır."
  },
  Event_50065_Name = {
    Text = "Esrarengiz Dizi"
  },
  Event_50066_ChoiceDesc1 = {
    Text = "[Explore the Cave Entrance] Gümüş Kalıntı [(RelicConfig.Arg1)]yı elde et"
  },
  Event_50066_ChoiceDesc2 = {
    Text = "[Deep into the Cave] Altın Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" becerisini geliştir"
  },
  Event_50066_Desc = {
    Text = "\"Burada bir mağara var.\"\nThais seni davet ediyor.\n \"İçeri girelim mi?\"\nDar mağara, dev bir iblisin kocaman açılmış ağzı gibi karanlık ve derin, sonsuz Karanlık’a doğru uzanıyor. Bu ıssız yere adım atan herkes, omurgasından yükselen tehditkâr hissin pençesinden kurtulamaz. Sanki her köşede, güneş ışığından sakınan kadim yaratıklar pusuya yatmış, istilacıları bekliyordur."
  },
  Event_50066_Name = {
    Text = "Karanlık Mağara"
  },
  Event_50067_ChoiceDesc1 = {
    Text = "[Strike One by One] Rastgele bir Gümüş Kalıntı’yı Yaldızlı Kalıntı [(RelicConfig.Arg1)]ya Yükselt."
  },
  Event_50067_ChoiceDesc2 = {
    Text = "[Surround the Two] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_50067_ChoiceDesc3 = {
    Text = "[Eavesdrop] 25 Kara Mühür al"
  },
  Event_50067_Desc = {
    Text = "İki Aramit muhafız fabrika kapısında nöbet tutuyor.\nOnlardan biri aylak aylak dolanıyor, diğeriyle sohbete dalıyor.\n\"Bazıları Leydi Juliette’in, Fırtına Duvarı’nı aşmaya çalışan ekipleri yine saymakla meşgul olduğunu söylüyor.\"\n\"Umarım seçilenlerden biri olmam.\""
  },
  Event_50067_Name = {
    Text = "Aylak Kapı Bekçisi"
  },
  Event_50067_Tips1 = {
    Text = "Henüz edinilmemiş Gümüş Kalıntı"
  },
  Event_50068_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50068_Desc = {
    Text = "Bakma, dinleme, düşünme.\nO zamansız sesin nereden geldiğini sorgulamadan, doğruca Ana Ağaç Kalıntıları’na yönelirsin."
  },
  Event_50068_Name = {
    Text = "Esrarengiz Dizi"
  },
  Event_50069_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50069_Desc = {
    Text = "Ramona, kılıcını kırmızı ipeği sallayan Casiah'a saplar. Casiah alelacele kaçar, seni saran ipeğin bir anda gevşemesine neden olur."
  },
  Event_50069_Name = {
    Text = "Entangled Silk"
  },
  Event_50070_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50070_Desc = {
    Text = "İki gruba ayrılıyorsunuz. Sen ve Ramona sola, Ryker sağa gidiyor, iki yandan kuşatıyorsunuz.\nİşaret veriyorsun ve Ramona ile Ryker aynı anda saldırıyor. İki Aramlı muhafız sessizce yere düşüyor."
  },
  Event_50070_Name = {
    Text = "Aylak Kapı Bekçisi"
  },
  Event_50071_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50071_Desc = {
    Text = "Tuzaklara dalmanın zamanı değil. Yalnızca mağara girişinde oyalanırken bile, kayanın damarlarında atan o uğursuz nabzı neredeyse hissedebiliyorsun."
  },
  Event_50071_Name = {
    Text = "Karanlık Mağara"
  },
  Event_50072_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50072_Desc = {
    Text = "Senin işaretinle, Ryker sessiz Aram muhafızını bir zarla bayıltır, sonra hâlâ gevezelik eden diğer adama sessizce yaklaşır.\n \"Hey kardeş, ya o Leydi Juliette bir sahtekârsaysa?\"\n \"Ben de bilmiyorum.\"\nRyker keyifle sırıtınca, muhafızın içini bir ürperti kaplar. Tam çığlık atmak üzereyken, Ryker onun ağzını ve burnunu kapatır."
  },
  Event_50072_Name = {
    Text = "Aylak Kapı Bekçisi"
  },
  Event_50073_ChoiceDesc1 = {
    Text = "[Dikkatlice Dinle] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_50073_ChoiceDesc2 = {
    Text = "[Cover Ears] 50 veya daha fazla Aliemus’a sahip her Uyandırıcı için 15 Kara Mühür al."
  },
  Event_50073_ChoiceDesc3 = {
    Text = "[Check] 3 Yakarıştan 1’ini Oyarak Yaz"
  },
  Event_50073_Desc = {
    Text = "Kalıntı bedenin katına girdiğinde, boş ve terk edilmiş Fabrika’da birden melodik bir çan sesi yankılanır. Piyanonun berrak tınısı, paslanmış çelik harabelerle keskin bir tezat oluşturur."
  },
  Event_50073_Name = {
    Text = "Esrarengiz Dizi"
  },
  Event_50074_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50074_Desc = {
    Text = "\"Hey kardeş, ya şu Juliette yalancıysa? Sence ne yapmalıyız?\"\n\"Saçmalama. Juliette geldiğinden beri her şey düzenli ve tertipli. Eğer yalancı olsaydı, Aramlılara bu kadar neden yardım etsin?\"\nOnlar sohbet ederken Ryker sessizce pusu pozisyonuna geçer ve bir pat sesiyle iki zar fırlayıp ikisini birden yere serer."
  },
  Event_50074_Name = {
    Text = "Aylak Kapı Bekçisi"
  },
  Event_50075_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50075_Desc = {
    Text = "Cesaretini toplayıp karşılık verircesine bakışlarını dikersin.\nPerdenin ardındaki devasa göz iğrenç bir sırıtışa bürünür ve metanetli direncin sarsılıp Sur Çöküşü’ne uğrar."
  },
  Event_50075_Name = {
    Text = "Sihirli Göz"
  },
  Event_50076_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50076_Desc = {
    Text = "Sarsılmaz bir odakla perdeyi yırtarsın.\nElinin altında, o dev göz düz, parçalanmış bir kumaş parçasına dönüşür."
  },
  Event_50076_Name = {
    Text = "Sihirli Göz"
  },
  Event_50077_ChoiceDesc1 = {
    Text = "[Stare Back] Altın Kalıntı \"(RelicConfig.Arg1)\"yı elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_50077_ChoiceDesc2 = {
    Text = "[Tear Curtain] 3 Komut Kartından 1'ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_50077_Desc = {
    Text = "Perde, sayısız burulmuş gözü açığa çıkarır.\nArdalarında pusuda bekleyen devasa varlık, üstüne atlamaya can atan şiddetli bir açlık saçar."
  },
  Event_50077_Name = {
    Text = "Sihirli Göz"
  },
  Event_50078_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50078_Desc = {
    Text = "Hareketlerinle rahatsız ettiğin, atılmış, uzamış bir parça olduğu ortaya çıkar; sallanarak demir boruya çarpmaktadır."
  },
  Event_50078_Name = {
    Text = "Esrarengiz Dizi"
  },
  Event_50079_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50079_Desc = {
    Text = "Thais sakince mağaraya adım atar, sen de temkinle peşinden girip etrafı incelersin.\n\"Dikkat et!\" Bir anda geriye çekilir ve yumuşak bir kucaklayışın içine düşersin. Gözlerinin önünde, zifiri karanlık bir dev, mağaradan akıl almaz bir hızla dışarı fırlar.\n\"Şuraya bak,\" dersin hâlâ afallamış haldeyken Thais, karanlıkta hafifçe parlayan gözleriyle, \"Bu onun gizli hazinesi olabilir.\""
  },
  Event_50079_Name = {
    Text = "Karanlık Mağara"
  },
  Event_50080_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50080_Desc = {
    Text = "Çantanın sapına umutsuzca tutunuyor, kırmızı ipeğe karşı çırpınıyorsun.\nAma kırmızı ipek ezici bir güçle üstün geliyor, çantan elinden kayıyor ve eşyalar her yana saçılıyor."
  },
  Event_50080_Name = {
    Text = "Entangled Silk"
  },
  Event_50081_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50081_Desc = {
    Text = "Zapt edilme hissinden nefret ediyorsun.\nKırmızı ipeği kavrayıp yırtıcı bir sesle ikiye ayırıyorsun.\nGeriye kalan parça, kırmızı bir yılan gibi sürünerek uzaklaşıyor."
  },
  Event_50081_Name = {
    Text = "Entangled Silk"
  },
  Event_50276_ChoiceDesc1 = {
    Text = "[Destroy Offering] Lanetli Kalıntı \"(RelicConfig.Arg1)\"yı elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_50276_ChoiceDesc2 = {
    Text = "[İpleri Çöz] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: [(EnchantConfig.Arg1)]"
  },
  Event_50276_ChoiceDesc3 = {
    Text = "[Keep Going] 50 Kara Mühür al"
  },
  Event_50276_Desc = {
    Text = "Üç Aramlı yüksek bir platforma bağlanmıştı.\nBebeklerin teninde gördüğün, koyu, kabuk benzeri desenler, büyüler mırıldanırlarken onların üzerinde belirdi."
  },
  Event_50276_Name = {Text = "Üç Sunu"},
  Event_50277_ChoiceDesc1 = {
    Text = "[Stare] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_50277_ChoiceDesc2 = {
    Text = "[Ignore] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_50277_Desc = {
    Text = "Aramlılar kum fırtınasının içinde diz çöker.\nFırtına bedenlerini kamçılar, kum onların Sadık Kalplerini yutar.\nDönen toz bulutlarının içinde, sayısız dev göz, bükülmüş diyara tepeden bakıyormuş gibi görünür."
  },
  Event_50277_Name = {Text = "Toz Devi"},
  Event_50278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50278_Desc = {
    Text = "Hatırlamak istemediğin sahneler gözlerinin önünde yeniden beliriyor.\nKıvranan dokunaçlar, cam kırıklarının açtığı kesiklerden sızan kan...\nMiden bulanıyor."
  },
  Event_50278_Name = {
    Text = "Yalnız Yolculuk II"
  },
  Event_50279_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50279_Desc = {
    Text = "O burada değil; en tehlikeli kabarışın ortasında değil.\nBu bile zihnini bir nebze olsun yatıştırmalı."
  },
  Event_50279_Name = {
    Text = "Yalnız Yolculuk I"
  },
  Event_50280_ChoiceDesc1 = {
    Text = "[Baskın] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: [(EnchantConfig.Arg1)]"
  },
  Event_50280_ChoiceDesc2 = {
    Text = "[Attack] Rastgele 3 Komut Kartına \"(EnchantConfig.Arg1)\" Yakarışını kazı, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_50280_Desc = {
    Text = "Şiddetli kum fırtınasında bir Nubia çırpınıyor.\nDört toynağı sarı kuma derinlemesine gömülmüş, girdaba kapılmamak için var gücüyle direniyor."
  },
  Event_50280_Name = {
    Text = "Doğanın Kum Fırtınası"
  },
  Event_50281_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50281_Desc = {
    Text = "İçeri dalıyor, Aramlıların haykırışları arasında ipleri kesiyorsun.\nBir Aramlı savaşçı yaklaşıyor; mızrağını kapıp karanlık kalabalığa doğrultuyorsun."
  },
  Event_50281_Name = {Text = "Üç Sunu"},
  Event_50282_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50282_Desc = {
    Text = "Mantık sana onun geri dönmeyeceğini söylüyor.\nEvet, hangi kumarbazdan sözünü tutması beklenir ki?\nElinde yalnızlıktan başka hiçbir şey kalmadı. Sahip olduğun tek şey yalnızlık."
  },
  Event_50282_Name = {
    Text = "Yalnız Yolculuk III"
  },
  Event_50283_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50283_Desc = {
    Text = "Anormal ateş, Ana Ağaç’ın dirilişiyle daha da mı kötüleşecek?\nRamona, Fırtına Duvarı’nın dışında tek başına kendine bakabilir mi?\nŞimdi dikkatin dağılmamalı, ama yine de partnerin için endişelenmeden edemiyorsun."
  },
  Event_50283_Name = {
    Text = "Yalnız Yolculuk I"
  },
  Event_50284_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50284_Desc = {
    Text = "Sen meydan okumayla yüzleşmeyi seçersin, bu sırada Nubya nadir bir tutunacak yer bulmuş gibi başına sıçrayıp yapışır.\nKum fırtınasının ve Nubya’nın çift yönlü kıskacına yakalanırsın.\n\"Tek başına kör cesaret zaferin yolu değildir,\" William’ın soğuk sesi, tıkanmış kulaklarına bir meleğin ilahisi gibi çarpar. \"Fırsatları yakalamayı öğren.\""
  },
  Event_50284_Name = {
    Text = "Doğanın Kum Fırtınası"
  },
  Event_50285_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50285_Desc = {
    Text = "Şu an gazete keyfi yapma zamanı değil."
  },
  Event_50285_Name = {
    Text = "Onun Öğüdü"
  },
  Event_50286_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50286_Desc = {
    Text = "Düşünmüyorsun, hatırlamıyorsun.\nDüşünmek istemiyorsun, hatırlamak istemiyorsun.\nMythag efsanesi sona erecek, ama yolculuğu durmayacak.\nİleri gitmek zorundasın. İleri gitmek zorundasın."
  },
  Event_50286_Name = {
    Text = "Yalnız Yolculuk II"
  },
  Event_50287_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50287_Desc = {
    Text = "\n\"Sevgili Koruyucu:\nUmarım bu mektup sana iyi halde ulaşır.\nBu Remouahe yolculuğunda bedenimi ihmal ettiğim için yanında kalamadığımdan ötürü üzgünüm.\nAma kritik anlarda, lütfen tek yardımcına güven.\nNe zaman bana ihtiyaç duysan, daima oradayım.\"\nZaman darlığı yüzünden daha fazlasını okuyamazsın.\nAma tanıdık el yazısı, içine dingin bir huzur salar."
  },
  Event_50287_Name = {
    Text = "Onun Öğüdü"
  },
  Event_50288_ChoiceDesc1 = {
    Text = "[He'll Be Back] Gümüş Kalıntı [(RelicConfig.Arg1)] elde et"
  },
  Event_50288_ChoiceDesc2 = {
    Text = "[He Won't Come] Altın Kalıntı \"(RelicConfig.Arg1)\" elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_50288_Desc = {
    Text = "Çadırdan en son çıkan kişi Ryker’dı.\nCasiah’ı durdurmak için çadırda kalmayı seçti.\nSana, ayini bozacağına, Bereket Ana Ağacı’nı yakacağına ve yanında kalacağına söz vermişti.\nAma şimdi, hâlâ sana gelmedi.\nSeni yapayalnız bırakarak."
  },
  Event_50288_Name = {
    Text = "Yalnız Yolculuk III"
  },
  Event_50289_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50289_Desc = {
    Text = "Guruldayarak, üç turluk dehşetler ayin alanında yuvarlanır.\nKendini bedeninden kopmuş hissedersin; ayinin hastalıklı vecdi seni tarif edilemez bir Düş’ün içine yutar."
  },
  Event_50289_Name = {Text = "Üç Sunu"},
  Event_50290_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50290_Desc = {
    Text = "Aramlılar’ın inancı öylesine içtendir ki, kumların kendilerini tekrar tekrar gömmesine gönüllüce izin verirler.\nAma başını kaldırdığında, fırtınanın içinde güneş yoktur."
  },
  Event_50290_Name = {Text = "Toz Devi"},
  Event_50291_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50291_Desc = {
    Text = "Kum Denizi, onların adanmışlığına karşılık versin."
  },
  Event_50291_Name = {Text = "Toz Devi"},
  Event_50292_ChoiceDesc1 = {
    Text = "[Break Free from Memories] Rastgele bir kartın Yakarış niteliğini güçlendir."
  },
  Event_50292_ChoiceDesc2 = {
    Text = "[Anıları Yakala] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte et"
  },
  Event_50292_Desc = {
    Text = "İkinci ayrılan kişi William’dı."
  },
  Event_50292_Name = {
    Text = "Yalnız Yolculuk II"
  },
  Event_50293_ChoiceDesc1 = {
    Text = "[Calm] 25 Kara Mühür al"
  },
  Event_50293_ChoiceDesc2 = {
    Text = "[Worry] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ama \"(Skill.Arg2)\" geliştir."
  },
  Event_50293_Desc = {
    Text = "Birden, yola çıktığın günü hatırlarsın.\nRamona sana çantalarını hazırlamanı hatırlatmış, William senin için bir günlük ayarlamış, Ryker ise gizlice çantana bir şişe viski sıkıştırmıştı.\nŞimdi hepsi gitmiş durumda.\n\nİlk ayrılan Ramona olmuştu. Tawil’in gücü, Fırtına Duvarı’nın Otoritesiyle çatıştı ve o, yol boyunca yükselen bir ateşli hastalığa yenik düştü."
  },
  Event_50293_Name = {
    Text = "Yalnız Yolculuk I"
  },
  Event_50294_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50294_Desc = {
    Text = "Nubia’nın ayağına vurur, dengesini bozarsın. Sarmaşık misali uzuvları havada çılgınca savrulur, ardından kum fırtınası tarafından yutulur."
  },
  Event_50294_Name = {
    Text = "Doğanın Kum Fırtınası"
  },
  Event_50295_ChoiceDesc1 = {
    Text = "[Read] Bir Kartı İmha Et"
  },
  Event_50295_ChoiceDesc2 = {
    Text = "[Put Away] \"(RelicConfig.Arg1)\" Kalıntısını elde et, fakat \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_50295_Desc = {
    Text = "Tak-tuk.\nBu dünyevi olmayan, çılgın sunağın altında, ağır davul vuruşları kum fırtınasıyla birlikte yuvarlanır. Bitmek bilmeyen ilahiler arasında, uzaktan bir Daktilo sesi duyarsın—Mythag’dan gelen çağrı, huzursuz kalbini okşar."
  },
  Event_50295_Name = {
    Text = "Onun Öğüdü"
  },
  Event_50296_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50296_Desc = {
    Text = "Ryker’ın olağanüstü bir şansı vardır.\nSana bir şey vaat ederse, mutlaka yerine getirir.\nKesinlikle."
  },
  Event_50296_Name = {
    Text = "Yalnız Yolculuk III"
  },
  Event_50297_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50297_Desc = {
    Text = "Seni ilgilendirmez.\nŞu an yapman gereken, hızla yaklaşmak ve Ana Ağaç Kalıntıları’nı imha etmek."
  },
  Event_50297_Name = {Text = "Üç Sunu"},
  Event_52373_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52373_Desc = {
    Text = "Hayatta kaldın. Sayısız tümsek ve yanmış beden görüyorsun.\nSen de bir şeyleri yakmış gibisin, ama artık önemi yok.\nİlahi Diyar’ın çanlarının çaldığını duyuyorsun."
  },
  Event_52373_Name = {
    Text = "Plague Onslaught"
  },
  Event_52374_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52374_Desc = {
    Text = "Hayatta kaldın. Sayısız tümsek ve yanmış beden görüyorsun.\nKıymet verdiğini korumak için amansızca savaştın, ağır bir bedel ödedin. Ama artık önemi yok.\nİlahi Diyar’ın çanlarının çaldığını duyuyorsun."
  },
  Event_52374_Name = {
    Text = "Plague Onslaught"
  },
  Event_52375_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52375_Desc = {
    Text = "Devin öfkesi geçici olarak dinmişti. Bulutlar dağılmış, sükûnet hüküm sürüyordu. Okyanus, ezelî bir ana gibi, yumuşak gelgitlerle Lemuria’nın sırtını okşuyordu. Lemuria’da geriye yalnızca cesetler ve harabeler kalmıştı.\nSevdiğin şeyleri korumak için umutsuzca savaştın, ağır bir bedel ödedin. Ama artık bunun bir önemi yok.\nOkyanusta, Tanrı Diyarının siluetini bir anlığına gördün."
  },
  Event_52375_Name = {
    Text = "Okyanusun Kükreyişi"
  },
  Event_52376_ChoiceDesc1 = {
    Text = "[Offer Additional Sacrifices] Bir Komut Kartını İmha Et ve 3 tür [Tanrı Diyarı Hayaleti] kartının her birinden 1 adet al."
  },
  Event_52376_Desc = {
    Text = "Yıkılmakta olan Lemuria tahtının önünde durup son ziyaretini sunuyorsun.\nSonsuz Uçurum önünde açılıyor. Gülümseyerek, gözyaşların süzülürken diz çöküyorsun.\n“Bakın, Baba, Deborah. Bakın, yüce Kralım—İlahi Diyar önümde tecelli etti!”"
  },
  Event_52376_Name = {
    Text = "Hail the Divine Realm"
  },
  Event_52377_ChoiceDesc2 = {
    Text = "[Protect What You Cherish] Arg1 HP kaybet ve rastgele bir Semptom geliştir."
  },
  Event_52377_Desc = {
    Text = "Toprak. Sessiz, Metanetli Toprak. İnsanlığın Işığı’nı taşır ve sonsuza dek dayanır. Ama şimdi titriyor, dipsiz yarıklara bölünüyor, üzerinde taşıdığı her şeyi sarsıyor.\nTüm umutlarını Toprak’a bağladın, peki o sarsılmaya başladığında nereye gideceksin?\nKurban, diye sesleniyor Lemuria halkı sana. Sarsıntısız bir İlahi Diyar’ı ortaya çıkarmak için sahip olduğun her şeyi Kurban et."
  },
  Event_52377_Name = {
    Text = "Yer Sarsıntısı"
  },
  Event_52378_ChoiceDesc2 = {
    Text = "[Protect What You Cherish] Arg1 HP kaybet ve rastgele bir Semptom geliştir."
  },
  Event_52378_Desc = {
    Text = "Okyanus. Okyanus Lemuria’nın annesi, hayatın, inancın. Şimdi okyanus, efsanelerdeki öfkeli dev bir tanrı gibi yükseliyor. Kükreyerek yumuşak suları sert kayalara, keskin sivri uçlara dönüştürüyor, önüne çıkan her şeyin üzerine çökertiyor. Ayaklarının dibinde titreşen Lemuria’ya, böcekler gibi sağa sola kaçışan Lemuryalılara soğuk bir bakışla bakıyor. Lemuria ne yaparsa yapsın, onu İmha Etmeye kararlı.\nKurban, diye haykırıyor Lemuria’nın Çocukları. İlahi Diyar’ın huzurla gelebilmesi için her şeyi Kurban edin."
  },
  Event_52378_Name = {
    Text = "Okyanusun Kükreyişi"
  },
  Event_52379_ChoiceDesc2 = {
    Text = "[Protect What You Cherish] Arg1 HP kaybet ve rastgele bir Semptom geliştir."
  },
  Event_52379_Desc = {
    Text = "Veba. Her yerde. Veba, en utanmaz hizmetkâr gibi davranıyor; tanrıların kara ve deniz üzerindeki gazabı dindikten sonra, onların adına tarif edilemez ölümler dağıtıyor. Ölülerin bedenlerini göm, ölülerin bedenlerini yak ve seni korurken ölenler için dua et—onları kendinden olabildiğince uzak tut. Veba karşısında yaşam ve İnsanlığın Işığı un ufak oluyor.\nKurban, diye feryat ediyor Lemuria’nın Vatandaşları. Vebadan azade bir Tanrı Diyarı doğurmak için her şeyi Kurban edin."
  },
  Event_52379_Name = {
    Text = "Plague Onslaught"
  },
  Event_52380_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52380_Desc = {
    Text = "Şiddetli sarsıntı dindi. Sokaklar kızıl kanla lekelendi ve sayısız insan çöken evlerin altında gömüldü.\nKıymet verdiğin şeyi korumak için amansızca savaştın, ağır bir bedel ödedin. Ama artık bunun da önemi yok.\nÖnemli olan tek şey, İlahi Diyar’a bir adım daha yaklaşmış olman."
  },
  Event_52380_Name = {
    Text = "Yer Sarsıntısı"
  },
  Event_52381_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52381_Desc = {
    Text = "Yıkılmakta olan Lemuria tahtının önünde durup son duanı okuyorsun.\nSonsuz uçurum önünde açılıyor. Gülümseyerek, gözyaşların süzülürken diz çöküyorsun.\n \"Bakın, baba, Deborah. Bakın, yüce kralım—İlahi Diyar, önümde tecelli etti!\""
  },
  Event_52381_Name = {
    Text = "Hail the Divine Realm"
  },
  Event_52382_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52382_Desc = {
    Text = "Şiddetli sarsıntı dindi. Sokaklar kızıl kanla lekelendi ve sayısız insan çöken evlerin altında gömüldü.\nEnkazın altında sana ait bir şey de gömülmüş gibi, ama artık önemi yok.\nÖnemli olan tek şey, İlahi Diyar’a bir adım daha yaklaşmış olman."
  },
  Event_52382_Name = {
    Text = "Yer Sarsıntısı"
  },
  Event_52383_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52383_Desc = {
    Text = "Devin öfkesi geçici olarak dindi. Bulutlar dağıldı, dinginlik hüküm sürüyor. Okyanus, ebedî bir anne gibi, yumuşak dalgalarla Lemuria’nın sırtını usulca okşuyor. Lemuria’da geriye yalnızca cesetler ve harabeler kaldı.\nDenizde sana ait bir şeyin yitip gitmiş olduğu hissine kapılıyorsun, ama artık önemi yok.\nOkyanusta, İlahi Diyar’ın siluetini seçebildin."
  },
  Event_52383_Name = {
    Text = "Okyanusun Kükreyişi"
  },
  Event_52384_ChoiceDesc1 = {
    Text = "[Devout Prayer] Destedeki tüm Temel Semptom kartlarını İmha Et. Onların sayısı +2 kadar rastgele [Tanrı Diyarı Hayaleti] kartı al."
  },
  Event_52384_ChoiceDesc2 = {
    Text = "[Devout Prayer] Destedeki tüm Temel Semptom kartlarını İmha Et. Onların sayısı +2 kadar rastgele [Tanrı Diyarı Hayaleti] kartı al."
  },
  Event_52384_Desc = {
    Text = "Toprak artık titremiyor, okyanus artık kükremiyor, veba artık sızmıyor. Felaket, Lemuria’yı yok etti ve geriye yalnızca sen kaldın. Etrafa bakıyorsun; her yerde yıkıntılar görüyorsun. Boş ellerine bakıyorsun.\nAma ne çıkar, onurlu Baş Rahip? Lemuria’nın harabelerine ve cesetlerine bas, sürünerek de olsa ileri git.\nTanrı Diyarına yalnızca Bir Adım Uzakta’sın."
  },
  Event_52384_Name = {
    Text = "Hail the Divine Realm"
  },
  Event_53140_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53140_Desc = {
    Text = "Okuldan gelen bir iletişim isteğini kabul ettin. Tanıdık Ses zihnini sakinleştiriyor. Kendini toparlayıp ilerliyorsun."
  },
  Event_53140_Name = {Text = "Kavşak"},
  Event_53141_ChoiceDesc1 = {
    Text = "[Connect] Arg2 HP Yenile."
  },
  Event_53141_ChoiceDesc2 = {
    Text = "[Meditate] Bir Uyandırıcıyı Uyanış’a geçir."
  },
  Event_53141_ChoiceDesc3 = {
    Text = "[Expel] En fazla 3 Semptom kartını İmha Et ve Arg2 Kara Mühür elde et."
  },
  Event_53141_ChoiceDesc4 = {
    Text = "[Fall into Madness] Rastgele 2 Uyanan’ı uyandır, ancak rastgele bir Semptom geliştir."
  },
  Event_53141_ChoiceDesc5 = {
    Text = "[Hesitation] Others"
  },
  Event_53141_Desc = {
    Text = "Sis ağır ağır yapışırken, rozetin solgun bir gümüş titreşimle yanıp sönüyor. İletişimci cızırtıyla hayata dönüyor. Biri arıyor."
  },
  Event_53141_Name = {Text = "Kavşak"},
  Event_53141_Tips3 = {
    Text = "Şu anda hiçbir Semptom göstermiyorsun."
  },
  Event_53142_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53142_Desc = {
    Text = "Okuldan gelen bir iletişim isteğini kabul ettin. Tanıdık Ses zihnini sakinleştiriyor. Kendini toparlayıp ilerliyorsun."
  },
  Event_53142_Name = {Text = "Kavşak"},
  Event_53143_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53143_Desc = {
    Text = "Okuldan gelen bir iletişim isteğini kabul ettin. Tanıdık Ses zihnini sakinleştiriyor. Kendini toparlayıp ilerliyorsun."
  },
  Event_53143_Name = {Text = "Kavşak"},
  Event_53147_ChoiceDesc1 = {
    Text = "[Expel] En fazla 3 Semptom kartını İmha Et ve Arg2 Kara Mühür elde et."
  },
  Event_53147_ChoiceDesc2 = {
    Text = "[Fall into Madness] Rastgele 2 Uyanan’ı uyandır, ancak rastgele bir Semptom geliştir."
  },
  Event_53147_Desc = {
    Text = "Sis ağır ağır yapışırken, rozetin solgun bir gümüş titreşimle yanıp sönüyor. İletişimci cızırtıyla hayata dönüyor. Biri arıyor."
  },
  Event_53147_Name = {Text = "Kavşak"},
  Event_53147_Tips1 = {
    Text = "Şu anda hiçbir Semptom göstermiyorsun."
  },
  Event_53148_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53148_Desc = {
    Text = "Bağlantıyı kuruyorsun. Hem delirtici hem de baştan çıkarıcı bir ses, aygıttan süzülüyor.\n \"Şunu unutma: bu, İlahi Diyar’ın bir lütfudur.\""
  },
  Event_53148_Name = {Text = "Kavşak"},
  Event_55782_ChoiceDesc1 = {
    Text = "[Cut Through Thorns] Arg1 adet [(Skill.Arg2)] İmgesi bestele. Sonraki Savaşta, düşmanların HP’si %30 artar ve %15 daha fazla Hasar verirler."
  },
  Event_55782_ChoiceDesc2 = {
    Text = "[Cut Through Thorns] Arg1 adet [(Skill.Arg2)] İmgesi bestele. Sonraki Savaşta, düşmanların HP’si %30 artar ve %15 daha fazla Hasar verirler."
  },
  Event_55782_ChoiceDesc3 = {
    Text = "[Part the Thorns] Arg1 adet \"(Skill.Arg2)\" İmgesi bestele, ancak \"(Skill.Arg3)\" Semptomunu geliştir."
  },
  Event_55782_ChoiceDesc4 = {
    Text = "[Part the Thorns] Arg1 adet \"(Skill.Arg2)\" İmgesi bestele, ancak \"(Skill.Arg3)\" Semptomunu geliştir."
  },
  Event_55782_ChoiceDesc5 = {
    Text = "[Leave the Thorns] \"Horla'nın Kalemi ve Mürekkebi\" Arg1 yığın \"Mürekkep\" kazanır."
  },
  Event_55782_Desc = {
    Text = "Bir şey kalbinin tellerine dokundu. Durup bahçenin köşesine baktın. Diken yığınlarının altında, özgürlüğe kavuşmak için çırpınan bir ışık titreşiyor.\nNedir o? Bir kelebek mi? Bir kuş mu? Ona doğru yaklaşıyorsun."
  },
  Event_55782_Name = {
    Text = "Muzus'un Lütfu"
  },
  Event_55782_Tips1 = {
    Text = "Bir sonraki Savaştaki düşmanlar güçlendirildi ve bir daha seçilemez."
  },
  Event_55783_ChoiceDesc1 = {
    Text = "[Create Offering] 3 İmge kartı seç ve Horla’nın senin için bir [Sunu] yaratmasına izin ver."
  },
  Event_55783_ChoiceDesc2 = {Text = "[Leave]"},
  Event_55783_Desc = {
    Text = "Güzel bir seraya geliyorsun ve pencereden içeri bakıyorsun, ama hiçbir şey görmüyorsun.\nBir rüzgâr esiyor, içerdeki taç yaprakları ve yaprakları titretiyor. Çiçeklerin ve yaprakların arasında bir kız silueti seçiyorsun.\n\"Ah! Bahçede bir misafir!\" Kız sana hem şaşkın hem de tedirgin bir ifadeyle bakıyor. \"Üzgünüm, Colette dışarıda... Bu çiçeklerin fiyatlarını bilmiyorum...\"\nKız aniden susuyor, sana yaklaşarak seni dikkatle inceliyor. \"Ah, sevgili misafir, içinde şiirsel imgeler hissediyorum... Belki birlikte bir şiir yaratabiliriz?\""
  },
  Event_55783_Name = {
    Text = "Baharın Armağanı"
  },
  Event_55783_Tips1 = {
    Text = "Yetersiz İmge. En az 3 tane gerekli."
  },
  Event_55799_ChoiceDesc1 = {Text = "[Leave]"},
  Event_55799_Desc = {
    Text = "Canlı dikenler huzursuz görünüyor, ama bu bedeller önemsiz—o ışık kıvılcımında Esin Perisinin çağrısını işitiyorsun."
  },
  Event_55799_Name = {
    Text = "Muzus'un Lütfu"
  },
  Event_55819_ChoiceDesc1 = {
    Text = "[Follow the Body's Memory] Savaşı atla ve anında zafer kazan, ancak Arg1 CP kaybet."
  },
  Event_55819_ChoiceDesc2 = {
    Text = "[Leave] Savaşa Gir"
  },
  Event_55819_Desc = {
    Text = "Aşina olduğun düşmanlarla yüzleşirken, yaklaşan Savaş’ı zaten iyi biliyorsun."
  },
  Event_55819_Name = {
    Text = "Kas Hafızası"
  },
  Event_55997_ChoiceDesc1 = {Text = "[Leave]"},
  Event_55997_Desc = {
    Text = "Topladığın imgelerden birkaçını seçip kıza uzattın.\n\"Ne kadar güzel imgeler! Kıymetli misafir, lütfen bir an bekleyin... İşte. Bu, yalnızca bahara özgü, sadece size ait bir sunu!\"\nElinde, yalnızca senin için açan bir çiçek gibi bir şiir vücut buldu.\nKıza teşekkür etmek istedin, ama başını kaldırdığında, silueti çoktan kaybolmuştu. Issız serada, yalnızca solmuş çiçekler ve yapraklar kalmıştı.\n—Baharın alevinden geriye kalan kül."
  },
  Event_55997_Name = {
    Text = "Baharın Armağanı"
  },
  Event_55999_ChoiceDesc1 = {Text = "[Leave]"},
  Event_55999_Desc = {
    Text = "Kalın dikenler seni tereddüde düşürüyor. Işık noktasından uzaklaşıyorsun, ama o kısa bakış bile yüreğini yeni ilhamla dolduruyor—o noktada esin perisinin çağrısını işitiyorsun."
  },
  Event_55999_Name = {
    Text = "Muzus'un Lütfu"
  },
  Event_56000_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56000_Desc = {
    Text = "Elinle dikenleri iterek açıyorsun, ufak yaralar alıyorsun, ama bedel önemsiz—o ışık noktasında Esin Perisinin çağrısını işitiyorsun."
  },
  Event_56000_Name = {
    Text = "Muzus'un Lütfu"
  },
  Event_56024_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56024_Desc = {
    Text = "Yeterli değil... Işığa doğru yürümeye devam ediyorsun. Dikenler kışkırtılıyor, sivri uçlarını açığa çıkarıyor. Ama hepsi buna değer.\nIşık avucundan dağılırken, parıltılı perdenin ortasında Muzus’un lütfunu açıkça hissediyorsun."
  },
  Event_56024_Name = {
    Text = "Muzus'un Lütfu"
  },
  Event_56025_ChoiceDesc1 = {
    Text = "[Approach Light Points] Bir İmge kartını Yükselt. Sonraki Savaşta, düşmanların HP’si %30 artar ve %15 daha fazla Hasar verirler."
  },
  Event_56025_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56025_Desc = {
    Text = "Aletlerini kullanarak dikenleri biçtin. Canlı dikenler huzursuzlaştı, ama bedel önemsizdi—o parlak noktada Esin Perisinin çağrısını duydun."
  },
  Event_56025_Name = {
    Text = "Muzus'un Lütfu"
  },
  Event_56146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56146_Desc = {
    Text = "Yeterli değil... Işığa biraz daha yaklaşıyorsun. Keskin dikenler elini delici biçimde yarıyor, kanın durmaksızın akmasına neden oluyor. Ama buna değer.\nIşık avucundan dağılırken, parıltılı perdenin ortasında Muzus’un lütfunu açıkça hissediyorsun."
  },
  Event_56146_Name = {
    Text = "Muzus'un Lütfu"
  },
  Event_56147_ChoiceDesc1 = {
    Text = "[Creative Impulse] Tüm Uyananlar tüm Aliemus’larını kaybeder. 3 İmge kartı seç ve Horla’nın senin için bir [Sunu] yaratmasına izin ver."
  },
  Event_56147_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56147_Desc = {
    Text = "Okuldan gelen bir iletişim isteğini kabul ettin. Tanıdık Ses zihnini sakinleştiriyor. Kendini toparlayıp ilerliyorsun."
  },
  Event_56147_Name = {Text = "Kavşak"},
  Event_56147_Tips1 = {
    Text = "Yetersiz İmge. En az 3 tane gerekli."
  },
  Event_56148_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56148_Desc = {
    Text = "Armadadaki gümüş ışık duygularını harekete geçiriyor. Yüreğinin rehberliğini izleyerek elindekini dikenlerin arasına fırlatıyorsun. Altındaki ışık parlamaya başlıyor— o ışığın içinde yeni bir ilham kazanıyorsun."
  },
  Event_56148_Name = {Text = "Kavşak"},
  Event_56149_ChoiceDesc1 = {
    Text = "[Approach Light Points] Bir İmge kartını Yükselt, ancak Maksimum HP’ni %10 azalt."
  },
  Event_56149_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56149_Desc = {
    Text = "Elinle dikenleri iterek açıyorsun, ufak yaralar alıyorsun, ama bedel önemsiz—o ışık noktasında Esin Perisinin çağrısını işitiyorsun."
  },
  Event_56149_Name = {
    Text = "Muzus'un Lütfu"
  },
  Event_56149_Tips1 = {
    Text = "Bu İmge yükseltilemez."
  },
  Event_56150_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56150_Desc = {
    Text = "Armadaki gümüş ışık duygularını harekete geçiriyor. Şiiri zihnine kazıma isteğiyle dolup taşıyorsun."
  },
  Event_56150_Name = {Text = "Kavşak"},
  Event_56151_ChoiceDesc1 = {
    Text = "[New Inspiration] Bir İmge kartını İmha Et ve rastgele bir İmge kartını Yükselt."
  },
  Event_56151_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56151_Desc = {
    Text = "Okuldan gelen bir iletişim isteğini kabul ettin. Tanıdık Ses zihnini sakinleştiriyor. Kendini toparlayıp ilerliyorsun."
  },
  Event_56151_Name = {Text = "Kavşak"},
  Event_56151_Tips1 = {
    Text = "Yetersiz İmge"
  },
  Event_57738_ChoiceDesc1 = {
    Text = "[Forceful Entry] Tüm Uyananların Aliemus’unu 30 artır, ancak desteye iki [(Skill.Arg1)] kartı ekle."
  },
  Event_57738_ChoiceDesc2 = {
    Text = "[Disarm] Bir sonraki savaştaki düşmanların HP’si %60 artar ve %30 daha fazla Hasar verirler."
  },
  Event_57738_ChoiceDesc3 = {
    Text = "[Ambush] Tüm Uyananlar tüm Aliemus’larını kaybeder; 30 Kara Mühür elde et."
  },
  Event_57738_Desc = {
    Text = "Köşedeki kör noktadan başını uzatıyorsun. Komite Ajanları başka bir yöne bakıyor, varlığından habersizler.\nGeçmiş eğitimlerinin anıları zihninde çakıyor ve yolunu kesen düşmanlarla başa çıkmak için hızla bir yöntem buluyorsun."
  },
  Event_57738_Name = {
    Text = "Komite'nin Ajanı"
  },
  Event_57738_Tips3 = {
    Text = "Hiçbir Uyanışçı Aliemus’a sahip değil."
  },
  Event_57739_ChoiceDesc1 = {Text = "[Leave]"},
  Event_57739_Desc = {
    Text = "Dikkatle gözlemledin. Komite Ajanları yolunu kesti, çevreyi titizlikle gözetliyorlardı.\nSayısız düşmanla karşı karşıyayken, onlarla savaşamazdın.\nİlerlemek mi, geri çekilmek mi?"
  },
  Event_57739_Name = {
    Text = "Tutuklama Noktası"
  },
  Event_57776_ChoiceDesc1 = {Text = "[Leave]"},
  Event_57776_ChoiceDesc2 = {
    Text = "[Feign Surrender] Bu bölgeyi keşfettikten sonra Tutuklama Noktası’na aktarılır ve iki rastgele Semptom geliştirirsin."
  },
  Event_57776_ChoiceDesc3 = {
    Text = "[Intrude] Bu bölgeyi keşfettikten sonra Tutuklama Noktası’na aktarılır ve Arg1 HP kaybedersin."
  },
  Event_57776_Desc = {
    Text = "Dikkatle gözlemledin. Komite Ajanları yolunu kesti, çevreyi titizlikle gözetliyorlardı.\nSayısız düşmanla karşı karşıyayken, onlarla savaşamazdın.\nİlerlemek mi, geri çekilmek mi?"
  },
  Event_57776_Name = {
    Text = "Gözetleme Noktası"
  },
  Event_57776_Tips3 = {
    Text = "Yeterli CP’n yok."
  },
  Event_59193_ChoiceDesc1 = {
    Text = "[Alistair's Blessing] destesine 1 [Kutup Alacakaranlığı] ekle."
  },
  Event_59193_Desc = {
    Text = "Giriş belgesi bavulunun dibinde öylece yatıyordu. Kâğıda özgü o hafif mürekkep kokusunu içine çekerken, yıldızların sönmeyen parıltısıyla çerçevelenmiş gibi duran o zarif çerçeveyi usulca okşadın. Mythag Amblemi, geleceğe açılan ışıklı bir geçit gibi parlıyor, o gün olduğu gibi, bugün de hevesli bakışlarını büyülüyordu."
  },
  Event_59193_Name = {
    Text = "Kabul Töreni"
  },
  Event_59527_ChoiceDesc1 = {
    Text = "\"Lex Nous\" Yakarışı'nı kavramak için bir Kart seç. \"Lex Nous\": Oynandıktan sonra 2 kart çek; onların Arithmetica Maliyeti, Yakarış kartlarının gerçek Arithmetica Maliyetini düşürür ve bu Etki her Savaşta yalnızca bir kez işler."
  },
  Event_59527_Desc = {
    Text = "Bilgi sembolü belgenize kazınmıştır.\nTawil'in düşünceleri zihninize akıyor. Sonsuz olasılıklar arasında, tek gerçek yola doğru ilerliyorsunuz."
  },
  Event_59527_Name = {
    Text = "Kabul Töreni"
  },
  Event_59528_ChoiceDesc1 = {
    Text = "\"Lex Volis\" Yakarışı'nı kavramak için bir Kart seç. \"Lex Volis\": Oynandıktan sonra, bu Uyandırma kartı dışındaki tüm kartları at ve rastgele 5 adet Uyandırma olmayan kart kazan. Bu Etki yalnızca her Savaşta bir kez Etkindir."
  },
  Event_59528_Desc = {
    Text = "Neşe sembolü belgenize kazınmıştır.\nİşaret aracılığıyla N sizi gözlemliyor. Hiçbir zaman pervasızca dile getirmediği bir sonucu gerçekleştirmenizi bekliyor."
  },
  Event_59528_Name = {
    Text = "Kabul Töreni"
  },
  Event_59529_ChoiceDesc1 = {
    Text = "\"Lex Genis\" Yakarışı'nı kavramak için bir Kart seç. \"Lex Genis\": Oynandığında, \"Sakla\" ve \"Tüketme\" özelliklerine sahip 3 ek Temel Kopya kazan; bu yalnızca her Savaşta bir kez Etki gösterir."
  },
  Event_59529_Desc = {
    Text = "Yayılma sembolü belgenize kazınmıştır.\nThais umutlarını size bağlamıştır ve Her dünyada sizinle birlikte var olacaktır."
  },
  Event_59529_Name = {
    Text = "Kabul Töreni"
  },
  Event_59566_ChoiceDesc1 = {
    Text = "[Kan Gözyaşlarını Sil] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: [(EnchantConfig.Arg1)]"
  },
  Event_59566_ChoiceDesc2 = {
    Text = "[Eyes Open] Rastgele 3 Komut Kartına \"(EnchantConfig.Arg1)\" Yakarışını kazı, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_59566_Desc = {
    Text = "Sayılamayacak kadar çok dilek birleşir. Bir zamanlar aynı kökene sahiptiniz, şimdi aynı bedeni paylaşıyorsunuz.\nSayısız göz birlikte açılır, ulu gözle yüzleşir.\nSayısız göz birlikte parçalanır, kuru kan gözyaşları döker."
  },
  Event_59566_Name = {
    Text = "Benliklerin Birleşimi"
  },
  Event_59567_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59567_Desc = {
    Text = "Çılgın sesle tartışmaya çalışır, boşluğun ideolojisini çürütmeye çalışırsınız.\n\"Her şey ölüyor, bu hayatı anlamsız mı kılıyor?\"\nŞiddetle tartışırsınız, ama kahkaha devam eder, aptallığınızla alay eder."
  },
  Event_59567_Name = {
    Text = "Lambs to Slaughter"
  },
  Event_59568_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59568_Desc = {
    Text = "Kapıya bakıyorsunuz, cehaletin ıstırabına katlanmak istemiyorsunuz.\nÖtesinde ne olduğunu görmeyi arzuluyorsunuz.\nHayali kapı hipnotize edici bir şekilde sallanıyor, sayısız dünyanın anlık görüntüleriyle titreşiyor.\nKavramaya vakit bulamadan, sonsuz bir bilgi seli ruhunuzu istila ediyor ve zihninizi kaotik gürültüyle dolduruyor."
  },
  Event_59568_Name = {
    Text = "Kapıların Ötesinde"
  },
  Event_59569_ChoiceDesc1 = {
    Text = "[Firm Command] Rastgele bir Uyandırıcıyı Uyanışa geçir, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_59569_ChoiceDesc2 = {
    Text = "[Joint Discussion] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_59569_Desc = {
    Text = "Her şey o kadar aniden oldu ki. Bir sis seni sarıyor ve etrafına bakmaya çabalasan da hiçbir şeyi net göremiyorsun.\nUyananlar senin emrini bekliyor.\nArtık Yalıtılmışsın; yalnızca kendi Gücüne güvenmek zorundasın."
  },
  Event_59569_Name = {
    Text = "Cahil Bakış"
  },
  Event_59570_ChoiceDesc1 = {
    Text = "[With Sacrifice] Lanetli Kalıntı \"(RelicConfig.Arg1)\" elde et, ancak \"(Skill.Arg2)\" becerisini geliştir."
  },
  Event_59570_ChoiceDesc2 = {
    Text = "[Cesaretle] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: [(EnchantConfig.Arg1)]"
  },
  Event_59570_ChoiceDesc3 = {
    Text = "[With Direct Stare] 50 Kara Mühür al"
  },
  Event_59570_Desc = {
    Text = "Sonsuz dünyalarda sayısız versiyonun, omuz omuza, el ele, kardeşler gibi yan yana duruyor.\nŞimdi hepiniz büyük Gölge’nin altında, başlarınız dik, tek bir adım geri atmadan duruyorsunuz.\nNe yapmalı?\nKendinin o son versiyonunu nasıl yenebilirsin?"
  },
  Event_59570_Name = {
    Text = "Kendine Verilen Yanıt"
  },
  Event_59571_ChoiceDesc1 = {
    Text = "[Seek Answers] Arg1 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_59571_ChoiceDesc2 = {
    Text = "[Give Up] 25 Kara Mühür al ve ayrıl."
  },
  Event_59571_Desc = {
    Text = "Kapı'nın hayaletinden geçerken, kendinize dair sayısız deneyim zihninizde canlanır.\nBazıları öldü, bazıları delirdi, bazıları dayandı, diğerleri düştü.\nSayısız yol ve seçim gözlerinizin önünden geçer ve bir an içinde uzun, sonsuz bir hayat yaşamış gibi olursunuz.\nŞimdi sayısız zihin ve ağız aynı anda çalışıyor.\nZaman ve mekân boyunca sayısız versiyonunuzla konuşmaya çalışır, sonsuz anılardan cevaplar aramaya koyulursunuz."
  },
  Event_59571_Name = {
    Text = "Kendi Sorgulamam"
  },
  Event_59572_ChoiceDesc1 = {
    Text = "[Exchange Power] Rastgele bir Komut Kartı üzerine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_59572_ChoiceDesc2 = {
    Text = "[Exchange Fortune] Maksimum HP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_59572_Desc = {
    Text = "Her seçim bir bedel ister.\nHayat, ruh, duygu, hafıza...\nKaderle neyi takas etmek istiyorsun ve terazinin kefesine neyi koyacaksın?"
  },
  Event_59572_Name = {
    Text = "Kaderin Seçimi"
  },
  Event_59573_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59573_Desc = {
    Text = "İnsan kalpsiz nasıl yaşar?\nÇılgınca etrafı arıyorsun, her geçen an nefesin hızlanıyor, ölüm korkusu zihnini kaplıyor.\n“Nefes alamıyorum... Kalbim duruyor...”\nBekle, artık kalp atışına ihtiyacın olmadığını fark ediyorsun.\nSonunda anlıyor ve sevinçle gülüyorsun."
  },
  Event_59573_Name = {
    Text = "Boş Göğüs"
  },
  Event_59574_ChoiceDesc1 = {
    Text = "[Peer] Altın Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_59574_ChoiceDesc2 = {
    Text = "[Evade] Rastgele 2 Uyandırıcıyı Uyanış’a çağır, ancak [(Skill.Arg1)] becerisini iki kez geliştir."
  },
  Event_59574_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_59574_Desc = {
    Text = "Boşlukta seni izleyen bir varlığın farkına varıyorsun.\nNereye gidersen git, o bakış gölge gibi peşini bırakmıyor.\nKendini hedef alınmış küçük bir av gibi hissediyorsun ve sırtın, iğne batıyormuşçasına sızlamaya başlıyor."
  },
  Event_59574_Name = {
    Text = "O'nun Bakışı"
  },
  Event_59575_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59575_Desc = {
    Text = "Kaotik gösteriden etkilenmeden, kendi ritmini metanetli bir şekilde korursun.\nRakibin saldırıları ve ayartmaları sonuçsuz kalır. Piyanoda aynı anda iki melodi çalınır ve sona kadar kim dayanırsa tüm notalara hükmedecek olan odur."
  },
  Event_59575_Name = {
    Text = "Kıyamet Rapsodisi"
  },
  Event_59576_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59576_Desc = {
    Text = "Tüm cesaretinle, ne gelirse gelsin, yoldaşlarının yanında yürümeye devam edeceksin."
  },
  Event_59576_Name = {
    Text = "Donmuş Gelecek"
  },
  Event_59577_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59577_Desc = {
    Text = "\"Şu an neredesin?\"\n\"Öğretmenler ne planlıyor?\"\n\"Bundan sonra ne yapmalıyım?\"\nEndişeyle sorular soruyorsun, her zamanki gibi o güvenilir varlığa dayanmayı umarak.\nİletişim cihazı takılıyor ve yanıt vermeyi bırakıyor. Cihazı sallıyorsun ve yanıttaki kelimeler bir kelebek sürüsüne dönüşerek yüzüne doğru uçuşuyor.\nGözlerini ovuşturuyorsun, bunun sadece bir hayalet olduğunu fark ediyorsun.\nYanıt kâğıdı boş."
  },
  Event_59577_Name = {
    Text = "Sanrının Yankısı"
  },
  Event_59578_ChoiceDesc1 = {
    Text = "[Panic Search] Maks. HP’yi Arg1 kadar artır"
  },
  Event_59578_ChoiceDesc2 = {
    Text = "[Doldurmayı Dene] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_59578_Desc = {
    Text = "Göğsünde bir boşluk ve hafiflik hissediyorsun. Aşağı baktığında, bir anahtar deliği gibi açıldığını görüyorsun.\nKalbin yerinde yok."
  },
  Event_59578_Name = {
    Text = "Boş Göğüs"
  },
  Event_59579_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59579_Desc = {
    Text = "Niyetini yüksek sesle sorgularsın, ama aldığın tek şey değişmemiş bir gülümsemedir.\n\nO dünyayı çoktan terk etmiştir. Kopmuş bir birey hiçbir sorumluluk taşımaz.\nDirencin nafile."
  },
  Event_59579_Name = {
    Text = "Çılgın Beyefendi"
  },
  Event_59580_ChoiceDesc1 = {
    Text = "[Disrupt Rhythm] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_59580_ChoiceDesc2 = {
    Text = "[Self-Preservation] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_59580_Desc = {
    Text = "Yanınızda bir delinin varlığı eşlik ediyormuşçasına çalarsınız; sizi tuşlara bağlar, çılgın ezgisine sürükler.\nOnun ritmine ayak uydurmaya çalışır, sendeleyerek peşinden gidersiniz.\nEzginin kontrolünü ele geçirmek için mücadele edersiniz."
  },
  Event_59580_Name = {
    Text = "Kıyamet Rapsodisi"
  },
  Event_59581_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59581_Desc = {
    Text = "Tüm zincirleri ve bariyerleri paramparça edecek eşsiz bir güç arzularsın.\nNe var ki insan gücünün sınırları vardır. Çelimsiz bir bedenle tanrılara meydan okumak, sonunda ömrünü bir kibrit çöpü gibi yakıp tüketecektir."
  },
  Event_59581_Name = {
    Text = "Kaderin Seçimi"
  },
  Event_59582_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59582_Desc = {
    Text = "\"Gitti... Hepsi gitti...\"\nKendini boş hissediyorsun ve boşluğu doldurmak için bir cep saati, elma ve okul ceketi alıyorsun.\nGöğsün tekrar dolu hissediyor, biraz fazlasıyla bile.\nSorun değil; hiçbir şey mükemmel olmaz."
  },
  Event_59582_Name = {
    Text = "Boş Göğüs"
  },
  Event_59583_ChoiceDesc1 = {
    Text = "[Persuade] 25 Kara Mühür al"
  },
  Event_59583_ChoiceDesc2 = {
    Text = "[Question] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ama \"(Skill.Arg2)\" geliştir."
  },
  Event_59583_Desc = {
    Text = "N'nin ayakkabıları önünde duruyor, karanlık yüzünde çarpık bir sırıtış var.\nHer zaman kusursuz giyinir, ama o centilmence görünüşün ardında saf bir delilik yatar.\nDostları yoktur, düşmanları da azdır.\nÇünkü hepsi en teatral biçimde ortadan kaybolur.\nMaalesef, sen şimdi onun bir sonraki baş oyuncususun.\nAçılış repliğini hazırla. Bu en kritik seyirciyi nasıl memnun edeceksin?"
  },
  Event_59583_Name = {
    Text = "Çılgın Beyefendi"
  },
  Event_59584_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59584_Desc = {
    Text = "Uyandırıcılar senden çok daha fazlasını bilmiyor, ama uzun süredir en sadık yoldaşların, silah arkadaşların ve desteğin oldular.\nUyandırıcılarla stratejileri tartışıyorsun. Hâlâ belirsiz olsa da, hep birlikte yeniden ileri gitme cesaretini buluyorsunuz."
  },
  Event_59584_Name = {
    Text = "Cahil Bakış"
  },
  Event_59585_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59585_Desc = {
    Text = "Sanki kararlılığınızı pekiştiriyormuşçasına, yüksek ve kararlı bir sesle cevap veriyorsunuz.\nSesiniz sayısız baloncuk arasında yankılanıyor, sanki sayısız versiyonunuz birlikte yemin ediyor.\nArtık her şeyle yüzleşmeye hazırsınız."
  },
  Event_59585_Name = {
    Text = "O'nun Sorgulaması"
  },
  Event_59586_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59586_Desc = {
    Text = "Kımıldamadan duruyor, yanıtın üzerindeki sözcüklere dikkatle bakıyorsun.\nBakışının altında sözcükler yavaşça bulanıklaşıp bükülüyor, yüzüne doğru uçuşan kelebeklere dönüşüyor.\nEllerini sallayıp onları kovuyorsun; ama yanıt kâğıdının artık tamamen boş olduğunu görüyorsun.\nGerçek olamayacak kadar güzel rüyalar, elbette daima sahtedir."
  },
  Event_59586_Name = {
    Text = "Sanrının Yankısı"
  },
  Event_59587_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59587_Desc = {
    Text = "Bu alçakça ipliklerden tiksiniyorsun.\nTüm gücünle çekiyorsun; bazıları kopuyor, ama sayısız diğerleri yeniden birbirine dolanıyor.\nOnlarla boğuşurken bütün gücünü tüketiyorsun."
  },
  Event_59587_Name = {
    Text = "Puppet Hands"
  },
  Event_59588_ChoiceDesc1 = {
    Text = "[Gölgeyi Kes] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_59588_ChoiceDesc2 = {
    Text = "[Embriyoyu Ez] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_59588_ChoiceDesc3 = {
    Text = "[Close Your Eyes] 25 Kara Mühür al"
  },
  Event_59588_Desc = {
    Text = "Sersemlik içinde, Aram'da bir zamanlar tanıştığın insanların sana yaklaştığını görüyorsun.\nGülüyorlar ve seni içmeye, dans etmeye, ziyafetten zevk almaya davet ediyorlar.\nSonra etleri tabaka tabaka soyulmaya başlıyor, yere düşüp kıvranarak yeni Embriyolara dönüşüyor.\nSana ellerini uzatıyorlar, et ve yeniden doğuş kutlamasına katılmanı istiyorlar."
  },
  Event_59588_Name = {
    Text = "Geçmişin Gölgeleri"
  },
  Event_59589_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59589_Desc = {
    Text = "Elinizi uzatmadan önce, böyle bir kedinizin hiç olmadığını aniden hatırlıyorsunuz.\nHavada kedinin gözleriyle bakışlarınız buluşuyor ve size göz kırpıyor.\nKedi kayıtsızlığınızı umursamıyor; yine de sizi aynı şekilde seviyor gibi görünüyor."
  },
  Event_59589_Name = {
    Text = "Kedinin Cazibesi"
  },
  Event_59590_ChoiceDesc1 = {
    Text = "[Embed] Bir Kalıntıyı [(RelicConfig.Arg1)] Lanetli Kalıntıya dönüştür"
  },
  Event_59590_ChoiceDesc2 = {
    Text = "[Swallow] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_59590_ChoiceDesc3 = {
    Text = "[Store] 25 Kara Mühür al"
  },
  Event_59590_Desc = {
    Text = "İçinizdeki üç Aeon'un gücü birleşiyor ve onu kontrol etmekte zorlanıyorsunuz.\nRuh diyarınız genişlemeye devam ederken bir galaksi doğuyor ve yayılıyor.\nSonsuz bir düşman dalgasıyla karşı karşıya kalarak bu yıldızlı gökyüzüne içtenlikle dua ediyor, yardımını diliyorsunuz.\nGalaksiden bir yıldız avucunuza düşüyor ve büyüleyici bir parıltı yayıyor."
  },
  Event_59590_Name = {
    Text = "Dilek Yıldızı"
  },
  Event_59591_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59591_Desc = {
    Text = "Sessizlikle cevap veriyorsunuz. Hiçbir söz alışverişi yok; sessizlik cevaptır.\nHer şeyle yüzleşmeye hazırsınız."
  },
  Event_59591_Name = {
    Text = "O'nun Sorgulaması"
  },
  Event_59592_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59592_Desc = {
    Text = "O kedi bir yalancı mı?\nEtrafında yankılanan kahkahalar eşliğinde, havuz gibi mavi gözlerinden şüphe duymaya başlarsın.\n“Yalancı, yalancı, kandırıldın!”\nİçinde bir kaygı dalgası kabarır."
  },
  Event_59592_Name = {
    Text = "Secret Whisper"
  },
  Event_59593_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59593_Desc = {
    Text = "Bir gözlemci gibi, giderek yabancılaşan duyguları sessizce izliyorsun.\nTüm kalan arzuları bastırıyorsun ve ruhunun soğuduğunu hissediyorsun.\nBu senin kaderin, senin yazılmış yolun."
  },
  Event_59593_Name = {
    Text = "Kristalleşmiş Duygu"
  },
  Event_59594_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59594_Desc = {
    Text = "O gülümseyen yüz yerinden kıpırdamaz; ne mantıklı argümanların ne de duygusal yakarışların onu sarsabilir.\nİnsan arzuları onun için hiçbir anlam taşımaz.\nSözlerin, insan hayal gücünün sınırlarını aşabilir mi?"
  },
  Event_59594_Name = {
    Text = "Çılgın Beyefendi"
  },
  Event_59595_ChoiceDesc1 = {
    Text = "[Answer] Altın Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_59595_ChoiceDesc2 = {
    Text = "[Remain Silent] Rastgele 2 Uyanan’ı uyandır, ancak [(Skill.Arg1)] becerisini iki kez geliştir."
  },
  Event_59595_Desc = {
    Text = "Sayısız göze benzeyen sayısız baloncuk sessizce sizi izliyor, sanki sessizce sorguluyorlar.\nHazır mısınız?\nHer şeyden vazgeçmeye hazır mısınız?\nHer şeyi taşımaya hazır mısınız?"
  },
  Event_59595_Name = {
    Text = "O'nun Sorgulaması"
  },
  Event_59596_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59596_Desc = {
    Text = "Rakipler saldırıya geçtiğinde, derhal karşılık verirsiniz.\nOnların gerçek doğasını zekice fark ettiniz—dişlerini gösteren birer canavarden başka bir şey değiller.\nGalip gelme şansına sahip olduğunuz için şanslısınız.\nŞimdi, canınız için kaçın ve sizi yakalamadıklarından emin olun."
  },
  Event_59596_Name = {
    Text = "Uçurumun Mahkûmu"
  },
  Event_59597_ChoiceDesc1 = {
    Text = "[Seek Answers] Arg1 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_59597_ChoiceDesc2 = {
    Text = "[Give Up] Ayrıl"
  },
  Event_59597_Desc = {
    Text = "Ne yapmalısınız?\nKendinizin sayısız versiyonunu görürsünüz, yüzleri sizinkiyle aynı, size bakıyor, dudakları kıpırdıyor.\nBir umut kırıntısına tutunur gibi, umutsuzca arar ve dinlersiniz, son cevabı bulmayı umarak."
  },
  Event_59597_Name = {
    Text = "Kendi Sorgulamam"
  },
  Event_59598_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59598_Desc = {
    Text = "Henüz değil. Dayanmalı ve beklemelisin.\nKininle nefretini yutuyor, belirleyici anı bekliyorsun."
  },
  Event_59598_Name = {
    Text = "Puppet Hands"
  },
  Event_59599_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59599_Desc = {
    Text = "Tarif edilemez bir çekim hissediyorsun; sanki görünmeyen bakışların kaynağına doğru çekiliyorsun.\nBoşluğa bakıyor, bir şeyin gölgesini yakalamışsın gibi hissediyorsun.\nGörüş Alanın bir anlığına kar benzeri bulanıklıklarla örtülüyor ve gözlerinin önündeki dünya değişmiş gibi oluyor.\nGözlerini ovuşturduğunda, yüzünden aşağı süzülen iki ince kanlı gözyaşı şeridi fark ediyorsun."
  },
  Event_59599_Name = {
    Text = "O'nun Bakışı"
  },
  Event_59600_ChoiceDesc1 = {
    Text = "[Hatırlamaya Çalış] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_59600_ChoiceDesc2 = {
    Text = "[Hüznü Tatmak] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_59600_ChoiceDesc3 = {
    Text = "[Accept Silently] 25 Kara Mühür al"
  },
  Event_59600_Desc = {
    Text = "Sanki en hassas beyin ameliyatından geçiyormuşsun gibi, zihninden özenle sakladığın anıların sökülüp alındığını, düşüncelerinin beynin eriyormuşçasına bulanıklaştığını apaçık hissediyorsun.\nAcıyla titriyor, karşı koyan elini bastırıyorsun.\nBillur gibi gözyaşları süzülüyor, ama neden akıyorlar?\nGaliba unuttun.\nİzahsız bir keder hissediyorsun."
  },
  Event_59600_Name = {
    Text = "Hafıza Ayrışması"
  },
  Event_59601_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59601_Desc = {
    Text = "Kediyle bağın tartışılmazdır. El sallayıp arkana bakmadan ilerlersin.\n\"Ahmak! Ahmak!\"\nArdından gelen ses öfkeyle haykırır."
  },
  Event_59601_Name = {
    Text = "Secret Whisper"
  },
  Event_59602_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59602_Desc = {
    Text = "Kararlı bir halde, bedeli ne olursa olsun, herkesin umudunu sırtlanıp sonuna dek savaşmaya niyetleniyorsun."
  },
  Event_59602_Name = {
    Text = "Donmuş Gelecek"
  },
  Event_59603_ChoiceDesc1 = {
    Text = "[Restrain] Gümüş Kalıntı [(RelicConfig.Arg1)]yı elde et"
  },
  Event_59603_ChoiceDesc2 = {
    Text = "[Gaze] Altın Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" becerisini geliştir"
  },
  Event_59603_Desc = {
    Text = "Tawil tarafından korunan Kapının ardında sonsuz bir dünya ve sınırsız hakikatler yatıyor.\nKapının ötesinde ne gördüğünü bilmiyorsunuz, ama onun her şeyi bildiğini biliyorsunuz.\nŞimdi kapı önünüzde açık duruyor, ardında saklanan tüm hakikatleri ortaya çıkarmanız için sessizce sizi davet ediyor."
  },
  Event_59603_Name = {
    Text = "Kapıların Ötesinde"
  },
  Event_59604_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59604_Desc = {
    Text = "\nBilinmeyene saygı gösterin; onun kıyısından uzak durmak bilgece bir seçimdir.\nBaşınızı eğiyor ve göğsünüzdeki Gümüş Anahtarı sıkıca tutuyorsunuz, hafifçe teselli buluyorsunuz.\nEn azından hâlâ gücünüz ve Uyandırıcılarınız var.\nO bakışları görmezden gelmeye ve önünüzdeki yola odaklanmaya çalışıyorsunuz.\nAma o bakışlar gerçekten kayboldu mu? Cevabı biliyorsunuz."
  },
  Event_59604_Name = {
    Text = "O'nun Bakışı"
  },
  Event_59605_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59605_Desc = {
    Text = "Eğer tanrılara karşı koymanın tüm yolları, karıncanın ağacı sarsmaya çalışması kadar nafileyse, tutunabileceğin tek şey sarsılmaz cesarettir.\nSonsuz Yıkım tepende dolaşırken, en önde duran kişi sen olacaksın."
  },
  Event_59605_Name = {
    Text = "Kendine Verilen Yanıt"
  },
  Event_59606_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59606_Desc = {
    Text = "Düşen gözyaşlarına dokunur, aklın alamayacağı bir kederi yeniden yaşarsın.\nSanki çok kıymetli bir şeyi yitirmişsindir, ama ne olduğunu bir türlü hatırlayamazsın.\nNe yazık.\nGözyaşlarını güçsüzce siler, yüzüne acı bir gülümseme zorla kondurursun."
  },
  Event_59606_Name = {
    Text = "Hafıza Ayrışması"
  },
  Event_59607_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59607_Desc = {
    Text = "Seslerini görmezden gelirsiniz.\nKedinin yalancı olup olmadığı umurunuzda değil; yalnızca kendi gücünüze güvenirsiniz.\nKulaklarınızda sesler iç çeker."
  },
  Event_59607_Name = {
    Text = "Secret Whisper"
  },
  Event_59608_ChoiceDesc1 = {
    Text = "[Seek Answers] Arg1 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_59608_ChoiceDesc2 = {
    Text = "[Give Up] Ayrıl"
  },
  Event_59608_Desc = {
    Text = "Biri çılgınca güler.\nKendinizin o versiyonu her şeyin boşuna olduğuna inanır, erken vazgeçmek daha iyidir.\nKaşlarınızı çatarsınız ve o benlik aniden gülümser, acı çekmekten kurtarmak için herkesin hayatına son vermeyi önerir.\nSesi savuşturursunuz, inançlarınızda kararlısınız."
  },
  Event_59608_Name = {
    Text = "Kendi Sorgulamam"
  },
  Event_59609_ChoiceDesc1 = {
    Text = "[Interrogate] Herhangi 2 Kartı İmha Et"
  },
  Event_59609_ChoiceDesc2 = {
    Text = "[Pierce] \"(RelicConfig.Arg1)\" Lanetli Kalıntısını edin, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_59609_ChoiceDesc3 = {
    Text = "[Leave] Arg1 Kara Mühür al"
  },
  Event_59609_Desc = {
    Text = "Uzun bekleyişin içinde, İletişimci’yi yeniden açıyorsun. Belki özlemin ve Duaların karşılık bulmuştur; mektubun üzerinde tanıdık ve şefkatli yanıtların belirdiğini görüyorsun.\nŞu anda çok güvende, hocalarının ayarladığı her şey yerli yerinde ve Mythag sorunsuz işliyor...\nHaberler kar taneleri gibi peş peşe geldikçe, yüreğinde bir kıpırtı hissetmemek elde değil."
  },
  Event_59609_Name = {
    Text = "Sanrının Yankısı"
  },
  Event_59610_ChoiceDesc1 = {
    Text = "[Catch the Stars] Bir Gümüş Kalıntıyı Altın Kalıntı [(RelicConfig.Arg1)]ya Yükselt."
  },
  Event_59610_ChoiceDesc2 = {
    Text = "[Crush the Stars] Altın Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ama \"(Skill.Arg2)\" ve \"(Skill.Arg3)\" geliştir."
  },
  Event_59610_ChoiceDesc3 = {
    Text = "[Watch Silently] 25 Kara Mühür al"
  },
  Event_59610_Desc = {
    Text = "Duyguların, anılarınla birlikte soyulup alınıyor. Kendini devasa bir varlığa dönüşürken hissediyorsun; kadim, sıcak yuvasına dönen bir canavar gibi.\nSayısız duygu parlak yıldızlara yoğunlaşarak ruh âleminde yağmur gibi yağıyor.\nVarlığının izleri bir kayan yıldız gibi kayboluyor.\nSessizce izliyorsun, kahkahanla yankılanan bir yıldızı yerden alıyorsun.\nVe sen de gülüyorsun, anın tadını çıkararak."
  },
  Event_59610_Name = {
    Text = "Kristalleşmiş Duygu"
  },
  Event_59611_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59611_Desc = {
    Text = "Bunların yalnızca geçmişin gölgeleri olduğunu biliyorsun; bir zamanlar seninle konuşanları, en ufak bir duygu taşımadan acımasızca katlediyorsun.\nKahkahaları ve gözyaşları avuçlarının arasında paramparça oluyor, tereddüde yer bırakmıyor.\nEğer bu zorunlu bir sınavsa, o hâlde sen en acımasız cellat olacaksın."
  },
  Event_59611_Name = {
    Text = "Geçmişin Gölgeleri"
  },
  Event_59612_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59612_Desc = {
    Text = "Yumuşak tüyleri ve berrak gözleri doğal olarak güven veriyor.\nKediye yaklaşıyorsun ve o da sana yaklaşıyor.\nİkiniz de konuşmuyorsunuz ama kuyruğu dimdik duruyor."
  },
  Event_59612_Name = {
    Text = "Kedinin Cazibesi"
  },
  Event_59613_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59613_Desc = {
    Text = "Merakınızı bastırıyorsunuz, bu kapının asla açılmaması gerektiğini biliyorsunuz.\nÇok fazla hakikat bazen bir lanet olabilir.\nGümüş Anahtarı göğsünüze bastırarak, bu kapıyı sonsuza dek mühürlü tutmaya karar veriyorsunuz."
  },
  Event_59613_Name = {
    Text = "Kapıların Ötesinde"
  },
  Event_59614_ChoiceDesc1 = {
    Text = "[Courage] 2 Rastgele kartın Yakarış niteliğini güçlendir."
  },
  Event_59614_ChoiceDesc2 = {
    Text = "[Resolve] [(EnchantConfig.Arg1)] Yakarışını 3 Komut Kartından 1’ine kazı."
  },
  Event_59614_Desc = {
    Text = "Tawil'in sözleri zihninizde yankılanıyor.\nSayısız son arasında yalnızca tek bir gerçek yol var.\nBir an dalıp giderken, pek çok dünyanın gelip geçen gölgelerinin film kareleri gibi gözlerinizin önünden aktığını görürsünüz, donacak anı beklerken.\nBir sonraki saniyede dünyanın kaderi ne olacak?"
  },
  Event_59614_Name = {
    Text = "Donmuş Gelecek"
  },
  Event_59615_ChoiceDesc1 = {
    Text = "[Ignore Suspicion] 50 Kara Mühür al"
  },
  Event_59615_ChoiceDesc2 = {
    Text = "[Arbitrary] 75 Kara Mühür kazan, ancak [(Skill.Arg2)] Semptomunu geliştir"
  },
  Event_59615_Desc = {
    Text = "N’nin alayıyla birlikte, tanıdığın herkes hakkında şüpheye düşmeye başlıyorsun.\nHangileri onun suretleri, hangileri senin gerçek hocaların ve dostların?\nGölgeleri durmadan şekil değiştiriyor, sayısız yüz açığa çıkıyor, hepsi sana sırıtarak bakıyor."
  },
  Event_59615_Name = {
    Text = "Gölgenin Yüz Yüzü"
  },
  Event_59616_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59616_Desc = {
    Text = "Eğer Herkes ihanet edebiliyorsa, kimseye güvenme.\nKaranlıkta yalnızca tek bir gerçeği doğrulayabilirsin.\nEn azından hâlâ kendin varsın—güvenebileceğin en sadık hâlin."
  },
  Event_59616_Name = {
    Text = "Gölgenin Yüz Yüzü"
  },
  Event_59617_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59617_Desc = {
    Text = "Parıldayan kristali avucunda ezip toza dönüştürürsün.\nGeçmişten sızan duyguları açgözlülükle içine çekersin.\nYoğun bir sevinç dalgası beynini istila eder, sonra bir fantazma gibi dağılır.\nDudakların hızla yukarı kıvrılır, ardından yavaşça iner.\nYüzün giderek sakinleşir, ifadesizleşir."
  },
  Event_59617_Name = {
    Text = "Kristalleşmiş Duygu"
  },
  Event_59618_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59618_Desc = {
    Text = "Her şeyin bir bedeli olduğunu biliyorsun; kurtuluşun bedeli kurbansa, onu sonuna dek ödemeye hazırsın.\nHer an, kendini bütünüyle feda etmeye hazır durumdasın."
  },
  Event_59618_Name = {
    Text = "Kendine Verilen Yanıt"
  },
  Event_59619_ChoiceDesc1 = {
    Text = "[Seek Answers] Arg1 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_59619_ChoiceDesc2 = {
    Text = "[Give Up] Ayrıl"
  },
  Event_59619_Desc = {
    Text = "Biri bağırır.\nKaçmaya can atan o benlik, direnişin boşuna olduğunu iddia eder.\nAncak sonsuz kaçış, nihai yok oluşu geciktirebilir.\nŞüphelisiniz."
  },
  Event_59619_Name = {
    Text = "Kendi Sorgulamam"
  },
  Event_59620_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59620_Desc = {
    Text = "Embriyo çoğalmasının korkunç hızını biliyorsun; buradaki yeni yaşam, çekirgeler gibi bir lanettir.\nYeni doğanları daha ağlayamadan eziyorsun.\nEt ve kandan yapılmış figürler sana zehirli bir nefretle bakıyor, kutsal yaşamı kirletmeni sorguluyorlar.\nSen amansız bir katliamla karşılık veriyorsun."
  },
  Event_59620_Name = {
    Text = "Geçmişin Gölgeleri"
  },
  Event_59621_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59621_Desc = {
    Text = "Bu anda, en şanslı kişi olmayı, en kusursuz sona ulaşmayı diliyorsun.\nAma iyi talihin bedeli bazen daha zalim olabilir. Şans ve talihsizlik çoğu zaman el ele yürür. Bir şey kazandığında, neleri kaybettiğini de unutma."
  },
  Event_59621_Name = {
    Text = "Kaderin Seçimi"
  },
  Event_59622_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59622_Desc = {
    Text = "Direksiyon için kavga eder gibi, ellerin her yana savruluyor, müziğin ritmini ele geçirmeye çalışıyorsun.\nMücadelenin hararetinde, bir anda bir sıra tuşa abanıyorsun.\nKaotik icra sekteye uğruyor; dişlerini gösterip gülümsüyorsun ve daha da derin bir deliliğe dalıyorsun."
  },
  Event_59622_Name = {
    Text = "Kıyamet Rapsodisi"
  },
  Event_59623_ChoiceDesc1 = {
    Text = "[Approach] %100 ihtimalle 25 Kara Mühür elde et"
  },
  Event_59623_ChoiceDesc2 = {
    Text = "[Gaze] %50 ihtimalle 50 Kara Mühür kazan, %50 ihtimalle hiçbir şey kazanma."
  },
  Event_59623_Desc = {
    Text = "Bir kedi seni takip ediyor; tüyleri parlak ve temiz, ön patileri kar kadar beyaz.\nKedi, en sadık hizmetkârınmış gibi, adım adım yanında kalıyor.\nTüm Şaşkınlığın, çaresizliğin, acın ve kaygın yatışıyor."
  },
  Event_59623_Name = {
    Text = "Kedinin Cazibesi"
  },
  Event_59624_ChoiceDesc1 = {
    Text = "[Deny] Lanetli Kalıntı \"(RelicConfig.Arg2)\" edin, fakat \"(Skill.Arg1)\" geliştir."
  },
  Event_59624_ChoiceDesc2 = {
    Text = "[Retort] Gümüş Kalıntı \"(RelicConfig.Arg2)\" ve \"(RelicConfig.Arg3)\"u elde et, ancak \"(Skill.Arg1)\"i iki kez geliştir."
  },
  Event_59624_ChoiceDesc3 = {
    Text = "[Remain Silent] Gümüş Kalıntı [(RelicConfig.Arg1)] elde et"
  },
  Event_59624_Desc = {
    Text = "Hiçliğin illüzyonuna düşersiniz.\nKıyametin gölgesinde susturulmuş sayısız insanı görürsünüz, toz zerreleri kadar küçük.\nCansız, gri ve umutsuzdurlar.\nBirinin tiz kahkahasını duyarsınız.\n\"Bak, ısrarının sonucu bu.\"\n\"Dünya asla sona ermez; her şey anlamsız.\""
  },
  Event_59624_Name = {
    Text = "Lambs to Slaughter"
  },
  Event_59625_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59625_Desc = {
    Text = "Hayır, bu yanlış, bu gerçek değil.\nÇılgın sesleri durmaksızın reddediyorsun, ama gri gölgeler kımıldamadan kalıyor, sanki hayali bir sonu tasdikler gibi.\nKahkahalar büyüyor, çaresizliğinle alay ediyor."
  },
  Event_59625_Name = {
    Text = "Lambs to Slaughter"
  },
  Event_59626_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59626_Desc = {
    Text = "İçini derin bir pişmanlık ve isteksizlik kaplıyor; içgüdüsel olarak Geçmişi Hatırlamaya çabalıyor, izlerini hafızanın parçaları arasında arıyorsun.\nBulanık yansımalar hızla geri çekiliyor ve sen onları umutsuzca kavramaya çalışsan da parmaklarının arasından kayıp gidiyorlar.\nHer şeyi kaybetmek üzere olduğunu fark ediyorsun."
  },
  Event_59626_Name = {
    Text = "Hafıza Ayrışması"
  },
  Event_59627_ChoiceDesc1 = {
    Text = "[Approach] %100 ihtimalle 25 Kara Mühür elde et"
  },
  Event_59627_ChoiceDesc2 = {
    Text = "[Gaze] %50 ihtimalle 50 Kara Mühür kazan, %50 ihtimalle hiçbir şey kazanma."
  },
  Event_59627_Desc = {
    Text = "Bir kedi seni takip ediyor; tüyleri parlak ve temiz, ön patileri kar kadar beyaz.\nKedi, en sadık hizmetkârınmış gibi, adım adım yanında kalıyor.\nTüm Şaşkınlığın, çaresizliğin, acın ve kaygın yatışıyor."
  },
  Event_59627_Name = {
    Text = "Kedinin Cazibesi"
  },
  Event_59628_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59628_Desc = {
    Text = "Burada, nihai benliğinle karşılaşıyorsun; dünyayı yok etme savaşı yalnızca bir bakışmadan ibaret.\nO sana baktığında, bakışını kararlılıkla karşılamalısın—ta ki birinizin bakışı sönene kadar."
  },
  Event_59628_Name = {
    Text = "Kendine Verilen Yanıt"
  },
  Event_59629_ChoiceDesc1 = {
    Text = "[Breath] Gümüş Kalıntı \"(RelicConfig.Arg1)\"i elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_59629_ChoiceDesc2 = {
    Text = "[Counterattack] Altın Kalıntı \"(RelicConfig.Arg1)\" elde et, ancak \"(Skill.Arg2)\" ve \"(Skill.Arg3)\" Semptomlarını geliştir."
  },
  Event_59629_ChoiceDesc3 = {
    Text = "[Struggle] 25 Kara Mühür al"
  },
  Event_59629_Desc = {
    Text = "Bir grup Komite Ajanı yolunuzu keserken ağır ayak sesleri yankılanır.\n\"Lütfen soruşturmamıza işbirliği yapın.\"\nSoğuk ses, bir parça kötü niyet taşır.\nBir şıpırtıyla, durgun su bozulur ve sizi derinliklere atarlar."
  },
  Event_59629_Name = {
    Text = "Uçurumun Mahkûmu"
  },
  Event_59630_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59630_Desc = {
    Text = "Umutsuzca çırpınırsın.\nİleri, sadece biraz daha.\nBedeli ne olursa olsun, her şeyi korumak zorundasın.\nİpler etini keserken elini uzatırsın, ama hiçbir şey hissetmezsin."
  },
  Event_59630_Name = {
    Text = "Puppet Hands"
  },
  Event_59631_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59631_Desc = {
    Text = "Başınızı şiddetle sallarsınız, kaotik anıları zihninizden temizlersiniz.\nKısa sürede gürültü kaybolur ve bilinciniz bağımsızlığını yeniden kazanır.\nGeçmiş başarısızlıklarda yardım bulamayacağınızı bilirsiniz; ancak şimdiki ana odaklanarak umut bulabilirsiniz."
  },
  Event_59631_Name = {
    Text = "Kendi Sorgulamam"
  },
  Event_59632_ChoiceDesc1 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_59632_Desc = {
    Text = "Elinizi uzatmadan önce, böyle bir kedinizin hiç olmadığını aniden hatırlıyorsunuz.\nHavada kedinin gözleriyle bakışlarınız buluşuyor ve size göz kırpıyor.\nKedi kayıtsızlığınızı umursamıyor; yine de sizi aynı şekilde seviyor gibi görünüyor."
  },
  Event_59632_Name = {
    Text = "Kedinin Cazibesi"
  },
  Event_59633_ChoiceDesc1 = {
    Text = "[Seek Answers] Arg1 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_59633_ChoiceDesc2 = {
    Text = "[Give Up] Ayrıl"
  },
  Event_59633_Desc = {
    Text = "Birileri ağlıyor.\nYasla dolu, sevdiklerini kucaklamayı arzuluyorlar.\nEn büyük pişmanlıkları, Yıkım sırasında sevdiklerinin yanında olamamak.\nSen de acılarını paylaşırken, kalbin sızlıyor."
  },
  Event_59633_Name = {
    Text = "Kendi Sorgulamam"
  },
  Event_59634_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59634_Desc = {
    Text = "Alaycı kahkahayı görmezden gelerek sayısız gri figüre bakarsınız.\nÇökmekte olan bir dünyayı nasıl kurtarabilirsiniz?\nSessiz yok oluşun ortasında düşünürsünüz."
  },
  Event_59634_Name = {
    Text = "Lambs to Slaughter"
  },
  Event_59635_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59635_Desc = {
    Text = "Alveollerinizdeki hava yavaş yavaş tükenir ve su altında nefes almaya çalışırsınız.\nNe aptalca bir davranış, ama yine de başarırsınız.\nAlveolleriniz yeniden dolar ve bir kez daha özgürce nefes alabilirsiniz.\nAma tam olarak ne soluyorsunuz?"
  },
  Event_59635_Name = {
    Text = "Uçurumun Mahkûmu"
  },
  Event_59636_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59636_Desc = {
    Text = "Yapışkan sıvının içine gömülüyorsun.\nNe kadar çabalarsan çabala, yalnızca daha derine batıyorsun.\nBu bataklıktan tek başına kaçamazsın."
  },
  Event_59636_Name = {
    Text = "Uçurumun Mahkûmu"
  },
  Event_59637_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59637_Desc = {
    Text = "Kendini bu şüpheleri unutmaya zorluyorsun.\nBu anda şüphenin beyhude olduğunu biliyorsun; yalnızca güvenebilirsin.\nMühürlü kutu açılana dek, içindeki hakikat sana bilinmeyen kalacak.\nBazen, şaşkın bir budalanın rolünü oynamak insana huzur getirir."
  },
  Event_59637_Name = {
    Text = "Gölgenin Yüz Yüzü"
  },
  Event_59638_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59638_Desc = {
    Text = "Tüm gözler sende. Lider olarak, hiçbir kırılganlık göstermemelisin.\n\"Kara Göl'e gidin, her şey yoluna girecek.\"\nSakince komutu veriyorsun, kendin bile pek inanmadığın bir söz vererek."
  },
  Event_59638_Name = {
    Text = "Cahil Bakış"
  },
  Event_59639_ChoiceDesc1 = {
    Text = "[Suspect] Lanetli Kalıntı \"(RelicConfig.Arg2)\"yı elde et, ancak \"(Skill.Arg1)\"i geliştir."
  },
  Event_59639_ChoiceDesc2 = {
    Text = "[Disdain] Gümüş Kalıntı \"(RelicConfig.Arg2)\" ve \"(RelicConfig.Arg3)\"u elde et, ancak \"(Skill.Arg1)\"i iki kez geliştir."
  },
  Event_59639_ChoiceDesc3 = {
    Text = "[Ignore] Gümüş Kalıntı [(RelicConfig.Arg1)]i elde et"
  },
  Event_59639_Desc = {
    Text = "Üç tereddütlü siluet önünde bir şeyler mırıldanıyor.\nDinlemek için eğiliyorsun; sözleri nefesleriyle karışıp giderek berraklaşıyor.\n“O kediye güvenme; o bir yalancı.”\nAniden arkanı dönüyorsun, ama yanında kimseyi bulamıyorsun."
  },
  Event_59639_Name = {
    Text = "Secret Whisper"
  },
  Event_59640_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59640_Desc = {
    Text = "Yıldızlar öyle iştah açıcı görünür ki, güçlerine göz dikersiniz ve birini bütünüyle yutarsınız.\nGulp.\nRuhunuz hiç olmadığı kadar dolu hisseder ve yan görüşünüzde bir ışık belirir.\nAşağı baktığınızda, yıldızın hâlâ karnınızda parladığını görürsünüz."
  },
  Event_59640_Name = {
    Text = "Dilek Yıldızı"
  },
  Event_59641_ChoiceDesc1 = {
    Text = "[Struggle Forward] Bir Komut Kartı’nı İmha Et ve Arg1 Kara Mühür al."
  },
  Event_59641_ChoiceDesc2 = {
    Text = "[Snap the Thread] Bir Komut Kartını kopyala, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_59641_ChoiceDesc3 = {
    Text = "[Endure] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_59641_Desc = {
    Text = "Boylu boyunca ileri itiliyorsun, her seçimin görünmez ipliklerce yönlendiriliyor.\nÖnem verdiğin her şeyi kavramak için çırpınıyorsun.\nDünyanın kaderi parmak uçlarının hemen önünde sallanıyor.\nSayısız iplik birbirine dolanıyor, tüm bedenini bağlayıp sarıyor."
  },
  Event_59641_Name = {
    Text = "Puppet Hands"
  },
  Event_59642_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59642_Desc = {
    Text = "Kanlı gözyaşlarını siliyorsun, ama daha fazlası akmaya devam ediyor.\nKızıl, görüşünü bulandırıyor; sanki kanlı bir kurbanı önceden haber veriyor.\nTitreyerek, acı içinde silmeye devam ediyorsun, ama içinde zerre kadar korku yok."
  },
  Event_59642_Name = {
    Text = "Benliklerin Birleşimi"
  },
  Event_59643_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59643_Desc = {
    Text = "Büyülü mücevheri okşar ve Gümüş Anahtar'a yerleştirirsiniz.\nYıldız ışığı sizi sarar.\nGözleriniz kamaşır"
  },
  Event_59643_Name = {
    Text = "Dilek Yıldızı"
  },
  Event_59644_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59644_Desc = {
    Text = "Her şeye rağmen gözlerini sonuna dek açık tuttun, saf iradeyi meydan okuyan bir kükreyişe dönüştürdün.\nParamparça olup silinsen bile, tek bir adım geri çekilmeyeceksin."
  },
  Event_59644_Name = {
    Text = "Benliklerin Birleşimi"
  },
  Event_59645_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59645_Desc = {
    Text = "Biri sessiz kalır.\nUmutsuz benliğin yüzünü görünce, hiçbirinin sona ulaşamadığını anlarsınız.\nTüm benlikler arasında en uzağa siz gittiniz; yalnızca sizin cevabınız son umudu taşıyor."
  },
  Event_59645_Name = {
    Text = "Kendi Sorgulamam"
  },
  Event_59646_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59646_Desc = {
    Text = "Elini uzatır, sayısız kayan yıldızı yakalamaya çalışırsın; ışıklı kristaller parmak uçlarına sürtünür.\nNeşe, ağıt, öfke, korku...\nHer duyguyu açgözlülükle kaparsın, sadece parmaklarının arasından kayıp gidişlerini izlemek için.\nGöz alıcı ışık yüzünü aydınlatır, gözlerin yavaşça derin ve karanlık bir hâl alır."
  },
  Event_59646_Name = {
    Text = "Kristalleşmiş Duygu"
  },
  Event_59657_ChoiceDesc1 = {
    Text = "[Call Out] Gümüş Kalıntı [(RelicConfig.Arg1)] elde et"
  },
  Event_59657_ChoiceDesc2 = {
    Text = "[Touch] Altın Kalıntı \"(RelicConfig.Arg1)\" elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_59657_Desc = {
    Text = "Otomatonun bozulmasına tanık oluyorsunuz.\nBir zamanlar en rasyonel varlıktı, en sadık asistanınızdı, topladığınız tüm bilgileri özenle koruyordu.\nŞimdi, birlikte paylaştığınız anların hiçbirini artık hatırlamıyor gibi görünüyor.\nGözlerinin kenarından kristal gözyaşlarının düştüğünü görüyorsunuz."
  },
  Event_59657_Name = {
    Text = "Otomatonun Gözyaşı"
  },
  Event_59658_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59658_Desc = {
    Text = "Vazgeçmeyi reddediyorsun ve enerji çekirdeğine ulaşmaya çalışıyorsun.\nBir makineyse, yeniden başlatılabilir, değil mi?\nAncak acımasız otomaton sana bu saf fırsatı tanımıyor.\nGeri durman, otomatondan merhamet elde etmeye yetmiyor ve tüm gücünle savaşmak zorunda kalıyorsun."
  },
  Event_59658_Name = {
    Text = "Otomatonun Gözyaşı"
  },
  Event_59659_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59659_Desc = {
    Text = "Eski partnerine zarar vermek istemiyorsun.\nÇaresizce adını haykırıyor, aklına gelen tüm komutları veriyorsun, ama nafile.\nOtomaton sana ihanet etti, cansız bir nesnenin soğukluğuna geri döndü."
  },
  Event_59659_Name = {
    Text = "Otomatonun Gözyaşı"
  },
  Event_60944_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60944_Desc = {
    Text = "Zaman daralıyor, bu yüzden en dolaysız yolu seçip ablukayı yararak geçiyorsun. Uyandırıcılar ilham bulup coşkuya kapılıyor.\nArtan düşman Alarmı’na gelince, bu pek de kayda değer bir endişe değil."
  },
  Event_60944_Name = {
    Text = "Komite'nin Ajanı"
  },
  Event_60945_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60945_Desc = {
    Text = "Ajan tepki veremeden arkasına dolanır ve silahını kaparsın.\nTakviye kuvvetler gelmeden de kaçmayı başarırsın.\nNe yazık ki söylenti yayılmıştır; bir sonraki düşmanlar daha hazırlıklı olacaktır.\nHazırlan."
  },
  Event_60945_Name = {
    Text = "Komite'nin Ajanı"
  },
  Event_60946_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60946_Desc = {
    Text = "Ajan, bir ıslığın çekimine kapılıp saklandığın yere yaklaşır. Yeterince yaklaştığında, bekleyişteki Uyananlar saldırıya geçer.\nKusursuz bir pusu. Buradaki tehdit kalıcı olarak ortadan kaldırıldı."
  },
  Event_60946_Name = {
    Text = "Komite'nin Ajanı"
  },
  Event_60947_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60947_Desc = {
    Text = "Sayısız düşmanla yüz yüze, karşılık veremez hâlde kalırsın. Bilerek, direnmeden görüş alanlarına adım atarsın.\nYakında bir Tutuklama Noktası’na götürüleceğini biliyorsun; bu da planın bir parçası.\nOradan kaçacak ve yeni bir yol bulacaksın."
  },
  Event_60947_Name = {
    Text = "Gözetleme Noktası"
  },
  Event_60948_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60948_Desc = {
    Text = "Sayısız düşmanla karşı karşıya, onlarla boy ölçüşemezsin. Kısa bir çarpışmanın ardından direnmekten vazgeçersin.\nBir tutma noktasına götürülmek üzere olduğunu biliyorsun; bu planın bir parçası.\nOradan kaçacak ve yeni bir yol bulacaksın."
  },
  Event_60948_Name = {
    Text = "Gözetleme Noktası"
  },
  Event_60949_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60949_Desc = {
    Text = "Sayısız düşmanla karşı karşıya, onlarla baş edemiyorsun.\nGeçici olarak çekilmeyi ve yeni bir yol aramayı seçiyorsun."
  },
  Event_60949_Name = {
    Text = "Gözetleme Noktası"
  },
  Event_61058_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61058_Desc = {
    Text = "Ellerine ve tüm bedenine bakıyorsun, umut ve kararlılıkla dolu.\nEğer tüm bunlar kaderin tasarımının bir parçasıysa, her şeyle yüzleşmeye hazırsın.\nSon anlarda, cennete ya da cehenneme açılan kapılar olursa, onları dünya için açacak olan sen olacaksın."
  },
  Event_61058_Name = {Text = "Gözle"},
  Event_61059_ChoiceDesc1 = {
    Text = "[Ready for Battle] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_61059_ChoiceDesc2 = {
    Text = "[Continue Observing] [(Skill.Arg1)] Semptomunu geliştir ve Yakarışı kazıma ile değiştir.(Kullanım: 1/2)"
  },
  Event_61059_Desc = {
    Text = "Savaşa atılmak için acele etmiyor, sakince durumu anlamaya çalışıyorsun. Bu aniden beliren şef hem dost hem düşman gibi; niyetinden emin değilsin. Yine de, tümüyle Hazırlanmayı seçiyor, gerçek amacını gözlemlemeden önce meydan okumasıyla yüzleşmeye hazır bekliyorsun."
  },
  Event_61059_Name = {
    Text = "İblis Kondüktör"
  },
  Event_61060_ChoiceDesc1 = {
    Text = "[Listen] 3 İleri Yakarıştan 1’ini Oyarak Kazı"
  },
  Event_61060_ChoiceDesc2 = {
    Text = "[Call Out] Altın Kalıntı \"(RelicConfig.Arg1)\" elde et, ancak \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_61060_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_61060_Desc = {
    Text = "Kazadan bu yana partnerinizden hiçbir haber almadınız.\nSayısız iletişim girişimi, denize taş atmak gibi karşılıksız kaldı.\nTüm umudunuzu yitirdiğinizde, iletişim cihazı aniden bir ses çıkarıyor.\nBavulu açıyor, alıcıyı kulağınıza yaklaştırıyorsunuz.\n\"Koruyucu...\"\nBir an için, özlediğiniz o sesi duyuyorsunuz, boşlukta uzaklardan yankılanıyor."
  },
  Event_61060_Name = {
    Text = "Özlemin Yankısı"
  },
  Event_61061_ChoiceDesc1 = {
    Text = "[Embrace the Darkness] Gümüş Kalıntı \"(RelicConfig.Arg1)\" elde et, ancak \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_61061_ChoiceDesc2 = {
    Text = "[Attempt to Swim] Gümüş Kalıntı \"(RelicConfig.Arg1)\" elde et, ancak \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_61061_ChoiceDesc3 = {
    Text = "[Call to the Ghosts] 25 Kara Mühür al"
  },
  Event_61061_Desc = {
    Text = "İleri atılırsın ve zemin bir anda geçilmez bir denize dönüşür.\nToprağın içine gömülürsün.\nMezarlıktaki hayaletler gibi koyu ve yapışkan bir karanlık seni sarar, açgözlülükle ağzına ve burnuna sızar."
  },
  Event_61061_Name = {
    Text = "Yerin Altına Batış"
  },
  Event_61062_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61062_Desc = {
    Text = "Gözlerinizi sonuna kadar açıyor, her ipucunu arıyorsunuz.\nYüz göz aynı anda hareket ediyor; önünüzde insan yüzlü tazının pençe izlerini, arkanızda Hameln'in batonunu sallayışının yörüngesini görüyorsunuz.\nAçgözlülükle her şeyi gözlemliyorsunuz.\nAniden, yerde yuvarlanan tanıdık bir göz küresi fark ediyorsunuz.\nSizin gözlerinizden biri gibi görünüyor."
  },
  Event_61062_Name = {
    Text = "Bilginin Açgözlülüğü"
  },
  Event_61063_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61063_Desc = {
    Text = "Hayır, bu kadar çok şeyi göremezsin.\nKaç tane gözün vardı senin? Sadece... birkaçı mı?\nAceleyle gözlerini kapatıp yüzünü yoklarsın.\nBir, iki...\nGözlerini yeniden açtığında, görüş alanın dar ve cahilce olur.\nAh, sadece iki gözün var. Ne yazık."
  },
  Event_61063_Name = {
    Text = "Bilginin Açgözlülüğü"
  },
  Event_61064_ChoiceDesc1 = {
    Text = "[Search] Lanetli Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_61064_ChoiceDesc2 = {
    Text = "[Gözleri Kapat] Rastgele 1 Komut Kartı Mühür kazanır: [(EnchantConfig.Arg1)]"
  },
  Event_61064_Desc = {
    Text = "Giderek artan ipuçları dolaşık bir yumağa dönüşüyor; kaygılı, kafası karışık, kızgın hissediyorsunuz—hiçbir şey bilmediğiniz için kendinizden nefret ediyorsunuz.\nMuazzam bir baskı ruhunuzu ince bir ipliğe sıkıştırıyor.\nBir çıtırtıyla, başınızın aniden rahatladığını hissediyorsunuz ve tüm çevrenizi algılayabildiğinizi, boşlukta titreşen gölgeleri görebildiğinizi fark ediyorsunuz.\nDaha fazla, daha fazlasını görmeniz gerekiyor..."
  },
  Event_61064_Name = {
    Text = "Bilginin Açgözlülüğü"
  },
  Event_61065_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61065_Desc = {
    Text = "Kendini en çevik balıkmışsın gibi hayal ederek toprağın içinde yüzüyorsun.\nBir balık olmak için, insan bacaklarından vazgeçmelisin.\nBu, anlaşmanın bedeli.\nÇok geçmeden, yeraltındaki en özgür varlığa dönüşürken eşi benzeri görülmemiş bir özgürlük hissi kaplıyor içini.\nYüzeye geri dönüyorsun, ama yürümeyi nasıl yaptığını unutmuşsun."
  },
  Event_61065_Name = {
    Text = "Yerin Altına Batış"
  },
  Event_61066_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61066_Desc = {
    Text = "Parmakların Gümüş Anahtar'ın tanıdık dokunuşuna değiyor, tüm ışığın özü.\nO, hayatını ve kaderini simgeliyor.\nAnılar gözlerinin önünden akıp geçiyor.\nSeçimlerin artık dünyanın kaderiyle ayrılmaz biçimde bağlı.\nKaderin pek çok başkasının kaderiyle iç içe geçmiş durumda."
  },
  Event_61066_Name = {Text = "Gözle"},
  Event_61067_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61067_Desc = {
    Text = "Kendini birçok tanıdık varlığın arasında hissedersin.\nBelki de hiç var olmayan hayaletlere seslenmeye çalışırsın.\nBir mucize gerçekleşir ve kendini yeniden yerde bulursun.\nSayılamayacak kadar çok mezar taşı sessizce dikilir."
  },
  Event_61067_Name = {
    Text = "Yerin Altına Batış"
  },
  Event_61068_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61068_Desc = {
    Text = "Duygusallığa ayıracak vaktin yok; tek amacın bu çökmekte olan dünyayı kurtarmak.\nEğer bir yıldız olmak zorundaysan, bir kayan yıldız ol.\nDüşsen bile, gece göğünü aydınlattığın sürece."
  },
  Event_61068_Name = {Text = "Gözle"},
  Event_61069_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61069_Desc = {
    Text = "En ufak sesi bile yakalayabilmek için kulağını daha da yaklaştırıyorsun.\n“Ben...”\n“Mutlaka...”\nYalnızca kopuk kopuk sözler duyabiliyorsun, anlam çıkaramıyorsun.\nAma tek bir kelimeyi bile kaçırmaktan korktuğun için ses etmeye cesaret edemiyorsun.\nNe var ki kader merhamet nedir bilmiyor.\nSon ses kırıntısı da sönüp gidiyor, geriye yalnızca sessizlik kalıyor."
  },
  Event_61069_Name = {
    Text = "Özlemin Yankısı"
  },
  Event_61070_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61070_Desc = {
    Text = "Daha fazla düşünmeyi bırakır ve Uyananlara, onun meydan okumasıyla yüzleşmek için sıraya girmelerini emredersin."
  },
  Event_61070_Name = {
    Text = "İblis Kondüktör"
  },
  Event_61071_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61071_Desc = {
    Text = "Onun adını durmadan çağırıyor, duygularından en azından bir kırıntıyı iletmeye çalışıyorsun.\nSeni duyup duymadığını bilmiyorsun. Mikrofondan gelen o hafif sesleri seçebilmek için kulak kesiliyorsun.\nBu, onun cevabı olabilir ya da belki de geçmişin durmaksızın dönen parçalarıdır.\nBir zamanlar birlikte paylaştığınız sevinçleri ve ağıtları yeniden yaşıyorsun."
  },
  Event_61071_Name = {
    Text = "Özlemin Yankısı"
  },
  Event_61072_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61072_Desc = {
    Text = "Belki de gerçek dünya bu karanlıktır. Ona katılmakta ne sakınca var?\nKaranlığı bütünüyle kucaklıyorsun ve o artık seni reddetmiyor. Rahatça nefes alabiliyorsun.\nBir sonraki saniye yüzeye dönüyorsun. Belki aşağıda bir şeyler kalıyor, ama artık önemi yok."
  },
  Event_61072_Name = {
    Text = "Yerin Altına Batış"
  },
  Event_61073_ChoiceDesc1 = {
    Text = "[Gaze at Light] \"(EnchantConfig.Arg1)\" Yakarışını 3 Komut Kartından 1’ine kazı, ancak \"(Skill.Arg2)\" Becerisini geliştir."
  },
  Event_61073_ChoiceDesc2 = {
    Text = "[Touch Chest] Bir Uyandırıcıyı Uyanışa çağır, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_61073_ChoiceDesc3 = {
    Text = "[Keep Running] 25 Kara Mühür al"
  },
  Event_61073_Desc = {
    Text = "Kaybolmuş durumdasın ve yalnızca delicesine koşabiliyorsun; düşünmeye vaktin yok.\nAniden göğsünde bir boşluk hissediyorsun.\nAşağı baktığında, kalbinin olması gereken yerde anahtar biçimli bir ışık görüyorsun.\nIşık giderek parlaklaşıyor, tüm bedenine yayılıyor.\nKendinin bir yıldıza dönüştüğünü görüyorsun.\nBirden, belki de bunun her zaman senin görevin olduğunu fark ediyorsun."
  },
  Event_61073_Name = {Text = "Gözle"},
  Event_61074_ChoiceDesc1 = {
    Text = "[Ready for Battle] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_61074_ChoiceDesc2 = {
    Text = "[Observe Carefully] [(Skill.Arg1)] Semptomunu geliştir ve Yakarışı kazıma ile değiştir.(Kullanım: 2/2)"
  },
  Event_61074_Desc = {
    Text = "\"Hey... bekle! Neler oluyor...\"\n\"Prova.\"\nAdam ifadesiz bir yüzle sana bakıyor.\n\"Müzikle Uyandıran bağlantısını sürdürmek yeni bir deney. Orkestranın kalitesini güvenceye almak, kusursuz bir icrayı güvenceye alır.\"\nŞef çubuğunu zarifçe kaldırıyor, başlangıcı işaret ederek.\n\"Çal, Koruyucu. Bana neler yapabildiğini göster.\""
  },
  Event_61074_Name = {
    Text = "İblis Kondüktör"
  },
  Event_61075_ChoiceDesc1 = {
    Text = "[Ready for Battle] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_61075_Desc = {
    Text = "Niyeti ne olursa olsun, seni Komite’nin infazcılarından kurtardı. Sana zarar vermek isteseydi, yardım etmezdi. Kendini toparlayıp en kötüsüne hazırlanırsın."
  },
  Event_61075_Name = {
    Text = "İblis Kondüktör"
  },
  Event_65400_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65400_Desc = {
    Text = "Bir aracı, dışarıdan gelecek kurtuluş vaatlerini iletti; kurtarma ekibi dağa ulaşmaya çalışırken umut yeniden alevlendi."
  },
  Event_65400_Name = {Text = "Kavşak"},
  Event_65401_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65401_Desc = {
    Text = "Keşif ekibinin hiçbir üyesi Karlı Dağ’dan sağ çıkamadı. Felaket karşısında her zaman kendini seçiyorsun ve sıradan insanların hayatlarının senin için hiçbir anlamı yok. İnsanlığın Işığını terk ettin ve sağ salim sona ulaştın.\nKurtarma ekibi sana karmaşık duygularla baktı, ama sen aldırış etmeden kar fırtınasının içine yürüdün. Belki gece yarısı, kayıtsızlığın yüzünden ölenlerin ruhları yatağının etrafında toplanıp sessizce seni izleyecek."
  },
  Event_65401_Name = {
    Text = "Güvenli Tahliye Noktası"
  },
  Event_65402_ChoiceDesc1 = {
    Text = "[Crowd Evacuation] \"Keşif Ekibi\" yadigârını kaldır ve keşif ekibi üyelerinin sayısına göre farklı seviyelerde \"Kurtarma Madalyası\" kazan."
  },
  Event_65402_Desc = {
    Text = "Keşif ekibini güvenle tahliye noktasına ulaştırdın. Kurtarma ekibi devralırken, kurtarılanlar sanki başka bir âleme geçmişçesine yere yığılıyor.\nAma sen, gerçek krizin çözülmekten hâlâ çok uzak olduğunu biliyorsun. Devasa canavar hâlâ Sıradağlar’ın derinliklerinde pusuda, bir sonraki hamlesi için açlıkla bekliyor."
  },
  Event_65402_Name = {
    Text = "Güvenli Tahliye Noktası"
  },
  Event_65403_ChoiceDesc1 = {
    Text = "[Supply Trade] 25 Kara Mühür al, ayrıca her Sefer Üyesi için (Arg1) 1 ek al."
  },
  Event_65403_ChoiceDesc2 = {
    Text = "[Rescue Promise] 3 Yakarış arasından 1’ini kazı. 2 Keşif Üyesi kazan."
  },
  Event_65403_ChoiceDesc3 = {
    Text = "[Profit First] Altın+ bir Kalıntı edin, ancak 10 Keşif Üyesi kaybet."
  },
  Event_65403_Desc = {
    Text = "Kar fırtınasında bata çıka ilerler, uzaktaki acil irtibat noktasının titrek ışıklarını takip edersin.\n○ Nihayet, sayısız duadan sonra, umudu barındıran küçük kulübeyi görürsün."
  },
  Event_65403_Name = {Text = "Kavşak"},
  Event_65403_Tips3 = {
    Text = "Keşif Üyesi Sayısı Çok Az"
  },
  Event_65404_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65404_Desc = {
    Text = "Bağlantı görevlisinden depo şifresini aldın ve Herkes için iki günlük Envanter buldun. En azından karlı dağda açlıktan ya da soğuktan ölmeyeceksiniz."
  },
  Event_65404_Name = {Text = "Kavşak"},
  Event_65415_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_65415_Desc = {
    Text = "Karlı Dağ, \"yemeğini\" bir anda tamamladı; iki kişi sonsuza dek dipsiz yarıklarda kayboldu ve hiçbiriniz bunu fark etmediniz."
  },
  Event_65415_Name = {Text = "İllüzyon"},
  Event_65416_ChoiceDesc1 = {
    Text = "[Leave] Projektör Ara"
  },
  Event_65416_ChoiceDesc2 = {
    Text = "[Snow Intrusion] 2 Keşif Üyesi Kaybet"
  },
  Event_65416_Desc = {
    Text = "Aniden kopan bir fırtına, Karlı Dağ’ın yamacını süpürür; uluyan rüzgâr bir canavarın çığlığını andırır, kar sisleri gözlerini kör eder. Sonsuz beyazlığın içinde bir şeylerin kıpırdadığını hissedersin.\nMecburen durur, bacaklarını kara sağlamca gömerek yamaçtan aşağı kaymamak için kendini sabitlersin."
  },
  Event_65416_Name = {Text = "???"},
  Event_65417_ChoiceDesc1 = {
    Text = "[Silent Evaporation] 2 Keşif Üyesi Kaybet"
  },
  Event_65417_ChoiceDesc2 = {Text = "[Leave]"},
  Event_65417_Desc = {
    Text = "Karlı Dağ’ın bağrından kükremeler yükseliyor, aç bir canavarın homurtularını andırıyor. Zemin titriyor, karın altındaki buz sessizce çatlıyor; sanki Karlı Dağ çenesini aralıyormuş gibi.\nSarsıntılar nihayet dindiğinde, insanlar şaşkınlık içinde etraflarına bakınıyor ve sen grubu kontrol etmek için geriye dönüyorsun."
  },
  Event_65417_Name = {Text = "İllüzyon"},
  Event_65468_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65468_Desc = {
    Text = "Ekibin hareket kabiliyetini güvenceye almak için çırpınanları geride bırakıp onları Yalıtılmış bir kulübeye terk ettin. Bu, geriye kalanların hayatta kalma oranını artırabilir, ama onların kin dolu bakışlarıyla yüzleşirken gerçekten hiçbir şey hissetmiyor musun?"
  },
  Event_65468_Name = {Text = "Kavşak"},
  Event_65483_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65483_Desc = {
    Text = "Bazı insanları kurtardın, ama karlı dağda daha fazlası kaldı. En azından elinden geleni yaptın.\nKurtarma ekibi, çabalarının sonra takdir edileceğini söyledi. Onlara el sallayıp kar fırtınasının içine geri yürüdün."
  },
  Event_65483_Name = {
    Text = "Güvenli Tahliye Noktası"
  },
  Event_65484_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65484_Desc = {
    Text = "Tüm odağını karlı dağdan kaçmaya verdin, en verimli yolu seçtin. Son hayatta kalanın gözünde bir iblis gibi görünebilirsin.\nKurtarıcılar, katkılarının yakında onurlandırılacağını söyledi. Sen onları elinle savuşturup kar fırtınasının içine yürüdün."
  },
  Event_65484_Name = {
    Text = "Güvenli Tahliye Noktası"
  },
  Event_65485_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65485_Desc = {
    Text = "Aralıksız korumanız altında, tüm keşif ekibi sağ salim çıktı. Sizinle karşılaşmak, talihsizlik içindeki en büyük şanslarıydı; siz onların gerçek kurtarıcısısınız.\nFelaket ortasında bir mucize yarattınız ve yakında Kar Dağı kahramanının hikayeleri her yere yayılacak. Kurtarma ekibi olağanüstü katkılarınızın yakında onurlandırılacağını ciddiyetle belirtti. Gülümseyerek elinizi salladınız ve kar fırtınasına geri yürüdünüz."
  },
  Event_65485_Name = {
    Text = "Güvenli Tahliye Noktası"
  },
  Event_65486_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65486_Desc = {
    Text = "İnsanların hayatını gerçekten önemsiyorsun. Çoğunu sen kurtardın, gözyaşları içinde sana teşekkür edip durdular, koruman için minnet duydular.\nKurtarıcılar, olağanüstü katkının yakında takdir edileceğine dair ciddi bir söz verdiler. Sen gülümsedin, el salladın ve kar fırtınasının içine yürüdün."
  },
  Event_65486_Name = {
    Text = "Güvenli Tahliye Noktası"
  },
  Event_65487_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65487_Desc = {
    Text = "Sürekli şekil değiştiren felakete karşı savaştın ve insanları Ölümün Eşiği’nden geri çektin. Çabaların sayesinde trajik son biraz olsun saptı.\nKurtarma ekibi, paha biçilmez katkını ağırbaşlılıkla kabul etti ve onurlandırılacağını ilan etti. Sen gülümsedin, el salladın ve yeniden kar fırtınasının içine yürüdün."
  },
  Event_65487_Name = {
    Text = "Güvenli Tahliye Noktası"
  },
  Event_6817_ChoiceDesc1 = {
    Text = "[Stop Here] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_6817_ChoiceDesc2 = {
    Text = "[Okumaya Devam Et] Rastgele 1 Komut Kartı Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_6817_Desc = {
    Text = "Ahşap bir kitaplığın en üst rafında, altın kapaklı bir kitap duruyor. Aşağıdan bakınca adını seçemiyorsun.\nNedense, onu okuma arzusu içinde kabarıyor… Bu arzu hızla dizginlenemez hâle geliyor. Fark edilme riskini umursamadan, kitaplığın yanındaki ahşap merdivene tırmanıyor, kitabı alıyor ve iştahla okumaya başlıyorsun…\nZihninin okyanusunda belirsiz imgeler yüzeye çıkıyor. Düşlerden bir denizin içine gömülüyorsun…"
  },
  Event_6817_Name = {
    Text = "Sarı Kitap"
  },
  Event_6818_ChoiceDesc1 = {
    Text = "[Dinle] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_6818_ChoiceDesc2 = {
    Text = "[Ensemble] 50 veya daha fazla Aliemus’a sahip her Uyandırıcı için 15 Kara Mühür al."
  },
  Event_6818_ChoiceDesc3 = {
    Text = "[Leave] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_6818_Desc = {
    Text = "Piyano sesi aniden kulaklarına ulaşıyor. Eterik yeşil parmaklar tuşların üzerinde dans ediyor, akıp giden bir dere kadar zarif bir melodi yaratıyor.\n“Sevgili dostum, benimle bir düete katılmak ister misin?”\nEller konuşmuyor; müzik aracılığıyla sana soruyorlar."
  },
  Event_6818_Name = {
    Text = "Arp'ın Hayaleti"
  },
  Event_6819_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6819_Desc = {
    Text = "Ramona sesin kaynağına baktı, fakat yalnızca duvara eriyen bir gramofon gibi solup giden bir Fantazma yakalayabildi."
  },
  Event_6819_Name = {
    Text = "Başkasının Kulakları"
  },
  Event_6820_ChoiceDesc1 = {
    Text = "[Clean the Typewriter] Bir Komut Kartı İmha Et ve 25 Kara Mühür kazan."
  },
  Event_6820_ChoiceDesc2 = {
    Text = "[Try to Identify Text] Bir Kartı kopyala, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_6820_Desc = {
    Text = "Bavuldaki daktilo aniden koyu mürekkep püskürttü; tren sallandıkça mürekkep çizgisel akıntılar hâlinde etrafa sıçradı."
  },
  Event_6820_Name = {
    Text = "Daktilon'un Fısıltısı"
  },
  Event_6821_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6821_Desc = {
    Text = "Yumruğun fantazmayı dağıtırken, anılar zihnine hücum eder, ruhunu acıyla döver."
  },
  Event_6821_Name = {Text = "Serap"},
  Event_6822_ChoiceDesc1 = {
    Text = "[Discard the Letter] Bir Kartı İmha Et"
  },
  Event_6822_ChoiceDesc2 = {
    Text = "[Keep Close] \"(RelicConfig.Arg1)\" Kalıntısını elde et, fakat \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_6822_Desc = {
    Text = "\nDaktilo’dan birkaç sayfa çekip alıyorsun. Dağılmış mürekkep ağır bir koku yayıyor. İçeriğe göz gezdiriyor, istemsizce kaşlarını çatıyorsun.\nMektubun çoğu karalanmış; geriye yalnızca cümle olmaya zor yeten birkaç Parça kalmış, metni neredeyse okunamaz kılıyor."
  },
  Event_6822_Name = {
    Text = "Lekeli Mektup"
  },
  Event_6823_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6823_Desc = {
    Text = "Kâğıttaki bulanık yazıyı çözmek için kendini zorluyorsun. Sözcükler bükülüyor ve sonra bambaşka bir şeyi açığa çıkarıyor.\n“@2Sanırım gazetede haberi görmüşsündür.\nEvet, baban seni veraset sıralamasından çıkardı... Biz @2 istememiştik\nŞeytan, şeytan...\nBay Herbert’le derhal görüşmeyi kes, yoksa mali desteğini keseceğim...”"
  },
  Event_6823_Name = {
    Text = "Yazıyla Buluşma"
  },
  Event_6824_ChoiceDesc1 = {
    Text = "[Hold Silver Key] \"(EnchantConfig.Arg1)\" Yakarışını 3 Komut Kartından 1’ine kazı, ancak \"(Skill.Arg2)\" Becerisini geliştir."
  },
  Event_6824_ChoiceDesc2 = {
    Text = "[Close Your Eyes] Bir Uyandırıcıyı Uyanışa çağır, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_6824_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_6824_Desc = {
    Text = "\nSaçma bir dalganın içinde paramparça oldun, uzuvların bükülüp çarpılırken, sanki @2 boyutunun öte âleminden gelen bir şey tarafından yönlendiriliyormuşsun gibi yerde sürünüyordun.\n \"Hayır... hayır...\"\nAkıl sağlığın, örümcek ağı gibi parça parça çökerken, hezeyanlı kahkahalar ve çığlıklar dev bir ağ misali bilincini sardı; dudaklarından dökülenlerse yalnızca belirsiz inlemelerdi."
  },
  Event_6824_Name = {
    Text = "Gözcünün Bakışı"
  },
  Event_6825_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6825_Desc = {
    Text = "Onu işlemeyi Koruyucu'ya bırak; kim bilir, nasıl bir bireyi Uyandırabilir."
  },
  Event_6825_Name = {
    Text = "Yalnız Gümüş Çekirdek"
  },
  Event_6826_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6826_Desc = {
    Text = "Kulak ucundan hüzünlü bir melodi süzülür, zihin ve ruhu keder ve acıyla doldurur. Farkına varmadan önce, birinin gözlerinde yaşlar çoktan birikmiştir."
  },
  Event_6826_Name = {
    Text = "İsimsiz Yankı"
  },
  Event_6827_ChoiceDesc1 = {
    Text = "[Open the Left Door] Gümüş Kalıntı [(RelicConfig.Arg1)]yı elde et"
  },
  Event_6827_ChoiceDesc2 = {
    Text = "[Open the Right Door] Altın Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" becerisini geliştir"
  },
  Event_6827_Desc = {
    Text = "Kapılar. Kapılar. Sayısız kapı.\nSen ve Ramona en son teftiş ettiğinizden bu yana kapıların sayısı artmış gibi görünüyor.\nKoridorda duruyor, bir sonraki kapıyı itip açmaya hazırlanıyorsun.\nSol taraftaki kapının ardında her şey sessiz, usulca Varışını bekliyor.\nSağ taraftaki kapının ardındansa Boğuk Sesler duyuluyor."
  },
  Event_6827_Name = {
    Text = "Sonsuzluk Kapısı"
  },
  Event_6828_ChoiceDesc1 = {
    Text = "[Listen Closely] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ama \"(Skill.Arg2)\" geliştir."
  },
  Event_6828_ChoiceDesc2 = {
    Text = "[Plug Ears] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_6828_Desc = {
    Text = "Yalnızca çılgınca basılan tuşların sesini duyarsın; bir fırtına gibi saldıran, yere çarpan göktaşları gibi, tüm piyanoyu titreten.\nMızraplar inler, pedallar hüzünlü bir feryat salar.\nUğursuz ezginin içinde, tanıdık melodiler sürüklenir, kulak zarlarını kazıya kazıya ilerler."
  },
  Event_6828_Name = {
    Text = "Yasak Tını"
  },
  Event_6829_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6829_Desc = {
    Text = "\"Müfettiş William acil Envanter teslimatı sağladı; teslim aldıktan sonra broşunu onay için üç kez tıkla.\""
  },
  Event_6829_Name = {
    Text = "Destek İletişimi"
  },
  Event_6830_ChoiceDesc1 = {
    Text = "[Push Left Door] 3 Yakarıştan 1’ini Oyarak Yaz"
  },
  Event_6830_ChoiceDesc2 = {
    Text = "[Push the Right Door] 3 Komut Kartından 1’ine \"(EnchantConfig.Arg1)\" Yakarışını kazı, ancak \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_6830_Desc = {
    Text = "Kapılar. Kapılar. Sayısız kapı.\nSen ve Ramona en son teftiş ettiğinizden bu yana kapıların sayısı artmış gibi görünüyor.\nKoridorda duruyor, bir sonraki kapıyı itip açmaya hazırlanıyorsun.\nSol taraftaki kapının ardında her şey sessiz, usulca Varışını bekliyor.\nSağ taraftaki kapının ardındansa Boğuk Sesler duyuluyor."
  },
  Event_6830_Name = {
    Text = "Sonsuz Kapılar"
  },
  Event_6831_ChoiceDesc1 = {
    Text = "[Read the Letter] Bir Komut Kartı İmha Et ve Arg1 Kara Mühür al."
  },
  Event_6831_ChoiceDesc2 = {
    Text = "[Close the Box]"
  },
  Event_6831_Desc = {
    Text = "Bavul durmaksızın titriyor, sanki bir tür hayat, bir Yumurta Kabuğu'nu yarıp çıkmanın eşiğindeymiş gibi.\nKendini tutamayıp bavulu açıyorsun ve mektuplar salıverilmiş kelebekler gibi etrafa saçılıyor."
  },
  Event_6831_Name = {
    Text = "Davetsiz Mektup"
  },
  Event_6832_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6832_Desc = {
    Text = "Israrcı çınlama kalp atışlarını hızlandırır. Ahizeyi alıp masanın üzerine bırakırsın. Çınlama aniden kesilir; sanki biri onu boğazından yakalamış gibi, zihninde yankısı dışında hiçbir şey kalmaz."
  },
  Event_6832_Name = {
    Text = "Tren Araması"
  },
  Event_6833_ChoiceDesc1 = {
    Text = "[Pick up the Photo] 3 Komut Kartı’ndan 1’ine [(EnchantConfig.Arg1)] Yakarı’nı kazır."
  },
  Event_6833_ChoiceDesc2 = {
    Text = "[Check Film] [(Skill.Arg1)] Semptomunu geliştir ve kazınacak Yakarışı değiştir.(Kullanım: 2/2)"
  },
  Event_6833_Desc = {
    Text = "Atölyenin bir köşesinde eski bir fotoğraf makinesi, birkaç film rulosu ve etrafa saçılmış fotoğraflar durur. Bunlar, balmumu heykeltıraşının işini ve estetiğini sadakatle belgelemiştir."
  },
  Event_6833_Name = {
    Text = "Birebir Kayıt"
  },
  Event_6834_ChoiceDesc1 = {
    Text = "[Continue Questioning] Maks. HP’yi Arg1 kadar artır"
  },
  Event_6834_ChoiceDesc2 = {
    Text = "[Gölgeyi Yakala] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_6834_Desc = {
    Text = "Gölge, altın tozlar içinde ilahi sözler fısıldar:\n\"Gerçeği bilenler...\nAnahtar’ı Otorite edinenler, yolu gösterecek.\"\nKadim bir deyiş.\nİçgüdülerin bunun aradığın Gerçek’e çok yakın olduğunu söylüyor.\nVe içgüdülerin asla yanılmaz."
  },
  Event_6834_Name = {
    Text = "Gümüş Anahtar Taşıyıcısı"
  },
  Event_6835_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6835_Desc = {
    Text = "Çılgın mırıltılarla açıkça hemfikir olursun ve o çılgın varlığın cazibesine kapılarak, neredeyse kendini onun sofrasında bulursun."
  },
  Event_6835_Name = {Text = "Su Ayini"},
  Event_6836_ChoiceDesc1 = {
    Text = "[Call the Crow] 30 Kara Mühür al, [(Skill.Arg2)] becerisini geliştir ve seçim yapmaya devam et."
  },
  Event_6836_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_6836_Desc = {
    Text = "Sen gitmezsen, onlar da gitmez.\nTuhaf bir ip ruhlarınızı birbirine bağlıyor; sanki sana söylemek istedikleri bir şey var."
  },
  Event_6836_Name = {
    Text = "Sürüden Ayrılan Karga"
  },
  Event_6837_ChoiceDesc1 = {
    Text = "[Give Up Resistance] Bir Komut Kartını İmha Et ve Arg1 Kara Mühür elde et."
  },
  Event_6837_ChoiceDesc2 = {
    Text = "[Pull Back Hands]"
  },
  Event_6837_Desc = {
    Text = "Bir, iki, üç...\nYüzde, parmaklarda, sürüler hâlinde kelebekler gökyüzündeki havai fişekler gibi parlar; mücevherimsi ışıltıları Karanlık’ı deler.\nBu daktilonun pratik bir kullanımı yoktur, ama güzellik yaratma konusunda ustadır."
  },
  Event_6837_Name = {
    Text = "İlham Patlaması"
  },
  Event_6838_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6838_Desc = {
    Text = "Şu anda ilgilenmen gereken daha önemli meseleler var. Kutuyu kapatır, onu Görmezden Gelmeye kararlı olursun ve Daktilo yavaş yavaş susar."
  },
  Event_6838_Name = {
    Text = "Davetsiz Uyarı"
  },
  Event_6839_ChoiceDesc1 = {
    Text = "[Listen to the Moon] [(Skill.Arg1)] Semptomunu geliştir"
  },
  Event_6839_ChoiceDesc2 = {
    Text = "[Listen to the Dwarf Star] [(Skill.Arg1)] Semptomunu geliştir"
  },
  Event_6839_ChoiceDesc3 = {
    Text = "[Listen to the Meteor] 25 Kara Mühür kaybet"
  },
  Event_6839_Desc = {
    Text = "Hararetli, parlak, hiç bitmeyen."
  },
  Event_6839_Name = {
    Text = "Astral Harmonies"
  },
  Event_6840_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6840_Desc = {
    Text = "Parıltının özünde katılaşmış bir damla Gümüş vardır, ama aklın sana onun aslında parlamadığını söyler.\nBakışın ışığın kaynağını takip eder, fakat karanlık ve bilinmeyen tuzaklarla karşılaşırsın..."
  },
  Event_6840_Name = {
    Text = "Gece Parıltısı"
  },
  Event_6841_ChoiceDesc1 = {
    Text = "[Leave] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_6841_Desc = {
    Text = "Kuzey tarafı, kuzey çıkışı!\nRamona böyle karar verdiğine göre, kuzeyde mutlaka bir çıkış olmalı."
  },
  Event_6841_Name = {
    Text = "Kuzeye Doğru"
  },
  Event_6842_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6842_Desc = {
    Text = "Ah... o lekesiz gümüş, ruhunun sana oynadığı bir şaka.\nPeki, bir sonraki seçimin ne?"
  },
  Event_6842_Name = {
    Text = "Perde Açılıyor"
  },
  Event_6843_ChoiceDesc1 = {
    Text = "[Ayrıl] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_6843_Desc = {
    Text = "Başını sallayıp sesleri kenara itersin.\nZar zor duyulan bir iç çekiş, sana biraz yardım sunar."
  },
  Event_6843_Name = {
    Text = "Kuzeye Doğru"
  },
  Event_6844_ChoiceDesc1 = {
    Text = "[Proceed Deeper] [(Skill.Arg1)] Semptomunu geliştir"
  },
  Event_6844_ChoiceDesc2 = {
    Text = "[Go Against the Flow] 25 Kara Mühür al"
  },
  Event_6844_Desc = {
    Text = "Ay ışığı sönüyor, koridor tarafından yutularak geriye yalnızca uğursuz bir kapı bırakıyor."
  },
  Event_6844_Name = {
    Text = "Sessiz Salon"
  },
  Event_6845_ChoiceDesc1 = {
    Text = "[Proceed Deeper] [(EnchantConfig.Arg1)] Yakarışını rastgele bir Komut Kartına kazı."
  },
  Event_6845_ChoiceDesc2 = {
    Text = "[Go Against the Flow] 25 Kara Mühür al"
  },
  Event_6845_Desc = {
    Text = "Tam kavrayış olmadan, insan daha derine inmemelidir."
  },
  Event_6845_Name = {
    Text = "Sessiz Salon"
  },
  Event_6846_ChoiceDesc1 = {
    Text = "[Proceed Deeper] [(Skill.Arg1)] Semptomunu geliştir"
  },
  Event_6846_ChoiceDesc2 = {
    Text = "[Go Against the Flow] 25 Kara Mühür al"
  },
  Event_6846_Desc = {
    Text = "Soldaki kapı uğursuz bir kıkırtı saldı, hafifçe titreyerek ince ince kötülük lifleri döktü."
  },
  Event_6846_Name = {
    Text = "Sessiz Salon"
  },
  Event_6847_ChoiceDesc1 = {
    Text = "[Proceed Deeper] Gümüş Kalıntı [(RelicConfig.Arg1)]i elde et"
  },
  Event_6847_ChoiceDesc2 = {
    Text = "[Go Against the Flow] 25 Kara Mühür al"
  },
  Event_6847_Desc = {
    Text = "Sağdaki kapı açıktır; yerde, önceden belirlenmiş bir yolu izleyen Kan izleri sürünür."
  },
  Event_6847_Name = {
    Text = "Sessiz Salon"
  },
  Event_6848_ChoiceDesc1 = {
    Text = "[Leave] Burada artık senin için hiçbir şey kalmadı."
  },
  Event_6848_Desc = {
    Text = "İlla her zaman ileri atılman mı gerekir? Bir adım geri çekilmek, uçsuz bucaksız yeni bir dünyayı açığa çıkarabilir."
  },
  Event_6848_Name = {
    Text = "Sessiz Salon"
  },
  Event_6849_ChoiceDesc1 = {
    Text = "[Repair Wax Sculpture] Bir kart seç ve Arithmetica Maliyetini 1 azalt."
  },
  Event_6849_Desc = {
    Text = "\"Balmumu Heykel'in onarımı sürüyor.\nProfesyonel bir balmumu heykeltıraşı değilsin, ne de resmi bir estetik eğitimi aldın.\nYine de ustaca yoğurmaya, şekil vermeye, boyamaya başlıyorsun...\nSanki elinde bir keskiyle doğmuşsun.\nSanki kaderinde eksik kalmak, senin dokunuşunu beklemek varmış gibi.\""
  },
  Event_6849_Name = {
    Text = "Tamamlanmamış Balmumu Heykel"
  },
  Event_6850_ChoiceDesc1 = {
    Text = "[Repair Wax Sculpture] Bir kart seç ve Arithmetica Maliyetini 1 azalt."
  },
  Event_6850_Desc = {
    Text = "Galatea, Galatea...\nO sesi bir kez daha izleyerek, Tamamlanmamış Balmumu Heykel’i buldun.\nKusursuz görünüyordu, hatta rahatsız edici ölçüde.\n \"Çirkinlik, mükemmellikte açılan bir yaradır.\"\nSon anda, bir şey yapmaya karar verirsin."
  },
  Event_6850_Name = {
    Text = "Tamamlanmamış Balmumu Heykel"
  },
  Event_6851_ChoiceDesc1 = {
    Text = "[Fantazmayı Kabul Et] Rastgele 1 Komut Kartı Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_6851_ChoiceDesc2 = {
    Text = "[Deny the Illusion] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_6851_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_6851_Desc = {
    Text = "Ağır, karanlık demir köprünün altında, sazlarla kaplanmış sessiz bir nehir kıyısında, parıldayan bir kelebek aniden havalandı.\nKelebek usulca avucuna kondu. Dehşet verici ulumalar kesildi; yerlerini paslı raylarda ilerleyen bir trenin gümbürtüsü, yanan kömürün çıtırtısı ve dönen dingillerin metalik çığlığı aldı..."
  },
  Event_6851_Name = {
    Text = "Demiryolu Serabı"
  },
  Event_6852_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6852_Desc = {
    Text = "Evet, kaçıyorsun, bir yaratık seni kovalıyor. Hayatta Kalma İçgüdüsü’n seni, çıkış kalmayana dek umutsuzca koşturuyor. Dur, bu böyle olmamalı... Kaçış Yok bırakanlar Cehennem Köpekleri değil miydi?"
  },
  Event_6852_Name = {Text = "Koş"},
  Event_6853_ChoiceDesc1 = {
    Text = "[This Isn't Real] Gümüş Kalıntı [(RelicConfig.Arg1)]yı elde et"
  },
  Event_6853_ChoiceDesc2 = {
    Text = "[Falling, falling...] Altın Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" becerisini geliştir"
  },
  Event_6853_Desc = {
    Text = "Yerdeki yansımaların çerçeveleri girift; çerçeve içinde çerçeve, çerçeve içinde çerçeve...\nAlice aşağı atlar ve sonsuz tavşan deliğinde düşmeye devam eder, birbiri ardına yansımalar, birbiri ardına ruhlar görür; hepsi hapsolmuştur, kendini göremez."
  },
  Event_6853_Name = {
    Text = "Ayna İçinde Ayna"
  },
  Event_6854_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6854_Desc = {
    Text = "Karla kaplı pencereden Karlı Dağ’a bakıyorsun, birçok siyah karınca tek bir siyah karıncayı kovalıyor...\nDüşünce zincirin kopuyor."
  },
  Event_6854_Name = {
    Text = "Yanardağ Anısı"
  },
  Event_6855_ChoiceDesc1 = {
    Text = "[Step Forward and Grip] %100 ihtimalle 25 Kara Mühür kazan."
  },
  Event_6855_ChoiceDesc2 = {
    Text = "[Friendly Response] %50 ihtimalle 50 Kara Mühür kazan, %50 ihtimalle hiçbir şey kazanma."
  },
  Event_6855_Desc = {
    Text = "Bilinmeyen kökenli bir kedi, D-balçığın arasında oturuyor; bulanık bedeni, Ruhsal Boyut’a ait olduğunu fısıldıyor.\nBu silik Yansıtma, bilge gözlerle Ramona’ya bakıyor, beyaz patisini kaldırıp onu çağırıyor."
  },
  Event_6855_Name = {
    Text = "Gezinen Sakin"
  },
  Event_6856_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6856_Desc = {
    Text = "Canlı bir grup portresi.\nBalmumu Heykeller süslenmiş, sıra sıra oturtulmuş, hepsinin yüzünde aynı abartılı gülümseme var.\nHerhangi bir tımarhanede görebileceğin kadar uyumlu görünüyorlar.\n\nTarih: A.F. 305, @2 Rogers"
  },
  Event_6856_Name = {
    Text = "Portre Galerisi"
  },
  Event_6857_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6857_Desc = {
    Text = "\nParçaları dikkatle yerden alır, yakından incelersin. Yine hareketsizdir.\n\"Şu sakar ellerine dikkat et, öyle oynatma,\" diye başının arkasına hafifçe vurur Bebek, \"sana kısa sürede ikinci bir parça çıkaramam.\""
  },
  Event_6857_Name = {
    Text = "Huzursuz Broş"
  },
  Event_6858_ChoiceDesc1 = {Text = "[Use Key]"},
  Event_6858_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6858_Desc = {
    Text = "Bir kapı yolunu kesiyor. Her yöntemi denedin, yine de dimdik yerinde duruyor."
  },
  Event_6858_Name = {
    Text = "Paslı Kapı"
  },
  Event_6858_Tips1 = {
    Text = "\"Paslı Anahtar\"ı bulman gerekiyor."
  },
  Event_6859_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6859_Desc = {
    Text = "Hızına utandın.\nNitelikli bir Koruyucu titiz olmalıdır; onların \"üst düzey Ödüller\" olmadıklarına öylece hükmetmemelisin.\nBu yüzden onları dikkatle gözlemlemeye karar verdin. Beş dakika geçti, on dakika geçti...\nPekâlâ, artık bir yargıya varabilirsin—\nGerçekten de çöp bunlar."
  },
  Event_6859_Name = {Text = "Tutsak Ruh"},
  Event_6860_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6860_Desc = {
    Text = "Sen ve yoldaşların silahlarınızı yere bırakırsınız.\nBu, merhametten değildir; zayıf bedenlerinin uzun süre dayanamayacağını bilirsin.\nHaklı çıktığın ortaya çıkar."
  },
  Event_6860_Name = {Text = "Taslak"},
  Event_6861_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6861_Desc = {
    Text = "\n \"Haydi yakala beni!\"\n \"Haydi ama, ahmak!\"\n \"Yapabiliyorsan yakala bizi!\"\nÇocukların sesleri gururla doluydu.\n \"Lanet olsun! Olduğunuz yerde durun!\"\nYetişkinin sesi nefes nefeseydi."
  },
  Event_6861_Name = {
    Text = "Anılarımız"
  },
  Event_6862_ChoiceDesc1 = {
    Text = "[Enter] Sise bata çıka ilerleyerek diğer tarafa ulaş."
  },
  Event_6862_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6862_Desc = {
    Text = "Aradığın kişi işte burada. Görevi Tamamladın."
  },
  Event_6862_Name = {
    Text = "Tek Yönlü Geçit 26"
  },
  Event_6863_ChoiceDesc1 = {
    Text = "[Leave] [(RelicConfig.Arg1)] Gümüş Kalıntıyı edin"
  },
  Event_6863_Desc = {
    Text = "Ah! Kıl payı kaçtı! Bekle, üç zar nasıl on attı?\nZarlar önünde sessizce yatıyor, masum ve uslu görünüyorlar."
  },
  Event_6863_Name = {
    Text = "Eternal Gamble"
  },
  Event_6864_ChoiceDesc1 = {
    Text = "[Leave] Altın Kalıntı [(RelicConfig.Arg1)]yı elde et"
  },
  Event_6864_Desc = {
    Text = "Lanet olsun! Saat altı değil, ama hâlâ çıkarılacak biraz kâr var.\nPeki, tam olarak saat kaç?"
  },
  Event_6864_Name = {
    Text = "Eternal Gamble"
  },
  Event_6865_ChoiceDesc1 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_6865_Desc = {
    Text = "Her ne kadar doğru tahmin edememiş olsam da, bunu kabullenebilirim.\nİç çekiş... Ne zaman oylama yaptılar?"
  },
  Event_6865_Name = {
    Text = "Eternal Gamble"
  },
  Event_6866_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6866_Desc = {
    Text = "Başını eğip alçı parçalarını toplarsın, onu yavaş yavaş yeniden birleştirirsin. Ellerin altında bedeninin bir kısmı yavaşça şekil kazanır."
  },
  Event_6866_Name = {
    Text = "Patchwork Remains"
  },
  Event_6867_ChoiceDesc1 = {
    Text = "[Pick Up Key]"
  },
  Event_6867_Desc = {
    Text = "Paslı anahtarların bir demeti. Kapıları açmak için kullanılabilir."
  },
  Event_6867_Name = {
    Text = "Paslı Anahtar"
  },
  Event_6868_ChoiceDesc1 = {
    Text = "[Silver Chip] %50 ihtimalle Altın Kalıntı \"(RelicConfig.Arg2)\" elde et, %50 ihtimalle \"(Skill.Arg3)\" geliştir."
  },
  Event_6868_ChoiceDesc2 = {
    Text = "[Red Chip] %50 ihtimalle 75 Kara Mühür al, %50 ihtimalle [(Skill.Arg3)] Semptomunu geliştir."
  },
  Event_6868_ChoiceDesc3 = {
    Text = "[Let Them Choose] %50 ihtimalle Lanetli Kalıntı \"(RelicConfig.Arg2)\" elde et, %50 ihtimalle \"(Skill.Arg3)\" geliştir."
  },
  Event_6868_Desc = {
    Text = "Bu sadece bir bahis. Kaybetmeyeceksin.\nÜzerine girift desenler işlenmiş madeni para havaya fırlatılır, hızla aşağı süzülür ve avucunda ısınır."
  },
  Event_6868_Name = {
    Text = "Notorious Gambler"
  },
  Event_6869_ChoiceDesc1 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_6869_Desc = {
    Text = "\"Kaderin lütfuna güvenenler, onun tarafından altüst edilmeye de mahkûmdur.\"\nGitmeyi seçersin."
  },
  Event_6869_Name = {
    Text = "Notorious Gambler"
  },
  Event_6870_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6870_Desc = {
    Text = "\"Muhafız.\"\nRamona’nın sesi seni kendine getirir, ama düşüş hissi dağılmaz."
  },
  Event_6870_Name = {
    Text = "Ayna İçinde Ayna"
  },
  Event_6871_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6871_Desc = {
    Text = "Derler ki serenatlar, aşktan doğan şarkılardır.\nYaz gecelerinde, bir âşığın penceresinin önünde, insanlar bu ince ezgileri birlikte çalar.\nGündelik ve yüzeysel, Rogers’ın zevkine pek uymazlar, yine de repertuvarında yerlerini korurlar.\nBelki de nedenini yalnızca o bilir."
  },
  Event_6871_Name = {
    Text = "Kötü Zevk"
  },
  Event_6872_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6872_Desc = {
    Text = "\nOnların fısıltılarına kapılmayı reddediyorsun.\n“Yalancı!” dedin. “Zifiri karanlık ebedi gecede hapsolmuşsun. Evreni nasıl kat edebilirsin?”\nGözler güldü. Sayısız kahkaha devasa bir kükremede birleşti, yüreğinin titremesine neden oldu.\nGözler şöyle dedi: “Diğer gözleri yağmalayarak. Her göz bir evrendir. Bin göze sahip olduğunda, gerçek bir zaman ve mekân yolculuğuna çıkacaksın.”"
  },
  Event_6872_Name = {Text = "Göz"},
  Event_6873_ChoiceDesc1 = {
    Text = "[Receive] 3 Altın Kalıntıdan 1’ini Edin"
  },
  Event_6873_Desc = {
    Text = "Evet, o iğrenç yansıma sensin.\nKabarıp taşan kin, ayaklarının dibindeki kara sümükle birleşerek birlikte bükülüp dans eder. Sakıncası yoksa, omzuna da tırmanmak ister."
  },
  Event_6873_Name = {
    Text = "Under-Mirror"
  },
  Event_6874_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6874_Desc = {
    Text = "Çok geçmeden, bağlar aniden gevşedi ve sendelemeni sağladı.\nSessiz ipliklere dönüp baktın—“Kum saatini rahatsız etme” sözü, belki de Alan’da da geçerlidir."
  },
  Event_6874_Name = {
    Text = "Saplanmış"
  },
  Event_6875_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6875_Desc = {
    Text = "Gnosis’in Ateşi alevlenir, tüm bağları yakıp kül eder—\nEn azından, sen buna inanıyorsun."
  },
  Event_6875_Name = {
    Text = "Saplanmış"
  },
  Event_6876_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6876_Desc = {
    Text = "Tüm gücünle kurtulmaya çalışırsın. İplikler giysilerini yırtar, teninde ince kesikler bırakır.\nAğ, senden bedel alsa da, içini bir ferahlık kaplar—artık özgürsün."
  },
  Event_6876_Name = {
    Text = "Saplanmış"
  },
  Event_6877_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6877_Desc = {
    Text = "Çözünme çıkıntısının ürettiği mektubun çoğu bilgisi genellikle silinmiş olur.\nİçinden kayda değer hiçbir bilgi çıkaramayınca mektubu parçalara ayırıp etrafa saçtın."
  },
  Event_6877_Name = {
    Text = "Kelebek Bölümü"
  },
  Event_6878_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6878_Desc = {
    Text = "Sözcükler kasten silinmiş olsa bile, mektubun değerini hâlâ berrak bir şekilde hissedebiliyorsun."
  },
  Event_6878_Name = {
    Text = "Kelebek Bölümü"
  },
  Event_6879_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6879_Desc = {
    Text = "Tedbiri elden bırakmamak en iyisi.\nRamona çömeldi, koridora geri döndü ve gizlice bir sonraki odaya süzüldü."
  },
  Event_6879_Name = {
    Text = "Penceredeki Yansıma"
  },
  Event_6880_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6880_Desc = {
    Text = "Umutsuz bir çığlık salıverirsin.\nSesine çekilmiş gibi görünen karga sürüsü hızla kaybolur ve geride karanlık izler bırakır."
  },
  Event_6880_Name = {
    Text = "Song of Crows"
  },
  Event_6881_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6881_Desc = {
    Text = "Bedenini büküp kıvırıyor, kendini küçücük siyah bir noktaya sıkıştırmaya çalışıyorsun.\nBelki seni fark etmezler.\nBir süre sonra gözlerini açıyorsun.\nIşığı görüyorsun."
  },
  Event_6881_Name = {
    Text = "Song of Crows"
  },
  Event_6882_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6882_Desc = {
    Text = "Gölge, parmaklarımın arasından usulca süzülür, ardında altın tozdan bir iz bırakır."
  },
  Event_6882_Name = {
    Text = "Gümüş Anahtar Taşıyıcısı"
  },
  Event_6883_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6883_Desc = {
    Text = "Saçlarını hoyratça karıştırırken, zihninden vahşi hayaller ve sanrılar fırtına gibi geçiyor; derinlerde, siyah ve sümüksü pıhtılar saklı.\nOnu parçalara ayırırsan, nasıl bir armağan alacaksın?"
  },
  Event_6883_Name = {
    Text = "Zihin Çalkantısı"
  },
  Event_6884_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6884_Desc = {
    Text = "Renkli yağ lekeleri yavaşça Görüş Alanını doldurur, duygularını kaotik bir şenliğe sürükler."
  },
  Event_6884_Name = {
    Text = "Zihin Çalkantısı"
  },
  Event_6885_ChoiceDesc1 = {Text = "[Take It]"},
  Event_6885_Desc = {
    Text = "D-balçıktan arıtılmış, neredeyse cıva benzeri bir Gümüş madde; güçlü zihinsel güç barındırır ve ayinlerde daha fazla Uyanan’ı birbirine bağlamak için kullanılır D-balçıktan arıtılmış, neredeyse cıva benzeri bir Gümüş madde; güçlü zihinsel güç barındırır ve ayinlerde daha fazla Uyanan’ı birbirine bağlamak için kullanılır."
  },
  Event_6885_Name = {Text = "Gümüş"},
  Event_6886_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6886_Desc = {
    Text = "Kutuya kahkaha dolar ve sıcak parıltı söndüğünde, üzerinde üç çöp adamın olduğu bir kart görürsün: sen, gümüş saçlı Ramona ve sarı saçlı Ogier. Yanında şu satır yazılıdır:\n\"Hepinize teşekkürler!\""
  },
  Event_6886_Name = {
    Text = "İyi Niyetin Hediyesi"
  },
  Event_6887_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6887_Desc = {
    Text = "Bedenin kelebek sürüsünden sıyrıldı, ama onlar hedeflerini yitirmedi. Bavuluna sızıp daktilo’ndan sızan mürekkebi açgözlülükle emdiler."
  },
  Event_6887_Name = {
    Text = "Sanrı Patlaması"
  },
  Event_6888_ChoiceDesc1 = {
    Text = "[Hatayı Göster] 1 Komut Kartı seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_6888_ChoiceDesc2 = {
    Text = "[Listen to the Performance] 50 veya daha fazla Aliemus’a sahip her Uyandırıcı için 15 Kara Mühür al."
  },
  Event_6888_ChoiceDesc3 = {
    Text = "[Leave] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_6888_Desc = {
    Text = "Balmumu Heykel Oğlan piyanonun başına oturmuş, alıştırma yapıyor.\nÖğretmeni—o da bir Balmumu Heykel—hemen yanında ona rehberlik ediyor.\n133, 355, 244...\nYanlış, her nota yanlış."
  },
  Event_6888_Name = {
    Text = "Piyano Dersi"
  },
  Event_6889_ChoiceDesc1 = {
    Text = "[Give Up Resistance] Bir Komut Kartını İmha Et ve Arg1 Kara Mühür elde et."
  },
  Event_6889_ChoiceDesc2 = {
    Text = "[Pull Back Hands]"
  },
  Event_6889_Desc = {
    Text = "İçindeki dürtüye karşı koyamıyorsun.\nParmakların, ormanda kaybolmuş çocuklar gibi klavyenin üzerinde gezinip oynuyor...\nYavaş yavaş, daktilodan kelebekler belirmeye başlıyor.\nBir, iki, üç...\nYüzünde, parmaklarında, kelebek sürüleri havai fişekler gibi parıldıyor, karanlıkta mücevherler gibi ışıldıyor.\nBu daktilonun pratik bir işlevi yok, ama güzellik yaratma konusunda tam bir usta."
  },
  Event_6889_Name = {
    Text = "İlham Patlaması"
  },
  Event_6890_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6890_Desc = {
    Text = "\nKâğıdı koyu kırmızı ışığa doğru kaldırdın, en ufak bir ayrıntıyı kaçırmaktan korkarak.\nBu bir sağlık raporuydu ve muayene edilen kişi Mason'dı.\n\"Ağırlık 40 kg, kan oksijen seviyesi normal, Afinite %30, Rezonans değeri...\"\nOkumaya devam etmek istedin, ama yazılar yavaş yavaş silinip gitti.\nSanki hiçbir şey hiç yaşanmamış gibi tertemizdi."
  },
  Event_6890_Name = {Text = "Daktilo"},
  Event_6891_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6891_Desc = {
    Text = "Evet, sen kaçmıyorsun; belirli bir hedefi kovalıyorsun—nemli, dar, karla kaplı ara sokaklardan fırlayıp giden \"Cehennem Köpeği\" ni. Bunu unutmayacaksın; tıpkı o gün Tunguska’daki harabelerden seni çekip çıkaran kişinin yüzünü unutmayacağın gibi... Kimdi o yine?"
  },
  Event_6891_Name = {Text = "Koş"},
  Event_6892_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6892_Desc = {
    Text = "Her şeyden yalıtılmış bu boşlukta, yalnızca kendine güvenebilirsin."
  },
  Event_6892_Name = {
    Text = "Kâbus Yolcusu"
  },
  Event_6893_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6893_Desc = {
    Text = "Kriz ve risk yan yanadır. Demir kilide dokunduğun an, aşındırıcı sümüksü sıvı avucunu yakar. Umarız kapının ardındaki kalıntı buna değiyordur."
  },
  Event_6893_Name = {
    Text = "Behind Iron Gates"
  },
  Event_6894_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6894_Desc = {
    Text = "Haritasız dünyalarda pervasızca dolaşırken, kırılgan akıl sağlığın henüz muhakemeni yitirecek kadar bozulmamış.\nBilinmeyenin dehşeti, en derinlerinden kavradığın bir şey."
  },
  Event_6894_Name = {
    Text = "Kâbus Yolcusu"
  },
  Event_6895_ChoiceDesc1 = {
    Text = "[Loud Shout] Gümüş Kalıntı \"(RelicConfig.Arg1)\"i elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_6895_ChoiceDesc2 = {
    Text = "[Embrace Silence] Altın Kalıntı \"(RelicConfig.Arg1)\"i elde et, fakat \"(Skill.Arg2)\" ve \"(Skill.Arg3)\" geliştir."
  },
  Event_6895_ChoiceDesc3 = {
    Text = "[Surface] 25 Kara Mühür al"
  },
  Event_6895_Desc = {
    Text = "Sessizliği duyuyorsun.\nDalgaların sesi gibi büyütülmüş bir sessizlik, tüm mekânı dolduruyor.\n\nBaşını kaldırıyor, yıldızlara bakan küçücük bir nokta gibi yukarı bakıyorsun."
  },
  Event_6895_Name = {
    Text = "Lethe'nin Akışı"
  },
  Event_6896_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6896_Desc = {
    Text = "Kulaklarını dikersin, sesin kaynağını arar, baş belasını yakalamaya çalışırsın.\nAma bu kasıtlı bir oyun gibi gelir. Onu köşeye sıkıştırdığını sandığın anda, kendini yine başladığın yerde bulursun.\nSinirle bir tuğla duvara tekme atarsın; yerinden oynayan bir tuğla, içinde saklı parıltılı bir sırrı açığa çıkarır."
  },
  Event_6896_Name = {
    Text = "Yitik Yankı"
  },
  Event_6897_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6897_Desc = {
    Text = "Bu mutlaka bir oynatma sorunu, öyle olmak zorunda.\nŞüpheyle iğneyi geri sararsın, berbat ilk yarıya katlanırsın, ama o tanıdık tıklama sesi bir türlü gelmez.\nArdında, boşluğun içinde, yerdeki küçük bir gölge sessizce sıvışıp gider."
  },
  Event_6897_Name = {
    Text = "Yitik Yankı"
  },
  Event_6898_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6898_Desc = {
    Text = "Etrafında kimse yok. Tıkırtının sırrı mutlaka gramofonun içindeki düzende saklı.\nYargına güvenerek eski gramofonu söküyorsun.\nAşınmış metal parçalar ve kalın bir toz tabakasından başka hiçbir şey bulamıyorsun.\nSadece hafif bir kıkırdama, rüya kadar incecik, sise karışıp kayboluyor."
  },
  Event_6898_Name = {
    Text = "Yitik Yankı"
  },
  Event_6899_ChoiceDesc1 = {
    Text = "[Fool's White Matter] Arg1 YP Kurtar"
  },
  Event_6899_ChoiceDesc2 = {
    Text = "[Madman's Heart] Rastgele bir Komut Kartına [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_6899_ChoiceDesc3 = {
    Text = "[Refuse to Eat] 25 Kara Mühür al"
  },
  Event_6899_Desc = {
    Text = "\"Aptal’ın beyaz cevheri, kaynayan balık çorbası kadar lezzetli; delinin kalbiyse sıcak, kanlı bir çörek gibi fırınlanmış.\"\nGölge şeytani bir sırıtışla gülümsedi ve sana, içinde Bilinmeyen Yaratık malzemeler barındıran bir tabak uzattı.\nDerin bir nefes aldın; bunaltıcı koku burun deliklerine zorla hücum etti. Aşağılanmanın doruğundaki tükürük bezlerin önce teslim oldu; miden acıyla büküldü ve Arzu dolu inleyen bir homurtu salıverdi."
  },
  Event_6899_Name = {
    Text = "Flesh Banquet"
  },
  Event_6900_ChoiceDesc1 = {
    Text = "[Touch Wind Chime] Rastgele bir Komut Kartına \"(EnchantConfig.Arg2)\" Yakarışını kazı, ancak \"(Skill.Arg1)\" geliştir."
  },
  Event_6900_ChoiceDesc2 = {
    Text = "[Observe Wind Chime] Rastgele bir Komut Kartına \"(EnchantConfig.Arg2)\" Yakarışını kazı, ancak \"(Skill.Arg1)\" geliştir."
  },
  Event_6900_ChoiceDesc3 = {
    Text = "[Do Nothing] Rastgele bir Komut Kartına [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_6900_Desc = {
    Text = "Ding ding, ding ding...\nBu, paslı bir rüzgâr çanı; beceriksiz notalar aralıklardan süzülerek dolaşıyor."
  },
  Event_6900_Name = {
    Text = "Rusted Chime"
  },
  Event_6901_ChoiceDesc1 = {
    Text = "[Wait and See] Hayatta Kalmaya Çalış"
  },
  Event_6901_ChoiceDesc2 = {
    Text = "[Swing Weapon] Yarılmayı Denemeye Çalış"
  },
  Event_6901_ChoiceDesc3 = {
    Text = "[Hold a Hand] 25 Kara Mühür al"
  },
  Event_6901_Desc = {
    Text = "Ayaklarının altında aniden siyah bir bataklık beliriyor, içinden sayısız el yükseliyor.\nTavuskuşu mavisi, pullu ya da gözlü… türlü renk, doku ve maddeden oluşan bu eller, sayısız Boyut ve uzamı aşmış gibi, bir sonraki talihsiz ruhu ailelerine sürüklemeye çalışıyor.\nSen ise şöyle yapmaya karar veriyorsun—"
  },
  Event_6901_Name = {
    Text = "Kasvet Bataklığı"
  },
  Event_6902_ChoiceDesc1 = {
    Text = "[Hold it] 3 Komut Kartından 1’ini Çoğalt"
  },
  Event_6902_ChoiceDesc2 = {
    Text = "[Hafifçe Salla] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_6902_ChoiceDesc3 = {
    Text = "[Do Nothing] 25 Kara Mühür al"
  },
  Event_6902_Desc = {
    Text = "Ding ding, ding ding...\nBu, paslı bir rüzgâr çanı; beceriksiz notalar aralıklardan süzülerek dolaşıyor."
  },
  Event_6902_Name = {Text = "Minik Çan"},
  Event_6903_ChoiceDesc1 = {
    Text = "[Counter Them] Gümüş Kalıntı [(RelicConfig.Arg1)]i elde et, fakat 3 Semptomdan 1’ini geliştir."
  },
  Event_6903_ChoiceDesc2 = {
    Text = "[Follow Them] 3 Komut Kartından 1’ine Yadigâr \"(EnchantConfig.Arg1)\"i kazı, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_6903_ChoiceDesc3 = {
    Text = "[Suggest New Idea] 25 Kara Mühür al"
  },
  Event_6903_Desc = {
    Text = "\n \"Lütfen bizden uzak dur.\"\nBir sıçan sürüsü seni sardı, arada en az beş ayaklık mesafeyi koruyarak.\n \"Çoğalmaya çabalar, serpiliriz; seçici değilizdir—bu yüzden insanlığın Işığına hastalık, huzursuzluk ve acı getiririz.\"\n \"İnsanlara fazla yaklaşmamalıyız; burası sizin için bir yer değil.\"\nSıçanların gardını indirmesini sağlamak için, karar verdin ki—"
  },
  Event_6903_Name = {Text = "Veba"},
  Event_6904_ChoiceDesc1 = {
    Text = "[Descend Further] [(Skill.Arg1)] Semptomunu geliştir"
  },
  Event_6904_ChoiceDesc2 = {
    Text = "[Pull Away] 25 Kara Mühür al"
  },
  Event_6904_Desc = {
    Text = "\"Sen\" seni daha derine davet ediyor.\nSarmalın derinliklerinde, geçmişteki ve gelecekteki \"sen\" sana farklı boyutlardan \"hediyeler\" gönderiyor."
  },
  Event_6904_Name = {Text = "Uçurum"},
  Event_6905_ChoiceDesc1 = {
    Text = "[Pin Down the Crow] 40 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_6905_ChoiceDesc2 = {
    Text = "[Ignore It] 25 Kara Mühür elde et ve ayrıl."
  },
  Event_6905_Desc = {
    Text = "Yalnız karga, kısık ve boğuk sesiyle, siyah kanatlarını tek tek yoluyor.\nAcıyla titriyor, tiz çığlıklar atıyor, ama giderek çılgınlaşan hızını durduramıyor.\n\"Gaak—Gaak—\"\nGözlerinden, yalnızca senin tanık olduğun, siyah sümüksü sıvıyla karışmış mavi yaşlar süzülüyor."
  },
  Event_6905_Name = {
    Text = "Erimiş Gözyaşı"
  },
  Event_6906_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6906_Desc = {
    Text = "Kızıl, tutkulu, canlı ve çarpıcı. Böyle bir güzelliği tesadüfen tanıyorum; zamanı gelince sen de onunla karşılaşacaksın.\nPeki, bir sonraki seçimin ne?"
  },
  Event_6906_Name = {
    Text = "Perde Açılıyor"
  },
  Event_6907_ChoiceDesc1 = {
    Text = "[Loud Cheer]"
  },
  Event_6907_ChoiceDesc2 = {Text = "[Drowsy]"},
  Event_6907_Desc = {
    Text = "Uzun bir Rüya gördün.\nRüyada seyirciler arasındaydın, sahnede şarkı söyleyen bir oğlanı izliyordun.\n \"Yaşlı Charlie’nin çok sevdiği bir tekir kedisi vardı.\nO kaybolduğunda, onu her yerde aradı.\"\n.....\nBoş, kuru bir ses, mekanik bir şekilde, durmaksızın tekrarlıyordu."
  },
  Event_6907_Name = {
    Text = "Son Perde IV"
  },
  Event_6908_ChoiceDesc1 = {
    Text = "[Unravel the Upper Branch]"
  },
  Event_6908_ChoiceDesc2 = {
    Text = "[Unravel the Lower Branch]"
  },
  Event_6908_Desc = {
    Text = "Diyar’da kalan Gnosis birbirine bağlanır, dolaşarak kararsız bir kuvvet alanına dönüşür.\nBelki de Gnosis’i çözerek kendine ilerleyecek bir yol açabilirsin."
  },
  Event_6908_Name = {
    Text = "Dolanık Yol"
  },
  Event_6909_ChoiceDesc1 = {
    Text = "[Leave] 2 Uyandırıcıyı Uyanışa Çağır"
  },
  Event_6909_Desc = {
    Text = "\nAyağa fırladın ve kapıya doğru koştun.\n\"Örtü bezini kaldırdın...\nBir sır, bir sır keşfettin...\"\nKükreme kakofonik bir okyanusta toplandı, zemin dehşet verici bir rezonansla şiddetle sarsıldı.\nArkaya bakmaya cesaret edemedin ve oradan olabildiğince hızlı kaçtın."
  },
  Event_6909_Name = {
    Text = "Son Perde V"
  },
  Event_6910_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6910_Desc = {
    Text = "Ne direniyorsun ne de kendini bütünüyle bırakıyorsun."
  },
  Event_6910_Name = {
    Text = "Kafatası Yarası"
  },
  Event_6911_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6911_Desc = {
    Text = "Direnmeyi bıraktın, pisliğin bedenini ve ruhunu yutmasına izin verdin. Uzun bir Hafif Uyku’nun ardından, gümüş ışık kenetli ellerine düştü."
  },
  Event_6911_Name = {
    Text = "Kafatası Yarası"
  },
  Event_6912_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6912_Desc = {
    Text = "Ne kadar çok çırpınırsan, pislik zihnine o kadar derine işler. Günahla ağırlaşmış bir beynin derinliklerine gömülü, esrarengiz bir armağan yatıyor."
  },
  Event_6912_Name = {
    Text = "Kafatası Yarası"
  },
  Event_6913_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6913_Desc = {
    Text = "Ağ yırtılırken zihninde bir şey çakar—sanki birkaç Çocuğun gülümseyen yüzleri."
  },
  Event_6913_Name = {
    Text = "Vagus Ağı"
  },
  Event_6914_ChoiceDesc1 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_6914_Desc = {
    Text = "Kedi memnuniyetle başını sallar, ardından gölgeye karışıp yok olur; geride birkaç siyah, dairesel nesne bırakır."
  },
  Event_6914_Name = {
    Text = "Gezinen Sakin"
  },
  Event_6915_ChoiceDesc1 = {
    Text = "[Read the Letter] Bir Komut Kartı İmha Et ve Arg1 Kara Mühür al."
  },
  Event_6915_ChoiceDesc2 = {
    Text = "[Close the Box]"
  },
  Event_6915_Desc = {
    Text = "Kanat çırpan harfler gökyüzünü doldurur, sessiz bir telkin gibi."
  },
  Event_6915_Name = {
    Text = "Davetsiz Mektup"
  },
  Event_6916_ChoiceDesc1 = {
    Text = "[Enter] Sise bata çıka ilerleyerek diğer tarafa ulaş."
  },
  Event_6916_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6916_Desc = {
    Text = "İlerideki yolda, siyah sisle dolu gizli bir tünel belirir. Gittiği yer bilinmeyendir."
  },
  Event_6916_Name = {Text = "Tünel"},
  Event_6917_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6917_Desc = {
    Text = "Onun acısına son vermeye karar verirsin, yumuşak bedenini kavramak için elini uzatır, sıkarsın... sıkarsın...\nAvucunun içinde umutsuzca çırpınır, sonunda sıcak bir sıvı sıçramasına dönüşerek patlar."
  },
  Event_6917_Name = {
    Text = "Erimiş Gözyaşı"
  },
  Event_6918_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6918_Desc = {
    Text = "Endişelenme, bunlar sadece Boyut içindeki başkalarına ait Anıların parçaları. Bir gölgen var. Ama gölgedeki kişi gerçekten hâlâ sen misin?"
  },
  Event_6918_Name = {
    Text = "Hafıza Kırık Parçası: Bira"
  },
  Event_6919_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6919_Desc = {
    Text = "Karganın gagasını, kendi Kanatlar’ını yolmaktan zorla uzaklaştırırsın, ama o inatla geri bükülür; gücü, kemiklerinin Gıcırtı ile sızlamasına neden olur.\nYüzün kıpkırmızı kesilir, tüm gücünü kullanarak karganın bedenini zapt eder, çılgınca öz-yok edişini durdurursun.\nTam derin bir nefes alıp rahatlayacakken, karganın yarı kel boynu birdenbire sertçe geriye kırılır; bedeni gevşer ve ellerinin arasında siyah bir çamur gölüne dönüşür."
  },
  Event_6919_Name = {
    Text = "Erimiş Gözyaşı"
  },
  Event_6920_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6920_Desc = {
    Text = "O umutsuz çalmaları soğukkanlılıkla görmezden geldin.\nBir sonraki saniye ilkel dünyaya geri savrulacak olsan bile, sen ve büyük görevin birlikte gömülecek olsan bile.\nCevaplanmaması gereken bir çağrı, basitçe cevaplanamaz.\nBu basit gerçeği çok iyi biliyorsun."
  },
  Event_6920_Name = {
    Text = "Çağrıya Cevap"
  },
  Event_6921_ChoiceDesc1 = {
    Text = "[Lower Gaze] 25 Kara Mühür al"
  },
  Event_6921_ChoiceDesc2 = {
    Text = "[I Must Find It] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ama \"(Skill.Arg2)\" geliştir."
  },
  Event_6921_Desc = {
    Text = "\nGölgeyi ileri doğru kovalarken aniden sığ bir su birikintisine basarsın. Renksiz sıvı ayakkabılarını ıslatır, iliklerine işleyen bir soğuk gönderir.\nSuyun içinden bir ses konuşur: \"Bunu öğrenmek istemezsin.\""
  },
  Event_6921_Name = {
    Text = "Aramaman Gereken Şey"
  },
  Event_6922_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6922_Desc = {
    Text = "Güvenli bir seçim."
  },
  Event_6922_Name = {
    Text = "Haystack's Leeward"
  },
  Event_6923_ChoiceDesc1 = {
    Text = "[Chase the Crows] Arg1 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_6923_ChoiceDesc2 = {
    Text = "[Disregard] 25 Kara Mühür al ve ayrıl."
  },
  Event_6923_Desc = {
    Text = "Akıl hastanesindeki odada kargalar ne arıyor?\nAma kahkahalarını açıkça duyuyorsun. Görünmeyen bir güç, boş kuş gözlerinden, gölgelerin içinden seni izliyor. Bu siyah yaratıklar, sokak lambalarına tünemiş, boyunlarını bükerek sana kötü kötü bakıyor. Üst üste binmiş başları, D-balçığa gömülü tek bir bedeni paylaşıyormuş gibi görünüyor."
  },
  Event_6923_Name = {
    Text = "Fener Kargası"
  },
  Event_6924_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6924_Desc = {
    Text = "Pislikten korkma; ondan kaybettiğinden fazlasını kazanırsın."
  },
  Event_6924_Name = {
    Text = "Haystack's Leeward"
  },
  Event_6925_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6925_Desc = {
    Text = "Gnosis fırtınası Tulu’yu kuşatıyor. Onunla göz göze gelirsin ve peş peşe Karanlık’a adım atarsınız."
  },
  Event_6925_Name = {
    Text = "Elçi'nin Sözü"
  },
  Event_6926_ChoiceDesc1 = {
    Text = "[Enter] Sise bata çıka ilerleyerek diğer tarafa ulaş."
  },
  Event_6926_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6926_Desc = {
    Text = "Karanlığa düşersin.\nGörüş alanının kenarında, anahtar deliğini andıran bir yarıktan ince bir ışık sızar.\nGümüş Anahtar, seni Gizli Geçit’e yönlendiren hafif bir parıltı yayar."
  },
  Event_6926_Name = {
    Text = "Tek Yönlü Geçit"
  },
  Event_6927_ChoiceDesc1 = {
    Text = "[Infect \"(Skill.Arg1)\", acquire Relic: \"(RelicConfig.Arg2)\"]"
  },
  Event_6927_ChoiceDesc2 = {
    Text = "[Choose 1 out of 3 Command Cards to gain the Orison: \"(EnchantConfig.Arg1)\"]"
  },
  Event_6927_Desc = {
    Text = "Olay 203 (Geliştirme Aşamasında), Son Etki Değil"
  },
  Event_6927_Name = {
    Text = "Olay 203 (Geliştirme Aşamasında)"
  },
  Event_6928_ChoiceDesc1 = {
    Text = "[Patch Her Up] Bir Komut Kartını İmha Et ve [(RelicConfig.Arg1)] adlı Kalıntıyı edin."
  },
  Event_6928_ChoiceDesc2 = {
    Text = "[Touch] Bir Darbe ya da Savunma kartını İmha Et ve 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_6928_ChoiceDesc3 = {
    Text = "[Disgust] 25 Kara Mühür al"
  },
  Event_6928_Desc = {
    Text = "“Kalıntılarımı beğendin mi? Mümkünse, bedenimi benim için birleştirir misin?”\nAlçıdan yarım beden heykelin dudakları kıpırdadı ve sert, soğuk olması gereken dudaklarından ipek kadar yumuşak, narin bir ses süzüldü."
  },
  Event_6928_Name = {
    Text = "Patchwork Remains"
  },
  Event_6929_ChoiceDesc1 = {
    Text = "[Discard Envelope] [(EnchantConfig.Arg1)] Yakarışını 3 Komut Kartından 1’ine kazı."
  },
  Event_6929_ChoiceDesc2 = {
    Text = "[Tucked in the Chest] \"(RelicConfig.Arg2)\" adlı Kalıntıyı edin, fakat \"(Skill.Arg1)\" Semptomunu geliştir."
  },
  Event_6929_Desc = {
    Text = "Bu bir İmdat Mektubu. Yazan kişi sakin kalmaya çalışıyor, ama arada titreyen harfler, kök salmış dehşetini ele veriyor.\n“Bu, beklentilerimin tamamen ötesinde. Biri bana ağır bir lanetin altında olduğumu söylese, yemin ederim inanırım.”\n“Bazıları deli olduğumu söylüyor. Yarı haklılar. Akıl sağlığımın uçurum kenarındayım.”\n“Ama onu gerçekten gördüm! Değişip kayboluyor; çoğalan siyah sümüksü kütle, tüm bedenimi sarmaya çalışıyor!”\n“Koştum! Yapabildiğim kadar hızlı koştum, ama bakış bir an bile üzerimden ayrılmadı. Beni bulacağını hissediyorum! O iğrenç siyah çamur yine kafatasıma sızacak. Bu mektubu kim alırsa, lütfen, beni kurtarın—”"
  },
  Event_6929_Name = {
    Text = "Distress Letter"
  },
  Event_6930_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6930_Desc = {
    Text = "“Sakin ol,” Ramona başına hafifçe vurur, “sadece geçmişin parçaları. Kim bıraktıysa bu boyutsal geçide, bilmiyorum.”\nGerçekten de, havada nostaljik bir koku var."
  },
  Event_6930_Name = {
    Text = "Acil Mektup"
  },
  Event_6931_ChoiceDesc1 = {
    Text = "[1 random Command Card gains Orison: \"(EnchantConfig.Arg1)\"]"
  },
  Event_6931_ChoiceDesc2 = {
    Text = "[1 random Command Card gains Orison: \"(EnchantConfig.Arg1)\"]"
  },
  Event_6931_ChoiceDesc3 = {
    Text = "[1 random Command Card gains Orison: \"(EnchantConfig.Arg1)\"]"
  },
  Event_6931_Desc = {
    Text = "Olay 205 (Geliştirme Aşamasında), Son Etki Değil"
  },
  Event_6931_Name = {
    Text = "Olay 205 (Geliştirme Aşamasında)"
  },
  Event_6932_ChoiceDesc1 = {
    Text = "[Obtain Relic: (\"(RelicConfig.Arg1)\"]"
  },
  Event_6932_ChoiceDesc2 = {
    Text = "[Obtain Relic: (\"(RelicConfig.Arg1)\"]"
  },
  Event_6932_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_6932_Desc = {
    Text = "Olay 204 (Geliştirme Aşamasında), Son Etki Değil"
  },
  Event_6932_Name = {
    Text = "Olay 204 (Geliştirme Aşamasında)"
  },
  Event_6933_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6933_Desc = {
    Text = "Yalnız ay gökyüzünde yüksekte asılı duruyor, yine de onun duasını—çürümüşlüğün fısıltılarını andıran tuhaf bir ilahiyi—apaçık işitebiliyorsun.\nDua kesiliyor ve sen tam ayrılmak üzereyken, arkanda beyaz bir hayalet beliriyor.\n“Kadere ve duaya tecavüz edenlere, hem lütuflar hem de ceza, vaat edildiği gibi gelecektir.”"
  },
  Event_6933_Name = {
    Text = "Ay Gümüşü Kırığı"
  },
  Event_6934_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6934_Desc = {
    Text = "Arkadan berrak bir kırılma sesi gelir. Bir an duraksar, düşüncelere dalarsın, sonra sırtını dönersin."
  },
  Event_6934_Name = {
    Text = "Ay Gümüşü Kırığı"
  },
  Event_6935_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6935_Desc = {
    Text = "Avuç içine toplanan bir avuç ay ışığı, taş tablete serpiştirildi.\nBirisi kalın çamurun altına gömülmüştü; seyredenler bunun doğal bir ölüm olduğunu, yerin altında huzurla uyuyacağını iddia ediyordu.\nOysa gömülü çamur kabardı ve çığlıkların ortasında, gevşek, cansız bir ay sürünerek dışarı çıktı."
  },
  Event_6935_Name = {
    Text = "Ay Gümüşü Kırığı"
  },
  Event_6936_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6936_Desc = {
    Text = "Sadece hayatta kalmak için çırpınan, dinlenmek için bir parça dal parçası arayan bir canlı...\nİç çekiyorsun, kelebeğin kuyruğundan siyah sıvının akmasına izin veriyorsun."
  },
  Event_6936_Name = {
    Text = "Var Olmaması Gereken"
  },
  Event_6937_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6937_Desc = {
    Text = "Bu önceden tasarlanmış bir tuzak ve tehlikesinin fazlasıyla farkındasın.\nMücevherlerle kıyaslandığında, sen— apaçık çok daha kıymetli bir taşsın."
  },
  Event_6937_Name = {
    Text = "Devirici Pençeler"
  },
  Event_6938_ChoiceDesc1 = {
    Text = "[Insert your Silver Key]"
  },
  Event_6938_Desc = {
    Text = "Aşırı doygun D-balçığın içinde bir şey var gibi görünüyor... Gümüş Anahtar’ı kullanarak onu kendi Gücüne dönüştür."
  },
  Event_6938_Name = {
    Text = "Çökelti Noktası"
  },
  Event_6939_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6939_Desc = {
    Text = "Talebi kabul ettiniz ama ufak bir sorunla karşılaştınız.\n“O balmumu heykel nasıl görünüyor?”\n“Benim büstüm tabii ki, elbette bana benziyor.”\n“Ama...”\n“Yüzün çoktan tamamen çürüyüp gitti. Bilmiyor musun?”"
  },
  Event_6939_Name = {
    Text = "Diğer Yarım"
  },
  Event_6940_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6940_Desc = {
    Text = "Yoldaşının Elini sıkıca kavrarsın. Ramona, sana şaşkınlıkla bir bakış atar ama sonunda bu kabalığını sineye çeker."
  },
  Event_6940_Name = {
    Text = "Rüya Duası"
  },
  Event_6941_ChoiceDesc1 = {
    Text = "[Ask Who It Is] \"(EnchantConfig.Arg1)\" Yakarışını 3 Komut Kartından 1’ine kazı, ancak \"(Skill.Arg2)\" Becerisini geliştir."
  },
  Event_6941_ChoiceDesc2 = {
    Text = "[Stare Back] Bir Uyandırıcıyı Uyanışa çağır, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_6941_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_6941_Desc = {
    Text = "İz Düzeninde ilerlerken, güçlü bir izlenildiğin hissi seni olduğun yerde durduruyor.\n \"Kim var orada?\" Yoğun sisin içinde etrafına bakınıyorsun, \"Jenkin, sen misin?\"\nSis ağır; avlunun derinliklerinden Çözündürülmüşlerin boğuk çığlıkları geliyor. Elin boş dönüyor ve arkanı döndüğünde, havada asılı duran bir gözle neredeyse çarpışıyorsun."
  },
  Event_6941_Name = {
    Text = "Kör Bakış"
  },
  Event_6942_ChoiceDesc1 = {
    Text = "[Avoid Coin] Rastgele bir Komut Kartı üzerine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_6942_ChoiceDesc2 = {
    Text = "[Touch the Coin] Maksimum HP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_6942_Desc = {
    Text = "Siyah çamura gömülü kadim bir madeni para buldun.\nBir yüzünde mavi ve kırmızı damarların ince oyma desenleri, diğer yüzünde ise saf beyaz bir portre kabartması vardı—lekesiz bir düşes hafifçe gülümsüyor, bakışı senin solgun gözlerinle bir anlığına kesişiyor, sonra huzursuzca etrafta gezinmeye başlıyordu."
  },
  Event_6942_Name = {
    Text = "Çift Yüzlü Kalıntı"
  },
  Event_6943_ChoiceDesc1 = {
    Text = "[Turn Around] 25 Kara Mühür al"
  },
  Event_6943_ChoiceDesc2 = {
    Text = "[Keep Going] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ama \"(Skill.Arg2)\" geliştir."
  },
  Event_6943_Desc = {
    Text = "İşte yine geliyor, o tuhaf ayak sesi.\nSeni stüdyodan küratörün odasına, oradan da küratörün odasından bodruma kadar takip ediyor.\nOnun temkinli biri olduğunu biliyorsun.\nArandaki mesafeyi özenle koruyor—ne çok uzak, ne de rahatsız edecek kadar yakın.\nYine de, içindeki o derin huzursuzluk duygusundan kurtulamıyorsun."
  },
  Event_6943_Name = {
    Text = "Ayak Sesleri"
  },
  Event_6944_ChoiceDesc1 = {
    Text = "[Observe It] %100 ihtimalle 25 Kara Mühür elde et"
  },
  Event_6944_ChoiceDesc2 = {
    Text = "[Pet It] %50 ihtimalle 50 Kara Mühür kazan, %50 ihtimalle hiçbir şey kazanma."
  },
  Event_6944_Desc = {
    Text = "Bir kara kedi aniden yandaki bir ara sokaktan fırlayıp çıktı, sevgiyle ayaklarına dolandı. Uğursuz yeşil dikey gözbebekleri, “Beni kovalama, gel biraz benimle oyna,” dercesine ürpertici bir ışıkla parladı.\n“Onu zaten gördün. O hemen yanında—delilikle kirlenmiş olanlar, kudurmuş gölgeler... Anahatlarına doğrudan bakma.”"
  },
  Event_6944_Name = {
    Text = "Gece Perisi"
  },
  Event_6945_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6945_Desc = {
    Text = "Uyandırıcılar emrini bekliyor; başka hiçbir şeye ayıracak vaktin yok."
  },
  Event_6945_Name = {
    Text = "From Perspective"
  },
  Event_6946_ChoiceDesc1 = {
    Text = "[Check the Film] \"(RelicConfig.Arg2)\" adlı Altın Kalıntıyı edin, fakat \"(Skill.Arg1)\"i geliştir."
  },
  Event_6946_ChoiceDesc2 = {
    Text = "[Check Camera] 50 Kara Mühür al"
  },
  Event_6946_Desc = {
    Text = "Sanki iç organlardan bir parça sökülüyormuş gibi, kameranın içindeki film lime lime yırtıldı; içi boşaltılmış, kenara atılmış ve görmezden gelinmişti.\nKör edici bir beyaz parıltı, sokağın köşesine terk edilmiş kamerayı yana eğdi; deklanşörü görünmeyen bir güç tarafından çekildi.\n“Klik—”\nŞaşkın, donakalmış ifaden filmde sadakatle kaydedildi."
  },
  Event_6946_Name = {
    Text = "Masumiyeti Kaydet"
  },
  Event_6947_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6947_Desc = {
    Text = "Bu sadece rüzgârın Demir Kilitleri sallayan sesi, endişelenecek bir şey yok. Sadece görmezden gel."
  },
  Event_6947_Name = {
    Text = "Behind Iron Gates"
  },
  Event_6948_ChoiceDesc1 = {
    Text = "[Choose] [(Skill.Arg1)] Semptomunu Geliştir"
  },
  Event_6948_ChoiceDesc2 = {
    Text = "[Choose] [(Skill.Arg1)] Semptomunu Geliştir"
  },
  Event_6948_ChoiceDesc3 = {
    Text = "[Choose] [(Skill.Arg1)] Semptomunu Geliştir"
  },
  Event_6948_Desc = {
    Text = "\"Ben\" eşsizim, milyonlarca evren içinde yeri doldurulamazım."
  },
  Event_6948_Name = {
    Text = "Ruh Rezonansı"
  },
  Event_6949_ChoiceDesc1 = {
    Text = "[Claim] Bir Gümüş Kalıntı Seç"
  },
  Event_6949_Desc = {
    Text = "\nBu belki de “ben”im.\nZamanın gölgeleri arasından, boyutsal savunma duvarlarını aşarak, çatlak bir yarıktan “kendimle” yüz yüze geldim."
  },
  Event_6949_Name = {
    Text = "Ruh Rezonansı"
  },
  Event_6950_ChoiceDesc1 = {
    Text = "[Point Out the Issue] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_6950_ChoiceDesc2 = {
    Text = "[Swallow Doubt] [(Skill.Arg1)] Semptomunu geliştir ve kazınacak Yakarışı değiştir.(Kullanım: 1/2)"
  },
  Event_6950_Desc = {
    Text = "Kız için de bu, dile getirilemez bir kederdi.\nO kalbine dokunup yirmi beş yıl süren bir rüyayı ve uyandıktan sonraki yalnızlık duygusunu anlatmaya başlarken, sorularını yutkunup içine gömersin."
  },
  Event_6950_Name = {
    Text = "Zincirlenmiş Hayat"
  },
  Event_6951_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6951_Desc = {
    Text = "Kâğıt ve ağaç kıymıklarını alevlerin içine atarsın. Ateş onları oburca yutar ve memnun bir geğirti çıkarır. Yıkım için hazırdır, ama önce sana bir lütuf bahşedecektir."
  },
  Event_6951_Name = {
    Text = "Solgun Ateş"
  },
  Event_6952_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6952_Desc = {
    Text = "Nefretin son közünü acımasızca söndürdün ve etrafta asılı duran Kin ve isteksizlik sanki hafifledi."
  },
  Event_6952_Name = {
    Text = "Solgun Ateş"
  },
  Event_6953_ChoiceDesc1 = {
    Text = "[Chase the Crows] Arg1 Kara Mühür al, fakat [(Skill.Arg2)] geliştir."
  },
  Event_6953_ChoiceDesc2 = {
    Text = "[Ignore] Leave"
  },
  Event_6953_Desc = {
    Text = "Kargayı yakalamaya çalışırsın, ama o yalnızca yatak odasının bir ucundan ötekine uçar, tekinsiz gaklayışını sürdürür. Konduğu yerden siyah bir sıvı damlar, karanlık izler oluşturur."
  },
  Event_6953_Name = {
    Text = "Fener Kargası"
  },
  Event_6954_ChoiceDesc1 = {
    Text = "[Leave] \"(RelicConfig.Arg1)\" Kalıntısını elde et, fakat \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_6954_Desc = {
    Text = "\n \"Özü yakalamakta ustasın,\" der adam, ışıldayan bir gülümsemeyle. \"Bu, dünyadaki en leziz yiyecek; her oburun titizlikle hazırlayıp takdir etmesi gereken bir nimet.\"\n \"Ne yazık ki bu sefer sana tattıramam. Telafi olsun diye, yanımda başka nefis şeyler var, onları sana vereceğim.\"\nBöyle diyerek adam, yumuşak kırmızı bir et parçası fırlatır. Yumuşak et köprüye düşer; yapışkan uzuvları grotesk bir biçimde kıvranır. Başını yeniden kaldırdığında, adamın silueti karmaşık çelik iskeletlerin ardında kaybolmuş, geride tek bir iz bile bırakmamıştır."
  },
  Event_6954_Name = {
    Text = "Garip Yol Arkadaşı VI"
  },
  Event_6955_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6955_Desc = {
    Text = "Yığınları Adım Adım çözmek senin ustalığın.\nBir anlık İlham zihnini arındırır, önündeki gerçeği görmeni sağlar—\nİpleri kim çekerse çeksin, kaç ve hayatta kal."
  },
  Event_6955_Name = {
    Text = "İlham Patlaması"
  },
  Event_6956_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6956_Desc = {
    Text = "Avucunda bir kelebek paramparça oluyor; sanki aniden kırılan camdan bir tavan gibi, parçalar düşüyor, düşüyor, düşüyor yere—"
  },
  Event_6956_Name = {
    Text = "Demiryolu Serabı"
  },
  Event_6957_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6957_Desc = {
    Text = "Ramona'nın yaklaşmaya isteksiz olduğunu gören kedi başını salladı ve bir Gölgeye karışarak dağıldı."
  },
  Event_6957_Name = {
    Text = "Gezinen Sakin"
  },
  Event_6958_ChoiceDesc1 = {
    Text = "[Make a promise] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\"yi geliştir."
  },
  Event_6958_ChoiceDesc2 = {
    Text = "[Refuse] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\"yi geliştir."
  },
  Event_6958_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_6958_Desc = {
    Text = "\"Bu gerçekten unutulmaz bir hafızaydı.\nBaşım ve uzuvlarım zorla alçıya bastırılmıştı.\nBoğulma ve ölüm eşiği fantazmaları beni derinden sarıp sarmaladı, sonra çekip kaldırdı ve beni karanlık bir kıyıya fırlattı.\nOna baktım, içimden bir parçanın da alınmış olduğunu hissederek.\nRuhumun yitirilen o yarısı o küçük, ilk Balmumu Heykelin içinde o günden beri ikamet ediyor.\nYani... Diğer Yarımımı bulmama yardım eder misin?\""
  },
  Event_6958_Name = {
    Text = "Diğer Yarım"
  },
  Event_6959_ChoiceDesc1 = {
    Text = "[Leave] 3 İleri Yakarıştan 1’ini Oyarak Yaz"
  },
  Event_6959_Desc = {
    Text = "Sen, Anıların bir seyircisisin; kızın Karanlık Deniz’e düşüşünü çaresizce izlersin.\nAkıntı eteğini yukarı kaldırır, ama o, açılmamış bir çiçek gibi dibe çöker."
  },
  Event_6959_Name = {
    Text = "Batık Deniz"
  },
  Event_6960_ChoiceDesc1 = {
    Text = "[Insert your Silver Key]"
  },
  Event_6960_Desc = {
    Text = "Aşırı doygun D-balçığın içinde bir şey var gibi görünüyor... Gümüş Anahtar’ı kullanarak onu kendi Gücüne dönüştür."
  },
  Event_6960_Name = {
    Text = "Çökelti Noktası"
  },
  Event_6961_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6961_Desc = {
    Text = "Düşmanın ayartısına kapılmayın; bir tuzak olabilir."
  },
  Event_6961_Name = {
    Text = "Lanetli Karga"
  },
  Event_6962_ChoiceDesc1 = {Text = "[Help Him]"},
  Event_6962_ChoiceDesc2 = {
    Text = "[Observe Coldly]"
  },
  Event_6962_Desc = {
    Text = "Çocuk sahnede duruyordu, solgun bir ışık yüzüne vuruyordu.\n“Ad-adanmıştır...”\nÇocuğun yüzü kızardı. Ağzını açtı ama tek bir ses çıkaramadı.\nAçık duran ağzı gitgide daha da büyüdü..."
  },
  Event_6962_Name = {
    Text = "Son Perde III"
  },
  Event_6963_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6963_Desc = {
    Text = "“Lanet olsun, lanet olsun!” Sanki bir düğmeye basmışsın gibi, kara kedi aniden vahşileşiyor, kolunu ısırmaya çalışıyor. Neyse ki tam zamanında geri çekiliyorsun, yalnızca ceketin bir parçasını kaybediyorsun. Kara kedi sokak köşesine fırlayıp kanalizasyonda kayboluyor."
  },
  Event_6963_Name = {
    Text = "Gece Perisi"
  },
  Event_6964_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6964_Desc = {
    Text = "Zihnini dolduran kabaran düşüncelere sarılı halde kapıyı itip açıyor ve geri dönüşü olmayan bir yola adım atıyorsun.\nKapının dışındaki o yakıcı beyaz ışık kurtuluş mu, yoksa Yıkım mı?"
  },
  Event_6964_Name = {
    Text = "Kapıların Ötesinde"
  },
  Event_6965_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6965_Desc = {
    Text = "Dikkatle öne eğilip incelemeye koyulursun ve masayı kaplayan sümüksü tabaka aniden yarılarak altındakini açığa çıkarır."
  },
  Event_6965_Name = {
    Text = "Kapıların Ötesinde"
  },
  Event_6966_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6966_Desc = {
    Text = "Kuşkularını yut, düşmana odaklan.\nKelebeklerin bedeninin içinde oyalanmasına izin ver; kanatları organlarını parçalasa bile."
  },
  Event_6966_Name = {
    Text = "Kelebek Etkisi"
  },
  Event_6967_ChoiceDesc1 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_6967_Desc = {
    Text = "Kedi memnuniyetle başını sallar, ardından gölgeye karışıp yok olur; geride birkaç siyah, dairesel nesne bırakır."
  },
  Event_6967_Name = {
    Text = "Gezinen Sakin"
  },
  Event_6968_ChoiceDesc1 = {
    Text = "[Insert your Silver Key]"
  },
  Event_6968_Desc = {
    Text = "Aşırı doygun D-balçığın içinde bir şey var gibi görünüyor... Gümüş Anahtar’ı kullanarak onu kendi Gücüne dönüştür."
  },
  Event_6968_Name = {
    Text = "Çökelti Noktası"
  },
  Event_6969_ChoiceDesc1 = {
    Text = "[Leave] Rastgele bir Altın Kalıntı edin, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_6969_Desc = {
    Text = "Hâlâ tereddüt ettiğini görünce, Koum toprak yığınına atıldı, ön patileriyle hızla kazdı ve bir şeyi önüne itti."
  },
  Event_6969_Name = {
    Text = "Derine Gömülü"
  },
  Event_6970_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6970_Desc = {
    Text = "Kâğıdın üst kısmına özenle “Mérimée” basılmıştır, hiçbir zaman bir Mason olmamıştır.\nAşırı şüphe iyiye işaret değildir, Koruyucu."
  },
  Event_6970_Name = {Text = "Daktilo"},
  Event_6971_ChoiceDesc1 = {
    Text = "[Leave] 3 Altın Kalıntıdan 1’ini edin, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_6971_Desc = {
    Text = "Tümseklerin altında, Heykeltıraşlar Birliği’nin sayısız iğrenç suçu gömülü."
  },
  Event_6971_Name = {
    Text = "Derine Gömülü"
  },
  Event_6972_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6972_Desc = {
    Text = "Kuşların kendi kuralları vardır. Senin iradene göre hareket etmezler ve senin de doğa yasalarına müdahale etmeye hakkın yoktur."
  },
  Event_6972_Name = {
    Text = "Sürüden Ayrılan Karga"
  },
  Event_6973_ChoiceDesc1 = {
    Text = "[Leave] 3 Altın Kalıntıdan 1’ini edin, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_6973_Desc = {
    Text = "Neden? Neden battı?\nO gün ne gök gürültülü bir fırtına vardı, ne de kasırga. Gece göğü açıktı, tek bir yıldız bile görünmüyordu; ufkun üzerinde alçakça asılı duran dolunay, soğuk bir güneş gibiydi."
  },
  Event_6973_Name = {
    Text = "Batık Deniz"
  },
  Event_6974_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6974_Desc = {
    Text = "\"\"Şef! Saldırı altındayız!... Bzzzz...\"\nGaliba arayan Sürücü. Tam telefonu kapatacaktın.\n\"Tekrar ediyorum, burası Mythag Saha Ekibi 4. Kurtarılan rehinelere Refakat ederken kuzeye Doğru giden gece ekspresindeydik ki... Ah!\"\nTelefondaki ses boğuk bir Fısıltı'ya dönüşüyor, içine uğursuz çığlıklar karışıyor.\n\"Ayinin Tamamlandı. Yitik kuzu, bu kutsal banyo ruhunu arındırsın...\"\""
  },
  Event_6974_Name = {
    Text = "Tren Araması"
  },
  Event_6975_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6975_Desc = {
    Text = "Gümüşleri toplamak da Koruyucuların görevlerinden biridir.\nSaf beyaz kristallerin içinde sürüklenen ruhlar, gelecekte bambaşka bir suretle dünyaya Dönüş yapacaktır."
  },
  Event_6975_Name = {Text = "Tutsak Ruh"},
  Event_6976_ChoiceDesc1 = {
    Text = "[Descend Further] [(EnchantConfig.Arg1)] Yakarışını rastgele bir Komut Kartına kazı."
  },
  Event_6976_ChoiceDesc2 = {
    Text = "[Pull Away] 25 Kara Mühür al"
  },
  Event_6976_Desc = {
    Text = "\"Sen\" seni daha derine davet ediyor.\nSarmalın derinliklerinde, geçmişteki ve gelecekteki \"sen\" sana farklı boyutlardan \"hediyeler\" gönderiyor."
  },
  Event_6976_Name = {Text = "Uçurum"},
  Event_6977_ChoiceDesc1 = {
    Text = "[Lean Out] \"(RelicConfig.Arg2)\" adlı Altın Kalıntıyı edin, fakat \"(Skill.Arg1)\"i geliştir."
  },
  Event_6977_ChoiceDesc2 = {
    Text = "[Give Up Checking] 50 Kara Mühür al"
  },
  Event_6977_Desc = {
    Text = "Ameliyat masasının altında sıkışmış bir film rulosu var gibi görünüyor."
  },
  Event_6977_Name = {
    Text = "Mnemonic Phantoms"
  },
  Event_6978_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6978_Desc = {
    Text = "Dikkat dağıtıcıları görmezden gel ve ana odaklan.\nYapman gereken daha önemli şeyler var."
  },
  Event_6978_Name = {
    Text = "Diğer Yarım"
  },
  Event_6979_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6979_Desc = {
    Text = "Kaybolmuş bir kalıntı, paha biçilmez bir yadigâr, dilek gerçekleştiren bir aygıt...\nBelki de yalnızca gizli hazineler bu kadar baştan çıkarıcı olabilir."
  },
  Event_6979_Name = {
    Text = "Gizem Girdisi"
  },
  Event_6980_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6980_Desc = {
    Text = "『Sen Lily'nin 'annesisin', ama onu yalnızca araştırma ve savaş için bir araç olarak kullanıyorsun,』 diye karşılık verirsin. 『Bir çocuk annesine itaat edebilir, ama sen Lily'nin 'annesi' olmamalısın.』"
  },
  Event_6980_Name = {
    Text = "Onun Seçimi"
  },
  Event_69813_ChoiceDesc1 = {Text = "[Leave]"},
  Event_69813_Desc = {
    Text = "Gümüş Anahtar parıldar; kollar, bir güçten ürkmüş gibi havuza çekilir ve ardından yok olur."
  },
  Event_69813_Name = {Text = "Kan Gölü"},
  Event_69814_ChoiceDesc1 = {Text = "[Leave]"},
  Event_69814_Desc = {
    Text = "Ne kadar derine batarsan, zihninde Yüce İrade’nin kaotik fısıltılarını o kadar çok duyarsın. Gözlerini kapatır, içindeki Otorite’yi çağırırsın.\nBir anda, tüm sesler ve tuhaf hisler yok olur. Kapı’nın ardında duruyorsun; yanındaki kan kırmızısı Dokunaç’lar iz bırakmadan kaybolmuş, sanki hiç var olmamışlar gibi.\nKendini dinç hissediyorsun. Ödediğin bedeli biliyorsun, ama önemsiz—o yüce varlığın karşısına daha güçlü bir hâlde çıkacaksın."
  },
  Event_69814_Name = {Text = "Kan Gölü"},
  Event_69815_ChoiceDesc1 = {Text = "[Leave]"},
  Event_69815_Desc = {
    Text = "Anılarınla şekillenmiş Uyanan, tereddüt etmeden hareket etti ve seni kanla dolu havuzdan çekip çıkardı. Kopmuş kolun, çamurlu su sıçrarken yeniden yerine tutturuldu; suda sayısız, ayırt edilemeyen yaratık kıvranıyordu. Köken Yadigâr ve Yıkımcı, umutsuzca her şeyi yutmayı arzuluyordu."
  },
  Event_69815_Name = {Text = "Kan Gölü"},
  Event_69816_ChoiceDesc1 = {
    Text = "[Summon Awakeners] Tüm Uyandıranlar 100 Aliemus kaybeder. Bir Semptom kartını İmha Et."
  },
  Event_69816_ChoiceDesc2 = {
    Text = "[Drink the Blood] Azami HP'yi Arg1 artır, ancak [(Skill.Arg2)]yi iki kez geliştir."
  },
  Event_69816_ChoiceDesc3 = {
    Text = "[Harness Silver Key] Tüm Keyflare’i kaybet."
  },
  Event_69816_Desc = {
    Text = "Yaşamın Otoritesi, ilkel varlığın gözünde ölüm suretinde tezahür eder. Bu gölgeli Gizli Diyar’a adımını attığında, pis kokulu kan gölü anında gerçek biçimini açığa vurur.\nKızıl-siyah kan, sayısız kol uzatarak ayak bileklerine yapışır ve seni akıl sır ermez Uçurum’a sürüklemek istercesine durmaksızın yukarı doğru çeker."
  },
  Event_69816_Name = {Text = "Kan Gölü"},
  Event_6981_ChoiceDesc1 = {
    Text = "[Pick Up Key]"
  },
  Event_6981_Desc = {
    Text = "Paslı anahtarların bir demeti. Kapıları açmak için kullanılabilir."
  },
  Event_6981_Name = {
    Text = "Paslı Anahtar"
  },
  Event_6982_ChoiceDesc1 = {
    Text = "[Leave] Bir Komut Kartını kopyala, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_6982_Desc = {
    Text = "Türkülerin ve Celeste’in rehberliğinde, kamaraların zifiri karanlık derinliklerine bakarsın—hayatta kalma şansın, o sınırsız Karanlık’ın içinde olabilir mi?"
  },
  Event_6982_Name = {
    Text = "Denizci Türküsü"
  },
  Event_6983_ChoiceDesc1 = {
    Text = "[Leave Together] [(RelicConfig.Arg1)] adlı Gümüş Kalıntıyı elde et."
  },
  Event_6983_ChoiceDesc2 = {
    Text = "[Refuse to Leave] 75 Kara Mühür al, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_6983_Desc = {
    Text = "Bu bir fantazma mı? Üstünde dönen kargalar görüyorsun, tanıdık bir ezgi mırıldanıyorlar:\n\"Öyleyse birlikte gidelim, sen ve ben,\nGece çökerken,\nSokakta yığılıp kalan ölümlü bir sarhoş gibi.\""
  },
  Event_6983_Name = {
    Text = "Kargaların Korosu"
  },
  Event_6984_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6984_Desc = {
    Text = "Geriye bakışın gücü kısa vadede senin için başka bir Kavşak bulamaz, ama en azından biraz Geçici kurtuluş hissedersin."
  },
  Event_6984_Name = {
    Text = "Anormal Temas"
  },
  Event_6985_ChoiceDesc1 = {
    Text = "[Gaze into the Abyss]"
  },
  Event_6985_ChoiceDesc2 = {
    Text = "[Pull Away] 25 Kara Mühür al"
  },
  Event_6985_Desc = {
    Text = "Bordo penceresinden deniz yüzeyi kaybolmuş.\nCam, solgun yüzünü yansıtırken, gözbebeğinde “sen” tekrar borda penceresine bakarsın.\nGerçeklik ve Gizli Diyar üst üste biner, iç içe geçer ve sonunda karmaşık bir sarmala bükülür."
  },
  Event_6985_Name = {Text = "Uçurum"},
  Event_6986_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6986_Desc = {
    Text = "Okuldan gelen bir iletişim isteğini kabul ettin. Tanıdık Ses zihnini sakinleştiriyor. Kendini toparlayıp ilerliyorsun."
  },
  Event_6986_Name = {Text = "Kavşak"},
  Event_6987_ChoiceDesc1 = {Text = "[Agree]"},
  Event_6987_ChoiceDesc2 = {Text = "[Disagree]"},
  Event_6987_ChoiceDesc3 = {
    Text = "[No Comment]"
  },
  Event_6987_Desc = {
    Text = "\"Uzun zaman oldu, dostlar.\" Işık Taşıyıcı Tarikatçılarıyla savaştan sıyrılıp nefesini topladıktan sonra, uzun saçlı adamın yol kenarında yeniden belirdiğini fark ediyorsun; sanki dövüş hiç yaşanmamış gibi gülümsüyor.\n\"Geçen seferle kıyaslayınca, üzerindeki Kerberos kokusu çok daha ağır. Bu süre içinde epey yol katetmiş olmalısın, değil mi?\"\n"
  },
  Event_6987_Name = {
    Text = "Garip Yol Arkadaşı V"
  },
  Event_6988_ChoiceDesc1 = {
    Text = "[Ona Yol Sor] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_6988_ChoiceDesc2 = {
    Text = "[Onu Terk Et] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_6988_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_6988_Desc = {
    Text = "Gölge, uzun sokak lambasının altında duruyor.\n\"Bir ateş alabilir miyim, bayım?\"\n@2 alışkanlığın yok, ama biraz ‘sihir’ kullanmaktan da gocunmuyorsun.\nYardımınla, gölge @2’i tutuşturacak ve onu o akıl almaz siyah girdabın derinliklerine saplayacak.\nÇok geçmeden, beyaz dumanların yükseldiğini görüyorsun.\n\"Ah—\"\nGölge, memnun bir iç çekiş bırakıyor."
  },
  Event_6988_Name = {
    Text = "Sokak Lambasının Altındaki Silüet"
  },
  Event_6989_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_6989_Desc = {
    Text = "Satranç tahtasında gördüğün gerçek değildir.\n\nYolunu kesen şey bir duvar değil, belki de sönmekte olan merakındır."
  },
  Event_6989_Name = {
    Text = "Phantom Space"
  },
  Event_6990_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6990_Desc = {
    Text = "\"Çok acı çekiyorum... Sasha Abla...\"\nSarah’a göz atarsın. Gergin bir hâlde, iki Çocuklar’ı kendine siper etmiş, hiçbir şey duymuyormuş gibi yapıyor.\nSes yavaş yavaş sönüp gider."
  },
  Event_6990_Name = {
    Text = "\"Sasha Abla\""
  },
  Event_6991_ChoiceDesc1 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_6991_Desc = {
    Text = "Ayağa kalkar ve çocuk için alkış tutarsın.\nTeşvikini hissetmiş gibi, çocuk küçücük göğsünü kabartır.\nAğzından kara kan akmaya devam eder, ama artık şarkı söylemesini durduramaz."
  },
  Event_6991_Name = {
    Text = "Son Perde IV"
  },
  Event_6992_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6992_Desc = {
    Text = "Hüznün bir kısmı buharlaşıyor, ama gözyaşları gizemli geçmişe doğru durmaksızın akmaya devam ediyor."
  },
  Event_6992_Name = {
    Text = "Stiks'in Ağıtı"
  },
  Event_6993_ChoiceDesc1 = {
    Text = "[Choke the Singer] \"(RelicConfig.Arg2)\" Lanetli Kalıntı’yı elde et, ancak \"(Skill.Arg1)\" geliştir."
  },
  Event_6993_ChoiceDesc2 = {
    Text = "[Stumbling Dancer's Steps] \"(RelicConfig.Arg2)\" ve \"(RelicConfig.Arg3)\" Gümüş Kalıntıları’nı elde et, ancak \"(Skill.Arg1)\"i iki kez geliştir."
  },
  Event_6993_ChoiceDesc3 = {
    Text = "[Take a Detour] [(RelicConfig.Arg1)] Gümüş Kalıntı’yı elde et."
  },
  Event_6993_Desc = {
    Text = "Üç yapışkan siluet tarafından yolun kesiliyor.\nBunlardan biri, boğuk bir sesle tekinsiz sözler mırıldanıyor. Kulaklarını kapatıp yanından geçiyorsun.\nBir diğeri, tutuk adımlarla tereddütlü bir dans sergiliyor. Gözlerini kapatıp ondan sıyrılıyorsun.\nSonuncusu, kopuk cümlelerle paramparça şiirler okuyor. Artık daha fazla dayanamayıp—"
  },
  Event_6993_Name = {
    Text = "Dar Yolun Canisi"
  },
  Event_6994_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6994_Desc = {
    Text = "Öfkenin bir kısmı kaynıyor, fakat gözyaşları bilinmeyen bir geçmişe doğru akmaya devam ediyor."
  },
  Event_6994_Name = {
    Text = "Stiks'in Ağıtı"
  },
  Event_6995_ChoiceDesc1 = {
    Text = "[Ignore It] Bir Kalıntı edin, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_6995_ChoiceDesc2 = {
    Text = "[Turn Away] Rastgele bir Uyandırıcıyı uyandır."
  },
  Event_6995_Desc = {
    Text = "Zalim kader, seyyahın ayaklarının altında sürünür. Fitil Yolu ayna gibi berraktır, arkadaysa hafif bir çatlama sesi.\nKimin kaderi ayaklar altında ezildi? Bu bir Düş mü, tuzak mı, yoksa yalnızca Mırıltılar, Hile...\nGözlerinin önünde, ağır ağır ilerleyen bir çatlak belirir.\n<Italic:Sanki Uyanış Gnosis’i için dibe çökecekmiş gibi.>"
  },
  Event_6995_Name = {
    Text = "Sürünen Çatlak"
  },
  Event_6996_ChoiceDesc1 = {
    Text = "[Initiate Trial] [(Skill.Arg1)] geliştir; galip gelirsen bir Altın Kalıntı, yenilirsen 50 Kara Mühür kazan."
  },
  Event_6996_ChoiceDesc2 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_6996_Desc = {
    Text = "Ayaklarının altındaki ayna gibi siyah sümüksü maddeden bazı sırların gölgesini yakaladın.\nYansıması bulanık, inatçı bir karanlık sisine bürünmüş. Tuhaf biçimde tanıdık geliyor, ama ne olduğunu tam seçemiyorsun."
  },
  Event_6996_Name = {
    Text = "Under-Mirror"
  },
  Event_6997_ChoiceDesc1 = {
    Text = "[Imitate Cat's Call] %50 ihtimalle 125 Kara Mühür al, %50 ihtimalle [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_6997_ChoiceDesc2 = {
    Text = "[Feed] %75 ihtimalle 100 Kara Mühür al, %25 ihtimalle [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_6997_ChoiceDesc3 = {
    Text = "[Run Away] 50 Kara Mühür al"
  },
  Event_6997_Desc = {
    Text = "Yanlışlıkla kara kedinin bölgesine girdin.\nKaranlıkta sayısız göz açıldı; merak, tetkik ve Alarm doluydular... ama zerre kadar merhamet yoktu.\nZümrüt yeşili, kehribar sarısı, tavuskuşu mavisi...\nSanki pırıl pırıl mücevherlerden oluşan bir denize nüfuz etmişsin gibi hissettin.\nKaçmak için, sen—"
  },
  Event_6997_Name = {
    Text = "Kediler Şehri"
  },
  Event_6998_ChoiceDesc1 = {
    Text = "[About Daffodil] \"(EnchantConfig.Arg1)\" ve \"(EnchantConfig.Arg2)\" Yakarışlarını rastgele 2 Komut Kartına kazı."
  },
  Event_6998_ChoiceDesc2 = {
    Text = "[About Hellhound] [(RelicConfig.Arg1)] Lanetli Kalıntı’yı elde et."
  },
  Event_6998_ChoiceDesc3 = {
    Text = "[About Lily] [(Skill.Arg1)] Semptomunu Geliştir"
  },
  Event_6998_Desc = {
    Text = "\"Nergis’in İpucu Süresi.\""
  },
  Event_6998_Name = {
    Text = "İpucu Süresi"
  },
  Event_6999_ChoiceDesc1 = {
    Text = "[Let Pointer] \"(RelicConfig.Arg1)\" Altın Kalıntı’yı elde et, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_6999_ChoiceDesc2 = {
    Text = "[Hold Pointer] \"(RelicConfig.Arg1)\" Altın Kalıntı’yı elde et, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_6999_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_6999_Desc = {
    Text = "Çat, çıtır, çat—\nKaderin elleri milim milim ileri sarıyor, dişlilerin soğuk tıkırtısı, senin ürktüğün yöne amansızca ilerliyor."
  },
  Event_6999_Name = {
    Text = "Beyond the Needle"
  },
  Event_7000_ChoiceDesc1 = {
    Text = "[Turn a Deaf Ear] 3 Komut Kartı’ndan 1’ini İmha Et ve 75 Kara Mühür al."
  },
  Event_7000_ChoiceDesc2 = {
    Text = "[Carefully Inspect] 3 Komut Kartı’ndan 1’ini çoğalt ve 25 Kara Mühür al."
  },
  Event_7000_ChoiceDesc3 = {
    Text = "[Turn and Leave] 50 Kara Mühür al"
  },
  Event_7000_Desc = {
    Text = "Zalim kader gezginin ayaklarının altında sürünürken, yol ayna gibi parıldar, arkada hafif çatlama sesleri duyulur.\nKim ayak altındaki kaderi parçaladı? Bu bir Sanrı mı, tuzak mı, yoksa yalnızca Mırıltılar ve aldatmaca mı...\nGözlerinin önünde, yavaşça ilerleyen bir çatlak belirir."
  },
  Event_7000_Name = {
    Text = "Sürünen Çatlak"
  },
  Event_7001_ChoiceDesc1 = {
    Text = "[Call the Crow] 25 Kara Mühür al, [(Skill.Arg2)] becerisini geliştir ve seçim yapmaya devam et."
  },
  Event_7001_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_7001_Desc = {
    Text = "Pençe pelerini yararak omza derinlemesine saplanır."
  },
  Event_7001_Name = {
    Text = "Sürüden Ayrılan Karga"
  },
  Event_7002_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7002_Desc = {
    Text = "Korku bazen somut bir şeyden kaynaklanmaz.\n“Cehennem Köpeği” nereye gitse ardında kırmızı damlalar bırakır, senin siluetini yansıtır."
  },
  Event_7002_Name = {
    Text = "Biçimsiz Yansıma"
  },
  Event_7003_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7003_Desc = {
    Text = "Hafif bir vızıltıyla, kadının fısıltısını duyarsın.\nGözyaşları içinde, hikâyesini durmaksızın anlatıp durur.\nBir saat geçer, sonra bir gün... ta ki onun neden üzgün olduğunu çoktan unutana dek.\nSonunda neşeyle telefonu kapatır ve sana bir hediye göndermeye söz verir.\nKabul edersin. Ne de olsa hediyeler her zaman hoştur."
  },
  Event_7003_Name = {
    Text = "Çağrıya Cevap"
  },
  Event_7004_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7004_Desc = {
    Text = "Yoldaşlarının şaşkın bakışları altında başını eğiyor, tek dizinin üzerine çöküyor ve sağ yumruğunu alnına götürüyorsun.\nMükemmel, bu yüzünü tamamen örtecek."
  },
  Event_7004_Name = {
    Text = "Kusursuz Kılık Değiştirme"
  },
  Event_7005_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7005_Desc = {
    Text = "\n \"Örtüyü üzerime sen örttün.\"\nBalmumu Heykel sana dingin bir gülümsemeyle bakıyor.\n \"Yoğun çabanın ödülü olarak sana Gerçek’i sunuyorum.\"\nKarnından durmaksızın siyah bir sıvı sızıyor, seni sıkıca sarıp sarmalıyor.\nDünya zifiri karanlık, ama tarifsiz bir sıcaklıkta.\nBüzülüp esniyor, @1. kez düşler ülkesine dalıyorsun..."
  },
  Event_7005_Name = {
    Text = "Tamamlanmamış Balmumu Heykel"
  },
  Event_7006_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7006_Desc = {
    Text = "Siste hiçbir şey bulamazsın."
  },
  Event_7006_Name = {Text = "Kaos Sisi"},
  Event_7007_ChoiceDesc1 = {
    Text = "[Answer the Phone] 3 İleri Yakarış’tan 1’ini Oyarak Yaz"
  },
  Event_7007_ChoiceDesc2 = {
    Text = "[Ignore Bell] Altın Kalıntı \"(RelicConfig.Arg1)\" elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_7007_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_7007_Desc = {
    Text = "\"Ding ding ding...\"\nKöşeden keskin bir telefon zili yükseldi; aceleci ve gürültülüydü, her çalışı bir öncekinden daha yüksek, sanki cevaplamazsan hemen delirecek ve patlayacak, böylece dünyayı yok edecekmişsin gibi sana bir düş veriyordu."
  },
  Event_7007_Name = {
    Text = "Çağrıya Cevap"
  },
  Event_7008_ChoiceDesc1 = {
    Text = "[Approach Phantasm] 3 Gümüş Kalıntıdan 1’ini Elde Et"
  },
  Event_7008_ChoiceDesc2 = {
    Text = "[Break Phantasm] Gümüş Kalıntılar \"(RelicConfig.Arg1)\" ve \"(RelicConfig.Arg2)\"yi elde et, fakat \"(Skill.Arg3)\"ü iki kez geliştir."
  },
  Event_7008_Desc = {
    Text = "Bu, Gizli Diyar’da bir serap mı? Yoksa başka bir kaçınılmaz Hatıra mı?\nGözlerini ovuşturursun. Bir Fantazma yaklaşır—bu, cıvıl cıvıl pazar mı, Çözünme’ye kaybolmuş Balmumu Müzesi mi, karlı köydeki tımarhane mi, yoksa bulanık Yakutsk mu?"
  },
  Event_7008_Name = {Text = "Serap"},
  Event_7009_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7009_Desc = {
    Text = "Kaynar suyla haşlanmış gibi, içgüdüsel olarak kulaklarını kapatıyor, o habis müziği dışarıda bırakıyorsun."
  },
  Event_7009_Name = {
    Text = "Yasak Tını"
  },
  Event_7010_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7010_Desc = {
    Text = "Parlak bir majör akor, gerilimi ve korkuyu dağıtır. Tutkulu, tomurcuklanan, taşkınsındır. Öne doğru adımlarsın, Ramona’yı çok geride bırakarak—\"Koruyucu?! Bu kadar hızlı yürüme!\""
  },
  Event_7010_Name = {
    Text = "İsimsiz Yankı"
  },
  Event_7011_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7011_Desc = {
    Text = "\n\"Olduğun yerde kal!!! Sürünerek ilerleyen, eriyen canavar bile kendi uzuvlarını senden daha iyi tanıyor!\"\nSeyircileri bırak...\nBunu kalbinden Dua edersin"
  },
  Event_7011_Name = {
    Text = "Dar Yolun Canisi"
  },
  Event_7012_ChoiceDesc1 = {Text = "[Withdraw]"},
  Event_7012_Desc = {
    Text = "Bu yalnızca bir Gizli Diyar.\nKorumak istediğin ve kaçmaya çalıştığın şey ise benzersiz bir gerçekliktir."
  },
  Event_7012_Name = {Text = "Uçurum"},
  Event_7013_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7013_Desc = {
    Text = "\n \"En tiksinilesi olan sensin.\"\nEl yazmasını parçalara ayırıp rüzgâra savuruyorsun; rüzgârda uçuşan birkaç demet çiçek yaprağına bölünüyor.\nŞiirdeki Kişi, rüzgârda dönen karakterlere bakıyor; dudaklarının kenarında bir Takıntı kıvrılıyor.\n \"Güzel...\""
  },
  Event_7013_Name = {
    Text = "Dar Yolun Canisi"
  },
  Event_7014_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7014_Desc = {
    Text = "\nPosteri yırtıp indirdin ve arkasında balmumu müzesi için alelacele kaydedilmiş giderler buldun.\nYazının sahibinin ne aritmetiğe sabrı ne de yeteneği vardı; bu hesaplar, ne yapılırsa yapılsın düzeltilemezdi.\nŞöyle bir göz gezdirdin; en büyük gider kalemi \"Balmumu Heykel Bakım Temizliği\" görünüyordu.\nÇalışan giderleri acınacak kadar düşüktü; en son harcama, tanesi yaklaşık 20 Fang’dan 12 at kılı kamçıydı.\nBir de özel bir gider vardı — \"Onların Yiyeceği\".\n \"Onlar\" kim?"
  },
  Event_7014_Name = {
    Text = "Karanlıktaki Kahkaha"
  },
  Event_7015_ChoiceDesc1 = {
    Text = "[Leave] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7015_Desc = {
    Text = "\"Kurnaz... ve Düzgün bir cevap.\"\nSes, yanıttan etkilenmiş gibiydi; sudan Gümüş bir nesne Belirme yaptı.\n\"Unutma, her şeyin bir bedeli vardır.\""
  },
  Event_7015_Name = {
    Text = "Ötelerden Gelen Sesler"
  },
  Event_7016_ChoiceDesc1 = {
    Text = "[Catch the Second Butterfly] Bir Komut Kartını İmha Et ve Arg1 Kara Mühür elde et."
  },
  Event_7016_ChoiceDesc2 = {
    Text = "[Linger No Longer]"
  },
  Event_7016_Desc = {
    Text = "Onlar Ruhsal Boyut’un sakinleri mi? Yoksa Çözünme’den doğan bir yaşam mı?\nBu sorularla, bir kelebek fırtınasının içine yürürsün."
  },
  Event_7016_Name = {
    Text = "Gnosis Fırtınası"
  },
  Event_7017_ChoiceDesc1 = {
    Text = "[Observe the Third Butterfly] Bir Komut Kartını İmha Et ve Arg1 Kara Mühür elde et."
  },
  Event_7017_ChoiceDesc2 = {
    Text = "[Linger No Longer]"
  },
  Event_7017_Desc = {
    Text = "Parmaklarındaki Pain katlanılmaz hâle gelir ve hızla bırakırsın."
  },
  Event_7017_Name = {
    Text = "Gnosis Fırtınası"
  },
  Event_7018_ChoiceDesc1 = {
    Text = "[Leave] 25 Kara Mühür al, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7018_Desc = {
    Text = "\"Siz insanların başka cevabı yok mu?\"\nSesin sahibi sabırsız bir homurtu saldı, tüm mekânı titretti.\n\"Açgözlü ve cahilsiniz... İşte bu yüzden sizden yoruldum.\""
  },
  Event_7018_Name = {
    Text = "Ötelerden Gelen Sesler"
  },
  Event_7019_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7019_Desc = {
    Text = "“Merak etme, sadece açgözlü misafire ufak bir cezalandırma verdim. Ne yapayım—bira sevmiyorum~”"
  },
  Event_7019_Name = {
    Text = "Hafıza Kırık Parçası: Bira"
  },
  Event_7020_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7020_Desc = {
    Text = "\"Şarkı söylemeyi kes—\"\nKulak tırmalayan şarkıcıyı uyarır, kulaklarının daha fazla işkence görmesine izin vermezsin."
  },
  Event_7020_Name = {
    Text = "Dar Yolun Canisi"
  },
  Event_7021_ChoiceDesc1 = {
    Text = "[Leave] 2 Uyandırıcıyı Uyanışa Çağır"
  },
  Event_7021_Desc = {
    Text = "Arkanı dönersin ve kendini uzun bir koridorda kaybolmuş bulursun.\nSonu gelmeyen koridor, sabrını tamamen tüketir; ta ki küçük, yıpranmış bir sahne fark edene dek.\nGözlerini kırpıştırırsın ve sahne yok olur."
  },
  Event_7021_Name = {
    Text = "Son Perde II"
  },
  Event_7022_ChoiceDesc1 = {
    Text = "[Raise the Goblet] [Bal Şarabı] elde et"
  },
  Event_7022_Desc = {
    Text = "Bir fincan berrak altın rengi sıvı, geç sonbahar buğdayının altın dalgaları gibi parıldıyor ve bal gibi tatlı bir koku yayıyor. İçindekiler ne? Onu buraya kim koydu? Neden başıboş bırakılmış?\nBu sorular yanıtlanmadan, gizemli bir düşünce zihninize sızıyor: Onu şimdi, hemen içmelisiniz.\nBu anda, aniden alevle büyülenmiş bir pervaneye, bir Nepenthes tarafından tuzağa düşürülmüş bir böceğe dönüşüyorsunuz, kontrolsüzce o tatlı şarap kadehine uzanıyorsunuz—"
  },
  Event_7022_Name = {
    Text = "Bal Şarabı"
  },
  Event_7023_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7023_Desc = {
    Text = "Bu kapıyı incelemeye çalıştın. Ona dokunduğun anda kapı yok oldu ve uzaktan bir şeyin açıldığını duydun."
  },
  Event_7023_Name = {
    Text = "Tuhaf Kapı"
  },
  Event_7024_ChoiceDesc1 = {
    Text = "[No Action]"
  },
  Event_7024_ChoiceDesc2 = {
    Text = "[Wipe Palm Print]"
  },
  Event_7024_Desc = {
    Text = "Francis’in ofisi soğuk ve lekesiz; titiz mizacını yansıtıyor.\nBir köşede, bir kutunun üzerinde, 5 inç karelik bir toz izi buluyorsun.\nİz tuhaf—merkezinde küçük bir insan kızın el izi bulunan bir canavar pençesi silueti. Sanki önce kızın eli değmiş, ardından devasa pençe gelip onu bütünüyle örtmüş gibi.\nİnsan, evcilleştirilmiş bir canavarın, teselli edercesine patisini kızın elinin üzerine usulca koyduğu şefkatli bir sahneyi hayal edebilir.\nAma sen gerçeği biliyorsun—bu, acımasız deneylere maruz bırakılmış melez bir yaratığın bıraktığı iz."
  },
  Event_7024_Name = {
    Text = "Devasa Yaratığın İzi"
  },
  Event_7025_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7025_Desc = {
    Text = "Psyche Deepdive denekleri seni tüketti ve kısacık bir soluklanma anı bile çöldeki yağmur gibi geliyor."
  },
  Event_7025_Name = {
    Text = "Sonsuzluk Kapısı"
  },
  Event_7026_ChoiceDesc1 = {
    Text = "[Master] Lanetli Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7026_ChoiceDesc2 = {
    Text = "[Onu Al Götür] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: [(EnchantConfig.Arg1)]"
  },
  Event_7026_ChoiceDesc3 = {
    Text = "[Disassemble It] 50 Kara Mühür al"
  },
  Event_7026_Desc = {
    Text = "Yürürken yanlışlıkla bir şeye tekme atıyorsun.\nBu, camı kırılmış ve D-Slime’la kaplanmış bir pusula. Onu dikkatle ters çevirdiğinde, arka yüzüne kazınmış Mythag Üniversitesi armasını güçlükle seçebiliyorsun."
  },
  Event_7026_Name = {
    Text = "Onun Seçimi"
  },
  Event_7027_ChoiceDesc1 = {
    Text = "[Read the Letter] Bir Komut Kartı İmha Et ve Arg1 Kara Mühür al."
  },
  Event_7027_ChoiceDesc2 = {
    Text = "[Close the Box]"
  },
  Event_7027_Desc = {
    Text = "Bir mektup, bir mektup daha, sonra bir tane daha.\nKâğıt, geçmişinle dolu ve geleceğini resmediyor. Tuhaf bir büyülenme altında, kâğıdı yırtıp yiyip bitirmeden duramıyorsun.\n\"Ha? Yine neye delirdin sen? Havayı mı yiyorsun?\"\nMurphy seni fantazmadan tekmeyle uyandırır. Gerçekliğe döndüğünde, önünde hiçbir şey yoktur."
  },
  Event_7027_Name = {
    Text = "Davetsiz Mektup"
  },
  Event_7028_ChoiceDesc1 = {
    Text = "[Leave] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_7028_Desc = {
    Text = "Sesini duyunca siluet durur; Clementine'in sesi yoğun sisin içinden güçlükle geçer.\n\"Oh— sensin,\" der, belirsiz ve bulanık, suda eriyen ay ışığı gibi. \"Merak etme, iyi olacaksın\"— güzel bir düşünce, ama inanması zor.\n\"Buradaki işin bitince, yeniden buluşacağız.\""
  },
  Event_7028_Name = {
    Text = "Sisin İçindeki Silüet"
  },
  Event_7029_ChoiceDesc1 = {
    Text = "[Recipient: Academic Office] Gümüş Kalıntı [(RelicConfig.Arg1)] elde et."
  },
  Event_7029_ChoiceDesc2 = {
    Text = "[Recipient: My Partner] Gümüş Kalıntı [(RelicConfig.Arg1)] elde et."
  },
  Event_7029_Desc = {
    Text = "Alıcının adını yazarken mektuptan duman yükselir. Görünmez bir el onu zorla kavrayışından kapar—\nÇiğneme sesleri eşliğinde bedenin birden ağırlaşır.\nAma elindeki yadigâr, bu yolculuğun bütünüyle boşuna olmadığını fısıldar."
  },
  Event_7029_Name = {
    Text = "İç Monolog"
  },
  Event_7030_ChoiceDesc1 = {
    Text = "[Insert your Silver Key]"
  },
  Event_7030_Desc = {
    Text = "Aşırı doygun D-balçığın içinde bir şey var gibi görünüyor... Gümüş Anahtar’ı kullanarak onu kendi Gücüne dönüştür."
  },
  Event_7030_Name = {
    Text = "Çökelti Noktası"
  },
  Event_7031_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7031_Desc = {
    Text = "Gölgeden belirmelerini bekleyelim."
  },
  Event_7031_Name = {
    Text = "Fener Kargası"
  },
  Event_7032_ChoiceDesc1 = {
    Text = "[Call the Crow] 35 Kara Mühür al, [(Skill.Arg2)] becerisini geliştir ve seçim yapmaya devam et."
  },
  Event_7032_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_7032_Desc = {
    Text = "Karanlık kuşlar, ilham bulmuşçasına kabarır ve elinin üzerine bir şey tükürür.\nSonra direğe geri uçar, seni delici bakışlarla süzerler."
  },
  Event_7032_Name = {
    Text = "Sürüden Ayrılan Karga"
  },
  Event_7033_ChoiceDesc1 = {
    Text = "[Enter Cave]"
  },
  Event_7033_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7033_Desc = {
    Text = "\"Öhö, öhö, öhö...\"\nNe kadar da tanıdık bir ses... Hatırlıyorum onu, cıkcık!\nİnsanlar hasta olduklarında ya da ölüme yaklaştıklarında bu sesi çıkarır!\nÇabuk gidip bak, cıkcık!"
  },
  Event_7033_Name = {
    Text = "Depths of the Cave"
  },
  Event_7034_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7034_Desc = {
    Text = "Gümüşler hakkında her şeyi inceledin; derecelerini nasıl değerlendirmen gerektiğini bile.\nAçıkça, bu Gümüşler arıtma için temel gereklilikleri karşılamıyor.\nOnları, içlerinde hapsolmuş olabilecek parçalanmış Ruhlarla birlikte terk etmelisin.\nBırakmayı öğrenmek, bir Koruyucu için vazgeçilmez bir derstir."
  },
  Event_7034_Name = {Text = "Tutsak Ruh"},
  Event_7035_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7035_Desc = {
    Text = "Bu bir Tek Yön Geçit; buradan girişe geri dönemezsin."
  },
  Event_7035_Name = {Text = "Geçit"},
  Event_7036_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7036_Desc = {
    Text = "Ne kadar çabuk biterse, o kadar çabuk dinlenebiliriz. Mythag müfettişleri asla tehlikeden korkmaz."
  },
  Event_7036_Name = {
    Text = "Sonsuzluk Kapısı"
  },
  Event_7037_ChoiceDesc1 = {
    Text = "[Lütfen çekilin, acil bir meselem var.]"
  },
  Event_7037_ChoiceDesc2 = {
    Text = "[Would Love to Hear More]"
  },
  Event_7037_Desc = {
    Text = "“Affedersiniz, lütfen bekleyin. Ciddi ve telaşlı görünüyorsunuz; belli ki bir tür açmazın içine düşmüş olmalısınız.\nNe var ki insan, içinde bulunduğu çıkmaz yüzünden ne genel bakışını ne de sükûnetini yitirmemelidir.\nMesela ben, son birkaç gündür Kerberos efsanesiyle mevcut durum arasındaki pek çok tutarsızlığı ciddiyetle düşünüp duruyorum.”"
  },
  Event_7037_Name = {
    Text = "Garip Yol Arkadaşı II"
  },
  Event_7038_ChoiceDesc1 = {
    Text = "[Receive the Gift]"
  },
  Event_7038_ChoiceDesc2 = {
    Text = "[Decline Kindly]"
  },
  Event_7038_Desc = {
    Text = "Çocuk pencere pervazına oturmuş, sana bakıyor. Uzun zamandır seni Bekleyiş içindeydi.\n“Gösteri başarılı oldu, t-teşekkür ederim.”\n“Ben yakında gideceğim... Bu da senin için bir hediye.”\nÇocuk elini sana uzatır.\nGüzelce paketlenmiş bir hediye kutusu görürsün; içinden sızan kan, çocuğun elini boyamaktadır."
  },
  Event_7038_Name = {
    Text = "Son Perde VI"
  },
  Event_7039_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7039_Desc = {
    Text = "Dilerim bu tür bir güveni daima koruyabilirsin."
  },
  Event_7039_Name = {
    Text = "Biçimsiz Yansıma"
  },
  Event_7040_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7040_Desc = {
    Text = "Bu küçük, yumuşak kulağı alıyorsun.\nYapışkan Balmumu’na sarılı, avucunun ortasında sessizce yatıyor.\nİçinde güçlü bir sorumluluk duygusu kabarıyor.\nÖncelikle, bara gitmek yasak; oradaki müzik fazla gürültülü.\nİkinci olarak, Wellington Bahçe Tiyatrosu da olmaz; orkestrası çoktan demode.\nSonra...\nSen ve yoldaşların, artık yeni küçük bir evcil hayvanınız olduğu gerçeğini hiç zorlanmadan kabulleniyorsunuz."
  },
  Event_7040_Name = {Text = "Kulak Ver"},
  Event_7041_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7041_Desc = {
    Text = "\"Profesör Alistair, Mythag'ın temel taşıdır. Onsuz her şey işlemez hale gelir.\"\nCzort'un bunu uykulu bir derste, ciddi bir ifadeyle tahtaya vurarak söylediğini belli belirsiz hatırlarsın.\nBu temel taş çökerse, sen ne yapardın? Derin bir korku seni yutar.\n\"Nereye gidiyorsun?\" Ramona'nın sesi seni gerçeğe geri çeker.\nBu geçmiş miydi yoksa gelecek mi, gerçek mi hayal mi, yoksa başka bir boyuttan bir rüya mıydı? Bilemezsin.\nElinde bir \"Hediye\" belirir."
  },
  Event_7041_Name = {
    Text = "Kaos Uluması"
  },
  Event_7042_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7042_Desc = {
    Text = "\"Bu tekerlekli sandalye benim ikinci bacak çiftim; muhtemelen bu hayatımda ondan hiç ayrılamayacağım,\" dedi Profesör Alistair acı bir gülümsemeyle, \"ama talihsiz olan şu ki, beni çok daha kısa gösteriyor.\"\n\nDemek ki bu, gerçek Profesör Alistair olamaz."
  },
  Event_7042_Name = {
    Text = "Kaos Uluması"
  },
  Event_7043_ChoiceDesc1 = {
    Text = "[Kim Konuşuyor?] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_7043_ChoiceDesc2 = {
    Text = "[Ne Viskisi, Bana da Tattır] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_7043_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7043_Desc = {
    Text = "\n \"Gerçekten bir yudum almayacak mısın? Bu üst düzey viski. Bar sahibinin bana koca bir şişeyi bağışlamasaydı, seninle bir damlasını bile paylaşmaya cesaret edemezdim.\"\n \"Demek o solgun, lastik derili, sadece Bloody Mary içen heriften kurtulmasına yardım ettin? O soruşturma için sana verdiği ödül bu kadar mıydı? Bir ayını harcadın, otuz haneye gittin, on bir kapı yüzüne kapandı ve on yedi tabanca mermisini tükettin. Bir şişe viski... Yaptığın masrafı bile çıkaramıyorsun.\"\n \"Peki, peki, bu kadar cimri olma. En azından şimdi elimizde bu şişe viski var, değil mi?\""
  },
  Event_7043_Name = {
    Text = "Anı Parçası: Viski"
  },
  Event_7044_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7044_Desc = {
    Text = "Uyandıran’ın dokunaçlarını yakalarsın; sana dönüp bakar, gözleri belirsiz bir ışıkla parlar.\nHiçbir şey söylemez, ama gizli mesajı anlarsın—\n \"Had aşımı.\""
  },
  Event_7044_Name = {
    Text = "Kelebek Etkisi"
  },
  Event_7045_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7045_Desc = {
    Text = "Telgraf makinesi tamamen bozulmuş. Fırtına sırasında sahibinin yaşadığı umutsuzluğu hayal edebiliyorsun... tıpkı şu an senin hissettiğin gibi."
  },
  Event_7045_Name = {
    Text = "Kadim Miras"
  },
  Event_7046_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7046_Desc = {
    Text = "İsim: Leigh\nYaş: 20\nKomplikasyonlar: Şiddetli histeri eşliğinde Kan Hırsı\nHiperplazi: Koyu kırmızı Dokunaçlar @2 ağız parçaları\nNakiller: Doğrudan kan akrabalarından alınmış organlar ve dokular @3\nNakil Nedeni: Özel bir sebep yok. Sadece ondan hoşlanmıyorum.\n(Geri kalanı çizilmiş)"
  },
  Event_7046_Name = {
    Text = "Organ Kaydı"
  },
  Event_7047_ChoiceDesc1 = {
    Text = "[Receive Blessing] Tüm Kara Mühürleri kaybet. Bir Altın Kalıntı edin."
  },
  Event_7047_Desc = {
    Text = "Önünde titreyen bir siyah sümüksü kütle beliriyor ve sana bir belge uzatıyor.\n \"Şu an dışarı çıkamam... ama özel hizmetlerimize göz atabilirsin...\"\nKadın sesi, sanki bir şeyden saklanıyormuş gibi, hafif paniğe kapılmış halde, sümüğün göğsünün içinden süzülüyor.\n \"Peri Lütufları, üyelik seviyesine göre etkinleştirilir, herkes için adil olması garanti edilir.\"\n \"İmzala, çabuk!\""
  },
  Event_7047_Name = {
    Text = "Fae's Blessing"
  },
  Event_7048_ChoiceDesc1 = {
    Text = "[Listen Closely] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ama \"(Skill.Arg2)\" geliştir."
  },
  Event_7048_ChoiceDesc2 = {
    Text = "[Inspect] Tüm Uyandıranlar 50 Aliemus kazanır, ama sen [(Skill.Arg1)] geliştirirsin."
  },
  Event_7048_ChoiceDesc3 = {
    Text = "[Leave Directly] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_7048_Desc = {
    Text = "\"Biliyor muydun?\" Ramona gizemli silueti ararken, bir ses aniden fısıldadı: \"O meseleyi biliyor musun? O dehşet derecede önemli meseleyi?\""
  },
  Event_7048_Name = {
    Text = "Başkasının Kulakları"
  },
  Event_7049_ChoiceDesc1 = {
    Text = "[Focus] En fazla 2 Semptom kartını İmha Et."
  },
  Event_7049_ChoiceDesc2 = {
    Text = "[Meditate] Bir Uyandırıcıyı Uyanış’a geçir."
  },
  Event_7049_ChoiceDesc3 = {
    Text = "[Connect] Arg2 HP Yenile."
  },
  Event_7049_Desc = {
    Text = "Sis ağır ağır yapışırken, rozetin solgun bir gümüş titreşimle yanıp sönüyor. İletişimci cızırtıyla hayata dönüyor. Biri arıyor."
  },
  Event_7049_Name = {Text = "Kavşak"},
  Event_7050_ChoiceDesc1 = {
    Text = "[Handle Carefully] Maks. HP’yi Arg1 kadar artır"
  },
  Event_7050_ChoiceDesc2 = {
    Text = "[Öne Çık] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte et"
  },
  Event_7050_Desc = {
    Text = "Boyut’un çağırdığı bir gölge, silikleşen siluetiyle sana doğru elini uzatıyor.\nBir zamanlar bu gemiye bir Mythag Müfettişi’nin bindiğini hatırlıyorsun. Acaba o mu?\nYoksa yalnızca Boyut’a zincirlenmiş başka bir sefil anı mı?"
  },
  Event_7050_Name = {
    Text = "Gümüş Anahtar Taşıyıcısı"
  },
  Event_7051_ChoiceDesc1 = {
    Text = "[Leave] \"(RelicConfig.Arg1)\" Altın Kalıntıyı edin, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_7051_Desc = {
    Text = "\"Bak, sırf gelişigüzel bir laf ettim diye, en acil durumu gözden kaçırdım; bu hiç iyi değil.\nDaha fazla oyalanırsak, avın çoktan uzaklara kaçacak.\nÖzür niyetine, bunlar senin için.\"\n\nAdam, başka şeylerden geveleyerek söz ederken, sana belli bir eşyayı uzatır."
  },
  Event_7051_Name = {
    Text = "Garip Yol Arkadaşı II"
  },
  Event_7052_ChoiceDesc1 = {
    Text = "[Leave] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7052_Desc = {
    Text = "\"Dilediğin şeye kavuşasın.\"\nAdam omuz silkti ve kenara çekilerek yolu açtı."
  },
  Event_7052_Name = {
    Text = "Garip Yol Arkadaşı II"
  },
  Event_7053_ChoiceDesc1 = {Text = "[Take It]"},
  Event_7053_Desc = {
    Text = "D-balçıktan arıtılmış, neredeyse cıva benzeri bir Gümüş madde; güçlü zihinsel güç barındırır ve ayinlerde daha fazla Uyanan’ı birbirine bağlamak için kullanılır D-balçıktan arıtılmış, neredeyse cıva benzeri bir Gümüş madde; güçlü zihinsel güç barındırır ve ayinlerde daha fazla Uyanan’ı birbirine bağlamak için kullanılır."
  },
  Event_7053_Name = {Text = "Gümüş"},
  Event_7054_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7054_Desc = {
    Text = "Yolun yeni bir çatallanmasına girersin.\nGüneş her zamanki gibi doğar, insanlar her zamanki gibi ölür ve sen her zamanki gibi kaybolursun.\nHiçbir şey taze gelmez."
  },
  Event_7054_Name = {
    Text = "Göz Labirenti"
  },
  Event_7055_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7055_Desc = {
    Text = "Işıkla kırılarak yansımış, çarpık bir gölgeye benziyor."
  },
  Event_7055_Name = {
    Text = "Barrel Flotsam"
  },
  Event_7056_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7056_Desc = {
    Text = "Arkana döner ve yalnız bir çift deri ayakkabı görürsün.\n\"Affedersin, zarar vermek gibi bir niyetim yok.\"\n\"Eğer bedenimi bulursan, ona en sadık yürüyüş yoldaşının 1. Salon, 45 Numaralı Vitrin'de beklediğini söyle lütfen.\"\n\"—Unutma, dana derisi olanlar, keçi derisi değil.\""
  },
  Event_7056_Name = {
    Text = "Oxford Ayakkabılar"
  },
  Event_7057_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7057_Desc = {
    Text = "Bu, o mezun olmalı—Kollarını Ona açarsın, fakat ardından kemiklerine işleyen buz gibi bir acı gelir.\nAcı dindiğinde, uzuvların olağanüstü derecede güçlenmiştir, hiç olmadığı kadar güçlüdür."
  },
  Event_7057_Name = {
    Text = "Gümüş Anahtar Taşıyıcısı"
  },
  Event_7058_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7058_Desc = {
    Text = "Önündeki sis sanki inceliyor.\n\nBir sonraki hamlen için görüş alanının keskinleştiğini hissediyorsun."
  },
  Event_7058_Name = {
    Text = "Şeytani Sınav"
  },
  Event_7059_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7059_Desc = {
    Text = "Fantazma yaklaşır, anılar kabarır ve berraklık bir darbe gibi iner."
  },
  Event_7059_Name = {Text = "Serap"},
  Event_7060_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7060_Desc = {
    Text = "Onun bilinçaltı, görünmeyen bir şeyleri değiştirmeyi sürdürür."
  },
  Event_7060_Name = {
    Text = "İlahi Bakış"
  },
  Event_7061_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7061_Desc = {
    Text = "Bir kriz anında, Gümüş Çekirdek toplamanın sırası değildir."
  },
  Event_7061_Name = {
    Text = "Varoluşun Kanıtı"
  },
  Event_7062_ChoiceDesc1 = {
    Text = "[Leave] Üç Gümüş Kalıntıdan birini elde et, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7062_Desc = {
    Text = "Silik siluet yavaş yavaş netleşir; ne bir Serseri'dir ne de bir Felaket belirtisi, kanatsız, normal görünen bir Clementine'dir.\n“Ne tesadüf, sen de ay ışığının tadını çıkarmaya mı geldin?” diye gülümseyerek sorar; başından bir baş dönmesi dalgası geçer. “Sisli gecelerde dikkatli olmalısın.\nBuradaki ufaklıklar pek uslu görünmüyor.”"
  },
  Event_7062_Name = {
    Text = "Sisin İçindeki Silüet"
  },
  Event_7063_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7063_Desc = {
    Text = "Alçı blok yere çarpıp parçalandığında, onun bedeni de dağıldı. İstemsiz ulumalar zihnini doldurdu, ama neyse ki zamanında geri çekildin."
  },
  Event_7063_Name = {
    Text = "Flesh Reforged"
  },
  Event_7064_ChoiceDesc1 = {
    Text = "[Hüznü Dinle] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_7064_ChoiceDesc2 = {
    Text = "[Hear Joy] 50 veya daha fazla Aliemus’a sahip her Uyandırıcı için 15 Kara Mühür al."
  },
  Event_7064_ChoiceDesc3 = {
    Text = "[Leave] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_7064_Desc = {
    Text = "Melodik, lirik, neşeli, hüzünlü... Ezgi, kaynağı belirsiz biçimde Gizli Diyar'da yankılanıyor.\nBu, hayalet geminin ses sisteminden gelen bir senfoni mi, yoksa Gizli Diyar'a zincirlenmiş bir gece yarısı Rapsodi'si mi?"
  },
  Event_7064_Name = {
    Text = "İsimsiz Yankı"
  },
  Event_7065_ChoiceDesc1 = {
    Text = "[They're Searching for Someone] Bir Komut Kartı İmha Et ve 25 Kara Mühür kazan."
  },
  Event_7065_ChoiceDesc2 = {
    Text = "[They're Searching for Something] Bir Kartı kopyala, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7065_Desc = {
    Text = "Işık Taşıyıcı Tarikatçıları neden Rye’da ortaya çıktı? Burada fazlasıyla sır var.\nCehennem Köpeği Cerberus, Francis, Rye Sanatoryumu’nun müdürü, Heykeltıraşlar Birliği, Işık Taşıyıcı Kilisesi...\nHepsini bu ıssız kasabaya çeken bir kaynak olmalı.\nDaktilo aniden siyah mürekkep tükürüyor, sanki senden bir şeyler yazmanı talep eder gibi."
  },
  Event_7065_Name = {
    Text = "Gizem Girdisi"
  },
  Event_7066_ChoiceDesc1 = {
    Text = "[Tightly Close Your Eyes]"
  },
  Event_7066_ChoiceDesc2 = {
    Text = "[Escape Scene]"
  },
  Event_7066_Desc = {
    Text = "Gösteri aniden kesilir. Etrafa bakarsın ve seyircilerin seni çepeçevre sardığını görürsün.\nHepsinin yüzü çocukla aynıdır, tek bir beden gibi sana bakarlar.\nAh—\nSessizce, simsiyah ağızlarını sana doğru açarlar."
  },
  Event_7066_Name = {
    Text = "Son Perde V"
  },
  Event_7067_ChoiceDesc1 = {
    Text = "[Pick up the Photo] 3 Komut Kartı’ndan 1’ine [(EnchantConfig.Arg1)] Yakarı’nı kazır."
  },
  Event_7067_ChoiceDesc2 = {
    Text = "[Check Film] [(Skill.Arg1)] Semptomunu geliştir ve kazınacak Yakarışı değiştir.(Kullanım: 1/2)"
  },
  Event_7067_Desc = {
    Text = "Filmi loş kırmızı ışığın altına yerleştiriyorsun; yarı saydam tabakanın ardından silik imgeler beliriyor.\nEller, ayaklar, gözbebekleri, organlar... akla gelebilecek ve gelemeyecek her insan parçası filmde sadakatle kaydedilmiş.\nHepsi özenle temizlenmiş ve dizilmiş, ilk kafiyeli şiirin kadar düzenli."
  },
  Event_7067_Name = {
    Text = "Birebir Kayıt"
  },
  Event_7068_ChoiceDesc1 = {
    Text = "[Princess's Guard] Rastgele bir Uyandırıcıyı Uyanışa geçir, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7068_ChoiceDesc2 = {
    Text = "[Thinker] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7068_Desc = {
    Text = "\"Da, da, da...\"\nAyak Sesleri uzaklardan yaklaştı ve birinin stüdyonun büyük kapısını itip açmak üzere olduğunu gördün.\nArtık kaçacak yerin kalmadığından, loş ışıkta bir Balmumu Heykelmiş gibi yapmaktan ve o delici bakıştan saklanmaya çalışmaktan başka çaren yoktu."
  },
  Event_7068_Name = {
    Text = "Kusursuz Kılık Değiştirme"
  },
  Event_7069_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7069_Desc = {
    Text = "\"Harika, harika!\" Ses sevinçle dolup taşıyordu. \"Sonunda benim gibi oldun, Sasha Abla!\""
  },
  Event_7069_Name = {
    Text = "\"Sasha Abla\""
  },
  Event_7070_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7070_Desc = {
    Text = "Belki de birileri onları buraya sürükledi.\nKeşfine devam ettikçe, o kişinin kimliği er ya da geç gün yüzüne çıkacak."
  },
  Event_7070_Name = {
    Text = "Gizem Girdisi"
  },
  Event_7071_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7071_Desc = {
    Text = "Ne kadar çabuk biterse, o kadar çabuk dinlenebiliriz. Mythag müfettişleri asla tehlikeden korkmaz."
  },
  Event_7071_Name = {
    Text = "Sonsuz Kapılar"
  },
  Event_7072_ChoiceDesc1 = {
    Text = "[Choose Morality] Arg1 CP Yenile"
  },
  Event_7072_ChoiceDesc2 = {
    Text = "[Choose HP] Tüm CP’yi geri kazan, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_7072_Desc = {
    Text = "Bir zamanlar altın bir kalbin vardı belki.\nGeceni gündüzüne katarak durmadan atar, hayatın ve rüyaların için çabalardı... sıcak, tutkulu ve umut dolu.\nAma bir noktada yavaşladı. Sanki hayatla ahlak arasında sıkışmış gibi, yalnızca birini taşıyabildi."
  },
  Event_7072_Name = {
    Text = "Lanetli Özlem"
  },
  Event_7073_ChoiceDesc1 = {
    Text = "[Pick up the Photo] 3 Komut Kartı’ndan 1’ine [(EnchantConfig.Arg1)] Yakarı’nı kazır."
  },
  Event_7073_ChoiceDesc2 = {
    Text = "[Check Film] [(Skill.Arg1)] Semptomunu geliştir ve kazınacak Yakarışı değiştir.(Kullanım: 2/2)"
  },
  Event_7073_Desc = {
    Text = "\n \"Demek her şeyi dürüstçe kaydettin.\"\n \"Evet, gerçek filmde saklı.\"\nKonuşma aniden kesildi ve sayısız görünmez göz sana çevrildi, sanki son hükmünü bekliyormuş gibi."
  },
  Event_7073_Name = {
    Text = "Görgü Tanığı İfadesi"
  },
  Event_7074_ChoiceDesc1 = {
    Text = "[Leave] Azami CP’yi Arg1 kadar artır ve 25 Kara Mühür kazan."
  },
  Event_7074_Desc = {
    Text = "Sesin uğuldayan rüzgâr tarafından yutuluyor.\n“Beni tanıman gerekmiyor,” tıslama gitgide berraklaşıyor, “Herbert, aradığın kişi Herbert. Bırak sahte düşten sert, soğuk gerçeğe düşsün.”\n“Sana lütfumu bahşedeceğim, sana en leziz olanı sunacağım...”"
  },
  Event_7074_Name = {
    Text = "Garip Yol Arkadaşı VI"
  },
  Event_7075_ChoiceDesc1 = {
    Text = "[Leave] \"(RelicConfig.Arg1)\" Kalıntısını elde et, fakat \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_7075_Desc = {
    Text = "\n \"Evet, zavallı kayıp ruh, güce sahip ama kendini tanıyamıyor.\nEl mi uzatacaksın? Yoksa Silahını Ona mı doğrultacaksın?\"\nAdam coşkun suya atladı. Tam silueti düşmek üzereyken, bakışların tesadüfen onunkiyle kesişti. Bu, bir yılana ait, altın, bal rengi, yarık göz bebekleriydi.\nVe az önce durduğu yerde, mor duman salan küçük bir lamba vardı."
  },
  Event_7075_Name = {
    Text = "Garip Yol Arkadaşı VI"
  },
  Event_7076_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7076_Desc = {
    Text = "\"Tedbirlilik bir erdemdir, fakat aşırı tedbirlilik bir tür zamansızlıktır,\" memnuniyetsizlikle yüklü tekdüze bir ses şöyle dedi: \"Yıldızların devinimi, Uyanan’ın hafif uykusunun kökenini rahatsız edecek ve doğru zamanlama, onların Aliemus’unu, balon şişirir gibi, hızla kabartabilir. Kısacası, hâlâ kuyruklu yıldızın kuyruğunu yakalamak için zaman var; bir dahaki sefere, kaplumbağadan hallice olmayan tepki hızını optimize etmeyi unutma.\""
  },
  Event_7076_Name = {Text = "Yükseliş"},
  Event_7077_ChoiceDesc1 = {
    Text = "[Restore] Mevcut Stresi yarıya indir."
  },
  Event_7077_Desc = {
    Text = "Dengeleyici hazneye dokunur, mevcut stres seviyeni eski hâline getirirsin."
  },
  Event_7077_Name = {
    Text = "Stres Denge Noktası"
  },
  Event_7078_ChoiceDesc1 = {
    Text = "[Ona Teselli Et] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: [(EnchantConfig.Arg1)]"
  },
  Event_7078_ChoiceDesc2 = {
    Text = "[Blame Her] \" (EnchantConfig.Arg1)\" Yakarışını rastgele 3 Komut Kartına kazı, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7078_Desc = {
    Text = "\"Ben, ölmüş müfettişin gölgesiyim, katil ise şu gümüş anahtar.\"\nKadın, dayanılmaz bir acıyla başını kavradı. Gür saçlarının arasında sayısız pırıltılı göz, kırpınıp duruyordu...\n \"Her zaman şöyle derlerdi: Hayır, Charlotte! Yazık, Charlotte!\nBen de düşündüm ki, eğer bir anda birçok Uyanan’ı birbirine bağlayabilirsem, herkes susar.\"\n \"Sonra... Ne olduğunu bilmiyorum, uyandığımda böyle olmuştum. Yazık!\""
  },
  Event_7078_Name = {
    Text = "Müfettişin Gölgesi"
  },
  Event_7079_ChoiceDesc1 = {
    Text = "[Climb the Wall] Lanetli Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7079_ChoiceDesc2 = {
    Text = "[Labirente Gir] Rastgele 1 Kart Mühür kazanır: [(EnchantConfig.Arg1)]"
  },
  Event_7079_Desc = {
    Text = "Beynin bir labirent.\nPek çok düşünce birbirine dolanmış, çıkış Bakışın erişebildiği yerde; düşüncenin yüksek duvarları aranızda sıralanmış."
  },
  Event_7079_Name = {
    Text = "Zihin Labirenti"
  },
  Event_7080_ChoiceDesc1 = {
    Text = "[Gaze at Phantasm] 3 Gümüş Kalıntıdan 1’ini Elde Et"
  },
  Event_7080_ChoiceDesc2 = {
    Text = "[Near Phantasm] Gümüş Kalıntılar \"(RelicConfig.Arg1)\" ve \"(RelicConfig.Arg2)\"yi elde et, fakat \"(Skill.Arg3)\"ü iki kez geliştir."
  },
  Event_7080_Desc = {
    Text = "Uzakta, sanki bir volkan konisi patlamış, fırtınalı göğe insan biçimli bir duman yükseliyor.\nOysa burası, yalnızca sonsuz, başdöndürücü Sıradağlar ve kireçtaşı karst mağaralarından oluşan Elworth.\nSüregiden anormallikler seni ruhsal bir Şaşkınlığa mı sürükledi?"
  },
  Event_7080_Name = {
    Text = "Yanardağ Hayaleti"
  },
  Event_7081_ChoiceDesc1 = {
    Text = "[What Did I See] Gümüş Kalıntı [(RelicConfig.Arg1)] elde et"
  },
  Event_7081_ChoiceDesc2 = {
    Text = "[I Saw Nothing] Altın Kalıntı \"(RelicConfig.Arg1)\" elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_7081_Desc = {
    Text = "Gözlerinin kenarlarından sıvı sızıyor, yapışkan hissi tedirgin edici.\nSonunda, bunu tetikleyen gördüklerindi—ya da gerçekten hiçbir şey görmemiş olabilir misin?"
  },
  Event_7081_Name = {
    Text = "Görülmez Olan"
  },
  Event_7082_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7082_Desc = {
    Text = "Sevinci hissettin. Kederi hissettin. Şimdi seni boğan duyguların sana ait olmadığını fark ediyorsun.\nGözlerini kapatıp kulaklarını tıkarken, Gümüş Anahtar göz alıcı bir ışıkla parlar.\nHer şey yoluna girecek. Sonunda derin bir nefes alabilirsin."
  },
  Event_7082_Name = {Text = "İhtiras"},
  Event_7083_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7083_Desc = {
    Text = "Hançer’i kuşanan, gece yarısı mezarlığında öten bir ölüm kuşunu andıran bir çığlık salıverir.\nSes anında yok olur, diğer iki Denizci de kaybolur... Meğer hepsi, Gizli Diyar’ın yansıttığı bir Düş’ten ibaretmiş."
  },
  Event_7083_Name = {
    Text = "Relentless Hunt"
  },
  Event_7084_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7084_Desc = {
    Text = "Havada sessizce süzülür, kırpışmadan, O'nun Bakışı içtendir—sanki sana bir şey anlatmaya çalışıyormuş gibi.\nGözler bir ruh barındırabilir, ama söz olmadan yalnızca hafif bir telaş ve belli belirsiz bir keder sezebilirsin.\nBir anda havaya karışıp yok olur."
  },
  Event_7084_Name = {
    Text = "Kör Bakış"
  },
  Event_7085_ChoiceDesc1 = {
    Text = "[Agree] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\"yi geliştir."
  },
  Event_7085_ChoiceDesc2 = {
    Text = "[Gift] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\"yi geliştir."
  },
  Event_7085_ChoiceDesc3 = {
    Text = "[Turn and Leave] 25 Kara Mühür al"
  },
  Event_7085_Desc = {
    Text = "\n\"Eğer bir gün düşmek zorundaysam, suya düşmeyi isterim.\nBurun deliklerimi örten akan su, nazik, eski bir düş gibi gelir.\nİçine battığım o sıvı\n@2'in en çok arzuladığı kâsedir.\""
  },
  Event_7085_Name = {Text = "Su Ayini"},
  Event_7086_ChoiceDesc1 = {
    Text = "[Resist Phantasm] Altın Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7086_ChoiceDesc2 = {
    Text = "[Extract Aliemus] Rastgele 2 Uyandırıcıyı Uyanış’a çağır, ancak [(Skill.Arg1)] becerisini iki kez geliştir."
  },
  Event_7086_Desc = {
    Text = "Parçalanmış boyut yavaşça çökerken, diğer boyutlardan gelen fantazmalar, çıldırmış odaya sel gibi doluyor."
  },
  Event_7086_Name = {
    Text = "Boyutsal Hayalet"
  },
  Event_7087_ChoiceDesc1 = {
    Text = "[Leave] Rastgele bir Uyanışçı’yı uyandır"
  },
  Event_7087_Desc = {
    Text = "Kız duraksar, eteğini siler.\n \"Senin için yapabileceğim... sadece bu kadar.\""
  },
  Event_7087_Name = {
    Text = "Beyaz Elbiseli Kız"
  },
  Event_7088_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7088_Desc = {
    Text = "Kim konuşuyor?\nAşağı bakıyorsun ve bulanık bir yansıma görüyorsun—seninle aynı kıyafetleri giyiyor ama elinde bir bıçak tutuyor, sana gülümsüyor."
  },
  Event_7088_Name = {
    Text = "Aramaman Gereken Şey"
  },
  Event_70892_ChoiceDesc1 = {
    Text = "[Follow the Body's Memory] Savaşı atla ve anında zafer kazan, ancak Arg1 CP kaybet."
  },
  Event_70892_ChoiceDesc2 = {
    Text = "[Leave] Savaşa Gir"
  },
  Event_70892_Desc = {
    Text = "Düşman olağanüstü güçlü olsa da, onu alt etme tekniklerine zaten iyice hâkimsin."
  },
  Event_70892_Name = {
    Text = "Kas Hafızası"
  },
  Event_7089_ChoiceDesc1 = {
    Text = "[Rake Koum]"
  },
  Event_7089_ChoiceDesc2 = {
    Text = "[Attack the Test Subject]"
  },
  Event_7089_Desc = {
    Text = "Koum, bir denek üzerinde deneme yaparken, onu fırlatmaya hazır şekilde ensesini ısırdı. Aniden, denek başını bir baykuş gibi 180° çevirdi ve Koum’un yüzünü gagaladı."
  },
  Event_7089_Name = {Text = "Arena"},
  Event_7090_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7090_Desc = {
    Text = "Gümüş Anahtar’ı kavrıyor, Boyut’un çalkantıları arasından Köken’in çağrısını hissediyorsun.\nBilinmeyen kötü Cehennem Köpeği’yle savaşmak için mümkün olan her gücü kullanmalısın."
  },
  Event_7090_Name = {
    Text = "Boyutsal Hayalet"
  },
  Event_7091_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7091_Desc = {
    Text = "\n \"Şu müfettişe gelince, küratör onu bizzat sorgulamayı düşünüyor...\nOnu canlı yakalayın...\"\nSes yavaş yavaş zayıfladı ve sonunda Karanlık içinde kayboldu."
  },
  Event_7091_Name = {
    Text = "Kulak Misafiri"
  },
  Event_7092_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7092_Desc = {
    Text = "Ağırlıksızlık hissi seni sarsarak uyandırıyor. Ayaklarının altındaki zemin sağlam ve güvenilir; ayaklarının dibinde ise zarif, kare bir ayna yatıyor."
  },
  Event_7092_Name = {
    Text = "Ayna İçinde Ayna"
  },
  Event_7093_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7093_Desc = {
    Text = "Sen hiçbir zaman Delilik'e düşmüş, çaresi olmayan biriyle tartışmazsın; bu, ruhunun gece yarısının sorgulamasında tamamen Yutulmasına yol açar. Seni bırak gitsin!"
  },
  Event_7093_Name = {Text = "Su Ayini"},
  Event_7094_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7094_Desc = {
    Text = "Balmumu Heykel’in yüzü nasıl olmalı?\nGözlerini kapatıyorsun ve zihninde sayısız bulanık yüz beliriyor.\nSolgun alevli mumlar gibi, karanlık nehirde belirip kayboluyorlar...\nNehri sonuna dek takip ediyorsun; orada tek ve son Balmumu Heykel duruyor.\nOna yaklaştığında görüyorsun ki...@2."
  },
  Event_7094_Name = {
    Text = "Tamamlanmamış Balmumu Heykel"
  },
  Event_7095_ChoiceDesc1 = {
    Text = "[Attack the Dagger-Wielder] Lanetli Kalıntı \"(RelicConfig.Arg2)\" yi edin, ama \"(Skill.Arg1)\" geliştir."
  },
  Event_7095_ChoiceDesc2 = {
    Text = "[Ambush the Blade-Wielder] Gümüş Kalıntılar \"(RelicConfig.Arg2)\" ve \"(RelicConfig.Arg3)\" elde et, ancak \"(Skill.Arg1)\" iki kez geliştir."
  },
  Event_7095_ChoiceDesc3 = {
    Text = "[Trip the Spear-Wielder] Gümüş Kalıntı [(RelicConfig.Arg1)] elde et"
  },
  Event_7095_Desc = {
    Text = "Üç Denizci sana sıkıca yapışmış, çılgın ve ateşli bakışları neredeyse pelerinini tutuşturuyor.\nGeriye dönüp baktığında, üçünün de farklı olduğunu görürsün—\nKocaman bir bıçak savuran Denizci en vahşi şekilde bağırır, ama hareketlerinde bir umursamazlık vardır.\nMızrak tutan Denizci, konuşmayı yeni öğrenen bir çocuk gibi seninle aynı ritimde hareket eder.\nHançeri kavrayan Denizci geride kalır; mırıldandığı saygı duruşu sözleri, fanatikliğinin kanıtıdır."
  },
  Event_7095_Name = {
    Text = "Relentless Hunt"
  },
  Event_7096_ChoiceDesc1 = {
    Text = "[Leave] \"(RelicConfig.Arg1)\" Kalıntısını elde et, fakat \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_7096_Desc = {
    Text = "Hediyeyi dikkatle açarsın.\nKutunun içinde bir çift göz küresi sessizce durmaktadır.\n\"Sana gözlerimi veriyorum.\"\n\"Tıpkı bir zamanlar onun bana yaptığı gibi.\""
  },
  Event_7096_Name = {
    Text = "Son Perde VI"
  },
  Event_7097_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7097_Desc = {
    Text = "Işığın merkezine uzanıp katılaşmış bir Gümüş alıyorsun. Bu kıymetli Hafıza ve Ruh kabı kavurucu derecede sıcak, tuhaf renkler kırıyor.\nTüm ışığı çarpıtmadan önce, yakan acı onu yeniden Karanlık’a fırlatmana neden oluyor."
  },
  Event_7097_Name = {
    Text = "Gece Parıltısı"
  },
  Event_7098_ChoiceDesc1 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7098_Desc = {
    Text = "Çocuğun hediyesini reddettin.\nÇocuk seni boş gözlerle süzdü. Usulca iç çekti.\n\"Öyleyse, hoşça kal.\"\nBu sözlerle, çocuk eğilerek selam verir gibi yaptı ve pencereden aşağı düştü.\nDans eden bir kelebek ya da esen bir rüzgâr gibi kayboldu."
  },
  Event_7098_Name = {
    Text = "Son Perde VI"
  },
  Event_7099_ChoiceDesc1 = {
    Text = "Bir Sade Yakarış seç"
  },
  Event_7100_ChoiceDesc1 = {
    Text = "[Accept Ear] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7100_ChoiceDesc2 = {
    Text = "[Reject Request] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_7100_Desc = {
    Text = "Zarif notalar parmak uçlarından çağlayan gibi dökülüyor.\nMahzun balmumu piyanist, penceresinin yanında tek başına oturuyor.\nBilinç kazandığından beri, balmumu müzesi onun tüm dünyası olmuş.\nFarklı bir şey duymayı arzuluyor, özellikle de... caz denen bir müzik türünü.\nSonunda, kulaklarından birini koparıp onu yanında götürmeni istiyor.\n“Dışarıdaki müziği duymama izin ver... cebine koyman yeter.”"
  },
  Event_7100_Name = {Text = "Kulak Ver"},
  Event_7101_ChoiceDesc1 = {
    Text = "[Connect] Arg2 YP yenile. [ExDesc1]"
  },
  Event_7101_ChoiceDesc2 = {
    Text = "[Meditate] Bir Uyandırıcıyı Uyanış’a çağır. [ExDesc1]"
  },
  Event_7101_ChoiceDesc3 = {
    Text = "[Expel] En fazla 3 Semptom kartını İmha Et ve Arg2 Kara Mühür elde et."
  },
  Event_7101_Desc = {
    Text = "Sis ağır ağır yapışırken, rozetin solgun bir gümüş titreşimle yanıp sönüyor. İletişimci cızırtıyla hayata dönüyor. Biri arıyor."
  },
  Event_7101_Name = {Text = "Kavşak"},
  Event_7101_Tips3 = {
    Text = "Şu anda hiçbir Semptom göstermiyorsun."
  },
  Event_7102_ChoiceDesc1 = {
    Text = "[Accept Challenge]"
  },
  Event_7102_ChoiceDesc2 = {
    Text = "[Punch It] 25 Kara Mühür al"
  },
  Event_7102_Desc = {
    Text = "Yolunu keserek gölgelerden sıska bir siluet çıkar.\nEbediyen zincirlenmiş bir anı, alana sızar ve kendini \"N\" diye tanıtır. Hayalet, elindeki pulları havaya atar, boğuk bir iniltiyle seni O’nun oyununa davet eder.\nÜç renkli pullar önüne saçılır; O’nunla bir \"oyun\" oynamadığın sürece seni bırakmaya niyetli görünmez."
  },
  Event_7102_Name = {
    Text = "Perde Açılıyor"
  },
  Event_7103_ChoiceDesc1 = {
    Text = "[Insert your Silver Key]"
  },
  Event_7103_Desc = {
    Text = "Aşırı doygun D-balçığın içinde bir şey var gibi görünüyor... Gümüş Anahtar’ı kullanarak onu kendi Gücüne dönüştür."
  },
  Event_7103_Name = {
    Text = "Çökelti Noktası"
  },
  Event_7104_ChoiceDesc1 = {
    Text = "[Struggle Awake] Azami HP’yi Arg1 kadar artır"
  },
  Event_7104_ChoiceDesc2 = {
    Text = "[Kendini Derin Uykuya Bırak] Rastgele 2 Komut Kartı Mühür kazan: \"(EnchantConfig.Arg1)\", 2 \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_7104_Desc = {
    Text = "Kollarında parıldayan bir mücevheri beşik gibi sallıyorsun.\nGöğsünden yayılıp bedenini mum ışığı anılarının sıcak parıltısıyla dolduruyor, sonunda zihnine akıyor.\nÇatırtılı közler, şöminenin yanındaki rahat bir koltuk, koyu bir sıcak çay ve ayaklarının dibine kıvrılmış bir kedi...\nBu teselli dolu uyuşuklukta zihnin bulanıyor ve hafif bir uykuya dalıyorsun."
  },
  Event_7104_Name = {
    Text = "Dünün Kucağı"
  },
  Event_7105_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7105_Desc = {
    Text = "Acımasızca, kameranın içinde saklı bir başka film şeridini çekip çıkardın ve seni dilsiz bırakan görüntüleri açığa çıkardın.\nBanyo edilmemiş film, sadakatle şunu kaydetmişti— siyah bir çamur birikintisinin içinde yatan seni."
  },
  Event_7105_Name = {
    Text = "Masumiyeti Kaydet"
  },
  Event_7106_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7106_Desc = {
    Text = "Fotoğraf makinesini dikkatle inceledin; derisi ve siyah-altın kakmaları pürüzsüz bir parlaklık saçıyordu.\nMercek sana doğrultulmuştu; sanki bakıyor ve gizlice gözlüyordu..."
  },
  Event_7106_Name = {
    Text = "Masumiyeti Kaydet"
  },
  Event_7107_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7107_Desc = {
    Text = "Avuç içine toplanan bir avuç ay ışığı, taş tablete serpiştirildi.\nBirisi kalın çamurun altına gömülmüştü; seyredenler bunun doğal bir ölüm olduğunu, yerin altında huzurla uyuyacağını iddia ediyordu.\nOysa gömülü çamur kabardı ve çığlıkların ortasında, gevşek, cansız bir ay sürünerek dışarı çıktı."
  },
  Event_7107_Name = {
    Text = "Ay Gümüşü Kırığı"
  },
  Event_7108_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7108_Desc = {
    Text = "Kelebeğin narin siyah kanatlarına usulca dokunursun. O hafifçe çırpınır, ardından zifiri siyah damlalara dönüşerek avucuna düşer."
  },
  Event_7108_Name = {
    Text = "Var Olmaması Gereken"
  },
  Event_7109_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7109_Desc = {
    Text = "Yalnız ay gökyüzünde yüksekte asılı duruyor, yine de onun duasını—çürümüşlüğün fısıltılarını andıran tuhaf bir ilahiyi—apaçık işitebiliyorsun.\nDua kesiliyor ve sen tam ayrılmak üzereyken, arkanda beyaz bir hayalet beliriyor.\n“Kadere ve duaya tecavüz edenlere, hem lütuflar hem de ceza, vaat edildiği gibi gelecektir.”"
  },
  Event_7109_Name = {
    Text = "Ay Gümüşü Kırığı"
  },
  Event_7110_ChoiceDesc1 = {
    Text = "[Three Points]"
  },
  Event_7110_ChoiceDesc2 = {
    Text = "[Six Points]"
  },
  Event_7110_ChoiceDesc3 = {
    Text = "[One Point]"
  },
  Event_7110_Desc = {
    Text = "Bugün şansın yerinde gibi görünüyor.\nZarlar titriyor ve heyecanlı bir uğultu yayıyor.\nBir sayı tahmin etmeye karar veriyorsun."
  },
  Event_7110_Name = {
    Text = "Eternal Gamble"
  },
  Event_7111_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7111_Desc = {
    Text = "Bu kumar koskoca bir sahtekârlık!\n\"Tseng\" diye yerinden fırlarsın, ama bir baş dönmesi dalgası seni sarar.\nZarlar gürültülü bir uğultu yayar, baştan çıkarıcı bir ses zihninde durmaksızın yankılanır:\n\"Tek olan... son olan...\""
  },
  Event_7111_Name = {
    Text = "Eternal Gamble"
  },
  Event_7112_ChoiceDesc1 = {
    Text = "[Use Silver] Bir Gümüş Kalıntıyı Altın Kalıntı [(RelicConfig.Arg1)]ya Yükselt."
  },
  Event_7112_ChoiceDesc2 = {
    Text = "[Store Silver] Altın Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" ve \"(Skill.Arg3)\" Becerilerini geliştir."
  },
  Event_7112_ChoiceDesc3 = {
    Text = "[Put Back in Drawer] 25 Kara Mühür al"
  },
  Event_7112_Desc = {
    Text = "Masandaki çekmecenin sağ taraftaki ikinci gözünde, yapayalnız bir Gümüş Çekirdek yatıyor. Ona dokunduğunda, fırtınaların ulumasını, kar tanelerinin parçalanışını ve bir flütün ağlayışını işitirsin..."
  },
  Event_7112_Name = {
    Text = "Yalnız Gümüş Çekirdek"
  },
  Event_7113_ChoiceDesc1 = {
    Text = "[Listen Closely] \"(RelicConfig.Arg2)\" Lanetli Kalıntı’yı elde et, ancak \"(Skill.Arg1)\" geliştir."
  },
  Event_7113_ChoiceDesc2 = {
    Text = "[Make a Change] Bir Kalıntıyı İmha Et ve bir ödül kazan."
  },
  Event_7113_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_7113_Desc = {
    Text = "Her melodi dokunaklı değildir.\nSaf uyumsuzluk, bir ağıt biçimini alır."
  },
  Event_7113_Name = {Text = "Uyumsuzluk"},
  Event_7114_ChoiceDesc1 = {
    Text = "[Pick It Up] \"(RelicConfig.Arg2)\" adlı Gümüş Kalıntıyı edin, fakat \"(Skill.Arg1)\"i geliştir."
  },
  Event_7114_ChoiceDesc2 = {
    Text = "[Abandon It] 25 Kara Mühür al"
  },
  Event_7114_Desc = {
    Text = "Saman yığınının gizlenmiş, çürüyen köşesinde, çatlamış D-iz’in içinde, bir şey sessizce yatıyor."
  },
  Event_7114_Name = {
    Text = "Haystack's Leeward"
  },
  Event_7115_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7115_Desc = {
    Text = "Silüet yaklaşmaz. Bir an seni süzer, sonra bir avuç gümüş kuma dönüşür."
  },
  Event_7115_Name = {
    Text = "Gümüş Anahtar Taşıyıcısı"
  },
  Event_7116_ChoiceDesc1 = {
    Text = "[Hold the Tentacle] Tulu’nun yardımını kabul et"
  },
  Event_7116_Desc = {
    Text = "İç çekerek, Tulu sana yetişir.\nAğır, buz gibi uzuvları sana dolanır, düşman saflarına atılma dürtünü bastırır.\n \"Senin yardımcın olacağım, ama sadece şimdilik.\""
  },
  Event_7116_Name = {
    Text = "Elçi'nin Sözü"
  },
  Event_7117_ChoiceDesc1 = {
    Text = "[Get the Key]"
  },
  Event_7117_Desc = {
    Text = "1, 2, 3...\nJenkin masadan 10 fit uzakta.\nKısa bir mesafe, ama ona bir ömür kadar uzun geliyor.\nYumuşak kurdeleleri, altın renkli kelebek şeker kâğıtlarını ve annesinin gözyaşlarını hatırlıyor.\nÇok, çok şey düşünüyor...\nNarin bedeni kara nehirde bata çıka ilerliyor, masaya doğru her adımda biraz daha yaklaşıyor.\nAnahtar çekmecede ve onu elde etmenin bedeli basit: cesaret, çeviklik ve biraz da şans.\nJenkin'in her şeyi var, şans dışında."
  },
  Event_7117_Name = {
    Text = "Nihai Anahtar"
  },
  Event_7118_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7118_Desc = {
    Text = "Bu sadece bir bahis. Kaybetmeyeceksin.\nÜzerine girift desenler işlenmiş madeni para havaya fırlatılır, hızla aşağı süzülür ve avucunda ısınır."
  },
  Event_7118_Name = {
    Text = "Notorious Gambler"
  },
  Event_7119_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7119_Desc = {
    Text = "Bu sadece bir bahis. Kaybetmeyeceksin.\nÜzerine girift desenler işlenmiş madeni para havaya fırlatılır, hızla aşağı süzülür ve avucunda ısınır."
  },
  Event_7119_Name = {
    Text = "Notorious Gambler"
  },
  Event_7120_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7120_Desc = {
    Text = "Bu sadece bir bahis. Kaybetmeyeceksin.\nÜzerine girift desenler işlenmiş madeni para havaya fırlatılır, hızla aşağı süzülür ve avucunda ısınır."
  },
  Event_7120_Name = {
    Text = "Notorious Gambler"
  },
  Event_7121_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7121_Desc = {
    Text = "Bu ciddi Piyano Dersi’ne katılmak gibi bir niyetin yok.\nHer ölçüden sonra, Öğrenciler başlarını zorlukla çevirip dinliyormuş gibi yaparlar.\nÖğretmen hafifçe eğilir, dudakları kıpırdar, dönen gözleri var olmayan bir nota kâğıdına dikilidir.\nNe yaptıklarını açıkça bilmiyorlar ve insanların yıllarını bu mekanik alıştırmaya neden adadığını asla anlayamayacaklar.\nSadece taklit ediyorlar."
  },
  Event_7121_Name = {
    Text = "Piyano Dersi"
  },
  Event_7122_ChoiceDesc1 = {
    Text = "[Insert your Silver Key]"
  },
  Event_7122_Desc = {
    Text = "Aşırı doygun D-balçığın içinde bir şey var gibi görünüyor... Gümüş Anahtar’ı kullanarak onu kendi Gücüne dönüştür."
  },
  Event_7122_Name = {
    Text = "Çökelti Noktası"
  },
  Event_7123_ChoiceDesc1 = {
    Text = "[Recognize Lyrics] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7123_ChoiceDesc2 = {
    Text = "[Hum Softly] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_7123_Desc = {
    Text = "Kadim denizci türküleri gizli diyarda yankılanıyor.\nHapsedilmiş anılar, dalgaları, gökleri ve sert içkileri, kimsenin duymadığı bir dilde söylüyor."
  },
  Event_7123_Name = {
    Text = "Denizci Türküsü"
  },
  Event_7124_ChoiceDesc1 = {
    Text = "[Call the Crow] 20 Kara Mühür al, ancak [(Skill.Arg2)] becerisini geliştir."
  },
  Event_7124_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_7124_Desc = {
    Text = "Zifiri siyah kuşlar bakışlarını sana diker. Uzun bir sessizliğin ardından, kanatlarından bir şey düşer..."
  },
  Event_7124_Name = {
    Text = "Sürüden Ayrılan Karga"
  },
  Event_7125_ChoiceDesc1 = {
    Text = "[Step Forward and Grip] %100 ihtimalle 25 Kara Mühür kazan."
  },
  Event_7125_ChoiceDesc2 = {
    Text = "[Friendly Response] %50 ihtimalle 50 Kara Mühür kazan, %50 ihtimalle hiçbir şey kazanma."
  },
  Event_7125_Desc = {
    Text = "Bilinmeyen kökenli bir kedi, D-balçığın arasında oturuyor; bulanık bedeni, Ruhsal Boyut’a ait olduğunu fısıldıyor.\nBu silik Yansıtma, bilge gözlerle Ramona’ya bakıyor, beyaz patisini kaldırıp onu çağırıyor."
  },
  Event_7125_Name = {
    Text = "Gezinen Sakin"
  },
  Event_7126_ChoiceDesc1 = {
    Text = "[Running North]"
  },
  Event_7126_ChoiceDesc2 = {
    Text = "[Ignore the Sound]"
  },
  Event_7126_Desc = {
    Text = "Düşmanın Saldırıları arkadan Yağmur gibi yağar; Bıçakları pelerini sıyırıp iskeledeki bir martı sürüsünü havalandırır.\n\"Kuzeye git... ya da gemiye bin...\"\nEn ahmak kişi bile görünmeyen bir gücün sana yardım ettiğini hissedebilir."
  },
  Event_7126_Name = {
    Text = "Kuzeye Doğru"
  },
  Event_7127_ChoiceDesc1 = {
    Text = "[Listen to the Sun] Gümüş Kalıntı [(RelicConfig.Arg1)]i elde et"
  },
  Event_7127_ChoiceDesc2 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7127_Desc = {
    Text = "Gerçeklik ile Düş'ün birbirine dolandığı yerde, gök cisimleri ezelden belirlenmiş yörüngelerinde sonsuza dek döner.\nSayısız teğet geçiş, tuhaf ve tekinsiz bir senfoni çalmıştır..."
  },
  Event_7127_Name = {
    Text = "Astral Harmonies"
  },
  Event_7128_ChoiceDesc1 = {
    Text = "[Leave with Sorrow] Bir kart kopyala. Eğer bir Semptom kartı kopyalanırsa, 75 Kara Mühür al."
  },
  Event_7128_ChoiceDesc2 = {
    Text = "[Öfkeyle Ayrıl] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: [(EnchantConfig.Arg1)]"
  },
  Event_7128_Desc = {
    Text = "Göz bebeksinden soğuk ve azgın bir sıvı fışkırdı, ruhun bir parçasını da beraberinde götürerek."
  },
  Event_7128_Name = {
    Text = "Stiks'in Ağıtı"
  },
  Event_7129_ChoiceDesc1 = {
    Text = "[Into the Corridor]"
  },
  Event_7129_ChoiceDesc2 = {
    Text = "[Go Against the Flow] 25 Kara Mühür al"
  },
  Event_7129_Desc = {
    Text = "Solgun ay ışığı, zamanın akışını umursamadan sessiz koridora dökülüyor.\nKapı eşiği, ayın ışınları altında tekinsiz bir parıltı saçıyor."
  },
  Event_7129_Name = {
    Text = "Sessiz Salon"
  },
  Event_7130_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7130_Desc = {
    Text = "Balmumu Heykeli onarmaya karar veriyorsun.\nEtrafta dağılmış bazı aletler var ve “Prusya Mavisi” adlı bir boya seçiyorsun.\nBir hastalık kadar mavi."
  },
  Event_7130_Name = {
    Text = "Tamamlanmamış Balmumu Heykel"
  },
  Event_7131_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7131_Desc = {
    Text = "Püstül, kulaklarda yankılanan doğaüstü bir ıslık, fantazmatik flüt sesleri ve sızan sıvıların yasak Rezonansı eşliğinde keskin, tekinsiz bir Çığlık saldı.\nPüstül bir an için tuhaf biçimde seğirdi, ardından kasılıp Sessizliğe gömüldü. Bunu gören yanındaki Uyandırma sahibi, sanki bir tür çağrı almış gibiydi."
  },
  Event_7131_Name = {Text = "Tuhaf Apse"},
  Event_7132_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7132_Desc = {
    Text = "Parmak uçların heykele dokunuyor, beklenmedik biçimde yumuşak çöküntüleri hissediyorsun. Bunun hep bir Düş olduğunu varsaymıştın."
  },
  Event_7132_Name = {
    Text = "Patchwork Remains"
  },
  Event_7133_ChoiceDesc1 = {
    Text = "[Tear For Her]"
  },
  Event_7133_ChoiceDesc2 = {
    Text = "[Pray to Her]"
  },
  Event_7133_Desc = {
    Text = "Geminin korkuluğuna dokunduğun anda, sana ait olmayan anılar zihnine hücum eder.\nİnsanlar ona saf beyaz bir elbise giydirdiler, zarif mücevherlerle donattılar ve onu yüksek bir sunağa yerleştirdiler. Kasaba halkı ayaklarının dibinde diz çöküp eğildi.\nGözleri umutla doluydu: denizciler seferlerde korumasını diledi, balıkçılar sakin bir balık tutma mevsimi umdu, diğer kasabalılar ise sorunsuz bir yıl arzuladı.\nDiz çöken kalabalığın arasında onun Çocukluk arkadaşları ve en yakın ailesi de vardı.\nO hiçbir şey istemiyordu; ne istediğini bilmiyordu.\nDileklere pasifçe karşılık vermek, sanki hayattaki tek amacıydı."
  },
  Event_7133_Name = {
    Text = "Sefer Öncesi Ritüeller"
  },
  Event_7134_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7134_Desc = {
    Text = "O sakatlanmış bedenin solgun gözbebekleri yavaşça döndü, uzaklaşan siluetini izlerken belli belirsiz bir gülümseme açığa çıktı."
  },
  Event_7134_Name = {
    Text = "Patchwork Remains"
  },
  Event_7135_ChoiceDesc1 = {
    Text = "[Face It] Lanetli Kalıntı \"(RelicConfig.Arg1)\"yı elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_7135_ChoiceDesc2 = {
    Text = "[Direnişten Vazgeç] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: [(EnchantConfig.Arg1)]"
  },
  Event_7135_ChoiceDesc3 = {
    Text = "[Run Away] 50 Kara Mühür al"
  },
  Event_7135_Desc = {
    Text = "Birkaç balmumu heykel bloğu yolunu kapatıyor.\nEğri büğrü ve kaba görünüyorlar; Rogers’tan beklenen ustalığa hiç benzemiyorlar.\n“Emirler... efendinin emirleri...”"
  },
  Event_7135_Name = {Text = "Taslak"},
  Event_7136_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7136_Desc = {
    Text = "\nGözlerin içine cesurca bakmayı seçiyorsun.\nOnlar karanlıkta titreşen parlak yıldızlar.\nSonra gülüyorlar ve sayısız hilal aya dönüşüyorlar.\n\"Bakışlardan korkmuyorsun. Korkmaman gereken...\nUzun zaman oldu görüşmeyeli, @2\"\nYok olmadan önce sana küçük bir hediye bırakıyorlar, bir \"Kavuşma Anısı\" olarak."
  },
  Event_7136_Name = {Text = "Göz"},
  Event_7137_ChoiceDesc1 = {
    Text = "[Switch On] Mevcut görüş alanını genişlet[ExDesc1]."
  },
  Event_7137_Desc = {
    Text = "Kadim bir aydınlatma aygıtı etrafındaki siyah Sisi dağıtır.\nOnu saran Sis, sanki nefesiyle rahatsız edilmiş gibi ritmik biçimde dalgalanır."
  },
  Event_7137_Name = {Text = "Projektör"},
  Event_7138_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7138_Desc = {
    Text = "Sırtından saydam kanatlar açılır, kargalarla birlikte sessiz deniz dibine doğru dönerek ve kıvrılarak süzülür."
  },
  Event_7138_Name = {
    Text = "Kargaların Korosu"
  },
  Event_7139_ChoiceDesc1 = {
    Text = "[Destroy It] [Mutasyona Uğramış Kalp] elde et"
  },
  Event_7139_Desc = {
    Text = "Yol kenarına Bilinmeyen Yaratıklar tarafından bırakılmış çarpık Püstüller, kirli, yağlımsı yeşil bir parıltıyla ışıldıyor; kıvranarak huzursuzca şekil değiştiriyorlar.\nBir canavarı andırmaktan çok, kavurucu güneş altında eriyen dondurmaya benziyor; kısa süre sonra yapışkan bir pelteye dönüşüp havaya karışarak yok oluyor."
  },
  Event_7139_Name = {Text = "Tuhaf Apse"},
  Event_7140_ChoiceDesc1 = {
    Text = "[Lower Your Hands] [(Skill.Arg1)] Semptomunu geliştir ve bir ödül seç."
  },
  Event_7140_ChoiceDesc2 = {
    Text = "[Catch a Crow] [(Skill.Arg1)] Semptomunu geliştir ve bir ödül seç."
  },
  Event_7140_ChoiceDesc3 = {
    Text = "[Close Your Eyes] 50 Kara Mühür al"
  },
  Event_7140_Desc = {
    Text = "Tırmalayan, bitmek bilmeyen bir çığlık—\nKarga Şarkıcısı parlak siyah Kanatlara bürünmüştür; keskin gagası soğuk soğuk parlar, attığı her yaslı çığlık kulak zarlarını deler.\nEllerini kulaklarından çek!\nGecenin kargaları, çığlıklarının şenliği içinde, tir tir titreyen bedenindeki dizginlenmemiş sarsıntılardan kana kana içmek için sabırsızlanır.\n"
  },
  Event_7140_Name = {
    Text = "Song of Crows"
  },
  Event_7141_ChoiceDesc1 = {
    Text = "[Leave] Hiçbir şey bulunamadı"
  },
  Event_7141_Desc = {
    Text = "Aradığın kişi bu değil."
  },
  Event_7141_Name = {
    Text = "Geçici 2_6"
  },
  Event_7142_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7142_Desc = {
    Text = "Devam etmeyi seçtin.\nO dehşet verici balmumu sanatlarının zihninde ve bedeninde açtığı yaralarla kıyaslandığında, bu ufak rahatsızlık hiçbir şey.\nDaha büyük görevlerin var."
  },
  Event_7142_Name = {
    Text = "Ayak Sesleri"
  },
  Event_7143_ChoiceDesc1 = {
    Text = "[Point Out the Issue] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7143_Desc = {
    Text = "\"Ne oldu! Başkalarının yaralarını deşmeye bayılıyor musun?\"\n\"Evet! Hiçbir sebep yokken bir anda yirmi beş yaş yaşlandım! Artık bana Murphy Abla demek zorundasın!\""
  },
  Event_7143_Name = {
    Text = "Zincirlenmiş Hayat"
  },
  Event_7144_ChoiceDesc1 = {
    Text = "[Leave] Üç Gümüş Kalıntıdan birini elde et, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7144_Desc = {
    Text = "Kızın yüzü bu geceki ay ışığı kadar dingin. Sana karşılık vermez, ama elindeki pusulayı havaya kaldırır—titremektedir; sanki o küçük pusulayı kaldırmak bile tüm gücünü tüketmiştir."
  },
  Event_7144_Name = {
    Text = "Beyaz Elbiseli Kız"
  },
  Event_7145_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7145_Desc = {
    Text = "\"Lezzetli! Lezzetli!\" diye kahkaha attı karga; kanatlarını açarken çürümenin kokusu burnuna yayıldı."
  },
  Event_7145_Name = {
    Text = "Lanetli Karga"
  },
  Event_7146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7146_Desc = {
    Text = "Bana göre gürültü, yeni çağın modelidir.\nDüzensiz ritimleri ve delirtici melodileriyle dünyayı acımasızca arşınlar.\nNe merhamet, ne tereddüt, ne de taviz tanır.\nDüzenden nefret eder, temaları çöpe atar, gürültü asla hoşnut etmeye çalışmaz—\nBuna bizim balmumu heykeltıraşımız da dahildir."
  },
  Event_7146_Name = {
    Text = "Kötü Zevk"
  },
  Event_7147_ChoiceDesc1 = {Text = "[Guide]"},
  Event_7147_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7147_Desc = {
    Text = "Birisi usulca kolunu çekiştiriyor.\nDaha önce gördüğün çocuk bu. Köşeye çömelmiş, sana hüzünlü bir ifadeyle bakıyor.\n“-Ş-şey, akademinin gösterisine katılmak istiyorum.\nAma sahneye giden yolu bulamıyorum.”"
  },
  Event_7147_Name = {
    Text = "Son Perde II"
  },
  Event_7148_ChoiceDesc1 = {
    Text = "[Keep Searching] Azami CP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_7148_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7148_Desc = {
    Text = "Burnunun ucu tanıdık, yuva kokusunu andıran, doyurucu bir koku yakalar. Yemekhane aromasından bir nefes daha çekmeye yeltenirken, koku bir anda bütünüyle yok olur."
  },
  Event_7148_Name = {
    Text = "Anormal Temas"
  },
  Event_7149_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7149_Desc = {
    Text = "Onlar sıcak renklerdir.\nTutkulu, yumuşak ve sevgi dolu renkler.\nKıza nostaljik bir sarılış verdiler ve sonra rüzgâr gibi kaybolup gittiler."
  },
  Event_7149_Name = {
    Text = "Özlemin Rengi"
  },
  Event_7150_ChoiceDesc1 = {
    Text = "[Who are you, really?]"
  },
  Event_7150_ChoiceDesc2 = {
    Text = "[How to Change Your Mindset?]"
  },
  Event_7150_Desc = {
    Text = "Uzun saçlı bir adam yine yolunu kesiyor. Önceki deneyimden sonra, Ramona’nın İfadesi dostane olmaktan çok uzak.\n“Sakin ol, dostum,” adam ağır ağır konuşuyor. Sesi mıknatıs gibi çekici ve baştan çıkarıcı; sanki dar bir hava yolundan süzülüp gelen, tıslayan bir sürtünmeyle karışmış bir ses.\n“Bir süredir seni gözlemliyorum; ancak zihniyetini değiştirerek hedefine yaklaşabilirsin.”"
  },
  Event_7150_Name = {
    Text = "Garip Yol Arkadaşı III"
  },
  Event_7151_ChoiceDesc1 = {
    Text = "[I Am Searching] Maks. HP’yi Arg1 kadar artır"
  },
  Event_7151_ChoiceDesc2 = {
    Text = "[Kaçınıyorum] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_7151_Desc = {
    Text = "Ulaşılamaz olana, o kederli akraba şeye, hakikat denilen şeye arayışla bakan birini görüyorum.\nKaçınılmaz olandan, o zalim gizli şeyden, hakikat denilen şeyden kaçan, ondan sakınan birini görüyorum.\nSen hangisisin?"
  },
  Event_7151_Name = {Text = "Aranan"},
  Event_7152_ChoiceDesc1 = {
    Text = "[Examine Closely] Bir Gümüş Kalıntıyı Altın Kalıntı [(RelicConfig.Arg1)]ya Yükselt."
  },
  Event_7152_ChoiceDesc2 = {
    Text = "[Attempt to Listen] Altın Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" ve \"(Skill.Arg3)\" Becerilerini geliştir."
  },
  Event_7152_ChoiceDesc3 = {
    Text = "[Store Carefully] 25 Kara Mühür al"
  },
  Event_7152_Desc = {
    Text = "İlerideki sis, cam ya da kristal parçasını andıran küçücük bir nesneyle aydınlanmıştı; içinde sayısız renk, hem canlı hem soluk tonlarıyla, durmaksızın dönüp duruyordu."
  },
  Event_7152_Name = {
    Text = "Anılarımız"
  },
  Event_7153_ChoiceDesc1 = {
    Text = "[Accept Challenge] Kazanırsan bir Gümüş Kalıntı elde et, kaybedersen bir Semptom geliştir. Sonuç, sonraki Soruşturmayı etkilemez."
  },
  Event_7153_ChoiceDesc2 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7153_Desc = {
    Text = "Yansımadaki kişi kimdir?\nSizinle birlikte nefes alır, kalp atışınızı paylaşır ve aynı tekinsiz fikri içinde taşır.\nBu, Gizli Diyar’ın bir oyunu mu, yoksa boyutları aşan bir gölge mi?\nBu, hayali bir meydan okumaya yapılmış bir davete benziyor."
  },
  Event_7153_Name = {
    Text = "Ruh Rezonansı"
  },
  Event_7154_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7154_Desc = {
    Text = "Görüş, tarihi ve zamanı aşar. Doğrusal olmayabilir; gezegen doğmadan önceki kaostan sana bakıyor olabilir.\nYa da belki, seni uzak bir geleceğin gününde bekliyordur."
  },
  Event_7154_Name = {Text = "Gözle"},
  Event_7155_ChoiceDesc1 = {
    Text = "[Claim] 50 Kara Mühür al"
  },
  Event_7155_Desc = {
    Text = "Alan boştur; yerde akan koyu sıvı hiçbir şeyi yansıtmadan akıp gider.\nBu bir Düş mü? Parmaklarının arasından bir şeylerin kayıp gittiğini hissedersin."
  },
  Event_7155_Name = {
    Text = "Under-Mirror"
  },
  Event_7156_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7156_Desc = {
    Text = "\"Ne kadar cömert bir insansın. Diliyorum ki tüm dileklerin bugün, yarın ve yarından sonra da gerçek olsun.\"\n\"Bu arada, bu tek seferlik bir anlaşma...\"\nPeri, dudaklarını şapırdatarak memnuniyetini belli eder ve isteksizce seninle vedalaşır."
  },
  Event_7156_Name = {
    Text = "Fae's Blessing"
  },
  Event_7157_ChoiceDesc1 = {
    Text = "[Give Me My Wallet Back!] 3 Yakarıştan 1'ini kazı."
  },
  Event_7157_ChoiceDesc2 = {
    Text = "[Tereddüt Et] Rastgele 1 Komut Kartı Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_7157_Desc = {
    Text = "\n\"Haydi, gel de cüzdanını geri al!\" Uzakta bir çocuk el salladı.\nİleri koştun ve tam uzanmışken, zihninde birden yüksek ve kaotik bir gürültü patladı.\n\"Bu pis velet de nereden çıktı?\"\n\"O küçük bir sokak sıçanı! Düşes’in elbisesine dokunmaya nasıl cüret eder!\"\n\"Defedin şunu buradan!\"\n\"Bozuk paran var mı? Bozuk paran yoksa, siyah ekmeğin bir parçasını bile alabileceğini sanma!\""
  },
  Event_7157_Name = {
    Text = "Yokluk Kitabı"
  },
  Event_7158_ChoiceDesc1 = {
    Text = "[Chase the Song] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7158_ChoiceDesc2 = {
    Text = "[Sing Along] [(Skill.Arg1)] Semptomunu geliştir ve kazınacak Yakarışı değiştir.(Kullanım: 2/2)"
  },
  Event_7158_Desc = {
    Text = "Uzak şarkı yıldız tozuna parçalandı:\n“Gece sokağındaki pis su birikintisini lanetliyorum, çürümüş çiçekler dökülen duvara tutunuyor, zincirler zihni çamura sürüklüyor. Sis varlığımı silmeden önce, alacakaranlık en derin @2’e batacak.”"
  },
  Event_7158_Name = {
    Text = "Soluk Lanet"
  },
  Event_7159_ChoiceDesc1 = {
    Text = "[Sunu Bırak] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_7159_ChoiceDesc2 = {
    Text = "[Onu Götür] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_7159_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7159_Desc = {
    Text = "Yaklaştıkça, kaotik ruhlar aniden bataklıktan fışkırır.\nSiyah uzuvlar seni sıkıca sarar, ağlayıp yalvarırlar—\nBir sunu yap ya da onları uzaklaştır."
  },
  Event_7159_Name = {Text = "Kaos Ruhu"},
  Event_7160_ChoiceDesc1 = {
    Text = "[Leave an Offering] Rastgele bir kartın Yakarış niteliğini güçlendir."
  },
  Event_7160_ChoiceDesc2 = {
    Text = "[Onu Götür] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte et"
  },
  Event_7160_Desc = {
    Text = "Yaklaştıkça, kaotik ruhlar aniden bataklıktan fışkırır.\nSiyah uzuvlar seni sıkıca sarar, ağlayıp yalvarırlar—\nBir sunu yap ya da onları uzaklaştır."
  },
  Event_7160_Name = {Text = "Kaos Ruhu"},
  Event_7161_ChoiceDesc1 = {
    Text = "[El Sallayarak Uzaklaştır] Rastgele 1 Komut Kartı Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_7161_ChoiceDesc2 = {
    Text = "[Let It Stay] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7161_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7161_Desc = {
    Text = "Kanatlarında siyah sümüksü bir sıvı taşıyan bir Kelebek, sendeleyerek uçar; ardından rüzgârda katılaşıp pul pul dökülen siyah bir iz bırakır.\nYorulur ve gelip burnunun ucuna konar."
  },
  Event_7161_Name = {
    Text = "Obsidyen Kelebek"
  },
  Event_7162_ChoiceDesc1 = {
    Text = "[El Sallayarak Uzaklaştır] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_7162_ChoiceDesc2 = {
    Text = "[Let It Stay] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7162_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7162_Desc = {
    Text = "Kanatlarında siyah sümüksü bir sıvı taşıyan bir Kelebek, sendeleyerek uçar; ardından rüzgârda katılaşıp pul pul dökülen siyah bir iz bırakır.\nYorulur ve gelip burnunun ucuna konar."
  },
  Event_7162_Name = {
    Text = "Obsidyen Kelebek"
  },
  Event_7163_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7163_Desc = {
    Text = "Yıldızlar gibi parlayan bir ruh, irade gücü ve cesaret görüyorum. O mumla mühürlenmiş anıya doğru ilerle; dileğin yerine getirilecek."
  },
  Event_7163_Name = {Text = "Aranan"},
  Event_7164_ChoiceDesc1 = {
    Text = "[Kalmaya Bırak] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_7164_ChoiceDesc2 = {
    Text = "[Wave Away] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntı'yı edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7164_ChoiceDesc3 = {
    Text = "[Welcome the Butterflies] 25 Kara Mühür al"
  },
  Event_7164_Desc = {
    Text = "Soğuk sanatoryumda dolaşırsın; mevsime inat var olmaması gereken siyah bir kelebek yanından süzülür.\nKanatları, üzerini kaplayan siyah sümüksü sıvıyla, uçarken titrer; rüzgârda katılaşıp soyulan katman katman siyah tortular döker.\nTükenmiş halde, gelip parmak ucuna konar."
  },
  Event_7164_Name = {
    Text = "Var Olmaması Gereken"
  },
  Event_7165_ChoiceDesc1 = {
    Text = "[Leave] Üç Gümüş Kalıntıdan birini elde et, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7165_Desc = {
    Text = "Yorgunluk hissetmeye başlarsın.\nBilinç, seni göletlerin ve Sıradağlar’ın üzerinden taşır,\nGüneşin ötesine, ışık yıllarının ötesine,\nTek ve yegâne... kozmik Beşik’e doğru."
  },
  Event_7165_Name = {
    Text = "Son Perde IV"
  },
  Event_7166_ChoiceDesc1 = {
    Text = "[Look More]"
  },
  Event_7166_Desc = {
    Text = "Devasa bir gölge seni bütünüyle yutar ve ağır kokulu salyası seni sırılsıklam bir fare gibi ıslatır.\n\"Küçük fare, buraya gel. Sadece bir anlığına...\"\n\"Yemin ederim, seni yeme niyetim yok...\"\n\"Şu tombul, sulu göbeğine şöyle bir bakmayacağım bile!\""
  },
  Event_7166_Name = {Text = "Malzeme 12"},
  Event_7167_ChoiceDesc1 = {
    Text = "[Look More]"
  },
  Event_7167_Desc = {
    Text = "Solmuş Balmumu Heykel filozof, beyaz bir duman bulutuna bürünmüş hâlde sigarasını içer.\n\"Öteki kıyı vardır ama bilinemediği için Bilinmeyen Yaratık olarak kalır.\"\n\"Bu dünyayı bir oyun olarak hayal et...\nAradığın şey haritanın öteki tarafında olabilir.\""
  },
  Event_7167_Name = {Text = "Malzeme 45"},
  Event_7168_ChoiceDesc1 = {
    Text = "[Look More]"
  },
  Event_7168_Desc = {
    Text = "\"Üzgünüm, gücenmek yoktu niyetim...\"\n\"Fareleri sevmem. Farelerin sorunu, insanlardan asla korkmamaları...\"\nBakımsız bir ihtiyar köşede uzanmış, hüzünlü gözlerini sana kilitlemişti.\n\"Elbette, sen çok hırslısın.\nBu iyi, ama felaketten kaçmana yardım etmeye yetmez...\"\""
  },
  Event_7168_Name = {Text = "Malzeme 4"},
  Event_7169_ChoiceDesc1 = {
    Text = "[Laneti Göster] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_7169_ChoiceDesc2 = {
    Text = "[Reject the Crow] 3 Yakarıştan 1’ini Oyarak Kazı"
  },
  Event_7169_ChoiceDesc3 = {Text = "[Ignore]"},
  Event_7169_Desc = {
    Text = "Zifiri siyah, hastalıklı, çok başlı bir kuzgun, bir Işık Taşıyıcı Tarikatçısı'nın siyah cübbesinden fırlar ve omzuna konar.\n\"Başımı görüyor musun? Lanetin tadını aldığım sürece yeni bir baş çıkarırım. Bakalım, senin lanetin nasılmış!\""
  },
  Event_7169_Name = {
    Text = "Lanetli Karga"
  },
  Event_7170_ChoiceDesc1 = {
    Text = "[Answer the Call] Bir Komut Kartını İmha Et ve Arg1 YP geri kazan"
  },
  Event_7170_ChoiceDesc2 = {
    Text = "[I'm Not Fleeing] Altın Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" becerisini geliştir"
  },
  Event_7170_Desc = {
    Text = "Sokağın arasından fırlayıp koşuyorsun. Adrenalin kabarıyor, laktik asit birikiyor, glikoz tükeniyor... Zihin, istilaya uğramış bir kaosla dolup taşıyor; seni bu halüsinatif pusun içinde kaçmaya zorluyor.\nEvet, kaç. Eğer kaçmıyorsan, neden kaos ve düş, başarısızlık ve hiçlik seni bekliyor?"
  },
  Event_7170_Name = {Text = "Koş"},
  Event_7171_ChoiceDesc1 = {
    Text = "[Trace Sound Source]"
  },
  Event_7171_ChoiceDesc2 = {
    Text = "[Summon Lily and Koum]"
  },
  Event_7171_Desc = {
    Text = "Boyutsal geçitte, uzaklardan, korku, beklenti ve huzursuzlukla yoğrulmuş boğuk, ağır sesler duyuyoruz; sanki sana sesleniyorlar. Ardından, bir kızın boğuk mırıltıları yavaşça sönüp gidiyor."
  },
  Event_7171_Name = {
    Text = "Yol Gösteren Ses"
  },
  Event_7172_ChoiceDesc1 = {Text = "[Take It]"},
  Event_7172_Desc = {
    Text = "D-balçıktan arıtılmış, neredeyse cıva benzeri bir Gümüş madde; güçlü zihinsel güç barındırır ve ayinlerde daha fazla Uyanan’ı birbirine bağlamak için kullanılır D-balçıktan arıtılmış, neredeyse cıva benzeri bir Gümüş madde; güçlü zihinsel güç barındırır ve ayinlerde daha fazla Uyanan’ı birbirine bağlamak için kullanılır."
  },
  Event_7172_Name = {Text = "Gümüş"},
  Event_7173_ChoiceDesc1 = {
    Text = "[Ask to Clear the Path]"
  },
  Event_7173_ChoiceDesc2 = {
    Text = "[Ask Who He Is]"
  },
  Event_7173_Desc = {
    Text = "Loş ışıklarla aydınlanan bir vagona adım atıyorsun, içinde tekinsiz bir his kabarıyor.\nVagon bomboş; yolcular çoktan kaçmış, geride yavaşça dağılan dağınık canavar kalıntı bedenleri bırakmış.\nVagonun ortasında bir adam duruyor.\n“Kadere inanırım, ve aynı metroya binmemizi sağlayan şey de kaderdir.”"
  },
  Event_7173_Name = {
    Text = "Garip Yol Arkadaşı IV"
  },
  Event_7174_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7174_Desc = {
    Text = "\"Gözlerin çok güzel, yıldızlar gibi.\"\nCharlotte kıkırdadı, çılgınca savrulan saçları usulca duruldu.\n\"Okulda da epey popülersindir. Ben de senden hoşlandım.\"\nAyrılmadan önce alnına bir öpücük kondurdu.\nBedeninin ısındığını hissettin ve bir şeylerin değiştiğini sezdin."
  },
  Event_7174_Name = {
    Text = "Müfettişin Gölgesi"
  },
  Event_7175_ChoiceDesc1 = {
    Text = "[Read] [(EnchantConfig.Arg1)] Yakarışını 3 Komut Kartından 1’ine kazı."
  },
  Event_7175_ChoiceDesc2 = {
    Text = "[Store in Suitcase] \"(RelicConfig.Arg2)\" Kalıntısını elde et, ancak \"(Skill.Arg1)\" Semptomunu geliştir."
  },
  Event_7175_Desc = {
    Text = "Işık Taşıyıcı müridinin cübbesinden sararmış bir sayfa düştü.\nÜzeri tuhaf yazılarla kaplıydı; bazıları hiyeroglife benziyor, bazıları garip biçimde eğik, bazılarıysa üst üste biniyordu. Yalnızca birkaç sözcük güçlükle seçilebiliyordu."
  },
  Event_7175_Name = {
    Text = "Şifreli Emir·Bölüm I"
  },
  Event_7176_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7176_Desc = {
    Text = "\"Yapma, Charlotte! Olmaz!\" diyorsun.\nCharlotte’un saçları çılgınca kıvrılıyor, öfkeden deliye dönüyor.\n \"Sana göstereceğim! Yeteneklerimi iyi izle!\""
  },
  Event_7176_Name = {
    Text = "Müfettişin Gölgesi"
  },
  Event_7177_ChoiceDesc1 = {
    Text = "[Infect with \"(Skill.Arg1)\" and obtain the Silver Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7177_ChoiceDesc2 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7177_Desc = {
    Text = "Etkinlik 302 (Geliştirme Aşamasında), Nihai Olmayan Etkiler"
  },
  Event_7177_Name = {
    Text = "Etkinlik 302 (Geliştirme Aşamasında)"
  },
  Event_7178_ChoiceDesc1 = {
    Text = "[Accept Request] \"(RelicConfig.Arg2)\" adlı Gümüş Kalıntıyı edin, fakat \"(Skill.Arg1)\"i geliştir."
  },
  Event_7178_ChoiceDesc2 = {
    Text = "[Refuse Request] 25 Kara Mühür al"
  },
  Event_7178_Desc = {
    Text = "Çene, belli bir ritmi olan düzenli bir tınıyla çatırdıyor ve tam da bu sırada, yoldaşın biraz kriptografi biliyor.\nÇözülen metin şöyledir:\n“Merhaba, lütfen bana Dr.@2 deyin. Bir zamanlar koleksiyoner ve doğa bilimciydim…\n(Bu bölümde meslekler ve unvanlar üzerine uzun, geveze bir giriş yer alır.)\nKısacası, bana Diğer Yarım’ımı bulmamda yardım edebilir misiniz? Küçük bir üst çene kemiği parçası.\nBulunduğunda, özel hazinem kapılarını size açacak.”"
  },
  Event_7178_Name = {
    Text = "Gıcırdama"
  },
  Event_7179_ChoiceDesc1 = {
    Text = "[Invest 100 Florins] \"(RelicConfig.Arg2)\" adlı Gümüş Kalıntıyı edin, fakat \"(Skill.Arg1)\"i geliştir."
  },
  Event_7179_ChoiceDesc2 = {
    Text = "[Invest Five Pence] 25 Kara Mühür al"
  },
  Event_7179_Desc = {
    Text = "İşlemeli kese kıvranıyor, sana doğru zifiri karanlık bir ağız açıyor.\nZengin sahibinden ayrıldığından beri onlarca yıldır aç, beslenmeyi arzuluyor.\nİçine bir göz atıyorsun; bomboş, yalnızca geçit vermez bir karanlıkla dolu."
  },
  Event_7179_Name = {
    Text = "Gluttonous Purse"
  },
  Event_7180_ChoiceDesc1 = {
    Text = "[Steadfast Determination] Bir Komut Kartını İmha Et ve Arg1 YP geri kazan"
  },
  Event_7180_ChoiceDesc2 = {
    Text = "[Desire to Succeed] Altın Kalıntı \"(RelicConfig.Arg1)\" elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_7180_Desc = {
    Text = "\"İki tane İnatçı mı? Yoksullar Evi zaten tehlikeli—\" Bebek’in sesi aniden İletişimci’den gelir, \"Planın ne burada? Kafasını geri mi dikeceksin?\"\n \"Alay etme sırası değil şimdi, Bebek!\"\n \"Biliyorum, anlıyorum.\" dedi Bebek, \"Sakin ol. Başarının anahtarının ne olduğunu biliyor musun?\""
  },
  Event_7180_Name = {
    Text = "Rogers Kuralı"
  },
  Event_7181_ChoiceDesc1 = {
    Text = "[Infect with \"(Skill.Arg1)\" and obtain the Silver Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7181_ChoiceDesc2 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7181_Desc = {
    Text = "Etkinlik 304 (Geliştirme Aşamasında), Nihai Olmayan Etki"
  },
  Event_7181_Name = {
    Text = "Etkinlik 304 (Geliştirme Aşamasında)"
  },
  Event_7182_ChoiceDesc1 = {
    Text = "[Infect with \"(Skill.Arg1)\" and obtain the Silver Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7182_ChoiceDesc2 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7182_Desc = {
    Text = "Etkinlik 305 (Geliştirme Aşamasında), Nihai Olmayan Etkiler"
  },
  Event_7182_Name = {
    Text = "Etkinlik 305 (Geliştirme Aşamasında)"
  },
  Event_7183_ChoiceDesc1 = {
    Text = "[Hang Up] 3 İleri Yakarıştan 1’ini Oyarak Kazı"
  },
  Event_7183_ChoiceDesc2 = {
    Text = "[Answer the Phone] Altın Kalıntı \"(RelicConfig.Arg1)\" elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_7183_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_7183_Desc = {
    Text = "Orkestra Şefi’nin dinlenme alanının yanından geçerken, gizli bir köşeden keskin bir telefon zili duyulur."
  },
  Event_7183_Name = {
    Text = "Tren Araması"
  },
  Event_7184_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7184_Desc = {
    Text = "Soluk, ama inkâr edilemez biçimde gerçek.\nBu kadar zayıf bir Gümüş Çekirdek bir Uyandıran çağırmaya yetmez, fakat Güçlendirme için kusursuzdur—işte bu, Gümüş çip teknolojisinin özüdür."
  },
  Event_7184_Name = {
    Text = "Varoluşun Kanıtı"
  },
  Event_7185_ChoiceDesc1 = {
    Text = "[Lady's Portrait] Rastgele bir kartın Yakarış niteliğini güçlendir."
  },
  Event_7185_ChoiceDesc2 = {
    Text = "[Balmumu Heykel Aile Fotoğrafı] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte et"
  },
  Event_7185_Desc = {
    Text = "Balmumu Müzesi aynı zamanda birçok tabloya da ev sahipliği yapar.\nPortreler, manzaralar, natürmortlar, gerçekçi, soyut...\nAksi hâlde kasvetli olan duvarları süsler, onları daha az sıkıcı kılarlar.\nOnlardan biri gözünü yakalar. O —"
  },
  Event_7185_Name = {
    Text = "Portre Galerisi"
  },
  Event_7186_ChoiceDesc1 = {
    Text = "[Keep Reading] Rastgele bir Komut Kartı üzerine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7186_ChoiceDesc2 = {
    Text = "[Leave] Maksimum HP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_7186_Desc = {
    Text = "Tartmak için bir terazi.\nArkasında, sayısız organ kırmızı formalinde bekletiliyor.\nDepo raflarına düzenlice istiflenmişler.\nSen de yanındaki bir defteri rastgele eline alıp karıştırıyorsun:\n\"Kalp: 8 ons, Beyin: 50 ons...\""
  },
  Event_7186_Name = {
    Text = "Organ Kaydı"
  },
  Event_7187_ChoiceDesc1 = {
    Text = "[Open Gift] [Masum Dönüş Hediyesi] al"
  },
  Event_7187_Desc = {
    Text = "Yanınızdan bir çocuğun gölgesi titreşerek geçer; bunun gerçek bir çocuk mu, yoksa Gizli Diyar’daki bir ruhun yansıtması mı olduğunu ayırt edemezsiniz. Ama—yere bırakılmış, üzerinde çocuksu bir yazıyla “Hediye” yazan kutuya bakarsınız."
  },
  Event_7187_Name = {
    Text = "İyi Niyetin Hediyesi"
  },
  Event_7188_ChoiceDesc1 = {
    Text = "[Call the Crow] 40 Kara Mühür al, [(Skill.Arg2)] becerisini geliştir ve seçim yapmaya devam et."
  },
  Event_7188_ChoiceDesc2 = {
    Text = "[Stay Far Away] 25 Kara Mühür al ve ayrıl."
  },
  Event_7188_Desc = {
    Text = "Beyaz martılar, kırağı kaplı direkten dinleniyor.\nYankılanan çığlıkları, karanlığı ve açık denize ait olmayan kara kuşları geri püskürtüyor."
  },
  Event_7188_Name = {
    Text = "Sürüden Ayrılan Karga"
  },
  Event_7189_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7189_Desc = {
    Text = "Şarkının bir aşk şarkısından uyarlanmış olduğunu fark ettin.\nO aşk şarkısının sonunda, şair şöyle diyordu:\n\"İnsanlığın sesi bizi uyandırana dek, boğulacağız.\"\n\"Henüz değil,\" diye düşündün.\nHâlâ seni uyandırması için İnsanlığın Işığı’nı bekliyorsun."
  },
  Event_7189_Name = {
    Text = "Kargaların Korosu"
  },
  Event_7190_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7190_Desc = {
    Text = "Tozlu bir film makarası. Ne var ki bu odada projeksiyon cihazı yok ve burası malikâneyi, filmi ve ikindi çayını keyifle seyretmenin zamanı değil.\nMakarada ne olduğunu keşfetme fırsatını bulman, belki de çok uzun zaman alacak."
  },
  Event_7190_Name = {
    Text = "Mnemonic Phantoms"
  },
  Event_7191_ChoiceDesc1 = {
    Text = "[Leave] 3 İleri Yakarıştan 1’ini kazı, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7191_Desc = {
    Text = "Çocuğu takip edersin, ne fazla yakın ne fazla uzak.\nTak. Tak. Tak... Çocuk sokak köşesinde durur.\nArkasında titreşen kırmızı bir ışık fark edersin ve içgüdülerin sana, ilerde Balmumu Müzesi’nin olduğunu söyler.\nÇocuk arkasını döner. Gözleri yoktur, yalnızca karanlık boşluklar.\nSana gülümser."
  },
  Event_7191_Name = {
    Text = "Son Perde I"
  },
  Event_7192_ChoiceDesc1 = {
    Text = "[Leave] 50 Kara Mühür kazan, ancak [(Skill.Arg1)] Semptomunu geliştir"
  },
  Event_7192_Desc = {
    Text = "\nOmzuna hafifçe vurdun.\nÇocuk arkasını döndü. Gözleri yoktu, yalnızca karanlık boşluklar vardı.\n“İyi akşamlar. Balmumu müzesine giden yolu arıyorum.”\nÇocuk ileriyi işaret etti. Arkasında, kırmızı bir parıltının tehlikeli biçimde sallandığını gördün.\nİçgüdülerin balmumu müzesinin tam orada olduğunu söyledi.\nKendine geldiğinde, çocuk çoktan gitmişti, geride yalnızca sokak lambasının düşürdüğü gölge kalmıştı."
  },
  Event_7192_Name = {
    Text = "Son Perde I"
  },
  Event_7193_ChoiceDesc1 = {
    Text = "[Pin Down the Crow] 35 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_7193_ChoiceDesc2 = {
    Text = "[Ignore It] Ayrıl"
  },
  Event_7193_Desc = {
    Text = "Yalnız karga, kısık ve boğuk sesiyle, siyah kanatlarını tek tek yoluyor.\nAcıyla titriyor, tiz çığlıklar atıyor, ama giderek çılgınlaşan hızını durduramıyor.\n\"Gaak—Gaak—\"\nGözlerinden, yalnızca senin tanık olduğun, siyah sümüksü sıvıyla karışmış mavi yaşlar süzülüyor."
  },
  Event_7193_Name = {
    Text = "Erimiş Gözyaşı"
  },
  Event_7194_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7194_Desc = {
    Text = "Paha biçilmez bilgi zihnini dolduruyor, sonra sise dönüşüyor... Kendine geldiğinde, garip, sarı kaplı kitap ortadan kaybolmuş oluyor..."
  },
  Event_7194_Name = {
    Text = "Sarı Kitap"
  },
  Event_7195_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7195_Desc = {
    Text = "Balmumu Heykelleri kolayca alt ettin. Önünde yığılıp kaldılar.\nTabanlarında kazınmış birkaç satır var gibi.\n\"A.F. @2, Kasım\n@2 Koleji'nde Rogers tarafından yapıldı\"\nRogers’ın bir sanat okulunda heykel okuduğunu hatırlarsın. Bu sakar Balmumu Heykeller mutlaka onun öğrenci işleri olmalı."
  },
  Event_7195_Name = {Text = "Taslak"},
  Event_7196_ChoiceDesc1 = {Text = "[Why?]"},
  Event_7196_ChoiceDesc2 = {
    Text = "[Descend into the Deep Sea]"
  },
  Event_7196_Desc = {
    Text = "\n\"Sahtekâr! Oğlumu geri ver!\"\n\"Sen Nuh’un Gemisi’nin Mübarek Bakiresi değil misin? Gemiyi korumak senin görevin değil mi? Neden yalnızca bir gemi döndü? Söyle bana, söyle!\"\n\"Boğun onu! Babam ölmeden önce çektiği acının aynısını o da çekmeli!\"\n\"Boğun onu, boğun onu!\"\n\"Bu sahtekârı boğun! Bir taşa bağlayın!\"\nDeniz suyu ağzına ve burnuna dolup ciğerlerinin her köşesinden havayı sökerken, hâlâ o gösterişli ve lekesiz beyaz elbiseyi giyiyordu.\nMübarek Bakire oluşunun ardından beliren ilk düşünce, zihninin en karanlık köşesinden gecikmiş bir misafir gibi çıktı su yüzüne.\n\"Evet, neden o gemiler battı?\""
  },
  Event_7196_Name = {
    Text = "Batık Deniz"
  },
  Event_7197_ChoiceDesc1 = {
    Text = "[Pin Down the Crow] 30 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_7197_ChoiceDesc2 = {
    Text = "[Ignore It] Ayrıl"
  },
  Event_7197_Desc = {
    Text = "Yalnız karga, kısık ve boğuk sesiyle, siyah kanatlarını tek tek yoluyor.\nAcıyla titriyor, tiz çığlıklar atıyor, ama giderek çılgınlaşan hızını durduramıyor.\n\"Gaak—Gaak—\"\nGözlerinden, yalnızca senin tanık olduğun, siyah sümüksü sıvıyla karışmış mavi yaşlar süzülüyor."
  },
  Event_7197_Name = {
    Text = "Erimiş Gözyaşı"
  },
  Event_7198_ChoiceDesc1 = {
    Text = "[Keep Searching] Azami CP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_7198_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7198_Desc = {
    Text = "Sanki güçlü, sarsılmaz bir çift el omuzlarına konmuş gibi hissediyorsun; ama arkanı döndüğünde, az önce somut olan dokunuş ele avuca sığmaz oluyor."
  },
  Event_7198_Name = {
    Text = "Anormal Temas"
  },
  Event_7199_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7199_Desc = {
    Text = "Ryelway köprüsü, Londinium'un kanı ve sinirleri, şehrin kalbini ve uzuvlarını birbirine bağlar. Lai Hastanesi, uzuvların ucunda sessizce bekliyor; kan ve sinyallerin iletilmesine hazır."
  },
  Event_7199_Name = {
    Text = "Demiryolu Serabı"
  },
  Event_7200_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7200_Desc = {
    Text = "Yerdeki bavulu titremeyi kesene dek çiğnersin, sonra yeniden eline alırsın.\nTozunu silkeleyip, Murphy’nin şaşkın bakışları altında yürümeye devam edersin."
  },
  Event_7200_Name = {
    Text = "Davetsiz Mektup"
  },
  Event_7201_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7201_Desc = {
    Text = "Tahta bir kapının ardında tehlike pusuda bekler; oyalanılacak bir yer değildir. Onu bavuluna yerleştir."
  },
  Event_7201_Name = {
    Text = "Sarı Kitap"
  },
  Event_7202_ChoiceDesc1 = {
    Text = "[Chase the Crows] Arg1 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_7202_ChoiceDesc2 = {
    Text = "[Ignore] Leave"
  },
  Event_7202_Desc = {
    Text = "O, ya da daha doğrusu onlar, yatak odasında süzülüyor, şangırtıyla abajura çarpıyor."
  },
  Event_7202_Name = {
    Text = "Fener Kargası"
  },
  Event_7203_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7203_Desc = {
    Text = "Burası Ruh Boyutu, Gnosis’in dünyası.\nZihinlerini kurcalamaktan başka hiçbir şey yapamazlar."
  },
  Event_7203_Name = {
    Text = "Gnosis Fırtınası"
  },
  Event_7204_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7204_Desc = {
    Text = "Kafatası: Hank Tillinghast A.F.186-A.F.203 Creole Adası\nOmurga: Andy Crawford A.F.177-A.F.203 Narragansett\n..Üzerinde fazla düşünmemek gerek."
  },
  Event_7204_Name = {
    Text = "İsim Plakası"
  },
  Event_7205_ChoiceDesc1 = {
    Text = "[Check Fragment] 3 Komut Kartı’ndan 1’ini İmha Et ve 75 Kara Mühür al."
  },
  Event_7205_ChoiceDesc2 = {
    Text = "[Ask Doll] 3 Komut Kartı’ndan 1’ini çoğalt ve 25 Kara Mühür al."
  },
  Event_7205_ChoiceDesc3 = {
    Text = "[Disregard] 50 Kara Mühür al"
  },
  Event_7205_Desc = {
    Text = "Bebek’in sana verdiği metal Parça göğsünde huzursuzca titrer; rahatsız edilmiş bir Kelebek gibi."
  },
  Event_7205_Name = {
    Text = "Huzursuz Broş"
  },
  Event_7206_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7206_Desc = {
    Text = "\"Bitiriş çizgisinde sessizce bekler, son noktayı nereye koyarsan koy—şu genç gardiyana bak; kaçışı eninde sonunda deliliğe çıkar.\""
  },
  Event_7206_Name = {Text = "Aranan"},
  Event_7207_ChoiceDesc1 = {
    Text = "[Leave] Hiçbir şey bulunamadı"
  },
  Event_7207_Desc = {
    Text = "Geliştirme Aşamasında, Özel Etkinlik"
  },
  Event_7207_Name = {
    Text = "2_16 Geçici"
  },
  Event_7208_ChoiceDesc1 = {
    Text = "[Comfort It] Maks. HP’yi Arg1 kadar artır"
  },
  Event_7208_ChoiceDesc2 = {
    Text = "[Görmezden Gel] Rastgele 2 Komut Kartı Mühür kazan: \"(EnchantConfig.Arg1)\", 2 \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_7208_Desc = {
    Text = "Bağ, hâlâ insan doğasını Sakla-yan kalbi ısıtır.\nKalp, diğer uçtaki nefes alış ritmini taklit eder; sanki bunu yapmak, terk edilmekten kurtaracak, ona Bağ ile ebedi yoldaşlık hakkı tanıyacaktır."
  },
  Event_7208_Name = {
    Text = "Sol Kulakçık"
  },
  Event_7209_ChoiceDesc1 = {
    Text = "Rastgele Gelişmiş Yakarış"
  },
  Event_7210_ChoiceDesc1 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7210_Desc = {
    Text = "Soğukluğun, sesin sahibini pişmanlığa sürüklüyor; su tembelce dalgalanıp yeniden durgunluğa dönüyor."
  },
  Event_7210_Name = {
    Text = "Ötelerden Gelen Sesler"
  },
  Event_7211_ChoiceDesc1 = {
    Text = "[Select 1 Card to gain the Orison: \"(EnchantConfig.Arg1)\"] Test Yakarış"
  },
  Event_7211_ChoiceDesc2 = {
    Text = "[Select 1 Card to gain the Orison: \"(EnchantConfig.Arg1)\"] Test Düşen Paket"
  },
  Event_7211_Desc = {
    Text = "Belirtilen Yakarışı Sına"
  },
  Event_7211_Name = {
    Text = "Belirlenmiş Mühür Testi 1"
  },
  Event_7212_ChoiceDesc1 = {
    Text = "[Leave] Bir Uyandırıcıyı Uyanışa Çağır"
  },
  Event_7212_Desc = {
    Text = "Çocuğun başını usulca okşar, onu seninle birlikte tekrar etmeye yönlendirirsin.\n\"Annem İçin Bir Şarkı—\"\nSesler, geceleyin uçuşan güveler gibi, boş sahneden yan yana süzülür,\nkapkaranlık seyirci koltuklarına usulca konar."
  },
  Event_7212_Name = {
    Text = "Son Perde III"
  },
  Event_7213_ChoiceDesc1 = {
    Text = "[Leave] 3 Altın Kalıntıdan 1’ini edin, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7213_Desc = {
    Text = "Sakin ve soğukkanlı kaldın. Bir Aristokrat Kadın aniden sahneye fırladı.\nÇocuğun ağzını çılgınca açıp zorla bir çubuk tıkıştırdı.\n\"Konuş, benimle konuş.\"\nÇocuğun ağzından kara kan aktı. O ise mırıldanmaya devam etti.\n\"Annem için bir şarkı...\""
  },
  Event_7213_Name = {
    Text = "Son Perde III"
  },
  Event_7215_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7215_Desc = {
    Text = "Bu bir pencere değil, bir ayna. Ramona'nın gergin yüzü onda yansıyor.\nNeden bu odada pencere yok da, duvarda asılı yalnızca kocaman bir ayna var?"
  },
  Event_7215_Name = {
    Text = "Penceredeki Yansıma"
  },
  Event_7216_ChoiceDesc1 = {
    Text = "[Hold Silver Key] Rastgele bir Uyandırıcıyı Uyanışa geçir, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7216_ChoiceDesc2 = {
    Text = "[Close Your Eyes] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7216_Desc = {
    Text = "\nSaçma bir dalganın içinde paramparça oldun, uzuvların bükülüp çarpılırken, sanki @2 boyutunun öte âleminden gelen bir şey tarafından yönlendiriliyormuşsun gibi yerde sürünüyordun.\n \"Hayır... hayır...\"\nAkıl sağlığın, örümcek ağı gibi parça parça çökerken, hezeyanlı kahkahalar ve çığlıklar dev bir ağ misali bilincini sardı; dudaklarından dökülenlerse yalnızca belirsiz inlemelerdi."
  },
  Event_7216_Name = {
    Text = "Gözcünün Bakışı"
  },
  Event_7217_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7217_Desc = {
    Text = "Galaksinin renkleri değişip ayaklarının dibinde tarif edilemez desenler oluşturuyor. Yakutlar kadar güzel, ama denizanaları gibi şişkinler. Bir kırmızı parıltı bavuldan sızıyor..."
  },
  Event_7217_Name = {
    Text = "Yıldız Kavşağı"
  },
  Event_7218_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Stresi 10 artır."
  },
  Event_7218_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7218_Desc = {
    Text = "Bulanık yüzler aniden belirir; seni sarar ve var olmayan ses telleriyle umutsuzca inlerler."
  },
  Event_7218_Name = {Text = "İllüzyon"},
  Event_7221_ChoiceDesc1 = {
    Text = "[Catch] [(RelicConfig.Arg1)] adlı Gümüş Kalıntıyı elde et."
  },
  Event_7221_ChoiceDesc2 = {
    Text = "[Look Down] 75 Kara Mühür al, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_7221_Desc = {
    Text = "Kargalar gökyüzünde dolanıyordu; aralardaki dar sokaklar onları, sanki yapı taşlarıymış gibi parçalara bölüyor, boğuk çığlıkları iç sıkıntısı veriyordu.\nBirden, sürü huzursuzlandı; sanki hastalıklı bir içgüdü bükülmüş ya da uyanmıştı. Vahşice birbirlerine saldırıp kovalamaya başladılar, kargaşanın ortasında bir şeyler yere düşüyordu."
  },
  Event_7221_Name = {
    Text = "Çılgın Karga Sürüsü"
  },
  Event_7222_ChoiceDesc1 = {
    Text = "[Follow the Instructions] Azami CP’yi Arg1 kadar Artır"
  },
  Event_7222_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7222_Desc = {
    Text = "Gümüş Anahtar’ın iz sürme gücünü kullanarak en yakın Kavşak’ı bulmaya çalışırsın; fakat aldığın bilgilerde, sanki birileri tarafından bozulmuşçasına ince sapmalar vardır."
  },
  Event_7222_Name = {
    Text = "Anormal Temas"
  },
  Event_7223_ChoiceDesc1 = {
    Text = "[Give It to Doll] Rastgele bir Komut Kartı üzerine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7223_ChoiceDesc2 = {
    Text = "[Read the Nameplate] Azami Canı Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_7223_Desc = {
    Text = "Heykeltıraşlar Birliği'nin başarısızlığa uğramış deneyinden, metal çerçeveli bir İsim Plakası düştü. Gümüş Anahtar bunu hisseder ve hafifçe parıldar."
  },
  Event_7223_Name = {
    Text = "İsim Plakası"
  },
  Event_7224_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7224_Desc = {
    Text = "Kılıç kuşanan uzun bir uluma salar; sanki dağları ve denizleri yarabilecek bir ses gibi.\nSes bir anda yok olur ve diğer iki Denizci de kaybolur... Meğer bu, Alan’ın yansıttığı bir Düş’ten ibaretmiş."
  },
  Event_7224_Name = {
    Text = "Relentless Hunt"
  },
  Event_7225_ChoiceDesc1 = {
    Text = "[Repair Wax Sculpture] Bir kart seç ve Arithmetica Maliyetini 1 azalt."
  },
  Event_7225_Desc = {
    Text = "Elinde bir mumla, sisli pusun içinden ona doğru yürürsün.\nO, tamamlanmamış bir balmumu heykeldir.\nNarin yüzü ikiye ayrılmıştır; bir yarısı gülümser, diğer yarısı @1.\nOnun tanrısı ol.\nOna güzellik ver, ona gözyaşları ver.\nOnu yont ya da yok et."
  },
  Event_7225_Name = {
    Text = "Tamamlanmamış Balmumu Heykel"
  },
  Event_7226_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7226_Desc = {
    Text = "\"Elbette, yok oluşa bizzat tanık oldum.\" diye yanıtladın.\nEvet, bu yalnızca küçük bir farenin şiddetli ölümü, bir kalbin çürümesi ve gecenin cenazesine nüfuz etmiş bir demet iris çiçeğiydi."
  },
  Event_7226_Name = {
    Text = "Kayıp Panteon"
  },
  Event_7227_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7227_Desc = {
    Text = "\"İlahi Diyar... yok oluş... yanılsamalı mevzular... neyin yok oluş sayıldığını bilmiyorum.\"\nİki siluet, beyaz, titreşen ışık parçacıklarıyla çevrili halde hafifçe kıkırdar.\n \"Öyleyse şimdi, gerçek yok oluşa tanık olacaksın.\""
  },
  Event_7227_Name = {
    Text = "Kayıp Panteon"
  },
  Event_7228_ChoiceDesc1 = {
    Text = "[Combine Pages] \"(RelicConfig.Arg1)\" adlı Altın Kalıntıyı edin, fakat \"(Skill.Arg2)\"yi geliştir."
  },
  Event_7228_ChoiceDesc2 = {
    Text = "[Read] [(EnchantConfig.Arg1)] Yakarışını 3 Komut Kartından 1’ine kazı."
  },
  Event_7228_ChoiceDesc3 = {
    Text = "[Discard It] 50 Kara Mühür al"
  },
  Event_7228_Desc = {
    Text = "Işık Taşıyıcı Tarikatçısı'nın cübbesinden sararmış bir sayfa düştü.\nÜzerini garip yazılar kaplamış; kimisi hiyeroglife benzer, kimisi tuhaf biçimde eğik, kimisi de birbirinin üstüne binmiş. Ancak birkaç kelime güçlükle seçilebiliyor.\nBaşlığı: \"@2 Divus'un Doğuşu\""
  },
  Event_7228_Name = {
    Text = "Şifreli Emir·Bölüm II"
  },
  Event_7229_ChoiceDesc1 = {
    Text = "[Struggle] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\"yi geliştir."
  },
  Event_7229_ChoiceDesc2 = {
    Text = "[Wallow] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntı’yı elde et, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7229_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7229_Desc = {
    Text = "\"Çok acı çekiyorum, çok acı...\"\n\"Neden ben? Neden buna katlanmak zorundayım?\"\n\"Merhametli Baba, ne yaptım ben?\"\nKeder, acı, öfke, çaresizlik... empatiyle boğulurken bu \"hastalar\"ın duyguları üzerine ağır bir yük gibi çöker. Göğsünü kavrarken nefes almakta zorlanırsın."
  },
  Event_7229_Name = {Text = "İhtiras"},
  Event_7230_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7230_Desc = {
    Text = "Bakış, eti Delici bir şekilde aşar, öncünün retinasına damgasını vurur.\nHiç kimse kaçamaz, tıpkı hiç kimsenin@2"
  },
  Event_7230_Name = {Text = "Gözle"},
  Event_7231_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7231_Desc = {
    Text = "Zihnini odakla, şarkı sözlerini teşhis et ve ardından kaotik kelimelerin kafanın arkasına çarpışını hisset.\nBunlar, insan idrakinin ötesindeki kelimelerdir."
  },
  Event_7231_Name = {
    Text = "Denizci Türküsü"
  },
  Event_7232_ChoiceDesc1 = {
    Text = "[Initiate Trial] [(Skill.Arg1)] geliştir; galip gelirsen bir Altın Kalıntı, yenilirsen 50 Kara Mühür kazan."
  },
  Event_7232_ChoiceDesc2 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_7232_Desc = {
    Text = "Ayaklarının altındaki ayna gibi siyah sümüksü maddeden bazı sırların gölgesini yakaladın.\nYansıması bulanık, inatçı bir karanlık sisine bürünmüş. Tuhaf biçimde tanıdık geliyor, ama ne olduğunu tam seçemiyorsun."
  },
  Event_7232_Name = {
    Text = "Under-Mirror"
  },
  Event_7233_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7233_Desc = {
    Text = "Gizemli, isimsiz mektubu önemsemeyip onu rastgeleceğe yakar, küle çevirirsin."
  },
  Event_7233_Name = {
    Text = "Bir İmdat Mektubu Daha"
  },
  Event_7234_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7234_Desc = {
    Text = "Mektubun kendisini inceliyorsun. Mühür, kana ve siyah bir sıvıya benzeyen yapışkan bir karışımla kaplı; üzerine yapışmış birkaç saç teli var."
  },
  Event_7234_Name = {
    Text = "Bir İmdat Mektubu Daha"
  },
  Event_7235_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7235_Desc = {
    Text = "Mektubun sürüklendiği yönü takip et. Duvarın köşesinde, parlayan bir şeyin siluetini yakalıyorsun."
  },
  Event_7235_Name = {
    Text = "Bir İmdat Mektubu Daha"
  },
  Event_7236_ChoiceDesc1 = {
    Text = "[Keep Searching] Azami CP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_7236_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7236_Desc = {
    Text = "Solgun, sıcak bir ışık belirdi. Ancak peşine düşmeye yeltendiğin anda aniden yok oldu."
  },
  Event_7236_Name = {
    Text = "Anormal Temas"
  },
  Event_7237_ChoiceDesc1 = {
    Text = "[Leave] Tüm Uyanışçıların Aliemus’unu Arg1 artır"
  },
  Event_7237_Desc = {
    Text = "Korkuyla gözlerini sımsıkı kaparsın.\n\"Örtüyü kaldırdın...\nSırlar, sırları açığa çıkardın...\"\nSes dalgaları kükreyen bir okyanusa dönüşür, zemin dehşet verici bir Rezonans içinde şiddetle sarsılır.\nDaha fazla dayanamayarak birden gözlerini açarsın, ama etrafında hiçbir şey yoktur."
  },
  Event_7237_Name = {
    Text = "Son Perde V"
  },
  Event_7238_ChoiceDesc1 = {
    Text = "[Keep Searching] Azami CP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_7238_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7238_Desc = {
    Text = "Burnunun ucu tanıdık, yuva kokusunu andıran, doyurucu bir koku yakalar. Yemekhane aromasından bir nefes daha çekmeye yeltenirken, koku bir anda bütünüyle yok olur."
  },
  Event_7238_Name = {
    Text = "Anormal Temas"
  },
  Event_7239_ChoiceDesc1 = {
    Text = "[Keep Searching] Azami CP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_7239_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7239_Desc = {
    Text = "Tanıdık bir ses kulağıma fısıldadı; sıcak ve teselli vericiydi. Ama peşine düşmeye çalıştığımda, ses aniden kesildi."
  },
  Event_7239_Name = {
    Text = "Anormal Temas"
  },
  Event_7240_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7240_Desc = {
    Text = "Geriye bakışın gücü kısa vadede senin için başka bir Kavşak bulamaz, ama en azından biraz Geçici kurtuluş hissedersin."
  },
  Event_7240_Name = {
    Text = "Anormal Temas"
  },
  Event_7241_ChoiceDesc1 = {
    Text = "[Keep Searching] Azami CP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_7241_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7241_Desc = {
    Text = "Sanki güçlü, sarsılmaz bir çift el omuzlarına konmuş gibi hissediyorsun; ama arkanı döndüğünde, az önce somut olan dokunuş ele avuca sığmaz oluyor."
  },
  Event_7241_Name = {
    Text = "Anormal Temas"
  },
  Event_7242_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7242_Desc = {
    Text = "\"N\" in gölgesi yumrukla dağılır, siyah parçacıklar Gizli Diyar sisine karışır, iz sürmesi güçleşir.\n \"Eğlenceli değil, ama ilgi çekici. Gerçek buluşmamızı sabırsızlıkla bekleyeceğim...\""
  },
  Event_7242_Name = {
    Text = "Perde Açılıyor"
  },
  Event_7243_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7243_Desc = {
    Text = "\n\"İyi çocuk. Ama yine de sana küçük bir ceza vermeliyim.\"\nNergis’in hafif kahkahası boyutsal yarıkta sönümlendi."
  },
  Event_7243_Name = {
    Text = "İpucu Süresi"
  },
  Event_7244_ChoiceDesc1 = {
    Text = "[Silver Chip] %50 ihtimalle Altın Kalıntı \"(RelicConfig.Arg2)\" elde et, %50 ihtimalle \"(Skill.Arg3)\" geliştir."
  },
  Event_7244_ChoiceDesc2 = {
    Text = "[Red Chip] %50 ihtimalle 75 Kara Mühür al, %50 ihtimalle [(Skill.Arg3)] Semptomunu geliştir."
  },
  Event_7244_ChoiceDesc3 = {
    Text = "[Black Chip] %50 ihtimalle Lanetli Kalıntı \"(RelicConfig.Arg2)\" elde et, %50 ihtimalle \"(Skill.Arg3)\" geliştir."
  },
  Event_7244_Desc = {
    Text = "İyi... güzel...\nŞimdi, arzuladığın fişi seç."
  },
  Event_7244_Name = {
    Text = "Perde Açılıyor"
  },
  Event_7245_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7245_Desc = {
    Text = "“Pekâlâ, pekâlâ. O her zaman boyutlar arası yaratıklara meraklıydı. Bu Boyutsal Yarıklar arasında özgürce dolaşabilmek için epey çaba harcadım. Ah, sanırım bu 3.000 yıl önceydi.”"
  },
  Event_7245_Name = {
    Text = "İpucu Süresi"
  },
  Event_7246_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7246_Desc = {
    Text = "Umalım ki araştırma müdürüne duyduğun güven, göğsüne bir bomba yerleştirmesiyle sonuçlanmasın."
  },
  Event_7246_Name = {
    Text = "Huzursuz Broş"
  },
  Event_7247_ChoiceDesc1 = {
    Text = "[Leave] Bir Komut Kartı İmha Et ve 25 Kara Mühür kazan."
  },
  Event_7247_Desc = {
    Text = "“Kaybolmuşlara yol gösteren iyi yürekli bir yabancı,” diye sırıttı, “Hafif seyahat et. Kerberos bekler.”\nElindeki cihaz aniden titreşti."
  },
  Event_7247_Name = {
    Text = "Garip Yol Arkadaşı III"
  },
  Event_7248_ChoiceDesc1 = {
    Text = "[Move Slowly] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7248_ChoiceDesc2 = {
    Text = "[Lie Down] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7248_Desc = {
    Text = "“Bataklıkla karşılaştığında, sakın çırpınma.”\nBu hayatta kalma kuralını aklında tutarak, Paskalya Adası heykeli gibi kıpırtısız durursun.\nBeş dakika, on dakika, bir saat... siyah çamur sonunda sabrını yitirir ve ayaklarının altından çekilip gider."
  },
  Event_7248_Name = {
    Text = "Kasvet Bataklığı"
  },
  Event_7249_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7249_Desc = {
    Text = "Olağandışı bir el fark edersin. İnce, solgun ve başından beri sarsılmaz bir dinginlikte.\nDaha da önemlisi—onun kendi elin olduğunu tanırsın.\nNazikçe kavrarsın.\nEl karşılık verir. İliklerine işleyen bir soğuk ve bir düş hissedersin, sonra bataklık yok olur."
  },
  Event_7249_Name = {
    Text = "Kasvet Bataklığı"
  },
  Event_7250_ChoiceDesc1 = {
    Text = "[Cut Off Hand] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7250_ChoiceDesc2 = {
    Text = "[Soothe Them] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7250_Desc = {
    Text = "Kılıcını savurur, onları birer birer biçersin.\nKan bedenine, yüzüne, saçlarına sıçrar, ama sen bunun farkında bile değilsin.\nSayısız el acı içinde çığlık atar ve bataklık yok olur.\nÇığlıkların karabasanlarını terk etmesi bir haftanı alır."
  },
  Event_7250_Name = {
    Text = "Kasvet Bataklığı"
  },
  Event_7251_ChoiceDesc1 = {
    Text = "[Pick up the Silver Core] bir Gümüş Kalıntı’yı Yaldızlı Kalıntı [(RelicConfig.Arg1)]ye Yükselt"
  },
  Event_7251_ChoiceDesc2 = {
    Text = "[Attempt Awakening] Altın Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" ve \"(Skill.Arg3)\" Becerilerini geliştir."
  },
  Event_7251_ChoiceDesc3 = {
    Text = "[Ignore] 25 Kara Mühür al"
  },
  Event_7251_Desc = {
    Text = "Gevşek güverte tahtasının altından pis, kara bir çamur sızar.\nÇamurun içinde, tanıdık bir \"Gümüş Çekirdek\" parıltısı gözüne çarpar."
  },
  Event_7251_Name = {
    Text = "Varoluşun Kanıtı"
  },
  Event_7252_ChoiceDesc1 = {
    Text = "[The Rat] Rastgele bir Komut Kartı’na [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7252_ChoiceDesc2 = {
    Text = "[The Candle] Azami HP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_7252_Desc = {
    Text = "Çözülen, gözlerinin önünde dağılır. Ondan yükselen siyah küller, sisin içinde tuhaf bir teraziye dönüşür. Bir kefesinde uyuyan bir sıçan yatar. Diğer kefede ise küçük bir mum vardır; bir küçük çocuk şeklinde oyulmuştur.\nİçgüdülerin sana bir seçim yapmak zorunda olduğunu söyler."
  },
  Event_7252_Name = {
    Text = "Akıl ve Tutku"
  },
  Event_7253_ChoiceDesc1 = {Text = "[Call Out]"},
  Event_7253_ChoiceDesc2 = {
    Text = "[Check Carefully]"
  },
  Event_7253_Desc = {
    Text = "Köşeyi dönerken etrafın gitgide daha da bulanıklaşıyor, ama o dehşet verici kükremeler hâlâ berrak.\nAyak sesleri yankılanıyor ve arkana döndüğünde, güçlükle seçebildiğin tuhaf bir siluet görüyorsun; insansı şekli bir insan gibi ayakta duruyor, fakat arkasında, devasa bir güvenin kanatlarını andıran bir çift gölge uzanıyor.\n \"Dikkatli ol,\" diye fısıldıyor Ramona, \"Bir Gizli Diyar’ın içinde gördüklerin mutlaka gerçek olmak zorunda değil. Dikkatli olmazsan kendini tehlikeye atabilirsin.\""
  },
  Event_7253_Name = {
    Text = "Sisin İçindeki Silüet"
  },
  Event_7254_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7254_Desc = {
    Text = "Gümüş Anahtar’ı çıkarıyor, onu hüzün ve hürmetle kavrıyorsun. Soluk, sisimsi bir parıltı seni sarıyor.\nSessizlikte yalnızca bir iç çekiş yankılanıyor."
  },
  Event_7254_Name = {
    Text = "Gözcünün Bakışı"
  },
  Event_7255_ChoiceDesc1 = {
    Text = "[Choose Silver River] Rastgele bir Komut Kartı üzerine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7255_ChoiceDesc2 = {
    Text = "[Choose Rainbow Path] Maksimum HP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_7255_Desc = {
    Text = "Güm, güm, güm.\nKalbin davul gibi çarpıyor, ağzın kupkuru, tepeden gelen bir bakış omurganı delip göğsüne saplanıyor.\nÖnünde bir yol ayrımı beliriyor: bir patika yıldızlı bir nehir gibi akıyor, diğeri gökkuşağı parıltısıyla titreşiyor."
  },
  Event_7255_Name = {
    Text = "Yıldız Kavşağı"
  },
  Event_7256_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7256_Desc = {
    Text = "Üzerinde gezinen bakışlar seni izlemeyi sürdürüyor; derinin altındaki hücreler çığlık atıp kaçışıyor, damarların kurtlar gibi kıvranıyor.\nUzuvlarının grotesk hâlinin ortasında, kabarıp patlayan bir güç akışını hissediyorsun."
  },
  Event_7256_Name = {
    Text = "Gözcünün Bakışı"
  },
  Event_7257_ChoiceDesc1 = {
    Text = "[Leave] [(Skill.Arg1)] Semptomunu Geliştir"
  },
  Event_7257_ChoiceDesc2 = {
    Text = "[Leave] [(Skill.Arg1)] Semptomunu Geliştir"
  },
  Event_7257_ChoiceDesc3 = {
    Text = "[Leave] [(Skill.Arg1)] Semptomunu Geliştir"
  },
  Event_7257_Desc = {
    Text = "\n“Hayır, bu doğru değil. Hamamböcekleriyle kıyaslayınca, en azından sizin tüylü bedenleriniz var.\nKimse tüylü bir bedene karşı koyamaz.”\nFareler kendi aralarında fısıldaştı ve sonunda senin fikrine katıldılar.\n“Gerçi o kadar da çok tüy yok ya.”\nİltifat edilmek her zaman hoştur. Ayrılmadan önce, fareler sana küçük bir hediye verdi"
  },
  Event_7257_Name = {Text = "Veba"},
  Event_7258_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7258_Desc = {
    Text = "\"Katılıyorum! İnsanlar ve fareler birlikte yaşayamaz!\"\nFareler biraz öfkelenmiş görünerek beyaz dişlerini gösterdiler.\n\"Öyleyse neden hâlâ buradasın? Eşyalarını al ve bir daha asla geri dönme.\""
  },
  Event_7258_Name = {Text = "Veba"},
  Event_7259_ChoiceDesc1 = {
    Text = "[Leave] \"(RelicConfig.Arg1)\" Kalıntısını elde et, fakat \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_7259_Desc = {
    Text = "Etrafında tekinsiz bir kanat çırpma sesi dolaşır. Sersemlik içinde, Rogers’ı, tedavi yatağında George adlı bebeği tutarken, elleri kan içinde görürsün.\nGözlerini açtığında Clementine’in ortadan kaybolduğunu fark edersin.\nUyandığında, Clementine çoktan gitmiştir."
  },
  Event_7259_Name = {
    Text = "Hipnoterapi"
  },
  Event_7260_ChoiceDesc1 = {
    Text = "[Unlock] Anahtarı kullan."
  },
  Event_7260_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7260_Desc = {
    Text = "Bir kapı yolunu kesiyor. Her yöntemi denedin, yine de dimdik yerinde duruyor."
  },
  Event_7260_Name = {
    Text = "Paslı Kapı"
  },
  Event_7260_Tips1 = {
    Text = "\"Paslı Anahtar\"ı bulman gerekiyor."
  },
  Event_7261_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7261_Desc = {
    Text = "Bakışın kaynağı olduğuna inandığın yöne bakıyorsun. Atölyenin tavanı birden uzaklaşıyormuş gibi geliyor ve devasa bir gözbebeğinin üst üste yığılmış gölgeleri tepende beliriyor. Bakışınla yalnızca kısmen kesişse de, yine de muazzam bir baskı hissediyorsun."
  },
  Event_7261_Name = {
    Text = "Kimin Bakışı?"
  },
  Event_7262_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7262_Desc = {
    Text = "Kara kedi temkinle yaklaşır ve avucunun içine koyu bir kütle kusar."
  },
  Event_7262_Name = {
    Text = "Gece Kedisinin Laneti"
  },
  Event_7263_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7263_Desc = {
    Text = "\"Akıllıca bir Seçim. Zorlu bir düşmanla yüzleşirken, kendini ve düşmanını bilmek şart, değil mi? Ama dikkat et—Boyutların sırları hakkında fazla şey öğrenmek zihnini sarsabilir.\"\n\"Şu herif, boyutlar arası varlıklara kafayı takmaktan kendini alamıyor. Bu Boyutsal Yarıklar arasında özgürce dolaşabilmem epey zamanımı aldı. Ah, o da 3.000 yıl önceydi.\""
  },
  Event_7263_Name = {
    Text = "İpucu Süresi"
  },
  Event_7264_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7264_Desc = {
    Text = "“Miyav, miyav miyav, miyav miyav miyav...”\nSesini zorluyor, kendini zayıf ve zararsız göstermeye çalışıyordun.\n“Miyav! Miyav miyav! Miyav miyav miyav!”\nKedi sürüsü, iyi niyetini kabul etmişe benziyordu; neşeli miyavlamalarla karşılık verdiler. Çığlıkların gece gündüz durmaksızın yankılandı, ayı bile korkutup bulutların ardına saklanmaya zorladı."
  },
  Event_7264_Name = {
    Text = "Kediler Şehri"
  },
  Event_7265_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7265_Desc = {
    Text = "Karganın gagasını, kendi Kanatlar’ını yolmaktan zorla uzaklaştırırsın, ama o inatla geri bükülür; gücü, kemiklerinin Gıcırtı ile sızlamasına neden olur.\nYüzün kıpkırmızı kesilir, tüm gücünü kullanarak karganın bedenini zapt eder, çılgınca öz-yok edişini durdurursun.\nTam derin bir nefes alıp rahatlayacakken, karganın yarı kel boynu birdenbire sertçe geriye kırılır; bedeni gevşer ve ellerinin arasında siyah bir çamur gölüne dönüşür."
  },
  Event_7265_Name = {
    Text = "Erimiş Gözyaşı"
  },
  Event_7266_ChoiceDesc1 = {
    Text = "[Pin Down the Crow] 20 Kara Mühür al, fakat [(Skill.Arg2)] geliştir."
  },
  Event_7266_ChoiceDesc2 = {
    Text = "[Ignore It] Ayrıl"
  },
  Event_7266_Desc = {
    Text = "Yalnız karga, kısık ve boğuk sesiyle, siyah kanatlarını tek tek yoluyor.\nAcıyla titriyor, tiz çığlıklar atıyor, ama giderek çılgınlaşan hızını durduramıyor.\n\"Gaak—Gaak—\"\nGözlerinden, yalnızca senin tanık olduğun, siyah sümüksü sıvıyla karışmış mavi yaşlar süzülüyor."
  },
  Event_7266_Name = {
    Text = "Erimiş Gözyaşı"
  },
  Event_7267_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7267_Desc = {
    Text = "Karga, tıpkı insanların kendi bedenlerini kemirmesi gibi, kanatlarını didikler.\nKorkunun hüküm sürdüğü bu dünyada, böylesi sahneler olağandır. Tüm canlıları kurtaramazsın."
  },
  Event_7267_Name = {
    Text = "Erimiş Gözyaşı"
  },
  Event_7268_ChoiceDesc1 = {
    Text = "[Leave] \"(RelicConfig.Arg1)\" Kalıntısını elde et, fakat \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_7268_Desc = {
    Text = "\"Öğrencilerle birlikte döneceğim.\" Kız, Azaltıcı’nın eteğini çekiştirdi, azimliydi, \"Kendine dikkat et... denize düşme.\""
  },
  Event_7268_Name = {
    Text = "Kutsal Bakire'nin Nöbeti"
  },
  Event_7269_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7269_Desc = {
    Text = "Haha, siyah, en sevdiğim. Kaos, Şaşkınlık, acı... Artık anlamış olmalısın—siyah asla hayra alamet değildir.\nPeki, bir sonraki Seçimin ne?"
  },
  Event_7269_Name = {
    Text = "Perde Açılıyor"
  },
  Event_7270_ChoiceDesc1 = {
    Text = "[Pin Down the Crow] 25 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_7270_ChoiceDesc2 = {
    Text = "[Ignore It] Ayrıl"
  },
  Event_7270_Desc = {
    Text = "Yalnız karga, kısık ve boğuk sesiyle, siyah kanatlarını tek tek yoluyor.\nAcıyla titriyor, tiz çığlıklar atıyor, ama giderek çılgınlaşan hızını durduramıyor.\n\"Gaak—Gaak—\"\nGözlerinden, yalnızca senin tanık olduğun, siyah sümüksü sıvıyla karışmış mavi yaşlar süzülüyor."
  },
  Event_7270_Name = {
    Text = "Erimiş Gözyaşı"
  },
  Event_7271_ChoiceDesc1 = {
    Text = "[Leave] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7271_Desc = {
    Text = "Orası, kulübenin derinleriydi; uzun süredir ihmal edilmiş, loş ve rehbersiz.\nKız, aralarındaki anlaşmaya göre, geminin azizinin \"Kutsama\"sıyla yola çıkacaktı."
  },
  Event_7271_Name = {
    Text = "Kutsal Bakire'nin Nöbeti"
  },
  Event_7272_ChoiceDesc1 = {
    Text = "[Chase the Song] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7272_ChoiceDesc2 = {
    Text = "[Sing Along] [(Skill.Arg1)] Semptomunu geliştir ve kazınacak Yakarışı değiştir.(Kullanım: 1/2)"
  },
  Event_7272_Desc = {
    Text = "Uzak şarkı yıldız tozuna parçalanır:\n“Gece sokağındaki pis su birikintisini lanetliyorum, dökülen duvara tutunan çürümüş çiçekleri, çamura gömülürken beyni saran zincirleri. Sis varlığımı silmeden önce, alacakaranlık en derin @3’e çökecek.”"
  },
  Event_7272_Name = {
    Text = "Soluk Lanet"
  },
  Event_7273_ChoiceDesc1 = {
    Text = "[Chase the Song] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7273_Desc = {
    Text = "Uzak şarkı yıldız tozuna parçalanır:\n“Gece sokağındaki pis su birikintisini lanetliyorum, çürümüş çiçekler dökülen duvara tutunuyor, zincirler çamura gömülen beyni sarıp sarmalıyor. Sis varlığımı silmeden önce, alacakaranlık en derin @4’e batacak.”"
  },
  Event_7273_Name = {
    Text = "Soluk Lanet"
  },
  Event_7274_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7274_Desc = {
    Text = "Gümüş Çekirdek Uyanışına karşılık vermedi, fakat sıcak bir aura yaydı."
  },
  Event_7274_Name = {
    Text = "Yalnız Gümüş Çekirdek"
  },
  Event_7275_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7275_Desc = {
    Text = "Dönen siyah bir sis omurgana tırmanır, yere yığılana dek sürünür ve sen bu cümleyi tekrar tekrar mırıldanırsın."
  },
  Event_7275_Name = {
    Text = "Görülmez Olan"
  },
  Event_7276_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7276_Desc = {
    Text = "Evet, gözbebeklerinden yavaşça süzülen camsı sıvı, tabu kaynaklı çürümenin kanıtıdır.\nDürüstlük, tam da şu anda, erdeme karşı konumlanmıştır."
  },
  Event_7276_Name = {
    Text = "Görülmez Olan"
  },
  Event_7277_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7277_Desc = {
    Text = "Kadim sikke yapışkan ve ıslak, sanki kirli bir tortuyla kaplı; gözle görülür siyah dumanlar salıyor."
  },
  Event_7277_Name = {
    Text = "Çift Yüzlü Kalıntı"
  },
  Event_7278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7278_Desc = {
    Text = "Keskin sinir uçların ölümcül bir uyarı yollar. Ani bir refleksle geri sıçrar, isteksizce geri çekilirsin.\nYine kıl payı kurtulmuşsundur...\nBir lanet mi? Yoksa topraktan yeniden doğuş mu?"
  },
  Event_7278_Name = {
    Text = "Çift Yüzlü Kalıntı"
  },
  Event_7279_ChoiceDesc1 = {
    Text = "[Kelebeği Serbest Bırak] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_7279_ChoiceDesc2 = {
    Text = "[Become a Butterfly] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7279_ChoiceDesc3 = {
    Text = "[Swallow Back] 25 Kara Mühür al"
  },
  Event_7279_Desc = {
    Text = "Bu gece çok şey oldu.\nİskeledeki Hücum, hayalet yük gemisi, Denizci, Tulu, Murphy, Ramona… her şey bir girdapta dönüp durdu, Mythag’ın lokantasındaki sabah 7 yulaf lapasına karıştı.\nÖnündeki Uyanan’a bir şeyler sormak istiyorsun ama nereden başlayacağını bilemiyorsun; boğazında bir düğüm—ya da midende uçuşan kelebekler hissediyorsun."
  },
  Event_7279_Name = {
    Text = "Kelebek Etkisi"
  },
  Event_7280_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Arg3 HP kaybet"
  },
  Event_7280_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7280_Desc = {
    Text = "Bulanık yüzler aniden belirir; seni sarar ve var olmayan ses telleriyle umutsuzca inlerler."
  },
  Event_7280_Name = {Text = "İllüzyon"},
  Event_7281_ChoiceDesc1 = {
    Text = "[Join the Prayer] Gümüş Kalıntı \"(RelicConfig.Arg1)\"i elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_7281_ChoiceDesc2 = {
    Text = "[Sink into Ocean] Altın Kalıntı \"(RelicConfig.Arg1)\"i elde et, fakat \"(Skill.Arg2)\" ve \"(Skill.Arg3)\" geliştir."
  },
  Event_7281_ChoiceDesc3 = {
    Text = "[Surface] 25 Kara Mühür al"
  },
  Event_7281_Desc = {
    Text = "\"Yumuşak huylu Tanrı, Yüce Tanrı.\nLütfen azgın fırtınayı dindir ve kuduran akıntıları durdur.\nOkyanusu derin yurdumuz kıl, krallığımızı sonsuz bir örtüyle gizle...\"\nMüminlerin fısıltıları sonunda anlayabildiğin sözcüklere dönüşüyor, ama onlarla birlikte kaçınılmaz bir boğulma da geliyor."
  },
  Event_7281_Name = {
    Text = "Rüya Duası"
  },
  Event_7282_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7282_Desc = {
    Text = "Kalan et parçalarını kedi sürüsünün içine fırlatıyorsun.\nKediler kara gelgit gibi ileri atılıyor, çılgınca eti parçalayıp ardından hızla dağılıyorlar.\nNe yazık ki et bozulmuş. Boş midelerini dolduruyor ama onlara pek az tatmin sunuyor."
  },
  Event_7282_Name = {
    Text = "Kediler Şehri"
  },
  Event_7283_ChoiceDesc1 = {Text = "[Take It]"},
  Event_7283_Desc = {
    Text = "D-balçıktan arıtılmış, neredeyse cıva benzeri bir Gümüş madde; güçlü zihinsel güç barındırır ve ayinlerde daha fazla Uyanan’ı birbirine bağlamak için kullanılır D-balçıktan arıtılmış, neredeyse cıva benzeri bir Gümüş madde; güçlü zihinsel güç barındırır ve ayinlerde daha fazla Uyanan’ı birbirine bağlamak için kullanılır."
  },
  Event_7283_Name = {Text = "Gümüş"},
  Event_7284_ChoiceDesc1 = {
    Text = "[Leave] Bir Uyandırıcıyı Uyanışa çağır, o Kartın Arithmetica Maliyetini 2 azalt, fakat [(Skill.Arg1)] geliştir."
  },
  Event_7284_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7284_Desc = {
    Text = "Şimdi seni duymayabilirler, ama er ya da geç çağrını işitecekler."
  },
  Event_7284_Name = {
    Text = "Yol Gösteren Ses"
  },
  Event_7285_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7285_Desc = {
    Text = "Psyche Deepdive denekleri seni tüketti ve kısacık bir soluklanma anı bile çöldeki yağmur gibi geliyor."
  },
  Event_7285_Name = {
    Text = "Sonsuz Kapılar"
  },
  Event_7286_ChoiceDesc1 = {
    Text = "[Leave] Rastgele bir Uyanışçı’yı uyandır"
  },
  Event_7286_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7286_Desc = {
    Text = "O ses, seni mutlaka varış noktan olan bu soruşturmanın cevabına götürecek."
  },
  Event_7286_Name = {
    Text = "Yol Gösteren Ses"
  },
  Event_7287_ChoiceDesc1 = {
    Text = "[Observe Carefully]"
  },
  Event_7287_Desc = {
    Text = "Kristal küre aracılığıyla uzak diyarları gözlemleyebilirsin."
  },
  Event_7287_Name = {
    Text = "Kristal Küre"
  },
  Event_7288_ChoiceDesc1 = {
    Text = "[Chase the Crows] Arg1 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_7288_ChoiceDesc2 = {
    Text = "[Ignore] Leave"
  },
  Event_7288_Desc = {
    Text = "Karga, gardırobun üzerine tünemiş, sivri gagasıyla ahşap kapının üzerinde tekinsiz desenler oyuyor."
  },
  Event_7288_Name = {
    Text = "Fener Kargası"
  },
  Event_7289_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7289_Desc = {
    Text = "Okuldan gelen bir iletişim isteğini kabul ettin. Tanıdık Ses zihnini sakinleştiriyor. Kendini toparlayıp ilerliyorsun."
  },
  Event_7289_Name = {Text = "Kavşak"},
  Event_7290_ChoiceDesc1 = {
    Text = "[Stay Here] Gümüş Kalıntı [(RelicConfig.Arg1)]yı elde et"
  },
  Event_7290_ChoiceDesc2 = {
    Text = "[Find the Exit] Altın Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" becerisini geliştir"
  },
  Event_7290_Desc = {
    Text = "Tuhaf bir sessizliğin içine adım attın; üst üste binen kapılar kontrolsüzce dönüyor, bedenini girdabın içine çekiyordu.\nBaşın dönmüş, yön duygun altüst olmuş halde tersyüz olmuş kapıların arasında debelendin; Çıkış Yolu’nu güçlükle seçebiliyor, ama kaçınılmaz biçimde, tekrar tekrar başka bir kapının içine düşüyordun.\nBu kez bir kapının önünde durdun; ardındaki Bilinmeyen Yaratık ölümcül bir çekicilik yayıyor, akıl sağlığının tellerini geriyordu.\nEvet, bu ölümcül."
  },
  Event_7290_Name = {
    Text = "Kapıların Ötesinde"
  },
  Event_7291_ChoiceDesc1 = {
    Text = "[Ecstasy] Bir Komut Kartını İmha Et ve Arg1 YP geri kazan"
  },
  Event_7291_ChoiceDesc2 = {
    Text = "[Stop] Altın Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7291_Desc = {
    Text = "Sanki kafatasın zahmetsizce yarılmış, beynine mide bulandıran bir baş dönmesi dalgası dolmuş gibi. Görünmez bir el zihnini karıştırıp çalkalıyor, zaten sıvımsı olan özü lapa hâline getiriyor.\nSindirilmemiş, lapamsı mide içeriği gibi, yerçekimine meydan okuyarak boş, çorak beyin kabuğuna dökülüyor.\nYoğuruyor, karıştırıyor, tırmalıyor; içine sevinç parçacıkları serpiyor ve gün batımının kalıntılarını etine karıştırıyor."
  },
  Event_7291_Name = {
    Text = "Zihin Çalkantısı"
  },
  Event_7292_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7292_Desc = {
    Text = "Aniden beliriveren Cehennem Köpekleriyle kıyaslandığında, sıradan kar yağışı dikkate değmez. Yavaşça düşen kar tanelerini görmezden gelerek geceye doğru atılırsın."
  },
  Event_7292_Name = {Text = "Kar"},
  Event_7293_ChoiceDesc1 = {
    Text = "[Connect] Arg2 HP Yenile."
  },
  Event_7293_Desc = {
    Text = "Sis ağır ağır yapışırken, rozetin solgun bir gümüş titreşimle yanıp sönüyor. İletişimci cızırtıyla hayata dönüyor. Biri arıyor."
  },
  Event_7293_Name = {Text = "Kavşak"},
  Event_7294_ChoiceDesc1 = {
    Text = "[Feel Fear] Altın Kalıntı \"(RelicConfig.Arg1)\"yı elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_7294_ChoiceDesc2 = {
    Text = "[Steadfast Will] 3 Komut Kartından 1'ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7294_Desc = {
    Text = "Uğursuz iniltiler yankılanıyor, ama Londinium ölü ya da uykudaymışçasına sessiz.\nDemiryolu köprüsünün altında dolaşıyor, Alistair'in öğütlerini anımsıyorsun.\nKibarca yaklaşarak konuşmaya çalışıyor, ama sözleri bulanık.\nBaşını kaldırıyorsun—ağzından siyah, koyu bir sıvı sızıyor, sözlerini boğuyor—"
  },
  Event_7294_Name = {
    Text = "Kaos Uluması"
  },
  Event_7295_ChoiceDesc1 = {
    Text = "[Leave] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_7295_Desc = {
    Text = "\"Elbette, elbette. Eğer sakıncası yoksa, sana yardım edebilirim.\"\nSana antika bir el aynası uzatır.\n\"Şah zaten tahtayı aldı, kral da çok geride olmayacak. Onunla yakında karşılaşman muhtemel. Gerçekten heyecan verici, değil mi?\""
  },
  Event_7295_Name = {
    Text = "Garip Yol Arkadaşı IV"
  },
  Event_7296_ChoiceDesc1 = {
    Text = "[Shred the Letter] Herhangi 2 Kartı İmha Et"
  },
  Event_7296_ChoiceDesc2 = {
    Text = "[Continue Reading] Lanetli Kalıntı \"(RelicConfig.Arg1)\" edin, \"(Skill.Arg2)\" bulaştır."
  },
  Event_7296_ChoiceDesc3 = {
    Text = "[Leave] Arg1 Kara Mühür al"
  },
  Event_7296_Desc = {
    Text = "Gözlerinin önünde, siyah kelebeklerden oluşan bir sürü patlayarak ortaya çıkıyor; durmaksızın dışarı taşıp kanat çırparak masanın üzerine düşüyorlar.\nAçılmış, boş mektup kâğıdı mürekkeple sıçramış; yaralı kelebekler üzerinde can çekişiyor.\nKanatlarındaki siyah, yapışkan sıvı sayfanın üzerinde yayılırken tabu sözcükler oluşturuyor.\nBu kâğıdı daktilodan çekip alıyorsun."
  },
  Event_7296_Name = {
    Text = "Kelebek Bölümü"
  },
  Event_7297_ChoiceDesc1 = {
    Text = "[Go to the Butterflies] Bir Komut Kartını İmha Et ve Arg1 Kara Mühür elde et."
  },
  Event_7297_ChoiceDesc2 = {
    Text = "[Linger No Longer]"
  },
  Event_7297_Desc = {
    Text = "Londinium’da son zamanlarda şöyle bir söz dolaşır: \"Yakutsk’ta bir kelebeğin kanat çırpışı, Leonia Krallığı’nda fırtına koparabilir.\"\nKelebeklerin dalga dalga üzerlerine geldiğini gördüğünde, bu sözü hatırlamadan edemezsin.\nBu kelebekler, gezegeni yutacak bir felaketi kışkırtmaya fazlasıyla yeterli olabilir."
  },
  Event_7297_Name = {
    Text = "Gnosis Fırtınası"
  },
  Event_7298_ChoiceDesc1 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_7298_Desc = {
    Text = "Parmağını dudaklarına götürüp sessizliği işaret edersin.\nKara kedi bir fantazma gibi yanından kayar, ayaklarının dibine karanlık bir armağan bırakır."
  },
  Event_7298_Name = {
    Text = "Gece Kedisinin Laneti"
  },
  Event_7299_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7299_Desc = {
    Text = "İpek parçası gibi çantana süzülüp girdi; ağırlıktaki hafif artış neredeyse fark edilmezdi, sanki yumuşak bir teşekkür fısıldıyordu.\nSonrasında her şey sessizliğe gömüldü."
  },
  Event_7299_Name = {Text = "Kaos Ruhu"},
  Event_7300_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7300_Desc = {
    Text = "Kaos Ruhu'nun çığlıkları gitgide keskinleşti, sonunda her yana yayılan delici bir feryada dönüştü.\nSunuların ve kaçınılmaz kederinle, O yeniden bataklığa gömüldü."
  },
  Event_7300_Name = {Text = "Kaos Ruhu"},
  Event_7301_ChoiceDesc1 = {
    Text = "[Answer Honestly]"
  },
  Event_7301_ChoiceDesc2 = {
    Text = "[Doodle Randomly]"
  },
  Event_7301_Desc = {
    Text = "Doğu Bölge’nin sokakları girift ve karmaşıktır; kısa sürede Çocuklar’ı gözden kaybedersin.\nUmudunu yitirmeye başlamak üzereyken, gizemli bir kadın sana yaklaşır.\n \"Çocuklar’ın nereye gittiğini biliyorum, ama söylemeden önce, bana küçük bir iyilik yapar mısın?\"\nBir kâğıt parçası çıkarır ve sana nazikçe gülümser.\n \"Benim adım Clementine. Londinium sakinleri üzerinde psikolojik bir Soruşturma yürüten bir psikoloğum. Şu anketi doldurursan,\nben de memnuniyetle sana ve yoldaşlarına biraz yardım sağlarım.\""
  },
  Event_7301_Name = {
    Text = "Psikolojik Değerlendirme"
  },
  Event_7302_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7302_Desc = {
    Text = "\"“Bu da benim kararımdı,” diyor şekerler tutan siluet. “Ama o, onun piyonu olacak ve er ya da geç bir seçim yapmaya zorlanacaksın.\nBu dünyada kusursuz sonlar yoktur.”\nDerin bir ağıt yüreğini sarıyor. Siluetler yok oluyor; göğsünü tutmuş halde kalıyorsun, bunun bir yansıtma mı yoksa zihinsel stresin doğurduğu bir fantazma mı olduğundan emin olamıyorsun.\""
  },
  Event_7302_Name = {
    Text = "Çatallanan Patikalar"
  },
  Event_7303_ChoiceDesc1 = {
    Text = "[Golden Axe]"
  },
  Event_7303_ChoiceDesc2 = {
    Text = "[Silver Axe]"
  },
  Event_7303_ChoiceDesc3 = {
    Text = "[I Haven't Dropped Anything]"
  },
  Event_7303_Desc = {
    Text = "\"Ey Boyut Aşımının Öncüsü.\"\nKadim bir ses kulaklarında yankılanır; sanki tarih öncesinden, çağları aşarak gelmektedir.\nAşırı bir gerilim içinde, sesin sana tuhaf biçimde tanıdık gelen bir soru sorduğunu duyarsın.\n\"Bu düşürdüğün altın balta mı, yoksa şu gümüş olan mı?\""
  },
  Event_7303_Name = {
    Text = "Ötelerden Gelen Sesler"
  },
  Event_7304_ChoiceDesc1 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7304_Desc = {
    Text = "\"Ah, bu...\" Anket formunu hafifçe afallamış bir ifadeyle geri alır. \"Neyse, sonuçta acelem var diyorsun. Çocuklar o tarafa gitti, çok uzaklaşmış olamazlar.\"\nHızla dönüp koşarsın, neredeyse arkandan gelen fısıltıyı kaçırırsın.\n\"Önemli değil, yeniden karşılaşacağız.\""
  },
  Event_7304_Name = {
    Text = "Psikolojik Değerlendirme"
  },
  Event_7305_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7305_Desc = {
    Text = "\n\"Sen kimsin?\"\n\"Ben, trajik biçimde öldürülen Gümüş Anahtar Taşıyıcısı'nın gölgesiyim. Katil, kurnaz bir albino yılandır.\"\n\"Albino yılan mı? O da ne?\"\n\"Bir hata. İnsanla yılanın karışmasından doğan bir küfür...\"\nSormaya devam etmek istiyorsun, ama gölge aniden dağılır ve geride, altın tozla kaplı bir zemin bırakır."
  },
  Event_7305_Name = {
    Text = "Gümüş Anahtar Taşıyıcısı"
  },
  Event_7306_ChoiceDesc1 = {
    Text = "[Infection\"(Skill.Arg1)\", Gain Golden Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7306_ChoiceDesc2 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_7306_Desc = {
    Text = "Olay 355 (Geliştirme Aşamasında), Son Etki Değil"
  },
  Event_7306_Name = {
    Text = "Olay 355 (Geliştirme Aşamasında)"
  },
  Event_7307_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7307_Desc = {
    Text = "Mideye gömül, kelebeklerle dans et.\nDüşüncenin pulları, kelebeklerle iç içe, içeride yumuşak bir kar gibi süzülüyor.\nYavaş yavaş her şeyi birleştiriyorsun ve bir sonraki fırsat doğduğunda konuşacaksın."
  },
  Event_7307_Name = {
    Text = "Kelebek Etkisi"
  },
  Event_7308_ChoiceDesc1 = {
    Text = "[Refute Them] Yadigâr \"(EnchantConfig.Arg2)\"i rastgele bir Komut Kartına kazı, fakat \"(Skill.Arg1)\" geliştir."
  },
  Event_7308_ChoiceDesc2 = {
    Text = "[Follow them] Yadigâr \"(EnchantConfig.Arg2)\"i rastgele bir Komut Kartına kazı, fakat \"(Skill.Arg1)\" geliştir."
  },
  Event_7308_ChoiceDesc3 = {
    Text = "[Propose New Idea] Yadigâr [(EnchantConfig.Arg1)]i rastgele bir Komut Kartına kazı."
  },
  Event_7308_Desc = {
    Text = "\n \"Lütfen bizden uzak dur.\"\nBir sıçan sürüsü seni sardı, arada en az beş ayaklık mesafeyi koruyarak.\n \"Çoğalmaya çabalar, serpiliriz; seçici değilizdir—bu yüzden insanlığın Işığına hastalık, huzursuzluk ve acı getiririz.\"\n \"İnsanlara fazla yaklaşmamalıyız; burası sizin için bir yer değil.\"\nSıçanların gardını indirmesini sağlamak için, karar verdin ki—"
  },
  Event_7308_Name = {Text = "Veba"},
  Event_7309_ChoiceDesc1 = {
    Text = "[Open Iron Door] \"(RelicConfig.Arg2)\" adlı Altın Kalıntıyı edin, fakat \"(Skill.Arg1)\"i geliştir."
  },
  Event_7309_ChoiceDesc2 = {
    Text = "[Ignore] 50 Kara Mühür al"
  },
  Event_7309_Desc = {
    Text = "Bu, tipik bir güverte altı kemer köprüdür. Rayların yanındaki merdivenler demir bir kapıya çıkar. Ardından, içerden ritmik ve tuhaf bir metal şakırtısı duyarsınız.\nKapıyı incelemek için durur, üzerinde ağır bir asma kilit sallandığını fark edersiniz, ama kilitli değildir."
  },
  Event_7309_Name = {
    Text = "Behind Iron Gates"
  },
  Event_7310_ChoiceDesc1 = {
    Text = "[Leave] 50 Kara Mühür elde et, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7310_Desc = {
    Text = "Ayartmaya direnerek, yerinden kıpırdamıyorsun.\nSesin sahibi hayal kırıklığına uğramış görünüyor, su yüzeyinde birkaç dalgacık yayılıyor ve sonra her şey yeniden sakinleşiyor."
  },
  Event_7310_Name = {
    Text = "Ötelerden Gelen Sesler"
  },
  Event_7311_ChoiceDesc1 = {
    Text = "[Infection\"(Skill.Arg1)\", Gain Golden Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7311_ChoiceDesc2 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_7311_Desc = {
    Text = "Etkinlik 353 (Geliştirme Aşamasında), Nihai Etki Değil"
  },
  Event_7311_Name = {
    Text = "Etkinlik 353 (Geliştirme Aşamasında)"
  },
  Event_7312_ChoiceDesc1 = {
    Text = "[Leave] 50 Kara Mühür elde et, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7312_Desc = {
    Text = "\"Siz insanların başka cevabı yok mu?\"\nSesin sahibi sabırsız bir homurtu saldı, tüm mekânı titretti.\n\"Açgözlü ve cahilsiniz... İşte bu yüzden sizden yoruldum.\""
  },
  Event_7312_Name = {
    Text = "Ötelerden Gelen Sesler"
  },
  Event_7313_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7313_Desc = {
    Text = "Gizli Diyar’ın düzenini kabul et, kayıpta kazanç bul ve lanetli armağanı kucakla."
  },
  Event_7313_Name = {
    Text = "Sanrı Patlaması"
  },
  Event_7314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7314_Desc = {
    Text = "Gözler yavaşça kırpışır; sorunu anlayıp anlamadığından emin değilsindir.\nGözün kenarından altın-kızıl tek bir damla yaş süzülür; sıcak güneş ışığı saçan minik bir yıldıza benzer. Düşüşü hüzün ve merhamet taşır, ta ki tuğlaların üzerinde toza dönüşene dek.\nKendine geldiğinde gözler yok olmuştur."
  },
  Event_7314_Name = {
    Text = "Kör Bakış"
  },
  Event_7315_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7315_Desc = {
    Text = "Üstleri başları sade, hatta biraz kirli birkaç çocuk, peşlerine düşmüş üniformalı bir polis tarafından kovalanarak sokakta koşuyor. Çocuklardan birinin başında, sana bir yerlerden tanıdık gelen kahverengi bir kukuleta var."
  },
  Event_7315_Name = {
    Text = "Anılarımız"
  },
  Event_7316_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7316_Desc = {
    Text = "\"Şarkı söylemeyi kes—\"\nKulak tırmalayan şarkıcıyı uyarır, kulaklarının daha fazla işkence görmesine izin vermezsin."
  },
  Event_7316_Name = {
    Text = "Dar Yolun Canisi"
  },
  Event_7317_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7317_Desc = {
    Text = "\n\"Olduğun yerde kal!!! Sürünerek ilerleyen, eriyen canavar bile kendi uzuvlarını senden daha iyi tanıyor!\"\nSeyircileri bırak...\nBunu kalbinden Dua edersin"
  },
  Event_7317_Name = {
    Text = "Dar Yolun Canisi"
  },
  Event_7318_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7318_Desc = {
    Text = "Siyah balçık yüzüne damlar, karıncalı bir kaşıntı bırakır.\nDayanamayarak kelebeğe doğru hamle yaparsın.\nKelebek, düşmanca hareketinden sıyrılır ve sessizce uzaklara karışır."
  },
  Event_7318_Name = {
    Text = "Var Olmaması Gereken"
  },
  Event_7319_ChoiceDesc1 = {
    Text = "[Praise It] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7319_Desc = {
    Text = "Jenkin şöyle dedi: \"Uyan artık, Johnny! Şiir yazmak ne borçlarını öder ne de sızdıran zemini onarır.\"\nSen şöyle dedin: \"Ne yazık ki, hakikati arayan hücrelerin günde bir milyonluk bir hızla ölecek. Yakında, geriye yalnızca bir beyin sapın kalacak.\"\nBeyin, eğer yapabilseydi, kayıtsızca omuz silkti.\nBeyin şöyle dedi: \"Düşünüyorum, öyleyse varım. Benim düşünce Seviyeme ulaştığında, beyin saplarını artık umursamayacaksın.\""
  },
  Event_7319_Name = {
    Text = "Filozofun Beyni"
  },
  Event_7320_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7320_Desc = {
    Text = "Piyano yumuşak bir iç çekiş bırakır; kalıcı ama teselli verici, melodisinin sonuna gelmiş birinin gülümsemesine benzer.\n \"Yeter ki Çocuklar... yeter ki...\"\nSözleri tam seçemeden, piyanonun Fantazma’sı rüzgârla birlikte yok olur."
  },
  Event_7320_Name = {Text = "Ninni"},
  Event_7321_ChoiceDesc1 = {
    Text = "[Leave] Üç Gümüş Kalıntıdan birini elde et, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7321_Desc = {
    Text = "\nKalın tıbbi dosyayı alır ve açarsın; başlık sayfasında \"G. R.\" yazmaktadır.\n \"Ah canım, ah canım, bu senin kaydın değil, öyle mi?\" der Clementine, en ufak bir telaş göstermeden. \"Zararı yok, başkalarının psişesini incelemek insanın kendi ruhuna da iyi gelebilir sonuçta.\"\nDaha soru soramadan, silueti çoktan gözden kaybolmuştur."
  },
  Event_7321_Name = {
    Text = "Tıbbi Kayıtlar"
  },
  Event_7322_ChoiceDesc1 = {
    Text = "[Leave] Bir Uyandırıcıyı Uyanışa çağır, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7322_Desc = {
    Text = "İnce tıbbi kaydı eline alıp açarsın; içinde yalnızca tek bir cümle yazılı, tek bir sayfa bulursun.\n\"Sonsuz kaos denizinde, Solgun, Bebeği Olmayan Bir Göz durmaksızın gözetler.\"\nSoru sormaya fırsat bulamadan, Clementine’in silueti çoktan gözden kaybolmuştur."
  },
  Event_7322_Name = {
    Text = "Tıbbi Kayıtlar"
  },
  Event_7323_ChoiceDesc1 = {
    Text = "[Connect] Tüm YP’yi Kurtar."
  },
  Event_7323_ChoiceDesc2 = {
    Text = "[Meditate] Bir Uyandırıcıyı Uyanış’a geçir."
  },
  Event_7323_Desc = {
    Text = "Sis ağır ağır yapışırken, rozetin solgun bir gümüş titreşimle yanıp sönüyor. İletişimci cızırtıyla hayata dönüyor. Biri arıyor."
  },
  Event_7323_Name = {Text = "Kavşak"},
  Event_7324_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7324_Desc = {
    Text = "Önemli fiziksel kanıtlar özenle muhafaza edilmeli ve araştırma ile analiz için tarih bölümüne teslim edilmelidir."
  },
  Event_7324_Name = {
    Text = "Şifreli Emir·Bölüm I"
  },
  Event_7325_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7325_Desc = {
    Text = "Yanan güneş, yüksek göklerden sisleri delerek iner ve yorgun ruhları uyandırır."
  },
  Event_7325_Name = {Text = "Yükseliş"},
  Event_7326_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7326_Desc = {
    Text = "Bir tür doyum hissi duyuyorsun. Bakışları, gece göğünde üzerinde titreşerek başka birine odaklanıyor."
  },
  Event_7326_Name = {
    Text = "Kubbenin Gözü"
  },
  Event_7327_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7327_Desc = {
    Text = "O tedirgin edici bakıştan kaçamazsın, tanrıların armağanlarına da direnemezsin."
  },
  Event_7327_Name = {
    Text = "Kubbenin Gözü"
  },
  Event_7328_ChoiceDesc1 = {
    Text = "[Leave] \"(RelicConfig.Arg1)\" Kalıntısını elde et, fakat \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_7328_Desc = {
    Text = "\n \"Sen tam olarak nesin?\" diye dehşetle sorarsın.\n \"Bununla kendini yormana gerek yok. Düşmanımın düşmanı dostumdur, öyle değil mi?\" Adam gülümser.\n \"Hediye sandalyenin üzerinde bırakıldı. Sana iyi şanslar dilerim.\""
  },
  Event_7328_Name = {
    Text = "Garip Yol Arkadaşı IV"
  },
  Event_7329_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7329_Desc = {
    Text = "Ramona, \"Beyaz Önlük\" hakkında daha fazlasını duymayı umarak eğildi. \"Biri gizlice dinliyor!\" Gramofonun sesi aniden yükseldi: \"Gizlice dinliyor, gizlice dinliyor, gizlice dinliyor!\""
  },
  Event_7329_Name = {
    Text = "Başkasının Kulakları"
  },
  Event_7330_ChoiceDesc1 = {
    Text = "[Leave] Tüm Uyanışçıların Aliemus’unu Arg1 artır"
  },
  Event_7330_Desc = {
    Text = "Çocuğun yumuşak elini tutarak, bir kapıdan ötekine geçersin ve sonunda küçük, yıpranmış bir sahneye varırsın.\nÇocuk minnettarlığını ifade etmek için elini sıkar.\n\"Teşekkür ederim, hoşça kal.\""
  },
  Event_7330_Name = {
    Text = "Son Perde II"
  },
  Event_7331_ChoiceDesc1 = {
    Text = "[Descend Further] Gümüş Kalıntı [(RelicConfig.Arg1)]i elde et"
  },
  Event_7331_ChoiceDesc2 = {
    Text = "[Pull Away] 25 Kara Mühür al"
  },
  Event_7331_Desc = {
    Text = "\"Sen\", seni daha derinlere davet eder.\nSarmalın dibinde, geçmişteki ve gelecekteki \"sen\", sana farklı boyutlardan \"armağanlar\" yollar."
  },
  Event_7331_Name = {Text = "Uçurum"},
  Event_7332_ChoiceDesc1 = {
    Text = "[Keep Silent] %100 ihtimalle 25 Kara Mühür elde et"
  },
  Event_7332_ChoiceDesc2 = {
    Text = "[Reach Out and Touch] %50 ihtimalle 50 Kara Mühür kazan, %50 ihtimalle hiçbir şey kazanma."
  },
  Event_7332_Desc = {
    Text = "\"Söyleyeceğim tek bir vecize var—hiç kimse bir kediyi öldüremez!\"\n\"Şu lanet siyah kedi çoktan bağırsakları çıkarılıp vahşi doğada çürümeye bırakılmalıydı, ama gitti aile mezarımı eşeledi, kalan insan etini yiyip kemikleri ve uzuvları her yere Saçılma hâlinde savurdu.\"\n\"Soğuk, karanlık, yarık gibi gözbebeklerinin altında, o irinli sarı cerahat yüzeye çıktı ve ben karabasanlarla kıvranarak sürünerek uzaklaştım, Ruh’um emilip tükenmişti.\"\n\"Bekle... Ne yapıyorsun? Ben deli değilim! Değilim! Kesin bir şey saklıyorsun! Hepsi gerçek—\"\nGerçekten de gerçek. Deli adamın gölgesinin yok oluşunu izlerken, ayaklarının dibindeki sessiz siyah kediyle göz göze geliyorsun."
  },
  Event_7332_Name = {
    Text = "Gece Kedisinin Laneti"
  },
  Event_7333_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7333_Desc = {
    Text = "Ona balmumu müzesinin yolunu sorarsın.\nTuhaf, bu gece onunla beşinci kez karşılaşıyorsun. Ateşini beş kez yaktın ve beş kez yol tarifi istedin.\nYine de, tıpkı onunla durmadan karşılaşman gibi, balmumu müzesinin yerini bir türlü hatırlayamıyorsun."
  },
  Event_7333_Name = {
    Text = "Sokak Lambasının Altındaki Silüet"
  },
  Event_7334_ChoiceDesc1 = {
    Text = "[Chase the Crows] 25 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_7334_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Ayrıl"
  },
  Event_7334_Desc = {
    Text = "Üçüncü karga da ayrıldı, gözden kaybolup ebedi karanlığa uçtu."
  },
  Event_7334_Name = {
    Text = "Kuzgun Bakışı"
  },
  Event_7335_ChoiceDesc1 = {
    Text = "[Leave] 75 Kara Mühür kazan, ancak [(Skill.Arg2)] Semptomunu geliştir"
  },
  Event_7335_Desc = {
    Text = "Postu yumuşak ve ince, hâlâ Koum’un yaşamının sıcaklığını taşıyor.\nBu, alacakaranlıktan önceki son gün batımı ışını; uçup giden, kısacık bir sıcaklık kalıntısı."
  },
  Event_7335_Name = {
    Text = "Kalan Sıcaklık"
  },
  Event_7336_ChoiceDesc1 = {Text = "[Chase]"},
  Event_7336_Desc = {
    Text = "Duvarı dikkatle aradın ve sonunda çalıların ardında gizli bir lağım girişi keşfettin. Lağımdan sürünerek geçtin, fakat canavar çoktan kaçmıştı."
  },
  Event_7336_Name = {Text = "Çıkmaz"},
  Event_7337_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7337_Desc = {
    Text = "Kuşların kendi kuralları vardır. Senin iradene göre hareket etmezler ve senin de doğa yasalarına müdahale etmeye hakkın yoktur."
  },
  Event_7337_Name = {
    Text = "Sürüden Ayrılan Karga"
  },
  Event_7338_ChoiceDesc1 = {
    Text = "[Overlook Reflection] 25 Kara Mühür al"
  },
  Event_7338_ChoiceDesc2 = {
    Text = "[Are You Okay?] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ama \"(Skill.Arg2)\" geliştir."
  },
  Event_7338_Desc = {
    Text = "\"Biliyor musun... yan dairedeki şu yeni Patron hanım hiç dışarı çıkmıyor... Geçen gün ona bir bira aldım, köpüğü tamamen çekildikten sonra birden fark ettim ki... bardakta onun hiçbir gölgesi yoktu!\""
  },
  Event_7338_Name = {
    Text = "Hafıza Kırık Parçası: Bira"
  },
  Event_7339_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7339_Desc = {
    Text = "\"Seninle bir kez daha şarkı söylemeyi gerçekten istiyorum...\"\nSarah’nın çılgın, çarpılmış Ağlayış’ı aniden kesildi, deforme olmuş yüzünde bir parça Şaşkınlık belirdi."
  },
  Event_7339_Name = {
    Text = "\"Sasha Abla\""
  },
  Event_7340_ChoiceDesc1 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_7340_Desc = {
    Text = "\"Ne kadar mutluyum! Ne kadar mutluyum!\" Keskin, gür ve çocukça bir ses kulaklarında çınlıyor: \"Senin için, senin için!\""
  },
  Event_7340_Name = {
    Text = "Gece Perisi"
  },
  Event_7341_ChoiceDesc1 = {
    Text = "[Thick Record]"
  },
  Event_7341_ChoiceDesc2 = {
    Text = "[Thin Record]"
  },
  Event_7341_Desc = {
    Text = "Sana oldukça Tanıdık Ses seslenir. Gözlerini kısarsın, ama silueti tam seçemezsin.\n \"Acele ettiğini biliyorum,\" der Dr. Clementine neşeyle, \"Söz veriyorum vaktini fazla almayacağım.\"\nZihnindeki sise doğru uzanan iki el, her birinde birer tıbbi dosya tutar—biri kalın ve yıpranmış, diğeri ince ve tertemiz.\n \"Anket sonuçlarına dayanarak senin için bir tıbbi kayıt hazırlama cüretini gösterdim. Ne var ki hangisinin sana ait olduğunu unutmuşum. Neden sen seçmiyorsun?\"\nNedense, ince tıbbi dosya tanıdık bir aura yayar; seninle o siluet arasındaki zihinsel bağla hafifçe rezonansa girer."
  },
  Event_7341_Name = {
    Text = "Tıbbi Kayıtlar"
  },
  Event_7342_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7342_Desc = {
    Text = "Görünüşte sıradan bir duvar. Kendini onu tıklatırken buldun, ama sağlam hissettirmedi."
  },
  Event_7342_Name = {
    Text = "Tuhaf Duvar"
  },
  Event_7343_ChoiceDesc1 = {
    Text = "[I'm Not on Water] Rastgele bir Gümüş Kalıntıyı Altın Kalıntı [(RelicConfig.Arg1)]ya Yükselt"
  },
  Event_7343_ChoiceDesc2 = {
    Text = "[Look Down] Gümüş Kalıntı \"(RelicConfig.Arg1)\" elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_7343_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7343_Desc = {
    Text = "\"Hehe, Koruyucu, Winkle’ın uyarısını hâlâ hatırlıyor musun? Dinle, öğle vakti yansımana aşağı bakma.\""
  },
  Event_7343_Name = {
    Text = "Biçimsiz Yansıma"
  },
  Event_7343_Tips1 = {
    Text = "Henüz edinilmemiş Gümüş Kalıntı"
  },
  Event_7344_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7344_Desc = {
    Text = "Elworth'un yarıklarında gizlenmiş, uzak bir gelecekten gelen bir fantazma."
  },
  Event_7344_Name = {
    Text = "Yanardağ Hayaleti"
  },
  Event_7345_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7345_Desc = {
    Text = "Avucunda bir kelebek paramparça oluyor; sanki aniden kırılan camdan bir tavan gibi, parçalar düşüyor, düşüyor, düşüyor yere—"
  },
  Event_7345_Name = {
    Text = "Çelik Köprü Serabı"
  },
  Event_7346_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7346_Desc = {
    Text = "Gölgeden belirmelerini bekleyelim."
  },
  Event_7346_Name = {
    Text = "Fener Kargası"
  },
  Event_7347_ChoiceDesc1 = {
    Text = "[Switch On] Mevcut Görüş Alanını genişlet."
  },
  Event_7347_Desc = {
    Text = "Kadim bir aydınlatma aygıtı etrafındaki siyah Sisi dağıtır.\nOnu saran Sis, sanki nefesiyle rahatsız edilmiş gibi ritmik biçimde dalgalanır."
  },
  Event_7347_Name = {Text = "Projektör"},
  Event_7348_ChoiceDesc1 = {
    Text = "[Point Out the Issue] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7348_ChoiceDesc2 = {
    Text = "[Swallow Doubt] [(Skill.Arg1)] Semptomunu geliştir ve kazınacak Yakarışı değiştir.(Kullanım: 2/2)"
  },
  Event_7348_Desc = {
    Text = "Şimdi bile, Murphy'nin geçmişe dair anlatımını zihninde evirip çeviriyorsun.\nAnılar seninle rezonansa giriyor, zihnini sıkıca zincirleyip sıkarak. Golyat'ın Murphy'ye söylediği son teselli sözleri bile sana huzur getiremedi.\n..Bekle, yıldızların yirmi beş yıl sonra hizalanacağını söylemişlerdi...\nAma karşında duran Murphy apaçık bir ergen..."
  },
  Event_7348_Name = {
    Text = "Zincirlenmiş Hayat"
  },
  Event_7349_ChoiceDesc1 = {
    Text = "[Leave] Üç Gümüş Kalıntıdan birini elde et, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7349_Desc = {
    Text = "Gözyaşı dökmesi gereken kişi o; ondan daha fazla ağlamaya hakkı olan yok.\nAma neden ağlamıyor? Neden kayıtsız duruyor, sanki o insanlar önünde diz çökmüyormuş gibi...?"
  },
  Event_7349_Name = {
    Text = "Sefer Öncesi Ritüeller"
  },
  Event_7350_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7350_Desc = {
    Text = "Ne olursa olsun, başkalarının mahremiyetini kurcalamak nezaketsizliktir."
  },
  Event_7350_Name = {
    Text = "Yazıyla Buluşma"
  },
  Event_7351_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7351_Desc = {
    Text = "Bu, anlık bir düş olmalı."
  },
  Event_7351_Name = {
    Text = "Kuzgun Bakışı"
  },
  Event_7352_ChoiceDesc1 = {
    Text = "[Leave] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_7352_Desc = {
    Text = "Onun anılarındaki herkes ona dua ediyor, ona yalvarıyordu. Sen de kalbinden sessizce dua etmeden edemiyorsun..."
  },
  Event_7352_Name = {
    Text = "Sefer Öncesi Ritüeller"
  },
  Event_7353_ChoiceDesc1 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7353_Desc = {
    Text = "Siyah kedinin altında, kara sümüksü sıvıdan oluşan ince bir akıntı, sokağın girişindeki lağımın içine durmaksızın sızmaktadır. Yaklaşmadığını görünce kedi arkasını döner ve lağıma atlayarak gözden kaybolur."
  },
  Event_7353_Name = {
    Text = "Gece Perisi"
  },
  Event_7354_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7354_Desc = {
    Text = "Panikleyip keskin bir çığlık atarsın.\nSesinle dikkati dağılan, az önce huzursuzca kıpırdayan el bir an tereddüt eder.\nFırsatı yakalayıp derhal kaçarsın."
  },
  Event_7354_Name = {
    Text = "Kasvet Bataklığı"
  },
  Event_7355_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7355_Desc = {
    Text = "Bükülerek, kıvranarak, sürünerek... O rahatsız edici kollarından kaçmak için her yolu denedin.\nSonunda, yepyeni bir üniforma, iki kaburga ve yüzlerce saç telin pahasına kaçmayı başardın."
  },
  Event_7355_Name = {
    Text = "Kasvet Bataklığı"
  },
  Event_7356_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7356_Desc = {
    Text = "\n\"Normal bir olgu. Öyle Acemi gibi telaşlanma,\"\nBebek sana yaklaşır, broşunun yerini düzeltir. \"Bu, yakınlarda özel Boyutlara açılan geçitler olduğuna işaret. Görünüşe göre yönü akıl hastanesine doğru.\""
  },
  Event_7356_Name = {
    Text = "Huzursuz Broş"
  },
  Event_7357_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7357_Desc = {
    Text = "Işık Taşıyıcı Tarikatçıları'nın sunduğu sunuları kabul etmek için hiçbir nedenin yok.\nTiksintiyle kirli ve Grotesk üst üste yığılmış başlarını sallayan bir karga, mezarlığı andıran bir ses çıkararak gaklar ve uçar gider."
  },
  Event_7357_Name = {
    Text = "Lanetli Karga"
  },
  Event_7358_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7358_Desc = {
    Text = "\"“Bu da benim kararımdı,” diyor ayı tutan siluet. “Ama o, onun kuklası olacak ve hepsi ölecek.\nVe sen, bu trajedinin suç ortaklarından biri olmuş olacaksın.”\nYoğun bir suçluluk duygusu seni boğuyor. Siluetler yok oluyor; göğsünü tutmuş halde kalıyorsun, bunun bir yansıtma mı yoksa zihinsel stresin doğurduğu bir fantazma mı olduğundan emin olamıyorsun.\""
  },
  Event_7358_Name = {
    Text = "Çatallanan Patikalar"
  },
  Event_7359_ChoiceDesc1 = {
    Text = "[Keep Covering Ears] Arg1 Kara Mühür al; miktar, bir Uyandıran’ın en yüksek Aliemus değerine eşittir."
  },
  Event_7359_ChoiceDesc2 = {
    Text = "[Keep Covering Ears] Arg1 HP yenile; miktar, sahip olduğun Kara Mühür sayısına göre artar."
  },
  Event_7359_Desc = {
    Text = "Kulağındaki kötü niyetli fısıltılara boyun eğdin. İğne gibi keskin, çığlık atan bir acı kafatasının derinliklerine işliyor.\n\n\"Dur—lütfen dur—istediğini yaptım—durdur bunu—\"\n\nAcıyla başını iki elinle kavrarken, yalnızca uzaklardan gelen kargaların alay dolu kahkahalarını duyuyorsun."
  },
  Event_7359_Name = {
    Text = "Song of Crows"
  },
  Event_7360_ChoiceDesc1 = {
    Text = "[Catch a Crow] Her Uyanışa geçmiş Uyandıran için 25 Kara Mühür al."
  },
  Event_7360_ChoiceDesc2 = {
    Text = "[Howl] Destenizde bir Uyanış kartı seçin ve ona [Doğuştan] Ek’ini iliştirin."
  },
  Event_7360_Desc = {
    Text = "Birden yaramazlık isteği duyup bir karga yakalıyorsun.\nElinde umutsuzca çırpınıyor, sonra sıcak bir sıçramaya dönüşerek patlıyor."
  },
  Event_7360_Name = {
    Text = "Song of Crows"
  },
  Event_7361_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7361_Desc = {
    Text = "Kulaklarını kapatır, gözlerini yumarsın.\nGüm, güm... Kalp atışların tiz çığlıklarla karışarak kaotik bir ölüm senfonisi oluşturur.\nBu anda, eşi benzeri görülmemiş bir dinginlik hissedersin."
  },
  Event_7361_Name = {
    Text = "Song of Crows"
  },
  Event_7362_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7362_Desc = {
    Text = "Gizli Diyar tehlikelerle dolu. Tüm ışıklar yol gösteren birer işaret değildir.\nBazıları, güveleri ölüme çağıran mumlardır."
  },
  Event_7362_Name = {
    Text = "Gece Parıltısı"
  },
  Event_7363_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7363_Desc = {
    Text = "\"Çoktan öldün, Evimize de dönemezsin.\" Sesin, Ross Kar Ovası'nda Uluma Rüzgâr gibi soğuk ve acımasız. Yolcunun İfadesi hiç değişmedi, Sanki böyle olması gerekiyormuş gibi. Elini bir kez daha tuttu, \"Bana Yardım Et! Ben bir Asker'im, uzak doğuya gitmekle görevlendirildim...\""
  },
  Event_7363_Name = {Text = "Yutucu"},
  Event_7364_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7364_Desc = {
    Text = "Telgraf bozulmuş. Fırtınada sahibinin yaşadığı umutsuzluğu hayal et... tıpkı şu an seninki gibi."
  },
  Event_7364_Name = {
    Text = "Silent Telegram"
  },
  Event_7365_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7365_Desc = {
    Text = "\"Elli yarda dümdüz git, sonra sola, sonra sağa, sonra yine sola dön...\nSonra sonuna kadar yürümeye devam et, evin tam orada olacak.\"\nYolcu sevinçten havalara uçtu. El sallayıp vedalaştı ve ardından uzaklaştı.\nDerin bir nefes aldın ve aniden birinin elini kavradığını hissettin. O tanıdık ses bir kez daha kulağında yankılandı:\n\"Lütfen beni kurtar.\nBen uzak Doğu'ya gönderilmiş bir askerim...\""
  },
  Event_7365_Name = {Text = "Yutucu"},
  Event_7366_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7366_Desc = {
    Text = "Nihayet labirentin dışına çıkmayı başarırsınız.\nTam o anda, bu balmumu müzesinin canlı olduğunu fark edersiniz.\nTüm tuhaflık, güzellik ve acımasızlık, kadim bir ayinle birbirine bağlanmıştır.\nVe ayinin kalbinde, Rogers yatar."
  },
  Event_7366_Name = {
    Text = "Göz Labirenti"
  },
  Event_7367_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7367_Desc = {
    Text = "\"Rol Yapma eğlenceli mi, Koruyucu?\" Ramona kolunu çekiştirir. \"Çıkış çok uzakta değil. Leydi Nergis'in karşısında da bu neşeni koruyabilmeni umuyorum.\""
  },
  Event_7367_Name = {
    Text = "Anı Parçası: Eski Rüyanın Yeniden Belirişi"
  },
  Event_7368_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7368_Desc = {
    Text = "\"Bir Uyanan’ın Bağlayıcı’nın iradesine karşı koyması zordur,\" diye yanıtlıyorsun, \"ama biz vazgeçmeyeceğiz.\""
  },
  Event_7368_Name = {
    Text = "Onun Seçimi"
  },
  Event_7369_ChoiceDesc1 = {
    Text = "[Enter] Duvarın içinden, daha derine in."
  },
  Event_7369_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7369_Desc = {
    Text = "Duvara yaklaşırsın ve o, seni içine çekmeye çalışıyormuşçasına birden bükülür."
  },
  Event_7369_Name = {
    Text = "Çarpık Uzay"
  },
  Event_7370_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7370_Desc = {
    Text = "\n“Hayır, bu doğru değil. Hamamböcekleriyle kıyaslayınca, en azından sizin tüylü bedenleriniz var.\nKimse tüylü bir bedene karşı koyamaz.”\nFareler kendi aralarında fısıldaştı ve sonunda senin fikrine katıldılar.\n“Gerçi o kadar da çok tüy yok ya.”\nİltifat edilmek her zaman hoştur. Ayrılmadan önce, fareler sana küçük bir hediye verdi"
  },
  Event_7370_Name = {Text = "Veba"},
  Event_7371_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7371_Desc = {
    Text = "\"Katılıyorum! İnsanlar ve fareler birlikte yaşayamaz!\"\nFareler biraz öfkelenmiş görünerek beyaz dişlerini gösterdiler.\n\"Öyleyse neden hâlâ buradasın? Eşyalarını al ve bir daha asla geri dönme.\""
  },
  Event_7371_Name = {Text = "Veba"},
  Event_7372_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7372_Desc = {
    Text = "Derin denizin altına hoş geldin; attığın her adım muazzam bir baskıyla yüklü.\n\nAşılmaz Kaos Sisi her şeyi gizler; böylesi bir baskı altında bu Karanlık Deniz’de yolunu bulabilecek misin?"
  },
  Event_7372_Name = {
    Text = "Under the Tide"
  },
  Event_7373_ChoiceDesc1 = {
    Text = "[Just Take a Look] Bir Kartı İmha Et"
  },
  Event_7373_ChoiceDesc2 = {
    Text = "[Take a closer look] \"(RelicConfig.Arg1)\" Kalıntısını elde et, fakat \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_7373_Desc = {
    Text = "\"Tak tak...\"\nDaktilo, sanki bir kadeh fazla viski içmiş yaşlı bir ayyaş gibi, siyah mürekkebi tükürürken kekeliyordu.\nSen hızla \"Mason\" adını fark ettin ve derhal yazı kâğıdını çektin."
  },
  Event_7373_Name = {Text = "Daktilo"},
  Event_7374_ChoiceDesc1 = {
    Text = "[Eye Contact] Altın Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7374_ChoiceDesc2 = {
    Text = "[Close Your Eyes] Rastgele 2 Uyandırıcıyı Uyanış’a çağır, ancak [(Skill.Arg1)] becerisini iki kez geliştir."
  },
  Event_7374_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_7374_Desc = {
    Text = "Sayısız göz kulağının etrafında fısıldar.\n\"Yürür, durur, on binlerce yıl ve daha fazlası boyunca adımlarız.\nGüneş, gözlerimizin gözetimi altında solarken, kadim Dünya'daki yaşam seller tarafından yutulurken.\nBiz çoktan evrenin gizemlerine kapıldık.\""
  },
  Event_7374_Name = {Text = "Göz"},
  Event_7375_ChoiceDesc1 = {
    Text = "[Follow the Instructions] Azami CP’yi Arg1 kadar Artır"
  },
  Event_7375_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7375_Desc = {
    Text = "Gümüş Anahtar’ın iz sürme gücünü kullanarak en yakın Kavşak’ı bulmaya çalışırsın; fakat aldığın bilgilerde, sanki birileri tarafından bozulmuşçasına ince sapmalar vardır."
  },
  Event_7375_Name = {
    Text = "Anormal Temas"
  },
  Event_7376_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7376_Desc = {
    Text = "Daktiloyu Mythag Öğrenci setindeki standart keten mendille nazikçe siliyorsun.\nDaktilo sakinleşiyor. Kirlenen mendil ise... Gizli Diyar’da kalıyor."
  },
  Event_7376_Name = {
    Text = "Daktilon'un Fısıltısı"
  },
  Event_7377_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7377_Desc = {
    Text = "Dikkatle bakıyorsun ve sallanan, üst üste binen mürekkep lekelerinin arasından silik bir isim beliriyor: \"Fingal Johansen\".\nBu da kim?"
  },
  Event_7377_Name = {
    Text = "Daktilon'un Fısıltısı"
  },
  Event_7378_ChoiceDesc1 = {
    Text = "[Look Up] \"(EnchantConfig.Arg1)\" Yakarışını 3 Komut Kartından 1’ine kazı, ancak \"(Skill.Arg2)\" Becerisini geliştir."
  },
  Event_7378_ChoiceDesc2 = {
    Text = "[Sun's Angle?] Bir Uyandırıcıyı Uyanışa çağır, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7378_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7378_Desc = {
    Text = "\"Şimdi, derhal güneydoğuya bak. Güneşin Yükseliş Açısı yerinde.\" Bebeğin komutu, iletişimciden geldi."
  },
  Event_7378_Name = {Text = "Yükseliş"},
  Event_7379_ChoiceDesc1 = {
    Text = "[Infection\"(Skill.Arg1)\", Gain Golden Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7379_ChoiceDesc2 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_7379_Desc = {
    Text = "Olay 354 (Geliştirme Aşamasında), Son Etki Değil"
  },
  Event_7379_Name = {
    Text = "Olay 354 (Geliştirme Aşamasında)"
  },
  Event_7380_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7380_Desc = {
    Text = "Çocuklar’ın sesleri piyano tuşlarının altından yükselir.\n<Italic:“Yaşlı Charlie’nin tekiri, tombul ve sevgili...”>\nÇocuklar’ın şarkısının altında, Genç Kadın’ın Yumuşak Ses’i usulca eşlik eder.\nHalüsinasyon mu görüyorsun...?"
  },
  Event_7380_Name = {Text = "Ninni"},
  Event_7381_ChoiceDesc1 = {
    Text = "[Turn Around] 25 Kara Mühür al"
  },
  Event_7381_ChoiceDesc2 = {
    Text = "[Keep Going] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ama \"(Skill.Arg2)\" geliştir."
  },
  Event_7381_Desc = {
    Text = "Ardından Ayak Sesleri yankılanıyor.\nBir gölge gibi, sakin ve ağır adımlarla seni izliyorlar.\nSeninkilerle iç içe geçip boş sergi salonunda yankılanıyorlar."
  },
  Event_7381_Name = {
    Text = "Oxford Ayakkabılar"
  },
  Event_7382_ChoiceDesc1 = {
    Text = "[Fold the Letter] Herhangi 2 Kartı İmha Et"
  },
  Event_7382_ChoiceDesc2 = {
    Text = "[Save Letters] \"(RelicConfig.Arg1)\" Lanetli Kalıntısını edin, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_7382_ChoiceDesc3 = {
    Text = "[Leave] Arg1 Kara Mühür al"
  },
  Event_7382_Desc = {
    Text = "Yeni bir Daktilo.\nKendine özgü bir tuş takımına sahip; bir mikroskop kadar girift ve zarif.\nMükemmel mekanik yapısına hayranlıkla bakarken, aniden siyah harfler belirir.\n“Sayın Bay Rogers,\nAğır bir kalple bildiririz ki akademiden atıldınız.\nBildiğiniz üzere, @2 Akademisi, krallık genelinde katı akademik standartlarıyla Ünlü’dür ve o şoke edici söylentiler @3 bizleri derinden huzursuz etmiştir...”"
  },
  Event_7382_Name = {
    Text = "Yazıyla Buluşma"
  },
  Event_7383_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7383_Desc = {
    Text = "Uzakta, hareketsiz duran cep saati sanki seni uyarır, zaman ve mekânın tuzaklarına düşmemeni hatırlatır."
  },
  Event_7383_Name = {
    Text = "İlahi Bakış"
  },
  Event_7384_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7384_Desc = {
    Text = "Siyah balçık yüzüne damlar, karıncalı bir kaşıntı bırakır.\nDayanamayarak kelebeğe doğru hamle yaparsın.\nKelebek, düşmanca hareketinden sıyrılır ve sessizce uzaklara karışır."
  },
  Event_7384_Name = {
    Text = "Obsidyen Kelebek"
  },
  Event_7385_ChoiceDesc1 = {
    Text = "[Observe Carefully]"
  },
  Event_7385_ChoiceDesc2 = {Text = "[Dig]"},
  Event_7385_Desc = {
    Text = "Koum, üçünüzü de sırtına almış halde akıl hastanesinin içinde bir giriş arayarak ilerliyor.\nAniden sertçe duruyor, neredeyse seni sırtından savuracak gibi.\nSoruların arasında Koum başını eğip yumuşak toprağı kokluyor, sonra da altında gömülü bir şeyi işaret etmek için dönüyor."
  },
  Event_7385_Name = {
    Text = "Derine Gömülü"
  },
  Event_7386_ChoiceDesc1 = {
    Text = "[Receive] 3 Altın Kalıntıdan 1’ini Edin"
  },
  Event_7386_Desc = {
    Text = "Alan boştur; yerde akan koyu sıvı hiçbir şeyi yansıtmadan akıp gider.\nBu bir Düş mü? Parmaklarının arasından bir şeylerin kayıp gittiğini hissedersin."
  },
  Event_7386_Name = {
    Text = "Under-Mirror"
  },
  Event_7387_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7387_Desc = {
    Text = "Kara kanatlar, nemli arka sokağın toprağına düştü ve siyah, çamurumsu bir D-balçığa dönüştü."
  },
  Event_7387_Name = {
    Text = "Çılgın Karga Sürüsü"
  },
  Event_7388_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7388_Desc = {
    Text = "“Bayan Nergis mizahınızı takdir edecektir.” Ramona el salladı ve fantazma dağıldı. “Kendini boyutlar arası yolculuğun bedeli haline getirme.”"
  },
  Event_7388_Name = {
    Text = "Anı Parçası: Eski Rüyanın Yeniden Belirişi"
  },
  Event_7389_ChoiceDesc1 = {
    Text = "[Receive] 3 Altın Kalıntıdan 1’ini Edin"
  },
  Event_7389_Desc = {
    Text = "Evet, o iğrenç yansıma sensin.\nKabarıp taşan kin, ayaklarının dibindeki kara sümükle birleşerek birlikte bükülüp dans eder. Sakıncası yoksa, omzuna da tırmanmak ister."
  },
  Event_7389_Name = {
    Text = "Under-Mirror"
  },
  Event_7390_ChoiceDesc1 = {
    Text = "[Stand Still] 25 Kara Mühür al"
  },
  Event_7390_ChoiceDesc2 = {
    Text = "[Walk Casually] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ama \"(Skill.Arg2)\" geliştir."
  },
  Event_7390_Desc = {
    Text = "Gölgene çöküp onu parçalara ayırırsın, geceyle dolu bir havuza düşersin.\nDağılan karanlık kırıntıları, yok olmuş dünyaya kalan tek bağdır.\nGerçekten bu zifiri karanlık karabasanın içinde yürüyecek misin? Yolunu hâlâ bulamadın."
  },
  Event_7390_Name = {
    Text = "Kâbus Yolcusu"
  },
  Event_7391_ChoiceDesc1 = {
    Text = "[Seek the Source] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı elde et, ancak \"(Skill.Arg2)\"yi geliştir."
  },
  Event_7391_ChoiceDesc2 = {
    Text = "[Replay Record] Tüm Uyandıranlar 50 Aliemus kazanır, ancak sen [(Skill.Arg1)]i geliştirirsin."
  },
  Event_7391_ChoiceDesc3 = {
    Text = "[Dismantle the Phonograph] 3 Yakarıştan 1'ini kazı."
  },
  Event_7391_Desc = {
    Text = "\nKarşına bir Eski Gramofon çıkıyor.\nKurup, iğneyi çizik içindeki Vinil Plak’ın üzerine bırakıyorsun. Senfoni bozulmuş, sanki bant paramparça edilirken pirinç ve yaylı çalgılar birbirine çarpıyor—hiçbir ses bu eserden yara almadan çıkamıyor.\nTını, çıtırtılar eşliğinde sona yaklaşırken ritmik bir vuruntu duyuyorsun.\n“Güm güm... güm güm güm... güm...”\nKaşlarını çatarak iğneyi kaldırıyorsun, ama vuruntu aynı şekilde sürüyor."
  },
  Event_7391_Name = {
    Text = "Yitik Yankı"
  },
  Event_7392_ChoiceDesc1 = {
    Text = "[Gaze at Radiance] Bir Kalıntıyı Lanetli Kalıntı [(RelicConfig.Arg1)]ya dönüştür."
  },
  Event_7392_ChoiceDesc2 = {
    Text = "[Touch the Light] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7392_ChoiceDesc3 = {
    Text = "[Turn and Leave] 25 Kara Mühür al"
  },
  Event_7392_Desc = {
    Text = "Düş Görüsü altında Alan Sisi, gerçekliği karanlık bir örtüyle sarar. Her şey, zar zor seçilebilen silik gölgeler gibi görünür.\nBu sisin içinden bir şeyin ışığı perdeyi deler. Bir gemiyi yönlendiren deniz feneri ya da kaybolmuş bir çocuğa yol gösteren duman gibi, güvenliğe giden yolu işaret eder."
  },
  Event_7392_Name = {
    Text = "Gece Parıltısı"
  },
  Event_7393_ChoiceDesc1 = {
    Text = "[Pause Music] Bir Gümüş Kalıntıyı Altın Kalıntı [(RelicConfig.Arg1)]ya Yükselt."
  },
  Event_7393_ChoiceDesc2 = {
    Text = "[Talking with It] Altın Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ama \"(Skill.Arg2)\" ve \"(Skill.Arg3)\" geliştir."
  },
  Event_7393_ChoiceDesc3 = {
    Text = "[Listen Quietly] 25 Kara Mühür al"
  },
  Event_7393_Desc = {
    Text = "Kirli, katran karası bir sıvı birikintisinden anıların parçalarını topladın.\nKristaller ışıkla titreşiyor, içlerinde incecik dumanlar dönüp dans ediyor, anı kıymıklarıysa rüzgârın savurduğu kum taneleri gibi uçuşuyordu.\nEtrafında kaotik, tuhaf ve tekinsiz sahneler yükseldi.\nGözlerini diktin—\n"
  },
  Event_7393_Name = {
    Text = "Ay Gümüşü Kırığı"
  },
  Event_7394_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7394_Desc = {
    Text = "Bazı düşen kar tanelerini yakalayıp yakından bakarsın. Şeffaf damlalar yerine, koyu, yoğun D-balçık’a dönüşerek erirler."
  },
  Event_7394_Name = {Text = "Kar"},
  Event_7395_ChoiceDesc1 = {
    Text = "[I'm Not on Water] Rastgele bir Gümüş Kalıntıyı Altın Kalıntı [(RelicConfig.Arg1)]ya Yükselt"
  },
  Event_7395_ChoiceDesc2 = {
    Text = "[Look Down] Gümüş Kalıntı \"(RelicConfig.Arg1)\" elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_7395_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7395_Desc = {
    Text = "Sis dağılır ve sana doğru uzanmış iskelet bir el açığa çıkar.\nAşınmış gibidir; pürüzlü yüzeyi yapışkan siyah bir çamurla kaplıdır. Altın ışıkla parlayan yüzükler ve kolyelerle bezenmiştir.\nSeni kendine çağırır.\nYalnızca krizin gölgesinde hazineler en parlak hâliyle parlar."
  },
  Event_7395_Name = {
    Text = "Devirici Pençeler"
  },
  Event_7395_Tips1 = {
    Text = "Henüz edinilmemiş Gümüş Kalıntı"
  },
  Event_7396_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7396_Desc = {
    Text = "Fantazma kaybolmadan önce sana el sallar. Geriye yalnızca soğuk kar ve baş döndüren sıradağlar kalır."
  },
  Event_7396_Name = {
    Text = "Yanardağ Hayaleti"
  },
  Event_7397_ChoiceDesc1 = {
    Text = "[Silver Moon Funeral] Bir Kalıntıyı [(RelicConfig.Arg1)] Lanetli Kalıntıya dönüştür"
  },
  Event_7397_ChoiceDesc2 = {
    Text = "[Silver Moon Prayer] \"(RelicConfig.Arg1)\" Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\" becerisini geliştir"
  },
  Event_7397_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7397_Desc = {
    Text = "Kirli siyah bir sümüksü birikintiden anıların parçalarını topladın.\nKristaller ışıkla titreşiyor, içlerinde kıvrılan dumanlar dolaşıyor, anı kırıntıları rüzgârın savurduğu kum taneleri gibi uçuşuyordu.\nEtrafında kaotik, tuhaf ve tekinsiz sahneler yükseldi.\nGözlerini diktin—"
  },
  Event_7397_Name = {
    Text = "Ay Gümüşü Kırığı"
  },
  Event_7398_ChoiceDesc1 = {
    Text = "[Fuel Up] 3 Yakarıştan 1’ini Oyarak Yaz"
  },
  Event_7398_ChoiceDesc2 = {
    Text = "[Extinguish It] Üç Komut Kartından birine \"(EnchantConfig.Arg1)\" Yakarışını kazı, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_7398_Desc = {
    Text = "\"Ben öldürülen hizmetçinin gölgesiyim ve katil, o aldatıcı yeşil alevdir.\"\nHafifçe kızıl alev sallanır, sizi suçlar.\n\"Bir zamanlar şişkin ayı yansıtan göl kıyısında yaşardım, görkemli ve ışıl ışıldım.\""
  },
  Event_7398_Name = {
    Text = "Solgun Ateş"
  },
  Event_7399_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7399_Desc = {
    Text = "Sen ve gölge sokak lambasının altında, sessizce durdunuz.\nBu gece ay yoktu ve tüm evler suskundu.\nGölgeye el salladın ve uzaklaştın."
  },
  Event_7399_Name = {
    Text = "Sokak Lambasının Altındaki Silüet"
  },
  Event_7400_ChoiceDesc1 = {
    Text = "[Chase the Crows] Arg1 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_7400_ChoiceDesc2 = {
    Text = "[Ignore] Leave"
  },
  Event_7400_Desc = {
    Text = "Kuzgun, yatağın başucuna tünemiş, kan çanağına dönmüş gözleriyle seni izliyor."
  },
  Event_7400_Name = {
    Text = "Fener Kargası"
  },
  Event_7401_ChoiceDesc1 = {
    Text = "[I've Got No Wallet] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_7401_ChoiceDesc2 = {
    Text = "[Ağı Yırt] Rastgele 1 Komut Kartı Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_7401_Desc = {
    Text = "Sarı-turuncu bir ağ havada sessizce süzülüyor; seyrek delikleri, duvar dibine yuvalanmış örümcek-örgülü akrabalarınınkinden çok daha az girift.\nDayanamayıp elini uzatıyorsun; Kırılgan ağ anında çözünüyor ve kulaklarında çocuk kahkahaları yankılanıyor.\n \"Altın, gümüş, sarı, kırmızı, bütün cüzdanlar bizim!\""
  },
  Event_7401_Name = {
    Text = "Vagus Ağı"
  },
  Event_7402_ChoiceDesc1 = {
    Text = "[Repair the Telegraph] Rastgele bir Komut Kartı'na \"(EnchantConfig.Arg2)\" Yakarışını kazı, ancak \"(Skill.Arg1)\" geliştir."
  },
  Event_7402_ChoiceDesc2 = {
    Text = "[Bury the Telegraph] Rastgele bir Komut Kartına \"(EnchantConfig.Arg2)\" Yakarışını kazı, ancak \"(Skill.Arg1)\" geliştir."
  },
  Event_7402_ChoiceDesc3 = {
    Text = "[Ignore] Rastgele bir Komut Kartına [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7402_Desc = {
    Text = "Dar bir mağara yarığında saklanır, kar fırtınasından geçici olarak korunursun. Ama burada uzun süre kalamayacağını bilirsin. O siyah cübbeli figürler seni burada bulursa, Kaçış Yok.\nYarığın bir köşesinde, hasar görmüş bir telgraf makinesi keşfedersin."
  },
  Event_7402_Name = {
    Text = "Kadim Miras"
  },
  Event_7403_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7403_Desc = {
    Text = "Krallığın dört bir yanında buna benzer portreler görmüştün.\n“Kraliçe”, siyah güllerin ortasında, ışık saçarak ayakta durur.\nYalnızca bir farkla—yüzü zalimce oyulmuş, geriye kömürleşmiş, kara bir boşluk bırakılmıştır.\nBugüne dek, Kraliçe’nin gerçek çehresini hâlâ göremedin."
  },
  Event_7403_Name = {
    Text = "Portre Galerisi"
  },
  Event_7404_ChoiceDesc1 = {
    Text = "[Spare Her] Lanetli Kalıntı \"(RelicConfig.Arg1)\"yı elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_7404_ChoiceDesc2 = {
    Text = "[Ona Yardım Et] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: [(EnchantConfig.Arg1)]"
  },
  Event_7404_ChoiceDesc3 = {
    Text = "[Walk My Own Path] 50 Kara Mühür Al"
  },
  Event_7404_Desc = {
    Text = "Üç karanlık, gelip geçici siluet yolunu kesiyor.\n \"Onu bırakabilirsin,\" diyor, D-balçık damlayan bir oyuncak ayı tutan, \"o sadece ürkek, kötü değil. Kimseye zarar vermek istemiyor.\"\n \"Ona yardım edebilirsin,\" diyor, güzelce paketlenmiş bir Şeker torbası tutan, \"onun yapamadığını sen yapabilirsin. Bütün bunlara bir son verebilirsin.\"\n \"Bizi dinlemek zorunda değilsin,\" diyor, elleri boş olan, \"senin kendine ait bir yolun var.\""
  },
  Event_7404_Name = {
    Text = "Çatallanan Patikalar"
  },
  Event_7405_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7405_Desc = {
    Text = "Nergis’in sesi bir an duraksadı.\n“Ah, bunu mu seçtin? Güzel bir seçim. Ödül olarak sana özel bir hediye vereceğim.”\n“O çocukla pek aşina değilim, ama Francis hakkında bir varsayımım var. Ona egemen olan ve ona ‘görme’ gücünü veren duygunun yoğun bir pişmanlık olduğuna inanıyorum. Merak ediyorum, bu pişmanlık karşısında nasıl bir seçim yapacak...”"
  },
  Event_7405_Name = {
    Text = "İpucu Süresi"
  },
  Event_74068_ChoiceDesc1 = {
    Text = "[Incorporate into Brain Vat] [Yedek Beyin Tankı]nı Çekme Desteğine Karıştır."
  },
  Event_74068_Desc = {
    Text = "İnce ince oyulmuş kemerli geçidin içinde, kırmızı tuğlalı dış cephenin eğik çatısında ve duvarları oyulmuş sıra evlerin önünde, uzamış gölgeler dans ediyor; sorulara cevap ararcasına kıvranıyor.\nSıradanlık ölüm mü demektir?\nMevcut hâle razı olmak, kaderinde sönmekte olan bir ateş olmak mı vardır?"
  },
  Event_74068_Name = {
    Text = "Lingering Consciousness"
  },
  Event_74069_ChoiceDesc1 = {
    Text = "[Continue Containment] Deste içinden en fazla 2 Komut Kartı seçip çıkar ve onları [Yedek Beyin Tankı]na yerleştir."
  },
  Event_74069_Desc = {
    Text = "“Onları gördüm. Çok insan, çok mırıltı; bilge, sığ, aklı başında, deli. Bazen, küllerin içinde bile bir umut kıvılcımı doğar.”"
  },
  Event_74069_Name = {
    Text = "Lingering Consciousness"
  },
  Event_7406_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7406_Desc = {
    Text = "Kemirgeni dikkatle teraziden kaldırırsın. Nefesi sakindir, tüylü bedeni avucunun içinde sıcaktır."
  },
  Event_7406_Name = {
    Text = "Akıl ve Tutku"
  },
  Event_7407_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7407_Desc = {
    Text = "Soluk Gümüş Çekirdek bir an parlaklıkla patlar ama anında kaybolur, elde topraktan ayırt edilemez bir kül bırakır.\nSon Gnosis'i tükenen Gümüş Çekirdek, bilinmeyen Ruh için bir beden yeniden şekillendirmeyi başaramaz, ancak tamamen kaybolmadan önce varlığının bir izini bırakır."
  },
  Event_7407_Name = {
    Text = "Varoluşun Kanıtı"
  },
  Event_7408_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7408_Desc = {
    Text = "『O çocukla pek aşina değilim, ama Francis hakkında bir hipotezim var. Onu kontrol altına alan ve ona ‘görme’ gücünü bahşeden duygunun derin bir pişmanlık olduğuna inanıyorum. Merak ediyorum, bu pişmanlık yüzünden nasıl bir seçim yapacak...』"
  },
  Event_7408_Name = {
    Text = "İpucu Süresi"
  },
  Event_7409_ChoiceDesc1 = {
    Text = "[Pull The Paper] Bir Kartı İmha Et"
  },
  Event_7409_ChoiceDesc2 = {
    Text = "[Not Now] \"(RelicConfig.Arg1)\" Kalıntısı’nı elde et, fakat \"(Skill.Arg2)\" Semptom’unu geliştir."
  },
  Event_7409_Desc = {
    Text = "Valizinin içindeki taşınabilir Daktilo aniden kendi kendine yazmaya başlar; fark edene dek yarım sayfa yamuk yumuk metin çıkarır.\n \"Onu gördün. O hep yanı başındaydı—delilik ve fanatizmle lekelenmiş o gölgeler... Siluetine doğrudan bakma.\""
  },
  Event_7409_Name = {
    Text = "Davetsiz Uyarı"
  },
  Event_7410_ChoiceDesc1 = {
    Text = "[Go Left] \"(EnchantConfig.Arg1)\" Yakarışını 3 Komut Kartından 1’ine kazı, ancak \"(Skill.Arg2)\" Becerisini geliştir."
  },
  Event_7410_ChoiceDesc2 = {
    Text = "[Go Right] Bir Uyandırıcıyı Uyanışa çağır, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7410_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7410_Desc = {
    Text = "Görünüşe göre bir labirente girdin.\nSol, sağ, yine sol... Yavaş yavaş sabrını yitiriyorsun, ta ki başını kaldırıp o gözü görene dek.\nGöz seni sakince, haşmetle izliyor; sanki buranın hükümdarıymış gibi."
  },
  Event_7410_Name = {
    Text = "Göz Labirenti"
  },
  Event_7411_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7411_Desc = {
    Text = "Ellerini büyük bir çabayla geri çekersin, kemiklerinin kırılma sesini açıkça duyarsın.\nBu, merakının ödediği bedeldir."
  },
  Event_7411_Name = {
    Text = "İlham Patlaması"
  },
  Event_7412_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7412_Desc = {
    Text = "Fotoğraf makinesini dikkatle inceledin; derisi ve siyah-altın kakmaları pürüzsüz bir parlaklık saçıyordu.\nMercek sana doğrultulmuştu; sanki bakıyor ve gizlice gözlüyordu..."
  },
  Event_7412_Name = {
    Text = "Masumiyeti Kaydet"
  },
  Event_7413_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7413_Desc = {
    Text = "Acımasızca, kameranın içinde saklı bir başka film şeridini çekip çıkardın ve seni dilsiz bırakan görüntüleri açığa çıkardın.\nBanyo edilmemiş film, sadakatle şunu kaydetmişti— siyah bir çamur birikintisinin içinde yatan seni."
  },
  Event_7413_Name = {
    Text = "Masumiyeti Kaydet"
  },
  Event_74145_ChoiceDesc1 = {
    Text = "[Read] Bir Komut Kartı İmha Et ve 25 Kara Mühür kazan."
  },
  Event_74145_ChoiceDesc2 = {
    Text = "[Continue Typing] Bir Kartı kopyala, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_74145_Desc = {
    Text = "Yazıcı şiddetle mürekkep kusuyor.\nSiyah mürekkep, memeden bir hayalet gibi fışkırıyor, havayı doldurup yoğun, baskıcı bir siyah sise dönüşüyor.\nMasum parmakların dokunmasını bekleyen, klavyede gizli bir ipucu var gibi."
  },
  Event_74145_Name = {
    Text = "Hayalet Mürekkebi"
  },
  Event_74146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74146_Desc = {
    Text = "Karanlık bir sokağa adım atıyorsun; sis giysilerini kemirirken, arkandaki gölgeler sayısız göz çiftine bölünüyor. Paslı çanın çınlayışı, beraberinde nemli bir alamet taşıyor.\n\nBütün dolambaçlı yolların sonunda döngülerden örülmüş bir kozaya çökeceğini biliyorsun—çürümüş şafaktan önce, kendi yansımanla yeniden buluşacaksın."
  },
  Event_74146_Name = {
    Text = "Zamanın Külleri"
  },
  Event_74147_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74147_Desc = {
    Text = "Sessizce göğsüne bir işaret çizersin, Ölü Ruh için sessiz bir dua sunarsın.\nBu yok edilmiş dünyada, kurtarma gücünün ötesinde çok fazla şey var.\nKemik hafifçe parlar, uzun zaman önce ölmüş sahibinin bir zamanlar kıymet verdiği bir Gizli Hazine’ye dair bir parıltı açığa çıkarır."
  },
  Event_74147_Name = {
    Text = "Solmuş Kemik"
  },
  Event_74148_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74148_Desc = {
    Text = "\"Her Şeyin Babası merhametinizi hatırlıyor. Her Şeyin Babası bizi gözetecek, acının yüklerinden kurtaracak.\"\n\nHayaleti yavaşça soluyor ve kutsal müziğin sesi rüzgârın amansız uğultusuna dönüşüyor."
  },
  Event_74148_Name = {
    Text = "Organ Duası"
  },
  Event_74149_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74149_Desc = {
    Text = "Açığa çıkmış iskeleti usulca itersin; yavaşça siyah balçığın içine gömülür ve iz bırakmadan yok olur.\nRuhu, hiçlikte huzur bulsun."
  },
  Event_74149_Name = {
    Text = "Solmuş Kemik"
  },
  Event_7414_ChoiceDesc1 = {
    Text = "[Leave] Rakibi yendin ve hiçbir şey olmadı."
  },
  Event_7414_Desc = {
    Text = "\"Görünüşe göre ufaklığın, bir kadının sırlarının öyle kolayca açığa çıkmadığını acı yoldan öğrenmesi gerekecek.\"\nNergis’in sözleri sönümlenirken, önünüzde devasa bir canavar belirir."
  },
  Event_7414_Name = {
    Text = "İpucu Süresi"
  },
  Event_74150_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74150_Desc = {
    Text = "Jenkin’in saklandığı saat kulesinde böylesine hastalıklı oyuncaklar var olmamalı; bu ses, zihninden, anılarından yükseliyor.\nBir Kavanozdaki Beyin olduğun zamanki hisleri hatırlıyorsun—ses dalgalarından dönüştürülen elektrik akımlarını.\nBu tuhaf gürültü yavaş yavaş sıradan ve yatıştırıcı bir hâl alıyor, pürüzsüz bir klasik ezgiye dönüşerek zihninde durmaksızın çalmaya başlıyor."
  },
  Event_74150_Name = {
    Text = "Çan Kulesi Yankıları"
  },
  Event_74151_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74151_Desc = {
    Text = "Bunlar kedi değil... huzursuz Fener Kilisesi Müminleri.\nKara peçenin altından nefret ve düşmanlık sızıyor. Mırıltılar bilincini tırmalıyor, tuhaf ve açıklanamaz halüsinasyonlar getiriyor."
  },
  Event_74151_Name = {
    Text = "Kedinin Mırıltısı"
  },
  Event_74152_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74152_Desc = {
    Text = "Ayakkabılarına yapışırlar, bileğini kavrarlar; açgözlüdürler, Açlıktan Kıvranan’dırlar ve seni yaşadıkları uçuruma sürüklemek için çabalarlar.\nSen, tutunabilmek için can havliyle çırpınır, birkaç adım sendeleyerek geri çekilir ve bir kaçış yolu ararsın.\nFarkında olmadan, bir şey düşürürsün."
  },
  Event_74152_Name = {
    Text = "Kâbusun Aynası"
  },
  Event_74153_ChoiceDesc1 = {
    Text = "[Dodge] 3 Yakarıştan 1’ini Oyarak Yaz"
  },
  Event_74153_ChoiceDesc2 = {
    Text = "[Stop] 3 Komut Kartından 1’ine \"(EnchantConfig.Arg1)\" Yakarışını kazı, ancak \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_74153_Desc = {
    Text = "Tanıdık bir sahne sinirlerini zıplatıyor, seğirtip korkuyla geri çekilmene neden oluyor.\n\"Yine...\"\nMerhametsiz karabasan geliyor ve ezici bir çaresizlik duygusu seni baştan ayağa sarıyor.\nOnun kaderini gerçekten yeniden yazmanın hiçbir yolu yok mu?\nZaman kalmadı. Sarah’nın çatlamış kafatasının içinde, devasa bir ağız gümüş bir parıltıyla ışıldıyor; seni ikiye bölmek, yutmak ve çiğnemek için sabırsızlanıyor."
  },
  Event_74153_Name = {
    Text = "Kâbusun Yeniden Doğuşu"
  },
  Event_74154_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74154_Desc = {
    Text = "Tedirgin edici fısıltılar duyuyorsun.\n\n\"Uzak yıldızların dağlarından ve bataklıklarından geliyoruz. Bedenlerimiz fenerlerin fitili ve yakıtı, ve biz yeryüzünün odunlarını tutuşturup yeni bir dünyaya giden yolu aydınlatacağız.\""
  },
  Event_74154_Name = {
    Text = "Kedinin Mırıltısı"
  },
  Event_74155_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74155_Desc = {
    Text = "Gün batımı, çan kulesi, uçan kuşlar...\nKız göz bandını çıkardı, gri gözbebeklerinin bakışı seni olduğun yere çiviledi.\nDüşler, seraplar gibi, belirir belirmez yok oldu; ama geride kalan kaygılar bir türlü dağılmadı."
  },
  Event_74155_Name = {
    Text = "Beyaz Göz Bandı"
  },
  Event_74156_ChoiceDesc1 = {
    Text = "[Pick Up] 3 Gümüş Kalıntıdan 1’ini Edin"
  },
  Event_74156_ChoiceDesc2 = {
    Text = "[Recall] Gümüş Kalıntı elde et: \"(RelicConfig.Arg1)\", \"(RelicConfig.Arg2)\", \"(Skill.Arg3)\" ile iki kez Sözleşme yap."
  },
  Event_74156_Desc = {
    Text = "Köşedeki aşınmış sümüksü sıvının içinde küçük, Beyaz Göz Bandı yatmaktadır.\nAnılar kalbini pençesine alır."
  },
  Event_74156_Name = {
    Text = "Beyaz Göz Bandı"
  },
  Event_74157_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74157_Desc = {
    Text = "Şeffaf avuç, siyah-beyaz tuşların üzerinde zarifçe süzülür; fakat ürettiği ses dalgaları parçalıdır, uyumsuz bir müzik kutusunu andırır. Her nota, sanki acı içinde yardım istercesine, uyumsuz bir inilti saçar.\nSonunda icra, çaresiz bir akor üzerinde aniden son bulur.\nHayatta elde edilemeyen şey, şimdi bu ana asılı kalır ve geride derin bir özlem duygusu bırakır."
  },
  Event_74157_Name = {
    Text = "Pişmanlık Sonatı"
  },
  Event_74158_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74158_Desc = {
    Text = "\"Sayın Sarah Hanım:\nYoksullar yurdundaki bakıcı görevimden istifa ediyorum.\nFelsefenizi artık destekleyemiyorum. Öğretileriniz yanlış yönlendirilmiş; Doğu Bölgesi'nin çocukları sizin etkileriniz altında büyümemeli, saf iyiliğe ve karşılıksız fedakârlığa inanmamalılar.\nBir gün, kanatlarınızın altından çıkıp Doğu Bölgesi'nin hayatta kalma kurallarını öğrenecekler.\n.....\"\n\nMektubun geri kalanı bulanık ve okunamaz hâlde, koyu bir sıvıyla lekelenmiş."
  },
  Event_74158_Name = {
    Text = "Hayalet Mürekkebi"
  },
  Event_74159_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74159_Desc = {
    Text = "\"Çocuklara sunabildiğim tek şey, onları yağmurdan koruyacak bir çatı ve açlıktan ölmemeleri için yetecek kadar yiyecek. İyi yürekli Bay Rogers Doktor’u getirmeseydi, hastalandıklarında tek bir hap bile alamazlardı.\nÇok kitap okumadım; sokaklarda donup açlıktan ölmemelerini sağlamak, elimden gelenin hepsi bu.\nNe tür insanlar olmayı seçeceklerine hiç karışmadım, ama hayatta kalmaları gerekiyor.\n.....\""
  },
  Event_74159_Name = {
    Text = "Hayalet Mürekkebi"
  },
  Event_7415_ChoiceDesc1 = {
    Text = "[Seek the Source] [(RelicConfig.Arg1)] adlı Altın Kalıntıyı edin."
  },
  Event_7415_ChoiceDesc2 = {
    Text = "[Discard Letter] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] adlı Yakarışı kazı."
  },
  Event_7415_ChoiceDesc3 = {
    Text = "[Check Letter] 50 Kara Mühür al"
  },
  Event_7415_Desc = {
    Text = "Ayaklarının dibine bir mektup daha düşer. Yırtık kâğıt, onu açarken içine korku salar.\n\"Yine geldi. Uyarılarım boşa değilmiş! @4 Burada başlar ve burada bitecek.\"\n\"Kaçmak istiyorum... Ahşap dolaba saklandım, ellerim kontrolsüzce titriyordu. Ama zeminde gümbürdeyen o yapışkan uzuvlar gitgide yaklaşıyor... Bir isim duydum! O oydu! @5!\""
  },
  Event_7415_Name = {
    Text = "Bir İmdat Mektubu Daha"
  },
  Event_74160_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74160_Desc = {
    Text = "\"Teşekkür ederim. Her Şeyin Babası'nın yaratıcı gücü nihayetinde biçimlerimizi yeniden şekillendirecek, bize sonsuz ışık ve alev getirecek.\n\nSona ulaştığımda, Her Şeyin Babası'nın huzurunda sizin için dualar edeceğim.\"\n\nHayaleti yavaşça soluyor ve kutsal müziğin sesi rüzgârın amansız uğultusuna dönüşüyor."
  },
  Event_74160_Name = {
    Text = "Organ Duası"
  },
  Event_74161_ChoiceDesc1 = {
    Text = "[Bury] Bir Komut Kartı yok et ve Arg2 HP yenile. [ExDesc1]"
  },
  Event_74161_ChoiceDesc2 = {
    Text = "[Pray] Altın Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştirin."
  },
  Event_74161_Desc = {
    Text = "Zifiri karanlık D-balçığa yarıya kadar gömülmüş solgun bir iskelet."
  },
  Event_74161_Name = {
    Text = "Solmuş Kemik"
  },
  Event_74162_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74162_Desc = {
    Text = "Doğruca sisin içine adım atıyorsun, hayaletler bir ağ gibi bedenine yapışıyor, soğuk hisler kemiklerine işliyor.\nFısıltıları hafıza parçalarına dönüşüyor, kalbini delip geçiyor.\nİçlerinden geçtiğinde, arkanda illüzyondan başka bir şey kalmıyor ve önünde, yoğun sisin içinde yutmak için bekleyen daha fazla karanlık figür beliriyor."
  },
  Event_74162_Name = {
    Text = "Zamanın Külleri"
  },
  Event_74163_ChoiceDesc1 = {
    Text = "[Avoid Phantasm] \"(RelicConfig.Arg1)\" Altın Kalıntıyı edin, ancak \"(Skill.Arg2)\" becerisini geliştir"
  },
  Event_74163_ChoiceDesc2 = {
    Text = "[Pass Through Phantasm] 3 Altın Kalıntı arasından 1 tane edin, ancak [(Skill.Arg1)] Semptomunu geliştir"
  },
  Event_74163_ChoiceDesc3 = {
    Text = "[Leave] [(RelicConfig.Arg1)] Gümüş Kalıntıyı edin"
  },
  Event_74163_Desc = {
    Text = "Toz, sokakların üzerine ağır bir perde gibi çökmüş; attığın her adımda, sanki zamanın küllerine basıyormuşsun gibi hissedersin.\nUzakta, sisin içinde iki gölgeli siluet belirir; geçmişin hayaletleri gibi, çoktan unutulmuş hikâyeleri fısıldarlar.\nAzgın hayal gücü, dehşet verici Fantazmalar yaratır; kıvrılıp bükülerek yayılır, sanki yaklaşan bir felaketin habercileriymişçesine nefesinin üzerine çöker.\nİlerideki yolun yalnızca daha da karanlıklaşacağını bilirsin; yine de adımların duramaz, durmamalıdır."
  },
  Event_74163_Name = {
    Text = "Zamanın Külleri"
  },
  Event_74164_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74164_Desc = {
    Text = "Sarah’ın ilk azgın saldırısından kıl payı sıyrılırsın.\nBir dahakine bu kadar şanslı olmayabilirsin."
  },
  Event_74164_Name = {
    Text = "Kâbusun Yeniden Doğuşu"
  },
  Event_74165_ChoiceDesc1 = {
    Text = "[Indicate Direction] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_74165_ChoiceDesc2 = {
    Text = "[Pray Together] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_74165_Desc = {
    Text = "Piyano ve orgun sesleri, loş rüzgârın içinde birbirine karışır. Sanki büyülü ezgiler, ıssız sokaklarda sürüklenip dolaşmaktadır.\nAdsız bir rahibe, müziğin ortasında dua eder.\n \"Basit dualar için görkemli törenlere gerek yok. Ulu Baba, bir zamanlar bize bağnaz öğretilerini bahşettiği gibi, bize yine umut tohumları ekecektir.\""
  },
  Event_74165_Name = {
    Text = "Organ Duası"
  },
  Event_74166_ChoiceDesc1 = {
    Text = "[Parry the Monster] Bir Kalıntı’yı [(RelicConfig.Arg1)] adlı Altın Kalıntı’ya Yükselt"
  },
  Event_74166_ChoiceDesc2 = {
    Text = "[Pick Up Stars] \"(RelicConfig.Arg1)\" Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\" becerisini geliştir"
  },
  Event_74166_ChoiceDesc3 = {
    Text = "[Ignore] 25 Kara Mühür al"
  },
  Event_74166_Desc = {
    Text = "Göktaşı yağmuru saat kulesinin üzerine sağanak gibi iner.\nSaydam bir kristal ayaklarının dibine düşer, küçük bir çukur açar.\nÇevren hâlâ, bükülmüş gölgeleri andıran türlü biçimlerdeki Çözündürülmüş Varlıklar’la sarılı. Kükremeler ve ulumalar durmaksızın sürüyor.\nKarar verirsin—"
  },
  Event_74166_Name = {
    Text = "Bir Düşen Yıldız"
  },
  Event_74167_ChoiceDesc1 = {
    Text = "[Rub Your Eyes] 50 Kara Mühür al"
  },
  Event_74167_ChoiceDesc2 = {
    Text = "[Close Your Eyes] 75 Kara Mühür kazan, ancak [(Skill.Arg2)] Semptomunu geliştir"
  },
  Event_74167_Desc = {
    Text = "Juliette’in arkasında iğrenç bir kara kedi sürüsü toplanıyor; bilinmeyen ilahiler mırıldanarak gizemli ve habis bir tehdit yayıyor."
  },
  Event_74167_Name = {
    Text = "Kedinin Mırıltısı"
  },
  Event_74168_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74168_Desc = {
    Text = "Ucuz kumaş dokunuşta biraz sert hissettiriyor, ama yine de özenle temizlenmiş.\nOna iyi bak ve gerçek sahibine iade edileceği günü bekle."
  },
  Event_74168_Name = {
    Text = "Beyaz Göz Bandı"
  },
  Event_74169_ChoiceDesc1 = {
    Text = "[Maintain Distance] 25 Kara Mühür al"
  },
  Event_74169_ChoiceDesc2 = {
    Text = "[Show Mercy] Gümüş Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ama \"(Skill.Arg2)\" geliştir."
  },
  Event_74169_Desc = {
    Text = "Ayaklarının altından sürü halinde fışkırıyorlar.\nAcıyla bulanıklaşmış yüzlerinde, çekilip götürülen gölgende kendini görüyorsun.\nOnları yargılamaya gerçekten hakkın var mı?"
  },
  Event_74169_Name = {
    Text = "Kâbusun Aynası"
  },
  Event_7416_ChoiceDesc1 = {
    Text = "[Discard Fragments] Özel bir yadigâra sahip, Orison ile enfekte: [(EnchantConfig.Arg1)] - Semptom: Çözünme Delilik"
  },
  Event_7416_ChoiceDesc2 = {
    Text = "[Complete the Fragments] Özel Yadigâr yok, \"(Skill.Arg1)\" ile enfekte ol, \"(Skill.Arg2)\" enfeksiyonu kazan"
  },
  Event_7416_Desc = {
    Text = "Solgun uzuvlar önünüzde yavaşça kıvranıyor. Eğilip size doğru kırık kolunu uzatıyor. Acıyla kısılmış gözlerinden, beyaz, alçıya benzer yaşlar taşıyor.\n“Yalnızca... bir parça daha, o zaman yapabileceğim...”"
  },
  Event_7416_Name = {
    Text = "Flesh Reforged"
  },
  Event_74170_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74170_Desc = {
    Text = "Onları kurtarmaya çalışmalısın.\nAma kendini onlara kaptırma."
  },
  Event_74170_Name = {
    Text = "Kâbusun Aynası"
  },
  Event_74171_ChoiceDesc1 = {
    Text = "[Avert Gaze] Maks. HP’yi Arg1 kadar artır"
  },
  Event_74171_ChoiceDesc2 = {
    Text = "[Bakmaya Devam Et] Rastgele 1 Komut Kartı Mühür kazan: \"(EnchantConfig.Arg1)\", 1 \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_74171_Desc = {
    Text = "\"Son geldi.\"\nKalbin sıkışıyor ve daralıyor.\nJuliette'in kendinden emin tonu şüphesiz bir tür hipnoz ve telepatik gücün etkisini taşıyor.\nBu boyuttaki Juliette'i geçmişte tanıdığından ayıran nedir?\nÇok fazla gizem, çok fazla engel.\nJuliette'e bakıyorsun, ancak onun da sana dikkatle baktığını görüyorsun."
  },
  Event_74171_Name = {
    Text = "Son Bakış"
  },
  Event_74172_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74172_Desc = {
    Text = "Elini kaldırıp hayali piyano tuşlarına beceriksizce dokunursun.\nTuşlar çınlar, birbirine dolanır; her nota çiy damlası gibi—berrak ve saydamdır. Ustalıklı, ince işlenmiş icra parmaklarından doğmaz.\nSersemlik içinde, biçimsiz, upuzun bir çift elin seninkilerin üzerine kapandığını görürsün; icranın akışına uyup aşağı yukarı hareket ederler.\nPiyanonun son, uzayıp giden notasının sesi sönene dek zaman sanki donup kalır.\nMemnun bir iç çekiş duyarsın."
  },
  Event_74172_Name = {
    Text = "Pişmanlık Sonatı"
  },
  Event_74173_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74173_Desc = {
    Text = "Sık sık yer değiştiren bilinç dengesizdir ve anlamsız dikkat dağınıklıklarını yok etmen gerekir.\nDikkatini önündeki Jenkin’e odaklarsın ve gramofonun sesi yavaş yavaş silikleşip sise karışarak yok olur."
  },
  Event_74173_Name = {
    Text = "Çan Kulesi Yankıları"
  },
  Event_74174_ChoiceDesc1 = {
    Text = "[Locate the Source] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı elde et, ancak \"(Skill.Arg2)\"yi geliştir."
  },
  Event_74174_ChoiceDesc2 = {
    Text = "[Reminisce] Tüm Uyandıranlar 50 Aliemus kazanır, ancak sen [(Skill.Arg1)]i geliştirirsin."
  },
  Event_74174_ChoiceDesc3 = {
    Text = "[Ignore Noise] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_74174_Desc = {
    Text = "Bir Gramofon iğnesinin bükülme sesini duyarsın.\nBükülmüş iğne, hasar görmüş spiral olukların üzerinde kayar, yavaş ve iliklere işleyen bir titreme üretir."
  },
  Event_74174_Name = {
    Text = "Çan Kulesi Yankıları"
  },
  Event_74175_ChoiceDesc1 = {
    Text = "[Onun İçin Çal] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_74175_ChoiceDesc2 = {
    Text = "[Listening to the Strings] 50 veya daha fazla Aliemus’a sahip her Uyandırıcı için 15 Kara Mühür al."
  },
  Event_74175_ChoiceDesc3 = {
    Text = "[Leave] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_74175_Desc = {
    Text = "\"Sevgili John:\nSon zamanlarda, bize en son piyano çaldığından bu yana birkaç yıl geçtiğini aniden fark ettim.\nBu yıl 81 yaşındayım ve yaşlandıkça gençliğimin Anıları’nı gitgide daha çok değerli buluyorum.\nBu mektubu alırsan, lütfen bir dahaki Londinium’dan geçişinde daireme uğra ve benim için bir parça çal.\""
  },
  Event_74175_Name = {
    Text = "Pişmanlık Sonatı"
  },
  Event_74176_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74176_Desc = {
    Text = "Göğsünde yaşama arzusu kabarıyor ve tereddüt etmeden emri veriyorsun.\nKuşatmayı yarıp geçtikten sonra arkana dönüp baktığında, o yıldızın D-balçık tarafından yutulduğunu görüyorsun.\nD-balçığın girdabında keskin, ritmik bir ses yankılanıyor.\nD-balçığın yüzeyine dokunuyorsun ve çürümüş bir yıldız avucuna düşüyor."
  },
  Event_74176_Name = {
    Text = "Bir Düşen Yıldız"
  },
  Event_74177_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74177_Desc = {
    Text = "Yıldızı yerden alırsın, ama avucunda parlaklığını yitirmiştir.\nAnsızın bastıran bir ezici his seni baştan ayağa ürpertir.\nHayatla ölüm arasındaki bir göz kırpımı anda, şiddetli saldırıdan yana kaçarak kurtulursun, ama kolunda hâlâ iki parmak uzunluğunda bir çizik kalır."
  },
  Event_74177_Name = {
    Text = "Bir Düşen Yıldız"
  },
  Event_74178_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74178_Desc = {
    Text = "Dokunaçların içindeki gizli keskin dişler, kolunu sıyırıp manşetini yırtar ve sıcak kan bileğinden aşağı kızıl bir derecik gibi süzülür.\nSarah’nın İfade’sini okuyamazsın, fakat çatlamış kafatası hafif, titrek bir acı çığlığı salıverir."
  },
  Event_74178_Name = {
    Text = "Kâbusun Yeniden Doğuşu"
  },
  Event_74179_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74179_Desc = {
    Text = "Etrafına bakınıyor, sola ve sağa doğru ilerliyorsun. Ses, seninle saklambaç oynayan bir fare gibi—bir solunda, bir sağında; bazen uzak, bazen yakın.\nOrtalıkta dolanıyorsun ama gürültü giderek artıyor. Metal sürtünme sesleri huzursuzluğunu daha da derinleştiriyor.\nBir anlık dürtüyle cebini yokluyorsun. Sesin kaynağını bulamasan da, küçük bir gizli hazine çıkarıyorsun."
  },
  Event_74179_Name = {
    Text = "Çan Kulesi Yankıları"
  },
  Event_7417_ChoiceDesc1 = {
    Text = "[Leave] Arg1 HP kaybet ve [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_7417_Desc = {
    Text = "\n\"İyi çocuk. Ama yine de sana küçük bir ceza vermeliyim.\"\nNergis’in hafif kahkahası boyutsal yarıkta sönümlendi."
  },
  Event_7417_Name = {
    Text = "İpucu Süresi"
  },
  Event_74180_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74180_Desc = {
    Text = "Bakışlarını kaçırır, Onun Gözleri’yle buluşmaktan sakınırsın.\nYine de bir güç kalbini kaygılı bir hızla çarptırır."
  },
  Event_74180_Name = {
    Text = "Son Bakış"
  },
  Event_74181_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74181_Desc = {
    Text = "Juliette seninle göz göze geliyor.\nBir sonraki an, tamamen çılgınca bir gülümsemeyle, kibrine ve cehaletine alay eder gibi gülümsüyor.\nAncak gülümseme bir anda kayboluyor ve diğerleri buna hiçbir tepki vermiyor... Sadece senin halüsinasyonundan ibaret gibi görünüyor."
  },
  Event_74181_Name = {
    Text = "Son Bakış"
  },
  Event_7418_ChoiceDesc1 = {
    Text = "[Task Relic] Altın Hatıra [(RelicConfig.Arg1)] elde et."
  },
  Event_7418_ChoiceDesc2 = {
    Text = "[Task Relic 2, Obtain Golden Relic \"(RelicConfig.Arg1)\"]"
  },
  Event_7418_ChoiceDesc3 = {
    Text = "[1 random Command Card gains Orison: \"(EnchantConfig.Arg1)\"]"
  },
  Event_7418_Desc = {
    Text = "Etkinlik 254 (Geliştirme Aşamasında), Nihai Etki Değil"
  },
  Event_7418_Name = {
    Text = "Etkinlik 254 (Geliştirme Aşamasında)"
  },
  Event_7419_ChoiceDesc1 = {
    Text = "[Submit Special Orison 1] Rastgele 1 Komut Kartı üzerinde Yakarış kazan: [(EnchantConfig.Arg1)]"
  },
  Event_7419_ChoiceDesc2 = {
    Text = "[Submit Special Orison 2] rastgele bir Komut Kartına bir Orison bahşet: [(EnchantConfig.Arg1)]"
  },
  Event_7419_ChoiceDesc3 = {
    Text = "[Infection \"(Skill.Arg1)\" and \"(Skill.Arg2)\", Gain Golden Relic \"(RelicConfig.Arg3)\"]"
  },
  Event_7419_Desc = {
    Text = "Etkinlik 255 (Geliştirme Aşamasında), Nihai Etki Değil"
  },
  Event_7419_Name = {
    Text = "Etkinlik 255 (Geliştirme Aşamasında)"
  },
  Event_7420_ChoiceDesc1 = {
    Text = "[Dodge Butterfly Card] Herhangi 2 Kartı İmha Et"
  },
  Event_7420_ChoiceDesc2 = {
    Text = "[Embrace the Butterfly] \"(RelicConfig.Arg1)\" Lanetli Kalıntısını edin, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_7420_ChoiceDesc3 = {
    Text = "[Leave] Arg1 Kara Mühür al"
  },
  Event_7420_Desc = {
    Text = "Köşe üstüne köşe dönersin, Cehennem Köpeği’nin takibi hiç bitmeyecek gibidir.\nSızlayan bilekler, zonklayan bir beyin—kaosun ortasında, yeniden kelebekler görürsün. Bunların Delilik’in sanrıları, Alan’ın fısıltıları olduğunu bilirsin. Her yönden içeri süzülürler."
  },
  Event_7420_Name = {
    Text = "Sanrı Patlaması"
  },
  Event_7421_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7421_Desc = {
    Text = "Rüzgâr çanına usulca dokunursun. Birkaç kez hafifçe çınlar, sonra susar. Çoktan geri çekilmiştir— yalnızca karabasanlarda dönmek üzere."
  },
  Event_7421_Name = {Text = "Minik Çan"},
  Event_7422_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7422_Desc = {
    Text = "Zil kısa bir süre çalar, sonra susar. Geri çekilmiştir—yalnızca karabasanlarda dönmek üzere."
  },
  Event_7422_Name = {Text = "Minik Çan"},
  Event_7423_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7423_Desc = {
    Text = "\"Fena değil, oldukça tedbirlisin.\"\nBirden, rüzgâr çanlarından uzak bir ses geldi.\n\"Tedbir sana küçük bir ödül getirecek, ama hepsi bu.\""
  },
  Event_7423_Name = {Text = "Minik Çan"},
  Event_74245_ChoiceDesc1 = {
    Text = "[Leave] [(RelicConfig.Arg1)] Gümüş Kalıntıyı edin"
  },
  Event_74245_Desc = {
    Text = "Takır tukur, zarlar kupanın içinde coşkuyla dans ediyor, tükenene dek dönüp duruyor.\n\n\"Kaybettin. Yine de, beni eğlendirdiğin için bir ödül alabilirsin.\""
  },
  Event_74245_Name = {
    Text = "N'nin Mesajı"
  },
  Event_74246_ChoiceDesc1 = {
    Text = "[Shut the Gate] Rastgele bir Komut Kartına \"(EnchantConfig.Arg2)\" Yakarışını kazı, ancak \"(Skill.Arg1)\" geliştir."
  },
  Event_74246_ChoiceDesc2 = {
    Text = "[Flee in Panic] Rastgele bir Komut Kartı’nın üzerine \"(EnchantConfig.Arg2)\" adlı Yakarış’ı kazı, ancak \"(Skill.Arg1)\" geliştir."
  },
  Event_74246_ChoiceDesc3 = {
    Text = "[Ignore] Rastgele bir Komut Kartına [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_74246_Desc = {
    Text = "Buhar ve dişlilerden örülmüş bir labirentin içine derinlemesine hapsolmuş durumdasın; yukarıda, pirinç borular örümcek ağı gibi kıvrılıyor. Her nefes alışın, kalın makine yağı sisini dalgalandırıyor.\nKontrolden çıkmış mekanik göstergeler duvarlarda seğiriyor; ibreleri, ölçeklere sürtünerek, Viktoryen bir laboratuvardaki can çekişen ateşböceklerine benzeyen tek tük kıvılcımlar saçıyor. Perçinlerin aralıklarından bakır pas sızıyor; bu çelik devin iltihaplı Yaraları’nı andırıyor ve cep saatin çoktan durdu—burada zaman, iç içe geçen dişlilerin yalnızca bir Dua’sı."
  },
  Event_74246_Name = {
    Text = "Steam Labyrinth"
  },
  Event_74247_ChoiceDesc1 = {
    Text = "[Take a Gamble] [(Skill.Arg1)] geliştir ve talihini yokla"
  },
  Event_74247_ChoiceDesc2 = {
    Text = "[Forget It] 25 Kara Mühür elde et"
  },
  Event_74247_Desc = {
    Text = "Sokak köşesindeki koyu siyah sisin içinde, boğucu bir aura yayılıyor.\nSisin içinden, yüzeyleri anlaşılmaz semboller ve ürkütücü desenlerle kaplı iki kadim ve ürpertici zar beliriyor.\nIslak taş levhaların üzerinde, sanki bilinmeyen bir çağrıyı bekliyormuşçasına sessizce duruyorlar.\n\"Benim kim olduğumu biliyorsun. Kumar oynamaya ne dersin?\""
  },
  Event_74247_Name = {
    Text = "N'nin Mesajı"
  },
  Event_74248_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74248_Desc = {
    Text = "“Her şeyi süpürüp götüren, geçmişin ihtişamını boğan bir Felaket gördüm rüyamda. Hayata öfke, umuttan yoksun bir geleceğe karşı çaresizlik hissediyorum. Ruhum korkuyla paramparça oluyor; bu yaklaşan çöküşün ortasında, umarım tetikte kalır ve bu korkunç kaderin gelişini engellersin.”"
  },
  Event_74248_Name = {
    Text = "Last Words' Whisper"
  },
  Event_74249_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74249_Desc = {
    Text = "Siyah duman umutsuzluk içinde titriyor.\nSonra zarlar bir göz açıp kapayıncaya dek yok oluyor.\n\nAklında tek bir soru asılı kalıyor:\nBu zarlar gerçekte neyden yapılmış?"
  },
  Event_74249_Name = {
    Text = "N'nin Mesajı"
  },
  Event_7424_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7424_Desc = {
    Text = "Arkanı dönüyor ve bir çift deri ayakkabı ile bulanık bir insan yansıması görüyorsun.\nGenç bir beyefendiye benziyor.\n\"Rahatsız ettiğim için özür dilerim, siyah bir Oxford ayakkabı çifti gördünüz mü?\"\n\"Hemen önünüzde bir çift var.\"\n\"Hayır, hayır... Bunlar keçi derisinden, sığır derisinden değil.\nOn iki yıldır bu Balmumu Müzesi'nde sıkışıp kaldım—bunlar yanlış ayakkabılar olmalı...\"\nSes mırıldanarak giderek siliniyor."
  },
  Event_7424_Name = {
    Text = "Ayak Sesleri"
  },
  Event_74250_ChoiceDesc1 = {
    Text = "[Discern Man's Voice] 3 Komut Kartından 1’ini kopyala."
  },
  Event_74250_ChoiceDesc2 = {
    Text = "[Kadının Sesini Ayırt Et] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_74250_ChoiceDesc3 = {
    Text = "[Discern the Elder's Voice] 25 Kara Mühür al."
  },
  Event_74250_Desc = {
    Text = "Karanlık bir bataklıkta yapayalnız duruyorsun.\nPusun arasından, gelgitler gibi üst üste binen kaotik mırıltılar duyuyorsun—bazıları titreyen yaşlılardan, bazıları gevezelik eden çocuklardan, bazıları endişeli kadınlardan ve bazıları isimsiz bir dehşetin pençesindeki erkeklerden..."
  },
  Event_74250_Name = {
    Text = "Last Words' Whisper"
  },
  Event_74251_ChoiceDesc1 = {
    Text = "[Advance] 3 Komut Kartı’ndan 1’ini İmha Et ve 75 Kara Mühür al."
  },
  Event_74251_ChoiceDesc2 = {
    Text = "[Rest] 3 Komut Kartı’ndan 1’ini çoğalt ve 25 Kara Mühür al."
  },
  Event_74251_ChoiceDesc3 = {
    Text = "[Look Back] 50 Kara Mühür al"
  },
  Event_74251_Desc = {
    Text = "Issız sokaklarda yürür, her adımında küllerin içine derin damgalar bırakırsın.\n\nŞehrin yolları örümcek ağları gibidir ve sen, onlara dolanmış bir güvesin."
  },
  Event_74251_Name = {
    Text = "Kasvet Şehri"
  },
  Event_74252_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74252_Desc = {
    Text = "Buhar kapısı gökgürültüsüyle kapanırken, iç içe geçmiş dişlilerin gölgeni inç inç soyup aldığını duydun."
  },
  Event_74252_Name = {
    Text = "Steam Labyrinth"
  },
  Event_74253_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74253_Desc = {
    Text = "Tekrarlanan sahneler gözlerinin önünde durmadan yenileniyor ve kaçacak hiçbir yerin yok."
  },
  Event_74253_Name = {
    Text = "Steam Labyrinth"
  },
  Event_74254_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74254_Desc = {
    Text = "Zaman anlamsız bir koordinattır; senin özlediğin yalnızca Gerçek’tir."
  },
  Event_74254_Name = {
    Text = "Steam Labyrinth"
  },
  Event_74255_ChoiceDesc1 = {
    Text = "[Three Points]"
  },
  Event_74255_ChoiceDesc2 = {
    Text = "[Six Points]"
  },
  Event_74255_ChoiceDesc3 = {
    Text = "[One Point]"
  },
  Event_74255_Desc = {
    Text = "Talihsizlik ve delilik taşıyan bu zarları kim atmaya cesaret edebilir?\nSen, işte sensin.\nSeçimini yapıyorsun—"
  },
  Event_74255_Name = {
    Text = "N'nin Mesajı"
  },
  Event_74256_ChoiceDesc1 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_74256_Desc = {
    Text = "Takır tukur, zarlar kupanın içinde coşkuyla dans ediyor, tükenene dek dönüp duruyor.\n\n\"Kaybettin. Yine de, beni eğlendirdiğin için bir ödül alabilirsin.\""
  },
  Event_74256_Name = {
    Text = "N'nin Mesajı"
  },
  Event_74257_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74257_Desc = {
    Text = "Yolculuk sonsuz karanlık ve sınırsız kaosla örtülü.\nKaderini düşünmeye vakit yok. Korkuyu dağıtmalı ve son hüküm inmeden önce varış noktana ulaşmalısın."
  },
  Event_74257_Name = {
    Text = "Kasvet Şehri"
  },
  Event_74258_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74258_Desc = {
    Text = "\"Yılların gölgesine oturmuş, ölümün buz gibi elinin yavaşça yaklaşmasını hissederken, dışarıdaki dünya giderek daha da kararıyor, felaket fısıltılarıyla dolup taşıyor. Yaklaşan yargıdan, çılgınlığımızın hesabının sorulacağı o günden korkuyorum. Sokaklar tehditkâr bir aurayla kaplı; Yargı Günü’müzün hızla yaklaştığından endişe ediyorum. Uygarlığımız uçurumun kenarında sendeleyip duruyor, sanki Yıkım tarafından yutulmak üzereymişiz de kendi ahmak kibrimizle tuzağa düşmüşüz gibi.\""
  },
  Event_74258_Name = {
    Text = "Last Words' Whisper"
  },
  Event_74259_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74259_Desc = {
    Text = "Ölümden kurtulmuş olmak bile nadir bir başarı; daha fazlasını istememelisiniz.\nKırık kalıntıların ve harabelerin gölgeleri hâlâ sizi çağırıyor."
  },
  Event_74259_Name = {
    Text = "Kasvet Şehri"
  },
  Event_7425_ChoiceDesc1 = {
    Text = "[Leave] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_7425_Desc = {
    Text = "\"Öyle mi... pek ilginç.\"\nAnket formunu katlayıp kaldırır ve sana çocukların gittiği yönü gösterir. Sen aceleyle uzaklaşırken, neredeyse arkandan gelen fısıltıyı kaçırırsın.\n\"Yeniden karşılaşacağımız günü iple çekiyorum.\""
  },
  Event_7425_Name = {
    Text = "Psikolojik Değerlendirme"
  },
  Event_74260_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74260_Desc = {
    Text = "Büyük bir gücün ya da kudretli bir kaderin kontrolü altındasın.\nKısa bir mola bu durumu değiştiremez, ama en azından yorgun bacaklarına yürümeye devam edecek gücü verebilir."
  },
  Event_74260_Name = {
    Text = "Kasvet Şehri"
  },
  Event_74261_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74261_Desc = {
    Text = "\"...Şehir artık sıcak bir sığınak değil, gizli bir mezar; dehşeti ve umutsuzluğu besliyor. Bir zamanlar capcanlı olan düşler, şimdi yalnızca korku kırıntıları olarak kaldı. Artık korkusuzmuş gibi davranamıyorum; önümdeki dünya, uyanamadığım bir karabasan gibi.\""
  },
  Event_74261_Name = {
    Text = "Last Words' Whisper"
  },
  Event_74262_ChoiceDesc1 = {
    Text = "[Leave] Altın Kalıntı [(RelicConfig.Arg1)]yı elde et"
  },
  Event_74262_Desc = {
    Text = "Takır tukur, zarlar kupanın içinde coşkuyla dans ediyor, tükenene dek dönüp duruyor.\n\n\"Kaybettin. Yine de, beni eğlendirdiğin için bir ödül alabilirsin.\""
  },
  Event_74262_Name = {
    Text = "N'nin Mesajı"
  },
  Event_7426_ChoiceDesc1 = {
    Text = "[Leave] Rastgele bir Komut Kartına [Yansıma] Yakarışını kazı."
  },
  Event_7426_Desc = {
    Text = "\"Sorun değil, cevabı zaten gözlerinde gördüm. Benim halletmem gereken birkaç iş var, müsaadeni isteyeyim. Senin de ilgilenmen gereken meseleler yok mu? Bak, biri sana doğru geliyor.\"\nArkanı dönersin ve yolun sonunda Işık Taşıyıcı Kilisesi’nden bir siluet belirir."
  },
  Event_7426_Name = {
    Text = "Garip Yol Arkadaşı V"
  },
  Event_7427_ChoiceDesc1 = {
    Text = "[Leave] Rastgele bir Komut Kartına [Hesaplama] Yakarışını kazı."
  },
  Event_7427_Desc = {
    Text = "\"Görünüşe göre bana açılmaya niyetli değilsin. Hayal kırıklığına uğradım, ama önemi yok. Yine de sana nazik bir ipucu vereceğim: Işık Taşıyıcılarının Kilisesi burada ne arıyor?\"\n\"Ah, belli ki birileri sohbet etmemizi istemiyor. Şuraya bak—biri sana doğru geliyor.\"\nArkanı dönüyorsun ve yolun sonunda Işık Taşıyıcı Tarikatçılarının siluetleri beliriyor."
  },
  Event_7427_Name = {
    Text = "Garip Yol Arkadaşı V"
  },
  Event_7428_ChoiceDesc1 = {
    Text = "[Leave] Rastgele bir Komut Kartına [Insight] İlahisini kazı."
  },
  Event_7428_Desc = {
    Text = "\"Dürüstsün, bu da bir ödülü hak ediyor. O hâlde, sana bir ipucu: Neden O, Rye Kasabası'na varır varmaz seni hedef aldı?\"\n\"Ah, galiba birileri sohbet etmemizi istemiyor. Bak, biri sana doğru geliyor.\"\nArkanı dönersin ve yolun sonunda Işık Taşıyıcı Tarikatçıları'nı görürsün."
  },
  Event_7428_Name = {
    Text = "Garip Yol Arkadaşı V"
  },
  Event_7429_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7429_Desc = {
    Text = "Kaotik sesler yavaşça silinir, ellerin boştur, fakat o gelip geçen duygular çoktan Gümüş Anahtar tarafından kaydedilmiştir."
  },
  Event_7429_Name = {
    Text = "Yokluk Kitabı"
  },
  Event_7430_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7430_Desc = {
    Text = "Elini kaosa uzatıyor, alışılmadık bir dokuya sahip bir şeyi yakalıyorsun; avucunda yavaş yavaş şekil alıyor."
  },
  Event_7430_Name = {
    Text = "Yokluk Kitabı"
  },
  Event_7431_ChoiceDesc1 = {
    Text = "[Ayrıl] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_7431_Desc = {
    Text = "\"Yılanın avlanma yöntemini duydun mu? Yılanlar yalnızca yerde sürünerek hareket edebilir; bu yüzden bir çita gibi ani hız patlamalarıyla avlarını kovalamaz, bir kurt sürüsü gibi avlarını kuşatamazlar. Bunun yerine, yılanlar sabırla beklemeyi öğrenmiştir.\"\n\"Avlarının gardını indirdiği o anı beklerler, sonra aniden saldırıp tek ısırmada yutarlar.\""
  },
  Event_7431_Name = {
    Text = "Garip Yol Arkadaşı III"
  },
  Event_7432_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7432_Desc = {
    Text = "Ürkmüş siyah kedinin parlak tüyleri, sise karışıp kaybolmadan önce parmak uçlarında yakıcı bir his bırakıyor."
  },
  Event_7432_Name = {
    Text = "Gece Kedisinin Laneti"
  },
  Event_7433_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7433_Desc = {
    Text = "Sadece deliliğe iman eden o ahmak müminlerin saçma rüyaları."
  },
  Event_7433_Name = {
    Text = "Şifreli Emir·Bölüm II"
  },
  Event_7434_ChoiceDesc1 = {
    Text = "[Keep Eavesdropping] 3 Yakarıştan 1’ini Oyarak Yaz"
  },
  Event_7434_ChoiceDesc2 = {
    Text = "[Cough Loudly] 3 Komut Kartından 1’ine \"(EnchantConfig.Arg1)\" Yakarışını kazı, ancak \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_7434_Desc = {
    Text = "\nDuvarın köşesi, kan damarları gibi dışarı doğru kıvrılan ince ince Çatlak’larla yarıldı.\nHafif bir vızıltı eşliğinde, karşı taraftan gelen tok bir erkek sesi duyuyorsun.\n\"Quentin Bölgesi 5, Wellington Bölgesi 10, Norman Bölgesi 15...\nBu ayki tüm malzemeler yüklendi, sevkiyata hazır, kargo numarası I-0234...\n.....\nAyrıca, Mythag’dan gelen şu insanlar sağ olsun, Whitechapel Bölgesi şu anda sıkıyönetim altında ve en büyük malzeme kaynağımızı kaybettik.\""
  },
  Event_7434_Name = {
    Text = "Kulak Misafiri"
  },
  Event_7435_ChoiceDesc1 = {
    Text = "[Chase the Crows] 20 Kara Mühür al, fakat [(Skill.Arg2)] geliştir."
  },
  Event_7435_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Ayrıl"
  },
  Event_7435_Desc = {
    Text = "Senin ürkütüşünle, bütün kargalar bir kanat çırpışıyla her yöne dağıldı; düşen siyah kanatlar sümüksü bir sıvıya eriyip damlayarak Kara Mühür’ün şeklini aldı."
  },
  Event_7435_Name = {
    Text = "Kuzgun Bakışı"
  },
  Event_7436_ChoiceDesc1 = {
    Text = "[Give Up Resistance] Bir Komut Kartını İmha Et ve Arg1 Kara Mühür elde et."
  },
  Event_7436_ChoiceDesc2 = {
    Text = "[Pull Back Hands]"
  },
  Event_7436_Desc = {
    Text = "Yeni bir daktilo.\nKendine özgü bir tuş takımı var, mikroskop kadar girift ve zarif.\nMerakla ellerini üzerine koyuyorsun, ama parmaklarının klavyede istemsizce uçuştuğunu, giderek hızlandığını fark ediyorsun..."
  },
  Event_7436_Name = {
    Text = "İlham Patlaması"
  },
  Event_7437_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7437_Desc = {
    Text = "Sadece, dinlenebileceği bir tahta parçası arayan çırpınan bir yaratık...\nKelebek kuyruğundan damlayan siyah sıvı yanağına düşerken içini çekersin."
  },
  Event_7437_Name = {
    Text = "Obsidyen Kelebek"
  },
  Event_7438_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7438_Desc = {
    Text = "Okuldan gelen bir iletişim isteğini kabul ettin. Tanıdık Ses zihnini sakinleştiriyor. Kendini toparlayıp ilerliyorsun."
  },
  Event_7438_Name = {Text = "Kavşak"},
  Event_7439_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7439_Desc = {
    Text = "Okuldan gelen bir iletişim isteğini kabul ettin. Tanıdık Ses zihnini sakinleştiriyor. Kendini toparlayıp ilerliyorsun."
  },
  Event_7439_Name = {Text = "Kavşak"},
  Event_7440_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7440_Desc = {
    Text = "Şüphelerin havada asılı kalır, cevapsız. Pencereden süzülen sıcak sarı ışık, Anılar kadar teselli vericidir."
  },
  Event_7440_Name = {
    Text = "Yanardağ Anısı"
  },
  Event_7441_ChoiceDesc1 = {
    Text = "[Pick Up] \"(RelicConfig.Arg2)\" adlı Gümüş Kalıntıyı edin, fakat \"(Skill.Arg1)\"i geliştir."
  },
  Event_7441_ChoiceDesc2 = {
    Text = "[Hesitate] 25 Kara Mühür al"
  },
  Event_7441_Desc = {
    Text = "Sokağın köşesindeki tahta bir fıçının içinde, tuhaf renkte bir nesne süzülüyor. Alışılmadık görünüşü sanki seni “Dokunma” diye uyarıyor."
  },
  Event_7441_Name = {
    Text = "Barrel Flotsam"
  },
  Event_7442_ChoiceDesc1 = {
    Text = "[Leave It to Her] 3 Gümüş Kalıntı arasından 1 tane edin"
  },
  Event_7442_ChoiceDesc2 = {
    Text = "[Interesting Situation] Gümüş Kalıntılar \"(RelicConfig.Arg1)\" ve \"(RelicConfig.Arg2)\"yi elde et, fakat \"(Skill.Arg3)\"ü iki kez geliştir."
  },
  Event_7442_Desc = {
    Text = "\"Burası Mythag iletişim hattı. Ben Erica. Uyanan Lotan’da anormal Gnosis İndeksi dalgalanmaları tespit edildi. Desteğe ihtiyacın var mı?\""
  },
  Event_7442_Name = {
    Text = "Destek İletişimi"
  },
  Event_7443_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7443_Desc = {
    Text = "Kulağındaki kötü niyetli fısıltılara boyun eğdin. İğne gibi keskin, çığlık atan bir acı kafatasının derinliklerine işliyor.\n\n\"Dur—lütfen dur—istediğini yaptım—durdur bunu—\"\n\nAcıyla başını iki elinle kavrarken, yalnızca uzaklardan gelen kargaların alay dolu kahkahalarını duyuyorsun."
  },
  Event_7443_Name = {
    Text = "Karga Sürüsünün Şarkısı"
  },
  Event_7444_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7444_Desc = {
    Text = "Buraya konmuş olması iki anlama gelebilir: ya ihmal edilmiş bir şeydir ya da çok değer verilen. Eğer ikincisiyse, en iyisi sahibine bırakmaktır."
  },
  Event_7444_Name = {
    Text = "Yalnız Gümüş Çekirdek"
  },
  Event_7445_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7445_Desc = {
    Text = "En mutlu olanlar, habersiz kalanlardır."
  },
  Event_7445_Name = {Text = "Gözle"},
  Event_7446_ChoiceDesc1 = {
    Text = "[Spawn Normal Monster]"
  },
  Event_7446_ChoiceDesc2 = {
    Text = "[Spawn Blank Tile]"
  },
  Event_7446_ChoiceDesc3 = {
    Text = "[Spawn Void]"
  },
  Event_7446_Desc = {
    Text = "Bakalım neler üretilebilir."
  },
  Event_7446_Name = {
    Text = "[To Be Packaged]"
  },
  Event_7447_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7447_Desc = {
    Text = "“Sakin ol,” Ramona başına hafifçe vurur, “sadece geçmişin parçaları. Kim bıraktıysa bu boyutsal geçide, bilmiyorum.”\nGerçekten de, havada nostaljik bir koku var."
  },
  Event_7447_Name = {
    Text = "Anı Parçası: Viski"
  },
  Event_7448_ChoiceDesc1 = {
    Text = "[Collect] Bir Gümüş Kalıntıyı Altın Kalıntı [(RelicConfig.Arg1)]ya Yükselt."
  },
  Event_7448_ChoiceDesc2 = {
    Text = "[Throw Them Away] Altın Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" ve \"(Skill.Arg3)\" Becerilerini geliştir."
  },
  Event_7448_ChoiceDesc3 = {
    Text = "[Observe Carefully] 25 Kara Mühür al"
  },
  Event_7448_Desc = {
    Text = "Burada pek çok paramparça Gümüş var.\nMat, kırık dökük... belli ki üst düzey Ödüller değiller.\nBelki de bu Balmumu Heykel Grubu’nun \"canlanabilmesinin\" nedenlerinden biri budur.\nEn kaba Gümüş bile Mucize yaratma potansiyeline sahiptir."
  },
  Event_7448_Name = {Text = "Tutsak Ruh"},
  Event_7449_ChoiceDesc1 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_7449_Desc = {
    Text = "Koum elinden gelen her şeyi verdi.\nŞimdi, onun kurbanının boşa gitmemesini sağlama sırası sende."
  },
  Event_7449_Name = {
    Text = "Kalan Sıcaklık"
  },
  Event_7450_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7450_Desc = {
    Text = "Rüzgâr ve kar sana ebedi sükûnet bahşetsin."
  },
  Event_7450_Name = {
    Text = "Kadim Miras"
  },
  Event_7451_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7451_Desc = {
    Text = "Direncini koruyorsun, kendine sadık kalarak ilahi mırıldanıyorsun.\nKulaklarındaki fısıltılara güvenmiyor, yalnızca insan aklına dayanıyorsun.\nNe var ki... Güvendiğin sağlam zemin koyu siyah bir pislikle yutulduğunda, gözlerini oyup Gözlem için birer araç olarak kullanmak, son anlarında sahip olacağın tek Seçim olacak."
  },
  Event_7451_Name = {
    Text = "Karga Sürüsünün Şarkısı"
  },
  Event_7452_ChoiceDesc1 = {
    Text = "[Leave] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7452_Desc = {
    Text = "Koum senin tarafından geri çekildi ve kıl payı bir darbeden sıyrıldı. Sana minnetle başını salladı ve yeniden denek yaratığın üzerine atıldı."
  },
  Event_7452_Name = {Text = "Arena"},
  Event_7453_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7453_Desc = {
    Text = "Çın çın...\nParalar cüzdana düşüp berrak ve hoş bir ses çıkarır.\nCüzdan memnuniyetle çiğner ve geğirir.\nCömertliğinizden duygulanan cüzdan gardını tamamen indirir.\nArtık, emrinizdedir."
  },
  Event_7453_Name = {
    Text = "Gluttonous Purse"
  },
  Event_7454_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7454_Desc = {
    Text = "Pirinç bir sikke dipsiz uçuruma düştü, hiçbir ses çıkmadı.\nBeş dakika boyunca sabırla bekledin. Cüzdan acıyla inledi ve sonunda bir havuz dolusu siyah sümüksü madde kustu.\nBu onun sessiz protestosuydu"
  },
  Event_7454_Name = {
    Text = "Gluttonous Purse"
  },
  Event_7455_ChoiceDesc1 = {
    Text = "[Look into the Distance]"
  },
  Event_7455_ChoiceDesc2 = {
    Text = "[Listen Carefully]"
  },
  Event_7455_Desc = {
    Text = "Celeste elindeki pusulayı sallar. Konuşmaz, ama etrafında hafif bir şarkı yankılanır.\nBurada, denizcilerin ilahileri zaman boyunca örülüp üst üste biner; kaotik ama güçlü bir denizci türküsü seni yönlendirir ve Bakışını geminin öteki ucuna çevirir."
  },
  Event_7455_Name = {
    Text = "Denizci Türküsü"
  },
  Event_7456_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7456_Desc = {
    Text = "İçeri girip küçük prova seansını yarıda kesiyorsun.\nParmak pozisyonundan temel müzik teorisine kadar her ayrıntıyı acımasızca eleştiriyorsun.\nMüzik aniden kesilir ve hem çocuk hem de öğretmen sana aynı tekinsiz gülümsemeyle döner.\n133, 355, 244...\nPiyano yeniden çalmaya başlar, hâlâ korkunç biçimde detonedir.\nMeğer hiçbir şey duyamıyorlarmış."
  },
  Event_7456_Name = {
    Text = "Piyano Dersi"
  },
  Event_7457_ChoiceDesc1 = {Text = "[Take It]"},
  Event_7457_Desc = {
    Text = "Alan’da bulunan siyah bir işaret, Yadigârlar ya da diğer ruhsal yansıtımlar için D-Mark’a kurban edilebilir. Mevcut bölgeden ayrıldıktan kısa süre sonra siyah bir çamura çözünerek yok olacaktır."
  },
  Event_7457_Name = {
    Text = "Kara Mühür"
  },
  Event_7458_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7458_Desc = {
    Text = "O esrarengiz kişiyi bulmak şu an her şeyden daha önemliydi. Bu düşünceyle Ramona hızla oradan ayrıldı."
  },
  Event_7458_Name = {
    Text = "Başkasının Kulakları"
  },
  Event_7459_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7459_Desc = {
    Text = "Bilinçte kendini bırak, Fitil Yolu boyunca Derin Deniz’e, duaların izini sürerek bat.\nDipte batmış altın ülkeyi görürsün, ölümsüz taş Heykel’leri görürsün ve sonunda Gölgeler içindeki titreşen gözlerle yüzleşirsin...\n\"İlahi kan dökmemiş olanlar... gidin, gidin.\""
  },
  Event_7459_Name = {
    Text = "Rüya Duası"
  },
  Event_7460_ChoiceDesc1 = {
    Text = "[Leave] 3 Lanetli Kalıntıdan 1’ini edin, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7460_Desc = {
    Text = "Ramona, deneklerden birinin boğazını tek bir saplamayla delip geçti. Koum cansız bedeni bir kenara fırlatıp bir sonraki hedefe doğru atıldı."
  },
  Event_7460_Name = {Text = "Arena"},
  Event_7461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7461_Desc = {
    Text = "Karga, tıpkı insanların kendi bedenlerini kemirmesi gibi, kanatlarını didikler.\nKorkunun hüküm sürdüğü bu dünyada, böylesi sahneler olağandır. Tüm canlıları kurtaramazsın."
  },
  Event_7461_Name = {
    Text = "Erimiş Gözyaşı"
  },
  Event_7462_ChoiceDesc1 = {
    Text = "[Soothe Koum]"
  },
  Event_7462_ChoiceDesc2 = {
    Text = "[Shout for Koum]"
  },
  Event_7462_Desc = {
    Text = "Kocaman canavar, küçük siluete umutsuzca kükreyerek eski yoldaşlarını uyandırmaya çalışır. Ne var ki hasar görmüş ses telleri yalnızca alçak, tuhaf hırıltılar çıkarabilir."
  },
  Event_7462_Name = {
    Text = "Dostluğun Çağrısı"
  },
  Event_7463_ChoiceDesc1 = {
    Text = "[Leave] Projektör Ara"
  },
  Event_7463_ChoiceDesc2 = {
    Text = "[Break into Mist] Arg2 HP kaybet"
  },
  Event_7463_Desc = {
    Text = "İleride yoğun, siyah bir sis uzanıyor; düşüncesizce içine dalmak felaket getirir.\nBelki de sisi dağıtmak için bir \"Projektör\" bulmalısın."
  },
  Event_7463_Name = {Text = "???"},
  Event_7464_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7464_Desc = {
    Text = "\"Seninki gibi gıcırdayan bir çene mi? Hayatımda böyle bir şey görmedim.\"\nBay Çene’nin kaba isteğini reddettin. Bay Çene son derece hayal kırıklığına uğradı ama Soğukkanlılığını korumayı başardı.\nSabırlı dinleyişine teşekkür etmek için sana küçük bir hediye verdi."
  },
  Event_7464_Name = {
    Text = "Gıcırdama"
  },
  Event_7465_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7465_Desc = {
    Text = "Bu tuhaf isteği kabul ettin ve Bay Çene Kemiği’ni de yanında getirdin.\nCebinde yatıyor, durmaksızın şakırdıyor. Yoldaşının tercümesine göre, sözleri çoğunlukla minnettarlık, nostalji ve pişmanlık ifade ediyor.\nPeki nasıl bu hâle geldiğine gelince? Bay Çene Kemiği ayrıntıya girmeye yanaşmıyor, yalnızca şunu söylüyor:\n“Bilirsin. Sen @2’e baktığında, @2 de sana bakar.”"
  },
  Event_7465_Name = {
    Text = "Gıcırdama"
  },
  Event_7466_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7466_Desc = {
    Text = "İpek parçası gibi çantana süzülüp girdi; ağırlıktaki hafif artış neredeyse fark edilmezdi, sanki yumuşak bir teşekkür fısıldıyordu.\nSonrasında her şey sessizliğe gömüldü."
  },
  Event_7466_Name = {Text = "Kaos Ruhu"},
  Event_7467_ChoiceDesc1 = {Text = "[Advance]"},
  Event_7467_Desc = {
    Text = "Tık.\nAnahtarı kilide yerleştirir ve kapıyı usulca iterek Kapı Açıldı.\nTüm süreç sorunsuz ilerler, yaklaşan soruşturma için özgüvenini besler."
  },
  Event_7467_Name = {
    Text = "Paslı Kapı"
  },
  Event_7468_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7468_Desc = {
    Text = "Ses derin bir kahkaha attı, ayaklarının dibindeki sıvıda halkalar oluştu.\n\"Yakında fark edeceksin ki, ölümle yüzleşmekten başka yapman gereken hiçbir şey yok.\""
  },
  Event_7468_Name = {
    Text = "Aramaman Gereken Şey"
  },
  Event_7469_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7469_Desc = {
    Text = "Bu hafızayı atıyor, bilincini aldatıcı konfordan çekip alıyorsun."
  },
  Event_7469_Name = {
    Text = "Dünün Kucağı"
  },
  Event_7470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7470_Desc = {
    Text = "Sadece kısa bir hafif uyku. Teselli olmadan, bu sonsuz geceye nasıl tahammül edeceksin...?"
  },
  Event_7470_Name = {
    Text = "Dünün Kucağı"
  },
  Event_7471_ChoiceDesc1 = {
    Text = "[Pick up the Photo] 3 Komut Kartı’ndan 1’ine [(EnchantConfig.Arg1)] Yakarı’nı kazır."
  },
  Event_7471_Desc = {
    Text = "Bu bir grup fotoğrafı.\nÜzgün insanlar demir parmaklıkların ardında çömelmiş, yüzleri acıyla dolu.\nBir fotoğraf gözünü takılıyor. Zayıf bir genç kadın, yüzü bomboş.\nKutsal değerlere küfreden urumsu çıkıntılar bedenini sarmalamış.\nYüzünü göremiyorsun, ama ifadesiz olacağını hayal ediyorsun."
  },
  Event_7471_Name = {
    Text = "Birebir Kayıt"
  },
  Event_7472_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7472_Desc = {
    Text = "Bu, kuşun Kalıntı Beden’i."
  },
  Event_7472_Name = {
    Text = "Çılgın Karga Sürüsü"
  },
  Event_7473_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7473_Desc = {
    Text = "Piyanistin isteğini soğukça reddettin.\nPiyanist tam anlamıyla yıkıldı. Diğer kulağını da koparıp ikisini birden pencereden dışarı fırlattı.\n\"Zaten onlara ihtiyacım yok.\"\nMelankolik piyanist, yüzünden süzülen yaşlarla, bir dizi kederli nota çaldı."
  },
  Event_7473_Name = {Text = "Kulak Ver"},
  Event_7474_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7474_Desc = {
    Text = "Kaos Ruhu'nun çığlıkları gitgide keskinleşti, sonunda her yana yayılan delici bir feryada dönüştü.\nSunuların ve kaçınılmaz kederinle, O yeniden bataklığa gömüldü."
  },
  Event_7474_Name = {Text = "Kaos Ruhu"},
  Event_7475_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7475_Desc = {
    Text = "Bu bir Tek Yön Geçit; buradan girişe geri dönemezsin."
  },
  Event_7475_Name = {Text = "Geçit"},
  Event_7476_ChoiceDesc1 = {
    Text = "[Leave] \"(RelicConfig.Arg1)\" Kalıntısını elde et, fakat \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_7476_Desc = {
    Text = "“Öyleyse, lütfen gözlerini kapa ve yaklaşan Ayak Sesleri’nin sesini sessizce hisset.”\nTavsiyesine uyarak gözlerini kapattın. Bir anda, tuhaf bir canavar nefesi kulaklarında uğuldadı.\nŞokla gözlerini açtığında, az önceki adam çoktan ortadan kaybolmuştu."
  },
  Event_7476_Name = {
    Text = "Garip Yol Arkadaşı I"
  },
  Event_7477_ChoiceDesc1 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7477_Desc = {
    Text = "“Bu gerçekten üzücü.”\nAdam gözlüğünü düzeltti, sesi alçaktı.\n“Yine de, onu hiç duymadıysanız, bu saatte buraya neden geldiniz?”\nBir cevap beklemeden kenara çekildi."
  },
  Event_7477_Name = {
    Text = "Garip Yol Arkadaşı I"
  },
  Event_7478_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7478_Desc = {
    Text = "Azimli adımlarla ileri yürüyorsun.\nBir adım, iki adım, üç adım...\nArdındaki ayak sesleri karanlıkta siliniyor.\nYeniden karşılaşacaksınız."
  },
  Event_7478_Name = {
    Text = "Oxford Ayakkabılar"
  },
  Event_7479_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7479_Desc = {
    Text = "Yarım bir reverans yapıp yanındaki masadan tepsiyi kaldırıyor, prensesin muhafızına dönüşüyorsun.\nŞanslı prensesin kim olduğuna gelince—elbette en sadık ortağın.\n\"Bir daha yüzüme çay dökersen, gelecek ayın ders notlarını unut gitsin.\"\nBu da prensesin sana uyarısı."
  },
  Event_7479_Name = {
    Text = "Kusursuz Kılık Değiştirme"
  },
  Event_7480_ChoiceDesc1 = {
    Text = "[Listening Quietly] Rastgele bir kartın Yakarış niteliğini güçlendir."
  },
  Event_7480_ChoiceDesc2 = {
    Text = "[Ona O] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte et"
  },
  Event_7480_Desc = {
    Text = "Sarah'nın çığlıkları zihninde yankılanıyor. Hiçlikten soluk, tanıdık bir ses beliriyor, güçsüzce fısıldayarak: \"Sasha Abla\", \"Sasha Abla.\"\n\"Sasha Abla, neredesin?\""
  },
  Event_7480_Name = {
    Text = "\"Sasha Abla\""
  },
  Event_7481_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7481_Desc = {
    Text = "\"... Tamamen yalan da sayılmaz, ama tek başına Arzu, Çözündürülmüş Varlık sorununu çözmez. Hadi daha somut bir şey yapalım.\""
  },
  Event_7481_Name = {
    Text = "Rogers Kuralı"
  },
  Event_7482_ChoiceDesc1 = {
    Text = "[Tune] 100 Kara Mühür al"
  },
  Event_7482_ChoiceDesc2 = {
    Text = "[Rastgele 2 Komut Kartı Mühür kazanır: \"(EnchantConfig.Arg1)\"]"
  },
  Event_7482_Desc = {
    Text = "Dengelenmiş Gnosis’ten oluşan yadigârlar, belki de uyumlu ezgiler doğurabilir."
  },
  Event_7482_Name = {Text = "Uyumsuzluk"},
  Event_7483_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7483_Desc = {
    Text = "\"Bu, bu boyuta girmiş birinin anı Parçası,\" diye yanıtladı Ramona, \"Boyutlar arasında yolculuk ederken bununla karşılaşmak kolaydır. Onu kendi Anılarınla karıştırmamaya dikkat et.\""
  },
  Event_7483_Name = {
    Text = "Anı Parçası: Viski"
  },
  Event_7484_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7484_Desc = {
    Text = "Kalp atışının ritmini izle ve parıltının peşine düş. Ayrılmayacaksınız; tıpkı hiç kimsenin gündüz ile geceyi tam olarak ayıramaması gibi."
  },
  Event_7484_Name = {
    Text = "Sol Kulakçık"
  },
  Event_7485_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7485_Desc = {
    Text = "O huzursuz elleri okşamayı sürdürür, onları sakinleştirmeye çalışırsın.\nÇok geçmeden, dünyan bütünüyle sessizliğe gömülür.\nAşk, daima kendi ödülünü beraberinde getirir."
  },
  Event_7485_Name = {
    Text = "Kasvet Bataklığı"
  },
  Event_7486_ChoiceDesc1 = {
    Text = "[Struggle] Gümüş Kalıntı \"(RelicConfig.Arg2)\" elde et, ancak \"(Skill.Arg1)\" geliştir."
  },
  Event_7486_ChoiceDesc2 = {
    Text = "[Give Up] Gümüş Kalıntı \"(RelicConfig.Arg2)\" elde et, ancak \"(Skill.Arg1)\" geliştir."
  },
  Event_7486_ChoiceDesc3 = {
    Text = "[Be Wary] 25 Kara Mühür al"
  },
  Event_7486_Desc = {
    Text = "Zihnin pislikle dolup taşıyor, belirgin bir yozlaşma hissiyle.\nBulanık, pis kokulu sıvı içeri sızıyor ve düşüncelerini bütünüyle ele geçiriyor. Korkuyla kasılmış yüzüne yayılan acı, seni Kâbusların Döngüsü’nde sonsuzca hapsediyor; kurtulmaya güç yetiremiyorsun."
  },
  Event_7486_Name = {
    Text = "Kafatası Yarası"
  },
  Event_7487_ChoiceDesc1 = {
    Text = "[It's the Memphis Ritual Mirror]"
  },
  Event_7487_ChoiceDesc2 = {
    Text = "[It's a True North Compass]"
  },
  Event_7487_ChoiceDesc3 = {
    Text = "[I Haven't Dropped Anything]"
  },
  Event_7487_Desc = {
    Text = "\"Ey Boyut Aşımının Öncüsü.\"\n\nKulaklarında, sanki tarih öncesinden kopup gelen, çağları aşan bir Kadim Ses yankılanır.\n\nAşırı bir gerilim içinde, sesin sana tuhaf biçimde tanıdık gelen bir Soru sorduğunu işitirsin.\n\n\"Tur başında kart çekmeni sağlayan, düşürdüğün şu tur nesnesi nedir?\""
  },
  Event_7487_Name = {
    Text = "Ötelerden Gelen Sesler"
  },
  Event_7488_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7488_Desc = {
    Text = "\"Burası hurdalık değil,\" diye homurdanır Bebek, onu kabul ederken, \"ama peki, hâlâ işe yarar bir şeyler çıkarabilirim.\""
  },
  Event_7488_Name = {
    Text = "İsim Plakası"
  },
  Event_7489_ChoiceDesc1 = {
    Text = "Rastgele Sıradan Yakarış"
  },
  Event_7490_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7490_Desc = {
    Text = "\nYıpranmış, lime lime olmuş kâğıdı okursun: \"İkizler\", \"Islat\", \"Kurban\", \"Etkisiz\"...\nParçalanmış kavramların ve esrarengiz bir düzyazının karmakarışık yığını; bu kâğıt parçasını okuduğuna tanıklık eden tek şey zonklayan beynindir."
  },
  Event_7490_Name = {
    Text = "Şifreli Emir·Bölüm II"
  },
  Event_7491_ChoiceDesc1 = {
    Text = "[What Price Are You Willing to Pay?] Rastgele bir kartın Yakarış niteliğini güçlendir."
  },
  Event_7491_ChoiceDesc2 = {
    Text = "[Onlara Son Kullanma Tarihi Geçmiş Bir Bloody Mary Ismarla] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte et"
  },
  Event_7491_Desc = {
    Text = "\"Hoş Geldin, kıymetli konuğum. Çekinmeden seç; bu göz kamaştırıcı çeşitliliğin hepsi seni beklemek için var.\"\n\"Şey, rahatsız ettim kusura bakmayın, sorabilir miyim... Siz Leydi Nergis'in ikiz kız kardeşi misiniz?\"\n\"Ben bizzat Leydi Nergis'im. Sorabilir miyim, bugün sizi buraya getiren nedir...?\"\n\"Affedersiniz, affedersiniz, eskisinden bile daha büyüleyici olmuşsunuz. Sizi tanıyamadım. Hatırlıyor musunuz? Yirmi yıl önce, barımdan bir ucubeyi kovmuştunuz... Dün, o karabasan geri döndü. Barı ele geçirdi, yanında da sayısız türdeşini getirdi...\"\""
  },
  Event_7491_Name = {
    Text = "Anı Parçası: Eski Rüyanın Yeniden Belirişi"
  },
  Event_7492_ChoiceDesc1 = {
    Text = "[Chase the Crows] 30 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_7492_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Ayrıl"
  },
  Event_7492_Desc = {
    Text = "İkinci karga uzaklaştı; kuyruk Kanatları, kemikleri andıran beyaz bir izi açığa vuruyordu."
  },
  Event_7492_Name = {
    Text = "Kuzgun Bakışı"
  },
  Event_7493_ChoiceDesc1 = {
    Text = "[Take a Gamble] [(Skill.Arg1)] geliştir ve talihini yokla"
  },
  Event_7493_ChoiceDesc2 = {
    Text = "[Forget It] 25 Kara Mühür elde et"
  },
  Event_7493_Desc = {
    Text = "\n\"Şansını denemek ister misin? Sayılarımızı tahmin et! Sadece küçük bir bedel karşılığında!\"\nBir kenara atılmış zarlar, sanki seninle konuşuyormuş gibi gürültüyle vızıldar.\n\"At beni! At beni!\"\n\"Tek olan! Son olan!\"\nPekâlâ, sadece bir tane...\nBir jeton alırsın. Karar verirsin..."
  },
  Event_7493_Name = {
    Text = "Eternal Gamble"
  },
  Event_7494_ChoiceDesc1 = {
    Text = "[Resist Malice] Gümüş Kalıntı \"(RelicConfig.Arg1)\" elde et, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7494_ChoiceDesc2 = {
    Text = "[Embrace Malice] Gümüş Kalıntı \"(RelicConfig.Arg1)\" elde et, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7494_ChoiceDesc3 = {
    Text = "[Clear-Minded Departure] 25 Kara Mühür al"
  },
  Event_7494_Desc = {
    Text = "Kötü düşünceler bıçaklara, yahut keskin dişlere dönüşür.\nGizli Diyar’daki zayıflayan sağduyuyu kemirir, geriye kalan iradeyi yutarlar; tıpkı gerçekliğin sana acımasızlığını tattırdığı gibi..."
  },
  Event_7494_Name = {
    Text = "Unbidden Thought"
  },
  Event_7495_ChoiceDesc1 = {
    Text = "[Struggle Fully] Bir Komut Kartı İmha Et ve Arg1 Kara Mühür kazan."
  },
  Event_7495_ChoiceDesc2 = {
    Text = "[Light the Web] Bir Komut Kartını kopyala, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7495_ChoiceDesc3 = {
    Text = "[Wait Quietly] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7495_Desc = {
    Text = "Örümcek ağlarını andıran ince iplikler seni sarmalıyor; bu anda, açıkça Gizli Diyar’ın avına dönüşmüş durumdasın."
  },
  Event_7495_Name = {
    Text = "Saplanmış"
  },
  Event_7496_ChoiceDesc1 = {
    Text = "[Recipient: ∞] [(Skill.Arg1)] Semptomunu Geliştir"
  },
  Event_7496_ChoiceDesc2 = {
    Text = "[Recipient: Self] Bir Kartı İmha Et"
  },
  Event_7496_ChoiceDesc3 = {
    Text = "[Recipient: Teacher] 25 Kara Mühür al"
  },
  Event_7496_Desc = {
    Text = "Gizli Diyar Yürüyenine bir fırsat sundu: Bilinmeyen Yaratık ile bağ kurma fırsatı.\nBirkaç yırtık pırtık kâğıt, mürekkep saçan bir Daktilo ve Bilinmeyen Yaratık, Tek Yön bir alıcı.\nBelki de irade, mesajının nereye iletileceğini belirleyebilir."
  },
  Event_7496_Name = {
    Text = "İç Monolog"
  },
  Event_7497_ChoiceDesc1 = {Text = "[Accept]"},
  Event_7497_ChoiceDesc2 = {Text = "[Reject]"},
  Event_7497_Desc = {
    Text = "Fısıltılar boşlukta yankılanır.\n\"Şu sürekli 'kazan ya da öl' diye söylenen aptal var ya, o meşhur kumarbaz. Ondan uzak dursan iyi edersin.\"\nİnce, kambur bir siluet sana birkaç madeni para fırlatır; metalik şakırtı avucunda son bulur.\n\"Haydi, bir el oynayalım.\""
  },
  Event_7497_Name = {
    Text = "Notorious Gambler"
  },
  Event_7498_ChoiceDesc1 = {
    Text = "[Hepimiz İyiyiz] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_7498_ChoiceDesc2 = {
    Text = "[Sen Kimsin?] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_7498_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7498_Desc = {
    Text = "Daktilo aniden mürekkep fışkırtır, göz tırmalayan sayıda ünlem işaretiyle.\n\"Bebek, iyi misin??? Neden Koruyucu da ortadan kaybolmuşken sen de yok oldun??? Lütfen, eğer güvendeysen bir mesaj yolla!!! William'ın saçları daha fazla beklersek dökülecek!!!\""
  },
  Event_7498_Name = {
    Text = "Acil Mektup"
  },
  Event_7499_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7499_Desc = {
    Text = "Alçının son parçasını da yapıştırırsın. O, keskin bir kahkaha patlatır; siyah sis yukarı doğru Sarmalamak’ta, süzülen silueti gözlerinin önünden silinir."
  },
  Event_7499_Name = {
    Text = "Flesh Reforged"
  },
  Event_7500_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7500_Desc = {
    Text = "Gümüş Anahtar’ı çıkarıyor, onu hüzün ve hürmetle kavrıyorsun. Soluk, sisimsi bir parıltı seni sarıyor.\nSessizlikte yalnızca bir iç çekiş yankılanıyor."
  },
  Event_7500_Name = {
    Text = "Gözcünün Bakışı"
  },
  Event_7501_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7501_Desc = {
    Text = "Üzerinde gezinen bakışlar seni izlemeyi sürdürüyor; derinin altındaki hücreler çığlık atıp kaçışıyor, damarların kurtlar gibi kıvranıyor.\nUzuvlarının grotesk hâlinin ortasında, kabarıp patlayan bir güç akışını hissediyorsun."
  },
  Event_7501_Name = {
    Text = "Gözcünün Bakışı"
  },
  Event_7502_ChoiceDesc1 = {
    Text = "[Avoid Gaze] Rastgele bir Uyandırıcıyı Uyanışa Çağır"
  },
  Event_7502_ChoiceDesc2 = {
    Text = "[Stare] Uyanışa geçirecek bir Uyandırıcı seç, o Kartın Arithmetica Maliyetini 2 azalt, ancak [(Skill.Arg1)]yi geliştir."
  },
  Event_7502_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_7502_Desc = {
    Text = "Boyutsal tüneller sayısız evreni birbirine bağlar; yüce Geçit’ten sinsice geçerken sayısız göz sana dikilir."
  },
  Event_7502_Name = {
    Text = "İlahi Bakış"
  },
  Event_7503_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7503_Desc = {
    Text = "Kaos, tam bir kaos.\nTüm düşünceler bir anda süpürülür, zihnin seliyle sürüklenir.\nBeynin derinliklerinde yalnızca sonsuz Şaşkınlık ve acı kalır, birlikte dibe çökerler."
  },
  Event_7503_Name = {
    Text = "İlham Patlaması"
  },
  Event_7504_ChoiceDesc1 = {Text = "[Take It]"},
  Event_7504_Desc = {
    Text = "Aşırı doygun D-balçığın içinde bir şey var gibi görünüyor... Gümüş Anahtar’ı kullanarak onu kendi Gücüne dönüştür."
  },
  Event_7504_Name = {
    Text = "Çökelti Noktası"
  },
  Event_7505_ChoiceDesc1 = {
    Text = "[Chase the Crows] 35 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_7505_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Ayrıl"
  },
  Event_7505_Desc = {
    Text = "Bir karga uçup gitti, geride süzülerek inen tek bir siyah tüy bıraktı."
  },
  Event_7505_Name = {
    Text = "Kuzgun Bakışı"
  },
  Event_7506_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7506_Desc = {
    Text = "Burası Uçurum Savaş Alanı; burada savaş hem cesaret hem de bilgelik ister.\n\nGözlerini bile, zihnini bile bileyip rakiplerini gözlemle. Hepsini yenmene gerek yok; sadece liderlerini devirmelisin!"
  },
  Event_7506_Name = {
    Text = "Şeytani Sınav"
  },
  Event_7507_ChoiceDesc1 = {
    Text = "[Connect] Arg2 HP Yenile."
  },
  Event_7507_Desc = {
    Text = "Sis ağır ağır yapışırken, rozetin solgun bir gümüş titreşimle yanıp sönüyor. İletişimci cızırtıyla hayata dönüyor. Biri arıyor."
  },
  Event_7507_Name = {Text = "Kavşak"},
  Event_7508_ChoiceDesc1 = {Text = "[Tail Him]"},
  Event_7508_ChoiceDesc2 = {
    Text = "[Greet Them]"
  },
  Event_7508_Desc = {
    Text = "Tak. Tak. Tak.\nBeyaz bir siluet, kalın sisin içinde yavaşça ilerliyor; sanki sessiz bir geceye açılan bir gemi.\nArkadan bakıldığında bir oğlan çocuğunu andırıyor.\nYorgun ayak seslerini dinlerken, kalbinin derinliklerinde bir karar veriyorsun."
  },
  Event_7508_Name = {
    Text = "Son Perde I"
  },
  Event_7509_ChoiceDesc1 = {
    Text = "[Hesitantly Agree]"
  },
  Event_7509_ChoiceDesc2 = {
    Text = "[Express Caution]"
  },
  Event_7509_Desc = {
    Text = "Çözündürülmüş düşerken bir çığlık koparıyor ve arkasında Clementine’in durduğunu görünce şaşırıyorsun.\n \"Veda etmeye geldim,\" diyor. \"Teşekkürümün bir nişanesi olarak sana bazı ipuçları verebilirim. Ne var ki... bunun için bana güvenmen gerek.\nİzin ver seni hipnotize edeyim, bildiğim her şeyi seninle paylaşacağım.\"\nOna güvenebilir misin?\n \"Dikkatli ol,\" diye uyarmıştı Ramona, \"Kesinlikle gizli bir amacı var.\""
  },
  Event_7509_Name = {
    Text = "Hipnoterapi"
  },
  Event_7510_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7510_Desc = {
    Text = "Dikkatini toplarsın ve düş, suya karışan mürekkep gibi dağılır. İleriye doğru yürürsün, ama kalbindeki gölge yerinden kıpırdamaz."
  },
  Event_7510_Name = {Text = "İllüzyon"},
  Event_7511_ChoiceDesc1 = {
    Text = "[Pitiful Creature?]"
  },
  Event_7511_ChoiceDesc2 = {
    Text = "[Evolved Human?]"
  },
  Event_7511_ChoiceDesc3 = {
    Text = "[Who are you?]"
  },
  Event_7511_Desc = {
    Text = "Altıncı kez karşılaştığın adam, çelik iskeletin tepesinde duruyor, diyara tepeden bakıyordu. Şiddetli rüzgâr uzun saçlarını geriye savurup gerçek hâlini, bir yılanı, ortaya çıkarıyordu.\nBakışlarını sana dikti, sonra uzaklardaki Karanlık’a çevirdi.\n\"Ah, ne zavallı bir yaratık o.\nİhanet duygusu, <Bold:evrimleşmiş> bir insanın tattığı haz kadar tatlı olmalı.\""
  },
  Event_7511_Name = {
    Text = "Garip Yol Arkadaşı VI"
  },
  Event_7512_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7512_Desc = {
    Text = "Bir cehennem köpeğinin bakışı altında, kim bir film rulosuna dikkat eder ki?"
  },
  Event_7512_Name = {
    Text = "Mnemonic Phantoms"
  },
  Event_7513_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7513_Desc = {
    Text = "Bakma, konuşma, dinleme, hatta düşünme bile— bilgenin seçimi budur."
  },
  Event_7513_Name = {
    Text = "Rün Çılgınlığı"
  },
  Event_7514_ChoiceDesc1 = {
    Text = "[Leave] Herhangi 2 Kartı İmha Et"
  },
  Event_7514_Desc = {
    Text = "Gürültü kakofonisi içinde, zar zor da olsa, bir böceğin kanat çırpışını andıran tuhaf bir vızıltı seçebiliyorsun. Gümüş Anahtar göğsünde şiddetle titreşiyor; görünmez bir kuvvetin etkisiyle başını kaldırıyor ve gökyüzünde beliren kocaman, kara bir yarık görüyorsun.\n \"Ne yazık, elbette, ama sorun değil. Yeniden Karşılaşacağız, benim muhterem Göz Bebeği’siz Göz’üm.\""
  },
  Event_7514_Name = {
    Text = "Hipnoterapi"
  },
  Event_7515_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7515_Desc = {
    Text = "Etrafındaki her şeyi görmezden gelebilirsin, ama kalbinin atışını asla. Ritmini hızlandırıyor; seni hem dürtüyor hem de azarlıyor."
  },
  Event_7515_Name = {
    Text = "Sol Kulakçık"
  },
  Event_7516_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7516_Desc = {
    Text = "\"Harika!!! William'ın saçları artık güvende!!\"\nTelgrafın metni kısa, ama kelimeler sayfadan fırlayacakmış gibi titreşiyor."
  },
  Event_7516_Name = {
    Text = "Acil Mektup"
  },
  Event_7517_ChoiceDesc1 = {
    Text = "[Tell Him the Truth] Rastgele bir Uyandırıcıyı Uyanışa geçir, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7517_ChoiceDesc2 = {
    Text = "[Conceal the Truth] 3 Yakarıştan 1’ini Oyarak Yaz"
  },
  Event_7517_Desc = {
    Text = "\"Lütfen beni kurtar.\"\nMelankolik yolcu elini kavradı. Yüzlerce yıldır burada dolaşıp duruyordu.\n\"Ben bir askerim, sapkınlara karşı savaşmak için uzak doğuya gitmekle görevlendirildim.\nSık ormanları aştım, nehirleri yara yara geçtim, ama yolumu kaybettim, tekrar tekrar aynı yere döndüm.\nBir şey beni karanlıktan izliyor. Onu göremiyorum, ama biliyorum. Hep beni izledi.\nArtık tek istediğim eve gitmek...\"\nArkasındaki süzülen gölgelere bakıyorsun. Önce bulanıktılar, sonra yavaş yavaş netleştiler—yüz yıldır saklanan kayıp ruhları açlıkla bekleyen, kocaman, ardına kadar açılmış bir ağızdı."
  },
  Event_7517_Name = {Text = "Yutucu"},
  Event_7518_ChoiceDesc1 = {
    Text = "[Into the Darkness]"
  },
  Event_7518_ChoiceDesc2 = {Text = "[Farewell]"},
  Event_7518_Desc = {
    Text = "\"Celeste, bu sefer bana yardım edeceksin, değil mi?\"\nKız, sinirle bir o yana bir bu yana yürürken, ara sıra sessiz Uyanışçı’ya geri dönüp bakıyordu.\nKıza karşılık vermedi; fakat kızın İfadesi giderek daha da kaygılı hale geldikçe, bir esinti beyaz duvağı kaldırdı ve onu nazikçe belli bir yöne doğru itti.\n\"Seni koruyacağım.\"\nSeni koruyacağım; her ne kadar bir zamanlar bu \"koruma\" meselesinde başarısız olmuş olsam da.\nAma bu kez, karanlıkta tek başına kaybolmana izin vermeyeceğim."
  },
  Event_7518_Name = {
    Text = "Kutsal Bakire'nin Nöbeti"
  },
  Event_7519_ChoiceDesc1 = {
    Text = "[Leave] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7519_Desc = {
    Text = "Bazı şarkılar kadimdir, tufan yayılmadan çok önce yitip gitmiştir; bazılarıysa tazedir, geçen yılbaşı hakkındadır—bir kadının Londinium Büyük Mağazası’ndan yeni eldivenler alışını anlatır... Duyguların kaotik üst üste binmesinden sonra, geriye kalpte yalnızca koca bir boşluk kalır."
  },
  Event_7519_Name = {
    Text = "Denizci Türküsü"
  },
  Event_7520_ChoiceDesc1 = {
    Text = "[Expel Colors] \"(RelicConfig.Arg1)\" Altın Kalıntıyı edin, ancak \"(Skill.Arg2)\" becerisini geliştir"
  },
  Event_7520_ChoiceDesc2 = {
    Text = "[Embrace Colors] 3 Altın Kalıntı arasından 1 tane edin, ancak [(Skill.Arg1)] Semptomunu geliştir"
  },
  Event_7520_ChoiceDesc3 = {
    Text = "[Turn and Leave] [(RelicConfig.Arg1)] Gümüş Kalıntıyı edin"
  },
  Event_7520_Desc = {
    Text = "Murphy yakından takip etti ama bir köşede donakaldı.\nAkan gökkuşağı renkleri girdap gibi dönüyor, havayı iç çektiriyordu.\n\"Mur@1...\"\nBu, Sona-Nyl’de sıkışıp kalmış boğulmuş bir Ölü Ruh’un hayaleti mi? Yoksa yaşayanların peşine düşmüş, göçüp gitmiş bir sevgili mi?"
  },
  Event_7520_Name = {
    Text = "Özlemin Rengi"
  },
  Event_7521_ChoiceDesc1 = {
    Text = "[Keep Searching] Azami CP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_7521_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7521_Desc = {
    Text = "Tanıdık bir ses kulağıma fısıldadı; sıcak ve teselli vericiydi. Ama peşine düşmeye çalıştığımda, ses aniden kesildi."
  },
  Event_7521_Name = {
    Text = "Anormal Temas"
  },
  Event_7522_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7522_Desc = {
    Text = "\"Bu, küfre varan bir ezgiydi.\"\nKulaklarını kapatır, akan kanı hisseder ve bunu kesin bir dille onaylarsın."
  },
  Event_7522_Name = {
    Text = "Yasak Tını"
  },
  Event_7523_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7523_Desc = {
    Text = "Renkler belirsizce iki insanı andıran şekillere bürünüyor, fakat o köşede hareketsiz kalıyor, bakışlarıyla sana son lütuflarını sunuyorlar."
  },
  Event_7523_Name = {
    Text = "Özlemin Rengi"
  },
  Event_7524_ChoiceDesc1 = {
    Text = "[Listen] 3 Altın Kalıntıdan 1’ini Edin"
  },
  Event_7524_Desc = {
    Text = "Nergis'in sesi bir an duraksadı.\n\"Ah, bunu mu seçtin? Güzel bir seçim. Ödül olarak sana özel bir hediye vereceğim.\""
  },
  Event_7524_Name = {
    Text = "İpucu Süresi"
  },
  Event_7525_ChoiceDesc1 = {
    Text = "[Keep Asking] [(Skill.Arg1)] Semptomunu Geliştir"
  },
  Event_7525_ChoiceDesc2 = {
    Text = "[Abandon Inquiry] Bir Kartı İmha Et"
  },
  Event_7525_Desc = {
    Text = "\"Hımm, akıllıca bir seçim. Böylesine azametli bir düşmanla yüzleşirken, elbette hem kendini hem de düşmanını tanımak istersin, değil mi? Ne var ki, boyutlar hakkında fazla sır bilmek zihnini bulandırabilir, biliyorsun?\""
  },
  Event_7525_Name = {
    Text = "İpucu Süresi"
  },
  Event_7526_ChoiceDesc1 = {
    Text = "[Persistent Inquiry] Nergis'i Çıldırt ve savaşa gir."
  },
  Event_7526_ChoiceDesc2 = {
    Text = "[Give up asking] Küçük bir ceza al."
  },
  Event_7526_Desc = {
    Text = "\"Oh? Şu anda bile hâlâ beni İz Düzeni’ne almayı mı düşünüyorsun? Küçük olan, fazla açgözlü olmak iyi değildir, bilirsin.\""
  },
  Event_7526_Name = {
    Text = "İpucu Süresi"
  },
  Event_7527_ChoiceDesc1 = {
    Text = "[Focus] Azami CP’yi Arg1 kadar Artır"
  },
  Event_7527_ChoiceDesc2 = {
    Text = "[Yok Say] Rastgele 2 Komut Kartı Mühür kazan: \"(EnchantConfig.Arg1)\", 2 \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_7527_Desc = {
    Text = "Küçük kasabanın sokaklarında Cehennem Köpeği’nin peşine düşersin.\nGökyüzünden soğuk kar taneleri inmeye başlar; usulca yanaklarına ve göğsüne konarak çalkantılı kalbini yatıştırır."
  },
  Event_7527_Name = {Text = "Kar"},
  Event_7528_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7528_Desc = {
    Text = "Kollarınızı sallayarak bu sinir bozucu kargaları kovmaya çalışırsınız.\nAlaycı bir şekilde gaklarlar, sanki aptallığınıza ve zayıflığınıza gülüyorlardır.\nYine de cesaretiniz onları etkiler ve buna uygun bir ödül alırsınız."
  },
  Event_7528_Name = {
    Text = "Song of Crows"
  },
  Event_7529_ChoiceDesc1 = {
    Text = "[About Lily] Gümüş Kalıntı [(RelicConfig.Arg1)]yı elde et"
  },
  Event_7529_ChoiceDesc2 = {
    Text = "[About Hellhound] Altın Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" becerisini geliştir"
  },
  Event_7529_Desc = {
    Text = "\nSonsuz kapıyı aş, uzak ve erişilmez bir yerden Nergis’in sesi ulaşır.\n\"Bu, Nergis’in ipucu süresi.\""
  },
  Event_7529_Name = {
    Text = "İpucu Süresi"
  },
  Event_7530_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7530_Desc = {
    Text = "Direncini koruyorsun, kendine sadık kalarak ilahi mırıldanıyorsun.\nKulaklarındaki fısıltılara güvenmiyor, yalnızca insan aklına dayanıyorsun.\nNe var ki... Güvendiğin sağlam zemin koyu siyah bir pislikle yutulduğunda, gözlerini oyup Gözlem için birer araç olarak kullanmak, son anlarında sahip olacağın tek Seçim olacak."
  },
  Event_7530_Name = {
    Text = "Song of Crows"
  },
  Event_7531_ChoiceDesc1 = {
    Text = "[Stare Down the Hellhound Source] Altın Kalıntı \"(RelicConfig.Arg1)\" elde et, ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_7531_ChoiceDesc2 = {
    Text = "[Focus on Battle] 3 Komut Kartından 1'ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7531_Desc = {
    Text = "Cehennem Köpeği’nin silueti kıpırdanır.\nBedeni, duvarlardaki çatlakları birbirine bağlayarak tekinsiz Düşleri açığa çıkarır."
  },
  Event_7531_Name = {
    Text = "From Perspective"
  },
  Event_7532_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7532_Desc = {
    Text = "“Miyav, miyav miyav, miyav miyav miyav...”\nSesini zorluyor, kendini zayıf ve zararsız göstermeye çalışıyordun.\n“Miyav! Miyav miyav! Miyav miyav miyav!”\nKedi sürüsü, iyi niyetini kabul etmişe benziyordu; neşeli miyavlamalarla karşılık verdiler. Çığlıkların gece gündüz durmaksızın yankılandı, ayı bile korkutup bulutların ardına saklanmaya zorladı."
  },
  Event_7532_Name = {
    Text = "Kediler Şehri"
  },
  Event_7533_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7533_Desc = {
    Text = "Sadece, dinlenebileceği bir tahta parçası arayan çırpınan bir yaratık...\nKelebek kuyruğundan damlayan siyah sıvı yanağına düşerken içini çekersin."
  },
  Event_7533_Name = {
    Text = "Obsidyen Kelebek"
  },
  Event_7534_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7534_Desc = {
    Text = "Kedi grubundan uzaklaşmak için son zerre gücünü kullandın.\nGeriye baktığında, kediler çoktan günlük hâllerine dönmüştü: tüylerini yalıyor, kestiriyor, hatta birbirleriyle kavga ediyorlardı...\nDoğrusunu söylemek gerekirse, insanları umursamıyorlar."
  },
  Event_7534_Name = {
    Text = "Kediler Şehri"
  },
  Event_7535_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7535_Desc = {
    Text = "Kalan et parçalarını kedi sürüsünün içine fırlatıyorsun.\nKediler kara gelgit gibi ileri atılıyor, çılgınca eti parçalayıp ardından hızla dağılıyorlar.\nNe yazık ki et bozulmuş. Boş midelerini dolduruyor ama onlara pek az tatmin sunuyor."
  },
  Event_7535_Name = {
    Text = "Kediler Şehri"
  },
  Event_7536_ChoiceDesc1 = {
    Text = "[Eye Contact] Altın Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7536_ChoiceDesc2 = {
    Text = "[Stop Resisting] Rastgele 2 Uyandırıcıyı Uyanış’a çağır, ancak [(Skill.Arg1)] becerisini iki kez geliştir."
  },
  Event_7536_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_7536_Desc = {
    Text = "Sayısız göz kulağının etrafında fısıldar.\n\"Yürür, durur, on binlerce yıl ve daha fazlası boyunca adımlarız.\nGüneş, gözlerimizin gözetimi altında solarken, kadim Dünya'daki yaşam seller tarafından yutulurken.\nBiz çoktan evrenin gizemlerine kapıldık.\""
  },
  Event_7536_Name = {Text = "Göz"},
  Event_7537_ChoiceDesc1 = {
    Text = "[Feel Panic] Rastgele bir Uyandırıcıyı Uyanışa Çağır"
  },
  Event_7537_ChoiceDesc2 = {
    Text = "[Feel Content] Uyanışa geçirecek bir Uyandırıcı seç, o Kartın Arithmetica Maliyetini 2 azalt, ancak [(Skill.Arg1)]yi geliştir."
  },
  Event_7537_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_7537_Desc = {
    Text = "Ayın ve Yıldızlar'ın olmadığı bir gökyüzü gördün; yukarıda, sayısız büyümüş Göz Bebeği asılıydı.\nElini uzatsan onları koparıp aşağı indirecekmişsin gibi gelir, et ve Kan etrafa sıçrardı.\nAma elini açtığında, orada hiçbir şey yoktur.\nKaderin gözleri, kaotik evrende parıldayan bir kum tanesi bulmuş gibi, gözlerini kırpmadan seni izler."
  },
  Event_7537_Name = {
    Text = "Kubbenin Gözü"
  },
  Event_7538_ChoiceDesc1 = {
    Text = "[Lower Hands] [(RelicConfig.Arg1)] adlı Gümüş Kalıntıyı elde et."
  },
  Event_7538_ChoiceDesc2 = {
    Text = "[Keep Covering Ears] 75 Kara Mühür kazan, ancak [(Skill.Arg2)] Semptomunu geliştir"
  },
  Event_7538_Desc = {
    Text = "Tırmalayan, bitmek bilmeyen bir çığlık—\nParlak siyah Kanatlara bürünmüş Kuzgun Şarkıcısı, soğuk soğuk parlayan keskin gagasıyla, attığı her yaslı çığlıkta kulak zarlarını deler.\nEllerini kulaklarından çek!\nGecenin kargalardan oluşan korosu, tir tir titreyen bedenindeki ham sarsıntılara açlıkla susamış."
  },
  Event_7538_Name = {
    Text = "Karga Sürüsünün Şarkısı"
  },
  Event_7539_ChoiceDesc1 = {
    Text = "[Imitate Cat's Call] 50 Kara Mühür al"
  },
  Event_7539_ChoiceDesc2 = {
    Text = "[Feed] 75 Kara Mühür kazan, ancak [(Skill.Arg2)] Semptomunu geliştir"
  },
  Event_7539_Desc = {
    Text = "Yanlışlıkla kara kedinin bölgesine girdin.\nKaranlıkta sayısız göz açıldı; merak, tetkik ve Alarm doluydular... ama zerre kadar merhamet yoktu.\nZümrüt yeşili, kehribar sarısı, tavuskuşu mavisi...\nSanki pırıl pırıl mücevherlerden oluşan bir denize nüfuz etmişsin gibi hissettin.\nKaçmak için, sen—"
  },
  Event_7539_Name = {
    Text = "Kediler Şehri"
  },
  Event_7540_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7540_Desc = {
    Text = "Sıradışı bir el fark edersin. İnce, beyaz ve baştan sona sakindir.\nDaha da önemlisi—onun sana ait olduğunu tanırsın.\nTereddüt etmeden, onu acımasızca koparırsın.\nSayısız tiz çığlık yankılanır ve bataklık nihayet yok olur."
  },
  Event_7540_Name = {
    Text = "Kasvet Bataklığı"
  },
  Event_7541_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7541_Desc = {
    Text = "\"“Bilgece bir karar,” diyor eli boş siluet. “Önceden yazılmış seçimler, önceden belirlenmiş sonuçlara götürür; öngörülemez eylemler ise yeni geleceklerin yolunu açar.”\nİnce bir umut duygusu usulca seni sarıyor. Siluetler yok oluyor; göğsünü tutmuş halde kalıyorsun, bunun bir yansıtma mı yoksa zihinsel stresin doğurduğu bir fantazma mı olduğundan emin olamıyorsun.\""
  },
  Event_7541_Name = {
    Text = "Çatallanan Patikalar"
  },
  Event_7542_ChoiceDesc1 = {
    Text = "[Praise It] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7542_ChoiceDesc2 = {
    Text = "[Taunt It] [(Skill.Arg1)] Semptomunu geliştir ve kazınacak Yakarışı değiştir.(Kullanım: 2/2)"
  },
  Event_7542_Desc = {
    Text = "Zihin der ki: Zincirler ön beynimi, beyin sapımı, serebral korteksimi bağlıyor, ama gerçeğin peşine düşmüş 10 milyardan fazla ufacık hücreyi bağlayamıyor.\nSen dersin ki: Seni buraya kim hapsetti? Peki ya bedenin?\nZihin der ki: Beden mi? Şaka etme! Eskiden bana “Domuzcu Yaşlı Johnny” derlerdi.\nBir bedenim varken, ondan küçük sayıları bile kavrayamazdım.\nAma küratör fazlalık etimi aldıktan sonra, bak neye dönüştüm! Bir fizikçi, bir filozof ve amatör bir şair."
  },
  Event_7542_Name = {
    Text = "Filozofun Beyni"
  },
  Event_7543_ChoiceDesc1 = {
    Text = "[Prove Goldbach's Conjecture] Gümüş Kalıntı [(RelicConfig.Arg1)]i elde et."
  },
  Event_7543_ChoiceDesc2 = {
    Text = "[Journey's End] Yadigâr [(EnchantConfig.Arg1)]i rastgele bir Komut Kartına kazı."
  },
  Event_7543_ChoiceDesc3 = {
    Text = "[Refuse to Ask] 50 Kara Mühür al"
  },
  Event_7543_Desc = {
    Text = "Ruh Tahtası’nı eline aldığında, Genç kadın sesi zihnine hücum etti.\n \"Bana her şeyi sor. Her şeyi biliyorum.\"\n \"Cevaplarımdan, kaderin armağanını alacaksın.\""
  },
  Event_7543_Name = {
    Text = "Spirit Board"
  },
  Event_7544_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7544_Desc = {
    Text = "Yırtık, paramparça kâğıdı okurken, bozuk cümleler dudaklarından dökülüyor. \"Atalar\", \"Divus\", \"Ebedî Ölüm\" ve \"Uzun Hafıza\" gibi sözcükler zihnini dolduruyor, karabasanlarla kemirilen zaten Kırılgan sinirlerini daha da galeyana getiriyor."
  },
  Event_7544_Name = {
    Text = "Şifreli Emir·Bölüm I"
  },
  Event_7545_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7545_Desc = {
    Text = "Siyah balçık yüzüne damlar, karıncalı bir kaşıntı bırakır.\nDayanamayarak kelebeğe doğru hamle yaparsın.\nKelebek, düşmanca hareketinden sıyrılır ve sessizce uzaklara karışır."
  },
  Event_7545_Name = {
    Text = "Obsidyen Kelebek"
  },
  Event_7546_ChoiceDesc1 = {
    Text = "[Leave] Projektör Ara"
  },
  Event_7546_ChoiceDesc2 = {
    Text = "[Break into Mist] Arg2 HP kaybet"
  },
  Event_7546_ChoiceDesc3 = {
    Text = "[Enter Directly]"
  },
  Event_7546_Desc = {
    Text = "İleride yoğun, siyah bir sis uzanıyor; düşüncesizce içine dalmak felaket getirir.\nBelki de sisi dağıtmak için bir \"Projektör\" bulmalısın."
  },
  Event_7546_Name = {Text = "???"},
  Event_7547_ChoiceDesc1 = {
    Text = "[Fantazmayı Kabul Et] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_7547_ChoiceDesc2 = {
    Text = "[Deny the Illusion] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7547_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7547_Desc = {
    Text = "Ağır, karanlık demir köprünün altında, sessiz, sazlarla kaplı nehir kıyısından birden parıltılı bir kelebek havalanıyor.\nKelebek usulca avucuna konuyor, dehşet verici ulumaları susturuyor. Onun yerine, çelik taşıyan işçilerin ritmik ilahilerini, çekiç darbelerinin gümlemesini ve perçinlerin berrak şakırtısını işitiyorsun..."
  },
  Event_7547_Name = {
    Text = "Çelik Köprü Serabı"
  },
  Event_7548_ChoiceDesc1 = {
    Text = "[Chase the Crows] 40 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_7548_ChoiceDesc2 = {
    Text = "[Keep Chasing the Child] 25 Kara Mühür al ve ayrıl."
  },
  Event_7548_Desc = {
    Text = "Avizede bir karga tünemişti.\nAvizede iki karga tünemişti.\nAvizede üç karga tünemişti.\n.....\nSiyah yaratıklar boyunlarını bükerek, ara sokağın avizesinden kötücül bakışlar fırlatıyordu. Gölgeye gömülü başları, D-balçık’a batmış tek bir bedeni paylaşıyor gibiydi."
  },
  Event_7548_Name = {
    Text = "Kuzgun Bakışı"
  },
  Event_7549_ChoiceDesc1 = {
    Text = "[Leave] 3’ten az Uyanışçı uyandığında bir Gümüş Kalıntı elde et [(RelicConfig.Arg1)]"
  },
  Event_7549_ChoiceDesc2 = {
    Text = "[Leave] En az 3 Uyanışçı uyandığında Altın Bir Hatıra Relik’i elde et [(RelicConfig.Arg1)]"
  },
  Event_7549_Desc = {
    Text = "İşareti görmezden gelip ileri adım atarsın.\n<Italic:Uyanmış Gnosis’in ağırlığı öylesine ağırdır ki>, adımlarınla birlikte işaret genişler ve bükülür; sanki her an o çatlaklardan bir el uzanıp seni derinliklere sürükleyebilirmiş gibi."
  },
  Event_7549_Name = {
    Text = "Sürünen Çatlak"
  },
  Event_7550_ChoiceDesc1 = {
    Text = "[Return the Gaze] Altın Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7550_ChoiceDesc2 = {
    Text = "[Avoid the gaze] Rastgele 2 Uyandırıcıyı Uyanış’a çağır, ancak [(Skill.Arg1)] becerisini iki kez geliştir."
  },
  Event_7550_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_7550_Desc = {
    Text = "Bir bakış hissediyorsun—Alan’ın bile ötesinde, aşkın bir bakış—seni ve karşındaki kızı izliyor.\nNefesin hızlanıyor, zihninin en derinlerinden ilkel bir korku çığlık atıyor."
  },
  Event_7550_Name = {
    Text = "Kimin Bakışı?"
  },
  Event_7551_ChoiceDesc1 = {
    Text = "[Keep Searching] Azami CP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_7551_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7551_Desc = {
    Text = "Solgun, sıcak bir ışık belirdi. Ancak peşine düşmeye yeltendiğin anda aniden yok oldu."
  },
  Event_7551_Name = {
    Text = "Anormal Temas"
  },
  Event_7552_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7552_Desc = {
    Text = "Onların ilahilerini usulca yankılayan sıcak akıntılar, sana yurdun lütuflarını getirir."
  },
  Event_7552_Name = {
    Text = "Denizci Türküsü"
  },
  Event_7553_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7553_Desc = {
    Text = "İleride solgun bir ışık fark edersin; sonunda boğucu sisi yarıp geçmişsindir."
  },
  Event_7553_Name = {Text = "Kaos Sisi"},
  Event_7554_ChoiceDesc1 = {
    Text = "[Unravel the Lower Branch]"
  },
  Event_7554_Desc = {
    Text = "Diyar’da kalan Gnosis birbirine bağlanır, dolaşarak kararsız bir kuvvet alanına dönüşür.\nBelki de Gnosis’i çözerek kendine ilerleyecek bir yol açabilirsin."
  },
  Event_7554_Name = {
    Text = "Dolanık Yol"
  },
  Event_7555_ChoiceDesc1 = {
    Text = "[Unravel the Upper Branch]"
  },
  Event_7555_Desc = {
    Text = "Diyar’da kalan Gnosis birbirine bağlanır, dolaşarak kararsız bir kuvvet alanına dönüşür.\nBelki de Gnosis’i çözerek kendine ilerleyecek bir yol açabilirsin."
  },
  Event_7555_Name = {
    Text = "Dolanık Yol"
  },
  Event_7556_ChoiceDesc1 = {
    Text = "[Unravel the Left Branch]"
  },
  Event_7556_Desc = {
    Text = "Diyar’da kalan Gnosis birbirine bağlanır, dolaşarak kararsız bir kuvvet alanına dönüşür.\nBelki de Gnosis’i çözerek kendine ilerleyecek bir yol açabilirsin."
  },
  Event_7556_Name = {
    Text = "Dolanık Yol"
  },
  Event_7557_ChoiceDesc1 = {
    Text = "[Unravel the Left Branch]"
  },
  Event_7557_Desc = {
    Text = "Diyar’da kalan Gnosis birbirine bağlanır, dolaşarak kararsız bir kuvvet alanına dönüşür.\nBelki de Gnosis’i çözerek kendine ilerleyecek bir yol açabilirsin."
  },
  Event_7557_Name = {
    Text = "Dolanık Yol"
  },
  Event_7558_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7558_Desc = {
    Text = "Önünde hâlâ birkaç çetin savaş var. Şimdi sakin bir soruşturma için uygun zaman değil."
  },
  Event_7558_Name = {
    Text = "Organ Kaydı"
  },
  Event_7559_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7559_Desc = {
    Text = "Kâğıttaki karakterler birden Tamamlandı ve canlı hâle geliyor; habersiz herhangi bir mazlumun inancını ve temelini sarsabilecek kadar dehşet verici sözcükler hâline dönüşüyor. Okudukça daha çok Şaşkınlık ve Dehşet içinde kalıyor, kendini durduramadan saç diplerini kaşıyorsun.\nBirden, o lanetli semboller yok oluyor. Ramona okumanı yarıda kesiyor ve sayfaları zorla bavula tıkıyor."
  },
  Event_7559_Name = {
    Text = "Şifreli Emir·Bölüm II"
  },
  Event_7560_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7560_Desc = {
    Text = "Sevinç, ağıt, keder, sıkıntı... Bunlar senin duyguların.\nSen ve farklı boyutlardaki sayısız sen."
  },
  Event_7560_Name = {Text = "İhtiras"},
  Event_7561_ChoiceDesc1 = {
    Text = "[Sessizce Dinle] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_7561_ChoiceDesc2 = {
    Text = "[Ona Burada] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_7561_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7561_Desc = {
    Text = "Çözülenlerin çığlıkları zihninde yankılanır. Karanlığın içinden silik ama Tanıdık Ses belirir, güçsüzce fısıldar:\n\"Sasha Abla,\" \"Sasha Abla...\"\n\"Sasha Abla, neredesin?\""
  },
  Event_7561_Name = {
    Text = "\"Sasha Abla\""
  },
  Event_7562_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7562_Desc = {
    Text = "\"O'na katıl, onlara katıl, bize katıl.\nO'nun Muhafızı ol, O'nun vekili ol.\nBırak O'nun Düşü yoluna rehberlik etsin...\"\nBu kaotik Saygı Duruşu zihnini altüst ediyor. Sesler dindikten sonra, kendini sırılsıklam ter içinde buluyorsun."
  },
  Event_7562_Name = {
    Text = "Rüya Duası"
  },
  Event_7563_ChoiceDesc1 = {
    Text = "[Never Heard of It]"
  },
  Event_7563_ChoiceDesc2 = {
    Text = "[I've heard of it]"
  },
  Event_7563_Desc = {
    Text = "『Affedersiniz, vaktinizden biraz çalabilir miyim?\nSize birkaç dakika boyunca yerel bir halk efsanesini tanıtmak istiyorum.\n'Kerberos' denen bir yaratığı duydunuz mu?』"
  },
  Event_7563_Name = {
    Text = "Garip Yol Arkadaşı I"
  },
  Event_7564_ChoiceDesc1 = {
    Text = "[Quit Thinking] Lanetli Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7564_ChoiceDesc2 = {
    Text = "[İlhamı Yakala] Rastgele 1 Komut Kartı Mühür kazanır: [(EnchantConfig.Arg1)]"
  },
  Event_7564_Desc = {
    Text = "Liman Saldırı altında, gizemli bir yük gemisi girip çıkıyor ve yüzgeçli 'yeni arkadaşlar' dolaşıyor... Bu ince ince hazırlanmış bir tuzak mı? Yoksa yine beklenmedik ölçüde tehlikeli bir yolculuk mu?\nGerçeklik ve akıl birbirini çekiştirip büküyor, zihinden sayısız İlham ve düşünce kabarıyor."
  },
  Event_7564_Name = {
    Text = "İlham Patlaması"
  },
  Event_7565_ChoiceDesc1 = {
    Text = "[Elworth's Volcano?] Maksimum HP’yi Arg1 kadar artır."
  },
  Event_7565_ChoiceDesc2 = {
    Text = "[Hatırlamaya Çalış] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_7565_Desc = {
    Text = "Lily’nin yanaklarından siyah gözyaşları süzülür. “Gördük, anne,” diye fısıldar usulca, “Elworth’un yanardağında...”"
  },
  Event_7565_Name = {
    Text = "Yanardağ Anısı"
  },
  Event_7566_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7566_Desc = {
    Text = "\"Deniz@1... ci...\"\nGözlerinin önünde rünler bir görünüp bir kaybolur; elini istemsizce boşluğa uzatır, onları yakalamaya çalışırsın—\n\"Ne yapıyorsun sen?! Yetişiyorlar!\"\nGizemli bir kız, seni güvertenin öbür ucuna doğru sürükler, rünlerle kurduğun bağı koparır.\nAma parmak uçlarında bir iz bırakan bir güç olduğu kesindir."
  },
  Event_7566_Name = {
    Text = "Rün Çılgınlığı"
  },
  Event_7567_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7567_Desc = {
    Text = "Bu mistik gevezeliklere zerre ilgin yok; karanlık geceye adım atıp Delilik riskine girmek de istemiyorsun."
  },
  Event_7567_Name = {
    Text = "Distress Letter"
  },
  Event_7568_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7568_Desc = {
    Text = "Her şeye rağmen, Koruyucu'nun görevi göğsünde kabarır. Göndereni bulma umudunu, ne kadar belirsiz ve muğlak olursa olsun, terk edemezsin."
  },
  Event_7568_Name = {
    Text = "Distress Letter"
  },
  Event_7569_ChoiceDesc1 = {
    Text = "[Observe It] %100 ihtimalle 25 Kara Mühür elde et"
  },
  Event_7569_ChoiceDesc2 = {
    Text = "[Pet It] %50 ihtimalle 50 Kara Mühür kazan, %50 ihtimalle hiçbir şey kazanma."
  },
  Event_7569_Desc = {
    Text = "Bir kara kedi aniden yandaki bir ara sokaktan fırlayıp çıktı, sevgiyle ayaklarına dolandı. Uğursuz yeşil dikey gözbebekleri, “Beni kovalama, gel biraz benimle oyna,” dercesine ürpertici bir ışıkla parladı.\n“Onu zaten gördün. O hemen yanında—delilikle kirlenmiş olanlar, kudurmuş gölgeler... Anahatlarına doğrudan bakma.”"
  },
  Event_7569_Name = {
    Text = "Gece Perisi"
  },
  Event_7570_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7570_Desc = {
    Text = "\"İmkânsız, inanılmaz!\" Ses çığlık attı, \"Beni bu iblise gönderen o kadın Sasha Abla DEĞİL!\""
  },
  Event_7570_Name = {
    Text = "\"Sasha Abla\""
  },
  Event_7571_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7571_Desc = {
    Text = "\"Alındı. Sade envanter teslimatına geçeceğiz. Lütfen kontrol edip onaylayın.\""
  },
  Event_7571_Name = {
    Text = "Destek İletişimi"
  },
  Event_7572_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7572_Desc = {
    Text = "Artık bir işe yaramıyor."
  },
  Event_7572_Name = {
    Text = "Kadim Miras"
  },
  Event_7573_ChoiceDesc1 = {
    Text = "[Look Closely] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_7573_ChoiceDesc2 = {
    Text = "[Afişi Kopar] Rastgele 1 Komut Kartı Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_7573_Desc = {
    Text = "Balmumu Müzesi’nde sıkça görülen bir şamdan.\nUğursuz turuncu parıltının ışığında, duvarda el çizimi bir afiş fark edersin."
  },
  Event_7573_Name = {
    Text = "Karanlıktaki Kahkaha"
  },
  Event_7574_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7574_Desc = {
    Text = "\"Lily’nin kendi kalbi var; kimseyi dinlemek zorunda değil.\" Sakin bir şekilde cevap veriyorsun.\nFrancis homurdanıyor, karşılık vermiyor."
  },
  Event_7574_Name = {
    Text = "Onun Seçimi"
  },
  Event_7575_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7575_Desc = {
    Text = "Bu bir grup fotoğrafı.\nÜzgün insanlar demir parmaklıkların ardında çömelmiş, yüzleri acıyla dolu.\nBir fotoğraf gözünü takılıyor. Zayıf bir genç kadın, yüzü bomboş.\nKutsal değerlere küfreden urumsu çıkıntılar bedenini sarmalamış.\nYüzünü göremiyorsun, ama ifadesiz olacağını hayal ediyorsun."
  },
  Event_7575_Name = {
    Text = "Birebir Kayıt"
  },
  Event_7576_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7576_Desc = {
    Text = "Sen bu parlak takılara büyülenmiş bir şekilde bakarken, farkında olmadan çökmüş siyah yapışkan elin tutmuşsun.\nO ise yalnızca eli biraz sıktı, sonra bıraktı.\nHiçbir şey olmadı; yalnızca ince bir kara sis, parmak uçlarından yürüyerek yenin içine kaydı."
  },
  Event_7576_Name = {
    Text = "Devirici Pençeler"
  },
  Event_7577_ChoiceDesc1 = {
    Text = "[Play a Few Notes] Gümüş Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_7577_ChoiceDesc2 = {
    Text = "[Close the Lid] 3 Yakarış’tan 1’ini Oyar"
  },
  Event_7577_Desc = {
    Text = "Duvarın yanındaki piyanonun kapağı açıktır. Tuşları sararmış, kenarları çatlamış, altındaki ahşabı açığa vurmuştur; ama her bir tuş özenle silinmiştir.\nNice kişi için bir sevinç kaynağıdır."
  },
  Event_7577_Name = {Text = "Ninni"},
  Event_7578_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7578_Desc = {
    Text = "Mızrak kuşanan inliyor, ezilmiş bir çocuk gibi hıçkırıyor.\nSes bir anda yok oluyor ve diğer iki Denizci de kayboluyor... Meğer hepsi, Gizli Diyar’ın yansıttığı bir Düş’ten ibaretmiş."
  },
  Event_7578_Name = {
    Text = "Relentless Hunt"
  },
  Event_7579_ChoiceDesc1 = {
    Text = "[Leave] [(RelicConfig.Arg1)] Gümüş Kalıntıyı edin"
  },
  Event_7579_Desc = {
    Text = "\"Doğru.\"\nSesin sahibi bu cevaptan çok memnun kaldı ve parlak bir nesne suyun içinden fırlatıldı.\n\"Unutma, her şeyin bir bedeli vardır.\""
  },
  Event_7579_Name = {
    Text = "Ötelerden Gelen Sesler"
  },
  Event_7580_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Rastgele bir Semptom geliştir."
  },
  Event_7580_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7580_Desc = {
    Text = "Bulanık yüzler aniden belirir; seni sarar ve var olmayan ses telleriyle umutsuzca inlerler."
  },
  Event_7580_Name = {Text = "İllüzyon"},
  Event_7581_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7581_Desc = {
    Text = "İzi görmezden gelip ileri adım atıyorsun.\nAma sanki öfkelenmiş gibi, attığın her adımda genişleyip bükülüyor; sanki o çatlağın içinden uzanacak bir el seni içeri sürükleyecekmiş gibi."
  },
  Event_7581_Name = {
    Text = "Sürünen Çatlak"
  },
  Event_7582_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7582_Desc = {
    Text = "Kandırılmadın. Kararlılıkla arkanı döndün ve uzaklaştın."
  },
  Event_7582_Name = {
    Text = "Sürünen Çatlak"
  },
  Event_7583_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7583_Desc = {
    Text = "Bu tuhaf çatlağı fark edip çömelerek incelemeye koyuluyorsun. Ne gariptir ki, az önce yayılmakta olan çatlak birden duruyor ve ebedi bir sessizliğe gömülüyor."
  },
  Event_7583_Name = {
    Text = "Sürünen Çatlak"
  },
  Event_7584_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7584_Desc = {
    Text = "Hayır, bu berrak bir zihin. Kararlılık, Çözündürülmüş Varlık’la başa çıkmana yaramaz, Koruyucu. Stratejini enine boyuna düşün."
  },
  Event_7584_Name = {
    Text = "Rogers Kuralı"
  },
  Event_7585_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7585_Desc = {
    Text = "İçindeki dürtüye karşı koyamıyorsun.\nParmakların, ormanda kaybolmuş çocuklar gibi klavyenin üzerinde gezinip oynuyor...\nYavaş yavaş, daktilodan kelebekler belirmeye başlıyor.\nBir, iki, üç...\nYüzünde, parmaklarında, kelebek sürüleri havai fişekler gibi parıldıyor, karanlıkta mücevherler gibi ışıldıyor.\nBu daktilonun pratik bir işlevi yok, ama güzellik yaratma konusunda tam bir usta."
  },
  Event_7585_Name = {Text = "Göz"},
  Event_7586_ChoiceDesc1 = {
    Text = "[Tie the Hen]"
  },
  Event_7586_Desc = {
    Text = "Çavdar Spesiyali: Kıpır kıpır tavuk, damak için bir ayartı!"
  },
  Event_7586_Name = {
    Text = "Tuzak Yapımı"
  },
  Event_7587_ChoiceDesc1 = {
    Text = "[Mission Accomplished]"
  },
  Event_7587_Desc = {
    Text = "Ucuz ama etkili tuzaklar!"
  },
  Event_7587_Name = {
    Text = "Tuzak Yapımı"
  },
  Event_7588_ChoiceDesc1 = {
    Text = "[Set up a Trap]"
  },
  Event_7588_Desc = {
    Text = "Metal bir hayvan kapanı, tembel avcının en iyi dostu."
  },
  Event_7588_Name = {
    Text = "Tuzak Yapımı"
  },
  Event_7589_ChoiceDesc1 = {
    Text = "[Check] \"(RelicConfig.Arg2)\" adlı Altın Kalıntıyı edin, fakat \"(Skill.Arg1)\"i geliştir."
  },
  Event_7589_ChoiceDesc2 = {
    Text = "[Disregard] 50 Kara Mühür al"
  },
  Event_7589_Desc = {
    Text = "Fırtınadan kaçmak için dar bir mağara yarığında saklanırsınız. Ama burada uzun süre kalamayacağınızı bilirsiniz—o siyah cüppeli figürler sizi bulursa, Kaçış Yoktur.\nYarığın bir köşesinde, beklenmedik şekilde bir telgraf makinesi keşfedersiniz."
  },
  Event_7589_Name = {
    Text = "Silent Telegram"
  },
  Event_7590_ChoiceDesc1 = {
    Text = "[Check the Film] 2 Rastgele kartın Yakarış niteliğini güçlendir."
  },
  Event_7590_ChoiceDesc2 = {
    Text = "[Check Camera] [(EnchantConfig.Arg1)] Yakarışını 3 Komut Kartından 1’ine kazı."
  },
  Event_7590_Desc = {
    Text = "Sanki iç organlardan bir parça sökülüyormuş gibi, kameranın içindeki film lime lime yırtıldı; içi boşaltılmış, kenara atılmış ve görmezden gelinmişti.\nKör edici bir beyaz parıltı, sokağın köşesine terk edilmiş kamerayı yana eğdi; deklanşörü görünmeyen bir güç tarafından çekildi.\n“Klik—”\nŞaşkın, donakalmış ifaden filmde sadakatle kaydedildi."
  },
  Event_7590_Name = {
    Text = "Masumiyeti Kaydet"
  },
  Event_7591_ChoiceDesc1 = {
    Text = "[Strangle the Singer] Lanetli Kalıntı \"(RelicConfig.Arg1)\"yı elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_7591_ChoiceDesc2 = {
    Text = "[Dansçının Adımlarını Sekteye Uğrat] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: [(EnchantConfig.Arg1)]"
  },
  Event_7591_ChoiceDesc3 = {
    Text = "[Steal the Poet's Manuscript] 50 Kara Mühür elde et."
  },
  Event_7591_Desc = {
    Text = "Üç yapışkan siluet tarafından yolun kesiliyor.\nBunlardan biri, boğuk bir sesle tekinsiz sözler mırıldanıyor. Kulaklarını kapatıp yanından geçiyorsun.\nBir diğeri, tutuk adımlarla tereddütlü bir dans sergiliyor. Gözlerini kapatıp ondan sıyrılıyorsun.\nSonuncusu, kopuk cümlelerle paramparça şiirler okuyor. Artık daha fazla dayanamayıp—"
  },
  Event_7591_Name = {
    Text = "Dar Yolun Canisi"
  },
  Event_7592_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7592_Desc = {
    Text = "\n\"Hayır! İnsanlığın ilerleyişi tarihe ya da teknolojiye değil, farelere bağlıdır.\"\n\"Sıçanlar karanlık çağı başlattı ve ancak ondan sonra insanlık dirilişin şafağına kavuştu.\"\n\"İnsanlığın sana ihtiyacı var—her ne kadar bunu herkes anlamasa da.\"\nFareler uzun nutkundan biraz şaşkınlığa kapıldı, ama yine de seni serbest bıraktılar."
  },
  Event_7592_Name = {Text = "Veba"},
  Event_7593_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7593_Desc = {
    Text = "Görme sinirlerindeki kasılmaların arasından seçmeye çalışırsın...\nYırtılmış, kusursuz dairesel bir Büyü Çemberi var gibi.\nİçinde sayısız yay, hareketsiz ama akışkan, büyüleyici."
  },
  Event_7593_Name = {
    Text = "From Perspective"
  },
  Event_7594_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7594_Desc = {
    Text = "<Bold>Rogers Balmumu Müzesi\n44 Nanhua Caddesi, Londinium Şehri @2 Bölge\nZiyaret Saatleri: 21: 00-6: 00\n3: 00 giriş durur (hafta sonları kapalı)\n\n<Bold>Güncel Sergi\nVladimir @2:\nGülümsemenin Felsefesi"
  },
  Event_7594_Name = {
    Text = "Karanlıktaki Kahkaha"
  },
  Event_7595_ChoiceDesc1 = {
    Text = "[Eye Contact] \"(EnchantConfig.Arg1)\" Yakarışını 3 Komut Kartından 1’ine kazı, ancak \"(Skill.Arg2)\" Becerisini geliştir."
  },
  Event_7595_ChoiceDesc2 = {
    Text = "[Close Your Eyes] Bir Uyandırıcıyı Uyanışa çağır, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7595_ChoiceDesc3 = {
    Text = "[Turn Your Back] 25 Kara Mühür al"
  },
  Event_7595_Desc = {
    Text = "Yıldızları görmemen gerek.\nSona-Nyl’in Gizli Diyarı’nda gök, akıp giden bir ihtişamla titreşir, yıldızları ve ayı gizler.\nLoş kamarada da yıldızları görememen gerekir.\nBurada yalnızca seyrek akkor lambalar ve eski fenerler olmalı—öyleyse neden hâlâ yukarıdan gelen o bakışı hissediyorsun?"
  },
  Event_7595_Name = {Text = "Gözle"},
  Event_7596_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7596_Desc = {
    Text = "\nGözlerin içine cesurca bakmayı seçiyorsun.\nOnlar, karanlıkta titreşen parlak yıldızlar.\nSonra gülüp sayısız hilal aya dönüşüyorlar.\nGözler şöyle diyor: “Bakışlardan korkmuyorsun. Korkmamalısın da... Uzun zaman oldu görüşmeyeli, @2.”\nYok olup gitmeden önce, sana küçük bir hatıra bırakıyorlar; bir “Kavuşma Anısı”."
  },
  Event_7596_Name = {Text = "Göz"},
  Event_7597_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7597_Desc = {
    Text = "Demiryolu köprüsü, Londinium'un kanı ve sinirleri, şehrin kalbini ve uzuvlarını birbirine bağlıyor. Güneş burada batmadığı sürece, Londinium'un kalbi güçlü bir şekilde atmaya devam edecek."
  },
  Event_7597_Name = {
    Text = "Çelik Köprü Serabı"
  },
  Event_7598_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7598_Desc = {
    Text = "Bestecisi bilinmeyen, enfes bir füg.\nSayısız ses benzer temalarla iç içe geçer; her nota bir cerrahın neşteri kadar keskin ve soğuktur.\nKesin ve görkemli—Rogers’ın estetiği budur.\nFüg, havalan!"
  },
  Event_7598_Name = {
    Text = "Kötü Zevk"
  },
  Event_7599_ChoiceDesc1 = {
    Text = "[Greet Out Loud]"
  },
  Event_7599_ChoiceDesc2 = {
    Text = "[Seek Help]"
  },
  Event_7599_Desc = {
    Text = "Geminin korkuluğuna yaslandığın anda, beyaz elbiseli bir kız görürsün.\nAsil, saf, dünyevi olmayan… ve tuhaf biçimde tanıdık.\nOnu daha önce nerede görmüştün? Kaotik anılarını elerken zorlanırsın; tam o sırada, sanki varlığının farkına varmış gibi olur ve boşluğun ötesinden gözlerini seninkilere kilitler.\nOnun Gözleri, erken bahar denizi kadar sakindir; yine de içlerinden tuhaf bir şey sezersin…\nSanki senden onu selamlamanı bekliyordur; yalnızca bugünün havasından söz etmek için bile olsa."
  },
  Event_7599_Name = {
    Text = "Beyaz Elbiseli Kız"
  },
  Event_7600_ChoiceDesc1 = {
    Text = "[Praise It] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_7600_ChoiceDesc2 = {
    Text = "[Taunt It] [(Skill.Arg1)] Semptomunu geliştir ve kazınacak Yakarışı değiştir.(Kullanım: 1/2)"
  },
  Event_7600_Desc = {
    Text = "Jenkin şöyle dedi: \"Johnny! Gerçekten de... her bakımdan eskisinden çok farklısın.\"\nSen şöyle dedin: \"Sen de gerçekten çalışkan ve hırslı bir beyinmişsin.\"\nBeyin hafifçe kıvrılıp büküldü, belli ki çok memnun olmuştu.\nBeyin şöyle dedi: \"Hadi bakalım! Madem başarılarımı takdir ediyorsun, sana tüm ömür boyu biriktirdiğim Bilgi’yi aktaracağım...\""
  },
  Event_7600_Name = {
    Text = "Filozofun Beyni"
  },
  Event_7601_ChoiceDesc1 = {
    Text = "[Graceful Fugue] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı elde et, ancak \"(Skill.Arg2)\"yi geliştir."
  },
  Event_7601_ChoiceDesc2 = {
    Text = "[Simple Serenade] Tüm Uyandıranlar 50 Aliemus kazanır, ancak sen [(Skill.Arg1)]i geliştirirsin."
  },
  Event_7601_ChoiceDesc3 = {
    Text = "[Meaningless Noise] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_7601_Desc = {
    Text = "\"Açıkçası, küratörün müzik zevkine pek katıldığımı söyleyemem...\nFazla gösterişli, ben ise ayağı yere basan biriyim.\"\nGıcırdayan gramofondan yorgun bir erkek sesi yükselir, kendi kendine yakınarak.\n\"Ama bu benim işim... Pekâlâ, vakit kaybetmeyelim ve bir tane seçelim.\""
  },
  Event_7601_Name = {
    Text = "Kötü Zevk"
  },
  Event_7602_ChoiceDesc1 = {
    Text = "[Special Relic] Altın Bir Kalıntı Edin [(RelicConfig.Arg1)]"
  },
  Event_7602_ChoiceDesc2 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_7602_Desc = {
    Text = "Etkinlik 253 (Geliştirme Aşamasında), Nihai Etki Değil"
  },
  Event_7602_Name = {
    Text = "Etkinlik 253 (Geliştirme Aşamasında)"
  },
  Event_7603_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7603_Desc = {
    Text = "Elinden geldiğince hızlı kaçarsın.\nŞimdi, bugüne dek gördüğün en baş belası ve en tiksindirici canavarlarla—sürü halinde gelen Balmumu Heykellerle—yüzleşiyorsun.\nOnlarla kıyaslandığında, bu kaba kil figürler hiçbir şeydir.\nÖnceliklendirme—her Muhafızın uyması gereken bir ilkedir."
  },
  Event_7603_Name = {Text = "Taslak"},
  Event_7604_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7604_Desc = {
    Text = "Gümüş Anahtar parıldar, mekânı gümüşi bir ışıltıyla doldurur ve yoğun, akışkan renkleri saf gümüşe dönüştürür.\nIşık bir anda yok olur, geride yalnızca rüzgârın matemli çığlığı kalır."
  },
  Event_7604_Name = {
    Text = "Özlemin Rengi"
  },
  Event_7605_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7605_Desc = {
    Text = "O yanardöner parıltı gözlerinizi kamaştırıyor ve siz farkına varmadan büyülenip transa dalıyorsunuz..."
  },
  Event_7605_Name = {
    Text = "Yıldız Kavşağı"
  },
  Event_7606_ChoiceDesc1 = {
    Text = "[Descend Further] [(Skill.Arg1)] Semptomunu geliştir"
  },
  Event_7606_ChoiceDesc2 = {
    Text = "[Pull Away] 25 Kara Mühür al"
  },
  Event_7606_Desc = {
    Text = "\"Sen\", seni daha derinlere davet eder.\nSarmalın dibinde, geçmişteki ve gelecekteki \"sen\", sana farklı boyutlardan \"armağanlar\" yollar."
  },
  Event_7606_Name = {Text = "Uçurum"},
  Event_7607_ChoiceDesc1 = {
    Text = "[Understanding] \"(RelicConfig.Arg1)\" Altın Kalıntıyı edin, ancak \"(Skill.Arg2)\" becerisini geliştir"
  },
  Event_7607_ChoiceDesc2 = {
    Text = "[Innocence] 3 Altın Kalıntı arasından 1 tane edin, ancak [(Skill.Arg1)] Semptomunu geliştir"
  },
  Event_7607_ChoiceDesc3 = {
    Text = "[Leave] [(RelicConfig.Arg1)] Gümüş Kalıntıyı edin"
  },
  Event_7607_Desc = {
    Text = "Gözlerinin önünde, havada süzülen, viskoz bir sıvı biçiminde, gümüşi ışık saçan iki siluet beliriyor.\n“Tam olarak burada can verdim.” Figürlerden biri çömeliyor.\n“Tanrı’nın hastalıksız âleminde, arzu ve kayıp diye bir şey yoktur. Sen gerçekten anlamıyorsun—yok olmanın ne demek olduğunu.”\nDiğer figür iç çekiyor, O'nun Bakışı’nı sana çeviriyor."
  },
  Event_7607_Name = {
    Text = "Kayıp Panteon"
  },
  Event_7608_ChoiceDesc1 = {
    Text = "[Leave] Projektör Ara"
  },
  Event_7608_ChoiceDesc2 = {
    Text = "[Enter the Mist] [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_7608_ChoiceDesc3 = {
    Text = "[Enter Directly]"
  },
  Event_7608_Desc = {
    Text = "İleride yoğun, siyah bir sis uzanıyor; düşüncesizce içine dalmak felaket getirir.\nBelki de sisi dağıtmak için bir \"Projektör\" bulmalısın."
  },
  Event_7608_Name = {Text = "???"},
  Event_7609_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7609_Desc = {
    Text = "\"Bu, anının yansıtmasıdır,\" diye açıkladı Ramona, \"Belki belirli bir kişiye aittir, belki de birkaç kişinin paylaştığı ortak bir anıdır.\"\nDeğerli anılar dikkatle korunmayı hak eder."
  },
  Event_7609_Name = {
    Text = "Anılarımız"
  },
  Event_7610_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7610_Desc = {
    Text = "Şimdilik onu çözemesen de vazgeçmiyorsun. Mektubu dikkatle katlayıp cebine yerleştiriyor, okula döndüğünde onu okuyabilmenin başka bir yolunu bulmayı planlıyorsun.\nNe var ki, mektup havada gizemli bir şekilde buruşurken, göğsünde hafif bir sızı filizlenmeye başlıyor."
  },
  Event_7610_Name = {
    Text = "Lekeli Mektup"
  },
  Event_7611_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7611_Desc = {
    Text = "Mum, teraziden ayrıldığı anda alev alır; parmaklarının arasından hızla süzülüp kaybolan süt beyazı gözyaşları döker."
  },
  Event_7611_Name = {
    Text = "Akıl ve Tutku"
  },
  Event_7612_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7612_Desc = {
    Text = "Aceleyle kâğıdı daktilodan çekersin—ama o çalışmaya devam eder. Bu panik anında, bir Komut Kartı içeri düşer ve en siyah mürekkeple geri dönülmez biçimde bulaşarak kullanılamaz hâle gelir.\nOnu dikkatle ortadan kaldırmak için bir an duraksarsın, ama üzerine şimdi kazınmış, tehditkâr ve tekerrür eden metni fark etmemek elde değildir;\n<Bold:DOĞRUDAN BAKMA>\n<Bold:DOĞRUDAN BAKMA>\n<Bold:DOĞRUDAN BAKMA>\n<Bold:DOĞRUDAN BAKMA>\n<Bold:DOĞRUDAN BAKMA>\n<Bold:DOĞRUDAN BAKMA>\n<Bold:DOĞRUDAN BAKMA>\n<Bold:DOĞRUDAN BAKMA>"
  },
  Event_7612_Name = {
    Text = "Davetsiz Uyarı"
  },
  Event_7613_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7613_Desc = {
    Text = "Parmakların kupanın iliğini donduracak kadar soğuk kenarına değdiğinde ürperip birden kendine geldin.\nYine de, yol kenarında bırakılmamalı. En iyisi onu bavula kaldırmak."
  },
  Event_7613_Name = {
    Text = "Bal Şarabı"
  },
  Event_7614_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7614_Desc = {
    Text = "Şiddetle öksürüyorsun.\nSes ürkmüş gibi oluyor, sonra susuyor.\nÖnemli bir ipucunu kaçırmışsın gibi hissediyorsun...\nAma hayat zaten kaçırılmış fırsatlar ve pişmanlıklarla dolu, değil mi?"
  },
  Event_7614_Name = {
    Text = "Kulak Misafiri"
  },
  Event_7615_ChoiceDesc1 = {
    Text = "[Keep Silent] %100 ihtimalle 25 Kara Mühür elde et"
  },
  Event_7615_ChoiceDesc2 = {
    Text = "[Reach Out and Touch] %50 ihtimalle 50 Kara Mühür kazan, %50 ihtimalle hiçbir şey kazanma."
  },
  Event_7615_Desc = {
    Text = "\"Söyleyeceğim tek bir vecize var—hiç kimse bir kediyi öldüremez!\"\n\"Şu lanet siyah kedi çoktan bağırsakları çıkarılıp vahşi doğada çürümeye bırakılmalıydı, ama gitti aile mezarımı eşeledi, kalan insan etini yiyip kemikleri ve uzuvları her yere Saçılma hâlinde savurdu.\"\n\"Soğuk, karanlık, yarık gibi gözbebeklerinin altında, o irinli sarı cerahat yüzeye çıktı ve ben karabasanlarla kıvranarak sürünerek uzaklaştım, Ruh’um emilip tükenmişti.\"\n\"Bekle... Ne yapıyorsun? Ben deli değilim! Değilim! Kesin bir şey saklıyorsun! Hepsi gerçek—\"\nGerçekten de gerçek. Deli adamın gölgesinin yok oluşunu izlerken, ayaklarının dibindeki sessiz siyah kediyle göz göze geliyorsun."
  },
  Event_7615_Name = {
    Text = "Gece Kedisinin Laneti"
  },
  Event_7616_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7616_Desc = {
    Text = "Tereddüt edince, D-iz’e çözünüp hızla gözden kayboldu."
  },
  Event_7616_Name = {
    Text = "Barrel Flotsam"
  },
  Event_7617_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7617_Desc = {
    Text = "Mektubu öfkeyle buruşturup ayaklarının dibine fırlatıyorsun."
  },
  Event_7617_Name = {
    Text = "Lekeli Mektup"
  },
  Event_7618_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7618_Desc = {
    Text = "Dikkatini toplarsın ve düş, suya karışan mürekkep gibi dağılır. İleriye doğru yürürsün, ama kalbindeki gölge yerinden kıpırdamaz."
  },
  Event_7618_Name = {Text = "İllüzyon"},
  Event_7619_ChoiceDesc1 = {
    Text = "[Examine Carefully] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\"yi geliştir."
  },
  Event_7619_ChoiceDesc2 = {
    Text = "[Avoid Shadows] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\"yi geliştir."
  },
  Event_7619_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_7619_Desc = {
    Text = "Ramona'nın sinirleri gergindi; akıl hastanesinde dikkatle ilerlerken Halktan kaçınıyordu.\nKüçük bir odaya süzüldü.\nPencerinin dışında aniden bir Gölge belirdi."
  },
  Event_7619_Name = {
    Text = "Penceredeki Yansıma"
  },
  Event_7620_ChoiceDesc1 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_7620_Desc = {
    Text = "Şu an daha acil görev, suçluyu adalete teslim etmek. Ne var ki öfkenin tohumları kalbinde çoktan kök saldı. Cevabını beklemeden adam arkasını dönüp uzaklaştı."
  },
  Event_7620_Name = {
    Text = "Devasa Yaratığın İzi"
  },
  Event_7621_ChoiceDesc1 = {
    Text = "[Leave] 75 Kara Mühür kazan, ancak [(Skill.Arg2)] Semptomunu geliştir"
  },
  Event_7621_Desc = {
    Text = "Mythag’da çocukluğundan beri aldığın eğitim, bu damgayı görmezden gelmeni imkânsız kılmıştı. Tozlu ayak izlerini silip süpürdün ve o anda, uzak bir boyuttan gelen bir yanıt duymuş gibi oldun: “Teşekkürler.”"
  },
  Event_7621_Name = {
    Text = "Devasa Yaratığın İzi"
  },
  Event_7622_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7622_Desc = {
    Text = "Gümüş Anahtarı kavradın; yumuşak gümüş ışığı ve hafif titreşimleri sana teselli veriyor. Bakış kaybolmuş gibi oldu, ama yine de oyalanarak sende görünmez bir iz bıraktı."
  },
  Event_7622_Name = {
    Text = "Kimin Bakışı?"
  },
  Event_7623_ChoiceDesc1 = {
    Text = "[Find the Secret Path]"
  },
  Event_7623_Desc = {
    Text = "Sen, Ramona ve Lotan, cehennem köpeğinin peşine düşmek için ayrılırsınız.\n\nBirkaç ara sokaktan son sürat geçersin, önünde devasa bir gövde belirir.\nPeşine takıldığın anda köşeyi döner.\nYetişirsin ama karşında bir çıkmaz vardır; üç yüksek duvar, gökyüzünden dar bir kareyi kuşatmıştır."
  },
  Event_7623_Name = {Text = "Çıkmaz"},
  Event_7624_ChoiceDesc1 = {
    Text = "[Walk Past]"
  },
  Event_7624_ChoiceDesc2 = {Text = "[Pat]"},
  Event_7624_Desc = {
    Text = "Tertemiz ve yumuşak ameliyat masasının yanında, çoktan çökmüş Koum’un bedeni yatıyor.\nHâlâ uzun, küçük bir tepe gibi; onu ilk gördüğünde hatırladığın gibi.\nAncak gökteki gerçek \"Cehennem Köpekleri\" yle kıyaslandığında o kadar küçük ki, bir çocuğu andıracak kadar küçük."
  },
  Event_7624_Name = {
    Text = "Kalan Sıcaklık"
  },
  Event_7625_ChoiceDesc1 = {
    Text = "[Get Silver]"
  },
  Event_7625_Desc = {
    Text = "Hımm, ileride pek çok pırıl pırıl şey var gibi görünüyor!\nKokla... güzel kokuyor.\nYala... buz gibi serin!\nDeğerli bir şeye benziyor. Çabuk, bunu Küçük Jenkin'e götürelim, belki bir sürü peynir cıkcığı alabiliriz!"
  },
  Event_7625_Name = {
    Text = "Altın Parıltı"
  },
  Event_7626_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7626_Desc = {
    Text = "Hayalî ağ, yavaş yavaş dağılırken kalbinde yabancı bir hayal kırıklığı dalgası kabarır ve önündeki Fitil Yolu ortaya çıkar."
  },
  Event_7626_Name = {
    Text = "Vagus Ağı"
  },
  Event_7627_ChoiceDesc1 = {
    Text = "[Comprehend it] Rastgele bir Uyandırıcıyı Uyanışa geçir, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_7627_ChoiceDesc2 = {
    Text = "[Ignore It] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_7627_Desc = {
    Text = "Balık biçimli yaşam formunun kükreyişinden rünler taşar, kulaklarını, burun deliklerini ve boğazını doldurur. Bedenini yakarlar. Sadece on saniye içinde, bu kükreyişin ardındaki derin anlamı kavrayacaksın..."
  },
  Event_7627_Name = {
    Text = "Rün Çılgınlığı"
  },
  Event_7628_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7628_Desc = {
    Text = "Dişlerini sıkıp kaotik fantazmaya direnmeye çalışıyorsun. Ramona avucuna soğuk bir nesne bırakıyor.\n \"Keşif yoluyla bulduğum bu kalıntı sana yardımcı olabilir.\""
  },
  Event_7628_Name = {
    Text = "Boyutsal Hayalet"
  },
  Event_7629_ChoiceDesc1 = {
    Text = "Gelişmiş bir Yakarış seç"
  },
  Event_7630_ChoiceDesc1 = {
    Text = "[Kargayı Bastır] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_7630_ChoiceDesc2 = {
    Text = "[Kill Crow] 3 Yakarıştan 1’ini Oyarak Kazı"
  },
  Event_7630_ChoiceDesc3 = {Text = "[Leave]"},
  Event_7630_Desc = {
    Text = "Yalnız karga, kısık bir sesle gaklayarak siyah kanatlarını tek tek yoluyor.\nAcıyla titriyor, çılgınca hareketleri şiddetlenirken kontrolsüzce çığlık atıyor.\n\"Gaak—Gaak—\"\nGözlerinden, yalnızca senin tanık olduğun, siyah sümüksü sıvıyla karışmış mavi yaşlar sel gibi akıyor."
  },
  Event_7630_Name = {
    Text = "Erimiş Gözyaşı"
  },
  Event_7631_ChoiceDesc1 = {
    Text = "[Leave] Maks. HP’yi Arg1 kadar artır"
  },
  Event_7631_Desc = {
    Text = "\"Bana bırak,\" diyorsun, canavarın omurgasını usulca okşayarak, sanki öfkeli bir yavru kediyi yatıştırıyormuşsun gibi, \"O uyanacak. Ona zarar vermeyeceğiz.\""
  },
  Event_7631_Name = {
    Text = "Dostluğun Çağrısı"
  },
  Event_7632_ChoiceDesc1 = {
    Text = "[Leave] Azami Canı Arg1 kadar artır, fakat \"(Skill.Arg2)\" ve \"(Skill.Arg3)\" geliştir."
  },
  Event_7632_Desc = {
    Text = "\"Uyan, Lily. Koum da bir an önce uyanmanı istiyor—\""
  },
  Event_7632_Name = {
    Text = "Dostluğun Çağrısı"
  },
  Event_7633_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7633_Desc = {
    Text = "Artık bir işe yaramıyor."
  },
  Event_7633_Name = {
    Text = "Silent Telegram"
  },
  Event_79429_ChoiceDesc1 = {
    Text = "Bir Uyandıran seç ve Yaşam Ayini aracılığıyla bir \"Böceksiler\" e dönüş. \"Böceksiler\" Komut Kartları 1 daha az Arithmetica’ya mal olur, fakat oynandıktan sonra Tüketilir."
  },
  Event_79429_Desc = {
    Text = "\"Öz farkındalık süreci daima acıyla iç içedir; tıpkı başkalaşım ve topraktan yeniden doğuşta olduğu gibi.\"\nŞefkatle gülümser, yüzünüzü sevgiyle okşar.\n \"Korkma, tam burada, yanında duruyorum; o yüzden ruhunu aç ve onları kabul et.\"\n \"İyi çocuk, yeniden doğuşunu bekliyorum, seni bekliyorum... bizim bir parçam olmanı bekliyorum.\""
  },
  Event_79429_Name = {
    Text = "Ruh Göçü"
  },
  Event_80463_ChoiceDesc1 = {
    Text = "[Leave] Üç Gümüş Kalıntıdan birini elde et, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_80463_Desc = {
    Text = "Bir yol seçip küçük William’ı sürükleyerek delicesine koşuyorsun.\nNeyse ki seçimin doğru çıkıyor.\nO zihinsel bükülmelerden, o birbirinin aynı Clementine’lerden sonunda sıyrılmayı başarıyorsun.\nElbette, bunun bir bedeli oldu."
  },
  Event_80463_Name = {
    Text = "\"Clementine\"'ler"
  },
  Event_80464_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80464_Desc = {
    Text = "Bilinç ötesi bir anı beynine zerk edilir, doğrudan sağduyunu paramparça eder.\nO hızla sarıp geçen sahnede yalnızca tek bir şeyi hatırlarsın: üçgen Tapınak.\nBu, Shag@2ais tarafından Kör Ahmak Tanrı @4 için inşa edilmiş büyük bir başarıydı."
  },
  Event_80464_Name = {
    Text = "Derin Hafıza"
  },
  Event_80465_ChoiceDesc1 = {
    Text = "[Leave] Bir Uyandırıcıyı Uyanışa çağır, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_80465_Desc = {
    Text = "Bir yol seçip küçük William’ı sürükleyerek delicesine koşuyorsun.\nNeyse ki seçimin doğru çıkıyor.\nO zihinsel bükülmelerden, o birbirinin aynı Clementine’lerden sonunda sıyrılmayı başarıyorsun.\nElbette, bunun bir bedeli oldu."
  },
  Event_80465_Name = {
    Text = "\"Clementine\"'ler"
  },
  Event_80466_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80466_Desc = {
    Text = "\"Tık. Tık. Tık.\"\n \"İş\" sonunda tamamlanır, ama \"iş\" in kendisi dışında, gerçekte ne kazanmış oldun?"
  },
  Event_80466_Name = {
    Text = "Sonsuz Işkence"
  },
  Event_80467_ChoiceDesc1 = {
    Text = "[Leave] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_80467_Desc = {
    Text = "\"Samimi cevabını duymak beni memnun etti.\"\n\"Bir sonraki buluşmamızı sabırsızlıkla bekliyorum.\""
  },
  Event_80467_Name = {
    Text = "Düş Çağrısı"
  },
  Event_80468_ChoiceDesc1 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_80468_Desc = {
    Text = "\"Ah, ne kadar sahtekâr bir çocuk.\"\n\"Ama sorun değil, bir dahaki sefere seni gerçeği söylemeye zorlayacağım.\"\n\"Kalbinden ve ruhundan fışkıran tüm gerçekleri.\""
  },
  Event_80468_Name = {
    Text = "Düş Çağrısı"
  },
  Event_80469_ChoiceDesc1 = {
    Text = "[Start \"Working\"] Bir Komut Kartı İmha Et ve Arg1 Kara Mühür elde et."
  },
  Event_80469_ChoiceDesc2 = {
    Text = "[Retreat Far Away]"
  },
  Event_80469_Desc = {
    Text = "\"Tık.\"\nDaktilonun sesi çınlar ve \"iş\" bitene dek sonsuza dek onun kölesi olursun."
  },
  Event_80469_Name = {
    Text = "Sonsuz Işkence"
  },
  Event_80470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80470_Desc = {
    Text = "\"Ne yazık, ihtiyatın, gerçeği öğrenebileceğin tek fırsatı kaçırmana neden oldu.\"\nİç çeker, sessizce çözülür."
  },
  Event_80470_Name = {
    Text = "Derin Hafıza"
  },
  Event_80471_ChoiceDesc1 = {
    Text = "[All-Out Attack]"
  },
  Event_80471_ChoiceDesc2 = {
    Text = "[Fight and Retreat]"
  },
  Event_80471_Desc = {
    Text = "Beklenmedik bir siluet önünde belirir—Clementine'dir.\n\"Şaşırma, sadece bir özel test yapmak istiyorum.\"\n\"Testin ne olduğuna gelince, bu bir sır.\" Clementine gülümser, \"Senin için testin tek içeriği—\"\n\"hayatta kalmak.\""
  },
  Event_80471_Name = {
    Text = "Özel Sınama"
  },
  Event_80472_ChoiceDesc1 = {
    Text = "[Recall the Past]"
  },
  Event_80472_ChoiceDesc2 = {
    Text = "[Pull out the Scales]"
  },
  Event_80472_Desc = {
    Text = "“Lütfen bana inan, kötü bir niyetim yok, sadece sana yardım etmek istiyorum.”\nClementine peşinden koşuyor, yüksek sesle bağırıyordu.\nSesi inanılmaz derecede içten geliyor, ama artık hiçbir şeye güvenemiyorsun.\nAhlakın “Bedenleşmiş Biliş Kuramı” tarafından paramparça edildi ve aklın çöküşün eşiğinde.\nEtinde filizlenen böcek pullarına, ruhuna yavaş yavaş sızan deliliğe ve umutsuzluğa karşı koymak için bir şey yapmalısın, mutlaka yapmalısın."
  },
  Event_80472_Name = {
    Text = "Çırpınan Ruhlar"
  },
  Event_80473_ChoiceDesc1 = {
    Text = "[Leave] Herhangi 2 Kartı İmha Et"
  },
  Event_80473_Desc = {
    Text = "\"Final savaş için gücünü korumak mı istiyorsun?\"\n \"Bilgece bir seçim. Ama kazanırken, insan aynı zamanda kaybeder.\"\n \"Çünkü bu yanan ve zalim dünyada, hayatta kalmanın bile bir bedeli vardır.\""
  },
  Event_80473_Name = {
    Text = "Özel Sınama"
  },
  Event_80474_ChoiceDesc1 = {
    Text = "[Ignore It] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_80474_ChoiceDesc2 = {
    Text = "[Ona Dokun] Rastgele 1 Komut Kartı Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_80474_Desc = {
    Text = "Sporlara benzeyen tuhaf bir şey dikkatini çekti.\nEt ve kandan yapılmış narin bir denizanasını andırıyordu; aynı zamanda beynin derinliklerinde sinyaller taşıyan sinir liflerine de benziyordu.\n“Gel, dokun bana,” diye sessizce ayartıyor, “sana zalim bir anı göstereceğim.”"
  },
  Event_80474_Name = {
    Text = "Derin Hafıza"
  },
  Event_80475_ChoiceDesc1 = {
    Text = "[Leave] 3 Yakarış arasından 1’ini Oyarak Kazı"
  },
  Event_80475_Desc = {
    Text = "\"Ramona, Oyuncak Bebek, Lotan, Ogier...\"\nBu isimleri durmadan, kaygıyla fısıldayıp duruyorsun.\nParamparça olmuş aklın artık yüzlerini hatırlayamıyor, ama temsil ettikleri varlık hâlâ kalbini ve ruhunu ısıtıyor.\nOnlar vardı, güldüler, onlar... şu anda İnsanlığın Işığı'nı yerinde tutan, senin için temel çizgi ve demir atma noktası oldular."
  },
  Event_80475_Name = {
    Text = "Çırpınan Ruhlar"
  },
  Event_80476_ChoiceDesc1 = {
    Text = "[Leave] Üç Gümüş Kalıntıdan birini elde et, fakat [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_80476_Desc = {
    Text = "\"Aaaaaah—\"\nAğzını açtın, bağırdın; çıkan ses bir çığlıktan çok bir cayırtıya benziyordu.\nYolunmuş böcek pulları yeniden bitti ve paramparça olmuş sağduyun sonsuza dek yitirildi."
  },
  Event_80476_Name = {
    Text = "Çırpınan Ruhlar"
  },
  Event_80477_ChoiceDesc1 = {
    Text = "[Leave] \"(RelicConfig.Arg1)\" Kalıntısını elde et, fakat \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_80477_Desc = {
    Text = "Hiçbir şeyi saklamadan, tüm gücünü ortaya koyarsın. Bu tavır, Clementine’in gözünden kaçmaz, belli ki hoşuna gider.\n“Ne kadar uslu bir çocuk.”\n“Öyleyse, sana küçük bir ödül vereyim. Elbette, bir bedeli olacak.”\n“Bu yanan, zalim dünyada, hayatta kalmanın kendisi bile bir bedel ister.”"
  },
  Event_80477_Name = {
    Text = "Özel Sınama"
  },
  Event_80478_ChoiceDesc1 = {
    Text = "[Start \"Working\"] Bir Komut Kartı İmha Et ve Arg1 Kara Mühür elde et."
  },
  Event_80478_ChoiceDesc2 = {
    Text = "[Retreat Far Away]"
  },
  Event_80478_Desc = {
    Text = "\"Tık. Tık.\"\nDaktilonun sesi çınlar ve “iş” sürerken, onu tamamlamaktan başka işe yaramayan bir araçsın."
  },
  Event_80478_Name = {
    Text = "Sonsuz Işkence"
  },
  Event_80479_ChoiceDesc1 = {
    Text = "[Run to the Left]"
  },
  Event_80479_ChoiceDesc2 = {
    Text = "[Run to the Right]"
  },
  Event_80479_Desc = {
    Text = "Tanıdık bir silüet seni amansızca kovalar—yalnız bir iki tane değil, onlarca, yüzlerce.\nDar koridor bu kadar çok \"Clementine\"i alamaz; bazı \"Clementine\"ler yere itilir, bazıları çamura dönene dek Çiğneme ile ezilir.\nAma hepsi bir ağızdan sana seslenir, zihnini Zehir gibi kemiren o cümleyi tekrarlar.\n\"Neden kaçıyorsun? Ben sadece sana bir muayene yapmak istemiştim.\"\nVe sen, Sanatoryum’un koridorlarında delicesine koşar, bir yol ayrımında Seçim yapmak zorunda kalırsın."
  },
  Event_80479_Name = {
    Text = "\"Clementine\"'ler"
  },
  Event_80480_ChoiceDesc1 = {
    Text = "[Start \"Working\"] Bir Komut Kartı İmha Et ve Arg1 Kara Mühür elde et."
  },
  Event_80480_ChoiceDesc2 = {
    Text = "[Retreat Far Away]"
  },
  Event_80480_Desc = {
    Text = "\"Düzelt! Çalış! Durma!\"\nSayısız mırıltı kulaklarında yankılanır, seni aniden beliren daktiloya doğru çeker.\n \"Ne yapmalı, ne yapmalı, sabahtan geceye kadar yazıyorum ama iş bir türlü bitmiyor.\"\n \"Düzelt! Düzelt! Planı düzelt, talepleri sun, işi tamamla!\"\n \"Çalış! Çalış!! Çalış!!\"\nMırıldanan ruh, durmaksızın yazan daktiloya çarpar durur ve sonunda o daktilo susar.\nAma bir an sonra, o daktilo yeniden çalışmaya başlar.\n \"Düzelt! Çalış! Durma!\"\nÇünkü çalışmanın sonu yoktur."
  },
  Event_80480_Name = {
    Text = "Sonsuz Işkence"
  },
  Event_80481_ChoiceDesc1 = {
    Text = "[Answer Honestly]"
  },
  Event_80481_ChoiceDesc2 = {
    Text = "[Refuse to Answer]"
  },
  Event_80481_Desc = {
    Text = "Bir an içinde, önündeki manzara bulanık ve hayaletsi bir hâl alır.\nBaşta bükülüp şekil değişenin odağın olduğunu sanırsın, ama sonra anlarsın ki istila edilen, görme sinirlerindir.\n \"Yeniden karşılaştık.\"\nBulanık görüş alanında, Clementine usulca gülümser.\n \"Beklediğimizden daha erken buluşsak da, yine de çok mutluyum. Merak ediyorum, sen de aynı şeyi hissediyor musun, %player%?\""
  },
  Event_80481_Name = {
    Text = "Düş Çağrısı"
  },
  Event_80595_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80595_Desc = {
    Text = "\nOnu kovma çabana karşı, kelebek kayıtsız kalır.\nIsrarla avucunu kovalarken, avuç içinde canlılığını yitirir.\n\"Ah, ne kadar sıcak...\"\nBu, onun son fısıltısıydı."
  },
  Event_80595_Name = {
    Text = "Kelebek Rüyası"
  },
  Event_80596_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80596_Desc = {
    Text = "\"Çiçeklerin sonsuza dek açmasını istiyorum, gülümsemelerin ebediyen sürmesini istiyorum.\"\n\"Çözünme'den muzdarip herkesin huzur içinde iyileşmesini diliyorum, bu dünyanın geçmişine dönüp yanmayı bırakmasını diliyorum.\"\n\"İstiyorum...\"\nKüçük kelebek kanatlarını çırptı, avucunuzda canlılığını yitirdi.\nEn azından, birisi onun sesini dinledi."
  },
  Event_80596_Name = {
    Text = "Kelebek Rüyası"
  },
  Event_80597_ChoiceDesc1 = {
    Text = "[Kelebeği Kovala] Rastgele 1 Komut Kartı Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte ol"
  },
  Event_80597_ChoiceDesc2 = {
    Text = "[Listen to Their Wish] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_80597_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_80597_Desc = {
    Text = "Küçük kelebek birçok rüya taşır.\nBu rüyalar çiçek denizine, koğuşa ve @2'nin kan ve etiyle dolu sunağa saçılır.\nSonunda, bağını bekledi; küçücük, minicik dileğini dinlemeye istekli olup olmadığınızı bilmeden."
  },
  Event_80597_Name = {
    Text = "Kelebek Rüyası"
  },
  Event_80610_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80610_Desc = {
    Text = "\"Akılcılık mı? İlginç bir cevap.\"\n\"Umarım Seçiminden pişman olmazsın.\""
  },
  Event_80610_Name = {
    Text = "Humanity's Toll"
  },
  Event_80612_ChoiceDesc1 = {
    Text = "[Feed Them] Gümüş Kalıntı [(RelicConfig.Arg1)]i elde et, fakat 3 Semptomdan 1’ini geliştir."
  },
  Event_80612_ChoiceDesc2 = {
    Text = "[Pay No Mind] 3 Komut Kartından 1’ine \"(EnchantConfig.Arg1)\" Yakarışını kazı, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_80612_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_80612_Desc = {
    Text = "Sakinler gelir gider, ama fare sürüsü sonsuza dek uzayıp gidiyor.\nİnsanlarla kıyaslandığında, bu kalenin gerçek “yerlileri” onlardır.\nYine de insanların içeri taşınmasına hiçbir itirazları yoktur.\nÇünkü o yumuşak ve beyaz, çirkin şeyler onlara aynı derecede yumuşak ve beyaz, çirkin şeyler yedirecektir.\n“Ve sen, çirkin şey, hangi türe aitsin?”"
  },
  Event_80612_Name = {
    Text = "Citadel's Secret"
  },
  Event_80613_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80613_Desc = {
    Text = "\nKaranlıktan yumuşak bir kahkaha yükselir.\n\"Seninle buluşmak için, seni bekliyorum.\"\n\"Cesur küçük böcek.\""
  },
  Event_80613_Name = {
    Text = "\"O\"nun Bakışı"
  },
  Event_80614_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80614_Desc = {
    Text = "\"Kes sesini, kes sesini, berbat tınlıyorsun.\"\nSiyah kedi, benzersiz bir insan tavrıyla patileriyle kulaklarını kapatıyor.\n \"İnsan, kedi dilin çok kötü, söylediğin hiçbir şeyin anlamı yok!\"\nBöyle söylese de, siyah kedinin ifadesi yumuşar.\n \"Beni memnun etmek için miyavladığın için, sana bir hediye bırakacağım.\"\n \"Hediyenin içeriği ise, şansına kalmış.\""
  },
  Event_80614_Name = {Text = "Nigelman"},
  Event_80615_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80615_Desc = {
    Text = "\n\"Anne, arkadaşlarımı, kocamı ve oğlumu kaybettikten sonra, şimdi de küçük kızım Diana'yı sonsuza dek yitirdim.\"\n\"Önümde küle döndüğünde, zihnim bomboş oldu...\" Sonraki yazılar artık okunamıyor.\nSadece bir sonraki satıra dönüp bakabiliyorsun.\nKararımı verdim. Seni bir daha görürsem, lütfen beni suçlama; ben sadece... hepinizi fazlasıyla özlüyorum."
  },
  Event_80615_Name = {
    Text = "Fading Longing"
  },
  Event_80616_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80616_Desc = {
    Text = "Kovma ritüelin etkisini gösterir. Belirsiz birkaç beden bükülerek kaçar, çoğu ise kalır.\nArtık gülmez, ilahi söylemezler; yüksek sesle ağlarlar.\nKulaklarında bir çocuğun çığlığı patlar, tek bir cümleyi durmadan tekrarlar.\n\"Canavarı öldür!\""
  },
  Event_80616_Name = {
    Text = "\"Onun\"Çocukluğu"
  },
  Event_80617_ChoiceDesc1 = {
    Text = "[Leave] [(Skill.Arg1)] Semptomunu Geliştir"
  },
  Event_80617_ChoiceDesc2 = {
    Text = "[Leave] [(Skill.Arg1)] Semptomunu Geliştir"
  },
  Event_80617_ChoiceDesc3 = {
    Text = "[Leave] [(Skill.Arg1)] Semptomunu Geliştir"
  },
  Event_80617_Desc = {
    Text = "Beslenmen, sıçan sürüsünü memnun ediyor.\nDevasa sürü kıvranıyor ve sana kaba saba sarılmış bir hediye sunuyor.\nŞeklini seçemiyorsun, yalnızca sargısına işlemiş büyük miktarda kan görüyorsun."
  },
  Event_80617_Name = {
    Text = "Citadel's Secret"
  },
  Event_80618_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80618_Desc = {
    Text = "\"...\"\n\"......\"\n\".........\"\nGölge sessiz kalıyor; ağlamak istiyor, ama bunu yapma yetisini yitirmiş.\nSonunda yalnızca derin bir iç çekiyor.\n\"Dostum, umarım en kıymetli şeylerini koruyabilirsin.\""
  },
  Event_80618_Name = {
    Text = "İçi Boş İnsan"
  },
  Event_80619_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80619_Desc = {
    Text = "Azarların hiçbir işe yaramıyor, sadece onları daha çılgınca sevinçli yapıyor.\nKahkahalar ve ilahiler daha da yükseliyor ve yeni bir tekerlemeye başlıyorlar:\n\"Küçük William, yüksek kalede,\nİnsan yiyen fareler duvarda koşar.\nİnsan kurbanı bittiğinde,\nHerkes kemirilerek yok olur.\""
  },
  Event_80619_Name = {
    Text = "\"Onun\"Çocukluğu"
  },
  Event_80620_ChoiceDesc1 = {
    Text = "[Avoid Gaze] Rastgele bir Uyandırıcıyı Uyanışa Çağır"
  },
  Event_80620_ChoiceDesc2 = {
    Text = "[Stare] Uyanışa geçirecek bir Uyandırıcı seç, o Kartın Arithmetica Maliyetini 2 azalt, ancak [(Skill.Arg1)]yi geliştir."
  },
  Event_80620_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_80620_Desc = {
    Text = "Sanatoryumdaki her şey onun kontrolü ve gözetimi altındadır. Elbette sen de öylesin.\nAma senin için kör gözünü çevirmeye razı.\nSonuçta, bir oyunun ilgi çekici olması için karşılıklı olması gerekir."
  },
  Event_80620_Name = {
    Text = "\"O\"nun Bakışı"
  },
  Event_80621_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80621_Desc = {
    Text = "Zarfı yerine geri koyup ayrılmaya hazırlanırsın, fakat aniden, rüya gibi bir mırıltı duyarsın.\n\"Benim ricam üzerine, Dr. Clementine sonunda yumuşadı.\nBana anlattığı o engin, esrarengiz evrende, mutlaka hepinizi kurtarmanın bir yolu vardır.\nBen çoktan <color=#FFFFFF>Topraktan Yeniden Doğuş</color> için hazırlandım. Kaç ışık yılı sürüklenmem gerekirse gereksin, sizi bir kez daha görmeyi arzuluyorum.\""
  },
  Event_80621_Name = {
    Text = "Fading Longing"
  },
  Event_80622_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80622_Desc = {
    Text = "Dr. Clementine beni kurtardı.\nGerçekten de çok, çok iyi bir insan, beni dinlemeye istekli.\nNeşeli ve mutlu bir şeyler söylemek istiyorum, oysa şu anda sahip olduğum tek şey acı ve umutsuzluk.\nDoktorun beklentilerini boşa çıkaracağımdan korkuyorum.\nSeni kaybettikten sonra, hayat benim için ıssızlaştı."
  },
  Event_80622_Name = {
    Text = "Fading Longing"
  },
  Event_80623_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80623_Desc = {
    Text = "\"Sen, sen...\"\n\"Hıh, fena teknik değil—bu sefer geçtin. Bir dahaki sefere bu kadar kolay olmayacak!\"\nKara kedi çevik bir sıçrayışla uzaklaşıyor, diğerleri de peşinden gidiyor."
  },
  Event_80623_Name = {Text = "Nigelman"},
  Event_80624_ChoiceDesc1 = {
    Text = "[Attack the Cat] %50 ihtimalle 125 Kara Mühür al, %50 ihtimalle [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_80624_ChoiceDesc2 = {
    Text = "[Meow Like a Cat] %75 ihtimalle 100 Kara Mühür al, %25 ihtimalle [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_80624_ChoiceDesc3 = {
    Text = "[Attempt to Pet the Cat] 50 Kara Mühür al"
  },
  Event_80624_Desc = {
    Text = "\"Hey! Sen, orada dur bakalım.\"\nSiyah kediler gölgelerden fırlayarak yolunu keser.\nZarifçe patilerini yalarlar, tavırları kibirli ve gururludur.\n\"İlerideki Fitil Yolu tehlikelerle dolu; senin gibi zayıf bir insanın keşfedebileceği bir yer değil.\"\nİlerlemekteki kararlılığını dile getirirsin. Sürünün liderinin dikey Göz Bebeği kayar, avıyla oynama Niyeti’ni açığa vuran zalim bir parıltı belirir. \"Öyleyse göster bize kararlılığını.\""
  },
  Event_80624_Name = {Text = "Nigelman"},
  Event_80625_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80625_Desc = {
    Text = "\nİhmalkârlığın fare sürüsünü öfkelendirdi; çığlıklar atarak sana doğru hücum ediyorlar, oysa sen, fare seli kabarmadan çok önce uzaklara kaçmış bulunuyorsun."
  },
  Event_80625_Name = {
    Text = "Citadel's Secret"
  },
  Event_80626_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80626_Desc = {
    Text = "\"Ah, işte böyle, kır kanatlarımı.\"\n \"Zaman, sağlık, onur, hayat; benden fazlasıyla aldılar.\"\n \"Bu son rüya elbette bana ait değil.\"\n \"Çünkü ben, kapatılmış ve özgürlüğü elinden alınmış bir kuştan ibaretim.\""
  },
  Event_80626_Name = {
    Text = "İçi Boş İnsan"
  },
  Event_80627_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80627_Desc = {
    Text = "\"Duygusal mı? İlginç bir cevap.\"\n\"Umarım Seçiminden pişman olmazsın.\""
  },
  Event_80627_Name = {
    Text = "Humanity's Toll"
  },
  Event_80628_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80628_Desc = {
    Text = "\"Duana icabet ediyorum.\"\nVızıldayan ses yaklaştı, yavaşça kulak kanalından beynine doğru vidalanarak ilerledi.\nBeynin titredi, ve bu titreme içinde evrenin ‘sesini’ duydun.\n\"Benimle bağ kur.\""
  },
  Event_80628_Name = {
    Text = "Karanlık Kurtuluş"
  },
  Event_80629_ChoiceDesc1 = {
    Text = "[Pray] Rastgele bir Uyandırıcıyı Uyanışa geçir, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_80629_ChoiceDesc2 = {
    Text = "[Refuse] 3 Yakarıştan 1’ini Oyarak Kazı"
  },
  Event_80629_Desc = {
    Text = "\"Böyle olmamalıydı, böyle olmamalıydı.\"\n\"Ben açıkça, apaçık bu aşağılık insan hayatından kopup daha ileri bir şeye evrilmeliydim...\"\nKaranlığın içinde acı dolu hıçkırıkların sesi yankılandı.\nBu hıçkırıklar toplanıp kabardı ve muazzam bir uğultuya dönüştü.\n\"Bu yanan dünya, doymak bilmez bir kara delik gibi, her bir kişiyi tek tek Yutar, öyleyse—\"\n\"Bana dua edin, sonsuz evren size kurtuluş bahşedecek.\""
  },
  Event_80629_Name = {
    Text = "Karanlık Kurtuluş"
  },
  Event_80630_ChoiceDesc1 = {
    Text = "[Open the Envelope] Altın Kalıntı \"(RelicConfig.Arg1)\" edin, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_80630_ChoiceDesc2 = {
    Text = "[Read] [(EnchantConfig.Arg1)] Yakarışını 3 Komut Kartından 1’ine kazı."
  },
  Event_80630_ChoiceDesc3 = {
    Text = "[Put it back] 50 Kara Mühür kazan"
  },
  Event_80630_Desc = {
    Text = "İhmal edilmiş bir köşede, geride bırakılmış bir mektup duruyor.\nMektuptaki birçok kelime artık seçilemiyor, ama bir kelime kalmış. Kâğıdı delip geçiyor.\nO kelime “Anne”."
  },
  Event_80630_Name = {
    Text = "Fading Longing"
  },
  Event_80631_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80631_Desc = {
    Text = "\"Heh, önemsiz insan, yanlış seçimi yaptın.\"\nKara kediler sana soğuk gözlerle bakar, sonra aniden karşı saldırıya geçer.\n\"Cesurlara saygımız var ama bedelini ödemelisin.\""
  },
  Event_80631_Name = {Text = "Nigelman"},
  Event_80632_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80632_Desc = {
    Text = "\nKaranlıktan yumuşak bir kahkaha yükselir.\n\"Seninle buluşmak için, seni bekliyorum.\"\n\"Sevimli küçük böcek.\""
  },
  Event_80632_Name = {
    Text = "\"O\"nun Bakışı"
  },
  Event_80633_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80633_Desc = {
    Text = "Saldırın altında, bu çarpık ve tuhaf siluetler sonunda kaçıp kurtuldu.\nÇevre sessiz, yalnızca kalbin sessizce ağlıyor.\nMeğer bu, \"Onun\"Çocukluğu imiş."
  },
  Event_80633_Name = {
    Text = "\"Onun\"Çocukluğu"
  },
  Event_80635_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80635_Desc = {
    Text = "\"Ah, küçük metin tuzağı açığa çıkarılmış.\"\n\"Bu bir ödül. Çünkü...\"\n\"Her seçim yapılmak zorunda değildir.\""
  },
  Event_80635_Name = {
    Text = "Humanity's Toll"
  },
  Event_80636_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80636_Desc = {
    Text = "\"@3 İsyankâr\"\nVızıldayan ses yavaşça zayıflar, ta ki yok olana dek; geriye yalnızca son sözler kalır.\n“İnsanlığın Işığı’nı koruyarak bu zalim dünyada hayatta kalamazsın.”"
  },
  Event_80636_Name = {
    Text = "Karanlık Kurtuluş"
  },
  Event_80637_ChoiceDesc1 = {
    Text = "[Refuse] Bir Komut Kartı İmha Et ve Arg1 Kara Mühür kazan."
  },
  Event_80637_ChoiceDesc2 = {
    Text = "[Comply] Bir Komut Kartını kopyala, ancak [(Skill.Arg1)] Semptomunu geliştir."
  },
  Event_80637_ChoiceDesc3 = {
    Text = "[Embrace] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_80637_Desc = {
    Text = "\"Ben kafese kapatılmış bir kuşum, birçok odadan oluşan bir avluya hapsedilmiş.\"\nKaranlıkta belirsiz silüetler dolaşır—ölülerin Takıntı’larından geriye kalan Kalıntı Nüsha’lar.\n\"Adına akıl hastanesi diyorlar, ama biliyorum ki bu, toplumsal Kurallar’a boyun eğmeyen özgür kuşları tutsak eden, insanlara özgü özel bir kafes.\"\n\"Ama bir kuş uçamıyorsa, hâlâ kuş sayılır mı?\"\nTakıntı’lar etrafında toplanır, Kurtuluş için yalvarır.\n\"Lütfen kanatlarımı Kırılma’ya uğrat, uçmaktan yoruldum.\""
  },
  Event_80637_Name = {
    Text = "İçi Boş İnsan"
  },
  Event_80638_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80638_Desc = {
    Text = "\"...\"\n\"......\"\n\".........\"\nGölge aniden titriyor ve bedenine karışıp eriyor.\n\"Dostum, en kıymetli şeylerini korumak için ilerle.\"\n\"Biz çoktan göçüp gitmiş olsak da, son lütfumuzu sunmaya hâlâ razıyız... senin rüyan için.\""
  },
  Event_80638_Name = {
    Text = "İçi Boş İnsan"
  },
  Event_80639_ChoiceDesc1 = {
    Text = "[Choose Emotion] Arg1 YP Kurtar"
  },
  Event_80639_ChoiceDesc2 = {
    Text = "[Maintain Rationality] Rastgele bir Komut Kartına [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_80639_ChoiceDesc3 = {
    Text = "[Refuse to Choose] 25 Kara Mühür al"
  },
  Event_80639_Desc = {
    Text = "“Seç, seç.”\nKoşarcasına akıp giden karanlıkta sayısız fısıltı yankılandı.\nSes hafifçe hipnotiktir, sende çılgın bir fantazma uyandıran sonsuz bir büyü taşıyormuş gibidir.\nBeyninin deliliğe gömülüp bedenden kıvranarak uzaklaştığını, kalbinin ise bir tür bilinç kazanmış gibi çığlık atıp seni çağırdığını hissediyorsun.\n“Seç, seç.”\n“Akılcılığı mı yoksa duyguyu mu koruyacaksın; bir seçim yapmak zorundasın.”"
  },
  Event_80639_Name = {
    Text = "Humanity's Toll"
  },
  Event_80641_ChoiceDesc1 = {
    Text = "[Scold \"Them\"] Lanetli Kalıntı \"(RelicConfig.Arg2)\" edin, fakat \"(Skill.Arg1)\" geliştir."
  },
  Event_80641_ChoiceDesc2 = {
    Text = "[Drive \"Them\" Away] Gümüş Kalıntılar \"(RelicConfig.Arg2)\" ve \"(RelicConfig.Arg3)\" edin, fakat \"(Skill.Arg1)\"i iki kez geliştir."
  },
  Event_80641_ChoiceDesc3 = {
    Text = "[Attack \"Them\"] Gümüş Kalıntı [(RelicConfig.Arg1)] edin"
  },
  Event_80641_Desc = {
    Text = "\"Küçük William, ne tuhaf,\nMezarlarda yatar, soğuk ve ıssız.\nKimse sevmez onu, uzak dur,\nYoksa bir gün sırtından bıçaklar seni durup dururken.\"\nSilüetler, şekilleri bulanık, bedenleri bükülmüş, küçük çocukların sesleriyle konuşur.\nAlay eder, ilahi söyler gibi tekrarlarken, seni hem tiksintiyle hem de tuhaf bir istekle dolu gözlerle izlerler.\nOnlardan saf, katıksız bir kötülük yayılır."
  },
  Event_80641_Name = {
    Text = "\"Onun\"Çocukluğu"
  },
  Event_90571_ChoiceDesc1 = {
    Text = "[Indulge] destesine 1 [Ruh Bayramı Özel Karışımı] karıştır."
  },
  Event_90571_Desc = {
    Text = "Görkemli bir ziyafet masası, cıvıl cıvıl bir dans pisti, zarif sofra takımları ve cesetlerin ağır kokusu...\nAh, sabırsızlandığını biliyorum, ama lütfen biraz daha bekle, sevgili misafir.\nBu içki, şölenin ev sahibi tarafından özel olarak hazırlanmış, saygın konuklara mahsus bir armağan.\nOnu ellerine al. Yudumla. Ve damağında kalan o izde, kendini bu şenlikli ana bırak!"
  },
  Event_90571_Name = {
    Text = "Ziyafet Öncesi Ritüel"
  },
  Event_91460_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91460_Desc = {
    Text = "Savunmasızsın, sesin içinden geçmesine engel olamıyorsun.\nKeskin bir çığlık beynini ikiye yarıyor ve unutulmuş bir korku dışarı taşıyor—onun açlığını hissediyorsun.\nDehşet verici, yamyam bir yaratık..."
  },
  Event_91460_Name = {
    Text = "Sessiz İtiraf"
  },
  Event_91461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91461_Desc = {
    Text = "Artık kendini tutmuyor, o yakıcı tutkuyu bütünüyle serbest bırakıyorsun; söylenmemiş tüm sözler durmaksızın zihninden fışkırıyor.\nHarika bir kavrayış hissediyor, kendini Pickman’ın yeteneğine kaptırıyorsun."
  },
  Event_91461_Name = {
    Text = "Uyuyan Yanardağ"
  },
  Event_91462_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91462_Desc = {
    Text = "Alevler, mürekkep lekelerinin etrafında kıvrılır, geride bir kan sıçraması izi bırakır.\nO anda, rüya ile gerçekliğin sınırında yere düştün. Kendini küçük bir kıza dönüşmüş, Doresain’in elini tutup onunla dans ederken gördün.\nUyandığında ve Doresain’e yeniden baktığında, ağır bir keder zihnini boğdu."
  },
  Event_91462_Name = {
    Text = "Rüyanın Vahyi"
  },
  Event_91463_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91463_Desc = {
    Text = "İleri atılıyorsun, alevler teninin altına çekilerek yok oluyor. Resme gelince, onu gören herkes için sıradan bir portreden fazlası değil.\nSonraki rüyalarda kendini hep yanarken görüyorsun—mükemmelce kızarmış—ve bir gün kendi yemek masanda servis ediliyorsun."
  },
  Event_91463_Name = {
    Text = "Yanan Portre"
  },
  Event_91464_ChoiceDesc1 = {
    Text = "[Listen] 30 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_91464_ChoiceDesc2 = {
    Text = "[Ignore] Leave"
  },
  Event_91464_Desc = {
    Text = "Sessiz kakofoni içinde, yavaş yavaş kuzgunun sözlerini anlamaya başlarsın..."
  },
  Event_91464_Name = {
    Text = "Sessiz İtiraf"
  },
  Event_91465_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91465_Desc = {
    Text = "Bir taş alıyor ve odaklanmış, kemirici sıçan gölgelerini uyandırıyorsun.\nSana açgözlülükle bakıyorlar.\nBedenlerinden yayılan nemli, pis kokuyu duyumsuyorsun; sanki bir tür alamet gibi."
  },
  Event_91465_Name = {
    Text = "Sürgün Krallığı"
  },
  Event_91466_ChoiceDesc1 = {
    Text = "[Listen] 25 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_91466_ChoiceDesc2 = {
    Text = "[Ignore] Leave"
  },
  Event_91466_Desc = {
    Text = "Seni karşılıyor. Kimi karşılıyor?\nElbette seni!\nBelki de seni yarının leziz yemeği olarak görüyordur."
  },
  Event_91466_Name = {
    Text = "Sessiz İtiraf"
  },
  Event_91467_ChoiceDesc1 = {
    Text = "[Avucu Kes] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazanır: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" bulaşır"
  },
  Event_91467_ChoiceDesc2 = {
    Text = "[Accept Growth] \"(RelicConfig.Arg1)\" adlı Gümüş Kalıntıyı edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_91467_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_91467_Desc = {
    Text = "O kelebek içeri uçmadı; yavaşça avucunun içinden büyüdü.\nÖnce bunun sadece ter olduğunu sandın, ama parmaklarının arasında, damarların tersine akışı gibi sızan siyah bir sıvı gördün; soğuk, atan kanatlara pıhtılaşıyordu.\nHer kanat çırpışında, kan dolaşımında dalgalar yayılır."
  },
  Event_91467_Name = {Text = "Parazit"},
  Event_91468_ChoiceDesc1 = {
    Text = "[Portreyi Kurtar] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte et"
  },
  Event_91468_ChoiceDesc2 = {
    Text = "[Boşluğu Kabul Et] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: \"(EnchantConfig.Arg1)\", \"(Skill.Arg2)\" ile enfekte et"
  },
  Event_91468_ChoiceDesc3 = {
    Text = "[Leave] 25 Kara Mühür al"
  },
  Event_91468_Desc = {
    Text = "Pickman’ın Armağanı’nın önünde durursun.\nBu, kanla boyanmış bir portredir; zifiri siyah alevler sessizce yanmaktadır.\nTablodaki figürün boş göz çukurlarından şunu görürsün—\nKendi Anıların kabarıp yanmakta, uzayıp bükülmekte, parıldamaktadır; sanki biçimsiz bir ateş zihninin koridorlarını yalayıp geçmektedir. Sersemlik içinde bir ses duyarsın.\n \"Pişirme vakti geldi. Isı tam kıvamında.\"\nBu, bizzat senin imal ettiğin anının ta kendisidir—alevlerin içinde kıvranır ve burkulursun."
  },
  Event_91468_Name = {
    Text = "Yanan Portre"
  },
  Event_91469_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91469_Desc = {
    Text = "Cevap vermeyi reddediyor, sessizce titreyişini izliyorsun, ta ki durana dek.\nYıllar içinde, Delilik’e karşı savaşmayı çoktan öğrenmiş bulunuyorsun."
  },
  Event_91469_Name = {
    Text = "Cevapsız Arama"
  },
  Event_91470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91470_Desc = {
    Text = "Bir adım geri çekilip tuvalin alevler içinde yanmasına izin veriyorsun.\nKendi suretinin iştah açıcı bir altın kahverengiye döndüğünü, yağın cızırdayıp çatırdadığını izliyorsun. Sanki tuvalin ardından kızarmış etin kokusunu alabiliyormuşsun gibi.\nDoresain’in hissettiği cazibe bu mu?"
  },
  Event_91470_Name = {
    Text = "Yanan Portre"
  },
  Event_91471_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91471_Desc = {
    Text = "Neredeyse kutsala saygısızlık sayılacak bir merakla ya da belki de bilinmeyene göğüs germek için duyduğun umarsız bir cesaretle, Geçmişin Gölgeleri'nin içinde bir vahiy arıyorsun.\nYüzü seçilemeyen uzun bir adamla dans eden bir kız görüyorsun, ve açıklanamaz bir sevinç kalbini dolduruyor."
  },
  Event_91471_Name = {
    Text = "Geçmişin Gölgeleri"
  },
  Event_91472_ChoiceDesc1 = {
    Text = "[End Record] Herhangi 2 Kartı İmha Et"
  },
  Event_91472_ChoiceDesc2 = {
    Text = "[Continue Writing] \"(RelicConfig.Arg1)\" Lanetli Kalıntısını edin, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_91472_ChoiceDesc3 = {
    Text = "[Leave] Arg1 Kara Mühür al"
  },
  Event_91472_Desc = {
    Text = "Sonunda geçici de olsa gulyabanilerin pazarından sıyrılmayı başarıp, her zamanki gibi kayda başlamak için sakin bir köşe buldun.\nDaktilo aniden şiddetle titremeye başladı; tuşları kendi kendine inip kalkıyor, aralıklarından siyah, koyu bir sıvı fışkırıyor, parmak uçlarına sıçrayıp sağduyunu iliklerine kadar ıslatıyordu.\nKâğıdın üzerinde yavaş yavaş beliren, giderek canlılaşan bir kelebek gölgesi gördün..."
  },
  Event_91472_Name = {
    Text = "Kelebek Gölgeleri"
  },
  Event_91473_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91473_Desc = {
    Text = "Tuhaf bir şekilde, hiç öğrenmediğin bir dil olmasına rağmen, anlamını bir şekilde kavrıyorsun.\nDizeler, sevdiklerine duyulan özlemle dolu; yaşamı ve ölümü aşan bir özlem bu, senin rüyan aracılığıyla sana iletilmiş.\nŞiirin sonundaki el yazısını belli belirsiz tanıyorsun—\nCelina'nınki bu."
  },
  Event_91473_Name = {
    Text = "Rüyanın Vahyi"
  },
  Event_91474_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91474_Desc = {
    Text = "Avucunun derisini yararken acıya tahammül eder, yeni filizlenmiş kanatlı eti alevle yakıp yok edersin.\nSiyah sıvı buharlaşır ve kelebekler paramparça olur.\nHer şey tertemiz ve lekesiz hâle gelir, yine de avucunda hafif bir kanat çırpma hissi duymadan edemezsin; sanki asla tam anlamıyla kuluçkadan çıkmamış bir düşüncenin kalıntısı hâlâ damarlarında ağır ağır nefes alıyordur.\nDoresain bu konuda hiçbir yorum yapmaz, yalnızca geride bıraktığın kanı alır."
  },
  Event_91474_Name = {Text = "Parazit"},
  Event_91475_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91475_Desc = {
    Text = "O ateşli Kavrayış’ın her zaman Felaket’e yol açtığını biliyorsun, bu yüzden her şeyi aklınla mühürlüyorsun."
  },
  Event_91475_Name = {
    Text = "Uyuyan Yanardağ"
  },
  Event_91476_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91476_Desc = {
    Text = "Göz’e dikkatle bakar, iletmeye çalıştığı mesajı çözmeye uğraşırsın.\nUzun zamandır savaşla yoğrulmuş olsan da, bu kez Golyat’la yüz yüze gelirken... korku kalbini kavrar.\n\"Neredeyse Normal— Felaket gerçekleşmeden önceki en sessiz biçimdir.\""
  },
  Event_91476_Name = {
    Text = "Neredeyse Normal"
  },
  Event_91477_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91477_Desc = {
    Text = "Gözlerini kapatıyor ve vahşi doğaya doğru yürümek için arkanı dönüyorsun.\nGizli arzuyu ve alameti hissedebiliyorsun, ama bunu kendi ellerinle asla dindiremeyeceksin.\nAdsız mezar taşlarına bakınıyorsun. Belki de hikâyen böyle sona erer."
  },
  Event_91477_Name = {
    Text = "Kuzgunların Şöleni"
  },
  Event_91478_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91478_Desc = {
    Text = "Başını yavaşça kaldırıyorsun. O anda, ışık gözbebeklerini delerken, yakıcı bir sıcaklık zihninin içinde bir boşlukta filizleniyor.\nNecrovia’nın yıldızları, başka yerlerdekilerden farklı değil; yine de, görünüşte ebedi olan gulyabaniler bile yalnızca bu yıldızların altında, özgürlükten yoksun yaşayabiliyor."
  },
  Event_91478_Name = {
    Text = "Yıldızlar Gecesi"
  },
  Event_91479_ChoiceDesc1 = {
    Text = "[Throw into the Flames] Bir Kartı İmha Et"
  },
  Event_91479_ChoiceDesc2 = {
    Text = "[Attempt Interpretation] \"(RelicConfig.Arg1)\" Kalıntısını elde et, fakat \"(Skill.Arg2)\" Semptomunu geliştir."
  },
  Event_91479_Desc = {
    Text = "Bilinç, sonsuz bir kara sis denizinde süzülüp sürüklenir; sayısız canlı ve ölü ruhun zihinsel manzaralarından geçip gider.\nSenin rüyanda, tuhaf bir daktilo, yabancı dizelerden oluşan bir geçit üretir. Kimin hikâyesidir bu?\nBilinmeyen kökenli bir kâğıda damgalanmıştır; çarpık el yazısı, ayık bir sarhoşun yazısını andırır.\nRüyanın içindeki tarif edilemez bir dürtüyle kâğıdı eline alırsın—mürekkep, ocağın titreşen ışığında dans eder."
  },
  Event_91479_Name = {
    Text = "Rüyanın Vahyi"
  },
  Event_91480_ChoiceDesc1 = {
    Text = "[Apply] Yadigâr \"(EnchantConfig.Arg2)\"i rastgele bir Komut Kartına kazı, fakat \"(Skill.Arg1)\" geliştir."
  },
  Event_91480_ChoiceDesc2 = {
    Text = "[Drive] Yadigâr \"(EnchantConfig.Arg2)\"i rastgele bir Komut Kartına kazı, fakat \"(Skill.Arg1)\" geliştir."
  },
  Event_91480_ChoiceDesc3 = {
    Text = "[Ostracise] Yadigâr [(EnchantConfig.Arg1)]i rastgele bir Komut Kartına kazı."
  },
  Event_91480_Desc = {
    Text = "Uzaklardan gelen hafif bir kemik borusu sesi duyarsın.\nSiyah çamurdan, sesin çekimine kapılmış sıçan sürüleri çıkar; kurumuş nehir yatağında yatan isimsiz cesedi kemirmeye başlar.\nBir çember oluştururlar—merkezde içi boş kalıntı beden, çevresinde ise unutuş yasasıyla yönetilen yeni bir krallığın sınırları vardır.\nVe sen, bu krallığın eşiğinde durmaktasın."
  },
  Event_91480_Name = {
    Text = "Sürgün Krallığı"
  },
  Event_91481_ChoiceDesc1 = {
    Text = "[Look Up] [(RelicConfig.Arg1)] adlı Gümüş Kalıntıyı elde et."
  },
  Event_91481_ChoiceDesc2 = {
    Text = "[Black Sigil] 75 Kara Mühür kazan, ancak [(Skill.Arg2)] Semptomunu geliştir"
  },
  Event_91481_Desc = {
    Text = "Kargalar gökyüzünde tereddütlü bir testere gibi dönüp duruyor, göklerin omurgasını tekrar tekrar kesiyor.\nAlçaktan, çevrende uçuyorlar; sanki ölümünü önceden görmüşler de sabırla şölenin başlamasını bekliyorlar."
  },
  Event_91481_Name = {
    Text = "Kuzgunların Şöleni"
  },
  Event_91482_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91482_Desc = {
    Text = "\"Onun yazmayı sürdürmesine izin veriyorsun; nabzınla, acı duyunla, geçmişinle ve hayalinle.\nKelebek, kâğıdın bağlarından kurtuluyor ve ruhun da uçuşuna eşlik ediyor.\nKendini lunaparkta eğlenirken hayal etmeye başlıyorsun. Doresain'e söylemediğin şey şu ki, aslında lunaparkları gerçekten seviyorsun—ceset temalı bile olsa...\nUmarım... fazla tuhaf değildir.\""
  },
  Event_91482_Name = {
    Text = "Kelebek Gölgeleri"
  },
  Event_91483_ChoiceDesc1 = {
    Text = "[Reobserve] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_91483_Desc = {
    Text = "Bir zamanlar berrak olan akşam yemeği, kanlı, seçilmez bir şölene dönüşmüş.\nOcaktaki malzemeleri ve çürümüşlüğün burun direğini sızlatan kokusunu hatırlıyorsun.\nKorku kalbini kavrıyor—bir seçim yapmak zorundasın."
  },
  Event_91483_Name = {
    Text = "Geçmişin Gölgeleri"
  },
  Event_91484_ChoiceDesc1 = {
    Text = "[Ignore the Ring] 3 İleri Yakarıştan 1’ini Oyarak Kazı"
  },
  Event_91484_ChoiceDesc2 = {
    Text = "[Pick up the Receiver] Altın Kalıntı \"(RelicConfig.Arg1)\" elde et, ancak \"(Skill.Arg2)\" geliştir"
  },
  Event_91484_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_91484_Desc = {
    Text = "Çalmamış olması gerekirdi—tuvalin arkasına kıvrılmış telefonun.\nKordon, paslanmış bir göbek bağı gibi, hantal makinenin gövdesine dolanmış; sanki senin zihninden uzanıyormuş gibi.\nTitreşimin frekansını dikkatle ayırt ediyorsun; tedirgin edici ses, Pickman’ın sürreal sanatını andırıyor."
  },
  Event_91484_Name = {
    Text = "Cevapsız Arama"
  },
  Event_91485_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91485_Desc = {
    Text = "Soğuk beyni beşiğine alırsın, fakat bir an içinde suya dönüşür, sessizce parmaklarının arasından süzülür.\nTerazi anında Denge’yi yitirir ve kalp çürük bir meyve gibi çöker, sessiz, kara bir su birikintisine çözünür.\nTüm açlık yok olur; artık ürpertici bir sükûnete, pişmansızlığa ve gelip geçen bir berraklığa sahipsin."
  },
  Event_91485_Name = {
    Text = "Açlık Oyunları"
  },
  Event_91486_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91486_Desc = {
    Text = "Ses yok, yanıt yok. Sadece bir şaka mıydı?\nAhizeyi yerine koyarken, ağır bir duygu yeniden içine hücum ediyor."
  },
  Event_91486_Name = {
    Text = "Cevapsız Arama"
  },
  Event_91487_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91487_Desc = {
    Text = "Kuzgun kayboluyor.\nAma başka bir gecenin aynasında, bu kuzguna bakarken kendini görüyorsun.\nHâlâ sessizce çığlık atıyor, sanki senin cevabını bekliyormuş gibi."
  },
  Event_91487_Name = {
    Text = "Sessiz İtiraf"
  },
  Event_91488_ChoiceDesc1 = {
    Text = "[Reobserve] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_91488_ChoiceDesc2 = {
    Text = "[Give Up] [(Skill.Arg1)] Semptomunu geliştir ve kazınacak Yakarışı değiştir.(Kullanım: 1/2)"
  },
  Event_91488_Desc = {
    Text = "Kararlılıkla bakışlarını kaçırıyorsun, ama o imgeler Görüş Alanı’nda hayaletler gibi oyalanıyor...\nBu, hüzünlü bir düettir."
  },
  Event_91488_Name = {
    Text = "Geçmişin Gölgeleri"
  },
  Event_91489_ChoiceDesc1 = {
    Text = "[Consume] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_91489_ChoiceDesc2 = {
    Text = "[Decline] [(Skill.Arg1)] Semptomunu geliştir ve kazınacak Yakarışı değiştir.(Kullanım: 2/2)"
  },
  Event_91489_Desc = {
    Text = "Bu, Doresain tarafından senin zahmetli soruşturman için özenle hazırlanmıştı.\nBaharat kullanılmamış olmasına rağmen kokusuz; Doresain’in dediği gibi, bu en seçkin malzeme.\nŞölen senin için kurulmuş, beyin tabakta sessizce yatıyor.\n \"Tatmak ister misin?\""
  },
  Event_91489_Name = {
    Text = "Lezzetin Tadını Çıkar"
  },
  Event_91490_ChoiceDesc1 = {
    Text = "[Listen] 40 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_91490_ChoiceDesc2 = {
    Text = "[Disregard] 25 Kara Mühür al ve ayrıl."
  },
  Event_91490_Desc = {
    Text = "Bu bir kuzgun.\nKafatası biçimli bir lambanın tepesinde duruyor, gagasını açıyor ama hiçbir ses çıkmıyor."
  },
  Event_91490_Name = {
    Text = "Sessiz İtiraf"
  },
  Event_91491_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91491_Desc = {
    Text = "Elini yavaşça hâlâ sıcak olan kalbe uzatırsın; kalp atar ve kasılır, sonunda hoş kokulu bir sıcaklık bulutuna dönüşerek dağılır.\nTerazi şiddetle sarsılır ve beynin sonsuz Karanlığa yuvarlanır.\nDoygunluk duygusu açlığın yerini alır ve tutkuyu, acıyı ve gerçek Anı’yı kavrarsın."
  },
  Event_91491_Name = {
    Text = "Açlık Oyunları"
  },
  Event_91492_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91492_Desc = {
    Text = "Başını yukarı kaldırıyor, sessiz devinimi kabul ediyorsun; kadim bir ayindeki bir hacı gibi.\nNeşeyle etini kemiriyorlar; acı duyuyorsun, ama aynı zamanda bir açıklık.\nYitirdiğin benliğini—ölememiş parçalarını—nihayet alıp götürdüklerini görüyorsun.\nBilinç geri döndüğünde, kendini sapasağlam buluyorsun."
  },
  Event_91492_Name = {
    Text = "Kuzgunların Şöleni"
  },
  Event_91493_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91493_Desc = {
    Text = "Anıları ve duygulardan yapılmış bir harçla anahtar deliğini mühürledin, gerçeği seni ayartma gücünden mahrum bıraktın.\nSanki azılı bir düşmanla yüzleşiyormuşsun gibi takındığın tavrı gören Doresain dudaklarını yaladı.\n\"Bir kez daha denemek ister misiniz? Bu, yalnızca {Male=Bay,Female=Bayan} Koruyucu için özel olarak hazırlanmış Beyin Yaprağı Mozzarellası.\""
  },
  Event_91493_Name = {Text = "Vahiy"},
  Event_91494_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91494_Desc = {
    Text = "Aslında bir gulyabani olmanın nasıl bir his olduğu hepini merak etmişsindir.\n \"Öyleyse sıçan sürüsünün içine adım atar ve onlardan biri olursun—\"\nKabul etmelisin, Denizci’nin varışı zihnini biraz bulandırdı."
  },
  Event_91494_Name = {
    Text = "Sürgün Krallığı"
  },
  Event_91495_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91495_Desc = {
    Text = "Bozulma ve kaos tarafından kirletilmeyi reddediyorsun.\nOna çoktan alıştın; tüm çürüme sana artık olağan görünüyor."
  },
  Event_91495_Name = {
    Text = "Sürgün Krallığı"
  },
  Event_91496_ChoiceDesc1 = {
    Text = "[Consume] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_91496_ChoiceDesc2 = {
    Text = "[Decline] [(Skill.Arg1)] Semptomunu geliştir ve kazınacak Yakarışı değiştir.(Kullanım: 1/2)"
  },
  Event_91496_Desc = {
    Text = "Doresain sana zarifçe bir parça \"beyin\" keser.\nO tatlı lezzet...\nO yumuşak ve narin doku...\nBir ısırık daha almak istiyorsun."
  },
  Event_91496_Name = {
    Text = "Lezzetin Tadını Çıkar"
  },
  Event_91497_ChoiceDesc1 = {
    Text = "[I'm Dreaming] Gümüş Kalıntı [(RelicConfig.Arg1)] elde et"
  },
  Event_91497_ChoiceDesc2 = {
    Text = "[This is Not Normal] Altın Kalıntı \"(RelicConfig.Arg1)\" elde et, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_91497_Desc = {
    Text = "Pürüzsüz bir mezar taşı, yavaşça bozulan bir gözü yansıtır.\nSanki görsel tasvirin ötesinde bir imge taşıyormuşçasına, sana ait olmayan bir hafıza, gözlerinin kıvrımlarına derinlemesine yerleşmiştir.\nGöz kırpıp onu silmeye, parmak ucunla kazımaya çalışırsın, ama o göz artık sana ait değildir—bir hayal âlemini andıran, bin parçalı bir sahneyi yansıtmaya başlar."
  },
  Event_91497_Name = {
    Text = "Neredeyse Normal"
  },
  Event_91498_ChoiceDesc1 = {
    Text = "[Continue Observation] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_91498_ChoiceDesc2 = {
    Text = "[Look Away] [(Skill.Arg1)] Semptomunu geliştir ve kazınacak Yakarışı değiştir.(Kullanım: 2/2)"
  },
  Event_91498_Desc = {
    Text = "Kadim kalenin nemli bir köşesinde, o film rulosunu keşfettin.\nGörüntüler, zaman nehrinde boğulmuş hayaletlere benzer; ağır çekimde donup kalırlar—kimi zaman tarif edilemez, devasa biçimlere genişler, kimi zaman titreşen yıldızlara çöküşürler.\nOnların içinde kaybolmuşken, aniden bastıran bir baş dönmesi, sana zamanın geçişini hatırlattı."
  },
  Event_91498_Name = {
    Text = "Geçmişin Gölgeleri"
  },
  Event_91499_ChoiceDesc1 = {
    Text = "[Gaze at the Stars] Altın Kalıntı \"(RelicConfig.Arg1)\" edin, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_91499_ChoiceDesc2 = {
    Text = "[Close Your Eyes] Rastgele 2 Uyandırıcıyı Uyanış’a çağır, ancak [(Skill.Arg1)] becerisini iki kez geliştir."
  },
  Event_91499_ChoiceDesc3 = {
    Text = "[Leave] 50 Kara Mühür al"
  },
  Event_91499_Desc = {
    Text = "Yıldızların varlığının geceyi gündüz kadar aydınlattığı, ıssız bir mezarlıkta durursun.\nZamanın dipsiz derinliklerinde yüzen ışık küreleri sessizdir, fakat rüyanın içindeki mırıltılar kadar sonsuz döngülerle yavaşça birleşirler.\nOnlar, unutulmuş, yalnız yıldızı seyreder.\nO, seni seyreder; tüm ölümü ve ebediyeti seyreder."
  },
  Event_91499_Name = {
    Text = "Yıldızlar Gecesi"
  },
  Event_91500_ChoiceDesc1 = {
    Text = "[Listen] 20 Kara Mühür al, fakat [(Skill.Arg2)] geliştir."
  },
  Event_91500_ChoiceDesc2 = {
    Text = "[Ignore] Leave"
  },
  Event_91500_Desc = {
    Text = "Göz göze geliyorsunuz.\nZifiri karanlıkta, açgözlü bir yangının parıltısını görüyorsun."
  },
  Event_91500_Name = {
    Text = "Sessiz İtiraf"
  },
  Event_91501_ChoiceDesc1 = {
    Text = "[Open Socket] Lanetli Kalıntı \"(RelicConfig.Arg1)\"yı elde et, ancak \"(Skill.Arg2)\" geliştir."
  },
  Event_91501_ChoiceDesc2 = {
    Text = "[Kilidi Kapat] Rastgele 1 Kart Mühür kazanır: [(EnchantConfig.Arg1)]"
  },
  Event_91501_Desc = {
    Text = "Doresain sana beyin lobunu uzatırken birkaç kez direniyorsun, ama sonunda Bilgi’nin cazibesine karşı koyamıyorsun.\nHikmet yavaş yavaş gelmiyor; birdenbire, sağanak gibi üzerime boşalıyor.\nBaşın zonklamaya başlıyor, düşüncelerin kabaran hamur gibi şişiyor. Sonunda yere yığıldığında, acı çekilen bir gelgit gibi çekiliyor ve bilincinde boş, kadim bir anahtar deliği bırakıyor.\nDemek Bilgi’nin şekli bu! Eşi benzeri görülmemiş bir bilgelik dalgası hissediyorsun.\nBelki de... daha fazlasını elde edebilirsin?"
  },
  Event_91501_Name = {Text = "Vahiy"},
  Event_91502_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91502_Desc = {
    Text = "Bilinç bıçağının geride kalan ucu ile o anahtar deliğine sızdın.\nAnahtarın ne olduğunu bilmiyordun, bu yüzden yalnızca takıntına güvenerek bir girişimde bulundun.\nO anda, düşüncelerin tamamen yanıp tükendi; boş anahtar deliğinin içinde, insana ait olmayan bir şeyin fısıltısı kaldı yalnızca.\nVahiy böyle bir şey mi hissettirir? Bunu hevesle Doresain’le paylaştın.\n \"Denemek ister misiniz? Bu, yalnızca {Male=Bay, Female=Bayan} Koruyucu’ya özel, özel üretim bir beyinli mozzarella.\""
  },
  Event_91502_Name = {Text = "Vahiy"},
  Event_91503_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91503_Desc = {
    Text = "Ne patlatıyor ne de bastırıyorsun.\nKendinden sıyrılmış ince bir gözlem durumunda, kabaran düşüncelere hava durumunun değişimiymiş gibi bakıyor, onların doğal hâlde bilinmeyen bir sonuca akmasına izin veriyorsun.\nKan ve etten oluşan tabloda, sonsuzluğun sanatını takdir etmeye başlıyorsun."
  },
  Event_91503_Name = {
    Text = "Uyuyan Yanardağ"
  },
  Event_91504_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91504_Desc = {
    Text = "Tuşlar aniden duruyor ve kelebek gölgeleri bir anda yok oluyor.\nBu bir düş müydü? İçini bir yoksunluk duygusu kaplıyor.\nBelki de Doresain’i dinleyip hafıza konservecisinden biraz beyin yaprağı almalıyım.\n \"Hayır, ne düşünüyorum ben?\""
  },
  Event_91504_Name = {
    Text = "Kelebek Gölgeleri"
  },
  Event_91505_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91505_Desc = {
    Text = "Çırpınmayı bırakıyor, kanatların ve siyah sıvının avucunu delip geçmesine izin veriyorsun.\nOnun kabı oluyorsun; seni bir kabuk gibi kullanarak düşüncelerini sürdürmeye devam ediyor.\nKelebek büyüdükçe büyüyor, ta ki artık ağırlığına tahammül edemeyene dek.\nBunu gören Doresain, iştahla elindeki yemek bıçağıyla seninle kelebek arasındaki bağı kesiyor. Gözlerindeki açlık dolu bakış, Arzu’sunu apaçık ele veriyor...\nOnun isteğini reddediyorsun."
  },
  Event_91505_Name = {Text = "Parazit"},
  Event_91506_ChoiceDesc1 = {
    Text = "[Listen] 35 Kara Mühür al, [(Skill.Arg2)] geliştir ve seçmeye devam et."
  },
  Event_91506_ChoiceDesc2 = {
    Text = "[Ignore] Leave"
  },
  Event_91506_Desc = {
    Text = "Sessiz olduğunu sanmıştın, ta ki bilincin aniden kayıp da sayısız karganın kafatası zihninin içinde çığlık atıyormuş gibi olana dek.\nYere diz çöküyorsun, dünya gözlerinin önünde dönüyor."
  },
  Event_91506_Name = {
    Text = "Sessiz İtiraf"
  },
  Event_91507_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91507_Desc = {
    Text = "Gözlerini kapatıp sonsuz, yumuşak bir toz sisine adım atarsın; bulutsu seni kucaklar ve sen biçimini yitirirsin—bedeninden daha kalıcı bir varlık, içine yerleşir.\nO gece, yıldızlar her zamanki parlaklıklarıyla dönmeyi sürdürdü.\nÖlümsüz bir varlık için, yıldızlı gökyüzü ne ifade eder? Belki gidip Doresain’e sormalısın."
  },
  Event_91507_Name = {
    Text = "Yıldızlar Gecesi"
  },
  Event_91508_ChoiceDesc1 = {
    Text = "[Consume] 3 Komut Kartından 1’ine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_91508_Desc = {
    Text = "Meğer peynir çıkıyor. Rahatlama hissederken, içinde hafif bir pişmanlık da beliriyor."
  },
  Event_91508_Name = {
    Text = "Lezzetin Tadını Çıkar"
  },
  Event_91509_ChoiceDesc1 = {
    Text = "[Ignite] Gümüş Kalıntı \"(RelicConfig.Arg2)\"yı elde et, ancak \"(Skill.Arg1)\" geliştir."
  },
  Event_91509_ChoiceDesc2 = {
    Text = "[The Vigil] Gümüş Kalıntı \"(RelicConfig.Arg2)\"yı elde et, ancak \"(Skill.Arg1)\" geliştir."
  },
  Event_91509_ChoiceDesc3 = {
    Text = "[Sealed] 25 Kara Mühür al"
  },
  Event_91509_Desc = {
    Text = "Bakışlarını Pickman’ın tablosuna sabitliyorsun ve çürümenin mide bulandırıcı kokusu seni sersemletiyor.\nDüşünceler zihninden yavaşça yükseliyor—önce yalnızca ısı, sonra sis ve ardından—"
  },
  Event_91509_Name = {
    Text = "Uyuyan Yanardağ"
  },
  Event_91510_ChoiceDesc1 = {
    Text = "[Touch the Brain] Rastgele bir Komut Kartı üzerine [(EnchantConfig.Arg1)] Yakarışını kazı."
  },
  Event_91510_ChoiceDesc2 = {
    Text = "[Touch the Heart] Maksimum HP’yi Arg1 kadar artır, ancak [(Skill.Arg2)] Semptomunu geliştir."
  },
  Event_91510_Desc = {
    Text = "Hiçbir fısıltının oyalanmadığı, sessiz, gri salona adım atarsın ve karanlık sise karışmış solgun bir terazi belirir.\nSolda, göl kadar sakin bir beyin vardır; gümüş beyazı kıvrımları hafifçe parıldar; sağda ise, kızıl bir kalp sıcak sıcak buhar salar.\nAnsızın, burnuna hoş bir koku gelir. Doymak bilmez bir arzu içinde kabarır, aklın Onun sınırsız Karanlığı tarafından sıkıştırılır.\nElini uzatırsın."
  },
  Event_91510_Name = {
    Text = "Açlık Oyunları"
  },
  Event_91511_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91511_Desc = {
    Text = "Bu bir rüya olmalı, diye diye kendini ikna ediyorsun.\nFarkına varmadan gerçekten uykuya dalmışsın.\nBelki de son zamanlarda fazla içli dışlı olduğun için, rüyanda Doresain’i görüyorsun—isteyerek Doresain’in kendi kanını ve etini yemesine izin veriyorsun? Ne tür bir dehşet hikâyesi bu?"
  },
  Event_91511_Name = {
    Text = "Neredeyse Normal"
  },
  Event_91660_ChoiceDesc1 = {
    Text = "[Farklı Bir Yol] 3 Komut Kartı arasından 1 tanesini seçerek Mühür kazan: [(EnchantConfig.Arg1)]"
  },
  Event_91660_ChoiceDesc2 = {
    Text = "[Let It Be] Rastgele 3 Komut Kartına \"(EnchantConfig.Arg1)\" Yakarışını kazı, fakat \"(Skill.Arg2)\" geliştir."
  },
  Event_91660_Desc = {
    Text = "\"Ruhu sür—ölüleri sona kadar götürmelisin.\"\nDoresain konuşurken, aniden bir aydınlanma yaşarsın.\nBu ne bilgi, ne de anıdır—daha çok bir ağırlık gibidir; gözlerinden içeri sızar, bir sel gibi zihnini doldurur.\nDuyguların artık bu ana ait değilmiş gibi gelir; geri çekilir ve evrenin gözden kaçırdığı bir yarığı açığa çıkarır.\nAlgılayabildiğin her şey tam orada durur, sanki bir patikanın sonuna varmışsın gibi."
  },
  Event_91660_Name = {Text = "Ruhun Sonu"},
  Event_91661_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91661_Desc = {
    Text = "Ruhunun uzaklara sürüklenmesine izin veriyorsun.\n \"Benlik\" sınırında, ölülerin fısıltısını duyar gibi oluyorsun.\nAma dikkat kesilip dinlediğinde, her şey yok olup gidiyor."
  },
  Event_91661_Name = {Text = "Ruhun Sonu"},
  Event_91662_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91662_Desc = {
    Text = "Bilinçini sarıp sarmaladın, böylece kendini bilinmeyen ayartılardan yalıttın.\nRuhunun ucunda kayboldun, yalnızca kendini görüyordun.\nBeklendiği gibi, yaşayan biri olarak bir gulyanın yeteneklerine sahip olamazsın."
  },
  Event_91662_Name = {Text = "Ruhun Sonu"}
})
return Text_Event
