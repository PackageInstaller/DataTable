__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_State = readonly({
  State_100291_Desc = {
    Text = "Tüm Uyandırıcılar %50 daha fazla Aliemus üretir."
  },
  State_100291_Name = {Text = "İtiraf"},
  State_100292_Name = {
    Text = "Tur Başlangıcı"
  },
  State_100293_Desc = {
    Text = "Tüm Uyandıranların neden olduğu Aliemus %50 azalır."
  },
  State_100293_Name = {
    Text = "Gölge Benlik"
  },
  State_100295_Name = {
    Text = "Hasar Dinleyicisi"
  },
  State_100296_Desc = {
    Text = "Her tur başında, tüm Uyananlar her yığın için <Energy:5> Aliemus kazanır."
  },
  State_100296_Name = {
    Text = "Karanlık \"İd\""
  },
  State_100297_Desc = {
    Text = "Tüm Uyananların Aliemus Üretimi +%50. Tur sonunda, Maksimum Canın %20’sine eşit Kalkan kazan."
  },
  State_100297_Name = {Text = "Ruh Kalesi"},
  State_100298_Desc = {
    Text = "Tur başında, mevcut Canının %10’unu kaybet ve [DescArg1] <PowerIconKeywords:Güçlü> kazan. Tüm Uyananların Aliemus Üretimi -%50."
  },
  State_100298_Name = {
    Text = "Sur Çöküşü"
  },
  State_100299_Desc = {
    Text = "Taşkınlık Sayısı"
  },
  State_100299_Name = {
    Text = "Taşkınlık Sayısı"
  },
  State_100302_Name = {
    Text = "Yüceltim Dinleyicisi"
  },
  State_100307_Desc = {
    Text = "Takıma Özel: Kuşanan Exalt’ı serbest bıraktıktan sonra 1 yığın \"İşbirliği\" kazanır. Bu turda diğer Uyananların bir sonraki Exalt’ı \"İşbirliği\" ni tüketebilir; bu Exalt’ın Kritik Oranı <WeaponEffect_Num:[StateArg1]%> artar ve \"İşbirliği\" ni tüketen Uyanan, kuşananın Aliemus Dolumu’nun <WeaponEffect_Num:[StateArg1]%>’üne eşit Aliemus kazanır."
  },
  State_100307_WeaponDesc = {
    Text = "Kuşanan Exalt’ı serbest bıraktıktan sonra 1 yığın \"İşbirliği\" kazanır. Bu tur içinde diğer Uyananların bir sonraki Exalt’ı \"İşbirliği\" ni tüketebilir; bu Exalt’ın Kritik Oranı <WeaponEffect_Num:[StateArg1]%> artar ve \"İşbirliği\" ni tüketen Uyanan <WeaponEffect_Num:[DescArg1]> Aliemus kazanır."
  },
  State_100326_Desc = {
    Text = "Her turun başında, bu etkinin her yığını için tüm Uyananlar <Energy:3> Aliemus kazanır."
  },
  State_100326_Name = {
    Text = "<DarkEgo:Karanlık \"İd\">"
  },
  State_100327_Desc = {
    Text = "Tüm Uyananların Aliemus Üretimi +%50. Tur sonunda, Maksimum Canın %20’sine eşit Kalkan kazan."
  },
  State_100327_Name = {
    Text = "<MindWall:Ruh Kalesi>"
  },
  State_100328_Desc = {
    Text = "Tüm Uyandırıcılar %50 daha fazla Aliemus üretir."
  },
  State_100328_Name = {
    Text = "<TrueConfess:İtiraf>"
  },
  State_100329_Desc = {
    Text = "Tüm Uyananların Aliemus Üretimi -%50. Tur sonunda, 1 yığın <DarkEgo:Karanlık \"İd\"> kazan: Tur başında, tüm Uyananlar 3 Aliemus kazanır."
  },
  State_100329_Name = {
    Text = "<ShadowSelf:Gölge Benlik>"
  },
  State_100330_Desc = {
    Text = "Tur başında, mevcut Canının %10’unu kaybet ve [DescArg1] <PowerIconKeywords:Güçlü> kazan. Tüm Uyananların Aliemus Üretimi -%50."
  },
  State_100330_Name = {
    Text = "<BarrierCrash:Sur Çöküşü>"
  },
  State_100395_Name = {
    Text = "Yaratılmış Kutsanmış Kan+"
  },
  State_100396_Name = {
    Text = "Yaratılmış Kutsanmış Kan"
  },
  State_100527_Desc = {
    Text = "Pickman “Keşif” etkisini tetiklediğinde, “İlham!” seçeneğini sun: 1 yığın “Fantasia” tüket, tüm “Keşif” etkilerini seç ve 1 yığın “Yaratıcılık” kazan."
  },
  State_100527_Name = {Text = "Vahşet"},
  State_100541_Desc = {
    Text = "Pickman 10 yığın \"Yaratıcılık\" biriktirdiğinde ve Yüceltim kullandığında, tüm \"Yaratıcılık\" yığınlarını tüketerek bir \"Fantezi\" yığını kazanır. Ayrıca tüm takım arkadaşlarına 15 Aliemus verir. \"Yaratıcılık\" en fazla 10 yığına kadar birikebilir ve savaşlar arasında korunur."
  },
  State_100541_Name = {
    Text = "<Chuangyi:Yaratıcılık>"
  },
  State_100542_Desc = {
    Text = "Pickman \"Keşif\" etkisini tetiklediğinde, \"İlham!\" seçeneğini sun: 1 yığın \"Fantasia\" tüket, tüm \"Keşif\" etkilerini seç ve 1 yığın \"Yaratıcılık\" kazan."
  },
  State_100542_Name = {
    Text = "<Kuangxiang:Fantasia>"
  },
  State_100544_Name = {
    Text = "Tatlı Sümüklüböcek"
  },
  State_100544_WeaponDesc = {
    Text = "Kullananın neden olduğu Kalkan Üretimi ve HP Yenilenmesi %6 artar. Eğer kullananın Diyar Ustalığı 50’den büyükse, Kalkan Üretimi ve HP Yenilenmesi ek olarak %6 daha artar."
  },
  State_100545_Name = {
    Text = "Tatlı Sümüklüböcek"
  },
  State_100545_WeaponDesc = {
    Text = "Kullananın neden olduğu Kalkan Üretimi ve HP Yenilenmesi %6 artar. Eğer kullananın Diyar Ustalığı 50’den büyükse, Kalkan Üretimi ve HP Yenilenmesi ek olarak %6 daha artar."
  },
  State_100558_Desc = {
    Text = "Bu turda diğer Uyananların bir sonraki Yüceltim’i Kritik Oranını [StateArg1]% artırır ve kullanıldıktan sonra [DescArg1] Aliemus kazanılır."
  },
  State_100558_Name = {
    Text = "İşbirliği"
  },
  State_100559_Desc = {
    Text = "Aşağıdaki \"Yıldız Bölümü Kalıntıları\"nı içerir: Kötücül Çocuk, Bahar Ayini, Demir Kilit, Telkâri Akik, Kutsanmış Kan, Paslanmış Testere, Altın Düş Diyarı, Kanlı Çakıl Taşı."
  },
  State_100559_Name = {
    Text = "<Chuanggouzaowu:Yaratılmış Kalıntı>"
  },
  State_100562_Desc = {
    Text = "Bu turda oynanan sonraki [Layer] Komut Kartı, Arithmetica Maliyeti 2 daha az olacak şekilde kullanılır."
  },
  State_100562_Name = {
    Text = "Gerçek, Aynı Zamanda Yanılsama"
  },
  State_100564_Desc = {
    Text = "Aşağıdaki \"Dilekler\"i içerir: Hesaplama, Ustalık, Çılgınlık, Katalizör, Kudret, Siper, Süzülme, Kavrayış."
  },
  State_100564_Name = {
    Text = "<Chuanggoukeyin:Yaratılmış Damga>"
  },
  State_100566_WeaponDesc = {
    Text = "Oynamadan önce kartın Arithmetica’sını değiştir"
  },
  State_100617_Desc = {
    Text = "Tur sonunda, Dokunaç Sınırı +1."
  },
  State_100617_Name = {
    Text = "Uçurum Takıntısı"
  },
  State_100619_Desc = {
    Text = "Güç azaldığında, yalnızca Güç yığınlarının %50’si azaltılır."
  },
  State_100619_Name = {
    Text = "Tüketme Direnci"
  },
  State_100621_Desc = {
    Text = "Her yığın Temel Hasarını %25 azaltır ve sonrasında rotanın yönünü tayin edebilir."
  },
  State_100621_Name = {
    Text = "Soluk Mum Işığı"
  },
  State_100623_Desc = {
    Text = "Her yığın Temel Hasarını %30 azaltır. Aktif ya da Dokunaç Hasarı verdikten sonra, Zehirin -[DescArg1]."
  },
  State_100623_Name = {
    Text = "Kayıp Olanın Işığı"
  },
  State_100639_Desc = {
    Text = "Dokunaç HASARI geçici olarak %50 azalır."
  },
  State_100639_Name = {
    Text = "Kayıp Lemuria Şehri"
  },
  State_100644_Desc = {
    Text = "Hedefin STR’sini kalıcı olarak azalt ve aynı miktarda STR kazan."
  },
  State_100644_Name = {
    Text = "<TouquKeywords:Kalıcı Çalma>"
  },
  State_100647_Desc = {
    Text = "Tüm Hasara karşı Bağışıklık."
  },
  State_100647_Name = {
    Text = "Tüm Hasara karşı Bağışıklık."
  },
  State_100694_Desc = {
    Text = "Her yığın Temel Hasarını %30 azaltır. Aktif ya da Dokunaç Hasarı verdikten sonra, Zehir yığınlarını azalt."
  },
  State_100694_Name = {
    Text = "Kayıp Olanın Işığı"
  },
  State_116342_Desc = {
    Text = "Bir <ErosionColorInkKeywords:Algı Bükülmesi> kartı oynayarak \"Ressam\"a 1 yığın <DecayDye:Hayalet Boya> ver."
  },
  State_116342_Name = {
    Text = "Kehanet Paleti"
  },
  State_116406_Name = {Text = "İleri"},
  State_116407_Name = {Text = "Boş Durum"},
  State_116858_Desc = {
    Text = "Bu Durum, Savunmasız çarpanını kullanır ve bağımsız bir çarpan olarak işler."
  },
  State_116858_Name = {
    Text = "Belirli bir Duruma sahipsen iki kat Hasar alırsın."
  },
  State_116859_Desc = {
    Text = "Sonraki turun başında Gedik kazan."
  },
  State_116859_Name = {
    Text = "Gecikmiş Gedik"
  },
  State_116958_Desc = {
    Text = "Bir kart oynadıktan sonra, yığın sayısına eşit Hasar al."
  },
  State_116958_Name = {
    Text = "<PVPCardLockColour:Kart Kilit>"
  },
  State_117154_Desc = {
    Text = "Bu etki, ekipte yalnızca bir Uyanan üzerinde etkili olacaktır."
  },
  State_117154_Name = {
    Text = "<TeamUnique:Takıma Özel>"
  },
  State_117212_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: «Beceri» öncesinde ve tur sonunda, <HPAndShieldMax:can ve kalkanı en yüksek> düşmana <Damage:[Damage:StateArg1]> kat <PVPCorrosionKeywords:suç mührü> uygular."
  },
  State_117212_Name = {
    Text = "Bükülmüş Şövalye Baladı"
  },
  State_117213_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kullanıcının Beceri Kartı oynandığında ve turun sonunda, en yüksek Aliemus’a sahip düşmana [StateArg1] <PVPfengsuoKeywords:Yüceltme Kilidi> uygula."
  },
  State_117213_Name = {
    Text = "Tanrısal Suret"
  },
  State_117346_Desc = {
    Text = "Pollux, verdiği Hasarın [Layer]%’i kadar Kan Akıtma uygular."
  },
  State_117346_Name = {
    Text = "Günah Damgası"
  },
  State_117355_Desc = {
    Text = "Bir sonraki Pollux Komut Kartı 2 kez Etki gösterir."
  },
  State_117355_Name = {
    Text = "İlahi Vahiy"
  },
  State_117357_Desc = {
    Text = "Takıma Özel: \"D-iz\" ve \"Kül Harabeleri\" ndeki stok sıfırlandıktan sonra, Kuşanan <WeaponEffect_Num:[StateArg1]> Aliemus kazanır."
  },
  State_117357_WeaponDesc = {
    Text = "\"D-iz\" ve \"Kül Harabeleri\" ndeki stok sıfırlandıktan sonra, Kuşanan <WeaponEffect_Num:[StateArg1]> Aliemus kazanır."
  },
  State_117358_Desc = {
    Text = "Her yığın, Pollux’un Hasarına %1 Kanama etkisi kazandırır."
  },
  State_117358_Name = {
    Text = "<ZuiyinKeywords:Günah Damgası>"
  },
  State_117744_Desc = {
    Text = "<MaxHPKeywords:Maksimum Can> -[Layer]. Tetiklendiğinde [Layer] Pasif Hasar al; Kalıcı. Dağıtıldığında, hedefin Maksimum Canı yenilenmez."
  },
  State_117744_Name = {
    Text = "Günah Damgası"
  },
  State_117745_Desc = {
    Text = "Her yığın, hedefin <MaxHPKeywords:Maksimum Canını> azaltır. Günah İşareti tetiklendiğinde, hedef yığın sayısına eşit miktarda Pasif Hasar alır. Dağıtıldığında, hedefin Maksimum Canı yenilenmez."
  },
  State_117745_Name = {
    Text = "<PVPCorrosionKeywords:Günah Damgası>"
  },
  State_117755_Desc = {
    Text = "Tur sonuna kadar hiçbir eylem gerçekleştiremez."
  },
  State_117755_Name = {Text = "Baygın"},
  State_117756_Desc = {
    Text = "Tur sonuna kadar hiçbir eylem gerçekleştiremez."
  },
  State_117756_Name = {Text = "Baygın"},
  State_117776_Desc = {
    Text = "Bu turda, sonraki [Layer] Komut Kartı'nın Final Hasarı ve Karakter Kalkanı Üretimi +[StateArg1]%."
  },
  State_117776_Name = {Text = "Alev Alev"},
  State_117777_Desc = {
    Text = "Takıma Özel: Taşıyıcının kartları +<WeaponEffect_Num:[StateArg1]%> Temel Hasar ve Krit. Hasar kazanır. Turunun başında ve taşıyıcının Yüceltme’sini kullandıktan sonra 1 \"Tutuş\" yükü kazan. Taşıyıcının Komut Kartı oynandığında, 1 yük tüketerek kartın Final Hasarını ve Kalkanını <WeaponEffect_Num:[StateArg2]%> artır. Ultra Tur sırasında bunun yerine \"Alev Alev\" kazan(etki ikiye katlanır)."
  },
  State_117777_WeaponDesc = {
    Text = "Taşıyıcının kartları +<WeaponEffect_Num:[StateArg1]%> Temel Hasar ve Krit. Hasar kazanır. Turunun başında ve Yüceltme kullandıktan sonra 1 \"Tutuş\" yükü kazan. Taşıyıcının Komut Kartı oynandığında, 1 yük tüketerek kartın Final Hasarını ve Kalkanını <WeaponEffect_Num:[StateArg2]%> artır. Ultra Tur sırasında bunun yerine \"Alev Alev\" kazan(etki ikiye katlanır)."
  },
  State_117778_Desc = {
    Text = "Bu turda, sonraki [Layer] Komut Kartı'nın Final Hasarı ve Karakter Kalkanı Üretimi +[StateArg1]%."
  },
  State_117778_Name = {Text = "Tutuşmuş"},
  State_117779_Desc = {
    Text = "Takıma Özel: Ultra Tur’da: 3 yığın \"Alevlen\" kazan. Kuşanan bir Komut Kartı oynadığında, 1 yığın tüketerek Final Hasarını ve Kalkan Üretimini <WeaponEffect_Num:[StateArg1]%> oranında artır."
  },
  State_117779_WeaponDesc = {
    Text = "Ultra Tur’da: 3 yığın \"Alevlen\" kazan. Kuşanan bir Komut Kartı oynadığında, 1 yığın tüketerek Final Hasarını ve Kalkan Üretimini <WeaponEffect_Num:[StateArg1]%> oranında artır."
  },
  State_117851_Desc = {
    Text = "Pollux’un tüm Komut Kartları, \"Izdırapla Kefaret\" Etkisi +%50 kazanır. Bu Etki [Layer] tur sürer."
  },
  State_117851_Name = {
    Text = "Gece Kıran"
  },
  State_117853_Desc = {
    Text = "Bu turda, sonraki [Layer] Pollux Komut Kartı şu kazanımları elde eder: DMG +[DescArg1], Karakter Kalkanı +[DescArg2] ve Aliemus +10."
  },
  State_117853_Name = {
    Text = "Izdırapla Kefaret"
  },
  State_117869_Desc = {
    Text = "Her Serbest Bırakılışında Yüceltme, \"Çağrı\"yı 1 yığın artırır. Her \"Çağrı\" yığını için, en fazla 5 yığına kadar [DescArg1] Güç kazanırsın."
  },
  State_117869_Name = {
    Text = "Denizci Başrahibe"
  },
  State_117870_Desc = {
    Text = "Bu birim öldürüldüğünde, öldüren kişi kaybedilen HP'nin %20'sini geri kazanır."
  },
  State_117870_Name = {Text = "Sashimi"},
  State_117875_Desc = {
    Text = "Arkada boş alan varsa, eylemden sonra 1 yığın kaybet ve \"Sashimi\" durumuna sahip 1 \"Yavru Balık\" çağır."
  },
  State_117875_Name = {
    Text = "Sözleşme: Balık Çılgınlığı"
  },
  State_117876_Desc = {
    Text = "<WeaknessIconKeywords:Weakness>, <FragileIconKeywords:Fragile> ve <HeavyInjuryKeywords:Blighten> etkileri %50’ye yükseltilir."
  },
  State_117876_Name = {
    Text = "Zayıflık & Kırılganlık & Çürüme+"
  },
  State_117880_Desc = {
    Text = "Bu savaşta, \"Sürü Sıçrayışı\" bundan sonra bir kez daha tetiklenecek."
  },
  State_117880_Name = {
    Text = "Okul sıçrama ek tetikleme"
  },
  State_117883_Desc = {
    Text = "5 yığında, tüm Uyananları derhal mühürle ve niyeti şu şekilde değiştir: \"Lemurya'nın Şanı! +\"."
  },
  State_117883_Name = {Text = "Çağır"},
  State_117885_Desc = {
    Text = "STR▼ etkisinden etkilendiğinde, aynı miktarda STR▼ etkisini uygulayana da yükler."
  },
  State_117885_Name = {Text = "Göze Göz"},
  State_117889_Desc = {
    Text = "Savaş alanına girdiğinde Maksimum HP'ni %10 artır ve diğer müttefiklere [DescArg1] <PowerIconKeywords:STR> ver; böylece bu savaşta <FishLeapWords:Sürü Gücü>nün HP artışı ve STR kazanma etkisi bir kez daha tetiklenir."
  },
  State_117889_Name = {
    Text = "Sürü Gücü"
  },
  State_118112_Desc = {
    Text = "Alınan tek vuruşluk maksimum Hasar [DescArg1] puandır ve HP %50'nin altına düştüğünde kaldırılır."
  },
  State_118112_Name = {
    Text = "Acı Eşiği I"
  },
  State_118113_Desc = {
    Text = "Aktif Hasar alarak HP kaybettikten sonra, kaybedilen HP'nin %15'i kadar Karakter Kalkanı ve kaybedilen HP'nin %5'i kadar <AlertIconKeywords:Geçici Alarm> kazan."
  },
  State_118113_Name = {
    Text = "Yumuşakça Bünyesi I"
  },
  State_118114_Desc = {
    Text = "Aktif Hasar alarak HP kaybettikten sonra, kaybedilen HP'nin %35'i kadar Karakter Kalkanı ve kaybedilen HP'nin %10'u kadar <AlertIconKeywords: Geçici Alarm> kazan."
  },
  State_118114_Name = {
    Text = "Yumuşakça Bünyesi III"
  },
  State_118115_Desc = {
    Text = "Önde boş alan varsa, eylemden sonra 1 yığın kaybet ve 1 \"Denizci Uzantısı\" çağır."
  },
  State_118115_Name = {
    Text = "Sözleşme: Denizci Çoğalması"
  },
  State_118116_Desc = {
    Text = "Alınan tek vuruşluk maksimum Hasar [DescArg1] puandır ve HP %50'nin altına düştüğünde kaldırılır."
  },
  State_118116_Name = {
    Text = "Acı Eşiği II"
  },
  State_118117_Desc = {
    Text = "Alınan tek vuruşluk maksimum Hasar [DescArg1] puandır ve HP %50'nin altına düştüğünde kaldırılır."
  },
  State_118117_Name = {
    Text = "Acı Eşiği III"
  },
  State_118118_Desc = {
    Text = "[TentaclePower:DescArg1] kadar <TentacleInjurieIconKeywords:Tentacle DMG>e sahip 1 Dokunaç ve 5 Dokunaç Sınırı kazan. Tur sonunda 1 Dokunaç kazan. Gücü azaltan etkiler %50 azaltılır."
  },
  State_118118_Name = {
    Text = "Dokunaç Toplanması"
  },
  State_118119_Desc = {
    Text = "Aktif Hasar alarak HP kaybettikten sonra, kaybedilen HP'nin %25'i kadar Karakter Kalkanı ve kaybedilen HP'nin %5'i kadar <AlertIconKeywords: Geçici Alarm> kazan."
  },
  State_118119_Name = {
    Text = "Yumuşakça Bünyesi II"
  },
  State_118319_Desc = {
    Text = "Alınan tek vuruşluk maksimum Hasar [DescArg1] puandır ve HP %50'nin altına düştüğünde kaldırılır."
  },
  State_118319_Name = {
    Text = "Uçurum Kalkanı Hasar sınırı"
  },
  State_118320_Name = {
    Text = "Geçici tükenme karşı önlemi"
  },
  State_118321_Name = {
    Text = "Tükenme Karşı Önlem Sayımı"
  },
  State_118322_Name = {
    Text = "Çağırma işaretleri"
  },
  State_118323_Desc = {
    Text = "Sürü Sıçrayışı Tetiklendi"
  },
  State_118323_Name = {
    Text = "Okul sıçrama giriş işaretçisi"
  },
  State_118324_Desc = {
    Text = "Verilen her 1 Hasar için 1 Geçici Dokunaç üret."
  },
  State_118324_Name = {
    Text = "Yılan Yağmuru Ritüeli"
  },
  State_118325_Desc = {
    Text = "Engellenmemiş Hasar verdiğinde, Çekme Desteği'nin üstüne [DescArg1] Boğulma kartı Karıştır."
  },
  State_118325_Name = {
    Text = "Yeni Dünya Yılan-başı Titremesi"
  },
  State_118656_Desc = {
    Text = "Bir kart oynarken [StateArg1] Hasar al ve 1 yığın kaldır. Yığınlar 0’a ulaştığında, daha zayıf bir \"Deniz Yaratığı\"çıkar. Tur sonunda hâlâ Parazitlenmişsen, yığınlara göre HP’si belirlenen bir \"Deniz Yaratığı\"çıkar."
  },
  State_118656_Name = {
    Text = "Defalarca Parazitlenmiş"
  },
  State_118657_Desc = {
    Text = "Bir kart oynarken [StateArg1] Hasar al ve 1 yığın kaldır. Yığınlar 0’a ulaştığında, daha zayıf bir \"Deniz Yaratığı\"çıkar. Tur sonunda hâlâ Parazitlenmişsen, yığınlara göre HP’si belirlenen bir \"Deniz Yaratığı\"çıkar."
  },
  State_118657_Name = {
    Text = "Tekrar Parazitlenme"
  },
  State_118659_Desc = {
    Text = "Bir kart oynarken [StateArg1] Hasar al ve 1 yığın kaldır. Yığınlar 0’a ulaştığında, daha zayıf bir \"Deniz Yaratığı\"çıkar. Tur sonunda hâlâ Parazitlenmişsen, yığınlara göre HP’si belirlenen bir \"Deniz Yaratığı\"çıkar."
  },
  State_118659_Name = {
    Text = "Parazitlenmiş"
  },
  State_118663_Name = {
    Text = "Yeni Dünya Yılan-başı Niyet Dinleme"
  },
  State_118669_Name = {
    Text = "Yeni Dünya Yılan-başı Başlatma"
  },
  State_118670_Desc = {
    Text = "Tükenme karşı önlem belirtileri algılanıyor"
  },
  State_118670_Name = {
    Text = "Tükenme Karşı Önlem Algılama"
  },
  State_118671_Desc = {
    Text = "Tükenme belirtisi gösteren oyuncu davranışı tespit ediliyor"
  },
  State_118671_Name = {
    Text = "Tükenme Karşı Önlem İzleme"
  },
  State_118672_Name = {
    Text = "Yeni Dünya Yılan-başı Niyet Dinleme Bekleme Süresi"
  },
  State_118741_Name = {
    Text = "Geçici dokunaçları temizle"
  },
  State_118743_Name = {
    Text = "Hazırlık çağırma konumu için çağırma işaretleri gerekli"
  },
  State_118759_Name = {
    Text = "Canavarın mevcut kalıcı dokunaç sayısı"
  },
  State_118760_Name = {
    Text = "Canavarın kalıcı dokunaç limiti"
  },
  State_118762_Name = {
    Text = "İlk çürüme ipucu"
  },
  State_118763_Name = {
    Text = "İlk nörotoksin kan ipucu"
  },
  State_118764_Name = {
    Text = "İlk lanet nefesi ipucu"
  },
  State_118766_Name = {
    Text = "Mavi halkalı ahtapot BOSS niyet izleme"
  },
  State_118769_Name = {
    Text = "Gümüş Çekirdek Fener İpucu"
  },
  State_118771_Name = {
    Text = "İlk yoklama ipucu"
  },
  State_118772_Name = {
    Text = "İlk yılan parçalama ipucu"
  },
  State_118935_Name = {
    Text = "Canavarların murphy'si gizlice dinlemeyi amaçlıyor"
  },
  State_118938_Desc = {
    Text = "Derinlerin Hanımefendisi Uyanmış durumda, oluşturulan Karakter Kalkanı miktarı büyük ölçüde artar!"
  },
  State_118938_Name = {
    Text = "Yaratılmış Varlık"
  },
  State_118943_Desc = {
    Text = "Turun sırasında alınan Hasar ikiye katlanır. HP kaybettiğinde, eşit miktarda yığın kaybedersin. Yığınlar 0'a ulaştığında, dokunaç sayısını kalıcı olarak 1 azalt ve yığınları sıfırla; en az 1 dokunaç kalır."
  },
  State_118943_Name = {
    Text = "Tanrıça'nın Fedakârlığı"
  },
  State_118973_Name = {
    Text = "Gizli İsyan Yönetimi"
  },
  State_119051_Desc = {
    Text = "Tur sonunda tetiklenir: Bu miktarda Pasif Hasar al ve yığınların yarısını kaldır; dağıtılamaz."
  },
  State_119051_Name = {
    Text = "<PVPSacrificeKeyWords:Kurban>"
  },
  State_119052_Desc = {
    Text = "Alınan Aktif Hasarın [Layer]%’üne eşit Kurban kazan."
  },
  State_119052_Name = {
    Text = "Doğum Ritüeli"
  },
  State_119053_Desc = {
    Text = "Tur sonunda tetiklenir: [Layer] Pasif Hasar al ve yığınların yarısını kaldır; dağıtılamaz."
  },
  State_119053_Name = {Text = "Kurban"},
  State_119058_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda, en az Kurban'a sahip düşmana [StateArg1] <PVPSacrificeKeyWords:Kurban> uygular, [StateArg2] kez tekrarlar. Tüm dostlar artık <PVPCapKeywords:Arithmetica Sınırı> azalma etkisinden etkilenmez."
  },
  State_119058_Name = {
    Text = "Karanlıktaki Huzur"
  },
  State_119059_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Taşkınlık\"tan sonra, bu tur alınan Aktif Hasarın [StateArg1]%’üne eşit <PVPSacrificeKeyWords:Kurban> tüm düşmanlara uygulanır."
  },
  State_119059_Name = {
    Text = "Mavi Halka Zehri"
  },
  State_119060_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Darbe\" Hasarı +[StateArg1]%, herhangi bir müttefik \"Darbe\" oynadıktan sonra [StateArg3] kart çek, tur başına en fazla [StateArg2] kez tetiklenebilir. (şu anda [DescArg1] kez tetiklendi)."
  },
  State_119060_Name = {
    Text = "Kıyamet Azgınlığı"
  },
  State_119061_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tüm müttefiklerin \"Darbe\" Hasarı +[StateArg1]%."
  },
  State_119061_Name = {
    Text = "İdrak Işığı"
  },
  State_119063_Desc = {
    Text = "5 yığında, niyeti şu şekilde değiştir: \"Lemurya'nın Şanı!\"."
  },
  State_119063_Name = {Text = "Çağır"},
  State_119075_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_119075_Name = {
    Text = "Uyanmamış"
  },
  State_119076_Desc = {
    Text = "Ön sırada boş konumlar varsa, eylemden sonra 1 yığın kaybet ve rastgele 1 \"Lemuryalı Uyanan\" Çağır."
  },
  State_119076_Name = {
    Text = "Sözleşme: Lemuria"
  },
  State_119077_Desc = {
    Text = "\"Çağrı\" 5 yığına ulaştığında, tüm Uyananları derhal mühürle."
  },
  State_119077_Name = {
    Text = "Miryam Uyanışı!"
  },
  State_119077_WeaponDesc = {
    Text = "Bir sonraki turun başında, önceki turda kaybedilen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_119080_Desc = {
    Text = "\"Kaçacak Yer Yok\" veya \"Unutulmamış Şafak\" Serbest Bırakıldığında, seçilen Posse 1 kez ek olarak etki eder."
  },
  State_119080_Name = {Text = "Unutuştan"},
  State_119082_Desc = {
    Text = "Her Uyanan, Yücelişi serbest bıraktığında Temel Aliemus'u +10 artar."
  },
  State_119082_Name = {
    Text = "Aliemus Tükenmesi"
  },
  State_119083_Desc = {
    Text = "Bir Komut Kartı Ultra Uzay'dan alındığında, Arithmetica Maliyeti -1 olur."
  },
  State_119083_Name = {
    Text = "Öte Dünyanın Son Yolu"
  },
  State_119084_Desc = {
    Text = "Her Serbest Bırak Posse kullandığında, gereken Keyflare 100 artar."
  },
  State_119084_Name = {
    Text = "Gümüş Anahtar Şok Dalgası"
  },
  State_119085_Desc = {
    Text = "Kızıl Ocak kullanıldıktan sonra, 1 Embriyo'yu 3 tur bekleme süresiyle bir Saflığın Varisi'ne dönüştür."
  },
  State_119085_Name = {
    Text = "Kızıl Beslenme"
  },
  State_119086_Desc = {
    Text = "Üreme Gücü Bekleme Süresinde, [Layer] tur kaldı."
  },
  State_119086_Name = {
    Text = "Üreme Güç Bekleme Süresi"
  },
  State_119104_Desc = {
    Text = "Tur başında [DescArg1] yığın \"Hayat Mührü\" kazan."
  },
  State_119104_Name = {
    Text = "Gelgit Ayini"
  },
  State_119105_Desc = {
    Text = "Öldüğünde tüm \"Hayat Mührü\" yığınlarını kaybedersin. Yığın başına Maksimum HP’nin %1’ini yeniler ve Dokunaç Hasarını %1 artırırsın."
  },
  State_119105_Name = {Text = "Ahit"},
  State_119106_Name = {
    Text = "Canavarların sanrılı murphy'si kulak misafiri olmayı amaçlıyor"
  },
  State_119107_Name = {
    Text = "Tanrı'nın Diyar Düzeni Yönetimi"
  },
  State_119108_Desc = {
    Text = "Can kaybedildiğinde, her 1 yığın için kaybedilen Can'ın %1'i kadar <SacrificeKeyWord:Kurban> kazanır."
  },
  State_119108_Name = {
    Text = "Doğum Ritüeli"
  },
  State_119109_Desc = {
    Text = "<SacrificeKeyWord:Sacrifice> dışındaki kaynaklardan Hasar alındığında, eşit miktarda \"İlahi Diyar Nizamı\" kaybedersin ve Hasarın %50’si kadar <SacrificeKeyWord:Sacrifice> kazanırsın. Yığınlar 0’a indiğinde, 1 yığın \"Hayat Mührü\" kazan ve yığınları sıfırla."
  },
  State_119109_Name = {
    Text = "İlahi Diyarın Buyruğu"
  },
  State_119132_Desc = {
    Text = "Bu tur, \"Darbe\" Hasarı +[Layer]%."
  },
  State_119132_Name = {
    Text = "Darbe Geliştirme"
  },
  State_119134_Name = {
    Text = "İlk Sanrı Yaratıcısı İpucu"
  },
  State_119359_Name = {
    Text = "Gümüş Anahtar Ritüel Sayısı"
  },
  State_119362_Name = {
    Text = "Ayini Gerçekleştir"
  },
  State_119363_Name = {
    Text = "Kendi Kartın"
  },
  State_119364_Name = {
    Text = "Delilik ritüel sayısı"
  },
  State_119365_Desc = {
    Text = "Tüm Uyananların İyileştirme ve Kalkan Üretimi %40 artar."
  },
  State_119365_Name = {
    Text = "Soğukkanlılık"
  },
  State_119366_Desc = {
    Text = "Atıldıktan sonra ele dön."
  },
  State_119366_Name = {
    Text = "Atıldıktan sonra ele dön."
  },
  State_119367_Name = {
    Text = "Yaşam Ayini sayısı"
  },
  State_119368_Desc = {
    Text = "Her turun başında 500 Keyflare kazan."
  },
  State_119368_Name = {Text = "Durugörü"},
  State_119369_Desc = {
    Text = "Tüm Uyananların Aliemus Üretimi %50 artar."
  },
  State_119369_Name = {Text = "Otorite"},
  State_119370_Name = {Text = "Kalıntı"},
  State_119373_Name = {
    Text = "Düşman bir kurban gerçekleştiriyor"
  },
  State_119567_Name = {
    Text = "Ayini Tamamla"
  },
  State_119568_Desc = {
    Text = "Darbe Hasarı +[Layer]."
  },
  State_119568_Name = {
    Text = "Darbe Güçlendirici"
  },
  State_119583_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Darbe\", \"Beceri\" ve \"Taşkınlık\"tan önce, Geçici <StrongEffectKeywords:Güçlendirme> +[StateArg1]. Her kart türü için tur başına yalnızca bir kez tetiklenir."
  },
  State_119583_Name = {
    Text = "Tekrar Buluşacağız"
  },
  State_119588_Name = {Text = "Caro BS"},
  State_119589_Name = {Text = "Ultra bs"},
  State_119590_Desc = {
    Text = "Takım Özgünlüğü: Dokunaç Duruşu değiştirildikten, Kızıl Ocak kullanıldıktan veya \"Yok Oluş\" serbest bırakıldıktan sonra, kullanıcının Komut Kartını ×1 çek; her efektin 3 tur bekleme süresi vardır. Keşiften sonra, takımdaki tüm Uyandırıcılar +<WeaponEffect_Num:[StateArg1]%> Afinite kazanır."
  },
  State_119590_WeaponDesc = {
    Text = "Aktif olarak Dokunaç Duruşu değiştirirken (mevcut kalan [DescArg1] tur bekleme), Kızıl Ocak kullanırken (mevcut kalan [DescArg2] tur bekleme), \"Yok Oluş\" serbest bırakıldıktan sonra (mevcut kalan [DescArg3] tur bekleme) kullananın 1 Komut Kartı çekilir; her Etki için ayrı ayrı 3 tur bekleme süresi uygulanır. Keşif tamamlandığında, tüm Uyandırıcıların kazandığı Afinite <WeaponEffect_Num:[StateArg1]%> artar."
  },
  State_119591_Name = {
    Text = "Derin Deniz bs"
  },
  State_119741_Desc = {
    Text = "Tüm Uyananların STR Üretimi %50 azalır."
  },
  State_119741_Name = {
    Text = "Lanet: Gerileme"
  },
  State_119742_Desc = {
    Text = "Her turun başında, kayıp HP’nin %15’i iyileşir."
  },
  State_119742_Name = {
    Text = "Kutsama: Ebediyet"
  },
  State_119743_Desc = {
    Text = "Tüm Uyananların HP Yenilenmesi %50 azalır."
  },
  State_119743_Name = {
    Text = "Lanet: Yıkım"
  },
  State_119744_Desc = {
    Text = "Lanet: Yıkım 1 tur boyunca etkisizdir."
  },
  State_119744_Name = {
    Text = "Bağışıklık Lanet: Yıkım"
  },
  State_119746_Name = {
    Text = "Uçurum Kilidi kaybedilme sayısı"
  },
  State_119747_Desc = {
    Text = "1 tur boyunca DMG almaz."
  },
  State_119747_Name = {
    Text = "Gümüş Anahtar, Yolumuzu Aydınlat"
  },
  State_119748_Desc = {
    Text = "Lanet: Gerileme 1 tur boyunca etkisizdir."
  },
  State_119748_Name = {
    Text = "Bağışıklık Lanet: Gerileme"
  },
  State_119749_Desc = {
    Text = "Koruyucunun turunun başında, ellerine, <Abyssallock:Dream Chain> yığınları kadar 1 yığın <SlowIconKeywords:Stagnation> uygula."
  },
  State_119749_Name = {
    Text = "Rüya Zinciri"
  },
  State_119750_Name = {
    Text = "Göksel perdenin niyeti dinliyor"
  },
  State_119751_Name = {
    Text = "Perde serbest bırakma işaretini yeniden canlandırıyor"
  },
  State_119752_Desc = {
    Text = "Her tur başında Maksimum HP’nin %5’i kadar <PowerIconKeywords:STR> kazanırsın ve Geçici Kritik Oranı +%25 olur."
  },
  State_119752_Name = {
    Text = "Kutsama: Kudret"
  },
  State_119753_Name = {
    Text = "Uçurumun loş gelgit sayısı"
  },
  State_119754_Desc = {
    Text = "Tüm Uyandıranların neden olduğu Aliemus %50 azalır."
  },
  State_119754_Name = {
    Text = "Lanet: Ahmaklık"
  },
  State_119755_Name = {
    Text = "Ölüm sayısı"
  },
  State_119756_Desc = {
    Text = "Lanet: Ahmaklık 1 tur boyunca etkisizdir."
  },
  State_119756_Name = {
    Text = "Bağışıklık Lanet: Ahmaklık"
  },
  State_119757_Desc = {
    Text = "Koruyucu'nun turunun başında, eline, <Abyssallock:Rüya Zinciri> yığınlarının sayısına eşit olacak şekilde 1 yığın <SlowIconKeywords:Durgunluk> uygula. Her seferinde Aktif Hasar ile \"\"Cennet Perdesi\"\" kırıldığında, 1 yığın azalt ve saldıran Uyanan'ı 1 tur boyunca Tamamen Mühürle."
  },
  State_119757_Name = {
    Text = "Rüya Zinciri"
  },
  State_119758_Desc = {
    Text = "Her tur başında tüm Uyananlar 10 Aliemus kazanır."
  },
  State_119758_Name = {
    Text = "Kutsama: Bilgelik"
  },
  State_119760_Name = {
    Text = "Ölüm izleme"
  },
  State_119789_Desc = {
    Text = "Tur başlangıcında [Layer] HP yenile."
  },
  State_119789_Name = {
    Text = "Balçık Çiçeği"
  },
  State_119837_Desc = {
    Text = "Bu tur Ramona’nın oynadığı bir sonraki Komut Kartı 2 kez etkisini gösterir."
  },
  State_119837_Name = {
    Text = "Yeniden Tutuşan Eller"
  },
  State_119847_Desc = {
    Text = "Oynamadan önce kartın Arithmetica’sını değiştir"
  },
  State_119847_Name = {
    Text = "Oynanmadan önce Arithmetica Maliyetini değiştir"
  },
  State_119928_Desc = {
    Text = "Oynandıktan sonra, [StateArg1] kez daha etkinleşir, <DepleteIconKeywords:Tüketme>. <RippleKeywords:Artçı Sarsıntı>: 2 kart çek."
  },
  State_119928_Name = {
    Text = "<Rune_20:Uçurum Yankısı>"
  },
  State_119958_Desc = {
    Text = "Öldükten hemen sonra rastgele bir \"Sürü\" çağır ve onun \"Göçen Gelgitler\"ini 1 yığın azalt."
  },
  State_119958_Name = {
    Text = "Göçen Gelgitler"
  },
  State_119959_Desc = {
    Text = "Öldükten hemen sonra rastgele bir \"Yavru Sürü\" çağır ve onun \"Sonsuz Döngü\"sünü 1 yığın azalt."
  },
  State_119959_Name = {
    Text = "Sonsuz Döngü"
  },
  State_119960_Desc = {
    Text = "Verilen Aktif ve Dokunaç Hasarı -%35. Mevcut Canınız %50'nin üzerindeyken bu durum dağıtılır."
  },
  State_119960_Name = {
    Text = "<PurpleKeyWord:Çürüme>"
  },
  State_120215_Desc = {
    Text = "Koruyucu'nun turunun başında, eline, <Abyssallock:Rüya Zinciri> yığınlarının sayısına eşit olacak şekilde 1 yığın <SlowIconKeywords:Durgunluk> uygula. Her seferinde Aktif Hasar ile \"\"Cennet Perdesi\"\" kırıldığında, 1 yığın azalt ve saldıran Uyanan'ı 1 tur boyunca Tamamen Mühürle."
  },
  State_120215_Name = {
    Text = "Uçurum Kilidi"
  },
  State_120216_Desc = {
    Text = "Koruyucunun turunun başında, ellerine, <Abyssallock:Abyssal Lock> yığınları kadar 1 yığın <SlowIconKeywords:Stagnation> uygula."
  },
  State_120216_Name = {
    Text = "Uçurum Kilidi"
  },
  State_120218_Name = {
    Text = "Tur sonunda Murphy desteği seç"
  },
  State_120222_Name = {
    Text = "Tur Başlangıcı: Ters Lanet Seç"
  },
  State_120292_Name = {
    Text = "Dışlananın Acısı"
  },
  State_120293_Desc = {
    Text = "Tur sonunda [Layer] HP yenile."
  },
  State_120293_Name = {
    Text = "Dışlananın Acısı"
  },
  State_120312_Desc = {
    Text = "Öldükten hemen sonra rastgele bir \"Tiran\" çağır ve onun \"Göçen Gelgitler\"ini 1 yığın azalt."
  },
  State_120312_Name = {
    Text = "Göçen Gelgitler"
  },
  State_120320_Desc = {
    Text = "Her yığın, uygulanan bir sonraki \"Sanrı Prensesi\" \"Doğum Ritüeli\"ni %20 artırır, en fazla 5 yığına kadar birikir. 5 yığına ulaşıldıktan sonra, bir sonraki \"Sanrı Prensesi\" hasar sayısını ikiye katlar."
  },
  State_120320_Name = {Text = "Ahit"},
  State_120321_Desc = {
    Text = "Her yığın, alınan Aktif veya Dokunaç Hasarının %1'i kadar \"Kurban\" yığını uygular. En fazla 75 yığın olur. Tur sonunda kaldırılır."
  },
  State_120321_Name = {
    Text = "<DwmofeiKeywords:Doğum Ritüeli>"
  },
  State_120322_Desc = {
    Text = "Takıma Özel: El Limiti +2. Aynı türdeki Etkiler yığın yapamaz. Kuşananın Keyflare Yenilenmesi ve Yüceltim’in Final Hasar & Karakter Kalkanı Üretimi +<WeaponEffect_Num:[StateArg1]%>.\n \"Sakin Deniz\" duruşuna geçmek, Kuşananın Aliemus’unu <WeaponEffect_Num:[StateArg2]> artırır, 3 tur bekleme süresi.\n \"Azgın Dalgalar\" duruşuna geçmek, tüm düşmanlara <WeaponEffect_Num:[StateArg3]> yığın <DwmofeiKeywords:Doğum Ritüeli> yükler, 3 tur bekleme süresi."
  },
  State_120322_WeaponDesc = {
    Text = "El Limiti +2. Aynı türdeki Etkiler yığın yapamaz. Kuşananın Keyflare Yenilenmesi ve Yüceltim’in Final Hasar & Karakter Kalkanı Üretimi +<WeaponEffect_Num:[StateArg1]%>.\n \"Sakin Deniz\" duruşuna geçmek, Kuşananın Aliemus’unu <WeaponEffect_Num:[StateArg2]> artırır, 3 tur bekleme süresi.\n \"Azgın Dalgalar\" duruşuna geçmek, tüm düşmanlara <WeaponEffect_Num:[StateArg3]> yığın <DwmofeiKeywords:Doğum Ritüeli> yükler, 3 tur bekleme süresi."
  },
  State_120324_Desc = {
    Text = "Her yığın, alınan Aktif veya Dokunaç Hasarının [Layer]%'i kadar \"Kurban\" yığını uygular. En fazla 75'e kadar yığılır. Tur sonunda kaldırılır."
  },
  State_120324_Name = {
    Text = "Doğum Ritüeli"
  },
  State_120350_Desc = {Text = "—"},
  State_120350_WeaponDesc = {Text = "—"},
  State_120351_Desc = {
    Text = "\"İlahi Diyar: Durgun Deniz\" alınabilir olana [Layer] tur kaldı"
  },
  State_120351_Name = {
    Text = "İlahi Diyar: Sakin Deniz SY"
  },
  State_120352_Desc = {Text = "—"},
  State_120352_WeaponDesc = {Text = "—"},
  State_120353_Desc = {Text = "—"},
  State_120354_Desc = {
    Text = "\"İlahi Diyar: Azgın Dalgalar\" alınabilir olana [Layer] tur kaldı"
  },
  State_120354_Name = {
    Text = "İlahi Diyar: Azgın Dalgalar SY"
  },
  State_120357_Desc = {Text = "—"},
  State_120357_Name = {Text = "Dokunaç"},
  State_120357_WeaponDesc = {Text = "—"},
  State_120362_Desc = {
    Text = "<SacrificeKeyWord:Sacrifice> dışındaki kaynaklardan Hasar alındığında, Hasarın %50’si kadar <SacrificeKeyWord:Sacrifice> kazan."
  },
  State_120362_Name = {
    Text = "Genel canavar kurban yönetimi"
  },
  State_120363_Desc = {
    Text = "Tur sonunda [Layer] puan Hasar alır ve <SacrificeKeyWord:Kurban> yığınları %50 azalır."
  },
  State_120363_Name = {
    Text = "<BlueKeyWord:Adak>"
  },
  State_120364_Desc = {
    Text = "Ölümün üzerine \"Denizci Muhafızı\" çağır."
  },
  State_120364_Name = {
    Text = "Ebedî İnanç"
  },
  State_120401_Desc = {
    Text = "Arithmetica Maliyeti -[StateArg5]. Oynadıktan sonra [StateArg4] kart çek."
  },
  State_120401_Name = {
    Text = "<OrangeQuality:Mythag Nişanı>"
  },
  State_120450_Name = {
    Text = "Mavi halkalı ahtapot oyuncunun canını kaydediyor"
  },
  State_120462_Desc = {
    Text = "Savaş bittikten sonra deste içinde kalmaya devam eder, ancak oynanırsa veya tüketilirse kalıcı olarak kaldırılır."
  },
  State_120462_Name = {
    Text = "<DestructionKeywords:Yıkım>"
  },
  State_120900_Name = {
    Text = "\"Lemurya Uyandırıcı\" çağırma sayısını hazırla"
  },
  State_120907_Desc = {
    Text = "Dokunaç saldırısı engellenirse [DescArg1] kat <IntoxicationIconKeywords:Zehir> uygular."
  },
  State_120907_Name = {
    Text = "Undercurrent"
  },
  State_120908_Desc = {
    Text = "Bir Dokunaç Saldırısı engellenirse, eşit miktarda <IntoxicationIconKeywords:Zehir> uygula."
  },
  State_120908_Name = {
    Text = "Undercurrent"
  },
  State_120910_Desc = {
    Text = "Arithmetica Maliyeti +[StateArg5]. Oynadıktan sonra [StateArg4] kart çek."
  },
  State_120910_Name = {
    Text = "<OrangeQuality:Mythag Nişanı>"
  },
  State_120924_Desc = {
    Text = "Sonraki turun başında Kale kazan."
  },
  State_120924_Name = {
    Text = "Gecikme Kalesi"
  },
  State_120929_Desc = {
    Text = "Kart elde tutulur, ancak oynandıktan sonra Kirliliği kaldırır ve 1 \"Denizci Uzantısı\" çağırır. Çağırmak için boş yer yoksa, 1 yığın \"Çağrıya Hazırlan: Denizci Uzantısı\" kazanır."
  },
  State_120929_Name = {
    Text = "<SeastriderCurse:Denizci Laneti>"
  },
  State_120930_Desc = {
    Text = "Boş yer varsa, eylemden sonra 1 yığın kaybedilir ve 1 \"Denizci Uzantısı\" çağrılır."
  },
  State_120930_Name = {
    Text = "Sözleşme: Denizci Çoğalması"
  },
  State_120934_Desc = {
    Text = "Her Krit. Hasar aldığında, %3 <Baojidikang:Geçici Krit. Direnci> kazan. Her tur başında, 2 karta \"<SeastriderCurse:Denizci Laneti>\" uygula."
  },
  State_120934_Name = {
    Text = "Derin Deniz Ayinleri"
  },
  State_120941_Desc = {
    Text = "Düşmanın becerilerini güçlendirir. Düşman, hasar aldığında 1 yığın kaybeder."
  },
  State_120941_Name = {Text = "Kan Yemini"},
  State_121006_Desc = {
    Text = "Takıma Özel: Kullananın Keyflare Yenilenmesi, Yüceltme Final Hasarı ve Kalkanı +<WeaponEffect_Num:[StateArg1]%>."
  },
  State_121006_WeaponDesc = {
    Text = "Kullananın Keyflare Yenilenmesi, Yüceltme Final Hasarı ve Kalkanı +<WeaponEffect_Num:[StateArg1]%>."
  },
  State_121014_Name = {
    Text = "Kutsal Ceninin Himayesi"
  },
  State_121015_Desc = {
    Text = "Tur başında Karakter Kalkanları temizlenmez. Bir kalkanın varken, 50 yığın <ReinforcePVEKeywords:Fortress> kazanırsın ve kalkan kırıldığında <ReinforcePVEKeywords:Fortress> kaldırılır."
  },
  State_121015_Name = {
    Text = "Kutsal Ceninin Himayesi"
  },
  State_121151_Desc = {
    Text = "Kart elde tutulur, ancak oynandıktan sonra Kirliliği kaldırır ve 1 \"Denizci Uzantısı\" çağırır. Çağırmak için boş yer yoksa, 1 yığın \"Çağrıya Hazırlan: Denizci Uzantısı\" kazanır."
  },
  State_121151_Name = {
    Text = "<SeastriderCurse:Denizci Laneti>"
  },
  State_121210_Name = {
    Text = "Tüm düşmanlara 2 kez etkili olacak şekilde negatif bir <PVPWonderfulEffectKeywords:Harika Etki> bahşet."
  },
  State_121211_Name = {
    Text = "2 Kart çek, 2 Arithmetica kazan"
  },
  State_121212_Name = {
    Text = "Tüm müttefiklere 2 kez etkili olacak şekilde pozitif bir <PVPWonderfulEffectKeywords:Harika Etki> bahşet."
  },
  State_121213_Desc = {
    Text = "Tüm Hasara karşı Bağışıklık."
  },
  State_121213_Name = {
    Text = "Tüm Hasara karşı Bağışıklık."
  },
  State_121231_Desc = {
    Text = "Her yığın, bir sonraki \"Sanrı Prensesi\" ne +%20 \"Doğum Ritüeli\" verir; 5 yığına kadar birikir, bu noktada bir sonraki \"Sanrı Prensesi\" Hasar sayımı ikiye katlanır."
  },
  State_121231_Name = {
    Text = "<MingqiKeywords:Yaşam Mührü>"
  },
  State_121365_Desc = {
    Text = "Ek olarak %[Layer] Dokunaç Hasarı al."
  },
  State_121377_Name = {
    Text = "<RetainIconKeywords:Sakla>: Her turun başında 500 Keyflare kazan"
  },
  State_121378_Name = {
    Text = "<RetainIconKeywords:Sakla>: Tüm Uyananların HP Yenilenmesi ve Karakter Kalkanı Üretimi +%40"
  },
  State_121380_Name = {
    Text = "<RetainIconKeywords:Sakla>: Tüm Uyananların Aliemus Üretimi +%50"
  },
  State_121719_Name = {
    Text = "<RippleKeywords:Artçı Sarsıntı>: 1 kart çek ve [DescArg1] Geçici <PowerIconKeywords:STR> kazan"
  },
  State_121734_Desc = {
    Text = "Her Komut Kartı oynandığında, Uyananın en düşük Arithmetica Maliyetli 1 kartını at."
  },
  State_121734_Name = {
    Text = "Delilik Seli"
  },
  State_121735_Desc = {
    Text = "Tüm Komut Kartlarının Arithmetica Maliyeti 1 artar. Her 3 turun sonunda, eline 1 \"Kademeli Taşlaşma\" ekle."
  },
  State_121735_Name = {
    Text = "Ağıtın Akıntısı"
  },
  State_121736_Desc = {
    Text = "Tur sonunda, kaybedilen HP'nin %10'unu yenile, kendi üzerindeki zayıflatmaları ve takımının üzerindeki güçlendirmeleri kaldır."
  },
  State_121736_Name = {
    Text = "Doğumun Akıntısı"
  },
  State_121737_Desc = {
    Text = "Savaşın başında 15 yığın \"Geçici Bariyer\" kazan. Tur sonunda 15 yığın \"Geçici Bariyer\" kazan ve 10 rastgele karta \"Geçici Erime\" uygula."
  },
  State_121737_Name = {
    Text = "Kemik Delici Akıntısı"
  },
  State_121738_Desc = {
    Text = "Uyananların STR Üretimi %75 azalır. HP her kaybedildiğinde, [DescArg1] Kalkan ve 1 yığın Geçici Kale kazan."
  },
  State_121738_Name = {
    Text = "Sapkınlık Seli"
  },
  State_121739_Desc = {
    Text = "Tüm Uyananların Aliemus Sınırı %50 artar. Her turun sonunda, tüm Uyananlar 10 Aliemus kaybeder ve Maksimum HP'lerinin %3'ünü yeniler."
  },
  State_121739_Name = {
    Text = "Korkunun Akıntısı"
  },
  State_121740_Desc = {
    Text = "Savaş başladığında ve her tur sonunda, 2 kat Geçici <ResentChainsKeywords:Kin Zincirleri> kazanır."
  },
  State_121740_Name = {
    Text = "Hilenin Akıntısı"
  },
  State_121797_Desc = {
    Text = "Verilen tüm hasar, iyileştirme ve Kalkan etkileri %10 azalır, maksimum 2 yığın, dağıtılamaz. Büyülenmiş etkisini uygulayan son kişi öldüğünde, etkilenen kişinin tüm Büyülenmiş yığınları kaldırılır."
  },
  State_121797_Name = {
    Text = "<PVPLostSoulKeyWords:Büyüyle Bağlı>"
  },
  State_121798_Desc = {
    Text = "Verilen hasar, iyileşme ve Kalkan etkisi [DescArg1]% azalır, dağıtılamaz. En fazla 2 yığın.\n<StatusApplier:> öldürüldükten sonra kaldırılır."
  },
  State_121798_Name = {
    Text = "Büyüyle Bağlı"
  },
  State_121799_Name = {
    Text = "Dördüncü Bölüm: Lemurya Destek Kartı"
  },
  State_121850_Desc = {
    Text = "Dokunaç DMG’si %80 azalır."
  },
  State_121850_Name = {
    Text = "Golyat: Destek"
  },
  State_121863_Name = {
    Text = "<RippleKeywords:Artçı Sarsıntı>: 2 Kart çek"
  },
  State_121878_Name = {
    Text = "Ters Lanet Anlatısının İlk Seçimi"
  },
  State_122428_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_122428_Name = {
    Text = "Uyanmamış"
  },
  State_122431_Desc = {
    Text = "Mouchette engellenmemiş Hasar verdiğinde, 2 yığın <Monster_Fervor:Geçici Coşku> kazan."
  },
  State_122431_Name = {
    Text = "Sis Diyarı Kalıntısı"
  },
  State_122441_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında 3 yığın <PVPReciprocalKeywords:Geri Sayım Anı> kazan."
  },
  State_122441_Name = {
    Text = "Yılbaşı Geri Sayımı"
  },
  State_122442_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında <Block:[Block:StateArg1]> Kalkan ve <Energy:[Energy:StateArg1]> Aliemus kazan. Tur sonunda, bu Kader Çarkı otomatik olarak çıkarılır. Çekme Desteği bir sonraki kez karıştırıldığında, bu KÇ’yı Çekme Desteği’ne yerleştir ve \"Kutudaki Çocuk Neşesi\" kuşanıldığında kazanılan Aliemus ve Kalkan +[StateArg2] olur."
  },
  State_122442_Name = {
    Text = "Kutudaki Çocuk Neşesi"
  },
  State_122443_Desc = {
    Text = "Tur başında, yığın sayısı 1 azalır. Yığınlar tükendiğinde, kendi üzerindeki olumsuz etkileri dağıt ve 100 Aliemus kazan, ardından 3 Geri Sayım yığını geri kazan. Kader Çarkı’nı değiştirmek yığınları kaldırır."
  },
  State_122443_Name = {
    Text = "<PVPFlowerKeywords:Geri Sayım Anı>"
  },
  State_122596_Desc = {
    Text = "Kart Oynanamaz, Yücelik Serbest Bırakılamaz."
  },
  State_122596_Name = {
    Text = "<Seal1:Mühürlü>"
  },
  State_122636_Desc = {
    Text = "Her tur oynanan ilk “Yetenek”in Hasarı, İyileştirmesi ve Karakter Kalkanı +[StateArg1]%."
  },
  State_122636_Name = {
    Text = "Kızıl Broş"
  },
  State_122650_Desc = {
    Text = "<OrangeQuality:Gizemli Eldivenler> kalıntısı bu kartı ekledi."
  },
  State_122650_Name = {Text = "Tuhaf Kart"},
  State_122654_Name = {
    Text = "Tur başında ve tur sonunda, boş bir oyuncu destesini sıfırlamaya çalışır. Boş olmayan bir deste sıfırlanmaz."
  },
  State_122706_Name = {
    Text = "<CardKeyWord:Kavuşma Dileği>"
  },
  State_122707_Desc = {
    Text = "Bunu bu turda oynanan son \"Beceri\" olarak say. Arithmetica Maliyeti -1."
  },
  State_122707_Name = {
    Text = "<CardKeyWord:Kavuşma Dileği>"
  },
  State_123109_Desc = {
    Text = "Takıma Özel: \"D-iz\" dükkânında ilk \"Yakarış\" alışverişin ya da \"Kül Harabeleri\" ndeki indirimli ilk eşya alışverişinin 0 Kara Mühür’e mal olma ihtimali <WeaponEffect_Num:[StateArg1]%>. Bu etki her Keşif’te yalnızca bir kez tetiklenebilir."
  },
  State_123109_WeaponDesc = {
    Text = "\"D-İzi\"nde ilk kez \"Mühür\" satın alırken veya \"Kül Harabeleri\"nde ilk kez indirimli ürün satın almak için gereken Kara Mühür'ün <WeaponEffect_Num:[StateArg1]%> ihtimalle 0'a dönüşme şansı vardır; her keşif başına en fazla 1 kez geçerlidir."
  },
  State_123177_Desc = {
    Text = "Tur başında temizlenir. 10 yığına ulaştıktan sonra, bir sonraki kart oynandığında Mouchette derhal harekete geçer, \"Geçici Coşku\" yu kaldırır ve \"Ölümlü Patlama\" niyetini ekler."
  },
  State_123177_Name = {
    Text = "Geçici Coşku"
  },
  State_123178_Desc = {
    Text = "<Guaiwusiwangdikang:Ölüm Direnci>nin İyileştirme etkisi 5 kat artırılır. Düşman tarafından oynanan her kart için, 1 yığın <Monster_Fervor:Geçici Coşku> kazan."
  },
  State_123178_Name = {
    Text = "Somurtkan Sabah"
  },
  State_123243_Desc = {
    Text = "Bir düşmanı öldürdüğünde bu durumun tüm yığınlarını kaldır. Kaldırılan her yığın için 30 Aliemus kazan, en fazla 2 yığın."
  },
  State_123243_Name = {Text = "Girdap"},
  State_123246_Desc = {
    Text = "Bir düşmanı öldürdüğünde bu durumun tüm yığınlarını kaldır. Kaldırılan her yığın için 30 Aliemus kazan, en fazla 2 yığın."
  },
  State_123246_Name = {
    Text = "<PVPWaterPowerKeyWords:Girdap>"
  },
  State_123294_Desc = {
    Text = "Bu tur, “Darbe” yoluyla [DescArg1] Kart çekme destesi çekildi."
  },
  State_123294_Name = {Text = "Azgınlık"},
  State_123507_Desc = {
    Text = "Takıma Özel: Keşfin başında, desteye 1 adet “Geri Sayım Anı: 5” kartı ekle. “Geri Sayım Anı: 5”: Oynandıktan sonra 1 kart çek, bir sonraki “Geri Sayım Anı”nı Atılmış Kart Destesi’ne karıştır, <DestructionKeywords:Yıkım>. “Geri Sayım Anı: 0”: 3 kart çek, 3 Arithmetica kazan ve “Geri Sayım Anı: 5”i Atılmış Kart Destesi’ne karıştırmak için <WeaponEffect_Num:[StateArg1]%> ihtimal elde et, Elde Tut, Yıkım."
  },
  State_123507_WeaponDesc = {
    Text = "Keşfin başında, desteye 1 adet “Geri Sayım Anı: 5” kartı ekle. “Geri Sayım Anı: 5”: Oynandıktan sonra 1 kart çek, bir sonraki “Geri Sayım Anı”nı Atılmış Kart Destesi’ne karıştır, <DestructionKeywords:Yıkım>. “Geri Sayım Anı: 0”: 3 kart çek, 3 Arithmetica kazan ve “Geri Sayım Anı: 5”i Atılmış Kart Destesi’ne karıştırmak için <WeaponEffect_Num:[StateArg1]%> ihtimal elde et, Elde Tut, Yıkım."
  },
  State_123520_Desc = {
    Text = "Takıma Özel: Her tur ilk Çete serbest bırakılışından sonra, Kuşanan’ın 1 “Darbe” kartını çekme şansı <WeaponEffect_Num:[StateArg1]>%."
  },
  State_123520_WeaponDesc = {
    Text = "Her tur ilk Çete serbest bırakılışından sonra, Kuşanan’ın 1 \"Darbe\" kartını çekme şansı <WeaponEffect_Num:[StateArg1]>%."
  },
  State_123521_Desc = {
    Text = "Takıma Özel: Kuşananın Yüceltme ve Av Temel Hasarı +<WeaponEffect_Num:[StateArg1]%>. Bu tur herhangi bir Uyanan’ın “Darbe”sini oynadıktan sonra, kuşananın “Darbe” Hasarı, kuşananın Saldırısının Geçici olarak +<WeaponEffect_Num:[StateArg2]%>’i kadar artar. Bu etki tur başına en fazla 8 kez tetiklenir."
  },
  State_123521_WeaponDesc = {
    Text = "Kuşananın Yüceltme ve Av Temel Hasarı +<WeaponEffect_Num:[StateArg1]%>. Bu tur herhangi bir Uyanan’ın “Darbe”sini oynadıktan sonra, kuşananın “Darbe” Hasarı Geçici olarak +<WeaponEffect_Num:[DescArg2]> artar. Bu etki tur başına en fazla 8 kez tetiklenir."
  },
  State_123810_Desc = {
    Text = "Düşmanın mevcut Niyetini \"Harekete Geçemez\" ile değiştir."
  },
  State_123810_Name = {
    Text = "<HunmiKeywords:Fainted>"
  },
  State_123812_Desc = {
    Text = "Tur sonunda, Arithmetica Maliyeti azalır."
  },
  State_123812_Name = {
    Text = "<PrepareKeywords:Hazırlan>"
  },
  State_123994_Desc = {
    Text = "Harekete Geçemiyor."
  },
  State_123994_Name = {
    Text = "Kaliteli Uyku"
  },
  State_124010_Desc = {
    Text = "Sonraki turun başında [Layer] Arithmetica kazan."
  },
  State_124010_Name = {
    Text = "Gecikmiş Arithmetica"
  },
  State_124024_Desc = {
    Text = "Bu tur, [Layer] adet “Darbe” kartı oynandı, “Dramatik Karşılaşma” [DescArg1] kez tetiklendi."
  },
  State_124024_Name = {
    Text = "Dramatik Karşılaşma"
  },
  State_124034_Desc = {
    Text = "Tüm Uyananların \"Darbe\" Hasarı [StateArg1] artar, [Layer] tur sürer."
  },
  State_124034_Name = {
    Text = "Parlayan☆Kasırga"
  },
  State_124037_Desc = {
    Text = "Mouchette’in isabet sayısı +1, tüm Uyananların \"Darbe\" Hasarı [StateArg1] artar, [Layer] tur sürer."
  },
  State_124037_Name = {
    Text = "Parlayan☆Kasırga"
  },
  State_124107_Desc = {
    Text = "\"Yıldız Filizi\" öldüğünde, tüm Hasar ve Kışkırtma’ya Bağışıklık kazan, Azami HP’yi ikiye katla ve kalan HP’ye eşit miktarda fazladan Azami HP elde et. Üzerindeki tüm zayıflatmaları dağıt."
  },
  State_124107_Name = {
    Text = "Uyanmamış"
  },
  State_124108_Name = {
    Text = "Ötelerden Gelen Sesler Sayısı"
  },
  State_124109_Desc = {
    Text = "Bu birimin kazandığı <RetaliateIconKeywords:Sayaç>, ek olarak %5 <PowerIconKeywords:GÜÇ> bonusundan yararlanır. Tek bir turda [DescArg1] HP kaybettikten sonra, \"Şarkıcı\" ile konum değiştir."
  },
  State_124109_Name = {
    Text = "İkincil Kundak"
  },
  State_124111_Desc = {
    Text = "Ölüm Direnci HP Yenilenmesi %25’e çıkar. Düşman tarafından oynanan her Komut Kartı için, Geçici olarak [DescArg1] <TouquKeywords:Çal> <PowerIconKeywords:GÜÇ>."
  },
  State_124111_Name = {
    Text = "Sınırsız Yıldız Işığı"
  },
  State_124112_Desc = {
    Text = "\"Şarkıcı\" nın ölümü üzerine, tüm Hasar ve Coşturma’ya karşı bağışık ol, Maksimum HP ikiye katlanır ve kalan HP’ye eşit ek Maksimum HP kazan."
  },
  State_124112_Name = {
    Text = "Uyanmamış"
  },
  State_124113_Desc = {
    Text = "Rakip, turun sonunda elindeki kartları atmaz. Tur sonunda, sırayla 2 yığın <FragileIconKeywords:Kırılgan>, <WeaknessIconKeywords:Zayıflık>, <HeavyInjuryKeywords:Ağır Yıkım> ve <VulnerabilityIconKeywords:Savunmasız> durumu uygula."
  },
  State_124113_Name = {
    Text = "Ötelerden Gelen Sesler"
  },
  State_124115_Desc = {
    Text = "<FragileIconKeywords:Kırılgan>, <HeavyInjuryKeywords:Ağır Yıkım> ve <WeaknessIconKeywords:Semptom: Zayıflık> etkileri %50'ye yükseltilir. [DescArg1] adet daha <SlowIconKeywords:Durağanlık> kartı oynadıktan sonra, \"Yıldız Filizi\" ile yer değiştir."
  },
  State_124115_Name = {
    Text = "Gezegen Gezgini"
  },
  State_124121_Name = {
    Text = "Gezegen Gezgini Sayısı"
  },
  State_124122_Name = {
    Text = "Gezegen Gezgini Oyuncu Dinleyicisi"
  },
  State_124190_Desc = {
    Text = "Bu birimin kazandığı <RetaliateIconKeywords:Sayaç>, ek olarak %5 <PowerIconKeywords:GÜÇ> bonusundan yararlanır."
  },
  State_124190_Name = {
    Text = "İkincil Kundak"
  },
  State_124193_Name = {
    Text = "Ölüm Direnci’nin İyileştirme etkisi %25’e çıkar."
  },
  State_124198_Desc = {
    Text = "Uygulanan <FragileIconKeywords:Kırılgan>, <HeavyInjuryKeywords:Ağır Yıkım> ve <WeaknessIconKeywords:Semptom: Zayıflık> etkileri %50'ye yükseltilir."
  },
  State_124198_Name = {
    Text = "Gezegen Gezgini"
  },
  State_124277_Desc = {
    Text = "Yürütme sürecindeki ara değerlerin görselleştirilmesi."
  },
  State_124277_Name = {
    Text = "Değer Yazdır 2"
  },
  State_124278_Desc = {
    Text = "Yürütme sürecindeki ara değerlerin görselleştirilmesi."
  },
  State_124278_Name = {
    Text = "Değer Yazdır 4"
  },
  State_124279_Desc = {
    Text = "Yürütme sürecindeki ara değerlerin görselleştirilmesi."
  },
  State_124279_Name = {
    Text = "Değer Yazdır 5"
  },
  State_124280_Desc = {
    Text = "Yürütme sürecindeki ara değerlerin görselleştirilmesi."
  },
  State_124280_Name = {
    Text = "Değer Yazdır 1"
  },
  State_124282_Desc = {
    Text = "Yürütme sürecindeki ara değerlerin görselleştirilmesi."
  },
  State_124282_Name = {
    Text = "Değer Yazdır 7"
  },
  State_124283_Desc = {
    Text = "Yürütme sürecindeki ara değerlerin görselleştirilmesi."
  },
  State_124283_Name = {
    Text = "Değer Yazdır 8"
  },
  State_124284_Desc = {
    Text = "Yürütme sürecindeki ara değerlerin görselleştirilmesi."
  },
  State_124284_Name = {
    Text = "Değer Yazdır 9"
  },
  State_124285_Desc = {
    Text = "Yürütme sürecindeki ara değerlerin görselleştirilmesi."
  },
  State_124285_Name = {
    Text = "Değer Yazdır 10"
  },
  State_124286_Desc = {
    Text = "Yürütme sürecindeki ara değerlerin görselleştirilmesi."
  },
  State_124286_Name = {
    Text = "Değer Yazdır 6"
  },
  State_124287_Desc = {
    Text = "Yürütme sürecindeki ara değerlerin görselleştirilmesi."
  },
  State_124287_Name = {
    Text = "Değer Yazdır 3"
  },
  State_124736_Desc = {
    Text = "BEAttachPostAction arayüzünün parametre 3'ünün ilgili tetikleyiciyi doğru şekilde filtrelediğini veya tetiklediğini doğrulayın."
  },
  State_124736_Name = {
    Text = "Dinleyici Testi 1"
  },
  State_124747_Desc = {
    Text = "BEAttachPostAction arayüzünün parametre 3'ünün ilgili tetikleyiciyi doğru şekilde filtrelediğini veya tetiklediğini doğrulayın."
  },
  State_124747_Name = {
    Text = "Dinleyici Testi 2"
  },
  State_124748_Desc = {
    Text = "Düşman <BurningKeywords:Burn> içeren kartlar oynadığında, 1 yığın <MonsterExFlameKeywords:Combust> kazan, ancak geçici olarak [DescArg1] <PowerIconKeywords:STR> kaybet."
  },
  State_124748_Name = {
    Text = "Sönmeyen Alev"
  },
  State_124752_Desc = {
    Text = "BEAttachPostAction arayüzünün parametre 3'ünün ilgili tetikleyiciyi doğru şekilde filtrelediğini veya tetiklediğini doğrulayın."
  },
  State_124752_Name = {
    Text = "Dinleyici Testi 3"
  },
  State_124753_Desc = {
    Text = "BEAttachPostAction arayüzünün parametre 3'ünün ilgili tetikleyiciyi doğru şekilde filtrelediğini veya tetiklediğini doğrulayın."
  },
  State_124753_Name = {
    Text = "Dinleyici Testi 4"
  },
  State_124754_Desc = {
    Text = "BEAttachPostAction arayüzünün parametre 3'ünün ilgili tetikleyiciyi doğru şekilde filtrelediğini veya tetiklediğini doğrulayın."
  },
  State_124754_Name = {
    Text = "Dinleyici Testi 5"
  },
  State_124765_Desc = {
    Text = "Krit. Oranı [Layer]% artar."
  },
  State_124765_Name = {
    Text = "Kritik Oranı"
  },
  State_124766_Desc = {
    Text = "Bu savaşta Krit. Oranı [Layer]% artar."
  },
  State_124766_Name = {
    Text = "Kritik Oranı"
  },
  State_124766_WeaponDesc = {
    Text = "Bu savaşta Krit. Oranı [Layer]% artar."
  },
  State_124767_Desc = {
    Text = "Krit. Hasar [Layer]% artar."
  },
  State_124767_Name = {
    Text = "Kritik Hasar"
  },
  State_124811_Desc = {
    Text = "BEAttachPostAction arayüzünün parametre 3'ünün ilgili tetikleyiciyi doğru şekilde filtrelediğini veya tetiklediğini doğrulayın."
  },
  State_124811_Name = {
    Text = "Dinleyici Testi 8"
  },
  State_124812_Desc = {
    Text = "BEAttachPostAction arayüzünün parametre 3'ünün ilgili tetikleyiciyi doğru şekilde filtrelediğini veya tetiklediğini doğrulayın."
  },
  State_124812_Name = {
    Text = "Dinleyici Testi 7"
  },
  State_124813_Desc = {
    Text = "BEAttachPostAction arayüzünün parametre 3'ünün ilgili tetikleyiciyi doğru şekilde filtrelediğini veya tetiklediğini doğrulayın."
  },
  State_124813_Name = {
    Text = "Dinleyici Testi 6"
  },
  State_124826_Desc = {
    Text = "BEAttachPostAction arayüzünün parametre 3'ünün ilgili tetikleyiciyi doğru şekilde filtrelediğini veya tetiklediğini doğrulayın."
  },
  State_124826_Name = {
    Text = "Dinleyici Testi 9"
  },
  State_124843_Desc = {
    Text = "BSTAfterAttachPostAction ve BSTAfterDoActiveDamage.AttachPostAction tetikleyicilerinin dinleyicilerini doğrulayın."
  },
  State_124843_Name = {
    Text = "Dinleyici Testi 9"
  },
  State_124886_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanan bir Beceri Kartı oynadıktan sonra, öncelikle diğer Uyananlara ait kartlar olmak üzere [StateArg1] kart çek. Bu etki tur başına yalnızca bir kez etkinleşebilir."
  },
  State_124886_Name = {
    Text = "Rota Fortunae"
  },
  State_124887_Desc = {
    Text = "Bu Uyandırıcı'nın \"Örme\" hasar sayısı [Layer] artar."
  },
  State_124887_Name = {Text = "Ör"},
  State_124888_Desc = {
    Text = "Oynadıktan sonra rastgele bir düşman \"Becerisi\"ne -1 maliyet ile dönüşür."
  },
  State_124888_Name = {
    Text = "<CardKeyWord:Kehanet>"
  },
  State_124890_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Yüceltme\"den sonra, oynanan bir sonraki [StateArg1] \"Beceri\" 2 kez etkinleşir."
  },
  State_124890_Name = {
    Text = "Ebedi Örülen Ağ"
  },
  State_124892_Name = {
    Text = "<CardKeyWord:Kehanet>"
  },
  State_124916_Desc = {
    Text = "Tur sonunda, tüm yığınları kaldır ve [DescArg1] pasif Hasar ver. Dağıtılamaz."
  },
  State_124916_Name = {
    Text = "Mukadder Ölüm"
  },
  State_124917_Desc = {
    Text = "Tur sonunda, tüm yığınları kaldır ve pasif Hasar ver. Dağıtılamaz."
  },
  State_124917_Name = {
    Text = "<PVPDestinedDeathKeyWords:Mukadder Ölüm>"
  },
  State_124992_Desc = {
    Text = "Sonraki [DescArg1] \"Beceri\" kartı 1 ek kez etki eder."
  },
  State_124992_Name = {Text = "Aşmak"},
  State_124993_Desc = {
    Text = "Verilen ve alınan ölümcül Aktif Hasar, eşit miktarda <PVPDestinedDeathKeyWords:Kaderli Alamet> olarak uygulanır. Dağıtılamaz."
  },
  State_124993_Name = {
    Text = "Kaderin İği"
  },
  State_124997_Desc = {
    Text = "Verilen ve alınan ölümcül Aktif Hasar, eşit miktarda <PVPDestinedDeathKeyWords:Kaderli Alamet> uygulamaya dönüşür. Dağıtılamaz."
  },
  State_124997_Name = {
    Text = "<PVPEternalDimensionKeyWords:Moira, Hükmettiğim Gibi>"
  },
  State_125002_Name = {
    Text = "Durum@Genel Oyuncu Atma Aşaması Kalkan Değeri Dinleyicisi"
  },
  State_125003_Name = {
    Text = "Kalkan Değeri"
  },
  State_125004_Name = {
    Text = "Durum@Genel Oyuncu Kalkan Sayısı Uygula"
  },
  State_125472_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: «Çılgınlık Patlaması» sonrasında <HPAndShieldMax:can ve kalkanı en yüksek> düşmana [StateArg1] kat <PVPLostSoulKeyWords:büyülenme> uygular."
  },
  State_125472_Name = {
    Text = "Manolya'nın Cazibesi"
  },
  State_125486_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Diğer müttefikler \"Taşkınlık\" yaptıktan sonra, kullanan kişiye ait eldeki tüm \"Yetenekler\"in Arithmetica Maliyetini [StateArg1] azalt."
  },
  State_125486_Name = {
    Text = "Boş Kalan Pişmanlıklar"
  },
  State_125925_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_125925_Name = {
    Text = "Uyanmamış"
  },
  State_125926_Name = {
    Text = "Durum@Canavar Tawil Niyet Değiştirme Oyuncu Dinleyicisi"
  },
  State_125927_Desc = {
    Text = "[DescArg1] Komut Kartı oynadıktan sonra, Niyeti \"Altı Kanat\" olarak değiştir."
  },
  State_125927_Name = {
    Text = "Dört Kanat"
  },
  State_125928_Desc = {
    Text = "Bir Komut Kartı oynadıktan sonra, ilgili Uyanan’ın Yüceltmesini ve tüm Komut Kartlarını 2 tur boyunca mühürle."
  },
  State_125928_Name = {
    Text = "Zamanın Kanatları"
  },
  State_125929_Desc = {
    Text = "Tek bir tur içinde [DescArg1] Hasar aldıktan sonra, 70 yığın Geçici <ReinforceColour:Kale> ve 1 yığın <ResentChainsKeywords:Kin Zincirleri> kazan."
  },
  State_125929_Name = {
    Text = "Var Olmayan Varoluş"
  },
  State_125933_Desc = {
    Text = "[DescArg1] Komut Kartı oynadıktan sonra, Niyeti \"Dört Kanat\" olarak değiştir."
  },
  State_125933_Name = {
    Text = "İkiz Kanatların Açılışı"
  },
  State_125934_Desc = {
    Text = "Arithmetica tüketilirken kazanılan Keyflare %50 azaltılır. Tawil engellenmemiş Hasar verdikten sonra, ele 1 \"<DerivativeCardKeywords_131:Zaman Paradoksu EX>\" koy."
  },
  State_125934_Name = {
    Text = "Gümüş Anahtar Kapısı"
  },
  State_125935_Name = {Text = "Sessizlik"},
  State_125935_WeaponDesc = {
    Text = "Çekildiğinde, kendine 1 tur boyunca Zayıflık uygula. Kullanıldığında, tüm düşmanlara 1 tur boyunca Zayıflık uygula. Satılamaz."
  },
  State_125937_Desc = {
    Text = "Bir Komut Kartı oynadıktan sonra, ilgili Uyanan’ın Yüceltmesini ve tüm Komut Kartlarını 2 tur boyunca mühürle."
  },
  State_125937_Name = {
    Text = "Zamanın Kanatları"
  },
  State_125964_Desc = {
    Text = "Arithmetica tüketilirken, kazanılan Keyflare -%50. Tawil engellenmemiş Hasar verdikten sonra, ele 1 \"<DerivativeCardKeywords_131:Zaman Paradoksu EX>\" ekle."
  },
  State_125964_Name = {
    Text = "Gümüş Anahtar Kapısı"
  },
  State_126010_Desc = {
    Text = "Takıma Özel: Taşıyıcının Sabit Zehir ve tetiklenen Zehir Etkileri <WeaponEffect_Num:[StateArg1]%> artar ve Caro Diyarında otomatik olarak yenilenen <EmbryoFusionIconKeywords:Embriyo Füzyonu> <WeaponEffect_Num:[StateArg2]%> artar. Taşıyıcı her tur ilk kez \"Rezonans\" tetiklediğinde, diğer Uyandırıcılar <WeaponEffect_Num:[StateArg3]> Aliemus kazanır."
  },
  State_126010_WeaponDesc = {
    Text = "Taşıyıcının Sabit Zehir ve Tetiklenen Zehir Etkileri +<WeaponEffect_Num:[StateArg1]%>, ve Caro Diyarı tarafından otomatik olarak yenilenen <EmbryoFusionIconKeywords:Embriyo Füzyonu> +<WeaponEffect_Num:[StateArg2]%>. Taşıyıcı her tur ilk kez \"Rezonans\" tetiklediğinde, diğer Uyandırıcılar <WeaponEffect_Num:[StateArg3]> Aliemus kazanır."
  },
  State_126463_Name = {
    Text = "Durum@Canavar Liz Baştan Çıkarıcı Işık Hasar Dinleyicisi"
  },
  State_126464_Desc = {
    Text = "En fazla 10 yığın; her yığın, Liz’in verdiği Hasarı [DescArg1] artırır."
  },
  State_126464_Name = {
    Text = "<GreenWord:Yeşil Kıvılcım>"
  },
  State_126465_Name = {
    Text = "Canavar Liz Niyet Dinleyicisi"
  },
  State_126466_Desc = {
    Text = "Rakip, turunun sonunda elini atmayacaktır. Niyet Yeşil Alevler’e geçtiğinde: en az 6 yığın <MonsterLizVerdantSpark:Zümrüt Köz> varsa, 6 yığın tüketerek niyeti, <Damage:[Damage:DescArg1]> Hasar veren ve [AttackTimes:DescArg2] kez isabet eden \"Ölümcül Alevler\"e yükselt; en az 3 yığın varsa, 3 yığın tüketerek niyeti, <Damage:[Damage:DescArg3]> Hasar veren ve [AttackTimes:DescArg4] kez isabet eden \"Yozlaşmış Alevler\"e yükselt."
  },
  State_126466_Name = {
    Text = "Ebedî Alevler"
  },
  State_126467_Desc = {
    Text = "Bu Uyanışçı henüz Uyanmamış... Yenilmek üzereyken Uyanış’a geçecek, Can yenileyecek ve tüm Gücüyle savaşacak, “Yıkıma Dans” için olumsuz Durumları kaldırma yeteneği kazanacaktır."
  },
  State_126467_Name = {
    Text = "Uyanmamış"
  },
  State_126468_Name = {
    Text = "Durum@Canavar Liz Zümrüt Yansıma Yönetimi"
  },
  State_126469_Desc = {
    Text = "Kaybedilen her [DescArg1] CP için, [DescArg2] yığın <MonsterLizVerdantSpark:Zümrüt Kor> kazan."
  },
  State_126469_Name = {
    Text = "Zümrüt Yansıma"
  },
  State_126470_Name = {
    Text = "Durum@Canavar Liz İpucu Sayısı"
  },
  State_126479_Desc = {
    Text = "En fazla 10 yığın; Liz'in verdiği HASARı artırır."
  },
  State_126479_Name = {
    Text = "<GreenWord:Yeşil Kıvılcım>"
  },
  State_126540_Desc = {
    Text = "Rezonans bir sonraki [Layer] kez tetiklendiğinde, Rezonans etkisi ikiye katlanır."
  },
  State_126540_Name = {
    Text = "Sisle Bağlı Yemin"
  },
  State_126568_Desc = {
    Text = "Her seferinde bir Uyandırıcı Aktif Hasar verdiğinde, hedefe saldırması için 1 Dokunaç emret; [Layer]% Dokunaç Hasarı verir."
  },
  State_126568_Name = {
    Text = "Azgın Dalgalar"
  },
  State_126569_Desc = {
    Text = "<Each time the awakener deals active damage, it commands 1 tentacle to attack the target, causing 50% tentacle damage.:Uyandıran her etkin Hasar verdiğinde, hedefe saldırması için 1 Dokunaç emreder ve %50 Dokunaç Hasarı verir.>"
  },
  State_126569_Name = {
    Text = "Azgın Dalgalar"
  },
  State_126643_Desc = {
    Text = "Bu durumun Maksimum Katmanı=1. Kaynak Uyandırıcı: [DescArg1]"
  },
  State_126643_Name = {
    Text = "Sınır Seviye 1"
  },
  State_126644_Desc = {
    Text = "Elde ettikten sonra, [Layer] yığın Gösteri Durumunu temizle ve yeniden uygula. \n Gösteri Durumu için maksimum yığın sayısı 1'dir."
  },
  State_126644_Name = {
    Text = "Maksimum yığını aş"
  },
  State_126645_Desc = {
    Text = "Ramona'nın Temel Hasarı [DescArg1]% artar"
  },
  State_126645_Name = {
    Text = "Yüce Tavlama"
  },
  State_126651_Desc = {
    Text = "Av serbest bırakıldıktan sonraki dinleyici [Layer] kez karşılandı."
  },
  State_126651_Name = {Text = "Sayaç"},
  State_126652_Desc = {
    Text = "Elde ettikten sonra, ön sıradaki düşmana gecikmeli bir aksiyon eklemesini ve mevcut niyetini oynamasını emret."
  },
  State_126652_Name = {
    Text = "Canavara Av yaptır"
  },
  State_126653_Desc = {
    Text = "Elde ettikten sonra, 1. pozisyondaki Uyandırıcının Saldırı kartını oynamak için bir takip aksiyonu eklemesine izin ver."
  },
  State_126653_Name = {
    Text = "Uyandırıcıya Av Emri Ver"
  },
  State_126654_Desc = {
    Text = "İsimli Dinleyici tetiklendiğinde, sayımı 1 kez yazdır."
  },
  State_126654_Name = {
    Text = "İsimli Dinleyici"
  },
  State_126655_Desc = {
    Text = "Elde ettikten sonra, Koruyucuya bir takip aksiyonu eklemesini ve @Protagonist Skill@Kafandaki Sesler becerisini oynamasını emret."
  },
  State_126655_Name = {
    Text = "Koruyucuya Av emri ver"
  },
  State_126677_Desc = {
    Text = "Bu tur, bir sonraki [Layer] \"İsyan Kılıcı\" iki kez etkisini gösterir."
  },
  State_126677_Name = {
    Text = "İlksel Leviathan"
  },
  State_126678_WeaponDesc = {
    Text = "Tüm Balina Sıçrayışı Sıçrama Hasarı örnekleri +1."
  },
  State_126714_Desc = {
    Text = "Aigis’in bir sonraki [Layer] \"Savunma\"sı 3 kez etkisini gösterir."
  },
  State_126714_Name = {
    Text = "Kristalleşmiş Gözyaşı"
  },
  State_126714_WeaponDesc = {
    Text = "Tüm Balina Sıçrayışı Sıçrama Hasarı örnekleri +1."
  },
  State_126715_WeaponDesc = {
    Text = "Tüm Balina Sıçrayışı Sıçrama Hasarı örnekleri +1."
  },
  State_126776_Desc = {
    Text = "Her yığın için, alınan Sabit Zehir +%5, verilen Hasar -[DescArg1]%. En fazla [DescArg2] yığına kadar birikir."
  },
  State_126776_Name = {
    Text = "<WitherKeywords:Büyüyle Bağlı>"
  },
  State_126783_Name = {
    Text = "Geçici olarak kullanımdan kaldırıldı"
  },
  State_126784_Desc = {
    Text = "Alınan Sabit Zehir +[DescArg1]%, verilen Hasar -[DescArg2]%. En fazla [DescArg3] yığına kadar birikir."
  },
  State_126784_Name = {
    Text = "Büyüyle Bağlı"
  },
  State_126785_Desc = {
    Text = "Diğer Uyandıranlar toplamda X Komut Kartı oynadıysa, bu kartı oynadıktan sonra takip eden etkileri tetikle. Bu karta ait olan Uyandıran’ın Rezonansı, herhangi bir kartı oynandığında veya turun sonunda sıfırlanır."
  },
  State_126785_Name = {
    Text = "<ResonanceKeywords:Rezonans X>"
  },
  State_126789_Desc = {
    Text = "Tüm düşmanlara 2 yığın <WitherKeywords:Büyüyle Bağlı> uygula."
  },
  State_126789_Name = {
    Text = "<WitherKeywords1:Nişanla>"
  },
  State_126790_Desc = {
    Text = "Tüm düşmanların <WitherKeywords:Büyülenmiş> hâlini kaldır. Kaldırılan her yığın için, hedefin Maksimum HP'sinin [DescArg1]%'i kadar Sabit Hasar ver ve %40 Zehir tetikle."
  },
  State_126790_Name = {
    Text = "<WitherKeywords2:Büyüle>"
  },
  State_126803_Desc = {
    Text = "Sonraki [DescArg1] Komut Kartı, 3 tur sonrasındaki geleceğe gönderilecek."
  },
  State_126803_Name = {
    Text = "Orbis Fatum"
  },
  State_126893_Name = {
    Text = "Durum@Kader Ultra Saf Tanımlayıcı"
  },
  State_126895_Desc = {
    Text = "Bu kartın Final Hasarı, Sabit <PowerIconKeywords:Güç> & <TentacleInjurieIconKeywords:Dokunaç Hasarı> kazanımı, Sabit <IntoxicationIconKeywords:Zehir> & <RetaliateIconKeywords:Karşı Atak> her biri +[DescArg1]%; Bu kartın Final Sabit Kalkanı, Sabit HP Yenilenmesi ve <ExhaustionIconKeywords:Güç Azalması> her biri +[DescArg2]%. \"Tekillik Feneri\" olan kartlar \"Boyut Mekiği\"ni tetikleyemez."
  },
  State_126895_Name = {
    Text = "<SingularityKeywords:Tekillik Feneri [DescArg2]>"
  },
  State_126896_Name = {
    Text = "Durum@Aşkınlık Işığı Kartı Arithmetica Uyumu yığınlarını azaltır"
  },
  State_126900_Name = {
    Text = "Durum@Kader Ultra Boyut Sınıfı Başlatma 2"
  },
  State_126901_Name = {
    Text = "Durum@Kader Ultra Boyut Sınıfı Başlatma 1"
  },
  State_126903_Name = {
    Text = "Durum@Ultra Uzay Kuasar İşaretçisi"
  },
  State_126927_Desc = {
    Text = "Takıma Özel: Kuşanan tarafından verilen Sabit Zehir ve Tetiklenen Zehir Etkileri +<WeaponEffect_Num:[StateArg1]%>. Kuşanan, her tur ilk kez \"Rezonans\" tetiklediğinde <WeaponEffect_Num:[StateArg2]> Aliemus kazanır."
  },
  State_126927_WeaponDesc = {
    Text = "Kuşanan tarafından verilen Sabit Zehir ve Tetiklenen Zehir Etkileri +<WeaponEffect_Num:[StateArg1]%>. Kuşanan, her tur ilk kez \"Rezonans\" tetiklediğinde <WeaponEffect_Num:[StateArg2]> Aliemus kazanır."
  },
  State_126990_Name = {
    Text = "<IntoxicationColour:Zehir>"
  },
  State_127108_Desc = {
    Text = "Tüm düşmanlara 5 yığın <WitherKeywords:Spellbound> uygula."
  },
  State_127108_Name = {
    Text = "<WitherKeywords3:Nişanla>"
  },
  State_127109_Desc = {
    Text = "Tüm düşmanların <WitherKeywords:Büyülenmiş> etkisini kaldır, her 1 kat kaldırıldığında KON'un %20'si kadar Kızıl Ocak biriktir, hedefin Maksimum can'ının [DescArg1]%'i kadar Sabit Hasar ver ve %40 Zehir'ini tetikle."
  },
  State_127109_Name = {
    Text = "<WitherKeywords4:Büyüle>"
  },
  State_127176_Desc = {
    Text = "Her yığın için, alınan Sabit Zehir +%5, verilen Hasar -[DescArg1]%. En fazla [DescArg2] yığına kadar birikir."
  },
  State_127176_Name = {
    Text = "<WitherKeywords0:Büyülenmiş>"
  },
  State_127264_Desc = {
    Text = "Bu kartı oynarken, \"Algılayan\" 1 yığın <MonsterTimeBeacon:Loop> kazanır. Bu kart atılırsa, \"Algılayan\" 1 yığın <MonsterTimeBeacon:Loop> kaybeder."
  },
  State_127264_Name = {
    Text = "<MonsterSightUnbound:Kurtulmuş Bakış>"
  },
  State_127266_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_127266_Name = {
    Text = "Uyanmamış"
  },
  State_127267_Desc = {
    Text = "Turun sonunda, 1 yığın <MonsterTimeBeacon:Loop> kazan."
  },
  State_127267_Name = {
    Text = "Entropi Tersine Çevrildi"
  },
  State_127271_Desc = {
    Text = "Çeteyi serbest bıraktıktan sonra, 1 yığın <MonsterTimeBeacon:Loop> kazan."
  },
  State_127271_Name = {
    Text = "Möbius Tutsak"
  },
  State_127272_Desc = {
    Text = "En fazla 3 yığın. \"Algılayan\" 3 yığın <MonsterTimeBeacon:Loop> ile niyet serbest bıraktığında, <MonsterTimeBeacon:Loop> etkisini tetikle, <MonsterTimeBeacon:Loop>’u temizle ve olumsuz durumları kaldır."
  },
  State_127272_Name = {
    Text = "<WhiteWord:Döngü>"
  },
  State_127275_Desc = {
    Text = "Her yığın için, alınan Sabit Zehir +%5, verilen Hasar -[DescArg1]%. En fazla [DescArg2] yığına kadar birikir."
  },
  State_127275_Name = {
    Text = "<WitherKeywords:Büyüyle Bağlı>"
  },
  State_127276_Desc = {
    Text = "Bu kartı oynarken, \"Algılayan\" 1 yığın <MonsterTimeBeacon:Loop> kazanır. Bu kart atılırsa, \"Algılayan\" 1 yığın <MonsterTimeBeacon:Loop> kaybeder."
  },
  State_127276_Name = {
    Text = "<MonsterSightUnbound:Kurtulmuş Bakış>"
  },
  State_127312_Desc = {
    Text = "<When the Psyche Surge of the Awakener reaches +12, the \"Absolute Axiom\" is activated, granting unique effects.:Uyandıran’ın Kişilik Derinleşmesi +12’ye ulaştığında “Mutlak Aksiyom” etkinleşir ve ona özgü etkiler bahşeder.>"
  },
  State_127312_Name = {
    Text = "<UltraPotencyKeywords:Nihai Kural>"
  },
  State_127705_Desc = {
    Text = "Kart kurcalandı! Oynanınca [Layer] hasar al. <CardKeyWord:Sabotaj> yığınlarını yarıya indir."
  },
  State_127705_Name = {
    Text = "<CardKeyWord:Sabotaj>"
  },
  State_127705_WeaponDesc = {
    Text = "Kart oynandığında [StateArg1] hasar alır."
  },
  State_127708_Desc = {
    Text = "Düşman bir Komut Kartı olmayan kart oynadığında, tüm müttefikler [DescArg1] yığın <PowerIconKeywords:Strength> kazanır. Eski Günlerin Közleri Kırıldıktan sonra etkisiz hale gelir."
  },
  State_127708_Name = {
    Text = "Kaos İpliği"
  },
  State_127709_Name = {
    Text = "Kara İpliğin Oyuncu Durumu"
  },
  State_127710_Name = {
    Text = "Kara İplik Tetikleyicisi"
  },
  State_128026_Name = {
    Text = "Beyaz İplik Oyuncu Durumu"
  },
  State_128027_Desc = {
    Text = "Düşman bir Komut Kartı oynadıktan sonra, tüm dostlar [DescArg1] yığın Geçici <ReinforcePVEKeywords:Güçlendirilmiş> kazanır. Kadim Korlar kırıldıktan sonra etkisiz hale gelir."
  },
  State_128027_Name = {
    Text = "Düzen İpliği"
  },
  State_128028_Desc = {
    Text = "Kart kurcalandı! Oynanınca <FixedDamage:Saf Hasar> al, ardından <BrokenCard:Sabotaj> yığınlarını yarıya indir."
  },
  State_128028_Name = {
    Text = "<CardKeyWord:Sabotaj>"
  },
  State_128028_WeaponDesc = {
    Text = "Kart oynandığında [StateArg1] hasar alır."
  },
  State_128029_Name = {
    Text = "Beyaz İplik Tetikleyicisi"
  },
  State_128067_Name = {
    Text = "Durum@Soğuk Örümcek Hizmetçi Kül Dinleyicisi"
  },
  State_128069_Name = {
    Text = "Durum@Soğuk Örümcek Hizmetçi Sarmalamak Vuruş Algılama"
  },
  State_128071_Name = {
    Text = "Durum@Soğuk Örümcek Hizmetçi Ön Konum Çağırma İşaretçisi Gerektirir"
  },
  State_128073_Desc = {
    Text = "Her eylem sona erdikten sonra [DescArg1] yığın <ParcloseIconKeywords:Bariyer> ve [DescArg2] yığın <Chapter5_Monster_Fervor1:Coşku> kazanır."
  },
  State_128073_Name = {
    Text = "Dokumacı Ana Beşiği"
  },
  State_128082_Desc = {
    Text = "Bu kartı oynayarak Hameln'e 3 Aliemus bahşet."
  },
  State_128082_Name = {
    Text = "<XushiBKeywords:Yükselen Ezgi>"
  },
  State_128086_Desc = {
    Text = "Düşman bir Komut Kartı oynadıktan sonra, [DescArg1] yığın <Chapter5_Monster_Fervor1:Coşku> kazan ve \"\"Kadim Korlar\"\" tükendiğinde arka sıradaki müttefikinle yer değiştir."
  },
  State_128086_Name = {
    Text = "Kaderin Devrimi"
  },
  State_128087_Name = {
    Text = "Durum@Soğuk Örümcek Hizmetçi Beyaz Döngü Tetikleyici İşaretçisi"
  },
  State_128089_Name = {
    Text = "Beyaz Döngü Tetikleyicisi"
  },
  State_128216_Name = {
    Text = "Beyaz Döngü Oyuncu Durumu"
  },
  State_128245_Desc = {
    Text = "Tur başında temizlenir. 10 yığına ulaştığında, bir sonraki kart oynandığında derhal harekete geç, <Chapter5_Monster_Fervor2:Fervor>u kaldır ve Niyeti, <FragileIconKeywords:Fragile> yüklemeye ve rastgele <BrokenCard:Sabotage> “Çöküş İpliği” eklemeye çevir."
  },
  State_128245_Name = {
    Text = "Geçici Coşku"
  },
  State_128246_Name = {
    Text = "Kara Döngü Oyuncu Durumu"
  },
  State_128247_Desc = {
    Text = "Ölümün ardından Hasara Bağışıklık ve %100 Can ile canlan. Niyeti “Kaderî Coşku”ya çevir: Her eylemden sonra [DescArg1] <PowerIconKeywords:Strength> ve [DescArg2] <Chapter5_Monster_Fervor2:Fervor> kazan."
  },
  State_128247_Name = {
    Text = "Koza Yeniden Doğuşu"
  },
  State_128248_Desc = {
    Text = "Tur başlarken temizlenir. 10 yığına ulaştığında, bir sonraki kart oynandığında derhal harekete geç, <Chapter5_Monster_Fervor1:Fervor>u kaldır ve Niyeti, <WeaknessIconKeywords:Weakness> yükleyen ve Komut Kartlarını rastgele Mühürleyen \"Esaret Ağı\" na çevir."
  },
  State_128248_Name = {
    Text = "Geçici Coşku"
  },
  State_128250_Name = {
    Text = "Kara Döngü Tetikleyicisi"
  },
  State_128251_Desc = {
    Text = "Düşman bir Komut Kartı oynadıktan sonra, [DescArg1] yığın <Chapter5_Monster_Fervor1:Coşku> kazan ve \"\"Kadim Korlar\"\" tükendiğinde arka sıradaki müttefikinle yer değiştir."
  },
  State_128251_Name = {
    Text = "Uçurum Hapishanesi Devrimi"
  },
  State_128253_Desc = {
    Text = "Öldükten sonra Hasara Bağışıklık ve %100 Can ile canlan. Niyeti “Kaderî Coşku”ya çevir: Her eylemden sonra [DescArg1] yığın <ParcloseIconKeywords:Barrier> ve [DescArg2] yığın <Chapter5_Monster_Fervor1:Fervor> kazan."
  },
  State_128253_Name = {
    Text = "Koza Yeniden Doğuşu"
  },
  State_128257_Desc = {
    Text = "Her eylem sona erdikten sonra [DescArg1] <PowerIconKeywords:GÜÇ> ve [DescArg2] yığın <Chapter5_Monster_Fervor2:Coşku> kazanır."
  },
  State_128257_Name = {
    Text = "Dokumacı Ananın Fısıltısı"
  },
  State_128643_Name = {
    Text = "Durum@Oyuncu Bu Tur Belirti Oynama Sayısı"
  },
  State_128644_Desc = {
    Text = "Turun başında sıfırlanır. 10 yığına ulaştıktan sonra, bir sonraki kart oynandığında hemen harekete geçer, <Chapter5_Monster_Fervor3:Coşku>'yu kaldırır ve niyeti rastgele değiştirir."
  },
  State_128644_Name = {
    Text = "Geçici Coşku"
  },
  State_128645_Desc = {
    Text = "Niyet, dört türden rastgele seçilir ama tekrar etmez. Bir Aşma serbest bırakıldıktan sonra niyet derhal değişir. Bir Komut Kartı oynadıktan sonra 1 yığın <Chapter5_Monster_Fervor3:Coşku> kazan."
  },
  State_128645_Name = {
    Text = "Omnifex Ahenk"
  },
  State_128646_Name = {
    Text = "Durum@Çılgın Kader Diskalifiye Ağır Darbe Oynama Algılama"
  },
  State_128648_Desc = {
    Text = "Bir sonraki turun başına kadar, her Komut Kartı oynadığınızda [DescArg1] Geçici <PowerIconKeywords:GÜÇ> kazanırsınız."
  },
  State_128648_Name = {
    Text = "Hiddet Kozası"
  },
  State_128692_Desc = {
    Text = "Aktif hasar veya Dokunaç hasarı aldıktan sonra, eşit miktarda \"Eski Korlar\"ı kaldır ve kaldırılan miktarın %300'ü kadar can kaybı yaşa; diğer hasarları alırken yarısını kaldır. \"Eski Korlar\" sayısı her turda sıfırlanır."
  },
  State_128692_Name = {
    Text = "<AshesPastKeyWord:Eski Günlerin Közleri>"
  },
  State_128695_Name = {
    Text = "Durum@Çılgın Kader Niyet İşaretçisi"
  },
  State_129297_Desc = {
    Text = "Sonraki [Layer] Savaş’ın başında, tüm düşmanların Canını 1’e ayarla."
  },
  State_129297_Name = {
    Text = "Küçük N'in Yardımı"
  },
  State_129569_Name = {
    Text = "Durum@Çılgın Kader Haz Tiyatrosu Tetikleme İşaretçisi"
  },
  State_129570_Name = {
    Text = "Durum@Çılgın Kader Kader Fısıltısı Tetikleme İşaretçisi"
  },
  State_129571_Name = {
    Text = "Durum@Çılgın Kader Sonsuz Yokluk Tetikleme İşaretçisi"
  },
  State_129612_Desc = {
    Text = "Niyet, dört türden rastgele seçilir ama tekrar etmez. Bir Aşma serbest bırakıldıktan sonra niyet derhal değişir. Bir Komut Kartı oynadıktan sonra 1 yığın <Chapter5_Monster_Fervor3:Coşku> kazan."
  },
  State_129612_Name = {
    Text = "Omnifex Ahenk"
  },
  State_129625_Desc = {
    Text = "Niyet, dört türden rastgele seçilir ama tekrar etmez. Bir Aşma serbest bırakıldıktan sonra niyet derhal değişir. Bir Komut Kartı oynadıktan sonra 1 yığın <Chapter5_Monster_Fervor3:Coşku> kazan. Niyet her değiştiğinde 1 yığın \"Bükülme Kaynaşması\" kazan."
  },
  State_129625_Name = {
    Text = "Omnifex Ahenk"
  },
  State_129643_Desc = {
    Text = "Niyet her değiştirildiğinde 1 yığın kazanılır. 10 yığın \"Çözülmüş Kader\" varken, niyet değiştirilemez \"Çılgın Belirme\" olarak değişir; bu, büyük Hasar verir ve olumsuz etkiler uygular."
  },
  State_129643_Name = {
    Text = "Bükülmüş Erime"
  },
  State_129644_Name = {
    Text = "Bükülmüş Erime Kilidi Niyetleri"
  },
  State_129650_Desc = {
    Text = "Takım Özgünlüğü: Kullanan Uyandırıcı \"Döngü·Ramona\" ise, aşama tamamlandığında diğer Uyandırıcıların kazandığı Afinite +<WeaponEffect_Num:[StateArg1]%>, ancak kullanan hiç Afinite kazanmaz."
  },
  State_129650_WeaponDesc = {
    Text = "Kullanan kişi Uyandırıcı \"Döngü·Ramona\" ise, bir Aşama tamamlandığında diğer Uyandırıcılar +<WeaponEffect_Num:[StateArg1]%> Afinite kazanır, ancak kullanan kişi herhangi bir Afinite kazanmaz."
  },
  State_129761_Desc = {
    Text = "Oyuncular için oyun içi büyüme yoğunluğunu döndüren arayüzü değiştirin, her yığın başına %1 artış sağlayın."
  },
  State_129761_Name = {
    Text = "Oyun İçi Büyüme Yoğunluğu Ayarı"
  },
  State_129845_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_129845_Name = {
    Text = "Uyanmamış"
  },
  State_129846_Name = {
    Text = "Uzamsal Sarsıntı Sayısı"
  },
  State_129848_Desc = {
    Text = "Boyutsal Yarık’tan her [DescArg1] kart ayrıldığında, onlara [DescArg2] yığın <BrokenCard:Sabotaj> ver."
  },
  State_129848_Name = {
    Text = "Gelecek Kesimi"
  },
  State_129849_Desc = {
    Text = "Her tur, düşman tarafından oynanan ilk Komut Kartının bir kopyasını yarat ve onu Boyutsal Yarık’a yerleştir. Kart Boyutsal Yarık’a girdiğinde, ona <DepleteIconKeywords:Tüketme> bahşet. Her tur bir Çete ilk kez Serbest Bırakıldığında, en soldaki kartı dışarı çıkar ve Çekme Deste­sinin üstüne yerleştir."
  },
  State_129849_Name = {
    Text = "Kaderi Örme"
  },
  State_129850_Desc = {
    Text = "Boyutsal Yarık’taki her Komut Kartı için oyuncunun el sınırı 1 azalır. Zaten doluysa, bir sonraki kart oynandığında \"Ebedi Ağ\" derhal harekete geçer, Boyutsal Yarık’ı temizler ve niyeti \"Kaderi Aşan Ağıt\"a ayarlar."
  },
  State_129850_Name = {
    Text = "Uzaysal Sarsıntı"
  },
  State_129854_Desc = {
    Text = "Boyutsal Yarık'taki her Komut Kartı için oyuncunun el limiti 1 azalır. Eğer zaten doluysa, bir sonraki kart oynandığında \"Ebedi Ağ\" derhal harekete geçer, Boyutsal Yarık'ı temizler ve niyeti \"Kaderin Çarkı\" olarak ayarlar."
  },
  State_129854_Name = {
    Text = "Uzaysal Sarsıntı"
  },
  State_129864_Desc = {
    Text = "<Remove 1 layer of \"Drowsiness\" whenever a card is played. At the start of the turn, restore to 12 layers of \"Drowsiness\".:Her kart oynandığında “Uyuşukluk”tan 1 katman kaldır. Tur başında “Uyuşukluk”u yeniden 12 katmana çıkar.>"
  },
  State_129864_Name = {Text = "Öfke"},
  State_129865_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_129865_Name = {
    Text = "Uyanmamış"
  },
  State_129872_Desc = {
    Text = "Geçici değişken."
  },
  State_129872_Name = {
    Text = "Karşı Saldırı 1"
  },
  State_129873_Desc = {
    Text = "[Layer] yığın Durum _Karşı Saldırı1_ kazan."
  },
  State_129873_Name = {
    Text = "Kapsülleme Testi 1"
  },
  State_129874_Desc = {
    Text = "Geçici değişken."
  },
  State_129874_Name = {
    Text = "Yükseltici 1"
  },
  State_130358_Desc = {
    Text = "Oynanan bir sonraki Komut Kartı 2 ek kez etkisini gösterir."
  },
  State_130358_Name = {Text = "Marionet"},
  State_130387_Desc = {
    Text = "\"Marionette\" Tüketme ile oyundan çıkarıldıktan sonra, sonraki her turda oynanan ilk Komut Kartı 2 ek kez etkisini gösterir. Eğer bir Reis Savaşı ise, tüm Uyananlar 50 Aliemus ve 1000 Keyflare kazanır."
  },
  State_130387_Name = {
    Text = "Kaderin Cenazesi"
  },
  State_130388_Name = {
    Text = "<RetainIconKeywords:Retain>: [DescArg1] Keyflare kazan."
  },
  State_130389_Desc = {
    Text = "Oynandığında, tüm Uyananlara [DescArg1] Aliemus bahşet."
  },
  State_130389_Name = {
    Text = "Oynandığında, tüm Uyananlara [DescArg1] Aliemus bahşet."
  },
  State_130390_Desc = {
    Text = "Arithmetica Sınırı ve Maksimum El Boyutu 1 artar."
  },
  State_130390_Name = {
    Text = "Yinelenen Profil"
  },
  State_130391_Desc = {
    Text = "Her 1 “Semptom kartı” oynadığında, “Marionette”in Arithmetica Maliyeti 1 azalır."
  },
  State_130391_Name = {
    Text = "Kirliliğin Yankıları"
  },
  State_130490_Desc = {
    Text = "Bu kartın sağladığı Hasar, Karakter Kalkanı, İyileştirme, Güç, Sömürü, Dokunaç Hasarı, sabit Zehir ve sabit Sayaç miktarları, çarpımsal olarak 1+[Layer]% şeklinde hesaplanarak artırılır."
  },
  State_130490_Name = {
    Text = "Tekillik Feneri α"
  },
  State_130498_Desc = {
    Text = "Oynanan bir sonraki Komut Kartı 2 ek kez etkisini gösterir."
  },
  State_130498_Name = {
    Text = "Kaderin Cenazesi"
  },
  State_130500_Desc = {
    Text = "Reis Savaşı’nda Ölüm Direnci +%100. “Marionette” “Ölüm Direnci”ni tetikledikten sonra, bir sonraki turda artık zorla bir Komut Kartı oynatmaz; bunun yerine elinden bir Komut Kartı seç."
  },
  State_130500_Name = {
    Text = "Şehidin Bakışı"
  },
  State_130501_Desc = {
    Text = "Bir sonraki Komut Kartının Arithmetica Maliyeti 0’a düşer."
  },
  State_130501_WeaponDesc = {
    Text = "Oynamadan önce kartın Arithmetica’sını değiştir"
  },
  State_130512_Desc = {
    Text = "Oynanan bir sonraki Komut Kartı 2 ek kez etkisini gösterir ve Arithmetica Maliyeti 2 azalır."
  },
  State_130512_Name = {Text = "Marionet"},
  State_130517_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında ve tur başında, aşağıdaki etkilerden birini rastgele tetikler: <Energy:[Energy:StateArg1]> Aliemus kazanır ve kendisine <PVPSlowKeywords:Durgunluk> uygular; <Energy:[Energy:StateArg3]> Aliemus kazanır; <Energy:[Energy:StateArg4]> ve [StateArg5] adet <PVPDerivativeCardKeywords_17:\"İlham\"> kazanır."
  },
  State_130517_Name = {
    Text = "Bilgeliğin Kazıkları"
  },
  State_131046_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Yüceltim\"den sonra, kendine <Block:[Block:StateArg1]> Karakter Kalkanı ve <DelayKeywords:Gecikme>: <Energy:[Energy:StateArg2]> Aliemus ver."
  },
  State_131046_Name = {
    Text = "Uzak Cennet"
  },
  State_131047_Desc = {
    Text = "Bu tur, bir sonraki [Layer] Posse kullanımı iki kez Etki gösterir."
  },
  State_131047_Name = {
    Text = "İkili Müfreze"
  },
  State_131048_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Her turda ilk kez «Beceri» oynadıktan sonra <HPAndShieldMin:can ve kalkanı en düşük> düşmana <Damage:[Damage:StateArg1]> hasar verir."
  },
  State_131048_Name = {
    Text = "Hapsedilmiş Delilik"
  },
  State_131055_Desc = {
    Text = "<Draw -1 card each turn. All Awakeners' Shield and health recovery are increased by 20%.:Her tur 1 kart daha az çek. Tüm Uyandıranların Karakter Kalkanı ve Can yenilemesi %20 artar.>"
  },
  State_131055_Name = {
    Text = "Çene Kaşıma"
  },
  State_131056_Desc = {
    Text = "HP kaybettikten sonra, eşit miktarda Gecikmeli Aliemus’u Karakter Kalkanına dönüştür."
  },
  State_131056_Name = {
    Text = "Girdap Karakter Kalkanı"
  },
  State_131058_Desc = {
    Text = "Tüm Uyandıranların Temel Aliemus’u +10. Taşkınlık serbest bırakıldıktan sonra 1 Arithmetica kazanılır ve her Uyandıran bunu tur başına yalnızca bir kez tetikleyebilir."
  },
  State_131058_Name = {
    Text = "Yanak Sürtünmeleri"
  },
  State_131059_Name = {
    Text = "Vortice Nihai Yükseltme İşareti"
  },
  State_131061_Desc = {
    Text = "<Silver Key Energy Cap and Key Token Consumption Silver Key Energy +350. The first Key Token takes effect 2 times each turn.:Gümüş Anahtar Enerji Sınırı ve Anahtar Jetonu Tüketimi Gümüş Anahtar Enerjisi +350. Her tur ilk Anahtar Jetonu 2 kez etkisini gösterir.>"
  },
  State_131061_Name = {
    Text = "Su Samurunu Besle"
  },
  State_131064_Desc = {
    Text = "<Gain 1 Power after unleashing Frenzy Burst, and each Awakener can only trigger it once per turn.:Çılgın Patlama’yı Serbest Bıraktıktan sonra 1 Güç kazan ve her Uyandıran bunu tur başına yalnızca bir kez tetikleyebilir.>"
  },
  State_131064_Name = {
    Text = "Yanak Sürtünmeleri"
  },
  State_131069_Desc = {
    Text = "Tüm Uyandıranların Karakter Kalkanı Üretimi ve HP Yenilenmesi +%20."
  },
  State_131069_Name = {
    Text = "Çene Kaşıma"
  },
  State_131073_Desc = {
    Text = "Takıma Özel: Savaşın başında, Temel Aliemus’un <WeaponEffect_Num:[StateArg1]%>’üne eşit Aliemus kazan. Kullanıcının Yüceliş Final Hasarı, Temel Aliemus’un <WeaponEffect_Num:[StateArg2]%>’ine eşit bir yüzde kadar artar.\n\"Azgın Dalgalar\" duruşuna geçerken, mevcut Diyar Ustalığı’na göre <WeaponEffect_Num:[StateArg3]%> oranında Geçici Diyar Ustalığı kazan. 3 tur bekleme süresi."
  },
  State_131073_WeaponDesc = {
    Text = "Savaşın başında [DescArg1] Aliemus kazan. Kuşananın Yüceliş Final Hasarı +[DescArg2]%.\n \"Azgın Dalgalar\" duruşuna geçerken [DescArg3] Geçici Diyar Ustalığı kazan. 3 turluk bekleme süresi(Kalan turlar: [DescArg4])."
  },
  State_131078_Desc = {
    Text = "<The first Posse activation each turn takes effect twice.:Her tur ilk Çete etkinleşmesi iki kez etkisini gösterir.>"
  },
  State_131078_Name = {
    Text = "Su Samurunu Besle"
  },
  State_131118_Desc = {
    Text = "Hasar aldığınızda veya Can kaybettiğinizde, bu miktar Maksimum Can'ın %5'ini aşamaz."
  },
  State_131118_Name = {
    Text = "Kader Kozası"
  },
  State_131123_Desc = {
    Text = "Turun başında temizlenir. 10 yığına ulaştıktan sonra, bir kart oynandığında derhal harekete geç ve bir sonraki niyete geç, <Chapter5_Monster_Fervor4:Fervor> kaldırılır."
  },
  State_131123_Name = {
    Text = "Geçici Coşku"
  },
  State_131127_Desc = {
    Text = "Kader'e bağlı bir duruş. Düşman her 1 Komut Kartı oynadığında, Karanlık Arachne 1 yığın \"Geçici Coşku\" kazanır."
  },
  State_131127_Name = {
    Text = "Kaderin Yeminlisi"
  },
  State_131134_Desc = {
    Text = "Ölümün ardından Nefraea, [DescArg1] yığın Geçici Coşku kazanır ancak Maksimum Can'ının %3'ünü kaybeder."
  },
  State_131134_Name = {
    Text = "Huzursuzluk"
  },
  State_131186_Desc = {
    Text = "1 kez daha etki eder, ancak oynanmasının ardından [DescArg1] Hasar alırsın."
  },
  State_131186_Name = {
    Text = "<ExclamationPointColour:Paramparça Kader>"
  },
  State_131188_Desc = {
    Text = "Oynanan \"Beceri\", \"Boyutsal Yarık\"a girer ve aynı isimdeki tüm Becerilere \"Kader Parçası\" ekler; Boyutsal Yarık'tan çıkıldığında temizlenir. Boyutsal Yarık dolduğunda, \"İhanet Ağı\" Nefraea eyleminin ardından onu temizler ve bir sonraki niyeti güçlü bir Taşkınlık'a dönüştürür."
  },
  State_131188_Name = {
    Text = "Boyutsal Yarık"
  },
  State_131191_Name = {
    Text = "Bilişsel Bozulma"
  },
  State_131242_Desc = {
    Text = "Bu kartın sağladığı Hasar, Karakter Kalkanı, İyileştirme, Güç, Sömürü, Dokunaç Hasarı, sabit Zehir ve sabit Sayaç miktarları, çarpımsal olarak 1+[Layer]% şeklinde hesaplanarak artırılır."
  },
  State_131242_Name = {
    Text = "Tekillik Feneri β"
  },
  State_131258_Desc = {
    Text = "Kader çarkının ipliklerini döndürür, yanlış kaderi bozar. Keyflare serbest bırakıldıktan veya \"Kader Kalıntısı\" kartı oynanıldıktan sonra 1 yığın kaldırılır; tümü kaldırıldığında Arachne \"Yerli Yerinde İplikler\" takip saldırısı gerçekleştirir ve yüksek hasar verir. 3 kez serbest bırakıldıktan sonra düşmanın \"Sonsuz Yumak\" kozasını tamamen parçalar!"
  },
  State_131258_Name = {
    Text = "Kader Bozulması"
  },
  State_131261_Name = {
    Text = "Arachne'nin Tiyatrosu"
  },
  State_131351_Desc = {
    Text = "Diğer Uyanışçılar Taşkınlık serbest bıraktıktan sonra, 1 yük tüket ve Vortice, bir Av olarak \"Girdap! Kabuğu!\"nu serbest bırakır."
  },
  State_131351_Name = {
    Text = "Girdap Yeniden Yükleme"
  },
  State_131439_Desc = {
    Text = "Oynanan bir sonraki Komut Kartı 2 ek kez etkisini gösterir ve Arithmetica Maliyeti 0’a düşer."
  },
  State_131439_Name = {Text = "Marionet"},
  State_131637_Desc = {
    Text = "Ölüm anında, rastgele bir \"Uçurum Örümcek Kümesi\" veya \"Leng Örümcek Kümesi\" çağırır ve onun \"Küme Etkisi\"ni 1 yığın azaltır."
  },
  State_131637_Name = {
    Text = "Küme Etkisi"
  },
  State_131638_Desc = {
    Text = "Ölüm anında, rastgele bir \"Kırık Ana\" veya \"İpek Hayalet Ana\" çağırır ve onun \"Küme Etkisi\"ni 1 yığın azaltır."
  },
  State_131638_Name = {
    Text = "Küme Etkisi"
  },
  State_131645_Desc = {
    Text = "Takıma Özel: \"Azgın Dalgalar\" duruşuna geçerken, mevcut Diyar Ustalığının <WeaponEffect_Num:[StateArg1]%>’üne eşit Geçici Diyar Ustalığı kazan. 3 turluk bekleme süresi."
  },
  State_131645_WeaponDesc = {
    Text = "\"Azgın Dalgalar\" duruşuna geçerken [DescArg2] Geçici Diyar Ustalığı kazan. 3 turluk bekleme süresi (Kalan tur: [DescArg1])."
  },
  State_131657_Desc = {
    Text = "Diğer Uyanışçılar Taşkınlık serbest bıraktıktan sonra, 1 yük tüket ve Vortice, bir Av olarak \"Girdap! Kabuğu!\"nu serbest bırakır."
  },
  State_131657_Name = {
    Text = "<WhirlpoolKeywords:Girdap Yeniden Yükleme>"
  },
  State_131660_Desc = {
    Text = "Her yığın için, Yüceltim’i serbest bırakmak için gereken Aliemus 1 artar."
  },
  State_131660_Name = {
    Text = "Aliemus Tüketimi Sayı Ayarı"
  },
  State_131675_Desc = {
    Text = "Bu Kartın, bir sonraki oynanışında, etkisini 1 kez daha uygulama ihtimali [StateArg1]%’dir."
  },
  State_131675_Name = {
    Text = "<CardKeyWord:Kumar>"
  },
  State_131684_Desc = {
    Text = "Sonraki [Layer] \"Girdap! Kabuk!\" kullanımı iki kez etki eder."
  },
  State_131684_Name = {
    Text = "Moskstraumen! GÜM!"
  },
  State_131749_Desc = {
    Text = "Takıma Özel: Keşif başladıktan sonra, Çekme Desteğine 1 \"Hikmet Kazıkları\" karıştır. \"Hikmet Kazıkları\": Maliyet 1 Arithmetica. Eldeki tüm Komut Kartlarını rastgele Çekme Desteğine karıştır. Karıştırılan Komut Kartlarının, bir sonraki oynanışlarında 1 kez daha etkili olma ihtimali <WeaponEffect_Num:[StateArg1]%>’dir ve içeri karıştırılan her Komut Kartı için tüm Uyanışçılar 2 Aliemus kazanır. <RetainIconKeywords:Elde>. <DepleteIconKeywords:Tüketme>. <GuyouKeywords:Doğuştan>."
  },
  State_131749_WeaponDesc = {
    Text = "Keşif başladıktan sonra, Çekme Desteğine 1 \"Hikmet Kazıkları\" karıştır. \"Hikmet Kazıkları\": Maliyet 1 Arithmetica. Eldeki tüm Komut Kartlarını rastgele Çekme Desteğine karıştır; karıştırılan Komut Kartlarının, bir sonraki oynanışlarında 1 kez daha etkili olma ihtimali <WeaponEffect_Num:[StateArg1]%>’dir ve içeri karıştırılan her Komut Kartı için tüm Uyanışçılar 2 Aliemus kazanır. <RetainIconKeywords:Elde>. <DepleteIconKeywords:Tüketme>. <GuyouKeywords:Doğuştan>."
  },
  State_131769_Name = {
    Text = "Durum@Üreme Caro Sınıf Başlatma 1"
  },
  State_131779_Desc = {
    Text = "Yalnızca [Layer] kez kullanıldıktan sonra Atılmış Kart Destesi’ne girer ve sayacı sıfırlanır, ancak \"Yakarış\" yalnızca ilk kullanılışında etkisini gösterir."
  },
  State_131779_Name = {
    Text = "Kullanılabilir: [Layer] kez"
  },
  State_131789_Desc = {
    Text = "Bir yedek seçenek. Eline tid [Layer] olan 1 kart ekle."
  },
  State_131789_Name = {
    Text = "Belirtilen Kartı Ekle"
  },
  State_131807_Name = {
    Text = "Durum@Üreme Caro Saf Tanımlayıcı"
  },
  State_131824_Name = {
    Text = "Durum@Canavar Tawil Niyet Değiştirme Oyuncu Dinleyicisi"
  },
  State_131846_Desc = {
    Text = "Ölüm anında, rastgele bir \"Uçurum Örümcek Kümesi\" veya \"Leng Örümcek Kümesi\" çağırır ve onun \"Küme Etkisi\"ni 1 yığın azaltır."
  },
  State_131846_Name = {
    Text = "Küme Etkisi"
  },
  State_131908_Desc = {
    Text = "Hedefin Can, Kalkan ve Aliemus değerlerini paylaş, ancak savaş istatistikleri oluşturma."
  },
  State_131908_Name = {
    Text = "Çürüme Şöleni Sıçrama Tahtası"
  },
  State_131909_Desc = {
    Text = "Bu Duruma sahip olmak Taşkınlık kullanımını engeller."
  },
  State_131909_Name = {
    Text = "Kalıcı Olarak Mühürlü"
  },
  State_132366_Desc = {
    Text = "Diğer Uyandırıcılar Saldırı Kartları oynadıktan sonra Av gerçekleştirir."
  },
  State_132366_Name = {Text = "Takip"},
  State_132465_Desc = {
    Text = "Bu Uyandırıcının Hasarı, Kalkanı, İyileştirmesi, Gücü, Tükenmesi, Dokunaç Hasarı, sabit Zehiri ve sabit Karşı Saldırısı artırılır, bağımsız olarak 1+[Layer]% ile çarpılır."
  },
  State_132465_Name = {
    Text = "Yutma Güçlendirme α"
  },
  State_132469_Desc = {
    Text = "Bu Uyandırıcının Hasarı, Kalkanı, İyileştirmesi, Gücü, Tükenmesi, Dokunaç Hasarı, sabit Zehiri ve sabit Karşı Saldırısı artırılır, bağımsız olarak 1+[Layer]% ile çarpılır."
  },
  State_132469_Name = {
    Text = "Yutma Güçlendirme β"
  },
  State_132539_Desc = {
    Text = "Koleksiyon Test Kalıntısı"
  },
  State_132539_Name = {
    Text = "Koleksiyon Test Kalıntısı"
  },
  State_132539_WeaponDesc = {Text = "Test"},
  State_132560_WeaponDesc = {
    Text = "Cinderfire her [Damage:StateArg2] kez Hasar verdiğinde, Tükenme ile bir [Green Flames] elde et."
  },
  State_132564_WeaponDesc = {
    Text = "Cinderfire her [Damage:StateArg2] kez Hasar verdiğinde, Tükenme ile bir [Green Flames] elde et."
  },
  State_132565_WeaponDesc = {
    Text = "Cinderfire her [Damage:StateArg2] kez Hasar verdiğinde, Tükenme ile bir [Green Flames] elde et."
  },
  State_132598_Desc = {
    Text = "Bu turda Dokunaç Hasarı verirken, ek olarak verilen hasarın [Layer]%'si kadar Zehir uygular."
  },
  State_132598_Name = {
    Text = "Uçurum Takıntısı"
  },
  State_132609_Desc = {
    Text = "Heykeltıraş kalkan uyguladığında, [StateArg1] Dokunaç HASARI artar."
  },
  State_132609_Name = {
    Text = "Kendinden Geçiş Diyarı"
  },
  State_132609_WeaponDesc = {
    Text = "Heykeltıraş kalkan uyguladığında, [StateArg1] Dokunaç HASARI artar."
  },
  State_132669_Desc = {
    Text = "Bu Uyandırıcı'nın Kartlarının Hasarı, Kalkanı, İyileştirmesi, Gücü, Tükenmesi, Dokunaç Hasarı, sabit Zehiri ve sabit Karşı Saldırısı artırılır, her biri bağımsız olarak 1+[Layer]% ile çarpılır."
  },
  State_132669_Name = {
    Text = "Kaderli Ultra α"
  },
  State_132840_Name = {
    Text = "\"24\"ün Komut Kartı kişilik efekt bonusu iki katına çıkar. \"24\" Taşkınlık serbest bıraktıktan sonra, iki katına çıkmış kişilik bonus efekti bu turda sona erer"
  },
  State_132891_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında [StateArg1] <StrongEffectKeywords:Güçlü> kazanır, diğer müttefikler Taşkınlık sonrası <PVPOneMeetingKeywords:Ichigo Ichie> kazanır."
  },
  State_132891_Name = {
    Text = "Sakura Hayalleri"
  },
  State_132892_Desc = {
    Text = "·Edinildiğinde diğer müttefiklerin \"Ichigo Ichie\" durumunu kaldırır, \"Sakura Hayalleri\" donanmış müttefik sayısına eşit Güçlü efekti kazanır, en fazla 3 kat.\n·\"Sakura Hayalleri\" donanmış karakterler \"Ichigo Ichie\" kazanamaz."
  },
  State_132892_Name = {
    Text = "Ichigo Ichie"
  },
  State_133294_Name = {
    Text = "Kızıl Davetiye"
  },
  State_133353_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldıktan sonra, kullananın \"Vuruş,\" \"Beceri\" ve \"Taşkınlık\" açıklamaları tanımlanamaz hale gelir, ancak her Hasar, Kalkan ve HP Yenilenmesi örneği rastgele [StateArg1]%~[StateArg2]% oranında artırılır."
  },
  State_133353_Name = {
    Text = "Çamurdaki peri masalı"
  },
  State_133354_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Bu Kader Çarkı ölümden sonra korunur. kullanan ölüm anında ve ölüm Durumundaki sonraki [Layer] tur sonunda, diğer müttefikler <Heal:[Heal:StateArg1]> <PVPFeatheredSeedsKeyWords:Gynoecium> ve Can kazanır."
  },
  State_133354_Name = {
    Text = "Dünya kokuya dönüşsün"
  },
  State_133369_Desc = {
    Text = "Oynanan sonraki [DescArg1] Tawil olmayan Komut Kartı iki kez etki eder."
  },
  State_133369_Name = {
    Text = "Gümüş Anahtar Kapısı"
  },
  State_133372_Desc = {
    Text = "Şu anda bir Ultra Tur'daysa, \"Tekillik Bükülmesi\" etkisini etkinleştir. \"Tekillik Yok Oluşu\" ayrıca bu turda bir sonraki \"Tekillik Bükülmesi\" tetiklenmesini garanti eder."
  },
  State_133372_Name = {
    Text = "<SingularityKeywords:Tekillik Bükülmesi>"
  },
  State_133391_Desc = {
    Text = "Hedefin Can'ı yığın sayısına eşit veya altındaysa, tüm Son Karar'ı kaldır ve onu anında öldür."
  },
  State_133391_Name = {
    Text = "<CutKeywords:Son Karar>"
  },
  State_133395_Desc = {
    Text = "Oynanan sonraki [Layer] Komut Kartı \"Boyut Mekiği\"ni tetikler."
  },
  State_133395_Name = {
    Text = "Boyut Mekiği"
  },
  State_133717_Desc = {
    Text = "Mevcut sahip [Layer] olup, tüm mevcut ve gelecekteki kartları ilgili niteliği kazanacaktır (Mevcut: Kart Mührü)."
  },
  State_133717_Name = {
    Text = "Kart Özelliği Yayılımı"
  },
  State_133774_Desc = {
    Text = "Her yığın bu kartın Final Hasarını, Sabit <PowerIconKeywords:Güç> & <TentacleInjurieIconKeywords:Dokunaç Hasarı> kazanımını, Sabit <IntoxicationIconKeywords:Zehir> & <RetaliateIconKeywords:Karşı Atak>'ı %2 artırır; bu kartın Final Sabit Kalkanını, Sabit HP Yenilenmesini ve <ExhaustionIconKeywords:Güç Azalması>'nı %1 artırır. Bu kart <SingularityKeywords3:Boyut Mekiği>'ni tetikleyemez."
  },
  State_133774_Name = {
    Text = "<SingularityKeywords1:Tekillik İşareti>"
  },
  State_133775_Desc = {
    Text = "Her yığın bu kartın Final Hasarını, Sabit <PowerIconKeywords:Güç> & <TentacleInjurieIconKeywords:Dokunaç Hasarı> kazanımını, Sabit <IntoxicationIconKeywords:Zehir> & <RetaliateIconKeywords:Karşı Atak>'ı %2 artırır; bu kartın Final Sabit Kalkanını, Sabit HP Yenilenmesini ve <ExhaustionIconKeywords:Güç Azalması>'nı %1 artırır."
  },
  State_133775_Name = {
    Text = "<SingularityKeywords2:Tekillik Prizması>"
  },
  State_133961_Desc = {
    Text = "Takım Özgünlüğü: Keşif başladıktan sonra, desteye 1 \"Bahar Mesajı\" karıştır: Arithmetica Maliyeti 1, <WeaponEffect_Num:[StateArg1]> S-Enerjisi kazan, oynanınca kalıcı olarak \"Sakura Çiçekleri\"ne dönüşür: Arithmetica Maliyeti 1, <WeaponEffect_Num:[StateArg2]> S-Enerjisi kazan, oynanınca kalıcı olarak \"Hanafubuki\"ye dönüşür: Arithmetica Maliyeti 1, <WeaponEffect_Num:[StateArg3]> S-Enerjisi kazan, oynanınca kalıcı olarak \"Ichigo Ichie\"ye dönüşür: Arithmetica Maliyeti 1, rastgele 3 açık Müfreze'den 1'ini seç, anında serbest bırak ve 2 kez tetikle, oynanınca kalıcı olarak \"Bahar Mesajı\"na dönüşür. Bu kartların tümünde \"Sakla\" bulunur."
  },
  State_133961_WeaponDesc = {
    Text = "Keşif başladıktan sonra, desteye 1 \"Bahar Mesajı\" karıştır: Arithmetica Maliyeti 1, <WeaponEffect_Num:[StateArg1]> Keyflare kazan, oynanınca kalıcı olarak \"Sakura Çiçekleri\"ne dönüşür: Arithmetica Maliyeti 1, <WeaponEffect_Num:[StateArg2]> Keyflare kazan, oynanınca kalıcı olarak \"Hanafubuki\"ye dönüşür: Arithmetica Maliyeti 1, <WeaponEffect_Num:[StateArg3]> Keyflare kazan, oynanınca kalıcı olarak \"Ichigo Ichie\"ye dönüşür: Arithmetica Maliyeti 1, 3 rastgele açılmış Müfreze arasından 1 tanesini seç ve hemen serbest bırakarak 2 kez tetikle, oynanınca kalıcı olarak \"Bahar Mesajı\"na dönüşür. Bu Kartların hepsi \"Sakla\" özelliğine sahiptir."
  },
  State_133994_Desc = {
    Text = "Tüm Uyandırıcıların Final Hasarı, Sabit <PowerIconKeywords:Güç> & <TentacleInjurieIconKeywords:Dokunaç Hasarı> kazanımı, Sabit <IntoxicationIconKeywords:Zehir> & <RetaliateIconKeywords:Karşı Atak> her biri +[DescArg1]%; Bu kartın Final Sabit Kalkanı, Sabit HP Yenilenmesi ve <ExhaustionIconKeywords:Güç Azalması> her biri +[DescArg2]%"
  },
  State_133994_Name = {
    Text = "Tekillik Prizması"
  },
  State_133998_Desc = {
    Text = "Bu kartın verdiği Hasar, Kalkan ve Güç değişimleri [DescArg2]% artar, Dokunaç Hasarı, Can İyileştirme, sabit Zehir ve sabit Karşı Saldırının nihai Etkisi [DescArg1]% artar; tur sonu veya oynanmasının ardından kaldırılır."
  },
  State_133998_Name = {
    Text = "<TempPowerKeywords1:Geçici Güçlendirme [DescArg1]>"
  },
  State_133999_Desc = {
    Text = "Her yığın bu kartın Final Hasarını, Sabit <PowerIconKeywords:Güç> & <TentacleInjurieIconKeywords:Dokunaç Hasarı> kazanımını, Sabit <IntoxicationIconKeywords:Zehir> & <RetaliateIconKeywords:Karşı Atak>'ı %2 artırır; bu kartın Final Sabit Kalkanını, Sabit HP Yenilenmesini ve <ExhaustionIconKeywords:Güç Azalması>'nı %1 artırır. Oynanınca veya tur sonunda temizlenir."
  },
  State_133999_Name = {
    Text = "<TempPowerKeywords:Geçici Güçlendirme>"
  },
  State_134100_Desc = {
    Text = "Bu savaşta öldürücü Hasar aldığında, yeniden canlan, [Layer] Can yenile ve tüm Uyandırıcılara [StateArg1] Aliemus ve [DescArg1] Geçici Dokunaç Hasarı ver. Dağıtılamaz."
  },
  State_134100_Name = {
    Text = "Ölümsüz Cennet Kuşu"
  },
  State_134191_Desc = {
    Text = "Takım Benzersiz: Keşif başladıktan sonra, 1 \"Özel Mola Vakti\"ni Çekme Destesine Karıştır. \"Özel Mola Vakti\": 1 Arithmetica maliyetlidir. Geçici Kritik Hasar +<WeaponEffect_Num:[StateArg1]%>. <RetainIconKeywords:Sakla>. <DepleteIconKeywords:Tüket>."
  },
  State_134191_WeaponDesc = {
    Text = "Keşif başladıktan sonra, 1 \"Özel Mola Vakti\"ni Çekme Destesine Karıştır. \"Özel Mola Vakti\": 1 Arithmetica maliyetlidir. Geçici Kritik Hasar +<WeaponEffect_Num:[StateArg1]%>. <RetainIconKeywords:Sakla>. <DepleteIconKeywords:Tüket>."
  },
  State_134195_Desc = {
    Text = "Bu Kartın sabit Zehir, sabit Karşı Saldırı ve sabit Kader Yargısı yığınları artırılır, her biri bağımsız olarak 1+[Layer]% ile çarpılır."
  },
  State_134195_Name = {
    Text = "Üçlü Güç α1"
  },
  State_134196_Desc = {
    Text = "Bu Uyandırıcı'nın Komut Kartlarının sabit Zehir, sabit Karşı Saldırı ve sabit Kader Yargısı yığınları artırılır, her biri bağımsız olarak 1+[StateArg1]% ile çarpılır."
  },
  State_134196_Name = {
    Text = "Üçlü Güç β3"
  },
  State_134197_Desc = {
    Text = "Bu Kartın sabit Zehir, sabit Karşı Saldırı ve sabit Kader Yargısı yığınları artırılır, her biri bağımsız olarak 1+[StateArg1]% ile çarpılır."
  },
  State_134197_Name = {
    Text = "Üçlü Güç β1"
  },
  State_134198_Desc = {
    Text = "Bu Uyandırıcı'nın Komut Kartlarının sabit Zehir, sabit Karşı Saldırı ve sabit Kader Yargısı yığınları artırılır, her biri bağımsız olarak 1+[Layer]% ile çarpılır."
  },
  State_134198_Name = {
    Text = "Üçlü Güç α3"
  },
  State_134199_Desc = {
    Text = "Bu Uyandırıcı'nın Taşkınlığının sabit Zehir, sabit Karşı Saldırı ve sabit Kader Yargısı yığınları artırılır, her biri bağımsız olarak 1+[StateArg1]% ile çarpılır."
  },
  State_134199_Name = {
    Text = "Üçlü Güç β2"
  },
  State_134200_Desc = {
    Text = "Bu Uyandırıcı'nın Taşkınlığının sabit Zehir, sabit Karşı Saldırı ve sabit Kader Yargısı yığınları artırılır, her biri bağımsız olarak 1+[Layer]% ile çarpılır."
  },
  State_134200_Name = {
    Text = "Üçlü Güç α2"
  },
  State_134227_Desc = {
    Text = "Kader Dokuyucu ipliklerini çeker. Maksimum [DescArg1] yığın, savaşlar arasında kalıcıdır ve Taşkınlık tarafından tüketilerek Av: \"Sonsuz İplikler\"i serbest bırakabilir."
  },
  State_134227_Name = {
    Text = "<SilkKeywords:Kader İpliği>"
  },
  State_134231_Desc = {
    Text = "Takım Benzersiz: Kullanan tarafından üretilen Kalkan +<WeaponEffect_Num:%[StateArg1]> ve kullanan \"Av\" kullandığında, Geçici Güçlü +<WeaponEffect_Num:%[StateArg2]>, tur başına en fazla 5 kez. \"Boyut Mekiği\" her tetiklendiğinde, kullanan <WeaponEffect_Num:[StateArg3]> Aliemus kazanır."
  },
  State_134231_WeaponDesc = {
    Text = "Kullanan tarafından üretilen Kalkan +<WeaponEffect_Num:[StateArg1]%> ve kullanan \"Av\" kullandığında, Geçici Güçlü +<WeaponEffect_Num:[StateArg2]%>, tur başına en fazla 5 kez. \"Boyut Mekiği\" her tetiklendiğinde, kullanan <WeaponEffect_Num:[StateArg3]> Aliemus kazanır."
  },
  State_134237_Desc = {
    Text = "Kader Dokumacısı ipliklerini çeker. Maksimum [DescArg1] yığın, savaşlar arasında kalıcıdır ve Av: \"<DerivativeCardKeywords_144:Sonsuz Yumak>\" serbest bırakmak için Taşkınlık tarafından tüketilebilir."
  },
  State_134237_Name = {
    Text = "Kader İpliği"
  },
  State_134240_Desc = {
    Text = "\"Ebedi Tezgâh\"ın sonraki <plural value=\"[Layer]\" singular=\"kullanımında\" plural=\"kullanımında\"> ekstra bir \"Yönlendirici İplikler\" üretilir ve Çekme Destesi ile Atılmış Kart Destesi'ne yerleştirilir."
  },
  State_134240_Name = {
    Text = "Kader Bağlama Ağı"
  },
  State_134261_Desc = {
    Text = "Verilen bir sonraki [Layer] Hasar örneği iki katına çıkar."
  },
  State_134261_Name = {
    Text = "Özel Öğleden Sonra"
  },
  State_134262_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Taşkınlık\" sonrasında, kendisinin verdiği bir sonraki Hasar iki katına çıkar."
  },
  State_134262_Name = {
    Text = "Özel Öğleden Sonra"
  },
  State_134285_Desc = {
    Text = "Hedefin Can'ı yığın sayısına eşit veya altındaysa, tüm Son Karar'ı kaldır ve onu anında öldür."
  },
  State_134285_Name = {
    Text = "Kader Yargısı"
  },
  State_134313_Desc = {
    Text = "Takım Benzersiz: Kullanan tarafından üretilen Kalkan +<WeaponEffect_Num:%[StateArg1]> ve kullanan \"Av\" kullandığında, Geçici Güçlü +<WeaponEffect_Num:%[StateArg2]>, tur başına en fazla 5 kez."
  },
  State_134313_WeaponDesc = {
    Text = "Kullanan tarafından üretilen Kalkan +<WeaponEffect_Num:%[StateArg1]> ve kullanan \"Av\" kullandığında, Geçici Güçlü +<WeaponEffect_Num:%[StateArg2]>, tur başına en fazla 5 kez."
  },
  State_134384_Desc = {
    Text = "Oynanan sonraki [Layer] Komut Kartı \"Boyut Mekiği\"ni tetikler."
  },
  State_134384_Name = {
    Text = "Boyut Mekiği"
  },
  State_134389_Desc = {
    Text = "Bu kartın Final Hasarı, Sabit <PowerIconKeywords:Güç> & <TentacleInjurieIconKeywords:Dokunaç Hasarı> kazanımı, Sabit <IntoxicationIconKeywords:Zehir> & <RetaliateIconKeywords:Karşı Atak> her biri +[DescArg1]%; Bu kartın Final Sabit Kalkanı, Sabit HP Yenilenmesi ve <ExhaustionIconKeywords:Güç Azalması> her biri +[DescArg2]%. \"Tekillik Feneri\" olan kartlar \"Boyut Mekiği\"ni tetikleyemez."
  },
  State_134389_Name = {
    Text = "<SingularityKeywords:Tekillik Feneri [DescArg2]>"
  },
  State_134391_Desc = {
    Text = "Her turda, ilk Komut Kartı oynandıktan sonra bu Etki tetiklenir: oynanan Komut Kartının Geçici Temel Kopyası Ultra Uzay'a yerleştirilir. Bu Etki, Ultra Turlar sırasında tetiklenemez."
  },
  State_134391_Name = {
    Text = "<SingularityKeywords3:Boyut Mekiği>"
  },
  State_135232_Name = {
    Text = "<SingularityKeywords:Tekillik Bükülmesi>: Bu turun geri kalanında, başka bir Uyandırıcı bir Komut Kartı oynadığında, Av: <DerivativeCardKeywords_137:\"Sonsuz İplikler\"> serbest bırakmak için 1 <SilkKeywords:Dokuyucu> tüketilir"
  },
  State_135233_Name = {
    Text = "<SingularityKeywords:Tekillik Bükülmesi>: Bu turun geri kalanında, başka bir Uyandırıcı bir Komut Kartı oynadığında, Av: <DerivativeCardKeywords_137:\"Sonsuz İplikler\"> serbest bırakmak için 1 <SilkKeywords:Dokuyucu> tüketilir"
  },
  State_135919_Name = {
    Text = "<SingularityKeywords:Tekillik Bükülmesi>: Bu turun geri kalanında, başka bir Uyandırıcı bir Komut Kartı oynadığında, Av: <DerivativeCardKeywords_137:\"Sonsuz İplikler\"> serbest bırakmak için 1 <SilkKeywords:Dokuyucu> tüketilir"
  },
  State_135920_Name = {
    Text = "<SingularityKeywords:Tekillik Bükülmesi>: Bu turun geri kalanında, başka bir Uyandırıcı bir Komut Kartı oynadığında, Av: <DerivativeCardKeywords_137:\"Sonsuz İplikler\"> serbest bırakmak için 1 <SilkKeywords:Dokuyucu> tüketilir"
  },
  State_135921_Desc = {
    Text = "Uyandıran %25 daha fazla Hasar verir."
  },
  State_135921_Name = {
    Text = "<CardKeyWord:Azarla, Kan Borcunu Ödemek İçin>"
  },
  State_138824_Desc = {
    Text = "Parlayan yaşam özgürlüğü yüceltip zafer marşı söylüyor; Saya'nın Taşkınlığı tarafından tüketilerek etkisi güçlendirilebilir. Bu durum en fazla 4 kat birikir ve savaş bittikten sonra korunur."
  },
  State_138824_Name = {
    Text = "<KaiHuajishu1:Gynoecium>"
  },
  State_139039_Desc = {
    Text = "Bu Uyandırıcı'nın bu tur bir sonraki Taşkınlık'ının verdiği Hasar, sabit Kalkan, sabit Can İyileştirme, sabit Güç, Güç Azalması, Dokunaç Hasarı Artışı, sabit Zehir, sabit Karşı Saldırı'nın nihai Etkisi [Layer]% artar."
  },
  State_139039_Name = {
    Text = "<BreedingKeywords2:Yayılma Şenliği>"
  },
  State_139687_Desc = {
    Text = "Parlayan yaşam özgürlüğü yüceltip zafer marşı söylüyor; Saya'nın Taşkınlığı tarafından tüketilerek etkisi güçlendirilebilir. Bu durum en fazla 4 kat birikir ve savaş bittikten sonra korunur."
  },
  State_139687_Name = {
    Text = "<KaiHuajishu:Gynoecium>"
  },
  State_139688_Desc = {
    Text = "Takım Özgünlüğü: Arithmetica Sınırı +1, aynı türdeki etkiler yığılamaz.\nKullanana ait her 10 Temel Aliemus için, +<WeaponEffect_Num:[StateArg1]%> <Corrosion:Aşınma> yığını uygular ve +<WeaponEffect_Num:[Float:StateArg2]％> Embriyo Füzyonuna neden olur."
  },
  State_139688_WeaponDesc = {
    Text = "Arithmetica Sınırı +1, aynı türdeki etkiler yığılamaz.\nKullanana ait her 10 Temel Aliemus için, +<WeaponEffect_Num:[StateArg1]%> Sabit <Corrosion:Aşınma> yığını uygular ve +<WeaponEffect_Num:[Float:StateArg2]%> Embriyo Füzyonuna neden olur."
  },
  State_139689_Desc = {
    Text = "Takım Özgünlüğü: \"Kızıl Ocak\" kullanıldıktan sonra, kullanan kişi Aliemus Üssü'nün <WeaponEffect_Num:[StateArg1]%>'i kadar Aliemus kazanır. 3 tur bekleme süresi."
  },
  State_139689_WeaponDesc = {
    Text = "\"Kızıl Ocak\" kullanıldıktan sonra, kullanan Temel Aliemus'un <WeaponEffect_Num:[StateArg1]%> kadarını Aliemus olarak kazanır, 3 tur bekleme süresi."
  },
  State_139977_Desc = {
    Text = "Bu tur, \"Vuruş\" oynarsan, \"Vuruş\" Delici ile +[DescArg1]% Hasar verir; aksi takdirde, tur sonunda +[Layer] Bariyer kazan."
  },
  State_139977_Name = {
    Text = "Yıldız Canavarı"
  },
  State_140063_Desc = {
    Text = "Bu, bir sonraki turdan Arithmetica ödünç alınarak oluşturulan bir \"borç senedi\"dir. Bir sonraki turun başında [Layer] Arithmetica düşülecektir. Dağıtılamaz."
  },
  State_140063_Name = {Text = "Zararda"},
  State_140068_Desc = {
    Text = "Sonraki [DescArg1] \"Beceri\" Kartının maliyeti - [StateArg1] Arithmetica."
  },
  State_140068_Name = {Text = "Vahiy"},
  State_140135_Desc = {
    Text = "Her 1 katman için, bu Uyandırıcı'nın bu tur bir sonraki Taşkınlık'ının verdiği Hasar, sabit Kalkan, sabit Can İyileştirme, sabit Güç, Güç Azalması, Dokunaç Hasarı Artışı, sabit Zehir, sabit Karşı Saldırı'nın nihai Etkisi 1% artar."
  },
  State_140135_Name = {
    Text = "<BreedingKeywords2:Yayılma Şenliği>"
  },
  State_140186_WeaponDesc = {
    Text = "Tüm Balina Sıçrayışı Sıçrama Hasarı örnekleri +1."
  },
  State_140454_Desc = {
    Text = "Takımda Benzersiz: Kuşananın kendisi, Kader Çarkı ve Gizli Ahitte her 1% Kara Mühür düşüşü başına, savaş bitiminde <WeaponEffect_Num:[StateArg1]%> maksimum can yenilenir, her tur sonunda bu yenilenme etkisi %30 azalır, birden fazla etki bağımsız hesaplanır.\"Kül Harabeleri\" içinde \"Algılama\" kullanıldıktan sonra, bu \"Kül Harabeleri\" yenilemesi Kara Mühür tüketimi gerektirmez."
  },
  State_140454_WeaponDesc = {
    Text = "Kullananın, WoD'larının ve Ahitlerinin sahip olduğu her %1 Mühür Hasadı için, savaş sonunda Maksimum canın <WeaponEffect_Num:[DescArg2]%>'i ([DescArg1]) kadar Can yenile. Bu etki her turun sonunda %30 azalır ve her savaş için ayrı ayrı hesaplanır.\n\"Kül Harabeleri\"nde \"Algı\" seçildikten sonra, bu \"Kül Harabeleri\"nde yenilemeler ücretsiz olur."
  },
  State_140456_WeaponDesc = {
    Text = "Kullandıktan sonra onu kalıcı olarak kaldır."
  },
  State_140458_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında ve herhangi bir Uyanmış \"Çılgınlık Patlaması\" serbest bıraktığında, kendisi <Block:[Block:StateArg1]> kalkan kazanır."
  },
  State_140458_Name = {
    Text = "Yıldızlara Doğru"
  },
  State_140489_Desc = {
    Text = "Eşit miktarda maksimum can kazanılır, katman sayısı Uyanış Bedeninin başlangıç maksimum canını aşamaz."
  },
  State_140489_Name = {Text = "Gynoecium"},
  State_140490_Desc = {
    Text = "Eşit miktarda maksimum can kazanılır, katman sayısı bu Uyanış Bedeninin başlangıç maksimum canı [DescArg1] değerini aşamaz."
  },
  State_140490_Name = {Text = "Gynoecium"},
  State_140495_Desc = {
    Text = "Bir sonraki \"Yetenek\"in harcadığı Arithmetica - [Layer] ."
  },
  State_140495_Name = {
    Text = "Yeniden Yazmak"
  },
  State_140517_Desc = {
    Text = "Sonraki \"Beceri\" kartının Arithmetica maliyeti - [DescArg1] ."
  },
  State_140517_Name = {
    Text = "Yeniden Yazmak"
  },
  State_140547_Desc = {
    Text = "Bu etki Embriyo Füzyonunu en fazla + 100 artırabilir, Embriyo Füzyonu artırma etkisi bonusundan etkilenmez."
  },
  State_140547_Name = {
    Text = "Embriyo Füzyonu Çift"
  },
  State_140645_Desc = {
    Text = "Boşta Etki"
  },
  State_140645_Name = {
    Text = "Boşta Etki"
  },
  State_140647_Name = {
    Text = "Bilişsel Uyumsuzluk Dinlemesi oynandı"
  },
  State_140648_Name = {
    Text = "Oyuncu Bilişsel Uyumsuzluk sayacı tutuyor"
  },
  State_140650_Desc = {
    Text = "Her tur \"Algı Bükülmesi\" olan bir Komut Kartı oynadığınız ilk 3 seferde, Saya [Layer] Aliemus kazanır."
  },
  State_140650_Name = {
    Text = "Bilişsel Dönüşüm"
  },
  State_140651_Desc = {
    Text = "Boşta Etki"
  },
  State_140651_Name = {
    Text = "Boşta Etki"
  },
  State_140653_Desc = {
    Text = "Bu kartın Arithmetica Maliyeti'nin %10 ihtimalle -2, %25 ihtimalle -1, %30 ihtimalle değişmez, %25 ihtimalle +1, %10 ihtimalle +2 olma şansı vardır. Oynanırsa veya atılırsa bu durum kaldırılır."
  },
  State_140653_Name = {
    Text = "<ExclamationPointColour:Boyama Üstü>"
  },
  State_140654_Desc = {
    Text = "Boşta Etki"
  },
  State_140654_Name = {
    Text = "Boşta Etki"
  },
  State_140655_Desc = {
    Text = "Bu kart Çözünme tarafından örtüldüğünden metni görüntülenemez; Arithmetica Maliyeti'nin %10 ihtimalle -2, %25 ihtimalle -1, %30 ihtimalle değişmez, %25 ihtimalle +1, %10 ihtimalle +2 olma şansı vardır. Oynanırsa veya atılırsa bu durum kaldırılır."
  },
  State_140655_Name = {
    Text = "<ErosionColorInkKeywords:Algı Bükülmesi>"
  },
  State_140656_Desc = {
    Text = "Bu kartın Arithmetica Maliyeti'nin %10 ihtimalle -2, %25 ihtimalle -1, %30 ihtimalle değişmez, %25 ihtimalle +1, %10 ihtimalle +2 olma şansı vardır. Oynanırsa veya atılırsa bu durum kaldırılır."
  },
  State_140656_Name = {
    Text = "<ColorInkKeywords:Üzerine Boyama>"
  },
  State_140657_Desc = {
    Text = "Bu kart Çözünme tarafından örtüldüğünden metni görüntülenemez; Arithmetica Maliyeti'nin %10 ihtimalle -2, %25 ihtimalle -1, %30 ihtimalle değişmez, %25 ihtimalle +1, %10 ihtimalle +2 olma şansı vardır. Oynanırsa veya atılırsa bu durum kaldırılır."
  },
  State_140657_Name = {
    Text = "<ExclamationPointColour:Algı Bükülmesi>"
  },
  State_140658_Name = {
    Text = "Oyuncu Bilişsel Uyumsuzluk Dinlemesi tutuyor"
  },
  State_140659_Desc = {
    Text = "Boşta Etki"
  },
  State_140659_Name = {
    Text = "Boşta Etki"
  },
  State_140662_Desc = {
    Text = "Her turun başında, \"Algı Bükülmesi\" olmayan 2 Komut Kartı'na rastgele \"Algı Bükülmesi\" uygulanır."
  },
  State_140662_Name = {
    Text = "Yaşam Formu Yeniden Yapılandırması"
  },
  State_140672_Desc = {
    Text = "Bu Uyandırıcı kaosa düşer, verilen Hasarı, HP Yenilenmesini ve Kalkanı rastgele %15~%35 oranında azaltır ve bu etki giderilemez."
  },
  State_140672_Name = {
    Text = "<PVPCognitiveDissonanceKeyWords:Algı Bükülmesi>"
  },
  State_140673_Desc = {
    Text = "Bu Uyandırıcı kaosa düşer, verilen Hasarı, HP Yenilenmesini ve Kalkanı rastgele %15~%35 oranında azaltır ve bu etki giderilemez."
  },
  State_140673_Name = {
    Text = "Algı Bükülmesi"
  },
  State_140683_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında [StateArg1] <MaxHPKeywords:Maksimum can> kazanır, tur sonunda <Heal:[Heal:DescArg1]> HP Yenilenmesi sağlar, HP Yenilenmesi kullananın canı azaldıkça artar, en fazla [StateArg3]% artış sağlar."
  },
  State_140683_Name = {
    Text = "Harikalar Diyarında Lily"
  },
  State_140724_Name = {Text = "Beslenme"},
  State_140726_Desc = {
    Text = "Bu Kartın verdiği Hasar, Güç, Dokunaç Hasarı, sabit Zehir, sabit Karşı Saldırı, Kalkan, HP İyileştirme ve Güç Azalması'nın nihai Etkisi [DescArg1]% azalır."
  },
  State_140726_Name = {
    Text = "<AdaptKeywords1:Uyum [DescArg1]>"
  },
  State_140727_Desc = {
    Text = "Açlık 5 kata ulaştığında, tur sonu tüm açlığı tüketir, niyeti güçlü saldırıya geçirir ve [DescArg1] puan Güç kazanır."
  },
  State_140727_Name = {Text = "Açlık"},
  State_140728_Desc = {
    Text = "Her tur başında 1 kat açlık kazanır, engellenmemiş Hasar verdiğinde maksimum can değerinin %2'si ([DescArg1]) kadar Kalkan kazanır. Uyum'un maksimum kat sayısı 75'e yükselir."
  },
  State_140728_Name = {
    Text = "Yiyeceği Koruma"
  },
  State_140730_Desc = {
    Text = "Bir Komut Kartı oynanıldığında, ait olduğu Uyandırıcı'nın her yerdeki kartlarına 10 kat <AdaptKeywords:Uyum> uygular; diğer Uyandırıcıların kartlarından 5 kat <AdaptKeywords:Uyum> kaldırır. Her kat <AdaptKeywords:Uyum>, kartın verdiği Hasar, Güç, Dokunaç Hasarı, sabit Zehir, sabit Karşı Saldırı, Kalkan, Can İyileştirme, Güç Azalması'nın nihai etkisini %1 azaltır; en fazla [DescArg1] kat birikir."
  },
  State_140730_Name = {Text = "Taklit"},
  State_140838_Desc = {
    Text = "Bu tur verilen Hasar %[Layer] azalır."
  },
  State_140838_Name = {
    Text = "Güneşi Örten Kabus Duvarı"
  },
  State_140839_Desc = {
    Text = "Bu tur tüm Uyandırıcıların Final Hasarı %[Layer] artar."
  },
  State_140839_Name = {
    Text = "Eşlik Eden Avcı Sürüsü"
  },
  State_140856_Desc = {
    Text = "Uyandırıcı Eylem yapamaz, tur sonunda 1 yığın Bilinç Müdahalesi kaldırılır. Tüm yığınlar kaldırıldıktan sonra bu Uyandırıcının bir sonraki Taşkınlık kullanımı Aşırı Yüceltme olarak değerlendirilir; eğer zaten Aşırı Yüceltme kullanılmışsa %100 Temel Aliemus iade edilir."
  },
  State_140856_Name = {
    Text = "<Yishiganshe:Bilinç Müdahalesi>"
  },
  State_140860_Desc = {
    Text = "Uyandırıcı Eylem yapamaz, tur sonunda 1 yığın Bilinç Müdahalesi kaldırılır. Tüm yığınlar kaldırıldıktan sonra bu Uyandırıcının bir sonraki Taşkınlık kullanımı Aşırı Yüceltme olarak değerlendirilir; eğer zaten Aşırı Yüceltme kullanılmışsa %100 Temel Aliemus iade edilir."
  },
  State_140860_Name = {
    Text = "<Yishiganshe:Bilinç Müdahalesi>"
  },
  State_140861_Desc = {
    Text = "Bir sonraki Taşkınlık kullanımı Aşırı Yüceltme olarak değerlendirilir; eğer zaten Aşırı Yüceltme kullanılmışsa %100 Temel Aliemus iade edilir."
  },
  State_140861_Name = {
    Text = "Harikalar Diyarında Lily"
  },
  State_140873_Desc = {
    Text = "Her 1 kat, bu kartın verdiği Hasar, Güç, Dokunaç Hasarı, sabit Zehir, sabit Karşı Saldırı, Kalkan, Can İyileştirme, Güç Azalması'nın nihai etkisini %1 azaltır; en fazla [DescArg1] kat uygulanır."
  },
  State_140873_Name = {
    Text = "<AdaptKeywords:Uyum>"
  },
  State_140877_Name = {
    Text = "Ek olarak [DescArg1] kez etkinleşir"
  },
  State_141468_Desc = {
    Text = "Açlık 5 yığına ulaştığında, tur sonu tüm Açlık yığınları tükenir, niyet Güçlü Saldırı'ya geçer ve Güç kazanılır."
  },
  State_141468_Name = {
    Text = "<HungerKeywords:Açlık>"
  },
  State_141504_Desc = {
    Text = "En fazla 3 adet biriktirilir; üst sınıra ulaşıldığında bir sonraki \"Ölüm Şöleni\" bunları yiyip etkisini güçlendirebilir. Kalıntılar bir sonraki savaşa aktarılır."
  },
  State_141504_Name = {Text = "Ceset"},
  State_141950_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında ve tur sonunda, <PVPDiscoveryKeyWords:Keşfet> [StateArg1] adet <PVPVoidKeywords:Yanılsama> eklenmiş \"Beceri\" kartı ve ele al."
  },
  State_141950_Name = {
    Text = "Yukarı İniş"
  },
  State_141988_Desc = {
    Text = "Bu kartın verdiği Hasar, Kalkan, iyileşme; uyguladığı Güç, Tükenme, Dokunaç Hasarı, Zehir, Karşı Saldırı, Son Karar, sabit Zehir, sabit Karşı Saldırı, sabit Son Karar etkileri [Layer]% artar."
  },
  State_141988_Name = {
    Text = "Bu Kartın Gökkuşağı Rengi"
  },
  State_141989_Desc = {
    Text = "Rastgele kartlar oluşturur."
  },
  State_141989_Name = {
    Text = "<CardKeyWord:Keşfet>"
  },
  State_141991_Desc = {
    Text = "Bu Uyandırıcı'nın Taşkınlığının verdiği Hasar, Kalkan, iyileşme; uyguladığı Güç, Tükenme, Dokunaç Hasarı, Zehir, Karşı Saldırı, Son Karar, sabit Zehir, sabit Karşı Saldırı, sabit Son Karar etkileri [Layer]% artar."
  },
  State_141991_Name = {
    Text = "Taşkınlık Gökkuşağı Rengi"
  },
  State_141992_Desc = {
    Text = "Bu Uyandırıcı'nın kartlarının verdiği Hasar, Kalkan, iyileşme; uyguladığı Güç, Tükenme, Dokunaç Hasarı, Zehir, Karşı Saldırı, Son Karar, sabit Zehir, sabit Karşı Saldırı, sabit Son Karar etkileri [Layer]% artar."
  },
  State_141992_Name = {
    Text = "Bu Kartın Gökkuşağı Rengi"
  },
  State_141993_Desc = {
    Text = "Bu Uyandırıcı'nın Komut Kartlarının verdiği Hasar, Kalkan, iyileşme; uyguladığı Güç, Tükenme, Dokunaç Hasarı, Zehir, Karşı Saldırı, Son Karar, sabit Zehir, sabit Karşı Saldırı, sabit Son Karar etkileri [Layer]% artar."
  },
  State_141993_Name = {
    Text = "Komut Kartı Gökkuşağı Rengi"
  },
  State_141994_Desc = {
    Text = "Kart oynadıktan sonra, Taşkınlık serbest bıraktıktan sonra verilen Hasar, Kalkan kazanma, iyileştirme, Güç, Tükenme, Dokunaç Hasarı, Zehir, Karşı Saldırı, Son Karar, sabit Zehir, sabit Karşı Saldırı, sabit Son Karar uygulama."
  },
  State_141994_Name = {
    Text = "Renkli Tetik Komutu"
  },
  State_142018_Desc = {
    Text = "Tur başında, 1 yığın <Guaiwucanhai:Enkaz> kazan."
  },
  State_142018_Name = {
    Text = "Kızıl Davetiye"
  },
  State_142057_Desc = {
    Text = "Müfreze kullandıktan sonra kendi niyetini değiştirir; savaş başladıktan sonra tüm Uyandırıcıların Keyflare Yenilenme Seviyesi %25 artar."
  },
  State_142057_Name = {
    Text = "Aydınlanma Nedeni"
  },
  State_142058_Desc = {
    Text = "Verilen Temel HSR, Zehir, Karşı Saldırı [DescArg1]% azalır."
  },
  State_142058_Name = {
    Text = "Kirli Kanat"
  },
  State_142060_Desc = {
    Text = "Düşman her Komut Kartı kullandığında, kendisi 1 kat Geçici Coşku kazanır. Geçici Coşku 10 kata ulaştığında, bir sonraki Komut Kartı oynanmasının ardından kendisi hemen harekete geçer ve tüm Geçici Coşkuları kaldırır."
  },
  State_142060_Name = {
    Text = "Derin Yankı"
  },
  State_142062_Desc = {
    Text = "Her seferinde 0246 başlangıç etkisi rastgele belirlenir."
  },
  State_142062_Name = {
    Text = "Rastgele Niyet"
  },
  State_142063_Desc = {
    Text = "Kendi turu içinde alınan Hasar [DescArg1]% azalır."
  },
  State_142063_Name = {
    Text = "Kutsal Kanat"
  },
  State_142065_Desc = {
    Text = "Tur başında temizlenir. 10 kata ulaştığında, bir sonraki Komut Kartı oynanmasının ardından kendisi hemen harekete geçer ve tüm Geçici Coşkuları kaldırır."
  },
  State_142065_Name = {
    Text = "Geçici Coşku"
  },
  State_142066_Desc = {
    Text = "<WeaknessIconKeywords:Weakness>, <FragileIconKeywords:Fragile> ve <HeavyInjuryKeywords:Blighten> etkileri %50’ye yükseltilir."
  },
  State_142066_Name = {
    Text = "Öz Kavrayış"
  },
  State_142067_Desc = {
    Text = "Verilen Güç, Karşı Saldırı, Dokunaç Hasarı [DescArg1]% azalır."
  },
  State_142067_Name = {
    Text = "Lanetli Kanat"
  },
  State_142072_Desc = {
    Text = "Her Hasar aldığında ya da Can kaybettiğinde, bu miktar Maksimum Can’ın %5’ini aşamaz."
  },
  State_142072_Name = {
    Text = "Acı Eşiği"
  },
  State_142091_Desc = {
    Text = "Altı Kanat Katlaması Sayacı"
  },
  State_142091_Name = {
    Text = "Altı Kanat Katlaması Sayacı"
  },
  State_142092_Desc = {
    Text = "Tüm Uyandırıcıların Keyflare Yenilenme Seviyesi %25 artar."
  },
  State_142092_Name = {
    Text = "Aydınlanma Nedeni"
  },
  State_142093_Desc = {
    Text = "Altı Kanat Katlaması tüketim ilerlemesi: [DescArg1], mevcut gereken hasar değeri: [DescArg2]."
  },
  State_142093_Name = {
    Text = "Altı Kanat Katlaması"
  },
  State_142095_Desc = {
    Text = "Altı Kanat Katlaması İşareti"
  },
  State_142095_Name = {
    Text = "Altı Kanat Katlaması İşareti"
  },
  State_142166_Desc = {
    Text = "Belirli etkiler için temel Saldırı mantığına bakın."
  },
  State_142213_Name = {
    Text = "Arithmetica Sınırı-"
  },
  State_142215_Desc = {
    Text = "Bir sonraki tur başında hâlâ ölü durumdaysa, dirilerek [StateArg1] Kalkan kazanır; dağıtılamaz."
  },
  State_142215_Name = {
    Text = "Ebedi Saplantı"
  },
  State_142228_Desc = {
    Text = "Bu kart Kader Çarkı \"Yukarı İniş\" tarafından oluşturuldu."
  },
  State_142228_Name = {
    Text = "Yukarı İniş"
  },
  State_142229_Desc = {
    Text = "Takım Özgünlüğü: Keşif başladıktan sonra kart destesine 1 \"Harikalar Diyarında Lily\" kartı ekler. \"Harikalar Diyarında Lily\": 2 Arithmetica harcayarak kullananın <WeaponEffect_Num:[StateArg1]> puan Aliemus ve 3 yığın <Yishiganshe:\"Bilinç Müdahalesi\"> kazanmasını sağlar. <RetainIconKeywords:Sakla>. <DepleteIconKeywords:Tüket>."
  },
  State_142229_Name = {
    Text = "Harikalar Diyarında Lily"
  },
  State_142229_WeaponDesc = {
    Text = "Keşif başladıktan sonra, kart destesine 1 adet \"Harikalar Diyarında Lily\" ekle. \"Harikalar Diyarında Lily\": 2 Arithmetica harca, kullananın <WeaponEffect_Num:[StateArg1]> Aliemus ve <Yishiganshe:\"Bilinç Müdahalesi\"> kazanmasını sağla. <RetainIconKeywords:Sakla>. <DepleteIconKeywords:Harca>."
  },
  State_142452_Desc = {
    Text = "Alınan Güç Azalması etkileri %50 oranında azaltılır."
  },
  State_142452_Name = {
    Text = "Ölümsüz Varlık"
  },
  State_142663_Desc = {
    Text = "Sonraki tur başında <DelayKeywords:Gecikme>: [Layer] Aliemus kazanırsın."
  },
  State_142663_Name = {
    Text = "Gecikmeli Gecikmeli Aliemus"
  },
  State_142688_Desc = {
    Text = "Hedefin donanımlı olduğu Kader Çarkı devre dışı kalır, dağıtılamaz."
  },
  State_142688_Name = {
    Text = "Süper Sarmalamak"
  },
  State_142692_Desc = {
    Text = "Yeni küçük fikirler filizleniyor."
  },
  State_142692_Name = {Text = "Ani İlham"},
  State_142715_Desc = {
    Text = "Bu \"yeteneğin\" hasarı [DescArg1]% artar, bu yetenek her 1 Arithmetica harcadığında [StateArg1]% daha artar."
  },
  State_142715_Name = {
    Text = "Kehribar Renkli Ölüm"
  },
  State_142887_Desc = {
    Text = "Bu tur tekrar \"Felç\" uygulanırsa, tüm \"Vuruş\" kartları \"İllüzyon\" olur; dağıtılamaz, tur sonuna kadar devam eder."
  },
  State_142887_Name = {
    Text = "Biraz Uyuştu"
  },
  State_142954_Desc = {
    Text = "Arithmetica Sınırı en az 0'dır; her tur başında 10'dan küçükse 1 artar. 10'a ulaştıktan sonra elde edilen Arithmetica Sınırı, eşit miktarda kart çekmeye dönüşür."
  },
  State_142954_Name = {
    Text = "Arithmetica Sınırı"
  },
  State_143002_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Yapılandırılmamış"
  },
  State_143002_Name = {
    Text = "Sartogua SR (geçici metin)"
  },
  State_143004_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Yapılandırılmamış"
  },
  State_143004_Name = {
    Text = "Tsathoggua Özel Silahı (Geçici Metin)"
  },
  State_143005_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Yapılandırılmamış"
  },
  State_143005_Name = {
    Text = "Lantigos SR (geçici metin)"
  },
  State_143006_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Yapılandırılmamış"
  },
  State_143006_Name = {
    Text = "Nephren-Ka Özel Silahı (Geçici Metin)"
  },
  State_143007_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında ve tur başında, rastgele bir düşmana [StateArg1] <plural value=\"[StateArg1]\" singular=\"yığın\" plural=\"yığın\"> <PVPCompassKeywords:Başıboş Pusula> uygula."
  },
  State_143007_Name = {
    Text = "Başıboş Pusula"
  },
  State_143008_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Yapılandırılmamış"
  },
  State_143008_Name = {
    Text = "Shantak Özel Silahı (Geçici Metin)"
  },
  State_143009_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Yapılandırılmamış"
  },
  State_143009_Name = {
    Text = "Aforgomon Özel Silahı (Geçici Metin)"
  },
  State_143010_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Maksimum El Boyutu +[StateArg1], kullanan veya bir dost öldüğünde, onun Kartları artık <PVPDerivativeCardKeywords_2:\"İllüzyon\">'a dönüşmez, bunun yerine <PVPDerivativeCardKeywords_30:\"Yağmacı-Gaunt\">'a dönüşür."
  },
  State_143010_Name = {
    Text = "Canlı Kafes"
  },
  State_143011_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Yapılandırılmamış"
  },
  State_143011_Name = {
    Text = "Akbaba SR (Geçici Metin)"
  },
  State_143012_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Yapılandırılmamış"
  },
  State_143012_Name = {
    Text = "Shatak Kuşu SR (Geçici Metin)"
  },
  State_143013_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Yapılandırılmamış"
  },
  State_143013_Name = {
    Text = "Köken Ogier SR (Geçici Metin)"
  },
  State_143014_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Taşkınlık\" öncesinde mevcut Canın 25%'ini kaybeder; \"Taşkınlık\" sonrasında tüm düşmanlara [StateArg1] Hasar verir ve eşit miktarda Can emer."
  },
  State_143014_Name = {
    Text = "Tatlı dilli aldatmaca"
  },
  State_143016_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Yapılandırılmamış"
  },
  State_143016_Name = {
    Text = "Kara Firavun SR (geçici metin)"
  },
  State_143017_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Yapılandırılmamış"
  },
  State_143017_Name = {
    Text = "Rhan-Tegoth Özel Silahı (Geçici Metin)"
  },
  State_143018_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Yapılandırılmamış"
  },
  State_143018_Name = {
    Text = "Köken Tulu SR (Geçici Metin)"
  },
  State_143019_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Taşkınlık\" sonrası tüm düşmanlara [StateArg1] kat <PVPBless:Kutsama> uygular."
  },
  State_143019_Name = {
    Text = "Tatlı Hakikat"
  },
  State_143020_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Yapılandırılmamış"
  },
  State_143020_Name = {
    Text = "Köken Ogier Özel Silahı (Geçici Metin)"
  },
  State_143022_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Yapılandırılmamış"
  },
  State_143022_Name = {
    Text = "Akbaba Özel Silahı (Geçici Metin)"
  },
  State_143023_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Yapılandırılmamış"
  },
  State_143023_Name = {
    Text = "Yafagomon SR (Geçici Metin)"
  },
  State_143326_Desc = {
    Text = "Gümüş Anahtar Şarjı [DescArg1] artar."
  },
  State_143326_Name = {
    Text = "Aydınlanma Nedeni"
  },
  State_143331_Desc = {
    Text = "Bir sonraki tur sona ermeden önce <StatusApplier:> için hasarın yarısını üstlenir; bu Durum her takım için Takım Özgünlüğüdür, bağlı taraflardan herhangi biri öldüğünde bu Etki kaldırılır, dağıtılamaz."
  },
  State_143331_Name = {
    Text = "Hasar Üstlen"
  },
  State_143333_Desc = {
    Text = "Bir sonraki tur başlamadan önce <StatusApplier:> onun için hasarın yarısını üstlenir; bu Durum her takım için Takım Özgünlüğüdür, bağlı taraflardan herhangi biri öldüğünde bu Etki kaldırılır, dağıtılamaz."
  },
  State_143333_Name = {
    Text = "Hasar Devret"
  },
  State_143336_Desc = {
    Text = "\"Gaunt\" için 1 ek kez etki eder. \"Gaunt\" oynanıldığında 1 kat tükenir, üst sınır 9 kattır, savaş bittiğinde temizlenmez."
  },
  State_143336_Name = {
    Text = "<BattueKeywords:Av>"
  },
  State_143340_Desc = {
    Text = "\"Gaunt\" için 1 ek kez etki eder. \"Gaunt\" oynanıldığında 1 kat tükenir, üst sınır 9 kattır, savaş bittiğinde temizlenmez."
  },
  State_143340_Name = {
    Text = "<BattueKeywords:Av>"
  },
  State_143386_Desc = {
    Text = "<StatusApplier:> için hasarın yarısını üstlenir, dağıtılamaz."
  },
  State_143386_Name = {
    Text = "Hasar Üstlen"
  },
  State_143387_Desc = {
    Text = "<StatusApplier:> onun için hasarın yarısını üstlenir, dağıtılamaz."
  },
  State_143387_Name = {
    Text = "Hasar Devret"
  },
  State_143406_Name = {
    Text = "Bu Kart [DescArg1] ek kez etki eder"
  },
  State_143408_Desc = {
    Text = "Bir düşman tarafından saldırıya uğradığında, saldırganın Aliemus'una dönüş."
  },
  State_143408_Name = {
    Text = "Başıboş Pusula"
  },
  State_143409_Desc = {
    Text = "Bir düşman tarafından saldırıya uğradığında, saldırganın Aliemus'una dönüş."
  },
  State_143409_Name = {
    Text = "<CardKeyWord:Başıboş Pusula>"
  },
  State_143419_Desc = {
    Text = "Bu kart <PVPDerivativeCardKeywords_31:\"Aurita'nın Hazinesi\">'nden geliyor."
  },
  State_143419_Name = {
    Text = "Aurita'nın Hazinesi"
  },
  State_143426_Desc = {
    Text = "Tur başladıktan sonra [Layer] Arithmetica düşülür, dağıtılamaz."
  },
  State_143426_Name = {
    Text = "Gecikmeli Arithmetica Düşümü"
  },
  State_143441_Desc = {
    Text = "[StateArg1]. turda seçilen Uyandırıcı."
  },
  State_143441_Name = {
    Text = "Test İşareti 1"
  },
  State_143442_Desc = {
    Text = "[StateArg1]. turda seçilen Uyandırıcı."
  },
  State_143442_Name = {
    Text = "Test İşareti 2"
  },
  State_143444_Desc = {
    Text = "[StateArg1]. turda seçilen Uyandırıcı."
  },
  State_143444_Name = {
    Text = "Test İşareti 4"
  },
  State_143445_Desc = {
    Text = "[StateArg1]. turda seçilen Uyandırıcı."
  },
  State_143445_Name = {
    Text = "Test İşareti 3"
  },
  State_143499_Name = {
    Text = "Aktif Hasara Bağışık__\"Yalnızca Geliştirme İçin\""
  },
  State_143500_Name = {
    Text = "Saf Hasara Bağışık__\"Yalnızca Geliştirme İçin\""
  },
  State_143541_Desc = {
    Text = "Tüm düşmanların bu turda verdiği Hasar [DescArg1]% azalır ve [DescArg2] Güç kazanırsın."
  },
  State_143541_Name = {Text = "Refakat"},
  State_143542_Desc = {
    Text = "Geçici Final Hasar +[DescArg1]% ve tüm düşmanlara Maksimum can'ın [DescArg2]% kadar Aşınma uygular."
  },
  State_143542_Name = {Text = "Avlanma"},
  State_143548_Desc = {
    Text = "Kalkan uygular ve Durum ekler, Canavar, dal 1."
  },
  State_143548_Name = {
    Text = "Canavar Kalkan Dönüşümü 1"
  },
  State_143549_Desc = {
    Text = "Kalkan uygular ve Durum ekler, Uyandırıcı, dal 2."
  },
  State_143549_Name = {
    Text = "Karakter Kalkan Dönüşümü 2"
  },
  State_143550_Desc = {
    Text = "Kalkan uygular ve Durum ekler, Uyandırıcı, dal 1."
  },
  State_143550_Name = {
    Text = "Karakter Kalkan Dönüşümü 1"
  },
  State_143551_Desc = {
    Text = "Kalkan oluşturur ve Durum ekler, Canavar, dal 2."
  },
  State_143551_Name = {
    Text = "Canavar Kalkan Dönüşümü 2"
  },
  State_143552_Desc = {
    Text = "Kalkan uygular ve Durum ekler, oyuncu, dal 1."
  },
  State_143552_Name = {
    Text = "Oyuncu Kalkan Dönüşümü 1"
  },
  State_143553_Desc = {
    Text = "Kalkan uygular ve Durum ekler, oyuncu, dal 2."
  },
  State_143553_Name = {
    Text = "Oyuncu Kalkan Dönüşümü 2"
  },
  State_143573_Desc = {
    Text = "Gaunt; Pontos'un güçlendirme kartlarıdır, toplamda 3 türü vardır: \"Baskıncı-Gaunt\", \"Kışkırtıcı-Gaunt\" ve \"Katil-Gaunt\". Kalıcı \"Gaunt\" oluşturulduğunda kalıcı \"Gaunt\" sayısı 6'yı aşarsa, rastgele bir kalıcı \"Gaunt\" Arithmetica Maliyeti +1 olan ancak 1 ek kez etki eden \"Birleşik Gauntlar\"a yükseltilir; \"Birleşik Gauntlar\" destede 2 adet \"Gaunt\" olarak sayılır. Tüm \"Gaunt\" kartları zaten yükseltilmişse <DestructionKeywords:İmha Et> özelliğine sahip 1 adet \"İleri Kavrayış\" ele eklenir."
  },
  State_143573_Name = {Text = "Gaunt"},
  State_143578_Desc = {
    Text = "Bu tur içinde, her Aktif Hasar aldığında, [Layer] adet <PVPDerivativeCardKeywords_30:\"Köle-Solgun\"> eli kartına ekle."
  },
  State_143578_Name = {
    Text = "Lord Ritüeli"
  },
  State_143595_Desc = {
    Text = "Bu karta <PrepareKeywords:Hazırlan> [StateArg1] eklendi."
  },
  State_143595_Name = {
    Text = "Kara Kuğunun Dansı"
  },
  State_143597_Desc = {
    Text = "Takım Özgünlüğü: kullanan'ın verdiği Güç Azalması Etkisi <WeaponEffect_Num:[StateArg1]%> artar. \"Öfkeli Dalgalar\" duruşuna geçildiğinde, Geçici Krit. Hasar artar; artış miktarı kendi temel Kritik Hasar'ının <WeaponEffect_Num:[StateArg1]%>'sine eşittir, 3 tur bekleme süresi."
  },
  State_143597_WeaponDesc = {
    Text = "kullanan'ın verdiği Güç Azalması Etkisi <WeaponEffect_Num:[StateArg1]%> artar. \"Öfkeli Dalgalar\" duruşuna geçildikten sonra Geçici Krit. Hasar <WeaponEffect_Num:[DescArg1]%> artar, 3 tur bekleme süresi."
  },
  State_143598_Desc = {
    Text = "Takım Özgünlüğü: kullanan'ın verdiği Güç Azalması Etkisi <WeaponEffect_Num:[StateArg1]%> artar, her 1 düşman Öldürme başına kullanan'ın bu keşif turunda tur sonu sabit İyileştirme ile kazandığı Aliemus 2 puan artar, en fazla <WeaponEffect_Num:[StateArg2]> kez yığılabilir. \"Öfkeli Dalgalar\" duruşuna geçildikten sonra Geçici Krit. Hasar artar; artış miktarı kendi temel Kritik Hasar'ının <WeaponEffect_Num:[StateArg1]%>'sine eşittir, 3 tur bekleme süresi."
  },
  State_143598_WeaponDesc = {
    Text = "kullanan'ın verdiği Güç Azalması Etkisi <WeaponEffect_Num:[StateArg1]%> artar, her 1 düşman Öldürme başına kullanan'ın bu keşif turunda tur sonu sabit İyileştirme ile kazandığı Aliemus 2 puan artar, en fazla <WeaponEffect_Num:[StateArg2]> kez yığılabilir. \"Öfkeli Dalgalar\" duruşuna geçildikten sonra Geçici Krit. Hasar <WeaponEffect_Num:[DescArg1]%> artar, 3 tur bekleme süresi."
  },
  State_143683_Desc = {
    Text = "Bu Uyandırıcı'nın Takip özelliği Mühürlü olduğundan kullanılamaz, [Layer] tur sonra Mühür kalkar."
  },
  State_143683_Name = {
    Text = "<Seal1:Takip Mühürlü>"
  },
  State_144381_Desc = {
    Text = "Eylem gerçekleştirilemiyor, Kalan [DescArg1] tur."
  },
  State_144381_Name = {
    Text = "<Yishiganshe:Bilinç Müdahalesi>"
  },
  State_144441_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Bir dost ölünce, kendisi <Energy:[Energy:StateArg1]> Aliemus kazanır. Bir dost diriltilince, o karakter <Energy:[Energy:StateArg2]> Aliemus kazanır. Aliemus kazanma etkisi yalnızca hedefin Aliemus'u dolu olmadığında geçerlidir; [Layer] kez daha etki eder, sayı tükenince bu Kader Çarkı'nı imha eder."
  },
  State_144441_Name = {
    Text = "Ruh Senkronizasyonu"
  },
  State_144494_Desc = {
    Text = "7 tür etki vardır: 8 kart çek, 6 Arithmetica kazan, Keyflare kazan, tüm Uyandırıcılar Sabit Aliemus kazanır, GÜÇ kazan, tüm düşmanların GÜÇ'ünü geçici olarak azalt, Hasar Güçlendirmesini geçici olarak artır."
  },
  State_144494_Name = {
    Text = "<Blessing:Bereket>"
  },
  State_144508_Desc = {
    Text = "\"Fiyat\" 3 türde gelir:\n\nKaçırılan Fırsat: İlgili \"Hediye\" etkisini 2 tur geciktirir.\nYaldızlı Sözler: İlgili \"Hediye\" etkisini %50 azaltır.\nÖrtülü Kötülük: Takımına 1 rastgele olumsuz etki uygular:\n<Italic:2 tur Semptom: Zayıflık; 2 tur Kırılgan, 2 tur Ağır Yıkım; Maksimum canın %1'i kadar Zehir yığını; 2 yığın Boşluk; elde rastgele 2 karta 1 yığın Durağanlık; ya da 2 Geçici Semptom Kartı oluşturur (savaşlar arasında devam etmez) ve bunları Çekme Destesinin üstüne yerleştirir.>"
  },
  State_144508_Name = {
    Text = "<BlessingNegativeEffect:Fiyat>"
  },
  State_144519_Desc = {
    Text = "Test süreç değeri, tur başladıktan sonra veya kart oynadıktan sonra yenilenir. Şu anda [Layer] Diyar Ruhu'na sahipsiniz."
  },
  State_144519_Name = {
    Text = "Yeni Kaos Diyar Ruhu"
  },
  State_145228_Name = {
    Text = "<WormGrowth:Ziyafet>"
  },
  State_145229_Desc = {
    Text = "Bereketin bir parçasısın~! Caraboo'nun Taşkınlığı tarafından bir güçlendirme için tüketilebilir, en fazla 5 yığın. Savaşlar arasında devam eder."
  },
  State_145229_Name = {
    Text = "<SacrificialMark:Kurban>"
  },
  State_145436_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Vuruş\" Hasarı [DescArg1]% artar, her \"Vuruş\" sonrasında Hasar ek olarak [StateArg2]% daha artar, en fazla [StateArg3]%'e kadar artabilir."
  },
  State_145436_Name = {
    Text = "Ölümsüz Açlık Kemikleri"
  },
  State_145437_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında [StateArg2] yığın <EnergyStorageKeywords:Şarj> kazanır, \"Vuruş\" Hasarı [StateArg1]% artar ve <PVPPunctureDamagewords:Delici Hasar>'a dönüşür."
  },
  State_145437_Name = {
    Text = "Göksel Yıkım"
  },
  State_145456_Desc = {
    Text = "Hedef seçerken Alay, Gizlilik ve Kilitleme durumlarını yok sayar. Birden fazla hedef eşit koşullara sahipse, öndeki Uyandırıcı öncelikli olarak seçilir."
  },
  State_145456_Name = {
    Text = "Can ve Kalkan En Düşük"
  },
  State_145457_Desc = {
    Text = "Hedef seçerken Alay, Gizlilik ve Kilitleme durumlarını yok sayar. Birden fazla hedef eşit koşullara sahipse, öndeki Uyandırıcı öncelikli olarak seçilir."
  },
  State_145457_Name = {
    Text = "Can ve Kalkan En Yüksek"
  },
  State_145495_Desc = {
    Text = "Bu Kart Çift Atış ile oynanır."
  },
  State_145495_Name = {
    Text = "<CardKeyWord:Çift Atış>"
  },
  State_145554_Desc = {
    Text = "Takım Özgünlüğü: Keşif başladıktan sonra, kart destesine 1 adet <Falltospace1[StateArg3]:\"Ölümlü Konaklama\"> ekle. \"Ölümlü Konaklama\": 0 Arithmetica harca. Tüm düşmanlara kullananın SLD'sinin <WeaponEffect_Num:[StateArg1]%>'i ve maksimum canının <WeaponEffect_Num:[Float:StateArg4]%>'i kadar sabit <Corrosion:Aşınma> ver, her yerdeki diğer Uyandırıcıların Komut Kartlarına <ErosionColorInkKeywords:Algı Bükülmesi> ekle ve 1 adet <Falltospace2[StateArg3]:\"Yukarı İniş\"> Çekme Destesine karıştır. <RetainIconKeywords:Sakla>. <DepleteIconKeywords:Tüket>."
  },
  State_145554_Name = {
    Text = "Yukarı İniş"
  },
  State_145554_WeaponDesc = {
    Text = "Keşif başladıktan sonra, kart destesine 1 adet <Falltospace1[StateArg3]:\"Ölümlü Konaklama\"> ekle. \"Ölümlü Konaklama\": 0 Arithmetica harca. Tüm düşmanlara kullananın SLD'sinin <WeaponEffect_Num:[StateArg1]%>'i ve maksimum canının <WeaponEffect_Num:[Float:StateArg4]%>'i kadar sabit <Corrosion:Aşınma> ver, her yerdeki diğer Uyandırıcıların Komut Kartlarına <ErosionColorInkKeywords:Algı Bükülmesi> ekle ve 1 adet <Falltospace2[StateArg3]:\"Yukarı İniş\"> Çekme Destesine karıştır. <RetainIconKeywords:Sakla>. <DepleteIconKeywords:Tüket>"
  },
  State_145572_Desc = {
    Text = "Her tur başında, diğer tüm Uyandırıcılar <Damage:[Damage:Layer]> Delici Hasar verir."
  },
  State_145572_Name = {
    Text = "Cetus'u Yutan Fırtına"
  },
  State_145590_Desc = {
    Text = "Aynı kaynağa ait aynı Kart ele geldiğinde Birleşim etkisi tetiklenir ve o Kart tüketilir."
  },
  State_145590_Name = {
    Text = "<CardKeyWord:Birleşim>"
  },
  State_145592_Desc = {
    Text = "Bir düşmanı kilitler ve onu öncelikli saldırı hedefi olarak belirler; tekli hedef seçerken yalnızca kilitli hedef seçilebilir, Alay ve gizlenme yok sayılır."
  },
  State_145592_Name = {
    Text = "<CardKeyWord:Kilit>"
  },
  State_145619_Name = {Text = "Çürüt"},
  State_145620_Name = {Text = "Boşluk"},
  State_145621_Desc = {
    Text = "\"Bereket\" etkisi %50 azaltılır."
  },
  State_145621_Name = {
    Text = "<Bleesing_Exaggerate:Abartma>"
  },
  State_145622_Name = {Text = "Durgunluk"},
  State_145623_Desc = {
    Text = "Takımına 1 rastgele olumsuz etki uygular:\n<Italic:2 tur Semptom: Zayıflık; 2 tur Kırılgan, 2 tur Ağır Yıkım; Maksimum canın %1'i kadar Zehir yığını; 2 yığın Boşluk; elde rastgele 2 karta 1 yığın Durağanlık; ya da 2 Geçici Semptom Kartı oluşturur (savaşlar arasında devam etmez) ve bunları Çekme Destesinin üstüne yerleştirir.>"
  },
  State_145623_Name = {
    Text = "<Bleesing_Negative:Örtülü Kötülük>"
  },
  State_145624_Name = {Text = "Zayıflık"},
  State_145625_Name = {
    Text = "2 adet özdeş geçici \"Semptom Kartı\""
  },
  State_145626_Name = {Text = "Kırılgan"},
  State_145627_Name = {Text = "Zehir"},
  State_145628_Desc = {
    Text = "2 tur sonra \"Bereket\" etkisi kazan."
  },
  State_145628_Name = {
    Text = "<Bleesing_Delay:Kaçırılan Fırsat>"
  },
  State_145631_Desc = {
    Text = "\"Vuruş\" Hasarı [StateArg1]% artar ve <PVPPunctureDamagewords:Delici Hasar>'a dönüşür."
  },
  State_145631_Name = {
    Text = "Göksel Yıkım"
  },
  State_145632_Desc = {
    Text = "Bu kart Kader Çarkı \"Şans Saati\"nden gelir."
  },
  State_145632_Name = {
    Text = "Şans Saati"
  },
  State_145638_Desc = {
    Text = "Bu Kartın Arithmetica Maliyeti [Layer] artar."
  },
  State_145638_Name = {
    Text = "Zalim Saygı"
  },
  State_145642_Desc = {
    Text = "2 tur sonra tüm Uyandırıcılar [StateArg1] puan Aliemus kazanır [Layer] kez."
  },
  State_145642_Name = {
    Text = "Gecikmeli Aliemus"
  },
  State_145644_Desc = {
    Text = "2 tur sonra <Posse:[StateArg1]> puan S-Enerjisi kazanır [Layer] kez."
  },
  State_145644_Name = {
    Text = "Gecikmeli S-Enerjisi"
  },
  State_145645_Desc = {
    Text = "2 tur sonra tüm düşmanların [StateArg1] puan <ExhaustionIconKeywords:gücünü> geçici olarak azaltır [Layer] kez"
  },
  State_145645_Name = {
    Text = "Gecikmeli Özsüzme"
  },
  State_145646_Desc = {
    Text = "2 tur sonra [StateArg1] puan Arithmetica kazanır [Layer] kez."
  },
  State_145646_Name = {
    Text = "Gecikmiş Arithmetica"
  },
  State_145647_Desc = {
    Text = "2 tur sonra [StateArg1] puan <PowerIconKeywords:güç> kazanır [Layer] kez."
  },
  State_145647_Name = {
    Text = "Gecikmeli Güç"
  },
  State_145648_Desc = {
    Text = "2 tur sonra [StateArg1] Kart çeker [Layer] kez."
  },
  State_145648_Name = {
    Text = "Gecikmeli Kart Çekme"
  },
  State_145649_Desc = {
    Text = "2 tur sonra geçici Hasar Güçlendirmesi [StateArg1]% [Layer] kez."
  },
  State_145649_Name = {
    Text = "Gecikmeli Geçici Hasar Güçlendirmesi"
  },
  State_145652_Desc = {
    Text = "Bu kartın Arithmetica Maliyeti -[Layer]."
  },
  State_145652_Name = {
    Text = "Dayanılmaz Özgürlük"
  },
  State_145654_Desc = {
    Text = "Test. Oynanıldıktan sonra veya Elden ayrıldıktan sonra İmha Et."
  },
  State_145654_Name = {
    Text = "Test. Anlık"
  },
  State_145660_Desc = {
    Text = "Bizim\n1.<AllyPosAwaker1Name:> [DescArg1]\n2.<AllyPosAwaker2Name:> [DescArg2]\n3.<AllyPosAwaker3Name:> [DescArg3]\n4.<AllyPosAwaker4Name:> [DescArg4]\nDüşman\n1.<EnemyPosAwaker1Name:> [DescArg5]\n2.<EnemyPosAwaker2Name:> [DescArg6]\n3.<EnemyPosAwaker3Name:> [DescArg7]\n4.<EnemyPosAwaker4Name:> [DescArg8]"
  },
  State_145660_Name = {
    Text = "Sıfırlamadan Sonra Can Değişimi"
  },
  State_145693_Desc = {
    Text = "Tur sonunda, Arithmetica Maliyeti -[Layer]. Bu Etki, kart atılsa bile tetiklenir."
  },
  State_145693_Name = {
    Text = "<PrepareKeypvewordscolour:Hazırlan[Layer]>"
  },
  State_145693_WeaponDesc = {
    Text = "Kart Atılmış Kart Destesine girmez, bunun yerine elinde kalır."
  },
  State_145694_Desc = {Text = "—"},
  State_145694_Name = {
    Text = "Kara Bataklıkla Simbiyoz"
  },
  State_145694_WeaponDesc = {Text = "—"},
  State_145698_Desc = {
    Text = "Kilitli <StatusApplier:>'a öncelikli saldırır, tek hedef seçerken yalnızca kilitli hedefi seçebilir, Alay ve gizlenmeyi yok sayar."
  },
  State_145698_Name = {Text = "Kilitleme"},
  State_145699_Desc = {
    Text = "·Kilitli <StatusApplier:>'a öncelikli saldırır; tekli hedef seçerken yalnızca kilitli hedef seçilebilir, Alay ve gizlenme yok sayılır.\n·Kendisi öldükten sonra <StatusApplier:> \"<PVPDerivativeCardKeywords_32:Savaşa Gel!>\" kazanır."
  },
  State_145699_Name = {Text = "Kilitleme"},
  State_145709_Desc = {
    Text = "Her yığın, Maksimum Canı Caraboo'nun KON'unun %10'u kadar artırır (En fazla 50 yığın). Maksimum yığına ulaşıldığında, fazla yığınlar bunun yerine bu Can değerinin 3 katı kadar iyileştirir. Patron olmayan savaşlarda tur başına en fazla 10 yığın \"Tokluk\" kazanılabilir. \"Tokluk\" savaşlar arasında kalıcıdır."
  },
  State_145709_Name = {
    Text = "<WormGrowth:Ziyafet>"
  },
  State_145710_Desc = {
    Text = "Bereketin bir parçasısın~! Caraboo'nun Taşkınlığı tarafından bir güçlendirme için tüketilebilir, en fazla 5 yığın. Savaşlar arasında devam eder."
  },
  State_145710_Name = {
    Text = "<SacrificialMark:Kurban>"
  },
  State_145901_Desc = {
    Text = "Bizim tarafımız\n1.<AllyPosAwaker1Name:> [DescArg1]\n2.<AllyPosAwaker2Name:> [DescArg2]\n3.<AllyPosAwaker3Name:> [DescArg3]\n4.<AllyPosAwaker4Name:> [DescArg4]"
  },
  State_145901_Name = {
    Text = "Sıfırlamadan Sonra Can Değişimi"
  },
  State_146041_Desc = {
    Text = "Bu Uyandırıcı dünyevi gürültüden uzaklaşmış hissediyor.\n·Tur sona erene kadar hiçbir Eylem gerçekleştiremez, Hasarı %99 azaltır; hedefin Direnci yoksa hedefe Direnç kazandırır.\n·Etki sona erdiğinde tüm dost birimlere <Damage:[Layer]> pasif Hasar verir.\n·Uygulandığı anda hedefin Direnci varsa Göz Boyama hemen sona erer ve hedefe verilen Hasar iki katına çıkar."
  },
  State_146041_Name = {Text = "Kandırma"},
  State_146043_Desc = {
    Text = "Sonraki tur başında [Layer] Aliemus düşülür."
  },
  State_146043_Name = {
    Text = "Gecikmeli Aliemus Düşümü"
  },
  State_146058_Desc = {
    Text = "Test süreç değeri, tur başladıktan sonra veya kart oynadıktan sonra yenilenir. Şu anda [Layer]% saldırı etkisine sahip olunmalıdır."
  },
  State_146058_Name = {
    Text = "Müfreze Saldırı Etkisi"
  },
  State_146059_Desc = {
    Text = "Test süreç değeri, tur başladıktan sonra veya kart oynadıktan sonra yenilenir. Şu anda [Layer]% savunma etkisine sahip olunmalıdır."
  },
  State_146059_Name = {
    Text = "Müfreze Savunma Etkisi"
  },
  State_146079_Desc = {
    Text = "Bu Kart elden ayrıldıktan sonra ele geri döner."
  },
  State_146079_Name = {
    Text = "<Recycle:Geri Dön>"
  },
  State_146085_Desc = {
    Text = "Bu Turda Oynamadan Önce Kartın Arithmetica'sını Değiştir"
  },
  State_146085_Name = {
    Text = "Bu Turda Oynamadan Önce Kartın Arithmetica'sını Değiştir"
  },
  State_146085_WeaponDesc = {
    Text = "Oynamadan önce kartın Arithmetica’sını değiştir"
  },
  State_146086_Desc = {
    Text = "Bu Turda Oynamadan Önce Kartın Arithmetica'sını Değiştir"
  },
  State_146086_Name = {
    Text = "Bu Turda Oynamadan Önce Kartın Arithmetica'sını Değiştir"
  },
  State_146086_WeaponDesc = {
    Text = "Oynamadan önce kartın Arithmetica’sını değiştir"
  },
  State_146117_Desc = {
    Text = "\"<DerivativeCardKeywords_157:Kılıcın Kemiği>\" tarafından tüketilerek güçlendirme kazanılabilir. Bu durum en fazla 15 kat biriktirebilir."
  },
  State_146117_Name = {
    Text = "<Shimieluotanhuodong2:Savaş Azmi>"
  },
  State_146129_Desc = {
    Text = "Tüm Uyandırıcıların Final Hasarı +[Layer]%."
  },
  State_146129_Name = {
    Text = "Balina-Gökyüzü Öldürme Niyeti"
  },
  State_146147_Desc = {
    Text = "\"<DerivativeCardKeywords_157:Kılıcın Kemiği>\" tarafından tüketilerek güçlendirme kazanılabilir. Bu durum en fazla 15 kat biriktirebilir."
  },
  State_146147_Name = {
    Text = "<Shimieluotanhuodong1:Savaş Azmi>"
  },
  State_146154_Desc = {
    Text = "Bu Uyandırıcının kendini iyi hissetmesini sağlar; \"Beceri\"si \"Kutsama?\" olarak değiştirilir, değişimin ardından eşit miktarda yığın tüketilir."
  },
  State_146154_Name = {
    Text = "<PVPBlessColour:Kutsama>"
  },
  State_146155_Desc = {
    Text = "Bu Uyandırıcı kendini iyi hissediyor.\n·Bundan sonra [Layer] adet \"Beceri\" kartı \"Kutsama?\" olarak değiştirilecek, değişim sonrasında eşit miktarda yığın tüketilir."
  },
  State_146155_Name = {Text = "Kutsama"},
  State_146155_WeaponDesc = {Text = "Hayır"},
  State_146202_Desc = {
    Text = "Bu Uyandırıcının dünyevi gürültüden kopmuş hissetmesini sağlar.\nTur sona ermeden hiçbir Eylem gerçekleştirilemez, %99 Hasar azaltılır; hedefin Direnci yoksa hedefe Direnç kazandırır.\n·Etki sona erdiğinde tüm dost birimlere eşit miktarda yığın kadar pasif Hasar verir.\n·Uygulandığında hedefin Direnci varsa Göz Boyama anında sona erer ve hedefe verilen Hasar iki katına çıkar."
  },
  State_146202_Name = {
    Text = "<CardKeyWord:Oyalama>"
  },
  State_146352_Desc = {
    Text = "Her 1 Hasar alındığında, [StateArg1] kat <Shimieluotanhuodong1:Savaş Azmi> biriktirir"
  },
  State_146352_Name = {
    Text = "Savaşta Çelikleşmiş"
  },
  State_146363_Desc = {
    Text = "Sonraki tur başında [Layer] Can kaldırılır. Can kaybedildiğinde bu Durumun eşit miktarda yığını azalır."
  },
  State_146363_Name = {
    Text = "Yalan Olmayan Şey"
  },
  State_146383_Desc = {
    Text = "Durum eklendikten sonra, Kart oynanıldıktan sonra, her Uyandırıcının Keyflare Yenilenme Seviyesini yeniler ve yazdırır."
  },
  State_146383_Name = {
    Text = "Verimlilik Girişi"
  },
  State_146384_Desc = {
    Text = "P1 değeri [StateArg1], P2 değeri [StateArg2], P3 değeri [StateArg3], P4 değeri [StateArg4]."
  },
  State_146384_Name = {
    Text = "Verimlilik Değeri"
  },
  State_146385_Desc = {
    Text = "Durum eklendikten sonra, Kart oynanıldıktan sonra, her Uyandırıcının Keyflare Yenilenme Seviyesini yeniler ve yazdırır."
  },
  State_146385_Name = {
    Text = "Seviye Girişi"
  },
  State_146386_Desc = {
    Text = "P1 değeri [StateArg1], P2 değeri [StateArg2], P3 değeri [StateArg3], P4 değeri [StateArg4]."
  },
  State_146386_Name = {
    Text = "Seviye Değeri"
  },
  State_146446_Desc = {
    Text = "Uyandırıcı SAV, P1: [StateArg1], P2: [StateArg2], P3: [StateArg3], P4: [StateArg4]."
  },
  State_146446_Name = {
    Text = "Savunma Özellik Listesi"
  },
  State_146448_Desc = {
    Text = "Uyandırıcı SLD, P1: Güç[StateArg1]Yoğunluk[StateArg2], P2: Güç[StateArg3]Yoğunluk[StateArg4], P3: Güç[StateArg5]Yoğunluk[StateArg6], P4: Güç[StateArg7]Yoğunluk[StateArg8]."
  },
  State_146448_Name = {
    Text = "Saldırı Özellik Listesi"
  },
  State_146452_Desc = {
    Text = "Takım Özgünlüğü: kullananın \"Vuruş\" Kritik Hasarı <WeaponEffect_Num:[StateArg1]%> artar. Tur sonunda kullananın bir sonraki Taşkınlık Kritik Hasarı artar; artış yüzdesi Aliemus Üssü'nün <WeaponEffect_Num:[StateArg2]%>'sine eşittir, en fazla 5 kez yığılabilir."
  },
  State_146452_WeaponDesc = {
    Text = "kullananın \"Vuruş\" Kritik Hasarı <WeaponEffect_Num:[StateArg1]%> artar. Tur sona erdiğinde kullananın bir sonraki Taşkınlık Kritik Hasarı <WeaponEffect_Num:[DescArg1]%> artar, en fazla 5 kez yığınlanabilir (şu an [DescArg2]% aktif)."
  },
  State_146456_Desc = {
    Text = "Takım Özgünlüğü: kullananın \"Vuruş\" Kritik Hasarı <WeaponEffect_Num:[StateArg1]%> artar."
  },
  State_146456_WeaponDesc = {
    Text = "kullananın \"Vuruş\" Kritik Hasarı <WeaponEffect_Num:[StateArg1]%> artar."
  },
  State_146534_Desc = {
    Text = "Sahne başladıktan sonra, Köken Kaos'un her mekanizmasının kapsayıcısını Koruyucu'ya ekler."
  },
  State_146534_Name = {
    Text = "Köken Kaos Başlatma"
  },
  State_146535_Desc = {
    Text = "Özellik kapsayıcısı."
  },
  State_146535_Name = {
    Text = "Köken Kaos Tanımlayıcısı"
  },
  State_146536_Desc = {
    Text = "Mekanizma kapsayıcısı."
  },
  State_146536_Name = {
    Text = "Köken Kaos Mekanizması"
  },
  State_146644_Desc = {
    Text = "Uyanış, Hazırlan 1 kazanır; her turun ilk oynanışında taşınan Müfreze otomatik olarak serbest bırakılır."
  },
  State_146644_Name = {
    Text = "İlksel Yankı"
  },
  State_146645_Desc = {
    Text = "Yeni Kaos Diyarı her turda ilk kez Uyanış oynanıldığında taşınan Müfreze otomatik olarak serbest bırakılır. Şu anda kullanılabilir."
  },
  State_146645_Name = {
    Text = "Kullanılabilir Tanımlayıcı"
  },
  State_146646_Desc = {
    Text = "Temel S-Enerjisi üst sınırı 2000 olarak değiştirilir. S-Enerjisi kazanma kuralı şununla değiştirilir: Uyandırıcı her turda ilk kez Komut Kartı oynadığında, 3 kat Gümüş Anahtar Şarjı + 100 S-Enerjisi kazanır."
  },
  State_146646_Name = {
    Text = "Yeni Kaos Keyflare Kuralı"
  },
  State_146651_Desc = {
    Text = "Bu Uyandırıcı'nın SLD özelliğini [Layer]% artırır."
  },
  State_146651_Name = {
    Text = "Kaos·Saldırı"
  },
  State_146652_Desc = {
    Text = "Savaş başladıktan sonra yalnızca 1 kez, her Uyandırıcı'nın Gümüş Anahtar Şarjı verimliliğini Keyflare Yenilenme Seviyesi ortalamasına göre değiştirir."
  },
  State_146652_Name = {
    Text = "Köken Dengesi"
  },
  State_146653_Desc = {
    Text = "Bu Uyandırıcı'nın SAV özelliğini [Layer]% artırır."
  },
  State_146653_Name = {
    Text = "Kaos·Savunma"
  },
  State_146663_Desc = {
    Text = "Sonraki [Layer] Lotan: Cetarchon'un \"Vuruş\"u 1 ek kez etki eder."
  },
  State_146663_Name = {
    Text = "Cetus'u Yutan Fırtına"
  },
  State_147058_Name = {
    Text = "Aksesuar: Oda 36 Yüzüğü"
  },
  State_147079_Desc = {
    Text = "Bu kart atılamaz veya dönüştürülemez."
  },
  State_147079_Name = {
    Text = "<RetainIconKeywordsColour:Zorla Sakla>"
  },
  State_147545_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Yapılandırılmamış"
  },
  State_147545_Name = {
    Text = "Tinct: Vespera SR (Geçici Metin)"
  },
  State_147546_Name = {
    Text = "Kullanım Dışı"
  },
  State_147546_WeaponDesc = {
    Text = "Ötelerden Gelen Sesler"
  },
  State_147584_Desc = {
    Text = "Bir sonraki oynanan <DerivativeCardKeywords_152:\"Peri Lütfu\">'nun <Blessing:lütuf> etkisi %50 artar"
  },
  State_147737_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında [StateArg1] <MaxHPKeywords:Maksimum can> kazanır. Tur başında tüm düşmanlara <Damage:[Damage:StateArg2]> <PVPBleedingKeywords:Kanama> hasarı verir,"
  },
  State_147737_Name = {
    Text = "Karanlıktan da karanlık"
  },
  State_147764_Name = {
    Text = "Durum@Caraboo Etkinlik Yanlış Seçim Sayacı"
  },
  State_147765_Desc = {
    Text = "Sonraki tur başında 2 Arithmetica kaybeder ve 2 kart daha az çekersiniz."
  },
  State_147765_Name = {
    Text = "Pistoles de Marie"
  },
  State_147768_Desc = {
    Text = "Sonraki tur başında [DescArg1] adet İleri Kavrayış kazanırsınız."
  },
  State_147768_Name = {
    Text = "Pistoles de Marie Altını"
  },
  State_147769_Desc = {
    Text = "Bu savaşta \"Ziyafet\" şu an [Layer] kat yığıldı."
  },
  State_147769_Name = {
    Text = "Yığın Sınırı"
  },
  State_147772_Name = {
    Text = "Durum@Caraboo Etkinlik Geçici Keyflare Üst Sınırı Ekle"
  },
  State_147773_Name = {
    Text = "Durum@Caraboo Etkinlik Geçici Keyflare Üst Sınırı Ekle"
  },
  State_147774_Name = {
    Text = "Durum@Caraboo Etkinlik Geçici Keyflare Üst Sınırı Ekle_Normal Kaos"
  },
  State_147797_Desc = {
    Text = "Aliemus, <PowerIconKeywords:güç>, can puanı, S-Enerjisi ve Arithmetica ile çekme kazanabilir veya kaybedebilirsiniz."
  },
  State_147797_Name = {
    Text = "Pistoles de Marie"
  },
  State_147800_Desc = {
    Text = "Sonraki tur başında 2 Arithmetica kaybeder ve 2 kart daha az çekersiniz."
  },
  State_147800_Name = {
    Text = "Pistoles de Marie"
  },
  State_147869_Name = {
    Text = "[Layer] kart çek"
  },
  State_147870_Name = {
    Text = "Tüm düşmanlara [Layer] tur Zayıflık uygula"
  },
  State_147871_Name = {
    Text = "[Energy:DescArg1] Aliemus kazan"
  },
  State_147872_Name = {
    Text = "Tüm düşmanlara [Layer] tur boyunca Savunmasız uygula"
  },
  State_147873_Name = {
    Text = "[Layer] Aritmetika Kazan"
  },
  State_147874_Name = {
    Text = "[Block:DescArg1] Kalkan kazan"
  },
  State_147962_Desc = {
    Text = "Oyuncu \"<DerivativeCardKeywords_158:Kefaret>\" oynadığında, yalnızca <MonsterSinMarkKeywords:Günah İşareti> yığınlarının %50'sini temizler ve her oynanan Komut Kartı için \"Divus: Beyaz Gece\" 1 yığın <MonsterSinMarkKeywords:Günah İşareti> kazanır."
  },
  State_147962_Name = {
    Text = "Arınma Yolu"
  },
  State_147967_Desc = {
    Text = "\"Divus: Beyaz Gece\"nin verdiği hasara [DescArg1]% <BleedingIconKeywords:Kanama> eklenir."
  },
  State_147967_Name = {
    Text = "Günah Damgası"
  },
  State_147968_Desc = {
    Text = "Üst sınır 3 kat; saldırı niyetine geçildiğinde \"Divus: Beyaz Gece\"nin verdiği hasarı 25% artırır ve 1 kat tüketir."
  },
  State_147968_Name = {
    Text = "Izdırapla Kefaret"
  },
  State_147969_Desc = {
    Text = "\"Divus: Beyaz Gece\" \"Kutsal Kalp\" niyetindeyken her 1 Komut Kartı oynadığında 2 kat <MonsterPolluxFever:Şevk> biriktirir."
  },
  State_147969_Name = {
    Text = "İlahi Vahiy"
  },
  State_147971_Desc = {
    Text = "Bu Uyandırıcı henüz Uyanmadı... Yenilmek üzereyken Can yenilenir ve 1 yığın <InvincibleUntilRoused:Geçilmez Zırh> kazanır. Uyanma gerçekleştikten sonra, <InvincibleUntilRoused:Geçilmez Zırh> kaldırılır ve gerçek formunda savaşa başlar."
  },
  State_147971_Name = {
    Text = "Uyanmamış"
  },
  State_147972_Desc = {
    Text = "Her kat, \"Divus: Beyaz Gece\"nin verdiği hasara 1% <BleedingIconKeywords:Kanama> ekler."
  },
  State_147972_Name = {
    Text = "<MonsterSinMarkKeywords:Günah İşareti>"
  },
  State_147974_Desc = {
    Text = "Tur başında temizlenir. 10 kata ulaşıldığında bir sonraki kart oynanır oynanmaz hemen harekete geçer, Şevk'i kaldırır ve niyeti \"Kutsal Kalp\" olarak değiştirir."
  },
  State_147974_Name = {
    Text = "Geçici Coşku"
  },
  State_147975_Desc = {
    Text = "Savaş başında el kartlarına bir \"<DerivativeCardKeywords_158:Kefaret>\" eklenir; tur sonunda 5 kat <MonsterSinMarkKeywords:Günah İşareti> kazanılır."
  },
  State_147975_Name = {
    Text = "Işık Taşıyıcının Habercisi"
  },
  State_147993_Desc = {
    Text = "Üst sınır 3 kat; saldırı niyetine geçildiğinde \"Divus: Beyaz Gece\"nin verdiği hasarı 25% artırır ve 1 kat tüketir."
  },
  State_147993_Name = {
    Text = "Izdırapla Kefaret"
  },
  State_148020_Desc = {
    Text = "Tüm hasara Bağışık olur ve Can kaybedilemez; Uyanış sonrası kaldırılır."
  },
  State_148020_Name = {
    Text = "Gümüş Çekirdek Pekişmesi"
  },
  State_148021_Name = {
    Text = "Durum@Canavar Genel Diriliş Uyanış Öncesi Bağışıklık Temizleme İşareti"
  },
  State_148073_Name = {
    Text = "1 kart çek."
  },
  State_148074_Desc = {
    Text = "Kart Atılmış Kart Destesine girmez, bunun yerine elinde kalır."
  },
  State_148074_Name = {
    Text = "<RetainIconKeywords:Sakla>"
  },
  State_148074_WeaponDesc = {
    Text = "Kart Atılmış Kart Destesine girmez, bunun yerine elinde kalır."
  },
  State_148076_Name = {
    Text = "Arınma Yolu Kart Oynama Dinleyicisi"
  },
  State_148116_Desc = {
    Text = "1 tur sonra [StateArg1] kart çek [Layer] kez."
  },
  State_148116_Name = {
    Text = "Gecikmeli Çekiş1"
  },
  State_148381_Desc = {
    Text = "Tur sona erene kadar, kendisinin verdiği hasara %100 <BleedingIconKeywords:Kanama> eklenir."
  },
  State_148381_Name = {
    Text = "Zincirli Kin"
  },
  State_148383_Desc = {
    Text = "Maksimum 3 yığın. 3 yığın \"Sonsuz Katliam\" elde tutuluyorsa, Niyet bir sonraki \"Kızıl Zincirler\"e geçişinde, bunun yerine Niyet \"Kan Emici Topuz\"a geçer ve \"Sonsuz Katliam\" temizlenir."
  },
  State_148383_Name = {Text = "\"Kin\""},
  State_148385_Desc = {
    Text = "Düşman her Komut Kartı oynadığında 2 kat <MonsterB05EXFever:Geçici Coşku> kazanırsınız."
  },
  State_148385_Name = {
    Text = "Düzensiz Form"
  },
  State_148386_Desc = {
    Text = "Tur sona erene kadar Kalkan kazanılamaz."
  },
  State_148386_Name = {
    Text = "Kanlı Zincirler"
  },
  State_148387_Desc = {
    Text = "Bu Uyandırıcı henüz Uyanmadı... Yenilmek üzereyken Can yenilenir ve 1 yığın <InvincibleUntilRoused:Geçilmez Zırh> kazanır. Uyanma gerçekleştikten sonra, <InvincibleUntilRoused:Geçilmez Zırh> kaldırılır ve gerçek formunda savaşa başlar."
  },
  State_148387_Name = {
    Text = "Uyanmamış"
  },
  State_148391_Desc = {
    Text = "Tur sona erene kadar, kendisinin verdiği hasara %100 <BleedingIconKeywords:Kanama> eklenir."
  },
  State_148391_Name = {
    Text = "Kanlı Zincirler"
  },
  State_148392_Desc = {
    Text = "Tur başında temizlenir. 10 kata ulaşıldığında bir sonraki kart oynanır oynanmaz hemen harekete geçer, Şevk'i kaldırır ve niyeti \"Kızıl Zincirler\" olarak değiştirir."
  },
  State_148392_Name = {
    Text = "Geçici Coşku"
  },
  State_148394_Desc = {
    Text = "Tur başında 1 yığın <ResentChainsKeywords:Kin Zincirleri> kazanır. Niyet \"Kan Emici Topuz\"a geçtiğinde, düşman turunun sona ermesine kadar tüm hasar ve can kaybı etkilerine karşı Bağışık olur."
  },
  State_148394_Name = {
    Text = "Ruh Biçicisinin Bildirisi"
  },
  State_148395_Desc = {
    Text = "Tüm hasara (Delici Hasar dahil) Bağışık olur ve can kaybedilemez; düşman turu sona erdikten sonra kaldırılır."
  },
  State_148395_Name = {
    Text = "Ruh Biçicisinin Bildirisi - Kan Emici Topuz"
  },
  State_148421_Desc = {
    Text = "1 tur sonra tüm düşmanların [StateArg1] puan <ExhaustionIconKeywords:güç> değerini geçici olarak [Layer] kez düşür"
  },
  State_148421_Name = {
    Text = "Gecikmeli Tükenme 1"
  },
  State_148422_Desc = {
    Text = "1 tur sonra geçici Hasar Güçlendirmesi [StateArg1]% [Layer] kez."
  },
  State_148422_Name = {
    Text = "Gecikmeli Geçici Hasar Güçlendirmesi1"
  },
  State_148423_Desc = {
    Text = "1 tur sonra <Posse:[StateArg1]> puan S-Enerjisi kazanır [Layer] kez."
  },
  State_148423_Name = {
    Text = "Gecikmeli S-Enerjisi 1"
  },
  State_148426_Desc = {
    Text = "1 tur sonra [StateArg1] puan Arithmetica kazanır [Layer] kez."
  },
  State_148426_Name = {
    Text = "Gecikme Arithmetica 1"
  },
  State_148427_Desc = {
    Text = "1 tur sonra tüm Uyandırıcılar [StateArg1] puan Aliemus kazanır [Layer] kez."
  },
  State_148427_Name = {
    Text = "Gecikmeli Aliemus1"
  },
  State_148428_Desc = {
    Text = "1 tur sonra [StateArg1] puan <PowerIconKeywords:güç> kazanır [Layer] kez."
  },
  State_148428_Name = {
    Text = "Gecikmeli Güç 1"
  },
  State_148511_Desc = {
    Text = "Takım Özgünlüğü: Keşif başladıktan sonra, deste ye 1 adet <Backupbody[StateArg3]:\"Ruh Senkronizasyonu\"> ekler. \"Ruh Senkronizasyonu\": Arithmetica Maliyeti 0, oynanınca 1 Arithmetica kazanır. <RetainIconKeywords:Sakla>: kullananın KON'unun <WeaponEffect_Num:[StateArg1]%>'i kadar sabit Can İyileştirmesi ile <WeaponEffect_Num:[StateArg2]> sabit Aliemus'u bu kartta biriktirir. Bu kart imha edilmemişse, bir kez ölümden Bağışık olur ve biriktirilen tüm Can İyileştirmesi ile Aliemus'u serbest bırakır; ardından bu kartı <DestructionKeywords:İmha Et>."
  },
  State_148511_Name = {
    Text = "Ruh Senkronizasyonu"
  },
  State_148511_WeaponDesc = {
    Text = "Keşif başladıktan sonra, desteye 1 adet <Backupbody[StateArg3]:\"Ruh Senkronizasyonu\"> ekler. \"Ruh Senkronizasyonu\": Arithmetica Maliyeti 0, oynanınca 1 Arithmetica kazanır. <RetainIconKeywords:Sakla>: kullananın KON'unun <WeaponEffect_Num:[StateArg1]%>'i kadar sabit Can İyileştirmesi ile <WeaponEffect_Num:[StateArg2]> sabit Aliemus'u bu kartta biriktirir. Bu kart imha edilmemişse, bir kez ölümden Bağışık olur ve biriktirilen tüm Can İyileştirmesi ile Aliemus'u serbest bırakır; ardından bu kartı <DestructionKeywords:İmha Et>."
  },
  State_148513_Desc = {
    Text = "Rakip, turun sonunda elindeki kartları atmaz. Tur sonunda, sırayla 2 yığın <FragileIconKeywords:Kırılgan>, <WeaknessIconKeywords:Zayıflık>, <HeavyInjuryKeywords:Ağır Yıkım> ve <VulnerabilityIconKeywords:Savunmasız> durumu uygula."
  },
  State_148513_Name = {
    Text = "Ötelerden Gelen Sesler"
  },
  State_148520_Desc = {
    Text = "Tur sona erene kadar Kalkan kazanılamaz."
  },
  State_148520_Name = {
    Text = "Zincirli Kin"
  },
  State_148522_Desc = {
    Text = "Takım Özgünlüğü: kullananın \"Taşkınlık\" saldırısının verdiği Kalkan ve güç <WeaponEffect_Num:[StateArg1]%> artar."
  },
  State_148524_Desc = {
    Text = "Takım Özgünlüğü: kullananın \"Taşkınlık\" saldırısının verdiği Kalkan ve güç <WeaponEffect_Num:[StateArg1]%> artar. kullananın \"Savunma\" saldırısının verdiği Kalkan Artışı <WeaponEffect_Num:[StateArg2]%> artar. kullanan \"Savunma\" oynadıktan sonra kullananın SLD'sinin <WeaponEffect_Num:[StateArg3]%>'i kadar güç kazanır."
  },
  State_148540_Desc = {
    Text = "Gecikme[Layer]: <AwakerName:[DescArg1]>'ın en yüksek Arithmetica'ya sahip [StateArg1] Komut Kartının Arithmetica Maliyeti [StateArg2] azalır."
  },
  State_148540_Name = {
    Text = "Öngörü Aynası - Gecikme[Layer]"
  },
  State_148541_Name = {
    Text = "Seçilen Uyandırıcı'nın eldeki kartından \"Durağanlık\" efektini kaldır"
  },
  State_148544_Desc = {
    Text = "Gecikme[Layer] : <AwakerName:[DescArg1]> bir sonraki Taşkınlık sırasında harcanan her 1 Aliemus puanı için [StateArg1] puan S-Enerjisi kazanır."
  },
  State_148544_Name = {
    Text = "Goetia Anahtarı - Gecikme[Layer]"
  },
  State_148547_Desc = {
    Text = "<AwakerName:[DescArg1]> bir sonraki Taşkınlık, Aşırı Yüceltme olarak sayılır; zaten Aşırı Yüceltme ise %100 Aliemus Üssü iade edilir."
  },
  State_148547_Name = {
    Text = "Sonsuzluk Tacı"
  },
  State_148548_Desc = {
    Text = "Sakla: Tüm Uyandırıcılar 5 Aliemus kazanır."
  },
  State_148548_Name = {
    Text = "Derin Düşünceye Dalmış"
  },
  State_148549_Name = {
    Text = "Eldeki tüm \"Hazırlan\" etkilerini tetikle"
  },
  State_148553_Desc = {
    Text = "Gecikme[Layer]: <AwakerName:[DescArg1]>'ın oynayacağı sonraki [Layer] Komut Kartı, kaybedilen Canın %[StateArg2]'üne eşit Kalkan kazanır."
  },
  State_148553_Name = {
    Text = "Baştan Çıkarma Meyvesi - Gecikme[Layer]"
  },
  State_148554_Desc = {
    Text = "<AwakerName:[DescArg1]> Komut Kartı ile verilen hasara [Layer]% Kanama ekler."
  },
  State_148554_Name = {
    Text = "Yıkım Gözü"
  },
  State_148556_Desc = {
    Text = "Elde tutulduğunda, tüm Uyandırıcılar Aktif Hasar verirken ek %10 Kanama uygular."
  },
  State_148556_Name = {
    Text = "Öngörülen Kabus"
  },
  State_148557_Desc = {
    Text = "<AwakerName:[DescArg1]>'ın oynayacağı sonraki [Layer] Komut Kartı, kaybedilen Canın %[StateArg1]'üne eşit Kalkan kazanır."
  },
  State_148557_Name = {
    Text = "Baştan Çıkarma Meyvesi"
  },
  State_148559_Desc = {
    Text = "<AwakerName:[DescArg1]> bir sonraki Taşkınlık sırasında harcanan her 1 Aliemus puanı için [Layer] puan S-Enerjisi kazanır."
  },
  State_148559_Name = {
    Text = "Goetia Anahtarı"
  },
  State_148561_Desc = {
    Text = "Bu kart oynanırken, aşağıdaki üç olumsuz etkiden rastgele biri tetiklenir: Etki %50 azalır / 2 tur Gecikme ile etki eder / Rastgele 1 olumsuz etki kazanır."
  },
  State_148561_Name = {
    Text = "<ExclamationPointColour:Çarpık Dilek>"
  },
  State_148562_Name = {
    Text = "Seçilen Uyandırıcı 10 Aliemus kazanır"
  },
  State_148563_Desc = {
    Text = "Gecikme[Layer]: <AwakerName:[DescArg1]>'ın bir sonraki Taşkınlığında kazanılan Kalkan ve Can İyileşmesi %[StateArg1] artar."
  },
  State_148563_Name = {
    Text = "Adalet Tüyü - Gecikme[Layer]"
  },
  State_148566_Desc = {
    Text = "<AwakerName:[DescArg1]> bir sonraki Taşkınlık ile verilen hasara [Layer]% Son Karar ekler."
  },
  State_148566_Name = {Text = "Kader İpi"},
  State_148569_Desc = {
    Text = "<AwakerName:[DescArg1]>'ın bir sonraki Taşkınlığında kazanılan Kalkan ve Can İyileşmesi %[Layer] artar."
  },
  State_148569_Name = {
    Text = "Adalet Tüyü"
  },
  State_148571_Desc = {
    Text = "Gecikme[Layer] : <AwakerName:[DescArg1]> Komut Kartı ile verilen hasara [StateArg1]% Kanama ekler."
  },
  State_148571_Name = {
    Text = "Yıkım Gözü - Gecikme[Layer]"
  },
  State_148574_Desc = {
    Text = "Gecikme[Layer] : <AwakerName:[DescArg1]> bir sonraki Taşkınlık ile verilen hasara [StateArg1]% Son Karar ekler."
  },
  State_148574_Name = {
    Text = "Kader İpi - Gecikme[Layer]"
  },
  State_148575_Name = {
    Text = "Seçilen Uyandırıcı 20 Aliemus kazanır"
  },
  State_149089_Name = {
    Text = "Durum@Fener Tazısı Küçük Yutma Aliemus İşareti"
  },
  State_149092_Desc = {
    Text = "\"<AwakerName:[DescArg1]>\" adlı Uyandırıcının <Energy:[Energy:DescArg2]> Aliemus'unu yuttu; ölümün ardından iade edilir."
  },
  State_149092_Name = {Text = "Yutmak"},
  State_149094_Desc = {
    Text = "Takım Özgünlüğü: Kullanana ait Taşkınlığın oluşturduğu Temel Kalkan +<WeaponEffect_Num:[StateArg1]%>. Kullanan <WeaknessIconKeywords:Semptom: Zayıflık> uygulayan bir Komut Kartı oynadıktan sonra, bir sonraki ekipman Komut Kartının oluşturduğu Temel Kalkan +<WeaponEffect_Num:[StateArg1]%> artar. Yığılamaz. \"Kızıl Ocak\" kullanıldığında, kullanana ait en yüksek Arithmetica Maliyetli beceri kartını çek, <EmbryoFusionIconKeywords:Embriyo Füzyonu> +<WeaponEffect_Num:[StateArg1]%>, 3 tur bekleme süresi."
  },
  State_149094_WeaponDesc = {
    Text = "Kullanana ait Taşkınlık Temel Kalkanı +<WeaponEffect_Num:[StateArg1]%>. Kullanan <WeaknessIconKeywords:Semptom: Zayıflık> uygulayan bir Komut Kartı oynadıktan sonra, Komut Kartı Temel Kalkanı +<WeaponEffect_Num:[StateArg1]%> artar. \"Kızıl Ocak\" kullanıldığında, kullanana ait en yüksek Arithmetica Maliyetli Beceri Kartını çek, <EmbryoFusionIconKeywords:Embriyo Füzyonu> +<WeaponEffect_Num: [StateArg1]>, 3 tur bekleme süresi."
  },
  State_149122_Desc = {
    Text = "Ölümün ardından, \"Küme Etkisi\" 1 yığın azaltılmış 1 rastgele \"Fener Tazısı\" hemen çağrılır."
  },
  State_149122_Name = {
    Text = "Küme Etkisi"
  },
  State_149123_Desc = {
    Text = "Taşkınlık'tan alınan hasar %50 azalır."
  },
  State_149123_Name = {
    Text = "Karanlık Fener Modu"
  },
  State_149124_Desc = {
    Text = "Komut Kartlarından alınan hasar %50 azalır."
  },
  State_149124_Name = {
    Text = "Buzul Fener Modu"
  },
  State_149125_Desc = {
    Text = "\"<AwakerName:[DescArg1]>\" adlı Uyandırıcının Komut Kartını dondurdu; ölümün ardından bu Uyandırıcının Dondurması kaldırılır."
  },
  State_149125_Name = {Text = "Yutmak"},
  State_149126_Desc = {
    Text = "Ölümün ardından, \"Küme Etkisi\" 1 yığın azaltılmış 1 rastgele \"Fener Tazısı\" hemen çağrılır."
  },
  State_149126_Name = {
    Text = "Küme Etkisi"
  },
  State_149128_Name = {
    Text = "Durum@Buzlu Fener Tazısı Küçük Dondurma Komut Kartı İşareti"
  },
  State_149140_Desc = {
    Text = "Düşmanın becerilerini güçlendirir. Düşman, hasar aldığında 1 yığın kaybeder."
  },
  State_149140_Name = {Text = "Kan Yemini"},
  State_149143_Desc = {
    Text = "Çekme aşaması sona erdikten sonra, düşmanın elindeki her [DescArg1] <SlowIconKeywords:Durgunluk> Komut Kartı için kendisi [DescArg2] yığın <BloodOath_New:Kan Yemini> kazanır. Kendisi bloke edilmemiş hasar verdikten sonra, eldeki veya Çekme Destesindeki [DescArg3] adet <SlowIconKeywords:Durgunluk> uygulanmamış Komut Kartına rastgele [DescArg4] yığın <SlowIconKeywords:Durgunluk> uygular."
  },
  State_149143_Name = {
    Text = "Donmuş Yemin"
  },
  State_149162_Desc = {
    Text = "Engellenmemiş hasar verdiğinde Direnç'i kaldırır."
  },
  State_149162_Name = {
    Text = "Uzak Doğu Büyücülüğü"
  },
  State_149163_Desc = {
    Text = "Maksimum can eşit yığın sayısı kadar azalır; savaş sona erdikten sonra yarıya iner."
  },
  State_149163_Name = {
    Text = "<BoneHitKeywords:Kemik Delici>"
  },
  State_149164_Desc = {
    Text = "Hasar verdiğinde Kemik Delici uygular."
  },
  State_149164_Name = {
    Text = "Delici Soğuk"
  },
  State_149167_Desc = {
    Text = "Maksimum can [Layer] azalır, savaş bitiminde yarıya iner."
  },
  State_149167_Name = {
    Text = "<BoneHitKeywords:Kemik Delici>"
  },
  State_149169_Desc = {
    Text = "Her yığın, Maksimum Canı Caraboo'nun KON'unun %10'u kadar artırır (En fazla 50 yığın). Maksimum yığına ulaşıldığında, fazla yığınlar bunun yerine bu Can değerinin 3 katı kadar iyileştirir. Patron olmayan savaşlarda tur başına en fazla 10 yığın \"Tokluk\" kazanılabilir. \"Tokluk\" savaşlar arasında kalıcıdır."
  },
  State_149169_Name = {
    Text = "<WormGrowth:Ziyafet>"
  },
  State_149172_Desc = {
    Text = "Takım Özgünlüğü: Kullanan <WeaknessIconKeywords:Semptom: Zayıflık> uygulayan bir Komut Kartı oynadıktan sonra, bir sonraki ekipman Komut Kartının oluşturduğu Temel Kalkan +<WeaponEffect_Num:[StateArg1]%> artar. Yığılamaz."
  },
  State_149172_WeaponDesc = {
    Text = "Kullanan <WeaknessIconKeywords:Semptom: Zayıflık> uygulayan bir Komut Kartı oynadıktan sonra, bir sonraki Komut Kartının Temel Kalkanı +<WeaponEffect_Num:[StateArg1]%> artar."
  },
  State_149187_Desc = {
    Text = "Test | Sabit Hasar aldıktan sonra ve Sabit Hasar Öldürme yaptıktan sonra dinle, tetikleme değerini ve ilişkili olanı yazdır."
  },
  State_149187_Name = {
    Text = "Test Sabit Hasarı"
  },
  State_149188_Desc = {
    Text = "Test｜Sabit Hasar ile Öldürme gerçekleştiğinde, tetikleme değeri 1, Öldürme gerçek hasarı:[Layer]"
  },
  State_149188_Name = {
    Text = "Test Sabit Öldürme Tetikleme Değeri 2"
  },
  State_149189_Desc = {
    Text = "Test | Sabit Hasar Öldürme yaptıktan sonra, ilişkili 2, öldürmeyi gerçekleştiren kaynak: [Layer]"
  },
  State_149189_Name = {
    Text = "Test Sabit Öldürme İlişkilisi 2"
  },
  State_149190_Desc = {
    Text = "Test｜Sabit Hasar ile Öldürme gerçekleştiğinde, tetikleme değeri 1, Öldürme taşma hasarı:[Layer]"
  },
  State_149190_Name = {
    Text = "Test Sabit Öldürme Tetikleme Değeri 3"
  },
  State_149191_Desc = {
    Text = "Test | Sabit Hasar aldıktan sonra, tetikleme değeri 1, toplam hasar: [Layer]"
  },
  State_149191_Name = {
    Text = "Test Sabit Hasar Tetikleme Değeri 1"
  },
  State_149192_Desc = {
    Text = "Test | Sabit Hasar Öldürme yaptıktan sonra, ilişkili 1, öldürülen: [Layer]"
  },
  State_149192_Name = {
    Text = "Test Sabit Öldürme İlişkilisi 1"
  },
  State_149193_Desc = {
    Text = "Test | Sabit Hasar aldıktan sonra, ilişkili 2, vurulan: [Layer]"
  },
  State_149193_Name = {
    Text = "Test Sabit Hasar İlişkilisi 2"
  },
  State_149194_Desc = {
    Text = "Test | Sabit Hasar aldıktan sonra, tetikleme değeri 1, toplam hasar: [Layer]"
  },
  State_149194_Name = {
    Text = "Test Sabit Hasar Tetikleme Değeri 2"
  },
  State_149195_Desc = {
    Text = "Test | Sabit Hasar Öldürme yaptıktan sonra, tetikleme değeri 1, toplam öldürme hasarı: [Layer]"
  },
  State_149195_Name = {
    Text = "Test Sabit Öldürme Tetikleme Değeri 1"
  },
  State_149196_Desc = {
    Text = "Test | Sabit Hasar aldıktan sonra, ilişkili 1, hasar kaynağı: [Layer]"
  },
  State_149196_Name = {
    Text = "Test Sabit Hasar İlişkilisi 1"
  },
  State_149227_Desc = {
    Text = "Tur sonunda Kalkan kaybolmaz. Kalkana sahipken alınan Taşkınlık Hasarı %50 artar, Komut Kartı hasarı %50 azalır."
  },
  State_149227_Name = {
    Text = "Buzul Pelerini"
  },
  State_149228_Desc = {
    Text = "Hasar verdiğinde Kanama uygular."
  },
  State_149228_Name = {
    Text = "Kanlı Delme"
  },
  State_149229_Desc = {
    Text = "Sahneye çıkışta Maksimum canın %25'ini kaybeder, kaybedilen değerin [DescArg1]%'i kadar \"Buz Kalkanı\" elde eder."
  },
  State_149229_Name = {
    Text = "Buz Kalkanı Dönüşümü"
  },
  State_149230_Desc = {
    Text = "Alınan Komut Kartı hasarı %50 artar, Taşkınlık Hasarı %50 azalır."
  },
  State_149230_Name = {
    Text = "Durum@Gölge Pelerini Hasar Artışı/Azalışı"
  },
  State_149232_Desc = {
    Text = "Tur sonunda Kalkan kaybolmaz. Kalkana sahipken alınan Komut Kartı hasarı %50 artar, Taşkınlık Hasarı %50 azalır."
  },
  State_149232_Name = {
    Text = "Gölge Pelerini"
  },
  State_149233_Desc = {
    Text = "Alınan Taşkınlık Hasarı %50 artar, Komut Kartı hasarı %50 azalır."
  },
  State_149233_Name = {
    Text = "Durum@Buzul Pelerini Hasar Artışı/Azalışı"
  },
  State_149234_Desc = {
    Text = "Sahneye çıkışta Maksimum canın %25'ini kaybeder, kaybedilen değerin [DescArg1]%'i kadar \"Lanetli Koruma\" elde eder."
  },
  State_149234_Name = {
    Text = "Lanetli Koruma Dönüşümü"
  },
  State_149235_Desc = {
    Text = "Engellenmemiş hasar verdiğinde Direnç'i kaldırır."
  },
  State_149235_Name = {
    Text = "Fener Büyüsü"
  },
  State_149250_Desc = {
    Text = "Alınan Komut Kartı Hasarı +50%"
  },
  State_149250_Name = {
    Text = "Alınan Komut Kartı Hasarı +50%"
  },
  State_149251_Desc = {
    Text = "Alınan Komut Kartı Hasarı -50%"
  },
  State_149251_Name = {
    Text = "Alınan Komut Kartı Hasarı -50%"
  },
  State_149252_Desc = {
    Text = "Alınan Taşkınlık Hasarı -50%"
  },
  State_149252_Name = {
    Text = "Alınan Taşkınlık Hasarı -50%"
  },
  State_149253_Desc = {
    Text = "Alınan Taşkınlık Hasarı +50%"
  },
  State_149253_Name = {
    Text = "Alınan Taşkınlık Hasarı +50%"
  },
  State_149265_Desc = {
    Text = "Ölümün ardından hemen rastgele bir \"Wendigo\" Çağır ve onun \"Küme Etkisi\"ni 1 kat azalt."
  },
  State_149265_Name = {
    Text = "Küme Etkisi"
  },
  State_149268_Desc = {
    Text = "Tüm Kalkanları kaybettiğinde, 75 kat Geçici Güçlendirilmiş kazan ve 1 kat \"Blizzard Örtüsü\" kaldır, niyeti <BoneHitKeywords:Kemik Delici> uygulayan güçlü bir saldırıyla değiştir."
  },
  State_149268_Name = {
    Text = "Blizzard Örtüsü"
  },
  State_149269_Desc = {
    Text = "Tüm Kalkanları kaybettiğinde, 75 kat Geçici Güçlendirilmiş kazan ve 1 kat \"Gölge Örtüsü\" kaldır, niyeti Aliemus çalan güçlü bir saldırıyla değiştir."
  },
  State_149269_Name = {
    Text = "Gölge Örtüsü"
  },
  State_149270_Desc = {
    Text = "Ölümün ardından hemen rastgele bir \"Wendigo\" Çağır ve onun \"Küme Etkisi\"ni 1 kat azalt."
  },
  State_149270_Name = {
    Text = "Küme Etkisi"
  },
  State_149308_Name = {
    Text = "Durum@Fener Dua Edici Durgunluk Yığın Kaydı"
  },
  State_149391_Desc = {
    Text = "Bu Uyandırıcı henüz Uyanmadı... Yenilmek üzereyken Can yenilenir ve 1 yığın <InvincibleUntilRoused:Geçilmez Zırh> kazanır. Uyanma gerçekleştikten sonra, <InvincibleUntilRoused:Geçilmez Zırh> kaldırılır ve gerçek formunda savaşa başlar."
  },
  State_149391_Name = {
    Text = "Uyanmamış"
  },
  State_149398_Desc = {
    Text = "\"Peri Pamuk Prenses\" niyeti \"Karlı Büyü\"ye geçtiğinde 1 kat tüketir ve niyeti \"Mucize Bereket\" olarak değiştirir."
  },
  State_149398_Name = {Text = "Ziyafet"},
  State_149399_Desc = {
    Text = "\"Peri Pamuk Prenses\" \"Kusursuz Peri Masalı\"nı kullandıktan sonra bir sonraki [DescArg1] niyet \"Karlı Büyü\" olur. Her tur, [DescArg3] kat <SlowIconKeywords:Durgunluk> içeren [DescArg2] adet rastgele <Blessing:Bereket> kartını destene Karıştır."
  },
  State_149399_Name = {
    Text = "Baştan Çıkarıcı Bal Meyvesi"
  },
  State_149418_Desc = {
    Text = "Kritik Vuruş yapamaz, Temel HSR olarak değerlendirilmez ve Final Hasar gibi bonuslardan etkilenmez."
  },
  State_149418_Name = {
    Text = "<RealDamage:Sabit Hasar>"
  },
  State_149419_Name = {
    Text = "<Rune_6:Siper>"
  },
  State_149420_Name = {
    Text = "<Rune_3:Ustalık>"
  },
  State_149421_Name = {
    Text = "<Rune_15:Patlama>"
  },
  State_149422_Name = {
    Text = "<Rune_4:Hesaplama>"
  },
  State_149423_Name = {
    Text = "<Rune_11:Hükümranlık>"
  },
  State_149424_Name = {
    Text = "<Rune_12:Kan Hırsı>"
  },
  State_149425_Name = {
    Text = "<Rune_1:Savunmasız>"
  },
  State_149426_Name = {
    Text = "<Rune_14:Güç>"
  },
  State_149427_Name = {
    Text = "<Rune_2:Zayıflık>"
  },
  State_149428_Name = {
    Text = "<Rune_9:Diken>"
  },
  State_149429_Name = {
    Text = "<Rune_10:Toksin>"
  },
  State_149430_Name = {
    Text = "<Rune_18:Drenaj>"
  },
  State_149576_Desc = {
    Text = "\"Peri Pamuk Prenses\" niyeti \"Karlı Büyü\"ye geçtiğinde 1 kat tüketir ve niyeti \"Mucize Bereket\" olarak değiştirir."
  },
  State_149576_Name = {Text = "Ziyafet"},
  State_149618_Desc = {
    Text = "2 tur sonra aşağıdaki etkiler tetiklenir:\n[DescArg1] puan Arithmetica kazan. \n[DescArg2] puan güç kazan. \n[DescArg3] puan S-Enerjisi kazan. \n[DescArg5] puan Aliemus kazan. \n[DescArg6] kart çek.\n[DescArg7] puan geçici Hasar Güçlendirmesi kazan.\nTüm düşmanların gücünü geçici olarak [DescArg4] puan düşür."
  },
  State_149618_Name = {
    Text = "Kaçırılan Fırsat2"
  },
  State_149619_Desc = {
    Text = "1 tur sonra aşağıdaki etkiler tetiklenir:\n[DescArg1] puan Arithmetica kazan. \n[DescArg2] puan güç kazan. \n[DescArg3] puan S-Enerjisi kazan. \n[DescArg5] puan Aliemus kazan. \n[DescArg6] kart çek.\n[DescArg7] puan geçici Hasar Güçlendirmesi kazan.\nTüm düşmanların gücünü geçici olarak [DescArg4] puan düşür."
  },
  State_149619_Name = {
    Text = "Kaçırılan Fırsat1"
  },
  State_149628_Desc = {
    Text = "Tur sona ermeden önce düşman en az 1000 S-Enerjisine sahipse, 1000 S-Enerjisi Yut."
  },
  State_149628_Name = {
    Text = "Keyflare Kurban"
  },
  State_149629_Desc = {
    Text = "Tur sona ermeden önce en yüksek Aliemus'a sahip Uyandırıcı en az 100 Aliemus'a sahipse, 50 Aliemus'unu Yut."
  },
  State_149629_Name = {
    Text = "Aliemus Kurban Et"
  },
  State_149630_Desc = {
    Text = "Tur sona ermeden önce düşman en az 1000 S-Enerjisine sahipse, 1000 S-Enerjisi Yut."
  },
  State_149630_Name = {
    Text = "Keyflare Kurban"
  },
  State_149631_Desc = {
    Text = "Tur sona ermeden önce düşman en az 3 puan Arithmetica'ya sahipse, 3 puan Arithmetica Yut."
  },
  State_149631_Name = {
    Text = "Arithmetica Kurban"
  },
  State_149632_Desc = {
    Text = "Tur sona ermeden önce düşman en az 3 puan Arithmetica'ya sahipse, 3 puan Arithmetica Yut."
  },
  State_149632_Name = {
    Text = "Arithmetica Kurban"
  },
  State_149633_Desc = {
    Text = "Kart atma aşamasından önce düşmanın elinde en az 4 Komut Kartı kalırsa, rastgele 2 Komut Kartı Yut."
  },
  State_149633_Name = {
    Text = "Kart Kurban Et"
  },
  State_149634_Desc = {
    Text = "Kart atma aşamasından önce düşmanın elinde en az 4 Komut Kartı kalırsa, rastgele 2 Komut Kartı Yut."
  },
  State_149634_Name = {
    Text = "Kart Kurban Et"
  },
  State_149635_Desc = {
    Text = "Tur sona ermeden önce en yüksek Aliemus'a sahip Uyandırıcı en az 100 Aliemus'a sahipse, 50 Aliemus'unu Yut."
  },
  State_149635_Name = {
    Text = "Aliemus Kurban Et"
  },
  State_149652_Desc = {
    Text = "Kritik Vuruş yapamaz, ilgili Uyandırıcı tarafından verilen Hasar olarak sayılmaz."
  },
  State_149652_Name = {
    Text = "<FixedDamage:Saf Hasar>"
  },
  State_149660_Desc = {
    Text = "Bu kartın verdiği hasar, Kalkan ve güç değişimi [DescArg2]% artar; Dokunaç Hasarı, Can İyileştirme, sabit Zehir ve sabit Karşı Saldırının nihai Etkisi [DescArg1]% artar; oynadıktan sonra kaldırılır."
  },
  State_149660_Name = {
    Text = "Güçlendirme [DescArg1]"
  },
  State_149664_Desc = {
    Text = "Her 1 kat için bu kartın verdiği hasar, sabit güç ve Dokunaç Hasarı artışı, sabit Zehir ve sabit Karşı Saldırının nihai Etkisi %2 artar; sabit Kalkan, sabit Can İyileştirme ve Güç Azalmasının nihai Etkisi %1 artar; oynadıktan sonra kaldırılır."
  },
  State_149664_Name = {Text = "Geliştir"},
  State_149719_Name = {
    Text = "PVP Saf Hasarına Bağışık__\"Yalnızca Geliştirme İçin\""
  },
  State_149736_Desc = {
    Text = "<AwakerName:[DescArg1]>'nın sonraki [Layer] Komut Kartının Temel Kalkanı [StateArg1]% artar."
  },
  State_149736_Name = {
    Text = "Tatlı dilli aldatmaca"
  },
  State_149744_Desc = {
    Text = "Bir sonraki oynanan Bereket olumsuz etkiyi tetiklemez"
  },
  State_149744_Name = {
    Text = "Debuff Bağışıklığı"
  },
  State_149772_Desc = {
    Text = "Her Aktif Hasar alındığında, tüm Uyandırıcılar 3 Aliemus kaybeder. Tur başına en fazla 5 kez tetiklenir. Kalkan kırıldıktan sonra \"Lanetli Koruma\" Durumunu kaldırır."
  },
  State_149772_Name = {
    Text = "Lanetli Koruma"
  },
  State_149773_Desc = {
    Text = "Her Aktif Hasar alındığında, eldeki 1 rastgele Karta 1 yığın Geçici \"Durağanlık\" uygular. Tur başına en fazla 5 kez tetiklenir. Kalkan kırıldıktan sonra \"Buz Kalkanı\"nı kaldırır."
  },
  State_149773_Name = {
    Text = "Ayaz Kalkanı"
  },
  State_149782_Desc = {
    Text = "Tüket: Bir sonraki tur kart çektikten sonra, Çekme Destesine 1 \"Değişken Meyve\" karıştır."
  },
  State_149782_Name = {
    Text = "Değişken Meyve"
  },
  State_149787_Desc = {
    Text = "Her 1 kat için, Yeminini Bozmuş·Ogier'in Komut Kartı Final Hasarı [DescArg2]% artar, tur başında çekme sayısı -1 olur, Kritik Hasar [DescArg3]% artar, üst sınır [DescArg1] kat, savaş bitiminde temizlenmez."
  },
  State_149787_Name = {
    Text = "<KuangNu:Gizli Akıntı>"
  },
  State_149788_Desc = {
    Text = "Yeminini Bozmuş·Ogier'in \"Beceri\" kartını oynarken, 1 yığın tüket ve bir sonraki oynanıştan önce Sakla kazanan 1 \"Savunma\" kartı Çek. Maksimum [DescArg1] yığın. Savaş sonunda temizlenmez."
  },
  State_149788_Name = {
    Text = "<ShuZui:Öz Suçlama>"
  },
  State_149789_Desc = {
    Text = "Her 1 kat için, Yeminini Bozmuş·Ogier'in Komut Kartı Final Hasarı %33 artar, tur başında çekme sayısı -1 olur, üst sınır [DescArg1] kat, savaş bitiminde temizlenmez."
  },
  State_149789_Name = {
    Text = "<KuangNu:Gizli Akıntı>"
  },
  State_149790_Desc = {
    Text = "Her 1 kat için, Yeminini Bozmuş·Ogier'in Komut Kartı Final Hasarı [DescArg2]% artar, tur başında çekme sayısı -1 olur, üst sınır [DescArg1] kat, savaş bitiminde temizlenmez."
  },
  State_149790_Name = {
    Text = "<KuangNu:Gizli Akıntı>"
  },
  State_149791_Desc = {
    Text = "Yeminini Bozmuş·Ogier'in \"Beceri\" kartını oynarken, 1 yığın tüket ve bir sonraki oynanıştan önce Sakla kazanan 1 \"Savunma\" kartı Çek. Maksimum [DescArg1] yığın. Savaş sonunda temizlenmez."
  },
  State_149791_Name = {
    Text = "<ShuZui:Öz Suçlama>"
  },
  State_149814_Desc = {
    Text = "Geçici Hasar Güçlendirmesi +[Layer]."
  },
  State_149814_Name = {
    Text = "Geçici Hasar Güçlendirmesi"
  },
  State_149819_Desc = {
    Text = "Tüm Hasara karşı Bağışıklık"
  },
  State_149819_Name = {
    Text = "Bağışık"
  },
  State_149892_Desc = {
    Text = "<AwakerName:[DescArg1]>'nın sonraki [Layer] Komut Kartının Temel Kalkanı [StateArg1]% artar."
  },
  State_149892_Name = {
    Text = "Sakin Hakikat"
  },
  State_149913_Name = {
    Text = "Durum@Makrofaj Solucanı Hazine Etki_Tinktur Hasarlı"
  },
  State_149914_Name = {
    Text = "Durum@Makrofaj Solucanı Hazine Etkisi_William Hasar Aldı"
  },
  State_149915_Name = {
    Text = "Durum@Makrofaj Solucanı Hazine Etkisi_William"
  },
  State_149916_Name = {
    Text = "Durum@Makrofaj Solucanı Hazine Etkisi_Castor Hasar Aldı"
  },
  State_149917_Name = {
    Text = "Durum@Makrofaj Solucanı Hazine Etki_Helot Helot Hasarlı"
  },
  State_149918_Name = {
    Text = "Durum@Makrofaj Solucanı Tur Başlangıç Testi"
  },
  State_149919_Name = {
    Text = "Durum@Makrofaj Solucanı Hazine Etki_Tinktur"
  },
  State_149920_Name = {
    Text = "Durum@Makrofaj Solucanı Hazine Etki_Arachne"
  },
  State_149921_Name = {
    Text = "Durum@Makrofaj Solucanı Hazine Etki_Arachne Hasarlı"
  },
  State_149922_Name = {
    Text = "Durum@Makrofaj Solucanı Hazine Etkisi_Castor"
  },
  State_149923_Name = {
    Text = "Durum@Makrofaj Solucanı Hazine Etki_Helot Helot"
  },
  State_149930_Desc = {
    Text = "Her yığın için, Yeminini Bozmuş·Ogier'in Komut Kartlarının Final Hasarı %50 artar. Turun başında, Çekme sayısı -1 azalır. Maksimum [DescArg1] yığın. Savaş sonunda temizlenmez."
  },
  State_149930_Name = {
    Text = "<KuangNu2:Gizli Akıntı>"
  },
  State_149931_Desc = {
    Text = "7 tür etki içerir: STR kazan, Kızıl Ocak İyileştirmesi biriktir, tüm Uyandırıcılar Aliemus kazan, Embriyo Füzyonu güçlendirmesi, kart çek, S-Enerjisi kazan ve Geçici Hasar Güçlendirmesi artışı."
  },
  State_149931_Name = {
    Text = "<Blessing:Bereket>"
  },
  State_149933_Name = {
    Text = "Durum@Canavar Caraboo Adak Balonu"
  },
  State_149934_Name = {
    Text = "Durum@Canavar Caraboo Adak Balonu"
  },
  State_149939_Desc = {
    Text = "Tur sona erene kadar Kalkan kazanılamaz."
  },
  State_149939_Name = {
    Text = "Kanlı Zincirler"
  },
  State_19507_Desc = {
    Text = "Alınan Aktif Hasar ve Kan Akıtma yığınları, bir sonraki tur başlayana dek %25 artar, Kale yığınlarıyla dengelenir."
  },
  State_19507_Name = {
    Text = "<PVPVulnerabilityIconColour:Savunmasız>"
  },
  State_19508_Desc = {
    Text = "Tur sonunda bu kartı at."
  },
  State_19508_Name = {
    Text = "<PVPVoidKeyColour:Yanılsama>"
  },
  State_19509_Desc = {
    Text = "Kartın Arithmetica'sını geçici olarak değiştir."
  },
  State_19509_Name = {
    Text = "Kalıcı Kart Aritmetika Değişimi"
  },
  State_19511_Desc = {
    Text = "Öldüğünde, elindeki kartlar Düş kartlarıyla değiştirilir."
  },
  State_19511_Name = {
    Text = "Ölüm, eldeki kartların Düş ile değiştirilmesini tetikler."
  },
  State_19513_Name = {
    Text = "Ölüm Düellosu Uygula"
  },
  State_19516_Name = {
    Text = "Geçici Kart Hesaplama Maliyeti Değişimi"
  },
  State_19517_Desc = {
    Text = "Kaybedilen her %2 Can için 1 Aliemus kazan"
  },
  State_19517_Name = {
    Text = "Hasar almak Aliemus kazandırır."
  },
  State_19519_Desc = {
    Text = "\"Darbe\"yi kullandıktan sonra tüm yığınları tüket. Her yığın, bu \"Darbe\"nin Hasarını %50 artırır, en fazla 5 yığına kadar. (Şu anda +[DescArg1]%)"
  },
  State_19519_Name = {Text = "Hücum"},
  State_19521_Desc = {
    Text = "Her yığın, bu Savaşta verilen tüm Hasarı 1 puan artırır ve dağıtılamaz."
  },
  State_19521_Name = {
    Text = "<PowerColourKeywords:GÜÇ>"
  },
  State_19522_Name = {
    Text = "Geçici Kart Hesaplama Maliyeti Değişimi"
  },
  State_19523_Name = {
    Text = "Kalıcı Kart Aritmetika Değişimi"
  },
  State_19524_Desc = {
    Text = "Sonraki turun başlangıcından önce, her saldırıya uğradığında saldırgana [Layer] pasif Hasar ver."
  },
  State_19524_Name = {Text = "Sayaç"},
  State_19525_Desc = {
    Text = "Tur başlamadan önce Uyanışçının Karakter Kalkanını kaldır."
  },
  State_19525_Name = {
    Text = "Tur başlamadan önce karakterin Karakter Kalkanını kaldır."
  },
  State_19527_Desc = {
    Text = "Her yığın, bu tur \"Yetenek\" Arithmetica Maliyetini +1 artırır, en fazla 3 yığın; oynanınca yığın sayısı 1'den büyükse yığın sayısı -1 olur."
  },
  State_19527_Name = {
    Text = "<SlowColour:Durgunluk>"
  },
  State_19528_Desc = {
    Text = "Güçlü etkileri olan bir kart."
  },
  State_19528_Name = {
    Text = "<SilverKeyColour:Çete>"
  },
  State_19529_Desc = {
    Text = "Her başka kart oynadığınızda, bu kartın bir sonraki oynanışı için Arithmetica Maliyetini 1 azalt; bu kartı oynadıktan sonra eline geri dön ve Arithmetica Maliyetini 1 artır, ardından tur sonunda at."
  },
  State_19529_Name = {
    Text = "<CardKeyWord:Fantazma>"
  },
  State_19530_Desc = {
    Text = "Rakipler, Saldırı ve tek hedefli yeteneklerde öncelikle bu birimi hedef almak zorundadır.\nEtkinleştiğinde: Kendisi: Mevcut Gizliliği kaldırır. Müttefikler: Onların Çekiciliğini kaldırır. Düşmanlar: Tüm düşman Gizliliğini dağıtır."
  },
  State_19530_Name = {
    Text = "<TauntColour:Alay>"
  },
  State_19532_Desc = {
    Text = "Verilen HASAR, tur sonuna kadar [DescArg1]% azalır, uygulanırken güçlendirmeleri geçersiz kılar."
  },
  State_19532_Name = {Text = "Zayıflık"},
  State_19533_Desc = {
    Text = "Verilen Hasar tur sonuna dek %50 azalır, uygulandığında Güçlendirme’yi geçersiz kılar."
  },
  State_19533_Name = {
    Text = "<WeaknessColour:Zayıflık>"
  },
  State_19534_Desc = {
    Text = "Alınan Aktif Hasar ve Kan Akıtma yığınları, bir sonraki tur başlayana dek +[DescArg1]% artar, Kale yığınlarıyla dengelenir."
  },
  State_19534_Name = {
    Text = "Savunmasız"
  },
  State_19535_Desc = {
    Text = "Rakipler, Saldırı ve tek hedefli yeteneklerde öncelikle bu birimi hedef almak zorundadır.\nEtkinleştiğinde: Kendisi: Mevcut Gizliliği kaldırır. Müttefikler: Onların Çekiciliğini kaldırır. Düşmanlar: Tüm düşman Gizliliğini dağıtır."
  },
  State_19535_Name = {Text = "Tahrik"},
  State_19536_Desc = {
    Text = "Tur sonunda 10 Aliemus kazan"
  },
  State_19536_Name = {
    Text = "Tur sonunda Aliemus Tetikleyicisi kazan"
  },
  State_19537_Desc = {
    Text = "Bu turun bitiminden önce verilen HASAR [DescArg1]% artar, Zayıflık tarafından dengelenir."
  },
  State_19537_Name = {Text = "Geliştir"},
  State_19538_Desc = {
    Text = "8. ve 9. turların başında 1 yığın kazan\nHer bir Şiddetli Dövüş yığını, Karakter Kalkanı ve can yenilemeyi %50 azaltır ve birikebilir Bariyer yığınlarının sayısını 1 düşürür\nŞiddetli Dövüş dağıtılamaz ve ölü Uyanışçıları da etkiler."
  },
  State_19538_Name = {
    Text = "Ölüm Dövüşü"
  },
  State_19540_Name = {
    Text = "Arithmetica Sınırı"
  },
  State_19541_Desc = {
    Text = "Tur sonuna kadar hiçbir eylem gerçekleştiremez."
  },
  State_19541_Name = {Text = "Baygın"},
  State_19544_Desc = {
    Text = "\"Darbe\"yi kullandıktan sonra tüm yığınları tüket. Tüketilen her yığın, bu \"Darbe\"nin Hasarını %50 artırır, en fazla 5 yığına kadar."
  },
  State_19544_Name = {
    Text = "<EnergyStorageColour:Yükleme>"
  },
  State_19545_Name = {
    Text = "Bu kart “Darbe” olarak kabul edilir"
  },
  State_19546_Desc = {
    Text = "Oynamadan önce kartın Arithmetica’sını değiştir"
  },
  State_19546_Name = {
    Text = "Oynanmadan önce Arithmetica Maliyetini değiştir"
  },
  State_19547_Desc = {
    Text = "Tur sonunda [Layer] pasif Hasar al. Kalıcı."
  },
  State_19547_Name = {Text = "Zehir"},
  State_19549_Desc = {
    Text = "Sonraki turun başlangıcına dek alınan aktif Saldırı Hasarı %50 azalır ve uygulanırken Savunmasız ile birbirini yok eder."
  },
  State_19549_Name = {
    Text = "<ReinforceColour:Hisar>"
  },
  State_19552_Desc = {
    Text = "Şu anda [Layer] Karakter Kalkanı’na sahipsin. Karakter Kalkanı Maksimum HP’yi aşmaz ve 1 tur sürer."
  },
  State_19552_Name = {Text = "Kalkan"},
  State_19553_Desc = {
    Text = "Çekim aşamasından sonra \"Son Vuran, En İyi Vurur\" kazan."
  },
  State_19553_Name = {
    Text = "Karşı Saldırı Tetikleyicisi"
  },
  State_19554_Name = {Text = "Boş Durum"},
  State_19555_Desc = {
    Text = "·Bu tur \"Yetenek\" Arithmetica Maliyeti +[Layer], en fazla 3 yığın.\n·\"Yetenek\" oynanınca yığın sayısı 1'den büyükse yığın sayısı -1 olur."
  },
  State_19555_Name = {Text = "Durgunluk"},
  State_19556_Desc = {
    Text = "Tur sonu, bu kartın Arithmetica Maliyeti -[Layer] olur."
  },
  State_19556_Name = {
    Text = "<PrepareKeywords:Hazırlan [Layer] >"
  },
  State_19557_Desc = {
    Text = "Sonraki turun başlangıcından önce, alınan aktif saldırı Hasarı [DescArg1]% azalır ve uygulanırken Savunmasız etkisini yok sayar."
  },
  State_19557_Name = {Text = "Hisar"},
  State_19558_Name = {
    Text = "Diriltme Deste Kartı Ekleme Tetikleyicisi"
  },
  State_19560_Desc = {
    Text = "Tur sonuna kadar Taşkınlık kullanılamaz."
  },
  State_19560_Name = {Text = "Mühürlü"},
  State_19561_Name = {
    Text = ", 3 kez kullanılabilir"
  },
  State_19990_Desc = {
    Text = "Sonraki turun başında [Layer] Aliemus kazan."
  },
  State_19990_Name = {
    Text = "Gecikmeli Aliemus"
  },
  State_19992_Desc = {
    Text = "Baygın olduğunda, hedef turun sonuna kadar hareket edemez. Baygınlık Hasarı almak Direnç kazandırır. Direnç etkinken, sonraki Baygınlık Hasarı ikiye katlanır ancak Baygınlık etkisi geçersiz kılınır."
  },
  State_19992_Name = {
    Text = "<ComaColour:Baygın>"
  },
  State_19995_Desc = {
    Text = "Tur sonunda, yığın sayısına eşit pasif Hasar ver. Kalıcı."
  },
  State_19995_Name = {
    Text = "<IntoxicationColour:Zehir>"
  },
  State_19996_Desc = {
    Text = "Bu turun bitiminden önce, verilen Hasar %25 artar, Zayıflık ile dengelenir."
  },
  State_19996_Name = {
    Text = "<StrengthenColour:Güçlendirme>"
  },
  State_19998_Desc = {
    Text = "Sonraki tur başlamadan önce, her saldırıya uğradığında, saldırgana eşit sayıda yığın pasif Hasar uygula."
  },
  State_19998_Name = {
    Text = "<RetaliateColour:Karşı Saldırı>"
  },
  State_20012_Desc = {
    Text = "Kalan her Arithmetica, bir sonraki turun başında 1 kart çekmeni sağlar; elde kalan her kart, bir sonraki turun başında sana 1 Arithmetica kazandırır."
  },
  State_20012_Name = {
    Text = "Kadim Bilgelerin Kayıp Bölümü"
  },
  State_20012_WeaponDesc = {
    Text = "Kalan her Arithmetica, bir sonraki turun başında 1 kart çekmeni sağlar; elde kalan her kart, bir sonraki turun başında sana 1 Arithmetica kazandırır."
  },
  State_20013_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Diyar Ustalığı> 100 artar. Her tur oynanan ilk kartı eline Dönüş ettir. Ultra Tur başında El Sınırını 5 artır ve elini Kopyala."
  },
  State_20013_Name = {
    Text = "Durum@Krono Sarkaç Yansıma"
  },
  State_20014_Name = {
    Text = "Krono Sarkaç \"Akış\""
  },
  State_20016_Name = {
    Text = "Yadigâr Gizemli Eldivenler"
  },
  State_20017_Desc = {
    Text = "Bir sonraki Sıçrama Etkisi kesinlikle tetiklenecek."
  },
  State_20017_Name = {Text = "Sıçrama"},
  State_20021_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Diyar Ustalığı> 100 artar. Her tur oynanan ilk kartı eline Dönüş ettir. Ultra Tur başında El Sınırını 5 artır ve elini Kopyala."
  },
  State_20021_Name = {
    Text = "Durum@Krono Sarkaç Yansıma"
  },
  State_20023_Desc = {
    Text = "Savaşın başında, iki Aliemus Şarj kartını desteye karıştır."
  },
  State_20023_Name = {
    Text = "Kaos Dikicisi"
  },
  State_20023_WeaponDesc = {
    Text = "Savaşın başında, iki Aliemus Şarj kartını desteye karıştır."
  },
  State_20024_Desc = {
    Text = "Exaslt serbest bırakıldığında [Arg1] Zehir uygulayabilen 1 \"Toksik Enfüzyon\" kazan. Tur sonunda, eldeki her 3 \"Toksik Enfüzyon\" kartı için, Zehri tetikleyen 1 \"Toksik Nöbet\" sentezle."
  },
  State_20024_Name = {
    Text = "Durum@Kalıntı Mutasyon Dili"
  },
  State_20026_Desc = {
    Text = "Kart Atılmış Kart Destesine girmez, bunun yerine elinde kalır. Sonraki etkileri tetikler."
  },
  State_20026_Name = {
    Text = "<RetainIconKeywords:Sakla>"
  },
  State_20026_WeaponDesc = {
    Text = "Oynandıktan sonra, kart Atılmış Kart Destesi’ne gitmez ve bu Savaşta tekrar kullanılamaz."
  },
  State_20028_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Diyar Ustalığı> 100 artar. Oynanan her kart +10 Embriyo Füzyonu verir. Can %25'in altındayken bu değer 20'ye yükselir. Tur başına en fazla 10 kez tetiklenir."
  },
  State_20028_Name = {
    Text = "Durum@Krono Sarkaç Yozlaşması"
  },
  State_20029_Desc = {
    Text = "Exaslt serbest bırakıldığında [Arg1] Zehir uygulayabilen 1 \"Toksik Enfüzyon\" kazan. Tur sonunda, eldeki her 3 \"Toksik Enfüzyon\" kartı için, Zehri tetikleyen 1 \"Toksik Nöbet\" sentezle."
  },
  State_20029_Name = {
    Text = "Durum@Kalıntı Mutasyon Dili"
  },
  State_20035_Name = {
    Text = "Durum@Krono Sarkaç Uykuda"
  },
  State_20038_Name = {
    Text = "Kaos Ortak Yaşarı"
  },
  State_20038_WeaponDesc = {
    Text = "Takım Kaos ve diğer sınıflardan oluştuğunda, tüm Uyananlar turlarının başında 20 Aliemus elde eder."
  },
  State_20039_Desc = {
    Text = "Atma aşamasında elde tutulursa, Tüketme. Yeniden ortaya çıkmaz."
  },
  State_20039_Name = {
    Text = "<NothingnessIconKeywords:Gelip Geçici>"
  },
  State_20039_WeaponDesc = {
    Text = "Oynandıktan sonra, kart Atılmış Kart Destesi’ne gitmez ve bu Savaşta tekrar kullanılamaz."
  },
  State_20040_Name = {
    Text = "Durum@Krono Sarkaç Uyanış Sayacı"
  },
  State_20041_Desc = {
    Text = "Tur başında, 1 Arithmetica kazan ve her düşman için 1 kart çek. Bir düşman Aktif Hasar ile öldürüldüğünde, fazla Hasarın iki katını diğer düşmanlara Kan Akıtma olarak uygula."
  },
  State_20041_Name = {
    Text = "Mutasyona Uğramış Güruh Şarkısı"
  },
  State_20042_Desc = {
    Text = "Zayıflatma etkisi altındaki düşmanlara %25 daha fazla Hasar ver ve onları öldürdüğünde 20 Aliemus kazan."
  },
  State_20044_Desc = {
    Text = "Semptom: Zayıflık etkisini %10 artırır. Her 3 turda bir tüm düşmanlara 1 yığın Semptom: Zayıflık ekler."
  },
  State_20045_Desc = {
    Text = "Sonraki turun başında destesinden istediğin 3 kartı seç ve eline ekle."
  },
  State_20045_Name = {
    Text = "Krono Sarkaç Dansı"
  },
  State_20306_Name = {
    Text = "Yadigâr Gizemli Eldivenler"
  },
  State_20419_Desc = {
    Text = "Her isabet için [Arg1] birikim Zehir uygula. Bu savaş sırasında 25 kez tetiklenirse, derhal tüm düşmanlara Zehir uygula."
  },
  State_20425_Desc = {
    Text = "Tur başında [Layer] Geçici <PowerIconKeywords:Güç> ve Karakter Kalkanı kazan."
  },
  State_20425_Name = {
    Text = "Kana Susamış Obur"
  },
  State_20600_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Her turda ilk [StateArg2] \"Yetenek\" kartının Arithmetica Maliyeti - [StateArg1] azalır."
  },
  State_20600_Name = {Text = "Vahiy"},
  State_20601_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Darbe\" Hasarı +%[StateArg1]. Alınan her Saldırı için [StateArg2] yığın <EnergyStorageKeywords:Yük> kazan."
  },
  State_20601_Name = {Text = "Oburluk"},
  State_20602_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Vuruş\" bir hedef seçebilir ve [StateArg1] yığın <PVPSlowKeywords:Durgunluk> uygular. Bu etki, her turda ilk hedefte tetiklendiğinde iki katına çıkar."
  },
  State_20602_Name = {
    Text = "Unutuşun Eli"
  },
  State_20603_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Yüceltme\"den sonra kendine <Energy:[Energy:StateArg1]> Aliemus ver."
  },
  State_20603_Name = {
    Text = "Sapkın Yutma"
  },
  State_20604_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Vuruş\", kendine <Heal:[Heal:StateArg1]> HP iyileştirir."
  },
  State_20604_Name = {Text = "Emme"},
  State_20605_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında, kendini <ComaKeywords:Baygın>. \"Taşkınlık\"tan önce müttefiklerin tüm zayıflatmalarını dağıt."
  },
  State_20605_Name = {
    Text = "Asilin Asası"
  },
  State_20606_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Vuruş\", Kuşanan’a <Energy:[Energy:StateArg1]> Aliemus kazandırır."
  },
  State_20606_Name = {Text = "Vahşet"},
  State_20607_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: «Vuruş» ile <HPAndShieldMax:can ve kalkanı en yüksek> düşmana saldırır ve ek olarak hasarın [StateArg1]%'i kadar <PVPBleedingKeywords:kanama> uygular."
  },
  State_20607_Name = {
    Text = "Kesik ve Yara"
  },
  State_20608_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Bir \"Beceri\" kullandıktan sonra ve tur sonunda, <Energy:[Energy:StateArg1]> Aliemus kazan."
  },
  State_20608_Name = {Text = "Fısıltı"},
  State_20609_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: HP kaybederek kazanılan Aliemus iki katına çıkar."
  },
  State_20609_Name = {
    Text = "Deniz Rüyası"
  },
  State_20610_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Vuruş\" Hasar Artışı [DescArg1]%, \"Taşkınlık\" sonrası kendi <PVPPowerIconKeywords:Güç> + [StateArg2] ve \"Vuruş\" Hasarı ek olarak [StateArg3]% daha artar, maksimum %100."
  },
  State_20610_Name = {
    Text = "Göksel Canavar"
  },
  State_20611_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Yetenek\" ve turun sonunda, en fazla kaybedilen HP’ye sahip müttefiğe <Heal:[Heal:StateArg1]> HP iyileştirir."
  },
  State_20611_Name = {Text = "Umut"},
  State_20612_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda, en düşük Aliemus'a sahip müttefiğe <Energy:[Energy:StateArg1]> Aliemus ver ve en çok kaybedilen HP'ye sahip müttefiği <Heal:[Heal:StateArg2]> HP iyileştir."
  },
  State_20612_Name = {
    Text = "Merhametli Beslenme"
  },
  State_20613_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda, diğer müttefiklere <Block:[Block:StateArg1]> Kalkan ver."
  },
  State_20613_Name = {
    Text = "Var Olmayan Diyar"
  },
  State_20614_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda, [StateArg1] Geçici <PVPRetaliateIconKeywords:Sayaç> elde et."
  },
  State_20614_Name = {
    Text = "Çekirdek Erimesi"
  },
  State_20615_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Her turdaki ilk \"Darbe\" fazladan [StateArg1] Hasar verir ve aynı miktarda <PVPMethysisKeywords:Zehir> uygular."
  },
  State_20615_Name = {
    Text = "Lanetli Bağ"
  },
  State_20616_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda <Energy:[Energy:StateArg1]> Aliemus kazan."
  },
  State_20616_Name = {
    Text = "Akut'ta Bahar"
  },
  State_20617_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda, <Block:[Block:StateArg1]> Karakter Kalkanı kazan."
  },
  State_20617_Name = {Text = "Sürgün"},
  State_20618_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Yüceltme\"den önce, her iki taraf da elindeki tüm kartları atar, ardından atılan kart sayısı +1 kadar kart çeker."
  },
  State_20618_Name = {
    Text = "Mutlu Sihir Gösterisi"
  },
  State_20619_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında <Energy:[Energy:StateArg1]> Aliemus kazan. Dost bir Uyandırıcı \"Taşkınlık\" serbest bıraktıktan sonra, <DelayKeywords:Gecikme>: <Energy:[Energy:StateArg2]> Aliemus kazan."
  },
  State_20619_Name = {
    Text = "Tanrı Kralın İlahisi"
  },
  State_20620_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: El Limiti + [StateArg2]. Tur sonunda, elden rastgele [StateArg1] \"Beceri\" kopyası kazan."
  },
  State_20620_Name = {
    Text = "Kavuşma Anı"
  },
  State_20621_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Taşkınlık\"tan önce, kendine <StrengthenKeywords:Enhance> ve <ReinforceKeywords:Fortress> uygula."
  },
  State_20621_Name = {
    Text = "Acıyı Aşmak"
  },
  State_20622_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonu kendisi <Energy:[Energy:StateArg1]> Aliemus kazanır, kalan tüm Arithmetica'yı harcar, her 1 Arithmetica harcandığında kazanılan Aliemus [StateArg3] artar."
  },
  State_20622_Name = {
    Text = "Örtülü Doğuş"
  },
  State_20623_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Taşkınlık\"tan sonra [StateArg1] kart çek."
  },
  State_20623_Name = {
    Text = "Yüzeye Çık"
  },
  State_20624_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Yüceltme\"den sonra [StateArg1] kart çek ve [StateArg2] kopyasını ele yerleştir."
  },
  State_20624_Name = {
    Text = "Şans Saati"
  },
  State_20625_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Yüceltme\"den sonra, <DelayKeywords:Gecikme>: Tüm müttefik birimlere <Heal:[Heal:StateArg1]> Can yenile."
  },
  State_20625_Name = {
    Text = "Obur'un Masalı"
  },
  State_20626_Desc = {
    Text = "<ReinforceKeywords:Kader Çarkı>: \"Darbe\" Hasarı +[StateArg1]% ve kendine <PVPWeaponKeywords:Kale> uygula."
  },
  State_20626_Name = {
    Text = "Boyun Eğmeyen İrade"
  },
  State_20627_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda, tüm müttefiklere <Heal:[Heal:StateArg1]> Can yenile."
  },
  State_20627_Name = {Text = "Kutsama"},
  State_20628_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Taşkınlık\"tan sonra, diğer müttefiklere <Energy:[Energy:StateArg1]> Aliemus ver. Eğer bu, bir müttefiğe Taşkınlığını etkinleştirmesi için gerekenden fazla Aliemus verirse, Kuşanan fazla miktarın yarısını kazanır."
  },
  State_20628_Name = {
    Text = "Görevin Ağırlığı"
  },
  State_20629_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Yüceltme\"nin Hasar, İyileştirme ve Karakter Kalkanı etkileri [StateArg1]% artar."
  },
  State_20629_Name = {
    Text = "Gül Adına"
  },
  State_20630_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda, <Block:[Block:StateArg1]> Kalkan ve <Energy:[Energy:StateArg2]> Aliemus kazan."
  },
  State_20630_Name = {
    Text = "Kışın Ağıtı"
  },
  State_20631_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Vuruş\", hedefe <PVPVulnerabilityIconKeywords:Savunmasız> uygular. Tur sonunda, [StateArg1] <EnergyStorageKeywords:Şarj> kazan."
  },
  State_20631_Name = {
    Text = "Kritik Nokta"
  },
  State_20632_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: El Limiti +[StateArg1]."
  },
  State_20632_Name = {
    Text = "Hafıza Sarmalı"
  },
  State_20633_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanan her tur ilk kez aktif olarak saldırıya uğradığında, saldırgana [StateArg1] Hasar ver, <PVPEntanglementKeywords:Sarmalamak>."
  },
  State_20633_Name = {
    Text = "Solgun Torun"
  },
  State_20634_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Vuruş\", \"Yetenek\" ve \"Yüceltme\"nin verdiği Hasar, İyileştirme ve Kalkan [DescArg1]% artar. <PVPGrowthKeywords:Gelişim>: [StateArg2]%."
  },
  State_20634_Name = {
    Text = "Güneşin Düşüşü"
  },
  State_20635_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Taşkınlık\"tan önce tüm müttefiklere <StrengthenKeywords:Güçlendirme> bahşet."
  },
  State_20635_Name = {
    Text = "Dindarın Gücü"
  },
  State_20636_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda bir <PVPDerivativeCardKeywords_2:\"Düş\"> kazan. Elinde her iki <PVPDerivativeCardKeywords_2:\"Düş\"> için, onları bir <PVPDerivativeCardKeywords_12:\"Küçük Dilek\">e birleştir."
  },
  State_20636_Name = {Text = "Eskimiş"},
  State_20637_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Turunun sonunda, [StateArg1] adet <PVPDerivativeCardKeywords_11:\"Unequal Exchange\"> kartını Çekme Destenin içine Karıştır."
  },
  State_20637_Name = {
    Text = "Veri Hayattır"
  },
  State_20639_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda, ekipman sahibi <HPAndShieldMax:can ve kalkanı en yüksek> düşmana [StateArg1] hasar verir ve <PVPMethysisKeywords:zehirleme> uygular."
  },
  State_20639_Name = {
    Text = "Çürümenin Armağanı"
  },
  State_20640_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında ve tur başında, tüm düşmanlara <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:Kan Akıtma> Hasarı ver. Hedefin elindeki her kart için, <PVPBleedingKeywords:Kan Akıtma> Hasarını +[StateArg2] artır."
  },
  State_20640_Name = {
    Text = "Kanlı Ziyafet"
  },
  State_20641_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Ölüm anında, diğer müttefiklere [StateArg1] yığın <PVPProtectiveKeywords:Bariyer> verir."
  },
  State_20641_Name = {
    Text = "Ölümün Analizi"
  },
  State_20642_Desc = {
    Text = "<PVPHoldingKeywords:Elde>: Ne zaman bir kart oynarsan, bu kart, Arithmetica Maliyeti -1 olan rastgele bir \"Kader Çarkı\" na dönüşür."
  },
  State_20642_Name = {
    Text = "Bir Ruhun Doğuşu"
  },
  State_20643_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Taşkınlık\" sonrası [StateArg1] Arithmetica kazanır, <DelayKeywords:Gecikme>: [StateArg2] Arithmetica düşer."
  },
  State_20643_Name = {
    Text = "Hafıza Sendromu"
  },
  State_20644_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında, kendine [StateArg2] Hasar ver, <PVPEntanglementKeywords:Sarmalamak>. Her bir Düşkün müttefik için, <StrongEffectKeywords:Güçlendirme> +[StateArg1]."
  },
  State_20644_Name = {
    Text = "En Değerli Koleksiyon"
  },
  State_20645_Name = {
    Text = "Maceracının Çantası"
  },
  State_20646_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Darbe\" Hasarı [StateArg1]% artar ve \"Yüceltme\" kendini <Heal:[Heal:StateArg2]> HP iyileştirir."
  },
  State_20646_Name = {
    Text = "Yutulmuş Ninni"
  },
  State_20647_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Exalt\"tan sonra, eline [StateArg1] adet <PVPDerivativeCardKeywords_11:\"Unequal Exchange\"> yerleştir."
  },
  State_20647_Name = {
    Text = "Sağanağın Ortasında"
  },
  State_20648_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur başında, olumlu bir <PVPWonderfulEffectKeywords:Harika Etki> kazanır. Düşman her turda ilk kez \"Posse\" kullandığında, eline [StateArg1] adet \"Muhteşem Manzara\" kartı eklenir."
  },
  State_20648_Name = {
    Text = "Sessiz Şölen"
  },
  State_20649_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Yüceltme\"den sonra, önceki turda oynanan son \"Beceri\"yi eline geri al; onun Arithmetica Maliyeti -1 olur. Bu tür bir Etki birden fazla kez tetiklenirse, daha da geriye iz sürer."
  },
  State_20649_Name = {
    Text = "Zamanı Geri Sarma"
  },
  State_20650_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında, kendine <ComaKeywords:Baygınlık> uygula. \"Taşkınlık\"tan önce tüm düşmanlar üzerindeki tüm güçlendirmeleri dağıt."
  },
  State_20650_Name = {Text = "Sayıklama"},
  State_20651_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda [StateArg1] kart çek."
  },
  State_20651_Name = {
    Text = "Açgözlülük"
  },
  State_20652_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Taşkınlık\"tan sonra, tüm düşmanlara [StateArg1] Hasar ver, <DisarmKeywords:Felç>."
  },
  State_20652_Name = {
    Text = "Cezalandırma"
  },
  State_20653_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Darbe\" bir hedef seçebilir ve o hedeften <Energy:[Energy:StateArg1]> Aliemus eksiltebilir."
  },
  State_20653_Name = {
    Text = "Arzunun Sürüklenişi"
  },
  State_20654_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur başında, kendine <PVPSeriousInjuryKeywords:Ağır Yıkım> uygula ve <Damage:[Damage:StateArg1]> kat <PVPCorrosionKeywords:Günah İşareti> kazan. Tur sonunda, kendini <ReinforceKeywords:Güçlendirilmiş> yap."
  },
  State_20654_Name = {
    Text = "Kraliçenin Fermanı"
  },
  State_20655_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>:\"Darbe\" Hasarı +[StateArg1]%, \"Darbe\" hedef seçebilir."
  },
  State_20655_Name = {Text = "Lütuf"},
  State_20656_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Beceri\"den gelen Hasar, İyileştirme ve Kalkan etkileri [StateArg1]% artar. \"Beceri\" kullandıktan sonra <PVPProtectiveKeywords:Engel> yoksa, 1 yük kazan."
  },
  State_20656_Name = {Text = "Son Dize"},
  State_20657_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Her tur, rakip [StateArg1]. \"Yetenek\" i oynadığında, Arithmetica Maliyeti [StateArg2] azaltılmış bir kopyasını Elde’ye koy."
  },
  State_20657_Name = {Text = "İdrak"},
  State_20658_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Vuruş\", isabet ettirdiği her hedef için [StateArg1] Arithmetica üretir."
  },
  State_20658_Name = {
    Text = "Tutsağın Türküsü"
  },
  State_20659_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Ölüm anında, bir sonraki turun başında <Heal:[Heal:StateArg1]> HP ve <Block:[Block:StateArg2]> Kalkan ile <PVPResurrectionKeywords:Canlanma> ve bu \"Kader Çarkı\"nı imha et."
  },
  State_20659_Name = {Text = "Canlılık"},
  State_20660_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Taşkınlık\"tan sonra, tüm müttefikler <Block:[Block:StateArg1]> Karakter Kalkanı kazanır."
  },
  State_20660_Name = {Text = "Ruh Kalesi"},
  State_20661_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Yüceltme\"den sonra, tüm düşmanlara <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:Kan Akıtma> Hasarı ver."
  },
  State_20661_Name = {
    Text = "Terk Edilmiş Yol"
  },
  State_20662_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda, her bir <PVPCapKeywords:hesaplama kapasitesi üst sınırı> puanı başına <HPAndShieldMin:can ve kalkanı en düşük> düşmana [StateArg1] <PVPBleedingKeywords:kanama> verir ve toplamda <Damage:[Damage:DescArg1]> <PVPBleedingKeywords:kanama> hasarı verir."
  },
  State_20662_Name = {
    Text = "Geceye Bürünmüş"
  },
  State_20663_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Taşkınlık\"tan önce, kendi zayıflatmalarını dağıt ve [StateArg1] yığın <EnergyStorageKeywords:Charge> kazan."
  },
  State_20663_Name = {
    Text = "Çözülen Zincirler"
  },
  State_20664_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Beceri\", kendine <ReinforceKeywords:Kale> uygular."
  },
  State_20664_Name = {
    Text = "Bir Şövalyenin Yemini"
  },
  State_20665_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Giderilecek hiçbir zayıflatma yoksa, <Heal:[Heal:StateArg1]> Can yenile. Tur sonunda, <DelayKeywords:Gecikme>: Kendi zayıflatmalarını gider."
  },
  State_20665_Name = {
    Text = "Kader Yelkeni"
  },
  State_20666_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: «Çılgınlık Patlaması» sonrasında <HPAndShieldMin:can ve kalkanı en düşük> dost tarafa [StateArg1] kat <PVPProtectiveKeywords:bariyer> kazandırır."
  },
  State_20666_Name = {
    Text = "Canım Dostuma"
  },
  State_20667_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kullanan kişinin her turda oynadığı ilk \"Yetenek\" +[StateArg1]% Hasar verir."
  },
  State_20667_Name = {
    Text = "Devin Kılıcı"
  },
  State_20668_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Uyananımız öldüğünde, tüm düşman hedeflere <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:Kan Akıtma> Hasarı ver. Kuşanan öldüğünde, ek olarak <Damage:[Damage:StateArg2]> <PVPBleedingKeywords:Kan Akıtma> Hasarı ver."
  },
  State_20668_Name = {
    Text = "Bayan Mercan'ın Ölümü"
  },
  State_20669_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında ve tur başında, eğer hiçbir <PVPProtectiveKeywords:Bariyer> yoksa, [StateArg1] yığın <PVPProtectiveKeywords:Bariyer> kazan; aksi halde, eldeki en yüksek maliyetli 1 \"Beceri\" kartının bedeli 1 azalır."
  },
  State_20669_Name = {
    Text = "Kutsal Söz Tabletleri"
  },
  State_20670_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Darbe\", <PVPSeriousInjuryKeywords:Ciddi Yaralanma> uygular, Hasarı [StateArg1]% artırır, ancak büyücü, verilen Hasarın yarısını Can olarak kaybeder."
  },
  State_20670_Name = {
    Text = "Keder Yüzgeci"
  },
  State_20671_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Yüceltme\"den sonra kendine <Heal:[Heal:StateArg1]> HP yenile."
  },
  State_20671_Name = {
    Text = "Ölümsüz Yükseliş"
  },
  State_20672_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda, eldeki Arithmetica Maliyeti en yüksek kartın Arithmetica Maliyetini [StateArg1] azalt. <PrepareKeywords:Hazırlan>."
  },
  State_20672_Name = {
    Text = "Yüksek Odaklanma"
  },
  State_20673_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Yüceltme\"den sonra kendine <Block:[Block:StateArg1]> Karakter Kalkanı, diğer müttefiklere <Energy:[Energy:StateArg2]> Aliemus ver."
  },
  State_20673_Name = {
    Text = "Hesaplanamaz Etken"
  },
  State_20696_Name = {
    Text = "Durum@Dev Korkusu"
  },
  State_20723_Desc = {
    Text = "\"Darbe\"nin Hasarı [Layer] artar."
  },
  State_20723_Name = {
    Text = "Saldırı Kartlarının Sabit Hasarı arttırılır"
  },
  State_20724_Desc = {
    Text = "\"Saldırı\"nın Hasarı [Layer] azaltılır."
  },
  State_20724_Name = {
    Text = "Darbe Kartlarının Sabit Hasarı azaltıldı"
  },
  State_20749_Desc = {
    Text = "Evrensel İz Sayaç."
  },
  State_20758_Desc = {
    Text = "Sonraki turun başında [Layer] Kart çek."
  },
  State_20758_Name = {
    Text = "Gecikmeli Kart Çekme"
  },
  State_20766_Desc = {
    Text = "Belirli etkiler için temel Saldırı mantığına bakın."
  },
  State_20802_Desc = {
    Text = "Bu kart oynanamaz."
  },
  State_20802_Name = {Text = "Oynanamaz"},
  State_20803_Desc = {
    Text = "Bu kart Arithmetica Maliyeti'ni 1 azaltır. Başka bir kart kullandıktan sonra bu kart, rastgele bir Kader Çarkı kartına dönüşür."
  },
  State_20803_Name = {
    Text = "<CardKeyWord:Bir Ruhun Doğuşu>"
  },
  State_20805_Desc = {
    Text = "Kart Atılmış Kart Destesine girmez, bunun yerine elinde kalır."
  },
  State_20805_Name = {
    Text = "<RetainIconKeywords:Sakla>"
  },
  State_20806_Desc = {
    Text = "Oynandıktan sonra, bu kart Atılmış Kart Destesi'ne gitmek yerine desteden kaldırılır."
  },
  State_20806_Name = {
    Text = "<DepleteIconKeywords:Tüketme>"
  },
  State_20820_Desc = {
    Text = "Bir sonraki turun başında [Layer] HP ve [Layer] Kalkan ile Canlanma."
  },
  State_20820_Name = {
    Text = "Gecikmeli Diriliş"
  },
  State_20851_Name = {
    Text = "Kart Bahşet"
  },
  State_20981_Desc = {
    Text = "\"\"Kızıl\"\" Uyandırıldı ve verdiği Hasar büyük ölçüde arttı."
  },
  State_20981_Name = {
    Text = "Uvhash Uyanışı!"
  },
  State_20981_WeaponDesc = {
    Text = "Bir sonraki turun başında, önceki turda kaybedilen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_20982_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_20982_Name = {
    Text = "Uyanmamış"
  },
  State_20988_Desc = {
    Text = "+80 Aliemus ile başla. Her tur 20 Aliemus kazan."
  },
  State_20988_Name = {
    Text = "Nergis: İlk Karşılaşma"
  },
  State_20989_Desc = {
    Text = "+80 Aliemus ile başla. Her tur 2 Arithmetica ve 20 Aliemus kazan."
  },
  State_20989_Name = {
    Text = "Tulu: İlk Karşılaşma"
  },
  State_21306_Desc = {
    Text = "Her turda komboyu sıfırla."
  },
  State_21306_Name = {
    Text = "Kombo Sıfırlama"
  },
  State_21307_Desc = {
    Text = "Her yığın, Saldırı sayısını 1 artırır. Alınan her Hasar örneğinde 1 yığın kaybedilir (en az 1 yığın kalacak şekilde) ve tur sonunda tüm yığınlar kaybedilir."
  },
  State_21307_Name = {Text = "Kombo"},
  State_21342_Desc = {
    Text = "Sonraki turun başında [Layer] HP kazan"
  },
  State_21342_Name = {
    Text = "Gecikmeli İyileştirme"
  },
  State_21345_Desc = {
    Text = "İlahi İniş Ritüeli başlamadan önce, ölüm sizi diriltir, zayıflatmaları kaldırır, Hasar’a bağışıklık verir ve HP’nizi %30 yeniler. Ayin başladıktan sonra ise ölüm sizi tamamen diriltir, zayıflatmaları ve Ritüel Saplantısı’nı kaldırır ve iki Akraba çağırır."
  },
  State_21345_Name = {
    Text = "Ritüel Saplantısı"
  },
  State_21358_Desc = {
    Text = "Bu oyuncunun el boyutu sınırsızdır."
  },
  State_21381_Name = {
    Text = "Mühür Kullanım Sayısı"
  },
  State_21385_Desc = {
    Text = "Her 1 HP kaybedildiğinde 1 yığın azalır. Yığın sayısı 0'a indiğinde, Niyet yüksek Hasarlı bir Yücelişe kayar ve Taşlaştırma etkisini kaldırır."
  },
  State_21385_Name = {
    Text = "Kan Çılgınlığı"
  },
  State_21450_Desc = {
    Text = "Bir sonraki turun başında, üzerindeki tüm zayıflatmaları kaldır."
  },
  State_21450_Name = {
    Text = "Gecikmeli Arındırma"
  },
  State_21488_Desc = {
    Text = "Belirli etkiler için temel Saldırı mantığına bakın."
  },
  State_21492_Desc = {
    Text = "Kritik Vuruşta Hasar %50 artar."
  },
  State_21492_Name = {
    Text = "<CardKeyWord:Kritik Vuruş>"
  },
  State_21546_Desc = {
    Text = "Sonraki turun başında [Layer] Karakter Kalkanı kazan."
  },
  State_21546_Name = {
    Text = "Gecikmeli Kalkan"
  },
  State_21547_Desc = {
    Text = "Tur başında, Karakter Kalkanı'nın yarısını sakla."
  },
  State_21547_Name = {Text = "Azimli"},
  State_21548_Desc = {
    Text = "Sonraki turun başında Güçlendirme kazan."
  },
  State_21548_Name = {
    Text = "Gecikmeli Güçlendirme"
  },
  State_21580_Desc = {
    Text = "Kafatası Avcısı hareketlerini izliyor. Her çekilen kart için, Kafatası Avcısı [StateArg1] Geçici GÜÇ kazanır."
  },
  State_21580_Name = {Text = "İz Sürme"},
  State_21587_Name = {
    Text = "Bu tur, yeni rastgele bir Uyanan bulundu."
  },
  State_21590_Name = {
    Text = "Yeni bir Uyanan bulma deneme sayısı"
  },
  State_21601_Name = {
    Text = "Yeni Uyandırıcı Bulundu"
  },
  State_21616_Desc = {
    Text = "Yüceltme’yi kullandıktan sonra, tüm Uyandırma kartlarını bir tur boyunca mühürle."
  },
  State_21616_Name = {
    Text = "Yol Yürüyenin Kalıntıları"
  },
  State_21671_Name = {
    Text = "Alan Hasarı Ver"
  },
  State_21688_Name = {
    Text = ", 1 kez kullanılabilir"
  },
  State_21689_Name = {
    Text = ", 2 kez kullanılabilir"
  },
  State_21720_Desc = {
    Text = "Hedefin arkasındaki Uyandırıcıyı da etkiler. Eğer yoksa yalnızca hedef etkilenir."
  },
  State_21720_Name = {
    Text = "<CardKeyWord:Del>"
  },
  State_21726_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kullanıcı her tur ilk kez bir \"Yetenek\" oynadığında, ondan bir kopyayı Arithmetica Maliyeti - [StateArg1] olacak şekilde Çekme Desteğine kar.\n"
  },
  State_21726_Name = {Text = "Fouetté"},
  State_21744_Name = {
    Text = "Yeni bir Uyanan bulma deneme sayısı"
  },
  State_21745_Name = {
    Text = "Yeni Uyandırıcı Bulundu"
  },
  State_21746_Name = {
    Text = "Bu tur, yeni rastgele bir Uyanan bulundu."
  },
  State_21747_Desc = {
    Text = "[Layer] Uyanan Avlanıyor ve Avlanan her Uyanan’ın oynadığı her kart için, \"Çılgın Kafatası Avcısı\" 1 Av İşareti biriktirir."
  },
  State_21747_Name = {Text = "Av Töreni"},
  State_21751_Desc = {
    Text = "Av İşareti taşıyan kartların yarısını çek ([DescArg1]) ve “Çılgın Kafatası Avcısı” üzerindeki Av İşareti sayısını 1 artır."
  },
  State_21751_Name = {
    Text = "<CardKeyWord:Avlanan>"
  },
  State_21754_Desc = {
    Text = "Öldüğünde, \"Çılgın Kafatası Avcısı\"nın tüm Geçici GÜÇ’ünü dağıt ve \"Av İşareti\" yığınlarını yarıya indir."
  },
  State_21754_Name = {
    Text = "Geçici Kurtuluş"
  },
  State_21765_Desc = {
    Text = "\"Kader Çarkı\"nı bir Uyanmışa kuşanarak etkinleştir.\nZaten bir tane kuşanılıysa, eski Çark imha edilir.\nUyanmış ölürse, Çark imha edilir.\nÖlü bir Uyanmışa kuşanmak, onu imha eder, 1 Düş verir ve maliyeti iade eder."
  },
  State_21765_Name = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>"
  },
  State_21785_Name = {
    Text = "Savaş Narası"
  },
  State_21787_Name = {
    Text = "Savaş Naraları Ekle"
  },
  State_21826_Name = {
    Text = "\"Çocuk Kral konuşmasına başlar\""
  },
  State_21829_Name = {
    Text = "Ölüm Çınlaması Etkisi"
  },
  State_21838_Name = {
    Text = "Açılış Tanıtımı"
  },
  State_21843_Name = {
    Text = "Başlangıçta Durum Uygula"
  },
  State_21895_Name = {
    Text = "Açılış Bildirisi"
  },
  State_21905_Desc = {
    Text = "\"Saldırı\" 2 Arithmetica kazanır ve 1 rastgele kart atar; \"Savunma\" 2 kart çeker ve 1 Arithmetica kaybeder."
  },
  State_21928_Name = {
    Text = "Soruşturma Devam Ediyor"
  },
  State_22054_Name = {
    Text = "Açılış Bildirisi"
  },
  State_22055_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_22055_Name = {
    Text = "Uyanmamış"
  },
  State_22067_Desc = {
    Text = "Tur sonunda, 1 Dokunaç [Layer] kez Dokunaç Saldırısı yapar."
  },
  State_22067_Name = {
    Text = "Dokunaç Toplanması"
  },
  State_22074_Desc = {
    Text = "7. tura kadar hayatta kal; Niyet Bakış’a dönüşür, 8. tur ve sonrasında Niyet Saygısızlık’a dönüşür."
  },
  State_22134_Desc = {
    Text = "Hedefin Kalkanına, Canına ve Bariyerine aynı anda Hasar ver."
  },
  State_22134_Name = {
    Text = "<CardKeyWord:Delici Hasar>"
  },
  State_22157_Desc = {
    Text = "HP %50’nin ([StateArg1]) altına indiğinde, eşit HP ile \"Akıntı\" ve \"Gelgit\" olarak ikiye bölünür."
  },
  State_22157_Name = {Text = "Bölünme"},
  State_22204_Desc = {
    Text = "Tur başında, [Layer]% Geçici Kritik Oranı ve Geçici Kritik Hasar kazan."
  },
  State_22204_Name = {
    Text = "Uzak Melodi"
  },
  State_22204_WeaponDesc = {
    Text = "bir sonraki turun başlangıcına kadar HP kaybetmeden, Kritik Oranı +[StateArg1]%."
  },
  State_22210_Desc = {
    Text = "Arithmetica Maliyeti +100, Darbe kullanılamaz ve Aliemus kazanılamaz."
  },
  State_22210_Name = {
    Text = "Süper Durgunluk"
  },
  State_22238_Name = {
    Text = "Oyuncu Ölüm Düellosu"
  },
  State_22239_Name = {
    Text = "Oyuncu Ölüm Düellosu'nu etkinleştir"
  },
  State_22249_Desc = {
    Text = "Sonraki turun başında, [Layer] daha az kart çek."
  },
  State_22249_Name = {
    Text = "Eşitsiz Takas"
  },
  State_22300_Desc = {
    Text = "Bu \"Saldırı\" oynanamaz."
  },
  State_22300_Name = {
    Text = "Silahsız bırakma, Darbe kartlarının oynanmasını engeller."
  },
  State_22303_Desc = {
    Text = "Her Hasar aldığında, Elde bulunan rastgele bir kart Geçici \"Durgunluk\" durumuna girer. Karakter Kalkanı kırıldıktan sonra \"Ayaz Kalkanı\" durumu kaldırılır."
  },
  State_22303_Name = {
    Text = "Ayaz Kalkanı"
  },
  State_22324_Desc = {
    Text = "Her yığın için, bu tur 1 ek Saldırı kazan."
  },
  State_22324_Name = {
    Text = "Azgın Dalgalar Yankısı"
  },
  State_22325_Desc = {
    Text = "Her saldırıya uğradığında [StateArg1] Geçici GÜÇ kazan."
  },
  State_22325_Name = {
    Text = "Dev Soy Hattı"
  },
  State_22326_Desc = {
    Text = "Hedef sensin! Oynandıktan sonra, Denizci Muhafızı 1 yığın Geçici Delilik kazanır ve bu Komut Kartı’ndan Öfke İşareti’ni kaldırır."
  },
  State_22326_Name = {
    Text = "<CardKeyWord:Öfke Mührü>"
  },
  State_22328_Desc = {
    Text = "\"Öfke Mührü\" taşıyan bir Komut Kartı her kullanıldığında, bu tur için saldırı sayısını 1 artır."
  },
  State_22328_Name = {
    Text = "Azgın Dalgalar Yankısı"
  },
  State_22334_Desc = {
    Text = "Her \"Darbe\" kartı oynandığında, Çekme Desteği’nin üstüne [StateArg1] \"Yara\" yerleştir."
  },
  State_22334_Name = {Text = "Travma"},
  State_22404_Desc = {
    Text = "Bu savaşta üretilen Karakter Kalkanı [Layer] artar."
  },
  State_22404_Name = {Text = "Teyakkuz"},
  State_22405_Desc = {
    Text = "Bu Savaşta Karakter Kalkanı üretimini artır."
  },
  State_22405_Name = {
    Text = "<PVPAlertKeywords:Uyarı>"
  },
  State_22702_Desc = {
    Text = "Her tur oynanan ilk \"Kart\" ek bir Etki tetikler."
  },
  State_22702_Name = {
    Text = "<CardKeyWord:Pusu>"
  },
  State_22706_Name = {
    Text = "Baskın İşareti"
  },
  State_22707_Desc = {
    Text = "Her kart oynama turun ardından, seni bir Pusu Durumuyla işaretler."
  },
  State_22707_Name = {
    Text = "Pusu Tetikleyicisi"
  },
  State_22721_Name = {
    Text = "Krono Sarkaç \"Akış\""
  },
  State_23405_Desc = {
    Text = "Bu Uyandırıcı hâlâ Henüz Uyanmamış... Yenilmek üzereyken Uyanacak, mevcut Sayaç yığın sayısı kadar STR kazanacak, HP’sini yenileyecek ve tüm gücüyle savaşacak."
  },
  State_23405_Name = {
    Text = "Uyanmamış"
  },
  State_23406_Desc = {
    Text = "\"Uçurum Sakini\" her turun sonunda [StateArg1] yığın Sayaç kazanır."
  },
  State_23406_Name = {
    Text = "Caecus Uyanış!"
  },
  State_23512_Name = {
    Text = "Bin Serap Bahşet"
  },
  State_23514_Name = {
    Text = "Bin Serap Bahşet"
  },
  State_23515_Name = {
    Text = "Bin Serap Bahşet"
  },
  State_23516_Name = {
    Text = "Bin Serap Bahşet"
  },
  State_23517_Name = {
    Text = "Oyuncuya GÜÇLENDİRME ver"
  },
  State_23518_Desc = {
    Text = "2 tur boyunca Savunmasız uygular / 1 kez daha Saldırı yapar / STR▼ uygular."
  },
  State_23518_Name = {
    Text = "<CardKeyWord:Niyet Seçimi>"
  },
  State_23519_Name = {Text = "Niyet 2b"},
  State_23520_Name = {Text = "Niyet 2c"},
  State_23521_Name = {
    Text = "Atıldığında, Tüket ve tüm Uyananların Aliemus'u -[StateArg1]. Çekme Desteğine 5 \"Semptom\" Kartı karıştır."
  },
  State_23522_Name = {
    Text = "Atıldığında, Tüket ve tüm Uyananların Aliemus'u -[StateArg1]."
  },
  State_23524_Name = {Text = "Niyet 3a"},
  State_23525_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_23525_Name = {
    Text = "Uyanmamış"
  },
  State_23526_Name = {Text = "Niyet 2a"},
  State_23527_Name = {Text = "Niyet 3c"},
  State_23528_Name = {Text = "Niyet 3b"},
  State_23529_Desc = {
    Text = "Güç Artır / Ek Hasar Ver / Karakter Kalkanı Kazan"
  },
  State_23529_Name = {
    Text = "<CardKeyWord:Niyet Seçimi>"
  },
  State_23530_Desc = {
    Text = "\"Bin Serap\" kullanmak iki Niyet seçimi gerektirir. Eğer atılırsa, tüm Uyananlar 20 Aliemus kaybeder ve 5 \"Semptom\" kartı Çekme Desteğine karıştırılır."
  },
  State_23530_Name = {
    Text = "Nergis Uyan!"
  },
  State_23531_Name = {
    Text = "Bin Serap Bahşet"
  },
  State_23532_Name = {
    Text = "Bin Serap Bahşet"
  },
  State_23533_Desc = {
    Text = "Semptom kartı uygula / Kan Akıtma uygula / Aliemus azalt"
  },
  State_23533_Name = {
    Text = "<CardKeyWord:Niyet Seçimi>"
  },
  State_23534_Name = {Text = "Niyet 1a"},
  State_23535_Name = {Text = "Niyet 1c"},
  State_23536_Name = {Text = "Niyet 1b"},
  State_23612_Desc = {
    Text = "Her 1 HP kaybedildiğinde 1 yığın azalır. Yığın sayısı 0'a indiğinde, Niyet yüksek Hasarlı bir Yücelişe kayar ve Taşlaştırma etkisini kaldırır."
  },
  State_23612_Name = {
    Text = "Kan Çılgınlığı: Final"
  },
  State_23687_Name = {
    Text = "Krono Sarkaç \"Gelgit\""
  },
  State_23726_Desc = {
    Text = "Bir sonraki turdan önce, Uyandıran’ın bir kez ölmesini engeller; en fazla 1 yük birikebilir."
  },
  State_23726_Name = {Text = "Direnç"},
  State_23732_Desc = {
    Text = "Sonraki tur başlayana kadar, alınan her Aktif Hasar örneği için [Layer] <plural value=\"[Layer]\" singular=\"yığın\" plural=\"yığın\"> <PainWord:Tahammül> kazan."
  },
  State_23732_Name = {
    Text = "Yasak Bataklık"
  },
  State_23736_Name = {
    Text = "Bu turda çekilen kart sayısı"
  },
  State_23737_Name = {
    Text = "Çekme Sayısı Kaydı"
  },
  State_23741_Name = {
    Text = "Kart Çekme Kaydı Uygula"
  },
  State_23744_Desc = {
    Text = "Sahada hiç \"Ölü\" yoksa, tur başında 1 \"Ölü\" çağır ve her çağrıda HP artar."
  },
  State_23744_Name = {
    Text = "Ölülerin Çağrısı"
  },
  State_23747_Name = {
    Text = "HP Güçlendirme"
  },
  State_23748_Name = {
    Text = "Çağırma Sayısı"
  },
  State_23769_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_23769_Name = {
    Text = "Uyanmamış"
  },
  State_23771_Desc = {
    Text = "\"Büyü Ustası\" Uyandırıldı. Onun \"Fantazma\" sının yarattığı kopyalara dikkat et. Rakip, onun Uyanışından sonra her kart oynadığında, Casiah 1 yığın \"Fantazma\" kazanır."
  },
  State_23771_Name = {
    Text = "Casiah Uyanış!"
  },
  State_23771_WeaponDesc = {
    Text = "Bir sonraki turun başında, önceki turda kaybedilen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_23782_Desc = {
    Text = "Fantazma 10 yığına ulaştığında, \"Fantazma\" yığın sayısını temizle ve öne 1 hayalet çağır; aynı anda en fazla 2 hayalet var olabilir. Hayalet çağrıldığında üzerinde 3 yığın <ParcloseIconKeywords:Bariyer> taşır."
  },
  State_23782_Name = {Text = "Fantazma"},
  State_23786_Name = {
    Text = "Durum@Uyandırıcı Casiah Telekinezi"
  },
  State_23787_Name = {
    Text = "Durum@Uyandırıcı Casiah@Telekinezi@Çekme Azaltma"
  },
  State_23788_Desc = {
    Text = "3. turun başında, eline şu karttan 1 ekle: \"Geçmişin Yankıları—Tüm kartları at, mevcut HP ve Kalkanı bir önceki turun sonundaki hâline sıfırla. Elde Tut, Tüket.\""
  },
  State_23791_Name = {
    Text = "Açılış İpucu"
  },
  State_23823_Name = {Text = "Bomba 1"},
  State_23825_Name = {
    Text = "Durum@Uyandırıcı Casiah@Puf"
  },
  State_23827_Desc = {
    Text = "Oynandıktan sonra, [DescArg1] Maksimum Can kaybet. Büyük sihirbaz bu tur 1 \"Ego Artışı\" yığını kazanır."
  },
  State_23827_Name = {
    Text = "<CardCheerKeywords:Alkış>"
  },
  State_23828_Desc = {
    Text = "Büyük büyücü artık gösterisinin tadını sonuna dek çıkarıyor. Her bir \"Ego Artışı\" yükü için, Becerinin etkisi ve becerilerinin GÜÇ'ü [DescArg1] azalır, en fazla 5 yüke kadar."
  },
  State_23828_Name = {
    Text = "Ego Artışı"
  },
  State_23871_Desc = {
    Text = "Maksimum HP’yi artırmak mevcut HP’yi yenilemez. Maksimum HP’yi azaltmak, fazladan mevcut HP’yi yine de kaldırır. Ayarlanmış Maksimum HP’nin alt sınırı 1’dir ve ölümle sıfırlanmaz."
  },
  State_23871_Name = {
    Text = "<MaxHPColour:Azami Can>"
  },
  State_23934_Name = {
    Text = "Durum@Telekinezi El Kartı İzleyici"
  },
  State_23935_Name = {
    Text = "Durum@Uyandırıcı Casiah@Telekinezi Aktif"
  },
  State_2393_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_2393_Name = {
    Text = "Uyanmamış"
  },
  State_2394_Name = {
    Text = "Kızıl Güç Aydınlanma Artışı"
  },
  State_2395_Name = {
    Text = "Aksesuar: Uzakların Şöleni"
  },
  State_2395_WeaponDesc = {
    Text = "\"Savunma\" kalkanı %30 artırır. Eğer kullananın Mühür Hasadı %15’ten fazlaysa, \"Savunma\" ayrıca %30 ek kalkan sağlar."
  },
  State_2396_Desc = {
    Text = "Krit. Hasar +%20. Karakter Kalkanı olan düşmanlara karşı garantili Kritik Vuruş."
  },
  State_2398_Desc = {
    Text = "Hasar almak [Layer] Karakter Kalkanı kazandırır; bu kalkan her darbe ile artar ve turun sonunda yenilenir."
  },
  State_2398_Name = {
    Text = "Boyutsal Savunma Duvarı"
  },
  State_2398_WeaponDesc = {
    Text = "Alınan Aktif Hasar [Layer] artar. Her Hasar alındığında Çözünme Yarası genişler ve Tur başında iyileşir."
  },
  State_2399_Desc = {
    Text = "HP yenilendikten sonra, tüm Uyananlar 3 Aliemus kazanır. Her 5. HP yenilenmesinde, bu savaş için Yüceltme Hasarı [Arg1] artar."
  },
  State_2400_Desc = {
    Text = "Dokunaç Sınırı 1 artar. HP %50'nin altındayken Dokunaç Hasarı [StateArg1] artar."
  },
  State_2400_Name = {
    Text = "Geçmişin Yadigârının Yaratımı"
  },
  State_2400_WeaponDesc = {
    Text = "Dokunaç Sınırı 1 artar. HP %50'nin altındayken Dokunaç Hasarı [StateArg1] artar."
  },
  State_2401_Desc = {
    Text = "Tur başında Atılmış Kart Desteği'nin en üstündeki kartı eline ekle."
  },
  State_2402_Desc = {
    Text = "Tur başında, bu tur Ultra Uzay’daki her Kart için [Arg1] Geçici GÜÇ kazan."
  },
  State_2403_Desc = {
    Text = "Bu Savaşta Karakter Kalkanı Üretimi [Layer] artar."
  },
  State_2403_Name = {Text = "Teyakkuz"},
  State_2403_WeaponDesc = {
    Text = "Bu Savaşta Karakter Kalkanı Üretimi [Layer] artar."
  },
  State_2404_Desc = {
    Text = "Alındığında 1 Semptom kartı kaldır. Şanslı Orison Oranı %50 artar."
  },
  State_2405_Desc = {
    Text = "Kartın Aritmetika değerini geçici olarak değiştir"
  },
  State_2405_Name = {
    Text = "Kartın Aritmetika değerini geçici olarak değiştir"
  },
  State_2405_WeaponDesc = {
    Text = "Kartın Aritmetika değerini geçici olarak değiştir"
  },
  State_2406_Desc = {
    Text = "Son 1 Arithmetica'yı tükettiğinde, 2 Arithmetica kazan. Tur başına en fazla 2 kez tetiklenir."
  },
  State_2407_Name = {
    Text = "Gözlem Değerleri"
  },
  State_2408_Name = {
    Text = "Denizci düdüğü"
  },
  State_2409_Desc = {
    Text = "Bu tur, oynanan her [Strike] kartı Arithmetica Maliyetini 1 azaltır."
  },
  State_2409_Name = {
    Text = "İsyan Kılıcı"
  },
  State_2409_WeaponDesc = {
    Text = "Bu tur, oynanan her [Strike] kartı Arithmetica Maliyetini 1 azaltır."
  },
  State_2410_Desc = {
    Text = "1 tur boyunca hareket edemez. Taşlaşmış düşmanlar tekrar Taşlaştırılamaz."
  },
  State_2410_Name = {
    Text = "<PetrifactionIconKeywords:Taşlaştırma>"
  },
  State_2410_WeaponDesc = {
    Text = "Canavarı bir tur boyunca sersemlet."
  },
  State_2411_Desc = {
    Text = "Tur sonunda, takımına [Layer] yığın Kanama uygula."
  },
  State_2411_Name = {
    Text = "Kan Kandili"
  },
  State_2411_WeaponDesc = {
    Text = "Tur sonunda, takımına [Layer] yığın Kanama uygula."
  },
  State_2412_Desc = {
    Text = "Sonraki tur verilecek Hasarı iki katına çıkar."
  },
  State_2412_Name = {
    Text = "Çıkmazda Hayatta Kalma"
  },
  State_2412_WeaponDesc = {
    Text = "Sonraki tur verilecek Hasarı iki katına çıkar."
  },
  State_2413_Desc = {
    Text = "Darbe ve Savunma ile kazanılan Aliemus [Layer] % azaltılır."
  },
  State_2413_Name = {Text = "Boşluk"},
  State_2413_WeaponDesc = {
    Text = "Darbe ve Savunma'dan [StateArg1]% Aliemus kazan."
  },
  State_2415_Desc = {
    Text = "Önceki turda Hasar aldıysan, bu turun başında 1 tur boyunca bağışıklık kazan."
  },
  State_2415_Name = {
    Text = "Uyum Sağla"
  },
  State_2415_WeaponDesc = {
    Text = "Önceki turda Hasar aldıysan, bu turun başında 1 tur boyunca bağışıklık kazan."
  },
  State_2416_Desc = {
    Text = "Çağırdığı Canavarların Canı ve Hasarı iki katına çıkar."
  },
  State_2416_Name = {
    Text = "\"Balmumu Heykel Dünyası\""
  },
  State_2416_WeaponDesc = {
    Text = "Çağırdığı Canavarların Canı ve Hasarı iki katına çıkar."
  },
  State_24174_Desc = {
    Text = "Bu Uyanan'ın Canı, Hasar nedeniyle 1'in altına düşmez."
  },
  State_24174_Name = {
    Text = "Ölüm Bağışıklığı"
  },
  State_2418_Desc = {
    Text = "[Exalt] 30 Aliemus verir."
  },
  State_2418_Name = {
    Text = "Yabancılaşmış Tanrı'nın Peçesi"
  },
  State_2418_WeaponDesc = {
    Text = "[Exalt] 30 Aliemus verir."
  },
  State_2419_Name = {
    Text = "Kalıntı Beyaz Ayna"
  },
  State_2420_Desc = {
    Text = "Bu tur, oynanan her [Defense] kartı Arithmetica Maliyetini 1 azaltır."
  },
  State_2420_Name = {
    Text = "Kalp Gözü Bıçağı"
  },
  State_2420_WeaponDesc = {
    Text = "Bu tur, oynanan her [Defense] kartı Arithmetica Maliyetini 1 azaltır."
  },
  State_24210_Desc = {
    Text = "Bu tur, Tanrı Kral’ın Dokunaç Saldırısı tüm düşmanları hedef alır."
  },
  State_24210_Name = {
    Text = "İlahi Uzuv: Posse"
  },
  State_24211_Desc = {
    Text = "\nTur sonunda, ön saftaki düşmanlara [DescArg4] kez [DescArg2] Hasar ver. Bir düşman öldürülürse, Hasar [DescArg3] puan artar; en fazla 5 kez (şu anda [DescArg6] kez).\nUyanan her Yücelt kullandığında, bu tur ek bir saldırı tetiklenir.\nKoruyucu Posse kullandıktan sonra, bu tur için saldırı hedefi tüm düşmanlar olarak değişir. Eğer bir Reis Savaşı ise, \"İlahi Uzuv\"un verdiği Hasar da +[DescArg5] puan artar."
  },
  State_24211_Name = {
    Text = "İlahi Uzuv"
  },
  State_24213_Name = {
    Text = "Bu kart elindeyse, tur sonunda 150 Keyflare kazan."
  },
  State_24214_Desc = {
    Text = "Tur sonunda, ön saftaki düşmanlara [DescArg2] Hasar ver."
  },
  State_24214_Name = {
    Text = "İlahi Uzuv"
  },
  State_24215_Desc = {
    Text = "Tur sonunda, ön saftaki düşmanlara [DescArg2] Hasar ver. Bir düşman öldürülürse, bu Hasarı [DescArg3] kadar artır; en fazla 5 kez (şu anda [DescArg4] kez)."
  },
  State_24215_Name = {
    Text = "İlahi Uzuv"
  },
  State_24217_Name = {
    Text = "Kendindeki <VulnerabilityIconKeywords:Savunmasız>, <WeaknessIconKeywords:Zayıflık> ve <FragileIconKeywords:Kırılgan> durumlarını dağıt"
  },
  State_24220_Name = {
    Text = "[DescArg1] Kalkan Puanı kazan"
  },
  State_24222_Desc = {
    Text = "Tur sonunda, ön saftaki düşmanlara [DescArg4] kez [DescArg2] Hasar ver. Bir düşman öldürülürse, Hasar [DescArg3] puan artar; en fazla 5 kez (şu anda [DescArg5] kez).\nHer Uyanan, Yücelt kullandığında bu tur fazladan bir saldırı gerçekleştir.\nBu tur her Koruyucu Posse kullandığında, saldırı tüm düşmanları hedef alır."
  },
  State_24222_Name = {
    Text = "İlahi Uzuv"
  },
  State_24223_Desc = {
    Text = "Tur sonunda, ön saftaki düşmanlara [DescArg2] Hasar ver. Bir düşman öldürülürse, bu Hasarı [DescArg3] kadar artır; en fazla 5 kez (şu anda [DescArg4] kez).\nMuhafız her Posse kullandığında, bu turun saldırılarının hedefini tüm düşmanlar olarak değiştir."
  },
  State_24223_Name = {
    Text = "İlahi Uzuv"
  },
  State_24224_Desc = {
    Text = "Her turun ardından, ön saftaki düşmanlara [DescArg4] isabetlik [DescArg2] Hasar ver. Bir düşman öldürülürse, Hasar [DescArg3] puan artar; en fazla 5 kez (şu anda [DescArg5] kez).\nBu turda her Uyandırıcı Yüceldiğinde, fazladan bir saldırı gerçekleştir."
  },
  State_24224_Name = {
    Text = "İlahi Uzuv"
  },
  State_24226_Desc = {
    Text = "\nTur sonunda, ön saftaki düşmanlara [DescArg4] kez [DescArg2] Hasar ver. Bir düşman öldürülürse, Hasar [DescArg3] puan artar; en fazla 5 kez (şu anda [DescArg6] kez).\nUyanan her Yücelt kullandığında, bu tur ek bir saldırı tetiklenir.\nBir Reis Savaşı’nda, Koruyucu her Posse kullandığında \"İlahi Uzuv\"un verdiği Hasar [DescArg5] puan artar."
  },
  State_24226_Name = {
    Text = "İlahi Uzuv"
  },
  State_24227_Desc = {
    Text = "\nTur sonunda, ön saftaki düşmanlara [DescArg2] Hasar ver. Bir düşman öldürülürse, Hasar [DescArg3] puan artar; en fazla 5 kez (şu anda [DescArg5] kez).\nKoruyucu Posse kullandıktan sonra, bu tur için saldırı hedefi tüm düşmanlar olarak değişir. Eğer bir Reis Savaşı ise, \"İlahi Uzuv\"un verdiği Hasar da +[DescArg4] puan artar."
  },
  State_24227_Name = {
    Text = "İlahi Uzuv"
  },
  State_2422_Desc = {
    Text = "Oynandığında, <Block:[StateArg1]> Karakter Kalkanı kazan."
  },
  State_2422_Name = {
    Text = "<Rune_6:Siper>"
  },
  State_24245_Desc = {
    Text = "Tur sonunda, tüm \"Hidra\" akrabalarını dirilt. Her akraba öldüğünde, yığın sayısını 1 azalt; yığınlar 0’a ulaşırsa, \"Hidra\" final savaş için dönüşür."
  },
  State_24245_Name = {
    Text = "Yılan Manipülasyonu"
  },
  State_24247_Desc = {
    Text = "Alınan hasar %90 azalır. Tur başında üzerinde hiç \"Yılan Manipülasyonu\" yığını yoksa, bu durum kaldırılır."
  },
  State_24247_Name = {
    Text = "Yılan Bariyeri"
  },
  State_2425_Desc = {
    Text = "Oynandığında Tüketme. Eğer bir Komut Kartı ise, Hasarı ve Savunması 2 katına çıkar."
  },
  State_2425_Name = {
    Text = "<CardKeyWord:Çözünme>"
  },
  State_2426_Desc = {
    Text = "Her tur oynadığın ilk kart bir kez daha tetiklenir, ancak tur başına en fazla 4 kart oynayabilirsin."
  },
  State_2427_Name = {
    Text = "Durum@İllüzyon Gümüş Anahtarı: Kan Uçurum Kalp Karşı Saldırısı"
  },
  State_2428_Desc = {
    Text = "Kötülük Çiçeği’nden gelen <ParcloseIconKeywords:Bariyer> sayısı [Layer] seviye artar."
  },
  State_2428_Name = {
    Text = "Hınç Bariyeri"
  },
  State_2428_WeaponDesc = {
    Text = "Kötü Çiçek Bariyerlerinin miktarı [Layer] yığın arttı."
  },
  State_24292_Name = {
    Text = "Arka Sıra İlerle"
  },
  State_24293_Name = {
    Text = "Ön Sırayı Geriye Taşı"
  },
  State_2429_Desc = {
    Text = "Verilen tüm Hasar [Layer]% azaltılır."
  },
  State_2429_Name = {
    Text = "Geçici Hasar Azaltımı"
  },
  State_2429_WeaponDesc = {
    Text = "Verilen tüm Hasar [Layer]% azaltılır."
  },
  State_2430_Desc = {
    Text = "Savaş başında, tüm müttefikler [Waxed Armor] yığın kazanır. Tur sonunda, takımına [Arg1] yığın Kanama uygular."
  },
  State_2430_Name = {
    Text = "\"Balmumu Beyefendi\""
  },
  State_2430_WeaponDesc = {
    Text = "Savaş başında, tüm müttefikler [Waxed Armor] yığın kazanır. Tur sonunda, takımına [Arg1] yığın Kanama uygular."
  },
  State_2431_Desc = {
    Text = "Takıma Özel: Kullanıcının Kalkanı ve HP Yenilenmesi, ONB’lerinin <WeaponEffect_Num:[StateArg1]%>’i kadar artar. Kullanıcının Karşı Saldırısı +<WeaponEffect_Num:[StateArg3]%> hasar verir. \"Savunma\" oynandıktan sonra, kullanıcının ZDH’sinin <RetaliateIconKeywords:[StateArg4]%>’i kadar <WeaponEffect_Num:Counter> kazan. Savaşın başında, kullanıcının ONB’lerinin <PowerIconKeywords:[StateArg2]%>’i kadar <WeaponEffect_Num:STR> kazan. Mevcut âlem \"Aequor\" ise, aynı miktarda ek Dokunaç Hasarı kazan."
  },
  State_2431_WeaponDesc = {
    Text = "The Shield Generation and HP Recovery increase by <WeaponEffect_Num:[DescArg1]>. The wielder's Counter increases by <WeaponEffect_Num:[StateArg3]>. After playing \"Defense,\" gain <WeaponEffect_Num:[Counterattack:DescArg3]> stacks of <RetaliateIconKeywords:Counter>. At the start of battle, gain <WeaponEffect_Num:[Power:DescArg2]> <PowerIconKeywords:STR>. If the current Realm is \"Aequor,\" gain additional Tentacle DMG of the same amount."
  },
  State_2432_Desc = {
    Text = "Alınan Aktif ve Dokunaç Hasarı +%50, tur sonunda 1 yığın kaldırılır."
  },
  State_2432_Name = {
    Text = "<VulnerabilityIconKeywords:Savunmasız>"
  },
  State_2432_WeaponDesc = {
    Text = "Alınan tüm Hasar %50 artırılır."
  },
  State_2433_Desc = {
    Text = "Her turun sonunda [Layer] STR elde edersin."
  },
  State_2433_Name = {Text = "Öfke"},
  State_2434_Name = {
    Text = "Aksesuar: Oda 36 Yüzüğü"
  },
  State_2434_WeaponDesc = {
    Text = "Kuşananın kartı çekildiğinde, Arithmetica değeri rastgele 0 ile 3 arasında değişir."
  },
  State_2435_Desc = {Text = "Olay 19_2"},
  State_2435_Name = {Text = "Olay 19_2"},
  State_2435_WeaponDesc = {Text = "Olay 19_2"},
  State_2436_Desc = {
    Text = "Kazanılan Güç ve Karakter Kalkanı, [Layer] tur boyunca %50 azaltılır."
  },
  State_2436_Name = {
    Text = "Geçici Lanet"
  },
  State_2436_WeaponDesc = {
    Text = "Turunun sonundan önce, kendine uygulanan güçlendirme etkilerine karşı bağışıklık kazan."
  },
  State_2437_Desc = {Text = "—"},
  State_2437_WeaponDesc = {Text = "—"},
  State_2438_Desc = {
    Text = "Durum@Kalıntı Gümüş Diferansiyel Motor Sayacı"
  },
  State_2438_Name = {
    Text = "Durum@Kalıntı Gümüş Diferansiyel Motor Sayacı"
  },
  State_2438_WeaponDesc = {
    Text = "Durum@Kalıntı Gümüş Diferansiyel Motor Sayacı"
  },
  State_2440_Name = {
    Text = "1 kart çek."
  },
  State_2441_Name = {
    Text = "1 Arithmetica elde et."
  },
  State_2442_Name = {
    Text = "Tüm düşmanlara 1 yük <VulnerabilityIconKeywords:Vulnerable> uygula."
  },
  State_2443_Name = {
    Text = "Tüm düşmanlara 1 yığın <WeaknessIconKeywords:Zayıflık> uygula"
  },
  State_2444_Name = {
    Text = "<Energy:[DescArg1]> Aliemus kazan"
  },
  State_2445_Name = {
    Text = "Diğer Uyananlar <Energy:[DescArg1]> Aliemus kazanır"
  },
  State_2446_Name = {
    Text = "Çekme Destene 1 <DerivativeCardKeywords_4:\"Insight\"> ekle."
  },
  State_2447_Desc = {
    Text = "Takıma Özel: Kuşananın Komut Kartı Kritik Oranı ve Krit. Hasarı, Karakter Kalkanı Üretimi, HP Yenilenmesi, Aliemus ve Gücü <WeaponEffect_Num:[StateArg1]% artar>. Mevcut diyar \"Ultra\" ise, \"Yok Oluş\" kullanıldıktan sonra <WeaponEffect_Num:[StateArg2]> Keyflare kazan. Ultra Tur'a girildikten sonra, bir sonraki Çete bu tur iki kez serbest bırakılır."
  },
  State_2447_WeaponDesc = {
    Text = "Kuşananın Komut Kartı Kritik Oranı ve Kritik Hasarı, Karakter Kalkanı Üretimi, HP Yenilenmesi, Aliemus ve Gücü <WeaponEffect_Num:[StateArg1]%> artar. Mevcut âlem \"Ultra\" ise, \"Yok Oluş\" serbest bırakıldıktan sonra <WeaponEffect_Num:[StateArg2]> Keyflare kazan. Ultra Tur'a girildikten sonra, bir sonraki Çete bu tur iki kez serbest bırakılır."
  },
  State_2448_Desc = {
    Text = "Kart Atılmış Kart Destesine girmez, bunun yerine elinde kalır."
  },
  State_2448_Name = {
    Text = "<CardKeyWord:Muhafaza>"
  },
  State_2449_Desc = {
    Text = "Gerçek Hasar aldıktan sonra [Layer] Karakter Kalkanı elde et."
  },
  State_2449_Name = {Text = "Tampon"},
  State_2449_WeaponDesc = {
    Text = "Gerçek Hasar aldıktan sonra [Layer] Karakter Kalkanı elde et."
  },
  State_2450_Desc = {
    Text = "\"Darbe\" garanti Kritik Vuruş yapar. Krit. Hasar %50 artar."
  },
  State_2451_Desc = {
    Text = "Tur sonunda, diğer müttefikler [Layer] GÜÇ kazanır."
  },
  State_2451_Name = {
    Text = "\"Aydınlanma Ateşi\""
  },
  State_2452_Desc = {
    Text = "Oynandığında, etkileri çözümlendikten sonra [StateArg1] <PowerIconKeywords:STR> kazan."
  },
  State_2452_Name = {
    Text = "<Rune_14_High:Gelişmiş Kaba Güç>"
  },
  State_2453_Name = {
    Text = "Aksesuar: Fotosentez Ritüeli"
  },
  State_2453_WeaponDesc = {
    Text = "Savaşın başında, Kuşanan'ın tüm kartları Sakla kazanır."
  },
  State_2454_Desc = {
    Text = "Oynandıktan sonra, bu kart Atılmış Kart Destesi'ne gitmek yerine desteden kaldırılır."
  },
  State_2454_Name = {
    Text = "<DepleteIconKeywords:Tüketme>"
  },
  State_2454_WeaponDesc = {
    Text = "Oynandıktan sonra, kart Atılmış Kart Destesi’ne gitmez ve bu Savaşta tekrar kullanılamaz."
  },
  State_24556_Name = {
    Text = "Durum@Büyük Sihirbaz Houdini@Şanslı Seyirci Tezahüratı Eklendi"
  },
  State_2455_Name = {
    Text = "Durum @ Mavi Alev Dansçısı Aydınlanma 7"
  },
  State_24560_Desc = {
    Text = "Her Çete kullandığında, Ramona: Zaman Aşınmış, Geçici olarak %25 Kritik Oran ve Krit. Hasar artışı kazanır."
  },
  State_24560_Name = {
    Text = "Klein Şişesi Yolcusu"
  },
  State_24562_Desc = {
    Text = "Tur sonunda 1 yığın Negentropi kazan."
  },
  State_24562_Name = {
    Text = "Penrose Hacısı"
  },
  State_24564_Desc = {
    Text = "3 Negentropi yığınıyla, Ramona: Yıpranmış Zaman’ın Komut Kartlarını kullanmak tüm yığınları tüketir ve ek Döngü etkisini tetikler. (En fazla 3 yığın)"
  },
  State_24564_Name = {Text = "Negentropi"},
  State_2456_Name = {
    Text = "Durum @ Mavi Alev Dansçısı Aydınlanma 15"
  },
  State_2457_Name = {
    Text = "1 kart çek."
  },
  State_24584_Name = {
    Text = "Durum@N'nin Klonu@Fısıltı1 Durum Değişimi"
  },
  State_2458_Name = {
    Text = "Durum@Aksesuar Kızıl Kucaklayış Etki Sayısı"
  },
  State_24593_Desc = {
    Text = "Yığın sayısı 0 olduğunda, niyeti \"Kara Çağırma\" olarak değiştir. Tur sonunda, yığın sayısı 1 azalır ve en fazla 4 yığına kadar çıkabilir."
  },
  State_24593_Name = {Text = "Kaos"},
  State_24595_Desc = {
    Text = "Öldüğünde, \"Kaos\"un \"N\" yığınını derhal 1 azalt."
  },
  State_24595_Name = {Text = "Yayılma"},
  State_24596_Desc = {
    Text = "\"N\"in bir klonunu çağırdığında, her bir \"Karanlık\" yığını için fazladan bir klon daha Çağrı."
  },
  State_24596_Name = {Text = "Karanlık"},
  State_2460_Desc = {
    Text = "Takıma Özel: Kuşananın Temel Hasarı, <IntoxicationIconKeywords:Zehir>i ve <RetaliateIconKeywords:Sayaç>ı <WeaponEffect_Num:[StateArg1]%> artar. Krit. Oranı ve Krit. Hasar <WeaponEffect_Num:[StateArg2]%> artar."
  },
  State_2460_WeaponDesc = {
    Text = "Kullananın Temel Hasarı, <IntoxicationIconKeywords:Zehir> ve <RetaliateIconKeywords:Sayaç>ı <WeaponEffect_Num:[StateArg1]%> artar. Krit. Oranı ve Krit. Hasarı <WeaponEffect_Num:[StateArg2]%> artar."
  },
  State_2461_Desc = {
    Text = "Bu Savaşta, Ölümcül Hasar aldığında diril, [Layer] Can yenile ve tüm Uyananlara [StateArg1] Aliemus ver. Bu etki dağıtılamaz."
  },
  State_2461_Name = {
    Text = "Ölümsüz Cennet Kuşu"
  },
  State_2463_Desc = {
    Text = "Savaş başında, Embriyo Füzyonu +%20. Aliemus'u maksimumda olan her Uyandıran için Embriyo Füzyonu ilave +%20 artar."
  },
  State_24640_Desc = {
    Text = "Savaş başladığında Embriyo Füzyonu +[Blood:DescArg1]; her Direnç tetiklendiğinde Embriyo Füzyonu +[Blood:DescArg1]. Sorel her Hasar verdiğinde, bu tur içinde kendi verdiği Hasar, SLD'nin %4'ü kadar artar."
  },
  State_24640_Name = {
    Text = "Taç Mücevheri"
  },
  State_2464_Desc = {
    Text = "Kart Arithmetica Artışı"
  },
  State_2464_Name = {
    Text = "Kalıcı Kart Aritmetika Artışı"
  },
  State_2464_WeaponDesc = {
    Text = "Kart Arithmetica Artışı"
  },
  State_24654_Desc = {
    Text = "Nergis, her düşman öldürdüğünde takımın Kritik Oranını kalıcı olarak %5 artırır; bu koşuda en fazla 5 defaya kadar birikir. (Mevcut yığın: [DescArg1])"
  },
  State_24654_Name = {
    Text = "Açgözlülük Sisi"
  },
  State_2466_Desc = {
    Text = "Sonraki tur başlayana kadar, alınan her Hasar örneği için Dokunaç saldırgana bir kez karşı saldırı yapar. Geçici Dokunaç Hasarı +[Layer]."
  },
  State_2466_Name = {
    Text = "Sapkın Soy"
  },
  State_24678_Name = {
    Text = "Durum@N'nin Klonu@Fısıltı2 Durum Değişimi"
  },
  State_24679_Name = {
    Text = "Durum@N'nin Klonu 3@Fısıltı 6 Durum Değişimi"
  },
  State_2467_Desc = {
    Text = "Durum@Prolog Saldırı Analizi"
  },
  State_2467_Name = {
    Text = "Durum@Prolog Saldırı Analizi"
  },
  State_2467_WeaponDesc = {
    Text = "Durum@Prolog Saldırı Analizi"
  },
  State_24680_Name = {
    Text = "Durum@N'nin Klonu 2@Fısıltı 1 Durum Değişimi"
  },
  State_24681_Name = {
    Text = "Durum@N'nin Klonu@Fısıltı6 Durum Değişimi"
  },
  State_24682_Name = {
    Text = "Durum@N'nin Klonu 3@Fısıltı 3 Durum Değişimi"
  },
  State_24683_Name = {
    Text = "Durum@N'nin Klonu 2@Fısıltı 2 Durum Değişimi"
  },
  State_24684_Name = {
    Text = "Durum@N'nin Klonu@Fısıltı4 Durum Değişimi"
  },
  State_24685_Name = {
    Text = "Durum@N'nin Klonu@Fısıltı5 Durum Değişimi"
  },
  State_24686_Name = {
    Text = "Durum@N'nin Klonu 3@Fısıltı 5 Durum Değişimi"
  },
  State_24687_Name = {
    Text = "Durum@N'nin Klonu 3@Fısıltı 2 Durum Değişimi"
  },
  State_24688_Name = {
    Text = "Durum@N'nin Klonu 2@Fısıltı 6 Durum Değişimi"
  },
  State_24689_Name = {
    Text = "Durum@N'nin Klonu 3@Fısıltı 4 Durum Değişimi"
  },
  State_24690_Name = {
    Text = "Durum@N'nin Klonu 3@Fısıltı 1 Durum Değişimi"
  },
  State_24691_Name = {
    Text = "Durum Klonu@N2@Fısıltı4 Durum Değişimi"
  },
  State_24692_Name = {
    Text = "Durum@N'nin Klonu 2@Fısıltı 3 Durum Değişimi"
  },
  State_24693_Name = {
    Text = "Durum@N'nin Klonu@Fısıltı3 Durum Değişimi"
  },
  State_24694_Name = {
    Text = "Durum@N'nin Klonu 2@Fısıltı 5 Durum Değişimi"
  },
  State_2470_Desc = {
    Text = "Alındığında kalıcı olarak [Arg1] Uyanıklık kaybedilir. Aktif Hasar, 1x GÜÇ bonusu kazanır."
  },
  State_24719_Desc = {
    Text = "\"@2\" gerçek formuyla indi, CP x3."
  },
  State_24719_Name = {
    Text = "Kaderin Yeniden Uyanışı"
  },
  State_24719_WeaponDesc = {
    Text = "Bir sonraki turun başında, önceki turda kaybedilen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_2471_Desc = {
    Text = "Tur başında, takımının Alarmını 1 azalt."
  },
  State_2471_Name = {Text = "Aşınma"},
  State_2471_WeaponDesc = {
    Text = "Tur başında, takımının Alarmını 1 azalt."
  },
  State_24720_Desc = {
    Text = "Bu bilinmeyen varlık hâlâ Kara Havuz’un altında pusuda bekliyor. Yakın bir yenilginin eşiğinde tamamen uyanacak ve dirilecek, özgürleşmiş hâliyle dövüşmeye hazır olacak."
  },
  State_24720_Name = {Text = "Uyku Hâli"},
  State_2472_Desc = {
    Text = "Hasar hem Karakter Kalkanını hem de Canı azaltır. Bağışıklık kazanılamaz."
  },
  State_2472_Name = {
    Text = "<PunctureDamagewords:Delici Hasar>"
  },
  State_2472_WeaponDesc = {
    Text = "Delici Hasar, Hedef Karakter Kalkanını, Hasar azaltımını ve engellemeyi yok sayarak doğrudan Hasar verir."
  },
  State_24730_Desc = {
    Text = "Ultra Uzay’ı Geçici olarak artır, en fazla 10’a kadar. Bir sonraki Ultra Tur sırasında, Geçici Ultra Uzay’daki kartlar eline eklenir ve Geçici Ultra Uzay kaldırılır."
  },
  State_24730_Name = {
    Text = "<CardKeyWord:Geçici Ultra Uzay>"
  },
  State_24737_Desc = {
    Text = "Tur başında rakibe Kan Akıtma uygula. Her kader yığını [StateArg1] Kan Akıtma uygular."
  },
  State_24737_Name = {Text = "Kader"},
  State_24738_Desc = {
    Text = "Kader’in her yığını etkinleştiğinde [StateArg1] Kan Akıtma Hasarı verir; bir Kart oynamak Kader’in bir yığınını azaltır."
  },
  State_24738_Name = {Text = "Kader"},
  State_24739_Name = {Text = "Kader"},
  State_2473_Desc = {
    Text = "[Defense] 1 Dokunaç kaybet, [StateArg1] HP yenile. [Strike] [StateArg2] HP kaybet, 1 Dokunaç üret."
  },
  State_2473_Name = {
    Text = "Kalıntı Ölümsüz Beden"
  },
  State_2473_WeaponDesc = {
    Text = "[Defense] 1 Dokunaç kaybet, [StateArg1] HP yenile. [Strike] [StateArg2] HP kaybet, 1 Dokunaç üret."
  },
  State_2474_Desc = {
    Text = "Saldırıyı [Layer]% artır."
  },
  State_2474_Name = {
    Text = "Genel Saldırıyı yüzde olarak artır"
  },
  State_2474_WeaponDesc = {
    Text = "Saldırıyı [Layer]% artır."
  },
  State_2475_Desc = {
    Text = "Takıma Özel: Kuşananın Aktif Hasarı, Kuşananın Saldırısı ×<WeaponEffect_Num:[StateArg3]%> kadar artırılır. Kuşananın bir Komut Kartı oynandıktan veya atıldıktan sonra, rastgele bir düşmana Kuşananın Saldırısı ×<WeaponEffect_Num:[StateArg1]%> kadar <IntoxicationIconKeywords:Zehir> olarak Hasar ver. Ultra Tur sona erdikten sonra, tüm düşmanlarda %100 Zehir tetikleme şansı <WeaponEffect_Num:[StateArg2]%>’dir."
  },
  State_2475_WeaponDesc = {
    Text = "Kuşanan'ın Aktif Hasarı <WeaponEffect_Num:[DescArg2]> puan artar. Kuşanan'dan 1 Komut Kartı oynadıktan veya attıktan sonra, rastgele bir düşmana <WeaponEffect_Num:[DescArg1]> yığın <IntoxicationIconKeywords:Zehir> uygula. Ultra Tur sona erdiğinde, tüm düşmanlarda [DescArg3]% Zehir tetiklemek için <WeaponEffect_Num:[StateArg2]>% ihtimal vardır."
  },
  State_2476_Name = {
    Text = "Durum@Köken Kahin Aydınlanma 1"
  },
  State_2478_Desc = {
    Text = "Nautilus’un uyguladığı Karakter Kalkanı ikiye katlanır."
  },
  State_2478_Name = {
    Text = "Bakım Uzmanı"
  },
  State_2478_WeaponDesc = {
    Text = "Nautilus’un uyguladığı Karakter Kalkanı ikiye katlanır."
  },
  State_2479_Desc = {
    Text = "Zümrüt Ateş’in verdiği her Hasar örneği için +1 Yığın"
  },
  State_2479_Name = {
    Text = "Zümrüt Yansıma Sayacı"
  },
  State_2479_WeaponDesc = {
    Text = "Zümrüt Ateş’in verdiği her Hasar örneği için +1 Yığın"
  },
  State_2480_Desc = {
    Text = "İyileştirme yaptığında [StateArg1] Sayaç kazan. Uçurum Sakini, oynanan her kart için 1 HP yeniler."
  },
  State_2480_Name = {
    Text = "Başkalaşım Bedeni"
  },
  State_2481_Desc = {
    Text = "Durum@Prolog Deste Sıfırla 0_2_3_1"
  },
  State_2481_Name = {
    Text = "Durum@Prolog Deste Sıfırla 0_2_3_1"
  },
  State_2481_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırla 0_2_3_1"
  },
  State_2482_Desc = {
    Text = "HP %50’nin altına düştüğünde, eşit HP’ye sahip 1 Çözünme Üçgeni çağır."
  },
  State_2482_Name = {Text = "Çağır"},
  State_2482_WeaponDesc = {
    Text = "HP %50’nin altına düştüğünde, eşit HP’ye sahip 1 Çözünme Üçgeni çağır."
  },
  State_2486_Desc = {
    Text = "Tur başında, her düşman için 1 Arithmetica kazan. Bir düşman Aktif Hasar ile öldürüldüğünde, fazla Hasarı diğer düşmanlara Kan Akıtma olarak uygula."
  },
  State_24879_Desc = {
    Text = "Bin yıl geçti, on bin yıl geçti; onlar ebedî Karanlık’ta sessizce beklediler. Ölüm anında, \"N\" in 1 yığın \"Kaos\" u azaltılır ve \"N\" e [DescArg1] Kalkan ile [DescArg2] Güç verilir."
  },
  State_24879_Name = {
    Text = "Hayali Çift"
  },
  State_2488_Desc = {
    Text = "Bir Güçlendirme Kartı, Semptom kartı veya Durum Kartı oynadığında, en az Aliemus’a sahip Uyanan 10 Aliemus kazanır."
  },
  State_2489_Desc = {
    Text = "Krit. Oranı +%10. Her tur ilk Kritik Vuruştan sonra, Krit. Oranını fazladan %20 artır. Her tur 3. Kritik Vuruştan sonra, Krit. Hasarı fazladan %50 artır."
  },
  State_2490_Desc = {
    Text = "Her yığın, saldırı sayısını 1 artırır. Hasar aldığında 1 yığın kaybedersin ve tur sonunda tüm yığınları yitirirsin."
  },
  State_2490_Name = {Text = "Dua"},
  State_2491_Desc = {
    Text = "İyileştirme sırasında yenilenen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_2491_Name = {
    Text = "Geçici Sertleşme"
  },
  State_2492_Desc = {
    Text = "Her tur alınan ilk Aktif Hasara karşı Bağışıklık."
  },
  State_2492_Name = {Text = "Azimli"},
  State_2492_WeaponDesc = {
    Text = "Her tur alınan ilk Aktif Hasara karşı Bağışıklık."
  },
  State_2493_Desc = {
    Text = "Aktif Hasarı [Layer] azalt."
  },
  State_2493_Name = {Text = "STR▼"},
  State_2494_Desc = {
    Text = "Durum@Prolog Aliemus 0_1_4_1"
  },
  State_2494_Name = {
    Text = "Durum@Prolog Aliemus 0_1_4_1"
  },
  State_2494_WeaponDesc = {
    Text = "Durum@Prolog Aliemus 0_1_4_1"
  },
  State_2495_Desc = {
    Text = "Durum@Prolog Aliemus 0_1_4_2"
  },
  State_2495_Name = {
    Text = "Durum@Prolog Aliemus 0_1_4_2"
  },
  State_2495_WeaponDesc = {
    Text = "Durum@Prolog Aliemus 0_1_4_2"
  },
  State_24968_Desc = {
    Text = "Savaş başladığında Embriyo Füzyonu +[Blood:DescArg2]; her Direnç tetiklendiğinde Embriyo Füzyonu +[Blood:DescArg2]. Sorel her Hasar verdiğinde, bu tur içinde kendi verdiği Hasar [DescArg1] puan artar."
  },
  State_24968_Name = {
    Text = "Taç Mücevheri"
  },
  State_2496_Desc = {
    Text = "Tur başında, [Arg1] HP yenile. HP %50’nin altındaysa, bunun yerine [Arg2] HP yenile."
  },
  State_2496_Name = {
    Text = "Kutsanmış kan"
  },
  State_24976_Desc = {
    Text = "\"Şişkin Ay Nedimesi\" Uyanış’a geçti. Özel yemeklerinin vereceği zarara dikkat et!"
  },
  State_24976_Name = {
    Text = "Karen Uyanış!"
  },
  State_24976_WeaponDesc = {
    Text = "Bir sonraki turun başında, önceki turda kaybedilen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_24977_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_24977_Name = {
    Text = "Uyanmamış"
  },
  State_2497_Desc = {
    Text = "Lily, her tur oynadığın ilk Komut Kartı’nı taklit eder. Eğer bu bir Saldırı kartıysa, Lily +1 saldırı kazanır; bir Savunma kartıysa, Lily canının %10’u kadar bir Kalkan kazanır; diğer Komut Kartlarıysa, Lily kafası karışmış hâlde buraya bir püstül yerleştirir."
  },
  State_2497_Name = {
    Text = "Lily Uyanış!"
  },
  State_2497_WeaponDesc = {
    Text = "Bir sonraki turun başında, önceki turda kaybedilen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_2498_Name = {
    Text = "Lanetli Tavşan Aksesuar"
  },
  State_2498_WeaponDesc = {
    Text = "Kullananın neden olduğu Kalkan Üretimi ve HP Yenilenmesi %6 artar. Eğer kullananın Diyar Ustalığı 50’den büyükse, Kalkan Üretimi ve HP Yenilenmesi ek olarak %6 daha artar."
  },
  State_2499_Name = {
    Text = "Durağanlık Laneti"
  },
  State_2500_Desc = {
    Text = "Gerçek Hasar verirken Zehir uygular."
  },
  State_2500_Name = {Text = "Zehir"},
  State_2501_Desc = {
    Text = "Takıma Özel: Takımın Maksimum HP’si %10 artar. Kuşananın sağladığı İyileştirme ve Karakter Kalkanı <WeaponEffect_Num:[StateArg3]%> artar. Kuşananın \"Darbe\" sini oynadıktan sonra, kaybedilen HP’nin <WeaponEffect_Num:[StateArg1]%>’ini geri kazan. Kuşananın \"Savunma\" sını oynadıktan sonra, mevcut canın <WeaponEffect_Num:[StateArg2]%>’ine eşit Karakter Kalkanı kazan. Bu etki her turda en fazla 1’er kez tetiklenebilir."
  },
  State_2501_Name = {
    Text = "Bir Ruhun Doğuşu"
  },
  State_2501_WeaponDesc = {
    Text = "Takımın Maksimum HP’si +%10. Kullananın İyileştirme ve Kalkan Üretimi <WeaponEffect_Num:[StateArg3]%> artırılır. Kullananın \"Saldırı\" sını oynadıktan sonra, kaybedilen HP’nin [StateArg1]%’ini(<WeaponEffect_Num:[Heal:DescArg1]>) yenile. Kullananın \"Savunma\" sını oynadıktan sonra, mevcut HP’nin [StateArg1]%’ine(<WeaponEffect_Num:[Block:DescArg2]>) eşit Kalkan kazan. Bu etki her tur en fazla 1 kez tetiklenir."
  },
  State_2502_Desc = {
    Text = "Verilen tüm Aktif ve Dokunaç Hasarı -50%."
  },
  State_2502_Name = {
    Text = "Yokoluş Zaafı"
  },
  State_2502_WeaponDesc = {
    Text = "Alınan tüm Hasar %50 azaltılır."
  },
  State_2503_Desc = {
    Text = "Takıma Özel: Kuşananın kartlarının verdiği Temel Hasar <WeaponEffect_Num:[StateArg1]%> artar. Tur başında, kuşananın rastgele bir kartını, ek Tüketme ile ele üretme ihtimali <WeaponEffect_Num:[StateArg2]%>'dir. Mevcut diyar \"Caro\" ise, kuşanan üzerinde \"Embriyo\" kullanmak, bu tur kuşananın bir sonraki \"Darbe\" kartının Hasarının Kritik Oranını <WeaponEffect_Num:+[StateArg3]%> artırır."
  },
  State_2503_WeaponDesc = {
    Text = "Taşıyıcının kartlarının verdiği Temel Hasar <WeaponEffect_Num:[StateArg1]%> artar. Tur başında, taşıyıcının 1 Rastgele kartını ele yerleştirme ve ona Tüketme ekleme şansı <WeaponEffect_Num:[StateArg2]%> olur. Mevcut âlem \"Caro\" ise, taşıyıcıya \"Embriyo\" kullanıldığında, bu turdaki bir sonraki Darbe Kartının Hasarının Krit. Oranı <WeaponEffect_Num:+[StateArg3]%> artar."
  },
  State_2504_Desc = {
    Text = "\"Saldırı\" 2 Arithmetica kazanır ve 1 rastgele kart atar; \"Savunma\" 2 kart çeker ve 1 Arithmetica kaybeder."
  },
  State_25056_Desc = {
    Text = "Arithmetica her Tüketildiğinde, Karen [Layer] Geçici GÜÇ kazanır."
  },
  State_25056_Name = {Text = "Tok"},
  State_25057_Desc = {
    Text = "Karen, her Arithmetica tüketildiğinde [StateArg1] Geçici GÜÇ kazanır ve her turun sonunda 1 yük kaldırılır."
  },
  State_25057_Name = {Text = "Tok"},
  State_2505_Name = {
    Text = "Aksesuar: Nisan Övgüsü"
  },
  State_2505_WeaponDesc = {
    Text = "Savaş başında, Kuşanan Ultra sınıfındaysa, Saldırı gücünü %25 artır."
  },
  State_2507_Desc = {
    Text = "Alındığında Maksimum CP’yi %100 artırır. Tur başında [Arg1] CP kaybedersin."
  },
  State_2509_Name = {
    Text = "Durum@Genel Diyar Ustalığı"
  },
  State_2511_Desc = {
    Text = "Durum @ Prolog Keyflare Eğitimi"
  },
  State_2511_Name = {
    Text = "Durum @ Prolog Keyflare Eğitimi"
  },
  State_2511_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_2"
  },
  State_2512_Desc = {
    Text = "Arithmetica Maliyeti 3 veya daha fazla olan bir kart oynadığında, 1 kart çek ve 1 Arithmetica kazan."
  },
  State_2514_Desc = {
    Text = "Bu Savaşta Karakter Kalkanı Üretimi [Layer] azalır."
  },
  State_2514_Name = {
    Text = "Alert Lowered"
  },
  State_2514_WeaponDesc = {
    Text = "Bu Savaşta Karakter Kalkanı Üretimi [Layer] azalır."
  },
  State_2515_Desc = {
    Text = "[Strike], tüm düşmanlara [StateArg1] yığın Zehir uygular."
  },
  State_2515_Name = {
    Text = "Kalıntı Nörotoksin"
  },
  State_25163_Desc = {
    Text = "Sis kadar ele avuca sığmaz."
  },
  State_25163_Name = {
    Text = "Geçmişin Gölgeleri"
  },
  State_25165_Desc = {
    Text = "Ramona: Yıpranmış Zaman: Ramona’nın Komut Kartı’na özgü ek bir etkidir; 3 yığın Negentropi varken tetiklenir. Döngü bir sonraki Savaşa taşınır."
  },
  State_25165_Name = {
    Text = "<TimeBeacon:Döngü>"
  },
  State_25166_Desc = {
    Text = "3 Negentropi yığınıyla, Ramona: Yıpranmış Zaman’ın Komut Kartlarını kullanmak tüm yığınları tüketir ve ek Döngü etkisini tetikler. (En fazla 3 yığın)"
  },
  State_25166_Name = {
    Text = "<TimeBeacon2:Negentropi>"
  },
  State_2516_Desc = {Text = "Oynanamaz."},
  State_2516_Name = {Text = "Oynanamaz"},
  State_2516_WeaponDesc = {
    Text = "Kart oynanamaz."
  },
  State_25179_Name = {
    Text = "Aliemus Yargısı"
  },
  State_2517_Desc = {
    Text = "Ekibin Yücelişi serbest bıraktıktan sonra, o tur için Güç kaybederiz. Tur başına bir kez."
  },
  State_2517_Name = {
    Text = "Korku Çılgınlığı"
  },
  State_25181_Name = {
    Text = "Reenkarnasyon Koruma Etkisi"
  },
  State_2518_Desc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_1_3"
  },
  State_2518_Name = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_1_3"
  },
  State_2518_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_1_3"
  },
  State_25194_Desc = {
    Text = "Öldükten sonra \"N\" e [DescArg1] Kalkan ve [DescArg2] Kalıcı GÜÇ ver."
  },
  State_2519_Desc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_1_3"
  },
  State_2519_Name = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_1_3"
  },
  State_2519_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_1_3"
  },
  State_25204_Name = {
    Text = "Durum @ N'nin Klonu 2 @ Niyet Değerlendirmesi"
  },
  State_25205_Name = {
    Text = "Durum @ N'nin Klonu 3 @ Niyet Değerlendirmesi"
  },
  State_25206_Name = {
    Text = "Durum@N@N için kopya kontrolü ekle"
  },
  State_25207_Name = {
    Text = "Durum @ N'nin Klonu @ Niyet Değerlendirmesi"
  },
  State_2520_Desc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_1_2"
  },
  State_2520_Name = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_1_2"
  },
  State_2520_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_1_2"
  },
  State_2522_Desc = {
    Text = "Helot Uyandırıldı. Artık daha güçlü saldırılar Serbest Bırakacak!"
  },
  State_2522_Name = {
    Text = "Helot Uyanışı"
  },
  State_2523_Desc = {
    Text = "Tek sayılı turların başında, bu tur için [Arg1] Güç kazan. Çift sayılı turların başında, bu tur için [Arg2] Tetikte olma kazan."
  },
  State_2524_Desc = {
    Text = "Savaşın başında, 1 Güç kazan."
  },
  State_2524_Name = {
    Text = "Uzak Yakın Ün Salmış"
  },
  State_2525_Desc = {
    Text = "Saldırı sayısı -1, [Layer] GÜÇ kazan"
  },
  State_2525_Name = {Text = "Sefahat"},
  State_2527_Name = {
    Text = "Kızıl STR Bonusu"
  },
  State_2528_Desc = {
    Text = "Gerçek Arithmetica Maliyeti 3 olan bir kart oynadığında, 1 kart çek ve 2 Arithmetica kazan."
  },
  State_2529_Desc = {
    Text = "Bu tur Krit. Hasar [Layer]% artar."
  },
  State_2529_Name = {
    Text = "Geçici Kritik Hasar"
  },
  State_2529_WeaponDesc = {
    Text = "Bu tur Krit. Hasar [Layer]% artar."
  },
  State_2531_Desc = {
    Text = "Cinderfire her [Damage:StateArg2] kez Hasar verdiğinde, Tükenme ile bir [Green Flames] elde et."
  },
  State_2531_Name = {
    Text = "Zümrüt Yansıma"
  },
  State_2531_WeaponDesc = {
    Text = "Cinderfire her [Damage:StateArg2] kez Hasar verdiğinde, Tükenme ile bir [Green Flames] elde et."
  },
  State_2532_Name = {
    Text = "Aksesuar: Kızıl Heyecan"
  },
  State_2534_Desc = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_3_3"
  },
  State_2534_Name = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_3_3"
  },
  State_2534_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_3_3"
  },
  State_2535_Desc = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_3_2"
  },
  State_2535_Name = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_3_2"
  },
  State_2535_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_3_2"
  },
  State_2536_Name = {
    Text = "Durum @ Geçici Saldırı Kartı Kritik Hasar Artışı"
  },
  State_2537_Desc = {
    Text = "Ütopya Kılıcı bir kalkan uyguladığında, [StateArg2] Geçici Alarm kazan."
  },
  State_2537_Name = {
    Text = "Savaş Alanının Bilgesi"
  },
  State_2537_WeaponDesc = {
    Text = "Ütopya Kılıcı bir kalkan uyguladığında, [StateArg2] Geçici Alarm kazan."
  },
  State_2538_Desc = {
    Text = "Oynandığında, [StateArg1] <RetaliateIconKeywords:Karşı Atak> kazan, ardından tüm düşmanlara <RetaliateIconKeywords:Karşı Atak> değerinin [StateArg2]%'i kadar Gerçek Hasar ver."
  },
  State_2538_Name = {
    Text = "<Rune_9_High:İleri Diken>"
  },
  State_25391_Desc = {
    Text = "Takımdaki bir Uyanan \"Şanslı Seyirci\" olarak seçildi ve o Uyanan’a ait tüm kartlar \"Tezahürat\" etkisine sahip."
  },
  State_25391_Name = {
    Text = "Şanslı Seyirci"
  },
  State_25392_Desc = {
    Text = "Oynandıktan sonra, %2 Maksimum Can kaybet; büyük sihirbaz bu tur 1 \"Ego Artışı\" yığını kazanır."
  },
  State_25392_Name = {
    Text = "<CardCheerKeywords:Alkış>"
  },
  State_25401_Desc = {
    Text = "Bu kart Elde iken, el sınırı 1 artar."
  },
  State_25401_Name = {
    Text = "El Boyutu Sınırını Yoksay"
  },
  State_25403_Desc = {
    Text = "Dokunaç Hasarı -%50, verilen her Dokunaç Hasarı için [Layer] Karakter Kalkanı kazan."
  },
  State_25403_Name = {
    Text = "Sakin Deniz"
  },
  State_25405_Desc = {
    Text = "Bu kart, koşullar ne olursa olsun daima elinde kalır."
  },
  State_25405_Name = {
    Text = "Kalıcı Olarak Sakla"
  },
  State_25406_Desc = {
    Text = "Bu turun geri kalanında Dokunaç Duruşlarını değiştiremezsin."
  },
  State_25406_Name = {
    Text = "Aequor Çılgınlığı: Kısıtlama"
  },
  State_25407_Desc = {
    Text = "Dokunaç Hasarı -%25, Tur Sonunda Dokunaç -1"
  },
  State_25407_Name = {
    Text = "Derinlik Çılgınlığı"
  },
  State_25415_Desc = {
    Text = "Müfreze serbest bırakıldıktan sonra [Layer] Müfreze Enerjisi kazan."
  },
  State_25415_Name = {
    Text = "Kaos Geçici Keyflare Taşması"
  },
  State_25417_Name = {Text = "Bomba"},
  State_25418_Name = {Text = "Bomba 2"},
  State_2542_Name = {
    Text = "Kalıntı İsimsiz Uzantı Sayacı"
  },
  State_2543_Name = {
    Text = "Durum@Aşama2_14Savaş8Balon1"
  },
  State_2544_Desc = {
    Text = "Durum@Prolog Canavar Pasif"
  },
  State_2544_Name = {
    Text = "Durum@Prolog Canavar Pasif"
  },
  State_2544_WeaponDesc = {
    Text = "Durum@Prolog Canavar Pasif"
  },
  State_2545_Desc = {
    Text = "Savaş başında, Embriyo Füzyonu +%20. Aliemus'u maksimumda olan her Uyandıran için Embriyo Füzyonu ilave +%20 artar."
  },
  State_2547_Desc = {
    Text = "Tur başında, eline [Arg1] Güç veren bir \"Dikenli Üç Dişli Zıpkın\" ekle. Yücelt’i serbest bıraktıktan sonra, elindeki tüm \"Dikenli Üç Dişli Zıpkın\" ların Gücü [Arg2] artar."
  },
  State_2548_Desc = {
    Text = "Bir ölüme karşı Bağışıklık sağlar, tetiklendikten sonra 50 HP yeniler ve bu Hatırayı kalıcı olarak devre dışı bırakır."
  },
  State_2548_Name = {
    Text = "Kalıntı Dublör Bebek"
  },
  State_2548_WeaponDesc = {
    Text = "Bir ölüme karşı Bağışıklık sağlar, tetiklendikten sonra 50 HP yeniler ve bu Hatırayı kalıcı olarak devre dışı bırakır."
  },
  State_2549_Desc = {
    Text = "Aktif ve Dokunaç Hasarını azalt."
  },
  State_2549_Name = {
    Text = "<ExhaustionIconKeywords:KUV▼>"
  },
  State_2549_WeaponDesc = {
    Text = "Her bir Yük Tükeniş, verilen Hasarı ve Dokunaç Hasarını 1 azaltır."
  },
  State_2550_Desc = {
    Text = "Çekildiğinde, kendini 1 tur boyunca Kırılgan yap. Kullanıldığında, tüm düşmanları 1 tur boyunca Savunmasız yap. Satılamaz."
  },
  State_2550_Name = {
    Text = "Lanet Durumu Çöküş"
  },
  State_2550_WeaponDesc = {
    Text = "Çekildiğinde, kendini 1 tur boyunca Kırılgan yap. Kullanıldığında, tüm düşmanları 1 tur boyunca Savunmasız yap. Satılamaz."
  },
  State_2552_Desc = {
    Text = "Kart Atılmış Kart Destesine girmez, bunun yerine elinde kalır."
  },
  State_2552_Name = {
    Text = "<RetainIconKeywords:Sakla>"
  },
  State_2552_WeaponDesc = {
    Text = "Kart Atılmış Kart Destesine girmez, bunun yerine elinde kalır."
  },
  State_2553_Desc = {
    Text = "Tur başında 1 Arithmetica kazan."
  },
  State_2553_Name = {
    Text = "Kalıntı Arcana Arithmetica"
  },
  State_2553_WeaponDesc = {
    Text = "Tur başında 1 Arithmetica kazan."
  },
  State_2554_Name = {
    Text = "Putney sabah postası"
  },
  State_2556_Desc = {
    Text = "Can azaldığında, azalan miktarın [Layer]%’i kadar Karakter Kalkanı kazan."
  },
  State_2556_Name = {
    Text = "Kan Kalkanı"
  },
  State_2556_WeaponDesc = {
    Text = "HP azaldıktan sonra, azalan değerin [Layer]%'ü kadar karakter kalkanı elde et."
  },
  State_2557_Desc = {
    Text = "Sonraki turun başında [Layer] Karakter Kalkanı kazan."
  },
  State_2557_Name = {
    Text = "Izdırap ve Haz Kalkanı"
  },
  State_2558_Desc = {
    Text = "Can %50’nin([StateArg1]) altına düştüğünde, eşit Can’a sahip 2 \"Müdahale Tipi Çözünür\" e bölünür."
  },
  State_2558_Name = {Text = "Bölünme"},
  State_2558_WeaponDesc = {
    Text = "HP %50’nin altına düştüğünde ([StateArg1]), eşit HP’ye sahip 2 \"II-Tip Çözündürülmüş Varlık\"a bölünür."
  },
  State_2559_Desc = {
    Text = "Her saldırıdan sonra [Layer] Geçici GÜÇ kaybedersin."
  },
  State_2559_Name = {
    Text = "Dürtüselliğin Bedeli"
  },
  State_2560_Desc = {
    Text = "Sonraki turun başında [Layer] Karakter Kalkanı elde et."
  },
  State_2560_Name = {
    Text = "İzolasyon Eseri"
  },
  State_2560_WeaponDesc = {
    Text = "Sonraki turun başında [Layer] Karakter Kalkanı elde et."
  },
  State_2561_Desc = {
    Text = "Melankolik Yetenek"
  },
  State_2561_Name = {
    Text = "Melankolik Yetenek"
  },
  State_2561_WeaponDesc = {
    Text = "Melankolik Yetenek"
  },
  State_2562_Name = {
    Text = "Durum@Bölüm 3_Rezonans 1_İşaret"
  },
  State_2563_Desc = {
    Text = "10. kartı oynamak Dokunaç Hasarını 2 artırır ve tüm Dokunaçların bir kez saldırmasını sağlar."
  },
  State_2563_Name = {
    Text = "Kalıntı Dikenli Üç Dişli Mızrak"
  },
  State_2563_WeaponDesc = {
    Text = "10. kartı oynamak Dokunaç Hasarını 2 artırır ve tüm Dokunaçların bir kez saldırmasını sağlar."
  },
  State_2564_Desc = {
    Text = "Kazanılan tüm Karakter Kalkanları [DescArg1]% azalır."
  },
  State_2564_Name = {
    Text = "<FragileColour:Narin>"
  },
  State_2564_WeaponDesc = {
    Text = "Elde edilen tüm Kalkan %33 azaltılır."
  },
  State_2565_Name = {
    Text = "Aksesuar: Kızıl Kucaklayış"
  },
  State_2565_WeaponDesc = {
    Text = "Taşıyıcı hasar verdiğinde 20, Kritik Vuruş yaptığında ise 50 Keyflare kazan. Bu etki tur başına en fazla 3 kez tetiklenebilir."
  },
  State_2566_Desc = {
    Text = "Bir turda 3 saldırı aldıktan sonra, 1 yığın Geçici Delilik kazan."
  },
  State_2566_Name = {
    Text = "\"Tatlı Izdırap\""
  },
  State_2567_Desc = {
    Text = "[Layer] Hasar aldı; 3 kez ulaşıldığında, \"Tatlı Kötücüllük\" bu tur için 1 yığın delilik kazanır."
  },
  State_2567_Name = {
    Text = "\"Tatlı Izdırap\"Sayısı"
  },
  State_2567_WeaponDesc = {
    Text = "[Layer] kez Hasar aldı. 3'e ulaşıldığında, \"Tatlı Şeytan\" bu tur için 1 Delilik yığını elde eder."
  },
  State_2569_Desc = {
    Text = "Bugünün Önerisi Diyar bonus etkisi %50 artar ve seviye başında Diyar Ustalığın 100 artar."
  },
  State_2569_Name = {
    Text = "Durum@Fantazma Gümüş Anahtar: Uyumluluk Ayrılığı"
  },
  State_2570_Desc = {
    Text = "Oynandığında [StateArg1] kart çek."
  },
  State_2570_Name = {
    Text = "<Rune_3:Ustalık>"
  },
  State_2571_Desc = {
    Text = "Takımdaki her [Chaos] Uyanan için, tüm üyelerin Maksimum HP'si (Tamamlanmadı), Savunması ve Saldırısı %50 artar."
  },
  State_2571_Name = {
    Text = "Kaos Bonusu"
  },
  State_2571_WeaponDesc = {
    Text = "Takımdaki her [Chaos] Uyanan için, tüm üyelerin Maksimum HP'si (Tamamlanmadı), Savunması ve Saldırısı %50 artar."
  },
  State_2572_Desc = {
    Text = "Oynandığında, <EmbryoFusionIconKeywords:Embriyo Füzyonu> +[StateArg1]."
  },
  State_2572_Name = {
    Text = "<Rune_12:Kan Hırsı>"
  },
  State_2573_Desc = {
    Text = "[Fuse]’in 5 yığını kazan. Bir kart oynadığında 1 azalır. 0’a ulaştığında kendini patlatır, Saldırı * 2,5 Hasar verir."
  },
  State_2573_Name = {Text = "Bomba"},
  State_2573_WeaponDesc = {
    Text = "[Fuse]’in 5 yığını kazan. Bir kart oynadığında 1 azalır. 0’a ulaştığında kendini patlatır, Saldırı * 2,5 Hasar verir."
  },
  State_2574_Desc = {
    Text = "Krit. Hasar +%50. Bu tur hiçbir Saldırı yapılmazsa, bir sonraki turda Kritik Vuruş garanti edilir."
  },
  State_2574_Name = {
    Text = "Durum@Hayalet Gümüş Anahtar: Rondo"
  },
  State_2575_Desc = {
    Text = "Takıma Özel: Savaşın başında, Kuşananın Komut Kartı Kritik Oranı, sahip olunan her kalıntı için [StateArg1]% artar. Yüceltim kullandıktan sonra, 4 yüzlü bir zar at; Kuşanan, zar sonucunun <WeaponEffect_Num:[StateArg2]> katına eşit Aliemus ve Geçici Kritik Hasar kazanır. Zar sonucu 4 veya daha yüksekse, diğer Uyananlar da bunun yarısını kazanır."
  },
  State_2575_WeaponDesc = {
    Text = "Savaşın başında, her bir Kalıntı, Kuşanan'ın Komut Kartı Krit. Oranını [StateArg1]% artırır. Kuşanan bir Yüceltim serbest bıraktıktan sonra, 4 yüzlü bir zar at; Kuşanan, zar sonucunun <WeaponEffect_Num:[StateArg2]> katı kadar Aliemus ve Geçici Kritik Hasar kazanır. Eğer 4 veya daha yüksek atılırsa, diğer Uyananlar da bunun yarısını kazanır."
  },
  State_2576_Desc = {
    Text = "Her kart Ultra Uzay’a girdiğinde, Arithmetica Maliyeti 1 azalır."
  },
  State_2579_Desc = {
    Text = "Bu turda verilen Aktif Hasar sayısını [Layer] artırır."
  },
  State_2579_Name = {
    Text = "Geçici Delilik"
  },
  State_2580_Desc = {
    Text = "Bir Kafatası Avcısı Cadı kartı Ultra Uzay'a girdiğinde veya çıktığında, 1 Arithmetica kazan."
  },
  State_2580_Name = {
    Text = "Boyutsal Projeksiyon"
  },
  State_2581_Desc = {
    Text = "Tüm Uyananların Keyflare Yenilenmesi 30 artar. Posse serbest bırakıldıktan sonra destesine 3 adet <DerivativeCardKeywords_4:\"Kavrayış\"> karıştır."
  },
  State_2581_Name = {
    Text = "Durum@Krono Sarkaç Kavrayışı"
  },
  State_2582_Desc = {
    Text = "Kuşananın Hasarı, Karakter Kalkanı ve İyileştirmesi +[StateArg1]%. (Geçici)"
  },
  State_2582_Name = {
    Text = "Durum@Proto Lazer Topu Aliemus"
  },
  State_2583_Desc = {
    Text = "Her Aktif Hasar aldığınızda ekibinize bir yığın ekleyin."
  },
  State_2583_Name = {
    Text = "Durum @ İntikamcının Büyük Bıçağı Baş Kesme Hasarı Sayacı"
  },
  State_2583_WeaponDesc = {
    Text = "Her Aktif Hasar aldığınızda ekibinize bir yığın ekleyin."
  },
  State_2584_Desc = {
    Text = "Deste her Karıştırıldığında [Arg1] Güç kazan."
  },
  State_2586_Desc = {
    Text = "Elde edilen tüm Karakter Kalkanları -%25, tur sonunda 1 yığın kaldır."
  },
  State_2586_Name = {
    Text = "<FragileIconKeywords:Kırılgan>"
  },
  State_2586_WeaponDesc = {
    Text = "Elde edilen tüm Kalkan %25 azaltılır."
  },
  State_2587_Desc = {
    Text = "Yara Hasarı ikiye katlanır. Her gerçek Hasar verildiğinde, [Layer] kalkan puanı elde edin."
  },
  State_2587_Name = {
    Text = "\"Gök Yutan Çene\""
  },
  State_2587_WeaponDesc = {
    Text = "Yara Hasarı ikiye katlanır. Her gerçek Hasar verildiğinde, [Layer] kalkan puanı elde edin."
  },
  State_2588_Desc = {
    Text = "Tur sonunda [Layer] <FixedDamage:Saf Hasar> al ve bu durumu kaldır. Can yenilerken, yenilenen miktarın iki katı kadar kanama yığını kaldır."
  },
  State_2588_Name = {
    Text = "Kalıcı<BleedingColour:Kan Akıtma>"
  },
  State_2588_WeaponDesc = {
    Text = "Tur sonunda [Layer] Hasar al ve bu durumu kaldır. Her iyileşme, yığınları yarıya indirir."
  },
  State_2589_Name = {
    Text = "Aksesuar: Bükülmüş İkiz Siyah"
  },
  State_2589_WeaponDesc = {
    Text = "Tek sayılı turların başında, kuşananın \"Vuruş\" kartını Elde Tüketme ve Geçici ile eline ekle."
  },
  State_2590_Desc = {
    Text = "Hareket ettiğinde 10 Kara Mühür kazan"
  },
  State_2590_Name = {
    Text = "Kalıntı Dipsiz Çanta"
  },
  State_2590_WeaponDesc = {
    Text = "Hareket ettiğinde 10 Kara Mühür kazan"
  },
  State_2592_Desc = {
    Text = "Kaybedilen her 1 YP için 1 yığın kaldır. Yığın sayısı 0’a ulaştığında, [DescArg1] Karakter Kalkanı kazan."
  },
  State_2592_Name = {
    Text = "Boyutsal Savunma Duvarı"
  },
  State_2593_Name = {
    Text = "Durum@Kızıl Kan ve Kum İlahisi"
  },
  State_2594_Desc = {
    Text = "Gerçek Hasar vererek Karakter Kalkanı kazan."
  },
  State_2594_Name = {
    Text = "\"Gök Yutan Çene\""
  },
  State_2594_WeaponDesc = {
    Text = "Gerçek Hasar vererek Karakter Kalkanı kazan."
  },
  State_2595_Desc = {
    Text = "Her darbe için [StateArg2] Geçici GÜÇ kazanırsın."
  },
  State_2595_Name = {
    Text = "Bilge Kraliçenin Kılıcı"
  },
  State_2597_Desc = {
    Text = "Tur başında [Layer] kalkan puanı elde et."
  },
  State_2597_Name = {
    Text = "Gecikmeli Kalkan"
  },
  State_2597_WeaponDesc = {
    Text = "Tur başında [Layer] kalkan puanı elde et."
  },
  State_2600_Desc = {
    Text = "Can kaybettiğinde, en düşük Aliemus’a sahip Uyanan 10 Aliemus kazanır. Canını 5 kez kaybettiğinde, 1 Bariyer yığını kazan."
  },
  State_2600_Name = {
    Text = "Krono Sarkaç \"Ayrıştırma\""
  },
  State_2601_Desc = {
    Text = "Çift turlar: Alınan Hasar -%50, Verilen Hasar +%33."
  },
  State_2601_Name = {Text = "Gelgeç"},
  State_2601_WeaponDesc = {
    Text = "Çift turlar: Alınan Hasar -%50, Verilen Hasar +%33."
  },
  State_2602_Desc = {
    Text = "Hedef sensin! Oynandıktan sonra, Ebedi Bağnaz [StateArg1] Geçici GÜÇ kazanır ve bu komuttan Derin Dalış Mührü’nü kaldırır."
  },
  State_2602_Name = {
    Text = "<CardKeyWord:Derin Dalış Mührü>"
  },
  State_2602_WeaponDesc = {
    Text = "Kart oynandıktan sonra, Derin Dalışçı Elit [StateArg1] Geçici GÜÇ kazanır."
  },
  State_2603_Desc = {
    Text = "\"Embriyo\" kartları Elde ise, her Embriyo için bir kez Yutma etkisini tetiklemek üzere hepsini tüket."
  },
  State_2603_Name = {
    Text = "<UnlimitedDevouredIconKeywords:Sonsuz Yutma>"
  },
  State_2604_Desc = {
    Text = "Bu tur Krit. Oranı [Layer]% artar."
  },
  State_2604_Name = {
    Text = "Geçici Kritik Oranı"
  },
  State_2604_WeaponDesc = {
    Text = "Bu tur Krit. Oranı [Layer]% artar."
  },
  State_2605_Desc = {
    Text = "CP %95’in([StateArg1]) altına düştüğünde, eşit CP’ye sahip 2 \"Deneysel Eser\" e bölünür."
  },
  State_2605_Name = {Text = "Bölünme"},
  State_2605_WeaponDesc = {
    Text = "HP %30’un ([StateArg1]) altına indiğinde, HP’si eşit olacak şekilde 3 adet \"II-Tip Çözündürülmüş Varlık Balmumu Heykel Grubu\"na bölünür."
  },
  State_2606_Desc = {
    Text = "CP %90’ın([StateArg1]) altına düştüğünde, eşit CP’ye sahip 2 \"Deneysel Eser\" e bölünür."
  },
  State_2606_Name = {Text = "Bölünme"},
  State_2606_WeaponDesc = {
    Text = "HP %30’un ([StateArg1]) altına indiğinde, HP’si eşit olacak şekilde 3 adet \"II-Tip Çözündürülmüş Varlık Balmumu Heykel Grubu\"na bölünür."
  },
  State_2607_Desc = {
    Text = "Savaşın sonunda 5 Can yenile."
  },
  State_2607_Name = {
    Text = "Şişkin Ay Nedimesi Aydınlanma 3"
  },
  State_2607_WeaponDesc = {
    Text = "Savaşın sonunda 5 Can yenile."
  },
  State_2609_Desc = {
    Text = "CP %30’un([StateArg1]) altına düştüğünde, eşit CP’ye sahip 2 \"Deneysel Eser\" e bölünür."
  },
  State_2609_Name = {Text = "Bölünme"},
  State_2609_WeaponDesc = {
    Text = "HP %30’un ([StateArg1]) altına indiğinde, HP’si eşit olacak şekilde 3 adet \"II-Tip Çözündürülmüş Varlık Balmumu Heykel Grubu\"na bölünür."
  },
  State_2610_Desc = {
    Text = "CP %70’in([StateArg1]) altına düştüğünde, eşit CP’ye sahip 2 \"Deneysel Eser\" e bölünür."
  },
  State_2610_Name = {Text = "Bölünme"},
  State_2610_WeaponDesc = {
    Text = "HP %30’un ([StateArg1]) altına indiğinde, HP’si eşit olacak şekilde 3 adet \"II-Tip Çözündürülmüş Varlık Balmumu Heykel Grubu\"na bölünür."
  },
  State_2611_Desc = {
    Text = "CP %50’nin([StateArg1]) altına düştüğünde, eşit CP’ye sahip 2 \"Deneysel Yaratım\" a bölünür."
  },
  State_2611_Name = {Text = "Bölünme"},
  State_2611_WeaponDesc = {
    Text = "HP %30’un ([StateArg1]) altına indiğinde, HP’si eşit olacak şekilde 3 adet \"II-Tip Çözündürülmüş Varlık Balmumu Heykel Grubu\"na bölünür."
  },
  State_2612_Desc = {
    Text = "Kadim Taklitçi"
  },
  State_2612_Name = {
    Text = "Kadim Taklitçi"
  },
  State_2612_WeaponDesc = {
    Text = "Kadim Taklitçi"
  },
  State_2614_Desc = {
    Text = "Takıma Özel: Kuşananın Komut Kartını oynadıktan sonra, onu Atılmış Kart Desteğinden eline geri döndürme şansı <WeaponEffect_Num:[StateArg1]%> olur. Bu Etki tur başına yalnızca bir kez tetiklenebilir."
  },
  State_2614_WeaponDesc = {
    Text = "Taşıyıcının Komut Kartı oynandığında, onu Atılmış Kart Desteği’nden ele geri döndürme şansı <WeaponEffect_Num:[StateArg1]%>’dir. Bu etki her tur yalnızca bir kez tetiklenir."
  },
  State_2617_Desc = {
    Text = "Sonraki tur başında ekstra [DescArg1] kart çek."
  },
  State_2617_Name = {Text = "Mani"},
  State_2619_Desc = {
    Text = "Bu Savaşta verilen Aktif Hasar [Layer] azaltılır."
  },
  State_2619_Name = {Text = "STR▼"},
  State_2619_WeaponDesc = {
    Text = "Bu savaş boyunca verilen Hasar [Layer] azaltılır."
  },
  State_2620_Desc = {
    Text = "Paslanmış Neşter Kalıntısı"
  },
  State_2620_Name = {
    Text = "Paslanmış Neşter"
  },
  State_2623_Desc = {
    Text = "Tur başında 1 Arithmetica kazan."
  },
  State_2624_Desc = {
    Text = "Oynandığında, tüm düşmanlara [StateArg1] Geçici <ExhaustionIconKeywords:STR▼> uygula."
  },
  State_2624_Name = {
    Text = "<Rune_18:Drenaj>"
  },
  State_2625_Desc = {
    Text = "Sıçrama Etkin iki kez tetiklenir. Ultra Tur’a girildiğinde, tüm düşmanlar 5 Geçici GÜÇ kazanır."
  },
  State_2625_Name = {
    Text = "Kalıntı Kâbus Feneri"
  },
  State_2626_Desc = {
    Text = "Dokunaç Sınırı -1. Tur sonunda, tüm Dokunaçların fazladan 1 kez saldırı yapsın."
  },
  State_2627_Name = {
    Text = "[StateArg1] Keyflare Kazan"
  },
  State_2627_WeaponDesc = {
    Text = "\"Tamamlanmamış Balmumu Heykel\" düğümünde seçilen kartlara Keyflare verilir."
  },
  State_2628_Desc = {
    Text = "\"Tamamlanmamış Balmumu Heykel\" düğümünde kopyalanan kartlar Yakarış etkisi kazanır."
  },
  State_2628_Name = {
    Text = "Durum@İkinci Bölüm_Rezonans 3"
  },
  State_2628_WeaponDesc = {
    Text = "\"Tamamlanmamış Balmumu Heykel\" düğümünde kopyalanan kartlar Yakarış etkisi kazanır."
  },
  State_2629_Desc = {
    Text = "\"Tamamlanmamış Balmumu Heykel\"de bulunur: Kopyalanabilecek Kartların menzili artar."
  },
  State_2629_Name = {
    Text = "Durum@Bölüm 2_Rezonans 2"
  },
  State_2629_WeaponDesc = {
    Text = "\"Tamamlanmamış Balmumu Heykel\" düğümünde kopyalanan kartlar ve asılları \"Doğuştan\" etkisi kazanır."
  },
  State_2630_Desc = {
    Text = "\"Tamamlanmamış Balmumu Heykel\"de kopyalanan kartlar ve asılları \"Sakla\" etkisi kazanır."
  },
  State_2630_Name = {
    Text = "Durum@Bölüm2_Rezonans4"
  },
  State_2630_WeaponDesc = {
    Text = "\"Tamamlanmamış Balmumu Heykel\" düğümünde kopyalanan kartlar ve asılları \"Sakla\" etkisi kazanır."
  },
  State_2631_Desc = {
    Text = "\"Tamamlanmamış Balmumu Heykel\"de bir kart kopyala."
  },
  State_2631_Name = {
    Text = "Durum@Bölüm 2_Rezonans 6"
  },
  State_2631_WeaponDesc = {
    Text = "\"Tamamlanmamış Balmumu Heykel\" düğümünde fazladan bir kart kopyala."
  },
  State_2633_Desc = {
    Text = "Her Aktif Hasar alındığında, [Layer] <plural value=\"[Layer]\" singular=\"tur\" plural=\"tur\"> süreyle ele Tükenme özellikli 1 [Yeşil Alevler] ekle."
  },
  State_2633_Name = {
    Text = "Güve Kapanı Ateşi"
  },
  State_2633_WeaponDesc = {
    Text = "Bir dahaki turunuzdan önce her saldırıya uğradığınızda, elinize bir [Green Flames] ekleyin."
  },
  State_2634_Desc = {
    Text = "Bir kart oynarken [StateArg1] Hasar al ve 1 yığın kaldır. Yığınlar 0’a ulaştığında, daha zayıf bir \"Deniz Yaratığı\"çıkar. Tur sonunda hâlâ Parazitlenmişsen, yığınlara göre HP’si belirlenen bir \"Deniz Yaratığı\"çıkar."
  },
  State_2634_Name = {
    Text = "Parazitlenmiş"
  },
  State_2635_Desc = {
    Text = "Durum@Prolog Saldırı Analizi İşaretçi"
  },
  State_2635_Name = {
    Text = "Durum@Prolog Saldırı Analizi İşaretçi"
  },
  State_2635_WeaponDesc = {
    Text = "Durum@Prolog Saldırı Analizi İşaretçi"
  },
  State_2636_Name = {
    Text = "Durum@Bölüm 4 Rezonans@Sonraki Turda 1 Kart Çek"
  },
  State_2637_Desc = {
    Text = "Tur başında [StateArg1] Arithmetica kazan."
  },
  State_2637_Name = {
    Text = "Kalıntı Can Enjeksiyonu"
  },
  State_2637_WeaponDesc = {
    Text = "Tur başında [StateArg1] Arithmetica kazan."
  },
  State_2639_Desc = {
    Text = "Ölümcül Hasar alındığında, Ölüm Direnci tetiklenip 1 Can ile hayatta kalma ihtimali vardır. Her tetikleniş, bu keşif boyunca Ölüm Direnci yüzdeni ve sonradan kazanılan Ölüm Direnci artışlarını yarıya indirir."
  },
  State_2639_Name = {
    Text = "<DeathResistanceIconKeywords:Ölüm Direnci>"
  },
  State_2640_Name = {
    Text = "Genel etki bir kez daha yinelenir"
  },
  State_2645_Desc = {
    Text = "Durum@Prolog Canavar Pasif 1"
  },
  State_2645_Name = {
    Text = "Durum@Prolog Canavar Pasif 1"
  },
  State_2645_WeaponDesc = {
    Text = "Durum@Prolog Canavar Pasif 1"
  },
  State_2646_Desc = {
    Text = "Durum@Prolog Canavar Pasif 2"
  },
  State_2646_Name = {
    Text = "Durum@Prolog Canavar Pasif 2"
  },
  State_2646_WeaponDesc = {
    Text = "Durum@Prolog Canavar Pasif 2"
  },
  State_2647_Desc = {
    Text = "Durum@Prolog Canavar Pasif 3"
  },
  State_2647_Name = {
    Text = "Durum@Prolog Canavar Pasif 3"
  },
  State_2647_WeaponDesc = {
    Text = "Durum@Prolog Canavar Pasif 3"
  },
  State_2648_Desc = {
    Text = "Durum @ Prolog Canavar Pasif 4"
  },
  State_2648_Name = {
    Text = "Durum @ Prolog Canavar Pasif 4"
  },
  State_2648_WeaponDesc = {
    Text = "Durum @ Prolog Canavar Pasif 4"
  },
  State_2649_Desc = {
    Text = "Durum@Prolog Canavar Pasif 5"
  },
  State_2649_Name = {
    Text = "Durum@Prolog Canavar Pasif 5"
  },
  State_2649_WeaponDesc = {
    Text = "Durum@Prolog Canavar Pasif 5"
  },
  State_2650_Desc = {
    Text = "Durum @ Prolog Canavar Pasif 6"
  },
  State_2650_Name = {
    Text = "Durum @ Prolog Canavar Pasif 6"
  },
  State_2650_WeaponDesc = {
    Text = "Durum @ Prolog Canavar Pasif 6"
  },
  State_2651_Desc = {
    Text = "Durum@Prolog Canavar Pasif 7"
  },
  State_2651_Name = {
    Text = "Durum@Prolog Canavar Pasif 7"
  },
  State_2651_WeaponDesc = {
    Text = "Durum@Prolog Canavar Pasif 7"
  },
  State_2652_Desc = {
    Text = "Durum@Prolog Canavar Pasif 8"
  },
  State_2652_Name = {
    Text = "Durum@Prolog Canavar Pasif 8"
  },
  State_2652_WeaponDesc = {
    Text = "Durum@Prolog Canavar Pasif 8"
  },
  State_2653_Desc = {
    Text = "Durum@Prolog Canavar Pasif 9"
  },
  State_2653_Name = {
    Text = "Durum@Prolog Canavar Pasif 9"
  },
  State_2653_WeaponDesc = {
    Text = "Durum@Prolog Canavar Pasif 9"
  },
  State_2655_Desc = {
    Text = "Engellenmemiş verilen Hasar kadar İyileştirme sağlar. Hasar verildiğinde kaldırılır."
  },
  State_2655_Name = {
    Text = "Yaşam Gücü Emilimi"
  },
  State_2656_Desc = {
    Text = "Sonraki turun başında kaç!"
  },
  State_2656_Name = {Text = "Kaçış"},
  State_2660_Desc = {
    Text = "Savaşın başında Güç kazan, ancak 5 fazladan Hasar al."
  },
  State_2660_Name = {
    Text = "Son Çığlık"
  },
  State_2661_Desc = {
    Text = "Savaşın başında tüm düşmanlar [Arg1] Güç kaybeder."
  },
  State_2662_Name = {
    Text = "Durum@Bölüm_3_Test_Durumu"
  },
  State_2663_Desc = {
    Text = "Çekildiğinde, kendine 1 tur boyunca Zayıflık uygula. Kullanıldığında, tüm düşmanlara 1 tur boyunca Zayıflık uygula. Satılamaz."
  },
  State_2663_Name = {
    Text = "Lanet Durumu Zayıfladı"
  },
  State_2663_WeaponDesc = {
    Text = "Çekildiğinde, kendine 1 tur boyunca Zayıflık uygula. Kullanıldığında, tüm düşmanlara 1 tur boyunca Zayıflık uygula. Satılamaz."
  },
  State_2666_Name = {
    Text = "Tekrarlayan Hançerin Krit. Oranı"
  },
  State_2667_Desc = {
    Text = "Darbe kartı Hasarı [Layer]% artar."
  },
  State_2667_Name = {
    Text = "Vuruş Kartlarının Hasarı Artırıldı"
  },
  State_2667_WeaponDesc = {
    Text = "Darbe kartı Hasarı [Layer]% artar."
  },
  State_2668_Desc = {
    Text = "Saldırıyı [Layer]% artır."
  },
  State_2668_Name = {
    Text = "Evrensel kalıcı saldırı yüzdesini artır"
  },
  State_2668_WeaponDesc = {
    Text = "Saldırıyı [Layer]% artır."
  },
  State_2669_Desc = {
    Text = "Bu savaşta Krit. Hasar [Layer]% artırılır."
  },
  State_2669_Name = {
    Text = "Kritik Hasar"
  },
  State_2670_Desc = {
    Text = "Zayıflık uyguladığında [Arg1] Kalkan kazan; Savunmasızlık uyguladığında [Arg2] Güç kazan. Aynı turda her iki etkiyi de tetiklemek, fazladan [Arg1] Kalkan ve [Arg2] Güç sağlar."
  },
  State_2670_Name = {
    Text = "Yaldızlı Çerçeve"
  },
  State_2671_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_2671_Name = {
    Text = "Uyanmamış"
  },
  State_2672_Desc = {
    Text = "Tur başında, takımına bir yığın [Bondage] uygula."
  },
  State_2672_Name = {Text = "Esaret"},
  State_2672_WeaponDesc = {
    Text = "Tur başında, takımına bir yığın [Bondage] uygula."
  },
  State_2674_Desc = {
    Text = "Bu tur Krit. Oranı [Layer]% artar."
  },
  State_2674_Name = {
    Text = "Geçici Kritik Oranı"
  },
  State_2676_Name = {
    Text = "Aksesuar: Kızıl Heyecan"
  },
  State_2676_WeaponDesc = {
    Text = "Çete salındıktan sonra, taşıyıcı %15 Geçici Kritik Oranı kazanır. Taşıyıcının Mevcut Krit. Hasarı %80’den yüksekse, fazladan %15 Geçici Kritik Oranı elde eder."
  },
  State_2677_Desc = {
    Text = "Her tur, aktif/Dokunaç Saldırılarından alınan ilk 3 Hasar örneği %75 azaltılır."
  },
  State_2677_Name = {
    Text = "\"Ölümsüz Kalıntı\""
  },
  State_2677_WeaponDesc = {
    Text = "Her tur, aktif/Dokunaç Saldırılarından alınan ilk 3 Hasar örneği %75 azaltılır."
  },
  State_2679_Name = {
    Text = "Durum@Bölüm3_Rezonans7_İşaretçi"
  },
  State_2680_Desc = {
    Text = "Kritik Oranı %20 artar. Tur başında Can %25'in altındaysa bu tur Kritik Vuruş garantidir."
  },
  State_2681_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_2681_Name = {
    Text = "Uyanmamış"
  },
  State_2682_Desc = {
    Text = "Kalkan ve İyileştirme Güçlendirmesi %50 artırılır."
  },
  State_2682_Name = {
    Text = "Yabancılaşmış Bahçenin Muhafızı"
  },
  State_2682_WeaponDesc = {
    Text = "Kalkan ve İyileştirme Güçlendirmesi %50 artırılır."
  },
  State_2683_Desc = {
    Text = "Durum yığınları çeken kart."
  },
  State_2683_Name = {Text = "Çek"},
  State_2684_Desc = {
    Text = "Takıma Özel: Kuşanan'ın \"Darbe\"si, 1 Arithmetica kazanmak ve tüm düşmanlarda %10 <IntoxicationIconKeywords:Zehir> tetiklemek için <WeaponEffect_Num:[StateArg1]%> ihtimale sahiptir; mevcut Âlem \"Aequor\" ise, bu etkinin tetiklenmesi 1 Dokunaç'ın bir kez saldırmasına neden olur. Bu etki tur başına yalnızca bir kez etkinleşir."
  },
  State_2684_WeaponDesc = {
    Text = "Kuşanan'ın \"Darbe\"si, 1 Arithmetica kazanmak ve tüm düşmanlarda [DescArg1]% <IntoxicationIconKeywords:Zehir> tetiklemek için <WeaponEffect_Num:[StateArg1]%> ihtimale sahiptir. Mevcut Âlem \"Aequor\" ise, bu etki tetiklendiğinde 1 Dokunaç bir kez saldırır. Bu etki tur başına en fazla 1 kez tetiklenebilir."
  },
  State_2685_Desc = {
    Text = "Zayıflığa Bağışıklık, Kırılganlık ve Savunmasız durumlarına Bağışıklık. Tur sonunda 1 yığın kaldır."
  },
  State_2685_Name = {
    Text = "<BlessingIconKeywords:Lütuf>"
  },
  State_2685_WeaponDesc = {
    Text = "Bu tur müttefiklere uygulanan zayıflatmalara Bağışıklık."
  },
  State_2686_Desc = {
    Text = "Savaş sırasında verilen Geçici kartlar."
  },
  State_2686_Name = {
    Text = "<CardKeyWord:Durum Kartı>"
  },
  State_2687_Desc = {
    Text = "Bu tur Kritik Oranı + %100."
  },
  State_2687_Name = {
    Text = "Geçici Garantili Kritik"
  },
  State_2687_WeaponDesc = {
    Text = "Bu tur Kritik Oranı + %100."
  },
  State_2688_Desc = {
    Text = "Her tur oynanan 3. karttan sonra, \"Kavrayış\" tan 1 kartı Atılmış Kart Destesi’ne yerleştir. Her tur oynanan 6. karttan sonra, Atılmış Kart Destesi’nden 1 \"Kavrayış\"ı ele al."
  },
  State_2689_Desc = {
    Text = "Tur başında 2 kart çek. Ultra kart yuvası kapasitesi 2 artar."
  },
  State_2689_Name = {
    Text = "Kalıntı Düzenbazın Şapkası"
  },
  State_2689_WeaponDesc = {
    Text = "Tur başında 2 kart çek. Ultra kart yuvası kapasitesi 2 artar."
  },
  State_2690_Desc = {
    Text = "Erdem Şövalyesi bir kart oynadığında, [StateArg1] Güç kazanır."
  },
  State_2690_Name = {
    Text = "Şövalye Gayreti"
  },
  State_2691_Desc = {
    Text = "Takım Özgünlüğü: kullanan Taşkınlık tetiklendikten sonra <WeaponEffect_Num:[StateArg1]> puan Aliemus ve <WeaponEffect_Num:[StateArg2]> puan S-Enerjisi kazan; her 4 El kartı için 1 kez tekrarla. Mevcut Diyar \"Ultra\" iken kullananın kartı Ultra Uzay'a girdiğinde, kullananın SLD'sinin <WeaponEffect_Num:[StateArg3]%>'ine eşit Geçici GÜÇ kazan; her turda en fazla 2 kez tetiklenebilir."
  },
  State_2691_WeaponDesc = {
    Text = "Taşıyıcı Yüceltmeyi serbest bıraktıktan sonra, eldeki her 4 kart için bir kez tekrar ederek <WeaponEffect_Num:[StateArg1]> Aliemus ve <WeaponEffect_Num:[StateArg2]> Keyflare kazan. Mevcut Âlem \"Ultra\" ise, taşıyıcının kartları Ultra Uzay'a girdikten sonra, tur başına en fazla 2 kez tetiklenmek üzere <WeaponEffect_Num:[Power:DescArg1]> Geçici GÜÇ kazan."
  },
  State_2693_Desc = {
    Text = "Durum@Prolog Aliemus 0_1_2 Etki"
  },
  State_2693_Name = {
    Text = "Durum@Prolog Aliemus 0_1_2 Etki"
  },
  State_2693_WeaponDesc = {
    Text = "Durum@Prolog Aliemus 0_1_2 Etki"
  },
  State_2694_Desc = {
    Text = "Tüketilen her Kara Mühür için, tüm Uyananlar 1 Aliemus elde eder."
  },
  State_2694_Name = {
    Text = "Kalıntı Ters Çiçek Durumu"
  },
  State_2694_WeaponDesc = {
    Text = "Tüketilen her Kara Mühür için, tüm Uyananlar 1 Aliemus elde eder."
  },
  State_2695_Desc = {
    Text = "Bir Uyanışçı’ya ait her kart Ultra Uzay’a girdiğinde, ilgili Uyanışçı 15 Aliemus kazanır."
  },
  State_2696_Desc = {
    Text = "Durum@Prolog Aliemus 0_1_2 Aktif"
  },
  State_2696_Name = {
    Text = "Durum@Prolog Aliemus 0_1_2 Aktif"
  },
  State_2696_WeaponDesc = {
    Text = "Durum@Prolog Aliemus 0_1_2 Aktif"
  },
  State_2698_Name = {
    Text = "Sonraki turun başında +1 Aritmetika Kazan."
  },
  State_2699_Name = {
    Text = "Sonraki turun başında +2 Aritmetika Kazan."
  },
  State_2701_Desc = {
    Text = "Derinlerin Hanımefendisi, bir kalkan elde ettiğinizde [StateArg1] Geçici Dokunaç Hasarı artırır."
  },
  State_2701_Name = {
    Text = "Yaratılmış Varlık"
  },
  State_2701_WeaponDesc = {
    Text = "Derinlerin Hanımefendisi, bir kalkan elde ettiğinizde [StateArg1] Geçici Dokunaç Hasarı artırır."
  },
  State_2702_Desc = {
    Text = "Alındığında %100 Ölüm Direnci kazan. Ölüm Direnci tetiklendikten sonra, bu savaşta tur başında [Arg1] HP yenile."
  },
  State_2702_Name = {
    Text = "Hayat üfleyici"
  },
  State_2703_Desc = {
    Text = "Her tur oynanan ilk Uyanışçı kartının Geçici kopyası bir Boyutsal Yarık’a girer; tehlike anında öz koruma için kullanılabilir!"
  },
  State_2703_Name = {
    Text = "Boyutsal Yarık"
  },
  State_2705_Desc = {Text = "—"},
  State_2705_Name = {
    Text = "Sana İntikam"
  },
  State_2705_WeaponDesc = {Text = "—"},
  State_2706_Desc = {
    Text = "Kademeli Taşlaşma Tespiti"
  },
  State_2706_Name = {
    Text = "Kademeli Taşlaşma Tespiti"
  },
  State_2706_WeaponDesc = {
    Text = "Kademeli Taşlaşma Tespiti"
  },
  State_2707_Desc = {
    Text = "Bu tur, Dokunaç tüm düşmanlara Saldırı yapar."
  },
  State_2707_Name = {
    Text = "Dokunaç Topyekûn Saldırı"
  },
  State_2707_WeaponDesc = {
    Text = "Bu tur, Dokunaç tüm düşmanlara Saldırı yapar."
  },
  State_2708_Desc = {
    Text = "Dokunaç Sınırı 1 artar. HP %50'nin altındayken Dokunaç Hasarı [StateArg1] artar."
  },
  State_2708_Name = {
    Text = "Mutasyona Uğramış Geçmişin Yadigârı"
  },
  State_2708_WeaponDesc = {
    Text = "Dokunaç Sınırı 1 artar. HP %50'nin altındayken Dokunaç Hasarı [StateArg1] artar."
  },
  State_2709_Desc = {
    Text = "Paslanmış Neşter Hatırası Sayısı"
  },
  State_2710_Desc = {Text = "Damga"},
  State_2710_Name = {Text = "Damga"},
  State_2710_WeaponDesc = {Text = "Damga"},
  State_2711_Desc = {
    Text = "Kartın Aritmetika değerini geçici olarak değiştir"
  },
  State_2711_Name = {
    Text = "Kartın Aritmetika değerini geçici olarak değiştir"
  },
  State_2711_WeaponDesc = {
    Text = "Kartın Aritmetika değerini geçici olarak değiştir"
  },
  State_2712_Desc = {
    Text = "Karakter Kalkanı üretimini artır."
  },
  State_2712_Name = {
    Text = "<AlertIconKeywords:Uyarı>"
  },
  State_2712_WeaponDesc = {
    Text = "Kazanılan Karakter Kalkanı’nı artırır."
  },
  State_2713_Desc = {
    Text = "İntikam Kılıcı her tur Güç kazanır."
  },
  State_2713_Name = {
    Text = "Golyat Uyanışı"
  },
  State_2713_WeaponDesc = {
    Text = "Bir sonraki turun başında, önceki turda kaybedilen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_2715_Desc = {
    Text = "Bu aşamada Karakter Kalkanı Üretimi [Layer] artar."
  },
  State_2715_Name = {
    Text = "Kalıcı Tetikte"
  },
  State_2715_WeaponDesc = {
    Text = "Bu aşamada Karakter Kalkanı Üretimi [Layer] artar."
  },
  State_2718_Desc = {
    Text = "Takıma Özel: Tur sonunda, Kuşanan, Keyflare Yenilenmesine eşit miktarda <WeaponEffect_Num:[StateArg1]> Aliemus ve Keyflare kazanır."
  },
  State_2718_WeaponDesc = {
    Text = "Tur sonunda, Kuşanan <WeaponEffect_Num:[StateArg1]> Aliemus ve Kuşananın Keyflare Yenilenmesine eşit Keyflare kazanır."
  },
  State_2720_Desc = {
    Text = "Gerçek Hasar verdikten sonra, en yüksek Aliemus'a sahip Uyanan'ın Aliemus'unu 10 azalt."
  },
  State_2720_Name = {
    Text = "Gelip Geçici"
  },
  State_2720_WeaponDesc = {
    Text = "Gerçek Hasar verdikten sonra, en yüksek Aliemus'a sahip Uyanan'ın Aliemus'unu 10 azalt."
  },
  State_2721_Name = {
    Text = "Durum@Seviye2_9Savaş5Balon1"
  },
  State_2722_Desc = {
    Text = "Oynandığında, Çekme Desteğine [StateArg1] adet <DerivativeCardKeywords_4:\"Kavrayış\"> karıştır."
  },
  State_2722_Name = {
    Text = "<Rune_17_High:İleri Kavrayış>"
  },
  State_2723_Desc = {
    Text = "Oynandığında, tüm düşmanlara [StateArg1] tur boyunca <VulnerabilityIconKeywords:Savunmasız> uygula."
  },
  State_2723_Name = {
    Text = "<Rune_1_High:Gelişmiş Savunmasız>"
  },
  State_2724_Desc = {
    Text = "Saldırı sayısını 1 artır."
  },
  State_2724_Name = {
    Text = "Hayalet Çekirdek Karşı Saldırı"
  },
  State_2726_Desc = {
    Text = "Oynandığında, tüm düşmanlara [StateArg1] <IntoxicationIconKeywords:Poison> uygula, ardından her düşmanın <IntoxicationIconKeywords:Poison> değerinin [StateArg2]%’sini tetikle."
  },
  State_2726_Name = {
    Text = "<Rune_10_High:İleri Toksin>"
  },
  State_2727_Desc = {
    Text = "Ölümün eşiğindeyken 1 Can iyileştir ve bu Durumu kaldır."
  },
  State_2727_Name = {Text = "Sebat"},
  State_2727_WeaponDesc = {
    Text = "Ölümün eşiğindeyken 1 Can iyileştir ve bu Durumu kaldır."
  },
  State_2728_Desc = {
    Text = "Tur başında, diğer her dost birim için 1 yığın <ParcloseIconKeywords:Bariyer> kazan."
  },
  State_2728_Name = {
    Text = "Bağlantı Bariyeri"
  },
  State_2728_WeaponDesc = {
    Text = "Tur başında, her başka dost birim için Maksimum HP'nin [Layer]%'üne eşit Kalkan kazan."
  },
  State_2729_Desc = {
    Text = "Tetiklendiğinde, Uyandıran’a karşılık gelen bir kart çek."
  },
  State_2729_Name = {
    Text = "Mutasyona Uğramış Uzay Sapma Cihazı Çekişi"
  },
  State_2729_WeaponDesc = {
    Text = "Tetiklendiğinde, Uyandıran’a karşılık gelen bir kart çek."
  },
  State_2730_Desc = {
    Text = "Ölüm anında Hydra, \"Yılan Manipülasyonu\" durumunun 1 yığınını azaltır."
  },
  State_2730_Name = {Text = "Soydaş"},
  State_2732_Desc = {
    Text = "Durum@Prolog Aliemus Başlangıç 0_2_3"
  },
  State_2732_Name = {
    Text = "Durum@Prolog Aliemus Başlangıç 0_2_3"
  },
  State_2732_WeaponDesc = {
    Text = "Durum@Prolog Aliemus Başlangıç 0_2_3"
  },
  State_2734_Name = {
    Text = "Sonraki turun başında +1 kart çek"
  },
  State_2735_Desc = {
    Text = "Bu kart oynandıktan sonra \"Boyut Mekiği\"ni tetiklerse veya şu anda bir Ultra Tur'daysa, sonraki etkiyi tetikle."
  },
  State_2735_Name = {
    Text = "<TransitionIconKeywords:Sıçrama>"
  },
  State_2735_WeaponDesc = {
    Text = "Şu anda bir Ultra Tur içindeysen, Sıçrama etkileri tetiklenebilir."
  },
  State_2737_Desc = {
    Text = "Takımının destesinin sıfırlandığı her seferde [Layer] GÜÇ kazanırsın."
  },
  State_2737_Name = {
    Text = "Ebedi Donma"
  },
  State_2738_Name = {
    Text = "Zayıflık Etkisi Artışı"
  },
  State_2740_Desc = {
    Text = "\"Tamamlanmamış Balmumu Heykel\" düğümünde kopyalanan kartlar ve onların asılları Arithmetica Maliyeti -1 alır ve bir Semptom kartı kazanır."
  },
  State_2740_Name = {
    Text = "Durum@İkinciBölüm_Rezonans5_2"
  },
  State_2740_WeaponDesc = {
    Text = "\"Tamamlanmamış Balmumu Heykel\" düğümünde kopyalanan kartlar ve onların orijinallerinin Arithmetica Maliyeti 1 azalır."
  },
  State_2741_Desc = {
    Text = "\"Tamamlanmamış Balmumu Heykel\" düğümünde kopyalanan kartlar ve onların asılları Arithmetica Maliyeti -1 alır ve bir Semptom kartı kazanır."
  },
  State_2741_Name = {
    Text = "Durum @ İkinci Bölüm_Rezonans 5_1"
  },
  State_2741_WeaponDesc = {
    Text = "\"Tamamlanmamış Balmumu Heykel\" düğümünde kopyalanan kartlar ve onların orijinallerinin Arithmetica Maliyeti 1 azalır."
  },
  State_2742_Desc = {
    Text = "Tik-Tak Adam’ın verdiği her 1 Hasar için [StateArg2] Geçici GÜÇ kazan; her 1 Kalkan için [StateArg3] Geçici Alarm elde et."
  },
  State_2742_Name = {
    Text = "Parametre Uyumu"
  },
  State_2744_Desc = {
    Text = "Bir Uyanan'a ait her kart Ultra Uzay'a girdiğinde, 15 Aliemus kazanır."
  },
  State_2744_Name = {
    Text = "Kalıntı Sıçrama Cihazı"
  },
  State_2744_WeaponDesc = {
    Text = "Bir Uyanan'a ait her kart Ultra Uzay'a girdiğinde, 15 Aliemus kazanır."
  },
  State_2746_Desc = {
    Text = "Saldırı sayısı +1, [Layer] GÜÇ kaybet"
  },
  State_2746_Name = {
    Text = "Huzursuzluk"
  },
  State_2747_Desc = {
    Text = "Oynandığında, diğer tüm Uyananların Aliemus’unu <Energy:[StateArg1]> artır."
  },
  State_2747_Name = {
    Text = "<Rune_16:Katalizör>"
  },
  State_2748_Desc = {
    Text = "Durum@Fener Töreni"
  },
  State_2748_Name = {
    Text = "Durum@Fener Töreni"
  },
  State_2748_WeaponDesc = {
    Text = "Durum@Fener Töreni"
  },
  State_2749_Desc = {
    Text = "Bu tur, Dokunaç Hasarı verdikten sonra, hedefe [Layer] yığın Zehir uygula."
  },
  State_2749_Name = {
    Text = "Derin Akıntılar"
  },
  State_2750_Desc = {
    Text = "Benimle birlikte denizin dibine bat..."
  },
  State_2750_Name = {
    Text = "Nymphaea Uyanışı"
  },
  State_2752_Desc = {
    Text = "Nilüfer hasar verdiğinde, [StateArg2] Aliemus elde et."
  },
  State_2752_Name = {
    Text = "Kederde Boğulmak"
  },
  State_2752_WeaponDesc = {
    Text = "Nilüfer hasar verdiğinde, [StateArg2] Aliemus elde et."
  },
  State_2753_Desc = {
    Text = "Tur başında Can [Arg1] üzerindeyse, [Arg1] Can kaybet, bu tur için [Arg2] Güç ve [Arg3] Tetikte ol kazan."
  },
  State_2754_Name = {
    Text = "Durum @ Geçici Saldırı Kartı Kritik Oranı Artışı"
  },
  State_2757_Desc = {
    Text = "Sonraki tur başında ekstra [DescArg1] Arithmetica kazan."
  },
  State_2757_Name = {Text = "Paranoya"},
  State_2758_Desc = {
    Text = "Tüm HP Yenilenmesi Etkilerin [Arg1] artar ve fazla yenilenme, eşit miktarda Karakter Kalkanı’na dönüştürülür."
  },
  State_2758_Name = {
    Text = "Korunmuş kelebek"
  },
  State_2760_Desc = {
    Text = "Her Sefer Uyandıran bir Yutma gerçekleştirdiğinde, diğer Uyandıranlar 10 Aliemus kazanır."
  },
  State_2762_Desc = {
    Text = "Oynandığında, etkisi [StateArg1] kez fazladan gerçekleşir ve [StateArg2] Kara Mühür alırsın. (Bu Yakarış ayrıca karta <DepleteIconKeywords:Tüketme> ve <GuyouKeywords:Doğuştan> ekler.)"
  },
  State_2762_Name = {
    Text = "<Rune_7_High:İleri Yankı>"
  },
  State_2762_WeaponDesc = {
    Text = "Oynandıktan sonra, ek olarak [StateArg1] kez daha Etki gösterir. Tüketme."
  },
  State_2763_Desc = {
    Text = "Uyuyan Hükümdar her 1 Arithmetica tükettiğinde, [StateArg1] Dokunaç Hasarı artır."
  },
  State_2763_Name = {
    Text = "Ölümsüz Heybet"
  },
  State_2763_WeaponDesc = {
    Text = "Uyuyan Hükümdar her 1 Arithmetica tükettiğinde, [StateArg1] Dokunaç Hasarı artır."
  },
  State_2764_Desc = {
    Text = "Engellenmeyen Hasar verdiğinde [StateArg1] yığın Kan Akıtma ekler."
  },
  State_2764_Name = {
    Text = "Kötü Niyetli Kan Akıtma"
  },
  State_2765_Name = {
    Text = "Durum@George@Ölüm üzerine iyileştirme"
  },
  State_2767_Name = {
    Text = "Durum@Kara Mühür ve Gümüş Anahtar Şarjı Verimliliği"
  },
  State_2769_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_2769_Name = {
    Text = "Uyanmamış"
  },
  State_2771_Desc = {
    Text = "Canavar Gücü"
  },
  State_2771_Name = {
    Text = "Canavar Gücü"
  },
  State_2772_Name = {
    Text = "Durum@Aşama2_5Savaş3Balon1"
  },
  State_2773_Desc = {
    Text = "Savaş başında, ele 1 adet \"Geçici Güzellik - Elde bulunan tüm Uyanan kartlarını tur sonuna kadar 'Vuruş' ile değiştir. Sakla, Tüketme.\" yerleştir."
  },
  State_2775_Desc = {
    Text = "Dönüşte Çekim Sayısı"
  },
  State_2775_Name = {
    Text = "Çekme Sayısı Restorasyonu"
  },
  State_2776_Name = {
    Text = "Taşlaştıran Gözler Durağanlık Laneti Güçlendirilmiş"
  },
  State_2777_Name = {
    Text = "Durum@Üçüncü Bölüm_Boş Durum"
  },
  State_2778_Desc = {
    Text = "Savaşın başında [Arg1] Karakter Kalkanı kazan. Bu savaşta 7 adet \"Savunma\" oynadıktan sonra, derhal [Arg2] Karakter Kalkanı kazan."
  },
  State_2778_Name = {
    Text = "Putney sabah postası"
  },
  State_2779_Desc = {
    Text = "Can %50’nin([StateArg1]) altına düştüğünde, eşit Can’a sahip 3 \"Müdahale Tipi Çözünür\" e bölünür."
  },
  State_2779_Name = {Text = "Bölünme"},
  State_2779_WeaponDesc = {
    Text = "HP %50’nin altına düştüğünde ([StateArg1]), eşit HP’ye sahip 2 \"II-Tip Çözündürülmüş Varlık\"a bölünür."
  },
  State_2780_Desc = {
    Text = "Oynandığında, [StateArg1] Arithmetica geri kazan."
  },
  State_2780_Name = {
    Text = "<Rune_4:Hesaplama>"
  },
  State_2781_Desc = {
    Text = "Her [Layer] kart oynadığında, eğer Bariyerin yoksa bir yığın <ParcloseIconKeywords:Bariyer> ekle."
  },
  State_2781_Name = {
    Text = "Enerji Bariyeri"
  },
  State_2781_WeaponDesc = {
    Text = "Takımın her [Layer] kart oynadığında, Canavar bir Bariyer yığını yeniler."
  },
  State_2784_Desc = {
    Text = "Ultra Turların dışında bile, her tur bir kez Sıçrama etkisini tetikleyebilirsin. Ultra Uzay kapasitesini 2 artır."
  },
  State_2785_Desc = {
    Text = "Takıma Özel: Kuşanan bir kart oynadıktan sonra, 1 Aliemus puanı kazanır. Savaşın başında, kuşananın Saldırı’sının <WeaponEffect_Num:[StateArg1]%>’i kadar <PowerIconKeywords:STR> kazan; eğer mevcut Âlem \"Aequor\" ise, ayrıca <CardKeyWord:Tentacle DMG>’nin <WeaponEffect_Num:[StateArg2]%>’ini kazan. Sonrasında, her bir sonraki turun başında, kuşananın Saldırı’sının <WeaponEffect_Num:[StateArg3]%>’i kadar <PowerIconKeywords:STR> kazan; eğer mevcut Âlem \"Aequor\" ise, ayrıca <CardKeyWord:Tentacle DMG>’nin <WeaponEffect_Num:[StateArg4]%>’ini kazan."
  },
  State_2785_WeaponDesc = {
    Text = "After the wielder plays a card, the wielder gains 1 Aliemus. At the start of battle, gain <WeaponEffect_Num:[Power:DescArg1]> <PowerIconKeywords:STR>. If the current Realm is \"Aequor,\" additionally gain <WeaponEffect_Num:[DescArg2]> <CardKeyWord:Tentacle DMG>. After the start of each subsequent turn, gain <WeaponEffect_Num:[Power:DescArg3]> <PowerIconKeywords:STR>. If the current Realm is \"Aequor,\" additionally gain <WeaponEffect_Num:[DescArg4]> <CardKeyWord:Tentacle DMG>."
  },
  State_2786_Name = {
    Text = "Kalıntı Kanlı Çakıl Taşı Sayacı"
  },
  State_2787_Desc = {
    Text = "HP Yenilenmesi, Atılmış Kart Destesi'ne 1 [Illusion's End] karıştır. Kalıcı, İmha Et."
  },
  State_2787_Name = {
    Text = "<CardKeyWord:Hakikat Arayışı>"
  },
  State_2787_WeaponDesc = {
    Text = "HP Yenilenmesi, Atılmış Kart Destesi'ne 1 [Illusion's End] karıştır. Kalıcı, İmha Et."
  },
  State_2788_Desc = {
    Text = "Tur başında [StateArg1] kart çek."
  },
  State_2788_Name = {
    Text = "Kalıntı Kâhinin Dilek Lambası 1"
  },
  State_2788_WeaponDesc = {
    Text = "Tur başında [StateArg1] kart çek."
  },
  State_2789_Desc = {
    Text = "Kart Jenkin tarafından kurcalandı! Oynandığında [Layer] <FixedDamage:Saf Hasar> al."
  },
  State_2789_Name = {
    Text = "<CardKeyWord:Oynandığında [Layer] Hasar Alır>"
  },
  State_2789_WeaponDesc = {
    Text = "Kart oynandığında [StateArg1] hasar alır."
  },
  State_2790_Desc = {
    Text = "Turunun sonunda, elinde [StateArg1] kartı saklamayı seçebilirsin."
  },
  State_2790_Name = {
    Text = "Kalıntı Kâhinin Dilek Lambası 2"
  },
  State_2790_WeaponDesc = {
    Text = "Turunun sonunda, elinde [StateArg1] kartı saklamayı seçebilirsin."
  },
  State_2792_Desc = {
    Text = "Savaşın başında tüm müttefikler [Waxed Armor]'in 3 yığını kazanır. Tur başında, takımının Çekme Desteğine bir [Convulsion] karıştır."
  },
  State_2792_Name = {
    Text = "\"Balmumu Hanımefendi\""
  },
  State_2792_WeaponDesc = {
    Text = "Savaşın başında tüm müttefikler [Waxed Armor]'in 3 yığını kazanır. Tur başında, takımının Çekme Desteğine bir [Convulsion] karıştır."
  },
  State_2793_Desc = {
    Text = "Durum@Taş Göz'ün Son Çırpınışı"
  },
  State_2793_Name = {
    Text = "Durum@Taş Göz'ün Son Çırpınışı"
  },
  State_2793_WeaponDesc = {
    Text = "Durum@Taş Göz'ün Son Çırpınışı"
  },
  State_2796_Desc = {
    Text = "HP kaybettiğinde, tüm düşmanlara [Arg1] yığın Zehir uygula. Zehir değeri her tur [Arg2] artar."
  },
  State_2797_Desc = {
    Text = "Tur başında, bu tur elde edilen [Arg1] Uyanıklığa sahip bir \"Güneş Şemsiyesi\" eline ekle. 6 Kart oynadıktan sonra, elindeki tüm \"Güneş Şemsiyeleri\"nin Uyanıklığını [Arg2] artır."
  },
  State_2798_Desc = {
    Text = "Sevgi Dolu Baş Rahip, Kalkan uyguladığında elindeki 1 Rastgele kartın Arithmetica Maliyetini, oynanana dek 1 azaltır."
  },
  State_2798_Name = {
    Text = "Ulu Baba'nın Merhameti"
  },
  State_2798_WeaponDesc = {
    Text = "Sevgi Dolu Baş Rahip, Kalkan uyguladığında elindeki 1 Rastgele kartın Arithmetica Maliyetini, oynanana dek 1 azaltır."
  },
  State_2799_Desc = {
    Text = "Denizanası Ayı Aktif Hasar verdiğinde, hedefe [StateArg1] Dokunaç saldırısı tetikler."
  },
  State_2799_Name = {
    Text = "Kendini Çoğaltma"
  },
  State_2799_WeaponDesc = {
    Text = "Hydromedusa Hasar verdiğinde, hedef üzerinde [StateArg1] Dokunaç Saldırısı tetikler."
  },
  State_2800_Desc = {
    Text = "Kuşananın Hasarı, Karakter Kalkanı ve İyileştirmesi +[StateArg1]%. (Geçici)"
  },
  State_2800_Name = {
    Text = "Durum@Prototip Hançer Kritik Hasar"
  },
  State_2801_Desc = {
    Text = "Gerçek Hasar aldığında Derin Çözünme yığınlarını artır."
  },
  State_2801_Name = {
    Text = "Hasar almak Çözünme yığınlarını artırır."
  },
  State_2801_WeaponDesc = {
    Text = "Gerçek Hasar aldığında Derin Çözünme yığınlarını artır."
  },
  State_2802_Desc = {
    Text = "Tur başında Geçici GÜÇ Kazan"
  },
  State_2802_Name = {
    Text = "Geçici GÜÇ Kazan"
  },
  State_2804_Desc = {
    Text = "Kuşananın Hasarı, Karakter Kalkanı ve İyileştirmesi +[StateArg1]%. (Geçici)"
  },
  State_2804_Name = {
    Text = "Durum@Prototip Lazer Topu Kritik Hasar"
  },
  State_2805_Desc = {
    Text = "Tur sonunda, diğer müttefikler Güç kazanır."
  },
  State_2805_Name = {
    Text = "\"Aydınlanma Ateşi\""
  },
  State_2807_Desc = {
    Text = "Tur başında, bu tur elde edilen [Arg1] Uyanıklığa sahip bir \"Güneş Şemsiyesi\" eline ekle. 6 Kart oynadıktan sonra, elindeki tüm \"Güneş Şemsiyeleri\"nin Uyanıklığını [Arg2] artır."
  },
  State_2808_Desc = {
    Text = "Tur sonunda, 1 Füzyon Seviyesi üret. Elde bir Embriyo kartı varsa, 15 HP yenile."
  },
  State_2808_Name = {
    Text = "Mutasyonlu Hemostat"
  },
  State_2808_WeaponDesc = {
    Text = "Tur sonunda, 1 Füzyon Seviyesi üret. Elde bir Embriyo kartı varsa, 15 HP yenile."
  },
  State_2809_Desc = {
    Text = "Alındığında kalıcı olarak [Arg1] Güç kaybedersin. Her Hasar verdiğinde [Arg2] Can iyileşirsin, tur başına en fazla 6 kez."
  },
  State_2809_Name = {
    Text = "Taşemren öpücüğü"
  },
  State_2810_Desc = {
    Text = "Tur sonunda, Maksimum CP'nin [Layer]%'i kadarını yeniler."
  },
  State_2810_Name = {
    Text = "Kendini İyileştirme"
  },
  State_2810_WeaponDesc = {
    Text = "Canavarın turu sonunda maksimum canın %[Layer] kadarını yenile"
  },
  State_2811_Desc = {
    Text = "Bir Semptom kartı çekildiğinde [Arg1] Güç kazan. Sahip olunan her lanetli Orison veya Lanetli Kalıntı için, Krit. Oranı ve Krit. Hasar %10 artar."
  },
  State_2812_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_2812_Name = {
    Text = "Uyanmamış"
  },
  State_2813_Desc = {
    Text = "Tur başında Arithmetica kaybet"
  },
  State_2813_Name = {
    Text = "Hesap Hatası!"
  },
  State_2814_Desc = {
    Text = "Savaşı kazandığında, Yakarış güçlü ve tehlikeli bir lanetli Yakarışa dönüşür."
  },
  State_2817_Desc = {
    Text = "Her yığın, alınan Hasarı [StateArg1] azaltır. Her Kritik Vuruşta 1 yığın kaybedilir."
  },
  State_2817_Name = {
    Text = "Balmumu Zırh"
  },
  State_2817_WeaponDesc = {
    Text = "Anormal durumlara Bağışıklık, kritik darbe alındığında kaldırılır."
  },
  State_2818_Desc = {
    Text = "Çözünme Üçgeni A ve Çözünme Üçgeni B’ye bölünür."
  },
  State_2818_Name = {Text = "Bölünme"},
  State_2818_WeaponDesc = {
    Text = "Çözünme Üçgeni A ve Çözünme Üçgeni B’ye bölünür."
  },
  State_2820_Desc = {
    Text = "Oynandığında, önce [StateArg1] Geçici <PowerIconKeywords:STR> kazan, ardından kartın etkilerini çözümlendir. (Hasar etkileri bu STR’den fayda sağlar.)"
  },
  State_2820_Name = {
    Text = "<Rune_15:Patlama>"
  },
  State_2821_Name = {
    Text = "Hassasiyete geçici bağışıklık"
  },
  State_2823_Desc = {
    Text = "Takım Özgünlüğü: Savaş başlangıcında ön sıradaki düşmanlara 2 kat <VulnerabilityIconKeywords:Savunmasız> uygular. Tur başında, Savunmasız durumundaki düşmanlar kullananın SLD'sinin <WeaponEffect_Num:[StateArg1]%>'si kadar Geçici <PowerIconKeywords:Güç> kaybeder. Mevcut Diyar \"Caro\" ise kullanan \"Taşkınlık\" kullandıktan sonra Embriyo Füzyonu +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2823_WeaponDesc = {
    Text = "Savaş başlangıcında ön sıradaki düşmanlara 2 kat <VulnerabilityIconKeywords:Savunmasız> uygular. Tur başında, Savunmasız durumundaki düşmanlar <WeaponEffect_Num:[Power:DescArg1]> puan Geçici <PowerIconKeywords:Güç> kaybeder. Mevcut Diyar \"Caro\" ise kullanan \"Taşkınlık\" kullandıktan sonra Embriyo Füzyonu +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2825_Desc = {
    Text = "Canavar Ultra Yuva Sınırı"
  },
  State_2825_Name = {
    Text = "Canavar Ultra Yuva Sınırı"
  },
  State_2825_WeaponDesc = {
    Text = "Canavar Ultra Yuva Sınırı"
  },
  State_2826_Desc = {
    Text = "Öncekinden daha düşük Arithmetica Maliyetine sahip 2 kart art arda oynandığında, en düşük Aliemus’a sahip Uyanışçı 50 Aliemus kazanır."
  },
  State_2826_Name = {
    Text = "Yaratım Arcana Kalıntısı"
  },
  State_2827_Desc = {
    Text = "Vuruş Sayısı ve Hasar Artışı."
  },
  State_2827_Name = {
    Text = "<CardKeyWord:Yükseltme>"
  },
  State_2829_Desc = {
    Text = "Gerçek Hasar verdikten sonra [Layer] GÜÇ kazan."
  },
  State_2829_Name = {
    Text = "\"Kaotik Kişilik\""
  },
  State_2830_Desc = {
    Text = "Takımda her [Aequor] sınıfı Uyanan için, tüm takımın Maksimum HP'si (Tamamlanmadı), Savunması ve Saldırısı %50 artar."
  },
  State_2830_Name = {
    Text = "Aequor Güçlendirmesi"
  },
  State_2830_WeaponDesc = {
    Text = "Takımda her [Aequor] sınıfı Uyanan için, tüm takımın Maksimum HP'si (Tamamlanmadı), Savunması ve Saldırısı %50 artar."
  },
  State_2832_Desc = {
    Text = "Kuşananın Hasarı, Karakter Kalkanı ve İyileştirmesi +[StateArg1]%. (Geçici)"
  },
  State_2832_Name = {
    Text = "Durum@Prototip Lazer Topu Direnç"
  },
  State_2833_Desc = {
    Text = "Tur başında 1 kart çek. Çekilen her kartın Arithmetica Maliyeti rastgele (0–4) olarak değişir."
  },
  State_2835_Desc = {
    Text = "Her bir Yutma için, tüm düşmanlardan [Arg1] Geçici GÜÇ çal."
  },
  State_2836_Name = {
    Text = "Durum@Lanetli Kör İtaat"
  },
  State_2837_Name = {
    Text = "Durum@Lanetli Kör İtaat"
  },
  State_2838_Name = {
    Text = "Durum@Lanetli Kör İtaat"
  },
  State_2840_Desc = {
    Text = "Tur sonunda [Layer] <FixedDamage:Saf Hasar> al ve yığınların [DescArg1]%'ini kaldır. Can yenilerken, yenilenen miktar kadar Kanama yığınının iki katını kaldır."
  },
  State_2840_Name = {
    Text = "<BleedingColour:Kan Akıtma>"
  },
  State_2840_WeaponDesc = {
    Text = "Tur sonunda [Layer] Hasar al ve bu durumu kaldır. Her iyileşme, yığınları yarıya indirir."
  },
  State_2842_Desc = {
    Text = "Oynandığında, [StateArg1] <RetaliateIconKeywords:Karşı Atak> kazan, ardından tüm düşmanlara <RetaliateIconKeywords:Karşı Atak> değerinin [StateArg2]%'i kadar Gerçek Hasar ver."
  },
  State_2842_Name = {
    Text = "<Rune_9:Diken>"
  },
  State_2843_Desc = {
    Text = "Takımınız, oynanan her kart için [StateArg1] Yığın Kalkan kazanır. 1 tur sürer."
  },
  State_2843_Name = {
    Text = "Uçuşan Tüyler"
  },
  State_2843_WeaponDesc = {
    Text = "Takımınız, oynanan her kart için [StateArg1] Yığın Kalkan kazanır. 1 tur sürer."
  },
  State_2844_Desc = {
    Text = "Her savaşta CP kaybettiğin ilk sefer, 1 Hasarı Engelleme sağlayan bir Bariyer kazan."
  },
  State_2845_Name = {
    Text = "Aksesuar: Mezarlık Mırıltıları"
  },
  State_2845_WeaponDesc = {
    Text = "Seviye başında, Ölüm Direnci %25 artar.\nÖlüm Direnci tetiklendikten sonra, taşıyıcı 50 Aliemus elde eder."
  },
  State_2846_Desc = {
    Text = "Bir kez ölüme karşı Bağışıklık sağlar, tetiklendikten sonra [Arg1] CP yeniler ve bu Hatıra kalıcı olarak devre dışı kalır."
  },
  State_2846_Name = {
    Text = "Vekil bebek"
  },
  State_2847_Desc = {
    Text = "Her avlanan Uyanan bir kart kullandığında, 1 Av İşareti eklenir ve mevcut Av İşareti yığını sayısının yarısı kadar kart çeker."
  },
  State_2847_Name = {Text = "Av Töreni"},
  State_2849_Desc = {
    Text = "Her HP kaybettiğinde, 10 yığına kadar birikerek [Arg1] Güç kazan. Yığın en üst düzeye ulaştığında, kaybedilen HP'nin %25'ini geri kazan."
  },
  State_2849_Name = {Text = "Yüce Onur"},
  State_2853_Desc = {
    Text = "Ebedi Yatar Koltuk Hatırası Sayısı"
  },
  State_2854_Desc = {
    Text = "Uyananlar için ölümden sonra Aliemus yok."
  },
  State_2854_Name = {Text = "Bencil"},
  State_2854_WeaponDesc = {
    Text = "Uyananlar için ölümden sonra Aliemus yok."
  },
  State_2855_Desc = {
    Text = "\"Darbe\" Hasarı [StateArg1]% artar, [Layer] tur sürer."
  },
  State_2855_Name = {
    Text = "Çıkmazda Hayatta Kalma: Darbe"
  },
  State_2855_WeaponDesc = {
    Text = "Bu tur, Darbe Kartlarının Hasarı [Layer]% artar."
  },
  State_2856_Desc = {
    Text = "Takıma Özel: Kuşananın Karakter Kalkanı Üretimi +<WeaponEffect_Num:[StateArg1]%>. Karakter Kalkanı üretirken, tüm müttefikler <WeaponEffect_Num:[StateArg3]%> Geçici Kritik Oranı ve kuşananın Keyflare Yenilenmesinin <WeaponEffect_Num:[StateArg4]%>'i kadar Keyflare kazanır; tur başına en fazla 2 kez. Mevcut diyar \"Aequor\" ise, her Dokunaç Saldırısı gerçekleştiğinde, kuşanan 1 Aliemus puanı kazanır; tur başına en fazla <WeaponEffect_Num:[StateArg2]>."
  },
  State_2856_WeaponDesc = {
    Text = "The wielder's Shield Generation increases by <WeaponEffect_Num:[StateArg1]％>. When Shield is generated, all allies gain <WeaponEffect_Num:[StateArg3]％> Temporary Crit. Rate and <WeaponEffect_Num:[StateArg4]%> of the wielder's Keyflare Regen as Keyflare, up to 2 times per turn. If the current realm is \"Aequor\", each time a Tentacle attacks, the wielder gains 1 Aliemus, up to <WeaponEffect_Num:[StateArg2]> per turn."
  },
  State_2857_Desc = {
    Text = "Tüm Uyananlar, turun başında 10 Aliemus kazanır. Maksimum HP %50 azalır."
  },
  State_2858_Name = {
    Text = "Oynandığında fazladan 2 Bariyer yığını kazan"
  },
  State_2859_Desc = {
    Text = "Savaşın başında, bu Kart elde sabitlenir."
  },
  State_2859_Name = {
    Text = "<CardKeyWord:Doğuştan>"
  },
  State_2860_Desc = {
    Text = "Çekildiğinde, kendi Maksimum HP’ni %10 azalt. Kullanımdan sonra, bu tur için tüm Uyandıranların Krit. Hasarını %100 artır. Satılamaz."
  },
  State_2860_Name = {
    Text = "Lanet Durumu Çözünme"
  },
  State_2860_WeaponDesc = {
    Text = "Çekildiğinde, kendi Maksimum HP’ni %10 azalt. Kullanımdan sonra, bu tur için tüm Uyandıranların Krit. Hasarını %100 artır. Satılamaz."
  },
  State_2861_Name = {
    Text = "(Kalan:[Layer])"
  },
  State_2862_Desc = {
    Text = "Tur sonunda, fazladan bir kez Zehir Hasarı al."
  },
  State_2862_Name = {
    Text = "Fiziksel Zayıflık"
  },
  State_2863_Desc = {
    Text = "Evrim Katmanı"
  },
  State_2863_Name = {
    Text = "Evrim Katmanı"
  },
  State_2863_WeaponDesc = {
    Text = "Evrim Katmanı"
  },
  State_2864_Desc = {
    Text = "\"24\" Uyarıldı. Son \"Beni Kurtar\"ı kullanarak fırsatını yakala!"
  },
  State_2864_Name = {
    Text = "\"24\"Uyanış!"
  },
  State_2864_WeaponDesc = {
    Text = "Bir sonraki turun başında, önceki turda kaybedilen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_2866_Desc = {
    Text = "Takım Özgünlüğü: Maksimum El Boyutu +2, tur sonu kullananın <WeaponEffect_Num:[StateArg1]%> Gümüş Anahtar Şarjı kadar S-Enerjisi kazanır. Her Müfreze kullanımından sonra tüm Uyandırıcılar <WeaponEffect_Num:[StateArg2]> Aliemus kazanır; mevcut Diyar \"Caro\" ise Embriyo Füzyonu <WeaponEffect_Num:+[Blood:StateArg3]> olur."
  },
  State_2866_WeaponDesc = {
    Text = "Maksimum El Boyutu +2, tur sonu <WeaponEffect_Num:[DescArg1]> S-Enerjisi kazanır. Her Müfreze kullanımından sonra tüm Uyandırıcılar <WeaponEffect_Num:[StateArg2]> Aliemus kazanır; mevcut Diyar \"Caro\" ise Embriyo Füzyonu <WeaponEffect_Num:+[Blood:StateArg3]> olur."
  },
  State_2868_Desc = {
    Text = "Tur sonunda, elde oynanmamış her kart için, tüm Uyananlar 2 Ruh kazanır."
  },
  State_2871_Desc = {
    Text = "HP %50’nin altına düştüğünde, eşit HP’ye sahip 1 Çözünme Üçgeni çağır ([StateArg1])"
  },
  State_2871_Name = {Text = "Çağır"},
  State_2871_WeaponDesc = {
    Text = "HP %50’nin altına düştüğünde, eşit HP’ye sahip 1 Çözünme Üçgeni çağır ([StateArg1])"
  },
  State_2874_Desc = {
    Text = "Uyanan, Kafatası Avcısı tarafından gözlemlendiğinde, onun kartını kullanmak fazladan 2 kart çekmeni sağlar."
  },
  State_2875_Desc = {
    Text = "Oynandığında, <EmbryoFusionIconKeywords:Embriyo Füzyonu> +[StateArg1]."
  },
  State_2875_Name = {
    Text = "<Rune_12_High:İleri Kan Hırsı>"
  },
  State_2875_WeaponDesc = {
    Text = "Oynadıktan sonra Embriyo Füzyonu +[Blood:StateArg1]."
  },
  State_2876_Desc = {
    Text = "Savaştan sonra fazladan 50 Kara Mühür elde et, ancak rastgele bir Semptom geliştir."
  },
  State_2877_Desc = {
    Text = "Kırmızılı Madam her Hasar verdiğinde [StateArg2] Geçici GÜÇ kazanır."
  },
  State_2877_Name = {
    Text = "Ev Sahibesinin Ayrıcalığı"
  },
  State_2878_Desc = {
    Text = "Hasar vuruş sayısı 1 artar, ancak Hasar %25 azalır."
  },
  State_2878_Name = {Text = "Vahşet"},
  State_2878_WeaponDesc = {
    Text = "Hasar vuruş sayısı 1 artar, ancak Hasar %25 azalır."
  },
  State_2879_Name = {
    Text = "Tatlı Sümüklüböcek"
  },
  State_2879_WeaponDesc = {
    Text = "\"Yok Oluş\" kullanıldıktan sonra, eğer Sakin Deniz Duruşu’ndaysa, kullananın bu turdaki Kalkan ve İyileştirme etkileri +%30."
  },
  State_2880_Name = {
    Text = "Durum@Deniz Havarisi Aydınlanma 7"
  },
  State_2881_Desc = {
    Text = "Her 1 \"Ayin\" \"Takıntı\"ya dönüştüğünde, bu savaşta Miryam’ın verdiği Temel Hasar %15 artar."
  },
  State_2881_Name = {
    Text = "Yanılsamanın Çöküşü"
  },
  State_2883_Desc = {
    Text = "Takım Özgünlüğü: Kullanan Aktif Hasar verdikten sonra, <WeaponEffect_Num:[StateArg1]%> ihtimalle kullanana ait 1 Komut Kartı çek ve onun Arithmetica Maliyetini 1 azalt. Bu etki tur başına yalnızca bir kez etkinleşir."
  },
  State_2883_WeaponDesc = {
    Text = "Kullanan Aktif Hasar verdikten sonra, <WeaponEffect_Num:[StateArg1]%> ihtimalle kullanana ait 1 Komut Kartı çek ve onun Arithmetica Maliyetini 1 azalt. Bu etki tur başına yalnızca bir kez etkinleşir."
  },
  State_2884_Name = {
    Text = "<PunctureDamagewords:Delici Hasar> ver. Elindeki en yüksek maliyetli kartın Arithmetica Maliyetini 1 azalt."
  },
  State_2885_Name = {
    Text = "Durum: Her tur başında 2 kart çek"
  },
  State_2887_Desc = {
    Text = "Takıma Özel: Kuşanan Exalt’ı kullanmayı bitirdikten sonra, bu turun geri kalanında Krit. Hasarı <WeaponEffect_Num:[StateArg1]%> artar. Bu tur, kuşananın eldeki kartlarının Arithmetica Maliyetini 1 azaltma şansı <WeaponEffect_Num:[StateArg2]%> olur."
  },
  State_2887_WeaponDesc = {
    Text = "Kuşanan Exalt kullandıktan sonra, bu turun geri kalanı için Krit. Hasarı <WeaponEffect_Num:[StateArg1]%> artar. Ayrıca, bu tur boyunca kuşananın elindeki tüm kartların Arithmetica Maliyeti'nin 1 puan azalması için <WeaponEffect_Num:[StateArg2]%> ihtimal vardır."
  },
  State_2888_Desc = {
    Text = "\"Embriyo\" Elde ise, Yutma etkisini tetiklemek için 1 tane tüket."
  },
  State_2888_Name = {
    Text = "<DevouredIconKeywords:Yutma>"
  },
  State_2888_WeaponDesc = {
    Text = "Eldeki embriyoları tüket, güçlü bir Yutma etkisini tetikle."
  },
  State_2889_Name = {
    Text = "Bir Uyandırıcı seç ve ona <Energy:[DescArg1]> Aliemus kazandır."
  },
  State_2890_Desc = {
    Text = "Savaş başladığında, ekibine 1 yığın Kırılgan uygula."
  },
  State_2890_Name = {
    Text = "Zırh Delme"
  },
  State_2890_WeaponDesc = {
    Text = "Savaş başladığında, ekibine 1 yığın Kırılgan uygula."
  },
  State_2891_Name = {
    Text = "Aliemus Başlangıç İyileşme Artışı"
  },
  State_2892_Desc = {
    Text = "Tur sonunda [Layer] HP yenile."
  },
  State_2892_Name = {
    Text = "Gecikmeli HP Yenilenmesi"
  },
  State_2892_WeaponDesc = {
    Text = "Tur sonuna dek, her öldürme için [Layer] CP iyileştir."
  },
  State_2897_Desc = {
    Text = "Köken’in Varışı sırasında, düşmanların Geçici GÜÇ’ünü azalt."
  },
  State_2897_Name = {
    Text = "Korku Çılgınlığı"
  },
  State_2899_Desc = {
    Text = "Rakibin elinde 4 veya daha fazla kart varsa, Hasar aldığında [StateArg1] Karakter Kalkanı kazan."
  },
  State_2899_Name = {
    Text = "Yılan Formu"
  },
  State_2900_Desc = {
    Text = "Bu savaşta verilen Hasar [Layer] artar."
  },
  State_2900_Name = {Text = "Güç"},
  State_2900_WeaponDesc = {
    Text = "Bu savaşta verilen Hasar [Layer] artar."
  },
  State_2901_Desc = {
    Text = "[Exalt] 20 Aliemus verir."
  },
  State_2901_Name = {
    Text = "Kalıntı İsimsiz Tanrının Peçesi"
  },
  State_2901_WeaponDesc = {
    Text = "[Exalt] 20 Aliemus verir."
  },
  State_2902_Desc = {
    Text = "Kavanozdaki Beyin iki kat HP yeniler."
  },
  State_2902_Name = {
    Text = "Ayrılan Et"
  },
  State_2902_WeaponDesc = {
    Text = "Kavanozdaki Beyin iki kat HP yeniler."
  },
  State_2903_Desc = {
    Text = "Kuşananın Hasarı, Karakter Kalkanı ve İyileştirmesi +[StateArg1]%. (Geçici)"
  },
  State_2903_Name = {
    Text = "Durum@Prototip Hançer Kritik"
  },
  State_2904_Desc = {
    Text = "Gerçek Hasar aldıktan sonra 10 Karakter Kalkanı elde et."
  },
  State_2904_Name = {Text = "Tampon"},
  State_2904_WeaponDesc = {
    Text = "Gerçek Hasar aldıktan sonra 10 Karakter Kalkanı elde et."
  },
  State_2905_Desc = {
    Text = "Takıma Özel: Kullanıcının \"Exalt\" ile oluşturduğu kalkan <WeaponEffect_Num:[StateArg2]%> artırılır. Kullanıcı \"Exalt\"ı serbest bıraktıktan sonra, kullanıcının DEF’inin <WeaponEffect_Num:[StateArg1]%>’ine eşit Geçici <PowerIconKeywords:STR> elde eder. Eğer takımınız <FragileIconKeywords:Kırılgan> durumundaysa, etki iki katına çıkar."
  },
  State_2905_WeaponDesc = {
    Text = "Kullananın \"Exalt\"ı Kalkan Üretimini <WeaponEffect_Num:[StateArg2]%> artırır. Kullanan \"Exalt\"ı serbest bıraktıktan sonra, [Power:DescArg1] Geçici <PowerIconKeywords:STR> elde eder. Ekip <FragileIconKeywords:Kırılgan> durumdaysa, etki iki katına çıkar."
  },
  State_2906_Desc = {
    Text = "Gerçek Hasar verdikten sonra, ekibinin Gücünü geçici olarak [Layer] azalt."
  },
  State_2906_Name = {
    Text = "Felç Şoku"
  },
  State_2909_Desc = {
    Text = "[Layer] Aliemus’a sahiptir. Aliemus 5’e eşit veya daha yüksekse niyet \"Çarpık Leş Âlemi\" olur ve Aliemus azaldığında yeniden dolar."
  },
  State_2909_Name = {
    Text = "Durum@Canavar 24 Çarpık Ölülerin Ziyafeti Karşı Saldırı"
  },
  State_2909_WeaponDesc = {
    Text = "[Layer] Aliemus’a sahiptir. Aliemus 5’e eşit veya daha yüksekse niyet \"Çarpık Leş Âlemi\" olur ve Aliemus azaldığında yeniden dolar."
  },
  State_2910_Desc = {
    Text = "Takıma Özel: Keşfin başında desteye bir \"Kavrayış\" ve kullananın \"Vuruş\" kartını ekle. Kullananın \"Vuruş\" Temel Hasarı <WeaponEffect_Num:[StateArg1]%> artar ve oynandıktan sonra %<WeaponEffect_Num:[StateArg2]> ihtimalle 1 kart çekilir. Bu etki tur başına en fazla bir kez tetiklenebilir. Mevcut Âlem \"Ultra\" ise ve Ultra Tur sırasında oynanırsa, \"Vuruş\" elde 1 \"Kavrayış\" oluşturur; bu etki o turda en fazla bir kez tetiklenebilir."
  },
  State_2910_WeaponDesc = {
    Text = "Keşfin başında, desteye bir \"Kavrayış\" kartı ve taşıyıcının \"Darbe\"sini ekle. Taşıyıcının \"Darbe\"sinin Temel Hasarı <WeaponEffect_Num:[StateArg1]%> artar ve oynandıktan sonra 1 kart çekme şansı <WeaponEffect_Num:[StateArg2]%> olur. Bu etki tur başına en fazla 1 kez tetiklenebilir. Mevcut âlem \"Ultra\" ise ve Ultra Tur sırasında, \"Darbe\" elde 1 \"Kavrayış\" yerleştirir; bu etki o turda en fazla 1 kez tetiklenir."
  },
  State_2911_Desc = {
    Text = "Durum@Saf Beyaz Fantazma Dünyasının Karşı Saldırısı"
  },
  State_2911_Name = {
    Text = "Durum@Bembeyaz Fantezi Dünyası Sayacı"
  },
  State_2911_WeaponDesc = {
    Text = "Durum@Saf Beyaz Fantazma Dünyasının Karşı Saldırısı"
  },
  State_2912_Desc = {
    Text = "Hedef sensin! Oynandıktan sonra, Denizci'nin Seçkin Muhafızları [StateArg1] Geçici GÜÇ kazanır ve Derin Dalış Mührü’nü kaldırır."
  },
  State_2912_Name = {
    Text = "<CardKeyWord:Derin Dalış Mührü>"
  },
  State_2912_WeaponDesc = {
    Text = "Kart oynandıktan sonra, Derin Dalışçı Koruma [StateArg1] Geçici GÜÇ elde eder."
  },
  State_2913_Desc = {
    Text = "Savaşın başında, 3 tur boyunca Savunmasız ol."
  },
  State_2913_Name = {
    Text = "Relik Ürkütücü Kanca 2"
  },
  State_2913_WeaponDesc = {
    Text = "Savaşın başında, 3 tur boyunca Savunmasız ol."
  },
  State_2914_Desc = {
    Text = "HP %50'nin altına indiğinde, niyet, HP'si eşit bir [Dissolution Triangle] çağırmaya dönüşür."
  },
  State_2914_Name = {Text = "Bölünme"},
  State_2914_WeaponDesc = {
    Text = "HP %50'nin altına indiğinde, niyet, HP'si eşit bir [Dissolution Triangle] çağırmaya dönüşür."
  },
  State_2915_Desc = {
    Text = "\"Kin Zinciri\"nin Hasarını [Layer] kat artırır."
  },
  State_2915_Name = {Text = "Nefret"},
  State_2915_WeaponDesc = {
    Text = "\"Kin Zinciri\"nin Hasarını [Layer] kat artırır."
  },
  State_2917_Desc = {
    Text = "Tur sonunda, elde kalan her kart için, bir sonraki turun başında 1 Arithmetica kazan."
  },
  State_2917_Name = {
    Text = "Durum@Hayalet Gümüş Anahtar: Hesaplama"
  },
  State_2918_Desc = {
    Text = "Alınan Hasarı %99 azalt.\nAktif Hasar aldıktan sonra 1 yük kaldır ve turunun başında yükleri 3'e geri getir."
  },
  State_2918_Name = {
    Text = "\"Ölümsüz Kalıntı\""
  },
  State_2918_WeaponDesc = {
    Text = "Alınan Hasarı %99 azalt.\nAktif Hasar aldıktan sonra 1 yük kaldır ve turunun başında yükleri 3'e geri getir."
  },
  State_2919_Desc = {
    Text = "Durum@Zümrüt Yeşimateşi Görüntü İlerlemesi"
  },
  State_2919_Name = {
    Text = "Durum@Zümrüt Yeşimateşi Görüntü İlerlemesi"
  },
  State_2919_WeaponDesc = {
    Text = "Durum@Zümrüt Yeşimateşi Görüntü İlerlemesi"
  },
  State_2922_Desc = {
    Text = "Tüketilen her 1 Arithmetica için, ilgili Uyandıran 2 Aliemus kazanır."
  },
  State_2923_Desc = {
    Text = "Tur sonunda Gücü [Layer] artır."
  },
  State_2923_Name = {
    Text = "İlahi İniş Ritüeli"
  },
  State_2923_WeaponDesc = {
    Text = "Her turun sonunda [Layer] STR elde edersin."
  },
  State_2925_Desc = {
    Text = "Zümrüt Ateş’in verdiği her Hasar örneği için +1 Yığın"
  },
  State_2925_Name = {
    Text = "Zümrüt Yansıma Sayacı"
  },
  State_2925_WeaponDesc = {
    Text = "Zümrüt Ateş’in verdiği her Hasar örneği için +1 Yığın"
  },
  State_2927_Name = {
    Text = "Durum@Lanetli Sanrılar Değişimi"
  },
  State_2929_Desc = {
    Text = "Takım Özgünlüğü: Kullanan her 1 Hasar verdiğinde, <WeaponEffect_Num:[StateArg3]%> ihtimalle kullanan %2 Geçici Krit. Hasar kazanır. Kullanan Taşkınlık kullandıktan sonra rastgele düşmanlara kullananın SLD'sinin <WeaponEffect_Num:[StateArg1]%>'si kadar 3 kez Aktif Hasar verir. Mevcut Diyar \"Caro\" ise kullanan her Embriyo Yuttuğunda Embriyo Füzyonu +<WeaponEffect_Num:[Blood:StateArg2]> olur."
  },
  State_2929_WeaponDesc = {
    Text = "Kullanan her 1 Hasar verdiğinde, <WeaponEffect_Num:[StateArg3]%> ihtimalle kullanan %2 Geçici Krit. Hasar kazanır. Kullanan Taşkınlık kullandıktan sonra rastgele düşmanlara 3 kez [DescArg1] Aktif Hasar verir. Mevcut Diyar \"Caro\" ise kullanan her Embriyo Yuttuğunda Embriyo Füzyonu +<WeaponEffect_Num:[Blood:StateArg2]> olur."
  },
  State_2930_Name = {
    Text = "Durum@George@Ölümde Güç kazan"
  },
  State_2931_Desc = {
    Text = "Her Yutma eyleminde, tüm düşmanlardan 4 Geçici GÜÇ çal."
  },
  State_2931_Name = {
    Text = "Değişime Uğramış İpekböceği Akiki"
  },
  State_2933_Name = {
    Text = "Aksesuar: Bükülmüş İkiz Beyaz"
  },
  State_2933_WeaponDesc = {
    Text = "Çift turları başında, taşıyıcının \"Savunma\"sını Tükenme ve Geçicilik ile eline ekle."
  },
  State_2934_Desc = {
    Text = "Alınan tüm Aktif ve Dokunaç Hasarı +[DescArg1]%."
  },
  State_2934_Name = {
    Text = "<VulnerabilityColour:Savunmasız>"
  },
  State_2934_WeaponDesc = {
    Text = "Alınan tüm Hasar %50 artırılır."
  },
  State_2937_Desc = {
    Text = "3. kez Karakter Kalkanı kazandığında, ayrıca aynı miktarda Sayaç kazan."
  },
  State_2938_Desc = {
    Text = "Turunun başında 1 kart çek, ve turun sonunda elinde 1 kart tutmayı seçebilirsin."
  },
  State_2939_Name = {
    Text = "Kırılganlığa Bağışıklık"
  },
  State_2940_Desc = {
    Text = "Yenilenme Gücü Etkisi güçlendirildi."
  },
  State_2940_Name = {
    Text = "Sapkın Kanla Gittikçe Güçlenme"
  },
  State_2941_Desc = {
    Text = "Oynandığında, tüm düşmanlara [StateArg1] <IntoxicationIconKeywords:Poison> uygula, ardından her düşmanın <IntoxicationIconKeywords:Poison> değerinin [StateArg2]%’sini tetikle."
  },
  State_2941_Name = {
    Text = "<Rune_10:Toksin>"
  },
  State_2942_Desc = {
    Text = "Tur sonunda, diğer müttefiklerin Canını [Layer]% yeniler ve devam eden Hasarı kaldırır."
  },
  State_2942_Name = {
    Text = "Savaş Alanı Sağlıkçısı"
  },
  State_2946_Desc = {
    Text = "Azgın kombo son derece yüksek bir Kalkan sağlar."
  },
  State_2946_Name = {
    Text = "\"Sarsılmaz Kale\""
  },
  State_2946_WeaponDesc = {
    Text = "Azgın kombo son derece yüksek bir Kalkan sağlar."
  },
  State_2947_Name = {
    Text = "Çözünme 2"
  },
  State_2948_Desc = {
    Text = "Oynamadan önce kartın Arithmetica’sını değiştir"
  },
  State_2948_Name = {
    Text = "Oynamadan önce kartın Arithmetica’sını değiştir"
  },
  State_2948_WeaponDesc = {
    Text = "Oynamadan önce kartın Arithmetica’sını değiştir"
  },
  State_2949_Name = {
    Text = "Kader Çarkı Savaşı: Duayı Terk Et"
  },
  State_2951_Desc = {
    Text = "Ebedi Yatar Koltuk Kalıntısı"
  },
  State_2951_Name = {
    Text = "Sessiz eldivenler"
  },
  State_2952_Desc = {
    Text = "Tur bittikten sonra [Layer] HP yenile. Kaybedilen her 5 HP için 1 yığın kaldır."
  },
  State_2952_Name = {
    Text = "Yenilenme Gücü"
  },
  State_2954_Name = {
    Text = "Durum@2-8Canavar24@Beni kurtar"
  },
  State_2955_Desc = {
    Text = "Tüm düşmanlar Can kaybeder. Kalıcı, İmha Et."
  },
  State_2955_Name = {
    Text = "<CardKeyWord:Yanılsamanın Sonu>"
  },
  State_2955_WeaponDesc = {
    Text = "Tüm düşmanlar Can kaybeder. Kalıcı, İmha Et."
  },
  State_2956_Desc = {
    Text = "Alınan her Hasar örneği, tüm Uyananlara [StateArg1] Aliemus kazandırır."
  },
  State_2956_Name = {
    Text = "Hayali Işın"
  },
  State_2956_WeaponDesc = {
    Text = "Alınan her Hasar örneği, tüm Uyananlara [StateArg1] Aliemus kazandırır."
  },
  State_2957_Desc = {
    Text = "Öldükten sonra, konumda HP'nizin 1/3'üne sahip bir [Dissolution Triangle] çağır."
  },
  State_2957_Name = {Text = "Çözünme"},
  State_2957_WeaponDesc = {
    Text = "Öldükten sonra, konumda HP'nizin 1/3'üne sahip bir [Dissolution Triangle] çağır."
  },
  State_2960_Desc = {
    Text = "Çift sayılı turlarda, Arithmetica’n 0 ise 2 Arithmetica kazan."
  },
  State_2960_Name = {
    Text = "Eski Yapboz"
  },
  State_2960_WeaponDesc = {
    Text = "Çift sayılı turlarda, Arithmetica’n 0 ise 2 Arithmetica kazan."
  },
  State_2961_Desc = {
    Text = "Takıma Özel: Kuşananın <IntoxicationIconKeywords:Zehir> Etkisi <WeaponEffect_Num:[StateArg1]%> artar. Kuşanan bir Yüceltim serbest bırakmadan önce, tüm düşmanlara Saldırısının <WeaponEffect_Num:[StateArg2]%>’üne eşit Zehir uygular. Bir Çete kullandıktan sonra, kuşanan <WeaponEffect_Num:[StateArg3]> Aliemus kazanır."
  },
  State_2961_WeaponDesc = {
    Text = "Kuşananın <IntoxicationIconKeywords:Zehir> Hasarı <WeaponEffect_Num:[StateArg1]%> artar. Kuşanan bir Yücelt salmadan önce, önce tüm düşmanlara <WeaponEffect_Num:[Poison:DescArg1]> yığın Zehir uygular. Çete kullanıldıktan sonra, kuşanan <WeaponEffect_Num:[StateArg3]> Aliemus kazanır."
  },
  State_2962_Desc = {
    Text = "Oynandığında, tüm düşmanlara [StateArg1] tur boyunca <WeaknessIconKeywords:Zayıflık> uygula."
  },
  State_2962_Name = {
    Text = "<Rune_2:Zayıflık>"
  },
  State_2965_Name = {
    Text = "Durum@Hilal Hizmetçi Aydınlanma 7"
  },
  State_2967_Desc = {
    Text = "Semptom kartları kullanıldığında, Pandia'nın durumu \"Huzursuz\" ve \"Sefahat\" arasında değişir. Huzursuz: Aktif Hasar sayısı +1, azalmış GÜÇ. Sefahat: Aktif Hasar sayısı -1, artmış GÜÇ."
  },
  State_2967_Name = {
    Text = "Pandia Uyan!"
  },
  State_2967_WeaponDesc = {
    Text = "Bir sonraki turun başında, önceki turda kaybedilen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_2968_Name = {
    Text = "Durum@Stage2_14Battle8Bubble4"
  },
  State_2969_Name = {
    Text = "Durum@Level2_14Battle8Bubble5"
  },
  State_2970_Desc = {
    Text = "Köken Soyu"
  },
  State_2970_Name = {
    Text = "Köken Soyu"
  },
  State_2970_WeaponDesc = {
    Text = "Köken Soyu"
  },
  State_2971_Desc = {
    Text = "Durum@Prolog: Can'ı Yarıya Düşür"
  },
  State_2971_Name = {
    Text = "Durum@Prolog: Can'ı Yarıya Düşür"
  },
  State_2971_WeaponDesc = {
    Text = "Durum@Prolog: Can'ı Yarıya Düşür"
  },
  State_2972_Name = {
    Text = "Durum@Level2_14Battle8Bubble2"
  },
  State_2973_Name = {
    Text = "Durum@Level2_14Battle8Bubble3"
  },
  State_2975_Desc = {
    Text = "Her savaşta ilk 5 Sıçrama Etkisi bir kez daha tetiklenir."
  },
  State_2976_Desc = {
    Text = "Tur sonunda, Karakter Kalkanın 0 ya da 10’un katıysa [Arg1] Karakter Kalkanı kazan. HP’in 10’un katıysa [Arg2] Güç kazan."
  },
  State_2976_Name = {
    Text = "İmdat sinyali"
  },
  State_2977_Desc = {
    Text = "Tek sayılı turlarda, Elde 0 kartın varsa 2 kart çek."
  },
  State_2977_Name = {
    Text = "Eski Yapboz"
  },
  State_2977_WeaponDesc = {
    Text = "Tek sayılı turlarda, Elde 0 kartın varsa 2 kart çek."
  },
  State_2978_Desc = {
    Text = "Alınan her 1 Hasar için 1 yığın kaybeder. Yığınlar 0'a ulaştığında Savunma moduna geçer."
  },
  State_2978_Name = {
    Text = "Kart Sayısı"
  },
  State_2978_WeaponDesc = {
    Text = "Alınan her 1 Hasar için 1 yığın kaybeder. Yığınlar 0'a ulaştığında Savunma moduna geçer."
  },
  State_2979_Desc = {
    Text = "Takıma Özel: Kuşananın Zehir ve Karakter Kalkanı Üretimi +<WeaponEffect_Num:[StateArg3]%>. Kuşananın \"Darbe\" Kritik Oranı ve Krit. Hasarı <WeaponEffect_Num:[StateArg1]%> artar ve Maksimum HP'nin <WeaponEffect_Num:[StateArg2]%>'ine eşit bir Karakter Kalkanı kazanır. Bu Karakter Kalkanı etkisi tur başına yalnızca bir kez etkinleşebilir."
  },
  State_2979_Name = {
    Text = "Acıyı Aşmak"
  },
  State_2979_WeaponDesc = {
    Text = "Kuşananın Zehir ve Karakter Kalkanı Üretimi etkileri <WeaponEffect_Num:[StateArg3]%> artar. Kuşananın \"Darbe\" Kritik Oranı ve Kritik Hasarı <WeaponEffect_Num:[StateArg1]%> artar ve Maksimum HP'nin [StateArg2]%’ine ([DescArg1]) eşit Karakter Kalkanı kazanır; bu kalkan etkisi tur başına bir kez tetiklenir."
  },
  State_2983_Desc = {
    Text = "Atma aşamasında elde tutulursa, Tüketme. Yeniden ortaya çıkmaz."
  },
  State_2983_Name = {
    Text = "<NothingnessIconKeywords:Gelip Geçici>"
  },
  State_2983_WeaponDesc = {
    Text = "Atma aşamasında elinde kalırsa, Atılmış Kart Destesine gitmez ve bu savaşta tekrar kullanılamaz."
  },
  State_2985_Desc = {
    Text = "Tur sonuna kadar, her Hasar verdiğinde, tur sonunda [Layer] HP yenile."
  },
  State_2985_Name = {
    Text = "Yontulmamış Elmas"
  },
  State_2985_WeaponDesc = {
    Text = "Tur sonuna kadar, her Hasar verildiğinde [Layer] CP yenile."
  },
  State_2987_Desc = {Text = "Olay 19_1"},
  State_2987_Name = {Text = "Olay 19_1"},
  State_2987_WeaponDesc = {Text = "Olay 19_1"},
  State_2988_Desc = {
    Text = "Embriyoları Yutma sırasında, onlar Atılmış Kart Desteğinden El Destenize geri döner ve Arithmetica sıfıra iner."
  },
  State_2988_Name = {
    Text = "Kötücül Döl"
  },
  State_2988_WeaponDesc = {
    Text = "Embriyoları Yutma sırasında, onlar Atılmış Kart Desteğinden El Destenize geri döner ve Arithmetica sıfıra iner."
  },
  State_2989_Desc = {
    Text = "Bir Uyanan kartı oynadıktan sonra, maliyeti 1 azaltılmış Geçici bir kopyasını destesine Karıştır."
  },
  State_2990_Desc = {
    Text = "Oynandığında, tüm düşmanlara [StateArg1] Geçici <ExhaustionIconKeywords:STR▼> uygula."
  },
  State_2990_Name = {
    Text = "<Rune_18_High:Gelişmiş Tükenme>"
  },
  State_2992_Desc = {
    Text = "\"Boşluk\" kartını çektikten sonra, bu turda tüm Uyandırıcıların kazandığı Aliemus %50 azalır."
  },
  State_2992_Name = {Text = "Boşluk"},
  State_2992_WeaponDesc = {
    Text = "\"Boşluk\" kartını çektikten sonra, bu turda tüm Uyandırıcıların kazandığı Aliemus %50 azalır."
  },
  State_2993_Name = {
    Text = "Kalıntı Yılan Derisi Gömleği Sayacı"
  },
  State_2994_Desc = {
    Text = "Dokunaçlar Taşma halindeyken Dokunaç Hasarı +[StateArg1]."
  },
  State_2994_Name = {
    Text = "Kutsama Gücü"
  },
  State_2994_WeaponDesc = {
    Text = "Dokunaçlar Taşma halindeyken Dokunaç Hasarı +[StateArg1]."
  },
  State_2996_Desc = {
    Text = "Oynandığında, [StateArg1] Dokunaç Saldırısı tetikle."
  },
  State_2996_Name = {
    Text = "<Rune_11:Hükümranlık>"
  },
  State_2997_Desc = {
    Text = "Her turda 3. Hasarı verdikten sonra [Arg1] Kalkan kazan. Her turda 6. Hasarı verdikten sonra [Arg2] Güç kazan."
  },
  State_2997_Name = {
    Text = "Güvenli geçiş"
  },
  State_3001_Desc = {
    Text = "Saldırıya uğradığında Kart Oynayınca Aliemus Kazanımı miktarını 2 artır."
  },
  State_3002_Desc = {
    Text = "Kuşananın Hasarı, Karakter Kalkanı ve İyileştirmesi +[StateArg1]%. (Geçici)"
  },
  State_3002_Name = {
    Text = "Durum@Prototip Lazer Topu Şansı"
  },
  State_3003_Desc = {
    Text = "Oynandıktan sonra, bu kart Atılmış Kart Destesi'ne gitmek yerine desteden kaldırılır."
  },
  State_3003_Name = {
    Text = "<DepleteIconKeywords:Tüketme>"
  },
  State_3003_WeaponDesc = {
    Text = "Oynandıktan sonra, kart Atılmış Kart Destesi’ne gitmez ve bu Savaşta tekrar kullanılamaz."
  },
  State_3004_Desc = {
    Text = "[Layer], tur boyunca Zehir Durumu’na maruz kalmaya karşı Bağışıklık kazanır."
  },
  State_3004_Name = {
    Text = "Zehirlenmeye Bağışıklık"
  },
  State_3008_Desc = {
    Text = "Tur başında, elinde kalan kartlara 1 yığın Durgunluk ekle. Arithmetica Maliyeti 5’ten büyük olan kartlar taşa dönüşür."
  },
  State_3008_Name = {
    Text = "Aigis Uyanış!"
  },
  State_3008_WeaponDesc = {
    Text = "Bir sonraki turun başında, önceki turda kaybedilen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_3011_Desc = {
    Text = "Takıma Özel: Kuşananın \"Yüceliş\" inin Krit. Oranı ve Krit. Hasarı <WeaponEffect_Num:[StateArg2]%> artar. Kuşanan \"Yüceliş\" i serbest bıraktıktan sonra, DAY eşitinde <PowerIconKeywords:STR> kazanır: kendi DAY’sinin <WeaponEffect_Num:[StateArg1]%>’i. Bu Yüceliş <CardKeyWord:Devour> etkisini tetiklerse, fazladan 1 yığın <PowerIconKeywords:STR> kazanır."
  },
  State_3011_WeaponDesc = {
    Text = "Kuşananın \"Yüceltme\" sinin Kritik Oranı ve Krit. Hasarı <WeaponEffect_Num:[StateArg2]%> artar. Kuşanan \"Yüceltme\" yi serbest bıraktıktan sonra <WeaponEffect_Num:[Power:DescArg1]> Güç kazanır. Bu Yüceltme <CardKeyWord:Yutma> etkisini tetiklerse, ayrıca 1 <PowerIconKeywords:STR> elde eder."
  },
  State_3012_Desc = {
    Text = "İşe Yaramaz Boş Durum"
  },
  State_3012_Name = {
    Text = "İşe Yaramaz Boş Durum"
  },
  State_3012_WeaponDesc = {
    Text = "İşe Yaramaz Boş Durum"
  },
  State_3013_Desc = {
    Text = "Kan İçici Hasta Embriyo Füzyonu’nu güçlendirdiğinde, [StateArg1] Güç kazan."
  },
  State_3013_Name = {Text = "Kanobur"},
  State_3014_Desc = {
    Text = "Rakibin elinde 4 veya daha fazla kart varsa, Hasar aldığında [StateArg1] Karakter Kalkanı kazan."
  },
  State_3014_Name = {
    Text = "Yılan Formu"
  },
  State_3015_Desc = {
    Text = "Durum@Balmumu Zırh - Takımımız"
  },
  State_3015_Name = {
    Text = "Durum@Balmumu Zırh - Takımımız"
  },
  State_3015_WeaponDesc = {
    Text = "Durum@Balmumu Zırh - Takımımız"
  },
  State_3016_Desc = {
    Text = "Çağrılan Canavarların HP’si ikiye katlanır."
  },
  State_3016_Name = {
    Text = "\"Taşan Suçluluk\""
  },
  State_3016_WeaponDesc = {
    Text = "Çağrılan Canavarların HP’si ikiye katlanır."
  },
  State_3017_Name = {
    Text = "Durum@Lanetli Sanrılar"
  },
  State_3018_Desc = {
    Text = "\"Dimensional Hound\" her kaybedilen HP için 1 yük kaldırır; yükler 0’a ulaştığında, [StateArg1] Kalkan kazan ve [StateArg2] Boyutsal Savunma Duvarı’nı geri kazan."
  },
  State_3018_Name = {
    Text = "Boyutsal Savunma Duvarı"
  },
  State_3019_Desc = {
    Text = "10 Kara Mühür tüketmek 1% HP yeniler"
  },
  State_3019_Name = {
    Text = "Kalıntı Ters Kök Durumu"
  },
  State_3019_WeaponDesc = {
    Text = "10 Kara Mühür tüketmek 1% HP yeniler"
  },
  State_3020_Desc = {
    Text = "Önceki turda Hasar aldıysan, bu turun başında 1 tur boyunca bağışıklık kazan."
  },
  State_3020_Name = {
    Text = "Uyum Sağla"
  },
  State_3020_WeaponDesc = {
    Text = "Önceki turda Hasar aldıysan, bu turun başında 1 tur boyunca bağışıklık kazan."
  },
  State_3021_Desc = {
    Text = "Tur başında 1 Arithmetica kazan."
  },
  State_3021_Name = {
    Text = "Durum@Maksimum Arithmetica -2"
  },
  State_3023_Desc = {
    Text = "Bu turda her Aktif Hasar alındığında, Hasar Kaynağına [Layer] <FixedDamage:Saf Hasar> verir."
  },
  State_3023_Name = {Text = "Sayaç"},
  State_3023_WeaponDesc = {
    Text = "Her Aktif Hasar alındığında, Saldırgana [Layer] <FixedDamage:Saf Hasar> verir."
  },
  State_3024_Desc = {
    Text = "Kuşananın Hasarı, Karakter Kalkanı ve İyileştirmesi +[StateArg1]%. (Geçici)"
  },
  State_3024_Name = {
    Text = "Durum@Prototip Hançer Direnç"
  },
  State_3025_Desc = {
    Text = "Bu tur oynanan her kart, Krit. Oranını %10 artırır."
  },
  State_3026_Desc = {
    Text = "Savaşın başında, bu karttan [StateArg1] kopya Çekme Desteğine karıştırıldı. (Bu Yakarış kartlara <RetainIconKeywords:Sakla> ekler.)"
  },
  State_3026_Name = {
    Text = "<Rune_8_High:Gelişmiş Yansıma>"
  },
  State_3026_WeaponDesc = {
    Text = "Savaşın başında, bu karttan [StateArg1] kopya Çekme Desteğine karıştırıldı. (Bu Yakarış kartlara <RetainIconKeywords:Sakla> ekler.)"
  },
  State_3027_Desc = {
    Text = "Savaştan sonra fazladan 50 Kara Mühür elde et, ancak rastgele bir Semptom geliştir."
  },
  State_3028_Name = {
    Text = "Durum@Tur Başlangıcı Arithmetica +2"
  },
  State_3029_Desc = {
    Text = "Alınan her 1 Hasar için 1 yığın kaybeder. Yığınlar 0'a ulaştığında Savunma moduna geçer."
  },
  State_3029_Name = {
    Text = "Kart Sayısı"
  },
  State_3029_WeaponDesc = {
    Text = "Alınan her 1 Hasar için 1 yığın kaybeder. Yığınlar 0'a ulaştığında Savunma moduna geçer."
  },
  State_3033_Desc = {
    Text = "10 kart oynandığında, herhangi bir Hasarı engelleyen bir bariyer kazan. Zaten bir bariyerin varsa, bunun yerine [Arg1] CP yenile."
  },
  State_3034_Desc = {
    Text = "Takıma Özel: Kuşanana ait her kart oynandığında <WeaponEffect_Num:[StateArg1]> Keyflare kazan. Bu etki tur başına en fazla 3 kez tetiklenebilir."
  },
  State_3034_WeaponDesc = {
    Text = "Kullananın oynadığı her kart için <WeaponEffect_Num:[StateArg1]> Keyflare kazan. Bu etki tur başına en fazla 3 kez tetiklenebilir."
  },
  State_3035_Desc = {
    Text = "Oynandığında, [StateArg1] Dokunaç Saldırısı tetikle."
  },
  State_3035_Name = {
    Text = "<Rune_11_High:Gelişmiş Hâkimiyet>"
  },
  State_3035_WeaponDesc = {
    Text = "Oynandığında, [StateArg1] Dokunaç Saldırısı tetikle."
  },
  State_30364_Desc = {
    Text = "Bu kart Elde iken, el sınırı 1 artar."
  },
  State_30364_Name = {
    Text = "El Boyutu Sınırını Yoksay"
  },
  State_30369_Desc = {
    Text = "Bu tur El Sınırı +[Layer] artar."
  },
  State_30369_Name = {
    Text = "Maksimum El Boyutu"
  },
  State_3036_Desc = {
    Text = "Kırılgan ve Zayıflık Etkisini %33’ten %50’ye çıkar."
  },
  State_3036_Name = {
    Text = "\"Yok Oluşun Yankıları\""
  },
  State_3036_WeaponDesc = {
    Text = "Kırılgan ve Zayıflık Etkisini %33’ten %50’ye çıkar."
  },
  State_3038_Desc = {
    Text = "Takıma Özel: Sürü tetiklendikten sonra, Kuşanan <WeaponEffect_Num:[StateArg1]> Aliemus kazanır."
  },
  State_3038_WeaponDesc = {
    Text = "Çeteyi serbest bıraktıktan sonra, kullanan <WeaponEffect_Num:[StateArg1]> Aliemus kazanır."
  },
  State_3040_Desc = {
    Text = "Tur başında, takımına [Layer] yığın Esaret uygula."
  },
  State_3040_Name = {Text = "Esaret"},
  State_3040_WeaponDesc = {
    Text = "Tur başında, takımına [Layer] yığın Esaret uygula."
  },
  State_3041_Desc = {
    Text = "Deste içinde kalıcı olarak varlığını sürdürür."
  },
  State_3041_Name = {
    Text = "<CardKeyWord:Semptom kartı>"
  },
  State_3042_Desc = {
    Text = "Hasar verirken bu tur [Arg1] Güç kazan, en fazla 3 kez yığın yapar. Tam yığına ulaşıldığında Etki ikiye katlanır."
  },
  State_3043_Desc = {
    Text = "Çift turlar: Alınan Hasar -%50, Verilen Hasar +%33."
  },
  State_3043_Name = {Text = "Gelgeç"},
  State_3043_WeaponDesc = {
    Text = "Çift turlar: Alınan Hasar -%50, Verilen Hasar +%33."
  },
  State_3045_Desc = {
    Text = "Taşkınlık’tan sonra, ilgili Uyandıran 20 Aliemus kazanır."
  },
  State_3045_Name = {
    Text = "İsimsiz Tanrının Peçesi"
  },
  State_3046_Desc = {
    Text = "Takıma Özel: Her düşman öldüğünde [StateArg1] Kara Mühür kazan. Kuşanan bir düşmanı öldürdükten sonra, bu seviyede kuşananın Krit. Hasarı kalıcı olarak <WeaponEffect_Num:[StateArg2]%> artar; en fazla 5 yığına kadar birikir. Kuşanan her sıçrama (Leap) etkisini tetiklediğinde, bu tur kuşananın verdiği Final Hasar <WeaponEffect_Num:[StateArg3]%> artar; en fazla 3 yığına kadar birikir."
  },
  State_3046_WeaponDesc = {
    Text = "Her düşman öldüğünde [StateArg1] Kara Mühür kazan. Taşıyıcı bir düşmanı öldürdüğünde, bu karşılaşmada taşıyıcının Krit. Hasarı kalıcı olarak <WeaponEffect_Num:[StateArg2]%> artar; en fazla 5 yığına kadar birikir. Taşıyıcı her Sıçrama etkisini tetiklediğinde, o tur taşıyıcının verdiği Final Hasar <WeaponEffect_Num:[StateArg3]%> artar; en fazla 3 yığına kadar birikir."
  },
  State_3047_Desc = {
    Text = "Tur başında [Arg1] Kalkan kazan, her tur [Arg2] artar."
  },
  State_3047_Name = {
    Text = "Koruyucu el"
  },
  State_3048_Desc = {
    Text = "Lotan'ın Savaş Azmi asla dinmez. Her turun sonunda, Lotan 3 yığın Zayıflık ve Savunmasız hâlini kaldırır."
  },
  State_3048_Name = {
    Text = "Lotan Uyanışı"
  },
  State_3049_Desc = {
    Text = "George'un bir sonraki saldırısının Hasar örneklerinin sayısını 1 artırır."
  },
  State_3049_Name = {Text = "Kin"},
  State_3049_WeaponDesc = {
    Text = "George'un bir sonraki saldırısının Hasar örneklerinin sayısını 1 artırır."
  },
  State_3050_Desc = {
    Text = "Savaşın başında, bir [Convulsion]’i Çekme Destenin içine Karıştır."
  },
  State_3050_Name = {Text = "Korku"},
  State_3050_WeaponDesc = {
    Text = "Savaşın başında, bir [Convulsion]’i Çekme Destenin içine Karıştır."
  },
  State_3051_Desc = {
    Text = "Engellenemez Hasar verirken Çekme Desteğine bir Çığlık karıştır."
  },
  State_3051_Name = {
    Text = "Mum Gibi Sıcak Arzu"
  },
  State_3051_WeaponDesc = {
    Text = "Gerçek Hasar verdikten sonra, Çekme Desteğine bir \"Feryat\" kartı karıştır."
  },
  State_3054_Name = {
    Text = "Durum@Lanetli Şok"
  },
  State_3055_Desc = {
    Text = "Savaş başladığında, ekibine 1 yığın Kırılgan uygula."
  },
  State_3055_Name = {Text = "Nüfuz"},
  State_3055_WeaponDesc = {
    Text = "Savaş başladığında, ekibine 1 yığın Kırılgan uygula."
  },
  State_3056_Desc = {
    Text = "Tur sonunda, 1 yığın Zayıflık ve 1 yığın Savunmasız kaldır."
  },
  State_3056_Name = {Text = "Tehditkâr"},
  State_3058_Desc = {
    Text = "Her bir Dokunaç için, tur sonunda [Arg1] Karakter Kalkanı kazan."
  },
  State_3058_Name = {
    Text = "İsimsiz uzantı"
  },
  State_3060_Desc = {
    Text = "Sonraki turun başında [Layer] Karakter Kalkanı kazan."
  },
  State_3060_Name = {
    Text = "Yeniden Dövülmüş Psişe"
  },
  State_3060_WeaponDesc = {
    Text = "Sonraki turun başında [Layer] kart çek."
  },
  State_3063_Desc = {
    Text = "Gerçek Hasar verirken [Layer] Zehir uygula."
  },
  State_3063_Name = {Text = "Zehir"},
  State_3064_Desc = {
    Text = "Kartı oynamadan önce eşit sayıda Hasar yığın alın. Tur sonunda kaldırılır."
  },
  State_3064_Name = {Text = "Esaret"},
  State_3064_WeaponDesc = {
    Text = "Kartı oynamadan önce eşit sayıda Hasar yığın alın. Tur sonunda kaldırılır."
  },
  State_3065_Name = {
    Text = "Durum@Kalıntı Geçmiş Sunu 2"
  },
  State_3068_Desc = {
    Text = "Tur sonunda [Layer] <FixedDamage:Saf Hasar> alır."
  },
  State_3068_Name = {
    Text = "<IntoxicationColour:Zehir>"
  },
  State_3068_WeaponDesc = {
    Text = "Tur sonunda [Layer] <FixedDamage:Saf Hasar> alır."
  },
  State_3069_Name = {
    Text = "Aksesuar: Deus Ex Machina"
  },
  State_3069_WeaponDesc = {
    Text = "Her Savaşın ilk Turunun başında 1 ilave Arithmetica elde edersin."
  },
  State_3070_Desc = {
    Text = "Takıma Özel: Kuşananın \"Darbe\" si, hedef düşmanın Kuşananın Saldırısının <WeaponEffect_Num:[StateArg1]%>’üne eşit Geçici <PowerIconKeywords:Güç> kaybetmesine neden olur. Bu Etki tur başına en fazla 3 kez tetiklenebilir."
  },
  State_3070_WeaponDesc = {
    Text = "Kullanıcının \"Saldırı\"sı, hedef düşmanın <WeaponEffect_Num:[Power:DescArg1]> <PowerIconKeywords:GÜÇ>'ünü geçici olarak azaltır. Bu etki tur başına en fazla 3 kez tetiklenebilir."
  },
  State_3071_Desc = {
    Text = "Takıma Özel: Kuşananın \"Savunma\" sı oynandıktan sonra, Kuşananın Saldırısının <WeaponEffect_Num:[StateArg1]%>’üne eşit Geçici <PowerIconKeywords:Güç> kazan."
  },
  State_3071_WeaponDesc = {
    Text = "Kuşananın \"Savunma\" sını oynadıktan sonra, <WeaponEffect_Num:[Power:DescArg1]> Geçici <PowerIconKeywords:STR> kazan."
  },
  State_3072_Desc = {
    Text = "Takıma Özel: Bir düşmanı öldürdükten sonra, Kuşanan <WeaponEffect_Num:[StateArg1]> Aliemus ve tüm keşif boyunca geçerli olmak üzere %1 Krit. Hasar kazanır."
  },
  State_3072_WeaponDesc = {
    Text = "Bir düşmanı öldürdükten sonra, Kuşanan tüm keşif boyunca geçerli olmak üzere <WeaponEffect_Num:[StateArg1]> Aliemus ve %1 Krit. Hasar kazanır."
  },
  State_3073_Desc = {
    Text = "Takıma Özel: Kuşanan Yüceliş kullandıktan sonra, bu tur tüm müttefiklerin Kritik Oranı <WeaponEffect_Num:[StateArg1]%> artar."
  },
  State_3073_WeaponDesc = {
    Text = "Kullanan Exalt serbest bıraktıktan sonra, bu tur tüm müttefiklerin Kritik Oranı <WeaponEffect_Num:[StateArg1]%> artar."
  },
  State_3074_Desc = {
    Text = "Takıma Özel: Bir Semptom kartı oynandıktan sonra, Kuşanan <WeaponEffect_Num:[StateArg1]> Aliemus kazanır. Bu etki tur başına en fazla 2 kez tetiklenir. Bir Komut Kartı oynandıktan sonra, Kuşanan 1 Aliemus kazanır."
  },
  State_3074_WeaponDesc = {
    Text = "Bir Semptom kartı oyna. Kullanıcı <WeaponEffect_Num:[StateArg1]> Aliemus kazanır. Bu etki tur başına en fazla 2 kez tetiklenebilir. Kullanıcı 1 Komut Kartı oynadığında 1 Aliemus kazanır."
  },
  State_3075_Desc = {
    Text = "Takıma Özel: Yücelişten sonra, Kuşananın DEF’inin <WeaponEffect_Num:[StateArg1]%>’ine eşit Kalkan kazan."
  },
  State_3075_Name = {Text = "Ruh Kalesi"},
  State_3075_WeaponDesc = {
    Text = "Taşıyıcı Yücelt’i serbest bıraktıktan sonra, <WeaponEffect_Num:[Block:DescArg1]> Kalkan kazan."
  },
  State_3076_Desc = {
    Text = "Takım Özgünlüğü: Aktif Hasar verdikten sonra, kullanana ait Kritik Oranı + <WeaponEffect_Num:[StateArg1]%>. Kritik vuruş gerçekleştikten sonra, bu etkiden kazanılan Kritik Oranı sıfırlanır."
  },
  State_3076_WeaponDesc = {
    Text = "Aktif Hasar verdikten sonra, kullanana ait Kritik Oranı + <WeaponEffect_Num:[StateArg1]%>. Kritik vuruş gerçekleştikten sonra, bu etkiden kazanılan Kritik Oranı sıfırlanır."
  },
  State_3078_Desc = {
    Text = "Bu turda verilen tüm Hasarların Kritik Vuruş olacağı kesindir."
  },
  State_3078_Name = {
    Text = "Geçici Garantili Kritik"
  },
  State_3078_WeaponDesc = {
    Text = "Bu tur Kritik Oranı + %100."
  },
  State_3082_Desc = {
    Text = "Yüceldikten sonra, Uyandıran'a karşılık gelen rastgele bir kartı eline al. Kart Tüketme ve Geçicilik kazanır."
  },
  State_3082_Name = {
    Text = "Doktor Çantası"
  },
  State_3084_Desc = {
    Text = "Oynandığında, ondan [StateArg1] kopyayı Geçici <DimensionalSpaceIconKeywords:Ultra Uzay> yuvalarına ekle."
  },
  State_3084_Name = {
    Text = "<Rune_13_High:İleri Bükülme>"
  },
  State_3084_WeaponDesc = {
    Text = "Oynandığında, ondan [StateArg1] kopyayı Geçici <DimensionalSpaceIconKeywords:Ultra Uzay> yuvalarına ekle."
  },
  State_3087_Desc = {
    Text = "Darbe kartı Hasarı [Layer]% artar."
  },
  State_3087_Name = {
    Text = "Saldırı kartı HASARI geçici olarak artırıldı"
  },
  State_3087_WeaponDesc = {
    Text = "Darbe kartı Hasarı [Layer]% artar."
  },
  State_3088_Desc = {
    Text = "Alınan Aktif Hasar [Layer] artar. Çözünme yaraları her darbe ile genişler ve turun başında iyileşir."
  },
  State_3088_Name = {
    Text = "Derin Çözünme"
  },
  State_3088_WeaponDesc = {
    Text = "Alınan Aktif Hasar [Layer] artar. Her Hasar alındığında Çözünme Yarası genişler ve Tur başında iyileşir."
  },
  State_3092_Name = {
    Text = "Reis Savaşlarında tüm Uyandırıcılar 30 Aliemus kazanır ve Mühürlü Durum’dan serbest kalır."
  },
  State_3093_Name = {
    Text = "Durum@Sihirbazın Taklit Sayacı"
  },
  State_3094_Desc = {
    Text = "Çekildiğinde, kendini 1 tur boyunca Kırılgan yap. Kullanıldığında, tüm düşmanları 1 tur boyunca Savunmasız yap. Satılamaz."
  },
  State_3094_Name = {
    Text = "Lanet Durumu Çöküş"
  },
  State_3094_WeaponDesc = {
    Text = "Çekildiğinde, kendini 1 tur boyunca Kırılgan yap. Kullanıldığında, tüm düşmanları 1 tur boyunca Savunmasız yap. Satılamaz."
  },
  State_3095_Desc = {
    Text = "Bu aşamada verilen Hasar [Layer] artar."
  },
  State_3095_Name = {
    Text = "Kalıcı GÜÇ"
  },
  State_3095_WeaponDesc = {
    Text = "Bu aşamada verilen Hasar [Layer] artar."
  },
  State_3096_Desc = {
    Text = "Lotan'ı ikna etmek için gidilecek yol hâlâ uzun."
  },
  State_3096_Name = {
    Text = "Lotan Uyanışı"
  },
  State_3098_Desc = {
    Text = "Aldığında, Arithmetica Maliyeti kalıcı olarak 1’e düşürülecek bir kart seç."
  },
  State_3099_Desc = {
    Text = "Bir Yüceltim serbest bıraktıktan sonra, bu tur [Arg1] Güç kazan."
  },
  State_3100_Desc = {
    Text = "Tur başında, Ölüm Direnci %10 artar. Ölüm Direnci %100’ü aştığında, fazladan 30 Diyar Ustalığı kazan."
  },
  State_3104_Desc = {
    Text = "Bu tur, her Aktif Hasar alışında \"Tatlı Şeytan\"ın Hasarı +1 kez artar."
  },
  State_3104_Name = {
    Text = "Paylaşılan Acı"
  },
  State_3104_WeaponDesc = {
    Text = "Bu tur, her Aktif Hasar alışında \"Tatlı Şeytan\"ın Hasarı +1 kez artar."
  },
  State_3106_Desc = {
    Text = "CP %50’nin([StateArg1]) altına düştüğünde, eşit CP’ye sahip 2 \"Deneysel Yaratım\" a bölünür."
  },
  State_3106_Name = {Text = "Bölünme"},
  State_3106_WeaponDesc = {
    Text = "HP %50’nin ([StateArg1]) altına indiğinde, HP’si eşit olacak şekilde 3 adet \"II-Tip Çözündürülmüş Varlık Balmumu Heykel Grubu\"na bölünür."
  },
  State_3108_Name = {
    Text = "Aksesuar: Dize Yüzüğü"
  },
  State_3108_WeaponDesc = {
    Text = "Çift sayılı turların başında 1 Arithmetica elde et."
  },
  State_3109_Name = {
    Text = "Durum@Bölüm 4 Rezonans@Arithmetica -1"
  },
  State_3109_WeaponDesc = {
    Text = "\"Masum Dönüş Hediyesi\" Arithmetica Maliyeti -1"
  },
  State_3110_Name = {
    Text = "Durum@Bölüm 4 Rezonans@Arithmetica -1"
  },
  State_3110_WeaponDesc = {
    Text = "\"Masum Dönüş Hediyesi\" Arithmetica Maliyeti -1"
  },
  State_3111_Desc = {
    Text = "Sonraki turun başında, kalan Karakter Kalkanını 2x Can’a dönüştür."
  },
  State_3111_Name = {
    Text = "Sönmez Çiçek"
  },
  State_3112_Desc = {
    Text = "Takıma Özel: Kuşananın Zehir Hasarını <WeaponEffect_Num:[StateArg3]%> artırır. Yücelt kullandıktan sonra, Kuşananın DAY değerinin <WeaponEffect_Num:[StateArg1]%>'ine eşit Canı yenilenir ve kalan her bir Arithmetica için Kuşananın DAY değerinin ek olarak <WeaponEffect_Num:[StateArg2]%>'i kadar Can yenilenir."
  },
  State_3112_Name = {
    Text = "Sessiz Şölen"
  },
  State_3112_WeaponDesc = {
    Text = "Verilen Zehir’i <WeaponEffect_Num:[StateArg3]%> artır. Kuşanan Yüceltme gerçekleştirdikten sonra, <WeaponEffect_Num:[Heal:DescArg1]> Can puanı iyileştir ve kalan her bir Arithmetica için fazladan <WeaponEffect_Num:[Heal:DescArg2]> Can puanı kazan."
  },
  State_3113_Desc = {
    Text = "Durum@Prolog Aliemus 0_1_4"
  },
  State_3113_Name = {
    Text = "Durum@Prolog Aliemus 0_1_4"
  },
  State_3113_WeaponDesc = {
    Text = "Durum@Prolog Aliemus 0_1_4"
  },
  State_3114_Desc = {
    Text = "Durum@Prolog Aliemus 0_1_2"
  },
  State_3114_Name = {
    Text = "Durum@Prolog Aliemus 0_1_2"
  },
  State_3114_WeaponDesc = {
    Text = "Durum@Prolog Aliemus 0_1_2"
  },
  State_3115_Desc = {
    Text = "Durum@Prolog Aliemus 0_1_2"
  },
  State_3115_Name = {
    Text = "Durum@Prolog Aliemus 0_1_2"
  },
  State_3115_WeaponDesc = {
    Text = "Durum@Prolog Aliemus 0_1_2"
  },
  State_3116_Name = {
    Text = "Durum@Prolog Aliemus 0_1_1"
  },
  State_3117_Desc = {
    Text = "Takıma Özel: Kuşananın \"Darbe\" ve \"Yücelt\" Yeteneklerinin Temel Hasarı <WeaponEffect_Num:[StateArg1]%> artar. Kuşanan \"Darbe\" kullandıktan sonra, tur başına en fazla 3 yığına kadar, her kullanımda %5 Geçici Kritik Oranı kazanır. 3 yığına ulaşıldığında, %15 Geçici Kritik Hasar kazanır."
  },
  State_3117_WeaponDesc = {
    Text = "Silah kullananın \"Vuruş\" ve \"Yüceltme\" Temel Hasarı <WeaponEffect_Num:[StateArg1]%> artar. \"Vuruş\" kullanıldıktan sonra, taşıyıcı her kullanımda Tur başına en fazla 3 kez olmak üzere %5 Geçici Kritik Oranı kazanır. 3 yığına ulaşıldığında, %15 Geçici Kritik Hasar kazanır."
  },
  State_3118_Desc = {
    Text = "Tur başında, kaybedilen HP'nin [Layer]%'ini yenile."
  },
  State_3118_Name = {
    Text = "Kılavuz Yelkeninin Sığınağı"
  },
  State_3120_Desc = {
    Text = "[Defense] [Arg1] Sayaç kazan."
  },
  State_3121_Desc = {
    Text = "Düşmanın Niyeti saldırı değilse, verilen Hasarın yarısına eşit Kanama uygulamak için Etkin veya Dokunaç Hasarı ver."
  },
  State_3123_Desc = {
    Text = "Takıma Özel: Kuşananın <RetaliateIconKeywords:counter> değeri <WeaponEffect_Num:[StateArg3]%> artar. Her alınan Saldırı için, Kuşananın Saldırısının <WeaponEffect_Num:[StateArg1]%>’i kadar Geçici <PowerIconKeywords:STR> kazanılır. Kuşanan Yüceltim kullandıktan sonra, Kuşananın Saldırısının <WeaponEffect_Num:[StateArg2]%>’i kadar <RetaliateIconKeywords:counter> kazanılır."
  },
  State_3123_WeaponDesc = {
    Text = "Taşıyıcının Sayaç Hasarı <WeaponEffect_Num:[StateArg3]%> artar. Alınan her saldırı için, <WeaponEffect_Num:[Power:DescArg1]> Geçici <PowerIconKeywords:GÜÇ> kazan. Taşıyıcı Yücelt kullandıktan sonra, <WeaponEffect_Num:[Counterattack:DescArg2]> Sayaç kazan."
  },
  State_3124_Desc = {
    Text = "Şanslı Dedektif tarafından elde edilen Kara Mühür sayısı iki katına çıkar."
  },
  State_3124_Name = {
    Text = "Olağanüstü Şans"
  },
  State_3124_WeaponDesc = {
    Text = "Şanslı Dedektif tarafından elde edilen Kara Mühür sayısı iki katına çıkar."
  },
  State_3127_Name = {
    Text = "Durum@Seviye2_10Savaş3Balon1"
  },
  State_3128_Desc = {
    Text = "Uyananlar tarafından yapılan tüm Karakter Kalkanı ve HP yenileme [StateArg1]% artar."
  },
  State_3128_Name = {Text = "Beşik"},
  State_3129_Desc = {
    Text = "Sonraki tur başlamadan önce, alınan her Aktif Hasar örneği [Layer] ek karşı atak ve Dokunaç karşı atağını tetikler ve %50 Hasar verir."
  },
  State_3129_Name = {
    Text = "Koruyucu Pullar"
  },
  State_3130_Desc = {
    Text = "Bu tur Hasar [Layer] artar."
  },
  State_3130_Name = {
    Text = "Geçici GÜÇ"
  },
  State_3130_WeaponDesc = {
    Text = "Bu tur Hasar [Layer] artar."
  },
  State_3135_Desc = {
    Text = "Her yığın, verilen Hasar örneklerini 1 artırır."
  },
  State_3135_Name = {
    Text = "<MadnessIconKeywords:Delilik>"
  },
  State_3136_Name = {Text = "Aliemus"},
  State_3137_Desc = {
    Text = "Savaşın başında 1 Dokunaç kazan. Dokunaç Hasarı kalıcı olarak [Arg1] artar."
  },
  State_3138_Name = {
    Text = "Aksesuar Paradoks"
  },
  State_3138_WeaponDesc = {
    Text = "Kullanıcı Yüceltim kullandıktan sonra, müttefikler kullanıcının DEF'inin %100'üne dayalı <RetaliateIconKeywords:Sayaç> kazanır. Ayrıca kullanıcının mevcut <RetaliateIconKeywords:Sayaç>'ını %10 artırır."
  },
  State_3139_Desc = {
    Text = "Ultra Tur’a girdiğinde, üzerindeki Zayıflık ve Kırılganlık durumlarını kaldır ve tüm düşmanlara 2 tur boyunca Zayıflık ve Savunmasız uygula."
  },
  State_3140_Desc = {
    Text = "Savaş başında, \"Fantazma\"yı Ultra Uzay'a yerleştir; Ultra Uzay'da 4 kart olana dek devam et."
  },
  State_3143_Desc = {
    Text = "Gerçek Hasar verdikten sonra, ekibin [Layer] Geçici GÜÇ kaybeder."
  },
  State_3143_Name = {Text = "Felç"},
  State_3144_Name = {
    Text = "Takımındaki \"Zehir\" ve \"Kanama\" yığınlarının sayısı yarıya indirilir."
  },
  State_3145_Desc = {
    Text = "[Layer] tur boyunca kart kullanamazsın."
  },
  State_3145_Name = {
    Text = "Kart Oynanamaz"
  },
  State_3146_Desc = {
    Text = "Denizin Havarisi 1 kart oynadığında, Dokunaç Sınırını yok sayan [StateArg1] Geçici Dokunaç üretir."
  },
  State_3146_Name = {
    Text = "İlahi Vekâlet"
  },
  State_3146_WeaponDesc = {
    Text = "Denizin Havarisi 1 kart oynadığında, Dokunaç Sınırını yok sayan [StateArg1] Geçici Dokunaç üretir."
  },
  State_3149_Desc = {
    Text = "Bir sonraki turun başında, alınan tüm Aktif ve Dokunaç Hasarı +50%."
  },
  State_3149_Name = {
    Text = "Gecikmeli Hasar Artışı"
  },
  State_3149_WeaponDesc = {
    Text = "Alınan tüm Hasar %50 artırılır."
  },
  State_3150_Desc = {
    Text = "Bir turda 3 saldırı aldıktan sonra, 1 yığın Geçici Delilik kazan."
  },
  State_3150_Name = {
    Text = "\"Tatlı Izdırap\""
  },
  State_3151_Desc = {
    Text = "Alındığında kalıcı olarak [Arg1] Güç kazan."
  },
  State_3152_Name = {
    Text = "Durum@Aksesuar Yeniden Evrim"
  },
  State_3152_WeaponDesc = {
    Text = "Taşıyıcının turunun sonunda 3 Aliemus kazan. Taşıyıcının Aliemus Dolumu 10'dan büyükse fazladan 2 Aliemus kazan."
  },
  State_3153_Name = {
    Text = "Durum@Lanetli Sanrılar Eski Hâline Dönüş"
  },
  State_3154_Name = {
    Text = "Kritik Oranı"
  },
  State_3155_Desc = {
    Text = "Her tur, kaybedilen HP'nin %10'unu geri kazan."
  },
  State_3155_Name = {Text = "Sıhhiye"},
  State_3155_WeaponDesc = {
    Text = "Her tur, kaybedilen HP'nin %10'unu geri kazan."
  },
  State_3156_Desc = {
    Text = "Her tur alınan ilk Hasar, beşle çarpılır."
  },
  State_3156_Name = {
    Text = "Panik İçinde"
  },
  State_3160_Desc = {
    Text = "Tur başında, bu tur elde edilen [Arg1] Uyanıklığa sahip bir \"Güneş Şemsiyesi\" eline ekle. 6 Kart oynadıktan sonra, elindeki tüm \"Güneş Şemsiyeleri\"nin Uyanıklığını [Arg2] artır."
  },
  State_3161_Desc = {
    Text = "Rakip [Layer] daha az kart çeker, ancak tüm kartlar Sakla durumunda kalır."
  },
  State_3161_WeaponDesc = {
    Text = "Takımımızın kart çekme miktarı [Layer] azaltılır ve tüm kartlar Sakla kazanır."
  },
  State_3163_Desc = {
    Text = "Ölüm Direnci tetiklenir, [Layer] CP iyileştirir."
  },
  State_3163_Name = {
    Text = "Yıldızların Beşiği"
  },
  State_3163_WeaponDesc = {
    Text = "Ölüm Direnci tetiklenir, [Layer] CP iyileştirir."
  },
  State_3164_Desc = {Text = "—"},
  State_3164_Name = {
    Text = "Kin Helotu Sayısı"
  },
  State_3164_WeaponDesc = {Text = "—"},
  State_3165_Name = {
    Text = "Sürüngen Aydınlanma 3"
  },
  State_3166_Name = {
    Text = "Bu savaş zaten tetiklendi."
  },
  State_3168_Desc = {
    Text = "Tur başında tüm Canavarlara bir saldırı sayısı ekle."
  },
  State_3168_Name = {
    Text = "Durum @ İntikamcının Büyük Bıçağı Baş Kesme Hasarı"
  },
  State_3168_WeaponDesc = {
    Text = "Tur başında tüm Canavarlara bir saldırı sayısı ekle."
  },
  State_3170_Desc = {
    Text = "Dürtüselliğin Bedeli uygula"
  },
  State_3170_Name = {
    Text = "Dürtüselliğin Bedeli uygula"
  },
  State_3170_WeaponDesc = {
    Text = "Dürtüselliğin Bedeli uygula"
  },
  State_3171_Name = {
    Text = "Durum@Aşama2_1Savaş3Balon1"
  },
  State_3172_Desc = {
    Text = "Hasar verirken [StateArg1] Geçici GÜÇ kazan, en fazla [StateArg2] kez birikebilir. Tam biriktiğinde Etki ikiye katlanır."
  },
  State_3172_Name = {
    Text = "Relik Kanlı Çakıl Taşı"
  },
  State_3174_Desc = {
    Text = "Maksimum HP %30 azalır."
  },
  State_3174_Name = {
    Text = "Relik Altıparmaklı 2"
  },
  State_3174_WeaponDesc = {
    Text = "Maksimum HP %30 azalır."
  },
  State_3175_Desc = {
    Text = "Tüm Uyandırıcılar tur başında 10 Aliemus kazanır."
  },
  State_3175_Name = {
    Text = "Relik Altıparmaklı 1"
  },
  State_3175_WeaponDesc = {
    Text = "Tüm Uyandırıcılar tur başında 10 Aliemus kazanır."
  },
  State_3176_Desc = {
    Text = "Prolog: Deste Sıfırlama 0_1_1_1"
  },
  State_3176_Name = {
    Text = "Prolog Deste Sıfırlama 0_1_1_1_2"
  },
  State_3176_WeaponDesc = {
    Text = "Prolog: Deste Sıfırlama 0_1_1_1"
  },
  State_3177_Desc = {
    Text = "<color=#FFC800>\"Uyanıklık\"</color> 3 yüke ulaştığında, geri çekil ve bir <color=#FFC800>\"Yanıltıcı Balmumu Heykel\"</color> çağır.\nYükler tur başında temizlenir."
  },
  State_3177_Name = {
    Text = "Uyanıklık"
  },
  State_3177_WeaponDesc = {
    Text = "<color=#FFC800>\"Uyanıklık\"</color> 3 yüke ulaştığında, geri çekil ve bir <color=#FFC800>\"Yanıltıcı Balmumu Heykel\"</color> çağır.\nYükler tur başında temizlenir."
  },
  State_3178_Desc = {
    Text = "Bir kartın Arithmetica Maliyetini artır."
  },
  State_3178_Name = {
    Text = "<SlowIconKeywords:Durgunluk>"
  },
  State_3178_WeaponDesc = {
    Text = "Her Durgunluk yığını, kartların Arithmetica Maliyetini 1 artırır."
  },
  State_3179_Desc = {
    Text = "Savaş başladığında 20 Kalkan elde et. Tur başında, eğer Kalkanın varsa, o tur için Kalkan Üretimi ve İyileştirme Artışı %50 yükselir."
  },
  State_3179_Name = {
    Text = "Yabancılaşmış Bahçenin Muhafızı"
  },
  State_3179_WeaponDesc = {
    Text = "Savaş başladığında 20 Kalkan elde et. Tur başında, eğer Kalkanın varsa, o tur için Kalkan Üretimi ve İyileştirme Artışı %50 yükselir."
  },
  State_3180_Desc = {
    Text = "Kritik Oranı %25 artar. HP yeniledikten sonra, iyileştirenin Kritik Oranına eşit bir olasılıkla HP'yi bir kez daha yenileme şansı vardır."
  },
  State_3180_Name = {
    Text = "Durum@Hayalet_Gümüş_Anahtar: Kritik_İyileştirme"
  },
  State_3181_Name = {
    Text = "Kritik Oranı"
  },
  State_3183_Desc = {
    Text = "Bu tur Krit. Hasar [Layer]% artar."
  },
  State_3183_Name = {
    Text = "Geçici Kritik Hasar"
  },
  State_3185_Desc = {
    Text = "Hareket ederken fazladan Stres"
  },
  State_3185_Name = {
    Text = "Kalıntı Dipsiz Çanta 2"
  },
  State_3185_WeaponDesc = {
    Text = "Hareket ederken fazladan Stres"
  },
  State_3189_Name = {
    Text = "Canavar Geciktirme Gücü"
  },
  State_3190_Name = {
    Text = "Relik Anahtar"
  },
  State_3193_Desc = {
    Text = "Sonraki turun başında [Layer] Karakter Kalkanı elde et."
  },
  State_3193_Name = {
    Text = "Yitik Sanat"
  },
  State_3193_WeaponDesc = {
    Text = "Sonraki turun başında [Layer] Karakter Kalkanı elde et."
  },
  State_3196_Desc = {
    Text = "Oynandığında, [StateArg1] Arithmetica geri kazan."
  },
  State_3196_Name = {
    Text = "<Rune_4_High:Gelişmiş Hesaplama>"
  },
  State_3196_WeaponDesc = {
    Text = "Oynandığında, [StateArg1] Arithmetica geri kazan."
  },
  State_3197_Desc = {
    Text = "\"Darbe\" [Arg1] HP yeniler ve Kan Akıtma ile Zehir yığınlarını yarıya indirir."
  },
  State_3197_Name = {
    Text = "Hemostatik kelepçe"
  },
  State_3200_Desc = {
    Text = "Takıma Özel: Kuşananın Temel Hasar’ı ve Karakter Kalkanı <WeaponEffect_Num:[StateArg1]%> artar. Keşfin başında, kuşananın bir \"Darbe\" si ve bir \"Savunma\" sı desteye eklenir. Kuşanan \"Savunma\" oynadıktan sonra, bir sonraki \"Darbe\" nin Krit. Oranı ve Krit. Hasar’ı %15 artar. Kuşanan \"Darbe\" oynadıktan sonra, bir sonraki \"Savunma\" nın Karakter Kalkanı %15 artar. En fazla 3 defaya kadar birikebilir."
  },
  State_3200_WeaponDesc = {
    Text = "Kuşananın Temel Hasarı ve Karakter Kalkanı Üretimi <WeaponEffect_Num:[StateArg1]%>. Keşfin başında, kuşananın destesine bir \"Darbe\" ve bir \"Savunma\" eklenir. Kuşanan \"Savunma\" oynadıktan sonra, bir sonraki \"Darbe\" +%15 Kritik Oranı ve Kritik Hasar kazanır. Kuşanan \"Darbe\" oynadıktan sonra, bir sonraki \"Savunma\" +%15 Karakter Kalkanı üretir; bu etki en fazla 3 kez birikir."
  },
  State_3201_Desc = {Text = "—"},
  State_3201_Name = {
    Text = "Kin Zinciri"
  },
  State_3201_WeaponDesc = {Text = "—"},
  State_3203_Desc = {
    Text = "Takım Özgünlüğü: Kullananın sağladığı Kalkan <WeaponEffect_Num:[StateArg3]%> artar. Kullananın \"Savunma\"sı, en yüksek Cana sahip düşmana kullananın SAV'ının <WeaponEffect_Num:[StateArg1]%>'si kadar <IntoxicationIconKeywords:Zehir> uygular. Mevcut Diyar \"Caro\" ise <IntoxicationIconKeywords:Zehir> uygulandığında <EmbryoFusionIconKeywords:Embriyo Füzyonu> +<WeaponEffect_Num:[Blood:StateArg2]>, bu etki her tur en fazla 3 kez tetiklenir."
  },
  State_3203_WeaponDesc = {
    Text = "Kullananın sağladığı Kalkan <WeaponEffect_Num:[StateArg3]%> artar. Kullananın \"Savunma\"sı, en yüksek Cana sahip düşmana <WeaponEffect_Num:[Poison:DescArg1]> kat <IntoxicationIconKeywords:Zehir> uygular. Mevcut Diyar \"Caro\" ise <IntoxicationIconKeywords:Zehir> uygulandığında <EmbryoFusionIconKeywords:Embriyo Füzyonu> +<WeaponEffect_Num:[Blood:StateArg2]>, bu etki her tur en fazla 3 kez tetiklenir."
  },
  State_3204_Desc = {
    Text = "Gerçek Hasar verdiğinde, Çekme Desteğine [StateArg1] \"Yara\" karıştır."
  },
  State_3204_Name = {
    Text = "Yırtık Yara"
  },
  State_3204_WeaponDesc = {
    Text = "Çekildiğinde, kendine 1 tur boyunca Zayıflık uygula. Kullanıldığında, tüm düşmanlara 1 tur boyunca Zayıflık uygula. Satılamaz."
  },
  State_3206_Desc = {
    Text = "Bu tur oynanan her kart, Kritik Oranını [StateArg1]% artırır, en fazla [StateArg2] yığına kadar birikir. Yığınlar dolduğunda Etki iki katına çıkar."
  },
  State_3206_Name = {
    Text = "Relik Memphis Ritüel Aynası"
  },
  State_3206_WeaponDesc = {
    Text = "Bu tur oynanan her kart, Kritik Oranını [StateArg1]% artırır, en fazla [StateArg2] yığına kadar birikir. Yığınlar dolduğunda Etki iki katına çıkar."
  },
  State_3207_Desc = {
    Text = "Kaybedilen her 1 YP için 1 yığın kaldır. Yığın sayısı 0’a ulaştığında, [DescArg1] Karakter Kalkanı kazan."
  },
  State_3207_Name = {
    Text = "Boyutsal Savunma Duvarı"
  },
  State_3208_Desc = {
    Text = "Taşlaştırılmış, hareket edemez. Tur sonunda kaldırılır."
  },
  State_3208_Name = {
    Text = "<PetrifactionColour:Taşlaştırma>"
  },
  State_3209_Name = {
    Text = "Aksesuar Yaşam Tükenmesi"
  },
  State_3209_WeaponDesc = {
    Text = "Savaş başında, Kuşanan Caro sınıfındaysa, Saldırı gücünü %25 artır."
  },
  State_3210_Name = {
    Text = "Durum@İntikam Kılıcı Aydınlanma 1"
  },
  State_3211_Desc = {
    Text = "El sınırını 2 artır. Tur sonunda elini atma. HP kaybettiğinde, 2 Rastgele kart at."
  },
  State_3212_Desc = {
    Text = "Verilen Aktif ve Dokunaç Hasarı -%25, tur sonunda 1 yığın kaldırılır."
  },
  State_3212_Name = {
    Text = "<WeaknessIconKeywords:Zayıflık>"
  },
  State_3212_WeaponDesc = {
    Text = "Verilen tüm Hasar %25 azaltılır."
  },
  State_3213_Desc = {
    Text = "Kalkan ve İyileştirme etkileri [Layer]% artırılır."
  },
  State_3213_Name = {
    Text = "Geçici Kalkan ve İyileştirme Güçlendirme Etkisi"
  },
  State_3213_WeaponDesc = {
    Text = "Kalkan ve İyileştirme etkileri [Layer]% artırılır."
  },
  State_3215_Name = {
    Text = "Krono Sarkaç \"Okült\""
  },
  State_3216_Desc = {
    Text = "Savaştan sonra fazladan 100 Kara Mühür elde et, ancak rastgele bir Semptom geliştir."
  },
  State_3216_Name = {
    Text = "Kalıntı Uğurlu Yüzük"
  },
  State_3216_WeaponDesc = {
    Text = "Savaştan sonra fazladan 100 Kara Mühür elde et, ancak rastgele bir Semptom geliştir."
  },
  State_3220_Desc = {
    Text = "Bir Yücelik serbest bırakıldıktan sonra 1 kart çek. HP %25'in altındaysa, fazladan 1 kart daha çek."
  },
  State_3223_Desc = {
    Text = "Zayıflık etkisini %10 artırır. Her 3 turda bir tüm düşmanlara 1 yığın Zayıflık ekler."
  },
  State_3224_Name = {
    Text = "Relik Arcana Arşivi Arithmetica"
  },
  State_3225_Name = {
    Text = "Kafatası Biçen"
  },
  State_3226_Desc = {
    Text = "Oynandıktan sonra, kart Atılmış Kart Destesi’ne gitmez ve bu Savaşta tekrar kullanılamaz."
  },
  State_3226_Name = {Text = "Tüketme"},
  State_3226_WeaponDesc = {
    Text = "Oynandıktan sonra, kart Atılmış Kart Destesi’ne gitmez ve bu Savaşta tekrar kullanılamaz."
  },
  State_3227_Desc = {
    Text = "Tüm Kalıntı fiyatları %50 azaltılır."
  },
  State_3227_Name = {
    Text = "Kalıntı Ticaret Madalyası"
  },
  State_3227_WeaponDesc = {
    Text = "Tüm Kalıntı fiyatları %50 azaltılır."
  },
  State_3228_Desc = {
    Text = "Tur başında, en düşük Aliemus'a sahip Uyanan 25 Aliemus kazanır."
  },
  State_3228_Name = {
    Text = "Kalıntı Arcana Aliemus"
  },
  State_3228_WeaponDesc = {
    Text = "Tur başında, en düşük Aliemus'a sahip Uyanan 25 Aliemus kazanır."
  },
  State_3229_Desc = {
    Text = "Prolog: Deste Sıfırlama 0_1_1_1"
  },
  State_3229_Name = {
    Text = "Prolog: Deste Sıfırlama 0_1_1_1"
  },
  State_3229_WeaponDesc = {
    Text = "Prolog: Deste Sıfırlama 0_1_1_1"
  },
  State_3230_Name = {
    Text = "Durum@Üretim Gecikmesi Arithmetica"
  },
  State_3232_Desc = {
    Text = "Durum@Canavar Ultra Yuva Tetikleyici"
  },
  State_3232_Name = {
    Text = "Durum@Canavar Ultra Yuva Tetikleyici"
  },
  State_3232_WeaponDesc = {
    Text = "Durum@Canavar Ultra Yuva Tetikleyici"
  },
  State_3234_Desc = {
    Text = "Savaşın başında 3 Güç kazan, fakat 5 fazladan Hasar al."
  },
  State_3234_Name = {
    Text = "Son Çığlık"
  },
  State_3235_Desc = {
    Text = "Savaş başında [Layer] Güç kazan, ancak 5 fazladan Hasar al."
  },
  State_3235_Name = {
    Text = "Son Çığlık"
  },
  State_3236_Desc = {
    Text = "Oynandığında, diğer tüm Uyananların Aliemus’unu <Energy:[StateArg1]> artır."
  },
  State_3236_Name = {
    Text = "<Rune_16_High:İleri Kataliz>"
  },
  State_3237_Desc = {
    Text = "Her 3 turda bir 3 Dokunaç kazan. Bu Dokunaçlar Dokunaç Sınırını yok sayar ve turun sonunda kaldırılır."
  },
  State_3238_Desc = {
    Text = "Savaşın başında, canavarlara verilen tüm Hasarı artıran bir durum kazan."
  },
  State_3238_Name = {
    Text = "Savaşın başında, canavarlara verilen tüm Hasarı artıran bir durum kazan."
  },
  State_3238_WeaponDesc = {
    Text = "Savaşın başında, canavarlara verilen tüm Hasarı artıran bir durum kazan."
  },
  State_3239_Desc = {
    Text = "[Layer] Saldırısını artır."
  },
  State_3239_Name = {
    Text = "Genel Saldırı Artışı"
  },
  State_3239_WeaponDesc = {
    Text = "[Layer] Saldırısını artır."
  },
  State_3242_Name = {
    Text = "Çekme Destesi’ne 2 <DerivativeCardKeywords_4:\"Insight\"> kartı ekle."
  },
  State_3243_Desc = {
    Text = "Kart Arithmetica Artışı"
  },
  State_3243_Name = {
    Text = "Kart Arithmetica Artışı"
  },
  State_3243_WeaponDesc = {
    Text = "Kart Arithmetica Artışı"
  },
  State_3244_Desc = {
    Text = "Çağrılan Canavarların HP’si ikiye katlanır."
  },
  State_3244_Name = {
    Text = "\"Taşan Suçluluk\""
  },
  State_3244_WeaponDesc = {
    Text = "Çağrılan Canavarların HP’si ikiye katlanır."
  },
  State_3245_Desc = {
    Text = "Savaşın başında, takımınızın Kritik Oranı %30 azalır ve Krit. Hasar %30 artar."
  },
  State_3245_Name = {Text = "Bastırma"},
  State_3245_WeaponDesc = {
    Text = "Savaşın başında, takımınızın Kritik Oranı %30 azalır ve Krit. Hasar %30 artar."
  },
  State_3246_Desc = {
    Text = "Savaş başında tüm sıradan düşmanların HP’si %30 artar. Savaşı kazandığında fazladan 25 Kara Mühür kazan."
  },
  State_3246_Name = {
    Text = "Kalıntı Yırtık Savaş Sancağı"
  },
  State_3246_WeaponDesc = {
    Text = "Savaş başında tüm sıradan düşmanların HP’si %30 artar. Savaşı kazandığında fazladan 25 Kara Mühür kazan."
  },
  State_3247_Desc = {
    Text = "[Exalt] Elde bulunan tüm kartların Arithmetica Maliyetini 1 azaltır."
  },
  State_3247_Name = {
    Text = "Mutasyona Uğramış Uygarlığın Işığı"
  },
  State_3247_WeaponDesc = {
    Text = "[Exalt] Elde bulunan tüm kartların Arithmetica Maliyetini 1 azaltır."
  },
  State_3249_Desc = {
    Text = "Diğer müttefikler 1 yığın Delilik kazanır; bu birim öldüğünde kaldırılır."
  },
  State_3249_Name = {
    Text = "Huzursuzluk"
  },
  State_3249_WeaponDesc = {
    Text = "Diğer müttefikler 1 yığın Delilik kazanır; bu yığın, büyücünün ölümüyle kaldırılır."
  },
  State_3250_Desc = {
    Text = "Savaş bittikten sonra deste içinde kalmaya devam eder, ancak oynanırsa veya tüketilirse kalıcı olarak kaldırılır."
  },
  State_3250_Name = {
    Text = "<DestructionKeywords:Yıkım>"
  },
  State_3250_WeaponDesc = {
    Text = "Kullandıktan sonra onu kalıcı olarak kaldır."
  },
  State_3251_Desc = {
    Text = "Aktif veya Dokunaç Hasarı alındığında, hasara karşı bağışıklık kazanır ve 1 yığın kaybeder. Tur başında kaldırılır."
  },
  State_3251_Name = {
    Text = "<ParcloseColour:Geçici Bariyer>"
  },
  State_3252_Desc = {
    Text = "Balçık Çiçeği, kalkan uygulandığında Maksimum CP'yi [StateArg2] artırır."
  },
  State_3252_Name = {
    Text = "Balçık Yakınsaması"
  },
  State_3252_WeaponDesc = {
    Text = "Balçık Çiçeği, kalkan uygulandığında Maksimum CP'yi [StateArg2] artırır."
  },
  State_3253_Desc = {
    Text = "[StateArg1] Geçici Alarm kazan."
  },
  State_3253_Name = {
    Text = "<CardKeyWord:Kalkan: Meka>"
  },
  State_3253_WeaponDesc = {
    Text = "[StateArg1] Geçici Alarm elde et"
  },
  State_3255_Name = {Text = "Sayaç"},
  State_3256_Name = {
    Text = "Durum@Lanetli Mani"
  },
  State_3259_Desc = {
    Text = "Verilen Aktif Hasar sayısını [Layer] artırır."
  },
  State_3259_Name = {
    Text = "<MadnessColour:Delilik>"
  },
  State_3260_Desc = {
    Text = "Ultra Uzay dolduğunda fazladan bir tur kazan. Bu turda Çekme Desteğinden kart çekme; bunun yerine Ultra Uzay’daki kartları eline al."
  },
  State_3260_Name = {
    Text = "<DimensionalSpaceIconKeywords:Ultra Uzay>"
  },
  State_3260_WeaponDesc = {
    Text = "Ultra Uzay sınırına ulaştığında, fazladan bir Ultra Tur elde et ve tüm Ultra Uzay kartlarını eline ekle."
  },
  State_3261_Desc = {
    Text = "Çağrılan Canavarların Hasarı ikiye katlanır."
  },
  State_3261_Name = {
    Text = "\"Balmumu Heykel Ordusu\""
  },
  State_3261_WeaponDesc = {
    Text = "Çağrılan Canavarların Hasarı ikiye katlanır."
  },
  State_3262_Desc = {
    Text = "Durum@Takımımız İçin Balmumu Kaplama"
  },
  State_3262_Name = {
    Text = "Durum@Takımımız İçin Balmumu Kaplama"
  },
  State_3262_WeaponDesc = {
    Text = "Durum@Takımımız İçin Balmumu Kaplama"
  },
  State_3263_Name = {
    Text = "Durum@Nautilus Kabuğu Karşı Saldırı"
  },
  State_3264_Name = {
    Text = "Garantili Kritik"
  },
  State_3265_Name = {
    Text = "Atıldığında Kaldırılır"
  },
  State_3266_Desc = {
    Text = "Düşlerin Nekropolisi'nin Güçlendirilmiş Sıçrayışı"
  },
  State_3266_Name = {
    Text = "Durum@Ölüm Rüyası Şehri Güçlendir Sıçrama"
  },
  State_3267_Desc = {
    Text = "Savaş başladığında, [Waxed Armor]'den 5 yığın elde edin."
  },
  State_3267_Name = {
    Text = "\"Balmumu Beyefendi\""
  },
  State_3267_WeaponDesc = {
    Text = "Savaş başladığında, [Waxed Armor]'den 5 yığın elde edin."
  },
  State_3268_Desc = {
    Text = "Tur başında 1 kart çek. Çekilen her kartın Arithmetica Maliyeti rastgele (0–4) olarak değişir."
  },
  State_3268_Name = {
    Text = "Relik Kaleydoskop"
  },
  State_3268_WeaponDesc = {
    Text = "Tur başında 1 kart çek. Çekilen her kartın Arithmetica Maliyeti rastgele (0–4) olarak değişir."
  },
  State_3269_Desc = {
    Text = "Her tur ikinci Kalkan kazanıldığında [Arg1] yığın Sayaç kazan. Her tur 4. Kalkan kazanıldığında, tüm düşmanlara 1 Sayaç Hasarı ver."
  },
  State_3269_Name = {
    Text = "Serbest kalan gerçek"
  },
  State_3270_Name = {
    Text = "Durum@İkinci Bölüm Rezonans Kopyası"
  },
  State_3271_Desc = {
    Text = "[Strike] Tüm düşmanlara [Arg1] yığın Zehir uygular."
  },
  State_3272_Desc = {
    Text = "Engellenmeyen Hasar verdiğinde, verilen gerçek Hasarın 3 katı kadar iyileş. Bu etki, Hasar verdiğinde kaldırılır."
  },
  State_3272_Name = {
    Text = "Yaşam Gücü Emilimi"
  },
  State_3273_Desc = {
    Text = "Takıma Özel: Kuşananın kartını oynadıktan sonra, Kuşananın Savunmasının <WeaponEffect_Num:[StateArg1]%>’ine eşit bir Karakter Kalkanı kazanırsın. Her bir Dokunaç için, Karakter Kalkanı Kuşananın Savunmasının ek <WeaponEffect_Num:[StateArg2]%>’i kadar artar. Bu Etki tur başına yalnızca bir kez tetiklenir."
  },
  State_3273_Name = {
    Text = "Bayan Mercan'ın Ölümü"
  },
  State_3273_WeaponDesc = {
    Text = "Taşıyıcının kartı oynandıktan sonra <WeaponEffect_Num:[Block:DescArg1]> Kalkan kazan. Her bir Dokunaç için Kalkanı <WeaponEffect_Num:[DescArg2]> artır. Bu etki tur başına yalnızca bir kez tetiklenir."
  },
  State_3274_Desc = {
    Text = "Her Aktif Hasar aldığınızda ekibinize bir yığın ekleyin."
  },
  State_3274_Name = {
    Text = "Durum@İntikamcı Büyük Bıçak Takımımıza Baş Kesme Hasarı Sayısı"
  },
  State_3274_WeaponDesc = {
    Text = "Her Aktif Hasar aldığınızda ekibinize bir yığın ekleyin."
  },
  State_3277_Desc = {
    Text = "Oynandığında, bu Uyanan’ın Aliemus’unu <Energy:[StateArg1]> artır."
  },
  State_3277_Name = {
    Text = "<Rune_5:Çılgınlık>"
  },
  State_3280_Name = {
    Text = "Mukadder Darbe"
  },
  State_3281_Desc = {
    Text = "Verilen Aktif Hasarı artır."
  },
  State_3281_Name = {
    Text = "<PowerIconKeywords:GÜÇ>"
  },
  State_3281_WeaponDesc = {
    Text = "Verilen Hasarı artır."
  },
  State_3282_Desc = {
    Text = "Vuruş Sayısı ve Hasar Artışı."
  },
  State_3282_Name = {
    Text = "<CardKeyWord:Yükseltme>"
  },
  State_3282_WeaponDesc = {
    Text = "Hasarı bir kez daha artır"
  },
  State_3283_Desc = {
    Text = "Tur başında [StateArg1] HP yenile. HP %50'nin altındaysa, iyileştirme [StateArg2] olur."
  },
  State_3283_Name = {
    Text = "Relik Günlük Bileşimi"
  },
  State_3283_WeaponDesc = {
    Text = "Tur başında [StateArg1] HP yenile. HP %50'nin altındaysa, iyileştirme [StateArg2] olur."
  },
  State_3287_Desc = {
    Text = "Savaşın başında, destesine 2 \"Kavrayış\" kartı karıştır. Her savaş zaferi bu yadigârı Yükseltme sağlar, en fazla 3 kez."
  },
  State_3288_Desc = {
    Text = "Durum@Boş Durum"
  },
  State_3288_Name = {
    Text = "Durum@Boş Durum"
  },
  State_3288_WeaponDesc = {
    Text = "Durum@Boş Durum"
  },
  State_3289_Desc = {
    Text = "Alınan her Hasar puanı bir yığını azaltır. 0 yığında, niyeti Sönmez Çiçek ile değiştir ve Savunma odaklı beceriler kullan."
  },
  State_3289_Name = {
    Text = "Sönmez Çiçek"
  },
  State_3289_WeaponDesc = {
    Text = "Alınan her 1 Hasar için 1 yığın kaybeder. Yığınlar 0'a ulaştığında Savunma moduna geçer."
  },
  State_3290_Desc = {
    Text = "Bir zamanlar “Miryam” olarak bilinen yaratık, aşırı paranoya ve umutsuzluğa gömüldü. Binlerce yıllık Deliliği sona erdirmek için son sanrılarını paramparça et."
  },
  State_3290_Name = {Text = "Takıntı"},
  State_3291_Desc = {
    Text = "Gerçek Hasar verdikten sonra, takımın 3 Geçici GÜÇ kaybeder."
  },
  State_3291_Name = {Text = "Felç"},
  State_3292_Desc = {
    Text = "Yücelt’i serbest bıraktığında, bir düşman her Hasar vermek üzere olduğunda onlara [Arg1] yığın Zehir uygula."
  },
  State_3293_Desc = {
    Text = "Bu Aşamada verilen Hasar [Layer] azalır."
  },
  State_3293_Name = {Text = "STR▼"},
  State_3293_WeaponDesc = {
    Text = "Bu aşamadaki Hasar ve Dokunaç Hasar Azaltma [Layer] kadar azaltılır."
  },
  State_3294_Name = {
    Text = "Durum@Lanetli Paranoya"
  },
  State_3296_Desc = {
    Text = "Atıldığında ya da oynandığında onu kaldır."
  },
  State_3296_Name = {
    Text = "Bu kartı atıldığında veya oynandığında kaldır."
  },
  State_3296_WeaponDesc = {
    Text = "Çekildiğinde, kendine 1 tur boyunca Zayıflık uygula. Kullanıldığında, tüm düşmanlara 1 tur boyunca Zayıflık uygula. Satılamaz."
  },
  State_3297_Desc = {
    Text = "Durum@Diken Kraliçesi Qiming_Formu"
  },
  State_3297_Name = {
    Text = "Durum@Diken Kraliçesi Qiming_Formu"
  },
  State_3297_WeaponDesc = {
    Text = "Durum@Diken Kraliçesi Qiming_Formu"
  },
  State_3298_Desc = {
    Text = "Bu turdaki bir sonraki Sıçrama etkisi, tetiklenmesi garanti edilir."
  },
  State_3298_Name = {
    Text = "Garantili Sıçrama"
  },
  State_3298_WeaponDesc = {
    Text = "Sıçrama Etkisi bu tur koşul gerektirmez."
  },
  State_3301_Name = {
    Text = "Yıldız Şarabı Sayacı"
  },
  State_3302_Desc = {
    Text = "Ebedi Donma Uygula"
  },
  State_3302_Name = {
    Text = "Ebedi Donma Uygula"
  },
  State_3302_WeaponDesc = {
    Text = "Ebedi Donma Uygula"
  },
  State_3304_Desc = {
    Text = "Her turun sonunda, son Komut Kartı’na karşılık gelen Uyanan oynandığında 15 Aliemus kazan. \"Anne Heykeli\"ne de sahipsen, diğer Uyananlara 5 Aliemus ver."
  },
  State_3305_Desc = {
    Text = "Oynandığında, Çekme Desteğine [StateArg1] adet <DerivativeCardKeywords_4:\"Kavrayış\"> karıştır."
  },
  State_3305_Name = {
    Text = "<Rune_17:Kavrayış>"
  },
  State_3307_Name = {
    Text = "(Kalan:[Layer])"
  },
  State_3308_Desc = {
    Text = "Tur başında, önceki turda elde 2'den fazla kart kaldıysa 2 Arithmetica kazan."
  },
  State_3309_Desc = {
    Text = "Kuşananın Hasarı, Karakter Kalkanı ve İyileştirmesi +[StateArg1]%. (Geçici)"
  },
  State_3309_Name = {
    Text = "Durum@Prototip Uzun Kılıç Direnç"
  },
  State_3310_Desc = {
    Text = "Göçmen kalkan uyguladığında, [Energy:StateArg2] Aliemus elde et."
  },
  State_3310_Name = {
    Text = "Kendini Hapsediş"
  },
  State_3310_WeaponDesc = {
    Text = "Göçmen kalkan uyguladığında, [Energy:StateArg2] Aliemus elde et."
  },
  State_3312_Desc = {
    Text = "Her Can yenilediğinde [Arg1] Sayaç kazan. Canın %75’in üzerindeyse, fazladan [Arg2] Sayaç kazan."
  },
  State_3313_Desc = {
    Text = "Tur başında, bu tur için [Arg1] Güç kazan. Oynanan her kart için bu tur [Arg2] Güç kaybet."
  },
  State_3314_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_3314_Name = {
    Text = "Uyanmamış"
  },
  State_3315_Desc = {
    Text = "Her tur ilk kartı oynadıktan sonra, eldeki 2 Rastgele kartı özgün hâllerine dönüştür. Tur sonunda eski hâllerine geri dönerler."
  },
  State_3315_Name = {
    Text = "Relik Büyüleyici Çan"
  },
  State_3316_Desc = {
    Text = "Tur sonunda Karakter Kalkanı Sakla özelliğini korur."
  },
  State_3316_Name = {
    Text = "Muhafaza Bariyeri"
  },
  State_3316_WeaponDesc = {
    Text = "Tur sonunda Karakter Kalkanı Sakla özelliğini korur."
  },
  State_3317_Desc = {
    Text = "Tur sonunda tüm Karakter Kalkanını kaybet"
  },
  State_3317_Name = {
    Text = "Zincirler: Öz Baba"
  },
  State_3318_Name = {
    Text = "Durum@Kan Susuzluğu Kucaklama Yutma İşaretçisi"
  },
  State_3323_Desc = {
    Text = "Kuşananın Hasarı, Karakter Kalkanı ve İyileştirmesi +[StateArg1]%. (Geçici)"
  },
  State_3323_Name = {
    Text = "Durum@Proto Uzun Kılıç Aliemus"
  },
  State_3324_Desc = {
    Text = "Bu tur Krit. Hasar [Layer]% artar."
  },
  State_3324_Name = {
    Text = "Geçici Kritik Hasar"
  },
  State_3324_WeaponDesc = {
    Text = "Bu tur Krit. Hasar [Layer]% artar."
  },
  State_3325_Desc = {
    Text = "Desteği her sıfırladığında, bu tur [Arg1] Güç kazanmış 2 \"Dikenli Üç Dişli Zıpkın\" ve bu tur [Arg2] Uyanıklık kazanmış 1 \"Güneş Şemsiyesi\" eline ekle."
  },
  State_3326_Desc = {
    Text = "Her tur alınan ilk Aktif Hasara karşı Bağışıklık."
  },
  State_3326_Name = {Text = "Azimli"},
  State_3326_WeaponDesc = {
    Text = "Her tur alınan ilk Aktif Hasara karşı Bağışıklık."
  },
  State_3327_Desc = {
    Text = "Ölüm Öncesi Canavar Canı."
  },
  State_3327_Name = {
    Text = "Ölüm Öncesi Canavar Canı"
  },
  State_3327_WeaponDesc = {
    Text = "Ölüm Öncesi Canavar Canı."
  },
  State_3328_Desc = {
    Text = "Bu savaşta, Ölümcül HASAR aldığında bir kez dirilir ve [Layer] CP geri kazanırsın. Bu Etki dağıtılamaz."
  },
  State_3328_Name = {
    Text = "Ölümsüz Cennet Kuşu"
  },
  State_3329_Desc = {
    Text = "5 kart oyna; elindeki en soldaki kartın bir kopyasını elde et, bu kopyaya Tüketme ve Geçicilik eklenir."
  },
  State_3330_Desc = {
    Text = "Kartın Arithmetica Maliyeti [Layer] artar. Bu zayıflatma, kart oynandıktan sonra kaldırılır."
  },
  State_3330_Name = {
    Text = "<SlowColour:Durgunluk [Layer]>"
  },
  State_3330_WeaponDesc = {
    Text = "Kart Arithmetica Maliyeti [Layer] artar."
  },
  State_3332_Desc = {
    Text = "Aktif veya Dokunaç Hasarı alındığında, Hasara bağışık olur ve 1 yığın kaybedilir."
  },
  State_3332_Name = {
    Text = "<ParcloseColour:Bariyer>"
  },
  State_3335_Desc = {
    Text = "Savaşın başında, tüm düşmanlara 1 yığın Savunmasız uygula. \"Durağanlık Laneti\", düşmanlar üzerindeki Savunmasız etkisini %25 artırır."
  },
  State_3335_Name = {
    Text = "Taş Göz Aydınlanma 6"
  },
  State_3336_Name = {
    Text = "Durum@George@Ölüm üzerine iyileştirme"
  },
  State_3337_Desc = {Text = "—"},
  State_3337_Name = {
    Text = "Kızıl Ayin"
  },
  State_3337_WeaponDesc = {Text = "—"},
  State_3339_Desc = {
    Text = "[Layer] Saldırısını artır."
  },
  State_3339_Name = {
    Text = "Geçici Saldırı Gücü Artışı"
  },
  State_3339_WeaponDesc = {
    Text = "[Layer] Saldırısını artır."
  },
  State_3340_Desc = {
    Text = "Exalt kullandıktan sonra, bu savaş boyunca Exalt Hasarını [Arg1] artır; en fazla 5 kez birikebilir. Tam yüklendiğinde, bu Exalt'ı kullanan Uyandıran 100 Aliemus kazanır."
  },
  State_3341_Desc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_1"
  },
  State_3341_Name = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_1"
  },
  State_3341_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_1"
  },
  State_3342_Desc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_2"
  },
  State_3342_Name = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_2"
  },
  State_3342_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_2"
  },
  State_3343_Desc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_3"
  },
  State_3343_Name = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_3"
  },
  State_3343_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_3"
  },
  State_3344_Desc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_4"
  },
  State_3344_Name = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_4"
  },
  State_3344_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_4"
  },
  State_3345_Desc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_5"
  },
  State_3345_Name = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_5"
  },
  State_3345_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_5"
  },
  State_3346_Desc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_5"
  },
  State_3346_Name = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_5"
  },
  State_3346_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_2_6"
  },
  State_3347_Desc = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_5"
  },
  State_3347_Name = {
    Text = "Durum@Prolog Deste Sıfırlama 0_1_2_5"
  },
  State_3347_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_2_7"
  },
  State_3348_Desc = {
    Text = "Oynandığında [StateArg1] kart çek."
  },
  State_3348_Name = {
    Text = "<Rune_3_High:İleri Ustalık>"
  },
  State_3348_WeaponDesc = {
    Text = "Oynandığında [StateArg1] kart çek."
  },
  State_3350_Desc = {
    Text = "Bir Yüceliş serbest bıraktıktan sonra mevcut Canının %10’unu kaybet ve bu tur tüm düşmanlardan [Arg1] GÜÇ çal."
  },
  State_3351_Name = {
    Text = "Durum@Desteye katıldıktan sonra"
  },
  State_3352_Name = {
    Text = "Relik Göksel Usturlap 1"
  },
  State_3354_Name = {
    Text = "Relik Göksel Usturlap 2"
  },
  State_3356_Name = {
    Text = "Tur Sonu: Boğulma Zehirlenmesi"
  },
  State_3357_Desc = {
    Text = "Sonraki turun başlamasından sonra Dokunaç Hasarı +[Layer]."
  },
  State_3357_Name = {
    Text = "Gecikmeli Dokunaç HASARI"
  },
  State_3358_Desc = {
    Text = "Sonraki turun başında [Layer] Karakter Kalkanı kazan."
  },
  State_3358_Name = {
    Text = "Yitik Sanat: Kalkan"
  },
  State_3359_Desc = {
    Text = "Oynadığın her üçüncü kart iki kez Etki gösterir."
  },
  State_3359_Name = {
    Text = "Relik Yıldız Demlemesi+"
  },
  State_3359_WeaponDesc = {
    Text = "Oynadığın her üçüncü kart iki kez Etki gösterir."
  },
  State_3360_Desc = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_4_1"
  },
  State_3360_Name = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_4_1"
  },
  State_3360_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_4_1"
  },
  State_3362_Desc = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_4_1"
  },
  State_3362_Name = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_4_1"
  },
  State_3362_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_4_1"
  },
  State_3364_Desc = {
    Text = "Alındığında, bir kart seç ve ona üç seçenekli iki Güçlendirme Etkisi uygula. (Not: Bin Serap kart üretimine benzer)"
  },
  State_3365_Desc = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_4_1"
  },
  State_3365_Name = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_4_1"
  },
  State_3365_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_4_1"
  },
  State_3366_Desc = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_4_1"
  },
  State_3366_Name = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_4_1"
  },
  State_3366_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_4_1"
  },
  State_3368_Desc = {
    Text = "Arithmetica Maliyeti, atma aşamasından önce 5’i aşarsa taşa dönüşür."
  },
  State_3368_Name = {
    Text = "Taşlaştır"
  },
  State_3368_WeaponDesc = {
    Text = "Atma aşamasından önce, elindeki kartları taşa dönüştür."
  },
  State_3369_Desc = {
    Text = "Tüm Yutma etkilerin Sonsuz Yutma olur."
  },
  State_3369_Name = {
    Text = "Sonsuz Yutma"
  },
  State_3369_WeaponDesc = {
    Text = "Tüm Yutma etkilerin Sonsuz Yutma olur."
  },
  State_3370_Desc = {
    Text = "Bu aşamada Karakter Kalkanı Üretimi [Layer] azalır."
  },
  State_3370_Name = {
    Text = "Kalıcı Tetikte Düşüşü"
  },
  State_3370_WeaponDesc = {
    Text = "Bu aşamada Karakter Kalkanı Üretimi [Layer] azalır."
  },
  State_3372_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_3372_Name = {
    Text = "Uyanmamış"
  },
  State_3373_Desc = {
    Text = "Gerçek Hasar verdiğinde, Çekme Desteğine [StateArg1] \"Yara\" karıştır."
  },
  State_3373_Name = {Text = "Boğulma"},
  State_3373_WeaponDesc = {
    Text = "Çekildiğinde, kendine 1 tur boyunca Zayıflık uygula. Kullanıldığında, tüm düşmanlara 1 tur boyunca Zayıflık uygula. Satılamaz."
  },
  State_3374_Desc = {
    Text = "Tur bitiminden sonra, eşit miktarda Güç yığını kazan."
  },
  State_3374_Name = {Text = "Öfke"},
  State_3376_Desc = {
    Text = "Taşkınlık HASARI bu savaş boyunca [Layer] artar."
  },
  State_3376_Name = {
    Text = "Taşkınlık Hasar Artışı"
  },
  State_3378_Desc = {
    Text = "Yüceltme tetiklendikten sonra, oynanan bir sonraki Kart iki kez Etki gösterir."
  },
  State_3378_Name = {
    Text = "Durum@İllüzyon Gümüş Anahtar: Patlama"
  },
  State_3379_Desc = {
    Text = "HP %50'nin altına düştüğünde, Zincir Kırıcı çılgına döner."
  },
  State_3379_Name = {
    Text = "İntikam Anı"
  },
  State_3379_WeaponDesc = {
    Text = "HP %50'nin altına düştüğünde, Zincir Kırıcı çılgına döner."
  },
  State_3380_Desc = {
    Text = "Savaşın başında, bir [Confusion]’i Çekme Destenin içine Karıştır."
  },
  State_3380_Name = {
    Text = "Büyülenme"
  },
  State_3380_WeaponDesc = {
    Text = "Savaşın başında, bir [Confusion]’i Çekme Destenin içine Karıştır."
  },
  State_3381_Name = {
    Text = "Ultra Boyut Sınıfı Başlatma"
  },
  State_3382_Desc = {
    Text = "Bir görev kazan. Görevi tamamlayarak ödüller al. [Event Placeholder]"
  },
  State_3383_Name = {
    Text = "Ultra Boyut Sınıfı Başlatma"
  },
  State_3385_Desc = {
    Text = "Gelen aktif ve Dokunaç Hasarı %33 azalır."
  },
  State_3385_Name = {
    Text = "Ayna Kalkanı"
  },
  State_3385_WeaponDesc = {
    Text = "Gelen aktif ve Dokunaç Hasarı %33 azalır."
  },
  State_3386_Desc = {
    Text = "Kuşananın Hasarı, Karakter Kalkanı ve İyileştirmesi +[StateArg1]%. (Geçici)"
  },
  State_3386_Name = {
    Text = "Durum@Prototip Uzun Kılıç Kritik"
  },
  State_3387_Name = {
    Text = "Durum@Seviye2_3Savaş3Balon1"
  },
  State_3388_Desc = {
    Text = "Oynandığında, etkileri çözümlendikten sonra [StateArg1] <PowerIconKeywords:STR> kazan."
  },
  State_3388_Name = {
    Text = "<Rune_14:Güç>"
  },
  State_3389_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_3389_Name = {
    Text = "Uyanmamış"
  },
  State_3390_Desc = {
    Text = "Savaşın başında, tüm düşmanlara 1 tur boyunca Zayıflık ve Savunmasız yüklenir."
  },
  State_3392_Desc = {
    Text = "Alındığında [Arg1] GÜÇ kazan. Her \"Embriyo\" kaynaştırıldığında, bu tur [Arg2] GÜÇ kazan."
  },
  State_3393_Desc = {
    Text = "Tur başında, Embriyo Füzyonu +%30. Tüm Yutma etkilerin sınırsız Yutma hâline gelir."
  },
  State_3394_Name = {
    Text = "Çekme Destesi’ne 1 <DerivativeCardKeywords_4:\"Insight\"> ekle"
  },
  State_3395_Desc = {
    Text = "Takıma Özel: Kullanıcının \"Saldırı\" sının Temel Hasarı %25 artar ve \"Savunma\" nın temel kalkanı %25 artar. Kullanıcının \"Saldırı\" sı oynandığında, kullanıcının SLD’sinin <PowerIconKeywords:[StateArg1]%>’i kadar Geçici <WeaponEffect_Num:STR> kazan; kullanıcının \"Savunma\" sı oynandığında ise, kullanıcının ZDH’sinin <AlertIconKeywords:[StateArg2]%>’i kadar Geçici <WeaponEffect_Num:alert> kazan. Mevcut âlem \"Ultra\" ise, Ultra Tur’a girerken Geçici bir <PowerIconKeywords:power> ve Geçici bir <AlertIconKeywords:alert> al."
  },
  State_3395_WeaponDesc = {
    Text = "The wielder's \"Strike\" Base DMG is increased by 25%, and the \"Defense\" Base Shield is increased by 25%. When the wielder performs a \"Strike\", they obtain <WeaponEffect_Num:[Power:DescArg1]> Temporary <PowerIconKeywords:STR>. When the wielder performs a \"Defense\", they obtain <WeaponEffect_Num:[DescArg2]> Temporary <AlertIconKeywords:Alert>. If the Current Realm is \"Ultra\", they obtain 1 Temporary <PowerIconKeywords:STR> and 1 Temporary <AlertIconKeywords:Alert> upon entering the Ultra Round."
  },
  State_3397_Desc = {
    Text = "10. kartı oynamak, Dokunaç Hasarını [Arg1] artırır ve tüm Dokunaçların bir kez saldırmasını sağlar."
  },
  State_3400_Desc = {
    Text = "Elit ve Boss düşmanların maksimum Canı %20 azaltılır."
  },
  State_3401_Desc = {
    Text = "Oynandığında, etkisi [StateArg1] kez fazladan gerçekleşir ve [StateArg2] Kara Mühür alırsın. (Bu Yakarış ayrıca karta <DepleteIconKeywords:Tüketme> ve <GuyouKeywords:Doğuştan> ekler.)"
  },
  State_3401_Name = {
    Text = "<Rune_7:Yankı>"
  },
  State_3402_Desc = {
    Text = "\"Demir kazma\" Lusen’in ağır darbe Hasarı [Layer]% artırıldı."
  },
  State_3402_Name = {
    Text = "Ağır Saldırı Hasarı Artışı"
  },
  State_3402_WeaponDesc = {
    Text = "\"\"Demir Kazma\" Lucen\"in Ağır Darbe Hasarı +[Layer]%"
  },
  State_3403_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_3403_Name = {
    Text = "Uyanmamış"
  },
  State_3405_Name = {
    Text = "Tüm düşmanlar geçici olarak [Power:StateArg1] <PowerIconKeywords:Güç> kaybeder ve Karakter Kalkanı kazanımları ile <PowerIconKeywords:Güç>leri 1 tur boyunca %50 azalır."
  },
  State_3406_Name = {
    Text = "[StateArg1] <PowerIconKeywords:KUV> elde et"
  },
  State_3407_Name = {
    Text = "Çekme destesinden 1 kart seç, eline ekle ve Arithmetica Maliyetini 1 azalt."
  },
  State_3408_Name = {
    Text = "<Posse:[DescArg1]> Keyflare kazanır. Bu Savaşta, \"Boyun Kesme\" ve \"Bin Serap\"ın Temel Hasarı %10 artar."
  },
  State_3409_Name = {
    Text = "Bir Uyandırıcı seç ve ona <Energy:[DescArg1]> Aliemus kazandır."
  },
  State_3410_Name = {
    Text = "Bu kartın Kritik Oranı ve Krit. Hasarı %50 artar, Delici Hasar verir."
  },
  State_3411_Name = {
    Text = "1 tur boyunca <FragileIconKeywords:Kırılgan>, <WeaknessIconKeywords:Zayıflık>, <VulnerabilityIconKeywords:Savunmasız> durumlarına Bağışıklık kazan. <Block:[Block:StateArg1]> Karakter Kalkanı elde et."
  },
  State_3412_Desc = {
    Text = "Zayıflatmalara Bağışıklık. Her turun sonunda veya kritik darbe aldığında 1 yığın azalır."
  },
  State_3412_Name = {
    Text = "Balmumu Kaplama"
  },
  State_3412_WeaponDesc = {
    Text = "Her yığın, alınan Hasarı %10 azaltır. Kritik Vuruş aldığında 1 yığın kaybedilir."
  },
  State_3415_Desc = {
    Text = "Alındığında, 3 Yozlaşmış Orison arasından 1 tane seç. Yozlaşmış Orisonlar daha güçlüdür, ancak oynandıklarında bir kartı tüketirler."
  },
  State_3415_Name = {
    Text = "Relik Yeşim Baskı"
  },
  State_3415_WeaponDesc = {
    Text = "Alındığında, 3 Yozlaşmış Orison arasından 1 tane seç. Yozlaşmış Orisonlar daha güçlüdür, ancak oynandıklarında bir kartı tüketirler."
  },
  State_3416_Desc = {
    Text = "Takım Özgünlüğü: Savaş başladıktan sonra kullananın SAV'ının <WeaponEffect_Num:[StateArg1]%>'i kadar Karşı Saldırı kazanır. <DeathResistanceIconKeywords:Direnç> tetiklendikten sonra toplam en fazla 2 kat \"Beşik\" kazanır: Tüm müttefiklerin sağladığı Kalkan ve Can iyileşmesi <WeaponEffect_Num:[StateArg2]%> artar, tur sonunda 1 kat kaldırılır; mevcut Diyar \"Caro\" ise <DeathResistanceIconKeywords:Direnç> tetiklendikten sonra Embriyo Füzyonu <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_3416_WeaponDesc = {
    Text = "Savaş başladıktan sonra <WeaponEffect_Num:[Counterattack:DescArg1]> kat Karşı Saldırı kazanır. <DeathResistanceIconKeywords:Direnç> tetiklendikten sonra toplam en fazla 2 kat \"Beşik\" kazanır: Tüm müttefiklerin sağladığı Kalkan ve Can iyileşmesi <WeaponEffect_Num:[StateArg2]%> artar, tur sonunda 1 kat kaldırılır; mevcut Diyar \"Caro\" ise <DeathResistanceIconKeywords:Direnç> tetiklendikten sonra Embriyo Füzyonu <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_3418_Desc = {
    Text = "Tur sonundan sonra Geçici GÜÇ kaybet"
  },
  State_3418_Name = {
    Text = "Gecikmeli Özsüzme"
  },
  State_3419_Desc = {
    Text = "Alındığında Gelişmiş ya da Lanetli Yakarış içeren 3 kart göster, birini seçip Yakarışını atamak için seç."
  },
  State_3420_Desc = {
    Text = "Her eylem Kanama'ya neden olur. İyileştirme, Kanama yığınlarının sayısını yarıya indirebilir."
  },
  State_3420_Name = {
    Text = "Kan Sıçraması"
  },
  State_3420_WeaponDesc = {
    Text = "Her eylem Kanama'ya neden olur. İyileştirme, Kanama yığınlarının sayısını yarıya indirebilir."
  },
  State_3421_Desc = {
    Text = "Tur başında, eline [Arg1] Güç veren bir \"Dikenli Üç Dişli Zıpkın\" ekle. Yücelt’i serbest bıraktıktan sonra, elindeki tüm \"Dikenli Üç Dişli Zıpkın\" ların Gücü [Arg2] artar."
  },
  State_3422_Name = {
    Text = "Durum@Aksesuar Saf Vahiy"
  },
  State_3422_WeaponDesc = {
    Text = "Çeteyi serbest bıraktıktan sonra [DescArg1] HP iyileştir. Eğer kullananın Anahtar Parıltısı Yenilenme Seviyesi 20’den büyükse, ayrıca [DescArg1] HP iyileştir. Benzer etkiler birikmez."
  },
  State_3423_Desc = {
    Text = "Diyar Ustalığı 100, Hasarı ve Geçici Dokunaç Hasarını artırır."
  },
  State_3423_Name = {
    Text = "Krono Sarkaç \"Kabus\""
  },
  State_3424_Desc = {
    Text = "Tur başında, önceki turda 3’ten fazla kart oynadıysan 2 kart çek."
  },
  State_3425_Desc = {
    Text = "HP %50’nin ([StateArg1]) altına düştüğünde, niyet \"Çıkmazda Hayatta Kalma\"ya kayar: Kırılganlık, Zayıflık ve Zehir durumlarını kaldırır, ekibine 99 yığın Zayıflık ve Kırılganlık uygular."
  },
  State_3425_Name = {
    Text = "İntikam Anı"
  },
  State_3425_WeaponDesc = {
    Text = "HP %50’nin ([StateArg1]) altına düştüğünde, niyet \"Çıkmazda Hayatta Kalma\"ya kayar: Kırılganlık, Zayıflık ve Zehir durumlarını kaldırır, ekibine 99 yığın Zayıflık ve Kırılganlık uygular."
  },
  State_3429_Desc = {
    Text = "Her eylem Kan Akıtma ekler; iyileştirme Kan Akıtma etkisini kaldırır."
  },
  State_3429_Name = {
    Text = "Ağır Yaralanma"
  },
  State_3429_WeaponDesc = {
    Text = "Her eylem Kan Akıtma ekler; iyileştirme Kan Akıtma etkisini kaldırır."
  },
  State_3430_Desc = {
    Text = "Bir Yüceliş serbest bırakıldıktan sonra [Arg1] Sayaç kazan. Bu savaşta 6. kez tetikleniyorsa, Sayaç miktarını ikiye katla."
  },
  State_3431_Name = {
    Text = "Zehirlenmeye Bağışıklık"
  },
  State_3432_Desc = {
    Text = "Atıldığında Tüket"
  },
  State_3432_Name = {
    Text = "Kart Atma Maliyeti"
  },
  State_3432_WeaponDesc = {
    Text = "Çekildiğinde, kendine 1 tur boyunca Zayıflık uygula. Kullanıldığında, tüm düşmanlara 1 tur boyunca Zayıflık uygula. Satılamaz."
  },
  State_3434_Name = {
    Text = "Durum @ Genel Savunmasız Değiştirici"
  },
  State_3436_Desc = {
    Text = "[Layer] Uyandırıcı avlanmış durumda."
  },
  State_3436_Name = {Text = "Avlanan"},
  State_3437_Desc = {
    Text = "Durum@Canavar Balina Sıçrama Fantazma Gezegen Soy_Kaos Canavarı"
  },
  State_3437_Name = {
    Text = "Durum@Canavar Balina Sıçrama Fantazma Gezegen Soy_Kaos Canavarı"
  },
  State_3437_WeaponDesc = {
    Text = "Durum@Canavar Balina Sıçrama Fantazma Gezegen Soy_Kaos Canavarı"
  },
  State_3438_Desc = {
    Text = "[StateArg1] Geçici GÜÇ kazan."
  },
  State_3438_Name = {
    Text = "<CardKeyWord:Kılıç: Meka>"
  },
  State_3439_Desc = {
    Text = "Tur sonunda Tulu 5 Aliemus kazanır."
  },
  State_3439_Name = {
    Text = "Yıldızlar Yerinde"
  },
  State_3440_Name = {
    Text = "Yaldızlı rehber"
  },
  State_3441_Desc = {
    Text = "Tek sayılı turlarda, elinde kart yoksa 2 kart çek; çift sayılı turlarda, hiç kalmadıysa 2 Arithmetica kazan."
  },
  State_3441_Name = {
    Text = "Eski Yapboz"
  },
  State_3441_WeaponDesc = {
    Text = "Tek sayılı turlarda, elinde kart yoksa 2 kart çek; çift sayılı turlarda, hiç kalmadıysa 2 Arithmetica kazan."
  },
  State_3442_Desc = {
    Text = "Alındığında kalıcı olarak [Arg1] Güç kaybedersin. Her Hasar verdiğinde [Arg2] Can iyileşirsin, tur başına en fazla 6 kez."
  },
  State_3442_Name = {
    Text = "Taşemren öpücüğü"
  },
  State_3444_Desc = {
    Text = "Tur başında 1 kart çek."
  },
  State_3445_Desc = {
    Text = "Savunmayı [Layer]% artır."
  },
  State_3445_Name = {
    Text = "Genel Savunma Yüzdesini artır"
  },
  State_3445_WeaponDesc = {
    Text = "Savunmayı [Layer]% artır."
  },
  State_3446_Desc = {
    Text = "[Fuse]’in 5 yığını kazan. Bir kart oynadığında 1 azalır. 0’a ulaştığında kendini patlatır, Saldırı * 2,5 Hasar verir."
  },
  State_3446_Name = {Text = "Bomba"},
  State_3446_WeaponDesc = {
    Text = "[Fuse]’in 5 yığını kazan. Bir kart oynadığında 1 azalır. 0’a ulaştığında kendini patlatır, Saldırı * 2,5 Hasar verir."
  },
  State_3447_Desc = {
    Text = "[Fuse]’in 5 yığını kazan. Bir kart oynadığında 1 azalır. 0’a ulaştığında kendini patlatır, Saldırı * 2,5 Hasar verir."
  },
  State_3447_Name = {Text = "Bomba"},
  State_3447_WeaponDesc = {
    Text = "[Fuse]’in 5 yığını kazan. Bir kart oynadığında 1 azalır. 0’a ulaştığında kendini patlatır, Saldırı * 2,5 Hasar verir."
  },
  State_3448_Desc = {
    Text = "Her turun sonunda, tüm Dokunaçları etkinleştir."
  },
  State_3448_Name = {
    Text = "Dokunaç Otomatik Tetikleme"
  },
  State_3448_WeaponDesc = {
    Text = "Her turun sonunda, tüm Dokunaçları etkinleştir."
  },
  State_3449_Desc = {
    Text = "Durum@Prolog Aliemus 0_1_1 Aktif"
  },
  State_3449_Name = {
    Text = "Durum@Prolog Aliemus 0_1_1 Aktif"
  },
  State_3449_WeaponDesc = {
    Text = "Durum@Prolog Aliemus 0_1_1 Aktif"
  },
  State_3450_Desc = {
    Text = "Aktif veya Dokunaç Hasarı alındığında, Hasara Bağışık olur ve 1 yığın kaldırılır."
  },
  State_3450_Name = {
    Text = "<ParcloseIconKeywords:Bariyer>"
  },
  State_3450_WeaponDesc = {
    Text = "Alınan Hasar -%99. Hasar alındıktan sonra 1 yığın kaybedilir."
  },
  State_3451_Desc = {
    Text = "Tüm Uyandıranlar ölüm anında 10 Aliemus kazanır."
  },
  State_3451_Name = {
    Text = "Son Nefesteki Gümüş Pullar"
  },
  State_3451_WeaponDesc = {
    Text = "Tüm Uyandıranlar ölüm anında 10 Aliemus kazanır."
  },
  State_3452_Desc = {
    Text = "Her kart oynadığında [StateArg1] Hasar al ve 1 yığın kaldır. Tur sonunda hâlâ yığın kalmışsa, bir \"Deniz Yaratığı\" yumurtadan çıkar. Her yığın için, AZ %10 artar."
  },
  State_3452_Name = {
    Text = "Uçurum Aşınması"
  },
  State_3453_Name = {
    Text = "Durum@İntikam Bıçağı Güç Çarpanı"
  },
  State_3455_Desc = {
    Text = "Durum@Prolog Aliemus Başlangıç 0_2_3 Etki"
  },
  State_3455_Name = {
    Text = "Durum@Prolog Aliemus Başlangıç 0_2_3 Etki"
  },
  State_3455_WeaponDesc = {
    Text = "Durum@Prolog Aliemus Başlangıç 0_2_3 Etki"
  },
  State_3456_Desc = {
    Text = "[Defense] [StateArg1] Sayaç kazan."
  },
  State_3456_Name = {
    Text = "Relik Isırgan Yeleği"
  },
  State_3457_Name = {
    Text = "Hasar Açığına Bağışıklık"
  },
  State_3458_Desc = {
    Text = "[Strike] ve [Defense] oynayın. İlgili Uyanan 35 Aliemus kazanır, ancak Arithmetica Maliyeti 1 artar."
  },
  State_3459_Desc = {
    Text = "Taşkınlık HASARI bu savaş boyunca [Layer] artar."
  },
  State_3459_Name = {
    Text = "Taşkınlık Hasar Artışı"
  },
  State_3461_Desc = {
    Text = "Beşinci Saldırın her zaman Krit. Hasar verir."
  },
  State_3462_Name = {
    Text = "Durum@İntikam Büyük Kılıcı Güç Çarpanı 3"
  },
  State_3463_Name = {
    Text = "Durum@İntikam Büyük Kılıcı Güç Çarpanı 2"
  },
  State_3464_Desc = {
    Text = "Dokunaç Sınırı 1 artar. HP %50’nin altındaysa, Dokunaç Hasarı [Arg1] artar."
  },
  State_3465_Desc = {
    Text = "Bu kart savaşa taşınır ve aşama boyunca etkili olur."
  },
  State_3465_Name = {
    Text = "<CardKeyWord:Kalıcı>"
  },
  State_3465_WeaponDesc = {
    Text = "Bu kart savaşın dışına taşınabilir ve bölüm boyunca etkilidir."
  },
  State_3466_Desc = {
    Text = "Alındığında, Uyanış için bir Uyanan seç. Onun Uyandırma kartının Arithmetica Maliyeti kalıcı olarak 1 azalır."
  },
  State_34671_Desc = {
    Text = "Oynandıktan sonra ele geri döner."
  },
  State_34671_Name = {
    Text = "<CardKeyWord:Ele Dön>"
  },
  State_34685_Name = {
    Text = "Bomba Oyuncu 2"
  },
  State_34689_Desc = {
    Text = "Kaybedilen her 1 HP için, Maksimum HP'nin %100'üne kadar 1 yığın <PainWord:Tahammül> kazan. Tahammül bir sonraki savaşa taşınır."
  },
  State_34689_Name = {
    Text = "<CardKeyWord:Tahammül>"
  },
  State_3468_Desc = {
    Text = "Durum @ Kusurlu'nun Kini"
  },
  State_3468_Name = {
    Text = "Durum @ Kusurlu'nun Kini"
  },
  State_3468_WeaponDesc = {
    Text = "Durum @ Kusurlu'nun Kini"
  },
  State_34691_Desc = {
    Text = "Her 1 Can kaybında 1 kat <PainWord:Tahammül> kazanır. Üst sınır [DescArg1] kattır. Tahammül bir sonraki savaşa aktarılır."
  },
  State_34691_Name = {
    Text = "<CardKeyWord:Tahammül>"
  },
  State_34696_Desc = {
    Text = "Bu kart her zaman elinde kalır ve el sınırını +1 artırır."
  },
  State_34696_Name = {
    Text = "Kalıcı Olarak Sakla ve el limitini yok say"
  },
  State_3469_Desc = {
    Text = "Verilen tüm Aktif ve Dokunaç Hasarı -[DescArg1]%."
  },
  State_3469_Name = {
    Text = "<WeaknessColour:Zayıflık>"
  },
  State_3469_WeaponDesc = {
    Text = "Verilen tüm Hasarı [DescArg1]% azalt."
  },
  State_3470_Desc = {
    Text = "Kademeli Taşlaşma Tespiti Uygula"
  },
  State_3470_Name = {
    Text = "Kademeli Taşlaşma Tespiti Uygula"
  },
  State_3470_WeaponDesc = {
    Text = "Kademeli Taşlaşma Tespiti Uygula"
  },
  State_3471_Desc = {
    Text = "Her [StateArg1]. kartı oynadığında, etkisi iki kez gerçekleşir."
  },
  State_3471_Name = {
    Text = "Yıldız Şarabı Sayacı"
  },
  State_3471_WeaponDesc = {
    Text = "Her [StateArg1]. kartı oynadığında, etkisi iki kez gerçekleşir."
  },
  State_3473_Desc = {
    Text = "HP %50’nin altına düştüğünde, \"Fener Papazı\" \"İlahi’nin İnişi\" için dua eder ve tüm Takipçileri emdikten sonra çılgına döner."
  },
  State_3473_Name = {
    Text = "Fitilin Damgası"
  },
  State_3473_WeaponDesc = {
    Text = "HP %50’nin altına düştüğünde, \"Fener Papazı\" \"İlahi’nin İnişi\" için dua eder ve tüm Takipçileri emdikten sonra çılgına döner."
  },
  State_3475_Desc = {
    Text = "[Strike] ve [Defense] Arithmetica Maliyeti +1."
  },
  State_3475_Name = {
    Text = "Relik Lanetli Stel"
  },
  State_3475_WeaponDesc = {
    Text = "[Strike] ve [Defense] Arithmetica Maliyeti +1."
  },
  State_3476_Desc = {
    Text = "Ne zaman Can kaybetsen, Embriyo Füzyonu +%10. Can %50’nin altındaysa, bu etki ikiye katlanır."
  },
  State_3477_Desc = {
    Text = "Saldırıya uğradığında [Layer] Can yeniler; Hasar Maksimum canın %15'ini aşarsa bayılır ve bu durum kaldırılır"
  },
  State_3477_Name = {
    Text = "Obsidyen Uçurum"
  },
  State_3478_Name = {
    Text = "Durum@Standart Aksesuar Ahit"
  },
  State_3479_Desc = {
    Text = "Tüketilen her Kara Mühür için, tüm Uyananlar 1 Aliemus elde eder."
  },
  State_3479_Name = {
    Text = "Kalıntı Ters Çiçek"
  },
  State_3479_WeaponDesc = {
    Text = "Tüketilen her Kara Mühür için, tüm Uyananlar 1 Aliemus elde eder."
  },
  State_3480_Desc = {
    Text = "Tur sonuna kadar HP 0'a düşmez."
  },
  State_3480_Name = {
    Text = "Yontulmamış Elmas: Ölümsüz"
  },
  State_3480_WeaponDesc = {
    Text = "Tur sonuna kadar HP 0'a düşmez."
  },
  State_3481_Desc = {
    Text = "Aşama başında, Ölüm Direnci ve Yakarış oranlarını ikiye katla."
  },
  State_3481_Name = {
    Text = "Durum@İllüzyon Gümüş Anahtar: Çifte Şans"
  },
  State_3482_Desc = {
    Text = "Savunmasız etkisini %25 artır. Her 3 turda bir tüm düşmanlara 1 yığın Savunmasız ekle."
  },
  State_3483_Desc = {
    Text = "Her eylem Kan Akıtma ekler; iyileştirme Kan Akıtma etkisini kaldırır."
  },
  State_3483_Name = {
    Text = "Ağır Yaralanma"
  },
  State_3483_WeaponDesc = {
    Text = "Her eylem Kan Akıtma ekler; iyileştirme Kan Akıtma etkisini kaldırır."
  },
  State_3484_Desc = {
    Text = "Gerçek Hasar verdikten sonra Güç kazan."
  },
  State_3484_Name = {
    Text = "\"Kaotik Kişilik\""
  },
  State_3485_Desc = {
    Text = "Durum@Fener Töreni Aktif"
  },
  State_3485_Name = {
    Text = "Durum@Fener Töreni Aktif"
  },
  State_3485_WeaponDesc = {
    Text = "Durum@Fener Töreni Aktif"
  },
  State_3486_Name = {
    Text = "Mukadder Darbe"
  },
  State_3488_Desc = {
    Text = "Bir kart oynarken [StateArg1] Hasar al ve 1 yığın kaldır. Yığınlar 0’a ulaştığında, daha zayıf bir \"Deniz Yaratığı\"çıkar. Tur sonunda hâlâ Parazitlenmişsen, yığınlara göre HP’si belirlenen bir \"Deniz Yaratığı\"çıkar."
  },
  State_3488_Name = {
    Text = "Defalarca Parazitlenmiş"
  },
  State_3489_Name = {
    Text = "Tur sonunda, elde veya <DimensionalSpaceIconKeywords:Ultra Space> içindeyse, \"Yozlaşmış Alevler\" e Yükseltme uygula."
  },
  State_3489_WeaponDesc = {
    Text = "Tur sonunda Elde veya Ultra Uzay'da ise güçlenir."
  },
  State_3490_Desc = {
    Text = "Bir kart oynarken [StateArg1] Hasar al ve 1 yığın kaldır. Yığınlar 0’a ulaştığında, daha zayıf bir \"Deniz Yaratığı\"çıkar. Tur sonunda hâlâ Parazitlenmişsen, yığınlara göre HP’si belirlenen bir \"Deniz Yaratığı\"çıkar."
  },
  State_3490_Name = {
    Text = "Tekrar Parazitlenme"
  },
  State_3492_Desc = {
    Text = "Her çift numaralı turda ekibin Gücünü [Layer] azaltır."
  },
  State_3492_Name = {Text = "Boşalt"},
  State_3495_Desc = {
    Text = "Her eylem [Layer] Kanama uygular."
  },
  State_3495_Name = {
    Text = "Ağır Yaralanma"
  },
  State_3495_WeaponDesc = {
    Text = "Her eylem [Layer] Kanama ekler; iyileştirme Kanama Etkisi’ni kaldırabilir."
  },
  State_34964_Desc = {
    Text = "Tur başında, <PainWord:Endure>’dan Maksimum CP’nin %10’unu kazan."
  },
  State_34964_Name = {
    Text = "Asla Unutma"
  },
  State_3496_Name = {
    Text = "Tur sonunda, elde veya <DimensionalSpaceIconKeywords:Ultra Space> içindeyse, \"Ölümcül Alevler\" e Yükseltme uygula."
  },
  State_3496_WeaponDesc = {
    Text = "Tur sonunda Elde veya Ultra Uzay'da ise güçlenir."
  },
  State_3497_Desc = {
    Text = "Ekip, farklı mesleklerden Uyananlardan oluştuğunda, ekibin HP'si ile tüm Uyananların Saldırı ve Savunması %200 artar."
  },
  State_3497_Name = {
    Text = "Karma Bonus"
  },
  State_3497_WeaponDesc = {
    Text = "Ekip, farklı mesleklerden Uyananlardan oluştuğunda, ekibin HP'si ile tüm Uyananların Saldırı ve Savunması %200 artar."
  },
  State_3499_Desc = {
    Text = "Takıma Özel: Kuşanan tarafından üretilen Aliemus <WeaponEffect_Num:[StateArg1]%> artar. Kuşanan, Yüceltme serbest bırakıldıktan sonra <WeaponEffect_Num:[StateArg2]> Keyflare kazanır."
  },
  State_3499_WeaponDesc = {
    Text = "Kullanıcının ürettiği Aliemus <WeaponEffect_Num:[StateArg1]%> artar. Yüceltim serbest bırakıldıktan sonra, kullanıcı <WeaponEffect_Num:[StateArg2]> Keyflare elde eder."
  },
  State_3502_Desc = {
    Text = "Kuşananın Hasarı, Karakter Kalkanı ve İyileştirmesi +[StateArg1]%. (Geçici)"
  },
  State_3502_Name = {
    Text = "Durum@Proto Bıçak Aliemus"
  },
  State_3504_Desc = {
    Text = "Tur başında [StateArg1] kart çek."
  },
  State_3504_Name = {
    Text = "Relik Yön Pusulası"
  },
  State_3504_WeaponDesc = {
    Text = "Tur başında [StateArg1] kart çek."
  },
  State_3507_Name = {
    Text = "Aksesuar: Organik Form"
  },
  State_3507_WeaponDesc = {
    Text = "Kuşanan Yüceltme kullandıktan sonra, bu tur boyunca Kalkanı ve İyileştirme Güçlendirmesi ikiye katlanır."
  },
  State_3508_Name = {
    Text = "Aksesuar: Bakire'nin Kozası"
  },
  State_3508_WeaponDesc = {
    Text = "Savaşın başında, eğer kullanan Kaos Diyarındansa, Saldırı +%25."
  },
  State_3510_Desc = {
    Text = "Uyandıran’ın Karakter Kalkanı [Layer] artar."
  },
  State_3510_Name = {
    Text = "<AlertColour:Uyarı>"
  },
  State_3511_Desc = {
    Text = "Kuşananın Hasarı, Karakter Kalkanı ve İyileştirmesi +[StateArg1]%. (Geçici)"
  },
  State_3511_Name = {
    Text = "Durum@Prototip Şans Kılıcı"
  },
  State_35120_Desc = {
    Text = "Alınan her Aktif Hasar örneği için saldırgana [StateArg1] <plural value=\"[Poison:StateArg1]\" singular=\"yığın\" plural=\"yığın\"> Zehir uygula; [Layer] <plural value=\"[Layer]\" singular=\"tur\" plural=\"tur\"> sürer."
  },
  State_35120_Name = {
    Text = "Balçık Üzerinde Ölümsüz Çiçek"
  },
  State_3512_Name = {
    Text = "Kırılganlığa geçici bağışıklık"
  },
  State_3514_Desc = {
    Text = "Tur sonunda, yığın sayısı kadar <FixedDamage:Saf Hasar> al ve bu durumu kaldır."
  },
  State_3514_Name = {
    Text = "<BleedingIconKeywords:Kan Akıtma>"
  },
  State_3514_WeaponDesc = {
    Text = "Tur başında Hasar al."
  },
  State_35158_Name = {
    Text = "Krono Sarkaç \"Trans\""
  },
  State_3515_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_3515_Name = {
    Text = "Uyanmamış"
  },
  State_35161_Name = {
    Text = "Krono Sarkaç \"Hücum\""
  },
  State_3516_Name = {
    Text = "Durum@Lanetli Çöküntü"
  },
  State_3518_Desc = {
    Text = "Büyücü her kart oynadığında [StateArg2] Geçici GÜÇ kazanır."
  },
  State_3518_Name = {
    Text = "Açılış Perdesi"
  },
  State_3519_Desc = {
    Text = "Ultra Turların dışında bile, her turda bir kez Sıçrama Etkisini tetikleyebilirsiniz."
  },
  State_3519_Name = {
    Text = "Uzay Sapma Cihazı"
  },
  State_3519_WeaponDesc = {
    Text = "Ultra Turların dışında bile, her turda bir kez Sıçrama Etkisini tetikleyebilirsiniz."
  },
  State_3520_Desc = {
    Text = "Savaşın başında bir Uyanan seç ve ona 50 Aliemus bahşet."
  },
  State_35228_Name = {
    Text = "Krono Sarkaç \"Hücum\""
  },
  State_3522_Name = {
    Text = "Kalıntı Üç Dişli Mızrak Sayacı"
  },
  State_35238_Desc = {
    Text = "Takıma Özel: Kuşananın verdiği Kalkanlar ve Zehir <WeaponEffect_Num:[StateArg1]%> artar. Her Direnç tetiklendiğinde, tüm Uyananlar <WeaponEffect_Num:[StateArg2]%> Geçici Kritik Oranı ve Krit. Hasar kazanır."
  },
  State_35238_WeaponDesc = {
    Text = "Kuşananın Kalkan Üretimi ve Zehri <WeaponEffect_Num:[StateArg1]%> artar. Ölüm Direnci tetiklendiğinde, tüm Uyananlar <WeaponEffect_Num:[StateArg2]%> Geçici Kritik Oranı ve Krit. Hasar elde eder."
  },
  State_3523_Desc = {
    Text = "Oynandığında, tüm düşmanlara [StateArg1] tur boyunca <WeaknessIconKeywords:Zayıflık> uygula."
  },
  State_3523_Name = {
    Text = "<Rune_2_High:Gel. Zayıflık>"
  },
  State_3524_Desc = {
    Text = "Alınan Hasar [Layer] artar."
  },
  State_3524_Name = {
    Text = "Çözünme Yarası"
  },
  State_3524_WeaponDesc = {
    Text = "Alınan Hasar [Layer] artar."
  },
  State_3525_Desc = {
    Text = "Takımım her kart oynadığında, [Bind]’dan 2 yığın uygula."
  },
  State_3525_Name = {
    Text = "\"Doğu Bölgesi Özel\""
  },
  State_3525_WeaponDesc = {
    Text = "Takımım her kart oynadığında, [Bind]’dan 2 yığın uygula."
  },
  State_35264_Desc = {
    Text = "Bu tur, oynanan her kart için \"Büyü Ustası\" 1 yığın Fantazma kazanır."
  },
  State_35264_Name = {
    Text = "Gölge Kayması Kaydı"
  },
  State_35277_Name = {
    Text = "Casiah’ın Büyü Savunması"
  },
  State_3527_Desc = {
    Text = "Her turun sonunda, ilk Komut Kartı’na karşılık gelen Uyanan 15 Aliemus kazanır. \"Adanmış Yürek\"in olduğunda, diğer Uyananlara 5 Aliemus ver."
  },
  State_3528_Desc = {
    Text = "Kuşananın Hasarı, Karakter Kalkanı ve İyileştirmesi +[StateArg1]%. (Geçici)"
  },
  State_3528_Name = {
    Text = "Durum@Proto Lazer Topu Diyar"
  },
  State_3529_Desc = {
    Text = "Tüm Hasara Bağışıklık. Tur başında kaldırılır."
  },
  State_3529_Name = {
    Text = "Hasara Bağışıklık"
  },
  State_3530_Desc = {
    Text = "Durum@Şanslı Dedektif Hepsini Koy İşareti 8"
  },
  State_3530_Name = {
    Text = "Durum@Şanslı Dedektif Hepsini Koy İşareti 8"
  },
  State_3530_WeaponDesc = {
    Text = "Durum@Şanslı Dedektif Hepsini Koy İşareti 8"
  },
  State_3531_Desc = {
    Text = "Takıma Özel: Savaşın başında, kuşanan <WeaponEffect_Num:[StateArg1]> Aliemus kazanır. Başka bir Uyanan her Yüceliş (Exalt) kullandığında, kuşanan <WeaponEffect_Num:[StateArg2]> Aliemus kazanır. Mevcut Diyar \"Aequor\" ise, kuşanan Yüceliş (Exalt) kullandıktan sonra, Saldırısının <WeaponEffect_Num:[StateArg3]%>'ine eşit Dokunaç Hasarı kazanır."
  },
  State_3531_WeaponDesc = {
    Text = "Savaş başında, taşıyıcı <WeaponEffect_Num:[StateArg1]> Aliemus kazanır. Her başka bir Uyanan Yüceldiğinde, taşıyıcı <WeaponEffect_Num:[StateArg2]> Aliemus kazanır. Mevcut Diyar \"Aequor\" ise, taşıyıcı Yüceldikten sonra Dokunaç Hasarı <WeaponEffect_Num:+[DescArg1]> artar."
  },
  State_3532_Desc = {
    Text = "Tur başında [StateArg1] Arithmetica kazan."
  },
  State_3532_Name = {
    Text = "Kara Mum Kalıntısı 1"
  },
  State_3533_Desc = {
    Text = "Her zaman başlangıç elinde görünür."
  },
  State_3533_Name = {
    Text = "<GuyouKeywords:Doğuştan>"
  },
  State_3533_WeaponDesc = {
    Text = "Savaşın başında, bu Kart elde sabitlenir."
  },
  State_3535_Desc = {
    Text = "Kartların Arithmetica Maliyeti [Layer] artar. Bu zayıflatma tur sonunda veya bir kart oynandıktan sonra kaldırılır."
  },
  State_3535_Name = {
    Text = "<SlowColour:Geçici Durgunluk [Layer]>"
  },
  State_3535_WeaponDesc = {
    Text = "Kart Arithmetica Maliyeti [Layer] artar."
  },
  State_3536_Name = {
    Text = "Reis savaşlarında en fazla 3 kez kullanılabilir."
  },
  State_3537_Desc = {
    Text = "“Masum Dönüş Hediyesi” elde edildiğinde bir Yakarış kazan."
  },
  State_3537_Name = {
    Text = "Durum@Bölüm1_Rezonans4"
  },
  State_3537_WeaponDesc = {
    Text = "“Masum Dönüş Hediyesi” elde edildiğinde bir Yakarış kazan."
  },
  State_3538_Desc = {
    Text = "\"Masum Dönüş Hediyesi\" daha fazla Aliemus üretir"
  },
  State_3538_Name = {
    Text = "Durum@Birinci Bölüm_Rezonans1"
  },
  State_3538_WeaponDesc = {
    Text = "\"Masum Dönüş Hediyesi\" daha fazla Aliemus üretir"
  },
  State_3539_Desc = {
    Text = "\"Masum Dönüş Hediyesi\" Arithmetica Maliyeti -1"
  },
  State_3539_Name = {
    Text = "Durum@Bölüm 1_Rezonans 3"
  },
  State_3539_WeaponDesc = {
    Text = "\"Masum Dönüş Hediyesi\" Arithmetica Maliyeti -1"
  },
  State_3540_Desc = {
    Text = "\"Masum Dönüş Hediyesi\" bir hedef belirleyebilir"
  },
  State_3540_Name = {
    Text = "Durum@Bölüm 1_Rezonans 2"
  },
  State_3540_WeaponDesc = {
    Text = "\"Masum Dönüş Hediyesi\" bir hedef belirleyebilir"
  },
  State_3541_Desc = {
    Text = "Koom kurduğun tuzağa düştü."
  },
  State_3541_Name = {
    Text = "Tuzağa Düşmüş"
  },
  State_3542_Desc = {
    Text = "Savaşın başında, destedeki her Orison için [Arg1] Güç kazan ve her Hatıra için [Arg2] CP yenile."
  },
  State_3542_Name = {
    Text = "☆Lonca Madalyası☆"
  },
  State_3545_Name = {
    Text = "Göz Kamaştıran Renk Direnci"
  },
  State_3545_WeaponDesc = {
    Text = "Oynanan her kart için [StateArg1]% Ölüm Direnci kazan. Ölüm Direnci kazandığında [StateArg2] HP iyileştir."
  },
  State_3546_Desc = {
    Text = "Takımım her kart oynadığında, [Bind] üzerine [Layer] yığın uygula."
  },
  State_3546_Name = {
    Text = "\"Doğu Bölgesi Özel\""
  },
  State_3546_WeaponDesc = {
    Text = "Takımım her kart oynadığında, [Bind] üzerine [Layer] yığın uygula."
  },
  State_3547_Desc = {
    Text = "Takımım her kart oynadığında, [Bind] üzerine [Layer] yığın uygula."
  },
  State_3547_Name = {
    Text = "\"Doğu Bölgesi Özel\""
  },
  State_3547_WeaponDesc = {
    Text = "Takımım her kart oynadığında, [Bind] üzerine [Layer] yığın uygula."
  },
  State_3548_Desc = {
    Text = "Çekildiğinde, kendine 1 tur boyunca Zayıflık uygula. Kullanıldığında, tüm düşmanlara 1 tur boyunca Zayıflık uygula. Satılamaz."
  },
  State_3548_Name = {
    Text = "Lanet Durumu Zayıfladı"
  },
  State_3548_WeaponDesc = {
    Text = "Çekildiğinde, kendine 1 tur boyunca Zayıflık uygula. Kullanıldığında, tüm düşmanlara 1 tur boyunca Zayıflık uygula. Satılamaz."
  },
  State_3549_Name = {
    Text = "Durum Aksesuar Steppenwolf"
  },
  State_3549_WeaponDesc = {
    Text = "Kullananın Temel Hasarı +%10. Eğer takanın Hasar Güçlendirmesi %20’yi aşarsa, Temel Hasar ayrıca +%10."
  },
  State_35503_Name = {
    Text = "Krono Sarkaç \"Çoğalma\""
  },
  State_3551_Desc = {
    Text = "Tur başında, önceki tur elinde [StateArg1] karttan fazlası kaldıysa, [StateArg2] Arithmetica elde et."
  },
  State_3551_Name = {
    Text = "Diferansiyel Motor Kalıntısı"
  },
  State_3551_WeaponDesc = {
    Text = "Tur başında, önceki tur elinde [StateArg1] karttan fazlası kaldıysa, [StateArg2] Arithmetica elde et."
  },
  State_35539_Desc = {
    Text = "[Layer] tur boyunca iki kat Hasar al."
  },
  State_35539_Name = {
    Text = "Yol Yürüyenin Kalıntıları"
  },
  State_3553_Desc = {
    Text = "Kritik Oranı %25 artar. HP yeniledikten sonra, iyileştirenin Kritik Oranına eşit bir olasılıkla HP'yi bir kez daha yenileme şansı vardır."
  },
  State_3553_Name = {
    Text = "Durum@Hayalet_Gümüş_Anahtar: Kritik_İyileştirme"
  },
  State_3554_Desc = {
    Text = "Kalkan ve İyileştirme etkileri [Layer]% artırılır."
  },
  State_3554_Name = {
    Text = "Kalkan ve İyileştirme Güçlendirmesi"
  },
  State_3554_WeaponDesc = {
    Text = "Kalkan ve İyileştirme etkileri [Layer]% artırılır."
  },
  State_3555_Desc = {
    Text = "Alındığında %100 Ölüm Direnci kazan. Ölüm Direnci tetiklendikten sonra, bu savaşta tur başında [Arg1] HP yenile."
  },
  State_3555_Name = {
    Text = "Hayat üfleyici"
  },
  State_3556_Desc = {
    Text = "Bu yadigâr alındığında, bir kart seç ve ondan bir kopya desteye ekle."
  },
  State_3558_Desc = {
    Text = "Tur başında Kara Mühür sayısı 10'u aşarsa, 10 Kara Mühür tüket; o tur verilen Hasarı ikiye katla."
  },
  State_3559_Desc = {
    Text = "Engellenemez Hasar verirken 1 Kırılgan uygula."
  },
  State_3559_Name = {Text = "Pençe"},
  State_3559_WeaponDesc = {
    Text = "Gerçek Hasar verdiğinde, Çekme Desteğine [StateArg1] \"Yara\" karıştır."
  },
  State_3561_Name = {
    Text = "Durum@Hayalet Gümüş Anahtar: Biçme Karşı Saldırısı"
  },
  State_3562_Desc = {
    Text = "Ölümünden sonra, diğer müttefiklerin Gücü [Layer] artar."
  },
  State_3562_Name = {
    Text = "Ölüm Fısıltısı"
  },
  State_35635_Name = {
    Text = "Durum@Uyandırıcı Casiah Telekinezi Aktivasyon İzni"
  },
  State_35636_Name = {
    Text = "Durum@Uyandırıcı Casiah Telekinezi Ekle"
  },
  State_3563_Desc = {
    Text = "Engellenmemiş Hasar verdiğinde, Çekme Desteğine [StateArg1] adet \"Yara\" karıştır."
  },
  State_3563_Name = {Text = "Bıçak"},
  State_3563_WeaponDesc = {
    Text = "Gerçek Hasar verdiğinde, Çekme Desteğine [StateArg1] \"Yara\" karıştır."
  },
  State_35645_Desc = {
    Text = "Bu tur [Layer] daha az Kart çek."
  },
  State_35645_Name = {
    Text = "Çekme Azaltma"
  },
  State_35646_Desc = {
    Text = "Bu tur [Layer] daha az Kart çek."
  },
  State_35646_Name = {
    Text = "Çekme Azaltma"
  },
  State_3564_Desc = {
    Text = "Oynandığında, önce [StateArg1] Geçici <PowerIconKeywords:STR> kazan, ardından kartın etkilerini çözümlendir. (Hasar etkileri bu STR’den fayda sağlar.)"
  },
  State_3564_Name = {
    Text = "<Rune_15_High:Gelişmiş Patlama>"
  },
  State_3565_Desc = {
    Text = "Heykeltıraş kalkan uyguladığında, [StateArg1] Dokunaç HASARI artar."
  },
  State_3565_Name = {
    Text = "Kendinden Geçiş Diyarı"
  },
  State_3565_WeaponDesc = {
    Text = "Heykeltıraş kalkan uyguladığında, [StateArg1] Dokunaç HASARI artar."
  },
  State_3566_Desc = {
    Text = "Tur başında 3 Geçici GÜÇ kazan. [Exalt] bu Geçici GÜÇ’ü ikiye katlar, en fazla 2 yığına kadar."
  },
  State_3566_Name = {
    Text = "Yılanın Kabuğu Kalıntısı"
  },
  State_3567_Desc = {
    Text = "Kuşananın Hasarı, Karakter Kalkanı ve İyileştirmesi +[StateArg1]%. (Geçici)"
  },
  State_3567_Name = {
    Text = "Durum@Proto Lazer Topu Kritik Vuruş"
  },
  State_35684_Desc = {
    Text = "Ekibin Yücelişi serbest bıraktıktan sonra, o tur için Güç kaybederiz. Tur başına bir kez."
  },
  State_35684_Name = {
    Text = "Korku Çılgınlığı"
  },
  State_35685_Desc = {
    Text = "Köken’in Varışı sırasında, düşmanların Geçici GÜÇ’ünü azalt."
  },
  State_35685_Name = {
    Text = "Korku Çılgınlığı"
  },
  State_3568_Desc = {
    Text = "Ramona hasar verdiğinde, [StateArg1] Arithmetica elde eder."
  },
  State_3568_Name = {
    Text = "Birinci Doktrin"
  },
  State_3568_WeaponDesc = {
    Text = "Ramona hasar verdiğinde, [StateArg1] Arithmetica elde eder."
  },
  State_3570_Name = {
    Text = "Sonraki turun başında +2 kart çek"
  },
  State_3571_Name = {
    Text = "Zayıflığa geçici bağışıklık"
  },
  State_3572_Desc = {
    Text = "Çağrılan Canavarların Hasarı ikiye katlanır."
  },
  State_3572_Name = {Text = "Komutan"},
  State_3572_WeaponDesc = {
    Text = "Çağrılan Canavarların Hasarı ikiye katlanır."
  },
  State_3573_Desc = {
    Text = "Her tur alınan ilk Hasar, beşle çarpılır."
  },
  State_3573_Name = {Text = "Kibir"},
  State_3573_WeaponDesc = {
    Text = "Her tur alınan ilk Hasar ikiye katlanır."
  },
  State_3574_Desc = {
    Text = "Aynı Uyandırıcıya ait kartları art arda oynadığında, o Uyandırıcı 10 Aliemus kazanır."
  },
  State_35768_Name = {
    Text = "300 Keyflare Kazan"
  },
  State_35769_Name = {
    Text = "1 Arithmetica elde et."
  },
  State_35770_Name = {
    Text = "Kendindeki <IntoxicationIconKeywords:Zehir>, Mühürlü ve <SlowIconKeywords:Durgunluk> durumlarını dağıt"
  },
  State_35771_Name = {
    Text = "Maksimum Canın [DescArg1]%’üne (<Block:[DescArg2]>) eşit Karakter Kalkanı kazan."
  },
  State_35772_Name = {
    Text = "Reis Savaşlarında [StateArg1] kez daha Alınabilir."
  },
  State_35774_Desc = {
    Text = "Ölümden önce, Celeste’in yardımını çağırarak tüm Canı, Aliemus’u ve Keyflare’i yeniler."
  },
  State_35774_Name = {
    Text = "Ütopya Perdesi"
  },
  State_3577_Name = {
    Text = "Aliemus Otomatik İyileşme Artışı"
  },
  State_35809_Desc = {
    Text = "Verilen Hasar [StateArg1]% azalır, [Layer] tur sürer."
  },
  State_35809_Name = {
    Text = "Hezeyanın Varisi"
  },
  State_35809_WeaponDesc = {
    Text = "Durum@Aequor Leydi Çay & Pasta"
  },
  State_3580_Desc = {
    Text = "[Layer] Dokunaç Saldırıları bu tur Delici Hasar verir."
  },
  State_3580_Name = {
    Text = "Dokunaç Del"
  },
  State_35811_Desc = {
    Text = "Aktif veya Dokunaç Hasarı alındığında, hasarın yarısı kadar <SacrificeKeyWord:Fedakârlık> kazan, [Layer] <plural value=\"[Layer]\" singular=\"tur\" plural=\"tur\"> boyunca."
  },
  State_35811_Name = {
    Text = "Hezeyanın Varisi"
  },
  State_35819_Desc = {
    Text = "Tur sonu, Murphy 5 Aliemus kazanır. Posse serbest bırakıldığında, <SacrificeKeyWord:Kurban> ile Maksimum HP'nin %2'sini kaybet."
  },
  State_35819_Name = {
    Text = "Siyah Çay ve Pasta"
  },
  State_3581_Desc = {
    Text = "Durum@Kırmızı Leydi'nin Şehvetli Valsi Karşı Saldırı"
  },
  State_3581_Name = {
    Text = "Durum@Kırmızı Leydi'nin Şehvetli Valsi Karşı Saldırı"
  },
  State_3582_Desc = {
    Text = "Ultra Turların dışında bile, tur başına bir kez Sıçrama etkisini tetikleyebilirsin.\nTetiklendiğinde, Uyanan'a karşılık gelen bir kart çek."
  },
  State_3582_Name = {
    Text = "Mutasyona Uğramış Uzay Sapma Cihazı"
  },
  State_3582_WeaponDesc = {
    Text = "Ultra Turların dışında bile, tur başına bir kez Sıçrama etkisini tetikleyebilirsin.\nTetiklendiğinde, Uyanan'a karşılık gelen bir kart çek."
  },
  State_3584_Desc = {
    Text = "Kuşananın Hasarı, Karakter Kalkanı ve İyileştirmesi +[StateArg1]%. (Geçici)"
  },
  State_3584_Name = {
    Text = "Durum@Proto Bıçak Diyar"
  },
  State_35858_Desc = {
    Text = "Tur sonunda Murphy 5 Aliemus kazanır. Çete serbest bırakıldıktan sonra, Murphy’nin saldırısının %3’üne eşit Dokunaç Hasarı ver."
  },
  State_35858_Name = {
    Text = "Siyah Çay ve Pasta"
  },
  State_3585_Desc = {
    Text = "HP %50’nin ([StateArg1]) altına düştüğünde, \"Fener Papazı\" \"İlahi’nin İnişi\" için dua eder ve tüm müritleri emdikten sonra kudurur."
  },
  State_3585_Name = {
    Text = "Fitilin Damgası"
  },
  State_3585_WeaponDesc = {
    Text = "HP %50’nin ([StateArg1]) altına düştüğünde, \"Fener Papazı\" \"İlahi’nin İnişi\" için dua eder ve tüm müritleri emdikten sonra kudurur."
  },
  State_3588_Name = {
    Text = "Yaratım Arcana Kalıntısı Arithmetica"
  },
  State_3589_Desc = {
    Text = "Aktif veya Dokunaç Hasarı alındığında, Hasara bağışık olur ve 1 yığın kaybedilir."
  },
  State_3589_Name = {
    Text = "<ParcloseColour:Bariyer>"
  },
  State_3591_Desc = {
    Text = "Takım Özgünlüğü: Kullanıcının <RetaliateIconKeywords:Karşı Atak> değeri +<WeaponEffect_Num:[StateArg1]%>. \"Savunma\", kullanıcının SAV değerinin ×<WeaponEffect_Num:[StateArg2]%>'i kadar Geçici Karşı Atak sağlar. Patron Savaşlarında bu değer Geçici Karşı Atak'ın 3 katı olur. Direnç tetiklendikten sonra, tüm düşmanlara karşı [StateArg3]% <RetaliateIconKeywords:Karşı Atak> tetikle."
  },
  State_3591_Name = {
    Text = "Geceye Bürünmüş"
  },
  State_3591_WeaponDesc = {
    Text = "Kullanıcının <RetaliateIconKeywords:Karşı Atak> +<WeaponEffect_Num:[StateArg1]%>. Kullanıcının \"Savunma\" kartını oynadıktan sonra, <WeaponEffect_Num:[Counterattack:DescArg1]> yığın Geçici Karşı Atak kazan. Patron Savaşlarında bu, Geçici Karşı Atağın 3 katına dönüşür. Direnç tetiklendikten sonra, tüm düşmanlara karşı [StateArg3]% <RetaliateIconKeywords:Karşı Atak> tetikle."
  },
  State_3592_Desc = {
    Text = "Dokunaç Hasarını artırır."
  },
  State_3592_Name = {
    Text = "<TentacleInjurieIconKeywords:Dokunaç Hasarı>"
  },
  State_3592_WeaponDesc = {
    Text = "Dokunaçların verdiği Hasar miktarını artır."
  },
  State_3593_Desc = {
    Text = "Takıma Özel: Kuşananın uyguladığı <IntoxicationIconKeywords:Zehir> <WeaponEffect_Num:[StateArg1]%> artar. \"Darbe\", saldıranın Saldırısının <WeaponEffect_Num:[StateArg2]%>’üne eşit hasarı <IntoxicationIconKeywords:Zehir> olarak verir. Bu Etki tur başına en fazla 3 kez tetiklenebilir."
  },
  State_3593_WeaponDesc = {
    Text = "Taşıyıcının verdiği <IntoxicationIconKeywords:Zehir> etkisi <WeaponEffect_Num:[StateArg1]%> artar. \"Darbe\", hedef düşmana <WeaponEffect_Num:[Poison:DescArg1]> yığın <IntoxicationIconKeywords:Zehir> uygular. Bu etki tur başına en fazla 3 kez tetiklenebilir."
  },
  State_3596_Name = {
    Text = "Kalıntı Gümüş"
  },
  State_35970_Desc = {
    Text = "Öldükten sonra, takımına 1 tur boyunca <VulnerabilityIconKeywords:Savunmasız> uygular."
  },
  State_35970_Name = {
    Text = "Erken Ölüm"
  },
  State_35971_Desc = {
    Text = "Sahneye çıktığında, Maksimum Canının %50’sine eşit bir Karakter Kalkanı kazanır."
  },
  State_35971_Name = {
    Text = "Yumurta Kabuğu"
  },
  State_3597_Name = {
    Text = "Kalıntı Gümüş"
  },
  State_3598_Name = {
    Text = "Kalıntı Gümüş"
  },
  State_3599_Desc = {
    Text = "Gerçek Arithmetica Maliyeti 4 veya daha fazla olan bir kart oynadığında, elindeki diğer kartların Arithmetica Maliyeti 1 azalır."
  },
  State_36006_Desc = {
    Text = "Öldüğünde, yerinde bir \"Uykunun Çocuğu\" ortaya çıkar."
  },
  State_36006_Name = {Text = "Tecessüd"},
  State_3600_Name = {
    Text = "Kalıntı Gümüş"
  },
  State_36013_Desc = {
    Text = "Bu durum aynı zamanda <SacrificeKeyWord:Kurban> olarak sayılır, bir sonraki turun başında <SacrificeKeyWord:Kurban> durumundan [Layer] yığın kazanır."
  },
  State_36013_Name = {
    Text = "<BlueKeyWord:Gecikmeli Kurban>"
  },
  State_36014_Desc = {
    Text = "Tur sonunda [Layer] Hasar al ve <SacrificeKeyWord:Kurban> yığınlarını %50 azalt."
  },
  State_36014_Name = {
    Text = "<BlueKeyWord:Adak>"
  },
  State_3601_Name = {
    Text = "Durum@Hayalet Gümüş Anahtar: Dönüş Sayısı"
  },
  State_36022_Desc = {
    Text = "<SacrificeKeyWord:Sacrifice> dışındaki kaynaklardan Hasar alındığında, Hasarın %50’si kadar <SacrificeKeyWord:Sacrifice> kazan."
  },
  State_36022_Name = {Text = "Ziyaret"},
  State_36023_Desc = {
    Text = "Öldüğünde, eğer başka müttefikler varsa, bir “Suyun Çocuğu” ortaya çıkar."
  },
  State_36023_Name = {Text = "Tecessüd"},
  State_36024_Desc = {
    Text = "Öldüğünde, eğer başka müttefikler varsa bir \"Uykunun Çocuğu\" ortaya çıkar."
  },
  State_36024_Name = {Text = "Tecessüd"},
  State_3603_Name = {
    Text = "Reis Savaşlarında iki kez kullanılabilir ve ilk kullanımdan sonra ele geri döner."
  },
  State_3604_Desc = {
    Text = "Ekip, farklı mesleklerden Uyananlardan oluştuğunda, ekibin HP'si ile tüm Uyananların Saldırı ve Savunması %200 artar."
  },
  State_3604_Name = {
    Text = "Durum @ Karışık Eşleşme Bonusu"
  },
  State_3604_WeaponDesc = {
    Text = "Ekip, farklı mesleklerden Uyananlardan oluştuğunda, ekibin HP'si ile tüm Uyananların Saldırı ve Savunması %200 artar."
  },
  State_3607_Desc = {
    Text = "Uyanmışa kalıcı savaş güçlendirmeleri verir. Tekrarlanan Uyandırma kullanımları yığılmaz."
  },
  State_3607_Name = {
    Text = "<ExaltIconKeywords:Uyandır>"
  },
  State_3607_WeaponDesc = {
    Text = "Canlandırma oynandıktan sonra, Uyandıran bu savaşta özel bir yetenek güçlendirmesi kazanır. Ancak Canlandırma’yı birden fazla kez oynamak etkiyi yığmaz."
  },
  State_3608_Name = {
    Text = "Tüm müttefikler [StateArg1] Aliemus kazanır."
  },
  State_36092_Desc = {
    Text = "Öldüğünde, sahnede başka müttefikler varsa, yerine bir “Suyun Çocuğu” doğar."
  },
  State_36092_Name = {Text = "Tecessüd"},
  State_36093_Desc = {
    Text = "Kaybedilen her 1 Can puanı için 1 yığın azalt. Yığın sayısı 0’a ulaştığında, canavarın turunun sonunda 1 \"Suyun Çocuğu\"çağır ve [DescArg1] yığın \"Suyun Konağı\" geri kazan; en fazla 4 \"Suyun Çocuğu\" olabilir."
  },
  State_36093_Name = {
    Text = "Suyun Konağı"
  },
  State_36094_Desc = {
    Text = "1 yığın azaltmak için 1 HP kaybet; yığın sayısı 0 olduğunda, 1 \"Büyü Çocuğu\" çağır ve [DescArg1] yığın \"Mercan Konağı\" geri kazan, en fazla 4’e kadar."
  },
  State_36094_Name = {
    Text = "Ruh Duyusu Konağı"
  },
  State_3609_Name = {
    Text = "Reis Savaşı’nda iki kez kullanılabilir ve ilk kullanımdan sonra ele geri döner, turun geri kalanında Arithmetica Maliyeti 1 azalır"
  },
  State_36111_Desc = {
    Text = "Öldüğünde, eline 1 \"Mercan Hiperplazisi\" ekle."
  },
  State_36111_Name = {
    Text = "Mercan Hiperplazisi"
  },
  State_3611_Desc = {
    Text = "Durum@Prolog Canavar Pasif 12"
  },
  State_3611_Name = {
    Text = "Durum@Prolog Canavar Pasif 12"
  },
  State_3611_WeaponDesc = {
    Text = "Durum@Prolog Canavar Pasif 12"
  },
  State_36124_Desc = {
    Text = "Tur sonunda [Layer] Hasar al ve \"Kurban\" yığınlarını %50 azalt."
  },
  State_36124_Name = {
    Text = "<BlueKeyWord:Adak>"
  },
  State_3612_Desc = {
    Text = "Durum@Prolog Canavar Pasif 13"
  },
  State_3612_Name = {
    Text = "Durum@Prolog Canavar Pasif 13"
  },
  State_3612_WeaponDesc = {
    Text = "Durum@Prolog Canavar Pasif 13"
  },
  State_36136_Name = {
    Text = "Elde tutulurken, oynanan her diğer kart için [StateArg1] <FixedDamage:Saf Hasar> al."
  },
  State_3613_Desc = {
    Text = "Durum@Prolog Canavar Pasif 10"
  },
  State_3613_Name = {
    Text = "Durum@Prolog Canavar Pasif 10"
  },
  State_3613_WeaponDesc = {
    Text = "Durum@Prolog Canavar Pasif 10"
  },
  State_3614_Desc = {
    Text = "Durum@Prolog Canavar Pasif 11"
  },
  State_3614_Name = {
    Text = "Durum@Prolog Canavar Pasif 11"
  },
  State_3614_WeaponDesc = {
    Text = "Durum@Prolog Canavar Pasif 11"
  },
  State_36152_Desc = {
    Text = "Tur sonunda, yığın sayısı kadar Hasar al, ardından <SacrificeKeyWord:Kurban> yığınlarının %50’sini kaldır. Kurban, bir sonraki savaşa taşınır."
  },
  State_36152_Name = {
    Text = "<SacrificeKeyWord:Kurban>"
  },
  State_3615_Desc = {
    Text = "Durum @ Prolog Canavar Pasif 16"
  },
  State_3615_Name = {
    Text = "Durum @ Prolog Canavar Pasif 16"
  },
  State_3615_WeaponDesc = {
    Text = "Durum @ Prolog Canavar Pasif 16"
  },
  State_3616_Desc = {
    Text = "Durum@Prolog Canavar Pasif 14"
  },
  State_3616_Name = {
    Text = "Durum@Prolog Canavar Pasif 14"
  },
  State_3616_WeaponDesc = {
    Text = "Durum@Prolog Canavar Pasif 14"
  },
  State_36173_Name = {
    Text = "Reis Savaşlarında [DescArg1] kez kullanılabilir."
  },
  State_36174_Name = {
    Text = "([Layer] kez kaldı)"
  },
  State_3617_Desc = {
    Text = "Durum@Prolog Canavar Pasif 15"
  },
  State_3617_Name = {
    Text = "Durum@Prolog Canavar Pasif 15"
  },
  State_3617_WeaponDesc = {
    Text = "Durum@Prolog Canavar Pasif 15"
  },
  State_36182_Name = {
    Text = "Maksimum HP'nin [DescArg1]%’üne (<Block:[DescArg2]>) eşit bir Kalkan kazan ve aynı miktarda HP yenile; Kalkan, kaybedilen HP ile birlikte artar."
  },
  State_3618_Desc = {
    Text = "Gerçek Hasar aldığında bir kalkan kazan."
  },
  State_3618_Name = {Text = "Tampon"},
  State_3618_WeaponDesc = {
    Text = "Gerçek Hasar aldığında bir kalkan kazan."
  },
  State_36196_Desc = {
    Text = "Lotan’ın \"Darbe\" Hasarı %30 artar."
  },
  State_36196_Name = {
    Text = "Dizginsiz Kılıç Rüzgârı"
  },
  State_3619_Desc = {
    Text = "Durum @ Mavi Alev Dansçısı Vuruş Savunması"
  },
  State_3619_Name = {
    Text = "Durum @ Mavi Alev Dansçısı Vuruş Savunması"
  },
  State_3619_WeaponDesc = {
    Text = "Durum @ Mavi Alev Dansçısı Vuruş Savunması"
  },
  State_3620_Desc = {
    Text = "Ne zaman bir Semptom geliştirirsen, Maksimum Canı [Arg1] artır."
  },
  State_3621_Desc = {
    Text = "İlkel Mürit tarafından oynanan her kart için [StateArg1] kart çek ve tüm düşmanlara %5 Zehir uygula."
  },
  State_3621_Name = {
    Text = "Uçurum Takıntısı"
  },
  State_3621_WeaponDesc = {
    Text = "Köken Müridesi'nin oynadığı her kart için [StateArg1] kart çek."
  },
  State_3622_Desc = {
    Text = "\"Çılgın Kafatası Avcısı\" ve \"Ölüler\" in yetenek etkilerini güçlendir; turun başında [StateArg1] Geçici GÜÇ kazan ve her \"Av İşareti\" yığını için [StateArg1] arttır."
  },
  State_3622_Name = {
    Text = "Av İşareti"
  },
  State_36242_Desc = {
    Text = "Savaşın başında [StateArg1] Karakter Kalkanı kazan. Can kaybettikten sonra, \"Kutsal Cenin\" derin uykusundan uyanacak ve ağlamaya başlayacak."
  },
  State_36242_Name = {Text = "Derin Uyku"},
  State_3624_Desc = {
    Text = "Durum@Bilge Saldırı Analizi Güç Azaltma"
  },
  State_3624_Name = {
    Text = "Durum@Bilge Saldırı Analizi Güç Azaltma"
  },
  State_3625_Desc = {
    Text = "Karakter Kalkanın varken verdiğin Hasar [Arg1] artar. Karakter Kalkanın mevcut HP’ni aştığında, verdiğin Hasar ayrıca [Arg2] daha artar."
  },
  State_36263_Desc = {
    Text = "Artık Hasar almaz, \"Doğuş Sporu\"nu salmaya hazırlanır."
  },
  State_36263_Name = {
    Text = "Bağışık"
  },
  State_3628_Name = {
    Text = "Durum@Oynandıktan Sonra Savunma Kırma"
  },
  State_3629_Name = {
    Text = "2 kart çek."
  },
  State_3630_Name = {
    Text = "Tüm düşmanlara 2 yığın <VulnerabilityIconKeywords:Savunmasız> uygula"
  },
  State_36315_Desc = {
    Text = "Tur sonunda [Layer] GÜÇ kazan."
  },
  State_36315_Name = {
    Text = "Lütuflanmış"
  },
  State_3631_Name = {
    Text = "2 Arithmetica elde et."
  },
  State_3632_Name = {
    Text = "<Energy:[DescArg1]> Aliemus kazan"
  },
  State_36332_Desc = {
    Text = "Tur başında, 1 yığın İlahi Ana'nın Kudreti kazanmayı ya da İlahi Otorite tüketip bir kez Murphy’nin yardımını almayı seç."
  },
  State_36332_Name = {
    Text = "İlahi Ana'nın Kudreti"
  },
  State_36334_Desc = {
    Text = "Her turun sonunda 1 Dokunaç kazan."
  },
  State_36334_Name = {
    Text = "Lemuria'nın Çağrısı"
  },
  State_3633_Name = {
    Text = "Tüm düşmanlara 2 yığın <WeaknessIconKeywords:Zayıflık> uygula"
  },
  State_36346_Desc = {
    Text = "HP 0’a düştüğünde, 1’e ayarlanır, artık Hasar almaz ve \"Doğum Tohumu\"nu salmaya hazırlanır."
  },
  State_36346_Name = {
    Text = "Doğuş Sporu"
  },
  State_3634_Name = {
    Text = "Çekme Destene 2 <DerivativeCardKeywords_4:\"Insight\"> ekle."
  },
  State_3635_Name = {
    Text = "Diğer Uyananlar <Energy:[DescArg1]> Aliemus kazanır"
  },
  State_36360_Desc = {
    Text = "Tur başında, 1 yığın Dokunaç Toplanması kazanma ihtimali [DescArg1]%. 100%’ü aşarsa birden fazla yığın kazanılabilir."
  },
  State_36360_Name = {
    Text = "Dönüş Hattı"
  },
  State_36361_Desc = {
    Text = "Sahneye çıktığında diğer müttefikler [Layer] GÜÇ kazanır."
  },
  State_36361_Name = {
    Text = "İlahi Mutasyon"
  },
  State_3636_Desc = {
    Text = "Durum@Kalıntı Büyü Çanı Aktif"
  },
  State_3636_Name = {
    Text = "Durum@Kalıntı Büyü Çanı Aktif"
  },
  State_3637_Desc = {
    Text = "Canın %25’in altına düştüğünde ve ölmemişken, anında [Arg1] Can yenilersin. 3 kez tetiklendikten sonra Kalıcı olarak devre dışı kalır."
  },
  State_3637_Name = {
    Text = "☆Acil Yiyecek☆"
  },
  State_3638_Desc = {
    Text = "Aktif veya Dokunaç Hasarı alındığında, Hasara bağışık olur ve 1 yığın kaybedilir."
  },
  State_3638_Name = {
    Text = "<ParcloseColour:Bariyer>"
  },
  State_3638_WeaponDesc = {
    Text = "Alınan Hasar -%99. Her Hasar alındığında 1 yığın kaybedilir."
  },
  State_3639_Desc = {
    Text = "Ramona hasar verdiğinde, [StateArg1] Arithmetica elde eder."
  },
  State_3639_Name = {
    Text = "Üçüncü Felsefe"
  },
  State_3639_WeaponDesc = {
    Text = "Ramona hasar verdiğinde, [StateArg1] Arithmetica elde eder."
  },
  State_3641_Desc = {
    Text = "\"Tamamlanmamış Balmumu Heykel\" düğümünde bir kart seçerek Arithmetica Maliyetini 1 azalt."
  },
  State_3641_Name = {
    Text = "Durum@İkinci Bölüm_Rezonans_Temel Etki"
  },
  State_3641_WeaponDesc = {
    Text = "\"Tamamlanmamış Balmumu Heykel\" düğümünde kopyalanan Kartların seviyesini +1 artır."
  },
  State_3642_Desc = {
    Text = "Her HP kaybettiğinde, [Arg1] yığın Sayaç kazan. Tek bir turda 3. tetiklenişinde, tüm düşmanlara 1 kez Sayaç Hasarı ver."
  },
  State_3642_Name = {
    Text = "Merhum'un kronosu"
  },
  State_3646_Desc = {
    Text = "HP 1’in altına düşemez. Ölümcül Hasar alındığında, niyet Çıkmazda Hayatta Kalma’ya dönüşür. [Surviving Impasse]: Maksimum HP’nin %100’ünü yenile, Gücü ikiye katla ve sonraki becerileri Güçlendir."
  },
  State_3646_Name = {
    Text = "Çıkmazda Hayatta Kalma"
  },
  State_3647_Name = {
    Text = "Kalıntı Arcana Kayıt Sayısı"
  },
  State_3648_Desc = {
    Text = "Takıma Özel: Kuşananın İyileştirme Etkisi <WeaponEffect_Num:[StateArg2]%> artar. Tur başında, önceki tur kaybedilen HP’nin <WeaponEffect_Num:[StateArg1]%>’üne eşit Geçici <PowerIconKeywords:Güç> ve Karakter Kalkanı kazan."
  },
  State_3648_WeaponDesc = {
    Text = "Kullananın HP Yenilenmesi etkisi <WeaponEffect_Num:[StateArg2]%> artırılır. Tur başında, önceki turda kaybedilen HP’nin <WeaponEffect_Num:[StateArg1]%>’i kadar Geçici <PowerIconKeywords:SLD> ve Kalkan kazan."
  },
  State_3649_Desc = {
    Text = "Takımda her [Ultra] sınıfı Uyanan için, tüm takımın Maksimum HP'si (Tamamlanmadı), Savunması ve Saldırısı %50 artar."
  },
  State_3649_Name = {
    Text = "Ultra Bonus"
  },
  State_3649_WeaponDesc = {
    Text = "Takımda her [Ultra] sınıfı Uyanan için, tüm takımın Maksimum HP'si (Tamamlanmadı), Savunması ve Saldırısı %50 artar."
  },
  State_3651_Desc = {
    Text = "Oynamadan önce kartın Arithmetica’sını değiştir"
  },
  State_3651_Name = {
    Text = "Oynamadan önce kartın Arithmetica’sını değiştir"
  },
  State_3651_WeaponDesc = {
    Text = "Oynamadan önce kartın Arithmetica’sını değiştir"
  },
  State_3652_Desc = {
    Text = "Tur başında, eğer önceki turda [StateArg1] karttan fazlası oynandıysa, [StateArg2] kart çek."
  },
  State_3652_Name = {
    Text = "Yadigâr Gizemli Eldivenler"
  },
  State_3652_WeaponDesc = {
    Text = "Tur başında, eğer önceki turda [StateArg1] karttan fazlası oynandıysa, [StateArg2] kart çek."
  },
  State_3653_Name = {
    Text = "Yırtık Kalıntı Savaş Sancağı 2"
  },
  State_3654_Desc = {
    Text = "Tur başında [Layer]% Geçici Kritik Oranı kazan."
  },
  State_3654_Name = {
    Text = "Uzak Melodi"
  },
  State_3654_WeaponDesc = {
    Text = "bir sonraki turun başlangıcına kadar HP kaybetmeden, Kritik Oranı +[StateArg1]%."
  },
  State_3656_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_3656_Name = {
    Text = "Uyanmamış"
  },
  State_3658_Desc = {
    Text = "Elindeki son kartı oynadığında 2 kart çek. Bu etki tur başına en fazla 2 kez tetiklenebilir."
  },
  State_3659_Name = {
    Text = "Durum @ Saldırı Kartı Kritik Oranı ve Kritik Hasar Artışı"
  },
  State_36613_Name = {
    Text = "Durum@Aksesuar Mekanik Tanrı Karşı Saldırı"
  },
  State_3661_Desc = {
    Text = "Gerçek Hasar aldığında Derin Çözünme yığınlarını artır."
  },
  State_3661_Name = {
    Text = "Hasar almak Çözünme yığınlarını artırır."
  },
  State_3661_WeaponDesc = {
    Text = "Gerçek Hasar aldığında Derin Çözünme yığınlarını artır."
  },
  State_3662_Desc = {
    Text = "Bu savaşta Krit. Hasar [Layer]% artırılır."
  },
  State_3662_Name = {
    Text = "Kritik Hasar"
  },
  State_3662_WeaponDesc = {
    Text = "Bu savaşta Krit. Hasar [Layer]% artırılır."
  },
  State_36631_Desc = {
    Text = "Her Yüceliş saldığında 1 yığın \"Gebelik\" kazanırsın. Her Gebelik yığını için [StateArg1] Güç kazan, en fazla 5 yığına kadar."
  },
  State_36631_Name = {
    Text = "Sahte Gebelik Konağı"
  },
  State_36635_Desc = {
    Text = "Her Yüceliş saldığında 1 yığın \"Gebelik\" kazanırsın. Her Gebelik yığını için [StateArg1] Güç kazan, en fazla 5 yığına kadar."
  },
  State_36635_Name = {
    Text = "Lemurya'nın Son İnişi"
  },
  State_36636_Desc = {
    Text = "5 yığına ulaşıldığında \"Lemurya'nın Şanı!\"nı sal, muazzam HASAR ver ve soyu çağır."
  },
  State_36636_Name = {Text = "Doğuş"},
  State_36637_Desc = {
    Text = "5 yığına ulaşıldığında \"Lemuria İçin!\" serbest bırakılır, muazzam Hasar verir ve akrabaları çağırır."
  },
  State_36637_Name = {Text = "Doğuş"},
  State_3663_Desc = {
    Text = "Her turda ilk kez bir kart oynadıktan sonra, ilgili Uyandıran'dan bir \"Darbe\"yi eline al."
  },
  State_3664_Desc = {
    Text = "Oynandığında 5 Aliemus kazan."
  },
  State_3664_Name = {Text = "Anılar"},
  State_3664_WeaponDesc = {
    Text = "Oynandığında 5 Aliemus kazan."
  },
  State_3665_Desc = {
    Text = "Embriyo Füzyonu sınırına ulaştığında, eline bir \"Embriyo\" yerleştir."
  },
  State_3665_Name = {
    Text = "<EmbryoFusionIconKeywords:Embriyo Füzyonu>"
  },
  State_3666_Desc = {
    Text = "Krit. Oranı [Layer]% artar."
  },
  State_3666_Name = {
    Text = "Kritik Oranı"
  },
  State_3666_WeaponDesc = {
    Text = "Krit. Oranı [Layer]% artar."
  },
  State_36670_Name = {
    Text = "Durum @ Aksesuar Yeniden Evrim Sayısı"
  },
  State_36670_WeaponDesc = {
    Text = "Taşıyıcının turunun sonunda 3 Aliemus kazan. Taşıyıcının Aliemus Dolumu 10'dan büyükse fazladan 2 Aliemus kazan."
  },
  State_3667_Desc = {
    Text = "Takıma Özel: Kullanıcının <RetaliateIconKeywords:Counter> Üretimi +<WeaponEffect_Num:[StateArg4]%>. Bir kart oynandıktan sonra, tur başına en fazla 2 kez olmak üzere, kullanıcının ZDH’sinin <RetaliateIconKeywords:[StateArg1]%>’i kadar <WeaponEffect_Num:Counter> kazan. Oynanan kart Ultra Uzay’a girerse, kullanıcı ayrıca <WeaponEffect_Num:[StateArg2]> Aliemus kazanır. Yüceltme serbest bırakıldıktan sonra, tüm düşmanlar kullanıcının ZDH’sine eşit Geçici GÜÇ’ün <WeaponEffect_Num:[StateArg3]%>’ini kaybeder."
  },
  State_3667_WeaponDesc = {
    Text = "Increases <RetaliateIconKeywords:Counter> inflicted by the wielder by <WeaponEffect_Num:[StateArg4]%>. After the wielder plays a card, they gain <WeaponEffect_Num:[Counterattack:DescArg1]> <RetaliateIconKeywords:Counter>, up to 2 times per turn. If the card played enters Ultra Space, they also gain <WeaponEffect_Num:[StateArg2]> Aliemus. After Exalt, all enemies temporarily lose <WeaponEffect_Num:[Power:DescArg2]> Strength."
  },
  State_3668_Desc = {
    Text = "Durum@Değiştirilmiş Bahçe Koruyucu Rozeti"
  },
  State_3668_Name = {
    Text = "Durum@Değiştirilmiş Bahçe Koruyucu Rozeti"
  },
  State_3668_WeaponDesc = {
    Text = "Durum@Değiştirilmiş Bahçe Koruyucu Rozeti"
  },
  State_3669_Desc = {
    Text = "[Layer] tur boyunca Zayıflığa, Kırılganlığa ve Savunmasız durumlarına Bağışık."
  },
  State_3669_Name = {
    Text = "<BlessingColour:Lütuf>"
  },
  State_3669_WeaponDesc = {
    Text = "[Layer], tur sırasında uygulanan zayıflatmalara bağışıktır."
  },
  State_36710_Name = {
    Text = "Şişkin Ay Dansı"
  },
  State_3673_Desc = {
    Text = "Alındığında silmek için 2 kart seç, [StateArg1] Güç kazan."
  },
  State_3673_Name = {
    Text = "Kara Yıldız Közü Kalıntısı"
  },
  State_3674_Desc = {
    Text = "Tur sonunda tüm Uyananların Aliemus'u 10 azalır."
  },
  State_3674_Name = {Text = "Unutuş"},
  State_3674_WeaponDesc = {
    Text = "Tur sonunda tüm Uyananların Aliemus'u 10 azalır."
  },
  State_3675_Name = {
    Text = "Atılan Kart Sayısı + 1 × Kart Çek"
  },
  State_3676_Desc = {
    Text = "Rakibin turunda alınan hasarı [Layer]% azalt."
  },
  State_3676_Name = {Text = "Tetikte"},
  State_3676_WeaponDesc = {
    Text = "Takımının turu sırasında Canavarlar [Layer]% Hasar azaltımı kazanır."
  },
  State_3677_Desc = {
    Text = "Savunmayı [Layer]% artır."
  },
  State_3677_Name = {
    Text = "Geçici Savunma Yüzdesi Artışı"
  },
  State_3677_WeaponDesc = {
    Text = "Savunmayı [Layer]% artır."
  },
  State_36781_Desc = {
    Text = "Güç azaldığında, yalnızca Güç yığınlarının %50’si azaltılır."
  },
  State_36781_Name = {
    Text = "Arzuyu Cisimleştirme İradesi"
  },
  State_3678_Name = {
    Text = "Durum@Etkinlik Kalıntı 1"
  },
  State_36797_Desc = {
    Text = "Bu tur Dokunaç Hasarı [Layer] azalır."
  },
  State_36797_Name = {
    Text = "Dokunaç Hasar Azaltma"
  },
  State_3679_Name = {
    Text = "Durum@Etkinlik Kalıntı 2"
  },
  State_3680_Desc = {
    Text = "Her isabet için [Arg1] birikim Zehir uygula. Bu savaş sırasında 25 kez tetiklenirse, derhal tüm düşmanlara Zehir uygula."
  },
  State_3681_Desc = {
    Text = "Engellenmemiş hasar verirken, 2 rastgele \"Komut Kartı\" üzerine [DescArg1] yığın <BrokenCard:Sabotaj> bırakır."
  },
  State_3681_Name = {
    Text = "Jenkin Uyan!"
  },
  State_3681_WeaponDesc = {
    Text = "Bir sonraki turun başında, önceki turda kaybedilen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_3682_Desc = {
    Text = "Kaybedilen her %10 HP için, tüm Uyananlar 10 Aliemus kazanır ve ölümünde Dokunaç Hasarı artar."
  },
  State_3682_Name = {
    Text = "Gömülü Gümüş"
  },
  State_3682_WeaponDesc = {
    Text = "Kaybedilen her %10 HP için, tüm Uyananlar 10 Aliemus kazanır ve ölümünde Dokunaç Hasarı artar."
  },
  State_3683_Desc = {
    Text = "Takıma Özel: Kuşananın Komut Kartı’nın neden olduğu İyileştirme <WeaponEffect_Num:[StateArg2]%> artar. Kuşanan \"Exalt\"ı serbest bırakmadan önce, diğer Uyanış sahipleri <WeaponEffect_Num:[StateArg1]> Aliemus kazanır. Ekibin durumu <VulnerabilityIconKeywords:Savunmasız> ise Etki ikiye katlanır."
  },
  State_3683_WeaponDesc = {
    Text = "Kullananın Komut Kartı’ndan gelen İyileştirme <WeaponEffect_Num:[StateArg2]%> artar. Kullanan Exalt’ı serbest bırakmadan önce, diğer Uyananlar <WeaponEffect_Num:[StateArg1]> Aliemus kazanır. Ekibin durumu <VulnerabilityIconKeywords:Savunmasız> ise, etki iki katına çıkar."
  },
  State_3684_Desc = {
    Text = "Alınan her Hasar puanı bir yığını azaltır. 0 yığında, niyeti Sönmez Çiçek ile değiştir ve Savunma odaklı beceriler kullan."
  },
  State_3684_Name = {
    Text = "Sönmez Çiçek"
  },
  State_3684_WeaponDesc = {
    Text = "Alınan her 1 Hasar için 1 yığın kaybeder. Yığınlar 0'a ulaştığında Savunma moduna geçer."
  },
  State_3685_Desc = {
    Text = "Çekildiğinde 1 Arithmetica kaybet ve 1 kart çek."
  },
  State_3685_Name = {
    Text = "Şaşkınlık"
  },
  State_3685_WeaponDesc = {
    Text = "Çekildiğinde 1 Arithmetica kaybet ve 1 kart çek."
  },
  State_3686_Desc = {
    Text = "Çekildiğinde 1 Arithmetica kaybet ve 1 kart çek."
  },
  State_3686_Name = {
    Text = "Boyut Mühürlendi"
  },
  State_3686_WeaponDesc = {
    Text = "Çekildiğinde 1 Arithmetica kaybet ve 1 kart çek."
  },
  State_36884_Desc = {
    Text = "Bu Savaşta Son Yemin, Ölüm Direnci’ni isteyerek tetikleyerek artık Kalkan sağlayamaz."
  },
  State_36884_Name = {Text = "Son Yemin"},
  State_3688_Desc = {
    Text = "Öncekinden daha yüksek Arithmetica Maliyetine sahip 2 kart oynadığınızda, 2 Arithmetica elde edin."
  },
  State_3688_Name = {
    Text = "Arcana Arşivi Kalıntısı"
  },
  State_3688_WeaponDesc = {
    Text = "Öncekinden daha yüksek Arithmetica Maliyetine sahip 2 kart oynadığınızda, 2 Arithmetica elde edin."
  },
  State_3689_Desc = {
    Text = "Tur başında, Diyar Ustalığı’nı 30 artır. Zayıflatma etkisi altında değilken, Diyar Ustalığı 100 artar."
  },
  State_3692_Desc = {
    Text = "Bin biçimli esrarengiz kartlar. En çok muhtaç olduğun olanı seç!"
  },
  State_3692_Name = {
    Text = "<CardKeyWord:Bin Serap>"
  },
  State_3692_WeaponDesc = {
    Text = "Bin biçimli esrarengiz kartlar. En çok muhtaç olduğun olanı seç!"
  },
  State_3693_Desc = {
    Text = "Kritik Oranı %25 artar. HP yeniledikten sonra, iyileştirenin Kritik Oranına eşit bir olasılıkla HP'yi bir kez daha yenileme şansı vardır."
  },
  State_3693_Name = {
    Text = "Durum@Hayalet_Gümüş_Anahtar: Kritik_İyileştirme"
  },
  State_3696_Desc = {
    Text = "Bu turda her isabet için [Arg1] Uyanıklık kazan. Tur başında kalan her 3 Kalkan için 1 Güç kazan."
  },
  State_3696_Name = {
    Text = "Krono Sarkaç \"Okült\""
  },
  State_3697_Desc = {
    Text = "Tur başında 1 kart çek. Aynı Arithmetica Maliyeti'ne sahip 2 kartı art arda oynarsan, fazladan 1 kart daha çek."
  },
  State_3698_Desc = {
    Text = "Oynandığında, ondan [StateArg1] kopyayı Geçici <DimensionalSpaceIconKeywords:Ultra Uzay> yuvalarına ekle."
  },
  State_3698_Name = {
    Text = "<Rune_13:Bükülme>"
  },
  State_3699_Name = {
    Text = "Kalıntı Gümüş"
  },
  State_3700_Desc = {
    Text = "Saldırıyı [Layer]% artır."
  },
  State_3700_Name = {
    Text = "Geçici Saldırı Artışı Yüzdesi"
  },
  State_3700_WeaponDesc = {
    Text = "Saldırıyı [Layer]% artır."
  },
  State_3702_Desc = {
    Text = "Durum @ Genel Maksimum Sağlık Değişimi"
  },
  State_3702_Name = {
    Text = "Durum @ Genel Maksimum Sağlık Değişimi"
  },
  State_3702_WeaponDesc = {
    Text = "Durum @ Genel Maksimum Sağlık Değişimi"
  },
  State_3703_Name = {
    Text = "Durum@Bölüm 4 Rezonans@Sonraki turda 2 kart çek"
  },
  State_3704_Desc = {
    Text = "Diyar Ustalığı 30 artar. Alındığında, bir Kalıntı seç ve onu rastgele bir Kalıntı ile değiştir."
  },
  State_3705_Name = {
    Text = "Aequor Aydınlanma 3"
  },
  State_3707_Desc = {
    Text = "Savaşın başında, bu karttan [StateArg1] kopya Çekme Desteğine karıştırıldı. (Bu Yakarış kartlara <RetainIconKeywords:Sakla> ekler.)"
  },
  State_3707_Name = {
    Text = "<Rune_8:Ayna>"
  },
  State_3708_Desc = {
    Text = "Çift sayılı turların sonunda, bir sonraki turun başında kalan her kart için 1 Arithmetica kazan."
  },
  State_3708_Name = {
    Text = "Kadim Bilgelerin Kayıp Bölümü Kalıntısı 2"
  },
  State_3708_WeaponDesc = {
    Text = "Çift sayılı turların sonunda, bir sonraki turun başında kalan her kart için 1 Arithmetica kazan."
  },
  State_3709_Desc = {
    Text = "Tek sayılı turların sonunda, kalan her Arithmetica, bir sonraki turun başında fazladan 1 kart çekmeni sağlar."
  },
  State_3709_Name = {
    Text = "Kadim Bilgelerin Kayıp Bölümü Kalıntısı 1"
  },
  State_3709_WeaponDesc = {
    Text = "Tek sayılı turların sonunda, kalan her Arithmetica, bir sonraki turun başında fazladan 1 kart çekmeni sağlar."
  },
  State_3711_Desc = {
    Text = "Her eylem [Layer] Kan Akıtma uygular."
  },
  State_3711_Name = {
    Text = "Kan Sıçraması"
  },
  State_3711_WeaponDesc = {
    Text = "Her eylem [Layer] Kanama uygular; İyileştirme, Kanama yığınlarını yarıya indirir."
  },
  State_3712_Desc = {
    Text = "Kart oynandıktan sonra Tüketilir. Komut Kartları 1 tur boyunca 3x Hasar ve savunma sağlar."
  },
  State_3712_Name = {
    Text = "Çözündür"
  },
  State_3714_Desc = {
    Text = "Oynandığında, <Block:[StateArg1]> Karakter Kalkanı kazan."
  },
  State_3714_Name = {
    Text = "<Rune_6:Siper>"
  },
  State_3716_Desc = {
    Text = "Bu savaşta Krit. Oranı [Layer]% artar."
  },
  State_3716_Name = {
    Text = "Kritik Oranı"
  },
  State_3719_Desc = {
    Text = "Alınan her Aktif Hasar örneği için Dokunaç, Hasar Kaynağına bir kez karşı saldırı yapar; [Layer] <plural value=\"[Layer]\" singular=\"tur\" plural=\"tur\"> sürer."
  },
  State_3719_Name = {
    Text = "Sapkın Soy"
  },
  State_3720_Desc = {
    Text = "Savunmayı [Layer] artır."
  },
  State_3720_Name = {
    Text = "Genel Savunma Artışı"
  },
  State_3720_WeaponDesc = {
    Text = "Savunmayı [Layer] artır."
  },
  State_3721_Desc = {
    Text = "Oynandıktan sonra, bu kart Atılmış Kart Destesi'ne gitmek yerine desteden kaldırılır."
  },
  State_3721_Name = {Text = "Tüketme"},
  State_3721_WeaponDesc = {
    Text = "Oynandıktan sonra, kart Atılmış Kart Destesi’ne gitmez ve bu Savaşta tekrar kullanılamaz."
  },
  State_3722_Desc = {
    Text = "Hasar verirken Dokunaç Hasarını geçici olarak [StateArg1] artır, 5 kata kadar birikir. Tam yığına ulaşıldığında 1 Dokunaç üret."
  },
  State_3722_Name = {
    Text = "Hierofant Asası Kalıntısı"
  },
  State_3722_WeaponDesc = {
    Text = "Hasar verirken Dokunaç Hasarını geçici olarak [StateArg1] artır, 5 kata kadar birikir. Tam yığına ulaşıldığında 1 Dokunaç üret."
  },
  State_3723_Name = {
    Text = "Kara Ayna Kalıntısı"
  },
  State_3724_Desc = {
    Text = "Alındığında diğer tüm yadigârları kaybet. Rastgele 2 Altın Yadigâr kazan."
  },
  State_3726_Name = {
    Text = "Çarpık Leş Âlemi"
  },
  State_3728_Desc = {
    Text = "Savaşın başında bir [Strike] kartı kazan."
  },
  State_3728_Name = {
    Text = "Balina Sıçrayışı Aydınlanma 1"
  },
  State_3728_WeaponDesc = {
    Text = "Savaşın başında bir [Strike] kartı kazan."
  },
  State_3730_Desc = {
    Text = "Durum@Tatlılık İblisi Bal Rengi Trajedi"
  },
  State_3730_Name = {
    Text = "Durum@Tatlılık İblisi Bal Rengi Trajedi"
  },
  State_3730_WeaponDesc = {
    Text = "Durum@Tatlılık İblisi Bal Rengi Trajedi"
  },
  State_3731_Desc = {
    Text = "D-İzi Mağazası’ndan her alışveriş yaptığında, sonraki savaş boyunca her tur fazladan 1 kart çek ve 1 Arithmetica kazan."
  },
  State_3732_Desc = {
    Text = "Her 3 turda bir, 3 geçici Dokunaç elde et. Bu Dokunaçlar Dokunaç Sınırı'nı yok sayar."
  },
  State_3732_Name = {
    Text = "İsimsiz Uzuv Kalıntısı"
  },
  State_3732_WeaponDesc = {
    Text = "Her 3 turda bir, 3 geçici Dokunaç elde et. Bu Dokunaçlar Dokunaç Sınırı'nı yok sayar."
  },
  State_3733_Desc = {
    Text = "Tek sayılı turların sonunda, kalan Arithmetica bir sonraki tur için fazladan çekilişlere dönüştürülür; çift sayılı turların sonunda, kalan kartlar bir sonraki tur için fazladan Arithmetica’ya dönüştürülür."
  },
  State_3735_Name = {
    Text = "Takımındaki \"Zehir\" yığınlarının sayısı yarıya indirilir."
  },
  State_3738_Desc = {
    Text = "Tur sonunda, Embriyo Füzyonu +%15. Elde bir \"Embriyo\" varsa, [Arg1] HP yenile."
  },
  State_3738_Name = {
    Text = "Veba kaydı"
  },
  State_3739_Name = {
    Text = "Aksesuar Organik Form Etkisi"
  },
  State_3739_WeaponDesc = {
    Text = "Kuşanan Yüceltme kullandıktan sonra, bu tur boyunca Kalkanı ve İyileştirme Güçlendirmesi ikiye katlanır."
  },
  State_3740_Name = {
    Text = "Durum@Tatlı Şeytan Kritik Vuruş Sayacı"
  },
  State_3741_Desc = {
    Text = "3. turun başında, eline şu karttan 1 ekle: \"Geçmişin Yankıları—Tüm kartları at, mevcut HP ve Kalkanı bir önceki turun sonundaki hâline sıfırla. Elde Tut, Tüket.\""
  },
  State_3742_Desc = {
    Text = "Oynandığında, tüm düşmanlara [StateArg1] tur boyunca <VulnerabilityIconKeywords:Savunmasız> uygula."
  },
  State_3742_Name = {
    Text = "<Rune_1:Savunmasız>"
  },
  State_3743_Desc = {
    Text = "Oynadığın her 6. Kart iki kez Etki gösterir."
  },
  State_3743_Name = {
    Text = "Relik Yıldız Demlemesi+"
  },
  State_3744_Name = {
    Text = "Kalıntı Memphis Ritüel Yansıma Sayacı"
  },
  State_3747_Name = {
    Text = "Çekme Desteğinden 1 kart seç ve eline ekle."
  },
  State_3748_Name = {
    Text = "Kritik Oranı [DescArg1]% ve Krit. Hasarı [DescArg2]% artır"
  },
  State_3750_Name = {
    Text = "Geçici Kritik Oranı +[DescArg1]%. Bu Savaşta, \"Skull Reaver\" ve \"Bin Serap\"ın Temel Hasarı %5 artar."
  },
  State_3751_Name = {
    Text = "[StateArg1] <PowerIconKeywords:KUV> elde et"
  },
  State_3752_Name = {
    Text = "<Posse:[DescArg1]> Keyflare kazan. <Block:[Block:StateArg1]> Kalkan kazan."
  },
  State_3753_Desc = {
    Text = "Kart Atılmış Kart Destesine girmez, bunun yerine elinde kalır."
  },
  State_3753_Name = {
    Text = "<RetainIconKeywords:Sakla>"
  },
  State_3753_WeaponDesc = {
    Text = "Kart Atılmış Kart Destesine girmez, bunun yerine elinde kalır."
  },
  State_3754_Desc = {
    Text = "Aktif Hasar verirken, bu tur için Dokunaç Hasarı’nı [Arg1] artır; en fazla 3 kez birikebilir. Tam biriktiğinde 1 Dokunaç üret; tur sonunda bu Dokunaç kaldırılır."
  },
  State_3755_Desc = {
    Text = "Takıma Özel: Kuşananın Kalkan Üretimi +<WeaponEffect_Num:[StateArg1]%> ve HP Yenilenmesi +<WeaponEffect_Num:[StateArg1]%>. Tek sayılı turların sonunda, kuşananın Krit. Oranı +<WeaponEffect_Num:[StateArg2]%> olur ve <WeaponEffect_Num:[StateArg3]> Aliemus kazanır; çift sayılı turların sonunda, kuşananın Krit. Hasarı <WeaponEffect_Num:[StateArg2]%> artar ve <WeaponEffect_Num:[StateArg4]> Keyflare kazanır. Mevcut âlem \"Caro\" ise, Kızıl Ocağın azami birikimi <WeaponEffect_Num:[StateArg5]%> artar."
  },
  State_3755_WeaponDesc = {
    Text = "Kuşananın Kalkan Üretimi <WeaponEffect_Num:[StateArg1]%> artar ve HP Yenilenmesi <WeaponEffect_Num:[StateArg1]%> artar. Tek sayılı turların sonunda, kuşananın Krit. Oranı +<WeaponEffect_Num:[StateArg2]%> olur ve <WeaponEffect_Num:[StateArg3]> Aliemus elde eder; çift sayılı turların sonunda, kuşananın Krit. Hasarı <WeaponEffect_Num:[StateArg2]%> artar ve <WeaponEffect_Num:[StateArg4]> Keyflare elde eder. Mevcut âlem \"Caro\" ise, Kızıl Ocağın sınırı <WeaponEffect_Num:[StateArg5]%> artar."
  },
  State_3757_Desc = {
    Text = "Takımınız, oynanan her kart için [StateArg1] Yığın Kalkan kazanır. 1 tur sürer."
  },
  State_3757_Name = {
    Text = "Uçuşan Tüyler"
  },
  State_3757_WeaponDesc = {
    Text = "Takımınız, oynanan her kart için [StateArg1] Yığın Kalkan kazanır. 1 tur sürer."
  },
  State_3759_Name = {Text = "Meka 1"},
  State_3760_Desc = {
    Text = "En az [StateArg1] Kara Mühürün varsa, [Exalt] [StateArg1] Kara Mühür tüketir ve tüm düşmanları 1 tur boyunca Savunmasız ve Zayıflık yapar."
  },
  State_3760_Name = {
    Text = "Kehanet Ritüel Kuşu Kalıntısı"
  },
  State_3760_WeaponDesc = {
    Text = "En az [StateArg1] Kara Mühürün varsa, [Exalt] [StateArg1] Kara Mühür tüketir ve tüm düşmanları 1 tur boyunca Savunmasız ve Zayıflık yapar."
  },
  State_3761_Desc = {
    Text = "Takımınız her 1 Sersemleme çektiğinde [Layer] GÜÇ elde edin."
  },
  State_3761_Name = {
    Text = "Fener Töreni"
  },
  State_3761_WeaponDesc = {
    Text = "Takımınız her 1 Sersemleme çektiğinde [Layer] GÜÇ elde edin."
  },
  State_3763_Desc = {
    Text = "Bu turda Sinsice Gezen'in gerçekleştirdiği her isabet için, Krit. Hasar [StateArg3]% artar."
  },
  State_3763_Name = {
    Text = "Geçit Kıvrımı"
  },
  State_3763_WeaponDesc = {
    Text = "Bu turda Sinsice Gezen'in gerçekleştirdiği her isabet için, Krit. Hasar [StateArg3]% artar."
  },
  State_3764_Name = {Text = "Meka 2"},
  State_3766_Name = {
    Text = "Kızıl Güç Çarpanı Ekle"
  },
  State_3767_Desc = {
    Text = "Tur başında, rastgele bir düşmana [Arg1] Hasar ver. Bu savaşta \"Darbe\"yi 7 kez oynadıktan sonra, verilen Hasar [Arg2] olarak değişir."
  },
  State_3767_Name = {
    Text = "Eski Yapboz"
  },
  State_3768_Desc = {
    Text = "Alınan Aktif Hasar kesin olarak kritik vurur ve tur sonunda kaldırılır."
  },
  State_3768_Name = {Text = "Gedik"},
  State_3768_WeaponDesc = {
    Text = "Alınan Aktif Hasar kesin olarak kritik vurur ve tur sonunda kaldırılır."
  },
  State_3770_Name = {
    Text = "Kalıntı Arcana Sayısı"
  },
  State_3771_Desc = {
    Text = "Savaşın başında 3 Arithmetica kazan."
  },
  State_3772_Desc = {
    Text = "Her isabet için, İntikam Kılıcı mevcut Dokunaç Hasarına eşit Geçici GÜÇ kazanır."
  },
  State_3772_Name = {
    Text = "Önleyici İntikam"
  },
  State_3773_Desc = {
    Text = "Tur sonunda, yığın sayısı kadar <FixedDamage:Saf Hasar> al."
  },
  State_3773_Name = {
    Text = "<IntoxicationIconKeywords:Zehir>"
  },
  State_3773_WeaponDesc = {
    Text = "Tur başında Hasar al."
  },
  State_3774_Desc = {
    Text = "Exaslt serbest bırakıldığında [Arg1] Zehir uygulayabilen 1 \"Toksik Enfüzyon\" kazan. Tur sonunda, eldeki her 3 \"Toksik Enfüzyon\" kartı için, Zehri tetikleyen 1 \"Toksik Nöbet\" sentezle."
  },
  State_3776_Desc = {
    Text = "Her Aktif Hasar aldığında bir \"Uyanıklık\" yığını kazan. \"Uyanıklık\" 3 yığına ulaştığında geri çekil."
  },
  State_3776_Name = {
    Text = "Çekingen Bebek"
  },
  State_3776_WeaponDesc = {
    Text = "Her Aktif Hasar aldığında bir \"Uyanıklık\" yığını kazan. \"Uyanıklık\" 3 yığına ulaştığında geri çekil."
  },
  State_3777_Desc = {
    Text = "Oynandığında, bu Uyanan’ın Aliemus’unu <Energy:[StateArg1]> artır."
  },
  State_3777_Name = {
    Text = "<Rune_5_High:Gelişmiş Çılgınlık>"
  },
  State_3777_WeaponDesc = {
    Text = "Oynandığında, bu Uyanan’ın Aliemus’unu <Energy:[StateArg1]> artır."
  },
  State_3778_Desc = {
    Text = "Zayıflatma etkisi altındaki düşmanlara %25 daha fazla Hasar ver ve onları öldürdüğünde 20 Aliemus kazan."
  },
  State_3779_Desc = {
    Text = "Dokunaç Sınırı 2 azaltılır. Tur sonunda, tüm Dokunaçlar bir kez daha saldırır."
  },
  State_3779_Name = {
    Text = "Kutsal Izdırap Kalıntısı"
  },
  State_3779_WeaponDesc = {
    Text = "Dokunaç Sınırı'nı 2 azalt. Her turun sonunda, tüm Dokunaçlar fazladan bir saldırı yapar."
  },
  State_3781_Desc = {
    Text = "Tur başında, destedeki en üstteki 2 karta \"Durağanlık Laneti\" uygula."
  },
  State_3781_Name = {
    Text = "\"Uçurumun Lanetli Gözü\""
  },
  State_3781_WeaponDesc = {
    Text = "Tur başında, destedeki en üstteki 2 karta \"Durağanlık Laneti\" uygula."
  },
  State_3782_Desc = {
    Text = "Takıma Özel: Keşif başlangıcında, desteye kuşananın bir \"Savunma\" sını ekle; kuşananın \"Savunma\" sının Kalkanını <WeaponEffect_Num:[StateArg1]%> artır."
  },
  State_3782_WeaponDesc = {
    Text = "Keşif başlangıcında, desteye bir \"Savunma\" kartı ekle. Kuşananın \"Savunma\" kalkanı <WeaponEffect_Num:[StateArg1]%> artar."
  },
  State_3783_Desc = {
    Text = "Takıma Özel: Kuşananın temel Yüceliş Hasarını <WeaponEffect_Num:[StateArg1]%> artırır ve Kalkan ile HP Yenilenmesini <WeaponEffect_Num:[StateArg2]%> artırır."
  },
  State_3783_WeaponDesc = {
    Text = "Kuşananın Yüceltme Temel Hasarını <WeaponEffect_Num:[StateArg1]%> artırır. Kalkan Üretimini ve HP Yenilenmesini <WeaponEffect_Num:[StateArg2]%> artırır."
  },
  State_3784_Desc = {
    Text = "Takıma Özel: Kuşananın Komut Kartının Temel Hasarını <WeaponEffect_Num:[StateArg1]%> artırır ve Kalkan ile HP Yenilenmesini <WeaponEffect_Num:[StateArg2]%> artırır."
  },
  State_3784_WeaponDesc = {
    Text = "Kuşananın Komut Kartı Temel Hasarı <WeaponEffect_Num:[StateArg1]%> artırılır ve Kalkan/HP Yenilenmesi <WeaponEffect_Num:[StateArg2]%> artırılır."
  },
  State_3786_Desc = {
    Text = "Hedef sensin! Oynandıktan sonra, tüm Canavarlar [StateArg1] Geçici GÜÇ kazanır ve bu komutun Derin Dalış Mührü kaldırılır."
  },
  State_3786_Name = {
    Text = "<CardKeyWord:Derin Dalış Mührü>"
  },
  State_3786_WeaponDesc = {
    Text = "Kart oynandıktan sonra, Derin Dalışçı [StateArg1] Geçici GÜÇ kazanır."
  },
  State_3787_Desc = {
    Text = "Takıma Özel: Kuşanan Yücelişi tetikledikten sonra, tüm müttefikler <WeaponEffect_Num:[StateArg1]> Aliemus kazanır."
  },
  State_3787_WeaponDesc = {
    Text = "Kullanan Yüceliş kullandıktan sonra, tüm müttefikler <WeaponEffect_Num:[StateArg1]> Aliemus elde eder."
  },
  State_3788_Desc = {
    Text = "Takıma Özel: Keşfin başında, Kuşananın bir \"Darbe\" kartını desteye ekle; Kuşananın \"Darbe\" sinin Temel Hasarını <WeaponEffect_Num:[StateArg1]%> artır."
  },
  State_3788_WeaponDesc = {
    Text = "Keşfin başında, desteye bir \"Vuruş\" kartı ekle ve silah kullananın \"Vuruş\" Temel Hasarını <WeaponEffect_Num:[StateArg1]%> artır."
  },
  State_3790_Desc = {
    Text = "Durum@Belirsiz Madde Sayısı"
  },
  State_3790_Name = {
    Text = "Durum@Belirsiz Madde Sayısı"
  },
  State_3790_WeaponDesc = {
    Text = "Durum@Belirsiz Madde Sayısı"
  },
  State_3791_Desc = {
    Text = "Ne zaman Hasar verilirse, [Arg1] Karakter Kalkanı kazan, tur başına en fazla 5 kez birikebilir. Tam yığına ulaşıldığında, ele bir \"Kavrayış\" yerleştir."
  },
  State_3792_Desc = {
    Text = "Artık Taşlaştırma'dan etkilenmez."
  },
  State_3792_Name = {
    Text = "Taşlaşma Direnci"
  },
  State_3792_WeaponDesc = {
    Text = "Artık taşlaşmış değil, şimdi üç kat Hasar alır."
  },
  State_3793_Desc = {
    Text = "Bu aşamada Krit. Hasar [Layer]% artar."
  },
  State_3793_Name = {
    Text = "Kalıcı Kritik Hasar"
  },
  State_3793_WeaponDesc = {
    Text = "Bu aşamada Krit. Hasar [Layer]% artar."
  },
  State_3794_Desc = {
    Text = "Kuşananın Hasarı, Karakter Kalkanı ve İyileştirmesi +[StateArg1]%. (Geçici)"
  },
  State_3794_Name = {
    Text = "Durum@Prototip Uzun Kılıç Kritik Hasar"
  },
  State_3796_Desc = {
    Text = "HP %20 azalır, tüm Uyananlar 10 Aliemus elde eder, ölümünde Dokunaç Hasarı ekler."
  },
  State_3796_Name = {
    Text = "Çökeltilmiş Gümüş Tanecikler"
  },
  State_3796_WeaponDesc = {
    Text = "HP %20 azalır, tüm Uyananlar 10 Aliemus elde eder, ölümünde Dokunaç Hasarı ekler."
  },
  State_3797_Desc = {
    Text = "Alınan her Hasar için [StateArg1] Geçici GÜÇ kazan, tur başında kaldırılır."
  },
  State_3797_Name = {
    Text = "Fare Sürüsünün Gazabı!"
  },
  State_37980_Desc = {
    Text = "Bu Savaşta Diyar Ustalığı [Layer] artar."
  },
  State_37980_Name = {
    Text = "Diyar Ustalığı"
  },
  State_3798_Desc = {
    Text = "Gerçek Hasar verdikten sonra Can yenile."
  },
  State_3798_Name = {
    Text = "Vampir Kılıcı"
  },
  State_3798_WeaponDesc = {
    Text = "Gerçek Hasar verdikten sonra Can yenile."
  },
  State_3799_Desc = {
    Text = "Takımda her [Caro] sınıfı Uyanan için, tüm takımın Maksimum HP'si (Tamamlanmadı), Savunması ve Saldırısı %50 artar."
  },
  State_3799_Name = {
    Text = "Caro Bonusu"
  },
  State_3799_WeaponDesc = {
    Text = "Takımda her [Caro] sınıfı Uyanan için, tüm takımın Maksimum HP'si (Tamamlanmadı), Savunması ve Saldırısı %50 artar."
  },
  State_3800_Desc = {
    Text = "Tüm düşmanlara Hasar ver. <CardKeyWord:Strength> bu Hasarı birden çok kez güçlendirir."
  },
  State_3800_Name = {
    Text = "<CardKeyWord:Kılıcın Hükümranlığı>"
  },
  State_3801_Desc = {
    Text = "Engellenmeyen Hasar verdiğinde [StateArg1] yığın Kan Akıtma ekler."
  },
  State_3801_Name = {
    Text = "Kan Akıtma"
  },
  State_3802_Desc = {
    Text = "Elde iken, kullanılan her Komut Kartı, Arithmetica’sı 0 olan bir kopyaya dönüşür."
  },
  State_3802_Name = {
    Text = "<CardKeyWord:Saflığın Varisi>"
  },
  State_3802_WeaponDesc = {
    Text = "Elde olduğu sürece, kullanılan her kart 0 Arithmetica'lı bir kopya yaratır."
  },
  State_3803_Desc = {
    Text = "Savaşın başında, mevcut Arithmetica Maliyeti 1 olan tüm kartlar bu savaş için +[Arg1] Hasar, Kalkan ve İyileştirme kazanır."
  },
  State_3804_Desc = {
    Text = "Mutasyonlu Zıpkın Sayısı"
  },
  State_3804_Name = {
    Text = "Mutasyonlu Zıpkın Sayısı"
  },
  State_3804_WeaponDesc = {
    Text = "Mutasyonlu Zıpkın Sayısı"
  },
  State_3807_Name = {
    Text = "Aksesuarlardan İlaç Rüyası"
  },
  State_3807_WeaponDesc = {
    Text = "Savaşın başında, Kuşanan'ın kartlarından ek bir seti Çekme Desteğine Karıştır."
  },
  State_3808_Desc = {
    Text = "Durum@MevcutCanıDeğiştir"
  },
  State_3808_Name = {
    Text = "Durum@MevcutCanıDeğiştir"
  },
  State_3808_WeaponDesc = {
    Text = "Durum@MevcutCanıDeğiştir"
  },
  State_3810_Desc = {
    Text = "Ölümden sonra, diğer müttefiklerin Gücü artar."
  },
  State_3810_Name = {
    Text = "Ölüm Fısıltısı"
  },
  State_3811_Desc = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_4_1"
  },
  State_3811_Name = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_4_1"
  },
  State_3811_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_4_1"
  },
  State_3813_Name = {
    Text = "Zayıflığa Bağışıklık"
  },
  State_3815_Desc = {
    Text = "Tur sonunda, tüm Uyandıranlar [Layer] Aliemus kaybeder."
  },
  State_3815_Name = {
    Text = "<EnergyColour:Boşluk>"
  },
  State_3815_WeaponDesc = {
    Text = "Elde et: Aliemus [Layer]% azaltılır."
  },
  State_3817_Desc = {
    Text = "Tur başında, rakibe [DescArg1] Tüketme uygula."
  },
  State_3817_Name = {Text = "Dağılma"},
  State_3817_WeaponDesc = {
    Text = "Tur başında, ekibin [DescArg1*Layer*0.01] Yutma yükü elde eder."
  },
  State_3818_Name = {
    Text = "Durum@Bilge Tarafından Aydınlatılmış 1"
  },
  State_3819_Name = {
    Text = "Zincir Kırıcı Aydınlanma 1"
  },
  State_3819_WeaponDesc = {
    Text = "Kadim Taklitçi"
  },
  State_3821_Desc = {
    Text = "Tur başında, geçen tur kaybedilen Can'ın yarısına eşit bir Karakter Kalkanı kazan."
  },
  State_3821_Name = {
    Text = "Izdırap ve Haz"
  },
  State_3821_WeaponDesc = {
    Text = "Bir sonraki turun başında, önceki turda kaybedilen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_3824_Desc = {
    Text = "Takım Benzersiz: Taşkınlık Temel Hasarı +[StateArg1]%. Keşif başlangıcında, kullanan Bilgin Kişiliğine girer. Taşkınlık kullanmak, kullananı Bilgin ve Soytarı Kişilikleri arasında geçiş yaptırır.\nBilgin: Tur sonunda <WeaponEffect_Num:[StateArg2]> Aliemus kazan.\nSoytarı: Tur sonunda Kritik Oranı ve Kritik Hasar +<WeaponEffect_Num:[StateArg3]%>."
  },
  State_3824_WeaponDesc = {
    Text = "Kullananın Taşkınlık Temel Hasarı +[StateArg1]%. Keşif başlangıcında, kullanan Bilgin Kişiliğine girer. Taşkınlık kullandıktan sonra, kullanan Bilgin ve Soytarı Kişilikleri arasında geçiş yapar.\nBilgin: Tur sonunda, kullanan <WeaponEffect_Num:[StateArg2]> Aliemus kazanır.\nPalyaço: Tur sonunda, kullananın Kritik Oranı ve Kritik Hasarı <WeaponEffect_Num:+[StateArg3]%> artar."
  },
  State_3825_Desc = {
    Text = "Aktif Hasar alındığında, Hasar Kaynağına yığın sayısı kadar <FixedDamage:Saf Hasar> ver."
  },
  State_3825_Name = {
    Text = "<RetaliateIconKeywords:Sayaç>"
  },
  State_3825_WeaponDesc = {
    Text = "Her Aktif Hasar alındığında, saldırgana <FixedDamage:Saf Hasar> ver."
  },
  State_3826_Name = {
    Text = "Durum@Hayalet Gümüş Anahtar: Patlama Sayısı"
  },
  State_3827_Desc = {
    Text = "Takıma Özel: Kuşananın HP Yenilenmesi <WeaponEffect_Num:[StateArg1]%> artar. Yücelt serbest bırakıldıktan sonra, bir sonraki turun başında kaybedilen HP’nin <WeaponEffect_Num:[StateArg2]%>’i kadar HP yenilenir."
  },
  State_3827_WeaponDesc = {
    Text = "Kuşananın HP Yenilenme Gücünü <WeaponEffect_Num:[StateArg1]%> artır. Yücelişten sonra, bir sonraki turun başında kaybedilen HP'nin <WeaponEffect_Num:[DescArg1]%>'ini geri kazan."
  },
  State_3830_Name = {
    Text = "1 kez ek olarak etki eder"
  },
  State_3831_Name = {
    Text = "Kalıntı Ters Kök"
  },
  State_3834_Desc = {
    Text = "Labirent Örümceği’nin verdiği Zehir Hasarı iki katına çıkar."
  },
  State_3834_Name = {
    Text = "Kayıpların Yolu"
  },
  State_3835_Desc = {
    Text = "Bu tur Krit. Hasar [Layer]% artar."
  },
  State_3835_Name = {
    Text = "Geçici Kritik Hasar"
  },
  State_3835_WeaponDesc = {
    Text = "Bu tur Krit. Hasar [Layer]% artar."
  },
  State_3836_Desc = {Text = "Test 123"},
  State_3836_Name = {Text = "Test 123"},
  State_3837_Desc = {
    Text = "Takım Özgünlüğü: Kullananın ürettiği Aliemus +<WeaponEffect_Num:[StateArg1]%> ve kullananın uyguladığı <IntoxicationIconKeywords:Zehir> +<WeaponEffect_Num:[StateArg2]%>.\nKullanan Aktif Hasar verdikten sonra, tüm Uyandırıcılar kullanana ait Temel Krit. Hasarın <WeaponEffect_Num:[StateArg3]%>'i kadar Geçici Krit. Hasar kazanır.\nDiyar Aequor içeriyorsa, Dokunaç Sınırı +1 ve savaş başlangıcında 1 Dokunaç oluşturulur."
  },
  State_3837_WeaponDesc = {
    Text = "Kullananın ürettiği Aliemus +<WeaponEffect_Num:[StateArg1]%> ve kullananın uyguladığı <IntoxicationIconKeywords:Zehir> +<WeaponEffect_Num:[StateArg2]%>.\nKullanan Aktif Hasar verdikten sonra, tüm Uyandırıcıların Geçici Krit. Hasarı +<WeaponEffect_Num:[DescArg1]%>.\nDiyar Aequor içeriyorsa, Dokunaç Sınırı +1 ve savaş başlangıcında 1 Dokunaç oluşturulur."
  },
  State_3839_Desc = {
    Text = "Savaşın başında, destesindeki her bir Semptom kartı için [Arg1] Güç kazan. Tüm Semptom kartların Geçici kazanır."
  },
  State_3840_Desc = {
    Text = "CP her azaldığında [StateArg1] Alarm kazanır."
  },
  State_3840_Name = {
    Text = "Uyanıklık"
  },
  State_3842_Desc = {
    Text = "Verilen tüm Aktif ve Dokunaç Hasarı -[DescArg1]%."
  },
  State_3842_Name = {Text = "Zayıflık"},
  State_3842_WeaponDesc = {
    Text = "Verilen tüm Hasarı [DescArg1]% azalt."
  },
  State_3843_Desc = {
    Text = "Her eylem [Layer] Kanama uygular."
  },
  State_3843_Name = {
    Text = "Ağır Yaralanma"
  },
  State_3843_WeaponDesc = {
    Text = "Her eylem [Layer] Kanama ekler; iyileştirme Kanama Etkisi’ni kaldırabilir."
  },
  State_3844_Desc = {
    Text = "Tüm Balina Sıçrayışı Sıçrama Hasarı örnekleri +1."
  },
  State_3844_Name = {
    Text = "Dinmeyen Savaş Arzusu"
  },
  State_3844_WeaponDesc = {
    Text = "Tüm Balina Sıçrayışı Sıçrama Hasarı örnekleri +1."
  },
  State_3845_Desc = {
    Text = "Kart Aritmetika-"
  },
  State_3845_Name = {
    Text = "Kart Aritmetika-"
  },
  State_3845_WeaponDesc = {
    Text = "Kart Aritmetika-"
  },
  State_3846_Name = {
    Text = "Relik Yeşim Baskı"
  },
  State_3848_Desc = {
    Text = "Bu savaşta, rastgele bir Uyanışçının Taşkınlığı mühürlenir ve kullanılamaz."
  },
  State_3848_Name = {Text = "Mühürlü"},
  State_3850_Desc = {
    Text = "Her [StateArg1]. kartı oynadığında, Dokunaç Hasarını [StateArg2] artır ve tüm Dokunaçların bir kez saldırmasını sağla."
  },
  State_3850_Name = {
    Text = "Mutasyonlu Zıpkın"
  },
  State_3850_WeaponDesc = {
    Text = "Her [StateArg1]. kartı oynadığında, Dokunaç Hasarını [StateArg2] artır ve tüm Dokunaçların bir kez saldırmasını sağla."
  },
  State_3851_Name = {
    Text = "Tiyatro Kedi Aksesuar"
  },
  State_3851_WeaponDesc = {
    Text = "Verilen tüm Hasar + Kuşananın Maks. CP’sinin %10’u."
  },
  State_3852_Desc = {
    Text = "Isırma Hasarı örneklerinin sayısını [Layer] artır."
  },
  State_3852_Name = {
    Text = "Artan Isırışlar"
  },
  State_3852_WeaponDesc = {
    Text = "Isırma Hasarı örneklerinin sayısını [Layer] artır."
  },
  State_3853_Desc = {
    Text = "Tur başında, Çekme Desteğindeki bir Komut Kartının kopyasına rastgele dönüşür, Arithmetica Maliyeti sabit olarak 3 olur. Tur sonunda eski hâline döner."
  },
  State_3853_Name = {
    Text = "<CardKeyWord:Sayıklama>"
  },
  State_3853_WeaponDesc = {
    Text = "Kart Atılmış Kart Destesine girmez, bunun yerine elinde kalır."
  },
  State_3854_Desc = {
    Text = "2 kart çek, ancak bu Kafatası Avcısı'nın dikkatini çekecek."
  },
  State_3854_Name = {
    Text = "<CardKeyWord:Avlanan>"
  },
  State_3855_Name = {Text = "Güç"},
  State_3856_Desc = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_3_1"
  },
  State_3856_Name = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_3_1"
  },
  State_3856_WeaponDesc = {
    Text = "Durum@Prolog Deste Sıfırla 0_1_3_1"
  },
  State_3859_Desc = {
    Text = "Bereket Nefesi tarafından sağlanan Aliemus iki katına çıkar."
  },
  State_3859_Name = {
    Text = "Ad Matrem Vocatus"
  },
  State_3859_WeaponDesc = {
    Text = "Bereket Nefesi tarafından sağlanan Aliemus iki katına çıkar."
  },
  State_3860_Desc = {
    Text = "Kuşananın Hasarı, Karakter Kalkanı ve İyileştirmesi +[StateArg1]%. (Geçici)"
  },
  State_3860_Name = {
    Text = "Durum@Prototip Hançer Şans"
  },
  State_3862_Name = {
    Text = "Durum@Level2_15Battle4Bubble1"
  },
  State_3863_Desc = {
    Text = "Üç kez Yüceltme kullandıktan sonra, eldeki tüm kartların Arithmetica Maliyeti’ni 1 azalt."
  },
  State_3866_Desc = {
    Text = "Bu tur, el sınırı [Layer] artar."
  },
  State_3866_Name = {Text = "El Limiti+"},
  State_3867_Name = {
    Text = "Ultra Sınıf Karşı Saldırı"
  },
  State_3868_Desc = {
    Text = "Bu tur Karakter Kalkanı Üretimi [Layer] artar."
  },
  State_3868_Name = {
    Text = "Geçici Alarm"
  },
  State_3868_WeaponDesc = {
    Text = "Bu tur Karakter Kalkanı Üretimi [Layer] artar."
  },
  State_3872_Desc = {
    Text = "Hasar almak Geçici GÜÇ’ü iptal eder."
  },
  State_3872_Name = {Text = "Gedik"},
  State_38730_Desc = {
    Text = "Tur başında, 1 yığın Dokunaç Toplanması kazanma ihtimali [DescArg1]%. 100%’ü aşarsa birden fazla yığın kazanılabilir."
  },
  State_38730_Name = {
    Text = "Dönüş Hattı"
  },
  State_38735_Desc = {
    Text = "Verilen Aktif Hasar -%[StateArg1], saldırı sayısı iki katına çıkar ve [Layer] <plural value=\"[Layer]\" singular=\"tur\" plural=\"tur\"> sürer."
  },
  State_38735_Name = {
    Text = "Mırıltılar"
  },
  State_38738_Desc = {
    Text = "En fazla 10 yığın; bir sonraki Savaş’a devreder."
  },
  State_38738_Name = {Text = "Düş Yemi"},
  State_3873_Desc = {
    Text = "Bu Savaşta Diyar Ustalığı [Layer] artar."
  },
  State_3873_Name = {
    Text = "Diyar Ustalığı"
  },
  State_3874_Name = {
    Text = "Durum@Rüzgâr Çanı Kart Restorasyonu"
  },
  State_3876_Desc = {
    Text = "Her çift turda ekibin Gücünü azaltır."
  },
  State_3876_Name = {
    Text = "\"Ölen Düşün Oyuğu\""
  },
  State_3878_Desc = {
    Text = "Kaybedilen her 2 HP için, bir sonraki turun başında [Layer] Kalkan kazan."
  },
  State_3878_Name = {
    Text = "Izdırap ve Haz"
  },
  State_3878_WeaponDesc = {
    Text = "Bir sonraki turun başında, önceki turda kaybedilen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_3879_Desc = {
    Text = "Alındığında Maksimum HP [Arg1] artar. Alındığı anda HP %25’in altındaysa, Maksimum HP artışı [Arg2] olur."
  },
  State_3881_Desc = {
    Text = "Durum@Canavar George balmumu heykel uşağını yutuyor"
  },
  State_3881_Name = {
    Text = "Durum@Canavar George balmumu heykel uşağını yutuyor"
  },
  State_3881_WeaponDesc = {
    Text = "Durum@Canavar George balmumu heykel uşağını yutuyor"
  },
  State_3882_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_3882_Name = {
    Text = "Uyanmamış"
  },
  State_3883_Desc = {
    Text = "Bu aşamada Krit. Oranı + [Layer]%."
  },
  State_3883_Name = {
    Text = "Kalıcı Kritik Oranı"
  },
  State_3883_WeaponDesc = {
    Text = "Bu aşamada Krit. Oranı + [Layer]%."
  },
  State_3884_Desc = {
    Text = "Her tur 1 ilave Embriyo Füzyonu üret. Tüm Yutma etkilerin Sonsuz Yutma'ya dönüşür."
  },
  State_3884_Name = {
    Text = "Kıvranan Kordon Kalıntısı"
  },
  State_3884_WeaponDesc = {
    Text = "Her tur 1 ilave Embriyo Füzyonu üret. Tüm Yutma etkilerin Sonsuz Yutma'ya dönüşür."
  },
  State_3888_Desc = {
    Text = "Taşkınlık Serbest Bırakılamaz; tur sonunda 1 yük kaldır."
  },
  State_3888_Name = {
    Text = "<CardKeyWord:Mühürlü>"
  },
  State_3888_WeaponDesc = {
    Text = "Tüm Uyananların Yücelişi kullanılamaz."
  },
  State_3890_Name = {
    Text = "Çekme Sayısı = Atılan Kart Sayısı +[DescArg1] × kart"
  },
  State_3893_Desc = {
    Text = "Hasar verirken [Arg1] Karakter Kalkanı kazan. YP iyileştirirken [Arg2] Geçici GÜÇ kazan."
  },
  State_3893_Name = {Text = "Yuvamız"},
  State_3894_Desc = {
    Text = "Atma aşamasından önce, elindeki kartları taşa dönüştür."
  },
  State_3894_Name = {
    Text = "Taşlaştır"
  },
  State_3894_WeaponDesc = {
    Text = "Atma aşamasından önce, elindeki kartları taşa dönüştür."
  },
  State_3895_Desc = {
    Text = "Bu tur Krit. Oranı [Layer]% artar."
  },
  State_3895_Name = {
    Text = "Geçici Kritik Oranı"
  },
  State_3895_WeaponDesc = {
    Text = "Bu tur Krit. Oranı [Layer]% artar."
  },
  State_3898_Desc = {
    Text = "Sonraki turun başında [Layer] Karakter Kalkanı kazan."
  },
  State_3898_Name = {
    Text = "Izdırap ve Haz Kalkanı"
  },
  State_3900_Name = {
    Text = "Kart Mühürlü ve oynanamaz. Mührü kaldırmak için onu at."
  },
  State_3901_Name = {
    Text = "Kalıntı Rahip Asası Sayacı"
  },
  State_3902_Desc = {
    Text = "Bu tur verilen Aktif Hasar [Layer] azalır."
  },
  State_3902_Name = {Text = "STR▼"},
  State_3902_WeaponDesc = {
    Text = "Bu tur verilen Hasar [Layer] azalır."
  },
  State_3904_Desc = {
    Text = "Kaybedilen her 1 HP için 1 yığın kaldır; yığınlar 0’a ulaştığında [StateArg1] Karakter Kalkanı kazan ve [StateArg2] Kan Bariyeri yığını geri kazan."
  },
  State_3904_Name = {
    Text = "Uyanış - Kan Bariyeri"
  },
  State_3905_Desc = {
    Text = "Her Aktif Hasar alındığında, Hasar Kaynağına [Layer] <FixedDamage:Saf Hasar> verir."
  },
  State_3905_Name = {Text = "Sayaç"},
  State_3905_WeaponDesc = {
    Text = "Her Aktif Hasar alındığında, Saldırgana [Layer] <FixedDamage:Saf Hasar> verir."
  },
  State_3906_Name = {
    Text = "Kalıntı Gümüş"
  },
  State_3907_Name = {
    Text = "Kalıntı Gümüş"
  },
  State_3908_Desc = {
    Text = "Kavanozdaki Beyin iyileştirme uyguladığında [Arg2] kart çek."
  },
  State_3908_Name = {
    Text = "Gerçek ve Yanılsama İkilemi"
  },
  State_3908_WeaponDesc = {
    Text = "Kavanozdaki Beyin iyileştirme uyguladığında [Arg2] kart çek."
  },
  State_3909_Name = {
    Text = "Kalıntı Gümüş"
  },
  State_3910_Name = {
    Text = "Kalıntı Gümüş"
  },
  State_3911_Name = {
    Text = "Kalıntı Gümüş"
  },
  State_3912_Name = {
    Text = "Kalıntı Gümüş"
  },
  State_3913_Desc = {
    Text = "Takıma Özel: Kuşananın Karakter Kalkanı Üretimi +<WeaponEffect_Num:[StateArg1]%>. Tur başında, kalan Karakter Kalkanının <WeaponEffect_Num:[StateArg2]%>’i Sakla; en fazla Azami HP’nin <WeaponEffect_Num:[StateArg3]%>’ine kadar."
  },
  State_3913_WeaponDesc = {
    Text = "Kuşananın Karakter Kalkanı Üretimi +<WeaponEffect_Num:[StateArg1]%>. Tur başında, kalan Karakter Kalkanının <WeaponEffect_Num:[StateArg2]%>’i Sakla; en fazla Azami HP’nin <WeaponEffect_Num:[StateArg3]%>’ine kadar."
  },
  State_3914_Desc = {
    Text = "Her turda 2. Yüceliş serbest bırakıldıktan sonra, tüm Uyananlar 10 Aliemus kazanır. Her turda 3. Yüceliş serbest bırakıldıktan sonra, tüm Uyananların Aliemus bekleme süresi sıfırlanır ve fazladan 10 Aliemus verilir."
  },
  State_3915_Name = {
    Text = "Kalıntı Gümüş"
  },
  State_3916_Name = {
    Text = "Kalıntı Gümüş"
  },
  State_3917_Desc = {
    Text = "Sonraki tur Geçici GÜÇ Kazan"
  },
  State_3917_Name = {Text = "Hücum"},
  State_3918_Desc = {
    Text = "Her Turun Başlangıcında alınan ilk Hasarı ikiye katlayan bir Durum elde et."
  },
  State_3918_Name = {Text = "Kibir"},
  State_3918_WeaponDesc = {
    Text = "Her Turun Başlangıcında alınan ilk Hasarı ikiye katlayan bir Durum elde et."
  },
  State_3921_Desc = {
    Text = "Bu turda, Kart Atılmış Kart Destesine girmez, bunun yerine elinde kalır."
  },
  State_3921_Name = {
    Text = "<RetainIconKeywords:Sakla>"
  },
  State_3921_WeaponDesc = {
    Text = "Kart Atılmış Kart Destesine girmez, bunun yerine elinde kalır."
  },
  State_3923_Desc = {
    Text = "Kart Aritmetika-"
  },
  State_3923_Name = {
    Text = "Kalıcı Kart Aritmetika Düşüşü"
  },
  State_3923_WeaponDesc = {
    Text = "Kart Aritmetika-"
  },
  State_3925_Name = {
    Text = "Durum@Bölüm 4 Rezonans@Bizim Tur Başlangıcı Arithmetica 2"
  },
  State_3926_Desc = {
    Text = "\"Çarpık Ölülerin Ziyafeti\" Hasarı [Layer] artırır."
  },
  State_3926_Name = {Text = "Bükülme"},
  State_3926_WeaponDesc = {
    Text = "\"Mania\" Hasarını artır."
  },
  State_3927_Desc = {
    Text = "\"Boşluk\" çekildikten sonra, bu turda tüm Uyandıranların kazandığı Aliemus'u [Layer]% azalt."
  },
  State_3927_Name = {Text = "Boşluk"},
  State_3927_WeaponDesc = {
    Text = "\"Boşluk\" çekildikten sonra, bu turda tüm Uyandıranların kazandığı Aliemus'u [Layer]% azalt."
  },
  State_3928_Desc = {
    Text = "Tatlı Şeytan Hasar verdiğinde, [StateArg2] Sayaç kazan."
  },
  State_3928_Name = {Text = "Ver ve Al"},
  State_3929_Desc = {
    Text = "%50 daha az Güç ve Karakter Kalkanı kazan ve tur sonunda 1 yük kaldır."
  },
  State_3929_Name = {
    Text = "<CardKeyWord:Lanet>"
  },
  State_3929_WeaponDesc = {
    Text = "Bu tur kendine uygulanan olumlu güçlendirmelere karşı bağışıklık kazan."
  },
  State_3930_Name = {
    Text = "Durum@Bölüm 4 Rezonans@Bizim Tur Başlangıcı Arithmetica 1"
  },
  State_3931_Name = {
    Text = "Durum@Kızıl Kan ve Kum İlahisi"
  },
  State_3932_Desc = {
    Text = "Karta Elde Tut özelliği ver. Her bir Durağanlık Laneti yığını, kartın bedelini 1 artırır. Oynandıktan sonra Durağanlık Laneti’ni kaldır."
  },
  State_3932_Name = {
    Text = "Durağanlık Laneti ([Layer])"
  },
  State_3932_WeaponDesc = {
    Text = "Karta Elde Tut özelliği ver. Her bir Durağanlık Laneti yığını, kartın bedelini 1 artırır. Oynandıktan sonra Durağanlık Laneti’ni kaldır."
  },
  State_3933_Desc = {
    Text = "Savunmayı [Layer] artır."
  },
  State_3933_Name = {
    Text = "Geçici Savunma Artışı"
  },
  State_3933_WeaponDesc = {
    Text = "Savunmayı [Layer] artır."
  },
  State_3934_Desc = {
    Text = "Elde edilen tüm Kalkan %50 azaltılır."
  },
  State_3934_Name = {
    Text = "Kırılgan Yokoluş"
  },
  State_3934_WeaponDesc = {
    Text = "Elde edilen tüm Kalkan %50 azaltılır."
  },
  State_3935_Desc = {
    Text = "Ekibin her kart kullandığında 1 yığın \"Gözlem\" kazanırsın. 10 yığına ulaştığında sersemletilirsin."
  },
  State_3935_Name = {Text = "Gözlem"},
  State_3936_Desc = {
    Text = "Kuşananın Hasarı, Karakter Kalkanı ve İyileştirmesi +[StateArg1]%. (Geçici)"
  },
  State_3936_Name = {
    Text = "Durum@Proto Uzun Kılıç Diyar"
  },
  State_3937_Desc = {
    Text = "Dikenlerin Kraliçesi bir karşı saldırı gerçekleştirdiğinde, karşı saldırının Hasarının yarısına eşit bir Karakter Kalkanı kazanır."
  },
  State_3937_Name = {
    Text = "Ceset Duvarı"
  },
  State_3938_Name = {
    Text = "Balmumu Heykel Oluştur"
  },
  State_3941_Desc = {
    Text = "Bir embriyoyu yutarken Atılmış Kart Desteği’nden El Desteği’ne dön."
  },
  State_3941_Name = {
    Text = "Renksiz Girdap"
  },
  State_3941_WeaponDesc = {
    Text = "Bir embriyoyu yutarken Atılmış Kart Desteği’nden El Desteği’ne dön."
  },
  State_3942_Name = {
    Text = "Aksesuar Dönüş Hattı"
  },
  State_3942_WeaponDesc = {
    Text = "Savaş başında, Kuşanan Aequor sınıfındaysa, Saldırı gücünü %25 artır."
  },
  State_3943_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_3943_Name = {
    Text = "Uyanmamış"
  },
  State_3944_Desc = {
    Text = "Tur bittikten sonra, tüm Uyananlar 5 Aliemus kazanır. Kalan her bir Arithmetica için, tüm Uyananlar fazladan 3 Aliemus kazanır."
  },
  State_3945_Desc = {
    Text = "Tüm Kalıntı fiyatları %50 azaltılır."
  },
  State_39547_Desc = {
    Text = "Savaştan sonra fazladan 5 Kara Mühür kazan. Bu etki Mühür Hasadı tarafından güçlendirilir. Wanda bir kart oynadıktan sonra, 1 Yadözü (Dreamlead) yükü kazan. Bu etki tur başına en fazla 2 kez tetiklenebilir. Şu anda, [DescArg1] kez kaldı."
  },
  State_39547_Name = {
    Text = "Kürk ve Venüs"
  },
  State_40483_Name = {
    Text = "Parçalanmış Teber"
  },
  State_40484_Desc = {
    Text = "Wanda'nın yeteneği Sıçrama etkisini tetiklediğinde ve 5 yük varken, 5 yük tüketerek ek bir etki sağlar. Düş Yemi için üst sınır 10 yüktür ve bu yükler bir sonraki savaşa taşınır."
  },
  State_40484_Name = {
    Text = "<PurpleKeyWord:Düş Yemi>"
  },
  State_41337_Desc = {
    Text = "Tur sonunda [Layer] HP yenile."
  },
  State_41337_Name = {
    Text = "Gülün Zaferi: İyileştirme"
  },
  State_41340_Desc = {
    Text = "Takıma Özel: Kuşananın Kalkanını ve Sayaç değerini <WeaponEffect_Num:[StateArg1]%> artırır. Saldırıya uğradığında, tüm Uyananların 1 Aliemus kazanması için <WeaponEffect_Num:[StateArg2]%> ihtimal vardır."
  },
  State_41340_WeaponDesc = {
    Text = "Silah kullananın Kalkan Üretimi ve Sayaç değeri <WeaponEffect_Num:[StateArg1]%> artar. Ne zaman saldırıya uğrasa, tüm Uyananların 1 Aliemus kazanması için <WeaponEffect_Num:[StateArg2]%> ihtimal vardır."
  },
  State_41342_Name = {
    Text = "Etki Değişimleri"
  },
  State_41344_Name = {
    Text = "Etki Değişimleri"
  },
  State_41360_Desc = {
    Text = "5 yük <DreamGuide:Dreamlure> tüket, Wanda <Energy:[StateArg1]> Aliemus elde eder ve Kalıcı <RetaliateIconKeywords:Counter> değerinin [StateArg2]%’ine eşit Geçici <RetaliateIconKeywords:Counter> kazanır."
  },
  State_41360_Name = {
    Text = "Derin Uyku Karşı Saldırısı"
  },
  State_41361_Desc = {
    Text = "<DreamGuide:Düş Yemi>'nin 10 yığınını Tüket ve tüm düşmanların 1 tur boyunca \"Mırıltı\" durumuna girmesine neden ol: Verilen Aktif Hasar -%[StateArg3], ancak saldırı sayısı iki katına çıkar."
  },
  State_41361_Name = {
    Text = "Mırıltı Yankıları"
  },
  State_43818_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_43818_Name = {
    Text = "Uyanmamış"
  },
  State_44398_Desc = {
    Text = "Her turda ilk kez bir kart oynadıktan sonra, ilgili Uyandıran'dan bir \"Savunma\"yı eline al."
  },
  State_44484_Name = {
    Text = "Reis savaşlarında 3 kez kullanılabilir."
  },
  State_44485_Name = {
    Text = "(Kalan:[Layer])"
  },
  State_44491_Name = {
    Text = "Etkiyi Devre Dışı Bırak"
  },
  State_44562_Name = {
    Text = "Etkiyi Devre Dışı Bırak"
  },
  State_44575_Desc = {
    Text = "Bu turda kalan Karakter Kalkanı kaldırılmaz ve bir sonraki tura taşınır."
  },
  State_44575_Name = {
    Text = "Kalkan Koruma"
  },
  State_44653_Desc = {
    Text = "Tur başında tüm Uyandıranlar 20 Aliemus kazanır. Alındığında Maksimum HP %50 azalır."
  },
  State_44665_Desc = {
    Text = "Bu tur, \"Darbe\"nin Kritik Oranı [Layer]% artar."
  },
  State_44665_Name = {
    Text = "Vuruş Kritik Oranı"
  },
  State_44667_Desc = {
    Text = "“Darbe” [DescArg1] Arithmetica kazanır. Mevcut duruş “Taşkın” ise Arithmetica kazanılmaz, ancak 1 Dokunaç [DescArg2] kez saldırmak üzere komuta edilir."
  },
  State_44667_Name = {
    Text = "Devin Hükümranlığı"
  },
  State_44671_Desc = {
    Text = "Tur başında tüm Uyandıranlar 25 Aliemus kazanır. Alındığında Maksimum HP x3 olur."
  },
  State_44672_Name = {
    Text = "Kutsanmış· Sürü Bilinci"
  },
  State_44711_Desc = {
    Text = "Kalıntı Kapasitesi +5, [D-Mark] içinde +1 Yenileme. Savaştan sonra 125 Kara Mühür elde et. Alındığında, en fazla 6 Semptom kartını İmha Etmeyi seçebilirsin."
  },
  State_44713_Desc = {
    Text = "Savaştan sonra fazladan 100 Kara Mühür elde et, ancak 2 rastgele Semptom geliştir."
  },
  State_44730_Desc = {
    Text = "Tur başında, Kızıl Ocak’tan <Heal:[Heal:StateArg1]> iyileştirme biriktir."
  },
  State_44730_Name = {
    Text = "Kurtuluş Lütfu"
  },
  State_44731_Desc = {
    Text = "Acıyı acıyla gider. Kızıl Ocak'ın kalan tüm İyileştirme miktarını tüket, her 1 puan tüketildiğinde Hasar 3 puan artar; Patron Savaşı'nda ise her 1 puan tüketildiğinde Hasar 9 puan artar. Tüketilen her 1% Maksimum can Kızıl Ocak başına [DescArg1]% Final Hasar artar."
  },
  State_44731_Name = {Text = "Kurtuluş"},
  State_44732_Desc = {
    Text = "Kanla iyileş. Hasar verdikten sonra mevcut YP’nin %10’unu kaybet ve eşdeğer miktarda İyileştirme’yi Kızıl Ocak’ta biriktir."
  },
  State_44732_Name = {
    Text = "Adanmışlık"
  },
  State_44739_Desc = {
    Text = "Alındığında kalıcı olarak [Arg1] Güç kaybedersin. Her Hasar verdiğinde [Arg2] Can iyileşirsin, tur başına en fazla 6 kez."
  },
  State_44739_Name = {
    Text = "Günahkâr: Taşemren Öpücüğü"
  },
  State_44740_Name = {
    Text = "Kutsanmış· Taşemren Öpücüğü"
  },
  State_44741_Desc = {
    Text = "Alındığında kalıcı olarak [Arg1] Güç kaybedersin. Her Hasar verdiğinde [Arg2] Can iyileşirsin, tur başına en fazla 6 kez."
  },
  State_44741_Name = {
    Text = "Günahkâr: Taşemren Öpücüğü"
  },
  State_44742_Desc = {
    Text = "Alındığında kalıcı olarak [Arg1] Güç kaybedersin. Her Hasar verdiğinde [Arg2] Can iyileşirsin, tur başına en fazla 6 kez."
  },
  State_44742_Name = {
    Text = "Kutsanmış· Taşemren Öpücüğü"
  },
  State_44743_WeaponDesc = {
    Text = "Savaşın başında, 3 tur boyunca Savunmasız ol."
  },
  State_44744_WeaponDesc = {
    Text = "Savaşın başında, 3 tur boyunca Savunmasız ol."
  },
  State_44750_Desc = {
    Text = "Tur başında [StateArg1] Arithmetica kazan."
  },
  State_44750_Name = {
    Text = "Kara Mum Kalıntısı 1"
  },
  State_44751_Desc = {
    Text = "Tur başında [StateArg1] Arithmetica kazan."
  },
  State_44751_Name = {
    Text = "Kara Mum Kalıntısı 1"
  },
  State_44752_Desc = {
    Text = "\"\"Sofya\"\" her 1 CP kaybettiğinde 1 yığın kaybeder; yığın sayısı 0’a ulaştığında, niyeti \"Göze Göz Dişe Diş\" ile değiştir ve [StateArg2] Kalkan kazan. İlk tetiklenişte tüm yığınlar tamamen yenilenir."
  },
  State_44752_Name = {
    Text = "Gömülü Dürtü"
  },
  State_44762_Desc = {
    Text = "\"Savunma\" oynadığında, Çekme Destesinin içine 1 Yara karıştır."
  },
  State_44762_Name = {Text = "Yırt"},
  State_44763_Desc = {
    Text = "Tüm Uyandırıcıların Krit. Hasarı yarıya iner."
  },
  State_44763_Name = {
    Text = "<PurpleKeyWord:Körlük>"
  },
  State_44764_Desc = {
    Text = "\"Darbe\" oynadığında, Çekme Destene 1 Yara Kartı karıştır."
  },
  State_44764_Name = {Text = "Travma"},
  State_44807_Desc = {
    Text = "İlk kez yenilmek üzereyken HP yeniler ve niyeti \"Ayna Hükmü\"ne çevirerek kendini güçlendirir. İkinci kez yenilmek üzereyken HP yeniler ve niyeti \"Çılgın Isırık\"a çevirerek son derece yüksek tekli Hasar verir."
  },
  State_44807_Name = {
    Text = "Gömülü Katliam"
  },
  State_44819_Desc = {
    Text = "Eğer <ParcloseIconKeywords:Barrier> yoksa, bir Geçici <ParcloseIconKeywords:Barrier> yükü kazan. Aksi hâlde, %10 Kritik Oranı ve Krit. Hasar kazan."
  },
  State_44819_Name = {
    Text = "<CardKeyWord:Ulu Baba'nın Koruması>"
  },
  State_44828_Desc = {
    Text = "Takım Özgünlüğü: Tur sonunda, kullanan [StateArg1] Aliemus kazanır. Aktif ve Dokunaç Hasarı alındığında, bir sonraki turun başında hasarın <WeaponEffect_Num:[StateArg2]%>'i kadar Kalkan kazan. Mevcut Diyar Caro ise, bunun yerine hasarın <WeaponEffect_Num:[StateArg2]%>'i kadar Kızıl Ocak kazan."
  },
  State_44828_WeaponDesc = {
    Text = "Tur sonunda, kullanan <WeaponEffect_Num:[StateArg1]> Aliemus kazanır. Aktif veya Dokunaç Hasarı alındığında, bir sonraki turun başında hasarın <WeaponEffect_Num:[Float:StateArg2]%>'i kadar Kalkan kazan. Mevcut Diyar Caro ise, bunun yerine hasarın <WeaponEffect_Num:[Float:StateArg2]%>'i kadar Kızıl Ocak kazan."
  },
  State_44889_Name = {
    Text = "Durum@İnsan Yüzlü Köpek BOSS@Son Yansıma 1"
  },
  State_44890_Name = {
    Text = "Durum@Köpek Adam BOSS@Sonun Yansıması 2"
  },
  State_44891_Name = {
    Text = "Durum @ Tazı BOSS @ Sonun Yansıması 3"
  },
  State_44903_Desc = {
    Text = "Aktif veya Dokunaç Hasarı alındığında, hasarın [StateArg1]%'i Kızıl Ocak'ın iyileşme miktarına dönüştürülür, [Layer] <plural value=\"[Layer]\" singular=\"turn\" plural=\"turns\"> sürer."
  },
  State_44903_Name = {
    Text = "Koruyucu Olan"
  },
  State_44909_Name = {Text = "Tüketme"},
  State_45018_Desc = {
    Text = "Tur sonuna kadar \"Darbe\" kullanamazsın."
  },
  State_45018_Name = {Text = "Felç"},
  State_45025_Desc = {
    Text = "Belirli etkiler için temel Saldırı mantığına bakın."
  },
  State_45029_Desc = {
    Text = "Belirli etkiler için temel Saldırı mantığına bakın."
  },
  State_45032_Desc = {
    Text = "Sonraki turun sonunda [Layer] Hasar al."
  },
  State_45032_Name = {Text = "Kanatma"},
  State_45039_Desc = {
    Text = "Bir sonraki turun başına kadar, her Aktif veya Dokunaç Hasarı alındığında, bir sonraki turun başında Hasarın [Layer]%'i kadar Kalkan kazan."
  },
  State_45039_Name = {
    Text = "Mucizenin Şafağı"
  },
  State_45040_Desc = {
    Text = "Bir sonraki turun başına kadar, her Aktif veya Dokunaç Hasarı alındığında, Hasarın [Layer]%'ini Kızıl Ocak için iyileştirme olarak biriktir."
  },
  State_45040_Name = {
    Text = "Mucizenin Şafağı"
  },
  State_45049_Desc = {
    Text = "Bir sonraki aktif saldırının Hasarını engelle (en fazla 3 yığın). Her Ölüm Dövüşü yığını, Maksimum Bariyer yığınını 1 azaltır, ancak halihazırda elde edilmiş Bariyerleri kaldırmaz."
  },
  State_45049_Name = {Text = "Bariyer"},
  State_45050_Desc = {
    Text = "Bir sonraki aktif saldırının Hasarını engelle (en fazla 3 yığın). Her Ölüm Dövüşü yığını, Maksimum Bariyer yığınını 1 azaltır, ancak halihazırda elde edilmiş Bariyerleri kaldırmaz."
  },
  State_45050_Name = {
    Text = "<ReinforceColour:Bariyer>"
  },
  State_45064_Name = {
    Text = "Sessiz Şölen Karşı Saldırısı__\"Yalnızca Geliştirme Amaçlıdır\""
  },
  State_45069_Desc = {
    Text = "Belirli etkiler için temel Saldırı mantığına bakın."
  },
  State_45072_Name = {
    Text = "Kutsama Sayısı"
  },
  State_45073_Desc = {
    Text = "Kart Aritmetika-"
  },
  State_45076_Desc = {
    Text = "Uygulandığında, hedef üzerindeki Karakter Kalkanı ve Gecikmeli İyileştirme’yi dağıtır. Tur sonuna kadar alınan İyileştirme ve Karakter Kalkanı Etkileri %50 azaltılır."
  },
  State_45076_Name = {Text = "Çürüt"},
  State_45137_Desc = {
    Text = "Yüceltme kullandıktan sonra, tüm Uyandıranları bir tur boyunca mühürle ve bir tur boyunca Savunmasız ol."
  },
  State_45137_Name = {
    Text = "İlk Günah: Yol Yürüyenin Kalıntıları"
  },
  State_45139_Desc = {
    Text = "Taşkınlık kullandıktan sonra rastgele 1 zayıflatmayı dağıt."
  },
  State_45139_Name = {
    Text = "Kutsanmış· Yol Yürüyücüsünün Kalıntıları"
  },
  State_45148_Desc = {
    Text = "Tüm Uyandırıcıların Krit. Hasarı yarıya iner."
  },
  State_45148_Name = {
    Text = "<PurpleKeyWord:Körlük>"
  },
  State_45166_Desc = {
    Text = "Kader Çarkı tur sonuna kadar devre dışı."
  },
  State_45166_Name = {
    Text = "Birbirine Dolanmış"
  },
  State_45206_Desc = {
    Text = "İnançla gelen Kurtuluş. Kızıl Ocak’taki kalan tüm iyileştirmeyi tüketerek, tüketilen miktarın %150’sine eşit bir Kalkan kazan. Bu Kalkan, Kalkan artışlarından ya da zayıflatmalarından etkilenmez ve Kalkan sınırlarını yok sayar."
  },
  State_45206_Name = {Text = "Kurtuluş"},
  State_45248_Name = {Text = "Sayaç"},
  State_45328_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Taşkınlık\"tan sonra, kendine <TauntKeywords:Taunt> ve <Block:[Block:StateArg1]> Karakter Kalkanı ver."
  },
  State_45328_Name = {Text = "35mm Sihir"},
  State_45329_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Darbe\" hedef seçebilir. Her \"Darbe\"den önce, hedefin tüm dağıtılabilir güçlendirmelerini arkalarındaki Uyanan'a <PVPRepelKeywords:Geri İtme>."
  },
  State_45329_Name = {
    Text = "Derin Denizin Çağrısı"
  },
  State_45331_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>:Kuşanıldığında ve \"Darbe\"den sonra, Kuşanan'ın Elde bulunan Türetilmemiş \"Becerileri\" sırayla diğer \"Becerilerine\" dönüşür [ShowIfState:, <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]."
  },
  State_45331_Name = {
    Text = "Geçmişin Çiçekleri ve Şiirleri"
  },
  State_45332_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanan her Aktif Hasar aldığında, diğer müttefikler <Energy:[Energy:StateArg1]> Aliemus kazanır."
  },
  State_45332_Name = {
    Text = "Isarawu'nun Bakışı"
  },
  State_45333_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: El Limiti +[StateArg1], \"Taşkınlık\"tan sonra <Energy:[Energy:StateArg2]> Aliemus kazan."
  },
  State_45333_Name = {
    Text = "Veda Öpücüğü"
  },
  State_45334_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Yetenek\", bu turdaki bir sonraki \"Darbe\" yi rastgele hedefleri vuracak şekilde değiştirir ve ayrıca [StateArg1] rastgele hedefe daha saldırır."
  },
  State_45334_Name = {
    Text = "Aynadaki Adam"
  },
  State_45345_Desc = {
    Text = "Aşama 1 doğurganlık Becerisinin kaç kez kullanıldığını kaydetmek için kullanılır"
  },
  State_45345_Name = {
    Text = "Doğurganlık İşareti 1"
  },
  State_45346_Desc = {
    Text = "Aşama 2 Bereket Becerisinin kaç kez kullanıldığını kaydetmek için kullanılır"
  },
  State_45346_Name = {
    Text = "Doğurganlık İşareti 2"
  },
  State_45354_Desc = {
    Text = "Bu kart oynanamaz."
  },
  State_45354_Name = {Text = "Oynanamaz"},
  State_45356_Desc = {
    Text = "Tur sonu, Arithmetica Maliyeti -2 olan, en son oynanan \"Beceri\" kartına dönüşür. Oynandıktan sonra, \"Gri Sisin Ardındaki Gerçek\" desteğe karıştırılır."
  },
  State_45356_Name = {
    Text = "<CardKeyWord:Gri Sisin Ardındaki Gerçek>"
  },
  State_45364_Desc = {
    Text = "Sonraki turun başında, Uyanan [Layer] \"Darbe\" kazanır."
  },
  State_45364_Name = {
    Text = "Gecikmeli Vuruş Kazan"
  },
  State_45385_Desc = {
    Text = "Bu Savaşta verilen tüm Hasar [Layer] azaltılır ve giderilemez. Buna, tur sonunda kaldırılacak olan [DescArg1] yığın Geçici GÜÇ Azaltma da dahildir."
  },
  State_45385_Name = {Text = "STR▼"},
  State_45387_Desc = {
    Text = "Bu savaşta verilen tüm Hasar +[Layer] ve dağıtılamaz. Tur sonunda [DescArg1] yığın Geçici GÜÇ kaldırılır."
  },
  State_45387_Name = {Text = "Güç"},
  State_45397_Desc = {
    Text = "Tur başında, 1 yığın Bariyer’i Güç’e dönüştür."
  },
  State_45397_Name = {
    Text = "Güllerin Zaferi"
  },
  State_45403_Desc = {
    Text = "Sonraki turun başında, [Layer] yığın Şarj kazan."
  },
  State_45403_Name = {
    Text = "Gecikmeli Yüklen"
  },
  State_45407_Desc = {
    Text = "Kazanılan Aliemus ve Gecikmeli Aliemus %50 azalır ve tüm Gecikmeli Aliemus anında kaldırılır."
  },
  State_45407_Name = {Text = "Boşluk"},
  State_45656_Desc = {
    Text = "Ana Ağaç üçüncü kez canlanır ve Bereket Beceri 2’yi etkinleştirir."
  },
  State_45658_Desc = {
    Text = "Ana Ağaç ilk kez canlanır ve Bereket Becerisini etkinleştirir."
  },
  State_45661_Desc = {
    Text = "HP 0’a düştüğünde, 1’e ayarlanır, artık Hasar almaz ve \"Çoklu Füzyon\"u salmaya hazırlanır."
  },
  State_45661_Name = {
    Text = "Çoklu Füzyon"
  },
  State_45715_Desc = {
    Text = "Dokunaç Hasarının [StateArg1]%’ine eşit Geçici GÜÇ Kazan."
  },
  State_45715_Name = {Text = "Gasp Et"},
  State_45716_Desc = {
    Text = "Dokunaç Hasarının [StateArg1]%’üne eşit Geçici GÜÇ kazan. Golyat %25 Geçici Kritik Oranı kazanır."
  },
  State_45716_Name = {Text = "Gasp Et"},
  State_45717_Desc = {
    Text = "Bu Savaş boyunca \"Kılıcın Hükümranlık\"ı ve \"Baş Kesme Hasarı\" nın Temel Hasar’ını %25 artır. Golyat, <Energy:[Energy:StateArg2]> Aliemus elde eder."
  },
  State_45717_Name = {Text = "Uyku Hâli"},
  State_45718_Desc = {
    Text = "Bu savaşta \"Kılıcın Hükümranlığı\" ve \"Baş Kesme Hasarı\"nın Temel Hasarını %25 artır."
  },
  State_45718_Name = {Text = "Uyku Hâli"},
  State_46057_Name = {
    Text = "Arithmetica"
  },
  State_46079_Desc = {
    Text = "Bu turda, hedef her Aktif Hasar aldığında, en çok kaybedilen HP’ye sahip müttefiki [Layer] iyileştir."
  },
  State_46079_Name = {
    Text = "Kutsal Kanın Rehberliği"
  },
  State_46119_Desc = {
    Text = "Bir sonraki saldırıya uğradığında, saldırgana Sarmalamak uygula."
  },
  State_46119_Name = {
    Text = "Labirent Tuzağı"
  },
  State_46124_Desc = {
    Text = "Tur sonuna kadar hiçbir eylem gerçekleştiremez."
  },
  State_46124_Name = {
    Text = "Taşlaştır"
  },
  State_46138_Desc = {
    Text = "Rakibin oynadığı son \"Yetenek\" haline gelir ve onun bedelini -1 azaltır."
  },
  State_46138_Name = {
    Text = "<CardKeyWord:Yıldız Işığı Taklidi>"
  },
  State_46139_Desc = {
    Text = "Aktif Hasar alındığında [Layer] yığın Şarj kazan ve saldırgana [Layer] yığın Durgunluk uygula."
  },
  State_46139_Name = {
    Text = "Anormal Yerçekimi"
  },
  State_46155_Desc = {
    Text = "\"Beceri\" kullandıktan sonra [StateArg1] Şarj kazan ve bu durumun 1 yığınını kaybet. Tur sonunda tüm yığınları tüket, her yığın için [StateArg2] HP yenile."
  },
  State_46155_Name = {
    Text = "Sapkın Kan"
  },
  State_46243_Name = {
    Text = "Kavrayış Sayacı__\"Yalnızca Geliştirme İçin\""
  },
  State_46255_Desc = {
    Text = "Belirli etkiler için temel Saldırı mantığına bakın."
  },
  State_46256_Desc = {
    Text = "Belirli etkiler için temel Saldırı mantığına bakın."
  },
  State_46322_Desc = {
    Text = "Tur başlangıcında, 30 Embriyo Füzyonu kazan."
  },
  State_46322_Name = {
    Text = "Uvhash Deneme"
  },
  State_46323_Desc = {
    Text = "Ultra Tur başında 100 Aliemus kazan. Tur başında 7 Güç kazan."
  },
  State_46323_Name = {Text = "Liz Deneme"},
  State_46324_Desc = {
    Text = "Her tur 1 \"Kavrayış\" kazan."
  },
  State_46324_Name = {
    Text = "Jenkin Duruşması"
  },
  State_46329_Desc = {
    Text = "Savaşın başında 600 Keyflare kazan. Lotan 50 Aliemus kazanır. Lotan’ın Yücelişinden sonra, fazladan 44 Aliemus daha kazanılır."
  },
  State_46329_Name = {
    Text = "Duruşma Bonusu"
  },
  State_46330_Desc = {
    Text = "Tur başlangıcında, 30 Embriyo Füzyonu, 10 Aliemus, [DescArg1] GÜÇ kazan ve Çekme Destesine 3 \"Vuruş\" ekle."
  },
  State_46330_Name = {
    Text = "Helot Duruşması"
  },
  State_46333_Name = {
    Text = "Leigh Deneme"
  },
  State_46334_Desc = {
    Text = "4. turdan sonra 100 Aliemus kazan."
  },
  State_46334_Name = {
    Text = "Faros Deneme"
  },
  State_46336_Desc = {
    Text = "Tur başında, 30 Embriyo Füzyonu ve 10 Aliemus kazan."
  },
  State_46336_Name = {
    Text = "Agrippa Deneme"
  },
  State_46337_Desc = {
    Text = "Tur başında 10 Aliemus kazan."
  },
  State_46337_Name = {
    Text = "Caecus Deneme"
  },
  State_46338_Desc = {
    Text = "Tur başında, 30 Embriyo Füzyonu ve 10 Aliemus kazan."
  },
  State_46338_Name = {
    Text = "Solgun Deneme"
  },
  State_46427_Desc = {
    Text = "Belirli etkiler için temel Saldırı mantığına bakın."
  },
  State_46428_Desc = {
    Text = "Belirli etkiler için temel Saldırı mantığına bakın."
  },
  State_46429_Desc = {
    Text = "Belirli etkiler için temel Saldırı mantığına bakın."
  },
  State_46441_Desc = {
    Text = "Tüm Hasara Bağışıklık. Tur başında kaldırılır."
  },
  State_46441_Name = {
    Text = "Hasara Bağışıklık"
  },
  State_46442_Name = {
    Text = "Kartın hedef türünün değiştirilmesi yasaktır."
  },
  State_46500_Desc = {
    Text = "Belirli etkiler için temel Saldırı mantığına bakın."
  },
  State_46505_Desc = {
    Text = "Bu tur içinde, her Aktif Hasar aldığında [Layer] Aliemus kazan."
  },
  State_46505_Name = {
    Text = "Acı Dönüşümü"
  },
  State_46508_Desc = {
    Text = "Baygın olduğunda, hedef turun sonuna kadar hareket edemez. Baygınlık Hasarı almak Direnç kazandırır. Direnç etkinken, sonraki Baygınlık Hasarı ikiye katlanır ancak Baygınlık etkisi geçersiz kılınır."
  },
  State_46508_Name = {Text = "Direnç"},
  State_46511_Desc = {
    Text = "Bu Uyandırıcı'nın \"Yüzlerin Örtüşmesi\" hasarı [Layer] artar."
  },
  State_46511_Name = {
    Text = "Yüzlerin Örtüşmesi"
  },
  State_46512_Desc = {
    Text = "Tur bitmeden önce, bu Uyandıran, oynanan her kart için [Layer] Hasar alır."
  },
  State_46512_Name = {
    Text = "Eylem Kilidi"
  },
  State_46513_Desc = {
    Text = "Bir Sonraki Mezmuru güçlendirerek ek etkiler kazandır. Dağıtılamaz."
  },
  State_46513_Name = {
    Text = "Yaslı Mürekkep"
  },
  State_46536_Desc = {
    Text = "Durum parametresi 1, 0 ise bir kart çek; değilse yalnızca metni yüzdür."
  },
  State_46536_Name = {Text = "Çek"},
  State_46538_Desc = {
    Text = "Keşfin başında [StateArg1] Aliemus kazan."
  },
  State_46538_Name = {
    Text = "Delilik Alameti"
  },
  State_47072_Desc = {
    Text = "Bu tur \"Darbe\"nin Kritik Oranı [Layer]% artar."
  },
  State_47072_Name = {
    Text = "Vuruş Kritik Vuruş"
  },
  State_47089_Name = {
    Text = "Test Etkisi__\"Yalnızca Geliştirme İçin\""
  },
  State_47096_Desc = {
    Text = "Her \"Kavrayış\" kartı oynandığında, Nergis [StateArg1] Aliemus ve [StateArg2] Güç kazanır; bu etki tur başına en fazla 5 kez tetiklenir.(Şu anda [DescArg1] kez kalmış)"
  },
  State_47096_Name = {
    Text = "Öz Çökeltisi"
  },
  State_47189_Name = {
    Text = "Çılgın Kişiliğe geç. Caro·Bunalımlı: <EmbryoFusionIconKeywords:Embriyo Füzyonu> +[Blood:StateArg5], [StateArg6] puan Kızıl Ocak iyileşme miktarı biriktirir"
  },
  State_47192_Name = {
    Text = "Bunalımlı Persona: Diğer Uyandırıcıların da [DescArg1] kat Aliemus kazanmasını sağlar. Çılgın Kişilik: Ekstra [DescArg2] kat Aliemus kazanır"
  },
  State_47199_Name = {
    Text = "Bunalımlı Persona'ya geç. Caro: Delilik: Hasar [DescArg1]x <PowerIconKeywords:STR> Bonusu alır ve Hedefe verilen Hasarın %200'ü kadar <BleedingIconKeywords:Kanama> uygular. [StateArg7] <PowerIconKeywords:STR> kazan"
  },
  State_47204_Name = {
    Text = "Manik Kişilik’e geç.\nKaos: Depresyon: <Posse:[StateArg1]> Keyflare kazan. Bir sonraki Müfreze tetiklenmesi 2 kez gerçekleşir"
  },
  State_47206_Name = {
    Text = "Manik Kişilik'e geç. Aequor: Depresyon: Hedefe 2 tur boyunca <WeaknessIconKeywords:Zayıflık> ve <VulnerabilityIconKeywords:Savunmasız> uygula, 1 Dokunaç üret, <TentacleInjurieIconKeywords:Dokunaç Hasarı> + [TentaclePower:StateArg3]"
  },
  State_47209_Name = {
    Text = "Bunalımlı Persona'ya geç. Ultra: Semptom: Delilik: Verilen Hasarın %15'ini <RetaliateIconKeywords:Karşı Atak> olarak kazan, ardından diğer düşmanlara eşit miktarda <FixedDamage:Saf Hasar> ver. Bu tur oynanan her \"Kavrayış\" kartı için, bu Hasarı tur sonuna kadar [StateArg9] artır; en fazla [StateArg10]"
  },
  State_47211_Name = {
    Text = "Bunalımlı Persona: Eldeki en yüksek Arithmetica maliyetli [DescArg1] Kartın Arithmetica Maliyetini 1 azaltır ve Geçici <RetainIconKeywords:Sakla> kazanır. Çılgın Kişilik: Ekstra [DescArg2] kez Hasar verir"
  },
  State_47212_Name = {
    Text = "\"24\", Depresif ve Manik Kişilikler arasında geçiş yapar. Mevcut Âleme ve Kişiliğe göre ek etkiler tetikler"
  },
  State_47216_Name = {
    Text = "Depresif Kişilik'e geç. Aequor: Mania: Bu saldırı [StateArg4]% <TentacleInjurieIconKeywords:Tentacle DMG> bonusu kazanır. Verilen Hasarın %30'u kadar <IntoxicationIconKeywords:Poison> tüm düşmanlara yükle."
  },
  State_47217_Name = {
    Text = "Depresif Kişilik’e geç.\nKaos: Mani: 3 kez Hasar ver ve \"24\" tarafından verilen tüm Hasarı [StateArg2] artır"
  },
  State_47218_Name = {
    Text = "Manik Kişilik'e geç. Ultra: Depresyon: Eline 2 \"İdrak\" kartı ekle, hedefin [Power:StateArg8] <PowerIconKeywords:STR> değerini geçici olarak azalt."
  },
  State_47222_Name = {
    Text = "Bunalımlı Persona: Eldeki en yüksek Arithmetica maliyetli [DescArg1] Kartın Arithmetica Maliyetini 1 azaltır ve Geçici <RetainIconKeywords:Sakla> kazanır. <AwakerCard_24Lost:Çılgın Kişilik: Ekstra [DescArg2] kez Hasar verir>"
  },
  State_47224_Name = {
    Text = "Bunalımlı Persona: Diğer Uyandırıcıların da [DescArg1] kat Aliemus kazanmasını sağlar. <AwakerCard_24Lost:Çılgın Kişilik: Ekstra [DescArg2] kat Aliemus kazanır>"
  },
  State_47228_Name = {
    Text = "<AwakerCard_24Lost:Bunalımlı Persona: Diğer Uyandırıcıların da [DescArg1] kat Aliemus kazanmasını sağlar.>Çılgın Kişilik: Ekstra [DescArg2] kat Aliemus kazanır"
  },
  State_47229_Name = {
    Text = "<AwakerCard_24Lost:Bunalımlı Persona: Eldeki en yüksek Arithmetica maliyetli [DescArg1] Kartın Arithmetica Maliyetini 1 azaltır ve Geçici <RetainIconKeywords:Sakla> kazanır. >Çılgın Kişilik: Ekstra [DescArg2] kez Hasar verir"
  },
  State_47451_Name = {
    Text = "Ryker Çetesi Kader Çarkı etkilerini devre dışı bırakır"
  },
  State_47485_Name = {
    Text = "Bunalımlı Persona: Eldeki en yüksek Arithmetica maliyetli [DescArg1] Kartın Arithmetica Maliyetini 2 azaltır ve Geçici <RetainIconKeywords:Sakla> kazanır. Çılgın Kişilik: Ekstra [DescArg2] kez Hasar verir"
  },
  State_47486_Name = {
    Text = "Bunalımlı Persona: Eldeki en yüksek Arithmetica maliyetli [DescArg1] Kartın Arithmetica Maliyetini 2 azaltır ve Geçici <RetainIconKeywords:Sakla> kazanır. <AwakerCard_24Lost:Çılgın Kişilik: Ekstra [DescArg2] kez Hasar verir>"
  },
  State_47488_Name = {
    Text = "Bunalımlı Persona: Ekstra <Energy: [DescArg1]> puan Aliemus kazanır. Çılgın Kişilik: Ekstra [DescArg2] kez Kalkan kazanır"
  },
  State_47489_Name = {
    Text = "<AwakerCard_24Lost:Bunalımlı Persona: Eldeki en yüksek Arithmetica maliyetli [DescArg1] Kartın Arithmetica Maliyetini 2 azaltır ve Geçici <RetainIconKeywords:Sakla> kazanır. >Çılgın Kişilik: Ekstra [DescArg2] kez Hasar verir"
  },
  State_47492_Name = {
    Text = "Bunalımlı Persona: Ekstra <Energy: [DescArg1]> puan Aliemus kazanır. <AwakerCard_24Lost:Çılgın Kişilik: Ekstra [DescArg2] kez Hasar verir>"
  },
  State_47493_Name = {
    Text = "Bunalımlı Persona: Ekstra <Energy: [DescArg1]> puan Aliemus kazanır. Çılgın Kişilik: Ekstra [DescArg2] kez Hasar verir"
  },
  State_47494_Name = {
    Text = "Bunalımlı Persona: Diğer Uyandırıcıların da [DescArg1] kat Aliemus kazanmasını sağlar, tüm düşmanlara [DescArg3] tur <WeaknessIconKeywords:Zayıflık> uygular. Çılgın Kişilik: Ekstra [DescArg2] kat Aliemus kazanır, tüm düşmanlara [DescArg3] tur <VulnerabilityIconKeywords:Savunmasız> uygular"
  },
  State_47495_Name = {
    Text = "Bunalımlı Persona: Diğer Uyandırıcıların da [DescArg1] kat Aliemus kazanmasını sağlar, tüm düşmanlara [DescArg3] tur <WeaknessIconKeywords:Zayıflık> uygular. <AwakerCard_24Lost:Çılgın Kişilik: Ekstra [DescArg2] kat Aliemus kazanır, tüm düşmanlara [DescArg3] tur Savunmasız uygular>"
  },
  State_47496_Name = {
    Text = "<AwakerCard_24Lost:Bunalımlı Persona: Diğer Uyandırıcıların da [DescArg1] kat Aliemus kazanmasını sağlar, tüm düşmanlara [DescArg3] tur Zayıflık uygular.>Çılgın Kişilik: Ekstra [DescArg2] kat Aliemus kazanır, tüm düşmanlara [DescArg3] tur <VulnerabilityIconKeywords:Savunmasız> uygular"
  },
  State_47498_Name = {
    Text = "<AwakerCard_24Lost:Bunalımlı Persona: Ekstra [DescArg1] Aliemus kazan.>Çılgın Kişilik: Ekstra [DescArg2] kez Hasar ver"
  },
  State_47499_Name = {
    Text = "<AwakerCard_24Lost:Bunalımlı Persona: Ekstra [DescArg1] Aliemus kazan.>Çılgın Kişilik: Ekstra [DescArg2] kez Kalkan kazan"
  },
  State_47500_Name = {
    Text = "Bunalımlı Persona: Ekstra <Energy: [DescArg1] > Aliemus kazan.<AwakerCard_24Lost:Çılgın Kişilik: Ekstra [DescArg2] kez Kalkan kazan>"
  },
  State_47517_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda, diğer Uyananlardan [StateArg1] kart at; başarılı olursan [StateArg2] kart çek."
  },
  State_47517_Name = {
    Text = "Gümüş Morina'nın Kararlılığı"
  },
  State_47518_Name = {
    Text = "Gümüş Morina'nın Kararlılığının Karşı Saldırısı __ \"Yalnızca Geliştirme Amaçlıdır\""
  },
  State_47528_Desc = {
    Text = "Bu tur, \"Vuruş\" +[DescArg1]% Hasar verir. <PVPPenetrateKeywords:Delici>."
  },
  State_47528_Name = {
    Text = "Yıldız Canavarının Artık Parıltısı"
  },
  State_47530_Desc = {
    Text = "Bu tur oynanan son “Beceri” olarak kabul edilir."
  },
  State_47530_Name = {
    Text = "<CardKeyWord:Yankılı Simülasyon>"
  },
  State_47557_Desc = {
    Text = "Takım Özgünlüğü: Kullanan, keşif başladıktan sonra Gümüş Morina Kişiliğine geçer. Taşkınlık kullandıktan sonra Gümüş Morina ve Kedi Kişilikleri arasında geçiş yapar.\nGümüş Morina: Aktif Hasar verdikten sonra <WeaponEffect_Num:[StateArg1]> S-Enerjisi kazan. Kedi: Aktif Hasar verdikten sonra <WeaponEffect_Num:+[StateArg2]%> Geçici Krit. Hasar artışı kazan. Bu etkiler tur başına en fazla 5 tetiklenmeyi paylaşır."
  },
  State_47557_WeaponDesc = {
    Text = "Kullanan, keşif başladıktan sonra Gümüş Morina Kişiliğine geçer. Taşkınlık kullandıktan sonra Gümüş Morina ve Kedi Kişilikleri arasında geçiş yapar.\nGümüş Morina: Aktif Hasar verdikten sonra <WeaponEffect_Num:[StateArg1]> S-Enerjisi kazan. Kedi: Aktif Hasar verdikten sonra <WeaponEffect_Num:+[StateArg2]%> Geçici Krit. Hasar artışı kazan. Bu etkiler tur başına en fazla 5 tetiklenmeyi paylaşır."
  },
  State_47822_Desc = {
    Text = "Bir sonraki turda tekrar \"Felç\" uygulanırsa, tüm \"Vuruş\" kartları \"İllüzyon\" olur; dağıtılamaz, bir sonraki tur sonuna kadar devam eder."
  },
  State_47822_Name = {
    Text = "Biraz Uyuştu"
  },
  State_47825_Desc = {
    Text = "Tur başında, karşılık gelen Beceri Etkisi tetiklenir."
  },
  State_47825_Name = {
    Text = "<CardKeyWord:Gecikme>"
  },
  State_47826_Desc = {
    Text = "·Hedef \"Felç\" durumundayken hasar iki katına çıkar, aksi takdirde bu tur onun \"Vuruş\" kartları kullanılamaz.\n·Üst üste 2 tur \"Felç\" durumunda kalırsa, tüm \"Vuruş\" kartları \"İllüzyon\" olur."
  },
  State_47826_Name = {
    Text = "<WeaknessColour:Felç>"
  },
  State_47827_Desc = {
    Text = "Her yığın, bu Savaşta verilen tüm Hasarı 1 puan azaltır ve dağıtılamaz."
  },
  State_47827_Name = {
    Text = "<WeaknessColour:STR▼>"
  },
  State_47828_Desc = {
    Text = "Bu durum bir düşmana uygulandığında, aynı miktarda Hasar ver. Hedef zaten \"Sarmalanmış\" ise verilen Hasar iki katına çıkar. \"Sarmalanmak\", turun sonuna kadar hedefin kuşanılı Kader Çarkı’nı devre dışı bırakır."
  },
  State_47828_Name = {
    Text = "<WeaknessColour:Birbirine Dolanmış>"
  },
  State_47830_Desc = {
    Text = "Uygulandığında, hedef üzerindeki Karakter Kalkanı ve Gecikmeli İyileştirme’yi dağıtır. Tur sonuna kadar alınan İyileştirme ve Karakter Kalkanı Etkileri %50 azaltılır."
  },
  State_47830_Name = {
    Text = "<PVPVulnerabilityIconColour:Ağır Yıkım>"
  },
  State_47831_Desc = {
    Text = "Baygın olduğunda, hedef turun sonuna kadar hareket edemez. Baygınlık Hasarı almak Direnç kazandırır. Direnç etkinken, sonraki Baygınlık Hasarı ikiye katlanır ancak Baygınlık etkisi geçersiz kılınır."
  },
  State_47831_Name = {
    Text = "<ComaColour:Taşlaştırma>"
  },
  State_47832_Desc = {
    Text = "Veba Kapan Fareler, Elektrikli Fareler ve Bunama Fareleri dâhil"
  },
  State_47832_Name = {
    Text = "<CardKeyWord:Sıçan Kartı>"
  },
  State_47833_Desc = {
    Text = "Güvercin İşlemeli Mendil, Ters Bölünmüş Sihir Kutusu ve Telepati Mikrofonu dâhil."
  },
  State_47833_Name = {
    Text = "<CardKeyWord:Şaşırtıcı Sihir>"
  },
  State_47841_Desc = {
    Text = "Bu Savaşta bir sonraki [Layer] Posse kullanımı iki kez etkili olur."
  },
  State_47841_Name = {
    Text = "İkili Müfreze"
  },
  State_47842_Desc = {
    Text = "Kazanılan Aliemus ve Gecikmeli Aliemus %50 azalır ve tüm Gecikmeli Aliemus anında kaldırılır."
  },
  State_47842_Name = {
    Text = "<PVPEmptinessColour:Boşluk>"
  },
  State_47843_Desc = {
    Text = "Uyandırıcıyı ölüm Durumu’ndan Canlanma ile geri getir ve tüm kartlarını Çekme Desteği’ne yerleştir."
  },
  State_47843_Name = {
    Text = "<PVPResurrectionColour:Diriliş>"
  },
  State_47844_Desc = {
    Text = "Rastgele, aklı karıştıran bir Etki üretir."
  },
  State_47844_Name = {
    Text = "<PVPWonderfulEffectKeywords:Harika Etki>"
  },
  State_47845_Desc = {
    Text = "Kart, eldeyken bir etki üretir."
  },
  State_47845_Name = {
    Text = "<CardKeyWord:Elde>"
  },
  State_47873_Desc = {
    Text = "Bir sonraki turun sonunda, yığın sayısına eşit Hasar ver."
  },
  State_47873_Name = {
    Text = "<PVPVulnerabilityIconColour:Kanama>"
  },
  State_47887_Name = {
    Text = "Mevcut ekibin Diyar’ına göre farklı etkiler"
  },
  State_47888_Name = {
    Text = "Caro: \"24\" her 1 Arithmetica tükettiğinde <EmbryoFusionIconKeywords:Embriyo Füzyonu> +[Blood:DescArg1], [StateArg3] puan <PowerIconKeywords:Güç> kazanır; \"24\" Taşkınlığı ekstra %300 Güç bonusundan yararlanır"
  },
  State_47889_Name = {
    Text = "Aequor: \"24\"ün verdiği Hasar, [StateArg2]% <TentacleInjurieIconKeywords:Dokunaç Hasarı> bonusu kazanır ve verilen Hasarın %10’una eşit <IntoxicationIconKeywords:Zehir> uygular. \"24\"ün Yüceltmesi, düşmanlar üzerinde [StateArg6]% <IntoxicationIconKeywords:Zehir> tetikleyebilir."
  },
  State_47892_Name = {
    Text = "Kaos: \"24\"ün Kritik Oranı ve Kritik Hasar +[StateArg4]%. Her Müfreze kullanıldığında, \"24\"ün Taşkınlık Final Hasarı [StateArg1]% artar"
  },
  State_47894_Name = {
    Text = "Ultra: \"24\"ün verdiği Hasar, [StateArg5]% <RetaliateIconKeywords:Counter> bonusundan yararlanır. Tur sonunda 1 \"İdrak\" kartını Atılmış Kart Destesi’ne karıştır, El Limiti +2."
  },
  State_48009_Desc = {
    Text = "Her tur ilk oynandığında, [StateArg1] ek kez etkinleşir."
  },
  State_48009_Name = {
    Text = "<Rune_19:Topluluk>"
  },
  State_48010_Desc = {
    Text = "Topluluk İşareti"
  },
  State_48010_Name = {
    Text = "Topluluk İşareti"
  },
  State_48011_Desc = {
    Text = "Her tur ilk oynandığında, [StateArg1] ek kez etkinleşir."
  },
  State_48011_Name = {
    Text = "<Rune_19_High:İleri Topluluk>"
  },
  State_48011_WeaponDesc = {
    Text = "Oynandıktan sonra, ek olarak [StateArg1] kez daha Etki gösterir. Tüketme."
  },
  State_48012_Desc = {
    Text = "Yakarış içeren kartın, her tur ilk oynandığında 2 kez etkinleşmesini sağla."
  },
  State_48012_Name = {
    Text = "<CardKeyWord:Topluluk>"
  },
  State_48013_Desc = {
    Text = "Yakarış içeren kartın, her tur ilk oynandığında 3 kez etkinleşmesini sağla."
  },
  State_48013_Name = {
    Text = "<CardKeyWord:İleri Topluluk>"
  },
  State_48019_Name = {
    Text = "<CardKeyWord:Yankılı Simülasyon>"
  },
  State_48020_Name = {
    Text = "<CardKeyWord:Bir Ruhun Doğuşu>"
  },
  State_48021_Name = {
    Text = "<CardKeyWord:Gri Sisin Ardındaki Gerçek>"
  },
  State_48078_Name = {
    Text = "<CardKeyWord:Yıldız Işığı Taklidi>"
  },
  State_48099_Desc = {
    Text = "Tur sonunda, \"24\" [DescArg1] Aliemus kazanır. \"24\" her Aşkınlık tetiklediğinde, bu etkiden kazanılan Aliemus miktarı 1 artar."
  },
  State_48099_Name = {
    Text = "Pavlov Davranış Araştırması"
  },
  State_48099_WeaponDesc = {
    Text = "Taşıyıcının turunun sonunda 3 Aliemus kazan. Taşıyıcının Aliemus Dolumu 10'dan büyükse fazladan 2 Aliemus kazan."
  },
  State_48100_Name = {
    Text = "Durum@24 Pavlov Davranış Araştırması Sayısı"
  },
  State_48100_WeaponDesc = {
    Text = "Taşıyıcının turunun sonunda 3 Aliemus kazan. Taşıyıcının Aliemus Dolumu 10'dan büyükse fazladan 2 Aliemus kazan."
  },
  State_48107_Desc = {
    Text = "Kullanan kişinin her turda oynadığı ilk \"Yetenek\" +[StateArg1]% Hasar verir."
  },
  State_48107_Name = {
    Text = "Devin Kılıcı"
  },
  State_48108_Desc = {
    Text = "Kuşanan her turda ilk kez bir \"Yetenek\" oynadığında, Arithmetica Maliyeti - [StateArg1] olan bir kopyayı Çekme Desteğine Karıştır."
  },
  State_48108_Name = {Text = "Fouetté"},
  State_48110_Desc = {
    Text = "\"Yetenek\", bu tur atılacak bir sonraki \"Darbe\"nin rastgele bir düşmanı hedeflemesine ve ayrıca [StateArg1] adet daha rastgele hedefe saldırmasına neden olur."
  },
  State_48110_Name = {
    Text = "Aynadaki Adam"
  },
  State_48140_Desc = {
    Text = "Keşif başlangıcında, \"24\" Bunalımlı Persona durumuna girer.\n<School_1:Kaos: Bunalımlı>: <Posse:[StateArg1]> S-Enerjisi kazanır, bir sonraki Müfreze 2 kez geçerli olur.\n<School_1:Kaos: Çılgın>: 3 kez hasar verir, \"24\"ün verdiği tüm hasarı [StateArg2] puan artırır.\n<School_2:Aequor: Bunalımlı>: Hedefe 2 tur <WeaknessIconKeywords:Semptom: Zayıflık> ve <VulnerabilityIconKeywords:Savunmasız> uygular, 1 Dokunaç oluşturur, <TentacleInjurieIconKeywords:Dokunaç Hasarı> +[StateArg3].\n<School_2:Aequor: Çılgın>: Bu hasar [StateArg4]% <TentacleInjurieIconKeywords:Dokunaç Hasarı> bonusundan yararlanır ve tüm düşmanlara verilen hasarın %30'u kadar <IntoxicationIconKeywords:Zehir> uygular.\n<School_3:Caro: Bunalımlı>: <EmbryoFusionIconKeywords:Embriyo Füzyonu> +[Blood:StateArg5], [StateArg6] puan Kızıl Ocak iyileşme miktarı biriktirir.\n<School_3:Caro: Çılgın>: Hasar 6 kat <PowerIconKeywords:STR> bonusundan yararlanır ve hedefe verilen hasarın %200'ü kadar <BleedingIconKeywords:Kanama> uygular, [StateArg7] puan <PowerIconKeywords:STR> kazanır.\n<School_4:Ultra: Bunalımlı>: Ele 2 \"Kavrayış\" kartı ekler, hedefin <PowerIconKeywords:STR> değerini geçici olarak [StateArg8] puan düşürür.\n<School_4:Ultra: Çılgın>: Verilen hasarın %15'i kadar <RetaliateIconKeywords:Karşı Atak> kazanır, ardından diğer düşmanlara eşit miktarda <RealDamage:Sabit Hasar> verir. Bu turda her 1 \"Kavrayış\" kartı oynadığında bu hasarı [StateArg9] puan artırır, en fazla [StateArg10] puan artırılabilir."
  },
  State_48140_Name = {
    Text = "Diyar ve Kişilik Etkileri"
  },
  State_48141_Desc = {
    Text = "<School_1:Kaos>: \"24\"ün Kritik Oranı ve Kritik Hasarı +[StateArg4]%. Her Müfreze kullanımından sonra \"24\"ün Taşkınlık Final Hasarını [StateArg1]% artırır.\n <School_2:Aequor>: \"24\"ün verdiği hasar [StateArg2]% <TentacleInjurieIconKeywords:Dokunaç Hasarı> bonusundan yararlanır ve %10 hasar kadar <IntoxicationIconKeywords:Zehir> uygular. \"24\"ün Taşkınlığı düşmanın %50 <IntoxicationIconKeywords:Zehir>'ini tetikleyebilir.\n <School_3:Caro>: \"24\" her 1 Arithmetica harcadığında <EmbryoFusionIconKeywords:Embriyo Füzyonu> +[Blood:5], [StateArg3] puan <PowerIconKeywords:Güç> kazanır. \"24\"ün Taşkınlığı ekstra 300% Güç bonusundan yararlanır.\n <School_4:Ultra>: \"24\"ün verdiği hasar [StateArg5]% <RetaliateIconKeywords:Karşı Saldırı> Hasar Bonusundan yararlanır, tur sonunda Atılmış Kart Destesine 1 \"Kavrayış\" Karıştırır, Maksimum El Boyutu +2."
  },
  State_48141_Name = {
    Text = "Diyar Etkisi"
  },
  State_48149_Name = {
    Text = "Kart Özel Efekti Kullanılamaz"
  },
  State_48176_Desc = {
    Text = "Bu sınamada, her tur 1 Arithmetica kazan; tüketilen her 1 Arithmetica için 30 Keyflare kazan."
  },
  State_48176_Name = {Text = "\"24\"Deneme"},
  State_48198_Desc = {
    Text = "Bu sınavda her tur 1 \"Kavrayış\" kazan."
  },
  State_48198_Name = {Text = "\"24\"Deneme"},
  State_48199_Desc = {
    Text = "Bu demoda her tur 1 Arithmetica kazan."
  },
  State_48199_Name = {Text = "\"24\"Deneme"},
  State_48589_Desc = {
    Text = "Bu Uyanışçı Henüz Uyanmamış...\nYenilmek üzereyken Uyanış’a geçecek, Maksimum HP’si %200 artacak ve tüm gücüyle savaşacak."
  },
  State_48589_Name = {
    Text = "Uyanmamış"
  },
  State_48607_Name = {
    Text = "Genel Kartların Köken Arithmetica'sını azalt"
  },
  State_48822_Desc = {
    Text = "Caro Diyarındaki turların başında, Embriyo Füzyonu kazanımı %50 artar."
  },
  State_48822_Name = {
    Text = "Sonsuz Döngü"
  },
  State_48923_Desc = {
    Text = "Gölge \"24\" uyandırıldı. Son \"Kurtar Beni\" ile fırsatını yakala!"
  },
  State_48923_Name = {
    Text = "Gölge\"24\"Uyanış!"
  },
  State_48923_WeaponDesc = {
    Text = "Bir sonraki turun başında, önceki turda kaybedilen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_49063_Desc = {
    Text = "Lotan’ın \"Darbe\" Hasarı %30 artar."
  },
  State_49063_Name = {
    Text = "Coşkun Savaş Arzusu"
  },
  State_49109_Desc = {
    Text = "Kartlar Sakla etkisi kazanır. Tur sonunda, bu kart Elde ise, Tüketme özelliğine sahip Komut Kartının özgün bir kopyasını kazan."
  },
  State_49109_Name = {
    Text = "<Rune_20_High:Doğum>"
  },
  State_49109_WeaponDesc = {
    Text = "Oynandıktan sonra, ek olarak [StateArg1] kez daha Etki gösterir. Tüketme."
  },
  State_49148_Desc = {
    Text = "Öldüğünde, Arithmetica Maliyeti sıfır olmayan bir karta \"Mutasyon 1\" ekle. Mutasyon: Savaş bittikten sonra da kalır. Her yığın, Arithmetica Maliyeti’ni 1 azaltır, ancak oynandıktan sonra, her yığın eline(el sınırını yok sayarak) 1 rastgele Mutasyon ekler ve tüm Mutasyon’u kaldırır."
  },
  State_49148_Name = {
    Text = "Sapkın Cenin"
  },
  State_49149_Desc = {
    Text = "Her yığın, kartların Arithmetica Maliyeti’ni 1 azaltır. Oynandıktan sonra, her Mutasyon yığını için eline rastgele bir Bükülme kartı ekle ve bu durumu kaldır. Bu durum Savaş sonrasında da sürer."
  },
  State_49149_Name = {
    Text = "<ExclamationPointColour:Mutasyon [Layer]>"
  },
  State_49149_WeaponDesc = {
    Text = "Kullandıktan sonra onu kalıcı olarak kaldır."
  },
  State_49207_Name = {
    Text = "100 Anahtarışığı Kazan"
  },
  State_49225_Desc = {
    Text = "Tur sonunda, 1 Dokunaç [Layer] kez Dokunaç Saldırısı yapar."
  },
  State_49225_Name = {
    Text = "<CardKeyWord:Dokunaç Toplanması>"
  },
  State_49226_Desc = {
    Text = "Tur sonunda, eldeki her kart için tüm düşmanlara %3 Zehir uygula ve 3 Aliemus kazan."
  },
  State_49226_Name = {
    Text = "Soluk Mum Işığı"
  },
  State_49260_Desc = {
    Text = "Tur sonunda KON’un %7,5’ine eşit HP yeniler."
  },
  State_49260_Name = {
    Text = "Dışlananın Acısı"
  },
  State_49270_Desc = {
    Text = "Darbe kartı Hasarı [Layer]% artar."
  },
  State_49270_Name = {
    Text = "Vuruş Kartlarının Hasarı Artırıldı"
  },
  State_49270_WeaponDesc = {
    Text = "Darbe kartı Hasarı [Layer]% artar."
  },
  State_49278_Desc = {
    Text = "Tur sonunda, kaybedilen HP’nin %5’i kadar HP yenile. HP %50’nin altındaysa ([StateArg1]), [StateArg2] Güç kazan."
  },
  State_49278_Name = {
    Text = "Kızıl Sunak"
  },
  State_49430_Desc = {
    Text = "Alınan Hasar, yığın başına -%1. Müttefikler öldüğünde Durum tamamlanır."
  },
  State_49430_Name = {
    Text = "<AberrationColour:Gizlenme>"
  },
  State_49500_Desc = {
    Text = "Her yığın, saldırı sayısını 1 artırır. Hasar aldığında 1 yığın kaybedersin ve tur sonunda tüm yığınları yitirirsin."
  },
  State_49500_Name = {Text = "Dua"},
  State_49524_Desc = {
    Text = "Tur sonunda, kaybedilen HP'nin %5'i kadar HP yenilenir. Her Durum Kartı veya Semptom kartı çektiğinde, tüm \"Nubia\" [StateArg1] Geçici GÜÇ kazanır."
  },
  State_49524_Name = {
    Text = "Kızıl İncil"
  },
  State_49526_Desc = {
    Text = "Öldüğünde [StateArg2] HP yeniler ve 1 tur boyunca Hasara karşı bağışıklık kazanır, Niyet'i \"Yozlaşma Yayılımı\"na ayarlar."
  },
  State_49526_Name = {
    Text = "Tohum Saçma"
  },
  State_49542_Desc = {
    Text = "Takıma Özel: Savaş başladıktan sonra, Kuşananın Saldırısının <WeaponEffect_Num:[StateArg1]%>'i kadar STR kazan. Mevcut âlem \"Aequor\" ise, ayrıca Kuşananın Saldırısının <WeaponEffect_Num:[StateArg2]%>'i kadar Dokunaç Hasarı artır."
  },
  State_49542_WeaponDesc = {
    Text = "Savaşın başında <WeaponEffect_Num:[Power:DescArg1]> Güç kazan; mevcut Âlem \"Aequor\" ise ayrıca <WeaponEffect_Num:[DescArg2]> Dokunaç Hasarı da kazan."
  },
  State_49546_Desc = {
    Text = "Her zaman 2 seçkin Muhafız ile birlikte görünür. O öldüğünde onlar da ölür."
  },
  State_49546_Name = {Text = "Düzen"},
  State_49547_Desc = {
    Text = "Öldüğünde, Aram Muhafız Komutanı [StateArg1] Güç kazanır ve Maksimum CP’nin %50’sine eşit bir Karakter Kalkanı elde eder."
  },
  State_49547_Name = {Text = "Sadakat"},
  State_49558_Desc = {
    Text = "Her tur GÜÇ’ü [StateArg1] artır."
  },
  State_49558_Name = {
    Text = "Kumların Duası"
  },
  State_49582_Desc = {
    Text = "Bu Savaşta her turun sonunda kalan Karakter Kalkanı kaldırılmaz ve olduğu gibi kalır."
  },
  State_49582_Name = {
    Text = "Kalkan Kalıcı Koruma"
  },
  State_49583_Desc = {
    Text = "Tur sonunda, [StateArg1] Karakter Kalkanı kazan; Uyanıklık tarafından güçlendirilir."
  },
  State_49583_Name = {
    Text = "Aram'ın Kalkanı"
  },
  State_49595_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_49595_Name = {
    Text = "Uyanmamış"
  },
  State_49596_Desc = {
    Text = "\"Ütopya Kılıcı\" Uyanışa geçti. Daha fazla Karakter Kalkanı ve Güç kazanacak."
  },
  State_49596_Name = {
    Text = "Alva Uyanış!"
  },
  State_49596_WeaponDesc = {
    Text = "Bir sonraki turun başında, önceki turda kaybedilen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_49597_Name = {
    Text = "Bu turda zaten felç uygulandı"
  },
  State_49600_Desc = {
    Text = "Tüm düşmanlara 2 tur boyunca Zayıflık uygula."
  },
  State_49600_Name = {
    Text = "Korkunun Kanı"
  },
  State_49601_Desc = {
    Text = "Tüm düşmanları 2 tur boyunca Savunmasız yap."
  },
  State_49601_Name = {
    Text = "Çürüme Kanı"
  },
  State_49602_Desc = {
    Text = "Tüm düşmanları 1 tur boyunca savunmasız yap."
  },
  State_49602_Name = {
    Text = "Çürüme Kanı"
  },
  State_49603_Desc = {
    Text = "Embriyo Füzyonu +[Blood:DescArg1]."
  },
  State_49603_Name = {
    Text = "Birleşme Kanı"
  },
  State_49604_Desc = {
    Text = "Embriyo Füzyonu +[Blood:DescArg1]."
  },
  State_49604_Name = {
    Text = "Birleşme Kanı"
  },
  State_49605_Desc = {
    Text = "Tüm düşmanlara 1 tur boyunca Zayıflık uygula."
  },
  State_49605_Name = {
    Text = "Korkunun Kanı"
  },
  State_49623_Desc = {
    Text = "HP Yenilenmesi [DescArg1]% azaltılır. Tur sonunda 1 yığın kaldırılır."
  },
  State_49623_Name = {
    Text = "<BaseDamageColour:Ağır Yıkım>"
  },
  State_49623_WeaponDesc = {
    Text = "Verilen tüm Hasarı [DescArg1]% azalt."
  },
  State_49627_Desc = {
    Text = "Başlangıçta 2 yığın <ParcloseIconKeywords:Bariyer>e sahiptir. Ölümünde tüm \"Nubya\"lar [StateArg1] Güç kazanır."
  },
  State_49627_Name = {
    Text = "Kan Coşkusu"
  },
  State_49628_Desc = {
    Text = "Ölüm anında, tüm \"Nubia\" [StateArg1] Güç kazanır."
  },
  State_49628_Name = {Text = "Kan Bağı"},
  State_49638_Desc = {
    Text = "Siyah Keçi serisine ait bir Canavar durumu olup olmadığını belirle."
  },
  State_49833_Desc = {
    Text = "Tur sonunda, tüm düşmanlara 1 tur süren \"Körlük\" durumu uygula. Kendi Kalkanın kırıldığında, \"Körlük\" durumunu kaldır."
  },
  State_49833_Name = {
    Text = "Toz Bariyeri"
  },
  State_49844_Desc = {
    Text = "Takıma Özel: Tur sonunda <WeaponEffect_Num:[StateArg1]> Keyflare kazan. Ölüm Direnci tetikledikten sonra <WeaponEffect_Num:[StateArg2]> Keyflare kazan. Acil Gnosis Birimi kullanmak Arithmetica sınırını 3 artırır ve tur başına 3 kart çekmene izin verir."
  },
  State_49844_WeaponDesc = {
    Text = "Tur sonunda <WeaponEffect_Num:[StateArg1]> Keyflare kazan. Ölüm Direnci tetiklendikten sonra <WeaponEffect_Num:[StateArg2]> Keyflare kazan. Acil Gnosis Birimi kullanmak Arithmetica Sınırını 3 artırır ve tur başına 3 fazladan kart çekmeni sağlar."
  },
  State_49877_Desc = {
    Text = "Bu kartın Arithmetica Maliyeti azalır. Oynandıktan sonra, her Mutasyon yığını için 1 rastgele Mutasyon Kartı ekle ve durumu kaldır. Durum savaş sonrasında da sürer."
  },
  State_49877_Name = {
    Text = "<AberrationKeywords:Mutasyon>"
  },
  State_49877_WeaponDesc = {
    Text = "Her Durgunluk yığını, kartların Arithmetica Maliyetini 1 artırır."
  },
  State_49954_Desc = {
    Text = "Tüm Uyandırıcıların Krit. Hasarı yarıya iner."
  },
  State_49954_Name = {
    Text = "<BlindingKeywords:Körlük>"
  },
  State_49954_WeaponDesc = {
    Text = "Her Durgunluk yığını, kartların Arithmetica Maliyetini 1 artırır."
  },
  State_49957_Desc = {
    Text = "Aktif Hasar alındığında, saldıran Uyandırıcı'nın Taşkınlık ve Komut Kartlarını 1 tur mühürler, 1 <ResentChainsKeywords:Kin Zincirleri> yığını kaldırır. Tur sonunda temizlenir."
  },
  State_49957_Name = {
    Text = "<ResentChainsKeywords:Kin Zincirleri>"
  },
  State_49957_WeaponDesc = {
    Text = "Her Durgunluk yığını, kartların Arithmetica Maliyetini 1 artırır."
  },
  State_49958_Desc = {
    Text = "Aktif ve Dokunaç Hasarı alındığında, saldıran Uyandırıcının Taşkınlık ve Komut Kartlarını 1 tur mühürle, 1 <ResentChainsKeywords:Kin Zincirleri> yığınını kaldır."
  },
  State_49958_Name = {
    Text = "<ResentChainsKeywords1:Kin Zincirleri>"
  },
  State_49959_Desc = {
    Text = "Tur başında, 1 yığın <ResentChainsKeywords:Kin Zincirleri> kazan."
  },
  State_49959_Name = {
    Text = "Çok Boyutlu Kilit"
  },
  State_50010_Desc = {
    Text = "Alınan İyileştirme -%25. Tur sonunda 1 yığın kaldır."
  },
  State_50010_Name = {
    Text = "<HeavyInjuryKeywords:Ağır Yıkım>"
  },
  State_50021_Desc = {
    Text = "Takım Özgünlüğü: Kullanan Taşkınlık kullandıktan sonra, kullananın SLD'sinin <WeaponEffect_Num:[StateArg1]%>'i kadar <PowerIconKeywords:Güç> kazanır. Mevcut Diyar \"Caro\" ise Taşkınlık kullandıktan sonra Embriyo Füzyonu <WeaponEffect_Num:+[Blood:StateArg2]> olur."
  },
  State_50021_WeaponDesc = {
    Text = "Kullanan Taşkınlık kullandıktan sonra <WeaponEffect_Num:[Power:DescArg1]> <PowerIconKeywords:Güç> kazanır. Mevcut Diyar \"Caro\" ise Taşkınlık kullandıktan sonra Embriyo Füzyonu <WeaponEffect_Num:+[Blood:StateArg2]> olur."
  },
  State_50302_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: 1 ölüme diren ve bu \"Kader Çarkı\"nı yok et, [StateArg1] <PVPProtectiveKeywords:Bariyer> <plural value=\"[StateArg1]\" singular=\"yığın\" plural=\"yığın\"> kazan. Etki tetiklendiğinde kullanan hayatta kalan tek müttefikse, bir sonraki turun başında [StateArg2] rastgele \"Müfreze\" kazan."
  },
  State_50302_Name = {
    Text = "Kutup Gecesi ve Şafak Vakti"
  },
  State_50323_Desc = {
    Text = "Sonraki turun başlamasından önce [Layer] rastgele Çete kartı kazan."
  },
  State_50323_Name = {
    Text = "Gecikmeli Çete"
  },
  State_50333_Desc = {
    Text = "Tur sonunda, tüm Uyandıranlar Aliemus kaybeder."
  },
  State_50333_Name = {
    Text = "<EmptinessKeywords:Boşluk>"
  },
  State_50333_WeaponDesc = {
    Text = "Her Durgunluk yığını, kartların Arithmetica Maliyetini 1 artırır."
  },
  State_50352_Name = {
    Text = "Thais Deneme"
  },
  State_50353_Name = {
    Text = "Thais Deneme"
  },
  State_50358_Desc = {
    Text = "Alınan Hasar, yığın başına -%1. Müttefikler öldüğünde Durum tamamlanır."
  },
  State_50358_Name = {
    Text = "<ConcealmentKeywords:Gizlen>"
  },
  State_50375_Desc = {
    Text = "Bu Etkiler şunları içerir: kendine 10 Aliemus kazandır, diğer müttefiklere 5 Aliemus kazandır, tüm düşmanlara 1 yığın Savunmasız uygula, tüm düşmanlara 1 yığın Zayıflık uygula, 1 kart çek, 200 Keyflare kazan."
  },
  State_50375_Name = {
    Text = "<MysterybuffKeywords:Harika Etki>"
  },
  State_50389_Desc = {
    Text = "Tur başında ele bir \"Ryker'ın Şanslı Zarı\" yerleştir."
  },
  State_50389_Name = {
    Text = "Ryker'ın Desteği"
  },
  State_50390_Desc = {
    Text = "Tur başında, [StateArg1] Güç kazanırsın."
  },
  State_50390_Name = {
    Text = "Seçkin Gazi"
  },
  State_50491_Name = {
    Text = "Krono Sarkaç \"Denge\""
  },
  State_50735_Desc = {
    Text = "İlk kez yenilmek üzereyken, HP’yi yenile ve niyeti \"Parçalayan Ağıt\" olarak değiştir; tek bir hedefe son derece yüksek Hasar ver."
  },
  State_50735_Name = {
    Text = "Beyhude Kararlılık"
  },
  State_50854_Desc = {
    Text = "Savaş başlangıcında [StateArg1] <RetaliateIconKeywords:Sayaç> kazan. Turunun ardından [StateArg2] kalkan kazan; bu Kalkan Üretimi her tur [StateArg3] artar."
  },
  State_50854_Name = {
    Text = "Sağlam Kabuk"
  },
  State_50861_Desc = {
    Text = "Artık Hasar almıyor, \"Milyon Evladın Anası\"nı salıvermeye hazırlanıyor."
  },
  State_50861_Name = {Text = "Türemiş"},
  State_50862_Desc = {
    Text = "Artık Hasar almıyor, \"Üreme\"yi salıvermeye hazırlanıyor."
  },
  State_50862_Name = {Text = "Yarılma"},
  State_50863_Desc = {
    Text = "Artık Hasar almaz, \"Vahşi Ağaç Özsuyu\"nu salmaya hazırlanır."
  },
  State_50863_Name = {
    Text = "Bağışık"
  },
  State_50864_Desc = {
    Text = "Artık Hasar almıyor, \"Ağaç Reçinesi\"ni salıvermeye hazırlanıyor."
  },
  State_50864_Name = {
    Text = "Bağışık"
  },
  State_50891_Desc = {
    Text = "Artık Hasar almaz, \"Çoklu Füzyon\"u salmaya hazırlanır."
  },
  State_50891_Name = {Text = "Yut"},
  State_51016_Desc = {
    Text = "Alınan Zehir Etkisi %1000’e çıkar."
  },
  State_51016_Name = {
    Text = "Kurumuş ve Çürümüş"
  },
  State_51017_Desc = {
    Text = "Alınan Zehir Etkisi %500 olur."
  },
  State_51017_Name = {
    Text = "Kurumuş ve Çürümüş"
  },
  State_51607_Desc = {
    Text = "Tüm Hasara Bağışıklık. Tur başında kaldırılır."
  },
  State_51607_Name = {
    Text = "Hasara Bağışıklık"
  },
  State_51695_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_51695_Name = {
    Text = "Uyanmamış"
  },
  State_51696_Desc = {
    Text = "\"Denizin Havarisi\" Uyandırıldı; Yüceltim’e karşı daha güçlü Direnç kazandı."
  },
  State_51696_Name = {
    Text = "Miryam Uyanışı!"
  },
  State_51696_WeaponDesc = {
    Text = "Bir sonraki turun başında, önceki turda kaybedilen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_51739_Desc = {
    Text = "Tur sonunda rastgele 1 \"Tanrı Diyarı Hayaleti\" kazan. Giderilemez."
  },
  State_51739_Name = {
    Text = "İnancın Sonu"
  },
  State_51740_Desc = {
    Text = "Savaşın başında, ele 1 adet \"Takıntı\" yerleştir."
  },
  State_51740_Name = {
    Text = "Sönmez Bağlılık"
  },
  State_51741_Desc = {
    Text = "Tur başında [Layer] Karakter Kalkanı kazan. Giderilemez."
  },
  State_51741_Name = {
    Text = "Demir Kararlılık"
  },
  State_51742_Desc = {
    Text = "Tur başında [Layer] Dokunaç Hasarı ve Güç kazan. Giderilemez."
  },
  State_51742_Name = {
    Text = "Adanmışlığı Aydınlat"
  },
  State_51743_Desc = {
    Text = "Bu tur, her Dokunaç Saldırısı, Dokunaç Duruşuna göre aşağıdaki etkileri kazanır: Yükselen Dalgalar: Tüm Uyananlar <Energy:[Energy:StateArg1]> Aliemus elde eder; Sakin Deniz: Tüm düşmanlara [StateArg2] <IntoxicationIconKeywords:Zehir> uygula; Azgın Dalgalar: Geçici <TentacleInjurieIconKeywords:Dokunaç Hasarı> +[StateArg3]."
  },
  State_51743_Name = {
    Text = "Deipara'nın Lütfu"
  },
  State_51745_Desc = {
    Text = "Denizin Havarisi 1 kart oynadığında, Dokunaç Sınırını yok sayan [StateArg1] Geçici Dokunaç üretir."
  },
  State_51745_Name = {
    Text = "İlahi Vekâlet"
  },
  State_51745_WeaponDesc = {
    Text = "Denizin Havarisi 1 kart oynadığında, Dokunaç Sınırını yok sayan [StateArg1] Geçici Dokunaç üretir."
  },
  State_51811_Name = {
    Text = "Rehber Yelkenin İyileştirme Etkisi"
  },
  State_51813_Desc = {
    Text = "Tur sonunda, Arithmetica Maliyeti -[Layer]. Bu Etki, kart atılsa bile tetiklenir."
  },
  State_51813_Name = {
    Text = "<PrepareKeypvewordscolour:Hazırlan[Layer]>"
  },
  State_51820_Desc = {
    Text = "\"Doğum\" ek bir etki kazanır: 5 yığında anında 1 \"Suyun Çocuğu\" çağır, en fazla 2 \"Suyun Çocuğu\" olabilir."
  },
  State_51820_Name = {
    Text = "Miryam Uyanışı"
  },
  State_51822_Desc = {
    Text = "Her Yüceliş saldığında 1 yığın \"Gebelik\" kazanırsın. Her Gebelik yığını için [StateArg1] Güç kazan, en fazla 5 yığına kadar."
  },
  State_51822_Name = {
    Text = "Lemurya'nın Son İnişi"
  },
  State_52068_Desc = {
    Text = "Elde bulunan en fazla 3 \"Ayin\" i \"Takıntı\" ya dönüştür; dönüşüm sayısına göre farklı ek etkiler kazan."
  },
  State_52068_Name = {
    Text = "<CardKeyWord:Ayin>"
  },
  State_52087_Desc = {
    Text = "\"Ölümsüz Cennet Kuşu\" diriliş durumunu yeniden ancak [Layer] tur sonra uygulayabilir."
  },
  State_52087_Name = {
    Text = "Diriliş Bekleme Süresi"
  },
  State_52116_Desc = {
    Text = "Tur bitmeden önce, bu Uyandıran, her Taşkınlık kullanımı için [Layer] Hasar alır."
  },
  State_52116_Name = {
    Text = "Yüceltme Kilidi"
  },
  State_52369_Desc = {
    Text = "[DescArg1] Semptom kartı oynadıktan sonra, Tulu’dan \"Kraliyet Otoritesi\" destek kartını kazan: muazzam Hasar ver ve hedefi 1 tur boyunca bayılt."
  },
  State_52369_Name = {
    Text = "Tanrı Diyarı Yeniden İnecek"
  },
  State_53115_Desc = {
    Text = "Bu tur, Miryam'ın bir sonraki tetiklenen \"Ayin\" Etkisi +%50."
  },
  State_53115_Name = {
    Text = "Uçuruma Dua Et"
  },
  State_53144_Desc = {
    Text = "Tur başında <Block:[Block:StateArg1]> Karakter Kalkanı kazan."
  },
  State_53144_Name = {
    Text = "<CardKeyWord:Demir Kararlılık>"
  },
  State_53145_Desc = {
    Text = "Tur başında, <PowerIconKeywords:STR> ve <TentacleInjurieIconKeywords:Tentacle DMG>+[StateArg2]."
  },
  State_53145_Name = {
    Text = "<CardKeyWord:Adanmışlığı Aydınlat>"
  },
  State_53673_Desc = {
    Text = "En fazla 10 Bez Bölünmesi tutabilirsin."
  },
  State_53673_Name = {
    Text = "Bez Bölünme Sınırı"
  },
  State_53674_Desc = {
    Text = "El Sınırı +2. Tur başında Miryam 20 Aliemus kazanır."
  },
  State_53674_Name = {
    Text = "Miryam Deneme"
  },
  State_53755_Desc = {
    Text = "Tüm Uyanışçıların kazandığı <PowerIconKeywords:STR>, kazandığı <RetaliateIconKeywords:Sayaç> ve uygulanan <IntoxicationIconKeywords:Zehir> +[DescArg1]% artar. \"Görkemli Bölümler\" ile kazanılan <PowerIconKeywords:STR> miktarını artır."
  },
  State_53755_Name = {Text = "Korku"},
  State_53756_Desc = {
    Text = "Tüm Uyanışçıların kazandığı Aliemus [DescArg1]% artar. Tüm Komut Kartları Sakla kazanır. Kullanılmayan Arithmetica saklanır. \"Görkemli Bölümler\"in verdiği Aliemus’u artır."
  },
  State_53756_Name = {Text = "Mutluluk"},
  State_53758_Desc = {
    Text = "Tüm Uyanışçıların Final Hasarı [DescArg1]% artar. \"Görkemli Bölümler\" ile kazanılan Kritik Oranı ve Krit. Hasar’ı artır."
  },
  State_53758_Name = {Text = "Öfke"},
  State_53759_Desc = {
    Text = "Tüm Uyanışçıların Karakter Kalkanı kazanımı ve HP Yenilenmesi etkileri ile uygulanan <PowerIconKeywords:STR> azaltma etkisi [DescArg1]% artar. \"Görkemli Bölümler\"in HP Yenilenmesini artır."
  },
  State_53759_Name = {Text = "Keder"},
  State_53772_Name = {
    Text = "Aksesuar Paradoks"
  },
  State_53772_WeaponDesc = {
    Text = "Kullanıcı Yüceltim kullandıktan sonra, müttefikler kullanıcının DEF'inin %100'üne dayalı <RetaliateIconKeywords:Sayaç> kazanır. Ayrıca kullanıcının mevcut <RetaliateIconKeywords:Sayaç>'ını %10 artırır."
  },
  State_53870_Name = {
    Text = "Aksesuar: Oda 36 Yüzüğü"
  },
  State_53870_WeaponDesc = {
    Text = "Kuşananın kartı çekildiğinde, Arithmetica değeri rastgele 0 ile 3 arasında değişir."
  },
  State_53981_Name = {
    Text = "Aksesuar: İlaç Rüyasında Kara Mühür Ayarlaması"
  },
  State_53981_WeaponDesc = {
    Text = "Savaşın başında, Kuşanan'ın kartlarından ek bir seti Çekme Desteğine Karıştır."
  },
  State_54002_Name = {
    Text = "Durum@Aksesuar Rüya Filtre İşareti"
  },
  State_54002_WeaponDesc = {
    Text = "Kullanıcı Yüceltim kullandıktan sonra, müttefikler kullanıcının DEF'inin %100'üne dayalı <RetaliateIconKeywords:Sayaç> kazanır. Ayrıca kullanıcının mevcut <RetaliateIconKeywords:Sayaç>'ını %10 artırır."
  },
  State_54011_Name = {
    Text = "Durum@Aksesuar Rüya Kopya 1 Mevcut"
  },
  State_54011_WeaponDesc = {
    Text = "Kullanıcı Yüceltim kullandıktan sonra, müttefikler kullanıcının DEF'inin %100'üne dayalı <RetaliateIconKeywords:Sayaç> kazanır. Ayrıca kullanıcının mevcut <RetaliateIconKeywords:Sayaç>'ını %10 artırır."
  },
  State_54012_Name = {
    Text = "Durum@Aksesuar Rüya Kopya 2 Mevcut"
  },
  State_54012_WeaponDesc = {
    Text = "Kullanıcı Yüceltim kullandıktan sonra, müttefikler kullanıcının DEF'inin %100'üne dayalı <RetaliateIconKeywords:Sayaç> kazanır. Ayrıca kullanıcının mevcut <RetaliateIconKeywords:Sayaç>'ını %10 artırır."
  },
  State_54013_Desc = {
    Text = "Bu tur Diyar Ustalığı [Layer] artar."
  },
  State_54013_Name = {
    Text = "Geçici Diyar Ustalığı"
  },
  State_54014_Desc = {
    Text = "Diyar Ustalığı [Layer] artar."
  },
  State_54014_Name = {
    Text = "Diyar Ustalığı"
  },
  State_54043_WeaponDesc = {
    Text = "Kuşanan Yüceltme kullandıktan sonra, bu tur boyunca Kalkanı ve İyileştirme Güçlendirmesi ikiye katlanır."
  },
  State_54044_Desc = {
    Text = "İki katı Hasar ver ve ek olarak Döngü·Ramona'nın Gümüş Anahtar Şarjı'na eşit %600 Keyflare kazan, ancak oynadıktan sonra <DepleteIconKeywords:Tükenir>."
  },
  State_54044_Name = {
    Text = "Yarına Övgü"
  },
  State_54045_Desc = {
    Text = "3 Arithmetica elde et."
  },
  State_54045_Name = {
    Text = "Reenkarnasyon Divanı"
  },
  State_54046_Desc = {
    Text = "Tur başında, [Layer] tur boyunca her tur [StateArg1] HP yenile."
  },
  State_54046_Name = {
    Text = "Akıl, Hakikat ve Gerçeklik"
  },
  State_54071_Desc = {
    Text = "Ogier'in Aktif Hasar sayısı +1, [Layer] <plural value=\"[Layer]\" singular=\"turn\" plural=\"turns\"> sürer."
  },
  State_54071_Name = {
    Text = "Yedi Sanat, Sekiz Erdem"
  },
  State_54121_Desc = {
    Text = "\"Kaos Canavarı\"nın verdiği Temel Hasar bu savaşta [Layer]% artar."
  },
  State_54121_Name = {
    Text = "Kaos Canavarı"
  },
  State_54138_Desc = {
    Text = "[Layer] içinde oynanan Sorel’in Komut Kartı iki kez Etki gösterir."
  },
  State_54138_Name = {
    Text = "Hırs Atlıkarıncası"
  },
  State_54384_Desc = {
    Text = "Nymphaea'nın <IntoxicationIconKeywords:Poison> etkisini %50 artır, [Layer] tur sürer."
  },
  State_54384_Name = {
    Text = "Benliğin Geçidi"
  },
  State_54416_Desc = {
    Text = "Aşırı Yüceltme Patlaması açıldığında, Aliemus göstergesi iki kez doldurulabilir. İkinci kez tamamen dolduğunda, beceri Aşırı Yüceltme Patlaması'na yükselir ve güçlü bonus etkiler kazanır. Bunun yerine normal bir Yüceltme serbest bırakılırsa, fazla Aliemus'un %50'si tüketilir."
  },
  State_54416_Name = {
    Text = "<OverLimitUtlSkillKeywords:Aşırı Yüceltme Patlaması>"
  },
  State_54416_WeaponDesc = {
    Text = "Eldeki embriyoları tüket, güçlü bir Yutma etkisini tetikle."
  },
  State_54561_Desc = {
    Text = "Takıma Özel: Kuşananın verdiği Hasarı, Saldırısının <WeaponEffect_Num:[StateArg1]%>'i kadar artırır. Mevcut Diyar \"Caro\" ise, her Yutma etkisi tetiklendiğinde, Kuşananın verdiği Hasarı Saldırısının ek %3'ü kadar daha artırır."
  },
  State_54561_WeaponDesc = {
    Text = "Taşıyıcının verdiği Hasar [DescArg1] puan artar. Mevcut âlem \"Caro\" ise, her Yutma etkisi tetiklendiğinde taşıyıcının verdiği Hasar ayrıca [DescArg2] puan artar."
  },
  State_54568_Name = {
    Text = "Gezegenin Sonuna Dek"
  },
  State_54597_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Düşman Uyandırıcı öldükten sonra [StateArg1] <StrongEffectKeywords:Güçlü> kazanır, onun Arithmetica Maliyeti en yüksek ve <PVPVoidKeywords:Yanılsama> içeren \"Beceri\"yi ele alır."
  },
  State_54597_Name = {
    Text = "Milyon Sevgi Dolu Bakış"
  },
  State_54704_Desc = {
    Text = "'24' numaralı bir sonraki Komut Kartı 3 kez etkisini gösterir."
  },
  State_54704_Name = {
    Text = "Çarpık Leş Âlemi"
  },
  State_54798_Desc = {
    Text = "Tüm Uyananların Ürettiği Kalkan, HP Yenilenmesi ve <PowerIconKeywords:STR> Azaltma etkisi +[StateArg1]%. Görkemli Bölümlerin HP Yenilenmesini artır."
  },
  State_54798_Name = {Text = "\"Keder\""},
  State_54799_Desc = {
    Text = "Tüm Uyananların kazandığı GÜÇ, kazandığı Hasar Verince Karşı Atak Kazanma ve verdiği Zehir +[StateArg1]%. Görkemli Bölümlerin GÜÇ Üretimini artır."
  },
  State_54799_Name = {Text = "\"Korku\""},
  State_54800_Desc = {
    Text = "Tüm Uyanışçıların verdiği Final Hasar [StateArg1]% artar. Görkemli Bölümler ile kazanılan Geçici Kritik Oranı ve Krit. Hasar’ı artır."
  },
  State_54800_Name = {Text = "\"Öfke\""},
  State_55108_Desc = {
    Text = "Tur başında, eldeki \"Yeşil Alevler\" veya \"Yozlaşmış Alevler\"i [Layer] tur süren \"Ölümcül Alevler\"e yükselt."
  },
  State_55108_Name = {
    Text = "Uğursuzluğun İnişi"
  },
  State_55108_WeaponDesc = {
    Text = "Tur başında elde veya Ultra Uzay'da ise güçlenir."
  },
  State_55113_Desc = {
    Text = "Horla, her turda ilk Mezmur kartını oynadıktan sonra 10 Aliemus kazanır."
  },
  State_55113_Name = {
    Text = "Çiçekler ve Şiirin Kavuşması"
  },
  State_55465_Name = {
    Text = "\"Öfke\" Metaforu’ndan [Layer] yığın tüketerek fazladan [DescArg1] kez Hasar ver"
  },
  State_55466_Name = {
    Text = "\"Keder\" Metaforu’ndan [Layer] yığın tüketerek <Heal:[Heal:DescArg1]> HP yenile"
  },
  State_55467_Name = {
    Text = "\"Korku\" metaforundan [Layer] yığın tüketerek fazladan [Power:DescArg1] <PowerIconKeywords:STR> kazan"
  },
  State_55469_Name = {
    Text = "\"Sevinç\" Metaforu’ndan [Layer] yığın tüketerek fazladan <Energy:[Energy:DescArg1]> Aliemus kazan"
  },
  State_55470_Name = {
    Text = "Kafatası Biçen"
  },
  State_55485_Desc = {
    Text = "Casiah tarafından oynanan sonraki [Layer] <plural value=\"[Layer]\" singular=\"kart\" plural=\"kart\">, SLD değerinin %8'i kadar gücünü kazanır."
  },
  State_55485_Name = {
    Text = "Neşeli Kahkaha"
  },
  State_55486_Name = {
    Text = "Ölü Düşler Şehri’nin Aşırı Yüceltme Patlaması, Düş Yemi tüketimini muaf kılar."
  },
  State_55487_Desc = {
    Text = "Erica’nın \"Darbe\" si fazladan 2 kez Hasar verir ve \"Savunma\" sı fazladan 2 kez Kalkan sağlar; [Layer] tur sürer."
  },
  State_55487_Name = {
    Text = "Çoklu Hesaplama"
  },
  State_55489_Name = {
    Text = "Uzay-Zaman Kıvrımı"
  },
  State_55806_Name = {
    Text = "<PoetryKeywords:Sunu>: Tüm düşmanlara olumsuz bir <PVPWonderfulEffectKeywords:Harika Etki> ver ya da tüm müttefiklere olumlu bir <PVPWonderfulEffectKeywords:Harika Etki> ver ya da 1 kart çek ve 1 Arithmetica kazan. Son Sunu 2 kez Etki gösterir."
  },
  State_55807_Name = {
    Text = "1 kart çek, 1 Arithmetica kazan"
  },
  State_55808_Name = {
    Text = "<PoetryKeywords:Sunu>: Tüm müttefiklere olumlu bir <PVPWonderfulEffectKeywords:Harika Etki> ver ya da 1 kart çek ve 1 Arithmetica kazan. Son Sunu 2 kez Etki gösterir."
  },
  State_55809_Name = {
    Text = "Tüm düşmanlara olumsuz <PVPWonderfulEffectKeywords:Harika Etki> uygula"
  },
  State_55811_Desc = {
    Text = "Listelenen seçeneklerden birini seçerek Etkiyi tetikle."
  },
  State_55811_Name = {
    Text = "<ComaColour:Seçim>"
  },
  State_55813_Name = {
    Text = "<PoetryKeywords:Sunu>: Tüm düşmanlara olumsuz bir <PVPWonderfulEffectKeywords:Harika Etki> ver ya da 1 kart çek ve 1 Arithmetica kazan. Son Sunu 2 kez Etki gösterir."
  },
  State_55814_Name = {
    Text = "<PoetryKeywords:Sunu>: Tüm düşmanlara olumsuz bir <PVPWonderfulEffectKeywords:Harika Etki> ver ya da tüm müttefiklere olumlu bir <PVPWonderfulEffectKeywords:Harika Etki> ver. Son Sunu 2 kez Etki gösterir."
  },
  State_55816_Name = {
    Text = "Tüm müttefiklere olumlu <PVPWonderfulEffectKeywords:Harika Etki> uygula"
  },
  State_55824_Desc = {
    Text = "Listelenen seçeneklerden birini seç. Seçtikten sonra seçilen seçeneği kaldır. Hâlâ seçenek kalırsa, bu kartı rakibin eline koy."
  },
  State_55824_Name = {
    Text = "<ComaColour:Sunu>"
  },
  State_55836_Desc = {
    Text = "Tur sonunda, eldeki Horla'nın Komut Kartlarının Arithmetica Maliyeti 1 azaltılır."
  },
  State_55836_Name = {
    Text = "Mürekkebe Bürünmüş Sone"
  },
  State_55839_Desc = {
    Text = "Alındığında diğer tüm yadigârları kaybet. Rastgele 2 Altın Yadigâr kazan."
  },
  State_55866_Desc = {
    Text = "Takıma Özel: Savaşın başında, Kuşananın 1 Komut Kartını çek ve Arithmetica Maliyetini 1 azaltma şansın <WeaponEffect_Num:[StateArg1]%> olsun. Her Direnç tetiklendiğinde, bu Etki bir kez daha yinelenir."
  },
  State_55866_WeaponDesc = {
    Text = "Savaş başında, kullanıcının 1 Komut Kartı çekilir ve Arithmetica Maliyetini 1 azaltmak için <WeaponEffect_Num:[StateArg1]%> ihtimalin olur. Her Ölüm Direnci tetiklendiğinde, bu etki yeniden tetiklenir."
  },
  State_55992_Desc = {
    Text = "Arithmetica yetersiz olduğunda, kartlar işaretlenir ve tüketme durumuna girer."
  },
  State_55992_Name = {Text = "Küller"},
  State_55993_Name = {
    Text = "Köz İşareti"
  },
  State_56018_Desc = {
    Text = "Bu Savaşta Maksimum HP [Layer]% artar."
  },
  State_56018_Name = {
    Text = "Muzus'un Kutsaması: Yaşam"
  },
  State_56020_Desc = {
    Text = "Bu Savaşta Hasar %[Layer] artırılır."
  },
  State_56020_Name = {
    Text = "Muzus'un Kutsaması: Güç"
  },
  State_56030_Desc = {
    Text = "Bu tur, Uyandıranların sağladığı Karakter Kalkanı ve İyileştirme +%[Layer]."
  },
  State_56030_Name = {Text = "Kar"},
  State_56031_Desc = {
    Text = "Bu tur verilen her bir Hasar örneği için, Geçici Kritik Oranı +[Layer]%."
  },
  State_56031_Name = {Text = "Kelebek"},
  State_56034_Desc = {
    Text = "Her \"Metafor\" türü en fazla 3 yığın olabilir. Farklı \"Metaforlar\" Mezmurların farklı etkilerini güçlendirir: \n<D06CardKeyWordnu:Kükreyiş Mezmuru>: Tüm \"Öfke\" Metaforlarını tüketir, her Metafor yığını ek 2 Hasar uygular. \n<D06CardKeyWordai:Ağıt Mezmuru>: Tüm \"Keder\" Metaforlarını tüketir, her Metafor yığını ek HP Yenilenmesi sağlar. \n<D06CardKeyWordxi:Hayali Şiir>: Tüm \"Mutluluk\" Metaforlarını tüketir, her Metafor yığını ek 10 Aliemus verir. \n<D06CardKeyWordju:Esrarengiz Şiir>: Tüm \"Korku\" Metaforlarını tüketir, her Metafor yığını ek <PowerIconKeywords:GÜÇ> verir."
  },
  State_56034_Name = {Text = "Metafor"},
  State_56208_Desc = {
    Text = "Yağmurun Ağıtı: <Heal:[DescArg1]> Can yenile.\nRüzgârın İlahisi: [DescArg2] <PowerIconKeywords:Güç> kazan.\nÇiçek İlahisi: Tüm Uyandırıcılara <Energy:10> Aliemus ver.\nAy İlahisi: Bu tur Kritik Oranı +%30."
  },
  State_56208_Name = {
    Text = "Şiir Sayfası"
  },
  State_56330_Desc = {
    Text = "[DescArg1] Karakter Kalkanı kazan. Bu tur 3 Yüceltme eylemi gerçekleştirildiyse, bu kart 1 kez daha etkinleşir."
  },
  State_56330_Name = {
    Text = "İleri İmgelem"
  },
  State_56331_Desc = {
    Text = "Çekme Destesi veya Atılmış Kart Desteği’nden 1 Komut Kartı seçip eline al, ardından Arithmetica Maliyeti 2 azalır."
  },
  State_56331_Name = {
    Text = "İleri İmgelem"
  },
  State_56332_Desc = {
    Text = "[DescArg1] Geçici <PowerIconKeywords:STR> elde et. Oynandıktan sonra, bu tur verilen her Hasar için Geçici Kritik Oranı +%3."
  },
  State_56332_Name = {
    Text = "İleri İmgelem"
  },
  State_56333_Desc = {
    Text = "Kaybedilen HP’nin %10’unu yenile. Mevcut HP %25’in altındaysa, bu kart bir kez daha etkisini gösterir."
  },
  State_56333_Name = {
    Text = "İleri İmgelem"
  },
  State_56334_Desc = {
    Text = "Sonraki Müfreze iki kez etkinleşir."
  },
  State_56334_Name = {
    Text = "İleri İmgelem"
  },
  State_56335_Desc = {
    Text = "Maksimum Canın %150'si kadar <FixedDamage:Saf Hasar> verir; bu hasar 10× <PowerIconKeywords:STR> bonusundan yararlanır."
  },
  State_56335_Name = {
    Text = "İleri İmgelem"
  },
  State_56336_Desc = {
    Text = "5 Kart Çekme Destesi çek."
  },
  State_56336_Name = {
    Text = "İleri İmgelem"
  },
  State_56337_Desc = {
    Text = "[DescArg1] Geçici <AlertIconKeywords:Alarm> elde et. Kullanımdan sonra, bu tur için kalkan ve iyileştirme [DescArg2]% artar."
  },
  State_56337_Name = {
    Text = "İleri İmgelem"
  },
  State_56338_Desc = {
    Text = "3 Arithmetica elde et."
  },
  State_56338_Name = {
    Text = "İleri İmgelem"
  },
  State_56339_Desc = {
    Text = "Rastgele bir zayıflatmayı dağıt. Bu kart 3 ek kez etkinleşir. Tüketme."
  },
  State_56339_Name = {
    Text = "İleri İmgelem"
  },
  State_56340_Desc = {
    Text = "Tüm düşmanlara 3 tur boyunca <VulnerabilityIconKeywords:Savunmasız> uygula. Bir düşman her öldüğünde, bu kartı desteden ele al."
  },
  State_56340_Name = {
    Text = "İleri İmgelem"
  },
  State_56341_Desc = {
    Text = "Diyar Ustalığı +25, Geçici Diyar Ustalığı +125."
  },
  State_56341_Name = {
    Text = "İleri İmgelem"
  },
  State_56342_Desc = {
    Text = "Tüm Uyandırıcılar 15 Aliemus kazanır."
  },
  State_56342_Name = {
    Text = "İleri İmgelem"
  },
  State_56343_Desc = {
    Text = "Tüm düşmanlara 3 tur boyunca <WeaknessIconKeywords:Zayıflık> uygula, bu karttan 1 kopyayı Atılmış Kart Destesine yerleştir ve <DepleteIconKeywords:Tüketme>, <NothingnessIconKeywords:Uçucu> ekle."
  },
  State_56343_Name = {
    Text = "İleri İmgelem"
  },
  State_56372_Desc = {
    Text = "Öldüğünde, edindiğin son zayıflatıcı etkiyi temizle."
  },
  State_56372_Name = {
    Text = "Çiçekler ve Şiir"
  },
  State_56400_Desc = {
    Text = "\"Darbe\"den sonra, bu Uyandırma'nın Elde bulunan Becerilerini sırayla diğer Becerilere dönüştür: [ShowIfState:, <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]."
  },
  State_56400_Name = {
    Text = "Geçmişin Çiçekleri ve Şiirleri"
  },
  State_56402_Desc = {
    Text = "<D06CardKeyWordnu:\"Öfke\"> metaforuna sahip [DescArg2] yığın: \"Kükreyiş Mezmuru\" Sıçrama tetikler ve ek Hasar verir.\n<D06CardKeyWordai:\"Keder\"> metaforuna sahip [DescArg3] yığın: \"Ağıt Mezmuru\" Sıçrama tetikler ve ek Can yeniler.\n<D06CardKeyWordxi:\"Mutluluk\"> metaforuna sahip [DescArg1] yığın: \"Hayali Şiir\" Sıçrama tetikler ve seçilen Uyandırıcıya ek Aliemus verir.\n<D06CardKeyWordju:\"Korku\"> metaforuna sahip [DescArg4] yığın: \"Esrarengiz Şiir\" Sıçrama tetikler ve ek GÜÇ verir."
  },
  State_56402_Name = {Text = "Metafor"},
  State_57166_Desc = {
    Text = "Uyandıran %25 daha fazla Hasar verir."
  },
  State_57170_Desc = {
    Text = "El Sınırı +2. Tur sonunda, eldeki 1 kartı Sakla ve 3 tur boyunca Arithmetica Maliyeti'ni 1 azalt."
  },
  State_57170_Name = {
    Text = "Kayıp Olanın Işığı"
  },
  State_57316_Desc = {
    Text = "Her tur başında 1 \"Embriyo\" kartını \"Saflığın Varisi\"ne dönüştürür; eğer \"Embriyo\" yoksa <EmbryoFusionIconKeywords:Embriyo Füzyonu> +[Blood:DescArg1] kazanır, Embriyo Füzyonu artış etkisinden etkilenmez. [Layer] tur sürer."
  },
  State_57316_Name = {
    Text = "Kutsal Kalıntının Sürekliliği"
  },
  State_57317_Desc = {
    Text = "Bu Kader Çarkı destede olduğu sürece, becerilerinizde yaklaşan değişimleri görebilirsiniz."
  },
  State_57317_Name = {
    Text = "<PVPFlowerKeywords:Geçmiş Günlerin Çiçekler ve Şiir’i>"
  },
  State_57324_Desc = {
    Text = "Bu Uyanan \"Geçmişin Çiçekleri ve Şiirleri\"ni tetiklerse, bu kart <CardKeyWord:<SkillName1:>>’e dönüşür."
  },
  State_57324_Name = {
    Text = "Geçmişin Çiçekleri ve Şiirleri"
  },
  State_57325_Desc = {
    Text = "Bu Uyanan \"Geçmişin Çiçekleri ve Şiirleri\"ni tetiklerse, bu kart <CardKeyWord:<SkillName2:>>’ye dönüşür."
  },
  State_57325_Name = {
    Text = "Geçmişin Çiçekleri ve Şiirleri"
  },
  State_57326_Desc = {
    Text = "Bu Uyanan \"Geçmişin Çiçekleri ve Şiirleri\"ni tetiklerse, bu kart <CardKeyWord:<SkillName3:>>’e dönüşür."
  },
  State_57326_Name = {
    Text = "Geçmişin Çiçekleri ve Şiirleri"
  },
  State_57335_Name = {
    Text = "Bu kartın Hasarı, ilave olarak [DescArg1] kat Güç artışı kazanır."
  },
  State_57356_Name = {
    Text = "Durum@Uçurum Karşı Saldırı Hesaplaması"
  },
  State_57368_Name = {
    Text = "Durum@Uçurum Karşı Saldırı Sıçraması"
  },
  State_57413_Name = {
    Text = "Her Karakter Kalkanı puanı, bu kartın Hasarını [DescArg1] artırır"
  },
  State_57417_Desc = {
    Text = "Her Ölüm Direnci tetiklendiğinde, %100 oranında karşılık veren Sabit Hasar ver. Bu savaşta Ölüm Direnci her tetiklendiğinde, Sabit Hasar %25 artar."
  },
  State_57417_Name = {
    Text = "Aşk Beşiği"
  },
  State_57566_Name = {
    Text = "Çıkmazda Hayatta Kalma"
  },
  State_57587_Desc = {
    Text = "\"Bez Bölünmesi\" oynandığında 1 kart çek, [Layer] kullanım hakkı kalır."
  },
  State_57587_Name = {
    Text = "Denizanaları, Toplanın!"
  },
  State_57665_Name = {
    Text = "İlahi ananın koruması"
  },
  State_57728_Desc = {
    Text = "Uvhash’in Hasar örnekleri 1 artar."
  },
  State_57728_Name = {
    Text = "Coşan Kanın Armağanı"
  },
  State_57751_Desc = {
    Text = "Takıma Özel: Kuşananın oluşturduğu Kalkan +<WeaponEffect_Num:[StateArg1]%>. Çeteyi serbest bıraktıktan sonra, tüm Uyananlar ek olarak <WeaponEffect_Num:[StateArg2]%> Geçici Kritik Oranı ve Krit. Hasar kazanır, ancak Maks. CP’nin %3’ü kadar bir Kurban verir. Mevcut Âlem \"Aequor\" ise, Çeteyi serbest bırakmak ayrıca Dokunaç Hasarını kuşananın Saldırısının <WeaponEffect_Num:[StateArg3]%>’i kadar artırır."
  },
  State_57751_WeaponDesc = {
    Text = "Kuşananın sebep olduğu Karakter Kalkanı Üretimi etkileri <WeaponEffect_Num:[StateArg1]%> artar. Çete serbest bırakıldıktan sonra, tüm Uyananlar <WeaponEffect_Num:[StateArg2]%> Geçici Kritik Oranı ve Kritik Hasar kazanır, ancak [DescArg1] Kurban alırlar. Mevcut âlem \"Aequor\" ise, bir Çete serbest bırakmak ayrıca Dokunaç Hasarını [DescArg2] artırır."
  },
  State_57753_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında [StateArg1] yığın <PVPSleepKeywords:Kaliteli Uyku> kazan."
  },
  State_57753_Name = {
    Text = "Buzulun Altındaki Uyku"
  },
  State_57766_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Her turdaki ilk \"Yüceltme\"den sonra, Geçici <StrongEffectKeywords:Güçlendirme> +[StateArg1] kazan."
  },
  State_57766_Name = {
    Text = "Çobanın Asası"
  },
  State_57767_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda, <Energy:[Energy:StateArg1]> Aliemus kes ve bir <PVPDerivativeCardKeywords_12:\"Küçük Dilek\"> kazan. Kesilecek yeterli Aliemus yoksa, bunun yerine <Energy:[Energy:StateArg2]> Aliemus kazan."
  },
  State_57767_Name = {
    Text = "Bitmeyen Performans"
  },
  State_57768_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Beceri\" Hasarı +[StateArg1]%. \"Yüceltme\"den sonra kaybedilen HP’nin [StateArg2]%’ini geri kazan."
  },
  State_57768_Name = {
    Text = "Karlar Eridiğinde"
  },
  State_57769_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanan bir Beceri Kartı oynadıktan sonra, kuşananın Beceri Kartlarından 1 kart çek. Bu Etki her tur yalnızca bir kez tetiklenebilir."
  },
  State_57769_Name = {
    Text = "Hakikat Kapısı"
  },
  State_57770_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Yetenek\"in verdiği Hasar, iyileştirme ve Kalkan Etkisi [StateArg1]~[StateArg2]% artar (şu an [Layer] %), <PhantomKeywords:Fantazma>."
  },
  State_57770_Name = {
    Text = "Kader Ruleti"
  },
  State_57814_Name = {
    Text = "Bu işaret mevcut olduğunda, bir Kader Çarkı’nın değiştirildiğini gösterir. Bazı mantıklar tanıma için bu işarete ihtiyaç duyar."
  },
  State_57817_Desc = {
    Text = "Hareketsiz kalır, tur sonunda yığınlar 1 azalır. Yığınlar tükendiğinde, <StrongEffectKeywords:Amplification> +5 alır, dağıtılamaz. Kader Çarkı’nı değiştirmek, Kaliteli Uyku durumunu kaybettirir."
  },
  State_57817_Name = {
    Text = "Kaliteli Uyku"
  },
  State_57854_Desc = {
    Text = "Tur başında, [StateArg1] Kalkan ve [StateArg2] Dokunaç Hasarı kazan, ve [Layer] tur süren 2 Geçici Dokunaç üret."
  },
  State_57854_Name = {
    Text = "Özgürlük Yemini"
  },
  State_57854_WeaponDesc = {
    Text = "Durum@Aequor Leydi Çay & Pasta"
  },
  State_57864_Name = {
    Text = "Güç Artışı Yenileme"
  },
  State_57942_Desc = {
    Text = "Mevcut füzyon oranı [Layer]%. %100’e ulaştığında, düşman zorla bir sonraki evreye girer ve daha güçlü geçiş becerilerini serbest bırakır."
  },
  State_57942_Name = {
    Text = "Füzyon Seviyesi"
  },
  State_57952_Desc = {
    Text = "Güç azaldığında, yalnızca Güç yığınlarının %50’si azaltılır."
  },
  State_57952_Name = {
    Text = "Derin Dalış"
  },
  State_57953_Desc = {
    Text = "Tur sonunda 1 Dokunaç üret. Durum Uyanış gerçekleştiğinde kaldırılır."
  },
  State_57953_Name = {
    Text = "Mest Uykusu"
  },
  State_57955_Desc = {
    Text = "Helot'un HASARI [StateArg1]% artar, [Layer] tur sürer."
  },
  State_57955_Name = {
    Text = "Çıkmazda Hayatta Kalma: Hasar"
  },
  State_57968_Desc = {
    Text = "Juliette’in etkisi altındayken, İkiz Birleşim göstergesi her turun sonunda %10 artar ve Çekme Desteğine 1 adet \"Mutasyon\" kartı karıştırılır."
  },
  State_57968_Name = {
    Text = "\"Juliette'in Şarkısı\""
  },
  State_57970_Name = {
    Text = "İlahi ananın koruması"
  },
  State_57976_Desc = {
    Text = "\"Karanlığın Çocuğu\" Zorla Birleştirme uygular, mevcut Canının 3 katına eşit Sabit Hasar vererek \"Unutulmuş Başlangıç\"ı vurur."
  },
  State_57976_Name = {Text = "Kurban"},
  State_58051_Desc = {
    Text = "Krit. Hasar +[Layer]%."
  },
  State_58051_Name = {
    Text = "Kritik Hasar"
  },
  State_58052_Desc = {
    Text = "Keşif sırasında tüketilen her 1 Kara Mühür için, \"All-In\"in Temel Hasarı %0,5 artar. (Toplam artış: [DescArg1]%)"
  },
  State_58052_Name = {
    Text = "Garantili Kazanç"
  },
  State_58061_Name = {
    Text = "Dürüst İade"
  },
  State_58063_Desc = {
    Text = "Uyandırıcının verdiği Hasar %25 artar ve [Layer] tur sürer."
  },
  State_58063_Name = {
    Text = "Çağları Aşan Bakış"
  },
  State_58144_Desc = {
    Text = "Bu aşamada Krit. Oranı + [Layer]%."
  },
  State_58144_Name = {
    Text = "Kalıcı Kritik Oranı"
  },
  State_58144_WeaponDesc = {
    Text = "Bu aşamada Krit. Oranı + [Layer]%."
  },
  State_58259_Desc = {
    Text = "Takıma Özel: Kuşananın Kritik Oranı <WeaponEffect_Num:[StateArg1]%> artar. Bir düşmanı öldürdüğünde <WeaponEffect_Num:[StateArg2]> Kara Mühür kazan, keşif sırasında en fazla 3 kez tetiklenebilir. 3 tetiklemeden sonra, kuşananın Kritik Oranı keşfin geri kalanında kalıcı olarak <WeaponEffect_Num:[StateArg3]%> artar."
  },
  State_58259_WeaponDesc = {
    Text = "Kullanıcının Krit. Oranı + <WeaponEffect_Num:[StateArg1]%>. Kullanıcı, bir düşmanı öldürdükten sonra <WeaponEffect_Num:[DescArg2]> Kara Mühür kazanır; keşif başına en fazla 3 kez ([DescArg1]/3). 3 tetiklemeden sonra, kullanıcı mevcut keşif için Kalıcı olarak <WeaponEffect_Num:[StateArg3]%> Krit. Oranı kazanır."
  },
  State_58297_Desc = {
    Text = "Ryker bir düşmanı öldürdüğünde, [DescArg3] Kara Mühür kazanır, keşif başına en fazla 5 kez. ([DescArg1]/5)\nSavaş yoluyla 75/150/300 Kara Mühür elde ederek Kalıntı Kapasitesini 1 artırın. Savaş sonunda, kalıntı listesine eklemek için bir \"Kaotik Miras\" seçin. (Şu ana kadar [DescArg2] Kara Mühür elde edildi)"
  },
  State_58297_Name = {
    Text = "Kazanan Hepsini Alır"
  },
  State_58447_Desc = {
    Text = "Aşağıdaki üç kalıntıyı içerir:\n\"Şanslı Rüzgâr Paltosu\": Tüm Uyandırıcıların Kritik Oranını %10 artırır. Tüm Ryker ve zar atışları asla minimum değerle sonuçlanmaz.\n<TentacleInjurieIconKeywords:Yükseltme>: Kritik Oranı artışı %15'e yükselir ve rastgele sonuçların maksimum değeri +1 olur.\n\"Sekizyüzlü Zar\": Her Müfreze etkinleştirildiğinde, elinize 1 \"<C05_yansheng1:Sekizyüzlü Zar>\" eklenir.\n<TentacleInjurieIconKeywords:Yükseltme>: Elinize 1 \"<C05_yansheng2:Parlayan Sekizyüzlü Zar>\" eklenmesine dönüşür.\n\"Kocaağız Düğmesi\": Tur başında ve Ryker veya zarın rastgele etkisi tetiklendiğinde, 50 Keyflare ve %2 Kritik Hasar kazanılır, en fazla %30 Kritik Hasar.\n<TentacleInjurieIconKeywords:Yükseltme>: 100 Keyflare ve %4 Kritik Hasar kazanılmasına dönüşür, en fazla %50 Kritik Hasar."
  },
  State_58447_Name = {
    Text = "<CardKeyWord:Kaosun Mirası>"
  },
  State_58490_Desc = {
    Text = "Tüm Uyuşukluk kaldırıldığında, tüm Uyanışçılar ve Kartlar mühürlenecek ve \"Uyuyan Hükümdar\"ın Niyeti \"Hükümdarın Otoritesi\" olarak ayarlanacaktır."
  },
  State_58490_Name = {Text = "Uyuşukluk"},
  State_58491_Desc = {
    Text = "<Remove 1 layer of \"Drowsiness\" whenever a card is played. At the start of the turn, restore to 12 layers of \"Drowsiness\".:Her kart oynandığında “Uyuşukluk”tan 1 katman kaldır. Tur başında “Uyuşukluk”u yeniden 12 katmana çıkar.>"
  },
  State_58491_Name = {Text = "Öfke"},
  State_58492_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_58492_Name = {
    Text = "Uyanmamış"
  },
  State_58493_Desc = {
    Text = "<Remove 1 layer of \"Drowsiness\" whenever a card is played. At the start of the turn, restore to 12 layers of \"Drowsiness\".:Her kart oynandığında “Uyuşukluk”tan 1 katman kaldır. Tur başında “Uyuşukluk”u yeniden 12 katmana çıkar.>"
  },
  State_58493_Name = {Text = "Öfke"},
  State_58947_Desc = {
    Text = "Bu aşamada Krit. Oranı + [Layer]%."
  },
  State_59078_Name = {
    Text = ", 1 kez kullanılabilir"
  },
  State_59079_Name = {
    Text = ", 2 kez kullanılabilir"
  },
  State_59080_Name = {
    Text = ", 3 kez kullanılabilir"
  },
  State_59117_Desc = {
    Text = "Krit. Hasar +[Layer]%."
  },
  State_59117_Name = {
    Text = "Kritik Hasar"
  },
  State_59160_Desc = {
    Text = "Her yığın, bu Savaşta \"Komut Kartları\" ve \"Taşkınlık\" tarafından verilen tüm Hasar, İyileştirme ve Kalkan Etkilerini %10 artırır ve dağıtılamaz."
  },
  State_59160_Name = {
    Text = "<CardKeyWord:Yoğunlaştırma>"
  },
  State_59161_Desc = {
    Text = "Komut Kartı ve Taşkınlık Hasarı, İyileştirme, Kalkan +[DescArg1]%, dağıtılamaz."
  },
  State_59161_Name = {
    Text = "Güçlendirme"
  },
  State_59169_Desc = {
    Text = "Bu kartın temel Arithmetica Maliyeti, Arithmetica Sınırını aşmayacaktır."
  },
  State_59169_Name = {Text = "Denge"},
  State_59173_Name = {
    Text = "Bu işaret mevcut olduğunda, devam eden çoklu Darbeleri gösterir ve çoklu Darbeler yeniden tetiklenmez."
  },
  State_59208_Desc = {
    Text = "Her yığın, bu Savaşta \"Komut Kartları\" ve \"Taşkınlık\" tarafından verilen tüm Hasar, İyileştirme ve Kalkan Etkilerini %10 azaltır ve dağıtılamaz."
  },
  State_59208_Name = {
    Text = "<WeaknessColour:Güçlendirme▼>"
  },
  State_59209_Desc = {
    Text = "Komut Kartı ve Taşkınlık Hasarı, İyileştirme, Kalkan -[DescArg1]%, dağıtılamaz."
  },
  State_59209_Name = {
    Text = "Güçlendirme▼"
  },
  State_59423_Desc = {
    Text = "Ryker bir düşmanı öldürdüğünde, 5 Kara Mühür kazanır. Ryker'ın sahip olduğu her %1 Mühür Hasadı için, kazanılan miktar %1 artar, keşif başına en fazla 5 etkinleştirme.\nSavaş yoluyla 75/150/300 Kara Mühür elde ederek Kalıntı Kapasitesini 1 artırın. Savaş sonunda, kalıntı listesine eklemek için bir \"Kaotik Miras\" seçin."
  },
  State_59423_Name = {
    Text = "Kazanan Hepsini Alır"
  },
  State_59424_Desc = {
    Text = "Keşif sırasında tüketilen her 1 Kara Mühür için, \"Her Şeyini Ortaya Koy\"un Temel Hasarı %0,5 artar."
  },
  State_59424_Name = {
    Text = "Garantili Kazanç"
  },
  State_59439_Desc = {
    Text = "Bu Durum, Savunmasız çarpanını kullanır ve bağımsız bir çarpan olarak işler."
  },
  State_59439_Name = {
    Text = "Belirli bir Duruma sahipsen iki kat Hasar alırsın."
  },
  State_59519_Name = {
    Text = "Çekme Destesi veya Atılmış Kart Desteği’nden 1 Komut Kartı seç ve eline ekle, Arithmetica Maliyetini 0’a ayarla."
  },
  State_59520_Desc = {
    Text = "Kullanıldığında 2 kart çek; bu kartların Arithmetica Maliyetini, Yakarış edilen kartın Arithmetica Maliyeti kadar azaltır. Savaş başına bir kez etkisini gösterir."
  },
  State_59520_Name = {
    Text = "<WhiteQuality:Lex Nous>"
  },
  State_59521_Name = {
    Text = "Mevcut HP'nin %10'unu kaybet ([DescArg1])"
  },
  State_59522_Desc = {
    Text = "Kullanıldığında, eldeki bu Uyanışçıya ait olmayan tüm kartları at. 5 Komut dışı kart kazan. Savaş başına bir kez etkisini gösterir."
  },
  State_59522_Name = {
    Text = "<WhiteQuality:Lex Volis>"
  },
  State_59525_Name = {
    Text = "Bu Komut Kartının sahibi 50 Aliemus kazanır."
  },
  State_59526_Desc = {
    Text = "Oynandıktan sonra, üzerine <RetainIconKeywords:Sakla> ve <DepleteIconKeywords:Tüketme> eklenmiş 3 Temel Kopya kazan. Savaş başına bir kez etkisini gösterir."
  },
  State_59526_Name = {
    Text = "<WhiteQuality:Lex Genis>"
  },
  State_59534_Name = {
    Text = "Bu işaret mevcut olduğunda, bu kartın Fantazma tetiklemesinin yasak olduğunu gösterir."
  },
  State_59560_Name = {
    Text = "Üç Eon’un Yakarışlarını almış bir kart seç ve eline ekle."
  },
  State_59671_Desc = {
    Text = "Bu tur tüm Uyandıranlar %15 daha fazla Final Hasar verir."
  },
  State_59671_Name = {
    Text = "Süpertelli Cep Saati"
  },
  State_59673_Name = {
    Text = "Küçük müzik kutusu"
  },
  State_59678_Desc = {
    Text = "Alındığında diğer tüm yadigârları kaybet. Rastgele 2 Altın Yadigâr kazan."
  },
  State_59878_Desc = {
    Text = "Tur sonunda, ek olarak 1 yığın \"Kaos\" azalt ve [StateArg1] <PowerIconKeywords:GÜÇ> kazan. Sonradan çağrılan \"N\" klonlarının Can'ı %200 artar ve ölmeleri artık \"N\"nin \"Kaos\" yığınlarını azaltmasına veya <PowerIconKeywords:GÜÇ> kazanmasına neden olmaz."
  },
  State_59878_Name = {
    Text = "Kaosun Gelişi"
  },
  State_59991_Name = {
    Text = ", bu kart oynandığında en fazla 5 yığın <EnergyStorageKeywords:Şarj> tüketir"
  },
  State_59993_Name = {
    Text = "Kaybedilen HP'nin %10'unu geri kazan ([DescArg1])"
  },
  State_60000_Desc = {
    Text = "Aktif Hasar alındığında 1 yığın Geçici <MadnessIconKeywords:Delilik> kazan."
  },
  State_60000_Name = {
    Text = "Öfke Birikimi"
  },
  State_60028_Desc = {
    Text = "Tur başında, rastgele bir kartın Arithmetica Maliyeti 3 olarak ayarlanır. Ölümünde, bu etkiyi kaldır, o tur için katilin kartlarının Arithmetica Maliyetini 1 azalt."
  },
  State_60028_Name = {
    Text = "Sayıklama Kafesi"
  },
  State_60044_Name = {
    Text = "\"[Layer] kullanım sonra tüketilir\""
  },
  State_60083_Desc = {
    Text = "Bu turda alınan hasar -[Layer]%."
  },
  State_60083_Name = {
    Text = "<ReinforceColour:Hisar>"
  },
  State_60083_WeaponDesc = {
    Text = "Verilen tüm Hasarı [DescArg1]% azalt."
  },
  State_60085_Desc = {
    Text = "Savaş başında ve her tur Geçici Kale kazan. HP’n ne kadar yüksekse, o kadar çok yığın kazanırsın; en fazla 50."
  },
  State_60085_Name = {
    Text = "Nihai Pupa Dönüşümü"
  },
  State_60085_WeaponDesc = {
    Text = "Verilen tüm Hasarı [DescArg1]% azalt."
  },
  State_60086_Desc = {
    Text = "Savaş başında ve her tur Geçici Kale kazan. HP’n ne kadar yüksekse, o kadar çok yığın kazanırsın; en fazla 25."
  },
  State_60086_Name = {
    Text = "Pupa Dönüşümü"
  },
  State_60086_WeaponDesc = {
    Text = "Verilen tüm Hasarı [DescArg1]% azalt."
  },
  State_60087_Desc = {
    Text = "Neden olunan Ağır Yıkım etkisi, CP Yenilenmesini [Layer]% azaltır."
  },
  State_60087_Name = {
    Text = "<Rune_14_High:Ağır Yıkım Güçlendirmesi>"
  },
  State_60087_WeaponDesc = {
    Text = "Verilen tüm Hasarı [DescArg1]% azalt."
  },
  State_60088_Desc = {
    Text = "Her yığın, alınan Hasarı %1 azaltır."
  },
  State_60088_Name = {
    Text = "<ReinforcePVEKeywords:Hisar>"
  },
  State_60088_WeaponDesc = {
    Text = "Elde edilen tüm Kalkan %25 azaltılır."
  },
  State_60089_Desc = {
    Text = "Alınan hasar -[Layer]%."
  },
  State_60089_Name = {
    Text = "<ReinforceColour:Hisar>"
  },
  State_60089_WeaponDesc = {
    Text = "Verilen tüm Hasarı [DescArg1]% azalt."
  },
  State_60106_Desc = {
    Text = "Tur başında, elindeki rastgele bir kartın Arithmetica Maliyeti 3 olur ve turun sonunda eski haline döner."
  },
  State_60106_Name = {
    Text = "Sayıklama Kafesi"
  },
  State_60112_Desc = {
    Text = "Bu tur oynanan her Komut Kartı için tüm Uyandırıcılar 1 Aliemus kazanır."
  },
  State_60112_Name = {Text = "Konçerto"},
  State_60115_Desc = {
    Text = "Bu tur Taşkınlık serbest bırakıldıktan sonra, İkiz Füzyon oranı %3 azalır."
  },
  State_60115_Name = {Text = "Ağıt"},
  State_60118_Desc = {
    Text = "Bu turun Hasarı, Zehri ve Sayaç etkisi +[Layer]%."
  },
  State_60118_Name = {Text = "Rapsodi"},
  State_60128_Desc = {
    Text = "Oynamadan önce kartın Arithmetica’sını değiştir"
  },
  State_60128_WeaponDesc = {
    Text = "Oynamadan önce kartın Arithmetica’sını değiştir"
  },
  State_60129_Desc = {
    Text = "Oynayacağın bir sonraki [Layer] Türetilmemiş Komut Kartının Arithmetica Maliyeti -2 olur."
  },
  State_60129_Name = {
    Text = "Alçalan Dizi"
  },
  State_60130_Desc = {
    Text = "Oynayacağın bir sonraki [Layer] Türetilmemiş Komut Kartının Arithmetica Maliyeti +2 olur ve 2 kez etkisini gösterir."
  },
  State_60130_Name = {
    Text = "Yükselen Dizi"
  },
  State_60148_Desc = {
    Text = "Tur sonunda, duruma göre farklı etkiler kazan: Salıverme - 1 yığın Geçici <MadnessIconKeywords:Delilik> elde et. Zaptetme - 50 yığın Geçici <ReinforcePVEKeywords:Hisar> elde et."
  },
  State_60148_Name = {
    Text = "Parametre Uyumu"
  },
  State_60150_Desc = {
    Text = "Her Posse kullandığında “Serbest Bırak” ve “Toplama” kipleri arasında geçiş yap.\nSerbest Bırak’a geçerken [StateArg1] Geçici GÜÇ kazan, Toplama’ya geçerken [StateArg2] Kalkan kazan."
  },
  State_60150_Name = {
    Text = "İşlevsel Algılama"
  },
  State_60151_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_60151_Name = {
    Text = "Uyanmamış"
  },
  State_60154_Desc = {
    Text = "Şu anda Toplama Modunda. Mekanik Silahlanma Kalkan ve Alarm kazanır, niyetler savunmaya odaklanır."
  },
  State_60154_Name = {
    Text = "Geri Çek: Meka"
  },
  State_60155_Desc = {
    Text = "Şu anda Serbest Bırak Modunda. Mekanik Silahlanma fazladan Güç kazanır, Niyet tamamen saldırıya odaklanır."
  },
  State_60155_Name = {
    Text = "Serbest Bırak: Meka"
  },
  State_60167_Desc = {
    Text = "Oynamadan önce kartın Arithmetica’sını değiştir"
  },
  State_60167_WeaponDesc = {
    Text = "Oynamadan önce kartın Arithmetica’sını değiştir"
  },
  State_60184_Desc = {
    Text = "Her kart oynandığında, \"Çelişkinin İkizleri\" Niyetlerini değiştirir."
  },
  State_60184_Name = {Text = "Paradoks"},
  State_60187_Desc = {
    Text = "%50 Zayıflık, Kırılgan ve Ağır Yıkım durumları uygular."
  },
  State_60187_Name = {
    Text = "Son, Başlangıçtır"
  },
  State_60201_Name = {
    Text = "Canavar Geciktirme Gücü"
  },
  State_60263_Desc = {
    Text = "Uygulanan Kırılgan etkisi, Karakter Kalkanı üretimini [Layer]% azaltacak şekilde değiştirilir."
  },
  State_60263_Name = {
    Text = "<Rune_14_High:Kırılganlık Yoğunlaşması>"
  },
  State_60264_Desc = {
    Text = "Verilen Kan Akıtma etkileri, her turun sonunda yalnızca %50 oranında kendiliğinden kaldırılır."
  },
  State_60264_Name = {
    Text = "<Rune_14_High:Hemoliz>"
  },
  State_60265_Desc = {
    Text = "“Kan Akıtma etkisi tur sonunda yalnızca %50 oranında kaldırılır.”"
  },
  State_60265_Name = {
    Text = "<BleedingColour:Hemoliz>"
  },
  State_60279_Name = {
    Text = "Bu kart turun sonunda tüketilecektir."
  },
  State_60284_Desc = {
    Text = "Savaş başında ve her tur Geçici Kale kazan; HP’n ne kadar düşükse, o kadar çok yığın kazanırsın; en fazla 50."
  },
  State_60284_Name = {
    Text = "Kırılmaz Kılıç Dizilişi"
  },
  State_60284_WeaponDesc = {
    Text = "Verilen tüm Hasarı [DescArg1]% azalt."
  },
  State_60297_Desc = {
    Text = "\"@2\" gerçek suretiyle iner, Canı 3 katına çıkar. Her tur, Muhafız’a bir Soru yöneltir ve ele bir \"Tawil’e Cevap\" kartı ekler."
  },
  State_60297_Name = {
    Text = "Hakikat Sorgulaması"
  },
  State_60297_WeaponDesc = {
    Text = "Bir sonraki turun başında, önceki turda kaybedilen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_60298_Desc = {
    Text = "Bu bilinmeyen varlık hâlâ Kara Havuz’un altında pusuda bekliyor. Yakın bir yenilginin eşiğinde tamamen uyanacak ve dirilecek, özgürleşmiş hâliyle dövüşmeye hazır olacak."
  },
  State_60298_Name = {Text = "Uyku Hâli"},
  State_60312_Desc = {
    Text = "Her tur, biriken Hasar HP’nin %10’una ulaştığında, [Layer] yığın Geçici \"Hisar\" kazan."
  },
  State_60312_Name = {
    Text = "Çözünme Sis Kalkanı"
  },
  State_60315_Desc = {
    Text = "Bu tur Yüceltme serbest bırakıldıktan sonra, kaybedilen HP’nin %5’ini geri kazan ([DescArg1])."
  },
  State_60315_Name = {Text = "Ağıt"},
  State_60336_Name = {
    Text = "1 Arithmetica kazan ve 1 kart çek, ancak bu kart Tüketme ile oyundan çıkar."
  },
  State_60339_Name = {
    Text = "Bu tur oynadıktan sonra 1 Arithmetica kazan ve 1 kart çek, ancak bu kart tüketilecektir."
  },
  State_60367_Desc = {
    Text = "Tur başında, rastgele bir kartın Arithmetica Maliyeti 3 olarak ayarlanır. Ölümünde, bu etkiyi kaldır, o tur için katilin kartlarının Arithmetica Maliyetini 1 azalt."
  },
  State_60367_Name = {
    Text = "Sayıklama Kafesi"
  },
  State_60386_Desc = {
    Text = "Etkiler: Kanama (%150 Hasar), Zehir (%75 Hasar), 1 Zayıflık uygula, 1 Savunmasız uygula, Geçici GÜÇ -[DescArg1]."
  },
  State_60386_Name = {
    Text = "<MysterydebuffKeywords:Harika Olumsuz Etki>"
  },
  State_60404_Desc = {
    Text = "Her 1 Hasar aldığında 2 yığın Geçici takviye kazan."
  },
  State_60404_Name = {
    Text = "Son Başkalaşım"
  },
  State_60408_Desc = {
    Text = "CP her azaldığında %33’e düştüğünde ([DescArg1] eksik), bu tur Hasar almaz ve \"Hayalet Isırığı\"nı serbest bırakır."
  },
  State_60408_Name = {
    Text = "Hayalet Yüz Isırığı"
  },
  State_60409_Desc = {
    Text = "CP her azaldığında %66’ya düştüğünde ([DescArg1] eksik), bu tur Hasar almaz ve \"Son Başkalaşım\"ı serbest bırakır."
  },
  State_60409_Name = {
    Text = "Sonun Aynası"
  },
  State_60429_Name = {
    Text = "Durum@Uyandırıcı Hameln@Kadim Melodi"
  },
  State_60430_Desc = {
    Text = "Gerçek Arithmetica Maliyeti gösterilen Niyet ile eşleşen bir kart oynandığında, onu Tüket ve tüm düşmanların Geçici GÜÇ’ünü [DescArg1] azalt."
  },
  State_60430_Name = {Text = "Nota Emri"},
  State_60431_Name = {
    Text = "Durum@Uyandırıcı Hameln@Yükselen Ton"
  },
  State_60432_Name = {
    Text = "Durum@Uyandırıcı Hameln@Ruh Uvertürü"
  },
  State_60433_Name = {
    Text = "Durum@Uyandırıcı Hameln@Alçalan Ton"
  },
  State_60434_Name = {
    Text = "Durum@Uyandırıcı Hameln@Anılar Rondosu"
  },
  State_60435_Name = {
    Text = "Durum@Uyandırıcı Hameln@Ruh Prelüdü Karşı Saldırısı"
  },
  State_60436_Desc = {
    Text = "Engellenmemiş Hasar verdiğinde, Çekme Desteğine [StateArg1] adet \"Yara\" karıştır."
  },
  State_60436_Name = {
    Text = "Ruh Uvertürü"
  },
  State_60438_Name = {
    Text = "Durum@Uyandırıcı Hameln@Yükselen Ton İzleyicisi"
  },
  State_60439_Name = {
    Text = "Durum@Uyandırıcı Hameln@Alçalan Ton İzleyicisi"
  },
  State_60440_Name = {
    Text = "Durum@Uyandırıcı Hameln@Ruh Prelüdü Dinleyicisi"
  },
  State_60441_Name = {
    Text = "Durum@Uyandırıcı Hameln@Anılar Rondosu Dinleyicisi"
  },
  State_60442_Name = {
    Text = "Durum@Uyandırıcı Hameln@Kadim Melodi İzleyicisi"
  },
  State_60486_Desc = {
    Text = "Savaşın başında, tüm Uyandırıcıların Aliemus'u yarıya düşer."
  },
  State_60486_Name = {
    Text = "Ana Tanrıça Özümsemesi"
  },
  State_60487_Desc = {
    Text = "Bu Uyanışçı Henüz Uyanmamış...\nYenilmek üzereyken Uyanış’a geçecek, Maksimum HP’si %200 artacak ve tüm gücüyle savaşacak."
  },
  State_60487_Name = {
    Text = "Uyanmamış"
  },
  State_60490_Desc = {
    Text = "Ölümden sonra tüm Uyandıranlar 30 Aliemus kazanır."
  },
  State_60490_Name = {
    Text = "Yaşama Arzusu"
  },
  State_60491_Desc = {
    Text = "Tüm Uyandıranların neden olduğu Aliemus %50 azalır."
  },
  State_60491_Name = {
    Text = "Ana Ağaç Töreni"
  },
  State_60493_Desc = {
    Text = "Kaybedilen her [Layer] HP için bir Taklit Uyanışı çağır. Alanda hâlihazırda 2 Taklit Uyanışı varsa, tüm Taklit Uyanışlarının Maksimum HP’sini %50 artır."
  },
  State_60493_Name = {
    Text = "Besleyici Ana"
  },
  State_60500_Desc = {
    Text = "Bir Taklit Uyandıran varsa, 50 yığın \"Gizlenme\" kazan."
  },
  State_60500_Name = {
    Text = "Ormanın İçinde Gizli"
  },
  State_60511_Desc = {
    Text = "Her zaman başlangıç elinde görünür."
  },
  State_60511_Name = {
    Text = "<GuyouKeywords:Doğuştan>"
  },
  State_60511_WeaponDesc = {
    Text = "Oynandıktan sonra, kart Atılmış Kart Destesi’ne gitmez ve bu Savaşta tekrar kullanılamaz."
  },
  State_60522_Desc = {
    Text = "Kırılgan ve Ağır Yıkım etkilerini %50’ye çıkarır."
  },
  State_60522_Name = {Text = "Yıkım"},
  State_60523_Desc = {
    Text = "Her yığın, saldırı sayısını 1 artırır. Hasar aldığında 1 yığın kaybedersin ve tur sonunda tüm yığınları yitirirsin."
  },
  State_60523_Name = {Text = "Dua"},
  State_60524_Desc = {
    Text = "Savaşın başında ve her turun başında [Layer] yığın Kale kazan, en fazla 50 yığına kadar."
  },
  State_60524_Name = {
    Text = "Kutsallaştırma"
  },
  State_60524_WeaponDesc = {
    Text = "Verilen tüm Hasarı [DescArg1]% azalt."
  },
  State_60527_Desc = {
    Text = "Oynandığında, Tüketme; düşmanların Geçici GÜÇ’ünü azalt."
  },
  State_60527_Name = {
    Text = "<CardKeyWord:Cennetin Korosu>"
  },
  State_60543_Desc = {
    Text = "Tur sonunda, 10 yığın \"Kan Yemini\" kazan; Hasar aldıktan sonra \"Kan Yemini\" 1 yığın kaldırır."
  },
  State_60543_Name = {
    Text = "Fitil Alevi"
  },
  State_60554_Name = {
    Text = "<HuihuanbKeywords:Rondino>"
  },
  State_60558_Name = {
    Text = "<HuihuanbKeywords:Rondino>"
  },
  State_60562_Desc = {
    Text = "Oynandığında, 2 kez Etki gösterir ve \"Yükselen Ezgi\" ye dönüşür."
  },
  State_60562_Name = {
    Text = "<HuihuanaKeywords:Rondino>"
  },
  State_60564_Desc = {
    Text = "İlk kez yenilmek üzereyken HP yenilenir ve niyet \"Son Evrim\"e dönüşür, Güç ve takviye kazanırsın. İkinci kez yenilmek üzereyken HP yenilenir ve niyet \"Hayalet Isırığı\"na dönüşür, son derece yüksek tekil Hasar verirsin."
  },
  State_60564_Name = {
    Text = "Gölge İblisi"
  },
  State_60567_Desc = {
    Text = "Bu kartı oynayarak Hameln'e 3 Aliemus bahşet."
  },
  State_60567_Name = {
    Text = "<XushiAKeywords:Yükselen Ezgi>"
  },
  State_60568_Name = {
    Text = "<XushiAKeywords:Yükselen Ezgi>"
  },
  State_60569_Name = {
    Text = "<XushiBKeywords:Yükselen Ezgi>"
  },
  State_60570_Desc = {
    Text = "Bu kartı oynayarak Hameln'e 3 Aliemus bahşet."
  },
  State_60570_Name = {
    Text = "<XushiBKeywords:Yükselen Ezgi>"
  },
  State_60571_Name = {
    Text = "<HuihuanaKeywords:Rondino>"
  },
  State_60576_Desc = {
    Text = "Tur başında, rastgele bir kartın Arithmetica Maliyeti 3 olarak ayarlanır. Ölümünde, bu etkiyi kaldır, o tur için katilin kartlarının Arithmetica Maliyetini 1 azalt."
  },
  State_60576_Name = {
    Text = "Sayıklama Kafesi"
  },
  State_60578_Desc = {
    Text = "Ölümcül Hasar aldıktan sonra %50 HP ile canlanır, 1 tur boyunca hasara karşı bağışıklık kazanır, niyeti \"Koza Kırılışı\"na dönüşür."
  },
  State_60578_Name = {
    Text = "Koza Kırılışı"
  },
  State_60592_Desc = {
    Text = "Keşif başlangıcında, destene <DestructionKeywords:İmha Et> özellikli 1 \"Gümüş Anahtar Şafağı\" ekle.\nMüfreze her serbest bırakıldığında, kullanana ait Krit. Hasar +<WeaponEffect_Num:[StateArg1]%>.\nKullanan her Aktif Hasar verdiğinde, bu tur Kritik Oranı +<WeaponEffect_Num:[StateArg3]%> artar ve kullanana ait Gümüş Anahtar Şarjının <WeaponEffect_Num:[StateArg2]%>'i kadar S-Enerjisi kazanırsın, tur başına en fazla 5 kez."
  },
  State_60592_WeaponDesc = {
    Text = "Keşif başlangıcında, destene <DestructionKeywords:İmha Et> özellikli 1 \"Gümüş Anahtar Şafağı\" ekle.\nMüfreze her serbest bırakıldığında, kullanana ait Krit. Hasar +<WeaponEffect_Num:[StateArg1]%>.\nKullanan her Aktif Hasar verdiğinde, Geçici Kritik Oranı +<WeaponEffect_Num:[StateArg3]%> artar ve <WeaponEffect_Num:[DescArg1]> S-Enerjisi kazanırsın, tur başına en fazla 5 kez."
  },
  State_60594_Desc = {
    Text = "Takıma Özel: Tur sonunda, Kuşanan 5 Aliemus kazanır. Kuşanan Yüceliş serbest bıraktıktan sonra, bu tur Kuşanan tarafından oynanan bir sonraki Komut Kartı, Krit. Oranı, Krit. Hasarı, Karakter Kalkanı ve can yenilemesini <WeaponEffect_Num:[StateArg1]%> artırır."
  },
  State_60594_WeaponDesc = {
    Text = "Tur sonunda, kullanıcı 5 Aliemus kazanır. Yüceltim tetiklendikten sonra, kullanıcının bu tur oynadığı bir sonraki Komut Kartı Kritik Oranı, Krit. Hasar, Kalkan ve HP Yenilenmesini <WeaponEffect_Num:[StateArg1]%> artırır."
  },
  State_60898_Desc = {
    Text = "Aktif ve Dokunaç Hasarı alındığında, saldıran Uyandırıcının Taşkınlık ve Komut Kartlarını 1 tur mühürle, 1 <ResentChainsKeywords:Kin Zincirleri> yığınını kaldır."
  },
  State_60898_Name = {
    Text = "<ResentChainsKeywords1:Kin Zincirleri>"
  },
  State_60925_Desc = {
    Text = "Tur sonunda, kaybedilen HP'nin %5'ini geri kazan. Ne zaman bir Semptom ya da Durum Kartı çekersen, tüm müttefikler [Layer] STR kazanır."
  },
  State_60925_Name = {
    Text = "Kan Kandili"
  },
  State_60926_Desc = {
    Text = "Tur sonunda, mevcut HP %50'nin altındaysa, [Layer] Güç ve [StateArg1] yığın Bariyer kazan."
  },
  State_60926_Name = {
    Text = "Fener Sunağı"
  },
  State_60953_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Taşkınlık\"tan önce, tüm düşman hedeflere [StateArg1] yığın <PVPSlowKeywords:Durgunluk> uygula."
  },
  State_60953_Name = {
    Text = "Ebedi Ağıt"
  },
  State_60962_Desc = {
    Text = "Bu Savaşta Maksimum HP [Layer]% artar."
  },
  State_60962_Name = {
    Text = "HP Artışı"
  },
  State_60964_Desc = {
    Text = "Bu Savaşta Hasar %[Layer] artırılır."
  },
  State_60964_Name = {
    Text = "Hasar Artışı"
  },
  State_61038_Name = {
    Text = "Hameln Deneme"
  },
  State_61050_Desc = {
    Text = "\"Melodi\" etkisi tetiklendikten veya \"Uyum Senfonisi\" oynandıktan sonra, Hameln %1 Kritik Oranı ve Krit. Hasar kazanır (Şu ana dek kazanılan: [DescArg1]%). Her 10 tetiklemede, bu savaşta \"Ruh Uvertürü\" ve \"Kökenin Akordu\"nun Hasar isabet sayısı 1 artar, en fazla 3 kez."
  },
  State_61050_Name = {
    Text = "Ay Işığında Rapsodi"
  },
  State_61051_Desc = {
    Text = "\"\"Melodi\"\" Etkisini tetikledikten veya \"Uyum Senfonisi\"ni oynadıktan sonra, Hameln %1 Kritik Oranı ve Krit. Hasar kazanır. Her 10 tetiklemede, bu Savaşta \"Ruh Uvertürü\" ve \"Kökenin Akordu\"nun Hasar örneklerinin sayısı +1 olur, en fazla 3 kez."
  },
  State_61051_Name = {
    Text = "Ay Işığında Rapsodi"
  },
  State_61056_Desc = {
    Text = "İlk turda 100 Geçici GÜÇ kazan."
  },
  State_61056_Name = {Text = "Öfke"},
  State_61084_Desc = {
    Text = "Bu turda [Layer] kart oynandı: Arithmetica Maliyeti 3 veya daha fazlaysa 2 Arithmetica kazan; değilse 2 kart çek."
  },
  State_61084_Name = {
    Text = "Dördüncü Senfoni"
  },
  State_61085_Desc = {
    Text = "Arithmetica Maliyeti -2, 2 kez Etki gösterir, ardından \"Yükselen Ezgi\" ye dönüşür."
  },
  State_61085_Name = {
    Text = "<HuihuanbKeywords:Rondino>"
  },
  State_61089_Desc = {
    Text = "Oynanan bir sonraki Komut Kartı iki kez Etki gösterir."
  },
  State_61089_Name = {
    Text = "Orkestra Şefi Batonu"
  },
  State_61145_Name = {
    Text = "<BleedingColour:Kan Akıtma>"
  },
  State_61174_Desc = {
    Text = "Karakter Kalkanı elde edilemez."
  },
  State_61174_Name = {
    Text = "Kalıntıların Ağıtı"
  },
  State_61180_Desc = {
    Text = "Bu savaşta Helot: Catena'nın Temel Hasarı [DescArg1]% artırılır."
  },
  State_61180_Name = {
    Text = "İntikam Kılıcı"
  },
  State_61185_Desc = {
    Text = "Düşmanın becerilerini güçlendirir. Düşman, hasar aldığında 1 yığın kaybeder."
  },
  State_61185_Name = {Text = "Kan Yemini"},
  State_62213_Desc = {
    Text = "Zayıflık etkisini, verilen Aktif ve Dokunaç Hasarını [Layer]% azaltacak şekilde değiştirir."
  },
  State_62213_Name = {
    Text = "<Rune_14_High:Zayıflık Yoğunlaşması>"
  },
  State_62309_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında [StateArg1] <StrongEffectKeywords:Güçlü> kazanır. Her Can kaybedildiğinde, mevcut Can [StateArg2]%'nin altındaysa <ReinforceKeywords:Güçlendirilmiş> ve <StrengthenKeywords:Güçlendirme> kazanır."
  },
  State_62309_Name = {
    Text = "Kızıla Batış"
  },
  State_62317_Desc = {
    Text = "Tüm Hasara Bağışıklık. Tur başında kaldırılır."
  },
  State_62317_Name = {
    Text = "Hasar Bağışıklığı"
  },
  State_62336_Desc = {
    Text = "3 kart oynandıktan sonra ([Layer] kart kaldığında), 1 kart çek ve eldeki rastgele 1 Komut Kartı’nı dondur."
  },
  State_62336_Name = {
    Text = "Kışın Soğuğu"
  },
  State_62337_Desc = {
    Text = "3 kart oynandıktan sonra ([Layer] kart kaldığında), 1 kart çek ve eldeki rastgele 1 Komut Kartı’nı dondur."
  },
  State_62337_Name = {
    Text = "Kışın Soğuğu"
  },
  State_62338_Desc = {
    Text = "Bu kart oynanamaz, turun sonunda atılmaz ve ilişkili Uyanan’a 5 Aliemus kazandırır. Uyanan Yüceltme’yi serbest bıraktıktan sonra Dondurma kalkar."
  },
  State_62338_Name = {
    Text = "<CardKeyWord:Dondur>"
  },
  State_65332_Desc = {
    Text = "Ölümden sonra tüm Uyandıranlar 30 Aliemus kazanır."
  },
  State_65332_Name = {Text = "Çözünme"},
  State_65342_Desc = {
    Text = "Yenildiğinde, fazladan %100 Maksimum Can ile diriliş yaşa ve \"Kemiklere İşleyen Ayaz\"ı serbest bırak."
  },
  State_65342_Name = {Text = "Sessizlik"},
  State_65346_Desc = {
    Text = "Ölüm anında eldeki 2 Komut Kartını dondur."
  },
  State_65346_Name = {
    Text = "Ayaz Düşüşü"
  },
  State_65358_Desc = {
    Text = "Takıma Özel: Kuşananın Temel Hasarı <WeaponEffect_Num:[StateArg1]%> artar. Yücelişten önce, Geçici el boyutu +1, 1 Komut Kartı çek. \"Caro\" diyarında, Yutma tetiklemek Geçici olarak Krit. Hasarı <WeaponEffect_Num:[StateArg1]%> artırır, tur başına bir kez."
  },
  State_65358_WeaponDesc = {
    Text = "Kuşananın Temel Hasarı <WeaponEffect_Num:[StateArg1]%> artar. Yüceltme serbest bırakılmadan önce, kuşananın geçici el sınırı 1 artar ve kuşananın bir Komut Kartı çekilir. Mevcut âlem \"Caro\" ise, kuşanan Yutma tetiklediğinde Geçici Kritik Hasarı <WeaponEffect_Num:[StateArg1]%> artar; bu etki tur başına bir kez tetiklenir."
  },
  State_65360_Desc = {
    Text = "Takıma Özel: Kuşananın Temel Hasarı <WeaponEffect_Num:[StateArg1]%> artar. Savaşın başında, Kuşanan 25 \"Kar\" yığını kazanır. Bir kart oynamak 2 Aliemus verir ve 1 yığın kaldırır. Tüm \"Kar\" yığınları kaldırıldığında, Kuşanan <WeaponEffect_Num:[StateArg2]%> Kritik Oranı kazanır."
  },
  State_65360_WeaponDesc = {
    Text = "Silah kullananın Temel Hasarı <WeaponEffect_Num:[StateArg1]%> artar. Savaşın başında, taşıyıcı 25 yığın \"Kar\" kazanır; her kart oynadığında 2 Aliemus kazanır ve 1 yığın kaybeder. \"Kar\" tamamen tükendiğinde, taşıyıcı <WeaponEffect_Num:[StateArg2]%> Kritik Oranı kazanır (şu anda [DescArg1] yığın Kar kaldı)."
  },
  State_65362_Desc = {
    Text = "[StateArg1] kez Aktif Hasar aldıktan sonra (kalan: [Layer]), eldeki rastgele 1 Komut Kartını dondur."
  },
  State_65362_Name = {
    Text = "Ayaz Dönüşü"
  },
  State_65463_Name = {
    Text = "5 Kara Mühür puanı kazan"
  },
  State_65490_Desc = {
    Text = "Tur sonunda [StateArg1] Buz Kalkanı ve [StateArg2] Güç kazan."
  },
  State_65490_Name = {
    Text = "Mutlak Sıfır"
  },
  State_65497_Name = {
    Text = "Helot: Catena Deneme"
  },
  State_65553_Desc = {
    Text = "Her turun sonunda, elde kalan kart sayısına göre Güç kazan; kart başına [Layer] al."
  },
  State_65553_Name = {
    Text = "Buz Bıçağı"
  },
  State_65557_Desc = {
    Text = "Ölümcül Hasar alındıktan sonra tüm HP’yi yenile ve Niyet’i \"Derin Uzay Bakışı EX\" e dönüştür; 80 yığın Geçici Kale kazanırken, kendindeki tüm zayıflatmaları ve oyuncudaki tüm güçlendirmeleri kaldır. Tur sonunda, 20 yığın Kale kaldır."
  },
  State_65557_Name = {Text = "Kadim Kaos"},
  State_65558_Desc = {
    Text = "Ölümcül Hasar aldıktan sonra niyet, \"Derin Uzay Bakışı\"na dönüşür ve 80 yığın Kale kazanarak tüm HP’yi yeniler. [DescArg1] kez tetiklenebilir. Tetikler tükendikten sonra, tekrar Ölümcül Hasar alındığında 1 HP korunur ve niyet \"Sonsuz Dünyaların Gözleri\"ne dönüşür. Tur sonunda 20 yığın Kale kaldırılır."
  },
  State_65558_Name = {
    Text = "Yıldız Tozu"
  },
  State_65559_Desc = {
    Text = "Tohuwabohu, Herkes öldükten sonra yeniden belirecek."
  },
  State_65559_Name = {
    Text = "\"Kadim Kırıntılar\""
  },
  State_65564_Name = {
    Text = "\n<D05EX_Relic:Araştırma ekibinin Helot’a dair şüphesi büyüyor ve düşmanlar seni bulmadan önce onları yatıştırmanın bir yolunu bulmalısın.>"
  },
  State_65565_Name = {
    Text = "\n<D05EX_Relic:Takımın şüphesini görmezden gel ve ilerlemeye devam et>"
  },
  State_65566_Name = {
    Text = "\n<D05EX_Relic:Durumu Araştırma Ekibi’ne açıkla>"
  },
  State_65567_Name = {
    Text = "\n<D05EX_Relic:Takım üyelerini daha iyi korumak için Helot’u kısıtla>"
  },
  State_65568_Name = {
    Text = "\n<D05EX_Relic:Helot’u kısıtla ve diğer Uyandırıcıların gücünü kullanarak tüm takım üyelerini koru>"
  },
  State_65585_Desc = {
    Text = "Bu kartı oynadıktan sonra eline geri döner. Yakarış, turun sonuna dek devre dışı kalır."
  },
  State_65585_Name = {
    Text = "<CardKeyWord:Yankı>"
  },
  State_66305_Desc = {
    Text = "Tur sonunda, 1 kat Geçici <ResentChainsKeywords:Kin Zincirleri> kazanır."
  },
  State_66305_Name = {
    Text = "Zamansız Kilit"
  },
  State_66306_Desc = {
    Text = "Aktif ve Dokunaç Hasarı alındığında, saldıran Uyandırıcının Taşkınlık ve Komut Kartlarını 1 tur mühürle, 1 <ResentChainsKeywords:Kin Zincirleri> yığınını kaldır."
  },
  State_66306_Name = {
    Text = "<ResentChainsKeywords1:Kin Zincirleri>"
  },
  State_66308_Desc = {
    Text = "Ölümcül Hasar aldıktan sonra HP’yi 1’e kilitle."
  },
  State_66308_Name = {Text = "Kadim Kaos"},
  State_66311_Desc = {
    Text = "Uyananların Anıları zihninin kıyılarından yükselir, kök salıp büyür. Kaç kez koparsan da, Çözünme onları ne kadar boğarsa boğsun, aslında hiç gitmemişlerdir."
  },
  State_66311_Name = {
    Text = "Parçalanmış Anılar"
  },
  State_66313_Desc = {
    Text = "Her Komut Kartı oynandığında, Uyananın en düşük Arithmetica Maliyetli 1 kartını at."
  },
  State_66313_Name = {
    Text = "Yüce İrade'nin Baskısı"
  },
  State_66314_Desc = {
    Text = "Tüm Hasara karşı Bağışıklık."
  },
  State_66314_Name = {
    Text = "Hasar Bağışıklığı"
  },
  State_66317_Desc = {
    Text = "“Uyandırılmışların anıları zihninin kıyılarından taşarak sende kök salıyor, büyüyor. Kaç kez onları koparsan da, Çözünme kaç kez onları altüst etse de, aslında hiç gitmediler. Tur başında Arithmetica Sınırı’nı 1 puan yenile ve kart sınırını 2 artır.”"
  },
  State_66317_Name = {
    Text = "Hafıza Parçaları"
  },
  State_66325_Desc = {
    Text = "“Uyandırılmışların anıları zihninin kıyılarından taşarak sende kök salıyor, büyüyor. Kaç kez onları koparsan da, Çözünme kaç kez onları altüst etse de, aslında hiç gitmediler. Tur başında Arithmetica Sınırı’nı 1 puan yenile ve kart sınırını 2 artır.”"
  },
  State_66325_Name = {
    Text = "Hafıza Parçaları"
  },
  State_66358_Desc = {
    Text = "Keşifte ilk kez Ölüm Direnci tetiklendiğinde, eline \"<DerivativeCardKeywords_39:Geçmişin Yankıları>\" ekle."
  },
  State_66358_Name = {
    Text = "Var Olmayan Varoluş"
  },
  State_66359_Desc = {
    Text = "Seçebilmen için rastgele seçenekler üretir."
  },
  State_66359_Name = {
    Text = "<FaxianKeywords:Keşfet>"
  },
  State_66360_Desc = {
    Text = "Bu savaşta Krit. Oranı [Layer]% artar."
  },
  State_66360_Name = {
    Text = "Kritik Oranı"
  },
  State_66362_Desc = {
    Text = "Bu savaşta Krit. Hasar [Layer]% artırılır."
  },
  State_66362_Name = {
    Text = "Kritik Hasar"
  },
  State_66409_Name = {
    Text = "Elçi'nin Kararı"
  },
  State_66410_Desc = {
    Text = "\"Tawil’in oynayacağı sonraki [DescArg1] Komut Kartı iki kez Etki gösterir.\""
  },
  State_66410_Name = {
    Text = "Omnifex Yakınsaması"
  },
  State_66414_Desc = {
    Text = "Elde iken, Çekme Desteğinin en üstündeki kart bir Komut Kartı ise, bu kart onun bir kopyası olur."
  },
  State_66414_Name = {
    Text = "Her Şeyi Bilen Hakikat"
  },
  State_66454_Desc = {
    Text = "Beceri Kartı Arithmetica Maliyeti, en fazla 5 yığına kadar \"Gizlenme\" yığınları kadar azalır. Hasar aldıktan veya bir Beceri oynadıktan sonra 1 yığın kaldırılır."
  },
  State_66454_Name = {Text = "Gizlenme"},
  State_66456_Desc = {
    Text = "Beceri Kartı Arithmetica Maliyeti, en fazla 5 yığına kadar \"Gizlenme\" yığınları kadar azalır. Hasar aldıktan veya bir Beceri oynadıktan sonra 1 yığın kaldırılır."
  },
  State_66456_Name = {
    Text = "<YinniColour:Gizlenme>"
  },
  State_66465_Desc = {
    Text = "Yüceltme’yi kullandıktan sonra, yığın sayısına karşılık gelen Hasarı al."
  },
  State_66465_Name = {
    Text = "<PVPfengsuoColour:Yüceltme Kilidi>"
  },
  State_66522_Desc = {
    Text = "Oynadığın her 8. Kart iki kez Etki gösterir."
  },
  State_66522_Name = {
    Text = "Yıldız Demlemesi+"
  },
  State_66553_Desc = {
    Text = "\"Darbe\" ve \"Savunma\" kullandıktan sonra, ilgili Uyananlar 35 Aliemus kazanır. Ancak Arithmetica Maliyetleri +1 artar."
  },
  State_66553_Name = {
    Text = "Kırık Çehre"
  },
  State_66554_Desc = {
    Text = "Alındığında, ele 1 adet <DerivativeCardKeywords_1:\"Kayıp Gölgelerin Yankısı\"> yerleştir."
  },
  State_66554_Name = {
    Text = "Sinyal Aktarıcı"
  },
  State_66555_Desc = {
    Text = "Maksimum Arithmetica 1 artırıldı."
  },
  State_66555_Name = {
    Text = "Can Enjeksiyonu"
  },
  State_66556_Desc = {
    Text = "Aynı Uyanışçının kartları art arda oynandığında, o Uyanışçı 8 Aliemus kazanır."
  },
  State_66556_Name = {
    Text = "Kronometrik Cihaz"
  },
  State_66557_Desc = {
    Text = "Her HP kaybettiğinde [DescArg1] <PowerIconKeywords:STR> kazan; savaş başına en fazla 10 kez yığılır. Tam yığına ulaşıldığında, kaybedilen HP’nin %25’ini geri kazan."
  },
  State_66557_Name = {Text = "Yüce Onur"},
  State_66558_Desc = {
    Text = "Her 3 turda bir, tüm düşmanlara 1 yığın <WeaknessIconKeywords:Zayıflık> ekle. <WeaknessIconKeywords:Zayıflık> taşıyan bir düşmana Hasar verdikten sonra [DescArg1] yığın Geçici <PowerIconKeywords:GÜÇ> kazan; tur başına en fazla 3 kez tetiklenir."
  },
  State_66558_Name = {
    Text = "Kötücül Çocuk"
  },
  State_66559_Desc = {
    Text = "Arithmetica Maliyeti 3 veya daha fazla olan bir kart oynadığında, 1 kart çek ve 1 Arithmetica kazan."
  },
  State_66559_Name = {
    Text = "Yitişin Güzelliği"
  },
  State_66560_Desc = {
    Text = "\"Saldırı\" 2 Arithmetica kazanır ve 1 rastgele kart atar; \"Savunma\" 2 kart çeker ve 1 Arithmetica kaybeder. Tur başına en fazla 3 kez tetiklenebilir."
  },
  State_66560_Name = {
    Text = "Neşeli Plak"
  },
  State_66561_Desc = {
    Text = "Her 3 turda bir, tüm düşmanlara 1 yığın <VulnerabilityIconKeywords:Savunmasız> ekle. Bir <VulnerabilityIconKeywords:Savunmasız> düşmana Hasar verdikten sonra, onlara [DescArg1] Geçici <PowerIconKeywords:STR> kaybettir; tur başına en fazla 3 kez tetiklenir."
  },
  State_66561_Name = {
    Text = "Bahar Ayini"
  },
  State_66562_Desc = {
    Text = "Her 4 turda bir, bu turda tüm düşmanların aldığı Hasarı ikiye katla. Ancak bu turda Yücelt’i serbest bıraktıktan sonra, tüm Uyananları 1 tur boyunca mühürle."
  },
  State_66562_Name = {
    Text = "Yol Yürüyenin Kalıntıları"
  },
  State_66563_Desc = {
    Text = "Tur başında, önceki turda 3’ten fazla kart oynadıysan 2 kart çek."
  },
  State_66563_Name = {
    Text = "Yepyeni Cüzdan"
  },
  State_66564_Desc = {
    Text = "Alındığında, 3 Arithmetica kazan."
  },
  State_66564_Name = {
    Text = "Cep Saati Aynası"
  },
  State_66565_Desc = {
    Text = "Alındığında, tüm düşmanlara 1 tur boyunca <WeaknessIconKeywords:Zayıflık> ve <VulnerabilityIconKeywords:Savunmasız> uygula."
  },
  State_66565_Name = {
    Text = "Renk Değiştiren Deli Gömleği"
  },
  State_66566_Desc = {
    Text = "Tur başında, <DeathResistanceIconKeywords:Ölüm Direnci> %10 artar (bu seviyede her Ölüme Direnci tetiklendiğinde, kazanılan Ölüm Direnci yarıya iner). <DeathResistanceIconKeywords:Ölüm Direnci> %100’ün üzerine çıktığında, <ProficientInRealmsIconKeywords:Diyar Ustalığı> 100 artar."
  },
  State_66566_Name = {
    Text = "Deniz Kızının Gözyaşı"
  },
  State_66703_Desc = {
    Text = "Takıma Özel: Keyflare Sınırı +%100. El Limiti +2, aynı etkiye sahip diğer Kader Çarklarıyla birikmez. Kullanıcının Keyflare Yenilenmesini <WeaponEffect_Num:[StateArg1]%> artırır. Kullanıcı bir kart oynadıktan sonra, bu turda kullanıcının Komut Kartlarının Krit. Oranı, Krit. Hasar, Kalkan Üretimi, Aliemus Üretimi ve KUV Üretimi +<WeaponEffect_Num:[StateArg2]%>, en fazla 5 defaya kadar birikir."
  },
  State_66703_WeaponDesc = {
    Text = "Keyflare Üst Sınırı +%100. El Sınırı +2, aynı etkiye sahip diğer WoD'larla birikmez. Kuşananın Keyflare Yenilenmesini <WeaponEffect_Num:[DescArg2]> artırır. Kuşanan bir kart oynadıktan sonra, bu tur için kuşananın Komut Kartlarının Krit. Oranı ve Krit. Hasarı, Kalkan Üretimi, Aliemus'u ve Gücü <WeaponEffect_Num:[StateArg2]%> artar; en fazla 5 yığılmaya kadar birikir (şu anda [DescArg1] yığın)."
  },
  State_66722_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında ve tur başında, eğer hiçbir <PVPProtectiveKeywords:Bariyer> yoksa, [StateArg1] yığın <PVPProtectiveKeywords:Bariyer> elde et; aksi halde <StrengthenKeywords:Güçlendirme> kazan."
  },
  State_66722_Name = {
    Text = "Görünmez Çark"
  },
  State_66872_Desc = {
    Text = "Tawil’in sağladığı Hasar, Kalkan ve HP Yenilenmesi geçici olarak [StateArg1]% artar, [Layer] tur sürer."
  },
  State_66872_Name = {
    Text = "Sonsuz Milyarlarca Işıltı"
  },
  State_66884_Desc = {
    Text = "Tur sonunda Arithmetica Maliyeti azalır ve kart atılsa bile Etki tetiklenir."
  },
  State_66884_Name = {
    Text = "<PrepareKeypvewords:Hazırlan 1>"
  },
  State_66888_Desc = {
    Text = "Takıma Özel: Posse serbest bırakıldığında, kuşananın Saldırısının <WeaponEffect_Num:[StateArg1]%>’i kadar <PowerIconKeywords:STR> ve Savunmasının <WeaponEffect_Num:[StateArg2]%>’i kadar Karakter Kalkanı kazan. Acil Gnosis Birimi kullanıldığında, tur sonunda tüm Uyananlar <WeaponEffect_Num:[StateArg3]> Aliemus kazanır."
  },
  State_66888_Name = {
    Text = "Gümüş Kalp"
  },
  State_66888_WeaponDesc = {
    Text = "Posse serbest bırakıldıktan sonra, <WeaponEffect_Num:[Power:DescArg1]> <PowerIconKeywords:GÜÇ> ve <WeaponEffect_Num:[Block:DescArg2]> Kalkan elde et. Acil Gnosis Birimi kullanıldıktan sonra, tur sonunda tüm Uyananlar <WeaponEffect_Num:[StateArg3]> Aliemus elde eder."
  },
  State_66893_Desc = {
    Text = "Takıma Özel: Savaşın başlangıcından sonra, Kuşananın Keyflare Yenilenmesinin <WeaponEffect_Num:[StateArg1]%>'i kadar Keyflare kazan. Her Savaşta ilk Çete ilanı bu Etkiyi yineler."
  },
  State_66893_WeaponDesc = {
    Text = "Savaş başladıktan sonra, <WeaponEffect_Num:[DescArg1]> Keyflare elde et. Her savaşta ilk kez bir Posse serbest bıraktıktan sonra, bu Etki yeniden tetiklenir."
  },
  State_66896_WeaponDesc = {
    Text = "Oynamadan önce kartın Arithmetica’sını değiştir"
  },
  State_66900_Desc = {
    Text = "Bu kartın Hasarı, İyileştirmesi ve Karakter Kalkanı Üretimi +[StateArg1]%."
  },
  State_66900_Name = {
    Text = "Gümüş Kalp"
  },
  State_66901_Desc = {
    Text = "Komut Kartı ve Taşkınlık Hasarı, İyileştirme, Kalkan 1 tur boyunca +[DescArg1]%."
  },
  State_66901_Name = {
    Text = "Geçici Güçlendirme"
  },
  State_66902_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Bir müttefik Uyanan öldüğünde, <Block:[Block:StateArg1]> Kalkan kazan, onun en düşük maliyetli \"Beceri\" kartını çek."
  },
  State_66902_Name = {
    Text = "Gümüş Kalp"
  },
  State_66971_Desc = {
    Text = "Can 0’a düştüğünde, Can’ı 1’e ayarla ve artık Hasar almaz."
  },
  State_66971_Name = {
    Text = "Dünya Kopuşu"
  },
  State_67234_Desc = {
    Text = "Tur sonunda bir \"Kavanozda Beyin Klonu\" çağır, [Layer] <plural value=\"[Layer]\" singular=\"tur\" plural=\"tur\"> sürer."
  },
  State_67234_Name = {Text = "Ayrılık"},
  State_67235_Desc = {
    Text = "Öldüğünde tüm Canı yenile, Maksimum Can +%100, \"Ruh Vebası\"nı serbest bırak."
  },
  State_67235_Name = {
    Text = "Uyanmamış"
  },
  State_67237_Desc = {
    Text = "Seviye 10’a ulaşıldığında, niyet \"Yanılsamanın Sonu\"na dönüşür: rakibin maksimum CP’sini 1’e düşürür."
  },
  State_67237_Name = {Text = "Son Perde"},
  State_67238_Desc = {
    Text = "Tur sonunda, 1 \"Son\" yükü kazan. Ölümcül Hasar aldıktan sonra bu durumu kaldır, 1 tur boyunca Hasara bağışık ol, Canının %15'ini yenile ve 10 \"Son\" yükü kazan."
  },
  State_67238_Name = {
    Text = "Ruh Çürümesi"
  },
  State_67240_Desc = {
    Text = "\"\"Bilge\"\" 25 yığın Geçici <ReinforcePVEKeywords:Fortress> ve [Power:StateArg1] Geçici <PowerIconKeywords:STR> kazanır, ardından bu Durumu kaldırır."
  },
  State_67240_Name = {
    Text = "<TuiyanColour:Çıkarım>"
  },
  State_67241_Desc = {
    Text = "Öldüğünde tüm Canı yenile, Maksimum Can +%100, \"Şövalye Gayreti\"ni serbest bırak."
  },
  State_67241_Name = {
    Text = "Uyanmamış"
  },
  State_67242_Desc = {
    Text = "Öldüğünde tüm HP’yi yenile, Maks HP +%100, \"Beden @1yrışması\"nı serbest bırak."
  },
  State_67242_Name = {
    Text = "Uyanmamış"
  },
  State_67243_Desc = {
    Text = "Tur sonunda bir “Kavanozda Beyin Klonu” çağır. “\"Fıçıdaki Beyin\"” klonu “Ruh Özü Ayrışması”nı tetiklediğinde, buna ek olarak kendi STR’inin %5’ini çalar."
  },
  State_67243_Name = {
    Text = "Et De@1şilmiş"
  },
  State_67245_Desc = {
    Text = "Tur sonunda [StateArg1] <PowerIconKeywords:STR> kazan."
  },
  State_67245_Name = {
    Text = "Şövalye Gayreti"
  },
  State_67246_Desc = {
    Text = "Her turda kalkanın ilk kez kırıldığında, Maksimum CP’nin %25’ini kaybet ve [Power:DescArg1] <PowerIconKeywords:Geçici GÜÇ> ile [Layer] yığın Geçici Kale kazan. Bir sonraki turun başında, <Block:[Block:DescArg2]> yığın Karakter Kalkanı geri kazan. \"Şövalye Andı\" her tetiklendiğinde, fazladan bir yığın Karakter Kalkanı kazan."
  },
  State_67246_Name = {
    Text = "Şövalyenin İnancı"
  },
  State_67247_Desc = {
    Text = "Her turun sonunda, aynı anda en fazla 2 olacak şekilde düşmanlar takviye edilir. Bir düşman öldüğünde, \"Çürümüş Beyin\" azami HP’sinin %5’ini kaybeder."
  },
  State_67247_Name = {
    Text = "Uçurum Kapısı"
  },
  State_67252_Desc = {
    Text = "Ölümcül Hasar alırken arka sıraya geç ve 1 Canı koru, ardından tüm sonraki Hasarlara karşı bağışık ol. <PowerIconKeywords:STR> [DescArg1] artar. Kendini Patlatma bu Etkiyi tetiklemez."
  },
  State_67252_Name = {
    Text = "Ruh Özü Ayrışması"
  },
  State_67253_Desc = {
    Text = "[Layer] kart oynandıktan sonra, önde 1 \"Kavanozda Beyin Klonu\"üret; aynı anda en fazla 3 klon var olabilir."
  },
  State_67253_Name = {
    Text = "Kavanozdaki Beyin"
  },
  State_67255_Desc = {
    Text = "Öldüğünde tüm Canı yenile, Maksimum Can +%100, \"Birinci Doktrin\"i serbest bırak."
  },
  State_67255_Name = {
    Text = "Uyanmamış"
  },
  State_67256_Desc = {
    Text = "Çekim aşamasından sonra, elinden rastgele üç Komut Kartı açığa çıkar, birini seçerek ona \"Yankı\" Yakarışı ver ve diğerlerini at."
  },
  State_67256_Name = {
    Text = "Birinci Doktrin"
  },
  State_67257_Desc = {
    Text = "Her turda ilk kez bir Çete serbest bırakıldıktan sonra, tüm Uyananlar 10 Aliemus kazanır, ancak bir Çete serbest bırakmanın maliyeti Kalıcı olarak %10 artar."
  },
  State_67257_Name = {
    Text = "Yavaşça Kopan Bağ"
  },
  State_67258_Desc = {
    Text = "Savaş başında, <Block:[Block:DescArg1]> yığın Kalkan kazan. Kalkan tur sonunda kaybolmaz."
  },
  State_67258_Name = {
    Text = "Şövalyenin Kararlılığı"
  },
  State_67347_Desc = {
    Text = "Elde iken, Çekme Desteği’nin en üstündeki kart bir Komut Kartı ise, bu kart, Arithmetica Maliyeti -1 olan bir kopyasına dönüşür."
  },
  State_67347_Name = {
    Text = "Her Şeyi Bilen Hakikat"
  },
  State_67353_Desc = {
    Text = "Öldüğünde, \"Çürümüş Beyin\" azami HP’sinin %5’ini kaybeder."
  },
  State_67353_Name = {Text = "Erime"},
  State_67358_Desc = {
    Text = "Her 1 Arithmetica tükettiğinde, derhal <Block:[Block:StateArg1]> Kalkan ve 3 birikim Geçici Kale kazan."
  },
  State_67358_Name = {
    Text = "Dengesiz Bariyer"
  },
  State_67414_Desc = {
    Text = "Bakılmaması gereken gözler. Karşı gelinmemesi gereken bir aura. Her şeyin parçaları hâlâ yalnızca parçalardır. Şimdi, yazgılı yıkımla yüzleş..."
  },
  State_67414_Name = {
    Text = "Sayısız Kökene Yüzleş"
  },
  State_67418_Desc = {
    Text = "Kullanıldığında, eldeki bu Uyanışçıya ait olmayan tüm kartları at. 5 Komut dışı kart kazan. Savaş başına bir kez etkisini gösterir."
  },
  State_67418_Name = {
    Text = "<WhiteQuality:İleri Lex Volis>"
  },
  State_67419_Desc = {
    Text = "Kullanıldığında, -1 Arithmetica Maliyetiyle, üzerine <RetainIconKeywords:Elde Tutma> ve <DepleteIconKeywords:Tüketme> eklenmiş 3 Temel Kopya kazan. Savaş başına bir kez etkili olur."
  },
  State_67419_Name = {
    Text = "<WhiteQuality:Gelişmiş Üreme Yasası>"
  },
  State_67420_Desc = {
    Text = "Kullanıldığında, 4 kart çek; bu kartların Arithmetica Maliyeti, Adanmış Kartın Arithmetica Maliyeti kadar azalır. Savaş başına bir kez etkili olur."
  },
  State_67420_Name = {
    Text = "<WhiteQuality:İleri Lex Nous>"
  },
  State_67598_Desc = {
    Text = "Uyanış serbest bırakıldıktan sonra, Uyanan’a karşılık gelen rastgele bir kartı eline ekle. Kart <DepleteIconKeywords:Tüketme> ve <NothingnessIconKeywords:Fleeting> kazanır. Savaş bittikten sonra [DescArg1] Can yenile."
  },
  State_67598_Name = {
    Text = "Doktor Çantası"
  },
  State_67599_Desc = {
    Text = "\"Saldırı\" veya \"Savunma\" olmayan bir Komut Kartı oynadıktan sonra, ilgili Uyandırıcı 15 Aliemus kazanır; her turda en fazla 5 kez tetiklenir. Her turda ilk tetiklenme ayrıca oynanan kartı ele geri döndürür."
  },
  State_67599_Name = {
    Text = "Krono Sarkaç: Yansıtma"
  },
  State_67600_Desc = {
    Text = "Maksimum Arithmetica +4. Deste her sıfırlandığında, Çekme Destesi’ne 4 <DerivativeCardKeywords_4:\"Insight\"> ekle."
  },
  State_67600_Name = {
    Text = "Kutsanmış· Siyah Mum"
  },
  State_67602_Name = {
    Text = "Kullanım Dışı"
  },
  State_67603_Desc = {
    Text = "Zayıflatma etkisi altındaki düşmanlara %20 daha fazla Hasar ver ve onları öldürdüğünde 20 Aliemus kazan."
  },
  State_67603_Name = {
    Text = "Hierofant Asası"
  },
  State_67604_Desc = {
    Text = "Her seferinde, bir önce oynanan Uyandıran'dan farklı bir Uyandıran'a ait bir Komut Kartı oynandığında, o Uyandıran 3 Aliemus kazanır ve 1 yığın \"Canlılık\" biriktirir. 10 yığın biriktiğinde tüm \"Canlılık\" temizlenir ve her Uyandıran için, \"Tüketme\" ye sahip ve Arithmetica Maliyeti 1 azaltılmış rastgele bir Komut Kartı Elde konumuna yerleştirilir. Bu Etki, tur başına en fazla 1 kez tetiklenebilir."
  },
  State_67604_Name = {
    Text = "Krono Sarkaç: Evrim"
  },
  State_67605_Desc = {
    Text = "Bir kalkanın varken, bu Hatıra [DescArg1] Geçici <PowerIconKeywords:STR> sağlar. Karakter Kalkanın Mevcut Canından yüksekse, ek olarak [DescArg2] Geçici <PowerIconKeywords:STR> sağlar."
  },
  State_67605_Name = {
    Text = "Güvercin Tüyü Yelpazesi"
  },
  State_67606_Desc = {
    Text = "Tur başında, her düşman için 1 Arithmetica elde et. Bir düşman Aktif Hasarla öldürüldüğünde, diğer düşmanlara fazla Hasar kadar <BleedingIconKeywords:Bleed> uygula."
  },
  State_67606_Name = {
    Text = "Güruh Şarkısı"
  },
  State_67607_Desc = {
    Text = "5 Yücelik serbest bırakıldıktan sonra, Yücelikleri serbest bırakan Uyandıran 100 Aliemus kazanır."
  },
  State_67607_Name = {
    Text = "Minik Beşik"
  },
  State_67608_Name = {
    Text = "Kullanım Dışı"
  },
  State_67609_Desc = {
    Text = "Uyanış serbest bırakıldıktan sonra mevcut Canın %8’ini kaybet, tüm düşmanlardan [DescArg1] Geçici <PowerIconKeywords:STR> çal. Yalnızca 1 düşman varsa, ek olarak [DescArg2] Geçici <PowerIconKeywords:STR> çal."
  },
  State_67609_Name = {
    Text = "Kehanet Ritüel Kuşu"
  },
  State_67611_Desc = {
    Text = "Her 2 turda bir, tüm düşmanların aldığı Hasarı ikiye katla ve bu tur kullanılan her Taşkınlık için rastgele 1 zayıflatmayı dağıt."
  },
  State_67611_Name = {
    Text = "Kutsanmış· Yol Yürüyücüsünün Kalıntıları"
  },
  State_67612_Desc = {
    Text = "Tüm “Darbe” Krit. Hasar %20 artar. Alındığında, eline 1 adet <DerivativeCardKeywords_40:\"Geçici Güzellik\"> ekle."
  },
  State_67612_Name = {
    Text = "Geçici Güzellik β"
  },
  State_67614_Desc = {
    Text = "Tur başında, tüm Uyananlar 25 Aliemus kazanır. Alındığında, Maksimum HP 1,5 katına çıkar."
  },
  State_67614_Name = {
    Text = "Kutsanmış· Kabus Tezahürü β"
  },
  State_67615_Desc = {
    Text = "6. Komut Kartını oynamak, onu Atılmış Kart Desteğinden eline geri döndürür."
  },
  State_67615_Name = {
    Text = "Alacakaranlıkta"
  },
  State_67616_Name = {
    Text = "Kullanım Dışı"
  },
  State_67618_Desc = {
    Text = "Tur başında, tüm Uyananlar 25 Aliemus kazanır. Alındığında, Maksimum HP 1,5 katına çıkar."
  },
  State_67619_Desc = {
    Text = "El Limiti +5. Alındığında, elini kartlarla doldur. Tur başında, fazladan 1 kart çek. Tur sonunda, eldeki tüm Semptom kartlarını ve Durum Kartlarını at, diğer kartları elinde tut."
  },
  State_67619_Name = {
    Text = "Kutsanmış· Bilinç Kazıması β"
  },
  State_67620_Desc = {
    Text = "Her tur oynanan 3. karttan sonra, Atılmış Kart Destesi’ne 1 <DerivativeCardKeywords_4:\"Insight\"> yerleştir. Her tur oynanan 6. karttan sonra, Atılmış Kart Destesi’nden 1 <DerivativeCardKeywords_4:\"Insight\"> eline al."
  },
  State_67620_Name = {
    Text = "Uygarlığın Işığı"
  },
  State_67621_Desc = {
    Text = "Uyanış serbest bırakıldıktan sonra [DescArg1] Geçici GÜÇ kazan ve tüm düşmanlardan [DescArg1] Geçici <PowerIconKeywords:STR> çal. Yalnızca 1 düşman varsa, ek olarak [DescArg2] Geçici <PowerIconKeywords:STR> çal."
  },
  State_67621_Name = {
    Text = "Kutsanmış· Uğursuzluk Ritüel Kuşu"
  },
  State_67622_Desc = {
    Text = "Son 1 Arithmetica'yı tükettiğinde, 2 Arithmetica kazan. Tur başına en fazla 2 kez tetiklenir."
  },
  State_67622_Name = {
    Text = "Diferansiyel Motor"
  },
  State_67623_Desc = {
    Text = "Alındıktan sonra kalıcı olarak [DescArg1] <PowerIconKeywords:STR> kazan. Hasar verdiğinde [DescArg2] Can iyileş; tur başına en fazla 6 kez tetiklenir."
  },
  State_67623_Name = {
    Text = "Kutsanmış· Taşemren Öpücüğü"
  },
  State_67624_Name = {
    Text = "Kullanım Dışı"
  },
  State_67625_Desc = {
    Text = "Her turda bir Komut Kartı ilk kez Atılmış Kart Destesi’ne girdiğinde, Arithmetica Maliyeti 1 azaltılmış Geçici bir kopyasını Çekme Destesi’ne karıştır."
  },
  State_67625_Name = {
    Text = "Sessiz Gramofon"
  },
  State_67626_Desc = {
    Text = "Maksimum Arithmetica +1. Art arda, Arithmetica Maliyeti bir önceki karttan daha yüksek olan 2 kart oynadığında, 1 Arithmetica kazan."
  },
  State_67626_Name = {
    Text = "Arcana Arşivi"
  },
  State_67628_Name = {
    Text = "Kullanım Dışı"
  },
  State_67630_Name = {
    Text = "Kullanım Dışı"
  },
  State_67631_Desc = {
    Text = "Maksimum Arithmetica +2. Deste her sıfırlandığında, Çekme Desteğine 1 adet <DerivativeCardKeywords_9:\"Sendeleme\"> ekle."
  },
  State_67631_Name = {Text = "Siyah Mum"},
  State_67632_Name = {
    Text = "Kullanım Dışı"
  },
  State_67634_Desc = {
    Text = "Tur sonunda, elde oynanmamış her kart için, tüm Uyananlar 2 Ruh kazanır."
  },
  State_67634_Name = {
    Text = "Dengesiz Terazi"
  },
  State_67635_Desc = {
    Text = "Alındığında, tüm Uyananlar 50 Aliemus kazanır ve Çekme Desteğine 2 adet <DerivativeCardKeywords_1:\"Kayıp Gölgelerin Yankısı\"> karıştır."
  },
  State_67635_Name = {
    Text = "Sinyal Aktarıcı +β"
  },
  State_67636_Desc = {
    Text = "Krit. Hasar +%15. Karakter Kalkanı olan düşmanlara karşı garantili Kritik Vuruş."
  },
  State_67636_Name = {
    Text = "Estetik İlkeleri"
  },
  State_67637_Desc = {
    Text = "Tur başında, 2 kart çek ve 2 Arithmetica kazan. Ne zaman bir Komut Kartı çekersen ya da Coşku yaşarsan, onun Arithmetica Maliyetini rastgele değiştir. (0-4)"
  },
  State_67637_Name = {
    Text = "Düzenbazın Şapkası"
  },
  State_67638_Desc = {
    Text = "Zayıflatma etkisi altındaki düşmanlara %50 daha fazla Hasar ver ve onları öldürdüğünde 100 Aliemus kazan."
  },
  State_67638_Name = {
    Text = "Hierofant Asası +"
  },
  State_67639_Desc = {
    Text = "Kritik Oranı %50 artar, Krit. Hasar %100 artar."
  },
  State_67639_Name = {
    Text = "Kutsanmış· Tekinsiz Kanca"
  },
  State_67640_Desc = {
    Text = "Krit. Oran ve Krit. Hasar +%100. Bu tur verilen her bir Hasar/Dokunaç Hasarı örneği için, tüm Uyananların Krit. Oranı ve Krit. Hasarı %10 azalır, en fazla %50’ye kadar. Zehir ve Sayaç hasarı +%10, en fazla %50’ye kadar."
  },
  State_67640_Name = {
    Text = "Krono Sarkaç: Dalgalanma"
  },
  State_67641_Desc = {
    Text = "Uyanış serbest bırakıldıktan sonra [DescArg1] Geçici <PowerIconKeywords:STR> elde et."
  },
  State_67641_Name = {
    Text = "Demir Kilit"
  },
  State_67643_Desc = {
    Text = "Aktif Hasar verirken [DescArg1] Karakter Kalkanı elde et. Can yenilerken [DescArg2] Geçici <PowerIconKeywords:STR> elde et."
  },
  State_67643_Name = {Text = "Yuvamız"},
  State_67645_Desc = {
    Text = "Krit. Oranı +%10. Her tur ilk Kritik Vuruştan sonra, Krit. Oranını fazladan %20 artır. Her tur 3. Kritik Vuruştan sonra, Krit. Hasarı fazladan %50 artır."
  },
  State_67645_Name = {
    Text = "Şenlik Duası"
  },
  State_67646_Desc = {
    Text = "Tek sayılı turların sonunda, Arithmetica kalmışsa, bir sonraki tur fazladan 2 kart çek; çift sayılı turların sonunda, kart kalmışsa, bir sonraki tur fazladan 2 Arithmetica kazan."
  },
  State_67646_Name = {
    Text = "Güneş-Ay Çarkı"
  },
  State_67647_Desc = {
    Text = "Oynadığın her 5. Komut Kartı iki kez Etki gösterir ve oynandıktan sonra eline geri döner."
  },
  State_67647_Name = {
    Text = "Yıldız Demlemesi+"
  },
  State_67649_Desc = {
    Text = "Canavar Niyetlerini gizle. Her tur 1 Arithmetica kazan ve 1 kart çek."
  },
  State_67649_Name = {
    Text = "Büyüleyici Çan"
  },
  State_67650_Desc = {
    Text = "\"Saldırı\" ve \"Savunma\" fazladan 50 Keyflare kazanır. Arithmetica Maliyeti 2 veya daha fazla olan bir kart her oynandığında, Arithmetica Maliyeti 1 olan bir kart çek ve maliyetini 0’a düşür; tur başına en fazla 3 kez."
  },
  State_67650_Name = {
    Text = "Krono Sarkaç: İkizler"
  },
  State_67651_Desc = {
    Text = "Alındığında, ekibin Diyar Ustalığı temel değerinin %150’sine çıkar. Her tur oynanan 5. Komut Kartından sonra tüm Uyananlar 20 Aliemus kazanır."
  },
  State_67651_Name = {
    Text = "Krono Sarkaç: Kirli"
  },
  State_67653_Desc = {
    Text = "Her tur 2 Yüceliş serbest bıraktıktan sonra, tüm Uyananlar 8 Aliemus kazanır. 3 Yüceliş serbest bırakıldıktan sonra, tüm Uyananlar ek 8 Aliemus daha kazanır."
  },
  State_67653_Name = {
    Text = "Unutulmuşların Kanı"
  },
  State_67654_Name = {
    Text = "Ek olarak [DescArg1] kez etkinleşir"
  },
  State_67656_Desc = {
    Text = "Kritik Oranı %50 artar, kendine 3 tur boyunca <FragileIconKeywords:Kırılgan> uygula."
  },
  State_67656_Name = {
    Text = "Ürkütücü Kanca"
  },
  State_67657_Desc = {
    Text = "Tur başında 1 kart çek. Aynı Arithmetica Maliyetine sahip 2 kartı art arda oynarsan, tur başına en fazla 3 kez olmak üzere 1 ek kart çek."
  },
  State_67657_Name = {
    Text = "Gnosis Aygıtı"
  },
  State_67658_Desc = {
    Text = "Gerçek Arithmetica Maliyeti 3 olan bir kart oynadığında, 1 kart çek ve 2 Arithmetica kazan; gerçek Arithmetica Maliyeti 4 veya daha fazla olan bir kart oynadığında, elindeki diğer kartların Arithmetica Maliyetini 1 azalt."
  },
  State_67658_Name = {
    Text = "Krono Sarkaç: Göz"
  },
  State_67659_Desc = {
    Text = "Tur başında, her düşman için 2 Arithmetica elde et. Bir düşman Aktif Hasarla öldürüldüğünde, fazla Hasarın iki katını diğer düşmanlara <BleedingIconKeywords:Bleed> olarak ver."
  },
  State_67659_Name = {
    Text = "Kitle Şarkısı +"
  },
  State_67660_Desc = {
    Text = "Her üçüncü \"Darbe\" oynandığında, tüm düşmanlara [DescArg1] Hasar ver. İlgili Uyanan 15 Aliemus kazanır."
  },
  State_67660_Name = {
    Text = "Paslanmış Neşter"
  },
  State_67661_Desc = {
    Text = "Her Arithmetica harcandığında, tur başına en fazla 5 kez 1 kart çek. Deste her karıştırıldığında 2 Arithmetica kazan."
  },
  State_67661_Name = {
    Text = "Krono Sarkaç: Uykusuz"
  },
  State_67662_Desc = {
    Text = "Bir Güçlendirme Kartı, Semptom kartı veya Durum Kartı oynadığında, en az Aliemus’a sahip Uyanan 10 Aliemus kazanır."
  },
  State_67662_Name = {
    Text = "Yabancı Pul Albümü"
  },
  State_67665_Desc = {
    Text = "Maksimum Arithmetica 2 artar. \"Saldırı\" veya \"Savunma\" oynadıktan sonra, ilgili Uyanan 5 Aliemus kazanır. Yüceliş serbest bırakıldıktan sonra, ilgili Uyanan'a ait, Tükenme ve Geçici eklenmiş 1 \"Saldırı\" kazan. Posse serbest bırakıldıktan sonra, rastgele Tükenme ve Geçici eklenmiş 1 \"Savunma\" kazan."
  },
  State_67665_Name = {
    Text = "Krono Sarkaç: Kanatlar"
  },
  State_67666_Desc = {
    Text = "Her Hasar verdiğinde [DescArg1] Geçici <PowerIconKeywords:STR> kazan, en fazla 3 kez birikebilir. Tam yığına ulaşıldığında Etki ikiye katlanır."
  },
  State_67666_Name = {
    Text = "Telkâri Akik"
  },
  State_67667_Desc = {
    Text = "Tur bittikten sonra, tüm Uyananlar 5 Aliemus kazanır. Kalan her bir Arithmetica için, tüm Uyananlar fazladan 3 Aliemus kazanır."
  },
  State_67667_Name = {
    Text = "Prototip Batarya"
  },
  State_67668_Desc = {
    Text = "Krit. Hasar %15 artar. \"Darbe\" Krit. Oranı %40 artar."
  },
  State_67668_Name = {
    Text = "Fildişi Karga Gagası"
  },
  State_67669_Name = {
    Text = "Kullanım Dışı"
  },
  State_67670_Desc = {
    Text = "Bir Yücelik serbest bırakıldıktan sonra 1 kart çek. HP %25'in altındaysa, fazladan 1 kart daha çek."
  },
  State_67670_Name = {
    Text = "Bilgi Çarkı"
  },
  State_67671_Desc = {
    Text = "Verilen her Aktif Hasar için [DescArg1] Can yenile ve Hasar hedefine [DescArg2] yığın <BleedingIconKeywords:Bleed> uygula."
  },
  State_67671_Name = {
    Text = "Kutsanmış· Sürü Bilinci"
  },
  State_67672_Desc = {
    Text = "<WeaknessIconKeywords:Weakness> Etkisi %8, <VulnerabilityIconKeywords:Vulnerable> Etkisi %25 artar. <WeaknessIconKeywords:Weakness> veya <VulnerabilityIconKeywords:Vulnerable> uyguladığında, hedeften geçici olarak [DescArg1] <PowerIconKeywords:STR> çal."
  },
  State_67672_Name = {
    Text = "Solmuş Fotoğraf +"
  },
  State_67673_Desc = {
    Text = "Tur başında 1 kart çek."
  },
  State_67673_Name = {
    Text = "Yön Pusulası"
  },
  State_67674_Desc = {
    Text = "Her Komut Kartı oynadığında [DescArg2]% <DeathResistanceIconKeywords:Direnç> kazan (bu Sahnede her 1 Direnç tetiklendiğinde kazanılan Direnç yarıya düşer). <DeathResistanceIconKeywords:Direnç> değerin %100 veya üzerindeyse bunun yerine [DescArg1] puan Geçici <PowerIconKeywords:Güç> kazan."
  },
  State_67674_Name = {
    Text = "Yılanın Kabuğu"
  },
  State_67675_Desc = {
    Text = "Tur sonunda, eğer kalan Arithmetica varsa, bir sonraki tur 2 fazladan kart çek; eğer elde kalan kartlar varsa, bir sonraki tur 2 fazladan Arithmetica kazan."
  },
  State_67675_Name = {
    Text = "Güneş-Ay Çarkı+ +"
  },
  State_67677_Desc = {
    Text = "<WeaknessIconKeywords:Zayıflık> uyguladığında [DescArg1] Karakter Kalkanı kazan; <VulnerabilityIconKeywords:Savunmasız> uyguladığında [DescArg2] geçici <PowerIconKeywords:GÜÇ> kazan. Her iki Etki de 1 tur içinde tetiklenirse, fazladan [DescArg1] Karakter Kalkanı ve [DescArg2] geçici <PowerIconKeywords:GÜÇ> kazan."
  },
  State_67677_Name = {
    Text = "Yaldızlı Çerçeve"
  },
  State_67703_Desc = {
    Text = "Tur başında, önceki turda elde 3'ten fazla kart kaldıysa 2 Arithmetica kazan."
  },
  State_67703_Name = {
    Text = "Mythag Nişanı"
  },
  State_67704_Desc = {
    Text = "Yücelik serbest bırakıldığında, ilgili Uyanan için 10 Aliemus kazan ve [DescArg1] Kalkan elde et."
  },
  State_67704_Name = {
    Text = "İsimsiz Tanrının Peçesi"
  },
  State_67796_Name = {
    Text = "<TongxiaoKeywords:Her Şeyi Bilen Hakikat>: Kullanımdan sonra yenilenir ve <Energy:[StateArg1]> Aliemus kazan."
  },
  State_67841_WeaponDesc = {
    Text = "Oynamadan önce kartın Arithmetica’sını değiştir"
  },
  State_67844_Desc = {
    Text = "Ölümcül Hasar aldıktan sonra tüm HP’yi yenile. @1 kez tetiklenebilir. Şu ana dek [DescArg1] kez tetiklendi."
  },
  State_67844_Name = {Text = "Kadim Kaos"},
  State_67866_Name = {
    Text = "<BleedingColour:Kan Akıtma>"
  },
  State_68298_Desc = {
    Text = "Ölümcül Hasar alındıktan sonra, Niyet’i \"Derin Uzay Bakışı\" na dönüştür ve 80 yığın Geçici Kale kazanarak tüm HP’yi yenile. [DescArg1] kez tetiklenebilir. Tur sonunda, 20 yığın Kale kaldır."
  },
  State_68298_Name = {
    Text = "Yıldız Tozu"
  },
  State_68554_Desc = {
    Text = "Ölümcül Hasar aldıktan sonra tüm HP'yi geri kazan ve diğer tüm düşmanlar öldüğünde bu Durumu kaldır. @1 kez tetiklenebilir, şu ana dek [DescArg1] kez tetiklendi."
  },
  State_68554_Name = {
    Text = "Kadim Kaos Kırıntısı"
  },
  State_68621_Desc = {
    Text = "Savaş başladığında ve her tur sonunda, 2 kat Geçici <ResentChainsKeywords:Kin Zincirleri> kazanır."
  },
  State_68621_Name = {
    Text = "Hilenin Akıntısı"
  },
  State_68622_Desc = {
    Text = "Uyananların STR Üretimi %75 azalır. HP her kaybedildiğinde, [DescArg1] Kalkan ve 1 yığın Geçici Kale kazan."
  },
  State_68622_Name = {
    Text = "Sapkınlık Seli"
  },
  State_68623_Desc = {
    Text = "Her Komut Kartı oynandığında, Uyananın en düşük Arithmetica Maliyetli 1 kartını at."
  },
  State_68623_Name = {
    Text = "Delilik Seli"
  },
  State_68624_Desc = {
    Text = "Tur sonunda, kaybedilen HP'nin %10'unu yenile, kendi üzerindeki zayıflatmaları ve takımının üzerindeki güçlendirmeleri kaldır."
  },
  State_68624_Name = {
    Text = "Doğumun Akıntısı"
  },
  State_68626_Desc = {
    Text = "Tüm Uyananların Temel Aliemus'u %50 artar. Her turun sonunda, tüm Uyananlardan 10 Aliemus eksilt ve Maksimum HP'lerinin %3'ünü geri yükle."
  },
  State_68626_Name = {
    Text = "Korkunun Akıntısı"
  },
  State_68627_Desc = {
    Text = "Savaşın başında 15 yığın \"Geçici Bariyer\" kazan. Tur sonunda 15 yığın \"Geçici Bariyer\" kazan ve 10 rastgele karta \"Geçici Erime\" uygula."
  },
  State_68627_Name = {
    Text = "Kemik Delici Akıntısı"
  },
  State_68632_Desc = {
    Text = "Tüm Komut Kartlarının Arithmetica Maliyeti 1 artar. Her 3 turun sonunda, eline 1 \"Kademeli Taşlaşma\" ekle."
  },
  State_68632_Name = {
    Text = "Ağıtın Akıntısı"
  },
  State_68635_Name = {
    Text = "Saf Gümüş Çekirdek· Korku"
  },
  State_68637_Desc = {
    Text = "CP kaybettiğinde, aynı miktarda yığın kaybet. 0 yığına indiğinde, sana 2 yığın Geçici Bariyer ver, [DescArg1] Kalkan, [DescArg2] Geçici Kale kazan ve [DescArg3] yığın Boyutsal Savunma Duvarı geri kazan."
  },
  State_68637_Name = {
    Text = "Boyutsal Savunma Duvarı"
  },
  State_68638_Name = {
    Text = "Saf Gümüş Çekirdek· Sapkınlık"
  },
  State_68646_Desc = {
    Text = "Temel Hasar ve Karakter Kalkanı değeri %200 artar, ancak kullanım sonrası Tüketme’ye gider."
  },
  State_68646_Name = {
    Text = "<RedQuality1:Geçici Erime>"
  },
  State_68647_Name = {
    Text = "\"Saf Ton Çekirdeği · Delilik\""
  },
  State_68680_Desc = {
    Text = "Kadim Kalıntıları Kaldır"
  },
  State_68680_Name = {
    Text = "Kadim Kalıntıları Kaldır"
  },
  State_68704_Desc = {
    Text = "Tohuwabohu'nun gerçek Varış'ına hâlâ [DescArg1] tur var..."
  },
  State_68704_Name = {Text = "Geliş"},
  State_68829_Desc = {
    Text = "Aktif veya Dokunaç Hasarı alındığında, hasara karşı bağışıklık kazanır ve 1 yığın kaybeder. Tur başında kaldırılır."
  },
  State_68829_Name = {
    Text = "<ParcloseColour:Geçici Bariyer>"
  },
  State_68829_WeaponDesc = {
    Text = "Alınan Hasar -%99. Her Hasar alındığında 1 yığın kaybedilir."
  },
  State_70026_Desc = {
    Text = "Bu kartta \"Tutma\" vardır. Oynandığında tüm Uyananların Krit. Oranını geçici olarak [StateArg1]% artırır ve \"Ölümsüz Hükümranlık\"ı kaldırır. Mevcut Diyar Aequor ise, \"Ölümsüz Hükümranlık\" kaldırıldıktan sonra 1 Arithmetica kazan."
  },
  State_70026_Name = {
    Text = "<OrangeQuality:Ölümsüz Hükümranlık>"
  },
  State_70031_Desc = {
    Text = "Takıma Özel: Savaşın başında, Çekme Desteğindeki Arithmetica tüketimi 3 veya daha fazla olan tüm Komut Kartlarına \"Ölümsüz Hükümranlık\" etkisi ver. Bu kart \"Sakla\" etkisine sahiptir. Oynandıktan sonra, tüm Uyananlar geçici olarak Kritik Oranlarını <WeaponEffect_Num:[StateArg1]%> artırır ve \"Ölümsüz Hükümranlık\" kaldırılır. Mevcut Diyar Aequor ise, \"Ölümsüz Hükümranlık\" kaldırıldıktan sonra 1 Arithmetica kazan."
  },
  State_70031_WeaponDesc = {
    Text = "Savaşın başında, Kuşanan'ın Çekme Desteğindeki Arithmetica Maliyeti 3 veya daha yüksek olan tüm Komut Kartlarına \"Ölümsüz Hükümranlık\" etkisi ver: bu kart \"Sakla\" özelliğine sahiptir ve oynandıktan sonra tüm Uyananlar geçici olarak <WeaponEffect_Num:[StateArg1]%> Krit. Oranı artışı kazanır ve \"Ölümsüz Hükümranlık\" kaldırılır. Mevcut âlem Aequor ise, \"Ölümsüz Hükümranlık\" kaldırıldıktan sonra 1 Arithmetica elde et."
  },
  State_70182_Desc = {
    Text = "Kazanılan tüm Karakter Kalkanları [DescArg1]% azalır."
  },
  State_70182_Name = {
    Text = "<FragileColour:Narin>"
  },
  State_70182_WeaponDesc = {
    Text = "Elde edilen tüm Kalkan %33 azaltılır."
  },
  State_70277_Desc = {
    Text = "Aktif veya Dokunaç Hasarı alındığında, hasarın [StateArg1]%'i Kızıl Ocak'ın iyileşme miktarına dönüştürülür, [Layer] <plural value=\"[Layer]\" singular=\"turn\" plural=\"turns\"> sürer."
  },
  State_70277_Name = {
    Text = "Yaratılış Ayini"
  },
  State_70287_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda, elindeki Kuşananın \"Beceri\" kartlarının Hasarını, İyileştirmesini ve Karakter Kalkanını [StateArg1]% artır."
  },
  State_70287_Name = {
    Text = "Mavi Taş Tahtı"
  },
  State_70288_Desc = {
    Text = "Bu kartın sağladığı Hasar, İyileştirme ve Karakter Kalkanı [DescArg1]% artırılır."
  },
  State_70288_Name = {
    Text = "Mavi Taş Tahtı"
  },
  State_70313_Desc = {
    Text = "Reis Savaşları sırasında, tur başında ve \"Erimenin Bebeği\" Yüceliş tetiklediğinde, 1 yığın \"<Zhongmowuqiling:Finale>\" kazan.\n \"Finale\" en fazla 10 yığına kadar birikebilir ve 10 yığına ulaştığında, eline 1 \"Yanılsamanın Sonu\" kartı yerleştir."
  },
  State_70313_Name = {
    Text = "Yok Oluş Yolu"
  },
  State_70318_Desc = {
    Text = "Tüm düşmanlara [StateArg1] <plural value=\"[StateArg1]\" singular=\"tur\" plural=\"tur\"> <VulnerabilityIconKeywords:Savunmasız> uygula, 1 tur \"Coşku\" durumu kazan: Takım Hasar Güçlendirmesi +[StateArg2]%."
  },
  State_70318_Name = {Text = "Vecd"},
  State_70322_Desc = {
    Text = "Finale’nin 10 yığınına sahip olduğunda, ele 1 \"Yanılsamanın Sonu\" yerleştir."
  },
  State_70322_Name = {Text = "Son Perde"},
  State_70330_Desc = {
    Text = "1 tur \"Coşku\" durumu kazan: Takım Hasar Güçlendirmesi [Arg2]% artar."
  },
  State_70330_Name = {Text = "Vecd"},
  State_70346_Desc = {
    Text = "Tüm düşmanlara [StateArg1] tur boyunca <WeaknessIconKeywords:Weakness> uygula ve bu tur onların <PowerIconKeywords:STR>’ünü [Exhaustion:StateArg3] azalt."
  },
  State_70346_Name = {Text = "Lanet"},
  State_70347_Desc = {
    Text = "Bu tur tüm düşmanların [Exhaustion:StateArg3] <PowerIconKeywords:STR>’ünü azalt."
  },
  State_70347_Name = {Text = "Lanet"},
  State_70374_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: kullanan her tur ilk [StateArg1] kez saldırı aldığında, saldırıyı yapana <PVPEmptinessKeywords:Boşluk> uygular."
  },
  State_70374_Name = {
    Text = "Unutuşun Kuklaları"
  },
  State_70379_Desc = {
    Text = "Saldırıya karşı <PVPEmptinessKeywords:Boşluk> uygular. Saldırıya uğradıktan sonra bu durum kaldırılır."
  },
  State_70379_Name = {
    Text = "Boşluk Karşı Saldırısı"
  },
  State_70443_Desc = {
    Text = "Finale’nin 10 yığınına sahip olduğunda, ele 1 \"Yanılsamanın Sonu\" yerleştir."
  },
  State_70443_Name = {Text = "Son Perde"},
  State_70539_Name = {
    Text = "Ruh Çürümesi"
  },
  State_70589_Desc = {
    Text = "Öncekinden daha düşük Arithmetica Maliyetine sahip 2 kartı art arda oynadığında, tüm düşmanlara 40/80 Zehir uygula. (Tur başına en fazla 5 tetiklenme)"
  },
  State_70590_Desc = {
    Text = "Her turda Embriyo’yu doğrudan ilk kez kullandıktan sonra, bu tur verilen Aktif Hasar, Hasarın %15/30’una eşdeğer Kan Akıtma uygular."
  },
  State_70593_Desc = {
    Text = "Bir Türetilmemiş Komut Kartı oynadıktan sonra, o kartın Arithmetica Maliyetini 2 azalt ve ondan 1/2 Geçici kopyayı Çekme Desteğine karıştır. Bu etkinin bekleme süresi 3 turdur."
  },
  State_70594_Desc = {
    Text = "Tur sonunda, Yükselen Dalgalar duruşundaysan 3 tur bekleme süresiyle 32/64 Dokunaç Hasarı kazan."
  },
  State_70595_Desc = {
    Text = "Savaşın başında, tüm düşmanlara 1280 Zehir uygula; Reis Savaşlarında etki ikiye katlanır."
  },
  State_70598_Desc = {
    Text = "Bir kart her Ultra Uzay’a girdiğinde, eğer bu kart Ultra Uzay’daki diğer kartlardan farklı bir sahibine aitse, eldeki İlham’ın 1/2’sini yerleştir."
  },
  State_70600_Desc = {
    Text = "Tur sonunda 32 HP yenile."
  },
  State_70600_Name = {
    Text = "Kutsanmış kan"
  },
  State_70602_Desc = {
    Text = "Keyflare Uyandırması’ndan sonra 4 kart çek."
  },
  State_70603_Desc = {
    Text = "Keyflare Uyanışı'ndan sonra tüm Uyandırıcılar 10 Aliemus kazanır."
  },
  State_70605_Desc = {
    Text = "Keyflare Uyanış’tan sonra 32 Güç kazan."
  },
  State_70607_Desc = {
    Text = "Öncekinden daha yüksek Arithmetica Maliyeti olan iki kartı art arda oynadığında, 24/48 Sayaç kazan. Bu etki tur başına en fazla 5 kez tetiklenebilir."
  },
  State_70609_Desc = {
    Text = "Keyflare Uyanış’tan sonra 96 Karakter Kalkanı kazan."
  },
  State_70609_Name = {
    Text = "Korunmuş kelebek"
  },
  State_70611_Desc = {
    Text = "Bir Keyflare Uyanışı gerçekleştirdikten sonra, tüm Uyandıranların verdiği Temel Hasarı %25/%50 artır."
  },
  State_70614_Name = {
    Text = "Radyum Çene Kemiği+"
  },
  State_70617_Desc = {
    Text = "Her tur verilen ilk beş Darbe’nin Hasarını %15/%30 artır."
  },
  State_70618_Desc = {
    Text = "Tur başında 1 kart çek."
  },
  State_70619_Desc = {
    Text = "\"Darbe\" %10/%20 Zehir Hasarı verir, tur başına en fazla 320/640 hasar verir."
  },
  State_70620_Desc = {
    Text = "Düşmanlar tarafından saldırıya uğradığında, Maksimum HP'mizin %25/%50'sine eşit Sabit Hasar uygula. Bu Hasar %100/%200 Karşı Atak bonusu kazanır ve her turda her bir düşman için en fazla bir kez tetiklenebilir."
  },
  State_70620_Name = {
    Text = "Ritüel hançeri"
  },
  State_70621_Desc = {
    Text = "Keyflare Uyanışı’ndan sonra 192 Karakter Kalkanı kazan."
  },
  State_70621_Name = {
    Text = "Kelebek Örneği+"
  },
  State_70623_Desc = {
    Text = "Tüm Uyandırıcılar tur başında 10 Aliemus kazanır."
  },
  State_70624_Desc = {
    Text = "Keyflare Uyanışı'ndan sonra tüm Uyandırıcılar 20 Aliemus kazanır."
  },
  State_70628_Desc = {
    Text = "Tur başında 2 kart çek."
  },
  State_70629_Desc = {
    Text = "Her turdaki ilk Yutma sırasında, diğer Uyandıranlar 10/20 Aliemus kazanır."
  },
  State_70635_Desc = {
    Text = "Keyflare Uyanışı’ndan sonra 416 Sayaç kazan."
  },
  State_70636_Desc = {
    Text = "Kızıl Ocak, HP kaybettiğinde, kaybedilen HP miktarının %10/%20’sini verir."
  },
  State_70637_Desc = {
    Text = "Savaşın başında, Dokunaç Sınırı’nı 1/2 artır ve 1/2 Dokunaç kazan."
  },
  State_70641_Desc = {
    Text = "Yok Oluş’tan 160/320 Karakter Kalkanı kazan, bekleme süresi 3 turdur."
  },
  State_70641_Name = {
    Text = "Süpertelli Cep Saati"
  },
  State_70643_Desc = {
    Text = "Tur başında 1 Arithmetica kazan."
  },
  State_70644_Desc = {
    Text = "Taşkınlığı serbest bıraktıktan sonra 16/32 Geçici GÜÇ kazan."
  },
  State_70645_Desc = {
    Text = "Tur başında, 2 Arithmetica kazan."
  },
  State_70646_Name = {
    Text = "Ritüel Hançeri+"
  },
  State_70647_Desc = {
    Text = "Tüm Uyandırıcılar Temel Hasarı %30 artırır."
  },
  State_70648_Desc = {
    Text = "Savaşın başında, tüm düşmanlara 640 Zehir uygula; Reis Savaşlarında Etki ikiye katlanır."
  },
  State_70656_Desc = {
    Text = "\"Vuruş\", Uyanan’ın Saldırısının %60’ına eşit ek 1/2 hasar örneği verir, tur başına en fazla 3 kez tetiklenir."
  },
  State_70657_Desc = {
    Text = "Savaşın başında, 32 Güç kazan."
  },
  State_70660_Desc = {
    Text = "Savaşın başında, 64 Güç kazan."
  },
  State_70661_Desc = {
    Text = "Tur sonunda 64 HP yenile."
  },
  State_70661_Name = {
    Text = "Kutsanmış Kan+"
  },
  State_70662_Desc = {
    Text = "Keyflare Uyanış’tan sonra 2 Arithmetica kazan."
  },
  State_70664_Desc = {
    Text = "Keyflare Uyanış’tan sonra 16 Güç kazan."
  },
  State_70666_Desc = {
    Text = "Savaşın başında 100/200 Diyar Ustalığı kazan. Tüm Uyananların verdiği temel Zehir ve Kalıntıların verdiği Zehir %10/%20 artar."
  },
  State_70667_Desc = {
    Text = "Keyflare Uyanış’tan sonra 4 Arithmetica kazan."
  },
  State_70670_Desc = {
    Text = "Savaş başında 320 Sayaç kazan. Reis Savaşlarında, Etki ikiye katlanır."
  },
  State_70671_Desc = {
    Text = "Ultra Tura girdikten sonra, oynanan ilk Türetilmemiş Komut Kartı ilaveten 1/2 kez daha etkinleşir."
  },
  State_70678_Desc = {
    Text = "Savaş başında 640 Sayaç kazan. Reis Savaşlarında, Etki ikiye katlanır."
  },
  State_70681_Desc = {
    Text = "Tüm Uyandırıcılar Temel Hasarı %60 artırır."
  },
  State_70682_Desc = {
    Text = "Eldeki kart sayısı 2 veya daha az olduğunda, 1/2 kart çek. Bu Etki her tur en fazla 2 kez tetiklenebilir."
  },
  State_70683_Desc = {
    Text = "En az Aliemus’a sahip Uyandıran 50/100 Aliemus kazanır; bekleme süresi 3 turdur."
  },
  State_70684_Desc = {
    Text = "Tur başında, HP %25’in altındaysa 72/144 Geçici GÜÇ kazan."
  },
  State_70685_Desc = {
    Text = "Keyflare Uyanış’tan sonra tüm düşmanlara 416 Zehir uygula."
  },
  State_70686_Desc = {
    Text = "Taşkınlık serbest bırakıldıktan sonra, tüm düşmanlar Maksimum Canınızın %15/%30'u kadar <FixedDamage:Saf Hasar> alır ve %10/%20 Zehir'e maruz kalır."
  },
  State_70687_Name = {
    Text = "Hipersicim Cep Saati+"
  },
  State_70689_Desc = {
    Text = "Keyflare Uyanış’tan sonra tüm düşmanlara 832 Zehir uygula."
  },
  State_70690_Desc = {
    Text = "Savaşın başında 100/200 Diyar Ustalığı kazan. Tüm Uyananların verdiği temel Sayaç ve Kalıntıların verdiği Sayaç %10/%20 artar."
  },
  State_70691_Desc = {
    Text = "Her hasar verişinde 4/8 Geçici GÜÇ kazan; tur başına en fazla 15 kez tetiklenir."
  },
  State_70693_Desc = {
    Text = "Embriyo Füzyonu otomatik kazanım miktarı %100/%200 artar."
  },
  State_70694_Desc = {
    Text = "Keyflare Uyandırması’ndan sonra 2 kart çek."
  },
  State_70695_Desc = {
    Text = "Tur başında tüm Uyandırıcılar 5 Aliemus kazanır."
  },
  State_70696_Desc = {
    Text = "Keyflare Uyanışı’ndan sonra 208 Sayaç kazan."
  },
  State_70698_Desc = {
    Text = "Savunma, tur başına en fazla 3 kez tetiklenmek üzere 200/400 Geçici Sayaç kazanır."
  },
  State_70804_Name = {
    Text = "Ölüm Kalım Süresi Zaman Sınırı"
  },
  State_70805_Desc = {
    Text = "Savaşın başında, tüm düşmanlara 1/2 yığın Zayıflık uygula, Boss’lar üzerindeki etkisi iki katına çıkar. Tüm Uyananlar Temel Hasarlarını %15/%30 artırır."
  },
  State_70806_Name = {
    Text = "Koruyucu El+"
  },
  State_70808_Desc = {
    Text = "Sakin Deniz Duruşu’nda, tüm düşmanlara 64/128 Emme uygula. 3 tur bekleme süresi."
  },
  State_70809_Desc = {
    Text = "Tur başında, HP %25'in altındaysa 100/200 Karakter Kalkanı kazan."
  },
  State_70809_Name = {
    Text = "Koruyucu el"
  },
  State_70810_Desc = {
    Text = "Öfke Dalgası duruşunu kullanarak düşmanlardaki tüm Dokunaç Saldırılarını derhal 1/2 kez etkinleştir; bekleme süresi 3 turdur."
  },
  State_70812_Desc = {
    Text = "Savaşın başında, tüm düşmanlara 1/2 yığın Savunmasız uygula, Boss’lar üzerindeki etkisi iki katına çıkar. Tüm Uyananlar Temel Hasarlarını %15/%30 artırır."
  },
  State_70832_Desc = {
    Text = "Takıma Özel: Savaşın başında, Kuşananın Aliemus Dolumunun <WeaponEffect_Num:[StateArg1]%>’ine eşit Aliemus, Kuşanana takılı olana verilir. Kuşanana takılı olan her savaşta ilk kez Yüceliş serbest bıraktıktan sonra, bu etki bir kez daha yinelenir."
  },
  State_70832_WeaponDesc = {
    Text = "Savaşın başında, taşıyıcı, taşıyıcının Aliemus Dolumu’nun (<WeaponEffect_Num:[DescArg1]>) <WeaponEffect_Num:[StateArg1]%>’ü kadar Yüceltme kazanır. Taşıyıcı her savaşta ilk kez Yüceltme saldığında, bu etki bir kez daha yinelenir."
  },
  State_70835_Desc = {
    Text = "Takıma Özel: Kuşananın Aliemus, Zehir ve HP Yenilenmesi etkileri <WeaponEffect_Num:[StateArg1]%> artar. Kuşanan Yücelişi Serbest Bıraktıktan sonra, tüketilen Aliemus’un <WeaponEffect_Num:[StateArg2]%>’ine eşit Aliemus kazanır."
  },
  State_70835_WeaponDesc = {
    Text = "Silah kullananın Aliemus, Zehir ve HP Yenilenmesi etkileri <WeaponEffect_Num:[StateArg1]%> artar. Silah kullanan Yüceltim serbest bıraktıktan sonra, bu seferki Aliemus Tüketimi ile <WeaponEffect_Num:[StateArg2]> çarpımı kadar Aliemus kazan."
  },
  State_70989_Desc = {
    Text = "Bir tur içinde Yücelt'i 4 kez kullandıktan sonra, 3/6 Arithmetica kazan; bekleme süresi 3 turdur."
  },
  State_71001_Desc = {
    Text = "Bir turda farklı Uyananlara ait 4 Komut Kartı oynadıktan sonra, tüm Uyananlar 20/40 Aliemus kazanır; bekleme süresi 3 turdur."
  },
  State_71153_Desc = {
    Text = "Tur başında Caecus 15 Aliemus kazanır. Caecus bir Karakter Kalkanı kazandığında, kalkan miktarının %50’si kadar HP geri kazanır."
  },
  State_71154_Desc = {
    Text = "Tur başında Aigis 15 Aliemus kazanır. Aigis, Savunmasız düşmanlara Hasar verdiğinde onların Geçici GÜÇ’lerinden 10 çalar; bu etki tur başına en fazla 5 kez tetiklenir."
  },
  State_71155_Desc = {
    Text = "Tur başında Leigh 15 Aliemus kazanır. Her CP kaybettiğinde 8 Güç kazanır; bu, savaş başına en fazla 10 kez birikir. 10 kez biriktiğinde, \"Izdırap ve Haz\"ın Arithmetica Maliyeti 1 olur ve Hasar sayısı 1 artar."
  },
  State_71156_Desc = {
    Text = "Tur başında, Agrippa 15 Aliemus kazanır. \"Gönülsüz Sadaka\" ayrıca bu tur için Agrippa'nın Arithmetica Maliyetini 1 azaltır; bu etki tur başına en fazla bir kez tetiklenir."
  },
  State_71157_Desc = {
    Text = "Tur başında Sanga 15 Aliemus kazanır. Savaş başında, Sanga'nın tüm Komut Kartlarına Sakla ve Hazırlan 1 ver ve 24 Karakter Kalkanı kazan."
  },
  State_71157_Name = {
    Text = "Boyut Görüntüsü · Sanga"
  },
  State_71158_Desc = {
    Text = "Tur başında, Bebek 15 Aliemus kazanır. Savaş başladıktan sonra, Bebeğin \"Eşdeğer Borsa\"sının Arithmetica Maliyetini 0 olarak ayarla. Oynandığında, bir sonraki turda fazladan 2 kart çek."
  },
  State_71159_Desc = {
    Text = "Tur başında, Faros 15 Aliemus kazanır. Verilen her bir Dokunaç Hasarı örneği için, bu savaşta Faros'un nedenlediği Zehir'i %1 artır; en fazla %100'e kadar."
  },
  State_71160_Desc = {
    Text = "Turun başında \"24\" 15 Aliemus kazanır. Eğer \"24\"\"Depresif Kişilik\" hâlindeyse, fazladan 25 Aliemus kazanır; \"Manik Kişilik\" hâlindeyse, \"24\"ün Geçici kritik oranı ve Krit. Hasarı %35 artar."
  },
  State_71161_Desc = {
    Text = "Tur başında Faint 15 Aliemus kazanır. Her Ölüm Direnci tetiklendiğinde, bu keşif boyunca Faint’in neden olduğu Kalkan, Sayaç ve HP Yenilenmesi etkilerini %20 artırır; en fazla 5 defaya kadar."
  },
  State_71162_Desc = {
    Text = "Tur başında, Golyat 15 Aliemus kazanır. Golyat 1 tur içinde 3 kez Hasar verirse, bu savaştaki Golyat kaynaklı Hasar 1x GÜÇ ilave bonusu kazanır; bekleme süresi 3 turdur."
  },
  State_71163_Desc = {
    Text = "Tur başında Helot: Catena 15 Aliemus kazanır. Helot: Catena’nın Aktif Hasarı fazladan %20 Kan Akıtma uygular ve bir düşmanı öldürmek, fazla Hasara eşit miktarda Kan Akıtma’yı diğer düşmanlara yükler."
  },
  State_71164_Desc = {
    Text = "Tur başında, Aurita 15 Aliemus kazanır. \"Bez Bölünmesi\" nin Hasar sayacı 1 artar ve Aurita’nın \"Savunma\" sını oynadıktan sonra, 1 \"Bez Bölünmesi\" ele eklenir."
  },
  State_71166_Desc = {
    Text = "Tur başında Lily 15 Aliemus kazanır. Lily’nin Dayan limit’i %100 artar ve \"Ölümsüz Balçık Üzerinde Çiçek\" veya \"Koruma Darbesi\" kullandığında, her bir \"Dayan\" yığını başına HP’nin %8’ini yeniler."
  },
  State_71167_Desc = {
    Text = "Tur başında Lotan 15 Aliemus kazanır. Lotan'ın her turdaki ilk \"Savunma\" kullanımından sonra, Tüketme ve Geçici etkili 2 adet \"İsyan Kılıcı\" ele al."
  },
  State_71168_Desc = {
    Text = "Tur başında \"Pandia\" 15 Aliemus kazanır. Tur başında 64 Sayaç kazan. Her 4 Geçici olmayan Sayaç için, \"Pandia\"'nın Komut Kartının verdiği Hasar 1 artar."
  },
  State_71169_Desc = {
    Text = "Tur başında, \"Helot\" 15 Aliemus kazanır. Her kart atıldığında, \"Helot\" 5 Aliemus kazanır."
  },
  State_71170_Desc = {
    Text = "Tur başında, Tawil 15 Aliemus kazanır. Bir turda Tawil’in 6 Komut Kartı oynanırsa, ele 1 \"Gümüş Anahtar Şafağı\" ekle. Bekleme süresi: 3 tur."
  },
  State_71171_Desc = {
    Text = "Tur başında Miryam 15 Aliemus kazanır ve 1 \"Ayin\"i ele alır."
  },
  State_71172_Desc = {
    Text = "Tur başında, \"Erime·Doll\" 15 Aliemus kazanır. \"Erime·Doll\" Yüceltme’yi serbest bıraktıktan sonra, harcanan her 20 Aliemus, diğer Uyandıranlara 1 Aliemus kazandırır."
  },
  State_71173_Desc = {
    Text = "Tur başında, Salvador 15 Aliemus kazanır. Her Kızıl Ocak biriktirdiğinde, biriken miktarın %5’i kadar GÜÇ de kazanır. Salvador’un \"Darbe\" ve \"Izdırabın Sonu\" yetenekleri ayrıca 1x GÜÇ bonusu alır."
  },
  State_71175_Desc = {
    Text = "Tur başında Nautila 15 Aliemus kazanır. Nautila’nın \"Yüceltme\"sini kullandıktan sonra, mevcut Karakter Kalkanı’nın %50’sine eşit Sayaç kazanır; bu etki tur başına en fazla 1 kez tetiklenir."
  },
  State_71177_Desc = {
    Text = "Tur başında Liz 15 Aliemus kazanır. \"Yıkıma Dans\" ile atılan kartlar, 3 tur bekleme süresiyle, bir kez ek bir etki kazanır."
  },
  State_71178_Desc = {
    Text = "Tur başında Ramona 15 Aliemus kazanır. Ramona’nın oynadığı her 3. Komut Kartı, 1 kez ek bir etki sağlar."
  },
  State_71179_Desc = {
    Text = "Tur başında Uvhash 15 Aliemus kazanır. Uvhash’in Yüceltme Aliemus Tüketimi -10’dur ve her Yüceltme saldığında 5 daha azalır. Her tur 2 kez Yüceltme salabilir."
  },
  State_71180_Desc = {
    Text = "Tur başında, Alva 15 Aliemus kazanır. Alva önceki turda 2 \"Savunma\" oynadıysa, tüketilmiş bir \"Kalp Gözü Bıçağı\" nı eline koy; 2 \"Saldırı\" oynadıysa, 1 tüketilmiş \"Savaş Duruşu\" nu eline koy."
  },
  State_71181_Desc = {
    Text = "Tur başında, Sorel 15 Aliemus kazanır. Verilen her Hasar örneği için Embriyo Füzyonu +10, tur başına en fazla 10 kez. 10 etkinleştirmeye ulaştıktan sonra, Sorel'in Kritik Hasar'ı bu savaş boyunca +%20."
  },
  State_71182_Desc = {
    Text = "Tur başında Hameln 15 Aliemus kazanır. \"Ruh Uvertürü\"nün Arithmetica Maliyeti 1 azalır ve Temel Hasar sayısı 1 artar."
  },
  State_71183_Desc = {
    Text = "Tur başında Thais 15 Aliemus kazanır. Bir turda 3 Komut Kartı oynadıktan sonra, Thais 1 \"Saflığın Varisi\" ve 72 Geçici GÜÇ kazanır; bekleme süresi 3 turdur."
  },
  State_71187_Desc = {
    Text = "Tur başında Celeste 15 Aliemus kazanır. Tur bitmeden, eldeki her bir Celeste Komut Kartı için 1 Dokunaç bir düşmana saldırır ve 8 Can yeniler."
  },
  State_71188_Desc = {
    Text = "Tur başında Murphy 15 Aliemus kazanır. Murphy’nin \"Vuruş\" ve \"Savunma\" sı, \"Kurban\"ın %25’ini Geçici Dokunaç Hasarı’na dönüştürebilir, ancak tur başına yalnızca bir kez etkili olabilir."
  },
  State_71189_Desc = {
    Text = "Tur başında Nymphaea 15 Aliemus kazanır. Nymphaea'nın \"Saldırı\"sını kullandıktan sonra, bu savaşta \"Nymphaea\" tarafından verilen Zehir %20 artar. Nymphaea'nın \"Savunma\"sını kullandıktan sonra, tüm düşmanlara %50 Zehir tetiklenir. Her etki, tur başına en fazla bir kez etkili olabilir."
  },
  State_71190_Desc = {
    Text = "Tur başında, Ogier 15 Aliemus kazanır. Ogier her turda ilk kez \"Delici Mızrak\" veya \"Strike\" oynadıktan sonra, o turda ürettiği Kalkan ve STR %50 artar."
  },
  State_71191_Desc = {
    Text = "Tur başında Ryker 15 Aliemus kazanır. Her turdaki ilk zar atışının sonucu daima 6’dır."
  },
  State_71192_Desc = {
    Text = "Tur başında, Döngü·Ramona 15 Aliemus kazanır. Her tur \"Döngü\" ilk kez tetiklendiğinde, 500 Keyflare ve 1 yığın \"Negentropi\" kazan."
  },
  State_71193_Desc = {
    Text = "Tur başında Tulu 15 Aliemus kazanır. Tulu için Aliemus tüketimi 10 puan azalır ve Yücelişi serbest bıraktıktan sonra anında 2 Geçici Dokunaç üretir."
  },
  State_71194_Desc = {
    Text = "Tur başında Karen 15 Aliemus kazanır. \"Sessiz Sadakat\" oynamak, tükenmiş Arithmetica’yı iki katı olarak geri kazandırır; bekleme süresi 3 turdur."
  },
  State_71271_Desc = {
    Text = "Tur başında, Horla 15 Aliemus kazanır. Savaş başında, tüm duygular için 1 yığın \"Metafor\" kazanır. \"Metafor\" etkisi +%50."
  },
  State_71272_Desc = {
    Text = "Tur başında Jenkin 15 Aliemus kazanır ve Final Hasar %5 artar. \"Yakala onları! Brown!\" un Temel Hasarı ve Hasar büyümesi %200 artar."
  },
  State_71273_Desc = {
    Text = "Tur başında, Nergis 15 Aliemus ve 1 \"Insight\" kazanır. \"Heterojen Gelgit\"i her oynadığında, bu keşif sırasında kazanılan Güç kalıcı olarak %25 artar, en fazla %300’e kadar."
  },
  State_71274_Desc = {
    Text = "Tur başında Tinktur 15 Aliemus kazanır. Tinktur'un Komut Kartı Sıçrama tetiklediğinde, tur başına en fazla 3 etkinleşme olmak üzere onu eline geri döndür."
  },
  State_71275_Desc = {
    Text = "Tur başında Wanda 15 Aliemus kazanır ve 1 \"Düş Yemi\" yükü alır. Eğer bir Ultra Tur ise, ek olarak 1 Geçici \"Omurga İğnesi Zincirleri\" ve \"Kayıpların Koruyucusu\" elde Elde edilir."
  },
  State_71276_Desc = {
    Text = "Tur başında, Erica 15 Aliemus kazanır. Bir turda 3 Komut Kartı oynadıktan sonra, Erica 1 \"Insight\" kazanır ve bu savaşta \"Elektromanyetik Patlama\"nın Güç ve Tetikte bonuslarını ikiye katlar."
  },
  State_71277_Desc = {
    Text = "Tur başında Casiah 15 Aliemus kazanır. 1 kart çekmek, Casiah'a 1 Aliemus puanı kazandırır. Casiah Exalt'ı serbest bıraktığında, tüm düşmanlar 32 Güç kaybeder."
  },
  State_71278_Desc = {
    Text = "Tur başında Winkle 15 Aliemus kazanır. Başka bir Uyanık her Yücelt’i serbest bıraktığında Winkle 5 Aliemus kazanır ve eldeki \"Yeniden Dövülmüş Psişe\" nin Arithmetica Maliyeti 1 azalır."
  },
  State_71279_Desc = {
    Text = "Takım Hasar Güçlendirmesi [StateArg1]% artar, [Layer] <plural value=\"[Layer]\" singular=\"tur\" plural=\"tur\"> sürer."
  },
  State_71279_Name = {Text = "Vecd"},
  State_71503_Name = {
    Text = "\"Son Form\": 3 ek kart çek, 3 Arithmetica kazan, tüm düşmanlarda [DescArg1]% <IntoxicationIconKeywords:Poison> tetikle, \"Erime·Doll\"’un Aliemus Sınırını 50 artır, en fazla 3 kez."
  },
  State_71581_Name = {
    Text = "Ruh Dövme Yeteneği"
  },
  State_71589_Name = {
    Text = "Düşmana 1 Dokunaç Saldırısı tetikle ve 8 iyileştir."
  },
  State_71605_Name = {
    Text = "[StateArg1] Kalkan kazan"
  },
  State_71650_Desc = {
    Text = "Öldüğünde canlanır ve farklı sayılarda klon çağırır. Şaşırtıcı biçimde, diriliş sırasında hiçbir Kale ya da Bağışıklık etkisi kazanmaz. Etki yine de [Layer] kez tetiklenebilir."
  },
  State_71650_Name = {
    Text = "Sayısız Boyutun Canavarı"
  },
  State_71651_Desc = {
    Text = "Her HP kaybettiğinde, [StateArg1] Geçici GÜÇ kaybedersin. Hâlâ [Layer] kez etkili olabilir ve etkili olma sayısı tur başında sıfırlanır."
  },
  State_71651_Name = {
    Text = "Beyefendi Silindir Şapkası"
  },
  State_71707_Desc = {
    Text = "Alınan her Aktif Hasar örneği için [StateArg1] Can yenile; [Layer] <plural value=\"[Layer]\" singular=\"tur\" plural=\"tur\"> sürer."
  },
  State_71707_Name = {
    Text = "Caecus: Destek"
  },
  State_71708_Desc = {
    Text = "Tur sonunda, eldeki her 1 Kart için, tüm Uyananlar [DescArg1] Aliemus kazanır."
  },
  State_71708_Name = {
    Text = "Casiah: Destek"
  },
  State_71709_Desc = {
    Text = "Tur sonunda, [Layer] tur boyunca sürecek 35 Aliemus kazan."
  },
  State_71709_Name = {
    Text = "Winkle: Destek"
  },
  State_71711_Desc = {
    Text = "Uyandırıcının verdiği Hasar %25 artar ve [Layer] tur sürer."
  },
  State_71711_Name = {
    Text = "Jenkin: Destek"
  },
  State_71712_Desc = {
    Text = "Aktif Hasar verirken, [Layer] <plural value=\"[Layer]\" singular=\"tur\" plural=\"tur\"> süreyle 1 kez Dokunaç saldırısı tetikler."
  },
  State_71712_Name = {
    Text = "Aurita: Destek"
  },
  State_71712_WeaponDesc = {
    Text = "Hydromedusa Hasar verdiğinde, hedef üzerinde [StateArg1] Dokunaç Saldırısı tetikler."
  },
  State_71713_Desc = {
    Text = "Her \"Yutma\" gerçekleştirildiğinde, 2 \"Darbe\" çek ve Arithmetica Maliyetlerini 1 azalt; [Layer] tur sürer."
  },
  State_71713_Name = {
    Text = "Helot: Destek"
  },
  State_71740_Desc = {
    Text = "Sonraki turun başında [Layer] Karakter Kalkanı kazan."
  },
  State_71740_Name = {
    Text = "Leigh: Destek Kalkanı"
  },
  State_71741_Desc = {
    Text = "Sonraki turun başında, bu tur kaybedilen CP'ye eşit bir Karakter Kalkanı kazan, [Layer] tur sürer."
  },
  State_71741_Name = {
    Text = "Leigh: Destek"
  },
  State_71741_WeaponDesc = {
    Text = "Bir sonraki turun başında, önceki turda kaybedilen HP miktarı kadar Karakter Kalkanı kazan."
  },
  State_71742_Desc = {
    Text = "“Darbe” Hasarı [Layer]% artar."
  },
  State_71742_Name = {
    Text = "Helot: Destek"
  },
  State_71742_WeaponDesc = {
    Text = "Bu tur, Darbe Kartlarının Hasarı [Layer]% artar."
  },
  State_71837_Desc = {
    Text = "Sonraki turun başında Savunmasız ol."
  },
  State_71837_Name = {
    Text = "Gecikmeli Hasar Artışı"
  },
  State_71839_Desc = {
    Text = "\"Uyanış\" kullanıldığında, [Layer] Arithmetika kazan. Mevcut Diyar \"Aequor\" ise, geçici olarak fazladan [Layer] Dokunaç üretilir."
  },
  State_71839_Name = {
    Text = "Yıldızsal Koruma"
  },
  State_71856_Desc = {
    Text = "Her HP kaybettiğinde, [StateArg1] Geçici GÜÇ kaybedersin. Hâlâ [Layer] kez etkili olabilir ve etkili olma sayısı tur başında sıfırlanır."
  },
  State_71856_Name = {
    Text = "Beyefendi Silindir Şapkası"
  },
  State_72016_Name = {
    Text = "Caro ustalığı"
  },
  State_72018_WeaponDesc = {
    Text = "Her Hasar aldığında, tüm Uyandıranların Aliemus'u 1 artar."
  },
  State_72033_Desc = {Text = "—"},
  State_72033_Name = {Text = "Dokunaç"},
  State_72033_WeaponDesc = {Text = "—"},
  State_72034_Desc = {Text = "—"},
  State_72034_WeaponDesc = {Text = "—"},
  State_72036_Name = {
    Text = "Kaos Sınıfı Başlatma"
  },
  State_72079_Name = {
    Text = "Azgın Dalgalar"
  },
  State_72102_Desc = {
    Text = "\"Morimens\"in klasik oynanış deneyimi."
  },
  State_72102_Name = {
    Text = "Unutuş Destanı"
  },
  State_72137_Name = {
    Text = "Arithmetica Taşması"
  },
  State_72206_Name = {
    Text = "Araştırma İlerlemesi \"[DescArg1]/15\""
  },
  State_72208_Name = {
    Text = "Araştırma İlerleyişi \"[DescArg1]/2\""
  },
  State_72212_Name = {
    Text = "Araştırma İlerlemesi \"[DescArg1]/10\""
  },
  State_72213_Name = {
    Text = "Araştırma İlerlemesi \"[DescArg1]/30\""
  },
  State_72220_Name = {
    Text = "Araştırma İlerleyişi \"[DescArg1]/5\""
  },
  State_73518_Desc = {
    Text = "Verilen Hasar %100 artar. HP kaybettiğinde bu durum kaldırılır, ancak Maksimum HP’nin %50’sine eşit Karakter Kalkanı kazanılır."
  },
  State_73518_Name = {
    Text = "\"Suikastçı\""
  },
  State_73520_Desc = {
    Text = "Öldüğünde 1 Can puanını sakla ve tüm Hasara karşı bağışıklık kazan, Niyeti \"Bağ Kurulumunun Serbest Bırakılması\" na dönüştür."
  },
  State_73520_Name = {
    Text = "\"Bağlayıcı\""
  },
  State_73533_Desc = {
    Text = "Tur sonlarında artık kart atma. Savaşın başında, el sınırını 8 olarak ayarla."
  },
  State_73533_Name = {
    Text = "Yuva Rezonansı"
  },
  State_73535_Desc = {
    Text = "Sıra sende iken alınan Hasar %75 azalır. GÜÇ azaldığında, yalnızca GÜÇ yığınlarının %50’si düşürülür."
  },
  State_73535_Name = {Text = "Öz Koruma"},
  State_73566_Desc = {
    Text = "Komut Kartı olmayan her oynanan kart için [Power:StateArg1] <PowerIconKeywords:STR> kazan ve <Block:[Block:StateArg2]> Karakter Kalkanı elde et."
  },
  State_73566_Name = {
    Text = "\"İletişimci\""
  },
  State_73567_Desc = {
    Text = "Komut Kartı olmayan her oynanan kart için [Power:StateArg1] <PowerIconKeywords:STR> kazan ve <Block:[Block:StateArg2]> Karakter Kalkanı elde et."
  },
  State_73567_Name = {
    Text = "\"İletişimci\""
  },
  State_73570_Desc = {
    Text = "Komut Kartı olmayan her oynanan kart için [Power:StateArg1] <PowerIconKeywords:STR> kazan ve <Block:[Block:StateArg2]> Karakter Kalkanı elde et."
  },
  State_73570_Name = {
    Text = "\"İletişimci\""
  },
  State_73573_Desc = {
    Text = "Komut Kartı olmayan her oynanan kart için [Power:StateArg1] <PowerIconKeywords:STR> kazan ve <Block:[Block:StateArg2]> Karakter Kalkanı elde et."
  },
  State_73573_Name = {
    Text = "\"İletişimci\""
  },
  State_73649_Desc = {
    Text = "Takım Hasar Güçlendirmesi [Layer]% artar."
  },
  State_73649_Name = {
    Text = "Unutuşun Kuklaları"
  },
  State_73655_Name = {
    Text = "Organik Form Tanımlayıcı"
  },
  State_73664_Name = {
    Text = "Aksesuar Organik Form Etkisi"
  },
  State_73664_WeaponDesc = {
    Text = "Kuşanan Yüceltme kullandıktan sonra, bu tur boyunca Kalkanı ve İyileştirme Güçlendirmesi ikiye katlanır."
  },
  State_74012_Desc = {
    Text = "Tüm düşmanların maksimum HP'sinin [StateArg1]%'i kadar <RealDamage:Sabit Hasar> ver (en az [DescArg1]). Kullanımdan sonra, \"Kukla: Cehennem\"in özel yeteneği \"Final\"e dönüşür."
  },
  State_74012_Name = {
    Text = "Yanılsamanın Sonu"
  },
  State_74013_Desc = {
    Text = "Tüm düşmanların maksimum HP'sinin [StateArg1]%'i kadar <RealDamage:Sabit Hasar> ver. Bu Hasar, büyücülerin maksimum HP'sinin %500'ünden az olamaz. Kullanımdan sonra, \"Kukla: Cehennem\"in özel yeteneği \"Final\"e dönüşür."
  },
  State_74013_Name = {
    Text = "Yanılsamanın Sonu"
  },
  State_74014_Desc = {
    Text = "Tüm düşmanların maksimum HP'sinin [StateArg1]%'i kadar <RealDamage:Sabit Hasar> ver (bu Hasar, kendi maksimum HP'inin %500'ünden az olamaz), kaybedilen HP'nin %30'unu yenile. Kullanımdan sonra, \"Kukla: Cehennem\"in özel yeteneği \"Final\"e dönüşür."
  },
  State_74014_Name = {
    Text = "Yanılsamanın Sonu"
  },
  State_74015_Desc = {
    Text = "Tüm düşmanların maksimum HP'sinin [StateArg1]%'i kadar <RealDamage:Sabit Hasar> ver (en az [DescArg1]), <Heal:[Heal:DescArg2]> HP iyileştir ve kullanımdan sonra, \"Kukla: Cehennem\"in özel yeteneği \"Final\"e dönüşür."
  },
  State_74015_Name = {
    Text = "Yanılsamanın Sonu"
  },
  State_74019_Desc = {
    Text = "Tüm Uyandıranların Zehir, Sayaç ve Temel Hasarı +[Layer]%."
  },
  State_74019_Name = {
    Text = "Delilik Bulaşması"
  },
  State_74142_Desc = {
    Text = "Keşfin başında, DAY, SAL ve SAV [StateArg1]% artar."
  },
  State_74142_Name = {
    Text = "Ruh Dövme Yeteneği"
  },
  State_74219_Name = {
    Text = "Oynandıktan sonra eline geri döner"
  },
  State_74273_Desc = {
    Text = "Helot: Catena Aktif Hasar verdiğinde, [StateArg1]% Kan Akıtma uygula; [Layer] tur sürer."
  },
  State_74273_Name = {
    Text = "Kanlı Zincirler"
  },
  State_74771_Desc = {
    Text = "Bir Yücelişi tetiklemek için gereken Aliemus miktarı."
  },
  State_74771_Name = {
    Text = "Aliemus Sınırı"
  },
  State_74788_Desc = {
    Text = "\nVaroluş Paradoksu: Keşfin başında, Ölüm Direnci'nin %75'i Azami HP bonusuna dönüştürülür; en fazla %300 Ölüm Direnci dönüştürülebilir ve Azami HP en çok %10 artırılabilir. Ölüm Direnci her tetiklendiğinde, ele fazladan bir \"Gümüş Anahtar Işıltısı\" eklenir. \nDipsiz Yara İzi: Reis Savaşlarında, tarafımızın aldığı iyileştirme her %100 HP sınırına ulaştığında, sonraki iyileştirme etkileri %25 azaltılır, ancak toplam Ölüm Direnci %25 artar; en fazla 3 kez tetiklenir. \nPrizmatik Mercek: Tur başında, Karşı Hasar HP sınırının %750’sini aşarsa, fazladan biriken yığınlar yarıya indirilir ve Kalıcı Karşı Hasar HP sınırının en fazla %2250’sine kadar birikebilir; düşman Zehirlenmesi HP sınırının %1000’ini aşarsa, fazladan yığınlar yarıya indirilir ve Zehir HP sınırının en fazla %3000’ine kadar birikebilir. Takımın her %4 Hasar Güçlendirmesi niteliği için, yukarıdaki toplam sınırlar %1 artırılabilir. Uyandıran’ın Karşı Hasar’dan aldığı hasar bonusu %70 azaltılır, ancak verilen tüm Zehir ve Karşı Hasar %10 artırılır. Düşmanın turunun başında, etkinleştirilen her Gnosis için mevcut Kalıcı Karşı Hasar’ın %25’i Geçici Karşı Hasar olarak kazanılır ve tüm düşmanlarda %25 Zehir tetiklenir. \nKaderin Işık Konisi: Sıradan Canavarların \"Bakış\" salma tur sayısı 6 tura değiştirilir. Tüm savaşlar için 15 turluk bir sınır vardır, ancak 15. turun başında ele bir \"Işık Konisi Sınırı\" eklenir: Keyflare’ı ve tüm Uyandıranların Aliemus’unu en üst seviyeye çıkar."
  },
  State_74788_Name = {
    Text = "(Geçici Olarak At)"
  },
  State_74791_Desc = {
    Text = "\nArithmetica Uyumu: Bir turda 10. Komut Kartından sonra oynanan her Komut Kartı için 1 \"Arithmetica Uyumu\" kazan. Her yığın kart maliyetini 1 Arithmetica artırır; bu da Uyandırıcının Gümüş Anahtar Şarjı'nın %100'üne dönüştürülür (yığılabilir). Yığınlar Ultra Uzay'a girildiğinde sıfırlanır.\nAritmetik Taşması: Bir kart oynanınca, bu turdaki Arithmetica Maliyet azaltma etkisini kaldır. Mevcut Arithmetica 12'yi aştığında, her fazla puan takımın ortalama Gümüş Anahtar Şarjı'nın %300'üne dönüştürülür.\nAliemus Uyumu: Artan Aliemus % etkisi yarıya indirilir. Her Taşkınlık, Aliemus Üssü'nü 10 artırır. Taşkınlık yapmayan her Uyandırıcı için tur sonunda takımın ortalama Gümüş Anahtar Şarjı'nın %200'ü kazanılır."
  },
  State_74791_Name = {
    Text = "Keyflare’ın Uyum Şarkısı"
  },
  State_74809_Name = {
    Text = "\"Son Form\": 3 ek kart çek, 3 Arithmetica kazan, tüm düşmanlarda [DescArg1]% <IntoxicationIconKeywords:Poison> tetikle, \"Erime·Doll\"’un Aliemus Sınırını 50 artır, en fazla 3 kez."
  },
  State_74826_Name = {
    Text = "Rastgele [DescArg1] <FixedDamage:Saf Hasar> [DescArg2] <plural value=\"[DescArg2]\" singular=\"time\" plural=\"times\"> ver (1× <PowerIconKeywords:STR>'den yararlanır)"
  },
  State_74827_Name = {
    Text = "\n+[DescArg1]% Geçici Kritik Oranı ve Krit. Hasar kazan"
  },
  State_74828_Name = {
    Text = "\nTüm düşmanlara [DescArg1] <IntoxicationIconKeywords:Zehir> uygula"
  },
  State_74829_Name = {
    Text = "Tüm düşmanlara eksik Canlarının [DescArg1]%'i kadar <FixedDamage:Saf Hasar> ver"
  },
  State_74830_Name = {
    Text = "[DescArg1] Güç kazan"
  },
  State_74831_Name = {
    Text = "\nTüm Uyananlara <Energy:[DescArg1]> Aliemus bahşet"
  },
  State_74847_Desc = {
    Text = "Takıma Özel: Kuşananın her tur kullandığı ilk Komut Kartının verdiği Temel Hasar <WeaponEffect_Num:[StateArg1]%> artar. Ultra Uzay’a girerlerse, Kuşanan <WeaponEffect_Num:[StateArg2]> Aliemus kazanır."
  },
  State_74847_WeaponDesc = {
    Text = "Silah kullananın her tur kullandığı ilk Komut Kartı’nın verdiği Temel Hasar <WeaponEffect_Num:[StateArg1]%> artar. Ultra Uzay’a girerlerse, silah kullanan <WeaponEffect_Num:[StateArg2]> Aliemus kazanır."
  },
  State_74879_Name = {
    Text = [[

[DescArg1] Arithmetica kazan]]
  },
  State_74881_Name = {
    Text = "\nSeçilen bir Uyandıran'a <Energy:[DescArg1]> Aliemus ver"
  },
  State_74882_Name = {
    Text = "\n[DescArg1] <ProficientInRealmsIconKeywords:Diyar Ustalığı> kazan"
  },
  State_74883_Name = {
    Text = "\nOynanan sonraki [DescArg1] Komut Kartı fazladan bir <Posse:[DescArg2]> Keyflare verir"
  },
  State_74884_Name = {
    Text = "\nBu tur kazanılan <RetaliateIconKeywords:Sayaç> ile uygulanan <IntoxicationIconKeywords:Zehir> ve <BleedingIconKeywords:Kan Akıtma> her biri +[DescArg1]%"
  },
  State_74885_Name = {
    Text = "\nTüm Uyananlara <Energy:[DescArg1]> Aliemus bahşet"
  },
  State_74887_Name = {
    Text = "[DescArg1] Kalkan Puanı kazan"
  },
  State_74888_Name = {
    Text = "\n<DeathResistanceIconKeywords:Ölüm Direnci>'ni +[DescArg1]% artır"
  },
  State_74889_Name = {
    Text = [[

[DescArg1] <RetaliateIconKeywords:Counter> kazan]]
  },
  State_74890_Name = {
    Text = "Tüm düşmanlardan [DescArg1] Geçici GÜÇ Çal"
  },
  State_74891_Name = {
    Text = "Rastgele [DescArg1] <FixedDamage:Saf Hasar> [DescArg2] <plural value=\"[DescArg2]\" singular=\"time\" plural=\"times\"> ver (1× <PowerIconKeywords:STR>'den yararlanır)"
  },
  State_74910_Desc = {
    Text = "Takım Özgünlüğü: Kullanan Uyandırıcı \"Ramona\" ise, aşama tamamlandığında kazanılan Afinite +<WeaponEffect_Num:[StateArg1]%>."
  },
  State_74910_WeaponDesc = {
    Text = "Eğer kuşanan Uyanışçı \"Ramona\" ise, seviye tamamlandığında kazanılan Afinite <WeaponEffect_Num:[StateArg1]%> artar."
  },
  State_74932_Desc = {
    Text = "\"Darbe\" Komutu, \"Savunma\" Komutu veya \"Beceri\" Komutu oynamak, sırasıyla Tabu Ticareti’nin 1., 2. veya 3. etkisini güçlendirir."
  },
  State_74932_Name = {
    Text = "Tabu Ticareti"
  },
  State_74947_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur başında, <HPAndShieldMin:can ve kalkanı en düşük> düşmana [StateArg1] kat eylem kilidi uygular. Ekipman sahibi bir düşmanı öldürdükten sonra bu etki anında bir kez daha tetiklenir."
  },
  State_74947_Name = {
    Text = "Cadının Geniş Kenarlı Şapkası"
  },
  State_74948_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Exalt\"tan sonra, en yüksek Aliemus'a sahip düşman [StateArg1] Aliemus kaybeder ve <PVPEmptinessKeywords:Boşluk> kazanır."
  },
  State_74948_Name = {
    Text = "Hipnotik Sarkaç"
  },
  State_76236_Desc = {
    Text = "\nGümüş Anahtar Uyanışı: Keyflare dolduğunda, belirlenen Uyandırıcı'nın Uyanış kartını ele almak ve bu savaş için ona \"Sakla\" vermek amacıyla ek olarak \"Gümüş Anahtar Uyanışı\"nı seçebilirsiniz. \"Gümüş Anahtar Uyanışı\" tur başına yalnızca bir kez tetiklenebilir ve \"Müfreze\"den bağımsız bir bekleme süresine sahiptir.\nGümüş Anahtar Aşımı: \"Gümüş Anahtar Uyanışı\" kullanıldığında, her Uyandırılmış Uyandırıcı için 1000 Keyflare düşülür; bu durum Keyflare'in negatife girmesine neden olabilir.\nArşiv İşareti: Koruyucu'nun her Müfrezesi için \"Ezoterik Araştırma\" ve \"Okült Araştırma\" Derinliği %1 artar, en fazla %50'ye kadar. Tüm R Kader Çarkı etkileri, kullananın Boyutsal İmge Kalıntısı'nın görünme şansını %100 artıracak şekilde değiştirilir."
  },
  State_76236_Name = {
    Text = "Parlak Gümüş Işıltı"
  },
  State_76277_Desc = {
    Text = "Takıma Özel: Reis Savaşı başladıktan sonra, en fazla 50 Kara Mühür tüket; tüketilen her bir Kara Mühür puanı, <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords:Ölüm Direnci> kazandırır. Yıldız Bölümü'nde bu etki şu hâle gelir: \"Kullananın Boyutsal Görüntü Kalıntısı'nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76277_WeaponDesc = {
    Text = "Reis Savaşı başladıktan sonra en fazla 50 Kara Mühür tüket. Tüketilen her Kara Mühür için <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords: Ölüm Direnci> kazan. Yıldız Bölümü'nde, etki şu şekilde değişir: \"Kuşananın Boyutsal Görüntü Kalıntısının düşme oranını %100 artırır.\""
  },
  State_76278_Desc = {
    Text = "Takıma Özel: Yeni bir Kare üzerinde yürüdükten sonra kaybedilen HP'nin <WeaponEffect_Num:[StateArg1]%>'i kadarını geri kazan. Bir Acil Gnosis Birimi kullandıktan sonra, tüm Uyananların Krit. Oranı ve Krit. Hasarı %100 artar. \"Yıldız Bölümü\"nde bu etki şu hâle gelir: \"Kullananın Boyutsal Görüntü Kalıntısı'nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76278_WeaponDesc = {
    Text = "Yeni bir Kare’de yürüdükten sonra kaybedilen HP’nin ([DescArg1]) [StateArg1]%’ini geri kazan. Bir Acil Gnosis Birimi kullandıktan sonra, tüm Uyananların Krit. Oranı ve Krit. Hasar’ı %100 artar. \"Yıldız Bölümü\"nde bu Etki Değişimleri şuna dönüşür: \"Kuşananın Boyutsal Görüntü Kalıntısı’nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76279_Desc = {
    Text = "Takıma Özel: D-İzi Mağazası’ndaki Uyandırma Kartlarının maliyetini <WeaponEffect_Num:[StateArg1]> Kara Mühür azalt. Kuşananın Uyandırma kartı Doğuştan kazanır. \"Yıldız Bölümü\"nde bu Etki Değişimleri şuna dönüşür: \"Kuşananın Boyutsal Görüntü Kalıntısı’nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76279_WeaponDesc = {
    Text = "D-İzi Mağazası’ndaki Uyandırılmış Uyananların fiyatı <WeaponEffect_Num:[StateArg1]> Kara Mühür azaltılır. Kuşananın Uyandırma’sı Doğuştan bir Etki kazanır. Yıldız Bölümü’nde Etki Değişimleri şuna dönüşür: \"Kuşananın Boyutsal Görüntü Kalıntısı’nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76280_Desc = {
    Text = "Takıma Özel: Dinlenme Alanlarındaki HP Yenilenmesi <WeaponEffect_Num:[StateArg1]%> artar. HP yenilemeyi seçtikten sonra desteye 2 \"Kavrayış\" kartı ekle. \"Yıldız Bölümü\"nde, bu etki şu şekilde değişir: \"Kuşananın Boyutsal Görüntü Kalıntısının ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76280_WeaponDesc = {
    Text = "Dinlenme Alanındaki İyileştirme miktarı <WeaponEffect_Num:[StateArg1]%> artar. HP Yenilenmesini seçtikten sonra desteye 2 \"Kavrayış\" kartı ekle. Yıldız Bölümü'nde, etki şu şekilde değişir: \"Kuşananın Boyutsal Görüntüsünün Kalıntı ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76281_Desc = {
    Text = "Takıma Özel: Her Savaş bittikten sonra, en az Aliemus’a sahip Uyanan <WeaponEffect_Num:[StateArg1]> Aliemus kazanır. \"Yıldız Bölümü\"nde bu Etki Değişimleri şuna dönüşür: \"Kuşananın Boyutsal Görüntü Kalıntısı’nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76281_WeaponDesc = {
    Text = "Savaş bittikten sonra, en az Aliemus’a sahip Uyanan <WeaponEffect_Num:[Energy:StateArg1]> Aliemus kazanır. Yıldız Bölümü’nde bu Etki Değişimleri şuna dönüşür: \"Kuşananın Boyutsal Görüntü Kalıntısı’nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76282_Desc = {
    Text = "Takıma Özel: D-İzi Mağazası Yenileme Hakkı +1, Yenileme maliyeti <WeaponEffect_Num:[StateArg1]> Kara Mühür azalır. \"Yıldız Bölümü\"nde bu Etki Değişimleri şuna dönüşür: \"Kuşananın Boyutsal Görüntü Kalıntısı’nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76282_WeaponDesc = {
    Text = "D-İzi Mağazası Yenileme Hakkı +1, Yenileme maliyeti -<WeaponEffect_Num:[StateArg1]> Kara Mühür. \"Yıldız Bölümü\"nde Etki Değişimleri şuna dönüşür: \"Kuşananın Boyutsal Görüntü Kalıntısı’nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76283_Desc = {
    Text = "Takıma Özel: Kalıntı Yuvası sayısı 3 olur, bunlardan biri Lanetli Kalıntı Yuvası’dır. Bir Lanetli Kalıntı satın almak <WeaponEffect_Num:[StateArg1]> Kara Mühür kazandırır. \"Yıldız Bölümü\"nde bu Etki Değişimleri şuna dönüşür: \"Kuşananın Boyutsal Görüntü Kalıntısı’nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76283_WeaponDesc = {
    Text = "Kalıntı Yuvası sayısı 3 olur, bunlardan biri Lanetli Kalıntı’dır. Bir Lanetli Kalıntı satın aldıktan sonra <WeaponEffect_Num:[StateArg1]> Kara Mühür elde et. Yıldız Bölümü’nde Etki Değişimleri şuna dönüşür: \"Kuşananın Boyutsal Görüntü Kalıntısı’nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76284_Desc = {
    Text = "Takıma Özel: Her aşama başladığında, tüm Uyananlar <WeaponEffect_Num:[StateArg1]> Aliemus kazanır. Bir Reis Savaşı başlarken 2 kart çek. \"Yıldız Bölümü\"nde bu Etki Değişimleri şuna dönüşür: \"Kuşananın Boyutsal Görüntü Kalıntısı’nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76284_WeaponDesc = {
    Text = "Seviye başladıktan sonra, tüm Uyananlar <WeaponEffect_Num:[Energy:StateArg1]> Aliemus kazanır. Reis Savaşı başladıktan sonra 2 kart çek. Yıldız Bölümü’nde Etki Değişimleri şuna dönüşür: \"Kuşananın Boyutsal Görüntü Kalıntısı’nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76285_Desc = {
    Text = "Takıma Özel: Her safha başladıktan sonra <WeaponEffect_Num:[StateArg1]> Keyflare kazan. Bir Reis Savaşı başında 2 Arithmetica kazan. \"Yıldız Bölümü\"nde, bu etki şu şekilde değişir: \"Kuşananın Boyutsal Görüntü Kalıntısının ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76285_WeaponDesc = {
    Text = "Seviye başladıktan sonra <WeaponEffect_Num:[StateArg1]> Keyflare kazan. Reis Savaşı başladıktan sonra 2 Arithmetica kazan. \"Yıldız Bölümü\"nde, etki şu şekilde değişir: \"Kuşananın Boyutsal Görüntü Kalıntısının ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76286_Desc = {
    Text = "Takıma Özel: Dinlenme Alanları ek bir seçenek sunar: En fazla 3 Semptom kartını İmha Et, <WeaponEffect_Num:[StateArg1]> Kara Mühür elde et. \"Yıldız Bölümü\"nde, bu etki şu şekilde değişir: \"Kuşananın Boyutsal Görüntü Kalıntısının ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76286_WeaponDesc = {
    Text = "Dinlenme Alanları ek bir seçenek sunar: En fazla 3 Semptom kartını İmha Et, <WeaponEffect_Num:[StateArg1]> Kara Mühür elde et. \"Yıldız Bölümü\"nde, bu etki şu şekilde değişir: \"Kuşananın Boyutsal Görüntü Kalıntısının ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76287_Desc = {
    Text = "Takıma Özel: Normal bir savaş sona erdikten sonra, Alınabilir Duaların sayısı 4 olur. Kullananın kartlarındaki Duaların, İleri Dua'ya yükselme ihtimali <WeaponEffect_Num:[StateArg1]%> olur. \"Yıldız Bölümü\"nde bu etki şu hâle gelir: \"Kullananın Boyutsal Görüntü Kalıntısı'nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76287_WeaponDesc = {
    Text = "Sıradan bir savaş sona erdikten sonra, Alınabilir Duaların sayısı 4 olur. Kullananın kartlarındaki Duaların, İleri Dualar'a yükselme ihtimali <WeaponEffect_Num:[StateArg1]%> olur. Yıldız Bölümü'nde bu etki şu hâle gelir: \"Kullananın Boyutsal Görüntü Kalıntısı'nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76288_Desc = {
    Text = "Takıma Özel: Her savaş bittikten sonra <WeaponEffect_Num:[StateArg1]> Keyflare kazan. \"Yıldız Bölümü\"nde, bu etki şu şekilde değişir: \"Kuşananın Boyutsal Görüntü Kalıntısının ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76288_WeaponDesc = {
    Text = "Savaş sona erdikten sonra <WeaponEffect_Num:[StateArg1]> Keyflare elde et.\nYıldız Bölümü’nde bu etki şu hale gelir: \"Kuşanan’ın Boyutsal Görüntü Kalıntısı’nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76289_Desc = {
    Text = "Takıma Özel: Keşif sırasında Görüş +1, harita tamamen açıldığında <WeaponEffect_Num:[StateArg1]> Kara Mühür kazan. Reis Savaşlarının başında, tüm düşmanlara 1 tur boyunca <WeaknessIconKeywords:Zayıflık> ve <VulnerabilityIconKeywords:Savunmasız> uygula. Yıldız Bölümü'nde, etkisi şu şekilde değişir: \"Kuşananın Boyutsal Görüntü Kalıntısı'nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76289_WeaponDesc = {
    Text = "Keşif Görüşü +1, harita tamamen açıldığında <WeaponEffect_Num:[StateArg1]> Kara Mühür elde et. Bir Reis Savaşı'nın başında, tüm düşmanlara 1 tur boyunca <WeaknessIconKeywords:Zayıflık> ve <VulnerabilityIconKeywords:Savunmasız> uygula. Yıldız Bölümü'nde, etkisi şu şekilde değişir: \"Kuşananın Boyutsal Görüntü Kalıntısı'nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76290_Desc = {
    Text = "Takıma Özel: Normal bir Savaş’tan sonra, bir Yakarış’tan vazgeçip Maksimum HP’yi <WeaponEffect_Num:[StateArg1]%> artırmayı seçebilirsin. En fazla 2 kez Etki gösterir. \"Yıldız Bölümü\"nde bu Etki Değişimleri şuna dönüşür: \"Kuşananın Boyutsal Görüntü Kalıntısı’nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76290_WeaponDesc = {
    Text = "Sıradan bir Savaş’tan sonra, bir Yakarış’tan Vazgeçme ve Maksimum HP’yi <WeaponEffect_Num:[DescArg1]> artırma seçeneğin olur. Bu Etki en fazla 2 kez Etki gösterir. Yıldız Bölümü’nde Etki Değişimleri şuna dönüşür: \"Kuşananın Boyutsal Görüntü Kalıntısı’nın ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76291_Desc = {
    Text = "Takıma Özel: Her safha başladıktan sonra <WeaponEffect_Num:[StateArg1]> Kara Mühür kazan. Kalıntı Kapasitesi +2. \"Yıldız Bölümü\"nde, bu etki şu şekilde değişir: \"Kuşananın Boyutsal Görüntü Kalıntısının ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76291_WeaponDesc = {
    Text = "Seviye başladıktan sonra <WeaponEffect_Num:[StateArg1]> Kara Mühür elde et. Kalıntı Kapasitesi +2. Yıldız Bölümü'nde, etki şu şekilde değişir: \"Kuşananın Boyutsal Görüntü Kalıntısının ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76292_Desc = {
    Text = "Takıma Özel: Semptom kartları <WeaponEffect_Num:[StateArg1]> Kara Mühür karşılığında satılabilir. \"Yıldız Bölümü\"nde, bu etki şu şekilde değişir: \"Kuşananın Boyutsal Görüntü Kalıntısının ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76292_WeaponDesc = {
    Text = "D-İzleri, D-İzi Mağazası'nda Semptom kartlarını <WeaponEffect_Num:[StateArg1]> Kara Mühür karşılığında satarak elde edilebilir. Yıldız Bölümü'nde, etki şu şekilde değişir: \"Kuşananın Boyutsal Görüntü Kalıntısının ortaya çıkma ihtimalini %100 artırır.\""
  },
  State_76321_Name = {
    Text = "Prizmatik Mercek"
  },
  State_76323_Name = {
    Text = "Aliemus Uyumu"
  },
  State_76324_Name = {
    Text = "Arithmetica Uyumu"
  },
  State_76325_Desc = {
    Text = "[DescArg1] Komut Kartı oynadıktan sonra, \"Arithmetica Uyumu\" durumuna gir."
  },
  State_76325_Name = {
    Text = "Arithmetica Uyumu"
  },
  State_76326_Name = {
    Text = "Varoluş Paradoksu"
  },
  State_76328_Name = {
    Text = "Kaderin Işık Konisi"
  },
  State_76337_Name = {
    Text = "Dipsiz Yara İzi"
  },
  State_76338_Desc = {
    Text = "Alınan İyileştirme %[Layer] azaltılır."
  },
  State_76338_Name = {
    Text = "Dipsiz Yara İzi"
  },
  State_76430_Name = {
    Text = "Boyut İmgesi · Lily"
  },
  State_76433_Name = {
    Text = "Arithmetica Uyumu"
  },
  State_76434_Desc = {
    Text = "Her Komut Kartı oynandığında, Arithmetica Uyumu nedeniyle fazladan Arithmetica Tüketme gerçekleştiyse, Uyandıranın Keyflare Yenilenmesinin %100’ü kadar ek Keyflare kazan. Bu Etki birikebilir."
  },
  State_76434_Name = {
    Text = "Arithmetica Uyumu"
  },
  State_76435_Name = {
    Text = "Prizmatik Mercek"
  },
  State_76528_Name = {
    Text = "Bu kart \"Darbe\" olarak kabul edilir"
  },
  State_76529_Desc = {
    Text = "Alındığında, bir Uyanışçının kartını seç ve Arithmetica Maliyeti’ni 1 azalt. Onu oynadıktan sonra 1 kart çek ve onu \"Darbe\" olarak değerlendir."
  },
  State_76533_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda, rakibin elindeki rastgele [StateArg1] karta [StateArg2] yığın <PVPAcheKeywords:Örtülü Acı> yükle."
  },
  State_76533_Name = {
    Text = "Örtülü Acı"
  },
  State_76553_Desc = {
    Text = "Bu Kartın Arithmetica Maliyetini [StateArg1] azalt."
  },
  State_76553_Name = {
    Text = "Milyon Sevgi Dolu Bakış"
  },
  State_77686_Name = {
    Text = "Yarı Mekanik Form"
  },
  State_77688_Desc = {
    Text = "Beşinci turun başında ya da ölüm yaklaşırken, ölüme Bağışıklık kazan ve Niyet \"Mekanik Yükseliş\"e kayar."
  },
  State_77688_Name = {
    Text = "Beden Zayıftır"
  },
  State_77690_Desc = {
    Text = "\"Yarı Mekanik Form\" a geçtikten sonra, her Final perdesi fazladan %10 Maksimum HP sağlar. \"Yarı Mekanik Form\" dayken, \"Doll: Cehennem\" sahip olduğu \"Final\" yığınları arttıkça daha tehditkâr Yetenekler açığa çıkarır."
  },
  State_77690_Name = {Text = "Son Perde"},
  State_77692_Desc = {
    Text = "Tur sonunda 2 adet Çözünme Canavarı çağır; aynı anda en fazla 2 tane var olabilir. Çağrılan Çözünme Canavarları öldüğünde, \"Erime·Doll\" azami CP’sinin %5’ini kaybeder."
  },
  State_77692_Name = {
    Text = "Uçurum Kapısı"
  },
  State_77693_Desc = {
    Text = "Öldüğünde, \"Erime·Doll\" en fazla HP’sinin %5’ini kaybeder."
  },
  State_77693_Name = {Text = "Erime"},
  State_78102_Desc = {
    Text = "Verilen Hasar %15 azalır ve alınan Hasar %30 artar; bu etki Savaşın sonuna dek sürer."
  },
  State_78102_Name = {
    Text = "Aşırı Hız Felci"
  },
  State_78694_Desc = {
    Text = "Savaşın başında [Arg1] Güç kazan. Tur başında, her [Arg2] Kalıcı Güç için [Arg3] Geçici GÜÇ kazan; en fazla [Arg4] Geçici GÜÇ’e kadar. Tur sonunda, o Kutsal Emanet tarafından kazandığın Geçici GÜÇ’ün yarısını kaybet."
  },
  State_78696_Desc = {
    Text = "Keyflare Uyanışı kullandıktan sonra, ilgili Uyanan’ın [Arg1] adet \"Beceri\"sini Tüketme için seç ve Tüketme ile [Arg2] kopyayı Çekme Desteğine karıştır."
  },
  State_78697_Desc = {
    Text = "Tur başında, Ultra Uzay’daki her 1 boş alan için [Arg1] KUV kazan, ancak [Arg2] yığın Zehir çek."
  },
  State_78698_Desc = {
    Text = "Arithmetica Sınırı -[Arg1]. Arithmetica Maliyeti [Arg2] veya daha fazla olan bir kart oynadığında, 1 Arithmetica kazan. Bu etki, tur başına en fazla [Arg3] kez tetiklenebilir."
  },
  State_78699_Desc = {
    Text = "Çekildikten sonra, fazladan [Arg1] kart çek, ancak elinden [Arg2] kart seçip at."
  },
  State_78700_Desc = {
    Text = "Tüm Uyananların Temel Hasarı [Arg1]% artar. Deste her sıfırlandığında, fazladan [Arg2]% verilir, ancak eline bir \"Sersemleme\" kartı eklenir. En fazla artış [Arg3]%’tir."
  },
  State_78701_Desc = {
    Text = "Tur başında, [Arg1]’den fazla Kalıcı Dokunaç varsa, [Arg3] Geçici Dokunaç kazanmak için [Arg2] Dokunaç kaybet; aksi halde [Arg4] Geçici Dokunaç kazan."
  },
  State_78702_Desc = {
    Text = "Keyflare Uyandırma kullanıldıktan sonra, fazladan [Arg1] Keyflare tüketerek alınan Uyandırma kartının Arithmetica Tüketmesini 0’a düşür. Oynandığında, ilgili Uyandıran fazladan [Arg2] Aliemus kazanır."
  },
  State_78703_Desc = {
    Text = "Savaş başında, tüm düşmanlara [Arg1] Zehir uygula. Her tur başlangıcından önce, düşmanın Zehir’inin [Arg2]%’ini kaldır ve kaldırılan miktarın [Arg3]%’i kadar Kan Akıtma uygula."
  },
  State_78710_Desc = {
    Text = "Oynanan her Komut Kartı için, ilgili Uyanan'ın o turdaki Final Hasarı [Arg1]% artar, ancak [Arg2] Aliemus kaybeder. Bu etki tur başına en fazla [Arg3] kez tetiklenebilir."
  },
  State_78712_Desc = {
    Text = "Tur başında, Embriyo Füzyonu seviyesi +[Arg1]. Embriyonuz tur sonunda ıskartaya atılır."
  },
  State_78713_Desc = {
    Text = "Tur başında [Arg1] Sayaç kazan. Bir turda Uyanış’ı [Arg2] kez kullandıktan sonra, [Arg3]% Kalıcı Sayaç kaldır ve kaldırılan miktarın [Arg4]%’i kadar Geçici Sayaç kazan. Bekleme süresi: [Arg5] tur."
  },
  State_78781_Desc = {
    Text = "Hedefin STR’sini geçici olarak azalt ve aynı miktarda Geçici GÜÇ kazan."
  },
  State_78781_Name = {
    Text = "<TouquKeywords:Çalma>"
  },
  State_79405_Desc = {
    Text = "Oynandığında, \"Berrak Hatıra\"yı 1 artırır. 10’a ulaştığında, 1 tur boyunca kilitle ve 3 \"Insight\" kartı kazan; sonra bir sonraki turun başında 5’e sıfırla."
  },
  State_79405_Name = {
    Text = "Hakiki Geçmiş"
  },
  State_79406_Desc = {
    Text = "Oynandığında, \"Berrak Hatıra\"yı 1 azaltır. 0'a ulaştığında, onu 1 tur kilitle ve tüm Uyananlar 30 Aliemus kazansın. Ardından bir sonraki turun başında 5'e sıfırla."
  },
  State_79406_Name = {
    Text = "Gösterişin Yanılsaması"
  },
  State_80052_Desc = {Text = "Test"},
  State_80052_Name = {Text = "Test 123"},
  State_80052_WeaponDesc = {Text = "Test"},
  State_80161_Desc = {
    Text = "Takıma Özel: Taşıyıcının Tecessüd Temel Hasarı +<WeaponEffect_Num:[StateArg1]%>, ve Keyflare Yenilenmesi +<WeaponEffect_Num:[StateArg2]>. Ultra Tur’a girildikten sonra, tüm Uyananlar <WeaponEffect_Num:[StateArg4]> Aliemus kazanır. \"Yok Oluş\" serbest bırakıldıktan sonra, taşıyıcı <WeaponEffect_Num:[StateArg3]> Aliemus elde eder."
  },
  State_80161_WeaponDesc = {
    Text = "Kuşanan’ın Uyanış Temel Hasarı +<WeaponEffect_Num:[StateArg1]%>, ve Keyflare Yenilenmesi +<WeaponEffect_Num:[DescArg1]>. Ultra Tur’a girildikten sonra, tüm Uyanışlar <WeaponEffect_Num:[StateArg4]> Aliemus elde eder. \"Yok Oluş\" serbest bırakıldıktan sonra, Kuşanan <WeaponEffect_Num:[StateArg3]> Aliemus elde eder."
  },
  State_80174_Desc = {
    Text = "Takıma Özel: Kuşananın Keyflare Yenilenmesi <WeaponEffect_Num:[StateArg1]%> artar. İlk Savaşın başında, tüm düşmanlara 1 yığın Zayıflık ve Savunmasızlık uygula."
  },
  State_80174_WeaponDesc = {
    Text = "Silah kullananın Keyflare Yenilenmesini <WeaponEffect_Num:[DescArg1]> artırır. İlk savaşın başında, tüm düşmanlara 1 yığın Zayıflık ve Savunmasızlık uygular."
  },
  State_80207_Desc = {
    Text = "Bu kart oynandıktan sonra \"Boyut Mekiği\"ni tetiklerse, sonraki etkiyi tetikle. Ultra Uzay'dan alındığında Arithmetica Maliyeti -1."
  },
  State_80207_Name = {
    Text = "<WormholeKeywords:Kuasar>"
  },
  State_80328_Desc = {
    Text = "Duyguları, bilişi ve diğer her şeyi sonsuza dek Kovan İradesi’ne bağlıdır. Bu etki en fazla 15 kez birikir. \"Ortak Duyum\", Clementine’in \"Yaşam Formu Yeniden Yapılandırması\" Yücelt’iyle zayıflatma etkilerine dönüştürülebilir."
  },
  State_80328_Name = {Text = "Simbiyoz"},
  State_80331_Desc = {
    Text = "Kovan'ın aşındırması altında, zayıflıklarınız tamamen açığa çıkar. Bu tur alınan Aktif ve Dokunaç Hasarı [DescArg1]% artar."
  },
  State_80331_Name = {
    Text = "<D13Colour:Psişik Travma>"
  },
  State_80332_Desc = {
    Text = "Duyguları, bilişi ve diğer her şeyi sonsuza dek Kovan İradesi’ne bağlıdır. Bu etki en fazla 10 kez birikir. \"Ortak Duyum\", Clementine’in \"Yaşam Formu Yeniden Yapılandırması\" Yücelt’iyle zayıflatma etkilerine dönüştürülebilir."
  },
  State_80332_Name = {Text = "Simbiyoz"},
  State_80335_Desc = {
    Text = "Kovan'ın aşındırması altında, zayıflıklarınız tamamen açığa çıkar. Bu tur alınan Aktif ve Dokunaç Hasarı [DescArg1]% artar."
  },
  State_80335_Name = {
    Text = "<D13Colour:Psişik Travma>"
  },
  State_80336_Desc = {
    Text = "Kovan'ın aşındırması altında, korkularınız gün yüzüne çıkar. Bu tur verilen Aktif ve Dokunaç Hasarı [DescArg1]% azalır."
  },
  State_80336_Name = {
    Text = "<D13Colour:Fobik Takıntı>"
  },
  State_80338_Desc = {
    Text = "Kovan'ın aşındırması altında, korkularınız gün yüzüne çıkar. Bu tur verilen Aktif ve Dokunaç Hasarı [DescArg1]% azalır."
  },
  State_80338_Name = {
    Text = "<D13Colour:Fobik Takıntı>"
  },
  State_80575_Desc = {
    Text = "<After suffering active damage or Tentacle damage, remove an equivalent amount of \"Old Embers\" and lose 300% of the removal amount in life; when suffering other damage, remove half. The number of \"Old Embers\" resets each round.:Etkin Hasar veya Dokunaç Hasarı aldıktan sonra, eşdeğer miktarda “Eski Köz”ü kaldır ve kaldırılan miktarın %300’ü kadar Can kaybet; başka tür Hasar aldığında ise bunun yarısını kaldır. “Eski Köz” sayısı her tur başında sıfırlanır.>"
  },
  State_80575_Name = {
    Text = "Eski Günlerin Közleri"
  },
  State_80644_Name = {
    Text = "Durum@Aşkınlık Işığı"
  },
  State_80773_Desc = {
    Text = "Maruz kalınan STR ▼ etkisi -%50. Kendi turunda, Aktif ve Dokunaç dışındaki alınan hasar +%100."
  },
  State_80773_Name = {
    Text = "Boyutötesi Antikor"
  },
  State_80774_Desc = {
    Text = "Aktif Hasar veya Dokunaç Hasarı aldıktan sonra, eşit miktarda \"Kadim Korlar\" kaldır ve kaldırılan miktarın %300’ü kadar Can kaybet; diğer tür Hasar aldığında, yarısını kaldır. \"Kadim Korlar\" yığın sayısı her tur yenilenir. Tüm \"Kadim Korlar\" kaldırıldıktan sonra, 50 yığın \"Kale\" kazan."
  },
  State_80774_Name = {
    Text = "Eski Günlerin Közleri"
  },
  State_80777_Desc = {
    Text = "Savaş başında, tüm Uyandıranların Kritik Oranını %10 azalt. Ölümünde, diğer müttefikler [DescArg1] Güç ve [DescArg2] yığın \"Kadim Korlar\" kazanır."
  },
  State_80777_Name = {
    Text = "Kovan Empatisi: Miras"
  },
  State_80778_Desc = {
    Text = "Ölümden sonra, diğer müttefikler 1 yığın \"Geçici Delilik\" kazanır."
  },
  State_80778_Name = {
    Text = "Kovan Empatisi: Füzyon"
  },
  State_80782_Desc = {
    Text = "Bu Savaşta, tüm Uyandıranların Kritik Oranları -[Layer]%."
  },
  State_80782_Name = {
    Text = "Kritik Oranı-"
  },
  State_80783_Desc = {
    Text = "Tur sonunda, 1 yığın \"Delilik\" kazan."
  },
  State_80783_Name = {
    Text = "Akrabalık Bağı"
  },
  State_80784_Desc = {
    Text = "HP %50’nin altındayken arka safa bir \"İlk Dönüşen\"Çağrı; her Savaşta yalnızca bir kez tetiklenebilir."
  },
  State_80784_Name = {
    Text = "Kovan Empatisi: Fisyon"
  },
  State_80785_Desc = {
    Text = "GÜÇ Azaltma bu düşmana yalnızca %50 etkili olur. Her Taşkınlık kullandığınızda, 1 yığın \"Geçici Delilik\" kazan."
  },
  State_80785_Name = {
    Text = "Kovan Empatisi: Boyut"
  },
  State_80788_Desc = {
    Text = "GÜÇ Azaltma bu düşmana yalnızca %25 etkili olur. Her Taşkınlık kullandığınızda, 1 yığın \"Geçici Delilik\" kazan."
  },
  State_80788_Name = {
    Text = "Kovan Empatisi: Boyut"
  },
  State_80789_Desc = {
    Text = "Alınan Aktif ve Dokunaç Hasarı +%100, 1 tur sürer."
  },
  State_80789_Name = {Text = "Uyku Hâli"},
  State_80790_Desc = {
    Text = "Başkalaşımdan sonra, her bir Kozmik Eter yığını onu mükemmele biraz daha yaklaştıracak..."
  },
  State_80790_Name = {
    Text = "Kozmik Eter"
  },
  State_80792_Desc = {
    Text = "Her Taşkınlık kullandığınızda, 1 yığın \"Geçici Delilik\" kazan."
  },
  State_80792_Name = {
    Text = "Kovan Empatisi: Boyut"
  },
  State_80794_Desc = {
    Text = "Kartlar oynanamaz ve tur sonunda elde kalır."
  },
  State_80794_Name = {
    Text = "<Boundkeywords:Bağlama>"
  },
  State_80807_Desc = {
    Text = "Beşinci tur başladığında ya da ölmek üzereyken, diğer tüm düşmanları kaldır ve niyeti \"Başkalaşım Anı\"na çevir."
  },
  State_80807_Name = {
    Text = "Dönüşüm Anı"
  },
  State_80809_Desc = {
    Text = "Tur sonunda, Elde olup Geçici olan kartlar atılır."
  },
  State_80809_Name = {
    Text = "<PVPVoidKeyColour:Yanılsama>"
  },
  State_80810_Desc = {
    Text = "<After suffering active damage or Tentacle damage, remove an equivalent amount of \"Old Embers\" and lose 300% of the removal amount in life; when suffering other damage, remove half. The number of \"Old Embers\" resets each round.:Etkin Hasar veya Dokunaç Hasarı aldıktan sonra, eşdeğer miktarda “Eski Köz”ü kaldır ve kaldırılan miktarın %300’ü kadar Can kaybet; başka tür Hasar aldığında ise bunun yarısını kaldır. “Eski Köz” sayısı her tur başında sıfırlanır.>"
  },
  State_80810_Name = {
    Text = "Eski Günlerin Közleri"
  },
  State_80827_Desc = {
    Text = "Her 15 oynanan kart için, mevcut Niyet’i \"Travma Darbesi\" ile değiştir (şu anda kalan [Layer] kart)."
  },
  State_80827_Name = {
    Text = "Öfkenin Cezası"
  },
  State_81022_WeaponDesc = {
    Text = "Her Hasar aldığında, tüm Uyandıranların Aliemus'u 1 artar."
  },
  State_81027_Desc = {
    Text = "Bu kartın sahibi \"Böceksiler\"dir, Arithmetica Maliyeti -1, oynadıktan sonra tükenir."
  },
  State_81027_Name = {
    Text = "Yaşam Ayini"
  },
  State_81054_Desc = {
    Text = "Kovan'ın aşındırması altında korkularınız gün yüzüne çıkar. Her yığın için bu turda verilen Aktif ve Dokunaç Hasarı -%3, en fazla 15 yığın yığılır."
  },
  State_81054_Name = {
    Text = "<D13AFKeyWordQ1:Fobik Takıntı>"
  },
  State_81055_Desc = {
    Text = "Kovan'ın aşındırması altında korkularınız gün yüzüne çıkar. Her yığın için bu turda alınan Aktif ve Dokunaç Hasarı +%3, en fazla 10 yığın yığılır."
  },
  State_81055_Name = {
    Text = "<D13AFKeyWord2:Psişik Travma>"
  },
  State_81056_Desc = {
    Text = "Kovan'ın aşındırması altında korkularınız gün yüzüne çıkar. Her yığın için bu turda alınan Aktif ve Dokunaç Hasarı +%3, en fazla 15 yığın yığılır."
  },
  State_81056_Name = {
    Text = "<D13AFKeyWordQ2:Psişik Travma>"
  },
  State_81057_Desc = {
    Text = "Kovan'ın aşındırması altında korkularınız gün yüzüne çıkar. Her yığın için bu turda verilen Aktif ve Dokunaç Hasarı -%3, en fazla 10 yığın yığılır."
  },
  State_81057_Name = {
    Text = "<D13AFKeyWord1:Fobik Takıntı>"
  },
  State_81058_Desc = {
    Text = "Duyguları, bilişi ve diğer her şeyi sonsuza dek Kovan İradesi’ne bağlıdır. \"Empati\", Clementine’in \"Yaşam Formu Yeniden Yapılandırması\" Yücelt’iyle zayıflatma etkilerine dönüştürülebilir ve en fazla 15 yığına kadar birikir."
  },
  State_81058_Name = {
    Text = "<AnalysisKeywords3:Ortak Duyum>"
  },
  State_81059_Desc = {
    Text = "Duyguları, bilişi ve diğer her şeyi sonsuza dek Kovan İradesi’ne bağlıdır. \"Ortak Duyum\", Clementine’in \"Yaşam Formu Yeniden Yapılandırması\" Yücelt’iyle zayıflatma etkilerine dönüştürülebilir ve en fazla 10 yığına kadar birikir."
  },
  State_81059_Name = {
    Text = "<AnalysisKeywords0:Ortak Duyum>"
  },
  State_81073_Desc = {
    Text = "Ölümcül Hasar aldığında derhal tüm Canını yenile ve %80 Geçici Kale kazan; arkaya bir \"İlk Dönüşen\"çağır; 2 kez tetiklenebilir."
  },
  State_81073_Name = {
    Text = "Kovan Empatisi: Fisyon"
  },
  State_81278_Desc = {
    Text = "Her turda ilk kez bir Çete serbest bırakıldıktan sonra, tüm Uyananlar 10 Aliemus kazanır, ancak bir Çete serbest bırakmanın maliyeti Kalıcı olarak %10 artar."
  },
  State_81278_Name = {
    Text = "Gümüş Anahtar Bastırması"
  },
  State_81312_Desc = {
    Text = "Ölümcül Hasar aldıktan sonra tüm HP’yi yenile ve 50 yığın Geçici güçlendirme kazan. Ayrıca [Layer] kez tetiklenebilir."
  },
  State_81312_Name = {
    Text = "Kozmik Reenkarnasyon"
  },
  State_81331_Desc = {
    Text = "Tur başında 1 Uyandıran seç; tüm kartlarını ve Yüceliğini 3 tur boyunca mühürle."
  },
  State_81331_Name = {
    Text = "Şuur Hapsi"
  },
  State_81340_Desc = {
    Text = "Bu kart Mühürlü’dür ve mühür kalkana dek, yani [Layer] tur sonra, oynanamaz."
  },
  State_81340_Name = {
    Text = "<Seal1:Kart Mührü>"
  },
  State_81341_Desc = {
    Text = "Bu Uyanan’ın Yücelişi mühürlüdür ve mühür kalkana kadar, yani [Layer] tur sonra, kullanılamaz."
  },
  State_81341_Name = {
    Text = "<Seal1:Aliemus Mührü>"
  },
  State_81354_Desc = {
    Text = "Oynandığında [DescArg1] Hasar alırsın. Tur sonunda hâlâ eldeyse, Tüketme."
  },
  State_81354_Name = {
    Text = "<BurningKeywords:Yak>"
  },
  State_81356_Desc = {
    Text = "Kart yanar, oynandığında [DescArg1] Hasar alırsın. Tur sonunda hâlâ eldeyse, Tüketme."
  },
  State_81356_Name = {
    Text = "<BurningKeywords:Yak>"
  },
  State_81356_WeaponDesc = {
    Text = "Her Durgunluk yığını, kartların Arithmetica Maliyetini 1 artırır."
  },
  State_83587_Desc = {
    Text = "\"Demir Alma\" seçildiğinde Etkiyi güçlendirebilir, en fazla 10 yığın."
  },
  State_83587_Name = {Text = "Yelken Aç"},
  State_83589_Desc = {
    Text = "\"Kıyıda Dinleniş\" seçildiğinde Etkiyi güçlendirebilir, en fazla 10 yığın."
  },
  State_83589_Name = {Text = "Demir Atma"},
  State_83593_Desc = {
    Text = "Bu turda Uyandırıcıların verdiği tüm Final Hasar artırılır."
  },
  State_83593_Name = {
    Text = "Final Hasar"
  },
  State_83596_Desc = {
    Text = "El Sınırı +1. Tur başında destede \"Seyir Subayının İkilemi\" yoksa, eline ekle. Lider Maksimum Canının %10’unu her kaybettiğinde 1 yığın \"Yelken Aç\" kazan; sen Maksimum Canının %10’unu her kaybettiğinde 1 yığın \"Demir Atma\" kazan."
  },
  State_83596_Name = {
    Text = "Erasmus'un Rehberliği: \"Yelken Aç\""
  },
  State_83607_Desc = {
    Text = "Boss’un kümülatif yüzde on HP kaybı tanımlayıcısı"
  },
  State_83607_Name = {
    Text = "Durum@Boss kümülatif yüzde on can kaybı tanımlayıcı"
  },
  State_83609_Desc = {
    Text = "Oyuncunun kümülatif yüzde on HP kaybı tanımlayıcısı"
  },
  State_83609_Name = {
    Text = "Durum@Oyuncu kümülatif yüzde on can kaybı tanımlayıcı"
  },
  State_83614_Desc = {
    Text = "Oyuncu Maksimum CP’sinin %10’u"
  },
  State_83614_Name = {
    Text = "Durum@Oyuncu yüzde on can değeri"
  },
  State_83615_Desc = {
    Text = "[Layer] Can kaybettikten sonra, 1 yığın \"Yelken Aç\" kazan."
  },
  State_83615_Name = {
    Text = "\"Yelken Aç\"İlerlemesi"
  },
  State_83616_Desc = {
    Text = "[Layer] Can kaybettikten sonra, 1 yığın \"Demir Atma\" kazan."
  },
  State_83616_Name = {
    Text = "\"Demir Atma\" İlerlemesi"
  },
  State_83617_Desc = {
    Text = "Canavarsı Önder %10 sağlıkta"
  },
  State_83617_Name = {
    Text = "Durum@Boss yüzde on can değeri"
  },
  State_83618_Desc = {
    Text = "Test sırasında mevcut HP: [Layer]"
  },
  State_83618_Name = {
    Text = "Düşmanın mevcut can sayısı"
  },
  State_83619_Desc = {
    Text = "Test sırasında azami HP: [Layer]"
  },
  State_83619_Name = {
    Text = "Düşmanın maksimum can sayısı"
  },
  State_83620_Desc = {
    Text = "4. parametrenin mevcut değerinin 100 ile çarpımı [Layer]’dir."
  },
  State_83620_Name = {
    Text = "Parametre Baskısı"
  },
  State_83621_Desc = {
    Text = "Patron on yüzde sağlık kaybı orta nokta sayımı"
  },
  State_83621_Name = {
    Text = "Durum@Boss yüzde on can kaybı sayım ara değeri"
  },
  State_83622_Desc = {
    Text = "Oyuncu yüzde on sağlık kaybı, orta değeri esas alır."
  },
  State_83622_Name = {
    Text = "Durum@Oyuncu yüzde on can kaybı sayım ara değeri"
  },
  State_83627_Desc = {
    Text = "[DescArg1] Can kaybettikten sonra, 1 yığın \"Yelken Aç\" kazan."
  },
  State_83627_Name = {
    Text = "\"Yelken Aç\"İlerlemesi"
  },
  State_83805_Name = {
    Text = "Artçı Sarsıntı"
  },
  State_83807_Name = {
    Text = "Derinliklerde Batmış"
  },
  State_83808_Desc = {
    Text = "Atıldığında \"Artçı Sarsıntı\" etkisini tetikler."
  },
  State_83808_Name = {
    Text = "<RippleKeywords:Artçı Sarsıntı>"
  },
  State_83811_Desc = {
    Text = "Ek olarak %[Layer] Dokunaç Hasarı al."
  },
  State_83812_Desc = {
    Text = "Ek olarak %[Layer] Dokunaç Hasarı al."
  },
  State_83814_Desc = {
    Text = "Canavarsı Önder %10 sağlıkta"
  },
  State_83814_Name = {
    Text = "Reis yüzde on cana indiğinde"
  },
  State_84140_Desc = {
    Text = "Bu savaşta \"Gürültülü Okyanus\" aracılığıyla [Layer] \"Bez Bölünmesi\" kartı Tükendi."
  },
  State_84140_Name = {
    Text = "Gürültülü Okyanus"
  },
  State_84184_Name = {
    Text = "Ek olarak [Layer]% STR bonusu kazanır"
  },
  State_84255_Desc = {
    Text = "Takıma Özel: Savaş başında, Kuşananın SAV’ının <WeaponEffect_Num:[StateArg1]%>’ine eşit bir Karakter Kalkanı kazanırsın. Ölüm Direnci tetiklendikten sonra, bir sonraki turun başında bu Etkiyi yeniden tetikle."
  },
  State_84255_Name = {
    Text = "Deniz Kılavuzu"
  },
  State_84255_WeaponDesc = {
    Text = "Savaşın başında <WeaponEffect_Num:[Block:DescArg1]> Kalkan elde et. Ölüm Direnci tetiklendikten sonra, bir sonraki turun başında bu etkiyi yeniden tetikle."
  },
  State_84257_Desc = {
    Text = "Takıma Özel: Kuşananın Yüceltimi tarafından oluşturulan Karakter Kalkanı <WeaponEffect_Num:[StateArg1]%> artar. Yüceltim kullanıldıktan sonra, tüm Uyananların Geçici Kritik Hasarı <WeaponEffect_Num:[StateArg2]%> artar; her bir Dokunaç bu artışı %1 yükseltir. Her keşiften sonra, ilk kez Direnç tetiklenir ve bir sonraki turun başında Maksimum HP'nin <WeaponEffect_Num:[StateArg3]%>'i yenilenir."
  },
  State_84257_WeaponDesc = {
    Text = "Kuşananın Yüceltisi, <WeaponEffect_Num:[StateArg1]%> daha fazla Kalkan üretir. Yücelt kullanıldıktan sonra, tüm Uyananlar <WeaponEffect_Num:[StateArg2]%> Geçici Krit. Hasar kazanır ve her bir Dokunaç fazladan %1 sağlar. Her Keşifte ilk kez Ölüm Direnci tetiklendikten sonra, bir sonraki turun başında Maksimum CP'nin <WeaponEffect_Num:[StateArg3]%>'i kadar iyileş."
  },
  State_84272_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda, en çok HP kaybetmiş dosta <Heal:[Heal:StateArg1]> HP yenile."
  },
  State_84272_Name = {
    Text = "Deniz Kılavuzu"
  },
  State_84273_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında ve tur başında, eğer hiç <PVPProtectiveKeywords:Bariyer> yoksa, [StateArg1] yığın <PVPProtectiveKeywords:Bariyer> kazan; aksi hâlde <Energy:[Energy:StateArg2]> Aliemus kazan."
  },
  State_84273_Name = {
    Text = "Kutsal Ateşin Rehberi"
  },
  State_84364_Desc = {
    Text = "Krit. Hasar +[Layer]%."
  },
  State_84364_Name = {
    Text = "Kritik Hasar"
  },
  State_84368_Desc = {
    Text = "Kalan [Layer] tur bekleme süresi."
  },
  State_84368_Name = {
    Text = "Derinliklerde Batmış"
  },
  State_84375_Desc = {
    Text = "Tur başında [Layer] Karakter Kalkanı kazan."
  },
  State_84375_Name = {
    Text = "Deniz Kılavuzu"
  },
  State_84376_Desc = {
    Text = "Tur başında [Layer] HP iyileştir."
  },
  State_84376_Name = {
    Text = "Kutsal Ateşin Rehberi"
  },
  State_84399_Desc = {
    Text = "Her turun sonunda, alınan Hasarı %5 artır ve 2 yığın Bariyer kazan."
  },
  State_84399_Name = {
    Text = "Derinliklerde Batmış"
  },
  State_84400_Desc = {
    Text = "Sonraki turun başında, her bariyer 1 yığın <ReinforcePVEKeywords:Kale>’ye dönüştürülür."
  },
  State_84400_Name = {Text = "\"Pilot\""},
  State_84402_Desc = {
    Text = "Alınan Hasarı [Layer]% artır."
  },
  State_84402_Name = {
    Text = "Gücü Aşırı Kullanma"
  },
  State_89340_Desc = {
    Text = "Ek olarak %[Layer] Dokunaç Hasarı al."
  },
  State_89340_Name = {
    Text = "Dokunaç Hasar Açığı"
  },
  State_89422_Desc = {
    Text = "Tüm Uyananlar %100 daha fazla Aliemus üretir ve her tur 2 kez Yüceltme serbest bırakabilir."
  },
  State_89422_Name = {
    Text = "\"Boyun Eğmez Yürek\""
  },
  State_89447_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Maksimum El Boyutu + [StateArg2]. \"Taşkınlık\"tan sonra [StateArg1] Arithmetica kazan."
  },
  State_89447_Name = {
    Text = "Dayanılmaz Özgürlük"
  },
  State_89448_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda, en düşük Can ve Kalkan’a sahip müttefik [StateArg1] <PVPDerivativeCardKeywords_16:\"Oniks Tüy\"> kazanır."
  },
  State_89448_Name = {
    Text = "Yalnız Tüy"
  },
  State_89554_Name = {
    Text = "Kaderin Işık Konisi"
  },
  State_89555_Desc = {
    Text = "Takım Özgünlüğü: Kullanan Taşkınlık serbest bıraktıktan sonra, Taşkınlık Temel HSR +<WeaponEffect_Num:[StateArg1]%>, Kalkan ve HP Yenilenmesi +<WeaponEffect_Num:[StateArg2]%>, en fazla 5 kez yığılır. Keşif sırasında, kullanıcının kazandığı Afinite +<WeaponEffect_Num:[StateArg3]%>."
  },
  State_89555_WeaponDesc = {
    Text = "Kuşanan Yüceltme'yi serbest bıraktıktan sonra, Yüceltme'nin Temel Hasarı <WeaponEffect_Num:[StateArg1]%> artar, Karakter Kalkanı Üretimi ve HP Yenilenmesi <WeaponEffect_Num:[StateArg2]%> artar; bu etki en fazla 5 kez birikir. Keşif tamamlandıktan sonra, kuşananın elde ettiği Afinite <WeaponEffect_Num:[StateArg3]%> artar."
  },
  State_89557_Name = {
    Text = "Prizmatik Mercek"
  },
  State_89559_Desc = {
    Text = "\n·Varoluş Paradoksu: Keşif başladığında, ölüm direncinin %75'i maksimum can puanı bonusuna dönüştürülür; en fazla %300 ölüm direnci dönüştürülebilir ve maksimum can puanı en fazla %10 artırılabilir. Ölüm direnci her tetiklendiğinde, ele 1 adet \"Gümüş Anahtar Parıltısı\" kartı eklenir.\n·Dipsiz Yara İzi: Patron savaşında, bizim tarafımızın aldığı can yenileme miktarı can üst sınırının %100'üne her ulaştığında, sonraki can yenileme etkisi %25 azalır; ancak mevcut toplam ölüm direnci %25 artar; en fazla 3 kez tetiklenebilir.\n·Prizmatik Mercek: Tur başında, karşı saldırı can üst sınırının %2000'ini aşarsa, aşan kısım yarıya indirilir ve kalıcı karşı saldırı en fazla can üst sınırının %6000'ine kadar birikebilir; düşman zehirlenmesi can üst sınırının %3000'ini aşarsa, aşan kısım yarıya indirilir ve zehirlenme en fazla can üst sınırının %9000'ine kadar birikebilir. Uyanış bedeninin karşı saldırıdan elde ettiği hasar artışı miktarı %70 azalır; ancak verilen tüm zehirlenme ve karşı saldırı %10 artar. Her bir uyanış bedeni uyandırıldığında: Tur sonunda mevcut kalıcı karşı saldırının %25'i kadar geçici karşı saldırı elde edilir, düşman turu sonunda tüm düşmanların %25 zehirlenmesi ek olarak tetiklenir.\n·Kader Işık Konisi: Normal canavarların \"Bakış\" yeteneğini kullandığı tur sayısı 6 tura dönüşür. 15. tur başladığında, ele 1 adet \"Işık Konisi Sınırı\" kartı eklenir: Gümüş Anahtar enerjisini ve tüm uyanış bedenlerinin çılgınlık doluluk oranını maksimum değere yükseltir."
  },
  State_89559_Name = {
    Text = "Zaman Bükülmesi"
  },
  State_89567_Desc = {
    Text = "Bu Kartın Arithmetica Maliyetini [StateArg1] azalt."
  },
  State_89567_Name = {
    Text = "Küller Arasından Yeniden Doğuş"
  },
  State_89568_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Taşıyıcı öldükten sonra, Arithmetica tüketimi -[StateArg1] olan tüm \"Beceriler\"Çekme Desteği’ne karıştırılır; sahipleri, en yüksek kalan HP’ye sahip müttefik birime dönüştürülür."
  },
  State_89568_Name = {
    Text = "Küller Arasından Yeniden Doğuş"
  },
  State_89571_Name = {
    Text = "\"Yanan Tiyatro\""
  },
  State_89572_Desc = {
    Text = "Tur başında, rastgele [DescArg1] kartı <BurningKeywords:Yanma> etkisiyle el destesine ekle, [DescArg2] Geçici güç kazan. Her 2 turda bir, eklenen yanma kartlarının sayısı 1 artar ve kazanılan Geçici güç [DescArg3] artar."
  },
  State_89572_Name = {
    Text = "\"Yanan Tiyatro\""
  },
  State_89626_Desc = {
    Text = "Keyflare Nüfuz Etme'den sonra, 1 adet \"Gümüş Anahtar Işıltısı\" kartını ele al. Tüm Uyananlar uyandıktan sonra, her turun başında rastgele 1 Uyananlar Desteği kartı keşfet."
  },
  State_89631_Desc = {
    Text = "Ek [Layer] Gidiş Geliş"
  },
  State_89634_Desc = {
    Text = "Uyandırma 4"
  },
  State_89634_Name = {
    Text = "Uyandırma 4"
  },
  State_89637_Desc = {
    Text = "Her turun ilk Komut Kartı bir kez daha etkisini gösterir. Yok Oluş sırasında 1 Dokunaç üret. Dokunaç \"Azgın Gelgit\" duruşuna geçirildikten sonra, bu turda 2 Komut Kartının Sıçrama etkisi mutlaka tetiklenir ve 3 tur bekleme süresiyle Ultra Uzay’a girilir."
  },
  State_89640_Desc = {
    Text = "Diyar Ustalığı 200 puan artar. Kızıl Ocağı tüketirken Dokunaç Hasarı %15 artar. Her Dokunaç Saldırısı ile [Arg3] Kızıl Ocak biriktir."
  },
  State_89642_Desc = {
    Text = "El Limiti +2, Yücelişten sonra Geçici Final Hasar %10 artar. Kart Ultra Uzay'a girdikten sonra, eldeki 1 \"Embriyo\" \"Saflığın Varisi\"ne dönüşür. Her 1 \"Embriyo\" üretildiğinde, Ultra Uzay'daki rastgele bir kartın bedeli 1 azalır."
  },
  State_89669_Desc = {
    Text = "Anahtar Alevi Uyandırma 4"
  },
  State_89669_Name = {
    Text = "Anahtar Alevi Uyandırma 4"
  },
  State_89759_Desc = {
    Text = "Çeteyi serbest bıraktıktan sonra, Ramona %50 Geçici Kritik Oranı kazanır."
  },
  State_89759_Name = {
    Text = "Değerli Bağlar"
  },
  State_90023_Name = {
    Text = "Sabit tablo yapılandırması için kullanılan durum, geçici olarak atıldı."
  },
  State_90059_Desc = {
    Text = "Bu turda aktif veya Dokunaç Hasarı aldığında, eşit miktarda Aşınma kaldırılır ve kaldırılan miktarın [DescArg1]% kadar Can kaybedilir. Diğer hasarları aldığında ise hasarın %50'si kadar Aşınma kaldırılır."
  },
  State_90059_Name = {Text = "Aşınma"},
  State_90094_Name = {Text = "Oniks Tüy"},
  State_90218_Desc = {
    Text = "Takıma Özel: El Sınırı +2. Aynı türdeki etkiler istiflenemez. Kullanıcının Temel Hasarı ve Kalkan Üretimi <WeaponEffect_Num:[StateArg1]%> artar.\nUltra Tur’a girildiğinde <WeaponEffect_Num:[StateArg2]> Aliemus elde et.\n \"Yok Oluş\" u serbest bıraktığında tüm Uyananlara Geçici Krit. Hasar +<WeaponEffect_Num:[StateArg3]%> ver. Bu etkinin Bekleme Süresi 3 turdur."
  },
  State_90218_WeaponDesc = {
    Text = "El Sınırı +2. Aynı türdeki etkiler istiflenemez. Kullanıcının Temel Hasarı ve Kalkan Üretimi <WeaponEffect_Num:[StateArg1]%> artar.\nUltra Tur’a girildiğinde <WeaponEffect_Num:[StateArg2]> Aliemus elde et.\n \"Yok Oluş\" u serbest bıraktığında tüm Uyananlara Geçici Krit. Hasar +<WeaponEffect_Num:[StateArg3]%> ver. Bu etkinin Bekleme Süresi 3 turdur."
  },
  State_90221_Desc = {
    Text = "Takıma Özel: Kuşananın Karakter Kalkanı Üretimi <WeaponEffect_Num:[StateArg1]%> artar. Tur sonunda, kuşananın Savunmasının <WeaponEffect_Num:[StateArg2]%>'i kadar Karakter Kalkanı kazan; bu miktar her turda kuşananın Savunmasının %2'si kadar artar."
  },
  State_90221_Name = {
    Text = "Yalnız Tüy"
  },
  State_90221_WeaponDesc = {
    Text = "Kuşananın Karakter Kalkanı Üretimi <WeaponEffect_Num:[StateArg1]%> artar. Tur sonunda, <WeaponEffect_Num:[Block:DescArg1]> kadar Karakter Kalkanı kazan."
  },
  State_90294_Desc = {
    Text = "Bu turda aktif veya Dokunaç Hasarı aldığında, eşit miktarda Aşınma kaldırılır ve kaldırılan miktarın [DescArg1]% kadar Can kaybedilir. Diğer hasarları aldığında ise hasarın %50'si kadar Aşınma kaldırılır."
  },
  State_90294_Name = {
    Text = "<Corrosion:Aşınma>"
  },
  State_90591_Name = {
    Text = "Eline [Layer] adet \"Kavrayış\" kartı al"
  },
  State_90594_Name = {
    Text = "[Layer] Geçici Alarm ile"
  },
  State_90599_Name = {
    Text = "Tüm Uyananlar [Layer] Aliemus kazanır."
  },
  State_90600_Name = {
    Text = "[Layer] Keyflare puanı kazan"
  },
  State_90601_Name = {
    Text = "([DescArg1] <harmonyKeyWord: \"Seasoning\"> deneme kaldı)"
  },
  State_90603_Name = {
    Text = "[Layer] Geçici GÜÇ kazan"
  },
  State_90604_Name = {
    Text = "[Layer] HP yeniler, kaybedilen HP ile artar"
  },
  State_90696_Desc = {
    Text = "Oynamadan önce, içine yerleştirmek ve etkisini tetiklemek için 1 “Baharat” keşfet; Reis Savaşı sırasında uyumlandırma denemelerinin sayısını 1 artırır."
  },
  State_90696_Name = {
    Text = "<harmonyKeyWord:Harmanlama>"
  },
  State_91106_Desc = {
    Text = "Her bir \"Coşku\" yığını, verilen Aktif Hasar ve Dokunaç Hasarı’nın %10’unu <BleedingIconKeywords:Kan Akıtma> yığınlarına dönüştürür."
  },
  State_91106_Name = {Text = "Vahşet"},
  State_91165_Name = {
    Text = "Solgun Yumurta"
  },
  State_91235_Desc = {
    Text = "Can kaybedildiğinde, eşit sayıda yığın azaltılır. Yaralanma 0'a ulaştığında, tüm Uyandırıcılar 10 Aliemus kazanır ve Yaralanma yığınları sıfırlanır."
  },
  State_91235_Name = {Text = "Yaralanma"},
  State_91236_Name = {
    Text = "Roma Etkinliği Uygulama Boss HP Sayısı"
  },
  State_91329_Desc = {
    Text = "Bu Kartın Arithmetica Maliyetini [StateArg1] azalt."
  },
  State_91329_Name = {
    Text = "Makabre Lezzetler"
  },
  State_91521_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Tur sonunda, [StateArg1] adet <PVPDerivativeCardKeywords_17:\"Kavrayış\">ı Elde Karıştır."
  },
  State_91521_Name = {
    Text = "Özel Eğitim"
  },
  State_91522_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında ve tur sonunda, Kuşanan arka sıradaki düşmana <Damage:[Damage:StateArg1]> Hasar verir."
  },
  State_91522_Name = {
    Text = "Okul Günü"
  },
  State_91676_Desc = {
    Text = "Belirli etkiler için temel Saldırı mantığına bakın."
  },
  State_91706_Desc = {
    Text = "Bir sonraki turun başında eşit sayıda Arithmetica yığın kazan."
  },
  State_91706_Name = {
    Text = "<CardKeyWord:Arithmetica Sakla>"
  },
  State_91717_Desc = {
    Text = "En fazla 3 adet biriktirilir; üst sınıra ulaşıldığında bir sonraki \"Ölüm Şöleni\" bunları yiyip etkisini güçlendirebilir. Kalıntılar bir sonraki savaşa aktarılır."
  },
  State_91717_Name = {Text = "Ceset"},
  State_91759_Desc = {
    Text = "\"Oniks Tüy\", \"Divus: Oniks Tüy\"ün yeteneklerini güçlendirebilir."
  },
  State_91759_Name = {Text = "Oniks Tüy"},
  State_91761_Desc = {
    Text = "\"Divus: Oniks Tüy\", kırılmamış Karakter Kalkanı’nın %50’sini bir sonraki tura taşır ve tur sonunda 1 yığın <Guaiwuheiyu:Oniks Tüy> kazanır."
  },
  State_91761_Name = {
    Text = "Göklerin Yemini"
  },
  State_91797_Desc = {
    Text = "Bu kart oynanıp atıldıktan sonra, ön saftaki düşmanlara bu miktarda Karakter Kalkanı uygula."
  },
  State_91797_Name = {
    Text = "<PVPredKeyword:Örtülü Acı>"
  },
  State_91799_Desc = {
    Text = "Bu kart oynandığında, en öndeki düşmana [Layer] Karakter Kalkanı uygular."
  },
  State_91799_Name = {
    Text = "<PVPredKeyword:Örtülü Acı [Layer] >"
  },
  State_91809_Desc = {
    Text = "Bu kartın Arithmetica Maliyeti -[Layer]."
  },
  State_91809_Name = {
    Text = "Yüksek Odaklanma"
  },
  State_91819_Desc = {
    Text = "Mevcut savaş turuna göre ilgili güçlendirmeyi kazanır."
  },
  State_91819_Name = {
    Text = "<CardKeyWord:Büyüme>"
  },
  State_91827_Desc = {
    Text = "\"Darbe\" bir hedef seçebilir. \"Darbe\"den önce, hedefin tüm olumlu durum etkileri arkasındaki Uyanışçıya geri savrulur."
  },
  State_91827_Name = {
    Text = "<CardKeyWord:Derin Denizin Çağrısı>"
  },
  State_94410_Name = {
    Text = "Tur başında ve tur sonunda, boş bir oyuncu destesini sıfırlamaya çalışır. Boş olmayan bir deste sıfırlanmaz."
  },
  State_94411_Name = {
    Text = "Tur başında ve tur sonunda, boş bir oyuncu destesini sıfırlamaya çalışır. Boş olmayan bir deste sıfırlanmaz."
  },
  State_94426_Name = {
    Text = "Pasif Karakter Kalkanı"
  },
  State_94540_Desc = {
    Text = "Hedefin arkasında başka bir Uyanışçı yoksa, bunun yerine hedefin güçlendirmeleri dağıtılır."
  },
  State_94540_Name = {
    Text = "<CardKeyWord:Geri Savurma Güçlendirmeleri>"
  },
  State_94600_Desc = {
    Text = "Ölümcül Hasar alındığında 1 yük kaldır ve Maksimum HP’nin %5’ini yenile. Her tetikleniş, bu tur için iyileştirme miktarını %1 artırır."
  },
  State_94600_Name = {Text = "Direnç"},
  State_94603_Name = {
    Text = "Gulyabani Mührü"
  },
  State_94608_Name = {
    Text = "Ölüm Direnci Tetiklenme Sayısı"
  },
  State_94623_Desc = {
    Text = "Her bir \"Coşku\" yığını, verilen Aktif Hasar ve Dokunaç Hasarı’nın %10’unu <BleedingIconKeywords:Kan Akıtma> yığınlarına dönüştürür."
  },
  State_94623_Name = {
    Text = "<Kuangre:Coşku>"
  },
  State_94657_Desc = {
    Text = "Düşmanı öldürdüğünde ya da diriliş etkisini etkinleştirdiğinde, ilgili etkileri tetikle."
  },
  State_94657_Name = {
    Text = "<KillKeywords:Yok Etme>"
  },
  State_94692_Desc = {
    Text = "Ölümcül Hasar alındığında 1 yük kaldır ve Maksimum HP’nin %5’ini yenile. Her tetikleniş, bu tur için iyileştirme miktarını %1 artırır."
  },
  State_94692_Name = {
    Text = "<Guaiwusiwangdikang: Ölüm Direnci>"
  },
  State_94693_Desc = {
    Text = "Tur başında, sahnede başka müttefikler varsa, [DescArg1] CP kaybet ve en yüksek CP’ye sahip müttefiğe 1 yığın <Guaiwusiwangdikang:Ölüm Direnci> ve [DescArg2] <PowerIconKeywords:GÜÇ> ver."
  },
  State_94693_Name = {
    Text = "Leş Paylaşımı"
  },
  State_94708_Desc = {
    Text = "Tur başında, sahnede başka müttefikler varsa, [DescArg1] CP kaybet ve en yüksek CP’ye sahip müttefiğe 1 yığın <Guaiwusiwangdikang:Ölüm Direnci> ve [DescArg2] <Duren:Zehir Bıçağı> ver."
  },
  State_94708_Name = {
    Text = "Aequor'un Şöleni"
  },
  State_94730_Desc = {
    Text = "Engellenmemiş Hasar verirken, yığın başına [Layer] <IntoxicationIconKeywords:Zehir> uygula."
  },
  State_94730_Name = {
    Text = "Zehir Bıçağı"
  },
  State_94993_Desc = {
    Text = "Her turdaki Dehşet Verici Tsunami sayısını sıfırlar."
  },
  State_94993_Name = {
    Text = "Azgın Dalgalar Sayısı Sıfırlama"
  },
  State_94994_Desc = {
    Text = "Her katman saldırı sayısını 1 artırır, Kritik Hasar alındığında 1 katman kaybedilir (en az 1 katman kalır) ve turun sonunda tüm yığın kaybolur."
  },
  State_94994_Name = {
    Text = "Azgın Dalgalar Sayısı"
  },
  State_94995_Desc = {
    Text = "Her Krit. Hasar aldığında, %3 <Baojidikang:Geçici Krit. Direnci> kazan. Her Hasar verdiğinde, rastgele bir karta \"Uçurum İşareti\" uygula."
  },
  State_94995_Name = {
    Text = "Derin Deniz Ayinleri"
  },
  State_94996_Desc = {
    Text = "Hasar aldığında, eşit miktarda Geçici GÜÇ kazan."
  },
  State_94996_Name = {Text = "Öfke"},
  State_94997_Desc = {
    Text = "Her Krit. Hasar aldığında, %5 <Baojidikang:Geçici Krit. Direnci> kazan. Her Hasar verdiğinde, rastgele bir karta \"Uçurum İşareti\" uygula."
  },
  State_94997_Name = {
    Text = "Derin Deniz Ayinleri"
  },
  State_94998_Desc = {
    Text = "<Guaiwusiwangdikang:Ölüm Direnci> tetiklendiğinde, Çekme Desteği’nde veya Elde bulunan rastgele bir karta <SlowIconKeywords:Durgunluk> uygula."
  },
  State_94998_Name = {
    Text = "Umutsuzluk Bedeni"
  },
  State_94999_Desc = {
    Text = "Her tur Yutucu Dalgalar sayısını sıfırlar."
  },
  State_94999_Name = {
    Text = "Yutan Dalgalar Sayısı Sıfırlama"
  },
  State_95000_Desc = {
    Text = "Olumsuz durumlara karşı bağışıklık kazanır."
  },
  State_95000_Name = {
    Text = "Zayıflatmalara Bağışıklık"
  },
  State_95001_Desc = {
    Text = "Her katman saldırı sayısını 1 artırır, Kritik Hasar alındığında 1 katman kaybedilir (en az 1 katman kalır) ve turun sonunda tüm yığın kaybolur."
  },
  State_95001_Name = {
    Text = "Yutan Dalgalar Sayısı"
  },
  State_95002_Desc = {
    Text = "Bu tur, Kritik Vuruş ihtimali [Layer]% azalır."
  },
  State_95002_Name = {
    Text = "Geçici Krit. Direnci"
  },
  State_95002_WeaponDesc = {
    Text = "Bu tur, Kritik Vuruş ihtimali [Layer]% azalır."
  },
  State_95035_Desc = {
    Text = "Engellenmemiş Hasar verirken, yığın başına 1 <IntoxicationIconKeywords:Zehir> uygula."
  },
  State_95035_Name = {
    Text = "<Duren: Zehir Bıçağı>"
  },
  State_95038_Desc = {
    Text = "Hasar aldığında, eşit miktarda Geçici GÜÇ kazan."
  },
  State_95038_Name = {
    Text = "<Kuangbao: Öfke>"
  },
  State_95040_Desc = {
    Text = "Kayıt can kaybetti"
  },
  State_95040_Name = {
    Text = "Kayıt can kaybetti"
  },
  State_95932_Name = {
    Text = "Gulyabani Nöbeti Süzüşü"
  },
  State_95937_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Exalt\" kullandıktan sonra, öncelikle kendi \"Yetenek\" kartlarını tercih ederek [StateArg1] kart çek ve onların Arithmetica Maliyetini [StateArg2] azalt."
  },
  State_95937_Name = {
    Text = "Makabre Lezzetler"
  },
  State_95938_Desc = {
    Text = "Her kaldırılan kart için 1 Doygunluk yığını kazan, en fazla 10 yığına kadar."
  },
  State_95938_Name = {Text = "Doygunluk"},
  State_95943_Desc = {
    Text = "Verilen hasar geçici olarak %30 azalır."
  },
  State_95943_Name = {
    Text = "Doğrudan Müdahale"
  },
  State_95944_Desc = {
    Text = "Takıma Özel: Taşıyıcının Temel Hasarı +<WeaponEffect_Num:[StateArg1]%> Bu keşif boyunca, taşıyıcı her düşman öldürdüğünde, Krit. Oranı +%2 ve Yüceltme Temel Hasarı +<WeaponEffect_Num:[StateArg2]%> olur, en fazla 10 defaya kadar birikir. Mevcut Diyar Caro ise, taşıyıcı Embriyo'yu doğrudan tükettiğinde fazladan <WeaponEffect_Num:[StateArg4]> Aliemus kazanır (bekleme süresi 3 tur)."
  },
  State_95944_WeaponDesc = {
    Text = "Takıma Özel: Taşıyıcının Temel Hasarı +<WeaponEffect_Num:[StateArg1]%> Bu keşif boyunca, taşıyıcı her düşman öldürdüğünde, Krit. Oranı +%2 ve Yüceltme Temel Hasarı +<WeaponEffect_Num:[StateArg2]%> olur, en fazla 10 defaya kadar birikir. Mevcut Diyar Caro ise, taşıyıcı Embriyo'yu doğrudan tükettiğinde fazladan <WeaponEffect_Num:[StateArg4]> Aliemus kazanır (bekleme süresi 3 tur)."
  },
  State_95948_Name = {
    Text = "Gulyabani Süzüşü"
  },
  State_95949_Desc = {
    Text = "Oynandıktan sonra, Doresain <Guaiwucanhai:Enkaz>’ının yarısını kaybeder."
  },
  State_95949_Name = {Text = "Pusu"},
  State_95953_Desc = {
    Text = "Ölüm Direnci’nin İyileştirme etkisi 5 kat artar."
  },
  State_95953_Name = {
    Text = "Mırıltılar Perdesi"
  },
  State_95954_Name = {
    Text = "Gulyabani Süzüşü: Uyanmış Sürüm"
  },
  State_95960_Desc = {
    Text = "\"Enkaz\" yığınları, \"Enkaz\" Toplama etkisini güçlendirir."
  },
  State_95960_Name = {Text = "Ceset"},
  State_95962_Name = {
    Text = "Öldürme Sayısı"
  },
  State_95964_Desc = {
    Text = "Takıma Özel: Kuşananın Temel Hasarı +<WeaponEffect_Num:[StateArg1]%>. Mevcut Diyar Caro ise, kuşanan her düşman öldürdüğünde, kuşananın Saldırısının <WeaponEffect_Num:[StateArg2]%>'i kadar Kızıl Ocak biriktir."
  },
  State_95964_WeaponDesc = {
    Text = "Kuşananın Temel Hasarı +<WeaponEffect_Num:[StateArg1]%>%. Kuşanan her düşman öldürdüğünde, <WeaponEffect_Num:[DescArg1]> kadar Kızıl Ocak biriktir."
  },
  State_95966_Desc = {
    Text = "Sonraki turun başında, bu Uyanan’dan [Layer] kart çek."
  },
  State_95966_Name = {
    Text = "Zalim Saygı"
  },
  State_95967_Desc = {
    Text = "\"Enkaz\" yığınları, \"Enkaz\" Toplama etkisini güçlendirir."
  },
  State_95967_Name = {
    Text = "<Guaiwucanhai:Ceset>"
  },
  State_95968_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Kuşanıldığında [StateArg1] <StrongEffectKeywords:Güçlendirme> kazan. Kuşanan bir düşmanı öldürdüğünde, taşan Hasar arkadaki Uyandıran’a aktarılır."
  },
  State_95968_Name = {
    Text = "Huzur Öpücüğü"
  },
  State_96167_Desc = {
    Text = "Dağıtılamaz. Bir Uyanışçı öldürüldüğünde, diğer müttefikler [StateArg1] <StrongEffectKeywords:Güçlendirme> kazanır."
  },
  State_96167_Name = {
    Text = "Kara Yıldız Közü"
  },
  State_96183_Desc = {
    Text = "Tur sonunda, sahada başka müttefik yoksa, kendini patlatma moduna geç."
  },
  State_96183_Name = {
    Text = "Gulyabani Kendini İmha"
  },
  State_96193_Name = {
    Text = "Ziyafet Öncesi Ayin"
  },
  State_96330_Desc = {
    Text = "Kaybedilen her %1 CP için, Doresain’in Komut Kartlarının sağladığı Temel Hasar, Karakter Kalkanı ve Aliemus %1 artar."
  },
  State_96330_Name = {
    Text = "Hayalet Fısıltıları"
  },
  State_96352_Name = {
    Text = "Başlangıç Gulyabani Sayısı"
  },
  State_96354_Name = {
    Text = "Başlangıç Maks. HP"
  },
  State_96355_Desc = {
    Text = "Kritik Vuruş ihtimali [Layer]% azaltılır."
  },
  State_96355_Name = {
    Text = "Krit. Direnci"
  },
  State_96355_WeaponDesc = {
    Text = "Bu savaşta, Kritik Vuruş alma ihtimali [Layer]% azalır."
  },
  State_96356_Desc = {
    Text = "Kaybedilen her [DescArg1] Can için [DescArg2] yığın <ReinforcePVEKeywords:Fortress> kazan, en fazla [DescArg3] yığına kadar. \"<Guaiwusiwangdikang:Death Resistance>\" tetiklendikten sonra, hedefin maksimum Canı [DescArg4]% artar."
  },
  State_96356_Name = {
    Text = "Elena'nın Koruması"
  },
  State_96357_Desc = {
    Text = "Tur bitiminden sonra, eşit miktarda Güç yığını kazan."
  },
  State_96357_Name = {
    Text = "<Fennu:Öfke>"
  },
  State_96358_Desc = {
    Text = "Kritik Vuruş ihtimali [Layer]% azaltılır."
  },
  State_96358_Name = {
    Text = "<Baojidikang:Krit. Direnci>"
  },
  State_96412_Name = {
    Text = "Obur Canavar Dinleyicisi"
  },
  State_96416_Desc = {
    Text = "Kritik Vuruş ihtimali [Layer]% azaltılır."
  },
  State_96416_Name = {
    Text = "Krit. Direnci"
  },
  State_96603_Name = {
    Text = "Bu tur oynanmazsa, bir sonraki turun başında \"Uyum\" etkisini bir kez tetikle."
  },
  State_96610_Name = {
    Text = "İlk Ölüm Direnci"
  },
  State_96613_Name = {
    Text = "Dev Dalgaları Dinlemek"
  },
  State_96650_Desc = {
    Text = "Her yığın, tüm Uyandıranların Kritik Oranını [DescArg1]% artırır."
  },
  State_96650_Name = {
    Text = "<ExclamationPointColour:Karanlık Alev>"
  },
  State_96719_Desc = {
    Text = "Bu tur <BurningKeywords:Yanma> içeren kartlar oynarken artık <Heat:Karanlık Alev> kazanmazsın. Bunun yerine, söz konusu kartın etkisini iki kez uygulatmak için 1 yığın <Heat:Karanlık Alev> tüket. Tur sonunda tüm <Heat:Karanlık Alev>i temizle."
  },
  State_96719_Name = {
    Text = "Sonsuz Yanış"
  },
  State_96731_Desc = {
    Text = "Bu tur <BurningKeywords:Yanma> içeren kartlar oynarken artık <Heat:Karanlık Alev> kazanmazsın. Bunun yerine, söz konusu kartın etkisini iki kez uygulatmak için 1 yığın <Heat:Karanlık Alev> tüket. Tur sonunda tüm <Heat:Karanlık Alev>i temizle."
  },
  State_96731_Name = {
    Text = "<Overload:Sonsuz Yanış>"
  },
  State_96732_Desc = {
    Text = "Her yığın, tüm Uyandıranların Kritik Oranını [DescArg1]% artırır."
  },
  State_96732_Name = {
    Text = "<Heat:Karanlık Alev>"
  },
  State_96740_Desc = {
    Text = "Alınan Aktif Hasar ve Kanama yığınları +%50. Hasar alındığında veya turun başında kaldırılır."
  },
  State_96740_Name = {
    Text = "<CardKeyWord:Gedik>"
  },
  State_96741_Desc = {
    Text = "Oynandıktan sonra, kalan Arithmetica [StateArg1] değerinden büyükse, sonraki Etkileri tetiklemek için ek olarak [StateArg1] Arithmetica tüket."
  },
  State_96741_Name = {
    Text = "<CardKeyWord:Aritmetika Aşırı Yüklenme>"
  },
  State_96742_Name = {
    Text = "Arithmetica Aşırı Yükü tetiklenme işareti"
  },
  State_96743_Desc = {
    Text = "Oynandıktan sonra, kalan Arithmetica, Arithmetica Aşırı Yükü için gereken miktarı aşarsa, ek Arithmetica tüketerek sonraki etkileri tetikler."
  },
  State_96743_Name = {
    Text = "<CardKeyWord:Aritmetika Aşırı Yüklenme>"
  },
  State_96744_Desc = {
    Text = "Alınan Aktif Hasar ve Kanama yığınları +%50. Hasar alındığında veya turun başında kaldırılır."
  },
  State_96744_Name = {Text = "Gedik"},
  State_96774_Desc = {
    Text = "Her Kritik Hasar aldığında, %3 Geçici Kritik Direnci kazan."
  },
  State_96774_Name = {
    Text = "Derin Deniz Hayaleti"
  },
  State_96780_Desc = {
    Text = "Kart Saklanır, ancak oynandığında ya da atıldığında Kirliliği kaldırır ve en fazla 2 olacak şekilde 1 \"Denizci Uzantısı\" çağırır. Eğer çağrı için yer yoksa, Çürümenin Kuklası derhal [DescArg1] Güç ve [DescArg2] Can kazanır."
  },
  State_96780_Name = {
    Text = "<Kuangluan:Denizci Çılgınlığı>"
  },
  State_96783_Desc = {
    Text = "Her tur, 2 karta \"<Kuangluan:Denizci Çılgınlığı>\" uygula."
  },
  State_96783_Name = {
    Text = "Denizci Ritüeli"
  },
  State_96784_Desc = {
    Text = "Çürümüş Kuklası’nın Hücumunu azaltabilir, en fazla 5 yığına kadar."
  },
  State_96784_Name = {Text = "Kaos"},
  State_96808_Desc = {
    Text = "Kaybedilen her [DescArg1] HP için 15 yığın “<ReinforcePVEKeywords:Fortress>” kazan, en fazla 75 yığına kadar. Kırıldığında tüm yığınları kaldır ve 1 yığın “<Chaos:Chaos>” kazan. Reformasyon serbest bırakılmadıysa, Ölümcül Hasar alındığında Niyeti “Reformasyon”a çevir ve tüm hasara karşı Bağışık ol."
  },
  State_96808_Name = {
    Text = "Kimera Kuklası"
  },
  State_96809_Name = {
    Text = "Kimera'nın Kukla Sayısı"
  },
  State_96810_Desc = {
    Text = "Verilen Hasar -%25."
  },
  State_96810_Name = {
    Text = "Mırıltılar Perdesi"
  },
  State_96813_Name = {
    Text = "Yeniden İnşa İşareti"
  },
  State_97114_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Darbe\" [StateArg1] Arithmetica kazanır, \"Beceri\" Hasarı +[StateArg2]%."
  },
  State_97114_Name = {
    Text = "Yaklaşan Güneş"
  },
  State_97118_Name = {
    Text = "Hibrit Kukla Kırılma"
  },
  State_97119_Desc = {
    Text = "Kart Saklanır, ancak oynandığında ya da atıldığında Kirliliği kaldırır ve en fazla 2 olacak şekilde 1 \"Denizci Uzantısı\" çağırır. Eğer çağrı için yer yoksa, Çürümenin Kuklası derhal [DescArg1] Güç ve [DescArg2] Can kazanır."
  },
  State_97119_Name = {
    Text = "<Kuangluan:Denizci Çılgınlığı>"
  },
  State_97120_Desc = {
    Text = "Büyü Çemberi tarafından korunduğunda, tüm düşmanlardan alınan Hasar %25 azalır."
  },
  State_97120_Name = {
    Text = "Mırıltılar Perdesi"
  },
  State_97131_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Yetenek\" her 1 Arithmetica harcadığında Hasar Artışı [StateArg1]%. Öldürme gerçekleştirdikten sonra \"Taşkınlık\" Hasar Artışı [StateArg2]%, mevcut bonus [DescArg1]%."
  },
  State_97131_Name = {
    Text = "Kehribar Renkli Ölüm"
  },
  State_97134_Desc = {
    Text = "Verilen Final Hasar %50 artar."
  },
  State_97134_Name = {
    Text = "Celina'nın İlahisi"
  },
  State_97135_Desc = {
    Text = "Final Hasar +%25."
  },
  State_97135_Name = {
    Text = "Celina'nın Fısıltısı"
  },
  State_97136_Desc = {
    Text = "Final Hasar +%100"
  },
  State_97136_Name = {
    Text = "Celina'nın Aryası"
  },
  State_97137_Desc = {
    Text = "At, ardından ele dön."
  },
  State_97137_Name = {
    Text = "At, ardından ele dön"
  },
  State_97137_WeaponDesc = {
    Text = "Çekildiğinde, kendine 1 tur boyunca Zayıflık uygula. Kullanıldığında, tüm düşmanlara 1 tur boyunca Zayıflık uygula. Satılamaz."
  },
  State_97219_Desc = {
    Text = "Wanda'nın oynadığı sonraki <plural value=\"[Layer]\" singular=\"kart\" plural=\"kart\"> 1 ek kez etkili olur."
  },
  State_97219_Name = {
    Text = "Dikenlerin Kraliçesi"
  },
  State_97251_Desc = {
    Text = "Düşman Saldırıları veya tek hedefli yetenekler tarafından hedef alınamaz ya da önceliklendirilemez.\nOtomatik Kaldırma: Birim Çekicilik kazanırsa; hiç müttefik kalmazsa; herhangi bir düşman Çekicilik kazanırsa.\nEtkinleştiğinde: Mevcut Gizliliği ve tüm müttefiklerin Çekiciliğini kaldırır."
  },
  State_97251_Name = {Text = "Gizlilik"},
  State_97252_Desc = {
    Text = "Düşman Saldırıları veya tek hedefli yetenekler tarafından hedef alınamaz ya da önceliklendirilemez.\nOtomatik Kaldırma: Birim Çekicilik kazanırsa; hiç müttefik kalmazsa; herhangi bir düşman Çekicilik kazanırsa.\nEtkinleştiğinde: Mevcut Gizliliği ve tüm müttefiklerin Çekiciliğini kaldırır."
  },
  State_97252_Name = {
    Text = "<PVPSneakKeywords:Gizlilik>"
  },
  State_97339_Name = {
    Text = "Şampiyonluk Kupası"
  },
  State_97742_Desc = {
    Text = "Her Aktif Hasar alındığında, Hasar Kaynağına [Layer] <FixedDamage:Saf Hasar> verir."
  },
  State_97742_Name = {Text = "Sayaç"},
  State_97743_Desc = {
    Text = "Verilen Aktif Hasar [Layer] artar."
  },
  State_97743_Name = {
    Text = "<PowerColourKeywords:GÜÇ>"
  },
  State_97744_Desc = {
    Text = "Alınan hasar -[Layer]%."
  },
  State_97744_Name = {
    Text = "<ReinforceColour:Hisar>"
  },
  State_97744_WeaponDesc = {
    Text = "Verilen tüm Hasarı [DescArg1]% azalt."
  },
  State_97938_Desc = {
    Text = "Final Hasar [DescArg1]% artar."
  },
  State_97938_Name = {
    Text = "Şampiyonluk Kupası"
  },
  State_97939_Desc = {
    Text = "Verilen Final Hasar %50 artar."
  },
  State_97939_Name = {
    Text = "Şampiyonluk Kupası"
  },
  State_97941_Desc = {
    Text = "Temel Hasar %100 artar."
  },
  State_97941_Name = {
    Text = "Şampiyonluk Kupası"
  },
  State_97942_Desc = {
    Text = "Yüceltme kullandıktan sonra 35 Aliemus kazan."
  },
  State_97942_Name = {
    Text = "Şampiyonluk Kupası"
  },
  State_97943_Name = {
    Text = "Arithmetica Sakla Sayısı"
  },
  State_98055_Desc = {
    Text = "Tur sonunda 1 Dokunaç üret. Durum Uyanış gerçekleştiğinde kaldırılır."
  },
  State_98055_Name = {
    Text = "Mest Uykusu"
  },
  State_98060_Desc = {
    Text = "Bu Uyandırıcı hâlâ Uyanmamış... Yenilmek üzereyken Uyanacak, Canını geri kazanacak ve gerçek suretinde savaşmaya başlayacak."
  },
  State_98060_Name = {
    Text = "Uyanmamış"
  },
  State_98068_Desc = {
    Text = "\"Alevlenme\" 10 yığına ulaştığında, 2 Arithmetica kazan ve tüm \"Güneş Patlaması\"nı \"Milyar Parıltı\"ya Yükselt."
  },
  State_98068_Name = {
    Text = "<BaoyanKeywords:Alevlenme>"
  },
  State_98139_Desc = {
    Text = "<Randomly <BurningKeywords:Burn> 1 card from the opponent's hand at the start of their turn.:Rakibin turunun başında, elindeki kartlardan rastgele 1 tanesini <BurningKeywords:Yak>.>"
  },
  State_98139_Name = {
    Text = "Karma Kozu Yeniden Alevlenir"
  },
  State_98140_Desc = {
    Text = "<After accumulating 10 stacks of <MonsterExFlameKeywords:Combust>, switch intention to the extremely high-damage \"Hyperflare\"!:<MonsterExFlameKeywords:Alevlenme> 10 yığına ulaştığında, niyeti son derece yüksek Hasarlı \"Milyar Parıltı\"ya çevir!>"
  },
  State_98140_Name = {
    Text = "<BurningColor:Alevlenme>"
  },
  State_98147_Desc = {
    Text = "Düşman <BurningKeywords:Burn> içeren kartlar oynadığında, 1 yığın <MonsterExFlameKeywords:Combust> kazan, ancak geçici olarak [DescArg1] <PowerIconKeywords:STR> kaybet."
  },
  State_98147_Name = {
    Text = "Sönmeyen Alev"
  },
  State_98148_Desc = {
    Text = "<This Awakener is still not Roused... They will Rouse when about to be defeated, discard all remaining hand cards and grant <BurningKeywords:Burn>, restore HP, and fight with full power.:Bu Uyandıran hâlâ Henüz Uyanmamış… Yenilginin eşiğine geldiğinde Uyanacak, elinde kalan tüm kartları atıp <BurningKeywords:Yak> verecek, Canını yenileyecek ve tüm kudretiyle savaşacak.>"
  },
  State_98148_Name = {
    Text = "Uyanmamış"
  },
  State_98302_Desc = {
    Text = "Takıma Özel: Taşıyıcının verdiği Temel Hasar +<WeaponEffect_Num:[StateArg1]%> ve GÜÇ Üretimi +<WeaponEffect_Num:[StateArg2]%>. Taşıyıcının Komut Kartı oynandıktan sonra, taşıyıcının SLD'sinin <WeaponEffect_Num:[StateArg3]%>'ine eşit Geçici GÜÇ kazan; bu etki tur başına en fazla 5 kez tetiklenir."
  },
  State_98302_WeaponDesc = {
    Text = "Kuşananın verdiği Temel Hasar +<WeaponEffect_Num:[StateArg1]%>, ve üretilen GÜÇ +<WeaponEffect_Num:[StateArg2]%>. Kuşananın Komut Kartı oynandıktan sonra, <WeaponEffect_Num:[Power:DescArg1]> Geçici GÜÇ kazan; tur başına en fazla 5 kez tetiklenir. (şu anda [DescArg2]/5 kez tetiklendi)."
  },
  State_98323_Desc = {
    Text = "Kart atıldıktan sonra elinize geri döner"
  },
  State_98323_Name = {
    Text = "Atıldıktan sonra ele dön."
  },
  State_98341_Desc = {
    Text = "Yeni renkler yaratmak için diğer ana renklerle karıştırılabilir."
  },
  State_98341_Name = {
    Text = "<Yellow:Ana Renk: Sarı>"
  },
  State_98344_Desc = {
    Text = "Yeni renkler yaratmak için diğer ana renklerle karıştırılabilir."
  },
  State_98344_Name = {
    Text = "<Red:Ana Renk: Kırmızı>"
  },
  State_98345_Desc = {
    Text = "Yeni renkler yaratmak için diğer ana renklerle karıştırılabilir."
  },
  State_98345_Name = {
    Text = "<Blue:Ana Renk: Mavi>"
  },
  State_98366_Desc = {
    Text = "Tur başında, Keyflare [Arg1]’den büyükse, [Arg1] Keyflare tüketerek eline 1 adet <DerivativeCardKeywords_115:\"İleri Kavrayış\"> koy."
  },
  State_98435_Desc = {
    Text = "Kırmızı ve mavinin bir karışımı. Verilen her etkin hasar için <Block:[DescArg1]> Kalkan kazan."
  },
  State_98435_Name = {
    Text = "<PurpleKeyWord:Görüş Alanı: Mor>"
  },
  State_98436_Desc = {
    Text = "Kırmızı ve sarının bir karışımı. Yüceltme serbest bırakıldıktan sonra, ilgili Uyanan <Energy:15> Aliemus kazanır."
  },
  State_98436_Name = {
    Text = "<ExclamationPointColour:Görüş Alanı: Turuncu>"
  },
  State_98437_Desc = {
    Text = "Final Hasar %10 artar."
  },
  State_98437_Name = {
    Text = "<Red:Ana Renk: Kırmızı>"
  },
  State_98438_Desc = {
    Text = "Sarı ve mavinin bir karışımı. \"Savunma\" oynandıktan sonra <Heal:[DescArg1]> HP yenile."
  },
  State_98438_Name = {
    Text = "<GreenWord:Görüş Alanı: Yeşil>"
  },
  State_98439_Desc = {
    Text = "Sarı ve mavinin bir karışımı. \"Savunma\" oynandıktan sonra <Heal:[DescArg1]> HP yenile."
  },
  State_98439_Name = {
    Text = "<GreenWord:Görüş Alanı: Yeşil>"
  },
  State_98440_Desc = {
    Text = "Kırmızı ve mavinin bir karışımı. Verilen her etkin hasar için <Block:[DescArg1]> Kalkan kazan."
  },
  State_98440_Name = {
    Text = "<PurpleKeyWord:Görüş Alanı: Mor>"
  },
  State_98441_Desc = {
    Text = "Kırmızı ve sarının bir karışımı. Yüceltme serbest bırakıldıktan sonra, ilgili Uyanan <Energy:15> Aliemus kazanır."
  },
  State_98441_Name = {
    Text = "<ExclamationPointColour:Görüş Alanı: Turuncu>"
  },
  State_98444_Desc = {
    Text = "Takıma Özel: Taşıyıcının Temel Hasarı <WeaponEffect_Num:[StateArg1]%> artar. Taşıyıcıdan 5 Komut Kartı oynandıktan sonra, taşıyıcı <WeaponEffect_Num:[StateArg2]%> Geçici Kritik Oranı kazanır. Bu etki tur başına yalnızca bir kez tetiklenebilir."
  },
  State_98444_WeaponDesc = {
    Text = "Kuşananın verdiği Temel Hasar <WeaponEffect_Num:[StateArg1]%> artar. Kuşananın 5 Komut Kartı oynanmasının ardından, kuşanan [StateArg2]% Geçici Kritik Oranı kazanır ve bu etki her turda yalnızca bir kez tetiklenebilir (şu anda oynanan kart sayısı [DescArg1]/5)."
  },
  State_98466_Name = {
    Text = "<HuoyanKeywords1:Fiamma1>"
  },
  State_98468_Name = {
    Text = "<HuoyanKeywords3:Fiamma3>"
  },
  State_98470_Name = {
    Text = "<HuoyanKeywords2:Fiamma2>"
  },
  State_98474_Desc = {
    Text = "Kırmızı, sarı ve maviden oluşan, diğer renkleri oluşturmak için karıştırılabilen ana renkler."
  },
  State_98474_Name = {Text = "Ana Renk"},
  State_98484_Name = {
    Text = "Kederde Boğulmak"
  },
  State_98485_Desc = {
    Text = "Bu kartın verdiği Final Hasar ve Güç +[DescArg1]%; Kalkan ve Aliemus +[DescArg2]%. \"Sakla\" kazanır. Oynadıktan sonra, tüm \"Fiamma\" yığınlarını tüketir ve eldeki başka bir Kathigu-Ra Komut Kartına 1 \"Fiamma\" yığını aktarır."
  },
  State_98485_Name = {
    Text = "<HuoyanKeywords2:Fiamma2>"
  },
  State_98486_Desc = {
    Text = "Bu kartın verdiği Final Hasar ve Güç +[DescArg1]%; Kalkan ve Aliemus +[DescArg2]%. \"Sakla\" kazanır. Oynadıktan sonra, tüm \"Fiamma\" yığınlarını tüketir ve eldeki başka bir Kathigu-Ra Komut Kartına 1 \"Fiamma\" yığını aktarır."
  },
  State_98486_Name = {
    Text = "<HuoyanKeywords3:Fiamma3>"
  },
  State_98487_Desc = {
    Text = "Bu kartın verdiği Final Hasar ve Güç +[DescArg1]%; Kalkan ve Aliemus +[DescArg2]%. \"Sakla\" kazanır. Oynadıktan sonra, tüm \"Fiamma\" yığınlarını tüketir ve eldeki başka bir Kathigu-Ra Komut Kartına 1 \"Fiamma\" yığını aktarır."
  },
  State_98487_Name = {
    Text = "<HuoyanKeywords1:Fiamma1>"
  },
  State_98488_Desc = {
    Text = "Bu kartın sağladığı Final Hasar, Kalkan, Aliemus ve STR +%30. “Elde Tutma” kazanır. Oynandıktan sonra tüm “Fiamma” yığınlarını tüket ve eldeki başka bir Kathigu-Ra’nın Komut Kartına 1 “Fiamma” yığını aktar."
  },
  State_98488_Name = {
    Text = "<HuoyanKeywords:Fiamma>"
  },
  State_98492_Desc = {
    Text = "Keşfin başında, DAY, SAL ve SAV [StateArg1]% artar."
  },
  State_98492_Name = {
    Text = "Ruh Dövme Yeteneği"
  },
  State_98495_Desc = {
    Text = "Keşfin başında, DAY, SAL ve SAV [StateArg1]% artar."
  },
  State_98495_Name = {
    Text = "Ruh Dövme Yeteneği"
  },
  State_98507_Desc = {
    Text = "Keşfin başında, DAY, SAL ve SAV [StateArg1]% artar."
  },
  State_98507_Name = {
    Text = "Ruh Dövme Yeteneği"
  },
  State_98511_Name = {
    Text = "Türetilmiş Kart Elde Et"
  },
  State_98551_Desc = {
    Text = "Savaşın başında, Diyar Ustalığı +[Arg1]. Tek sayılı turların başında 1 kart çek. Çift sayılı turların başında 1 Arithmetica kazan."
  },
  State_98553_Desc = {
    Text = "Her 1 \"Embryo\" üretildiğinde, tur başına en fazla 3 kez olmak üzere [Arg1] Kızıl Ocak kazan."
  },
  State_98555_Desc = {
    Text = "Savaşın başında [Arg1]% Güçlendirme kazan. Her tur Zehir ilk kez uygulandığında [Arg2] kart çek."
  },
  State_98556_Desc = {
    Text = "Tüm Uyanmışların HP İyileştirme ve Karakter Kalkanı temel Etkileri [Arg1]% artar."
  },
  State_98557_Desc = {
    Text = "Her 1 \"Embryo\" üretildiğinde, tur başına en fazla 3 kez olmak üzere [Arg1] Kızıl Ocak kazan."
  },
  State_98559_Desc = {
    Text = "Her kart çektiğinde veya attığında [Arg1] Geçici GÜÇ kazan, en fazla [Arg2] Geçici GÜÇ’e kadar."
  },
  State_98560_Desc = {
    Text = "Tüm Uyananlar [Arg1]% artırılmış Temel Hasar verir. Exalt’ı serbest bırakmadan önce, Exalt’ı serbest bırakan Uyanan’ın verdiği Temel Hasar geçici olarak [Arg2]% artar."
  },
  State_98561_Desc = {
    Text = "Tur başında, HP %50’nin altındaysa, geçici olarak Hasar Güçlendirmesi +[Arg1]% kazan. HP %25’in altındaysa, [Arg2] ek kart çek ve [Arg2] Arithmetica kazan."
  },
  State_98562_Desc = {
    Text = "Aktif veya Dokunaç Hasarı verdikten sonra, hedefin aldığı Dokunaç Hasarı bu turun geri kalanı için [Arg1]% artar. Tur başına en fazla 20 kez tetiklenebilir."
  },
  State_98563_Desc = {
    Text = "Savaşın başında [Arg1] Güç kazan. Her \"Tüketme\" kartı oynadığında, en fazla [Arg3] kez olmak üzere [Arg2] Geçici GÜÇ kazan."
  },
  State_98564_Desc = {
    Text = "Exalt, tur başına en fazla 3 tetiklenme olmak üzere [Arg1] Keyflare kazanır."
  },
  State_98565_Desc = {
    Text = "Bir kart Ultra Uzay’a her girdiğinde, bu kartın sahibine ait Çekme Desteği’nden [Arg1] Komut Kartı çek. Çekilemezse, bunun yerine eşit miktarda Arithmetica kazan. Bu etki tur başına en fazla 2 kez tetiklenebilir."
  },
  State_98567_Desc = {
    Text = "Tur bitmeden önce, elde bir Komut Kartı ait olduğu her Uyanmış [Arg1] Aliemus kazanır."
  },
  State_98568_Desc = {
    Text = "Savaşın başında, Hasar Güçlendirmesi +[Arg1]% kazan. Aktif Hasar verdikten sonra, tur başına en fazla 5 ek tetiklenme olmak üzere tüm düşmanlara [Arg2] Zehir uygula."
  },
  State_98569_Desc = {
    Text = "Her tur ilk \"Posse\"ni kullandıktan sonra, tüm düşmanlara [Arg1] Zehir uygula ve [Arg2] Sayaç kazan."
  },
  State_98571_Desc = {
    Text = "Keyflare Uyandırma kullanıldıktan sonra [Arg1] HP yeniler ve [Arg2] Keyflare verir."
  },
  State_98571_Name = {
    Text = "Gezginin Şemsiyesi"
  },
  State_98572_Desc = {
    Text = "Her tur ikinci \"Posse\" serbest bırakıldığında, [Arg1] Keyflare kazan ve tüm Uyandırıcılar [Arg2] Aliemus kazansın."
  },
  State_98575_Desc = {
    Text = "Savaşın başında, Hasar Güçlendirmesi +[Arg1]% kazan. Aktif Hasar verdikten sonra, tur başına en fazla 5 ek tetiklenme olmak üzere tüm düşmanlara [Arg2] Zehir uygula."
  },
  State_98576_Desc = {
    Text = "Savaşın başında, tüm düşmanlara [Arg1] Zayıflık ve Savunmasız uygula. Bu etki \"Yok Oluş\"tan sonra da tetiklenir, ancak 3 tur bekleme süresi vardır."
  },
  State_98577_Desc = {
    Text = "Tüm Uyananlar [Arg1]% artırılmış Temel Hasar verir. Exalt’ı serbest bırakmadan önce, Exalt’ı serbest bırakan Uyanan’ın verdiği Temel Hasar geçici olarak [Arg2]% artar."
  },
  State_98579_Desc = {
    Text = "Tur başında, HP %50’nin altındaysa, geçici olarak Hasar Güçlendirmesi +[Arg1]% kazan. HP %25’in altındaysa, [Arg2] ek kart çek ve [Arg2] Arithmetica kazan."
  },
  State_98581_Desc = {
    Text = "Tüm Uyananlar, her turdaki ilk \"Komut Kartı\"ndan [Arg1] Keyflare kazanır."
  },
  State_98582_Desc = {
    Text = "\"Exalt\" her 5 kullanımından sonra, bir sonraki [Arg1] Türetilmemiş Komut Kartı 1 kez ek olarak etki eder."
  },
  State_98583_Desc = {
    Text = "Tüm Uyananlar, her turdaki ilk \"Komut Kartı\"ndan [Arg1] Keyflare kazanır."
  },
  State_98586_Desc = {
    Text = "Tur başında, Aliemus’u Exalt’ı serbest bırakmak için yetersiz olan tüm Uyananlar [Arg1] Aliemus kazanır."
  },
  State_98587_Desc = {
    Text = "Her kart çektiğinde veya attığında [Arg1] Geçici GÜÇ kazan, en fazla [Arg2] Geçici GÜÇ’e kadar."
  },
  State_98588_Desc = {
    Text = "Tur bitmeden önce, elde bir Komut Kartı ait olduğu her Uyanmış [Arg1] Aliemus kazanır."
  },
  State_98589_Desc = {
    Text = "Savaşın başında, tüm düşmanlar geçici olarak [Arg1] Güç kaybeder. \"Kızıl Ocak\" kullanmak da bu etkiyi tetikler, ancak 3 tur bekleme süresi vardır."
  },
  State_98590_Desc = {
    Text = "Savaşın başında [Arg1]% Güçlendirme kazan. Her tur Zehir ilk kez uygulandığında [Arg2] kart çek."
  },
  State_98591_Desc = {
    Text = "Her tur ilk \"Posse\"ni kullandıktan sonra, tüm düşmanlara [Arg1] Zehir uygula ve [Arg2] Sayaç kazan."
  },
  State_98596_Desc = {
    Text = "Her turdaki ilk \"Posse\", harcanan Keyflare’in [Arg1]%’ini iade eder."
  },
  State_98597_Desc = {
    Text = "Keyflare Uyandırma kullanıldıktan sonra [Arg1] HP yeniler ve [Arg2] Keyflare verir."
  },
  State_98597_Name = {
    Text = "Gezginin Şemsiyesi+"
  },
  State_98598_Desc = {
    Text = "Savaşın başında [Arg1] Güç kazan. Her \"Tüketme\" kartı oynadığında, en fazla [Arg3] kez olmak üzere [Arg2] Geçici GÜÇ kazan."
  },
  State_98600_Desc = {
    Text = "Savaşın başında, tüm düşmanlar geçici olarak [Arg1] Güç kaybeder. \"Kızıl Ocak\" kullanmak da bu etkiyi tetikler, ancak 3 tur bekleme süresi vardır."
  },
  State_98602_Desc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Her tur ilk kez Sayaç elde ettiğinde 1/2 Arithmetica kazan."
  },
  State_98603_Desc = {
    Text = "Savaşın başında, Hasar Güçlendirmesi +[Arg1]% kazan. Aktif veya Dokunaç Hasarı aldıktan sonra, tur başına en fazla 3 kez olmak üzere [Arg2] Karşı Atak kazan."
  },
  State_98604_Desc = {
    Text = "Savaşın başında, Hasar Güçlendirmesi +[Arg1]% kazan. Aktif veya Dokunaç Hasarı aldıktan sonra, tur başına en fazla 3 kez olmak üzere [Arg2] Karşı Atak kazan."
  },
  State_98606_Desc = {
    Text = "Bir kart Ultra Uzay’a her girdiğinde, bu kartın sahibine ait Çekme Desteği’nden [Arg1] Komut Kartı çek. Çekilemezse, bunun yerine eşit miktarda Arithmetica kazan. Bu etki tur başına en fazla 2 kez tetiklenebilir."
  },
  State_98607_Desc = {
    Text = "Her tur ilk \"Posse\" etkinleşmesi, tüm Dokunaç Saldırısı’nı düşmanlara karşı [Arg1] kez tetikler ve %50 Hasar verir."
  },
  State_98608_Desc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Oynanan her farklı Uyanmış Komut Kartı için, ek olarak %15/30 Geçici Hasar Güçlendirmesi kazan."
  },
  State_98610_Desc = {
    Text = "Keyflare Rouse kullanıldıktan sonra, eldeki en yüksek Arithmetica’ya sahip 2/4 kart, bir sonraki oynanışlarından önce Tutma ve Hazırlan kazanır ve 100/200 Keyflare elde eder."
  },
  State_98611_Desc = {
    Text = "Savaşın başında, Diyar Ustalığı +[Arg1]. Tek sayılı turların başında 1 kart çek. Çift sayılı turların başında 1 Arithmetica kazan."
  },
  State_98612_Desc = {
    Text = "Her turdaki ilk \"Posse\", HP ne kadar düşükse o kadar güçlü olmak üzere Geçici Hasar Güçlendirmesi +[Arg1]% verir."
  },
  State_98613_Desc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Oynanan her farklı Uyanmış Komut Kartı için, ek olarak %15/30 Geçici Hasar Güçlendirmesi kazan."
  },
  State_98614_Desc = {
    Text = "\"Exalt\" her 5 kullanımından sonra, bir sonraki [Arg1] Türetilmemiş Komut Kartı 1 kez ek olarak etki eder."
  },
  State_98615_Desc = {
    Text = "Her turdaki ilk \"Posse\", harcanan Keyflare’in [Arg1]%’ini iade eder."
  },
  State_98616_Desc = {
    Text = "Tüm Uyanmışların HP İyileştirme ve Karakter Kalkanı temel Etkileri [Arg1]% artar."
  },
  State_98617_Desc = {
    Text = "Aktif veya Dokunaç Hasarı verdikten sonra, hedefin aldığı Dokunaç Hasarı bu turun geri kalanı için [Arg1]% artar. Tur başına en fazla 20 kez tetiklenebilir."
  },
  State_98619_Desc = {
    Text = "Turun sonunda, Keyflare doluysa, [Arg1] Keyflare tüketerek eline bir \"Gümüş Anahtar Işıltısı\" ekle."
  },
  State_98621_Desc = {
    Text = "Turun sonunda, Keyflare doluysa, [Arg1] Keyflare tüketerek eline bir \"Gümüş Anahtar Şafağı\" koy."
  },
  State_98623_Desc = {
    Text = "Tur başında, Aliemus’u Exalt’ı serbest bırakmak için yetersiz olan tüm Uyananlar [Arg1] Aliemus kazanır."
  },
  State_98624_Desc = {
    Text = "Savaşın başında ve Ölüm Direnci tetiklendikten sonra [Arg1] Keyflare kazan."
  },
  State_98625_Desc = {
    Text = "Savaşın başında, tüm düşmanlara [Arg1] Zayıflık ve Savunmasız uygula. Bu etki \"Yok Oluş\"tan sonra da tetiklenir, ancak 3 tur bekleme süresi vardır."
  },
  State_98626_Desc = {
    Text = "Her turdaki ilk \"Posse\", HP ne kadar düşükse o kadar güçlü olmak üzere Geçici Hasar Güçlendirmesi +[Arg1]% verir."
  },
  State_98627_Desc = {
    Text = "Exalt, tur başına en fazla 3 tetiklenme olmak üzere [Arg1] Keyflare kazanır."
  },
  State_98628_Desc = {
    Text = "Her tur ilk \"Posse\" etkinleşmesi, tüm Dokunaç Saldırısı’nı düşmanlara karşı [Arg1] kez tetikler ve %50 Hasar verir."
  },
  State_98629_Desc = {
    Text = "Her tur ikinci \"Posse\" serbest bırakıldığında, [Arg1] Keyflare kazan ve tüm Uyandırıcılar [Arg2] Aliemus kazansın."
  },
  State_98630_Desc = {
    Text = "Savaşın başında ve Ölüm Direnci tetiklendikten sonra [Arg1] Keyflare kazan."
  },
  State_98632_Desc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Her tur ilk kez Sayaç elde ettiğinde 1/2 Arithmetica kazan."
  },
  State_98686_Desc = {
    Text = "Bir sonraki [Layer] Türetilmemiş Komut Kartı 1 kez ek olarak etki eder."
  },
  State_98686_Name = {
    Text = "Türetilmemiş Komut Kartı Çift Kullanım"
  },
  State_98739_Desc = {
    Text = "Niyet Renksiz Girdap’a dönüştürüldüğünde, Hasar örneklerinin sayısını, Durumun yığınları kadar artır ve tur sonunda Durumu temizle. 3 yığına ulaşıldığında, Niyeti derhal Renksiz Girdap’a dönüştür."
  },
  State_98739_Name = {
    Text = "Örümcek Kraliçesi'nin Öpücüğü"
  },
  State_98742_Desc = {
    Text = "%100 daha fazla Zehir uygula. Her turun sonunda <Block:[Block:DescArg1]> Karakter Kalkanı kazan."
  },
  State_98742_Name = {
    Text = "Kayıpların Yolu"
  },
  State_98743_Desc = {
    Text = "Bir tur içinde [DescArg1] Hasar aldıktan sonra 75 yığın Geçici Sur kazan, Niyeti \"Sabırsız Sadaka\" ya dönüştür, Taşlaşma etkisini kaldır ve 1 yığın \"Örümcek Kraliçesi'nin Öpücüğü\" kazan."
  },
  State_98743_Name = {Text = "Gasıp"},
  State_98752_Desc = {
    Text = "Kartı ateşe ver; oynandığında Maksimum Canın %5’i kadar Hasar verir ve tur sonunda hâlâ Elde ise Tüketme ile yok edilir."
  },
  State_98752_Name = {
    Text = "<BurningKeywords2:Yak>"
  },
  State_98752_WeaponDesc = {
    Text = "Her Durgunluk yığını, kartların Arithmetica Maliyetini 1 artırır."
  },
  State_98887_Name = {
    Text = "Kurtuluş Kandili"
  },
  State_98889_Desc = {
    Text = "Her turda ilk kez <DepleteIconKeywords:Tüketme> içeren bir Komut Kartı oynandığında, bu kartı Atılmış Kart Destesine yerleştir."
  },
  State_98889_Name = {
    Text = "Kurtuluş Kandili"
  },
  State_98912_Desc = {
    Text = "Her yığın, tüm Uyandırıcıların verdiği Final Hasar’ı %10 azaltır."
  },
  State_98912_Name = {
    Text = "<LostWay:Kayıp>"
  },
  State_98913_Desc = {
    Text = "Her yığın, tüm Uyandırıcıların verdiği Final Hasar’ı %10 azaltır."
  },
  State_98913_Name = {Text = "Kayıp"},
  State_99007_Desc = {
    Text = "Oynandıktan sonra, bu kart Atılmış Kart Destesi'ne gitmek yerine desteden kaldırılır."
  },
  State_99007_Name = {
    Text = "<DepleteIconKeywords:Tüketme>"
  },
  State_99007_WeaponDesc = {
    Text = "Oynandıktan sonra, kart Atılmış Kart Destesi’ne gitmez ve bu Savaşta tekrar kullanılamaz."
  },
  State_99053_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: Diğer müttefikler her turda ilk kez \"Yüceltme\" kullandığında [StateArg1] kart çek."
  },
  State_99053_Name = {
    Text = "Susamış Fırça"
  },
  State_99055_Desc = {
    Text = "<PVPWeaponKeywords:Kader Çarkı>: \"Taşkınlık\" sonrasında, kullanan kişiye ait [StateArg1] \"Yetenek\"i rastgele ele yerleştir ve Arithmetica Maliyetini 0'a düşür."
  },
  State_99055_Name = {
    Text = "Gerçekçilik Paradoksu"
  },
  State_99056_Desc = {
    Text = "Takıma Özel: Bir Posse Serbest Bıraktıktan sonra, Kuşanan'ın Kritik Oranı geçici olarak <WeaponEffect_Num:[StateArg1]%> artar."
  },
  State_99056_WeaponDesc = {
    Text = "Posse'yi Serbest Bırak, Kuşanan'ın Kritik Oranını geçici olarak <WeaponEffect_Num:[StateArg1]%> artır."
  },
  State_99134_Desc = {
    Text = "\"Ressam\"ın kullandığı boya. Yetenek etkilerini güçlendirir. En fazla 10 yığına kadar birikir."
  },
  State_99134_Name = {
    Text = "Fantazmatik Boya"
  },
  State_99237_Name = {
    Text = "Durum eşya Yükseliş"
  },
  State_99237_WeaponDesc = {
    Text = "Kullananın Temel Hasarı +%10. Eğer takanın Hasar Güçlendirmesi %20’yi aşarsa, Temel Hasar ayrıca +%10."
  },
  State_99238_Name = {
    Text = "Durum eşya Humus"
  },
  State_99238_WeaponDesc = {
    Text = "Kullananın Temel Hasarı +%10. Eğer takanın Hasar Güçlendirmesi %20’yi aşarsa, Temel Hasar ayrıca +%10."
  },
  State_99239_Name = {
    Text = "Durum eşya Styx"
  },
  State_99239_WeaponDesc = {
    Text = "Kullananın Temel Hasarı +%10. Eğer takanın Hasar Güçlendirmesi %20’yi aşarsa, Temel Hasar ayrıca +%10."
  },
  State_99258_Desc = {
    Text = "Takıma Özel: Her tur 2. Posse serbest bırakıldıktan sonra, Kuşanan'ın 1 Komut Kartı çekilmesi için <WeaponEffect_Num:[StateArg1]%> ihtimal vardır. Her tur Kuşanan'ın 3. Komut Kartı oynandıktan sonra, <WeaponEffect_Num:[StateArg2]> Keyflare kazan."
  },
  State_99258_WeaponDesc = {
    Text = "Her tur 2. Posse serbest bırakıldıktan sonra, Kuşanan'ın 1 Komut Kartı çekilmesi için <WeaponEffect_Num:[StateArg1]%> ihtimal vardır. Her tur Kuşanan'ın 3. Komut Kartı oynandıktan sonra, <WeaponEffect_Num:[StateArg2]> Keyflare kazan."
  },
  State_99294_Desc = {
    Text = "Tüm Uyanmışların ürettiği Aliemus [DescArg1]% artar. Tur sonunda Arithmetica ve Komut Kartları bir sonraki tura kadar saklanabilir. Görkemli Bölümler daha fazla Aliemus üretir."
  },
  State_99294_Name = {Text = "\"Sevinç\""},
  State_99295_Desc = {
    Text = "Tüm Uyanışçılar tarafından üretilen Aliemus, [StateArg1]% artar. Tur sonunda Arithmetica ve Komut Kartları bir sonraki tura kadar Sakla ile elde tutulabilir. Görkemli Bölümler daha fazla Aliemus üretir."
  },
  State_99295_Name = {Text = "\"Sevinç\""},
  State_99336_Desc = {
    Text = "\"Ressam\"ın kullandığı boya. Yetenek etkilerini güçlendirir. En fazla 10 yığına kadar birikir."
  },
  State_99336_Name = {
    Text = "<DecayDye:Serap Boyası>"
  },
  State_99533_Name = {
    Text = "Aksesuar: Bakire'nin Kozası"
  },
  State_99533_WeaponDesc = {
    Text = "Savaşın başında, eğer kullanan Kaos Diyarındansa, Saldırı +%25."
  },
  State_99534_Name = {
    Text = "Tatlı Sümüklüböcek"
  },
  State_99534_WeaponDesc = {
    Text = "Kullananın neden olduğu Kalkan Üretimi ve HP Yenilenmesi %6 artar. Eğer kullananın Diyar Ustalığı 50’den büyükse, Kalkan Üretimi ve HP Yenilenmesi ek olarak %6 daha artar."
  },
  State_99640_Desc = {
    Text = "Pickman şu anda 10 Yaratıcılık yığınına sahipse, Yüceltim kullandıktan sonra tüm Yaratıcılık yığınlarını tüket. Tüm Uyananlar 15 Aliemus kazanır. 1 \"Fantezi\" yığını kazan. Pickman en fazla 10 Yaratıcılık yığını tutabilir. Bir sonraki savaşa devredilebilir."
  },
  State_99640_Name = {
    Text = "Yaratıcılık"
  },
  State_99723_Desc = {
    Text = "Takıma Özel: Kullanıcının Aliemus ve KUV Üretimi +<WeaponEffect_Num:[StateArg1]%>. Yüceliş serbest bırakıldıktan sonra, bu turda diğer Uyananların Yücelişlerinden gelen Final Hasar, Kalkan ve İyileştirme +<WeaponEffect_Num:[StateArg2]%>. Bu Yüceliş \"Yutma\"yı tetiklediyse, kullanıcı <WeaponEffect_Num:[StateArg3]> Aliemus kazanır."
  },
  State_99723_WeaponDesc = {
    Text = "Kuşananın ürettiği Aliemus ve Güç <WeaponEffect_Num:[StateArg1]%> artar. Exalt serbest bırakıldıktan sonra, bu turda diğer Uyananların Exalt’larının Final Hasar, Kalkan ve İyileştirme etkileri +<WeaponEffect_Num:[StateArg2]%> olur. Eğer bu Exalt \"Yutma\" yı tetiklediyse, kuşanan <WeaponEffect_Num:[StateArg3]> Aliemus kazanır."
  }
})
return Text_State
