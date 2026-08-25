__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Event = readonly({
  Event_116371_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_116371_Desc = {
    Text = "Kamu menerima permintaan kontak dari sekolah, suara yang familiar membuatmu merasa tenang. Kamu mengumpulkan Roh dan melanjutkan langkah."
  },
  Event_116371_Name = {
    Text = "Persimpangan"
  },
  Event_116372_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_116372_Desc = {
    Text = "Kamu memicu ruang yang tidak diketahui."
  },
  Event_116372_Name = {
    Text = "Tidak diketahui"
  },
  Event_116373_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_116373_Desc = {
    Text = "Kamu menemukan harta karun."
  },
  Event_116373_Name = {
    Text = "Harta Karun"
  },
  Event_116374_ChoiceDesc1 = {
    Text = "[Menghubungkan] Pulihkan Arg2 poin Hidup."
  },
  Event_116374_Desc = {
    Text = "Kamu menjelajahi dalam kabut, tiba-tiba, lencana sekolah di dada memancarkan cahaya perak yang lemah. Siapa yang memanggil dari sisi lain komunikator?"
  },
  Event_116374_Name = {
    Text = "Persimpangan"
  },
  Event_116389_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_116389_Desc = {
    Text = "Cubitan masih tidur...zzZZ"
  },
  Event_116389_Name = {Text = "Cubitan"},
  Event_116429_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_116429_Desc = {
    Text = "Kamu memicu Acara Acak 3."
  },
  Event_116429_Name = {
    Text = "Acara Acak 3"
  },
  Event_116430_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_116430_Desc = {
    Text = "Kamu memicu Acara Acak 1."
  },
  Event_116430_Name = {
    Text = "Acara Acak 1"
  },
  Event_116431_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_116431_Desc = {
    Text = "Kamu memicu Acara Acak 2."
  },
  Event_116431_Name = {
    Text = "Acara Acak 2"
  },
  Event_117279_ChoiceDesc1 = {
    Text = "[Kau Pernah Mencita Keceriaan]Memasukkan 3 kartu[(Skill.Arg1)]ke dalam dek kartu."
  },
  Event_117279_Desc = {
    Text = [[

Kabut tipis naik di atas permukaan laut, menyelimuti segala sesuatu dalam suasana yang samar-samar.
Melewati batas antara hidup dan mati, melintasi jarak dalam dan luar Pintu, melintasi memori yang pudar dengan panjang, kamu melihat sosok seorang wanita berpayung di balik cahaya.
Waktu yang dihabiskan bersamanya telah berlalu, seperti warna cerah namun tipis dari masa mudanya yang indah.
Menunggu matahari palsu terbit, kabut pecah menjadi tak terlihat, bayangannya juga bergoyang dalam mimpi menjadi gelembung ilusi yang ringan, memberikan perpisahan tanpa suara kepadamu.]]
  },
  Event_117279_Name = {
    Text = "Fatamorgana Murphy"
  },
  Event_117280_ChoiceDesc1 = {
    Text = "[Kamu Pernah Menginginkan Kepolosan]Pilih 2 Kartu untuk diberikan Orison [Gema Samudera]."
  },
  Event_117280_Desc = {
    Text = [[

Kabut tipis naik di atas permukaan laut, menyelimuti segala sesuatu dalam suasana yang samar-samar.
Melewati batas antara hidup dan mati, melintasi jarak dalam dan luar Pintu, melintasi memori yang pudar dengan panjang, kamu melihat sosok seorang wanita berpayung di balik cahaya.
Waktu yang dihabiskan bersamanya telah berlalu, seperti warna cerah namun tipis dari masa mudanya yang indah.
Menunggu matahari palsu terbit, kabut pecah menjadi tak terlihat, bayangannya juga bergoyang dalam mimpi menjadi gelembung ilusi yang ringan, memberikan perpisahan tanpa suara kepadamu.]]
  },
  Event_117280_Name = {
    Text = "Fatamorgana Murphy"
  },
  Event_118414_ChoiceDesc1 = {
    Text = "[Tiga Poin]"
  },
  Event_118414_ChoiceDesc2 = {Text = "[Enam]"},
  Event_118414_ChoiceDesc3 = {
    Text = "[Satu Titik]"
  },
  Event_118414_Desc = {
    Text = [[
Dadu berputar, mengeluarkan suara bergulung. 
Kapan ia akan berhenti? 
Kamu tidak tahu, tetapi kamu harus memberikan jawaban.]]
  },
  Event_118414_Name = {
    Text = "Perjudian Takdir"
  },
  Event_118415_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118415_Desc = {
    Text = [[
Responsmu membuat "langit" semakin lembut.
Ia perlahan mendaratkan sebuah ciuman di dahimu.
Kemudian, di dahimu mekar setangkai buih ombak.]]
  },
  Event_118415_Name = {
    Text = "Pelukan Lautan"
  },
  Event_118416_ChoiceDesc1 = {
    Text = "[Tenggelam dalam Ilusi] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_118416_ChoiceDesc2 = {
    Text = "[Pertahankan Kewarasan] Setiap ada satu Pembangun dengan nilai Aliemus 50 atau lebih, dapatkan 15 Segil hitam."
  },
  Event_118416_ChoiceDesc3 = {
    Text = "[Pergi Paksa] Mendapatkan 1 dari 3 pilihan Orison"
  },
  Event_118416_Desc = {
    Text = [[
Mungkin pertempuran yang berkepanjangan membuatmu linglung, atau mungkin otakmu mengkhianati tubuhmu.
Semacam perasaan tanpa bobot muncul di benakmu.
Dalam sekejap, pikiranmu tiba-tiba berubah menjadi kaleidoskop, gemerlap, berwarna-warni, berkilauan dengan cahaya beraneka warna.
Inspirasi, misteri, dan khayalan liar yang tak terhitung jumlahnya memenuhi otakmu, mengisi setiap sudut lekukan otakmu.
Jika terus begini, otakmu akan segera meledak oleh semua hal yang kacau balau ini.]]
  },
  Event_118416_Name = {
    Text = "Kaleidoskop Pikiran"
  },
  Event_118417_ChoiceDesc1 = {
    Text = "[Ikut berjudi] Infeksi [(Skill.Arg1)], masuk ke dalam permainan judi"
  },
  Event_118417_ChoiceDesc2 = {
    Text = "[Lebih baik tidak] mendapatkan 25 Segil hitam"
  },
  Event_118417_Desc = {
    Text = [[
Dalam sekejap kebingungan, kesadaranmu menembus lapisan kabut dan melayang ke ruang yang tak dikenal. 
Dua dadu dilemparkan ke hadapanmu, namun keberadaan tak dikenal yang memaksamu kemari masih belum menampakkan diri. 
Kamu hanya bisa mendengar suara kacau dari segala arah milik keberadaan itu. 
 "Ingin kembali? Kalau begitu, ayo mainkan satu ronde."
 "Dengan nyawamu sebagai taruhannya, berjudilah melawan takdir."]]
  },
  Event_118417_Name = {
    Text = "Perjudian Takdir"
  },
  Event_118418_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118418_Desc = {
    Text = [[
Pengalaman transenden selalu singkat. Mereka datang tanpa suara, lalu menghilang tiba-tiba.
Tapi setidaknya kepalamu masih di sini, tidak benar-benar meledak.]]
  },
  Event_118418_Name = {
    Text = "Kaleidoskop Pikiran"
  },
  Event_118419_ChoiceDesc1 = {
    Text = "[Peroleh] Relik perak [(RelicConfig.Arg1)]"
  },
  Event_118419_Desc = {
    Text = [[
Kamu tidak kalah, tapi juga tidak menang. Hasilnya tidak baik dan tidak buruk.
 "Seri..."
Keberadaan tak dikenal itu menghela napas, namun tak terdengar penyesalan dalam suaranya.
 "Sungguh hiburan yang menyenangkan."]]
  },
  Event_118419_Name = {
    Text = "Perjudian Takdir"
  },
  Event_118420_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118420_Desc = {
    Text = [[
Perlahan-lahan, alunan musik yang kacau itu terdengar harmonis dan suci di telingamu.
Akhirnya kau tersadar, memahami mengapa ia disebut "Kidung Sempurna".
Karena memang benar-benar "sempurna tanpa cela".]]
  },
  Event_118420_Name = {
    Text = "Kidung \"Sempurna\""
  },
  Event_118421_ChoiceDesc1 = {
    Text = "[Merasakan Otak] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_118421_ChoiceDesc2 = {
    Text = "[Rasakan Jiwa] Infeksi [(Skill.Arg1)], Orison ulang, maksimal 2 kali"
  },
  Event_118421_Desc = {
    Text = [[
Sangkar pertama manusia adalah tubuhnya sendiri.
Di dalam sangkar tubuh ini, otak adalah penjara terakhir sekaligus terpenting.
 "Sayang, kau pikir kau hidup, masih bernapas, dan aman?"
Ketika otakmu mengkhianati jiwamu, kau akan merasakan siksaan paling menyakitkan di dunia.
Dan siksaan itu akan menemanimu seumur hidup.]]
  },
  Event_118421_Name = {
    Text = "Penjara Otak"
  },
  Event_118422_ChoiceDesc1 = {
    Text = "[Menyentuh Kupu-kupu] Hapus 2 Kartu"
  },
  Event_118422_ChoiceDesc2 = {
    Text = "[Mengusir Kupu-kupu] Mendapatkan Relic terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_118422_ChoiceDesc3 = {
    Text = "[Pergi]mendapatkan Arg1 Segil hitam"
  },
  Event_118422_Desc = {
    Text = [[
Tidak ada kupu-kupu di dasar laut. Gadis yang dikurung di dalam kamar itulah yang membayangkan makhluk-makhluk hidup ini.
Mereka begitu indah, menari dengan bebas di udara.
 "Seandainya... seandainya aku juga bisa seperti mereka, terbang meninggalkan tempat ini..."
Seekor kupu-kupu mengeluarkan isak tangis, namun suara itu tertutup oleh kepakan sayap yang tak terhitung jumlahnya, tertutup oleh bunyi ketikan yang berdetak-detak, nyaris tak terdengar.]]
  },
  Event_118422_Name = {
    Text = "Jiwa Menari Bagai Kupu-kupu"
  },
  Event_118423_ChoiceDesc1 = {
    Text = "[Potong talinya]terinfeksi「(Skill.Arg1)」, mendapatkan Relik terkutuk「(RelicConfig.Arg2)」"
  },
  Event_118423_ChoiceDesc2 = {
    Text = "[Lepaskan ikatannya]terinfeksi dua kali「(Skill.Arg1)」, mendapatkan Relik perak「(RelicConfig.Arg2)」serta「(RelicConfig.Arg3)」"
  },
  Event_118423_ChoiceDesc3 = {
    Text = "[Bantu dia bebas]mendapatkan Relik perak「(RelicConfig.Arg1)」"
  },
  Event_118423_Desc = {
    Text = [[
"Ada yang bilang, hasrat tanpa batas adalah kekuatan pendorong yang membuat orang maju."
 "Tapi ketika hasrat ini begitu kuat hingga tak bisa diabaikan, tak bisa diputus, aku hanya merasa hasrat dari dalam diriku sendiri ini telah berubah menjadi sangkar yang memenjarakanku."
Dari kegelapan terdengar suara yang lemah tak bertenaga, kau tak bisa melihat wajah mereka, hanya sepasang tangan yang terikat.
 "Hasrat-hasrat ini memakan ketakutan, kepengecut, harapan, dan penderitaanku, lalu sebaliknya memperkuat hasratku."
Suara lemah tak bertenaga itu mengeluarkan permohonan terakhir.
 "Aku rela menyerahkan segalanya! Orang baik, selamatkanlah aku... atau berikanlah aku kebebasan..."]]
  },
  Event_118423_Name = {
    Text = "Hasrat yang Membelenggu"
  },
  Event_118424_ChoiceDesc1 = {
    Text = "[Merasakan Otak] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_118424_Desc = {
    Text = [[
Kamu merasakan sumsum otakmu berkedut sesaat.
 "Apakah ini memiliki makna khusus?"
Kamu bertanya pada dirimu sendiri, namun otak tetap hening.
Tidak setiap pertanyaan tentang diri sendiri bisa mendapatkan jawaban.]]
  },
  Event_118424_Name = {
    Text = "Penjara Otak"
  },
  Event_118425_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118425_Desc = {
    Text = [[
Kau berenang sekuat tenaga, akhirnya muncul di permukaan air.
Udara bercampur bau ikan laut mengalir ke paru-parumu, mengingatkanmu bahwa kau belum benar-benar melarikan diri dari bahaya.
Tetapi kau tahu, langit yang sebenarnya ada di atas kepalamu.
Seperti kebenaran, tidak akan pernah disembunyikan oleh kebohongan lembut.]]
  },
  Event_118425_Name = {
    Text = "Pelukan Lautan"
  },
  Event_118426_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118426_Desc = {
    Text = [[
Saat kau menyentuh tali hasrat itu, rasa perih muncul dari kedalaman jiwamu.
Ketakutan, kelemahan, harapan, dan penderitaanmu semuanya meluap dari dalam tubuhmu, berubah menjadi tali berlumuran darah yang mengikat kedua tanganmu.
Saat itu, kau mendengar sorak penuh niat jahat dari suara itu.
 "Orang baik, kau akan mendapat imbalan... tentu saja, juga kutukan."]]
  },
  Event_118426_Name = {
    Text = "Hasrat yang Membelenggu"
  },
  Event_118427_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118427_Desc = {
    Text = [[
Sentuhanmu membuat kupu-kupu gemetar.
Sejak dilahirkan, mereka tidak pernah merasakan perlakuan selembut ini.
Kupu-kupu dikuasai oleh emosi yang membingungkan, bahkan lupa cara terbang.
Maka, kupu-kupu yang tak terhitung jumlahnya berjatuhan, memperlihatkan mesin tik yang selama ini tersembunyi di balik sayap-sayap tak terhitung.
Makhluk malang yang telah kehilangan nyawa itu, dengan kekuatan terakhirnya, mengetikkan kata "Kebebasan".]]
  },
  Event_118427_Name = {
    Text = "Jiwa Menari Bagai Kupu-kupu"
  },
  Event_118428_ChoiceDesc1 = {
    Text = "[Bersiap Tempur] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_118428_ChoiceDesc2 = {
    Text = "[Mencoba jalan memutar] Mendapatkan 25 Segil Hitam"
  },
  Event_118428_Desc = {
    Text = [[
Di kedalaman laut tempat cahaya bintang jatuh, para Pengarung Laut telah bersembunyi selama ribuan tahun. 
Perairan tak bertepi menyaksikan kegilaan mereka, menyaksikan kesabaran mereka, dan juga menyaksikan keimanan mereka yang paling taat kepada dewa. 
Tidak ada yang bisa menghalangi kedatangan agung sang dewa. 
Siapa pun yang menghalangi akan menjadi abu dalam murka para Pengarung Laut.]]
  },
  Event_118428_Name = {
    Text = "Menunggu di Bawah Bintang-Bintang"
  },
  Event_118429_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118429_Desc = {
    Text = [[
Kamu secara refleks menutupi telingamu.
Tak dapat dipercaya, suara musik dari kedalaman jiwa itu menghilang.
Tentu saja, hanya sementara.]]
  },
  Event_118429_Name = {
    Text = "Suara Terlarang"
  },
  Event_118430_ChoiceDesc1 = {
    Text = "[Mengenang Masa Lalu] Mendapatkan pilihan 1 dari 3 Orison tingkat lanjut"
  },
  Event_118430_ChoiceDesc2 = {
    Text = "[Mengintip Masa Depan] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_118430_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_118430_Desc = {
    Text = [[
Tidak ada yang abadi dan tak berubah di dunia ini.
Bahkan taman surga yang dibentuk oleh Sang Ibu Dewa pun demikian.
Dalam sekejap yang singkat, kamu melihat sekilas sesuatu dari celah ruang-waktu.
Masa lalu, masa kini, masa depan terjalin dalam celah yang penuh retakan itu, terus berubah.
Menunggu tatapan penasaranmu.]]
  },
  Event_118430_Name = {
    Text = "Celah Ruang-Waktu"
  },
  Event_118431_ChoiceDesc1 = {
    Text = "[Memperoleh 100 Segil Hitam]"
  },
  Event_118431_ChoiceDesc2 = {
    Text = "[2 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\"]"
  },
  Event_118431_Desc = {
    Text = "Kehendak tak berwujud tidak menerima pilihanmu. Ia bersedia memberimu satu kesempatan lagi, agar kau membuat perubahan——\nBerhati-hatilah, meskipun musik tak berwujud, ia tetap bisa merenggut nyawa."
  },
  Event_118431_Name = {
    Text = "Kidung \"Sempurna\""
  },
  Event_118432_ChoiceDesc1 = {
    Text = "[Memberi makan tikus] Mendapatkan Relik perak [(RelicConfig.Arg1)], pilih untuk menginfeksi gejala sebanyak 1 kali."
  },
  Event_118432_ChoiceDesc2 = {
    Text = "[Mengusir tikus] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Terpesona:\"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_118432_ChoiceDesc3 = {
    Text = "[Mengabaikan tikus] Mendapatkan 25 Segil Hitam"
  },
  Event_118432_Desc = {
    Text = [[
Segala sesuatu di kapal ini berada dalam siklus reinkarnasi.
Makhluk-makhluk kecil menjijikkan yang dipenuhi bulu kotor yang mencari nafkah di kapal ini tentu saja juga tidak bisa menghindari takdir semacam itu.
Dalam siklus reinkarnasi yang berulang-ulang, mereka memakan segala yang bisa mereka lihat, namun tetap tidak bisa terpuaskan.
 "La... par sekali..."
Kawanan tikus mengeluarkan pekikan melengking yang menyakitkan dan tidak wajar.
Siklus reinkarnasi yang berulang membuat mereka kelaparan tak tertahankan, mereka harus makan sesuatu.
Segera, sekarang juga!]]
  },
  Event_118432_Name = {
    Text = "Gerombolan Tikus yang Kelaparan"
  },
  Event_118433_ChoiceDesc1 = {
    Text = "[Menghindari tatapan] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_118433_ChoiceDesc2 = {
    Text = "[Menatap langsung ke mata] Secara acak membangunkan 2 Pembangun, menginfeksi dua kali [(Skill.Arg1)]"
  },
  Event_118433_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_118433_Desc = {
    Text = [[
Sama seperti bintang-bintang di langit, tentu saja di laut dalam juga terdapat banyak mata.
Mata-mata itu berasal dari ikan yang hidup di dasar laut, dari insang yang menghujat, dan juga dari lautan itu sendiri.
Ssst, jangan ganggu mereka.
Jangan, ganggu kegilaan laut dalam.]]
  },
  Event_118433_Name = {
    Text = "Mata Laut Dalam"
  },
  Event_118434_ChoiceDesc1 = {
    Text = "[Abaikan Bisikan]"
  },
  Event_118434_ChoiceDesc2 = {
    Text = "[Dengarkan Bisikan]"
  },
  Event_118434_ChoiceDesc3 = {
    Text = "[Propaganda Balik]"
  },
  Event_118434_Desc = {
    Text = [[
"Apakah kamu mendambakan perhatian para dewa? Apakah kamu ingin mengetahui makna keberadaanmu?"
Sebuah desahan terdengar di telingamu, bagaikan gumaman seorang penderita gangguan jiwa, sekaligus bisikan mesra dari sesuatu yang tak berwujud.
Dengan akal sehat dan kewaspadaan, kamu bersuara menolak, namun suara itu tetap berbicara sendiri.
 "Dengarkanlah dengan sabar. Yang akan kamu ketahui adalah kebenaran yang menyangkut takdir dunia..."]]
  },
  Event_118434_Name = {
    Text = "Khotbah Sang Tak Berwujud"
  },
  Event_118435_ChoiceDesc1 = {
    Text = "[Merasakan Otak] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_118435_ChoiceDesc2 = {
    Text = "[Merasakan Jiwa] Infeksi [(Skill.Arg1)], ukir Orison acak lagi"
  },
  Event_118435_Desc = {
    Text = [[
Otak yang terlindungi dengan aman di dalam tengkorak menyampaikan beberapa informasi kepadamu.
Kamu tidak tahu apakah informasi ini telah terdegradasi dalam konversi neurotransmitter dan transmisi arus bioelektrik.
Satu-satunya fakta yang pasti adalah kamu menerima informasi ini, dan dalam keberadaan objektif tubuhmu, merasakan bahwa kamu masih hidup.]]
  },
  Event_118435_Name = {
    Text = "Penjara Otak"
  },
  Event_118436_ChoiceDesc1 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_118436_Desc = {
    Text = [[
"Jawaban yang bagus, tapi sayang, bukan jawaban yang benar."
 "Lalu apa jawaban yang benar?"
Keberadaan tak dikenal itu tidak menjawab pertanyaanmu, hanya mengeluarkan tawa mengejek. 
 "Siapa bilang takdir punya jawaban yang benar?"]]
  },
  Event_118436_Name = {
    Text = "Perjudian Takdir"
  },
  Event_118437_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118437_Desc = {
    Text = [[
"Kau pikir aku tidak pernah mencoba memotongnya? Tidak, saat kau melawan hasrat, mereka hanya menjadi semakin kuat!"
Merasakan tali hasrat yang semakin mengencang, bahkan mengiris daging, suara itu mengeluarkan teriakan putus asa.
 "Aku tidak akan pernah bisa lepas dari mereka... selamanya!"]]
  },
  Event_118437_Name = {
    Text = "Hasrat yang Membelenggu"
  },
  Event_118438_ChoiceDesc1 = {
    Text = "[Mendengarkan Nyanyian]Mendapatkan 25 Segil Hitam, terinfeksi「(Skill.Arg2)」，lanjut memilih"
  },
  Event_118438_ChoiceDesc2 = {
    Text = "[Meninggalkan begitu saja] Pergi"
  },
  Event_118438_Desc = {
    Text = [[
Gagak hitam legam menangis.
Gagak hitam legam berteriak.
Gagak hitam legam meraung.
Namun di telinga manusia, ia hanya sedang bernyanyi.
 "Ah, betapa riang suara nyanyian itu. Andai saja aku juga seekor gagak, jauh dari kekhawatiran dunia."]]
  },
  Event_118438_Name = {
    Text = "Ratapan yang Tak Terasa"
  },
  Event_118439_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118439_Desc = {
    Text = [[
Kupu-kupu berpencar, akhirnya kamu bisa melihat dengan jelas mesin tik di bawahnya.
Makhluk malang yang telah kehilangan nyawa itu, dengan kekuatan terakhirnya, mengetikkan kata "Pergi".]]
  },
  Event_118439_Name = {
    Text = "Jiwa Menari Bagai Kupu-kupu"
  },
  Event_118440_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118440_Desc = {
    Text = [[
Dalam bayangan masa lalu, seorang gadis berbalut mantel bulu tebal melambaikan tangan ke arahmu.
Kamu tak bisa mendengar jelas apa yang dikatakannya, tapi kamu melihat senyuman sang gadis.]]
  },
  Event_118440_Name = {
    Text = "Celah Ruang-Waktu"
  },
  Event_118441_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118441_Desc = {
    Text = [[
Laut dalam kembali tenggelam dalam kegelapan dan kesunyian.
Dalam kegelapan dan kesunyian itu, kamu kembali mendengar detak jantung.
Suara itu berasal dari dalam tubuhmu.
Di mata orang lain, kamu juga hanyalah sebuah jantung yang berdenyut, berenang di kegelapan laut dalam.]]
  },
  Event_118441_Name = {
    Text = "Hukum Rimba"
  },
  Event_118442_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118442_Desc = {
    Text = [[
Kali ini, yang menjadi abu bukanlah penghalang, melainkan para Pengarung Laut. 
Bintang-bintang memandang ke bawah dalam diam menyaksikan pemandangan ini, tetap bisu seperti ribuan tahun yang lalu.]]
  },
  Event_118442_Name = {
    Text = "Menunggu di Bawah Bintang-Bintang"
  },
  Event_118443_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118443_Desc = {
    Text = [[
Meskipun unggul dalam jumlah, keberanian tikus-tikus kotor itu bahkan lebih kecil dari tubuh mereka.
Mereka terintimidasi oleh sikapmu yang tegas, dan bubar kocar-kacir.]]
  },
  Event_118443_Name = {
    Text = "Gerombolan Tikus yang Kelaparan"
  },
  Event_118444_ChoiceDesc1 = {
    Text = "[Mengulurkan Tangan] Bangun secara acak 1 Pembangun, infeksi [(Skill.Arg1)]"
  },
  Event_118444_ChoiceDesc2 = {
    Text = "[Diam Mengamati] Mendapatkan 1 dari 3 Orison"
  },
  Event_118444_Desc = {
    Text = [[
Sebuah jantung yang berdenyut berenang di kegelapan laut dalam.
Mungkin milik seekor ikan, mungkin milik makhluk yang memiliki insang.
Kamu tidak bisa melihat dengan jelas. Satu-satunya yang bisa kamu lihat adalah jantung yang terus berdenyut itu, dan di belakang jantung itu, mulut besar yang perlahan menganga.
Berburu, atau diburu, adalah hukum alam.
Baik di darat, maupun di lautan.]]
  },
  Event_118444_Name = {
    Text = "Hukum Rimba"
  },
  Event_118445_ChoiceDesc1 = {
    Text = "[Kibas Tangan untuk Mengusir] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_118445_ChoiceDesc2 = {
    Text = "[Dibiarkan tetap] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_118445_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_118445_Desc = {
    Text = "Dari kegelapan terdengar suara pelan.\nItu adalah seekor kupu-kupu yang bertanya dengan sopan.\n \"Bolehkah aku hinggap di telapak tanganmu?\"\n \"Aku hanya terlalu lelah, ingin beristirahat sebentar...\"\nSambil bertanya demikian, kupu-kupu itu menembus kegelapan, berputar-putar di hadapanmu.\nCairan hitam pekat menetes dari sayapnya — itu adalah pemberian dari kegelapan saat kupu-kupu menembus kegelapan."
  },
  Event_118445_Name = {
    Text = "Permintaan Kupu-kupu"
  },
  Event_118446_ChoiceDesc1 = {
    Text = "[Peroleh] Relik emas [(RelicConfig.Arg1)]"
  },
  Event_118446_Desc = {
    Text = [[
Setelah keheningan sesaat, sesuatu dilemparkan ke pelukanmu. 
 "Ambil ini dan pergilah."
 "Takdir selalu murah hati kepada mereka yang beruntung."]]
  },
  Event_118446_Name = {
    Text = "Perjudian Takdir"
  },
  Event_118447_ChoiceDesc1 = {
    Text = "[Ikuti Petunjuk] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_118447_ChoiceDesc2 = {
    Text = "[Abaikan Petunjuk] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_118447_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_118447_Desc = {
    Text = "Perayaan telah dimulai.\nDi bawah kembang api roh dan doa darah, jiwa-jiwa penganut yang tak terhitung berubah menjadi mercu penunjuk jalan——\nRoh-roh samar tersebar di sekelilingmu, bagaikan peri penunjuk jalan, berkilau menunggu pilihanmu."
  },
  Event_118447_Name = {Text = "Mercu Jiwa"},
  Event_118448_ChoiceDesc1 = {
    Text = "[Pergi] Infeksi [(Skill.Arg1)], dapatkan 50 Segil Hitam"
  },
  Event_118448_Desc = {
    Text = [[
"Manusia yang bodoh!"
Suara itu mengeluarkan keluhan kesal, namun belum sampai pada tingkat kemarahan.
Karena ia tahu, orang yang tidak tahu selalu memiliki saat pencerahan.
Ia hanya perlu menunggu datangnya hari itu.
Dan sebelum hari itu tiba, ia mengukir cap dewa pada tubuhmu, memastikan kepemilikan jiwamu.]]
  },
  Event_118448_Name = {
    Text = "Khotbah Sang Tak Berwujud"
  },
  Event_118449_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118449_Desc = {
    Text = "\"@2的@3...\"\nPengetahuan yang luar biasa banyak mengalir masuk ke otakmu bersama melodi yang menghujat.\nNamun tubuh manusia membatasimu, membuatmu tak mampu memahami ilmu dari alam semesta.\nSungguh penyesalan yang menyedihkan."
  },
  Event_118449_Name = {
    Text = "Suara Terlarang"
  },
  Event_118450_ChoiceDesc1 = {
    Text = "[Pergi] Infeksi [(Skill.Arg1)], dapatkan 50 Segil Hitam"
  },
  Event_118450_Desc = {
    Text = [[
"Sebenarnya, aku juga punya sebuah kebenaran dunia yang ingin kuceritakan padamu..."
 "Dunia diciptakan oleh Dewa Mie Terbang yang memiliki dua mata bola daging penuh kebijaksanaan, dan mie yang melambangkan kemampuan tak terbatas..."
Kamu dengan serius mengarang cerita lucu yang pernah kamu dengar, menunggu reaksi lawan bicaramu.
Namun setelah sekian lama, tidak ada gerakan sama sekali dari seberang.
 "Haah, tampaknya para fanatik tidak memahami humor."
Kamu menghela napas, dan hanya bisa pergi.]]
  },
  Event_118450_Name = {
    Text = "Khotbah Sang Tak Berwujud"
  },
  Event_118451_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118451_Desc = {
    Text = [[
Penyetelanmu tidak membuat nada-nada yang kacau ini menjadi harmonis.
Namun setidaknya, kehendak tak berwujud melihat usahamu.
Ini adalah awal yang baik.]]
  },
  Event_118451_Name = {
    Text = "Kidung \"Sempurna\""
  },
  Event_118452_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118452_Desc = {
    Text = [[
Tiga bayangan bergetar, terisak tanpa suara.
Keyakinan mereka kamu pertanyakan, dan ini adalah penghinaan yang paling tidak bisa ditoleransi oleh para fanatik.]]
  },
  Event_118452_Name = {
    Text = "Persembahan Terbaik"
  },
  Event_118453_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118453_Desc = {
    Text = [[
Dalam bayangan masa depan, seorang gadis dengan tentakel yang tumbuh dari lengannya melirikmu dengan angkuh dan menegurmu. 
 "Wujud sejati Sang Ibu Dewa tidak boleh dinodai."
Dengan itu, bayangan menghilang dan celah ruang-waktu langsung menutup. Hanya menyisakanmu mengingat-ingat pemandangan tadi.]]
  },
  Event_118453_Name = {
    Text = "Celah Ruang-Waktu"
  },
  Event_118454_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118454_Desc = {
    Text = [[
Kamu berhasil lolos dari para Pengarung Laut dan terus berlari ke depan. 
Di atas kepalamu, bintang-bintang bersinar tenang, seperti ribuan tahun yang lalu.]]
  },
  Event_118454_Name = {
    Text = "Menunggu di Bawah Bintang-Bintang"
  },
  Event_118455_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118455_Desc = {
    Text = [[
Keberadaan tak dikenal itu tidak menghalangimu.
 "Suatu hari nanti, kamu akan kembali lagi."
 "Tidak ada seorang pun yang bisa menolak takdir."]]
  },
  Event_118455_Name = {
    Text = "Perjudian Takdir"
  },
  Event_118456_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118456_Desc = {
    Text = [[
Dengan gerakan yang cepat dan tegas, kedua tangan itu terkulai tak berdaya.
Namun kau tidak melewatkan helaan napas terakhirnya.
Dia akhirnya benar-benar terbebas dari hasrat tanpa akhir dalam dirinya.]]
  },
  Event_118456_Name = {
    Text = "Hasrat yang Membelenggu"
  },
  Event_118457_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118457_Desc = {
    Text = [[
Tidak terasa oleh siapa pun adalah takdir yang tak terelakkan di dunia ini.
Tidak ada yang bisa sepenuhnya berempati dengan kehidupan lain.]]
  },
  Event_118457_Name = {
    Text = "Ratapan yang Tak Terasa"
  },
  Event_118458_ChoiceDesc1 = {
    Text = "[Mendengarkan Nyanyian]mendapatkan 35 Segil hitam, terinfeksi「(Skill.Arg2)」, terus memilih"
  },
  Event_118458_ChoiceDesc2 = {
    Text = "[Meninggalkan begitu saja] Pergi"
  },
  Event_118458_Desc = {
    Text = [[
Gagak hitam legam menangis.
Gagak hitam legam berteriak.
Gagak hitam legam meraung.
Namun di telinga manusia, ia hanya sedang bernyanyi.
 "Ah, betapa riang suara nyanyian itu. Andai saja aku juga seekor gagak, jauh dari kekhawatiran dunia."]]
  },
  Event_118458_Name = {
    Text = "Ratapan yang Tak Terasa"
  },
  Event_118459_ChoiceDesc1 = {
    Text = "[Mendengarkan dengan cermat] Memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_118459_ChoiceDesc2 = {
    Text = "[Tutup telinga] Dapatkan 1 dari 3 Orison"
  },
  Event_118459_Desc = {
    Text = [[
Dalam kegilaan tak berwujud, kamu seolah melihat sebuah piano.
Sepasang tangan yang bentuknya tak jelas, melompat-lompat di atas tuts tak berwujud itu, memainkan melodi yang menghujat.
Musik aneh itu bergema dari kedalaman jiwamu, mengalir melalui jalur pembuluh darah, langsung menuju otakmu yang bergetar.]]
  },
  Event_118459_Name = {
    Text = "Suara Terlarang"
  },
  Event_118460_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118460_Desc = {
    Text = [[
Inspirasi, misteri, dan khayalan liar itu bercampur aduk, melebur menjadi warna paling gemerlap di dunia.
Kamu melihat ruang terlipat di dalam dirimu, waktu berputar sesuai kehendakmu.
Saat ini, kamu memahami ruang-waktu, mahakuasa, mahatahu.
Tentu saja, kamu juga membayar harganya.]]
  },
  Event_118460_Name = {
    Text = "Kaleidoskop Pikiran"
  },
  Event_118461_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118461_Desc = {
    Text = [[
Jiwa-jiwa kacau menunjukkan jalan ke depan dengan lolongan tajam.
Apakah itu jalan yang aman? Kamu tidak tahu.
Satu-satunya pilihanmu hanyalah terus melangkah maju.]]
  },
  Event_118461_Name = {Text = "Mercu Jiwa"},
  Event_118462_ChoiceDesc1 = {
    Text = "[Mendengarkan Nyanyian]mendapatkan 40 Segil hitam, terinfeksi「(Skill.Arg2)」, terus memilih"
  },
  Event_118462_ChoiceDesc2 = {
    Text = "[Membiarkan Begitu Saja]mendapatkan 25 Segil hitam, pergi"
  },
  Event_118462_Desc = {
    Text = [[
Gagak hitam legam menangis.
Gagak hitam legam berteriak.
Gagak hitam legam meraung.
Namun di telinga manusia, ia hanya sedang bernyanyi.
 "Ah, betapa riang suara nyanyian itu. Andai saja aku juga seekor gagak, jauh dari kekhawatiran dunia."]]
  },
  Event_118462_Name = {
    Text = "Ratapan yang Tak Terasa"
  },
  Event_118463_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118463_Desc = {
    Text = [[
Jiwa kacau itu mengeluarkan desahan penuh duka.
Perlahan ia menghilang, namun desahan penuh duka itu, seolah berwujud nyata, jatuh menimpa jantungmu.
Dug dug, detak jantungmu bergema seirama dengan musik upacara.]]
  },
  Event_118463_Name = {Text = "Mercu Jiwa"},
  Event_118464_ChoiceDesc1 = {
    Text = "[Peroleh] Relik perak [(RelicConfig.Arg1)]"
  },
  Event_118464_Desc = {
    Text = [[
"Ah, ah, betapa salehnya domba ini!"
Suara itu berseru penuh kekaguman, dipenuhi kegembiraan pujian.
 "Ketika Tuanku terbangun, domba sepertimu pasti akan menemukan tempat bernaung di kerajaan ilahi yang agung dan mulia itu..."]]
  },
  Event_118464_Name = {
    Text = "Khotbah Sang Tak Berwujud"
  },
  Event_118465_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118465_Desc = {
    Text = [[
"Langit" memaklumi kekeraskepalamu.
Suatu hari nanti, anak yang tersesat akan kembali ke pelukan ibu.
Karena, kamu tak punya tempat untuk lari.]]
  },
  Event_118465_Name = {
    Text = "Pelukan Lautan"
  },
  Event_118466_ChoiceDesc1 = {
    Text = "[Menerima pelukan] Memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_118466_ChoiceDesc2 = {
    Text = "[Menolak pelukan] Memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_118466_ChoiceDesc3 = {
    Text = "[Berenang ke permukaan] Mendapatkan 25 Segil Hitam"
  },
  Event_118466_Desc = {
    Text = [[
Dunia terbalik di matamu.
Saat ini, laut dalam yang mengelilingimu adalah "langit".
Dalam penderitaan hampir tenggelam,"langit" biru tua ini dengan lembut mendekat, bermaksud memelukmu dalam dekapannya.
Ia tidak akan menghakimi, hanya akan memberi.]]
  },
  Event_118466_Name = {
    Text = "Pelukan Lautan"
  },
  Event_118467_ChoiceDesc1 = {
    Text = "[Membentak mereka] Mendapatkan Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_118467_ChoiceDesc2 = {
    Text = "[Merespons Mereka] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_118467_ChoiceDesc3 = {
    Text = "[Mengabaikan mereka] Mendapatkan 50 Segil hitam"
  },
  Event_118467_Desc = {
    Text = [[
Tiga jiwa dengan bentuk yang kabur menghalangi jalanmu.
Satu bayangan dengan khidmat memberi hormat kepadamu, memohon agar kamu memberikan darah. Darahmu yang mengalir adalah persembahan terbaik untuk dewa.
Satu bayangan dengan dingin mengacungkan pisau kepadamu, bermaksud memotong daging tubuhmu. Daging manusia yang belum bermutasi itu pasti bisa merebut perhatian dewa.
Yang terakhir hanya menatapmu dalam diam, berharap kamu mengambil nyawanya, sebagai bukti keimanan yang paling tulus.]]
  },
  Event_118467_Name = {
    Text = "Persembahan Terbaik"
  },
  Event_118468_ChoiceDesc1 = {
    Text = "[Mendengarkan Nyanyian]mendapatkan 30 Segil hitam, terinfeksi「(Skill.Arg2)」, terus memilih"
  },
  Event_118468_ChoiceDesc2 = {
    Text = "[Meninggalkan begitu saja] Pergi"
  },
  Event_118468_Desc = {
    Text = [[
Gagak hitam legam menangis.
Gagak hitam legam berteriak.
Gagak hitam legam meraung.
Namun di telinga manusia, ia hanya sedang bernyanyi.
 "Ah, betapa riang suara nyanyian itu. Andai saja aku juga seekor gagak, jauh dari kekhawatiran dunia."]]
  },
  Event_118468_Name = {
    Text = "Ratapan yang Tak Terasa"
  },
  Event_118469_ChoiceDesc1 = {
    Text = "[Keluar] Infeksi [(Skill.Arg1)]"
  },
  Event_118469_ChoiceDesc2 = {
    Text = "[Keluar] Infeksi [(Skill.Arg1)]"
  },
  Event_118469_ChoiceDesc3 = {
    Text = "[Keluar] Infeksi [(Skill.Arg1)]"
  },
  Event_118469_Desc = {
    Text = [[
"Tidak! Kami tidak mau ini! Kami mau sesuatu yang lebih... lezat."
 "Dan itu adalah... daging dan darahmu!"
Gerombolan tikus mengeluarkan jeritan nyaring, bergegas ke arahmu.
Tampaknya kebaikan hati yang berlebihan, terkadang justru mendatangkan masalah.]]
  },
  Event_118469_Name = {
    Text = "Gerombolan Tikus yang Kelaparan"
  },
  Event_118470_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118470_Desc = {
    Text = [[
Rasa hormatmu mendapatkan simpati dari mata-mata itu.
Sebelum menghilang, mereka memberimu sebuah hadiah melalui air laut yang bergelombang.
Itu adalah bukti bahwa laut dalam telah menjinakkanmu.]]
  },
  Event_118470_Name = {
    Text = "Mata Laut Dalam"
  },
  Event_118471_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118471_Desc = {
    Text = [[
Di bawah tatapanmu yang tanpa penyamaran, laut dalam perlahan terbangun.
Air laut bergelombang liar di sekelilingmu, membawa igauan yang tak terkatakan.
Rasakanlah kemarahan laut dalam, ini adalah berkat, sekaligus kutukan.]]
  },
  Event_118471_Name = {
    Text = "Mata Laut Dalam"
  },
  Event_118472_ChoiceDesc1 = {
    Text = "[Dengarkan Nyanyian] Dapatkan 20 Segil Hitam, infeksi [(Skill.Arg2)]"
  },
  Event_118472_ChoiceDesc2 = {
    Text = "[Meninggalkan begitu saja] Pergi"
  },
  Event_118472_Desc = {
    Text = [[
Gagak hitam legam menangis.
Gagak hitam legam berteriak.
Gagak hitam legam meraung.
Namun di telinga manusia, ia hanya sedang bernyanyi.
 "Ah, betapa riang suara nyanyian itu. Andai saja aku juga seekor gagak, jauh dari kekhawatiran dunia."]]
  },
  Event_118472_Name = {
    Text = "Ratapan yang Tak Terasa"
  },
  Event_118473_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118473_Desc = {
    Text = [[
Darah, daging, kehidupan.
Persembahan telah disiapkan, selanjutnya hanya perlu menunggu dengan tenang perjamuan sang dewa.]]
  },
  Event_118473_Name = {
    Text = "Persembahan Terbaik"
  },
  Event_118474_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118474_Desc = {
    Text = [[
Kupu-kupu itu memahami penolakanmu.
Sayap yang dilumuri cairan hitam pekat kembali bergetar, terbang dengan goyangan tidak stabil dalam kegelapan.
Tak lama, kegelapan kembali menelan kupu-kupu itu. Kali ini, ia sudah tak berdaya untuk meronta.]]
  },
  Event_118474_Name = {
    Text = "Permintaan Kupu-kupu"
  },
  Event_118475_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118475_Desc = {
    Text = [[
Kupu-kupu itu hinggap di telapak tanganmu, bersama dengan cairan hitam pekat dari sayapnya yang berwarna-warni.
Dalam desah napasmu, sayap berwarna-warni itu perlahan meleleh, menyatu dengan cairan hitam pekat membentuk bentuk kacau yang tak dikenal.
Kupu-kupu ini tak perlu lagi melewati kegelapan.
Ia tertidur lelap di telapak tanganmu.]]
  },
  Event_118475_Name = {
    Text = "Permintaan Kupu-kupu"
  },
  Event_118477_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118477_Desc = {
    Text = [[
Gagak yang suaranya serak akhirnya menutup matanya.
Dalam kebencian yang tak diketahui siapa pun, tak terasa oleh siapa pun, ia menelan napas terakhirnya, berubah menjadi genangan cairan hitam yang kental.]]
  },
  Event_118477_Name = {
    Text = "Ratapan yang Tak Terasa"
  },
  Event_118478_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118478_Desc = {
    Text = [[
"Terima kasih..."
Jantung yang berdebar melompat riang menuju kejauhan.
Tak lama kemudian, dari kegelapan laut dalam terdengar suara mengunyah daging dan darah.]]
  },
  Event_118478_Name = {
    Text = "Hukum Rimba"
  },
  Event_118479_ChoiceDesc1 = {
    Text = "[Menerima undangan] Terinfeksi \"(Skill.Arg1)\", memperoleh Relik terkutuk -\"(RelicConfig.Arg2)\""
  },
  Event_118479_ChoiceDesc2 = {
    Text = "[Menolak undangan] Pilih untuk menghancurkan 1 Relik, dapatkan 1 hadiah."
  },
  Event_118479_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_118479_Desc = {
    Text = [[
"Segala sesuatu di kapal ini harus menjadi bagian dari taman siklus yang terus runtuh dan dimulai kembali ini."
Alunan musik yang kacau bergema di benakmu, itu adalah pencerahan dari kehendak tak berwujud.
 "Di sini tidak ada tangisan, tidak ada kesedihan, hanya musik suci yang murni dan tawa yang abadi."
 "Apakah kau bersedia bergabung dengan taman ini, menjadi bagian dari alunan musik yang sempurna ini?"]]
  },
  Event_118479_Name = {
    Text = "Kidung \"Sempurna\""
  },
  Event_118480_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_118480_Desc = {
    Text = [[
Dalam diammu, jiwa-jiwa lenyap tanpa suara.
Mereka yang tidak memahami keyakinan, tidak layak membuang waktu mereka.]]
  },
  Event_118480_Name = {
    Text = "Persembahan Terbaik"
  },
  Event_123616_ChoiceDesc1 = {
    Text = "[Mendapatkan Relik Standar]"
  },
  Event_123616_Desc = {
    Text = [[
Atur semua Pembangun Aliemus menjadi 100, kunci perak menjadi 1000, dan kehidupan menjadi 80%.
Hapus 2 kartu, masukkan 3 kartu gejala.
Pelebur Merah diatur menjadi 12.5%, pilih 4 kartu untuk dimasukkan ke ruang Ultra.
Dapatkan paket ciptaan standar.]]
  },
  Event_123616_Name = {
    Text = "Lewati jalan dengan satu klik"
  },
  Event_125696_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125696_Desc = {
    Text = "Kemarahan tanpa sebab mendorongmu, kau mengangkat tangan, mengusir dengan sekuat tenaga. Kau sudah terlalu lama terjebak dalam teka-teki, mungkin yang kau dambakan adalah pertarungan yang memuaskan, atau bahkan sekadar akhir dari segalanya…\nNamun kawanan gagak tak melakukan apa pun. Di bawah tatapanmu, jurang itu menghilang.\nKawanan gagak lenyap di ujung panggung, tempat yang akan kau tuju."
  },
  Event_125696_Name = {
    Text = "Jurang Kawanan Gagak"
  },
  Event_125697_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125697_Desc = {
    Text = [[
"Pengecut."Suara wanita itu tidak menyembunyikan ejekan dalam tawanya.
"Pergilah, sejauh mungkin."]]
  },
  Event_125697_Name = {
    Text = "Gembok Takdir"
  },
  Event_125698_ChoiceDesc1 = {
    Text = "[Mengusir] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_125698_ChoiceDesc2 = {
    Text = "[Dengarkan]Dapatkan artefak perak\"(RelicConfig.Arg1)\", terinfeksi\"(Skill.Arg2)\""
  },
  Event_125698_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_125698_Desc = {
    Text = [[
Suara lembut terdengar di kegelapan. Seekor kupu-kupu jatuh ke telapak tanganmu. Kau ingat padanya.
"Nona Arachne... kau tidak pernah meninggalkan kami, bukan?"
Polanya yang indah, memandang orang di sampingmu.]]
  },
  Event_125698_Name = {
    Text = "Sisa Hidup Sang Kupu-kupu"
  },
  Event_125699_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125699_Desc = {
    Text = [[
Suara dan tulisan itu menyerbu pikiranmu bagaikan gerombolan lebah. Kau menahan napas dan berkonsentrasi, menyingkirkan pikiran-pikiran tak berguna itu dari benakmu.
Mengabaikan jauh lebih sulit daripada membaca, tapi kau berhasil melakukannya.]]
  },
  Event_125699_Name = {
    Text = "Telegram Dimensi"
  },
  Event_125700_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125700_Desc = {
    Text = [[
Itu adalah ilusi yang diciptakan musuh!
Kamu menggelengkan kepala, tersadar kembali, dan sekali lagi menggenggam erat Kunci Perak di tanganmu.]]
  },
  Event_125700_Name = {
    Text = "Bayangan dalam Anggur"
  },
  Event_125701_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125701_Desc = {
    Text = "Kamu menatap mata itu dengan saksama, berusaha keras untuk memperhatikan dan mendengarkan. Kamu mencoba memasuki hati sang aktor, merasakan penderitaan yang sedang dialaminya.\nKamu mendekat, semakin dekat. Kamu menembus tubuhnya, menyentuh jiwanya…\nKamu tiba-tiba membuka mata dan mendapati dirimu berdiri di tengah panggung, air mata mengalir dari ujung jarimu.\nItu adalah pengakuanmu yang kamu persembahkan kepada para penonton."
  },
  Event_125701_Name = {
    Text = "Pengakuan Sang Aktor"
  },
  Event_125702_ChoiceDesc1 = {
    Text = "[Berdiskusi dengannya]Hapus 1 kartu perintah, dapatkan Arg1 Cap Hitam"
  },
  Event_125702_ChoiceDesc2 = {
    Text = "[Diam Membisu]"
  },
  Event_125702_Desc = {
    Text = "\"Akhir yang bahagia memang indah, tapi kebahagiaan palsu itu tak akan pernah menyentuh hati penonton…\"\nSang penulis naskah memejamkan mata, termenung. Dia tidak puas dengan akhir cerita ini."
  },
  Event_125702_Name = {
    Text = "Akhir dari Naskah"
  },
  Event_125703_ChoiceDesc1 = {
    Text = "[Mendengarkan Nyanyian]mendapatkan 35 Segil hitam, terinfeksi「(Skill.Arg2)」, terus memilih"
  },
  Event_125703_ChoiceDesc2 = {
    Text = "[Meninggalkan begitu saja] Pergi"
  },
  Event_125703_Desc = {
    Text = "\"Krieet— krieet— Dewi takdir memutar roda pintanya.\nKrieet— krieet— Benang-benang takdir berkumpul di tangannya.\""
  },
  Event_125703_Name = {
    Text = "Ramalan Terakhir"
  },
  Event_125704_ChoiceDesc1 = {
    Text = "[Diri Sendiri]Dapatkan 3 kartu perintah acak dari dek dan pilih 1 untuk diduplikasi"
  },
  Event_125704_ChoiceDesc2 = {
    Text = "[William] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_125704_ChoiceDesc3 = {
    Text = "[Bukan Siapa-siapa]Dapatkan 25 Segel Hitam"
  },
  Event_125704_Desc = {
    Text = [[
Kamu yakin dirimu tidak mabuk, tapi saat menatap ke dalam minuman, kamu tenggelam ke dalam danau yang tenang.
Sebuah bayangan terpantul di dalam gelas yang elegan, siapakah itu?]]
  },
  Event_125704_Name = {
    Text = "Bayangan dalam Anggur"
  },
  Event_125705_ChoiceDesc1 = {
    Text = "[Mendengarkan]Dapatkan artefak perak [(RelicConfig.Arg1)]"
  },
  Event_125705_ChoiceDesc2 = {
    Text = "[Mengusir]Dapatkan 75 Cap Hitam, terinfeksi [(Skill.Arg2)]"
  },
  Event_125705_Desc = {
    Text = [[
Ketika kamu mendekati kekuatan Plasmid di dalam tubuhmu, sekawanan gagak muncul di benakmu, berputar-putar di Ruang Jiwamu yang kacau.

Kawanan gagak mengelilingimu, sebuah jurang terbalik berputar di atas kepalamu.
Seratus ribu gagak berteriak serentak, bagaikan sebuah ramalan yang mengejek.]]
  },
  Event_125705_Name = {
    Text = "Jurang Kawanan Gagak"
  },
  Event_125706_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125706_Desc = {
    Text = [[
Kau dan Arachne mencoba menstabilkan nasib yang hancur di sampingmu. Usahamu tidak menghasilkan banyak, tetapi itu sudah cukup. Dengan memanfaatkan waktu yang diperoleh, kalian terus mendekati Nefraea. 
 Kamu datang ke sini untuk membawakan kebebasan baginya.]]
  },
  Event_125706_Name = {
    Text = "Tirai Penutup Jaring Takdir"
  },
  Event_125707_ChoiceDesc1 = {
    Text = "[Dengarkan Nyanyian] Dapatkan 20 Segil Hitam, infeksi [(Skill.Arg2)]"
  },
  Event_125707_ChoiceDesc2 = {
    Text = "[Meninggalkan begitu saja] Pergi"
  },
  Event_125707_Desc = {
    Text = "\"Mereka mati bersama jaring itu, tanpa suara.\""
  },
  Event_125707_Name = {
    Text = "Ramalan Terakhir"
  },
  Event_125708_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125708_Desc = {
    Text = [[
Itu adalah telegram yang ditujukan ke Jurang Neraka.
"Jangan terburu-buru, anak-anakku. Gerbang penjara akan segera terbuka, kebebasan kalian akan segera tiba."]]
  },
  Event_125708_Name = {
    Text = "Telegram Dimensi"
  },
  Event_125709_ChoiceDesc1 = {
    Text = "[Mengusir] 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_125709_ChoiceDesc2 = {
    Text = "[Dengarkan]Pilih 1 dari 3 kartu perintah untuk mendapat Terpesona:[(EnchantConfig.Arg1)]"
  },
  Event_125709_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_125709_Desc = {
    Text = [[
Seekor kupu-kupu mendarat lembut di tanganmu. Corak indahnya bagaikan bola mata, menatapmu dalam diam.
Mungkin, ia ingin memberitahumu sesuatu?]]
  },
  Event_125709_Name = {
    Text = "Istirahat Sang Kupu-kupu"
  },
  Event_125710_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125710_Desc = {
    Text = "Dua puluh pasang mata yang berduka menatapmu. Sang gagak berhenti bernyanyi, membawa ramalan terakhirnya pergi meninggalkan jaring yang hampir runtuh ini."
  },
  Event_125710_Name = {
    Text = "Ramalan Terakhir"
  },
  Event_125711_ChoiceDesc1 = {
    Text = "[Membungkuk ke depan] Terinfeksi \"(Skill.Arg1)\", memperoleh Relik emas \"(RelicConfig.Arg2)\""
  },
  Event_125711_ChoiceDesc2 = {
    Text = "[Menyerah untuk melihat] Mendapatkan 50 Segil Hitam"
  },
  Event_125711_Desc = {
    Text = "Saat melewati sudut jalan, kau melihat sebuah bioskop sederhana. Kau tidak ingat ada toko seperti ini di Londinium."
  },
  Event_125711_Name = {
    Text = "Bioskop Kenangan"
  },
  Event_125712_ChoiceDesc1 = {
    Text = "[Terima Takdir]Pilih 1 dari 3 kartu perintah untuk mendapatkan Terpesona: [(EnchantConfig.Arg1)]"
  },
  Event_125712_ChoiceDesc2 = {
    Text = "[Melawan Takdir]Terinfeksi[(Skill.Arg1)], cetak ulang, maksimal 2 kali"
  },
  Event_125712_Desc = {
    Text = [[
"Ah, kita bertemu lagi, sayangku."
Kau mulai menikmati suara wanita muda yang bergema di dalam otakmu. Suara itu lembut, menggoda, bagaikan jaring yang memikat serangga.
"Kemarilah, katakan padaku, apakah kau bersedia menerima takdirmu?"]]
  },
  Event_125712_Name = {
    Text = "Sangkar Takdir"
  },
  Event_125713_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125713_Desc = {
    Text = [[
"Manusia bodoh, memangnya aku akrab denganmu?"
Kucing hitam itu melirikmu dengan jijik, lalu berbalik.
"Pergi dari sini. Jangan lakukan hal bodoh seperti ini lagi."]]
  },
  Event_125713_Name = {
    Text = "Ilusi Berubah Rupa"
  },
  Event_125714_ChoiceDesc1 = {
    Text = "[Ambil Foto]Pilih 1 dari 3 kartu perintah untuk mendapatkan Terpesona: [(EnchantConfig.Arg1)]"
  },
  Event_125714_ChoiceDesc2 = {
    Text = "[Ganti Pose]Terinfeksi [(Skill.Arg1)], ganti Terpesona yang didapat di opsi 1, bisa digunakan dua kali"
  },
  Event_125714_Desc = {
    Text = "Sebuah kamera berdiri sendirian di atas panggung, lensa hitamnya menatapmu, bagaikan mata majemuk misterius ciptaan dewa mekanis.\n\"Teater ini sudah lama tak punya penonton… Selamat datang! Selamat datang! Ayo berfoto! Gratis sepenuhnya!\"\nKamera itu berteriak dengan penuh semangat. Di panggung yang tak dipedulikan siapa pun ini, dialah satu-satunya pemeran utama."
  },
  Event_125714_Name = {
    Text = "Foto dari Kursi Penonton"
  },
  Event_125715_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125715_Desc = {
    Text = "\"Bagaimana seseorang yang tidak mempertanyakan takdir bisa mengharapkan jawaban dari takdir?\""
  },
  Event_125715_Name = {
    Text = "Gembok Takdir"
  },
  Event_125716_ChoiceDesc1 = {
    Text = "[Pikirkan Jalan Keluar]Dapatkan Relic Perak\"(RelicConfig.Arg1)\", terinfeksi\"(Skill.Arg2)\""
  },
  Event_125716_ChoiceDesc2 = {
    Text = "[Biarkan Mengalir]Dapatkan Relic Emas\"(RelicConfig.Arg1)\", terinfeksi\"(Skill.Arg2)\",\"(Skill.Arg3)\""
  },
  Event_125716_ChoiceDesc3 = {
    Text = "[Muncul ke permukaan] Mendapatkan 25 Segil Hitam"
  },
  Event_125716_Desc = {
    Text = [[
Sebuah panggung baru, dua kehidupan yang saling tumpang tindih... Di tengah pelarian dari polisi, kamu menata semua hal yang Arachne katakan padamu. 
 Dalam pikiran yang rumit, kamu terjatuh ke dalam Aequor yang tenang.]]
  },
  Event_125716_Name = {Text = "Kedamaian"},
  Event_125717_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125717_Desc = {
    Text = [[
Kupu-kupu itu terbang ke bahumu, mendekat ke telingamu. Kau mendengarkan dengan saksama, tapi yang kau dengar hanyalah kepakan sayapnya, bagaikan desahan tanpa suara.
Dalam pendengaranmu, sepasang sayap berwarna-warni itu perlahan meleleh, dan kupu-kupu itu tertidur di bahumu.
Kau tidak akan pernah bisa mengetahui apa yang ingin dikatakannya padamu.]]
  },
  Event_125717_Name = {
    Text = "Sisa Hidup Sang Kupu-kupu"
  },
  Event_125718_ChoiceDesc1 = {
    Text = "[Kunyah]Kebangkitan acak 1 Awakened, terinfeksi[(Skill.Arg1)]"
  },
  Event_125718_ChoiceDesc2 = {
    Text = "[Tolak]mendapatkan 3 pilihan  Oriso"
  },
  Event_125718_Desc = {
    Text = [[
"Lapar, tamu tersayang?"
Suara lengket terdengar dari balik meja bar. Kau berbalik, tapi tidak melihat apa pun.
"Camilan di Bar Topeng Tengah Malam juga terkenal ke mana-mana. Mau mencobanya?"]]
  },
  Event_125718_Name = {
    Text = "Rasa Takdir"
  },
  Event_125719_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125719_Desc = {
    Text = [[
Anda tidak berani membaca tulisan di atas sembarangan, hanya mengamati dengan seksama amplop yang indah itu. 
 Di amplop tersebut, segel lilin menampilkan lambang keluarga yang samar, di atasnya tertulis dengan huruf kaligrafi yang indah: 
 "Kepada Nona Arachne yang Baru Lahir." 
 "Pelayan Anda yang setia, Edgar."]]
  },
  Event_125719_Name = {
    Text = "Selamat Malam, Tuan Edgar"
  },
  Event_125720_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125720_Desc = {
    Text = "\"Begitu rupanya, aku mengerti, Kakak…\"\n\"Sang penulis naskah tak pernah bisa mengubah akhir cerita karakternya. Takdir yang tragis itu sudah ditentukan sejak awal, bahkan kau pun tak pernah bisa mengubahnya…\"\nIsak tangis yang menyedihkan itu menghilang. Mesin tik sang penulis naskah berubah menjadi kupu-kupu, berterbangan ke dalam Teater Takdir yang kosong, tak terlihat lagi jejaknya."
  },
  Event_125720_Name = {
    Text = "Akhir dari Naskah"
  },
  Event_125721_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125721_Desc = {
    Text = "Aktor tak dikenal, langkah tarian yang berbahaya… Apa bedanya? Tidak ada yang lebih buruk dari takdir itu sendiri.\nKamu mengulurkan tangan dan melangkah ke atas panggung. Boneka-boneka itu meraih tanganmu dan menari dengan riang.\nKamu mendengar tepuk tangan."
  },
  Event_125721_Name = {
    Text = "Tarian Bertiga"
  },
  Event_125722_ChoiceDesc1 = {
    Text = "[Mendengarkan Nyanyian]Mendapatkan 25 Segil Hitam, terinfeksi「(Skill.Arg2)」，lanjut memilih"
  },
  Event_125722_ChoiceDesc2 = {
    Text = "[Meninggalkan begitu saja] Pergi"
  },
  Event_125722_Desc = {
    Text = "\"Mereka menari. Mereka bernyanyi riang. Krieet— krieet—\""
  },
  Event_125722_Name = {
    Text = "Ramalan Terakhir"
  },
  Event_125723_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125723_Desc = {
    Text = [[
Pembimbing, rekan seperjuangan, satu-satunya teman di dimensi yang sepi.
Kalian akan menyelesaikan semua yang ada di sini bersama-sama, dan kembali ke Kadath. Kamu tidak pernah meragukannya.]]
  },
  Event_125723_Name = {
    Text = "Bayangan dalam Anggur"
  },
  Event_125724_ChoiceDesc1 = {
    Text = "[Judikan] Infeksi [(Skill.Arg1)], masuk ke dalam permainan judi"
  },
  Event_125724_ChoiceDesc2 = {
    Text = "[Lebih baik tidak] mendapatkan 25 Segil hitam"
  },
  Event_125724_Desc = {
    Text = "Di sudut gang, sepasang tangan kotor menghalangimu.\nSeorang pengemis berpakaian compang-camping diam-diam mendekat, tatapannya serakah bagai hyena yang melihat bangkai.\n\"Ayo! Satu putaran! Aku akan memberitahumu semua yang ingin kamu ketahui! Asalkan kamu bisa menang…\""
  },
  Event_125724_Name = {
    Text = "Taruhan di Jalanan"
  },
  Event_125725_ChoiceDesc1 = {
    Text = "[Abaikan]Hapus 1 kartu perintah, dapatkan 25 Tinta Hitam"
  },
  Event_125725_ChoiceDesc2 = {
    Text = "[Baca]Salin satu kartu dari tumpukan kartu, terinfeksi[(Skill.Arg1)]"
  },
  Event_125725_Desc = {
    Text = "Tak tak tak, tak tak tak…\nSudut bar kosong tanpa siapa pun, mesin telegram berbunyi nyaring, bagaikan sebuah melodi piano yang indah."
  },
  Event_125725_Name = {
    Text = "Telegram Dimensi"
  },
  Event_125726_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125726_Desc = {
    Text = [[
"Diam, aku ini kucing, aku tidak mau mendengar cerita bodoh kalian."
Kucing hitam itu menghela napas dan berbalik.
"Pergi dari sini. Jangan lakukan hal bodoh seperti ini lagi."]]
  },
  Event_125726_Name = {
    Text = "Ilusi Berubah Rupa"
  },
  Event_125727_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125727_Desc = {
    Text = [[
Mungkin apa yang dikatakannya benar, itulah dirimu, pikiran paling tersembunyi dan paling kotor di lubuk hatimu.
Setiap orang itu egois, kau tidak pernah semulia yang orang lain pikirkan.
Kau merasakan penderitaan yang hina itu. Kau tahu yang telah berlalu sudah berlalu, dan penebusanmu ada di depan.]]
  },
  Event_125727_Name = {
    Text = "Penderitaan Menjalar"
  },
  Event_125728_ChoiceDesc1 = {
    Text = "[Berdiskusi dengannya]Hapus 1 kartu perintah, dapatkan Arg1 Cap Hitam"
  },
  Event_125728_ChoiceDesc2 = {
    Text = "[Diam Membisu]"
  },
  Event_125728_Desc = {
    Text = "\"Akhir yang heroik memang begitu nyata, tapi kenyataan kita sudah begitu menyedihkan, bahkan dalam cerita pun, kita tak bisa memberinya tempat berlabuh yang indah…\"\nSang penulis naskah memejamkan mata, termenung. Dia tidak puas dengan akhir cerita ini."
  },
  Event_125728_Name = {
    Text = "Akhir dari Naskah"
  },
  Event_125729_ChoiceDesc1 = {
    Text = "[Peroleh] Relik emas [(RelicConfig.Arg1)]"
  },
  Event_125729_Desc = {
    Text = "Klotak klotak, dadu menari dengan gembira di dalam wadahnya, menari hingga kelelahan.\n\n\"Kenapa… kenapa tidak pernah ada yang bisa menang!…\""
  },
  Event_125729_Name = {
    Text = "Taruhan di Jalanan"
  },
  Event_125730_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125730_Desc = {
    Text = [[
Kau berusaha mendekat dan mendengarkannya dengan saksama.
Kupu-kupu itu mengepakkan sayapnya dan meninggalkan telapak tanganmu.
Kau tidak mendengar apa pun.]]
  },
  Event_125730_Name = {
    Text = "Istirahat Sang Kupu-kupu"
  },
  Event_125731_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125731_Desc = {
    Text = [[
Menghadapi usiran darimu, kupu-kupu itu tak bergeming.
Ia dengan gigih mengejar telapak tanganmu, dan baru memilih pergi saat kau mengayunkan lenganmu untuk terakhir kalinya.
Kau sedikit menyesal. Mungkin, seharusnya kau mendengarkan apa yang ingin dikatakannya?]]
  },
  Event_125731_Name = {
    Text = "Istirahat Sang Kupu-kupu"
  },
  Event_125732_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125732_Desc = {
    Text = [[
Asap hitam bergetar dengan kecewa, tangisan pilu sang pengemis terdengar parau.
Dadu dan pengemis menghilang setelah kamu berkedip sekali. Di dalam topi usang itu, tertinggal hadiah dari permainan.]]
  },
  Event_125732_Name = {
    Text = "Taruhan di Jalanan"
  },
  Event_125733_ChoiceDesc1 = {
    Text = "[Bergabung dalam Karnaval]Terinfeksi\"(Skill.Arg1)\", dapatkan Relic Kutukan -\"(RelicConfig.Arg2)\""
  },
  Event_125733_ChoiceDesc2 = {
    Text = "[Hentikan Musik]Pilih untuk menghancurkan 1 Relic, dapatkan 1 hadiah"
  },
  Event_125733_ChoiceDesc3 = {
    Text = "[Tutup Telinga]Dapatkan 50 Tinta Hitam"
  },
  Event_125733_Desc = {
    Text = [[
"Ah! Musik! Bagaimana mungkin pertunjukan agung tanpa musik!!"
Simfoni yang sumbang bergema di teater yang hancur, bagai karnaval kekacauan. Para aktor dari Jurang Neraka menari dan bersorak dalam kidung tanpa aturan ini, itulah nada-nada yang menjadi sumber kehidupan mereka.]]
  },
  Event_125733_Name = {
    Text = "Kidung Takdir"
  },
  Event_125734_ChoiceDesc1 = {
    Text = "[Memperoleh 100 Segil Hitam]"
  },
  Event_125734_ChoiceDesc2 = {
    Text = "[2 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\"]"
  },
  Event_125734_Desc = {
    Text = "Benang takdir tak kasat mata menari di antara nada-nada, dan di tengah suara yang kacau itu, kau perlahan menangkap melodi yang memesona itu — ya, itulah suara yang seharusnya dimiliki takdir.\nPara terbuang dari Jurang Neraka bersorak untukmu, mereka mengerumunimu, membawamu masuk ke dalam karnaval tanpa aturan mereka.\nSelamat, penonton yang beruntung! Sekarang, kau akan memberi hormat kepada takdir bersama para aktor."
  },
  Event_125734_Name = {
    Text = "Kidung Takdir"
  },
  Event_125735_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125735_Desc = {
    Text = "Kau tidak bisa memahami makna suara ini, tapi kau tahu, ia harus berhenti.\nCahaya perak menebas bagai bilah yang mengamuk, dan ritmenya ternyata sangat selaras dengan nada-nada itu.\nSaat kau tersadar, nada-nada itu entah sejak kapan telah berhenti. Kau tidak bisa mendengar suara apa pun lagi. Yang kau lihat hanyalah kegelapan, yang kau dengar hanyalah kesunyian.\nKekacauan tanpa aturan dan kesunyian mutlak, mana yang lebih menakutkan… Penjaga Rahasia?"
  },
  Event_125735_Name = {
    Text = "Kidung Takdir"
  },
  Event_125736_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125736_Desc = {
    Text = "Kau mengulurkan tangan, seekor kupu-kupu mendarat lembut di atasnya.\nBenar. Kematian, kepudaran, berlalunya waktu… Kupu-kupu terlahir dari kepompong, penderitaan adalah tanah abadi tempat seni tumbuh.\nSebagai penonton yang baik, ini adalah kebenaran yang harus kau pahami."
  },
  Event_125736_Name = {
    Text = "Mekar dalam Kepudaran"
  },
  Event_125737_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125737_Desc = {
    Text = [[
Ini mungkin lagi-lagi adalah trik dari Nefraea. 
Kupu-kupu mendengar perkataanmu, di dalam kegelapan terdengar desahan tanpa suara darinya. Sayap yang dipenuhi dengan cairan hitam bergetar, dan segera, sosok berat kupu-kupu itu tenggelam dalam kegelapan yang tak terbatas. 
Kau tidak akan pernah bisa mengetahui kata-kata yang ingin disampaikannya kepadamu.]]
  },
  Event_125737_Name = {
    Text = "Sisa Hidup Sang Kupu-kupu"
  },
  Event_125738_ChoiceDesc1 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_125738_Desc = {
    Text = "Klotak klotak, dadu menari dengan gembira di dalam wadahnya, menari hingga kelelahan.\n\n\"Kenapa… kenapa tidak pernah ada yang bisa menang!…\""
  },
  Event_125738_Name = {
    Text = "Taruhan di Jalanan"
  },
  Event_125739_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125739_Desc = {
    Text = "Membiarkan pikiran mengalir liar sekarang sangatlah berbahaya. Kau menggelengkan kepala dan segera muncul ke permukaan…"
  },
  Event_125739_Name = {Text = "Kedamaian"},
  Event_125740_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125740_Desc = {
    Text = [[
Tidak semua nada membutuhkan pendengar, tidak semua takdir membutuhkan jawaban.
Kau menutup telingamu rapat-rapat dan meninggalkan panggung yang bising ini.
Kau masih akan penasaran dengan makna suara sumbang itu, tapi kau tahu, kau telah membuat satu-satunya pilihan yang benar.]]
  },
  Event_125740_Name = {
    Text = "Kidung Takdir"
  },
  Event_125741_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125741_Desc = {
    Text = [[
Cahaya perak menembus ilusi, kucing-kucing hitam itu berubah menjadi genangan cairan hitam.
Mencoba berubah menjadi kucing hitam untuk bersembunyi, tapi tidak bisa lolos dari matamu.]]
  },
  Event_125741_Name = {
    Text = "Ilusi Berubah Rupa"
  },
  Event_125742_ChoiceDesc1 = {
    Text = "[Terima Takdir]Pilih 1 dari 3 kartu perintah untuk mendapatkan Terpesona: [(EnchantConfig.Arg1)]"
  },
  Event_125742_Desc = {
    Text = [[
"Tidak ada yang benar-benar bisa melawan takdir, sayangku. Kita tidak pernah punya hak untuk memilih."
Suara wanita itu menjadi sendu dan jauh. Kau tidak yakin, apakah ia ingin berbicara denganmu, atau dengan sesuatu yang lain.]]
  },
  Event_125742_Name = {
    Text = "Sangkar Takdir"
  },
  Event_125743_ChoiceDesc1 = {
    Text = "[Mendengarkan Nyanyian]mendapatkan 30 Segil hitam, terinfeksi「(Skill.Arg2)」, terus memilih"
  },
  Event_125743_ChoiceDesc2 = {
    Text = "[Meninggalkan begitu saja] Pergi"
  },
  Event_125743_Desc = {
    Text = "\"Boneka-boneka berbaris masuk, melangkah ke dalam jaring takdir yang besar.\""
  },
  Event_125743_Name = {
    Text = "Ramalan Terakhir"
  },
  Event_125744_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125744_Desc = {
    Text = [[
Kau mendongak menatap jurang yang berputar bagai pusaran, mencoba mendengarkan wahyu kawanan gagak.
Namun kawanan gagak tak mengatakan apa pun. Di bawah tatapanmu, jurang itu menghilang.
Kawanan gagak lenyap di ujung panggung, tempat yang akan kau tuju.]]
  },
  Event_125744_Name = {
    Text = "Jurang Kawanan Gagak"
  },
  Event_125745_ChoiceDesc1 = {
    Text = "[Setuju dengan Kupu-kupu]Hapus 2 kartu"
  },
  Event_125745_ChoiceDesc2 = {
    Text = "[Menentang Kupu-kupu]Dapatkan artefak terkutuk\"(RelicConfig.Arg1)\", terinfeksi\"(Skill.Arg2)\""
  },
  Event_125745_ChoiceDesc3 = {
    Text = "[Pergi]mendapatkan Arg1 Segil hitam"
  },
  Event_125745_Desc = {
    Text = "Tirai panggung berkibar tertiup angin. Di dalam cairan hitam pekat yang menetes dari jasad, kau melihat sekumpulan kupu-kupu.\n\"Seni sejati, selalu mekar dalam kepudaran… Benar kan, Penjaga Rahasia?\"\nJasad sang penari tersenyum kepadamu. Kau mendengar suara kepakan sayap kupu-kupu."
  },
  Event_125745_Name = {
    Text = "Mekar dalam Kepudaran"
  },
  Event_125746_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125746_Desc = {
    Text = [[
Sofisme tidak akan pernah bisa mengganggumu. Kau tahu dengan jelas jalan seperti apa yang sedang kau tempuh, dan ke mana tujuan akhirmu.
Duri-duri di dalam tubuhmu menghilang. Kau melangkah di jalan, seperti biasa.]]
  },
  Event_125746_Name = {
    Text = "Penderitaan Menjalar"
  },
  Event_125747_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125747_Desc = {
    Text = [[
Kau berbalik, mencoba melupakan mata-mata di belakangmu. Tapi kau menyadari tubuhmu tampaknya sulit dikendalikan seperti biasa.
Kau tahu, tatapan-tatapan itu, kau tidak akan pernah bisa melarikan diri darinya.]]
  },
  Event_125747_Name = {Text = "Penonton"},
  Event_125748_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125748_Desc = {
    Text = [[
Baik karena rasa hormat maupun ketakutan, kau enggan untuk menyentuhnya dengan mudah, mengembalikan amplop ke tempat semula. Saat kau bersiap untuk pergi, suara keruh namun lembut terdengar dari kegelapan di balik amplop. 
 "Terima kasih telah mengingat saya, Nona Arachne..."]]
  },
  Event_125748_Name = {
    Text = "Selamat Malam, Tuan Edgar"
  },
  Event_125749_ChoiceDesc1 = {
    Text = "[Kekuatan Pelindung]Dapatkan Relic Perak[(RelicConfig.Arg1)]"
  },
  Event_125749_ChoiceDesc2 = {
    Text = "[Kebebasan untuk Melarikan Diri]1 kartu acak mendapatkan Terpesona:[(EnchantConfig.Arg1)]"
  },
  Event_125749_ChoiceDesc3 = {
    Text = "[Menolak Menjawab]Dapatkan 50 Tinta Hitam"
  },
  Event_125749_Desc = {
    Text = [[
Alkohol dari Midnight Masquerade merayap ke kepalamu, membelenggumu bagai rantai. Mengikuti rantai yang dingin itu, suara seorang wanita muda bergema di benakmu.
"Katakan padaku, Sayang. Takdir seperti apa yang sebenarnya kau inginkan?"]]
  },
  Event_125749_Name = {
    Text = "Gembok Takdir"
  },
  Event_125750_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125750_Desc = {
    Text = [[
Tak peduli seberapa rumit urusannya, kalian tetap harus menyelesaikannya.
Sementara beban terasa semakin berat, kau juga merasakan kekuatan baru.]]
  },
  Event_125750_Name = {Text = "Kedamaian"},
  Event_125751_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125751_Desc = {
    Text = [[
Aktor tak dikenal, langkah tarian yang berbahaya. Benar, melarikan diri selalu yang paling aman.
Kamu berbalik dan berlari, menyibak tirai teater, lalu, kamu berdiri di atas panggung. Boneka-boneka itu meraih tanganmu dan menari dengan riang.
Panggung takdir, tidak pernah ada pilihan.]]
  },
  Event_125751_Name = {
    Text = "Tarian Bertiga"
  },
  Event_125752_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125752_Desc = {
    Text = "Sekarang bukan saat yang tepat untuk menonton film."
  },
  Event_125752_Name = {
    Text = "Bioskop Kenangan"
  },
  Event_125753_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125753_Desc = {
    Text = [[
Bahaya di jalan sama sekali tidak memasuki pikiranmu. Kamu melewati nasib yang hancur di sampingmu, terus mendekati Nefraea. 
 Kamu datang ke sini untuk membawakan kebebasan baginya.]]
  },
  Event_125753_Name = {
    Text = "Tirai Penutup Jaring Takdir"
  },
  Event_125754_ChoiceDesc1 = {
    Text = "[Baca Amplopnya]Dapatkan Relic Emas\"(RelicConfig.Arg1)\", terinfeksi\"(Skill.Arg2)\""
  },
  Event_125754_ChoiceDesc2 = {
    Text = "[Baca Suratnya]Pilih 1 dari 3 kartu perintah untuk mendapatkan Terpesona:[(EnchantConfig.Arg1)]"
  },
  Event_125754_ChoiceDesc3 = {
    Text = "[Kembalikan ke Tempatnya]mendapatkan 50 Segil hitam"
  },
  Event_125754_Desc = {
    Text = [[
Gerakan kalian merobek jaring laba-laba yang rapat, dan sebuah surat tua jatuh dari dalamnya.
Bobotnya jauh lebih berat dari selembar kertas tipis.]]
  },
  Event_125754_Name = {
    Text = "Selamat Malam, Tuan Edgar"
  },
  Event_125755_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125755_Desc = {
    Text = "Air mata jatuh dari mata sang gagak. Darah mengalir dari sudut paruhnya. Sang gagak menghabiskan seluruh hidupnya, menyanyikan ramalan terakhirnya untukmu."
  },
  Event_125755_Name = {
    Text = "Ramalan Terakhir"
  },
  Event_125756_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125756_Desc = {
    Text = "\"Hehe… Hahahaha!\"\n\"Bagaimana, tamuku? Rasa takdir, kau akan gila merindukannya…\""
  },
  Event_125756_Name = {
    Text = "Rasa Takdir"
  },
  Event_125757_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125757_Desc = {
    Text = [[
"Membosankan."Suara wanita itu menguap dengan malas.
"Bawa kekuatanmu dan pergilah bertarung di klub."]]
  },
  Event_125757_Name = {
    Text = "Gembok Takdir"
  },
  Event_125758_ChoiceDesc1 = {
    Text = "[Stabilkan Jaring Takdir]Dapatkan Prasasti tingkat tinggi pilih 1 dari 3"
  },
  Event_125758_ChoiceDesc2 = {
    Text = "[Abaikan Bahaya]Dapatkan Artefak Emas\"(RelicConfig.Arg1)\", terinfeksi\"(Skill.Arg2)\""
  },
  Event_125758_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_125758_Desc = {
    Text = [[
Dia adalah anak kesayangan yang indah. Dia adalah bayi yang ditinggalkan oleh nasib. Dia adalah pembalas yang merangkak keluar dari jurang mengikuti titik cahaya yang redup. Dia datang ke sini untuk membawa pembebasan bagi segalanya. 
 Jaring Takdir runtuh di sekitar kalian. Kamu berdiri di panggung teater, tidak terlalu jauh dari Nefraea.]]
  },
  Event_125758_Name = {
    Text = "Tirai Penutup Jaring Takdir"
  },
  Event_125759_ChoiceDesc1 = {
    Text = "[Tidak Memahami]Dapatkan Artefak Perak[(RelicConfig.Arg1)]"
  },
  Event_125759_ChoiceDesc2 = {
    Text = "[Ikut Merasakan]Dapatkan Artefak Emas\"(RelicConfig.Arg1)\", terinfeksi\"(Skill.Arg2)\""
  },
  Event_125759_Desc = {
    Text = "Tangisan memilukan terdengar dari atas panggung, satu-satunya sorotan cahaya jatuh pada sosok yang kesepian.\nDia sedang mempersembahkan pertunjukan paling tulusnya untukmu—membelah isi perutnya, memperlihatkannya kepada setiap penonton.\nApa yang membuat karakter ini begitu menderita?"
  },
  Event_125759_Name = {
    Text = "Pengakuan Sang Aktor"
  },
  Event_125760_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125760_Desc = {
    Text = [[
Tanganmu terulur ke kanan.
Itu adalah masa depanmu, harapan terbesarmu, tujuan akhirmu, tempat yang akan kamu tuju.
Keberadaanmu, adalah untuk mengejar matahari di depan sana.]]
  },
  Event_125760_Name = {
    Text = "Masa Lalu, Masa Depan"
  },
  Event_125761_ChoiceDesc1 = {
    Text = "[Tiga Poin]"
  },
  Event_125761_ChoiceDesc2 = {Text = "[Enam]"},
  Event_125761_ChoiceDesc3 = {
    Text = "[Satu Titik]"
  },
  Event_125761_Desc = {
    Text = "Tentu saja kamu bisa langsung pergi, tapi dadu yang rumit itu benar-benar menarik perhatianmu.\nKamu melupakan para pengejar di belakangmu, mengambilnya dengan khidmat, dan melemparkannya ke dalam topi—"
  },
  Event_125761_Name = {
    Text = "Taruhan di Jalanan"
  },
  Event_125762_ChoiceDesc1 = {
    Text = "[Peroleh] Relik perak [(RelicConfig.Arg1)]"
  },
  Event_125762_Desc = {
    Text = "Klotak klotak, dadu menari dengan gembira di dalam wadahnya, menari hingga kelelahan.\n\n\"Kenapa… kenapa tidak pernah ada yang bisa menang!…\""
  },
  Event_125762_Name = {
    Text = "Taruhan di Jalanan"
  },
  Event_125763_ChoiceDesc1 = {
    Text = "[Terima Takdir]Pilih 1 dari 3 kartu perintah untuk mendapatkan Terpesona: [(EnchantConfig.Arg1)]"
  },
  Event_125763_ChoiceDesc2 = {
    Text = "[Melawan Takdir]Terinfeksi[(Skill.Arg1)], cetak ulang secara acak"
  },
  Event_125763_Desc = {
    Text = "\"Ah, anak nakal. Takdir selalu penuh belas kasihan… Tapi semua perlawanan ada harganya. Sekarang, apakah kau bersedia menerimanya?\""
  },
  Event_125763_Name = {
    Text = "Sangkar Takdir"
  },
  Event_125764_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125764_Desc = {
    Text = [[
Kau memandangi tatapan-tatapan itu, lalu melambaikan tangan menyapa mereka.
Segera, kau akan menghadiahkan klimaks cerita ini kepada mereka.]]
  },
  Event_125764_Name = {Text = "Penonton"},
  Event_125765_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125765_Desc = {
    Text = "\"Yang terhormat Nona Arachne, hari ini adalah hari kelahiran Anda, saya merasa bahagia untuk Tuan dan Nyonya, serta untuk Anda. Selamat datang di dunia yang indah ini. Saya mempersembahkan lagu tidur yang lembut ini untuk Anda, semoga Anda menjalani hidup yang bebas dari kekhawatiran mulai dari hari kelahiran ini...\""
  },
  Event_125765_Name = {
    Text = "Selamat Malam, Tuan Edgar"
  },
  Event_125766_ChoiceDesc1 = {
    Text = "[Ambil Foto]Pilih 1 dari 3 kartu perintah untuk mendapatkan Terpesona: [(EnchantConfig.Arg1)]"
  },
  Event_125766_ChoiceDesc2 = {
    Text = "[Ganti Lagi]Terinfeksi [(Skill.Arg1)], ganti Terpesona yang didapat di opsi 1, masih bisa digunakan satu kali"
  },
  Event_125766_Desc = {
    Text = "Menghadap lensa, kau merasa sedikit gugup. Mungkin pose ini akan lebih bagus? Atau yang itu?"
  },
  Event_125766_Name = {
    Text = "Foto dari Kursi Penonton"
  },
  Event_125767_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125767_Desc = {
    Text = [[
Kau ingin melihat apa yang ada di layar, tapi tidak ada apa-apa di sana, hanya suara gulungan film yang bergema di bioskop.
Mungkin baru lama setelah ini kau akan mendapat kesempatan untuk mengetahui isi film itu.]]
  },
  Event_125767_Name = {
    Text = "Bioskop Kenangan"
  },
  Event_125768_ChoiceDesc1 = {
    Text = "[Menghindari Pandangan] Bangun 1 Pembangun secara acak"
  },
  Event_125768_ChoiceDesc2 = {
    Text = "[Tatapan Langsung] Pilih 1 Pembangun untuk dibangunkan dan kurangi konsumsi aritmetika kartu bangun sebesar 2 poin. Infeksi [(Skill.Arg1)]"
  },
  Event_125768_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_125768_Desc = {
    Text = [[
Saat kau melangkah ke atas panggung, kau mendengar bisikan-bisikan. Kau menoleh ke belakang, sepuluh ribu pasang mata penonton melayang di sekeliling panggung, menatapmu.
Ayo! kata mereka. Drama yang menakjubkan, apakah akan berhenti di sini?
Menarilah! kata mereka. Bawakan klimaks dari tarian ini untuk kami!]]
  },
  Event_125768_Name = {Text = "Penonton"},
  Event_125769_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125769_Desc = {
    Text = [[
Kamu tidak memahami penderitaannya, dan tidak perlu memahaminya.
Teater memiliki begitu banyak panggung, dan di atas panggung ada begitu banyak boneka, kamu pun hanyalah salah satunya.
Kamu masih punya hal yang lebih penting untuk dilakukan.]]
  },
  Event_125769_Name = {
    Text = "Pengakuan Sang Aktor"
  },
  Event_125770_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125770_Desc = {
    Text = "Kematian, kepudaran, berlalunya waktu… Seni tidak ada untuk mendatangkan penderitaan. Jika keindahan hanya ada dalam penderitaan, maka keindahan seperti itu lebih baik tidak ada.\nKau berusaha keras mengusirnya. Kupu-kupu berpencar, meninggalkan sebuah jasad yang menyedihkan."
  },
  Event_125770_Name = {
    Text = "Mekar dalam Kepudaran"
  },
  Event_125771_ChoiceDesc1 = {
    Text = "[Mendengarkan Nyanyian]mendapatkan 40 Segil hitam, terinfeksi「(Skill.Arg2)」, terus memilih"
  },
  Event_125771_ChoiceDesc2 = {
    Text = "[Membiarkan Begitu Saja]mendapatkan 25 Segil hitam, pergi"
  },
  Event_125771_Desc = {
    Text = "Kawanan gagak yang pernah kau temui berkumpul menjadi satu. Dia berdiri di hadapanmu dan bernyanyi untukmu, nyanyian yang memilukan, bagaikan ramalan terakhir."
  },
  Event_125771_Name = {
    Text = "Ramalan Terakhir"
  },
  Event_125772_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125772_Desc = {
    Text = [[
Tanganmu terulur ke kiri.
Itu adalah masa lalumu, kenangan paling berhargamu, jalan yang telah kamu tempuh, tempat yang akan kamu kembali.
Semua yang telah berlalu, membentuk keseluruhan dirimu.]]
  },
  Event_125772_Name = {
    Text = "Masa Lalu, Masa Depan"
  },
  Event_125773_ChoiceDesc1 = {
    Text = "[Ambil Foto]Pilih 1 dari 3 kartu perintah untuk mendapatkan Terpesona: [(EnchantConfig.Arg1)]"
  },
  Event_125773_Desc = {
    Text = [[
Menghadap lensa, kau merasa sedikit gugup. Mungkin pose ini akan lebih bagus? Atau yang itu?
Kau masih ragu-ragu, tapi kau bisa melihat kamera itu sudah sangat tidak sabar.]]
  },
  Event_125773_Name = {
    Text = "Foto dari Kursi Penonton"
  },
  Event_125774_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125774_Desc = {
    Text = "Kau berpose, berdiri di depan kamera. Tegap, penasaran, sepenuh hati, bagaikan seorang penonton sejati.\nGluk—\nKamera menekan tombol rana, cairan hitam pekat meledak dari badan kamera, menyembur ke seluruh panggung.\nDi tengah bangkai kamera itu, film di dalamnya kosong tanpa gambar apa pun."
  },
  Event_125774_Name = {
    Text = "Foto dari Kursi Penonton"
  },
  Event_125775_ChoiceDesc1 = {
    Text = "[Terima]Dapatkan Artefak Perak pilih 1 dari 3"
  },
  Event_125775_ChoiceDesc2 = {
    Text = "[Melarikan Diri]Dapatkan Artefak Perak\"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\", terinfeksi dua kali\"(Skill.Arg3)\""
  },
  Event_125775_Desc = {
    Text = "Tak, tak, tak, tak… Hak sepatu berbenturan dengan papan kayu, menghasilkan bunyi renyah yang menyenangkan.\nDua boneka berseragam pelajar sedang menari di atas panggung. Tiba-tiba, mereka menghentikan langkah tarian mereka dan berbalik mengulurkan tangan ke arahmu."
  },
  Event_125775_Name = {
    Text = "Tarian Bertiga"
  },
  Event_125776_ChoiceDesc1 = {
    Text = "[Tahan Rasa Sakit]Tingkatkan HP maksimal sebesar Arg1 poin"
  },
  Event_125776_ChoiceDesc2 = {
    Text = "[Membantah Rasa Sakit] 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi 1 \"(Skill.Arg2)\""
  },
  Event_125776_Desc = {
    Text = "\"Kau tidak pernah peduli dengan kematian Liz. Kau tidak pernah peduli dengan siapa pun.\"\n\"Yang kau pedulikan hanyalah dirimu sendiri… Semua orang di sekitarmu hanyalah alat bagimu menuju kebebasan dan ketenangan.\"\n\"Bukankah begitu… Penjaga Rahasia?\"\nBisikan sang pembawa acara bergema di telingamu. Jantungmu terasa diremas, menyusut, rasa sakit yang hebat menjalar ke seluruh tubuhmu seiring kata-katanya…"
  },
  Event_125776_Name = {
    Text = "Penderitaan Menjalar"
  },
  Event_125777_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125777_Desc = {
    Text = "Biarkanlah kesadaranmu tenggelam, air laut memiliki daya apungnya sendiri, dan takdir akan menunjukkan jalan bagi kalian."
  },
  Event_125777_Name = {Text = "Kedamaian"},
  Event_125778_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125778_Desc = {
    Text = [[
Itu adalah dirimu sendiri. Sumber kekuatan, pemikul tanggung jawab, satu-satunya objek kesetiaan.
Kamu berjalan di jalan yang hanya milikmu.]]
  },
  Event_125778_Name = {
    Text = "Bayangan dalam Anggur"
  },
  Event_125779_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125779_Desc = {
    Text = "\"Sungguh disayangkan, tamuku. Rasa takdir, kau tidak akan punya kesempatan lagi untuk mencicipinya…\""
  },
  Event_125779_Name = {
    Text = "Rasa Takdir"
  },
  Event_125780_ChoiceDesc1 = {
    Text = "[Berdiskusi dengannya]Hapus 1 kartu perintah, dapatkan Arg1 Cap Hitam"
  },
  Event_125780_ChoiceDesc2 = {
    Text = "[Diam Membisu]"
  },
  Event_125780_Desc = {
    Text = "\"Ini benar-benar drama yang menyedihkan… Gadis malang itu, apakah dia ditinggalkan oleh orang yang dicintainya, Kakak?\"\nDalam suara yang familiar itu, kau tak mendengar kegilaan maupun kebencian. Suara itu jernih, sendu, bagaikan aliran sungai kecil yang lembut di hutan.\n\"Sang penyanyi itu, sehelai daun kering yang melayang tak berdaya, hanya bisa pasrah didera takdir… Betapa kasihannya…\"\n\"Menurutmu, jika aku adalah sang penulis naskah… akhir seperti apa yang harus kutulis untuknya?\""
  },
  Event_125780_Name = {
    Text = "Akhir dari Naskah"
  },
  Event_125781_ChoiceDesc1 = {
    Text = "[Mengelus]50% kemungkinan mendapatkan 125 Tinta Hitam, 50% kemungkinan terinfeksi[(Skill.Arg2)]"
  },
  Event_125781_ChoiceDesc2 = {
    Text = "[Menjelaskan]75% kemungkinan mendapatkan 100 Tinta Hitam, 25% kemungkinan terinfeksi[(Skill.Arg2)]"
  },
  Event_125781_ChoiceDesc3 = {
    Text = "[Memecahkan]Dapatkan 50 Tinta Hitam"
  },
  Event_125781_Desc = {
    Text = [[
Saat kau mengejar ke gang belakang bar, sosok monster itu menghilang, dan sekelompok kucing hitam menghalangi jalanmu.
"Hei, kau."Seekor kucing hitam menjilat cakarnya dan menatapmu.
"Apa yang kau lakukan di tempat kami?"]]
  },
  Event_125781_Name = {
    Text = "Ilusi Berubah Rupa"
  },
  Event_125782_ChoiceDesc1 = {
    Text = "[Peluk Masa Lalu]Dapatkan Artefak Emas\"(RelicConfig.Arg1)\", terinfeksi\"(Skill.Arg2)\""
  },
  Event_125782_ChoiceDesc2 = {
    Text = "[Sambut Masa Depan]Dapatkan Artefak Emas pilih 1 dari 3, terinfeksi[(Skill.Arg1)]"
  },
  Event_125782_ChoiceDesc3 = {
    Text = "[Peroleh] Relik perak [(RelicConfig.Arg1)]"
  },
  Event_125782_Desc = {
    Text = [[
Kedatangan Nefraea mengganggu benang. Dalam nasib yang kacau, kamu melihat dua fatamorgana yang samar. 
 Itu adalah masa lalumu, itu adalah masa depanmu. Kamu mendekatinya, mengulurkan tanganmu...]]
  },
  Event_125782_Name = {
    Text = "Masa Lalu, Masa Depan"
  },
  Event_125855_ChoiceDesc1 = {
    Text = "[Rasakan]Pilih 1 Artefak untuk diubah menjadi Artefak Emas[(RelicConfig.Arg1)]"
  },
  Event_125855_ChoiceDesc2 = {
    Text = "[Gaze] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_125855_ChoiceDesc3 = {
    Text = "[Mengabaikan] Mendapatkan 25 Segil Hitam"
  },
  Event_125855_Desc = {
    Text = "Di jalanan Kassalim, cahaya menyilaukan dari sebuah toko kristal menarik perhatianmu. Kamu mendatangi toko itu dan mengambil sebuah kristal berbentuk inti perak."
  },
  Event_125855_Name = {
    Text = "Rahasia Kristal"
  },
  Event_125856_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125856_Desc = {
    Text = "Kamu memejamkan mata dan merasakannya dengan saksama.\nSeberkas cahaya redup berkedip dalam kesadaranmu, ia ingin memberitahumu sesuatu…"
  },
  Event_125856_Name = {
    Text = "Rahasia Kristal"
  },
  Event_125857_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125857_Desc = {
    Text = "Segala perlawanan dan pengintipan terhadap takdir adalah sia-sia. Kau menutup mata dengan tenang, membiarkan takdir membawamu ke tempat yang seharusnya kau tuju."
  },
  Event_125857_Name = {
    Text = "Jaring Pengikat Takdir"
  },
  Event_125858_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125858_Desc = {
    Text = "\"Perasaan adalah makna dari keberlangsungan. Semoga kamu tidak menyesali pilihanmu.\""
  },
  Event_125858_Name = {
    Text = "Bayaran Sebuah Pilihan"
  },
  Event_125859_ChoiceDesc1 = {
    Text = "[Perasaan]Pulihkan Arg1 poin nyawa"
  },
  Event_125859_ChoiceDesc2 = {
    Text = "[Akal]1 kartu perintah acak mendapatkan Prasasti:[(EnchantConfig.Arg1)]"
  },
  Event_125859_ChoiceDesc3 = {
    Text = "[Tolak Pilihan]mendapatkan 25 Segil hitam"
  },
  Event_125859_Desc = {
    Text = "Sebuah timbangan muncul di atas panggung.\n\"Otak dan jantung, akal dan perasaan, abu dan merah… Kita tidak bisa menghindari pilihan, itulah takdir kita.\"\n\"Titik akhir panggung telah ditentukan. Sekarang, pilihlah jalan yang akan dilalui panggung ini.\""
  },
  Event_125859_Name = {
    Text = "Bayaran Sebuah Pilihan"
  },
  Event_125860_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125860_Desc = {
    Text = [[
"Jangan mendongak. Pergi dari sini."
Kamu mendengar suara takdir. Kamu sangat ingin memandang langit, tapi kamu tahu, dia benar.]]
  },
  Event_125860_Name = {
    Text = "Memandang ke Atas"
  },
  Event_125861_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125861_Desc = {
    Text = "Kau tidak akan pernah menerima takdir. Kau tidak akan pernah menerima pemenjaraan.\nKau meronta sekuat tenaga, dan setelah mengorbankan salah satu anggota tubuh ngengat, kau akhirnya berhasil melarikan diri…"
  },
  Event_125861_Name = {
    Text = "Jaring Pengikat Takdir"
  },
  Event_125862_ChoiceDesc1 = {
    Text = "[Persahabatan]Dapatkan 50 Tinta Hitam"
  },
  Event_125862_ChoiceDesc2 = {
    Text = "[Bantuan]Dapatkan 75 Tinta Hitam, terinfeksi[(Skill.Arg2)]"
  },
  Event_125862_Desc = {
    Text = [[
Di gang belakang bar, kau bertemu lagi dengan kucing-kucing hitam itu.
"Aku sudah dengar. Cairan hitam itu berubah menjadi wujud kami dan memberimu banyak masalah."
"Sebagai permintaan maaf, katakan padaku, apa yang kau inginkan?"
Kucing hitam itu berputar dua kali di sekitar kakimu, lalu mendongak menatapmu.]]
  },
  Event_125862_Name = {
    Text = "Hadiah Pertemuan Pertama"
  },
  Event_125863_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125863_Desc = {
    Text = "Kekuatan kasar tidak bisa memecahkan takdir, tapi mungkin kebijaksanaan bisa?\nKau mengamati jaring ini dengan saksama, mencoba mengintip jejak takdir darinya…"
  },
  Event_125863_Name = {
    Text = "Jaring Pengikat Takdir"
  },
  Event_125864_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125864_Desc = {
    Text = "Kamu mendekat dan menatapnya dengan saksama.\nSeberkas cahaya redup berkedip di matamu, ia ingin memberitahumu sesuatu…"
  },
  Event_125864_Name = {
    Text = "Rahasia Kristal"
  },
  Event_125865_ChoiceDesc1 = {
    Text = "[Meronta]Ambil secara acak 3 kartu perintah dari dek, pilih 1 kartu untuk dihapus, dapatkan 75 Tinta Hitam"
  },
  Event_125865_ChoiceDesc2 = {
    Text = "[Berpikir]Ambil secara acak 3 kartu perintah dari dek, pilih 1 kartu untuk memasukkan salinan aslinya ke dek, dapatkan 25 Tinta Hitam"
  },
  Event_125865_ChoiceDesc3 = {
    Text = "[Beristirahat]Dapatkan 50 Tinta Hitam"
  },
  Event_125865_Desc = {
    Text = [[
Perasaan yang familiar menyergapmu, bedanya, sensasi lengket itu, insting tak berdaya untuk melawan, kali ini jauh lebih kuat, jauh lebih mematikan dari sebelumnya.
Ngengat jatuh ke dalam jaring laba-laba, dan kau pun telah melangkah ke atas panggung.]]
  },
  Event_125865_Name = {
    Text = "Jaring Pengikat Takdir"
  },
  Event_125866_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125866_Desc = {
    Text = "\"Akal sehat adalah sarana untuk bertahan. Semoga kau tidak menyesali pilihanmu.\""
  },
  Event_125866_Name = {
    Text = "Bayaran Sebuah Pilihan"
  },
  Event_125867_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125867_Desc = {
    Text = "Rasa penasaranmu tersulut. Kamu bergabung dengan kerumunan dan mendongak seperti mereka.\nTidak ada apa-apa di sana, tapi entah mengapa, kamu tidak mau mengalihkan pandanganmu. Kamu ingin terus menatap, terus menatap…"
  },
  Event_125867_Name = {
    Text = "Memandang ke Atas"
  },
  Event_125868_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125868_Desc = {
    Text = "\"Melepaskan pilihan juga merupakan sebuah pilihan, itulah kutukan takdir. Semoga kau tidak menyesali pilihanmu.\""
  },
  Event_125868_Name = {
    Text = "Bayaran Sebuah Pilihan"
  },
  Event_125869_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125869_Desc = {
    Text = [[
"Sekarang, kau sudah memilikinya."
Kucing hitam itu menggesekkan tubuhnya ke betismu, lalu segera menghilang.
Di tempat mereka menghilang, sebuah hadiah menunggumu.]]
  },
  Event_125869_Name = {
    Text = "Hadiah Pertemuan Pertama"
  },
  Event_125870_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_125870_Desc = {
    Text = [[
"Sekarang, kau sudah memilikinya."
Kucing hitam itu menggesekkan tubuhnya ke betismu, lalu segera menghilang.
Di tempat mereka menghilang, sebuah hadiah menunggumu.]]
  },
  Event_125870_Name = {
    Text = "Hadiah Pertemuan Pertama"
  },
  Event_125871_ChoiceDesc1 = {
    Text = "[Mendongak] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_125871_ChoiceDesc2 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_125871_Desc = {
    Text = "Suara bising sesaat menghilang. Kerumunan di jalanan terdiam, mendongak menatap langit."
  },
  Event_125871_Name = {
    Text = "Memandang ke Atas"
  },
  Event_129176_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129176_Name = {
    Text = "Lupakan Bab 1@"
  },
  Event_129177_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129177_Name = {
    Text = "Bab 1 Bintang@"
  },
  Event_129178_ChoiceDesc1 = {
    Text = "[Indikasi arah] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129178_ChoiceDesc2 = {
    Text = "[Berdoa Bersama] Dapatkan Orison pilih 1 dari 3 sebanyak dua kali"
  },
  Event_129178_Desc = {
    Text = [[
Suara piano dan organ saling bertautan di tengah angin kelabu. Seakan melodi yang mengandung sihir melayang di jalan-jalan kosong. 
Seorang biarawati tanpa nama berdoa di tengah alunan musik. 
"Doa sederhana tidak memerlukan upacara yang megah, Bapa yang Maha Besar akan menaburkan harapan bagi kita, sebagaimana Dia pernah memberikan ajaran penuh kesalehan kepada kita."]]
  },
  Event_129178_Name = {
    Text = "Doa Pemain Organ"
  },
  Event_129179_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129179_Name = {
    Text = "Bab 1 Bintang@"
  },
  Event_129180_ChoiceDesc1 = {
    Text = "[Menyerang secara aktif] Memperoleh Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129180_ChoiceDesc2 = {
    Text = "[Lepaskan Perlawanan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)] dua kali"
  },
  Event_129180_ChoiceDesc3 = {
    Text = "[Cepat Pergi]mendapatkan 50 Segil hitam"
  },
  Event_129180_Desc = {
    Text = "Beberapa patung lilin mentah menghalangi jalanmu. \nMereka tampak bengkok dan kasar, tidak seperti kualitas yang seharusnya dibuat oleh Rogers. \n\"Perintah… perintah Tuan…\""
  },
  Event_129180_Name = {Text = "Latihan"},
  Event_129181_ChoiceDesc1 = {
    Text = "[Meninggalkan Pemikiran] memperoleh Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129181_ChoiceDesc2 = {
    Text = "[Kejar Ilham] 1 Kartu perintah acak mendapatkan Orison: [(EnchantConfig.Arg1)] dua kali"
  },
  Event_129181_Desc = {
    Text = [[
Pelabuhan diserang, kapal kargo misterius yang datang tanpa kembali dan "teman baru" bersirip... Apakah ini jebakan yang direncanakan dengan matang? Atau perjalanan lain yang penuh kejadian tak terduga? 
 Kenyataan dan akal sehat saling tarik-menarik, berbagai inspirasi dan pikiran membanjiri pikiran.]]
  },
  Event_129181_Name = {
    Text = "Ledakan Inspirasi"
  },
  Event_129182_ChoiceDesc1 = {
    Text = "[Bergabung] Terinfeksi \"(Skill.Arg1)\" dua kali, 1 Kartu acak mendapatkan Orison: \"(EnchantConfig.Arg2)\" dua kali"
  },
  Event_129182_ChoiceDesc2 = {
    Text = "[Mengusir] Terinfeksi \"(Skill.Arg1)\" dua kali, 1 Kartu acak mendapatkan Orison: \"(EnchantConfig.Arg2)\" dua kali"
  },
  Event_129182_ChoiceDesc3 = {
    Text = "[Acuh Tak Acuh] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)] dua kali"
  },
  Event_129182_Desc = {
    Text = [[
Kamu mendengar suara tanduk tulang yang samar-samar dari kejauhan. 
 Kawanan tikus muncul dari lumpur hitam, menggerogoti tubuh tanpa nama yang tergeletak di dasar sungai yang kering. 
 Mereka membentuk sebuah lingkaran, dengan pusat lingkaran adalah mayat yang telah kosong, dan kelilingnya adalah sebuah kerajaan baru yang diatur oleh hukum pelupaan. 
 Dan kamu, sedang berdiri di pintu masuk kerajaan ini.]]
  },
  Event_129182_Name = {
    Text = "Kerajaan Terasing"
  },
  Event_129183_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129183_Name = {
    Text = "Lupakan Bab Kelima@"
  },
  Event_129184_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129184_Name = {
    Text = "Lupakan Bab 8@"
  },
  Event_129185_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129185_Name = {
    Text = "Lupakan Bab 1@"
  },
  Event_129186_ChoiceDesc1 = {
    Text = "[Menyelamatkan Potret] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129186_ChoiceDesc2 = {
    Text = "[Menerima Kekosongan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129186_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_129186_Desc = {
    Text = [[
Kau berdiri di depan hadiah dari Pikman.
Itu adalah lukisan potret, dicat dengan darah, api hitam menyala diam.
Melalui rongga kosong mata orang dalam lukisan, kau melihat---
memori-memorimu berkobar, membentang, terdistorsi, bersinar, seolah ada api tak terlihat yang sedang menjilati koridor dalam kepalamu. Dalam keadaan bingung, kau mendengar satu suara.
"Sudah saatnya dimasak, ini sudah tepat."
Ini adalah pemandangan ingatan yang kau lukis sendiri, kau berjuang dan berubah dalam api.]]
  },
  Event_129186_Name = {
    Text = "Potret Terbakar"
  },
  Event_129187_ChoiceDesc1 = {
    Text = "[Apa yang bersedia Kamu korbankan?] Secara acak tingkatkan kualitas Orison 1 Kartu sebanyak dua kali"
  },
  Event_129187_ChoiceDesc2 = {
    Text = "[Traktir mereka segelas Bloody Mary kadaluarsa] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129187_Desc = {
    Text = [[
"Selamat datang, tamu berharga saya. Silakan pilih sesuka hati, semua ini ada di sini menunggu kehadiranmu."
"Eh, maaf mengganggu, bolehkah saya bertanya, apakah Anda... saudara kembar Nyonya Narsis?"
"Saya adalah Narsis sendiri, bolehkah saya bertanya apa keperluan tamu hari ini...?"
"Maaf, maaf, Anda terlihat lebih memesona dibanding sebelumnya, sampai saya tidak mengenali Anda. Apakah Anda masih ingat? Dua puluh tahun yang lalu, Anda membantu bar saya mengusir seorang aneh... Kemarin, mimpi buruk itu kembali, ia menduduki bar bersama teman-temannya, bergerombol..."]]
  },
  Event_129187_Name = {
    Text = "Fragmen Kenangan·Mimpi Lama Kembali"
  },
  Event_129188_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129188_Name = {
    Text = "Bintang Bab 3@"
  },
  Event_129189_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129189_Name = {
    Text = "Lupakan Bab 8@"
  },
  Event_129190_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129190_Name = {
    Text = "Lupakan Bab 1@"
  },
  Event_129191_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129191_Name = {
    Text = "Lupakan Bab Keenam@"
  },
  Event_129192_ChoiceDesc1 = {
    Text = "[Genggam Api] Meningkatkan Kesehatan maksimum sebesar Arg1"
  },
  Event_129192_ChoiceDesc2 = {
    Text = "[Hadapi Hati Nurani] 2 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, infeksi 2 kartu \"(Skill.Arg2)\" dua kali"
  },
  Event_129192_Desc = {
    Text = "Dalam perburuan besar ini, kejaran Goliath seperti binatang buas di malam gelap, berusaha melahap semua cahaya harapan. Namun, pengejaran tanpa ampun ini tidak membekukan dirimu, melainkan menyalakan api di dalam hatimu, yang menjalar dan berkobar di dalam dada, semakin lama semakin membara."
  },
  Event_129192_Name = {
    Text = "Mengejar Cahaya"
  },
  Event_129193_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129193_Name = {
    Text = "Lupakan Bab Keenam@"
  },
  Event_129194_ChoiceDesc1 = {
    Text = "[Membaca Jalan Pendahulu] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129194_ChoiceDesc2 = {
    Text = "[Membentuk jalan sendiri] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129194_ChoiceDesc3 = {
    Text = "[Melihat Kegelapan] Mendapatkan 25 Segil Hitam"
  },
  Event_129194_Desc = {
    Text = [[
Jika kamu seorang diri meraba-raba maju di Domain, pasti tidak akan seyakin ini dengan jalan di depanmu. 
Jejak di Domain terbagi menjadi tiga, setiap jejak yang tertinggal menuliskan masa depan yang tak terlihat.]]
  },
  Event_129194_Name = {Text = "Keluaran"},
  Event_129195_ChoiceDesc1 = {
    Text = "[Menunjukkan Kesalahan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129195_ChoiceDesc2 = {
    Text = "[Setelah mendengarkan permainan] Untuk setiap Pembangun dengan nilai Aliemus 50 atau lebih, dapatkan 15 Segil hitam."
  },
  Event_129195_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 1 dari 3 pilihan Orison"
  },
  Event_129195_Desc = {
    Text = "Patung lilin anak laki-laki duduk di depan piano memainkan etude.\nGurunya — juga terbuat dari patung lilin, sedang memberikan bimbingan di sampingnya.\n133, 355, 244...\nSalah, setiap nada salah."
  },
  Event_129195_Name = {
    Text = "Pelajaran piano"
  },
  Event_129196_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129196_Name = {
    Text = "Lupakan Bab Kelima@"
  },
  Event_129197_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129197_Name = {
    Text = "Bintang Bab 4@"
  },
  Event_129198_ChoiceDesc1 = {
    Text = "[Mendengarkan Kesedihan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129198_ChoiceDesc2 = {
    Text = "[ Mendengarkan Kebahagiaan ] Untuk setiap Pembangun dengan nilai Aliemus 50 atau lebih, dapatkan 15 Segil hitam."
  },
  Event_129198_ChoiceDesc3 = {
    Text = "[Pergi] Dapatkan Orison pilih 1 dari 3 sebanyak dua kali"
  },
  Event_129198_Desc = {
    Text = [[
Melodi yang lembut, puitis, gembira, dan sedih... bergema di ruang Domain, sulit untuk menentukan dari mana sumbernya. 
 Apakah ini sonata yang mengalir dari speaker kapal hantu, ataukah fantasi tengah malam yang terkurung di dalam Domain?]]
  },
  Event_129198_Name = {
    Text = "Suara Tanpa Nama"
  },
  Event_129199_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129199_Name = {
    Text = "Bab 1 Bintang@"
  },
  Event_129200_ChoiceDesc1 = {
    Text = "[Buka Amplop]mendapatkan Relik emas\"(RelicConfig.Arg1)\", terinfeksi\"(Skill.Arg2)\""
  },
  Event_129200_ChoiceDesc2 = {
    Text = "[Membaca] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)] dua kali"
  },
  Event_129200_ChoiceDesc3 = {
    Text = "[Kembalikan ke Tempatnya]mendapatkan 50 Segil hitam"
  },
  Event_129200_Desc = {
    Text = [[
Di sudut yang diabaikan, sebuah surat tergeletak.
Banyak tulisan di surat itu sudah tidak dapat dibaca, tetapi hanya ada satu kata yang jelas terbaca.
Kata itu adalah "ibu".]]
  },
  Event_129200_Name = {
    Text = "Kerinduan yang Menghilang"
  },
  Event_129201_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129201_Name = {
    Text = "Bintang Bab 4@"
  },
  Event_129202_ChoiceDesc1 = {
    Text = "[Dengarkan dengan Seksama] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, infeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129202_ChoiceDesc2 = {
    Text = "[Tutup telinga] Untuk setiap Pembangun dengan nilai Aliemus 50 atau lebih, dapatkan 15 Segil hitam."
  },
  Event_129202_ChoiceDesc3 = {
    Text = "[Periksa] Dapatkan Orison pilih 1 dari 3 sebanyak dua kali"
  },
  Event_129202_Desc = {
    Text = "Ketika kalian memasuki lantai tempat kerangka berada, suara merdu dan nyaring tiba-tiba terdengar di pabrik tua yang kosong. Kesan dingin dari permainan piano sangat kontras dengan reruntuhan besi yang berkarat."
  },
  Event_129202_Name = {
    Text = "Skala Sinister"
  },
  Event_129203_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129203_Name = {
    Text = "Lupakan Bab 3@"
  },
  Event_129204_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129204_Name = {
    Text = "Lupakan Bab Keenam@"
  },
  Event_129205_ChoiceDesc1 = {
    Text = "[Membebaskannya] Mendapatkan Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129205_ChoiceDesc2 = {
    Text = "[Membantunya] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)] dua kali"
  },
  Event_129205_ChoiceDesc3 = {
    Text = "[Saya ingin berjalan di jalan sendiri]Mendapatkan 50 Segil Hitam"
  },
  Event_129205_Desc = {
    Text = [[
Tiga bayangan menghalangi jalanmu.
"Kau bisa melepaskannya,"bayangan yang memegang boneka beruang yang ternoda D-lendir berkata, "dia hanya takut, bukan jahat. Dia tidak ingin melukai siapa pun."
"Kau bisa membantunya,"bayangan yang memegang sekumpulan permen yang dikemas dengan indah berkata, "kau bisa melakukan apa yang tidak bisa dilakukannya, kau bisa mengakhiri semua ini."
"Kau tidak perlu mendengarkan kami,"bayangan yang kosong berkata, "kau memiliki jalanmu sendiri."]]
  },
  Event_129205_Name = {
    Text = "Jalan yang bercabang"
  },
  Event_129206_ChoiceDesc1 = {
    Text = "[Memberi makan tikus] Mendapatkan Relik perak [(RelicConfig.Arg1)], pilih untuk menginfeksi gejala sebanyak 1 kali."
  },
  Event_129206_ChoiceDesc2 = {
    Text = "[Mengusir Tikus] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129206_ChoiceDesc3 = {
    Text = "[Mengabaikan tikus] Mendapatkan 25 Segil Hitam"
  },
  Event_129206_Desc = {
    Text = [[
Segala sesuatu di kapal ini berada dalam siklus reinkarnasi.
Makhluk-makhluk kecil menjijikkan yang dipenuhi bulu kotor yang mencari nafkah di kapal ini tentu saja juga tidak bisa menghindari takdir semacam itu.
Dalam siklus reinkarnasi yang berulang-ulang, mereka memakan segala yang bisa mereka lihat, namun tetap tidak bisa terpuaskan.
 "La... par sekali..."
Kawanan tikus mengeluarkan pekikan melengking yang menyakitkan dan tidak wajar.
Siklus reinkarnasi yang berulang membuat mereka kelaparan tak tertahankan, mereka harus makan sesuatu.
Segera, sekarang juga!]]
  },
  Event_129206_Name = {
    Text = "Gerombolan Tikus yang Kelaparan"
  },
  Event_129207_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129207_Name = {
    Text = "Lupakan Bab 8@"
  },
  Event_129208_ChoiceDesc1 = {
    Text = "[Menyentuh Otak] 1 Kartu perintah acak mendapatkan Orison: [(EnchantConfig.Arg1)] dua kali"
  },
  Event_129208_ChoiceDesc2 = {
    Text = "[Menyentuh Jantung]meningkatkan Arg1 poin Kesehatan maksimum，terinfeksi[(Skill.Arg2)]"
  },
  Event_129208_Desc = {
    Text = [[
Kamu melangkah ke dalam ruang abu-abu yang sunyi tanpa bisikan, sebuah neraca samar-samar terlihat di dalam kabut hitam. 
Di sebelah kiri, terdapat sebuah otak yang tenang seperti danau, dengan lembah perak yang berkilau lembut; di sebelah kanan, ada sebuah jantung merah menyala yang mengeluarkan uap panas. 
Tiba-tiba, kamu mencium aroma yang menggoda, keinginan yang lapar terus membengkak, akal sehatmu tertekan oleh kegelapan-Nya yang tak terbatas. 
Kamu mengulurkan tanganmu.]]
  },
  Event_129208_Name = {
    Text = "Permainan Lapar"
  },
  Event_129209_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129209_Name = {
    Text = "Lupakan Bab Keempat@"
  },
  Event_129210_ChoiceDesc1 = {
    Text = "[Bunuh Bayangan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, infeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129210_ChoiceDesc2 = {
    Text = "[Hancurkan Embryo] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, infeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129210_ChoiceDesc3 = {
    Text = "[Tutup mata] mendapatkan 25 Segil Hitam"
  },
  Event_129210_Desc = {
    Text = [[
Dalam keadaan bingung, kamu melihat orang-orang yang pernah kamu temui di Aran mendekat kepadamu.
Mereka tertawa dan mengundangmu untuk minum, menari, dan mencicipi makanan.
Kemudian, daging dan darah mereka terkelupas lapis demi lapis, yang jatuh ke tanah dan bergerak untuk menghasilkan embrio baru.
Mereka mengulurkan tangan kepada kamu, mengundangmu untuk bergabung dalam pesta daging dan kelahiran baru.]]
  },
  Event_129210_Name = {
    Text = "Bayangan Masa Lalu"
  },
  Event_129211_ChoiceDesc1 = {
    Text = "[Memberi Makan Mereka]mendapatkan Relik perak[(RelicConfig.Arg1)], memilih untuk terinfeksi 1 kali gejala"
  },
  Event_129211_ChoiceDesc2 = {
    Text = "[Tidak Peduli] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, infeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129211_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_129211_Desc = {
    Text = [[
Penghuni datang dan pergi, sementara kawanan tikus tetap ada.
Dibandingkan manusia, mereka adalah "penduduk asli" kastil ini.
Namun, mereka tidak keberatan dengan kehadiran manusia.
Karena makhluk berbau manis dan lembut itu akan memberi mereka makhluk berbau manis dan lembut yang sama.
"Dan kamu, makhluk berbau busuk, termasuk yang mana?"]]
  },
  Event_129211_Name = {
    Text = "Rahasia Kuno dari Istana"
  },
  Event_129212_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129212_Name = {
    Text = "Lupakan Bab Kelima@"
  },
  Event_129213_ChoiceDesc1 = {
    Text = "[Membedakan suara pria] Dapatkan 3 Kartu Perintah secara acak dari dek dan pilih 1 untuk disalin."
  },
  Event_129213_ChoiceDesc2 = {
    Text = "[Kenali Suara wanita] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, infeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129213_ChoiceDesc3 = {
    Text = "[Membedakan suara orang tua] Mendapatkan 25 Segil hitam"
  },
  Event_129213_Desc = {
    Text = [[
Kamu berdiri sendirian di tengah rawa kegelapan. 
 Dalam kabut samar, kamu mendengar suara delirium yang bersilangan dalam Chaos datang seperti gelombang, beberapa berasal dari lansia yang sudah lanjut usia, beberapa berasal dari anak-anak yang baru belajar berbicara, beberapa berasal dari wanita yang gelisah, dan beberapa berasal dari pria yang tak berdaya dalam Ketakutan......]]
  },
  Event_129213_Name = {
    Text = "Kata-kata Terakhir yang Tidak Masuk Akal"
  },
  Event_129214_ChoiceDesc1 = {
    Text = "[Perhatikan dengan Seksama] Dapatkan Orison pilih 1 dari 3 sebanyak dua kali"
  },
  Event_129214_ChoiceDesc2 = {
    Text = "[Merobek Poster] 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129214_Desc = {
    Text = [[
Sebuah kandil yang bisa ditemukan di mana saja di dalam museum lilin.
Dengan cahaya oranye yang menyeramkan, kamu menemukan sebuah poster bergambar tangan yang ditempel di dinding.]]
  },
  Event_129214_Name = {
    Text = "Tawa dalam Kegelapan"
  },
  Event_129215_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129215_Name = {
    Text = "Lupakan Bab Keempat@"
  },
  Event_129216_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129216_Name = {
    Text = "Lupakan Bab 7@"
  },
  Event_129217_ChoiceDesc1 = {
    Text = "[Gaze] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129217_ChoiceDesc2 = {
    Text = "[Abaikan] Dapatkan Orison pilih 1 dari 3 sebanyak dua kali"
  },
  Event_129217_Desc = {
    Text = [[
Aram berlutut di tengah badai pasir.
Badai menghantam tubuh mereka, pasir menyapu habis kesalehan mereka.
Di dalam pusaran debu, seolah-olah ada banyak mata raksasa yang mengamati tanah yang terdistorsi.]]
  },
  Event_129217_Name = {
    Text = "Gigante Pasir dan Debu"
  },
  Event_129218_ChoiceDesc1 = {
    Text = "[Mengusir Kupu-Kupu] 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129218_ChoiceDesc2 = {
    Text = "[Mendengarkan Keinginan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)] dua kali"
  },
  Event_129218_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_129218_Desc = {
    Text = [[
Kupu-kupu kecil, juga memiliki banyak mimpi.
Mimpi-mimpi ini tersebar di lautan bunga, di ruang perawatan, dan juga di altar @2 yang penuh dengan banyak darah dan daging.
Kini, ia akhirnya menunggu orang yang terikat, tidak tahu apakah kamu mau mendengarkan harapan kecilnya yang kecil.]]
  },
  Event_129218_Name = {
    Text = "Mimpi kupu-kupu"
  },
  Event_129219_ChoiceDesc1 = {
    Text = "[Mengikuti Petunjuk] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129219_ChoiceDesc2 = {
    Text = "[Mengabaikan Petunjuk] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129219_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_129219_Desc = {
    Text = "Perayaan telah dimulai.\nDi bawah kembang api roh dan doa darah, jiwa-jiwa penganut yang tak terhitung berubah menjadi mercu penunjuk jalan——\nRoh-roh samar tersebar di sekelilingmu, bagaikan peri penunjuk jalan, berkilau menunggu pilihanmu."
  },
  Event_129219_Name = {Text = "Mercu Jiwa"},
  Event_129220_ChoiceDesc1 = {
    Text = "[Mengabaikan Bunyi Bel] Dapatkan Orison tingkat lanjut pilih 1 dari 3 sebanyak dua kali"
  },
  Event_129220_ChoiceDesc2 = {
    Text = "[Mengangkat Telepon]mendapatkan Relik emas\"(RelicConfig.Arg1)\"，terinfeksi\"(Skill.Arg2)\""
  },
  Event_129220_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_129220_Desc = {
    Text = "Seharusnya tidak berbunyi—telepon itu, terentang di balik kanvas.\nKabel dari gagang telepon terjerat di tubuh mesin yang besar, seperti tali pusar yang berkarat, tampak merentang dari dalam kepalamu.\nKamu dengan hati-hati membedakan frekuensi getaran, suara aneh itu seperti seni surreal Pikman."
  },
  Event_129220_Name = {
    Text = "Panggilan terlewat"
  },
  Event_129221_ChoiceDesc1 = {
    Text = "[Kami Baik-baik Saja] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129221_ChoiceDesc2 = {
    Text = "[Kamu Siapa?] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129221_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_129221_Desc = {
    Text = [[
Mesin tik tiba-tiba menyemburkan tinta, dengan tanda seru yang begitu mencolok. 
"Boneka, apakah kamu baik-baik saja??? Kenapa kamu juga menghilang setelah Penjaga menghilang??? Tolong beri kabar jika kamu selamat!!! Jika menunggu lebih lama, rambut William akan rontok habis!!!"]]
  },
  Event_129221_Name = {
    Text = "Komunikasi Darurat"
  },
  Event_129222_ChoiceDesc1 = {
    Text = "[Memotong pita merah] Hapus 1 Kartu Perintah, dapatkan Arg1 Segil Hitam"
  },
  Event_129222_ChoiceDesc2 = {
    Text = "[Melawan] Salin 1 Kartu Perintah, infeksi [(Skill.Arg1)]"
  },
  Event_129222_ChoiceDesc3 = {
    Text = "[Panggilan Ramona] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)] dua kali"
  },
  Event_129222_Desc = {
    Text = "Casiah melemparkan kain merah, yang seketika melilit koper Anda."
  },
  Event_129222_Name = {
    Text = "Seda yang Berantakan"
  },
  Event_129223_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129223_Name = {
    Text = "Lupakan Bab Keenam@"
  },
  Event_129224_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129224_Name = {
    Text = "Bintang Bab 3@"
  },
  Event_129225_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129225_Name = {
    Text = "Lupakan Bab 3@"
  },
  Event_129226_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129226_Name = {
    Text = "Lupakan Bab Keempat@"
  },
  Event_129227_ChoiceDesc1 = {
    Text = "[Melambai untuk Mengusir] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129227_ChoiceDesc2 = {
    Text = "[Dibiarkan tetap] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129227_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_129227_Desc = {
    Text = "Dari kegelapan terdengar suara pelan.\nItu adalah seekor kupu-kupu yang bertanya dengan sopan.\n \"Bolehkah aku hinggap di telapak tanganmu?\"\n \"Aku hanya terlalu lelah, ingin beristirahat sebentar...\"\nSambil bertanya demikian, kupu-kupu itu menembus kegelapan, berputar-putar di hadapanmu.\nCairan hitam pekat menetes dari sayapnya — itu adalah pemberian dari kegelapan saat kupu-kupu menembus kegelapan."
  },
  Event_129227_Name = {
    Text = "Permintaan Kupu-kupu"
  },
  Event_129228_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129228_Name = {
    Text = "Lupakan Bab 7@"
  },
  Event_129229_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129229_Name = {
    Text = "Lupakan Bab 7@"
  },
  Event_129230_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129230_Name = {
    Text = "Lupakan Bab 1@"
  },
  Event_129231_ChoiceDesc1 = {
    Text = "[Mengenali lirik] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129231_ChoiceDesc2 = {
    Text = "[Bergumam Pelan] Dapatkan Orison pilih 1 dari 3 sebanyak dua kali"
  },
  Event_129231_Desc = {
    Text = [[
Nyanyian kapal kuno bergema di dalam Domain.
Memori yang terjebak di Domain bernyanyi dalam bahasa yang belum pernah kamu dengar, melantunkan tentang ombak, langit, dan minuman keras.]]
  },
  Event_129231_Name = {Text = "Lagu Laut"},
  Event_129232_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129232_Name = {
    Text = "Lupakan Bab 8@"
  },
  Event_129233_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129233_Name = {
    Text = "Bab 1 Bintang@"
  },
  Event_129234_ChoiceDesc1 = {
    Text = "[Memotong Telapak Tangan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129234_ChoiceDesc2 = {
    Text = "[Menerima Pertumbuhan]mendapatkan Relik perak\"(RelicConfig.Arg1)\"，terinfeksi\"(Skill.Arg2)\""
  },
  Event_129234_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_129234_Desc = {
    Text = [[
Kupu-kupu itu tidak terbang datang, melainkan tumbuh perlahan dari telapak tanganmu. 
 Awalnya kamu mengira itu hanya keringat, namun di antara celah jari, kamu melihat cairan hitam mengalir diam-diam seperti aliran darah, mengkristal menjadi sayap yang dingin dan berdenyut. 
 Setiap kali ia mengepak, gelombang muncul dalam darahmu.]]
  },
  Event_129234_Name = {
    Text = "Parasit kelas atas"
  },
  Event_129235_ChoiceDesc1 = {
    Text = "[Terus Membaca] 1 Kartu perintah acak mendapatkan Orison: [(EnchantConfig.Arg1)] dua kali"
  },
  Event_129235_ChoiceDesc2 = {
    Text = "[Meninggalkan] Meningkatkan Arg1 poin Kesehatan maksimum, terinfeksi [(Skill.Arg2)]"
  },
  Event_129235_Desc = {
    Text = "Sebuah timbangan yang digunakan untuk menimbang.\nDi belakangnya, tak terhitung banyaknya organ direndam dalam formalin merah.\nOrgan-organ tersebut disusun rapi di rak penyimpanan.\nKamu mengambil buku catatan di samping dan membacanya:\n\"Jantung: 8 ons, Otak: 50 ons…\""
  },
  Event_129235_Name = {
    Text = "Pendaftaran Organ"
  },
  Event_129236_ChoiceDesc1 = {
    Text = "[Hindari jalan] Hapus 1 Kartu perintah, dapatkan Arg1 Segil hitam."
  },
  Event_129236_ChoiceDesc2 = {
    Text = "[Tanya mengapa tenggelam] Salin 1 Kartu perintah, infeksi [(Skill.Arg1)]"
  },
  Event_129236_ChoiceDesc3 = {
    Text = "[Sapa Kru] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)] dua kali"
  },
  Event_129236_Desc = {
    Text = [[
Saat berjalan menuju Ruang Kekuatan, kamu kembali menemui beberapa "Memori"yang terperangkap di dalam Domain.
Mereka bukan hantu, hanya rasa rindu Kapten Elton terhadap para awak kapal yang telah tiada.]]
  },
  Event_129236_Name = {
    Text = "Pemilik Sonanir"
  },
  Event_129237_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129237_Name = {
    Text = "Lupakan Bab 3@"
  },
  Event_129238_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129238_Name = {
    Text = "Bab 1 Bintang@"
  },
  Event_129239_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129239_Name = {
    Text = "Lupakan Bab Keenam@"
  },
  Event_129240_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129240_Name = {
    Text = "Lupakan Bab Kelima@"
  },
  Event_129241_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129241_Name = {
    Text = "Bintang Bab 4@"
  },
  Event_129242_ChoiceDesc1 = {
    Text = "[Mainkan Musik Untuknya] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, infeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129242_ChoiceDesc2 = {
    Text = "[Mendengarkan suara piano] Untuk setiap Pembangun dengan nilai Aliemus 50 atau lebih, dapatkan 15 Segil hitam."
  },
  Event_129242_ChoiceDesc3 = {
    Text = "[Pergi] Dapatkan Orison pilih 1 dari 3 sebanyak dua kali"
  },
  Event_129242_Desc = {
    Text = [[
"Dear John:
    Akhir-akhir ini, saya tiba-tiba menyadari bahwa sudah beberapa tahun sejak terakhir kali kamu memainkan piano untuk kami.
    Saya sekarang berusia 81 tahun. Semakin bertambah usia saya, semakin saya menyadari betapa berharganya kenangan di masa muda.
    Jika kamu menerima surat ini, lain kali saat kamu melewati Londinium, tolong berhenti di apartemen saya dan mainkan satu lagu, ya."]]
  },
  Event_129242_Name = {
    Text = "Sonata Kesedihan"
  },
  Event_129243_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129243_Name = {
    Text = "Bintang Bab 3@"
  },
  Event_129244_ChoiceDesc1 = {
    Text = "[Mengatakan Tidak Punya Dompet] Dapatkan Orison pilih 1 dari 3 sebanyak dua kali"
  },
  Event_129244_ChoiceDesc2 = {
    Text = "[Merobek Jaring] 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\" sebanyak dua kali, terinfeksi \"(Skill.Arg2)\" sebanyak dua kali"
  },
  Event_129244_Desc = {
    Text = [[
Jaring berwarna oranye-kuning melayang tenang di udara, lubang-lubangnya jarang, jauh dari keindahan jaring yang ditempati sepupu laba-laba di akar dinding. 
 Kamu tak tahan untuk menyentuhnya, jaring rapuh itu langsung larut, dan tawa anak-anak terdengar di telingamu. 
 "Emas, perak, kuning, merah, semua dompet adalah milik kita!"]]
  },
  Event_129244_Name = {
    Text = "Jaringan Wandering"
  },
  Event_129245_ChoiceDesc1 = {
    Text = "[Pilih Perasaan]memulihkan Arg1 poin Hidup"
  },
  Event_129245_ChoiceDesc2 = {
    Text = "[Pertahankan Akal Sehat] 1 Kartu perintah acak mendapatkan Orison: [(EnchantConfig.Arg1)] dua kali"
  },
  Event_129245_ChoiceDesc3 = {
    Text = "[Tolak Pilihan]mendapatkan 25 Segil hitam"
  },
  Event_129245_Desc = {
    Text = [[
"Pilihlah, pilihlah."
Di tengah kegelapan yang berlari, terdengar banyak bisikan.
Suara ini lembut dan hipnotis, seolah memiliki kekuatan tanpa batas, membuatmu merasakan semacam ilusi kegilaan.
Otakmu terjebak dalam kebingungan, bergerak menjauh dari tubuh, sementara jantungmu tampaknya memiliki kesadaran tertentu, memanggilmu dengan terjerit.
"Pilihlah, pilihlah."
"Pertahankan rasionalitas atau emosional, kau harus membuat pilihan."]]
  },
  Event_129245_Name = {
    Text = "Bayaran Kemanusiaan"
  },
  Event_129246_ChoiceDesc1 = {
    Text = "[Menghilangkan Korban] Mendapatkan Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129246_ChoiceDesc2 = {
    Text = "[Lepaskan Tali] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)] dua kali"
  },
  Event_129246_ChoiceDesc3 = {
    Text = "[Lanjutkan Maju] Dapatkan 50 Segil Hitam"
  },
  Event_129246_Desc = {
    Text = [[
Tiga orang Aram terikat di atas panggung tinggi.
Di tubuh mereka muncul pola garis gelap seperti kulit pohon yang pernah kau lihat pada bayi, sementara mereka mengucapkan kata-kata tanpa henti.]]
  },
  Event_129246_Name = {
    Text = "tiga persembahan"
  },
  Event_129247_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129247_Name = {
    Text = "Bintang Bab 3@"
  },
  Event_129248_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129248_Name = {
    Text = "Lupakan Bab Keenam@"
  },
  Event_129249_ChoiceDesc1 = {
    Text = "[Merangkak Maju] Hapus 1 Kartu Perintah, dapatkan Arg1 Segil Hitam"
  },
  Event_129249_ChoiceDesc2 = {
    Text = "[Menghancurkan benang] Salin 1 Kartu perintah, infeksi [(Skill.Arg1)]"
  },
  Event_129249_ChoiceDesc3 = {
    Text = "[Tahan Diri] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)] dua kali"
  },
  Event_129249_Desc = {
    Text = [[
Sepanjang jalan, kamu terdorong untuk maju. Semua pilihanmu dikendalikan oleh benang tak terlihat. 
 Kamu berusaha menggerakkan kedua tanganmu, ingin meraih segala sesuatu yang kau hargai. 
 Nasib dunia tergantung pada ujung jarimu. 
 Jalinan tanpa akhir melilit seluruh tubuhmu.]]
  },
  Event_129249_Name = {
    Text = "Tangan yang Dimanipulasi"
  },
  Event_129250_ChoiceDesc1 = {
    Text = "[Bertanya Jalan padanya] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129250_ChoiceDesc2 = {
    Text = "[Meninggalkannya] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129250_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_129250_Desc = {
    Text = "Bayangan berdiri di bawah lampu jalan yang ramping. \n\"Boleh pinjam api, Tuan.\"\nKamu tidak punya kebiasaan @2, tapi kamu tidak keberatan menggunakan sedikit \"sihir\". \nDengan bantuanmu, Bayangan akan menyalakan @2 dan memasukkannya ke dalam pusaran hitam yang tak terlihat dasarnya. \nTak lama kemudian, kamu melihat asap putih mengepul keluar. \n\"Ah——\"\nBayangan menghela napas dengan puas."
  },
  Event_129250_Name = {
    Text = "Bayangan di bawah lampu jalan"
  },
  Event_129251_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129251_Name = {
    Text = "Lupakan Bab 1@"
  },
  Event_129252_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129252_Name = {
    Text = "Lupakan Bab 8@"
  },
  Event_129253_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129253_Name = {
    Text = "Lupakan Bab 3@"
  },
  Event_129254_ChoiceDesc1 = {
    Text = "[Menerima Bayangan] 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129254_ChoiceDesc2 = {
    Text = "[Menolak Bayangan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)] dua kali"
  },
  Event_129254_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_129254_Desc = {
    Text = [[
Di bawah jembatan besi yang berat dan gelap, di tepi sungai yang sunyi yang ditumbuhi alang-alang, tiba-tiba terbang seekor kupu-kupu yang berkilau. 
 Kupu-kupu itu ringan hinggap di telapak tanganmu, suara jeritan yang mengerikan terhenti, digantikan oleh suara gemuruh kereta yang melintasi rangka besi yang berkarat, suara letupan bara batubara yang terbakar, dan suara gesekan logam dari poros yang berputar......]]
  },
  Event_129254_Name = {
    Text = "Fatamorgana Rel"
  },
  Event_129255_ChoiceDesc1 = {
    Text = "[Pilih Tolak]menghapus 1 kartu perintah, mendapatkan Arg1 Segil hitam"
  },
  Event_129255_ChoiceDesc2 = {
    Text = "[Pilih Taat]menggandakan 1 kartu perintah, terinfeksi[(Skill.Arg1)]"
  },
  Event_129255_ChoiceDesc3 = {
    Text = "[Memilih untuk Memeluk] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)] dua kali"
  },
  Event_129255_Desc = {
    Text = [[
"Aku adalah burung dalam sangkar, terkurung di halaman penuh dengan banyak kamar."
Bayangan kabur berkeliaran dalam kegelapan, itu adalah obsesi yang ditinggalkan oleh yang telah pergi.
"Mereka bilang, itu adalah rumah sakit jiwa, tapi aku tahu, itu adalah penjara khusus bagi manusia, menahan burung yang tidak mau mengikuti aturan sosial."
"Tapi jika burung tidak bisa terbang, apakah masih bisa disebut burung?"
Obsesi-obsesi berkumpul mendekat kepadamu, meminta penebusan.
"Tolong patahkan sayapku, aku sudah lelah terbang."]]
  },
  Event_129255_Name = {
    Text = "Orang Kosong"
  },
  Event_129256_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129256_Name = {
    Text = "Lupa Bab 2@"
  },
  Event_129257_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129257_Name = {
    Text = "Bab 2 Bintang@"
  },
  Event_129258_ChoiceDesc1 = {
    Text = "[Lepaskan Kupu-Kupu] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, infeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129258_ChoiceDesc2 = {
    Text = "[Menjadi Kupu-Kupu] Mendapatkan Relik Perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129258_ChoiceDesc3 = {
    Text = "[Menelan kembali ke perut] Mendapatkan 25 Segil Hitam"
  },
  Event_129258_Desc = {
    Text = "Malam ini terjadi terlalu banyak hal. \n Serangan di dermaga, kapal hantu, Pelaut, Tulu, Murphy, Ramona... Segala sesuatu berputar dalam Vortex, diaduk menjadi oatmeal di restoran Mythag pada pukul tujuh pagi. \n Ingin bertanya kepada Awakener di depan mata, namun sama sekali tidak tahu bagaimana memulainya, seperti tercekik—atau bisa dibilang, kupu-kupu di perut."
  },
  Event_129258_Name = {
    Text = "Efek kupu-kupu"
  },
  Event_129259_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129259_Name = {
    Text = "Lupakan Bab 8@"
  },
  Event_129260_ChoiceDesc1 = {
    Text = "[Biarkan Tinggal] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129260_ChoiceDesc2 = {
    Text = "[Mengibaskan tangan untuk mengusir] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129260_ChoiceDesc3 = {
    Text = "[Menyambut Kupu-kupu] Mendapatkan 25 Segil hitam"
  },
  Event_129260_Desc = {
    Text = [[
Kalian berkeliling di sanatorium yang dingin dan berangin, seekor kupu-kupu hitam yang seharusnya tidak ada di musim ini datang dengan anggun. 
 Sayap kupu-kupu yang bergerak naik turun membawa cairan hitam kental, terbang dengan goyangan tidak stabil, lapisan demi lapisan cairan hitam menetes dari sayapnya, mengering dan terkikis oleh angin setelah mengeras. 
 Ia kelelahan dan hinggap di ujung jarimu.]]
  },
  Event_129260_Name = {
    Text = "Sesuatu yang tidak seharusnya ada"
  },
  Event_129261_ChoiceDesc1 = {
    Text = "[Kenang masa lalu] Dapatkan pilih 1 dari 3 Orison tingkat lanjut sebanyak dua kali"
  },
  Event_129261_ChoiceDesc2 = {
    Text = "[Mengintip Masa Depan] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129261_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_129261_Desc = {
    Text = [[
Tidak ada yang abadi dan tak berubah di dunia ini.
Bahkan taman surga yang dibentuk oleh Sang Ibu Dewa pun demikian.
Dalam sekejap yang singkat, kamu melihat sekilas sesuatu dari celah ruang-waktu.
Masa lalu, masa kini, masa depan terjalin dalam celah yang penuh retakan itu, terus berubah.
Menunggu tatapan penasaranmu.]]
  },
  Event_129261_Name = {
    Text = "Celah Ruang-Waktu"
  },
  Event_129262_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129262_Name = {
    Text = "Lupakan Bab 7@"
  },
  Event_129263_ChoiceDesc1 = {
    Text = "[Mengabaikannya] Dapatkan Orison pilih 1 dari 3 sebanyak dua kali"
  },
  Event_129263_ChoiceDesc2 = {
    Text = "[Menyentuhnya] 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129263_Desc = {
    Text = [[
Sesuatu yang aneh mirip spora menarik perhatianmu.
Ia seperti ubur-ubur tipis yang terbuat dari daging, dan seperti serat saraf yang menyimpan sinyal di dalam otak.
"Datang dan sentuh saya." Ia menggoda tanpa suara, "Saya akan, menunjukkan kepada Anda sebuah kenangan yang kejam."]]
  },
  Event_129263_Name = {
    Text = "Memori Dalam"
  },
  Event_129264_ChoiceDesc1 = {
    Text = "[Tenggelam dalam Fantasi] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129264_ChoiceDesc2 = {
    Text = "[Pertahankan Kewarasan] Setiap ada satu Pembangun dengan nilai Aliemus 50 atau lebih, dapatkan 15 Segil hitam."
  },
  Event_129264_ChoiceDesc3 = {
    Text = "[Pergi dengan Paksa] Dapatkan Orison pilih 1 dari 3 sebanyak dua kali"
  },
  Event_129264_Desc = {
    Text = [[
Mungkin pertempuran yang berkepanjangan membuatmu linglung, atau mungkin otakmu mengkhianati tubuhmu.
Semacam perasaan tanpa bobot muncul di benakmu.
Dalam sekejap, pikiranmu tiba-tiba berubah menjadi kaleidoskop, gemerlap, berwarna-warni, berkilauan dengan cahaya beraneka warna.
Inspirasi, misteri, dan khayalan liar yang tak terhitung jumlahnya memenuhi otakmu, mengisi setiap sudut lekukan otakmu.
Jika terus begini, otakmu akan segera meledak oleh semua hal yang kacau balau ini.]]
  },
  Event_129264_Name = {
    Text = "Kaleidoskop Pikiran"
  },
  Event_129265_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129265_Name = {
    Text = "Lupakan Bab Kelima@"
  },
  Event_129266_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129266_Name = {
    Text = "Lupakan Bab Keempat@"
  },
  Event_129267_ChoiceDesc1 = {
    Text = "[Dengarkan] Dapatkan Orison tingkat lanjut pilih 1 dari 3 sebanyak dua kali"
  },
  Event_129267_ChoiceDesc2 = {
    Text = "[Teriakan] Memperoleh Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129267_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_129267_Desc = {
    Text = [[
Sejak kecelakaan itu terjadi, kamu tidak pernah menerima kabar dari rekanmu. 
 Tak terhitung banyaknya kontak yang dikirim, seperti batu yang jatuh ke laut tanpa gema. 
 Pada saat kamu sudah putus harapan, alat komunikasi tiba-tiba mengeluarkan suara. 
 Kamu membuka kotak dan mendekatkan gagang telepon ke telinga. 
 "Penjaga..." 
 Dalam keadaan samar, kamu mendengar suara yang selalu kamu rindukan, seperti gema yang jauh di balik lapisan kosong.]]
  },
  Event_129267_Name = {
    Text = "Gema Kerinduan"
  },
  Event_129268_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129268_Name = {
    Text = "Lupakan Bab 1@"
  },
  Event_129269_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129269_Name = {
    Text = "Bab 1 Bintang@"
  },
  Event_129270_ChoiceDesc1 = {
    Text = "[Mendapatkan Anjing Neraka dari Sumber] Mendapatkan Relik Emas \"(RelicConfig.Arg1)\", Terinfeksi \"(Skill.Arg2)\""
  },
  Event_129270_ChoiceDesc2 = {
    Text = "[Fokus Bertarung] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)] dua kali"
  },
  Event_129270_Desc = {
    Text = [[
Garis besar anjing neraka berubah.
Tubuhnya terhubung dengan celah dinding, mengungkapkan ilusi yang aneh.]]
  },
  Event_129270_Name = {Text = "dari sudut"},
  Event_129271_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129271_Name = {
    Text = "Lupa Bab 2@"
  },
  Event_129272_ChoiceDesc1 = {
    Text = "[Menggabungkan kertas] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129272_ChoiceDesc2 = {
    Text = "[Membaca] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)] dua kali"
  },
  Event_129272_ChoiceDesc3 = {
    Text = "[Buang Itu]Mendapatkan 50 Segil Hitam"
  },
  Event_129272_Desc = {
    Text = "Selembar kertas yang menguning jatuh dari jubah Penerang cahaya kuil. \n Di atas kertas itu tertulis rapat teks aneh, beberapa terlihat seperti simbol piktograf, beberapa anehnya mengarah ke atas, dan beberapa huruf bahkan saling tumpang tindih, hanya sedikit kata yang dapat dibaca dengan susah payah. \n Judulnya adalah 《@2 Kelahiran Anak Suci》"
  },
  Event_129272_Name = {
    Text = "Kode Rahasia·Bawah"
  },
  Event_129273_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129273_Name = {
    Text = "Lupa Bab 2@"
  },
  Event_129274_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129274_Name = {
    Text = "Bab 2 Bintang@"
  },
  Event_129275_ChoiceDesc1 = {
    Text = "[Bersiap untuk Bertarung] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129275_ChoiceDesc2 = {
    Text = "[Mencoba jalan memutar] Mendapatkan 25 Segil Hitam"
  },
  Event_129275_Desc = {
    Text = [[
Di kedalaman laut tempat cahaya bintang jatuh, para Pengarung Laut telah bersembunyi selama ribuan tahun. 
Perairan tak bertepi menyaksikan kegilaan mereka, menyaksikan kesabaran mereka, dan juga menyaksikan keimanan mereka yang paling taat kepada dewa. 
Tidak ada yang bisa menghalangi kedatangan agung sang dewa. 
Siapa pun yang menghalangi akan menjadi abu dalam murka para Pengarung Laut.]]
  },
  Event_129275_Name = {
    Text = "Menunggu di Bawah Bintang-Bintang"
  },
  Event_129276_ChoiceDesc1 = {
    Text = "[Mendapatkan beberapa nada] Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129276_ChoiceDesc2 = {
    Text = "[Menutup Tutupnya] Dapatkan Orison pilih 1 dari 3 sebanyak dua kali"
  },
  Event_129276_Desc = {
    Text = [[
Piano di samping dinding terbuka tutupnya. Piano tersebut memiliki tuts-tuts yang menguning serta tepi-tepi retak yang menampakkan warna kayu, namun setiap tutsnya telah dibersihkan dengan sangat bersih. 
 Piano itu adalah sumber kebahagiaan bagi banyak orang.]]
  },
  Event_129276_Name = {
    Text = "Melodi Masa Kecil"
  },
  Event_129277_ChoiceDesc1 = {
    Text = "[Menerima Bayangan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129277_ChoiceDesc2 = {
    Text = "[Menyangkal Fatamorgana] mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129277_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_129277_Desc = {
    Text = [[
Di bawah jembatan besi yang berat dan gelap, di tepi sungai yang sunyi yang ditumbuhi alang-alang, tiba-tiba terbang seekor kupu-kupu yang berkilau. 
 Kupu-kupu itu ringan hinggap di telapak tanganmu, suara jeritan yang mengerikan terhenti, digantikan oleh suara teratur pekerja yang mengangkut besi beton, suara palu paku yang diketuk, dan suara logam yang nyaring dari benturan paku rivet......]]
  },
  Event_129277_Name = {
    Text = "Fatamorgana Jembatan Baja"
  },
  Event_129278_ChoiceDesc1 = {
    Text = "[Menampilkan kutukan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\" dua kali, terinfeksi \"(Skill.Arg2)\" dua kali"
  },
  Event_129278_ChoiceDesc2 = {
    Text = "[Menolak Gagak] Dapatkan Orison pilih 1 dari 3 sebanyak dua kali"
  },
  Event_129278_ChoiceDesc3 = {
    Text = "[Mengabaikan]"
  },
  Event_129278_Desc = {
    Text = [[
Burung gagak berkepala banyak yang gelap dan sakit terbang keluar dari jubah hitam seorang penganut Penerang Cahaya Kuil, lalu hinggap di pundakmu. 
"Lihat kepalaku? Setiap kali aku merasakan kutukan, aku akan tumbuh kepala baru. Ayo, tunjukkan padaku! Kutukanmu!"]]
  },
  Event_129278_Name = {
    Text = "Burung Gagak Terkutuk"
  },
  Event_129279_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129279_Name = {
    Text = "Lupakan Bab 7@"
  },
  Event_129280_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129280_Name = {
    Text = "Lupakan Bab 3@"
  },
  Event_129281_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129281_Name = {
    Text = "Lupakan Bab Keempat@"
  },
  Event_129282_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129282_Name = {
    Text = "Lupa Bab 2@"
  },
  Event_129283_ChoiceDesc1 = {
    Text = "[Teks sementara]."
  },
  Event_129283_Name = {
    Text = "Bab 2 Bintang@"
  },
  Event_129900_ChoiceDesc1 = {
    Text = "[Pemakaman] Pulihkan Arg2 poin hidup [ExDesc1], pilih 1 Kartu perintah untuk dihapus."
  },
  Event_129900_ChoiceDesc2 = {
    Text = "[Doa] mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_129900_Desc = {
    Text = "Sebuah tulang belulang pucat, setengahnya terendam dalam D-lendir hitam pekat."
  },
  Event_129900_Name = {
    Text = "Tulang Luntur"
  },
  Event_130337_ChoiceDesc1 = {
    Text = "[Duduk]Masukkan [Boneka Tali] ke dalam dek."
  },
  Event_130337_Desc = {
    Text = "Saat kakimu melangkah menaiki tangga teater, pandanganmu tak lagi bisa teralihkan dari panggung ini.\nBenang takdir menarik kisah-kisah tak terhitung banyaknya untuk mengalir di sini—debu masa lalu, cahaya dan bayangan saat ini, kabut masa depan, semuanya bergejolak tanpa henti di depan panggung.\nKau melupakan dari mana asalmu, ke mana tujuanmu. Jejak tentang \"diri sendiri\" melebur habis dalam bayangan tirai. Saat ini, kau adalah penonton yang terdiam di kursi, sekaligus aktor yang membara di atas panggung.\nSeluruh makna keberadaanmu, runtuh menjadi dua goresan: memandang, dan mempersembahkan."
  },
  Event_130337_Name = {
    Text = "Panggung Takdir"
  },
  Event_131264_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_131264_Desc = {
    Text = "Kalian memilih kekuatan, memilih keyakinan yang teguh dan keberanian untuk terus maju.\nNamun, harga yang harus dibayar… bukankah makna dari sebuah harga memang untuk ditanggung?"
  },
  Event_131264_Name = {
    Text = "Tatapan Masa Lalu"
  },
  Event_131265_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_131265_Desc = {
    Text = [[
Kau menahan rasa sakit yang menghujam pikiranmu, menggenggam erat kenangan-kenangan yang tercerai dan hancur. Dengan ketahananmu yang luar biasa, retakan-retakan itu mulai tersambung kembali.
Kau pergi demi mengingat, kau bertarung demi mengingat. Kau tak akan membiarkan kenangan apa pun meninggalkanmu.]]
  },
  Event_131265_Name = {
    Text = "Kenangan yang Hancur"
  },
  Event_131266_ChoiceDesc1 = {
    Text = "[Lindungi Kenangan]Dapatkan Terpesona pilih 1 dari 3"
  },
  Event_131266_ChoiceDesc2 = {
    Text = "[Hentikan Retakan]Pilih 1 dari 3 kartu perintah untuk mendapatkan Terpesona: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_131266_Desc = {
    Text = [[
Kau tak pernah meragukan kenanganmu. Mereka hangat, kokoh, pelabuhan paling andal dan harta paling berharga bagimu.
Namun kini, di bawah gangguan jurang kegelapan, retakan-retakan kacau mulai muncul dalam kenangan itu.]]
  },
  Event_131266_Name = {
    Text = "Kenangan yang Hancur"
  },
  Event_131267_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_131267_Desc = {
    Text = [[
Kekuatan spiritual membanjiri pikiranmu, menambal celah-celah yang mengerikan itu. Dengan seluruh tenagamu, akhirnya retakan-retakan itu kembali utuh.
Kau pergi demi mengingat, kau bertarung demi mengingat. Kau tak akan membiarkan kenangan apa pun meninggalkanmu.]]
  },
  Event_131267_Name = {
    Text = "Kenangan yang Hancur"
  },
  Event_131268_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_131268_Desc = {
    Text = "\"Huhuhuhu… Hahahaha!!\"\nTak seorang pun memahami pertanyaanmu, mereka menjawab dengan tangisan dan tawa mengilukan."
  },
  Event_131268_Name = {
    Text = "Yang Terbuang"
  },
  Event_131269_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_131269_Desc = {
    Text = [[
Kalian membalas tatapan mereka. Benang-benang bergetar, tatapan lembut memeluk kenangan ke dalam dekapan.
Kau menatap sang pengendali takdir dalam diam. Jika ada kesempatan kedua, pilihan apa yang akan dia ambil?]]
  },
  Event_131269_Name = {
    Text = "Tatapan Masa Lalu"
  },
  Event_131270_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_131270_Desc = {
    Text = "\"Huhuhuhu… Hahahaha!!\"\nTangisan dan tawa mengilukan perlahan menghilang di hadapanmu. Tak ada arwah yang datang menyakitimu — mereka sudah lama terbiasa diabaikan."
  },
  Event_131270_Name = {
    Text = "Yang Terbuang"
  },
  Event_131271_ChoiceDesc1 = {
    Text = "[Menatap Kenangan]Dapatkan artefak emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_131271_ChoiceDesc2 = {
    Text = "[Melupakan Kenangan]Kebangkitan acak 2 Awakened, terinfeksi dua kali [(Skill.Arg1)]"
  },
  Event_131271_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_131271_Desc = {
    Text = "Di dalam tubuh gadis itu, kau mendengar suara guci yang pecah. Kenangan meninggalkan wadahnya, datang menghampiri kalian.\nTeman bermain masa kecil, hadiah dari orang tua, imajinasi paling murni tentang awan putih dan burung-burung terbang, cita-cita seputih langit… Semua kenangan membuka mata, menatap kalian dalam diam.\nMereka bertanya. Mereka menangis. Mereka menunggu."
  },
  Event_131271_Name = {
    Text = "Tatapan Masa Lalu"
  },
  Event_131272_ChoiceDesc1 = {
    Text = "[Bertanya] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_131272_ChoiceDesc2 = {
    Text = "[Mengabaikan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_131272_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_131272_Desc = {
    Text = "Jeritan tajam bergema di telingamu, arwah-arwah yang tersiksa mencabik-cabik wajah dan tubuh mereka sendiri di hadapanmu…\nSiapakah mereka? Tahanan jurang kegelapan? Takdir yang terbuang? Kenangan yang terkubur?"
  },
  Event_131272_Name = {
    Text = "Yang Terbuang"
  },
  Event_133380_ChoiceDesc1 = {Text = "[OK]"},
  Event_133380_Desc = {
    Text = [[
Kau duduk di kursi beludru yang menjadi milikmu, tirai merah menyala perlahan tersibak.
Penonton yang terhormat, panggung akan menjawab harapanmu.
Pemeran utama pertunjukan ini, telah berdiri di atas panggung.]]
  },
  Event_133380_Name = {
    Text = "Panggung Takdir"
  },
  Event_141995_ChoiceDesc1 = {
    Text = "[Percobaan Sederhana] Hapus hingga 5 Kartu apa pun"
  },
  Event_141995_ChoiceDesc2 = {
    Text = "[Biarkan Ia Meneliti] Hapus secara acak 5 Kartu perintah, dapatkan Relic Diberkati [(RelicConfig.Arg1)]."
  },
  Event_141995_ChoiceDesc3 = {
    Text = "[Berpikir Terbalik?] Pilih hingga dua Tubuh Terjaga, hasilkan satu set lengkap Kartu dasar mereka dan masukkan ke dalam dek"
  },
  Event_141995_Desc = {
    Text = [[
Kamu tiba di sebuah alun-alun, banyak orang berlalu-lalang dengan tergesa-gesa, mungkin ada sesuatu yang menarik yang bisa ditemukan di sini.
Kamu mengetuk pintu sebuah ruangan yang diterangi cahaya redup kekuningan, seorang yang berpenampilan seperti Peneliti mengintip keluar. Kamu melihat banyak peralatan ilmiah yang tidak dikenal, ia menarikmu untuk duduk, mengaku dirinya sebagai seorang "ilmuwan evolusi". Wajahnya penuh Kegilaan, dengan antusias merekomendasikan "metode ilmiahnya" kepadamu.
"Hanya dengan menghapus hal-hal berlebihan yang membosankan dari manusia, itulah Jalan evolusi sejati!"]]
  },
  Event_141995_Name = {
    Text = "Ilmuwan Evolusi"
  },
  Event_141996_ChoiceDesc1 = {
    Text = "[Latihan Khusus untuk Serangan] Tambahkan Orison acak pada semua Serangan Dasar yang tidak memiliki Orison"
  },
  Event_141996_ChoiceDesc2 = {
    Text = "[Latihan Khusus untuk Pertahanan] Tambahkan Orison acak pada semua Pertahanan Dasar yang tidak memiliki Orison"
  },
  Event_141996_ChoiceDesc3 = {
    Text = "[Latihan Tanpa Henti] Tambahkan Orison acak pada 15 Kartu perintah acak, dapatkan 5 Kartu gejala acak"
  },
  Event_141996_Desc = {
    Text = [[
Kamu tiba di sebuah alun-alun, banyak orang berlalu-lalang dengan tergesa-gesa, mungkin bisa menemukan sesuatu yang menarik di sini.
Suara dentingan logam bergema di lapangan terbuka, beberapa orang sedang saling beradu di sini, meningkatkan kemampuan bela diri mereka, seorang pemuda berpakaian baju besi kuno memperhatikanmu, melemparkan sebuah pedang ke arahmu, mengundangmu untuk berlatih bersama mereka.]]
  },
  Event_141996_Name = {
    Text = "Waktu Latihan Khusus"
  },
  Event_141997_ChoiceDesc1 = {
    Text = "[Taruh besar] 50% kesempatan mendapatkan Orison acak dan Taruh ulang, 50% kesempatan mendapatkan 75 Segil hitam"
  },
  Event_141997_ChoiceDesc2 = {
    Text = "[Taruh kecil] 50% kesempatan mendapatkan Orison acak dan Taruh ulang, 50% kesempatan mendapatkan 75 Segil hitam"
  },
  Event_141997_Desc = {
    Text = "Pelayan mempertahankan senyumnya yang tak berubah, mengangkat penutup dadu, suara nyaring bergema, pemain lain satu per satu membuat pilihan mereka. \"Taruhan ditutup,\" katanya, \"silakan Taruh—\""
  },
  Event_141997_Name = {
    Text = "Kasino Ramai"
  },
  Event_141998_ChoiceDesc1 = {
    Text = "[Taruhan jujur] Hapus satu Kartu perintah"
  },
  Event_141998_ChoiceDesc2 = {
    Text = "[Coba curang] Hapus satu Kartu gejala"
  },
  Event_141998_ChoiceDesc3 = {Text = "[Keluar]"},
  Event_141998_Desc = {
    Text = [[
Kamu tiba di tempat yang sangat ramai, setiap wajah memancarkan kebahagiaan, lampu warna-warni yang berkelip sesuka hati memenuhi malam tanpa tersisa ruang. Di mana-mana terpampang papan bertuliskan: "Selamat datang di Karnaval! Di sini Mimpi tak pernah berakhir, di sini Kesukacitaan tak pernah Tirai ditutup!"
Terbawa arus kerumunan yang padat, kamu terdorong masuk ke sebuah bangunan megah, aula di dalamnya gemerlap keemasan, riuh rendah suara manusia, udara dipenuhi aroma manis minuman keras. Sebuah dadu menggelinding tepat ke kakimu, pelayan dengan senyum menjilat memberitahumu bahwa ini adalah pertanda keberuntungan. Dengan rasa penasaran, kamu melangkah maju selangkah, mungkin, kamu bisa menunjukkan kemampuanmu dalam permainan ini.]]
  },
  Event_141998_Name = {
    Text = "Kasino Ramai"
  },
  Event_141999_ChoiceDesc1 = {
    Text = "[Barter] Hapus 1 Relic, Probabilitas 50% mendapatkan pilihan 3 Relik emas, Probabilitas 50% mendapatkan 25 Segil hitam"
  },
  Event_141999_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_141999_Desc = {
    Text = [[
Kamu tiba di tempat yang sangat ramai, setiap orang memancarkan kebahagiaan di wajahnya, lampu warna-warni yang berkelip-kelip dengan bebas memenuhi malam hingga tak ada ruang tersisa. Di mana-mana terdapat papan bertuliskan: "Selamat datang di Karnaval! Di sini mimpi tidak pernah berakhir, di sini kesukacitaan tidak pernah tirai ditutup!"
Di tengah kerumunan, seorang Pedagang berpakaian compang-camping namun membawa bungkusan yang luar biasa besar melambaikan tangan kepadamu. Ia menepuk bungkusannya, mendekat dan berbisik pelan, mengajukan Undangan Barter kepadamu. Kantong kain usang itu bergoyang pelan mengikuti suaranya, sesekali mengeluarkan bunyi krak-krak.]]
  },
  Event_141999_Name = {
    Text = "Pedagang Compang-camping"
  },
  Event_142000_ChoiceDesc1 = {
    Text = "[Coba Membuat Permohonan] Habiskan 50% HP saat ini, dapatkan 2 Relik emas acak"
  },
  Event_142000_ChoiceDesc2 = {
    Text = "[Berdoa Sepenuh Hati] Habiskan 99% HP saat ini, dapatkan Pendulum waktu [(RelicConfig.Arg2)]"
  },
  Event_142000_ChoiceDesc3 = {
    Text = "[Merogoh Dasar Kolam] Dapatkan Relik emas [(RelicConfig.Arg1)]"
  },
  Event_142000_Desc = {
    Text = "Angin berhembus melewati padang, sekeliling sunyi senyap, hanya terdengar gemerisik pepohonan.\nTiba-tiba, kamu mendengar suara sesuatu yang mengalir gemericik, kamu mengikuti suara itu, bau amis manis yang pekat lebih dulu menyergapmu, dan akhirnya kamu melihat jelas sumber suara aliran itu — sebuah kolam harapan, penuh dengan warna merah, Darah dari banyak orang sedang Surge di dalam kolam, Seolah-olah ada sesuatu di bawah permukaan cairan yang akan melompat keluar.\nSebuah suara bergema di lubuk hatimu: \"Persembahkan Darahmu, dan aku akan memberikanmu berkah.\""
  },
  Event_142000_Name = {
    Text = "Mata Air Darah"
  },
  Event_142001_ChoiceDesc1 = {
    Text = "[Memberi Nafkah Sederhana] Pilih untuk menghapus 2 Relic, dapatkan Ciptaan Berdosa [(RelicConfig.Arg1)]"
  },
  Event_142001_ChoiceDesc2 = {
    Text = "[Memberi Nafkah dengan Kesetiaan] Pilih untuk menghapus 4 Relic, dapatkan Relic Diberkati [(RelicConfig.Arg1)]"
  },
  Event_142001_ChoiceDesc3 = {
    Text = "[Ambil sedikit persembahan, tidak ada yang tahu] Dapatkan Relik emas [(RelicConfig.Arg1)]"
  },
  Event_142001_Desc = {
    Text = "Angin berhembus melewati padang, sekeliling sunyi senyap, hanya terdengar gemerisik pepohonan.\nTanpa disadari, kamu tiba di depan sebuah altar kuno, patung raksasa menatapmu dari ketinggian dengan Tatapan yang seolah ingin mengambil sesuatu dari tanganmu. Kamu melihat tulisan samar yang terukir tepat di bawah altar — \"Untung Rugi Seimbang\"."
  },
  Event_142001_Name = {
    Text = "Altar Untung Rugi"
  },
  Event_142002_ChoiceDesc1 = {
    Text = "[Pengalaman Gratis] Peningkatan Arg2 Relik perak secara acak"
  },
  Event_142002_ChoiceDesc2 = {
    Text = "[Layanan Biasa] Habiskan Arg1 Segil hitam: Peningkatan Arg2 Relik perak secara acak"
  },
  Event_142002_ChoiceDesc3 = {
    Text = "[Layanan Mewah] Habiskan Arg1 Segil hitam: Peningkatan Arg2 Relik perak secara acak"
  },
  Event_142002_Desc = {
    Text = [[
Kamu tiba di sebuah alun-alun, banyak orang berlalu-lalang dengan tergesa-gesa, mungkin ada sesuatu yang menarik yang bisa ditemukan di sini.
Sebuah gedung kecil dengan lampu hangat berdiri tenang di sudut alun-alun, tampaknya sebuah klub Advanced, namun papan nama gelap yang tergantung di dindingnya dengan jelas bertuliskan: "Toko ini hanya melayani keberadaan di luar makhluk hidup."]]
  },
  Event_142002_Name = {
    Text = "Klub Istimewa"
  },
  Event_142003_ChoiceDesc1 = {
    Text = "[Undian sekali] Dapatkan satu Kartu gejala"
  },
  Event_142003_ChoiceDesc2 = {
    Text = "[Pergi] Dapatkan 75 Segil hitam"
  },
  Event_142003_Desc = {
    Text = "Kamu tiba di tempat yang sangat ramai, setiap wajah memancarkan kebahagiaan, lampu warna-warni yang berkelip sesuka hati memenuhi malam tanpa tersisa ruang. Di mana-mana terpampang papan bertuliskan: \"Selamat datang di Karnaval! Di sini Mimpi tak pernah berakhir, di sini Kesukacitaan tak pernah Tirai ditutup!\"\nKamu memperhatikan ada stan undian di pinggir Jalan yang dikerumuni banyak orang, semua Tatapan terfokus pada hadiah utama yang tertutup rapat — Pedagang kaki lima sangat gencar mempromosikan kelangkaannya, orang-orang berebut untuk ikut serta."
  },
  Event_142003_Name = {
    Text = "Tantangan Undian"
  },
  Event_142004_ChoiceDesc1 = {
    Text = "[Pinjam Sebentar]"
  },
  Event_142004_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_142004_Desc = {
    Text = [[
Angin berhembus melewati padang, suasana sunyi senyap di sekitar, hanya terdengar gemerisik pepohonan.
Tiba-tiba, kamu melihat sebuah gubuk tua yang reyot, di tengahnya terdapat sebuah landasan besi, di sampingnya terdapat banyak senjata logam yang sudah berkarat, tempat ini tampaknya adalah bengkel pandai besi yang sudah lama terbengkalai. Di samping landasan besi terdapat petunjuk penggunaan yang terperinci, memberitahumu bahwa kamu dapat menaruh Relic di sini untuk dimodifikasi.]]
  },
  Event_142004_Name = {
    Text = "Bengkel Pandai Besi"
  },
  Event_142005_ChoiceDesc1 = {
    Text = "[Taruhan jujur] Hapus satu Kartu perintah"
  },
  Event_142005_ChoiceDesc2 = {
    Text = "[Coba curang] Hapus satu Kartu gejala"
  },
  Event_142005_ChoiceDesc3 = {Text = "[Keluar]"},
  Event_142005_Desc = {
    Text = "Cheer dari orang-orang di sekitar mengumumkan kemenanganmu, di tengah keramaian suara manusia, akhirnya kamu pun sama seperti mereka, terhanyut dalam Mimpi aneh nan memukau yang mempertaruhkan segalanya. Kamu menatap chip di tanganmu, Seolah-olah mereka adalah sahabat paling setia yang membawa kemuliaanmu, Bisikan datang dari kedalaman meja judi, membawa serta permintaan yang ambigu: \"Lakukan lagi, menang sekali lagi.\""
  },
  Event_142005_Name = {
    Text = "Kasino Ramai"
  },
  Event_142013_ChoiceDesc1 = {
    Text = "[Taruh besar] 50% kesempatan mendapatkan Relik perak acak dan Taruh ulang, 50% kesempatan mendapatkan 75 Segil hitam dan memasuki pertarungan Elite"
  },
  Event_142013_ChoiceDesc2 = {
    Text = "[Taruh kecil] 50% kesempatan mendapatkan Relik perak acak dan Taruh ulang, 50% kesempatan mendapatkan 75 Segil hitam dan memasuki pertarungan Elite"
  },
  Event_142013_Desc = {
    Text = "Pelayan mempertahankan senyumnya yang tak berubah, mengangkat penutup dadu, suara nyaring bergema, pemain lain satu per satu membuat pilihan mereka. \"Taruhan ditutup,\" katanya, \"silakan Taruh—\""
  },
  Event_142013_Name = {
    Text = "Kasino Ramai"
  },
  Event_142073_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142073_Desc = {
    Text = "Pelayan mengangkat penutup dadu, beberapa detik singkat, udara Seolah-olah membeku dalam Stagnasi. Saat jawaban terungkap, kamu mendengar sorak sorai dan ratapan bercampur jadi satu. Keberuntungan tidak Berkat kamu, beberapa dadu yang tergeletak diam di atas meja memberikan jawaban yang berlawanan denganmu. Kamu menyapu pandangan terakhir, melihat para penjudi yang penuh Kegilaan itu. Sudah waktunya pergi."
  },
  Event_142073_Name = {
    Text = "Kasino Ramai"
  },
  Event_142074_ChoiceDesc1 = {
    Text = "[Teks Sementara]Masuk ke Pertempuran"
  },
  Event_142074_Desc = {
    Text = "Saat kamu menatap meja judi dengan penuh harap, tanganmu tiba-tiba dicengkeram erat, mendongak ke atas, Bos kasino sedang memandang ke bawah, bersiap mengusir semua tamu yang tidak mematuhi aturan. Seketika, semua Tatapan terfokus padamu seorang, ada yang terkejut, ada yang penuh permusuhan, ada yang schadenfreude... Kamu menyadari, seseorang mungkin bisa curang berkali-kali, tetapi Asalkan ketahuan sekali saja, maka kehancuran total pun tak terelakkan."
  },
  Event_142074_Name = {
    Text = "Kasino Ramai"
  },
  Event_142103_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142103_Desc = {
    Text = "Kamu berhasil meloloskan diri dari kasino dengan cara fisik, kebisingan kerumunan kamu tinggalkan di belakang, kamu mempercepat langkah pergi — adapun kekacauan yang tertinggal, pasti akan ada yang membereskannya."
  },
  Event_142103_Name = {
    Text = "Kasino Ramai"
  },
  Event_142105_ChoiceDesc1 = {
    Text = "[Undian sekali lagi] Dapatkan satu Kartu gejala"
  },
  Event_142105_ChoiceDesc2 = {
    Text = "[Pergi] Dapatkan 75 Segil hitam"
  },
  Event_142105_Desc = {
    Text = [[
Kamu mencoba mengundi sekali, tidak ada yang terjadi. Tapi di balik kartu tertulis: "Berikutnya lebih mudah"
... Mau coba sekali lagi?]]
  },
  Event_142105_Name = {
    Text = "Tantangan Undian"
  },
  Event_142106_ChoiceDesc1 = {
    Text = "[Undian sekali lagi] Dapatkan satu Kartu gejala"
  },
  Event_142106_ChoiceDesc2 = {
    Text = "[Pergi] Dapatkan 75 Segil hitam"
  },
  Event_142106_Desc = {
    Text = [[
Kamu mencoba mengundi sekali, tidak ada yang terjadi. Tapi di balik kartu tertulis: "Berikutnya lebih mudah"
... Mau coba sekali lagi?]]
  },
  Event_142106_Name = {
    Text = "Tantangan Undian"
  },
  Event_142107_ChoiceDesc1 = {
    Text = "[Undian sekali lagi] Dapatkan satu Kartu gejala"
  },
  Event_142107_Desc = {
    Text = [[
Kamu mencoba mengundi sekali, tidak ada yang terjadi. Tapi di balik kartu tertulis: "Berikutnya lebih mudah"
... Mau coba sekali lagi?]]
  },
  Event_142107_Name = {
    Text = "Tantangan Undian"
  },
  Event_142108_ChoiceDesc1 = {
    Text = "[Undian sekali lagi] Dapatkan satu Kartu gejala"
  },
  Event_142108_ChoiceDesc2 = {
    Text = "[Pergi] Dapatkan 75 Segil hitam"
  },
  Event_142108_Desc = {
    Text = [[
Kamu mencoba mengundi sekali, tidak ada yang terjadi. Tapi di balik kartu tertulis: "Berikutnya lebih mudah"
... Mau coba sekali lagi?]]
  },
  Event_142108_Name = {
    Text = "Tantangan Undian"
  },
  Event_142109_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142109_Desc = {
    Text = [[
Mendengarkan suara detak jantung, kamu membuka tiket undian, huruf-huruf emas yang menyilaukan melompat ke matamu. Pedagang kaki lima dengan gembira menggoyang-goyangkan lonceng, semua orang yang lewat melemparkan tatapan iri kepadamu.
"Hadiah utama telah dimenangkan!"]]
  },
  Event_142109_Name = {
    Text = "Tantangan Undian"
  },
  Event_142110_ChoiceDesc1 = {
    Text = "[Undian sekali lagi] Dapatkan satu Kartu gejala"
  },
  Event_142110_ChoiceDesc2 = {
    Text = "[Pergi] Dapatkan 75 Segil hitam"
  },
  Event_142110_Desc = {
    Text = [[
Kamu mencoba mengundi sekali, tidak ada yang terjadi. Tapi di balik kartu tertulis: "Berikutnya lebih mudah"
... Mau coba sekali lagi?]]
  },
  Event_142110_Name = {
    Text = "Tantangan Undian"
  },
  Event_142118_ChoiceDesc1 = {
    Text = "[Barter] Hapus 1 Relic, Probabilitas 25% mendapatkan pilihan 3 Pendulum waktu, Probabilitas 50% mendapatkan 2 Relik emas acak, Probabilitas 25% mendapatkan 25 Segil hitam"
  },
  Event_142118_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_142118_Desc = {
    Text = [[
Pedagang menerima barang yang kamu berikan, membolak-baliknya di bawah cahaya bulan, matanya hampir melotot keluar. Kamu menunggu cukup lama, baru kemudian ia menyeringai, mengeluarkan kotak besi berkarat dari dalam tasnya. "Ayo buka dan lihat, ini adalah blind box yang paling populer saat ini."
Kamu membukanya, namun menemukan di dalamnya hanya ada sedikit Cap Hitam yang mengecewakan. Pedagang menggosok-gosokkan tangannya, dengan penuh penyesalan di matanya menyatakan bahwa kamu bisa mencoba sekali lagi.]]
  },
  Event_142118_Name = {
    Text = "Pedagang Compang-camping"
  },
  Event_142119_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142119_Desc = {
    Text = [[
Pedagang menerima barang yang kamu berikan, membolak-baliknya di bawah cahaya bulan, matanya hampir melotot keluar. Kamu menunggu cukup lama, baru kemudian ia menyeringai, mengeluarkan kotak besi berkarat dari dalam tasnya. "Ayo buka dan lihat, ini adalah blind box yang paling populer saat ini."
Kamu membukanya, di dalamnya terdapat sesuatu.]]
  },
  Event_142119_Name = {
    Text = "Pedagang Compang-camping"
  },
  Event_142120_ChoiceDesc1 = {
    Text = "[Barter] Hapus 1 Relik emas, Probabilitas 50% mendapatkan pilihan 3 Pendulum waktu, Probabilitas 50% mendapatkan pilihan 3 Relic Diberkati"
  },
  Event_142120_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_142120_Desc = {
    Text = [[
Kamu membuka blind box sekali lagi, namun tetap tidak menemukan barang yang kamu inginkan. Pedagang segera tersenyum meminta maaf, lalu mengeluarkan kotak besi lainnya, mengangkatnya dengan kedua tangan dan menyodorkannya ke hadapanmu.
"Jangan marah, tuan! Aku bersumpah, kali ini pasti ada barang luar biasa......" begitu katanya, namun diam-diam ia menggeser satu tangannya, membuka telapak tangan ke arahmu, "Tentu saja, harta karun harus ditukar dengan harta karun."]]
  },
  Event_142120_Name = {
    Text = "Pedagang Compang-camping"
  },
  Event_142138_ChoiceDesc1 = {
    Text = "[Pinjam Sebentar]"
  },
  Event_142138_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_142138_Desc = {
    Text = "Kamu berhasil menggunakan peralatan ini, meskipun ada kerusakan, tampaknya masih bisa digunakan."
  },
  Event_142138_Name = {
    Text = "Bengkel Pandai Besi"
  },
  Event_142139_ChoiceDesc1 = {
    Text = "[Pecah Tuang] Pilih 1 Relik emas untuk dihapus, dapatkan 2 Relik perak, dapatkan 50 Segil hitam"
  },
  Event_142139_ChoiceDesc2 = {
    Text = "[Tempa] Pilih 2 Relic untuk dihapus, dapatkan Relik emas [(RelicConfig.Arg1)]."
  },
  Event_142139_ChoiceDesc3 = {
    Text = "[Tempa Tingkat Lanjut] Pilih 2 Relik emas untuk dihapus, dapatkan Pendulum waktu [(RelicConfig.Arg1)]."
  },
  Event_142139_Desc = {
    Text = "Kamu mengambil palu di sampingnya, bermaksud untuk......"
  },
  Event_142139_Name = {
    Text = "Bengkel Pandai Besi"
  },
  Event_142140_ChoiceDesc1 = {
    Text = "[Pinjam Sebentar]"
  },
  Event_142140_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_142140_Desc = {
    Text = "Kamu berhasil menggunakan peralatan ini, meskipun ada kerusakan, tampaknya masih bisa digunakan."
  },
  Event_142140_Name = {
    Text = "Bengkel Pandai Besi"
  },
  Event_142141_ChoiceDesc1 = {
    Text = "[Pecah Tuang] Pilih 1 Relik emas untuk dihapus, dapatkan 2 Relik perak, dapatkan 50 Segil hitam"
  },
  Event_142141_ChoiceDesc2 = {
    Text = "[Tempa] Pilih 2 Relic untuk dihapus, dapatkan Relik emas [(RelicConfig.Arg1)]."
  },
  Event_142141_ChoiceDesc3 = {
    Text = "[Tempa Tingkat Lanjut] Pilih 2 Relik emas untuk dihapus, dapatkan Pendulum waktu [(RelicConfig.Arg1)]."
  },
  Event_142141_Desc = {
    Text = "Kamu mengambil palu di sampingnya, bermaksud untuk......"
  },
  Event_142141_Name = {
    Text = "Bengkel Pandai Besi"
  },
  Event_142142_ChoiceDesc1 = {
    Text = "[Pecah Tuang] Pilih 1 Relik emas untuk dihapus, dapatkan 2 Relik perak, dapatkan 50 Segil hitam"
  },
  Event_142142_ChoiceDesc2 = {
    Text = "[Tempa] Pilih 2 Relic untuk dihapus, dapatkan Relik emas [(RelicConfig.Arg1)]."
  },
  Event_142142_ChoiceDesc3 = {
    Text = "[Tempa Tingkat Lanjut] Pilih 2 Relik emas untuk dihapus, dapatkan Pendulum waktu [(RelicConfig.Arg1)]."
  },
  Event_142142_Desc = {
    Text = "Kamu mengambil palu di sampingnya, bermaksud untuk......"
  },
  Event_142142_Name = {
    Text = "Bengkel Pandai Besi"
  },
  Event_142167_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142167_Desc = {
    Text = "Setelah tiga kali penggunaan, landasan besi benar-benar amblas, palu pun penuh dengan keausan, tampaknya sudah tidak bisa digunakan lagi."
  },
  Event_142167_Name = {
    Text = "Bengkel Pandai Besi"
  },
  Event_142235_ChoiceDesc1 = {
    Text = "[Aku Akan Melangkah Teguh ke Depan] Dapatkan \"Murni\": Semua Kartu perintah mendapatkan penguatan permanen 20 tumpukan"
  },
  Event_142235_ChoiceDesc2 = {
    Text = "[Aku Tidak Akan Melarikan Diri] Dapatkan \"Sublimasi\": Batas Kunci Perak, Batas Aliemus berkurang permanen sebesar 20%"
  },
  Event_142235_Desc = {
    Text = [[
Pandanganmu tiba-tiba diselimuti kabut, dunia mulai terasa kabur dan tidak jelas, dalam keadaan setengah sadar, sebuah suara bergema di lubuk hatimu:
"Apakah kamu masih ingin melanjutkan?"]]
  },
  Event_142235_Name = {
    Text = "Stasiun Akhir Semakin Dekat"
  },
  Event_142925_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142925_Desc = {
    Text = "Staf klub menerima pembayaran dan memberikanmu layanan dasar. Mereka membawa barang yang kamu serahkan ke dalam sebuah bilik gelap, waktu Menunggu tidak lama, ketika ia muncul kembali, barang itu sudah diletakkan kembali di atas nampan, tampaknya sedikit berbeda dari sebelumnya."
  },
  Event_142925_Name = {
    Text = "Klub Istimewa"
  },
  Event_142926_ChoiceDesc1 = {
    Text = "[Hapus satu Relik emas] (Membutuhkan Relik emas)"
  },
  Event_142926_ChoiceDesc2 = {
    Text = "[Tersedia Relic dengan Enhance (Forged)]"
  },
  Event_142926_ChoiceDesc3 = {Text = "[Keluar]"},
  Event_142926_Desc = {
    Text = "Uji \"Jumlah Relic\" \"Pilih Daftar Relic\""
  },
  Event_142927_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142927_Desc = {
    Text = "Staf klub menerima pembayaran dan memberikanmu layanan mewah. Mereka dengan khidmat meletakkan barangmu ke dalam sebuah kotak, lalu membawanya ke dalam bilik gelap. Kamu menunggu cukup lama, hingga ia muncul kembali, menyerahkan barang itu dengan kedua tangan, raut wajahnya tetap tenang seperti biasa."
  },
  Event_142927_Name = {
    Text = "Klub Istimewa"
  },
  Event_142928_ChoiceDesc1 = {
    Text = "[Pilih maksimal 2 Tubuh Terjaga untuk memenuhi Aliemus]"
  },
  Event_142928_ChoiceDesc2 = {
    Text = "[Harus memilih 2 Tubuh Terjaga yang penuh Aliemus]"
  },
  Event_142928_ChoiceDesc3 = {Text = "[Keluar]"},
  Event_142928_Desc = {
    Text = "Uji \"Pilih Tubuh Terjaga berdasarkan kondisi\""
  },
  Event_142929_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142929_Desc = {
    Text = "Peneliti berputar-putar mengelilingimu berkali-kali, mengamatimu dengan seksama dalam waktu lama, baru kemudian mulai bekerja — ia tidak meminta pendapatmu. Setelah beberapa waktu berlalu, ketika kamu bersiap meninggalkan laboratorium aneh ini, kamu sadar bahwa kamu memang telah kehilangan banyak hal, namun ia malah bertepuk tangan merayakanmu: \"Inilah hakikat sejati evolusi!\""
  },
  Event_142929_Name = {
    Text = "Ilmuwan Evolusi"
  },
  Event_142930_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142930_Desc = {
    Text = "Kamu mengulurkan tangan, menjangkau ke dalam air kolam yang merah darah, dan meraba sesuatu yang berguna."
  },
  Event_142930_Name = {
    Text = "Mata Air Darah"
  },
  Event_142931_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142931_Desc = {
    Text = "Suara itu menjauh, hatimu dipenuhi tekad, merasakan Strength yang bangkit."
  },
  Event_142931_Name = {
    Text = "Stasiun Akhir Semakin Dekat"
  },
  Event_142932_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142932_Desc = {
    Text = "Suara itu menjauh, hatimu dipenuhi tekad, pikiran semakin jernih."
  },
  Event_142932_Name = {
    Text = "Stasiun Akhir Semakin Dekat"
  },
  Event_142933_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142933_Desc = {
    Text = "Kamu mengambil sedikit dari tumpukan persembahan yang menggunung, lalu segera pergi dengan cepat. Saat kamu meninggalkan tempat itu, Mata patung itu seolah-olah bergerak sejenak."
  },
  Event_142933_Name = {
    Text = "Altar Untung Rugi"
  },
  Event_142934_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142934_Desc = {
    Text = "Kamu berlatih dengan fokus pada pertahanan, terus-menerus menangkis serangan lawan menggunakan senjata saat menghadapi Ambush mereka. Kemampuan Pertahanan dan reaksimu pun meningkat."
  },
  Event_142934_Name = {
    Text = "Waktu Latihan Khusus"
  },
  Event_142935_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142935_Desc = {
    Text = "Peneliti memakai sarung tangan, mengambil beberapa peralatan berbentuk aneh dari lemari, lalu memperagakannya di hadapanmu. Kamu tidak tahu apa yang sebenarnya ia lakukan, namun kamu sepertinya memang merasa sedikit lebih ringan."
  },
  Event_142935_Name = {
    Text = "Ilmuwan Evolusi"
  },
  Event_142936_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142936_Desc = {
    Text = "Kamu tidak memilih arah yang spesifik, melainkan berlatih tanding tanpa mempedulikan batas kemampuan tubuhmu, hingga Semua orang kelelahan. Kamu tahu dirimu telah banyak berkembang, namun begitu pula, kamu telah membayar harganya."
  },
  Event_142936_Name = {
    Text = "Waktu Latihan Khusus"
  },
  Event_142937_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142937_Desc = {
    Text = "Kamu mengambil beberapa barang dari tasmu secara sembarangan untuk dipersembahkan, dan mendapatkan imbalan yang setara."
  },
  Event_142937_Name = {
    Text = "Altar Untung Rugi"
  },
  Event_142938_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142938_Desc = {
    Text = "Kamu mempersembahkan beberapa barang berharga, dan mendapatkan imbalan yang setara."
  },
  Event_142938_Name = {
    Text = "Altar Untung Rugi"
  },
  Event_142939_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142939_Desc = {
    Text = [[
Kamu penuh Merasakan keraguan terhadap metode penelitiannya, setelah berdebat panjang, ia setuju membiarkanmu menggunakan peralatan ini sendiri, memilih cara lain untuk mengejar "evolusi".
Peralatan yang sama, namun kamu secara tidak sengaja membuat hal-hal yang seharusnya "dihapus" malah "berkembang biak" dalam jumlah besar. Sebelum pergi, kamu mendengar jeritan pilu sang Peneliti.]]
  },
  Event_142939_Name = {
    Text = "Ilmuwan Evolusi"
  },
  Event_142940_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142940_Desc = {
    Text = "Pekerja klub memberikanmu layanan gratis, mereka membawa barang yang kamu serahkan ke dalam sebuah bilik gelap, sesaat kemudian ia kembali, meletakkan barang itu kembali ke tanganmu tanpa sepatah kata pun."
  },
  Event_142940_Name = {
    Text = "Klub Istimewa"
  },
  Event_142941_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142941_Desc = {
    Text = "Kamu mempersembahkan banyak darah ke kolam harapan, dan hadiah berharga pun muncul dari dalam kolam."
  },
  Event_142941_Name = {
    Text = "Mata Air Darah"
  },
  Event_142942_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142942_Desc = {
    Text = "Kamu menjalani latihan yang berfokus pada serangan, di tengah benturan baja, teknik dan kecepatan pukulanmu pun meningkat."
  },
  Event_142942_Name = {
    Text = "Waktu Latihan Khusus"
  },
  Event_142943_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_142943_Desc = {
    Text = "Kamu mempersembahkan sedikit darah ke kolam harapan, dan hadiah pun muncul dari dalam kolam."
  },
  Event_142943_Name = {
    Text = "Mata Air Darah"
  },
  Event_142944_ChoiceDesc1 = {
    Text = "[Pilih Peningkatan Relic]"
  },
  Event_142944_ChoiceDesc2 = {
    Text = "[Peningkatan Relic Acak]"
  },
  Event_142944_ChoiceDesc3 = {
    Text = "[Keluar (Tes)]"
  },
  Event_142944_Desc = {
    Text = "Uji \"Fungsi Peningkatan Relic\", Relic menambah sendiri"
  },
  Event_146258_ChoiceDesc1 = {
    Text = "[Memanggilnya] Dapatkan Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_146258_ChoiceDesc2 = {
    Text = "[Merespons Mereka] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_146258_ChoiceDesc3 = {
    Text = "[Mengabaikan mereka] Mendapatkan 50 Segil hitam"
  },
  Event_146258_Desc = {
    Text = [[
Di atas altar, jubah putih Juliette terbenam dalam asap tebal, abu dupa bercampur dengan aroma amis yang manis.
"Pemegang Lampu mengasihi para pendosa di dunia," suaranya tidak keras, namun dengan jelas mengatasi bisik-bisik doa yang memenuhi seluruh aula, "seperti seorang ibu yang penuh kasih mengasihi bayi dalam gendongannya."
Persembahan di atas altar berkilap berminyak dalam cahaya lilin, kepulan asap tipis meliuk naik mengikuti konturnya, mengaburkan wajah-wajah orang-orang di bawah altar.
Castor memandang Pollux menembus asap yang bergoyang itu, ia berdiri di antara para jemaat, menundukkan mata, wajahnya menampilkan kesalehan yang terlatih dan pas takarannya.]]
  },
  Event_146258_Name = {
    Text = "Mimpi Lama III"
  },
  Event_146259_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146259_Desc = {
    Text = [[
Jangan hiraukan, hanyalah raungan angin salju, desahan danau es, atau ratapan puncak-puncak gunung.
Adalah ranting-ranting kering yang telah lapuk, saling bergesekan berbisik.
Mereka senantiasa meratap dengan sendu, untuk setiap pelopor yang pernah terkubur di celah-celah es.]]
  },
  Event_146259_Name = {
    Text = "Aria Danau Beku"
  },
  Event_146260_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146260_Desc = {
    Text = [[
Jika kesetaraan mutlak adalah keadilan, apakah Helot: Catena memiliki kesempatan yang sama denganmu untuk membuat permohonan?
Lalu, apakah kau seharusnya bersikap tenang terhadap tindakannya yang mendahuluimu bahkan mengusir para pesaing?
"Atau berhentilah melamun, cepat terus mendaki!" Terdengar seruan Caraboo di telingamu.]]
  },
  Event_146260_Name = {
    Text = "Keadilan yang Absurd"
  },
  Event_146261_ChoiceDesc1 = {
    Text = "[Gunung Takut Kelaparan]"
  },
  Event_146261_ChoiceDesc2 = {
    Text = "[Gunung Takut Kehilangan]"
  },
  Event_146261_ChoiceDesc3 = {
    Text = "[Gunung Takut Kematian]"
  },
  Event_146261_Desc = {
    Text = [[
Kamu berjalan di tubuh sang gunung.
Gemetaran gunung itu mengungkap rahasianya.
Keserakahan gunung, menentukan ketakutan gunung.]]
  },
  Event_146261_Name = {
    Text = "Rahasia Gunung"
  },
  Event_146262_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146262_Desc = {
    Text = [[
Kamu menikmati bulu yang halus dan lembut itu, kamu terpenjara dalam hasratmu sendiri.
Kamu sangat puas dengan teksturnya.
Apakah yang tersembunyi di balik penampilan itu benar-benar penting?]]
  },
  Event_146262_Name = {
    Text = "Kucing Hitam Mengendap"
  },
  Event_146263_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146263_Desc = {
    Text = [[
Kamu dengan tenang mengambil ujung tali merah itu dan mengikatnya di pergelangan tanganmu.
Pollux melakukan hal yang sama, dan tangan kedua anak itu pun segera terhubung oleh tali merah yang tipis.
Meski area pencarian yang bisa dijangkau dalam waktu yang sama menjadi lebih kecil, kalian memang ditakdirkan untuk hidup dan mati bersama, bukan?
Selebihnya, biarkan takdir yang mengaturnya.]]
  },
  Event_146263_Name = {
    Text = "Mimpi Lama I"
  },
  Event_146264_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146264_Desc = {
    Text = [[
"Tentu saja aku tahu ini sulit, anakku tersayang."
"Tapi dunia tidak pernah mudah bagi siapa pun."
"Suatu hari nanti, kupu-kupu itu akan terbang meninggalkan telapak tanganmu, dan tidak akan pernah terlihat lagi."]]
  },
  Event_146264_Name = {
    Text = "Ilusi Bukan Nyata"
  },
  Event_146265_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146265_Desc = {
    Text = [[
William mengangkat matanya, pandangannya sekilas melewatimu, lalu jatuh pada punggung bukit yang dipenuhi salju di kejauhan.
"Kau tidak melakukan apa pun yang perlu dimintai maaf," katanya dengan sungguh-sungguh, "beberapa pertanyaan adalah milikku sendiri, dan hanya bisa kujawab sendiri."
"Tapi terima kasih atas kepekaan dan wawasanmu."]]
  },
  Event_146265_Name = {
    Text = "Tenggelam dengan Lembut"
  },
  Event_146266_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146266_Desc = {
    Text = [[
Pandangan William berkilat.
Kau membuka mulut, namun tidak mengucapkan apa pun. Diam adalah pilihan terbaik saat ini.
Masih ada keselarasan berharga di antara kalian, jangan rusak itu.]]
  },
  Event_146266_Name = {
    Text = "Tenggelam dengan Lembut"
  },
  Event_146267_ChoiceDesc1 = {
    Text = "[Peroleh] Relik perak [(RelicConfig.Arg1)]"
  },
  Event_146267_Desc = {
    Text = [[
"Kembalikan padaku, kembalikan padaku, itu adalah kekuatanku!"
Gunung itu menangis, gunung itu meraung.
Gunung tidak sanggup menanggungnya, segala yang pernah dimilikinya telah dirampas habis.]]
  },
  Event_146267_Name = {
    Text = "Rahasia Gunung"
  },
  Event_146268_ChoiceDesc1 = {
    Text = "[Terus Keluar] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_146268_ChoiceDesc2 = {
    Text = "[Menunggu saat yang tepat] Dapatkan 1 dari 3 pilihan Orison"
  },
  Event_146268_ChoiceDesc3 = {
    Text = "[Pergi perlahan]"
  },
  Event_146268_Desc = {
    Text = [[
"Kakak, hati-hati, ada gagak yang mengawasi."
Castor yang masih muda menggendong Pollux berjalan cepat, matanya dengan panik menyapu setiap sudut yang mencurigakan, namun tidak menemukan apa pun.
"Di atas."
Seluruh tubuhmu bergidik, kamu mendongak.
Di bayangan sudut atap, seekor gagak duduk diam, matanya yang aneh menghadap ke segala penjuru menatapmu dengan tajam.]]
  },
  Event_146268_Name = {
    Text = "Mimpi Lama II"
  },
  Event_146269_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146269_Desc = {
    Text = [[
Kamu mengingat pesan dari pelatihan, jangan bergantung pada tali pengaman.
Dengan tendangan dan hentakan, kamu berhasil menstabilkan tubuhmu.
Namun ada sesuatu di dalam ransel yang menggelinding menuruni dinding gunung, menjadi titik kecil yang tak terlihat.
Tidak penting lagi, setidaknya kamu masih hidup.]]
  },
  Event_146269_Name = {
    Text = "Jatuh Tanpa Suara"
  },
  Event_146270_ChoiceDesc1 = {
    Text = "[Mendengarkan dengan cermat] Memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_146270_ChoiceDesc2 = {
    Text = "[Tutup telinga] Dapatkan 1 dari 3 Orison"
  },
  Event_146270_Desc = {
    Text = [[
Badai salju menghantam dinding batu, bercampur dengan suara retakan samar yang datang dari kedalaman lapisan es, pecah menjadi serangkaian isak tangis yang terputus-putus.
Kamu berdiri di ketinggian yang sunyi senyap, tiba-tiba mendengar dengan jelas melodi sang gunung.
Ia sendu dan agung, melantunkan dengan rendah sebuah lagu yang hanya milik mereka yang telah tiada.]]
  },
  Event_146270_Name = {
    Text = "Harmoni Alam Ilusi"
  },
  Event_146271_ChoiceDesc1 = {
    Text = "[Itu Suara Bel] Terinfeksi \"(Skill.Arg1)\", 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg2)\""
  },
  Event_146271_ChoiceDesc2 = {
    Text = "[Itu Makanan] Terinfeksi \"(Skill.Arg1)\", 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg2)\""
  },
  Event_146271_ChoiceDesc3 = {
    Text = "[Itu Harapan Anjing] 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\""
  },
  Event_146271_Desc = {
    Text = [[
"Pavlov membunyikan bel, lalu memberi makan anjing. Lama-kelamaan, hanya dengan membunyikan bel, anjing itu akan mengeluarkan air liur."
"Lalu, apa sebenarnya yang membuat anjing itu mengeluarkan air liur?"]]
  },
  Event_146271_Name = {
    Text = "Refleks Pavlov"
  },
  Event_146272_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146272_Desc = {
    Text = [[
Jangan mengingat kembali.
William ada dalam jangkauanmu.
Jangan biarkan rasa sakit menelanmu.
Kamu telah melewatkan banyak hal, tapi masih belum terlambat.]]
  },
  Event_146272_Name = {
    Text = "Datang dari Alam Baka"
  },
  Event_146273_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146273_Desc = {
    Text = [[
"Rapatkan telapak tanganmu."
"Hal-hal indah yang pernah ada, di tanganmu hanya akan tersisa segumpal lumpur hitam."]]
  },
  Event_146273_Name = {
    Text = "Ilusi Bukan Nyata"
  },
  Event_146274_ChoiceDesc1 = {
    Text = "[Kembalikan] Dapatkan 50 Segil hitam"
  },
  Event_146274_ChoiceDesc2 = {
    Text = "[Membelai] Dapatkan 75 Segil hitam, terinfeksi \"(Skill.Arg2)\""
  },
  Event_146274_Desc = {
    Text = [[
"Meong." Seekor kucing hitam bermata hijau melangkah lembut dan menggosokkan tubuhnya ke betismu.
Bersamaan dengan itu, "N" menghilang.]]
  },
  Event_146274_Name = {
    Text = "Kucing Hitam Mengendap"
  },
  Event_146275_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146275_Desc = {
    Text = [[
Kamu tidak bersuara, hanya membiarkan pandangan itu menembus asap, jatuh kembali ke mata Pollux, tidak mau bergeser sedikit pun.
Ia pun tidak menghindar, adik selalu begitu, lebih suka menyembunyikan kekerasan hatinya di tempat paling dalam, daripada menunduk lebih dulu.
Suara nyanyian di dalam aula, aroma abu dupa, kata-kata Juliette tentang belas kasih dan pengorbanan, tiba-tiba semuanya terasa jauh, seolah hanya tersisa kalian berdua, saling memandang menembus aula yang penuh belas kasih palsu ini, menembus rentang waktu yang panjang.]]
  },
  Event_146275_Name = {
    Text = "Mimpi Lama III"
  },
  Event_146276_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146276_Desc = {
    Text = "Saat ini, kamu adalah satu-satunya penjaga dari ingatanmu yang pucat dan panjang.\nWendigo mengulurkan tangannya yang seperti ranting mati, ujung jarinya langsung mengarah ke dadamu, namun di saat terakhir berhasil kamu halau dengan paksa.\nIa terhuyung mundur ke dalam kabut, hanya meninggalkan sepatah kata igauan yang serak —\n\"Cepat atau lambat, dengan sukarela, kamu akan menyerahkan semuanya kepadaku...\""
  },
  Event_146276_Name = {
    Text = "Pemangsa Rakus"
  },
  Event_146277_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146277_Desc = {
    Text = [[
Itu adalah mimpi yang jauh, mimpi yang bernama masa kecil.
Sadarlah. Kamu tidak berada di sana.
Kamu berada di tengah badai salju, dikepung oleh berlapis-lapis Percaya Lentera, sementara ujung pisau Pollux tepat mengarah ke dadamu.]]
  },
  Event_146277_Name = {
    Text = "Mimpi Lama I"
  },
  Event_146278_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146278_Desc = {
    Text = [[
"Aku menerima datangnya kematian."
"Aku rela terkubur dalam perjalanan yang penuh penderitaan."
"Di bawah tebing yang terjal, langit dan bumi menjadi nisanku."]]
  },
  Event_146278_Name = {
    Text = "Pertanda Kematian Mendekat"
  },
  Event_146279_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146279_Desc = {
    Text = [[
Pantulan hanyalah fenomena pemantulan cahaya.
Apa yang dilihat Tinct, kemungkinan besar juga hanya bayangannya sendiri.
Bintang asalnya berada jutaan tahun cahaya jauhnya, bahkan penyimpangan rute terkecil pun akan membuatnya jatuh di galaksi yang berbeda.
Dengan menghibur diri seperti itu, kau tak lagi terpaku pada bayangan di bawah kakimu.]]
  },
  Event_146279_Name = {
    Text = "Bayangan di Dasar Danau"
  },
  Event_146280_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146280_Desc = {
    Text = [[
Berasal dari Bintang-bintang. Berasal dari zaman purba. Berasal dari apa yang belum diketahui manusia, mungkin selamanya tidak akan diketahui.
Jangan meminta jawaban dari Mereka.
Kamu tidak tahu harganya.]]
  },
  Event_146280_Name = {
    Text = "Aria Danau Beku"
  },
  Event_146281_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146281_Desc = {
    Text = [[
Kamu menghentikan langkah, membiarkan alunan musik yang sendu itu memenuhi telingamu.
Suara angin adalah biola, butiran salju adalah tabuhan gendang, gemuruh lapisan es yang retak di kejauhan adalah semacam harmoni yang tertahan lama, dalam dan berat.
Kamu tidak bisa menangkap temanya, namun kamu tahu, di masa lalu maupun masa depan, ia akan terus dimainkan berulang kali untuk para musafir yang tak terhitung jumlahnya yang terkubur di sini.]]
  },
  Event_146281_Name = {
    Text = "Harmoni Alam Ilusi"
  },
  Event_146283_ChoiceDesc1 = {
    Text = "[Memandang ke atas Cahaya Langit] Semua Awakener memulihkan Arg1 Aliemus"
  },
  Event_146283_ChoiceDesc2 = {
    Text = "[Berpijak di Puncak Es] Pilih untuk Awaken 2 Awakener"
  },
  Event_146283_Desc = {
    Text = "Puncak gunung bersinar dalam diam di balik awan dan kabut.\nLembah, dinding batu, badai — apa yang berdiam di sini tidak pernah ada untuk manusia.\nBerada di tengahnya, kamu begitu rapuh."
  },
  Event_146283_Name = {
    Text = "Menyentuh Puncak"
  },
  Event_146284_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146284_Desc = {
    Text = [[
"Tidak, itu bukan salahmu."
"Kamu hanyalah mainan takdir yang telah diputar pegas-nya."]]
  },
  Event_146284_Name = {
    Text = "Tikus Rakus"
  },
  Event_146285_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146285_Desc = {
    Text = "\"Aku mengerti, kamu adalah tipe orang yang pandai merangkum pengalaman objektif. Tapi jangan lupa, terkadang, di balik penampilan yang serupa, sebenarnya tersembunyi kemungkinan-kemungkinan yang berbeda.\" Suara bel itu tertawa dan menjauh."
  },
  Event_146285_Name = {
    Text = "Refleks Pavlov"
  },
  Event_146286_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146286_Desc = {
    Text = [[
Jika kebaikan dan kejahatan mendapat balasannya adalah keadilan, lalu siapa yang menentukan baik dan buruk?
Apakah timbangan Anubis itu?
Jika gravitasi dunia bawah mengikuti prinsip fisika, kau tidak terlalu yakin bahwa jantungmu akan lebih ringan dari bulu itu.]]
  },
  Event_146286_Name = {
    Text = "Keadilan yang Absurd"
  },
  Event_146287_ChoiceDesc1 = {
    Text = "[Bertanya Lebih Lanjut] Dapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_146287_ChoiceDesc2 = {
    Text = "[Diam] Dapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_146287_ChoiceDesc3 = {
    Text = "[Meminta Maaf] Dapatkan 25 Segil hitam"
  },
  Event_146287_Desc = {
    Text = [[
"Kak William, ketika semua orang terkena pengaruh Wendigo, sepertinya kakak yang pertama tersadar. Sebentar lagi kita akan menghadapi gerombolan Wendigo secara langsung, adakah tips yang bisa dibagikan?"
Pandangan William bergerak sedikit, dari sorot matanya kau samar-samar menangkap kebingungan yang tak terduga, kesedihan dan ketenangan.
Seperti terendam dalam air laut yang tembus cahaya, melayang-layang jatuh menuju dasar laut yang gelap.
"Maaf, rasanya aku tidak bisa banyak membantu."]]
  },
  Event_146287_Name = {
    Text = "Tenggelam dengan Lembut"
  },
  Event_146288_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146288_Desc = {
    Text = "\"Tidak berperasaan, sungguh tidak berperasaan.\" Sosok hitam itu menggelengkan kepala sambil muncul, \"Kebenaran mungkin adalah racun yang menusuk tulang. Terkadang, menerima ilusi justru lebih bisa menjaga kebahagiaan saat ini, bukan?\""
  },
  Event_146288_Name = {
    Text = "Kucing Hitam Mengendap"
  },
  Event_146290_ChoiceDesc1 = {
    Text = "[Siapa Pelakunya] Terinfeksi \"(Skill.Arg1)\", 1 Kartu acak mendapatkan Orison: \"(EnchantConfig.Arg2)\""
  },
  Event_146290_ChoiceDesc2 = {
    Text = "[Ini Salahku] Terinfeksi \"(Skill.Arg1)\", 1 Kartu acak mendapatkan Orison: \"(EnchantConfig.Arg2)\""
  },
  Event_146290_ChoiceDesc3 = {
    Text = "[Bayaran Kerakusan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\""
  },
  Event_146290_Desc = {
    Text = [[
"Tikus kecil, merangkak dan merangkak. Selokan, gelap dan panjang. Tiba-tiba mencium aroma keju."
"Tikus kecil, menyeret keju, berlari pulang ke rumah. Kepala berdengung, kepala berdengung."
"Mendorong pintu, mendorong pintu, rumah sunyi senyap."
"Saudara-saudara terbaring di lantai, perut masing-masing berlubang, berlubang."]]
  },
  Event_146290_Name = {
    Text = "Tikus Rakus"
  },
  Event_146291_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146291_Desc = {
    Text = [[
Kamu berjongkok, menghapus air mata di pipinya, tanpa bertanya apakah air mata itu nyata atau palsu.
"Nyata atau palsu," katamu, "tidak perlu lagi membuktikannya kepada siapa pun."
Caraboo membuka mulutnya, namun kata-kata jenaka yang sudah disiapkan untuk mengelak itu akhirnya tidak bisa terucap.
Air matanya tanpa peringatan meluap deras, jatuh menghantam punggung tanganmu.]]
  },
  Event_146291_Name = {
    Text = "Air Mata Buaya"
  },
  Event_146292_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146292_Desc = {
    Text = "\"Lebih baik jangan bertanya. Ada beberapa pertanyaan yang tidak perlu diketahui jawabannya.\""
  },
  Event_146292_Name = {
    Text = "Tikus Rakus"
  },
  Event_146293_ChoiceDesc1 = {
    Text = "[Bersuara Mengingatkan] Dapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_146293_ChoiceDesc2 = {
    Text = "[Terus Mendengarkan] Semua Awakener memulihkan 50 Aliemus, terinfeksi \"(Skill.Arg1)\""
  },
  Event_146293_ChoiceDesc3 = {
    Text = "[Mengangkat Bahu Mengabaikan] Dapatkan 1 Orison pilihan dari 3"
  },
  Event_146293_Desc = {
    Text = [[
Di tanah jatuhnya Naraka hanya ada kegelapan.
Dari lumpur datang melodi yang lembab, seperti sepasang tangan dingin pucat yang membelai pipimu dengan lembut.
Ia bersenandung pelan, "Marilah, datanglah padaku dalam keheningan malam."]]
  },
  Event_146293_Name = {
    Text = "Suara Kerinduan"
  },
  Event_146294_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146294_Desc = {
    Text = "Kamu menundukkan kepala, membiarkan asap itu mengaburkan siluet Pollux, beserta ekspresinya saat ini, semuanya tersembunyi dalam kabut abu-abu putih.\nIni yang paling aman — kamu berkata pada dirimu sendiri, tidak perlu melihat, tidak perlu memikirkan.\nKhotbah Juliette masih mengalir di telingamu, kamu menatap keras kedua tanganmu yang bertumpang, tanpa sepatah kata.\nBaru ketika lonceng upacara berdentang, kamu berani mengangkat mata kembali.\nSementara Pollux senantiasa mempertahankan sikapnya yang saleh.\nMenembus rentang waktu yang panjang dan ilusi, kamu tidak tahu apakah ada sesuatu yang tergelincir pergi pada saat itu."
  },
  Event_146294_Name = {
    Text = "Mimpi Lama III"
  },
  Event_146295_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146295_Desc = {
    Text = "\"Pollux—\" suaramu baru saja keluar dari tenggorokan, langsung kamu telan kembali dengan keras, hanya menyisakan sedikit gema seperti hembusan napas, lenyap di antara asap dupa.\nGelombang suara jemaat yang melantunkan doa di sisimu tidak berhenti, namun beberapa pandangan mata menyapu ke arahmu tanpa terasa.\nPollux tiba-tiba menegang, sekilas kepanikan melintas di matanya, lalu dengan cepat tertutup kembali oleh ekspresi kepatuhan yang telah terlatih itu.\nIa tidak merespons, hanya menundukkan mata, namun ujung jarinya diam-diam mengepal di dalam lengan bajunya — kamu tahu, ia mendengarmu."
  },
  Event_146295_Name = {
    Text = "Mimpi Lama III"
  },
  Event_146297_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146297_Desc = {
    Text = [[
Setidaknya pada saat itu, kau tidak sanggup membiarkan dia diusir dari regu seorang diri.
Masalah yang perlu diselesaikan saat ini, serahkan saja pada dirimu yang sekarang.]]
  },
  Event_146297_Name = {
    Text = "Rencana dalam Rencana"
  },
  Event_146298_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146298_Desc = {
    Text = [[
"Pollux, sebaiknya kita berjalan ke arah yang berbeda. Dengan begitu, kita akan punya peluang lebih besar untuk menemukan batas hutan ini."
"Lalu bagaimana kamu akan menemukanku, Kakak?"
Melalui kabut waktu yang samar, kamu melihat ekspresi kecewanya. Rasa sakit mencengkeram jantungmu. Kamu menarik napas dalam-dalam, lalu menghembuskannya perlahan.
"Kita adalah kembar. Kita bisa membaca detak jantung satu sama lain."
"Kita tidak akan pernah berpisah."]]
  },
  Event_146298_Name = {
    Text = "Mimpi Lama I"
  },
  Event_146299_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146299_Desc = {
    Text = "Ia menghakimi, ia mempertanyakan. Ia menganugerahkan kematian dingin kepada semua penantang yang tak kembali."
  },
  Event_146299_Name = {
    Text = "Penghakiman Garis Salju"
  },
  Event_146300_ChoiceDesc1 = {
    Text = "[Mulai lagi] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_146300_ChoiceDesc2 = {
    Text = "[Ini sangat sulit] Dapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_146300_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_146300_Desc = {
    Text = [[
Cacing mengajarinya kebohongan.
Selain itu, ia tidak pernah belajar cara bertahan hidup.
Namun kebohongan tetaplah kebohongan, mulai dari suatu hari, kamu harus terus hidup tanpa dukungannya.]]
  },
  Event_146300_Name = {
    Text = "Ilusi Bukan Nyata"
  },
  Event_146301_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146301_Desc = {
    Text = "\"Memang, tapi tikus sekecil itu, mana mungkin tahu apa harga dari keserakahannya?\""
  },
  Event_146301_Name = {
    Text = "Tikus Rakus"
  },
  Event_146302_ChoiceDesc1 = {
    Text = "[Ikat tali merah] Hapus 1 Kartu perintah, dapatkan Arg1 Segil hitam"
  },
  Event_146302_ChoiceDesc2 = {
    Text = "[Tolak tali merah] Salin 1 Kartu perintah, terinfeksi \"(Skill.Arg1)\""
  },
  Event_146302_ChoiceDesc3 = {
    Text = "[Kembali ke Realitas] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\""
  },
  Event_146302_Desc = {
    Text = [[
Mimpi pertama. Mimpi di dalam hutan. Dua anak yang belum genap sepuluh tahun, ditinggalkan oleh sang pemimpin di hutan yang gelap dan dalam.
"Setelah malam tiba, binatang-binatang yang tertidur itu akan mulai berburu. Larilah sebelum itu terjadi. Yang berhasil kabur, itulah anak baikku."
Adiknya menggenggam tangannya, mengeluarkan sepotong tali merah.
"Kakak, mari kita ikat tangan kita bersama. Dengan begitu, kita tidak akan terpisah."]]
  },
  Event_146302_Name = {
    Text = "Mimpi Lama I"
  },
  Event_146304_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146304_Desc = {
    Text = [[
Kamu mendengar suara tawa cekikikan.
Gembira, menantang, penuh rasa ingin tahu.
Eksplorasi manusia terhadap alam semesta dengan segenap kemampuan, di mata Mereka tidak lebih dari semut yang memanjat.]]
  },
  Event_146304_Name = {
    Text = "Yang Dipandang dari Atas"
  },
  Event_146306_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146306_Desc = {
    Text = "Ia akan memurnikan. Ia akan mencairkan. Ia menerima semua pendaki yang tak kembali ke dalam dirinya."
  },
  Event_146306_Name = {
    Text = "Penghakiman Garis Salju"
  },
  Event_146307_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146307_Desc = {
    Text = [[
Kamu dan burung gagak itu terjebak dalam kebuntuan.
Sudah jelas, dalam konfrontasi ini, kamu tidak akan bisa menjadi pemenang terakhir.
Dalam pertarungan melawan Juliette, kalian sepertinya tidak akan pernah bisa menang.]]
  },
  Event_146307_Name = {
    Text = "Mimpi Lama II"
  },
  Event_146308_ChoiceDesc1 = {
    Text = "[Siapa yang Melihatku?] Awaken 1 Awakener secara acak, terinfeksi \"(Skill.Arg1)\""
  },
  Event_146308_ChoiceDesc2 = {
    Text = "[Fokus pada Saat Ini] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\""
  },
  Event_146308_Desc = {
    Text = [[
Angin yang membawa es dan salju menderu melewati titik tertinggi yang pernah dijejak manusia.
Kamu mendongak, di ketinggian yang lebih tinggi hanya ada matahari yang tak pernah padam sejak zaman purba.
Namun kamu tahu, di suatu tempat yang lebih tinggi dan lebih jauh, masih ada tak terhitung pasang mata, ada yang terbuka, ada yang terpejam.
Beberapa pasang di antaranya, sedang diam-diam menatap ke bawah memandang seluruh dunia di bawah kakimu.]]
  },
  Event_146308_Name = {
    Text = "Yang Dipandang dari Atas"
  },
  Event_146309_ChoiceDesc1 = {
    Text = "[Aku masih tak rela] Dapatkan Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_146309_ChoiceDesc2 = {
    Text = "[Aku telah Lupakan] 1 Kartu acak mendapatkan Orison: \"(EnchantConfig.Arg1)\""
  },
  Event_146309_Desc = {
    Text = [[
Kamu mencoba menutup modul penyimpan "ingatan" di dalam otakmu.
Di dalam kotak rahasia itu tersimpan semua jawaban yang membentuk dirimu, semua pikiran yang kamu malu untuk ungkapkan, semua lamunan yang tidak ingin kamu perlihatkan kepada siapa pun.
Namun hasrat adalah mantra bawah sadar, obsesi dan mimpi yang tidak bisa kamu lawan.]]
  },
  Event_146309_Name = {
    Text = "Mantra Bawah Sadar"
  },
  Event_146310_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146310_Desc = {
    Text = [[
William mengalihkan pandangannya darimu.
"Kesadaran adalah senjata untuk melawan pengaruh. Dan pengalaman hidup setiap orang menentukan kesadarannya, tidak dapat digantikan, juga tidak dapat diajarkan."
"Yang bisa kukatakan padamu hanyalah, jangan biarkan dirimu ditelan oleh kelemahan."]]
  },
  Event_146310_Name = {
    Text = "Tenggelam dengan Lembut"
  },
  Event_146311_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146311_Desc = {
    Text = "\"Aku mengerti, kamu adalah tipe orang yang ingin menjadi filsuf. Tapi jangan lupa, tidak ada harapan bukan berarti tidak ada penderitaan.\" Suara bel itu tertawa dan menjauh."
  },
  Event_146311_Name = {
    Text = "Refleks Pavlov"
  },
  Event_146312_ChoiceDesc1 = {
    Text = "[Pergi] Infeksi [(Skill.Arg1)], dapatkan 50 Segil Hitam"
  },
  Event_146312_Desc = {
    Text = [[
"Lapar, lapar."
Gunung itu menangis, gunung itu meraung.
Gunung tidak sanggup menanggungnya, perutnya kosong melompong.]]
  },
  Event_146312_Name = {
    Text = "Rahasia Gunung"
  },
  Event_146313_ChoiceDesc1 = {
    Text = "[Menendang Dinding Batu] Hapus 1 Kartu perintah, dan pulihkan HP sebesar Arg1 poin"
  },
  Event_146313_ChoiceDesc2 = {
    Text = "[Memegang Tali Pengaman] Dapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_146313_Desc = {
    Text = [[
Ilusi berwarna-warni bergolak di benakmu.
Awalnya adalah salju bubuk yang mulai longsor.
Lalu tepi salju yang runtuh.
Kamu tidak bisa mencegah dirimu tergelincir, tali pengaman memercikkan bunga api menyilaukan akibat gesekan pada pengaitnya.
Namun di hadapan pegunungan, ia begitu kecil dan rapuh.]]
  },
  Event_146313_Name = {
    Text = "Jatuh Tanpa Suara"
  },
  Event_146314_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146314_Desc = {
    Text = [[
"Datanglah padaku dalam mimpi, biarkan aku bisa menghidupi kembali hidupku."
Gramofon mengeluarkan isak tangis, lalu suara napas itu perlahan memudar dalam kegelapan.
Hanya gema yang tersisa. Hanya gema.]]
  },
  Event_146314_Name = {
    Text = "Suara Kerinduan"
  },
  Event_146315_ChoiceDesc1 = {
    Text = "[Merasa Menyesal] Dapatkan Relik perak \"(RelicConfig.Arg1)\""
  },
  Event_146315_ChoiceDesc2 = {
    Text = "[Semua Ini Adalah Takdir] Dapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_146315_Desc = {
    Text = [[
Kau selalu tahu bahwa perjalanan ini tidak sesederhana yang dibayangkan, dan sebagian besar pendaki dalam regu pendakian ini masing-masing memiliki niat tersembunyi.
Namun ketika kau menatap wajah Caraboo yang tertawa semakin gila dan sombong, masih ada suara pecahan kaca yang meledak di dadamu.
Mungkin ketika Naraka hendak mengusirnya dari regu, kau seharusnya membuat pilihan yang berbeda.]]
  },
  Event_146315_Name = {
    Text = "Rencana dalam Rencana"
  },
  Event_146316_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146316_Desc = {
    Text = [[
Berapa banyak orang yang pernah ditelan di sini?
Kolam kental itu mengulurkan tangan hitam, berusaha menyeretmu ke dunia mereka.
Namun kau hanya terus melangkah, dan mereka seolah tak berniat menahanmu, satu per satu mereka mundur.
Di depan masih ada puncak yang menunggumu.]]
  },
  Event_146316_Name = {
    Text = "Suara Kerinduan"
  },
  Event_146317_ChoiceDesc1 = {
    Text = "[Menyerah] Dapatkan 25 Segil hitam"
  },
  Event_146317_ChoiceDesc2 = {
    Text = "[Membungkuk Memeriksa] Dapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_146317_Desc = {
    Text = [[
Mengikuti arah pandangan Tinct, kau tak tahan untuk menatap dasar danau.
Apa gerangan yang menarik perhatiannya di dalam pantulan itu?
Namun kau tak dapat melihat dengan jelas, di atas permukaan es hanya terpantul samar-samar bayanganmu sendiri.]]
  },
  Event_146317_Name = {
    Text = "Bayangan di Dasar Danau"
  },
  Event_146318_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146318_Desc = {
    Text = [[
Satu-satunya cara melawan pengunyahan adalah dengan melepaskan.
Tidak ada seorang pun yang bisa kehilangan sesuatu yang tidak pernah mereka miliki.
Wendigo memperlihatkan giginya, tenggorokannya mengeluarkan geraman rendah yang tidak rela, selangkah demi selangkah mundur ke dalam kabut.]]
  },
  Event_146318_Name = {
    Text = "Mantra Bawah Sadar"
  },
  Event_146319_ChoiceDesc1 = {
    Text = "[Salju Akan Memurnikanku] Tingkatkan kualitas Orison 1 Kartu secara acak"
  },
  Event_146319_ChoiceDesc2 = {
    Text = "[Salju Akan Mengadiliku] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_146319_Desc = {
    Text = [[
Di depan adalah pendakian terakhir, garis salju yang dingin dan membentang.
Salju putih menyilaukan mata, bahkan kematian pun tampak bersih di sini.]]
  },
  Event_146319_Name = {
    Text = "Penghakiman Garis Salju"
  },
  Event_146320_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146320_Desc = {
    Text = [[
Jangan lewatkan satu pun detail dalam gambaran itu.
Ukirlah semuanya dalam benakmu.
Ukirlah juga kebingungan, kekosongan, dan rasa sakit yang menyertainya di saat itu.
Jangan pernah melupakannya.]]
  },
  Event_146320_Name = {
    Text = "Datang dari Alam Baka"
  },
  Event_146321_ChoiceDesc1 = {
    Text = "[Bertempur bersama] Dapatkan Relik perak \"(RelicConfig.Arg1)\""
  },
  Event_146321_ChoiceDesc2 = {
    Text = "[Menenangkan] Dapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_146321_Desc = {
    Text = [[
Puncak gunung berguncang hebat, seperti makhluk hidup yang sekarat.
Daging pucat berbentuk ruas-ruas menyembur keluar dari lapisan batu yang retak, ruas demi ruas memanjang dan saling melilit, membanting Caraboo dengan keras.
Saat muncul kembali di hadapan kalian, di pipinya sudah mengalir setetes air mata.
Apakah itu air mata kesakitan?
Kamu tidak yakin.
Begitu banyak kebohongan telah keluar dari mulutnya, siapa yang masih mau percaya pada air mata buaya?]]
  },
  Event_146321_Name = {
    Text = "Air Mata Buaya"
  },
  Event_146322_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146322_Desc = {
    Text = [[
Kamu tidak mengejar jawaban, hanya berdiri di sisinya.
"Bangkitlah," katamu, "pertunjukan baru setengah jalan, jangan mundur di tengah jalan."
Caraboo tertegun sejenak, lalu dengan keras mengusap wajahnya.
Ia bangkit dengan sempoyongan, kembali menggenggam senjatanya erat-erat, bahu ke bahu menghadapi mulut raksasa yang kembali menutup itu.
Terlalu banyak kebohongan yang telah diucapkan, bahkan ia sendiri hampir tidak bisa membedakan mana air mata yang nyata dan mana yang palsu.
Namun setidaknya kali ini, tidak ada yang menghitung mana yang benar dan mana yang salah.]]
  },
  Event_146322_Name = {
    Text = "Air Mata Buaya"
  },
  Event_146323_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146323_Desc = {
    Text = "\"Aku mengerti, kamu adalah tipe orang yang pandai menembus penampilan luar. Tapi jangan lupa, pada saat itu dalam kenyataan, makanan hanya ada dalam pengalaman dan imajinasimu.\" Suara bel itu tertawa dan menjauh."
  },
  Event_146323_Name = {
    Text = "Refleks Pavlov"
  },
  Event_146324_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146324_Desc = {
    Text = "Kamu memperlambat dan meringankan langkahmu.\nPerlahan, pelan-pelan, tanpa suara…\nKamu begitu saja menyelinap pergi melewati tikungan berikutnya.\nApakah burung gagak itu akhirnya mengejarmu?\nKamu sudah tidak mengingatnya lagi."
  },
  Event_146324_Name = {
    Text = "Mimpi Lama II"
  },
  Event_146325_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146325_Desc = {
    Text = [[
Melodi itu tiba-tiba berhenti.
Dari lumpur hitam terbuka sepasang mata yang penuh kerinduan.
Mata itu menatapmu dengan basah, berbisik sesuatu yang tak dapat kau pahami.
Lalu perlahan, perlahan menutup.]]
  },
  Event_146325_Name = {
    Text = "Suara Kerinduan"
  },
  Event_146326_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146326_Desc = {
    Text = "Kamu tidak berlama-lama, meninggalkan alunan melodi itu di belakang, langkah kakimu menghancurkan salju yang menumpuk, menimbulkan suara yang lebih tergesa dari suara angin.\nNamun seberapa cepat pun kamu berjalan, alunan musik yang sendu itu tetap mengikutimu dengan keras kepala, tanpa melewatkan satu langkah pun.\nKamu tidak bisa melarikan diri — ia adalah napas dari pegunungan bersalju ini sendiri, dan kamu, hanyalah pendengar kecil yang kebetulan melintas."
  },
  Event_146326_Name = {
    Text = "Harmoni Alam Ilusi"
  },
  Event_146327_ChoiceDesc1 = {
    Text = "[Dengarkan saja] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_146327_ChoiceDesc2 = {
    Text = "[Tidak perlu dipikirkan] Setiap Awakener dengan nilai Aliemus 50 atau lebih, dapatkan 15 Segil hitam"
  },
  Event_146327_ChoiceDesc3 = {
    Text = "[Pergi Paksa] Mendapatkan 1 dari 3 pilihan Orison"
  },
  Event_146327_Desc = {
    Text = [[
Di antara angin terselip suara nyanyian yang jauh.
Nyanyian itu seolah datang dari segala penjuru, atau dari bawah tanah.
Ke mana pun kamu mencarinya, ia bergema di telingamu dengan intensitas yang sama.]]
  },
  Event_146327_Name = {
    Text = "Aria Danau Beku"
  },
  Event_146328_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146328_Desc = {
    Text = [[
"Wahai bintang pertanda kematian, saat ini bukan waktumu untuk bersinar."
"Perjalananku masih belum mencapai tujuan akhirnya."
"Tolong padamkan dirimu sejenak, biarkan langit malam ini kembali tenang."]]
  },
  Event_146328_Name = {
    Text = "Pertanda Kematian Mendekat"
  },
  Event_146329_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146329_Desc = {
    Text = [[
Penyesalan yang tak berguna pun membuncah.
Manusia selalu terpaksa membereskan kekacauan yang ditinggalkan oleh diri mereka di masa lalu.]]
  },
  Event_146329_Name = {
    Text = "Rencana dalam Rencana"
  },
  Event_146330_ChoiceDesc1 = {
    Text = "[Kunyah]Kebangkitan acak 1 Awakened, terinfeksi[(Skill.Arg1)]"
  },
  Event_146330_ChoiceDesc2 = {
    Text = "[Tolak]mendapatkan 3 pilihan  Oriso"
  },
  Event_146330_Desc = {
    Text = "Di kedalaman kabut salju, terbaring sebuah tubuh yang tinggal tulang, tulang rusuk menopang kulit yang kering dan retak, dua tanduk seperti ranting mati di atas kepalanya menembus kabut.\nDari perutnya terdengar bunyi keroncongan yang hampa.\nSaat kamu bertatapan dengannya, dari lekukan mata yang cekung itu bergolak serpihan gambar — itu adalah ingatanmu. Ia telah merasakan cita rasanya.\n\"Belum cukup, belum cukup...\" ia merintih serak, mengulurkan tangan kering ke arahmu, sikapnya bahkan mengandung sedikit permohonan."
  },
  Event_146330_Name = {
    Text = "Pemangsa Rakus"
  },
  Event_146332_ChoiceDesc1 = {
    Text = "[Pemakaman langit] Dapatkan Relik perak \"(RelicConfig.Arg1)\""
  },
  Event_146332_ChoiceDesc2 = {
    Text = "[Mengusir]Dapatkan 75 Cap Hitam, terinfeksi [(Skill.Arg2)]"
  },
  Event_146332_Desc = {
    Text = [[
Burung nasar berjanggut melayang tinggi memanfaatkan arus udara yang naik, mengawasi wilayahnya.
Di antara para pendaki, ini selalu menjadi pertanda buruk.
"Mereka sedang mencari makan. Burung nasar bisa mencium aroma kematian yang mendekat."]]
  },
  Event_146332_Name = {
    Text = "Pertanda Kematian Mendekat"
  },
  Event_146333_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146333_Desc = {
    Text = [[
Percayalah pada kedua kakimu.
Kamu akan menaklukkan puncak tertinggi.]]
  },
  Event_146333_Name = {
    Text = "Menyentuh Puncak"
  },
  Event_146334_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146334_Desc = {
    Text = [[
Saat pikiran yang enggan berpisah itu menyeruak ke benak, kamu menyadari dirimu sudah tidak berdaya untuk melawan, hanya bisa membiarkannya menerobos masuk ke gudang ingatanmu yang telah lama tersegel.
Gigi taring putih pucat menusuk pelipismu, satu per satu gambar dicabut hingga ke akarnya.]]
  },
  Event_146334_Name = {
    Text = "Mantra Bawah Sadar"
  },
  Event_146335_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146335_Desc = {
    Text = [[
Ia membungkuk ke arahmu, ujung hidungnya hampir menyentuh dahinya, ia tenggelam dalam kenikmatan yang mendalam, seolah mencium sepotong gula madu.
Emosi-emosi yang bergolak gelisah itu dijilati hingga bersih.
Ia mundur dengan dengkuran puas, sorot mata yang menggoda berkilat di kedalaman matanya.
Ada bagian yang kosong di dadamu, namun anehnya... terasa jauh lebih ringan.]]
  },
  Event_146335_Name = {
    Text = "Pemangsa Rakus"
  },
  Event_146336_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146336_Desc = {
    Text = "\"Perhatikan langkahmu, setiap langkah harus diinjak dengan kuat,\" suara Naraka bergema di telingamu, \"jangan selalu berharap orang lain yang menolongmu.\""
  },
  Event_146336_Name = {
    Text = "Yang Dipandang dari Atas"
  },
  Event_146337_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146337_Desc = {
    Text = [[
Manusia seharusnya menyentuh langit.
Tujuan bisa membuat orang melupakan bahaya.
Langit luas sedang menunggumu di atas sana.]]
  },
  Event_146337_Name = {
    Text = "Menyentuh Puncak"
  },
  Event_146338_ChoiceDesc1 = {
    Text = "[Mengusir kenangan] Dapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_146338_ChoiceDesc2 = {
    Text = "[Menangkap ilusi] Dapatkan 1 dari 3 pilihan Relik emas, terinfeksi \"(Skill.Arg1)\""
  },
  Event_146338_ChoiceDesc3 = {
    Text = "[Peroleh] Relik perak [(RelicConfig.Arg1)]"
  },
  Event_146338_Desc = {
    Text = [[
Pembunuh William, kini ada tepat di hadapanmu.
Di dalam tenda Aran, di udara yang menjijikkan, wajah William yang pucat pasi, tubuhnya yang melayang, serta Lentera kecil yang dibedah di atas meja, kembali muncul dalam benakmu.]]
  },
  Event_146338_Name = {
    Text = "Datang dari Alam Baka"
  },
  Event_146339_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146339_Desc = {
    Text = [[
Tali pengaman putus seketika.
Kamu jatuh keras ke dalam tumpukan salju, seluruh isi perutmu mengeluarkan peringatan mematikan di tengah rasa sakit yang tumpul.
Membuka mata dengan kepala yang berputar, sepasang tulang belulang tanpa nama menatapmu balik.
Di dalam rongga matanya yang kosong, ada sesuatu yang berkilauan.]]
  },
  Event_146339_Name = {
    Text = "Jatuh Tanpa Suara"
  },
  Event_146340_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146340_Desc = {
    Text = [[
Tidak bisa menghindar lagi.
Kamu menggigit gigi, lalu melesat secepat mungkin, berharap bisa meloloskan diri dari pengawas itu dengan kecepatan.
Burung gagak itu mengeluarkan suara aneh, mengepakkan sayapnya, dan dengan mudah mengikuti di atas kalian, bahkan dengan santai berputar-putar sekali.
Keputusasaan yang dingin meresap ke dalam tubuh melalui tatapannya.
Kalian tidak akan bisa kabur.]]
  },
  Event_146340_Name = {
    Text = "Mimpi Lama II"
  },
  Event_146341_ChoiceDesc1 = {
    Text = "[Kebaikan dan Kejahatan Mendapat Balasannya] 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\""
  },
  Event_146341_ChoiceDesc2 = {
    Text = "[Kesetaraan Mutlak] Tingkatkan Max HP sebesar Arg1 poin, terinfeksi \"(Skill.Arg2)\""
  },
  Event_146341_Desc = {
    Text = "Kau tergantung di dinding tebing, namun tiba-tiba sebuah pertanyaan yang tak relevan muncul di benakmu: apa itu keadilan?"
  },
  Event_146341_Name = {
    Text = "Keadilan yang Absurd"
  },
  Event_146342_ChoiceDesc1 = {
    Text = "[Pergi] Infeksi [(Skill.Arg1)], dapatkan 50 Segil Hitam"
  },
  Event_146342_Desc = {
    Text = [[
"Aku belum boleh mati!"
Gunung itu menangis, gunung itu meraung.
Gunung tidak sanggup menanggungnya, keserakahannya telah merampas kemungkinan hari esok.]]
  },
  Event_146342_Name = {
    Text = "Rahasia Gunung"
  },
  Event_146343_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_146343_Desc = {
    Text = [[
Kau membungkuk, hingga pipimu menyentuh permukaan es.
Dingin yang menusuk tulang meresap dari kulit ke sumsum, kau tak tahan menggigil.
Sesuatu yang sulit dikenali bergerak perlahan di bawah lapisan es yang membeku, apakah itu arus air atau sejenis makhluk hidup?
Apa pun itu, tidak ada hubungannya dengan perjalananmu.]]
  },
  Event_146343_Name = {
    Text = "Bayangan di Dasar Danau"
  },
  Event_148532_ChoiceDesc1 = {
    Text = "[Terima Berkah] Setelah pertarungan dimulai, hasilkan 1 \"Buah Segala Perubahan\" acak dan masukkan ke dalam dek."
  },
  Event_148532_Desc = {
    Text = [[
Hamparan salju yang luas membentang tanpa batas, angin dingin tak mampu membawa sedikit pun suara, sebuah bayangan yang tak jelas asalnya muncul perlahan, mengulurkan sebiji buah yang hangat.
Aroma manis bercampur kabut menyeruak masuk ke dalam hidung sang musafir yang kebas karena dingin. 
Wilayah bersalju ini telah lama direndam oleh kematian, udara dipenuhi bau busuk dan dingin yang menjijikkan, namun hanya buah di telapak tangan ini yang tampak segar dan berair, bagaikan janji menggoda seorang gadis.]]
  },
  Event_148532_Name = {
    Text = "Fatamorgana Atas"
  },
  Event_20778_ChoiceDesc1 = {
    Text = "[Berikan padanya] Semua Pembangun memulihkan Arg1 Aliemus"
  },
  Event_20778_ChoiceDesc2 = {
    Text = "[Butuh Dukungan] Pilih 2 Pembangun untuk Dibangunkan"
  },
  Event_20778_Desc = {
    Text = "\"Ini adalah komunikasi dari Mythag, mendeteksi fluktuasi Indeks gnostik yang tidak normal pada Pembangun, apakah diperlukan bantuan?\""
  },
  Event_20778_Name = {
    Text = "Komunikasi Dukungan"
  },
  Event_20779_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_20779_Desc = {
    Text = "\"Bantuan darurat telah disediakan untuk Anda, silakan ketuk pin dada tiga kali setelah memeriksa untuk mengonfirmasi.\""
  },
  Event_20779_Name = {
    Text = "Komunikasi Dukungan"
  },
  Event_20780_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_20780_Desc = {
    Text = "Fatamorgana dari masa depan yang jauh, menghilang di celah pegunungan Elworth."
  },
  Event_20780_Name = {
    Text = "Fatamorgana Vulkanik"
  },
  Event_20781_ChoiceDesc1 = {
    Text = "[Far-sight Fatamorgana] Semua Pembangun pulih sebesar Arg1 Aliemus"
  },
  Event_20781_ChoiceDesc2 = {
    Text = "[Fatamorgana] Pilih Bangun 2 Pembangun"
  },
  Event_20781_Desc = {
    Text = [[
Jauh di sana tampak kerucut gunung berapi meletus, kabut berbentuk manusia melayang di langit yang dilanda badai.  
Ini adalah Elworth, di mana hanya ada pegunungan salju yang menjulang dan gua-gua batu kapur yang mengalir.  
Apakah kondisi aneh yang berkepanjangan membuatmu kehilangan akal?]]
  },
  Event_20781_Name = {
    Text = "Fatamorgana Vulkanik"
  },
  Event_20782_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_20782_Desc = {
    Text = "Fatamorgana melambai ke arahmu, lalu menghilang. Yang tersisa hanyalah dinginnya salju dan pegunungan yang menjulang."
  },
  Event_20782_Name = {
    Text = "Fatamorgana Vulkanik"
  },
  Event_20783_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_20783_Desc = {
    Text = "\"Roger, kami akan melakukan pengiriman sumber daya dasar, harap periksa.\""
  },
  Event_20783_Name = {
    Text = "Komunikasi Dukungan"
  },
  Event_21398_ChoiceDesc1 = {
    Text = "[Mengambil foto] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_21398_Desc = {
    Text = [[
Mesin dibongkar, kebenaran terungkap. 
 Kehidupan yang penuh gejolak lenyap tanpa jejak, meninggalkan rasa puas karena kebenaran akhirnya terungkap.]]
  },
  Event_21398_Name = {
    Text = "Keterangan saksi mata"
  },
  Event_21399_ChoiceDesc1 = {
    Text = "[Mengambil foto] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_21399_ChoiceDesc2 = {
    Text = "[Periksa Film] Terinfeksi [(Skill.Arg1)], ganti Orison yang diperoleh di opsi 1. Masih bisa digunakan sekali lagi."
  },
  Event_21399_Desc = {
    Text = [[
Rasa ingin tahu mendorongmu untuk mengarahkan pandangan ke Kolam Bayangan. 
 Gambar-gambar itu terendam dalam cairan merah tua, dan orang berdosa yang tubuhnya dipenuhi noda hitam pekat ternyata memiliki wajah yang sama dengan dirimu.]]
  },
  Event_21399_Name = {
    Text = "Keterangan saksi mata"
  },
  Event_21400_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_21400_Desc = {
    Text = [[
Mesin dibongkar, kebenaran terungkap. 
 Kehidupan yang penuh gejolak lenyap tanpa jejak, meninggalkan rasa puas karena kebenaran akhirnya terungkap.]]
  },
  Event_21400_Name = {
    Text = "Keterangan saksi mata"
  },
  Event_21811_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_21811_Desc = {
    Text = [[
"Duapuluh lima tahun... Ya, dia membuatku tertidur selama duapuluh lima tahun."
Gadis itu menjawabmu dengan suram dan lesu. 
Hanya setelah terbangun, para pelayan yang merawatnya sejak kecil, telah sepenuhnya berubah menjadi pelaut seiring bertambahnya usia. 
Tidak ada lagi yang memahami kesedihannya, tidak ada lagi yang peduli dengan rasa sakitnya, membuatnya sendirian di dalam ordo. 
Dia lebih memilih hari sebelum tidurnya, yaitu "saat bintang-bintang selaras".]]
  },
  Event_21811_Name = {
    Text = "Nyawa yang Terkurung"
  },
  Event_22058_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22058_Desc = {
    Text = [[
"Tidak, aku tidak lapar."
Kamu dengan sopan menolak undangan hangat untuk pesta besar ini.
Harga untuk mencuri jiwa, kamu tak pernah mau membayarnya.]]
  },
  Event_22058_Name = {
    Text = "Festin Daging"
  },
  Event_22059_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22059_Desc = {
    Text = [[
Kamu menggigit sembarangan scone yang berdarah. Aroma hati yang diasinkan dengan lada bercampur dengan keharuman adonan panggang, dan kamu mencium bau yang familiar. 
"Untuk mendapatkan kekuatan, diperlukan pengorbanan."
Kamu meneguk tetesan darah terakhir.]]
  },
  Event_22059_Name = {
    Text = "Festin Daging"
  },
  Event_22060_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22060_Desc = {
    Text = [[
Kamu menelan sup putih dan daging cincang dengan tergesa-gesa, lalu menyeka sisa di sudut bibirmu dengan lengan bajumu. 
 Dagingnya lembut, kuahnya harum dan segar, tapi siapa pemiliknya dulu? 
 Hanya puncak dari semua yang telah hilang darimu.]]
  },
  Event_22060_Name = {
    Text = "Festin Daging"
  },
  Event_22061_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22061_Desc = {
    Text = [[
Kamu memeriksa dengan cermat orison kuno yang terukir di angin genta.
Mereka berkelok dengan cara yang tak terbayangkan oleh orang biasa, seolah-olah tidak dimaksudkan untuk dipahami.
Jika tidak dipahami, maka tidak akan terganggu.]]
  },
  Event_22061_Name = {
    Text = "Loyang Angin Berkarat"
  },
  Event_22062_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22062_Desc = {
    Text = [[
"Tidak buruk, kamu sangat berhati-hati."
Dari dalam lonceng angin tiba-tiba terdengar suara yang jauh.
"Kehati-hatian akan memberimu sedikit hadiah kecil, tapi hanya sampai di situ saja."]]
  },
  Event_22062_Name = {
    Text = "Loyang Angin Berkarat"
  },
  Event_22063_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22063_Desc = {
    Text = [[
Kamu mengusap orison kuno yang terukir di lonceng angin. 
Mereka berkelok dengan cara yang tak terbayangkan oleh orang biasa, seolah-olah tidak ingin dipahami. 
Jika tidak dipahami, maka tidak akan terganggu.]]
  },
  Event_22063_Name = {
    Text = "Loyang Angin Berkarat"
  },
  Event_22064_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22064_Desc = {
    Text = "\"Ah, sungguh disayangkan... maka aku hanya bisa melanjutkan solo kesepianku.\" Kamu tidak tahu kapan qin dan tangannya menghilang, tetapi suara qin yang seperti aliran sungai kecil selamanya tinggal di dalam hatimu."
  },
  Event_22064_Name = {
    Text = "Hantu di samping piano"
  },
  Event_22065_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22065_Desc = {
    Text = "\"Ah, bisa memiliki teman seperti ini, sungguh suatu kehormatan!\" Tangan itu menjadi sangat bersemangat, kamu sama sekali tidak bisa mengikuti kecepatannya. Bahkan setelah pertunjukan selesai lama, suara yang membangkitkan semangat itu masih membuat hatimu berdebar-debar."
  },
  Event_22065_Name = {
    Text = "Hantu di samping piano"
  },
  Event_22175_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22175_Desc = {
    Text = [[
Papan spirit dengan percaya diri meluncur, pandanganmu pun mengikuti gerakannya ke sana kemari. 
Namun, setelah baru saja menunjuk dua huruf, Ia tiba-tiba berubah menjadi cairan hitam kental di tengah teriakan mengerikan.]]
  },
  Event_22175_Name = {
    Text = "Papan Ouija"
  },
  Event_22176_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22176_Desc = {
    Text = [[
"Matematika! Matematika!!"
Suara wanita menggertakkan gigi, papan ouija bergerak cepat di antara angka-angka, menghasilkan suara gesekan kayu yang tajam dan menusuk. 
"Pergi dari pandanganku bersama matematikamu!"]]
  },
  Event_22176_Name = {
    Text = "Papan Ouija"
  },
  Event_22177_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22177_Desc = {
    Text = [[
"Tunggu, tunggu!!"
"Tanyakan padaku! Kenapa kamu tidak bertanya!"]]
  },
  Event_22177_Name = {
    Text = "Papan Ouija"
  },
  Event_22178_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22178_Desc = {
    Text = "Tak pernah sebelumnya berdenyut seperti saat ini, namun di sisi lain, lubang di dalam hati sedang terkoyak..."
  },
  Event_22178_Name = {
    Text = "Kutukan Hasrat"
  },
  Event_22179_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22179_Desc = {
    Text = [[
Jiwa dan semangat memenuhi paru-parumu, dalam keheningan, kamu terus mengapung ke atas.
Suara-suara dunia mulai terdengar satu per satu, memainkan simfoni hidup.]]
  },
  Event_22179_Name = {
    Text = "Air dari Masa Lalu"
  },
  Event_22180_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22180_Desc = {
    Text = "Segalanya berjalan seperti biasa, kehancuran datang tepat pada waktunya. Di antara sisa-sisa yang belum habis terbakar, tersembunyi barang berharga, tenggelam dalam bayangan namun tetap berkilauan."
  },
  Event_22180_Name = {
    Text = "Di luar ujung jarum"
  },
  Event_22181_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22181_Desc = {
    Text = "Bertemu, berpisah, dan berlalu begitu saja."
  },
  Event_22181_Name = {
    Text = "Suara Bintang dan Bulan"
  },
  Event_22182_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22182_Desc = {
    Text = "Detak jantung melambat, namun mungkin \"hati nurani\"telah mendapatkan sedikit penghiburan…"
  },
  Event_22182_Name = {
    Text = "Kutukan Hasrat"
  },
  Event_22183_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22183_Desc = {
    Text = "Kamu menutup mata, menikmati momen ilusi dan kebebasan yang langka ini. Perlahan-lahan, kamu merasakan dunia terbentuk dari keheningan, hidup mekar tanpa suara di tengah kesunyian."
  },
  Event_22183_Name = {
    Text = "Air dari Masa Lalu"
  },
  Event_22184_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22184_Desc = {
    Text = "Kamu menghentikan jarum, potongan perak berkilau mengiris telapak tangan yang lembut, kehancuran belum tiba, tetapi bayangan di kakimu ditelan oleh kegelapan malam yang pekat seperti tinta."
  },
  Event_22184_Name = {
    Text = "Di luar ujung jarum"
  },
  Event_22185_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22185_Desc = {
    Text = [[
"Kamu tidak bisa melarikan diri, tidak ada yang bisa menahan kejahatan dari dalam."
Pikiran jahat merobek saraf, mencoba menarikmu ke dalam Jurang. Namun, rasa sakit hanya membuat kesadaranmu terasa lebih jernih daripada sebelumnya.
Pikiran jahat tidak akan memiliki dirimu, kamu hanya akan menjadi dirimu sendiri.]]
  },
  Event_22185_Name = {
    Text = "Pikiran Tanpa Dasar"
  },
  Event_22186_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22186_Desc = {
    Text = [[
"Kenapa tidak?"
Selama kamu merangkul gagasan-gagasan menakutkan itu, semua masalah akan teratasi, dan paradoks yang disebut "etika" tidak akan ada lagi di dunia.]]
  },
  Event_22186_Name = {
    Text = "Pikiran Tanpa Dasar"
  },
  Event_22187_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22187_Desc = {
    Text = "Kilatan cahaya perak melintas di depan mata, angin yang berat membawa serta semua suara."
  },
  Event_22187_Name = {
    Text = "Pikiran Tanpa Dasar"
  },
  Event_22188_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22188_Desc = {
    Text = "Berubah-ubah, dingin menyayat, seakan dekat namun sulit dijangkau."
  },
  Event_22188_Name = {
    Text = "Suara Bintang dan Bulan"
  },
  Event_22189_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22189_Desc = {
    Text = "Mengembang, menyusut, siap meledak saat disentuh."
  },
  Event_22189_Name = {
    Text = "Suara Bintang dan Bulan"
  },
  Event_22190_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22190_Desc = {
    Text = [[
Meskipun sedikit gegabah, tapi mengapa tidak?
Hancurkan semua hambatan dan teruslah berlari menuju garis akhir.
Bahkan jika kamu mengguncang danau pikiran hingga menimbulkan gelombang besar, bahkan jika kamu menjadi Icarus yang mengejar matahari, setidaknya kamu telah mencapai tujuanmu, bukan?]]
  },
  Event_22190_Name = {
    Text = "Labirin Pikiran"
  },
  Event_22191_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22191_Desc = {
    Text = [[
Otakmu adalah sebuah labirin, dan kamu adalah Ariadne-nya.
Di alam semesta ini, tidak ada yang lebih memahami cara keluar dari labirin selain dirimu.
Tidak ada seorang pun.]]
  },
  Event_22191_Name = {
    Text = "Labirin Pikiran"
  },
  Event_22192_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22192_Desc = {
    Text = [[
Dengan penyetelan yang tepat, interval disonan menjadi sedikit lebih lembut. 
Namun, mungkin masih ada sesuatu yang bisa kau lakukan.]]
  },
  Event_22192_Name = {Text = "Disonansi"},
  Event_22193_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22193_Desc = {
    Text = [[
Kamu adalah seorang master musik, namun juga seorang nada buta yang biasa saja. 
 Di bawah kendali pikiranmu, not-not tersebut menjalankan tugas masing-masing, dan kehidupan yang mengalir akhirnya memainkan melodi di Domain.]]
  },
  Event_22193_Name = {Text = "Disonansi"},
  Event_22194_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22194_Desc = {
    Text = "Suaramu tenggelam dalam kesunyian. Suara kesunyian semakin lama semakin keras, semakin nyaring, hingga akhirnya benar-benar hancur, meninggalkan puing-puing di mana-mana."
  },
  Event_22194_Name = {
    Text = "Air dari Masa Lalu"
  },
  Event_22195_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22195_Desc = {
    Text = "Kamu tidak akan mudah tertipu, lalu dengan tegas berbalik badan dan meninggalkan tempat ini."
  },
  Event_22195_Name = {
    Text = "Garis Retak Bergerak"
  },
  Event_22293_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22293_Desc = {
    Text = [[
Saat pena diangkat, kertas surat itu terbakar di dalam Domain, abu berjatuhan perlahan ke tangan.
Ketika sadar kembali, ada sesuatu yang lenyap bersama dengan kertas surat itu.]]
  },
  Event_22293_Name = {
    Text = "Pengakuan sepihak"
  },
  Event_22294_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22294_Desc = {
    Text = "Kertas surat itu menghilang dalam sekejap di Domain, dan kau mendengar kepedulian yang lembut namun penuh kelemahan. \n\"Dalam situasi seperti ini masih bisa memikirkanku, sungguh suatu kehormatan bagiku sebagai seorang guru. \nNamun, terakhir kali aku melangkah di Domain sudah terlalu lama, terlalu lama... Sekarang, aku hanya bisa membantu sejauh ini…\""
  },
  Event_22294_Name = {
    Text = "Pengakuan sepihak"
  },
  Event_22295_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22295_Desc = {
    Text = [[
Kertas surat menghilang di Domain pada saat itu, kamu mendengar teriakan cemas yang mendesak. 
"Penjaga, jika ada sesuatu yang tidak nyaman, tolong pastikan untuk memberitahuku. 
Sebagai rekan, aku akan membantumu sepenuhnya tanpa ragu."]]
  },
  Event_22295_Name = {
    Text = "Pengakuan sepihak"
  },
  Event_22296_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22296_Desc = {
    Text = [[
Kertas surat itu lenyap dalam sekejap di Domain, dan kamu mendengar sebuah desahan dingin. 
"Kalau saja kamu bisa semangat mencari bantuan seperti ini saat ujianmu tidak lulus."]]
  },
  Event_22296_Name = {
    Text = "Pengakuan sepihak"
  },
  Event_22397_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22397_Desc = {
    Text = "Kehadiranmu membuat bayangan-bayangan saling berpandangan. Setelah seberkas cahaya bintang menyapu ujung sepatumu, kerumunan itu tiba-tiba menghilang, hanya menyisakan bayangan paling pekat di tanganmu."
  },
  Event_22397_Name = {
    Text = "Perjanjian Bintang dan Bulan"
  },
  Event_22398_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_22398_Desc = {
    Text = "Bisikan berisik tiba-tiba terhenti. Bayangan hitam pekat seperti tinta bergantian berbalik ke arahmu, menatapmu. Dari wajah tanpa fitur itu, kamu bahkan bisa merasakan sedikit nada ejekan..."
  },
  Event_22398_Name = {
    Text = "Perjanjian Bintang dan Bulan"
  },
  Event_22399_ChoiceDesc1 = {
    Text = "[Mengamati dengan Tenang] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_22399_ChoiceDesc2 = {
    Text = "[Mengajukan pertanyaan] Mendapatkan 25 Segil Hitam"
  },
  Event_22399_Desc = {
    Text = "Di antara jalinan bintang dan bulan, bisikan-bisikan terus terdengar. \n\"Apakah ini orangnya? Orang @4…\"\n\"Dengan tubuh manusia, pada akhirnya tetap @3…\""
  },
  Event_22399_Name = {
    Text = "Perjanjian Bintang dan Bulan"
  },
  Event_22411_ChoiceDesc1 = {
    Text = "[Selesai dengan gemilang]"
  },
  Event_22411_Desc = {
    Text = "Jebakan murah tapi berguna!"
  },
  Event_22411_Name = {
    Text = "Membuat jebakan"
  },
  Event_24254_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_24254_Desc = {
    Text = "Badai Gnosis berputar di sekitar Tulu, kalian saling bertatapan sejenak, lalu masuk ke dalam kegelapan satu per satu."
  },
  Event_24254_Name = {Text = "Dari laut"},
  Event_24255_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_24255_Desc = {
    Text = "Badai Gnosis berputar di sekitar Tulu, sementara kesedihan dan rasa bersalah yang tak kunjung hilang menyebar di ruang tersebut."
  },
  Event_24255_Name = {
    Text = "Menghadapi jurang"
  },
  Event_24256_ChoiceDesc1 = {
    Text = "[Memegang tentakel] Menerima bantuan dari Tulu"
  },
  Event_24256_Desc = {
    Text = [[
Keharumannya seperti benda raksasa jatuh ke laut, mengguncang Domain di depan mata.
Kekuatan itu kuno, sangat lama, dan cukup melampaui segala zaman.
Untungnya, kamu tidak akan menjadi musuhnya, setidaknya untuk saat ini.]]
  },
  Event_24256_Name = {Text = "Dari laut"},
  Event_24257_ChoiceDesc1 = {
    Text = "[Menggenggam Tentakel] Bersama Tulu"
  },
  Event_24257_Desc = {
    Text = "Tulu menarik napas dalam-dalam, memandang Miryam dari kejauhan.\nSeolah-olah ia sedang merindukan sejarah, merindukan orang-orang terdahulu, merindukan hidupnya sendiri…\nEkspresi kompleks di wajahnya hanya bertahan sesaat, lalu ia memalingkan pandangannya dari wajah Miryam.\n\"Ayo pergi, tinggalkan dia.\""
  },
  Event_24257_Name = {
    Text = "Menghadapi jurang"
  },
  Event_24277_ChoiceDesc1 = {
    Text = "[Tutup pintu kabin]"
  },
  Event_24277_Desc = {
    Text = [[
Ramona menghentikan pelajar yang menerobos dari luar pintu. 
 Penjaga yang tanpa rasa takut dan kuat itu, meskipun terlihat sangat berantakan, sosoknya tampak samar-samar di mata birunya yang terlihat melalui lensa. 
 Hingga saat dia menggenggam tanganmu, Ramona baru bisa memastikan: kalian telah mendapatkan Reuni.]]
  },
  Event_24277_Name = {
    Text = "Pertemuan Bahagia"
  },
  Event_24278_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_24278_Desc = {
    Text = "Ramona tidak memberi Anda kesempatan untuk menjelaskan. Dia menarik Anda ke dalam kabin yang redup, lalu dengan hati-hati menutup pintu kabin..."
  },
  Event_24278_Name = {
    Text = "Pertemuan Bahagia"
  },
  Event_24540_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_24540_Desc = {
    Text = "\"Dia adalah perisaimu yang kokoh, pedang tajam di tanganmu. \nDia adalah temanmu, pasanganmu, sahabat yang kau percayai — tidak peduli bagaimana pun dia berubah.\""
  },
  Event_24540_Name = {
    Text = "Kehadiran yang asing namun akrab"
  },
  Event_24541_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_24541_Desc = {
    Text = [[
"Kamu... tidak, ini tidak mungkin, dirimu di siklus ini sudah... aku juga sudah..."
Suara itu menghilang bersamaan dengan sosoknya, hanya kesedihan yang masih tersisa di antara kabut air.]]
  },
  Event_24541_Name = {
    Text = "Bayangan yang familiar namun asing"
  },
  Event_24542_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_24542_Desc = {
    Text = "\"Untuk dunia, untuk umat manusia, untuk segala sesuatu yang kita hargai. \nTentu saja, yang paling penting — dia melakukannya untukmu.\""
  },
  Event_24542_Name = {
    Text = "Kehadiran yang asing namun akrab"
  },
  Event_24543_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_24543_Desc = {
    Text = [[
Sebelum kamu mendekati sosok itu, Dia sudah memperhatikanmu. Tubuh-Nya tersentak, seolah terkejut, atau tiba-tiba tenggelam dalam kesedihan yang mendalam.
Sebelum kamu sempat mengatakan apa pun, Dia lenyap bersama kabut.]]
  },
  Event_24543_Name = {
    Text = "Bayangan yang familiar namun asing"
  },
  Event_24544_ChoiceDesc1 = {
    Text = "[Siapa dia?] Dapatkan 3 Kartu Perintah secara acak dari dek dan pilih 1 untuk disalin."
  },
  Event_24544_ChoiceDesc2 = {
    Text = "[Mengapa Dia Bisa Menjadi Seperti Ini?] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_24544_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_24544_Desc = {
    Text = [[
Lagi-lagi kabut lain, lagi-lagi sosok lain. Berbeda dari sebelumnya, kali ini kamu bisa melihatnya dengan sangat jelas.
Postur tubuh yang sama persis denganmu, seragam yang sama persis denganmu, wajah yang sama persis denganmu.
"Kamu tahu mengapa kamu ada di sini," kata orang itu, "sama seperti kamu tahu mengapa dia berubah menjadi seperti itu."]]
  },
  Event_24544_Name = {
    Text = "Kehadiran yang asing namun akrab"
  },
  Event_24545_ChoiceDesc1 = {
    Text = "[Menghibur] Memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_24545_ChoiceDesc2 = {
    Text = "[Mencoba mendekati] Memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_24545_ChoiceDesc3 = {
    Text = "[Meninggalkan dengan berbalik] Mendapatkan 25 Segil Hitam"
  },
  Event_24545_Desc = {
    Text = "Kabut menyelimuti jalan di depanmu.\nSebuah sosok muncul di antara bayangan redup. Kau menyipitkan mata, namun tak bisa melihat wajah-Nya dengan jelas. Yang terdengar hanyalah bisikan-bisikan terputus.\n\"Mengapa…… mengapa tak bisa menyelamatkan…… apakah takdir benar-benar tak dapat diubah……\""
  },
  Event_24545_Name = {
    Text = "Bayangan yang familiar namun asing"
  },
  Event_35039_ChoiceDesc1 = {
    Text = "[Meminta Bantuan Mitra] Dapatkan Orison tingkat lanjut pilih 1 dari 3"
  },
  Event_35039_ChoiceDesc2 = {
    Text = "[Melakukan koordinasi di lokasi syuting] Mendapatkan Relik emas [(RelicConfig.Arg1)]"
  },
  Event_35039_ChoiceDesc3 = {
    Text = "[Memicu Fenomena Histeria] Memperoleh Relik [(RelicConfig.Arg1)]"
  },
  Event_35039_Desc = {
    Text = [[
"Panduan Lokasi Syuting Master Houdini" dengan jelas menyatakan bahwa Casiah, yaitu saya sendiri, sebagai produser dan sutradara, memiliki kewajiban dan kekuasaan untuk bertanggung jawab atas keseluruhan film. Oleh karena itu, karyawan Casiah yang berani, silakan pilih jadwal tindakanmu selanjutnya!"
"Jadwal? Tunggu, kapan saya menjadi karyawanmu?!"
"Kesempatan tidak datang dua kali, jangan ragu lagi!"]]
  },
  Event_35039_Name = {
    Text = "Mitologi Produser"
  },
  Event_35103_ChoiceDesc1 = {
    Text = "[Menghubungkan] Mengembalikan Arg2 poin Hidup[ExDesc1][ExDesc2]."
  },
  Event_35103_ChoiceDesc2 = {
    Text = "[Meditasi] Pilih 1 Pembangun untuk Bangun."
  },
  Event_35103_ChoiceDesc3 = {
    Text = "[ Pengusiran ] Hapus maksimal 3 Kartu gejala, dapatkan Arg2 Segil hitam."
  },
  Event_35103_Desc = {
    Text = "Kamu menjelajahi dalam kabut, tiba-tiba, lencana sekolah di dada memancarkan cahaya perak yang lemah. Siapa yang memanggil dari sisi lain komunikator?"
  },
  Event_35103_Name = {
    Text = "Persimpangan"
  },
  Event_35103_Tips3 = {
    Text = "Saat ini tidak memiliki Kartu gejala"
  },
  Event_35165_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35165_Desc = {
    Text = [[
Di tengah keraguan, Anda menghubungi penyandang dana misterius.
"Sudah sampai tahap ini, sulit untuk mundur. Mohon kemurahan hati Anda, Tuan..." 
Dari seberang komunikasi penghubung perak terdengar tawa yang sangat ceria, dan akhirnya lawan bicara menyetujui permintaan Anda sambil tertawa.
"Omong-omong, satu hal lagi... Mohon rahasiakan hal ini dari Ramona."]]
  },
  Event_35165_Name = {
    Text = "Mitologi Produser"
  },
  Event_35236_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35236_Desc = {
    Text = [[
Apa yang dilakukan oleh Koordinator Lokasi Syuting? Kamu mengeluarkan setumpuk dokumen yang entah kapan dimasukkan Casiah ke dalam alat transfer Gnosis, dan mulai membacanya dengan seksama. 
Kemudian, kamu mulai merasakan sakit kepala. 
Kerugian yang ditimbulkan Lotan selama proses penataan lokasi, camilan yang dimakan Aurita dan Cokelat, pengajuan penggantian biaya untuk bola sihir yang dibeli Casiah... setiap item biaya terhampar di depanmu, dan kamu terpaksa jongkok di tanah untuk melakukan perhitungan dengan kesakitan. 
Ngomong-ngomong, bola sihir Casiah itu apa?]]
  },
  Event_35236_Name = {
    Text = "Mitologi Produser"
  },
  Event_35259_ChoiceDesc1 = {
    Text = "[Mengusir Ilusi] Gejala Infeksi [ExDesc1][ExDesc2]."
  },
  Event_35259_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_35259_Desc = {
    Text = "Wajah-wajah kabur tiba-tiba muncul, mengelilingi kamu dan merintih putus asa dengan suara yang seolah-olah tidak ada."
  },
  Event_35259_Name = {Text = "Ilusi"},
  Event_35497_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35497_Desc = {
    Text = [[
Di balik fenomenal frenzy, diperlukan sosok pendorong, dan ketika menyebut "pendorong", sosok gadis dengan rambut pendek hijau langsung terbayang di benak. 
 "Perantara terbaik Universitas Mythag, Hanna Peaslee siap melayani Anda!" 
 "Jika ini adalah permintaan layanan pertama dari Penjaga, Anda hanya perlu membayar dengan tiga set lauk kari di kantin!"]]
  },
  Event_35497_Name = {
    Text = "Mitologi Produser"
  },
  Event_35887_ChoiceDesc1 = {Text = "[Maju]"},
  Event_35887_Desc = {
    Text = [[
Kamu menyingkap layar perahu, ternyata di bawahnya tidak ada apa-apa. Saat tersadar, layar perahu itu sudah menghilang tak terlihat. 
Layar putih bersih dan wajah samar-samar gadis itu berubah menjadi sebuah pesan, mengingatkanmu bahwa tak peduli bagaimana jalan ke depan, kamu tidak sendirian.]]
  },
  Event_35887_Name = {
    Text = "Layar Putih Murni"
  },
  Event_35888_ChoiceDesc1 = {
    Text = "[Mengangkat Layar Kapal]"
  },
  Event_35888_Desc = {
    Text = [[
Di sini tidak ada angin, tetapi ada sebuah kapal layar putih bersih, layarnya terangkat dengan megah, tegak di permukaan laut biru yang tenang. 
 Kamu samar-samar melihat wajah seorang gadis, fitur wajahnya tidak jelas, seperti terlihat melalui lapisan kabut tipis atau permukaan air yang mengalir. Keberadaannya tampaknya terpisah dari segala sesuatu di sekitarnya, tetapi dia adalah inti dari pemandangan ini. 
 Meskipun sosoknya terus bergetar menjadi jelas atau kabur, tetapi tidak diragukan lagi, kamu tahu siapa dia.]]
  },
  Event_35888_Name = {
    Text = "Layar Putih Murni"
  },
  Event_35894_ChoiceDesc1 = {
    Text = "[Jatuh ke bawah]Mendapatkan 35 Segil Hitam, terinfeksi[(Skill.Arg2)]，lanjut memilih"
  },
  Event_35894_ChoiceDesc2 = {
    Text = "[Jauhkan Diri]"
  },
  Event_35894_Desc = {
    Text = "Suara gadis itu menyebar di udara, samar dan jauh seperti gelembung."
  },
  Event_35894_Name = {
    Text = "Di tepi antara hidup dan mati"
  },
  Event_35895_ChoiceDesc1 = {
    Text = "[Berkeliling]Mendapatkan 30 Segil Hitam, terinfeksi[(Skill.Arg2)]，lanjut memilih"
  },
  Event_35895_ChoiceDesc2 = {
    Text = "[Jauhkan Diri]"
  },
  Event_35895_Desc = {
    Text = "Tubuh terasa sangat berat, kabut tebal mengunci tubuh yang lemah."
  },
  Event_35895_Name = {
    Text = "Di tepi antara hidup dan mati"
  },
  Event_35896_ChoiceDesc1 = {
    Text = "[Membaca Jalan Pendahulu] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_35896_ChoiceDesc2 = {
    Text = "[Membentuk jalan sendiri] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_35896_ChoiceDesc3 = {
    Text = "[Melihat Kegelapan] Mendapatkan 25 Segil Hitam"
  },
  Event_35896_Desc = {
    Text = [[
Jika kamu seorang diri meraba-raba maju di Domain, pasti tidak akan seyakin ini dengan jalan di depanmu. 
Jejak di Domain terbagi menjadi tiga, setiap jejak yang tertinggal menuliskan masa depan yang tak terlihat.]]
  },
  Event_35896_Name = {Text = "Keluaran"},
  Event_35897_ChoiceDesc1 = {
    Text = "[Membantu dia]"
  },
  Event_35897_ChoiceDesc2 = {
    Text = "[Melihatnya]"
  },
  Event_35897_Desc = {
    Text = [[
Dia bergumam, berputar-putar, dan akhirnya berhenti di depanmu. 
 Entah siapa yang mengganggu tidur nyenyaknya, kesadarannya terikat oleh realitas, namun jiwanya tetap tertinggal di negeri yang hilang.]]
  },
  Event_35897_Name = {
    Text = "Fatamorgana yang Hilang"
  },
  Event_35898_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35898_Desc = {
    Text = "Di dalam kegelapan yang belum terbedakan dari kekacauan ini, serangkaian jejak kaki yang kabur membentang, seperti jejak mendalam yang ditinggalkan oleh seorang pengembara malam di padang pasir tanpa bentuk."
  },
  Event_35898_Name = {Text = "Keluaran"},
  Event_35899_ChoiceDesc1 = {
    Text = "[Pergi] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_35899_Desc = {
    Text = [[
Di matamu terpancar sebuah mercusuar yang jauh, ia berdiri sendirian di tepi kegelapan, memancarkan cahaya yang lemah namun teguh, seperti pemandu di lautan malam, memanggil jiwa-jiwa yang ragu untuk menginginkan ketenangan di seberang. 
 Kamu tidak bisa menahan diri untuk mengejarnya, namun, tanah di bawah kakimu tiba-tiba tidak lagi kokoh. 
 Kamu melangkah ke dalam perairan yang tersembunyi di bawah bayangan. Permukaan airnya lembut seperti sutra, tanpa suara menelan langkahmu.]]
  },
  Event_35899_Name = {Text = "kedip"},
  Event_35900_ChoiceDesc1 = {
    Text = "[Mendengarkan Dia]"
  },
  Event_35900_ChoiceDesc2 = {
    Text = "[Abaikan dia]"
  },
  Event_35900_Desc = {
    Text = "Kamu jelas melihat sumber cahaya lampu, yang ternyata adalah seorang karakter dengan sosok tubuh wanita.\nCahaya mengalir dari bawah tengkorak makhluk aneh itu, membentuk jalan menuju tempat yang tak dikenal.\n\"Kembali… ke Li@2ya…\""
  },
  Event_35900_Name = {
    Text = "Lampu abadi"
  },
  Event_35901_ChoiceDesc1 = {
    Text = "[Mendekati Mercusuar]"
  },
  Event_35901_ChoiceDesc2 = {
    Text = "[Menjauh dari Mercusuar]"
  },
  Event_35901_Desc = {
    Text = [[
Berbelok di sudut yang menginterseksi antara kenyataan dan mimpi, dalam sekejap mata itu, sebuah pemandangan menakutkan badai terbentang di depan. 
 Seolah-olah diangkat oleh tangan raksasa yang tak terlihat, angin mengaum seperti binatang buas, mengangkat debu dan harapan, langit kelam, sangat menekan. 
 Di jantung badai, sebuah menara yang seharusnya tidak ada berdiri, tampaknya merupakan produk imajinasi, dan seolah-olah merupakan peninggalan dari legenda kuno. Di panggung yang dilanda angin kencang, ia mengeluarkan cahaya lemah dengan kesepian dan ketahanan.]]
  },
  Event_35901_Name = {
    Text = "Pusat Badai"
  },
  Event_35902_ChoiceDesc1 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_35902_Desc = {
    Text = [[
"Di Domain, cahaya menyala terus-menerus, Fatamorgana dengan tentakel di tubuhnya..."
Tulu menutup mata untuk merenung, setelah beberapa saat, dia menghela napas panjang. 
"Penjaga gerbang Lemuria... salah satu pelayan dari Yu. Pada akhirnya, dia juga tidak bisa melarikan diri dari belenggu obsesi."]]
  },
  Event_35902_Name = {
    Text = "Pengendapan Kapal Sonanir"
  },
  Event_35903_ChoiceDesc1 = {
    Text = "[Menyentuh Cahaya Perak] Mendapatkan 25 Segil Hitam"
  },
  Event_35903_ChoiceDesc2 = {
    Text = "[Percakapan dengan Cahaya Perak] Memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_35903_Desc = {
    Text = "Komunikator yang tertutup rapat terbuka sedikit celah, cahaya redup mengalir keluar — ini mungkin percakapan pertama Perak dengan dunia luar setelah disegel ke dalam pusat komunikator."
  },
  Event_35903_Name = {
    Text = "Monumen Mithril"
  },
  Event_35904_ChoiceDesc1 = {
    Text = "[Peroleh] Relik [(RelicConfig.Arg1)]"
  },
  Event_35904_Desc = {
    Text = "\"Wanita dengan kepala bercahaya?\" Wajah Elton menunjukkan keterkejutan. Jelas, dia pernah mendengar tentang sosok misterius yang sesekali muncul di Domain kapal kargo, hanya saja——\n\"Malam ketika kapal Sonaniel tenggelam…… yaitu malam ketika aku Bangun Celeste, aku pernah melihat bayangan seperti itu di tengah badai.\"\n\"Aku pasti tidak salah.\""
  },
  Event_35904_Name = {
    Text = "Pengendapan Kapal Sonanir"
  },
  Event_35905_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35905_Desc = {
    Text = [[
Domain penuh dengan bahaya yang tak terduga, sangat dalam dan sulit diukur. 
 Matamu terpaku pada kekacauan yang tak terlihat, tetapi sebelum kamu dilahap oleh kekacauan, Ramona yang telah menyelesaikan para pengejarmu tiba-tiba menangkapmu dan membawamu ke arah lain.]]
  },
  Event_35905_Name = {Text = "Keluaran"},
  Event_35906_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35906_Desc = {
    Text = [[
Apakah itu buah yang dihasilkan oleh jiwa misteriusmu? Apakah segala yang kamu alami sekarang adalah bentrokan antara diri dan supradiri? 
 Semakin kamu berpikir, semakin nyaring dan jelas suara bising di dalam kepalamu. Pandanganmu menerobos kabut, dan saat kamu hampir bisa melihat orang dalam kabut itu, jiwa menolak dirimu.]]
  },
  Event_35906_Name = {
    Text = "Fate Terbalik"
  },
  Event_35907_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35907_Desc = {
    Text = "Itu mengalir di dalam tubuh, berubah menjadi kekuatan tanpa rasa takut, menopangmu untuk menerobos kabut dan merobek ketakutan."
  },
  Event_35907_Name = {
    Text = "Mengejar Cahaya"
  },
  Event_35908_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35908_Desc = {
    Text = "Seiring dengan konsentrasi kesadaran dan ketenangan batin, ilusi yang kacau mulai perlahan-lahan larut, akhirnya surut seperti air pasang. \nPada akhirnya, kebisingan di dalam otak juga menghilang tanpa jejak — hanya saja, berapa banyak yang akan kamu lewatkan? Tidak ada yang tahu."
  },
  Event_35908_Name = {
    Text = "Peringatan Masa Depan"
  },
  Event_35909_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35909_Desc = {
    Text = "Jiwa sepenuhnya hilang dalam dering telinga. Kamu berusaha keras untuk melepaskan diri, mencoba memahami penderitaan ini, namun tetap saja hanya berkeliaran di tepi kesadaran..."
  },
  Event_35909_Name = {
    Text = "Di tepi antara hidup dan mati"
  },
  Event_35910_ChoiceDesc1 = {
    Text = "[Pergi] Dapatkan 1 dari 3 pilihan Relik emas, terinfeksi [(Skill.Arg1)]"
  },
  Event_35910_Desc = {
    Text = "Kamu bisa merasakan setiap titik cahaya yang dipancarkan oleh mercusuar itu, mereka bercahaya dan meloncat di tengah badai, seperti panggilan dari kedalaman Jiwa, bahkan dalam ketakutan yang paling bergelora sekalipun, tidak pernah menyerah pada misi untuk memandu jalan pulang."
  },
  Event_35910_Name = {
    Text = "Pusat Badai"
  },
  Event_35911_ChoiceDesc1 = {
    Text = "[Pergi] Mendapatkan 1 dari 3 Orison tingkat lanjut"
  },
  Event_35911_Desc = {
    Text = [[
Apakah itu simbol harapan, atau pertanda kehancuran?
Kau tidak lagi melihatnya, seakan-akan keberadaannya hanyalah ilusi yang dirancang dengan cermat.]]
  },
  Event_35911_Name = {
    Text = "Pusat Badai"
  },
  Event_35912_ChoiceDesc1 = {
    Text = "[Terjebak Dalam Kebingungan]mendapatkan 20 Segil hitam, terinfeksi[(Skill.Arg2)]"
  },
  Event_35912_ChoiceDesc2 = {
    Text = "[Jauhkan Diri]"
  },
  Event_35912_Desc = {
    Text = "Kemudian, di depan matamu muncul lapisan abu-abu yang tidak biasa. Setelah sesaat, kamu menyadari bahwa itu adalah kelopak mata bagian atas yang setengah transparan."
  },
  Event_35912_Name = {
    Text = "Di tepi antara hidup dan mati"
  },
  Event_35913_ChoiceDesc1 = {
    Text = "[Bangun] Secara acak membangunkan 1 Pembangun, terinfeksi [(Skill.Arg1)]"
  },
  Event_35913_Desc = {
    Text = [[
Di dalam hatimu muncul semacam resonansi yang tak terungkapkan.
Namun, akal sehatmu berkata: Abaikan dia.]]
  },
  Event_35913_Name = {
    Text = "Lampu abadi"
  },
  Event_35914_ChoiceDesc1 = {
    Text = "[Pergi] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_35914_Desc = {
    Text = "Ucapannya tidak terukir di prasasti mana pun yang dikenal, namun menggumpal di udara menjadi pengakuan dosa dan seruan terdalam. Seolah datang melayang dari ujung lain waktu, menembus sedimentasi bertahun-tahun, membawa kerinduan mendalam pada tanah air yang jauh."
  },
  Event_35914_Name = {
    Text = "Lampu abadi"
  },
  Event_35915_ChoiceDesc1 = {
    Text = "[Memegang tangannya] 1 Relik perak acak ditingkatkan menjadi Relik emas [(RelicConfig.Arg1)]"
  },
  Event_35915_ChoiceDesc2 = {
    Text = "[Mengungkapkan Kepedulian] Memperoleh Relik Perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_35915_ChoiceDesc3 = {
    Text = "[Mengamati dia] mendapatkan 25 Segil hitam"
  },
  Event_35915_Desc = {
    Text = [[
Murphy berada di barisan paling belakang, dia berjalan sejajar dengan Celeste. 
Kamu tak bisa menahan diri untuk terus menoleh ke arahnya, namun Murphy selalu menunduk memandangi ujung sepatunya, menyembunyikan ekspresinya dalam ketidakpastian.]]
  },
  Event_35915_Name = {
    Text = "Manajemen Rasa Sakit"
  },
  Event_35915_Tips1 = {
    Text = "Belum memiliki Relik perak"
  },
  Event_35916_ChoiceDesc1 = {
    Text = "[Tidak Bisa Terlepas]mendapatkan 40 Segil hitam, terinfeksi[(Skill.Arg2)], terus memilih"
  },
  Event_35916_ChoiceDesc2 = {
    Text = "[Embrace Reality] Mendapatkan 25 Segil Hitam"
  },
  Event_35916_Desc = {
    Text = [[
@1@1 memperoleh kehidupan kembali, jiwa melintasi tepi @2, namun belum sepenuhnya merangkul tubuh. 
 Kata-kata penuh perhatian dari Murphy semakin menjauh dari kesadaranmu, seperti raungan gagak, menggema di telinga, namun selalu terhalang oleh dinding batin di luar jendela.]]
  },
  Event_35916_Name = {
    Text = "Di tepi antara hidup dan mati"
  },
  Event_35917_ChoiceDesc1 = {
    Text = "[Keluar] Pilih untuk menyalin 1 Kartu perintah, terinfeksi [(Skill.Arg1)]"
  },
  Event_35917_Desc = {
    Text = "Dia hanyalah hantu yang tersisa di dunia nyata, sebuah fragmen kuno yang tak terjangkau namun tak terhapuskan."
  },
  Event_35917_Name = {
    Text = "Fatamorgana yang Hilang"
  },
  Event_35918_ChoiceDesc1 = {
    Text = "[Keluar] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_35918_Desc = {
    Text = [[
Dalam sekejap itu, kamu mendengar suara retakan halus dari dalam jiwa. Seperti asap yang perlahan memudar, sosoknya mulai kabur, menjadi semakin tidak nyata. 
 Dia tidak ada di sini, ini hanyalah proyeksi dari ingatan Kapten Elton. 
 Namun, rasa kehilangan dan kebingungan yang tertinggal di dalam hati, miliknya, bukanlah rekayasa.]]
  },
  Event_35918_Name = {
    Text = "Fatamorgana yang Hilang"
  },
  Event_35919_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35919_Desc = {
    Text = "Pada saat ujung jari bersentuhan, perasaan rumit tiba-tiba membanjiri hati — terasa begitu panas namun juga dingin. \n Jiwa yang terlupakan oleh dunia sedang meraung, mencari keabadian sepanjang masa."
  },
  Event_35919_Name = {
    Text = "Monumen Mithril"
  },
  Event_35920_ChoiceDesc1 = {
    Text = "[Genggam Api] Meningkatkan Kesehatan maksimum sebesar Arg1"
  },
  Event_35920_ChoiceDesc2 = {
    Text = "[Menghadapi Hati Nurani] 2 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi 2 \"(Skill.Arg2)\""
  },
  Event_35920_Desc = {
    Text = "Dalam perburuan besar ini, kejaran Goliath seperti binatang buas di malam gelap, berusaha melahap semua cahaya harapan. Namun, pengejaran tanpa ampun ini tidak membekukan dirimu, melainkan menyalakan api di dalam hatimu, yang menjalar dan berkobar di dalam dada, semakin lama semakin membara."
  },
  Event_35920_Name = {
    Text = "Mengejar Cahaya"
  },
  Event_35921_ChoiceDesc1 = {
    Text = "[Interpretasikan] Dapatkan 3 Kartu Perintah secara acak dari dek dan pilih 1 untuk disalin."
  },
  Event_35921_ChoiceDesc2 = {
    Text = "[Menjadi Itu] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_35921_ChoiceDesc3 = {
    Text = "[Abaikan itu] Dapatkan 25 Segil hitam"
  },
  Event_35921_Desc = {
    Text = "Pada saat melangkah maju, sebuah getaran tak terlihat tiba-tiba menarik kesadaranmu, memaksa kedua matamu melihat ke arah batas Domain yang penuh dengan Kekacauan dan Ilusi."
  },
  Event_35921_Name = {
    Text = "Peringatan Masa Depan"
  },
  Event_35922_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35922_Desc = {
    Text = "Ada warna-warna yang aneh menari di depan mata, ada suara yang berbisik di telinga, atau mungkin pemandangan yang berlalu dan wajah-wajah yang kabur, semuanya saling terjalin seolah-olah menceritakan satu demi satu kisah yang tidak dikenal. Ilusi-ilusi ini membuatmu merasa semakin terpisah dari kenyataan, terperosok ke dalam mimpi yang baik akrab maupun asing."
  },
  Event_35922_Name = {
    Text = "Peringatan Masa Depan"
  },
  Event_35923_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35923_Desc = {
    Text = "Getaran itu tidak berasal dari kebisingan eksternal atau sensasi fisik, melainkan firasat mendalam yang sulit dijelaskan. Seperti suara dari masa depan yang berdenyut dalam kesadaranmu."
  },
  Event_35923_Name = {
    Text = "Peringatan Masa Depan"
  },
  Event_35924_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35924_Desc = {
    Text = "Tangannya tanpa sadar meraih dadanya, berusaha mengendalikan perasaan yang hampir membuatnya tercekik. \n Ketakutan ini membuatnya menggigit bibir, memaksakan diri untuk mengabaikan rasa sakit yang menerjang rongga dadanya. Setiap sedikit distorsi di wajah Murphy segera ditutupi olehnya, dengan penyamaran yang buruk untuk menyembunyikan rasa sakit. \n —— Hingga kamu menggenggam tangannya, kejutan menjadi warna di wajahnya."
  },
  Event_35924_Name = {
    Text = "Manajemen Rasa Sakit"
  },
  Event_35925_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35925_Desc = {
    Text = "\"Murphy? Apakah kamu baik-baik saja?\"\n——Dia tidak meresponsmu. \nSebuah keanehan yang berwujud menggerogoti hatinya, membuatnya hampir tidak bisa bernapas."
  },
  Event_35925_Name = {
    Text = "Manajemen Rasa Sakit"
  },
  Event_35926_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35926_Desc = {
    Text = "Kamu tidak ragu lagi, melangkah ke dalam kegelapan yang tak dikenal. Setiap langkah yang diambil menggambarkan peta jalan menuju cahaya redup yang perlahan menyebar."
  },
  Event_35926_Name = {Text = "Keluaran"},
  Event_35927_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35927_Desc = {
    Text = "Di depan matamu ada api yang bergerak. \nApi itu membara, hidup, membungkus seberkas kembang api dingin yang bergoyang, dengan terangnya mengusir suara-suara yang tidak selaras. \nKamu tersadar, hanya untuk menemukan Murphy di depanmu menoleh dengan tatapan bingung—\n\"Apa kamu benar-benar baik-baik saja?\""
  },
  Event_35927_Name = {
    Text = "Di tepi antara hidup dan mati"
  },
  Event_35928_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35928_Desc = {
    Text = [[
Kau merasakan kesadaran mulai terpisah, perlahan-lahan diseret jauh dari tubuhmu.
Seolah melihat jiwamu menari dengan sisa kesadaran perak ini, kemudian terjatuh dalam jurang yang tak terlihat...
Di sana adalah kehampaan yang murni.]]
  },
  Event_35928_Name = {
    Text = "Monumen Mithril"
  },
  Event_35929_ChoiceDesc1 = {
    Text = "[Pergi] mendapatkan 25 Segil Hitam"
  },
  Event_35929_Desc = {
    Text = [[
Sebelum kamu bisa menyelidiki lebih jauh sumber cahaya, cahaya itu tiba-tiba bergetar dan kemudian hancur di udara.
Cahaya itu memancarkan riak yang menyebar ke segala arah di dalam Domain.
Lalu, tidak ada apa pun yang tersisa.]]
  },
  Event_35929_Name = {Text = "kedip"},
  Event_35930_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35930_Desc = {
    Text = [[
Bagaimana mungkin itu kamu?
Jika itu kamu, mengapa saat kesedihan datang, Dia tidak menebusmu?
Jika itu kamu, mengapa saat mengalami penderitaan, Dia tidak membantumu?
Jadi, semuanya adalah ilusi.]]
  },
  Event_35930_Name = {
    Text = "Fate Terbalik"
  },
  Event_35931_ChoiceDesc1 = {
    Text = "[Tanya Kapten]"
  },
  Event_35931_ChoiceDesc2 = {
    Text = "[Tanya Tulu]"
  },
  Event_35931_Desc = {
    Text = [[
Sekali lagi, kamu melihat sosok misterius itu melangkah ke dinding kabin, menghilang tanpa jejak. Rambut panjangnya yang bercahaya mulai dari suatu tempat, berubah menjadi beberapa tentakel yang menjuntai di tanah. 
 Kamu sangat yakin, meskipun dia bukan bagian dari Pelaut, identitasnya pasti memiliki hubungan yang rumit dengan negeri yang hilang.]]
  },
  Event_35931_Name = {
    Text = "Pengendapan Kapal Sonanir"
  },
  Event_35932_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35932_Desc = {
    Text = [[
Kamu merasa takut, semua ini karena adrenalin yang bermain. 
 Kamu takut bahwa keputusanmu akan menyebabkan kerusakan pada jiwa-jiwa yang berbagi kegelapan bersamamu.]]
  },
  Event_35932_Name = {
    Text = "Mengejar Cahaya"
  },
  Event_35933_ChoiceDesc1 = {
    Text = "[Tak Ada Tempat untuk Melarikan Diri]mendapatkan 25 Segil hitam, terinfeksi[(Skill.Arg2)], terus memilih"
  },
  Event_35933_ChoiceDesc2 = {
    Text = "[Jauhkan Diri]"
  },
  Event_35933_Desc = {
    Text = "Setiap serat saraf meraungkan keinginan akan @2."
  },
  Event_35933_Name = {
    Text = "Di tepi antara hidup dan mati"
  },
  Event_35934_ChoiceDesc1 = {Text = "[Kejar]"},
  Event_35934_ChoiceDesc2 = {
    Text = "[Abaikan itu]"
  },
  Event_35934_Desc = {
    Text = [[
Di jauh dalam Domain, cahaya lembut dan memikat mulai bersinar. 
 Ia berkilau seperti sinar matahari yang dipantulkan di permukaan air, seperti cahaya bintang yang bergetar, atau seperti titik lilin... 
 Saat kamu ingin mendekatinya, cahaya itu tiba-tiba menghilang. 
 Seolah-olah ia sedang menggoda kamu, seperti menggoda ngengat yang hidup berdasarkan insting.]]
  },
  Event_35934_Name = {Text = "kedip"},
  Event_35935_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_35935_Desc = {
    Text = [[
Memikirkan hal-hal ini lagi, apa gunanya? 
 Kamu seperti daun yang melayang di udara, dorongan angin takdir membawamu pergi, hanya itu saja.]]
  },
  Event_35935_Name = {
    Text = "Fate Terbalik"
  },
  Event_35936_ChoiceDesc1 = {
    Text = "[Menghina diri sendiri] Memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_35936_ChoiceDesc2 = {
    Text = "[Usut Tuntas] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_35936_ChoiceDesc3 = {
    Text = "[ Tidak Ingin Lagi ] mendapatkan 25 Segil Hitam"
  },
  Event_35936_Desc = {
    Text = [[
Angin hidup menggerakkan jiwamu, membuatmu terjebak dalam pusaran realitas, terseret ke dalam ketidakpastian yang penuh kabut. 
 Kamu tak bisa menahan diri untuk bertanya pada suara di pikiranmu: "Apakah itu aku?"]]
  },
  Event_35936_Name = {
    Text = "Fate Terbalik"
  },
  Event_36146_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36146_Desc = {
    Text = [[
Murphy akhirnya menyadari tatapanmu, mungkin, tatapan itu memang terlalu panas. 
Dia mengambil beberapa napas dalam-dalam, lalu mengeluarkan suara "hmm" pelan dari hidungnya. Akhirnya, dia menarik Celeste untuk mengikutimu, berjalan tepat di belakangmu.]]
  },
  Event_36146_Name = {
    Text = "Manajemen Rasa Sakit"
  },
  Event_36722_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36722_Desc = {
    Text = "Pada saat ujung jari bersentuhan, perasaan rumit tiba-tiba membanjiri hati — terasa begitu panas namun juga dingin. \n Jiwa yang terlupakan oleh dunia sedang meraung, mencari keabadian sepanjang masa."
  },
  Event_36722_Name = {
    Text = "Monumen Gnosis"
  },
  Event_36723_ChoiceDesc1 = {
    Text = "[Sentuh itu] Bangun 1 Pembangun secara acak, infeksi [(Skill.Arg1)]"
  },
  Event_36723_ChoiceDesc2 = {
    Text = "[Bergabung dalam Rotasi] Dapatkan 1 dari 3 Orison"
  },
  Event_36723_Desc = {
    Text = [[
Pada saat melangkah, sebuah celah diam-diam terbuka di kedalaman terdalam Roh. Aura mendalam yang tak terlukiskan menyusup melalui retakan itu, mengusik pikiranmu. 
 Kamu merasakan sebuah Planet Kekacauan berwarna perak berputar dan tumbuh diam-diam di dalam hatimu.]]
  },
  Event_36723_Name = {
    Text = "Monumen Gnosis"
  },
  Event_36724_ChoiceDesc1 = {
    Text = "[Ikuti mereka] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_36724_ChoiceDesc2 = {
    Text = "[Mengusap mereka] mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_36724_ChoiceDesc3 = {
    Text = "[Tidak mengganggu] Mendapatkan 25 Segil Hitam"
  },
  Event_36724_Desc = {
    Text = [[
Setelah berbelok di tikungan yang tak terduga, sebuah pemandangan aneh muncul dalam pandanganmu.
Bayangan beberapa kucing tampak samar-samar, melayang di sisi dinding ruang yang dingin.]]
  },
  Event_36724_Name = {
    Text = "kucing kapal"
  },
  Event_36725_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36725_Desc = {
    Text = "\"Memori\"tidak merespons, mereka menempel di dinding kapal, memandangmu tanpa berkedip sampai kamu melewati tikungan berikutnya."
  },
  Event_36725_Name = {
    Text = "Pemilik Sonanir"
  },
  Event_36726_ChoiceDesc1 = {
    Text = "[Hindari jalan] Hapus 1 Kartu perintah, dapatkan Arg1 Segil hitam."
  },
  Event_36726_ChoiceDesc2 = {
    Text = "[Tanya mengapa tenggelam] Salin 1 Kartu perintah, infeksi [(Skill.Arg1)]"
  },
  Event_36726_ChoiceDesc3 = {
    Text = "[Sapa awak kapal] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_36726_Desc = {
    Text = [[
Saat berjalan menuju Ruang Kekuatan, kamu kembali menemui beberapa "Memori"yang terperangkap di dalam Domain.
Mereka bukan hantu, hanya rasa rindu Kapten Elton terhadap para awak kapal yang telah tiada.]]
  },
  Event_36726_Name = {
    Text = "Pemilik Sonanir"
  },
  Event_36727_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36727_Desc = {
    Text = "\"Memori\"terlepas dari dinding kapal, dia memelintir wajahnya dan mengeluarkan ratapan dari tenggorokannya.\n——Menara Suar.\n——Menara Suar yang terpencil, menuntun mereka ke dalam badai."
  },
  Event_36727_Name = {
    Text = "Pemilik Sonanir"
  },
  Event_36728_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36728_Desc = {
    Text = "Kamu memilih untuk mengikuti, mengikuti jejak yang dilukiskan oleh jiwa-jiwa yang lembut dan bebas, meskipun di depan terdapat jebakan gelap."
  },
  Event_36728_Name = {
    Text = "kucing kapal"
  },
  Event_36729_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36729_Desc = {
    Text = "Jangan ganggu yang telah tiada, jangan kacaukan memori yang terlelap."
  },
  Event_36729_Name = {
    Text = "Pemilik Sonanir"
  },
  Event_36730_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36730_Desc = {
    Text = [[
Kau merasakan kesadaran mulai terpisah, perlahan-lahan diseret jauh dari tubuhmu.
Seolah melihat jiwamu menari dengan planet, kemudian terjatuh dalam jurang yang tak terlihat...
Di sana adalah kehampaan yang murni.]]
  },
  Event_36730_Name = {
    Text = "Monumen Gnosis"
  },
  Event_36731_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36731_Desc = {
    Text = [[
Sebagai makhluk lembut, mereka adalah kemewahan yang tak diizinkan dalam Domain ini, tak lebih dari sekadar Fatamorgana.
Meskipun kau menyadari hal ini, hatimu tetap merasakan riak kehangatan yang samar.]]
  },
  Event_36731_Name = {
    Text = "kucing kapal"
  },
  Event_36732_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36732_Desc = {
    Text = [[
Bayangan mereka kabur seperti lukisan minyak yang tergerus oleh arus waktu dan ruang. Titik-titik hitam yang dalam seperti awan yang melayang di langit malam, tetapi mata mereka lebih mirip dengan kilauan bintang yang jauh, memancarkan cahaya yang misterius dan dalam. 
 Kamu tidak bisa menolak godaan mereka, mengulurkan tanganmu ke dalam sebuah kekosongan.]]
  },
  Event_36732_Name = {
    Text = "kucing kapal"
  },
  Event_36733_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36733_Desc = {
    Text = "Kamu tahu bahwa kamu harus terus maju, meskipun tersandung, meskipun jatuh."
  },
  Event_36733_Name = {
    Text = "Rasa sakit fisik"
  },
  Event_36734_ChoiceDesc1 = {
    Text = "[Mencoba memanggilnya] Meningkatkan Hidup sebesar Arg1 poin"
  },
  Event_36734_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_36734_Desc = {
    Text = "Ini adalah tempat yang penuh dengan keinginan yang disembunyikan dan ketakutan yang belum pernah dijangkau, merupakan gulungan kaya yang terjalin dari mimpinya dan ingatan."
  },
  Event_36734_Name = {
    Text = "Perubahan Evolusi"
  },
  Event_36735_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36735_Desc = {
    Text = [[
"Penjaga, jika tidak bisa bertahan lagi, jangan tanggung penderitaan sendirian."
Kamu tidak akan menghindari rasa sakit, itu adalah bagian dari hidup yang seperti bayangan semu.
Kamu tidak akan lari dari bayangan malam, karena kamu tidak takut dilahap oleh kegelapan di dalamnya.]]
  },
  Event_36735_Name = {
    Text = "Rasa sakit fisik"
  },
  Event_36736_ChoiceDesc1 = {
    Text = "[Panggil dia terus] Tingkatkan Arg1 poin Hidup, infeksi [(Skill.Arg2)]"
  },
  Event_36736_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_36736_Desc = {
    Text = "Coretan polos membentuk dunia ini."
  },
  Event_36736_Name = {
    Text = "Perubahan Evolusi"
  },
  Event_36737_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36737_Desc = {
    Text = [[
Doa para Pelaut berputar di telinga, penuh dengan kegilaan dan membuat sesak napas. 
Namun, mereka tidak akan mempengaruhi kemauanmu, sama sekali tidak.]]
  },
  Event_36737_Name = {Text = "dari laut"},
  Event_36738_ChoiceDesc1 = {
    Text = "[Mengambil foto] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_36738_Desc = {
    Text = [[
Mata-mata itu dalam dan jernih, seperti cahaya di kedalaman Aequor, terang dan hangat.
Mereka tidak berbicara, juga tidak berwujud, tetapi kamu bisa merasakan keberadaan mereka, seperti belaian angin sejuk di malam musim panas.]]
  },
  Event_36738_Name = {
    Text = "Pengintai Baik"
  },
  Event_36739_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36739_Desc = {
    Text = "Kamu memaksa dirimu untuk fokus pada krisis di depan mata, dengan tegas mengabaikan rasa sakit itu."
  },
  Event_36739_Name = {
    Text = "Rasa sakit fisik"
  },
  Event_36740_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36740_Desc = {
    Text = "Itu adalah tanda hidup, bukti keberadaan. Itu menceritakan sebuah cerita, namun di bawah amukan badai ini, suaranya perlahan hilang."
  },
  Event_36740_Name = {
    Text = "Selamat tinggal, Icarus"
  },
  Event_36741_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36741_Desc = {
    Text = [[
Mata-mata itu dalam dan jernih, seperti cahaya di kedalaman Aequor, terang dan hangat.
Mereka tidak berbicara, juga tidak berwujud, tetapi kamu bisa merasakan keberadaan mereka, seperti belaian angin sejuk di malam musim panas.]]
  },
  Event_36741_Name = {
    Text = "Pengintai Baik"
  },
  Event_36742_ChoiceDesc1 = {
    Text = "[Panggilan Terakhirnya] Tingkatkan Arg1 poin Hidup, infeksi [(Skill.Arg2)]"
  },
  Event_36742_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_36742_Desc = {
    Text = "Retakan yang menyakitkan membentuk dunia ini."
  },
  Event_36742_Name = {
    Text = "Perubahan Evolusi"
  },
  Event_36743_ChoiceDesc1 = {
    Text = "[Memeluk Rasa Sakit] Mendapatkan Relik Perak \"(RelicConfig.Arg1)\", Terinfeksi \"(Skill.Arg2)\""
  },
  Event_36743_ChoiceDesc2 = {
    Text = "[Menolak Rasa Sakit] mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\" dan \"(Skill.Arg3)\""
  },
  Event_36743_ChoiceDesc3 = {
    Text = "[Mengabaikan Rasa Sakit] Mendapatkan 25 Segil Hitam"
  },
  Event_36743_Desc = {
    Text = "Rasa sakit seperti batu keras, berakar dalam di dalam pikiran. Penderitaan yang semakin menyebar ibarat sulur, melilit setiap inci saraf, membengkokkan kesadaranmu."
  },
  Event_36743_Name = {
    Text = "Rasa sakit fisik"
  },
  Event_36744_ChoiceDesc1 = {
    Text = "[Menggemakan dengan teguh] Meningkatkan Arg1 poin hidup, terinfeksi [(Skill.Arg2)]"
  },
  Event_36744_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_36744_Desc = {
    Text = "Kehausan akan pengakuan membentuk dunia ini."
  },
  Event_36744_Name = {
    Text = "Perubahan Evolusi"
  },
  Event_36745_ChoiceDesc1 = {
    Text = "[Perhatikan mereka] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_36745_ChoiceDesc2 = {
    Text = "[Mintalah bantuan mereka] Terinfeksi [(Skill.Arg1)], ganti Orison yang diperoleh di opsi 1, dapat digunakan dua kali"
  },
  Event_36745_Desc = {
    Text = [[
Di antara aliran warna dalam Domain, kamu merasakan tatapan misterius. Tatapan itu seperti mata tak terlihat yang bersembunyi di dalam lipatan misterius Domain ini.
Pada saat mereka memandangmu, hatimu diliputi oleh Keinginan yang kuat.]]
  },
  Event_36745_Name = {
    Text = "Pengintai Baik"
  },
  Event_36746_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36746_Desc = {
    Text = [[
Jika kamu tidak memahami mereka, kamu tidak akan bisa keluar dari neraka kacau ini. 
 Ketika bintang-bintang terpantul di permukaan air, keinginan dan permohonan yang berdetak itu, doa-doa tersebut perlahan naik ke permukaan laut seperti gelembung, namun tanpa disadari ditelan oleh kegelapan.]]
  },
  Event_36746_Name = {Text = "dari laut"},
  Event_36747_ChoiceDesc1 = {
    Text = "[Memanggilnya dengan cemas] Meningkatkan Arg1 poin hidup, terinfeksi [(Skill.Arg2)]"
  },
  Event_36747_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_36747_Desc = {
    Text = "Ucapan yang buruk membentuk dunia ini."
  },
  Event_36747_Name = {
    Text = "Perubahan Evolusi"
  },
  Event_36748_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36748_Desc = {
    Text = "Kamu berdiri di hadapannya, menyaksikan jiwanya dilahap oleh kenangan aneh."
  },
  Event_36748_Name = {
    Text = "Perubahan Evolusi"
  },
  Event_36749_ChoiceDesc1 = {
    Text = "[Itu adalah air mata] Hapus 1 kartu"
  },
  Event_36749_ChoiceDesc2 = {
    Text = "[Itu adalah darah] Mendapatkan \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_36749_Desc = {
    Text = [[
Beberapa tetes cairan menyebar dengan bebas di dek, perlahan merayap melalui celah-celah dek tanpa suara. 
 Jejak itu lembut namun teguh, setiap bekas basah mengandung makna yang tegas, dalam raungan angin laut dan keluhan kapal layar, membentuk sebuah lukisan tentang kehidupan dan kematian, ketenangan dan keramaian.]]
  },
  Event_36749_Name = {
    Text = "Selamat tinggal, Icarus"
  },
  Event_36750_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36750_Desc = {
    Text = [[
Kamu menatap bintik-bintik yang perlahan menyebar itu, berusaha memahami hakikatnya. Namun, di batas antara langit dan bumi, perbedaan antara air hujan dan darah menjadi kabur. 
Apakah mereka air hujan? Apakah mereka air mata lautan? 
Kamu tidak tahu.]]
  },
  Event_36750_Name = {
    Text = "Selamat tinggal, Icarus"
  },
  Event_36751_ChoiceDesc1 = {
    Text = "[Menolak Frekuensi yang Sama] Mendapatkan 1 dari 3 Relik Perak"
  },
  Event_36751_ChoiceDesc2 = {
    Text = "[Masuk ke Frekuensi yang Sama] Mendapatkan Relik Perak \"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\", terinfeksi dua kali oleh \"(Skill.Arg3)\""
  },
  Event_36751_Desc = {
    Text = "Bisikan Pelaut dan detak jantung \"Bayi Suci\"membentuk simfoni rahasia, setiap getaran membuat alam semesta cair yang tak berujung memicu suatu raungan."
  },
  Event_36751_Name = {Text = "dari laut"},
  Event_36752_ChoiceDesc1 = {
    Text = "[Mengambil foto] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_36752_ChoiceDesc2 = {
    Text = "[Periksa Film] Terinfeksi [(Skill.Arg1)], ganti Orison yang diperoleh di opsi 1. Masih bisa digunakan sekali lagi."
  },
  Event_36752_Desc = {
    Text = [[
Mereka tidak memiliki niat jahat, perasaan ini seperti intuisi, tertanam dalam darah dan tulangmu. 
 Jadi, kamu melepaskan kewaspadaan, mencoba meminta bantuan kepada para pengawas tersembunyi ini: mencurahkan kebingungan dan keinginanmu kepada keberadaan yang samar itu, seolah-olah bercerita kepada seorang teman lama, sangat tulus.]]
  },
  Event_36752_Name = {
    Text = "Pengintai Baik"
  },
  Event_36874_ChoiceDesc1 = {
    Text = "[Ceritakan cerita menarik tentang sekolah] Mendapatkan Relik perak [(RelicConfig.Arg1)]"
  },
  Event_36874_ChoiceDesc2 = {
    Text = "[Belum Pernah Sekolah]mendapatkan 75 Segil hitam, terinfeksi[(Skill.Arg2)]"
  },
  Event_36874_Desc = {
    Text = [[
Saat melewati sebuah reruntuhan, mata Aurita tiba-tiba bersinar. 
"Nenek bilang, dulu ini adalah sekolah, tapi karena tidak ada siswa, sudah lama ditinggalkan!"
"Aurita tidak pernah sekolah, bagaimana denganmu, teman? Apakah kamu pernah ke sekolah?"]]
  },
  Event_36874_Name = {
    Text = "Kesenangan yang hilang"
  },
  Event_36875_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36875_Desc = {
    Text = "Setelah mendapatkan jawaban negatif darimu, Aurita menggelengkan kepalanya dengan murung. \n\"Ternyata, di luar sana juga tidak ada siswa… Lalu, untuk apa sekolah pertama kali dibangun?\""
  },
  Event_36875_Name = {
    Text = "Kesenangan yang hilang"
  },
  Event_36876_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36876_Desc = {
    Text = "\"Panti asuhan, tikus kecil, patung lilin… Bagus! Petualangan, ini petualangan!\"\nAurita berbicara, sementara sebuah tanda tanya tak terlihat muncul di atas kepalanya.\n\"Tapi, Nenek berkata sekolah adalah tempat yang akan membuat Aurita menjadi lebih pintar, tetapi…\"\nSebelum Aurita melanjutkan pemikirannya, kamu mendorongnya melewati belokan lain."
  },
  Event_36876_Name = {
    Text = "Kesenangan yang hilang"
  },
  Event_36877_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36877_Desc = {
    Text = "\"Kenapa? Kenapa?\"\nAurita terkejut olehmu, dia melanjutkan memberi perintah dengan wajah cemberut.\n\"Ini rumah Aurita, Aurita tahu, alun-alun—ada di dalam sana!\""
  },
  Event_36877_Name = {
    Text = "Kegelapan yang Tak Terlihat"
  },
  Event_36878_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36878_Desc = {
    Text = [[
"Aku tidak ingin melewati jalan ini, apakah Aurita tahu cara lain untuk pergi ke alun-alun?"
Aurita mengerucutkan bibirnya, merasa sedikit bingung, tapi akhirnya tetap menarik jubahmu dan mengarahkanmu ke arah lain.]]
  },
  Event_36878_Name = {
    Text = "Kegelapan yang Tak Terlihat"
  },
  Event_36879_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_36879_Desc = {
    Text = [[
Ini adalah mimpi, ini hanyalah mimpi.
Kamu terus-menerus mengingatkan dirimu sendiri, atau mungkin menghibur diri, sambil membawa Aurita masuk ke dalam kegelapan yang tak terlihat.]]
  },
  Event_36879_Name = {
    Text = "Kegelapan yang Tak Terlihat"
  },
  Event_36880_ChoiceDesc1 = {
    Text = "[Dengarkan dia] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_36880_ChoiceDesc2 = {
    Text = "[Menentangnya] Pilih 1 Pembangun untuk Bangun, terinfeksi [(Skill.Arg1)]"
  },
  Event_36880_ChoiceDesc3 = {
    Text = "[Diskusikan dengannya] Dapatkan 25 Segil hitam"
  },
  Event_36880_Desc = {
    Text = "Aurita menarik jubahmu, melangkah maju mengikuti jejak kakimu satu per satu. \n\"Eh… salah! Alun-alun ada di arah sana!\"\nKamu berbalik untuk melihat ke arah yang ditunjuk Aurita, lorong-lorong di Domain tampak begitu gelap gulita. D-lendir dan entitas bermutasi bergerak saling melilit, menyeret dunia nyata ke dalam Jurang kehancuran."
  },
  Event_36880_Name = {
    Text = "Kegelapan yang Tak Terlihat"
  },
  Event_37983_ChoiceDesc1 = {
    Text = "[Mendapatkan Dana] Mendapatkan Arg1 Segil hitam."
  },
  Event_37983_ChoiceDesc2 = {
    Text = "[Mendapatkan Dana] Mendapatkan Arg1 Segil Hitam[ExDesc1]."
  },
  Event_37983_Desc = {
    Text = "\"Tidak ada penguasa yang akan membiarkan orang asing datang tanpa alasan, apalagi seorang pendeta.\"\nRatu duduk di atas takhta yang tinggi, matanya tiba-tiba melintas sedikit kejam. \n\"Buktikan bahwa kau masih berguna, jika tidak…\"\nBerguna untuk apa? Kau melihat ke luar ladang yang tandus, sebuah pikiran tiba-tiba muncul: mungkin bisa menggunakan pengetahuan ekonomi yang telah dipelajari, membantu Wanda mengelola perkebunan? \nKau berusaha dengan susah payah di dalam otakmu yang tumpul—perlu diketahui bahwa di Mythag, ekonomi hanyalah kursus pilihan yang tidak penting… \nKesabaran habis. Ratu menguap. \n\"Sangat mengecewakan. Biarkan—\"\nTepat saat pedang jatuh, Adam Smith, Malthus, David Ricardo, dan arwah besar lainnya muncul di benak kecilmu. \nPembagian kerja! Pengenaan pajak! Populasi, sialan populasi! \nKau mungkin, mungkin ingat."
  },
  Event_37983_Name = {
    Text = "Perintah Rahasia"
  },
  Event_37984_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_37984_Desc = {
    Text = [[
Kamu mengajukan dekrit dengan nekat. 
Ratu melihatnya sekilas dan tersenyum dingin: 
"Jika ini tidak berguna, kau tahu apa yang akan terjadi."]]
  },
  Event_37984_Name = {
    Text = "Perintah Rahasia"
  },
  Event_37985_ChoiceDesc1 = {
    Text = "[Mengeluarkan dekrit] Memperoleh Relik perak [(RelicConfig.Arg1)]"
  },
  Event_37985_ChoiceDesc2 = {
    Text = "[Mengeluarkan dekrit] Memperoleh Relik terkutuk [(RelicConfig.Arg1)]"
  },
  Event_37985_ChoiceDesc3 = {
    Text = "[Mengeluarkan dekrit] Memperoleh Relik emas [(RelicConfig.Arg1)]"
  },
  Event_37985_Desc = {
    Text = [[
"Setelah menerima uangku, kau harus bekerja keras untukku."
Ratu menopang dagunya dengan satu tangan, memandangmu dengan santai.
Tak peduli apakah dia mengakuinya atau tidak, rasa penasarannya terhadap hal ini nyata adanya.
"Jadi, ceritakan padaku rencanamu, sang reformis besar."]]
  },
  Event_37985_Name = {
    Text = "Perintah Rahasia"
  },
  Event_38700_ChoiceDesc1 = {
    Text = "[Menghubungkan] Mengembalikan Arg2 poin Hidup[ExDesc1]."
  },
  Event_38700_ChoiceDesc2 = {
    Text = "[Meditasi] Pilih 1 Pembangun untuk Bangun."
  },
  Event_38700_ChoiceDesc3 = {
    Text = "[ Pengusiran ] Hapus maksimal 3 Kartu gejala, dapatkan Arg2 Segil hitam."
  },
  Event_38700_Desc = {
    Text = "Kamu menjelajahi dalam kabut, tiba-tiba, lencana sekolah di dada memancarkan cahaya perak yang lemah. Siapa yang memanggil dari sisi lain komunikator?"
  },
  Event_38700_Name = {
    Text = "Persimpangan"
  },
  Event_38700_Tips3 = {
    Text = "Saat ini tidak memiliki Kartu gejala"
  },
  Event_38707_ChoiceDesc1 = {
    Text = "[Mengusir Ilusi] Gejala infeksi."
  },
  Event_38707_ChoiceDesc2 = {
    Text = "[Menyerap Ilusi]Hilang Arg1 Hidup, mendapatkan Arg2 Segil Hitam"
  },
  Event_38707_ChoiceDesc3 = {Text = "[Keluar]"},
  Event_38707_Desc = {
    Text = "Wajah-wajah kabur tiba-tiba muncul, mengelilingi kamu dan merintih putus asa dengan suara yang seolah-olah tidak ada."
  },
  Event_38707_Name = {Text = "Ilusi"},
  Event_38715_ChoiceDesc1 = {
    Text = "[Mengeluarkan dekrit] Memperoleh Relik perak \"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\""
  },
  Event_38715_ChoiceDesc2 = {
    Text = "[Mengeluarkan dekrit] Memperoleh Relik terkutuk [(RelicConfig.Arg1)]"
  },
  Event_38715_ChoiceDesc3 = {
    Text = "[Mengeluarkan dekrit] Memperoleh Relik emas [(RelicConfig.Arg1)]"
  },
  Event_38715_Desc = {
    Text = [[
"Setelah menerima uangku, kau harus bekerja keras untukku."
Ratu menopang dagunya dengan satu tangan, memandangmu dengan santai.
Tak peduli apakah dia mengakuinya atau tidak, rasa penasarannya terhadap hal ini nyata adanya.
"Jadi, ceritakan padaku rencanamu, sang reformis besar."]]
  },
  Event_38715_Name = {
    Text = "Perintah Rahasia"
  },
  Event_40452_ChoiceDesc1 = {
    Text = "[Tanyakan Identitas] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_40452_ChoiceDesc2 = {
    Text = "[Keluar] 3 Kartu Perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_40452_Desc = {
    Text = [[
Tiga hantu menghalangi langkah maju.
Mereka berkumpul di sekitar meja judi, sepenuhnya fokus pada pergerakan dadu.
"Gulu, gulu."
Dadu dilempar dan jatuh berkali-kali tanpa henti.
Ini adalah permainan judi yang tak berujung.]]
  },
  Event_40452_Name = {
    Text = "Perjudian Tanpa Akhir"
  },
  Event_40453_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_40453_Desc = {
    Text = "\"Halo, kami masing-masing adalah suami pertama, kedua, dan ketiga Wanda.\"\n\"Apa? Kamu bertanya di mana suami keempatnya?\nHmm… sejujurnya, John agak kurang humor, jadi dia diubah oleh Nyonya menjadi pelayan buta.\"\n\"Kami semua menyesali kehilangannya. Tentu saja, hanya sedikit.\""
  },
  Event_40453_Name = {
    Text = "Perjudian Tanpa Akhir"
  },
  Event_40454_ChoiceDesc1 = {
    Text = "[Berjabat tangan dengannya] Secara acak membangunkan 1 Pembangun, terinfeksi [(Skill.Arg1)]"
  },
  Event_40454_ChoiceDesc2 = {
    Text = "[Pergi] Mendapatkan 1 dari 3 pilihan Orison"
  },
  Event_40454_Desc = {
    Text = [[
Saat melewati kandang, sebuah tangan menjulur keluar dari dalam. 
 "Jangan tinggalkan aku, Rebecca..."
Suara itu terdengar tua dan kering, seperti bellow yang sudah usang.]]
  },
  Event_40454_Name = {Text = "Tahanan"},
  Event_40455_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_40455_Desc = {
    Text = "Terasa lengket di telapak tangan — adalah D-lendir. \n Pemilik suara itu entah kapan sudah menghilang, menyembunyikan diri di balik bayangan suram di sudut."
  },
  Event_40455_Name = {Text = "Tahanan"},
  Event_40456_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_40456_Desc = {
    Text = [[
Kamu pergi begitu saja tanpa peduli, sehingga melewatkan kisah penuh drama di balik surat itu.
Tapi apa masalahnya?
Samudra yang luas, fajar dan senja, gurun di khatulistiwa...
Kamu akan bertemu lebih banyak, dan juga akan melewatkan lebih banyak.]]
  },
  Event_40456_Name = {
    Text = "Kepada istri tercinta"
  },
  Event_40457_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_40457_Desc = {
    Text = [[
Dalam arti tertentu, kau tidak berbeda dengan tahanan ini.
Sekarang bukan saatnya untuk membuat mereka waspada.
Kau mengabaikan permohonan tahanan itu, lalu berbalik dan pergi.]]
  },
  Event_40457_Name = {Text = "Tahanan"},
  Event_40458_ChoiceDesc1 = {
    Text = "[Mengoyak surat] Pilih 1 Relik yang berubah menjadi Relik terkutuk [(RelicConfig.Arg1)]"
  },
  Event_40458_ChoiceDesc2 = {
    Text = "[Mengabaikan surat] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_40458_ChoiceDesc3 = {
    Text = "[Surat Balasan] Mendapatkan 25 Segil Hitam"
  },
  Event_40458_Desc = {
    Text = "Ⅰ. Surat  John Cambrian kepada Wanda (2 tahun sebelum Aluvi)\n\nSuami berhak mengatur istrinya, setidaknya di Cambrian. \nTapi saya jelas meremehkan tingkat kegilaanmu. Sekarang kedua mataku hampir buta, dan keempat anggota tubuhku juga akan segera dipotong. \nAnak perempuan iblis. Anak perempuan iblis... tidak, kamu adalah iblis itu sendiri. \nAku mengutukmu@1 mengutukmu@2 mengutukmu mengutukmu..."
  },
  Event_40458_Name = {
    Text = "Kepada istri tercinta"
  },
  Event_40459_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_40459_Desc = {
    Text = [[
Kamu menggunakan cara yang paling sederhana untuk memecahkan kutukan. 
Tidak ada yang terjadi. Kertas itu jatuh ke tanah dengan tak bernyawa. 
Kamu mengangkat bahu dan pergi, namun entah kenapa merasa ada sesuatu yang tidak beres di dalam hati.]]
  },
  Event_40459_Name = {
    Text = "Kepada istri tercinta"
  },
  Event_40460_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_40460_Desc = {
    Text = "Kamu melewati meja judi dengan fokus penuh.\nSebelum pergi, para hantu berkata serempak:\n\"Tolong sampaikan salam kami kepada mantan istri kami yang sama — Nyonya Wanda.\""
  },
  Event_40460_Name = {
    Text = "Perjudian Tanpa Akhir"
  },
  Event_40461_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_40461_Desc = {
    Text = [[
Di bagian bawah kertas surat, kamu menulis balasan dengan rapi: 
"Kutukan telah diterima, semoga segalanya baik-baik saja."
Saat goresan terakhir selesai, api biru kehijauan yang marah menyala di atas kertas surat itu.
Kamu memperoleh abu.]]
  },
  Event_40461_Name = {
    Text = "Kepada istri tercinta"
  },
  Event_44187_ChoiceDesc1 = {
    Text = "[Menghadapi Kegelapan][ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc2 = {
    Text = "[Menghadapi Kegelapan][ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc3 = {
    Text = "[Menghindari Kegelapan] Mendapatkan Relik emas acak"
  },
  Event_44187_Desc = {
    Text = "Jiwa di depanmu tampak kotor dan suram — cahaya dan kegelapan ada bersamaan di dalamnya. Mereka berjuang untuk mendominasi, sementara jiwa itu sendiri tenggelam dalam kebingungan. \n\"Saya sangat bersimpati kepada mereka, orang-orang malang yang kehilangan segalanya, tapi bukankah dunia memang seperti ini?\"\n\"Ada yang mendapatkan, ada yang kehilangan.\"\n\"Haruskah aku menyerahkan kebahagiaanku demi kebahagiaan orang lain?\""
  },
  Event_44187_Name = {
    Text = "Kegelapan Dalam Diri"
  },
  Event_44188_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_44188_Desc = {
    Text = "\"Ini adalah dosaku, bebanku. Bagaimana aku bisa menyelamatkanmu, jiwa yang penuh kontradiksi?\""
  },
  Event_44188_Name = {
    Text = "Kegelapan Dalam Diri"
  },
  Event_44299_ChoiceDesc1 = {
    Text = "[Memohon kepada Uskup] Membersihkan Relik berdosa. Jika tidak ada Relik berdosa, mendapatkan Relik emas acak."
  },
  Event_44299_Desc = {
    Text = "\"Saya menipu dan memperdaya untuk mendapatkan kehidupan yang saya inginkan — uang menjadi angka, hidangan lezat menjadi makanan sehari-hari, dalam bisnis saya berkuasa mutlak, dalam politik saya tegas dan keras. Tapi kenapa, kenapa saya tidak bisa melupakan orang-orang itu, orang-orang yang telah kehilangan segalanya karena saya? Kenapa saya tidak bisa melupakan keputusasaan di wajah mereka?\n\" Alkohol hanya memberikan pelarian sesaat, jiwa saya tercabik-cabik, penderitaan hampir menenggelamkan saya.\n \"Apa yang harus saya lakukan?\""
  },
  Event_44299_Name = {
    Text = "Rasa Bersalah dan Pengampunan"
  },
  Event_44301_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_44301_Desc = {
    Text = [[
"Kamu berjalan di jalan penderitaan, kamu telah menyimpang dari kemuliaan Bapa. 
"Kembalilah, hai domba yang tersesat, dengarkan ajaran Bapa dan kembali ke jalan yang benar."]]
  },
  Event_44301_Name = {
    Text = "Rasa Bersalah dan Pengampunan"
  },
  Event_44395_ChoiceDesc1 = {
    Text = "[Mencari Bantuan Luar] Uskup menerima 1 Gejala milikmu, kamu mendapatkan Arg1 Segil hitam. Jika tidak ada gejala, langsung dapatkan Segil hitam."
  },
  Event_44395_ChoiceDesc2 = {
    Text = "[Berburu Darah] Uskup menerima 2 Gejala milikmu, kamu mendapatkan Orison [(EnchantConfig.Arg1)]."
  },
  Event_44395_ChoiceDesc3 = {
    Text = "[Meminta Lebih Banyak] Uskup menanggung lebih banyak gejala (setidaknya 4 kartu)"
  },
  Event_44395_Desc = {
    Text = [[
Jiwa yang samar membentuk siluet kabur, ia berlutut di depan sang Uskup memperlihatkan tubuhnya yang hancur dan hatinya yang tersisa hitam. 
"Kau memberiku bimbingan, memberiku pengampunan, memberiku penebusan, tapi Uskup yang penuh belas kasih, ini tidak cukup."
"Aku miskin dan sakit-sakitan. Nyawaku tergantung pada seutas benang, dan kau adalah satu-satunya penebusanku. Selamatkan aku, Uskup, biarkan aku tak lagi merasakan penderitaan."]]
  },
  Event_44395_Name = {
    Text = "Berkat Uskup"
  },
  Event_44396_ChoiceDesc1 = {
    Text = "[Berdiri dengan hormat dan pergi]"
  },
  Event_44396_Desc = {
    Text = "Uskup melepas cincinnya, lalu melepas brosnya. Batu permata biru yang melambangkan Bapa Surgawi diletakkan satu per satu di tangan Jiwa itu. Uskup membungkuk dan memegang kedua tangan Jiwa yang malang itu. \n\"Ambil semua emas dan perak dariku, ambil semua barang milikku — asalkan itu yang kau butuhkan. Aku sudah cukup hidup dengan ajaran Bapa Surgawi.\""
  },
  Event_44396_Name = {
    Text = "Berkat Uskup"
  },
  Event_44400_ChoiceDesc1 = {
    Text = "[Tenggelam dalam] Infeksi [(Skill.Arg1)], Bangun Pembangun acak"
  },
  Event_44400_ChoiceDesc2 = {Text = "[Menyerah]"},
  Event_44400_Desc = {
    Text = [[
Jiwa yang tersesat tidak mau menyerah pada kegelapan. 
 Kamu tahu apa yang menantinya. Kehidupan yang absurd akan segera dimulai, dan kamu adalah satu-satunya penonton.]]
  },
  Event_44400_Name = {
    Text = "Kegelapan Dalam Diri"
  },
  Event_44401_ChoiceDesc1 = {
    Text = "[Gerak Cepat] Mendapatkan Arg1 Segil Hitam"
  },
  Event_44401_ChoiceDesc2 = {
    Text = "[Sembarangan Mengambil] Dapatkan 1 dari 3 pilihan Orison tingkat lanjut, terinfeksi [(Skill.Arg1)]."
  },
  Event_44401_Desc = {
    Text = "Tanda hitam yang ditemukan di domain dapat dipersembahkan kepada D-marka untuk ditukar dengan relik atau proyeksi jiwa. Setelah meninggalkan area saat ini, itu akan segera menghilang menjadi lumpur hitam."
  },
  Event_44401_Name = {
    Text = "Segil hitam"
  },
  Event_44407_ChoiceDesc1 = {
    Text = "[Mengusir Ilusi] Gejala infeksi."
  },
  Event_44407_ChoiceDesc2 = {
    Text = "[Memeluk Ilusi]Mendapatkan 2 gejala acak, mendapatkan Arg1 Segil Hitam."
  },
  Event_44407_ChoiceDesc3 = {Text = "[Keluar]"},
  Event_44407_Desc = {
    Text = "Wajah-wajah kabur tiba-tiba muncul, mengelilingi kamu dan merintih putus asa dengan suara yang seolah-olah tidak ada."
  },
  Event_44407_Name = {Text = "Ilusi"},
  Event_44445_ChoiceDesc1 = {
    Text = "[Keluar] Mencari lampu sorot"
  },
  Event_44445_ChoiceDesc2 = {
    Text = "[Masuki Kabut] Kehilangan Arg2 poin Hidup"
  },
  Event_44445_ChoiceDesc3 = {
    Text = "[Meninggalkan Objek Lain]mengurangi 5 Segil hitam, mendapatkan 1 kartu[Inspirasi]"
  },
  Event_44445_Desc = {
    Text = [[
Di depan terdapat kabut hitam pekat, masuk secara sembrono akan mendatangkan Clades. 
 Mungkin kamu harus menemukan "Lampu Sorot"untuk mengusir kabut tersebut.]]
  },
  Event_44445_Name = {
    Text = "tidak dikenal"
  },
  Event_44469_ChoiceDesc1 = {
    Text = "[Meminta Daging dan Tulang] Uskup menanggung 4 Gejala milikmu, kamu mendapatkan pilihan 1 dari 3 Relik emas+."
  },
  Event_44469_ChoiceDesc2 = {
    Text = "[Meminta Berkat]Uskup menanggung 6 kartu gejala Anda, Anda mendapatkan 3 pilih 1 Pendulum waktu."
  },
  Event_44469_ChoiceDesc3 = {Text = "[Kembali]"},
  Event_44469_Desc = {
    Text = [[
Jiwa yang samar membentuk siluet kabur, ia berlutut di depan sang Uskup memperlihatkan tubuhnya yang hancur dan hatinya yang tersisa hitam. 
"Kau memberiku bimbingan, memberiku pengampunan, memberiku penebusan, tapi Uskup yang penuh belas kasih, ini tidak cukup."
"Aku miskin dan sakit-sakitan. Nyawaku tergantung pada seutas benang, dan kau adalah satu-satunya penebusanku. Selamatkan aku, Uskup, biarkan aku tak lagi merasakan penderitaan."]]
  },
  Event_44469_Name = {
    Text = "Berkat Uskup"
  },
  Event_44474_ChoiceDesc1 = {
    Text = "[Mengharapkan] Mendapatkan berkah dari Uskup"
  },
  Event_44474_ChoiceDesc2 = {
    Text = "[Mengharapkan] Mendapatkan berkah dari Uskup"
  },
  Event_44474_ChoiceDesc3 = {Text = "[Keluar]"},
  Event_44474_Desc = {
    Text = "\"Ini adalah dosaku, bebanku. Bagaimana aku bisa menyelamatkanmu, jiwa yang penuh kontradiksi?\""
  },
  Event_44474_Name = {
    Text = "Kegelapan Dalam Diri"
  },
  Event_44911_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_44911_Desc = {
    Text = [[
"Semua, semua... Ya, aku ingin semuanya...!"
Jiwa mengulurkan tangannya, mencoba dengan sia-sia meraih di udara.
Ia mendapatkan sesuatu, namun pada akhirnya tidak mendapatkan apa pun.]]
  },
  Event_44911_Name = {
    Text = "Apa yang kamu dapatkan"
  },
  Event_44913_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_44913_Desc = {
    Text = "\"Maka hanya yang terpenting saja, yang terpenting…\"\nJiwa berjongkok, menggali harapan yang terang dari tanah ilusi, dan meletakkannya di telapak tangan."
  },
  Event_44913_Name = {
    Text = "Apa yang kamu dapatkan"
  },
  Event_44916_ChoiceDesc1 = {
    Text = "[Raih Semuanya] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_44916_ChoiceDesc2 = {
    Text = "[Belajar untuk melepaskan] 3 kartu perintah acak mendapatkan orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_44916_Desc = {
    Text = [[
Jiwa yang redup tenggelam dalam penderitaan.
Ia berputar-putar di tempat, bingung dengan semua pilihan dan konsekuensinya.
"Apa yang harus aku pilih?" bisiknya pelan, "Apa yang harus aku lakukan?"
"Bagaimana aku bisa memiliki semuanya?"]]
  },
  Event_44916_Name = {
    Text = "Apa yang kamu dapatkan"
  },
  Event_44919_ChoiceDesc1 = {
    Text = "[Introspeksi Diri] Bangun 1 Pembangun secara acak, terinfeksi [(Skill.Arg1)]"
  },
  Event_44919_ChoiceDesc2 = {
    Text = "[Melihat orang lain] Mendapatkan 1 dari 3 Orison"
  },
  Event_44919_Desc = {
    Text = [[
Jiwa yang melayang terjebak dalam dilema.
Ia berhenti, ragu di antara keinginan-keinginannya.
"Apa yang harus aku pilih?" bisiknya pelan, "Apa yang harus aku lakukan?"
"Mana yang sebenarnya aku inginkan?"]]
  },
  Event_44919_Name = {
    Text = "Apa yang kamu inginkan"
  },
  Event_44920_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_44920_Desc = {
    Text = [[
"Kamu benar, aku harus melihat, aku harus melihat..."
Ia menundukkan kepala, kedua tangannya meraba ke dalam dadanya, lalu mengeluarkan sebuah jantung yang ilusif: satu sisinya hitam pekat seperti tinta, sisi lainnya terang benderang seperti bintang.]]
  },
  Event_44920_Name = {
    Text = "Apa yang kamu inginkan"
  },
  Event_44921_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_44921_Desc = {
    Text = [[
"Benar, benar... orang lain bisa menjadi cermin... aku harus melihat..."
Ia mendekat ke arahmu, memandangmu dengan wajah tanpa fitur. 
"Kenapa kamu tidak merasa kesulitan? Sangat iri, sangat iri..."]]
  },
  Event_44921_Name = {
    Text = "Apa yang kamu inginkan"
  },
  Event_44998_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_44998_Desc = {
    Text = [[
"Mereka berkata, penderitaan saat ini hanya sementara, setelah mati kita akan menikmati kebahagiaan abadi dalam pelukan Bapa. 
"Aku tidak ingin menunggu sampai mati."
Bayangan dengan rakus melahap segalanya, jiwa menjadi redup, hampir menyatu dengan kegelapan di sekitarnya. 
Kau ingin melakukan sesuatu, namun tak berdaya."]]
  },
  Event_44998_Name = {
    Text = "Kegelapan Dalam Diri"
  },
  Event_45000_ChoiceDesc1 = {
    Text = "[Berdiri dengan hormat dan pergi]"
  },
  Event_45000_Desc = {
    Text = "Uskup menggunakan mata pisaunya untuk memotong telapak tangannya, darah yang menetes di atas tablet berubah menjadi cahaya biru penyembuhan, mengisi kembali darah yang hilang dari jiwanya. \n \"Ambil darahku, isi hidupmu — jika itu yang kau butuhkan. Inilah yang diharapkan Bapa agar aku lakukan.\""
  },
  Event_45000_Name = {
    Text = "Berkat Uskup"
  },
  Event_45001_ChoiceDesc1 = {
    Text = "[Berdiri dengan hormat dan pergi]"
  },
  Event_45001_Desc = {
    Text = [[
Uskup mengeluarkan jiwanya dari dalam rongga dada. Titik cahaya yang hangat menyatu ke dalam Tablet, berubah menjadi cahaya biru penyembuhan, mengisi semua retakan pada Jiwa. 
"Terimalah, ini adalah pemberian dari Bapa Surgawi, bukti cinta-Nya. Semoga Tubuhmu sehat dan Jiwa-mu utuh, tidak lagi menderita apa pun."]]
  },
  Event_45001_Name = {
    Text = "Berkat Uskup"
  },
  Event_45002_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_45002_Desc = {
    Text = "Kamu melangkah menuju wajah-wajah itu, dan saat membuka mata kembali, pandangan di depanmu telah tenggelam dalam kegelapan. Hanya suara tawa dari sumber yang tidak jelas terdengar bergema di sekitarmu."
  },
  Event_45002_Name = {Text = "Ilusi"},
  Event_45036_ChoiceDesc1 = {
    Text = "[Hapus Semua Relik]"
  },
  Event_45036_Desc = {
    Text = "\"Ini adalah dosaku, bebanku. Bagaimana aku bisa menyelamatkanmu, jiwa yang penuh kontradiksi?\""
  },
  Event_45036_Name = {
    Text = "Kegelapan Dalam Diri"
  },
  Event_45196_ChoiceDesc1 = {
    Text = "[Berdiri dengan hormat dan pergi]"
  },
  Event_45196_Desc = {
    Text = "Uskup menggunakan mata pisaunya untuk mencungkil daging dan tulang, tulang yang pucat serta daging merah menyatu ke dalam tablet, berubah menjadi cahaya biru penyembuhan, melengkapi kembali jiwa yang patah. \n \"Ambil daging dan tulangku, isi tubuhmu yang hilang—jika itu yang kau butuhkan. Inilah yang diharapkan oleh Bapa Pencipta agar aku lakukan.\""
  },
  Event_45196_Name = {
    Text = "Berkat Uskup"
  },
  Event_46144_ChoiceDesc1 = {
    Text = "[Keluar] Dapatkan 1 dari 3 pilihan Relik perak, terinfeksi [(Skill.Arg1)]"
  },
  Event_46144_Desc = {
    Text = [[
Bayangan manusia yang samar-samar perlahan menjadi jelas, itu bukan Tubuh yang terlulur, juga bukan Clades, melainkan Clementine tanpa sayap, dengan ekspresi wajah yang tenang seperti biasa. 
 "Benar-benar kebetulan, apakah kamu juga datang untuk menikmati cahaya bulan?" dia berkata sambil tersenyum, namun kamu merasakan pusing yang luar biasa, "Pada malam berembun tebal, kamu harus lebih berhati-hati." 
 "Makhluk-makhluk kecil di sini, tidak begitu tenang."]]
  },
  Event_46144_Name = {
    Text = "Bayangan di dalam kabut"
  },
  Event_46145_ChoiceDesc1 = {
    Text = "[Pergi] Dapatkan 1 dari 3 pilihan Relik emas, terinfeksi [(Skill.Arg1)]"
  },
  Event_46145_Desc = {
    Text = "Kamu tetap tenang. Tiba-tiba, seorang wanita bangsawan naik ke atas panggung. \nDia dengan Kegilaan membuka mulut anak itu dan memasukkan tongkat kayu di tangannya dengan keras. \n\"Berbicara, berbicaralah padaku.\" \nDarah hitam mengalir dari mulut anak itu. Dia melanjutkan membaca dengan suara yang tidak jelas. \n\"Lagu untuk ibu…\""
  },
  Event_46145_Name = {
    Text = "Upacara Penutupan III"
  },
  Event_47309_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_47309_Desc = {
    Text = [[
Pada hari itu, Tuhan akan menghukum orang Perishite dengan pedang-Nya yang keras dan kuat,
karena dosa pembunuhan yang telah mereka "lakukan".
Apa? Kamu bilang ini tidak adil?
Tidak, inilah takdir predator.]]
  },
  Event_47309_Name = {Text = "Lagu Laut"},
  Event_47310_ChoiceDesc1 = {
    Text = "[Lanjutkan Mendengarkan] memperoleh Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_47310_ChoiceDesc2 = {
    Text = "[Pergi] 1 Kartu perintah acak mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_47310_Desc = {
    Text = [[
Tuhan berkata: Sebut dia Orang Filistin.
Biarkan dia memikul tanggung jawab pembunuhan, biarkan dia membawa kutukan keserakahan.
Biarkan jalannya bersinar, membuat orang berpikir tentang jurang seperti rambut putih.
Di lautan yang luas, tidak ada hiu raksasa yang lebih megah dari ini.
Biarkan dia ditakuti dan dihormati oleh semua makhluk,
sampai saat pengadilan tiba.]]
  },
  Event_47310_Name = {Text = "Lagu Laut"},
  Event_47311_ChoiceDesc1 = {
    Text = "[Keluar] Infeksi [(Skill.Arg1)]"
  },
  Event_47311_ChoiceDesc2 = {
    Text = "[Keluar] Infeksi [(Skill.Arg1)]"
  },
  Event_47311_ChoiceDesc3 = {
    Text = "[Keluar] Infeksi [(Skill.Arg1)]"
  },
  Event_47311_Desc = {
    Text = [[
Anak laki-laki adalah budak yang hina. 
Tuannya memperlakukannya seperti ayah dan anak, namun dibunuh dengan ditusuk di atas tempat tidur. 
"Aku mencintaimu, Ayah. Aku hanya tidak ingin menjadi budak lagi." 
Kemudian, anak itu berdiri di depan makam "ayahnya", mengingat perkataan pendeta: 
<Small: Jangan tinggalkan tanah kelahiranmu. 
Pada saat itu, kedua tanganmu akan penuh dengan darah, dan kamu akan mati tanpa harga diri. 
Anjing liar, burung nasar, dan ikan laut akan membencimu.>
Anak bernama Igren akhirnya tetap pergi. 
Dia akan menulis cerita terkenal yang mengerikan miliknya sendiri.]]
  },
  Event_47311_Name = {
    Text = "Anak dalam tong"
  },
  Event_47312_ChoiceDesc1 = {
    Text = "[Membalik halaman ke depan] Mendapatkan Relik perak [(RelicConfig.Arg1)], pilih untuk menginfeksi gejala sebanyak 1 kali."
  },
  Event_47312_ChoiceDesc2 = {
    Text = "[Geser halaman ke belakang] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_47312_ChoiceDesc3 = {
    Text = "[Mem buang] Mendapatkan 25 Segil hitam"
  },
  Event_47312_Desc = {
    Text = "Kamu menemukan sebuah buku yang dijilid dengan kertas papirus: \n......\nAnak laki-laki itu bersembunyi di dalam tong kayu, mengapung menuju pulau kecil milik orang Filistin. \nDia lemah, rendah, dan penuh ambisi. \nKetika cahaya kebesaran raksasa abadi membuat semua orang terpesona, \nhanya anak laki-laki itu yang bersembunyi dalam bayangan, tidak membiarkan cahaya itu mendekat sedikit pun. \nKemudian, dia diberikan tugas penting oleh Goliath. \nSebagai alasan—"
  },
  Event_47312_Name = {
    Text = "Anak dalam tong"
  },
  Event_47313_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_47313_Desc = {
    Text = [[
Raksasa melanjutkan: 
"Aku meletakkannya di sisiku karena dia murung dan juga menggelikan. 
Dan dia tidak akan pernah bisa membunuhku."]]
  },
  Event_47313_Name = {
    Text = "Anak dalam tong"
  },
  Event_47314_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_47314_Desc = {
    Text = [[
Kamu tidak mendengar bagian berikutnya, tetapi liriknya mengingatkanmu pada lagu lain:
"Hiu raksasa yang langka ini, berada di tengah badai,
lautan adalah rumahnya,
karena kekuasaan adalah kebenaran, ia adalah raksasa kekuasaan,
raja lautan yang tak berujung."]]
  },
  Event_47314_Name = {Text = "Lagu Laut"},
  Event_47315_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_47315_Desc = {
    Text = [[
Sekarang bukanlah waktu yang tepat untuk membaca. 
 Kamu terburu-buru melemparkan buku, tidak sempat melihat isi terakhirnya: 
 ...... 
 Dia bersembunyi dalam bayangan bukan karena cemburu. 
 Tetapi murni karena ketakutan. 
 Begitu berdiri di bawah cahaya, jiwa yang hina itu akan sepenuhnya terhapus. 
 Bahkan abu pun tidak akan tersisa.]]
  },
  Event_47315_Name = {
    Text = "Anak dalam tong"
  },
  Event_47463_ChoiceDesc1 = {
    Text = "[Masuk ke dalam hipnosis] Tentukan satu Pembangun untuk membuatnya mengalami pemisahan roh, kehilangan empat Kartu perintah awal."
  },
  Event_47463_Desc = {
    Text = [[
Dokter mengangkat kepalanya dari tumpukan buku yang tebal:
"Kau adalah sampel yang langka, jadi aku tidak akan memungut biaya darimu.
Tapi aku memerlukan imbalan lain: sebuah hipnosis.
Ini adalah metode pengobatan baru yang membawa kesadaran yang sepenuhnya terbuka dan telanjang.
Bagaimana, mau mencoba?"]]
  },
  Event_47463_Name = {
    Text = "Ular Hipnotis"
  },
  Event_47464_ChoiceDesc1 = {
    Text = "[Memori yang Berkilauan][ExDesc1][ExDesc2]"
  },
  Event_47464_ChoiceDesc2 = {
    Text = "[Memori Pudar] Tingkatkan semua Orison Paduan dalam dek menjadi Orison Paduan Tingkat Lanjut"
  },
  Event_47464_Desc = {
    Text = [[
Dia berkeliaran di pantai lautan kesadaran.
Rok ombak menjilati kakinya, mengantarkan memori yang tersebar ke tepian.
Beberapa bersinar, beberapa redup, dan beberapa bahkan berbau seperti musim hujan Londinium.
Kamu memilih untuk mengambil memori mana? Dia berkeliaran di pantai lautan kesadaran.]]
  },
  Event_47464_Name = {
    Text = "\"Fusi Utama\""
  },
  Event_47465_ChoiceDesc1 = {
    Text = "[Menolak Mencoba] 1 Kartu perintah acak mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_47465_ChoiceDesc2 = {
    Text = "[Memecahkan Solvent] Membersihkan Relik Berdosa"
  },
  Event_47465_ChoiceDesc3 = {
    Text = "[Menerima Eksperimen] Mendapatkan 1 Pendulum Waktu [(RelicConfig.Arg1)]"
  },
  Event_47465_Desc = {
    Text = [[
Dokter menggoyangkan larutan berwarna hijau zamrud, dengan penuh semangat memberitahunya: 
"Minumlah seteguk, dan kamu akan memasuki mimpi yang jernih. 
Ini adalah manifestasi kekuatan pikiran dari alam bawah sadar kolektif. 
Sekarang, kamu akan berbagi lautan kesadaran yang sama dengan ribuan makhluk hidup, 
Mau mencobanya?"]]
  },
  Event_47465_Name = {
    Text = "\"Mimpi Jernih\""
  },
  Event_47466_ChoiceDesc1 = {
    Text = "[Mendapatkan suara] 1 Kartu perintah Pembangun pemisahan roh"
  },
  Event_47466_Desc = {
    Text = [[
Tubuh adalah penjara, yang mengurung kepribadian-kepribadian yang tercerai-berai.
Penjara bernama "24" kini penuh sesak.
"Jangan tertidur, jangan bersikap tenang."
Dalam kegelapan, sebuah suara berbisik pelan.]]
  },
  Event_47466_Name = {
    Text = "\"Kesadaran Diri\""
  },
  Event_47848_ChoiceDesc1 = {
    Text = "[Tutup kedua mata] Dapatkan pilihan 1 dari 3 Relik emas"
  },
  Event_47848_ChoiceDesc2 = {
    Text = "[Melirik sekilas] Pilih 2 Pembangun untuk dibangunkan, dan kurangi Lelah Aritmetika kartu bangun mereka sebesar 1."
  },
  Event_47848_ChoiceDesc3 = {
    Text = "[Membuka mata] Mendapatkan relik perak \"(RelicConfig.Arg1)\", \"(RelicConfig.Arg2)\", \"(RelicConfig.Arg3)\""
  },
  Event_47848_Desc = {
    Text = "Sebelum memasuki hipnotis, Dokter berkata: \n\"Tanpa izin saya, jangan buka mata.\"\nLalu dia menutup matanya erat-erat, menarik napas… menghembuskan napas… \nDi antara sadar dan tidak sadar, dia merasa mendengar suara desisan \"siss\". \nKemudian dia merasakan pandangan dingin menyelimutinya — \nAda sesuatu yang sedang mengamati dia. \nHaruskah dia membuka matanya dan melihat diam-diam?"
  },
  Event_47848_Name = {
    Text = "Ular Hipnotis"
  },
  Event_47876_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_47876_Desc = {
    Text = [[
Dia membungkuk dan mengambil memori yang berkilauan. 
Satu, dua... begitu banyak kebahagiaan datang bertubi-tubi, 
dia membuka kedua tangannya dan mulai berputar-putar dengan mereka di sekelilingnya.]]
  },
  Event_47876_Name = {
    Text = "\"Fusi Utama\""
  },
  Event_47877_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_47877_Desc = {
    Text = "Dia membungkuk memungut kenangan yang redup.\nSatu, dua… tak terhitung hal-hal hina berdatangan silih berganti,\nDia membuka kedua lengannya, memeluk semuanya ke dalam dekapan."
  },
  Event_47877_Name = {
    Text = "\"Fusi Utama\""
  },
  Event_47878_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_47878_Desc = {
    Text = [[
Kamu menolak menjadi korban dari pelarut-pelarut aneh ini. 
 Dokter terlihat sedikit kecewa, tetapi dia tidak memaksamu. 
 "Saya memaafkan kepengecutan dan pandangan sempit manusia."]]
  },
  Event_47878_Name = {
    Text = "\"Mimpi Jernih\""
  },
  Event_47879_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_47879_Desc = {
    Text = [[
Bruk! Kamu menghancurkan botol itu dengan satu pukulan. 
Larutan berwarna hijau dengan cepat melarutkan lantai. 
"Bagus, dorongan yang tidak terkendali. Tapi aku harap jangan ada lain kali. 
Kalau tidak, aku akan sedih sampai menangis karenanya."]]
  },
  Event_47879_Name = {
    Text = "\"Mimpi Jernih\""
  },
  Event_47880_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_47880_Desc = {
    Text = [[
Kamu meneguknya sekali. 
Glug glug... otak dan tenggorokanmu dipenuhi gelembung yang tak terhitung jumlahnya. 
Seperti kembang api kecil yang berderak. 
"Puji dirimu, manusia pemberani. Kamu akan memiliki kesempatan untuk menyentuh ketakterbatasan. 
Dan aku, akan menjadi saksi dari ketakterbatasan itu."]]
  },
  Event_47880_Name = {
    Text = "\"Mimpi Jernih\""
  },
  Event_47881_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_47881_Desc = {
    Text = [[
Dia membuka kedua matanya dan berkata: 
"Ya, semua ini memang tidak benar. 
Seharusnya menangis, seharusnya melawan."
Di kegelapan terdengar suara gemerisik, dia mendapat tanggapan yang penuh kebaikan.]]
  },
  Event_47881_Name = {
    Text = "\"Kesadaran Diri\""
  },
  Event_47900_ChoiceDesc1 = {
    Text = "[Melihat ular] Mendapatkan Relik emas + [(RelicConfig.Arg1)]"
  },
  Event_47900_ChoiceDesc2 = {
    Text = "[Melihat kamu] mendapatkan Relik negatif [(RelicConfig.Arg1)]"
  },
  Event_47900_Desc = {
    Text = [[
Plak. 
Sebuah jentikan jari yang lembut menariknya kembali ke kenyataan. 
Dokter entah sejak kapan sudah mendekatkan wajahnya, mata berwarna kobalt-kuning itu menyipit penuh semangat. 
"Ceritakan padaku, apa yang kamu lihat barusan?"]]
  },
  Event_47900_Name = {
    Text = "Ular Hipnotis"
  },
  Event_47901_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_47901_Desc = {
    Text = "Dia membuka kedua matanya. \n Di antara cahaya dan bayangan yang samar, dia seolah melihat seekor ular raksasa putih yang tenang melingkar dan bergerak perlahan di dalam kegelapan. \n Oh, dan juga matanya— \n itu adalah warna emas yang murni tanpa sedikit pun kotoran. \n Tanpa kesedihan dan tanpa kegembiraan, tanpa penilaian apa pun, \n cukup untuk membangunkan tupai dari mimpi buruk musim panasnya."
  },
  Event_47901_Name = {
    Text = "Ular Hipnotis"
  },
  Event_47909_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_47909_Desc = {
    Text = [[
Dia diam-diam membuka satu matanya.
Pandangan matanya tertuju pada sebuah bayangan putih kabur yang bergerak perlahan di tengah kegelapan.
Sekelebat cahaya emas pucat melintas di dalam bayangan itu, seakan-akan memberi peringatan atas pelanggarannya.
Dia tidak berani melanjutkan pandangannya.]]
  },
  Event_47909_Name = {
    Text = "Ular Hipnotis"
  },
  Event_47910_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_47910_Desc = {
    Text = [[
Dia dengan patuh mengikuti nasihat Dokter, tak pernah membuka matanya sedikit pun. 
 Udara dingin menyapu udara di sekitarnya, lama berhenti di wajahnya. 
 Entah berapa lama telah berlalu, segalanya kembali seperti biasa. 
 Seolah-olah tidak ada yang pernah terjadi.]]
  },
  Event_47910_Name = {
    Text = "Ular Hipnotis"
  },
  Event_47911_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_47911_Desc = {
    Text = [[
"Aku melihat... seekor ular yang sangat indah."
Tangan Dokter yang memegang pulpen berhenti sejenak.
"Ular seperti apa?"
"Sangat indah! Tubuhnya berwarna putih dengan pola emas di atasnya..."
Dokter tidak berkata apa-apa lagi, sudut bibirnya terangkat sedikit, hampir tak terlihat.
"Terima kasih."]]
  },
  Event_47911_Name = {
    Text = "Ular Hipnotis"
  },
  Event_47912_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_47912_Desc = {
    Text = [[
Dia menatap lurus ke dalam mata berwarna kobalt kuning Dokter. 
"Aku melihatmu berubah menjadi seekor ular."
"Oh. Kenapa kamu yakin itu aku?"
Karena itu misterius, diam, rumit. 
Dan... 
Itu terlihat sangat lelah, seolah baru saja bangun dari hibernasi selama ribuan tahun.]]
  },
  Event_47912_Name = {
    Text = "Ular Hipnotis"
  },
  Event_47992_ChoiceDesc1 = {
    Text = "[Menghubungkan] Mengembalikan Arg2 poin Hidup."
  },
  Event_47992_ChoiceDesc2 = {
    Text = "[Meditasi] Pilih 1 Pembangun untuk Bangun."
  },
  Event_47992_ChoiceDesc3 = {
    Text = "[ Pengusiran ] Hapus maksimal 3 Kartu gejala, dapatkan Arg2 Segil hitam."
  },
  Event_47992_Desc = {
    Text = "Kamu menjelajahi dalam kabut, tiba-tiba, lencana sekolah di dada memancarkan cahaya perak yang lemah. Siapa yang memanggil dari sisi lain komunikator?"
  },
  Event_47992_Name = {
    Text = "Persimpangan"
  },
  Event_47992_Tips3 = {
    Text = "Saat ini tidak memiliki Kartu gejala"
  },
  Event_47993_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_47993_ChoiceDesc2 = {
    Text = "[Keluar] Secara acak, 1 Kartu Perintah mendapatkan Orison: [(EnchantConfig.Arg1)]dan menyalin 1 versi asli dari kartu tersebut."
  },
  Event_47993_Desc = {
    Text = "Kamu menerima permintaan kontak dari sekolah, suara yang familiar membuatmu merasa tenang. Kamu mengumpulkan Roh dan melanjutkan langkah."
  },
  Event_47993_Name = {
    Text = "Persimpangan"
  },
  Event_48225_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_48225_Desc = {
    Text = [[
Kucing itu dengan senang menjilat punggung tanganmu. 
"Terima kasih, tidak perlu bersedih untukku, meong. 
Kepribadian di sini selalu mati dan dilahirkan kembali. 
Aku pasti akan kembali! 
Meong meong, meong meong meong!"]]
  },
  Event_48225_Name = {
    Text = "Surat Wasiat"
  },
  Event_48226_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_48226_Desc = {
    Text = "Kucing merasa kamu tidak memahami maksudnya, lalu dengan manja menggesekkan kepalanya ke punggung tanganmu. \n\"Asalkan kamu mau menyetujui aku, aku akan memberikan semua camilan rahasia milikku padamu. \nMereka disimpan dengan baik di Distrik Cambria @2…\""
  },
  Event_48226_Name = {
    Text = "Surat Wasiat"
  },
  Event_48227_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_48227_Desc = {
    Text = "Kamu menyampaikan permintaan maaf yang tulus kepada George.\n\"Hmph, kamu masih termasuk orang yang mengerti etika.\nGeorge akan mempertimbangkan untuk mengurangi kekuatan kutukan sebesar 10%,\npaling banyak 15% — ini adalah batas bawah George.\""
  },
  Event_48227_Name = {
    Text = "Hantu George"
  },
  Event_48228_ChoiceDesc1 = {
    Text = "[Setujui itu] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_48228_ChoiceDesc2 = {
    Text = "[Tolak itu] Dapatkan 1 dari 3 pilihan Relik emas, terinfeksi [(Skill.Arg1)]"
  },
  Event_48228_ChoiceDesc3 = {
    Text = "[Membisu] mendapatkan Relik perak [(RelicConfig.Arg1)]"
  },
  Event_48228_Desc = {
    Text = [[
"Kucing 24"mengalami luka parah, ia berjuang untuk memberitahumu: 
"Uuh, hidupku tidak akan lama lagi meong. 
Aku punya seorang teman, dia adalah ikan cod perak meong. 
Jika suatu hari kamu bertemu dengannya, katakan bahwa aku pergi jauh meong. 
Akan meninggalkan untuk waktu yang sangat lama meong. 
Akan membawakan banyak kentang goreng tanpa ikan goreng untuknya meong. 
Pastikan kamu memberitahunya ya!"]]
  },
  Event_48228_Name = {
    Text = "Surat Wasiat"
  },
  Event_48229_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_48229_Desc = {
    Text = [[
Kucing itu merasa sedikit kecewa.
Namun, ia selalu menjadi kucing yang penurut dan baik, tak pernah memaksa orang lain.
Akhirnya, dengan rasa penyesalan, ia menutup matanya.]]
  },
  Event_48229_Name = {
    Text = "Surat Wasiat"
  },
  Event_48230_ChoiceDesc1 = {
    Text = "[Mintanya maaf] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_48230_ChoiceDesc2 = {
    Text = "[Mengejeknya] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_48230_ChoiceDesc3 = {
    Text = "[Abaikan itu] Dapatkan 25 Segil hitam"
  },
  Event_48230_Desc = {
    Text = "Hantu, hantu George mengambang di atas kalian. \n\"George mati tanpa martabat. \nTapi tidak masalah, George akan selalu mengingat penghinaan ini. \nPenjaga, kau akan mendapat masalah besar, hmmm…\""
  },
  Event_48230_Name = {
    Text = "Hantu George"
  },
  Event_48231_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_48231_Desc = {
    Text = "\"Haha, berani sekali mengolok-olok George. \nTenang saja, saat kau makan, tidur, bernyanyi… \nGeorge akan selalu melayang-layang di sekitarmu, mengingatkanmu, menyiksamu. \nAgar kau selalu mengingat dosa-dosamu. \nKau takkan pernah bisa menangkap hantu, lalala~\""
  },
  Event_48231_Name = {
    Text = "Hantu George"
  },
  Event_48232_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_48232_Desc = {
    Text = "Kamu melangkah maju dengan mantap, meninggalkan kutukan George di belakang.\nTerdengar isakan dari belakang, ternyata George menangis tersedu-sedu.\n\"Hiks hiks… aku yang begitu menggemaskan, pantatmu—\nJijik! Jijik!\nGeorge lebih memilih mati di bawah cambuk Pandia!\""
  },
  Event_48232_Name = {
    Text = "Hantu George"
  },
  Event_49055_ChoiceDesc1 = {
    Text = "[Bangun Pembangun] Kurangi semua Pembangun sebesar 100 Aliemus, hapus 1 Kartu gejala"
  },
  Event_49055_ChoiceDesc2 = {
    Text = "[Melawan dengan sekuat tenaga] Pulihkan Arg1 poin Hidup, infeksi 2 kartu [(Skill.Arg2)]"
  },
  Event_49055_ChoiceDesc3 = {
    Text = "[Memasukkan Kunci perak] Mengosongkan semua Energi-s"
  },
  Event_49055_Desc = {
    Text = [[
Kolam noda darah yang samar-samar menampakkan wujud aslinya saat kamu melangkah ke atasnya. 
 Noda darah berwarna merah-hitam itu menjulurkan tak terhitung jumlahnya lengan, merayap di pergelangan kakimu, terus naik memanjat, dengan niat menarikmu ke dalam jurang yang tak terduga.]]
  },
  Event_49055_Name = {
    Text = "Bassin Darah"
  },
  Event_49097_ChoiceDesc1 = {Text = "[Maju]"},
  Event_49097_Desc = {
    Text = "Di dalam rongga perut terasa seperti badai mengamuk, beberapa detik kemudian secara ajaib kembali tenang. Entah mengapa, seolah-olah kamu mendengar detak jantung lain berdenyut di dalam tubuhmu..."
  },
  Event_49097_Name = {
    Text = "Ibu penyayang"
  },
  Event_49098_ChoiceDesc1 = {
    Text = "[Teguk Sekaligus] Pilih [ExDesc3][ExDesc4] Kartu perintah agar mendapatkan Orison: [(EnchantConfig.Arg1)][ExDesc1][ExDesc2]"
  },
  Event_49098_Desc = {
    Text = [[
Guci tanah liat yang usang memandangmu dari celah sempit di dinding batu yang rendah. 
Sumber air adalah Inventaris paling berharga di gurun, sedangkan alkohol adalah pemicu dunia Kegilaan dan halusinasi. 
Di daerah tandus ini, seseorang yang masih waras akan sulit menolak ajakannya.]]
  },
  Event_49098_Name = {
    Text = "Ibu penyayang"
  },
  Event_49312_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_49312_Desc = {
    Text = "Cahaya redup dari kunci perak berkilauan, lengan-lengan itu seolah-olah terkejut oleh semacam kekuatan, satu per satu masuk ke dalam kolam air, lalu menghilang tak terlihat."
  },
  Event_49312_Name = {
    Text = "Bassin Darah"
  },
  Event_49313_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_49313_Desc = {
    Text = [[
Kamu berjuang keras, namun semakin terjerat, dan bisikan seperti kutukan bergema di dalam pikiranmu. 
 Saat sadar kembali, tentakel-tentakel berwarna darah itu telah surut dengan puas. Kamu merasa tubuhmu segar, namun secara samar-samar, ada sesuatu yang hilang dalam dirimu...]]
  },
  Event_49313_Name = {
    Text = "Bassin Darah"
  },
  Event_49314_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_49314_Desc = {
    Text = "Awakener yang datang tanpa ragu menarikmu keluar dari Bassin Darah, lengan yang terhubung denganmu robek, lumpur keruh berceceran, di air banyak makhluk yang sulit dibedakan oleh mata, seolah mendambakan dan melahap sesuatu."
  },
  Event_49314_Name = {
    Text = "Bassin Darah"
  },
  Event_49867_ChoiceDesc1 = {
    Text = "Bangun acak Pembangun ditambah 50 Aliemus"
  },
  Event_49867_Name = {Text = "Acara"},
  Event_49907_ChoiceDesc1 = {
    Text = "[Memeriksa Kebenaran]"
  },
  Event_49907_ChoiceDesc2 = {
    Text = "[Permintaan Usapan]"
  },
  Event_49907_Desc = {
    Text = [[
"Kamu selalu menatap tandukku dengan rasa penasaran, ada sesuatu yang ingin ditanyakan?"
Thais tiba-tiba mendekatkan dirinya ke bahumu, manik-manik berwarna madu bergoyang-goyang lembut menyentuh pipimu.]]
  },
  Event_49907_Name = {
    Text = "Orang dengan tanduk"
  },
  Event_49908_ChoiceDesc1 = {
    Text = "[Melihat ke atas]"
  },
  Event_49908_ChoiceDesc2 = {
    Text = "[Menuju Thais]"
  },
  Event_49908_Desc = {
    Text = "Debu dan asap berhamburan di reruntuhan, di luar jendela yang pecah di sudut ruangan, tiba-tiba muncul sosok Thais. Tanpa ragu ia membungkuk di ambang jendela yang penuh debu, lalu menunjuk ke arah balok atap dengan misterius."
  },
  Event_49908_Name = {
    Text = "Orang Penyelinap"
  },
  Event_49909_ChoiceDesc1 = {
    Text = "[Keluar] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_49909_Desc = {
    Text = [[
Kamu menengadah, pipa tembaga yang berkarat menjalar ke segala arah, seperti jaring laba-laba raksasa yang menutupi di atas kepala. Sebuah bayangan melintas, apakah itu kucing liar yang mencari makanan atau monster yang bersembunyi di balik bayangan? 
 Ketika menoleh lagi, Thais juga sudah menghilang.]]
  },
  Event_49909_Name = {
    Text = "Orang Penyelinap"
  },
  Event_49910_ChoiceDesc1 = {
    Text = "[Memandanginya]"
  },
  Event_49910_ChoiceDesc2 = {
    Text = "[Memanggilnya]"
  },
  Event_49910_Desc = {
    Text = [[
Kamu melihat "Fatamorgana" itu lagi.
Kali ini, kamu sudah mengetahui namanya.
Thais berdiri di bawah Pohon ibu yang jauh, dengan khusyuk berdoa kepada pohon tersebut.
Siluetnya samar-samar, seolah menyatu dengan bayangan Pohon ibu.]]
  },
  Event_49910_Name = {
    Text = "Pembuat keinginan"
  },
  Event_49911_ChoiceDesc1 = {
    Text = "[Keluar] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_49911_Desc = {
    Text = [[
Kamu memandang jauh sosok Thais, siluetnya dalam badai seperti hari kiamat tampak seperti sebuah puncak suci yang megah, meskipun badai pasir mengamuk, tidak sedikit pun mengurangi kewibawaannya. 
 Langkahnya lambat namun mantap, posturnya yang mulia dan tak terjamah membuatmu terpesona.]]
  },
  Event_49911_Name = {
    Text = "Orang Abadi"
  },
  Event_49912_ChoiceDesc1 = {
    Text = "[Keluar] Pilih untuk menyalin 1 Kartu Perintah"
  },
  Event_49912_Desc = {
    Text = [[
"Apa menurutmu?"
Dia mengucapkan "shh", lalu membungkukkan tubuhnya lebih dekat. Kamu merasakan ujung tanduknya sudah menyentuh pipimu, dengan sensasi dingin dan sedikit gatal...]]
  },
  Event_49912_Name = {
    Text = "Orang dengan tanduk"
  },
  Event_49913_ChoiceDesc1 = {
    Text = "[Pergi] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_49913_Desc = {
    Text = "\"Kalau mau menyentuh, katakan saja dengan terus terang. Apakah aku akan menolakmu?\"\nDia tertawa kecil sambil menarik tanganmu, sentuhan ujung jarinya terasa hangat dan licin, membuatmu hampir ingin tenggelam dalam sensasi itu…"
  },
  Event_49913_Name = {
    Text = "Orang dengan tanduk"
  },
  Event_49914_ChoiceDesc1 = {
    Text = "[Keluar] Pilih 1 Pembangun untuk di-Bangun, kurangi biaya kartu Bangun sebesar 1, dan infeksi [(Skill.Arg1)]"
  },
  Event_49914_Desc = {
    Text = [[
Kamu bersama dengan yang lainnya berlutut di tanah.
"Aku tahu, aku tahu, Yang Mulia, Yang Mulia selalu melindungi kita!"
Tangisan kegembiraan bercampur dengan teriakan panjang dan deru angin, beresonansi di rongga kepalamu.
Secara samar-samar, ada pikiran penting yang berkelebat, namun tak bisa ditangkap.]]
  },
  Event_49914_Name = {
    Text = "Orang Abadi"
  },
  Event_49915_ChoiceDesc1 = {
    Text = "[Keluar] Dapatkan 1 dari 3 pilihan Relik perak, terinfeksi [(Skill.Arg1)]"
  },
  Event_49915_Desc = {
    Text = [[
Kamu melambaikan tangan padanya. 
"Apa yang kamu lakukan?"Ramona menatapmu dengan rasa penasaran. 
"Di sana..."
Kalimat itu belum selesai terucap, sosok wanita di kejauhan sudah menghilang. 
Apakah ini hanya ilusi?]]
  },
  Event_49915_Name = {
    Text = "Orang yang menyiram air"
  },
  Event_49916_ChoiceDesc1 = {
    Text = "[Menanggapi dia]"
  },
  Event_49916_ChoiceDesc2 = {Text = "[Keraguan]"},
  Event_49916_Desc = {
    Text = [[
Dari kejauhan, seorang wanita terlihat sedang mengambil air di tepi sungai.
Sepertinya dia menyadari tatapanmu, lalu berbalik dan melambaikan tangan ke arahmu.
Kamu memperhatikan bahwa cara dia berbalik tampak agak aneh.]]
  },
  Event_49916_Name = {
    Text = "Orang yang menyiram air"
  },
  Event_49917_ChoiceDesc1 = {
    Text = "[Pergi] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison [(EnchantConfig.Arg1)]"
  },
  Event_49917_Desc = {
    Text = [[
Saat kamu ragu-ragu, wanita itu tiba-tiba berbalik dan melompat ke dalam oasis, lalu menghilang. 
 Kamu hampir tidak bisa mempercayai mata sendiri... Apakah dia memiliki kuku seperti kambing?]]
  },
  Event_49917_Name = {
    Text = "Orang yang menyiram air"
  },
  Event_49918_ChoiceDesc1 = {
    Text = "[Pergi] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison [(EnchantConfig.Arg1)]"
  },
  Event_49918_Desc = {
    Text = "\"Wahai pohon, dengarkanlah Keinginan @1, aku akan mandi dalam susumu dan lahir Kembali, menjadi Eksekutormu, berjalan di antara pasir kuning untukmu, membiarkan akar-akarmu Mencapai setiap sudut Lemvahi…\"\n\nDoa-doa lugu yang sahut-menyahut bergema di dalam ruangan."
  },
  Event_49918_Name = {
    Text = "Pembuat keinginan"
  },
  Event_49919_ChoiceDesc1 = {
    Text = "[Pergi] Bangun 1 Pembangun secara acak"
  },
  Event_49919_Desc = {
    Text = [[
Pandangan Thais yang penuh dengan kebingungan telah menarik perhatianmu, suatu kekuatan aneh membuatmu tanpa sadar terpesona. Kamu seperti ditarik, tak tertahankan untuk mendekatinya. 
"Sebenarnya, hal-hal yang tak terlihat tetap ada."
Dia berbisik lembut di telingamu, kamu merasa sedikit tercerahkan, namun seperti diselimuti kabut tipis, sulit dipahami dengan jelas. 
Apakah ini semacam ramalan? Dalam sekejap, Thais sudah menghilang tanpa jejak.]]
  },
  Event_49919_Name = {
    Text = "Orang Penyelinap"
  },
  Event_49920_ChoiceDesc1 = {Text = "[Melihat]"},
  Event_49920_ChoiceDesc2 = {
    Text = "[Merangkak]"
  },
  Event_49920_Desc = {
    Text = [[
Kuku hitam domba melangkah di atas tanah berpasir yang diterpa angin. 
 Thais melantunkan doa tak dikenal, ribuan orang Aram bersujud menghadap arahnya saat ia melangkah menyusuri pasir.]]
  },
  Event_49920_Name = {
    Text = "Orang Abadi"
  },
  Event_49921_ChoiceDesc1 = {
    Text = "[Pergi] Dapatkan 1 dari 3 pilihan Relik emas, terinfeksi [(Skill.Arg1)]"
  },
  Event_49921_Desc = {
    Text = [[
Pohon raksasa menjulur ribuan cabang yang kekar, seperti anggota tubuh yang melilit, mengikat pergelangan tangan dan pergelangan kaki Thais dengan erat, tanpa menghiraukan perjuangannya, secara kasar memasukkan tubuhnya ke dalam rongga batang pohon yang membesar...

Meskipun hanya bayangan yang jauh, penderitaannya tetap mencapai hatimu seiring dengan getaran gelombang air.]]
  },
  Event_49921_Name = {
    Text = "Pembuat keinginan"
  },
  Event_49922_ChoiceDesc1 = {
    Text = "[Peroleh] Relik [(RelicConfig.Arg1)]"
  },
  Event_49922_Desc = {
    Text = "Anggota tubuh yang lemas mengalir bersama getah pohon melalui cabang-cabangnya. Dia berusaha sepenuhnya untuk melawan, namun anggota tubuhnya seperti ulat yang terseret dan terpelintir, tidak menuruti perintah.\n\"Tulangnya sudah sepenuhnya larut,\"sudut mata Thais dipenuhi kesedihan, \"Dia sudah menjadi bagian dari pohon itu.\"\n\"Kami membutuhkan kekuatan untuk membalikkan ini… kekuatan yang melampaui waktu.\""
  },
  Event_49922_Name = {
    Text = "Orang Berkarat"
  },
  Event_49923_ChoiceDesc1 = {
    Text = "[Keluar] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_49923_Desc = {
    Text = [[
"Dan, entah mengapa, 'Mata buta yang terbalik' itu memiliki daya tarik yang sangat kuat dari dalam diriku..."
"Ah, sedang membicarakan aku?"
"Medinate sedang memuji kemampuanmu bercerita."

Di malam ketika api unggun itu perlahan menyala, dia pernah menuangkan segelas anggur untukmu.]]
  },
  Event_49923_Name = {
    Text = "Orang Berkarat"
  },
  Event_49924_ChoiceDesc1 = {
    Text = "[Membelah Tumor Pohon]"
  },
  Event_49924_ChoiceDesc2 = {Text = "[Kenangan]"},
  Event_49924_Desc = {
    Text = [[
Sebuah tumor pohon. 
Itu berdenyut jahat dan bengkak, dengan kulit tipis berwarna darah yang rapuh memperlihatkan wajah yang ganas dan kesakitan di baliknya, seolah-olah siap untuk menembus keluar kapan saja. 
"Medinate."Thais memanggil nama wajah itu dengan nada sedih, namun penuh kelembutan.]]
  },
  Event_49924_Name = {
    Text = "Orang Berkarat"
  },
  Event_49939_ChoiceDesc1 = {
    Text = "[Percaya Pada Ryker]semua Pembangun memulihkan Arg1 Aliemus"
  },
  Event_49939_ChoiceDesc2 = {
    Text = "[Kekhawatiran Ryker] Pilih untuk membangun 2 Pembangun"
  },
  Event_49939_Desc = {
    Text = "\"Percayalah pada keberuntunganku.\""
  },
  Event_49939_Name = {
    Text = "Detektif Beruntung"
  },
  Event_49940_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_49940_Desc = {
    Text = [[
Ryker hanya ahli dalam tiga hal: pengintaian, mendengarkan, dan melempar dadu.
Dengan kata lain, dia tidak terlalu mahir dalam pertempuran.
Kekhawatiran di hatimu sulit dibendung, kegilaan terus tumbuh.]]
  },
  Event_49940_Name = {
    Text = "Detektif Beruntung"
  },
  Event_49941_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_49941_Desc = {
    Text = "Hati yang percaya adalah sihir; dia pasti bisa mengatasi semua rintangan di hadapannya."
  },
  Event_49941_Name = {
    Text = "Detektif Beruntung"
  },
  Event_49943_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_49943_Desc = {
    Text = [[
Kamu merasa sangat malu, namun tetap memandang penuh harap kepada Ramona yang masih sakit. 
"Aku yang akan melakukannya."
Dia memerah, mengeluarkan botol pengumpul baru dari tas tangannya yang tampaknya memiliki kapasitas tak terbatas, lalu dengan cepat menutup laba-laba itu.]]
  },
  Event_49943_Name = {
    Text = "Laba-laba beracun"
  },
  Event_49944_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_49944_Desc = {
    Text = [[
Ryker menjentikkan jarinya, lalu mengulurkan jari telunjuknya yang berbulu ke arah laba-laba besar yang mengangkat kakinya tinggi-tinggi. 
 Spesies yang bercorak cerah seperti ini biasanya sangat berbisa. Kamu baru saja ingin mengingatkannya untuk berhati-hati, tetapi laba-laba yang sebelumnya terlihat bermusuhan itu dengan lincah melompat ke persendian jarinya dan meringkuk. 
 Sudahlah, setiap orang memiliki takdir masing-masing.]]
  },
  Event_49944_Name = {
    Text = "Laba-laba beracun"
  },
  Event_49945_ChoiceDesc1 = {
    Text = "[Lihat ke arah Ramona] Dapatkan 3 pilihan, pilih 1 Orison"
  },
  Event_49945_ChoiceDesc2 = {
    Text = "[Lihat ke arah Ryker] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_49945_Desc = {
    Text = [[
Mata majemuk saling memandangmu. 
 Pemilik mata majemuk mundur selangkah, menggerakkan tangan dan kakinya untuk mengancammu. 
 Dari langkah tinggi dan kaki serta anggota tubuh yang menopang badan, ini memang merupakan makhluk arachnida yang langka. 
 Sebelum berangkat, nasihat Czort masih terngiang di telinga: "Tugas tambahan, harap kumpulkan sampel spesies lokal dan simpan di stasiun survei setempat." 
 Kamu menggoyangkan botol pengumpul di dalam ranselmu, setelah berminggu-minggu perjalanan, botol itu sudah penuh dengan serangga.]]
  },
  Event_49945_Name = {
    Text = "Laba-laba beracun"
  },
  Event_49946_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_49946_Desc = {
    Text = "\"Keserakahan yang tidak memperhitungkan waktu adalah sebuah penyakit.\""
  },
  Event_49946_Name = {Text = "Jawabanmu"},
  Event_49947_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_49947_Desc = {
    Text = "\"Mengikuti teks secara kaku tidak akan membuatmu disukai, Nak.\""
  },
  Event_49947_Name = {Text = "Jawabanmu"},
  Event_49948_ChoiceDesc1 = {
    Text = "[Kunci Emas] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_49948_ChoiceDesc2 = {
    Text = "[Kunci Besi] Dapatkan 1 dari 3 Relik emas, terinfeksi [(Skill.Arg1)]"
  },
  Event_49948_ChoiceDesc3 = {
    Text = "[Kunci perak] Mendapatkan Relik perak [(RelicConfig.Arg1)]"
  },
  Event_49948_Desc = {
    Text = [[
Pada tengah hari, uap air dari Sungai Suci berkondensasi menjadi dua fatamorgana. 
 Suara samar fatamorgana bertanya kepadamu: Apakah ini kunci emas, kunci perak, atau kunci besi yang jatuh darimu?]]
  },
  Event_49948_Name = {Text = "Jawabanmu"},
  Event_49949_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_49949_Desc = {
    Text = "\"Kejujuran sering kali membawa hasil yang lebih pasti, namun di saat yang sama, mungkin kamu juga akan kehilangan sesuatu.\""
  },
  Event_49949_Name = {Text = "Jawabanmu"},
  Event_50013_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50013_Desc = {
    Text = [[
Kamu memperhatikan dengan seksama, tetapi wajah orang itu mengambang mengikuti gelombang air, kabur dan tidak jelas. 

 Semakin kamu menatap dengan penuh perhatian, napasmu semakin terhambat, otakmu merasakan sensasi halusinasi akibat kekurangan oksigen, hingga mendengar suara Ramona memanggil namamu, yang membuatmu terseret kembali ke kenyataan. 
 Matahari yang terpantul di permukaan air sangat menyilaukan, tetapi di bawah permukaan air sepertinya ada sesuatu yang berkilau.]]
  },
  Event_50013_Name = {
    Text = "Phantom Kematian"
  },
  Event_50014_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50014_Desc = {
    Text = [[
Fatamorgana langsung runtuh, di tanganmu tak ada apa-apa, hanya rasa nyeri yang menyengat tiba-tiba meledak di pelipis.
Matahari yang menyilaukan dipantulkan di permukaan air, namun sepertinya ada sesuatu yang berkilauan di bawah permukaan.]]
  },
  Event_50014_Name = {
    Text = "Phantom Kematian"
  },
  Event_50015_ChoiceDesc1 = {
    Text = "[Usaha mengenali] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_50015_ChoiceDesc2 = {
    Text = "[Mencapai dan menyentuh] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_50015_ChoiceDesc3 = {
    Text = "[Mengucek mata] Mendapatkan 25 Segil Hitam"
  },
  Event_50015_Desc = {
    Text = [[
Kamu didorong oleh Nubia, setengah kakimu terjebak di dalam Sungai Suci. 
 Kamu berusaha keras untuk menjaga keseimbangan, tetapi di dalam gelombang air yang bergetar, kamu melihat bayangan yang seharusnya tidak terlihat. 
 Itu adalah seorang pemuda yang mengenakan seragam Universitas Mythag, tubuhnya yang lemas terbenam di dalam aliran Sungai Suci.]]
  },
  Event_50015_Name = {
    Text = "Phantom Kematian"
  },
  Event_50016_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50016_Desc = {
    Text = [[
Kepanikan menggerogoti pikiranmu, rasa sakit membuat kesadaran menjadi kabur, kamu berusaha keras merobeknya, tetapi tanaman merambat semakin menekan, rongga hidungmu dipenuhi cairan lengket yang mengeluarkan bau aneh, setiap napas membawa keputusasaan yang kental. 
 Ramona menusukkan pedangnya, Nubia melarikan diri dengan satu kaki yang putus, kamu merobek tentakel terakhir yang menempel di sisi wajahmu, dan ternyata ada lapisan daging yang kabur menempel di situ.]]
  },
  Event_50016_Name = {
    Text = "Angin menerpa wajah"
  },
  Event_50017_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50017_Desc = {
    Text = [[
Cahaya perak menusuk tubuh Nubia, rasa daging yang meledak mengalir melalui kunci perak hingga ujung jari dan pergelangan tanganmu. 
 Tentakel Nubia yang terdistorsi terangkat tinggi ke langit, mengeluarkan jeritan yang menakutkan dan menyedihkan, seluruh tubuhnya berubah menjadi cairan tidak jelas yang kental.]]
  },
  Event_50017_Name = {
    Text = "Angin menerpa wajah"
  },
  Event_50018_ChoiceDesc1 = {
    Text = "[Mengoyak] Mendapatkan Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_50018_ChoiceDesc2 = {
    Text = "[Menembus] 1 Kartu perintah acak mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_50018_Desc = {
    Text = "Tentakel Nubia yang berbentuk gulungan bergerak dengan liar, menyusup ke wajahmu dan dengan ganas menyerbu masuk ke mulut serta hidungmu."
  },
  Event_50018_Name = {
    Text = "Angin menerpa wajah"
  },
  Event_50019_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50019_Desc = {
    Text = [[
Hanya ada cahaya berkilauan di permukaan air. 
 Kamu mengangkat kakimu yang basah dan menuangkan pasir lembap dari sepatumu. 
 Bayangan tadi masih terus terngiang di pikiranmu, tak kunjung hilang.]]
  },
  Event_50019_Name = {
    Text = "Phantom Kematian"
  },
  Event_50029_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50029_Desc = {
    Text = [[
"Apakah dia akan kembali? Ataukah dia akan meninggalkanmu selamanya di lautan pasir yang tak berujung ini?"
"Apakah dia bisa menemukanmu? Atau akankah dia tersesat karena perubahan arah angin dan bukit pasir yang terus bergerak?"
"Harapan yang kau letakkan pada orang lain, apakah benar-benar seandal itu?"]]
  },
  Event_50029_Name = {
    Text = "Pantai Pasir Terdampar"
  },
  Event_50030_ChoiceDesc1 = {
    Text = "[Mencari Bantuan] Secara acak membangunkan 1 Pembangun, terinfeksi [(Skill.Arg1)]"
  },
  Event_50030_ChoiceDesc2 = {
    Text = "[Maju Bersama] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_50030_Desc = {
    Text = [[
Sebuah suara kuno dan jauh bercampur dengan gemericik air mengalir mengajukan pertanyaan kepadamu. 
"Kamu tersesat di tengah lautan pasir yang luas."
"Di hadapanmu ada dua pilihan. Temanmu memiliki kecepatan lebih, biarkan dia membawa makanan dan air untuk mencari bantuan, sementara kamu tetap tinggal dengan Lelah seminimal mungkin."
"Atau kalian berbagi segalanya dan terus maju."]]
  },
  Event_50030_Name = {
    Text = "Pantai Pasir Terdampar"
  },
  Event_50031_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50031_Desc = {
    Text = [[
"Kalian mungkin tidak bisa melangkah lebih jauh, tetapi jiwa dan raga kalian erat bersatu, mendapatkan kekuatan untuk saling menginspirasi dari sana."
"Inilah pilihanmu."
Saat dia berbicara, matahari yang menyengat di langit tinggi menutup matanya.]]
  },
  Event_50031_Name = {
    Text = "Pantai Pasir Terdampar"
  },
  Event_50064_ChoiceDesc1 = {
    Text = "[Memotong pita merah] Hapus 1 Kartu Perintah, dapatkan Arg1 Segil Hitam"
  },
  Event_50064_ChoiceDesc2 = {
    Text = "[Melawan] Salin 1 Kartu Perintah, infeksi [(Skill.Arg1)]"
  },
  Event_50064_ChoiceDesc3 = {
    Text = "[Panggil Ramona] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_50064_Desc = {
    Text = "Casiah melemparkan kain merah, yang seketika melilit koper Anda."
  },
  Event_50064_Name = {
    Text = "Seda yang Berantakan"
  },
  Event_50065_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50065_Desc = {
    Text = [[
Suara ketukan renyah yang terputus-putus berputar naik turun di antara pipa-pipa yang bersilangan di atas kepalamu, seperti hantu yang menari sendirian, mengayunkan kedua tangannya yang lemah di ruang sunyi ini. 
 Khayalan ini memanggil rasa takut kuno yang membawa dingin menusuk ke dalam hatimu.]]
  },
  Event_50065_Name = {
    Text = "Skala Sinister"
  },
  Event_50066_ChoiceDesc1 = {
    Text = "[Mengeksplorasi di mulut gua] Memperoleh Relik perak [(RelicConfig.Arg1)]"
  },
  Event_50066_ChoiceDesc2 = {
    Text = "[Masuk ke dalam gua] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_50066_Desc = {
    Text = [[
"Di sini ada gua batu."
Thais mengundangmu dengan berdiri menyamping. 
"Mau masuk dan lihat?"
Gua batu yang sempit itu gelap dan dalam, seperti mulut raksasa iblis, menjulur ke dalam kegelapan tanpa akhir. Siapa pun yang melangkah ke tanah tandus ini, tidak akan bisa melepaskan firasat buruk yang merayap dari tulang belakang mereka. Seolah-olah di setiap sudut gua ini, bersembunyi makhluk-makhluk kuno yang takut pada cahaya matahari, menunggu kedatangan para penyusup.]]
  },
  Event_50066_Name = {Text = "Gua Gelap"},
  Event_50067_ChoiceDesc1 = {
    Text = "[Satu per satu dihancurkan] 1 Relik perak acak ditingkatkan menjadi Relik emas [(RelicConfig.Arg1)]"
  },
  Event_50067_ChoiceDesc2 = {
    Text = "[Mengelilingi dua orang] memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_50067_ChoiceDesc3 = {
    Text = "[Menguping Percakapan] Mendapatkan 25 Segil Hitam"
  },
  Event_50067_Desc = {
    Text = [[
Dua orang Aram berjaga di pintu gerbang pabrik. 
Salah satunya dengan santai berkeliling, mencoba mengajak yang lain berbicara. 
"Ada yang bilang, Nyonya Juliette sedang menghitung jumlah tim yang berusaha menembus Dinding Badai lagi."
"Aku benar-benar tidak boleh terpilih."]]
  },
  Event_50067_Name = {
    Text = "Pengawal Gerbang yang Santai"
  },
  Event_50067_Tips1 = {
    Text = "Belum memiliki Relik perak"
  },
  Event_50068_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50068_Desc = {
    Text = [[
Tidak melihat, tidak mendengar, tidak berpikir. 
Tanpa membayangkan dari mana datangnya nada yang tidak pantas itu, kamu langsung menuju ke lokasi kerangka Pohon Ibu.]]
  },
  Event_50068_Name = {
    Text = "Skala Sinister"
  },
  Event_50069_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50069_Desc = {
    Text = "Ramona menusuk Casiah yang sedang melambaikan kain merah, Casiah buru-buru menghindar, kain merah yang melilitmu juga terlepas dalam sekejap."
  },
  Event_50069_Name = {
    Text = "Seda yang Berantakan"
  },
  Event_50070_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50070_Desc = {
    Text = [[
Kalian terbagi menjadi dua tim, kamu dan Ramona dari kiri, Ryker dari kanan, menyerang dari kedua sisi.
Kamu mengangkat tangan sebagai isyarat, Ramona dan Ryker langsung bertindak, dua Penjaga Aran jatuh tanpa suara.]]
  },
  Event_50070_Name = {
    Text = "Pengawal Gerbang yang Santai"
  },
  Event_50071_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50071_Desc = {
    Text = "Saat ini tidak tepat untuk terlalu dalam masuk ke jebakan. Hanya dengan berkeliaran di mulut gua, kalian hampir bisa merasakan denyutan jahat yang tersembunyi dalam detak batu."
  },
  Event_50071_Name = {Text = "Gua Gelap"},
  Event_50072_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50072_Desc = {
    Text = [[
Di bawah isyaratmu, Ryker melemparkan dadu dan membuat penjaga Arlan yang terdiam pingsan, lalu diam-diam mendekati yang lainnya yang masih terus berbicara tanpa henti. 
"Hei, teman, kalau Juliette yang katamu itu penipu, apa yang akan kamu lakukan?"
"Aku juga tidak tahu harus berbuat apa."
Ryker menyeringai senang, si penjaga gemetar hebat, dan tepat saat dia hendak berteriak, Ryker menutup mulut dan hidungnya.]]
  },
  Event_50072_Name = {
    Text = "Pengawal Gerbang yang Santai"
  },
  Event_50073_ChoiceDesc1 = {
    Text = "[Mendengarkan dengan Seksama] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_50073_ChoiceDesc2 = {
    Text = "[Tutup telinga] Untuk setiap Pembangun dengan nilai Aliemus 50 atau lebih, dapatkan 15 Segil hitam."
  },
  Event_50073_ChoiceDesc3 = {
    Text = "[Lihat] Dapatkan 1 dari 3 Orison"
  },
  Event_50073_Desc = {
    Text = "Ketika kalian memasuki lantai tempat kerangka berada, suara merdu dan nyaring tiba-tiba terdengar di pabrik tua yang kosong. Kesan dingin dari permainan piano sangat kontras dengan reruntuhan besi yang berkarat."
  },
  Event_50073_Name = {
    Text = "Skala Sinister"
  },
  Event_50074_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50074_Desc = {
    Text = [[
"Hei, saudara, jika Juliette yang terhormat itu adalah penipu, apa yang akan kau lakukan?"
"Jangan bicara sembarangan, sejak Juliette tiba, segalanya telah diatur dengan baik. Jika dia penipu, kenapa dia membantu orang Aram begitu banyak?"
Di tengah percakapan mereka, Ryker diam-diam memilih tempat untuk bersembunyi, dua dadu melesat keluar dengan suara berdebum, menjatuhkan keduanya ke tanah.]]
  },
  Event_50074_Name = {
    Text = "Pengawal Gerbang yang Santai"
  },
  Event_50075_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50075_Desc = {
    Text = [[
Kamu mengumpulkan keberanian untuk menatap balik. 
Mata raksasa di tirai tiba-tiba menyeringai dengan gerakan yang mengerikan, keteguhanmu mengalami guncangan dan akhirnya runtuh.]]
  },
  Event_50075_Name = {Text = "Mata Ajaib"},
  Event_50076_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50076_Desc = {
    Text = [[
Kamu dengan fokus penuh merobek tirai itu. 
Mata raksasa di bawah tanganmu berubah menjadi sepotong kain yang hancur dan kehilangan kesan tiga dimensi.]]
  },
  Event_50076_Name = {Text = "Mata Ajaib"},
  Event_50077_ChoiceDesc1 = {
    Text = "[Mendapatkan tatapan balik] Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_50077_ChoiceDesc2 = {
    Text = "[Tear the Curtain] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_50077_Desc = {
    Text = [[
Tirai terbuka, menampakkan banyak mata raksasa yang terdistorsi. 
 Monster besar yang bersembunyi di balik pupil mata tersebut memperlihatkan rasa haus yang luar biasa dan mulai bergerak dengan gelisah.]]
  },
  Event_50077_Name = {Text = "Mata Ajaib"},
  Event_50078_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50078_Desc = {
    Text = "Ternyata, sebuah komponen berbentuk batang yang sudah dibuang bergoyang karena getaran dari gerakan kalian, lalu dengan tidak stabil memukul pipa besi."
  },
  Event_50078_Name = {
    Text = "Skala Sinister"
  },
  Event_50079_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50079_Desc = {
    Text = [[
Thais melangkah tenang ke dalam gua batu, sementara kamu mengikuti di belakangnya dengan hati-hati menjelajahi.
"Hati-hati!"Kamu tiba-tiba ditarik dan jatuh duduk dalam pelukan yang lembut. Di depan kalian, seekor monster raksasa hitam melesat keluar dari gua dengan kecepatan luar biasa.
"Lihat ini,"kata Thais saat kamu masih gemetar karena ketakutan, matanya berkilauan dengan cahaya redup di kegelapan, "Mungkin ini adalah hartanya."]]
  },
  Event_50079_Name = {Text = "Gua Gelap"},
  Event_50080_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50080_Desc = {
    Text = [[
Kamu berusaha keras menarik gagang koper, melawan kain merah itu. 
Namun, kain merah itu sangat kuat, koper terlepas dari genggamanmu dan barang-barangmu menyebar di tanah.]]
  },
  Event_50080_Name = {
    Text = "Seda yang Berantakan"
  },
  Event_50081_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50081_Desc = {
    Text = [[
Kamu membenci perasaan terikat. 
Kamu menarik kain merah itu, dan dengan suara "jrrr" kamu merobeknya menjadi dua bagian. 
Sisa setengah dari kain merah itu bergerak seperti ular merah yang meliuk-liuk.]]
  },
  Event_50081_Name = {
    Text = "Seda yang Berantakan"
  },
  Event_50276_ChoiceDesc1 = {
    Text = "[Menghilangkan Korban] Mendapatkan Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_50276_ChoiceDesc2 = {
    Text = "[Lepaskan Tali] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_50276_ChoiceDesc3 = {
    Text = "[Lanjutkan Maju] Dapatkan 50 Segil Hitam"
  },
  Event_50276_Desc = {
    Text = [[
Tiga orang Aram terikat di atas panggung tinggi.
Di tubuh mereka muncul pola garis gelap seperti kulit pohon yang pernah kau lihat pada bayi, sementara mereka mengucapkan kata-kata tanpa henti.]]
  },
  Event_50276_Name = {
    Text = "tiga persembahan"
  },
  Event_50277_ChoiceDesc1 = {
    Text = "[Gaze] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_50277_ChoiceDesc2 = {
    Text = "[Mengabaikan] Mendapatkan 3 pilihan 1 Orison"
  },
  Event_50277_Desc = {
    Text = [[
Aram berlutut di tengah badai pasir.
Badai menghantam tubuh mereka, pasir menyapu habis kesalehan mereka.
Di dalam pusaran debu, seolah-olah ada banyak mata raksasa yang mengamati tanah yang terdistorsi.]]
  },
  Event_50277_Name = {
    Text = "Gigante Pasir dan Debu"
  },
  Event_50278_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50278_Desc = {
    Text = [[
Gambar yang tidak ingin kau ingat kembali muncul di depan mata.
Tentakel yang bergoyang-goyang, jejak darah yang mengalir akibat pecahan kaca...
Kau merasa mual.]]
  },
  Event_50278_Name = {
    Text = "Perjalanan Sendirian II"
  },
  Event_50279_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50279_Desc = {
    Text = [[
Dia tidak di sini, dia tidak berada di tengah pusaran yang paling berbahaya.
Itu sudah cukup untuk membuatmu merasa tenang.]]
  },
  Event_50279_Name = {
    Text = "Perjalanan Sendirian I"
  },
  Event_50280_ChoiceDesc1 = {
    Text = "[Serangan Mendadak] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_50280_ChoiceDesc2 = {
    Text = "[Serangan] 3 Kartu Perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_50280_Desc = {
    Text = [[
Seekor Nubia berjuang dalam badai pasir yang sangat kencang.
Keempat kakinya tertanam dalam-dalam di pasir kuning, berusaha keras untuk tidak terseret ke dalam pusaran.]]
  },
  Event_50280_Name = {
    Text = "Badai Pasir Alam"
  },
  Event_50281_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50281_Desc = {
    Text = [[
Dengan tegas kau menerobos masuk, di tengah teriakan kaget orang-orang Aram, kau menarik tali itu terbuka. 
Seorang prajurit Aram mencoba mendekat, kau dengan cepat merebut tombak dari tangannya dan mengarahkannya ke kerumunan yang gelap.]]
  },
  Event_50281_Name = {
    Text = "tiga persembahan"
  },
  Event_50282_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50282_Desc = {
    Text = [[
Akalmu memberitahumu bahwa dia tidak akan datang. 
Ya, siapa yang mengharapkan seorang penjudi menepati janji? 
Kamu hanya bisa merasa kesepian. Kamu hanya memiliki kesepian.]]
  },
  Event_50282_Name = {
    Text = "Perjalanan Sendirian III"
  },
  Event_50283_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50283_Desc = {
    Text = [[
Apakah demam tinggi yang tidak biasa itu akan memburuk dengan kebangkitan kembali Pohon Ibu?
Bisakah Ramona menjaga dirinya sendiri di luar Dinding Badai?
Sekarang bukan waktunya untuk teralihkan, tapi kamu tidak bisa menahan kekhawatiran terhadap rekanmu.]]
  },
  Event_50283_Name = {
    Text = "Perjalanan Sendirian I"
  },
  Event_50284_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50284_Desc = {
    Text = [[
Kamu bertekad menghadapinya secara langsung, namun Nubia justru seolah menemukan pijakan yang langka, meloncat dan meraih kepalamu. 
 Kamu terjebak dalam pusaran badai pasir dan jeratan ganda dari Nubia. 
 "Hanya keberanian brutal bukanlah cara untuk menang," suara dingin William terdengar seperti kabar baik dari surga di telingamu yang tersumbat, "Pelajari cara memanfaatkan kesempatan."]]
  },
  Event_50284_Name = {
    Text = "Badai Pasir Alam"
  },
  Event_50285_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50285_Desc = {
    Text = "Sekarang bukan saat yang tepat untuk bersantai membaca koran."
  },
  Event_50285_Name = {
    Text = "Pengingatannya"
  },
  Event_50286_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50286_Desc = {
    Text = [[
Kamu tidak memikirkannya, kamu tidak mengingatnya.
Kamu enggan memikirkannya, kamu enggan mengingatnya.
Legenda Mythag akan berakhir, tetapi perjalanan Mythag tidak akan terhenti.
Kamu harus terus maju. Kamu harus terus maju.]]
  },
  Event_50286_Name = {
    Text = "Perjalanan Sendirian II"
  },
  Event_50287_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50287_Desc = {
    Text = [[
"Penjaga yang tercinta: 
Semoga surat ini menemukanmu dalam keadaan baik. 
Maafkan aku karena tidak menjaga Tubuhku dengan baik selama perjalanan ke Lemuwah kali ini, sehingga aku tidak bisa selalu berada di sisimu. 
Namun, di saat-saat penting, percayalah pada asistenmu yang satu-satunya. 
Aku akan selalu ada di sini ketika kamu membutuhkanku."
Karena alasan waktu, kamu tidak bisa melanjutkan membaca lebih jauh. 
Namun, tulisan yang familiar itu memberikanmu rasa ketenangan yang menenangkan pikiran.]]
  },
  Event_50287_Name = {
    Text = "Pengingatannya"
  },
  Event_50288_ChoiceDesc1 = {
    Text = "[Dia akan datang lagi] mendapatkan Relik perak [(RelicConfig.Arg1)]"
  },
  Event_50288_ChoiceDesc2 = {
    Text = "[Dia tidak akan datang] mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_50288_Desc = {
    Text = [[
Orang terakhir yang pergi adalah Ryker. 
 Untuk menghentikan Casiah, dia memilih untuk tetap di dalam tenda. 
 Dia pernah berjanji padamu, bahwa dia akan bersamamu untuk menerobos masuk ke lokasi upacara dan membakar Pohon Ibu, dia pasti akan mendampingi. 
 Tapi sekarang dia masih belum datang ke sisimu. 
 Hanya meninggalkanmu sendirian.]]
  },
  Event_50288_Name = {
    Text = "Perjalanan Sendirian III"
  },
  Event_50289_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50289_Desc = {
    Text = [[
Gulung-gulung, tiga benda bulat yang mengerikan bergulir di lokasi ritual. 
 Kamu merasa tidak seperti dirimu sendiri, atmosfer ritual yang fanatik dan sakit menjebakmu dalam Ilusi yang tak terlukiskan.]]
  },
  Event_50289_Name = {
    Text = "tiga persembahan"
  },
  Event_50290_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50290_Desc = {
    Text = [[
Keyakinan Aran begitu teguh, rela berulang kali tertimbun oleh pasir kuning.
Namun saat kau menengadah, tidak ada matahari di tengah badai.]]
  },
  Event_50290_Name = {
    Text = "Gigante Pasir dan Debu"
  },
  Event_50291_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50291_Desc = {
    Text = "Semoga lautan pasir mengabulkan kesungguhan mereka."
  },
  Event_50291_Name = {
    Text = "Gigante Pasir dan Debu"
  },
  Event_50292_ChoiceDesc1 = {
    Text = "[Menghapus Kenangan] Meningkatkan kualitas Orison secara acak pada 1 Kartu"
  },
  Event_50292_ChoiceDesc2 = {
    Text = "[Tangkap Kenangan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_50292_Desc = {
    Text = "Orang kedua yang meninggalkan adalah William."
  },
  Event_50292_Name = {
    Text = "Perjalanan Sendirian II"
  },
  Event_50293_ChoiceDesc1 = {
    Text = "[Perasaan Aman] Mendapatkan 25 Segil Hitam"
  },
  Event_50293_ChoiceDesc2 = {
    Text = "[Khawatir] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_50293_Desc = {
    Text = [[
Kamu tiba-tiba teringat hari ketika kamu memulai perjalanan. 
 Ramona mengingatkanmu untuk menyiapkan barang bawaan, William menyiapkan buku panduan untuk perjalananmu, dan Ryker diam-diam menyelipkan sebotol whiskey ke dalam tasmu. 
 Sekarang mereka sudah pergi. 

 Orang pertama yang pergi adalah Ramona, kekuatan Tawil dan kekuasaan Dinding Badai saling menolak, dia kalah karena demam tinggi di sepanjang perjalanan.]]
  },
  Event_50293_Name = {
    Text = "Perjalanan Sendirian I"
  },
  Event_50294_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50294_Desc = {
    Text = "Kamu menyerang kaki Nubia secara tiba-tiba, membuatnya goyah. Beberapa tentakel mirip tanaman bergerak liar dan kacau di udara, akhirnya terseret ke dalam badai debu."
  },
  Event_50294_Name = {
    Text = "Badai Pasir Alam"
  },
  Event_50295_ChoiceDesc1 = {
    Text = "[Baca] Hapus 1 Kartu"
  },
  Event_50295_ChoiceDesc2 = {
    Text = "[Tutup] Memperoleh \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_50295_Desc = {
    Text = "Klik klik.\nDi bawah Altar yang tidak terlihat di dunia ini, suara drum yang berat mengalir bersama angin pasir. Di tengah nyanyian tanpa henti, kamu mendengar suara lembut mesin tik — itu adalah panggilan dari Mythag, menenangkan jiwa gelisahmu."
  },
  Event_50295_Name = {
    Text = "Pengingatannya"
  },
  Event_50296_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50296_Desc = {
    Text = [[
Ryker memiliki keberuntungan yang melampaui dunia biasa.
Apa pun yang dia janjikan padamu, dia pasti akan melakukannya.
Pasti.]]
  },
  Event_50296_Name = {
    Text = "Perjalanan Sendirian III"
  },
  Event_50297_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_50297_Desc = {
    Text = [[
Tidak ada hubungannya denganmu. 
Saat ini, yang paling kamu butuhkan adalah segera mendekati dan merusak kerangka Pohon Ibu.]]
  },
  Event_50297_Name = {
    Text = "tiga persembahan"
  },
  Event_52373_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_52373_Desc = {
    Text = [[
Kamu berhasil bertahan hidup. Kamu melihat tak terhitung banyaknya gundukan tanah yang ditumpuk, tubuh-tubuh yang dibakar. 
 Sepertinya kamu juga telah membakar sesuatu, namun itu sudah tidak penting lagi. 
 Kamu mendengar, lonceng dari Ranah Dewa telah berbunyi.]]
  },
  Event_52373_Name = {
    Text = "Invasi Wabah"
  },
  Event_52374_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_52374_Desc = {
    Text = [[
Kamu berhasil bertahan hidup. Kamu melihat tak terhitung banyaknya gundukan tanah yang ditumpuk, tubuh-tubuh yang dibakar. 
 Kau berjuang keras untuk melindungi hal-hal yang kamu hargai, untuk itu, kamu membayar harga yang sangat mahal. Namun itu sudah tidak penting lagi. 
 Kamu mendengar, lonceng dari Negara Dewa telah berbunyi.]]
  },
  Event_52374_Name = {
    Text = "Invasi Wabah"
  },
  Event_52375_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_52375_Desc = {
    Text = [[
Kemarahan raksasa sementara mereda. Awan menghilang dan hujan reda, angin tenang dan laut damai. Lautan seperti Ibu yang abadi, dengan lembut mengusap punggung Lemuria dengan gelombang yang lembut. Hanya tersisa mayat-mayat dan reruntuhan yang berserakan di tubuh Lemuria. 
 Kamu berjuang keras untuk melindungi hal-hal yang kamu hargai, untuk itu, kamu membayar harga yang sangat mahal. Namun itu sudah tidak penting lagi. 
 Di lautan, kamu melihat siluet Negara Dewa.]]
  },
  Event_52375_Name = {
    Text = "Derauan Laut"
  },
  Event_52376_ChoiceDesc1 = {
    Text = "[Persembahkan Persembahan Tambahan] Hapus 1 Kartu Perintah, tambahkan masing-masing 1 dari 3 jenis [Fatamorgana Ranah Dewa] ke dalam dek."
  },
  Event_52376_Desc = {
    Text = "Berdiri di hadapan Takhta runtuh Lemuria, kau mempersembahkan korban terakhirmu. \n Jurang tanpa akhir terbentang di hadapanmu. Kau berlutut, tersenyum, dengan air mata membanjiri wajahmu. \n \"Lihatlah, Ayah, Deborah. Lihatlah, wahai Rajaku yang tertinggi — Negara Dewa, telah Kedatangan ke hadapanku!\""
  },
  Event_52376_Name = {
    Text = "Selamat datang, Ranah dewa"
  },
  Event_52377_ChoiceDesc2 = {
    Text = "[Melindungi Hal yang Berharga] Kehilangan Arg1 Hidup, mendapatkan 1 Kartu Gejala acak."
  },
  Event_52377_Desc = {
    Text = [[
Bumi. Bumi yang sunyi, bumi yang stabil. Bumi yang memuat manusia, bumi yang abadi dan tak lekang oleh waktu. Namun, bumi bergetar. Ia retak dengan celah yang dalam tak terukur, segala sesuatu yang ditopangnya goyang-goyang. 
 Kau menaruh semua harapanmu pada bumi, ketika bumi mulai bergetar, ke mana kau akan pergi? 
 Pengorbananlah, rakyat Lemuria memanggilmu. Korbankan segalanya, biarkan Negara Dewa yang tanpa bencana turun.]]
  },
  Event_52377_Name = {
    Text = "Gemetar Bumi"
  },
  Event_52378_ChoiceDesc2 = {
    Text = "[Melindungi Hal yang Berharga] Kehilangan Arg1 Hidup, mendapatkan 1 Kartu Gejala acak."
  },
  Event_52378_Desc = {
    Text = [[
Laut. Laut adalah ibu yang melahirkan Lemuria, adalah kehidupanmu, keyakinanmu. Dan saat ini, laut berdiri seperti raksasa marah dalam legenda. Dia berteriak, memanggil, mengubah air laut yang lembut menjadi batu raksasa yang keras dan duri, mengayunkan ke segala sesuatu di depannya. Dia merenung dengan acuh tak acuh melihat Lemuria yang bergetar di kakinya, melihat orang-orang Lemuria yang melarikan diri seperti serangga. Dia akan menghancurkan Lemuria, dan ini tidak ada hubungannya dengan Lemuria. 
 Persembahkanlah, wahai rakyat Lemuria, panggilanmu telah terdengar. Persembahkan segalanya, agar Negara Dewa yang bebas dari bencana dapat datang.]]
  },
  Event_52378_Name = {
    Text = "Derauan Laut"
  },
  Event_52379_ChoiceDesc2 = {
    Text = "[Melindungi Hal yang Berharga] Kehilangan Arg1 Hidup, mendapatkan 1 Kartu Gejala acak."
  },
  Event_52379_Desc = {
    Text = [[
Wabah. Wabah ada di mana-mana. Wabah adalah pelayan yang paling tidak tahu malu, ketika hukuman dewa atas bumi dan laut berlalu, ia menggantikan dewa untuk menjatuhkan hukuman mati yang tidak dapat diucapkan. Menguburkan mayat sanak saudara, membakar mayat sanak saudara, berdoalah agar orang-orang terkasih yang mati untuk melindungi diri mereka, semakin jauh dari diri sendiri semakin baik. Kehidupan dan kemanusiaan tidak berdaya di hadapan wabah. 
Pengorbananlah, rakyat Lemuria memanggilmu. Korbankan segalanya, biarkan Negara Dewa yang bebas dari bencana datang.]]
  },
  Event_52379_Name = {
    Text = "Invasi Wabah"
  },
  Event_52380_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_52380_Desc = {
    Text = [[
Guncangan yang kuat telah mereda. Jalan-jalan dipenuhi dengan noda darah merah tua, di bawah rumah-rumah yang runtuh, tak terhitung banyaknya orang terkubur. 
 Kamu berjuang keras untuk melindungi hal-hal yang kamu hargai, untuk itu, kamu membayar harga yang sangat mahal. Namun itu sudah tidak penting lagi. 
 Satu-satunya yang penting adalah, kamu semakin dekat dengan Negara Dewa.]]
  },
  Event_52380_Name = {
    Text = "Gemetar Bumi"
  },
  Event_52381_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_52381_Desc = {
    Text = "Berdiri di hadapan Takhta runtuh Lemuria, kau mengucapkan doa terakhirmu. \nJurang tanpa akhir terbentang di hadapanmu. Kau berlutut, tersenyum, dengan air mata membanjiri wajahmu. \n\"Lihatlah, Ayah, Deborah. Lihatlah, wahai Rajaku yang tertinggi — Ranah dewa, telah Kedatangan ke hadapanku!\""
  },
  Event_52381_Name = {
    Text = "Selamat datang, Ranah dewa"
  },
  Event_52382_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_52382_Desc = {
    Text = [[
Guncangan yang kuat telah mereda. Jalan-jalan dipenuhi dengan noda darah merah tua, di bawah rumah-rumah yang runtuh, tak terhitung banyaknya orang terkubur. 
 Sepertinya ada sesuatu yang ada padamu juga telah terkubur di bawah reruntuhan, namun itu sudah tidak penting lagi. 
 Satu-satunya yang penting adalah, kamu semakin dekat dengan Negara Dewa.]]
  },
  Event_52382_Name = {
    Text = "Gemetar Bumi"
  },
  Event_52383_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_52383_Desc = {
    Text = [[
Kemarahan raksasa sementara mereda. Awan menghilang dan hujan reda, angin tenang dan damai. Lautan seperti ibu yang abadi, dengan gelombang lembut menyentuh punggung Lemuria. Hanya tersisa di Lemuria, mayat-mayat yang berserakan dan reruntuhan. 
 Sesuatu yang ada padamu sepertinya telah terbenam di laut, tetapi itu sudah tidak penting lagi. 
 Di lautan, kamu melihat siluet Negara Dewa.]]
  },
  Event_52383_Name = {
    Text = "Derauan Laut"
  },
  Event_52384_ChoiceDesc1 = {
    Text = "[Doa Khidmat] Ubah setiap 1 Kartu Gejala biasa di dek menjadi 1 \"Fatamorgana Ranah Dewa\"dan dapatkan 2 \"Fatamorgana Ranah Dewa\"lagi."
  },
  Event_52384_ChoiceDesc2 = {
    Text = "[Doa Khidmat] Ubah setiap 1 Kartu Gejala biasa di dek menjadi 1 \"Fatamorgana Ranah Dewa\"dan dapatkan 2 \"Fatamorgana Ranah Dewa\"lagi."
  },
  Event_52384_Desc = {
    Text = [[
Bumi tidak lagi bergetar, laut tidak lagi menggelegar, wabah tidak lagi menyerang. Bencana telah menghancurkan Lemuria, meninggalkanmu. Kau menatap sekeliling, penuh dengan kehancuran. Kau menunduk melihat tanganmu, kosong belaka. 
 Tapi itu tidak masalah, wahai Pemimpin Upacara yang terhormat? Langkahkan kakimu di atas reruntuhan dan mayat Lemuria, terus merangkak maju. 
 Kamu hanya satu langkah jauhnya dari Negara Dewa.]]
  },
  Event_52384_Name = {
    Text = "Selamat datang, Ranah dewa"
  },
  Event_53140_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_53140_Desc = {
    Text = "Kamu menerima permintaan kontak dari sekolah, suara yang familiar membuatmu merasa tenang. Kamu mengumpulkan Roh dan melanjutkan langkah."
  },
  Event_53140_Name = {
    Text = "Persimpangan"
  },
  Event_53141_ChoiceDesc1 = {
    Text = "[Menghubungkan] Mengembalikan Arg2 poin Hidup."
  },
  Event_53141_ChoiceDesc2 = {
    Text = "[Meditasi] Pilih 1 Pembangun untuk Bangun."
  },
  Event_53141_ChoiceDesc3 = {
    Text = "[ Pengusiran ] Hapus maksimal 3 Kartu gejala, dapatkan Arg2 Segil hitam."
  },
  Event_53141_ChoiceDesc4 = {
    Text = "[Bangun ke dalam Kegilaan] Secara acak membangunkan 2 Pembangun, mendapatkan 1 Gejala acak"
  },
  Event_53141_ChoiceDesc5 = {
    Text = "[Keraguan] Lainnya"
  },
  Event_53141_Desc = {
    Text = "Kamu menjelajahi dalam kabut, tiba-tiba, lencana sekolah di dada memancarkan cahaya perak yang lemah. Siapa yang memanggil dari sisi lain komunikator?"
  },
  Event_53141_Name = {
    Text = "Persimpangan"
  },
  Event_53141_Tips3 = {
    Text = "Saat ini tidak memiliki Kartu gejala"
  },
  Event_53142_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_53142_Desc = {
    Text = "Kamu menerima permintaan kontak dari sekolah, suara yang familiar membuatmu merasa tenang. Kamu mengumpulkan Roh dan melanjutkan langkah."
  },
  Event_53142_Name = {
    Text = "Persimpangan"
  },
  Event_53143_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_53143_Desc = {
    Text = "Kamu menerima permintaan kontak dari sekolah, suara yang familiar membuatmu merasa tenang. Kamu mengumpulkan Roh dan melanjutkan langkah."
  },
  Event_53143_Name = {
    Text = "Persimpangan"
  },
  Event_53147_ChoiceDesc1 = {
    Text = "[ Pengusiran ] Hapus maksimal 3 Kartu gejala, dapatkan Arg2 Segil hitam."
  },
  Event_53147_ChoiceDesc2 = {
    Text = "[Bangun ke dalam Kegilaan] Secara acak membangunkan 2 Pembangun, mendapatkan 1 Gejala acak"
  },
  Event_53147_Desc = {
    Text = "Kamu menjelajahi dalam kabut, tiba-tiba, lencana sekolah di dada memancarkan cahaya perak yang lemah. Siapa yang memanggil dari sisi lain komunikator?"
  },
  Event_53147_Name = {
    Text = "Persimpangan"
  },
  Event_53147_Tips1 = {
    Text = "Saat ini tidak memiliki Kartu gejala"
  },
  Event_53148_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_53148_Desc = {
    Text = [[
Kamu menghubungkan komunikasi. Di sisi lain alat komunikasi terdengar suara yang gila, membuatmu terpesona dan tenggelam dalam kegilaan.
"Ingatlah ini. Ini adalah anugerah dari Ranah Dewa untukmu."]]
  },
  Event_53148_Name = {
    Text = "Persimpangan"
  },
  Event_55782_ChoiceDesc1 = {
    Text = "[Menebas Duri] Dalam pertempuran berikutnya, nyawa musuh meningkat 30%, kerusakan meningkat 15%, dan mendapatkan Arg1 gambaran \"(Skill.Arg2)\"."
  },
  Event_55782_ChoiceDesc2 = {
    Text = "[Menebas Duri] Dalam pertempuran berikutnya, nyawa musuh meningkat 30%, kerusakan meningkat 15%, dan mendapatkan Arg1 gambaran \"(Skill.Arg2)\"."
  },
  Event_55782_ChoiceDesc3 = {
    Text = "[Membuka semak belukar] Infeksi \"(Skill.Arg3)\", tempatkan Arg1 kartu imaji \"(Skill.Arg2)\" ke dalam dek."
  },
  Event_55782_ChoiceDesc4 = {
    Text = "[Membuka semak belukar] Infeksi \"(Skill.Arg3)\", tempatkan Arg1 kartu imaji \"(Skill.Arg2)\" ke dalam dek."
  },
  Event_55782_ChoiceDesc5 = {
    Text = "[Keluar dari Semak Berduri] \"Pena dan Tinta Horla\"mendapatkan Arg1 lapisan \"Pena dan Tinta\"."
  },
  Event_55782_Desc = {
    Text = [[
Sesuatu menyentuh hatimu. Kamu menghentikan langkahmu dan menatap ke sudut taman. Di bawah lapisan duri, sebuah titik cahaya bergerak, mencoba melepaskan diri dari ikatan di tubuhnya. 
Apa itu? Kupu-kupu? Burung? Kamu mendekatinya.]]
  },
  Event_55782_Name = {
    Text = "Berkah muzus"
  },
  Event_55782_Tips1 = {
    Text = "Musuh di pertempuran berikutnya telah diperkuat dan tidak dapat dipilih kembali."
  },
  Event_55783_ChoiceDesc1 = {
    Text = "[Kreasi Persembahan] Pilih 3 kartu \"Imaji\", biarkan Horla menciptakan \"Persembahan\" untukmu."
  },
  Event_55783_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_55783_Desc = {
    Text = [[
Kamu tiba di depan sebuah rumah kaca yang indah, melalui jendela, kamu mengintip ke dalam rumah kaca, tetapi tidak melihat apa-apa. 
 Angin bertiup, kelopak bunga dan daun-daun di dalam rumah kaca bergerak tertiup angin, terbang dan berkumpul di udara. Di antara bunga dan daun, kamu melihat sosok seorang gadis. 
 "Ah! Ada tamu di taman bunga!" Gadis itu melihatmu dengan rasa senang dan cemas. "Maaf, Colette sedang keluar... Jika ingin membeli bunga, saya tidak begitu tahu harga bunga-bunga ini..." 
 Gadis itu tiba-tiba berhenti, mendekat dan mengamatimu. "Ah, tamu ini, saya merasakan imaji puisi dari dirimu... Mungkin, kita bisa bersama-sama menciptakan sebuah puisi?"]]
  },
  Event_55783_Name = {
    Text = "Hadiah Musim Semi"
  },
  Event_55783_Tips1 = {
    Text = "Jumlah \"Imaji\"tidak mencukupi 3 buah, tidak dapat disintesis."
  },
  Event_55799_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_55799_Desc = {
    Text = "Duri yang hidup kembali tampak agak gelisah, tetapi harga yang harus dibayar tidak berarti apa-apa — di titik cahaya itu, kamu mendengar panggilan dari Muse."
  },
  Event_55799_Name = {
    Text = "Berkah muzus"
  },
  Event_55819_ChoiceDesc1 = {
    Text = "[Memori Tubuh yang Sesuai] Lewati pertempuran untuk kemenangan instan, tetapi kehilangan Arg1 poin hidup."
  },
  Event_55819_ChoiceDesc2 = {
    Text = "[Keluar] Masuk ke Pertempuran"
  },
  Event_55819_Desc = {
    Text = "Menghadapi musuh yang sudah dikenal, kamu sudah memahami sepenuhnya pertempuran berikutnya."
  },
  Event_55819_Name = {
    Text = "memori otot"
  },
  Event_55997_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_55997_Desc = {
    Text = "Dari berbagai imaji yang terkumpul, kamu memilih beberapa dan menyerahkannya ke tangan gadis itu. \n \"Imaji yang sangat indah! Tamu ini, tunggu sebentar... Ini. Ini adalah persembahan puisi yang dibawa oleh Musim Semi, khusus untukmu!\" \n Sebuah puisi muncul di tanganmu, seperti bunga yang mekar khusus untukmu. \n Kamu ingin mengucapkan terima kasih kepada gadis itu. Namun, ketika kamu mengangkat kepala, sosok gadis itu telah menghilang. Di dalam rumah bunga yang sepi, hanya tersisa bunga dan daun yang layu di atas tanah. \n — Itu adalah sisa abu yang ditinggalkan setelah Musim Semi padam."
  },
  Event_55997_Name = {
    Text = "Hadiah Musim Semi"
  },
  Event_55999_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_55999_Desc = {
    Text = "Rimbunan duri yang lebat membuatmu ragu untuk melangkah maju. Kamu meninggalkan titik cahaya itu, namun pandangan singkat yang baru saja kau lakukan masih membuat hatimu dipenuhi dengan inspirasi baru — di titik cahaya itu, kamu mendengar panggilan sang Muse."
  },
  Event_55999_Name = {
    Text = "Berkah muzus"
  },
  Event_56000_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_56000_Desc = {
    Text = "Kamu menggunakan tanganmu untuk menyingkirkan semak berduri, dan karena itu kamu mengalami beberapa luka. Namun, harga yang harus dibayar tidaklah berarti — di titik cahaya itu, kamu mendengar panggilan dari sang Muse."
  },
  Event_56000_Name = {
    Text = "Berkah muzus"
  },
  Event_56024_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_56024_Desc = {
    Text = [[
Belum cukup... kamu terus mendekati titik cahaya itu. Semak berduri menjadi marah dan menunjukkan duri-duri tajamnya ke arahmu. Namun, semuanya sepadan. 
Titik cahaya itu menyebar dari telapak tanganmu, di tengah tirai cahaya yang memenuhi langit, kamu dengan jelas merasakan Berkah muzus.]]
  },
  Event_56024_Name = {
    Text = "Berkah muzus"
  },
  Event_56025_ChoiceDesc1 = {
    Text = "[Mendekati titik cahaya] Dalam pertempuran berikutnya, nyawa musuh meningkat tambahan 30%, kerusakan meningkat tambahan 15%, dapat memilih 1 kartu [Impresi] untuk ditingkatkan."
  },
  Event_56025_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_56025_Desc = {
    Text = "Kamu menggunakan alat yang selalu kamu bawa untuk memotong semak berduri. Semak berduri yang hidup itu tampak agak gelisah, namun harga yang harus dibayar tidaklah seberapa — di titik cahaya itu, kamu mendengar panggilan dari sang Muse."
  },
  Event_56025_Name = {
    Text = "Berkah muzus"
  },
  Event_56146_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_56146_Desc = {
    Text = [[
Belum cukup... kamu terus mendekati titik cahaya itu. Duri tajam melukai tanganmu, membuat darah mengalir tanpa henti. Namun, semua ini sepadan. 
Titik cahaya itu menyebar dari telapak tanganmu, di tengah tirai cahaya yang memenuhi langit, kamu dengan jelas merasakan Berkah muzus.]]
  },
  Event_56146_Name = {
    Text = "Berkah muzus"
  },
  Event_56147_ChoiceDesc1 = {
    Text = "[Impuls Kreatif] Semua Pembangun kehilangan semua Aliemus, pilih 3 kartu \"Imaji\", dan biarkan Horla menciptakan \"Persembahan\" untukmu."
  },
  Event_56147_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_56147_Desc = {
    Text = "Kamu menerima permintaan kontak dari sekolah, suara yang familiar membuatmu merasa tenang. Kamu mengumpulkan Roh dan melanjutkan langkah."
  },
  Event_56147_Name = {
    Text = "Persimpangan"
  },
  Event_56147_Tips1 = {
    Text = "Jumlah \"Imaji\"tidak mencukupi 3 buah, tidak dapat disintesis."
  },
  Event_56148_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_56148_Desc = {
    Text = "Cahaya perak pada lambang sekolah membuat hatimu berdebar. Mengikuti petunjuk di dalam hati, kau melemparkan benda di tanganmu ke semak berduri. Cahaya di bawah semak mulai bersinar terang — dalam cahaya itu, kau memperoleh Inspirasi baru."
  },
  Event_56148_Name = {
    Text = "Persimpangan"
  },
  Event_56149_ChoiceDesc1 = {
    Text = "[Mendekati titik cahaya] Mengurangi batas maksimal hidup sebesar 10%, dapat memilih satu kartu [imaji] untuk ditingkatkan."
  },
  Event_56149_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_56149_Desc = {
    Text = "Kamu menggunakan tanganmu untuk menyingkirkan semak berduri, dan karena itu kamu mengalami beberapa luka. Namun, harga yang harus dibayar tidaklah berarti — di titik cahaya itu, kamu mendengar panggilan dari sang Muse."
  },
  Event_56149_Name = {
    Text = "Berkah muzus"
  },
  Event_56149_Tips1 = {
    Text = "Tidak ada \"imaji\" yang dapat ditingkatkan"
  },
  Event_56150_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_56150_Desc = {
    Text = "Kilauan perak pada lambang sekolah membuat hatimu terguncang. Kamu merasakan dorongan kuat untuk mencatat bait-bait puisi yang muncul di benakmu."
  },
  Event_56150_Name = {
    Text = "Persimpangan"
  },
  Event_56151_ChoiceDesc1 = {
    Text = "[Inspirasi Baru] Pilih 1 \"Imaji\"untuk dihapus, tingkatkan secara acak 1 \"Imaji\"."
  },
  Event_56151_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_56151_Desc = {
    Text = "Kamu menerima permintaan kontak dari sekolah, suara yang familiar membuatmu merasa tenang. Kamu mengumpulkan Roh dan melanjutkan langkah."
  },
  Event_56151_Name = {
    Text = "Persimpangan"
  },
  Event_56151_Tips1 = {
    Text = "Saat ini tidak ada kartu \"Impian\""
  },
  Event_57738_ChoiceDesc1 = {
    Text = "[Bangun Paksa] Semua Pembangun mendapatkan 30 poin Aliemus, tetapi dua kartu \"(Skill.Arg1)\" dimasukkan ke dalam dek."
  },
  Event_57738_ChoiceDesc2 = {
    Text = "[Melucuti Senjata] Dalam pertempuran berikutnya, hidup musuh meningkat 60%, kerusakan meningkat 30%."
  },
  Event_57738_ChoiceDesc3 = {
    Text = "[Ambush] Lelah semua Pembangun, dapatkan 30 Segil hitam dan hapus ancaman Penjaga."
  },
  Event_57738_Desc = {
    Text = [[
Kamu mengintip keluar dari area buta di sudut. Agen Komite sedang mengamati ke arah lain dan tidak menyadari keberadaan kalian. 
Adegan-adegan latihan berkedip-kedip dalam pikiranmu, dan segera kamu memikirkan cara yang tepat untuk menangani musuh yang menghalangi jalan ini.]]
  },
  Event_57738_Name = {
    Text = "Agen Komite"
  },
  Event_57738_Tips3 = {
    Text = "Saat ini, semua Pembangun tidak memiliki Aliemus."
  },
  Event_57739_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_57739_Desc = {
    Text = [[
Kamu mengamati dengan cermat. Agen dari Komite menghalangi jalan yang harus kalian lewati, sedang serius mengawasi area di depanmu ini.
Menghadapi musuh yang jumlahnya banyak, kamu tidak bisa melawan mereka.
Maju, atau mundur?]]
  },
  Event_57739_Name = {
    Text = "Titik Penahanan"
  },
  Event_57776_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_57776_ChoiceDesc2 = {
    Text = "[Pretensi Menyerah] Setelah menjelajahi area ini, teleportasi ke titik penahanan dan dapatkan 2 \"Gejala\" acak."
  },
  Event_57776_ChoiceDesc3 = {
    Text = "[Menyerbu] Setelah menjelajahi area ini, teleportasi ke titik penahanan, kehilangan Arg1 poin Hidup."
  },
  Event_57776_Desc = {
    Text = [[
Kamu mengamati dengan cermat. Agen dari Komite menghalangi jalan yang harus kalian lewati, sedang serius mengawasi area di depanmu ini.
Menghadapi musuh yang jumlahnya banyak, kamu tidak bisa melawan mereka.
Maju, atau mundur?]]
  },
  Event_57776_Name = {
    Text = "Titik Pengawasan"
  },
  Event_57776_Tips3 = {
    Text = "Nyawa saat ini tidak cukup"
  },
  Event_59193_ChoiceDesc1 = {
    Text = "[Alistair's Blessing] Tambahkan satu kartu [Cahaya Mikro Malam Ekstrem] ke dalam dek."
  },
  Event_59193_Desc = {
    Text = "Sertifikat penerimaan ini telah tertekan di dasar kopermu, kamu mengusap bingkai halus yang seolah dilapisi cahaya bintang, mengendus ringan aroma tinta yang khas dari kertas, lambang Mythag seolah menjadi pintu cahaya menuju masa depan, menarik perhatian matamu yang penuh kerinduan — seperti hari itu, seperti hari ini."
  },
  Event_59193_Name = {
    Text = "Upacara Masuk Sekolah"
  },
  Event_59527_ChoiceDesc1 = {
    Text = "Pilih sebuah Kartu untuk memahami Orison \"Prinsip Pengetahuan\".\"Prinsip Pengetahuan\": Setelah dimainkan, tarik 2 kartu, konsumsi daya komputasi mereka berkurang sebesar daya komputasi aktual kartu Orison, hanya berlaku 1 kali per pertempuran."
  },
  Event_59527_Desc = {
    Text = [[
Orison yang melambangkan kebijaksanaan terukir di dokumenmu. 
Pikiran Tawil mengalir ke dalam benakmu. Di antara kemungkinan tanpa akhir, kau sedang melangkah menuju satu-satunya jalan yang benar.]]
  },
  Event_59527_Name = {
    Text = "Upacara Masuk Sekolah"
  },
  Event_59528_ChoiceDesc1 = {
    Text = "Pilih satu Kartu untuk memahami Orison \"Prinsip Kegembiraan\".\"Prinsip Kegembiraan\": Setelah dimainkan, buang semua kartu selain Awakened tersebut, dapatkan 5 kartu non-Awakened acak, hanya berlaku 1 kali per pertempuran."
  },
  Event_59528_Desc = {
    Text = [[
Simbol kegembiraan, Orison, terukir di dokumenmu. 
 Melalui Orison itu, N sedang mengamati dirimu. Dia menantikan bahwa engkau akan membawa-Nya sebuah akhir yang belum pernah disebutkan dengan sembarangan.]]
  },
  Event_59528_Name = {
    Text = "Upacara Masuk Sekolah"
  },
  Event_59529_ChoiceDesc1 = {
    Text = "Pilih satu Kartu untuk memahami Orison \"Prinsip Pembiakan\".\"Prinsip Pembiakan\": Setelah dimainkan, dapatkan 3 salinan asli dengan tambahan \"Pertahankan\" dan \"Konsumsi\", hanya berlaku 1 kali per pertempuran."
  },
  Event_59529_Desc = {
    Text = [[
Simbol Orison terukir di dokumen identitasmu. 
 Thais menaruh harapannya padamu, Dia akan berdampingan denganmu di semua dunia.]]
  },
  Event_59529_Name = {
    Text = "Upacara Masuk Sekolah"
  },
  Event_59566_ChoiceDesc1 = {
    Text = "[Menghapus Air Mata Darah] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_59566_ChoiceDesc2 = {
    Text = "[Tetap Terbangun]Dapatkan secara acak 3 kartu perintah untuk mendapatkan Orison:\"(EnchantConfig.Arg1)\"，terinfeksi\"(Skill.Arg2)\""
  },
  Event_59566_Desc = {
    Text = [[
Jutaan keinginanmu menyatu menjadi satu. Dulunya, kalian memiliki asal yang sama, sekarang kalian berbagi tubuh yang sama. 
 Jutaan mata terbuka bersamaan, menghadapi pupil raksasa itu. 
 Jutaan mata hancur bersamaan, meneteskan darah dan air mata dalam penderitaan yang kering.]]
  },
  Event_59566_Name = {Text = "Fusi saya"},
  Event_59567_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59567_Desc = {
    Text = [[
Kamu mencoba berdebat dengan suara kegilaan itu, membantah konsep ilusi tersebut. 
"Segala sesuatu akan menghadapi kematian, apakah hidup itu sendiri tidak memiliki makna?" 
Kamu berargumen dengan penuh keyakinan, namun tawa itu tidak berkurang sedikit pun, seolah-olah mengejek kebodohanmu.]]
  },
  Event_59567_Name = {
    Text = "Lamb to the slaughter"
  },
  Event_59568_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59568_Desc = {
    Text = [[
Kamu menatap pintu itu, tidak ingin lagi menahan rasa sakit karena ketidaktahuan. 
 Kamu ingin melihat pemandangan di balik pintu. 
 Pintu ilusi bergetar dengan mempesona, dan kamu melihat bayangan tak terhitung dari dunia yang berlalu dengan cepat. 
 Tidak sempat melihat dengan jelas, informasi yang tak terhingga menghancurkan jiwamu, dan otakmu dipenuhi dengan kebisingan yang kacau.]]
  },
  Event_59568_Name = {
    Text = "Di balik pintu"
  },
  Event_59569_ChoiceDesc1 = {
    Text = "[Bangun Komando] Bangun 1 Pembangun secara acak, terinfeksi [(Skill.Arg1)]"
  },
  Event_59569_ChoiceDesc2 = {
    Text = "[Diskusi Bersama] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_59569_Desc = {
    Text = [[
Segala sesuatu terjadi begitu tiba-tiba, kamu merasakan kabut samar menyelimuti sekitarmu. Kamu berusaha melihat ke sekeliling, tetapi tidak ada yang terlihat jelas. 
 Awakener sedang menunggu perintah darimu. 
 Sekarang kamu terjebak tanpa bantuan, hanya bisa mengandalkan kekuatanmu sendiri.]]
  },
  Event_59569_Name = {
    Text = "Mata Kebodohan"
  },
  Event_59570_ChoiceDesc1 = {
    Text = "[Mendapatkan dengan pengorbanan] Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_59570_ChoiceDesc2 = {
    Text = "[Dengan Keberanian] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_59570_ChoiceDesc3 = {
    Text = "[Mendapatkan] 50 Segil Hitam"
  },
  Event_59570_Desc = {
    Text = [[
Jutaan dirimu berdiri di antara berbagai dunia, bahu berdempetan, tangan bergandeng, seolah-olah seperti saudara yang sangat dekat. 
 Sekarang kalian berdiri bersama di bawah bayangan raksasa itu, mengangkat kepala, tidak mundur sejengkal pun. 
 Apa yang harus dilakukan? 
 Apa yang harus dilakukan untuk mengalahkan dirimu yang terakhir?]]
  },
  Event_59570_Name = {
    Text = "Jawaban saya"
  },
  Event_59571_ChoiceDesc1 = {
    Text = "[Mencari Jawaban] Mendapatkan Arg1 Segil hitam, terinfeksi [(Skill.Arg2)], lanjutkan memilih"
  },
  Event_59571_ChoiceDesc2 = {
    Text = "[Menyerah]mendapatkan 25 Segil hitam, pergi"
  },
  Event_59571_Desc = {
    Text = [[
Melalui ilusi pintu, tak terhitung banyaknya pengalamanmu berkedip di pikiranmu. 
 Beberapa di antara mereka mati, beberapa menjadi gila, beberapa bertahan, dan beberapa jatuh. 
 Tak terhitung banyaknya jalan, tak terhitung banyaknya pilihan berkedip di depanmu, seolah-olah dalam sekejap kamu telah menjalani kehidupan yang panjang dan tak berujung. 
 Sekarang, tak terhitung banyaknya pikiran, tak terhitung banyaknya mulut beroperasi secara bersamaan. 
 Kamu mencoba melintasi waktu dan ruang untuk berdialog dengan tak terhitung banyaknya dirimu, menyelam ke dalam ingatan yang tak berujung untuk menemukan jawaban.]]
  },
  Event_59571_Name = {
    Text = "Pertanyaan Diri Saya"
  },
  Event_59572_ChoiceDesc1 = {
    Text = "[Pertukaran Kekuatan] 1 kartu perintah acak mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_59572_ChoiceDesc2 = {
    Text = "[Pertukaran Keberuntungan] Meningkatkan Arg1 poin Kesehatan maksimum, terinfeksi [(Skill.Arg2)]"
  },
  Event_59572_Desc = {
    Text = [[
Semua pilihan memiliki harga. 
 Kehidupan, jiwa, emosi, ingatan... 
 Apa yang ingin kamu tukar dengan nasib, dan apa yang kamu pilih untuk diletakkan di timbangan?]]
  },
  Event_59572_Name = {
    Text = "Pilihan Nasib"
  },
  Event_59573_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59573_Desc = {
    Text = [[
Bagaimana mungkin manusia tidak memiliki jantung? 
 Kamu panik mencari ke sana kemari, napasmu semakin cepat, ketakutan akan kematian menyelimuti pikiranmu. 
 "Tidak bisa bernapas... detak jantungku akan berhenti..." 
 Tunggu, sepertinya kamu sudah tidak lagi membutuhkan detak jantung. 
 Kamu tiba-tiba menyadari, lalu tertawa bahagia.]]
  },
  Event_59573_Name = {
    Text = "Rongga dada"
  },
  Event_59574_ChoiceDesc1 = {
    Text = "[Mendapatkan] Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_59574_ChoiceDesc2 = {
    Text = "[Menghindar] Secara acak membangunkan 2 Pembangun, menginfeksi dua kali [(Skill.Arg1)]"
  },
  Event_59574_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_59574_Desc = {
    Text = [[
Kamu merasakan kehadiran sesuatu di dalam kehampaan yang mengamati kamu. 
Ke mana pun kamu melangkah, tatapan itu terus mengikuti seperti bayangan. 
Kamu merasa seperti mangsa kecil yang sudah menjadi sasaran, dan punggungmu mulai terasa nyeri seperti ditusuk jarum.]]
  },
  Event_59574_Name = {
    Text = "Pandangannya"
  },
  Event_59575_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59575_Desc = {
    Text = [[
Kamu tetap tenang di tengah permainan yang kacau, selalu diam-diam mempertahankan ritmemu sendiri. 
 Serangan dan godaan lawan tidak berpengaruh padamu. Dua melodi dimainkan secara bersamaan di atas piano; siapa yang bertahan sampai akhir akan menguasai semua not.]]
  },
  Event_59575_Name = {
    Text = "Lagu Pesta Kiamat"
  },
  Event_59576_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59576_Desc = {
    Text = "Kamu mengumpulkan semua keberanianmu, apa pun yang harus dihadapi, kamu akan terus maju bersama teman-teman seperjuangan."
  },
  Event_59576_Name = {
    Text = "Masa Depan Terkunci"
  },
  Event_59577_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59577_Desc = {
    Text = [[
"Apa kamu sekarang di mana?"
"Apa rencana para guru?"
"Apa yang harus aku lakukan selanjutnya?"
Kamu dengan terburu-buru bertanya, ingin bergantung pada keberadaan yang dapat diandalkan itu seperti biasanya.
Alat komunikasi itu seakan terhenti, kehilangan respons. Kamu menggoyangkan mesin itu, dan dalam goyangan, tulisan di surat balasan itu berubah menjadi segerombolan kupu-kupu, berdesir dan menempel di wajahmu.
Kamu menggosok-gosok matamu, menyadari bahwa semuanya hanyalah ilusi. 
Kertas surat balasan itu kosong tanpa satu kata pun.]]
  },
  Event_59577_Name = {
    Text = "Gema Hipnotis"
  },
  Event_59578_ChoiceDesc1 = {
    Text = "[Mencari dengan panik] Meningkatkan Kesehatan maksimum sebesar Arg1"
  },
  Event_59578_ChoiceDesc2 = {
    Text = "[Mencoba Mengisi] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_59578_Desc = {
    Text = [[
Kamu merasakan bagian dalam rongga dada menjadi kosong dan ringan. Kamu menunduk untuk melihat, dan di tengah dada muncul lubang berbentuk seperti lubang kunci. 
 Jantungmu lenyap tanpa jejak.]]
  },
  Event_59578_Name = {
    Text = "Rongga dada"
  },
  Event_59579_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59579_Desc = {
    Text = [[
Kamu mengajukan pertanyaan dengan suara keras tentang tujuannya, namun hanya mendapatkan senyuman yang tak berubah sedikit pun.

Dia sudah meninggalkan dunia, seseorang tanpa ikatan tidak perlu bertanggung jawab atas apa pun.
Kamu hanya bisa melawan dengan sia-sia.]]
  },
  Event_59579_Name = {
    Text = "Gentleman Gila"
  },
  Event_59580_ChoiceDesc1 = {
    Text = "[Mengacaukan Irama] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_59580_ChoiceDesc2 = {
    Text = "[Mempertahankan Diri Sendiri] Mendapatkan 1 dari 3 Orison"
  },
  Event_59580_Desc = {
    Text = [[
Kamu seolah-olah bermain musik bersama seseorang yang gila, dia menculikmu di atas tuts piano, menyeretmu ke dalam melodi kegilaannya.
Kamu memainkan nada dengan susah payah dalam ritmenya, terseok-seok.
Kamu berusaha keras untuk beradu dengannya, mencoba mengendalikan melodi lagu tersebut.]]
  },
  Event_59580_Name = {
    Text = "Lagu Pesta Kiamat"
  },
  Event_59581_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59581_Desc = {
    Text = [[
Kamu berharap memiliki kekuatan yang tak tertandingi, mampu menghancurkan semua belenggu dan rintangan. 
Namun, kemampuan manusia ada batasnya. Menantang dewa dengan tubuh yang kecil pada akhirnya akan membakar habis hidupmu seperti korek api.]]
  },
  Event_59581_Name = {
    Text = "Pilihan Nasib"
  },
  Event_59582_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59582_Desc = {
    Text = [[
"Sudah hilang... sudah hilang..."
Perasaan kosong itu sangat tidak menyenangkan, kamu mengambil jam saku, apel, dan jaket seragam, mencoba mengisi rongga di dadamu.
Rongga di dadamu kembali terasa penuh, hanya saja kamu merasakan ilusi terlalu kenyang.
Tidak apa-apa, segalanya tidak selalu sempurna.]]
  },
  Event_59582_Name = {
    Text = "Rongga dada"
  },
  Event_59583_ChoiceDesc1 = {
    Text = "[Mejelaskan] Mendapatkan 25 Segil Hitam"
  },
  Event_59583_ChoiceDesc2 = {
    Text = "[Pertanyaan] Memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_59583_Desc = {
    Text = [[
Sepatu kulit N berhenti di hadapanmu, kamu melihat senyum berlebihan di wajahnya yang gelap pekat.
Dia biasanya berpakaian rapi, tetapi kamu tahu di balik penampilan pria itu hanya ada Kegilaan yang paling murni.
Dia tidak memiliki teman, dan jarang memiliki musuh.
Karena orang-orang itu akan lenyap sepenuhnya dengan cara yang paling dramatis.

Sayangnya, kini kamu telah dipilihnya sebagai tokoh utama drama berikutnya.
Siapkanlah kata-kata pembukaanmu, bagaimana caranya agar Penonton yang paling pemilih ini merasa puas?]]
  },
  Event_59583_Name = {
    Text = "Gentleman Gila"
  },
  Event_59584_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59584_Desc = {
    Text = [[
Pembangun tidak lebih tahu apa-apa daripada kamu, tetapi mereka sudah menjadi teman, rekan, dan pendukung paling setia. 
 Kamu berdiskusi dengan Pembangun untuk mencari solusi. Meskipun hatimu masih diliputi kebimbangan, kalian sudah memiliki keberanian untuk memulai kembali.]]
  },
  Event_59584_Name = {
    Text = "Mata Kebodohan"
  },
  Event_59585_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59585_Desc = {
    Text = [[
Seakan-akan membulatkan tekad untuk dirimu sendiri, kau menjawab dengan suara lantang penuh keyakinan. 
Suaramu bergema di antara gelembung-gelembung yang tak terhitung jumlahnya, seolah ada banyak versi dirimu yang berikrar bersamaan. 
Kau telah siap menghadapi segala tantangan.]]
  },
  Event_59585_Name = {
    Text = "Pertanyaan-Nya"
  },
  Event_59586_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59586_Desc = {
    Text = [[
Kamu tidak bergerak, hanya menatap tulisan di surat balasan dengan tajam. 
 Di bawah tatapanmu, kalimat-kalimat itu perlahan-lahan menjadi kabur dan terdistorsi, akhirnya berubah menjadi sekelompok kupu-kupu yang berterbangan ke wajahmu. 
 Kamu mengayunkan tangan untuk mengusir kupu-kupu, dan saat menoleh kembali, kertas surat balasan itu sudah kosong tanpa satu kata pun. 
 Memang, mimpi yang terlalu indah selalu terasa palsu.]]
  },
  Event_59586_Name = {
    Text = "Gema Hipnotis"
  },
  Event_59587_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59587_Desc = {
    Text = [[
Kamu membenci benang-benang licik ini. 
 Kamu menariknya dengan keras, beberapa benang putus, tetapi tak terhitung banyaknya benang lain datang membelit lagi. 
 Kamu menggunakan semua Kekuatanmu untuk terus melawan mereka.]]
  },
  Event_59587_Name = {
    Text = "Tangan yang Dimanipulasi"
  },
  Event_59588_ChoiceDesc1 = {
    Text = "[Membunuh Bayangan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_59588_ChoiceDesc2 = {
    Text = "[Menghancurkan Embryo] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_59588_ChoiceDesc3 = {
    Text = "[Tutup mata] mendapatkan 25 Segil Hitam"
  },
  Event_59588_Desc = {
    Text = [[
Dalam keadaan bingung, kamu melihat orang-orang yang pernah kamu temui di Aran mendekat kepadamu.
Mereka tertawa dan mengundangmu untuk minum, menari, dan mencicipi makanan.
Kemudian, daging dan darah mereka terkelupas lapis demi lapis, yang jatuh ke tanah dan bergerak untuk menghasilkan embrio baru.
Mereka mengulurkan tangan kepada kamu, mengundangmu untuk bergabung dalam pesta daging dan kelahiran baru.]]
  },
  Event_59588_Name = {
    Text = "Bayangan Masa Lalu"
  },
  Event_59589_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59589_Desc = {
    Text = [[
Sebelum kamu mengulurkan tangan, tiba-tiba kamu teringat bahwa kamu tidak pernah memelihara seekor kucing seperti ini. 
 Kamu dan kucing itu saling menatap melalui udara, lalu kucing itu berkedip padamu. 
 Kucing itu tidak peduli dengan sikap dinginmu, tetapi sepertinya ia tetap mencintaimu.]]
  },
  Event_59589_Name = {
    Text = "Godaan Kucing"
  },
  Event_59590_ChoiceDesc1 = {
    Text = "[Permata] Pilih 1 Relik berubah menjadi Relik terkutuk [(RelicConfig.Arg1)]"
  },
  Event_59590_ChoiceDesc2 = {
    Text = "[Menelan] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_59590_ChoiceDesc3 = {
    Text = "[Simpan] Mendapatkan 25 Segil Hitam"
  },
  Event_59590_Desc = {
    Text = [[
Kekuatan dari tiga plasmid dalam tubuhmu sedang bercampur, dan kamu dengan susah payah mengendalikan kekuatan yang besar ini. 
 Ruang spiritualmu terus membesar, sebuah galaksi lahir dan menyebar di sini. 
 Menghadapi musuh yang terus berdatangan, kamu dengan tulus berdoa kepada langit berbintang ini, berharap bantuan dari kekuatan ini. 
 Sebuah bintang jatuh dari galaksi dan mendarat di telapak tanganmu, memancarkan cahaya yang menggoda.]]
  },
  Event_59590_Name = {
    Text = "Bintang Permintaan"
  },
  Event_59591_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59591_Desc = {
    Text = [[
Kamu juga tetap diam, kalian tidak saling berbicara. Diam adalah jawaban untuk segalanya. 
 Kamu sudah siap menghadapi semuanya.]]
  },
  Event_59591_Name = {
    Text = "Pertanyaan-Nya"
  },
  Event_59592_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59592_Desc = {
    Text = [[
Apakah kucing itu seorang penipu?
Kamu mulai meragukan mata birunya yang seperti kolam, tawa di samping telinga terus terngiang. 
"Penipu, penipu, kamu telah ditipu!"
Sebuah kekhawatiran muncul di dalam hatimu.]]
  },
  Event_59592_Name = {
    Text = "bisikan rahasia"
  },
  Event_59593_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59593_Desc = {
    Text = [[
Kamu seperti seorang pengamat, diam-diam menyaksikan emosi yang perlahan menjadi asing.
Kamu menahan semua keinginan untuk bernostalgia, merasakan jiwa kamu secara bertahap menjadi dingin.
Ini adalah takdirmu, ini adalah jalan yang harus kamu tempuh.]]
  },
  Event_59593_Name = {
    Text = "Kristal Emosional"
  },
  Event_59594_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59594_Desc = {
    Text = [[
Senyuman itu tetap tak tergoyahkan, kamu tidak bisa menggerakkannya dengan komunikasi rasional atau emosional. 
Semua keinginan manusia tidak ada hubungannya dengannya. 
Apakah kata-katamu dapat melampaui imajinasi manusia?]]
  },
  Event_59594_Name = {
    Text = "Gentleman Gila"
  },
  Event_59595_ChoiceDesc1 = {
    Text = "[Mendapatkan] Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_59595_ChoiceDesc2 = {
    Text = "[Bangun] secara acak 2 Pembangun, infeksi dua kali [(Skill.Arg1)]"
  },
  Event_59595_Desc = {
    Text = [[
Begitu banyak gelembung tampak seperti begitu banyak mata bulat. Dia diam-diam menatapmu, seolah-olah memberikan pertanyaan tanpa suara.
Apakah kamu sudah siap?
Siap untuk meninggalkan segalanya?
Siap untuk menanggung segalanya?]]
  },
  Event_59595_Name = {
    Text = "Pertanyaan-Nya"
  },
  Event_59596_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59596_Desc = {
    Text = [[
Pada saat musuh melancarkan serangan, kamu segera melakukan balasan. 
 Kamu dengan bijak mengenali wajah asli mereka, yang sebenarnya adalah sekumpulan binatang buas yang memperlihatkan taring. 
 Kamu beruntung meraih kemenangan. 
 Sekarang, berusaha melarikan diri, jangan sampai tertangkap oleh mereka.]]
  },
  Event_59596_Name = {
    Text = "Tenggelam ke jurang"
  },
  Event_59597_ChoiceDesc1 = {
    Text = "[Mencari Jawaban] Mendapatkan Arg1 Segil hitam, terinfeksi [(Skill.Arg2)], lanjutkan memilih"
  },
  Event_59597_ChoiceDesc2 = {
    Text = "[Menyerah] Pergi"
  },
  Event_59597_Desc = {
    Text = [[
Apa yang harus kamu lakukan?
Kamu melihat tak terhitung banyaknya dirimu sendiri, wajah-wajah yang sama denganmu menatapmu, mulut mereka bergerak membuka dan menutup.
Seolah-olah memegang erat jerami harapan, kamu berusaha mencari dan mendengarkan, berharap bisa mendapatkan jawaban akhir.]]
  },
  Event_59597_Name = {
    Text = "Pertanyaan Diri Saya"
  },
  Event_59598_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59598_Desc = {
    Text = [[
Masih belum waktunya, kamu harus menahan diri dan menunggu dengan sabar.
Kamu menelan rasa tidak puas dan kebencian, sambil menunggu saat untuk bertaruh segalanya.]]
  },
  Event_59598_Name = {
    Text = "Tangan yang Dimanipulasi"
  },
  Event_59599_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59599_Desc = {
    Text = [[
Kamu merasakan suatu tarikan yang tidak terlihat, kamu ingin melihat jelas dari mana tatapan itu berasal. 
 Kamu menatap kekosongan dengan penuh perhatian, merasa seolah-olah melihat sesuatu. 
 Pandanganmu seketika tertutup oleh kabur seperti butiran salju, dunia di dalam matamu tampak seperti ada sesuatu yang berbeda. 
 Kamu menggosok-gosok matamu dan menemukan dua baris air mata darah mengalir dari sudut matamu.]]
  },
  Event_59599_Name = {
    Text = "Pandangannya"
  },
  Event_59600_ChoiceDesc1 = {
    Text = "[Berusaha Mengingat] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_59600_ChoiceDesc2 = {
    Text = "[Merasakan Kesedihan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_59600_ChoiceDesc3 = {
    Text = "[Menerima dengan diam] Mendapatkan 25 Segil hitam"
  },
  Event_59600_Desc = {
    Text = [[
Seolah-olah telah mengalami operasi otak yang paling cermat, kamu merasakan dengan jelas bahwa segmen-segmen ingatan yang berharga sedang ditarik keluar dari pikiranmu, otakmu menjadi kabur, seolah-olah akan meleleh. 
 Kamu bergetar dalam rasa sakit, menekan tanganmu yang ingin menghentikannya. 
 Air mata yang jernih mengalir dari sudut matamu, tetapi, untuk apa mereka mengalir? 
 Sepertinya kamu agak tidak ingat. 
 Kamu merasa sangat sedih tanpa alasan.]]
  },
  Event_59600_Name = {
    Text = "Dissosiasi memori"
  },
  Event_59601_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59601_Desc = {
    Text = [[
Persahabatanmu dengan kucing tidak diragukan lagi. Kamu melambaikan tangan dan melanjutkan langkah tanpa menoleh.
"Bodoh! Bodoh!"
Suara di telinga terdengar penuh kemarahan.]]
  },
  Event_59601_Name = {
    Text = "bisikan rahasia"
  },
  Event_59602_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59602_Desc = {
    Text = "Kau bertekad, tidak peduli berapa banyak harga yang harus dibayar, kau akan bertempur sampai detik terakhir dengan harapan semua orang."
  },
  Event_59602_Name = {
    Text = "Masa Depan Terkunci"
  },
  Event_59603_ChoiceDesc1 = {
    Text = "[Mengatasi] Memperoleh Relik perak [(RelicConfig.Arg1)]"
  },
  Event_59603_ChoiceDesc2 = {
    Text = "[Mendapatkan] Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_59603_Desc = {
    Text = [[
Di balik pintu yang dijaga oleh Tawil terdapat dunia yang tak berujung dan kebenaran yang tak terbatas. 
 Kamu tidak tahu apa yang dia lihat di balik pintu, tetapi kamu tahu dia mengetahui segalanya. 
 Sekarang pintu ini terbuka di depanmu, semua kebenaran mengeluarkan undangan yang tak bersuara di balik pintu.]]
  },
  Event_59603_Name = {
    Text = "Di balik pintu"
  },
  Event_59604_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59604_Desc = {
    Text = [[
Hendaknya kita menghormati keberadaan yang tidak dikenal, menghindari ketajaman mereka adalah pilihan yang bijaksana. 
 Kamu menundukkan kepala, menggenggam erat kunci perak di dadamu, merasakan sedikit penghiburan. 
 Setidaknya kamu masih memiliki kekuatan, masih ada Awakener. 
 Kamu berusaha mengabaikan pandangan-pandangan itu, fokus pada jalan di depan. 
 Tapi, apakah pandangan-pandangan itu benar-benar menghilang? Kamu tahu jawabannya.]]
  },
  Event_59604_Name = {
    Text = "Pandangannya"
  },
  Event_59605_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59605_Desc = {
    Text = [[
Jika semua cara melawan Dewa seperti semut yang mencoba mengguncang pohon, satu-satunya hal yang bisa kau pegang teguh adalah keberanian untuk tidak menyerah. 
 Ketika Kehancuran tanpa akhir menekan dari langit, kau akan menjadi yang berdiri paling depan.]]
  },
  Event_59605_Name = {
    Text = "Jawaban saya"
  },
  Event_59606_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59606_Desc = {
    Text = [[
Kamu tertegun menyentuh tetesan air mata yang terus mengalir, dengan saksama merasakan kesedihan yang tidak tahu dari mana asalnya. 
 Seolah-olah banyak hal yang sangat berharga telah kamu buang dengan tanganmu sendiri, tetapi kamu sudah tidak ingat itu apa. 
 Sungguh disayangkan. 
 Kamu mengelap air mata dengan lemah, dan di dalam air mata itu muncul senyuman pahit.]]
  },
  Event_59606_Name = {
    Text = "Dissosiasi memori"
  },
  Event_59607_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59607_Desc = {
    Text = [[
Kamu mengabaikan suara mereka.
Kamu tidak peduli apakah kucing itu pembohong atau tidak, kamu hanya percaya pada Kekuatanmu sendiri.
Suara di telingamu mulai menghela napas.]]
  },
  Event_59607_Name = {
    Text = "bisikan rahasia"
  },
  Event_59608_ChoiceDesc1 = {
    Text = "[Mencari Jawaban] Mendapatkan Arg1 Segil hitam, terinfeksi [(Skill.Arg2)], lanjutkan memilih"
  },
  Event_59608_ChoiceDesc2 = {
    Text = "[Menyerah] Pergi"
  },
  Event_59608_Desc = {
    Text = [[
Ada yang tertawa gila. 
Dirinya yang menganggap segala sesuatu adalah perjuangan yang sia-sia, lebih baik menyerah lebih awal. 
Kamu mengernyitkan dahi, dirinya itu tiba-tiba tersenyum dan berpaling, dia berkata lebih baik mengakhiri nyawa semua orang dengan tangan sendiri, daripada membiarkan orang-orang mengalami penderitaan. 
Kamu melambaikan tangan untuk mengusir suara itu, meneguhkan keyakinanmu.]]
  },
  Event_59608_Name = {
    Text = "Pertanyaan Diri Saya"
  },
  Event_59609_ChoiceDesc1 = {
    Text = "[Konfirmasi] Hapus 2 Kartu"
  },
  Event_59609_ChoiceDesc2 = {
    Text = "[Mendapatkan] Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_59609_ChoiceDesc3 = {
    Text = "[Pergi]mendapatkan Arg1 Segil hitam"
  },
  Event_59609_Desc = {
    Text = [[
Dalam penantian yang panjang, kamu sekali lagi membuka alat komunikasi, mungkin kerinduan dan doamu telah membuahkan hasil, kamu melihat kertas balasan yang terus memunculkan tanggapan yang akrab dan hangat darinya. 
 Dia sekarang sangat aman, para pengajar sudah membuat rencana, semua berjalan lancar di Mythag... 
 Kamu melihat berita baik yang datang seperti salju, hati tidak bisa menahan bergetar.]]
  },
  Event_59609_Name = {
    Text = "Gema Hipnotis"
  },
  Event_59610_ChoiceDesc1 = {
    Text = "[Mengumpulkan Bintang] Tingkatkan 1 Relik Perak menjadi Relik Emas [(RelicConfig.Arg1)]"
  },
  Event_59610_ChoiceDesc2 = {
    Text = "[Menghancurkan Bintang] Mendapatkan Relik Emas \"(RelicConfig.Arg1)\", Infeksi \"(Skill.Arg2)\" dan \"(Skill.Arg3)\""
  },
  Event_59610_ChoiceDesc3 = {
    Text = "[Menonton dalam diam] Mendapatkan 25 Segil Hitam"
  },
  Event_59610_Desc = {
    Text = [[
Emosimu terlepas bersama ingatan, kamu merasakan dirimu sedang menjadi suatu keberadaan yang besar, seperti monster yang kembali ke sarangnya yang kuno dan hangat. 
 Ribuan suka, duka, marah, dan sedih dipadatkan, berubah menjadi bintang-bintang yang bersinar, menurunkan hujan cahaya di dimensi spiritualmu. 
 Jejak-jejak yang pernah kamu tinggali menghilang seperti meteor. 
 Kamu diam-diam memperhatikan, mengangkat sebuah bintang di depanmu, di dalamnya terdengar tawa ceria milikmu. 
 Maka kamu juga tertawa, manis seperti madu.]]
  },
  Event_59610_Name = {
    Text = "Kristal Emosional"
  },
  Event_59611_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59611_Desc = {
    Text = [[
Kau tahu bahwa semua ini hanyalah bayangan masa lalu, kau membantai orang-orang yang pernah berbicara denganmu tanpa ekspresi. 
 Tawa dan air mata mereka hancur di tanganmu, kau tidak bisa berhenti sedikitpun. 
 Jika ini adalah ujian yang diperlukan, kau akan berperan sebagai algojo yang paling kejam.]]
  },
  Event_59611_Name = {
    Text = "Bayangan Masa Lalu"
  },
  Event_59612_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59612_Desc = {
    Text = [[
Bulu lembutnya yang halus dan matanya yang jernih secara alami membuatmu merasa percaya. 
Kamu mendekati kucing itu, dan kucing itu juga mendekatimu. 
Tidak ada kata-kata di antara kalian, namun ekornya tegak lurus ke atas.]]
  },
  Event_59612_Name = {
    Text = "Godaan Kucing"
  },
  Event_59613_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59613_Desc = {
    Text = [[
Kamu menahan dorongan rasa penasaran, kamu tahu pintu ini seharusnya tidak dibuka. 
 Terlalu banyak kebenaran terkadang adalah sebuah kutukan. 
 Kamu menggenggam erat kunci perak di dadamu, bertekad untuk selamanya menutup pintu ini.]]
  },
  Event_59613_Name = {
    Text = "Di balik pintu"
  },
  Event_59614_ChoiceDesc1 = {
    Text = "[Keberanian] Tingkatkan secara acak efek Orison pada 2 Kartu"
  },
  Event_59614_ChoiceDesc2 = {
    Text = "[Keputusan] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_59614_Desc = {
    Text = [[
Kata-kata Tawil bergema di dalam benakmu. 
 Dari sekian banyak akhir, hanya satu jalan yang benar. 
 Dalam keadaan samar, kamu melihat banyak bayangan dunia berkelebat di depan matamu seperti potongan-potongan film, menunggu saat untuk menekan tombol dan membekukan momen itu. 
 Setelah detik ini, akhir seperti apa yang akan dihadapi dunia?]]
  },
  Event_59614_Name = {
    Text = "Masa Depan Terkunci"
  },
  Event_59615_ChoiceDesc1 = {
    Text = "[Mengabaikan Keraguan]Mendapatkan 50 Segil Hitam"
  },
  Event_59615_ChoiceDesc2 = {
    Text = "[Kepala Dingin]mendapatkan 75 Segil hitam, terinfeksi[(Skill.Arg2)]"
  },
  Event_59615_Desc = {
    Text = [[
Seiring dengan ejekan N, kamu mulai meragukan semua orang yang pernah kamu temui. 
Mana yang merupakan jelmaannya, dan mana yang benar-benar guru atau temanmu? 
Bayangannya terus berubah, seolah ada banyak wajah di dalamnya, semuanya menyeringai ke arahmu.]]
  },
  Event_59615_Name = {
    Text = "Seratus Wajah Bayangan"
  },
  Event_59616_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59616_Desc = {
    Text = "Jika semua orang mungkin melakukan penghianatan, maka jangan bergantung pada siapa pun.\nDalam kegelapan, kamu hanya bisa memastikan satu kebenaran.\nSetidaknya kamu masih memiliki dirimu sendiri — dirimu yang paling setia untuk dipercaya."
  },
  Event_59616_Name = {
    Text = "Seratus Wajah Bayangan"
  },
  Event_59617_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59617_Desc = {
    Text = [[
Kamu mencengkeram dengan kuat, kristal yang bersinar hancur menjadi serbuk di ujung jarimu. 
 Kamu dengan serakah menghirup emosi yang berasal dari masa lalu. 
 Dalam sekejap, kebahagiaan yang mendalam mengalir ke dalam otakmu, lalu perlahan-lahan menghilang seperti ilusi. 
 Sudut-sudut mulutmu terangkat tinggi, lalu perlahan turun. 
 Wajahmu perlahan menjadi tenang tanpa gelombang.]]
  },
  Event_59617_Name = {
    Text = "Kristal Emosional"
  },
  Event_59618_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59618_Desc = {
    Text = [[
Kamu tahu bahwa segala sesuatu memiliki harganya. Jika harga untuk menyelamatkan adalah pengorbanan, maka biarlah harga itu sepenuhnya dibayar oleh dirimu sendiri. 
 Kamu sudah siap untuk membayar semuanya kapan saja.]]
  },
  Event_59618_Name = {
    Text = "Jawaban saya"
  },
  Event_59619_ChoiceDesc1 = {
    Text = "[Mencari Jawaban] Mendapatkan Arg1 Segil hitam, terinfeksi [(Skill.Arg2)], lanjutkan memilih"
  },
  Event_59619_ChoiceDesc2 = {
    Text = "[Menyerah] Pergi"
  },
  Event_59619_Desc = {
    Text = [[
Ada yang berteriak.
Diriku sendiri yang ingin melarikan diri dengan putus asa, dia berkata bahwa perlawanan sudah pasti akan gagal.
Hanya pelarian tanpa akhir yang bisa menunda kehancuran terakhir.
Kamu merasa ragu-ragu.]]
  },
  Event_59619_Name = {
    Text = "Pertanyaan Diri Saya"
  },
  Event_59620_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59620_Desc = {
    Text = [[
Kau tahu betapa mengerikannya kecepatan reproduksi embrio, baru lahir di sini adalah kutukan seperti belalang. 
 Kau menghancurkan mereka sebelum bayi-bayi itu mengeluarkan suara menangis. 
 Orang-orang yang terdiri dari darah dan daging memandangmu dengan penuh kebencian, mempertanyakan mengapa kau melakukan profanasi terhadap kehidupan yang suci. 
 Kau menjawab dengan pembunuhan yang tiada henti.]]
  },
  Event_59620_Name = {
    Text = "Bayangan Masa Lalu"
  },
  Event_59621_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59621_Desc = {
    Text = [[
Saat ini, kamu berharap menjadi orang yang paling beruntung, yang bisa mendapatkan akhir yang paling memuaskan. 
 Namun, harga dari keberuntungan kadang-kadang lebih kejam, keberuntungan dan ketidakberuntungan sering kali berjalan beriringan. Ketika kamu mendapatkan sesuatu, jangan lupa untuk memeriksa apa yang telah hilang.]]
  },
  Event_59621_Name = {
    Text = "Pilihan Nasib"
  },
  Event_59622_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59622_Desc = {
    Text = [[
Kamu seolah-olah sedang berebut kemudi mobil yang sama dengan orang lain, kedua tanganmu bergerak cepat, berusaha mengendalikan ritme lagu. 
 Dalam perlawanan yang sulit, kamu tiba-tiba menekan satu baris tuts piano dengan keras. 
 Permainan yang kacau itu terganggu olehmu, kamu tersenyum sinis, terjebak dalam pertarungan antara kegilaan dan kegilaan yang lebih dalam.]]
  },
  Event_59622_Name = {
    Text = "Lagu Pesta Kiamat"
  },
  Event_59623_ChoiceDesc1 = {
    Text = "[Keakraban] Mendapatkan 25 Segil Hitam"
  },
  Event_59623_ChoiceDesc2 = {
    Text = "[Perhatikan] 50% kesempatan mendapatkan 50 Segil Hitam, 50% kesempatan tidak mendapatkan apa-apa."
  },
  Event_59623_Desc = {
    Text = [[
Di sisimu ada seekor kucing yang mengikuti, bulunya halus dan bersih, cakar depannya seputih salju. 
Kucing itu selalu menemanimu, melangkah tepat di belakangmu seperti pelayan paling setia. 
Semua kebingungan dan ketidakberdayaan, rasa sakit dan kegelisahan dalam hatimu telah lenyap.]]
  },
  Event_59623_Name = {
    Text = "Godaan Kucing"
  },
  Event_59624_ChoiceDesc1 = {
    Text = "[Menyangkal] terinfeksi \"(Skill.Arg1)\", memperoleh Relik terkutuk \"(RelicConfig.Arg2)\""
  },
  Event_59624_ChoiceDesc2 = {
    Text = "[Menyangkal] Terinfeksi dua kali \"(Skill.Arg1)\", mendapatkan Relik perak \"(RelicConfig.Arg2)\" dan \"(RelicConfig.Arg3)\""
  },
  Event_59624_ChoiceDesc3 = {
    Text = "[Diam] memperoleh Relik perak [(RelicConfig.Arg1)]"
  },
  Event_59624_Desc = {
    Text = [[
Kamu terjebak dalam suatu ilusi yang hampa. 
 Kamu melihat banyak orang terdiam di bawah bayangan kiamat, sekecil debu. 
 Mereka tampak kosong, kelabu, kehilangan harapan. 
 Kamu mendengar tawa tajam seseorang. 
 "Lihat, ini adalah hasil dari keteguhan kalian." 
 "Dunia tidak pernah memiliki akhir, segala sesuatu tidak ada artinya."]]
  },
  Event_59624_Name = {
    Text = "Lamb to the slaughter"
  },
  Event_59625_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59625_Desc = {
    Text = [[
Tidak, ini tidak benar, ini tidak nyata. 
Kamu terus menyangkal suara kegilaan itu, namun sosok kelabu itu tetap acuh tak acuh, seolah membenarkan akhir yang ilusi. 
Tawa itu semakin keras, mengejek ketidakberdayaanmu.]]
  },
  Event_59625_Name = {
    Text = "Lamb to the slaughter"
  },
  Event_59626_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59626_Desc = {
    Text = [[
Kamu merasakan rasa penyesalan dan ketidakrelakan yang besar, kamu secara naluriah berusaha keras untuk mengingat, mencoba mencari bayangan masa lalu di antara pecahan-pecahan ingatan. 
 Bayangan-bayangan samar itu dengan cepat mundur, kamu berusaha meraih untuk menangkapnya, tetapi hanya bisa melihat gambar-gambar itu mengalir dari celah-celah jari. 
 Kamu menyadari bahwa kamu akan segera kehilangan segalanya.]]
  },
  Event_59626_Name = {
    Text = "Dissosiasi memori"
  },
  Event_59627_ChoiceDesc1 = {
    Text = "[Keakraban] Mendapatkan 25 Segil Hitam"
  },
  Event_59627_ChoiceDesc2 = {
    Text = "[Perhatikan] 50% kesempatan mendapatkan 50 Segil Hitam, 50% kesempatan tidak mendapatkan apa-apa."
  },
  Event_59627_Desc = {
    Text = [[
Di sisimu ada seekor kucing yang mengikuti, bulunya halus dan bersih, cakar depannya seputih salju. 
Kucing itu selalu menemanimu, melangkah tepat di belakangmu seperti pelayan paling setia. 
Semua kebingungan dan ketidakberdayaan, rasa sakit dan kegelisahan dalam hatimu telah lenyap.]]
  },
  Event_59627_Name = {
    Text = "Godaan Kucing"
  },
  Event_59628_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59628_Desc = {
    Text = [[
Kamu bertemu dengan dirimu yang terakhir di sini, pertempuran yang menghancurkan seluruh dunia sebenarnya hanyalah tatapan antara kalian berdua. 
 Ketika Dia memandangmu, kamu harus teguh menatap balik ke arah-Nya, sampai salah satu dari tatapan itu menghilang.]]
  },
  Event_59628_Name = {
    Text = "Jawaban saya"
  },
  Event_59629_ChoiceDesc1 = {
    Text = "[Mendapatkan] Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_59629_ChoiceDesc2 = {
    Text = "[Counter] mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_59629_ChoiceDesc3 = {
    Text = "[Meronta] Mendapatkan 25 Segil hitam"
  },
  Event_59629_Desc = {
    Text = [[
Derap langkah kaki yang intens terdengar, sekelompok Agen dari Komite menghalangi jalur Anda. 
"Mohon kerja sama dalam Penyelidikan kami." 
Suara dingin itu menyiratkan niat jahat. 
Pluk, permukaan air yang tenang pecah, mereka melemparkan Anda ke dalam kolam dalam.]]
  },
  Event_59629_Name = {
    Text = "Tenggelam ke jurang"
  },
  Event_59630_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59630_Desc = {
    Text = [[
Kamu berjuang dengan sekuat tenaga.
Maju, sedikit lagi ke depan.
Apa pun yang terjadi, kamu harus menjaga semua ini.
Kamu mencoba meraih dengan tanganmu, benang itu mengiris kulit dan dagingmu, namun kamu tidak merasakannya sama sekali.]]
  },
  Event_59630_Name = {
    Text = "Tangan yang Dimanipulasi"
  },
  Event_59631_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59631_Desc = {
    Text = [[
Kamu menggelengkan kepala dengan keras, melemparkan ingatan yang kacau dari otakmu. 
 Suara yang bising segera menghilang, kesadaranmu akhirnya pulih kembali. 
 Kamu tidak bisa mendapatkan bantuan dari masa lalu yang gagal, hanya dengan fokus pada saat ini kamu bisa menemukan harapan.]]
  },
  Event_59631_Name = {
    Text = "Pertanyaan Diri Saya"
  },
  Event_59632_ChoiceDesc1 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_59632_Desc = {
    Text = [[
Sebelum kamu mengulurkan tangan, tiba-tiba kamu teringat bahwa kamu tidak pernah memelihara seekor kucing seperti ini. 
 Kamu dan kucing itu saling menatap melalui udara, lalu kucing itu berkedip padamu. 
 Kucing itu tidak peduli dengan sikap dinginmu, tetapi sepertinya ia tetap mencintaimu.]]
  },
  Event_59632_Name = {
    Text = "Godaan Kucing"
  },
  Event_59633_ChoiceDesc1 = {
    Text = "[Mencari Jawaban] Mendapatkan Segil hitam Arg1, terinfeksi [(Skill.Arg2)]"
  },
  Event_59633_ChoiceDesc2 = {
    Text = "[Menyerah] Pergi"
  },
  Event_59633_Desc = {
    Text = [[
Ada yang sedih hingga menangis.
Dirinya yang penuh dengan kesedihan, ingin memeluk orang yang paling dicintainya.
Tidak bisa bersama dengan orang-orang yang disayangi saat Kehancuran menjadi penyesalan terbesar mereka.
Hatimu terasa sakit, dan tanpa sadar kamu ikut bersedih.]]
  },
  Event_59633_Name = {
    Text = "Pertanyaan Diri Saya"
  },
  Event_59634_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59634_Desc = {
    Text = [[
Kamu memandang tak terhitung banyaknya bayangan abu-abu, mengabaikan tawaan yang mengejek. 
Bagaimana cara menyelamatkan dunia yang hancur? 
Kamu terus berpikir dalam keheningan kehancuran.]]
  },
  Event_59634_Name = {
    Text = "Lamb to the slaughter"
  },
  Event_59635_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59635_Desc = {
    Text = [[
Udara dalam alveoli perlahan menghilang, kamu mencoba bernapas di bawah air. 
 Betapa bodohnya tindakan itu, namun kamu berhasil. 
 Alveolimu kembali terisi, dan kamu bisa bernapas lega. 
 Namun, apa sebenarnya yang terus-menerus kamu hirup?]]
  },
  Event_59635_Name = {
    Text = "Tenggelam ke jurang"
  },
  Event_59636_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59636_Desc = {
    Text = [[
Kamu tenggelam dalam cairan kental. 
Meskipun kamu berusaha keras untuk melepaskan diri, kamu hanya semakin terjerumus. 
Kamu tidak bisa melarikan diri dari rawa ini sendirian.]]
  },
  Event_59636_Name = {
    Text = "Tenggelam ke jurang"
  },
  Event_59637_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59637_Desc = {
    Text = [[
Kamu memaksa dirimu untuk melupakan keraguan ini. 
 Kamu tahu bahwa pada saat ini keraguan adalah yang paling tidak berguna, kamu hanya bisa berusaha untuk percaya. 
 Sebelum kotak yang tersegel dibuka, kamu tidak bisa mengetahui kebenaran di dalam kotak itu. 
 Terkadang, menjadi orang bodoh yang bingung lebih mudah untuk mendapatkan ketenangan.]]
  },
  Event_59637_Name = {
    Text = "Seratus Wajah Bayangan"
  },
  Event_59638_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59638_Desc = {
    Text = [[
Semua mata tertuju padamu, kamu harus menjadi pemimpin bagi semua orang dan tidak boleh menunjukkan kelemahan sedikit pun.
"Pergi ke Kolam Hitam, semuanya akan baik-baik saja."
Kamu memberikan instruksi dengan tenang, membuat janji yang bahkan mungkin tidak kamu percayai sendiri.]]
  },
  Event_59638_Name = {
    Text = "Mata Kebodohan"
  },
  Event_59639_ChoiceDesc1 = {
    Text = "[Mencurigai] terinfeksi \"(Skill.Arg1)\", memperoleh Relik terkutuk \"(RelicConfig.Arg2)\""
  },
  Event_59639_ChoiceDesc2 = {
    Text = "[Mengabaikan] Terinfeksi dua kali \"(Skill.Arg1)\", mendapatkan Relik perak \"(RelicConfig.Arg2)\" dan \"(RelicConfig.Arg3)\""
  },
  Event_59639_ChoiceDesc3 = {
    Text = "[Mengabaikan] Mendapatkan Relik perak [(RelicConfig.Arg1)]"
  },
  Event_59639_Desc = {
    Text = [[
Di depanmu ada tiga bayangan yang ragu-ragu, mereka bergumam sesuatu. 
 Kamu mendekatkan telinga untuk mendengar, suara yang diucapkan dan napas menjadi jelas. 
 "Jangan percaya pada kucing itu, dia seorang penipu." 
 Kamu tiba-tiba menoleh, tetapi mendapati tidak ada seorang pun di sampingmu.]]
  },
  Event_59639_Name = {
    Text = "bisikan rahasia"
  },
  Event_59640_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59640_Desc = {
    Text = [[
Bintang terlihat begitu lezat, kamu menginginkan kekuatannya dan menelannya sekaligus. 
Gluk. 
Kamu merasakan rohmu terisi penuh seperti tak pernah sebelumnya, ada cahaya berkilauan di sudut pandangmu. 
Ketika menunduk, bintang itu masih bersinar di dalam perutmu.]]
  },
  Event_59640_Name = {
    Text = "Bintang Permintaan"
  },
  Event_59641_ChoiceDesc1 = {
    Text = "[Merangkak Maju] Hapus 1 Kartu Perintah, dapatkan Arg1 Segil Hitam"
  },
  Event_59641_ChoiceDesc2 = {
    Text = "[Menghancurkan benang] Salin 1 Kartu perintah, infeksi [(Skill.Arg1)]"
  },
  Event_59641_ChoiceDesc3 = {
    Text = "[Menahan Diri] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_59641_Desc = {
    Text = [[
Sepanjang jalan, kamu terdorong untuk maju. Semua pilihanmu dikendalikan oleh benang tak terlihat. 
 Kamu berusaha menggerakkan kedua tanganmu, ingin meraih segala sesuatu yang kau hargai. 
 Nasib dunia tergantung pada ujung jarimu. 
 Jalinan tanpa akhir melilit seluruh tubuhmu.]]
  },
  Event_59641_Name = {
    Text = "Tangan yang Dimanipulasi"
  },
  Event_59642_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59642_Desc = {
    Text = [[
Kamu menghapus darah dan air mata di sudut matamu, namun darah dan air mata yang tak terhitung jumlahnya terus mengalir. 
 Merah menyelimuti bidang pandangmu, seolah-olah menandakan pengorbanan yang berdarah. 
 Kamu terus mengelap, rasa sakit membuatmu bergetar, tetapi tidak membuatmu merasa takut sedikit pun.]]
  },
  Event_59642_Name = {Text = "Fusi saya"},
  Event_59643_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59643_Desc = {
    Text = [[
Kamu mengusap batu permata ajaib ini dan memasangnya pada kunci perak. 
 Cahaya bintang menyinari kamu. 
 Kamu merasa terpesona hingga pusing.]]
  },
  Event_59643_Name = {
    Text = "Bintang Permintaan"
  },
  Event_59644_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59644_Desc = {
    Text = [[
Kamu tidak peduli apa pun, terus memandang dengan mata terbuka, tekad di hatimu berubah menjadi raungan keras kepala. 
 Meskipun mungkin akan hancur dan menghilang, kamu tetap tidak akan mundur sedikit pun.]]
  },
  Event_59644_Name = {Text = "Fusi saya"},
  Event_59645_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59645_Desc = {
    Text = [[
Ada yang terdiam. 
Melihat wajah putus asa dan terdiam itu, kamu tahu bahwa mereka semua tidak berhasil bertahan sampai akhir. 
Kamu adalah dirimu sendiri yang paling jauh melangkah; hanya jawaban dari dirimu sendirilah harapan terakhir.]]
  },
  Event_59645_Name = {
    Text = "Pertanyaan Diri Saya"
  },
  Event_59646_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59646_Desc = {
    Text = [[
Kamu mengulurkan tanganmu, terus meraih dari ribuan meteor yang melintas, kristal yang bersinar meluncur di ujung jarimu. 
 Kebahagiaan, kesedihan, kemarahan, ketakutan... 
 Kamu dengan serakah mengambil setiap emosi, namun melihatnya menghilang dari tanganmu. 
 Cahaya yang megah menerangi wajahmu, dan pupil matamu perlahan menjadi hitam dan dalam.]]
  },
  Event_59646_Name = {
    Text = "Kristal Emosional"
  },
  Event_59657_ChoiceDesc1 = {
    Text = "[Panggilan] Mendapatkan Relik perak [(RelicConfig.Arg1)]"
  },
  Event_59657_ChoiceDesc2 = {
    Text = "[Sentuh] untuk mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_59657_Desc = {
    Text = [[
Kamu menyaksikan boneka itu terjebak dalam kehancuran. 
 Dia dulunya adalah makhluk yang paling rasional, dan juga asisten yang paling setia, yang dengan serius menjaga semua informasi yang kalian peroleh. 
 Namun sekarang dia sepertinya tidak lagi mengingat semua yang kalian alami bersama. 
 Kamu melihat cairan bening menetes dari sudut mata boneka itu.]]
  },
  Event_59657_Name = {
    Text = "Air Mata Boneka"
  },
  Event_59658_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59658_Desc = {
    Text = [[
Kamu tidak menyerah, mencoba menghubungi inti energi-nya. 
 Selama itu mekanis, pasti bisa diperbaiki dengan di-restart, kan? 
 Sayangnya, boneka yang tidak berperasaan itu tidak memberimu kesempatan yang naif. 
 Tindakanmu untuk menahan diri tidak membawa belas kasihan dari boneka, jadi kamu hanya bisa bertarung dengan segenap tenaga.]]
  },
  Event_59658_Name = {
    Text = "Air Mata Boneka"
  },
  Event_59659_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_59659_Desc = {
    Text = [[
Kamu tidak ingin menimbulkan kerusakan pada bekas rekanmu.
Kamu berteriak memanggil namanya, mencoba semua perintah, namun tidak ada hasilnya.
Boneka itu melakukan penghianatan terhadap kalian dan kembali ke dinginnya benda tak bernyawa.]]
  },
  Event_59659_Name = {
    Text = "Air Mata Boneka"
  },
  Event_60944_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_60944_Desc = {
    Text = [[
Waktumu tidak banyak tersisa, dan kamu memilih cara penanganan yang paling langsung, menerobos blokade. Pembangun-pembangun menjadi termotivasi dan juga semakin bersemangat. 
Adapun musuh yang menjadi lebih waspada, itu tidak perlu dikhawatirkan.]]
  },
  Event_60944_Name = {
    Text = "Agen Komite"
  },
  Event_60945_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_60945_Desc = {
    Text = [[
Sebelum agen itu menyadari, kalian mengitari ke belakangnya dan menyita senjatanya. Sebelum bala bantuan tiba, kalian berhasil meninggalkan tempat itu. 
 Sayangnya, berita sudah menyebar, musuh di belakang telah bersiap, mungkin akan menjadi lebih sulit untuk dihadapi. Bersiaplah.]]
  },
  Event_60945_Name = {
    Text = "Agen Komite"
  },
  Event_60946_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_60946_Desc = {
    Text = [[
Agen tertarik oleh suara peluit dan berjalan menuju tempat persembunyian kalian. Saat dia mendekat, para Pembangun yang sudah lama menunggu segera melancarkan serangan. 
Sebuah penyergapan yang sempurna, ancaman di sini telah sepenuhnya dihilangkan.]]
  },
  Event_60946_Name = {
    Text = "Agen Komite"
  },
  Event_60947_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_60947_Desc = {
    Text = [[
Menghadapi banyak musuh, kamu tidak mampu melawan mereka. Kamu sengaja masuk ke dalam jangkauan pandangan mereka tanpa melakukan perlawanan.
Kamu tahu bahwa kalian akan segera dikirim ke tempat penahanan, ini adalah bagian dari rencana.
Kalian akan melarikan diri dari sana dan mencari jalur baru.]]
  },
  Event_60947_Name = {
    Text = "Titik Pengawasan"
  },
  Event_60948_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_60948_Desc = {
    Text = [[
Menghadapi banyaknya musuh, kamu tidak dapat melawan mereka. Setelah pertempuran singkat, kalian memutuskan untuk menyerah. 
Kamu tahu bahwa kalian akan segera dikirim ke tempat penahanan, ini adalah bagian dari rencana. 
Kalian akan melarikan diri dari sana dan mencari jalan baru.]]
  },
  Event_60948_Name = {
    Text = "Titik Pengawasan"
  },
  Event_60949_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_60949_Desc = {
    Text = [[
Menghadapi jumlah musuh yang banyak, kamu tidak mampu melawan mereka. 
 Kamu memutuskan untuk sementara meninggalkan tempat ini dan mencari jalur baru.]]
  },
  Event_60949_Name = {
    Text = "Titik Pengawasan"
  },
  Event_61058_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_61058_Desc = {
    Text = [[
Kamu menatap kedua tanganmu, seluruh tubuhmu, hatimu dipenuhi dengan harapan dan tekad. 
Jika semua ini adalah takdir, kamu sudah siap menghadapi segalanya. 
Di saat terakhir, jika ada pintu menuju surga atau neraka, maka biarlah kamu yang membuka pintu itu untuk dunia.]]
  },
  Event_61058_Name = {
    Text = "Melihat secara diam-diam"
  },
  Event_61059_ChoiceDesc1 = {
    Text = "[Siapkan Pertempuran] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_61059_ChoiceDesc2 = {
    Text = "[Lanjutkan Observasi] Infeksi [(Skill.Arg1)], Orison ulang, maksimal dilakukan 1 kali"
  },
  Event_61059_Desc = {
    Text = "Kamu tidak terburu-buru untuk bertarung, dengan tenang mencoba untuk memahami situasi. Konduktor yang tiba-tiba muncul ini terlihat seperti musuh namun juga bisa jadi teman, kamu tidak jelas apa yang dia siapkan. Bagaimanapun, kamu memutuskan untuk mempersiapkan diri dengan baik, menghadapi tantangannya terlebih dahulu, lalu perlahan-lahan mengamati apa yang sebenarnya ingin dia lakukan."
  },
  Event_61059_Name = {
    Text = "Konduktor Setan"
  },
  Event_61060_ChoiceDesc1 = {
    Text = "[Mendengarkan] Mendapatkan 1 dari 3 Orison tingkat lanjut"
  },
  Event_61060_ChoiceDesc2 = {
    Text = "[Teriakan] Memperoleh Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_61060_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_61060_Desc = {
    Text = [[
Sejak kecelakaan itu terjadi, kamu tidak pernah menerima kabar dari rekanmu. 
 Tak terhitung banyaknya kontak yang dikirim, seperti batu yang jatuh ke laut tanpa gema. 
 Pada saat kamu sudah putus harapan, alat komunikasi tiba-tiba mengeluarkan suara. 
 Kamu membuka kotak dan mendekatkan gagang telepon ke telinga. 
 "Penjaga..." 
 Dalam keadaan samar, kamu mendengar suara yang selalu kamu rindukan, seperti gema yang jauh di balik lapisan kosong.]]
  },
  Event_61060_Name = {
    Text = "Gema Kerinduan"
  },
  Event_61061_ChoiceDesc1 = {
    Text = "[Menerima Kegelapan] Mendapatkan Relik Perak \"(RelicConfig.Arg1)\", Terinfeksi \"(Skill.Arg2)\""
  },
  Event_61061_ChoiceDesc2 = {
    Text = "[Coba berenang] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_61061_ChoiceDesc3 = {
    Text = "[Membangunkan Hantu] Mendapatkan 25 Segil Hitam"
  },
  Event_61061_Desc = {
    Text = [[
Kamu berlari ke depan, tiba-tiba tanah di bawah kakimu berubah menjadi lautan yang tak bisa dilalui. 
 Kamu jatuh ke dalam tanah. 
 Seperti hantu di pemakaman yang muncul bersamaan, kegelapan kental yang tak terhitung jumlahnya mengelilingi kamu, dengan rakus menyerbu mulut dan hidungmu.]]
  },
  Event_61061_Name = {
    Text = "Terbenam ke tanah"
  },
  Event_61062_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_61062_Desc = {
    Text = [[
Kamu membelalak, berusaha mencari semua petunjuk yang ada. 
 Seratus mata berputar serentak, kamu melihat cakar anjing bermuka manusia yang berlari di depanmu, kamu melihat jejak tongkat komando Hameln yang berputar di belakangmu. 
 Kamu mengamati semuanya dengan penuh keserakahan. 
 Tiba-tiba, kamu melihat sebuah bola mata yang familiar jatuh di tanah. 
 Sepertinya itu adalah matamu sendiri.]]
  },
  Event_61062_Name = {
    Text = "Keserakahan akan Pengetahuan"
  },
  Event_61063_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_61063_Desc = {
    Text = [[
Tidak, kamu tidak mungkin melihat begitu banyak hal. 
 Jelas sekali kamu hanya memiliki... hanya beberapa mata, kan? 
 Kamu segera menutup mata, meraba wajahmu. 
 Satu, dua... 
 Ketika kamu membuka mata lagi, bidang pandangmu kembali menjadi sempit dan tidak tahu. 
 Ternyata kamu hanya memiliki dua mata, sayang sekali, sayang sekali.]]
  },
  Event_61063_Name = {
    Text = "Keserakahan akan Pengetahuan"
  },
  Event_61064_ChoiceDesc1 = {
    Text = "[Mencari] Memperoleh Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_61064_ChoiceDesc2 = {
    Text = "[Tutup Mata] 1 Kartu perintah acak mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_61064_Desc = {
    Text = [[
Semakin banyak petunjuk yang kusut seperti benang yang terjalin, kamu merasa gelisah, bingung, dan marah, kamu membenci dirimu sendiri karena tidak tahu apa-apa. 
 Tekanan yang besar membuat jiwamu tegang seperti benang tipis. 
 Dengan suara ledakan, kamu merasakan kulit kepalamu tiba-tiba rileks, dan kamu bisa melihat semua pemandangan di sekitarmu, melihat bayangan yang bergetar di dalam kehampaan. 
 Lebih banyak, kamu masih perlu melihat lebih banyak...]]
  },
  Event_61064_Name = {
    Text = "Keserakahan akan Pengetahuan"
  },
  Event_61065_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_61065_Desc = {
    Text = [[
Kamu berenang di dalam tanah, membayangkan dirimu sebagai ikan yang paling lincah. 
 Untuk menjadi ikan, kamu harus melepaskan kedua kaki manusia. 
 Ini adalah harga dari transaksi. 
 Segera, kamu merasakan kenyamanan yang belum pernah ada sebelumnya, kamu menjadi makhluk yang paling bebas di bawah tanah. 
 Kamu berenang kembali ke permukaan, tetapi sudah lupa bagaimana cara berjalan.]]
  },
  Event_61065_Name = {
    Text = "Terbenam ke tanah"
  },
  Event_61066_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_61066_Desc = {
    Text = [[
Ujung jarimu menyentuh Kunci perak yang sudah familiar, itu adalah inti dari semua cahaya.
Ini adalah esensi Hidupmu, ini adalah manifestasi takdirmu.
Kenangan masa lalu berkedip di depan mata.
Pilihanmu sudah terikat erat dengan pilihan dunia ini.
Takdirmu sudah terhubung dengan banyak orang.]]
  },
  Event_61066_Name = {
    Text = "Melihat secara diam-diam"
  },
  Event_61067_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_61067_Desc = {
    Text = [[
Kamu merasakan banyak kehadiran yang hangat mengelilingimu. 
Kamu mencoba memanggil hantu-hantu yang mungkin tidak nyata. 
Keajaiban terjadi, dan kamu kembali ke permukaan tanah. 
Ribuan nisan tetap terdiam dalam kesunyian.]]
  },
  Event_61067_Name = {
    Text = "Terbenam ke tanah"
  },
  Event_61068_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_61068_Desc = {
    Text = [[
Kamu tidak punya waktu untuk merenung, kamu hanya ingin segera menyelamatkan semua yang runtuh ini. 
Jika kamu berubah menjadi bintang, biarkan dirimu menjadi meteor. 
Asalkan bisa menerangi langit malam, meskipun pada akhirnya akan jatuh.]]
  },
  Event_61068_Name = {
    Text = "Melihat secara diam-diam"
  },
  Event_61069_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_61069_Desc = {
    Text = [[
Kau menempelkan telinga lebih dekat, menyerap semua suara kecil ke dalam pikiranmu. 
 "Aku..." 
 "Kau pasti..." 
 Kau hanya bisa mendengar kalimat yang terputus, tidak dapat membedakan makna apa pun. 
 Namun kau tidak berani bersuara, takut melewatkan satu kata pun. 
 Namun nasib tidak memberimu lebih banyak belas kasih. 
 Suara yang tersisa juga menghilang, dan sekeliling kembali dalam keheningan.]]
  },
  Event_61069_Name = {
    Text = "Gema Kerinduan"
  },
  Event_61070_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_61070_Desc = {
    Text = "Kamu tidak melanjutkan berpikir lebih jauh, lalu memerintahkan Pembangun untuk berbaris dan menyambut tantangannya."
  },
  Event_61070_Name = {
    Text = "Konduktor Setan"
  },
  Event_61071_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_61071_Desc = {
    Text = [[
Kamu terus memanggil namanya, berusaha menyampaikan bahkan sedikit perasaan. 
 Kamu tidak tahu apakah dia mendengarnya, kamu berusaha membedakan suara samar di mikrofon. 
 Itu sepertinya adalah jawabannya, tetapi juga seolah-olah banyak potongan masa lalu yang diputar kembali. 
 Memutar kembali suka dan duka serta pertemuan yang kalian alami bersama.]]
  },
  Event_61071_Name = {
    Text = "Gema Kerinduan"
  },
  Event_61072_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_61072_Desc = {
    Text = [[
Mungkin kegelapan ini adalah dunia yang nyata, apa salahnya jika bergabung di dalamnya? 
 Kamu telah sepenuhnya menerima kegelapan, dan kegelapan pun tidak lagi menolakmu, kamu bisa bernapas dengan bebas. 
 Detik berikutnya kamu kembali ke permukaan, mungkin ada sesuatu yang akan selamanya tertinggal di bawah tanah, tetapi itu sudah tidak penting lagi.]]
  },
  Event_61072_Name = {
    Text = "Terbenam ke tanah"
  },
  Event_61073_ChoiceDesc1 = {
    Text = "[Memandang Cahaya] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_61073_ChoiceDesc2 = {
    Text = "[Menyentuh dada] Pilih 1 Pembangun untuk dibangunkan, infeksi [(Skill.Arg1)]"
  },
  Event_61073_ChoiceDesc3 = {
    Text = "[Lanjutkan Berlari] Dapatkan 25 Segil Hitam"
  },
  Event_61073_Desc = {
    Text = [[
Kamu merasa bingung, hanya bisa berlari dengan sekuat tenaga, tanpa waktu untuk berpikir banyak. 
 Tiba-tiba, kamu merasakan dada kosong. 
 Kamu menunduk untuk melihat, dan di tempat jantungmu seharusnya ada cahaya berbentuk kunci. 
 Cahaya itu semakin terang, perlahan menyebar ke seluruh tubuhmu. 
 Kamu melihat dirimu berubah menjadi sebuah bintang. 
 Kamu tiba-tiba mengerti, mungkin inilah misi yang telah kamu cari selama ini.]]
  },
  Event_61073_Name = {
    Text = "Melihat secara diam-diam"
  },
  Event_61074_ChoiceDesc1 = {
    Text = "[Siapkan Pertempuran] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_61074_ChoiceDesc2 = {
    Text = "[Amati dengan cermat] Infeksi [(Skill.Arg1)], Orison ulang, maksimal 2 kali"
  },
  Event_61074_Desc = {
    Text = "\"Hei…… tunggu! Ada apa ini……\"\n\"Latihan.\"\nPria itu menatapmu tanpa ekspresi.\n\"Menggunakan suara musik untuk mempertahankan tautan pembangun adalah percobaan baru. Pastikan tingkat orkestra tetap tinggi agar pertunjukan bisa sempurna.\"\nTongkat konduktor di tangannya terangkat dan dengan jelas ia ayunkan, membentuk simbol pembuka yang elegan di udara.\n\"Mainkan, Penjaga. Aku ingin melihat apa yang bisa kau lakukan.\""
  },
  Event_61074_Name = {
    Text = "Konduktor Setan"
  },
  Event_61075_ChoiceDesc1 = {
    Text = "[Siapkan Pertempuran] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_61075_Desc = {
    Text = "Apa pun tujuannya, setidaknya dia menyelamatkanmu dari serangan Komite. Jika dia berniat jahat terhadapmu, dia tidak perlu membantumu sama sekali. Kamu mulai tenang dan bersiap untuk langkah terakhir."
  },
  Event_61075_Name = {
    Text = "Konduktor Setan"
  },
  Event_65400_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_65400_Desc = {
    Text = "Petugas kontak menyampaikan komitmen bantuan dari luar kepada kalian. Mendengar bahwa tim penyelamat sedang berupaya masuk ke gunung, semua orang merasakan harapan kembali menyala."
  },
  Event_65400_Name = {
    Text = "Titik Kontak"
  },
  Event_65401_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_65401_Desc = {
    Text = [[
Tidak ada satu pun anggota Tim Penelitian yang selamat keluar dari Gunung Salju. Di hadapan bencana, kamu selalu memilih diri sendiri. Nyawa orang biasa tidak ada artinya di matamu. Kamu mengorbankan kemanusiaanmu dan berhasil sampai di akhir dengan aman. 
 Para petugas penyelamat memandangmu dengan ekspresi yang rumit, sementara kamu tidak merasa apa-apa dan berbalik melangkah ke dalam angin dan salju. Mungkin saat mimpi di tengah malam, jiwa-jiwa yang kehilangan nyawa karena ketidakpedulianmu akan mengelilingi tempat tidurmu, diam-diam menatapmu.]]
  },
  Event_65401_Name = {
    Text = "Titik Evakuasi Aman"
  },
  Event_65402_ChoiceDesc1 = {
    Text = "[Pengungsian Warga] Hapus Relik \"Tim Ekspedisi\". Berdasarkan jumlah anggota Tim Ekspedisi, dapatkan \"Medali Penyelamatan\" dengan level yang berbeda."
  },
  Event_65402_Desc = {
    Text = [[
Kamu telah mengantarkan Tim Penelitian dengan aman ke titik evakuasi, tim penyelamat mengambil alih segalanya, orang-orang yang diselamatkan terkulai di tanah, seolah-olah berada di dunia lain. 
 Namun kamu tahu, krisis yang sebenarnya jauh dari selesai, makhluk raksasa itu masih berdiam di pegunungan, menunggu dengan perut keroncongan untuk kalian.]]
  },
  Event_65402_Name = {
    Text = "Titik Evakuasi Aman"
  },
  Event_65403_ChoiceDesc1 = {
    Text = "[Penukaran Pasokan] Mendapatkan 25 Segil Hitam, setiap ada 1 anggota tim ekspedisi akan mendapatkan tambahan 1 Segil Hitam (Arg1)."
  },
  Event_65403_ChoiceDesc2 = {
    Text = "[Janji Penyelamatan] Pilih untuk mendapatkan 1 Orison. Tambahkan 2 anggota tim ekspedisi ilmiah."
  },
  Event_65403_ChoiceDesc3 = {
    Text = "[Pragmatisme Utama] Kehilangan 10 anggota tim penelitian, pilih untuk mendapatkan satu Relik + Emas."
  },
  Event_65403_Desc = {
    Text = "Kalian berjuang melalui badai salju yang ganas, mengikuti cahaya redup dan berkedip dari tempat kontak darurat di kejauhan. \n    ○ Akhirnya, setelah berdoa berkali-kali, kalian melihat pondok kecil yang penuh harapan itu."
  },
  Event_65403_Name = {
    Text = "Titik Kontak"
  },
  Event_65403_Tips3 = {
    Text = "Jumlah anggota tim penelitian tidak mencukupi"
  },
  Event_65404_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_65404_Desc = {
    Text = "Kalian mengetahui kata sandi gudang kontak dari petugas kontak dan menemukan inventaris untuk dua hari bagi semua orang di dalamnya. Selamat, setidaknya kalian tidak akan mati kelaparan dan kedinginan di gunung salju."
  },
  Event_65404_Name = {
    Text = "Titik Kontak"
  },
  Event_65415_ChoiceDesc1 = {Text = "[OK]"},
  Event_65415_Desc = {
    Text = "Gunung Salju seketika menyelesaikan \"makan\"-nya, dua orang lenyap selamanya di celah es yang tak berdasar, dan kalian tidak mengetahui apa pun tentang hal itu."
  },
  Event_65415_Name = {Text = "Ilusi"},
  Event_65416_ChoiceDesc1 = {
    Text = "[Keluar] Mencari lampu sorot"
  },
  Event_65416_ChoiceDesc2 = {
    Text = "[Menerobos Badai Salju] Kehilangan 2 anggota tim penelitian."
  },
  Event_65416_Desc = {
    Text = [[
Angin kencang tiba-tiba bertiup di atas Gunung Salju, suara angin yang menderu di telinga seolah-olah adalah jeritan tajam dari binatang raksasa, kabut salju putih yang tebal seketika membutakan mata kalian, seolah-olah ada sesuatu yang bergerak di dalam kabut putih yang tak berujung. 
 Kalian terpaksa berhenti melangkah, berusaha menancapkan kedua kaki kalian dalam-dalam ke dalam tumpukan salju, agar tidak terguling ke lereng gunung.]]
  },
  Event_65416_Name = {
    Text = "tidak dikenal"
  },
  Event_65417_ChoiceDesc1 = {
    Text = "[Evaporasi Tanpa Suara] Kehilangan 2 anggota tim penelitian."
  },
  Event_65417_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_65417_Desc = {
    Text = [[
Perut gunung salju mengeluarkan raungan mengguntur, seperti binatang buas yang kelaparan mengeluarkan raungan ketidakpuasan, Bumi bergetar, lapisan es di bawah salju perlahan retak, seolah-olah gunung salju menganga. 
 Ketika getaran Bumi akhirnya berhenti, orang-orang bingung melihat sekeliling, kamu menoleh untuk memeriksa rombongan.]]
  },
  Event_65417_Name = {Text = "Ilusi"},
  Event_65468_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_65468_Desc = {
    Text = "Untuk memastikan mobilitas tim, kamu meninggalkan sebagian orang yang sulit bergerak dan membiarkan mereka tetap di pondok kecil yang terisolasi ini. Mungkin ini bisa meningkatkan tingkat kelangsungan hidup sisa anggota, tetapi apakah kamu benar-benar tidak merasakan gejolak di dalam hatimu saat melihat tatapan mereka yang penuh penyesalan dan kemarahan?"
  },
  Event_65468_Name = {
    Text = "Titik Kontak"
  },
  Event_65483_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_65483_Desc = {
    Text = [[
Kamu telah menyelamatkan beberapa orang, tetapi lebih banyak orang yang selamanya tertinggal di Gunung Salju. Bagaimanapun, kamu setidaknya telah berusaha. 
 Para petugas penyelamat menyatakan bahwa kontribusimu akan dihargai, kamu melambai, lalu berbalik dan melangkah ke dalam angin dan salju.]]
  },
  Event_65483_Name = {
    Text = "Titik Evakuasi Aman"
  },
  Event_65484_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_65484_Desc = {
    Text = [[
Kamu tidak memiliki waktu untuk memikirkan orang lain. Untuk keluar dari Gunung Salju, kamu mengambil cara yang paling efisien. Di mata para penyintas terakhir, kamu mungkin terlihat seperti iblis. 
 Para petugas penyelamat menyatakan bahwa kontribusimu akan dihargai, kamu melambai, lalu berbalik dan melangkah ke dalam angin dan salju.]]
  },
  Event_65484_Name = {
    Text = "Titik Evakuasi Aman"
  },
  Event_65485_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_65485_Desc = {
    Text = [[
Di bawah perlindunganmu yang tak kenal lelah, seluruh anggota Tim Penelitian selamat tanpa cedera. Bertemu denganmu adalah keberuntungan terbesar di antara kesulitan mereka, kamu adalah penyelamat sejati bagi mereka. 
 Kamu telah menciptakan keajaiban di tengah bencana, dan kabar tentang pahlawan Gunung Salju mungkin segera menyebar ke seluruh penjuru. Para petugas penyelamat dengan serius menyatakan bahwa kontribusi luar biasamu akan dihargai, kamu tersenyum dan melambai, lalu berbalik dan melangkah ke dalam angin dan salju.]]
  },
  Event_65485_Name = {
    Text = "Titik Evakuasi Aman"
  },
  Event_65486_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_65486_Desc = {
    Text = [[
Kamu benar-benar peduli pada kehidupan orang-orang. Sebagian besar orang diselamatkan olehmu, mereka menangis tersedu-sedu dan terus berterima kasih atas perlindunganmu sepanjang jalan. 
 Para petugas penyelamat dengan serius menyatakan bahwa kontribusi luar biasamu akan dihargai, kamu tersenyum dan melambai, lalu berbalik dan melangkah ke dalam angin dan salju.]]
  },
  Event_65486_Name = {
    Text = "Titik Evakuasi Aman"
  },
  Event_65487_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_65487_Desc = {
    Text = [[
Kamu melawan bencana yang tidak terduga dan merebut orang-orang dari tangan kematian. Berkat usahamu, akhir tragis sedikit berubah. 
 Para petugas penyelamat dengan serius menyatakan bahwa kontribusi berharga kamu akan dihargai, kamu tersenyum dan melambai, lalu berbalik dan melangkah ke dalam angin dan salju.]]
  },
  Event_65487_Name = {
    Text = "Titik Evakuasi Aman"
  },
  Event_6817_ChoiceDesc1 = {
    Text = "[Secukupnya] Dapatkan 1 dari 3 Orison"
  },
  Event_6817_ChoiceDesc2 = {
    Text = "[Tetap Membaca] 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6817_Desc = {
    Text = [[
Di bagian tertinggi rak buku kayu, ada sebuah buku dengan sampul berwarna kuning keemasan. Dari sudut pandang lantai, nama buku itu tidak terlihat. 
 Entah mengapa, kamu merasakan hasrat untuk membacanya... Hasrat ini dengan cepat membesar menjadi tidak tertahankan, dan tanpa memedulikan risiko mengganggu orang lain, kamu menaiki tangga kayu di samping rak buku, mengambil buku itu, dan dengan tidak sabar mulai membacanya... 
 Gambaran samar muncul di lautan pikiranmu, kamu tenggelam dalam lautan ilusi...]]
  },
  Event_6817_Name = {
    Text = "Gulungan Buku Kuning"
  },
  Event_6818_ChoiceDesc1 = {
    Text = "[Mendengarkan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6818_ChoiceDesc2 = {
    Text = "[Paduan Suara] Setiap ada satu Pembangun dengan nilai Aliemus 50 atau lebih, dapatkan 15 Segil hitam."
  },
  Event_6818_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 1 dari 3 pilihan Orison"
  },
  Event_6818_Desc = {
    Text = [[
Suara piano tiba-tiba terdengar di telingamu. Jari-jari berwarna hijau kebiruan melompat di atas tuts, menghasilkan suara yang elegan mengalir seperti air sungai. 
"Teman yang terkasih, maukah kau bermain duet denganku?"
Tangan itu tak bisa bicara, ia bertanya padamu melalui suara piano.]]
  },
  Event_6818_Name = {
    Text = "Hantu di samping piano"
  },
  Event_6819_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6819_Desc = {
    Text = "Ramona memandang ke arah sumber suara, namun hanya sempat melihat sebuah fatamorgana yang perlahan menghilang, tampak seperti gramofon yang melebur ke dalam dinding."
  },
  Event_6819_Name = {
    Text = "Telinga orang lain"
  },
  Event_6820_ChoiceDesc1 = {
    Text = "[Membersihkan mesin tik] Hapus 1 Kartu perintah, dapatkan 25 Segil hitam"
  },
  Event_6820_ChoiceDesc2 = {
    Text = "[Mencoba mengenali teks] Salin satu kartu dari dek, infeksi [(Skill.Arg1)]"
  },
  Event_6820_Desc = {
    Text = "Mesin tik di dalam koper tiba-tiba menyemburkan tinta kental yang pekat. Bersamaan dengan goyangan kereta, tinta itu memercik membentuk aliran linear seperti tirai air terjun."
  },
  Event_6820_Name = {
    Text = "Bisikan Mesin Tik"
  },
  Event_6821_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6821_Desc = {
    Text = "Pada saat kepalan tangan membubarkan fatamorgana, memori tiba-tiba menerjang otakmu. Kenangan demi kenangan menghantam jiwa, membuatnya terasa sesak dan sakit."
  },
  Event_6821_Name = {
    Text = "Fata Morgana"
  },
  Event_6822_ChoiceDesc1 = {
    Text = "[Membuang kertas surat] Menghapus 1 Kartu"
  },
  Event_6822_ChoiceDesc2 = {
    Text = "[Simpan dengan baik] Mendapatkan \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6822_Desc = {
    Text = [[
Menarik beberapa lembar kertas surat yang terjebak di dalam mesin tik, huruf-huruf yang basah mengeluarkan aroma tinta yang kuat, kamu melirik isi surat tersebut dan tanpa sadar mengernyitkan dahi. 
 Sebagian besar isi surat itu telah dihapus, dan yang tersisa pun tidak membentuk kalimat, tidak ada yang tersisa untuk dibaca.]]
  },
  Event_6822_Name = {
    Text = "Surat yang Digores"
  },
  Event_6823_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6823_Desc = {
    Text = [[
Kamu berusaha keras mengenali tulisan yang kabur di atas kertas. Tulisan itu terus berubah bentuk, lalu menampilkan isi yang benar-benar berbeda. 
"@2Saya pikir kamu sudah melihat berita itu di koran. 
Ya, ayahmu sudah mencoret kamu dari daftar pewaris... kami juga tidak mau@2
Setan, setan... 
Segera hentikan hubunganmu dengan Tuan Herbert, jika tidak, saya akan menghentikan bantuan keuangan untukmu..."]]
  },
  Event_6823_Name = {
    Text = "Seperti bertemu langsung"
  },
  Event_6824_ChoiceDesc1 = {
    Text = "[Memegang Kunci perak] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6824_ChoiceDesc2 = {
    Text = "[Tutup mata] Pilih 1 Pembangun untuk Bangun, infeksi [(Skill.Arg1)]"
  },
  Event_6824_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_6824_Desc = {
    Text = "Kamu ditarik oleh kehampaan yang luar biasa, merangkak di tanah dengan tubuh yang terpuntir, seolah-olah dimanipulasi oleh sesuatu dari luar Dimensi.@2. \n\"Tidak… tidak…\"\n Kewarasanmu runtuh sedikit demi sedikit, tawa dan jeritan mengerikan bercampur menjadi satu, seperti jaring raksasa yang mengikat kesadaranmu, hanya ada erangan tak jelas yang meluap dari mulutmu."
  },
  Event_6824_Name = {
    Text = "Mata Pandangan"
  },
  Event_6825_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6825_Desc = {
    Text = "Serahkan pada Penjaga untuk ditangani, entah individu macam apa yang akan Bangun."
  },
  Event_6825_Name = {
    Text = "Perak Kesepian"
  },
  Event_6826_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6826_Desc = {
    Text = "Melodi sedih mengalir di telinga, penderitaan dan rasa sakit memenuhi pikiran dan jiwa. Ketika seseorang menyadarinya, sudut matanya sudah basah."
  },
  Event_6826_Name = {
    Text = "Suara Tanpa Nama"
  },
  Event_6827_ChoiceDesc1 = {
    Text = "[Dorong pintu di sebelah kiri] untuk mendapatkan Relik perak [(RelicConfig.Arg1)]"
  },
  Event_6827_ChoiceDesc2 = {
    Text = "[Mendorong pintu di sebelah kanan] mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6827_Desc = {
    Text = [[
Pintu. Pintu. Tak terhitung banyaknya pintu. 
 Jumlah pintu tampaknya lebih banyak dibanding saat kamu dan Ramona berkeliling. 
 Kalian berhenti di koridor, bersiap untuk membuka pintu berikutnya. 
 Di belakang pintu di sebelah kiri, sunyi senyap, menunggu kedatangan kalian dengan penuh kesopanan. 
 Di belakang pintu di sebelah kanan terdengar suara percakapan yang tidak jelas.]]
  },
  Event_6827_Name = {
    Text = "Pintu Tak Terbatas"
  },
  Event_6828_ChoiceDesc1 = {
    Text = "[Mendengarkan dengan cermat] Memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6828_ChoiceDesc2 = {
    Text = "[Tutup telinga] Dapatkan 1 dari 3 Orison"
  },
  Event_6828_Desc = {
    Text = [[
Kamu hanya bisa mendengar suara ketukan tuts piano yang kacau, menyerang seperti badai yang dahsyat, seperti suara gemuruh ketika meteor menghantam tanah, seluruh piano bergetar karenanya. 
 Palu pemukul senar mengeluarkan suara berdecit, pedal yang melompat mengeluarkan jeritan yang menyakitkan. 
 Dalam suara musik yang aneh, melodi yang akrab terikat, menggesek gendang telingamu.]]
  },
  Event_6828_Name = {
    Text = "Suara Terlarang"
  },
  Event_6829_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6829_Desc = {
    Text = "\"Penyelidik William telah menyediakan inventaris darurat untuk Anda, harap periksa dan ketuk pin dada sebanyak tiga kali untuk konfirmasi.\""
  },
  Event_6829_Name = {
    Text = "Komunikasi Dukungan"
  },
  Event_6830_ChoiceDesc1 = {
    Text = "[Dorong pintu di sebelah kiri] Dapatkan 1 dari 3 Orison"
  },
  Event_6830_ChoiceDesc2 = {
    Text = "[Dorong pintu di sebelah kanan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6830_Desc = {
    Text = [[
Pintu. Pintu. Tak terhitung banyaknya pintu. 
 Jumlah pintu tampaknya lebih banyak dibandingkan saat kamu dan Ramona melakukan pengawasan. 
 Kalian berdiri di koridor, bersiap untuk mendorong pintu berikutnya. 
 Di belakang pintu di sebelah kiri, sunyi senyap, dengan sabar menunggu kedatangan kalian. 
 Di belakang pintu di sebelah kanan terdengar suara percakapan yang tidak jelas.]]
  },
  Event_6830_Name = {
    Text = "Pintu Tanpa Henti"
  },
  Event_6831_ChoiceDesc1 = {
    Text = "[Baca surat] Hapus 1 Kartu Perintah, dapatkan Arg1 Segil Hitam"
  },
  Event_6831_ChoiceDesc2 = {
    Text = "[Tutup kotak dengan baik]"
  },
  Event_6831_Desc = {
    Text = [[
Koper bergetar tak henti-hentinya, seakan-akan ada kehidupan yang sedang menggigit cangkang telur, siap untuk keluar dari dalam. 
 Kamu membuka koper itu tanpa bisa mengendalikan dirimu, dan kertas surat berhamburan keluar seperti kupu-kupu yang dilepaskan.]]
  },
  Event_6831_Name = {
    Text = "Surat Tak Terduga"
  },
  Event_6832_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6832_Desc = {
    Text = "Dering yang mendesak membuat hati gelisah. Kau mengangkat gagang telepon dan meletakkannya di atas meja. Dering itu tiba-tiba terhenti seolah dicekik, hanya menyisakan gema yang bergema di dalam pikiran."
  },
  Event_6832_Name = {
    Text = "Panggilan kereta"
  },
  Event_6833_ChoiceDesc1 = {
    Text = "[Mengambil foto] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_6833_ChoiceDesc2 = {
    Text = "[Periksa Film] Terinfeksi [(Skill.Arg1)], ganti Orison yang diperoleh di opsi 1. Dapat digunakan dua kali."
  },
  Event_6833_Desc = {
    Text = "Di sudut studio terdapat kamera tua, beberapa gulungan film, dan foto-foto yang menyebar. Mereka dengan setia mencatat pekerjaan serta estetika pembuat patung lilin."
  },
  Event_6833_Name = {
    Text = "mencatat dengan jujur"
  },
  Event_6834_ChoiceDesc1 = {
    Text = "[Melanjutkan Interogasi] Meningkatkan Kesehatan maksimum sebesar Arg1"
  },
  Event_6834_ChoiceDesc2 = {
    Text = "[Menangkap Bayangan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6834_Desc = {
    Text = [[
Bayangan membacakan dalam debu emas: 
"Mereka yang mengetahui kebenaran... 
Dengan Kunci sebagai otoritas, pasti akan menunjukkan jalan bagi umat manusia."
Ini adalah sebuah pepatah kuno.
Instingmu mengatakan bahwa itu sangat dekat dengan kebenaran yang kamu cari.
Dan instingmu selalu tepat.]]
  },
  Event_6834_Name = {
    Text = "Pengguna Kunci Perak"
  },
  Event_6835_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6835_Desc = {
    Text = "Kamu tidak menyembunyikan pengakuanmu terhadap bisikan gila itu, dan hampir saja kamu diikat ke meja makan oleh keberadaan tersebut di bawah godaan Kegilaan."
  },
  Event_6835_Name = {Text = "Pesta Air"},
  Event_6836_ChoiceDesc1 = {
    Text = "[Memanggil Burung Gagak]Mendapatkan 30 Segil Hitam, terinfeksi[(Skill.Arg2)]，lanjut memilih"
  },
  Event_6836_ChoiceDesc2 = {
    Text = "[Jauhkan Diri]"
  },
  Event_6836_Desc = {
    Text = [[
Kamu tidak pergi, dan mereka juga tidak pernah meninggalkanmu. 
 Seutas tali aneh menghubungkan Roh kalian, sepertinya mereka ingin berbicara denganmu.]]
  },
  Event_6836_Name = {
    Text = "Gagak yang Sendirian"
  },
  Event_6837_ChoiceDesc1 = {
    Text = "[Menyerah melawan] Hapus 1 Kartu Perintah, dapatkan Arg1 Segil Hitam"
  },
  Event_6837_ChoiceDesc2 = {
    Text = "[Mengembalikan kedua tangan]"
  },
  Event_6837_Desc = {
    Text = [[
Seekor, dua ekor, tiga ekor... 
Di wajah. Di jari-jari. Sekumpulan kupu-kupu seperti kembang api yang mekar di udara, berkilauan dengan cahaya seperti permata dalam kegelapan. 
Mesin tik ini tidak memiliki fungsi praktis, tetapi sangat ahli dalam menciptakan keindahan.]]
  },
  Event_6837_Name = {
    Text = "Ledakan Inspirasi"
  },
  Event_6838_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6838_Desc = {
    Text = "Hal yang lebih penting ada di hadapanmu. Kamu menutup kotak itu dengan tekad untuk tidak memikirkannya lagi, dan mesin tik pun perlahan-lahan terdiam."
  },
  Event_6838_Name = {
    Text = "Peringatan Tidak Diundang"
  },
  Event_6839_ChoiceDesc1 = {
    Text = "[Mendengarkan Bulan] Terinfeksi [(Skill.Arg1)]"
  },
  Event_6839_ChoiceDesc2 = {
    Text = "[Mendengarkan Bintang Kerdil] Terinfeksi [(Skill.Arg1)]"
  },
  Event_6839_ChoiceDesc3 = {
    Text = "[Mendengarkan Meteor] Kehilangan 25 Segil Hitam"
  },
  Event_6839_Desc = {
    Text = "Penuh semangat, terang, dan tak pernah pudar."
  },
  Event_6839_Name = {
    Text = "Suara Bintang dan Bulan"
  },
  Event_6840_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6840_Desc = {
    Text = [[
Pusat cahaya adalah setetes inti perak yang mengapur, namun akal sehat memberitahumu bahwa ia tidak memancarkan cahaya. 
 Pandangan mengejar sumber cahaya, namun langsung terperangkap dalam kegelapan dan jebakan yang tidak diketahui... 
]]
  },
  Event_6840_Name = {
    Text = "Cahaya Malam"
  },
  Event_6841_ChoiceDesc1 = {
    Text = "[Keluar] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_6841_Desc = {
    Text = [[
Utara, pintu keluar sisi utara! 
 Sama seperti keputusan Ramona, pasti ada jalan keluar di utara.]]
  },
  Event_6841_Name = {
    Text = "Terus ke utara"
  },
  Event_6842_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6842_Desc = {
    Text = [[
Oh... warna perak yang sempurna, melambangkan lelucon Jiwa terhadapmu. 
Lalu, pilihanmu berikutnya adalah?]]
  },
  Event_6842_Name = {
    Text = "Pertunjukan dimulai"
  },
  Event_6843_ChoiceDesc1 = {
    Text = "[Pergi] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6843_Desc = {
    Text = [[
Kamu menggelengkan kepala, melemparkan suara itu ke belakang pikiranmu. 
 Sebuah desahan yang hampir tak terdengar membawa bantuan.]]
  },
  Event_6843_Name = {
    Text = "Terus ke utara"
  },
  Event_6844_ChoiceDesc1 = {
    Text = "[Bagian Dalam Koridor] Terinfeksi [(Skill.Arg1)], apakah Anda ingin melanjutkan maju?"
  },
  Event_6844_ChoiceDesc2 = {
    Text = "[Melawan arus] Mendapatkan 25 Segil Hitam"
  },
  Event_6844_Desc = {
    Text = "Cahaya bulan memudar, dilahap oleh koridor, hanya menyisakan pintu yang dipenuhi aura tidak menguntungkan di hadapan mata."
  },
  Event_6844_Name = {
    Text = "Galeri Sunyi"
  },
  Event_6845_ChoiceDesc1 = {
    Text = "[Corridor Dalam] 1 Kartu Perintah acak mendapatkan Orison: [(EnchantConfig.Arg1)], apakah ingin melanjutkan maju?"
  },
  Event_6845_ChoiceDesc2 = {
    Text = "[Melawan arus] Mendapatkan 25 Segil Hitam"
  },
  Event_6845_Desc = {
    Text = "Tidak mengetahui keseluruhan gambaran, sebaiknya tidak terlalu dalam."
  },
  Event_6845_Name = {
    Text = "Galeri Sunyi"
  },
  Event_6846_ChoiceDesc1 = {
    Text = "[Bagian Dalam Koridor] Terinfeksi [(Skill.Arg1)], apakah Anda ingin melanjutkan maju?"
  },
  Event_6846_ChoiceDesc2 = {
    Text = "[Melawan arus] Mendapatkan 25 Segil Hitam"
  },
  Event_6846_Desc = {
    Text = "Pintu di sebelah kiri mengeluarkan suara tawa menyeramkan. Dia bergetar pelan, melepaskan serpihan-serpihan kejahatan."
  },
  Event_6846_Name = {
    Text = "Galeri Sunyi"
  },
  Event_6847_ChoiceDesc1 = {
    Text = "[Relik perak \"(RelicConfig.Arg1)\" diperoleh di koridor dalam, apakah kamu ingin melanjutkan maju?]"
  },
  Event_6847_ChoiceDesc2 = {
    Text = "[Melawan arus] Mendapatkan 25 Segil Hitam"
  },
  Event_6847_Desc = {
    Text = "Pintu di sebelah kanan terbuka lebar, darah membentuk jejak yang telah ditentukan di atas tanah."
  },
  Event_6847_Name = {
    Text = "Galeri Sunyi"
  },
  Event_6848_ChoiceDesc1 = {
    Text = "[Tidak ada apa pun lagi, kamu mundur keluar]"
  },
  Event_6848_Desc = {
    Text = "Siapa bilang harus selalu maju dengan keras kepala? Mundur selangkah, mungkin benar-benar ada langit yang luas dan lautan yang terbuka."
  },
  Event_6848_Name = {
    Text = "Galeri Sunyi"
  },
  Event_6849_ChoiceDesc1 = {
    Text = "[Patung lilin Perbaikan] Pilih Kartu dan turunkan Lelah Aritmetika sebesar 1"
  },
  Event_6849_Desc = {
    Text = [[
Pekerjaan perbaikan patung lilin sedang berlangsung. 
 Kamu bukanlah seorang pematung lilin profesional, dan juga belum pernah menerima pendidikan estetika yang sistematis. 
 Namun, kamu tetap dengan terampil mulai mencetak, membentuk, dan mewarnai... 
 Seolah-olah kamu dilahirkan untuk memegang pahat. 
 Seolah-olah ia dilahirkan untuk cacat, hanya untuk menunggu ukiran darimu.]]
  },
  Event_6849_Name = {
    Text = "Patung Lilin yang Belum Selesai"
  },
  Event_6850_ChoiceDesc1 = {
    Text = "[Patung lilin Perbaikan] Pilih Kartu dan turunkan Lelah Aritmetika sebesar 1"
  },
  Event_6850_Desc = {
    Text = "Galatea, Galatea…\nKamu mengikuti suara panggilan dan kembali menemukan patung lilin yang belum selesai.\nDia tampak sempurna, bahkan sampai membuatmu merasa tidak nyaman.\n\"Kejelekan adalah celah yang merobek kesempurnaan.\"\nDi saat-saat terakhir, kamu memutuskan untuk melakukan sesuatu."
  },
  Event_6850_Name = {
    Text = "Patung Lilin yang Belum Selesai"
  },
  Event_6851_ChoiceDesc1 = {
    Text = "[Terima Bayangan] 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6851_ChoiceDesc2 = {
    Text = "[Menyangkal Fatamorgana] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_6851_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_6851_Desc = {
    Text = [[
Di bawah jembatan besi yang berat dan gelap, di tepi sungai yang sunyi yang ditumbuhi alang-alang, tiba-tiba terbang seekor kupu-kupu yang berkilau. 
 Kupu-kupu itu ringan hinggap di telapak tanganmu, suara jeritan yang mengerikan terhenti, digantikan oleh suara gemuruh kereta yang melintasi rangka besi yang berkarat, suara letupan bara batubara yang terbakar, dan suara gesekan logam dari poros yang berputar......]]
  },
  Event_6851_Name = {
    Text = "Fatamorgana Rel"
  },
  Event_6852_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6852_Desc = {
    Text = "Ya, melarikan diri. Kamu dikejar oleh suatu makhluk, insting bertahan hidup membuatmu berlari sekuat tenaga hingga tidak ada jalan keluar. Tidak, seharusnya tidak ada jalan keluar... Bukan Anjing neraka, kan?"
  },
  Event_6852_Name = {Text = "Berlari"},
  Event_6853_ChoiceDesc1 = {
    Text = "[Ini tidak nyata] Mendapatkan Relik perak [(RelicConfig.Arg1)]"
  },
  Event_6853_ChoiceDesc2 = {
    Text = "[Jatuh, jatuh…] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6853_Desc = {
    Text = [[
Cermin yang terjatuh di tanah memiliki bingkai yang indah, di dalam bingkai ada bingkai lagi, di dalam bingkai ada bingkai lagi...
Alice melompat turun, terus jatuh di dalam lubang kelinci yang tak ada habisnya, dia melihat satu demi satu cermin, satu demi satu jiwa terperangkap di sini, namun dia tidak bisa melihat dirinya sendiri.]]
  },
  Event_6853_Name = {
    Text = "Cermin dalam cermin"
  },
  Event_6854_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6854_Desc = {
    Text = [[
Kamu mengamati Gunung Salju dari balik jendela yang diselimuti badai salju, banyak semut hitam sedang mengejar seekor semut hitam...
Alur pikiranmu tiba-tiba terputus.]]
  },
  Event_6854_Name = {
    Text = "Pengingat Gunung Berapi"
  },
  Event_6855_ChoiceDesc1 = {
    Text = "[Maju dan pegang] Dapatkan 25 Segil Hitam"
  },
  Event_6855_ChoiceDesc2 = {
    Text = "[Respon ramah] 50% kesempatan mendapatkan 50 Segil Hitam, 50% kesempatan tidak mendapatkan apa-apa"
  },
  Event_6855_Desc = {
    Text = [[
Seekor kucing yang tidak diketahui asalnya duduk di antara Lumpur Hitam, tubuhnya yang samar menunjukkan bahwa ia seharusnya adalah penghuni Dimensi Spiritual. 
 Bayangan yang tidak terlihat jelas wajahnya itu menatap Ramona dengan pandangan yang cerdas, ia mengangkat kaki depannya yang putih bersih, seolah-olah melambaikan tangan untuk memberi isyarat padanya.]]
  },
  Event_6855_Name = {
    Text = "Penduduk yang Berpindah-pindah"
  },
  Event_6856_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6856_Desc = {
    Text = [[
Sebuah potret kelompok yang penuh kegembiraan.
Patung lilin itu berpakaian mewah, duduk rapi di kursi dengan senyuman berlebihan yang sama di wajah mereka.
Mereka begitu harmonis, seperti yang bisa kau lihat di rumah sakit jiwa mana pun.

Tertanda: Tahun Hongji 305, @2 Rogers]]
  },
  Event_6856_Name = {
    Text = "Galeri Potret"
  },
  Event_6857_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6857_Desc = {
    Text = [[
Kamu hati-hati melepas Fragmen itu, lalu memeriksanya dengan cermat. Fragmen itu kembali diam tak bergerak. 
"Jangan ceroboh, jangan sembarangan menyentuhnya,"Boneka mengetuk belakang kepalamu pelan, "Aku tidak bisa membuatkanmu yang kedua dalam waktu singkat."]]
  },
  Event_6857_Name = {
    Text = "Brooch Tidak Tenang"
  },
  Event_6858_ChoiceDesc1 = {
    Text = "[Gunakan Kunci]"
  },
  Event_6858_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_6858_Desc = {
    Text = "Sebuah pintu menghalangi jalanmu. Kamu telah mencoba berbagai cara, namun pintu itu tetap tidak bergeming."
  },
  Event_6858_Name = {
    Text = "Pintu berkarat"
  },
  Event_6858_Tips1 = {
    Text = "Perlu mendapatkan \"Kunci berkarat\""
  },
  Event_6859_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6859_Desc = {
    Text = "Kamu merasa malu atas keputusan gegabahmu. \nSeorang Penjaga yang kompeten haruslah teliti, kamu tidak seharusnya sembarangan menyimpulkan bahwa mereka bukan \"barang berkualitas tinggi\". \nJadi, kamu memutuskan untuk mengamati mereka dengan cermat. Lima menit berlalu, sepuluh menit berlalu… \nOke, sekarang kamu bisa memberikan penilaianmu — \nmemang barang sampah."
  },
  Event_6859_Name = {
    Text = "Jiwa yang Terikat"
  },
  Event_6860_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6860_Desc = {
    Text = [[
Kamu dan teman-temanmu meletakkan senjata.
Ini bukan karena belas kasihan besar, melainkan karena kamu tahu tubuh mereka yang goyah tidak akan mampu bertahan lama.
Ternyata, penilaianmu benar.]]
  },
  Event_6860_Name = {Text = "Latihan"},
  Event_6861_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6861_Desc = {
    Text = [[
"Kejar aku!"
"Ayo, bodoh!"
"Kalau berani, tangkap kami!"
Suara anak-anak terdengar penuh kemenangan.
"Sialan! Berhenti di sana!"
Suara orang dewasa terdengar terengah-engah.]]
  },
  Event_6861_Name = {
    Text = "Kenangan Kami"
  },
  Event_6862_ChoiceDesc1 = {
    Text = "[Masuk] Menembus kabut, tiba di ujung lain."
  },
  Event_6862_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_6862_Desc = {
    Text = "Ini adalah orang yang kamu cari. Kamu telah menyelesaikan tugas."
  },
  Event_6862_Name = {
    Text = "Jalan satu arah 26"
  },
  Event_6863_ChoiceDesc1 = {
    Text = "[Peroleh] Relik perak [(RelicConfig.Arg1)]"
  },
  Event_6863_Desc = {
    Text = [[
Ah! Hanya selisih sedikit lagi! Tunggu sebentar, mengapa tiga dadu bisa menghasilkan sepuluh poin! 
 Dadu-dadu itu tergeletak dengan tenang di depanmu, tampak begitu patuh dan tak bersalah.]]
  },
  Event_6863_Name = {
    Text = "Perjudian Tanpa Henti"
  },
  Event_6864_ChoiceDesc1 = {
    Text = "[Peroleh] Relik emas [(RelicConfig.Arg1)]"
  },
  Event_6864_Desc = {
    Text = [[
Sial! Bukan pukul enam, tapi masih ada untungnya.
Jadi, sebenarnya pukul berapa?]]
  },
  Event_6864_Name = {
    Text = "Perjudian Tanpa Henti"
  },
  Event_6865_ChoiceDesc1 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_6865_Desc = {
    Text = [[
Meskipun tidak menebak dengan benar, masih bisa diterima. 
 Eh, berapa angka yang mereka pilih?]]
  },
  Event_6865_Name = {
    Text = "Perjudian Tanpa Henti"
  },
  Event_6866_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6866_Desc = {
    Text = "Kamu menundukkan kepala, memilah-milah serpihan gips, merangkai kembali potongan-potongannya. Sebagian dari tubuhnya perlahan-lahan terbentuk kembali di bawah tanganmu."
  },
  Event_6866_Name = {
    Text = "Menyusun Sisa-sisa Tubuh"
  },
  Event_6867_ChoiceDesc1 = {
    Text = "[Memungut Kunci]"
  },
  Event_6867_Desc = {
    Text = "Sekumpulan kunci yang berkarat. Dapat digunakan untuk membuka kunci pintu."
  },
  Event_6867_Name = {
    Text = "Kunci berkarat"
  },
  Event_6868_ChoiceDesc1 = {
    Text = "[Positif] 50% kemungkinan mendapatkan Relik emas \"(RelicConfig.Arg2)\", 50% kemungkinan terinfeksi \"(Skill.Arg3)\""
  },
  Event_6868_ChoiceDesc2 = {
    Text = "[Sisi Buruk] 50% kemungkinan mendapatkan 75 Segil Hitam, 50% kemungkinan terinfeksi [(Skill.Arg3)]"
  },
  Event_6868_ChoiceDesc3 = {
    Text = "[Silakan pilih terlebih dahulu] 50% kemungkinan mendapatkan Relik terkutuk \"(RelicConfig.Arg2)\", 50% kemungkinan terinfeksi \"(Skill.Arg3)\""
  },
  Event_6868_Desc = {
    Text = [[
Hanya sebuah permainan taruhan, kamu tidak akan kalah. 
Koin yang diukir dengan tekstur dilemparkan tinggi-tinggi, lalu jatuh dengan cepat, dan telapak tanganmu membuatnya terasa hangat.]]
  },
  Event_6868_Name = {
    Text = "Penjudi Terkenal"
  },
  Event_6869_ChoiceDesc1 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_6869_Desc = {
    Text = [[
"Mereka yang menggantungkan diri pada anugerah takdir, juga akan dijatuhkan oleh takdir itu sendiri."
Kamu memilih untuk pergi.]]
  },
  Event_6869_Name = {
    Text = "Penjudi Terkenal"
  },
  Event_6870_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6870_Desc = {
    Text = [[
"Penjaga."
Suara Ramona membuatmu tersadar kembali, namun, sensasi jatuh itu tidak lenyap begitu saja.]]
  },
  Event_6870_Name = {
    Text = "Cermin dalam cermin"
  },
  Event_6871_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6871_Desc = {
    Text = [[
Konon, serenada adalah lagu yang berasal dari cinta. 
 Ini dimainkan pada malam musim panas, di luar jendela para kekasih, ketika orang-orang berkumpul dan memainkan melodi yang penuh kasih. 
 Sederhana dan dangkal, tidak sesuai dengan estetika Rogers, tetapi tetap menjadi lagu andalannya. 
 Mungkin hanya dia sendiri yang tahu alasannya.]]
  },
  Event_6871_Name = {
    Text = "selera yang buruk"
  },
  Event_6872_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6872_Desc = {
    Text = [[
Kamu menolak tergoda oleh gumaman mereka. 
Kamu berkata: "Penuh kebohongan! Kalian terjebak dalam malam abadi yang gelap gulita, bagaimana bisa menjelajahi alam semesta?"
Mata-mata itu tertawa. Ribuan tawa bergabung menjadi gelombang suara yang besar, membuat jantungmu ikut bergetar. 
Mata berkata: "Dengan merampas mata lainnya. Setiap mata adalah sebuah alam semesta. Ketika kamu memiliki seribu mata, kamu akan memulai perjalanan ruang waktu yang sebenarnya."]]
  },
  Event_6872_Name = {Text = "Mata"},
  Event_6873_ChoiceDesc1 = {
    Text = "[Klaim] Dapatkan 1 dari 3 Relik Emas"
  },
  Event_6873_Desc = {
    Text = [[
Oh ya, bayangan yang dibenci itu adalah dirimu sendiri. 
 Kebencian yang menyembur bercampur dengan lumpur hitam di bawah kakimu, berdansa dengan cara yang terdistorsi. Jika tidak keberatan, ia juga ingin merayap ke bahumu.]]
  },
  Event_6873_Name = {
    Text = "Di bawah permukaan cermin"
  },
  Event_6874_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6874_Desc = {
    Text = "Tak lama kemudian, ikatan tiba-tiba mengendur, membuatmu terjatuh dengan tersandung. \nKamu menoleh ke belakang melihat benang yang tenang — \"Jangan mengaduk-aduk pasir hisap\", mungkin kalimat ini juga berlaku di Domain."
  },
  Event_6874_Name = {
    Text = "Terjebak dalam"
  },
  Event_6875_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6875_Desc = {
    Text = "Api Gnosis menyala, membakar habis semua belenggu——\nsetidaknya, begitulah menurutmu."
  },
  Event_6875_Name = {
    Text = "Terjebak dalam"
  },
  Event_6876_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6876_Desc = {
    Text = "Menggunakan seluruh kekuatan untuk melepaskan diri, benang memotong pakaian dan meninggalkan bekas luka kecil di kulit. \n Meskipun jaring laba-laba mengambil sesuatu sebagai \"biaya perjalanan\", perasaan lega tetap ada — kamu bebas."
  },
  Event_6876_Name = {
    Text = "Terjebak dalam"
  },
  Event_6877_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6877_Desc = {
    Text = [[
Surat yang dihasilkan oleh pertumbuhan berlebih yang mengalami pelarutan, sebagian besar informasi yang dihasilkannya juga akan dihapus. 
 Kamu tidak mendapatkan informasi berharga dari kertas surat itu, jadi kamu merobeknya dan menyebarkannya begitu saja.]]
  },
  Event_6877_Name = {
    Text = "Bagian Kupu-kupu"
  },
  Event_6878_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6878_Desc = {
    Text = "Meskipun tulisan sengaja dihapus, kamu tetap bisa dengan jelas merasakan——nilai dari surat itu."
  },
  Event_6878_Name = {
    Text = "Bagian Kupu-kupu"
  },
  Event_6879_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6879_Desc = {
    Text = [[
Berhati-hatilah.
Ramona membungkukkan tubuhnya, kembali ke koridor, dan menyelinap ke ruangan berikutnya.]]
  },
  Event_6879_Name = {
    Text = "Refleksi di Jendela"
  },
  Event_6880_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6880_Desc = {
    Text = [[
Kamu mengeluarkan teriakan putus asa. 
Gerombolan gagak tampaknya terpengaruh oleh suaramu, tak lama kemudian mereka menghilang tanpa jejak, meninggalkan noda hitam yang pekat.]]
  },
  Event_6880_Name = {
    Text = "Lagu Kawan-Kawan Gagak"
  },
  Event_6881_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6881_Desc = {
    Text = [[
Kamu meringkuk, berusaha membuat tubuhmu menjadi sebuah titik hitam. 
Dengan begitu, mereka tidak akan memperhatikanmu, kan? 
Entah berapa lama telah berlalu, kamu membuka kedua matamu. 
Kamu melihat cahaya.]]
  },
  Event_6881_Name = {
    Text = "Lagu Kawan-Kawan Gagak"
  },
  Event_6882_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6882_Desc = {
    Text = "Bayangan mengalir perlahan di antara celah-celah jari, meninggalkan jejak debu emas."
  },
  Event_6882_Name = {
    Text = "Pengguna Kunci Perak"
  },
  Event_6883_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6883_Desc = {
    Text = [[
Kamu mengacak-acak rambutmu secara sembarangan, khayalan dan pikiran liar berlomba-lomba memenuhi benakmu, gumpalan berbalut lendir hitam tersembunyi di kedalaman. 
Jika kau membelahnya, apa pemberian yang akan kau dapatkan?]]
  },
  Event_6883_Name = {
    Text = "Mengaduk otak"
  },
  Event_6884_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6884_Desc = {
    Text = "Noda minyak berwarna-warni perlahan memenuhi pandangan, emosimu tenggelam dalam kegembiraan yang tak terkendali."
  },
  Event_6884_Name = {
    Text = "Mengaduk otak"
  },
  Event_6885_ChoiceDesc1 = {
    Text = "[Dimasukkan ke dalam kantong]"
  },
  Event_6885_Desc = {
    Text = "Sebuah zat perak berwarna mendekati merkuri, disaring dari lendir pelarut, mengandung kekuatan roh yang besar, terutama digunakan untuk menghubungkan lebih banyak Pembangun dalam ritual."
  },
  Event_6885_Name = {Text = "Perak"},
  Event_6886_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6886_Desc = {
    Text = [[
Tawa riang tumpah dari dalam kotak. Setelah cahaya fluoresen yang hangat memudar, kamu melihat sebuah kartu dengan gambar tiga orang tongkat: kamu, Ramona berambut perak, dan Ogier berambut emas. Di sampingnya ada satu baris tulisan. 
   "Terima kasih kalian!"]]
  },
  Event_6886_Name = {
    Text = "Hadiah Baik Hati"
  },
  Event_6887_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6887_Desc = {
    Text = "Tubuhmu berhasil menghindari kawanan kupu-kupu, tetapi mereka tidak kehilangan targetnya, masuk ke dalam koper mu, dengan rakus menghisap tinta dari mesin tik."
  },
  Event_6887_Name = {
    Text = "Aliran Delusi"
  },
  Event_6888_ChoiceDesc1 = {
    Text = "[Menunjukkan Kesalahan] Pilih 1 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6888_ChoiceDesc2 = {
    Text = "[Setelah mendengarkan permainan] Untuk setiap Pembangun dengan nilai Aliemus 50 atau lebih, dapatkan 15 Segil hitam."
  },
  Event_6888_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 1 dari 3 pilihan Orison"
  },
  Event_6888_Desc = {
    Text = "Patung lilin anak laki-laki duduk di depan piano memainkan etude.\nGurunya — juga terbuat dari patung lilin, sedang memberikan bimbingan di sampingnya.\n133, 355, 244...\nSalah, setiap nada salah."
  },
  Event_6888_Name = {
    Text = "Pelajaran piano"
  },
  Event_6889_ChoiceDesc1 = {
    Text = "[Menyerah melawan] Hapus 1 Kartu Perintah, dapatkan Arg1 Segil Hitam"
  },
  Event_6889_ChoiceDesc2 = {
    Text = "[Mengembalikan kedua tangan]"
  },
  Event_6889_Desc = {
    Text = [[
Kamu tidak dapat melawan dorongan dalam hatimu. 
 Jari-jarimu seperti anak kecil yang tersesat di hutan, berkeliaran dan bermain di atas papan ketik... 
 Perlahan, beberapa kupu-kupu terbang keluar dari mesin tik. 
 Seekor, dua ekor, tiga ekor... 
 Di wajah, di jari-jari, sekumpulan kupu-kupu seperti kembang api yang mekar di udara, berkilauan dengan cahaya seperti permata dalam kegelapan. 
 Mesin tik ini tidak memiliki fungsi praktis, tetapi sangat ahli dalam menciptakan keindahan.]]
  },
  Event_6889_Name = {
    Text = "Ledakan Inspirasi"
  },
  Event_6890_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6890_Desc = {
    Text = "Kamu mengangkat kertas itu ke bawah cahaya merah gelap, takut melewatkan satu detail pun. \nIni adalah laporan pemeriksaan kesehatan, dan orang yang diperiksa ternyata Mason. \n\"Berat badan 40kg, kadar oksigen darah normal, tingkat Affiniti 30%, nilai Resonansi…\"\nKamu ingin terus membaca, tetapi tulisan itu perlahan-lahan menghilang. \nBersih seolah-olah tidak ada yang terjadi."
  },
  Event_6890_Name = {Text = "Mesin tik"},
  Event_6891_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6891_Desc = {
    Text = "Ya, kamu tidak sedang melarikan diri, kamu mengejar tujuan yang pasti — \"Anjing neraka\"yang berlarian ke kiri dan ke kanan di gang-gang kecil yang sempit dan berlumpur karena salju. Kamu tidak akan melupakan hal ini, sama seperti kamu tidak akan melupakan wajah orang yang menarikmu dari reruntuhan pada hari itu di Tunguska. …… Siapa dia?"
  },
  Event_6891_Name = {Text = "Berlari"},
  Event_6892_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6892_Desc = {
    Text = "Di luar ruang yang terisolasi ini, satu-satunya yang bisa kamu andalkan hanyalah dirimu sendiri."
  },
  Event_6892_Name = {
    Text = "Perjalan Mimpi Buruk"
  },
  Event_6893_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6893_Desc = {
    Text = "Krisis dan risiko berdampingan. Saat menyentuh gembok besi, lendir korosif membakar telapak tanganmu. Semoga Relik di balik Pintu sepadan dengan harapan."
  },
  Event_6893_Name = {
    Text = "Di balik pintu besi"
  },
  Event_6894_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6894_Desc = {
    Text = [[
Di dunia yang belum pernah kau sentuh, kau terhuyung-huyung namun Roh-mu yang goyah belum mencapai titik kehilangan akal sehat.
Kengerian dari hal-hal yang tidak diketahui, kau sangat memahaminya.]]
  },
  Event_6894_Name = {
    Text = "Perjalan Mimpi Buruk"
  },
  Event_6895_ChoiceDesc1 = {
    Text = "[Berteriak keras] Memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6895_ChoiceDesc2 = {
    Text = "[Merasakan Keheningan] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_6895_ChoiceDesc3 = {
    Text = "[Muncul ke permukaan] Mendapatkan 25 Segil Hitam"
  },
  Event_6895_Desc = {
    Text = [[
Kamu mendengar keheningan.
Sebuah keheningan yang diperbesar, seperti suara ombak, memenuhi seluruh ruang.

Kamu mengangkat kepala, seperti sebuah titik kecil yang menatap langit malam.]]
  },
  Event_6895_Name = {
    Text = "Air dari Masa Lalu"
  },
  Event_6896_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6896_Desc = {
    Text = [[
Kamu mendengarkan dengan seksama, mencari sumber suara, berusaha untuk menangkap penjahat yang mengganggu ini. 
 Namun, seolah-olah sengaja mempermainkanmu, ketika kamu mengira telah memaksa orang itu ke dalam keadaan terdesak, kamu selalu terjebak dalam siklus yang seperti dinding hantu, dan kamu kembali ke tempat yang sama. 
 Kamu dengan putus asa menendang dinding batu, namun sepotong batu jatuh dari dinding, menyimpan kilauan di dalam lubang yang tersembunyi di dinding.]]
  },
  Event_6896_Name = {
    Text = "Suara Jejak Misterius"
  },
  Event_6897_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6897_Desc = {
    Text = [[
Pasti ada masalah dengan pemutaran, pasti begitu. 
 Kamu tidak percaya pada takhayul dan memutar kembali jarum, dengan susah payah menahan suara musik yang tidak enak di paruh pertama, tetapi suara ketukan yang ada dalam ingatanmu tidak muncul. 
 Di belakangmu yang kosong, bayangan kecil di tanah itu sedang menghilang dengan diam-diam.]]
  },
  Event_6897_Name = {
    Text = "Suara Jejak Misterius"
  },
  Event_6898_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6898_Desc = {
    Text = [[
Tidak ada orang di sekitarmu, rahasia ketukan pasti tersembunyi di dalam mekanisme fonograf. 
 Karena percaya pada penilaianmu sendiri, kamu membongkar fonograf tua itu. 
 Selain komponen logam yang membusuk di dalamnya dan lapisan debu tebal, kamu tidak menemukan apa-apa. 
 Hanya ada sebuah desahan, mengalir di kabut, ringan seolah-olah berada dalam mimpi.]]
  },
  Event_6898_Name = {
    Text = "Suara Jejak Misterius"
  },
  Event_6899_ChoiceDesc1 = {
    Text = "[Putihnya Si Bodoh] memulihkan Arg1 poin Hidup"
  },
  Event_6899_ChoiceDesc2 = {
    Text = "[Kartu perintah] 1 kartu acak mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_6899_ChoiceDesc3 = {
    Text = "[Menolak untuk makan] Mendapatkan 25 Segil hitam"
  },
  Event_6899_Desc = {
    Text = [[
"Otak si Bodoh segar dan lezat seperti sup ikan yang sedang mendidih, sementara jantung si Gila dipanggang menjadi kue scone yang hangat, berdarah, dan menggugah selera."
Bayangan hitam itu menyeringai, menyodorkan hidangan dengan bahan-bahan misterius tepat di depanmu.
Kau menarik napas dalam-dalam, aroma yang memenuhi udara secara paksa masuk ke rongga hidungmu. Kelenjar air liur tanpa martabatmu telah menyerah duluan, ususmu berdenyut penuh kesedihan, mengeluarkan suara erangan lapar yang memilukan.]]
  },
  Event_6899_Name = {
    Text = "Festin Daging"
  },
  Event_6900_ChoiceDesc1 = {
    Text = "[Sentuh angin genta] Infeksi \"(Skill.Arg1)\", 1 kartu perintah acak mendapatkan orison: \"(EnchantConfig.Arg2)\""
  },
  Event_6900_ChoiceDesc2 = {
    Text = "[Amati Lonceng Angin] Infeksi \"(Skill.Arg1)\", 1 Kartu Perintah acak mendapatkan Orison: \"(EnchantConfig.Arg2)\""
  },
  Event_6900_ChoiceDesc3 = {
    Text = "[Kosong] 1 Kartu Perintah acak mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_6900_Desc = {
    Text = [[
Ting ting, ting ting... 
 Ini adalah sebuah lonceng angin yang berkarat, suara kaku merayap keluar dari celah-celahnya.]]
  },
  Event_6900_Name = {
    Text = "Loyang Angin Berkarat"
  },
  Event_6901_ChoiceDesc1 = {
    Text = "[Mengamati dengan tenang] Cobalah bertahan hidup"
  },
  Event_6901_ChoiceDesc2 = {
    Text = "[Mengayunkan senjata] Cobalah untuk menembus pengepungan"
  },
  Event_6901_ChoiceDesc3 = {
    Text = "[Menggenggam satu tangan] Mendapatkan 25 Segil Hitam"
  },
  Event_6901_Desc = {
    Text = "Tanah di bawah kakimu tiba-tiba muncul sebuah rawa hitam, tak terhitung tangan muncul dari dalamnya. \n Mereka memiliki berbagai macam warna kulit, bahan, dan tekstur, biru merak, bersisik, bermata, seolah berasal dari berbagai dimensi dan ruang, berusaha menarik korban malang berikutnya ke dalam keluarga besar mereka. \n Kamu memutuskan——"
  },
  Event_6901_Name = {
    Text = "Bekas Rawan Gelap"
  },
  Event_6902_ChoiceDesc1 = {
    Text = "[Tahan] Dapatkan 3 Kartu Perintah secara acak dari dek dan pilih 1 untuk disalin"
  },
  Event_6902_ChoiceDesc2 = {
    Text = "[Menggoyangkan Sebentar] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6902_ChoiceDesc3 = {
    Text = "[Tidak melakukan apa pun] mendapatkan 25 Segil hitam"
  },
  Event_6902_Desc = {
    Text = [[
Ting ting, ting ting... 
 Ini adalah sebuah lonceng angin yang berkarat, suara kaku merayap keluar dari celah-celahnya.]]
  },
  Event_6902_Name = {
    Text = "Lonceng Angin Kecil"
  },
  Event_6903_ChoiceDesc1 = {
    Text = "[Membantah mereka] Mendapatkan Relik perak [(RelicConfig.Arg1)], pilih untuk menginfeksi gejala sebanyak 1 kali."
  },
  Event_6903_ChoiceDesc2 = {
    Text = "Ikuti mereka: Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6903_ChoiceDesc3 = {
    Text = "[Mengajukan pandangan baru] Mendapatkan 25 Segil Hitam"
  },
  Event_6903_Desc = {
    Text = "\"Harap jaga jarak dengan kami.\"\nSekelompok tikus mengelilingimu, menjaga jarak setidaknya lima kaki dari dirimu. \n\"Kami berusaha berkembang biak, kami tumbuh subur, dan kami tidak pernah pilih-pilih makanan — sehingga kami membawa penyakit, kecemasan, dan penderitaan kepada manusia.\"\n\"Kami dan manusia seharusnya tidak terlalu dekat, ini bukan tempatmu.\"\nUntuk membuat para tikus merasa tenang, kamu memutuskan untuk —"
  },
  Event_6903_Name = {Text = "Wabah"},
  Event_6904_ChoiceDesc1 = {
    Text = "[Melanjutkan Jatuh] Terinfeksi [(Skill.Arg1)], apakah akan terus jatuh?"
  },
  Event_6904_ChoiceDesc2 = {
    Text = "[Meninggalkan pertarungan] Mendapatkan 25 Segil Hitam"
  },
  Event_6904_Desc = {
    Text = [[
"Kamu" mengundangmu. 
Di kedalaman spiral,"kamu" dari masa lalu dan masa depan memberikanmu "hadiah" dari Dimensi yang berbeda.]]
  },
  Event_6904_Name = {
    Text = "Jurang Spiral"
  },
  Event_6905_ChoiceDesc1 = {
    Text = "[Menangkap Gagak]mendapatkan 40 Segil hitam, terinfeksi[(Skill.Arg2)], terus memilih"
  },
  Event_6905_ChoiceDesc2 = {
    Text = "[Membiarkan Begitu Saja]mendapatkan 25 Segil hitam, pergi"
  },
  Event_6905_Desc = {
    Text = "Gagak kesepian dengan suara serak mencabut bulu hitamnya satu per satu. \n Ia gemetar karena rasa sakit, berteriak nyaring, namun tak mampu menghentikan gerakannya yang semakin cepat. \n \"Ka——ka——\" \n Air mata birunya yang bercampur cairan hitam mengalir dari matanya. Hanya kau yang menyaksikannya, tak seorang pun lainnya."
  },
  Event_6905_Name = {
    Text = "Air Mata Magma"
  },
  Event_6906_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6906_Desc = {
    Text = [[
Merah, penuh semangat, terbuka, dan memesona. Kebetulan aku mengenal seorang wanita seperti itu, suatu hari kalian akan bertemu dengannya. 
Lalu, pilihanmu berikutnya adalah?]]
  },
  Event_6906_Name = {
    Text = "Pertunjukan dimulai"
  },
  Event_6907_ChoiceDesc1 = {
    Text = "[Lantunan sorak-sorai]"
  },
  Event_6907_ChoiceDesc2 = {
    Text = "[Mengantuk]"
  },
  Event_6907_Desc = {
    Text = "Kamu bermimpi sangat panjang.\nDalam mimpi, kamu duduk di kursi penonton, melihat seorang anak laki-laki bernyanyi di atas panggung.\n\"Charlie tua memiliki seekor kucing tabby yang sangat dia cintai\nKetika dia menghilang tanpa alasan, dia mencarinya ke mana-mana.\"\n……\nSuara yang kosong dan kering terus berulang secara mekanis, tanpa henti……"
  },
  Event_6907_Name = {
    Text = "Upacara Penutupan IV"
  },
  Event_6908_ChoiceDesc1 = {
    Text = "[Membuka cabang di atas]"
  },
  Event_6908_ChoiceDesc2 = {
    Text = "[Membuka cabang di bawah]"
  },
  Event_6908_Desc = {
    Text = [[
Gnosis dari Domain yang tersisa saling terhubung, menciptakan medan kekuatan yang tidak stabil. 
 Mungkin, kamu bisa memutus Jalinan ini dan membuka jalan untuk dirimu sendiri.]]
  },
  Event_6908_Name = {
    Text = "Jalur yang Berbelit"
  },
  Event_6909_ChoiceDesc1 = {
    Text = "[Pergi] Pilih 2 Pembangun untuk Bangun"
  },
  Event_6909_Desc = {
    Text = [[
Kamu bangkit dan segera berlari menuju pintu. 
 "Kamu menyingkap kain penutup itu... 
 Rahasia, kamu telah menemukan rahasia..."
 Gelombang suara bergabung menjadi lautan kebisingan, lantai bergetar hebat dalam resonansi yang mengerikan. 
 Kamu tidak berani menoleh ke belakang, melarikan diri dari tempat itu dengan kecepatan penuh.]]
  },
  Event_6909_Name = {
    Text = "Upacara Penutupan V"
  },
  Event_6910_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6910_Desc = {
    Text = "Kamu tidak melawan, tentu saja, dan kamu juga tidak akan memilih untuk tenggelam dalam kesedihan."
  },
  Event_6910_Name = {
    Text = "Luka di tengkorak"
  },
  Event_6911_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6911_Desc = {
    Text = "Kamu tidak lagi melawan, membiarkan kotoran melahap tubuh dan rohmu. Setelah tidur panjang, cahaya perak jatuh ke tanganmu yang saling bertautan."
  },
  Event_6911_Name = {
    Text = "Luka di tengkorak"
  },
  Event_6912_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6912_Desc = {
    Text = "Semakin keras berusaha, semakin dalam kotoran di pikiran tenggelam. Di kedalaman otak yang dipenuhi dosa, tersembunyi sebuah pemberian misterius yang tak diketahui asal-usulnya."
  },
  Event_6912_Name = {
    Text = "Luka di tengkorak"
  },
  Event_6913_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6913_Desc = {
    Text = "Saat jaringan hancur, sesuatu melintas di benakmu, tampaknya seperti senyuman beberapa anak kecil."
  },
  Event_6913_Name = {
    Text = "Jaringan Wandering"
  },
  Event_6914_ChoiceDesc1 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_6914_Desc = {
    Text = "Kucing itu mengangguk dengan puas, lalu berubah menjadi sebuah bayangan dan langsung menghilang, meninggalkan beberapa benda bulat berwarna hitam."
  },
  Event_6914_Name = {
    Text = "Penduduk yang Berpindah-pindah"
  },
  Event_6915_ChoiceDesc1 = {
    Text = "[Baca surat] Hapus 1 Kartu Perintah, dapatkan Arg1 Segil Hitam"
  },
  Event_6915_ChoiceDesc2 = {
    Text = "[Tutup kotak dengan baik]"
  },
  Event_6915_Desc = {
    Text = "Kertas-kertas surat yang beterbangan memenuhi langit, mirip dengan desakan tanpa suara."
  },
  Event_6915_Name = {
    Text = "Surat Tak Terduga"
  },
  Event_6916_ChoiceDesc1 = {
    Text = "[Masuk] Menembus kabut, tiba di ujung lain."
  },
  Event_6916_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_6916_Desc = {
    Text = "Di hadapan jalan muncul sebuah terowongan tersembunyi. Di dalam terowongan itu, kabut hitam menyebar, tidak diketahui ke mana arahnya."
  },
  Event_6916_Name = {Text = "Terowongan"},
  Event_6917_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6917_Desc = {
    Text = [[
Kamu bertekad untuk mengakhiri penderitaannya, lalu meraih tubuhnya yang lembut, mengeratkan, terus mengeratkan... 
 Dia berjuang putus asa di telapak tanganmu, hingga akhirnya meledak menjadi semburan cairan hangat.]]
  },
  Event_6917_Name = {
    Text = "Air Mata Magma"
  },
  Event_6918_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6918_Desc = {
    Text = "Tenanglah, ini hanyalah memori orang lain yang terpecah di dalam Dimensi. Kamu memiliki bayangan. Namun, apakah orang di dalam bayangan itu benar-benar dirimu?"
  },
  Event_6918_Name = {
    Text = "Fragmen Memori·Bir"
  },
  Event_6919_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6919_Desc = {
    Text = [[
Kamu dengan keras mematahkan paruh tajam gagak yang berniat mencabik bulunya, tetapi ia terus memutar, dengan kekuatan begitu besar hingga membuat tulangmu bergetar. 
 Wajahmu memerah, dengan segenap tenaga kamu berhasil menahan tubuh gagak itu, menghentikan tindakannya yang gila dan menyakiti diri sendiri. 
 Saat kamu merasa lega, leher gagak yang sudah setengah botak itu tiba-tiba berputar ke belakang, tubuhnya melunak, dan di tanganmu ia berubah menjadi genangan cairan hitam yang kental.]]
  },
  Event_6919_Name = {
    Text = "Air Mata Magma"
  },
  Event_6920_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6920_Desc = {
    Text = [[
Kamu dengan dingin mengabaikan dering putus asa itu. 
Bahkan jika detik berikutnya kamu akan meledak kembali ke dunia primitif, bahkan jika kamu dan misi besar-mu akan ikut terkubur. 
Telepon yang tidak seharusnya dijawab, memang tidak boleh dijawab. 
Kamu sangat memahami prinsip sederhana ini.]]
  },
  Event_6920_Name = {
    Text = "Harap angkat telepon"
  },
  Event_6921_ChoiceDesc1 = {
    Text = "[Menunduk] Mendapatkan 25 Segil Hitam"
  },
  Event_6921_ChoiceDesc2 = {
    Text = "[Saya harus menemukan] Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6921_Desc = {
    Text = [[
Kamu mengejar bayangan hitam ke depan, tiba-tiba melangkah ke dalam genangan air dangkal. Cairan yang tidak berwarna membasahi permukaan sepatumu, menyusupkan sedikit rasa dingin. 
Sebuah suara di dalam air berkata: "Kamu tidak akan ingin menemukannya."]]
  },
  Event_6921_Name = {
    Text = "Kamu tidak akan ingin menemukan"
  },
  Event_6922_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6922_Desc = {
    Text = "Pilihan yang aman."
  },
  Event_6922_Name = {
    Text = "setelah tumpukan jerami"
  },
  Event_6923_ChoiceDesc1 = {
    Text = "[Mengusir Gagak] Mendapatkan Arg1 Segil hitam, terinfeksi [(Skill.Arg2)], lanjutkan memilih"
  },
  Event_6923_ChoiceDesc2 = {
    Text = "[Mengabaikan]mendapatkan 25 Segil hitam, pergi"
  },
  Event_6923_Desc = {
    Text = [[
Bagaimana mungkin ada gagak di dalam kamar sanatorium? 
 Tetapi kamu benar-benar mendengar suara tawa jahat gagak, di dalam bayangan ada kekuatan yang belum muncul di panggung, mengintip kalian dari mata burung yang kosong itu. Makhluk-makhluk hitam pekat itu memutar leher mereka, berdiri di lampu gantung di ujung lorong, menatapmu dengan tatapan penuh niat jahat. Kepala yang berbayang itu, seolah-olah berbagi tubuh yang terendam dalam Lumpur Hitam.]]
  },
  Event_6923_Name = {
    Text = "Lentera Gagak Hitam"
  },
  Event_6924_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6924_Desc = {
    Text = "Jangan takut pada kotoran, kamu mendapatkan lebih banyak daripada yang hilang."
  },
  Event_6924_Name = {
    Text = "setelah tumpukan jerami"
  },
  Event_6925_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6925_Desc = {
    Text = "Badai Gnosis berputar di sekitar Tulu, kalian saling bertatapan sejenak, lalu masuk ke dalam kegelapan satu per satu."
  },
  Event_6925_Name = {Text = "Janji Agen"},
  Event_6926_ChoiceDesc1 = {
    Text = "[Masuk] Menembus kabut, tiba di ujung lain."
  },
  Event_6926_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_6926_Desc = {
    Text = [[
Kamu terjatuh ke dalam kegelapan pekat.
Di ujung pandanganmu, hanya ada seberkas cahaya yang menembus celah sempit seperti lubang kunci.
Kunci perak itu memancarkan cahaya redup bak napas, membimbingmu masuk ke lorong rahasia tersebut.]]
  },
  Event_6926_Name = {
    Text = "Jalan satu arah"
  },
  Event_6927_ChoiceDesc1 = {
    Text = "[Terinfeksi\"(Skill.Arg1)\"，mendapatkan Relik:（\"(RelicConfig.Arg2)\"]"
  },
  Event_6927_ChoiceDesc2 = {
    Text = "[Pilih 1 dari 3 kartu perintah untuk mendapatkan Orison:\"(EnchantConfig.Arg1)\"]"
  },
  Event_6927_Desc = {
    Text = "Acara 203 (dalam pengembangan), bukan efek akhir"
  },
  Event_6927_Name = {
    Text = "Acara 203 (dalam pengembangan)"
  },
  Event_6928_ChoiceDesc1 = {
    Text = "[Hapus] Hapus satu Kartu Perintah, dapatkan Relik: [(RelicConfig.Arg1)]"
  },
  Event_6928_ChoiceDesc2 = {
    Text = "[Usap] Hapus satu kartu serangan/pertahanan, dapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_6928_ChoiceDesc3 = {
    Text = "[Muak] Mendapatkan 25 Segil hitam"
  },
  Event_6928_Desc = {
    Text = [[
"Apakah kamu menyukai tubuhku yang tersisa? Jika bisa, bisakah kamu membantu menyusun kembali tubuhku?"
Patung gips dengan hanya setengah tubuh menggerakkan bibirnya, suara lembut seperti kain tipis jatuh di telinga, mengalir dari bibir dan giginya yang seharusnya keras dan dingin.]]
  },
  Event_6928_Name = {
    Text = "Menyusun Sisa-sisa Tubuh"
  },
  Event_6929_ChoiceDesc1 = {
    Text = "[Buang amplop] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_6929_ChoiceDesc2 = {
    Text = "[Masukkan ke dalam pelukan] Terinfeksi \"(Skill.Arg1)\", mendapatkan Relik: \"(RelicConfig.Arg2)\""
  },
  Event_6929_Desc = {
    Text = "Ini adalah sebuah surat permohonan tolong. Penulisnya berusaha keras untuk tetap tenang, namun goresan pena yang kadang-kadang miring itu sepenuhnya mengungkapkan ketakutan mendalam yang ia sembunyikan.\n\"Semua ini benar-benar di luar dugaan. Jika ada yang mengatakan bahwa saya terkena kutukan saat ini, saya bersumpah akan mempercayainya tanpa ragu.\"\n\"Ada yang mengatakan bahwa saya gila, dia hanya benar separuh. Saya sedang berada di ambang kegilaan, bergoyang-goyang di tepi jurang.\"\n\"Tapi saya benar-benar melihatnya! Ia bermutasi dan menghilang, zat hitam lengket yang terus bertambah mencoba merambat ke seluruh tubuh saya!\"\n\"Saya melarikan diri! Saya berlari secepat mungkin, tapi tatapan itu tak pernah lepas dari diri saya. Saya punya firasat, ia pasti akan menemukan saya! Lumpur hitam menjijikkan itu akan kembali memenuhi tengkorak saya. Siapa pun yang menerima surat ini, tolong, selamatkan saya—\""
  },
  Event_6929_Name = {
    Text = "Surat permintaan pertolongan"
  },
  Event_6930_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6930_Desc = {
    Text = [[
"Tenang," Ramona mengetuk kepalamu, "hanya fragmen dari masa lalu. Entah siapa yang menjatuhkannya di lorong dimensi ini."
Memang, ada aroma rindu.]]
  },
  Event_6930_Name = {
    Text = "Komunikasi Darurat"
  },
  Event_6931_ChoiceDesc1 = {
    Text = "[Acak 1 kartu perintah mendapatkan Orison:[(EnchantConfig.Arg1)]"
  },
  Event_6931_ChoiceDesc2 = {
    Text = "[Acak 1 kartu perintah mendapatkan Orison:[(EnchantConfig.Arg1)]"
  },
  Event_6931_ChoiceDesc3 = {
    Text = "[Acak 1 kartu perintah mendapatkan Orison:[(EnchantConfig.Arg1)]"
  },
  Event_6931_Desc = {
    Text = "Acara 205 (dalam pengembangan), bukan efek akhir"
  },
  Event_6931_Name = {
    Text = "Acara 205 (dalam pengembangan)"
  },
  Event_6932_ChoiceDesc1 = {
    Text = "[Mendapatkan Relik：(\"(RelicConfig.Arg1)\"]"
  },
  Event_6932_ChoiceDesc2 = {
    Text = "[Mendapatkan Relik：(\"(RelicConfig.Arg1)\"]"
  },
  Event_6932_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_6932_Desc = {
    Text = "Acara 204 (dalam pengembangan), bukan Efek akhir"
  },
  Event_6932_Name = {
    Text = "Acara 204 (dalam pengembangan)"
  },
  Event_6933_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6933_Desc = {
    Text = [[
Bulan kesepian tinggi di langit, namun kau dapat mendengar dengan jelas doa pujaannya. Nada aneh itu terdengar seperti bisikan kotor dari sesuatu yang najis. 
 Doa berhenti, dan kau hendak pergi. Namun, sebuah bayangan putih muncul di belakangmu. 
 "Orang yang mengintip takdir dan berdoa dengan penghinaan, karunia dan harga akan datang tepat pada waktunya."]]
  },
  Event_6933_Name = {
    Text = "Fragmen Bulan Perak"
  },
  Event_6934_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6934_Desc = {
    Text = "Dari belakang terdengar suara retakan yang renyah. Kamu termenung sejenak, lalu berbalik dan pergi."
  },
  Event_6934_Name = {
    Text = "Fragmen Bulan Perak"
  },
  Event_6935_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6935_Desc = {
    Text = [[
Sekumpulan cahaya bulan yang ditangkap di telapak tangan, ditaburkan di atas prasasti. 
 Seseorang terkubur di bawah lumpur yang berat, kerumunan yang menyaksikan mengklaim bahwa orang ini telah mengalami kematian alami, akan terlelap di bawah tanah. 
 Namun lumpur yang terkubur itu bergerak, dari jeritan yang menyedihkan, muncul seberkas bulan yang lemas.]]
  },
  Event_6935_Name = {
    Text = "Fragmen Bulan Perak"
  },
  Event_6936_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6936_Desc = {
    Text = [[
Hanyalah makhluk yang berjuang untuk bertahan hidup, mencari sepotong kayu apung untuk bersandar saja...
Kamu menghela napas, lalu membiarkan cairan hitam dari ekor kupu-kupu itu mengalir.]]
  },
  Event_6936_Name = {
    Text = "Sesuatu yang tidak seharusnya ada"
  },
  Event_6937_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6937_Desc = {
    Text = "Ini adalah jebakan yang telah direncanakan sebelumnya, dan kamu sangat menyadari bahayanya. \nDibandingkan dengan perhiasan, dirimu sendiri — jelas merupakan permata yang lebih langka."
  },
  Event_6937_Name = {
    Text = "Membalikkan Cakar Iblis"
  },
  Event_6938_ChoiceDesc1 = {
    Text = "[Memasukkan Kunci Perak]"
  },
  Event_6938_Desc = {
    Text = "Di dalam D-lendir yang terlalu jenuh tampaknya terkandung beberapa zat... Gunakan Kunci perak untuk mengamati, dan ubahlah menjadi Kekuatanmu sendiri."
  },
  Event_6938_Name = {
    Text = "Titik Ekstraksi"
  },
  Event_6939_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6939_Desc = {
    Text = "Kamu menyetujui permintaan itu, namun menghadapi sedikit masalah. \n\"Patung lilin itu…… seperti apa bentuknya?\"\n\"Itu adalah patung setengah badanku, tentu saja sama persis denganku.\"\n\"Tapi……\"\n\"Wajahmu sudah benar-benar membusuk. Apakah kamu tidak tahu?\""
  },
  Event_6939_Name = {
    Text = "Setengah tubuh saya"
  },
  Event_6940_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6940_Desc = {
    Text = "Kamu erat memegang tangan teman di sisimu, Ramona melirikmu dengan pandangan bingung, namun pada akhirnya dia menerima sikap tidak sopanmu."
  },
  Event_6940_Name = {Text = "Doa Mimpi"},
  Event_6941_ChoiceDesc1 = {
    Text = "[Tanyakan siapa itu] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", infeksi \"(Skill.Arg2)\""
  },
  Event_6941_ChoiceDesc2 = {
    Text = "[Berhadapan dengannya] Pilih 1 Pembangun untuk dibangkitkan, infeksi [(Skill.Arg1)]"
  },
  Event_6941_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_6941_Desc = {
    Text = [[
Perasaan kuat sedang diawasi membuatmu berhenti. 
"Siapa?"kau memandang ke sekitar dalam kabut tebal, "Jenkin, apakah itu kau?"
Kabut terus menyelimuti, jeritan Tubuh yang Terlulur samar-samar terdengar dari kedalaman halaman. Kau tidak menemukan apa pun, hanya bisa berbalik, tetapi hampir menabrak sebuah mata yang melayang di udara.]]
  },
  Event_6941_Name = {
    Text = "Pandangan Buta"
  },
  Event_6942_ChoiceDesc1 = {
    Text = "[Tidak menyentuh koin] 1 Kartu perintah acak mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_6942_ChoiceDesc2 = {
    Text = "[Menyentuh koin] Meningkatkan Arg1 poin Kesehatan maksimum, terinfeksi [(Skill.Arg2)]"
  },
  Event_6942_Desc = {
    Text = "Kamu menemukan sebuah koin kuno yang terjebak dalam lumpur hitam. \n Satu sisi terukir kosong dengan pembuluh darah berwarna merah dan biru, sementara sisi lainnya dengan teknik ukiran halus menggambarkan wajah putih bersih—seorang duchess yang tersenyum, menatap bola matamu yang pucat bergerak sejenak, lalu mulai berputar dengan sembarangan."
  },
  Event_6942_Name = {
    Text = "Koin Kuno Dua Sisi"
  },
  Event_6943_ChoiceDesc1 = {
    Text = "[Mendapatkan] 25 Segil Hitam"
  },
  Event_6943_ChoiceDesc2 = {
    Text = "[Lanjutkan perjalanan] mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6943_Desc = {
    Text = [[
Datang lagi, suara langkah kaki yang aneh itu. 
 Ia mengikuti di belakangmu, dari studio ke ruang kepala, lalu dari ruang kepala ke ruang bawah tanah. 
 Kamu tahu itu adalah orang yang berhati-hati. 
 Dia dengan hati-hati menjaga jarak di antara kalian, tidak terlalu jauh, tetapi juga tidak membuatmu merasa terganggu. 
 Namun, kamu tetap merasa sangat terganggu.]]
  },
  Event_6943_Name = {
    Text = "langkah kaki"
  },
  Event_6944_ChoiceDesc1 = {
    Text = "[Mengamati itu] dapat memperoleh 25 Segil Hitam"
  },
  Event_6944_ChoiceDesc2 = {
    Text = "[Usap itu] 50% kesempatan mendapatkan 50 Segil Hitam, 50% kesempatan tidak mendapatkan apa-apa."
  },
  Event_6944_Desc = {
    Text = [[
Seekor kucing hitam tiba-tiba meloncat dari gang kecil, dengan sangat mesra menjalinan di sekitar kakimu, pupil vertikal berwarna hijau redup berkilauan dengan cahaya yang membuat merinding, seolah-olah berkata "Jangan kejar, main denganku sebentar."
 "Kamu sudah melihat-Nya, Dia ada di sisimu, bayangan-bayangan yang tercemar oleh kegilaan... Jangan menatap langsung pada siluet-Nya."]]
  },
  Event_6944_Name = {Text = "Elfo Malam"},
  Event_6945_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6945_Desc = {
    Text = "Pembangun menunggu instruksi Anda, Anda tidak punya waktu untuk memikirkan hal lain."
  },
  Event_6945_Name = {Text = "dari sudut"},
  Event_6946_ChoiceDesc1 = {
    Text = "[Periksa Film] Terinfeksi \"(Skill.Arg1)\", mendapatkan Relik emas \"(RelicConfig.Arg2)\""
  },
  Event_6946_ChoiceDesc2 = {
    Text = "[Periksa Kamera] Dapatkan 50 Segil Hitam"
  },
  Event_6946_Desc = {
    Text = "Seperti menarik keluar sebagian isi perut, film di dalam kamera tercabik-cabik, dibuang begitu saja dengan perut terbuka di sini, tanpa ada yang peduli.\nSeberkas cahaya putih menyilaukan berkedip, kamera yang ditinggalkan di sudut jalan miring, shutter-nya ditekan entah dari mana.\n\"Klik——\"\nEkspresi terkejut dan bingungmu dengan setia tercatat pada gulungan film di dalam kamera."
  },
  Event_6946_Name = {
    Text = "Catatan Tidak Bersalah"
  },
  Event_6947_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6947_Desc = {
    Text = "Hanya suara angin yang menggoyangkan gembok besi, tidak ada yang perlu dikhawatirkan, abaikan saja."
  },
  Event_6947_Name = {
    Text = "Di balik pintu besi"
  },
  Event_6948_ChoiceDesc1 = {
    Text = "[Pilih] Infeksi [(Skill.Arg1)]"
  },
  Event_6948_ChoiceDesc2 = {
    Text = "[Pilih] Infeksi [(Skill.Arg1)]"
  },
  Event_6948_ChoiceDesc3 = {
    Text = "[Pilih] Infeksi [(Skill.Arg1)]"
  },
  Event_6948_Desc = {
    Text = "\"Saya\"adalah diri saya yang unik, satu-satunya di antara jutaan alam semesta."
  },
  Event_6948_Name = {
    Text = "Resonansi Jiwa"
  },
  Event_6949_ChoiceDesc1 = {
    Text = "[Ambil] Pilih 1 Relik Perak"
  },
  Event_6949_Desc = {
    Text = [[
Mungkin itu adalah "aku". 
Menembus bayang-bayang waktu, menembus batas Dimensi, melalui celah kecil dan bertatapan dengan "aku".]]
  },
  Event_6949_Name = {
    Text = "Resonansi Jiwa"
  },
  Event_6950_ChoiceDesc1 = {
    Text = "[Pilih salah satu] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_6950_ChoiceDesc2 = {
    Text = "[Menelan keraguan] Terinfeksi [(Skill.Arg1)], Orison ulang, masih bisa dilakukan 1 kali lagi"
  },
  Event_6950_Desc = {
    Text = [[
Bagi gadis itu, ini juga merupakan rahasia yang sulit diungkapkan.
Kamu menelan rasa penasaranmu, namun dia mulai bercerita sambil memegang dadanya, tentang mimpi panjang yang berlangsung selama dua puluh lima tahun, tentang keadaan dirinya yang terpencil setelah bangun dari mimpi itu.]]
  },
  Event_6950_Name = {
    Text = "Nyawa yang Terkurung"
  },
  Event_6951_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6951_Desc = {
    Text = "Kamu memasukkan kertas dan serpihan kayu ke dalam api. Api itu dengan rakus menelannya, lalu puas mengeluarkan sendawa. Api tersebut sudah siap untuk membawa Kehancuran dunia, dan sebelum pergi, ia memberikanmu sedikit berkah."
  },
  Event_6951_Name = {Text = "Api redup"},
  Event_6952_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6952_Desc = {
    Text = "Kamu tanpa ampun memadamkan bara kebencian yang tersisa ini, kebencian dan penyesalan yang menguar di sekitar tampaknya mulai berkurang."
  },
  Event_6952_Name = {Text = "Api redup"},
  Event_6953_ChoiceDesc1 = {
    Text = "[Mengusir Gagak] Mendapatkan Arg1 Segil hitam, terinfeksi [(Skill.Arg2)]"
  },
  Event_6953_ChoiceDesc2 = {
    Text = "[Mengabaikan] Pergi"
  },
  Event_6953_Desc = {
    Text = "Kamu ingin menangkap gagak itu, tetapi ia hanya terbang dari satu sisi kamar tidur ke sisi lainnya, lalu terus mengeluarkan suara aneh. Di tempat gagak itu terbang, cairan hitam yang menetes berubah menjadi noda hitam."
  },
  Event_6953_Name = {
    Text = "Lentera Gagak Hitam"
  },
  Event_6954_ChoiceDesc1 = {
    Text = "[Peroleh] Relik \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6954_Desc = {
    Text = [[
"Kamu sangat jeli menangkap poin penting," senyuman pria itu mengembang, "Itu adalah makanan paling lezat di dunia, layak untuk setiap penikmat kuliner memasak dengan hati-hati dan mencicipinya dengan penuh perhatian."
"Sayang sekali, kali ini aku tidak bisa mengajakmu mencobanya. Sebagai gantinya, aku juga memiliki beberapa hidangan lezat lainnya, akan kuberikan padamu."
 Setelah berkata demikian, pria itu melemparkan sepotong daging lunak berwarna merah muda. Daging itu jatuh di permukaan jembatan, dengan tentakel-tentakel lengket yang bergerak pelan. Ketika kamu mendongak lagi, sosok pria itu sudah menghilang di balik rangkaian baja yang rumit, tanpa jejak.]]
  },
  Event_6954_Name = {
    Text = "Teman Perjalanan Aneh VI"
  },
  Event_6955_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6955_Desc = {
    Text = "Mengurai benang demi benang, inilah keahlianmu yang paling cemerlang. \nKilatan Inspirasi membuat pikiranmu menjadi sangat jernih, sehingga kamu bisa melihat realitas saat ini dengan lebih jelas—\nSiapa pun yang mengendalikan boneka di balik layar, keluarlah dan bertahan hidup."
  },
  Event_6955_Name = {
    Text = "Ledakan Inspirasi"
  },
  Event_6956_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6956_Desc = {
    Text = "Kupu-kupu hancur di telapak tanganmu, seperti langit-langit kaca yang tiba-tiba pecah. Serpihan retakan jatuh ke arah gravitasi bumi, jatuh, jatuh, jatuh——"
  },
  Event_6956_Name = {
    Text = "Fatamorgana Rel"
  },
  Event_6957_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6957_Desc = {
    Text = "Melihat Ramona enggan mendekat, kucing itu menggelengkan kepalanya dan berubah menjadi sebuah bayangan, lalu lenyap di tempat."
  },
  Event_6957_Name = {
    Text = "Penduduk yang Berpindah-pindah"
  },
  Event_6958_ChoiceDesc1 = {
    Text = "[Mengucapkan Janji] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6958_ChoiceDesc2 = {
    Text = "[Tolak] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6958_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_6958_Desc = {
    Text = [[
"Itu benar-benar kenangan yang tak terlupakan. 
Kepala dan anggota tubuhku dipaksa dimasukkan ke dalam gips. 
Fatamorgana sesak napas dan sekarat membungkus diriku sepenuhnya, lalu menarikku dengan kuat dan melemparkanku di pantai gelap itu. 
Aku melihatnya, merasa bahwa sebagian dari diriku juga telah diambil bersamaan dengannya. 
Setengah dari jiwaku yang hilang sejak saat itu tinggal di patung lilin kecil pertamaku. 
Jadi... bisakah kamu membantu aku menemukan setengah dari diriku?"]]
  },
  Event_6958_Name = {
    Text = "Setengah tubuh saya"
  },
  Event_6959_ChoiceDesc1 = {
    Text = "[Pergi] Mendapatkan 1 dari 3 Orison tingkat lanjut"
  },
  Event_6959_Desc = {
    Text = [[
Kamu adalah pengamat memori, hanya bisa menyaksikan gadis itu jatuh ke Laut Gelap. 
 Arus mendorong roknya ke atas, namun dia terus tenggelam, mirip sekali dengan bunga yang belum mekar.]]
  },
  Event_6959_Name = {
    Text = "Tenggelam di laut"
  },
  Event_6960_ChoiceDesc1 = {
    Text = "[Memasukkan Kunci Perak]"
  },
  Event_6960_Desc = {
    Text = "Di dalam D-lendir yang terlalu jenuh tampaknya terkandung beberapa zat... Gunakan Kunci perak untuk mengamati, dan ubahlah menjadi Kekuatanmu sendiri."
  },
  Event_6960_Name = {
    Text = "Titik Ekstraksi"
  },
  Event_6961_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6961_Desc = {
    Text = "Tidak perlu memedulikan godaan musuh, mungkin itu adalah jebakan."
  },
  Event_6961_Name = {
    Text = "Burung Gagak Terkutuk"
  },
  Event_6962_ChoiceDesc1 = {
    Text = "[Bantu dia]"
  },
  Event_6962_ChoiceDesc2 = {
    Text = "[Mengamati dengan dingin]"
  },
  Event_6962_Desc = {
    Text = [[
Anak laki-laki berdiri di atas panggung, cahaya pucat menyinari wajahnya. 
"Dipersembahkan untuk..."
 Anak itu memerah karena malu. Dia membuka mulutnya, tetapi tak bisa mengeluarkan satu suku kata pun. 
 Mulut yang gelap itu semakin terbuka lebar, semakin lebar...]]
  },
  Event_6962_Name = {
    Text = "Upacara Penutupan III"
  },
  Event_6963_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6963_Desc = {
    Text = "\"Sangat menjengkelkan, sangat menjengkelkan!\" Seperti tersentuh suatu tombol olehmu, kucing hitam itu tiba-tiba menampakkan wajah garang dan menggigit lenganmu. Untungnya, kamu berhasil menghindar tepat waktu, hanya ujung bajumu yang terkoyak. Kucing hitam itu meloncat ke sudut jalan dan menghilang ke dalam saluran air di gang."
  },
  Event_6963_Name = {Text = "Elfo Malam"},
  Event_6964_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6964_Desc = {
    Text = [[
Dibawa oleh gelombang cairan kental yang memenuhi pikiranmu, kamu mendorong pintu dan melangkah ke jalan tanpa harapan untuk kembali. 
 Cahaya putih terang di luar pintu, apakah itu penyelamatan, atau mungkin kehancuran?]]
  },
  Event_6964_Name = {
    Text = "Di luar pintu ganda"
  },
  Event_6965_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6965_Desc = {
    Text = "Kamu memberanikan diri untuk maju dan memeriksa. Lendir yang menutupi permukaan meja tiba-tiba retak, memperlihatkan sesuatu di bawahnya."
  },
  Event_6965_Name = {
    Text = "Di luar pintu ganda"
  },
  Event_6966_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6966_Desc = {
    Text = [[
Menelan ludah, menekan rasa penasaran, dan fokus menghadapi musuh. 
 Biarkan kupu-kupu tetap tinggal di dalam tubuh untuk sementara, meskipun kepakan sayapnya akan merobek organmu menjadi berkeping-keping.]]
  },
  Event_6966_Name = {
    Text = "Efek kupu-kupu"
  },
  Event_6967_ChoiceDesc1 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_6967_Desc = {
    Text = "Kucing itu mengangguk dengan puas, lalu berubah menjadi sebuah bayangan dan langsung menghilang, meninggalkan beberapa benda bulat berwarna hitam."
  },
  Event_6967_Name = {
    Text = "Penduduk yang Berpindah-pindah"
  },
  Event_6968_ChoiceDesc1 = {
    Text = "[Memasukkan Kunci Perak]"
  },
  Event_6968_Desc = {
    Text = "Di dalam D-lendir yang terlalu jenuh tampaknya terkandung beberapa zat... Gunakan Kunci perak untuk mengamati, dan ubahlah menjadi Kekuatanmu sendiri."
  },
  Event_6968_Name = {
    Text = "Titik Ekstraksi"
  },
  Event_6969_ChoiceDesc1 = {
    Text = "[Pergi] Mendapatkan 1 Relik emas acak, terinfeksi [(Skill.Arg1)]"
  },
  Event_6969_Desc = {
    Text = "Melihatmu masih ragu, Kum melompat ke tumpukan tanah dan dengan cepat menggali sesuatu menggunakan kedua cakar depannya, lalu mendorongnya ke arahmu."
  },
  Event_6969_Name = {
    Text = "Benda Terkubur"
  },
  Event_6970_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6970_Desc = {
    Text = [[
Tertulis rapi di atas kertas "Merime", tidak pernah ada yang namanya Mason. 
Terlalu banyak kecurigaan bukanlah pertanda baik, Penjaga.]]
  },
  Event_6970_Name = {Text = "Mesin tik"},
  Event_6971_ChoiceDesc1 = {
    Text = "[Pergi] Dapatkan 1 dari 3 pilihan Relik emas, terinfeksi [(Skill.Arg1)]"
  },
  Event_6971_Desc = {
    Text = "Di tumpukan tanah terpendam kejahatan yang tidak terlukiskan dari para pematung."
  },
  Event_6971_Name = {
    Text = "Benda Terkubur"
  },
  Event_6972_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6972_Desc = {
    Text = "Di antara burung-burung, ada aturan mereka sendiri. Mereka tidak bertindak sesuai kehendakmu, dan kamu tidak berhak mengganggu hukum alam."
  },
  Event_6972_Name = {
    Text = "Gagak yang Sendirian"
  },
  Event_6973_ChoiceDesc1 = {
    Text = "[Pergi] Dapatkan 1 dari 3 pilihan Relik emas, terinfeksi [(Skill.Arg1)]"
  },
  Event_6973_Desc = {
    Text = [[
Kenapa? Kenapa bisa tenggelam? 
Pada hari itu tidak ada badai petir, tidak ada badai. Langit malam begitu jernih tanpa bintang, bulan purnama rendah menggantung di atas horizon laut, seperti matahari dingin.]]
  },
  Event_6973_Name = {
    Text = "Tenggelam di laut"
  },
  Event_6974_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6974_Desc = {
    Text = "\"Pengawas Kereta! Kami mengalami serangan teroris! ……zzz……\"\nSepertinya ini adalah laporan dari pengemudi, kamu berniat menutup teleponnya. \n\"Ulangi sekali lagi, ini adalah Tim Keempat Operasi Luar Mythag, kami diserang saat sedang menaiki Kereta Ekspres Malam di jalur utara untuk menyelamatkan sandera……Iyaahh!\"\nNada suara di telepon berubah menjadi bisikan serak, bercampur dengan jeritan melengkung yang membuat bulu kuduk merinding.\n\"Ritual telah selesai. Domba yang tersesat, semoga pemandian suci ini membersihkan jiwamu……\""
  },
  Event_6974_Name = {
    Text = "Panggilan kereta"
  },
  Event_6975_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6975_Desc = {
    Text = [[
Mengumpulkan inti perak juga merupakan salah satu tugas Penjaga. 
 Jiwa yang hanyut di dalam kristal putih murni akan kembali ke dunia dengan wajah baru di masa depan.]]
  },
  Event_6975_Name = {
    Text = "Jiwa yang Terikat"
  },
  Event_6976_ChoiceDesc1 = {
    Text = "[Apakah akan terus jatuh] 1 Kartu perintah acak mendapatkan Orison: [(EnchantConfig.Arg1)], apakah akan terus jatuh?"
  },
  Event_6976_ChoiceDesc2 = {
    Text = "[Meninggalkan pertarungan] Mendapatkan 25 Segil Hitam"
  },
  Event_6976_Desc = {
    Text = [[
"Kamu" mengundangmu. 
Di kedalaman spiral,"kamu" dari masa lalu dan masa depan memberikanmu "hadiah" dari Dimensi yang berbeda.]]
  },
  Event_6976_Name = {
    Text = "Jurang Spiral"
  },
  Event_6977_ChoiceDesc1 = {
    Text = "[Membungkuk ke depan] Terinfeksi \"(Skill.Arg1)\", memperoleh Relik emas \"(RelicConfig.Arg2)\""
  },
  Event_6977_ChoiceDesc2 = {
    Text = "[Menyerah untuk melihat] Mendapatkan 50 Segil Hitam"
  },
  Event_6977_Desc = {
    Text = "Sepertinya ada gulungan film yang terjepit di bagian bawah meja operasi."
  },
  Event_6977_Name = {
    Text = "Kenangan Cahaya dan Bayang-bayang"
  },
  Event_6978_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6978_Desc = {
    Text = [[
Menolak gangguan, fokus pada apa yang ada di depan. 
Kamu memiliki hal yang lebih penting untuk dilakukan.]]
  },
  Event_6978_Name = {
    Text = "Setengah tubuh saya"
  },
  Event_6979_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6979_Desc = {
    Text = [[
Relik suci yang hilang, warisan berharga dengan nilai tak terkira, instrumen untuk mewujudkan keinginan... 
 Mungkin hanya harta karun yang begitu menggoda.]]
  },
  Event_6979_Name = {
    Text = "Metode Input Misteri"
  },
  Event_6980_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6980_Desc = {
    Text = "\"Kamu adalah『Ibu』Lily, namun hanya memanfaatkannya sebagai alat untuk penelitian dan pertempuran,\"kamu menjawab,\"Anak kecil mungkin akan menuruti ibunya, tapi kamu tidak layak menjadi『Ibu』Lily.\""
  },
  Event_6980_Name = {Text = "Pilihannya"},
  Event_69813_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_69813_Desc = {
    Text = "Cahaya redup dari kunci perak berkilauan, lengan-lengan itu seolah-olah terkejut oleh semacam kekuatan, satu per satu masuk ke dalam kolam air, lalu menghilang tak terlihat."
  },
  Event_69813_Name = {
    Text = "Bassin Darah"
  },
  Event_69814_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_69814_Desc = {
    Text = "Kamu semakin terjerat, bisikan kacau dari Kehendak Tertinggi bergema di dalam pikiranmu. Kamu menutup mata, memanggil kekuasaan yang ada di dalam dirimu. \n Tiba-tiba, semua suara dan sensasi aneh menghilang, dan kamu berdiri di balik pintu, tentakel berwarna darah di sekitarmu lenyap tanpa jejak, seolah-olah tidak pernah ada. \n Kamu merasa tubuhmu segar. Kamu menyadari harga yang telah kamu bayar, tetapi itu tidak berarti apa-apa — kamu akan menghadapi keberadaan yang tertinggi dalam bentuk yang lebih kuat."
  },
  Event_69814_Name = {
    Text = "Bassin Darah"
  },
  Event_69815_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_69815_Desc = {
    Text = "Tubuh yang kamu bangunkan dari ingatan tidak ragu sedikit pun, menarikmu keluar dari kolam darah, lengan yang terhubung denganmu robek, lumpur keruh berceceran, di air banyak makhluk yang sulit dibedakan oleh mata, pencipta awal dan penghancur, sangat mendambakan untuk melahap."
  },
  Event_69815_Name = {
    Text = "Bassin Darah"
  },
  Event_69816_ChoiceDesc1 = {
    Text = "[Bangun Pembangun] Kurangi semua Pembangun sebesar 100 Aliemus, hapus 1 Kartu gejala"
  },
  Event_69816_ChoiceDesc2 = {
    Text = "[Menyerap Kolam Darah] Meningkatkan Arg1 poin kesehatan maksimum, menginfeksi 2 lembar [(Skill.Arg2)]"
  },
  Event_69816_ChoiceDesc3 = {
    Text = "[Memasukkan Kunci perak] Mengosongkan semua Energi-s"
  },
  Event_69816_Desc = {
    Text = [[
Kekuasaan kehidupan, muncul dalam bentuk kematian di mata awal. Saat kamu melangkah ke tempat yang samar ini, kolam noda darah yang amis tiba-tiba menampakkan wujud aslinya. 
 Noda darah berwarna merah-hitam menjulurkan tak terhitung jumlahnya lengan, merayap di pergelangan kakimu, terus naik memanjat, dengan niat menarikmu ke dalam jurang yang tak terduga.]]
  },
  Event_69816_Name = {
    Text = "Bassin Darah"
  },
  Event_6981_ChoiceDesc1 = {
    Text = "[Memungut Kunci]"
  },
  Event_6981_Desc = {
    Text = "Sekumpulan kunci yang berkarat. Dapat digunakan untuk membuka kunci pintu."
  },
  Event_6981_Name = {
    Text = "Kunci berkarat"
  },
  Event_6982_ChoiceDesc1 = {
    Text = "[Keluar] Pilih untuk menyalin 1 Kartu perintah, terinfeksi [(Skill.Arg1)]"
  },
  Event_6982_Desc = {
    Text = "Di bawah bimbingan lagu kapal dan Celeste, kau menatap ke dalam kedalaman gelap gulita kapal—apakah harapan kalian berada di kegelapan tanpa batas itu?"
  },
  Event_6982_Name = {
    Text = "Lagu Perahu"
  },
  Event_6983_ChoiceDesc1 = {
    Text = "[Keluar bersama] Mendapatkan Relik perak [(RelicConfig.Arg1)]"
  },
  Event_6983_ChoiceDesc2 = {
    Text = "[Menolak Pergi]Mendapatkan 75 Segil Hitam, terinfeksi[(Skill.Arg2)]"
  },
  Event_6983_Desc = {
    Text = [[
Apakah ini fatamorgana? Kamu melihat gagak berputar-putar di langit, bersenandung dengan lagu yang familiar: 
"Jadi, mari pergi bersama, aku dan kamu,
Saat malam baru saja tiba.
Seperti seorang pemabuk yang sekarat terbaring di jalan."]]
  },
  Event_6983_Name = {
    Text = "Suara Rombongan Gagak"
  },
  Event_6984_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6984_Desc = {
    Text = "Kekuatan pelacakan tidak dapat menemukanmu persimpangan dalam waktu singkat, namun setidaknya kamu mendapatkan ketenangan sementara."
  },
  Event_6984_Name = {
    Text = "Kontak Anomali"
  },
  Event_6985_ChoiceDesc1 = {
    Text = "[Menuju Spiral] Memandang ke ujung spiral"
  },
  Event_6985_ChoiceDesc2 = {
    Text = "[Meninggalkan pertarungan] Mendapatkan 25 Segil Hitam"
  },
  Event_6985_Desc = {
    Text = [[
Di luar jendela kapal, permukaan laut sudah tidak terlihat lagi. 
 Kaca memantulkan wajah pucatmu, dan di dalam murid matamu, "dirimu" juga menatap jendela kapal. 
 Realitas dan Domain saling tumpang tindih, berbaur, akhirnya terdistorsi menjadi spiral ganda yang rumit.]]
  },
  Event_6985_Name = {
    Text = "Jurang Spiral"
  },
  Event_6986_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6986_Desc = {
    Text = "Kamu menerima permintaan kontak dari sekolah, suara yang familiar membuatmu merasa tenang. Kamu mengumpulkan Roh dan melanjutkan langkah."
  },
  Event_6986_Name = {
    Text = "Persimpangan"
  },
  Event_6987_ChoiceDesc1 = {
    Text = "[Menyatakan persetujuan]"
  },
  Event_6987_ChoiceDesc2 = {
    Text = "[Menyatakan penolakan]"
  },
  Event_6987_ChoiceDesc3 = {
    Text = "[Tidak Menentukan Sikap]"
  },
  Event_6987_Desc = {
    Text = [[
"Lama tidak bertemu, teman-teman." Kalian berhasil selamat dari pertempuran melawan Penerang Cahaya Kuil dan mendapatkan sedikit waktu untuk bernapas. Tiba-tiba, kalian melihat pria berambut panjang itu muncul lagi di sisi jalan, menyapa kalian dengan senyuman, seolah-olah pertempuran tadi tidak pernah terjadi. 
 "Dibandingkan dengan saat kita terakhir bertemu, aroma Kerberos pada dirimu menjadi lebih kuat. Selama ini, kau pasti sudah pergi ke tempat yang sangat jauh, kan?" 
]]
  },
  Event_6987_Name = {
    Text = "Teman Perjalanan Aneh V"
  },
  Event_6988_ChoiceDesc1 = {
    Text = "[Menanyakan Jalan Padanya] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6988_ChoiceDesc2 = {
    Text = "[Meninggalkannya] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6988_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_6988_Desc = {
    Text = "Bayangan berdiri di bawah lampu jalan yang ramping. \n\"Boleh pinjam api, Tuan.\"\nKamu tidak punya kebiasaan @2, tapi kamu tidak keberatan menggunakan sedikit \"sihir\". \nDengan bantuanmu, Bayangan akan menyalakan @2 dan memasukkannya ke dalam pusaran hitam yang tak terlihat dasarnya. \nTak lama kemudian, kamu melihat asap putih mengepul keluar. \n\"Ah——\"\nBayangan menghela napas dengan puas."
  },
  Event_6988_Name = {
    Text = "Bayangan di bawah lampu jalan"
  },
  Event_6989_ChoiceDesc1 = {Text = "[OK]"},
  Event_6989_Desc = {
    Text = [[
Di dalam papan catur, apa yang terlihat belum tentu benar

Yang menghalangi langkahmu mungkin bukan dinding, melainkan rasa ingin tahu yang telah hilang.]]
  },
  Event_6989_Name = {
    Text = "Ruang Fatamorgana"
  },
  Event_6990_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6990_Desc = {
    Text = [[
"Aku sakit, sangat sakit... Kakak Sarah..."
Kamu melihat Sarah, dia dengan tegang melindungi dua anak itu, sepertinya tidak mendengarnya. 
Suara itu perlahan menghilang.]]
  },
  Event_6990_Name = {Text = "\"Kak Sasa\""},
  Event_6991_ChoiceDesc1 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_6991_Desc = {
    Text = [[
Kamu berdiri dan bertepuk tangan untuk anak laki-laki itu. 
Sepertinya merasakan semangat dari tepukanmu, anak laki-laki itu membusungkan dadanya yang kecil dengan penuh percaya diri. 
Darah hitam terus mengalir dari mulutnya, namun tak mampu lagi menghentikan nyanyian tersebut.]]
  },
  Event_6991_Name = {
    Text = "Upacara Penutupan IV"
  },
  Event_6992_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6992_Desc = {
    Text = "Sebagian kesedihan perlahan menguap, namun air mata masih terus mengalir menuju masa lalu yang aneh."
  },
  Event_6992_Name = {
    Text = "Air Mata Pantai Hantu"
  },
  Event_6993_ChoiceDesc1 = {
    Text = "[Mencekik tenggorokan penyanyi] Infeksi \"(Skill.Arg1)\", mendapatkan Relik terkutuk \"(RelicConfig.Arg2)\""
  },
  Event_6993_ChoiceDesc2 = {
    Text = "[Trip penyihir yang tersandung] Terinfeksi dua kali \"(Skill.Arg1)\", mendapatkan relik perak \"(RelicConfig.Arg2)\" dan \"(RelicConfig.Arg3)\""
  },
  Event_6993_ChoiceDesc3 = {
    Text = "[Mengambil jalan memutar] Mendapatkan Relik perak [(RelicConfig.Arg1)]"
  },
  Event_6993_Desc = {
    Text = "Kamu terhalang oleh tiga bayangan kental yang menghalangi jalanmu. \n Satu bayangan menyanyikan lagu, suaranya serak, liriknya aneh, kamu menutup telinga dan menghindarinya. \n Satu bayangan menari, gerakannya kaku, langkahnya ragu, kamu menutup mata dan menghindarinya. \n Satu bayangan melantunkan puisi, ritmenya hancur, kalimatnya tidak koheren, kamu tak bisa menahan diri lagi, lalu —"
  },
  Event_6993_Name = {
    Text = "Penjahat di Jalan Sempit"
  },
  Event_6994_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_6994_Desc = {
    Text = "Sebagian kemarahan sedang mendidih, namun air mata terus mengalir tanpa henti menuju dunia lampau yang tak dikenal."
  },
  Event_6994_Name = {
    Text = "Air Mata Pantai Hantu"
  },
  Event_6995_ChoiceDesc1 = {
    Text = "[Mengabaikan Sepenuhnya] Terinfeksi [(Skill.Arg1)]"
  },
  Event_6995_ChoiceDesc2 = {
    Text = "[Berbalik dan pergi] Bangun 1 Pembangun secara acak"
  },
  Event_6995_Desc = {
    Text = [[
Takdir yang kejam merayap di bawah kaki pejalan, jalanan berkilau seperti cermin, di belakang terdengar suara retakan yang lembut. 
 Siapa yang sebenarnya menginjak takdir di bawah kaki? Apakah itu ilusi, perangkap, atau hanya sekadar deliran, kebohongan... 
 Di depanmu, muncul retakan yang merayap perlahan. 
 <Italic:Seolah-olah itu akan tenggelam dalam Gnosis yang Bangun.>]]
  },
  Event_6995_Name = {
    Text = "Garis Retak Bergerak"
  },
  Event_6996_ChoiceDesc1 = {
    Text = "[Melakukan Ujian] Tertular [(Skill.Arg1)], menang dapat 1 Relik Emas, kalah dapat 50 Segil Hitam"
  },
  Event_6996_ChoiceDesc2 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_6996_Desc = {
    Text = [[
Kamu telah melihat beberapa rahasia dari genangan hitam yang memantulkan cahaya seperti cermin di bawah kakimu. 
 Tepi refleksinya kabur, dikelilingi oleh aura hitam yang tak kunjung pergi, kamu merasa anehnya akrab, tetapi tidak dapat mengenali apa sebenarnya itu.]]
  },
  Event_6996_Name = {
    Text = "Di bawah permukaan cermin"
  },
  Event_6997_ChoiceDesc1 = {
    Text = "[Mendengar Suara Kucing]50% peluang mendapatkan 125 Segil Hitam, 50% peluang terinfeksi[(Skill.Arg2)]"
  },
  Event_6997_ChoiceDesc2 = {
    Text = "[Mengumpan Makanan] 75% peluang mendapatkan 100 Segil Hitam, 25% peluang terinfeksi [(Skill.Arg2)]"
  },
  Event_6997_ChoiceDesc3 = {
    Text = "[Berlari sekuat tenaga] Mendapatkan 50 Segil Hitam"
  },
  Event_6997_Desc = {
    Text = "Kamu tersesat di wilayah kucing hitam. \n Tak terhitung mata tiba-tiba terbuka di kegelapan, penuh rasa ingin tahu, mengawasi, dan waspada... Hanya satu yang tidak ada, yaitu niat baik. \n Zamrud, kuning amber, biru merak... \n Kamu seolah-olah berada di lautan permata yang berkilauan. \n Untuk melarikan diri, kamu——"
  },
  Event_6997_Name = {
    Text = "Kota Kucing"
  },
  Event_6998_ChoiceDesc1 = {
    Text = "[Tentang Narsis] Dua kartu perintah acak masing-masing mendapatkan Orison: \"(EnchantConfig.Arg1)\", \"(EnchantConfig.Arg2)\""
  },
  Event_6998_ChoiceDesc2 = {
    Text = "[Anjing neraka] memperoleh relik terkutuk [(RelicConfig.Arg1)]"
  },
  Event_6998_ChoiceDesc3 = {
    Text = "[Tentang Lily] Terinfeksi [(Skill.Arg1)]"
  },
  Event_6998_Desc = {
    Text = "\"Ini adalah waktu tips dari Dafude'er.\""
  },
  Event_6998_Name = {
    Text = "Waktu Petunjuk"
  },
  Event_6999_ChoiceDesc1 = {
    Text = "[Mengabaikan Jarum] memperoleh Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6999_ChoiceDesc2 = {
    Text = "[Tahan pointer] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_6999_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_6999_Desc = {
    Text = "Kacha, kacha, ka——\nJarum takdir bergerak sedikit demi sedikit, suara mekanisme yang dingin terus bergeser menuju arah yang sangat tidak ingin kamu lihat."
  },
  Event_6999_Name = {
    Text = "Di luar ujung jarum"
  },
  Event_7000_ChoiceDesc1 = {
    Text = "[Memilih untuk Mengabaikan] Dapatkan 3 Kartu Perintah secara acak dari dek, pilih 1 kartu untuk dihapus, dan dapatkan 75 Segil Hitam."
  },
  Event_7000_ChoiceDesc2 = {
    Text = "[Periksa dengan hati-hati] Dapatkan 3 Kartu Perintah secara acak dari dek, pilih 1 salinan asli kartu untuk masuk ke dek, dan dapatkan 25 Segil Hitam."
  },
  Event_7000_ChoiceDesc3 = {
    Text = "[Meninggalkan dengan berbalik] Mendapatkan 50 Segil Hitam"
  },
  Event_7000_Desc = {
    Text = [[
Takdir yang kejam merayap di bawah kaki pejalan, jalanan berkilau seperti cermin, di belakang terdengar suara retakan yang lembut. 
 Siapa yang sebenarnya menginjak takdir di bawah kaki? Apakah itu ilusi, perangkap, atau hanya sekadar deliran, kebohongan... 
 Di depanmu, muncul retakan yang merayap perlahan.]]
  },
  Event_7000_Name = {
    Text = "Garis Retak Bergerak"
  },
  Event_7001_ChoiceDesc1 = {
    Text = "[Memanggil Burung Gagak]Mendapatkan 25 Segil Hitam, terinfeksi[(Skill.Arg2)]，lanjut memilih"
  },
  Event_7001_ChoiceDesc2 = {
    Text = "[Jauhkan Diri]"
  },
  Event_7001_Desc = {
    Text = "Cakar merobek jubah, menancap dalam di bahu."
  },
  Event_7001_Name = {
    Text = "Gagak yang Sendirian"
  },
  Event_7002_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7002_Desc = {
    Text = [[
Kadang-kadang rasa takut tidak berasal dari entitas fisik. 
"Anjing neraka"meninggalkan tetesan cairan merah di tempat yang dilaluinya, memantulkan bayangan siluetmu.]]
  },
  Event_7002_Name = {
    Text = "Refleksi Tidak Berwujud"
  },
  Event_7003_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7003_Desc = {
    Text = [[
Disertai aliran listrik yang lemah, kamu mendengar bisikan wanita. 
 Dia menangis, terus menerus menceritakan pengalamannya. 
 Satu jam berlalu, satu hari berlalu... sampai kamu sudah lupa mengapa dia bersedih. 
 Akhirnya dia dengan gembira menutup telepon, dan berjanji akan memberimu sebuah hadiah besar. 
 Kamu menerima hadiah itu. Bagaimanapun, hadiah selalu menyenangkan.]]
  },
  Event_7003_Name = {
    Text = "Harap angkat telepon"
  },
  Event_7004_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7004_Desc = {
    Text = [[
Di tengah tatapan bingung dari teman-temanmu, kamu menundukkan kepala dan berlutut dengan satu lutut, lalu mengepalkan tangan kanan di dahi. 
Bagus sekali, dengan cara ini wajahmu bisa tertutup sempurna.]]
  },
  Event_7004_Name = {
    Text = "Menipu dengan kebenaran palsu"
  },
  Event_7005_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7005_Desc = {
    Text = "\"Kamu telah menutupiku dengan selubung.\"\nPatung lilin itu tersenyum tenang ke arahmu.\"Aku mempersembahkan kebenaran padamu, sebagai hadiah atas kerja kerasmu.\"\nPerutnya terus mengalirkan cairan hitam kental yang membungkus dirimu sepenuhnya.\nDunia menjadi gelap gulita, namun terasa sangat hangat.\nKamu menguap sambil meringkuk, untuk pertama kalinya masuk ke alam mimpi……"
  },
  Event_7005_Name = {
    Text = "Patung Lilin yang Belum Selesai"
  },
  Event_7006_ChoiceDesc1 = {Text = "[OK]"},
  Event_7006_Desc = {
    Text = "Kamu tidak memperoleh apa pun di dalam Kabut."
  },
  Event_7006_Name = {
    Text = "Kabut Kekacauan"
  },
  Event_7007_ChoiceDesc1 = {
    Text = "[Mengangkat telepon] Mendapatkan pilihan 1 dari 3 Orison tingkat lanjut"
  },
  Event_7007_ChoiceDesc2 = {
    Text = "[Mengabaikan suara bel] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7007_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_7007_Desc = {
    Text = "\"Ding dong…\"\nDi sudut ruangan terdengar dering telepon yang menusuk telinga, mendesak dan berisik, semakin lama semakin keras, hampir membuatmu merasa: jika kamu tidak mengangkatnya, itu akan langsung meledak gila-gilaan, lalu menyebabkan kehancuran dunia."
  },
  Event_7007_Name = {
    Text = "Harap angkat telepon"
  },
  Event_7008_ChoiceDesc1 = {
    Text = "[Mendekati Fatamorgana] Mendapatkan 1 dari 3 pilihan Relik perak"
  },
  Event_7008_ChoiceDesc2 = {
    Text = "[Menghancurkan Fatamorgana] mendapatkan Relik perak \"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\", terinfeksi dua kali oleh \"(Skill.Arg3)\""
  },
  Event_7008_Desc = {
    Text = "Apakah itu Fata Morgana di dalam Domain? Atau mungkin kenangan lain yang tak bisa pergi? \n Kamu menggosok matamu, bayangan di kejauhan mendekat — apakah itu pasar yang ramai, museum lilin yang menghilang dalam pelarutan, rumah sakit jiwa di desa yang dilanda angin salju, ataukah Akut yang pemandangannya sudah kabur?"
  },
  Event_7008_Name = {
    Text = "Fata Morgana"
  },
  Event_7009_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7009_Desc = {
    Text = "Seolah tersentuh air panas mendidih, kamu secara refleks menutupi telinga, memblokir suara musik jahat itu dari luar."
  },
  Event_7009_Name = {
    Text = "Suara Terlarang"
  },
  Event_7010_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7010_Desc = {
    Text = "Melodi mayor yang cerah mengusir ketegangan dan ketakutan. Kamu penuh semangat seperti api, kamu siap mekar, kamu melompat kegirangan, dan kamu melangkah besar, meninggalkan Ramona jauh di belakang—\"Penjaga! Jangan berjalan terlalu cepat!\""
  },
  Event_7010_Name = {
    Text = "Suara Tanpa Nama"
  },
  Event_7011_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7011_Desc = {
    Text = "\"Berhenti langkahmu!!! Monster pelarutan yang merangkak lebih memahami anggota tubuhnya sendiri daripada kamu!\"\nLepaskan penonton…\nKau berdoa seperti itu dalam hati."
  },
  Event_7011_Name = {
    Text = "Penjahat di Jalan Sempit"
  },
  Event_7012_ChoiceDesc1 = {
    Text = "[Meninggalkan]"
  },
  Event_7012_Desc = {
    Text = [[
Ini hanyalah Domain.
Apa yang ingin kau lindungi, dan apa yang ingin kau hindari, adalah realitas yang unik.]]
  },
  Event_7012_Name = {
    Text = "Jurang Spiral"
  },
  Event_7013_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7013_Desc = {
    Text = [[
"Kamu yang paling dibenci."
 Kamu merobek kertas menjadi fragmen, menebarkannya di udara, berubah menjadi beberapa gumpalan bunga terbang. 
 Penyair menengadah melihat karakter-karakter itu beterbangan di angin, sudut bibirnya terukir dengan ekspresi terpesona. 
 "Indah sekali..."]]
  },
  Event_7013_Name = {
    Text = "Penjahat di Jalan Sempit"
  },
  Event_7014_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7014_Desc = {
    Text = "Kamu merobek seluruh poster itu dan menemukan catatan kasar di bagian belakangnya tentang berbagai pengeluaran Museum Lilin. \nPemilik tulisan ini jelas tidak memiliki kesabaran dan bakat dalam berhitung, karena entah bagaimana catatan ini tidak bisa diseimbangkan. \nSetelah melihatnya sekilas, pengeluaran terbesar tampaknya adalah untuk \"Perawatan dan Pembersihan Patung Lilin\". \nPengeluaran untuk staf sangat sedikit, pengeluaran terbaru adalah 12 cambuk bulu kuda dengan harga sekitar 20 Taring. \nAda juga satu pengeluaran khusus — \"Makanan mereka\". \nSiapa yang dimaksud dengan \"mereka\"?"
  },
  Event_7014_Name = {
    Text = "Tawa dalam Kegelapan"
  },
  Event_7015_ChoiceDesc1 = {
    Text = "[Keluar] mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7015_Desc = {
    Text = [[
"Licik... namun jawaban yang tepat."
Pemilik suara tertarik dengan jawaban itu, sebuah benda perak muncul dari permukaan air. 
"Ingatlah, segala sesuatu memiliki konsekuensi."]]
  },
  Event_7015_Name = {
    Text = "Suara di Luar Dunia"
  },
  Event_7016_ChoiceDesc1 = {
    Text = "[Tangkap kupu-kupu kedua] Hapus 1 Kartu Perintah, dapatkan Arg1 Segil Hitam"
  },
  Event_7016_ChoiceDesc2 = {
    Text = "[Tidak Lagi Berlama-lama]"
  },
  Event_7016_Desc = {
    Text = [[
Apakah mereka adalah penduduk Dimensi Roh? Atau Hidup yang lahir dari Pelarutan. 
Dengan penuh pertanyaan, kamu melangkah ke dalam badai kupu-kupu.]]
  },
  Event_7016_Name = {
    Text = "Badai Gnosis"
  },
  Event_7017_ChoiceDesc1 = {
    Text = "[Amati kupu-kupu ketiga] Hapus 1 Kartu Perintah, dapatkan Arg1 Segil Hitam"
  },
  Event_7017_ChoiceDesc2 = {
    Text = "[Tidak Lagi Berlama-lama]"
  },
  Event_7017_Desc = {
    Text = "Rasa sakit yang tak tertahankan di antara jari-jari membuatmu tiba-tiba melepaskan genggaman."
  },
  Event_7017_Name = {
    Text = "Badai Gnosis"
  },
  Event_7018_ChoiceDesc1 = {
    Text = "[Keluar] Mendapatkan 25 Segil Hitam, terinfeksi [(Skill.Arg1)]"
  },
  Event_7018_Desc = {
    Text = [[
"Apakah kalian manusia tidak punya jawaban lain?"
Pemilik suara mengeluarkan geraman tak sabar, membuat seluruh ruang bergetar. 
"Rakus dan bodoh... inilah alasan aku muak dengan kalian."]]
  },
  Event_7018_Name = {
    Text = "Suara di Luar Dunia"
  },
  Event_7019_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7019_Desc = {
    Text = "\"Tenang saja, aku hanya memberikan sedikit hukuman kepada tamu yang serakah. Aku tidak suka minum bir, jadi apa boleh buat~\""
  },
  Event_7019_Name = {
    Text = "Fragmen Memori·Bir"
  },
  Event_7020_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7020_Desc = {
    Text = "\"Jangan bernyanyi lagi—\"\nKamu memperingatkan penyanyi yang tidak bisa menyanyi dengan baik, jangan sampai mengganggu telingamu lagi."
  },
  Event_7020_Name = {
    Text = "Penjahat di Jalan Sempit"
  },
  Event_7021_ChoiceDesc1 = {
    Text = "[Pergi] Pilih 2 Pembangun untuk Bangun"
  },
  Event_7021_Desc = {
    Text = [[
Kamu berbalik dan pergi, namun tersesat di koridor yang panjang. 
 Koridor tanpa akhir hampir menguras seluruh kesabaranmu, sampai kamu menemukan sebuah panggung kecil yang kusam. 
 Kamu berkedip, dan panggung itu menghilang.]]
  },
  Event_7021_Name = {
    Text = "Upacara Penutupan II"
  },
  Event_7022_ChoiceDesc1 = {
    Text = "[Mengambil gelas anggur] Mendapatkan kartu spesial"
  },
  Event_7022_Desc = {
    Text = "Segelas cairan berwarna emas yang jernih seperti cahaya senja, bergetar seperti gelombang gandum di akhir musim gugur, mengeluarkan aroma manis yang menggoda seperti madu. Apa bahan-bahannya? Siapa yang meletakkannya di sini? Mengapa tidak ada yang menjaga? \n Sebelum pertanyaan-pertanyaan ini terjawab, sebuah pemikiran misterius merayap ke dalam pikiranmu: kamu harus segera meminumnya. \n Saat ini, kamu tiba-tiba berubah menjadi ngengat yang terpesona oleh api, serangga yang terperangkap dalam kantong tanaman, tidak bisa menahan diri untuk mengambil gelas anggur manis itu—"
  },
  Event_7022_Name = {
    Text = "Wine Manis Madu"
  },
  Event_7023_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7023_Desc = {
    Text = "Kamu mencoba memeriksa pintu ini, dan saat menyentuhnya, pintu itu tiba-tiba menghilang. Dari kejauhan terdengar suara sesuatu yang terbuka."
  },
  Event_7023_Name = {
    Text = "Pintu yang Aneh"
  },
  Event_7024_ChoiceDesc1 = {
    Text = "[Tidak diproses]"
  },
  Event_7024_ChoiceDesc2 = {
    Text = "[Menghapus Jejak Telapak Tangan]"
  },
  Event_7024_Desc = {
    Text = "Kantor Francis dingin dan rapi, mencerminkan ketelitian sang pemilik. \n Di atas kotak di sudut, kamu menemukan jejak debu berbentuk kotak berukuran 5 inci. \n Bentuk jejak tangan itu aneh—kontur luar tampak seperti jejak kaki binatang buas, namun di tengahnya terdapat jejak tangan kecil seorang gadis manusia. Seolah-olah jejak tangan manusia ditinggalkan terlebih dahulu, kemudian ditutupi oleh telapak tangan raksasa binatang buas. \n Tentu saja kamu bisa membayangkan gambar yang hangat, seperti seekor binatang yang jinak dan patuh menutupi punggung tangan gadis itu dengan cakarnya, memberikan penghiburan yang lembut. \n Namun kamu tahu kebenarannya—itu adalah jejak yang ditinggalkan oleh monster yang telah disatukan melalui eksperimen yang kejam."
  },
  Event_7024_Name = {
    Text = "Jejak Binatang Raksasa"
  },
  Event_7025_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7025_Desc = {
    Text = "Eksperimen yang berkeliaran telah membuatmu sangat lelah, sedikit waktu untuk bernapas terasa seperti embun di tengah gurun yang tandus."
  },
  Event_7025_Name = {
    Text = "Pintu Tak Terbatas"
  },
  Event_7026_ChoiceDesc1 = {
    Text = "[Pemilik] memperoleh Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7026_ChoiceDesc2 = {
    Text = "[Bawa Itu Pergi] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7026_ChoiceDesc3 = {
    Text = "[Bongkar itu] Dapatkan 50 Segil hitam"
  },
  Event_7026_Desc = {
    Text = [[
Kamu sedang berjalan ke depan, dan sesuatu terserempet di kakimu. 
 Itu adalah sebuah kompas, kaca pelindungnya sudah pecah, dan sisanya penuh dengan D-lendir. Kamu hati-hati membaliknya, dan samar-samar melihat lambang Universitas Mythag yang terukir di bagian belakang.]]
  },
  Event_7026_Name = {Text = "Pilihannya"},
  Event_7027_ChoiceDesc1 = {
    Text = "[Baca surat] Hapus 1 Kartu Perintah, dapatkan Arg1 Segil Hitam"
  },
  Event_7027_ChoiceDesc2 = {
    Text = "[Tutup kotak dengan baik]"
  },
  Event_7027_Desc = {
    Text = [[
Satu surat, satu surat, lalu satu lagi. 
 Kertas surat itu penuh dengan masa lalumu dan sekaligus menggambarkan masa depanmu. Terpengaruh oleh godaan aneh, kamu tak bisa berhenti merobek dan menelan kertas surat itu. 
 "Hei? Kamu sedang apa? Makan udara?" 
 Murphy menendangmu hingga kamu tersadar dari fatamorgana, dan saat kamu sadar, tidak ada apa pun di depanmu.]]
  },
  Event_7027_Name = {
    Text = "Surat Tak Terduga"
  },
  Event_7028_ChoiceDesc1 = {
    Text = "[Pergi] Mendapatkan 1 dari 3 pilihan Orison"
  },
  Event_7028_Desc = {
    Text = [[
Mendengar suaramu, sosok itu berhenti, suara Clementine menembus kabut air.
"Kamu ya," suaranya samar-samar, berkabut, seperti cahaya bulan yang larut dalam air, "Tidak perlu khawatir, kamu akan baik-baik saja, dia menginginkannya, tetapi dia tidak bisa melakukannya."
"Setelah kamu menyelesaikan urusan di sini, kita akan bertemu lagi."]]
  },
  Event_7028_Name = {
    Text = "Bayangan di dalam kabut"
  },
  Event_7029_ChoiceDesc1 = {
    Text = "[Penerima: Departemen Akademik]mendapatkan Relik perak[(RelicConfig.Arg1)]"
  },
  Event_7029_ChoiceDesc2 = {
    Text = "[Penerima: Rekan]mendapatkan Relik perak[(RelicConfig.Arg1)]"
  },
  Event_7029_Desc = {
    Text = "Saat kamu menuliskan nama penerima, kertas surat itu mengeluarkan asap tebal. Tangan tak terlihat melintasi kehampaan, dengan keras merebut kertas surat dari tanganmu—\n diiringi suara seperti mengunyah, tubuhmu tiba-tiba terasa berat. \n Namun, artefak di tanganmu memberitahumu bahwa perjalanan ini juga tidak sepenuhnya tanpa hasil."
  },
  Event_7029_Name = {
    Text = "Pengakuan sepihak"
  },
  Event_7030_ChoiceDesc1 = {
    Text = "[Memasukkan Kunci Perak]"
  },
  Event_7030_Desc = {
    Text = "Di dalam D-lendir yang terlalu jenuh tampaknya terkandung beberapa zat... Gunakan Kunci perak untuk mengamati, dan ubahlah menjadi Kekuatanmu sendiri."
  },
  Event_7030_Name = {
    Text = "Titik Ekstraksi"
  },
  Event_7031_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7031_Desc = {
    Text = "Tunggu sampai mereka muncul dari bayangan."
  },
  Event_7031_Name = {
    Text = "Lentera Gagak Hitam"
  },
  Event_7032_ChoiceDesc1 = {
    Text = "[Memanggil Burung Gagak]Mendapatkan 35 Segil Hitam, terinfeksi[(Skill.Arg2)]，lanjut memilih"
  },
  Event_7032_ChoiceDesc2 = {
    Text = "[Jauhkan Diri]"
  },
  Event_7032_Desc = {
    Text = [[
Burung hitam pekat merasakan panggilan, tubuh mereka mengembang, dan mereka memuntahkan sesuatu ke tanganmu. 
 Mereka mengepakkan sayap kembali ke atas tiang kapal, menatapmu dengan pandangan tajam dan penuh intensitas.]]
  },
  Event_7032_Name = {
    Text = "Gagak yang Sendirian"
  },
  Event_7033_ChoiceDesc1 = {
    Text = "[Memasuki Gua]"
  },
  Event_7033_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7033_Desc = {
    Text = "\"Huh, huhhuh……\"\nSuara yang sangat familiar…… aku ingat sekarang!\nManusia akan mengeluarkan suara seperti ini ketika mereka sakit atau hampir mati!\nCepat pergi dan lihat!"
  },
  Event_7033_Name = {
    Text = "Kedalaman gua"
  },
  Event_7034_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7034_Desc = {
    Text = [[
Kamu pernah mempelajari segala pengetahuan tentang Perak, termasuk cara mengidentifikasi tingkatannya. 
 Jelas, Perak ini tidak memenuhi persyaratan dasar untuk pemurnian. 
 Kamu terpaksa melepaskan mereka, serta jiwa-jiwa yang mungkin terjebak di dalamnya. 
 Belajar untuk melepaskan juga merupakan pelajaran wajib bagi Penjaga.]]
  },
  Event_7034_Name = {
    Text = "Jiwa yang Terikat"
  },
  Event_7035_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7035_Desc = {
    Text = "Ini adalah Lorong satu arah, kamu tidak bisa kembali ke pintu masuk melalui itu."
  },
  Event_7035_Name = {Text = "Lorong"},
  Event_7036_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7036_Desc = {
    Text = "Lebih cepat selesai, lebih tenang hati. Penyelidik Mythag tidak pernah takut bahaya."
  },
  Event_7036_Name = {
    Text = "Pintu Tak Terbatas"
  },
  Event_7037_ChoiceDesc1 = {
    Text = "[Tolong beri jalan, saya ada urusan mendesak.]"
  },
  Event_7037_ChoiceDesc2 = {
    Text = "[Ingin Mengetahui Lebih Lanjut]"
  },
  Event_7037_Desc = {
    Text = [[
"Teman sekolah, tunggu sebentar. Melihat ekspresi kalian yang tegang dan langkah kalian yang terburu-buru, mungkin kalian sedang menghadapi semacam kesulitan.
Namun, hidup tidak seharusnya menyerah pada pandangan menyeluruh dan kepala dingin hanya karena kebuntuan saat ini. 
Sebagai contoh, setelah memikirkannya dengan cermat beberapa hari ini, ada banyak ketidaksesuaian dalam legenda Kerberos dengan situasi saat ini."]]
  },
  Event_7037_Name = {
    Text = "Teman Perjalanan Aneh II"
  },
  Event_7038_ChoiceDesc1 = {
    Text = "[Menerima Hadiah]"
  },
  Event_7038_ChoiceDesc2 = {
    Text = "[Tolak dengan sopan]"
  },
  Event_7038_Desc = {
    Text = "Anak laki-laki duduk di ambang jendela memandangmu. Dia sudah menunggumu lama sekali. \n\"Pertunjukan berjalan dengan sukses, te-terima kasih.\"\n\"Aku akan pergi… ini Hadiah untukmu.\"\nAnak itu membuka telapak tangannya ke arahmu. \nKamu melihat sebuah kotak Hadiah yang dibungkus rapi, darah mengalir keluar dari dalamnya, mewarnai tangan anak itu menjadi merah."
  },
  Event_7038_Name = {
    Text = "Upacara Penutupan VI"
  },
  Event_7039_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7039_Desc = {
    Text = "Semoga kamu selalu memiliki rasa percaya diri seperti ini."
  },
  Event_7039_Name = {
    Text = "Refleksi Tidak Berwujud"
  },
  Event_7040_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7040_Desc = {
    Text = [[
Kamu menerima telinga kecil yang lembut ini. 
 Ia terbalut dalam lilin kental, terbaring tenang di tengah telapak tanganmu. 
 Di dalam hatimu muncul rasa tanggung jawab yang kuat. 
 Pertama, bar tidak boleh sembarangan dikunjungi, musik di sana terlalu kacau. 
 Kedua, Teater Wellington juga tidak boleh dikunjungi, orkestra di sana sudah sangat usang. 
 Lalu... 
 Kamu dan teman-temanmu dengan baik menerima kenyataan bahwa kalian memiliki satu hewan peliharaan kecil lagi.]]
  },
  Event_7040_Name = {
    Text = "Berikan perhatian"
  },
  Event_7041_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7041_Desc = {
    Text = [[
"Profesor Alistair adalah fondasi Mythag, tanpa dia, seluruh sistem di Mythag akan berhenti berfungsi."
 Kamu samar-samar mengingat suatu kelas yang membuatmu mengantuk, Czort dengan wajah cemberut mengetuk papan tulis dan mengatakan kalimat ini. 
 Jika fondasi ini runtuh menjadi serpihan, bagaimana kamu akan menghadapinya? Rasa takut yang luar biasa menyelimuti dirimu. 
 "Kamu mau ke mana?"Panggilan Ramona membawamu kembali ke kenyataan. 
 Apakah itu masa lalu atau masa depan, nyata atau imajinasi, atau mimpi ilusi dari dimensi lain? Kamu tidak tahu lagi. 
 Di tanganmu, muncul sebuah "Hadiah".]]
  },
  Event_7041_Name = {
    Text = "Kekacauan Meratap"
  },
  Event_7042_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7042_Desc = {
    Text = [[
"Kursi roda ini adalah kedua kakiku. Sepertinya aku tidak akan bisa lepas darinya seumur hidup," kata Profesor Alistair dengan senyum pahit, "Sayangnya, ini membuatku jadi lebih pendek." 

Jadi, ini tidak mungkin Profesor Alistair yang sebenarnya.]]
  },
  Event_7042_Name = {
    Text = "Kekacauan Meratap"
  },
  Event_7043_ChoiceDesc1 = {
    Text = "[Siapa yang Berbicara?] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7043_ChoiceDesc2 = {
    Text = "[Whiskey apa itu, biarkan aku Cicipi juga] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7043_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7043_Desc = {
    Text = "\"Apakah kamu benar-benar tidak mau mencicipi sedikit pun? Ini adalah wiski berkualitas tinggi, lho. Kalau saja pemilik bar itu tidak memberiku satu botol penuh, aku tidak akan rela berbagi setetes pun denganmu untuk diminum.\"\n\"Jadi, kamu membantunya mengusir orang itu—yang kurus kering, kulitnya seperti karet yang tegang, dan hanya minum Bloody Mary. Inilah imbalan penuh yang diberikan oleh sang pemilik bar kepadamu. Untuk Penyelidikan itu, kamu menghabiskan waktu satu bulan, mengunjungi tiga puluh rumah, mendapat sebelas penolakan, dan Lelah tujuh belas peluru revolver. Satu botol wiski, bahkan modalnya saja belum kembali.\"\n\"Yah, sudahlah, jangan terlalu memperhitungkannya. Setidaknya, sekarang kita punya botol wiski ini, kan?\""
  },
  Event_7043_Name = {
    Text = "Fragmen Kenangan·Whisky"
  },
  Event_7044_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7044_Desc = {
    Text = "Kamu menahan tentakel Pembangun, dia menoleh ke arahmu dengan kilatan cahaya yang redup di matanya.\nDia tidak mengucapkan sepatah kata pun, namun kamu bisa membaca makna tersembunyi dalam tatapannya——\n\"Melampaui batas.\""
  },
  Event_7044_Name = {
    Text = "Efek kupu-kupu"
  },
  Event_7045_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7045_Desc = {
    Text = "Mesin telegraf sudah rusak parah. Bisakah kamu membayangkan keputusasaan pemilik mesin telegraf di tengah badai... karena saat ini, kamu juga merasakan hal yang sama."
  },
  Event_7045_Name = {
    Text = "Relik dari Orang Terdahulu"
  },
  Event_7046_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7046_Desc = {
    Text = [[
Nama: Leigh
Usia: 20
Komplikasi: Hematomania disertai histeria parah
Tumor: Tentakel merah tua @2 mulut penghisap
Graft: Organ dan jaringan darah kerabat langsung @3
Alasan penyerahan: Tidak ada alasan khusus. Aku tidak menyukainya.
(Konten setelahnya dicoret)]]
  },
  Event_7046_Name = {
    Text = "Pendaftaran Organ"
  },
  Event_7047_ChoiceDesc1 = {
    Text = "[Pilih\"Terima Berkat\"]kehilangan semua Segil hitam. Mendapatkan 1 Relik emas."
  },
  Event_7047_Desc = {
    Text = [[
Segumpal lumpur hitam muncul di hadapanmu, dengan gemetar memberikan sebuah dokumen. 
"Saat ini aku tidak bisa menampakkan diri... tapi Anda bisa melihat layanan kustomisasi kami..."
Suara wanita terdengar dari dalam dada lumpur itu, sedikit panik, seolah sedang menghindari sesuatu. 
"Berkat peri berlaku sesuai tingkat keanggotaan, dijamin adil untuk semua."
"Tandatangani, cepat tanda tangani!"]]
  },
  Event_7047_Name = {
    Text = "Berkat Peri"
  },
  Event_7048_ChoiceDesc1 = {
    Text = "[Mendengarkan dengan saksama] Memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7048_ChoiceDesc2 = {
    Text = "[Periksa] Semua Pembangun memulihkan 50 Aliemus, terinfeksi [(Skill.Arg1)]"
  },
  Event_7048_ChoiceDesc3 = {
    Text = "[Meninggalkan langsung] Mendapatkan 1 dari 3 Orison"
  },
  Event_7048_Desc = {
    Text = "\"Apakah kamu tahu?\" Saat Ramona mencari sosok misterius itu, sebuah suara tiba-tiba terdengar, seolah-olah seseorang sedang berbisik, \"Apakah kamu tahu tentang hal itu? Hal besar itu?\""
  },
  Event_7048_Name = {
    Text = "Telinga orang lain"
  },
  Event_7049_ChoiceDesc1 = {
    Text = "[Fokus] Hapus maksimal 2 Kartu gejala."
  },
  Event_7049_ChoiceDesc2 = {
    Text = "[Meditasi] Pilih 1 Pembangun untuk Bangun."
  },
  Event_7049_ChoiceDesc3 = {
    Text = "[Menghubungkan] Mengembalikan Arg2 poin Hidup."
  },
  Event_7049_Desc = {
    Text = "Kamu menjelajahi dalam kabut, tiba-tiba, lencana sekolah di dada memancarkan cahaya perak yang lemah. Siapa yang memanggil dari sisi lain komunikator?"
  },
  Event_7049_Name = {
    Text = "Persimpangan"
  },
  Event_7050_ChoiceDesc1 = {
    Text = "[Waspadai dengan hati-hati] Meningkatkan Arg1 poin Kesehatan maksimum"
  },
  Event_7050_ChoiceDesc2 = {
    Text = "[Melangkah Maju] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7050_Desc = {
    Text = [[
Bayangan yang dihasilkan oleh Domain mengulurkan tangan ke arahmu, sosoknya samar-samar.
Kamu ingat, seorang Penyelidik Mythag pernah naik ke kapal ini, apakah ini dia?
Atau mungkin, ini hanyalah kenangan menyedihkan lain yang terperangkap dalam Domain.]]
  },
  Event_7050_Name = {
    Text = "Pengguna Kunci Perak"
  },
  Event_7051_ChoiceDesc1 = {
    Text = "[Keluar] mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7051_Desc = {
    Text = [[
"Lihat, karena satu kalimat tidak penting dariku, aku mengabaikan situasi yang paling mendesak. Ini tidak baik.
Jika terus tertunda, mangsa kalian akan semakin jauh melarikan diri.
Sebagai permintaan maaf, aku akan memberikan ini kepada kalian."

Pria itu dengan santai mengalihkan topik dan memberikan sebuah benda kepada kalian.]]
  },
  Event_7051_Name = {
    Text = "Teman Perjalanan Aneh II"
  },
  Event_7052_ChoiceDesc1 = {
    Text = "[Keluar] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7052_Desc = {
    Text = [[
"Semoga keinginanmu terkabul."
Pria itu tidak terlalu peduli, lalu menggeser tubuhnya untuk memberi jalan.]]
  },
  Event_7052_Name = {
    Text = "Teman Perjalanan Aneh II"
  },
  Event_7053_ChoiceDesc1 = {
    Text = "[Dimasukkan ke dalam kantong]"
  },
  Event_7053_Desc = {
    Text = "Sebuah zat perak berwarna mendekati merkuri, disaring dari lendir pelarut, mengandung kekuatan roh yang besar, terutama digunakan untuk menghubungkan lebih banyak Pembangun dalam ritual."
  },
  Event_7053_Name = {Text = "Perak"},
  Event_7054_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7054_Desc = {
    Text = [[
Kamu kembali memasuki jalan bercabang baru. 
Matahari terbit seperti biasa, manusia mati seperti biasa, dan kamu tersesat seperti biasa. 
Tidak ada yang baru.]]
  },
  Event_7054_Name = {
    Text = "Labirin Mata"
  },
  Event_7055_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7055_Desc = {
    Text = "Itu tampaknya bayangan yang terdistorsi oleh pembiasan cahaya."
  },
  Event_7055_Name = {
    Text = "Objek Mengapung di Dalam Ember"
  },
  Event_7056_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7056_Desc = {
    Text = "Kamu berbalik dan hanya melihat sepasang sepatu kulit yang tergeletak sendirian.\n\"Maaf, aku tidak bermaksud jahat.\"\n\"Jika kamu melihat tubuhku, tolong sampaikan bahwa pendamping setianya sedang menunggu di lemari pajangan nomor 45 di ruang pameran 1.\"\n\"——Ingatlah, yang terbuat dari kulit sapi, bukan kulit kambing.\""
  },
  Event_7056_Name = {Text = "Oxford"},
  Event_7057_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7057_Desc = {
    Text = "Pasti teman sealmamater — kamu membuka kedua tanganmu ke arah-Nya, namun yang menyusul adalah rasa sakit yang menusuk tulang. \n Setelah rasa sakit itu menghilang, anggota tubuhmu tiba-tiba terasa sangat kuat, lebih kuat daripada sebelumnya."
  },
  Event_7057_Name = {
    Text = "Pengguna Kunci Perak"
  },
  Event_7058_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7058_Desc = {
    Text = [[
Kamu merasakan kabut di depan matamu tampaknya semakin tipis

Kamu merasa bahwa dalam tindakan selanjutnya, penglihatanmu menjadi lebih tajam.]]
  },
  Event_7058_Name = {
    Text = "Ujian Asura"
  },
  Event_7059_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7059_Desc = {
    Text = "Fatamorgana juga mendekatimu, memori tiba-tiba kembali, pandangan menjadi jelas."
  },
  Event_7059_Name = {
    Text = "Fata Morgana"
  },
  Event_7060_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7060_Desc = {
    Text = "Ketidaksadaran-Nya masih mengubah sesuatu dalam kegelapan tanpa disadari."
  },
  Event_7060_Name = {
    Text = "Pandangannya"
  },
  Event_7061_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7061_Desc = {
    Text = "Dalam situasi mendesak, sekarang bukan saatnya mengumpulkan Perak."
  },
  Event_7061_Name = {
    Text = "Bukti Kehidupan"
  },
  Event_7062_ChoiceDesc1 = {
    Text = "[Keluar] Dapatkan 1 dari 3 pilihan Relik perak, terinfeksi [(Skill.Arg1)]"
  },
  Event_7062_Desc = {
    Text = [[
Bayangan manusia yang samar-samar perlahan menjadi jelas, itu bukan Tubuh yang terlulur, juga bukan Clades, melainkan Clementine tanpa sayap, dengan ekspresi wajah yang tenang seperti biasa. 
 "Benar-benar kebetulan, apakah kamu juga datang untuk menikmati cahaya bulan?" dia berkata sambil tersenyum, namun kamu merasakan pusing yang luar biasa, "Pada malam berembun tebal, kamu harus lebih berhati-hati." 
 "Makhluk-makhluk kecil di sini, tidak begitu tenang."]]
  },
  Event_7062_Name = {
    Text = "Bayangan di dalam kabut"
  },
  Event_7063_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7063_Desc = {
    Text = "Seiring dengan suara retakan balok gipsum yang dilemparkan ke tanah, tubuhnya hancur seketika. Jeritan ketidakrelaan memenuhi pikiranmu, tapi untungnya, kamu berhasil menghentikan diri tepat pada waktunya."
  },
  Event_7063_Name = {
    Text = "Melengkapi tubuh yang rusak"
  },
  Event_7064_ChoiceDesc1 = {
    Text = "[Mendengarkan Kesedihan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7064_ChoiceDesc2 = {
    Text = "[ Mendengarkan Kebahagiaan ] Untuk setiap Pembangun dengan nilai Aliemus 50 atau lebih, dapatkan 15 Segil hitam."
  },
  Event_7064_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 1 dari 3 pilihan Orison"
  },
  Event_7064_Desc = {
    Text = [[
Melodi yang lembut, puitis, gembira, dan sedih... bergema di ruang Domain, sulit untuk menentukan dari mana sumbernya. 
 Apakah ini sonata yang mengalir dari speaker kapal hantu, ataukah fantasi tengah malam yang terkurung di dalam Domain?]]
  },
  Event_7064_Name = {
    Text = "Suara Tanpa Nama"
  },
  Event_7065_ChoiceDesc1 = {
    Text = "[Mereka sedang mencari seseorang] Hapus 1 Kartu Perintah, dapatkan 25 Segil Hitam"
  },
  Event_7065_ChoiceDesc2 = {
    Text = "[Mereka sedang mencari suatu item] Salin satu kartu dari dek, infeksi [(Skill.Arg1)]"
  },
  Event_7065_Desc = {
    Text = [[
Mengapa Penerang Cahaya Kuil tiba-tiba muncul di Kota Kecil Lai? Terlalu banyak misteri di sini. 
Anjing neraka Cerberus, Direktur Rumah Sakit Jiwa Lai Francis, Para Pematung, Gereja Penerang Kuil... 
Pasti ada suatu sumber yang mengumpulkan mereka di kota kecil yang tidak terlalu ramai ini. 
Mesin tik tiba-tiba memuntahkan tinta secara otomatis, seolah-olah mengajakmu untuk memasukkan sesuatu.]]
  },
  Event_7065_Name = {
    Text = "Metode Input Misteri"
  },
  Event_7066_ChoiceDesc1 = {
    Text = "[Mata tertutup erat]"
  },
  Event_7066_ChoiceDesc2 = {
    Text = "[Melarikan Diri dari TKP]"
  },
  Event_7066_Desc = {
    Text = "Pertunjukan tiba-tiba terhenti. Kamu melihat sekeliling dan menemukan bahwa di sekitarmu penuh dengan penonton. \n Mereka memiliki wajah yang sama dengan anak laki-laki itu, menatapmu secara serempak. \n Ah— \n Mereka membuka mulut hitam pekat mereka tanpa suara ke arahmu."
  },
  Event_7066_Name = {
    Text = "Upacara Penutupan V"
  },
  Event_7067_ChoiceDesc1 = {
    Text = "[Mengambil foto] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7067_ChoiceDesc2 = {
    Text = "[Periksa Film] Terinfeksi [(Skill.Arg1)], ganti Orison yang diperoleh di opsi 1. Masih bisa digunakan sekali lagi."
  },
  Event_7067_Desc = {
    Text = [[
Kamu meletakkan gulungan film di bawah cahaya merah redup, dasar film yang setengah transparan samar-samar memunculkan gambar. 
Tangan, kaki, bola mata, organ dalam... Semua organ tubuh yang bisa kamu bayangkan maupun yang tidak bisa, tercatat dengan setia dalam film tersebut. 
Mereka dicuci bersih dan disusun dengan rapi, seolah-olah seperti puisi pertama yang kamu tulis dengan aturan.]]
  },
  Event_7067_Name = {
    Text = "mencatat dengan jujur"
  },
  Event_7068_ChoiceDesc1 = {
    Text = "[Pembangun Putri] Bangun 1 Pembangun secara acak, terinfeksi [(Skill.Arg1)]"
  },
  Event_7068_ChoiceDesc2 = {
    Text = "[Pemikir] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7068_Desc = {
    Text = "\"Tak, tak, tak…\"\nSuara langkah kaki semakin mendekat, tampaknya seseorang akan segera mendorong pintu studio. \nKalian tidak punya tempat untuk mundur lagi, hanya bisa berpura-pura menjadi patung lilin di bawah cahaya redup, berharap menghindari tatapan pemeriksaan itu."
  },
  Event_7068_Name = {
    Text = "Menipu dengan kebenaran palsu"
  },
  Event_7069_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7069_Desc = {
    Text = "\"Bagus sekali, bagus sekali!\"Suara itu dipenuhi dengan kegembiraan, \"Akhirnya kamu menjadi seperti aku, Kakak Sasha!\""
  },
  Event_7069_Name = {Text = "\"Kak Sasa\""},
  Event_7070_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7070_Desc = {
    Text = [[
Mungkin ada seseorang yang membawa mereka ke sini. 
Seiring dengan eksplorasi Anda, identitas orang itu akan segera terungkap.]]
  },
  Event_7070_Name = {
    Text = "Metode Input Misteri"
  },
  Event_7071_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7071_Desc = {
    Text = "Lebih cepat selesai, lebih tenang hati. Penyelidik Mythag tidak pernah takut bahaya."
  },
  Event_7071_Name = {
    Text = "Pintu Tanpa Henti"
  },
  Event_7072_ChoiceDesc1 = {
    Text = "[Pilih Moral] Pulihkan Arg1 poin Hidup"
  },
  Event_7072_ChoiceDesc2 = {
    Text = "[Pilih Hidup] Pulihkan semua darah, infeksi [(Skill.Arg2)]"
  },
  Event_7072_Desc = {
    Text = [[
Kamu mungkin pernah memiliki hati yang seperti emas. 
 Ia berdetak tanpa henti, berjuang sepenuh hati demi hidup dan kehidupanmu... Hangat, bersemangat, dan penuh harapan. 
 Namun, entah kapan, kecepatannya perlahan melambat. Seolah hidup dan moral, ia hanya bisa menanggung salah satunya...]]
  },
  Event_7072_Name = {
    Text = "Kutukan Hasrat"
  },
  Event_7073_ChoiceDesc1 = {
    Text = "[Mengambil foto] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7073_ChoiceDesc2 = {
    Text = "[Periksa Film] Terinfeksi [(Skill.Arg1)], ganti Orison yang diperoleh di opsi 1. Dapat digunakan dua kali."
  },
  Event_7073_Desc = {
    Text = [[
"Jadi, kamu mencatat semuanya dengan jujur."
"Ya, kebenaran ada di dalam film itu."
Suara percakapan tiba-tiba terhenti, tak terhitung pasang mata tak terlihat serentak menunjuk padamu, seolah menunggu putusan akhirmu.]]
  },
  Event_7073_Name = {
    Text = "Keterangan saksi mata"
  },
  Event_7074_ChoiceDesc1 = {
    Text = "[Pergi] Tingkatkan Arg1 poin hidup, dan dapatkan 25 segil hitam"
  },
  Event_7074_Desc = {
    Text = "Seruanmu ditelan oleh deru angin. \n\"Kamu tidak perlu mengenalku,\"desisan dalam kalimat itu semakin jelas,\"Herbert, Herbert adalah orang yang kalian cari. Biarkan dia jatuh, dari mimpi palsu, ke dalam kenyataan yang keras dan dingin.\"\n\"Aku akan memberikan berkat kepada kalian, memberikan kalian hal terlezat di dunia ini…\""
  },
  Event_7074_Name = {
    Text = "Teman Perjalanan Aneh VI"
  },
  Event_7075_ChoiceDesc1 = {
    Text = "[Peroleh] Relik \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7075_Desc = {
    Text = [[
"Benar, kasihan sekali yang tersesat, memiliki Kekuatan namun tak mampu mengenali dirinya sendiri. 
Apakah kau akan menawarkan bantuan? Ataukah kau akan mengangkat senjata terhadap-Nya?"
 Pria itu melompat ke dalam aliran air yang deras, dan tepat saat dia melompat, pandanganmu bertemu dengannya. Mata itu berwarna emas seperti madu yang menetes, dengan pupil vertikal milik ular.
 Sedangkan di tempatnya berdiri tadi, tertinggal sebuah lampu kecil yang mengeluarkan asap ungu.]]
  },
  Event_7075_Name = {
    Text = "Teman Perjalanan Aneh VI"
  },
  Event_7076_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7076_Desc = {
    Text = "\"Kehati-hatian adalah suatu kebajikan, tetapi terlalu berhati-hati adalah sesuatu yang tidak tepat pada waktunya,\"suara datar yang tak berubah menyiratkan ketidakpuasan, \"Pergerakan bintang-bintang akan mengganggu Genesis Pembangun yang sedang tidur, dan waktu yang tepat dapat membuat Aliemus mereka mengembang dengan cepat seperti balon yang ditiup. Singkatnya, masih ada waktu untuk menangkap ekor komet, lain kali ingatlah untuk memperbaiki kecepatan reaksi mu yang sebanding dengan kura-kura.\""
  },
  Event_7076_Name = {
    Text = "Sudut elevasi"
  },
  Event_7077_ChoiceDesc1 = {
    Text = "[Reply] Tekanan saat ini berkurang separuh."
  },
  Event_7077_Desc = {
    Text = "Kamu menyentuh kabin stabilisasi tekanan, dapat memulihkan nilai Tekanan saat ini."
  },
  Event_7077_Name = {
    Text = "Titik stabil tekanan"
  },
  Event_7078_ChoiceDesc1 = {
    Text = "[Hibur Dia] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7078_ChoiceDesc2 = {
    Text = "[Mengecamnya] 3 kartu perintah acak mendapatkan orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7078_Desc = {
    Text = "\"Aku adalah bayangan dari penyelidik yang telah mati, pembunuhnya adalah kunci perak itu.\"\nWanita itu memegang kepalanya dengan kesakitan. Rambutnya sangat tebal, dipenuhi oleh banyak sekali mata berkilauan yang berkedip, berkedip… \n\"Mereka selalu berkata: Tidak, Charlotte! Ah, Charlotte! \nJadi kupikir, jika aku bisa membuat banyak tautan dengan Pembangun sekaligus, semua orang akan diam.\"\n\"Lalu... aku juga tidak tahu apa yang terjadi, saat aku bangun, aku sudah seperti ini. Ah!\""
  },
  Event_7078_Name = {
    Text = "Bayang Penyelidik"
  },
  Event_7079_ChoiceDesc1 = {
    Text = "[Mendaki dinding tinggi] Memperoleh Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7079_ChoiceDesc2 = {
    Text = "[Masuki Labirin] 1 Kartu acak mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7079_Desc = {
    Text = [[
Otakmu adalah sebuah labirin.
Terlalu banyak pikiran yang saling membelit di dalamnya, pintu keluar ada di tempat yang masih bisa dijangkau Tatapan, namun tembok-tembok tinggi pikiran berdiri tegak di antara kamu dan tujuanmu.]]
  },
  Event_7079_Name = {
    Text = "Labirin Pikiran"
  },
  Event_7080_ChoiceDesc1 = {
    Text = "[Fatamorgana Jauh] Mendapatkan 3 Pilihan 1 Relik Perak"
  },
  Event_7080_ChoiceDesc2 = {
    Text = "[Mendekati Fatamorgana] mendapatkan Relik perak \"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\", terinfeksi dua kali oleh \"(Skill.Arg3)\""
  },
  Event_7080_Desc = {
    Text = [[
Jauh di sana tampak kerucut gunung berapi meletus, kabut berbentuk manusia melayang di langit yang dilanda badai.  
Ini adalah Elworth, di mana hanya ada pegunungan salju yang menjulang dan gua-gua batu kapur yang mengalir.  
Apakah kondisi aneh yang berkepanjangan membuatmu kehilangan akal?]]
  },
  Event_7080_Name = {
    Text = "Fatamorgana Vulkanik"
  },
  Event_7081_ChoiceDesc1 = {
    Text = "[Apa yang kulihat] Memperoleh Relik perak [(RelicConfig.Arg1)]"
  },
  Event_7081_ChoiceDesc2 = {
    Text = "[Saya tidak melihat apa pun] mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7081_Desc = {
    Text = "Cairan menetes dari sudut matamu, sensasi lengketnya membuat hati terkejut. \n Pada akhirnya, itu disebabkan oleh apa yang kamu lihat, dan kamu — apakah kamu benar-benar tidak melihat apa pun?"
  },
  Event_7081_Name = {
    Text = "Jangan lihat langsung"
  },
  Event_7082_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7082_Desc = {
    Text = [[
Kamu juga akan merasa gembira, juga akan merasa sedih, tetapi yang menenggelamkanmu saat ini bukanlah emosimu. Kamu menutupi telinga dengan tangan, kunci perak berkilauan dengan cahaya yang menyilaukan. 
Akhirnya, kamu bisa bernapas lagi.]]
  },
  Event_7082_Name = {Text = "Kecanduan"},
  Event_7083_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7083_Desc = {
    Text = [[
Pemegang belati mengeluarkan suara, seperti burung hantu pembawa kabar kematian di pemakaman tengah malam.
Suara itu lenyap seketika, bahkan dua Pelaut lainnya juga menghilang tanpa jejak... Ternyata itu hanyalah sebuah Ilusi yang dipantulkan oleh Domain.]]
  },
  Event_7083_Name = {
    Text = "Mengejar tanpa henti"
  },
  Event_7084_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7084_Desc = {
    Text = [[
Itu hanya melayang di udara dengan tenang, tanpa berkedip, tatapannya penuh kerinduan, seolah ingin menyampaikan sesuatu kepadamu. 
Mata mungkin menjadi tempat jiwa bersemayam, tetapi tanpa kata-kata, kamu hanya bisa merasakan sedikit kecemasan dan kesedihan. 
Itu lenyap begitu saja di udara.]]
  },
  Event_7084_Name = {
    Text = "Pandangan Buta"
  },
  Event_7085_ChoiceDesc1 = {
    Text = "[Mendapatkan persetujuan] Memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7085_ChoiceDesc2 = {
    Text = "[Menghadiahkan] Memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7085_ChoiceDesc3 = {
    Text = "[Meninggalkan dengan berbalik] Mendapatkan 25 Segil Hitam"
  },
  Event_7085_Desc = {
    Text = [[
"Jika suatu hari aku harus jatuh, maka aku berharap bisa jatuh ke dalam air. 
Aliran air yang memenuhi rongga hidung terasa seperti mimpi lama yang lembut, 
aku tenggelam dalam cairan itu, 
adalah @2 mangkuk yang paling diidam-idamkan."]]
  },
  Event_7085_Name = {Text = "Pesta Air"},
  Event_7086_ChoiceDesc1 = {
    Text = "[Melawan Fatamorgana] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7086_ChoiceDesc2 = {
    Text = "[Mengumpulkan Aliemus] Secara acak membangun 2 Pembangun, menginfeksi dua kali [(Skill.Arg1)]"
  },
  Event_7086_Desc = {
    Text = "Dimensi yang cacat secara bertahap runtuh, fatamorgana dari dimensi lain membanjiri ruangan yang sakit."
  },
  Event_7086_Name = {
    Text = "Ilusi Dimensi"
  },
  Event_7087_ChoiceDesc1 = {
    Text = "[Pergi] Bangun 1 Pembangun secara acak"
  },
  Event_7087_Desc = {
    Text = [[
Gadis itu terkejut sesaat, lalu mengangkat tangannya dan menyentuh tepi roknya. 
"Yang bisa kulakukan untukmu... hanya sebatas ini."]]
  },
  Event_7087_Name = {
    Text = "Gadis berbaju putih"
  },
  Event_7088_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7088_Desc = {
    Text = "Siapa yang berbicara?\nKamu menundukkan kepala, hanya melihat bayangan samar—ia mengenakan pakaian yang sama denganmu, tetapi tangannya menggenggam sebuah pisau, dan sedang tersenyum ke arahmu."
  },
  Event_7088_Name = {
    Text = "Kamu tidak akan ingin menemukan"
  },
  Event_70892_ChoiceDesc1 = {
    Text = "[Memori Tubuh yang Sesuai] Lewati pertempuran untuk kemenangan instan, tetapi kehilangan Arg1 poin hidup."
  },
  Event_70892_ChoiceDesc2 = {
    Text = "[Keluar] Masuk ke Pertempuran"
  },
  Event_70892_Desc = {
    Text = "Meskipun musuh sangat kuat, kamu telah menguasai teknik untuk mengalahkan mereka."
  },
  Event_70892_Name = {
    Text = "memori otot"
  },
  Event_7089_ChoiceDesc1 = {Text = "[Larikum]"},
  Event_7089_ChoiceDesc2 = {
    Text = "[Serangan Eksperimen]"
  },
  Event_7089_Desc = {
    Text = "Khum menggigit bagian belakang leher sebuah subjek eksperimen dan bersiap untuk melemparkannya. Tiba-tiba, subjek itu memutar kepalanya 180° seperti burung hantu dan mematuk wajah Khum."
  },
  Event_7089_Name = {Text = "Koloseum"},
  Event_7090_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7090_Desc = {
    Text = [[
Kamu menggenggam erat kunci perak, merasakan panggilan dari Genesis di tengah arus gelap dimensi. 
Untuk melawan anjing neraka jahat yang identitasnya tidak jelas, kamu harus memanfaatkan semua kekuatan yang mungkin.]]
  },
  Event_7090_Name = {
    Text = "Ilusi Dimensi"
  },
  Event_7091_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7091_Desc = {
    Text = "\"Adapun penyelidik itu, Tuan Direktur berencana untuk menginterogasi secara pribadi… \n Biarkan dia tetap hidup…\" \n Suara itu perlahan melemah, akhirnya menghilang ke dalam kegelapan."
  },
  Event_7091_Name = {
    Text = "Dinding memiliki telinga"
  },
  Event_7092_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7092_Desc = {
    Text = "Sensasi tanpa bobot membuatmu tersadar secara tiba-tiba. Tanah di bawah kakimu terasa kokoh dan dapat diandalkan, sedangkan di samping kakimu terdapat sebuah cermin persegi yang indah."
  },
  Event_7092_Name = {
    Text = "Cermin dalam cermin"
  },
  Event_7093_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7093_Desc = {
    Text = "Kamu tidak pernah berdebat dengan orang yang telah jatuh ke dalam Kegilaan dan tidak bisa diselamatkan, hal itu akan membuat jiwamu sepenuhnya di-Devour dalam pertanyaan tengah malam, ampunilah dirimu!"
  },
  Event_7093_Name = {Text = "Pesta Air"},
  Event_7094_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7094_Desc = {
    Text = [[
Wajah patung lilin, seharusnya seperti apa? 
 Kamu menutup mata, dan di dalam pikiranmu muncul ribuan wajah samar. 
 Mereka seperti lilin-lilin yang menyeret api pucat, muncul dan menghilang di dalam aliran kegelapan... 
 Kamu berjalan sampai ujung aliran, di sana berdiri satu-satunya, patung lilin terakhir. 
 Saat mendekatinya, kamu melihat... @2.]]
  },
  Event_7094_Name = {
    Text = "Patung Lilin yang Belum Selesai"
  },
  Event_7095_ChoiceDesc1 = {
    Text = "[Menyerang pemegang belati] Terinfeksi \"(Skill.Arg1)\", memperoleh Relik terkutuk \"(RelicConfig.Arg2)\""
  },
  Event_7095_ChoiceDesc2 = {
    Text = "[Pendekat dengan Pisau] Terinfeksi dua kali \"(Skill.Arg1)\", mendapatkan relik perak \"(RelicConfig.Arg2)\" dan \"(RelicConfig.Arg3)\""
  },
  Event_7095_ChoiceDesc3 = {
    Text = "[Mengalahkan Pembawa Tombak] mendapatkan Relik perak [(RelicConfig.Arg1)]"
  },
  Event_7095_Desc = {
    Text = "Tiga Pelaut menggigit kalian tanpa henti, pandangan mereka yang panas dan gila hampir membakar jubahmu. \n Sekilas, kamu memperhatikan bahwa ketiga dari mereka memiliki perbedaan— \n Pelaut yang mengangkat pedang raksasa berteriak paling keras, namun tindakannya agak acuh tak acuh. \n Pelaut yang memegang tombak mengikuti langkahnya, seperti anak kecil yang baru belajar berbicara. \n Pelaut yang menggenggam belati berada di belakang, doa yang keluar dari mulutnya membuktikan kegilaannya."
  },
  Event_7095_Name = {
    Text = "Mengejar tanpa henti"
  },
  Event_7096_ChoiceDesc1 = {
    Text = "[Peroleh] Relik \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7096_Desc = {
    Text = [[
Kamu menerima hadiah itu, lalu membukanya dengan hati-hati. 
 Sepasang bola mata terbaring diam di dalam kotak hadiah. 
 "Aku memberikan mataku padamu." 
 "Seperti yang pernah dia lakukan padaku."]]
  },
  Event_7096_Name = {
    Text = "Upacara Penutupan VI"
  },
  Event_7097_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7097_Desc = {
    Text = [[
Meraih melalui pusat cahaya yang bersinar, kamu mengangkat setetes inti perak yang mengapur. Setetes wadah berharga untuk kenangan dan jiwa ini sangat panas, memantulkan warna-warna yang aneh. 
 Sebelum ia mencampurkan semua cahaya dengan distorsi, rasa sakit yang membakar membuatmu tidak bisa menahan diri untuk melemparkannya kembali ke dalam kegelapan.]]
  },
  Event_7097_Name = {
    Text = "Cahaya Malam"
  },
  Event_7098_ChoiceDesc1 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7098_Desc = {
    Text = [[
Kamu menolak hadiah dari anak laki-laki itu. 
Anak laki-laki itu memandangmu dengan rongga mata yang kosong. Dia menghela napas pelan. 
"Kalau begitu, selamat tinggal." 
Setelah berkata demikian, anak laki-laki itu membuat pose penutupan, lalu jatuh ke luar jendela. 
Dia menghilang, seperti kupu-kupu yang menari dengan anggun, atau seperti angin sepoi-sepoi.]]
  },
  Event_7098_Name = {
    Text = "Upacara Penutupan VI"
  },
  Event_7099_ChoiceDesc1 = {
    Text = "Pilih Orison Normal"
  },
  Event_7100_ChoiceDesc1 = {
    Text = "[Menerima telinga] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7100_ChoiceDesc2 = {
    Text = "[Tolak Permintaan] Dapatkan 1 dari 3 Orison"
  },
  Event_7100_Desc = {
    Text = "Rangkaian nada indah mengalir deras dari ujung jarinya. \nPianis patung lilin yang murung duduk sendiri di depan jendela. \nSejak memiliki kesadaran, museum lilin adalah seluruh dunianya. \nIa terkurung begitu lama, dan ingin mendengar sesuatu yang berbeda, terutama… musik bernama jazz. \nAkhirnya, ia merobek salah satu telinganya sendiri dan meminta kamu untuk membawanya pergi. \n\"Biarkan aku mendengar musik dari luar… cukup masukkan ke dalam saku.\""
  },
  Event_7100_Name = {
    Text = "Berikan perhatian"
  },
  Event_7101_ChoiceDesc1 = {
    Text = "[Menghubungkan] Mengembalikan Arg2 poin Hidup. [ExDesc1]"
  },
  Event_7101_ChoiceDesc2 = {
    Text = "[Meditasi] Pilih 1 Pembangun untuk di-Bangun. [ExDesc1]"
  },
  Event_7101_ChoiceDesc3 = {
    Text = "[ Pengusiran ] Hapus maksimal 3 Kartu gejala, dapatkan Arg2 Segil hitam."
  },
  Event_7101_Desc = {
    Text = "Kamu menjelajahi dalam kabut, tiba-tiba, lencana sekolah di dada memancarkan cahaya perak yang lemah. Siapa yang memanggil dari sisi lain komunikator?"
  },
  Event_7101_Name = {
    Text = "Persimpangan"
  },
  Event_7101_Tips3 = {
    Text = "Saat ini tidak memiliki Kartu gejala"
  },
  Event_7102_ChoiceDesc1 = {
    Text = "[Terima Tantangan]"
  },
  Event_7102_ChoiceDesc2 = {
    Text = "[Pukul Dia Sekali] Dapatkan 25 Segil hitam"
  },
  Event_7102_Desc = {
    Text = [[
Sosok kurus muncul dari bayangan, menghalangi jalanmu. 
Sebuah memori yang selamanya terikat tiba-tiba menyelinap ke Domain, bayangan kosong yang menyebut dirinya "N"memainkan chip di tangannya, mengundangmu dengan suara tangisan yang tidak jelas untuk bergabung dalam permainannya. 
Chip tiga warna terbentang di hadapanmu, jika tidak bermain satu ronde "permainan" dengannya, sepertinya dia tidak akan melepaskanmu begitu saja.]]
  },
  Event_7102_Name = {
    Text = "Pertunjukan dimulai"
  },
  Event_7103_ChoiceDesc1 = {
    Text = "[Memasukkan Kunci Perak]"
  },
  Event_7103_Desc = {
    Text = "Di dalam D-lendir yang terlalu jenuh tampaknya terkandung beberapa zat... Gunakan Kunci perak untuk mengamati, dan ubahlah menjadi Kekuatanmu sendiri."
  },
  Event_7103_Name = {
    Text = "Titik Ekstraksi"
  },
  Event_7104_ChoiceDesc1 = {
    Text = "[Setelah berjuang untuk bangun] Meningkatkan Kesehatan maksimum sebesar Arg1"
  },
  Event_7104_ChoiceDesc2 = {
    Text = "[Membiarkan Diri Tertidur] 2 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi 2 \"(Skill.Arg2)\""
  },
  Event_7104_Desc = {
    Text = [[
Kamu memegang sebuah harta berkilau di pelukanmu. 
 Ia merayap dari dadamu ke seluruh tubuhmu, membawa ingatan hangat yang memancarkan cahaya lilin, akhirnya mengalir ke dalam otakmu. 
 Suara bara api yang berkeretak, kursi malas di dekat perapian yang dilapisi selimut, teh hangat yang kaya rasa, dan perut kucing yang melingkar di dekat kakimu...... 
 Dalam rasa kantuk yang nyaman ini, pikiranmu melayang, terjatuh ke dalam keempukan yang lembut.]]
  },
  Event_7104_Name = {
    Text = "Terbenam dalam hari-hari lama"
  },
  Event_7105_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7105_Desc = {
    Text = "Kamu tanpa ampun menarik keluar separuh film lainnya, yang tersembunyi di dalam perut kamera. Tiba-tiba ditarik keluar, namun gambar di atasnya membuatmu terdiam lama tanpa kata. \n Film yang belum dicuci dengan setia mencatat —— dirimu terbaring di genangan lumpur hitam."
  },
  Event_7105_Name = {
    Text = "Catatan Tidak Bersalah"
  },
  Event_7106_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7106_Desc = {
    Text = [[
Kamu memeriksa kamera dengan cermat. Kulit dan emas hitam tertanam di bodinya, memantulkan kilauan berminyak yang halus. 
 Lensanya mengarah padamu, seolah-olah sedang menatap dan mengintip...]]
  },
  Event_7106_Name = {
    Text = "Catatan Tidak Bersalah"
  },
  Event_7107_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7107_Desc = {
    Text = [[
Cahaya bulan yang ditampung di telapak tangan, ditaburkan di atas batu nisan. 
 Seseorang terkubur di bawah lumpur yang tebal, kerumunan yang menyaksikan mengklaim, orang ini telah mengalami kematian alami, akan beristirahat di bawah tanah. 
 Namun lumpur yang terkubur itu bergejolak, dari jeritan yang menyedihkan, muncul seberkas bulan yang lemas.]]
  },
  Event_7107_Name = {
    Text = "Fragmen Bulan Perak"
  },
  Event_7108_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7108_Desc = {
    Text = "Kamu menyentuh sayap hitam yang tipis dari kupu-kupu dengan lembut. Kupu-kupu itu mengepakkan sayapnya perlahan, lalu berubah menjadi tetesan cairan hitam pekat dan jatuh di telapak tanganmu."
  },
  Event_7108_Name = {
    Text = "Sesuatu yang tidak seharusnya ada"
  },
  Event_7109_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7109_Desc = {
    Text = [[
Bulan kesepian tinggi di langit, namun kau dapat mendengar dengan jelas doa pujaannya. Nada aneh itu terdengar seperti bisikan kotor dari sesuatu yang najis. 
 Doa berhenti, dan kau hendak pergi. Namun, sebuah bayangan putih muncul di belakangmu. 
 "Orang yang mengintip takdir dan berdoa dengan penghinaan, karunia dan harga akan datang tepat pada waktunya."]]
  },
  Event_7109_Name = {
    Text = "Fragmen Bulan Perak"
  },
  Event_7110_ChoiceDesc1 = {
    Text = "[Tiga Poin]"
  },
  Event_7110_ChoiceDesc2 = {Text = "[Enam]"},
  Event_7110_ChoiceDesc3 = {
    Text = "[Satu Titik]"
  },
  Event_7110_Desc = {
    Text = [[
Sepertinya keberuntunganmu hari ini cukup baik. 
Dadu bergetar dan mengeluarkan dengungan penuh semangat. 
Kamu memutuskan untuk menebak sebuah angka.]]
  },
  Event_7110_Name = {
    Text = "Perjudian Tanpa Henti"
  },
  Event_7111_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7111_Desc = {
    Text = "Permainan judi ini adalah penipuan besar! \n Kamu \"cepat\" berdiri, namun merasakan pusing yang luar biasa. \n Dadu-dadu itu mengeluarkan dengungan berisik, suara yang penuh daya tarik terus terngiang di pikiranmu: \n \"Hanya satu kali lagi…… terakhir kalinya……\""
  },
  Event_7111_Name = {
    Text = "Perjudian Tanpa Henti"
  },
  Event_7112_ChoiceDesc1 = {
    Text = "[Menggunakan Perak] Tingkatkan 1 Relik Perak menjadi Relik Emas [(RelicConfig.Arg1)]"
  },
  Event_7112_ChoiceDesc2 = {
    Text = "[Menyimpan Perak] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\" dan \"(Skill.Arg3)\""
  },
  Event_7112_ChoiceDesc3 = {
    Text = "[Masukkan kembali ke laci] Dapatkan 25 Segil Hitam"
  },
  Event_7112_Desc = {
    Text = "Di laci kedua di sebelah kanan meja kerja, tergeletak sebatang Perak yang sudah jadi. Saat disentuh dengan lembut, kamu mendengar raungan badai, bercampur dengan suara gesekan butiran salju yang hancur, bercampur dengan suara seruling yang meratap..."
  },
  Event_7112_Name = {
    Text = "Perak Kesepian"
  },
  Event_7113_ChoiceDesc1 = {
    Text = "[Mendengarkan dengan saksama] Terinfeksi \"(Skill.Arg1)\", memperoleh Relik terkutuk - \"(RelicConfig.Arg2)\""
  },
  Event_7113_ChoiceDesc2 = {
    Text = "[Membuat Perubahan] Pilih untuk menghancurkan 1 Relik, dapatkan 1 hadiah."
  },
  Event_7113_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_7113_Desc = {
    Text = [[
Tidak semua lagu memiliki daya tarik.
Ketidakharmonisan murni menciptakan ratapan yang menyayat hati.]]
  },
  Event_7113_Name = {Text = "Disonansi"},
  Event_7114_ChoiceDesc1 = {
    Text = "[Mengambilnya] Terinfeksi \"(Skill.Arg1)\", memperoleh Relik perak \"(RelicConfig.Arg2)\""
  },
  Event_7114_ChoiceDesc2 = {
    Text = "[Abandon It] mendapatkan 25 Segil hitam."
  },
  Event_7114_Desc = {
    Text = "Di sudut jerami yang membusuk tersembunyi, di dalam retakan bekas pelarutan, terletak suatu benda dengan tenang."
  },
  Event_7114_Name = {
    Text = "setelah tumpukan jerami"
  },
  Event_7115_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7115_Desc = {
    Text = "Sosok itu tidak mendekat. Setelah menatapmu sejenak, Dia berubah menjadi segenggam pasir perak."
  },
  Event_7115_Name = {
    Text = "Pengguna Kunci Perak"
  },
  Event_7116_ChoiceDesc1 = {
    Text = "[Memegang tentakel] Menerima bantuan dari Tulu"
  },
  Event_7116_Desc = {
    Text = [[
Setelah menghela napas, Tulu mengejarmu.
Tentakel yang berat dan dingin mencengkeram tubuhmu, memadamkan niat mengerikan untuk langsung menerobos ke barisan musuh.
"Aku akan menjadi bantuanmu, hanya untuk saat ini."]]
  },
  Event_7116_Name = {Text = "Janji Agen"},
  Event_7117_ChoiceDesc1 = {
    Text = "[Kunci Diperoleh]"
  },
  Event_7117_Desc = {
    Text = [[
1.2.3......
Jenkins dan jarak meja ada 10 kaki. 
Ini adalah jarak yang sangat pendek, tetapi terasa panjang seperti seumur hidupnya. 
Dia teringat pita lembut, teringat bungkus permen kupu-kupu emas, dan juga air mata ibunya. 
Dia juga memikirkan banyak hal, banyak sekali... 
Tubuhnya yang kurus melintasi sungai hitam, sedikit demi sedikit mendekati meja. 
Kunci ada di dalam laci, dan harga yang perlu dibayar untuk mendapatkannya sangat sederhana: keberanian, kelincahan, ditambah sedikit keberuntungan. 
Selain keberuntungan, Jenkin tidak kekurangan apapun.]]
  },
  Event_7117_Name = {
    Text = "Kunci Akhir"
  },
  Event_7118_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7118_Desc = {
    Text = [[
Hanya sebuah permainan taruhan, kamu tidak akan kalah. 
Koin yang diukir dengan tekstur dilemparkan tinggi-tinggi, lalu jatuh dengan cepat, dan telapak tanganmu membuatnya terasa hangat.]]
  },
  Event_7118_Name = {
    Text = "Penjudi Terkenal"
  },
  Event_7119_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7119_Desc = {
    Text = [[
Hanya sebuah permainan taruhan, kamu tidak akan kalah. 
Koin yang diukir dengan tekstur dilemparkan tinggi-tinggi, lalu jatuh dengan cepat, dan telapak tanganmu membuatnya terasa hangat.]]
  },
  Event_7119_Name = {
    Text = "Penjudi Terkenal"
  },
  Event_7120_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7120_Desc = {
    Text = [[
Hanya sebuah permainan taruhan, kamu tidak akan kalah. 
Koin yang diukir dengan tekstur dilemparkan tinggi-tinggi, lalu jatuh dengan cepat, dan telapak tanganmu membuatnya terasa hangat.]]
  },
  Event_7120_Name = {
    Text = "Penjudi Terkenal"
  },
  Event_7121_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7121_Desc = {
    Text = [[
Kamu tidak sengaja bergabung dalam pelajaran piano yang serius ini. 
 Setiap kali menyelesaikan satu bait, para pelajar akan berusaha keras memutar kepala, berusaha terlihat sedang mendengarkan. 
 Sementara itu, gurunya juga akan sedikit membungkuk, bibirnya bergerak-gerak, dan mata bulatnya memandang partitur yang sebenarnya tidak ada. 
 Mereka jelas tidak tahu apa yang mereka lakukan, dan tidak akan pernah mengerti mengapa manusia menghabiskan bertahun-tahun untuk melakukan latihan mekanis semacam ini. 
 Mereka hanya meniru saja.]]
  },
  Event_7121_Name = {
    Text = "Pelajaran piano"
  },
  Event_7122_ChoiceDesc1 = {
    Text = "[Memasukkan Kunci Perak]"
  },
  Event_7122_Desc = {
    Text = "Di dalam D-lendir yang terlalu jenuh tampaknya terkandung beberapa zat... Gunakan Kunci perak untuk mengamati, dan ubahlah menjadi Kekuatanmu sendiri."
  },
  Event_7122_Name = {
    Text = "Titik Ekstraksi"
  },
  Event_7123_ChoiceDesc1 = {
    Text = "[Mengenali lirik] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7123_ChoiceDesc2 = {
    Text = "[Humming pelan] Mendapatkan 3 pilihan Orison"
  },
  Event_7123_Desc = {
    Text = [[
Nyanyian kapal kuno bergema di dalam Domain.
Memori yang terjebak di Domain bernyanyi dalam bahasa yang belum pernah kamu dengar, melantunkan tentang ombak, langit, dan minuman keras.]]
  },
  Event_7123_Name = {Text = "Lagu Laut"},
  Event_7124_ChoiceDesc1 = {
    Text = "[Memanggil Burung Gagak]Mendapatkan 20 Segil Hitam, terinfeksi[(Skill.Arg2)]"
  },
  Event_7124_ChoiceDesc2 = {
    Text = "[Jauhkan Diri]"
  },
  Event_7124_Desc = {
    Text = "Burung hitam pekat menatapmu dengan tajam, setelah lama, sesuatu jatuh dari bulunya..."
  },
  Event_7124_Name = {
    Text = "Gagak yang Sendirian"
  },
  Event_7125_ChoiceDesc1 = {
    Text = "[Maju dan pegang] Dapatkan 25 Segil Hitam"
  },
  Event_7125_ChoiceDesc2 = {
    Text = "[Respon ramah] 50% kesempatan mendapatkan 50 Segil Hitam, 50% kesempatan tidak mendapatkan apa-apa"
  },
  Event_7125_Desc = {
    Text = [[
Seekor kucing yang entah berasal dari mana duduk di antara Lumpur Hitam, tubuhnya yang samar menunjukkan bahwa dia seharusnya adalah penghuni dimensi spiritual. 
 Proyeksi tanpa wajah ini memandang Ramona dengan pandangan yang bijaksana, dia mengangkat kaki depannya yang putih bersih, seakan-akan melambai-lambai ke arahnya.]]
  },
  Event_7125_Name = {
    Text = "Penduduk yang Berpindah-pindah"
  },
  Event_7126_ChoiceDesc1 = {
    Text = "[Menuju Utara dengan Kekuatan Penuh]"
  },
  Event_7126_ChoiceDesc2 = {
    Text = "[Abaikan suara]"
  },
  Event_7126_Desc = {
    Text = "Serangan musuh datang seperti hujan di belakang, mata pisaunya beberapa kali menyapu jubah, mengagetkan sekumpulan burung camar yang sedang beristirahat di dermaga. \n\"Ke utara… atau naik kapal……\"\n Bahkan orang yang paling bodoh pun bisa menyadari bahwa ada kekuatan yang diam-diam membantu kamu."
  },
  Event_7126_Name = {
    Text = "Terus ke utara"
  },
  Event_7127_ChoiceDesc1 = {
    Text = "[Mendengarkan Matahari] mendapatkan Relik perak [(RelicConfig.Arg1)]"
  },
  Event_7127_ChoiceDesc2 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7127_Desc = {
    Text = [[
Dalam jalinan antara kenyataan dan ilusi, benda langit berputar selamanya mengikuti orbit yang telah ditentukan. 
 Ribuan kali berselisih, memainkan satu demi satu lagu yang aneh dan lancar...]]
  },
  Event_7127_Name = {
    Text = "Suara Bintang dan Bulan"
  },
  Event_7128_ChoiceDesc1 = {
    Text = "[Pergi Dengan Kesedihan]menggandakan kartu, jika menggandakan kartu gejala, mendapatkan 75 Segil hitam"
  },
  Event_7128_ChoiceDesc2 = {
    Text = "[Pergi dengan Marah] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7128_Desc = {
    Text = "Cairan memancar keluar dari murid, dingin dan deras membawa sebagian jiwa."
  },
  Event_7128_Name = {
    Text = "Air Mata Pantai Hantu"
  },
  Event_7129_ChoiceDesc1 = {
    Text = "[Coridor Dalam]"
  },
  Event_7129_ChoiceDesc2 = {
    Text = "[Melawan arus] Mendapatkan 25 Segil Hitam"
  },
  Event_7129_Desc = {
    Text = [[
Cahaya bulan yang pucat tak menghiraukan aliran waktu, tumpah di atas koridor yang sunyi. 
 Di bawah sinar bulan, pintu gua memancarkan cahaya yang misterius.]]
  },
  Event_7129_Name = {
    Text = "Galeri Sunyi"
  },
  Event_7130_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7130_Desc = {
    Text = [[
Kamu memutuskan untuk memperbaiki patung lilin ini. 
Di sekitar patung lilin menyebar beberapa alat, dan kamu memilih sebuah pewarna bernama "Prussian Blue". 
Warnanya biru seperti sebuah penyakit.]]
  },
  Event_7130_Name = {
    Text = "Patung Lilin yang Belum Selesai"
  },
  Event_7131_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7131_Desc = {
    Text = [[
Pustula mengeluarkan teriakan yang tajam dan mengerikan, terdengar suara angin yang seharusnya tidak ada, suara seruling yang seperti ilusi, dan suara terlarang dari cairan nanah yang mengalir. 
 Pustula bergetar aneh sejenak, kemudian kaku dan terbenam dalam keheningan. Menyaksikan pemandangan ini, Awakener di sampingmu tampak seolah menerima semacam panggilan.]]
  },
  Event_7131_Name = {
    Text = "Pustula aneh"
  },
  Event_7132_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7132_Desc = {
    Text = "Ujung jarimu menyentuh patung itu, tetapi terkadang ada lekukan yang secara tak terduga terasa lembut. Kamu selalu mengira itu hanya ilusi."
  },
  Event_7132_Name = {
    Text = "Menyusun Sisa-sisa Tubuh"
  },
  Event_7133_ChoiceDesc1 = {
    Text = "[Untuknya Menangis]"
  },
  Event_7133_ChoiceDesc2 = {
    Text = "[Doa kepadanya]"
  },
  Event_7133_Desc = {
    Text = [[
Saat tubuhnya menyentuh sisi kapal, ingatan yang bukan miliknya mengalir ke dalam pikirannya. 
 Orang-orang mengganti gaun putih suci di tubuhnya, menghiasnya dengan perhiasan yang indah dan elegan, orang-orang mengangkatnya ke atas altar yang tinggi, penduduk kota merangkak dan berlutut di bawahnya. 
 Itu adalah sepasang mata yang penuh harapan: para pelaut berharap dia dapat melindungi pelayaran, para nelayan berharap musim menangkap ikan yang tenang dan damai, lebih banyak penduduk kota berharap untuk mendapatkan kelancaran sepanjang tahun. 
 Di antara orang-orang yang berlutut, ada teman bermainnya di masa kecil, juga ada orang tua dan saudara yang selalu bersamanya. 
 Dia tidak menginginkan apa-apa, dia tidak tahu apa yang dia inginkan. 
 Menanggapi keinginan dengan pasif, seolah-olah itu adalah satu-satunya tugas dalam hidupnya.]]
  },
  Event_7133_Name = {
    Text = "Ceremoni Pra-Penerbangan"
  },
  Event_7134_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7134_Desc = {
    Text = "Tubuh yang cacat itu perlahan memutar pupil matanya yang pucat, menatap bayanganmu saat kamu menjauh, dan memperlihatkan senyuman yang suram."
  },
  Event_7134_Name = {
    Text = "Menyusun Sisa-sisa Tubuh"
  },
  Event_7135_ChoiceDesc1 = {
    Text = "[Menyerang secara aktif] Memperoleh Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7135_ChoiceDesc2 = {
    Text = "[Menyerah] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7135_ChoiceDesc3 = {
    Text = "[Cepat Pergi]mendapatkan 50 Segil hitam"
  },
  Event_7135_Desc = {
    Text = "Beberapa patung lilin mentah menghalangi jalanmu. \nMereka tampak bengkok dan kasar, tidak seperti kualitas yang seharusnya dibuat oleh Rogers. \n\"Perintah… perintah Tuan…\""
  },
  Event_7135_Name = {Text = "Latihan"},
  Event_7136_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7136_Desc = {
    Text = "Kamu memilih untuk berani menatap langsung ke matanya. \nMereka adalah bintang gemilang, berkilauan dalam kegelapan. \nLalu mereka tertawa, berubah menjadi banyak bulan sabit yang tak terhitung jumlahnya. \n\"Kamu tidak takut dengan tatapan. Kamu juga tidak seharusnya takut… \nSudah lama tidak bertemu, @2\"\nSebelum menghilang, mereka memberikanmu sebuah hadiah kecil, sebagai \"Peringatan reuni\"."
  },
  Event_7136_Name = {Text = "Mata"},
  Event_7137_ChoiceDesc1 = {
    Text = "[Buka sakelar] Perluas bidang pandang saat ini [ExDesc1]."
  },
  Event_7137_Desc = {
    Text = [[
Perangkat penerangan peninggalan orang-orang terdahulu, mampu mengusir kabut hitam di sekitarnya. 
Kabut di sekelilingnya berfluktuasi secara teratur, seakan-akan terganggu oleh napasnya.]]
  },
  Event_7137_Name = {
    Text = "proyektor pencari"
  },
  Event_7138_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7138_Desc = {
    Text = "Di punggungmu, sayap transparan terentang. Kamu berputar-putar dan akhirnya mengalir bersama gagak ke dasar laut yang sunyi."
  },
  Event_7138_Name = {
    Text = "Suara Rombongan Gagak"
  },
  Event_7139_ChoiceDesc1 = {
    Text = "[Eliminasi itu] mendapatkan [Jantung Distorsi]"
  },
  Event_7139_Desc = {
    Text = [[
Pustula cacat yang ditinggalkan di pinggir jalan oleh entah siapa, permukaannya berkilau dengan cahaya hijau kotor, saat ini bergerak dengan gelisah dan berubah bentuk. 
 Dibandingkan dengan monster, ia lebih mirip es krim yang telanjang terbakar di bawah terik matahari, yang segera akan meleleh menjadi genangan air kotor yang lengket, lalu menghilang ke udara.]]
  },
  Event_7139_Name = {
    Text = "Pustula aneh"
  },
  Event_7140_ChoiceDesc1 = {
    Text = "[Turunkan tangan yang menutupi telinga] Terinfeksi [(Skill.Arg1)], pilih untuk mendapatkan satu hadiah."
  },
  Event_7140_ChoiceDesc2 = {
    Text = "[Menangkap seekor gagak] Mendapatkan [(Skill.Arg1)], pilih untuk mendapatkan satu hadiah."
  },
  Event_7140_ChoiceDesc3 = {
    Text = "[Tutup mata] mendapatkan 50 Segil Hitam"
  },
  Event_7140_Desc = {
    Text = "Jeritan, jeritan yang tiada akhir——\nSang Penyanyi gagak mengenakan bulu hitam mengkilap, paruhnya memancarkan cahaya dingin yang keras, ratapan nyaringnya berulang kali membelah gendang telingamu. \nLepaskan tanganmu yang menutupi telinga!\nGerombolan gagak yang bernyanyi dengan gembira di malam hari, ingin meneguk getaran yang belum teruji dalam tubuhmu yang terlipat.\n"
  },
  Event_7140_Name = {
    Text = "Lagu Kawan-Kawan Gagak"
  },
  Event_7141_ChoiceDesc1 = {
    Text = "[Tidak ada penemuan saat keluar]"
  },
  Event_7141_Desc = {
    Text = "Bukan orang yang kamu cari."
  },
  Event_7141_Name = {
    Text = "2_6 Sementara"
  },
  Event_7142_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7142_Desc = {
    Text = [[
Kamu memilih untuk terus melangkah.
Dibandingkan dengan kerusakan mental dan fisik yang ditimbulkan oleh seni lilin yang buruk, sedikit gangguan ini tidak ada artinya. 
Kamu masih memiliki tujuan yang lebih besar untuk dicapai.]]
  },
  Event_7142_Name = {
    Text = "langkah kaki"
  },
  Event_7143_ChoiceDesc1 = {
    Text = "[Pilih salah satu] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7143_Desc = {
    Text = [[
"Apa! Apakah kau begitu suka mengorek luka orang lain!"
"Ya! Sekarang aku tiba-tiba menjadi 25 tahun lebih tua tanpa alasan! Sekarang kau harus memanggilku Kak Murphy!"]]
  },
  Event_7143_Name = {
    Text = "Nyawa yang Terkurung"
  },
  Event_7144_ChoiceDesc1 = {
    Text = "[Keluar] Dapatkan 1 dari 3 pilihan Relik perak, terinfeksi [(Skill.Arg1)]"
  },
  Event_7144_Desc = {
    Text = "Wajah gadis itu tenang seperti cahaya bulan malam ini. Dia tidak menjawabmu, namun ia mengangkat kompas di tangannya tinggi-tinggi — dia gemetar, seolah mengangkat kompas kecil itu telah menghabiskan seluruh hidupnya."
  },
  Event_7144_Name = {
    Text = "Gadis berbaju putih"
  },
  Event_7145_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7145_Desc = {
    Text = "\"Lezat! Lezat!\"Gagak tertawa dengan suara aneh, aroma busuk menyebar ke hidungmu saat ia membentangkan sayapnya."
  },
  Event_7145_Name = {
    Text = "Burung Gagak Terkutuk"
  },
  Event_7146_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7146_Desc = {
    Text = "Menurut saya, suara bising benar-benar menjadi teladan generasi baru. \n Mereka dengan tegas menginjak irama yang tidak teratur dan melodi yang membuat frustrasi, berkeliaran di dunia ini. \n Tanpa belas kasihan, tanpa guncangan, dan tanpa kompromi. \n Membenci pola, menolak tema, suara bising tidak pernah menyenangkan orang lain — \n tentu saja, ini juga termasuk pematung lilin kami."
  },
  Event_7146_Name = {
    Text = "selera yang buruk"
  },
  Event_7147_ChoiceDesc1 = {Text = "[Pemandu]"},
  Event_7147_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7147_Desc = {
    Text = [[
Seseorang sedang menarik lembut ujung bajumu. 
Dia adalah anak laki-laki yang kamu lihat tadi. Dia sedang berjongkok di sudut, memandangmu dengan murung. 
"Aku ingin. ingin ikut serta dalam pertunjukan akademi. 
Tapi, aku tidak bisa menemukan jalan ke panggung."]]
  },
  Event_7147_Name = {
    Text = "Upacara Penutupan II"
  },
  Event_7148_ChoiceDesc1 = {
    Text = "[Lanjutkan Pencarian] Tingkatkan Arg1 poin Hidup, terinfeksi [(Skill.Arg2)]"
  },
  Event_7148_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7148_Desc = {
    Text = "Ujung hidungmu mencium bau yang akrab, sederhana namun memuaskan. Saat kau ingin menghirup lebih dalam aroma kantin itu, aroma yang menguar tiba-tiba lenyap tanpa jejak."
  },
  Event_7148_Name = {
    Text = "Kontak Anomali"
  },
  Event_7149_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7149_Desc = {
    Text = [[
Mereka adalah warna-warna yang hangat. 
 Warna-warna yang penuh semangat, lembut, dan penuh kasih sayang. 
 Mereka memberikan pelukan yang membuat gadis itu merasa rindu, lalu menghilang seperti angin.]]
  },
  Event_7149_Name = {
    Text = "Warna yang Mengingatkan"
  },
  Event_7150_ChoiceDesc1 = {
    Text = "[Siapa kamu sebenarnya?]"
  },
  Event_7150_ChoiceDesc2 = {
    Text = "[Bagaimana cara mengubah pola pikir?]"
  },
  Event_7150_Desc = {
    Text = [[
Pria berambut panjang sekali lagi menghalangi jalan kalian. Setelah kejadian terakhir, Ramona tampak tidak bersahabat.
"Jangan khawatir, temanku." pria itu berbicara perlahan, suaranya berwibawa dan memikat, cara dia berbicara seolah-olah aliran udara melewati saluran udara yang sempit, diselingi suara gesekan mendesis.
"Aku sudah mengamati cukup lama. Mengubah pola pikir adalah kunci untuk membawamu lebih dekat pada tujuanmu."]]
  },
  Event_7150_Name = {
    Text = "Teman Perjalanan Aneh III"
  },
  Event_7151_ChoiceDesc1 = {
    Text = "[Saya sedang mencari] Meningkatkan Arg1 poin Kesehatan maksimum"
  },
  Event_7151_ChoiceDesc2 = {
    Text = "[Aku Menghindar] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7151_Desc = {
    Text = [[
"Saya melihat seseorang yang sedang mencari, mencari sesuatu yang tak terjangkau untuk dicari, sesuatu yang penuh kesedihan dan kontradiktif, sesuatu yang disebut kebenaran.
Saya melihat seseorang yang sedang menghindari, menghindari sesuatu yang tak terelakkan, sesuatu yang kejam dan tersembunyi, sesuatu yang disebut kebenaran.
Kamu termasuk yang mana?"]]
  },
  Event_7151_Name = {
    Text = "Objek yang Dikejar"
  },
  Event_7152_ChoiceDesc1 = {
    Text = "[Periksa dengan cermat] Tingkatkan 1 Relik perak menjadi Relik emas [(RelicConfig.Arg1)]"
  },
  Event_7152_ChoiceDesc2 = {
    Text = "[Coba Dengarkan] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\" dan \"(Skill.Arg3)\""
  },
  Event_7152_ChoiceDesc3 = {
    Text = "[Simpan dengan hati-hati] Mendapatkan 25 Segil Hitam"
  },
  Event_7152_Desc = {
    Text = "Kabut di depan diterangi oleh sesuatu yang kecil, tampak seperti fragmen kaca atau kristal, dengan warna-warni mencolok dan redup bergerak di dalamnya."
  },
  Event_7152_Name = {
    Text = "Kenangan Kami"
  },
  Event_7153_ChoiceDesc1 = {
    Text = "[ Terima Tantangan ] Kemenangan memberikan Relik perak, kekalahan memberikan Gejala. Apapun hasilnya, tidak memengaruhi Penyelidikan selanjutnya."
  },
  Event_7153_ChoiceDesc2 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7153_Desc = {
    Text = [[
Siapa orang di dalam bayangan?
Dia memiliki napas yang sinkron denganmu, detak jantung yang seirama, dan berbagi ide jahat yang sama. Apakah ini lelucon dari Domain, atau bayangan yang melintasi Dimensi?
Sepertinya ini adalah undangan tantangan yang ilusif?]]
  },
  Event_7153_Name = {
    Text = "Resonansi Jiwa"
  },
  Event_7154_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7154_Desc = {
    Text = [[
Pandangan melampaui sejarah dan waktu, mungkin itu tidak linear, mungkin sedang memandangmu dari Kekacauan sebelum kelahiran Planet. 
 Atau mungkin, suatu hari di masa depan ia menunggumu.]]
  },
  Event_7154_Name = {
    Text = "Melihat secara diam-diam"
  },
  Event_7155_ChoiceDesc1 = {
    Text = "[Claim] Mendapatkan 50 Segil Hitam"
  },
  Event_7155_Desc = {
    Text = [[
Di sana tidak ada apa-apa, cairan hitam mengalir di atas tanah, tidak memantulkan apa pun. 
 Apakah ini ilusi milikmu? Kamu merasakan sesuatu meluncur di antara jari-jari.]]
  },
  Event_7155_Name = {
    Text = "Di bawah permukaan cermin"
  },
  Event_7156_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7156_Desc = {
    Text = [[
"Anda benar-benar orang yang murah hati, semoga hari ini, besok, dan lusa semua keinginan Anda terwujud."
"Ngomong-ngomong, ini adalah transaksi satu kali saja......"
Peri itu puas menjilat bibirnya, dengan berat hati mengucapkan selamat tinggal kepada Anda.]]
  },
  Event_7156_Name = {
    Text = "Berkat Peri"
  },
  Event_7157_ChoiceDesc1 = {
    Text = "[Kembalikan dompetku!] Dapatkan salah satu dari 3 Orison"
  },
  Event_7157_ChoiceDesc2 = {
    Text = "[Ragu-ragu] 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7157_Desc = {
    Text = [[
"Kemarilah, ambil kembali dompetmu!"Anak kecil di kejauhan melambaikan tangan.
Kamu berlari ke depan, dan saat kamu mengulurkan tangan, tiba-tiba terdengar suara bising yang besar dan kacau di dalam kepalamu.
"Anak kotor dari mana ini!"
"Tikus jalanan, bagaimana berani menyentuh gaun sutra sang Duchess!"
"Cepat usir dia!"
"Apakah kamu membawa koin? Tanpa koin, jangan harap bisa mendapatkan sepotong roti hitam pun!"]]
  },
  Event_7157_Name = {Text = "Buku Nihil"},
  Event_7158_ChoiceDesc1 = {
    Text = "[Pursue the Melody] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7158_ChoiceDesc2 = {
    Text = "[Mengikuti Nyanyian] Infeksi [(Skill.Arg1)], Orison ulang, maksimal 2 kali"
  },
  Event_7158_Desc = {
    Text = [[
Nyanyian yang samar hancur menjadi beberapa serpihan bintang: 
"Aku mengutuk genangan air kotor di gang malam, di dasar tembok yang runtuh terdapat bunga-bunga busuk, rantai merayap ke otak dan jatuh ke dalam lumpur. Sebelum kabut tebal menghapus keberadaanku, senja akan tenggelam ke dalam @2 yang paling dalam."]]
  },
  Event_7158_Name = {
    Text = "Kutukan Materi Putih"
  },
  Event_7159_ChoiceDesc1 = {
    Text = "[Meninggalkan Nafkah] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7159_ChoiceDesc2 = {
    Text = "[Membawa-Nya Pergi] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7159_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7159_Desc = {
    Text = "Saat kamu mendekat, jiwa kekacauan yang tanpa urutan tiba-tiba muncul dari genangan.\nLengan hitam melilit erat di sekelilingmu, Ia menangis, merintih —\nTawarkan persembahan, atau bawa Ia pergi."
  },
  Event_7159_Name = {
    Text = "Roh Kekacauan"
  },
  Event_7160_ChoiceDesc1 = {
    Text = "[Tinggalkan Persembahan] Secara acak meningkatkan kualitas orison dari 1 kartu"
  },
  Event_7160_ChoiceDesc2 = {
    Text = "[Bawa Pergi] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7160_Desc = {
    Text = "Saat kamu mendekat, jiwa kekacauan yang tanpa urutan tiba-tiba muncul dari genangan.\nLengan hitam melilit erat di sekelilingmu, Ia menangis, merintih —\nTawarkan persembahan, atau bawa Ia pergi."
  },
  Event_7160_Name = {
    Text = "Roh Kekacauan"
  },
  Event_7161_ChoiceDesc1 = {
    Text = "[Kibas Tangan untuk Mengusir] 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7161_ChoiceDesc2 = {
    Text = "[Biarkan tetap] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7161_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7161_Desc = {
    Text = [[
Sayap kupu-kupu yang bergerak naik turun membawa cairan hitam kental, terbang dengan goyangan tidak stabil. Lapisan demi lapisan cairan hitam menetes dari sayapnya, mengering dan terkikis oleh angin setelah mengeras. 
Ia kelelahan dan hinggap di ujung hidungmu.]]
  },
  Event_7161_Name = {
    Text = "Kupu-kupu Cairan Hitam"
  },
  Event_7162_ChoiceDesc1 = {
    Text = "[Kibas Tangan untuk Mengusir] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7162_ChoiceDesc2 = {
    Text = "[Dibiarkan tetap] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7162_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7162_Desc = {
    Text = [[
Sayap kupu-kupu yang bergerak naik turun membawa cairan hitam kental, terbang dengan goyangan tidak stabil. Lapisan demi lapisan cairan hitam menetes dari sayapnya, mengering dan terkikis oleh angin setelah mengeras. 
Ia kelelahan dan hinggap di ujung hidungmu.]]
  },
  Event_7162_Name = {
    Text = "Kupu-kupu Cairan Hitam"
  },
  Event_7163_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7163_Desc = {
    Text = "\"Saya melihat keberanian, melihat tekad, melihat Roh yang bersinar seperti bintang. Menuju Memori yang disegel dalam lilin itu, kamu pasti akan mencapai keinginanmu.\""
  },
  Event_7163_Name = {
    Text = "Objek yang Dikejar"
  },
  Event_7164_ChoiceDesc1 = {
    Text = "[Biarkan Tinggal] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7164_ChoiceDesc2 = {
    Text = "[Mengibaskan tangan untuk mengusir] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7164_ChoiceDesc3 = {
    Text = "[Menyambut Kupu-kupu] Mendapatkan 25 Segil hitam"
  },
  Event_7164_Desc = {
    Text = [[
Kalian berkeliling di sanatorium yang dingin dan berangin, seekor kupu-kupu hitam yang seharusnya tidak ada di musim ini datang dengan anggun. 
 Sayap kupu-kupu yang bergerak naik turun membawa cairan hitam kental, terbang dengan goyangan tidak stabil, lapisan demi lapisan cairan hitam menetes dari sayapnya, mengering dan terkikis oleh angin setelah mengeras. 
 Ia kelelahan dan hinggap di ujung jarimu.]]
  },
  Event_7164_Name = {
    Text = "Sesuatu yang tidak seharusnya ada"
  },
  Event_7165_ChoiceDesc1 = {
    Text = "[Keluar] Dapatkan 1 dari 3 pilihan Relik perak, terinfeksi [(Skill.Arg1)]"
  },
  Event_7165_Desc = {
    Text = [[
Kamu mulai merasa lelah. 
Kesadaran menarikmu, melewati kolam, melewati gunung tinggi, 
terbang melewati matahari, terbang melewati tahun cahaya, 
terbang menuju yang unik...... tempat tidur kosmik.]]
  },
  Event_7165_Name = {
    Text = "Upacara Penutupan IV"
  },
  Event_7166_ChoiceDesc1 = {
    Text = "[Cari lagi]"
  },
  Event_7166_Desc = {
    Text = "Bayangan raksasa sepenuhnya menutupi dirimu, air liur yang berbau busuk membuatmu basah kuyup seperti tikus. \n\"Tikus kecil, cepat kemari. Hanya sebentar saja…\"\n\"Aku bersumpah, aku sama sekali tidak punya niat untuk memakanmu…\"\n\"Aku tidak akan melirik perutmu yang gemuk dan berair sedikit pun!\""
  },
  Event_7166_Name = {
    Text = "Material No. 12"
  },
  Event_7167_ChoiceDesc1 = {
    Text = "[Cari lagi]"
  },
  Event_7167_Desc = {
    Text = "Patung lilin yang kering mengisap rokok, dikelilingi oleh kabut putih. \n\"Ada sesuatu di seberang, namun tidak dapat diketahui, jadi sisi lainnya tak terjangkau.\"\n\"Bayangkan dunia ini sebagai sebuah permainan… \nApa yang kamu cari mungkin ada di sisi lain peta.\""
  },
  Event_7167_Name = {
    Text = "Material No. 45"
  },
  Event_7168_ChoiceDesc1 = {
    Text = "[Cari lagi]"
  },
  Event_7168_Desc = {
    Text = "\"Maaf, aku tidak bermaksud menargetkan……\"\n\"Aku tidak suka tikus. Masalah dengan tikus adalah mereka tidak pernah takut pada manusia……\"\nPria tua berjanggut terbaring di sudut, matanya yang penuh kesedihan menatapmu dengan tajam.\n\"Tentu saja, kalian sangat ambisius.\nItu bagus, tapi masih belum cukup untuk membantu kalian menghindari Clades……\""
  },
  Event_7168_Name = {Text = "Bahan 4"},
  Event_7169_ChoiceDesc1 = {
    Text = "[Memperlihatkan Kutukan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7169_ChoiceDesc2 = {
    Text = "[Tolak Gagak] Dapatkan 1 dari 3 Orison"
  },
  Event_7169_ChoiceDesc3 = {
    Text = "[Mengabaikan]"
  },
  Event_7169_Desc = {
    Text = [[
Burung gagak berkepala banyak yang gelap dan sakit terbang keluar dari jubah hitam seorang penganut Penerang Cahaya Kuil, lalu hinggap di pundakmu. 
"Lihat kepalaku? Setiap kali aku merasakan kutukan, aku akan tumbuh kepala baru. Ayo, tunjukkan padaku! Kutukanmu!"]]
  },
  Event_7169_Name = {
    Text = "Burung Gagak Terkutuk"
  },
  Event_7170_ChoiceDesc1 = {
    Text = "[Menanggapi Panggilan] Hapus 1 Kartu Perintah, dan pulihkan Arg1 poin Hidup"
  },
  Event_7170_ChoiceDesc2 = {
    Text = "[Bukan dalam pelarian] Memperoleh Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7170_Desc = {
    Text = [[
Kamu berlari cepat di gang. Adrenalin terpicu, asam laktat terbentuk, glukosa habis... Kekacauan menggerogoti otakmu, menguasai pikiranmu, mendorongmu untuk melarikan diri menuju garis finis dalam ilusi berwarna-warni. 
Ya, melarikan diri. Jika kamu benar-benar tidak sedang melarikan diri, lalu mengapa yang menantimu adalah kekacauan dan kehampaan, ketidakberdayaan dan akhir yang sia-sia?]]
  },
  Event_7170_Name = {Text = "Berlari"},
  Event_7171_ChoiceDesc1 = {
    Text = "[Menelusuri Sumber Suara]"
  },
  Event_7171_ChoiceDesc2 = {
    Text = "[Memanggil Lily dan Kuum]"
  },
  Event_7171_Desc = {
    Text = "Dari kejauhan Lorong Dimensi, terdengar suara tenggorokan yang rendah dan berat, bercampur dengan rasa takut, harapan, dan kegelisahan, seolah-olah memanggil kalian. Segera setelah itu, terdengar gumaman samar-samar seorang gadis, lalu kedua suara tersebut perlahan-lahan menghilang."
  },
  Event_7171_Name = {
    Text = "Suara Petunjuk"
  },
  Event_7172_ChoiceDesc1 = {
    Text = "[Dimasukkan ke dalam kantong]"
  },
  Event_7172_Desc = {
    Text = "Sebuah zat perak berwarna mendekati merkuri, disaring dari lendir pelarut, mengandung kekuatan roh yang besar, terutama digunakan untuk menghubungkan lebih banyak Pembangun dalam ritual."
  },
  Event_7172_Name = {Text = "Perak"},
  Event_7173_ChoiceDesc1 = {
    Text = "[Mohon dia untuk memberi jalan]"
  },
  Event_7173_ChoiceDesc2 = {
    Text = "[Menanyakan Identitas]"
  },
  Event_7173_Desc = {
    Text = [[
Kalian melangkah ke dalam gerbong yang redup, perasaan aneh mulai menyelimuti hati.
Gerbong ini kosong melompong, para penumpang sudah melarikan diri, sementara di lantai menyebar sisa-sisa tubuh monster yang sedang perlahan menghilang.
Di tengah gerbong, berdirilah pria itu.
"Saya percaya bahwa ada takdir di dunia ini, dan juga takdir yang membuat kita menaiki kereta bawah tanah yang sama."]]
  },
  Event_7173_Name = {
    Text = "Teman Perjalanan Aneh IV"
  },
  Event_7174_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7174_Desc = {
    Text = [[
"Matamu sangat indah, seperti bintang."
Charlotte tertawa kecil, rambutnya yang berkibar dalam kegilaan dengan lembut jatuh menutupi wajahnya.
"Kamu pasti sangat populer di sekolah, aku juga menyukaimu."
Sebelum pergi, dia mencium dahimu.
Kamu merasa tubuhmu hangat, ada sesuatu yang tampaknya telah berubah.]]
  },
  Event_7174_Name = {
    Text = "Bayang Penyelidik"
  },
  Event_7175_ChoiceDesc1 = {
    Text = "[Baca] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7175_ChoiceDesc2 = {
    Text = "[Ke tangan] Terinfeksi \"(Skill.Arg1)\", mendapatkan Relik: \"(RelicConfig.Arg2)\""
  },
  Event_7175_Desc = {
    Text = [[
Selembar kertas yang menguning jatuh dari jubah Penerang cahaya kuil. 
 Di atas kertas itu tertulis rapat teks aneh dengan bentuk yang unik, beberapa terlihat seperti simbol piktograf, beberapa anehnya mengarah ke atas, dan beberapa huruf bahkan saling tumpang tindih, hanya sedikit kata yang dapat dibaca dengan susah payah.]]
  },
  Event_7175_Name = {
    Text = "Kode Rahasia·Atas"
  },
  Event_7176_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7176_Desc = {
    Text = [[
Kamu berkata: "Ah, Charlotte! Tidak boleh!"
Rambut Charlotte bergerak-gerak dengan **Kegilaan**, dia marah.
"Aku akan membuktikannya padamu! Lihat saja kemampuanku!"]]
  },
  Event_7176_Name = {
    Text = "Bayang Penyelidik"
  },
  Event_7177_ChoiceDesc1 = {
    Text = "[Infeksi \"(Skill.Arg1)\", mendapatkan Relik perak \"(RelicConfig.Arg2)\"]"
  },
  Event_7177_ChoiceDesc2 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7177_Desc = {
    Text = "Acara 302 (dalam pengembangan), bukan efek akhir"
  },
  Event_7177_Name = {
    Text = "Acara 302 (dalam pengembangan)"
  },
  Event_7178_ChoiceDesc1 = {
    Text = "[Menerima permintaan] Terinfeksi \"(Skill.Arg1)\", memperoleh Relik perak \"(RelicConfig.Arg2)\""
  },
  Event_7178_ChoiceDesc2 = {
    Text = "[Permintaan Ditolak] Mendapatkan 25 Segil Hitam"
  },
  Event_7178_Desc = {
    Text = [[
Rahang berbunyi kesakitan, suara yang memiliki ritme tertentu, sementara temanmu kebetulan tahu sedikit tentang kriptografi.
Teks yang terpecahkan adalah sebagai berikut:
"Hallo, panggil saya @2 Dokter. Saya pernah menjadi seorang kolektor, ahli biologi......
(Ini adalah kisah panjang tentang karier dan gelar, diabaikan)
Singkatnya, bisakah kamu membantu saya menemukan separuh lainnya? Itu adalah sebuah rahang atas kecil.
Asalkan dapat menemukannya, harta pribadi saya akan terbuka untukmu."]]
  },
  Event_7178_Name = {Text = "Berderak"},
  Event_7179_ChoiceDesc1 = {
    Text = "[Investasi Seratus Taring] Terinfeksi \"(Skill.Arg1)\", mendapatkan Relik perak \"(RelicConfig.Arg2)\""
  },
  Event_7179_ChoiceDesc2 = {
    Text = "[Gunakan lima Pensh untuk mendapatkan 25 Segil hitam.]"
  },
  Event_7179_Desc = {
    Text = [[
Dompet bordir itu bergerak, membuka mulutnya yang hitam legam ke arahmu. 
 Sejak ditinggalkan oleh tuannya yang kaya, dompet itu sudah lapar selama puluhan tahun, sangat ingin diisi. 
 Kamu melihat ke dalam dompet, di dalamnya kosong, hanya ada kegelapan pekat yang tak terlihat dasarnya.]]
  },
  Event_7179_Name = {
    Text = "Dompet rakus"
  },
  Event_7180_ChoiceDesc1 = {
    Text = "[Adalah tekad yang teguh] Hapus 1 Kartu Perintah, dan pulihkan Arg1 poin Hidup."
  },
  Event_7180_ChoiceDesc2 = {
    Text = "[Hasrat akan kesuksesan] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7180_Desc = {
    Text = [[
"Dua orang yang keras kepala, panti sudah sangat berbahaya,"tiba-tiba terdengar suara Boneka dari komunikator, "kalian berencana apa selanjutnya, membantu dia menjahit kepalanya kembali?"
"Ini bukan waktunya bicara seenaknya, Boneka!"
"Aku tahu, aku bisa mendengarnya."Boneka berkata, "Tetap tenang, kalian tahu apa kunci keberhasilannya?"]]
  },
  Event_7180_Name = {
    Text = "Aturan Logan"
  },
  Event_7181_ChoiceDesc1 = {
    Text = "[Infeksi \"(Skill.Arg1)\", mendapatkan Relik perak \"(RelicConfig.Arg2)\"]"
  },
  Event_7181_ChoiceDesc2 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7181_Desc = {
    Text = "Acara 304 (dalam pengembangan), bukan efek akhir"
  },
  Event_7181_Name = {
    Text = "Acara 304 (dalam pengembangan)"
  },
  Event_7182_ChoiceDesc1 = {
    Text = "[Infeksi \"(Skill.Arg1)\", mendapatkan Relik perak \"(RelicConfig.Arg2)\"]"
  },
  Event_7182_ChoiceDesc2 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7182_Desc = {
    Text = "Acara 305 (dalam pengembangan), bukan efek akhir"
  },
  Event_7182_Name = {
    Text = "Acara 305 (dalam pengembangan)"
  },
  Event_7183_ChoiceDesc1 = {
    Text = "[Gantung telepon] Dapatkan 1 dari 3 Orison tingkat lanjut"
  },
  Event_7183_ChoiceDesc2 = {
    Text = "[Mengangkat telepon] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7183_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_7183_Desc = {
    Text = "Kalian melewati ruang istirahat kondektur kereta, di sudut tersembunyi, dering telepon berbunyi dengan tajam."
  },
  Event_7183_Name = {
    Text = "Panggilan kereta"
  },
  Event_7184_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7184_Desc = {
    Text = "Cahaya redup, namun tetap nyata adanya. \nChip perak yang begitu redup sulit untuk memanggil Pembangun, tetapi sangat baik digunakan untuk memperkuat — inilah yang disebut teknologi chip perak."
  },
  Event_7184_Name = {
    Text = "Bukti Kehidupan"
  },
  Event_7185_ChoiceDesc1 = {
    Text = "[Portret Wanita] Meningkatkan kualitas orison secara acak pada 1 kartu"
  },
  Event_7185_ChoiceDesc2 = {
    Text = "[Foto Keluarga Patung Lilin] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7185_Desc = {
    Text = "Di dalam museum lilin, terdapat banyak koleksi lukisan juga. \nTokoh, pemandangan, benda mati, realis, abstrak... \nMereka menghiasi dinding yang semula monoton, membuatnya tidak terlihat membosankan. \nPandanganmu tertarik pada salah satunya, itu adalah sebuah ——"
  },
  Event_7185_Name = {
    Text = "Galeri Potret"
  },
  Event_7186_ChoiceDesc1 = {
    Text = "[Lanjutkan membaca] Dapatkan 1 Kartu perintah acak dengan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7186_ChoiceDesc2 = {
    Text = "[Meninggalkan] Meningkatkan Arg1 poin Kesehatan maksimum, terinfeksi [(Skill.Arg2)]"
  },
  Event_7186_Desc = {
    Text = "Sebuah timbangan yang digunakan untuk menimbang.\nDi belakangnya, tak terhitung banyaknya organ direndam dalam formalin merah.\nOrgan-organ tersebut disusun rapi di rak penyimpanan.\nKamu mengambil buku catatan di samping dan membacanya:\n\"Jantung: 8 ons, Otak: 50 ons…\""
  },
  Event_7186_Name = {
    Text = "Pendaftaran Organ"
  },
  Event_7187_ChoiceDesc1 = {
    Text = "[Membuka Hadiah] Mendapatkan Kartu Spesial"
  },
  Event_7187_Desc = {
    Text = "Bayangan anak melintas di depanmu, kamu tidak bisa membedakan apakah itu benar-benar seorang anak kecil atau proyeksi Roh dari Domain. Namun — kamu menatap kotak yang tertinggal di tanah, di atasnya tertulis \"Hadiah\" dengan tulisan tangan yang masih polos."
  },
  Event_7187_Name = {
    Text = "Hadiah Baik Hati"
  },
  Event_7188_ChoiceDesc1 = {
    Text = "[Memanggil Burung Gagak]Mendapatkan 40 Segil Hitam, terinfeksi[(Skill.Arg2)]，lanjut memilih"
  },
  Event_7188_ChoiceDesc2 = {
    Text = "[Menjauh Jauh] Mendapatkan 25 Segil Hitam"
  },
  Event_7188_Desc = {
    Text = [[
Burung camar putih bertengger di atas tiang layar, dan tiang layar itu diselimuti oleh embun beku. 
 Pipa-pipa seruling bergetar serempak, mereka menolak keberadaan hitam, serta menolak burung hitam kelam yang tidak berasal dari lautan lepas.]]
  },
  Event_7188_Name = {
    Text = "Gagak yang Sendirian"
  },
  Event_7189_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7189_Desc = {
    Text = [[
Kamu mendengar bahwa nyanyian itu diadaptasi dari sebuah lagu cinta.
Di akhir lagu cinta tersebut, penyair berkata:
"Hingga suara manusia membangun kita, kita akan mati tenggelam."
Bukan sekarang, pikirmu dalam hati.
Kamu masih menunggu manusia untuk membangunmu.]]
  },
  Event_7189_Name = {
    Text = "Suara Rombongan Gagak"
  },
  Event_7190_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7190_Desc = {
    Text = [[
Sebuah gulungan film yang dipenuhi debu. Namun, tidak ada proyektor di dalam ruangan ini, dan ini bukan saat yang tepat untuk bersantai menikmati mansion, film, serta teh sore hari. 
Mungkin setelah waktu yang lama, kamu akan memiliki kesempatan untuk mengetahui isi dari film tersebut.]]
  },
  Event_7190_Name = {
    Text = "Kenangan Cahaya dan Bayang-bayang"
  },
  Event_7191_ChoiceDesc1 = {
    Text = "[Pergi] Dapatkan 1 dari 3 Orison tingkat lanjut, terinfeksi [(Skill.Arg1)]"
  },
  Event_7191_Desc = {
    Text = [[
Kamu mengikuti di belakang anak laki-laki, tidak jauh dan tidak dekat. 
Tak. Tak. Tak... Anak laki-laki itu berhenti di sudut jalan. 
Kamu melihat cahaya merah yang goyang-goyang di belakangnya, nalurimu memberitahumu bahwa Museum lilin ada di depan. 
Anak laki-laki itu berbalik. Dia tidak memiliki mata, rongga matanya gelap. 
Dia tersenyum padamu.]]
  },
  Event_7191_Name = {
    Text = "Upacara Penutupan I"
  },
  Event_7192_ChoiceDesc1 = {
    Text = "[Pergi] mendapatkan 50 Segil hitam, terinfeksi [(Skill.Arg1)]"
  },
  Event_7192_Desc = {
    Text = [[
Kamu menepuk pundaknya. 
Bocah itu berbalik, dia tidak memiliki mata, dan rongga matanya gelap gulita. 
"Selamat malam. Aku sedang mencari jalan ke Museum Lilin." 
Bocah itu menunjuk ke depan. Kamu melihat cahaya merah yang goyah di belakangnya. 
Instingmu mengatakan bahwa Museum Lilin ada di sana. 
Sadar kembali, bocah itu sudah menghilang, hanya menyisakan bayangan panjang dari lampu jalan.]]
  },
  Event_7192_Name = {
    Text = "Upacara Penutupan I"
  },
  Event_7193_ChoiceDesc1 = {
    Text = "[Menangkap Gagak]mendapatkan 35 Segil hitam, terinfeksi[(Skill.Arg2)], terus memilih"
  },
  Event_7193_ChoiceDesc2 = {
    Text = "[Meninggalkan begitu saja] Pergi"
  },
  Event_7193_Desc = {
    Text = "Gagak kesepian dengan suara serak mencabut bulu hitamnya satu per satu. \n Ia gemetar karena rasa sakit, berteriak nyaring, namun tak mampu menghentikan gerakannya yang semakin cepat. \n \"Ka——ka——\" \n Air mata birunya yang bercampur cairan hitam mengalir dari matanya. Hanya kau yang menyaksikannya, tak seorang pun lainnya."
  },
  Event_7193_Name = {
    Text = "Air Mata Magma"
  },
  Event_7194_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7194_Desc = {
    Text = "Pengetahuan yang tak ternilai membanjiri pikiranmu, lalu berubah menjadi kabut... Ketika kamu tersadar, buku dengan sampul kuning yang aneh itu sudah menghilang tanpa jejak..."
  },
  Event_7194_Name = {
    Text = "Gulungan Buku Kuning"
  },
  Event_7195_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7195_Desc = {
    Text = [[
Kamu dengan mudah menjatuhkan patung lilin ini. Mereka jatuh dengan kepala tertunduk di hadapanmu. 
Bagian bawah patung lilin tampaknya memiliki beberapa baris tulisan. 
"Tahun Hongji ke-2, bulan 11
Dibuat oleh Rogers di Akademi @2"
Kamu ingat bahwa Rogers pernah belajar di jurusan patung di sebuah akademi seni, patung lilin yang canggung ini pasti merupakan latihannya dari tahun-tahun itu.]]
  },
  Event_7195_Name = {Text = "Latihan"},
  Event_7196_ChoiceDesc1 = {Text = "[Mengapa]"},
  Event_7196_ChoiceDesc2 = {
    Text = "[Menuju Kedalaman Aequor]"
  },
  Event_7196_Desc = {
    Text = [[
"Palsu! Kembalikan anakku!"
 "Bukankah kamu adalah Perawan Suci Kapal? Bukankah tugasmu melindungi kapal? Kenapa hanya satu kapal yang kembali, katakan, katakan!"
 "Tenggelamkan dia! Dia juga harus merasakan penderitaan yang dialami ayahku sebelum dia meninggal!"
 "Tenggelamkan dia, tenggelamkan dia!"
 "Tenggelamkan penipu ini! Ikat dia di atas batu!"
Air laut memenuhi mulut dan hidungnya, udara terdorong keluar dari setiap sudut alveoli paru-parunya, dan dia masih mengenakan gaun putih megah itu.
Hampir menjadi pikiran pertama setelah menjadi santa, muncul perlahan dari sudut tergelap di kepalanya, datang terlambat.
 "Ya, kenapa kapal-kapal itu bisa tenggelam?"]]
  },
  Event_7196_Name = {
    Text = "Tenggelam di laut"
  },
  Event_7197_ChoiceDesc1 = {
    Text = "[Menangkap Gagak]mendapatkan 30 Segil hitam, terinfeksi[(Skill.Arg2)], terus memilih"
  },
  Event_7197_ChoiceDesc2 = {
    Text = "[Meninggalkan begitu saja] Pergi"
  },
  Event_7197_Desc = {
    Text = "Gagak kesepian dengan suara serak mencabut bulu hitamnya satu per satu. \n Ia gemetar karena rasa sakit, berteriak nyaring, namun tak mampu menghentikan gerakannya yang semakin cepat. \n \"Ka——ka——\" \n Air mata birunya yang bercampur cairan hitam mengalir dari matanya. Hanya kau yang menyaksikannya, tak seorang pun lainnya."
  },
  Event_7197_Name = {
    Text = "Air Mata Magma"
  },
  Event_7198_ChoiceDesc1 = {
    Text = "[Lanjutkan Pencarian] Tingkatkan Arg1 poin Hidup, terinfeksi [(Skill.Arg2)]"
  },
  Event_7198_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7198_Desc = {
    Text = "Sepertinya ada sepasang tangan yang menyentuh bahumu, kuat dan mantap. Namun, ketika kamu berbalik untuk mencarinya, sensasi sentuhan yang awalnya nyata itu menjadi sulit ditemukan dan terasa menghilang."
  },
  Event_7198_Name = {
    Text = "Kontak Anomali"
  },
  Event_7199_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7199_Desc = {
    Text = "Jembatan rel, pembuluh darah dan saraf Londinium, menghubungkan jantung dan anggota tubuh kota, Rumah Sakit Jiwa Ruhai berada di ujung anggota tubuh, menunggu dengan tenang aliran darah dan sinyal."
  },
  Event_7199_Name = {
    Text = "Fatamorgana Rel"
  },
  Event_7200_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7200_Desc = {
    Text = [[
Kamu meletakkan koper di tanah dan menginjaknya beberapa kali dengan kuat, memastikan bahwa itu tidak lagi bergetar sebelum mengangkatnya kembali. 
 Setelah menepuk debu di atasnya, di bawah tatapan bingung Murphy, kalian melanjutkan perjalanan.]]
  },
  Event_7200_Name = {
    Text = "Surat Tak Terduga"
  },
  Event_7201_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7201_Desc = {
    Text = "Bahaya mengintaimu dari balik pintu kayu, tidak cocok untuk membuang-buang waktu. Simpanlah di dalam koper."
  },
  Event_7201_Name = {
    Text = "Gulungan Buku Kuning"
  },
  Event_7202_ChoiceDesc1 = {
    Text = "[Mengusir Gagak] Mendapatkan Arg1 Segil hitam, terinfeksi [(Skill.Arg2)], lanjutkan memilih"
  },
  Event_7202_ChoiceDesc2 = {
    Text = "[Mengabaikan] Pergi"
  },
  Event_7202_Desc = {
    Text = "Itu, atau lebih tepatnya mereka, melayang di kamar tidur, membuat lampu bergoyang dan berbunyi berdering."
  },
  Event_7202_Name = {
    Text = "Lentera Gagak Hitam"
  },
  Event_7203_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7203_Desc = {
    Text = [[
Ini adalah dimensi Roh, dunia Gnosis. 
 Selain mengacaukan pikiranmu, mereka tidak bisa melakukan apa pun.]]
  },
  Event_7203_Name = {
    Text = "Badai Gnosis"
  },
  Event_7204_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7204_Desc = {
    Text = [[
Tengkorak: Hank Tillinghast A.F.186-A.F.203 Pulau Creole
Tulang belakang: Andy Cloughford A.F.177-A.F.203 Narragansett
...... tidak bisa dipikirkan terlalu dalam.]]
  },
  Event_7204_Name = {Text = "Plakat"},
  Event_7205_ChoiceDesc1 = {
    Text = "[Periksa Fragmen] Dapatkan 3 kartu perintah secara acak dari dek, pilih 1 kartu untuk dihapus, dan dapatkan 75 segil hitam."
  },
  Event_7205_ChoiceDesc2 = {
    Text = "[Bertanya kepada Boneka] Dapatkan 3 kartu perintah secara acak dari dek, pilih 1 salinan asli kartu untuk masuk ke dek, dan dapatkan 25 Segil Hitam."
  },
  Event_7205_ChoiceDesc3 = {
    Text = "[Mengabaikan] Mendapatkan 50 Segil Hitam"
  },
  Event_7205_Desc = {
    Text = "Fragmen logam yang diberikan Boneka kepadamu bergerak gelisah di dadamu, seperti kupu-kupu yang terganggu."
  },
  Event_7205_Name = {
    Text = "Brooch Tidak Tenang"
  },
  Event_7206_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7206_Desc = {
    Text = "\"Dia menunggu dengan tenang di titik akhir, di mana pun kau menetapkan titik akhir itu — lihatlah manajer muda itu, pelariannya pada akhirnya mengundang kegilaan.\""
  },
  Event_7206_Name = {
    Text = "Objek yang Dikejar"
  },
  Event_7207_ChoiceDesc1 = {
    Text = "[Tidak ada penemuan saat keluar]"
  },
  Event_7207_Desc = {
    Text = "Dalam pengembangan, Acara khusus"
  },
  Event_7207_Name = {
    Text = "2_16 Sementara"
  },
  Event_7208_ChoiceDesc1 = {
    Text = "[Menghiburnya] Meningkatkan Kesehatan maksimum sebesar Arg1"
  },
  Event_7208_ChoiceDesc2 = {
    Text = "[Mengabaikannya] 2 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi 2 \"(Skill.Arg2)\""
  },
  Event_7208_Desc = {
    Text = [[
Tautan menghangatkan organ yang masih berfungsi sebagai jantung manusia.
Ia meniru ritme napas dari ujung tautan di sisi lain, seolah-olah dengan melakukan itu, ia tidak akan ditinggalkan dan memiliki hak untuk selamanya menyatu dengan tautan.]]
  },
  Event_7208_Name = {
    Text = "Atrium kiri"
  },
  Event_7209_ChoiceDesc1 = {
    Text = "Orison tingkat lanjut acak"
  },
  Event_7210_ChoiceDesc1 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7210_Desc = {
    Text = "Ketidakpedulianmu membuat pemilik suara merasa cukup menyesal. Permukaan air bergelombang malas-malasan, membentuk beberapa riak, tanpa ada gelombang lagi."
  },
  Event_7210_Name = {
    Text = "Suara di Luar Dunia"
  },
  Event_7211_ChoiceDesc1 = {
    Text = "[Pilih 1 kartu mendapatkan Orison:\"(EnchantConfig.Arg1)\"]uji Oriso"
  },
  Event_7211_ChoiceDesc2 = {
    Text = "[Pilih 1 kartu mendapatkan Orison:\"(EnchantConfig.Arg1)\"]ujian paket jatuh"
  },
  Event_7211_Desc = {
    Text = "Uji Orison yang ditentukan"
  },
  Event_7211_Name = {
    Text = "Orison Uji 1"
  },
  Event_7212_ChoiceDesc1 = {
    Text = "[Leave] Pilih Bangun 1 Pembangun"
  },
  Event_7212_Desc = {
    Text = "Kamu mengusap kepala anak laki-laki itu, membimbingnya untuk melanjutkan bersamamu. \n\"Lagu untuk Ibu——\" \nSuara itu seperti ngengat di malam gelap, berdampingan melayang keluar dari panggung yang kosong, \nlalu perlahan mendarat di kursi penonton yang gelap gulita."
  },
  Event_7212_Name = {
    Text = "Upacara Penutupan III"
  },
  Event_7213_ChoiceDesc1 = {
    Text = "[Pergi] Dapatkan 1 dari 3 pilihan Relik emas, terinfeksi [(Skill.Arg1)]"
  },
  Event_7213_Desc = {
    Text = "Kamu tetap tenang. Tiba-tiba, seorang wanita bangsawan naik ke atas panggung. \nDia dengan Kegilaan membuka mulut anak itu dan memasukkan tongkat kayu di tangannya dengan keras. \n\"Berbicara, berbicaralah padaku.\" \nDarah hitam mengalir dari mulut anak itu. Dia melanjutkan membaca dengan suara yang tidak jelas. \n\"Lagu untuk ibu…\""
  },
  Event_7213_Name = {
    Text = "Upacara Penutupan III"
  },
  Event_7215_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7215_Desc = {
    Text = [[
Itu bukan jendela, melainkan sebuah cermin. Di dalam cermin terpantul wajah Ramona yang tegang. 
Mengapa tidak ada jendela di ruangan ini, hanya ada sebuah cermin besar yang tergantung di dinding?]]
  },
  Event_7215_Name = {
    Text = "Refleksi di Jendela"
  },
  Event_7216_ChoiceDesc1 = {
    Text = "[Memegang Kunci perak] Secara acak membangunkan 1 Pembangun, terinfeksi [(Skill.Arg1)]"
  },
  Event_7216_ChoiceDesc2 = {
    Text = "[Tutup mata] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7216_Desc = {
    Text = "Kamu ditarik oleh kehampaan yang luar biasa, merangkak di tanah dengan tubuh yang terpuntir, seolah-olah dimanipulasi oleh sesuatu dari luar Dimensi.@2. \n\"Tidak… tidak…\"\n Kewarasanmu runtuh sedikit demi sedikit, tawa dan jeritan mengerikan bercampur menjadi satu, seperti jaring raksasa yang mengikat kesadaranmu, hanya ada erangan tak jelas yang meluap dari mulutmu."
  },
  Event_7216_Name = {
    Text = "Mata Pandangan"
  },
  Event_7217_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7217_Desc = {
    Text = "Warna-warni bintang berubah, menggambar pola tak tergambarkan di bawah kakimu, megah seperti batu rubi merah, namun mengembang seperti ubur-ubur. Di dalam koper, cahaya merah mulai berkilauan..."
  },
  Event_7217_Name = {
    Text = "Persimpangan Bintang"
  },
  Event_7218_ChoiceDesc1 = {
    Text = "[Mengusir Ilusi] Tekanan +10."
  },
  Event_7218_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7218_Desc = {
    Text = "Wajah-wajah kabur tiba-tiba muncul, mengelilingi kamu dan merintih putus asa dengan suara yang seolah-olah tidak ada."
  },
  Event_7218_Name = {Text = "Ilusi"},
  Event_7221_ChoiceDesc1 = {
    Text = "[Mendapatkan] Relik perak [(RelicConfig.Arg1)]"
  },
  Event_7221_ChoiceDesc2 = {
    Text = "[Menunduk untuk melihat]Mendapatkan 75 Segil Hitam, terinfeksi[(Skill.Arg2)]"
  },
  Event_7221_Desc = {
    Text = [[
Gagak berputar di langit yang terpotong-potong seperti balok oleh lorong-lorong kecil, mengeluarkan suara serak yang membuat hati tidak tenang. 
 Gerombolan gagak tiba-tiba menjadi gelisah, seolah-olah ada sifat sakit tertentu yang terdistorsi atau terbangkit, mereka saling menyerang dan mengejar dengan tergesa-gesa dan ganas, dalam tarikan itu sesuatu jatuh ke bawah.]]
  },
  Event_7221_Name = {
    Text = "Kawanan Gagak Berisik"
  },
  Event_7222_ChoiceDesc1 = {
    Text = "[Menaati instruksi] Meningkatkan Arg1 poin Hidup"
  },
  Event_7222_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7222_Desc = {
    Text = "Kamu mencoba menggunakan kekuatan penelusuran Kunci perak untuk mencari Persimpangan terdekat, tetapi informasi yang diperoleh mengandung anomali yang sulit dideteksi, sepertinya telah terganggu."
  },
  Event_7222_Name = {
    Text = "Kontak Anomali"
  },
  Event_7223_ChoiceDesc1 = {
    Text = "[Kepada Boneka] 1 Kartu perintah acak mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7223_ChoiceDesc2 = {
    Text = "[Membaca plakat] Meningkatkan Arg1 poin Kesehatan maksimum, terinfeksi [(Skill.Arg2)]"
  },
  Event_7223_Desc = {
    Text = "Dari tubuh eksperimen Para Pematung yang kamu kalahkan, jatuh sebuah plakat dengan bingkai logam. Kunci perak merespon plakat tersebut dan berkilauan pelan."
  },
  Event_7223_Name = {Text = "Plakat"},
  Event_7224_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7224_Desc = {
    Text = [[
Pemegang pisau mengeluarkan teriakan panjang, seolah-olah suara itu mampu membelah gunung dan lautan. 
 Suara itu lenyap dalam sekejap, bahkan dua Pelaut lainnya juga menghilang tanpa jejak... ternyata itu hanyalah sebuah Ilusi yang dipantulkan oleh Domain.]]
  },
  Event_7224_Name = {
    Text = "Mengejar tanpa henti"
  },
  Event_7225_ChoiceDesc1 = {
    Text = "[Patung lilin Perbaikan] Pilih Kartu dan turunkan Lelah Aritmetika sebesar 1"
  },
  Event_7225_Desc = {
    Text = [[
Kamu memegang lilin, melewati kabut yang samar, dan tiba di hadapannya. 
 Ini adalah patung lilin yang belum selesai. 
 Wajahnya yang lembut dibagi menjadi dua, satu bagian tersenyum, satu bagian @1. 
 Jadilah dewa baginya. 
 Berikan dia kecantikan, berikan dia air mata. 
 Ukir dia, atau hancurkan dia.]]
  },
  Event_7225_Name = {
    Text = "Patung Lilin yang Belum Selesai"
  },
  Event_7226_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7226_Desc = {
    Text = [[
"Tentu saja, aku pernah menyaksikan kehancuran dengan mata kepalaku sendiri." kau menjawab.
Ya, itu hanyalah kematian mendadak seekor tikus kecil, pembusukan sebuah jantung, dan upacara pemakaman seikat bunga iris yang tenggelam dalam warna malam.]]
  },
  Event_7226_Name = {
    Text = "Ranah dewa yang hilang"
  },
  Event_7227_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7227_Desc = {
    Text = "\"Ranah dewa… hilang… topik yang penuh ilusi… aku tidak tahu, bagaimana bisa disebut hilang.\"\nDua sosok itu tertawa pelan, serpihan cahaya putih berserakan di sekitar mereka.\n\"Maka saat ini, kau akan menyaksikan sebuah kehancuran yang sesungguhnya.\""
  },
  Event_7227_Name = {
    Text = "Ranah dewa yang hilang"
  },
  Event_7228_ChoiceDesc1 = {
    Text = "[Menggabungkan kertas] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7228_ChoiceDesc2 = {
    Text = "[Baca] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7228_ChoiceDesc3 = {
    Text = "[Buang Itu]Mendapatkan 50 Segil Hitam"
  },
  Event_7228_Desc = {
    Text = "Selembar kertas yang menguning jatuh dari jubah Penerang cahaya kuil. \n Di atas kertas itu tertulis rapat teks aneh, beberapa terlihat seperti simbol piktograf, beberapa anehnya mengarah ke atas, dan beberapa huruf bahkan saling tumpang tindih, hanya sedikit kata yang dapat dibaca dengan susah payah. \n Judulnya adalah 《@2 Kelahiran Anak Suci》"
  },
  Event_7228_Name = {
    Text = "Kode Rahasia·Bawah"
  },
  Event_7229_ChoiceDesc1 = {
    Text = "[Perjuangan] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7229_ChoiceDesc2 = {
    Text = "[Lumpuh] mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7229_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7229_Desc = {
    Text = [[
"Aku sangat menderita, sangat menderita..."
"Mengapa aku, mengapa aku harus mengalami ini?"
"Ya Tuhan yang Maha Pengasih, apa yang telah kulakukan salah?"
Kesedihan, penderitaan, kemarahan, ketidakrelaan... Emosi para "pasien" menekan tubuhmu dengan berat, kau memegang dada, tak bisa bernapas.]]
  },
  Event_7229_Name = {Text = "Kecanduan"},
  Event_7230_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7230_Desc = {
    Text = [[
Pandangan menembus kulit dan daging, membakar cap di retina sang Pembuka Jalan. 
 Tidak ada yang bisa melarikan diri, sama seperti tidak ada seorang pun@2]]
  },
  Event_7230_Name = {
    Text = "Melihat secara diam-diam"
  },
  Event_7231_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7231_Desc = {
    Text = [[
Fokuskan roh, kenali liriknya, lalu biarkan kalimat-kalimat yang kacau menghantam bagian belakang kepalamu. 
 Itu bukan kata-kata yang bisa dipahami oleh manusia.]]
  },
  Event_7231_Name = {Text = "Lagu Laut"},
  Event_7232_ChoiceDesc1 = {
    Text = "[Melakukan Ujian] Terinfeksi [(Skill.Arg1)], menang untuk mendapatkan Relik Emas, kalah untuk mendapatkan 50 Segil Hitam"
  },
  Event_7232_ChoiceDesc2 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_7232_Desc = {
    Text = [[
Kamu pernah mengintip beberapa rahasia dari genangan cairan hitam yang memantulkan seperti cermin di bawah kakimu. 
 Tepian bayangannya kabur, dikelilingi oleh aura hitam yang tak kunjung hilang, kamu merasakan keakraban yang aneh, tetapi tidak bisa mengenali apa sebenarnya itu.]]
  },
  Event_7232_Name = {
    Text = "Di bawah permukaan cermin"
  },
  Event_7233_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7233_Desc = {
    Text = "Kamu mengabaikan surat tanpa nama yang penuh dengan omong kosong, lalu membakarnya dengan santai. Abu dari surat itu pun beterbangan."
  },
  Event_7233_Name = {
    Text = "Surat permintaan bantuan lagi"
  },
  Event_7234_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7234_Desc = {
    Text = "Kamu memeriksa isi surat tersebut. Di bagian perekatnya, terdapat cairan lengket yang tampaknya merupakan campuran darah dan semacam bubur hitam, bercampur dengan beberapa helai rambut yang menempel di area perekat."
  },
  Event_7234_Name = {
    Text = "Surat permintaan bantuan lagi"
  },
  Event_7235_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7235_Desc = {
    Text = "Dari arah jatuhnya surat, saat berbelok di sudut dinding, kamu melihat sesuatu yang berkilau."
  },
  Event_7235_Name = {
    Text = "Surat permintaan bantuan lagi"
  },
  Event_7236_ChoiceDesc1 = {
    Text = "[Lanjutkan Pencarian] Tingkatkan Arg1 poin Hidup, terinfeksi [(Skill.Arg2)]"
  },
  Event_7236_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7236_Desc = {
    Text = "Cahaya samar muncul di depan mata, terang dan hangat. Saat ingin mengikuti cahaya itu, tiba-tiba ia menghilang."
  },
  Event_7236_Name = {
    Text = "Kontak Anomali"
  },
  Event_7237_ChoiceDesc1 = {
    Text = "[Leave] Semua Pembangun pulih Arg1 Aliemus"
  },
  Event_7237_Desc = {
    Text = [[
Kamu takut hingga erat menutup kedua matamu.
"Kamu mengangkat kain penutup itu...
Rahasia, kamu menemukan rahasia..."
Gelombang suara bergabung menjadi lautan kebisingan, lantai bergetar hebat dalam resonansi yang mengerikan.
Kamu tidak tahan lagi, tiba-tiba membuka mata, hanya untuk menemukan bahwa tidak ada apa pun di sekitarmu.]]
  },
  Event_7237_Name = {
    Text = "Upacara Penutupan V"
  },
  Event_7238_ChoiceDesc1 = {
    Text = "[Lanjutkan Pencarian] Tingkatkan Arg1 poin Hidup, terinfeksi [(Skill.Arg2)]"
  },
  Event_7238_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7238_Desc = {
    Text = "Ujung hidungmu mencium bau yang akrab, sederhana namun memuaskan. Saat kau ingin menghirup lebih dalam aroma kantin itu, aroma yang menguar tiba-tiba lenyap tanpa jejak."
  },
  Event_7238_Name = {
    Text = "Kontak Anomali"
  },
  Event_7239_ChoiceDesc1 = {
    Text = "[Lanjutkan Pencarian] Tingkatkan Arg1 poin Hidup, terinfeksi [(Skill.Arg2)]"
  },
  Event_7239_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7239_Desc = {
    Text = "Di telinga terdengar suara yang akrab, begitu hangat dan menenangkan. Namun, ketika mencoba mencari sumber suara tersebut, tiba-tiba suara itu terhenti."
  },
  Event_7239_Name = {
    Text = "Kontak Anomali"
  },
  Event_7240_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7240_Desc = {
    Text = "Kekuatan pelacakan tidak dapat menemukanmu persimpangan dalam waktu singkat, namun setidaknya kamu mendapatkan ketenangan sementara."
  },
  Event_7240_Name = {
    Text = "Kontak Anomali"
  },
  Event_7241_ChoiceDesc1 = {
    Text = "[Lanjutkan Pencarian] Tingkatkan Arg1 poin Hidup, terinfeksi [(Skill.Arg2)]"
  },
  Event_7241_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7241_Desc = {
    Text = "Sepertinya ada sepasang tangan yang menyentuh bahumu, kuat dan mantap. Namun, ketika kamu berbalik untuk mencarinya, sensasi sentuhan yang awalnya nyata itu menjadi sulit ditemukan dan terasa menghilang."
  },
  Event_7241_Name = {
    Text = "Kontak Anomali"
  },
  Event_7242_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7242_Desc = {
    Text = "\"N\" bayangannya tercerai oleh hembusan tinju, partikel hitam menyatu dengan kabut tebal Domain, sulit dilacak jejaknya. \n \"Tidak menarik, namun juga menarik. Aku sangat menantikan pertemuan sebenarnya denganmu…\""
  },
  Event_7242_Name = {
    Text = "Pertunjukan dimulai"
  },
  Event_7243_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7243_Desc = {
    Text = [[
"Anak baik. Namun, aku tetap harus memberikan hukuman kecil padamu."
Tawa ringan Dafude'er memudar di celah Dimensi.]]
  },
  Event_7243_Name = {
    Text = "Waktu Petunjuk"
  },
  Event_7244_ChoiceDesc1 = {
    Text = "[Positif] 50% kemungkinan mendapatkan Relik emas \"(RelicConfig.Arg2)\", 50% kemungkinan terinfeksi \"(Skill.Arg3)\""
  },
  Event_7244_ChoiceDesc2 = {
    Text = "[Sisi Buruk] 50% kemungkinan mendapatkan 75 Segil Hitam, 50% kemungkinan terinfeksi [(Skill.Arg3)]"
  },
  Event_7244_ChoiceDesc3 = {
    Text = "[Chip Hitam] 50% kemungkinan mendapatkan \"Relik terkutuk\"(RelicConfig.Arg2), 50% kemungkinan terinfeksi \"(Skill.Arg3)\""
  },
  Event_7244_Desc = {
    Text = [[
Bagus... bagus... 
Lalu, pilihlah chip yang kamu inginkan.]]
  },
  Event_7244_Name = {
    Text = "Pertunjukan dimulai"
  },
  Event_7245_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7245_Desc = {
    Text = "\"Baiklah, baiklah. Orang itu selalu mengganggu makhluk yang melintasi dimensi. Saya juga harus bekerja keras untuk bisa bergerak bebas di antara lubang-lubang dimensi ini. Ah, itu sudah terjadi sekitar tiga ribu tahun yang lalu, kan?\""
  },
  Event_7245_Name = {
    Text = "Waktu Petunjuk"
  },
  Event_7246_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7246_Desc = {
    Text = "Percayalah, direktur penelitian tidak akan memasang bom di dada Anda."
  },
  Event_7246_Name = {
    Text = "Brooch Tidak Tenang"
  },
  Event_7247_ChoiceDesc1 = {
    Text = "[ Meninggalkan ] Hapus 1 Kartu Perintah, dapatkan 25 Segil Hitam"
  },
  Event_7247_Desc = {
    Text = [[
"Seorang pejalan yang baik hati, memberikan petunjuk yang benar kepada mereka yang tersesat,"senyumannya terlihat penuh niat buruk, "Bergeraklah dengan ringan, Cerberus sedang menunggu kalian."
Perangkat kendali di tangannya tiba-tiba bergetar.]]
  },
  Event_7247_Name = {
    Text = "Teman Perjalanan Aneh III"
  },
  Event_7248_ChoiceDesc1 = {
    Text = "[Perlahan bergerak] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7248_ChoiceDesc2 = {
    Text = "[Membungkuk dan Berbaring Datar] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7248_Desc = {
    Text = [[
"Ketika menghadapi rawa, jangan pernah berjuang."
Kamu mengingat aturan bertahan hidup ini dengan baik, tetap diam seperti Patung di Pulau Paskah. 
Lima menit, sepuluh menit, satu jam... lumpur hitam akhirnya kehilangan kesabaran dan menghilang dari bawah kakimu.]]
  },
  Event_7248_Name = {
    Text = "Bekas Rawan Gelap"
  },
  Event_7249_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7249_Desc = {
    Text = "Kamu memperhatikan sebuah tangan yang berbeda dari yang lain. Tangan itu lembut, putih, dan sepanjang waktu menunjukkan ketenangan. \n Yang lebih penting—kamu mengenalinya, itu adalah tanganmu sendiri. \n Kamu dengan lembut menggenggamnya. \n Tangan itu juga menggenggam tanganmu. Kamu merasakan dingin yang menusuk dan kekosongan, kemudian rawa itu pun menghilang."
  },
  Event_7249_Name = {
    Text = "Bekas Rawan Gelap"
  },
  Event_7250_ChoiceDesc1 = {
    Text = "[Memotong satu tangan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7250_ChoiceDesc2 = {
    Text = "[Tenangkan mereka] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7250_Desc = {
    Text = [[
Kamu mengayunkan bilah tajam di tanganmu, memotong mereka satu per satu. 
 Berbagai macam cipratan darah mengenai tubuhmu, wajahmu, dan rambutmu, namun kamu tidak menyadarinya. 
 Ribuan tangan bersamaan mengeluarkan jeritan kesakitan, rawa itu menghilang. 
 Hingga satu minggu kemudian, kamu tidak lagi mendengar tangisan itu dalam mimpi burukmu.]]
  },
  Event_7250_Name = {
    Text = "Bekas Rawan Gelap"
  },
  Event_7251_ChoiceDesc1 = {
    Text = "[Mengambil Perak] Tingkatkan 1 Relik Perak menjadi Relik Emas [(RelicConfig.Arg1)]"
  },
  Event_7251_ChoiceDesc2 = {
    Text = "[Bangun] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\" dan \"(Skill.Arg3)\""
  },
  Event_7251_ChoiceDesc3 = {
    Text = "[Mengabaikan] Mendapatkan 25 Segil Hitam"
  },
  Event_7251_Desc = {
    Text = [[
Di bawah balok dek yang longgar, mengalir cairan hitam kotor. 
Dan kilauan di dalam cairan hitam itu adalah "Perak" yang sudah sangat kamu kenal.]]
  },
  Event_7251_Name = {
    Text = "Bukti Kehidupan"
  },
  Event_7252_ChoiceDesc1 = {
    Text = "[Pilih Tikus] Dapatkan 1 Kartu Perintah secara acak dengan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7252_ChoiceDesc2 = {
    Text = "[Pilih Lilin]meningkatkan Arg1 poin Kesehatan maksimum, terinfeksi[(Skill.Arg2)]"
  },
  Event_7252_Desc = {
    Text = [[
Tubuh yang terlulur di depanmu menghilang, abu hitam yang dingin menyatu dengan kabut, tiba-tiba membentuk sebuah timbangan yang aneh. Salah satu sisi timbangan adalah seekor tikus yang sedang tidur, dan sisi lainnya adalah sebuah lilin yang diukir menyerupai bentuk seorang anak laki-laki. 
 Dalam kegelapan, kamu tahu bahwa kamu harus membuat pilihan.]]
  },
  Event_7252_Name = {
    Text = "Kebijaksanaan dan Emosi"
  },
  Event_7253_ChoiceDesc1 = {
    Text = "[Mencoba bersuara]"
  },
  Event_7253_ChoiceDesc2 = {
    Text = "[Mengikuti diam-diam]"
  },
  Event_7253_Desc = {
    Text = [[
Saat berbelok di suatu sudut, segala sesuatu di sekitar semakin kabur, hanya teriakan mengerikan itu yang tetap jelas. 
Langkah kaki terdengar, saat kamu menoleh ke belakang, samar-samar terlihat sosok aneh: sepertinya itu manusia, namun ada bayangan berpasangan di belakangnya, sekilas tampak seperti ngengat raksasa. 
"Hati-hati," bisik Ramona memperingatkan, "Di dalam Domain, apa yang dilihat belum tentu nyata. Jika mengikutinya secara gegabah, kemungkinan besar akan ada bahaya."]]
  },
  Event_7253_Name = {
    Text = "Bayangan di dalam kabut"
  },
  Event_7254_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7254_Desc = {
    Text = [[
Kamu mengeluarkan kunci perak, dengan penuh kesedihan dan ketulusan memegangnya di telapak tangan. Cahaya tipis seperti kabut menyelimuti dirimu. 
 Dalam keheningan, hanya terdengar helaan napas.]]
  },
  Event_7254_Name = {
    Text = "Mata Pandangan"
  },
  Event_7255_ChoiceDesc1 = {
    Text = "[Sungai perak] 1 Kartu perintah acak mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7255_ChoiceDesc2 = {
    Text = "[Pilih Jalan Pelangi] Tingkatkan Arg1 poin Kesehatan maksimum, terinfeksi [(Skill.Arg2)]"
  },
  Event_7255_Desc = {
    Text = [[
Plok, plok, plok.
Detak jantung seperti genderang perang, mulut kering, tatapan dari ketinggian menembus tulang belakang hingga ke dada.
Di depan muncul jalan bercabang, satu mengalir seperti sungai bintang, yang lain berkilauan dengan cahaya pelangi.]]
  },
  Event_7255_Name = {
    Text = "Persimpangan Bintang"
  },
  Event_7256_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7256_Desc = {
    Text = [[
Pandangan yang tersisa masih mengamati mu, sel-sel caro di bawah kulitmu berteriak dalam kegilaan dan melarikan diri, pembuluh darah di bawah kulitmu bergerak seperti serangga. 
 Kamu merasakan aliran kekuatan, meledak dalam keanehan anggota tubuh yang misterius.]]
  },
  Event_7256_Name = {
    Text = "Mata Pandangan"
  },
  Event_7257_ChoiceDesc1 = {
    Text = "[Keluar] Infeksi [(Skill.Arg1)]"
  },
  Event_7257_ChoiceDesc2 = {
    Text = "[Keluar] Infeksi [(Skill.Arg1)]"
  },
  Event_7257_ChoiceDesc3 = {
    Text = "[Keluar] Infeksi [(Skill.Arg1)]"
  },
  Event_7257_Desc = {
    Text = "\"Tidak, ini tidak benar. Dibandingkan dengan kecoak, setidaknya kalian memiliki tubuh yang berbulu. \nTidak ada yang bisa menolak tubuh yang berbulu.\"\nTikus-tikus itu berbisik satu sama lain, akhirnya dengan enggan menyetujui pendapatmu. \n\"Lumayanlah…… sebenarnya tidak terlalu banyak bulu juga.\"\nDipuji selalu menyenangkan. Sebelum pergi, tikus-tikus itu memberimu sebuah Hadiah kecil."
  },
  Event_7257_Name = {Text = "Wabah"},
  Event_7258_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7258_Desc = {
    Text = [[
"Saya setuju! Manusia dan tikus tidak bisa hidup berdampingan!"
Tikus-tikus itu sedikit marah, memperlihatkan taring putih mereka. 
"Lalu apa yang masih kau lakukan di sini? Ambil barangmu dan jangan pernah kembali."]]
  },
  Event_7258_Name = {Text = "Wabah"},
  Event_7259_ChoiceDesc1 = {
    Text = "[Peroleh] Relik \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7259_Desc = {
    Text = [[
Suara gesekan sayap yang aneh berputar di sekelilingmu, dalam keadaan bingung kamu melihat, Rogers berbaring di meja perawatan dengan boneka George, kedua tangannya penuh dengan darah segar. 
 Kamu buka mata, menemukan Clementine sudah tidak ada. 
 Setelah bangun, Clementine sudah pergi.]]
  },
  Event_7259_Name = {
    Text = "Terapi hipnotis"
  },
  Event_7260_ChoiceDesc1 = {
    Text = "[Gunakan] Kunci."
  },
  Event_7260_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7260_Desc = {
    Text = "Sebuah pintu menghalangi jalanmu. Kamu telah mencoba berbagai cara, namun pintu itu tetap tidak bergeming."
  },
  Event_7260_Name = {
    Text = "Pintu berkarat"
  },
  Event_7260_Tips1 = {
    Text = "Perlu mendapatkan \"Kunci berkarat\""
  },
  Event_7261_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7261_Desc = {
    Text = "Kamu menatap ke arah yang kamu anggap sebagai sumber pandangan. Langit-langit Taring tiba-tiba terasa jauh lebih tinggi, bayangan pupil raksasa bertumpuk-tumpuk. Meskipun hanya sebagian yang memandangmu, kamu masih merasakan Tekanan yang luar biasa."
  },
  Event_7261_Name = {
    Text = "Siapa yang melihat"
  },
  Event_7262_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7262_Desc = {
    Text = "Kucing hitam berjalan hati-hati mendekat, lalu mengeluarkan segumpal kegelapan di telapak tanganmu."
  },
  Event_7262_Name = {
    Text = "Malapetaka Kucing Malam"
  },
  Event_7263_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7263_Desc = {
    Text = [[
"Hmm, pilihan yang cerdas. Dengan musuh besar di depan, pasti ingin mengetahui kekuatan dan kelemahan lawan? Namun, mengetahui terlalu banyak rahasia tentang dimensi dapat mengganggu pikiranmu lho?"
"Orang itu, selalu terobsesi dengan makhluk yang melintasi dimensi. Aku juga harus bersusah payah untuk bisa bebas bergerak di antara lubang-lubang dimensi ini. Ah, itu terjadi sekitar tiga ribu tahun yang lalu, ya?"]]
  },
  Event_7263_Name = {
    Text = "Waktu Petunjuk"
  },
  Event_7264_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7264_Desc = {
    Text = "\"Meong, meong meong, meong meong meong…\"\nKamu memeras suaramu, berusaha terdengar lemah dan tidak berbahaya.\n\"Meong! Meong meong! Meong meong meong!\"\nKawanan kucing tampaknya menerima kebaikanmu, membalas dengan teriakan nyaring. Suara kalian saling bersahutan, siang malam tanpa henti, bahkan bulan pun ketakutan hingga bersembunyi di balik awan."
  },
  Event_7264_Name = {
    Text = "Kota Kucing"
  },
  Event_7265_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7265_Desc = {
    Text = [[
Kamu dengan keras mendorong paruh tajam gagak yang berusaha menggigit bulunya. Namun, gagak itu tetap bersikeras memutar tubuhnya, kekuatannya begitu besar hingga membuat tulangmu bergetar. 
 Wajahmu memerah, kamu mengerahkan seluruh tenaga untuk mengendalikan tubuh gagak, menghentikan tindakannya yang gila dan menyakiti diri sendiri. 
 Saat kamu menghela napas lega, leher gagak yang sudah setengah botak tiba-tiba diputar ke belakang dengan keras, tubuhnya menjadi lemas, dan di tanganmu, ia berubah menjadi genangan cairan hitam yang kental.]]
  },
  Event_7265_Name = {
    Text = "Air Mata Magma"
  },
  Event_7266_ChoiceDesc1 = {
    Text = "[Tahan Gagak] Dapatkan 20 Segil Hitam, infeksi [(Skill.Arg2)]"
  },
  Event_7266_ChoiceDesc2 = {
    Text = "[Meninggalkan begitu saja] Pergi"
  },
  Event_7266_Desc = {
    Text = "Gagak kesepian dengan suara serak mencabut bulu hitamnya satu per satu. \n Ia gemetar karena rasa sakit, berteriak nyaring, namun tak mampu menghentikan gerakannya yang semakin cepat. \n \"Ka——ka——\" \n Air mata birunya yang bercampur cairan hitam mengalir dari matanya. Hanya kau yang menyaksikannya, tak seorang pun lainnya."
  },
  Event_7266_Name = {
    Text = "Air Mata Magma"
  },
  Event_7267_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7267_Desc = {
    Text = [[
Gagak mencabik-cabik bulunya sendiri, sama seperti manusia yang menggigiti tubuhnya sendiri. 
 Di dunia penuh ketakutan ini, hal seperti itu sudah sering terjadi, kamu tidak bisa menyelamatkan semua makhluk hidup.]]
  },
  Event_7267_Name = {
    Text = "Air Mata Magma"
  },
  Event_7268_ChoiceDesc1 = {
    Text = "[Peroleh] Relik \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7268_Desc = {
    Text = "\"Aku akan membawa para siswa kembali.\"Gadis itu menarik ujung rok Pembangun, berkata dengan yakin, \"Jaga dirimu baik-baik… jangan sampai jatuh ke laut.\""
  },
  Event_7268_Name = {
    Text = "Berkah Santa Navigasi"
  },
  Event_7269_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7269_Desc = {
    Text = [[
Haha, hitam, warna hitam favoritku. Ketidakteraturan, kekacauan, penderitaan... seharusnya kau sudah tahu, hitam bukanlah pertanda baik. 
Jadi, apa pilihanmu berikutnya?]]
  },
  Event_7269_Name = {
    Text = "Pertunjukan dimulai"
  },
  Event_7270_ChoiceDesc1 = {
    Text = "[Menekan Burung Gagak]Mendapatkan 25 Segil Hitam, terinfeksi[(Skill.Arg2)]，lanjut memilih"
  },
  Event_7270_ChoiceDesc2 = {
    Text = "[Meninggalkan begitu saja] Pergi"
  },
  Event_7270_Desc = {
    Text = "Gagak kesepian dengan suara serak mencabut bulu hitamnya satu per satu. \n Ia gemetar karena rasa sakit, berteriak nyaring, namun tak mampu menghentikan gerakannya yang semakin cepat. \n \"Ka——ka——\" \n Air mata birunya yang bercampur cairan hitam mengalir dari matanya. Hanya kau yang menyaksikannya, tak seorang pun lainnya."
  },
  Event_7270_Name = {
    Text = "Air Mata Magma"
  },
  Event_7271_ChoiceDesc1 = {
    Text = "[Keluar] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7271_Desc = {
    Text = [[
Itu adalah bagian terdalam kapal yang sudah lama tidak dirawat, kekurangan cahaya dan panduan. 
 Gadis itu akan berangkat dengan berkah dari Sang Perawan Suci Laut, itu adalah janji mereka.]]
  },
  Event_7271_Name = {
    Text = "Berkah Santa Navigasi"
  },
  Event_7272_ChoiceDesc1 = {
    Text = "[Pursue the Melody] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7272_ChoiceDesc2 = {
    Text = "[Menyanyikan Lagu] Infeksi [(Skill.Arg1)], ukir Orison acak lagi"
  },
  Event_7272_Desc = {
    Text = [[
Nyanyian yang samar hancur berkeping-keping menjadi beberapa serpihan bintang: 
"Aku mengutuk genangan air kotor di gang malam, di dasar tembok yang runtuh terdapat bunga-bunga busuk, rantai merayap ke otak dan jatuh ke dalam lumpur, sebelum kabut tebal menghapus keberadaanku, senja akan tenggelam ke dalam @3 yang paling dalam."]]
  },
  Event_7272_Name = {
    Text = "Kutukan Materi Putih"
  },
  Event_7273_ChoiceDesc1 = {
    Text = "[Pursue the Melody] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7273_Desc = {
    Text = [[
Nyanyian yang samar terpecah menjadi beberapa bintik cahaya: 
"Aku mengutuk genangan air kotor di gang malam, di dasar dinding yang runtuh terdapat bunga-bunga busuk, rantai merayap ke otak dan jatuh ke dalam lumpur, sebelum kabut tebal menghapus keberadaanku, senja akan tenggelam ke dalam @4 yang paling dalam."]]
  },
  Event_7273_Name = {
    Text = "Kutukan Materi Putih"
  },
  Event_7274_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7274_Desc = {
    Text = "Perak tidak merespons bangunmu, tetapi memancarkan aura yang hangat."
  },
  Event_7274_Name = {
    Text = "Perak Kesepian"
  },
  Event_7275_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7275_Desc = {
    Text = "Kabut hitam yang berliku merambat naik di sepanjang tulang belakang, hingga kamu jatuh ke tanah. Kalimat ini terus kamu ulangi."
  },
  Event_7275_Name = {
    Text = "Jangan lihat langsung"
  },
  Event_7276_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7276_Desc = {
    Text = [[
Ya, cairan vitreous yang perlahan mengalir dari murid adalah bukti bahwa kamu telah terkikis oleh tabu. 
 Kejujuran, pada saat ini, bertentangan dengan kebajikan.]]
  },
  Event_7276_Name = {
    Text = "Jangan lihat langsung"
  },
  Event_7277_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7277_Desc = {
    Text = "Koin kuno itu tampak lembap dan lengket, seolah-olah sisa-sisa kotoran yang dimuntahkan, mengeluarkan aura hitam yang terlihat jelas oleh mata telanjang."
  },
  Event_7277_Name = {
    Text = "Koin Kuno Dua Sisi"
  },
  Event_7278_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7278_Desc = {
    Text = [[
Ujung saraf yang tajam mengirimkan peringatan mematikan, kamu tersentak hebat dan hanya bisa menarik tanganmu dengan kecewa.
Lagi-lagi kau lolos dari...
Kutukan? Atau sebuah kelahiran kembali?]]
  },
  Event_7278_Name = {
    Text = "Koin Kuno Dua Sisi"
  },
  Event_7279_ChoiceDesc1 = {
    Text = "[Lepaskan Kupu-Kupu] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7279_ChoiceDesc2 = {
    Text = "[Menjadi Kupu-Kupu] Mendapatkan Relik Perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7279_ChoiceDesc3 = {
    Text = "[Menelan kembali ke perut] Mendapatkan 25 Segil Hitam"
  },
  Event_7279_Desc = {
    Text = "Malam ini terjadi terlalu banyak hal. \n Serangan di dermaga, kapal hantu, Pelaut, Tulu, Murphy, Ramona... Segala sesuatu berputar dalam Vortex, diaduk menjadi oatmeal di restoran Mythag pada pukul tujuh pagi. \n Ingin bertanya kepada Awakener di depan mata, namun sama sekali tidak tahu bagaimana memulainya, seperti tercekik—atau bisa dibilang, kupu-kupu di perut."
  },
  Event_7279_Name = {
    Text = "Efek kupu-kupu"
  },
  Event_7280_ChoiceDesc1 = {
    Text = "[Mengusir Ilusi] Kehilangan (Arg3) poin hidup."
  },
  Event_7280_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7280_Desc = {
    Text = "Wajah-wajah kabur tiba-tiba muncul, mengelilingi kamu dan merintih putus asa dengan suara yang seolah-olah tidak ada."
  },
  Event_7280_Name = {Text = "Ilusi"},
  Event_7281_ChoiceDesc1 = {
    Text = "[Doa] mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7281_ChoiceDesc2 = {
    Text = "[Tenggelam ke Lautan] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_7281_ChoiceDesc3 = {
    Text = "[Muncul ke permukaan] Mendapatkan 25 Segil Hitam"
  },
  Event_7281_Desc = {
    Text = [[
"Dewa yang lembut, Dewa yang luhur. 
Mohon redakan badai yang ganas, mohon hentikan aliran air yang deras. 
Jadikan lautan sebagai rumah kami yang dalam, biarkan ia menutupi negara kami dengan tabir abadi..."
Bisikan para penganut akhirnya membentuk kata-kata yang bisa kau pahami, namun yang menyertainya adalah rasa sesak yang sulit dihilangkan.]]
  },
  Event_7281_Name = {Text = "Doa Mimpi"},
  Event_7282_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7282_Desc = {
    Text = [[
Kamu melemparkan potongan daging yang tersisa di tanganmu ke kawanan kucing. 
 Kucing-kucing itu meluncur maju seperti gelombang hitam. Mereka menggigit potongan daging dengan gila, lalu segera menyebar. 
 Sayangnya, ini adalah daging yang sudah kadaluarsa. Mungkin bisa mengisi perut yang keroncongan, tetapi tidak begitu memuaskan.]]
  },
  Event_7282_Name = {
    Text = "Kota Kucing"
  },
  Event_7283_ChoiceDesc1 = {
    Text = "[Dimasukkan ke dalam kantong]"
  },
  Event_7283_Desc = {
    Text = "Sebuah zat perak berwarna mendekati merkuri, disaring dari lendir pelarut, mengandung kekuatan roh yang besar, terutama digunakan untuk menghubungkan lebih banyak Pembangun dalam ritual."
  },
  Event_7283_Name = {Text = "Perak"},
  Event_7284_ChoiceDesc1 = {
    Text = "[Keluar] Pilih 1 Pembangun untuk dibangunkan dan kurangi Lelah Aritmetika kartu bangun sebesar 2 poin. Infeksi [(Skill.Arg1)]"
  },
  Event_7284_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7284_Desc = {
    Text = "Mungkin saat ini masih belum bisa tersampaikan, tetapi cepat atau lambat mereka pasti akan mendengar seruan kalian."
  },
  Event_7284_Name = {
    Text = "Suara Petunjuk"
  },
  Event_7285_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7285_Desc = {
    Text = "Eksperimen yang berkeliaran telah membuatmu sangat lelah, sedikit waktu untuk bernapas terasa seperti embun di tengah gurun yang tandus."
  },
  Event_7285_Name = {
    Text = "Pintu Tanpa Henti"
  },
  Event_7286_ChoiceDesc1 = {
    Text = "[Pergi] Bangun 1 Pembangun secara acak"
  },
  Event_7286_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7286_Desc = {
    Text = "Suara itu pasti akan membimbing kalian menuju akhir perjalanan, jawaban dari penyelidikan ini."
  },
  Event_7286_Name = {
    Text = "Suara Petunjuk"
  },
  Event_7287_ChoiceDesc1 = {
    Text = "[Amati dengan saksama]"
  },
  Event_7287_Desc = {
    Text = "Melalui bola kristal, kamu dapat mengamati tempat yang jauh."
  },
  Event_7287_Name = {
    Text = "Bola Kristal"
  },
  Event_7288_ChoiceDesc1 = {
    Text = "[Mengusir Gagak] Mendapatkan Arg1 Segil hitam, terinfeksi [(Skill.Arg2)], lanjutkan memilih"
  },
  Event_7288_ChoiceDesc2 = {
    Text = "[Mengabaikan] Pergi"
  },
  Event_7288_Desc = {
    Text = "Gagak bertengger di atas lemari pakaian, paruhnya yang runcing menggoreskan pola aneh di pintu kayu."
  },
  Event_7288_Name = {
    Text = "Lentera Gagak Hitam"
  },
  Event_7289_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7289_Desc = {
    Text = "Kamu menerima permintaan kontak dari sekolah, suara yang familiar membuatmu merasa tenang. Kamu mengumpulkan Roh dan melanjutkan langkah."
  },
  Event_7289_Name = {
    Text = "Persimpangan"
  },
  Event_7290_ChoiceDesc1 = {
    Text = "[Tetap di sini] untuk mendapatkan Relik perak [(RelicConfig.Arg1)]"
  },
  Event_7290_ChoiceDesc2 = {
    Text = "[Mencari jalan keluar] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7290_Desc = {
    Text = [[
Kamu melangkah ke dalam keheningan pucat, pintu-pintu yang saling tumpang tindih berputar tanpa henti, menarik tubuhmu ke dalam pusaran. 
 Kamu berjuang dalam kebingungan di dalam pintu yang terbalik, samar-samar mengenali arah untuk melarikan diri, namun tak terhindarkan jatuh ke pintu lainnya berulang kali. 
 Kali ini, kamu kembali berhenti di depan sebuah pintu, ketidakpastian yang bergolak di balik pintu itu memancarkan daya tarik mematikan, sementara akal sehatmu tegang. 
 Ya, itu memang mematikan.]]
  },
  Event_7290_Name = {
    Text = "Di luar pintu ganda"
  },
  Event_7291_ChoiceDesc1 = {
    Text = "[Masuk ke dalam kegembiraan ekstrem] Hapus 1 Kartu Perintah, dan pulihkan Arg1 poin Hidup."
  },
  Event_7291_ChoiceDesc2 = {
    Text = "[Berhenti sejenak] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7291_Desc = {
    Text = [[
Seolah-olah tengkorakmu dibuka dengan mudah, kepalamu berputar seperti mual, tangan tak terlihat mengaduk dan mengacaukan otakmu, zat yang sudah cenderung cair itu hancur menjadi genangan. 
 Seperti sisa-sisa makanan dalam keadaan bubur yang belum dicerna, sudah terbebas dari gaya gravitasi, mengalir masuk ke korteks otakmu yang kosong dan miskin. 
 Ia menguleni, mencampur, dan meremas, menaburkan kesukacitaan yang dicincang, mengaduk sisa-sisa matahari terbenam menjadi daging.]]
  },
  Event_7291_Name = {
    Text = "Mengaduk otak"
  },
  Event_7292_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7292_Desc = {
    Text = "Dibandingkan dengan kemunculan tiba-tiba Anjing neraka, salju yang sering turun tidak layak mendapatkan perhatianmu. Kamu mengabaikan serpihan salju yang perlahan jatuh dan menerobos ke dalam kegelapan malam."
  },
  Event_7292_Name = {Text = "Salju"},
  Event_7293_ChoiceDesc1 = {
    Text = "[Menghubungkan] Pulihkan Arg2 poin Hidup."
  },
  Event_7293_Desc = {
    Text = "Kamu menjelajahi dalam kabut, tiba-tiba, lencana sekolah di dada memancarkan cahaya perak yang lemah. Siapa yang memanggil dari sisi lain komunikator?"
  },
  Event_7293_Name = {
    Text = "Persimpangan"
  },
  Event_7294_ChoiceDesc1 = {
    Text = "[Merasa takut] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7294_ChoiceDesc2 = {
    Text = "[Keinginan Teguh] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7294_Desc = {
    Text = "Suara ratapan aneh bergema tanpa henti, tetapi segala sesuatu di Londinium tidak memberikan reaksi, seolah-olah telah mati, atau tertidur. \n Kamu berjalan tanpa sadar di bawah jembatan rel, mengingat nasihat Alistair. \n Dia bangkit dengan sopan dan mendekat, seolah-olah sedang menceritakan sesuatu padamu, tetapi kata-katanya terputus-putus dan tidak jelas. \n Kamu menatap ke atas, tetesan cairan hitam yang kental mengalir dari mulutnya, menyumbat tenggorokannya, menghalangi kalimat-kalimatnya——"
  },
  Event_7294_Name = {
    Text = "Kekacauan Meratap"
  },
  Event_7295_ChoiceDesc1 = {
    Text = "[Pergi] Mendapatkan 1 dari 3 pilihan Orison"
  },
  Event_7295_Desc = {
    Text = [[
"Tentu saja, itu sudah pasti. Jika tidak keberatan, aku akan membantu kalian sepenuhnya."
Dia memberikan kalian sebuah cermin genggam kuno. 
"Ksatria sudah naik ke papan catur, dan Raja juga tidak akan menunggu lama di akhir permainan. Kalian mungkin akan segera bertemu dengannya. Sungguh sesuatu yang dinantikan."]]
  },
  Event_7295_Name = {
    Text = "Teman Perjalanan Aneh IV"
  },
  Event_7296_ChoiceDesc1 = {
    Text = "[Menghancurkan kertas surat] Hapus 2 Kartu"
  },
  Event_7296_ChoiceDesc2 = {
    Text = "[Lanjutkan Membaca] Mendapatkan Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7296_ChoiceDesc3 = {
    Text = "[Pergi]mendapatkan Arg1 Segil hitam"
  },
  Event_7296_Desc = {
    Text = [[
Di depanmu, kawanan kupu-kupu hitam memancar keluar, terus-menerus melimpah, mengepakkan sayap, dan jatuh berulang kali di atas meja tulis. 
 Kertas surat kosong yang terbentang penuh dengan noda tinta, kupu-kupu yang terjatuh, terkulai lemah di atas permukaan kertas. 
 Cairan hitam yang menempel di sayapnya membentuk tulisan terlarang. 
 Kamu menarik kertas surat ini dari mesin tik.]]
  },
  Event_7296_Name = {
    Text = "Bagian Kupu-kupu"
  },
  Event_7297_ChoiceDesc1 = {
    Text = "[Menghadapi Kupu-Kupu] Hapus 1 Kartu Perintah, dapatkan Arg1 Segil Hitam"
  },
  Event_7297_ChoiceDesc2 = {
    Text = "[Tidak Lagi Berlama-lama]"
  },
  Event_7297_Desc = {
    Text = [[
Baru-baru ini, ada sebuah kalimat yang populer di Londinium: "Kibasan sayap kupu-kupu di Hutan Akut mungkin dapat menyebabkan badai di Kerajaan Leo."
Saat melihat kupu-kupu bermunculan, kamu teringat akan kalimat itu.
Kupu-kupu ini mungkin cukup untuk memicu sebuah bencana yang menenggelamkan Planet.]]
  },
  Event_7297_Name = {
    Text = "Badai Gnosis"
  },
  Event_7298_ChoiceDesc1 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_7298_Desc = {
    Text = [[
Kamu meletakkan satu jari di sudut bibirmu, memberi isyarat bahwa kamu akan tetap bungkam tentang hal ini. 
 Fatamorgana kucing hitam berkilauan lewat dengan cepat, meninggalkan hadiah hitam mengilap di samping kakimu.]]
  },
  Event_7298_Name = {
    Text = "Malapetaka Kucing Malam"
  },
  Event_7299_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7299_Desc = {
    Text = [[
Dia meluncur ke dalam tas tangan mu seperti sehelai sutra, dengan sedikit tambahan berat, seakan-akan kamu mendengar ucapan terima kasih yang pelan. 
 Setelah itu, tak ada suara lagi.]]
  },
  Event_7299_Name = {
    Text = "Roh Kekacauan"
  },
  Event_7300_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7300_Desc = {
    Text = [[
Tangisan Roh Kekacauan semakin tajam, hingga akhirnya berubah menjadi teriakan menusuk telinga yang menggema di sekitar. 
 Dia membawa persembahanmu dan penderitaan yang tak terhindarkan, lalu tenggelam kembali ke dalam lumpur.]]
  },
  Event_7300_Name = {
    Text = "Roh Kekacauan"
  },
  Event_7301_ChoiceDesc1 = {
    Text = "[Diisi sesuai kenyataan]"
  },
  Event_7301_ChoiceDesc2 = {
    Text = "[Tulisan Acak]"
  },
  Event_7301_Desc = {
    Text = [[
Jalan-jalan di Distrik Timur begitu rumit, tak lama kemudian kamu kehilangan jejak anak-anak.
Ketika kamu sedang kebingungan, seorang wanita misterius tiba-tiba berbicara padamu.
"Aku tahu ke mana anak-anak itu pergi, tapi, sebelum aku memberitahumu, bisakah kamu membantuku dengan satu hal kecil?"
Dia mengeluarkan selembar kertas dan tersenyum ramah padamu.
"Namaku Clementine, seorang Dokter, dan aku sedang melakukan Penyelidikan psikologis terkait penduduk Londinium. Jika kamu bisa membantu mengisi survei ini untukku.
Isilah dengan jujur, dan aku akan dengan senang hati memberikan beberapa bantuan untukmu dan teman-temanmu."]]
  },
  Event_7301_Name = {
    Text = "Evaluasi psikologis"
  },
  Event_7302_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7302_Desc = {
    Text = [[
"Itu juga adalah pilihanku."Bayangan orang yang memegang permen berkata, "Tapi dia akan menjadi taruhannya, dan kamu harus memilih. 
Tidak ada akhir yang sempurna di dunia ini."
Kesedihan yang mendalam menenggelamkanmu. Bayangan itu menghilang, kamu memegang dada, tidak tahu apakah yang tadi adalah proyeksi, atau Fatamorgana yang dihasilkan oleh tekanan berat pada Roh.]]
  },
  Event_7302_Name = {
    Text = "Jalan yang bercabang"
  },
  Event_7303_ChoiceDesc1 = {
    Text = "[Kapak Emas]"
  },
  Event_7303_ChoiceDesc2 = {
    Text = "[Silver Axe]"
  },
  Event_7303_ChoiceDesc3 = {
    Text = "[Saya tidak menjatuhkan apa pun]"
  },
  Event_7303_Desc = {
    Text = [[
"Pionir yang melintasi dimensi."
Terdengar suara tua di telinga, seolah berasal dari zaman prasejarah, seolah menembus ribuan zaman. 
Dalam ketegangan yang luar biasa, kamu mendengar suara itu mengajukan pertanyaan yang terdengar cukup familiar. 
"Apa yang jatuh, kapak emas ini, atau kapak perak ini?"]]
  },
  Event_7303_Name = {
    Text = "Suara di Luar Dunia"
  },
  Event_7304_ChoiceDesc1 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7304_Desc = {
    Text = [[
"Ah, ini..." Dia menarik kembali kuesioner itu, memperlihatkan ekspresi sedikit putus asa, "Yah, lagipula kamu memang sedang terburu-buru. Anak-anak pergi ke sana, seharusnya mereka belum pergi jauh."
Kamu buru-buru berbalik, hampir tak mendengar bisikan dari belakang. 
"Lagipula, kita pasti akan bertemu lagi."]]
  },
  Event_7304_Name = {
    Text = "Evaluasi psikologis"
  },
  Event_7305_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7305_Desc = {
    Text = "\"Siapa kamu?\"\n\"Aku adalah bayangan dari Kunci Perak yang dibunuh dengan kejam, oleh seekor ular albino yang licik.\"\n\"Ular albino? Apa itu?\"\n\"Sebuah kesalahan. Makhluk yang lahir dari persilangan manusia dan ular… sebuah penghinaan terhadap alam.\"\nKamu ingin melanjutkan pertanyaanmu, namun bayangan itu tiba-tiba menghilang, meninggalkan jejak debu emas di tanah."
  },
  Event_7305_Name = {
    Text = "Pengguna Kunci Perak"
  },
  Event_7306_ChoiceDesc1 = {
    Text = "[Infeksi \"(Skill.Arg1)\", mendapatkan Relik emas \"(RelicConfig.Arg2)\"]"
  },
  Event_7306_ChoiceDesc2 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_7306_Desc = {
    Text = "Acara 355 (dalam pengembangan), bukan efek akhir"
  },
  Event_7306_Name = {
    Text = "Acara 355 (dalam pengembangan)"
  },
  Event_7307_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7307_Desc = {
    Text = [[
Tenggelam ke dalam perut, berdansa bersama kupu-kupu.
Serbuk sisik dari pikiranmu bercampur dengan kupu-kupu, jatuh seperti hujan salju halus di dalam perut.
Kamu perlahan mulai memahami segalanya, dan ketika kesempatan berikutnya datang, kamu pasti akan mengatakannya.]]
  },
  Event_7307_Name = {
    Text = "Efek kupu-kupu"
  },
  Event_7308_ChoiceDesc1 = {
    Text = "[Bantah mereka] Infeksi \"(Skill.Arg1)\", 1 kartu acak mendapatkan orison: \"(EnchantConfig.Arg2)\""
  },
  Event_7308_ChoiceDesc2 = {
    Text = "[Ikuti mereka] Infeksi \"(Skill.Arg1)\", 1 kartu acak mendapatkan Orison: \"(EnchantConfig.Arg2)\""
  },
  Event_7308_ChoiceDesc3 = {
    Text = "[Menyampaikan pandangan baru] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7308_Desc = {
    Text = "\"Harap jaga jarak dengan kami.\"\nSekelompok tikus mengelilingimu, menjaga jarak setidaknya lima kaki dari dirimu. \n\"Kami berusaha berkembang biak, kami tumbuh subur, dan kami tidak pernah pilih-pilih makanan — sehingga kami membawa penyakit, kecemasan, dan penderitaan kepada manusia.\"\n\"Kami dan manusia seharusnya tidak terlalu dekat, ini bukan tempatmu.\"\nUntuk membuat para tikus merasa tenang, kamu memutuskan untuk —"
  },
  Event_7308_Name = {Text = "Wabah"},
  Event_7309_ChoiceDesc1 = {
    Text = "[Membuka gerbang besi] Infeksi \"(Skill.Arg1)\", memperoleh Relik emas \"(RelicConfig.Arg2)\""
  },
  Event_7309_ChoiceDesc2 = {
    Text = "[Tidak peduli] Mendapatkan 50 Segil Hitam"
  },
  Event_7309_Desc = {
    Text = [[
Ini adalah jembatan lengkung tipe bawah yang khas, tangga di samping rel kereta samar-samar menuju sebuah pintu besi. Dari belakang pintu terdengar suara ketuk ketuk yang teratur dan aneh. 
 Kamu berhenti untuk mengamati pintu, terlihat ada sebuah gembok berat yang tergantung di atasnya, tetapi tidak terkunci.]]
  },
  Event_7309_Name = {
    Text = "Di balik pintu besi"
  },
  Event_7310_ChoiceDesc1 = {
    Text = "[Pergi] Infeksi [(Skill.Arg1)], dapatkan 50 Segil Hitam"
  },
  Event_7310_Desc = {
    Text = [[
Menghadapi godaan, kamu tetap tidak tergoyahkan.
Pemilik suara merasa cukup menyesal. Permukaan air bergelombang malas-malasan membentuk beberapa riak, dan tak ada lagi gelombang yang muncul.]]
  },
  Event_7310_Name = {
    Text = "Suara di Luar Dunia"
  },
  Event_7311_ChoiceDesc1 = {
    Text = "[Infeksi \"(Skill.Arg1)\", mendapatkan Relik emas \"(RelicConfig.Arg2)\"]"
  },
  Event_7311_ChoiceDesc2 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_7311_Desc = {
    Text = "Acara 353 (dalam pengembangan), bukan efek akhir"
  },
  Event_7311_Name = {
    Text = "Acara 353 (dalam pengembangan)"
  },
  Event_7312_ChoiceDesc1 = {
    Text = "[Pergi] Infeksi [(Skill.Arg1)], dapatkan 50 Segil Hitam"
  },
  Event_7312_Desc = {
    Text = [[
"Apakah kalian manusia tidak punya jawaban lain?"
Pemilik suara mengeluarkan geraman tak sabar, membuat seluruh ruang bergetar. 
"Rakus dan bodoh... inilah alasan aku muak dengan kalian."]]
  },
  Event_7312_Name = {
    Text = "Suara di Luar Dunia"
  },
  Event_7313_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7313_Desc = {
    Text = "Menerima pengaturan Domain, kehilangan dalam mendapatkan, dan menikmati pelukan yang terkutuk."
  },
  Event_7313_Name = {
    Text = "Aliran Delusi"
  },
  Event_7314_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7314_Desc = {
    Text = [[
Mata berkedip perlahan, tidak tahu apakah mengerti pertanyaanmu. 
 Setetes air mata berwarna emas dan merah jatuh dari sudut matanya, seperti bintang kecil yang memancarkan cahaya hangat seperti matahari. Ia jatuh, jatuh, membawa kesedihan, membawa rasa iba, hancur menjadi sebutir debu di atas batu bata. 
 Kamu tersadar tiba-tiba, dan mata itu sudah menghilang.]]
  },
  Event_7314_Name = {
    Text = "Pandangan Buta"
  },
  Event_7315_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7315_Desc = {
    Text = "Beberapa anak berpakaian sederhana, bahkan agak kotor, berlarian di jalan, dikejar oleh seorang dewasa yang mengenakan seragam polisi. Salah satu anak itu memakai tudung cokelat yang tampak cukup familiar bagi Anda."
  },
  Event_7315_Name = {
    Text = "Kenangan Kami"
  },
  Event_7316_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7316_Desc = {
    Text = "\"Jangan bernyanyi lagi—\"\nKamu memperingatkan penyanyi yang tidak bisa menyanyi dengan baik, jangan sampai mengganggu telingamu lagi."
  },
  Event_7316_Name = {
    Text = "Penjahat di Jalan Sempit"
  },
  Event_7317_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7317_Desc = {
    Text = "\"Berhenti langkahmu!!! Monster pelarutan yang merangkak lebih memahami anggota tubuhnya sendiri daripada kamu!\"\nLepaskan penonton…\nKau berdoa seperti itu dalam hati."
  },
  Event_7317_Name = {
    Text = "Penjahat di Jalan Sempit"
  },
  Event_7318_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7318_Desc = {
    Text = [[
Lumpur hitam menetes di wajahmu, menyebabkan rasa gatal yang menjalar. 
Kamu tidak tahan dan mencoba menepis kupu-kupu itu dengan tanganmu. 
Kupu-kupu itu menghindari gerakan kasarmu, lenyap tanpa suara di ujung sana.]]
  },
  Event_7318_Name = {
    Text = "Sesuatu yang tidak seharusnya ada"
  },
  Event_7319_ChoiceDesc1 = {
    Text = "[Puji itu] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7319_Desc = {
    Text = "Jenkin berkata: Segera bangun, Johnny! Menulis puisi tidak akan membayar utangmu, juga tidak akan menyelesaikan masalah kebocoran lantai di rumahmu. \n Kamu berkata: Sangat disayangkan, sel-sel yang mengejar kebenaran itu akan layu dengan kecepatan 100 ribu per hari, dan segera kamu akan menjadi sebuah batang otak yang sejati. \n Otak dengan acuh tak acuh mengangkat bahu—jika ia memilikinya. \n Otak berkata: Aku berpikir, maka aku ada. Ketika kamu bisa mencapai kedalaman pemikiran sepertiku, kamu tidak akan lagi peduli tentang batang otak."
  },
  Event_7319_Name = {
    Text = "Otak filsafat"
  },
  Event_7320_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7320_Desc = {
    Text = "Piano itu dengan lembut mengeluarkan suara seperti sebuah desahan, seakan-akan rasa lega, namun juga seperti kerinduan, sangat mirip dengan senyuman seseorang di akhir sebuah lagu. \n\"Asalkan anak-anak… asalkan…\"\nSebelum kamu sempat mendengarnya dengan jelas, fatamorgana piano itu telah lenyap dibawa angin."
  },
  Event_7320_Name = {
    Text = "Melodi Masa Kecil"
  },
  Event_7321_ChoiceDesc1 = {
    Text = "[Keluar] Mendapatkan 1 dari 3 Relik perak, terinfeksi [(Skill.Arg1)]"
  },
  Event_7321_Desc = {
    Text = "Kamu mengambil rekam medis tebal itu dan membukanya, lalu menemukan dua huruf \"G·R\" tertulis di halaman depan.\n\"Ah, ini bukankah rekam medismu sendiri?\"Clementine tampaknya tidak terlalu peduli, \"Namun, mempelajari psikologi orang lain juga bisa meningkatkan pemahaman tentang diri sendiri.\"\nSebelum kamu sempat bertanya, sosoknya sudah sepenuhnya menghilang."
  },
  Event_7321_Name = {
    Text = "rekam medis"
  },
  Event_7322_ChoiceDesc1 = {
    Text = "[Keluar] Pilih 1 Pembangun untuk dibangunkan, infeksi [(Skill.Arg1)]"
  },
  Event_7322_Desc = {
    Text = [[
Kamu menerima buku catatan medis yang tipis dan membukanya, hanya untuk menemukan satu lembar kertas di dalamnya, dengan hanya satu kalimat tertulis di atasnya. 
"Di dalam kekacauan purba, mata pucat tanpa pupil terus mengamati secara abadi."
Kamu ingin bertanya kepada Clementine, tetapi menyadari bahwa dia telah menghilang tanpa jejak.]]
  },
  Event_7322_Name = {
    Text = "rekam medis"
  },
  Event_7323_ChoiceDesc1 = {
    Text = "[Menghubungkan] Mengembalikan semua Hidup."
  },
  Event_7323_ChoiceDesc2 = {
    Text = "[Meditasi] Pilih 1 Pembangun untuk Bangun."
  },
  Event_7323_Desc = {
    Text = "Kamu menjelajahi dalam kabut, tiba-tiba, lencana sekolah di dada memancarkan cahaya perak yang lemah. Siapa yang memanggil dari sisi lain komunikator?"
  },
  Event_7323_Name = {
    Text = "Persimpangan"
  },
  Event_7324_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7324_Desc = {
    Text = "Bukti material yang penting sebaiknya disimpan dengan serius dan diserahkan kepada departemen sejarah untuk penelitian serta analisis."
  },
  Event_7324_Name = {
    Text = "Kode Rahasia·Atas"
  },
  Event_7325_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7325_Desc = {
    Text = "Matahari bersinar terang dari langit tinggi, menembus kabut, dan membangun jiwa yang lelah."
  },
  Event_7325_Name = {
    Text = "Sudut elevasi"
  },
  Event_7326_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7326_Desc = {
    Text = "Kamu merasa puas, tatapan mereka berkilauan di langit malam di atasmu, memfokuskan pandangan pada-Nya."
  },
  Event_7326_Name = {Text = "Mata Kubah"},
  Event_7327_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7327_Desc = {
    Text = "Kamu tidak bisa menghindari tatapan yang membuatmu merasa seperti duduk di atas jarum, dan tentu saja, sama sekali tidak dapat menolak pemberian dari para dewa."
  },
  Event_7327_Name = {Text = "Mata Kubah"},
  Event_7328_ChoiceDesc1 = {
    Text = "[Peroleh] Relik \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7328_Desc = {
    Text = [[
"Siapa kamu sebenarnya?" tanyamu dengan nada terkejut. 
"Tidak perlu memikirkan itu. Musuh dari musuh kita adalah teman, bukan?" pria itu tersenyum. 
"Hadiah sudah ditinggalkan di kursi. Semoga kalian beruntung."]]
  },
  Event_7328_Name = {
    Text = "Teman Perjalanan Aneh IV"
  },
  Event_7329_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7329_Desc = {
    Text = "Ramona mendekat, berharap mendengar lebih banyak tentang \"jas putih\". \"Ada yang menguping!\" suara gramofon tiba-tiba membesar, \"menguping, menguping, menguping!\""
  },
  Event_7329_Name = {
    Text = "Telinga orang lain"
  },
  Event_7330_ChoiceDesc1 = {
    Text = "[Leave] Semua Pembangun pulih Arg1 Aliemus"
  },
  Event_7330_Desc = {
    Text = [[
Kamu menggenggam tangan kecil anak laki-laki yang lembut, melewati satu pintu demi pintu lainnya, hingga akhirnya tiba di depan panggung kecil yang kusam. 
Anak laki-laki itu sedikit mencubit tanganmu sebagai bentuk rasa terima kasih.
"Terima kasih, sampai jumpa lagi."]]
  },
  Event_7330_Name = {
    Text = "Upacara Penutupan II"
  },
  Event_7331_ChoiceDesc1 = {
    Text = "[Melanjutkan jatuh] Mendapatkan Relik perak [(RelicConfig.Arg1)], apakah akan melanjutkan jatuh?"
  },
  Event_7331_ChoiceDesc2 = {
    Text = "[Meninggalkan pertarungan] Mendapatkan 25 Segil Hitam"
  },
  Event_7331_Desc = {
    Text = [[
"Kamu"mengundangmu. 
Di kedalaman spiral, "kamu"dari masa lalu dan masa depan memberikanmu "hadiah"dari Dimensi yang berbeda.]]
  },
  Event_7331_Name = {
    Text = "Jurang Spiral"
  },
  Event_7332_ChoiceDesc1 = {
    Text = "[Menutup Mulut Rapat-rapat] Mendapatkan 25 Segil Hitam"
  },
  Event_7332_ChoiceDesc2 = {
    Text = "[Menyentuh] 50% kesempatan mendapatkan 50 Segil Hitam, 50% kesempatan tidak mendapatkan apa-apa"
  },
  Event_7332_Desc = {
    Text = "\"Apa yang ingin kukatakan hanya satu pepatah—tidak ada yang bisa membunuh seekor kucing!\"\n\"Kucing hitam sial itu seharusnya dibedah, dan dibuang begitu saja, tetapi ia menggali makam keluargaku, daging manusia yang tersisa ditelannya habis, sementara tulang dan anggota tubuh tersebar di mana-mana.\"\n\"Di bawah tatapan sinis yang dingin dan gelap, nanah kuning kehitaman muncul dengan bau busuk, aku melarikan diri dengan terhuyung-huyung, tersiksa oleh mimpi buruk.\"\n\"Tunggu… kalian mau apa, aku tidak gila! Aku tidak! Kalian pasti menyembunyikan sesuatu! Ini nyata—\"\nIni memang nyata, saat melihat bayangan orang gila menghilang, kau bertemu tatapan kucing hitam yang duduk diam di kaki."
  },
  Event_7332_Name = {
    Text = "Malapetaka Kucing Malam"
  },
  Event_7333_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7333_Desc = {
    Text = [[
Kamu bertanya kepadanya tentang arah menuju Museum lilin. 
 Aneh sekali, termasuk yang ini, kalian sudah bertemu lima kali malam ini. Kamu sudah menyalakan api untuknya lima kali, dan bertanya tentang jalan lima kali. 
 Tapi kamu masih tidak ingat posisi museum lilin, sama seperti kamu dan dia yang terus-menerus bertemu.]]
  },
  Event_7333_Name = {
    Text = "Bayangan di bawah lampu jalan"
  },
  Event_7334_ChoiceDesc1 = {
    Text = "[Mengusir Gagak]mendapatkan 25 Segil hitam, terinfeksi[(Skill.Arg2)], terus memilih"
  },
  Event_7334_ChoiceDesc2 = {
    Text = "[Mengejar anak lagi] Pergi"
  },
  Event_7334_Desc = {
    Text = "Burung gagak ketiga pergi, terbang ke tempat yang tak terlihat oleh mata, menuju kegelapan abadi."
  },
  Event_7334_Name = {
    Text = "Pandangan Burung Gagak Hitam"
  },
  Event_7335_ChoiceDesc1 = {
    Text = "[Pergi] mendapatkan 75 Segil Hitam, terinfeksi [(Skill.Arg2)]"
  },
  Event_7335_Desc = {
    Text = [[
Bulu di sekitar tentakel terasa lembut dan halus, masih menyisakan kehangatan dari hidup Kum. 
 Itu adalah sinar senja terakhir sebelum matahari terbenam, kehangatan yang lenyap dalam sekejap.]]
  },
  Event_7335_Name = {Text = "Sisa Panas"},
  Event_7336_ChoiceDesc1 = {Text = "[Kejar]"},
  Event_7336_Desc = {
    Text = "Kamu dengan teliti memeriksa dinding, akhirnya menemukan sebuah saluran air tersembunyi di balik semak-semak. Kamu merangkak melewati saluran air itu, tetapi monster sudah melarikan diri jauh."
  },
  Event_7336_Name = {
    Text = "Jalan buntu"
  },
  Event_7337_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7337_Desc = {
    Text = "Di antara burung-burung, ada aturan mereka sendiri. Mereka tidak bertindak sesuai kehendakmu, dan kamu tidak berhak mengganggu hukum alam."
  },
  Event_7337_Name = {
    Text = "Gagak yang Sendirian"
  },
  Event_7338_ChoiceDesc1 = {
    Text = "[Melihat Bayangan] Mendapatkan 25 Segil Hitam"
  },
  Event_7338_ChoiceDesc2 = {
    Text = "[Apakah kamu baik-baik saja?] Memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7338_Desc = {
    Text = "\"Kamu, kamu tahu tidak... pemilik toko baru di sebelah, selalu menutup pintu dan tidak pernah keluar... Suatu hari aku mengajaknya minum bir, setelah busa itu hilang sepenuhnya, tiba-tiba aku menyadari... dia di dalam gelas, dia tidak punya bayangan!\""
  },
  Event_7338_Name = {
    Text = "Fragmen Memori·Bir"
  },
  Event_7339_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7339_Desc = {
    Text = [[
"Aku sangat ingin bernyanyi bersamamu lagi..."
 Ratapan penuh kegilaan Sarah tiba-tiba terhenti, wajahnya yang berubah bentuk menunjukkan sedikit kebingungan.]]
  },
  Event_7339_Name = {Text = "\"Kak Sasa\""},
  Event_7340_ChoiceDesc1 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_7340_Desc = {
    Text = "\"Senang sekali! Senang sekali!\"Suara yang ramai, tajam, dan penuh dengan kepolosan anak-anak terdengar di telingamu, \"Untukmu, untukmu!\""
  },
  Event_7340_Name = {Text = "Elfo Malam"},
  Event_7341_ChoiceDesc1 = {
    Text = "[Buku rekam medis yang tebal]"
  },
  Event_7341_ChoiceDesc2 = {
    Text = "[Buku rekam medis yang tipis]"
  },
  Event_7341_Desc = {
    Text = [[
Sebuah suara yang cukup familiar memanggilmu, kamu menyipitkan mata, namun tetap tidak bisa melihat jelas sosoknya. 
"Aku tahu kamu sedang terburu-buru,"kata Dokter Clementine dengan nada ringan, "Aku janji tidak akan memakan waktu lama."
Dua tangan muncul menembus kabut di pikiranmu, masing-masing memegang sebuah catatan medis, satu tebal dan aus, yang lain tipis dan baru. 
"Berdasarkan hasil kuesioner kamu, aku sudah membuatkanmu sebuah catatan medis tanpa izin. Namun, aku lupa mana yang milikmu, bagaimana kalau kamu pilih sendiri?"
Entah kenapa, catatan medis yang tipis itu membawa aroma yang familiar, beresonansi samar-samar dengan hubungan roh antara kamu dan Pembangun.]]
  },
  Event_7341_Name = {
    Text = "rekam medis"
  },
  Event_7342_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7342_Desc = {
    Text = "Sebuah dinding biasa, kamu tak bisa menahan diri untuk mengetuknya, namun merasa bahwa itu mungkin bukan dinding yang solid."
  },
  Event_7342_Name = {
    Text = "Dinding yang aneh"
  },
  Event_7343_ChoiceDesc1 = {
    Text = "[Saya tidak berada di permukaan air] 1 Relik perak acak ditingkatkan menjadi Relik emas [(RelicConfig.Arg1)]"
  },
  Event_7343_ChoiceDesc2 = {
    Text = "[Melihat ke bawah] Memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7343_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7343_Desc = {
    Text = "\"Haha, Penjaga, apakah kamu masih ingat pesan dari Kerang? Dengarkan baik-baik, jangan·melihat·bayangan·dirimu·sendiri·pada·tengah·hari.\""
  },
  Event_7343_Name = {
    Text = "Refleksi Tidak Berwujud"
  },
  Event_7343_Tips1 = {
    Text = "Belum memiliki Relik perak"
  },
  Event_7344_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7344_Desc = {
    Text = "Fatamorgana dari masa depan yang jauh, menghilang di celah pegunungan Elworth."
  },
  Event_7344_Name = {
    Text = "Fatamorgana Vulkanik"
  },
  Event_7345_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7345_Desc = {
    Text = "Kupu-kupu hancur di telapak tanganmu, seperti langit-langit kaca yang tiba-tiba pecah. Serpihan retakan jatuh ke arah gravitasi bumi, jatuh, jatuh, jatuh——"
  },
  Event_7345_Name = {
    Text = "Fatamorgana Jembatan Baja"
  },
  Event_7346_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7346_Desc = {
    Text = "Tunggu sampai mereka muncul dari bayangan."
  },
  Event_7346_Name = {
    Text = "Lentera Gagak Hitam"
  },
  Event_7347_ChoiceDesc1 = {
    Text = "[Buka saklar] Perluas pandangan saat ini."
  },
  Event_7347_Desc = {
    Text = [[
Perangkat penerangan peninggalan orang-orang terdahulu, mampu mengusir kabut hitam di sekitarnya. 
Kabut di sekelilingnya berfluktuasi secara teratur, seakan-akan terganggu oleh napasnya.]]
  },
  Event_7347_Name = {
    Text = "proyektor pencari"
  },
  Event_7348_ChoiceDesc1 = {
    Text = "[Pilih salah satu] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7348_ChoiceDesc2 = {
    Text = "[Menelan Keraguan] Terinfeksi [(Skill.Arg1)], Orison ulang, maksimal 2 kali"
  },
  Event_7348_Desc = {
    Text = [[
Hingga sekarang, kamu masih merenungkan masa lalu yang diceritakan oleh Murphy. 
 Kenangan membuatmu merasakan empati, terikat erat dan menekan otakmu, bahkan penjelasan terakhir Goliath kepada Murphy tidak bisa memberimu kenyamanan. 
 ... Tunggu, mereka bilang, saat bintang-bintang selaras akan terjadi dua puluh lima tahun lagi... 
 Namun, Murphy yang ada di depanmu jelas hanyalah seorang anak remaja...]]
  },
  Event_7348_Name = {
    Text = "Nyawa yang Terkurung"
  },
  Event_7349_ChoiceDesc1 = {
    Text = "[Keluar] Dapatkan 1 dari 3 pilihan Relik perak, terinfeksi [(Skill.Arg1)]"
  },
  Event_7349_Desc = {
    Text = [[
Dia seharusnya menangis, tak ada yang lebih berhak untuk menangis daripada dia. 
Namun, mengapa dia tidak melakukannya? Mengapa dia hanya berdiri di luar, seolah-olah orang-orang yang bersujud itu bukan untuknya......]]
  },
  Event_7349_Name = {
    Text = "Ceremoni Pra-Penerbangan"
  },
  Event_7350_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7350_Desc = {
    Text = "Bagaimanapun, mencari tahu privasi orang lain adalah perilaku yang tidak sopan."
  },
  Event_7350_Name = {
    Text = "Seperti bertemu langsung"
  },
  Event_7351_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7351_Desc = {
    Text = "Pasti hanya karena mata sedikit berkunang-kunang."
  },
  Event_7351_Name = {
    Text = "Pandangan Burung Gagak Hitam"
  },
  Event_7352_ChoiceDesc1 = {
    Text = "[Pergi] Mendapatkan 1 dari 3 pilihan Orison"
  },
  Event_7352_Desc = {
    Text = "Dalam memori, semua orang berdoa kepadanya, memohon dengan penuh harap. Tanpa sadar, kau juga mulai membisikkan doa dalam hati..."
  },
  Event_7352_Name = {
    Text = "Ceremoni Pra-Penerbangan"
  },
  Event_7353_ChoiceDesc1 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7353_Desc = {
    Text = "Di bawah tubuh kucing hitam menetes cairan hitam kental. Aliran kecil dari cairan tersebut langsung mengalir menuju saluran air di mulut gang. Melihat kamu tidak berniat mendekat, kucing hitam itu berbalik dan melompat ke dalam saluran air, menghilang tanpa jejak."
  },
  Event_7353_Name = {Text = "Elfo Malam"},
  Event_7354_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7354_Desc = {
    Text = [[
Kamu sangat panik dan memekikkan suara melengkung yang menusuk telinga. 
Tampaknya suaramu membuat tangan yang semula gelisah ragu-ragu selama sesaat. 
Kamu langsung memanfaatkan kesempatan ini untuk melarikan diri.]]
  },
  Event_7354_Name = {
    Text = "Bekas Rawan Gelap"
  },
  Event_7355_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7355_Desc = {
    Text = [[
Membengkokkan, merayap, merangkak... kamu mencoba segala cara untuk melepaskan diri dari lengan-lengan yang menjengkelkan ini. 
Akhirnya, kamu berhasil melarikan diri, namun dengan harga satu set seragam sekolah baru, dua tulang rusuk, dan ratusan helai rambut.]]
  },
  Event_7355_Name = {
    Text = "Bekas Rawan Gelap"
  },
  Event_7356_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7356_Desc = {
    Text = [[
"Ini hal yang normal, jangan terlalu panik seperti seorang pemula,"
Boneka mendekat dan membantu meluruskan posisi bros di dada Anda, "Ini menunjukkan bahwa ada lorong dimensi khusus di dekat sini. Sepertinya ada di arah rumah sakit jiwa."]]
  },
  Event_7356_Name = {
    Text = "Brooch Tidak Tenang"
  },
  Event_7357_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7357_Desc = {
    Text = [[
Kamu tidak punya alasan untuk menerima permintaan pemberian makan dari para Penerang Cahaya Kuil. 
 Gagak itu dengan tidak puas menggoyangkan kepala tumpukan yang kotor dan mengerikan, mengeluarkan suara aneh yang hanya bisa kamu dengar di sisi kuburan, lalu meraung dan terbang menjauh.]]
  },
  Event_7357_Name = {
    Text = "Burung Gagak Terkutuk"
  },
  Event_7358_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7358_Desc = {
    Text = [[
"Itu juga adalah pilihanku."Bayangan seseorang yang memeluk boneka beruang berkata, "Tapi dia akan menjadi bonekanya, dan mereka semua akan mati. 
Kamu, akan menjadi kaki tangan dari dosa itu."
Rasa bersalah yang kuat menenggelamkanmu. Bayangan itu menghilang, kamu memegang dada, tidak tahu apakah yang tadi adalah proyeksi, atau Fatamorgana yang dihasilkan oleh tekanan Roh.]]
  },
  Event_7358_Name = {
    Text = "Jalan yang bercabang"
  },
  Event_7359_ChoiceDesc1 = {
    Text = "[Tetap menutup telinga] Mendapatkan nilai Aliemus tertinggi dari Pembangun, jumlahnya setara dengan Segil hitam(Arg1)"
  },
  Event_7359_ChoiceDesc2 = {
    Text = "[Melanjutkan menutup telinga] Memulihkan (Arg1) poin hidup, jumlah Segil hitam yang dimiliki akan meningkatkan jumlah pemulihan."
  },
  Event_7359_Desc = {
    Text = "Kamu menuruti bujukan tidak bermaksud baik yang berbisik di telingamu, jeritan seperti ujung jarum yang berputar menusuk ke dalam lubang telingamu.\n\"Berhenti — cepat berhenti — aku sudah melakukan apa yang kamu katakan — cepat berhenti —\"\nKamu menutup kepalamu dengan kesakitan, dalam keadaan setengah sadar kamu mendengar ejekan kawanan gagak."
  },
  Event_7359_Name = {
    Text = "Lagu Kawan-Kawan Gagak"
  },
  Event_7360_ChoiceDesc1 = {
    Text = "[Menangkap seekor gagak] Setiap memiliki 1 Pembangun yang sudah terbangun mendapatkan 25 Segil hitam"
  },
  Event_7360_ChoiceDesc2 = {
    Text = "[Mengeluarkan teriakan melengkung] Pilih 1 Pembangun untuk dibangunkan dan tambahkan efek \"Inherent\"dan \"Tetap\"pada kartu bangunnya"
  },
  Event_7360_Desc = {
    Text = [[
Kamu tiba-tiba merasa ingin bermain, lalu mengulurkan tangan dan menangkap seekor gagak. 
Gagak itu berjuang dengan putus asa di telapak tanganmu, akhirnya meledak menjadi segumpal cairan hangat.]]
  },
  Event_7360_Name = {
    Text = "Lagu Kawan-Kawan Gagak"
  },
  Event_7361_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7361_Desc = {
    Text = [[
Kamu menutup telinga dan memejamkan mata. 
Dung dung, dung dung... detak jantungmu bersamaan dengan suara jeritan tajam, menciptakan lagu kematian yang kacau. 
Pada saat ini, kamu merasakan ketenangan yang belum pernah dirasakan sebelumnya.]]
  },
  Event_7361_Name = {
    Text = "Lagu Kawan-Kawan Gagak"
  },
  Event_7362_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7362_Desc = {
    Text = [[
Di dalam Domain penuh dengan bahaya, tidak semua cahaya adalah mercusuar yang menuntun jalan ke depan.
Itu mungkin juga menjadi nyala lilin yang memikat ngengat.]]
  },
  Event_7362_Name = {
    Text = "Cahaya Malam"
  },
  Event_7363_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7363_Desc = {
    Text = "\"Kamu sudah lama mati, dan tidak bisa pulang ke Rumah.\" Suaramu sedingin Angin yang Menderu di Lapangan Salju Ross. Ekspresi sang musafir tidak berubah sama sekali, Seolah-olah memang sudah seharusnya begitu. Ia kembali menggenggam tanganmu, \"Tolong Aku! Aku adalah seorang prajurit yang diperintahkan untuk pergi ke timur yang jauh...\""
  },
  Event_7363_Name = {Text = "Melahap"},
  Event_7364_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7364_Desc = {
    Text = "Mesin telegraf sudah rusak. Bisakah kamu membayangkan keputusasaan pemilik mesin telegraf di tengah badai... karena saat ini, kamu juga merasakan hal yang sama."
  },
  Event_7364_Name = {
    Text = "Telegram Diam"
  },
  Event_7365_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7365_Desc = {
    Text = "\"Lurus ke depan sejauh lima puluh yard, belok kiri, lalu belok kanan, kemudian belok kiri lagi…\nLalu terus jalan sampai ujung, rumahmu ada di sana.\"\nSi musafir sangat gembira. Dia melambaikan tangan padamu, lalu pergi.\nKamu menghela napas lega, tiba-tiba merasa ada yang memegang tanganmu. Di telinga kembali terdengar suara yang sudah tidak asing lagi:\n\"Tolong selamatkan aku.\nAku seorang prajurit, diperintahkan menuju ke timur yang jauh…\""
  },
  Event_7365_Name = {Text = "Melahap"},
  Event_7366_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7366_Desc = {
    Text = [[
Akhirnya, kamu berhasil keluar dari labirin ini.
Pada saat itu, kamu tiba-tiba menyadari bahwa museum lilin ini adalah makhluk hidup.
Semua keanehan, keindahan, dan kekejaman terhubung dalam sebuah ritual kuno.
Dan mata dari ritual itu adalah Rogers.]]
  },
  Event_7366_Name = {
    Text = "Labirin Mata"
  },
  Event_7367_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7367_Desc = {
    Text = "\"Apakah peran karakter itu menarik, Penjaga?\" Ramona menarik lenganmu,\"Jalan keluar tidak jauh dari kita, semoga Anda juga dapat mempertahankan humor saat di hadapan Wanita Narsis.\""
  },
  Event_7367_Name = {
    Text = "Fragmen Kenangan·Mimpi Lama Kembali"
  },
  Event_7368_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7368_Desc = {
    Text = "\"Pembangun sulit melawan kehendak Tautan,\"kamu menjawab,\"tetapi kami tidak akan menyerah.\""
  },
  Event_7368_Name = {Text = "Pilihannya"},
  Event_7369_ChoiceDesc1 = {
    Text = "[Masuk] Lewati dinding, lalu selidiki lebih lanjut."
  },
  Event_7369_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7369_Desc = {
    Text = "Kamu mendekati dinding, dan tiba-tiba permukaan dinding berubah bentuk seolah-olah ingin menarikmu masuk."
  },
  Event_7369_Name = {
    Text = "Ruang Terdistorsi"
  },
  Event_7370_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7370_Desc = {
    Text = "\"Tidak, ini tidak benar. Dibandingkan dengan kecoak, setidaknya kalian memiliki tubuh yang berbulu. \nTidak ada yang bisa menolak tubuh yang berbulu.\"\nTikus-tikus itu berbisik satu sama lain, akhirnya dengan enggan menyetujui pendapatmu. \n\"Lumayanlah…… sebenarnya tidak terlalu banyak bulu juga.\"\nDipuji selalu menyenangkan. Sebelum pergi, tikus-tikus itu memberimu sebuah Hadiah kecil."
  },
  Event_7370_Name = {Text = "Wabah"},
  Event_7371_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7371_Desc = {
    Text = [[
"Saya setuju! Manusia dan tikus tidak bisa hidup berdampingan!"
Tikus-tikus itu sedikit marah, memperlihatkan taring putih mereka. 
"Lalu apa yang masih kau lakukan di sini? Ambil barangmu dan jangan pernah kembali."]]
  },
  Event_7371_Name = {Text = "Wabah"},
  Event_7372_ChoiceDesc1 = {Text = "[OK]"},
  Event_7372_Desc = {
    Text = [[
Selamat datang di bawah laut dalam, setiap langkah yang diambil akan terasa tekanan yang berat.

Kabut kekacauan yang tidak dapat diteruskan cahaya menyembunyikan segalanya, dapatkah kamu melewati lautan gelap ini di bawah tekanan besar?]]
  },
  Event_7372_Name = {
    Text = "Di bawah gelombang pasang"
  },
  Event_7373_ChoiceDesc1 = {
    Text = "[Melihat Lihat] Hapus 1 Kartu"
  },
  Event_7373_ChoiceDesc2 = {
    Text = "[Lihat lebih dekat] Mendapatkan \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7373_Desc = {
    Text = "\"Tak tak…\"\nMesin tik itu seperti peminum wiski yang mabuk, keluarkan tinta hitam dengan tersendat-sendat. \nKamu dengan cepat menangkap kata \"Mason\", lalu segera menarik kertas dari mesin tik."
  },
  Event_7373_Name = {Text = "Mesin tik"},
  Event_7374_ChoiceDesc1 = {
    Text = "[Melihat langsung ke mata] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7374_ChoiceDesc2 = {
    Text = "[Tutup mata] Secara acak membangunkan 2 Pembangun, menginfeksi dua kali [(Skill.Arg1)]"
  },
  Event_7374_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_7374_Desc = {
    Text = [[
Tak terhitung mata mengelilingi di samping telingamu dan berbisik. 
"Kami berjalan, kami berhenti, kami melangkah dengan tegap melewati puluhan ribu tahun atau bahkan lebih lama. 
Ketika matahari perlahan memudar dalam pandangan, ketika kehidupan Bumi tua ditenggelamkan oleh banjir. 
Kami telah lama terpikat oleh misteri alam semesta."]]
  },
  Event_7374_Name = {Text = "Mata"},
  Event_7375_ChoiceDesc1 = {
    Text = "[Menaati instruksi] Meningkatkan Arg1 poin Hidup"
  },
  Event_7375_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7375_Desc = {
    Text = "Kamu mencoba menggunakan kekuatan penelusuran Kunci perak untuk mencari Persimpangan terdekat, tetapi informasi yang diperoleh mengandung anomali yang sulit dideteksi, sepertinya telah terganggu."
  },
  Event_7375_Name = {
    Text = "Kontak Anomali"
  },
  Event_7376_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7376_Desc = {
    Text = [[
Kamu menggunakan sapu tangan linen standar yang termasuk dalam set siswa Mythag untuk menyeka permukaan mesin tik.
Mesin tik itu kembali tenang. Adapun sapu tangan yang kotor... biarkan saja di dalam Domain.]]
  },
  Event_7376_Name = {
    Text = "Bisikan Mesin Tik"
  },
  Event_7377_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7377_Desc = {
    Text = [[
Kamu memandang dengan cermat, dan di antara goresan tinta yang bergoyang dan bertumpuk, sebuah nama samar-samar terlihat, "Fingal Johansen". 
Siapakah dia?]]
  },
  Event_7377_Name = {
    Text = "Bisikan Mesin Tik"
  },
  Event_7378_ChoiceDesc1 = {
    Text = "[Mengangkat kepala dan menatap lurus] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7378_ChoiceDesc2 = {
    Text = "[Sudut elevasi matahari?] Pilih 1 Pembangun untuk dibangunkan, infeksi [(Skill.Arg1)]"
  },
  Event_7378_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7378_Desc = {
    Text = "\"Sekarang, segera angkat kepalamu dan lihat ke arah tenggara, sudut elevasi matahari sedang berada di posisinya.\"Instruksi dari Boneka terdengar melalui komunikator."
  },
  Event_7378_Name = {
    Text = "Sudut elevasi"
  },
  Event_7379_ChoiceDesc1 = {
    Text = "[Infeksi \"(Skill.Arg1)\", mendapatkan Relik emas \"(RelicConfig.Arg2)\"]"
  },
  Event_7379_ChoiceDesc2 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_7379_Desc = {
    Text = "Acara 354 (dalam pengembangan), bukan efek akhir"
  },
  Event_7379_Name = {
    Text = "Acara 354 (dalam pengembangan)"
  },
  Event_7380_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7380_Desc = {
    Text = "Suara anak-anak mengalir dari bawah tuts piano. \n\"Paman Charlie memiliki seekor kucing belang yang sangat ia cintai……\"\nDi bawah nyanyian anak-anak, terdengar juga suara seorang wanita muda yang bernyanyi dengan lembut. \nApakah kamu salah dengar?"
  },
  Event_7380_Name = {
    Text = "Melodi Masa Kecil"
  },
  Event_7381_ChoiceDesc1 = {
    Text = "[Mendapatkan] 25 Segil Hitam"
  },
  Event_7381_ChoiceDesc2 = {
    Text = "[Lanjutkan perjalanan] mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7381_Desc = {
    Text = [[
Langkah kaki terdengar dari belakang.
Seperti bayangan, tidak terburu-buru dan tidak lambat.
Bercampur dengan suara langkah kakimu, bergema di ruang pameran yang luas dan kosong.]]
  },
  Event_7381_Name = {Text = "Oxford"},
  Event_7382_ChoiceDesc1 = {
    Text = "[Menghapus surat] Hapus 2 Kartu"
  },
  Event_7382_ChoiceDesc2 = {
    Text = "[Surat Terpelihara] Mendapatkan Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7382_ChoiceDesc3 = {
    Text = "[Pergi]mendapatkan Arg1 Segil hitam"
  },
  Event_7382_Desc = {
    Text = "Sebuah mesin ketik model baru. \nMemiliki set tombol huruf yang unik, seindah dan serumit mikroskop. \nAnda terpesona oleh struktur mekanisnya yang sempurna saat tiba-tiba muncul tulisan berwarna hitam. \n\"Yang Terhormat Tuan Rogers, \nDengan rasa berat hati kami memberitahukan bahwa Anda telah dikeluarkan dari Akademi. \nSeperti yang diketahui, @2Akademi terkenal di seluruh kerajaan karena sikap belajarnya yang ketat, sementara itu rumor mencengangkan tersebut…\""
  },
  Event_7382_Name = {
    Text = "Seperti bertemu langsung"
  },
  Event_7383_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7383_Desc = {
    Text = "Jam saku yang terhenti di kejauhan seolah menjadi semacam dorongan, mengingatkan kalian untuk tidak terjebak dalam jebakan waktu dan ruang."
  },
  Event_7383_Name = {
    Text = "Pandangannya"
  },
  Event_7384_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7384_Desc = {
    Text = [[
Lumpur hitam menetes di wajahmu, menyebabkan rasa gatal yang menjalar. 
Kamu tidak tahan dan mencoba menepis kupu-kupu itu dengan tanganmu. 
Kupu-kupu itu menghindari gerakan kasarmu, lenyap tanpa suara di ujung sana.]]
  },
  Event_7384_Name = {
    Text = "Kupu-kupu Cairan Hitam"
  },
  Event_7385_ChoiceDesc1 = {
    Text = "[Amati dengan saksama]"
  },
  Event_7385_ChoiceDesc2 = {Text = "[Gali]"},
  Event_7385_Desc = {
    Text = [[
Kum menggendong kalian bertiga di dalam rumah sakit jiwa mencari pintu masuk. 
 Tiba-tiba, ia mengerem dengan cepat, hampir membuat kalian terjatuh dari punggungnya. 
 Di tengah suara kebingungan kalian, Kum menundukkan kepala, mencium tanah yang lembut, lalu menoleh dan memberi isyarat kepada kalian, sepertinya ada sesuatu yang terkubur di bawah]]
  },
  Event_7385_Name = {
    Text = "Benda Terkubur"
  },
  Event_7386_ChoiceDesc1 = {
    Text = "[Klaim] Dapatkan 1 dari 3 Relik Emas"
  },
  Event_7386_Desc = {
    Text = [[
Di sana tidak ada apa-apa, cairan hitam mengalir di atas tanah, tidak memantulkan apa pun. 
 Apakah ini ilusi milikmu? Kamu merasakan sesuatu meluncur di antara jari-jari.]]
  },
  Event_7386_Name = {
    Text = "Di bawah permukaan cermin"
  },
  Event_7387_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7387_Desc = {
    Text = "Sayap hitam jatuh di atas tanah basah di gang kecil, berubah menjadi D-lendir."
  },
  Event_7387_Name = {
    Text = "Kawanan Gagak Berisik"
  },
  Event_7388_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7388_Desc = {
    Text = "\"Nyonya Dafude'er akan menyukai selera humormu.\"Ramona melambaikan tangannya, fatamorgana tipis pun mengalir dan memudar, \"Jangan biarkan dirimu menjadi korban perjalanan dimensi.\""
  },
  Event_7388_Name = {
    Text = "Fragmen Kenangan·Mimpi Lama Kembali"
  },
  Event_7389_ChoiceDesc1 = {
    Text = "[Klaim] Dapatkan 1 dari 3 Relik Emas"
  },
  Event_7389_Desc = {
    Text = [[
Oh ya, bayangan yang dibenci itu adalah dirimu sendiri. 
 Kebencian yang menyembur bercampur dengan lumpur hitam di bawah kakimu, berdansa dengan cara yang terdistorsi. Jika tidak keberatan, ia juga ingin merayap ke bahumu.]]
  },
  Event_7389_Name = {
    Text = "Di bawah permukaan cermin"
  },
  Event_7390_ChoiceDesc1 = {
    Text = "[Di tempat] mendapatkan 25 Segil hitam"
  },
  Event_7390_ChoiceDesc2 = {
    Text = "[Bergerak bebas] mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7390_Desc = {
    Text = [[
Kamu menginjak bayanganmu hingga hancur, terjatuh ke dalam genangan malam. 
 Bayangan hitam yang hancur berantakan itu adalah satu-satunya hal yang terhubung denganmu di dunia yang hilang jejaknya. 
 Apakah kamu benar-benar ingin berjalan di dalam mimpi buruk yang gelap gulita? Kamu masih belum menemukan arah.]]
  },
  Event_7390_Name = {
    Text = "Perjalan Mimpi Buruk"
  },
  Event_7391_ChoiceDesc1 = {
    Text = "[Mencari Asal Usul] Mendapatkan Relik Perak \"(RelicConfig.Arg1)\", Terinfeksi \"(Skill.Arg2)\""
  },
  Event_7391_ChoiceDesc2 = {
    Text = "[Rekam Ulang] Semua Pembangun memulihkan 50 Aliemus dan terinfeksi [(Skill.Arg1)]"
  },
  Event_7391_ChoiceDesc3 = {
    Text = "[Membongkar Gramofon] Mendapatkan 1 dari 3 Orison"
  },
  Event_7391_Desc = {
    Text = "Kamu menemui sebuah Gramofon Tua. \nSetelah memutar pegasnya, kamu meletakkan jarum di atas piringan hitam yang penuh goresan. Musik simfoni terdengar terdistorsi seperti suara tarikan pita perekat yang lengket, alat tiup dan dawai seolah saling beradu, tak satu pun bagian musik yang bisa keluar utuh dari komposisi ini. \nDi akhir lagu yang berderak-derik, kamu mendengar serangkaian ketukan teratur. \n\"Dung dung… dung dung dung… dung…\"\nKamu mengerutkan dahi, lalu mengangkat jarum, namun suara ketukan itu masih terus berlanjut."
  },
  Event_7391_Name = {
    Text = "Suara Jejak Misterius"
  },
  Event_7392_ChoiceDesc1 = {
    Text = "[Memeriksa cahaya] Pilih 1 Relik untuk diubah menjadi Relik terkutuk [(RelicConfig.Arg1)]"
  },
  Event_7392_ChoiceDesc2 = {
    Text = "[Menyentuh Cahaya] memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7392_ChoiceDesc3 = {
    Text = "[Meninggalkan dengan berbalik] Mendapatkan 25 Segil Hitam"
  },
  Event_7392_Desc = {
    Text = [[
Di bawah bidang pandang mimpi, kabut Domain menyelimuti realitas dengan kain hitam. Segala sesuatu tampak samar-samar, seolah ada dan tidak ada. 
 Dalam kabut yang samar, cahaya sesuatu menembus kabut. Seperti mercusuar bagi kapal pesiar, asap dapur bagi anak-anak yang tersesat, menunjukkan arah yang aman.]]
  },
  Event_7392_Name = {
    Text = "Cahaya Malam"
  },
  Event_7393_ChoiceDesc1 = {
    Text = "[Musik dijeda] Tingkatkan 1 Relik Perak menjadi Relik Emas [(RelicConfig.Arg1)]"
  },
  Event_7393_ChoiceDesc2 = {
    Text = "[Percakapan dengannya] mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\" serta \"(Skill.Arg3)\""
  },
  Event_7393_ChoiceDesc3 = {
    Text = "[ Dengarkan dengan tenang ] Mendapatkan 25 Segil Hitam"
  },
  Event_7393_Desc = {
    Text = "Kamu mencabut beberapa potongan memori yang pecah dari genangan lumpur hitam yang kotor. \n Kristal yang jernih berkilau, beberapa helai benang bergetar dan terbang di dalamnya, serpihan memori yang tersisa seperti kerikil yang diterbangkan oleh angin, melayang di udara. \n Gambaran yang kacau, aneh, dan misterius muncul di sampingmu. \n Kamu melihat ke arah—— \n"
  },
  Event_7393_Name = {
    Text = "Fragmen Bulan Perak"
  },
  Event_7394_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7394_Desc = {
    Text = "Kamu mengulurkan tangan untuk menangkap beberapa serpihan salju yang jatuh, lalu memperhatikannya dengan seksama. Salju itu tidak mencair menjadi tetesan air yang bening, melainkan D-lendir yang kental dan gelap."
  },
  Event_7394_Name = {Text = "Salju"},
  Event_7395_ChoiceDesc1 = {
    Text = "[Saya tidak berada di permukaan air] 1 Relik perak acak ditingkatkan menjadi Relik emas [(RelicConfig.Arg1)]"
  },
  Event_7395_ChoiceDesc2 = {
    Text = "[Melihat ke bawah] Memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7395_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7395_Desc = {
    Text = [[
Kabut perlahan menghilang, sebuah telapak tangan kurus muncul di hadapanmu. 
 Tangan itu tampaknya telah terkorosi daging dan darahnya, permukaan telapak yang tidak rata ditutupi dengan lendir hitam yang kental, sementara di tubuhnya, terjatuh banyak cincin kalung yang mengalirkan cahaya emas. 
 Ia melambai-lambaikan tangannya padamu, seolah mengundangmu untuk mendekat. 
 Hanya dalam bayang-bayang krisis, harta yang berharga terasa sangat bersinar.]]
  },
  Event_7395_Name = {
    Text = "Membalikkan Cakar Iblis"
  },
  Event_7395_Tips1 = {
    Text = "Belum memiliki Relik perak"
  },
  Event_7396_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7396_Desc = {
    Text = "Fatamorgana melambai ke arahmu, lalu menghilang. Yang tersisa hanyalah dinginnya salju dan pegunungan yang menjulang."
  },
  Event_7396_Name = {
    Text = "Fatamorgana Vulkanik"
  },
  Event_7397_ChoiceDesc1 = {
    Text = "[Pemakaman bulan perak] Pilih 1 Relik untuk diubah menjadi Relik terkutuk [(RelicConfig.Arg1)]"
  },
  Event_7397_ChoiceDesc2 = {
    Text = "[Doa bulan perak] mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7397_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7397_Desc = {
    Text = "Kamu mencabut beberapa potongan memori yang pecah dari genangan lumpur hitam yang kotor. \n Kristal yang jernih berkilau, beberapa helai benang bergetar dan terbang di dalamnya, serpihan memori yang tersisa seperti kerikil yang diterbangkan oleh angin, melayang di udara. \n Gambaran yang kacau, aneh, dan misterius muncul di sampingmu. \n Kamu melihat ke arah——"
  },
  Event_7397_Name = {
    Text = "Fragmen Bulan Perak"
  },
  Event_7398_ChoiceDesc1 = {
    Text = "[Tambah Bahan Bakar] Dapatkan 1 dari 3 Orison"
  },
  Event_7398_ChoiceDesc2 = {
    Text = "[Padamkan Itu] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7398_Desc = {
    Text = [[
"Aku adalah bayangan pelayan yang dibunuh dengan kejam, pelakunya adalah nyala api hijau palsu itu."
Nyala api merah pudar bergoyang, mengadukanmu. 
"Aku pernah hidup di tepi danau yang memantulkan bulan cembung, bersinar terang, gemerlap luar biasa."]]
  },
  Event_7398_Name = {Text = "Api redup"},
  Event_7399_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7399_Desc = {
    Text = [[
Kamu dan bayangan berdiri di bawah lampu jalan, tak ada yang bicara. 
Malam ini tidak ada bulan, semua rumah terlihat sunyi. 
Kamu melambaikan tangan ke arah bayangan, lalu berbalik pergi.]]
  },
  Event_7399_Name = {
    Text = "Bayangan di bawah lampu jalan"
  },
  Event_7400_ChoiceDesc1 = {
    Text = "[Mengusir Gagak] Mendapatkan Arg1 Segil hitam, terinfeksi [(Skill.Arg2)], lanjutkan memilih"
  },
  Event_7400_ChoiceDesc2 = {
    Text = "[Mengabaikan] Pergi"
  },
  Event_7400_Desc = {
    Text = "Gagak berhenti di kepala tempat tidur, memandangmu dengan mata yang memerah."
  },
  Event_7400_Name = {
    Text = "Lentera Gagak Hitam"
  },
  Event_7401_ChoiceDesc1 = {
    Text = "[Mengatakan tidak memiliki dompet] Mendapatkan pilihan 3 dalam 1 Orison"
  },
  Event_7401_ChoiceDesc2 = {
    Text = "[Memecahkan Jaring] 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7401_Desc = {
    Text = [[
Jaring berwarna oranye-kuning melayang tenang di udara, lubang-lubangnya jarang, jauh dari keindahan jaring yang ditempati sepupu laba-laba di akar dinding. 
 Kamu tak tahan untuk menyentuhnya, jaring rapuh itu langsung larut, dan tawa anak-anak terdengar di telingamu. 
 "Emas, perak, kuning, merah, semua dompet adalah milik kita!"]]
  },
  Event_7401_Name = {
    Text = "Jaringan Wandering"
  },
  Event_7402_ChoiceDesc1 = {
    Text = "[Mesin Telegram Perbaikan] Terinfeksi \"(Skill.Arg1)\", 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg2)\""
  },
  Event_7402_ChoiceDesc2 = {
    Text = "[Menyembunyikan telegraf] Infeksi \"(Skill.Arg1)\", 1 kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg2)\""
  },
  Event_7402_ChoiceDesc3 = {
    Text = "[Abaikan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7402_Desc = {
    Text = [[
Kamu bersembunyi di celah gua yang sempit, untuk menghindari badai salju. Namun kamu tahu bahwa kamu tidak bisa berlama-lama di sini, jika sekelompok monster berbaju hitam menemukan tempat ini, kamu tidak akan punya jalan keluar.
Di sudut celah, kamu bahkan menemukan sebuah mesin telegraf yang rusak.]]
  },
  Event_7402_Name = {
    Text = "Relik dari Orang Terdahulu"
  },
  Event_7403_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7403_Desc = {
    Text = "Kamu pernah melihat banyak potret seperti ini di berbagai tempat di dalam kerajaan. \n\"Sang Ratu\"berada di tengah lukisan, bersinar terang di antara mawar hitam yang mengelilinginya. \nHanya ada satu hal — wajahnya telah kejam dicungkil, meninggalkan lubang hitam yang hangus. \nHingga saat ini, kamu masih belum bisa melihat wajah asli sang ratu."
  },
  Event_7403_Name = {
    Text = "Galeri Potret"
  },
  Event_7404_ChoiceDesc1 = {
    Text = "[Membebaskannya] Mendapatkan Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7404_ChoiceDesc2 = {
    Text = "[Membantunya] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7404_ChoiceDesc3 = {
    Text = "[Saya ingin berjalan di jalan sendiri]Mendapatkan 50 Segil Hitam"
  },
  Event_7404_Desc = {
    Text = [[
Tiga bayangan menghalangi jalanmu.
"Kau bisa melepaskannya,"bayangan yang memegang boneka beruang yang ternoda D-lendir berkata, "dia hanya takut, bukan jahat. Dia tidak ingin melukai siapa pun."
"Kau bisa membantunya,"bayangan yang memegang sekumpulan permen yang dikemas dengan indah berkata, "kau bisa melakukan apa yang tidak bisa dilakukannya, kau bisa mengakhiri semua ini."
"Kau tidak perlu mendengarkan kami,"bayangan yang kosong berkata, "kau memiliki jalanmu sendiri."]]
  },
  Event_7404_Name = {
    Text = "Jalan yang bercabang"
  },
  Event_7405_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7405_Desc = {
    Text = "Suara Narsis terhenti sejenak. \n\"Oh, jadi kamu memilih ini? Pilihan yang bagus. Sebagai hadiah, aku akan memberikanmu sebuah hadiah spesial.\"\n\"Aku tidak terlalu mengenal anak itu, tapi aku punya dugaan tentang Francis. Aku merasa bahwa emosi yang menguasainya dan memberinya kekuatan untuk 'melihat' adalah penyesalan yang mendalam. Entah apa yang akan dia lakukan karena penyesalan itu…\""
  },
  Event_7405_Name = {
    Text = "Waktu Petunjuk"
  },
  Event_74068_ChoiceDesc1 = {
    Text = "[Masukkan ke dalam tangki otak] Masukkan [tangki otak cadangan]ke dalam tumpukan kartu menggambar."
  },
  Event_74068_Desc = {
    Text = [[
Di dalam pintu lengkung yang berornamen rumit, bayangan yang memanjang melompat di atas atap miring dinding bata merah, di depan rumah yang ada celah di dinding, mendambakan jawaban atas pertanyaan. 
Apakah kebosanan berarti kematian? 
Apakah berpuas diri berarti api akan padam?]]
  },
  Event_74068_Name = {
    Text = "Kesadaran yang belum hilang"
  },
  Event_74069_ChoiceDesc1 = {
    Text = "[Lanjutkan Penampungan] Pilih hingga 2 Kartu Perintah untuk dihapus dari dek dan tempatkan mereka ke dalam [Tangki Otak Cadangan]."
  },
  Event_74069_Desc = {
    Text = "\"Saya melihat mereka. Banyak orang, banyak gumaman mimpi, yang bijaksana, yang dangkal, yang rasional, yang terjebak dalam kegilaan. Terkadang, dari abu juga bisa lahir percikan harapan.\""
  },
  Event_74069_Name = {
    Text = "Kesadaran yang belum hilang"
  },
  Event_7406_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7406_Desc = {
    Text = "Kamu hati-hati melepas tikus dari timbangan, napasnya teratur, tubuhnya yang berbulu menghangatkan telapak tanganmu."
  },
  Event_7406_Name = {
    Text = "Kebijaksanaan dan Emosi"
  },
  Event_7407_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7407_Desc = {
    Text = [[
Inti perak yang redup memancarkan cahaya yang mencolok, namun lenyap dalam sekejap, meninggalkan hanya segenggam abu yang tak berbeda dari pasir.
Inti perak telah menghabiskan Gnosis terakhirnya, jiwa yang tidak dikenal tidak dapat membentuk kembali tubuh, tetapi sebelum sepenuhnya lenyap, ia juga meninggalkan jejak keberadaannya.]]
  },
  Event_7407_Name = {
    Text = "Bukti Kehidupan"
  },
  Event_7408_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7408_Desc = {
    Text = "『Aku tidak terlalu mengenal anak itu, tapi aku punya dugaan tentang Francis. Aku merasa bahwa emosi yang menguasainya dan memberinya kekuatan untuk 'melihat' adalah penyesalan yang mendalam. Aku tidak tahu pilihan apa yang akan dia buat karena penyesalan ini...』"
  },
  Event_7408_Name = {
    Text = "Waktu Petunjuk"
  },
  Event_7409_ChoiceDesc1 = {
    Text = "[Mengeluarkan kertas] Hapus 1 kartu"
  },
  Event_7409_ChoiceDesc2 = {
    Text = "[Saat ini bukan waktunya] Mendapatkan \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7409_Desc = {
    Text = [[
Mesin ketik portabel di dalam koper tiba-tiba bergerak sendiri, mengetik setengah halaman teks yang miring dan tidak rata. 
 "Kamu sudah melihat-Nya, Dia ada di sisimu, bayangan-bayangan yang tercemar oleh kegilaan, penuh dengan fanatisme... Jangan menatap langsung pada sosok-Nya."]]
  },
  Event_7409_Name = {
    Text = "Peringatan Tidak Diundang"
  },
  Event_7410_ChoiceDesc1 = {
    Text = "[Pergi ke kiri] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7410_ChoiceDesc2 = {
    Text = "[Pergi ke kanan] Pilih 1 Pembangun untuk Bangun, infeksi [(Skill.Arg1)]"
  },
  Event_7410_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7410_Desc = {
    Text = [[
Sepertinya kamu telah memasuki sebuah labirin. 
Ke kiri, ke kanan, lalu ke kiri lagi... Kamu mulai kehilangan kesabaran, sampai kamu mengangkat kepala dan melihat mata itu. 
Mata itu memandangmu, tenang dan penuh wibawa, seolah-olah ia adalah penguasa di sini.]]
  },
  Event_7410_Name = {
    Text = "Labirin Mata"
  },
  Event_7411_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7411_Desc = {
    Text = [[
Kamu berusaha menarik kedua tanganmu kembali dan dengan jelas mendengar suara tulang retak. 
Ini adalah harga yang harus kamu bayar untuk keingintahuanmu.]]
  },
  Event_7411_Name = {
    Text = "Ledakan Inspirasi"
  },
  Event_7412_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7412_Desc = {
    Text = [[
Kamu memeriksa kamera dengan cermat. Kulit dan emas hitam tertanam di bodinya, memantulkan kilauan berminyak yang halus. 
 Lensanya mengarah padamu, seolah-olah sedang menatap dan mengintip...]]
  },
  Event_7412_Name = {
    Text = "Catatan Tidak Bersalah"
  },
  Event_7413_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7413_Desc = {
    Text = "Kamu tanpa ampun menarik keluar separuh film lainnya, yang tersembunyi di dalam perut kamera. Tiba-tiba ditarik keluar, namun gambar di atasnya membuatmu terdiam lama tanpa kata. \n Film yang belum dicuci dengan setia mencatat —— dirimu terbaring di genangan lumpur hitam."
  },
  Event_7413_Name = {
    Text = "Catatan Tidak Bersalah"
  },
  Event_74145_ChoiceDesc1 = {
    Text = "[Baca] Hapus 1 Kartu Perintah, dapatkan 25 Segil Hitam"
  },
  Event_74145_ChoiceDesc2 = {
    Text = "[Salin kartu dari deck. Infeksi \"(Skill.Arg1)\"]"
  },
  Event_74145_Desc = {
    Text = [[
Printer dengan ganas menyemburkan tinta.
Tinta hitam seperti hantu menyembur keluar dari nosel, menyebar di udara dan membentuk awan hitam yang pekat serta menekan.
Keyboard tampaknya menyimpan petunjuk tersembunyi, menunggu sentuhan jari yang tak bersalah.]]
  },
  Event_74145_Name = {
    Text = "Tinta hantu"
  },
  Event_74146_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74146_Desc = {
    Text = "Kamu melangkah ke dalam gang gelap, kabut menggigit ujung pakaiannya, tetapi bayangan itu berubah menjadi ribuan pasang mata di belakangmu. Suara lonceng berkarat mengantarkan pertanda yang lembap. \n\nKau tahu, semua jalan yang berliku pada akhirnya akan runtuh menjadi kepompong yang berulang—sebelum fajar yang membusuk, kau dan bayanganmu pasti akan bertemu lagi."
  },
  Event_74146_Name = {Text = "Abu waktu"},
  Event_74147_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74147_Desc = {
    Text = [[
Kamu diam-diam menggambar kontur di dada, mempersembahkan doa tanpa kata untuk yang telah tiada. 
Di dunia yang lenyap ini, ada terlalu banyak hal yang tak bisa kau selamatkan. 
Tulang-belulang berkilauan, benda berharga milik pemiliknya semasa hidup tampak sebagian.]]
  },
  Event_74147_Name = {
    Text = "Tulang Luntur"
  },
  Event_74148_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74148_Desc = {
    Text = [[
"Dewa Ayah merasakan belas kasihmu. Dewa Ayah akan melindungi kita, menyelamatkan kita dari beban penderitaan yang berat."

Fatamorgana-nya perlahan memudar, suara musik suci pun berubah menjadi angin yang meraung tanpa ampun.]]
  },
  Event_74148_Name = {
    Text = "Doa Pemain Organ"
  },
  Event_74149_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74149_Desc = {
    Text = [[
Kamu dengan lembut mendorong tulang belulang yang telanjang, ia perlahan menyerap ke dalam lumpur hitam dan menghilang tanpa jejak.
Semoga jiwa mendapat ketenangan dalam ilusi.]]
  },
  Event_74149_Name = {
    Text = "Tulang Luntur"
  },
  Event_7414_ChoiceDesc1 = {
    Text = "[Keluar] Kamu mengalahkan lawan, tidak terjadi apa-apa."
  },
  Event_7414_Desc = {
    Text = [[
"Tampaknya, bocah kecil harus mengalami penderitaan agar tahu bahwa rahasia seorang wanita tidak bisa diintip begitu saja."
Seiring dengan suara Dafude'er, monster raksasa muncul di hadapanmu.]]
  },
  Event_7414_Name = {
    Text = "Waktu Petunjuk"
  },
  Event_74150_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74150_Desc = {
    Text = [[
Mainan patologis seperti ini seharusnya tidak ada di menara jam tempat si tikus kecil bersembunyi, suara ini berasal dari dalam pikiranmu, dari ingatanmu. 
 Kamu mengingat perasaan yang pernah kamu alami saat menjadi Otak Dalam Tabung, aliran listrik yang diubah melalui gelombang suara. 
 Suara aneh itu perlahan-lahan menjadi normal dan tenang, berubah menjadi sebuah musik klasik yang mengalir, diputar berulang kali dalam pikiranmu.]]
  },
  Event_74150_Name = {
    Text = "Suara Aneh dari Menara Jam"
  },
  Event_74151_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74151_Desc = {
    Text = [[
Itu bukan kucing... itu adalah Penerang cahaya kuil yang bergerak. 
 Di bawah kain tipis hitam terlihat kebencian dan permusuhan, bisikan menggores kesadaranmu, membawa bayangan yang aneh dan tidak jelas.]]
  },
  Event_74151_Name = {
    Text = "Bisikan Kucing"
  },
  Event_74152_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74152_Desc = {
    Text = [[
Mereka mencengkeram sepatumu, mencengkeram pergelangan kakimu. Mereka serakah, mereka haus, mereka ingin menarikmu ke dalam jurang tempat mereka berada. 
Kamu berjuang keras untuk mempertahankan posisi tubuhmu dan mundur beberapa langkah demi melarikan diri. 
Tanpa sengaja, sesuatu terjatuh.]]
  },
  Event_74152_Name = {
    Text = "Refleksi Mimpi Buruk"
  },
  Event_74153_ChoiceDesc1 = {
    Text = "[Dodge] Mendapatkan 1 Orison dari 3 Pilihan"
  },
  Event_74153_ChoiceDesc2 = {
    Text = "[Hentikan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_74153_Desc = {
    Text = "Adegan yang terasa familiar membuat sarafmu bergetar, berkedut, dan dipenuhi rasa takut.\n\"Lagi…\"\nKedatangan mimpi buruk yang kejam, perasaan tidak berdaya yang luar biasa menyelimuti dirimu.\nApakah kamu benar-benar tidak bisa mengubah nasibnya?\nTidak ada waktu lagi, kepala Sarah yang retak, mulut besar berkilauan perak siap untuk menggigit tubuhmu, melahap dan mengunyahmu."
  },
  Event_74153_Name = {
    Text = "Kengerian kembali"
  },
  Event_74154_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74154_Desc = {
    Text = [[
Kamu mendengar bisikan yang mengganggu. 

"Kami berasal dari pegunungan dan rawa-rawa di bintang yang jauh. Tubuh kami adalah sumbu dan bahan bakar lentera, kami akan menyalakan api dari bumi untuk menerangi jalan menuju dunia baru."]]
  },
  Event_74154_Name = {
    Text = "Bisikan Kucing"
  },
  Event_74155_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74155_Desc = {
    Text = [[
Matahari terbenam, menara jam, burung terbang... 
 Gadis itu melepas penutup matanya, tatapan pupil abu-abunya membuatmu terdiam. 
 Ilusi seperti fatamorgana, lenyap seketika di depan mata, namun pikiran cemas tak kunjung pergi.]]
  },
  Event_74155_Name = {
    Text = "Masker mata putih"
  },
  Event_74156_ChoiceDesc1 = {
    Text = "[Pungut] Dapatkan 1 dari 3 pilihan Relik perak"
  },
  Event_74156_ChoiceDesc2 = {
    Text = "[Kilas Balik] Memperoleh Relik Perak \"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\", terinfeksi dua kali \"(Skill.Arg3)\""
  },
  Event_74156_Desc = {
    Text = [[
Di dalam lendir pelarutan di sudut, terdapat sebuah penutup mata putih kecil. 
Kenangan mencengkeram jantungmu.]]
  },
  Event_74156_Name = {
    Text = "Masker mata putih"
  },
  Event_74157_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74157_Desc = {
    Text = [[
Telapak tangan yang transparan menari dengan bebas di atas tuts piano hitam-putih, tetapi gelombang suara yang dihasilkan terputus-putus, seperti kotak musik yang tidak sesuai nada, setiap not mengeluarkan ratapan yang tidak harmonis, seolah-olah merupakan jeritan minta tolong. 
 Akhirnya, permainan terhenti secara mendadak dalam sebuah akor yang putus asa. 
 Apa yang tidak bisa didapatkan semasa hidup, hanya menyisakan kerinduan di momen ini.]]
  },
  Event_74157_Name = {
    Text = "Sonata Kesedihan"
  },
  Event_74158_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74158_Desc = {
    Text = "\"Yang Terhormat Ibu Sarah: \nSaya memohon untuk mengundurkan diri dari posisi perawat di panti asuhan. \nSaya sudah tidak sejalan dengan prinsip Anda. Ajaran Anda adalah kesalahan, anak-anak di Distrik Timur tidak seharusnya tumbuh dalam naungan Anda, dan mereka tidak seharusnya percaya pada kebaikan murni serta pemberian tanpa pamrih. \nPada suatu hari, mereka harus meninggalkan perlindungan Anda untuk belajar tentang hukum kehidupan di Distrik Timur. \n\n……\"\n\nTulisan selanjutnya telah kabur karena cairan hitam yang meresap."
  },
  Event_74158_Name = {
    Text = "Tinta hantu"
  },
  Event_74159_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74159_Desc = {
    Text = "\"Yang bisa aku berikan kepada anak-anak hanyalah atap untuk melindungi mereka dari hujan dan sedikit makanan agar tidak kelaparan. Jika bukan karena Dokter yang dipanggil oleh Tuan Rogers yang baik hati, mereka bahkan tidak akan mendapatkan obat ketika sakit.\nAku tidak pernah membaca banyak buku, menjaga mereka agar tidak mati kelaparan atau kedinginan di jalanan adalah semua yang bisa aku lakukan.\nAku tak pernah mencampuri apa yang ingin mereka capai dalam hidup, tapi mereka harus tetap hidup.\n……\""
  },
  Event_74159_Name = {
    Text = "Tinta hantu"
  },
  Event_7415_ChoiceDesc1 = {
    Text = "[Mencari Sumber] Mendapatkan Relik emas [(RelicConfig.Arg1)]"
  },
  Event_7415_ChoiceDesc2 = {
    Text = "[Buang surat] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7415_ChoiceDesc3 = {
    Text = "[Periksa surat] Dapatkan 50 Segil Hitam"
  },
  Event_7415_Desc = {
    Text = "Sepucuk surat lain jatuh di depanmu, kertas surat yang tergores membuat hati terasa tenggelam. Lalu kau angkat kertas surat itu. \n\"Itu datang lagi, semua yang kuperkirakan bukanlah kebohongan! @4 Semuanya dimulai dari sini, dan akan berakhir di sini juga.\"\n\"Aku ingin melarikan diri… aku bersembunyi di dalam lemari kayu, tanganku gemetar tak terkendali, tapi suara tubuh lengket menghantam lantai terus mendekat… aku mendengar sebuah nama! Itu dia! @5!\""
  },
  Event_7415_Name = {
    Text = "Surat permintaan bantuan lagi"
  },
  Event_74160_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74160_Desc = {
    Text = [[
"Terima kasih, kekuatan penciptaan dari Ayah akan membentuk kembali tubuh kita, memberi kita cahaya dan api abadi. 

Ketika aku mencapai akhir, aku akan memberkati namamu di hadapan Ayah."

Fatamorgananya perlahan memudar, dan suara musik suci berubah menjadi angin yang meraung tanpa ampun.]]
  },
  Event_74160_Name = {
    Text = "Doa Pemain Organ"
  },
  Event_74161_ChoiceDesc1 = {
    Text = "[Pemakaman] Pulihkan Arg2 poin hidup [ExDesc1], pilih 1 Kartu perintah untuk dihapus."
  },
  Event_74161_ChoiceDesc2 = {
    Text = "[Doa] mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_74161_Desc = {
    Text = "Sebuah tulang belulang pucat, setengahnya terendam dalam D-lendir hitam pekat."
  },
  Event_74161_Name = {
    Text = "Tulang Luntur"
  },
  Event_74162_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74162_Desc = {
    Text = [[
Kamu melangkah langsung ke dalam kabut itu, ilusi melilit tubuhmu seperti jaring laba-laba, sentuhan dingin meresap ke dalam sumsum tulang. 
 Bisikan mereka berubah menjadi serpihan ingatan, menembus dadamu. 
 Ketika kamu melewatinya, hanya tersisa kehampaan di belakangmu, sementara di depan, bayangan kabur lainnya samar-samar muncul di dalam kabut, menunggu untuk menelan.]]
  },
  Event_74162_Name = {Text = "Abu waktu"},
  Event_74163_ChoiceDesc1 = {
    Text = "[Menghindari Fatamorgana] mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_74163_ChoiceDesc2 = {
    Text = "[Melintasi Fatamorgana] Dapatkan 1 dari 3 pilihan Relik emas, terinfeksi [(Skill.Arg1)]"
  },
  Event_74163_ChoiceDesc3 = {
    Text = "[Peroleh] Relik perak [(RelicConfig.Arg1)]"
  },
  Event_74163_Desc = {
    Text = [[
Kabut tebal seperti tirai berat, menyelimuti jalan, setiap langkah terasa seperti menginjak abu waktu. 
 Di kejauhan, dua bayangan samar muncul dan menghilang dalam kabut, seolah-olah hantu masa lalu, membisikkan cerita-cerita yang telah lama terlupakan. 
 Imajinasi yang tak terkendali kembali membentuk bayangan-bayangan menakutkan, mereka terdistorsi, menyebar, seperti pertanda masa depan yang menekanmu hingga sulit bernapas. 
 Kamu tahu, jalan di depan hanya akan semakin gelap, namun langkahmu, tidak boleh dan tidak seharusnya berhenti.]]
  },
  Event_74163_Name = {Text = "Abu waktu"},
  Event_74164_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74164_Desc = {
    Text = [[
Kamu berhasil menghindari serangan pertama Sarah yang sangat cepat. 
Selanjutnya, belum tentu akan semujur ini.]]
  },
  Event_74164_Name = {
    Text = "Kengerian kembali"
  },
  Event_74165_ChoiceDesc1 = {
    Text = "[Indikasi arah] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_74165_ChoiceDesc2 = {
    Text = "[Berdoa Bersama] Mendapatkan 1 dari 3 Orison"
  },
  Event_74165_Desc = {
    Text = [[
Suara piano dan organ saling bertautan di tengah angin kelabu. Seakan melodi yang mengandung sihir melayang di jalan-jalan kosong. 
Seorang biarawati tanpa nama berdoa di tengah alunan musik. 
"Doa sederhana tidak memerlukan upacara yang megah, Bapa yang Maha Besar akan menaburkan harapan bagi kita, sebagaimana Dia pernah memberikan ajaran penuh kesalehan kepada kita."]]
  },
  Event_74165_Name = {
    Text = "Doa Pemain Organ"
  },
  Event_74166_ChoiceDesc1 = {
    Text = "[Menghalau Monster] Pilih 1 Relik untuk diubah menjadi Relik emas [(RelicConfig.Arg1)]"
  },
  Event_74166_ChoiceDesc2 = {
    Text = "[Mengambil Bintang] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_74166_ChoiceDesc3 = {
    Text = "[Mengabaikan] Mendapatkan 25 Segil Hitam"
  },
  Event_74166_Desc = {
    Text = "Hujan meteor jatuh di menara lonceng. \n Sebuah kristal yang jernih jatuh tepat di dekat kakimu, menciptakan sebuah lubang kecil. \n Kamu masih terjebak dalam kepungan, tubuh pelarutan yang berbentuk berbeda-beda seperti bayangan yang terdistorsi, suara raungan dan teriakan tidak pernah berhenti. \n Kamu memutuskan —"
  },
  Event_74166_Name = {
    Text = "Bintang yang jatuh"
  },
  Event_74167_ChoiceDesc1 = {
    Text = "[Mengucek mata] Mendapatkan 50 Segil Hitam"
  },
  Event_74167_ChoiceDesc2 = {
    Text = "[Tutup Mata]mendapatkan 75 Segil hitam, terinfeksi[(Skill.Arg2)]"
  },
  Event_74167_Desc = {
    Text = "Kumpulan kucing hitam yang menyeramkan berkerumun di belakang Juliette, bergumam dengan nada tak dikenal, memancarkan ancaman jahat yang terselubung."
  },
  Event_74167_Name = {
    Text = "Bisikan Kucing"
  },
  Event_74168_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74168_Desc = {
    Text = [[
Kain murah terasa kasar saat disentuh, tetapi sudah dicuci dengan hati-hati hingga bersih. 
Simpanlah dengan baik dan tunggu hari ketika barang ini kembali ke pemiliknya.]]
  },
  Event_74168_Name = {
    Text = "Masker mata putih"
  },
  Event_74169_ChoiceDesc1 = {
    Text = "[Menjaga Jarak] Mendapatkan 25 Segil Hitam"
  },
  Event_74169_ChoiceDesc2 = {
    Text = "[Mengaruniakan belas kasihan] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_74169_Desc = {
    Text = [[
Mereka bergerombol datang dari bawah kakimu. 
Di antara wajah-wajah penderitaan mereka yang kabur, kau melihat bayangan dirimu sendiri yang terdistorsi. 
Apakah kau benar-benar memiliki hak untuk menghakimi mereka?]]
  },
  Event_74169_Name = {
    Text = "Refleksi Mimpi Buruk"
  },
  Event_7416_ChoiceDesc1 = {
    Text = "[Membuang Serpihan] Relik khusus, terinfeksi membawa orison: [(EnchantConfig.Arg1)]- Gejala: Kegilaan Pelarutan"
  },
  Event_7416_ChoiceDesc2 = {
    Text = "[Serpihan Penyelesaian] Tidak ada Relik khusus, terinfeksi \"(Skill.Arg1)\", memperoleh infeksi \"(Skill.Arg2)\""
  },
  Event_7416_Desc = {
    Text = [[
Tubuh pucatnya bergerak perlahan di depanmu. Dia menundukkan tubuhnya dan mengulurkan tangannya yang patah ke arahmu. Dari kedua matanya yang menyipit karena rasa sakit, mengalir air mata plester berwarna putih mati. 
 "Hanya... hanya satu bagian lagi, aku bisa..."]]
  },
  Event_7416_Name = {
    Text = "Melengkapi tubuh yang rusak"
  },
  Event_74170_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74170_Desc = {
    Text = [[
Kamu harus mencoba menyelamatkannya. 
Tapi jangan biarkan dirimu terpengaruh oleh mereka.]]
  },
  Event_74170_Name = {
    Text = "Refleksi Mimpi Buruk"
  },
  Event_74171_ChoiceDesc1 = {
    Text = "[Mengalihkan Pandangan] Meningkatkan Kesehatan Maksimum sebesar Arg1"
  },
  Event_74171_ChoiceDesc2 = {
    Text = "[Tetap Memandang] 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi 1 \"(Skill.Arg2)\""
  },
  Event_74171_Desc = {
    Text = [[
"Kedatangan terakhir telah tiba."
Jantungmu merasa tertekan, menyusut.
Nada suara Juliette yang yakin pasti mengandung beberapa daya hipnotis dan kekuatan telepati.
Apa tujuan Juliette di dimensi ini berbeda dengan Juliette yang kamu kenal di masa lalu? 
Terlalu banyak teka-teki, banyak hambatan.
Kamu mengangkat mata dan melihat Juliette, tetapi dia juga menatapmu.]]
  },
  Event_74171_Name = {
    Text = "Pandangan Akhir"
  },
  Event_74172_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74172_Desc = {
    Text = [[
Kamu mengangkat tanganmu dan mengetuk tuts piano yang tidak nyata dengan canggung. 
 Tuts piano berbunyi dengan nyaring, setiap nada seperti tetesan embun, jernih dan transparan, keterampilan bermain yang mahir tidak berasal dari ujung jarimu. 
 Dalam sekejap, kamu melihat sepasang tangan panjang yang tak terlihat menutupi punggung tanganmu, bergerak naik turun seiring dengan kemajuan permainan. 
 Waktu seolah terhenti, hingga gema terakhir dari suara piano. 
 Kamu mendengar sebuah desahan puas.]]
  },
  Event_74172_Name = {
    Text = "Sonata Kesedihan"
  },
  Event_74173_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74173_Desc = {
    Text = [[
Kesadaran yang sering berpindah tidak stabil, kamu perlu menyingkirkan gangguan yang tidak bermakna. 
 Kamu memfokuskan perhatian pada Jenkin di depanmu, dan suara gramofon pun perlahan memudar, menghilang di antara kabut.]]
  },
  Event_74173_Name = {
    Text = "Suara Aneh dari Menara Jam"
  },
  Event_74174_ChoiceDesc1 = {
    Text = "[Mencari Sumber Suara] Mendapatkan Relik Perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_74174_ChoiceDesc2 = {
    Text = "[Kenangan] Semua Pembangun pulih 50 Aliemus, terinfeksi [(Skill.Arg1)]"
  },
  Event_74174_ChoiceDesc3 = {
    Text = "[Abaikan Kebisingan] Dapatkan 1 dari 3 Orison"
  },
  Event_74174_Desc = {
    Text = [[
Kamu mendengar suara jarum gramofon yang terdistorsi. 
 Jarum yang melengkung bergerak melewati alur spiral yang rusak, menghasilkan getaran mengerikan yang membuat bulu kuduk merinding.]]
  },
  Event_74174_Name = {
    Text = "Suara Aneh dari Menara Jam"
  },
  Event_74175_ChoiceDesc1 = {
    Text = "[Bermain untuknya] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_74175_ChoiceDesc2 = {
    Text = "[Mendengarkan suara piano] Untuk setiap Pembangun dengan nilai Aliemus 50 atau lebih, dapatkan 15 Segil hitam."
  },
  Event_74175_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 1 dari 3 pilihan Orison"
  },
  Event_74175_Desc = {
    Text = [[
"Dear John:
    Akhir-akhir ini, saya tiba-tiba menyadari bahwa sudah beberapa tahun sejak terakhir kali kamu memainkan piano untuk kami.
    Saya sekarang berusia 81 tahun. Semakin bertambah usia saya, semakin saya menyadari betapa berharganya kenangan di masa muda.
    Jika kamu menerima surat ini, lain kali saat kamu melewati Londinium, tolong berhenti di apartemen saya dan mainkan satu lagu, ya."]]
  },
  Event_74175_Name = {
    Text = "Sonata Kesedihan"
  },
  Event_74176_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74176_Desc = {
    Text = [[
Keinginan untuk bertahan hidup bergetar di dalam dadamu, dan kamu tanpa ragu mengeluarkan perintah. 
 Menunggu kamu menerobos keluar, ketika kamu menoleh, bintang itu sudah ditenggelamkan oleh Lumpur Hitam. 
 Di dalam Lumpur Hitam yang bergejolak, terdengar serangkaian suara tajam yang teratur. 
 Kamu menyentuh permukaan Lumpur Hitam, sebuah bintang yang membusuk jatuh ke telapak tanganmu.]]
  },
  Event_74176_Name = {
    Text = "Bintang yang jatuh"
  },
  Event_74177_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74177_Desc = {
    Text = [[
Kamu mengambil bintang itu, namun ia kehilangan cahaya di telapak tanganmu. 
 Sebuah rasa tertekan tiba-tiba datang, dan hawa dingin membuat punggungmu merinding. 
 Dalam sekejap antara hidup dan mati, kamu menghindar dengan menyamping, berhasil menghindari satu serangan ganas, tetapi masih meninggalkan goresan sepanjang dua inci di lenganmu.]]
  },
  Event_74177_Name = {
    Text = "Bintang yang jatuh"
  },
  Event_74178_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74178_Desc = {
    Text = [[
Gigi tajam yang tersembunyi di dalam tentakel merobek lengan bajumu, plasma darah mengalir deras seperti aliran merah tua, mengalir di sepanjang tulang pergelanganmu. 
 Kau tidak bisa membedakan tatapan Sarah, tetapi kepala yang pecah itu samar-samar mengeluarkan jeritan yang bergetar karena sakit.]]
  },
  Event_74178_Name = {
    Text = "Kengerian kembali"
  },
  Event_74179_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74179_Desc = {
    Text = [[
Kamu melihat sekeliling, bergerak ke kiri dan ke kanan, suara itu seperti tikus yang bermain petak umpet denganmu, kadang di kiri, kadang di kanan, kadang jauh, kadang dekat. 
 Kamu berputar-putar, tetapi suara semakin bising, suara gesekan logam membuatmu semakin tidak nyaman. 
 Tiba-tiba kamu teringat, meraba-raba saku, meskipun tidak menemukan sumber suara, kamu menemukan sebuah benda kecil yang berharga.]]
  },
  Event_74179_Name = {
    Text = "Suara Aneh dari Menara Jam"
  },
  Event_7417_ChoiceDesc1 = {
    Text = "[Keluar] Anda kehilangan(Arg1) poin Hidup, terinfeksi [(Skill.Arg2)]"
  },
  Event_7417_Desc = {
    Text = [[
"Anak baik. Namun, aku tetap harus memberikan hukuman kecil padamu."
Tawa ringan Dafude'er memudar di celah Dimensi.]]
  },
  Event_7417_Name = {
    Text = "Waktu Petunjuk"
  },
  Event_74180_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74180_Desc = {
    Text = [[
Kamu mengalihkan pandangan, menghindari kontak dengannya. 
Namun, ada semacam kekuatan yang masih membuat jantungmu berdetak kencang dengan gelisah.]]
  },
  Event_74180_Name = {
    Text = "Pandangan Akhir"
  },
  Event_74181_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74181_Desc = {
    Text = [[
Juliette bertatapan denganmu. 
 Detik berikutnya, dia menunjukkan senyuman penuh kegilaan, seolah-olah mengejek kesombongan dan ketidaktahuanmu. 
 Namun senyuman itu segera menghilang, orang lain pun tidak menunjukkan reaksi... seolah-olah itu hanya bayanganmu.]]
  },
  Event_74181_Name = {
    Text = "Pandangan Akhir"
  },
  Event_7418_ChoiceDesc1 = {
    Text = "[Mendapatkan Relik 1, memperoleh Relik emas \"(RelicConfig.Arg1)\"]"
  },
  Event_7418_ChoiceDesc2 = {
    Text = "[Misi Relik 2, dapatkan Relik emas \"(RelicConfig.Arg1)\"]"
  },
  Event_7418_ChoiceDesc3 = {
    Text = "[Acak 1 kartu perintah mendapatkan Orison:[(EnchantConfig.Arg1)]"
  },
  Event_7418_Desc = {
    Text = "Acara 254 (dalam pengembangan), bukan efek akhir"
  },
  Event_7418_Name = {
    Text = "Acara 254 (dalam pengembangan)"
  },
  Event_7419_ChoiceDesc1 = {
    Text = "[Menyerahkan Orison Khusus 1, acak 1 kartu perintah untuk mendapatkan Orison:\"(EnchantConfig.Arg1)\"]"
  },
  Event_7419_ChoiceDesc2 = {
    Text = "[Menyerahkan Orison Khusus 2, acak 1 kartu perintah untuk mendapatkan Orison:\"(EnchantConfig.Arg1)\"]"
  },
  Event_7419_ChoiceDesc3 = {
    Text = "[Infeksi \"(Skill.Arg1)\" dan \"(Skill.Arg2)\", dapatkan Relik emas \"(RelicConfig.Arg3)\"]"
  },
  Event_7419_Desc = {
    Text = "Acara 255 (dalam pengembangan), bukan efek akhir"
  },
  Event_7419_Name = {
    Text = "Acara 255 (dalam pengembangan)"
  },
  Event_7420_ChoiceDesc1 = {
    Text = "[Hindari Kartu Kupu-kupu] Hapus 2 Kartu"
  },
  Event_7420_ChoiceDesc2 = {
    Text = "[Memeluk Kupu-Kupu] mendapatkan Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7420_ChoiceDesc3 = {
    Text = "[Pergi]mendapatkan Arg1 Segil hitam"
  },
  Event_7420_Desc = {
    Text = [[
Sebuah tikungan, satu tikungan lagi, jalan mengejar Anjing neraka seolah tak ada habisnya. 
 Pergelangan kaki yang nyeri, otak yang membengkak, dalam kekacauan kamu melihat kupu-kupu lagi, kamu tahu itu adalah pikiran gila, Delirium dari Domain. Mereka terbang dari segala arah.]]
  },
  Event_7420_Name = {
    Text = "Aliran Delusi"
  },
  Event_7421_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7421_Desc = {
    Text = "Kamu dengan lembut menyentuh angin lonceng. Suara lonceng berbunyi beberapa kali sebelum akhirnya terdiam. Itu telah menghilang — hanya akan kembali lagi dalam mimpi buruk."
  },
  Event_7421_Name = {
    Text = "Lonceng Angin Kecil"
  },
  Event_7422_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7422_Desc = {
    Text = "Suara bel berbunyi beberapa kali sebelum akhirnya jatuh ke dalam kesunyian. Itu telah menghilang — hanya akan kembali lagi di dalam mimpi buruk."
  },
  Event_7422_Name = {
    Text = "Lonceng Angin Kecil"
  },
  Event_7423_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7423_Desc = {
    Text = [[
"Tidak buruk, kamu sangat berhati-hati."
Dari dalam lonceng angin tiba-tiba terdengar suara yang jauh.
"Kehati-hatian akan memberimu sedikit hadiah kecil, tapi hanya sampai di situ saja."]]
  },
  Event_7423_Name = {
    Text = "Lonceng Angin Kecil"
  },
  Event_74245_ChoiceDesc1 = {
    Text = "[Peroleh] Relik perak [(RelicConfig.Arg1)]"
  },
  Event_74245_Desc = {
    Text = [[
Gulir gulir, dadu berjingkrak dengan penuh semangat di dalam cangkir dadu, menari hingga kelelahan total.

"Kamu kalah. Namun, sebagai imbalan karena telah menemani saya bermain, kamu tetap bisa mendapatkan hadiah."]]
  },
  Event_74245_Name = {Text = "Pesan N"},
  Event_74246_ChoiceDesc1 = {
    Text = "[Tutup gerbang] Infeksi \"(Skill.Arg1)\", 1 kartu perintah acak mendapatkan orison: \"(EnchantConfig.Arg2)\""
  },
  Event_74246_ChoiceDesc2 = {
    Text = "[Mundur tergesa-gesa] Infeksi \"(Skill.Arg1)\", 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg2)\""
  },
  Event_74246_ChoiceDesc3 = {
    Text = "[Abaikan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_74246_Desc = {
    Text = "Kamu terjebak dalam labirin yang dibangun dari uap dan roda gigi, pipa kuningan melingkar di atas kepalamu seperti jaring laba-laba, setiap tarikan napas mengaduk kabut minyak mesin yang kental. \n Panel jam yang tidak terkendali berkedut di dinding, jarum jam mengoyak skala dan memercikkan percikan api, seperti kunang-kunang yang sekarat di laboratorium Victoria. Sambungan paku keling mengeluarkan karat tembaga, seperti luka busuk dari raksasa baja ini, sementara jam saku milikmu telah berhenti berdetak—waktu di sini hanyalah orison dari gigi roda yang saling menggigit."
  },
  Event_74246_Name = {
    Text = "Kota Labirin Uap"
  },
  Event_74247_ChoiceDesc1 = {
    Text = "[Judikan] Infeksi [(Skill.Arg1)], masuk ke dalam permainan judi"
  },
  Event_74247_ChoiceDesc2 = {
    Text = "[Lebih baik tidak] mendapatkan 25 Segil hitam"
  },
  Event_74247_Desc = {
    Text = [[
Di sudut jalan, kabut hitam yang dalam menyebarkan aroma yang membuat napas terasa sesak.
Di dalam kabut, dua dadu kuno dan dingin perlahan muncul, permukaannya dipenuhi dengan simbol-simbol yang tak terbaca dan pola-pola aneh.
Mereka berbaring diam di atas Tablet yang licin dan basah, seolah-olah menunggu pemanggilan yang tidak jelas.
"Kamu tahu siapa aku. Mau bertaruh?"]]
  },
  Event_74247_Name = {Text = "Pesan N"},
  Event_74248_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74248_Desc = {
    Text = "\"Aku bermimpi tentang bencana yang melanda segalanya, menenggelamkan kemuliaan masa lalu. Aku merasa marah terhadap kehidupan, dan lebih lagi, merasa putus asa terhadap masa depan yang tanpa harapan. Jiwaku sobek oleh ketakutan, semoga di saat-saat hancur ini, kalian bisa waspada, jangan biarkan nasib mengerikan ini menimpa.\""
  },
  Event_74248_Name = {
    Text = "Kata-kata Terakhir yang Tidak Masuk Akal"
  },
  Event_74249_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74249_Desc = {
    Text = [[
Asap hitam bergetar dengan kekecewaan. 
Kemudian dadu menghilang dalam sekejap mata. 

Hanya satu pertanyaan yang tersisa di benakmu: 
Apa sebenarnya bahan penyusun dadu-dadu ini?]]
  },
  Event_74249_Name = {Text = "Pesan N"},
  Event_7424_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7424_Desc = {
    Text = [[
Kamu berbalik dan melihat sepasang sepatu kulit, serta bayangan samar berbentuk manusia. 
Sepertinya ini adalah seorang pria muda yang terhormat. 
"Maaf mengganggu, apakah kamu pernah melihat sepasang sepatu kulit oxford berwarna hitam?"
"Di depanmu ada sepasang."
"Tidak, tidak... Ini terbuat dari kulit kambing, bukan kulit sapi. 
Aku sudah terjebak di museum lilin ini selama dua belas tahun, pasti karena sepatunya tidak sesuai..."
Suara itu bergumam, lalu perlahan memudar.]]
  },
  Event_7424_Name = {
    Text = "langkah kaki"
  },
  Event_74250_ChoiceDesc1 = {
    Text = "[Membedakan suara pria] Dapatkan 3 Kartu Perintah secara acak dari dek dan pilih 1 untuk disalin."
  },
  Event_74250_ChoiceDesc2 = {
    Text = "[Membedakan Suara Wanita] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_74250_ChoiceDesc3 = {
    Text = "[Membedakan suara orang tua] Mendapatkan 25 Segil hitam"
  },
  Event_74250_Desc = {
    Text = [[
Kamu berdiri sendirian di tengah rawa kegelapan. 
 Dalam kabut samar, kamu mendengar suara delirium yang bersilangan dalam Chaos datang seperti gelombang, beberapa berasal dari lansia yang sudah lanjut usia, beberapa berasal dari anak-anak yang baru belajar berbicara, beberapa berasal dari wanita yang gelisah, dan beberapa berasal dari pria yang tak berdaya dalam Ketakutan......]]
  },
  Event_74250_Name = {
    Text = "Kata-kata Terakhir yang Tidak Masuk Akal"
  },
  Event_74251_ChoiceDesc1 = {
    Text = "[Maju] Dapatkan 3 Kartu Perintah secara acak dari dek, pilih 1 kartu untuk dihapus, dan dapatkan 75 Segil Hitam."
  },
  Event_74251_ChoiceDesc2 = {
    Text = "[Isi tenaga] Dapatkan 3 kartu perintah secara acak dari dek, pilih 1 salinan asli kartu untuk masuk ke dek, dan dapatkan 25 segil hitam."
  },
  Event_74251_ChoiceDesc3 = {
    Text = "[Menoleh Kembali] Mendapatkan 50 Segil Hitam"
  },
  Event_74251_Desc = {
    Text = [[
Kamu berjalan di jalan yang kosong, langkahmu menimbulkan bekas yang dalam di atas abu. 

Jalan-jalan kota seperti jaring laba-laba, dan kamu adalah ngengat yang terjerat.]]
  },
  Event_74251_Name = {
    Text = "Kota Bayangan"
  },
  Event_74252_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74252_Desc = {
    Text = "Saat gerbang uap tertutup dengan gemuruh, kau mendengar bayanganmu sendiri sedang dihancurkan perlahan oleh ulir-ulir presisi yang saling terkait."
  },
  Event_74252_Name = {
    Text = "Kota Labirin Uap"
  },
  Event_74253_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74253_Desc = {
    Text = "Pemandangan yang berulang terus-menerus diperbarui di depan mata, kamu tak punya jalan untuk melarikan diri."
  },
  Event_74253_Name = {
    Text = "Kota Labirin Uap"
  },
  Event_74254_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74254_Desc = {
    Text = "Waktu adalah koordinat yang tak berguna, yang kau harapkan hanyalah kebenaran."
  },
  Event_74254_Name = {
    Text = "Kota Labirin Uap"
  },
  Event_74255_ChoiceDesc1 = {
    Text = "[Tiga Poin]"
  },
  Event_74255_ChoiceDesc2 = {Text = "[Enam]"},
  Event_74255_ChoiceDesc3 = {
    Text = "[Satu Titik]"
  },
  Event_74255_Desc = {
    Text = "Siapa yang berani melempar dadu yang berarti kesialan dan kegilaan ini?\nKamu, tentu saja kamu.\nKamu memilih——"
  },
  Event_74255_Name = {Text = "Pesan N"},
  Event_74256_ChoiceDesc1 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_74256_Desc = {
    Text = [[
Gulir gulir, dadu berjingkrak dengan penuh semangat di dalam cangkir dadu, menari hingga kelelahan total.

"Kamu kalah. Namun, sebagai imbalan karena telah menemani saya bermain, kamu tetap bisa mendapatkan hadiah."]]
  },
  Event_74256_Name = {Text = "Pesan N"},
  Event_74257_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74257_Desc = {
    Text = [[
Jalan yang datang adalah kegelapan yang tak ada habisnya dan kekacauan yang tak terhingga.
Tidak ada waktu untuk mempertimbangkan nasibmu, kamu harus menghilangkan rasa takut, dan mencapai tujuanmu sebelum keputusan datang.]]
  },
  Event_74257_Name = {
    Text = "Kota Bayangan"
  },
  Event_74258_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74258_Desc = {
    Text = "\"Ketika aku duduk di bawah bayangan waktu, aku merasakan telapak tangan dingin kematian semakin mendekat. Dunia di luar jendela menjadi semakin redup, dipenuhi dengan bisikan-bisikan bencana. Aku takut akan penghakiman yang akan datang, pembalasan atas kebodohan kami. Jalanan dipenuhi dengan aura yang tidak menguntungkan, aku khawatir hari penghakiman kita akan segera tiba. Peradaban kita goyah, seolah-olah akan dilahap oleh kehancuran, terperangkap dalam kesombongan bodoh kita sendiri.\""
  },
  Event_74258_Name = {
    Text = "Kata-kata Terakhir yang Tidak Masuk Akal"
  },
  Event_74259_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74259_Desc = {
    Text = [[
Melarikan diri dari kematian sudah cukup sulit, kamu tidak seharusnya menuntut lebih. 
 Puing-puing dan bayangan reruntuhan masih memanggilmu.]]
  },
  Event_74259_Name = {
    Text = "Kota Bayangan"
  },
  Event_7425_ChoiceDesc1 = {
    Text = "[Pergi] Mendapatkan 1 dari 3 pilihan Orison"
  },
  Event_7425_Desc = {
    Text = [[
"Begitu ya... sangat menarik."
Dia menarik kembali kuesioner itu dan menunjuk ke arah anak-anak yang pergi. Kamu segera berlalu, hampir tidak mendengar bisikan pelan di belakangmu.
"Aku menantikan pertemuan kita berikutnya."]]
  },
  Event_7425_Name = {
    Text = "Evaluasi psikologis"
  },
  Event_74260_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74260_Desc = {
    Text = [[
Kamu berada di bawah kendali kekuatan besar atau takdir yang kuat. 
 Istirahat sejenak tidak dapat mengubah situasi ini, tetapi setidaknya bisa memberikan dorongan bagi kedua kaki yang lelah untuk terus maju.]]
  },
  Event_74260_Name = {
    Text = "Kota Bayangan"
  },
  Event_74261_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_74261_Desc = {
    Text = "\"…Kota bukan lagi pelabuhan hangat, melainkan kuburan rahasia yang menumbuhkan teror dan keputusasaan. Mimpi-mimpi yang dulu begitu hidup, kini hanya tersisa serpihan ketakutan. Aku tak bisa lagi berpura-pura tidak takut, dunia di depan mata bagaikan mimpi buruk yang tak bisa kubangkitkan diri darinya.\""
  },
  Event_74261_Name = {
    Text = "Kata-kata Terakhir yang Tidak Masuk Akal"
  },
  Event_74262_ChoiceDesc1 = {
    Text = "[Peroleh] Relik emas [(RelicConfig.Arg1)]"
  },
  Event_74262_Desc = {
    Text = [[
Gulir gulir, dadu berjingkrak dengan penuh semangat di dalam cangkir dadu, menari hingga kelelahan total.

"Kamu kalah. Namun, sebagai imbalan karena telah menemani saya bermain, kamu tetap bisa mendapatkan hadiah."]]
  },
  Event_74262_Name = {Text = "Pesan N"},
  Event_7426_ChoiceDesc1 = {
    Text = "[Keluar] 1 Kartu perintah acak mendapatkan Orison: Cermin"
  },
  Event_7426_Desc = {
    Text = [[
"Tidak apa-apa, aku sudah melihat jawabannya di matamu. Aku masih punya beberapa urusan yang harus diselesaikan, jadi aku akan undur diri untuk sementara. Kamu juga punya hal yang harus ditangani, kan? Lihat ke sana, ada orang yang mencarimu."
Kamu menoleh, dan sosok dari Gereja Penerang Kuil muncul di ujung jalan.]]
  },
  Event_7426_Name = {
    Text = "Teman Perjalanan Aneh V"
  },
  Event_7427_ChoiceDesc1 = {
    Text = "[Keluar] 1 Kartu perintah acak mendapatkan Orison: Perhitungan"
  },
  Event_7427_Desc = {
    Text = [[
"Tampaknya kamu masih belum mau membuka hati padaku. Aku kecewa, tapi tidak apa-apa, aku tetap akan memberikanmu petunjuk yang paling ramah: Gereja Penerang Kuil muncul di sini, sebenarnya mereka mencari apa?"
"Ah, sepertinya ada orang yang tidak ingin kita mengobrol terlalu lama. Lihat ke sana, ada orang yang datang menjemputmu."
Kamu menoleh, dan sosok Penerang Cahaya Kuil muncul di ujung jalan.]]
  },
  Event_7427_Name = {
    Text = "Teman Perjalanan Aneh V"
  },
  Event_7428_ChoiceDesc1 = {
    Text = "[Keluar] 1 Kartu Perintah acak mendapatkan Orison: Inspirasi"
  },
  Event_7428_Desc = {
    Text = [[
"Kamu sangat jujur, pantas mendapat pujian. Jadi, aku memutuskan memberimu sedikit petunjuk: kenapa begitu kamu tiba di Kota Rai, Dia langsung mengincarmu?"
"Ah, sepertinya ada yang tidak ingin kita mengobrol santai. Lihat ke sana, seseorang datang untukmu."
Kamu menoleh, sosok Penerang Cahaya Kuil muncul di ujung jalan.]]
  },
  Event_7428_Name = {
    Text = "Teman Perjalanan Aneh V"
  },
  Event_7429_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7429_Desc = {
    Text = "Suara yang kacau secara bertahap mereda, tanganmu kosong, namun emosi sesaat itu telah tercatat oleh Kunci perak."
  },
  Event_7429_Name = {Text = "Buku Nihil"},
  Event_7430_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7430_Desc = {
    Text = "Di tengah kekacauan, kamu mengulurkan tangan dan meraba-raba sembarangan. Di antara kekacauan tersebut, ada sesuatu dengan tekstur aneh yang jatuh ke tanganmu, lalu perlahan-lahan terbentuk menjadi sebuah objek."
  },
  Event_7430_Name = {Text = "Buku Nihil"},
  Event_7431_ChoiceDesc1 = {
    Text = "[Pergi] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7431_Desc = {
    Text = [[
"Apakah kamu pernah mendengar cara ular berburu? Ular hanya bisa merayap di tanah, merangkak dengan gerakan berliku, jadi mereka tidak bisa mengejar mangsa seperti cheetah, atau mengelilingi mangsa seperti serigala. Sebagai gantinya, ular belajar untuk diam dan menunggu."
"Mereka menunggu saat mangsa lengah, lalu melancarkan serangan mendadak, menyerang dan langsung menelan mangsa dalam sekali gigit."]]
  },
  Event_7431_Name = {
    Text = "Teman Perjalanan Aneh III"
  },
  Event_7432_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7432_Desc = {
    Text = "Sepertinya terganggu, bulu hitam yang berkilauan itu hanya meninggalkan sedikit rasa terbakar di ujung jari Anda, lalu menghilang ke dalam kedalaman Kabut."
  },
  Event_7432_Name = {
    Text = "Malapetaka Kucing Malam"
  },
  Event_7433_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7433_Desc = {
    Text = "Tidak lebih dari omong kosong absurd dari para penganut Kegilaan yang bodoh dan tidak masuk akal."
  },
  Event_7433_Name = {
    Text = "Kode Rahasia·Bawah"
  },
  Event_7434_ChoiceDesc1 = {
    Text = "[Melanjutkan Mendengarkan] Mendapatkan 1 dari 3 Orison"
  },
  Event_7434_ChoiceDesc2 = {
    Text = "[Batuk keras] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7434_Desc = {
    Text = [[
Sudut dinding retak dengan banyak celah halus, menjalar seperti pembuluh darah. 
Dengan suara dengungan kecil, kamu mendengar suara rendah seorang pria dari sisi lain. 
"Quintin District 5, Wellington District 10, Norman District 15... 
Bahan bulan ini sudah dimuat semua, bersiap untuk berangkat, nomor pengiriman I-0234... 
... 
Lagipula, berkat kelompok Mythag itu, White Chapel District saat ini dalam keadaan darurat militer, kita kehilangan sumber bahan terbesar kita."]]
  },
  Event_7434_Name = {
    Text = "Dinding memiliki telinga"
  },
  Event_7435_ChoiceDesc1 = {
    Text = "[Mengusir Gagak]mendapatkan 20 Segil hitam, terinfeksi[(Skill.Arg2)]"
  },
  Event_7435_ChoiceDesc2 = {
    Text = "[Mengejar anak lagi] Pergi"
  },
  Event_7435_Desc = {
    Text = "Di bawah ancamanmu, semua gagak terbang ke segala arah dengan suara gemerisik. Sayap hitam mereka yang jatuh berubah menjadi cairan kental, menetes membentuk pola Segil hitam."
  },
  Event_7435_Name = {
    Text = "Pandangan Burung Gagak Hitam"
  },
  Event_7436_ChoiceDesc1 = {
    Text = "[Menyerah melawan] Hapus 1 Kartu Perintah, dapatkan Arg1 Segil Hitam"
  },
  Event_7436_ChoiceDesc2 = {
    Text = "[Mengembalikan kedua tangan]"
  },
  Event_7436_Desc = {
    Text = [[
Sebuah mesin tik modern. 
 Ia memiliki satu set tombol huruf yang berbeda, terlihat megah dan rumit seperti mikroskop. 
 Kamu penasaran meletakkan tanganmu di atasnya, namun mendapati bahwa tanganmu bergerak tak terkendali, melompat-lompat di atas papan ketik dengan semakin cepat, semakin cepat...]]
  },
  Event_7436_Name = {
    Text = "Ledakan Inspirasi"
  },
  Event_7437_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7437_Desc = {
    Text = [[
Hanyalah makhluk yang berjuang untuk bertahan hidup, mencari sepotong kayu apung untuk beristirahat saja...
Kamu menghela napas, lalu membiarkan cairan hitam dari ekor kupu-kupu mengalir ke pipi.]]
  },
  Event_7437_Name = {
    Text = "Kupu-kupu Cairan Hitam"
  },
  Event_7438_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7438_Desc = {
    Text = "Kamu menerima permintaan kontak dari sekolah, suara yang familiar membuatmu merasa tenang. Kamu mengumpulkan Roh dan melanjutkan langkah."
  },
  Event_7438_Name = {
    Text = "Persimpangan"
  },
  Event_7439_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7439_Desc = {
    Text = "Kamu menerima permintaan kontak dari sekolah, suara yang familiar membuatmu merasa tenang. Kamu mengumpulkan Roh dan melanjutkan langkah."
  },
  Event_7439_Name = {
    Text = "Persimpangan"
  },
  Event_7440_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7440_Desc = {
    Text = "Keraguanmu melayang di udara, tanpa jawaban. Cahaya kuning hangat menembus dari luar jendela, memberikan kehangatan seperti kenangan."
  },
  Event_7440_Name = {
    Text = "Pengingat Gunung Berapi"
  },
  Event_7441_ChoiceDesc1 = {
    Text = "[Mengambil] Terinfeksi \"(Skill.Arg1)\", memperoleh Relik perak \"(RelicConfig.Arg2)\""
  },
  Event_7441_ChoiceDesc2 = {
    Text = "[ Ragu ] Mendapatkan 25 Segil hitam"
  },
  Event_7441_Desc = {
    Text = "Di dalam tong kayu di sudut gang, terdapat sebuah benda berwarna aneh yang mengapung. Kehadiran yang tidak biasa ini tampaknya memperingatkanmu, \"Jangan disentuh\"."
  },
  Event_7441_Name = {
    Text = "Objek Mengapung di Dalam Ember"
  },
  Event_7442_ChoiceDesc1 = {
    Text = "[Serahkan padanya] Dapatkan 1 dari 3 Relik Perak"
  },
  Event_7442_ChoiceDesc2 = {
    Text = "[Ada sedikit situasi] Memperoleh Relik perak \"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\", terinfeksi dua kali \"(Skill.Arg3)\""
  },
  Event_7442_Desc = {
    Text = "\"Ini adalah komunikasi dari Mythag, saya Erica. Terdeteksi fluktuasi Indeks gnostik abnormal pada Pembangun Lotan, apakah memerlukan bantuan?\""
  },
  Event_7442_Name = {
    Text = "Komunikasi Dukungan"
  },
  Event_7443_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7443_Desc = {
    Text = "Kamu menuruti bujukan tidak bermaksud baik yang berbisik di telingamu, jeritan seperti ujung jarum yang berputar menusuk ke dalam lubang telingamu.\n\"Berhenti — cepat berhenti — aku sudah melakukan apa yang kamu katakan — cepat berhenti —\"\nKamu menutup kepalamu dengan kesakitan, dalam keadaan setengah sadar kamu mendengar ejekan kawanan gagak."
  },
  Event_7443_Name = {
    Text = "Lagu Dari Gerombolan Gagak"
  },
  Event_7444_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7444_Desc = {
    Text = "Ditempatkan di posisi ini, ada dua kemungkinan: sesuatu yang diabaikan atau sesuatu yang sangat dihargai. Jika itu adalah yang terakhir, lebih baik biarkan pemilik aslinya yang menyimpannya."
  },
  Event_7444_Name = {
    Text = "Perak Kesepian"
  },
  Event_7445_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7445_Desc = {
    Text = "Yang paling bahagia adalah mereka yang berada dalam kebodohan."
  },
  Event_7445_Name = {
    Text = "Melihat secara diam-diam"
  },
  Event_7446_ChoiceDesc1 = {
    Text = "[Monster Biasa]"
  },
  Event_7446_ChoiceDesc2 = {
    Text = "[Generasi petak kosong]"
  },
  Event_7446_ChoiceDesc3 = {
    Text = "[Generasi Kekosongan]"
  },
  Event_7446_Desc = {
    Text = "Lihat apa yang dapat dihasilkan"
  },
  Event_7446_Name = {
    Text = "[Menunggu pengemasan]"
  },
  Event_7447_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7447_Desc = {
    Text = [[
"Tenang," Ramona mengetuk kepalamu, "hanya fragmen dari masa lalu. Entah siapa yang menjatuhkannya di lorong dimensi ini."
Memang, ada aroma rindu.]]
  },
  Event_7447_Name = {
    Text = "Fragmen Kenangan·Whisky"
  },
  Event_7448_ChoiceDesc1 = {
    Text = "[Kumpulkan] Tingkatkan 1 Relik Perak menjadi Relik Emas [(RelicConfig.Arg1)]"
  },
  Event_7448_ChoiceDesc2 = {
    Text = "[Membuangnya] mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\" serta \"(Skill.Arg3)\""
  },
  Event_7448_ChoiceDesc3 = {
    Text = "[Amati dengan cermat] Mendapatkan 25 Segil hitam"
  },
  Event_7448_Desc = {
    Text = [[
Di sini ada banyak inti perak yang retak.
Kusam, pecah... jelas bukan barang berkualitas tinggi.
Mungkin salah satu alasan patung lilin ini bisa "hidup" adalah karena mereka.
Bahkan inti perak yang paling kasar pun memiliki kemungkinan untuk menciptakan keajaiban.]]
  },
  Event_7448_Name = {
    Text = "Jiwa yang Terikat"
  },
  Event_7449_ChoiceDesc1 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_7449_Desc = {
    Text = [[
Khum telah memberikan segalanya yang bisa dia berikan. 
 Selanjutnya, giliranmu untuk memastikan pengorbanannya tidak sia-sia.]]
  },
  Event_7449_Name = {Text = "Sisa Panas"},
  Event_7450_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7450_Desc = {
    Text = "Semoga angin dan salju memberikan kalian ketenangan abadi."
  },
  Event_7450_Name = {
    Text = "Relik dari Orang Terdahulu"
  },
  Event_7451_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7451_Desc = {
    Text = [[
Kau masih tampak gigih, dalam nyanyianmu kau masih bisa mengikuti dirimu sendiri. 
 Kau tidak percaya pada bisikan di telingamu, satu-satunya yang kau andalkan adalah rasionalitas manusia. 
 Namun... pada hari ketika tanah yang kokoh yang kau andalkan diselimuti oleh cairan hitam yang kental, mencungkil bola mata sebagai objek pengintai akan menjadi satu-satunya pilihanmu saat menjelang akhir.]]
  },
  Event_7451_Name = {
    Text = "Lagu Dari Gerombolan Gagak"
  },
  Event_7452_ChoiceDesc1 = {
    Text = "[Keluar] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7452_Desc = {
    Text = "Kuum ditarik olehmu secara tiba-tiba, berhasil menghindari serangan itu dengan susah payah. Dia mengangguk padamu sebagai tanda terima kasih, lalu kembali menyerbu ke arah tubuh eksperimen."
  },
  Event_7452_Name = {Text = "Koloseum"},
  Event_7453_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7453_Desc = {
    Text = [[
Ding ding dang dang...
Koin jatuh ke dalam dompet, mengeluarkan gema yang nyaring dan menyenangkan. 
Dompet itu dengan puas mengunyah, lalu akhirnya bersendawa. 
Ia terpesona oleh kemurahan hatimu, melepaskan semua pertahanannya terhadapmu. 
Sekarang, ia akan digunakan untukmu.]]
  },
  Event_7453_Name = {
    Text = "Dompet rakus"
  },
  Event_7454_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7454_Desc = {
    Text = [[
Koin kuningan jatuh seperti terjun ke jurang tanpa dasar, tak bersuara sedikit pun.
Kamu dengan sabar menunggu selama lima menit. Dompet itu mengeluarkan erangan kesakitan, lalu akhirnya memuntahkan seonggok cairan hitam kental.
Ini adalah bentuk protesnya yang tak bersuara.]]
  },
  Event_7454_Name = {
    Text = "Dompet rakus"
  },
  Event_7455_ChoiceDesc1 = {
    Text = "[Melihat ke kejauhan]"
  },
  Event_7455_ChoiceDesc2 = {
    Text = "[Mendengarkan dengan cermat]"
  },
  Event_7455_Desc = {
    Text = [[
Celeste menggoyangkan kompas di tangannya. Dia tidak berbicara, namun nyanyian samar terdengar di sekitarnya. 
 Nyanyian pelaut melintasi waktu dan bertemu di sini. Sebuah lagu kapal yang kacau namun penuh kekuatan membimbingmu, membuatmu menoleh ke ujung lain kapal.]]
  },
  Event_7455_Name = {
    Text = "Lagu Perahu"
  },
  Event_7456_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7456_Desc = {
    Text = [[
Kamu maju untuk menginterupsi latihan pengajaran kecil ini. 
 Dari gerakan tangan saat bermain piano hingga teori musik dasar, kamu memberikan komentar tanpa ampun satu per satu. 
 Suara musik tiba-tiba berhenti, anak laki-laki dan gurunya menatapmu serentak, dengan senyuman yang sama sekali aneh di wajah mereka. 
 133, 355, 244... 
 Suara piano kembali terdengar, masih salah dengan parah. 
 Ternyata mereka tidak mendengar apa-apa.]]
  },
  Event_7456_Name = {
    Text = "Pelajaran piano"
  },
  Event_7457_ChoiceDesc1 = {
    Text = "[Dimasukkan ke dalam kantong]"
  },
  Event_7457_Desc = {
    Text = "Tanda hitam yang ditemukan di domain dapat dipersembahkan kepada D-marka untuk ditukar dengan relik atau proyeksi jiwa. Setelah meninggalkan area saat ini, itu akan segera menghilang menjadi lumpur hitam."
  },
  Event_7457_Name = {
    Text = "Segil hitam"
  },
  Event_7458_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7458_Desc = {
    Text = "Untuk saat ini, menemukan orang misterius itu lebih penting. Dengan pemikiran ini, Ramona segera berjalan cepat meninggalkan tempat tersebut."
  },
  Event_7458_Name = {
    Text = "Telinga orang lain"
  },
  Event_7459_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7459_Desc = {
    Text = "Menuruti kesadaran, mengikuti jejak doa menuju kegelapan Aequor.\nKamu melihat negara emas yang tenggelam di dasar air, melihat patung batu abadi, dan akhirnya bertatapan dengan mata berkilauan di tempat yang suram…\n\"Orang yang tidak mengalirkan darah dewa... pergi, pergi.\""
  },
  Event_7459_Name = {Text = "Doa Mimpi"},
  Event_7460_ChoiceDesc1 = {
    Text = "[Pergi] Pilih 1 Relik terkutuk, infeksi [(Skill.Arg1)]"
  },
  Event_7460_Desc = {
    Text = "Ramona menusuk leher tubuh percobaan dengan satu tusukan pedang, Kum melemparkan tubuh percobaan yang sudah kehilangan tanda-tanda hidup dan berlari menuju target berikutnya."
  },
  Event_7460_Name = {Text = "Koloseum"},
  Event_7461_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7461_Desc = {
    Text = [[
Gagak mencabik-cabik bulunya sendiri, sama seperti manusia yang menggigiti tubuhnya sendiri. 
 Di dunia penuh ketakutan ini, hal seperti itu sudah sering terjadi, kamu tidak bisa menyelamatkan semua makhluk hidup.]]
  },
  Event_7461_Name = {
    Text = "Air Mata Magma"
  },
  Event_7462_ChoiceDesc1 = {
    Text = "[Menenangkan Kum]"
  },
  Event_7462_ChoiceDesc2 = {
    Text = "[Bantu Kuum Berteriak]"
  },
  Event_7462_Desc = {
    Text = "Monster raksasa berteriak dengan sekuat tenaga ke arah manusia kecil, berusaha untuk membangun kembali teman dari masa lalu. Namun, pita suaranya yang telah rusak hanya menghasilkan suara rendah dan aneh dari tenggorokannya."
  },
  Event_7462_Name = {
    Text = "Panggilan Persahabatan"
  },
  Event_7463_ChoiceDesc1 = {
    Text = "[Keluar] Mencari lampu sorot"
  },
  Event_7463_ChoiceDesc2 = {
    Text = "[Masuki Kabut] Kehilangan Arg2 poin Hidup"
  },
  Event_7463_Desc = {
    Text = [[
Di depan terdapat kabut hitam pekat, masuk secara sembrono akan mendatangkan Clades. 
 Mungkin kamu harus menemukan "Lampu Sorot"untuk mengusir kabut tersebut.]]
  },
  Event_7463_Name = {
    Text = "tidak dikenal"
  },
  Event_7464_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7464_Desc = {
    Text = [[
"Tulang rahang yang berderak seperti dirimu? Belum pernah melihatnya seumur hidup."
Kamu menolak permintaan tidak sopan dari Tuan Rahang. Tuan Rahang sangat kecewa, namun tetap menjaga sikapnya. 
Untuk berterima kasih atas kesabaranmu mendengarkannya, dia memberikanmu sebuah Hadiah.]]
  },
  Event_7464_Name = {Text = "Berderak"},
  Event_7465_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7465_Desc = {
    Text = [[
Kamu menyetujui permintaan aneh ini dan membawa Tuan Rahang ini. 
Dia berada di saku kamu, terus-menerus berbunyi "krik krik". Menurut terjemahan temanmu, pernyataannya sebagian besar berisi rasa syukur, nostalgia, dan penyesalan. 
Adapun mengapa dia berubah menjadi seperti ini? Tuan Rahang tidak mau banyak bicara, hanya berkata: 
"Kamu tahu. Ketika kamu menatap @2, @2 juga akan balik menatapmu."]]
  },
  Event_7465_Name = {Text = "Berderak"},
  Event_7466_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7466_Desc = {
    Text = [[
Dia meluncur ke dalam tas tangan mu seperti sehelai sutra, dengan sedikit tambahan berat, seakan-akan kamu mendengar ucapan terima kasih yang pelan. 
 Setelah itu, tak ada suara lagi.]]
  },
  Event_7466_Name = {
    Text = "Roh Kekacauan"
  },
  Event_7467_ChoiceDesc1 = {Text = "[Maju]"},
  Event_7467_Desc = {
    Text = [[
Klik. 
Kamu memasukkan kunci ke dalam lubang kunci dan perlahan mendorong pintu terbuka. 
Seluruh proses membuka pintu berjalan sangat lancar, membuatmu semakin percaya diri untuk melanjutkan penyelidikan.]]
  },
  Event_7467_Name = {
    Text = "Pintu berkarat"
  },
  Event_7468_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7468_Desc = {
    Text = [[
Suara itu tertawa dalam nada berat, cairan di bawah kakimu mulai beriak. 
"Kamu akan segera mengerti, selain kematian, tidak ada yang benar-benar harus dilakukan."]]
  },
  Event_7468_Name = {
    Text = "Kamu tidak akan ingin menemukan"
  },
  Event_7469_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7469_Desc = {
    Text = "Kamu membuang memori ini, menarik kesadaranmu dari hiburan semu."
  },
  Event_7469_Name = {
    Text = "Terbenam dalam hari-hari lama"
  },
  Event_7470_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7470_Desc = {
    Text = "Hanya tidur dangkal sejenak. Jika tidak ada penghiburan, bagaimana kau akan melewati malam yang panjang ini..."
  },
  Event_7470_Name = {
    Text = "Terbenam dalam hari-hari lama"
  },
  Event_7471_ChoiceDesc1 = {
    Text = "[Mengambil foto] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7471_Desc = {
    Text = [[
Ini adalah sekelompok foto grup. 
 Orang-orang yang lesu duduk di belakang pagar besi, dengan wajah penuh kesengsaraan. 
 Salah satu foto menarik perhatianmu. Itu seharusnya seorang wanita muda yang kurus, dengan wajah yang kosong. 
 Makhluk tambahan yang sangat menghujat itu, melilit tubuhnya dengan lingkaran-lingkaran. 
 Kamu tidak bisa melihat wajahnya, tetapi dalam imajinasimu, dia seharusnya tidak memiliki ekspresi.]]
  },
  Event_7471_Name = {
    Text = "mencatat dengan jujur"
  },
  Event_7472_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7472_Desc = {
    Text = "Itu adalah sisa-sisa burung."
  },
  Event_7472_Name = {
    Text = "Kawanan Gagak Berisik"
  },
  Event_7473_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7473_Desc = {
    Text = [[
Kamu dengan dingin menolak permintaan pianis itu. 
Pianis tersebut sangat kecewa. Dia merobek telinga lainnya dan melemparkannya keluar jendela. 
"Toh aku tidak membutuhkannya."
Pianis yang penuh kesedihan menundukkan kepala dengan wajah murung, lalu memainkan serangkaian nada-nada penuh duka.]]
  },
  Event_7473_Name = {
    Text = "Berikan perhatian"
  },
  Event_7474_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7474_Desc = {
    Text = [[
Tangisan Roh Kekacauan semakin tajam, hingga akhirnya berubah menjadi teriakan menusuk telinga yang menggema di sekitar. 
 Dia membawa persembahanmu dan penderitaan yang tak terhindarkan, lalu tenggelam kembali ke dalam lumpur.]]
  },
  Event_7474_Name = {
    Text = "Roh Kekacauan"
  },
  Event_7475_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7475_Desc = {
    Text = "Ini adalah lorong satu arah, kamu tidak bisa kembali ke pintu masuk melalui lorong ini."
  },
  Event_7475_Name = {Text = "Lorong"},
  Event_7476_ChoiceDesc1 = {
    Text = "[Peroleh] Relik \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7476_Desc = {
    Text = [[
"Jika begitu, tutuplah mata Anda dan rasakan suara langkahnya yang mendekat."
Anda menutup mata sesuai instruksi, tiba-tiba terdengar suara napas makhluk aneh menggelegar di sisi telinga Anda.
Ketika Anda membuka mata dengan perasaan belum sepenuhnya pulih dari keterkejutan, pria itu telah menghilang tanpa jejak.]]
  },
  Event_7476_Name = {
    Text = "Teman Perjalanan Aneh I"
  },
  Event_7477_ChoiceDesc1 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7477_Desc = {
    Text = [[
"Sayang sekali."
Pria itu terdengar lesu saat ia menyesuaikan letak kacamatanya.
"Namun, jika kalian belum pernah mendengarnya, mengapa datang ke sini di tengah malam?"
Tanpa menunggu jawaban kalian, pria itu beringsut pergi.]]
  },
  Event_7477_Name = {
    Text = "Teman Perjalanan Aneh I"
  },
  Event_7478_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7478_Desc = {
    Text = [[
Kamu melangkah dengan teguh, terus maju. 
Satu langkah, dua langkah, tiga langkah... 
Suara langkah di belakangmu memudar ke dalam kegelapan. 
Kalian pasti akan bertemu lagi.]]
  },
  Event_7478_Name = {Text = "Oxford"},
  Event_7479_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7479_Desc = {
    Text = "Kamu sedikit membungkukkan tubuh, mengangkat nampan dari meja di sampingmu, dan berubah menjadi pengawal putri. \nAdapun siapa yang menjadi putri yang beruntung itu——tentu saja adalah partner setiamu. \n\"Beraninya menumpahkan cangkir teh ke wajahku, jangan harap bisa mendapatkan catatan kelas bulan depan.\"\nItu adalah peringatan dari sang putri padamu."
  },
  Event_7479_Name = {
    Text = "Menipu dengan kebenaran palsu"
  },
  Event_7480_ChoiceDesc1 = {
    Text = "[Secara acak meningkatkan kualitas Orison 1 Kartu]"
  },
  Event_7480_ChoiceDesc2 = {
    Text = "[Dialah Orangnya] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7480_Desc = {
    Text = [[
Teriakan Sarah bergema di dalam pikiranmu, sebuah suara halus yang terdengar agak familiar entah dari mana datangnya, berbisik lemah "Kak Sarah", "Kak Sarah". 
"Kak Sarah, di mana kamu?"]]
  },
  Event_7480_Name = {Text = "\"Kak Sasa\""},
  Event_7481_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7481_Desc = {
    Text = "\"…Saya merasa ada sedikit kebenaran dalam apa yang kamu katakan, tapi keinginan saja tidak bisa membantu menyelesaikan Tubuh yang terlulur. Lebih baik lakukan sesuatu yang praktis.\""
  },
  Event_7481_Name = {
    Text = "Aturan Logan"
  },
  Event_7482_ChoiceDesc1 = {
    Text = "[Memperoleh 100 Segil Hitam]"
  },
  Event_7482_ChoiceDesc2 = {
    Text = "[2 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\"]"
  },
  Event_7482_Desc = {
    Text = "Relik terbentuk dari Gnosis yang stabil, mungkin mereka dapat menukar dengan melodi harmoni."
  },
  Event_7482_Name = {Text = "Disonansi"},
  Event_7483_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7483_Desc = {
    Text = "\"Itu adalah Pecahan Memori dari seseorang yang pernah memasuki dimensi ini,\" jawab Ramona, \"Berjalan melintasi dimensi sangat mudah mengalami hal seperti ini. Hati-hati jangan sampai bercampur dengan ingatanmu sendiri.\""
  },
  Event_7483_Name = {
    Text = "Fragmen Kenangan·Whisky"
  },
  Event_7484_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7484_Desc = {
    Text = "Mengikuti irama detak jantung, kejarlah kilauan cahaya. Kalian tidak akan terpisahkan, sama seperti tak seorang pun bisa membedakan hari dan malam secara tepat."
  },
  Event_7484_Name = {
    Text = "Atrium kiri"
  },
  Event_7485_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7485_Desc = {
    Text = [[
Kamu terus mengelus tangan-tangan yang gelisah ini, berusaha menenangkannya. 
 Tak lama kemudian, duniamu pun menjadi benar-benar tenang. 
 Cinta selalu mendapat balasannya.]]
  },
  Event_7485_Name = {
    Text = "Bekas Rawan Gelap"
  },
  Event_7486_ChoiceDesc1 = {
    Text = "[Melawan] Tertular \"(Skill.Arg1)\", memperoleh Relik perak \"(RelicConfig.Arg2)\""
  },
  Event_7486_ChoiceDesc2 = {
    Text = "[Abandon] Infeksi \"(Skill.Arg1)\", dapatkan Relik perak \"(RelicConfig.Arg2)\""
  },
  Event_7486_ChoiceDesc3 = {
    Text = "[Peringatan] Mendapatkan 25 Segil Hitam"
  },
  Event_7486_Desc = {
    Text = [[
Kotoran mengalir ke dalam pikiranmu, perasaan asing yang sangat kotor itu terasa sangat jelas. 
 Cairan keruh yang mengeluarkan bau busuk merembes dan menguasai seluruh pikiranmu, rasa sakit memenuhi sisi wajahmu yang dipenuhi ketakutan, kamu terjebak dalam siklus mimpi buruk yang tak berujung, sulit untuk terlepas.]]
  },
  Event_7486_Name = {
    Text = "Luka di tengkorak"
  },
  Event_7487_ChoiceDesc1 = {
    Text = "[Adalah Cermin Ritual Memphis]"
  },
  Event_7487_ChoiceDesc2 = {
    Text = "[Kompas Arah]"
  },
  Event_7487_ChoiceDesc3 = {
    Text = "[Saya tidak menjatuhkan apa pun]"
  },
  Event_7487_Desc = {
    Text = [[
"Pionir yang melintasi dimensi."

Terdengar suara tua di telinga, seolah berasal dari zaman prasejarah, seolah menembus ribuan abad. 

Dalam ketegangan luar biasa, kamu mendengar suara itu mengajukan pertanyaan yang terdengar agak familiar. 

"Yang kamu jatuhkan, benda bulat ini, yang bisa membuatmu menggambar kartu di awal giliran, apa itu?"]]
  },
  Event_7487_Name = {
    Text = "Suara di Luar Dunia"
  },
  Event_7488_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7488_Desc = {
    Text = "\"Tempatku ini bukan tempat pembuangan sampah,\"gerutu Boneka sambil menerimanya, \"Ah, sudahlah, setidaknya masih bisa diekstrak sedikit yang berguna.\""
  },
  Event_7488_Name = {Text = "Plakat"},
  Event_7489_ChoiceDesc1 = {
    Text = "Orison Acak Biasa"
  },
  Event_7490_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7490_Desc = {
    Text = "Kamu membaca selembar kertas yang sudah usang dan rusak, \"Kembar\", \"Merembes\", \"Pengorbanan\", \"Tidak valid\"……\nMasih konsep-konsep yang terpecah belah dan susunan kalimat yang sulit diinterpretasikan, hanya otak yang semakin penuh yang membuktikan bahwa kamu pernah membaca selembar kertas ini."
  },
  Event_7490_Name = {
    Text = "Kode Rahasia·Bawah"
  },
  Event_7491_ChoiceDesc1 = {
    Text = "[Apakah Anda bersedia membayar harga apa pun?] Meningkatkan kualitas orison dari 1 kartu secara acak"
  },
  Event_7491_ChoiceDesc2 = {
    Text = "[Traktir Mereka Segelas Bloody Mary Kedaluwarsa] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7491_Desc = {
    Text = [[
"Selamat datang, tamu berharga saya. Silakan pilih sesuka hati, semua ini ada di sini menunggu kehadiranmu."
"Eh, maaf mengganggu, bolehkah saya bertanya, apakah Anda... saudara kembar Nyonya Narsis?"
"Saya adalah Narsis sendiri, bolehkah saya bertanya apa keperluan tamu hari ini...?"
"Maaf, maaf, Anda terlihat lebih memesona dibanding sebelumnya, sampai saya tidak mengenali Anda. Apakah Anda masih ingat? Dua puluh tahun yang lalu, Anda membantu bar saya mengusir seorang aneh... Kemarin, mimpi buruk itu kembali, ia menduduki bar bersama teman-temannya, bergerombol..."]]
  },
  Event_7491_Name = {
    Text = "Fragmen Kenangan·Mimpi Lama Kembali"
  },
  Event_7492_ChoiceDesc1 = {
    Text = "[Mengusir Gagak]mendapatkan 30 Segil hitam, terinfeksi[(Skill.Arg2)], terus memilih"
  },
  Event_7492_ChoiceDesc2 = {
    Text = "[Mengejar anak lagi] Pergi"
  },
  Event_7492_Desc = {
    Text = "Burung gagak kedua pergi, bulu ekor-Nya menampakkan sekelebat putih saat berkelebat, mirip dengan tulang belulang."
  },
  Event_7492_Name = {
    Text = "Pandangan Burung Gagak Hitam"
  },
  Event_7493_ChoiceDesc1 = {
    Text = "[Judikan] Infeksi [(Skill.Arg1)], masuk ke dalam permainan judi"
  },
  Event_7493_ChoiceDesc2 = {
    Text = "[Lebih baik tidak] mendapatkan 25 Segil hitam"
  },
  Event_7493_Desc = {
    Text = "\"Mau bertaruh? Tebak angka kami! Hanya dengan sedikit biaya!\"\nDadu-dadu yang terbuang mengeluarkan dengungan berisik, seolah-olah sedang berbicara padamu. \n\"Lemparkan aku! Lemparkan aku!\"\n\"Satu-satunya kesempatan! Yang terakhir!\"\nBaiklah, sekali saja——\nKamu mengambil sebuah chip. Kamu memutuskan——"
  },
  Event_7493_Name = {
    Text = "Perjudian Tanpa Henti"
  },
  Event_7494_ChoiceDesc1 = {
    Text = "[Melawan Pikiran Jahat] Mendapatkan Relik Perak \"(RelicConfig.Arg1)\", Terinfeksi \"(Skill.Arg2)\""
  },
  Event_7494_ChoiceDesc2 = {
    Text = "[Memeluk Pikiran Jahat] mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7494_ChoiceDesc3 = {
    Text = "[Wake Up and Leave] Mendapatkan 25 Segil Hitam"
  },
  Event_7494_Desc = {
    Text = [[
Pikiran jahat menjadi pedang, seakan-akan gigi yang tajam. 
 Mereka menggigit akal sehat yang semakin melemah di dalam Domain, melahap sisa-sisa kehendak, sama seperti perbuatan jahat yang dilakukan oleh realitas terhadapmu...]]
  },
  Event_7494_Name = {
    Text = "Pikiran Tanpa Dasar"
  },
  Event_7495_ChoiceDesc1 = {
    Text = "[Sepenuhnya Berjuang] Hapus 1 Kartu Perintah, dapatkan Arg1 Segil Hitam"
  },
  Event_7495_ChoiceDesc2 = {
    Text = "[Menghidupkan jaring laba-laba] Salin 1 Kartu perintah, infeksi [(Skill.Arg1)]"
  },
  Event_7495_ChoiceDesc3 = {
    Text = "[Tunggu dengan tenang] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7495_Desc = {
    Text = "Jalinan тонкая berputar seolah-olah jaring laba-laba mengikatmu, saat ini, kamu tiba-tiba menjadi mangsa dalam domain ini."
  },
  Event_7495_Name = {
    Text = "Terjebak dalam"
  },
  Event_7496_ChoiceDesc1 = {
    Text = "[Penerima: ∞]terinfeksi[(Skill.Arg1)]"
  },
  Event_7496_ChoiceDesc2 = {
    Text = "[Penerima: Diri Sendiri]menghapus 1 kartu"
  },
  Event_7496_ChoiceDesc3 = {
    Text = "[Penerima: Guru]mendapatkan 25 Segil hitam"
  },
  Event_7496_Desc = {
    Text = [[
Ia memberikan seorang pengembara Domain sebuah kesempatan: sebuah kesempatan untuk terhubung dengan yang tidak dikenal. 
Beberapa lembar kertas yang hancur, sebuah mesin tik yang mengeluarkan tinta, dan seorang penerima yang tidak dikenal serta satu arah. 
Kehendak mungkin dapat menentukan ke mana pesanmu dapat disampaikan...]]
  },
  Event_7496_Name = {
    Text = "Pengakuan sepihak"
  },
  Event_7497_ChoiceDesc1 = {
    Text = "[Menyetujui dengan senang hati]"
  },
  Event_7497_ChoiceDesc2 = {
    Text = "[Tegas Menolak]"
  },
  Event_7497_Desc = {
    Text = [[
Bisikan pelan bergema di lingkungan yang kosong. 
"Oh, itu si bodoh terkenal yang selalu menggumamkan 'mati atau menang', seorang penjudi ternama, sampah. Sebaiknya kamu menjauh darinya."
Bayangan tipis dengan postur tubuh yang lesu melemparkan beberapa koin ke arahmu, suara dentingan logam terdengar jelas saat menyentuh telapak tanganmu. 
"Mari main satu ronde."]]
  },
  Event_7497_Name = {
    Text = "Penjudi Terkenal"
  },
  Event_7498_ChoiceDesc1 = {
    Text = "[Kami Semua Baik-baik Saja] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7498_ChoiceDesc2 = {
    Text = "[Kamu Siapa?] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7498_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7498_Desc = {
    Text = [[
Mesin tik tiba-tiba menyemburkan tinta, dengan tanda seru yang begitu mencolok. 
"Boneka, apakah kamu baik-baik saja??? Kenapa kamu juga menghilang setelah Penjaga menghilang??? Tolong beri kabar jika kamu selamat!!! Jika menunggu lebih lama, rambut William akan rontok habis!!!"]]
  },
  Event_7498_Name = {
    Text = "Komunikasi Darurat"
  },
  Event_7499_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7499_Desc = {
    Text = "Kamu menambal bagian gips terakhir, dia meledak dalam tawa yang menusuk, diikuti oleh jalinan asap hitam yang melingkupi tubuhnya. Bayangannya yang melayang pun menghilang dari pandanganmu."
  },
  Event_7499_Name = {
    Text = "Melengkapi tubuh yang rusak"
  },
  Event_7500_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7500_Desc = {
    Text = [[
Kamu mengeluarkan kunci perak, dengan penuh kesedihan dan ketulusan memegangnya di telapak tangan. Cahaya tipis seperti kabut menyelimuti dirimu. 
 Dalam keheningan, hanya terdengar helaan napas.]]
  },
  Event_7500_Name = {
    Text = "Mata Pandangan"
  },
  Event_7501_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7501_Desc = {
    Text = [[
Pandangan yang tersisa masih mengamati mu, sel-sel caro di bawah kulitmu berteriak dalam kegilaan dan melarikan diri, pembuluh darah di bawah kulitmu bergerak seperti serangga. 
 Kamu merasakan aliran kekuatan, meledak dalam keanehan anggota tubuh yang misterius.]]
  },
  Event_7501_Name = {
    Text = "Mata Pandangan"
  },
  Event_7502_ChoiceDesc1 = {
    Text = "[Menghindari Pandangan] Bangun 1 Pembangun secara acak"
  },
  Event_7502_ChoiceDesc2 = {
    Text = "[Tatapan Langsung] Pilih 1 Pembangun untuk dibangunkan dan kurangi konsumsi aritmetika kartu bangun sebesar 2 poin. Infeksi [(Skill.Arg1)]"
  },
  Event_7502_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_7502_Desc = {
    Text = "Terowongan dimensi menghubungkan ribuan alam semesta, di lorong tertinggi, ratusan pasang mata menatap liar menuju kalian."
  },
  Event_7502_Name = {
    Text = "Pandangannya"
  },
  Event_7503_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7503_Desc = {
    Text = [[
Terlalu kacau, terlalu kacau. 
Semua pikiran dalam sekejap terseret oleh arus panjang pemikiran, dibawa pergi oleh banjir menuju kejauhan. 
Di lembah otak, hanya tertinggal kebingungan dan penderitaan tanpa akhir yang tenggelam bersama.]]
  },
  Event_7503_Name = {
    Text = "Ledakan Inspirasi"
  },
  Event_7504_ChoiceDesc1 = {
    Text = "[Dimasukkan ke dalam kantong]"
  },
  Event_7504_Desc = {
    Text = "Di dalam D-lendir yang terlalu jenuh tampaknya terkandung beberapa zat... Gunakan Kunci perak untuk mengamati, dan ubahlah menjadi Kekuatanmu sendiri."
  },
  Event_7504_Name = {
    Text = "Titik Ekstraksi"
  },
  Event_7505_ChoiceDesc1 = {
    Text = "[Mengusir Gagak]mendapatkan 35 Segil hitam, terinfeksi[(Skill.Arg2)], terus memilih"
  },
  Event_7505_ChoiceDesc2 = {
    Text = "[Mengejar anak lagi] Pergi"
  },
  Event_7505_Desc = {
    Text = "Seekor gagak terbang meninggalkan, dan bulu hitam legam perlahan melayang jatuh."
  },
  Event_7505_Name = {
    Text = "Pandangan Burung Gagak Hitam"
  },
  Event_7506_ChoiceDesc1 = {Text = "[OK]"},
  Event_7506_Desc = {
    Text = [[
Ini adalah medan pertempuran berdarah di Jurang, Pertempuran tidak hanya membutuhkan keberanian, tetapi juga kebijaksanaan. 

Pertajam penglihatanmu, amati lawanmu, kamu tidak perlu mengalahkan mereka semua, kamu hanya perlu mengalahkan pemimpin mereka!]]
  },
  Event_7506_Name = {
    Text = "Ujian Asura"
  },
  Event_7507_ChoiceDesc1 = {
    Text = "[Menghubungkan] Pulihkan Arg2 poin Hidup."
  },
  Event_7507_Desc = {
    Text = "Kamu menjelajahi dalam kabut, tiba-tiba, lencana sekolah di dada memancarkan cahaya perak yang lemah. Siapa yang memanggil dari sisi lain komunikator?"
  },
  Event_7507_Name = {
    Text = "Persimpangan"
  },
  Event_7508_ChoiceDesc1 = {
    Text = "[Mengikuti dia]"
  },
  Event_7508_ChoiceDesc2 = {Text = "[Menyapa]"},
  Event_7508_Desc = {
    Text = [[
Tak. Tak. Tak.
Sosok berpakaian putih melangkah perlahan di tengah kabut tebal, seperti kapal layar yang bergerak menuju malam yang sunyi.
Dari belakang, sepertinya seorang anak laki-laki.
Kamu mendengarkan suara langkah kakinya yang terdengar lelah, lalu dalam hati kamu membuat sebuah keputusan.]]
  },
  Event_7508_Name = {
    Text = "Upacara Penutupan I"
  },
  Event_7509_ChoiceDesc1 = {
    Text = "[Setuju dengan senang hati]"
  },
  Event_7509_ChoiceDesc2 = {
    Text = "[Memiliki Rasa Curiga]"
  },
  Event_7509_Desc = {
    Text = "Tubuh yang terlulur melolong jatuh, dan kamu terkejut menemukan Clementine berdiri di belakangnya. \n\"Aku datang untuk berpamitan,\"menghadapi pertanyaanmu, dia tidak menjawab, \"Sebagai ungkapan rasa terima kasihku padamu, aku bisa memberitahumu beberapa petunjuk. Namun… itu akan membutuhkan kepercayaanmu. \nBiarkan aku menghipnotismu, dan kamu akan mengetahui semua yang aku ketahui.\"\nApakah kamu bisa mempercayainya? \n\"Hati-hati,\"Ramona memperingatkan, \"Dia pasti punya tujuan lain.\""
  },
  Event_7509_Name = {
    Text = "Terapi hipnotis"
  },
  Event_7510_ChoiceDesc1 = {Text = "[OK]"},
  Event_7510_Desc = {
    Text = "Kamu berkonsentrasi dengan roh, ilusi itu memudar seperti tinta yang menyebar. Kamu melanjutkan langkahmu ke depan, namun tidak bisa sepenuhnya menghilangkan bayang-bayang kelam di hatimu."
  },
  Event_7510_Name = {Text = "Ilusi"},
  Event_7511_ChoiceDesc1 = {
    Text = "[Makhluk yang malang?]"
  },
  Event_7511_ChoiceDesc2 = {
    Text = "[Manusia yang Berevolusi?]"
  },
  Event_7511_ChoiceDesc3 = {
    Text = "[Siapa kamu sebenarnya?]"
  },
  Event_7511_Desc = {
    Text = [[
Pria yang kalian lihat untuk keenam kalinya itu, berdiri di ketinggian rangka baja, memandang tanah. Angin yang berhembus kencang mengibaskan rambut panjangnya, memperlihatkan wujud ular.
Tatapannya terfokus pada kalian, sesaat kemudian kembali ke kegelapan yang jauh. 
"Ah, makhluk malang seperti apa ini.
Perasaan dikhianati pasti terasa manis seperti <Bold: evolusi> manusia."]]
  },
  Event_7511_Name = {
    Text = "Teman Perjalanan Aneh VI"
  },
  Event_7512_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7512_Desc = {
    Text = "Siapa yang akan memperhatikan satu gulungan film di bawah tatapan Anjing neraka?"
  },
  Event_7512_Name = {
    Text = "Kenangan Cahaya dan Bayang-bayang"
  },
  Event_7513_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7513_Desc = {
    Text = "Tidak melihat, tidak membahas, tidak mendengar, bahkan jangan berpikir — pilihan orang cerdas."
  },
  Event_7513_Name = {
    Text = "Rune Madness"
  },
  Event_7514_ChoiceDesc1 = {
    Text = "[Keluar] Hapus 2 Kartu"
  },
  Event_7514_Desc = {
    Text = [[
Di tengah suara bising di sekitar, samar-samar kamu mendengar suara kepakan sayap yang aneh. Kunci perak di dadamu tiba-tiba bergetar, dan kamu dipaksa oleh semacam kekuatan untuk menengadah, melihat lubang hitam raksasa muncul di udara. 
 "Sayang sekali, sayang sekali, tapi tidak apa-apa. Kita akan bertemu lagi, wahai mata tanpa penglihatan yang terhormat."]]
  },
  Event_7514_Name = {
    Text = "Terapi hipnotis"
  },
  Event_7515_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7515_Desc = {
    Text = "Kamu bisa mengabaikan segala sesuatu di sekitarmu, namun tidak mampu mengabaikan detak jantungmu. Ia mempercepat ritme ketukan, mendesakmu, sekaligus menyalahkanmu."
  },
  Event_7515_Name = {
    Text = "Atrium kiri"
  },
  Event_7516_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7516_Desc = {
    Text = [[
"Syukurlah!!! Rambut Kak William selamat!!!"
Meskipun hanya informasi teks, isi telegram tersebut membuatmu membayangkan teriakan yang penuh semangat.]]
  },
  Event_7516_Name = {
    Text = "Komunikasi Darurat"
  },
  Event_7517_ChoiceDesc1 = {
    Text = "[Beritahu dia kebenaran] Bangun secara acak 1 Pembangun, infeksi [(Skill.Arg1)]"
  },
  Event_7517_ChoiceDesc2 = {
    Text = "[Menyembunyikan Kebenaran] Mendapatkan 1 dari 3 Orison"
  },
  Event_7517_Desc = {
    Text = "\"Tolong selamatkan aku.\"\nPengembara yang murung memegang tanganmu. Dia telah berkeliaran di sini selama ratusan tahun.\n\"Aku seorang prajurit, diperintahkan untuk pergi ke timur jauh guna menaklukkan kaum kafir.\nAku melewati hutan lebat, menyeberangi sungai, namun kehilangan arah, berulang kali kembali ke tempat yang sama.\nAda sesuatu yang mengamati aku dalam kegelapan. Aku tidak bisa melihatnya, tapi aku tahu. Itu terus mengamati aku.\nSekarang aku hanya ingin pulang…\"\nKamu menatap bayangan tak menentu yang melayang di belakangnya. Awalnya mereka kabur, lalu secara bertahap menjadi jelas — itu adalah mulut yang terbuka lebar, siap menikmati jiwa yang tersesat dan telah diasinkan selama ratusan tahun."
  },
  Event_7517_Name = {Text = "Melahap"},
  Event_7518_ChoiceDesc1 = {
    Text = "[Menyelami Kegelapan]"
  },
  Event_7518_ChoiceDesc2 = {
    Text = "[Perpisahan]"
  },
  Event_7518_Desc = {
    Text = [[
"Celeste, kau akan membantuku kali ini, kan."
Gadis itu gelisah mondar-mandir di tempat, sesekali menoleh ke arah Pembangun yang tenang.
Dia tidak merespons gadis itu, dan ketika ekspresi gadis itu semakin cemas, angin sepoi-sepoi mengangkat kain putih, mendorong gadis itu dengan lembut ke arah tertentu.
"Aku akan melindungimu."
Aku akan melindungimu, meskipun dalam hal "melindungi", aku pernah gagal sekali.
Tapi kali ini, aku tidak akan membiarkanmu tersesat sendirian dalam kegelapan.]]
  },
  Event_7518_Name = {
    Text = "Berkah Santa Navigasi"
  },
  Event_7519_ChoiceDesc1 = {
    Text = "[Keluar] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7519_Desc = {
    Text = "Nyanyian-nya ada yang kuno, begitu kuno hingga telah hilang sebelum penyebaran banjir; ada juga yang baru, menyanyikan tahun baru yang lalu, sarung tangan baru yang dibeli istri di Londinium... Setelah kekacauan emosi yang tumpang tindih, yang tersisa adalah kekosongan di dalam hati."
  },
  Event_7519_Name = {
    Text = "Lagu Perahu"
  },
  Event_7520_ChoiceDesc1 = {
    Text = "[Mengusir Warna] mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7520_ChoiceDesc2 = {
    Text = "[Memeluk Warna] Dapatkan 1 dari 3 pilihan Relik Emas, terinfeksi [(Skill.Arg1)]"
  },
  Event_7520_ChoiceDesc3 = {
    Text = "[Meninggalkan area] Mendapatkan Relik perak [(RelicConfig.Arg1)]"
  },
  Event_7520_Desc = {
    Text = "Murphy mengikuti di belakang tanpa beranjak sedikit pun, namun saat melewati sebuah tikungan, dia tiba-tiba membeku di tempat.\nAliran cahaya berkilauan bergulung di depan mata, menggulung udara hingga terdengar seperti suara napas panjang.\n\"Mur@1…\"\nApakah ini arwah tenggelam yang terjebak di penjara kapal Sonaniel? Atau kerabat yang telah meninggal dan mengikuti orang hidup?"
  },
  Event_7520_Name = {
    Text = "Warna yang Mengingatkan"
  },
  Event_7521_ChoiceDesc1 = {
    Text = "[Lanjutkan Pencarian] Tingkatkan Arg1 poin Hidup, terinfeksi [(Skill.Arg2)]"
  },
  Event_7521_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7521_Desc = {
    Text = "Di telinga terdengar suara yang akrab, begitu hangat dan menenangkan. Namun, ketika mencoba mencari sumber suara tersebut, tiba-tiba suara itu terhenti."
  },
  Event_7521_Name = {
    Text = "Kontak Anomali"
  },
  Event_7522_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7522_Desc = {
    Text = [[
"Itu adalah suara musik yang menghina."
Kamu menutupi darah yang mengalir dari lubang telingamu dan yakin akan hal itu.]]
  },
  Event_7522_Name = {
    Text = "Suara Terlarang"
  },
  Event_7523_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7523_Desc = {
    Text = "Warna itu samar-samar terdistorsi menjadi bentuk dua manusia, tetapi mereka hanya berdiri diam di sudut itu, memberikan kalian berkah terakhir dengan tatapan mereka."
  },
  Event_7523_Name = {
    Text = "Warna yang Mengingatkan"
  },
  Event_7524_ChoiceDesc1 = {
    Text = "[Mendengarkan] Mendapatkan pilihan 1 dari 3 Relik emas"
  },
  Event_7524_Desc = {
    Text = [[
Suara Narsis terhenti sejenak. 
"Oh, jadi kamu memilih ini? Pilihan yang bagus. Sebagai hadiah, aku akan memberimu sebuah Hadiah spesial."]]
  },
  Event_7524_Name = {
    Text = "Waktu Petunjuk"
  },
  Event_7525_ChoiceDesc1 = {
    Text = "[Tetap bertanya] Terinfeksi [(Skill.Arg1)]"
  },
  Event_7525_ChoiceDesc2 = {
    Text = "[Abandon Inquiry] Pilih 1 Kartu untuk dihapus"
  },
  Event_7525_Desc = {
    Text = "\"Hmm, pilihan yang cerdas. Dihadapkan pada musuh besar, pasti ingin mengetahui kekuatan lawan? Namun, mengetahui terlalu banyak tentang rahasia dimensi dapat mengganggu pikiranmu, lho?\""
  },
  Event_7525_Name = {
    Text = "Waktu Petunjuk"
  },
  Event_7526_ChoiceDesc1 = {
    Text = "[ Terus bertanya ] Memicu kemarahan Narsis, memasuki Pertempuran"
  },
  Event_7526_ChoiceDesc2 = {
    Text = "[Menyerah Bertanya] Menanggung sedikit hukuman"
  },
  Event_7526_Desc = {
    Text = "\"Oh? Masih memikirkan untuk melacakku di saat seperti ini? Bocah, terlalu serakah itu tidak baik, lho.\""
  },
  Event_7526_Name = {
    Text = "Waktu Petunjuk"
  },
  Event_7527_ChoiceDesc1 = {
    Text = "[Perhatikan dengan seksama] Meningkatkan Arg1 poin Kesehatan maksimum"
  },
  Event_7527_ChoiceDesc2 = {
    Text = "[Mengabaikan] 2 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi 2 \"(Skill.Arg2)\""
  },
  Event_7527_Desc = {
    Text = [[
Kalian mengejar bayangan Anjing neraka, berlari di jalan-jalan kota kecil. 
 Di langit mulai jatuh salju dingin, dengan lembut mendarat di pipi, di dada, menenangkan hatimu yang gelisah.]]
  },
  Event_7527_Name = {Text = "Salju"},
  Event_7528_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7528_Desc = {
    Text = [[
Kamu mengibaskan kedua tanganmu, berusaha mengusir gagak-gagak yang mengganggu itu. 
Mereka tertawa dengan suara "kra kra", seolah-olah mengejek kebodohan dan kelemahanmu. 
Namun demikian, keberanianmu tetap menyentuh mereka, dan kamu mendapatkan hadiah yang pantas kamu terima.]]
  },
  Event_7528_Name = {
    Text = "Lagu Kawan-Kawan Gagak"
  },
  Event_7529_ChoiceDesc1 = {
    Text = "[Lily] mendapatkan Relik perak [(RelicConfig.Arg1)]"
  },
  Event_7529_ChoiceDesc2 = {
    Text = "[Anjing neraka] memperoleh Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7529_Desc = {
    Text = [[
Melintasi pintu tak berujung, dari tempat yang begitu jauh hingga tak terjangkau, terdengar suara Dafude'er. 
"Ini adalah waktu tips dari Dafude'er."]]
  },
  Event_7529_Name = {
    Text = "Waktu Petunjuk"
  },
  Event_7530_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7530_Desc = {
    Text = [[
Kau masih terlihat gigih, dalam nyanyianmu, kau masih bisa mengikuti dirimu sendiri. 
 Kau tidak percaya pada deliran di telingamu, satu-satunya yang kau andalkan hanyalah rasionalitas manusia. 
 Namun... pada hari di mana tanah yang kokoh yang kau bergantung terbungkus oleh cairan hitam yang kental, mencungkil bola mata sebagai objek pengintai akan menjadi satu-satunya pilihanmu saat menjelang akhir.]]
  },
  Event_7530_Name = {
    Text = "Lagu Kawan-Kawan Gagak"
  },
  Event_7531_ChoiceDesc1 = {
    Text = "[Mendapatkan Anjing Neraka dari Sumber] Mendapatkan Relik Emas \"(RelicConfig.Arg1)\", Terinfeksi \"(Skill.Arg2)\""
  },
  Event_7531_ChoiceDesc2 = {
    Text = "[Fokus Pertempuran] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7531_Desc = {
    Text = [[
Garis besar anjing neraka berubah.
Tubuhnya terhubung dengan celah dinding, mengungkapkan ilusi yang aneh.]]
  },
  Event_7531_Name = {Text = "dari sudut"},
  Event_7532_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7532_Desc = {
    Text = "\"Meong, meong meong, meong meong meong…\"\nKamu memeras suaramu, berusaha terdengar lemah dan tidak berbahaya.\n\"Meong! Meong meong! Meong meong meong!\"\nKawanan kucing tampaknya menerima kebaikanmu, membalas dengan teriakan nyaring. Suara kalian saling bersahutan, siang malam tanpa henti, bahkan bulan pun ketakutan hingga bersembunyi di balik awan."
  },
  Event_7532_Name = {
    Text = "Kota Kucing"
  },
  Event_7533_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7533_Desc = {
    Text = [[
Hanyalah makhluk yang berjuang untuk bertahan hidup, mencari sepotong kayu apung untuk beristirahat saja...
Kamu menghela napas, lalu membiarkan cairan hitam dari ekor kupu-kupu mengalir ke pipi.]]
  },
  Event_7533_Name = {
    Text = "Kupu-kupu Cairan Hitam"
  },
  Event_7534_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7534_Desc = {
    Text = [[
Kamu mengeluarkan seluruh tenaga hingga jauh dari kawanan kucing.
Saat menoleh kembali, kucing-kucing itu sudah kembali ke posisi masing-masing. Ada yang sedang menyisir bulu, beristirahat, bahkan ada yang saling berkelahi...
Jujur saja, mereka tidak peduli dengan manusia.]]
  },
  Event_7534_Name = {
    Text = "Kota Kucing"
  },
  Event_7535_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7535_Desc = {
    Text = [[
Kamu melemparkan potongan daging yang tersisa ke dalam kawanan kucing. 
 Kucing-kucing itu maju seperti gelombang hitam. Mereka menggigit potongan daging dengan gila, lalu segera menyebar. 
 Sayangnya, ini adalah daging yang sudah kedaluwarsa. Mampu mengisi perut yang keroncongan, tetapi tidak begitu memuaskan.]]
  },
  Event_7535_Name = {
    Text = "Kota Kucing"
  },
  Event_7536_ChoiceDesc1 = {
    Text = "[Melihat langsung ke mata] Mendapatkan Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7536_ChoiceDesc2 = {
    Text = "[Berhenti melawan] Secara acak membangunkan 2 Pembangun, menginfeksi dua kali [(Skill.Arg1)]"
  },
  Event_7536_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_7536_Desc = {
    Text = [[
Tak terhitung mata mengelilingi di samping telingamu dan berbisik. 
"Kami berjalan, kami berhenti, kami melangkah dengan tegap melewati puluhan ribu tahun atau bahkan lebih lama. 
Ketika matahari perlahan memudar dalam pandangan, ketika kehidupan Bumi tua ditenggelamkan oleh banjir. 
Kami telah lama terpikat oleh misteri alam semesta."]]
  },
  Event_7536_Name = {Text = "Mata"},
  Event_7537_ChoiceDesc1 = {
    Text = "[Merasa cemas] Bangun 1 Pembangun secara acak"
  },
  Event_7537_ChoiceDesc2 = {
    Text = "[Merasa puas] Pilih untuk membangunkan 1 Pembangun dan kurangi lelah aritmetika kartu bangun sebesar 2 poin. Infeksi [(Skill.Arg1)]"
  },
  Event_7537_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_7537_Desc = {
    Text = [[
Kamu pernah melihat langit tanpa bulan dan bintang-bintang, di udara tergantung banyak pupil yang diperbesar. 
 Seolah-olah ketika kamu mengulurkan tangan, kamu bisa mencabutnya dan menyebarkan darah dan daging ke mana-mana. 
 Namun ketika kamu membuka lima jarimu, tempat yang kamu sentuh kosong tanpa apa-apa. 
 Mata nasib menatapmu tanpa berkedip, mereka mengambil sebutir pasir yang jernih dari kekacauan alam semesta.]]
  },
  Event_7537_Name = {Text = "Mata Kubah"},
  Event_7538_ChoiceDesc1 = {
    Text = "[Menurunkan tangan yang menutup telinga] Mendapatkan Relik perak [(RelicConfig.Arg1)]"
  },
  Event_7538_ChoiceDesc2 = {
    Text = "[Meneruskan menutup telinga] Mendapatkan 75 Segil Hitam, terinfeksi [(Skill.Arg2)]"
  },
  Event_7538_Desc = {
    Text = "Jeritan, jeritan yang tiada akhir——\nSang Penyanyi gagak mengenakan bulu hitam mengkilap, paruhnya memancarkan cahaya dingin yang keras, ratapan nyaringnya berulang kali membelah gendang telingamu. \nLepaskan tanganmu yang menutupi telinga! \nGerombolan gagak yang bernyanyi dengan gembira di malam hari, ingin meneguk getaran yang belum teruji dalam tubuhmu yang terlipat."
  },
  Event_7538_Name = {
    Text = "Lagu Dari Gerombolan Gagak"
  },
  Event_7539_ChoiceDesc1 = {
    Text = "[Meniru suara kucing] Mendapatkan 50 Segil hitam"
  },
  Event_7539_ChoiceDesc2 = {
    Text = "[Memberi Makanan]Mendapatkan 75 Segil Hitam, terinfeksi[(Skill.Arg2)]"
  },
  Event_7539_Desc = {
    Text = "Kamu tersesat ke wilayah kucing hitam. \n Tak terhitung mata terbuka dengan cepat dalam kegelapan, penuh rasa ingin tahu, menilai, waspada... hanya tidak ada niat baik. \n Zamrud, kuning amber, biru merak... \n Kamu seolah berada di lautan permata yang berkilau. \n Untuk melarikan diri, kamu——"
  },
  Event_7539_Name = {
    Text = "Kota Kucing"
  },
  Event_7540_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7540_Desc = {
    Text = "Kamu memperhatikan sebuah tangan yang berbeda dari yang lain. Tangan itu lembut, putih, dan sepanjang waktu menunjukkan ketenangan. \n Yang lebih penting—kamu mengenalinya, itu adalah tanganmu sendiri. \n Kamu segera mengambil keputusan dan memutuskannya dengan keras. \n Di telinga terdengar banyak jeritan tajam, rawa akhirnya menghilang."
  },
  Event_7540_Name = {
    Text = "Bekas Rawan Gelap"
  },
  Event_7541_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7541_Desc = {
    Text = [[
"Keputusan yang bijaksana."kata sosok dengan tangan kosong, "Pilihan yang sudah terbukti memiliki akhir yang pasti, sedangkan tindakan yang tidak diketahui akan membawa ke masa depan yang baru."
Harapan kecil itu lembut menyelimuti dirimu. Sosok itu menghilang, kau memegang dada, tidak yakin apakah yang barusan adalah proyeksi, ataukah Fatamorgana yang dihasilkan oleh Roh di bawah tekanan berat.]]
  },
  Event_7541_Name = {
    Text = "Jalan yang bercabang"
  },
  Event_7542_ChoiceDesc1 = {
    Text = "[Puji itu] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7542_ChoiceDesc2 = {
    Text = "[Mengejeknya] Infeksi [(Skill.Arg1)], Orison ulang, maksimal 2 kali"
  },
  Event_7542_Desc = {
    Text = [[
Otak berkata: Rantai mengikat otak depanku, batang otakku, korteks serebralku, namun tidak bisa mengekang lebih dari 10 miliar sel kecil yang haus akan kebenaran.
Kamu berkata: Siapa yang mengurungmu di sini? Lalu tubuhmu?
Otak berkata: Tubuh? Jangan bercanda. Dulu mereka semua memanggilku "Jonny si penjual daging babi".
Saat aku masih memiliki tubuh, aku bahkan tidak bisa menghitung penjumlahan dan pengurangan angka di bawah sepuluh.
Namun setelah Kurator menghilangkan tubuh berlebihanku, lihatlah apa yang terjadi padaku! Seorang fisikawan, filsuf, dan penyair amatir.]]
  },
  Event_7542_Name = {
    Text = "Otak filsafat"
  },
  Event_7543_ChoiceDesc1 = {
    Text = "[Membuktikan Konjektur Goldbach] Mendapatkan Relik perak [(RelicConfig.Arg1)]"
  },
  Event_7543_ChoiceDesc2 = {
    Text = "[Titik Akhir Perjalanan]acak 1 kartu mendapatkan Orison:[(EnchantConfig.Arg1)]"
  },
  Event_7543_ChoiceDesc3 = {
    Text = "[Menolak pertanyaan] Mendapatkan 50 Segil Hitam"
  },
  Event_7543_Desc = {
    Text = [[
Saat mengambil papan Spiritisme, suara seorang wanita muda menerobos masuk ke dalam pikiranmu. 
"Ajukan pertanyaan padaku, aku tahu segalanya."
"Dari jawabanku, kamu akan menerima hadiah takdir."]]
  },
  Event_7543_Name = {
    Text = "Papan Ouija"
  },
  Event_7544_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7544_Desc = {
    Text = "Kamu membaca kertas yang sudah usang dan rusak, kalimat-kalimat yang terpecah mengalir dari mulutmu, \"Leluhur\", \"Anak Suci\", \"Kematian Abadi\", \"Memori Panjang\" dan kata-kata lainnya membanjiri pikiranmu, merangsang sarafmu yang sudah menjadi sensitif dan rapuh karena mimpi buruk."
  },
  Event_7544_Name = {
    Text = "Kode Rahasia·Atas"
  },
  Event_7545_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7545_Desc = {
    Text = [[
Lumpur hitam menetes di wajahmu, menyebabkan rasa gatal yang menjalar. 
Kamu tidak tahan dan mencoba menepis kupu-kupu itu dengan tanganmu. 
Kupu-kupu itu menghindari gerakan kasarmu, lenyap tanpa suara di ujung sana.]]
  },
  Event_7545_Name = {
    Text = "Kupu-kupu Cairan Hitam"
  },
  Event_7546_ChoiceDesc1 = {
    Text = "[Keluar] Mencari lampu sorot"
  },
  Event_7546_ChoiceDesc2 = {
    Text = "[Masuki Kabut] Kehilangan Arg2 poin Hidup"
  },
  Event_7546_ChoiceDesc3 = {
    Text = "[Langsung Masuk]"
  },
  Event_7546_Desc = {
    Text = [[
Di depan terdapat kabut hitam pekat, masuk secara sembrono akan mendatangkan Clades. 
 Mungkin kamu harus menemukan "Lampu Sorot"untuk mengusir kabut tersebut.]]
  },
  Event_7546_Name = {
    Text = "tidak dikenal"
  },
  Event_7547_ChoiceDesc1 = {
    Text = "[Terima Bayangan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7547_ChoiceDesc2 = {
    Text = "[Menyangkal Fatamorgana] mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7547_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7547_Desc = {
    Text = [[
Di bawah jembatan besi yang berat dan gelap, di tepi sungai yang sunyi yang ditumbuhi alang-alang, tiba-tiba terbang seekor kupu-kupu yang berkilau. 
 Kupu-kupu itu ringan hinggap di telapak tanganmu, suara jeritan yang mengerikan terhenti, digantikan oleh suara teratur pekerja yang mengangkut besi beton, suara palu paku yang diketuk, dan suara logam yang nyaring dari benturan paku rivet......]]
  },
  Event_7547_Name = {
    Text = "Fatamorgana Jembatan Baja"
  },
  Event_7548_ChoiceDesc1 = {
    Text = "[Mengusir Gagak]mendapatkan 40 Segil hitam, terinfeksi[(Skill.Arg2)], terus memilih"
  },
  Event_7548_ChoiceDesc2 = {
    Text = "[Terus Mengejar Anak]mendapatkan 25 Segil hitam, pergi"
  },
  Event_7548_Desc = {
    Text = [[
Seekor gagak berdiri di lampu gantung. 
 Dua ekor gagak berdiri di lampu gantung. 
 Tiga ekor gagak berdiri di lampu gantung. 
 ... 
 Makhluk-makhluk hitam pekat itu memutar leher mereka, berdiri di lampu gantung di ujung lorong, menatapmu dengan tatapan penuh niat jahat. Kepala yang berbayang itu, seolah-olah berbagi tubuh yang terendam dalam lumpur hitam.]]
  },
  Event_7548_Name = {
    Text = "Pandangan Burung Gagak Hitam"
  },
  Event_7549_ChoiceDesc1 = {
    Text = "[Keluar] Jumlah Pembangun yang terbangun kurang dari 3, dapatkan Relik perak [(RelicConfig.Arg1)]"
  },
  Event_7549_ChoiceDesc2 = {
    Text = "[Keluar] Jumlah Pembangun yang telah Bangun minimal 3, dapatkan Relik emas [(RelicConfig.Arg1)]"
  },
  Event_7549_Desc = {
    Text = [[
Kamu tidak mempedulikan jejak ini dan melangkah maju. 
<Italic:"Gnosis yang Bangun"begitu berat>, jejak itu semakin membesar dan semakin berkelok mengikuti langkahmu, seolah-olah bisa menjulurkan tangan dari celah itu dan menarikmu ke dalam.]]
  },
  Event_7549_Name = {
    Text = "Garis Retak Bergerak"
  },
  Event_7550_ChoiceDesc1 = {
    Text = "[Mendapatkan pandangan] Memperoleh Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7550_ChoiceDesc2 = {
    Text = "[Menghindari Pandangan] Secara acak bangun 2 Pembangun, infeksi dua kali [(Skill.Arg1)]"
  },
  Event_7550_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_7550_Desc = {
    Text = [[
Kamu bisa merasakan sebuah tatapan, sebuah pandangan yang melampaui Dimensi, jauh lebih tinggi dari Domain, sedang mengamati. Mengamati dirimu, juga gadis di depanmu. 
 Napasmu mulai terengah-engah, di kedalaman akal sehatmu, ketakutan primitif mulai berteriak.]]
  },
  Event_7550_Name = {
    Text = "Siapa yang melihat"
  },
  Event_7551_ChoiceDesc1 = {
    Text = "[Lanjutkan Pencarian] Tingkatkan Arg1 poin Hidup, terinfeksi [(Skill.Arg2)]"
  },
  Event_7551_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7551_Desc = {
    Text = "Cahaya samar muncul di depan mata, terang dan hangat. Saat ingin mengikuti cahaya itu, tiba-tiba ia menghilang."
  },
  Event_7551_Name = {
    Text = "Kontak Anomali"
  },
  Event_7552_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7552_Desc = {
    Text = "Bergumam mengikuti nyanyian-Nya, aliran air hangat membawa berkah kepulangan untukmu."
  },
  Event_7552_Name = {Text = "Lagu Laut"},
  Event_7553_ChoiceDesc1 = {Text = "[OK]"},
  Event_7553_Desc = {
    Text = "Di depanmu, kamu melihat seberkas cahaya samar. Akhirnya, kamu berhasil menembus kabut pekat yang membuatmu merasa sesak."
  },
  Event_7553_Name = {
    Text = "Kabut Kekacauan"
  },
  Event_7554_ChoiceDesc1 = {
    Text = "[Membuka cabang di bawah]"
  },
  Event_7554_Desc = {
    Text = [[
Gnosis dari Domain yang tersisa saling terhubung, menciptakan medan kekuatan yang tidak stabil. 
 Mungkin, kamu bisa memutus Jalinan ini dan membuka jalan untuk dirimu sendiri.]]
  },
  Event_7554_Name = {
    Text = "Jalur yang Berbelit"
  },
  Event_7555_ChoiceDesc1 = {
    Text = "[Membuka cabang di atas]"
  },
  Event_7555_Desc = {
    Text = [[
Gnosis dari Domain yang tersisa saling terhubung, menciptakan medan kekuatan yang tidak stabil. 
 Mungkin, kamu bisa memutus Jalinan ini dan membuka jalan untuk dirimu sendiri.]]
  },
  Event_7555_Name = {
    Text = "Jalur yang Berbelit"
  },
  Event_7556_ChoiceDesc1 = {
    Text = "[Membuka cabang di sisi kiri]"
  },
  Event_7556_Desc = {
    Text = [[
Gnosis dari Domain yang tersisa saling terhubung, menciptakan medan kekuatan yang tidak stabil. 
 Mungkin, kamu bisa memutus Jalinan ini dan membuka jalan untuk dirimu sendiri.]]
  },
  Event_7556_Name = {
    Text = "Jalur yang Berbelit"
  },
  Event_7557_ChoiceDesc1 = {
    Text = "[Membuka cabang di sisi kiri]"
  },
  Event_7557_Desc = {
    Text = [[
Gnosis dari Domain yang tersisa saling terhubung, menciptakan medan kekuatan yang tidak stabil. 
 Mungkin, kamu bisa memutus Jalinan ini dan membuka jalan untuk dirimu sendiri.]]
  },
  Event_7557_Name = {
    Text = "Jalur yang Berbelit"
  },
  Event_7558_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7558_Desc = {
    Text = "Kalian masih akan menghadapi beberapa pertempuran sengit, sekarang bukan saatnya untuk melakukan Penyelidikan dengan santai."
  },
  Event_7558_Name = {
    Text = "Pendaftaran Organ"
  },
  Event_7559_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7559_Desc = {
    Text = [[
Karakter di atas kertas tiba-tiba menjadi utuh dan hidup, kata-kata yang menakutkan cukup untuk mengguncang keyakinan dan fondasi semua penderita yang tidak sadar. Semakin kamu membaca, semakin bingung dan ketakutan, tak bisa berhenti menggaruk kulit kepalamu dengan ujung jari. 
 Tiba-tiba, simbol-simbol yang penuh kutukan itu menghilang. Ramona memotong bacaanmu, lalu memaksa memasukkan halaman buku itu ke dalam koper.]]
  },
  Event_7559_Name = {
    Text = "Kode Rahasia·Bawah"
  },
  Event_7560_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7560_Desc = {
    Text = [[
Kegembiraan, kesedihan, kesedihan mendalam, kegelisahan... semua ini adalah emosimu. 
 Kamu, dan banyak dirimu yang berada di luar Dimensi di dunia lain yang berbeda-beda.]]
  },
  Event_7560_Name = {Text = "Kecanduan"},
  Event_7561_ChoiceDesc1 = {
    Text = "[Mendengarkan dengan Tenang] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7561_ChoiceDesc2 = {
    Text = "[Dia Ada di Sini] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7561_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7561_Desc = {
    Text = [[
Ratapan monster bergema di dalam pikiranmu, di antara cairan hitam yang tak berbentuk manusia, sebuah suara lemah berbisik, "Kak Sasa", "Kak Sasa".
"Kak Sasa, di mana kamu?"]]
  },
  Event_7561_Name = {Text = "\"Kak Sasa\""},
  Event_7562_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7562_Desc = {
    Text = "\"Bergabunglah dengannya, bergabunglah dengan mereka, bergabunglah dengan kami. \nMenjadi Penjaga-Nya, menjadi pelaksana-Nya. \nJadikan Mimpi-Nya sebagai arah tujuanmu…\"\nDoa yang kacau mengguncang kesadaranmu. Setelah suara-suara itu menghilang, kamu baru sadar bahwa dirimu sudah berkeringat dingin."
  },
  Event_7562_Name = {Text = "Doa Mimpi"},
  Event_7563_ChoiceDesc1 = {
    Text = "[Tidak pernah mendengar tentang ini]"
  },
  Event_7563_ChoiceDesc2 = {
    Text = "[Pernah mendengar]"
  },
  Event_7563_Desc = {
    Text = "『Teman sekelas, bolehkah aku meminta sedikit waktumu? \n Aku berharap bisa mengganggu kalian beberapa menit untuk memperkenalkan legenda pedesaan setempat. \n Apakah kalian pernah mendengar tentang makhluk yang disebut 'Kerberos'?』"
  },
  Event_7563_Name = {
    Text = "Teman Perjalanan Aneh I"
  },
  Event_7564_ChoiceDesc1 = {
    Text = "[Meninggalkan Pemikiran] memperoleh Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7564_ChoiceDesc2 = {
    Text = "[Kejar Ilham] 1 Kartu perintah acak mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7564_Desc = {
    Text = [[
Pelabuhan diserang, kapal kargo misterius yang datang tanpa kembali dan "teman baru" bersirip... Apakah ini jebakan yang direncanakan dengan matang? Atau perjalanan lain yang penuh kejadian tak terduga? 
 Kenyataan dan akal sehat saling tarik-menarik, berbagai inspirasi dan pikiran membanjiri pikiran.]]
  },
  Event_7564_Name = {
    Text = "Ledakan Inspirasi"
  },
  Event_7565_ChoiceDesc1 = {
    Text = "[Gunung Berapi Elworth?] Meningkatkan Kesehatan maksimum sebesar Arg1"
  },
  Event_7565_ChoiceDesc2 = {
    Text = "[Berusaha Mengingat] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7565_Desc = {
    Text = "Air mata hitam jatuh di kedua pipi Lily. \"Kita pernah bertemu, Ibu,\" bisiknya pelan, \"di gunung berapi Elworth…\""
  },
  Event_7565_Name = {
    Text = "Pengingat Gunung Berapi"
  },
  Event_7566_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7566_Desc = {
    Text = "\"Menginjak@1… laut……\"\nSimbol rune tampak samar-samar di depan mata, kamu tidak bisa menahan diri untuk meraih ke arah kehampaan, berusaha mencengkeram mereka——\n\"Apa yang kau lakukan! Mereka akan segera menyusul kita!\"\nGadis misterius itu menarikmu menuju ujung lain dek kapal, memutus hubunganmu dengan rune tersebut.\nNamun, ada sesuatu kekuatan yang meninggalkan jejak di ujung jarimu."
  },
  Event_7566_Name = {
    Text = "Rune Madness"
  },
  Event_7567_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7567_Desc = {
    Text = "Kamu tidak tertarik pada gumaman-gumaman aneh, apalagi mengambil risiko Kegilaan dengan melangkah ke dalam kegelapan malam."
  },
  Event_7567_Name = {
    Text = "Surat permintaan pertolongan"
  },
  Event_7568_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7568_Desc = {
    Text = "Bagaimanapun, tugas Penjaga membengkak di dadamu, kamu tidak bisa menyerah untuk menemukan pengirimnya, meskipun petunjuknya begitu samar-samar dan gelap."
  },
  Event_7568_Name = {
    Text = "Surat permintaan pertolongan"
  },
  Event_7569_ChoiceDesc1 = {
    Text = "[Mengamati itu] dapat memperoleh 25 Segil Hitam"
  },
  Event_7569_ChoiceDesc2 = {
    Text = "[Usap itu] 50% kesempatan mendapatkan 50 Segil Hitam, 50% kesempatan tidak mendapatkan apa-apa."
  },
  Event_7569_Desc = {
    Text = [[
Seekor kucing hitam tiba-tiba meloncat dari gang kecil, dengan sangat mesra menjalinan di sekitar kakimu, pupil vertikal berwarna hijau redup berkilauan dengan cahaya yang membuat merinding, seolah-olah berkata "Jangan kejar, main denganku sebentar."
 "Kamu sudah melihat-Nya, Dia ada di sisimu, bayangan-bayangan yang tercemar oleh kegilaan... Jangan menatap langsung pada siluet-Nya."]]
  },
  Event_7569_Name = {Text = "Elfo Malam"},
  Event_7570_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7570_Desc = {
    Text = "\"Tidak mungkin, aku tidak percaya!\" suara itu berteriak, \"Wanita yang menyerahkan aku kepada iblis ini, bukan kakak Sasha-ku!\""
  },
  Event_7570_Name = {Text = "\"Kak Sasa\""},
  Event_7571_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7571_Desc = {
    Text = "\"Roger, kami akan melakukan pengiriman inventaris dasar, harap perhatikan untuk penerimaan.\""
  },
  Event_7571_Name = {
    Text = "Komunikasi Dukungan"
  },
  Event_7572_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7572_Desc = {
    Text = "Sudah menjadi benda yang tidak berguna."
  },
  Event_7572_Name = {
    Text = "Relik dari Orang Terdahulu"
  },
  Event_7573_ChoiceDesc1 = {
    Text = "[Lihat lebih dekat] Dapatkan 1 dari 3 Orison"
  },
  Event_7573_ChoiceDesc2 = {
    Text = "[Merobek Poster] 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7573_Desc = {
    Text = [[
Sebuah kandil yang bisa ditemukan di mana saja di dalam museum lilin.
Dengan cahaya oranye yang menyeramkan, kamu menemukan sebuah poster bergambar tangan yang ditempel di dinding.]]
  },
  Event_7573_Name = {
    Text = "Tawa dalam Kegelapan"
  },
  Event_7574_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7574_Desc = {
    Text = [[
"Lily memiliki hatinya sendiri, tidak perlu mendengarkan siapa pun." Kamu menjawab dengan tenang dan tegas. 
 Francis mendengus dingin, tanpa memberikan tanggapan.]]
  },
  Event_7574_Name = {Text = "Pilihannya"},
  Event_7575_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7575_Desc = {
    Text = [[
Ini adalah serangkaian foto kelompok. 
 Orang-orang yang lesu duduk di belakang pagar besi, dengan wajah penuh kesengsaraan. 
 Salah satu foto menarik perhatianmu. Itu seharusnya seorang wanita muda yang kurus, dengan wajah yang kosong. 
 Makhluk yang sangat menghujat itu, melilit tubuhnya dalam lingkaran. 
 Kamu tidak bisa melihat wajahnya, tetapi dalam imajinasimu, dia seharusnya tidak berekspresi.]]
  },
  Event_7575_Name = {
    Text = "mencatat dengan jujur"
  },
  Event_7576_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7576_Desc = {
    Text = [[
Kamu menatap perhiasan-perhiasan berkilau itu dengan terpesona, tanpa sadar telah menggenggam tangan hitam kurus berlendir itu.
Dan ia hanya sedikit mempererat genggamannya, lalu melepaskannya.
Tidak ada yang terjadi, hanya Hanya Saja selarik asap hitam yang meluncur masuk ke balik lengan bajumu melalui ujung jarimu.]]
  },
  Event_7576_Name = {
    Text = "Membalikkan Cakar Iblis"
  },
  Event_7577_ChoiceDesc1 = {
    Text = "[Mendapatkan beberapa nada] Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7577_ChoiceDesc2 = {
    Text = "[Tutup penutupnya] Dapatkan 1 dari 3 Orison"
  },
  Event_7577_Desc = {
    Text = [[
Piano di samping dinding terbuka tutupnya. Piano tersebut memiliki tuts-tuts yang menguning serta tepi-tepi retak yang menampakkan warna kayu, namun setiap tutsnya telah dibersihkan dengan sangat bersih. 
 Piano itu adalah sumber kebahagiaan bagi banyak orang.]]
  },
  Event_7577_Name = {
    Text = "Melodi Masa Kecil"
  },
  Event_7578_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7578_Desc = {
    Text = [[
Pemegang tombak mendengus, menangis seperti anak yang sering di-bully.
Suara itu lenyap seketika, bersama dengan dua Pelaut lainnya juga menghilang tanpa jejak... Ternyata itu hanya ilusi yang dipantulkan oleh Domain.]]
  },
  Event_7578_Name = {
    Text = "Mengejar tanpa henti"
  },
  Event_7579_ChoiceDesc1 = {
    Text = "[Peroleh] Relik perak [(RelicConfig.Arg1)]"
  },
  Event_7579_Desc = {
    Text = [[
"Jawaban yang tepat."
Pemilik suara sangat puas dengan jawaban itu, sebuah benda berkilauan dilemparkan keluar dari permukaan air.
 "Ingatlah, segala sesuatu memiliki konsekuensi."]]
  },
  Event_7579_Name = {
    Text = "Suara di Luar Dunia"
  },
  Event_7580_ChoiceDesc1 = {
    Text = "[Mengusir Ilusi] Gejala infeksi."
  },
  Event_7580_ChoiceDesc2 = {Text = "[Keluar]"},
  Event_7580_Desc = {
    Text = "Wajah-wajah kabur tiba-tiba muncul, mengelilingi kamu dan merintih putus asa dengan suara yang seolah-olah tidak ada."
  },
  Event_7580_Name = {Text = "Ilusi"},
  Event_7581_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7581_Desc = {
    Text = [[
Kamu mengabaikan jejak ini dan melangkah maju. 
 Namun, seolah-olah terprovokasi, jejak itu semakin membesar dan semakin berkelok mengikuti langkahmu, seakan-akan sebuah tangan bisa muncul dari celah itu kapan saja dan menarikmu ke dalam.]]
  },
  Event_7581_Name = {
    Text = "Garis Retak Bergerak"
  },
  Event_7582_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7582_Desc = {
    Text = "Kamu tidak akan mudah tertipu, lalu dengan tegas berbalik badan dan meninggalkan tempat ini."
  },
  Event_7582_Name = {
    Text = "Garis Retak Bergerak"
  },
  Event_7583_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7583_Desc = {
    Text = "Kamu menyadari bahwa retakan itu tidak biasa, lalu berjongkok untuk memeriksanya. Anehnya, retakan yang tadi masih menyebar tiba-tiba terhenti seolah mati seketika, dan tenggelam dalam keheningan abadi."
  },
  Event_7583_Name = {
    Text = "Garis Retak Bergerak"
  },
  Event_7584_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7584_Desc = {
    Text = "\"Tidak, yang penting adalah pikiran yang jernih. Tekad saja tidak cukup untuk menyelesaikan Tubuh yang terlulur, Penjaga. Pikirkanlah strategi dengan baik.\""
  },
  Event_7584_Name = {
    Text = "Aturan Logan"
  },
  Event_7585_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7585_Desc = {
    Text = [[
Kamu tak bisa melawan dorongan di dalam hatimu. 
 Jari-jarimu seperti anak-anak yang tersesat di dalam hutan, berkeliaran dan bermain di atas papan ketik... 
 Perlahan-lahan, kupu-kupu mulai terbang keluar dari mesin tik. 
 Seekor, dua ekor, tiga ekor... 
 Di wajah, di jari-jari, sekumpulan kupu-kupu seperti kembang api yang mekar di udara, berkilauan dengan cahaya seperti permata dalam kegelapan. 
 Mesin tik ini tidak memiliki fungsi praktis, tetapi sangat ahli dalam menciptakan keindahan.]]
  },
  Event_7585_Name = {Text = "Mata"},
  Event_7586_ChoiceDesc1 = {
    Text = "[Mengikat ayam betina dengan baik]"
  },
  Event_7586_Desc = {
    Text = "Produk unggulan Raito, ayam betina yang penuh semangat, godaan bagi para pecinta kuliner."
  },
  Event_7586_Name = {
    Text = "Membuat jebakan"
  },
  Event_7587_ChoiceDesc1 = {
    Text = "[Selesai dengan gemilang]"
  },
  Event_7587_Desc = {
    Text = "Jebakan murah tapi berguna!"
  },
  Event_7587_Name = {
    Text = "Membuat jebakan"
  },
  Event_7588_ChoiceDesc1 = {
    Text = "[Menempatkan Perangkap Hewan]"
  },
  Event_7588_Desc = {
    Text = "Perangkap binatang berbahan logam, pembantu terbaik bagi Pemburu yang malas."
  },
  Event_7588_Name = {
    Text = "Membuat jebakan"
  },
  Event_7589_ChoiceDesc1 = {
    Text = "[Lihat telegraf] Terinfeksi \"(Skill.Arg1)\", memperoleh Relik emas \"(RelicConfig.Arg2)\""
  },
  Event_7589_ChoiceDesc2 = {
    Text = "[Mengabaikan] Mendapatkan 50 Segil Hitam"
  },
  Event_7589_Desc = {
    Text = [[
Kamu bersembunyi di celah gua yang sempit, untuk menghindari badai salju. Namun kamu tahu bahwa kamu tidak bisa berlama-lama di sini, jika sekelompok monster berbaju hitam menemukan tempat ini, kamu tidak akan punya jalan keluar. 
 Di sudut celah, kamu bahkan menemukan sebuah mesin telegraf.]]
  },
  Event_7589_Name = {
    Text = "Telegram Diam"
  },
  Event_7590_ChoiceDesc1 = {
    Text = "[Periksa Film] Tingkatkan secara acak efek Orison 2 Kartu"
  },
  Event_7590_ChoiceDesc2 = {
    Text = "[Periksa kamera] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7590_Desc = {
    Text = "Seperti menarik keluar sebagian isi perut, film di dalam kamera tercabik-cabik, dibuang begitu saja dengan perut terbuka di sini, tanpa ada yang peduli.\nSeberkas cahaya putih menyilaukan berkedip, kamera yang ditinggalkan di sudut jalan miring, shutter-nya ditekan entah dari mana.\n\"Klik——\"\nEkspresi terkejut dan bingungmu dengan setia tercatat pada gulungan film di dalam kamera."
  },
  Event_7590_Name = {
    Text = "Catatan Tidak Bersalah"
  },
  Event_7591_ChoiceDesc1 = {
    Text = "[Mencekik leher penyanyi] Mendapatkan Relik terkutuk \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7591_ChoiceDesc2 = {
    Text = "[Ganggu Langkah Penari] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7591_ChoiceDesc3 = {
    Text = "[Mengambil kertas naskah penyair] Mendapatkan 50 Segil hitam"
  },
  Event_7591_Desc = {
    Text = "Kamu terhalang oleh tiga bayangan kental. \n Satu sosok menyanyikan lagu dengan suara serak, liriknya aneh, kamu menutup telinga dan menghindarinya. \n Satu sosok menari dengan gerakan kaku, langkahnya ragu-ragu, kamu memejamkan mata dan menghindarinya. \n Satu sosok melafalkan puisi dengan irama yang patah, kalimatnya tidak jelas, kamu tidak bisa menahan diri lagi, jadi —"
  },
  Event_7591_Name = {
    Text = "Penjahat di Jalan Sempit"
  },
  Event_7592_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7592_Desc = {
    Text = "\"Tidak! Kemajuan manusia tidak bergantung pada sejarah, juga bukan teknologi, melainkan tikus.\"\n\"Tikuslah yang memulai zaman kegelapan itu, kemudian manusia menyambut fajar kebangkitan.\"\n\"Manusia membutuhkan kalian — meskipun tidak semua orang memahami hal ini.\"\nTikus-tikus itu tampak bingung dengan pidato panjangmu, namun tetap membiarkanmu pergi."
  },
  Event_7592_Name = {Text = "Wabah"},
  Event_7593_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7593_Desc = {
    Text = [[
Kamu menahan kedutan saraf penglihatanmu, sulit untuk mengenali...
 Di sana tampaknya digambar sebuah lingkaran sihir yang sudah dicabik-cabik. 
 Di dalam lingkaran sihir tersebut terdiri dari tak terhitung garis lengkung, seolah-olah statis namun juga mengalir, membuatmu pusing dan terpesona.]]
  },
  Event_7593_Name = {Text = "dari sudut"},
  Event_7594_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7594_Desc = {
    Text = [[
<Bold>Museum Lilin Rogers
Jalan Southwark No. 44, Kota Londinium@2 Zona
Jam kunjungan: 21:00-6:00
Penghentian masuk pukul 3:00 (tutup akhir pekan)

<Bold>Pameran Saat Ini
Vladimir@2:
Filsafat Senyuman]]
  },
  Event_7594_Name = {
    Text = "Tawa dalam Kegelapan"
  },
  Event_7595_ChoiceDesc1 = {
    Text = "[Menatap] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7595_ChoiceDesc2 = {
    Text = "[Tutup mata] Pilih 1 Pembangun untuk Bangun, infeksi [(Skill.Arg1)]"
  },
  Event_7595_ChoiceDesc3 = {
    Text = "[Mendapatkan] 25 Segil Hitam"
  },
  Event_7595_Desc = {
    Text = "Seharusnya tidak ada bintang di langit. \n Di dalam Domain kapal Sonanir, langit berkilau dengan cahaya yang indah, bentuk bintang dan bulan semuanya tersembunyi. \n Di dalam kabin yang redup, seharusnya kamu juga tidak melihat langit berbintang. \n Di sini seharusnya hanya ada lampu pijar yang tersebar dan lentera tua—tapi mengapa, kamu masih merasakan pandangan yang tergantung di langit?"
  },
  Event_7595_Name = {
    Text = "Melihat secara diam-diam"
  },
  Event_7596_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7596_Desc = {
    Text = "Kamu memilih untuk berani menatap langsung ke matanya. \nMereka adalah bintang gemilang yang berkilauan dalam kegelapan. \nLalu mereka tertawa, berubah menjadi banyak bulan sabit yang tak terhitung jumlahnya. \nMata itu berkata: \"Kamu tidak takut pada pandangan. Kamu juga tidak seharusnya takut… Sudah lama tidak bertemu, @2\" \nSebelum menghilang, mereka memberikanmu sebuah hadiah kecil, sebagai \"Peringatan reuni\"."
  },
  Event_7596_Name = {Text = "Mata"},
  Event_7597_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7597_Desc = {
    Text = "Jembatan rel, pembuluh darah dan saraf Londinium, tautan antara jantung dan anggota tubuh kota. Selama matahari belum terbenam dari tempat ini, jantung Londinium akan terus berdetak dengan penuh semangat."
  },
  Event_7597_Name = {
    Text = "Fatamorgana Jembatan Baja"
  },
  Event_7598_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7598_Desc = {
    Text = "Sebuah fugue yang sangat megah, komposer tidak diketahui. \nBanyak suara dengan tema serupa saling bertautan dan mengalir deras, setiap not seperti pisau bedah seorang dokter — presisi dan kejam. \nPresisi dan kemegahan — inilah estetika Rogers. \nFuga, terbanglah!"
  },
  Event_7598_Name = {
    Text = "selera yang buruk"
  },
  Event_7599_ChoiceDesc1 = {
    Text = "[Mengucapkan salam]"
  },
  Event_7599_ChoiceDesc2 = {
    Text = "[Mencari Bantuan]"
  },
  Event_7599_Desc = {
    Text = [[
Saat tanganmu menyentuh tepi kapal, kamu melihat seorang gadis berbaju putih. 
Anggun, suci, dan samar... serta sedikit akrab. 
Di mana sebenarnya kamu pernah melihatnya? Kamu sedang berusaha keras menggali ingatan yang kacau, namun dia tiba-tiba seolah menyadari keberadaanmu, menatapmu dari kejauhan. 
Mata gadis itu tenang seperti laut di awal musim semi, namun anehnya kamu bisa membaca sesuatu dari dalamnya... 
Dia sepertinya sedang menunggu kamu untuk menyapanya, bahkan jika hanya untuk membicarakan cuaca hari ini.]]
  },
  Event_7599_Name = {
    Text = "Gadis berbaju putih"
  },
  Event_7600_ChoiceDesc1 = {
    Text = "[Puji itu] Pilih 1 dari 3 Kartu Perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_7600_ChoiceDesc2 = {
    Text = "[Mengejeknya] Infeksi \"(Skill.Arg1)\", orison acak lainnya"
  },
  Event_7600_Desc = {
    Text = [[
Jenkin berkata: Johnny! Kamu memang sangat berbeda dari sebelumnya... dalam segala hal. 
 Kamu berkata: Kamu benar-benar otak yang rajin dan penuh ambisi. 
 Otak itu tampak sangat senang setelah bergerak-gerak beberapa kali. 
 Otak itu berkata: Ayo! Karena kalian begitu menghargai pencapaianku saat ini, aku akan memberikan semua yang aku pelajari seumur hidupku...]]
  },
  Event_7600_Name = {
    Text = "Otak filsafat"
  },
  Event_7601_ChoiceDesc1 = {
    Text = "[Fuge yang megah] mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7601_ChoiceDesc2 = {
    Text = "[Serenade Sederhana] Semua Pembangun memulihkan 50 Aliemus dan terinfeksi [(Skill.Arg1)]"
  },
  Event_7601_ChoiceDesc3 = {
    Text = "[Suara tanpa makna] Dapatkan 1 dari 3 Orison"
  },
  Event_7601_Desc = {
    Text = [[
"Secara pribadi, saya tidak terlalu setuju dengan selera musik sang kurator, kamu mengerti...
Itu terlalu berlebihan, sedangkan saya adalah orang yang lebih suka hal-hal sederhana."
Suara lelah seorang pria terdengar dari gramofon yang berderit, mengeluh dengan nada kesepian.
"Tapi ini pekerjaan saya... baiklah, mari kita hemat waktu, pilih saja salah satu."]]
  },
  Event_7601_Name = {
    Text = "selera yang buruk"
  },
  Event_7602_ChoiceDesc1 = {
    Text = "[Ada Relik khusus, memperoleh Relik emas \"(RelicConfig.Arg1)\"]"
  },
  Event_7602_ChoiceDesc2 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_7602_Desc = {
    Text = "Acara 253 (dalam pengembangan), bukan Efek akhir"
  },
  Event_7602_Name = {
    Text = "Acara 253 (dalam pengembangan)"
  },
  Event_7603_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7603_Desc = {
    Text = "Kamu berlari secepat mungkin menjauh dari lokasi. \n Sekarang kalian menghadapi monster yang paling sulit dan menjijikkan dalam sejarah — patung lilin yang sangat banyak itu. \n Dibandingkan dengan mereka, beberapa patung lilin mentah ini memang terlihat kurang mencolok. \n Memisahkan hal-hal yang penting dan yang tidak penting — ini adalah salah satu prinsip yang harus dijunjung tinggi oleh Penjaga."
  },
  Event_7603_Name = {Text = "Latihan"},
  Event_7604_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7604_Desc = {
    Text = [[
Kunci perak berkilauan, cahaya redup perak memenuhi ruang, mengubah aliran kental warna-warni menjadi perak murni. 
 Cahaya itu lenyap dalam sekejap, hanya angin yang meninggalkan tangisan pilu.]]
  },
  Event_7604_Name = {
    Text = "Warna yang Mengingatkan"
  },
  Event_7605_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7605_Desc = {
    Text = "Pelangi itu membuatmu terpesona, tanpa sadar kamu tenggelam dalam keindahannya..."
  },
  Event_7605_Name = {
    Text = "Persimpangan Bintang"
  },
  Event_7606_ChoiceDesc1 = {
    Text = "[Melanjutkan Jatuh] Terinfeksi [(Skill.Arg1)], apakah akan terus jatuh?"
  },
  Event_7606_ChoiceDesc2 = {
    Text = "[Meninggalkan pertarungan] Mendapatkan 25 Segil Hitam"
  },
  Event_7606_Desc = {
    Text = [[
"Kamu"mengundangmu. 
Di kedalaman spiral, "kamu"dari masa lalu dan masa depan memberikanmu "hadiah"dari Dimensi yang berbeda.]]
  },
  Event_7606_Name = {
    Text = "Jurang Spiral"
  },
  Event_7607_ChoiceDesc1 = {
    Text = "[Mengerti sepenuhnya] Memperoleh Relik emas \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7607_ChoiceDesc2 = {
    Text = "[Mendapatkan 1 dari 3 pilihan Relik emas, terinfeksi \"(Skill.Arg1)\"]"
  },
  Event_7607_ChoiceDesc3 = {
    Text = "[Peroleh] Relik perak [(RelicConfig.Arg1)]"
  },
  Event_7607_Desc = {
    Text = "Dua sosok bercahaya perak muncul di hadapanmu, tampak seperti cairan kental yang melayang di udara. \n \"Inilah tempat aku musnah.\" Salah satu sosok itu berjongkok. \n \"Di ranah dewa yang bebas dari penyakit dan bencana, tidak ada yang namanya keinginan atau kehilangan, kamu sebenarnya tidak benar-benar tahu — apa artinya musnah.\"\nSosok lainnya menghela napas, memindahkan pandangannya ke arahmu."
  },
  Event_7607_Name = {
    Text = "Ranah dewa yang hilang"
  },
  Event_7608_ChoiceDesc1 = {
    Text = "[Keluar] Mencari lampu sorot"
  },
  Event_7608_ChoiceDesc2 = {
    Text = "[Masuk ke Kabut] Infeksi [(Skill.Arg2)]"
  },
  Event_7608_ChoiceDesc3 = {
    Text = "[Langsung Masuk]"
  },
  Event_7608_Desc = {
    Text = [[
Di depan terdapat kabut hitam pekat, masuk secara sembrono akan mendatangkan Clades. 
 Mungkin kamu harus menemukan "Lampu Sorot"untuk mengusir kabut tersebut.]]
  },
  Event_7608_Name = {
    Text = "tidak dikenal"
  },
  Event_7609_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7609_Desc = {
    Text = [[
"Itu adalah proyeksi dari memori,"Ramona menjelaskan kepadamu, "mungkin milik seseorang, atau mungkin kenangan bersama dari beberapa orang."
Kenangan yang berharga, patut dijaga dengan hati-hati.]]
  },
  Event_7609_Name = {
    Text = "Kenangan Kami"
  },
  Event_7610_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7610_Desc = {
    Text = [[
Meskipun sekarang tidak bisa dibaca, kamu tidak menyerah, tetapi dengan sabar melipatnya dan menyimpannya di saku, menunggu untuk mencari cara lain untuk membaca informasi setelah kembali ke sekolah. 
 Hanya saja, seiring dengan surat yang secara aneh mengkerut tanpa sebab, dada kamu juga mulai terasa sakit.]]
  },
  Event_7610_Name = {
    Text = "Surat yang Digores"
  },
  Event_7611_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7611_Desc = {
    Text = "Saat lilin meninggalkan timbangan, ia langsung menyala dengan sendirinya. Lilin itu meneteskan air mata berwarna putih susu yang dengan cepat jatuh melalui celah di antara jari-jari Anda dan menghilang tanpa jejak."
  },
  Event_7611_Name = {
    Text = "Kebijaksanaan dan Emosi"
  },
  Event_7612_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7612_Desc = {
    Text = [[
Kamu menarik kertas itu dengan cepat, tetapi mesin tik masih beroperasi. Ia menarik masuk sebuah kartu, dan menutupi kartu itu dengan tinta. 
 Kamu dengan cermat mengenali, sepertinya tertulis berulang-ulang "jangan menatap langsung, jangan menatap langsung, jangan menatap langsung, jangan menatap langsung, jangan menatap langsung".]]
  },
  Event_7612_Name = {
    Text = "Peringatan Tidak Diundang"
  },
  Event_7613_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7613_Desc = {
    Text = [[
Saat ujung jari menyentuh tepi cangkir yang begitu dingin hingga membuat sumsum tulang membeku, kamu tiba-tiba tersentak dan sadar kembali. 
 Bagaimanapun juga, itu tidak cocok dibiarkan di pinggir jalan. Sebaiknya simpan saja ke dalam koper.]]
  },
  Event_7613_Name = {
    Text = "Wine Manis Madu"
  },
  Event_7614_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7614_Desc = {
    Text = [[
Kamu batuk keras.
Sepertinya suara itu terkejut, lalu jatuh ke dalam keheningan yang mencekam.
Kamu merasa seolah-olah melewatkan petunjuk penting...
Tapi hidup selalu penuh dengan kehilangan dan penyesalan, bukan begitu?]]
  },
  Event_7614_Name = {
    Text = "Dinding memiliki telinga"
  },
  Event_7615_ChoiceDesc1 = {
    Text = "[Menutup Mulut Rapat-rapat] Mendapatkan 25 Segil Hitam"
  },
  Event_7615_ChoiceDesc2 = {
    Text = "[Menyentuh] 50% kesempatan mendapatkan 50 Segil Hitam, 50% kesempatan tidak mendapatkan apa-apa"
  },
  Event_7615_Desc = {
    Text = "\"Apa yang ingin kukatakan hanya satu pepatah—tidak ada yang bisa membunuh seekor kucing!\"\n\"Kucing hitam sial itu seharusnya dibedah, dan dibuang begitu saja, tetapi ia menggali makam keluargaku, daging manusia yang tersisa ditelannya habis, sementara tulang dan anggota tubuh tersebar di mana-mana.\"\n\"Di bawah tatapan sinis yang dingin dan gelap, nanah kuning kehitaman muncul dengan bau busuk, aku melarikan diri dengan terhuyung-huyung, tersiksa oleh mimpi buruk.\"\n\"Tunggu… kalian mau apa, aku tidak gila! Aku tidak! Kalian pasti menyembunyikan sesuatu! Ini nyata—\"\nIni memang nyata, saat melihat bayangan orang gila menghilang, kau bertemu tatapan kucing hitam yang duduk diam di kaki."
  },
  Event_7615_Name = {
    Text = "Malapetaka Kucing Malam"
  },
  Event_7616_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7616_Desc = {
    Text = "Saat kau ragu, ia tenggelam dan melebur ke dalam D-marka, lalu segera menghilang."
  },
  Event_7616_Name = {
    Text = "Objek Mengapung di Dalam Ember"
  },
  Event_7617_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7617_Desc = {
    Text = "Dengan kesal, kamu meremas kertas surat itu menjadi gumpalan dan melemparkannya ke samping kakimu."
  },
  Event_7617_Name = {
    Text = "Surat yang Digores"
  },
  Event_7618_ChoiceDesc1 = {Text = "[OK]"},
  Event_7618_Desc = {
    Text = "Kamu berkonsentrasi dengan roh, ilusi itu memudar seperti tinta yang menyebar. Kamu melanjutkan langkahmu ke depan, namun tidak bisa sepenuhnya menghilangkan bayang-bayang kelam di hatimu."
  },
  Event_7618_Name = {Text = "Ilusi"},
  Event_7619_ChoiceDesc1 = {
    Text = "[Perhatikan dengan hati-hati] Mendapatkan Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7619_ChoiceDesc2 = {
    Text = "[Menghindari bayangan] memperoleh Relik perak \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7619_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_7619_Desc = {
    Text = [[
Saraf Ramona menegang, bergerak hati-hati menghindari kerumunan di rumah sakit jiwa. 
Dia bersembunyi di dalam ruangan kecil. 
Tiba-tiba bayangan seseorang muncul di luar jendela.]]
  },
  Event_7619_Name = {
    Text = "Refleksi di Jendela"
  },
  Event_7620_ChoiceDesc1 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_7620_Desc = {
    Text = "Sekarang, hal yang lebih penting adalah membawa pelaku penyebab semua ini ke pengadilan. Namun, benih kemarahan masih tertanam dan tumbuh di hatimu. Tanpa menunggu kalian merespons, pria itu berbalik dan pergi."
  },
  Event_7620_Name = {
    Text = "Jejak Binatang Raksasa"
  },
  Event_7621_ChoiceDesc1 = {
    Text = "[Pergi] mendapatkan 75 Segil Hitam, terinfeksi [(Skill.Arg2)]"
  },
  Event_7621_Desc = {
    Text = "Pendidikan yang kamu terima sejak kecil di Mythag membuatmu tidak bisa mengabaikan cetakan ini. Kamu mengusap debu dan jejak kaki, dan pada saat itu, kamu seolah mendengar respons dari dimensi yang jauh, \"Terima kasih\"."
  },
  Event_7621_Name = {
    Text = "Jejak Binatang Raksasa"
  },
  Event_7622_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7622_Desc = {
    Text = "Kamu menggenggam erat kunci perak, cahaya perak yang lembut dan getaran halus membuatmu merasa tenang. Pandanganmu seolah-olah menghilang, namun mungkin juga tidak; bagaimanapun, itu meninggalkan jejak tak terlihatnya padamu."
  },
  Event_7622_Name = {
    Text = "Siapa yang melihat"
  },
  Event_7623_ChoiceDesc1 = {
    Text = "[Mencari Jalan Rahasia]"
  },
  Event_7623_Desc = {
    Text = [[
Kamu dan Ramona, Lotan berpisah menjadi tiga jalur, mulai mengejar Anjing neraka.

Kamu berlari cepat melewati beberapa gang, tubuh besar itu muncul di depanmu.
Ia melihatmu mengejar, segera berbelok ke sudut berikutnya.
Kamu berlari mengejarnya, tetapi yang muncul di depanmu adalah jalan buntu, tiga dinding tinggi menghalangi langit berbentuk persegi yang sempit.]]
  },
  Event_7623_Name = {
    Text = "Jalan buntu"
  },
  Event_7624_ChoiceDesc1 = {
    Text = "[Melangkah]"
  },
  Event_7624_ChoiceDesc2 = {Text = "[Memeluk]"},
  Event_7624_Desc = {
    Text = [[
Di samping tempat tidur operasi yang bersih dan lembut, terbaring tubuh Kum yang sudah lunglai.
Dia masih sangat tinggi besar, seperti gunungan kecil, sama seperti saat kau pertama kali melihatnya.
Namun, dibandingkan dengan "Anjing neraka"sejati di angkasa, dia begitu kecil, sekecil seorang anak.]]
  },
  Event_7624_Name = {Text = "Sisa Panas"},
  Event_7625_ChoiceDesc1 = {
    Text = "[Memperoleh Inti Perak]"
  },
  Event_7625_Desc = {
    Text = [[
Eh, di depan sepertinya ada banyak benda berkilauan!
Cium-cium... wangi sekali.
Jilat-jilat... dingin sekali!
Kelihatannya ini adalah sesuatu yang sangat berharga, cepat simpan dan berikan pada Jenkin kecil, mungkin bisa ditukar dengan banyak keju!]]
  },
  Event_7625_Name = {Text = "Bercahaya"},
  Event_7626_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7626_Desc = {
    Text = "Rasa kecewa yang tidak berasal dari dirimu perlahan menyebar di hatimu, jaring ilusi perlahan memudar, membuka sebuah jalan."
  },
  Event_7626_Name = {
    Text = "Jaringan Wandering"
  },
  Event_7627_ChoiceDesc1 = {
    Text = "[Bangun Itu] Bangun secara acak 1 Pembangun, terinfeksi [(Skill.Arg1)]"
  },
  Event_7627_ChoiceDesc2 = {
    Text = "[Abaikan itu] Dapatkan 1 dari 3 Orison"
  },
  Event_7627_Desc = {
    Text = "Rune-rune yang mengalir keluar dari raungan makhluk hidup berbentuk ikan, mereka memenuhi saluran telingamu, rongga hidungmu, tenggorokanmu. Mereka membakar tubuhmu, hanya dalam sepuluh detik lagi, kamu akan memahami makna mendalam dari raungan itu..."
  },
  Event_7627_Name = {
    Text = "Rune Madness"
  },
  Event_7628_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7628_Desc = {
    Text = [[
Kamu menggertakkan gigi dan mencoba menahan Fatamorgana yang membingungkan itu. Ramona meletakkan sebuah benda dingin di telapak tanganmu. 
"Ini adalah Relik yang baru saja kitemukan, mungkin bisa membantu kamu."]]
  },
  Event_7628_Name = {
    Text = "Ilusi Dimensi"
  },
  Event_7629_ChoiceDesc1 = {
    Text = "Pilih Orison Tingkat Lanjut"
  },
  Event_7630_ChoiceDesc1 = {
    Text = "[Menahan Gagak] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_7630_ChoiceDesc2 = {
    Text = "[Membunuh Gagak] Mendapatkan 1 dari 3 Orison"
  },
  Event_7630_ChoiceDesc3 = {Text = "[Keluar]"},
  Event_7630_Desc = {
    Text = "Gagak kesepian itu dengan suara serak mencabut bulu-bulu hitamnya satu per satu. \n Ia gemetar karena rasa sakit, berteriak tajam, namun tak mampu menghentikan gerakannya yang semakin cepat. \n \"Gak——Gak——\" \n Air mata biru bercampur cairan hitam mengalir dari matanya, hanya kau yang menyaksikannya, tak seorang pun lainnya. \n"
  },
  Event_7630_Name = {
    Text = "Air Mata Magma"
  },
  Event_7631_ChoiceDesc1 = {
    Text = "[Meninggalkan] Meningkatkan Arg1 poin Kesehatan maksimum"
  },
  Event_7631_Desc = {
    Text = "“Biarkan aku yang mengurusnya,” kamu mengelus punggung monster seolah-olah menenangkan kucing kecil yang marah, “dia pasti akan bangun, kami tidak akan menyakitinya.”"
  },
  Event_7631_Name = {
    Text = "Panggilan Persahabatan"
  },
  Event_7632_ChoiceDesc1 = {
    Text = "[Meninggalkan] Meningkatkan Arg1 poin Kesehatan maksimum, terinfeksi \"(Skill.Arg2)\" serta \"(Skill.Arg3)\""
  },
  Event_7632_Desc = {
    Text = "\"Bangun, Lily, Kum juga berharap kau bisa segera sadar——\""
  },
  Event_7632_Name = {
    Text = "Panggilan Persahabatan"
  },
  Event_7633_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_7633_Desc = {
    Text = "Sudah menjadi benda yang tidak berguna."
  },
  Event_7633_Name = {
    Text = "Telegram Diam"
  },
  Event_79429_ChoiceDesc1 = {
    Text = "Pilih satu Pembangun untuk diubah menjadi \"Ras Serangga\" melalui Ritual Kehidupan. Kartu perintah \"Ras Serangga\" mengurangi konsumsi Aritmetika -1, tetapi setelah dikeluarkan menghabiskan."
  },
  Event_79429_Desc = {
    Text = [[
"Proses mengenali diri sendiri selalu disertai dengan rasa sakit, begitu pula dengan berkembang dan kelahiran kembali."
Dia tersenyum lembut, menyentuh wajah Anda dengan kasih sayang.
 "Jangan takut, aku di sini menemanimu, maka bukalah jiwamu kepada segala sesuatu, terimalah semuanya."
 "Anak manis, aku menunggu kelahiran kembalimu, menunggumu untuk menjadi bagian dari kami."]]
  },
  Event_79429_Name = {
    Text = "Metamorfosis hidup"
  },
  Event_80463_ChoiceDesc1 = {
    Text = "[Keluar] Mendapatkan 1 dari 3 Relik perak, terinfeksi [(Skill.Arg1)]"
  },
  Event_80463_Desc = {
    Text = [[
Kamu memilih jalan, menarik William kecil dan berlari sekuat tenaga.
Beruntung, pilihanmu benar.
Kau berhasil terlepas dari pengaruh kotor, dari banyak Clementine yang sama.
Tentu, kamu membayar beberapa harga.]]
  },
  Event_80463_Name = {
    Text = "\"Clementine\"-nya"
  },
  Event_80464_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80464_Desc = {
    Text = [[
Sebuah ingatan yang melampaui pemahaman disuntikkan ke dalam otakmu, menghancurkan rasionalitasmu langsung.
Dalam gambar yang seolah dipercepat, satu-satunya adegan yang kamu ingat adalah: kuil segitiga
Itu adalah karya besar @2 ras serangga untuk kebodohan yang hebat @4.]]
  },
  Event_80464_Name = {
    Text = "Memori Dalam"
  },
  Event_80465_ChoiceDesc1 = {
    Text = "[Keluar] Pilih 1 Pembangun untuk dibangunkan, infeksi [(Skill.Arg1)]"
  },
  Event_80465_Desc = {
    Text = [[
Kamu memilih jalan, menarik William kecil dan berlari sekuat tenaga.
Beruntung, pilihanmu benar.
Kau berhasil terlepas dari pengaruh kotor, dari banyak Clementine yang sama.
Tentu, kamu membayar beberapa harga.]]
  },
  Event_80465_Name = {
    Text = "\"Clementine\"-nya"
  },
  Event_80466_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80466_Desc = {
    Text = [[
"Klik. Klik. Klik"
'pekerjaan' akhirnya selesai, namun selain 'pekerjaan' itu sendiri, apa lagi yang kau dapatkan?]]
  },
  Event_80466_Name = {
    Text = "Torture abadi"
  },
  Event_80467_ChoiceDesc1 = {
    Text = "[Pergi] Mendapatkan 1 dari 3 pilihan Orison"
  },
  Event_80467_Desc = {
    Text = [[
"Senang mendengar jawaban jujurmu."
"Sampai jumpa, di pertemuan kami berikutnya."]]
  },
  Event_80467_Name = {
    Text = "Panggilan dalam mimpi"
  },
  Event_80468_ChoiceDesc1 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_80468_Desc = {
    Text = [[
"Ah ya, benar-benar anak yang tidak jujur."
"Tapi tidak apa-apa, lain kali, aku akan membuatmu mengucapkan kebenaran."
"Semua, kebenaran yang keluar dari hati dan jiwa."]]
  },
  Event_80468_Name = {
    Text = "Panggilan dalam mimpi"
  },
  Event_80469_ChoiceDesc1 = {
    Text = "[Mulai\"Bekerja\"]menghapus 1 kartu perintah, mendapatkan Arg1 Segil hitam"
  },
  Event_80469_ChoiceDesc2 = {
    Text = "[Mundur jauh]"
  },
  Event_80469_Desc = {
    Text = [[
"Klik."
Suara mesin ketik terdengar, sebelum 'pekerjaan' selesai, kau selamanya adalah budaknya.]]
  },
  Event_80469_Name = {
    Text = "Torture abadi"
  },
  Event_80470_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80470_Desc = {
    Text = [[
"Sangat disayangkan, kehati-hatianmu membuatmu kehilangan satu-satunya kesempatan untuk mengetahui kebenaran."
Ia menghela napas, hancur tanpa suara.]]
  },
  Event_80470_Name = {
    Text = "Memori Dalam"
  },
  Event_80471_ChoiceDesc1 = {
    Text = "[Serangan penuh]"
  },
  Event_80471_ChoiceDesc2 = {
    Text = "[Dan berperang sambil mundur]"
  },
  Event_80471_Desc = {
    Text = "Sosok yang tak terduga muncul di hadapanmu, itu adalah Clementine.\n\"Jangan terkejut, saya hanya ingin melakukan sebuah tes khusus.\"\n\"Mengenai apa yang diuji, itu adalah rahasia.\" Clementine tersenyum, \"Bagi kamu, satu-satunya konten dari tes ini——\"\n\"adalah bertahan hidup.\""
  },
  Event_80471_Name = {Text = "Tes Khusus"},
  Event_80472_ChoiceDesc1 = {
    Text = "[Kenangan Masa Lalu]"
  },
  Event_80472_ChoiceDesc2 = {
    Text = "[Cabut Sisik Serangga]"
  },
  Event_80472_Desc = {
    Text = [[
"Percayalah, aku tidak bermaksud buruk, aku hanya ingin membantumu."
Clementine mengejarmu, berteriak keras.
Suara dia terdengar sangat tulus, namun kau sudah tidak bisa mempercayai apa pun lagi.
Moralitasmu telah ditembus oleh "Teori Kognisi Berwujud", dan rasionalitasmu akan segera hancur.
Kau harus, harus melakukan sesuatu, melawan sisik serangga yang tumbuh di dagingmu, melawan kegilaan dan keputusasaan yang perlahan meresap ke dalam jiwamu.]]
  },
  Event_80472_Name = {
    Text = "Jiwa yang berjuang"
  },
  Event_80473_ChoiceDesc1 = {
    Text = "[Keluar] Hapus 2 Kartu"
  },
  Event_80473_Desc = {
    Text = [[
"Ingin menyimpan kekuatan untuk menghadapi pertempuran akhir?"
"Pilihan yang sangat cerdas. Namun, saat seseorang memperoleh, mereka sebenarnya juga kehilangan."
"Karena dalam dunia yang terbakar dan kejam ini, bertahan hidup itu sendiri, membutuhkan pengorbanan."]]
  },
  Event_80473_Name = {Text = "Tes Khusus"},
  Event_80474_ChoiceDesc1 = {
    Text = "[Abaikan itu] Dapatkan 1 dari 3 Orison"
  },
  Event_80474_ChoiceDesc2 = {
    Text = "[Menyentuhnya] 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_80474_Desc = {
    Text = [[
Sesuatu yang aneh mirip spora menarik perhatianmu.
Ia seperti ubur-ubur tipis yang terbuat dari daging, dan seperti serat saraf yang menyimpan sinyal di dalam otak.
"Datang dan sentuh saya." Ia menggoda tanpa suara, "Saya akan, menunjukkan kepada Anda sebuah kenangan yang kejam."]]
  },
  Event_80474_Name = {
    Text = "Memori Dalam"
  },
  Event_80475_ChoiceDesc1 = {
    Text = "[Pergi] Mendapatkan 1 dari 3 pilihan Orison"
  },
  Event_80475_Desc = {
    Text = [[
"Ramona, Boneka, Lotan, Ogier......"
Kau terus-menerus mengulangi nama-nama ini dengan saraf yang tegang.
Rasionalitasmu yang hancur sudah tidak mampu mengingat seperti apa mereka, tapi eksistensi yang diwakili oleh nama-nama ini masih bisa menghangatkan hatimu dan jiwa.
Mereka pernah ada, mereka pernah tertawa, mereka...... adalah garis batas dan jangkar yang kau pertahankan untuk tetap berperikemanusiaan saat ini.]]
  },
  Event_80475_Name = {
    Text = "Jiwa yang berjuang"
  },
  Event_80476_ChoiceDesc1 = {
    Text = "[Keluar] Dapatkan 1 dari 3 pilihan Relik perak, terinfeksi [(Skill.Arg1)]"
  },
  Event_80476_Desc = {
    Text = "\"Aaaaaah——\"\nKau membuka mulut, berteriak, suaranya lebih mirip jeritan daripada teriakan.\nSisik serangga yang tercabut itu tumbuh kembali, dan akal yang hancur, pergi tanpa kembali."
  },
  Event_80476_Name = {
    Text = "Jiwa yang berjuang"
  },
  Event_80477_ChoiceDesc1 = {
    Text = "[Peroleh] Relik \"(RelicConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_80477_Desc = {
    Text = [[
Kamu tidak menyembunyikan sesuatu, memberikan segalanya. Sikap ini jelas menyenangkan bagi Clementine.
"Benar-benar anak yang baik."
"Kalimat seperti itu, akan sedikit memberi hadiah padamu. Tentu saja, itu ada harganya."
"Dalam dunia yang penuh api dan kekejaman ini, bertahan hidup itu sendiri memerlukan membayar harga."]]
  },
  Event_80477_Name = {Text = "Tes Khusus"},
  Event_80478_ChoiceDesc1 = {
    Text = "[Mulai\"Bekerja\"]menghapus 1 kartu perintah, mendapatkan Arg1 Segil hitam"
  },
  Event_80478_ChoiceDesc2 = {
    Text = "[Mundur jauh]"
  },
  Event_80478_Desc = {
    Text = [[
"Klik. Klik."
Suara mesin ketik terdengar, saat 'pekerjaan' berlangsung, kau hanyalah alat untuk menyelesaikan 'pekerjaan'.]]
  },
  Event_80478_Name = {
    Text = "Torture abadi"
  },
  Event_80479_ChoiceDesc1 = {
    Text = "[Lari ke kiri]"
  },
  Event_80479_ChoiceDesc2 = {
    Text = "[Lari ke kanan]"
  },
  Event_80479_Desc = {
    Text = [[
Sosok yang akrab mengejarmu dengan erat, bukan satu atau dua, tetapi puluhan atau ratusan.
Koridor sempit ini sulit menampung begitu banyak "Clementine," sehingga beberapa "Clementine" terjatuh, beberapa "Clementine" terinjak menjadi lumpur.
Tetapi mereka semua bersatu memanggilmu, mengulang kalimat yang membuatmu terperangkap dalam pencemaran mental.
"Mengapa harus melarikan diri? Aku hanya ingin memberimu konseling psikologis." 
Dan kamu, berlari liar di koridor panti rehabilitasi, menghadapi pilihan di persimpangan.]]
  },
  Event_80479_Name = {
    Text = "\"Clementine\"-nya"
  },
  Event_80480_ChoiceDesc1 = {
    Text = "[Mulai\"Bekerja\"]menghapus 1 kartu perintah, mendapatkan Arg1 Segil hitam"
  },
  Event_80480_ChoiceDesc2 = {
    Text = "[Mundur jauh]"
  },
  Event_80480_Desc = {
    Text = [[
"Modifikasi! Bekerja! Jangan berhenti!"
Tak terhitung dengungan menggema di telingamu, membuatmu tanpa sadar mendekati mesin ketik yang tiba-tiba muncul.
"Apa yang harus dilakukan, apa yang harus dilakukan, sudah dari pagi mengetik hingga malam, tapi pekerjaan tak juga ada habisnya."
"Modifikasi! Modifikasi! Modifikasi rencana, ajukan permintaan, selesaikan pekerjaan!"
"Bekerja! Bekerja!! Bekerja!!!"
Roh yang berdengung menerjang mesin ketik yang terus mengetik, akhirnya, mesin ketik itu akhirnya berhenti.
Namun sesaat kemudian, mesin ketik itu kembali beroperasi
"Modifikasi! Bekerja! Jangan berhenti!"
Karena pekerjaan, tak ada ujungnya.]]
  },
  Event_80480_Name = {
    Text = "Torture abadi"
  },
  Event_80481_ChoiceDesc1 = {
    Text = "[Jawab Seperti Apa Adanya]"
  },
  Event_80481_ChoiceDesc2 = {
    Text = "[Tolak Menjawab]"
  },
  Event_80481_Desc = {
    Text = [[
Sekejap, pemandangan di depanmu menjadi kabur dan ilusi.
Kamu kira ruangan itu melengkung dan berubah, tetapi kemudian kamu mengerti bahwa saraf optikmu telah disusupi.
"Kita bertemu lagi."
Dalam pandangan yang samar, Clementine tersenyum lembut.
"Meskipun lebih cepat dari yang dimaksudkan, aku tetap senang. Apakah %player% kamu merasakan hal yang sama?"]]
  },
  Event_80481_Name = {
    Text = "Panggilan dalam mimpi"
  },
  Event_80595_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80595_Desc = {
    Text = "\nMenghadapi usahamu untuk mengusir, kupu-kupu tidak menunjukkan reaksi.\nIa bersikukuh mengejar telapak tanganmu, kehilangan kehidupannya di telapak tanganmu.\n\"Ah, begitu hangat……\"\nIni adalah suara terakhirnya."
  },
  Event_80595_Name = {
    Text = "Mimpi kupu-kupu"
  },
  Event_80596_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80596_Desc = {
    Text = [[
"Saya ingin bunga selalu mekar, saya ingin senyuman abadi ada."
 "Saya ingin semua yang terkena pelarutan dapat sembuh dan aman, saya ingin dunia ini kembali seperti dulu, tidak lagi membakar."
 "Saya ingin..."
Kupu-kupu kecil mengibaskan sayapnya, kehilangan kehidupannya di telapak tanganmu.
Setidaknya, ada yang mendengarkan suaranya.]]
  },
  Event_80596_Name = {
    Text = "Mimpi kupu-kupu"
  },
  Event_80597_ChoiceDesc1 = {
    Text = "[Mengusir Kupu-Kupu] 1 Kartu perintah acak mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_80597_ChoiceDesc2 = {
    Text = "[Dengarkan Keinginan]dari 3 kartu perintah memilih 1 untuk mendapatkan Orison:[(EnchantConfig.Arg1)]"
  },
  Event_80597_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_80597_Desc = {
    Text = [[
Kupu-kupu kecil, juga memiliki banyak mimpi.
Mimpi-mimpi ini tersebar di lautan bunga, di ruang perawatan, dan juga di altar @2 yang penuh dengan banyak darah dan daging.
Kini, ia akhirnya menunggu orang yang terikat, tidak tahu apakah kamu mau mendengarkan harapan kecilnya yang kecil.]]
  },
  Event_80597_Name = {
    Text = "Mimpi kupu-kupu"
  },
  Event_80610_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80610_Desc = {
    Text = [[
"Rasionalitas? Jawaban yang menarik."
 "Semoga kau tidak akan menyesal dengan pilihanmu."]]
  },
  Event_80610_Name = {
    Text = "Bayaran Kemanusiaan"
  },
  Event_80612_ChoiceDesc1 = {
    Text = "[Memberi Makan Mereka]mendapatkan Relik perak[(RelicConfig.Arg1)], memilih untuk terinfeksi 1 kali gejala"
  },
  Event_80612_ChoiceDesc2 = {
    Text = "[Tidak diperhatikan]Pilih 1 dari 3 kartu perintah untuk mendapatkan orison:\"(EnchantConfig.Arg1)\", terinfeksi\"(Skill.Arg2)\""
  },
  Event_80612_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_80612_Desc = {
    Text = [[
Penghuni datang dan pergi, sementara kawanan tikus tetap ada.
Dibandingkan manusia, mereka adalah "penduduk asli" kastil ini.
Namun, mereka tidak keberatan dengan kehadiran manusia.
Karena makhluk berbau manis dan lembut itu akan memberi mereka makhluk berbau manis dan lembut yang sama.
"Dan kamu, makhluk berbau busuk, termasuk yang mana?"]]
  },
  Event_80612_Name = {
    Text = "Rahasia Kuno dari Istana"
  },
  Event_80613_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80613_Desc = {
    Text = [[

Suara tawa lembut terdengar dalam kegelapan.
"Aku menunggumu untuk menemuiku."
"Kupu-kupu kecil yang berani."]]
  },
  Event_80613_Name = {
    Text = "\"Pengintaian 'dia'\""
  },
  Event_80614_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80614_Desc = {
    Text = [[
"Tutup mulutmu, sangat buruk."
Kucing hitam itu dengan manusiawi menutup telinganya.
"Manusia, bahasa kucingmu benar-benar buruk, apa yang kau katakan adalah omong kosong!"
Meskipun mengatakannya, namun wajah kucing hitam itu terlihat lebih tenang.
"Sebagai imbalan untuk meongmu yang menyenangkan hatiku, aku akan memberimu hadiah."
"Tapi isi hadiahnya tergantung pada keberuntunganmu."]]
  },
  Event_80614_Name = {Text = "Nigelman"},
  Event_80615_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80615_Desc = {
    Text = "\n\"Ibu, setelah kehilangan teman, suami, dan putraku, aku telah kehilangan Diana selamanya, putriku yang kecil. \"\n\"Ketika dia berubah menjadi abu di hadapanku, otakku kosong……\"Tinta selanjutnya sudah tidak terbaca.\nAnda hanya dapat beralih untuk membaca baris berikutnya.\nAku sudah memutuskan. Jika aku bertemu denganmu lagi, jangan menyalahkanku, aku hanya...... sangat merindukan kalian."
  },
  Event_80615_Name = {
    Text = "Kerinduan yang Menghilang"
  },
  Event_80616_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80616_Desc = {
    Text = [[
Usahamu untuk mengusir menghasilkan efek. Beberapa tubuh yang tidak bisa terlihat jelas menekuk dan melarikan diri, sebagian besar tetap berada di tempat.
Mereka tidak lagi tertawa, tidak lagi bernyanyi, malah menangis terisak.
Suara tangisan anak-anak meledak di telingamu, hanya mengulangi satu kalimat.
"Matikan makhluk aneh!"]]
  },
  Event_80616_Name = {
    Text = "\"Masa kanak-kanak 'dia'\""
  },
  Event_80617_ChoiceDesc1 = {
    Text = "[Keluar] Infeksi [(Skill.Arg1)]"
  },
  Event_80617_ChoiceDesc2 = {
    Text = "[Keluar] Infeksi [(Skill.Arg1)]"
  },
  Event_80617_ChoiceDesc3 = {
    Text = "[Keluar] Infeksi [(Skill.Arg1)]"
  },
  Event_80617_Desc = {
    Text = [[
Pemberianmu menyenangkan kawanan tikus.
Kawanan tikus besar itu bergerak, memberimu sebuah hadiah yang dibungkus kasar.
Kamu tidak bisa tahu bentuk hadiah itu, hanya melihat banyak darah yang mencemari pembungkusnya.]]
  },
  Event_80617_Name = {
    Text = "Rahasia Kuno dari Istana"
  },
  Event_80618_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80618_Desc = {
    Text = "\"……\"\n\"…………\"\n\"………………\"\nBayangan tersebut diam, ia ingin menangis, tetapi sudah kehilangan kemampuan untuk menangis.\nAkhirnya, ia hanya menghela napas panjang.  \n\"Teman, semoga kamu bisa melindungi hal yang paling berharga bagimu.\""
  },
  Event_80618_Name = {
    Text = "Orang Kosong"
  },
  Event_80619_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80619_Desc = {
    Text = [[
Sinar teriakanmu tidak ada artinya, malah membuat mereka semakin bersemangat.
Suara tawa dan nyanyian semakin menggema, menyanyikan lagu anak-anak lain
"William kecil, tinggal di kastil, tikus pemakan manusia, berlari di dinding.
Saat saat korban manusia dikorbankan, semua orang akan digigit."]]
  },
  Event_80619_Name = {
    Text = "\"Masa kanak-kanak 'dia'\""
  },
  Event_80620_ChoiceDesc1 = {
    Text = "[Menghindari Pandangan] Bangun 1 Pembangun secara acak"
  },
  Event_80620_ChoiceDesc2 = {
    Text = "[Tatapan Langsung] Pilih 1 Pembangun untuk dibangunkan dan kurangi konsumsi aritmetika kartu bangun sebesar 2 poin. Infeksi [(Skill.Arg1)]"
  },
  Event_80620_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_80620_Desc = {
    Text = [[
Segala sesuatu di rumah sakit berada di bawah kendali dan pengamatannya. Tentu saja, kamu juga.
Tapi dia bersedia untuk menutup satu mata untukmu.
Bagaimanapun, permainan harus saling menguntungkan untuk lebih menyenangkan.]]
  },
  Event_80620_Name = {
    Text = "\"Pengintaian 'dia'\""
  },
  Event_80621_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80621_Desc = {
    Text = [[
Kamu meletakkan amplop di tempat asalnya, bersiap untuk pergi, namun tiba-tiba mendengar bisikan lembut.
"Atas permintaanku, Dokter Klemenitin akhirnya menyerah.
Di alam semesta yang luas dan misterius yang dia gambarkan padaku, pasti ada cara untuk menyelamatkan kalian.
Aku sudah siap untuk "kelahiran kembali", seberapa jauh harus hanyut di antara bintang-bintang, aku sangat ingin bertemu dengan kalian lagi."]]
  },
  Event_80621_Name = {
    Text = "Kerinduan yang Menghilang"
  },
  Event_80622_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80622_Desc = {
    Text = [[
Dokter Clementine telah menyelamatkan saya. 
 Dia benar-benar orang yang sangat, sangat baik, mau mendengarkan suara saya. 
 Saya benar-benar ingin mengatakan beberapa hal yang menyenangkan, hal yang bahagia, namun saat ini, selain rasa sakit dan keputusasaan, saya tidak memiliki yang lain. 
 Takutnya, saya akan mengecewakan niat baik dokter. 
 Setelah kehilangan kalian, hidup bagi saya hanya gersang.]]
  },
  Event_80622_Name = {
    Text = "Kerinduan yang Menghilang"
  },
  Event_80623_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80623_Desc = {
    Text = "\"Kau, kau……\"\n\"Hmph, teknikmu lumayan, kali ini kau selamat. Namun lain kali, tidak akan semudah ini!\"\nKucing hitam melompat, bergerak lincah menjauh."
  },
  Event_80623_Name = {Text = "Nigelman"},
  Event_80624_ChoiceDesc1 = {
    Text = "[Serang Kucing Hitam]50% kemungkinan mendapatkan 125 Segil hitam, 50% kemungkinan terinfeksi[(Skill.Arg2)]"
  },
  Event_80624_ChoiceDesc2 = {
    Text = "[Belajar Mengoceh Kucing]75% kemungkinan mendapatkan 100 Segil hitam, 25% kemungkinan terinfeksi[(Skill.Arg2)]"
  },
  Event_80624_ChoiceDesc3 = {
    Text = "[Coba Mengelus Kucing]mendapatkan 50 Segil hitam"
  },
  Event_80624_Desc = {
    Text = [[
"Hei! Kau, larangan untuk maju."
Kucing hitam tiba-tiba melompat dan menghalangimu untuk melanjutkan.
Mereka menjilati cakar dengan anggun, tampak angkuh dan sombong.
"Di depan dipenuhi bahaya, bukan tempat yang bisa dijelajahi oleh manusia lemah sepertimu."
Kau mengungkapkan tekad untuk maju, saat itu, pupil vertikal kucing hitam yang memimpin berputar, memperlihatkan sifat kejam untuk memainkan mangsanya."Kalau begitu, tunjukkan tekadmu pada kami."]]
  },
  Event_80624_Name = {Text = "Nigelman"},
  Event_80625_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80625_Desc = {
    Text = [[

Ketidakpedulianmu membuat marah sekawanan tikus, yang menggeram dan berdesak-desakan menuju dirimu, sementara kamu sudah berlari jauh sebelum keramaian tikus itu muncul.]]
  },
  Event_80625_Name = {
    Text = "Rahasia Kuno dari Istana"
  },
  Event_80626_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80626_Desc = {
    Text = [[
"Ah, lakukan saja, patahkan sayapku."
"Waktu, kesehatan, martabat, kehidupan, mereka telah merampok terlalu banyak dariku."
"Mimpi terakhir ini, tentu saja, tidak milikku."
"Karena, aku hanyalah burung yang terkurung kehilangan kebebasan."]]
  },
  Event_80626_Name = {
    Text = "Orang Kosong"
  },
  Event_80627_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80627_Desc = {
    Text = [[
"Emosional? Jawaban yang menarik."
"Semoga kau tidak menyesali pilihanmu."]]
  },
  Event_80627_Name = {
    Text = "Bayaran Kemanusiaan"
  },
  Event_80628_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80628_Desc = {
    Text = [[
"Aku menerima doamu."
Suara dengungan mendekat, perlahan merambat melalui saluran telingamu ke otakmu.
Otakmu bergetar, dan dalam getaran ini, kau mendengar 'suara' semesta.
"Tautan denganku."]]
  },
  Event_80628_Name = {
    Text = "Penebusan Kegelapan"
  },
  Event_80629_ChoiceDesc1 = {
    Text = "[Doakan]acak 1 Pembangun terbangun, terinfeksi[(Skill.Arg1)]"
  },
  Event_80629_ChoiceDesc2 = {
    Text = "[Tolak]mendapatkan 3 pilihan  Oriso"
  },
  Event_80629_Desc = {
    Text = "\"Seharusnya tidak seperti ini, seharusnya tidak seperti ini.\"\n\"Aku seharusnya bisa terlepas dari kehidupan rendah seperti manusia, berevolusi menjadi yang lebih tinggi……\"\nDi kegelapan, terdengar isakan yang menyakitkan.\nIsakan ini berkumpul, bergerak, membentuk dengungan yang besar.\n\"Dunia yang terbakar ini, seperti kolam hitam yang tak pernah puas, Melahap setiap orang, jadi——\"\n\"Berdoalah padaku, semesta yang tak berujung akan memberikanmu penebusan.\""
  },
  Event_80629_Name = {
    Text = "Penebusan Kegelapan"
  },
  Event_80630_ChoiceDesc1 = {
    Text = "[Buka Amplop]mendapatkan Relik emas\"(RelicConfig.Arg1)\", terinfeksi\"(Skill.Arg2)\""
  },
  Event_80630_ChoiceDesc2 = {
    Text = "[Baca] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_80630_ChoiceDesc3 = {
    Text = "[Kembalikan ke Tempatnya]mendapatkan 50 Segil hitam"
  },
  Event_80630_Desc = {
    Text = [[
Di sudut yang diabaikan, sebuah surat tergeletak.
Banyak tulisan di surat itu sudah tidak dapat dibaca, tetapi hanya ada satu kata yang jelas terbaca.
Kata itu adalah "ibu".]]
  },
  Event_80630_Name = {
    Text = "Kerinduan yang Menghilang"
  },
  Event_80631_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80631_Desc = {
    Text = "\"Hah, manusia kecil yang remeh, kau telah membuat pilihan yang salah.\"\nKucing hitam menatapmu dengan dingin, tiba-tiba menyerang.\n\"Kau harus membayar harganya——tentu saja, kami juga menghormati yang kuat.\""
  },
  Event_80631_Name = {Text = "Nigelman"},
  Event_80632_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80632_Desc = {
    Text = [[

Suara tawa lembut terdengar dalam kegelapan.
"Aku menunggumu untuk menemuiku."
"Kupu-kupu kecil yang lucu."]]
  },
  Event_80632_Name = {
    Text = "\"Pengintaian 'dia'\""
  },
  Event_80633_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80633_Desc = {
    Text = [[
Di bawah serangan Anda, sosok-sosok aneh dan aneh ini akhirnya melarikan diri.
Sekeliling sunyi, hanya detak jantung Anda yang berseru dalam keheningan.
Ternyata, inilah "masa kecilnya".]]
  },
  Event_80633_Name = {
    Text = "\"Masa kanak-kanak 'dia'\""
  },
  Event_80635_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80635_Desc = {
    Text = "\"Ah, perangkap kata kecil itu telah dibongkar.\"\n\"Ini adalah hadiahnya. Karena……\"\n\"Tidak setiap pilihan harus merupakan pilihan.\""
  },
  Event_80635_Name = {
    Text = "Bayaran Kemanusiaan"
  },
  Event_80636_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80636_Desc = {
    Text = [[
"@3Pemberontak"
Suara mendengung perlahan melemah, hingga menghilang. Hanya tersisa ucapan terakhir.
"Menjaga kemanusiaan, tidak mungkin bertahan di dunia yang kejam ini."]]
  },
  Event_80636_Name = {
    Text = "Penebusan Kegelapan"
  },
  Event_80637_ChoiceDesc1 = {
    Text = "[Pilih Tolak]menghapus 1 kartu perintah, mendapatkan Arg1 Segil hitam"
  },
  Event_80637_ChoiceDesc2 = {
    Text = "[Pilih Taat]menggandakan 1 kartu perintah, terinfeksi[(Skill.Arg1)]"
  },
  Event_80637_ChoiceDesc3 = {
    Text = "[Pilih Peluk]dari 3 kartu perintah memilih 1 untuk mendapatkan Orison:[(EnchantConfig.Arg1)]"
  },
  Event_80637_Desc = {
    Text = [[
"Aku adalah burung dalam sangkar, terkurung di halaman penuh dengan banyak kamar."
Bayangan kabur berkeliaran dalam kegelapan, itu adalah obsesi yang ditinggalkan oleh yang telah pergi.
"Mereka bilang, itu adalah rumah sakit jiwa, tapi aku tahu, itu adalah penjara khusus bagi manusia, menahan burung yang tidak mau mengikuti aturan sosial."
"Tapi jika burung tidak bisa terbang, apakah masih bisa disebut burung?"
Obsesi-obsesi berkumpul mendekat kepadamu, meminta penebusan.
"Tolong patahkan sayapku, aku sudah lelah terbang."]]
  },
  Event_80637_Name = {
    Text = "Orang Kosong"
  },
  Event_80638_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_80638_Desc = {
    Text = "\"……\"\n\"…………\"\n\"………………\"\nBayangan tiba-tiba bergetar, menyatu ke dalam tubuhmu.\n\"Teman, maju lah, untuk melindungi hal yang paling berharga bagimu.\"\n\"Meskipun kami telah tiada, kami tetap ingin bermimpi untukmu dan mengirimkan berkat terakhir kami.\""
  },
  Event_80638_Name = {
    Text = "Orang Kosong"
  },
  Event_80639_ChoiceDesc1 = {
    Text = "[Pilih Perasaan]memulihkan Arg1 poin Hidup"
  },
  Event_80639_ChoiceDesc2 = {
    Text = "[Pertahankan Rasionalitas]acak 1 kartu perintah mendapatkan Orison:[(EnchantConfig.Arg1)]"
  },
  Event_80639_ChoiceDesc3 = {
    Text = "[Tolak Pilihan]mendapatkan 25 Segil hitam"
  },
  Event_80639_Desc = {
    Text = [[
"Pilihlah, pilihlah."
Di tengah kegelapan yang berlari, terdengar banyak bisikan.
Suara ini lembut dan hipnotis, seolah memiliki kekuatan tanpa batas, membuatmu merasakan semacam ilusi kegilaan.
Otakmu terjebak dalam kebingungan, bergerak menjauh dari tubuh, sementara jantungmu tampaknya memiliki kesadaran tertentu, memanggilmu dengan terjerit.
"Pilihlah, pilihlah."
"Pertahankan rasionalitas atau emosional, kau harus membuat pilihan."]]
  },
  Event_80639_Name = {
    Text = "Bayaran Kemanusiaan"
  },
  Event_80641_ChoiceDesc1 = {
    Text = "[Caci\"Mereka\"] terinfeksi\"(Skill.Arg1)\", mendapatkan Relik terkutuk\"(RelicConfig.Arg2)\""
  },
  Event_80641_ChoiceDesc2 = {
    Text = "[Usir\"Mereka\"]terinfeksi dua kali\"(Skill.Arg1)\", mendapatkan Relik perak\"(RelicConfig.Arg2)\"serta\"(RelicConfig.Arg3)\""
  },
  Event_80641_ChoiceDesc3 = {
    Text = "[Serang \"Mereka\"]mendapatkan Relik perak[(RelicConfig.Arg1)]"
  },
  Event_80641_Desc = {
    Text = [[
"William kecil, adalah makhluk aneh, tidur di tumpukan kubur, tidak ada yang mencintainya. Jangan bergaul dengan dia, hati-hati bisa disakiti diam-diam oleh dia."
Rupa yang tidak terlihat terdistorsi, suaranya seperti anak kecil.
Mereka tertawa dan mengucapkan, dengan tatapan yang merendahkan dan antusias menatapmu.
Membawa niat jahat.]]
  },
  Event_80641_Name = {
    Text = "\"Masa kanak-kanak 'dia'\""
  },
  Event_90571_ChoiceDesc1 = {
    Text = "[Nikmati Ini]Masukkan 1 kartu [Malam Ritual] ke dalam dek."
  },
  Event_90571_Desc = {
    Text = [[
Meja makan yang megah, lantai tari yang meriah, peralatan makan yang halus, aroma tubuh yang kuat...
Oh, aku tahu kau sudah tidak sabar, tapi tunggu sebentar lagi, tamuku tercinta.
Minuman ini adalah hadiah khusus yang disiapkan oleh tuan rumah pesta, hanya untuk tamu terhormat.
Peganglah itu. Seruputlah. Nikmati setiap momen kesukacitaan dalam setelah rasanya!]]
  },
  Event_90571_Name = {
    Text = "Ritual pra-pesta"
  },
  Event_91460_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91460_Desc = {
    Text = [[
Kamu tidak bisa melawan, hanya bisa membiarkan suara menembus.
Jeritan yang tajam membelah otakmu, beberapa ketakutan yang terlupakan mengalir keluar, kamu merasakan kelaparan itu.
Makhluk pemangsa yang mengerikan...]]
  },
  Event_91460_Name = {
    Text = "Pengakuan Bisu"
  },
  Event_91461_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91461_Desc = {
    Text = [[
Anda tidak lagi menahan diri, membiarkan api yang membara sepenuhnya dilepaskan, semua kata-kata yang belum terucap terus meledak dari kepala Anda.
Anda merasakan inspirasi yang luar biasa, terpesona oleh bakat Pikman.]]
  },
  Event_91461_Name = {
    Text = "Gunung Berapi Tidur"
  },
  Event_91462_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91462_Desc = {
    Text = [[
Lidah api melilit noda tinta, meninggalkan jejak darah yang berceceran. 
 Saat itu, kamu terjatuh di tepi mimpi dan kenyataan. Kamu melihat dirimu berubah menjadi seorang perempuan kecil, menggenggam tangan Doresain dan berdansa bersamanya. 
 Ketika kamu terbangun dan melihat Doresain lagi, kesedihan yang berat melanda otakmu.]]
  },
  Event_91462_Name = {
    Text = "Revelasi Mimpi"
  },
  Event_91463_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91463_Desc = {
    Text = [[
Anda berlari ke depan, api menghilang di kulit Anda. Adapun lukisan itu, siapa pun yang melihatnya hanyalah lukisan potret biasa.
Sejak saat itu, dalam mimpi, Anda selalu melihat diri Anda yang sedang terbakar, dengan suhu yang tepat, lalu pada suatu hari disajikan di meja makan Anda sendiri.]]
  },
  Event_91463_Name = {
    Text = "Potret Terbakar"
  },
  Event_91464_ChoiceDesc1 = {
    Text = "[Mendengarkan]mendapatkan 30 Segil hitam，terinfeksi[(Skill.Arg2)]，lanjut memilih"
  },
  Event_91464_ChoiceDesc2 = {
    Text = "[Mengabaikan] Pergi"
  },
  Event_91464_Desc = {
    Text = "Dalam keributan yang sunyi, kamu perlahan memahami kata-kata burung gagak itu..."
  },
  Event_91464_Name = {
    Text = "Pengakuan Bisu"
  },
  Event_91465_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91465_Desc = {
    Text = [[
Kamu mengambil batu kecil, mengejutkan siluet tikus yang fokus menggerogoti.
Mereka serakah memandangmu.
Kamu mencium bau lembab yang kotor dari tubuh mereka, seolah-olah itu adalah suatu pertanda.]]
  },
  Event_91465_Name = {
    Text = "Kerajaan Terasing"
  },
  Event_91466_ChoiceDesc1 = {
    Text = "[Mendengarkan]mendapatkan 25 Segil hitam，terinfeksi[(Skill.Arg2)]，lanjut memilih"
  },
  Event_91466_ChoiceDesc2 = {
    Text = "[Mengabaikan] Pergi"
  },
  Event_91466_Desc = {
    Text = [[
Ia menyambut. Menyambut siapa?
Tentu saja kamu!
Mungkin ia melihatmu sebagai hidangan lezat di hari esok.]]
  },
  Event_91466_Name = {
    Text = "Pengakuan Bisu"
  },
  Event_91467_ChoiceDesc1 = {
    Text = "[Sayat Telapak Tangan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_91467_ChoiceDesc2 = {
    Text = "[Menerima Pertumbuhan]mendapatkan Relik perak\"(RelicConfig.Arg1)\"，terinfeksi\"(Skill.Arg2)\""
  },
  Event_91467_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_91467_Desc = {
    Text = [[
Kupu-kupu itu tidak terbang datang, melainkan tumbuh perlahan dari telapak tanganmu. 
 Awalnya kamu mengira itu hanya keringat, namun di antara celah jari, kamu melihat cairan hitam mengalir diam-diam seperti aliran darah, mengkristal menjadi sayap yang dingin dan berdenyut. 
 Setiap kali ia mengepak, gelombang muncul dalam darahmu.]]
  },
  Event_91467_Name = {
    Text = "Parasit kelas atas"
  },
  Event_91468_ChoiceDesc1 = {
    Text = "[Selamatkan Potret] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_91468_ChoiceDesc2 = {
    Text = "[Terima Kekosongan] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: \"(EnchantConfig.Arg1)\", terinfeksi \"(Skill.Arg2)\""
  },
  Event_91468_ChoiceDesc3 = {
    Text = "[Pergi] Mendapatkan 25 Segil hitam"
  },
  Event_91468_Desc = {
    Text = [[
Kau berdiri di depan hadiah dari Pikman.
Itu adalah lukisan potret, dicat dengan darah, api hitam menyala diam.
Melalui rongga kosong mata orang dalam lukisan, kau melihat---
memori-memorimu berkobar, membentang, terdistorsi, bersinar, seolah ada api tak terlihat yang sedang menjilati koridor dalam kepalamu. Dalam keadaan bingung, kau mendengar satu suara.
"Sudah saatnya dimasak, ini sudah tepat."
Ini adalah pemandangan ingatan yang kau lukis sendiri, kau berjuang dan berubah dalam api.]]
  },
  Event_91468_Name = {
    Text = "Potret Terbakar"
  },
  Event_91469_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91469_Desc = {
    Text = [[
Kamu menolak untuk menjawab, hanya diam-diam melihatnya bergetar hingga berhenti.
Selama bertahun-tahun, kamu telah belajar untuk melawan kegilaan.]]
  },
  Event_91469_Name = {
    Text = "Panggilan terlewat"
  },
  Event_91470_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91470_Desc = {
    Text = [[
Anda melangkah mundur, membiarkan kanvas terbakar dalam api.
Anda melihat diri Anda terbakar sampai menjadi kecoklatan yang menggiurkan, lemaknya mendidih dan berbunyi retak, seolah bisa mencium aroma daging melalui kanvas.
Apakah itu godaan yang dirasakan Dulerth?]]
  },
  Event_91470_Name = {
    Text = "Potret Terbakar"
  },
  Event_91471_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91471_Desc = {
    Text = [[
Dengan rasa ingin tahu yang hampir terkutuk, atau keberanian untuk melawan ketidakpastian, kamu mencari petunjuk di antara fatamorgana masa lalu.
Kamu melihat seorang gadis berdansa dengan seorang pria tinggi yang wajahnya kabur, kebahagiaan yang tidak terduga memenuhi jantungmu.]]
  },
  Event_91471_Name = {
    Text = "Bayangan Masa Lalu"
  },
  Event_91472_ChoiceDesc1 = {
    Text = "[Menghentikan Pencatatan]menghapus 2 kartu"
  },
  Event_91472_ChoiceDesc2 = {
    Text = "[Melanjutkan Menulis]mendapatkan Relik terkutuk\"(RelicConfig.Arg1)\"，terinfeksi\"(Skill.Arg2)\""
  },
  Event_91472_ChoiceDesc3 = {
    Text = "[Pergi]mendapatkan Arg1 Segil hitam"
  },
  Event_91472_Desc = {
    Text = [[
Akhirnya kamu berhasil sementara terlepas dari pasar mayat hidup, dan menemukan sudut tenang untuk mulai mencatat seperti biasa. 
 Mesin tik tiba-tiba bergetar dengan ganas, tombolnya bergerak sendiri, lendir hitam menyembur keluar dari celah, membasahi akal sehat di ujung jari kamu. 
 Kamu melihat bayangan kupu-kupu yang perlahan muncul di atas kertas...]]
  },
  Event_91472_Name = {
    Text = "Bayangan-bayangan kupu-kupu"
  },
  Event_91473_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91473_Desc = {
    Text = "Anehnya, meskipun itu adalah kata-kata yang belum pernah dipelajari, sepertinya kamu memahami maknanya.\nBaris puisi dipenuhi dengan kerinduan untuk orang yang dicintai, kerinduan ini melampaui hidup dan mati, dapat disampaikan dalam mimpimu.\nKamu samar-samar mengenali tulisan di akhir puisi—\nitu adalah 'Selene'."
  },
  Event_91473_Name = {
    Text = "Revelasi Mimpi"
  },
  Event_91474_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91474_Desc = {
    Text = [[
Kamu dengan sakit hati mengiris kulit telapak tanganmu, membakar daging sayap yang baru lahir dengan api. 
 Cairan hitam menguap, kupu-kupu hancur. 
 Segalanya menjadi bersih tanpa jejak, tetapi kamu selalu merasa ada suara gesekan sayap yang lemah di telapak tanganmu, seperti pikiran yang belum sepenuhnya menetas, masih perlahan bernapas dalam pembuluh darahmu. 
 Doresain tidak memberikan tanggapan, hanya ingin mengambil darah segar yang kau tinggalkan.]]
  },
  Event_91474_Name = {
    Text = "Parasit kelas atas"
  },
  Event_91475_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91475_Desc = {
    Text = "Kau tahu inspirasi yang berapi-api selalu membawa bencana, jadi kau menutup semuanya dengan rasionalitas."
  },
  Event_91475_Name = {
    Text = "Gunung Berapi Tidur"
  },
  Event_91476_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91476_Desc = {
    Text = [[
Kau menatap mata itu, berusaha memahami pesan yang disampaikannya.
Walaupun kau telah melalui banyak pertempuran, namun kali ini berhadapan dengan Goliath... ketakutan menyekap jantungmu.
"Hampir normal, merupakan bentuk yang paling sunyi sebelum bencana terjadi."]]
  },
  Event_91476_Name = {
    Text = "Hampir normal"
  },
  Event_91477_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91477_Desc = {
    Text = [[
Kau menutup mata, berbalik dan melangkah ke padang liar.
Kau bisa merasakan keinginan dan pertanda yang tersembunyi, tetapi tak pernah bisa menghentikannya dengan tanganmu sendiri.
Kau melihat ke arah nisan tanpa tulisan di sekitarmu, mungkin inilah akhir perjalananmu.]]
  },
  Event_91477_Name = {
    Text = "Pesta Murai"
  },
  Event_91478_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91478_Desc = {
    Text = [[
Kau perlahan mendongak, pada saat itu, cahaya menerobos iris matamu, panas mekar menjadi bunga kosong di otakmu.
Bintang-bintang di Kota Pemakaman tidak berbeda dari tempat lain, dan seolah-olah memiliki kebangkitan abadi, zombie hanya bisa hidup di bawah bintang-bintang, tanpa kebebasan.]]
  },
  Event_91478_Name = {
    Text = "Malam Bintang"
  },
  Event_91479_ChoiceDesc1 = {
    Text = "[Menghayal di Perapian]menghapus 1 kartu"
  },
  Event_91479_ChoiceDesc2 = {
    Text = "[Mencoba Mengartikan]Dapatkan\"(RelicConfig.Arg1)\"，terinfeksi\"(Skill.Arg2)\""
  },
  Event_91479_Desc = {
    Text = [[
Kesadaranmu melayang di dalam kabut hitam yang tak berujung, menjelajahi citra mental dari banyak yang hidup dan yang mati. 
 Dalam mimpi, mesin ketik yang ajaib mengeluarkan sepotong larik yang asing. Ini adalah kisah siapa lagi? 
 Ia terukir di atas kertas yang tidak dikenal asal-usulnya, tulisan yang terdistorsi seolah ditulis oleh seorang pemabuk yang tersadar. 
 Kamu didorong oleh dorongan tak terkatakan dalam mimpi, mengambil kertas itu, tinta melompat di antara cahaya api.]]
  },
  Event_91479_Name = {
    Text = "Revelasi Mimpi"
  },
  Event_91480_ChoiceDesc1 = {
    Text = "[Bergabung]Terinfeksi\"(Skill.Arg1)\"，acak 1 kartu untuk mendapatkan orison:\"(EnchantConfig.Arg2)\""
  },
  Event_91480_ChoiceDesc2 = {
    Text = "[Mengusir]terinfeksi \"(Skill.Arg1)\"，secara acak 1 kartu untuk mendapatkan Orison:\"(EnchantConfig.Arg2)\""
  },
  Event_91480_ChoiceDesc3 = {
    Text = "[Mengabaikan]pilih 1 dari 3 kartu perintah untuk mendapatkan Orison:[(EnchantConfig.Arg1)]"
  },
  Event_91480_Desc = {
    Text = [[
Kamu mendengar suara tanduk tulang yang samar-samar dari kejauhan. 
 Kawanan tikus muncul dari lumpur hitam, menggerogoti tubuh tanpa nama yang tergeletak di dasar sungai yang kering. 
 Mereka membentuk sebuah lingkaran, dengan pusat lingkaran adalah mayat yang telah kosong, dan kelilingnya adalah sebuah kerajaan baru yang diatur oleh hukum pelupaan. 
 Dan kamu, sedang berdiri di pintu masuk kerajaan ini.]]
  },
  Event_91480_Name = {
    Text = "Kerajaan Terasing"
  },
  Event_91481_ChoiceDesc1 = {
    Text = "[Memandang ke Atas]mendapatkan Relik perak[(RelicConfig.Arg1)]"
  },
  Event_91481_ChoiceDesc2 = {
    Text = "[Menundukkan Kepala dan Pergi]Dapatkan 75 Segil Hitam, terinfeksi[(Skill.Arg2)]"
  },
  Event_91481_Desc = {
    Text = [[
Sekawanan gagak berputar di langit, seperti gergaji ragu yang terus-menerus memotong tulang punggung langit.
Mereka terbang rendah di sekitarmu, seolah-olah telah merasakan kematianmu, sabar menunggu dimulainya pesta.]]
  },
  Event_91481_Name = {
    Text = "Pesta Murai"
  },
  Event_91482_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91482_Desc = {
    Text = [[
Kau membiarkannya terus menulis, dengan denyut nadi, rasa sakit, masa lalumu, dan dugaanmu. 
 Kupu-Kupu menerobos pembatasan kertas, dan jiwamu pun terbang bebas. 
 Kau mulai membayangkan dirimu bahagia di taman bermain. Kau tidak memberitahu Doresain bahwa sebenarnya kau sangat menyukai taman bermain, bahkan taman bermain mayat sekalipun... 
 Seharusnya... tidak terlalu aneh, kan?]]
  },
  Event_91482_Name = {
    Text = "Bayangan-bayangan kupu-kupu"
  },
  Event_91483_ChoiceDesc1 = {
    Text = "[Mengamati Kembali]pilih 1 dari 3 kartu perintah untuk mendapatkan Orison:[(EnchantConfig.Arg1)]"
  },
  Event_91483_Desc = {
    Text = [[
Makan malam yang dulu jelas menjadi pesta daging yang berdarah, kamu teringat bahan yang ada di kompor, bau busuk menyengat hidungmu.
Ketakutan merenggut jantungmu dan kamu terpaksa membuat sebuah keputusan.]]
  },
  Event_91483_Name = {
    Text = "Bayangan Masa Lalu"
  },
  Event_91484_ChoiceDesc1 = {
    Text = "[Mengabaikan Bunyi Lonceng]mendapatkan 3 pilihan 1 Orison tingkat lanjut"
  },
  Event_91484_ChoiceDesc2 = {
    Text = "[Mengangkat Telepon]mendapatkan Relik emas\"(RelicConfig.Arg1)\"，terinfeksi\"(Skill.Arg2)\""
  },
  Event_91484_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_91484_Desc = {
    Text = "Seharusnya tidak berbunyi—telepon itu, terentang di balik kanvas.\nKabel dari gagang telepon terjerat di tubuh mesin yang besar, seperti tali pusar yang berkarat, tampak merentang dari dalam kepalamu.\nKamu dengan hati-hati membedakan frekuensi getaran, suara aneh itu seperti seni surreal Pikman."
  },
  Event_91484_Name = {
    Text = "Panggilan terlewat"
  },
  Event_91485_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91485_Desc = {
    Text = [[
Kamu mengangkat otak yang dingin itu, seketika ia berubah menjadi aliran air yang mengalir diam-diam dari celah-celah jarimu. 
 Timbangan segera kehilangan keseimbangannya, jantungmu cepat runtuh dan meleleh seperti buah busuk, berubah menjadi genangan air hitam yang diam. 
 Semua rasa lapar menghilang, kamu memiliki ketenangan, tanpa penyesalan, dan kejernihan yang singkat.]]
  },
  Event_91485_Name = {
    Text = "Permainan Lapar"
  },
  Event_91486_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91486_Desc = {
    Text = [[
Tidak ada suara, tidak ada tanggapan. Mungkin hanya lelucon? 
Begitu kamu meletakkan gagang telepon, semacam perasaan berat mengalir kembali ke dalam dirimu.]]
  },
  Event_91486_Name = {
    Text = "Panggilan terlewat"
  },
  Event_91487_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91487_Desc = {
    Text = [[
Burung gagak menghilang.
Tetapi kamu melihat dirimu berdiri di cermin malam yang lain, menatap burung gagak ini.
Itu masih berteriak diam, seolah menunggu jawabanmu.]]
  },
  Event_91487_Name = {
    Text = "Pengakuan Bisu"
  },
  Event_91488_ChoiceDesc1 = {
    Text = "[Mengamati Kembali]pilih 1 dari 3 kartu perintah untuk mendapatkan Orison:[(EnchantConfig.Arg1)]"
  },
  Event_91488_ChoiceDesc2 = {
    Text = "[Menyerah Melawan]terinfeksi[(Skill.Arg1)]，mengganti Orison yang diperoleh dari Opsi 1, dapat digunakan sekali lagi"
  },
  Event_91488_Desc = {
    Text = [[
Kamu secara tegas mengalihkan pandanganmu, tetapi gambaran-gambaran itu muncul seperti bayangan dalam matamu...
Itu adalah tarian duet yang menyedihkan.]]
  },
  Event_91488_Name = {
    Text = "Bayangan Masa Lalu"
  },
  Event_91489_ChoiceDesc1 = {
    Text = "[Nikmati]Pilih 1 dari 3 kartu perintah untuk mendapatkan orison:[(EnchantConfig.Arg1)]"
  },
  Event_91489_ChoiceDesc2 = {
    Text = "[Menolak]Terinfeksi[(Skill.Arg1)]，ulang orison, maksimal 2 kali"
  },
  Event_91489_Desc = {
    Text = [[
Itu dirancang dengan cermat untuk kalian yang telah melakukan penyelidikan di Dhul'Sein.
Tanpa bumbu tetapi tidak berbau busuk, seperti yang dikatakan Dhul'Sein, ini adalah bahan makanan terbaik.
Pesta diatur untukmu, dan otak dalam piring diam terdiam.
"Apakah kamu ingin mencobanya?"]]
  },
  Event_91489_Name = {
    Text = "Menikmati hidangan lezat"
  },
  Event_91490_ChoiceDesc1 = {
    Text = "[Mendengarkan]mendapatkan 40 Segil hitam，terinfeksi[(Skill.Arg2)]，lanjut memilih"
  },
  Event_91490_ChoiceDesc2 = {
    Text = "[Mengabaikan]mendapatkan 25 Segil hitam, pergi"
  },
  Event_91490_Desc = {
    Text = [[
Itu adalah seekor burung gagak.
Ia berdiri di atas lampu tengkorak, membuka mulut, tetapi tidak mengeluarkan suara.]]
  },
  Event_91490_Name = {
    Text = "Pengakuan Bisu"
  },
  Event_91491_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91491_Desc = {
    Text = [[
Kamu perlahan-lahan mengulurkan tanganmu ke arah jantung yang masih hangat itu, ia bergetar dan menyusut, hingga berubah menjadi seberkas uap hangat yang menghilang. 
 Neraca bergetar hebat, otakmu terjatuh ke dalam kegelapan yang tak berujung. 
 Perasaan kenyang yang melimpah menggantikan rasa lapar, kamu memahami gairah, penderitaan, dan kenangan yang sebenarnya.]]
  },
  Event_91491_Name = {
    Text = "Permainan Lapar"
  },
  Event_91492_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91492_Desc = {
    Text = [[
Kamu mendongak, menyambut putaran yang tanpa suara, seperti peziarah kuno yang melakukan ritual. 
 Mereka dengan gembira menikmati daging dan darahmu, kamu merasakan sakit, tetapi juga merasa jernih. 
 Kamu melihat dirimu yang hilang, bagian-bagian yang tidak mati, akhirnya dibawa pergi. 
 Ketika kesadaran kembali, kamu menemukan dirimu baik-baik saja.]]
  },
  Event_91492_Name = {
    Text = "Pesta Murai"
  },
  Event_91493_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91493_Desc = {
    Text = [[
Kau menutup lubang kunci itu dengan memori dan emosi, kebenaran tidak bisa lagi menggoda dirimu.
Melihat wajahmu yang seolah menghadapi musuh besar, Dullesain menjilat sudut bibirnya.
"Apakah kau ingin mencobanya lagi? Ini adalah mozzarella daun otak yang dibuat khusus untuk Yang Mulia Penjaga."]]
  },
  Event_91493_Name = {Text = "Wahyu"},
  Event_91494_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91494_Desc = {
    Text = [[
Sebenarnya kamu selalu penasaran dengan pengalaman zombie. 
"Jadi kamu masuk ke dalam kerumunan tikus, menjadi salah satu dari mereka -"
Kamu tidak bisa tidak mengakui, kedatangan pelaut membuat pikiranmu menjadi tidak terlalu jernih.]]
  },
  Event_91494_Name = {
    Text = "Kerajaan Terasing"
  },
  Event_91495_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91495_Desc = {
    Text = [[
Anda tidak mau terjerat dalam pembusukan dan kekacauan.
Anda sudah terbiasa, segala sesuatu yang busuk menjadi seperti hal yang biasa.]]
  },
  Event_91495_Name = {
    Text = "Kerajaan Terasing"
  },
  Event_91496_ChoiceDesc1 = {
    Text = "[Nikmati]Pilih 1 dari 3 kartu perintah untuk mendapatkan orison:[(EnchantConfig.Arg1)]"
  },
  Event_91496_ChoiceDesc2 = {
    Text = "[Menolak]Terinfeksi[(Skill.Arg1)]，acak orison lagi"
  },
  Event_91496_Desc = {
    Text = [[
Dengan anggun, Tulasa In memotong sepotong "Otak" untukmu.
Rasa yang manis ini...
Tekstur yang lembut dan kenyal ini...
Rasa kamu ingin lagi.]]
  },
  Event_91496_Name = {
    Text = "Menikmati hidangan lezat"
  },
  Event_91497_ChoiceDesc1 = {
    Text = "[Aku sedang bermimpi]mendapatkan Relik perak[(RelicConfig.Arg1)]"
  },
  Event_91497_ChoiceDesc2 = {
    Text = "[Ini Tidak Normal]mendapatkan Relik emas\"(RelicConfig.Arg1)\"，terinfeksi\"(Skill.Arg2)\""
  },
  Event_91497_Desc = {
    Text = [[
Nisan yang halus memantulkan sepasang mata yang perlahan-lahan membelok. 
 Seolah-olah menampung gambaran yang tidak dapat dilukiskan oleh mata telanjang, sebuah fragmen memori yang bukan milikmu, tetapi telah tertanam dalam lipatan di dasar matamu. 
 Kamu mencoba berkedip, menggosok dengan ujung jarimu, tetapi mata itu tidak lagi milikmu, ia mulai memantulkan pemandangan seperti kaleidoskop.]]
  },
  Event_91497_Name = {
    Text = "Hampir normal"
  },
  Event_91498_ChoiceDesc1 = {
    Text = "[Melanjutkan Mengamati]pilih 1 dari 3 kartu perintah untuk mendapatkan Orison:[(EnchantConfig.Arg1)]"
  },
  Event_91498_ChoiceDesc2 = {
    Text = "[Mengalihkan Pandangan]terinfeksi[(Skill.Arg1)]，mengganti Orison yang diperoleh dari Opsi 1, dapat digunakan dua kali"
  },
  Event_91498_Desc = {
    Text = [[
Di sudut lembap kastil, kamu menemukan gulungan film itu. 
 Gambar-gambar itu seperti ilusi yang tenggelam di sungai waktu, membeku dalam keheningan yang lambat, kadang mengembang menjadi benda raksasa yang tak terdefinisikan, kadang menyusut menjadi titik-titik berkilau yang tidak menentu. 
 Kamu terbenam di dalamnya, sebuah rasa pusing mengingatkanmu akan berlalu-nya waktu.]]
  },
  Event_91498_Name = {
    Text = "Bayangan Masa Lalu"
  },
  Event_91499_ChoiceDesc1 = {
    Text = "[Menatap Bintang]Dapatkan Relik Emas\"(RelicConfig.Arg1)\"，terinfeksi\"(Skill.Arg2)\""
  },
  Event_91499_ChoiceDesc2 = {
    Text = "[Menutup Mata]secara acak membangunkan 2 Pembangun，terinfeksi dua kali[(Skill.Arg1)]"
  },
  Event_91499_ChoiceDesc3 = {
    Text = "[Pergi] mendapatkan 50 Segil Hitam"
  },
  Event_91499_Desc = {
    Text = [[
Kamu berdiri di pemakaman yang sepi, keberadaan bintang-bintang membuat malam bersinar seperti siang. 
 Bola cahaya yang mengapung di dalam kedalaman waktu tidak pernah berbicara, tetapi dalam putaran yang panjang seperti bisikan mimpi, mereka perlahan memusat. 
 Mereka menatap bintang kesepian yang terlupakan. 
 Dia menatapmu, menatap segala kematian dan keabadian.]]
  },
  Event_91499_Name = {
    Text = "Malam Bintang"
  },
  Event_91500_ChoiceDesc1 = {
    Text = "[Mendengarkan]mendapatkan 20 Segil hitam，terinfeksi[(Skill.Arg2)]"
  },
  Event_91500_ChoiceDesc2 = {
    Text = "[Mengabaikan] Pergi"
  },
  Event_91500_Desc = {
    Text = [[
Anda saling bertatapan.
Dalam kegelapan pekat, Anda melihat api liar yang serakah.]]
  },
  Event_91500_Name = {
    Text = "Pengakuan Bisu"
  },
  Event_91501_ChoiceDesc1 = {
    Text = "[Membuka Lubang Kunci]mendapatkan Relik terkutuk\"(RelicConfig.Arg1)\"，terinfeksi\"(Skill.Arg2)\""
  },
  Event_91501_ChoiceDesc2 = {
    Text = "[Tutup Lubang Kunci] 1 Kartu acak mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_91501_Desc = {
    Text = [[
Menghadapi lembaran otak yang diberikan oleh Doresain, kamu beberapa kali menolak, namun pada akhirnya tidak dapat menolak godaan kebijaksanaan. 
Pengetahuan tidak datang perlahan, tetapi mengalir deras. 
Otak mulai terasa nyeri, pikiran terus mengembang seperti roti yang mengembang. Ketika kamu akhirnya terjatuh, rasa sakit surut seperti air pasang, kesadaranmu seolah-olah kehilangan bagian, meninggalkan sebuah lubang kunci yang bersih dan kuno. 
Ternyata inilah bentuk pengetahuan! Kamu merasakan kebijaksanaan yang belum pernah ada sebelumnya. 
Mungkin... kamu bisa mendapatkan lebih banyak?]]
  },
  Event_91501_Name = {Text = "Wahyu"},
  Event_91502_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91502_Desc = {
    Text = [[
Kau menggunakan sisa ketajaman kesadaranmu untuk mendorong lubang kunci itu.
Kau tidak tahu apa itu kunci, hanya mencoba dengan keinginan. Saat itu, pikiranmu terbakar habis, menyisakan semacam logika yang tidak manusiawi berbisik di dalam lubang kunci yang kosong.
Apakah ini petunjuk? Kau dengan antusias membagikannya kepada Dullesain.
"Apakah kau ingin mencobanya lagi? Ini adalah mozzarella daun otak yang dibuat khusus untuk Yang Mulia Penjaga."]]
  },
  Event_91502_Name = {Text = "Wahyu"},
  Event_91503_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91503_Desc = {
    Text = [[
Kamu tidak meledakkannya, juga tidak menekannya.
Dalam keadaan pengamat yang rumit, kamu menganggap pikiran yang memuncak itu sebagai bagian dari perubahan cuaca, membiarkannya mengalir menuju akhir yang tidak diketahui.
Dalam lukisan darah dan daging, kamu menikmati seni yang abadi.]]
  },
  Event_91503_Name = {
    Text = "Gunung Berapi Tidur"
  },
  Event_91504_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91504_Desc = {
    Text = [[
Tombol tiba-tiba berhenti, bayangan kupu-kupu segera lenyap.
Apakah ini fatamorgana? Kau sepertinya kehilangan sesuatu.
Mungkin sebaiknya mendengarkan Dullesain dan membeli beberapa pemori di toko kaleng.
"tidak, apa yang aku pikirkan?"]]
  },
  Event_91504_Name = {
    Text = "Bayangan-bayangan kupu-kupu"
  },
  Event_91505_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91505_Desc = {
    Text = [[
Kamu tidak lagi berjuang, membiarkan sayap dan cairan hitam menembus telapak tanganmu. 
 Kamu telah menjadi wadahnya, dan ia menjadikanmu sebagai cangkang, terus berpikir. 
 Kupu-kupu itu semakin besar, dan akhirnya kamu tidak dapat menahan beratnya. 
 Melihat ini, Doresain dengan antusias menggunakan pisau makan untuk memutuskan hubunganmu dengan kupu-kupu. Tatapannya yang bersemangat jelas menunjukkan bahwa ia ingin... 
 Kamu menolak permintaannya.]]
  },
  Event_91505_Name = {
    Text = "Parasit kelas atas"
  },
  Event_91506_ChoiceDesc1 = {
    Text = "[Mendengarkan]mendapatkan 35 Segil hitam，terinfeksi[(Skill.Arg2)]，lanjut memilih"
  },
  Event_91506_ChoiceDesc2 = {
    Text = "[Mengabaikan] Pergi"
  },
  Event_91506_Desc = {
    Text = [[
Kamu awalnya berpikir bahwa itu hening, hingga kesadaranmu tiba-tiba miring, seolah-olah banyak kepala gagak bernyanyi di dalam otakmu.
Kamu berlutut, dunia berputar di depan matamu.]]
  },
  Event_91506_Name = {
    Text = "Pengakuan Bisu"
  },
  Event_91507_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91507_Desc = {
    Text = [[
Kau menutup mata, melangkah ke dalam kabut debu yang tak berujung dan lembut, nebula memelukmu, dan kau kehilangan bentuk, sebuah keberadaan yang lebih kokoh daripada tubuhmu mengendap di dalam dirimu. 
Malam itu, bintang-bintang terus berputar, seperti biasa yang bersinar. 
Apa arti langit berbintang bagi mereka yang abadi? Mungkin kau harus bertanya kepada Doresain.]]
  },
  Event_91507_Name = {
    Text = "Malam Bintang"
  },
  Event_91508_ChoiceDesc1 = {
    Text = "[Nikmati]Pilih 1 dari 3 kartu perintah untuk mendapatkan orison:[(EnchantConfig.Arg1)]"
  },
  Event_91508_Desc = {
    Text = [[
Ternyata itu adalah keju.
Saat kamu merasa bersyukur, masih ada rasa penyesalan yang tersisa.]]
  },
  Event_91508_Name = {
    Text = "Menikmati hidangan lezat"
  },
  Event_91509_ChoiceDesc1 = {
    Text = "[Menyala]terinfeksi\"(Skill.Arg1)\"，mendapatkan Relik perak\"(RelicConfig.Arg2)\""
  },
  Event_91509_ChoiceDesc2 = {
    Text = "[Menunggu]terinfeksi\"(Skill.Arg1)\"，mendapatkan Relik perak\"(RelicConfig.Arg2)\""
  },
  Event_91509_ChoiceDesc3 = {
    Text = "[Dikunci]Dapatkan 25 Segil Hitam"
  },
  Event_91509_Desc = {
    Text = "Anda menatap karya Pikman, aroma busuk yang menjijikkan membuat Anda pusing.\nPikiran perlahan muncul dari kepala, awalnya hanya uap panas, kemudian kabut tipis, lalu——"
  },
  Event_91509_Name = {
    Text = "Gunung Berapi Tidur"
  },
  Event_91510_ChoiceDesc1 = {
    Text = "[Menyentuh Otak]mendapatkan 1 kartu perintah secara acak untuk mendapatkan Orison:[(EnchantConfig.Arg1)]"
  },
  Event_91510_ChoiceDesc2 = {
    Text = "[Menyentuh Jantung]meningkatkan Arg1 poin Kesehatan maksimum，terinfeksi[(Skill.Arg2)]"
  },
  Event_91510_Desc = {
    Text = [[
Kamu melangkah ke dalam ruang abu-abu yang sunyi tanpa bisikan, sebuah neraca samar-samar terlihat di dalam kabut hitam. 
Di sebelah kiri, terdapat sebuah otak yang tenang seperti danau, dengan lembah perak yang berkilau lembut; di sebelah kanan, ada sebuah jantung merah menyala yang mengeluarkan uap panas. 
Tiba-tiba, kamu mencium aroma yang menggoda, keinginan yang lapar terus membengkak, akal sehatmu tertekan oleh kegelapan-Nya yang tak terbatas. 
Kamu mengulurkan tanganmu.]]
  },
  Event_91510_Name = {
    Text = "Permainan Lapar"
  },
  Event_91511_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91511_Desc = {
    Text = "Ini pasti sebuah mimpi. Kau terus meyakinkan dirimu. \nTanpa sadar, kau benar-benar terjebak dalam mimpi. \nMungkin karena terlalu banyak berkomunikasi baru-baru ini, kau malah bermimpi tentang Duleisain—secara aktif membiarkan Duleisain memakan Caro dan darahmu sendiri? Cerita menyeramkan?"
  },
  Event_91511_Name = {
    Text = "Hampir normal"
  },
  Event_91660_ChoiceDesc1 = {
    Text = "[Mencari Jalan Lain] Pilih 1 dari 3 Kartu perintah untuk mendapatkan Orison: [(EnchantConfig.Arg1)]"
  },
  Event_91660_ChoiceDesc2 = {
    Text = "[Biarkan Dia Ada]Acak 3 kartu perintah untuk mendapatkan orison:\"(EnchantConfig.Arg1)\", terinfeksi\"(Skill.Arg2)\""
  },
  Event_91660_Desc = {
    Text = "\"Menggerakkan jiwa, kamu perlu membimbing orang mati menuju akhir.\"\nBersamaan dengan kata-kata Dullesain, kamu seakan menyadari.\nBukan pengetahuan, dan bukan memori—melainkan sesuatu yang lebih mirip dengan beban, masuk dari kelopak mata kamu dan mengalir deras ke dalam otakmu.\nEmosimu tampaknya tidak lagi milik saat ini, ia mundur, memperlihatkan celah di alam semesta yang terabaikan.\nSemua yang bisa kamu rasakan, terhenti di sana, seperti telah sampai di ujung jalan."
  },
  Event_91660_Name = {Text = "Akhir Jiwa"},
  Event_91661_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91661_Desc = {
    Text = [[
Kau membiarkan jiwa pergi jauh.
Di tepi 'diri', kau seolah mendengar bisikan para arwah.
Tetapi ketika kau mendengarkannya dengan seksama, semuanya menghilang.]]
  },
  Event_91661_Name = {Text = "Akhir Jiwa"},
  Event_91662_ChoiceDesc1 = {Text = "[Keluar]"},
  Event_91662_Desc = {
    Text = [[
Kamu membungkus kesadaranmu sendiri, sehingga mengisolasi dari godaan yang tidak diketahui.
Kamu tersesat di ujung jiwa, hanya melihat dirimu sendiri.
Memang, sebagai orang hidup, kamu tidak bisa memiliki kemampuan zombie.]]
  },
  Event_91662_Name = {Text = "Akhir Jiwa"}
})
return Text_Event
