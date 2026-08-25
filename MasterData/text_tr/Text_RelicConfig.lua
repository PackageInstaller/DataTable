__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_RelicConfig = readonly({
  RelicConfig_100300_BattleDesc = {
    Text = "Savaşın başında 1 yığın \"<MindWall:Ruh Kalesi>\" kazan ve 3 tur sonra bunu \"<BarrierCrash:Çöküş>\"e dönüştür."
  },
  RelicConfig_100300_Desc = {
    Text = "Savaşın başında 1 yığın \"<MindWall:Ruh Kalesi>\" kazan ve 3 tur sonra bunu \"<BarrierCrash:Çöküş>\"e dönüştür."
  },
  RelicConfig_100300_Name = {
    Text = "Ruh Analizi"
  },
  RelicConfig_100300_StoryDesc = {
    Text = "Kalbine dikkatle bak ve yanlış Seçim yapma."
  },
  RelicConfig_100399_BattleDesc = {
    Text = "<DevouredIconKeywords:Yutma> etkisi tetiklendikten sonra, diğer Uyananlar [Arg1] Aliemus kazanır. Tur başına bir kez tetiklenir."
  },
  RelicConfig_100399_Desc = {
    Text = "<DevouredIconKeywords:Yutma> etkisi tetiklendikten sonra, diğer Uyananlar [Arg1] Aliemus kazanır. Tur başına bir kez tetiklenir."
  },
  RelicConfig_100399_Name = {
    Text = "<OrangeQuality:Boyalı Altın Hayal+>"
  },
  RelicConfig_100399_StoryDesc = {
    Text = "Dönüşüm günü, senin kıyametin olacak."
  },
  RelicConfig_100400_BattleDesc = {
    Text = "Tur sonunda [Heal:Arg1] HP yenile."
  },
  RelicConfig_100400_Desc = {
    Text = "Tur sonunda [Heal:Arg1] HP yenile."
  },
  RelicConfig_100400_Name = {
    Text = "<OrangeQuality:Boyalı Kutsal Kan+>"
  },
  RelicConfig_100400_StoryDesc = {
    Text = "Tatlı ve yumuşak; gül kokulu."
  },
  RelicConfig_100401_BattleDesc = {
    Text = "HP kaybedildiğinde, kaybedilen HP’nin [Arg1]%’i kadar Kızıl Ocak biriktir."
  },
  RelicConfig_100401_Desc = {
    Text = "HP kaybedildiğinde, kaybedilen HP’nin [Arg1]%’i kadar Kızıl Ocak biriktir."
  },
  RelicConfig_100401_Name = {
    Text = "<OrangeQuality:Boyalı Paslı Testere+>"
  },
  RelicConfig_100401_StoryDesc = {
    Text = "Otopsi doktoru, hayatını hiç güzel bir kadın görmeden, yalnızca kemik yığınları, iltihaplı sinirler, kaslar ve hastalıkların yol açtığı dokularla geçirir."
  },
  RelicConfig_100402_BattleDesc = {
    Text = "Alındığında, tüm düşmanlara [Arg1] yığın <VulnerabilityIconKeywords:Vulnerable> uygula. Tüm Uyananların verdiği Temel Hasar +[Arg2]%."
  },
  RelicConfig_100402_Desc = {
    Text = "Alındığında, tüm düşmanlara [Arg1] yığın <VulnerabilityIconKeywords:Vulnerable> uygula. Tüm Uyananların verdiği Temel Hasar +[Arg2]%."
  },
  RelicConfig_100402_Name = {
    Text = "<WhiteQuality:Boyalı Bahar Ayini>"
  },
  RelicConfig_100402_StoryDesc = {
    Text = "Gecenin kahkahaları arasında, kano silueti gölün üzerinde zahmetsizce süzülür."
  },
  RelicConfig_100404_BattleDesc = {
    Text = "\"Exalt\" serbest bırakıldıktan sonra, [Arg1] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_100404_Desc = {
    Text = "\"Exalt\" serbest bırakıldıktan sonra, [Arg1] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_100404_Name = {
    Text = "<WhiteQuality:Boyalı Demir Kilit>"
  },
  RelicConfig_100404_StoryDesc = {
    Text = "Kalın ve sağlam bir kilit, anahtar olmadan açılması güç.\nElbette, usta bir hırsız için bunun hiçbir önemi yok."
  },
  RelicConfig_100405_BattleDesc = {
    Text = "Alındığında, tüm düşmanlara [Arg1] yığın <WeaknessIconKeywords:Weakness> uygula. Tüm Uyananların verdiği Temel Hasar +[Arg2]%."
  },
  RelicConfig_100405_Desc = {
    Text = "Alındığında, tüm düşmanlara [Arg1] yığın <WeaknessIconKeywords:Weakness> uygula. Tüm Uyananların verdiği Temel Hasar +[Arg2]%."
  },
  RelicConfig_100405_Name = {
    Text = "<WhiteQuality:Boyalı Kötücül Çocuk>"
  },
  RelicConfig_100405_StoryDesc = {
    Text = "Saf kötülükten doğdu, her ne kadar bu kendi iradesi olmasa da."
  },
  RelicConfig_100406_BattleDesc = {
    Text = "<DevouredIconKeywords:Yutma> etkisi tetiklendikten sonra, diğer Uyananlar [Arg1] Aliemus kazanır. Tur başına bir kez tetiklenir."
  },
  RelicConfig_100406_Desc = {
    Text = "<DevouredIconKeywords:Yutma> etkisi tetiklendikten sonra, diğer Uyananlar [Arg1] Aliemus kazanır. Tur başına bir kez tetiklenir."
  },
  RelicConfig_100406_Name = {
    Text = "<WhiteQuality:Boyalı Altın Hayal>"
  },
  RelicConfig_100406_StoryDesc = {
    Text = "Dönüşüm günü, senin kıyametin olacak."
  },
  RelicConfig_100407_BattleDesc = {
    Text = "Her Hasar verildiğinde [Arg1] Geçici <PowerIconKeywords:STR> kazan, tur başına en fazla 15 kez."
  },
  RelicConfig_100407_Desc = {
    Text = "Her Hasar verildiğinde [Arg1] Geçici <PowerIconKeywords:STR> kazan, tur başına en fazla 15 kez."
  },
  RelicConfig_100407_Name = {
    Text = "<WhiteQuality:Boyalı Telkâri Akik>"
  },
  RelicConfig_100407_StoryDesc = {
    Text = "Muhtemelen sıradan akik desenleridir. Belki."
  },
  RelicConfig_100408_BattleDesc = {
    Text = "\"Exalt\" serbest bırakıldıktan sonra, [Arg1] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_100408_Desc = {
    Text = "\"Exalt\" serbest bırakıldıktan sonra, [Arg1] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_100408_Name = {
    Text = "<OrangeQuality:Boyalı Demir Kilit+>"
  },
  RelicConfig_100408_StoryDesc = {
    Text = "Kalın ve sağlam bir kilit, anahtar olmadan açılması güç.\nElbette, usta bir hırsız için bunun hiçbir önemi yok."
  },
  RelicConfig_100409_BattleDesc = {
    Text = "Alındığında, tüm düşmanlara [Arg1] yığın <WeaknessIconKeywords:Weakness> uygula. Tüm Uyananların verdiği Temel Hasar +[Arg2]%."
  },
  RelicConfig_100409_Desc = {
    Text = "Alındığında, tüm düşmanlara [Arg1] yığın <WeaknessIconKeywords:Weakness> uygula. Tüm Uyananların verdiği Temel Hasar +[Arg2]%."
  },
  RelicConfig_100409_Name = {
    Text = "<OrangeQuality:Boyalı Kötücül Çocuk+>"
  },
  RelicConfig_100409_StoryDesc = {
    Text = "Saf kötülükten doğdu, her ne kadar bu kendi iradesi olmasa da."
  },
  RelicConfig_100410_BattleDesc = {
    Text = "Her Hasar verildiğinde [Arg1] Geçici <PowerIconKeywords:STR> kazan, tur başına en fazla 15 kez."
  },
  RelicConfig_100410_Desc = {
    Text = "Her Hasar verildiğinde [Arg1] Geçici <PowerIconKeywords:STR> kazan, tur başına en fazla 15 kez."
  },
  RelicConfig_100410_Name = {
    Text = "<OrangeQuality:Boyalı Telkâri Akik+>"
  },
  RelicConfig_100410_StoryDesc = {
    Text = "Muhtemelen sıradan akik desenleridir. Belki."
  },
  RelicConfig_100411_BattleDesc = {
    Text = "Alındığında, tüm düşmanlara [Arg1] yığın <VulnerabilityIconKeywords:Vulnerable> uygula. Tüm Uyananların verdiği Temel Hasar +[Arg2]%."
  },
  RelicConfig_100411_Desc = {
    Text = "Alındığında, tüm düşmanlara [Arg1] yığın <VulnerabilityIconKeywords:Vulnerable> uygula. Tüm Uyananların verdiği Temel Hasar +[Arg2]%."
  },
  RelicConfig_100411_Name = {
    Text = "<OrangeQuality:Boyalı Bahar Ayini+>"
  },
  RelicConfig_100411_StoryDesc = {
    Text = "Gecenin kahkahaları arasında, kano silueti gölün üzerinde zahmetsizce süzülür."
  },
  RelicConfig_100412_BattleDesc = {
    Text = "Tur sonunda [Heal:Arg1] HP yenile."
  },
  RelicConfig_100412_Desc = {
    Text = "Tur sonunda [Heal:Arg1] HP yenile."
  },
  RelicConfig_100412_Name = {
    Text = "<WhiteQuality:Boyalı Kutsal Kan>"
  },
  RelicConfig_100412_StoryDesc = {
    Text = "Tatlı ve yumuşak; gül kokulu."
  },
  RelicConfig_100413_BattleDesc = {
    Text = "HP kaybedildiğinde, kaybedilen HP’nin [Arg1]%’i kadar Kızıl Ocak biriktir."
  },
  RelicConfig_100413_Desc = {
    Text = "HP kaybedildiğinde, kaybedilen HP’nin [Arg1]%’i kadar Kızıl Ocak biriktir."
  },
  RelicConfig_100413_Name = {
    Text = "<WhiteQuality:Boyalı Paslı Testere>"
  },
  RelicConfig_100413_StoryDesc = {
    Text = "Otopsi doktoru, hayatını hiç güzel bir kadın görmeden, yalnızca kemik yığınları, iltihaplı sinirler, kaslar ve hastalıkların yol açtığı dokularla geçirir."
  },
  RelicConfig_100539_BattleDesc = {
    Text = "Her turda ilk kez \"Embriyo\" yu doğrudan kullandıktan sonra, turun geri kalanında Aktif Hasar, verdiği Hasarın [Arg1]%’i kadar <BleedingIconKeywords:Kan Akıtma> uygular."
  },
  RelicConfig_100539_Desc = {
    Text = "Her turda ilk kez \"Embriyo\" yu doğrudan kullandıktan sonra, turun geri kalanında Aktif Hasar, verdiği Hasarın [Arg1]%’i kadar <BleedingIconKeywords:Kan Akıtma> uygular."
  },
  RelicConfig_100539_Name = {
    Text = "<WhiteQuality:Boyalı Kanlı Çakıl>"
  },
  RelicConfig_100539_StoryDesc = {
    Text = "Bir, İki, Üç, Dört, Beş."
  },
  RelicConfig_100540_BattleDesc = {
    Text = "Her turda ilk kez \"Embriyo\" yu doğrudan kullandıktan sonra, turun geri kalanında Aktif Hasar, verdiği Hasarın [Arg1]%’i kadar <BleedingIconKeywords:Kan Akıtma> uygular."
  },
  RelicConfig_100540_Desc = {
    Text = "Her turda ilk kez \"Embriyo\" yu doğrudan kullandıktan sonra, turun geri kalanında Aktif Hasar, verdiği Hasarın [Arg1]%’i kadar <BleedingIconKeywords:Kan Akıtma> uygular."
  },
  RelicConfig_100540_Name = {
    Text = "<OrangeQuality:Boyalı Kanlı Çakıl+>"
  },
  RelicConfig_100540_StoryDesc = {
    Text = "Bir, İki, Üç, Dört, Beş."
  },
  RelicConfig_116382_BattleDesc = {
    Text = "Paslı anahtarların bir demeti. Kapıları açmak için kullanılabilir."
  },
  RelicConfig_116382_Desc = {
    Text = "Paslı anahtarların bir demeti. Kapıları açmak için kullanılabilir."
  },
  RelicConfig_116382_Name = {
    Text = "Paslı Anahtar"
  },
  RelicConfig_116383_BattleDesc = {
    Text = "Paslı anahtarların bir demeti. Kapıları açmak için kullanılabilir."
  },
  RelicConfig_116383_Desc = {
    Text = "Paslı anahtarların bir demeti. Kapıları açmak için kullanılabilir."
  },
  RelicConfig_116383_Name = {
    Text = "Paslı Anahtar"
  },
  RelicConfig_116384_BattleDesc = {
    Text = "Paslı anahtarların bir demeti. Kapıları açmak için kullanılabilir."
  },
  RelicConfig_116384_Desc = {
    Text = "Paslı anahtarların bir demeti. Kapıları açmak için kullanılabilir."
  },
  RelicConfig_116384_Name = {
    Text = "Paslı Anahtar"
  },
  RelicConfig_119371_BattleDesc = {
    Text = "El Sınırı +1.\nTur başında, eğer tüm ritüeller tamamlanmadıysa, Maksimum Canın %10’una eşit <SacrificeKeyWord:Kurban> çek. Ele 1 \"<DerivativeCardKeywords_119:İlahi Adanmışlık>\" koy, elde en fazla 1 tutulabilir."
  },
  RelicConfig_119371_Desc = {
    Text = "El Sınırı +1.\nTur başında, eğer tüm ritüeller tamamlanmadıysa, Maksimum Canın %10’una eşit <SacrificeKeyWord:Kurban> çek. Ele 1 \"<DerivativeCardKeywords_119:İlahi Adanmışlık>\" koy, elde en fazla 1 tutulabilir."
  },
  RelicConfig_119371_Name = {
    Text = "Pirinç Buhurdan"
  },
  RelicConfig_119371_StoryDesc = {
    Text = "\"Bu buhurdan, Lemurya’nın işçiliği taklit edilerek yapıldı; her gece huzurla uyumana yardım etsin. Miryam’dan.\""
  },
  RelicConfig_120372_BattleDesc = {
    Text = "El Sınırı +[Arg1]. Her turun başında, [Arg2] \"<PVPDerivativeCardKeywords_11:Eşitsiz Takas>\" elde edilir."
  },
  RelicConfig_120372_Desc = {
    Text = "El Sınırı +[Arg1]. Her turun başında, [Arg2] \"<PVPDerivativeCardKeywords_11:Eşitsiz Takas>\" elde edilir."
  },
  RelicConfig_120372_Name = {
    Text = "<OrangeQuality:Kaleydoskop>"
  },
  RelicConfig_120373_BattleDesc = {
    Text = "İlk [Arg1] \"<PVPWeaponKeywords:WoD>\" kartının Arithmetica Maliyeti sırasıyla -5/-3/-1/+1’dir. WoD kartı oynadıktan sonra 1 kart çek."
  },
  RelicConfig_120373_Desc = {
    Text = "İlk [Arg1] \"<PVPWeaponKeywords:WoD>\" kartının Arithmetica Maliyeti sırasıyla -5/-3/-1/+1’dir. WoD kartı oynadıktan sonra 1 kart çek."
  },
  RelicConfig_120373_Name = {
    Text = "<OrangeQuality:Mythag Nişanı>"
  },
  RelicConfig_121214_BattleDesc = {
    Text = "Hasara Bağışıklık"
  },
  RelicConfig_121214_Desc = {
    Text = "Hasara Bağışıklık"
  },
  RelicConfig_121214_Name = {
    Text = "Yenilmez Test Kalıntısı"
  },
  RelicConfig_121689_BattleDesc = {
    Text = "Final Hasarı %250 artır. Her Hasar verildiğinde, bu bonus %50 azalır (en fazla 5 kez), buna karşılık Karakter Kalkanı Üretimi %10 artar. Her tur başında sıfırlanır."
  },
  RelicConfig_121689_Desc = {
    Text = "Final Hasarı %250 artır. Her Hasar verildiğinde, bu bonus %50 azalır (en fazla 5 kez), buna karşılık Karakter Kalkanı Üretimi %10 artar. Her tur başında sıfırlanır."
  },
  RelicConfig_121689_Name = {
    Text = "<OrangeQuality:\"Gümüş Dönüş: Doğuş\">"
  },
  RelicConfig_121690_BattleDesc = {
    Text = "Savaşın başında, 3 kart seç ve onlara şu yeteneği bahşet: \"<RippleKeywords:Aftershock>: Bir kart çek ve [Arg3] Geçici <PowerIconKeywords:STR> kazan.\" Turun başında, <RippleKeywords:Aftershock> sahibi 2 kart çek; tüm <RippleKeywords:Aftershock> etkileri bir kez daha tetiklenir. <RippleKeywords:Aftershock> 10 kez tetiklendikten sonra, eline 1 <DerivativeCardKeywords_1:Kayıp Gölgelerin Yankısı> koy."
  },
  RelicConfig_121690_Desc = {
    Text = "Savaşın başında, 3 kart seç ve onlara şu yeteneği bahşet: \"<RippleKeywords:Aftershock>: Bir kart çek ve [Arg3] Geçici <PowerIconKeywords:STR> kazan.\" Turun başında, <RippleKeywords:Aftershock> sahibi 2 kart çek; tüm <RippleKeywords:Aftershock> etkileri bir kez daha tetiklenir. <RippleKeywords:Aftershock> 10 kez tetiklendikten sonra, eline 1 <DerivativeCardKeywords_1:Kayıp Gölgelerin Yankısı> koy."
  },
  RelicConfig_121690_Name = {
    Text = "<OrangeQuality:\"Gümüş Dönüş·Çılgınlık\">"
  },
  RelicConfig_121691_BattleDesc = {
    Text = "Tüm Uyananların Yüceltme Final Hasarı +%100. Her Uyanan Yüceltme kullandığında, söz konusu Uyananın Temel Aliemus'unun %500'ü kadar Keyflare elde et ve tüm Uyananların Temel Aliemus'unu 5 kezle sınırlı olmak üzere 20 azalt."
  },
  RelicConfig_121691_Desc = {
    Text = "Tüm Uyananların Yüceltme Final Hasarı +%100. Her Uyanan Yüceltme kullandığında, söz konusu Uyananın Temel Aliemus'unun %500'ü kadar Keyflare elde et ve tüm Uyananların Temel Aliemus'unu 5 kezle sınırlı olmak üzere 20 azalt."
  },
  RelicConfig_121691_Name = {
    Text = "<OrangeQuality:\"Gümüş Dönüş: Korku\">"
  },
  RelicConfig_121692_BattleDesc = {
    Text = "Tüm Uyanış sahipleri tarafından üretilen <RetaliateIconKeywords:Sayaç>, <IntoxicationIconKeywords:Zehir>, Karakter Kalkanı ve HP Yenilenmesi etkileri %50 artar. Tur sonunda, mevcut Karakter Kalkanının %500’üne eşit Geçici <RetaliateIconKeywords:Sayaç> kazan."
  },
  RelicConfig_121692_Desc = {
    Text = "Tüm Uyanış sahipleri tarafından üretilen <RetaliateIconKeywords:Sayaç>, <IntoxicationIconKeywords:Zehir>, Karakter Kalkanı ve HP Yenilenmesi etkileri %50 artar. Tur sonunda, mevcut Karakter Kalkanının %500’üne eşit Geçici <RetaliateIconKeywords:Sayaç> kazan."
  },
  RelicConfig_121692_Name = {
    Text = "<OrangeQuality:\"Gümüş Dönüş: Sapkınlık\">"
  },
  RelicConfig_121693_BattleDesc = {
    Text = "Maksimum El Boyutu +5. Turunun başında 2 kart çek ve 2 Arithmetica kazan. Deste her sıfırlandığında, [Arg3] <PowerIconKeywords:STR> ve [Arg4] Geçici <AlertIconKeywords:Alert> kazan; en yüksek Aliemus’a sahip Uyanan için her bir Türetilmemiş Komut Kartı’ndan 1 tane üret, Çekme Desteği’ne yerleştir ve Arithmetica Maliyeti’ni 1 azalt."
  },
  RelicConfig_121693_Desc = {
    Text = "Maksimum El Boyutu +5. Turunun başında 2 kart çek ve 2 Arithmetica kazan. Deste her sıfırlandığında, [Arg3] <PowerIconKeywords:STR> ve [Arg4] Geçici <AlertIconKeywords:Alert> kazan; en yüksek Aliemus’a sahip Uyanan için her bir Türetilmemiş Komut Kartı’ndan 1 tane üret, Çekme Desteği’ne yerleştir ve Arithmetica Maliyeti’ni 1 azalt."
  },
  RelicConfig_121693_Name = {
    Text = "<OrangeQuality:\"Gümüş Dönüş: Zarar\">"
  },
  RelicConfig_121694_BattleDesc = {
    Text = "Her turun başında, tüm Uyanış sahipleri 25 Aliemus kazanır ve Elleri’ne bir <DerivativeCardKeywords_4:Kavrayış> çeker. “Exalt” 4 kez serbest bırakıldıktan sonra, tüm Uyanış sahiplerinden <Seal:Mühürlü> durumu kaldır ve onlara 50 Aliemus ver."
  },
  RelicConfig_121694_Desc = {
    Text = "Her turun başında, tüm Uyanış sahipleri 25 Aliemus kazanır ve Elleri’ne bir <DerivativeCardKeywords_4:Kavrayış> çeker. “Exalt” 4 kez serbest bırakıldıktan sonra, tüm Uyanış sahiplerinden <Seal:Mühürlü> durumu kaldır ve onlara 50 Aliemus ver."
  },
  RelicConfig_121694_Name = {
    Text = "<OrangeQuality:\"Gümüş Dönüş: Hile\">"
  },
  RelicConfig_121695_BattleDesc = {
    Text = "Savaşın başında [Arg4] <PowerIconKeywords:STR> kazan ve Keyflare Üst Sınırını %100 artır. Tüketilen her 1 Arithmetica başına kazanılan Keyflare %100 artar. Keyflare Rouse kullandıktan veya Posse’yi Serbest Bırak’tıktan sonra, mevcut <PowerIconKeywords:STR>’nin %20’sine eşit Geçici <PowerIconKeywords:STR> kazan ve tüm Uyananlara 20 Aliemus ver."
  },
  RelicConfig_121695_Desc = {
    Text = "Savaşın başında [Arg4] <PowerIconKeywords:STR> kazan ve Keyflare Üst Sınırını %100 artır. Tüketilen her 1 Arithmetica başına kazanılan Keyflare %100 artar. Keyflare Rouse kullandıktan veya Posse’yi Serbest Bırak’tıktan sonra, mevcut <PowerIconKeywords:STR>’nin %20’sine eşit Geçici <PowerIconKeywords:STR> kazan ve tüm Uyananlara 20 Aliemus ver."
  },
  RelicConfig_121695_Name = {
    Text = "<OrangeQuality:\"Gümüş Dönüş: Keder\">"
  },
  RelicConfig_122625_BattleDesc = {
    Text = "Savaşın başında, [Arg1] \"<PVPDerivativeCardKeywords_25:Sylvia'nın Kırmızı Çayı>\" elde edilir."
  },
  RelicConfig_122625_Desc = {
    Text = "Savaşın başında, [Arg1] \"<PVPDerivativeCardKeywords_25:Sylvia'nın Kırmızı Çayı>\" elde edilir."
  },
  RelicConfig_122625_Name = {
    Text = "<OrangeQuality:Seylan Çayı>"
  },
  RelicConfig_122626_BattleDesc = {
    Text = "Her tur, [Arg1] \"<PVPDerivativeCardKeywords_14:Gerçeklik Taklidi>\" rastgele bir Uyandırma sahibine ait olacak şekilde Çekme Desteğine karıştır."
  },
  RelicConfig_122626_Desc = {
    Text = "Her tur, [Arg1] \"<PVPDerivativeCardKeywords_14:Gerçeklik Taklidi>\" rastgele bir Uyandırma sahibine ait olacak şekilde Çekme Desteğine karıştır."
  },
  RelicConfig_122626_Name = {
    Text = "<OrangeQuality:Gizemli Eldivenler>"
  },
  RelicConfig_122627_BattleDesc = {
    Text = "Her tur oynanan ilk “Yetenek”in Hasarı, İyileştirmesi ve Karakter Kalkanı +[Arg1]%."
  },
  RelicConfig_122627_Desc = {
    Text = "Her tur oynanan ilk “Yetenek”in Hasarı, İyileştirmesi ve Karakter Kalkanı +[Arg1]%."
  },
  RelicConfig_122627_Name = {
    Text = "<OrangeQuality:Kızıl Broş>"
  },
  RelicConfig_122628_BattleDesc = {
    Text = "Tur sonunda, fazladan <Energy:[Arg1]> Aliemus kazan."
  },
  RelicConfig_122628_Desc = {
    Text = "Tur sonunda, fazladan <Energy:[Arg1]> Aliemus kazan."
  },
  RelicConfig_122628_Name = {
    Text = "<OrangeQuality:Kâbus Tezahürü>"
  },
  RelicConfig_122629_BattleDesc = {
    Text = "Çekme Desteğinde iki kat Uyanışçı kartı bulunur. Bir kart oynadıktan sonra, bu turda eldeki kart sayısı ilk kez [Arg1]’in altına düştüğünde [Arg2] kart çek."
  },
  RelicConfig_122629_Desc = {
    Text = "Çekme Desteğinde iki kat Uyanışçı kartı bulunur. Bir kart oynadıktan sonra, bu turda eldeki kart sayısı ilk kez [Arg1]’in altına düştüğünde [Arg2] kart çek."
  },
  RelicConfig_122629_Name = {
    Text = "<OrangeQuality:Neşeli Plak>"
  },
  RelicConfig_122630_BattleDesc = {
    Text = "El Sınırı +[Arg1]. Her tur, [Arg2] \"<PVPDerivativeCardKeywords_13:Funus Aeternum>\" Çekme Desteğine yerleştirilir."
  },
  RelicConfig_122630_Desc = {
    Text = "El Sınırı +[Arg1]. Her tur, [Arg2] \"<PVPDerivativeCardKeywords_13:Funus Aeternum>\" Çekme Desteğine yerleştirilir."
  },
  RelicConfig_122630_Name = {
    Text = "<OrangeQuality:Ritüel Hançeri>"
  },
  RelicConfig_122768_BattleDesc = {
    Text = "Tur başında, Arithmetica Maliyeti -1 olan [Arg1] adet \"Darbe\" kartı çek. Yüceltme serbest bırakıldıktan sonra, ilgili Uyanan’a ait [Arg2] adet \"Darbe\" kartı üret; bu kartlar <DepleteIconKeywords:Tüketme>, <PrepareKeypvewords:Hazırlan 1> ve <RetainIconKeywords:Elde Tut> kazanır.\n1 tur içinde oynanan her [Arg3] \"Darbe\" için, [Arg4] Geçici <PowerIconKeywords:STR> kazan; [Arg5] \"Darbe\" kartı oynadıktan sonra [Arg6] kart çek ve [Arg7] Arithmetica kazan; [Arg8] \"Darbe\" kartı oynadıktan sonra, tüm Uyananlar [Arg9] Aliemus kazanır."
  },
  RelicConfig_122768_Desc = {
    Text = "Tur başında, Arithmetica Maliyeti -1 olan [Arg1] adet \"Darbe\" kartı çek. Yüceltme serbest bırakıldıktan sonra, ilgili Uyanan’a ait [Arg2] adet \"Darbe\" kartı üret; bu kartlar <DepleteIconKeywords:Tüketme>, <PrepareKeypvewords:Hazırlan 1> ve <RetainIconKeywords:Elde Tut> kazanır.\n1 tur içinde oynanan her [Arg3] \"Darbe\" için, [Arg4] Geçici <PowerIconKeywords:STR> kazan; [Arg5] \"Darbe\" kartı oynadıktan sonra [Arg6] kart çek ve [Arg7] Arithmetica kazan; [Arg8] \"Darbe\" kartı oynadıktan sonra, tüm Uyananlar [Arg9] Aliemus kazanır."
  },
  RelicConfig_122768_Name = {
    Text = "Öte Dünyadan Yankılar"
  },
  RelicConfig_122768_StoryDesc = {
    Text = "Başka bir dünyanın sisinde birbirine karışan Yankılar; bükülmeye, deliliğe ve inkâr edilemez bir gerçekliğe yol açar."
  },
  RelicConfig_123724_BattleDesc = {
    Text = "Tur başında, Mouchette [Arg1] Aliemus kazanır ve Arithmetica Maliyeti 0 olan 1 adet Geçici Darbe üretir. “Dramatik Karşılaşma” her tetiklendiğinde, “Parlayan☆Kasırga”nın Temel Hasar ve Darbe Hasarı artış etkisini bu savaş için [Arg2]% yükselt."
  },
  RelicConfig_123724_Desc = {
    Text = "Tur başında, Mouchette [Arg1] Aliemus kazanır ve Arithmetica Maliyeti 0 olan 1 adet Geçici Darbe üretir. “Dramatik Karşılaşma” her tetiklendiğinde, “Parlayan☆Kasırga”nın Temel Hasar ve Darbe Hasarı artış etkisini bu savaş için [Arg2]% yükselt."
  },
  RelicConfig_123724_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Mouchette>"
  },
  RelicConfig_125488_BattleDesc = {
    Text = "Her Uyandırma sahibi, her tur ilk kez bir Komut Kartı oynadığında [Arg1] Aliemus kazanır. Bir turda farklı Uyandırma sahiplerine ait 4 Komut Kartı oynadıktan sonra, tüm düşmanlara takımınızın Maksimum Canının [Arg2]%’i kadar <IntoxicationIconKeywords:Zehir> uygula."
  },
  RelicConfig_125488_Desc = {
    Text = "Her Uyandırma sahibi, her tur ilk kez bir Komut Kartı oynadığında [Arg1] Aliemus kazanır. Bir turda farklı Uyandırma sahiplerine ait 4 Komut Kartı oynadıktan sonra, tüm düşmanlara takımınızın Maksimum Canının [Arg2]%’i kadar <IntoxicationIconKeywords:Zehir> uygula."
  },
  RelicConfig_125488_Name = {
    Text = "Cariye Kibrinin"
  },
  RelicConfig_125489_BattleDesc = {
    Text = "Tur başında, Xu [Arg1] Aliemus kazanır ve tüm düşmanlara 1 yığın <WitherKeywords:Büyülenmiş> uygular. Xu’nun her tur oynadığı ilk Komut Kartı \"Rezonans\" etkisini tetikler."
  },
  RelicConfig_125489_Desc = {
    Text = "Tur başında, Xu [Arg1] Aliemus kazanır ve tüm düşmanlara 1 yığın <WitherKeywords:Büyülenmiş> uygular. Xu’nun her tur oynadığı ilk Komut Kartı \"Rezonans\" etkisini tetikler."
  },
  RelicConfig_125489_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Xu>"
  },
  RelicConfig_126673_BattleDesc = {
    Text = "Maksimum El Boyutu +3. Her tur oynanan ilk 3 Türetilmemiş Komut Kartı’nı kaydet ve 3 tur sonra, turun başında, onların Arithmetica Maliyeti’ni 1 azaltıp <DepleteIconKeywords:Tüketme> ile kopyalarını eline ekle."
  },
  RelicConfig_126673_Desc = {
    Text = "Maksimum El Boyutu +3. Her tur oynanan ilk 3 Türetilmemiş Komut Kartı’nı kaydet ve 3 tur sonra, turun başında, onların Arithmetica Maliyeti’ni 1 azaltıp <DepleteIconKeywords:Tüketme> ile kopyalarını eline ekle."
  },
  RelicConfig_126673_Name = {
    Text = "Orbis Fatum"
  },
  RelicConfig_126673_StoryDesc = {
    Text = "Çark sonsuza dek döner."
  },
  RelicConfig_129304_BattleDesc = {
    Text = "<OrangeQuality:Altın Uyumu>: \"Arithmetica Uyumu\" artık yalnızca Arithmetica Maliyetini 1 artırır. Her %1 Hasar Güçlendirmesi, Okült Araştırma Derinliğini %1 artırır.\n<OrangeQuality:Boyutsal Armağan>: Keşfin başında 1 rastgele Boyutsal Görüntü Kalıntısı kazan. El Sınırı +1.\n<RedQuality:Gidiş Geliş Yorgunluğu>: Savaşta tüm HP Yenilenmesi etkileri %50 azalır. \"Solmuş Kemik\"te \"Defin\" seçildiğinde, etkisi Maksimum HP'nin %25'ini yenileyecek şekilde değişir.\n<OrangeQuality:Lütuflanmış Ayin>: 1., 2. ve 3. Aşama Bosslarını yenme ödülleri, 3 Lütuflanmış Kalıntı arasından seçimle değiştirilir. \n<RedQuality:Hareket Vertigosu>: Tüm Uyananlar savaşa, Mevcut Karakter Çılgınlığı ve Keyflare'lerinin %50 eksiğiyle başlar. \n<RedQuality:Ebedigece Hattı>: Tüm Uyananlar keşfin başında Temel Karakter Çılgınlığı ve Keyflare Üst Sınırlarına +%100 kazanır."
  },
  RelicConfig_129304_Desc = {
    Text = "<OrangeQuality:Altın Uyumu>: \"Arithmetica Uyumu\" artık yalnızca Arithmetica Maliyetini 1 artırır. Her %1 Hasar Güçlendirmesi, Okült Araştırma Derinliğini %1 artırır.\n<OrangeQuality:Boyutsal Armağan>: Keşfin başında 1 rastgele Boyutsal Görüntü Kalıntısı kazan. El Sınırı +1.\n<RedQuality:Gidiş Geliş Yorgunluğu>: Savaşta tüm HP Yenilenmesi etkileri %50 azalır. \"Solmuş Kemik\"te \"Defin\" seçildiğinde, etkisi Maksimum HP'nin %25'ini yenileyecek şekilde değişir.\n<OrangeQuality:Lütuflanmış Ayin>: 1., 2. ve 3. Aşama Bosslarını yenme ödülleri, 3 Lütuflanmış Kalıntı arasından seçimle değiştirilir. \n<RedQuality:Hareket Vertigosu>: Tüm Uyananlar savaşa, Mevcut Karakter Çılgınlığı ve Keyflare'lerinin %50 eksiğiyle başlar. \n<RedQuality:Ebedigece Hattı>: Tüm Uyananlar keşfin başında Temel Karakter Çılgınlığı ve Keyflare Üst Sınırlarına +%100 kazanır."
  },
  RelicConfig_129304_Name = {
    Text = "<OrangeQuality:Küçük N'in Kaotik Kamerası>"
  },
  RelicConfig_129304_StoryDesc = {
    Text = "Hayır! Tamamen hurdaya dönmüş! Bekle... hâlâ çalışıyor mu? Ama şu kısıtlamaların hepsine bak!"
  },
  RelicConfig_129305_BattleDesc = {
    Text = "<OrangeQuality:Altın Uyumu>: \"Arithmetica Uyumu\" artık yalnızca Arithmetica Maliyetini 1 artırır. Her %1 Hasar Güçlendirmesi, Okült Araştırma Derinliğini %1 artırır.\n<RedQuality:Gidiş Geliş Yorgunluğu>: Savaşta tüm HP Yenilenmesi etkileri %50 azaltılır. \"Solmuş Kemik\"te \"Gömü\" seçildiğinde, etkisi Maksimum HP’nin %25’ini yenileyecek şekilde değişir."
  },
  RelicConfig_129305_Desc = {
    Text = "<OrangeQuality:Altın Uyumu>: \"Arithmetica Uyumu\" artık yalnızca Arithmetica Maliyetini 1 artırır. Her %1 Hasar Güçlendirmesi, Okült Araştırma Derinliğini %1 artırır.\n<RedQuality:Gidiş Geliş Yorgunluğu>: Savaşta tüm HP Yenilenmesi etkileri %50 azaltılır. \"Solmuş Kemik\"te \"Gömü\" seçildiğinde, etkisi Maksimum HP’nin %25’ini yenileyecek şekilde değişir."
  },
  RelicConfig_129305_Name = {
    Text = "<OrangeQuality:Küçük N'in Lekesiz Kamerası>"
  },
  RelicConfig_129305_StoryDesc = {
    Text = "Daha ötesini arama—aradığın şey tam olarak bu! Yepyeni, fabrika çıkışlı ve tatmini garanti."
  },
  RelicConfig_129306_BattleDesc = {
    Text = "<OrangeQuality:Altın Uyumu>: \"Arithmetica Uyumu\" artık yalnızca Arithmetica Maliyetini 1 artırır. Her %1 Hasar Güçlendirmesi, Okült Araştırma Derinliğini %1 artırır.\n<OrangeQuality:Boyutsal Hediye>: Keşfin başında 1 rastgele Boyutsal Görüntü Kalıntısı kazan. El Sınırı +1.\n<RedQuality:Gidiş Geliş Yorgunluğu>: Savaştaki tüm HP yenilenmesi etkileri %50 azaltılır. \"Solmuş Kemik\"te \"Gömü\" seçildiğinde, etkisi Maks. HP'nin %25'ini yenileyecek şekilde değişir.\n<RedQuality:Hareket Vertigosu>: Tüm Uyananlar savaşa, Mevcut Karakter Çılgınlığı ve Keyflare'ları %50 eksik olarak başlar."
  },
  RelicConfig_129306_Desc = {
    Text = "<OrangeQuality:Altın Uyumu>: \"Arithmetica Uyumu\" artık yalnızca Arithmetica Maliyetini 1 artırır. Her %1 Hasar Güçlendirmesi, Okült Araştırma Derinliğini %1 artırır.\n<OrangeQuality:Boyutsal Hediye>: Keşfin başında 1 rastgele Boyutsal Görüntü Kalıntısı kazan. El Sınırı +1.\n<RedQuality:Gidiş Geliş Yorgunluğu>: Savaştaki tüm HP yenilenmesi etkileri %50 azaltılır. \"Solmuş Kemik\"te \"Gömü\" seçildiğinde, etkisi Maks. HP'nin %25'ini yenileyecek şekilde değişir.\n<RedQuality:Hareket Vertigosu>: Tüm Uyananlar savaşa, Mevcut Karakter Çılgınlığı ve Keyflare'ları %50 eksik olarak başlar."
  },
  RelicConfig_129306_Name = {
    Text = "<OrangeQuality:Küçük N'in Yıpranmış Kamerası>"
  },
  RelicConfig_129306_StoryDesc = {
    Text = "Mahvolmuş! Kamera kırılmış! Bakayım, tamir edebilir miyim... ah, açılıyor! Ama neden şimdi bu kadar tuhaf hissettiriyor?"
  },
  RelicConfig_131079_BattleDesc = {
    Text = "Tur başında Vortice [Arg1] Aliemus kazanır. Her tur oynanan ilk \"Şarj!\" veya \"Yeniden Doldur!\" iki kez Etki gösterir."
  },
  RelicConfig_131079_Desc = {
    Text = "Tur başında Vortice [Arg1] Aliemus kazanır. Her tur oynanan ilk \"Şarj!\" veya \"Yeniden Doldur!\" iki kez Etki gösterir."
  },
  RelicConfig_131079_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Vortice>"
  },
  RelicConfig_131080_BattleDesc = {
    Text = "İlk 3 turun başında, tur başına bir kez \"Su Samurunun İkilemi\"ni tetikle. 5. turun başında, \"Su Samurunun İkilemi\"nin tüm olumsuz etkilerini kaldır ve <DerivativeCardKeywords_135:\"Coalsie ŞAPLAK!\"> kazan."
  },
  RelicConfig_131080_Desc = {
    Text = "İlk 3 turun başında, tur başına bir kez \"Su Samurunun İkilemi\"ni tetikle. 5. turun başında, \"Su Samurunun İkilemi\"nin tüm olumsuz etkilerini kaldır ve <DerivativeCardKeywords_135:\"Coalsie ŞAPLAK!\"> kazan."
  },
  RelicConfig_131080_Name = {Text = "Coalsie II"},
  RelicConfig_131080_StoryDesc = {
    Text = "Bayan Vortice bunun bir Kalıntı olduğunda ısrar ediyor.\n\"Kötü adam! Isır onu!\""
  },
  RelicConfig_131178_BattleDesc = {
    Text = "Savaş başlangıcında, desteye bir \"<DerivativeCardKeywords_134:Yasak Hakikat>\" Karıştır. Her tur Çekme +[Arg1]. Bir Komut Kartı oynadıktan sonra, rakibin elindeki [Arg2] Komut Kartı'na rastgele <ErosionColorInkKeywords:Algı Bükülmesi> ver."
  },
  RelicConfig_131178_Desc = {
    Text = "Savaş başlangıcında, desteye bir \"<DerivativeCardKeywords_134:Yasak Hakikat>\" Karıştır. Her tur Çekme +[Arg1]. Bir Komut Kartı oynadıktan sonra, rakibin elindeki [Arg2] Komut Kartı'na rastgele <ErosionColorInkKeywords:Algı Bükülmesi> ver."
  },
  RelicConfig_131178_Name = {
    Text = "Ogai’nin Notları"
  },
  RelicConfig_131178_StoryDesc = {
    Text = "Kayıtta 70 Mason asal sayısı bulunuyor."
  },
  RelicConfig_132540_BattleDesc = {
    Text = "Hasara Bağışıklık"
  },
  RelicConfig_132540_Name = {
    Text = "Koleksiyon Test Kalıntısı"
  },
  RelicConfig_13740_BattleDesc = {
    Text = "Kritik Oranı +%15. Tur başında HP %25’in ([Arg1]) altındaysa, o tur için Kritik Oranı ayrıca +%30."
  },
  RelicConfig_13740_Desc = {
    Text = "Kritik Oranı +%15. Tur başında HP %25’in altındaysa, o tur için Kritik Oranı ayrıca +%30."
  },
  RelicConfig_13740_Name = {
    Text = "<OrangeQuality:Göksel Usturlap>"
  },
  RelicConfig_13740_StoryDesc = {
    Text = "Evrenin harikaları."
  },
  RelicConfig_13741_BattleDesc = {
    Text = "Krit. Hasar +%15. Karakter Kalkanı olan düşmanlara karşı garantili Kritik Vuruş."
  },
  RelicConfig_13741_Desc = {
    Text = "Krit. Hasar +%15. Karakter Kalkanı olan düşmanlara karşı garantili Kritik Vuruş."
  },
  RelicConfig_13741_Name = {
    Text = "<WhiteQuality:Estetik İlkeleri>"
  },
  RelicConfig_13741_StoryDesc = {
    Text = "Wax Heykeltıraş: Doktorun asistanı, cenazecinin hamisi ve mezar kurtlarının sağlayıcısı."
  },
  RelicConfig_13742_BattleDesc = {
    Text = "Krit. Hasar +%50. Her üçüncü Saldırı mutlaka bir Kritik Vuruş olur."
  },
  RelicConfig_13742_Desc = {
    Text = "Krit. Hasar +%50. Her üçüncü Saldırı mutlaka bir Kritik Vuruş olur."
  },
  RelicConfig_13742_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Meditasyon\">"
  },
  RelicConfig_13743_BattleDesc = {
    Text = "Tur başında, en az Aliemus’a sahip Uyandıran 15 Aliemus kazanır. Art arda oynanan 2 kartın Arithmetica Maliyeti, bir önceki karttan düşük olduğunda, en az Aliemus’a sahip Uyandıran 15 Aliemus kazanır."
  },
  RelicConfig_13743_Desc = {
    Text = "Tur başında, en az Aliemus’a sahip Uyandıran 15 Aliemus kazanır. Art arda oynanan 2 kartın Arithmetica Maliyeti, bir önceki karttan düşük olduğunda, en az Aliemus’a sahip Uyandıran 15 Aliemus kazanır."
  },
  RelicConfig_13743_Name = {
    Text = "<OrangeQuality:Arkana Kalıntısı>"
  },
  RelicConfig_13743_StoryDesc = {
    Text = "Kaderin Sonu"
  },
  RelicConfig_13744_BattleDesc = {
    Text = "Tur başlarken, en az Aliemus’a sahip Uyandıran 15 Aliemus kazanır."
  },
  RelicConfig_13744_Desc = {
    Text = "Tur başlarken, en az Aliemus’a sahip Uyandıran 15 Aliemus kazanır."
  },
  RelicConfig_13744_Name = {
    Text = "<WhiteQuality:Defne Yaprağı Kol Düğmeleri>"
  },
  RelicConfig_13744_StoryDesc = {
    Text = "Üzerine zeytin çiçeği yaprağı desenleri işlenmiş gümüş kol düğmeleri.\nİnce işçilikli ve ışıl ışıl; bir zamanlar iki çocuğun dostluğunu cisimleştiriyorlardı."
  },
  RelicConfig_13745_BattleDesc = {
    Text = "Önerilen Diyarın güçlendirme etkisi %50 artırılır ve seviye başladığında Şanslı Orison Oranın iki katına çıkar."
  },
  RelicConfig_13745_Desc = {
    Text = "Önerilen Diyarın güçlendirme etkisi %50 artırılır ve seviye başladığında Şanslı Orison Oranın iki katına çıkar."
  },
  RelicConfig_13745_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Derin Uyku\">"
  },
  RelicConfig_13747_BattleDesc = {
    Text = "Ölüme bir kez Bağışıklık kazan, tetiklendikten sonra anında HP’nin %10’unu geri kazan; 3 tetiklemeden sonra kalıcı olarak devre dışı kalır."
  },
  RelicConfig_13747_Desc = {
    Text = "Ölüme bir kez Bağışıklık kazan, tetiklendikten sonra anında HP’nin %10’unu geri kazan; 3 tetiklemeden sonra kalıcı olarak devre dışı kalır."
  },
  RelicConfig_13747_Name = {
    Text = "<WhiteQuality:☆Rasyon Paketi☆>"
  },
  RelicConfig_13747_StoryDesc = {
    Text = "Bunu yalnızca son çare olarak ye."
  },
  RelicConfig_13748_BattleDesc = {
    Text = "Savaşın başında, mevcut Arithmetica Maliyeti 1 olan tüm kartlar bu savaş için +[Arg1] DMG ve +[Arg2] Karakter Kalkanı Üretimi kazanır."
  },
  RelicConfig_13748_Desc = {
    Text = "Savaşın başında, mevcut Arithmetica Maliyeti 1 olan tüm kartlar bu savaş için +[Arg1] DMG ve +[Arg2] Karakter Kalkanı Üretimi kazanır."
  },
  RelicConfig_13748_Name = {
    Text = "<OrangeQuality:Saf Yürekli Mary>"
  },
  RelicConfig_13748_StoryDesc = {
    Text = "Mantık bir kokteyl gibidir; fazlası, faydasını azaltır."
  },
  RelicConfig_13749_BattleDesc = {
    Text = "Her 4 turda bir, o tur boyunca tüm düşmanların aldığı Aktif ve Dokunaç Hasarı’nı ikiye katla. Ancak o turda Yüceltme serbest bırakıldıktan sonra, tüm Uyanış sahiplerini 1 tur boyunca mühürle."
  },
  RelicConfig_13749_Desc = {
    Text = "Her 4 turda bir, o tur boyunca tüm düşmanların aldığı Aktif ve Dokunaç Hasarı’nı ikiye katla. Ancak o turda Yüceltme serbest bırakıldıktan sonra, tüm Uyanış sahiplerini 1 tur boyunca mühürle."
  },
  RelicConfig_13749_Name = {
    Text = "<RedQuality:Yol Yürüyenin Kalıntıları>"
  },
  RelicConfig_13749_StoryDesc = {
    Text = "Kutsal bir parça.\nBedenden ayrılmış olsa da, ayak izleri dünyaya yayılmış durumda."
  },
  RelicConfig_13750_BattleDesc = {
    Text = "Tur sonunda, eğer Karakter Kalkanı yoksa, tek bir DMG örneğine bağışıklık tanıyan 1 yığın <ParcloseIconKeywords:Barrier> kazan. Bu Etki her Savaşta yalnızca bir kez tetiklenir."
  },
  RelicConfig_13750_Desc = {
    Text = "Tur sonunda, eğer Karakter Kalkanı yoksa, tek bir DMG örneğine bağışıklık tanıyan 1 yığın <ParcloseIconKeywords:Barrier> kazan. Bu Etki her Savaşta yalnızca bir kez tetiklenir."
  },
  RelicConfig_13750_Name = {
    Text = "<WhiteQuality:☆Ağrı Kesici Haplar☆>"
  },
  RelicConfig_13750_StoryDesc = {
    Text = "Etkisi tek seferlik bir çözüm değildir."
  },
  RelicConfig_13751_BattleDesc = {
    Text = "Kritik Oranı +%25; her tur verilen ilk Hasar ikiye katlanır."
  },
  RelicConfig_13751_Desc = {
    Text = "Kritik Oranı +%25; her tur verilen ilk Hasar ikiye katlanır."
  },
  RelicConfig_13751_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Derinleştirme\">"
  },
  RelicConfig_13752_BattleDesc = {
    Text = "Tur başında, [Arg1] HP yenile. HP %50’nin altındaysa, bunun yerine [Arg2] HP yenile."
  },
  RelicConfig_13752_Desc = {
    Text = "Tur başında, [Arg1] HP yenile. HP %50’nin altındaysa, bunun yerine [Arg2] HP yenile."
  },
  RelicConfig_13752_Name = {
    Text = "<WhiteQuality:Kutsanmış Kan>"
  },
  RelicConfig_13752_StoryDesc = {
    Text = "Tatlı ve yumuşak; gül kokulu."
  },
  RelicConfig_13753_BattleDesc = {
    Text = "Bu, hiçbir etkisi olmayan bir görev kutsal eşyasıdır."
  },
  RelicConfig_13753_Desc = {
    Text = "Bu, hiçbir etkisi olmayan bir görev kutsal eşyasıdır."
  },
  RelicConfig_13753_Name = {
    Text = "Görev Kutsal Eşyası Testi"
  },
  RelicConfig_13753_StoryDesc = {
    Text = "Ek içerik gerektiren bir Kutsal Eşya."
  },
  RelicConfig_13754_BattleDesc = {
    Text = "Beşinci Saldırın her zaman Krit. Hasar verir."
  },
  RelicConfig_13754_Desc = {
    Text = "Beşinci Saldırın her zaman Krit. Hasar verir."
  },
  RelicConfig_13754_Name = {
    Text = "<WhiteQuality:Görüş Düzeltici>"
  },
  RelicConfig_13754_StoryDesc = {
    Text = "Bir zamanlar biri onun aracılığıyla Gerçek’i keşfetti."
  },
  RelicConfig_13755_BattleDesc = {
    Text = "Tur başında, <DimensionalSpaceIconKeywords:Ultra Uzay> içindeki her kart için [Arg1] Geçici <PowerIconKeywords:STR> kazan. Bu tur bir Ultra Tur ise, [Arg2] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13755_Desc = {
    Text = "Tur başında, <DimensionalSpaceIconKeywords:Ultra Uzay> içindeki her kart için [Arg1] Geçici <PowerIconKeywords:STR> kazan. Bu tur bir Ultra Tur ise, [Arg2] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13755_Name = {
    Text = "<WhiteQuality:Üçgen Prizma>"
  },
  RelicConfig_13755_StoryDesc = {
    Text = "\"Işık yedi Ana Renkten oluşur.\""
  },
  RelicConfig_13756_BattleDesc = {
    Text = "Alındığında diğer tüm yadigârları kaybet. Rastgele 2 Altın Yadigâr kazan."
  },
  RelicConfig_13756_Desc = {
    Text = "Alındığında diğer tüm yadigârları kaybet. Rastgele 2 Altın Yadigâr kazan."
  },
  RelicConfig_13756_Name = {
    Text = "<RedQuality:☆Ters Bakış☆>"
  },
  RelicConfig_13756_StoryDesc = {
    Text = "Bu tuhaf çağda, çiçekler İnsanlığın Işığı’nın başlıca seyircileridir.\nKıpırdama; sessiz sergileri tercih ederler."
  },
  RelicConfig_13757_BattleDesc = {
    Text = "Oynadığın her 8. Komut Kartı iki kez Etki gösterir."
  },
  RelicConfig_13757_Desc = {
    Text = "Oynadığın her 8. Komut Kartı iki kez Etki gösterir."
  },
  RelicConfig_13757_Name = {
    Text = "<OrangeQuality:Yıldız Demlemesi>"
  },
  RelicConfig_13757_StoryDesc = {
    Text = "Yıldızların Arasında dolaşmak."
  },
  RelicConfig_13758_BattleDesc = {
    Text = "Alındığında Maksimum HP’yi [Arg1] artırır ve saldırıya uğradığında kazanılan Aliemus’u 2 artırır."
  },
  RelicConfig_13758_Desc = {
    Text = "Alındığında Maksimum HP’yi [Arg1] artırır ve saldırıya uğradığında kazanılan Aliemus’u 2 artırır."
  },
  RelicConfig_13758_Name = {
    Text = "<WhiteQuality:Ballı Mürekkep>"
  },
  RelicConfig_13758_StoryDesc = {
    Text = "Bazıları bunun şeytanın kanı olduğunu söyler, ama neyse, bir dene!"
  },
  RelicConfig_13759_BattleDesc = {
    Text = "Taşkınlığı serbest bırakırken, düşmanların verdiği her bir DMG örneği için [Arg1] yığın <IntoxicationIconKeywords:Poison> uygula."
  },
  RelicConfig_13759_Desc = {
    Text = "Taşkınlığı serbest bırakırken, düşmanların verdiği her bir DMG örneği için [Arg1] yığın <IntoxicationIconKeywords:Poison> uygula."
  },
  RelicConfig_13759_Name = {
    Text = "<WhiteQuality:☆Radyum Çene Kemiği☆>"
  },
  RelicConfig_13759_StoryDesc = {
    Text = "Özel bir koleksiyoncunun sergi odasında teşhir edilirdi.\nKoleksiyoncuyu güzel floresansı büyülemişti; gece gündüz onu seyretti, ta ki sonunda solup giderek onun türünden biri olana dek."
  },
  RelicConfig_13760_BattleDesc = {
    Text = "Maksimum Arithmetica +1. Art arda, Arithmetica Maliyeti bir önceki karttan daha yüksek olan 2 kart oynadığında, 1 Arithmetica kazan."
  },
  RelicConfig_13760_Desc = {
    Text = "Maksimum Arithmetica +1. Art arda, Arithmetica Maliyeti bir önceki karttan daha yüksek olan 2 kart oynadığında, 1 Arithmetica kazan."
  },
  RelicConfig_13760_Name = {
    Text = "<OrangeQuality:Arcana Arşivi>"
  },
  RelicConfig_13760_StoryDesc = {
    Text = "Kaderin akışı."
  },
  RelicConfig_13761_BattleDesc = {
    Text = "Tur başında, önceki turda elde 3'ten fazla kart kaldıysa 2 Arithmetica kazan."
  },
  RelicConfig_13761_Desc = {
    Text = "Tur başında, önceki turda elde 3'ten fazla kart kaldıysa 2 Arithmetica kazan."
  },
  RelicConfig_13761_Name = {
    Text = "<WhiteQuality:Mythag Nişanı>"
  },
  RelicConfig_13761_StoryDesc = {
    Text = "Mythag Üniversitesi tarafından Müfettişlere dağıtılan rozetler. Yalnızca taşıyanın kimliğini simgelemekle kalmaz, aynı zamanda uzaktan iletişim aracı olarak da hizmet ederler."
  },
  RelicConfig_13762_BattleDesc = {
    Text = "\"Savunma\" oyna, [Arg1] <RetaliateIconKeywords:Counter> kazan."
  },
  RelicConfig_13762_Desc = {
    Text = "\"Savunma\" oyna, [Arg1] <RetaliateIconKeywords:Counter> kazan."
  },
  RelicConfig_13762_Name = {
    Text = "Mutasyona Uğramış Isırgan Yeleği"
  },
  RelicConfig_13762_StoryDesc = {
    Text = "Bulaşmış olan sıvı tespit edilemiyor."
  },
  RelicConfig_13763_BattleDesc = {
    Text = "Savaşın başında [Arg1] Karakter Kalkanı kazan.\nEğer turun başında Karakter Kalkanın varsa, o tur Karakter Kalkanı ve İyileştirme Güçlendirmesi +%50 olur."
  },
  RelicConfig_13763_Desc = {
    Text = "Savaşın başında [Arg1] Karakter Kalkanı kazan.\nEğer turun başında Karakter Kalkanın varsa, o tur Karakter Kalkanı ve İyileştirme Güçlendirmesi +%50 olur."
  },
  RelicConfig_13763_Name = {
    Text = "Yabancılaşmış Bahçenin Muhafızı"
  },
  RelicConfig_13764_BattleDesc = {
    Text = "Kalıcı olarak [Arg1] <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13764_Desc = {
    Text = "Kalıcı olarak [Arg1] <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13764_Name = {
    Text = "<WhiteQuality:Kızıl Broş>"
  },
  RelicConfig_13764_StoryDesc = {
    Text = "Taze kırmızının bir izi sızıyor."
  },
  RelicConfig_13766_BattleDesc = {
    Text = "Alındığında, bir kart seç ve ona üç seçenekli iki Güçlendirme Etkisi uygula. (Not: Bin Serap kart üretimine benzer)"
  },
  RelicConfig_13766_Desc = {
    Text = "Alındığında, bir kart seç ve ona üç seçenekli iki Güçlendirme Etkisi uygula. (Not: Bin Serap kart üretimine benzer)"
  },
  RelicConfig_13766_Name = {
    Text = "<OrangeQuality:☆Usta Daktilo☆>"
  },
  RelicConfig_13766_StoryDesc = {
    Text = "Söylentiye göre, o başyapıtın gerçek yazarı aslında daktilonun ta kendisidir."
  },
  RelicConfig_13767_BattleDesc = {
    Text = "Alındığında, rastgele seçilen 3 İleri Dua arasından 1 tane kazan ve onu ilgili karta ata."
  },
  RelicConfig_13767_Desc = {
    Text = "Alındığında, rastgele seçilen 3 İleri Dua arasından 1 tane kazan ve onu ilgili karta ata."
  },
  RelicConfig_13767_Name = {
    Text = "<WhiteQuality:Rhind Papirüsü>"
  },
  RelicConfig_13767_StoryDesc = {
    Text = "İşte soru: 10 rahip hazretleri 6 somun ekmeği paylaşır. Her rahip hazretlerine ne kadar düşer?"
  },
  RelicConfig_13768_BattleDesc = {
    Text = "Maksimum Arithmetica 2 artar. \"Saldırı\" veya \"Savunma\" oynadıktan sonra, ilgili Uyanan 5 Aliemus kazanır. Yüceliş serbest bırakıldıktan sonra, ilgili Uyanan'a ait, Tükenme ve Geçici eklenmiş 1 \"Saldırı\" kazan. Posse serbest bırakıldıktan sonra, rastgele Tükenme ve Geçici eklenmiş 1 \"Savunma\" kazan."
  },
  RelicConfig_13768_Desc = {
    Text = "Maksimum Arithmetica 2 artar. \"Saldırı\" veya \"Savunma\" oynadıktan sonra, ilgili Uyanan 5 Aliemus kazanır. Yüceliş serbest bırakıldıktan sonra, ilgili Uyanan'a ait, Tükenme ve Geçici eklenmiş 1 \"Saldırı\" kazan. Posse serbest bırakıldıktan sonra, rastgele Tükenme ve Geçici eklenmiş 1 \"Savunma\" kazan."
  },
  RelicConfig_13768_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Kanatlar\">"
  },
  RelicConfig_13769_BattleDesc = {
    Text = "Tur başlangıcında, <EmbryoFusionIconKeywords:Embriyo Füzyonu>+30. Tüm <DevouredIconKeywords:Yutma> efektleriniz <UnlimitedDevouredIconKeywords:Sonsuz Yutma> olur."
  },
  RelicConfig_13769_Desc = {
    Text = "Tur başlangıcında, <EmbryoFusionIconKeywords:Embriyo Füzyonu>+30. Tüm <DevouredIconKeywords:Yutma> efektleriniz <UnlimitedDevouredIconKeywords:Sonsuz Yutma> olur."
  },
  RelicConfig_13769_Name = {
    Text = "<RedQuality:Kıvranan Kordon>"
  },
  RelicConfig_13769_StoryDesc = {
    Text = "Boyna dolan."
  },
  RelicConfig_13770_BattleDesc = {
    Text = "Tur başında [Arg1] Kalkan kazan, her tur [Arg2] artar."
  },
  RelicConfig_13770_Desc = {
    Text = "Tur başında [Arg1] Kalkan kazan, her tur [Arg2] artar."
  },
  RelicConfig_13770_Name = {
    Text = "<WhiteQuality:Muhafaza Eli>"
  },
  RelicConfig_13770_StoryDesc = {
    Text = "Dua eden el, metanetli kalan yumruk."
  },
  RelicConfig_13771_BattleDesc = {
    Text = "Tüm Uyananların Keyflare Yenilenmesi 30 artar. Posse serbest bırakıldıktan sonra destesine 3 adet <DerivativeCardKeywords_4:\"Kavrayış\"> karıştır."
  },
  RelicConfig_13771_Desc = {
    Text = "Tüm Uyananların Keyflare Yenilenmesi 30 artar. Posse serbest bırakıldıktan sonra destesine 3 adet <DerivativeCardKeywords_4:\"Kavrayış\"> karıştır."
  },
  RelicConfig_13771_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Hafif Uyku\">"
  },
  RelicConfig_13772_BattleDesc = {
    Text = "Savaştan sonra ek olarak 75 Kara Mühür ve 1 Semptom kartı kazan."
  },
  RelicConfig_13772_Desc = {
    Text = "Savaştan sonra ek olarak 75 Kara Mühür ve 1 Semptom kartı kazan."
  },
  RelicConfig_13772_Name = {
    Text = "<RedQuality:Yeşim Mührü>"
  },
  RelicConfig_13772_StoryDesc = {
    Text = "Bu Damga, binyıllar boyunca Çürüme olmadan tahammül eder."
  },
  RelicConfig_13773_BattleDesc = {
    Text = "Verilen her 1 örnek Aktif Hasar için, kendine [Arg1] yığın <BleedingIconKeywords:Kan Akıtma> ve hedefe [Arg2] yığın <BleedingIconKeywords:Kan Akıtma> uygula. Öldürülen her düşman için, kendindeki <BleedingIconKeywords:Kan Akıtma> durumunu dağıt."
  },
  RelicConfig_13773_Desc = {
    Text = "Verilen her 1 örnek Aktif Hasar için, kendine [Arg1] yığın <BleedingIconKeywords:Kan Akıtma> ve hedefe [Arg2] yığın <BleedingIconKeywords:Kan Akıtma> uygula. Öldürülen her düşman için, kendindeki <BleedingIconKeywords:Kan Akıtma> durumunu dağıt."
  },
  RelicConfig_13773_Name = {
    Text = "<RedQuality:Sürü Zihni>"
  },
  RelicConfig_13773_StoryDesc = {
    Text = "Sarmalamak, Ortak Duyum, Sürü; Korku, Bilinmeyen Yaratık, Kontrol."
  },
  RelicConfig_13774_BattleDesc = {
    Text = "Gerçek Arithmetica Maliyeti 3 olan bir kart oynadığında, 1 kart çek ve 2 Arithmetica kazan; gerçek Arithmetica Maliyeti 4 veya daha fazla olan bir kart oynadığında, elindeki diğer kartların Arithmetica Maliyetini 1 azalt."
  },
  RelicConfig_13774_Desc = {
    Text = "Gerçek Arithmetica Maliyeti 3 olan bir kart oynadığında, 1 kart çek ve 2 Arithmetica kazan; gerçek Arithmetica Maliyeti 4 veya daha fazla olan bir kart oynadığında, elindeki diğer kartların Arithmetica Maliyetini 1 azalt."
  },
  RelicConfig_13774_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Göz\">"
  },
  RelicConfig_13775_BattleDesc = {
    Text = "Alındığında, bir Komut Kartı seç ve ona “Doğuştan”, “Sakla” ve “Oynandığında 1 kart Çekme Destesi’nden çek” özelliklerini ver."
  },
  RelicConfig_13775_Desc = {
    Text = "Alındığında, bir Komut Kartı seç ve ona “Doğuştan”, “Sakla” ve “Oynandığında 1 kart Çekme Destesi’nden çek” özelliklerini ver."
  },
  RelicConfig_13775_Name = {
    Text = "<WhiteQuality:Dosya>"
  },
  RelicConfig_13775_StoryDesc = {
    Text = "Şşşt, bu seninle benim aramdaki gizli bir anlaşma."
  },
  RelicConfig_13776_BattleDesc = {
    Text = "Savaşın başında 1 Dokunaç kazan."
  },
  RelicConfig_13776_Desc = {
    Text = "Savaşın başında 1 Dokunaç kazan."
  },
  RelicConfig_13776_Name = {
    Text = "<WhiteQuality:Sarı Salyangoz>"
  },
  RelicConfig_13776_StoryDesc = {
    Text = "Bu küçük Sarı Salyangoz, kusursuz ve lekesiz bir kökene sahip, asil bir soydan gelir."
  },
  RelicConfig_13777_BattleDesc = {
    Text = "Tek sayılı turların sonunda, Arithmetica kalmışsa, bir sonraki tur fazladan 2 kart çek; çift sayılı turların sonunda, kart kalmışsa, bir sonraki tur fazladan 2 Arithmetica kazan."
  },
  RelicConfig_13777_Desc = {
    Text = "Tek sayılı turların sonunda, Arithmetica kalmışsa, bir sonraki tur fazladan 2 kart çek; çift sayılı turların sonunda, kart kalmışsa, bir sonraki tur fazladan 2 Arithmetica kazan."
  },
  RelicConfig_13777_Name = {
    Text = "<OrangeQuality:Güneş-Ay Çarkı>"
  },
  RelicConfig_13777_StoryDesc = {
    Text = "Tahmin et, siyah mı yoksa beyaz mı?"
  },
  RelicConfig_13778_BattleDesc = {
    Text = "Dokunaç Sınırı +1. HP %50'nin altındayken, <TentacleInjurieIconKeywords:Tentacle DMG> +[Arg1]."
  },
  RelicConfig_13778_Desc = {
    Text = "Dokunaç Sınırı +1. HP %50'nin altındayken, <TentacleInjurieIconKeywords:Tentacle DMG> +[Arg1]."
  },
  RelicConfig_13778_Name = {
    Text = "<OrangeQuality:Deniz İlahisi>"
  },
  RelicConfig_13778_StoryDesc = {
    Text = "Yenmeyen deniz canlıları, örneğin deniz salyangozları, okyanusun besinlerinin yaklaşık %80'ini absorbe eder denir."
  },
  RelicConfig_13779_BattleDesc = {
    Text = "Turunun başında 1 kart çek, ve turun sonunda elinde 1 kart tutmayı seçebilirsin."
  },
  RelicConfig_13779_Desc = {
    Text = "Turunun başında 1 kart çek, ve turun sonunda elinde 1 kart tutmayı seçebilirsin."
  },
  RelicConfig_13779_Name = {
    Text = "<OrangeQuality:Kâhinin Dilek Lambası>"
  },
  RelicConfig_13779_StoryDesc = {
    Text = "Dileğini yerine getir."
  },
  RelicConfig_13780_BattleDesc = {
    Text = "Her Yüce’yi serbest bıraktığında 1 <DerivativeCardKeywords_7:\"Toksik Enfüzyon\"> kazan. Elinde 3 <DerivativeCardKeywords_7:\"Toksik Enfüzyon\"> varsa, <IntoxicationIconKeywords:Zehir> tetikleyen bir <DerivativeCardKeywords_8:\"Toksik Nöbet\">e sentezlenir."
  },
  RelicConfig_13780_Desc = {
    Text = "Her Yüce’yi serbest bıraktığında 1 <DerivativeCardKeywords_7:\"Toksik Enfüzyon\"> kazan. Elinde 3 <DerivativeCardKeywords_7:\"Toksik Enfüzyon\"> varsa, <IntoxicationIconKeywords:Zehir> tetikleyen bir <DerivativeCardKeywords_8:\"Toksik Nöbet\">e sentezlenir."
  },
  RelicConfig_13780_Name = {
    Text = "<OrangeQuality:Yabancı Tür Sözcüsü>"
  },
  RelicConfig_13780_StoryDesc = {
    Text = "O bir iblis değil, ama gerçekten de ölümlü âlemin ötesinden gelen fısıltıları taşır."
  },
  RelicConfig_13781_BattleDesc = {
    Text = "Tüketilen her Kara Mühür için, tüm Uyandırıcılar 1 Aliemus kazanır."
  },
  RelicConfig_13781_Desc = {
    Text = "Tüketilen her Kara Mühür için, tüm Uyandırıcılar 1 Aliemus kazanır."
  },
  RelicConfig_13781_Name = {
    Text = "Ters Çiçek"
  },
  RelicConfig_13782_BattleDesc = {
    Text = "Hasara Bağışıklık"
  },
  RelicConfig_13782_Desc = {
    Text = "Hasara Bağışıklık"
  },
  RelicConfig_13782_Name = {
    Text = "Deneme Kalıntısı"
  },
  RelicConfig_13783_BattleDesc = {
    Text = "Her tur oynanan 3. karttan sonra, Atılmış Kart Destesi’ne 1 <DerivativeCardKeywords_4:\"Insight\"> yerleştir. Her tur oynanan 6. karttan sonra, Atılmış Kart Destesi’nden 1 <DerivativeCardKeywords_4:\"Insight\"> eline al."
  },
  RelicConfig_13783_Desc = {
    Text = "Her tur oynanan 3. karttan sonra, Atılmış Kart Destesi’ne 1 <DerivativeCardKeywords_4:\"Insight\"> yerleştir. Her tur oynanan 6. karttan sonra, Atılmış Kart Destesi’nden 1 <DerivativeCardKeywords_4:\"Insight\"> eline al."
  },
  RelicConfig_13783_Name = {
    Text = "<WhiteQuality:Uygarlığın Işığı>"
  },
  RelicConfig_13783_StoryDesc = {
    Text = "Gece göğünü yaran bir meteor."
  },
  RelicConfig_13784_BattleDesc = {
    Text = "Tur başında, her düşman için 1 Arithmetica elde et. Bir düşman Aktif Hasarla öldürüldüğünde, diğer düşmanlara fazla Hasar kadar <BleedingIconKeywords:Bleed> uygula."
  },
  RelicConfig_13784_Desc = {
    Text = "Tur başında, her düşman için 1 Arithmetica elde et. Bir düşman Aktif Hasarla öldürüldüğünde, diğer düşmanlara fazla Hasar kadar <BleedingIconKeywords:Bleed> uygula."
  },
  RelicConfig_13784_Name = {
    Text = "<OrangeQuality:Linç Şarkısı>"
  },
  RelicConfig_13784_StoryDesc = {
    Text = "Özellikle kulaklarını işkenceye boğmak için tasarlandı."
  },
  RelicConfig_13785_BattleDesc = {
    Text = "Tur sonunda, <EmbryoFusionIconKeywords:Embriyo Füzyonu> +15, elinizde <DerivativeCardKeywords_2:\"Embriyo\"> varsa, [Arg1] Can yenile."
  },
  RelicConfig_13785_Desc = {
    Text = "Tur sonunda, <EmbryoFusionIconKeywords:Embriyo Füzyonu> +15, elinizde <DerivativeCardKeywords_2:\"Embriyo\"> varsa, [Arg1] Can yenile."
  },
  RelicConfig_13785_Name = {
    Text = "<WhiteQuality:Veba Raporu>"
  },
  RelicConfig_13785_StoryDesc = {
    Text = "Veba — doğanın bilinçsiz, huzursuz bir tezahürü."
  },
  RelicConfig_13786_BattleDesc = {
    Text = "Taşkınlık serbest bırakıldıktan sonra, [Arg1] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13786_Desc = {
    Text = "Taşkınlık serbest bırakıldıktan sonra, [Arg1] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13786_Name = {
    Text = "<WhiteQuality:Demir Kilit>"
  },
  RelicConfig_13786_StoryDesc = {
    Text = "Kalın ve sağlam bir kilit, anahtar olmadan açılması güç.\nElbette, usta bir hırsız için bunun hiçbir önemi yok."
  },
  RelicConfig_13787_BattleDesc = {
    Text = "Tur başında, rastgele bir düşmana [Arg1] <FixedDamage:Saf Hasar> ver. Bu savaşta \"Vuruş\" 7 kez oynandıktan sonra, verilen hasar [Arg2] olarak değişir. \"Vuruş\" 21 kez oynandıktan sonra, tüm düşmanlara anında [Arg3] <FixedDamage:Saf Hasar> ver."
  },
  RelicConfig_13787_Desc = {
    Text = "Tur başında, rastgele bir düşmana [Arg1] <FixedDamage:Saf Hasar> ver. Bu savaşta \"Vuruş\" 7 kez oynandıktan sonra, verilen hasar [Arg2] olarak değişir. \"Vuruş\" 21 kez oynandıktan sonra, tüm düşmanlara anında [Arg3] <FixedDamage:Saf Hasar> ver."
  },
  RelicConfig_13787_Name = {
    Text = "<OrangeQuality:Eski Yapboz>"
  },
  RelicConfig_13787_StoryDesc = {
    Text = "Bir zamanlar ağır çerçeveye gömülü olan sanat eseri, sergilendiği günden beri bir parçasından yoksun."
  },
  RelicConfig_13788_BattleDesc = {
    Text = "Dokunaç Sınırı 2 azaltılır. Tur sonunda, tüm Dokunaçlar bir kez daha saldırır."
  },
  RelicConfig_13788_Desc = {
    Text = "Dokunaç Sınırı 2 azaltılır. Tur sonunda, tüm Dokunaçlar bir kez daha saldırır."
  },
  RelicConfig_13788_Name = {
    Text = "<RedQuality:Kutsal Izdırap>"
  },
  RelicConfig_13788_StoryDesc = {
    Text = "Izdırabı kucakla."
  },
  RelicConfig_13789_BattleDesc = {
    Text = "Deste her sıfırlandığında, [Arg1] <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13789_Desc = {
    Text = "Deste her sıfırlandığında, [Arg1] <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13789_Name = {
    Text = "<WhiteQuality:Ağlayan Pipo>"
  },
  RelicConfig_13789_StoryDesc = {
    Text = "Bu, nefretin ürünü mü, yoksa intikamın sonucu mu?"
  },
  RelicConfig_13790_BattleDesc = {
    Text = "Her harita hareketi 10 Kara Mühür kazandırır, ancak Stresi 10 puan artırır."
  },
  RelicConfig_13790_Desc = {
    Text = "Her harita hareketi 10 Kara Mühür kazandırır, ancak Stresi 10 puan artırır."
  },
  RelicConfig_13790_Name = {
    Text = "Dipsiz Torba"
  },
  RelicConfig_13791_BattleDesc = {
    Text = "Bu Kalıntı alındığında, bir Komut Kartı seç ve destesine bir kopyasını ekle."
  },
  RelicConfig_13791_Desc = {
    Text = "Bu Kalıntı alındığında, bir Komut Kartı seç ve destesine bir kopyasını ekle."
  },
  RelicConfig_13791_Name = {
    Text = "<WhiteQuality:Anlık Ateş>"
  },
  RelicConfig_13791_StoryDesc = {
    Text = "Titreşen ışık, sönük bir umut."
  },
  RelicConfig_13792_BattleDesc = {
    Text = "Her Can kaybettiğinizde, <EmbryoFusionIconKeywords:Embriyo Füzyonu>+10. Can'ınız %50'nin altındaysa etki iki katına çıkar."
  },
  RelicConfig_13792_Desc = {
    Text = "Her Can kaybettiğinizde, <EmbryoFusionIconKeywords:Embriyo Füzyonu>+10. Can'ınız %50'nin altındaysa etki iki katına çıkar."
  },
  RelicConfig_13792_Name = {
    Text = "<WhiteQuality:Paslı Testere>"
  },
  RelicConfig_13792_StoryDesc = {
    Text = "Otopsi doktoru, hayatını hiç güzel bir kadın görmeden, yalnızca kemik yığınları, iltihaplı sinirler, kaslar ve hastalıkların yol açtığı dokularla geçirir."
  },
  RelicConfig_13793_BattleDesc = {
    Text = "Alındığında, takımın Mühür Hasadı değeri Köken değerinin %150’si olur. HP Yenilenmesinden sonra tüm Uyananlar 3 Aliemus kazanır; HP kaybettikten sonra [Arg1] <PowerIconKeywords:STR> ve Dokunaç Hasarı kazanılır; bu birleşik etki tur başına en fazla 5 kez tetiklenebilir."
  },
  RelicConfig_13793_Desc = {
    Text = "Alındığında, takımın Mühür Hasadı değeri Köken değerinin %150’si olur. HP Yenilenmesinden sonra tüm Uyananlar 3 Aliemus kazanır; HP kaybettikten sonra [Arg1] <PowerIconKeywords:STR> ve Dokunaç Hasarı kazanılır; bu birleşik etki tur başına en fazla 5 kez tetiklenebilir."
  },
  RelicConfig_13793_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Ay\">"
  },
  RelicConfig_13794_BattleDesc = {
    Text = "Tur bittikten sonra, tüm Uyananlar 5 Aliemus kazanır. Kalan her bir Arithmetica için, tüm Uyananlar fazladan 3 Aliemus kazanır."
  },
  RelicConfig_13794_Desc = {
    Text = "Tur bittikten sonra, tüm Uyananlar 5 Aliemus kazanır. Kalan her bir Arithmetica için, tüm Uyananlar fazladan 3 Aliemus kazanır."
  },
  RelicConfig_13794_Name = {
    Text = "<OrangeQuality:Prototip Batarya>"
  },
  RelicConfig_13794_StoryDesc = {
    Text = "Taşınabilir Umut"
  },
  RelicConfig_13795_BattleDesc = {
    Text = "Maksimum Arithmetica 1 artırıldı."
  },
  RelicConfig_13795_Desc = {
    Text = "Maksimum Arithmetica 1 artırıldı."
  },
  RelicConfig_13795_Name = {
    Text = "<WhiteQuality:Canlılık Enjeksiyonu>"
  },
  RelicConfig_13795_StoryDesc = {
    Text = "Seğirme de bir tür Canlılıktır."
  },
  RelicConfig_13796_BattleDesc = {
    Text = "Savaş sonunda HP %50'nin altındaysa bir Gümüş Kalıntıya Yükselt."
  },
  RelicConfig_13796_Desc = {
    Text = "Savaş sonunda Can %50'nin altındaysa Gümüş Kalıntı'ya yükselt."
  },
  RelicConfig_13796_Name = {
    Text = "Yırtık Defter 2"
  },
  RelicConfig_13796_StoryDesc = {
    Text = "Elworth haritaları, deney günlükleri ve üçgen D-izleriyle işaretlenmiş mektuplarla doldurulmuş eski bir günlük.\nBaşlangıçtaki el yazısı düzenli ve tertipliyken, giderek dağınık ve kaotik bir hâl alır."
  },
  RelicConfig_13797_BattleDesc = {
    Text = "Altın bir Kalıntıya yükseltmek için 3 Darbe Kartı oyna."
  },
  RelicConfig_13797_Desc = {
    Text = "Altın Kalıntı'ya yükseltmek için 3 Saldırı Kartı oyna."
  },
  RelicConfig_13797_Name = {
    Text = "Yırtık Defter 1"
  },
  RelicConfig_13797_StoryDesc = {
    Text = "Elworth haritaları, deney günlükleri ve üçgen D-izleriyle işaretlenmiş mektuplarla doldurulmuş eski bir günlük.\nBaşlangıçtaki el yazısı düzenli ve tertipliyken, giderek dağınık ve kaotik bir hâl alır."
  },
  RelicConfig_13798_BattleDesc = {
    Text = "Savaşın başında, tüm Semptom kartların <NothingnessIconKeywords:Geçici Güzellik> kazanır ve destesindeki her Semptom kartı için [Arg1] <PowerIconKeywords:STR> elde edersin."
  },
  RelicConfig_13798_Desc = {
    Text = "Savaşın başında, tüm Semptom kartların <NothingnessIconKeywords:Geçici Güzellik> kazanır ve destesindeki her Semptom kartı için [Arg1] <PowerIconKeywords:STR> elde edersin."
  },
  RelicConfig_13798_Name = {
    Text = "<WhiteQuality:Harford İksiri>"
  },
  RelicConfig_13798_StoryDesc = {
    Text = "Bileşimi bilinmeyen ilaç.\nÜnlü kemancı Eric'in buna özel bir düşkünlüğü olduğu söylenir."
  },
  RelicConfig_13799_BattleDesc = {
    Text = "İlk savaş turunun başında eline <DerivativeCardKeywords_1:\"Kayıp Gölgelerin Yankısı\"> ekle; ikinci turda eline <DerivativeCardKeywords_41:\"Gümüş Anahtar Rezonansı\"> ekle; üçüncü turda eline <DerivativeCardKeywords_39:\"Geçmişin Yankıları\"> ekle."
  },
  RelicConfig_13799_Desc = {
    Text = "İlk savaş turunun başında eline <DerivativeCardKeywords_1:\"Kayıp Gölgelerin Yankısı\"> ekle; ikinci turda eline <DerivativeCardKeywords_41:\"Gümüş Anahtar Rezonansı\"> ekle; üçüncü turda eline <DerivativeCardKeywords_39:\"Geçmişin Yankıları\"> ekle."
  },
  RelicConfig_13799_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Yıldızlar\">"
  },
  RelicConfig_13800_BattleDesc = {
    Text = "Tur başında eline 1 <DerivativeCardKeywords_6:\"Güneş Şemsiyesi\"> ekle. 6 kart oynadıktan sonra, elindeki tüm <DerivativeCardKeywords_6:\"Güneş Şemsiyesi\"> kartlarının <AlertIconKeywords:Alarm> değerini [Arg2] artır."
  },
  RelicConfig_13800_Desc = {
    Text = "Tur başında eline 1 <DerivativeCardKeywords_6:\"Güneş Şemsiyesi\"> ekle. 6 kart oynadıktan sonra, elindeki tüm <DerivativeCardKeywords_6:\"Güneş Şemsiyesi\"> kartlarının <AlertIconKeywords:Alarm> değerini [Arg2] artır."
  },
  RelicConfig_13800_Name = {
    Text = "<WhiteQuality:Gezgin Şemsiyesi>"
  },
  RelicConfig_13800_StoryDesc = {
    Text = "Işıksız Diyar’da Çiçek Aç"
  },
  RelicConfig_13801_BattleDesc = {
    Text = "Normal savaşlarda tüm düşmanların HP'si %30 artar. Zaferden sonra fazladan 25 Kara Mühür kazan."
  },
  RelicConfig_13801_Desc = {
    Text = "Normal savaşlarda tüm düşmanların HP'si %30 artar. Zaferden sonra fazladan 25 Kara Mühür kazan."
  },
  RelicConfig_13801_Name = {
    Text = "Yırtık Savaş Sancağı"
  },
  RelicConfig_13802_BattleDesc = {
    Text = "Alındığında Maksimum HP [Arg1] artar. Alındığı anda HP %25’in altındaysa, Maksimum HP artışı [Arg2] olur."
  },
  RelicConfig_13802_Desc = {
    Text = "Alındığında Maksimum HP [Arg1] artar. Alındığı anda HP %25’in altındaysa, Maksimum HP artışı [Arg2] olur."
  },
  RelicConfig_13802_Name = {
    Text = "<WhiteQuality:Seylan Çayı>"
  },
  RelicConfig_13802_StoryDesc = {
    Text = "Sağlıklı beslenme, seninle ve benimle başlar."
  },
  RelicConfig_13803_BattleDesc = {
    Text = "Her 3 turda bir 3 Geçici Dokunaç kazan."
  },
  RelicConfig_13803_Desc = {
    Text = "Her 3 turda bir 3 Geçici Dokunaç kazan."
  },
  RelicConfig_13803_Name = {
    Text = "<WhiteQuality:Dalış Miğferi>"
  },
  RelicConfig_13803_StoryDesc = {
    Text = "Rüyalar, Yıldızlar ve denizdir!"
  },
  RelicConfig_13804_BattleDesc = {
    Text = "Turunun sonunda [Arg1] Karakter Kalkanı elde et. Karakter Kalkanın 0 ya da 3’ün katıysa, [Arg2] <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13804_Desc = {
    Text = "Turunun sonunda [Arg1] Karakter Kalkanı elde et. Karakter Kalkanın 0 ya da 3’ün katıysa, [Arg2] <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13804_Name = {
    Text = "<OrangeQuality:İmdat Sinyali>"
  },
  RelicConfig_13804_StoryDesc = {
    Text = "Kurtarılmayı beklemedi."
  },
  RelicConfig_13806_BattleDesc = {
    Text = "Bir Semptom kartı çektiğinde [Arg1] Geçici <PowerIconKeywords:STR> elde et. Sahip olduğun her Lanetli Kalıntı için Krit. Oranı ve Krit. Hasarın %10 artar."
  },
  RelicConfig_13806_Desc = {
    Text = "Bir Semptom kartı çektiğinde [Arg1] Geçici <PowerIconKeywords:STR> elde et. Sahip olduğun her Lanetli Kalıntı için Krit. Oranı ve Krit. Hasarın %10 artar."
  },
  RelicConfig_13806_Name = {
    Text = "<OrangeQuality:Uçurum Bağı>"
  },
  RelicConfig_13806_StoryDesc = {
    Text = "Issız varoşlarda, yalnız bir kulübede bir telefon çalar.\n“Karanlık... hısss... sonsuz... tıslayan... karanlık...”"
  },
  RelicConfig_13807_BattleDesc = {
    Text = "Savaş başlangıcında, <EmbryoFusionIconKeywords:Embriyo Füzyonu>+50. En az 50 Aliemus'a sahip her Uyandırıcı için, 1 ek kez etki eder."
  },
  RelicConfig_13807_Desc = {
    Text = "Savaş başlangıcında, <EmbryoFusionIconKeywords:Embriyo Füzyonu>+50. En az 50 Aliemus'a sahip her Uyandırıcı için, 1 ek kez etki eder."
  },
  RelicConfig_13807_Name = {
    Text = "<WhiteQuality:Sevgili Yavrum>"
  },
  RelicConfig_13807_StoryDesc = {
    Text = "Marangoz, karısı için, rahmindeki oğullarının yerini alacak, canlıymış gibi bir kukla yaptı."
  },
  RelicConfig_13808_BattleDesc = {
    Text = "Taşkınlık serbest bırakıldıktan sonra, ilgili Uyandıran’a karşılık gelen rastgele bir kartı eline ekle. Kart <DepleteIconKeywords:Tüketme> ve <NothingnessIconKeywords:Fleeting> kazanır. Savaş bittikten sonra [Arg1] HP yenile."
  },
  RelicConfig_13808_Desc = {
    Text = "Taşkınlık serbest bırakıldıktan sonra, ilgili Uyandıran’a karşılık gelen rastgele bir kartı eline ekle. Kart <DepleteIconKeywords:Tüketme> ve <NothingnessIconKeywords:Fleeting> kazanır. Savaş bittikten sonra [Arg1] HP yenile."
  },
  RelicConfig_13808_Name = {
    Text = "<WhiteQuality:Doktor Çantası>"
  },
  RelicConfig_13808_StoryDesc = {
    Text = "Bir doktor kimliğini simgeleyen, oldukça ağır bir evrak çantası.\nOnu açmak, gerçek bir doktora ait olduğunu garanti etmez."
  },
  RelicConfig_13809_BattleDesc = {
    Text = "Tüm Kalıntı fiyatları 20 düşer."
  },
  RelicConfig_13809_Desc = {
    Text = "Tüm Kalıntı fiyatları 20 düşer."
  },
  RelicConfig_13809_Name = {
    Text = "<WhiteQuality:Tatlı Dil>"
  },
  RelicConfig_13809_StoryDesc = {
    Text = "Sadece tüccarlar değil, inançlı olanlar da etkileyici konuşur."
  },
  RelicConfig_13811_BattleDesc = {
    Text = "\"Vuruş\" her 3. oynandığında, tüm düşmanlara [Arg1] <FixedDamage:Saf Hasar> ver. İlgili Uyandırıcı 15 Aliemus kazanır."
  },
  RelicConfig_13811_Desc = {
    Text = "\"Vuruş\" her 3. oynandığında, tüm düşmanlara [Arg1] <FixedDamage:Saf Hasar> ver. İlgili Uyandırıcı 15 Aliemus kazanır."
  },
  RelicConfig_13811_Name = {
    Text = "<WhiteQuality:Paslanmış Neşter>"
  },
  RelicConfig_13811_StoryDesc = {
    Text = "Canlı dokuyu kesmeye uygun değil."
  },
  RelicConfig_13812_BattleDesc = {
    Text = "Alındığında Maksimum CP’yi %100 artırır. Tur başında [Arg1] CP kaybedersin."
  },
  RelicConfig_13812_Desc = {
    Text = "Alındığında Maksimum CP’yi %100 artırır. Tur başında [Arg1] CP kaybedersin."
  },
  RelicConfig_13812_Name = {
    Text = "<RedQuality:☆Ölümsüz Beden☆>"
  },
  RelicConfig_13812_StoryDesc = {
    Text = "\"Deniz canlıları hayatta kalmak için sık sık uzuvlarını feda eder.\""
  },
  RelicConfig_13813_BattleDesc = {
    Text = "Savaşın başında, elit ve boss düşmanların mevcut HP’si %20 azaltılır."
  },
  RelicConfig_13813_Desc = {
    Text = "Savaşın başında, elit ve boss düşmanların mevcut HP’si %20 azaltılır."
  },
  RelicConfig_13813_Name = {
    Text = "<WhiteQuality:☆Eski Çapa☆>"
  },
  RelicConfig_13813_StoryDesc = {
    Text = "Yurduna dön, benim yaşlı denizcim."
  },
  RelicConfig_13814_BattleDesc = {
    Text = "Tur sonunda, elde oynanmamış her kart için, tüm Uyananlar 2 Ruh kazanır."
  },
  RelicConfig_13814_Desc = {
    Text = "Tur sonunda, elde oynanmamış her kart için, tüm Uyananlar 2 Ruh kazanır."
  },
  RelicConfig_13814_Name = {
    Text = "<WhiteQuality:Dengesiz Terazi>"
  },
  RelicConfig_13814_StoryDesc = {
    Text = "Artık adaleti simgelemiyor."
  },
  RelicConfig_13815_BattleDesc = {
    Text = "Aldığında, Arithmetica Maliyeti kalıcı olarak 1’e düşürülecek bir kart seç."
  },
  RelicConfig_13815_Desc = {
    Text = "Aldığında, Arithmetica Maliyeti kalıcı olarak 1’e düşürülecek bir kart seç."
  },
  RelicConfig_13815_Name = {
    Text = "<WhiteQuality:☆İşlenmiş Protez Göz☆>"
  },
  RelicConfig_13815_StoryDesc = {
    Text = "Artık saf olmayan bir göz."
  },
  RelicConfig_13816_BattleDesc = {
    Text = "Savaşın başında, tüm düşmanlar [Arg1] <RetaliateIconKeywords:Sayaç> kazanır. Ne zaman Hasar verilse, en düşük Aliemus’a sahip Uyandıran 6 Aliemus kazanır."
  },
  RelicConfig_13816_Desc = {
    Text = "Savaşın başında, tüm düşmanlar [Arg1] <RetaliateIconKeywords:Sayaç> kazanır. Ne zaman Hasar verilse, en düşük Aliemus’a sahip Uyandıran 6 Aliemus kazanır."
  },
  RelicConfig_13816_Name = {
    Text = "<RedQuality:☆Feryat Çanı☆>"
  },
  RelicConfig_13816_StoryDesc = {
    Text = "Çın, çın, çocuk ağlıyor;\nÇın, çın, çocuk çığlık atıyor.\nÇın, çın, çocuk inliyor;\nÇın, çın, aç o, biliyor musun."
  },
  RelicConfig_13817_BattleDesc = {
    Text = "Her 6 Komut Kartı oynandığında, <TentacleInjurieIconKeywords:Tentacle DMG> +[Arg1]."
  },
  RelicConfig_13817_Desc = {
    Text = "Her 6 Komut Kartı oynandığında, <TentacleInjurieIconKeywords:Tentacle DMG> +[Arg1]."
  },
  RelicConfig_13817_Name = {
    Text = "<WhiteQuality:Yarık Baş Kurdu>"
  },
  RelicConfig_13817_StoryDesc = {
    Text = "Beynimiz bir sır olarak kaldığı sürece, içlerinin dokunaçlarla dolu olması o kadar da önemli değil."
  },
  RelicConfig_13818_BattleDesc = {
    Text = "Krit. Oranı %50 artar, ancak savaş başladığında kendine 3 tur boyunca <FragileIconKeywords:Kırılgan> uygula."
  },
  RelicConfig_13818_Desc = {
    Text = "Krit. Oranı %50 artar, ancak savaş başladığında kendine 3 tur boyunca <FragileIconKeywords:Kırılgan> uygula."
  },
  RelicConfig_13818_Name = {
    Text = "<RedQuality:Uğursuz Kanca>"
  },
  RelicConfig_13818_StoryDesc = {
    Text = "Tanımlanması güç türler."
  },
  RelicConfig_13819_BattleDesc = {
    Text = "Arithmetica Maliyeti 3 veya daha fazla olan bir kart oynadığında, 1 kart çek ve 1 Arithmetica kazan."
  },
  RelicConfig_13819_Desc = {
    Text = "Arithmetica Maliyeti 3 veya daha fazla olan bir kart oynadığında, 1 kart çek ve 1 Arithmetica kazan."
  },
  RelicConfig_13819_Name = {
    Text = "<OrangeQuality:☆Yitişin Güzelliği☆>"
  },
  RelicConfig_13819_StoryDesc = {
    Text = "Artık kimse onun güzelliğini hatırlamıyor."
  },
  RelicConfig_13820_BattleDesc = {
    Text = "Ne zaman bir Semptom geliştirirsen, Maksimum Canı [Arg1] artır."
  },
  RelicConfig_13820_Desc = {
    Text = "Ne zaman bir Semptom geliştirirsen, Maksimum Canı [Arg1] artır."
  },
  RelicConfig_13820_Name = {
    Text = "<WhiteQuality:☆Günlük Bileşimi☆>"
  },
  RelicConfig_13820_StoryDesc = {
    Text = "“Tatlı ve baştan çıkarıcı bir koku.”"
  },
  RelicConfig_13821_BattleDesc = {
    Text = "Bir Yücelik serbest bırakıldıktan sonra 1 kart çek. HP %25'in altındaysa, fazladan 1 kart daha çek."
  },
  RelicConfig_13821_Desc = {
    Text = "Bir Yücelik serbest bırakıldıktan sonra 1 kart çek. HP %25'in altındaysa, fazladan 1 kart daha çek."
  },
  RelicConfig_13821_Name = {
    Text = "<OrangeQuality:Bilgi Çarkı>"
  },
  RelicConfig_13821_StoryDesc = {
    Text = "Lütfen dikkatle okuyun."
  },
  RelicConfig_13822_BattleDesc = {
    Text = "Her tur, Aktif Hasar verirken, [Arg1] Geçici <TentacleInjurieIconKeywords:Tentacle DMG> artır, en fazla 3 kez. Yığın dolduğunda, Dokunaç Sınırını görmezden gelen 1 Geçici Dokunaç üret."
  },
  RelicConfig_13822_Desc = {
    Text = "Her tur, Aktif Hasar verirken, [Arg1] Geçici <TentacleInjurieIconKeywords:Tentacle DMG> artır, en fazla 3 kez. Yığın dolduğunda, Dokunaç Sınırını görmezden gelen 1 Geçici Dokunaç üret."
  },
  RelicConfig_13822_Name = {
    Text = "<OrangeQuality:Lemuria'nın Hazzı>"
  },
  RelicConfig_13822_StoryDesc = {
    Text = "Ebedi Uykuya Dalış’ın Efendisi, rüyalarında seni bekliyor."
  },
  RelicConfig_13823_BattleDesc = {
    Text = "Her tur oynadığın [Arg1]. Komut Kartı iki kez tetiklenir ve eline geri döner."
  },
  RelicConfig_13823_Desc = {
    Text = "Her tur oynadığın [Arg1]. Komut Kartı iki kez tetiklenir ve eline geri döner."
  },
  RelicConfig_13823_Name = {
    Text = "<OrangeQuality:Yıldız Demlemesi+>"
  },
  RelicConfig_13823_StoryDesc = {
    Text = "Yıldızların Arasında dolaşmak."
  },
  RelicConfig_13824_BattleDesc = {
    Text = "Tur başında, <DeathResistanceIconKeywords:Ölüm Direnci> %10 artar (bu seviyede her Ölüme Direnci tetiklendiğinde, kazanılan Ölüm Direnci yarıya iner). <DeathResistanceIconKeywords:Ölüm Direnci> %100’ün üzerine çıktığında, <ProficientInRealmsIconKeywords:Diyar Ustalığı> 100 artar."
  },
  RelicConfig_13824_Desc = {
    Text = "Tur başında, <DeathResistanceIconKeywords:Ölüm Direnci> %10 artar (bu seviyede her Ölüme Direnci tetiklendiğinde, kazanılan Ölüm Direnci yarıya iner). <DeathResistanceIconKeywords:Ölüm Direnci> %100’ün üzerine çıktığında, <ProficientInRealmsIconKeywords:Diyar Ustalığı> 100 artar."
  },
  RelicConfig_13824_Name = {
    Text = "<WhiteQuality:Deniz Kızının Gözyaşı>"
  },
  RelicConfig_13824_StoryDesc = {
    Text = "Onu suya koymayın."
  },
  RelicConfig_13825_BattleDesc = {
    Text = "Tüketilen her 10 Kara Mühür için, [Arg1] HP yenile."
  },
  RelicConfig_13825_Desc = {
    Text = "Tüketilen her 10 Kara Mühür için, HP’nin %1’ini yenile."
  },
  RelicConfig_13825_Name = {Text = "Ters Kök"},
  RelicConfig_13826_BattleDesc = {
    Text = "Bir Güçlendirme Kartı, Semptom kartı veya Durum Kartı oynadığında, en az Aliemus’a sahip Uyanan 10 Aliemus kazanır."
  },
  RelicConfig_13826_Desc = {
    Text = "Bir Güçlendirme Kartı, Semptom kartı veya Durum Kartı oynadığında, en az Aliemus’a sahip Uyanan 10 Aliemus kazanır."
  },
  RelicConfig_13826_Name = {
    Text = "<WhiteQuality:Yabancı Pul Albümü>"
  },
  RelicConfig_13826_StoryDesc = {
    Text = "Sayılara dökülmüş bir özlem."
  },
  RelicConfig_13827_BattleDesc = {
    Text = "Alındığında, 75 Kara Mühür kazan. 1 Kalıntı seç ve onu rastgele bir Lanetli Kalıntıya dönüştür."
  },
  RelicConfig_13827_Desc = {
    Text = "Alındığında, 75 Kara Mühür kazan. 1 Kalıntı seç ve onu rastgele bir Lanetli Kalıntıya dönüştür."
  },
  RelicConfig_13827_Name = {
    Text = "<RedQuality:Lanetli Stel>"
  },
  RelicConfig_13827_StoryDesc = {
    Text = "Bu stelaya dokunurken derin denizin çağrısını duydun."
  },
  RelicConfig_13828_BattleDesc = {
    Text = "Her turda bir Komut Kartı ilk kez Atılmış Kart Destesi’ne girdiğinde, Arithmetica Maliyeti 1 azaltılmış Geçici bir kopyasını Çekme Destesi’ne karıştır."
  },
  RelicConfig_13828_Desc = {
    Text = "Her turda bir Komut Kartı ilk kez Atılmış Kart Destesi’ne girdiğinde, Arithmetica Maliyeti 1 azaltılmış Geçici bir kopyasını Çekme Destesi’ne karıştır."
  },
  RelicConfig_13828_Name = {
    Text = "<WhiteQuality:Sessiz Gramofon>"
  },
  RelicConfig_13828_StoryDesc = {
    Text = "Sesi rüzgâra karışıp soldu."
  },
  RelicConfig_13829_BattleDesc = {
    Text = "Paslı anahtarların bir demeti. Kapıları açmak için kullanılabilir."
  },
  RelicConfig_13829_Desc = {
    Text = "Paslı anahtarların bir demeti. Kapıları açmak için kullanılabilir."
  },
  RelicConfig_13829_Name = {
    Text = "Paslı Anahtar"
  },
  RelicConfig_13830_BattleDesc = {
    Text = "HP Yenilenmesi sağladığında, ayrıca [Arg1] Karakter Kalkanı kazan. 3. turun başlangıcından sonra, [Arg2] <AlertIconKeywords:Alarm> kazan."
  },
  RelicConfig_13830_Desc = {
    Text = "HP Yenilenmesi sağladığında, ayrıca [Arg1] Karakter Kalkanı kazan. 3. turun başlangıcından sonra, [Arg2] <AlertIconKeywords:Alarm> kazan."
  },
  RelicConfig_13830_Name = {
    Text = "<WhiteQuality:Muhafaza Edilmiş Kelebek>"
  },
  RelicConfig_13830_StoryDesc = {
    Text = "Bugüne dek hâlâ biri tarafından derinlemesine seviliyor."
  },
  RelicConfig_13831_BattleDesc = {
    Text = "Bir Komut Kartı <DimensionalSpaceIconKeywords:Ultra Uzay>a girdiğinde, ilgili Uyanan’a 15 Aliemus ver."
  },
  RelicConfig_13831_Desc = {
    Text = "Bir Komut Kartı <DimensionalSpaceIconKeywords:Ultra Uzay>a girdiğinde, ilgili Uyanan’a 15 Aliemus ver."
  },
  RelicConfig_13831_Name = {
    Text = "<WhiteQuality:Zaman Skarabeusu>"
  },
  RelicConfig_13831_StoryDesc = {
    Text = "Hem bir saat mağazasında hem de bir böcek müzesinde bulunmuş bir cep saati.\nTufan’dan beri üniversitenin koleksiyonuna dâhil edilmiştir."
  },
  RelicConfig_13832_BattleDesc = {
    Text = "Ultra Tur’a girildiğinde, kendinden <WeaknessIconKeywords:Zayıflık> ve <FragileIconKeywords:Kırılgan> durumlarını kaldır; tüm düşmanlara 3 tur boyunca <WeaknessIconKeywords:Zayıflık> ve <VulnerabilityIconKeywords:Savunmasız> durumu uygula. Bu tur, tüm Uyananların Final Hasarı %15 artar."
  },
  RelicConfig_13832_Desc = {
    Text = "Ultra Tur’a girildiğinde, kendinden <WeaknessIconKeywords:Zayıflık> ve <FragileIconKeywords:Kırılgan> durumlarını kaldır; tüm düşmanlara 3 tur boyunca <WeaknessIconKeywords:Zayıflık> ve <VulnerabilityIconKeywords:Savunmasız> durumu uygula. Bu tur, tüm Uyananların Final Hasarı %15 artar."
  },
  RelicConfig_13832_Name = {
    Text = "<WhiteQuality:Süpertelli Cep Saati>"
  },
  RelicConfig_13832_StoryDesc = {
    Text = "“Ah hayır, cep saati durdu.”"
  },
  RelicConfig_13833_BattleDesc = {
    Text = "Verilen her 1 Hasar örneği için, hedefe [Arg1] yığın <IntoxicationIconKeywords:Zehir> uygula. Bu savaştaki tetiklenme sayısı 25’e ulaştığında, tüm düşmanlar için derhal <IntoxicationIconKeywords:Zehir> tetiklenir."
  },
  RelicConfig_13833_Desc = {
    Text = "Verilen her 1 Hasar örneği için, hedefe [Arg1] yığın <IntoxicationIconKeywords:Zehir> uygula. Bu savaştaki tetiklenme sayısı 25’e ulaştığında, tüm düşmanlar için derhal <IntoxicationIconKeywords:Zehir> tetiklenir."
  },
  RelicConfig_13833_Name = {
    Text = "<OrangeQuality:☆Tozlanmış Dokuma Tezgâhı☆>"
  },
  RelicConfig_13833_StoryDesc = {
    Text = "Şefkatli bir anne, kalbin yaralarını diker."
  },
  RelicConfig_13834_BattleDesc = {
    Text = "Her 5. kez Karakter Kalkanı kazandığında, ayrıca <RetaliateIconKeywords:Counter> kazan; Sayaç değeri kazanılan Karakter Kalkanının [Arg1]%’ine eşittir."
  },
  RelicConfig_13834_Desc = {
    Text = "Her 5. kez Karakter Kalkanı kazandığında, ayrıca <RetaliateIconKeywords:Counter> kazan; Sayaç değeri kazanılan Karakter Kalkanının [Arg1]%’ine eşittir."
  },
  RelicConfig_13834_Name = {
    Text = "<OrangeQuality:Kadim Bilgelerin Kayıp Bölümü>"
  },
  RelicConfig_13834_StoryDesc = {
    Text = "\"İnsanlar ne kadar da budala; sırf kadim diye körü körüne inanıyorlar.\""
  },
  RelicConfig_13835_BattleDesc = {
    Text = "Tur başında 1 kart çek."
  },
  RelicConfig_13835_Desc = {
    Text = "Tur başında 1 kart çek."
  },
  RelicConfig_13835_Name = {
    Text = "<WhiteQuality:Yön Pusulası>"
  },
  RelicConfig_13835_StoryDesc = {
    Text = "Gösterilen şey bir yön değil, daha çok bir manyetik alandır."
  },
  RelicConfig_13836_BattleDesc = {
    Text = "Savaş başında, sınır dolana dek rastgele <DerivativeCardKeywords_3:\"Konvülsiyon\"> ve <DerivativeCardKeywords_4:\"Kavrayış\">ı <DimensionalSpaceIconKeywords:Ultra Uzay>a yerleştir. Ultra Tur’a girdikten sonra, [Arg1] <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13836_Desc = {
    Text = "Savaş başında, sınır dolana dek rastgele <DerivativeCardKeywords_3:\"Konvülsiyon\"> ve <DerivativeCardKeywords_4:\"Kavrayış\">ı <DimensionalSpaceIconKeywords:Ultra Uzay>a yerleştir. Ultra Tur’a girdikten sonra, [Arg1] <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13836_Name = {
    Text = "<RedQuality:Alfonso'nun Eseri>"
  },
  RelicConfig_13836_StoryDesc = {
    Text = "Öngörülemez kaderin aksine, yıldızlar kendi yasalarına uyar."
  },
  RelicConfig_13837_BattleDesc = {
    Text = "Alındığında <DeathResistanceIconKeywords:Death Resistance> +%100. (Bu meydan okumada her Sefer Ölüm Direnci tetiklendiğinde, kazanılan Ölüm Direnci yarıya iner). <DeathResistanceIconKeywords:Death Resistance> tetiklendikten sonra, bu savaşta turun başında [Arg1] HP yenile."
  },
  RelicConfig_13837_Desc = {
    Text = "Alındığında <DeathResistanceIconKeywords:Death Resistance> +%100. (Bu meydan okumada her Sefer Ölüm Direnci tetiklendiğinde, kazanılan Ölüm Direnci yarıya iner). <DeathResistanceIconKeywords:Death Resistance> tetiklendikten sonra, bu savaşta turun başında [Arg1] HP yenile."
  },
  RelicConfig_13837_Name = {
    Text = "<WhiteQuality:Suni Solunum>"
  },
  RelicConfig_13837_StoryDesc = {
    Text = "Kâşifler için olmazsa olmaz. Ona fazlasıyla bel bağlarsan, sonunda senin bir parçan hâline gelir."
  },
  RelicConfig_13838_BattleDesc = {
    Text = "Bu, Etkisi olmayan bir görev Kalıntısı 2"
  },
  RelicConfig_13838_Desc = {
    Text = "Bu, Etkisi olmayan bir görev Kalıntısı 2"
  },
  RelicConfig_13838_Name = {
    Text = "Görev Kalıntı Testi 2"
  },
  RelicConfig_13838_StoryDesc = {
    Text = "Ek içerik gerektiren bir Kutsal Eşya."
  },
  RelicConfig_13839_BattleDesc = {
    Text = "Elindeki son kartı oynadığında 2 kart çek. Bu etki tur başına en fazla 2 kez tetiklenebilir."
  },
  RelicConfig_13839_Desc = {
    Text = "Elindeki son kartı oynadığında 2 kart çek. Bu etki tur başına en fazla 2 kez tetiklenebilir."
  },
  RelicConfig_13839_Name = {
    Text = "<WhiteQuality:☆Gizemli Eldivenler☆>"
  },
  RelicConfig_13839_StoryDesc = {
    Text = "“Korkma, bu sadece bir düş.”"
  },
  RelicConfig_13840_BattleDesc = {
    Text = "Her 3 turda bir, tüm düşmanlara 1 yığın <WeaknessIconKeywords:Zayıflık> ekle. <WeaknessIconKeywords:Zayıflık> sahibi bir düşmana Hasar verdikten sonra, tur başına en fazla 3 tetikleme olmak üzere [Arg1] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13840_Desc = {
    Text = "Her 3 turda bir, tüm düşmanlara 1 yığın <WeaknessIconKeywords:Semptom: Zayıflık> ekle. <WeaknessIconKeywords:Semptom: Zayıflık> etkisindeki bir düşmana Hasar verdikten sonra [Arg1] Geçici <PowerIconKeywords:GÜÇ> kazan, tur başına en fazla 3 kez tetiklenir."
  },
  RelicConfig_13840_Name = {
    Text = "<WhiteQuality:Kötücül Çocuk>"
  },
  RelicConfig_13840_StoryDesc = {
    Text = "Saf kötülükten doğdu, her ne kadar bu kendi iradesi olmasa da."
  },
  RelicConfig_13841_BattleDesc = {
    Text = "Tüm \"Darbe\"lerin Krit. Hasarı %20 artar. Savaş başladığında, eline 1 adet <DerivativeCardKeywords_40:\"Geçici Güzellik\"> ekle."
  },
  RelicConfig_13841_Desc = {
    Text = "Tüm \"Darbe\"lerin Krit. Hasarı %20 artar. Savaş başladığında, eline 1 adet <DerivativeCardKeywords_40:\"Geçici Güzellik\"> ekle."
  },
  RelicConfig_13841_Name = {
    Text = "<WhiteQuality:Geçici Güzellik>"
  },
  RelicConfig_13841_StoryDesc = {
    Text = "Gelip geçen anların güzelliğini sonsuza dek muhafaza et."
  },
  RelicConfig_13842_BattleDesc = {
    Text = "Ölüm Direnci tetiklenmemişse, bir kez Gelen Ölümcül Hasara Bağışıklık kazan, [Arg1] HP yenile ve bu Kalıntıyı kalıcı olarak kaldır."
  },
  RelicConfig_13842_Desc = {
    Text = "Ölüm Direnci tetiklenmemişse, bir kez Gelen Ölümcül Hasara Bağışıklık kazan, [Arg1] HP yenile ve bu Kalıntıyı kalıcı olarak kaldır."
  },
  RelicConfig_13842_Name = {
    Text = "<OrangeQuality:Dublör Bebek>"
  },
  RelicConfig_13842_StoryDesc = {
    Text = "Hehehe, hehehe. Borçlu olan sensin, değil mi?"
  },
  RelicConfig_13844_BattleDesc = {
    Text = "<WeaknessIconKeywords:Zayıflık> uyguladığında [Arg1] Karakter Kalkanı kazanırsın; <VulnerabilityIconKeywords:Savunmasız> uyguladığında [Arg2] Geçici <PowerIconKeywords:STR> kazanırsın. Her iki Etki de 1 Tur içinde tetiklenirse, ek olarak [Arg1] Karakter Kalkanı ve [Arg2] Geçici <PowerIconKeywords:STR> kazanırsın."
  },
  RelicConfig_13844_Desc = {
    Text = "<WeaknessIconKeywords:Zayıflık> uyguladığında [Arg1] Karakter Kalkanı kazanırsın; <VulnerabilityIconKeywords:Savunmasız> uyguladığında [Arg2] Geçici <PowerIconKeywords:STR> kazanırsın. Her iki Etki de 1 Tur içinde tetiklenirse, ek olarak [Arg1] Karakter Kalkanı ve [Arg2] Geçici <PowerIconKeywords:STR> kazanırsın."
  },
  RelicConfig_13844_Name = {
    Text = "<OrangeQuality:Yaldızlı Çerçeve>"
  },
  RelicConfig_13844_StoryDesc = {
    Text = "Akli dengesi bozulmuş bir sanatçının son eseri; korku içindeki çehresini açığa vurduğu söylenir."
  },
  RelicConfig_13845_BattleDesc = {
    Text = "Son 1 Arithmetica'yı tükettiğinde, 2 Arithmetica kazan. Tur başına en fazla 2 kez tetiklenir."
  },
  RelicConfig_13845_Desc = {
    Text = "Son 1 Arithmetica'yı tükettiğinde, 2 Arithmetica kazan. Tur başına en fazla 2 kez tetiklenir."
  },
  RelicConfig_13845_Name = {
    Text = "<OrangeQuality:☆Diferansiyel Motor☆>"
  },
  RelicConfig_13845_StoryDesc = {
    Text = "“Tarihi değiştirdi.”"
  },
  RelicConfig_13846_BattleDesc = {
    Text = "Her HP kaybettiğinde, Savaş başına en fazla 10 kez olmak üzere [Arg1] <PowerIconKeywords:STR> kazan. Yığınlar tam olduğunda, kaybedilen HP’nin %25’ini geri kazan."
  },
  RelicConfig_13846_Desc = {
    Text = "Her HP kaybettiğinde, Savaş başına en fazla 10 kez olmak üzere [Arg1] <PowerIconKeywords:STR> kazan. Yığınlar tam olduğunda, kaybedilen HP’nin %25’ini geri kazan."
  },
  RelicConfig_13846_Name = {
    Text = "<OrangeQuality:Yüce Onur>"
  },
  RelicConfig_13846_StoryDesc = {
    Text = "Uzak bir çöl krallığında tanrı olarak yüceltildiği söylenen, zarif ve esrarengiz, siyah tüylü, kısa kıllı bir kedi. O ilahın adı artık zamanın sislerinde kaybolmuştur.\nTapıldı, yüceltildi, unutuldu—belki de tüm tanrıların kaderi budur."
  },
  RelicConfig_13847_BattleDesc = {
    Text = "Zayıflatma etkisi altındaki düşmanlara %20 daha fazla Hasar ver ve onları öldürdüğünde 20 Aliemus kazan."
  },
  RelicConfig_13847_Desc = {
    Text = "Zayıflatma etkisi altındaki düşmanlara %20 daha fazla Hasar ver ve onları öldürdüğünde 20 Aliemus kazan."
  },
  RelicConfig_13847_Name = {
    Text = "<OrangeQuality:Hierofant Asası>"
  },
  RelicConfig_13847_StoryDesc = {
    Text = "Yaptırımsız Takva"
  },
  RelicConfig_13848_BattleDesc = {
    Text = "Alındığında, ekibin Diyar Ustalığı temel değerinin %150’sine çıkar. Her tur oynanan 5. Komut Kartından sonra tüm Uyananlar 20 Aliemus kazanır."
  },
  RelicConfig_13848_Desc = {
    Text = "Alındığında, ekibin Diyar Ustalığı temel değerinin %150’sine çıkar. Her tur oynanan 5. Komut Kartından sonra tüm Uyananlar 20 Aliemus kazanır."
  },
  RelicConfig_13848_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Kirli\">"
  },
  RelicConfig_13849_BattleDesc = {
    Text = "Her tur verilen 3. Hasardan sonra [Arg1] Karakter Kalkanı kazan. Her tur verilen 6. Hasardan sonra [Arg2] <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13849_Desc = {
    Text = "Her tur verilen 3. Hasardan sonra [Arg1] Karakter Kalkanı kazan. Her tur verilen 6. Hasardan sonra [Arg2] <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13849_Name = {
    Text = "<WhiteQuality:Güvenli Çıkış>"
  },
  RelicConfig_13849_StoryDesc = {
    Text = "Görünüşe bakılırsa o da dışarı çıkamamış."
  },
  RelicConfig_13851_BattleDesc = {
    Text = "Her bir <DevouredIconKeywords:Devour> için, tüm düşmanlardan [Arg1] Geçici <PowerIconKeywords:STR> Çalma."
  },
  RelicConfig_13851_Desc = {
    Text = "Her bir <DevouredIconKeywords:Devour> için, tüm düşmanlardan [Arg1] Geçici <PowerIconKeywords:STR> Çalma."
  },
  RelicConfig_13851_Name = {
    Text = "<OrangeQuality:Hayalet El>"
  },
  RelicConfig_13851_StoryDesc = {
    Text = "Öldürmek, yağmalamak ve kaşımak için kusursuz bir araç."
  },
  RelicConfig_13852_BattleDesc = {
    Text = "Alındığında, Uyanış için bir Uyanan seç. Onun Uyandırma kartının Arithmetica Maliyeti kalıcı olarak 1 azalır."
  },
  RelicConfig_13852_Desc = {
    Text = "Alındığında, Uyanış için bir Uyanan seç. Onun Uyandırma kartının Arithmetica Maliyeti kalıcı olarak 1 azalır."
  },
  RelicConfig_13852_Name = {
    Text = "<WhiteQuality:Sürpriz Anı>"
  },
  RelicConfig_13852_StoryDesc = {
    Text = "Eğlencesinin tadını çıkar, ama sakın yeme."
  },
  RelicConfig_13853_BattleDesc = {
    Text = "Hasar verildiğinde [Arg1] Geçici <RetaliateIconKeywords:Karşı Saldırı> kazan. Bu tur başına en fazla 5 kez tetiklenebilir ve 5. kez tetiklendiğinde Çekme Destesi'ne bir <DerivativeCardKeywords_4:\"Kavrayış\"> koy."
  },
  RelicConfig_13853_Desc = {
    Text = "Hasar verildiğinde [Arg1] Geçici <RetaliateIconKeywords:Karşı Saldırı> kazan. Bu tur başına en fazla 5 kez tetiklenebilir ve 5. kez tetiklendiğinde Çekme Destesi'ne bir <DerivativeCardKeywords_4:\"Kavrayış\"> koy."
  },
  RelicConfig_13853_Name = {
    Text = "<WhiteQuality:Ritüel Hançeri>"
  },
  RelicConfig_13853_StoryDesc = {
    Text = "Eğri bıçaklı bir hançer; genellikle kurban ayinlerinde kullanılır."
  },
  RelicConfig_13854_BattleDesc = {
    Text = "Tur başında, 2 kart çek ve 2 Arithmetica kazan. Ne zaman bir Komut Kartı çekersen ya da Coşku yaşarsan, onun Arithmetica Maliyetini rastgele değiştir. (0-4)"
  },
  RelicConfig_13854_Desc = {
    Text = "Tur başında, 2 kart çek ve 2 Arithmetica kazan. Ne zaman bir Komut Kartı çekersen ya da Coşku yaşarsan, onun Arithmetica Maliyetini rastgele değiştir. (0-4)"
  },
  RelicConfig_13854_Name = {
    Text = "<RedQuality:Düzenbazın Şapkası>"
  },
  RelicConfig_13854_StoryDesc = {
    Text = "Hoş Geldin Bayan Casiah'ın Harikalar Sirki'ne! Dikkatli ol, sihir eşyalarına dokunma. Isırılırsan, sonun kötü olabilir.\nEn son kan tattığında, sonuç korkunç olmuştu.\n\nSilindir Şapka, her an belirmeye hazırmış gibi göz kırptı."
  },
  RelicConfig_13855_BattleDesc = {
    Text = "Tur başında ve Can her yenilendiğinde, [Arg1] <RetaliateIconKeywords:Karşı Atak> kazan. Tur başına en fazla 3 kez gerçekleşebilir. Limite ulaşıldığında, tüm düşmanlara karşı %100 <RetaliateIconKeywords:Karşı Atak> tetikle."
  },
  RelicConfig_13855_Desc = {
    Text = "Tur başında ve Can her yenilendiğinde, [Arg1] <RetaliateIconKeywords:Karşı Atak> kazan. Tur başına en fazla 3 kez gerçekleşebilir. Limite ulaşıldığında, tüm düşmanlara karşı %100 <RetaliateIconKeywords:Karşı Atak> tetikle."
  },
  RelicConfig_13855_Name = {
    Text = "<OrangeQuality:Küçük Müzik Kutusu>"
  },
  RelicConfig_13855_StoryDesc = {
    Text = "Dexter’ın malikanesinde pek çok koleksiyon vardır. Kırılmadan önce, küçük müzik kutusu Bayan Dexter’ın en sevdiği oyuncaktı.\nZaman geçti; Bayan Dexter onu yeniden bulduğunda dişlileri gevşemiş, melodisi falsoluymuş, ama dönmeye hâlâ devam ediyordu."
  },
  RelicConfig_13856_BattleDesc = {
    Text = "Krit. Hasar %15 artar. \"Darbe\" Krit. Oranı %40 artar."
  },
  RelicConfig_13856_Desc = {
    Text = "Krit. Hasar %15 artar. \"Darbe\" Krit. Oranı %40 artar."
  },
  RelicConfig_13856_Name = {
    Text = "<WhiteQuality:Fildişi Karga Gagası>"
  },
  RelicConfig_13856_StoryDesc = {
    Text = "Onun önünde hiçbir Sır yoktur."
  },
  RelicConfig_13857_BattleDesc = {
    Text = "Taşkınlık serbest bırakıldıktan sonra, [Arg1] <RetaliateIconKeywords:Sayaç> kazan. Bu, bu savaştaki 6. tetiklenişinse, <RetaliateIconKeywords:Sayaç> değerini ikiye katla."
  },
  RelicConfig_13857_Desc = {
    Text = "Taşkınlık serbest bırakıldıktan sonra, [Arg1] <RetaliateIconKeywords:Sayaç> kazan. Bu, bu savaştaki 6. tetiklenişinse, <RetaliateIconKeywords:Sayaç> değerini ikiye katla."
  },
  RelicConfig_13857_Name = {
    Text = "<OrangeQuality:☆Sekstant☆>"
  },
  RelicConfig_13857_StoryDesc = {
    Text = "Önünde uzanan tek yol, sapkın bir yanılsamadan ibaret."
  },
  RelicConfig_13858_BattleDesc = {
    Text = "Her tur 1 fazladan kart çek ve 1 Arithmetica kazan."
  },
  RelicConfig_13858_Desc = {
    Text = "Her tur 1 fazladan kart çek ve 1 Arithmetica kazan."
  },
  RelicConfig_13858_Name = {
    Text = "<OrangeQuality:☆Tatlı Anılar☆>"
  },
  RelicConfig_13858_StoryDesc = {
    Text = "Bazı insanlar o yazda sonsuza dek kaldı."
  },
  RelicConfig_13859_BattleDesc = {
    Text = "Tur başında 1 kart çek. Savaş başında, destesine 1 adet <DerivativeCardKeywords_4:\"Kavrayış\"> karıştır. Her savaş, destesine karıştırılan <DerivativeCardKeywords_4:\"Kavrayış\"> kartlarının sayısını 1 artırır, en fazla 3 kez."
  },
  RelicConfig_13859_Desc = {
    Text = "Tur başında 1 kart çek. Savaş başında, destesine 1 adet <DerivativeCardKeywords_4:\"Kavrayış\"> karıştır. Her savaş, destesine karıştırılan <DerivativeCardKeywords_4:\"Kavrayış\"> kartlarının sayısını 1 artırır, en fazla 3 kez."
  },
  RelicConfig_13859_Name = {
    Text = "<OrangeQuality:Prasno Merceği>"
  },
  RelicConfig_13859_StoryDesc = {
    Text = "Işık ve Gölgenin Hilesi"
  },
  RelicConfig_13860_BattleDesc = {
    Text = "Aynı Uyanışçının kartları art arda oynandığında, o Uyanışçı 8 Aliemus kazanır."
  },
  RelicConfig_13860_Desc = {
    Text = "Aynı Uyanışçının kartları art arda oynandığında, o Uyanışçı 8 Aliemus kazanır."
  },
  RelicConfig_13860_Name = {
    Text = "<WhiteQuality:Kronometrik Cihaz>"
  },
  RelicConfig_13860_StoryDesc = {
    Text = "İnsanlık tarihindeki en uğursuz icatlardan biri."
  },
  RelicConfig_13861_BattleDesc = {
    Text = "Seçildiğinde, bir Uyandırana ait bir kart seç; Arithmetica Maliyetini 1 azalt ve onu \"Darbe\" olarak kabul et."
  },
  RelicConfig_13861_Desc = {
    Text = "Seçildiğinde, bir Uyandırana ait bir kart seç; Arithmetica Maliyetini 1 azalt ve onu \"Darbe\" olarak kabul et."
  },
  RelicConfig_13861_Name = {
    Text = "<OrangeQuality:Rastlantısal Yanılgı>"
  },
  RelicConfig_13861_StoryDesc = {
    Text = "Gönlünce gül!"
  },
  RelicConfig_13862_BattleDesc = {
    Text = "Alındığında, Kalıcı olarak [Arg1] <PowerIconKeywords:Kaba Güç> kaybedersin. Ne zaman Hasar verirsen, her seferinde [Arg2] CP iyileşirsin; tur başına en fazla 6 kez tetiklenir."
  },
  RelicConfig_13862_Desc = {
    Text = "Alındığında, Kalıcı olarak [Arg1] <PowerIconKeywords:Kaba Güç> kaybedersin. Ne zaman Hasar verirsen, her seferinde [Arg2] CP iyileşirsin; tur başına en fazla 6 kez tetiklenir."
  },
  RelicConfig_13862_Name = {
    Text = "<RedQuality:Yedi Solungaçlı Öpücük>"
  },
  RelicConfig_13862_StoryDesc = {
    Text = "Derin bir öpücük ister misin? Canını alan cinsten."
  },
  RelicConfig_13863_BattleDesc = {
    Text = "Her savaşın ilk turunda 3 Arithmetica kazan."
  },
  RelicConfig_13863_Desc = {
    Text = "Her savaşın ilk turunda 3 Arithmetica kazan."
  },
  RelicConfig_13863_Name = {
    Text = "<WhiteQuality:Cep Saati Aynası>"
  },
  RelicConfig_13863_StoryDesc = {
    Text = "Geçmişte katılaşmış, siyah derinliklerin dibine gömülmüş anılar."
  },
  RelicConfig_13864_BattleDesc = {
    Text = "Her tur ilk kez bir Komut Kartı oynadıktan sonra, Uyandırana karşılık gelen bir \"Darbe\"yi eline koy ve ona <NothingnessIconKeywords:Geçici Güzellik> ile <DepleteIconKeywords:Tüketme> ver."
  },
  RelicConfig_13864_Desc = {
    Text = "Her tur ilk kez bir Komut Kartı oynadıktan sonra, Uyandırana karşılık gelen bir \"Darbe\"yi eline koy ve ona <NothingnessIconKeywords:Geçici Güzellik> ile <DepleteIconKeywords:Tüketme> ver."
  },
  RelicConfig_13864_Name = {
    Text = "<WhiteQuality:Modern Dingil>"
  },
  RelicConfig_13864_StoryDesc = {
    Text = "Kırlardan şehre, felaketten topraktan yeniden doğuşa doğru bir yolculuk."
  },
  RelicConfig_13865_BattleDesc = {
    Text = "Her tur ilk kez bir Komut Kartı oynadıktan sonra, Uyanış Sahibi’ne karşılık gelen bir \"Savunma\" kartını eline ekle ve ona <NothingnessIconKeywords:Gelip Geçici> ve <DepleteIconKeywords:Tüketme> ekle."
  },
  RelicConfig_13865_Desc = {
    Text = "Her tur ilk kez bir Komut Kartı oynadıktan sonra, Uyanış Sahibi’ne karşılık gelen bir \"Savunma\" kartını eline ekle ve ona <NothingnessIconKeywords:Gelip Geçici> ve <DepleteIconKeywords:Tüketme> ekle."
  },
  RelicConfig_13865_Name = {
    Text = "<WhiteQuality:Sessiz Prelüd>"
  },
  RelicConfig_13865_StoryDesc = {
    Text = "Ünlü kemancı Eric Eckstein’ın kemanı.\nArtık çalınamaz."
  },
  RelicConfig_13866_BattleDesc = {
    Text = "Her 3 turda bir, tüm düşmanlara 1 yığın <VulnerabilityIconKeywords:Savunmasız> ekle. Bir <VulnerabilityIconKeywords:Savunmasız> düşmana hasar verdikten sonra, onların Geçici <PowerIconKeywords:STR> değerini [Arg1] azalt; tur başına en fazla 3 kez tetiklenir."
  },
  RelicConfig_13866_Desc = {
    Text = "Her 3 turda bir, tüm düşmanlara 1 yığın <VulnerabilityIconKeywords:Savunmasız> ekle. Bir <VulnerabilityIconKeywords:Savunmasız> düşmana hasar verdikten sonra, onların Geçici <PowerIconKeywords:STR> değerini [Arg1] azalt; tur başına en fazla 3 kez tetiklenir."
  },
  RelicConfig_13866_Name = {
    Text = "<WhiteQuality:Bahar Ayini>"
  },
  RelicConfig_13866_StoryDesc = {
    Text = "Gecenin kahkahaları arasında, kano silueti gölün üzerinde zahmetsizce süzülür."
  },
  RelicConfig_13867_BattleDesc = {
    Text = "El sınırını 3 artır, ancak her tur 1 kart daha az çek. Tur sonunda tüm Semptom kartlarını ve Durum Kartlarını at, diğer kartları Sakla."
  },
  RelicConfig_13867_Desc = {
    Text = "El sınırını 3 artır, ancak her tur 1 kart daha az çek. Tur sonunda tüm Semptom kartlarını ve Durum Kartlarını at, diğer kartları Sakla."
  },
  RelicConfig_13867_Name = {
    Text = "<RedQuality:Bilinç Kazıması>"
  },
  RelicConfig_13867_StoryDesc = {
    Text = "Kadim kabile, ölülerin kafataslarına özel semboller kazımanın, ruhlarını sonsuza dek yanlarında tutacağına inanırdı."
  },
  RelicConfig_13868_BattleDesc = {
    Text = "Taşkınlığı 4 kez serbest bıraktıktan sonra, eldeki tüm kartların Arithmetica Maliyetini 1 azalt."
  },
  RelicConfig_13868_Desc = {
    Text = "Taşkınlığı 4 kez serbest bıraktıktan sonra, eldeki tüm kartların Arithmetica Maliyetini 1 azalt."
  },
  RelicConfig_13868_Name = {
    Text = "<WhiteQuality:☆Kaçış Planı☆>"
  },
  RelicConfig_13868_StoryDesc = {
    Text = "\"Binişin ardından lütfen önce kamarana en yakın acil çıkışı tespit et.\""
  },
  RelicConfig_13869_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Diyar Ustalığı> 100 artar. Her Aktif Hasar verildiğinde Geçici Dokunaç Hasarı [Arg1] artar; her Dokunaç Hasarı verildiğinde [Arg2] Kalkan kazanılır. Bu etki tur başına en fazla 6 kez tetiklenebilir."
  },
  RelicConfig_13869_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Diyar Ustalığı> 100 artar. Her Aktif Hasar verildiğinde Geçici Dokunaç Hasarı [Arg1] artar; her Dokunaç Hasarı verildiğinde [Arg2] Kalkan kazanılır. Bu etki tur başına en fazla 6 kez tetiklenebilir."
  },
  RelicConfig_13869_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Karabasan\">"
  },
  RelicConfig_13870_BattleDesc = {
    Text = "Tüketilen her 1 Arithmetica için, ilgili Uyandıran 2 Aliemus kazanır."
  },
  RelicConfig_13870_Desc = {
    Text = "Tüketilen her 1 Arithmetica için, ilgili Uyandıran 2 Aliemus kazanır."
  },
  RelicConfig_13870_Name = {
    Text = "<WhiteQuality:Gümüş Kurdele>"
  },
  RelicConfig_13870_StoryDesc = {
    Text = "Olay yerinde bulunan kurdele zorla iki parçaya ayrılmıştı.\nParçalardan biri yukarıdan süzülerek kızın avucuna kondu."
  },
  RelicConfig_13871_BattleDesc = {
    Text = "Tüm Uyananlar tur başında 10 Aliemus kazanır. Alındığında Maksimum HP %30 azalır."
  },
  RelicConfig_13871_Desc = {
    Text = "Tüm Uyananlar tur başında 10 Aliemus kazanır. Alındığında Maksimum HP %30 azalır."
  },
  RelicConfig_13871_Name = {
    Text = "<RedQuality:Kâbus Tezahürü>"
  },
  RelicConfig_13871_StoryDesc = {
    Text = "Dikkat et, müsamahakâr derin uyku, farkına bile varmadan her şeyi Yutma ile yok eder."
  },
  RelicConfig_13873_BattleDesc = {
    Text = "Tüm düşman Karakter Kalkanını kaldırmak için \"<ExaltIconKeywords:Rouse>\" oyna."
  },
  RelicConfig_13873_Desc = {
    Text = "Tüm düşman Karakter Kalkanını kaldırmak için \"<ExaltIconKeywords:Rouse>\" oyna."
  },
  RelicConfig_13873_Name = {
    Text = "Siyah Yansıma"
  },
  RelicConfig_13874_BattleDesc = {
    Text = "Tek sayılı turlarda, hiç kartın kalmamışsa 2 kart çek; çift sayılı turlarda, hiç Arithmetica’n kalmamışsa 2 Arithmetica kazan."
  },
  RelicConfig_13874_Desc = {
    Text = "Tek sayılı turlarda, hiç kartın kalmamışsa 2 kart çek; çift sayılı turlarda, hiç Arithmetica’n kalmamışsa 2 Arithmetica kazan."
  },
  RelicConfig_13874_Name = {
    Text = "Mutasyona Uğramış Altın Rehber"
  },
  RelicConfig_13875_BattleDesc = {
    Text = "\"Darbe\" ve \"Savunma\" kullandıktan sonra, ilgili Uyananlar 35 Aliemus kazanır. Ancak Arithmetica Maliyetleri +1 artar."
  },
  RelicConfig_13875_Desc = {
    Text = "\"Darbe\" ve \"Savunma\" kullandıktan sonra, ilgili Uyananlar 35 Aliemus kazanır. Ancak Arithmetica Maliyetleri +1 artar."
  },
  RelicConfig_13875_Name = {
    Text = "<RedQuality:Kırık Çehre>"
  },
  RelicConfig_13875_StoryDesc = {
    Text = "Dehşetle dolu yüzü, zamanın içinde donup kalmış."
  },
  RelicConfig_13877_BattleDesc = {
    Text = "Her tur 2. Kalkan kazanıldıktan sonra, [Arg1] <plural value=\"[Arg1]\" singular=\"yığın\" plural=\"yığın\"> <RetaliateIconKeywords:Karşı Atak> kazan. Her tur 4. Kalkan kazanıldıktan sonra, tüm düşmanlara karşı %100 <RetaliateIconKeywords:Karşı Atak> tetikle."
  },
  RelicConfig_13877_Desc = {
    Text = "Her tur 2. Kalkan kazanıldıktan sonra, [Arg1] <plural value=\"[Arg1]\" singular=\"yığın\" plural=\"yığın\"> <RetaliateIconKeywords:Karşı Atak> kazan. Her tur 4. Kalkan kazanıldıktan sonra, tüm düşmanlara karşı %100 <RetaliateIconKeywords:Karşı Atak> tetikle."
  },
  RelicConfig_13877_Name = {
    Text = "<WhiteQuality:Bildiğini Saklamayan>"
  },
  RelicConfig_13877_StoryDesc = {
    Text = "İster isteyerek ister istemeden, sayısız sır iletir."
  },
  RelicConfig_13878_BattleDesc = {
    Text = "6. Komut Kartını oynamak, onu Atılmış Kart Desteğinden eline geri döndürür."
  },
  RelicConfig_13878_Desc = {
    Text = "6. Komut Kartını oynamak, onu Atılmış Kart Desteğinden eline geri döndürür."
  },
  RelicConfig_13878_Name = {
    Text = "<OrangeQuality:Alacakaranlıkta>"
  },
  RelicConfig_13878_StoryDesc = {
    Text = "Hadi birlikte bir fotoğraf çekinelim! Gerçek acının hissini tat."
  },
  RelicConfig_13879_BattleDesc = {
    Text = "5 Yücelik serbest bırakıldıktan sonra, Yücelikleri serbest bırakan Uyandıran 100 Aliemus kazanır."
  },
  RelicConfig_13879_Desc = {
    Text = "5 Yücelik serbest bırakıldıktan sonra, Yücelikleri serbest bırakan Uyandıran 100 Aliemus kazanır."
  },
  RelicConfig_13879_Name = {
    Text = "<OrangeQuality:Küçük Beşik>"
  },
  RelicConfig_13879_StoryDesc = {
    Text = "Umut, lütuflar ve sevgiyi taşıyarak."
  },
  RelicConfig_13880_BattleDesc = {
    Text = "Aktif Hasar verdiğinde [Arg1] Kalkan kazan. HP yenilediğinde [Arg2] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13880_Desc = {
    Text = "Aktif Hasar verdiğinde [Arg1] Kalkan kazan. HP yenilediğinde [Arg2] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13880_Name = {
    Text = "<OrangeQuality:Yuvamız>"
  },
  RelicConfig_13880_StoryDesc = {
    Text = "Geçmişte birlikteydiler, gelecekte de daima birlikte olacaklar. Sıkı sıkıya bağlı, sevgi dolu bir aileler."
  },
  RelicConfig_13881_BattleDesc = {
    Text = "Tek sayılı bir turun başında [Arg1] Geçici<PowerIconKeywords:STR> kazan. Çift sayılı bir turun başında [Arg2] Geçici<AlertIconKeywords:Alert> kazan."
  },
  RelicConfig_13881_Desc = {
    Text = "Tek sayılı bir turun başında [Arg1] Geçici<PowerIconKeywords:STR> kazan. Çift sayılı bir turun başında [Arg2] Geçici<AlertIconKeywords:Alert> kazan."
  },
  RelicConfig_13881_Name = {
    Text = "<WhiteQuality:İkiz Bebekler>"
  },
  RelicConfig_13881_StoryDesc = {
    Text = "İkidoğuş, eski çağdan kalma bir hediyedir; geleceğe dair bir meseldir."
  },
  RelicConfig_13882_BattleDesc = {
    Text = "Her turun sonunda, ilgili Uyandırma yapan ilk Komut Kartını oynadığında 20 Aliemus kazan. Ayrıca \"Adanmış Yürek\" yadigârına da sahipsen, diğer Uyandıranlar da 5 Aliemus kazanır."
  },
  RelicConfig_13882_Desc = {
    Text = "Her turun sonunda, ilgili Uyandırma yapan ilk Komut Kartını oynadığında 20 Aliemus kazan. Ayrıca \"Adanmış Yürek\" yadigârına da sahipsen, diğer Uyandıranlar da 5 Aliemus kazanır."
  },
  RelicConfig_13882_Name = {
    Text = "<WhiteQuality:Anne Heykeli>"
  },
  RelicConfig_13882_StoryDesc = {
    Text = "“Sana her şeyi veririm, ne istersen, lütfen onu bırak.”"
  },
  RelicConfig_13883_BattleDesc = {
    Text = "Bir Uyanışçı bir kez <DevouredIconKeywords:Devour> olduğunda, diğer Uyanışçılar 10 Aliemus kazanır."
  },
  RelicConfig_13883_Desc = {
    Text = "Bir Uyanışçı bir kez <DevouredIconKeywords:Devour> olduğunda, diğer Uyanışçılar 10 Aliemus kazanır."
  },
  RelicConfig_13883_Name = {
    Text = "<OrangeQuality:Altın Düş Diyarı>"
  },
  RelicConfig_13883_StoryDesc = {
    Text = "Dönüşüm günü, senin kıyametin olacak."
  },
  RelicConfig_13884_BattleDesc = {
    Text = "\"Darbe\", tüm düşmanlara [Arg1] yığın <IntoxicationIconKeywords:Zehir> uygular."
  },
  RelicConfig_13884_Desc = {
    Text = "\"Darbe\", tüm düşmanlara [Arg1] yığın <IntoxicationIconKeywords:Zehir> uygular."
  },
  RelicConfig_13884_Name = {
    Text = "<WhiteQuality:Nörotoksin>"
  },
  RelicConfig_13884_StoryDesc = {
    Text = "Çek, Arıt."
  },
  RelicConfig_13885_BattleDesc = {
    Text = "Savaşın başında ele 1 <DerivativeCardKeywords_1:Kayıp Gölgelerin Yankısı> yerleştir. Eğer bir Reis Savaşı ise, fazladan 1 <DerivativeCardKeywords_1:Kayıp Gölgelerin Yankısı> kazan."
  },
  RelicConfig_13885_Desc = {
    Text = "Savaşın başında ele 1 <DerivativeCardKeywords_1:Kayıp Gölgelerin Yankısı> yerleştir. Eğer bir Reis Savaşı ise, fazladan 1 <DerivativeCardKeywords_1:Kayıp Gölgelerin Yankısı> kazan."
  },
  RelicConfig_13885_Name = {
    Text = "<WhiteQuality:Sinyal Aktarıcı>"
  },
  RelicConfig_13885_StoryDesc = {
    Text = "Çalacağı anı özle ya da ondan dehşet duy."
  },
  RelicConfig_13886_BattleDesc = {
    Text = "Desteği her sıfırladığında, eline 2 <DerivativeCardKeywords_5:Barbed Trident> ve 1 <DerivativeCardKeywords_6:Parasol> ekle."
  },
  RelicConfig_13886_Desc = {
    Text = "Desteği her sıfırladığında, eline 2 <DerivativeCardKeywords_5:Barbed Trident> ve 1 <DerivativeCardKeywords_6:Parasol> ekle."
  },
  RelicConfig_13886_Name = {
    Text = "<WhiteQuality:☆Hanımefendi Çantası☆>"
  },
  RelicConfig_13886_StoryDesc = {
    Text = "Zarafeti taşımak için yapılmıştı, ölümü değil."
  },
  RelicConfig_13887_BattleDesc = {
    Text = "Tur başında eline 1 adet <DerivativeCardKeywords_5:\"Dikenli Üç Dişli Zıpkın\"> ekle. Yüceltme serbest bırakıldıktan sonra, elindeki tüm <DerivativeCardKeywords_5:\"Dikenli Üç Dişli Zıpkın\"> kartlarının <PowerIconKeywords:STR> değerini [Arg2] artır."
  },
  RelicConfig_13887_Desc = {
    Text = "Tur başında eline 1 adet <DerivativeCardKeywords_5:\"Dikenli Üç Dişli Zıpkın\"> ekle. Yüceltme serbest bırakıldıktan sonra, elindeki tüm <DerivativeCardKeywords_5:\"Dikenli Üç Dişli Zıpkın\"> kartlarının <PowerIconKeywords:STR> değerini [Arg2] artır."
  },
  RelicConfig_13887_Name = {
    Text = "<WhiteQuality:Dikenli Üç Dişli Mızrak>"
  },
  RelicConfig_13887_StoryDesc = {
    Text = "Nasıl bakarsan bak, yalnızca sıradan."
  },
  RelicConfig_13888_BattleDesc = {
    Text = "Savaşın başında [Arg1] Karakter Kalkanı kazan. Bu savaşta \"Defense\"i 7 kez oynadıktan sonra anında [Arg2] Karakter Kalkanı kazan. Bu savaşta \"Defense\"i 21 kez oynadıktan sonra 1 yığın Geçici Bariyer kazan."
  },
  RelicConfig_13888_Desc = {
    Text = "Savaşın başında [Arg1] Karakter Kalkanı kazan. Bu savaşta \"Defense\"i 7 kez oynadıktan sonra anında [Arg2] Karakter Kalkanı kazan. Bu savaşta \"Defense\"i 21 kez oynadıktan sonra 1 yığın Geçici Bariyer kazan."
  },
  RelicConfig_13888_Name = {
    Text = "<WhiteQuality:Putney Sabah Postası>"
  },
  RelicConfig_13888_StoryDesc = {
    Text = "En düşünceli tuvalet yoldaşın."
  },
  RelicConfig_13889_BattleDesc = {
    Text = "Ultra Tur’a girildiğinde, 3 Arithmetica kazan."
  },
  RelicConfig_13889_Desc = {
    Text = "Ultra Tur’a girildiğinde, 3 Arithmetica kazan."
  },
  RelicConfig_13889_Name = {
    Text = "<WhiteQuality:Parıltı Kum Saati>"
  },
  RelicConfig_13889_StoryDesc = {
    Text = "Ölçülebilir bir zaman dilimi."
  },
  RelicConfig_13890_BattleDesc = {
    Text = "Savaş başında, tüm düşmanlara 1 tur boyunca <WeaknessIconKeywords:Zayıflık> ve <VulnerabilityIconKeywords:Savunmasız> uygula. Eğer bir Reis Savaşı ise, ek olarak 2 tur <WeaknessIconKeywords:Zayıflık> ve <VulnerabilityIconKeywords:Savunmasız> uygula."
  },
  RelicConfig_13890_Desc = {
    Text = "Savaş başında, tüm düşmanlara 1 tur boyunca <WeaknessIconKeywords:Zayıflık> ve <VulnerabilityIconKeywords:Savunmasız> uygula. Eğer bir Reis Savaşı ise, ek olarak 2 tur <WeaknessIconKeywords:Zayıflık> ve <VulnerabilityIconKeywords:Savunmasız> uygula."
  },
  RelicConfig_13890_Name = {
    Text = "<WhiteQuality:Renk Değiştiren Deli Gömleği>"
  },
  RelicConfig_13890_StoryDesc = {
    Text = "Yalnızca zaman değil, dehşet ve Pain de kumaşı soldurabilir."
  },
  RelicConfig_13891_BattleDesc = {
    Text = "Her tur oynanan ve bir Leap etkisini tetikleyen ilk Komut Kartı 1 kart çeker; aksi hâlde 1 Arithmetica kazanılır. Ultra Turlar sırasında her iki etki de uygulanır."
  },
  RelicConfig_13891_Desc = {
    Text = "Her tur oynanan ve bir Leap etkisini tetikleyen ilk Komut Kartı 1 kart çeker; aksi hâlde 1 Arithmetica kazanılır. Ultra Turlar sırasında her iki etki de uygulanır."
  },
  RelicConfig_13891_Name = {
    Text = "<OrangeQuality:Bükülme Cihazı>"
  },
  RelicConfig_13891_StoryDesc = {
    Text = "Çarpık bir gölgeyi yansıtır."
  },
  RelicConfig_13892_BattleDesc = {
    Text = "Bir görev kazan. Görevi tamamlayarak ödüller al. [Event Placeholder]"
  },
  RelicConfig_13892_Desc = {
    Text = "Bir görev kazan. Görevi tamamlayarak ödüller al. [Event Placeholder]"
  },
  RelicConfig_13892_Name = {
    Text = "<WhiteQuality:Yıpranmış Günlük>"
  },
  RelicConfig_13892_StoryDesc = {
    Text = "Elworth haritaları, deney günlükleri ve üçgen D-izleriyle işaretlenmiş mektuplarla doldurulmuş eski bir günlük.\nBaşlangıçtaki el yazısı düzenli ve tertipliyken, giderek dağınık ve kaotik bir hâl alır."
  },
  RelicConfig_13893_BattleDesc = {
    Text = "Her 4. Karakter Kalkanı kazandığında, o Karakter Kalkanı değerinin %50’si kadar HP iyileştir."
  },
  RelicConfig_13893_Desc = {
    Text = "Her 4. Karakter Kalkanı kazandığında, o Karakter Kalkanı değerinin %50’si kadar HP iyileştir."
  },
  RelicConfig_13893_Name = {
    Text = "<WhiteQuality:Denizci Düdüğü>"
  },
  RelicConfig_13893_StoryDesc = {
    Text = "Denizkızlarının yanı sıra, düdük kasırgalar, kokmuş çizmeler ve yüz gündür yıkanmamış denizciler de çağırabilir."
  },
  RelicConfig_13894_BattleDesc = {
    Text = "Önceki turda oynanan kart sayısı 4 veya daha azsa, bu tur oynanan ilk kart iki kez etkisini gösterir."
  },
  RelicConfig_13894_Desc = {
    Text = "Önceki turda oynanan kart sayısı 4 veya daha azsa, bu tur oynanan ilk kart iki kez etkisini gösterir."
  },
  RelicConfig_13894_Name = {
    Text = "<OrangeQuality:☆Kâbus Feneri☆>"
  },
  RelicConfig_13894_StoryDesc = {
    Text = "Fantazma’yı oyuna sok."
  },
  RelicConfig_13895_BattleDesc = {
    Text = "Her HP kaybettiğinde, en az Aliemus’a sahip Uyandırıcı 10 Aliemus kazanır.\nHer 5. HP kaybedişinde, kaybedilen HP’nin %20’sini geri kazan."
  },
  RelicConfig_13895_Desc = {
    Text = "Her HP kaybettiğinde, en az Aliemus’a sahip Uyandırıcı 10 Aliemus kazanır.\nHer 5. HP kaybedişinde, kaybedilen HP’nin %20’sini geri kazan."
  },
  RelicConfig_13895_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Çözümleme\">"
  },
  RelicConfig_13896_BattleDesc = {
    Text = "Maksimum Arithmetica +2. Deste her sıfırlandığında, Çekme Desteğine 1 adet <DerivativeCardKeywords_9:\"Sendeleme\"> ekle."
  },
  RelicConfig_13896_Desc = {
    Text = "Maksimum Arithmetica +2. Deste her sıfırlandığında, Çekme Desteğine 1 adet <DerivativeCardKeywords_9:\"Sendeleme\"> ekle."
  },
  RelicConfig_13896_Name = {
    Text = "<RedQuality:Kara Mum>"
  },
  RelicConfig_13896_StoryDesc = {
    Text = "Berraklıkta yan, düşe düş."
  },
  RelicConfig_13897_BattleDesc = {
    Text = "\"<ExaltIconKeywords:Rouse> Kartlar tur sonunda saklanır."
  },
  RelicConfig_13897_Desc = {
    Text = "\"<ExaltIconKeywords:Rouse> Kartlar tur sonunda saklanır."
  },
  RelicConfig_13897_Name = {
    Text = "Beyaz Yansıma"
  },
  RelicConfig_13898_BattleDesc = {
    Text = "Uyanışa geçmiş her Uyandıran için <ProficientInRealmsIconKeywords:Diyar Ustalığı>nı 35 artır. \"<ExaltIconKeywords:Uyanış>\" oynadıktan sonra, o Uyandırana ait 2 rastgele Komut Kartı kazan ve onlara \"Tüketme\" ekle."
  },
  RelicConfig_13898_Desc = {
    Text = "Uyanışa geçmiş her Uyandıran için <ProficientInRealmsIconKeywords:Diyar Ustalığı>nı 35 artır. \"<ExaltIconKeywords:Uyanış>\" oynadıktan sonra, o Uyandırana ait 2 rastgele Komut Kartı kazan ve onlara \"Tüketme\" ekle."
  },
  RelicConfig_13898_Name = {
    Text = "<OrangeQuality:İlahi Kehanet>"
  },
  RelicConfig_13898_StoryDesc = {
    Text = "“Korkma,” dedi."
  },
  RelicConfig_13899_BattleDesc = {
    Text = "Tur başında, <ProficientInRealmsIconKeywords:Diyar Ustalığı> 50 artar. Bir zayıflatma etkisi altında değilken, <ProficientInRealmsIconKeywords:Diyar Ustalığı> 150’ye çıkar."
  },
  RelicConfig_13899_Desc = {
    Text = "Tur başında, <ProficientInRealmsIconKeywords:Diyar Ustalığı> 50 artar. Bir zayıflatma etkisi altında değilken, <ProficientInRealmsIconKeywords:Diyar Ustalığı> 150’ye çıkar."
  },
  RelicConfig_13899_Name = {
    Text = "<WhiteQuality:☆\"Özgürlüğe\"☆>"
  },
  RelicConfig_13899_StoryDesc = {
    Text = "İçinde Nostalji uyandıran bir avuç Gümüş."
  },
  RelicConfig_13900_BattleDesc = {
    Text = "\"Yüceltme\"yi kullandıktan sonra, tüm kartların Arithmetica Maliyeti 1 azaltılır."
  },
  RelicConfig_13900_Desc = {
    Text = "\"Yüceltme\"yi kullandıktan sonra, eldeki tüm kartların Arithmetica Maliyetleri 1 azalır."
  },
  RelicConfig_13900_Name = {
    Text = "Mutasyona Uğramış Uygarlığın Işığı"
  },
  RelicConfig_13901_BattleDesc = {
    Text = "Her Komut Kartı oynadığında [Arg2]% <DeathResistanceIconKeywords:Ölüm Direnci> elde et (bu aşamada Ölüm Direnci her tetiklendiğinde, kazanılan Ölüm Direnci yarıya iner). Eğer <DeathResistanceIconKeywords:Ölüm Direncin> %100’e eşit ya da daha yüksekse, bunun yerine [Arg1] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13901_Desc = {
    Text = "Her Komut Kartı oynadığında [Arg2]% <DeathResistanceIconKeywords:Ölüm Direnci> elde et (bu aşamada Ölüm Direnci her tetiklendiğinde, kazanılan Ölüm Direnci yarıya iner). Eğer <DeathResistanceIconKeywords:Ölüm Direncin> %100’e eşit ya da daha yüksekse, bunun yerine [Arg1] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13901_Name = {
    Text = "<OrangeQuality:Yılanın Kabuğu>"
  },
  RelicConfig_13901_StoryDesc = {
    Text = "Kendi kendini sakatlayarak topraktan yeniden doğuş"
  },
  RelicConfig_13902_BattleDesc = {
    Text = "Tur başında, [Arg2] Kalkan kazan. Tur sonunda, rastgele bir düşmana mevcut Kalkanınızın [Arg1]%'sine eşit <FixedDamage:Saf Hasar> ver. Patron Savaşlarında hasar etkisi iki katına çıkar."
  },
  RelicConfig_13902_Desc = {
    Text = "Tur başında, [Arg2] Kalkan kazan. Tur sonunda, rastgele bir düşmana mevcut Kalkanınızın [Arg1]%'sine eşit <FixedDamage:Saf Hasar> ver. Patron Savaşlarında hasar etkisi iki katına çıkar."
  },
  RelicConfig_13902_Name = {
    Text = "<WhiteQuality:Altın Yolak>"
  },
  RelicConfig_13902_StoryDesc = {
    Text = "Kaybolduğunda onu aç. Ama dikkatli ol — tacı asla güneş ışığına maruz kalmamalı."
  },
  RelicConfig_13904_BattleDesc = {
    Text = "Canavar Niyetlerini gizle. Her tur 1 Arithmetica kazan ve 1 kart çek."
  },
  RelicConfig_13904_Desc = {
    Text = "Canavar Niyetlerini gizle. Her tur 1 Arithmetica kazan ve 1 kart çek."
  },
  RelicConfig_13904_Name = {
    Text = "<RedQuality:Büyüleyici Çan>"
  },
  RelicConfig_13904_StoryDesc = {
    Text = "Şıngır, şıngır."
  },
  RelicConfig_13905_BattleDesc = {
    Text = "Savaş başladıktan sonra, [Arg2] yığın <RetaliateIconKeywords:Sayaç> kazan. \"Savunma\" oynandığında, [Arg1] yığın <RetaliateIconKeywords:Sayaç> kazan."
  },
  RelicConfig_13905_Desc = {
    Text = "Savaş başladıktan sonra, [Arg2] yığın <RetaliateIconKeywords:Sayaç> kazan. \"Savunma\" oynandığında, [Arg1] yığın <RetaliateIconKeywords:Sayaç> kazan."
  },
  RelicConfig_13905_Name = {
    Text = "<WhiteQuality:Isırgan Yelek>"
  },
  RelicConfig_13905_StoryDesc = {
    Text = "Bulaşmış olan sıvı tespit edilemiyor."
  },
  RelicConfig_13906_BattleDesc = {
    Text = "Bu, Etkisi olmayan haftalık bir Kalıntı 4"
  },
  RelicConfig_13906_Desc = {
    Text = "Bu, Etkisi olmayan haftalık bir Kalıntı 4"
  },
  RelicConfig_13906_Name = {
    Text = "Günlük Mücadele Haftalık Yedek Kutsal Eşya 4"
  },
  RelicConfig_13907_BattleDesc = {
    Text = "Tur başında, önceki turda 3’ten fazla kart oynadıysan 2 kart çek."
  },
  RelicConfig_13907_Desc = {
    Text = "Tur başında, önceki turda 3’ten fazla kart oynadıysan 2 kart çek."
  },
  RelicConfig_13907_Name = {
    Text = "<WhiteQuality:Yepyeni Cüzdan>"
  },
  RelicConfig_13907_StoryDesc = {
    Text = "Mythag Üniversitesi'nin arması işlenmiş deri bir cüzdan.\nArtık bomboş, içinde hiçbir şey yok."
  },
  RelicConfig_13908_BattleDesc = {
    Text = "\"Yüceltme\"yi kullandıktan sonra, Uyandırıcı [Arg1] Aliemus kazanır."
  },
  RelicConfig_13908_Desc = {
    Text = "\"Yüceltme\"yi kullandıktan sonra, Uyandırıcı [Arg1] Aliemus kazanır."
  },
  RelicConfig_13908_Name = {
    Text = "Mutasyona Uğramış İsimsiz Tanrının Peçesi"
  },
  RelicConfig_13909_BattleDesc = {
    Text = "Taşkınlık salındıktan sonra mevcut HP’nin %8’ini kaybet, tüm düşmanlardan [Arg1] Geçici <PowerIconKeywords:STR> çal. Yalnızca 1 düşman varsa, fazladan [Arg2] Geçici <PowerIconKeywords:STR> çal."
  },
  RelicConfig_13909_Desc = {
    Text = "Taşkınlık salındıktan sonra mevcut HP’nin %8’ini kaybet, tüm düşmanlardan [Arg1] Geçici <PowerIconKeywords:STR> çal. Yalnızca 1 düşman varsa, fazladan [Arg2] Geçici <PowerIconKeywords:STR> çal."
  },
  RelicConfig_13909_Name = {
    Text = "<RedQuality:Kehanet Ritüel Kuşu>"
  },
  RelicConfig_13909_StoryDesc = {
    Text = "Çürümüş ceset bir çığlık kopardı."
  },
  RelicConfig_13910_BattleDesc = {
    Text = "Taşkınlıktan sonra, ilgili Uyandıran 10 Aliemus ve [Arg1] Karakter Kalkanı kazanır."
  },
  RelicConfig_13910_Desc = {
    Text = "Taşkınlıktan sonra, ilgili Uyandıran 10 Aliemus ve [Arg1] Karakter Kalkanı kazanır."
  },
  RelicConfig_13910_Name = {
    Text = "<OrangeQuality:İsimsiz Tanrının Peçesi>"
  },
  RelicConfig_13910_StoryDesc = {
    Text = "Tanrılara doğrudan bakma."
  },
  RelicConfig_13911_BattleDesc = {
    Text = "Her turun sonunda, son Komut Kartını oynayan ilgili Uyandıran 20 Aliemus kazanır. Ayrıca \"Anne Heykeli\" yadigârına da sahipse, diğer Uyandıranlar da 5 Aliemus kazanır."
  },
  RelicConfig_13911_Desc = {
    Text = "Her turun sonunda, son Komut Kartını oynayan ilgili Uyandıran 20 Aliemus kazanır. Ayrıca \"Anne Heykeli\" yadigârına da sahipse, diğer Uyandıranlar da 5 Aliemus kazanır."
  },
  RelicConfig_13911_Name = {
    Text = "<WhiteQuality:Adanmış Yürek>"
  },
  RelicConfig_13911_StoryDesc = {
    Text = "“Sana her şeyi veririm, ne olursa olsun. Lütfen beni bağışla.”"
  },
  RelicConfig_13912_BattleDesc = {
    Text = "Tur sonunda, elde kalan her kart için, bir sonraki turun başında 1 Arithmetica kazan."
  },
  RelicConfig_13912_Desc = {
    Text = "Tur sonunda, elde kalan her kart için, bir sonraki turun başında 1 Arithmetica kazan."
  },
  RelicConfig_13912_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Yorumlama\">"
  },
  RelicConfig_13913_BattleDesc = {
    Text = "Tur başında, HP [Arg1] değerinden yüksekse [Arg1] HP kaybet ve bu tur için [Arg2] <PowerIconKeywords:STR> ve [Arg3] <AlertIconKeywords:Alarm> kazan."
  },
  RelicConfig_13913_Desc = {
    Text = "Tur başında, HP [Arg1] değerinden yüksekse [Arg1] HP kaybet ve bu tur için [Arg2] <PowerIconKeywords:STR> ve [Arg3] <AlertIconKeywords:Alarm> kazan."
  },
  RelicConfig_13913_Name = {
    Text = "<RedQuality:Kurtuluş Uzvu>"
  },
  RelicConfig_13913_StoryDesc = {
    Text = "Kutsal bir parça.\nBedenden ayrılsa bile, sıcaklığı hâlâ hissedilebilir."
  },
  RelicConfig_13914_BattleDesc = {
    Text = "\"Saldırı\" 2 Arithmetica kazanır ve 1 rastgele kart atar; \"Savunma\" 2 kart çeker ve 1 Arithmetica kaybeder. Tur başına en fazla 3 kez tetiklenebilir."
  },
  RelicConfig_13914_Desc = {
    Text = "\"Saldırı\" 2 Arithmetica kazanır ve 1 rastgele kart atar; \"Savunma\" 2 kart çeker ve 1 Arithmetica kaybeder. Tur başına en fazla 3 kez tetiklenebilir."
  },
  RelicConfig_13914_Name = {
    Text = "<RedQuality:Neşeli Plak>"
  },
  RelicConfig_13914_StoryDesc = {
    Text = "Ünlü kemancının son performansının kaydı.\nO zamandan beri, alevleri çağırabilmektedir."
  },
  RelicConfig_13915_BattleDesc = {
    Text = "Önerilen Diyar güçlendirme etkisi %50’ye çıkar ve seviyenin başında <ProficientInRealmsIconKeywords:Diyar Ustalığı>n iki katına çıkar."
  },
  RelicConfig_13915_Desc = {
    Text = "Önerilen Diyar güçlendirme etkisi %50’ye çıkar ve seviyenin başında <ProficientInRealmsIconKeywords:Diyar Ustalığı>n iki katına çıkar."
  },
  RelicConfig_13915_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Morpheus\">"
  },
  RelicConfig_13916_BattleDesc = {
    Text = "Bir Taşkınlık tetikledikten sonra oynanan bir sonraki Komut Kartı iki kez etkisini gösterir."
  },
  RelicConfig_13916_Desc = {
    Text = "Bir Taşkınlık tetikledikten sonra oynanan bir sonraki Komut Kartı iki kez etkisini gösterir."
  },
  RelicConfig_13916_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Dalış\">"
  },
  RelicConfig_13917_BattleDesc = {
    Text = "Düşmanın niyeti saldırmaksa, Hasar verdikten sonra onların <PowerIconKeywords:STR> değerini geçici olarak [Arg1] azalt. Aksi hâlde, verilen Hasarın %25’ine eşit <BleedingIconKeywords:Bleed> uygula; tur başına en fazla 6 kez tetiklenir."
  },
  RelicConfig_13917_Desc = {
    Text = "Düşmanın niyeti saldırmaksa, Hasar verdikten sonra onların <PowerIconKeywords:STR> değerini geçici olarak [Arg1] azalt. Aksi hâlde, verilen Hasarın %25’ine eşit <BleedingIconKeywords:Bleed> uygula; tur başına en fazla 6 kez tetiklenir."
  },
  RelicConfig_13917_Name = {
    Text = "<WhiteQuality:Yabancı Kalp>"
  },
  RelicConfig_13917_StoryDesc = {
    Text = "İki “kalp” birbirine sokulmuş"
  },
  RelicConfig_13918_BattleDesc = {
    Text = "Her Hasar verildiğinde, en fazla 3 kez olmak üzere [Arg1] Geçici <PowerIconKeywords:STR> kazan. Yığınlar maksimumdayken Etki ikiye katlanır."
  },
  RelicConfig_13918_Desc = {
    Text = "Her Hasar verildiğinde, en fazla 3 kez olmak üzere [Arg1] Geçici <PowerIconKeywords:STR> kazan. Yığınlar maksimumdayken Etki ikiye katlanır."
  },
  RelicConfig_13918_Name = {
    Text = "<WhiteQuality:Telkâri Akik>"
  },
  RelicConfig_13918_StoryDesc = {
    Text = "Muhtemelen sıradan akik desenleridir. Belki."
  },
  RelicConfig_13919_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Diyar Ustalığı> 50 artar. Alındığında, bir Kalıntı seç ve onu rastgele birine dönüştür."
  },
  RelicConfig_13919_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Diyar Ustalığı> 50 artar. Alındığında, bir Kalıntı seç ve onu rastgele birine dönüştür."
  },
  RelicConfig_13919_Name = {
    Text = "<WhiteQuality:Kaleydoskop>"
  },
  RelicConfig_13919_StoryDesc = {
    Text = "Düşündüğün ve gördüğün her şey birer düş."
  },
  RelicConfig_13920_BattleDesc = {
    Text = "Verilen Zayıflık Etkisi %5 artar. <WeaknessIconKeywords:Zayıflık> uygularken, hedeften geçici olarak [Arg1] <PowerIconKeywords:STR> çal."
  },
  RelicConfig_13920_Desc = {
    Text = "Uygulanan Semptom: Zayıflık etkisi +%5. <WeaknessIconKeywords:Semptom: Zayıflık> uyguladığında, hedeften geçici olarak [Arg1] <PowerIconKeywords:GÜÇ> çal."
  },
  RelicConfig_13920_Name = {
    Text = "<WhiteQuality:Solgun Fotoğraf>"
  },
  RelicConfig_13920_StoryDesc = {
    Text = "Bulanık fotoğraf, bulanık bir Hafıza taşır; ya da belki de fotoğrafın solmasına yol açan, Hafıza’nın eksikliğidir."
  },
  RelicConfig_13921_BattleDesc = {
    Text = "Seçildiğinde, Silmek için 2 Komut Kartı seç ve [Arg1] <PowerIconKeywords:STR> elde et."
  },
  RelicConfig_13921_Desc = {
    Text = "Seçildiğinde, Silmek için 2 Komut Kartı seç ve [Arg1] <PowerIconKeywords:STR> elde et."
  },
  RelicConfig_13921_Name = {
    Text = "<RedQuality:Kara Yıldız Közü>"
  },
  RelicConfig_13921_StoryDesc = {
    Text = "Közler hâlâ parlıyor."
  },
  RelicConfig_13922_BattleDesc = {
    Text = "Her tur 2 Yüceliş serbest bıraktıktan sonra, tüm Uyananlar 8 Aliemus kazanır. 3 Yüceliş serbest bırakıldıktan sonra, tüm Uyananlar ek 8 Aliemus daha kazanır."
  },
  RelicConfig_13922_Desc = {
    Text = "Her tur 2 Yüceliş serbest bıraktıktan sonra, tüm Uyananlar 8 Aliemus kazanır. 3 Yüceliş serbest bırakıldıktan sonra, tüm Uyananlar ek 8 Aliemus daha kazanır."
  },
  RelicConfig_13922_Name = {
    Text = "<OrangeQuality:Unutulmuşların Kanı>"
  },
  RelicConfig_13922_StoryDesc = {
    Text = "Yavaş yavaş eriyip kayboluyor."
  },
  RelicConfig_13923_BattleDesc = {
    Text = "Verilen her bir Hasar örneği için [Arg1] Kalkan kazan. Tur başında, kalan her 3 Kalkan için 1 Geçici <PowerIconKeywords:STR> ve Dokunaç Hasarı kazan."
  },
  RelicConfig_13923_Desc = {
    Text = "Verilen her bir Hasar örneği için [Arg1] Kalkan kazan. Tur başında, kalan her 3 Kalkan için 1 Geçici <PowerIconKeywords:STR> ve Dokunaç Hasarı kazan."
  },
  RelicConfig_13923_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Gizem\">"
  },
  RelicConfig_13924_BattleDesc = {
    Text = "<TransitionIconKeywords:Leap> etkisi her tetiklendiğinde, tüm düşmanlardan [Arg1] Geçici <PowerIconKeywords:STR> çal. Yalnızca 1 düşman varsa, fazladan [Arg2] Geçici <PowerIconKeywords:STR> çal."
  },
  RelicConfig_13924_Desc = {
    Text = "<TransitionIconKeywords:Leap> etkisi her tetiklendiğinde, tüm düşmanlardan [Arg1] Geçici <PowerIconKeywords:STR> çal. Yalnızca 1 düşman varsa, fazladan [Arg2] Geçici <PowerIconKeywords:STR> çal."
  },
  RelicConfig_13924_Name = {
    Text = "<OrangeQuality:Uzay Sapma Cihazı>"
  },
  RelicConfig_13924_StoryDesc = {
    Text = "Boşluğa atıl."
  },
  RelicConfig_13925_BattleDesc = {
    Text = "Tur başında 1 kart çek. Aynı Arithmetica Maliyetine sahip 2 kartı art arda oynarsan, tur başına en fazla 3 kez olmak üzere 1 ek kart çek."
  },
  RelicConfig_13925_Desc = {
    Text = "Tur başında 1 kart çek. Aynı Arithmetica Maliyetine sahip 2 kartı art arda oynarsan, tur başına en fazla 3 kez olmak üzere 1 ek kart çek."
  },
  RelicConfig_13925_Name = {
    Text = "<OrangeQuality:Gnosis Aygıtı>"
  },
  RelicConfig_13925_StoryDesc = {
    Text = "Her Şeyi Bilen ve Her Şeye Kadir."
  },
  RelicConfig_13926_BattleDesc = {
    Text = "Savaşın başında, destesindeki her Yakarış için [Arg1] <PowerIconKeywords:STR> kazan. Her Kutsal Eşya için [Arg2] HP yenile."
  },
  RelicConfig_13926_Desc = {
    Text = "Savaşın başında, destesindeki her Yakarış için [Arg1] <PowerIconKeywords:STR> kazan. Her Kutsal Eşya için [Arg2] HP yenile."
  },
  RelicConfig_13926_Name = {
    Text = "<OrangeQuality:☆Lonca Madalyası☆>"
  },
  RelicConfig_13926_StoryDesc = {
    Text = "\"Bunu takarsan, Londinium Ticaret Odası’nın bir üyesisin demektir.\""
  },
  RelicConfig_13927_BattleDesc = {
    Text = "Alındığında 1 Semptom kartı kaldır. 1 rastgele Yakarışı Yükseltme ile bir İleri Dua’ya dönüştür."
  },
  RelicConfig_13927_Desc = {
    Text = "Alındığında 1 Semptom kartı kaldır. 1 rastgele Yakarışı Yükseltme ile bir İleri Dua’ya dönüştür."
  },
  RelicConfig_13927_Name = {
    Text = "<WhiteQuality:Şanslı Tavşan Pençesi>"
  },
  RelicConfig_13927_StoryDesc = {
    Text = "Tavşan için pek de şanslı sayılmaz."
  },
  RelicConfig_13928_BattleDesc = {
    Text = "Kritik Oranı %15 artar. Oynanan her kart Geçici Kritik Oranını %5 artırır."
  },
  RelicConfig_13928_Desc = {
    Text = "Kritik Oranı %15 artar. Oynanan her kart Geçici Kritik Oranını %5 artırır."
  },
  RelicConfig_13928_Name = {
    Text = "<OrangeQuality:Memphis Ritüel Aynası>"
  },
  RelicConfig_13928_StoryDesc = {
    Text = "\"İçinde ne gördün?\""
  },
  RelicConfig_13929_BattleDesc = {
    Text = "Her Can kaybettiğinizde, [Arg1] <plural value=\"[Arg1]\" singular=\"yığın\" plural=\"yığın\"> <RetaliateIconKeywords:Karşı Atak> kazan. Bu, tek bir turda 3. tetiklenme ise tüm düşmanlara karşı %100 <RetaliateIconKeywords:Karşı Atak> tetikle."
  },
  RelicConfig_13929_Desc = {
    Text = "Her Can kaybettiğinizde, [Arg1] <plural value=\"[Arg1]\" singular=\"yığın\" plural=\"yığın\"> <RetaliateIconKeywords:Karşı Atak> kazan. Bu, tek bir turda 3. tetiklenme ise tüm düşmanlara karşı %100 <RetaliateIconKeywords:Karşı Atak> tetikle."
  },
  RelicConfig_13929_Name = {
    Text = "<WhiteQuality:Merhumun Cep Saati>"
  },
  RelicConfig_13929_StoryDesc = {
    Text = "Anıları ve ağıtı sırtlayıp bilinmeyen yaratığa doğru ilerliyor."
  },
  RelicConfig_13930_BattleDesc = {
    Text = "Tur sonunda, eldeki her kart için tüm düşmanlara [Arg1] yığın <IntoxicationIconKeywords:Zehir> uygula."
  },
  RelicConfig_13930_Desc = {
    Text = "Tur sonunda, eldeki her kart için tüm düşmanlara [Arg1] yığın <IntoxicationIconKeywords:Zehir> uygula."
  },
  RelicConfig_13930_Name = {
    Text = "<WhiteQuality:Şüpheli Merhem>"
  },
  RelicConfig_13930_StoryDesc = {
    Text = "Dış yaralar için bir tür ev yapımı merhem. Doktorun rehberliği olmadan kullanmayın."
  },
  RelicConfig_13931_BattleDesc = {
    Text = "Alındığında [Arg1] <PowerIconKeywords:STR> elde et. Her <DerivativeCardKeywords_2:\"Embriyo\"> füzyonunda, [Arg2] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13931_Desc = {
    Text = "Alındığında [Arg1] <PowerIconKeywords:STR> elde et. Her <DerivativeCardKeywords_2:\"Embriyo\"> füzyonunda, [Arg2] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_13931_Name = {
    Text = "<WhiteQuality:Boyanmış Kanlı Çakıl Taşı>"
  },
  RelicConfig_13931_StoryDesc = {
    Text = "Bir, İki, Üç, Dört, Beş."
  },
  RelicConfig_13932_BattleDesc = {
    Text = "Her 3. kez \"Savunma\" oynandığında [Arg1] Karakter Kalkanı kazan. İlgili Uyandırma sahibi 15 Aliemus kazanır."
  },
  RelicConfig_13932_Desc = {
    Text = "Her 3. kez \"Savunma\" oynandığında [Arg1] Karakter Kalkanı kazan. İlgili Uyandırma sahibi 15 Aliemus kazanır."
  },
  RelicConfig_13932_Name = {
    Text = "<WhiteQuality:Sessiz Eldivenler>"
  },
  RelicConfig_13932_StoryDesc = {
    Text = "Sayısız kan, gözyaşı ve küfle lekelenmişler."
  },
  RelicConfig_13933_BattleDesc = {
    Text = "Bu, Etkisi olmayan haftalık bir Kalıntı 6"
  },
  RelicConfig_13933_Desc = {
    Text = "Bu, Etkisi olmayan haftalık bir Kalıntı 6"
  },
  RelicConfig_13933_Name = {
    Text = "Günlük Mücadele - Haftalık Kutsal Eşya 6"
  },
  RelicConfig_13934_BattleDesc = {
    Text = "Bu, Etkisi olmayan haftalık bir Kalıntı 5"
  },
  RelicConfig_13934_Desc = {
    Text = "Bu, Etkisi olmayan haftalık bir Kalıntı 5"
  },
  RelicConfig_13934_Name = {
    Text = "Günlük Mücadele Haftalık Yedek Kutsal Eşya 5"
  },
  RelicConfig_13935_BattleDesc = {
    Text = "Krit. Oranı +%10. Her tur ilk Kritik Vuruştan sonra, Krit. Oranını fazladan %20 artır. Her tur 3. Kritik Vuruştan sonra, Krit. Hasarı fazladan %50 artır."
  },
  RelicConfig_13935_Desc = {
    Text = "Krit. Oranı +%10. Her tur ilk Kritik Vuruştan sonra, Krit. Oranını fazladan %20 artır. Her tur 3. Kritik Vuruştan sonra, Krit. Hasarı fazladan %50 artır."
  },
  RelicConfig_13935_Name = {
    Text = "<WhiteQuality:Şenlik Duası>"
  },
  RelicConfig_13935_StoryDesc = {
    Text = "Aşık olanlara lütuf getirmesi gerekirdi."
  },
  RelicConfig_13936_BattleDesc = {
    Text = "Bu, Etkisi olmayan haftalık bir Kalıntı 3"
  },
  RelicConfig_13936_Desc = {
    Text = "Bu, Etkisi olmayan haftalık bir Kalıntı 3"
  },
  RelicConfig_13936_Name = {
    Text = "Günlük Mücadele - Haftalık Kutsal Eşya 3"
  },
  RelicConfig_13937_BattleDesc = {
    Text = "Bu, Etkisi olmayan haftalık bir Kalıntı 2"
  },
  RelicConfig_13937_Desc = {
    Text = "Bu, Etkisi olmayan haftalık bir Kalıntı 2"
  },
  RelicConfig_13937_Name = {
    Text = "Günlük Mücadeleler için Haftalık Yedek Kutsal Eşya 2"
  },
  RelicConfig_13938_BattleDesc = {
    Text = "Bu, Etkisi olmayan haftalık bir Kalıntı 1"
  },
  RelicConfig_13938_Desc = {
    Text = "Bu, Etkisi olmayan haftalık bir Kalıntı 1"
  },
  RelicConfig_13938_Name = {
    Text = "Günlük Mücadele için Haftalık Yedek Kutsal Eşya 1"
  },
  RelicConfig_13939_BattleDesc = {
    Text = "3. turun başında, bu savaştaki Kritik Oranı %15 artır ve eline 1 adet <DerivativeCardKeywords_39:Geçmişin Yankıları> ekle."
  },
  RelicConfig_13939_Desc = {
    Text = "3. turun başında, bu savaştaki Kritik Oranı %15 artır ve eline 1 adet <DerivativeCardKeywords_39:Geçmişin Yankıları> ekle."
  },
  RelicConfig_13939_Name = {
    Text = "<OrangeQuality:Geçmişin Yadigârı>"
  },
  RelicConfig_13939_StoryDesc = {
    Text = "Bir zamanlar sunulmuş bir sunu."
  },
  RelicConfig_13940_BattleDesc = {
    Text = "Karakter Kalkanına sahip olduğunda, bu Kalıntı [Arg1] Geçici <PowerIconKeywords:STR> sağlar. Karakter Kalkanın Mevcut HP'nden yüksek olduğunda, ek olarak [Arg2] Geçici <PowerIconKeywords:STR> sağlar."
  },
  RelicConfig_13940_Desc = {
    Text = "Karakter Kalkanına sahip olduğunda, bu Kalıntı [Arg1] Geçici <PowerIconKeywords:STR> sağlar. Karakter Kalkanın Mevcut HP'nden yüksek olduğunda, ek olarak [Arg2] Geçici <PowerIconKeywords:STR> sağlar."
  },
  RelicConfig_13940_Name = {
    Text = "<WhiteQuality:Güvercin Tüyü Yelpazesi>"
  },
  RelicConfig_13940_StoryDesc = {
    Text = "Narin, pahalı, ama pek de kullanışlı değil."
  },
  RelicConfig_13941_BattleDesc = {
    Text = "\"Darbe\" [Arg1] CP yeniler ve kendi <IntoxicationIconKeywords:Zehir>ini [Arg1] yığın azaltır."
  },
  RelicConfig_13941_Desc = {
    Text = "\"Darbe\" [Arg1] CP yeniler ve kendi <IntoxicationIconKeywords:Zehir>ini [Arg1] yığın azaltır."
  },
  RelicConfig_13941_Name = {
    Text = "<WhiteQuality:Hemostatik Klemp>"
  },
  RelicConfig_13941_StoryDesc = {
    Text = "\"Çabuk, çabuk! Ver onu bana!\""
  },
  RelicConfig_13942_BattleDesc = {
    Text = "Her bir Dokunaç, tur sonunda [Arg1] Karakter Kalkanı verir. Sakin Deniz Duruşundayken, bu etki %50 ek Karakter Kalkanı sağlar."
  },
  RelicConfig_13942_Desc = {
    Text = "Her bir Dokunaç, tur sonunda [Arg1] Karakter Kalkanı verir. Sakin Deniz Duruşundayken, bu etki %50 ek Karakter Kalkanı sağlar."
  },
  RelicConfig_13942_Name = {
    Text = "<WhiteQuality:İsimsiz Uzuv>"
  },
  RelicConfig_13942_StoryDesc = {
    Text = "Dikkat et, dikenine batma."
  },
  RelicConfig_139929_BattleDesc = {
    Text = "Tur başlangıcında, Saya [Arg1] Aliemus kazanır. Saya'nın Taşkınlık'ı tarafından tüketilen her 100 Aliemus için, rastgele oluşturulan bir \"Beceri\" 1 ek kez etki eder."
  },
  RelicConfig_139929_Desc = {
    Text = "Tur başlangıcında, Saya [Arg1] Aliemus kazanır. Saya'nın Taşkınlık'ı tarafından tüketilen her 100 Aliemus için, rastgele oluşturulan bir \"Beceri\" 1 ek kez etki eder."
  },
  RelicConfig_139929_Name = {
    Text = "<OrangeQuality:Boyutsal İmge · Saya>"
  },
  RelicConfig_140276_BattleDesc = {
    Text = "<OrangeQuality:Son Çare>: Tur başladığında kaybedilen her 1% maksimum can başına geçici nihai hasar 5% artar, önceki turda ölüm direnci tetiklendiyse bu etki iki katına çıkar.\n<RedQuality:Yücelik>: Tüm düşmanların maksimum canı 300% artar."
  },
  RelicConfig_140276_Desc = {
    Text = "<OrangeQuality:Son Çare>: Tur başladığında kaybedilen her 1% maksimum can başına geçici nihai hasar 5% artar, önceki turda ölüm direnci tetiklendiyse bu etki iki katına çıkar.\n<RedQuality:Yücelik>: Tüm düşmanların maksimum canı 300% artar."
  },
  RelicConfig_140276_Name = {
    Text = "<RedQuality:Boyut Sarkacı-Düello>"
  },
  RelicConfig_140277_BattleDesc = {
    Text = "<OrangeQuality:Çoğalma>: Her turda her Uyanmış'ın ilk kez oynadığı \"Beceri\" kartından 2 geçici orijinal kopya oluşturur. İşlem gücü maliyeti 0 veya 1 olan komut kartı oynandığında tüm Uyanmışlar 5 Çılgınlık kazanır.\n<RedQuality:Kale>: Orijinal işlem gücü maliyeti 3 veya daha fazla olan kart oynandığında, tüm düşmanlar maksimum canın 20%'si kadar kalkan kazanır."
  },
  RelicConfig_140277_Desc = {
    Text = "<OrangeQuality:Çoğalma>: Her turda her Uyanmış'ın ilk kez oynadığı \"Beceri\" kartından 2 geçici orijinal kopya oluşturur. İşlem gücü maliyeti 0 veya 1 olan komut kartı oynandığında tüm Uyanmışlar 5 Çılgınlık kazanır.\n<RedQuality:Kale>: Orijinal işlem gücü maliyeti 3 veya daha fazla olan kart oynandığında, tüm düşmanlar maksimum canın 20%'si kadar kalkan kazanır."
  },
  RelicConfig_140277_Name = {
    Text = "<RedQuality:Boyut Sarkacı-Alarm>"
  },
  RelicConfig_140278_BattleDesc = {
    Text = "<OrangeQuality:Yeniden Doğuş>: Kazanılan kalkan ve iyileştirme etkisi 25% artar. Can yenilendiğinde veya kalkan kazanıldığında, maksimum canın her 1%'i kadar yenileme veya kalkan etkisi başına 10% geçici hasar güçlendirmesi kazanılır.\n<RedQuality:Fısıltı>: Her turda maksimum canın 10%'i kadar güç azaltma etkisi kazanılır."
  },
  RelicConfig_140278_Desc = {
    Text = "<OrangeQuality:Yeniden Doğuş>: Kazanılan kalkan ve iyileştirme etkisi 25% artar. Can yenilendiğinde veya kalkan kazanıldığında, maksimum canın her 1%'i kadar yenileme veya kalkan etkisi başına 10% geçici hasar güçlendirmesi kazanılır.\n<RedQuality:Fısıltı>: Her turda maksimum canın 10%'i kadar güç azaltma etkisi kazanılır."
  },
  RelicConfig_140278_Name = {
    Text = "<RedQuality:Boyut Sarkacı-Korkutma>"
  },
  RelicConfig_140279_BattleDesc = {
    Text = "<OrangeQuality:Şafak>: Tüm Uyanmışların temel Çılgınlığı 30 puan azalır. Her turda serbest bırakılan ilk Çılgınlık Patlamasının nihai hasarı 200% artar, kalkan ve can yenilemesi 100% artar. Her 5 Çılgınlık Patlaması serbest bırakıldıktan sonra, 1 Uyanmış seçilerek uyanış gerçekleştirilir ve Çılgınlık Patlaması güçlendirme etkisi yenilenir.\n<RedQuality:Tükenme>: Temel Gümüş Anahtar enerjisi 200% artar."
  },
  RelicConfig_140279_Desc = {
    Text = "<OrangeQuality:Şafak>: Tüm Uyanmışların temel Çılgınlığı 30 puan azalır. Her turda serbest bırakılan ilk Çılgınlık Patlamasının nihai hasarı 200% artar, kalkan ve can yenilemesi 100% artar. Her 5 Çılgınlık Patlaması serbest bırakıldıktan sonra, 1 Uyanmış seçilerek uyanış gerçekleştirilir ve Çılgınlık Patlaması güçlendirme etkisi yenilenir.\n<RedQuality:Tükenme>: Temel Gümüş Anahtar enerjisi 200% artar."
  },
  RelicConfig_140279_Name = {
    Text = "<RedQuality:Boyut Sarkacı-Voodoo>"
  },
  RelicConfig_140280_BattleDesc = {
    Text = "<OrangeQuality:Uyanış>: Her turda ilk Çılgınlık Patlaması serbest bırakıldıktan sonra, o Uyanmış'ın Çılgınlık Patlaması bekleme süresi sıfırlanır ve 50 Çılgınlık kazanır, işlem gücü maliyeti 0 olan tüm \"Beceri\" kartlarının geçici kopyaları oluşturulur.\n<RedQuality:Mühür>: Her turda ilk Çılgınlık Patlaması serbest bırakıldıktan sonra, diğer Uyanmışlar mühürlenir."
  },
  RelicConfig_140280_Desc = {
    Text = "<OrangeQuality:Uyanış>: Her turda ilk Çılgınlık Patlaması serbest bırakıldıktan sonra, o Uyanmış'ın Çılgınlık Patlaması bekleme süresi sıfırlanır ve 50 Çılgınlık kazanır, işlem gücü maliyeti 0 olan tüm \"Beceri\" kartlarının geçici kopyaları oluşturulur.\n<RedQuality:Mühür>: Her turda ilk Çılgınlık Patlaması serbest bırakıldıktan sonra, diğer Uyanmışlar mühürlenir."
  },
  RelicConfig_140280_Name = {
    Text = "<RedQuality:Boyut Sarkacı-Düello>"
  },
  RelicConfig_140281_BattleDesc = {
    Text = "<OrangeQuality:Yankı>: Tur başladıktan sonra çekme destesinden en yüksek işlem gücüne sahip 3 komut kartı çekilir, her turda oynanan ilk komut kartı 2 kez etki eder.\n<RedQuality:Sersemletme>: Komut kartı oynadıktan sonra, işlem gücü maliyeti ondan düşük olmayan diğer tüm komut kartları atılır."
  },
  RelicConfig_140281_Desc = {
    Text = "<OrangeQuality:Yankı>: Tur başladıktan sonra çekme destesinden en yüksek işlem gücüne sahip 3 komut kartı çekilir, her turda oynanan ilk komut kartı 2 kez etki eder.\n<RedQuality:Sersemletme>: Komut kartı oynadıktan sonra, işlem gücü maliyeti ondan düşük olmayan diğer tüm komut kartları atılır."
  },
  RelicConfig_140281_Name = {
    Text = "<RedQuality:Boyut Sarkacı-Şaşırtma>"
  },
  RelicConfig_140282_BattleDesc = {
    Text = "<OrangeQuality:Kudret>: Tüm Uyanmışların verdiği <PowerIconKeywords:Güç> 50% artar, her 1 hasar verildiğinde [Arg2] geçici <PowerIconKeywords:Güç> kazanılır.\n<RedQuality:Görünmezlik>: Savaş başladığında, tüm düşmanlar 50 katman <ParcloseIconKeywords:Bariyer> kazanır."
  },
  RelicConfig_140282_Desc = {
    Text = "<OrangeQuality:Kudret>: Tüm Uyanmışların verdiği <PowerIconKeywords:Güç> 50% artar, her 1 hasar verildiğinde [Arg2] geçici <PowerIconKeywords:Güç> kazanılır.\n<RedQuality:Görünmezlik>: Savaş başladığında, tüm düşmanlar 50 katman <ParcloseIconKeywords:Bariyer> kazanır."
  },
  RelicConfig_140282_Name = {
    Text = "<RedQuality:Boyut Sarkacı-Pusu>"
  },
  RelicConfig_140840_BattleDesc = {
    Text = "Maksimum El Boyutu +1. Savaş başında ele 1 adet \"<DerivativeCardKeywords_148:驭魇>\" oluşturulur. Uyandırıcının \"Temel Saldırı\"sı oynanırken, \"<DerivativeCardKeywords_148:驭魇>\" Arithmetica Maliyeti -1 olur ve tüm düşmanlara [Arg1] Aşınma verir. Uyandırıcının \"Temel DEF\"i oynanırken, [Arg2] Güç kazanılır ve bir sonraki \"<DerivativeCardKeywords_148:驭魇>\" oynanışında Final Hasar Etkisi ve Güç [Arg3]% artar."
  },
  RelicConfig_140840_Desc = {
    Text = "Maksimum El Boyutu +1. Savaş başında ele 1 adet \"<DerivativeCardKeywords_148:驭魇>\" oluşturulur. Uyandırıcının \"Temel Saldırı\"sı oynanırken, \"<DerivativeCardKeywords_148:驭魇>\" Arithmetica Maliyeti -1 olur ve tüm düşmanlara [Arg1] Aşınma verir. Uyandırıcının \"Temel DEF\"i oynanırken, [Arg2] Güç kazanılır ve bir sonraki \"<DerivativeCardKeywords_148:驭魇>\" oynanışında Final Hasar Etkisi ve Güç [Arg3]% artar."
  },
  RelicConfig_140840_Name = {
    Text = "Beyhude Çaba"
  },
  RelicConfig_140840_StoryDesc = {
    Text = "Beyhude çaba içindeki kişi değişimden korkar, şeylerin kontrolden çıkmasından korkar; en derinde, Histeri içinde kaybetmekten korkar.\n Islığını defalarca çalar, Islık sesiyle her şeyi kontrol altına almak ister; ama hiçbir şeyi tutamaz."
  },
  RelicConfig_143665_BattleDesc = {
    Text = "Pontos, tur başında [Arg1] Aliemus kazanır. Toplandığında, bir sonraki savaşın başında 3 Kalıcı \"Gaunt\" kartı oluşturur. Pontos, bir \"Gaunt\" oynadıktan sonra 3 Aliemus kazanır."
  },
  RelicConfig_143665_Desc = {
    Text = "Pontos, tur başında [Arg1] Aliemus kazanır. Toplandığında, bir sonraki savaşın başında 3 Kalıcı \"Gaunt\" kartı oluşturur. Pontos, bir \"Gaunt\" oynadıktan sonra 3 Aliemus kazanır."
  },
  RelicConfig_143665_Name = {
    Text = "<OrangeQuality:Boyutsal İmge: Pontos>"
  },
  RelicConfig_145438_BattleDesc = {
    Text = "Tur başında [Arg1] Aliemus kazan. \"Sınır Kesen Kılıç\" kullanıldıktan sonra, bir sonraki turun başında Av: \"Cehennem Kılıcı\" gerçekleştir: Tüm düşmanlara Lotan: Cetarchon'un ATK'sının %400'ü kadar Hasar ver. Bu Av, \"Sınır Kesen Kılıç\"ın \"Büyük Bıçak: Balina Düşüşü\" aracılığıyla elde ettiği Hasar Bonusu'ndan yararlanır ve \"Vuruş\" olarak sayılır."
  },
  RelicConfig_145438_Desc = {
    Text = "Tur başında [Arg1] Aliemus kazan. \"Sınır Kesen Kılıç\" kullanıldıktan sonra, bir sonraki turun başında Av: \"Cehennem Kılıcı\" gerçekleştir: Tüm düşmanlara Lotan: Cetarchon'un ATK'sının %400'ü kadar Hasar ver. Bu Av, \"Sınır Kesen Kılıç\"ın \"Büyük Bıçak: Balina Düşüşü\" aracılığıyla elde ettiği Hasar Bonusu'ndan yararlanır ve \"Vuruş\" olarak sayılır."
  },
  RelicConfig_145438_Name = {
    Text = "<OrangeQuality:Boyutsal İmge: Lotan: Cetarchon>"
  },
  RelicConfig_146128_BattleDesc = {
    Text = "Maksimum El Boyutu +1. Savaş başladığında veya \"<DerivativeCardKeywords_157:Kılıç Kemiği>\" oynadıktan sonra eline 1 adet \"<DerivativeCardKeywords_155:Çılgınlık Kemiği>\" koy, Çekme Destesine 1 adet \"<DerivativeCardKeywords_156:Yara Kemiği>\" Karıştır. Eğer bir tur içinde hem \"<DerivativeCardKeywords_155:Çılgınlık Kemiği>\" hem de \"<DerivativeCardKeywords_156:Yara Kemiği>\" oynanırsa, bu iki kartı birleştirerek \"<DerivativeCardKeywords_157:Kılıç Kemiği>\" oluştur ve eline koy."
  },
  RelicConfig_146128_Desc = {
    Text = "Maksimum El Boyutu +1. Savaş başladığında veya \"<DerivativeCardKeywords_157:Kılıç Kemiği>\" oynadıktan sonra eline 1 adet \"<DerivativeCardKeywords_155:Çılgınlık Kemiği>\" koy, Çekme Destesine 1 adet \"<DerivativeCardKeywords_156:Yara Kemiği>\" Karıştır. Eğer bir tur içinde hem \"<DerivativeCardKeywords_155:Çılgınlık Kemiği>\" hem de \"<DerivativeCardKeywords_156:Yara Kemiği>\" oynanırsa, bu iki kartı birleştirerek \"<DerivativeCardKeywords_157:Kılıç Kemiği>\" oluştur ve eline koy."
  },
  RelicConfig_146128_Name = {
    Text = "Balina Kemiği Zırhı"
  },
  RelicConfig_146128_StoryDesc = {
    Text = "Leviathan'ın kemikleri, seçilmişlerini koruyarak onları yenilmez ve ölümsüz kılar."
  },
  RelicConfig_147547_BattleDesc = {
    Text = "Tur başında Casiah [Arg1] Aliemus kazanır. 1 kart çekmek Casiah'a [Arg2] Aliemus kazandırır. Casiah Yüceltim açığa çıkardığında, tüm düşmanlar [Arg3] GÜÇ kaybeder."
  },
  RelicConfig_147547_Desc = {
    Text = "Tur başında Casiah [Arg1] Aliemus kazanır. 1 kart çekmek Casiah'a [Arg2] Aliemus kazandırır. Casiah Yüceltim açığa çıkardığında, tüm düşmanlar [Arg3] GÜÇ kaybeder."
  },
  RelicConfig_147547_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Casiah>"
  },
  RelicConfig_147665_BattleDesc = {
    Text = "Arithmetica Sınırı ve her tur Çekme sayısı +1. Tur başında 3 adet \"<Caroboo_Tips:Pistoles de Marie>\" <FaxianKeywords:Keşfet> ve birini seç. Bunların yalnızca 1 tanesi gerçektir: Gerçeği seçersen olumlu Etkisini kazanır ve kendi üzerindeki rastgele 1 olumsuz Durumu dağıtırsın; yalanı seçersen olumsuz Etkisine maruz kalırsın ve bir sonraki <FaxianKeywords:Keşfet> sırasında gerçek seçenek +1, Etki iki katına çıkar; gerçeği seçtikten sonra sıfırlanır."
  },
  RelicConfig_147665_Desc = {
    Text = "Arithmetica Sınırı ve her tur Çekme sayısı +1. Tur başında 3 adet \"<Caroboo_Tips:Pistoles de Marie>\" <FaxianKeywords:Keşfet> ve birini seç. Bunların yalnızca 1 tanesi gerçektir: Gerçeği seçersen olumlu Etkisini kazanır ve kendi üzerindeki rastgele 1 olumsuz Durumu dağıtırsın; yalanı seçersen olumsuz Etkisine maruz kalırsın ve bir sonraki <FaxianKeywords:Keşfet> sırasında gerçek seçenek +1, Etki iki katına çıkar; gerçeği seçtikten sonra sıfırlanır."
  },
  RelicConfig_147665_Name = {
    Text = "Pistoles de Marie"
  },
  RelicConfig_147665_StoryDesc = {
    Text = "Tatlı ve değerli... ya da öyle mi?"
  },
  RelicConfig_148525_BattleDesc = {
    Text = "Tur başında, Yemin Bağlısı · Ogier [Arg1] Aliemus kazanır ve \"Karanlık Dalgalanma\" artık çekme sayısını azaltmaz."
  },
  RelicConfig_148525_Desc = {
    Text = "Tur başında, Yemin Bağlısı · Ogier [Arg1] Aliemus kazanır ve \"Karanlık Dalgalanma\" artık çekme sayısını azaltmaz."
  },
  RelicConfig_148525_Name = {
    Text = "<OrangeQuality:Boyutsal İmge·Lanetli·Ogier>"
  },
  RelicConfig_149665_BattleDesc = {
    Text = "Mevcut arazi \"Buz Sahası\" olarak sayılır.\nHiperborea'da: Çekme Aşamasından sonra, eldeki en yüksek Arithmetica Maliyetine sahip 2 donmamış Komut Kartına 1 yığın <SlowIconKeywords:Durağanlık> ve <RetainIconKeywords:Sakla> uygula. Herhangi bir Komut Kartı en az 3 yığın <SlowIconKeywords:Durağanlık>'a sahip olduğunda, <SlowIconKeywords:Durağanlık>'ını ve <RetainIconKeywords:Sakla>'sını (bu savaşta elde edilen) kaldır, onu Dondur ve 25 yığın <TempPowerKeywords2:Güçlendirme> uygula."
  },
  RelicConfig_149665_Desc = {
    Text = "Mevcut arazi \"Buz Sahası\" olarak sayılır.\nHiperborea'da: Çekme Aşamasından sonra, eldeki en yüksek Arithmetica Maliyetine sahip 2 donmamış Komut Kartına 1 yığın <SlowIconKeywords:Durağanlık> ve <RetainIconKeywords:Sakla> uygula. Herhangi bir Komut Kartı en az 3 yığın <SlowIconKeywords:Durağanlık>'a sahip olduğunda, <SlowIconKeywords:Durağanlık>'ını ve <RetainIconKeywords:Sakla>'sını (bu savaşta elde edilen) kaldır, onu Dondur ve 25 yığın <TempPowerKeywords2:Güçlendirme> uygula."
  },
  RelicConfig_149665_Name = {
    Text = "<OrangeQuality:Kristal Küre>"
  },
  RelicConfig_149665_StoryDesc = {
    Text = "Soğuğu getirmez.\nSadece toprağa kışın hiç gitmediğini hatırlatır."
  },
  RelicConfig_20164_BattleDesc = {
    Text = "Verilen her bir Hasar örneği için, en fazla 5 yığına kadar [Arg1] Geçici <PowerIconKeywords:STR> kazan.\nYığın sınırına ulaşıldığında, [Arg1] <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_20164_Desc = {
    Text = "Verilen her bir Hasar örneği için, en fazla 5 yığına kadar [Arg1] Geçici <PowerIconKeywords:STR> kazan.\nYığın sınırına ulaşıldığında, [Arg1] <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_20164_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Uykusuz\">"
  },
  RelicConfig_20165_BattleDesc = {
    Text = "Tüm Uyandırıcıları Uyandır.\n<ExaltIconKeywords:Rouse> oynadıktan sonra, o Uyandırıcıya ait, üzerinde \"Tüketme\" ve \"Fani\" olan 2 Rastgele Komut Kartı kazan."
  },
  RelicConfig_20165_Desc = {
    Text = "Tüm Uyandırıcıları Uyandır.\n<ExaltIconKeywords:Rouse> oynadıktan sonra, o Uyandırıcıya ait, üzerinde \"Tüketme\" ve \"Fani\" olan 2 Rastgele Komut Kartı kazan."
  },
  RelicConfig_20165_Name = {
    Text = "<OrangeQuality:İlahi Kehanet+>"
  },
  RelicConfig_20165_StoryDesc = {
    Text = "“Korkma,” dedi."
  },
  RelicConfig_20166_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Diyar Ustalığı> 100 artar. Her tur oynanan ilk kartı eline Dönüş ettir. Ultra Tur başında El Sınırını 5 artır ve elini Kopyala."
  },
  RelicConfig_20166_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Diyar Ustalığı> 100 artar. Her turda oynanan ilk kartı Atılmış Kart Desteği'nden tekrar ele al. Bir Ultra Tur'un başında, o tur için El Sınırı 5 artar ve elin kopyalanır; kopyalar <NothingnessIconKeywords:Gelip Geçici> ve <DepleteIconKeywords:Tüketme> kazanır."
  },
  RelicConfig_20166_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Düş Hırsızlığı\">"
  },
  RelicConfig_20167_BattleDesc = {
    Text = "Tur sonunda, eğer kalan Arithmetica varsa, bir sonraki tur 2 fazladan kart çek; eğer elde kalan kartlar varsa, bir sonraki tur 2 fazladan Arithmetica kazan."
  },
  RelicConfig_20167_Desc = {
    Text = "Tur sonunda, eğer kalan Arithmetica varsa, bir sonraki tur 2 fazladan kart çek; eğer elde kalan kartlar varsa, bir sonraki tur 2 fazladan Arithmetica kazan."
  },
  RelicConfig_20167_Name = {
    Text = "<OrangeQuality:Güneş Diski+>"
  },
  RelicConfig_20167_StoryDesc = {
    Text = "Tahmin et, siyah mı yoksa beyaz mı?"
  },
  RelicConfig_20168_BattleDesc = {
    Text = "Dokunaç Sınırı +2. Yücelt serbest bırakıldıktan sonra Dokunaç Hasarı +[Arg1]. Bir turda Yücelt 3 kez serbest bırakılırsa, tüm Dokunaçları bir kez etkinleştir."
  },
  RelicConfig_20168_Desc = {
    Text = "Dokunaç Sınırı +2. Yücelt serbest bırakıldıktan sonra Dokunaç Hasarı +[Arg1]. Bir turda Yücelt 3 kez serbest bırakılırsa, tüm Dokunaçları bir kez etkinleştir."
  },
  RelicConfig_20168_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Hafif Uyku\">"
  },
  RelicConfig_20169_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Diyar Ustalığı> +100. Oynanan her kart için <EmbryoFusionIconKeywords:Embriyo Füzyonu> +10; Can %25'in altındayken artış 20 olur. Bu etki tur başına en fazla 10 kez tetiklenebilir."
  },
  RelicConfig_20169_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Diyar Ustalığı> +100. Oynanan her kart için <EmbryoFusionIconKeywords:Embriyo Füzyonu> +10; Can %25'in altındayken artış 20 olur. Bu etki tur başına en fazla 10 kez tetiklenebilir."
  },
  RelicConfig_20169_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Kabaran\">"
  },
  RelicConfig_20170_BattleDesc = {
    Text = "Savaş başında, tüm Uyanışçılar 50 Aliemus kazanır. Ele 2 kopya <DerivativeCardKeywords_1:\"Kayıp Gölgelerin Yankısı\"> koy."
  },
  RelicConfig_20170_Desc = {
    Text = "Savaş başında, tüm Uyanışçılar 50 Aliemus kazanır. Ele 2 kopya <DerivativeCardKeywords_1:\"Kayıp Gölgelerin Yankısı\"> koy."
  },
  RelicConfig_20170_Name = {
    Text = "<OrangeQuality:Sinyal Aktarıcı+>"
  },
  RelicConfig_20170_StoryDesc = {
    Text = "Çalacağı anı özle ya da ondan dehşet duy."
  },
  RelicConfig_20171_BattleDesc = {
    Text = "Alındığında, rastgele 1 Gümüş Kalıntı, 1 Altın Kalıntı ve 1 Lanetli Kalıntı kazan."
  },
  RelicConfig_20171_Desc = {
    Text = "Alındığında, rastgele 1 Gümüş Kalıntı, 1 Altın Kalıntı ve 1 Lanetli Kalıntı kazan."
  },
  RelicConfig_20171_Name = {
    Text = "<OrangeQuality:Ters Bakış+>"
  },
  RelicConfig_20171_StoryDesc = {
    Text = "Bu tuhaf çağda, çiçekler İnsanlığın Işığı’nın başlıca seyircileridir.\nKıpırdama; sessiz sergileri tercih ederler."
  },
  RelicConfig_20172_BattleDesc = {
    Text = "Bir turda oynanan Komut Kartı sayısı 3’e ulaştığında 1 <DerivativeCardKeywords_4:\"Kavrayış\"> kazan; 6 karta ulaştığında bir <DerivativeCardKeywords_4:\"Kavrayış\"> daha kazan; 10 karta ulaşıldığında ise bir sonraki turun başında destesinden eline eklemek üzere 2 kart seçebilirsin."
  },
  RelicConfig_20172_Desc = {
    Text = "Bir turda oynanan Komut Kartı sayısı 3’e ulaştığında 1 <DerivativeCardKeywords_4:\"Kavrayış\"> kazan; 6 karta ulaştığında bir <DerivativeCardKeywords_4:\"Kavrayış\"> daha kazan; 10 karta ulaşıldığında ise bir sonraki turun başında destesinden eline eklemek üzere 2 kart seçebilirsin."
  },
  RelicConfig_20172_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Yankı\">"
  },
  RelicConfig_20173_BattleDesc = {
    Text = "Zayıflatma etkisi altındaki düşmanlara %50 daha fazla Hasar ver ve onları öldürdüğünde 100 Aliemus kazan."
  },
  RelicConfig_20173_Desc = {
    Text = "Zayıflatma etkisi altındaki düşmanlara %50 daha fazla Hasar ver ve onları öldürdüğünde 100 Aliemus kazan."
  },
  RelicConfig_20173_Name = {
    Text = "<OrangeQuality:Hierofant Asası+>"
  },
  RelicConfig_20173_StoryDesc = {
    Text = "Yaptırımsız Takva"
  },
  RelicConfig_20174_BattleDesc = {
    Text = "Alındığında, Takım Hasar Güçlendirmesi x150%. Tur başında, rastgele bir düşmana [Arg1] <FixedDamage:Saf Hasar> ver. Bu savaşta kullanılan her Müfreze için verilen hasar [Arg2] artar. Bu hasar bonusu, Takım Hasar Güçlendirmesi bonusundan yararlanır."
  },
  RelicConfig_20174_Desc = {
    Text = "Alındığında, Takım Hasar Güçlendirmesi x150%. Tur başında, rastgele bir düşmana [Arg1] <FixedDamage:Saf Hasar> ver. Bu savaşta kullanılan her Müfreze için verilen hasar [Arg2] artar. Bu hasar bonusu, Takım Hasar Güçlendirmesi bonusundan yararlanır."
  },
  RelicConfig_20174_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Kopuş\">"
  },
  RelicConfig_20175_BattleDesc = {
    Text = "<WeaknessIconKeywords:Zayıflık> etkisi %8, <VulnerabilityIconKeywords:Savunmasız> etkisi %25 artar.\n<WeaknessIconKeywords:Zayıflık> veya <VulnerabilityIconKeywords:Savunmasız> uyguladığında, hedeften geçici olarak [Arg1] <PowerIconKeywords:STR> çal."
  },
  RelicConfig_20175_Desc = {
    Text = "<WeaknessIconKeywords:Zayıflık> etkisi %8, <VulnerabilityIconKeywords:Savunmasız> etkisi %25 artar.\n<WeaknessIconKeywords:Zayıflık> veya <VulnerabilityIconKeywords:Savunmasız> uyguladığında, hedeften geçici olarak [Arg1] <PowerIconKeywords:STR> çal."
  },
  RelicConfig_20175_Name = {
    Text = "<OrangeQuality:Solmuş Fotoğraf+>"
  },
  RelicConfig_20175_StoryDesc = {
    Text = "Bulanık fotoğraf, bulanık bir Hafıza taşır; ya da belki de fotoğrafın solmasına yol açan, Hafıza’nın eksikliğidir."
  },
  RelicConfig_20176_BattleDesc = {
    Text = "Tur başında, her düşman için 2 Arithmetica elde et. Bir düşman Aktif Hasarla öldürüldüğünde, fazla Hasarın iki katını diğer düşmanlara <BleedingIconKeywords:Bleed> olarak ver."
  },
  RelicConfig_20176_Desc = {
    Text = "Tur başında, her düşman için 2 Arithmetica elde et. Bir düşman Aktif Hasarla öldürüldüğünde, fazla Hasarın iki katını diğer düşmanlara <BleedingIconKeywords:Bleed> olarak ver."
  },
  RelicConfig_20176_Name = {
    Text = "<OrangeQuality:Ayaktakımı Şarkısı+>"
  },
  RelicConfig_20176_StoryDesc = {
    Text = "Özellikle kulaklarını işkenceye boğmak için tasarlandı."
  },
  RelicConfig_20177_BattleDesc = {
    Text = "Bu eşyayı almak Ölüm Direncini ikiye katlar. Hasar verdikten sonra, hedefe Hasarın %50’sine eşit <BleedingIconKeywords:Kan Akıtma> uygular. Ölüm Direnci her tetiklendiğinde, tüm düşmanlar anında 1 kez Kan Akıtma tetikler."
  },
  RelicConfig_20177_Desc = {
    Text = "Bu eşyayı almak Ölüm Direncini ikiye katlar. Hasar verdikten sonra, hedefe Hasarın %50’sine eşit <BleedingIconKeywords:Kan Akıtma> uygular. Ölüm Direnci her tetiklendiğinde, tüm düşmanlar anında 1 kez Kan Akıtma tetikler."
  },
  RelicConfig_20177_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Canlanma\">"
  },
  RelicConfig_20178_BattleDesc = {
    Text = "Her 1 adet Aktif Hasar verdiğinde, 3 Aliemus kazan ve Hedefe [Arg1] yığın <IntoxicationIconKeywords:Zehir> uygula.\nBu savaşta tetiklenme sayısı 25’e ulaşırsa, derhal tüm Düşman hedeflere <IntoxicationIconKeywords:Zehir> uygula."
  },
  RelicConfig_20178_Desc = {
    Text = "Her 1 adet Aktif Hasar verdiğinde, 3 Aliemus kazan ve Hedefe [Arg1] yığın <IntoxicationIconKeywords:Zehir> uygula.\nBu savaşta tetiklenme sayısı 25’e ulaşırsa, derhal tüm Düşman hedeflere <IntoxicationIconKeywords:Zehir> uygula."
  },
  RelicConfig_20178_Name = {
    Text = "<OrangeQuality:Tozlanmış Dokuma Tezgâhı+>"
  },
  RelicConfig_20178_StoryDesc = {
    Text = "Şefkatli bir anne, kalbin yaralarını diker."
  },
  RelicConfig_21906_BattleDesc = {
    Text = "\"Darbe\" 3 Arithmetica kazanır ve 1 Rastgele kart atar; \"Savunma\" 3 kart çeker ve 1 Arithmetica kaybeder."
  },
  RelicConfig_21906_Desc = {
    Text = "\"Darbe\" 3 Arithmetica kazanır ve 1 Rastgele kart atar; \"Savunma\" 3 kart çeker ve 1 Arithmetica kaybeder."
  },
  RelicConfig_21906_Name = {
    Text = "<RedQuality:Neşeli Plak+>"
  },
  RelicConfig_21906_StoryDesc = {
    Text = "Ünlü kemancının son performansının kaydı.\nO zamandan beri, alevleri çağırabilmektedir."
  },
  RelicConfig_23688_BattleDesc = {
    Text = "Her Yutma tetiklendiğinde 30 <EmbryoFusionIconKeywords:Embriyo Füzyonu> ve [Arg1] <PowerIconKeywords:STR> kazan. Aynı turda ikinci kez tetiklenirse, 1 Arithmetica kazan ve 1 kart çek. Aynı turda üçüncü kez tetiklenirse, 2 Arithmetica kazan ve 2 kart çek."
  },
  RelicConfig_23688_Desc = {
    Text = "Her Yutma tetiklendiğinde 30 <EmbryoFusionIconKeywords:Embriyo Füzyonu> ve [Arg1] <PowerIconKeywords:STR> kazan. Aynı turda ikinci kez tetiklenirse, 1 Arithmetica kazan ve 1 kart çek. Aynı turda üçüncü kez tetiklenirse, 2 Arithmetica kazan ve 2 kart çek."
  },
  RelicConfig_23688_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Geri Tepme\">"
  },
  RelicConfig_23689_BattleDesc = {
    Text = "Alındığında tüm Uyananlara 30 Aliemus verir. Her Yüceltim salınımı Sayacı 1 artırır. Çeteyi saldıktan sonra, [Arg1] Geçici Alarm, [Arg2] Geçici <PowerIconKeywords:STR> kazanır ve tüm Uyananlar 6 Aliemus elde eder; bu işlem tüm Sayaç değerini tüketir ve her Sayaç puanı 1 ek kez etkili olur."
  },
  RelicConfig_23689_Desc = {
    Text = "Alındığında tüm Uyananlara 30 Aliemus verir. Her Yüceltim salınımı Sayacı 1 artırır. Çeteyi saldıktan sonra, [Arg1] Geçici Alarm, [Arg2] Geçici <PowerIconKeywords:STR> kazanır ve tüm Uyananlar 6 Aliemus elde eder; bu işlem tüm Sayaç değerini tüketir ve her Sayaç puanı 1 ek kez etkili olur."
  },
  RelicConfig_23689_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Yığılma\">"
  },
  RelicConfig_23690_BattleDesc = {
    Text = "Her ek Arithmetica veya çekilen her ekstra kart için, tüm düşmanlardan [Arg1] <PowerIconKeywords:STR> çal, %4 Geçici Kritik Oranı kazan ve bu etki Elit veya Reis Savaşlarında ikiye katlanır. Bir Ultra Tur başladıktan sonra, [Arg2] <PowerIconKeywords:STR> kazan ve Krit. Hasarı %15 artır."
  },
  RelicConfig_23690_Desc = {
    Text = "Her ek Arithmetica veya çekilen her ekstra kart için, tüm düşmanlardan [Arg1] <PowerIconKeywords:STR> çal, %4 Geçici Kritik Oranı kazan ve bu etki Elit veya Reis Savaşlarında ikiye katlanır. Bir Ultra Tur başladıktan sonra, [Arg2] <PowerIconKeywords:STR> kazan ve Krit. Hasarı %15 artır."
  },
  RelicConfig_23690_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Aralık\">"
  },
  RelicConfig_23691_BattleDesc = {
    Text = "Verilen her 5 Hasar örneği için [Arg1] HP yenile. Kaybedilen her HP için Dokunaç Hasarı +[Arg2]. [Arg3] HP'den fazla kaybedilirse, tüm Dokunaçları bir kez tetikle."
  },
  RelicConfig_23691_Desc = {
    Text = "Her 5 isabet için [Arg1] HP yenile. Kaybedilen her HP için Dokunaç Hasarı +[Arg2]. HP kaybı Maksimum HP'nin %10'unu aşarsa, tüm Dokunaçları bir kez tetikle."
  },
  RelicConfig_23691_Name = {
    Text = "<OrangeQuality:Krono Sarkaç\"Gelgit\">"
  },
  RelicConfig_35135_BattleDesc = {
    Text = "Verilen her Hasar örneği için, en fazla tur başına 12 tetiklenmeyle, [Arg1] Geçici <PowerIconKeywords:GÜÇ> ve [Arg2] Geçici Dokunaç Hasarı kazan. Tek bir turda 4 Hasar örneği verilirse, tüm düşmanlara 1 yığın Savunmasız uygula ve [Arg3] Karakter Kalkanı kazan. Aynı turda 8 Hasar örneği verilirse, tüm düşmanlara 1 yığın Zayıflık uygula ve [Arg3] CP yenile."
  },
  RelicConfig_35135_Desc = {
    Text = "Verilen her Hasar örneği için, en fazla tur başına 12 tetiklenmeyle, [Arg1] Geçici <PowerIconKeywords:GÜÇ> ve [Arg2] Geçici Dokunaç Hasarı kazan. Tek bir turda 4 Hasar örneği verilirse, tüm düşmanlara 1 yığın Savunmasız uygula ve [Arg3] Karakter Kalkanı kazan. Aynı turda 8 Hasar örneği verilirse, tüm düşmanlara 1 yığın Zayıflık uygula ve [Arg3] CP yenile."
  },
  RelicConfig_35135_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Trans\">"
  },
  RelicConfig_35136_BattleDesc = {
    Text = "\"Darbe\" Hasarı ve \"Savunma\" Karakter Kalkanı Üretimi %30 artar. Bir turda 4 veya daha fazla \"Darbe\" ve \"Savunma\" kartı oynarsan, sonraki turun başında 2 kart çek ve 1 Arithmetica kazan."
  },
  RelicConfig_35136_Desc = {
    Text = "\"Darbe\" Hasarı ve \"Savunma\" Karakter Kalkanı Üretimi %30 artar. Bir turda 4 veya daha fazla \"Darbe\" ve \"Savunma\" kartı oynarsan, sonraki turun başında 2 kart çek ve 1 Arithmetica kazan."
  },
  RelicConfig_35136_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"İnatçı\">"
  },
  RelicConfig_35137_BattleDesc = {
    Text = "Oynanan her kart [Arg1] Geçici <PowerIconKeywords:STR> verir ve [Arg2] HP yeniler. Aktif Hasar verdikten sonra, bu Hatıradan kazanılan [Arg2] <PowerIconKeywords:STR>'yi kaldır. Her öldürülen düşman için Uyanan 30 Aliemus kazanır."
  },
  RelicConfig_35137_Desc = {
    Text = "Oynanan her kart [Arg1] Geçici <PowerIconKeywords:STR> verir ve [Arg2] HP yeniler. Aktif Hasar verdikten sonra, bu Hatıradan kazanılan [Arg2] <PowerIconKeywords:STR>'yi kaldır. Her öldürülen düşman için Uyanan 30 Aliemus kazanır."
  },
  RelicConfig_35137_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Şarj\">"
  },
  RelicConfig_35138_BattleDesc = {
    Text = "Bir Yüce Güç salındıktan sonra, rastgele bir düşmana [Arg1] Zehir uygula. Oynanan her Komut Kartı için [Arg2] Geçici Sayaç kazan. Her 4 turun sonunda, tüm düşmanlara, onların Zehir yığınları ile senin Sayaç yığınlarının toplamına eşit Hasar ver."
  },
  RelicConfig_35138_Desc = {
    Text = "Bir Yüce Güç salındıktan sonra, rastgele bir düşmana [Arg1] Zehir uygula. Oynanan her Komut Kartı için [Arg2] Geçici Sayaç kazan. Her 4 turun sonunda, tüm düşmanlara, onların Zehir yığınları ile senin Sayaç yığınlarının toplamına eşit Hasar ver."
  },
  RelicConfig_35138_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Çoğalma\">"
  },
  RelicConfig_35139_BattleDesc = {
    Text = "Alındığında, takımın Hasar Güçlendirmesini %30 artır. Verilen her 4. Hasar örneği bir Kritik Vuruş olur ve Krit. Hasar %50 artar. Vuruş bir öldürmeyle sonuçlanırsa, 5 Kara Mühür kazan."
  },
  RelicConfig_35139_Desc = {
    Text = "Alındığında, takımın Hasar Güçlendirmesini %30 artır. Verilen her 4. Hasar örneği bir Kritik Vuruş olur ve Krit. Hasar %50 artar. Vuruş bir öldürmeyle sonuçlanırsa, 5 Kara Mühür kazan."
  },
  RelicConfig_35139_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Son\">"
  },
  RelicConfig_36823_BattleDesc = {
    Text = "Yüce Güçten sonra 1 kart çek. Her atılan kart için, tüm Uyananlar 3 Aliemus kazanır, tur başına en fazla 15'e kadar."
  },
  RelicConfig_36823_Desc = {
    Text = "Yüce Güçten sonra 1 kart çek. Her atılan kart için, tüm Uyananlar 3 Aliemus kazanır, tur başına en fazla 15'e kadar."
  },
  RelicConfig_36823_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Karşılık\">"
  },
  RelicConfig_36824_BattleDesc = {
    Text = "Her Arithmetica harcandığında, tur başına en fazla 5 kez 1 kart çek. Deste her karıştırıldığında 2 Arithmetica kazan."
  },
  RelicConfig_36824_Desc = {
    Text = "Her Arithmetica harcandığında, tur başına en fazla 5 kez 1 kart çek. Deste her karıştırıldığında 2 Arithmetica kazan."
  },
  RelicConfig_36824_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Uykusuz\">"
  },
  RelicConfig_39302_BattleDesc = {
    Text = "Verilen her 4 Hasar örneği için, tur başına en fazla 3 kez, Çekme Desteğine 1 <DerivativeCardKeywords_4:\"Kavrayış\"> Karıştır. Bir Yüce Güçten sonra, Çekme Desteğindeki tüm <DerivativeCardKeywords_4:\"Kavrayış\"> kartlarını oyna ve tüket."
  },
  RelicConfig_39302_Desc = {
    Text = "Verilen her 4 Hasar örneği için, tur başına en fazla 3 kez, Çekme Desteğine 1 <DerivativeCardKeywords_4:\"Kavrayış\"> Karıştır. Bir Yüce Güçten sonra, Çekme Desteğindeki tüm <DerivativeCardKeywords_4:\"Kavrayış\"> kartlarını oyna ve tüket."
  },
  RelicConfig_39302_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Düş\">"
  },
  RelicConfig_39303_BattleDesc = {
    Text = "Geçerli Arithmetica tek sayı olduğunda, fazladan [Arg2] Geçici Alarm kazanır. Geçerli Arithmetica çift sayı olduğunda, fazladan [Arg1] Geçici <PowerIconKeywords:GÜÇ> ve [Arg3] Geçici Dokunaç Hasarı kazanır. Her Altın Kalıntı, bu Kalıntı'nın Etki'sini %50 artırır ve her Lanetli Kalıntı onu %80 artırır."
  },
  RelicConfig_39303_Desc = {
    Text = "Geçerli Arithmetica tek sayı olduğunda, fazladan [Arg2] Geçici Alarm kazanır. Geçerli Arithmetica çift sayı olduğunda, fazladan [Arg1] Geçici <PowerIconKeywords:GÜÇ> ve [Arg3] Geçici Dokunaç Hasarı kazanır. Her Altın Kalıntı, bu Kalıntı'nın Etki'sini %50 artırır ve her Lanetli Kalıntı onu %80 artırır."
  },
  RelicConfig_39303_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Düş Ürpertisi\">"
  },
  RelicConfig_44192_BattleDesc = {
    Text = "Tur başında tüm Uyandıranlar 20 Aliemus kazanır. Alındığında Maksimum HP %50 azalır."
  },
  RelicConfig_44192_Desc = {
    Text = "Tur başında tüm Uyandıranlar 20 Aliemus kazanır. Alındığında Maksimum HP %50 azalır."
  },
  RelicConfig_44192_Name = {
    Text = "<RedQuality:Günahkâr· Kâbus Tezahürü>"
  },
  RelicConfig_44192_StoryDesc = {
    Text = "Müptela derin uyku, farkına varmadan önce her şeyi yutan arzunun ta kendisidir."
  },
  RelicConfig_44300_BattleDesc = {
    Text = "Tur başında tüm Uyandıranlar 25 Aliemus kazanır. Alındığında Maksimum HP x3 olur."
  },
  RelicConfig_44300_Desc = {
    Text = "Tur başında tüm Uyandıranlar 25 Aliemus kazanır. Alındığında Maksimum HP x3 olur."
  },
  RelicConfig_44300_Name = {
    Text = "<OrangeQuality:Kutsanmış· Kâbus Tezahürü>"
  },
  RelicConfig_44300_StoryDesc = {
    Text = "Korkma, tereddüt etme. Bu yalnızca bir anlık güzel düş; Yaratıcı Tanrı’nın ışığı hâlâ üzerine vuruyor."
  },
  RelicConfig_44592_BattleDesc = {
    Text = "Savaştan sonra 100 Kara Mühür ve 2 Semptom kartı kazan."
  },
  RelicConfig_44592_Desc = {
    Text = "Savaştan sonra 100 Kara Mühür ve 2 Semptom kartı kazan."
  },
  RelicConfig_44592_Name = {
    Text = "<RedQuality:Günahkâr· Yeşim Baskı>"
  },
  RelicConfig_44592_StoryDesc = {
    Text = "Kadim günahlar buraya kazınmış."
  },
  RelicConfig_44593_BattleDesc = {
    Text = "Alındığında, rastgele 1 Günahkâr Kalıntı’ya (kendisi hariç) dönüşür ve 75 Kara Mühür kazanırsın."
  },
  RelicConfig_44593_Desc = {
    Text = "Alındığında, rastgele 1 Günahkâr Kalıntı’ya (kendisi hariç) dönüşür ve 75 Kara Mühür kazanırsın."
  },
  RelicConfig_44593_Name = {
    Text = "<RedQuality:Günahkâr· Lanetli Stel>"
  },
  RelicConfig_44593_StoryDesc = {
    Text = "Dinle, içeriden biri sesleniyor."
  },
  RelicConfig_44594_BattleDesc = {
    Text = "Her 2 turda bir, o tur boyunca tüm düşmanların aldığı Aktif ve Dokunaç Hasarı’nı ikiye katla. Ancak o turda Yüceltme serbest bırakıldıktan sonra, tüm Uyanış sahiplerini 1 tur boyunca mühürle ve kendini Savunmasız yap."
  },
  RelicConfig_44594_Desc = {
    Text = "Her 2 turda bir, o tur boyunca tüm düşmanların aldığı Aktif ve Dokunaç Hasarı’nı ikiye katla. Ancak o turda Yüceltme serbest bırakıldıktan sonra, tüm Uyanış sahiplerini 1 tur boyunca mühürle ve kendini Savunmasız yap."
  },
  RelicConfig_44594_Name = {
    Text = "<RedQuality:Günahkâr· Yol Yürüyenin Kalıntıları>"
  },
  RelicConfig_44594_StoryDesc = {
    Text = "Kutsal bir parça.\nGövdesinden koparılmış, günahla lekelenmiştir."
  },
  RelicConfig_44597_BattleDesc = {
    Text = "Verilen her bir Aktif Hasar örneği için, kendine [Arg1] yığın <BleedingIconKeywords:Kan Akıtma> ve hedefe [Arg2] yığın <BleedingIconKeywords:Kan Akıtma> uygula."
  },
  RelicConfig_44597_Desc = {
    Text = "Verilen her bir Aktif Hasar örneği için, kendine [Arg1] yığın <BleedingIconKeywords:Kan Akıtma> ve hedefe [Arg2] yığın <BleedingIconKeywords:Kan Akıtma> uygula."
  },
  RelicConfig_44597_Name = {
    Text = "<RedQuality:Günahkâr· Sürü Bilinci>"
  },
  RelicConfig_44597_StoryDesc = {
    Text = "Sarmalamak, Ortak Duyum, Sürü; Korku, Bilinmeyen Yaratık, Kontrol."
  },
  RelicConfig_44598_BattleDesc = {
    Text = "Taşkınlık serbest bırakıldıktan sonra, mevcut CP’nin %12’sini kaybet ve tüm düşmanlardan [Arg1] Geçici <PowerIconKeywords:Kaba Güç> çal. Yalnızca 1 düşman varsa, ayrıca [Arg2] Geçici <PowerIconKeywords:Kaba Güç> çal."
  },
  RelicConfig_44598_Desc = {
    Text = "Taşkınlık serbest bırakıldıktan sonra, mevcut CP’nin %12’sini kaybet ve tüm düşmanlardan [Arg1] Geçici <PowerIconKeywords:Kaba Güç> çal. Yalnızca 1 düşman varsa, ayrıca [Arg2] Geçici <PowerIconKeywords:Kaba Güç> çal."
  },
  RelicConfig_44598_Name = {
    Text = "<RedQuality:Günahkâr· Kehanet Ritüel Kuşu>"
  },
  RelicConfig_44598_StoryDesc = {
    Text = "Hırsla öldürülen zavallı yaratık, kurumuş göğsünden delici bir çığlık salıverir."
  },
  RelicConfig_44603_BattleDesc = {
    Text = "El sınırını 5 artır ve savaşın başında 6 kart çek. Tur sonunda, elindeki tüm Semptom kartlarını ve Durum Kartlarını at, diğer kartları Sakla, ancak her tur 2 kart daha az çek."
  },
  RelicConfig_44603_Desc = {
    Text = "El sınırını 5 artır ve savaşın başında 6 kart çek. Tur sonunda, elindeki tüm Semptom kartlarını ve Durum Kartlarını at, diğer kartları Sakla, ancak her tur 2 kart daha az çek."
  },
  RelicConfig_44603_Name = {
    Text = "<RedQuality:Günahkâr· Bilinç Kazıması>"
  },
  RelicConfig_44603_StoryDesc = {
    Text = "Açgözlüler başkalarını birer nesne gibi görür, başkalarının ıstırabından haz devşirir."
  },
  RelicConfig_44608_BattleDesc = {
    Text = "Alındığında, Kalıcı olarak [Arg1] <PowerIconKeywords:Kaba Güç> kaybedersin. Ne zaman Hasar verirsen, her seferinde [Arg2] CP iyileşirsin; tur başına en fazla 6 kez tetiklenir."
  },
  RelicConfig_44608_Desc = {
    Text = "Alındığında, Kalıcı olarak [Arg1] <PowerIconKeywords:Kaba Güç> kaybedersin. Ne zaman Hasar verirsen, her seferinde [Arg2] CP iyileşirsin; tur başına en fazla 6 kez tetiklenir."
  },
  RelicConfig_44608_Name = {
    Text = "<RedQuality:Günahkâr· Yedi Solungaçlı Öpücük>"
  },
  RelicConfig_44608_StoryDesc = {
    Text = "Onun öpücüğü seni dibe çeker—ama belki de batan sensin."
  },
  RelicConfig_44609_BattleDesc = {
    Text = "Maksimum Arithmetica 3 artar. Deste her sıfırlandığında, Çekme Desteğine 2 adet <DerivativeCardKeywords_9:Sendeleme> ekle."
  },
  RelicConfig_44609_Desc = {
    Text = "Maksimum Arithmetica 3 artar. Deste her sıfırlandığında, Çekme Desteğine 2 adet <DerivativeCardKeywords_9:Sendeleme> ekle."
  },
  RelicConfig_44609_Name = {
    Text = "<RedQuality:Günahkâr· Kara Mum>"
  },
  RelicConfig_44609_StoryDesc = {
    Text = "Akıl sağlığını yak, deliliğe yuvarlan."
  },
  RelicConfig_44610_BattleDesc = {
    Text = "Krit. Oranı ve Krit. Hasar %50 artar. Tur başında 1 tur boyunca kendine <FragileIconKeywords:Kırılgan> uygula."
  },
  RelicConfig_44610_Desc = {
    Text = "Krit. Oranı ve Krit. Hasar %50 artar. Tur başında 1 tur boyunca kendine <FragileIconKeywords:Kırılgan> uygula."
  },
  RelicConfig_44610_Name = {
    Text = "<RedQuality:Günahkâr· Ürkütücü Kanca>"
  },
  RelicConfig_44610_StoryDesc = {
    Text = "Arzu tarafından bükülmüş pençeler."
  },
  RelicConfig_44654_BattleDesc = {
    Text = "Maksimum Arithmetica +4. Deste her sıfırlandığında, Çekme Destesi’ne 4 <DerivativeCardKeywords_4:\"Insight\"> ekle."
  },
  RelicConfig_44654_Desc = {
    Text = "Maksimum Arithmetica +4. Deste her sıfırlandığında, Çekme Destesi’ne 4 <DerivativeCardKeywords_4:\"Insight\"> ekle."
  },
  RelicConfig_44654_Name = {
    Text = "<OrangeQuality:Kutsanmış· Siyah Mum>"
  },
  RelicConfig_44654_StoryDesc = {
    Text = "Yanan arzuyla, kurtuluşa er."
  },
  RelicConfig_44656_BattleDesc = {
    Text = "Kalıntı Kapasitesi +[Arg1], \"D-iz\" yenileme denemeleri +1. Savaştan sonra 125 Kara Mühür kazan. Alırken, en fazla 6 Semptom kartını silmeyi seçebilirsin."
  },
  RelicConfig_44656_Desc = {
    Text = "Kalıntı Kapasitesi +[Arg1], \"D-iz\" yenileme denemeleri +1. Savaştan sonra 125 Kara Mühür kazan. Alırken, en fazla 6 Semptom kartını silmeyi seçebilirsin."
  },
  RelicConfig_44656_Name = {
    Text = "<OrangeQuality:Kutsanmış· Yeşim Baskı>"
  },
  RelicConfig_44656_StoryDesc = {
    Text = "Yaratıcı Tanrı'nın kurtuluşu acıyı silip süpürdü."
  },
  RelicConfig_44658_BattleDesc = {
    Text = "Yüceltim serbest bırakıldıktan sonra [Arg1] Geçici GÜÇ kazan ve tüm düşmanlardan [Arg1] Geçici <PowerIconKeywords:STR> çal. Yalnızca 1 düşman varsa, fazladan [Arg2] Geçici <PowerIconKeywords:STR> çal."
  },
  RelicConfig_44658_Desc = {
    Text = "Yüceltim serbest bırakıldıktan sonra [Arg1] Geçici GÜÇ kazan ve tüm düşmanlardan [Arg1] Geçici <PowerIconKeywords:STR> çal. Yalnızca 1 düşman varsa, fazladan [Arg2] Geçici <PowerIconKeywords:STR> çal."
  },
  RelicConfig_44658_Name = {
    Text = "<OrangeQuality:Kutsanmış· Kehanet Ritüel Kuşu>"
  },
  RelicConfig_44658_StoryDesc = {
    Text = "Bağışlanmanın ışığı, açgözlülüğün kalıntılarını sarar ve ölü kuşlar son şarkılarını söyler."
  },
  RelicConfig_44659_BattleDesc = {
    Text = "Verilen her bir Aktif Hasar örneği için [Arg1] CP yenile ve hedefe [Arg2] yığın <BleedingIconKeywords:Kan Akıtma> uygula."
  },
  RelicConfig_44659_Desc = {
    Text = "Verilen her bir Aktif Hasar örneği için [Arg1] CP yenile ve hedefe [Arg2] yığın <BleedingIconKeywords:Kan Akıtma> uygula."
  },
  RelicConfig_44659_Name = {
    Text = "<OrangeQuality:Kutsanmış· Sürü Bilinci>"
  },
  RelicConfig_44659_StoryDesc = {
    Text = "Sarmalamak, Ortak Duyum, Sürü; Birlik, Bir Arada Varoluş, Sığınak."
  },
  RelicConfig_44660_BattleDesc = {
    Text = "El sınırını 5 artır ve savaş başında eli sınırına kadar yenile. Tur başında ek 1 kart çek ve tur sonunda tüm Semptom kartlarını ve Durum Kartlarını atarken diğer kartları sakla."
  },
  RelicConfig_44660_Desc = {
    Text = "El sınırını 5 artır ve savaş başında eli sınırına kadar yenile. Tur başında ek 1 kart çek ve tur sonunda tüm Semptom kartlarını ve Durum Kartlarını atarken diğer kartları sakla."
  },
  RelicConfig_44660_Name = {
    Text = "<OrangeQuality:Kutsanmış· Bilinç Kazıması>"
  },
  RelicConfig_44660_StoryDesc = {
    Text = "Açgözlüler, hatalarını kalplerine oyar ve kendilerini geçmişlerinin kefaretine adarlar."
  },
  RelicConfig_44662_BattleDesc = {
    Text = "Her 2 turda bir, o tur boyunca tüm düşmanların aldığı Aktif ve Dokunaç Hasarı’nı ikiye katla. O turda kullanılan her Yüceltme için, rastgele 1 zayıflatma etkisini dağıt."
  },
  RelicConfig_44662_Desc = {
    Text = "Her 2 turda bir, o tur boyunca tüm düşmanların aldığı Aktif ve Dokunaç Hasarı’nı ikiye katla. O turda kullanılan her Yüceltme için, rastgele 1 zayıflatma etkisini dağıt."
  },
  RelicConfig_44662_Name = {
    Text = "<OrangeQuality:Kutsanmış· Yol Yürüyücüsünün Kalıntıları>"
  },
  RelicConfig_44662_StoryDesc = {
    Text = "Kutsal bir parça.\nBedenden ayrılmış olsa da, ayak izleri dünyaya yayılmış durumda."
  },
  RelicConfig_44663_BattleDesc = {
    Text = "Kritik Oranı %50 artar, Krit. Hasar %100 artar."
  },
  RelicConfig_44663_Desc = {
    Text = "Kritik Oranı %50 artar, Krit. Hasar %100 artar."
  },
  RelicConfig_44663_Name = {
    Text = "<OrangeQuality:Kutsanmış· Tekinsiz Kanca>"
  },
  RelicConfig_44663_StoryDesc = {
    Text = "Tüm arzular terk edildi."
  },
  RelicConfig_44664_BattleDesc = {
    Text = "Alındıktan sonra kalıcı olarak [Arg1] <PowerIconKeywords:STR> elde et. Hasar verildiğinde her seferinde [Arg2] CP iyileş; tur başına en fazla 6 kez tetiklenir."
  },
  RelicConfig_44664_Desc = {
    Text = "Alındıktan sonra kalıcı olarak [Arg1] <PowerIconKeywords:STR> elde et. Hasar verildiğinde her seferinde [Arg2] CP iyileş; tur başına en fazla 6 kez tetiklenir."
  },
  RelicConfig_44664_Name = {
    Text = "<OrangeQuality:Kutsanmış· Yedi Solungaçlı Öpücük>"
  },
  RelicConfig_44664_StoryDesc = {
    Text = "Bu lanet öpücüğünü reddet; çünkü Yaratıcı Tanrı’nın kucaklayışı, herhangi bir karanlıktan daha sıcaktır."
  },
  RelicConfig_47444_BattleDesc = {
    Text = "\"Saldırı\" ve \"Savunma\" fazladan 50 Keyflare kazanır. Arithmetica Maliyeti 2 veya daha fazla olan bir kart her oynandığında, Arithmetica Maliyeti 1 olan bir kart çek ve maliyetini 0’a düşür; tur başına en fazla 3 kez."
  },
  RelicConfig_47444_Desc = {
    Text = "\"Saldırı\" ve \"Savunma\" fazladan 50 Keyflare kazanır. Arithmetica Maliyeti 2 veya daha fazla olan bir kart her oynandığında, Arithmetica Maliyeti 1 olan bir kart çek ve maliyetini 0’a düşür; tur başına en fazla 3 kez."
  },
  RelicConfig_47444_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"İkizler\">"
  },
  RelicConfig_50338_BattleDesc = {
    Text = "Savaş başında, tüm Uyananların <ExaltIconKeywords:Rouse>’larını desteğe karıştır. 6. turdan itibaren, Thais her tur savaş desteği sağlayacak."
  },
  RelicConfig_50338_Desc = {
    Text = "Savaş başında, tüm Uyananların <ExaltIconKeywords:Rouse>’larını desteğe karıştır. 6. turdan itibaren, Thais her tur savaş desteği sağlayacak."
  },
  RelicConfig_50338_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Büyüleme\">"
  },
  RelicConfig_50338_StoryDesc = {
    Text = "“Korkma,” dedi."
  },
  RelicConfig_50385_BattleDesc = {
    Text = "Aldığında, Arithmetica Maliyeti kalıcı olarak 1’e düşürülecek bir kart seç."
  },
  RelicConfig_50385_Desc = {
    Text = "Aldığında, Arithmetica Maliyeti kalıcı olarak 1’e düşürülecek bir kart seç."
  },
  RelicConfig_50385_Name = {
    Text = "<WhiteQuality:☆Kurumuş Göz Bebeği☆>"
  },
  RelicConfig_50385_StoryDesc = {
    Text = "Çölün en kıymetli suyunu yitirdiğinden beri, onun gözleri kuruyup soldu."
  },
  RelicConfig_50487_BattleDesc = {
    Text = "Savaşın ilk turunun başında, eline <DerivativeCardKeywords_46:Priyon Virüsü> ekle; 3. turda eline <DerivativeCardKeywords_49:Obur Saldırı> ekle; Ölüm Direnci tetiklendikten sonra eline <DerivativeCardKeywords_52:Canlanma Kozası> ekle."
  },
  RelicConfig_50487_Desc = {
    Text = "Savaşın ilk turunun başında, eline <DerivativeCardKeywords_46:Priyon Virüsü> ekle; 3. turda eline <DerivativeCardKeywords_49:Obur Saldırı> ekle; Ölüm Direnci tetiklendikten sonra eline <DerivativeCardKeywords_52:Canlanma Kozası> ekle."
  },
  RelicConfig_50487_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Kutsama\">"
  },
  RelicConfig_50488_BattleDesc = {
    Text = "Tur sonunda: En az Aliemus’a sahip Uyanan 35 Aliemus kazanır. Kalan HP ≥%50 ise, [Arg1] <PowerIconKeywords:STR> kazan. Kalan HP ＜%50 ise, [Arg2] HP yenile."
  },
  RelicConfig_50488_Desc = {
    Text = "Tur sonunda: En az Aliemus’a sahip Uyanan 35 Aliemus kazanır. Mevcut HP %50 veya üzerindeyse, [Arg1] <PowerIconKeywords:STR> kazan. Mevcut HP %50’nin altındaysa, [Arg2] HP yenile."
  },
  RelicConfig_50488_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Denge\">"
  },
  RelicConfig_50489_BattleDesc = {
    Text = "Krit. Oranı ve Krit. Hasar %100 artar. Verilen her bir Hasar örneği için, tüm Uyananların Krit. Oranı ve Krit. Hasarı %10 azalır, azalma en fazla %50’ye kadar çıkabilir. Verilen her bir Hasar örneği için, bu tur uygulanan Zehir ve Sayaç Hasarı %10 artar, artış en fazla %50’ye kadar çıkabilir."
  },
  RelicConfig_50489_Desc = {
    Text = "Krit. Oran ve Krit. Hasar +%100. Bu tur verilen her bir Hasar/Dokunaç Hasarı örneği için, tüm Uyananların Krit. Oranı ve Krit. Hasarı %10 azalır, en fazla %50’ye kadar. Zehir ve Sayaç hasarı +%10, en fazla %50’ye kadar."
  },
  RelicConfig_50489_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Kabaran\">"
  },
  RelicConfig_51686_BattleDesc = {
    Text = "Her seferinde, bir önce oynanan Uyandıran'dan farklı bir Uyandıran'a ait bir Komut Kartı oynandığında, o Uyandıran 3 Aliemus kazanır ve 1 yığın \"Canlılık\" biriktirir. 10 yığın biriktiğinde tüm \"Canlılık\" temizlenir ve her Uyandıran için, \"Tüketme\" ye sahip ve Arithmetica Maliyeti 1 azaltılmış rastgele bir Komut Kartı Elde konumuna yerleştirilir. Bu Etki, tur başına en fazla 1 kez tetiklenebilir."
  },
  RelicConfig_51686_Desc = {
    Text = "Her seferinde, bir önce oynanan Uyandıran'dan farklı bir Uyandıran'a ait bir Komut Kartı oynandığında, o Uyandıran 3 Aliemus kazanır ve 1 yığın \"Canlılık\" biriktirir. 10 yığın biriktiğinde tüm \"Canlılık\" temizlenir ve her Uyandıran için, \"Tüketme\" ye sahip ve Arithmetica Maliyeti 1 azaltılmış rastgele bir Komut Kartı Elde konumuna yerleştirilir. Bu Etki, tur başına en fazla 1 kez tetiklenebilir."
  },
  RelicConfig_51686_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Evrim\">"
  },
  RelicConfig_51687_BattleDesc = {
    Text = "\"Darbe\" veya \"Savunma\" olmayan bir Komut Kartı oynadıktan sonra, eğer kart bir Türetilmiş Kart değilse, ilgili Uyanan 15 Aliemus kazanır; bu, Tur başına en fazla 5 kez tetiklenir. Her Turun ilk tetiklenişinde, oynanan kart ayrıca eline geri döner."
  },
  RelicConfig_51687_Desc = {
    Text = "\"Saldırı\" veya \"Savunma\" olmayan bir Komut Kartı oynadıktan sonra, kart Türetilmiş Kart değilse, ilgili Uyandırıcı 15 Aliemus kazanır, tur başına en fazla 5 kez tetiklenir. Her turun ilk tetiklenmesinde, oynanan kart ayrıca eline geri döner."
  },
  RelicConfig_51687_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Yansıtım\">"
  },
  RelicConfig_51688_BattleDesc = {
    Text = "Alındığında, tüm Komut Kartlarına \"Sakla\" ekle. Tur sonunda, eldeki kart sayısı 5 veya daha fazlaysa, eldeki rastgele 3 kartın Arithmetica Maliyeti 1 azalır; aksi halde 3 kart çek."
  },
  RelicConfig_51688_Desc = {
    Text = "Alındığında, tüm Komut Kartlarına \"Sakla\" ekle. Tur sonunda, eldeki kart sayısı 5 veya daha fazlaysa, eldeki rastgele 3 kartın Arithmetica Maliyeti 1 azalır; aksi halde 3 kart çek."
  },
  RelicConfig_51688_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Üreme\">"
  },
  RelicConfig_51689_BattleDesc = {
    Text = "Savaşın başında, destesine 3 rastgele Semptom kartı karıştır. Tur başında 1 kart çek. Her Semptom kartı oynamak 2 Arithmetica kazandırır. Her Semptom kartını atmak, tüm Uyananlara tur başına en fazla 5 kez olmak üzere 5 Aliemus kazandırır."
  },
  RelicConfig_51689_Desc = {
    Text = "Savaşın başında, destesine 3 rastgele Semptom kartı karıştır. Tur başında 1 kart çek. Her Semptom kartı oynamak 2 Arithmetica kazandırır. Her Semptom kartını atmak, tüm Uyananlara tur başına en fazla 5 kez olmak üzere 5 Aliemus kazandırır."
  },
  RelicConfig_51689_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Veba\">"
  },
  RelicConfig_55847_BattleDesc = {
    Text = "Simülasyon Savaşı Standart Kalıntı Seti (7 Parça)"
  },
  RelicConfig_55847_Desc = {
    Text = "Simülasyon Savaşı Standart Kalıntı Seti (7 Parça)"
  },
  RelicConfig_55847_Name = {
    Text = "<RedQuality:☆Simülasyon Kalıntısı☆>"
  },
  RelicConfig_55847_StoryDesc = {
    Text = "Bu tuhaf çağda, çiçekler İnsanlığın Işığı’nın başlıca seyircileridir.\nKıpırdama; sessiz sergileri tercih ederler."
  },
  RelicConfig_55874_BattleDesc = {
    Text = "Savaştan sonra [Arg1] yığın \"Mürekkep\" kazan. \"Mürekkep\" 2 yığına ulaştığında, Tüketme, ardından desteye rastgele 1 \"İmgelem\" kartı yerleştir."
  },
  RelicConfig_55874_Desc = {
    Text = "Savaştan sonra [Arg1] yığın \"Mürekkep\" kazan. \"Mürekkep\" 2 yığına ulaştığında, Tüketme, ardından desteye rastgele 1 \"İmgelem\" kartı yerleştir."
  },
  RelicConfig_55874_Name = {
    Text = "<OrangeQuality:Horla'nın Kalemi ve Mürekkebi>"
  },
  RelicConfig_55874_StoryDesc = {
    Text = "Kadim günahlar buraya kazınmış."
  },
  RelicConfig_56355_BattleDesc = {
    Text = "El Limiti +2, turun başında 1 kart çek. Savaştan sonra [Arg1] \"Mürekkep\" katmanı kazanırsın ve \"Mürekkep\" 2 yığına ulaştığında, destene yerleştirmek üzere 1 \"İmgelem\" seçmek için tüketilir."
  },
  RelicConfig_56355_Desc = {
    Text = "El Limiti +2, turun başında 1 kart çek. Savaştan sonra [Arg1] \"Mürekkep\" katmanı kazanırsın ve \"Mürekkep\" 2 yığına ulaştığında, destene yerleştirmek üzere 1 \"İmgelem\" seçmek için tüketilir."
  },
  RelicConfig_56355_Name = {
    Text = "<OrangeQuality:Horla'nın Kalemi ve Mürekkebi>"
  },
  RelicConfig_56355_StoryDesc = {
    Text = "Kadim günahlar buraya kazınmış."
  },
  RelicConfig_56356_BattleDesc = {
    Text = "Savaştan sonra [Arg1] yığın \"Mürekkep\" kazan. \"Mürekkep\" 2 yığına ulaştığında, Tüketme, ardından desteye yerleştirmek üzere 1 \"İmgelem\" kartı seç."
  },
  RelicConfig_56356_Desc = {
    Text = "Savaştan sonra [Arg1] yığın \"Mürekkep\" kazan. \"Mürekkep\" 2 yığına ulaştığında, Tüketme, ardından desteye yerleştirmek üzere 1 \"İmgelem\" kartı seç."
  },
  RelicConfig_56356_Name = {
    Text = "<OrangeQuality:Horla'nın Kalemi ve Mürekkebi>"
  },
  RelicConfig_56356_StoryDesc = {
    Text = "Kadim günahlar buraya kazınmış."
  },
  RelicConfig_57667_BattleDesc = {
    Text = "2 yığın İlahi Ana'nın Kudreti ile başla. Üçüncü turdan sonra, tur başında İlahi Ana'nın Kudreti'ni farklı Etki'ler için tüketmeyi ya da onu yenilemeyi seç. Ölümcül Hasar alırsan, diril ve tüm İlahi Ana'nın Kudreti yığınlarını tüket; her yığın %10 CP yeniler. Bu Etki yalnızca bir kez tetiklenebilir."
  },
  RelicConfig_57667_Desc = {
    Text = "2 yığın İlahi Ana'nın Kudreti ile başla. Üçüncü turdan sonra, tur başında İlahi Ana'nın Kudreti'ni farklı Etki'ler için tüketmeyi ya da onu yenilemeyi seç. Ölümcül Hasar alırsan, diril ve tüm İlahi Ana'nın Kudreti yığınlarını tüket; her yığın %10 CP yeniler. Bu Etki yalnızca bir kez tetiklenebilir."
  },
  RelicConfig_57667_Name = {
    Text = "<OrangeQuality:İlahi Ana'nın Himayesi>"
  },
  RelicConfig_57732_BattleDesc = {
    Text = "Tüm Uyananın Kritik Oranı %15 artar. Ryker ve zarın rastgele etkilerinin Final sonucu 1 artar."
  },
  RelicConfig_57732_Desc = {
    Text = "Tüm Uyananın Kritik Oranı %15 artar. Ryker ve zarın rastgele etkilerinin Final sonucu 1 artar."
  },
  RelicConfig_57732_Name = {
    Text = "<OrangeQuality:Özel Dikim Şanslı Rüzgârlık>"
  },
  RelicConfig_57732_StoryDesc = {
    Text = "Kalın bir Bariyer yükselterek rüzgârları, yağmurları ve talihsizlikleri dışarıda tutacaktır."
  },
  RelicConfig_57733_BattleDesc = {
    Text = "Tur başında ve Ryker ya da zarın rastgele etkisi tetiklendiğinde 100 Anahtarışığı ve %4 Kritik Hasar kazan, en fazla %50 Kritik Hasara kadar. Savaşın sonunda kaldırılır."
  },
  RelicConfig_57733_Desc = {
    Text = "Tur başında ve Ryker ya da zarın rastgele etkisi tetiklendiğinde 100 Anahtarışığı ve %4 Kritik Hasar kazan, en fazla %50 Kritik Hasara kadar. Savaşın sonunda kaldırılır."
  },
  RelicConfig_57733_Name = {
    Text = "<OrangeQuality:Zarif Büyük Ağız Düğmesi>"
  },
  RelicConfig_57733_StoryDesc = {
    Text = "Kocaağız Düğme ayı, cipsleri ve taze gözleri gibi yuvarlak olan her şeye bayılır.\nBilinmeyen nedenlerle, dolunay gecelerinde kara bir sis püskürtür."
  },
  RelicConfig_57734_BattleDesc = {
    Text = "Ne zaman Çeteyi Salıversen, ele 1 \"Parlayan Sekizyüzlü Zar\" koy."
  },
  RelicConfig_57734_Desc = {
    Text = "Ne zaman Çeteyi Salıversen, ele 1 \"Parlayan Sekizyüzlü Zar\" koy."
  },
  RelicConfig_57734_Name = {
    Text = "<OrangeQuality:Parlayan Sekizyüzlü Zar>"
  },
  RelicConfig_57734_StoryDesc = {
    Text = "Parlayan yalnızca yüzeyi değil, boyun eğmeyen kalbidir.\nOna beş saniyeden fazla bakarsan @2 için bir Çağrı başlatırsın."
  },
  RelicConfig_57735_BattleDesc = {
    Text = "Tur başında ve Ryker ya da zarın rastgele etkisi tetiklendiğinde 50 Anahtarışığı ve %2 Kritik Hasar kazan, en fazla %30 Kritik Hasara kadar. Savaşın sonunda kaldırılır."
  },
  RelicConfig_57735_Desc = {
    Text = "Tur başında ve Ryker ya da zarın rastgele etkisi tetiklendiğinde 50 Anahtarışığı ve %2 Kritik Hasar kazan, en fazla %30 Kritik Hasara kadar. Savaşın sonunda kaldırılır."
  },
  RelicConfig_57735_Name = {
    Text = "<OrangeQuality:Kocaağız Düğme>"
  },
  RelicConfig_57735_StoryDesc = {
    Text = "Kocaağız Düğme ayı, cipsleri ve taze gözleri gibi yuvarlak olan her şeye bayılır.\nBilinmeyen nedenlerle, dolunay gecelerinde kara bir sis püskürtür."
  },
  RelicConfig_57736_BattleDesc = {
    Text = "Çeteyi her Serbest Bıraktığında, ele 1 \"Sekizyüzlü Zar\" koy."
  },
  RelicConfig_57736_Desc = {
    Text = "Çeteyi her Serbest Bıraktığında, ele 1 \"Sekizyüzlü Zar\" koy."
  },
  RelicConfig_57736_Name = {
    Text = "<OrangeQuality:Sekizyüzlü Zar>"
  },
  RelicConfig_57736_StoryDesc = {
    Text = "Parlayan yalnızca yüzeyi değil, boyun eğmeyen kalbidir.\nOna beş saniyeden fazla bakarsan @2 için bir Çağrı başlatırsın."
  },
  RelicConfig_57737_BattleDesc = {
    Text = "Tüm Uyananların Krit. Oranı %10 artar. Ryker’ın ve zarların rastgele etkileri en düşük değer olamaz."
  },
  RelicConfig_57737_Desc = {
    Text = "Tüm Uyananların Krit. Oranı %10 artar. Ryker’ın ve zarların rastgele etkileri en düşük değer olamaz."
  },
  RelicConfig_57737_Name = {
    Text = "<OrangeQuality:Şanslı Rüzgârlık>"
  },
  RelicConfig_57737_StoryDesc = {
    Text = "Kalın bir Bariyer yükselterek rüzgârları, yağmurları ve talihsizlikleri dışarıda tutacaktır."
  },
  RelicConfig_57791_BattleDesc = {
    Text = "Kalıntı Kapasitesi +1. Savaş başladıktan sonraki ilk beş turda, tur başında bir Kalıntı kazan: \"Kızıl Broş, Telkâri Akik, SOS Sinyali, Kehanet Ritüel Kuşu, Krono Sarkaç: Trans\"."
  },
  RelicConfig_57791_Desc = {
    Text = "Kalıntı Kapasitesi +1. Savaş başladıktan sonraki ilk beş turda, tur başında bir Kalıntı kazan: \"Kızıl Broş, Telkâri Akik, SOS Sinyali, Kehanet Ritüel Kuşu, Krono Sarkaç: Trans\"."
  },
  RelicConfig_57791_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Batık Hazine\">"
  },
  RelicConfig_57791_StoryDesc = {
    Text = "Söylenene göre Lemurya bu sulara gömüldü. Batık hazinelerin sırlarını keşfetme cazibesine kim karşı koyabilir?"
  },
  RelicConfig_57792_BattleDesc = {
    Text = "Kalıntı Kapasitesi +1. Savaşın ilk beş turunun her birinin başında bir Kalıntı elde et: \"Dikenli Üç Dişli Mızrak, Yabancı Pul Albümü, Arcana Arşivi, Bilinç Kazıması, Krono Sarkaç: Birikim\"."
  },
  RelicConfig_57792_Desc = {
    Text = "Kalıntı Kapasitesi +1. Savaşın ilk beş turunun her birinin başında bir Kalıntı elde et: \"Dikenli Üç Dişli Mızrak, Yabancı Pul Albümü, Arcana Arşivi, Bilinç Kazıması, Krono Sarkaç: Birikim\"."
  },
  RelicConfig_57792_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Batık Hazine\">"
  },
  RelicConfig_57792_StoryDesc = {
    Text = "Söylenene göre Lemurya bu sulara gömüldü. Batık hazinelerin sırlarını keşfetme cazibesine kim karşı koyabilir?"
  },
  RelicConfig_57793_BattleDesc = {
    Text = "Kalıntı Kapasitesi +1. Savaş başladıktan sonraki ilk beş turda, tur başında bir Kalıntı kazan: \"Radyum Çene Kemiği\", \"Şüpheli Merhem\", \"Tozlanmış Dokuma Tezgâhı\", \"Yabancı Tür Sözcüsü\" ve \"Krono Sarkaç: Dalgalanma\"."
  },
  RelicConfig_57793_Desc = {
    Text = "Kalıntı Kapasitesi +1. Savaş başladıktan sonraki ilk beş turda, tur başında bir Kalıntı kazan: \"Radyum Çene Kemiği\", \"Şüpheli Merhem\", \"Tozlanmış Dokuma Tezgâhı\", \"Yabancı Tür Sözcüsü\" ve \"Krono Sarkaç: Dalgalanma\"."
  },
  RelicConfig_57793_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Batık Hazine\">"
  },
  RelicConfig_57793_StoryDesc = {
    Text = "Söylenene göre Lemurya bu sulara gömüldü. Batık hazinelerin sırlarını keşfetme cazibesine kim karşı koyabilir?"
  },
  RelicConfig_57794_BattleDesc = {
    Text = "Kalıntı Kapasitesi +1. Savaş başladıktan sonraki ilk beş turda, tur başında bir Kalıntı kazan: \"Isırgan Yeleği, Merhumun Cep Saati, Kadim Bilgelerin Kayıp Bölümü, Kurtuluş Uzvu, Krono Sarkaç: Çoğalma\"."
  },
  RelicConfig_57794_Desc = {
    Text = "Kalıntı Kapasitesi +1. Savaş başladıktan sonraki ilk beş turda, tur başında bir Kalıntı kazan: \"Isırgan Yeleği, Merhumun Cep Saati, Kadim Bilgelerin Kayıp Bölümü, Kurtuluş Uzvu, Krono Sarkaç: Çoğalma\"."
  },
  RelicConfig_57794_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Batık Hazine\">"
  },
  RelicConfig_57794_StoryDesc = {
    Text = "Söylenene göre Lemurya bu sulara gömüldü. Batık hazinelerin sırlarını keşfetme cazibesine kim karşı koyabilir?"
  },
  RelicConfig_57795_BattleDesc = {
    Text = "Kalıntı Kapasitesi +1. Savaş başladıktan sonraki ilk beş turda, tur başında bir Kalıntı kazanırsın: \"Paslanmış Neşter\", \"Hemostatik Klemp\", \"Eski Yapboz\", \"Sürü Zihni\" ve \"Krono Sarkaç: İkizler\"."
  },
  RelicConfig_57795_Desc = {
    Text = "Kalıntı Kapasitesi +1. Savaş başladıktan sonraki ilk beş turda, tur başında bir Kalıntı kazanırsın: \"Paslanmış Neşter\", \"Hemostatik Klemp\", \"Eski Yapboz\", \"Sürü Zihni\" ve \"Krono Sarkaç: İkizler\"."
  },
  RelicConfig_57795_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Batık Hazine\">"
  },
  RelicConfig_57795_StoryDesc = {
    Text = "Söylenene göre Lemurya bu sulara gömüldü. Batık hazinelerin sırlarını keşfetme cazibesine kim karşı koyabilir?"
  },
  RelicConfig_57796_BattleDesc = {
    Text = "Kalıntı Kapasitesi +1. Savaş başladıktan sonraki ilk beş tur boyunca, tur başında bir Kalıntı elde et; şunlar dâhil: \"Kronometrik Cihaz, Defne Yaprağı Kol Düğmeleri, İsimsiz Tanrının Peçesi, Kâbus Tezahürü, Krono Sarkaç: Denge\"."
  },
  RelicConfig_57796_Desc = {
    Text = "Kalıntı Kapasitesi +1. Savaş başladıktan sonraki ilk beş tur boyunca, tur başında bir Kalıntı elde et; şunlar dâhil: \"Kronometrik Cihaz, Defne Yaprağı Kol Düğmeleri, İsimsiz Tanrının Peçesi, Kâbus Tezahürü, Krono Sarkaç: Denge\"."
  },
  RelicConfig_57796_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Batık Hazine\">"
  },
  RelicConfig_57796_StoryDesc = {
    Text = "Söylenene göre Lemurya bu sulara gömüldü. Batık hazinelerin sırlarını keşfetme cazibesine kim karşı koyabilir?"
  },
  RelicConfig_57797_BattleDesc = {
    Text = "Kalıntı Kapasitesi +1. Savaş başladıktan sonraki ilk beş tur boyunca, tur başında bir Kalıntı elde et; şunlar dâhil: \"Yepyeni Cüzdan, Mythag Arması, Yıldız İksiri, Yedi Solungaçlı Öpücük, Krono Sarkaç: Göz\"."
  },
  RelicConfig_57797_Desc = {
    Text = "Kalıntı Kapasitesi +1. Savaş başladıktan sonraki ilk beş tur boyunca, tur başında bir Kalıntı elde et; şunlar dâhil: \"Yepyeni Cüzdan, Mythag Arması, Yıldız İksiri, Yedi Solungaçlı Öpücük, Krono Sarkaç: Göz\"."
  },
  RelicConfig_57797_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Batık Hazine\">"
  },
  RelicConfig_57797_StoryDesc = {
    Text = "Söylenene göre Lemurya bu sulara gömüldü. Batık hazinelerin sırlarını keşfetme cazibesine kim karşı koyabilir?"
  },
  RelicConfig_58872_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırını 1 artır ve tüm Uyananları Uyandır. Sonraki 5 tur boyunca, tur başında şu Kalıntılardan birini elde et: \"Paslı Lanset, Modern Dingil, Yuvamız, Uğursuz Kanca, Krono Sarkaç: Trans\"."
  },
  RelicConfig_58872_Desc = {
    Text = "Savaşın başında Arithmetica Sınırını 1 artır ve tüm Uyananları Uyandır. Sonraki 5 tur boyunca, tur başında şu Kalıntılardan birini elde et: \"Paslı Lanset, Modern Dingil, Yuvamız, Uğursuz Kanca, Krono Sarkaç: Trans\"."
  },
  RelicConfig_58872_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Hazine α\">"
  },
  RelicConfig_58873_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırını +1 artır ve tüm Uyananları Uyandır. Sonraki 5 tur boyunca, tur başında şu Kalıntılardan birini elde et: \"Bal Katkılı Mürekkep, Sessiz Gramofon, Yıldız İksiri, Düzenbaz Şapkası, Krono Sarkaç: Dalgalanma\"."
  },
  RelicConfig_58873_Desc = {
    Text = "Savaşın başında Arithmetica Sınırını +1 artır ve tüm Uyananları Uyandır. Sonraki 5 tur boyunca, tur başında şu Kalıntılardan birini elde et: \"Bal Katkılı Mürekkep, Sessiz Gramofon, Yıldız İksiri, Düzenbaz Şapkası, Krono Sarkaç: Dalgalanma\"."
  },
  RelicConfig_58873_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Hazine β\">"
  },
  RelicConfig_59118_BattleDesc = {
    Text = "Tur başında 1 \"Ryker'ın Şanslı Zarı\" elde et; zar atış sonucunu +1 artırır. Tur başında ve her zar atışından sonra, tüm Uyananlar %4 Kritik Hasar kazanır, en fazla %100'e kadar birikir."
  },
  RelicConfig_59118_Desc = {
    Text = "Tur başında 1 \"Ryker'ın Şanslı Zarı\" elde et; zar atış sonucunu +1 artırır. Tur başında ve her zar atışından sonra, tüm Uyananlar %4 Kritik Hasar kazanır, en fazla %100'e kadar birikir."
  },
  RelicConfig_59118_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Kaos Armağanı\">"
  },
  RelicConfig_59118_StoryDesc = {
    Text = "Kadim günahlar buraya kazınmış."
  },
  RelicConfig_59687_BattleDesc = {
    Text = "Simülasyon Savaşı Standart Kalıntı Seti (7 Parça)"
  },
  RelicConfig_59687_Desc = {
    Text = "Simülasyon Savaşı Standart Kalıntı Seti (7 Parça)"
  },
  RelicConfig_59687_Name = {
    Text = "<RedQuality:☆Simülasyon Kalıntısı☆>"
  },
  RelicConfig_59687_StoryDesc = {
    Text = "Bu tuhaf çağda, çiçekler İnsanlığın Işığı’nın başlıca seyircileridir.\nKıpırdama; sessiz sergileri tercih ederler."
  },
  RelicConfig_60723_BattleDesc = {
    Text = "Maksimum Arithmetica +1. Tur başında fazladan 1 kart çek ve 1 \"Uyum Senfonisi\" elde et. Aynı Arithmetica'ya sahip 3 Komut Kartı art arda oynanırsa, tüm Uyananlar 20 Aliemus kazanır. Tur başında ve tetiklendikten sonra sıfırlanır."
  },
  RelicConfig_60723_Desc = {
    Text = "Maksimum Arithmetica +1. Tur başında fazladan 1 kart çek ve 1 \"Uyum Senfonisi\" elde et. Aynı Arithmetica'ya sahip 3 Komut Kartı art arda oynanırsa, tüm Uyananlar 20 Aliemus kazanır. Tur başında ve tetiklendikten sonra sıfırlanır."
  },
  RelicConfig_60723_Name = {
    Text = "<OrangeQuality:Orkestra Şefi Batonu>"
  },
  RelicConfig_60723_StoryDesc = {
    Text = "İncecik bir Orkestra Şefi Batonu, yine de bir levye’den daha büyük bir güç barındırır.\n\n Notaları yönetir, ruhu yönetir, kaderi yönetir."
  },
  RelicConfig_60724_BattleDesc = {
    Text = "Savaşın başında, \"Savunmasız\" Yakarışı ve \"Patlama\" Yakarışı ile bunların Gelişmiş sürümlerini elde et ve bir Kart üzerine yerleştirmek için bir Yakarış seç."
  },
  RelicConfig_60724_Desc = {
    Text = "Savaşın başında, \"Savunmasız\" Yakarışı ve \"Patlama\" Yakarışı ile bunların Gelişmiş sürümlerini elde et ve bir Kart üzerine yerleştirmek için bir Yakarış seç."
  },
  RelicConfig_60724_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Müdürün Mesajı\">"
  },
  RelicConfig_60724_StoryDesc = {
    Text = "Mythag'ın kurucusunun sözleri kulaklarınızda yankılanıyor.\n\nGümüş Anahtar yolunu aydınlatsın, Mythag'ın Koruyucusu."
  },
  RelicConfig_60725_BattleDesc = {
    Text = "Savaşın başında, \"Aliemus\" Yakarışı ve \"Katalizör\" Yakarışı ile bunların Gelişmiş Yakarışlarını elde et ve bir kart için bir Yakarış seç."
  },
  RelicConfig_60725_Desc = {
    Text = "Savaşın başında, \"Aliemus\" Yakarışı ve \"Katalizör\" Yakarışı ile bunların Gelişmiş Yakarışlarını elde et ve bir kart için bir Yakarış seç."
  },
  RelicConfig_60725_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Müdürün Mesajı\">"
  },
  RelicConfig_60725_StoryDesc = {
    Text = "Mythag'ın kurucusunun sözleri kulaklarınızda yankılanıyor.\n\nGümüş Anahtar yolunu aydınlatsın, Mythag'ın Koruyucusu."
  },
  RelicConfig_60726_BattleDesc = {
    Text = "Savaşın başında, \"Zayıflık\" Yakarışı ve \"Hesaplama\" Yakarışı ile bunların Gelişmiş Yakarışlarını elde et ve bir kart için bir Yakarış seç."
  },
  RelicConfig_60726_Desc = {
    Text = "Savaşın başında, \"Zayıflık\" Yakarışı ve \"Hesaplama\" Yakarışı ile bunların Gelişmiş Yakarışlarını elde et ve bir kart için bir Yakarış seç."
  },
  RelicConfig_60726_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Müdürün Mesajı\">"
  },
  RelicConfig_60726_StoryDesc = {
    Text = "Mythag'ın kurucusunun sözleri kulaklarınızda yankılanıyor.\n\nGümüş Anahtar yolunu aydınlatsın, Mythag'ın Koruyucusu."
  },
  RelicConfig_60727_BattleDesc = {
    Text = "Savaşın başında, \"Burç\" Yakarışı ve \"Ustalık\" Yakarışı ile bunların Gelişmiş Yakarışlarını elde et, bir Kart üzerinde bir Yakarış seç."
  },
  RelicConfig_60727_Desc = {
    Text = "Savaşın başında, \"Burç\" Yakarışı ve \"Ustalık\" Yakarışı ile bunların Gelişmiş Yakarışlarını elde et, bir Kart üzerinde bir Yakarış seç."
  },
  RelicConfig_60727_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Müdürün Mesajı\">"
  },
  RelicConfig_60727_StoryDesc = {
    Text = "Mythag'ın kurucusunun sözleri kulaklarınızda yankılanıyor.\n\nGümüş Anahtar yolunu aydınlatsın, Mythag'ın Koruyucusu."
  },
  RelicConfig_60728_BattleDesc = {
    Text = "Savaşın başında, \"Doğuş\" Yakarışı ve \"Yankı\" Yakarışı ile bunların Gelişmiş Yakarışlarını elde et ve bir kart üzerinde bir Yakarış seç."
  },
  RelicConfig_60728_Desc = {
    Text = "Savaşın başında, \"Doğuş\" Yakarışı ve \"Yankı\" Yakarışı ile bunların Gelişmiş Yakarışlarını elde et ve bir kart üzerinde bir Yakarış seç."
  },
  RelicConfig_60728_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Müdürün Mesajı\">"
  },
  RelicConfig_60728_StoryDesc = {
    Text = "Mythag'ın kurucusunun sözleri kulaklarınızda yankılanıyor.\n\nGümüş Anahtar yolunu aydınlatsın, Mythag'ın Koruyucusu."
  },
  RelicConfig_60729_BattleDesc = {
    Text = "Savaşın başında, \"Ustalık\" Yakarışı ve \"Kavrayış\" Yakarışı ile bunların Gelişmiş Yakarışlarını elde et ve bir kart üzerine yerleştirmek için bir Yakarış seç."
  },
  RelicConfig_60729_Desc = {
    Text = "Savaşın başında, \"Ustalık\" Yakarışı ve \"Kavrayış\" Yakarışı ile bunların Gelişmiş Yakarışlarını elde et ve bir kart üzerine yerleştirmek için bir Yakarış seç."
  },
  RelicConfig_60729_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Müdürün Mesajı\">"
  },
  RelicConfig_60729_StoryDesc = {
    Text = "Mythag'ın kurucusunun sözleri kulaklarınızda yankılanıyor.\n\nGümüş Anahtar yolunu aydınlatsın, Mythag'ın Koruyucusu."
  },
  RelicConfig_60730_BattleDesc = {
    Text = "Savaşın başında, \"Kaba Güç\" Yakarışı ve \"Tükenme\" Yakarışı ile bunların Gelişmiş Yakarışlarını elde et. Bir kart üzerinde bir Yakarış seç."
  },
  RelicConfig_60730_Desc = {
    Text = "Savaşın başında, \"Kaba Güç\" Yakarışı ve \"Tükenme\" Yakarışı ile bunların Gelişmiş Yakarışlarını elde et. Bir kart üzerinde bir Yakarış seç."
  },
  RelicConfig_60730_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Müdürün Mesajı\">"
  },
  RelicConfig_60730_StoryDesc = {
    Text = "Mythag'ın kurucusunun sözleri kulaklarınızda yankılanıyor.\n\nGümüş Anahtar yolunu aydınlatsın, Mythag'ın Koruyucusu."
  },
  RelicConfig_60731_BattleDesc = {
    Text = "Savaşın başında 2 \"Topluluk\" Yakarışı ve bunların Gelişmiş Yakarışını elde et, ardından bir kart için bir Yakarış seç."
  },
  RelicConfig_60731_Desc = {
    Text = "Savaşın başında 2 \"Topluluk\" Yakarışı ve bunların Gelişmiş Yakarışını elde et, ardından bir kart için bir Yakarış seç."
  },
  RelicConfig_60731_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Müdürün Mesajı\">"
  },
  RelicConfig_60731_StoryDesc = {
    Text = "Mythag'ın kurucusunun sözleri kulaklarınızda yankılanıyor.\n\nGümüş Anahtar yolunu aydınlatsın, Mythag'ın Koruyucusu."
  },
  RelicConfig_60732_BattleDesc = {
    Text = "Savaşın başında, \"Hesaplama\" Yakarışı ve \"Yansıma\" Yakarışı ile bunların Gelişmiş Yakarışlarını elde et ve bir kart üzerinde bir Yakarış seç."
  },
  RelicConfig_60732_Desc = {
    Text = "Savaşın başında, \"Hesaplama\" Yakarışı ve \"Yansıma\" Yakarışı ile bunların Gelişmiş Yakarışlarını elde et ve bir kart üzerinde bir Yakarış seç."
  },
  RelicConfig_60732_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Müdürün Mesajı\">"
  },
  RelicConfig_60732_StoryDesc = {
    Text = "Mythag'ın kurucusunun sözleri kulaklarınızda yankılanıyor.\n\nGümüş Anahtar yolunu aydınlatsın, Mythag'ın Koruyucusu."
  },
  RelicConfig_65376_BattleDesc = {
    Text = "[Arg1] Keşif Ekibi üyesiyle başla. Savaşın başında desteye 5 adet <DerivativeCardKeywords_73:Şüphe> karıştır."
  },
  RelicConfig_65376_Desc = {
    Text = "[Arg1] Keşif Ekibi üyesiyle başla. Savaş başlangıcında, desteye 5 <DerivativeCardKeywords_73:Şüphe> karıştır."
  },
  RelicConfig_65376_Name = {
    Text = "<OrangeQuality:Keşif Ekibi>"
  },
  RelicConfig_65376_StoryDesc = {
    Text = "Mythag'ın kurucusunun sözleri kulaklarınızda yankılanıyor.\n\nGümüş Anahtar yolunu aydınlatsın, Mythag'ın Koruyucusu."
  },
  RelicConfig_65406_BattleDesc = {
    Text = "Tur başlangıcında [Arg1] <DerivativeCardKeywords_71:İnsanlığın Işıltısı> kazan.\n<D05EX_Relic:Tüm çabaların buna değdi; araştırma ekibinin neredeyse tamamını kurtardın ve hayatta kalanlar sana içtenlikle minnettarlar.>"
  },
  RelicConfig_65406_Desc = {
    Text = "Tur başlangıcında [Arg1] <DerivativeCardKeywords_71:İnsanlığın Işıltısı> kazan.\n<D05EX_Relic:Tüm çabaların buna değdi; araştırma ekibinin neredeyse tamamını kurtardın ve hayatta kalanlar sana içtenlikle minnettarlar.>"
  },
  RelicConfig_65406_Name = {
    Text = "<OrangeQuality:Kurtarma Madalyası: Platin>"
  },
  RelicConfig_65406_StoryDesc = {
    Text = "Çabaların buna değdi; neredeyse tüm Keşif Ekibi’ni kurtardın. Hayatta kalanlar sana derin bir minnet duyuyor."
  },
  RelicConfig_65407_BattleDesc = {
    Text = "Tur başlangıcında [Arg1] <DerivativeCardKeywords_72:\"İnsanlığın Parıltısı\"> kazan.\n<D05EX_Relic:İnanılmaz bir mucize yarattın; felaketten sonra herkes hayatta kaldı ve sen büyük bir kahraman olarak selamlandın. Efsanen yakında tüm karlı dağda yayılacak.>"
  },
  RelicConfig_65407_Desc = {
    Text = "Tur başlangıcında [Arg1] <DerivativeCardKeywords_72:\"İnsanlığın Parıltısı\"> kazan.\n<D05EX_Relic:İnanılmaz bir mucize yarattın; felaketten sonra herkes hayatta kaldı ve sen büyük bir kahraman olarak selamlandın. Efsanen yakında tüm karlı dağda yayılacak.>"
  },
  RelicConfig_65407_Name = {
    Text = "<OrangeQuality:Kurtarma Madalyası: Elmas>"
  },
  RelicConfig_65407_StoryDesc = {
    Text = "İnanılmaz bir mucize gerçekleştirdin; felaketten herkes sağ çıktı. Sen büyük bir kahramansın ve efsanen yakında karlı dağın eteklerine yayılabilir."
  },
  RelicConfig_65408_BattleDesc = {
    Text = "Tur başlangıcında [Arg1] <DerivativeCardKeywords_68:\"İnsanlığın Işıltısı\"> kazan. \n<D05EX_Relic:Karlı dağdan kaçmak için verimliliği ön plana koyan bir strateji seçtin ve insanların birer birer ölüşünü izledin. Hayatta kalanların sana bakışlarında minnetten çok korku vardı.>"
  },
  RelicConfig_65408_Desc = {
    Text = "Tur başlangıcında [Arg1] <DerivativeCardKeywords_68:\"İnsanlığın Işıltısı\"> kazan. \n<D05EX_Relic:Karlı dağdan kaçmak için verimliliği ön plana koyan bir strateji seçtin ve insanların birer birer ölüşünü izledin. Hayatta kalanların sana bakışlarında minnetten çok korku vardı.>"
  },
  RelicConfig_65408_Name = {
    Text = "<OrangeQuality:Kurtarma Madalyası: Bronz>"
  },
  RelicConfig_65408_StoryDesc = {
    Text = "Karlı Dağ’dan ayrılmak için verimliliği önceleyen bir strateji benimsedin, insanların birer birer düşüşünü izledin. Hayatta kalanlar sana minnetten çok korkuyla baktı."
  },
  RelicConfig_65409_BattleDesc = {
    Text = "Tur başlangıcında [Arg1] <DerivativeCardKeywords_69:\"İnsanlığın Titrek Işığı\"> kazan.\n<D05EX_Relic:Belki de elinden gelenin en iyisini yaptın. İnsanların yarısı hayatını kaybetmiş olsa da en azından diğer yarısını kurtardın. Sonuçta fedakârlık kaçınılmazdı.>"
  },
  RelicConfig_65409_Desc = {
    Text = "Tur başlangıcında [Arg1] <DerivativeCardKeywords_69:\"İnsanlığın Titrek Işığı\"> kazan.\n<D05EX_Relic:Belki de elinden gelenin en iyisini yaptın. İnsanların yarısı hayatını kaybetmiş olsa da en azından diğer yarısını kurtardın. Sonuçta fedakârlık kaçınılmazdı.>"
  },
  RelicConfig_65409_Name = {
    Text = "<OrangeQuality:Kurtarma Madalyası: Gümüş>"
  },
  RelicConfig_65409_StoryDesc = {
    Text = "Elinden gelenin en iyisini yaptın. Yarısı yok olmuş olsa da, diğer yarısını kurtarmayı başardın. Ne de olsa kurbanlar kaçınılmazdır."
  },
  RelicConfig_65410_BattleDesc = {
    Text = "Tur başlangıcında [Arg1] <DerivativeCardKeywords_70:\"İnsanlığın Işığı\"> kazan.\n<D05EX_Relic:İnsanların çoğunu kurtardın, trajik kaderlerini yeniden yazdın. Elinden gelenin en iyisini yaptın, değil mi?>"
  },
  RelicConfig_65410_Desc = {
    Text = "Tur başlangıcında [Arg1] <DerivativeCardKeywords_70:\"İnsanlığın Işığı\"> kazan.\n<D05EX_Relic:İnsanların çoğunu kurtardın, trajik kaderlerini yeniden yazdın. Elinden gelenin en iyisini yaptın, değil mi?>"
  },
  RelicConfig_65410_Name = {
    Text = "<OrangeQuality:Kurtarma Madalyası: Altın>"
  },
  RelicConfig_65410_StoryDesc = {
    Text = "İnsanların çoğunu kurtardın ve trajik kaderlerini yeniden yazdın. Elinden geleni yaptın, değil mi?"
  },
  RelicConfig_65456_BattleDesc = {
    Text = "Savaş başlangıcında, 3 rastgele \"Semptom\" karıştır. \"Semptom\" oynadığında [Arg1] GÜÇ kazan.\n<D05EX_Relic:Yardımınla Keşif Ekibinden kimse hayatta kalamadı ve sen soğukkanlılıkla kendine en büyük faydayı sağladın. Ama gerçekten buna değdi mi?>"
  },
  RelicConfig_65456_Desc = {
    Text = "Savaş başlangıcında, 3 rastgele \"Semptom\" karıştır. \"Semptom\" oynadığında [Arg1] GÜÇ kazan.\n<D05EX_Relic:Yardımınla Keşif Ekibinden kimse hayatta kalamadı ve sen soğukkanlılıkla kendine en büyük faydayı sağladın. Ama gerçekten buna değdi mi?>"
  },
  RelicConfig_65456_Name = {
    Text = "<OrangeQuality:Yalnız Kurt Nişanı>"
  },
  RelicConfig_65456_StoryDesc = {
    Text = "Senin yardımınla Keşif Ekibi’nden hiç kimse hayatta kalmadı. Kendin için en büyük faydayı sağladın, ama buna gerçekten değdi mi?"
  },
  RelicConfig_65569_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırını 1 artır ve tüm Uyananları Uyandır. Sonraki 5 tur boyunca, tur başında şu Kalıntılardan birini elde et: \"Sinyal Aktarıcı, Bahar Ayini, Hierofant Asası, Kehanet Ritüel Kuşu, Krono Sarkaç: Yansıtma\"."
  },
  RelicConfig_65569_Desc = {
    Text = "Savaşın başında Arithmetica Sınırını 1 artır ve tüm Uyananları Uyandır. Sonraki 5 tur boyunca, tur başında şu Kalıntılardan birini elde et: \"Sinyal Aktarıcı, Bahar Ayini, Hierofant Asası, Kehanet Ritüel Kuşu, Krono Sarkaç: Yansıtma\"."
  },
  RelicConfig_65569_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Hazine δ\">"
  },
  RelicConfig_65570_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırını +1 artır ve tüm Uyananları Uyandır. Sonraki 5 tur boyunca, tur başında şu Kalıntılardan birini elde et: \"Mythag Arması, Doktor Çantası, Prototip Batarya, Bilinç Kazıması, Krono Sarkaç: Evrim\"."
  },
  RelicConfig_65570_Desc = {
    Text = "Savaşın başında Arithmetica Sınırını +1 artır ve tüm Uyananları Uyandır. Sonraki 5 tur boyunca, tur başında şu Kalıntılardan birini elde et: \"Mythag Arması, Doktor Çantası, Prototip Batarya, Bilinç Kazıması, Krono Sarkaç: Evrim\"."
  },
  RelicConfig_65570_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Hazine γ\">"
  },
  RelicConfig_66515_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırını 1 artır ve tüm Uyananları Uyandır. Sonraki 5 tur boyunca, tur başında şu Kalıntılardan birini elde et: \"Putney Sabah Postası, Estetik İlkeleri, Linç Ezgisi, Kırık Çehre, Krono Sarkaç: Karşılıklı\"."
  },
  RelicConfig_66515_Desc = {
    Text = "Savaşın başında Arithmetica Sınırını 1 artır ve tüm Uyananları Uyandır. Sonraki 5 tur boyunca, tur başında şu Kalıntılardan birini elde et: \"Putney Sabah Postası, Estetik İlkeleri, Linç Ezgisi, Kırık Çehre, Krono Sarkaç: Karşılıklı\"."
  },
  RelicConfig_66515_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Hazine ε\">"
  },
  RelicConfig_66518_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_66518_Desc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_66518_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Dilek β\">"
  },
  RelicConfig_66519_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_66519_Desc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_66519_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Dilek α\">"
  },
  RelicConfig_67690_BattleDesc = {
    Text = "Tur başında, tüm Uyananlar 25 Aliemus kazanır. Alındığında, Maksimum HP 1,5 katına çıkar."
  },
  RelicConfig_67690_Desc = {
    Text = "Tur başında, tüm Uyananlar 25 Aliemus kazanır. Alındığında, Maksimum HP 1,5 katına çıkar."
  },
  RelicConfig_67690_Name = {
    Text = "<OrangeQuality:Kutsanmış· Kabus Tezahürü β>"
  },
  RelicConfig_67690_StoryDesc = {
    Text = "Korkma, tereddüt etme. Bu yalnızca bir anlık güzel düş; Yaratıcı Tanrı’nın ışığı hâlâ üzerine vuruyor."
  },
  RelicConfig_67788_BattleDesc = {
    Text = "Alındığında, 3 Arithmetica kazan."
  },
  RelicConfig_67788_Desc = {
    Text = "Alındığında, 3 Arithmetica kazan."
  },
  RelicConfig_67788_Name = {
    Text = "<WhiteQuality:Cep Saati Aynası>"
  },
  RelicConfig_67788_StoryDesc = {
    Text = "Geçmişte katılaşmış, siyah derinliklerin dibine gömülmüş anılar."
  },
  RelicConfig_67789_BattleDesc = {
    Text = "Alındığında, ele 1 adet <DerivativeCardKeywords_1:\"Kayıp Gölgelerin Yankısı\"> yerleştir."
  },
  RelicConfig_67789_Desc = {
    Text = "Alındığında, ele 1 adet <DerivativeCardKeywords_1:\"Kayıp Gölgelerin Yankısı\"> yerleştir."
  },
  RelicConfig_67789_Name = {
    Text = "<WhiteQuality:Sinyal Aktarıcı>"
  },
  RelicConfig_67789_StoryDesc = {
    Text = "Çalacağı anı özle ya da ondan dehşet duy."
  },
  RelicConfig_67790_BattleDesc = {
    Text = "Tüm “Darbe” Krit. Hasar %20 artar. Alındığında, eline 1 adet <DerivativeCardKeywords_40:\"Geçici Güzellik\"> ekle."
  },
  RelicConfig_67790_Desc = {
    Text = "Tüm “Darbe” Krit. Hasar %20 artar. Alındığında, eline 1 adet <DerivativeCardKeywords_40:\"Geçici Güzellik\"> ekle."
  },
  RelicConfig_67790_Name = {
    Text = "<WhiteQuality:Geçici Güzellik>"
  },
  RelicConfig_67790_StoryDesc = {
    Text = "Gelip geçen anların güzelliğini sonsuza dek muhafaza et."
  },
  RelicConfig_67791_BattleDesc = {
    Text = "Alındığında, tüm düşmanlara 1 tur boyunca <WeaknessIconKeywords:Zayıflık> ve <VulnerabilityIconKeywords:Savunmasız> uygula."
  },
  RelicConfig_67791_Desc = {
    Text = "Alındığında, tüm düşmanlara 1 tur boyunca <WeaknessIconKeywords:Zayıflık> ve <VulnerabilityIconKeywords:Savunmasız> uygula."
  },
  RelicConfig_67791_Name = {
    Text = "<WhiteQuality:Renk Değiştiren Deli Gömleği>"
  },
  RelicConfig_67791_StoryDesc = {
    Text = "Yalnızca zaman değil, dehşet ve Pain de kumaşı soldurabilir."
  },
  RelicConfig_67793_BattleDesc = {
    Text = "Savaş başında, tüm Uyanışçılar 50 Aliemus kazanır. Ele 2 kopya <DerivativeCardKeywords_1:\"Kayıp Gölgelerin Yankısı\"> koy."
  },
  RelicConfig_67793_Desc = {
    Text = "Alındığında, tüm Uyanışçılar 50 Aliemus kazanır ve ele 2 adet <DerivativeCardKeywords_1:\"Kayıp Gölgelerin Yankısı\"> yerleştir."
  },
  RelicConfig_67793_Name = {
    Text = "<OrangeQuality:Sinyal Aktarıcı +β>"
  },
  RelicConfig_67793_StoryDesc = {
    Text = "Çalacağı anı özle ya da ondan dehşet duy."
  },
  RelicConfig_67794_BattleDesc = {
    Text = "El sınırını 5 artır ve savaş başında eli sınırına kadar yenile. Tur başında ek 1 kart çek ve tur sonunda tüm Semptom kartlarını ve Durum Kartlarını atarken diğer kartları sakla."
  },
  RelicConfig_67794_Desc = {
    Text = "El sınırını 5 artır ve savaş başında eli sınırına kadar yenile. Tur başında ek 1 kart çek ve tur sonunda tüm Semptom kartlarını ve Durum Kartlarını atarken diğer kartları sakla."
  },
  RelicConfig_67794_Name = {
    Text = "<OrangeQuality:Kutsanmış· Bilinç Kazıması β>"
  },
  RelicConfig_67794_StoryDesc = {
    Text = "Açgözlüler, hatalarını kalplerine oyar ve kendilerini geçmişlerinin kefaretine adarlar."
  },
  RelicConfig_67818_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_67818_Desc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_67818_Name = {
    Text = "<OrangeQuality:\"Tüm Diyarların Kapısı ε\">"
  },
  RelicConfig_67819_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_67819_Desc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_67819_Name = {
    Text = "<OrangeQuality:\"Tüm Diyarların Kapısı ζ\">"
  },
  RelicConfig_67820_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_67820_Desc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_67820_Name = {
    Text = "<OrangeQuality:\"Tüm Diyarların Kapısı θ\">"
  },
  RelicConfig_67821_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_67821_Desc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_67821_Name = {
    Text = "<OrangeQuality:\"Tüm Diyarların Kapısı γ\">"
  },
  RelicConfig_67822_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_67822_Desc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_67822_Name = {
    Text = "<OrangeQuality:\"Tüm Diyarların Kapısı α\">"
  },
  RelicConfig_67823_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_67823_Desc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_67823_Name = {
    Text = "<OrangeQuality:\"Tüm Diyarların Kapısıη\">"
  },
  RelicConfig_67824_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_67824_Desc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_67824_Name = {
    Text = "<OrangeQuality:\"Tüm Diyarların Kapısıδ\">"
  },
  RelicConfig_67825_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_67825_Desc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_67825_Name = {
    Text = "<OrangeQuality:\"Tüm Diyarların Kapısı β\">"
  },
  RelicConfig_67826_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_67826_Desc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_67826_Name = {
    Text = "<OrangeQuality:\"Tüm Diyarların Kapısı ι\">"
  },
  RelicConfig_68651_BattleDesc = {
    Text = "Savaşın başında tüm Uyananları Uyandır, ele <DerivativeCardKeywords_84:\"Alacakaranlık: Tamamlanmamış Balmumu Heykel\"> yerleştir, Çekme Desteğindeki tüm kartları kopyala. Her tur fazladan 5 kart çek ve 5 Arithmetica kazan. “Saldırı” veya “Savunma” oynadıktan sonra [Arg1] Kalkan kazan."
  },
  RelicConfig_68651_Desc = {
    Text = "Savaşın başında tüm Uyananları Uyandır, ele <DerivativeCardKeywords_84:\"Alacakaranlık: Tamamlanmamış Balmumu Heykel\"> yerleştir, Çekme Desteğindeki tüm kartları kopyala. Her tur fazladan 5 kart çek ve 5 Arithmetica kazan. “Saldırı” veya “Savunma” oynadıktan sonra [Arg1] Kalkan kazan."
  },
  RelicConfig_68651_Name = {
    Text = "<OrangeQuality:\"Saf Gümüş Çekirdek: Korku\">"
  },
  RelicConfig_68652_BattleDesc = {
    Text = "Savaş başında, tüm Uyananları Uyandır, <DerivativeCardKeywords_85:\"Alacakaranlık: Mutasyona Uğramış Kalp\"> kartını ele yerleştir. Tur başında, eldeki istediğin sayıda kartı atmayı ve aynı sayıda kart çekmeyi seçebilirsin. Tek sayılı turlarda [Arg1] Geçici GÜÇ kazan ve <DerivativeCardKeywords_97:Tükenmez Savaş İradesi β> kartını ele yerleştir. Çift sayılı turlarda [Arg2] Geçici Alarm kazan ve <DerivativeCardKeywords_98:Gizlenmeβ> kartını ele yerleştir."
  },
  RelicConfig_68652_Desc = {
    Text = "Savaş başında, tüm Uyananları Uyandır, <DerivativeCardKeywords_85:\"Alacakaranlık: Mutasyona Uğramış Kalp\"> kartını ele yerleştir. Tur başında, eldeki istediğin sayıda kartı atmayı ve aynı sayıda kart çekmeyi seçebilirsin. Tek sayılı turlarda [Arg1] Geçici GÜÇ kazan ve <DerivativeCardKeywords_97:Tükenmez Savaş İradesi β> kartını ele yerleştir. Çift sayılı turlarda [Arg2] Geçici Alarm kazan ve <DerivativeCardKeywords_98:Gizlenmeβ> kartını ele yerleştir."
  },
  RelicConfig_68652_Name = {
    Text = "<OrangeQuality:\"Saf Gümüş Çekirdek: Kemik Delici\">"
  },
  RelicConfig_68653_BattleDesc = {
    Text = "Savaşın başında tüm Uyananları Uyandır, ele <DerivativeCardKeywords_83:\"Alacakaranlık: Masum Karşılık Hediyesi\"> yerleştir. Tüm Uyananlar tur başına fazladan 1 Yücelt salabilir; Yücelt saldıktan sonra düşmanın [Arg2] GÜÇ’ünü azalt. Tur başında tüm Uyananlar [Arg1] Aliemus kazanır."
  },
  RelicConfig_68653_Desc = {
    Text = "Savaşın başında tüm Uyananları Uyandır, ele <DerivativeCardKeywords_83:\"Alacakaranlık: Masum Karşılık Hediyesi\"> yerleştir. Tüm Uyananlar tur başına fazladan 1 Yücelt salabilir; Yücelt saldıktan sonra düşmanın [Arg2] GÜÇ’ünü azalt. Tur başında tüm Uyananlar [Arg1] Aliemus kazanır."
  },
  RelicConfig_68653_Name = {
    Text = "<OrangeQuality:\"Saf Gümüş Çekirdek: Ağıt\">"
  },
  RelicConfig_68654_BattleDesc = {
    Text = "Savaşın başında tüm Uyananları Uyandır, ele <DerivativeCardKeywords_88:\"Alacakaranlık: Ütopya Perdesi\"> yerleştir, ekibin el sınırını +2 artır ve Keyflare depolama sınırını %100 yükselt. Çete serbest bırakıldıktan sonra, tüm Uyananların Krit. Hasarı ve Geçici Kritik Oranı +[Arg1]%, Maksimum Canlarının %20’sine eşit bir Kalkan kazanırlar ve el sınırına ulaşılana dek kart çekilir."
  },
  RelicConfig_68654_Desc = {
    Text = "Savaşın başında tüm Uyananları Uyandır, ele <DerivativeCardKeywords_88:\"Alacakaranlık: Ütopya Perdesi\"> yerleştir, ekibin el sınırını +2 artır ve Keyflare depolama sınırını %100 yükselt. Çete serbest bırakıldıktan sonra, tüm Uyananların Krit. Hasarı ve Geçici Kritik Oranı +[Arg1]%, Maksimum Canlarının %20’sine eşit bir Kalkan kazanırlar ve el sınırına ulaşılana dek kart çekilir."
  },
  RelicConfig_68654_Name = {
    Text = "<OrangeQuality:\"Saf Gümüş Çekirdek: Delilik\">"
  },
  RelicConfig_68655_BattleDesc = {
    Text = "Savaşın başında tüm Uyananları Uyandır, ele <DerivativeCardKeywords_89:\"Alacakaranlık: Bereket Tohumu\"> yerleştir. Tur sonunda kalan Arithmetica’yı koru ve artık kart atma. Verilen her Aktif Hasar örneği için [Arg1] Geçici GÜÇ ve [Arg2] Kalkan kazan."
  },
  RelicConfig_68655_Desc = {
    Text = "Savaşın başında tüm Uyananları Uyandır, ele <DerivativeCardKeywords_89:\"Alacakaranlık: Bereket Tohumu\"> yerleştir. Tur sonunda kalan Arithmetica’yı koru ve artık kart atma. Verilen her Aktif Hasar örneği için [Arg1] Geçici GÜÇ ve [Arg2] Kalkan kazan."
  },
  RelicConfig_68655_Name = {
    Text = "<OrangeQuality:\"Saf Gümüş Çekirdek: Doğuş\">"
  },
  RelicConfig_68656_BattleDesc = {
    Text = "Savaşın başında tüm Uyanışçıları Tahrik et, <DerivativeCardKeywords_86:\"Alacakaranlık: Ballı Şarap\"> kartını ele al ve tüm Uyanışçıların Krit. Hasarını 1,5 katına çıkar. Tur sonunda, Yüceltim salmamış Uyanışçılar [Arg1] Aliemus kazanır. Oynanan kart sayısı [Arg2]'den azsa, bir sonraki turda 2 kart çek ve 2 Arithmetica kazan."
  },
  RelicConfig_68656_Desc = {
    Text = "Savaşın başında tüm Uyanışçıları Tahrik et, <DerivativeCardKeywords_86:\"Alacakaranlık: Ballı Şarap\"> kartını ele al ve tüm Uyanışçıların Krit. Hasarını 1,5 katına çıkar. Tur sonunda, Yüceltim salmamış Uyanışçılar [Arg1] Aliemus kazanır. Oynanan kart sayısı [Arg2]'den azsa, bir sonraki turda 2 kart çek ve 2 Arithmetica kazan."
  },
  RelicConfig_68656_Name = {
    Text = "<OrangeQuality:\"Saf Gümüş Çekirdek: Hile\">"
  },
  RelicConfig_68657_BattleDesc = {
    Text = "Savaş başında, tüm Uyandırıcıları Uyanış'a geçir, ele <DerivativeCardKeywords_87:\"Alacakaranlık: Elçinin Hükmü\"> yerleştir ve takımın Hasar Güçlendirmesini iki katına çıkar. Senin uyguladığın Semptom: Zayıflık etkisi %25'ten %50'ye yükselir. Her tur sonunda, Maksimum canın [Arg1]%'sine eşit Kalkan kazan ve tüm düşmanlara [Arg2] x Kalkan'a eşit <FixedDamage:Saf Hasar> ver."
  },
  RelicConfig_68657_Desc = {
    Text = "Savaş başında, tüm Uyandırıcıları Uyanış'a geçir, ele <DerivativeCardKeywords_87:\"Alacakaranlık: Elçinin Hükmü\"> yerleştir ve takımın Hasar Güçlendirmesini iki katına çıkar. Senin uyguladığın Semptom: Zayıflık etkisi %25'ten %50'ye yükselir. Her tur sonunda, Maksimum canın [Arg1]%'sine eşit Kalkan kazan ve tüm düşmanlara [Arg2] x Kalkan'a eşit <FixedDamage:Saf Hasar> ver."
  },
  RelicConfig_68657_Name = {
    Text = "<OrangeQuality:\"Saf Gümüş Çekirdek: Sapkınlık\">"
  },
  RelicConfig_68886_BattleDesc = {
    Text = "Tawil’in Hasarı, İyileştirmesi ve Kalkanı %50 güçlenir. Savaşın başında Tawil 120 Aliemus kazanır."
  },
  RelicConfig_68886_Desc = {
    Text = "Tawil’in Hasarı, Kalkanı ve HP Yenilenmesi %50 artar. Savaşın başında Tawil 120 Aliemus kazanır."
  },
  RelicConfig_68886_Name = {
    Text = "<OrangeQuality:Her Şeyi Bilen Göz>"
  },
  RelicConfig_68886_StoryDesc = {
    Text = "Geçitten dışarı adım atarak, Yalnızca Doğru Olan Yola ayak basar."
  },
  RelicConfig_69319_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_69319_Desc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_69319_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Dilek ε\">"
  },
  RelicConfig_69320_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_69320_Desc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_69320_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Dilek γ\">"
  },
  RelicConfig_69321_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_69321_Desc = {
    Text = "Savaşın başında Arithmetica Sınırı +1, tüm Uyananları Uyandır. Tur başında rastgele bir \"Kalıntı\" veya \"Destek\" Keşfet; en fazla 5 kez."
  },
  RelicConfig_69321_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Dilek δ\">"
  },
  RelicConfig_70042_BattleDesc = {
    Text = "Tur başında 1 \"Uçurum Enerjisi\" biriktir ve \"Hafif Uyku\" veya \"Uyandır\" seç. Hafif Uyku: fazladan 1 \"Uçurum Enerjisi\" biriktir. Uyandır: Tulu’nun yardımını almak için 1/5/10 \"Uçurum Enerjisi\" tüket. Ne kadar çok \"Uçurum Enerjisi\" tüketilirse, Tulu’nun yardımının etkisi o kadar güçlenir."
  },
  RelicConfig_70042_Desc = {
    Text = "Tur başında 1 \"Uçurum Enerjisi\" biriktir ve \"Hafif Uyku\" veya \"Uyandır\" seç. Hafif Uyku: fazladan 1 \"Uçurum Enerjisi\" biriktir. Uyandır: Tulu’nun yardımını almak için 1/5/10 \"Uçurum Enerjisi\" tüket. Ne kadar çok \"Uçurum Enerjisi\" tüketilirse, Tulu’nun yardımının etkisi o kadar güçlenir."
  },
  RelicConfig_70042_Name = {
    Text = "<OrangeQuality:Tanrı Kralın Kudreti>"
  },
  RelicConfig_70084_BattleDesc = {
    Text = "Savaşın başında tüm Uyananların \"Uyandır\" kartlarını Çekme Desteğine karıştır."
  },
  RelicConfig_70084_Desc = {
    Text = "Savaşın başında tüm Uyananların \"Uyandır\" kartlarını Çekme Desteğine karıştır."
  },
  RelicConfig_70084_Name = {
    Text = "<OrangeQuality:Uyandır>"
  },
  RelicConfig_70700_BattleDesc = {
    Text = "Tüm Uyananların Temel Hasarı [Arg1]% artar."
  },
  RelicConfig_70700_Desc = {
    Text = "Tüm Uyananların Temel Hasarı [Arg1]% artar."
  },
  RelicConfig_70700_Name = {
    Text = "<WhiteQuality:Ağlayan Pipo>"
  },
  RelicConfig_70700_StoryDesc = {
    Text = "Bu, nefretin ürünü mü, yoksa intikamın sonucu mu?"
  },
  RelicConfig_70701_BattleDesc = {
    Text = "Tur başında, tüm Uyananlar [Arg1] Aliemus kazanır."
  },
  RelicConfig_70701_Desc = {
    Text = "Tur başında, tüm Uyananlar [Arg1] Aliemus kazanır."
  },
  RelicConfig_70701_Name = {
    Text = "<WhiteQuality:Prototip Batarya>"
  },
  RelicConfig_70701_StoryDesc = {
    Text = "Taşınabilir Umut"
  },
  RelicConfig_70702_BattleDesc = {
    Text = "\"Exalt\" serbest bırakıldıktan sonra, [Arg1] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_70702_Desc = {
    Text = "\"Exalt\" serbest bırakıldıktan sonra, [Arg1] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_70702_Name = {
    Text = "<OrangeQuality:Demir Kilit+>"
  },
  RelicConfig_70702_StoryDesc = {
    Text = "Kalın ve sağlam bir kilit, anahtar olmadan açılması güç.\nElbette, usta bir hırsız için bunun hiçbir önemi yok."
  },
  RelicConfig_70703_BattleDesc = {
    Text = "\"Darbe\", Uyandıran’ın SLD’sinin [Arg1]%’üne eşit ek bir Hasar örneği daha verir ve tur başına en fazla 3 kez tetiklenebilir."
  },
  RelicConfig_70703_Desc = {
    Text = "\"Darbe\", Uyandıran’ın SLD’sinin [Arg1]%’üne eşit ek bir Hasar örneği daha verir ve tur başına en fazla 3 kez tetiklenebilir."
  },
  RelicConfig_70703_Name = {
    Text = "<WhiteQuality:Paslanmış Neşter>"
  },
  RelicConfig_70703_StoryDesc = {
    Text = "Canlı dokuyu kesmeye uygun değil."
  },
  RelicConfig_70704_BattleDesc = {
    Text = "Keyflare Uyanışı kullanarak tüm düşmanlara [Arg1] <IntoxicationIconKeywords:Zehir> uygula ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70704_Desc = {
    Text = "Keyflare Uyanışı kullanarak tüm düşmanlara [Arg1] <IntoxicationIconKeywords:Zehir> uygula ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70704_Name = {
    Text = "<OrangeQuality:Şüpheli Merhem+>"
  },
  RelicConfig_70704_StoryDesc = {
    Text = "Dış yaralar için bir tür ev yapımı merhem. Doktorun rehberliği olmadan kullanmayın."
  },
  RelicConfig_70705_BattleDesc = {
    Text = "\"Darbe\", verdiği Hasarın [Arg1]%’ine eşit, her turda en fazla [Arg2] olan <IntoxicationIconKeywords:Zehir> uygular."
  },
  RelicConfig_70705_Desc = {
    Text = "\"Darbe\", verdiği Hasarın [Arg1]%’ine eşit, her turda en fazla [Arg2] olan <IntoxicationIconKeywords:Zehir> uygular."
  },
  RelicConfig_70705_Name = {
    Text = "<OrangeQuality:Yabancı Tür Sözcüsü+>"
  },
  RelicConfig_70705_StoryDesc = {
    Text = "O bir iblis değil, ama gerçekten de ölümlü âlemin ötesinden gelen fısıltıları taşır."
  },
  RelicConfig_70706_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:Embriyo Füzyonu> Otomatik kazanç +[Arg1]%"
  },
  RelicConfig_70706_Desc = {
    Text = "<EmbryoFusionIconKeywords:Embriyo Füzyonu> Otomatik kazanç +[Arg1]%"
  },
  RelicConfig_70706_Name = {
    Text = "<WhiteQuality:Veba Raporu>"
  },
  RelicConfig_70706_StoryDesc = {
    Text = "Veba — doğanın bilinçsiz, huzursuz bir tezahürü."
  },
  RelicConfig_70707_BattleDesc = {
    Text = "Keyflare Uyanışı kullandıktan sonra tüm Uyanışçılar [Arg1] Aliemus ve [Arg2] Keyflare kazanır."
  },
  RelicConfig_70707_Desc = {
    Text = "Keyflare Uyanışı kullandıktan sonra tüm Uyanışçılar [Arg1] Aliemus ve [Arg2] Keyflare kazanır."
  },
  RelicConfig_70707_Name = {
    Text = "<OrangeQuality:Defne Yaprağı Kol Düğmeleri+>"
  },
  RelicConfig_70707_StoryDesc = {
    Text = "Üzerine zeytin çiçeği yaprağı desenleri işlenmiş gümüş kol düğmeleri.\nİnce işçilikli ve ışıl ışıl; bir zamanlar iki çocuğun dostluğunu cisimleştiriyorlardı."
  },
  RelicConfig_70708_BattleDesc = {
    Text = "Savaş başladıktan sonra, [Arg1] <ProficientInRealmsIconKeywords:Diyar Ustalığı> kazan. Tüm Uyandıran ve Kalıntı <IntoxicationIconKeywords:Zehir> Etkileri +[Arg2]%."
  },
  RelicConfig_70708_Desc = {
    Text = "Savaş başladıktan sonra, [Arg1] <ProficientInRealmsIconKeywords:Diyar Ustalığı> kazan. Tüm Uyandıran ve Kalıntı <IntoxicationIconKeywords:Zehir> Etkileri +[Arg2]%."
  },
  RelicConfig_70708_Name = {
    Text = "<OrangeQuality:Tozlanmış Dokuma Tezgâhı+>"
  },
  RelicConfig_70708_StoryDesc = {
    Text = "Şefkatli bir anne, kalbin yaralarını diker."
  },
  RelicConfig_70709_BattleDesc = {
    Text = "Ultra Tur’a girdikten sonra oynanan ilk Türetilmemiş Komut Kartı, fazladan [Arg1] kez daha etkinleşir."
  },
  RelicConfig_70709_Desc = {
    Text = "Ultra Tur’a girdikten sonra oynanan ilk Türetilmemiş Komut Kartı, fazladan [Arg1] kez daha etkinleşir."
  },
  RelicConfig_70709_Name = {
    Text = "<WhiteQuality:Parıltı Kum Saati>"
  },
  RelicConfig_70709_StoryDesc = {
    Text = "Ölçülebilir bir zaman dilimi."
  },
  RelicConfig_70711_BattleDesc = {
    Text = "Keyflare Uyanışı kullan ve [Arg1] <RetaliateIconKeywords:Sayaç> ile [Arg2] Keyflare kazan."
  },
  RelicConfig_70711_Desc = {
    Text = "Keyflare Uyanışı kullan ve [Arg1] <RetaliateIconKeywords:Sayaç> ile [Arg2] Keyflare kazan."
  },
  RelicConfig_70711_Name = {
    Text = "<OrangeQuality:Kadim Bilgelerin Kayıp Bölümü+>"
  },
  RelicConfig_70711_StoryDesc = {
    Text = "\"İnsanlar ne kadar da budala; sırf kadim diye körü körüne inanıyorlar.\""
  },
  RelicConfig_70712_BattleDesc = {
    Text = "Keyflare Uyanışı kullan ve [Arg1] <PowerIconKeywords:GÜÇ> ile [Arg2] Keyflare kazan."
  },
  RelicConfig_70712_Desc = {
    Text = "Keyflare Uyanışı kullan ve [Arg1] <PowerIconKeywords:GÜÇ> ile [Arg2] Keyflare kazan."
  },
  RelicConfig_70712_Name = {
    Text = "<WhiteQuality:Yuvamız>"
  },
  RelicConfig_70712_StoryDesc = {
    Text = "Geçmişte birlikteydiler, gelecekte de daima birlikte olacaklar. Sıkı sıkıya bağlı, sevgi dolu bir aileler."
  },
  RelicConfig_70713_BattleDesc = {
    Text = "HP kaybedildiğinde, kaybedilen HP’nin [Arg1]%’i kadar Kızıl Ocak biriktir."
  },
  RelicConfig_70713_Desc = {
    Text = "HP kaybedildiğinde, kaybedilen HP’nin [Arg1]%’i kadar Kızıl Ocak biriktir."
  },
  RelicConfig_70713_Name = {
    Text = "<WhiteQuality:Paslı Testere>"
  },
  RelicConfig_70713_StoryDesc = {
    Text = "Otopsi doktoru, hayatını hiç güzel bir kadın görmeden, yalnızca kemik yığınları, iltihaplı sinirler, kaslar ve hastalıkların yol açtığı dokularla geçirir."
  },
  RelicConfig_70714_BattleDesc = {
    Text = "Savaş başladıktan sonra, [Arg1] <ProficientInRealmsIconKeywords:Diyar Ustalığı> kazan. Tüm Uyandıranların ve Kalıntıların <RetaliateIconKeywords:Sayaç>’ı +[Arg2]%."
  },
  RelicConfig_70714_Desc = {
    Text = "Savaş başladıktan sonra, [Arg1] <ProficientInRealmsIconKeywords:Diyar Ustalığı> kazan. Tüm Uyandıranların ve Kalıntıların <RetaliateIconKeywords:Sayaç>’ı +[Arg2]%."
  },
  RelicConfig_70714_Name = {
    Text = "<WhiteQuality:Bildiğini Saklamayan>"
  },
  RelicConfig_70714_StoryDesc = {
    Text = "İster isteyerek ister istemeden, sayısız sır iletir."
  },
  RelicConfig_70715_BattleDesc = {
    Text = "Keyflare Uyanışı kullandıktan sonra [Arg1] kart çek ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70715_Desc = {
    Text = "Keyflare Uyanışı kullandıktan sonra [Arg1] kart çek ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70715_Name = {
    Text = "<OrangeQuality:Yepyeni Cüzdan+>"
  },
  RelicConfig_70715_StoryDesc = {
    Text = "Mythag Üniversitesi'nin arması işlenmiş deri bir cüzdan.\nArtık bomboş, içinde hiçbir şey yok."
  },
  RelicConfig_70717_BattleDesc = {
    Text = "Tur başında, [Arg1] kart çek."
  },
  RelicConfig_70717_Desc = {
    Text = "Tur başında, [Arg1] kart çek."
  },
  RelicConfig_70717_Name = {
    Text = "<OrangeQuality:Yön Pusulası+>"
  },
  RelicConfig_70717_StoryDesc = {
    Text = "Gösterilen şey bir yön değil, daha çok bir manyetik alandır."
  },
  RelicConfig_70718_BattleDesc = {
    Text = "\"Taşkınlık\" serbest bırakıldıktan sonra, tüm düşmanlar [Arg1] <FixedDamage:Saf Hasar> alır ve %[Arg2] <IntoxicationIconKeywords:Zehir> tetiklenir."
  },
  RelicConfig_70718_Desc = {
    Text = "\"Taşkınlık\" serbest bırakıldıktan sonra, tüm düşmanlar takımın Maksimum canının [Arg2]%'sine eşit 1 kez <FixedDamage:Saf Hasar> alır ve %[Arg2] <IntoxicationIconKeywords:Zehir> tetiklenir."
  },
  RelicConfig_70718_Name = {
    Text = "<WhiteQuality:Radyum Çene Kemiği>"
  },
  RelicConfig_70718_StoryDesc = {
    Text = "Özel bir koleksiyoncunun sergi odasında teşhir edilirdi.\nKoleksiyoncuyu güzel floresansı büyülemişti; gece gündüz onu seyretti, ta ki sonunda solup giderek onun türünden biri olana dek."
  },
  RelicConfig_70719_BattleDesc = {
    Text = "Tur başında, tüm Uyananlar [Arg1] Aliemus kazanır."
  },
  RelicConfig_70719_Desc = {
    Text = "Tur başında, tüm Uyananlar [Arg1] Aliemus kazanır."
  },
  RelicConfig_70719_Name = {
    Text = "<OrangeQuality:Prototip Batarya+>"
  },
  RelicConfig_70719_StoryDesc = {
    Text = "Taşınabilir Umut"
  },
  RelicConfig_70720_BattleDesc = {
    Text = "Tur başında, HP %25’in altındaysa, [Arg1] Geçici <PowerIconKeywords:Güç> kazan."
  },
  RelicConfig_70720_Desc = {
    Text = "Tur başında, HP %25’in altındaysa, [Arg1] Geçici <PowerIconKeywords:Güç> kazan."
  },
  RelicConfig_70720_Name = {
    Text = "<WhiteQuality:Yüce Onur>"
  },
  RelicConfig_70720_StoryDesc = {
    Text = "Uzak bir çöl krallığında tanrı olarak yüceltildiği söylenen, zarif ve esrarengiz, siyah tüylü, kısa kıllı bir kedi. O ilahın adı artık zamanın sislerinde kaybolmuştur.\nTapıldı, yüceltildi, unutuldu—belki de tüm tanrıların kaderi budur."
  },
  RelicConfig_70721_BattleDesc = {
    Text = "Bir turda \"Yücelt\" i 4 kez serbest bıraktıktan sonra [Arg1] Arithmetica kazan. 3 turluk bekleme süresi."
  },
  RelicConfig_70721_Desc = {
    Text = "Bir turda \"Yücelt\" i 4 kez serbest bıraktıktan sonra [Arg1] Arithmetica kazan. 3 turluk bekleme süresi."
  },
  RelicConfig_70721_Name = {
    Text = "<WhiteQuality:Diferansiyel Motor>"
  },
  RelicConfig_70721_StoryDesc = {
    Text = "“Tarihi değiştirdi.”"
  },
  RelicConfig_70722_BattleDesc = {
    Text = "Keyflare Uyanışı kullan ve [Arg1] <PowerIconKeywords:GÜÇ> ile [Arg2] Keyflare kazan."
  },
  RelicConfig_70722_Desc = {
    Text = "Keyflare Uyanışı kullan ve [Arg1] <PowerIconKeywords:GÜÇ> ile [Arg2] Keyflare kazan."
  },
  RelicConfig_70722_Name = {
    Text = "<OrangeQuality:Yuvamız+>"
  },
  RelicConfig_70722_StoryDesc = {
    Text = "Geçmişte birlikteydiler, gelecekte de daima birlikte olacaklar. Sıkı sıkıya bağlı, sevgi dolu bir aileler."
  },
  RelicConfig_70723_BattleDesc = {
    Text = "Öncekinden daha yüksek Arithmetica Maliyetine sahip 2 Kartı art arda oynadığında, her turda en fazla 3 kez olmak üzere [Arg1] <RetaliateIconKeywords:Sayaç> kazan."
  },
  RelicConfig_70723_Desc = {
    Text = "Öncekinden daha yüksek Arithmetica Maliyetine sahip 2 Kartı art arda oynadığında, her turda en fazla 3 kez olmak üzere [Arg1] <RetaliateIconKeywords:Sayaç> kazan."
  },
  RelicConfig_70723_Name = {
    Text = "<OrangeQuality:Arcana Arşivi+>"
  },
  RelicConfig_70723_StoryDesc = {
    Text = "Kaderin akışı."
  },
  RelicConfig_70724_BattleDesc = {
    Text = "Savaş başladığında [Arg1] <PowerIconKeywords:STR> elde et."
  },
  RelicConfig_70724_Desc = {
    Text = "Savaş başladığında [Arg1] <PowerIconKeywords:STR> elde et."
  },
  RelicConfig_70724_Name = {
    Text = "<OrangeQuality:Kızıl Broş+>"
  },
  RelicConfig_70724_StoryDesc = {
    Text = "Taze kırmızının bir izi sızıyor."
  },
  RelicConfig_70725_BattleDesc = {
    Text = "Savaş başladıktan sonra, tüm düşmanlara [Arg1] yığın <WeaknessIconKeywords:Zayıflık> uygula; Reis Savaşlarında Etki iki katına çıkar. Tüm Uyandıranların Temel Hasarı +[Arg2]%."
  },
  RelicConfig_70725_Desc = {
    Text = "Savaş başladıktan sonra, tüm düşmanlara [Arg1] yığın <WeaknessIconKeywords:Zayıflık> uygula; Reis Savaşlarında Etki iki katına çıkar. Tüm Uyandıranların Temel Hasarı +[Arg2]%."
  },
  RelicConfig_70725_Name = {
    Text = "<OrangeQuality:Kötücül Çocuk+>"
  },
  RelicConfig_70725_StoryDesc = {
    Text = "Saf kötülükten doğdu, her ne kadar bu kendi iradesi olmasa da."
  },
  RelicConfig_70726_BattleDesc = {
    Text = "Yok Oluş’tan [Arg1] Karakter Kalkanı kazan; bekleme süresi 3 turdur."
  },
  RelicConfig_70726_Desc = {
    Text = "Yok Oluş’tan [Arg1] Karakter Kalkanı kazan; bekleme süresi 3 turdur."
  },
  RelicConfig_70726_Name = {
    Text = "<WhiteQuality:Süpertelli Cep Saati>"
  },
  RelicConfig_70726_StoryDesc = {
    Text = "“Ah hayır, cep saati durdu.”"
  },
  RelicConfig_70727_BattleDesc = {
    Text = "Tur sonunda [Heal:Arg1] HP yenile."
  },
  RelicConfig_70727_Desc = {
    Text = "Tur sonunda [Heal:Arg1] HP yenile."
  },
  RelicConfig_70727_Name = {
    Text = "<OrangeQuality:Kutsanmış Kan+>"
  },
  RelicConfig_70727_StoryDesc = {
    Text = "Tatlı ve yumuşak; gül kokulu."
  },
  RelicConfig_70728_BattleDesc = {
    Text = "Sakin Deniz duruşuna geçmek, tüm düşmanların [Arg1] Geçici <ExhaustionIconKeywords:Güç> kaybetmesine neden olur. 3 turluk bekleme süresi."
  },
  RelicConfig_70728_Desc = {
    Text = "Sakin Deniz duruşuna geçmek, tüm düşmanların [Arg1] Geçici <ExhaustionIconKeywords:Güç> kaybetmesine neden olur. 3 turluk bekleme süresi."
  },
  RelicConfig_70728_Name = {
    Text = "<OrangeQuality:İsimsiz Uzuv+>"
  },
  RelicConfig_70728_StoryDesc = {
    Text = "Dikkat et, dikenine batma."
  },
  RelicConfig_70730_BattleDesc = {
    Text = "Savaş başladığında [Arg1] <PowerIconKeywords:STR> elde et."
  },
  RelicConfig_70730_Desc = {
    Text = "Savaş başladığında [Arg1] <PowerIconKeywords:STR> elde et."
  },
  RelicConfig_70730_Name = {
    Text = "<WhiteQuality:Kızıl Broş>"
  },
  RelicConfig_70730_StoryDesc = {
    Text = "Taze kırmızının bir izi sızıyor."
  },
  RelicConfig_70731_BattleDesc = {
    Text = "Bir düşman tarafından saldırıya uğrandığında, ona [Arg1] Sabit Hasar ver. Bu hasar %[Arg2] <RetaliateIconKeywords:Karşı Atak> bonusundan yararlanır. Her düşman bu efekti tur başına en fazla 1 kez tetikleyebilir."
  },
  RelicConfig_70731_Desc = {
    Text = "Bir düşman tarafından saldırıya uğrandığında, takımın Maksimum canının [Arg3]%'sine eşit Sabit Hasar ver. Bu hasar %[Arg2] <RetaliateIconKeywords:Karşı Atak> bonusundan yararlanır. Her düşman bu efekti tur başına en fazla 1 kez tetikleyebilir."
  },
  RelicConfig_70731_Name = {
    Text = "<OrangeQuality:Ritüel Hançeri+>"
  },
  RelicConfig_70731_StoryDesc = {
    Text = "Eğri bıçaklı bir hançer; genellikle kurban ayinlerinde kullanılır."
  },
  RelicConfig_70732_BattleDesc = {
    Text = "Ultra Tur’a girdikten sonra oynanan ilk Türetilmemiş Komut Kartı, fazladan [Arg1] kez daha etkinleşir."
  },
  RelicConfig_70732_Desc = {
    Text = "Ultra Tur’a girdikten sonra oynanan ilk Türetilmemiş Komut Kartı, fazladan [Arg1] kez daha etkinleşir."
  },
  RelicConfig_70732_Name = {
    Text = "<OrangeQuality:Parıltı Kum Saati+>"
  },
  RelicConfig_70732_StoryDesc = {
    Text = "Ölçülebilir bir zaman dilimi."
  },
  RelicConfig_70733_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:Embriyo Füzyonu> Otomatik kazanç +[Arg1]%"
  },
  RelicConfig_70733_Desc = {
    Text = "<EmbryoFusionIconKeywords:Embriyo Füzyonu> Otomatik kazanç +[Arg1]%"
  },
  RelicConfig_70733_Name = {
    Text = "<OrangeQuality:Veba Raporu+>"
  },
  RelicConfig_70733_StoryDesc = {
    Text = "Veba — doğanın bilinçsiz, huzursuz bir tezahürü."
  },
  RelicConfig_70734_BattleDesc = {
    Text = "Keyflare Uyanışı kullandıktan sonra tüm Uyanışçıların verdiği Temel Hasarı [Arg1]% artır ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70734_Desc = {
    Text = "Keyflare Uyanışı kullandıktan sonra tüm Uyanışçıların verdiği Temel Hasarı [Arg1]% artır ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70734_Name = {
    Text = "<WhiteQuality:Göksel Usturlap>"
  },
  RelicConfig_70734_StoryDesc = {
    Text = "Evrenin harikaları."
  },
  RelicConfig_70735_BattleDesc = {
    Text = "Öncekinden daha düşük Arithmetica Maliyetine sahip 2 Kartı art arda oynadığında, tüm düşmanlara her turda en fazla 3 kez olmak üzere [Arg1] <IntoxicationIconKeywords:Zehir> uygula."
  },
  RelicConfig_70735_Desc = {
    Text = "Öncekinden daha düşük Arithmetica Maliyetine sahip 2 Kartı art arda oynadığında, tüm düşmanlara her turda en fazla 3 kez olmak üzere [Arg1] <IntoxicationIconKeywords:Zehir> uygula."
  },
  RelicConfig_70735_Name = {
    Text = "<OrangeQuality:Arcana Kalıntısı+>"
  },
  RelicConfig_70735_StoryDesc = {
    Text = "Kaderin Sonu"
  },
  RelicConfig_70736_BattleDesc = {
    Text = "Sakin Deniz duruşuna geçmek, tüm düşmanların [Arg1] Geçici <ExhaustionIconKeywords:Güç> kaybetmesine neden olur. 3 turluk bekleme süresi."
  },
  RelicConfig_70736_Desc = {
    Text = "Sakin Deniz duruşuna geçmek, tüm düşmanların [Arg1] Geçici <ExhaustionIconKeywords:Güç> kaybetmesine neden olur. 3 turluk bekleme süresi."
  },
  RelicConfig_70736_Name = {
    Text = "<WhiteQuality:İsimsiz Uzuv>"
  },
  RelicConfig_70736_StoryDesc = {
    Text = "Dikkat et, dikenine batma."
  },
  RelicConfig_70737_BattleDesc = {
    Text = "Bir kart oynadıktan sonra, eldeki kart sayısı [Arg1] veya daha azsa [Arg2] kart çek. Bu etki, tur başına en fazla [Arg3] kez tetiklenebilir."
  },
  RelicConfig_70737_Desc = {
    Text = "Bir kart oynadıktan sonra, eldeki kart sayısı [Arg1] veya daha azsa [Arg2] kart çek. Bu etki, tur başına en fazla [Arg3] kez tetiklenebilir."
  },
  RelicConfig_70737_Name = {
    Text = "<WhiteQuality:Gizemli Eldivenler>"
  },
  RelicConfig_70737_StoryDesc = {
    Text = "“Korkma, bu sadece bir düş.”"
  },
  RelicConfig_70738_BattleDesc = {
    Text = "Tur sonunda [Heal:Arg1] HP yenile."
  },
  RelicConfig_70738_Desc = {
    Text = "Tur sonunda [Heal:Arg1] HP yenile."
  },
  RelicConfig_70738_Name = {
    Text = "<WhiteQuality:Kutsanmış Kan>"
  },
  RelicConfig_70738_StoryDesc = {
    Text = "Tatlı ve yumuşak; gül kokulu."
  },
  RelicConfig_70739_BattleDesc = {
    Text = "Keyflare Uyanışı kullandıktan sonra [Arg1] Karakter Kalkanı ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70739_Desc = {
    Text = "Keyflare Uyanışı kullandıktan sonra [Arg1] Karakter Kalkanı ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70739_Name = {
    Text = "<WhiteQuality:Muhafaza Edilmiş Kelebek>"
  },
  RelicConfig_70739_StoryDesc = {
    Text = "Bugüne dek hâlâ biri tarafından derinlemesine seviliyor."
  },
  RelicConfig_70740_BattleDesc = {
    Text = "Keyflare Uyanışı kullandıktan sonra tüm Uyanışçıların verdiği Temel Hasarı [Arg1]% artır ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70740_Desc = {
    Text = "Keyflare Uyanışı kullandıktan sonra tüm Uyanışçıların verdiği Temel Hasarı [Arg1]% artır ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70740_Name = {
    Text = "<OrangeQuality:Göksel Usturlap+>"
  },
  RelicConfig_70740_StoryDesc = {
    Text = "Evrenin harikaları."
  },
  RelicConfig_70741_BattleDesc = {
    Text = "Maksimum Arithmetica +[Arg1]."
  },
  RelicConfig_70741_Desc = {
    Text = "Maksimum Arithmetica +[Arg1]."
  },
  RelicConfig_70741_Name = {
    Text = "<OrangeQuality:Canlılık Enjeksiyonu+>"
  },
  RelicConfig_70741_StoryDesc = {
    Text = "Seğirme de bir tür Canlılıktır."
  },
  RelicConfig_70742_BattleDesc = {
    Text = "Savaş başında, Dokunaç Sınırı +[Arg1], [Arg2] Dokunaç kazan."
  },
  RelicConfig_70742_Desc = {
    Text = "Savaş başında, Dokunaç Sınırı +[Arg1], [Arg2] Dokunaç kazan."
  },
  RelicConfig_70742_Name = {
    Text = "<WhiteQuality:Deniz İlahisi>"
  },
  RelicConfig_70742_StoryDesc = {
    Text = "Yenmeyen deniz canlıları, örneğin deniz salyangozları, okyanusun besinlerinin yaklaşık %80'ini absorbe eder denir."
  },
  RelicConfig_70743_BattleDesc = {
    Text = "Her turda, <DevouredIconKeywords:Yutma> ilk kez tetiklendiğinde, diğer Uyandıran [Arg1] Aliemus kazanır."
  },
  RelicConfig_70743_Desc = {
    Text = "Her turda, <DevouredIconKeywords:Yutma> ilk kez tetiklendiğinde, diğer Uyandıran [Arg1] Aliemus kazanır."
  },
  RelicConfig_70743_Name = {
    Text = "<WhiteQuality:Altın Düş Diyarı>"
  },
  RelicConfig_70743_StoryDesc = {
    Text = "Dönüşüm günü, senin kıyametin olacak."
  },
  RelicConfig_70744_BattleDesc = {
    Text = "Türetilmemiş bir Komut Kartı oynandıktan sonra, Çekme Desteğine Arithmetica Maliyeti 2 azaltılmış o karttan [Arg1] adet geçici kopya karıştır. Bekleme süresi: 3 tur."
  },
  RelicConfig_70744_Desc = {
    Text = "Türetilmemiş bir Komut Kartı oynandıktan sonra, Çekme Desteğine Arithmetica Maliyeti 2 azaltılmış o karttan [Arg1] adet geçici kopya karıştır. Bekleme süresi: 3 tur."
  },
  RelicConfig_70744_Name = {
    Text = "<OrangeQuality:Sessiz Gramofon+>"
  },
  RelicConfig_70744_StoryDesc = {
    Text = "Sesi rüzgâra karışıp soldu."
  },
  RelicConfig_70745_BattleDesc = {
    Text = "Savaşın başında [Arg1] <RetaliateIconKeywords:Counter> elde et. Reis Savaşlarında etkiler iki katına çıkar."
  },
  RelicConfig_70745_Desc = {
    Text = "Savaşın başında [Arg1] <RetaliateIconKeywords:Counter> elde et. Reis Savaşlarında etkiler iki katına çıkar."
  },
  RelicConfig_70745_Name = {
    Text = "<OrangeQuality:Isırgan Yeleği+>"
  },
  RelicConfig_70745_StoryDesc = {
    Text = "Bulaşmış olan sıvı tespit edilemiyor."
  },
  RelicConfig_70746_BattleDesc = {
    Text = "Tur başında, HP %25’in altındaysa, [Arg1] Geçici <PowerIconKeywords:Güç> kazan."
  },
  RelicConfig_70746_Desc = {
    Text = "Tur başında, HP %25’in altındaysa, [Arg1] Geçici <PowerIconKeywords:Güç> kazan."
  },
  RelicConfig_70746_Name = {
    Text = "<OrangeQuality:Yüce Onur+>"
  },
  RelicConfig_70746_StoryDesc = {
    Text = "Uzak bir çöl krallığında tanrı olarak yüceltildiği söylenen, zarif ve esrarengiz, siyah tüylü, kısa kıllı bir kedi. O ilahın adı artık zamanın sislerinde kaybolmuştur.\nTapıldı, yüceltildi, unutuldu—belki de tüm tanrıların kaderi budur."
  },
  RelicConfig_70747_BattleDesc = {
    Text = "Bir kart oynadıktan sonra, eldeki kart sayısı [Arg1] veya daha azsa [Arg2] kart çek. Bu etki, tur başına en fazla [Arg3] kez tetiklenebilir."
  },
  RelicConfig_70747_Desc = {
    Text = "Bir kart oynadıktan sonra, eldeki kart sayısı [Arg1] veya daha azsa [Arg2] kart çek. Bu etki, tur başına en fazla [Arg3] kez tetiklenebilir."
  },
  RelicConfig_70747_Name = {
    Text = "<OrangeQuality:Gizemli Eldivenler+>"
  },
  RelicConfig_70747_StoryDesc = {
    Text = "“Korkma, bu sadece bir düş.”"
  },
  RelicConfig_70748_BattleDesc = {
    Text = "Keyflare Uyanışı kullandıktan sonra [Arg1] Karakter Kalkanı ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70748_Desc = {
    Text = "Keyflare Uyanışı kullandıktan sonra [Arg1] Karakter Kalkanı ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70748_Name = {
    Text = "<OrangeQuality:Korunmuş Kelebek+>"
  },
  RelicConfig_70748_StoryDesc = {
    Text = "Bugüne dek hâlâ biri tarafından derinlemesine seviliyor."
  },
  RelicConfig_70749_BattleDesc = {
    Text = "Bir kart Ultra Uzay’a her girdiğinde, eğer bu kart Ultra Uzay’daki diğer kartların sahibinden farklı bir sahibe aitse, ele [Arg1] <DerivativeCardKeywords_4:\"Kavrayış\"> kartı yerleştir."
  },
  RelicConfig_70749_Desc = {
    Text = "Bir kart Ultra Uzay’a her girdiğinde, eğer bu kart Ultra Uzay’daki diğer kartların sahibinden farklı bir sahibe aitse, ele [Arg1] <DerivativeCardKeywords_4:\"Kavrayış\"> kartı yerleştir."
  },
  RelicConfig_70749_Name = {
    Text = "<OrangeQuality:Alfonso'nun Eseri+>"
  },
  RelicConfig_70749_StoryDesc = {
    Text = "Öngörülemez kaderin aksine, yıldızlar kendi yasalarına uyar."
  },
  RelicConfig_70750_BattleDesc = {
    Text = "Öncekinden daha yüksek Arithmetica Maliyetine sahip 2 Kartı art arda oynadığında, her turda en fazla 3 kez olmak üzere [Arg1] <RetaliateIconKeywords:Sayaç> kazan."
  },
  RelicConfig_70750_Desc = {
    Text = "Öncekinden daha yüksek Arithmetica Maliyetine sahip 2 Kartı art arda oynadığında, her turda en fazla 3 kez olmak üzere [Arg1] <RetaliateIconKeywords:Sayaç> kazan."
  },
  RelicConfig_70750_Name = {
    Text = "<WhiteQuality:Arcana Arşivi>"
  },
  RelicConfig_70750_StoryDesc = {
    Text = "Kaderin akışı."
  },
  RelicConfig_70751_BattleDesc = {
    Text = "Keyflare Uyanışı kullandıktan sonra [Arg1] Arithmetica ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70751_Desc = {
    Text = "Keyflare Uyanışı kullandıktan sonra [Arg1] Arithmetica ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70751_Name = {
    Text = "<WhiteQuality:Mythag Nişanı>"
  },
  RelicConfig_70751_StoryDesc = {
    Text = "Mythag Üniversitesi tarafından Müfettişlere dağıtılan rozetler. Yalnızca taşıyanın kimliğini simgelemekle kalmaz, aynı zamanda uzaktan iletişim aracı olarak da hizmet ederler."
  },
  RelicConfig_70752_BattleDesc = {
    Text = "Keyflare Uyanışı kullan ve [Arg1] <RetaliateIconKeywords:Sayaç> ile [Arg2] Keyflare kazan."
  },
  RelicConfig_70752_Desc = {
    Text = "Keyflare Uyanışı kullan ve [Arg1] <RetaliateIconKeywords:Sayaç> ile [Arg2] Keyflare kazan."
  },
  RelicConfig_70752_Name = {
    Text = "<WhiteQuality:Kadim Bilgelerin Kayıp Bölümü>"
  },
  RelicConfig_70752_StoryDesc = {
    Text = "\"İnsanlar ne kadar da budala; sırf kadim diye körü körüne inanıyorlar.\""
  },
  RelicConfig_70753_BattleDesc = {
    Text = "Savaş başladıktan sonra, tüm düşmanlara [Arg1] yığın <VulnerabilityIconKeywords:Savunmasız> uygula; Reis Savaşlarında bu etki iki katına çıkar. Tüm Uyananların Temel Hasarı +[Arg2]%."
  },
  RelicConfig_70753_Desc = {
    Text = "Savaş başladıktan sonra, tüm düşmanlara [Arg1] yığın <VulnerabilityIconKeywords:Savunmasız> uygula; Reis Savaşlarında bu etki iki katına çıkar. Tüm Uyananların Temel Hasarı +[Arg2]%."
  },
  RelicConfig_70753_Name = {
    Text = "<OrangeQuality:Bahar Ayini+>"
  },
  RelicConfig_70753_StoryDesc = {
    Text = "Gecenin kahkahaları arasında, kano silueti gölün üzerinde zahmetsizce süzülür."
  },
  RelicConfig_70754_BattleDesc = {
    Text = "Her turda ilk kez \"Embriyo\" yu doğrudan kullandıktan sonra, turun geri kalanında Aktif Hasar, verdiği Hasarın [Arg1]%’i kadar <BleedingIconKeywords:Kan Akıtma> uygular."
  },
  RelicConfig_70754_Desc = {
    Text = "Her turda ilk kez \"Embriyo\" yu doğrudan kullandıktan sonra, turun geri kalanında Aktif Hasar, verdiği Hasarın [Arg1]%’i kadar <BleedingIconKeywords:Kan Akıtma> uygular."
  },
  RelicConfig_70754_Name = {
    Text = "<WhiteQuality:Boyanmış Kanlı Çakıl Taşı>"
  },
  RelicConfig_70754_StoryDesc = {
    Text = "Bir, İki, Üç, Dört, Beş."
  },
  RelicConfig_70755_BattleDesc = {
    Text = "Her Hasar verildiğinde [Arg1] Geçici <PowerIconKeywords:STR> kazan, tur başına en fazla 15 kez."
  },
  RelicConfig_70755_Desc = {
    Text = "Her Hasar verildiğinde [Arg1] Geçici <PowerIconKeywords:STR> kazan, tur başına en fazla 15 kez."
  },
  RelicConfig_70755_Name = {
    Text = "<OrangeQuality:Telkâri Akik+>"
  },
  RelicConfig_70755_StoryDesc = {
    Text = "Muhtemelen sıradan akik desenleridir. Belki."
  },
  RelicConfig_70756_BattleDesc = {
    Text = "Keyflare Uyanışı kullandıktan sonra [Arg1] Arithmetica ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70756_Desc = {
    Text = "Keyflare Uyanışı kullandıktan sonra [Arg1] Arithmetica ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70756_Name = {
    Text = "<OrangeQuality:Mythag Arması+>"
  },
  RelicConfig_70756_StoryDesc = {
    Text = "Mythag Üniversitesi tarafından Müfettişlere dağıtılan rozetler. Yalnızca taşıyanın kimliğini simgelemekle kalmaz, aynı zamanda uzaktan iletişim aracı olarak da hizmet ederler."
  },
  RelicConfig_70757_BattleDesc = {
    Text = "Azgın Dalgalar duruşunu kullanarak tüm Dokunaç Saldırılarını düşmanlar üzerinde anında [Arg1] kez etkinleştir; 3 turluk bekleme süresi."
  },
  RelicConfig_70757_Desc = {
    Text = "Azgın Dalgalar duruşunu kullanarak tüm Dokunaç Saldırılarını düşmanlar üzerinde anında [Arg1] kez etkinleştir; 3 turluk bekleme süresi."
  },
  RelicConfig_70757_Name = {
    Text = "<WhiteQuality:Lemuria'nın Hazzı>"
  },
  RelicConfig_70757_StoryDesc = {
    Text = "Ebedi Uykuya Dalış’ın Efendisi, rüyalarında seni bekliyor."
  },
  RelicConfig_70758_BattleDesc = {
    Text = "Öncekinden daha düşük Arithmetica Maliyetine sahip 2 Kartı art arda oynadığında, tüm düşmanlara her turda en fazla 3 kez olmak üzere [Arg1] <IntoxicationIconKeywords:Zehir> uygula."
  },
  RelicConfig_70758_Desc = {
    Text = "Öncekinden daha düşük Arithmetica Maliyetine sahip 2 Kartı art arda oynadığında, tüm düşmanlara her turda en fazla 3 kez olmak üzere [Arg1] <IntoxicationIconKeywords:Zehir> uygula."
  },
  RelicConfig_70758_Name = {
    Text = "<WhiteQuality:Arcana Kalıntısı>"
  },
  RelicConfig_70758_StoryDesc = {
    Text = "Kaderin Sonu"
  },
  RelicConfig_70759_BattleDesc = {
    Text = "Savaş başladıktan sonra, tüm düşmanlara [Arg1] yığın <WeaknessIconKeywords:Zayıflık> uygula; Reis Savaşlarında Etki iki katına çıkar. Tüm Uyandıranların Temel Hasarı +[Arg2]%."
  },
  RelicConfig_70759_Desc = {
    Text = "Savaş başladıktan sonra, tüm düşmanlara [Arg1] yığın <WeaknessIconKeywords:Zayıflık> uygula; Reis Savaşlarında Etki iki katına çıkar. Tüm Uyandıranların Temel Hasarı +[Arg2]%."
  },
  RelicConfig_70759_Name = {
    Text = "<WhiteQuality:Kötücül Çocuk>"
  },
  RelicConfig_70759_StoryDesc = {
    Text = "Saf kötülükten doğdu, her ne kadar bu kendi iradesi olmasa da."
  },
  RelicConfig_70760_BattleDesc = {
    Text = "Savaşın başında tüm düşmanlara [Arg1] <IntoxicationIconKeywords:Zehir> uygula; Reis Savaşlarında bu etki iki katına çıkar."
  },
  RelicConfig_70760_Desc = {
    Text = "Savaşın başında tüm düşmanlara [Arg1] <IntoxicationIconKeywords:Zehir> uygula; Reis Savaşlarında bu etki iki katına çıkar."
  },
  RelicConfig_70760_Name = {
    Text = "<WhiteQuality:Nörotoksin>"
  },
  RelicConfig_70760_StoryDesc = {
    Text = "Çek, Arıt."
  },
  RelicConfig_70761_BattleDesc = {
    Text = "Savaş başladıktan sonra, tüm düşmanlara [Arg1] yığın <VulnerabilityIconKeywords:Savunmasız> uygula; Reis Savaşlarında bu etki iki katına çıkar. Tüm Uyananların Temel Hasarı +[Arg2]%."
  },
  RelicConfig_70761_Desc = {
    Text = "Savaş başladıktan sonra, tüm düşmanlara [Arg1] yığın <VulnerabilityIconKeywords:Savunmasız> uygula; Reis Savaşlarında bu etki iki katına çıkar. Tüm Uyananların Temel Hasarı +[Arg2]%."
  },
  RelicConfig_70761_Name = {
    Text = "<WhiteQuality:Bahar Ayini>"
  },
  RelicConfig_70761_StoryDesc = {
    Text = "Gecenin kahkahaları arasında, kano silueti gölün üzerinde zahmetsizce süzülür."
  },
  RelicConfig_70762_BattleDesc = {
    Text = "Bir turda \"Yücelt\" i 4 kez serbest bıraktıktan sonra [Arg1] Arithmetica kazan. 3 turluk bekleme süresi."
  },
  RelicConfig_70762_Desc = {
    Text = "Bir turda \"Yücelt\" i 4 kez serbest bıraktıktan sonra [Arg1] Arithmetica kazan. 3 turluk bekleme süresi."
  },
  RelicConfig_70762_Name = {
    Text = "<OrangeQuality:Diferansiyel Motor+>"
  },
  RelicConfig_70762_StoryDesc = {
    Text = "“Tarihi değiştirdi.”"
  },
  RelicConfig_70763_BattleDesc = {
    Text = "\"Exalt\" serbest bırakıldıktan sonra, [Arg1] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_70763_Desc = {
    Text = "\"Exalt\" serbest bırakıldıktan sonra, [Arg1] Geçici <PowerIconKeywords:STR> kazan."
  },
  RelicConfig_70763_Name = {
    Text = "<WhiteQuality:Demir Kilit>"
  },
  RelicConfig_70763_StoryDesc = {
    Text = "Kalın ve sağlam bir kilit, anahtar olmadan açılması güç.\nElbette, usta bir hırsız için bunun hiçbir önemi yok."
  },
  RelicConfig_70764_BattleDesc = {
    Text = "Bir düşman tarafından saldırıya uğrandığında, ona [Arg1] Sabit Hasar ver. Bu hasar %[Arg2] <RetaliateIconKeywords:Karşı Atak> bonusundan yararlanır. Her düşman bu efekti tur başına en fazla 1 kez tetikleyebilir."
  },
  RelicConfig_70764_Desc = {
    Text = "Bir düşman tarafından saldırıya uğrandığında, takımın Maksimum canının [Arg3]%'sine eşit Sabit Hasar ver. Bu hasar %[Arg2] <RetaliateIconKeywords:Karşı Atak> bonusundan yararlanır. Her düşman bu efekti tur başına en fazla 1 kez tetikleyebilir."
  },
  RelicConfig_70764_Name = {
    Text = "<WhiteQuality:Ritüel Hançeri>"
  },
  RelicConfig_70764_StoryDesc = {
    Text = "Eğri bıçaklı bir hançer; genellikle kurban ayinlerinde kullanılır."
  },
  RelicConfig_70765_BattleDesc = {
    Text = "Her Hasar verildiğinde [Arg1] Geçici <PowerIconKeywords:STR> kazan, tur başına en fazla 15 kez."
  },
  RelicConfig_70765_Desc = {
    Text = "Her Hasar verildiğinde [Arg1] Geçici <PowerIconKeywords:STR> kazan, tur başına en fazla 15 kez."
  },
  RelicConfig_70765_Name = {
    Text = "<WhiteQuality:Telkâri Akik>"
  },
  RelicConfig_70765_StoryDesc = {
    Text = "Muhtemelen sıradan akik desenleridir. Belki."
  },
  RelicConfig_70766_BattleDesc = {
    Text = "Tur başında, HP %25’in altındaysa [Arg1] Kalkan kazan."
  },
  RelicConfig_70766_Desc = {
    Text = "Tur başında, HP %25’in altındaysa [Arg1] Kalkan kazan."
  },
  RelicConfig_70766_Name = {
    Text = "<WhiteQuality:Muhafaza Eli>"
  },
  RelicConfig_70766_StoryDesc = {
    Text = "Dua eden el, metanetli kalan yumruk."
  },
  RelicConfig_70767_BattleDesc = {
    Text = "Yok Oluş, en düşük Aliemus’a sahip Uyanışçıya [Arg1] Aliemus verir; bekleme süresi 3 turdur."
  },
  RelicConfig_70767_Desc = {
    Text = "Yok Oluş, en düşük Aliemus’a sahip Uyanışçıya [Arg1] Aliemus verir; bekleme süresi 3 turdur."
  },
  RelicConfig_70767_Name = {
    Text = "<WhiteQuality:Zaman Skarabeusu>"
  },
  RelicConfig_70767_StoryDesc = {
    Text = "Hem bir saat mağazasında hem de bir böcek müzesinde bulunmuş bir cep saati.\nTufan’dan beri üniversitenin koleksiyonuna dâhil edilmiştir."
  },
  RelicConfig_70768_BattleDesc = {
    Text = "Savaş başladıktan sonra, [Arg1] <ProficientInRealmsIconKeywords:Diyar Ustalığı> kazan. Tüm Uyandıranların ve Kalıntıların <RetaliateIconKeywords:Sayaç>’ı +[Arg2]%."
  },
  RelicConfig_70768_Desc = {
    Text = "Savaş başladıktan sonra, [Arg1] <ProficientInRealmsIconKeywords:Diyar Ustalığı> kazan. Tüm Uyandıranların ve Kalıntıların <RetaliateIconKeywords:Sayaç>’ı +[Arg2]%."
  },
  RelicConfig_70768_Name = {
    Text = "<OrangeQuality:Bildiğini Saklamayan+>"
  },
  RelicConfig_70768_StoryDesc = {
    Text = "İster isteyerek ister istemeden, sayısız sır iletir."
  },
  RelicConfig_70769_BattleDesc = {
    Text = "Her turda ilk kez \"Embriyo\" yu doğrudan kullandıktan sonra, turun geri kalanında Aktif Hasar, verdiği Hasarın [Arg1]%’i kadar <BleedingIconKeywords:Kan Akıtma> uygular."
  },
  RelicConfig_70769_Desc = {
    Text = "Her turda ilk kez \"Embriyo\" yu doğrudan kullandıktan sonra, turun geri kalanında Aktif Hasar, verdiği Hasarın [Arg1]%’i kadar <BleedingIconKeywords:Kan Akıtma> uygular."
  },
  RelicConfig_70769_Name = {
    Text = "<OrangeQuality:Boyanmış Kanlı Çakıl Taşı+>"
  },
  RelicConfig_70769_StoryDesc = {
    Text = "Bir, İki, Üç, Dört, Beş."
  },
  RelicConfig_70770_BattleDesc = {
    Text = "Tur başında, [Arg1] kart çek."
  },
  RelicConfig_70770_Desc = {
    Text = "Tur başında, [Arg1] kart çek."
  },
  RelicConfig_70770_Name = {
    Text = "<WhiteQuality:Yön Pusulası>"
  },
  RelicConfig_70770_StoryDesc = {
    Text = "Gösterilen şey bir yön değil, daha çok bir manyetik alandır."
  },
  RelicConfig_70771_BattleDesc = {
    Text = "\"Darbe\", ek olarak Uyandıran’ın SLD’sinin [Arg1]%’üne eşit 2 ek Hasar örneği daha verir; tur başına en fazla 3 kez tetiklenir."
  },
  RelicConfig_70771_Desc = {
    Text = "\"Darbe\", ek olarak Uyandıran’ın SLD’sinin [Arg1]%’üne eşit 2 ek Hasar örneği daha verir; tur başına en fazla 3 kez tetiklenir."
  },
  RelicConfig_70771_Name = {
    Text = "<OrangeQuality:Paslanmış Neşter+>"
  },
  RelicConfig_70771_StoryDesc = {
    Text = "Canlı dokuyu kesmeye uygun değil."
  },
  RelicConfig_70772_BattleDesc = {
    Text = "Keyflare Uyanışı kullandıktan sonra [Arg1] kart çek ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70772_Desc = {
    Text = "Keyflare Uyanışı kullandıktan sonra [Arg1] kart çek ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70772_Name = {
    Text = "<WhiteQuality:Yepyeni Cüzdan>"
  },
  RelicConfig_70772_StoryDesc = {
    Text = "Mythag Üniversitesi'nin arması işlenmiş deri bir cüzdan.\nArtık bomboş, içinde hiçbir şey yok."
  },
  RelicConfig_70774_BattleDesc = {
    Text = "Her turdaki ilk beş Saldırının Hasarını [Arg1]% artır."
  },
  RelicConfig_70774_Desc = {
    Text = "Her turdaki ilk beş Saldırının Hasarını [Arg1]% artır."
  },
  RelicConfig_70774_Name = {
    Text = "<WhiteQuality:Görüş Düzeltici>"
  },
  RelicConfig_70774_StoryDesc = {
    Text = "Bir zamanlar biri onun aracılığıyla Gerçek’i keşfetti."
  },
  RelicConfig_70776_BattleDesc = {
    Text = "Savaşın başında [Arg1] <RetaliateIconKeywords:Counter> elde et. Reis Savaşlarında etkiler iki katına çıkar."
  },
  RelicConfig_70776_Desc = {
    Text = "Savaşın başında [Arg1] <RetaliateIconKeywords:Counter> elde et. Reis Savaşlarında etkiler iki katına çıkar."
  },
  RelicConfig_70776_Name = {
    Text = "<WhiteQuality:Isırgan Yelek>"
  },
  RelicConfig_70776_StoryDesc = {
    Text = "Bulaşmış olan sıvı tespit edilemiyor."
  },
  RelicConfig_70777_BattleDesc = {
    Text = "Aynı turda art arda 4 farklı Uyananın Komut Kartı oynandığında, tüm Uyananlar [Arg1] Aliemus kazanır. 3 turluk bekleme süresi."
  },
  RelicConfig_70777_Desc = {
    Text = "Aynı turda art arda 4 farklı Uyananın Komut Kartı oynandığında, tüm Uyananlar [Arg1] Aliemus kazanır. 3 turluk bekleme süresi."
  },
  RelicConfig_70777_Name = {
    Text = "<WhiteQuality:İsimsiz Tanrının Peçesi>"
  },
  RelicConfig_70777_StoryDesc = {
    Text = "Tanrılara doğrudan bakma."
  },
  RelicConfig_70778_BattleDesc = {
    Text = "Savaşın başında tüm düşmanlara [Arg1] <IntoxicationIconKeywords:Zehir> uygula; Reis Savaşlarında bu etki iki katına çıkar."
  },
  RelicConfig_70778_Desc = {
    Text = "Savaşın başında tüm düşmanlara [Arg1] <IntoxicationIconKeywords:Zehir> uygula; Reis Savaşlarında bu etki iki katına çıkar."
  },
  RelicConfig_70778_Name = {
    Text = "<OrangeQuality:Nörotoksin+>"
  },
  RelicConfig_70778_StoryDesc = {
    Text = "Çek, Arıt."
  },
  RelicConfig_70779_BattleDesc = {
    Text = "Keyflare Uyanışı kullanarak tüm düşmanlara [Arg1] <IntoxicationIconKeywords:Zehir> uygula ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70779_Desc = {
    Text = "Keyflare Uyanışı kullanarak tüm düşmanlara [Arg1] <IntoxicationIconKeywords:Zehir> uygula ve [Arg2] Keyflare kazan."
  },
  RelicConfig_70779_Name = {
    Text = "<WhiteQuality:Şüpheli Merhem>"
  },
  RelicConfig_70779_StoryDesc = {
    Text = "Dış yaralar için bir tür ev yapımı merhem. Doktorun rehberliği olmadan kullanmayın."
  },
  RelicConfig_70780_BattleDesc = {
    Text = "\"Darbe\", verdiği Hasarın [Arg1]%’ine eşit, her turda en fazla [Arg2] olan <IntoxicationIconKeywords:Zehir> uygular."
  },
  RelicConfig_70780_Desc = {
    Text = "\"Darbe\", verdiği Hasarın [Arg1]%’ine eşit, her turda en fazla [Arg2] olan <IntoxicationIconKeywords:Zehir> uygular."
  },
  RelicConfig_70780_Name = {
    Text = "<WhiteQuality:Yabancı Tür Sözcüsü>"
  },
  RelicConfig_70780_StoryDesc = {
    Text = "O bir iblis değil, ama gerçekten de ölümlü âlemin ötesinden gelen fısıltıları taşır."
  },
  RelicConfig_70781_BattleDesc = {
    Text = "Tur başında, HP %25’in altındaysa [Arg1] Kalkan kazan."
  },
  RelicConfig_70781_Desc = {
    Text = "Tur başında, HP %25’in altındaysa [Arg1] Kalkan kazan."
  },
  RelicConfig_70781_Name = {
    Text = "<OrangeQuality:Muhafaza Eli+>"
  },
  RelicConfig_70781_StoryDesc = {
    Text = "Dua eden el, metanetli kalan yumruk."
  },
  RelicConfig_70782_BattleDesc = {
    Text = "HP kaybedildiğinde, kaybedilen HP’nin [Arg1]%’i kadar Kızıl Ocak biriktir."
  },
  RelicConfig_70782_Desc = {
    Text = "HP kaybedildiğinde, kaybedilen HP’nin [Arg1]%’i kadar Kızıl Ocak biriktir."
  },
  RelicConfig_70782_Name = {
    Text = "<OrangeQuality:Paslanmış Testere+>"
  },
  RelicConfig_70782_StoryDesc = {
    Text = "Otopsi doktoru, hayatını hiç güzel bir kadın görmeden, yalnızca kemik yığınları, iltihaplı sinirler, kaslar ve hastalıkların yol açtığı dokularla geçirir."
  },
  RelicConfig_70783_BattleDesc = {
    Text = "Her turdaki ilk beş Saldırının Hasarını [Arg1]% artır."
  },
  RelicConfig_70783_Desc = {
    Text = "Her turdaki ilk beş Saldırının Hasarını [Arg1]% artır."
  },
  RelicConfig_70783_Name = {
    Text = "<OrangeQuality:Görüş Düzeltici+>"
  },
  RelicConfig_70783_StoryDesc = {
    Text = "Bir zamanlar biri onun aracılığıyla Gerçek’i keşfetti."
  },
  RelicConfig_70784_BattleDesc = {
    Text = "Bir kart Ultra Uzay’a her girdiğinde, eğer bu kart Ultra Uzay’daki diğer kartların sahibinden farklı bir sahibe aitse, ele [Arg1] <DerivativeCardKeywords_4:\"Kavrayış\"> kartı yerleştir."
  },
  RelicConfig_70784_Desc = {
    Text = "Bir kart Ultra Uzay’a her girdiğinde, eğer bu kart Ultra Uzay’daki diğer kartların sahibinden farklı bir sahibe aitse, ele [Arg1] <DerivativeCardKeywords_4:\"Kavrayış\"> kartı yerleştir."
  },
  RelicConfig_70784_Name = {
    Text = "<WhiteQuality:Alfonso'nun Eseri>"
  },
  RelicConfig_70784_StoryDesc = {
    Text = "Öngörülemez kaderin aksine, yıldızlar kendi yasalarına uyar."
  },
  RelicConfig_70785_BattleDesc = {
    Text = "Aynı turda art arda 4 farklı Uyananın Komut Kartı oynandığında, tüm Uyananlar [Arg1] Aliemus kazanır. 3 turluk bekleme süresi."
  },
  RelicConfig_70785_Desc = {
    Text = "Aynı turda art arda 4 farklı Uyananın Komut Kartı oynandığında, tüm Uyananlar [Arg1] Aliemus kazanır. 3 turluk bekleme süresi."
  },
  RelicConfig_70785_Name = {
    Text = "<OrangeQuality:İsimsiz Tanrının Peçesi+>"
  },
  RelicConfig_70785_StoryDesc = {
    Text = "Tanrılara doğrudan bakma."
  },
  RelicConfig_70786_BattleDesc = {
    Text = "Tur sonunda, eğer Yükselen Dalgalar duruşundaysan, [Arg1] <TentacleInjurieIconKeywords:Dokunaç Hasarı> kazan; 3 turluk bekleme süresi."
  },
  RelicConfig_70786_Desc = {
    Text = "Tur sonunda, eğer Yükselen Dalgalar duruşundaysan, [Arg1] <TentacleInjurieIconKeywords:Dokunaç Hasarı> kazan; 3 turluk bekleme süresi."
  },
  RelicConfig_70786_Name = {
    Text = "<WhiteQuality:Yarık Baş Kurdu>"
  },
  RelicConfig_70786_StoryDesc = {
    Text = "Beynimiz bir sır olarak kaldığı sürece, içlerinin dokunaçlarla dolu olması o kadar da önemli değil."
  },
  RelicConfig_70787_BattleDesc = {
    Text = "Tüm Uyananların Temel Hasarı [Arg1]% artar."
  },
  RelicConfig_70787_Desc = {
    Text = "Tüm Uyananların Temel Hasarı [Arg1]% artar."
  },
  RelicConfig_70787_Name = {
    Text = "<OrangeQuality:Ağlayan Pipo+>"
  },
  RelicConfig_70787_StoryDesc = {
    Text = "Bu, nefretin ürünü mü, yoksa intikamın sonucu mu?"
  },
  RelicConfig_70788_BattleDesc = {
    Text = "Keyflare Uyanışı kullandıktan sonra tüm Uyanışçılar [Arg1] Aliemus ve [Arg2] Keyflare kazanır."
  },
  RelicConfig_70788_Desc = {
    Text = "Keyflare Uyanışı kullandıktan sonra tüm Uyanışçılar [Arg1] Aliemus ve [Arg2] Keyflare kazanır."
  },
  RelicConfig_70788_Name = {
    Text = "<WhiteQuality:Defne Yaprağı Kol Düğmeleri>"
  },
  RelicConfig_70788_StoryDesc = {
    Text = "Üzerine zeytin çiçeği yaprağı desenleri işlenmiş gümüş kol düğmeleri.\nİnce işçilikli ve ışıl ışıl; bir zamanlar iki çocuğun dostluğunu cisimleştiriyorlardı."
  },
  RelicConfig_70789_BattleDesc = {
    Text = "Savaş başladıktan sonra, [Arg1] <ProficientInRealmsIconKeywords:Diyar Ustalığı> kazan. Tüm Uyandıran ve Kalıntı <IntoxicationIconKeywords:Zehir> Etkileri +[Arg2]%."
  },
  RelicConfig_70789_Desc = {
    Text = "Savaş başladıktan sonra, [Arg1] <ProficientInRealmsIconKeywords:Diyar Ustalığı> kazan. Tüm Uyandıran ve Kalıntı <IntoxicationIconKeywords:Zehir> Etkileri +[Arg2]%."
  },
  RelicConfig_70789_Name = {
    Text = "<WhiteQuality:Tozlanmış Dokuma Tezgâhı>"
  },
  RelicConfig_70789_StoryDesc = {
    Text = "Şefkatli bir anne, kalbin yaralarını diker."
  },
  RelicConfig_70790_BattleDesc = {
    Text = "Yok Oluş, en düşük Aliemus’a sahip Uyanışçıya [Arg1] Aliemus verir; bekleme süresi 3 turdur."
  },
  RelicConfig_70790_Desc = {
    Text = "Yok Oluş, en düşük Aliemus’a sahip Uyanışçıya [Arg1] Aliemus verir; bekleme süresi 3 turdur."
  },
  RelicConfig_70790_Name = {
    Text = "<OrangeQuality:Zaman Skarabe+>"
  },
  RelicConfig_70790_StoryDesc = {
    Text = "Hem bir saat mağazasında hem de bir böcek müzesinde bulunmuş bir cep saati.\nTufan’dan beri üniversitenin koleksiyonuna dâhil edilmiştir."
  },
  RelicConfig_70791_BattleDesc = {
    Text = "Savaş başında, Dokunaç Sınırı +[Arg1], [Arg2] Dokunaç kazan."
  },
  RelicConfig_70791_Desc = {
    Text = "Savaş başında, Dokunaç Sınırı +[Arg1], [Arg2] Dokunaç kazan."
  },
  RelicConfig_70791_Name = {
    Text = "<OrangeQuality:Deniz İlahisi+>"
  },
  RelicConfig_70791_StoryDesc = {
    Text = "Yenmeyen deniz canlıları, örneğin deniz salyangozları, okyanusun besinlerinin yaklaşık %80'ini absorbe eder denir."
  },
  RelicConfig_70792_BattleDesc = {
    Text = "Tur sonunda, eğer Yükselen Dalgalar duruşundaysan, [Arg1] <TentacleInjurieIconKeywords:Dokunaç Hasarı> kazan; 3 turluk bekleme süresi."
  },
  RelicConfig_70792_Desc = {
    Text = "Tur sonunda, eğer Yükselen Dalgalar duruşundaysan, [Arg1] <TentacleInjurieIconKeywords:Dokunaç Hasarı> kazan; 3 turluk bekleme süresi."
  },
  RelicConfig_70792_Name = {
    Text = "<OrangeQuality:Yarık Baş Kurdu+>"
  },
  RelicConfig_70792_StoryDesc = {
    Text = "Beynimiz bir sır olarak kaldığı sürece, içlerinin dokunaçlarla dolu olması o kadar da önemli değil."
  },
  RelicConfig_70793_BattleDesc = {
    Text = "Her turda, <DevouredIconKeywords:Yutma> ilk kez tetiklendiğinde, diğer Uyandıran [Arg1] Aliemus kazanır."
  },
  RelicConfig_70793_Desc = {
    Text = "Her turda, <DevouredIconKeywords:Yutma> ilk kez tetiklendiğinde, diğer Uyandıran [Arg1] Aliemus kazanır."
  },
  RelicConfig_70793_Name = {
    Text = "<OrangeQuality:Altın Düş Diyarı+>"
  },
  RelicConfig_70793_StoryDesc = {
    Text = "Dönüşüm günü, senin kıyametin olacak."
  },
  RelicConfig_70794_BattleDesc = {
    Text = "Yok Oluş’tan [Arg1] Karakter Kalkanı kazan; bekleme süresi 3 turdur."
  },
  RelicConfig_70794_Desc = {
    Text = "Yok Oluş’tan [Arg1] Karakter Kalkanı kazan; bekleme süresi 3 turdur."
  },
  RelicConfig_70794_Name = {
    Text = "<OrangeQuality:Süpertelli Cep Saati+>"
  },
  RelicConfig_70794_StoryDesc = {
    Text = "“Ah hayır, cep saati durdu.”"
  },
  RelicConfig_70795_BattleDesc = {
    Text = "Türetilmemiş bir Komut Kartı oynandıktan sonra, Çekme Desteğine Arithmetica Maliyeti 2 azaltılmış o karttan [Arg1] adet geçici kopya karıştır. Bekleme süresi: 3 tur."
  },
  RelicConfig_70795_Desc = {
    Text = "Türetilmemiş bir Komut Kartı oynandıktan sonra, Çekme Desteğine Arithmetica Maliyeti 2 azaltılmış o karttan [Arg1] adet geçici kopya karıştır. Bekleme süresi: 3 tur."
  },
  RelicConfig_70795_Name = {
    Text = "<WhiteQuality:Sessiz Gramofon>"
  },
  RelicConfig_70795_StoryDesc = {
    Text = "Sesi rüzgâra karışıp soldu."
  },
  RelicConfig_70796_BattleDesc = {
    Text = "\"Taşkınlık\" serbest bırakıldıktan sonra, tüm düşmanlar [Arg1] <FixedDamage:Saf Hasar> alır ve %[Arg2] <IntoxicationIconKeywords:Zehir> tetiklenir."
  },
  RelicConfig_70796_Desc = {
    Text = "\"Taşkınlık\" serbest bırakıldıktan sonra, tüm düşmanlar takımın Maksimum canının [Arg2]%'sine eşit 1 kez <FixedDamage:Saf Hasar> alır ve %[Arg2] <IntoxicationIconKeywords:Zehir> tetiklenir."
  },
  RelicConfig_70796_Name = {
    Text = "<OrangeQuality:Radyum Çene Kemiği+>"
  },
  RelicConfig_70796_StoryDesc = {
    Text = "Özel bir koleksiyoncunun sergi odasında teşhir edilirdi.\nKoleksiyoncuyu güzel floresansı büyülemişti; gece gündüz onu seyretti, ta ki sonunda solup giderek onun türünden biri olana dek."
  },
  RelicConfig_70797_BattleDesc = {
    Text = "Maksimum Arithmetica +[Arg1]."
  },
  RelicConfig_70797_Desc = {
    Text = "Maksimum Arithmetica +[Arg1]."
  },
  RelicConfig_70797_Name = {
    Text = "<WhiteQuality:Canlılık Enjeksiyonu>"
  },
  RelicConfig_70797_StoryDesc = {
    Text = "Seğirme de bir tür Canlılıktır."
  },
  RelicConfig_70798_BattleDesc = {
    Text = "Azgın Dalgalar duruşunu kullanarak tüm Dokunaç Saldırılarını düşmanlar üzerinde anında [Arg1] kez etkinleştir; 3 turluk bekleme süresi."
  },
  RelicConfig_70798_Desc = {
    Text = "Azgın Dalgalar duruşunu kullanarak tüm Dokunaç Saldırılarını düşmanlar üzerinde anında [Arg1] kez etkinleştir; 3 turluk bekleme süresi."
  },
  RelicConfig_70798_Name = {
    Text = "<OrangeQuality:Lemuria'nın Hazzı+>"
  },
  RelicConfig_70798_StoryDesc = {
    Text = "Ebedi Uykuya Dalış’ın Efendisi, rüyalarında seni bekliyor."
  },
  RelicConfig_70799_BattleDesc = {
    Text = "“Savunma” oynandığında, her turda en fazla 3 kez tetiklenecek şekilde [Arg1] Geçici<RetaliateIconKeywords:Sayaç> kazan."
  },
  RelicConfig_70799_Desc = {
    Text = "“Savunma” oynandığında, her turda en fazla 3 kez tetiklenecek şekilde [Arg1] Geçici<RetaliateIconKeywords:Sayaç> kazan."
  },
  RelicConfig_70799_Name = {
    Text = "<OrangeQuality:Merhumun Cep Saati+>"
  },
  RelicConfig_70799_StoryDesc = {
    Text = "Anıları ve ağıtı sırtlayıp bilinmeyen yaratığa doğru ilerliyor."
  },
  RelicConfig_70800_BattleDesc = {
    Text = "“Savunma” oynandığında, her turda en fazla 3 kez tetiklenecek şekilde [Arg1] Geçici<RetaliateIconKeywords:Sayaç> kazan."
  },
  RelicConfig_70800_Desc = {
    Text = "“Savunma” oynandığında, her turda en fazla 3 kez tetiklenecek şekilde [Arg1] Geçici<RetaliateIconKeywords:Sayaç> kazan."
  },
  RelicConfig_70800_Name = {
    Text = "<WhiteQuality:Merhumun Cep Saati>"
  },
  RelicConfig_70800_StoryDesc = {
    Text = "Anıları ve ağıtı sırtlayıp bilinmeyen yaratığa doğru ilerliyor."
  },
  RelicConfig_70986_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırını 1 artır ve tüm Uyananları Uyandır. Tek sayılı turların başında, 2 Kalıntı arasından 1'ini seçip elde et; 5 tek sayılı tur boyunca sürer."
  },
  RelicConfig_70986_Desc = {
    Text = "Savaşın başında Arithmetica Sınırını 1 artır ve tüm Uyananları Uyandır. Tek sayılı turların başında, 2 Kalıntı arasından 1'ini seçip elde et; 5 tek sayılı tur boyunca sürer."
  },
  RelicConfig_70986_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Dilek η\">"
  },
  RelicConfig_70987_BattleDesc = {
    Text = "Savaşın başında Arithmetica Sınırını 1 artır ve tüm Uyananları Uyandır. Tek sayılı turların başında, 2 Kalıntı arasından 1'ini seçip elde et; 5 tek sayılı tur boyunca sürer."
  },
  RelicConfig_70987_Desc = {
    Text = "Savaşın başında Arithmetica Sınırını 1 artır ve tüm Uyananları Uyandır. Tek sayılı turların başında, 2 Kalıntı arasından 1'ini seçip elde et; 5 tek sayılı tur boyunca sürer."
  },
  RelicConfig_70987_Name = {
    Text = "<OrangeQuality:Krono Sarkaç \"Dilek ζ\">"
  },
  RelicConfig_71195_BattleDesc = {
    Text = "Tur başında Ramona: Zaman Aşınmış [Arg1] Aliemus kazanır. Her turda \"Döngü\" ilk kez tetiklendiğinde, [Arg2] Keyflare ve [Arg3] yığın \"Negentropi\" kazan."
  },
  RelicConfig_71195_Desc = {
    Text = "Tur başında Ramona: Zaman Aşınmış [Arg1] Aliemus kazanır. Her turda \"Döngü\" ilk kez tetiklendiğinde, [Arg2] Keyflare ve [Arg3] yığın \"Negentropi\" kazan."
  },
  RelicConfig_71195_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Ramona: Zaman Aşınmış>"
  },
  RelicConfig_71196_BattleDesc = {
    Text = "Tur başında Lotan [Arg1] Aliemus kazanır. Her turda Lotan’ın \"Savunma\" sı ilk kez oynandıktan sonra, ele [Arg2] ek Tüketme ve Geçici \"İsyan Kılıcı\" yerleştir."
  },
  RelicConfig_71196_Desc = {
    Text = "Tur başında Lotan [Arg1] Aliemus kazanır. Her turda Lotan’ın \"Savunma\" sı ilk kez oynandıktan sonra, ele [Arg2] ek Tüketme ve Geçici \"İsyan Kılıcı\" yerleştir."
  },
  RelicConfig_71196_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Lotan>"
  },
  RelicConfig_71197_BattleDesc = {
    Text = "Tur başında Ramona [Arg1] Aliemus kazanır. Ramona tarafından oynanan her [Arg2]. Komut Kartı, 1 kez ek olarak etki eder ve [Arg3] Keyflare kazanır."
  },
  RelicConfig_71197_Desc = {
    Text = "Tur başında Ramona [Arg1] Aliemus kazanır. Ramona tarafından oynanan her [Arg2]. Komut Kartı, 1 kez ek olarak etki eder ve [Arg3] Keyflare kazanır."
  },
  RelicConfig_71197_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Ramona>"
  },
  RelicConfig_71230_BattleDesc = {
    Text = "Tur başında Leigh [Arg1] Aliemus kazanır. Her Can kaybedildiğinde [Arg2] Güç kazanır, her savaşta en fazla [Arg3] kez yığınlanır. [Arg3] kez yığınlandıktan sonra, \"Izdırap ve Haz\" Temel Arithmetica Maliyeti 2 azalır, Hasar sayısı 1 artar."
  },
  RelicConfig_71230_Desc = {
    Text = "Tur başında Leigh [Arg1] Aliemus kazanır. Her Can kaybedildiğinde [Arg2] Güç kazanır, her savaşta en fazla [Arg3] kez yığınlanır. [Arg3] kez yığınlandıktan sonra, \"Izdırap ve Haz\" Temel Arithmetica Maliyeti 2 azalır, Hasar sayısı 1 artar."
  },
  RelicConfig_71230_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Leigh>"
  },
  RelicConfig_71231_BattleDesc = {
    Text = "Tur başında Aurita [Arg1] Aliemus kazanır. \"Bez Bölünmesi\" nin Hasar sayısı [Arg2] artar ve Aurita’nın \"Savunma\" sı oynandıktan sonra, Elde 1 \"Bez Bölünmesi\" belirir."
  },
  RelicConfig_71231_Desc = {
    Text = "Tur başında Aurita [Arg1] Aliemus kazanır. \"Bez Bölünmesi\" nin Hasar sayısı [Arg2] artar ve Aurita’nın \"Savunma\" sı oynandıktan sonra, Elde 1 \"Bez Bölünmesi\" belirir."
  },
  RelicConfig_71231_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Aurita>"
  },
  RelicConfig_71232_BattleDesc = {
    Text = "Tur başında Tinct [Arg1] Aliemus kazanır. Tinct'in Komut Kartı ile bir Sıçrama tetikledikten sonra, onu ele geri döndür ve oynamadan önce Arithmetica Maliyetini 1 azalt. Bu etki tur başına en fazla [Arg2] kez gerçekleşebilir."
  },
  RelicConfig_71232_Desc = {
    Text = "Tur başında Tinct [Arg1] Aliemus kazanır. Tinct'in Komut Kartı ile bir Sıçrama tetikledikten sonra, onu ele geri döndür ve oynamadan önce Arithmetica Maliyetini 1 azalt. Bu etki tur başına en fazla [Arg2] kez gerçekleşebilir."
  },
  RelicConfig_71232_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Tinct>"
  },
  RelicConfig_71233_BattleDesc = {
    Text = "Tur başında Nautila [Arg1] Aliemus kazanır. Nautila’nın \"Yücelt\" ini kullandıktan sonra, mevcut Kalkanın [Arg2]%’üne eşit Sayaç ve Gecikmeli Kalkan kazan; tur başına en fazla bir kez tetiklenir."
  },
  RelicConfig_71233_Desc = {
    Text = "Tur başlangıcında Nautila [Arg1] Aliemus kazanır. Nautila'nın \"Taşkınlık\" yeteneğini kullandıktan sonra, mevcut Kalkanın %[Arg2]'sine eşit Karşı Saldırı ve Gecikmeli Kalkan kazan, tur başına en fazla bir kez tetiklenir."
  },
  RelicConfig_71233_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Nautila>"
  },
  RelicConfig_71234_BattleDesc = {
    Text = "Tur başında Doll: Cehennem [Arg1] Aliemus kazanır. Doll: Cehennem Yücelt’i serbest bıraktıktan sonra, tüketilen her [Arg2] Aliemus için diğer Uyananlar 1 Aliemus kazanır."
  },
  RelicConfig_71234_Desc = {
    Text = "Tur başlangıcında Doll: Cehennem [Arg1] Aliemus kazanır. Doll: Cehennem Taşkınlık kullandıktan sonra, harcanan her [Arg2] Aliemus için diğer Uyandırıcılar 1 Aliemus kazanır."
  },
  RelicConfig_71234_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Doll: Cehennem>"
  },
  RelicConfig_71235_BattleDesc = {
    Text = "Tur başında Helot [Arg1] Aliemus kazanır. Her kart atıldığında Helot [Arg2] Aliemus kazanır."
  },
  RelicConfig_71235_Desc = {
    Text = "Tur başında Helot [Arg1] Aliemus kazanır. Her kart atıldığında Helot [Arg2] Aliemus kazanır."
  },
  RelicConfig_71235_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Helot>"
  },
  RelicConfig_71236_BattleDesc = {
    Text = "Tur başında Nergis [Arg1] Aliemus ve 1 \"İdrak\" kartı kazanır. \"Heterojen Gelgitler\"den kazanılan GÜÇ [Arg2]% artar ve oynanan her kart, bu keşif süresince onu kalıcı olarak [Arg3]% daha artırır, en fazla [Arg4]%’e kadar."
  },
  RelicConfig_71236_Desc = {
    Text = "Tur başında Nergis [Arg1] Aliemus ve 1 \"İdrak\" kartı kazanır. \"Heterojen Gelgitler\"den kazanılan GÜÇ [Arg2]% artar ve oynanan her kart, bu keşif süresince onu kalıcı olarak [Arg3]% daha artırır, en fazla [Arg4]%’e kadar."
  },
  RelicConfig_71236_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Nergis>"
  },
  RelicConfig_71237_BattleDesc = {
    Text = "Tur başında Wanda [Arg1] Aliemus ve [Arg2] yığın \"Düş Yemi\" kazanır. Eğer bu bir Ultra Tur ise, ayrıca ele 1 Geçici \"Omurga İğnesi Zincirleri\" ve \"Kayıpların Koruyucusu\" koy ve Wanda'nın bir sonraki Komut Kartı'nın 2 kez etkisini göstermesini sağla."
  },
  RelicConfig_71237_Desc = {
    Text = "Tur başında Wanda [Arg1] Aliemus ve [Arg2] yığın \"Düş Yemi\" kazanır. Eğer bu bir Ultra Tur ise, ayrıca ele 1 Geçici \"Omurga İğnesi Zincirleri\" ve \"Kayıpların Koruyucusu\" koy ve Wanda'nın bir sonraki Komut Kartı'nın 2 kez etkisini göstermesini sağla."
  },
  RelicConfig_71237_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Wanda>"
  },
  RelicConfig_71238_BattleDesc = {
    Text = "Tur başında Agrippa [Arg1] Aliemus kazanır. \"Gönülsüz Sadaka\" bu tur için Agrippa’nın Arithmetica Maliyeti’ni ayrıca [Arg2] azaltır; tur başına en fazla bir kez etkili olur."
  },
  RelicConfig_71238_Desc = {
    Text = "Tur başında Agrippa [Arg1] Aliemus kazanır. \"Gönülsüz Sadaka\" bu tur için Agrippa’nın Arithmetica Maliyeti’ni ayrıca [Arg2] azaltır; tur başına en fazla bir kez etkili olur."
  },
  RelicConfig_71238_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Agrippa>"
  },
  RelicConfig_71239_BattleDesc = {
    Text = "Tur başında \"24\"[Arg1] Aliemus kazanır. Eğer tur başında \"24\"\"Depresif Kişilik\" durumundaysa, ek [Arg2] Aliemus kazanır; eğer \"Manik Kişilik\" durumundaysa, \"24\"ün Geçici Kritik Oranı ve Geçici Kritik Hasarı +[Arg2]% olur."
  },
  RelicConfig_71239_Desc = {
    Text = "Tur başında \"24\"[Arg1] Aliemus kazanır. Eğer tur başında \"24\"\"Depresif Kişilik\" durumundaysa, ek [Arg2] Aliemus kazanır; eğer \"Manik Kişilik\" durumundaysa, \"24\"ün Geçici Kritik Oranı ve Geçici Kritik Hasarı +[Arg2]% olur."
  },
  RelicConfig_71239_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: \"24\">"
  },
  RelicConfig_71240_BattleDesc = {
    Text = "Tur başında Liz [Arg1] Aliemus kazanır. \"Yıkıma Dans\" tarafından atılan kartlar, 3 turluk bekleme süresiyle 1 kez daha etkisini gösterir."
  },
  RelicConfig_71240_Desc = {
    Text = "Tur başında Liz [Arg1] Aliemus kazanır. \"Yıkıma Dans\" tarafından atılan kartlar, 3 turluk bekleme süresiyle 1 kez daha etkisini gösterir."
  },
  RelicConfig_71240_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Liz>"
  },
  RelicConfig_71241_BattleDesc = {
    Text = "Tur başında Helot: Catena [Arg1] Aliemus kazanır. Helot: Catena’nın Aktif Hasarı [Arg2]% Kanama ekler ve bir düşmanı öldürmek, diğer düşmanların fazladan verilen Hasar kadar Kanama almasına neden olur."
  },
  RelicConfig_71241_Desc = {
    Text = "Tur başlangıcında Helot-catena [Arg1] Aliemus kazanır. Helot-catena'nın Aktif Hasarı %[Arg2] Kanama ekler ve bir düşmanı öldürmek, fazla Hasara eşit Kanamayı diğer düşmanlara uygular."
  },
  RelicConfig_71241_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Helot: Catena>"
  },
  RelicConfig_71242_BattleDesc = {
    Text = "Tur başında, Celeste [Arg1] Aliemus kazanır. Tur bitmeden önce, eldeki her bir Celeste Komut Kartı için 1 Dokunaç bir düşmana saldırır ve [Heal:Arg2] HP yeniler."
  },
  RelicConfig_71242_Desc = {
    Text = "Tur başında, Celeste [Arg1] Aliemus kazanır. Tur bitmeden önce, eldeki her bir Celeste Komut Kartı için 1 Dokunaç bir düşmana saldırır ve [Heal:Arg2] HP yeniler."
  },
  RelicConfig_71242_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Celeste>"
  },
  RelicConfig_71243_BattleDesc = {
    Text = "Tur başında Casiah [Arg1] Aliemus kazanır. 1 kart çekmek Casiah'a [Arg2] Aliemus kazandırır. Casiah Yüceltim açığa çıkardığında, tüm düşmanlar [Arg3] GÜÇ kaybeder."
  },
  RelicConfig_71243_Desc = {
    Text = "Tur başında Casiah [Arg1] Aliemus kazanır. 1 kart çekmek Casiah'a [Arg2] Aliemus kazandırır. Casiah Yüceltim açığa çıkardığında, tüm düşmanlar [Arg3] GÜÇ kaybeder."
  },
  RelicConfig_71243_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Casiah>"
  },
  RelicConfig_71244_BattleDesc = {
    Text = "Tur başlangıcında, Sorel [Arg1] Aliemus kazanır. Sorel'in verdiği her Hasar örneği için, Embriyo Füzyonu +[Arg2], tur başına en fazla [Arg3] <plural value=\"[Arg3]\" singular=\"kez\" plural=\"kez\">. 10 kez tetiklendikten sonra, Sorel'in bu savaştaki Final Hasar'ı +[Arg4]%."
  },
  RelicConfig_71244_Desc = {
    Text = "Tur başlangıcında, Sorel [Arg1] Aliemus kazanır. Sorel'in verdiği her Hasar örneği için, Embriyo Füzyonu +[Arg2], tur başına en fazla [Arg3] <plural value=\"[Arg3]\" singular=\"kez\" plural=\"kez\">. 10 kez tetiklendikten sonra, Sorel'in bu savaştaki Final Hasar'ı +[Arg4]%."
  },
  RelicConfig_71244_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Sorel>"
  },
  RelicConfig_71245_BattleDesc = {
    Text = "Tur başında, Ogier [Arg1] Aliemus kazanır. Ogier her turda ilk kez \"Delici Mızrak\" veya \"Strike\" oynadıktan sonra, o turda ürettiği Kalkan ve STR +%[Arg2] artar."
  },
  RelicConfig_71245_Desc = {
    Text = "Tur başında, Ogier [Arg1] Aliemus kazanır. Ogier her turda ilk kez \"Delici Mızrak\" veya \"Strike\" oynadıktan sonra, o turda ürettiği Kalkan ve STR +%[Arg2] artar."
  },
  RelicConfig_71245_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Ogier>"
  },
  RelicConfig_71246_BattleDesc = {
    Text = "Tur başında Alva [Arg1] Aliemus kazanır. 1 tur içinde, [Arg2]. \"Savunma\" kartı oynandıktan sonra, Elde tüketilmiş bir \"Kalp Gözü Bıçağı\" belirir; [Arg3]. \"Saldırı\" kartı oynandıktan sonra, Elde tüketilmiş bir \"Savaş Duruşu\" belirir."
  },
  RelicConfig_71246_Desc = {
    Text = "Tur başında Alva [Arg1] Aliemus kazanır. 1 tur içinde, [Arg2]. \"Savunma\" kartı oynandıktan sonra, Elde tüketilmiş bir \"Kalp Gözü Bıçağı\" belirir; [Arg3]. \"Saldırı\" kartı oynandıktan sonra, Elde tüketilmiş bir \"Savaş Duruşu\" belirir."
  },
  RelicConfig_71246_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Alva>"
  },
  RelicConfig_71247_BattleDesc = {
    Text = "Tur başında Jenkin [Arg1] Aliemus kazanır ve Final Hasarı +[Arg2]% olur. \"Get 'em! Brown!\"ın Temel Hasarı ve Hasar büyümesi +[Arg3]% artar."
  },
  RelicConfig_71247_Desc = {
    Text = "Tur başında Jenkin [Arg1] Aliemus kazanır ve Final Hasarı +[Arg2]% olur. \"Get 'em! Brown!\"ın Temel Hasarı ve Hasar büyümesi +[Arg3]% artar."
  },
  RelicConfig_71247_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Jenkin>"
  },
  RelicConfig_71248_BattleDesc = {
    Text = "Tur başında Doll [Arg1] Aliemus kazanır. Savaş başladıktan sonra, Doll’un \"Eşdeğer Borsa\" sının Arithmetica Maliyetini 0’a ayarla. Oynandıktan sonra, bir sonraki turda ek [Arg2] kart çek."
  },
  RelicConfig_71248_Desc = {
    Text = "Tur başında Doll [Arg1] Aliemus kazanır. Savaş başladıktan sonra, Doll’un \"Eşdeğer Borsa\" sının Arithmetica Maliyetini 0’a ayarla. Oynandıktan sonra, bir sonraki turda ek [Arg2] kart çek."
  },
  RelicConfig_71248_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Doll>"
  },
  RelicConfig_71249_BattleDesc = {
    Text = "Tur başlangıcında Ryker [Arg1] Aliemus kazanır. Her turda ilk zar atışının sonucu her zaman 6 olur."
  },
  RelicConfig_71249_Desc = {
    Text = "Tur başlangıcında Ryker [Arg1] Aliemus kazanır. Her turda ilk zar atışının sonucu her zaman 6 olur."
  },
  RelicConfig_71249_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Ryker>"
  },
  RelicConfig_71250_BattleDesc = {
    Text = "Tur başında Miryam [Arg1] Aliemus kazanır ve Elde 1 \"Ayin\" belirir."
  },
  RelicConfig_71250_Desc = {
    Text = "Tur başında Miryam [Arg1] Aliemus kazanır ve Elde 1 \"Ayin\" belirir."
  },
  RelicConfig_71250_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Miryam>"
  },
  RelicConfig_71251_BattleDesc = {
    Text = "Tur başında Winkle [Arg1] Aliemus kazanır. Başka bir Uyanan Yüceltim açığa çıkardığında, Winkle [Arg2] Aliemus kazanır ve eldeki \"Yeniden Dövülmüş Psişe\"nin Arithmetica Maliyeti [Arg3] azalır."
  },
  RelicConfig_71251_Desc = {
    Text = "Tur başında Winkle [Arg1] Aliemus kazanır. Başka bir Uyanan Yüceltim açığa çıkardığında, Winkle [Arg2] Aliemus kazanır ve eldeki \"Yeniden Dövülmüş Psişe\"nin Arithmetica Maliyeti [Arg3] azalır."
  },
  RelicConfig_71251_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Winkle>"
  },
  RelicConfig_71252_BattleDesc = {
    Text = "Tur başında, Tulu [Arg1] Aliemus kazanır. Tulu'nun Temel Aliemus'u -[Arg2] olur ve Yüceltmeyi serbest bıraktıktan sonra anında [Arg3] Geçici Dokunaç üretir."
  },
  RelicConfig_71252_Desc = {
    Text = "Tur başında, Tulu [Arg1] Aliemus kazanır. Tulu'nun Temel Aliemus'u -[Arg2] olur ve Yüceltmeyi serbest bıraktıktan sonra anında [Arg3] Geçici Dokunaç üretir."
  },
  RelicConfig_71252_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Tulu>"
  },
  RelicConfig_71253_BattleDesc = {
    Text = "Tur başında Faint [Arg1] Aliemus kazanır. Faint'in Kalkan Üretimi, Sayaç ve HP Yenilenmesi +[Arg2]%. Her Ölüm Direnci tetiklendiğinde, bu keşif süresince bu etki [Arg3]% artar, en fazla [Arg4] kez."
  },
  RelicConfig_71253_Desc = {
    Text = "Tur başında Faint [Arg1] Aliemus kazanır. Faint'in Kalkan Üretimi, Sayaç ve HP Yenilenmesi +[Arg2]%. Her Ölüm Direnci tetiklendiğinde, bu keşif süresince bu etki [Arg3]% artar, en fazla [Arg4] kez."
  },
  RelicConfig_71253_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Faint>"
  },
  RelicConfig_71254_BattleDesc = {
    Text = "Tur başında Tawil [Arg1] Aliemus kazanır. Bir turda Tawil’in [Arg2] Komut Kartı oynanırsa, ele 1 adet <DerivativeCardKeywords_67:<DerivativeCardKeywords_67:\"Gümüş Anahtar Şafağı\">> ekle. Bekleme süresi: [Arg3] tur."
  },
  RelicConfig_71254_Desc = {
    Text = "Tur başında Tawil [Arg1] Aliemus kazanır. Bir turda Tawil’in [Arg2] Komut Kartı oynanırsa, ele 1 adet <DerivativeCardKeywords_67:<DerivativeCardKeywords_67:\"Gümüş Anahtar Şafağı\">> ekle. Bekleme süresi: [Arg3] tur."
  },
  RelicConfig_71254_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Tawil>"
  },
  RelicConfig_71255_BattleDesc = {
    Text = "Tur başında Hameln [Arg1] Aliemus kazanır. \"Ruh Uvertürü\" Temel Arithmetica Maliyeti [Arg2] azalır, Temel Hasar sayısı [Arg3] artar."
  },
  RelicConfig_71255_Desc = {
    Text = "Tur başında Hameln [Arg1] Aliemus kazanır. \"Ruh Uvertürü\" Temel Arithmetica Maliyeti [Arg2] azalır, Temel Hasar sayısı [Arg3] artar."
  },
  RelicConfig_71255_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Hameln>"
  },
  RelicConfig_71256_BattleDesc = {
    Text = "Tur başında Horla [Arg1] Aliemus kazanır. Savaşın başında, tüm duygular için [Arg2] yığın \"Metafor\" kazan, \"Metafor\" etkisini %50 artır."
  },
  RelicConfig_71256_Desc = {
    Text = "Tur başında Horla [Arg1] Aliemus kazanır. Savaşın başında, tüm duygular için [Arg2] yığın \"Metafor\" kazan, \"Metafor\" etkisini %50 artır."
  },
  RelicConfig_71256_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Horla>"
  },
  RelicConfig_71257_BattleDesc = {
    Text = "Tur başında Murphy [Arg1] Aliemus kazanır. Murphy’nin \"Saldırı\" ve \"Savunma\" sı, \"Kurban\"ın [Arg2]%’sini Geçici Dokunaç Hasarı’na dönüştürebilir, ancak tur başına yalnızca bir kez etkili olabilir."
  },
  RelicConfig_71257_Desc = {
    Text = "Tur başında Murphy [Arg1] Aliemus kazanır. Murphy’nin \"Saldırı\" ve \"Savunma\" sı, \"Kurban\"ın [Arg2]%’sini Geçici Dokunaç Hasarı’na dönüştürebilir, ancak tur başına yalnızca bir kez etkili olabilir."
  },
  RelicConfig_71257_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Murphy>"
  },
  RelicConfig_71258_BattleDesc = {
    Text = "Tur başında, Uvhash [Arg1] Aliemus kazanır. Uvhash'in Temel Aliemus'u -[Arg2] olur ve her Yüceltme serbest bırakışında ayrıca 5 azalır. Tur başına [Arg3] kez Yüceltme serbest bırakabilir."
  },
  RelicConfig_71258_Desc = {
    Text = "Tur başında, Uvhash [Arg1] Aliemus kazanır. Uvhash'in Temel Aliemus'u -[Arg2] olur ve her Yüceltme serbest bırakışında ayrıca 5 azalır. Tur başına [Arg3] kez Yüceltme serbest bırakabilir."
  },
  RelicConfig_71258_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Uvhash>"
  },
  RelicConfig_71259_BattleDesc = {
    Text = "Tur başında Aigis [Arg1] Aliemus kazanır. Aigis Savunmasız düşmanlara DMG verdiğinde, ayrıca tur başına en fazla [Arg3] kez olmak üzere [Arg2] Geçici GÜÇ çalar."
  },
  RelicConfig_71259_Desc = {
    Text = "Tur başında Aigis [Arg1] Aliemus kazanır. Aigis Savunmasız düşmanlara DMG verdiğinde, ayrıca tur başına en fazla [Arg3] kez olmak üzere [Arg2] Geçici GÜÇ çalar."
  },
  RelicConfig_71259_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Aigis>"
  },
  RelicConfig_71260_BattleDesc = {
    Text = "Tur başında Thais [Arg1] Aliemus kazanır. 1 tur içinde [Arg2] Komut Kartı oynadıktan sonra Thais 1 \"Saflığın Varisi\" ve [Arg3] Geçici GÜÇ kazanır; bekleme süresi [Arg4] turdur."
  },
  RelicConfig_71260_Desc = {
    Text = "Tur başında Thais [Arg1] Aliemus kazanır. 1 tur içinde [Arg2] Komut Kartı oynadıktan sonra Thais 1 \"Saflığın Varisi\" ve [Arg3] Geçici GÜÇ kazanır; bekleme süresi [Arg4] turdur."
  },
  RelicConfig_71260_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Thais>"
  },
  RelicConfig_71261_BattleDesc = {
    Text = "Tur başında Faros [Arg1] Aliemus kazanır. Verilen her 2 Dokunaç Hasarı için, bu savaşta Faros’un Zehir ve Kalkan Üretimi [Arg2]% artar; en fazla %50’ye kadar."
  },
  RelicConfig_71261_Desc = {
    Text = "Tur başında Faros [Arg1] Aliemus kazanır. Verilen her 2 Dokunaç Hasarı için, bu savaşta Faros’un Zehir ve Kalkan Üretimi [Arg2]% artar; en fazla %50’ye kadar."
  },
  RelicConfig_71261_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Faros>"
  },
  RelicConfig_71262_BattleDesc = {
    Text = "Tur başında Pandia [Arg1] Aliemus kazanır. Pandia bir Uluya gerçekleştirdikten sonra, Geçici Sayaçlarının [Arg2]%’ine eşdeğer Kalıcı Sayaç kazanır."
  },
  RelicConfig_71262_Desc = {
    Text = "Tur başında Pandia [Arg1] Aliemus kazanır. Pandia bir Uluya gerçekleştirdikten sonra, Geçici Sayaçlarının [Arg2]%’ine eşdeğer Kalıcı Sayaç kazanır."
  },
  RelicConfig_71262_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Pandia>"
  },
  RelicConfig_71263_BattleDesc = {
    Text = "Tur başında Lily [Arg1] Aliemus kazanır. Lily’nin Dayan limitinin sınırı %100 artar ve \"Balçık üzerinde çiçek\" ya da \"Koruma Darbesi\" ni serbest bıraktığında, \"Dayan\" yığınlarının %8’ine eşit HP yeniler."
  },
  RelicConfig_71263_Desc = {
    Text = "Tur başında Lily [Arg1] Aliemus kazanır. Lily’nin Dayan limitinin sınırı %100 artar ve \"Balçık üzerinde çiçek\" ya da \"Koruma Darbesi\" ni serbest bıraktığında, \"Dayan\" yığınlarının %8’ine eşit HP yeniler."
  },
  RelicConfig_71263_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Lily>"
  },
  RelicConfig_71264_BattleDesc = {
    Text = "Tur başında Karen [Arg1] Aliemus kazanır. \"Sessiz Sadakat\" oynamak, tüketilmiş Arithmetica’yı iki katı olarak geri döndürür; bekleme süresi [Arg2] turdur."
  },
  RelicConfig_71264_Desc = {
    Text = "Tur başında Karen [Arg1] Aliemus kazanır. \"Sessiz Sadakat\" oynamak, tüketilmiş Arithmetica’yı iki katı olarak geri döndürür; bekleme süresi [Arg2] turdur."
  },
  RelicConfig_71264_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Karen>"
  },
  RelicConfig_71265_BattleDesc = {
    Text = "Tur başında Salvador [Arg1] Aliemus kazanır. Ne zaman Kızıl Ocak biriktirirse, ayrıca biriken miktarın [Arg2]%’sine eşit GÜÇ kazanır. Salvador’un \"Saldırı\" sı ve \"Izdırabın Sonu\" ilave [Arg3]x GÜÇ bonusundan yararlanır."
  },
  RelicConfig_71265_Desc = {
    Text = "Tur başında Salvador [Arg1] Aliemus kazanır. Ne zaman Kızıl Ocak biriktirirse, ayrıca biriken miktarın [Arg2]%’sine eşit GÜÇ kazanır. Salvador’un \"Saldırı\" sı ve \"Izdırabın Sonu\" ilave [Arg3]x GÜÇ bonusundan yararlanır."
  },
  RelicConfig_71265_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Salvador>"
  },
  RelicConfig_71266_BattleDesc = {
    Text = "Tur başında Caecus [Arg1] Aliemus kazanır. Caecus bir kalkan kazandığında, Kalkan miktarının [Arg2]%’i kadar HP geri kazanır."
  },
  RelicConfig_71266_Desc = {
    Text = "Tur başında Caecus [Arg1] Aliemus kazanır. Caecus bir kalkan kazandığında, Kalkan miktarının [Arg2]%’i kadar HP geri kazanır."
  },
  RelicConfig_71266_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Caecus>"
  },
  RelicConfig_71267_BattleDesc = {
    Text = "Tur başında Nymphaea [Arg1] Aliemus kazanır. Nymphaea’nın \"Saldırı\" sı oynandıktan sonra, bu savaşta \"Nymphaea\" nın verdiği Zehir [Arg2]% artar. Nymphaea’nın \"Savunma\" sı oynandıktan sonra, tüm düşmanlara [Arg3]% Zehir tetikler. Her etki, tur başına en fazla bir kez gerçekleşebilir."
  },
  RelicConfig_71267_Desc = {
    Text = "Tur başında Nymphaea [Arg1] Aliemus kazanır. Nymphaea’nın \"Saldırı\" sı oynandıktan sonra, bu savaşta \"Nymphaea\" nın verdiği Zehir [Arg2]% artar. Nymphaea’nın \"Savunma\" sı oynandıktan sonra, tüm düşmanlara [Arg3]% Zehir tetikler. Her etki, tur başına en fazla bir kez gerçekleşebilir."
  },
  RelicConfig_71267_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Nymphaea>"
  },
  RelicConfig_71268_BattleDesc = {
    Text = "Tur başında Erica [Arg1] Aliemus kazanır. 1 tur içinde [Arg2] Komut Kartı oynadıktan sonra, Erica 2 Arithmetica kazanır ve bu savaşta \"Elektromanyetik Patlama\" için GÜÇ ve Alarm bonusunu ikiye katlar."
  },
  RelicConfig_71268_Desc = {
    Text = "Tur başında Erica [Arg1] Aliemus kazanır. 1 tur içinde [Arg2] Komut Kartı oynadıktan sonra, Erica 2 Arithmetica kazanır ve bu savaşta \"Elektromanyetik Patlama\" için GÜÇ ve Alarm bonusunu ikiye katlar."
  },
  RelicConfig_71268_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Erica>"
  },
  RelicConfig_71269_BattleDesc = {
    Text = "Tur başında Golyat [Arg1] Aliemus kazanır. Golyat 1 tur içinde [Arg2] kez Hasar verirse, bu savaşta Golyat’ın verdiği Hasar ilave 1x GÜÇ bonusu kazanır; bekleme süresi 3 turdur."
  },
  RelicConfig_71269_Desc = {
    Text = "Tur başında Golyat [Arg1] Aliemus kazanır. Golyat 1 tur içinde [Arg2] kez Hasar verirse, bu savaşta Golyat’ın verdiği Hasar ilave 1x GÜÇ bonusu kazanır; bekleme süresi 3 turdur."
  },
  RelicConfig_71269_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Golyat>"
  },
  RelicConfig_71270_BattleDesc = {
    Text = "Tur başında Sanga [Arg1] Aliemus kazanır. Savaşın başında, Sanga’nın tüm Komut Kartlarına Sakla, Hazırlan 1 ver ve [Arg2] Kalkan kazan."
  },
  RelicConfig_71270_Desc = {
    Text = "Tur başında Sanga [Arg1] Aliemus kazanır. Savaşın başında, Sanga’nın tüm Komut Kartlarına Sakla, Hazırlan 1 ver ve [Arg2] Kalkan kazan."
  },
  RelicConfig_71270_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Sanga>"
  },
  RelicConfig_71662_BattleDesc = {
    Text = "Çift numaralı turların başında ele 1 <DerivativeCardKeywords_105:Infinite Silver Vault> yerleştir."
  },
  RelicConfig_71662_Desc = {
    Text = "Çift numaralı turların başında ele 1 <DerivativeCardKeywords_105:Infinite Silver Vault> yerleştir."
  },
  RelicConfig_71662_Name = {
    Text = "<OrangeQuality:Kedinin Hazinesi>"
  },
  RelicConfig_72226_BattleDesc = {
    Text = "El Sınırı +1. Tur başında, eğer hiçbir Araştırma yapılmadıysa, denenmemiş bir Araştırma seç. Tamamlandığında, Doll: Cehennem’in ilgili Araştırma sonucunu kazan. 3 Araştırma tamamlandıktan sonra, \"Yanılsamanın Sonu\"nu ele koy; bu Hatıra etkisiz hale gelir."
  },
  RelicConfig_72226_Desc = {
    Text = "El Sınırı +1. Tur başında, eğer hiçbir Araştırma yapılmadıysa, denenmemiş bir Araştırma seç. Tamamlandığında, Doll: Cehennem’in ilgili Araştırma sonucunu kazan. 3 Araştırma tamamlandıktan sonra, \"Yanılsamanın Sonu\"nu ele koy; bu Hatıra etkisiz hale gelir."
  },
  RelicConfig_72226_Name = {
    Text = "Son Perde Araştırma Elyazması"
  },
  RelicConfig_74832_BattleDesc = {
    Text = "El Sınırı +1. Savaşın başında kişiselleştirilmiş bir “Tabu Ticareti” oluştur. “Tabu Ticareti”ni oynadığında, bir sonrakini bir sonraki turunda oluşturursun.\n“Tabu Ticareti”nin 4 Arithmetica Maliyeti, Sakla, Hazırlan ve Tüketme özellikleri vardır ve 3 özel etkisi bulunur. “Saldırı”, “Savunma” veya “Yetenek” Komut Kartı oynamak sırasıyla 1., 2. veya 3. etkisini güçlendirir."
  },
  RelicConfig_74832_Desc = {
    Text = "El Sınırı +1. Savaşın başında kişiselleştirilmiş bir “Tabu Ticareti” oluştur. “Tabu Ticareti”ni oynadığında, bir sonrakini bir sonraki turunda oluşturursun.\n“Tabu Ticareti”nin 4 Arithmetica Maliyeti, Sakla, Hazırlan ve Tüketme özellikleri vardır ve 3 özel etkisi bulunur. “Saldırı”, “Savunma” veya “Yetenek” Komut Kartı oynamak sırasıyla 1., 2. veya 3. etkisini güçlendirir."
  },
  RelicConfig_74832_Name = {
    Text = "Biçim Değiştiricinin Daveti"
  },
  RelicConfig_74832_StoryDesc = {
    Text = "Mektuptaki kelimeler durmadan değişiyor, sürekli karşı konulamaz bir arzuya dönüşüyordu."
  },
  RelicConfig_78664_BattleDesc = {
    Text = "Tek bir turda farklı Uyananlardan 4 Komut Kartı oynadığında, bu turda tüm Uyananların verdiği Final Hasar [Arg1]% artar ve [Arg2] Aliemus kaybedersin. Bu Etki her tur yalnızca bir kez tetiklenebilir."
  },
  RelicConfig_78664_Desc = {
    Text = "Tek bir turda farklı Uyananlardan 4 Komut Kartı oynadığında, bu turda tüm Uyananların verdiği Final Hasar [Arg1]% artar ve [Arg2] Aliemus kaybedersin. Bu Etki her tur yalnızca bir kez tetiklenebilir."
  },
  RelicConfig_78664_Name = {
    Text = "<RedQuality:Uğursuz Kanca>"
  },
  RelicConfig_78664_StoryDesc = {
    Text = "Tanımlanması güç türler."
  },
  RelicConfig_78665_BattleDesc = {
    Text = "Tur başında [Arg1] daha az kart çek. Arithmetica maliyeti >= [Arg2] olan her oynanan kart için 1 Arithmetica kazan; tur başına en fazla [Arg3] kez tetiklenir."
  },
  RelicConfig_78665_Desc = {
    Text = "Tur başında [Arg1] daha az kart çek. Arithmetica maliyeti >= [Arg2] olan her oynanan kart için 1 Arithmetica kazan; tur başına en fazla [Arg3] kez tetiklenir."
  },
  RelicConfig_78665_Name = {
    Text = "<RedQuality:Feryat Çanı>"
  },
  RelicConfig_78665_StoryDesc = {
    Text = "Çın, çın, çocuk ağlıyor;\nÇın, çın, çocuk çığlık atıyor.\nÇın, çın, çocuk inliyor;\nÇın, çın, aç o, biliyor musun."
  },
  RelicConfig_78666_BattleDesc = {
    Text = "Tur başında [Arg1] Sayaç kazan. Bir turda Uyanış’ı [Arg2] kez kullandıktan sonra, [Arg3]% Kalıcı Sayaç kaldır ve kaldırılan miktarın [Arg4]%’i kadar Geçici Sayaç kazan. Bekleme süresi: [Arg5] tur."
  },
  RelicConfig_78666_Desc = {
    Text = "Tur başında [Arg1] Sayaç kazan. Bir turda Uyanış’ı [Arg2] kez kullandıktan sonra, [Arg3]% Kalıcı Sayaç kaldır ve kaldırılan miktarın [Arg4]%’i kadar Geçici Sayaç kazan. Bekleme süresi: [Arg5] tur."
  },
  RelicConfig_78666_Name = {
    Text = "<RedQuality:Yol Yürüyenin Kalıntıları>"
  },
  RelicConfig_78666_StoryDesc = {
    Text = "Kutsal bir parça.\nBedenden ayrılmış olsa da, ayak izleri dünyaya yayılmış durumda."
  },
  RelicConfig_78667_BattleDesc = {
    Text = "Çekme aşamasından sonra, [Arg1] ek kart çek ve elinden [Arg2] kart seçip at."
  },
  RelicConfig_78667_Desc = {
    Text = "Çekme aşamasından sonra, [Arg1] ek kart çek ve elinden [Arg2] kart seçip at."
  },
  RelicConfig_78667_Name = {
    Text = "<RedQuality:Düzenbazın Şapkası>"
  },
  RelicConfig_78667_StoryDesc = {
    Text = "Hoş Geldin Bayan Casiah'ın Harikalar Sirki'ne! Dikkatli ol, sihir eşyalarına dokunma. Isırılırsan, sonun kötü olabilir.\nEn son kan tattığında, sonuç korkunç olmuştu.\n\nSilindir Şapka, her an belirmeye hazırmış gibi göz kırptı."
  },
  RelicConfig_78668_BattleDesc = {
    Text = "Gümüş Anahtar Uyanışı kullandıktan Sonra, elindeki o Uyandırıcı'ya karşılık gelen [Arg1] Türetilmemiş Komut Kartı seç. O kartı tüket ve onun [Arg2] Temel Kopyasını sırasıyla Çekme Destesi'ne, ele ve Atılmış Kart Destesi'ne yerleştir."
  },
  RelicConfig_78668_Desc = {
    Text = "Gümüş Anahtar Uyanışı kullandıktan Sonra, elindeki o Uyandırıcı'ya karşılık gelen [Arg1] Türetilmemiş Komut Kartı seç. O kartı tüket ve onun [Arg2] Temel Kopyasını sırasıyla Çekme Destesi'ne, ele ve Atılmış Kart Destesi'ne yerleştir."
  },
  RelicConfig_78668_Name = {
    Text = "<RedQuality:Yeşim Mührü>"
  },
  RelicConfig_78668_StoryDesc = {
    Text = "Bu Damga, binyıllar boyunca Çürüme olmadan tahammül eder."
  },
  RelicConfig_78669_BattleDesc = {
    Text = "Savaşın başında [Arg1] Güç kazan. Tur başında, her [Arg2] Kalıcı Güç için [Arg3] Geçici GÜÇ kazan; en fazla [Arg4] Geçici GÜÇ’e kadar. Tur sonunda, o Kutsal Emanet tarafından kazandığın Geçici GÜÇ’ün yarısını kaybet."
  },
  RelicConfig_78669_Desc = {
    Text = "Savaşın başında [Arg1] Güç kazan. Tur başında, her [Arg2] Kalıcı Güç için [Arg3] Geçici GÜÇ kazan; en fazla [Arg4] Geçici GÜÇ’e kadar. Tur sonunda, o Kutsal Emanet tarafından kazandığın Geçici GÜÇ’ün yarısını kaybet."
  },
  RelicConfig_78669_Name = {
    Text = "<RedQuality:Kehanet Ritüel Kuşu>"
  },
  RelicConfig_78669_StoryDesc = {
    Text = "Çürümüş ceset bir çığlık kopardı."
  },
  RelicConfig_78670_BattleDesc = {
    Text = "Tüm Uyananların Temel Hasarı [Arg1]% artar. Deste her sıfırlandığında, fazladan [Arg2]% verilir, ancak eline bir \"Sersemleme\" kartı eklenir. En fazla artış [Arg3]%’tir."
  },
  RelicConfig_78670_Desc = {
    Text = "Tüm Uyananların Temel Hasarı [Arg1]% artar. Deste her sıfırlandığında, fazladan [Arg2]% verilir, ancak eline bir \"Sersemleme\" kartı eklenir. En fazla artış [Arg3]%’tir."
  },
  RelicConfig_78670_Name = {
    Text = "<RedQuality:Kara Mum>"
  },
  RelicConfig_78670_StoryDesc = {
    Text = "Berraklıkta yan, düşe düş."
  },
  RelicConfig_78671_BattleDesc = {
    Text = "Tur başlangıcında, Embriyo Füzyonu +[Arg1]. \"Embriyo\" kartları tur sonunda elden atılır."
  },
  RelicConfig_78671_Desc = {
    Text = "Tur başlangıcında, Embriyo Füzyonu +[Arg1]. \"Embriyo\" kartları tur sonunda elden atılır."
  },
  RelicConfig_78671_Name = {
    Text = "<RedQuality:Kıvranan Kordon>"
  },
  RelicConfig_78671_StoryDesc = {
    Text = "Boyna dolan."
  },
  RelicConfig_78672_BattleDesc = {
    Text = "Tur başında, Ultra Uzay’daki her 1 boş alan için [Arg1] KUV kazan, ancak [Arg2] yığın Zehir çek."
  },
  RelicConfig_78672_Desc = {
    Text = "Tur başında, Ultra Uzay’daki her 1 boş alan için [Arg1] KUV kazan, ancak [Arg2] yığın Zehir çek."
  },
  RelicConfig_78672_Name = {
    Text = "<RedQuality:Sürü Zihni>"
  },
  RelicConfig_78672_StoryDesc = {
    Text = "Sarmalamak, Ortak Duyum, Sürü; Korku, Bilinmeyen Yaratık, Kontrol."
  },
  RelicConfig_78673_BattleDesc = {
    Text = "Keyflare Uyandırma kullanıldıktan sonra, fazladan [Arg1] Keyflare tüketerek alınan Uyandırma kartının Arithmetica Tüketmesini 0’a düşür. Oynandığında, ilgili Uyandıran fazladan [Arg2] Aliemus kazanır."
  },
  RelicConfig_78673_Desc = {
    Text = "Keyflare Uyandırma kullanıldıktan sonra, fazladan [Arg1] Keyflare tüketerek alınan Uyandırma kartının Arithmetica Tüketmesini 0’a düşür. Oynandığında, ilgili Uyandıran fazladan [Arg2] Aliemus kazanır."
  },
  RelicConfig_78673_Name = {
    Text = "<RedQuality:Bilinç Kazıması>"
  },
  RelicConfig_78673_StoryDesc = {
    Text = "Kadim kabile, ölülerin kafataslarına özel semboller kazımanın, ruhlarını sonsuza dek yanlarında tutacağına inanırdı."
  },
  RelicConfig_78674_BattleDesc = {
    Text = "Savaşın başında tüm düşmanlara [Arg1] Zehir uygula. Tur başında, düşmanın Zehir’inin [Arg2]%’ini kaldır ve kaldırılan miktarın [Arg3]%’ini Kan Akıtma olarak uygula."
  },
  RelicConfig_78674_Desc = {
    Text = "Savaşın başında tüm düşmanlara [Arg1] Zehir uygula. Tur başında, düşmanın Zehir’inin [Arg2]%’ini kaldır ve kaldırılan miktarın [Arg3]%’ini Kan Akıtma olarak uygula."
  },
  RelicConfig_78674_Name = {
    Text = "<RedQuality:Kurtuluş Uzvu>"
  },
  RelicConfig_78674_StoryDesc = {
    Text = "Kutsal bir parça.\nBedenden ayrılsa bile, sıcaklığı hâlâ hissedilebilir."
  },
  RelicConfig_78675_BattleDesc = {
    Text = "Tur başında, eğer [Arg1]’den fazla Kalıcı Dokunaç varsa, [Arg2] Dokunaç kaybedip [Arg3] Geçici Dokunaç kazan. Aksi hâlde, [Arg4] Kalıcı Dokunaç kazan."
  },
  RelicConfig_78675_Desc = {
    Text = "Tur başında, eğer [Arg1]’den fazla Kalıcı Dokunaç varsa, [Arg2] Dokunaç kaybedip [Arg3] Geçici Dokunaç kazan. Aksi hâlde, [Arg4] Kalıcı Dokunaç kazan."
  },
  RelicConfig_78675_Name = {
    Text = "<RedQuality:Kutsal Izdırap>"
  },
  RelicConfig_78675_StoryDesc = {
    Text = "Izdırabı kucakla."
  },
  RelicConfig_79408_BattleDesc = {
    Text = "El sınırı +2, çekilen kart +2. \"Berrak Hatıra\" 5 yığınla başlar. İşaretli kartları oynamak \"Berrak Hatıra\"yı değiştirir. \"Berrak Hatıra\" 5’in altındayken, her 1 azalış Final Hasarı %10 artırır, Karakter Kalkanı ve HP Yenilenmesini %5 azaltır; 5’in üzerindeyken, her 1 artış Karakter Kalkanını ve İyileştirmeyi %5 artırır, Final Hasarı %10 azaltır."
  },
  RelicConfig_79408_Desc = {
    Text = "El sınırı +2, çekilen kart +2. \"Berrak Hatıra\" 5 yığınla başlar. İşaretli kartları oynamak \"Berrak Hatıra\"yı değiştirir. \"Berrak Hatıra\" 5’in altındayken, her 1 azalış Final Hasarı %10 artırır, Karakter Kalkanı ve HP Yenilenmesini %5 azaltır; 5’in üzerindeyken, her 1 artış Karakter Kalkanını ve İyileştirmeyi %5 artırır, Final Hasarı %10 azaltır."
  },
  RelicConfig_79408_Name = {
    Text = "\"Hafıza\" ve \"Düş\""
  },
  RelicConfig_79408_StoryDesc = {
    Text = "\"Gel, beni dinle.\"\n\"Anılarını ve düşlerini dönüştüreyim.\"\n\"Akıl almaz derecede leziz bir tatlıya.\""
  },
  RelicConfig_80340_BattleDesc = {
    Text = "Tur başında Clementine [Arg1] Aliemus kazanır. Clementine'in Komut Kartlarının DMG verme, Kalkan üretme, HP yenileme, Aliemus kazanma ve Keyflare kazanma sayısı 1 artar."
  },
  RelicConfig_80340_Desc = {
    Text = "Tur başında Clementine [Arg1] Aliemus kazanır. Clementine'in Komut Kartlarının DMG verme, Kalkan üretme, HP yenileme, Aliemus kazanma ve Keyflare kazanma sayısı 1 artar."
  },
  RelicConfig_80340_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Clementine>"
  },
  RelicConfig_83509_BattleDesc = {
    Text = "Keşfin başında Kalıntı Kapasitesi +1, ve \"Aequor\" Uyandıranı kendi \"Boyutsal Görüntü\"sünü kazanır. Takımdaki her \"Aequor\" Uyandıranı için Kalıntı Kapasitesi +1."
  },
  RelicConfig_83509_Desc = {
    Text = "Keşfin başında Kalıntı Kapasitesi +1, ve \"Aequor\" Uyandıranı kendi \"Boyutsal Görüntü\"sünü kazanır. Takımdaki her \"Aequor\" Uyandıranı için Kalıntı Kapasitesi +1."
  },
  RelicConfig_83509_Name = {
    Text = "<OrangeQuality:\"Aequor Yüzüğü\">"
  },
  RelicConfig_83509_StoryDesc = {
    Text = "Uçurumun okyanusunda uyuyanlar, dünyaya unutulmuş Otoriteyi göstermeye başlıyor."
  },
  RelicConfig_83510_BattleDesc = {
    Text = "Keşfin başında Kalıntı Kapasitesi +1, ve \"Caro\" Uyandıranı kendi \"Boyutsal Görüntü\"sünü kazanır. Takımdaki her \"Caro\" Uyandıranı için Kalıntı Kapasitesi +1."
  },
  RelicConfig_83510_Desc = {
    Text = "Keşfin başında Kalıntı Kapasitesi +1, ve \"Caro\" Uyandıranı kendi \"Boyutsal Görüntü\"sünü kazanır. Takımdaki her \"Caro\" Uyandıranı için Kalıntı Kapasitesi +1."
  },
  RelicConfig_83510_Name = {
    Text = "<OrangeQuality:\"Caro Yüzüğü\">"
  },
  RelicConfig_83510_StoryDesc = {
    Text = "Boyun eğmeyen ıstıraptan, yükseliş doğdu."
  },
  RelicConfig_83511_BattleDesc = {
    Text = "Keşfin başında Kalıntı Kapasitesi +1, ve \"Ultra\" Uyandıranı kendi \"Boyutsal Görüntü\"sünü kazanır. Takımdaki her \"Ultra\" Uyandıranı için Kalıntı Kapasitesi +1."
  },
  RelicConfig_83511_Desc = {
    Text = "Keşfin başında Kalıntı Kapasitesi +1, ve \"Ultra\" Uyandıranı kendi \"Boyutsal Görüntü\"sünü kazanır. Takımdaki her \"Ultra\" Uyandıranı için Kalıntı Kapasitesi +1."
  },
  RelicConfig_83511_Name = {
    Text = "<OrangeQuality:\"Ultra Yüzük\">"
  },
  RelicConfig_83511_StoryDesc = {
    Text = "Sonsuz boyutlar üst üste bindi; işte bu anda, \"Ben\" sonsuzca tamamlandım."
  },
  RelicConfig_83512_BattleDesc = {
    Text = "Keşfin başında Kalıntı Kapasitesi +1 olur ve \"Kaos\" Uyananı kendi \"Boyutsal Görüntü\" sünü kazanır. Takımdaki her \"Kaos\" Uyananı için Kalıntı Kapasitesi +1 artar."
  },
  RelicConfig_83512_Desc = {
    Text = "Keşfin başında Kalıntı Kapasitesi +1 olur ve \"Kaos\" Uyananı kendi \"Boyutsal Görüntü\" sünü kazanır. Takımdaki her \"Kaos\" Uyananı için Kalıntı Kapasitesi +1 artar."
  },
  RelicConfig_83512_Name = {
    Text = "<OrangeQuality:\"Kaos Yüzüğü\">"
  },
  RelicConfig_83512_StoryDesc = {
    Text = "Kaos biçimsizdir, kaos elle tutulmazdır; kaos her şeye karışmıştır."
  },
  RelicConfig_83606_BattleDesc = {
    Text = "El sınırı +1. Tur başında, \"Kılavuzun Tercihi\" elde değilse onu ele al.\nLider, başlangıç Maksimum HP’sinin %10’unu her kaybettiğinde, 1 yığın \"Yelken Aç\" kazan, en fazla 10 yığın. \"Yelken Aç\", \"Demir Alma\"nın etkilerini güçlendirir.\nSen, başlangıç Maksimum HP’nin %10’unu her kaybettiğinde, 1 yığın \"Demir Atma\" kazan, en fazla 10 yığın. \"Demir Atma\", \"Kıyıda Dinleniş\"in etkilerini güçlendirir."
  },
  RelicConfig_83606_Desc = {
    Text = "El sınırı +1. Tur başında, \"Kılavuzun Tercihi\" elde değilse onu ele al.\nLider, başlangıç Maksimum HP’sinin %10’unu her kaybettiğinde, 1 yığın \"Yelken Aç\" kazan, en fazla 10 yığın. \"Yelken Aç\", \"Demir Alma\"nın etkilerini güçlendirir.\nSen, başlangıç Maksimum HP’nin %10’unu her kaybettiğinde, 1 yığın \"Demir Atma\" kazan, en fazla 10 yığın. \"Demir Atma\", \"Kıyıda Dinleniş\"in etkilerini güçlendirir."
  },
  RelicConfig_83606_Name = {
    Text = "Erasmus'un Rehberliği"
  },
  RelicConfig_83606_StoryDesc = {
    Text = "Titreşen şimşek, ilerideki yönü gösterecek."
  },
  RelicConfig_84112_BattleDesc = {
    Text = "Tur başında Agrippa [Arg1] Aliemus kazanır. \"Gönülsüz Sadaka\" bu tur için Agrippa’nın Arithmetica Maliyeti’ni ayrıca [Arg2] azaltır; tur başına en fazla bir kez etkili olur."
  },
  RelicConfig_84112_Desc = {
    Text = "Tur başında Agrippa [Arg1] Aliemus kazanır. \"Gönülsüz Sadaka\" bu tur için Agrippa’nın Arithmetica Maliyeti’ni ayrıca [Arg2] azaltır; tur başına en fazla bir kez etkili olur."
  },
  RelicConfig_84112_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Agrippa>"
  },
  RelicConfig_84113_BattleDesc = {
    Text = "Tur başında, Caraboo [Arg1] Aliemus kazanır. Caraboo'nun \"Bereket\" kartları <FaxianKeywords:Keşfedildiğinde> 1 fazladan seçenek sunar. Caraboo'nun Taşkınlığı, verilen hasar miktarına eşit Aşınma yığını uygular."
  },
  RelicConfig_84113_Desc = {
    Text = "Tur başında, Caraboo [Arg1] Aliemus kazanır. Caraboo'nun \"Bereket\" kartları <FaxianKeywords:Keşfedildiğinde> 1 fazladan seçenek sunar. Caraboo'nun Taşkınlığı, verilen hasar miktarına eşit Aşınma yığını uygular."
  },
  RelicConfig_84113_Name = {
    Text = "<OrangeQuality:Boyutsal İmge: Caraboo>"
  },
  RelicConfig_84114_BattleDesc = {
    Text = "Tur başında Pickman [Arg1] Aliemus kazanır. Kazanılan her \"Yaratıcılık\" yığını için, bu tur boyunca eldeki rastgele 1 kartın Arithmetica Maliyeti 1 azalır. Pickman \"Yaratıcılık\" tükettiğinde, tüm Uyananlar ayrıca [Arg2] Aliemus kazanır."
  },
  RelicConfig_84114_Desc = {
    Text = "Tur başında Pickman [Arg1] Aliemus kazanır. Kazanılan her \"Yaratıcılık\" yığını için, bu tur boyunca eldeki rastgele 1 kartın Arithmetica Maliyeti 1 azalır. Pickman \"Yaratıcılık\" tükettiğinde, tüm Uyananlar ayrıca [Arg2] Aliemus kazanır."
  },
  RelicConfig_84114_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Pickman>"
  },
  RelicConfig_84116_BattleDesc = {
    Text = "Tur başında Erica [Arg1] Aliemus kazanır. 1 tur içinde [Arg2] Komut Kartı oynadıktan sonra, Erica 2 Arithmetica kazanır ve bu savaşta \"Elektromanyetik Patlama\" için GÜÇ ve Alarm bonusunu ikiye katlar."
  },
  RelicConfig_84116_Desc = {
    Text = "Tur başında Erica [Arg1] Aliemus kazanır. 1 tur içinde [Arg2] Komut Kartı oynadıktan sonra, Erica 2 Arithmetica kazanır ve bu savaşta \"Elektromanyetik Patlama\" için GÜÇ ve Alarm bonusunu ikiye katlar."
  },
  RelicConfig_84116_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Erica>"
  },
  RelicConfig_84117_BattleDesc = {
    Text = "Tur başında Murphy: Sahte Doğumlu [Arg1] Aliemus kazanır. \"Lemuria Valsi\" her 3. oynanışta 3 kez etkisini gösterir."
  },
  RelicConfig_84117_Desc = {
    Text = "Tur başında Murphy: Sahte Doğumlu [Arg1] Aliemus kazanır. \"Lemuria Valsi\" her 3. oynanışta 3 kez etkisini gösterir."
  },
  RelicConfig_84117_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Murphy: Sahte Doğumlu>"
  },
  RelicConfig_84118_BattleDesc = {
    Text = "Tur başında Casiah [Arg1] Aliemus kazanır. 1 kart çekmek Casiah'a [Arg2] Aliemus kazandırır. Casiah Yüceltim açığa çıkardığında, tüm düşmanlar [Arg3] GÜÇ kaybeder."
  },
  RelicConfig_84118_Desc = {
    Text = "Tur başında Casiah [Arg1] Aliemus kazanır. 1 kart çekmek Casiah'a [Arg2] Aliemus kazandırır. Casiah Yüceltim açığa çıkardığında, tüm düşmanlar [Arg3] GÜÇ kaybeder."
  },
  RelicConfig_84118_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Casiah>"
  },
  RelicConfig_84119_BattleDesc = {
    Text = "Tur başında Murphy [Arg1] Aliemus kazanır. Murphy’nin \"Saldırı\" ve \"Savunma\" sı, \"Kurban\"ın [Arg2]%’sini Geçici Dokunaç Hasarı’na dönüştürebilir, ancak tur başına yalnızca bir kez etkili olabilir."
  },
  RelicConfig_84119_Desc = {
    Text = "Tur başında Murphy [Arg1] Aliemus kazanır. Murphy’nin \"Saldırı\" ve \"Savunma\" sı, \"Kurban\"ın [Arg2]%’sini Geçici Dokunaç Hasarı’na dönüştürebilir, ancak tur başına yalnızca bir kez etkili olabilir."
  },
  RelicConfig_84119_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Murphy>"
  },
  RelicConfig_84121_BattleDesc = {
    Text = "Tur başında Arachne [Arg1] Aliemus kazanır. \"Vuruş\" ve \"Savunma\", anında 1 kez \"Sonsuz Yumak\" Takibi serbest bırakır; her tur en fazla 1 kez etki eder."
  },
  RelicConfig_84121_Desc = {
    Text = "Tur başında Arachne [Arg1] Aliemus kazanır. \"Vuruş\" ve \"Savunma\", anında 1 kez \"Sonsuz Yumak\" Takibi serbest bırakır; her tur en fazla 1 kez etki eder."
  },
  RelicConfig_84121_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Jenkin>"
  },
  RelicConfig_84122_BattleDesc = {
    Text = "Tur başında Tulu [Arg1] Aliemus kazanır. Tulu’nun Aliemus Tüketimi [Arg2] azalır ve Yüceltme’yi serbest bıraktıktan sonra anında [Arg3] Geçici Dokunaç üretir."
  },
  RelicConfig_84122_Desc = {
    Text = "Tur başında Tulu [Arg1] Aliemus kazanır. Tulu’nun Aliemus Tüketimi [Arg2] azalır ve Yüceltme’yi serbest bıraktıktan sonra anında [Arg3] Geçici Dokunaç üretir."
  },
  RelicConfig_84122_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Tulu>"
  },
  RelicConfig_84123_BattleDesc = {
    Text = "Tur başında, Pollux [Arg1] Aliemus kazanır. Savaşın başında 1 \"Kutsal Kalp\" kazan. 3. kullanımında Tüketildiğinde, \"Kutsal Kalp\" tüm düşmanlara Savunmasız uygular ve iki kez Hasar verir."
  },
  RelicConfig_84123_Desc = {
    Text = "Tur başında, Pollux [Arg1] Aliemus kazanır. Savaşın başında 1 \"Kutsal Kalp\" kazan. 3. kullanımında Tüketildiğinde, \"Kutsal Kalp\" tüm düşmanlara Savunmasız uygular ve iki kez Hasar verir."
  },
  RelicConfig_84123_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Pollux>"
  },
  RelicConfig_84124_BattleDesc = {
    Text = "Tur başında Hameln [Arg1] Aliemus kazanır. \"Ruh Uvertürü\" nün Arithmetica Maliyeti [Arg2] azalır ve Temel Hasar sayısı +[Arg3] olur."
  },
  RelicConfig_84124_Desc = {
    Text = "Tur başında Hameln [Arg1] Aliemus kazanır. \"Ruh Uvertürü\" nün Arithmetica Maliyeti [Arg2] azalır ve Temel Hasar sayısı +[Arg3] olur."
  },
  RelicConfig_84124_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Hameln>"
  },
  RelicConfig_84125_BattleDesc = {
    Text = "Tur başında Kathigu-Ra [Arg1] Aliemus kazanır. \"Fiamma\" 10 yığına ulaştığında, derhal Kathigu-Ra’nın 1 Komut Kartını çek ve ona 3 \"Fiamma\" yığını ver. Bu etki, bu turun geri kalanında yığın biriktirmez."
  },
  RelicConfig_84125_Desc = {
    Text = "Tur başında Kathigu-Ra [Arg1] Aliemus kazanır. \"Fiamma\" 10 yığına ulaştığında, derhal Kathigu-Ra’nın 1 Komut Kartını çek ve ona 3 \"Fiamma\" yığını ver. Bu etki, bu turun geri kalanında yığın biriktirmez."
  },
  RelicConfig_84125_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Kathigu-Ra>"
  },
  RelicConfig_84126_BattleDesc = {
    Text = "Tur başında Castor [Arg1] Aliemus kazanır. Savaşın başında ele 2 \"Oniks Tüy\" yerleştir. \"Oniks Tüy\" her tur ilk kez oynandıktan sonra [Arg2] Geçici GÜÇ kazan."
  },
  RelicConfig_84126_Desc = {
    Text = "Tur başında Castor [Arg1] Aliemus kazanır. Savaşın başında ele 2 \"Oniks Tüy\" yerleştir. \"Oniks Tüy\" her tur ilk kez oynandıktan sonra [Arg2] Geçici GÜÇ kazan."
  },
  RelicConfig_84126_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Castor>"
  },
  RelicConfig_84127_BattleDesc = {
    Text = "Tur başında Corposant [Arg1] Aliemus ve 1 Geçici Dokunaç kazanır. Ne zaman Ölüm Direnci tetiklenirse, Corposant [Arg2] Aliemus kazanır ve elde Arithmetica Maliyeti 0 olan, Tüketme’ye sahip 1 \"Yıldırım Cezası\" belirmesini sağlar."
  },
  RelicConfig_84127_Desc = {
    Text = "Tur başında Corposant [Arg1] Aliemus ve 1 Geçici Dokunaç kazanır. Ne zaman Ölüm Direnci tetiklenirse, Corposant [Arg2] Aliemus kazanır ve elde Arithmetica Maliyeti 0 olan, Tüketme’ye sahip 1 \"Yıldırım Cezası\" belirmesini sağlar."
  },
  RelicConfig_84127_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Corposant>"
  },
  RelicConfig_89252_BattleDesc = {
    Text = "Arithmetica Sınırı 1 artar, tur başına fazladan 1 kart çekersin ve savaşın başında [Arg1] yığın \"Kader Kafesi\" sayımı kazanırsın.\nHer \"Kader Kafesi\" yığını, tüm Uyanışçıların Aliemus’unu [Arg2]% azaltır ve her Yüceltim salınışında 1 yığın \"Kader Kafesi\" eksilir. Tüm \"Kader Kafesleri\" kaldırıldıktan sonra, tüm Uyanışçılar [Arg3] Aliemus kazanır, \"\"Boyun Eğmez Yürek\"\"i elde eder: tüm Uyanışçıların Aliemus’u +[Arg4]%, ve Yüceltim tur başına iki kez salınabilir."
  },
  RelicConfig_89252_Desc = {
    Text = "Arithmetica Sınırı 1 artar, tur başına fazladan 1 kart çekersin ve savaşın başında [Arg1] yığın \"Kader Kafesi\" sayımı kazanırsın.\nHer \"Kader Kafesi\" yığını, tüm Uyanışçıların Aliemus’unu [Arg2]% azaltır ve her Yüceltim salınışında 1 yığın \"Kader Kafesi\" eksilir. Tüm \"Kader Kafesleri\" kaldırıldıktan sonra, tüm Uyanışçılar [Arg3] Aliemus kazanır, \"\"Boyun Eğmez Yürek\"\"i elde eder: tüm Uyanışçıların Aliemus’u +[Arg4]%, ve Yüceltim tur başına iki kez salınabilir."
  },
  RelicConfig_89252_Name = {
    Text = "Lanetli Tüy"
  },
  RelicConfig_89252_StoryDesc = {
    Text = "Artık bu tüy gökyüzünde uçamaz."
  },
  RelicConfig_89645_BattleDesc = {
    Text = "El Sınırı +2, Yüceltme’den sonra Geçici Final Hasar %10 artar.\nKart Ultra Uzay’a girdikten sonra, eldeki 1 \"Embriyo\" \"Saflığın Varisi\"ne dönüşür.\nHer 1 \"Embriyo\" üretildiğinde, Ultra Uzay’daki Rastgele kartlardan birinin Arithmetica Maliyeti 1 azalır."
  },
  RelicConfig_89645_Desc = {
    Text = "El Sınırı +2, Yüceltme’den sonra Geçici Final Hasar %10 artar.\nKart Ultra Uzay’a girdikten sonra, eldeki 1 \"Embriyo\" \"Saflığın Varisi\"ne dönüşür.\nHer 1 \"Embriyo\" üretildiğinde, Ultra Uzay’daki Rastgele kartlardan birinin Arithmetica Maliyeti 1 azalır."
  },
  RelicConfig_89645_Name = {
    Text = "Hiperdize Kan Çürümesi Serumu"
  },
  RelicConfig_89646_BattleDesc = {
    Text = "Tur başında 250 Keyflare elde et.\nKeyflare Uyandırma kullanıldıktan sonra ele 1 adet <DerivativeCardKeywords_129:\"Gümüş Anahtar Işıltısı\"> yerleştir.\nTur başında 1 Uyanan Destek kartı Keşif yap."
  },
  RelicConfig_89646_Desc = {
    Text = "Tur başında 250 Keyflare elde et.\nKeyflare Uyandırma kullanıldıktan sonra ele 1 adet <DerivativeCardKeywords_129:\"Gümüş Anahtar Işıltısı\"> yerleştir.\nTur başında 1 Uyanan Destek kartı Keşif yap."
  },
  RelicConfig_89646_Name = {
    Text = "Birleşik Evrim Reaktifi"
  },
  RelicConfig_89647_BattleDesc = {
    Text = "Her Turdaki ilk Komut Kartı 1 kez ek olarak etki eder.\nYok Oluş gerçekleştiğinde 1 Dokunaç üret.\nDokunaç \"Azgın Dalgalar\" duruşuna geçirildikten sonra, bir sonraki Komut Kartının Sıçrama etkisi garanti olarak tetiklenir ve onun 2 Temel Kopyasını 3 Turluk bekleme süresiyle Ultra Uzay'a yerleştirir."
  },
  RelicConfig_89647_Desc = {
    Text = "Her Turdaki ilk Komut Kartı 1 kez ek olarak etki eder.\nYok Oluş gerçekleştiğinde 1 Dokunaç üret.\nDokunaç \"Azgın Dalgalar\" duruşuna geçirildikten sonra, bir sonraki Komut Kartının Sıçrama etkisi garanti olarak tetiklenir ve onun 2 Temel Kopyasını 3 Turluk bekleme süresiyle Ultra Uzay'a yerleştirir."
  },
  RelicConfig_89647_Name = {
    Text = "Hiperdize Uçurumsal İksir"
  },
  RelicConfig_89648_BattleDesc = {
    Text = "Diyar Ustalığı 200 puan artar.\nKızıl Ocak tüketildiğinde, Dokunaç Saldırısı Hasarını tüketilen miktarın %15’i kadar artır.\nHer Dokunaç Saldırısı gerçekleştiğinde [Arg3] Kızıl Ocak biriktir."
  },
  RelicConfig_89648_Desc = {
    Text = "Diyar Ustalığı 200 puan artar.\nKızıl Ocak tüketildiğinde, Dokunaç Saldırısı Hasarını tüketilen miktarın %15’i kadar artır.\nHer Dokunaç Saldırısı gerçekleştiğinde [Arg3] Kızıl Ocak biriktir."
  },
  RelicConfig_89648_Name = {
    Text = "Çürüyen Kan Uçurum Serumu"
  },
  RelicConfig_91096_BattleDesc = {
    Text = "Tur başlangıcında her iki taraf da bir yığın <Kuangre:Coşku> kazanır. Her <Kuangre:Coşku> yığını, verilen Aktif ve Dokunaç Hasarının verilen Hasarın %10'una eşit <BleedingIconKeywords:Kanama> uygulamasına neden olur. \nBoss Canının her %20'si azaldığında, tüm Uyandırıcılar 10 Aliemus kazanır. \nSavaş başlangıcında, Çekme Destesi'ne <DerivativeCardKeywords_108:\"Yavrularını Cesaretlendir\"> ve <DerivativeCardKeywords_109:\"Yavrularını Koru\"> karıştır."
  },
  RelicConfig_91096_Desc = {
    Text = "Tur başlangıcında her iki taraf da bir yığın <Kuangre:Coşku> kazanır. Her <Kuangre:Coşku> yığını, verilen Aktif ve Dokunaç Hasarının verilen Hasarın %10'una eşit <BleedingIconKeywords:Kanama> uygulamasına neden olur. \nBoss Canının her %20'si azaldığında, tüm Uyandırıcılar 10 Aliemus kazanır. \nSavaş başlangıcında, Çekme Destesi'ne <DerivativeCardKeywords_108:\"Yavrularını Cesaretlendir\"> ve <DerivativeCardKeywords_109:\"Yavrularını Koru\"> karıştır."
  },
  RelicConfig_91096_Name = {
    Text = "Solgun Yumurta"
  },
  RelicConfig_91096_StoryDesc = {
    Text = "Solgun çocuk doğmak üzereyken nabızlanır.\nDikkatli ol, çok yakında geliyorlar."
  },
  RelicConfig_94695_BattleDesc = {
    Text = "Bir Uyanışçı öldürüldüğünde, diğer müttefikler [Arg1] <StrongEffectKeywords:Güçlendirme> kazanır. Bu Etki her Uyanışçı için yalnızca bir kez tetiklenebilir."
  },
  RelicConfig_94695_Desc = {
    Text = "Bir Uyanışçı öldürüldüğünde, diğer müttefikler [Arg1] <StrongEffectKeywords:Güçlendirme> kazanır. Bu Etki her Uyanışçı için yalnızca bir kez tetiklenebilir."
  },
  RelicConfig_94695_Name = {
    Text = "<OrangeQuality:Kara Yıldız Közü>"
  },
  RelicConfig_94696_BattleDesc = {
    Text = "Savaş başladıktan sonra, [Arg1] <PVPDerivativeCardKeywords_21:Kemik Eritici Kucaklayış> elde edilir."
  },
  RelicConfig_94696_Desc = {
    Text = "Savaş başladıktan sonra, [Arg1] <PVPDerivativeCardKeywords_21:Kemik Eritici Kucaklayış> elde edilir."
  },
  RelicConfig_94696_Name = {
    Text = "<OrangeQuality:Canlılık Enjeksiyonu>"
  },
  RelicConfig_94697_BattleDesc = {
    Text = "Tur sonunda, elindeki tüm kartları at ve aynı sayıda kart çek."
  },
  RelicConfig_94697_Desc = {
    Text = "Tur sonunda, elindeki tüm kartları at ve aynı sayıda kart çek."
  },
  RelicConfig_94697_Name = {
    Text = "<OrangeQuality:Büyüleyici Çan>"
  },
  RelicConfig_94698_BattleDesc = {
    Text = "Savaş başladıktan sonra, [Arg1] <PVPDerivativeCardKeywords_22:Son Vuran, En İyi Vurur> ve <PVPDerivativeCardKeywords_23:Kafandaki Sesler> Çekme Desteğine yerleştirilir."
  },
  RelicConfig_94698_Desc = {
    Text = "Savaş başladıktan sonra, [Arg1] <PVPDerivativeCardKeywords_22:Son Vuran, En İyi Vurur> ve <PVPDerivativeCardKeywords_23:Kafandaki Sesler> Çekme Desteğine yerleştirilir."
  },
  RelicConfig_94698_Name = {
    Text = "<OrangeQuality:Alfonso'nun Eseri>"
  },
  RelicConfig_95975_BattleDesc = {
    Text = "El sınırı +1.\nTur başında, eğer elde <DerivativeCardKeywords_111:\"Ruh Yutma\"> yoksa, onu ele koy. \"Doygunluk\" 10’a ulaştığında, <DerivativeCardKeywords_112:\"Hafıza Rezonansı\">na dönüşür."
  },
  RelicConfig_95975_Desc = {
    Text = "El sınırı +1.\nTur başında, eğer elde \"Ruh Yutma\" yoksa, onu ele koy. \"Doygunluk\" 10’a ulaştığında, \"Hafıza Rezonansı\"na dönüşür."
  },
  RelicConfig_95975_Name = {
    Text = "İskelet Kadehi"
  },
  RelicConfig_95975_StoryDesc = {
    Text = "\"Kan Ayı yükselir, cesetler kadehlerini kaldırıp birlikte içecek.\""
  },
  RelicConfig_95976_BattleDesc = {
    Text = "Tur başında Doresain [Arg1] Aliemus ve [Arg2] GÜÇ puanı kazanır. Doresain bir \"Enkaz\" tükettiğinde, Doresain'in Kalıcı GÜÇ'ünün %20'sine eşit Geçici GÜÇ kazan."
  },
  RelicConfig_95976_Desc = {
    Text = "Tur başında Doresain [Arg1] Aliemus ve [Arg2] GÜÇ puanı kazanır. Doresain bir \"Enkaz\" tükettiğinde, Doresain'in Kalıcı GÜÇ'ünün %20'sine eşit Geçici GÜÇ kazan."
  },
  RelicConfig_95976_Name = {
    Text = "<OrangeQuality:Boyutsal Görüntü: Doresain>"
  },
  RelicConfig_96652_BattleDesc = {
    Text = "Tur başında, eldeki 1 Komut Kartına <BurningKeywords2:Yakma> uygula ve 1 yığın <Heat:Karanlık Alev> kazan. <Heat:Karanlık Alev> 3 yığına ulaştığında, 1 <Overload:Sonsuz Yanış> ele koy."
  },
  RelicConfig_96652_Desc = {
    Text = "Tur başında, eldeki 1 Komut Kartına <BurningKeywords2:Yakma> uygula ve 1 yığın <Heat:Karanlık Alev> kazan. <Heat:Karanlık Alev> 3 yığına ulaştığında, 1 <Overload:Sonsuz Yanış> ele koy."
  },
  RelicConfig_96652_Name = {
    Text = "Karanlık Alev"
  },
  RelicConfig_96652_StoryDesc = {
    Text = "Zifiri siyah alevler, onun iradesini infaz edecek, her şeyi küle çevirerek yakacak."
  },
  RelicConfig_97344_BattleDesc = {
    Text = "Eldeki son kartı kaybettiğinde 2 kart çek ve [Arg1] Keyflare kazan. Deste her sıfırlandığında Dokunaç Hasarı +[Arg2]."
  },
  RelicConfig_97344_Desc = {
    Text = "Eldeki son kartı kaybettiğinde 2 kart çek ve [Arg1] Keyflare kazan. Deste her sıfırlandığında Dokunaç Hasarı +[Arg2]."
  },
  RelicConfig_97344_Name = {
    Text = "Şampiyonluk Kupası"
  },
  RelicConfig_97344_StoryDesc = {
    Text = "Bugün, dehşeti unutacağız, Pain’i unutacağız ve sadece karnavalın tadını çıkaracağız."
  },
  RelicConfig_97345_BattleDesc = {
    Text = "Her 3 Komut Kartı oynandığında, 1 Arithmetica kazan ve 1 kart çek. Her bir Aktif Hasar örneği, Geçici Final Hasarı’nı %2 artırır, en fazla %50’ye kadar."
  },
  RelicConfig_97345_Desc = {
    Text = "Her 3 Komut Kartı oynandığında, 1 Arithmetica kazan ve 1 kart çek. Her bir Aktif Hasar örneği, Geçici Final Hasarı’nı %2 artırır, en fazla %50’ye kadar."
  },
  RelicConfig_97345_Name = {
    Text = "Şampiyonluk Kupası"
  },
  RelicConfig_97345_StoryDesc = {
    Text = "Bugün, dehşeti unutacağız, Pain’i unutacağız ve sadece karnavalın tadını çıkaracağız."
  },
  RelicConfig_97346_BattleDesc = {
    Text = "Tüm Uyananların Kritik Oranı +%30. Tek sayılı turların başında, tüm düşmanlar mevcut Canlarının %25’ini kaybeder. Takımının Can yüzdesi düşmanınkinden düşük olduğunda, Final Hasar +%50; takımının Can yüzdesi düşmanınkinden yüksek olduğunda, Yüceltme kullandıktan sonra 35 Aliemus kazan."
  },
  RelicConfig_97346_Desc = {
    Text = "Tüm Uyananların Kritik Oranı +%30. Tek sayılı turların başında, tüm düşmanlar mevcut Canlarının %25’ini kaybeder. Takımının Can yüzdesi düşmanınkinden düşük olduğunda, Final Hasar +%50; takımının Can yüzdesi düşmanınkinden yüksek olduğunda, Yüceltme kullandıktan sonra 35 Aliemus kazan."
  },
  RelicConfig_97346_Name = {
    Text = "Şampiyonluk Kupası"
  },
  RelicConfig_97346_StoryDesc = {
    Text = "Bugün, dehşeti unutacağız, Pain’i unutacağız ve sadece karnavalın tadını çıkaracağız."
  },
  RelicConfig_97347_BattleDesc = {
    Text = "Maksimum Arithmetica 2 artar. Harcanmamış Arithmetica bir sonraki tura devredilebilir. 2’den fazla Arithmetica devredilirse, bir sonraki turun başında tüm Uyananlar 20 Aliemus kazanır; 4’ten fazla Arithmetica devredilirse, bir sonraki turda verilen temel hasar %100 artar."
  },
  RelicConfig_97347_Desc = {
    Text = "Maksimum Arithmetica 2 artar. Harcanmamış Arithmetica bir sonraki tura devredilebilir. 2’den fazla Arithmetica devredilirse, bir sonraki turun başında tüm Uyananlar 20 Aliemus kazanır; 4’ten fazla Arithmetica devredilirse, bir sonraki turda verilen temel hasar %100 artar."
  },
  RelicConfig_97347_Name = {
    Text = "Şampiyonluk Kupası"
  },
  RelicConfig_97347_StoryDesc = {
    Text = "Bugün, dehşeti unutacağız, Pain’i unutacağız ve sadece karnavalın tadını çıkaracağız."
  },
  RelicConfig_98274_BattleDesc = {
    Text = "El Limiti +1. Savaş başlangıcında \"<DerivativeCardKeywords_116:Palet>\" kazan. \nHer tur başlangıcında, 1 \"<PrimaryColor:Renk>\" kazan ve rastgele 2 Komut Kartı'na \"<ColorInkKeywords:Boyama>\" uygula. \"<ColorInkKeywords:Boyama>\" kartı oynamak sırayla 1 \"<PrimaryColor:Renk>\" kazandırır. \nOynanan \"<PrimaryColor:Renk>\" \"<DerivativeCardKeywords_116:Palet>\" üzerine kaydedilir. \"<DerivativeCardKeywords_116:Palet>\" üzerinde 2 farklı \"<PrimaryColor:Renk>\" kayıtlıysa, sürekli güçlendirmeler sağlar. \n\"<DerivativeCardKeywords_116:Palet>\" üzerinde 3 farklı \"<PrimaryColor:Renk>\" kayıtlıysa, tüm düşmanlara anında Maksimum can'ın %5'i kadar hasar ver ve \"<DerivativeCardKeywords_116:Palet>\"i temizle."
  },
  RelicConfig_98274_Desc = {
    Text = "El Limiti +1. Savaş başlangıcında \"<DerivativeCardKeywords_116:Palet>\" kazan. \nHer tur başlangıcında, 1 \"<PrimaryColor:Renk>\" kazan ve rastgele 2 Komut Kartı'na \"<ColorInkKeywords:Boyama>\" uygula. \"<ColorInkKeywords:Boyama>\" kartı oynamak sırayla 1 \"<PrimaryColor:Renk>\" kazandırır. \nOynanan \"<PrimaryColor:Renk>\" \"<DerivativeCardKeywords_116:Palet>\" üzerine kaydedilir. \"<DerivativeCardKeywords_116:Palet>\" üzerinde 2 farklı \"<PrimaryColor:Renk>\" kayıtlıysa, sürekli güçlendirmeler sağlar. \n\"<DerivativeCardKeywords_116:Palet>\" üzerinde 3 farklı \"<PrimaryColor:Renk>\" kayıtlıysa, tüm düşmanlara anında Maksimum can'ın %5'i kadar hasar ver ve \"<DerivativeCardKeywords_116:Palet>\"i temizle."
  },
  RelicConfig_98274_Name = {
    Text = "Kehanet Paleti"
  },
  RelicConfig_98274_StoryDesc = {
    Text = "Görüş Alanı’nda, “sanat”ın doğuşuna tanıklık edeceğiz."
  },
  RelicConfig_98367_BattleDesc = {
    Text = "Tüm Uyanmışların HP İyileştirme ve Karakter Kalkanı temel Etkileri [Arg1]% artar."
  },
  RelicConfig_98367_Desc = {
    Text = "Tüm Uyanmışların HP İyileştirme ve Karakter Kalkanı temel Etkileri [Arg1]% artar."
  },
  RelicConfig_98367_Name = {
    Text = "<WhiteQuality:Yılanın Kabuğu>"
  },
  RelicConfig_98367_StoryDesc = {
    Text = "Kendi kendini sakatlayarak topraktan yeniden doğuş"
  },
  RelicConfig_98368_BattleDesc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Farklı bir Uyandıran tarafından oynanan her Komut Kartı için fazladan [Arg1]% Geçici Hasar Güçlendirmesi kazan."
  },
  RelicConfig_98368_Desc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Farklı bir Uyandıran tarafından oynanan her Komut Kartı için fazladan [Arg1]% Geçici Hasar Güçlendirmesi kazan."
  },
  RelicConfig_98368_Name = {
    Text = "<OrangeQuality:Kaleydoskop+>"
  },
  RelicConfig_98368_StoryDesc = {
    Text = "Düşündüğün ve gördüğün her şey birer düş."
  },
  RelicConfig_98369_BattleDesc = {
    Text = "Keyflare Rouse kullandıktan sonra, bir sonraki oynanıştan önce elindeki en yüksek Arithmetica değerine sahip [Arg1] karta Sakla ve Hazırlan ver ve [Arg2] puan Keyflare kazan."
  },
  RelicConfig_98369_Desc = {
    Text = "Keyflare Rouse kullandıktan sonra, bir sonraki oynanıştan önce elindeki en yüksek Arithmetica değerine sahip [Arg1] karta Sakla ve Hazırlan ver ve [Arg2] puan Keyflare kazan."
  },
  RelicConfig_98369_Name = {
    Text = "<WhiteQuality:Yabancı Pul Albümü>"
  },
  RelicConfig_98369_StoryDesc = {
    Text = "Sayılara dökülmüş bir özlem."
  },
  RelicConfig_98370_BattleDesc = {
    Text = "Savaşın başında, tüm düşmanlara [Arg1] Zayıflık ve Savunmasız uygula. Bu etki \"Yok Oluş\"tan sonra da tetiklenir, ancak 3 tur bekleme süresi vardır."
  },
  RelicConfig_98370_Desc = {
    Text = "Savaş, tüm düşmanlara [Arg1] yığın <WeaknessIconKeywords:Zayıflık> ve <VulnerabilityIconKeywords:Savunmasız> yüklenerek başlar. Bu etki \"Yok Oluş\"tan sonra da tetiklenir, ancak 3 el bekleme süresi vardır."
  },
  RelicConfig_98370_Name = {
    Text = "<WhiteQuality:Uzay Sapma Cihazı>"
  },
  RelicConfig_98370_StoryDesc = {
    Text = "Boşluğa atıl."
  },
  RelicConfig_98371_BattleDesc = {
    Text = "Tur bitmeden önce, elde bir Komut Kartı ait olduğu her Uyanmış [Arg1] Aliemus kazanır."
  },
  RelicConfig_98371_Desc = {
    Text = "Tur bitmeden önce, elde bir Komut Kartı ait olduğu her Uyanmış [Arg1] Aliemus kazanır."
  },
  RelicConfig_98371_Name = {
    Text = "<WhiteQuality:Dengesiz Terazi>"
  },
  RelicConfig_98371_StoryDesc = {
    Text = "Artık adaleti simgelemiyor."
  },
  RelicConfig_98372_BattleDesc = {
    Text = "Tur sonunda, eğer Keyflare doluysa, eline bir <DerivativeCardKeywords_129:\"Gümüş Anahtar Işıltısı\"> eklemek için [Arg1] Keyflare tüketir."
  },
  RelicConfig_98372_Desc = {
    Text = "Tur sonunda, eğer Keyflare doluysa, eline bir <DerivativeCardKeywords_129:\"Gümüş Anahtar Işıltısı\"> eklemek için [Arg1] Keyflare tüketir."
  },
  RelicConfig_98372_Name = {
    Text = "<WhiteQuality:Alacakaranlıkta>"
  },
  RelicConfig_98372_StoryDesc = {
    Text = "Hadi birlikte bir fotoğraf çekinelim! Gerçek acının hissini tat."
  },
  RelicConfig_98373_BattleDesc = {
    Text = "\"Yücelt\" serbest bırakıldığında [Arg1] Anahtar Alevi kazan."
  },
  RelicConfig_98373_Desc = {
    Text = "\"Yücelt\" serbest bırakıldığında [Arg1] Anahtar Alevi kazan."
  },
  RelicConfig_98373_Name = {
    Text = "<OrangeQuality:Geçici Güzellik+>"
  },
  RelicConfig_98373_StoryDesc = {
    Text = "Gelip geçen anların güzelliğini sonsuza dek muhafaza et."
  },
  RelicConfig_98374_BattleDesc = {
    Text = "Her tur ilk \"Posse\"ni kullandıktan sonra, tüm düşmanlara [Arg1] Zehir uygula ve [Arg2] Sayaç kazan."
  },
  RelicConfig_98374_Desc = {
    Text = "Her turdaki ilk \"Posse\"den sonra, tüm düşmanlara [Arg1] yığın <IntoxicationIconKeywords:Zehir> uygula ve [Arg2] yığın <RetaliateIconKeywords:Sayaç> kazan."
  },
  RelicConfig_98374_Name = {
    Text = "<OrangeQuality:Kâhinin Dilek Lambası+>"
  },
  RelicConfig_98374_StoryDesc = {
    Text = "Dileğini yerine getir."
  },
  RelicConfig_98375_BattleDesc = {
    Text = "Tur sonunda, eğer Keyflare doluysa, eline bir <DerivativeCardKeywords_67:\"Gümüş Anahtar Şafağı\"> koymak için [Arg1] Keyflare tüketir."
  },
  RelicConfig_98375_Desc = {
    Text = "Tur sonunda, eğer Keyflare doluysa, eline bir <DerivativeCardKeywords_67:\"Gümüş Anahtar Şafağı\"> koymak için [Arg1] Keyflare tüketir."
  },
  RelicConfig_98375_Name = {
    Text = "<OrangeQuality:Alacakaranlıkta+>"
  },
  RelicConfig_98375_StoryDesc = {
    Text = "Hadi birlikte bir fotoğraf çekinelim! Gerçek acının hissini tat."
  },
  RelicConfig_98376_BattleDesc = {
    Text = "Tüm Uyanmışların HP İyileştirme ve Karakter Kalkanı temel Etkileri [Arg1]% artar."
  },
  RelicConfig_98376_Desc = {
    Text = "Tüm Uyanmışların HP İyileştirme ve Karakter Kalkanı temel Etkileri [Arg1]% artar."
  },
  RelicConfig_98376_Name = {
    Text = "<OrangeQuality:Yılanın Kabuğu+>"
  },
  RelicConfig_98376_StoryDesc = {
    Text = "Kendi kendini sakatlayarak topraktan yeniden doğuş"
  },
  RelicConfig_98377_BattleDesc = {
    Text = "Bir kart Ultra Uzay’a her girdiğinde, bu kartın sahibine ait Çekme Desteği’nden [Arg1] Komut Kartı çek. Çekilemezse, bunun yerine eşit miktarda Arithmetica kazan. Bu etki tur başına en fazla 2 kez tetiklenebilir."
  },
  RelicConfig_98377_Desc = {
    Text = "Bir kart Ultra Uzay’a her girdiğinde, bu kartın sahibine ait Çekme Desteği’nden [Arg1] Komut Kartı çek. Çekilemezse, bunun yerine eşit miktarda Arithmetica kazan. Bu etki tur başına en fazla 2 kez tetiklenebilir."
  },
  RelicConfig_98377_Name = {
    Text = "<WhiteQuality:Üçgen Prizma>"
  },
  RelicConfig_98377_StoryDesc = {
    Text = "\"Işık yedi Ana Renkten oluşur.\""
  },
  RelicConfig_98378_BattleDesc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Hasar aldıktan sonra [Arg2] Sayaç kazan; tur başına en fazla 3 kez tetiklenir."
  },
  RelicConfig_98378_Desc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Hasar aldıktan sonra [Arg2] <RetaliateIconKeywords:Sayaç> kazan; tur başına en fazla 3 kez tetiklenir."
  },
  RelicConfig_98378_Name = {
    Text = "<OrangeQuality:Güvenli Çıkış+>"
  },
  RelicConfig_98378_StoryDesc = {
    Text = "Görünüşe bakılırsa o da dışarı çıkamamış."
  },
  RelicConfig_98379_BattleDesc = {
    Text = "Aktif veya Dokunaç Hasarı verdikten sonra, hedefin aldığı Dokunaç Hasarı bu turun geri kalanı için [Arg1]% artar. Tur başına en fazla 20 kez tetiklenebilir."
  },
  RelicConfig_98379_Desc = {
    Text = "Aktif veya Dokunaç Hasarı verdikten sonra, hedefin aldığı Dokunaç Hasarı bu turun geri kalanı için [Arg1]% artar. Tur başına en fazla 20 kez tetiklenebilir."
  },
  RelicConfig_98379_Name = {
    Text = "<WhiteQuality:Dalış Miğferi>"
  },
  RelicConfig_98379_StoryDesc = {
    Text = "Rüyalar, Yıldızlar ve denizdir!"
  },
  RelicConfig_98380_BattleDesc = {
    Text = "Savaşın başında ve Ölüm Direnci tetiklendikten sonra [Arg1] Keyflare kazan."
  },
  RelicConfig_98380_Desc = {
    Text = "Savaşın başında ve Ölüm Direnci tetiklendikten sonra [Arg1] Keyflare kazan."
  },
  RelicConfig_98380_Name = {
    Text = "<WhiteQuality:Geçmişin Yadigârı>"
  },
  RelicConfig_98380_StoryDesc = {
    Text = "Bir zamanlar sunulmuş bir sunu."
  },
  RelicConfig_98381_BattleDesc = {
    Text = "Keyflare Uyandırma kullanıldıktan sonra [Heal:Arg1] HP yeniler ve [Arg2] Keyflare verir."
  },
  RelicConfig_98381_Desc = {
    Text = "Keyflare Uyandırma kullanıldıktan sonra [Heal:Arg1] HP yeniler ve [Arg2] Keyflare verir."
  },
  RelicConfig_98381_Name = {
    Text = "<WhiteQuality:Gezgin Şemsiyesi>"
  },
  RelicConfig_98381_StoryDesc = {
    Text = "Işıksız Diyar’da Çiçek Aç"
  },
  RelicConfig_98382_BattleDesc = {
    Text = "Savaş başladıktan sonra [Arg1] <ProficientInRealmsIconKeywords:Diyar Ustalığı> kazan. Tek numaralı turların başında [Arg2] kart çek. Çift numaralı turların başında [Arg2] Arithmetica kazan."
  },
  RelicConfig_98382_Desc = {
    Text = "Savaş başladıktan sonra [Arg1] <ProficientInRealmsIconKeywords:Diyar Ustalığı> kazan. Tek numaralı turların başında [Arg2] kart çek. Çift numaralı turların başında [Arg2] Arithmetica kazan."
  },
  RelicConfig_98382_Name = {
    Text = "<OrangeQuality:Güneş Diski+>"
  },
  RelicConfig_98382_StoryDesc = {
    Text = "Tahmin et, siyah mı yoksa beyaz mı?"
  },
  RelicConfig_98383_BattleDesc = {
    Text = "Her tur ilk \"Posse\" etkinleşmesi, tüm Dokunaç Saldırısı’nı düşmanlara karşı [Arg1] kez tetikler ve %50 Hasar verir."
  },
  RelicConfig_98383_Desc = {
    Text = "Her tur ilk \"Posse\" etkinleşmesi, tüm Dokunaç Saldırısı’nı düşmanlara karşı [Arg1] kez tetikler ve %50 Hasar verir."
  },
  RelicConfig_98383_Name = {
    Text = "<OrangeQuality:Sarı Salyangoz+>"
  },
  RelicConfig_98383_StoryDesc = {
    Text = "Bu küçük Sarı Salyangoz, kusursuz ve lekesiz bir kökene sahip, asil bir soydan gelir."
  },
  RelicConfig_98384_BattleDesc = {
    Text = "Tüm Uyananlar [Arg1]% artırılmış Temel Hasar verir. Exalt’ı serbest bırakmadan önce, Exalt’ı serbest bırakan Uyanan’ın verdiği Temel Hasar geçici olarak [Arg2]% artar."
  },
  RelicConfig_98384_Desc = {
    Text = "Tüm Uyananlar [Arg1]% artırılmış Temel Hasar verir. Exalt’ı serbest bırakmadan önce, Exalt’ı serbest bırakan Uyanan’ın verdiği Temel Hasar geçici olarak [Arg2]% artar."
  },
  RelicConfig_98384_Name = {
    Text = "<WhiteQuality:Unutulmuşların Kanı>"
  },
  RelicConfig_98384_StoryDesc = {
    Text = "Yavaş yavaş eriyip kayboluyor."
  },
  RelicConfig_98385_BattleDesc = {
    Text = "Her tur ilk \"Posse\"ni kullandıktan sonra, tüm düşmanlara [Arg1] Zehir uygula ve [Arg2] Sayaç kazan."
  },
  RelicConfig_98385_Desc = {
    Text = "Her turdaki ilk \"Posse\"den sonra, tüm düşmanlara [Arg1] yığın <IntoxicationIconKeywords:Zehir> uygula ve [Arg2] yığın <RetaliateIconKeywords:Sayaç> kazan."
  },
  RelicConfig_98385_Name = {
    Text = "<WhiteQuality:Kâhinin Dilek Lambası>"
  },
  RelicConfig_98385_StoryDesc = {
    Text = "Dileğini yerine getir."
  },
  RelicConfig_98386_BattleDesc = {
    Text = "Tur başında, YP %50’nin altındaysa, Geçici Hasar Güçlendirmesi +[Arg1]%. YP %25’in altındaysa, fazladan [Arg2] kart çek ve [Arg2] Arithmetica kazan."
  },
  RelicConfig_98386_Desc = {
    Text = "Tur başında, YP %50’nin altındaysa, Geçici Hasar Güçlendirmesi +[Arg1]%. YP %25’in altındaysa, fazladan [Arg2] kart çek ve [Arg2] Arithmetica kazan."
  },
  RelicConfig_98386_Name = {
    Text = "<WhiteQuality:Doktor Çantası>"
  },
  RelicConfig_98386_StoryDesc = {
    Text = "Bir doktor kimliğini simgeleyen, oldukça ağır bir evrak çantası.\nOnu açmak, gerçek bir doktora ait olduğunu garanti etmez."
  },
  RelicConfig_98387_BattleDesc = {
    Text = "Savaşın başında, tüm düşmanlara [Arg1] Zayıflık ve Savunmasız uygula. Bu etki \"Yok Oluş\"tan sonra da tetiklenir, ancak 3 tur bekleme süresi vardır."
  },
  RelicConfig_98387_Desc = {
    Text = "Savaş, tüm düşmanlara [Arg1] yığın <WeaknessIconKeywords:Zayıflık> ve <VulnerabilityIconKeywords:Savunmasız> yüklenerek başlar. Bu etki \"Yok Oluş\"tan sonra da tetiklenir, ancak 3 el bekleme süresi vardır."
  },
  RelicConfig_98387_Name = {
    Text = "<OrangeQuality:Uzay Sapma Cihazı+>"
  },
  RelicConfig_98387_StoryDesc = {
    Text = "Boşluğa atıl."
  },
  RelicConfig_98388_BattleDesc = {
    Text = "Savaşın başında ve Ölüm Direnci tetiklendikten sonra [Arg1] Keyflare kazan."
  },
  RelicConfig_98388_Desc = {
    Text = "Savaşın başında ve Ölüm Direnci tetiklendikten sonra [Arg1] Keyflare kazan."
  },
  RelicConfig_98388_Name = {
    Text = "<OrangeQuality:Geçmişin Yadigârı+>"
  },
  RelicConfig_98388_StoryDesc = {
    Text = "Bir zamanlar sunulmuş bir sunu."
  },
  RelicConfig_98389_BattleDesc = {
    Text = "Savaş başladıktan sonra [Arg1] <ProficientInRealmsIconKeywords:Diyar Ustalığı> kazan. Tek numaralı turların başında [Arg2] kart çek. Çift numaralı turların başında [Arg2] Arithmetica kazan."
  },
  RelicConfig_98389_Desc = {
    Text = "Savaş başladıktan sonra [Arg1] <ProficientInRealmsIconKeywords:Diyar Ustalığı> kazan. Tek numaralı turların başında [Arg2] kart çek. Çift numaralı turların başında [Arg2] Arithmetica kazan."
  },
  RelicConfig_98389_Name = {
    Text = "<WhiteQuality:Güneş-Ay Çarkı>"
  },
  RelicConfig_98389_StoryDesc = {
    Text = "Tahmin et, siyah mı yoksa beyaz mı?"
  },
  RelicConfig_98390_BattleDesc = {
    Text = "Her kart çekildiğinde veya atıldığında [Arg1] Geçici GÜÇ kazan, tur başına en fazla 15 kez."
  },
  RelicConfig_98390_Desc = {
    Text = "Bir kart çek veya at, [Arg1] Geçici<PowerIconKeywords:STR> kazan; tur başına en fazla 15 kez tetiklenir."
  },
  RelicConfig_98390_Name = {
    Text = "<WhiteQuality:Sessiz Prelüd>"
  },
  RelicConfig_98390_StoryDesc = {
    Text = "Ünlü kemancı Eric Eckstein’ın kemanı.\nArtık çalınamaz."
  },
  RelicConfig_98391_BattleDesc = {
    Text = "Her turun ilk \"Posse\"si, HP azaldıkça etkisi artacak şekilde, Geçici Hasar Güçlendirmesini [Arg2]% artırır."
  },
  RelicConfig_98391_Desc = {
    Text = "Her turdaki ilk \"Posse\", HP ne kadar düşükse o kadar güçlü olmak üzere Geçici Hasar Güçlendirmesi +[Arg1]% verir."
  },
  RelicConfig_98391_Name = {
    Text = "<WhiteQuality:Harford İksiri>"
  },
  RelicConfig_98391_StoryDesc = {
    Text = "Bileşimi bilinmeyen ilaç.\nÜnlü kemancı Eric'in buna özel bir düşkünlüğü olduğu söylenir."
  },
  RelicConfig_98392_BattleDesc = {
    Text = "Her turun ilk \"Posse\"si, HP azaldıkça etkisi artacak şekilde, Geçici Hasar Güçlendirmesini [Arg2]% artırır."
  },
  RelicConfig_98392_Desc = {
    Text = "Her turdaki ilk \"Posse\", HP ne kadar düşükse o kadar güçlü olmak üzere Geçici Hasar Güçlendirmesi +[Arg1]% verir."
  },
  RelicConfig_98392_Name = {
    Text = "<OrangeQuality:Harford İksiri+>"
  },
  RelicConfig_98392_StoryDesc = {
    Text = "Bileşimi bilinmeyen ilaç.\nÜnlü kemancı Eric'in buna özel bir düşkünlüğü olduğu söylenir."
  },
  RelicConfig_98393_BattleDesc = {
    Text = "Tüm Uyananlar, her turdaki ilk \"Komut Kartı\"ndan [Arg1] Keyflare kazanır."
  },
  RelicConfig_98393_Desc = {
    Text = "Tüm Uyananlar, her turdaki ilk \"Komut Kartı\"ndan [Arg1] Keyflare kazanır."
  },
  RelicConfig_98393_Name = {
    Text = "<WhiteQuality:Tatlı Dil>"
  },
  RelicConfig_98393_StoryDesc = {
    Text = "Sadece tüccarlar değil, inançlı olanlar da etkileyici konuşur."
  },
  RelicConfig_98394_BattleDesc = {
    Text = "Her turdaki ilk \"Posse\", harcanan Keyflare’in [Arg1]%’ini iade eder."
  },
  RelicConfig_98394_Desc = {
    Text = "Her turdaki ilk \"Posse\", harcanan Keyflare’in [Arg1]%’ini iade eder."
  },
  RelicConfig_98394_Name = {
    Text = "<WhiteQuality:Şanslı Tavşan Pençesi>"
  },
  RelicConfig_98394_StoryDesc = {
    Text = "Tavşan için pek de şanslı sayılmaz."
  },
  RelicConfig_98395_BattleDesc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Aktif Hasar verdikten sonra, tüm düşmanlara [Arg2] yığın Zehir uygula; tur başına en fazla 5 kez tetiklenir."
  },
  RelicConfig_98395_Desc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Tüm düşmanlara Aktif Hasar ver ve [Arg2] yığın <IntoxicationIconKeywords:Zehir> uygula; tur başına en fazla 5 kez tetiklenir."
  },
  RelicConfig_98395_Name = {
    Text = "<OrangeQuality:Hierofant Asası+>"
  },
  RelicConfig_98395_StoryDesc = {
    Text = "Yaptırımsız Takva"
  },
  RelicConfig_98396_BattleDesc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Farklı bir Uyandıran tarafından oynanan her Komut Kartı için fazladan [Arg1]% Geçici Hasar Güçlendirmesi kazan."
  },
  RelicConfig_98396_Desc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Farklı bir Uyandıran tarafından oynanan her Komut Kartı için fazladan [Arg1]% Geçici Hasar Güçlendirmesi kazan."
  },
  RelicConfig_98396_Name = {
    Text = "<WhiteQuality:Kaleydoskop>"
  },
  RelicConfig_98396_StoryDesc = {
    Text = "Düşündüğün ve gördüğün her şey birer düş."
  },
  RelicConfig_98397_BattleDesc = {
    Text = "Her tur ikinci \"Posse\" serbest bırakıldığında, [Arg1] Keyflare kazan ve tüm Uyandırıcılar [Arg2] Aliemus kazansın."
  },
  RelicConfig_98397_Desc = {
    Text = "Her tur ikinci \"Posse\" serbest bırakıldığında, [Arg1] Keyflare kazan ve tüm Uyandırıcılar [Arg2] Aliemus kazansın."
  },
  RelicConfig_98397_Name = {
    Text = "<OrangeQuality:Kronometrik Cihaz+>"
  },
  RelicConfig_98397_StoryDesc = {
    Text = "İnsanlık tarihindeki en uğursuz icatlardan biri."
  },
  RelicConfig_98398_BattleDesc = {
    Text = "Savaşın başında tüm düşmanlar [Arg1] Geçici <ExhaustionIconKeywords:Strength> kaybeder. \"Kızıl Ocak\"ı kullanmak da bu Etkiyi tetikler, ancak 3 turluk bekleme süresi vardır."
  },
  RelicConfig_98398_Desc = {
    Text = "Savaşın başında tüm düşmanlar [Arg1] Geçici <ExhaustionIconKeywords:Strength> kaybeder. \"Kızıl Ocak\"ı kullanmak da bu Etkiyi tetikler, ancak 3 turluk bekleme süresi vardır."
  },
  RelicConfig_98398_Name = {
    Text = "<OrangeQuality:Hayalet El+>"
  },
  RelicConfig_98398_StoryDesc = {
    Text = "Öldürmek, yağmalamak ve kaşımak için kusursuz bir araç."
  },
  RelicConfig_98399_BattleDesc = {
    Text = "Her tur ikinci \"Posse\" serbest bırakıldığında, [Arg1] Keyflare kazan ve tüm Uyandırıcılar [Arg2] Aliemus kazansın."
  },
  RelicConfig_98399_Desc = {
    Text = "Her tur ikinci \"Posse\" serbest bırakıldığında, [Arg1] Keyflare kazan ve tüm Uyandırıcılar [Arg2] Aliemus kazansın."
  },
  RelicConfig_98399_Name = {
    Text = "<WhiteQuality:Kronometrik Cihaz>"
  },
  RelicConfig_98399_StoryDesc = {
    Text = "İnsanlık tarihindeki en uğursuz icatlardan biri."
  },
  RelicConfig_98400_BattleDesc = {
    Text = "Her kart çekildiğinde veya atıldığında [Arg1] Geçici GÜÇ kazan, tur başına en fazla 15 kez."
  },
  RelicConfig_98400_Desc = {
    Text = "Bir kart çek veya at, [Arg1] Geçici<PowerIconKeywords:STR> kazan; tur başına en fazla 15 kez tetiklenir."
  },
  RelicConfig_98400_Name = {
    Text = "<OrangeQuality:Sessiz Prelüd+>"
  },
  RelicConfig_98400_StoryDesc = {
    Text = "Ünlü kemancı Eric Eckstein’ın kemanı.\nArtık çalınamaz."
  },
  RelicConfig_98401_BattleDesc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Her turda ilk kez Sayaç elde ettiğinde [Arg2] Arithmetica kazan."
  },
  RelicConfig_98401_Desc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan ve her turda ilk kez <RetaliateIconKeywords:Counter> aldıktan sonra [Arg2] Arithmetica kazan."
  },
  RelicConfig_98401_Name = {
    Text = "<OrangeQuality:Putney Sabah Postası+>"
  },
  RelicConfig_98401_StoryDesc = {
    Text = "En düşünceli tuvalet yoldaşın."
  },
  RelicConfig_98402_BattleDesc = {
    Text = "Aktif veya Dokunaç Hasarı verdikten sonra, hedefin aldığı Dokunaç Hasarı bu turun geri kalanı için [Arg1]% artar. Tur başına en fazla 20 kez tetiklenebilir."
  },
  RelicConfig_98402_Desc = {
    Text = "Aktif veya Dokunaç Hasarı verdikten sonra, hedefin aldığı Dokunaç Hasarı bu turun geri kalanı için [Arg1]% artar. Tur başına en fazla 20 kez tetiklenebilir."
  },
  RelicConfig_98402_Name = {
    Text = "<OrangeQuality:Dalış Miğferi+>"
  },
  RelicConfig_98402_StoryDesc = {
    Text = "Rüyalar, Yıldızlar ve denizdir!"
  },
  RelicConfig_98403_BattleDesc = {
    Text = "Savaşın başında [Arg1] GÜÇ kazan. Her \"Tüketme\" kartı oynandığında, tur başına en fazla 10 tetiklenmeye kadar [Arg2] Geçici GÜÇ kazan."
  },
  RelicConfig_98403_Desc = {
    Text = "Savaşın başında [Arg1] <PowerIconKeywords:GÜÇ> kazan. Her \"Tüketme\" yazan kart oynadığında, tur başına en fazla 10 kez tetiklenmek üzere [Arg2] Geçici <PowerIconKeywords:GÜÇ> kazan."
  },
  RelicConfig_98403_Name = {
    Text = "<OrangeQuality:Küçük Müzik Kutusu+>"
  },
  RelicConfig_98403_StoryDesc = {
    Text = "Dexter’ın malikanesinde pek çok koleksiyon vardır. Kırılmadan önce, küçük müzik kutusu Bayan Dexter’ın en sevdiği oyuncaktı.\nZaman geçti; Bayan Dexter onu yeniden bulduğunda dişlileri gevşemiş, melodisi falsoluymuş, ama dönmeye hâlâ devam ediyordu."
  },
  RelicConfig_98404_BattleDesc = {
    Text = "\"Yücelt\" serbest bırakıldığında [Arg1] Anahtar Alevi kazan."
  },
  RelicConfig_98404_Desc = {
    Text = "\"Yücelt\" serbest bırakıldığında [Arg1] Anahtar Alevi kazan."
  },
  RelicConfig_98404_Name = {
    Text = "<WhiteQuality:Geçici Güzellik>"
  },
  RelicConfig_98404_StoryDesc = {
    Text = "Gelip geçen anların güzelliğini sonsuza dek muhafaza et."
  },
  RelicConfig_98405_BattleDesc = {
    Text = "Tüm Uyananlar, her turdaki ilk \"Komut Kartı\"ndan [Arg1] Keyflare kazanır."
  },
  RelicConfig_98405_Desc = {
    Text = "Tüm Uyananlar, her turdaki ilk \"Komut Kartı\"ndan [Arg1] Keyflare kazanır."
  },
  RelicConfig_98405_Name = {
    Text = "<OrangeQuality:Tatlı Dil+>"
  },
  RelicConfig_98405_StoryDesc = {
    Text = "Sadece tüccarlar değil, inançlı olanlar da etkileyici konuşur."
  },
  RelicConfig_98406_BattleDesc = {
    Text = "Her 1 \"Embryo\" üretildiğinde, tur başına en fazla 3 kez olmak üzere [Arg1] Kızıl Ocak kazan."
  },
  RelicConfig_98406_Desc = {
    Text = "Her 1 \"Embryo\" üretildiğinde, tur başına en fazla 3 kez olmak üzere [Arg1] Kızıl Ocak kazan."
  },
  RelicConfig_98406_Name = {
    Text = "<OrangeQuality:Sevgili Yavrum+>"
  },
  RelicConfig_98406_StoryDesc = {
    Text = "Marangoz, karısı için, rahmindeki oğullarının yerini alacak, canlıymış gibi bir kukla yaptı."
  },
  RelicConfig_98407_BattleDesc = {
    Text = "Her turdaki ilk \"Posse\", harcanan Keyflare’in [Arg1]%’ini iade eder."
  },
  RelicConfig_98407_Desc = {
    Text = "Her turdaki ilk \"Posse\", harcanan Keyflare’in [Arg1]%’ini iade eder."
  },
  RelicConfig_98407_Name = {
    Text = "<OrangeQuality:Şanslı Tavşan Pençesi+>"
  },
  RelicConfig_98407_StoryDesc = {
    Text = "Tavşan için pek de şanslı sayılmaz."
  },
  RelicConfig_98408_BattleDesc = {
    Text = "Tur başında, Aliemus’u Exalt’ı serbest bırakmak için yetersiz olan tüm Uyananlar [Arg1] Aliemus kazanır."
  },
  RelicConfig_98408_Desc = {
    Text = "Tur başında, Aliemus’u Exalt’ı serbest bırakmak için yetersiz olan tüm Uyananlar [Arg1] Aliemus kazanır."
  },
  RelicConfig_98408_Name = {
    Text = "<WhiteQuality:Sürpriz Anı>"
  },
  RelicConfig_98408_StoryDesc = {
    Text = "Eğlencesinin tadını çıkar, ama sakın yeme."
  },
  RelicConfig_98409_BattleDesc = {
    Text = "Savaşın başında tüm düşmanlar [Arg1] Geçici <ExhaustionIconKeywords:Strength> kaybeder. \"Kızıl Ocak\"ı kullanmak da bu Etkiyi tetikler, ancak 3 turluk bekleme süresi vardır."
  },
  RelicConfig_98409_Desc = {
    Text = "Savaşın başında tüm düşmanlar [Arg1] Geçici <ExhaustionIconKeywords:Strength> kaybeder. \"Kızıl Ocak\"ı kullanmak da bu Etkiyi tetikler, ancak 3 turluk bekleme süresi vardır."
  },
  RelicConfig_98409_Name = {
    Text = "<WhiteQuality:Hayalet El>"
  },
  RelicConfig_98409_StoryDesc = {
    Text = "Öldürmek, yağmalamak ve kaşımak için kusursuz bir araç."
  },
  RelicConfig_98410_BattleDesc = {
    Text = "Her 1 \"Embryo\" üretildiğinde, tur başına en fazla 3 kez olmak üzere [Arg1] Kızıl Ocak kazan."
  },
  RelicConfig_98410_Desc = {
    Text = "Her 1 \"Embryo\" üretildiğinde, tur başına en fazla 3 kez olmak üzere [Arg1] Kızıl Ocak kazan."
  },
  RelicConfig_98410_Name = {
    Text = "<WhiteQuality:Sevgili Yavrum>"
  },
  RelicConfig_98410_StoryDesc = {
    Text = "Marangoz, karısı için, rahmindeki oğullarının yerini alacak, canlıymış gibi bir kukla yaptı."
  },
  RelicConfig_98411_BattleDesc = {
    Text = "Tur başında, Keyflare [Arg1]’den büyükse, [Arg1] Keyflare tüketerek eline 1 adet <DerivativeCardKeywords_115:\"İleri Kavrayış\"> koy."
  },
  RelicConfig_98411_Desc = {
    Text = "Tur başında, Keyflare [Arg1]’den büyükse, [Arg1] Keyflare tüketerek eline 1 adet <DerivativeCardKeywords_115:\"İleri Kavrayış\"> koy."
  },
  RelicConfig_98411_Name = {
    Text = "<RedQuality:Kâbus Tezahürü>"
  },
  RelicConfig_98411_StoryDesc = {
    Text = "Dikkat et, müsamahakâr derin uyku, farkına bile varmadan her şeyi Yutma ile yok eder."
  },
  RelicConfig_98412_BattleDesc = {
    Text = "\"Exalt\" her 5 kez kullanıldığında, sonraki [Arg1] Türetilmemiş Komut Kartı 1 kez daha etkisini gösterir."
  },
  RelicConfig_98412_Desc = {
    Text = "\"Exalt\" her 5 kez kullanıldığında, sonraki [Arg1] Türetilmemiş Komut Kartı 1 kez daha etkisini gösterir."
  },
  RelicConfig_98412_Name = {
    Text = "<OrangeQuality:Yıldız Demlemesi+>"
  },
  RelicConfig_98412_StoryDesc = {
    Text = "Yıldızların Arasında dolaşmak."
  },
  RelicConfig_98413_BattleDesc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Hasar aldıktan sonra [Arg2] Sayaç kazan; tur başına en fazla 3 kez tetiklenir."
  },
  RelicConfig_98413_Desc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Hasar aldıktan sonra [Arg2] <RetaliateIconKeywords:Sayaç> kazan; tur başına en fazla 3 kez tetiklenir."
  },
  RelicConfig_98413_Name = {
    Text = "<WhiteQuality:Güvenli Çıkış>"
  },
  RelicConfig_98413_StoryDesc = {
    Text = "Görünüşe bakılırsa o da dışarı çıkamamış."
  },
  RelicConfig_98414_BattleDesc = {
    Text = "Tüm Uyananlar [Arg1]% artırılmış Temel Hasar verir. Exalt’ı serbest bırakmadan önce, Exalt’ı serbest bırakan Uyanan’ın verdiği Temel Hasar geçici olarak [Arg2]% artar."
  },
  RelicConfig_98414_Desc = {
    Text = "Tüm Uyananlar [Arg1]% artırılmış Temel Hasar verir. Exalt’ı serbest bırakmadan önce, Exalt’ı serbest bırakan Uyanan’ın verdiği Temel Hasar geçici olarak [Arg2]% artar."
  },
  RelicConfig_98414_Name = {
    Text = "<OrangeQuality:Unutulmuşların Kanı+>"
  },
  RelicConfig_98414_StoryDesc = {
    Text = "Yavaş yavaş eriyip kayboluyor."
  },
  RelicConfig_98415_BattleDesc = {
    Text = "Keyflare Uyandırma kullanıldıktan sonra [Heal:Arg1] HP yeniler ve [Arg2] Keyflare verir."
  },
  RelicConfig_98415_Desc = {
    Text = "Keyflare Uyandırma kullanıldıktan sonra [Heal:Arg1] HP yeniler ve [Arg2] Keyflare verir."
  },
  RelicConfig_98415_Name = {
    Text = "<OrangeQuality:Gezgin Şemsiyesi+>"
  },
  RelicConfig_98415_StoryDesc = {
    Text = "Işıksız Diyar’da Çiçek Aç"
  },
  RelicConfig_98416_BattleDesc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Her turda ilk kez Sayaç elde ettiğinde [Arg2] Arithmetica kazan."
  },
  RelicConfig_98416_Desc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan ve her turda ilk kez <RetaliateIconKeywords:Counter> aldıktan sonra [Arg2] Arithmetica kazan."
  },
  RelicConfig_98416_Name = {
    Text = "<WhiteQuality:Putney Sabah Postası>"
  },
  RelicConfig_98416_StoryDesc = {
    Text = "En düşünceli tuvalet yoldaşın."
  },
  RelicConfig_98417_BattleDesc = {
    Text = "Tur başında, Aliemus’u Exalt’ı serbest bırakmak için yetersiz olan tüm Uyananlar [Arg1] Aliemus kazanır."
  },
  RelicConfig_98417_Desc = {
    Text = "Tur başında, Aliemus’u Exalt’ı serbest bırakmak için yetersiz olan tüm Uyananlar [Arg1] Aliemus kazanır."
  },
  RelicConfig_98417_Name = {
    Text = "<OrangeQuality:Sürpriz Anı+>"
  },
  RelicConfig_98417_StoryDesc = {
    Text = "Eğlencesinin tadını çıkar, ama sakın yeme."
  },
  RelicConfig_98418_BattleDesc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Her turda Zehir ilk kez uygulandığında [Arg2] kart çek."
  },
  RelicConfig_98418_Desc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Her turda ilk kez <IntoxicationIconKeywords:Poison> uyguladıktan sonra [Arg2] kart çek."
  },
  RelicConfig_98418_Name = {
    Text = "<OrangeQuality:Rhind Papirüsü+>"
  },
  RelicConfig_98418_StoryDesc = {
    Text = "İşte soru: 10 rahip hazretleri 6 somun ekmeği paylaşır. Her rahip hazretlerine ne kadar düşer?"
  },
  RelicConfig_98419_BattleDesc = {
    Text = "\"Exalt\" her 5 kez kullanıldığında, sonraki [Arg1] Türetilmemiş Komut Kartı 1 kez daha etkisini gösterir."
  },
  RelicConfig_98419_Desc = {
    Text = "\"Exalt\" her 5 kez kullanıldığında, sonraki [Arg1] Türetilmemiş Komut Kartı 1 kez daha etkisini gösterir."
  },
  RelicConfig_98419_Name = {
    Text = "<WhiteQuality:Yıldız Demlemesi>"
  },
  RelicConfig_98419_StoryDesc = {
    Text = "Yıldızların Arasında dolaşmak."
  },
  RelicConfig_98420_BattleDesc = {
    Text = "Bir kart Ultra Uzay’a her girdiğinde, bu kartın sahibine ait Çekme Desteği’nden [Arg1] Komut Kartı çek. Çekilemezse, bunun yerine eşit miktarda Arithmetica kazan. Bu etki tur başına en fazla 2 kez tetiklenebilir."
  },
  RelicConfig_98420_Desc = {
    Text = "Bir kart Ultra Uzay’a her girdiğinde, bu kartın sahibine ait Çekme Desteği’nden [Arg1] Komut Kartı çek. Çekilemezse, bunun yerine eşit miktarda Arithmetica kazan. Bu etki tur başına en fazla 2 kez tetiklenebilir."
  },
  RelicConfig_98420_Name = {
    Text = "<OrangeQuality:Üçgen Prizma+>"
  },
  RelicConfig_98420_StoryDesc = {
    Text = "\"Işık yedi Ana Renkten oluşur.\""
  },
  RelicConfig_98421_BattleDesc = {
    Text = "Keyflare Rouse kullandıktan sonra, bir sonraki oynanıştan önce elindeki en yüksek Arithmetica değerine sahip [Arg1] karta Sakla ve Hazırlan ver ve [Arg2] puan Keyflare kazan."
  },
  RelicConfig_98421_Desc = {
    Text = "Keyflare Rouse kullandıktan sonra, bir sonraki oynanıştan önce elindeki en yüksek Arithmetica değerine sahip [Arg1] karta Sakla ve Hazırlan ver ve [Arg2] puan Keyflare kazan."
  },
  RelicConfig_98421_Name = {
    Text = "<OrangeQuality:Yabancı Pul Albümü+>"
  },
  RelicConfig_98421_StoryDesc = {
    Text = "Sayılara dökülmüş bir özlem."
  },
  RelicConfig_98422_BattleDesc = {
    Text = "Tur bitmeden önce, elde bir Komut Kartı ait olduğu her Uyanmış [Arg1] Aliemus kazanır."
  },
  RelicConfig_98422_Desc = {
    Text = "Tur bitmeden önce, elde bir Komut Kartı ait olduğu her Uyanmış [Arg1] Aliemus kazanır."
  },
  RelicConfig_98422_Name = {
    Text = "<OrangeQuality:Dengesiz Terazi+>"
  },
  RelicConfig_98422_StoryDesc = {
    Text = "Artık adaleti simgelemiyor."
  },
  RelicConfig_98423_BattleDesc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Aktif Hasar verdikten sonra, tüm düşmanlara [Arg2] yığın Zehir uygula; tur başına en fazla 5 kez tetiklenir."
  },
  RelicConfig_98423_Desc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Tüm düşmanlara Aktif Hasar ver ve [Arg2] yığın <IntoxicationIconKeywords:Zehir> uygula; tur başına en fazla 5 kez tetiklenir."
  },
  RelicConfig_98423_Name = {
    Text = "<WhiteQuality:Hierofant Asası>"
  },
  RelicConfig_98423_StoryDesc = {
    Text = "Yaptırımsız Takva"
  },
  RelicConfig_98424_BattleDesc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Her turda Zehir ilk kez uygulandığında [Arg2] kart çek."
  },
  RelicConfig_98424_Desc = {
    Text = "Savaşın başında [Arg1]% Hasar Güçlendirmesi kazan. Her turda ilk kez <IntoxicationIconKeywords:Poison> uyguladıktan sonra [Arg2] kart çek."
  },
  RelicConfig_98424_Name = {
    Text = "<WhiteQuality:Rhind Papirüsü>"
  },
  RelicConfig_98424_StoryDesc = {
    Text = "İşte soru: 10 rahip hazretleri 6 somun ekmeği paylaşır. Her rahip hazretlerine ne kadar düşer?"
  },
  RelicConfig_98425_BattleDesc = {
    Text = "Savaşın başında [Arg1] GÜÇ kazan. Her \"Tüketme\" kartı oynandığında, tur başına en fazla 10 tetiklenmeye kadar [Arg2] Geçici GÜÇ kazan."
  },
  RelicConfig_98425_Desc = {
    Text = "Savaşın başında [Arg1] <PowerIconKeywords:GÜÇ> kazan. Her \"Tüketme\" yazan kart oynadığında, tur başına en fazla 10 kez tetiklenmek üzere [Arg2] Geçici <PowerIconKeywords:GÜÇ> kazan."
  },
  RelicConfig_98425_Name = {
    Text = "<WhiteQuality:Küçük Müzik Kutusu>"
  },
  RelicConfig_98425_StoryDesc = {
    Text = "Dexter’ın malikanesinde pek çok koleksiyon vardır. Kırılmadan önce, küçük müzik kutusu Bayan Dexter’ın en sevdiği oyuncaktı.\nZaman geçti; Bayan Dexter onu yeniden bulduğunda dişlileri gevşemiş, melodisi falsoluymuş, ama dönmeye hâlâ devam ediyordu."
  },
  RelicConfig_98426_BattleDesc = {
    Text = "Her tur ilk \"Posse\" etkinleşmesi, tüm Dokunaç Saldırısı’nı düşmanlara karşı [Arg1] kez tetikler ve %50 Hasar verir."
  },
  RelicConfig_98426_Desc = {
    Text = "Her tur ilk \"Posse\" etkinleşmesi, tüm Dokunaç Saldırısı’nı düşmanlara karşı [Arg1] kez tetikler ve %50 Hasar verir."
  },
  RelicConfig_98426_Name = {
    Text = "<WhiteQuality:Sarı Salyangoz>"
  },
  RelicConfig_98426_StoryDesc = {
    Text = "Bu küçük Sarı Salyangoz, kusursuz ve lekesiz bir kökene sahip, asil bir soydan gelir."
  },
  RelicConfig_98427_BattleDesc = {
    Text = "Tur başında, YP %50’nin altındaysa, Geçici Hasar Güçlendirmesi +[Arg1]%. YP %25’in altındaysa, fazladan [Arg2] kart çek ve [Arg2] Arithmetica kazan."
  },
  RelicConfig_98427_Desc = {
    Text = "Tur başında, YP %50’nin altındaysa, Geçici Hasar Güçlendirmesi +[Arg1]%. YP %25’in altındaysa, fazladan [Arg2] kart çek ve [Arg2] Arithmetica kazan."
  },
  RelicConfig_98427_Name = {
    Text = "<OrangeQuality:Doktor Çantası+>"
  },
  RelicConfig_98427_StoryDesc = {
    Text = "Bir doktor kimliğini simgeleyen, oldukça ağır bir evrak çantası.\nOnu açmak, gerçek bir doktora ait olduğunu garanti etmez."
  },
  RelicConfig_98891_BattleDesc = {
    Text = "Savaş başladıktan sonra 5 yığın \"<LostWay:Kayıp>\" kazan ve her 3 Komut Kartı oynandığında 1 yığın azalt.\nTüm \"<LostWay:Kayıp>\" kaldırıldıktan sonra, tüm Uyananlar 100 Aliemus kazanır. Her 3 kart oynandığında, [Arg1] Can yenile ve ön sıradaki düşmana, düşmanın Maksimum Canının %1'ine eşit <Corrosion:Aşınma> uygula."
  },
  RelicConfig_98891_Desc = {
    Text = "Savaş başladıktan sonra 5 yığın \"<LostWay:Kayıp>\" kazan ve her 3 Komut Kartı oynandığında 1 yığın azalt.\nTüm \"<LostWay:Kayıp>\" kaldırıldıktan sonra, tüm Uyananlar 100 Aliemus kazanır. Her 3 kart oynandığında, [Arg1] Can yenile ve ön sıradaki düşmana, düşmanın Maksimum Canının %1'ine eşit <Corrosion:Aşınma> uygula."
  },
  RelicConfig_98891_Name = {
    Text = "Kurtuluş Kandili"
  },
  RelicConfig_98891_StoryDesc = {
    Text = "Deneyim soluk olsa da, kurtuluşun Fener’i ölümün ortasında sonunda yeniden parlakça yanacak."
  }
})
return Text_RelicConfig
