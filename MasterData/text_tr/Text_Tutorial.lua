__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Tutorial = readonly({
  Tutorial_120371_Desc_1 = {
    Text = "Savaşta son 25 turdan herhangi birine geri dönebilirsin."
  },
  Tutorial_120371_Title_1 = {
    Text = "Zaman Akışı Tersine Dönüş"
  },
  Tutorial_124999_Desc_1 = {
    Text = "<TutorialHighlight:Traphase-Sıralı Seçim Modu> modunda, önceden bir ekip kurmaya gerek kalmadan eşleştirmeye girmek için arayüzün sağ alt köşesindeki “Eşleştirmeyi Başlat”a tıkla."
  },
  Tutorial_124999_Desc_2 = {
    Text = "Maç başlamadan önce, yaklaşan savaşı etkilemek üzere rastgele bir <TutorialHighlight:Kalıntı> seçilir. Ardından oyuncular, sınırlı bir havuzdan Uyandırıcılar, Kader Çarkları ve Çeteleri sırayla seçerek dizilimlerini kurarlar. Stratejinizi ayarlamak için, konumlarını(önden arkaya 1-4 olarak numaralandırılmıştır) değiştirmek istediğiniz iki Uyandırıcıya tıklayın."
  },
  Tutorial_124999_Desc_3 = {
    Text = "Dizilimini ayarlamak için, konumlarını değiştirmek üzere herhangi iki Uyanışçıya tıkla(önden arkaya 1-4 olarak numaralandırılmıştır)."
  },
  Tutorial_124999_Title_1 = {
    Text = "Sıralı Seçim Modu Kadrosu"
  },
  Tutorial_126878_Desc_1 = {
    Text = "Belirli Uyandırıcıların Kişilik Derinleşmesi +12’ye ulaştığında, her Uyandırıcıya göre değişen \"Mutlak Aksiyom\" etkisini kendiliğinden kazanırlar."
  },
  Tutorial_126878_Desc_2 = {
    Text = "Uyandırıcının \"Mutlak Aksiyom\"unu açtıktan sonra, Uyandırıcıdan sana özel bir mesaj ulaşacak. Mutlaka göz atmayı unutma."
  },
  Tutorial_126878_Title_1 = {
    Text = "Mutlak Aksiyom"
  },
  Tutorial_126878_Title_2 = {
    Text = "Münhasır Mesaj"
  },
  Tutorial_148475_Desc_1 = {
    Text = "Uyandırıcının Afinitesi <TutorialHighlight:Lv20> seviyesine ulaştıktan sonra özel <TutorialHighlight:Scintilla> kazanılabilir."
  },
  Tutorial_148475_Desc_2 = {
    Text = "<TutorialHighlight:Scintilla>, sen ve Uyandırıcı arasındaki Kutsal Birliğin kanıtıdır."
  },
  Tutorial_148475_Desc_3 = {
    Text = "Artık bu Uyandırıcının Komut Kartı savaşta özel bir görünümle sunulacak ve sosyal ortamlarda diğer Koruyuculara gösterilebilecek."
  },
  Tutorial_148475_Title_1 = {
    Text = "Kutsal Birlik"
  },
  Tutorial_17805_Desc_1 = {
    Text = "Bir düşmana dokunarak tüm durumlarını görüntüleyebilirsin. <TutorialHighlight:Uyarı> durumları, benzersiz düşman mekaniklerini temsil ettikleri için özel dikkat gerektirir. Koruyucuların soruşturmaları tamamlayamamasının başlıca nedenleri çoğunlukla bu mekaniklerin göz ardı edilmesidir."
  },
  Tutorial_17805_Title_1 = {
    Text = "Düşman Durumu"
  },
  Tutorial_17806_Desc_1 = {
    Text = "Bir düşmanı yendikten sonra, <TutorialHighlight:Yakarış> kullanmayı ya da <TutorialHighlight:D-iz>’de <TutorialHighlight:Kara Mühür> harcayarak alışveriş yapmayı seçebilirsin. Yakarış, belirli Komut Kartlarına farklı ek etkiler bahşeder. Her bir belirli Komut Kartı en fazla <TutorialHighlight:1> kez Yakarış ile işlenebilir. Etkiyi en üst düzeye çıkarmak için Yakarışları en sık oynadığın Komut Kartlarına uygula."
  },
  Tutorial_17806_Title_1 = {Text = "Yakarış"},
  Tutorial_17807_Desc_1 = {
    Text = "Uyandırıcı için birden fazla nitelik sağlar. Bir <TutorialHighlight:set> oluşturulduğunda özel efektler tetiklenir. Her biri farklı <TutorialHighlight:ana niteliklere> sahip 6 parça bulunur. Kritik Oranı ve Kritik Hasar I, II ve III numaralı parçalarda; Aliemus Yenilenme Seviyesi ve Gümüş Anahtar Şarjı Seviyesi I, IV ve V numaralı parçalarda; Diyar Ustalığı ve Mühür Hasadı II, IV ve VI numaralı parçalarda; Hasar Güçlendirmesi ve Direnç III, V ve VI numaralı parçalarda görünür."
  },
  Tutorial_17807_Title_1 = {Text = "Ahit"},
  Tutorial_17808_Desc_1 = {
    Text = "<TutorialHighlight:Hayali Dalış> oynanışında, her sahneye meydan okuduğunuzda rastgele bir haritaya girersiniz. Meydan okumayı başarıyla tamamladıktan sonra, sahnenin zorluğuna, güçlendirilmiş Uyananlara ve sahne içindeki puanlama öğelerine göre karşılık gelen puanları kazanırsınız. Her haftanın meydan okumalarında, farklı başlangıç relikleri ve farklı güçlendirilmiş Uyananlar bulunur."
  },
  Tutorial_17808_Desc_2 = {
    Text = "<TutorialHighlight:Keşif Sıralaması>, haftalık meydan okumalarda elde edilen en yüksek puanlara göre sıralanır ve keşif sıralaması her hafta sonuçlandırılarak ilgili ödüller dağıtılır. <TutorialHighlight:Sezon Sıralaması>, sezon boyunca elde edilen en yüksek puanlara göre sıralanır."
  },
  Tutorial_17808_Desc_3 = {
    Text = "Derin Dalış Kaydı’nın birden fazla hedefi vardır ve tamamlandıklarında ödüller elde edilebilir. Her “Derin Dalış Kayıtları” hedefini tamamladığınızda veya bir P-Dalış meydan okumasını kazandığınızda, <TutorialHighlight:Derin Dalış TP> kazanırsınız. Derin Dalış TP’niz belirli bir değere ulaştığında, <TutorialHighlight:Derin Dalış Seviyesi> artar ve çeşitli ödüller almanızı sağlar. “Derin Dalış Kaydı”nızı ve “Derin Dalış Seviyesi”nizi arayüzün sol alt köşesinden kontrol edebilirsiniz."
  },
  Tutorial_17808_Title_1 = {
    Text = "Hayali Dalış"
  },
  Tutorial_17809_Desc_1 = {
    Text = "Etkinlikler ve D-İşaretleri aracılığıyla <TutorialHighlight:Relic> elde edebilirsin. Bu Kalıntılar, takımının savaş yeteneklerini güçlendirebilir. Usta Koruyucular, takımlarının ihtiyaçlarına göre daha uygun <TutorialHighlight:Relic> seçer."
  },
  Tutorial_17809_Title_1 = {Text = "Kalıntı"},
  Tutorial_17810_Desc_1 = {
    Text = "Sisi dağıtır, harita görüşünü <TutorialHighlight:2> karo artırır ve daha iyi Rota Planlama sağlar."
  },
  Tutorial_17810_Title_1 = {Text = "Projektör"},
  Tutorial_17811_Desc_1 = {
    Text = "<TutorialHighlight:Zehirlenmiş> durumundaki hedefler, turun sonunda sahip oldukları <TutorialHighlight:Zehir> yığını sayısına eşit hasar alır. <TutorialHighlight:Zehir> hasarı <TutorialHighlight:kritik vuramaz>."
  },
  Tutorial_17811_Title_1 = {Text = "Zehir"},
  Tutorial_17812_Desc_1 = {
    Text = "<TutorialHighlight:Savunmasız> durumundaki hedefler %50 fazladan Hasar alır ve turun sonunda otomatik olarak 1 <TutorialHighlight:Savunmasız> yığını kaybeder. Düşmanların <TutorialHighlight:Savunmasız> durumundan yararlanarak daha büyük Hasar verin."
  },
  Tutorial_17812_Title_1 = {
    Text = "Savunmasız"
  },
  Tutorial_17813_Desc_1 = {
    Text = "\"Çözünme Harabeleri\", \"Yasak Ahitname\" ve \"Gizemli Hakimiyet\" Aşamalarını temizledikten sonra, bu Aşamaları <TutorialHighlight:Yeniden Canlandırma> ile tekrar oynayabilirsin. <TutorialHighlight:Yeniden Canlandırma> kullanarak Aşama ödüllerini hızla elde edebilirsin."
  },
  Tutorial_17813_Title_1 = {
    Text = "Yeniden Canlandırma"
  },
  Tutorial_17814_Desc_1 = {
    Text = "<TutorialHighlight:Kalkan> Hasarı engelleyebilir. Kalkan, turun sonunda <TutorialHighlight:otomatik olarak kaldırılır>. Kalkan sınırı, ekibin <TutorialHighlight:Azami Canı>na eşittir. Bu turda <TutorialHighlight:toplam Kalkanı, alınacak toplam Hasarla eşleştirmeye elinizden geldiğince çalışın> ve savaşı kazanın."
  },
  Tutorial_17814_Title_1 = {Text = "Kalkan"},
  Tutorial_17815_Desc_1 = {
    Text = "Uyandırıcıları tekrar tekrar elde etmek, onları <TutorialHighlight:Parça>ya dönüştürür. Uyandırıcının Aydınlanma Seviyesi'ni yükseltmek için <TutorialHighlight:Parça> tüketmek, Uyandırıcının Becerilerine ek özel yetenekler kazandırır. Uyandırıcının Aydınlanma Seviyesi en üst düzeye ulaştığında, ilgili Parçaları elde etmek, onları <TutorialHighlight:Ruh Geri Sarma Parçası>na dönüştürür."
  },
  Tutorial_17815_Title_1 = {Text = "Parça"},
  Tutorial_17816_Desc_1 = {
    Text = "Arithmetica <TutorialHighlight:tüm ekip tarafından ortaklaşa kullanılır>, kart oynamak <TutorialHighlight:Arithmetica> tüketir. Arithmetica her turun başında <TutorialHighlight:otomatik olarak maksimuma dolar> ve turun sonunda <TutorialHighlight:otomatik olarak sıfırlanır>. Arithmetica verimliliğini en üst düzeye çıkarmak için, lütfen <TutorialHighlight:turu bitirmeden önce tüm Arithmetica’yı tüketmeye> çalışın."
  },
  Tutorial_17816_Title_1 = {
    Text = "Arithmetica"
  },
  Tutorial_17817_Desc_1 = {
    Text = "<TutorialHighlight:Gizemli Hakimiyet>teki düşmanları yenerek Üst Düzey <TutorialHighlight:Beceri Yükseltme Malzemeleri> elde edin. Ödüller haftada bir kez alınabilir. Çeşitli malzemeler ayrıca <TutorialHighlight:Simya> içinde sentezlenip Borsa yapılabilir."
  },
  Tutorial_17817_Title_1 = {
    Text = "Gizemli Hakimiyet"
  },
  Tutorial_17818_Desc_1 = {
    Text = "Edinildiğinde <TutorialHighlight:Malzemeler> içinde kullanılabilir; önceden belirlenmiş değerlere göre Uyandırıcı seviyesini ve beceri seviyesini hızla yükseltir."
  },
  Tutorial_17818_Title_1 = {
    Text = "Gnosis Yükselticisi"
  },
  Tutorial_17819_Desc_1 = {
    Text = "Bir Uyandırıcının Aliemus’u <TutorialHighlight:100>e ulaştığında, <TutorialHighlight:Yüceltim> Serbest Bırakabilir. Farklı Uyandırıcıların farklı Yüceltim etkileri vardır. <TutorialHighlight:yarı emekle iki kat sonuç> elde etmek için onları akıllıca kullanın."
  },
  Tutorial_17819_Title_1 = {
    Text = "Taşkınlık"
  },
  Tutorial_17820_Desc_1 = {
    Text = "<TutorialHighlight:Kırılgan> durumundaki hedeflerin kalkan etkinliği %25 azalır ve turun sonunda 1 yığın <TutorialHighlight:Kırılgan> kaldırılır. Ekibiniz <TutorialHighlight:Kırılgan> durumundaysa, savunmaya geçmeden önce mutlaka <TutorialHighlight:Kırılgan> durumunu kaldırın ya da bu tur stratejinizi acımasız bir saldırıya odaklanacak şekilde ayarlayın."
  },
  Tutorial_17820_Title_1 = {Text = "Kırılgan"},
  Tutorial_17821_Desc_1 = {
    Text = "Uyandırıcıya <TutorialHighlight:Kader Çarkı> kuşanmak, Uyandırıcının niteliklerini artırabilir ve özel yetenekler açabilir."
  },
  Tutorial_17821_Title_1 = {
    Text = "Kader Çarkı"
  },
  Tutorial_17822_Desc_1 = {
    Text = "<TutorialHighlight:Kanama> durumundaki hedefler, turun sonunda <TutorialHighlight:Kanama> yığınları kadar Hasar alır, ardından <TutorialHighlight:Kanama durumunu kaldır>. \n<TutorialHighlight:HP Yenilenmesi>, <TutorialHighlight:İyileştirme miktarının iki katı> kadar Kanama yığınını kaldırır. Kanama Hasarı <TutorialHighlight:kritik vuramaz>."
  },
  Tutorial_17822_Title_1 = {Text = "Kanatma"},
  Tutorial_17823_Desc_1 = {
    Text = "Kaos Uyandırıcıları, <TutorialHighlight:âlem kısıtlamalarını aşabilir> ve diğer âlemlerden Uyandırıcılarla birlikte dizilimler kurarak farklı simbiyotik etkiler sağlayabilir. Kaos Alanı Uyandırıcısı içeren her dizilim, fazladan %100 Ölüm Direnci kazanır."
  },
  Tutorial_17823_Desc_2 = {
    Text = "Diğer Diyar takımlarıyla karşılaştırıldığında, Kaos Diyarı takımları Keyflare’ı daha hızlı kazanır ve ikinci Posse serbest bırakılırken tüm Alınabilir Posse’ler arasından seçim yapabilir; seçilen Posse iki kez tetiklenir. Bu nedenle, Kaos Diyarı takımları Posse’ler arasındaki uyuma daha çok dayanır ve doğru Posse’yi seçmek, bir Kaos Diyarı takımının gücünü büyük ölçüde artırabilir!"
  },
  Tutorial_17823_Title_1 = {Text = "Kaos"},
  Tutorial_17824_Desc_1 = {
    Text = "Her bir <TutorialHighlight:Tetikte> puanı için, Kalkan elde ettiğinizde fazladan 1 Kalkan kazanırsınız."
  },
  Tutorial_17824_Title_1 = {Text = "Teyakkuz"},
  Tutorial_17825_Desc_1 = {
    Text = "İlk Soruşturmayı tamamladıktan sonra güçlü <TutorialHighlight:Rezonans> etkinleştirmek için kullanılabilen <TutorialHighlight:Resonance Activation Materials> elde edebilirsin. Bu Rezonans, bu bölümün tüm safhalarında etkili olacaktır."
  },
  Tutorial_17825_Title_1 = {Text = "Rezonans"},
  Tutorial_17826_Desc_1 = {
    Text = "Ekibiniz <TutorialHighlight:Aliemus Mührü> durumundayken, Yüceltim Serbest Bırakamazsınız. Aliemus’u boşa harcamamak için, düşman <TutorialHighlight:Aliemus Mührü> uygulamadan önce Yüceltim kullanın."
  },
  Tutorial_17826_Title_1 = {
    Text = "Aliemus Mührü"
  },
  Tutorial_17827_Desc_1 = {
    Text = "Uyandırıcının seviyesini artırmak için <TutorialHighlight:Gnosis İksiri> tüketir. Yükseltme, Uyandırıcının niteliklerini iyileştirir. Seviye sınırına ulaşıldığında, Uyandırıcının seviye sınırını yükseltmek için Arındırma yapılmalıdır."
  },
  Tutorial_17827_Title_1 = {
    Text = "Gnosis İksiri"
  },
  Tutorial_17828_Desc_1 = {
    Text = "Her bir <TutorialHighlight:KUV▼> puanı için, verilen <TutorialHighlight:Aktif Hasar>ı 1 azalt."
  },
  Tutorial_17828_Title_1 = {Text = "STR▼"},
  Tutorial_17829_Desc_1 = {
    Text = "Hasar almadan önce Hasara Bağışıklık kazanır ve 1 <TutorialHighlight:Bariyer> kaldırırsınız. Tek seferde alınan hasar ne kadar yüksekse, <TutorialHighlight:Bariyer>den elde edilen fayda o kadar büyüktür."
  },
  Tutorial_17829_Title_1 = {Text = "Bariyer"},
  Tutorial_17830_Desc_1 = {
    Text = "<TutorialHighlight:Zayıflık> durumundaki hedefler %25 daha az Hasar verir ve turun sonunda 1 <TutorialHighlight:Zayıflık> yığını kendiliğinden kaldırılır. Ekibin <TutorialHighlight:Zayıflık> durumundaysa, saldırmadan önce <TutorialHighlight:Zayıflık> durumunu kaldırmayı denemeyi unutma ya da bu tur Strateji’yi tamamen savunmaya odaklanacak şekilde değiştir."
  },
  Tutorial_17830_Title_1 = {Text = "Zayıflık"},
  Tutorial_17831_Desc_1 = {
    Text = "<TutorialHighlight:Yasak Ahit>'teki düşmanları yenerek Uyandırıcı yeteneklerini geliştiren <TutorialHighlight:Ahit> kazanabilirsiniz. Her ana hikaye bölümünü Temizlediğinizde yeni <TutorialHighlight:Yasak Ahit> Sahneleri açılır. Ahit ayrıca mağazadan da satın alınabilir."
  },
  Tutorial_17831_Title_1 = {
    Text = "Yasak Ahitname"
  },
  Tutorial_17832_Desc_1 = {
    Text = "Bir Ultra takımının her tur oynanan <TutorialHighlight:ilk> Komut Kartı’nın geçici kopyası <TutorialHighlight:Ultra Uzay>a girer ve güçlü sıçrama etkilerini tetikler. Ultra Uzay sınırına ulaştığında, 1 fazladan <TutorialHighlight:Ultra Tur> kazanılır; bu tur boyunca <TutorialHighlight:tüm sıçrama etkileri tetiklenir>. Ultra Takımını ustalıkla kullanmanın anahtarı: her tur oynanan ilk kartı dikkatle planlamak."
  },
  Tutorial_17832_Title_1 = {Text = "Ultra"},
  Tutorial_17833_Desc_1 = {
    Text = "Ekibinizin HP’si tükendiğinde, tüm Durumları yenilemek için <TutorialHighlight:Acil Gnosis Birimi>ni etkinleştirebilirsiniz. Acil Gnosis Birimi günde otomatik olarak <TutorialHighlight:1> birim yenilenir ve en fazla <TutorialHighlight:5> birime kadar birikir. Acil Gnosis Birimi’ni <TutorialHighlight:Yüksek Zorluklu Savaşlar>da akıllıca kullanın ve onları düşüncesizce heba etmekten kaçının."
  },
  Tutorial_17833_Title_1 = {
    Text = "Acil Gnosis Birimi"
  },
  Tutorial_17834_Desc_1 = {
    Text = "Haritadaki hafifçe parlayan noktaları dikkatle ara; onları soruşturmak beklenmedik kazanımlara yol açabilir."
  },
  Tutorial_17834_Title_1 = {
    Text = "Çökelti Noktası"
  },
  Tutorial_17835_Desc_1 = {
    Text = "Bu turda tüm düşmanlardan gelecek toplam hasarı gösterir. Basit ve pratik bir Koruyucu dövüş ipucu: <TutorialHighlight:Karakter kalkanını toplam düşman hasarına eşitle>."
  },
  Tutorial_17835_Title_1 = {
    Text = "Toplam Düşman Hasarı"
  },
  Tutorial_17837_Desc_1 = {
    Text = "Caro takımının <TutorialHighlight:Embriyo Füzyonu> sınırına ulaştığında, 1 <TutorialHighlight:\"Embriyo\"> kazanırsın. Taşkınlık'ı Serbest Bırakmak, güçlü bir <TutorialHighlight:Yutma> Etkisi tetiklemek için <TutorialHighlight:\"Embriyo\"> tüketir. Bu nedenle, Elinde <TutorialHighlight:\"Embriyo\"> varken Taşkınlık'ı Serbest Bırakmaya çalış; aksi takdirde Caro takımının tüm potansiyelini ortaya çıkaramazsın."
  },
  Tutorial_17837_Desc_2 = {
    Text = "Her savaştan sonra, Maksimum HP’nin %5’i oranında HP Yenilenmesi Kızıl Ocak’ta birikir. Kullanılmamış <TutorialHighlight:Embryo> varsa, her Embryo da Ocağa Maksimum HP’nin %5’i kadar HP Yenilenmesi katkısında bulunur. Kızıl Ocak, ekibin HP’sini yenilemek için kullanılabilir ve her turda bir kez İyileştirme’ye dönüştürülebilir. Koruyucu, Kızıl Ocak’ı ne zaman kullanacağına dikkatle karar vererek savaşın gidişatını tersine çevirmelidir."
  },
  Tutorial_17837_Title_1 = {Text = "Caro"},
  Tutorial_17838_Desc_1 = {
    Text = "Kavşak’ta, takımının kaybedilen HP’sinin %50’sini yenilemeyi ya da 1 Uyananı Uyandırmayı seçebilirsin. Takımının HP’si düşükken HP Yenilenmesi’ni seç; aksi hâlde bir Uyananı Uyandırmayı tercih et."
  },
  Tutorial_17838_Title_1 = {Text = "Kavşak"},
  Tutorial_17839_Desc_1 = {
    Text = "Takımınızı güçlendirmek için Kara Mühürleri tüketen bir tesis. Genellikle bir Orison, bir Gümüş Kalıntı ve bir Altın Kalıntı için birer yuva sunar. İstediğiniz öğeler Alınabilir değilse, <TutorialHighlight:Yenileme>'ye tıklayın; D-Mark'ler yeni seçenekler oluşturacaktır."
  },
  Tutorial_17839_Title_1 = {Text = "D-iz"},
  Tutorial_17840_Desc_1 = {
    Text = "<TutorialHighlight:Illusion>’u zorla aşmak seni “Semptom” ile enfekte edecektir."
  },
  Tutorial_17840_Title_1 = {Text = "İllüzyon"},
  Tutorial_17841_Desc_1 = {
    Text = "Komut Kartları kullanmak, Uyandırıcıların <TutorialHighlight:Aliemus> kazanmasını sağlar. Komut Kartının beceri seviyesi ne kadar yüksekse, kazanılan Aliemus o kadar fazladır."
  },
  Tutorial_17841_Title_1 = {Text = "Aliemus"},
  Tutorial_17842_Desc_1 = {
    Text = "Düşmanları yenmek veya olayları soruşturmak <TutorialHighlight:Black Sigil> kazandırabilir. Bir Uyananın <TutorialHighlight:Sigil Yield> niteliği, elde edilen Kara Mühür sayısını artırır."
  },
  Tutorial_17842_Desc_2 = {
    Text = "D-İşareti’nde, <TutorialHighlight:Black Sigil> harcayarak Yakarışlar ve Kalıntılar satın alabilir ya da Uyananları uyandırabilirsin. Final savaş öncesinde, takımını güçlendirmek için tüm Kara Mühürleri harcadığından emin ol."
  },
  Tutorial_17842_Title_1 = {
    Text = "Kara Mühür"
  },
  Tutorial_17843_Desc_1 = {
    Text = "Saldırıya uğradığınızda, saldırgana, sahip olduğunuz <TutorialHighlight:Sayaç> yığınının sayısına eşit miktarda hasar verirsiniz. <TutorialHighlight:Sayaç> hasarı kritik vuruş yapamaz."
  },
  Tutorial_17843_Title_1 = {Text = "Sayaç"},
  Tutorial_17844_Desc_1 = {
    Text = "Her bir <TutorialHighlight:Güç> puanı için, her aktif saldırıda verilen hasar 1 puan artırılır."
  },
  Tutorial_17844_Title_1 = {Text = "Güç"},
  Tutorial_17845_Desc_1 = {
    Text = "Uyandırıcıları araştırma görevlerini tamamlamaları için görevlendirerek karşılık gelen ödülleri alın. Atanan Uyandırıcıların <TutorialHighlight:toplam seviyesi> ne kadar yüksekse, ödüller o kadar iyi olur; en yüksek Hesaplama, toplam seviye 240 üzerinden yapılır."
  },
  Tutorial_17845_Title_1 = {Text = "Görev"},
  Tutorial_17847_Desc_1 = {
    Text = "Ölümcül Hasar alındığında, <TutorialHighlight:Ölüm Direncine eşit bir olasılıkla> hasara bağışık hale gelip 1 HP’yi saklı tutabilirsiniz; <TutorialHighlight:başarılı tetiklenmeden sonra Ölüm Direnci yarıya iner>. Ekibin Ölüm Direnci, tüm Uyananların Ölüm Direnci toplamına eşittir; ekibin Ölüm Direncini artırmak, savaşta hata payını yükseltir."
  },
  Tutorial_17847_Title_1 = {Text = "Direnç"},
  Tutorial_17848_Desc_1 = {
    Text = "Bir Aequor takım savaşının başında 1 <TutorialHighlight:Dokunaç> oluşturulur. <TutorialHighlight:Dokunaç>, turun sonunda ön saftaki düşmanlara saldırır. Mevcut Dokunaç Hasarı’nı ve saldırı sayısını, Dokunaç simgesinin altındaki formülden kontrol edebilirsin. Bazı Awakener’lar Dokunaç Sayısını ve Hasarını artırarak turun sonunda kayda değer hasar verebilir."
  },
  Tutorial_17848_Title_1 = {Text = "Aequor"},
  Tutorial_17850_Desc_1 = {
    Text = "Kart oynamak Arithmetica tüketir. Tur sonunda tüm kartlar <TutorialHighlight:Atılmış Kart Destesi>ne taşınır. <TutorialHighlight:kart oynama sırasını> doğru planlamak, savaşta zafere giden anahtardır."
  },
  Tutorial_17850_Title_1 = {Text = "El"},
  Tutorial_17851_Desc_1 = {
    Text = "Düşmanın bir sonraki turda gerçekleştireceği eylemi gösterir. Bu turda karar verirken <TutorialHighlight:Niyet>ten yararlanmak, savaşın temel oynanış mekaniğidir."
  },
  Tutorial_17851_Title_1 = {
    Text = "Düşman Niyeti"
  },
  Tutorial_17852_Desc_1 = {
    Text = "<TutorialHighlight:Yetenek Yükseltmesi>, Uyanan niteliklerini güçlendirebilir ve Komut Kartı etkilerini geliştirebilir. Uyanan Yetenek arayüzünde \"Sonraki Seviye\"ye tıklamak, yükseltilmiş etkiyi önceden görmeni sağlar."
  },
  Tutorial_17852_Desc_2 = {
    Text = "Farklı Diyarlardan Uyananlar, farklı <TutorialHighlight:Yetenek Yükseltme Malzemeleri>ne ihtiyaç duyar."
  },
  Tutorial_17852_Title_1 = {
    Text = "Yetenek Yükseltme"
  },
  Tutorial_20768_Desc_1 = {
    Text = "Bir Uyandırıcı Arithmetica tükettiğinde <TutorialHighlight:Keyflare> kazanır. <TutorialHighlight:Gümüş Anahtar Şarjı> niteliği, kazanılan <TutorialHighlight:Keyflare> miktarını artırır."
  },
  Tutorial_20768_Title_1 = {Text = "Keyflare"},
  Tutorial_20769_Desc_1 = {
    Text = "<TutorialHighlight:Rusted Door> önemli soruşturma güzergâhlarını tıkar. Haritada, <TutorialHighlight:Rusted Door>’u açmak için kullanılabilecek <TutorialHighlight:Rusted Key> adlı eşyayı ara."
  },
  Tutorial_20769_Title_1 = {
    Text = "Paslı Kapı"
  },
  Tutorial_20770_Desc_1 = {
    Text = "<TutorialHighlight:Rusted Key>, yolunu tıkayan <TutorialHighlight:Rusted Door>’u açabilir."
  },
  Tutorial_20770_Title_1 = {
    Text = "Paslı Anahtar"
  },
  Tutorial_20771_Desc_1 = {
    Text = "<TutorialHighlight:Işıksız Diyar>, dört diyar boyunca uzanan bir dizi bölüm içerir. Bunları temizlemek Gümüş ve Gnosis İksiri gibi ödüller kazandırır. Ayrıca, gerekli toplam yıldız derecesine ulaşmak, Gümüş ve Saf Çekirdek gibi ekstra ödüllerin kilidini açar!"
  },
  Tutorial_20771_Desc_2 = {
    Text = "Farklı Diyar Çatlağı bölümleri, soruşturma ekibindeki Uyananların Diyarına belirli gereksinimler uygular. Yalnızca <TutorialHighlight:gereksinimleri karşılayan> ekipler soruşturmaya devam edebilir."
  },
  Tutorial_20771_Title_1 = {
    Text = "Işıksız Diyar"
  },
  Tutorial_20772_Desc_1 = {
    Text = "Keyflare <TutorialHighlight:1000>e ulaştığında, <TutorialHighlight:Posse>nizi serbest bırakabilirsiniz. Posse’yi tur başına iki kez serbest bırakabilirsiniz. İkinci serbest bırakışta, rastgele gelen 3 Posse seçeneğinden 1’ini seçmek zorundasınız ve seçilen Posse bu soruşturma boyunca yeniden kullanılamaz. Dizilim sırasında ekibiniz için uygun Posse’yi seçmek, soruşturma sürecini daha akıcı kılar."
  },
  Tutorial_20772_Title_1 = {Text = "Müfreze"},
  Tutorial_20773_Desc_1 = {
    Text = "Yükseliş için aynı <TutorialHighlight:Kader Çarkı>'nı tüketmek, onun niteliklerini ve özel yeteneklerini geliştirir. 1 ila 3 kez Yükseltildiğinde, Kader Çarkı'nın etkileri güçlenir; 4 ila 15 kez Yükseltildiğinde, nitelikleri iyileşir. Yükseliş sonrası değişiklikleri önizlemek için Yükseliş arayüzündeki \"Sonraki Aşama\" düğmesine tıklayın."
  },
  Tutorial_20773_Title_1 = {
    Text = "Kader Çarkı Yükselişi"
  },
  Tutorial_22247_Desc_1 = {
    Text = "<TutorialHighlight:Ahit Yükseltme>, Ahit niteliklerini seviye 12’ye kadar güçlendirir. Ahitleri sökmek, karşılık gelen Kalıntı Nüsha’ları verir; bunlar Envanter içinde <TutorialHighlight:Bin Yüz Mührü> ile Borsa yapılabilir. Ahitleri Yükseltme, <TutorialHighlight:Bin Yüz Mührü> tüketir ve Yükseltilmiş Ahitleri sökmek, harcanan <TutorialHighlight:Bin Yüz Mührü>nü iade eder."
  },
  Tutorial_22247_Title_1 = {
    Text = "Ahit Yükseltme"
  },
  Tutorial_22248_Desc_1 = {
    Text = "Transkripsiyon, <TutorialHighlight:Ahit>in çeşitli tür ve güçlerde rastgele nitelikler elde etmesini sağlar. Bu nitelikler belirli ekipman parçalarına bağlı değildir ve Kritik Oranı, Krit. Hasar, Aliemus Dolum Seviyesi, Anahtar Parıltısı Yenilenme Seviyesi, Diyar Ustalığı, Mühür Hasadı, Hasar Güçlendirmesi ve Ölüm Direnci içerebilir. Transkripsiyon sırasında belirli bir niteliği korumak istersen, onu <TutorialHighlight:Kilitle>meyi seçebilir, böylece kilitlenen niteliğin transkripsiyon boyunca değişmeden kalmasını sağlayabilirsin."
  },
  Tutorial_22248_Title_1 = {
    Text = "Ahit Yazımı"
  },
  Tutorial_23466_Desc_1 = {
    Text = "Koruyucu Seviyeniz yükseldikçe, <TutorialHighlight:Kalıntıların ve Yakarışların gücü> artar ve Uyanan için her BND (CON) puanının ekip HP’si üzerindeki <TutorialHighlight:etkisi> güçlenir. Soruşturmalar ve Perde Araları önemli miktarda Koruyucu TP (EXP) verir. Tüketilen her 1 Dayanıklılık (Stamina) puanı, 1 Koruyucu TP kazandırır."
  },
  Tutorial_23466_Title_1 = {
    Text = "Koruyucu Seviyesi"
  },
  Tutorial_47538_Desc_1 = {
    Text = "D-Etkisi Yasak Bölgesi, yüksek zorlukta bir oynanış sistemidir. Koruyucular, mümkün olduğunca çok Eğitim Puanı elde etmek ve böylece daha fazla ödül kazanmak için birden fazla meydan okuma ekibini esnek biçimde koordine etmelidir. Yüksek Alarm zorluğunda, düşman birimleri yalnızca daha güçlü olmakla kalmaz, aynı zamanda çeşitli zayıflatma etkilerinden de muzdarip olur."
  },
  Tutorial_47538_Desc_2 = {
    Text = "D-Etkisi Yasak Bölgesi’nin kendine özgü kısıtlama kuralları vardır: Aynı Uyanan ve Posse ile aynı isimli Kader Çarkları tekrar tekrar sahaya sürülemez. Koruyucu, başlangıçtaki Kalıntılar, Canavarlar ve önerilen Seviyelere göre bu meydan okuma için ekibi esnek biçimde seçebilir; Tian Ji’nin at yarışı benzeri bir stratejiyle elde edilen Eğitim Puanlarını en üst düzeye çıkarabilir. <TutorialHighlight:Destek> sistemi üzerinden sahaya sürülen Uyananlar bu kısıtlamadan etkilenmez."
  },
  Tutorial_47538_Title_1 = {
    Text = "D-Etkisi Yasak Bölgesi"
  },
  Tutorial_54390_Desc_1 = {
    Text = "<TutorialHighlight:Traphase> modunda, savaş arayüzünde hem düşman hem de müttefik Uyandıranların sahip olduğu <TutorialHighlight:durumlar>, HP ve Aliemus’larının altında gösterilir. Belirli etkileri görmek için tıkla."
  },
  Tutorial_54390_Desc_2 = {
    Text = "<TutorialHighlight:Olumlu Durum>'a ait olanlar şunlardır (ayrıntılar için tıklayın): <TauntKeywords:Alay>, <PVPPowerIconKeywords:Güç>, <EnergyStorageKeywords:Şarj>, <PVPProtectiveKeywords:Bariyer>, <PVPRetaliateIconKeywords:Karşı Saldırı>, <ReinforceKeywords:Güçlendirilmiş>, <StrengthenKeywords:Güçlendirme>."
  },
  Tutorial_54390_Desc_3 = {
    Text = "Aşağıdaki gibi <TutorialHighlight:Olumsuz Durumlar> sınıfına aittir (ayrıntılar için tıklayın): <PVPEntanglementKeywords:Entwined>, <PVPVulnerabilityIconKeywords:Savunmasız>, <PVPSlowKeywords:Durgunluk>, <ComaKeywords:Taşlaştırma>, <DisarmKeywords:Felç>, <PVPMethysisKeywords:Zehir>, <PVPEmptinessKeywords:Boşluk>, <PVPBleedingKeywords:Kan Akıtma>, <PVPSeriousInjuryKeywords:Ağır Yıkım>, <ComaKeywords:Baygın>."
  },
  Tutorial_54390_Title_1 = {Text = "Durum"},
  Tutorial_54391_Desc_1 = {
    Text = "<TutorialHighlight:Traphase> modunda, bazı Uyanan kartlarının farklı <TutorialHighlight:ek özellik> etkileri olur; bunlar <TutorialHighlight:Koleksiyon> sisteminde ya da savaş sırasında karta uzun basarak görüntülenebilir. Ek özellikler şunları içerir (ayrıntılar için tıkla): <PVPPenetrateKeywords:Nüfuz>, <PrepareKeywords:Hazırlan>, <PVPResurrectionKeywords:Diriliş>, <PVPHoldingKeywords:Elde>, <PhantomKeywords:Fantazma>, <PVPRaidKeywords:Pusu>."
  },
  Tutorial_54391_Title_1 = {Text = "Ek"},
  Tutorial_54392_Desc_1 = {
    Text = "<TutorialHighlight:Traphase> modunda, maç puanları her sezon sonunda ve yeni sezon başlangıcında sıfırlanır. Sezon adları ve süreleri gibi bilgiler arayüzün sağ tarafında görüntülenebilir. Puanlar sıfırlandığında, önceki sezonda 1.000'den fazla puana sahip olan oyuncuların fazla kısmı yarıya indirilir."
  },
  Tutorial_54392_Desc_2 = {
    Text = "Her sezon boyunca <TutorialHighlight:Sezon Görevleri> bulunacaktır. Zengin ödüller kazanmak için Sezon Görevlerini tamamlayın. Sezon Görevleri, sezon yenilendiğinde sıfırlanır."
  },
  Tutorial_54392_Title_1 = {Text = "Sezon"},
  Tutorial_54393_Desc_1 = {
    Text = "<TutorialHighlight:Traphase> modunda, bir Uyanan öldüğünde, o Uyanan’a ait eldeki kartlar <TutorialHighlight:Düş>e dönüşür. <TutorialHighlight:Kader Çarkı>nı ölmüş bir Uyanan’a kuşanmak 1 Düş verir ve harcanan Arithmetica’yı iade eder. Düşler, Kader Çarkı’nın belirli etkileriyle birleşerek <TutorialHighlight:Küçük Dilek> oluşturabilir."
  },
  Tutorial_54393_Title_1 = {Text = "İllüzyon"},
  Tutorial_54394_Desc_1 = {
    Text = "<TutorialHighlight:Traphase> modunda, her iki oyuncu da ilk turda 3 <TutorialHighlight:Arithmetica> ve bir üst sınırla başlar. İkinci oyuncu bir <TutorialHighlight:Son Vuran, En İyi Vurur> kartı alır. Sonraki her turun başında Arithmetica üst sınırı ve yenilenme miktarı 10’a ulaşana dek 1 artar. Otomatik büyümenin yanı sıra, diğer yöntemler de Arithmetica üst sınırını artırıp azaltabilir. Üst sınır 10’a ulaştığında, her ek sınır taşması 1 kart çekmeye dönüşür."
  },
  Tutorial_54394_Title_1 = {
    Text = "Arithmetica"
  },
  Tutorial_54395_Desc_1 = {
    Text = "<TutorialHighlight:Traphase> modunda, her <TutorialHighlight:Uyanan> ayrıca <TutorialHighlight:Aliemus> ve <TutorialHighlight:Yüceltim>e sahiptir. Aliemus, <TutorialHighlight:Vuruş> kartları veya belirli <TutorialHighlight:Beceri> kartları kullanılarak ve hasar alıp HP kaybederek kazanılabilir (kaybedilen her %2 HP ya da eşdeğer Kalkan için 1 Aliemus kazanılır). Aliemus 100’e ulaştığında, ilgili Uyanan’a tıklayarak Yüceltim’i serbest bırak."
  },
  Tutorial_54395_Title_1 = {Text = "Aliemus"},
  Tutorial_54396_Desc_1 = {
    Text = "<TutorialHighlight:Traphase> modunda, eşleştirme sırasında \"Maç Kayıtları\" ndaki belirtilen hedefleri tamamlamak, size karşılık gelen ödülleri kazandırır. Bu ödül tek seferliktir ve sezonla birlikte sıfırlanmaz. Arayüzün sol alt köşesindeki \"Maç Kayıtları\"üzerinden kontrol edebilirsiniz."
  },
  Tutorial_54396_Title_1 = {
    Text = "Traphase Kaydı"
  },
  Tutorial_54397_Desc_1 = {
    Text = "<TutorialHighlight:Traphase> modunda, arayüzün sol tarafındaki \"Koleksiyon\" sekmesi Uyandıranlar, Kader Çarkları ve Çetelerle ilgili tüm bilgileri incelemeni sağlar."
  },
  Tutorial_54397_Title_1 = {Text = "Topla"},
  Tutorial_54398_Desc_1 = {
    Text = "<TutorialHighlight:Traphase> modunda, her bir <TutorialHighlight:Uyandıran>ın 2 <TutorialHighlight:Darbe> kartı ve 3 <TutorialHighlight:Beceri> kartı vardır. Genellikle, farklı Beceri Kartlarının farklı <TutorialHighlight:Arithmetica Maliyeti> değerleri bulunur."
  },
  Tutorial_54398_Title_1 = {Text = "Yetenek"},
  Tutorial_54399_Desc_1 = {
    Text = "<TutorialHighlight:Traphase> modunda, her tur otomatik olarak 5 kart çekersin ve varsayılan <TutorialHighlight:Maksimum El Boyutu> da 10’dur. Mevcut el sayını ve maksimum el boyutunu savaş arayüzünün sağ alt köşesinden, rakibin bilgilerini ise sağ üstten görebilirsin. Diğer yöntemler, tur başına çekilen kart sayısını ve maksimum el boyutunu değiştirebilir."
  },
  Tutorial_54399_Title_1 = {Text = "El"},
  Tutorial_54400_Desc_1 = {
    Text = "<TutorialHighlight:Traphase> modunda, farklı Uyananların toplamda beş adet farklı <TutorialHighlight:rol>ü vardır. Bunlar sırasıyla <TutorialHighlight:Muhafız>, <TutorialHighlight:Savaş Doğumlu>, <TutorialHighlight:Luminis>, <TutorialHighlight:Malphas> ve <TutorialHighlight:Lütuf>tur. Bir <TutorialHighlight:Düzen> kurarken, takımını oluşturmak için rolü farklı 4 Uyanan seç."
  },
  Tutorial_54400_Title_1 = {
    Text = "Traphase Roller"
  },
  Tutorial_54401_Desc_1 = {
    Text = "<TutorialHighlight:Traphase-Serbest Seçim Modu>nda, arayüzün sağ alt köşesindeki \"Eşleştirmeyi Başlat\" düğmesine tıklamak seni Kadro ekranına götürür. Ayrıca, arayüzün sol tarafındaki <TutorialHighlight:Serbest Seçim Modu>nda takımını önceden kurabilirsin."
  },
  Tutorial_54401_Desc_2 = {
    Text = "Hazır dizilimler birden fazla yapılandırmanın kaydedilmesini destekler. Sol üst köşeden takım adları düzenlenebilir. Her takım 4 Uyandıran, 4 Kader Çarkı ve 2 Çete’den oluşur."
  },
  Tutorial_54401_Title_1 = {
    Text = "Hazır Düzen"
  },
  Tutorial_54705_Desc_1 = {
    Text = "<TutorialHighlight:Traphase> modunda, <TutorialHighlight:avatar>ına tıkla, göndermek istediğin <TutorialHighlight:Düello İfadesi>ni seç ve hislerini rakibine ifade et!"
  },
  Tutorial_54705_Title_1 = {Text = "İfade"},
  Tutorial_54706_Desc_1 = {
    Text = "<TutorialHighlight:Traphase>, her oyuncunun önceden oluşturduğu ekibi <TutorialHighlight:Eşleşme Savaşı> için kullandığı iki oyunculu rekabetçi bir oyundur. Eşleştirme sistemi, seni benzer beceri seviyesindeki rakiplerle karşı karşıya getirir."
  },
  Tutorial_54706_Desc_2 = {
    Text = "Savaşlar aracılığıyla <TutorialHighlight:Serbest Seçim Modu EXP> ve <TutorialHighlight:Sıralı Seçim Modu EXP> kazanabilirsin. Daha yüksek <TutorialHighlight:Serbest Seçim Modu Seviyesi> ve <TutorialHighlight:Sıralı Seçim Modu Seviyesi> açarak <TutorialHighlight:Tek Seferlik Ödüller> kazan!"
  },
  Tutorial_54706_Desc_3 = {
    Text = "Her hafta, puan sıralamasına göre bir <TutorialHighlight:Unvan> alacak ve ertesi gün <TutorialHighlight:Altın Gül> kazanacaksınız. \n Hem \"Traphase\" hem de \"Hayali Dalış\"a katılırsanız, Altın Gül hesaplaması bu iki oyun modundan <TutorialHighlight:Daha Yüksek> olan ödüle göre yapılacaktır."
  },
  Tutorial_54706_Title_1 = {
    Text = "Oyuna Giriş"
  },
  Tutorial_74798_Desc_1 = {
    Text = "Farklı bölümlerin farklı <TutorialHighlight:Bölüm Ortamları> vardır ve bunlar genel kuralları ve yadigâr etkilerini önemli ölçüde değiştirir. Ayrıntılı bilgiler, her bölüm ekranında ilgili sekmeye tıklanarak görüntülenebilir."
  },
  Tutorial_74798_Title_1 = {
    Text = "Soruşturma Bölümleri"
  },
  Tutorial_81370_Desc_1 = {
    Text = "<TutorialHighlight:Uyanan Sıfırlama>, Uyananlar tarafından tüketilen çeşitli yetiştirme kaynaklarını iade edebilir."
  },
  Tutorial_81370_Desc_2 = {
    Text = "<TutorialHighlight:Gelişim Sıfırlama>, Uyananın Seviye, Terbiye, Yetenek ve Gnostik İlerleme durumunu sıfırlar. Tüketilen tüm Malzemeler ve Altın Kuponlar tamamen iade edilir."
  },
  Tutorial_81370_Desc_3 = {
    Text = "<TutorialHighlight:Aydınlanma Sıfırlama>, Uyananın Aydınlanma durumunu ve Aydınlanma yoluyla kazanılan Seviye Sınırını sıfırlar. Tüketilen tüm Malzemeler tamamen iade edilir."
  },
  Tutorial_81370_Desc_4 = {
    Text = "<TutorialHighlight:Yaratılış Dönüşü>, \"Gelişim Sıfırlama\" etkisini içerir ve ayrıca Uyananın kendisini kilidi açılmış duruma sıfırlar."
  },
  Tutorial_81370_Title_1 = {
    Text = "Uyandırıcı Sıfırlama"
  },
  Tutorial_81371_Desc_1 = {
    Text = "<TutorialHighlight:Uyanan Yükseltmesi>, Uyanan niteliklerini güçlendirmenin en hızlı yollarından biridir. Uyanan seviyesini artırmak için <TutorialHighlight:Gnosis İksiri> tüketir."
  },
  Tutorial_81371_Desc_2 = {
    Text = "Uyananların, seviye sınırına ulaştıktan sonra seviye sınırlarını yükseltmek için <TutorialHighlight:Terbiye>den geçmeleri gerekir ve farklı Diyarlardan Uyananlar farklı <TutorialHighlight:Terbiye Malzemeleri>ne ihtiyaç duyar."
  },
  Tutorial_81371_Title_1 = {
    Text = "Uyandırıcı Yükseltme"
  },
  Tutorial_81372_Desc_1 = {
    Text = "<TutorialHighlight:Aydınlanma Etkinleştirme>, Uyananların Komut Kartı etkilerini büyük ölçüde güçlendirebilir. Aydınlanma Seviyesi 7, Uyananlar Yücelik hâline girdiğinde ek etkiler sağlayan <TutorialHighlight:Aşırı Yüceltme Patlaması>nın kilidini açar. Aydınlanma Seviyeleri 11 ve 15, Uyananların Seviye Sınırını 5 seviye artırır."
  },
  Tutorial_81372_Title_1 = {
    Text = "Aydınlanma Etkinleştirme"
  }
})
return Text_Tutorial
