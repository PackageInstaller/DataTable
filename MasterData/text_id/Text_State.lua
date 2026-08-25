__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_State = readonly({
  State_100291_Desc = {
    Text = "Aliemus yang dihasilkan oleh semua Pembangun meningkat 50%."
  },
  State_100291_Name = {Text = "Menyatakan"},
  State_100292_Name = {
    Text = "Giliran dimulai"
  },
  State_100293_Desc = {
    Text = "Semua Aliemus yang dihasilkan oleh Pembangun berkurang sebesar 50%."
  },
  State_100293_Name = {
    Text = "Bayangan kepribadian"
  },
  State_100295_Name = {
    Text = "Pendengaran kerusakan"
  },
  State_100296_Desc = {
    Text = "Setiap lapisan, setelah ronde dimulai, semua tubuh tersadar mendapatkan <Energy:5> kegilaan."
  },
  State_100296_Name = {
    Text = "Sisi gelap diri sendiri"
  },
  State_100297_Desc = {
    Text = "Semua kemarahan yang diciptakan oleh awakener meningkat 50%, pada akhir putaran dapatkan perisai sebesar 20% secara maksimum dari kehidupan."
  },
  State_100297_Name = {
    Text = "Rintangan jiwa"
  },
  State_100298_Desc = {
    Text = "Kehilangan 10% HP saat giliran dimulai, mendapatkan [DescArg1] poin <PowerIconKeywords: kekuatan>. Semua awakener mengurangi aliemus sebesar 50%."
  },
  State_100298_Name = {
    Text = "Keruntuhan benteng"
  },
  State_100299_Desc = {
    Text = "Hitungan Ledakan Kegilaan"
  },
  State_100299_Name = {
    Text = "Hitungan Ledakan Kegilaan"
  },
  State_100302_Name = {
    Text = "Pemantauan Ledakan Kegilaan"
  },
  State_100307_Desc = {
    Text = "Unik untuk Tim: Setelah pembawa peralatan merilis Muliakan, mendapatkan 1 lapisan \"Kolaborasi\", dan selanjutnya Muliakan Pembangun lain dalam giliran ini dapat menghabiskan \"Kolaborasi\", meningkatkan tingkat kritis Muliakan itu sebesar <WeaponEffect_Num:[StateArg1]%>, dan Pembangun yang menghabiskan \"Kolaborasi\" mendapatkan pengisian ulang Aliemus pembawa peralatan sebesar <WeaponEffect_Num:[StateArg1]%>."
  },
  State_100307_WeaponDesc = {
    Text = "Setelah pembawa peralatan merilis Muliakan, mendapatkan 1 lapisan \"Kolaborasi\", dan selanjutnya Muliakan Pembangun lain dalam giliran ini dapat menghabiskan \"Kolaborasi\", meningkatkan tingkat kritis Muliakan itu sebesar <WeaponEffect_Num:[StateArg1]%>, dan memberikan Aliemus sebesar <WeaponEffect_Num:[DescArg1]> ke Pembangun yang menghabiskan \"Kolaborasi\"."
  },
  State_100326_Desc = {
    Text = "Untuk setiap lapis, di awal giliran semua Pembangun mendapatkan <Energy:3> Aliemus."
  },
  State_100326_Name = {
    Text = "<DarkEgo:Gelap diri>"
  },
  State_100327_Desc = {
    Text = "Semua kemarahan yang diciptakan oleh awakener meningkat 50%, pada akhir putaran dapatkan perisai sebesar 20% secara maksimum dari kehidupan."
  },
  State_100327_Name = {
    Text = "<MindWall:Penghalang Pikiran>"
  },
  State_100328_Desc = {
    Text = "Aliemus yang dihasilkan oleh semua Pembangun meningkat 50%."
  },
  State_100328_Name = {
    Text = "<TrueConfess:Pengakuan>"
  },
  State_100329_Desc = {
    Text = "Mengurangi aliemus yang disebabkan oleh semua tubuh yang terbangun sebesar 50%. Setelah giliran berakhir, memperoleh 1 lapisan \"<DarkEgo:Keserakahan Gelap>\":Pada awal giliran, semua tubuh yang terbangun memperoleh 3 aliemus."
  },
  State_100329_Name = {
    Text = "<ShadowSelf: Bayangan kepribadian>"
  },
  State_100330_Desc = {
    Text = "Kehilangan 10% HP saat giliran dimulai, mendapatkan [DescArg1] poin <PowerIconKeywords: kekuatan>. Semua awakener mengurangi aliemus sebesar 50%."
  },
  State_100330_Name = {
    Text = "<BarrierCrash:Penetrasi Penghalang>"
  },
  State_100395_Name = {
    Text = "Darah Anugerah Ciptaan+"
  },
  State_100396_Name = {
    Text = "Darah Anugerah Ciptaan"
  },
  State_100527_Desc = {
    Text = "Pilihan \"Inspirasi Meledak!\" ditambahkan ketika efek \"Temukan\" Pikeman terpicu: konsumsi 1 lapis \"Khyanak\", pilih semua efek dan mendapatkan 1 lapis \"Kreasi\"."
  },
  State_100527_Name = {
    Text = "Khayalan Liar"
  },
  State_100541_Desc = {
    Text = "Jika memiliki 10 lapis \"Kreasi\" saat ini, Pikeman akan mendapatkan 1 lapis Khyanak dan membuat semua Pembangun mendapatkan 15 poin Aliemus setelah menggunakan semua \"Kreasi\" dalam ledakan Aliemus. Batas maksimum Kreasi adalah 10 lapis, dapat diwarisi ke pertempuran berikutnya."
  },
  State_100541_Name = {
    Text = "<Chuangyi:Kreativitas>"
  },
  State_100542_Desc = {
    Text = "Pilihan \"Inspirasi Meledak!\" ditambahkan ketika efek \"Temukan\" Pikeman terpicu: konsumsi 1 lapis \"Khyanak\", pilih semua efek \"Temukan\" dan mendapatkan 1 lapis \"Kreasi\"."
  },
  State_100542_Name = {
    Text = "<Kuangxiang:Ilusi>"
  },
  State_100544_Name = {
    Text = "Slime Manis"
  },
  State_100544_WeaponDesc = {
    Text = "Peningkatan 6% untuk perisai dan pemulihan hidup yang diberikan oleh pemakai. Jika penguasaan alam pemakai lebih dari 50, perisai dan pemulihan hidup akan mendapatkan peningkatan tambahan sebesar 6%."
  },
  State_100545_Name = {
    Text = "Slime Manis"
  },
  State_100545_WeaponDesc = {
    Text = "Peningkatan 6% untuk perisai dan pemulihan hidup yang diberikan oleh pemakai. Jika penguasaan alam pemakai lebih dari 50, perisai dan pemulihan hidup akan mendapatkan peningkatan tambahan sebesar 6%."
  },
  State_100558_Desc = {
    Text = "Meningkatkan Tingkat kritis dari ledakan Aliemus oleh Pembangun lain sebesar [StateArg1]% kali berikutnya pada giliran ini, mendapatkan [DescArg1] poin Aliemus setelah digunakan."
  },
  State_100558_Name = {
    Text = "Buat Bersama"
  },
  State_100559_Desc = {
    Text = "Termasuk \"Star Domain Relik\" berikut: Anak Nakal, Festival Musim Semi, Belenggu Berat, Akik Berjalin Benang, Darah Pemberian, Gergaji Besi Berkarat, Padang Emas Mimpi, Kerikil Berlumuran Darah."
  },
  State_100559_Name = {
    Text = "<Chuanggouzaowu:Relik Konstruksi>"
  },
  State_100562_Desc = {
    Text = "Mengurangi biaya Aritmetika dari [Layer] Kartu perintah berikutnya yang dimainkan di giliran ini sebanyak 2."
  },
  State_100562_Name = {
    Text = "Kenyataan, juga Khayalan"
  },
  State_100564_Desc = {
    Text = "Termasuk \"Orison\" berikut: Rencana, Keterampilan Tangan, Aliemus, Katalis, Kekuatan Kasar, Tembok Besi, Pelemahan, Inspirasi."
  },
  State_100564_Name = {
    Text = "<Chuanggoukeyin:Cap Konstruksi>"
  },
  State_100566_WeaponDesc = {
    Text = "Mengubah aritmetika kartu sebelum bermain"
  },
  State_100617_Desc = {
    Text = "Saat akhir giliran, dapatkan 1 batas tentakel."
  },
  State_100617_Name = {
    Text = "Obsesi kelam"
  },
  State_100619_Desc = {
    Text = "Ketika kekuatan berkurang, hanya akan mengurangi 50% dari jumlah lapisan kekuatan."
  },
  State_100619_Name = {
    Text = "Ketahanan Drain"
  },
  State_100621_Desc = {
    Text = "Setiap lapisan mengurangi kerusakan dasar oleh pemain sebesar 15%, dapat memandu arah pelayaran selanjutnya."
  },
  State_100621_Name = {
    Text = "Lilin redup"
  },
  State_100623_Desc = {
    Text = "Setiap lapisan mengurangi kerusakan dasar oleh pemain sebesar 30%, setelah menyebabkan kerusakan aktif atau kerusakan tentakel, kurangi [DescArg1] racun."
  },
  State_100623_Name = {
    Text = "Cahaya penuntun"
  },
  State_100639_Desc = {
    Text = "Kerusakan tentakel yang ditimbulkan sementara berkurang 50%."
  },
  State_100639_Name = {
    Text = "Lemuria, Kota yang Hilang"
  },
  State_100644_Desc = {
    Text = "Permanen turunkan kekuatan target, dapatkan kekuatan setara."
  },
  State_100644_Name = {
    Text = "<TouquKeywords: Mencuri Permanen>"
  },
  State_100647_Desc = {
    Text = "Kebal terhadap semua kerusakan."
  },
  State_100647_Name = {
    Text = "Kebal terhadap semua kerusakan."
  },
  State_100694_Desc = {
    Text = "Setiap lapisan mengurangi kerusakan dasar oleh pemain sebesar 30%, setelah menyebabkan kerusakan aktif atau kerusakan tentakel, kurangi racun."
  },
  State_100694_Name = {
    Text = "Cahaya penuntun"
  },
  State_116342_Desc = {
    Text = "Setelah memainkan kartu <ErosionColorInkKeywords:Kekacauan Kognisi>, berikan \"Pelukis\" 1 lapis <DecayDye:Pewarna Dunia Ilusi>."
  },
  State_116342_Name = {
    Text = "Palet anomali"
  },
  State_116406_Name = {
    Text = "Tingkat Lanjutan"
  },
  State_116407_Name = {
    Text = "Keadaan kosong"
  },
  State_116858_Desc = {
    Text = "Status ini menggunakan zona rentan, berpura-pura menjadi zona multiplikasi independen.__\"Hanya untuk pengembangan\""
  },
  State_116858_Name = {
    Text = "Jika memiliki status tertentu, kerusakan yang diterima menjadi dua kali lipat__\"Hanya untuk pengembangan\""
  },
  State_116859_Desc = {
    Text = "Pada awal putaran berikutnya, dapatkan falter."
  },
  State_116859_Name = {
    Text = "Keterlambatan falter"
  },
  State_116958_Desc = {
    Text = "Setelah memainkan kartu, akan menerima kerusakan sesuai dengan lapisan yang bersangkutan."
  },
  State_116958_Name = {
    Text = "<PVPCardLockColour:Penguncian kartu>"
  },
  State_117154_Desc = {
    Text = "Efek ini akan aktif hanya 1 kali di semua awak awak, tidak dapat dipicu ulang."
  },
  State_117154_Name = {
    Text = "<TeamUnique: Tim unik>"
  },
  State_117212_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Sebelum \"Skill\" dan pada akhir giliran, memberikan <Damage:[Damage:StateArg1]> tumpukan <PVPCorrosionKeywords:Tanda Dosa> kepada musuh dengan <HPAndShieldMax:HP dan Perisai tertinggi>."
  },
  State_117212_Name = {Text = "Pollux"},
  State_117213_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: \"Keterampilan\" dan saat berakhirnya ronde, menyebabkan [StateArg1] <PVPfengsuoKeywords:Penguncian Ledakan> kepada musuh dengan aliemus tertinggi."
  },
  State_117213_Name = {
    Text = "Pollux SR (teks sementara)"
  },
  State_117346_Desc = {
    Text = "Kerusakan yang dihasilkan Pollux menambahkan [Layer]% bleed."
  },
  State_117346_Name = {Text = "Tanda dosa"},
  State_117355_Desc = {
    Text = "Kartu perintah yang sehingga dihasilkan oleh <pollux> aktif 2 kali."
  },
  State_117355_Name = {
    Text = "Perjanjian Baru Wahyu Ilahi"
  },
  State_117357_Desc = {
    Text = "Unik untuk tim: \"D-marka\" dan \"Sisa Abu\" setelah refresh menghasilkan <WeaponEffect_Num:[StateArg1]> poin aliemus bagi pemegang."
  },
  State_117357_WeaponDesc = {
    Text = "\"D-mark\" dan \"Jejak Abunya\" setelah refresh akan memberi pemakai <WeaponEffect_Num:[StateArg1]> poin aliemus."
  },
  State_117358_Desc = {
    Text = "Setiap lapisan menambahkan 1% bleed ke kerusakan yang dibuat Pollux."
  },
  State_117358_Name = {
    Text = "<ZuiyinKeywords: Sandi dosa>"
  },
  State_117744_Desc = {
    Text = "Hilang [Layer] <MaxHPKeywords:Max HP>, saat dihilangkan tidak mengembalikan Max HP yang hilang, saat dipicu menerima [Layer] poin Kerusakan Murni, permanen."
  },
  State_117744_Name = {Text = "Tanda dosa"},
  State_117745_Desc = {
    Text = "Kehilangan <MaxHPKeywords:Max HP> sejumlah lapisan saat diterapkan, tidak mengembalikan Max HP yang hilang saat dihilangkan, menerima Kerusakan Murni sejumlah lapisan saat dipicu, berlangsung selamanya."
  },
  State_117745_Name = {
    Text = "<PVPCorrosionKeywords:Dosa-Etching>"
  },
  State_117755_Desc = {
    Text = "Tidak dapat melakukan tindakan apa pun hingga giliran berakhir."
  },
  State_117755_Name = {Text = "Fainted"},
  State_117756_Desc = {
    Text = "Tidak dapat melakukan tindakan apa pun hingga giliran berakhir."
  },
  State_117756_Name = {Text = "Fainted"},
  State_117776_Desc = {
    Text = "Kerusakan akhir dan perisai dari [Layer] kartu perintah yang dimainkan pada putaran ini meningkat [StateArg1]%."
  },
  State_117776_Name = {Text = "Api Dewa"},
  State_117777_Desc = {
    Text = "Unik untuk tim: Kerusakan dasar dan kerusakan kritis kartu yang diperoleh oleh pemegang meningkat <WeaponEffect_Num:[StateArg1]%>. Pada awal giliran dan setelah pemegang melepaskan eksalasi, mendapatkan 1 lapisan 'Hati Luar Biasa', pemegang akan menghabiskan 1 lapisan 'Hati Luar Biasa' saat memainkan kartu perintah di giliran ini, meningkatkan kerusakan final dan perisai sebesar <WeaponEffect_Num:[StateArg2]%.> Dalam ultra round, akan mendapatkan 'Api Ilahi', efeknya menjadi dua kali lipat."
  },
  State_117777_WeaponDesc = {
    Text = "Kerusakan dasar dan crit. dmg yang dihasilkan oleh kartu pemegang peralatan meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Di awal ronde dan setelah pemegang mengeluarkan exalt, mendapatkan 1 lapisan hati fire, satu lapisan \"Hati Fire\" dikonsumsi saat pemegang mengeluarkan kartu perintah di giliran ini, meningkatkan final dmg dan perisai sebesar <WeaponEffect_Num:[StateArg2]%>. Mengubah menjadi mendapatkan \"Api Dewa\" pada ultra round, dengan efek ganda."
  },
  State_117778_Desc = {
    Text = "Kerusakan akhir dan perisai dari [Layer] kartu perintah yang dimainkan pada putaran ini meningkat [StateArg1]%."
  },
  State_117778_Name = {
    Text = "Api di hati"
  },
  State_117779_Desc = {
    Text = "Unik untuk tim: Dalam ultra round, pemegang mendapatkan 3 lapisan 'Hati Luar Biasa', pemegang akan menghabiskan 1 lapisan saat memainkan kartu perintah di giliran ini, meningkatkan kerusakan final dan perisai sebesar <WeaponEffect_Num:[StateArg1]%>."
  },
  State_117779_WeaponDesc = {
    Text = "Pada ultra round, pengguna mendapatkan 3 lapisan \"Api Hati\", dan ketika pengguna memainkan kartu perintah di giliran ini, 1 lapisan akan terpakai, meningkatkan final dmg dan perisai sebesar <WeaponEffect_Num:[StateArg1]%>."
  },
  State_117851_Desc = {
    Text = "Pollux menikmati efek \"Penyelamatan dari Penderitaan\" tambahan 50% dari setiap kartu perintah, berlangsung selama [Layer] giliran."
  },
  State_117851_Name = {
    Text = "Cahaya yang Menerangi Malam Putih"
  },
  State_117853_Desc = {
    Text = "Kerusakan dari [Layer] kartu perintah yang dimainkan Pollux pada giliran ini meningkat [DescArg1], perisai meningkat [DescArg2], mendapatkan 10 poin aliemus."
  },
  State_117853_Name = {
    Text = "Penyelamatan dari penderitaan"
  },
  State_117869_Desc = {
    Text = "Setiap kali melepaskan exalt, menambah 1 lapisan \"Panggilan\", setiap lapisan \"Panggilan\" mendapatkan [DescArg1] Kekuatan, dengan batas maksimum 5 lapisan."
  },
  State_117869_Name = {
    Text = "Pendeta Agung Laut Dalam"
  },
  State_117870_Desc = {
    Text = "Setelah kematian, pembunuh memulihkan 20% dari Hidup yang hilang."
  },
  State_117870_Name = {
    Text = "Sashimi lezat"
  },
  State_117875_Desc = {
    Text = "Jika ada ruang kosong di belakang, setelah tindakan kehilangan 1 lapisan, memanggil 1 \"Ikan Muda\" dengan tambahan \"Sashimi Lezat\"."
  },
  State_117875_Name = {
    Text = "Kontrak Saling Bantu: Kawanan Ikan"
  },
  State_117876_Desc = {
    Text = "Efek <WeaknessIconKeywords:kelemahan>, <FragileIconKeywords:rapuh>, dan <HeavyInjuryKeywords:luka berat> yang diberikan ditingkatkan menjadi 50%."
  },
  State_117876_Name = {
    Text = "Kelemahan&Rapuh&Luka Berat Diperparah"
  },
  State_117880_Desc = {
    Text = "Dalam pertempuran ini, \"Gerombolan Ikan Meloncat\" akan terpicu tambahan 1 kali setelahnya."
  },
  State_117880_Name = {
    Text = "Kawanan ikan melompat terpicu tambahan"
  },
  State_117883_Desc = {
    Text = "Setelah mencapai level 5, segel semua awak yang terjaga, ubah niat menjadi: \"Kemuliaan Lemuria!+\"."
  },
  State_117883_Name = {Text = "Panggilan"},
  State_117885_Desc = {
    Text = "Ketika terkena efek pengurangan kekuatan, juga akan memberikan efek pengurangan kekuatan yang sama kepada pemberi efek."
  },
  State_117885_Name = {
    Text = "Gigi untuk gigi"
  },
  State_117889_Desc = {
    Text = "Saat muncul, kesehatan maksimum sendiri meningkat 10% dan memberikan [DescArg1] <PowerIconKeywords:Kekuatan> kepada sekutu lain, membuat efek peningkatan kesehatan dan perolehan kekuatan dari <FishLeapWords:Kekuatan Tatanan Kawanan> terpicu tambahan 1 kali dalam pertempuran ini."
  },
  State_117889_Name = {
    Text = "Kekuatan Tatanan Kawanan"
  },
  State_118112_Desc = {
    Text = "Batas maksimum kerusakan tunggal yang diterima adalah [DescArg1] poin, akan dihapus setelah HP di bawah 50%."
  },
  State_118112_Name = {
    Text = "Ambang Batas Nyeri I"
  },
  State_118113_Desc = {
    Text = "Setelah menerima Kerusakan aktif dan kehilangan hidup, mendapatkan Perisai setara dengan 15% dari hidup yang hilang dan <AlertIconKeywords: Kewaspadaan Sementara> setara dengan 5% dari hidup yang hilang."
  },
  State_118113_Name = {
    Text = "Fisik Lunak I"
  },
  State_118114_Desc = {
    Text = "Setelah menerima Kerusakan aktif dan kehilangan hidup, mendapatkan Perisai setara dengan 35% dari hidup yang hilang dan <AlertIconKeywords: Kewaspadaan Sementara> setara dengan 10% dari hidup yang hilang."
  },
  State_118114_Name = {
    Text = "Fisik Lunak III"
  },
  State_118115_Desc = {
    Text = "Jika ada ruang kosong di barisan depan, setelah tindakan kehilangan 1 lapisan, memanggil 1 \"Gumpalan Laut Dalam\"."
  },
  State_118115_Name = {
    Text = "Kontrak Saling Bantu: Gumpalan Laut Dalam"
  },
  State_118116_Desc = {
    Text = "Batas kerusakan tunggal yang diterima adalah [DescArg1] poin, akan dihapus setelah HP di bawah 50%."
  },
  State_118116_Name = {
    Text = "Ambang Batas Nyeri II"
  },
  State_118117_Desc = {
    Text = "Batas maksimum kerusakan tunggal yang diterima adalah [DescArg1] poin, akan dihapus setelah HP di bawah 50%."
  },
  State_118117_Name = {
    Text = "Ambang Batas Nyeri III"
  },
  State_118118_Desc = {
    Text = "Dapatkan 1 tentakel dengan <TentacleInjurieIconKeywords:Kerusakan tentakel> sebesar [TentaclePower:DescArg1] dan batas maksimum 5 tentakel. Setelah akhir ronde, dapatkan 1 tentakel. Efek pengurangan kekuatan yang diterima berkurang 50%."
  },
  State_118118_Name = {
    Text = "Pertemuan Tentakel"
  },
  State_118119_Desc = {
    Text = "Setelah menerima Kerusakan aktif dan kehilangan hidup, mendapatkan Perisai setara dengan 25% dari hidup yang hilang dan <AlertIconKeywords: Kewaspadaan Sementara> setara dengan 5% dari hidup yang hilang."
  },
  State_118119_Name = {
    Text = "Fisik Lunak II"
  },
  State_118319_Desc = {
    Text = "Batas maksimum kerusakan tunggal yang diterima adalah [DescArg1] poin, akan dihilangkan setelah HP di bawah 50%."
  },
  State_118319_Name = {
    Text = "Pembatasan Kerusakan Perisai Samudra"
  },
  State_118320_Name = {
    Text = "Jumlah Penanggulangan Kelelahan Sementara"
  },
  State_118321_Name = {
    Text = "Jumlah Penanggulangan Kelelahan"
  },
  State_118322_Name = {
    Text = "Tanda Persiapan Memanggil"
  },
  State_118323_Desc = {
    Text = "Telah memicu kawanan ikan melompat"
  },
  State_118323_Name = {
    Text = "Tanda keluarnya kawanan ikan melompat"
  },
  State_118324_Desc = {
    Text = "Setiap kali menyebabkan 1 kerusakan, hasilkan 1 tentakel sementara."
  },
  State_118324_Name = {
    Text = "Anugerah Ilahi"
  },
  State_118325_Desc = {
    Text = "Saat menyebabkan kerusakan yang tidak terblokir, masukkan [DescArg1] kartu Tercekik ke bagian atas tumpukan Menggambar"
  },
  State_118325_Name = {
    Text = "Kepala Ular Dunia Baru Bergetar"
  },
  State_118656_Desc = {
    Text = "Menerima [StateArg1] kerusakan saat memainkan kartu dan menghilangkan 1 lapisan. Saat jumlah lapisan menjadi 0, menetas satu \"Benda Laut\" yang lebih lemah. Jika status parasit masih ada saat giliran berakhir, menetas satu \"Benda Laut\" dengan hidup yang meningkat sesuai dengan jumlah lapisan."
  },
  State_118656_Name = {
    Text = "Terinfestasi berkali-kali"
  },
  State_118657_Desc = {
    Text = "Menerima [StateArg1] kerusakan saat memainkan kartu dan menghilangkan 1 lapisan. Saat jumlah lapisan menjadi 0, menetas satu \"Benda Laut\" yang lebih lemah. Jika status parasit masih ada saat giliran berakhir, menetas satu \"Benda Laut\" dengan hidup yang meningkat sesuai dengan jumlah lapisan."
  },
  State_118657_Name = {
    Text = "Diparasitkan Kembali"
  },
  State_118659_Desc = {
    Text = "Menerima [StateArg1] kerusakan saat memainkan kartu dan menghilangkan 1 lapisan. Saat jumlah lapisan menjadi 0, menetas satu \"Benda Laut\" yang lebih lemah. Jika status parasit masih ada saat giliran berakhir, menetas satu \"Benda Laut\" dengan hidup yang meningkat sesuai dengan jumlah lapisan."
  },
  State_118659_Name = {
    Text = "Parasitized"
  },
  State_118663_Name = {
    Text = "Pemantauan Niat Kepala Ular Dunia Baru"
  },
  State_118669_Name = {
    Text = "Inisialisasi Kepala Ular Dunia Baru"
  },
  State_118670_Desc = {
    Text = "Deteksi apakah ada Penanggulangan Kelelahan"
  },
  State_118670_Name = {
    Text = "Deteksi Penanggulangan Kelelahan"
  },
  State_118671_Desc = {
    Text = "Deteksi perilaku pemain yang mengalami kelelahan"
  },
  State_118671_Name = {
    Text = "Pemantauan Penanggulangan Kelelahan"
  },
  State_118672_Name = {
    Text = "Pemantauan Niat Kepala Ular Dunia Baru Sedang dalam pendinginan"
  },
  State_118741_Name = {
    Text = "Hapus Tentakel Sementara"
  },
  State_118743_Name = {
    Text = "Persiapan Memanggil posisi awal memerlukan tanda pemanggilan"
  },
  State_118759_Name = {
    Text = "Jumlah Tentakel Permanen monster saat ini"
  },
  State_118760_Name = {
    Text = "Batas maksimum Tentakel Permanen monster"
  },
  State_118762_Name = {
    Text = "Petunjuk pembusukan pertama"
  },
  State_118763_Name = {
    Text = "Petunjuk pertama Toksin saraf-Tusukan Darah"
  },
  State_118764_Name = {
    Text = "Petunjuk pertama Kutukan Tiupan"
  },
  State_118766_Name = {
    Text = "Pemantauan Niat BOSS Gurita cincin biru"
  },
  State_118769_Name = {
    Text = "Petunjuk Lentera Inti Perak"
  },
  State_118771_Name = {
    Text = "Petunjuk percobaan pertama"
  },
  State_118772_Name = {
    Text = "Petunjuk pertama kawanan ular merobek"
  },
  State_118935_Name = {
    Text = "Pemantauan Niat Monster Murphy"
  },
  State_118938_Desc = {
    Text = "\"Deep Sea Lady\" telah bangkit, jumlah perisai yang dihasilkan sangat meningkat!"
  },
  State_118938_Name = {
    Text = "Dibuat menjadi ada"
  },
  State_118943_Desc = {
    Text = "Kerusakan yang diterima pada ronde sendiri berlipat ganda. Saat kehilangan hidup, kehilangan jumlah lapisan yang setara. Ketika jumlah lapisan menjadi 0, kurangi jumlah tentakel secara permanen sebanyak 1 dan reset jumlah lapisan, minimal 1 tentakel."
  },
  State_118943_Name = {
    Text = "Pengorbanan Sang Dewi"
  },
  State_118973_Name = {
    Text = "Manajemen Pemberontakan Tersembunyi"
  },
  State_119051_Desc = {
    Text = "Terpicu saat akhir giliran, menderita Kerusakan Murni dalam jumlah tumpukan yang sama dan menghapus setengah tumpukan, tidak dapat dispel."
  },
  State_119051_Name = {
    Text = "<PVPSacrificeKeyWords:Pengorbanan>"
  },
  State_119052_Desc = {
    Text = "Mendapatkan pengorbanan sebesar [Layer]% setelah menerima kerusakan aktif."
  },
  State_119052_Name = {
    Text = "Upacara Kelahiran"
  },
  State_119053_Desc = {
    Text = "Terpicu saat akhir giliran, menderita [Layer] poin Kerusakan Murni dan menghapus setengah tumpukan, tidak dapat dispel."
  },
  State_119053_Name = {
    Text = "Pengorbanan"
  },
  State_119058_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat akhir giliran, memberikan [StateArg1] <PVPSacrificeKeyWords:Pengorbanan> kepada musuh dengan Pengorbanan paling sedikit, diulang [StateArg2] kali. Seluruh sekutu tidak lagi terpengaruh efek pengurangan <PVPCapKeywords:Arithmetica Limit>."
  },
  State_119058_Name = {
    Text = "Istirahat dalam Kegelapan"
  },
  State_119059_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setelah \"Exalt\" membuat semua musuh mendapatkan Pengorbanan [StateArg1]% dari kerusakan setelah menerima kerusakan aktif pada giliran ini."
  },
  State_119059_Name = {
    Text = "Birring Toksin"
  },
  State_119060_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Pukulan\"kerusakan meningkat sebesar [StateArg1]%, setelah sembarang teman mengeluarkan\"Pukulan\"gambar [StateArg3] kartu, maksimal dapat memicu [StateArg2] kali per giliran (saat ini telah memicu [DescArg1] kali)."
  },
  State_119060_Name = {
    Text = "Pembantaian Hingga Ujung Dunia"
  },
  State_119061_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Semua sekutu\"Serangan\"kerusakan meningkat sebesar [StateArg1]%."
  },
  State_119061_Name = {
    Text = "Lentera Kewarasan"
  },
  State_119063_Desc = {
    Text = "Setelah mencapai level 5, ubah niat menjadi:\"Kemuliaan Lemuria!\"."
  },
  State_119063_Name = {Text = "Panggilan"},
  State_119075_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_119075_Name = {Text = "Not Roused"},
  State_119076_Desc = {
    Text = "Jika ada posisi kosong di barisan depan, maka setelah bergerak, satu lapisan akan hilang dan secara acak memanggil satu \"awak Lemuria\"."
  },
  State_119076_Name = {
    Text = "Perjanjian Saling Bantu: Lemuria"
  },
  State_119077_Desc = {
    Text = "\"Panggilan\" mencapai 5 lapisan, segera menyegel semua awakener."
  },
  State_119077_Name = {
    Text = "Miryam Bangun!"
  },
  State_119077_WeaponDesc = {
    Text = "Pada ronde berikutnya, dapatkan perisai sejumlah kehilangan hidup dari ronde sebelumnya."
  },
  State_119080_Desc = {
    Text = "Saat melepaskan\"Memori Chaos\"atau\"Senja Tak Terlupakan\", Kunci yang dipilih akan berefek tambahan 1 kali."
  },
  State_119080_Name = {
    Text = "Dari Kelupaan"
  },
  State_119082_Desc = {
    Text = "Setiap kali Awakener melepaskan Exalt, Aliemus dasarnya meningkat sebesar 10 poin."
  },
  State_119082_Name = {
    Text = "Aliemus Exhaustion"
  },
  State_119083_Desc = {
    Text = "Saat kartu perintah diambil dari ruang ultra, konsumsi arithmetica -1."
  },
  State_119083_Name = {
    Text = "Akhir jalan lain"
  },
  State_119084_Desc = {
    Text = "Setiap kali Lepaskan Posse, Energi-s yang dibutuhkan meningkat sebesar 100 poin."
  },
  State_119084_Name = {
    Text = "Oscilasi Kunci Perak"
  },
  State_119085_Desc = {
    Text = "Setelah menggunakan tungku merah darah, ubah 1 embrio menjadi anak yang suci, cooldown 3 putaran."
  },
  State_119085_Name = {
    Text = "Merah darah menyusui"
  },
  State_119086_Desc = {
    Text = "Kekuatan pembiakan dalam cooldown, sisa [Layer] putaran."
  },
  State_119086_Name = {
    Text = "Kekuatan pembiakan - cooldown"
  },
  State_119104_Desc = {
    Text = "Pada awal ronde, dapatkan [DescArg1] lapisan \"Ambang Takdir\"."
  },
  State_119104_Name = {
    Text = "Ritual Laut"
  },
  State_119105_Desc = {
    Text = "Setelah mati, kehilangan semua \"Ambang Takdir\". Setiap lapisan memulihkan 1% dari Max HP dan meningkatkan Kerusakan tentakel sebesar 1%."
  },
  State_119105_Name = {
    Text = "Ambang Takdir"
  },
  State_119106_Name = {
    Text = "Pemantauan Niat Monster Kelahiran Murphy"
  },
  State_119107_Name = {
    Text = "Manajemen Tatanan Negara Dewa"
  },
  State_119108_Desc = {
    Text = "Saat kehilangan hidup, setiap lapisan memberikan <SacrificeKeyWord:Pengorbanan> sebesar 1% dari kehilangan hidup."
  },
  State_119108_Name = {
    Text = "Upacara Kelahiran"
  },
  State_119109_Desc = {
    Text = "Saat menerima kerusakan selain dari <SacrificeKeyWord:Pengorbanan>, kehilangan \"Tatanan Kerajaan Ilahi\" dalam jumlah yang sama, dan dapatkan <SacrificeKeyWord:Pengorbanan> sebesar 50% dari kerusakan. Ketika jumlah lapisan menjadi 0, dapatkan 1 lapisan \"Ambang Takdir\" dan reset jumlah lapisan."
  },
  State_119109_Name = {
    Text = "Tatanan Negara Dewa"
  },
  State_119132_Desc = {
    Text = "Daya \"Serangan\" meningkat di putaran ini [Layer]%."
  },
  State_119132_Name = {
    Text = "Pukulan semakin kuat"
  },
  State_119134_Name = {
    Text = "Petunjuk pertama Pencipta Ilusi"
  },
  State_119359_Name = {
    Text = "Penghitungan Ritual Kunci Perak"
  },
  State_119362_Name = {
    Text = "Melakukan ritual"
  },
  State_119363_Name = {
    Text = "Memiliki kartu"
  },
  State_119364_Name = {
    Text = "Hitung ritual kegilaa"
  },
  State_119365_Desc = {
    Text = "Semua awakener meningkatkan pemulihan kehidupan dan perisai sebesar 40%."
  },
  State_119365_Name = {
    Text = "Tenang saja"
  },
  State_119366_Desc = {
    Text = "Kembali ke tangan setelah dibuang"
  },
  State_119366_Name = {
    Text = "Kembali ke tangan setelah dibuang"
  },
  State_119367_Name = {
    Text = "Hitung ritual kehidupa"
  },
  State_119368_Desc = {
    Text = "Setiap awal giliran, mendapatkan 500 poin keyflare."
  },
  State_119368_Name = {
    Text = "Seperti melihat api dengan jelas"
  },
  State_119369_Desc = {
    Text = "Semua awakener meningkatkan aliemus sebesar 50%."
  },
  State_119369_Name = {
    Text = "William yang berkuasa"
  },
  State_119370_Name = {Text = "Relic"},
  State_119373_Name = {
    Text = "Musuh menerapkan pengorbanan"
  },
  State_119567_Name = {
    Text = "Selesaikan ritual"
  },
  State_119568_Desc = {
    Text = "Dampak yang diterima meningkatkan Kerusakan [Layer] poin."
  },
  State_119568_Name = {
    Text = "Pukulan semakin dalam"
  },
  State_119583_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Sebelum \"Serangan\", sebelum \"Keterampilan\", sebelum \"Exalt\" sementara <StrongEffectKeywords:amplification> +[StateArg1], setiap efek hanya dapat dipicu sekali per giliran."
  },
  State_119583_Name = {
    Text = "Kita akhirnya akan bertemu kembali"
  },
  State_119588_Name = {Text = "Caro cd"},
  State_119589_Name = {Text = "Ultra cd"},
  State_119590_Desc = {
    Text = "Tim Unik: Setelah secara aktif beralih Postur Tentakel, menggunakan Crimson Furnace, atau melepaskan \"Pembantaian\", menarik 1 Kartu perintah milik Pemakai, masing-masing efek memiliki cooldown 3 giliran. Affiniti yang diperoleh semua Awakener dari eksplorasi meningkat sebesar <WeaponEffect_Num:[StateArg1]%>."
  },
  State_119590_WeaponDesc = {
    Text = "Beralih secara aktif ke postur Tentakel (sisa cooldown [DescArg1] ronde saat ini), gunakan Dapur Merah (sisa cooldown [DescArg2] ronde saat ini), setelah melepaskan \"Annihilation\" (sisa cooldown [DescArg3] ronde saat ini), tarik 1 kartu perintah pemakai, setiap efek memiliki cooldown 3 ronde. Setelah menyelesaikan eksplorasi, semua Pembangun memperoleh peningkatan Affiniti sebesar <WeaponEffect_Num:[StateArg1] %>."
  },
  State_119591_Name = {
    Text = "Cd Laut Dalam"
  },
  State_119741_Desc = {
    Text = "Semua awakener menurunkan efek kekuatan sebesar 50%."
  },
  State_119741_Name = {
    Text = "Kutukan Patung: Kesedihan yang Memudar"
  },
  State_119742_Desc = {
    Text = "Setiap awal giliran mengembalikan 15% hp yang hilang."
  },
  State_119742_Name = {
    Text = "Berkat Patung: Mimpi Kekal"
  },
  State_119743_Desc = {
    Text = "Semua awakener mengurangi kehidupan yang dipulihkan sebesar 50%."
  },
  State_119743_Name = {
    Text = "Kutukan Patung: Kebencian Kehancuran"
  },
  State_119744_Desc = {
    Text = "\"Kutukan Patung: Kebencian Keterpurukan\" tidak aktif selama 1 putaran."
  },
  State_119744_Name = {
    Text = "Imun terhadap Kutukan Patung Suci: Kebencian yang Hancur"
  },
  State_119746_Name = {
    Text = "Jumlah Kehilangan Kunci Jurang"
  },
  State_119747_Desc = {
    Text = "Tidak akan menerima kerusakan, berlangsung 1 putaran."
  },
  State_119747_Name = {
    Text = "Kunci Perak, menunjukkan jalan ke depan"
  },
  State_119748_Desc = {
    Text = "\"Kutukan Patung: Kesedihan Kehancuran\" tidak aktif selama 1 giliran."
  },
  State_119748_Name = {
    Text = "Kutukan Ikon Kebal: Kesedihan Kehancuran"
  },
  State_119749_Desc = {
    Text = "Pada awal giliran Penjaga, terapkan 1 lapisan <SlowIconKeywords:stagnation> pada kartu yang setara dengan jumlah lapisan dari \"<Abyssallock:Mimpi terikat>\"."
  },
  State_119749_Name = {
    Text = "Belenggu Mimpi"
  },
  State_119750_Name = {
    Text = "Niat tirai langit mendengarkan"
  },
  State_119751_Name = {
    Text = "Tanda pelepasan kembali tirai"
  },
  State_119752_Desc = {
    Text = "Setiap awal giliran mendapatkan <PowerIconKeywords:Kekuatan> 5% dari max hp, sementara crit. rate sementara +25%."
  },
  State_119752_Name = {
    Text = "Berkat Patung: Mimpi Kekuata"
  },
  State_119753_Name = {
    Text = "Penghitungan arus laut yang suram"
  },
  State_119754_Desc = {
    Text = "Semua Aliemus yang dihasilkan oleh Pembangun berkurang sebesar 50%."
  },
  State_119754_Name = {
    Text = "Kutukan Patung: Keluhan Kebodohan"
  },
  State_119755_Name = {
    Text = "Hitungan kematian"
  },
  State_119756_Desc = {
    Text = "\"Kutukan Patung: Keluhan Kebodohan\" tidak berlaku selama 1 putaran."
  },
  State_119756_Name = {
    Text = "Kutukan Imej Imun: Keluhan Kebodohan"
  },
  State_119757_Desc = {
    Text = "Pada awal giliran Penjaga, terapkan 1 lapisan <SlowIconKeywords:Stagnation> pada kartu tangan yang setara dengan lapisan \"<Abyssallock:Belenggu Mimpi>\". Setiap kali \"Tabir Taman Hiburan\" dihancurkan oleh kerusakan aktif, satu lapisan akan berkurang dan Awakener yang dihancurkan akan \"Sealed\" selama 1 ronde."
  },
  State_119757_Name = {
    Text = "Belenggu Mimpi"
  },
  State_119758_Desc = {
    Text = "Setiap awal giliran, semua awak akan mendapatkan 10 poin kegilaan."
  },
  State_119758_Name = {
    Text = "Berkat Patung: Mimpi Kebijaksanaa"
  },
  State_119760_Name = {
    Text = "Pemantauan kematian"
  },
  State_119789_Desc = {
    Text = "Saat putaran dimulai, pulihkan [Layer] poin kehidupan."
  },
  State_119789_Name = {
    Text = "Bunga dari Lumpur"
  },
  State_119837_Desc = {
    Text = "Kartu perintah berikutnya yang dimainkan oleh Ramona pada ronde ini akan berlaku 2 kali."
  },
  State_119837_Name = {
    Text = "Bersatu Kembali"
  },
  State_119847_Desc = {
    Text = "Mengubah aritmetika kartu sebelum bermain.__\"仅开发用\""
  },
  State_119847_Name = {
    Text = "Mengubah aritmetika kartu sebelum bermain__\"仅开发用\""
  },
  State_119928_Desc = {
    Text = "Setelah digunakan, efek tambahan berlaku sebanyak [StateArg1] kali, <DepleteIconKeywords:Lelah>. <RippleKeywords:Gelombang purna>: Tarik 2 kartu."
  },
  State_119928_Name = {
    Text = "<Rune_20:Gema Gelombang Amarah>"
  },
  State_119958_Desc = {
    Text = "Segera setelah mati, panggil satu \"Kawanan Ikan\" secara acak, mengurangi \"Arus Ikan\" sebanyak 1 lapisan."
  },
  State_119958_Name = {Text = "Arus ikan"},
  State_119959_Desc = {
    Text = "Segera setelah mati, panggil satu \"kelompok janin\" secara acak, mengurangi \"Kelahiran Abadi\" sebanyak 1 lapisan."
  },
  State_119959_Name = {
    Text = "Hidup abadi"
  },
  State_119960_Desc = {
    Text = "Active DMG dan kerusakan tentakel yang ditimbulkan berkurang 35%, dihapus saat HP pemain saat ini lebih dari 50%."
  },
  State_119960_Name = {
    Text = "<PurpleKeyWord:Pembusukan>"
  },
  State_120215_Desc = {
    Text = "Pada awal giliran Penjaga, terapkan 1 lapisan <SlowIconKeywords:Stagnation> pada kartu tangan yang setara dengan lapisan \"<Abyssallock:Belenggu Mimpi>\". Setiap kali \"Tabir Taman Hiburan\" dihancurkan oleh kerusakan aktif, satu lapisan akan berkurang dan Awakener yang dihancurkan akan \"Sealed\" selama 1 ronde."
  },
  State_120215_Name = {
    Text = "Kunci Dimensi"
  },
  State_120216_Desc = {
    Text = "Pada awal giliran Penjaga, terapkan 1 lapisan <SlowIconKeywords:stagnation> pada kartu yang setara dengan jumlah lapisan dari \"<Abyssallock:kunci jurang>\"."
  },
  State_120216_Name = {
    Text = "Kunci Dimensi"
  },
  State_120218_Name = {
    Text = "Pilih dukungan Murphy saat akhir giliran"
  },
  State_120222_Name = {
    Text = "Pilih untuk membalikkan kutukan saat putaran dimulai"
  },
  State_120292_Name = {
    Text = "Rasa Sakit yang Tidak Diterima"
  },
  State_120293_Desc = {
    Text = "Pada akhir ronde, pulihkan [Layer] poin Hidup."
  },
  State_120293_Name = {
    Text = "Rasa Sakit yang Tidak Diterima"
  },
  State_120312_Desc = {
    Text = "Segera setelah mati, panggil satu \"Raja Ikan\" secara acak, mengurangi \"Arus Ikan\" sebanyak 1 lapisan."
  },
  State_120312_Name = {Text = "Arus ikan"},
  State_120320_Desc = {
    Text = "Setiap lapisan meningkatkan \"Ritual Kelahiran\" yang diterapkan oleh \"Putri Ilusi\" berikutnya sebesar 20%, maksimum bertumpuk 5 lapisan, setelah penuh 5 lapisan, jumlah kerusakan dari \"Putri Ilusi\" berikutnya menjadi dua kali lipat."
  },
  State_120320_Name = {
    Text = "Ambang Takdir"
  },
  State_120321_Desc = {
    Text = "Setiap stack memberikan Pengorbanan sebesar 1% kerusakan tambahan saat menerima Active DMG atau Kerusakan tentakel, dihapus saat giliran berakhir, batas maksimal 75 stack."
  },
  State_120321_Name = {
    Text = "<DwmofeiKeywords:ritual kelahiran>"
  },
  State_120322_Desc = {
    Text = "Satu-satunya di tim: Batas kartu di tangan +2, tidak dapat digabungkan dengan batas kartu yang diberikan oleh Roda takdir lainnya. Pengisian kunci perak pemakai, kerusakan akhir yang disebabkan oleh Muliakan, dan perisai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Saat beralih ke sikap \"Laut Tenang\", pemakai mendapatkan <WeaponEffect_Num:[StateArg2]> poin Aliemus, dengan cooldown 3 giliran. Saat beralih ke sikap \"Gelombang Marah\", memberikan <WeaponEffect_Num:[StateArg3]> lapisan<DwmofeiKeywords:Upacara Kelahiran> kepada semua musuh, dengan cooldown 3 giliran."
  },
  State_120322_WeaponDesc = {
    Text = "Batas kartu di tangan +2, tidak dapat ditumpuk dengan batas kartu di tangan yang diberikan oleh roda takdir lainnya. Kerusakan akhir yang dihasilkan oleh pemakai dari pengisian kunci perak dan Muliakan meningkat sebesar <WeaponEffect_Num:[StateArg1]>. Saat beralih ke postur \"Laut Tenang\", pemakai mendapatkan <WeaponEffect_Num:[StateArg2]> poin Aliemus, dengan waktu cooldown 3 ronde. Saat beralih ke postur \"Gelombang Kemarahan\", tambahkan <WeaponEffect_Num:[StateArg3]> lapisan <DwmofeiKeywords:Upacara Kelahiran> kepada semua musuh, dengan waktu cooldown 3 ronde."
  },
  State_120324_Desc = {
    Text = "Saat menerima Active DMG atau kerusakan tentakel, tambahkan Pengorbanan senilai [Layer]% dari kerusakan, dihapus saat giliran berakhir, maksimal ditumpuk hingga 75 stacks."
  },
  State_120324_Name = {
    Text = "Upacara Kelahiran"
  },
  State_120351_Desc = {
    Text = "[Layer] Dapat beralih kembali ke\"Ranah dewa·lautan tenang\"setelah giliran."
  },
  State_120351_Name = {
    Text = "Ranah Dewa·lautan tenang mendingin"
  },
  State_120354_Desc = {
    Text = "[Layer] Dapat beralih kembali ke\"Ranah dewa·ombak bergelora\"setelah giliran."
  },
  State_120354_Name = {
    Text = "Ranah Dewa·ombak bergelora mendingin"
  },
  State_120357_Name = {Text = "Tentacle"},
  State_120362_Desc = {
    Text = "Ketika menerima kerusakan dari sumber selain <SacrificeKeyWord:Pengorbanan>, dapatkan 50% dari kerusakan tersebut sebagai <SacrificeKeyWord:Pengorbanan>."
  },
  State_120362_Name = {
    Text = "Manajemen pengorbanan monster umum"
  },
  State_120363_Desc = {
    Text = "Setelah akhir giliran, terima kerusakan sebesar [Layer] poin dan kurangi 50% jumlah stack dari <SacrificeKeyWord:Pengorbanan>."
  },
  State_120363_Name = {
    Text = "<BlueKeyWord:Pengorbanan>"
  },
  State_120364_Desc = {
    Text = "Setelah diri sendiri mati, memanggil \"Pelaut dekat\"."
  },
  State_120364_Name = {
    Text = "Keyakinan abadi"
  },
  State_120401_Desc = {
    Text = "Kartu ini memiliki arithmetica cost -[StateArg5], setelah dimainkan, ambil [StateArg4] kartu."
  },
  State_120401_Name = {
    Text = "<OrangeQuality:lencana mythag>"
  },
  State_120450_Name = {
    Text = "Cumi-cumi Cincin Biru mencatat nyawa pemain"
  },
  State_120462_Desc = {
    Text = "Tetap tersimpan di dalam dek setelah pertempuran berakhir, tetapi akan dihapus secara permanen setelah dimainkan atau dikonsumsi."
  },
  State_120462_Name = {
    Text = "<DestructionKeywords:memusnahkan>"
  },
  State_120900_Name = {
    Text = "Siapkan pemanggilan \"Kelahiran Lemuria\" penghitungan"
  },
  State_120907_Desc = {
    Text = "Jika serangan tentakel diblokir, berikan <IntoxicationIconKeywords:racun> layer [DescArg1]."
  },
  State_120907_Name = {Text = "Arus gelap"},
  State_120908_Desc = {
    Text = "Jika serangan tentakel diblokir, berikan <IntoxicationIconKeywords:racun> layer dalam jumlah yang sama."
  },
  State_120908_Name = {Text = "Arus gelap"},
  State_120910_Desc = {
    Text = "Kartu ini memiliki arithmetica cost +[StateArg5], setelah dimainkan, ambil [StateArg4] kartu."
  },
  State_120910_Name = {
    Text = "<OrangeQuality:lencana mythag>"
  },
  State_120924_Desc = {
    Text = "Saat ronde berikutnya dimulai, dapatkan penguatan."
  },
  State_120924_Name = {
    Text = "Penundaan penguata"
  },
  State_120929_Desc = {
    Text = "Kartu memperoleh retensi, tetapi setelah dimainkan akan menghilangkan pencemaran dan memanggil 1 \"aequor reproduktor\". Jika tidak ada tempat untuk memanggil, akan mendapatkan 1 lapisan \"persiapan memanggil: aequor reproduktor\"."
  },
  State_120929_Name = {
    Text = "<SeastriderCurse:Kutukan Pelaut>"
  },
  State_120930_Desc = {
    Text = "Jika ada posisi kosong, maka setelah bertindak kehilangan 1 layer, memanggil 1 \"Pembentuk Laut Dalam\"."
  },
  State_120930_Name = {
    Text = "Kontrak Saling Bantu: Gumpalan Laut Dalam"
  },
  State_120934_Desc = {
    Text = "Setiap kali menerima kerusakan kritikal, dapatkan 3% <Baojidikang:Resistansi Kritikal Sementara>. Di awal setiap giliran, tambahkan \"<SeastriderCurse:Kutukan Pengarung Laut>\" ke 2 kartu."
  },
  State_120934_Name = {
    Text = "Upacara Pengorbanan Laut Dalam"
  },
  State_120941_Desc = {
    Text = "Akan meningkatkan kemampuan musuh. Kehilangan satu lapisan setiap kali menerima kerusakan."
  },
  State_120941_Name = {
    Text = "Sumpah Darah"
  },
  State_121006_Desc = {
    Text = "Hanya untuk tim: Kerusakan akhir yang dihasilkan oleh pemakai pada pengisian Kunci Perak dan Pembantaian, dan perisai meningkat <WeaponEffect_Num:[StateArg1]%>."
  },
  State_121006_WeaponDesc = {
    Text = "Kerusakan akhir yang ditimbulkan oleh pemakai yang mengisi kunci perak dan melepaskan aliyemus meningkat sebesar <WeaponEffect_Num:[StateArg1]%.>"
  },
  State_121014_Name = {
    Text = "Perlindungan bayi suci"
  },
  State_121015_Desc = {
    Text = "Saat putaran mulai, perisai tidak akan dibersihkan. Ketika memiliki perisai, memiliki 50 lapisan <ReinforcePVEKeywords:fortress>, saat perisai dihancurkan, <ReinforcePVEKeywords:fortress> akan dihapus."
  },
  State_121015_Name = {
    Text = "Perlindungan bayi suci"
  },
  State_121151_Desc = {
    Text = "Kartu memperoleh retensi, tetapi setelah dimainkan akan menghilangkan pencemaran dan memanggil 1 \"aequor reproduktor\". Jika tidak ada tempat untuk memanggil, akan mendapatkan 1 lapisan \"persiapan memanggil: aequor reproduktor\"."
  },
  State_121151_Name = {
    Text = "<SeastriderCurse:Kutukan Pelaut>"
  },
  State_121210_Name = {
    Text = "Beri semua musuh efek menakjubkan negatif <PVPWonderfulEffectKeywords:marvelous effect>, berlaku 2 kali"
  },
  State_121211_Name = {
    Text = "Ambil 2 Kartu, dapatkan 2 arithmetica"
  },
  State_121212_Name = {
    Text = "Beri semua teman efek menakjubkan positif <PVPWonderfulEffectKeywords:marvelous effect>, berlaku 2 kali"
  },
  State_121213_Desc = {
    Text = "Kebal terhadap semua kerusakan."
  },
  State_121213_Name = {
    Text = "Kebal terhadap semua kerusakan."
  },
  State_121231_Desc = {
    Text = "Setiap lapisan meningkatkan efek \"Putri Tipuan\"yang diterapkan oleh \"Upacara Kelahiran\"sebanyak 20%, maksimum dapat bertumpuk hingga 5 lapisan. Setelah mencapai 5 lapisan, jumlah kerusakan yang diberikan oleh \"Putri Tipuan\"akan berlipat ganda."
  },
  State_121231_Name = {
    Text = "<MingqiKeywords: Kontrak Hidup>"
  },
  State_121365_Desc = {
    Text = "Menanggung tambahan [Layer]% kerusakan tentakel."
  },
  State_121377_Name = {
    Text = "<RetainIconKeywords: Perubahan>:Setiap awal giliran, dapatkan 500 poin keyflare"
  },
  State_121378_Name = {
    Text = "<RetainIconKeywords: Perubahan>:Semua penyembuhan hp dan perisai dari awakener meningkat sebesar 40%"
  },
  State_121380_Name = {
    Text = "<RetainIconKeywords: Perubahan>:Semua awakener menimbulkan kenaikan 50% pada aliemus"
  },
  State_121719_Name = {
    Text = "<RippleKeywords:Gelombang Efek>:Mengambil 1 kartu, mendapatkan [DescArg1] poin <PowerIconKeywords:kekuatan> sementara"
  },
  State_121734_Desc = {
    Text = "Setiap kali memainkan 1 Kartu perintah, buang 1 Kartu dengan konsumsi Aritmetika terendah dari Pembangun ini."
  },
  State_121734_Name = {
    Text = "Aliran Kegilaan"
  },
  State_121735_Desc = {
    Text = "Konsumsi aritmetika semua kartu instruksi meningkat 1. Setiap 3 giliran, pada akhir giliran, menempatkan 1 kartu “Batu yang perlahan mengeras” ke tangan"
  },
  State_121735_Name = {
    Text = "Aliran Ratapan"
  },
  State_121736_Desc = {
    Text = "Pada akhir giliran, pulihkan 10% dari kesehatan yang hilang, hilangkan kondisi negatif diri sendiri dan kondisi positif pemain"
  },
  State_121736_Name = {
    Text = "Arus Kehadiran"
  },
  State_121737_Desc = {
    Text = "Pada saat pertempuran dimulai, dapatkan 15 lapisan \"Penghalang Sementara\". Pada akhir ronde, dapatkan 15 lapisan \"Penghalang Sementara\", dan tambahkan \"Pembubaran Sementara\" pada 10 kartu acak."
  },
  State_121737_Name = {
    Text = "Arus Menyegarkan"
  },
  State_121738_Desc = {
    Text = "Efek kekuatan yang diberikan oleh Pembangun berkurang sebesar 75%. Setiap kali kehilangan hidup, mendapatkan [DescArg1] poin Perisai dan 1 lapisan Diperkuat sementara."
  },
  State_121738_Name = {
    Text = "Aliran Kepercayaan Jahat"
  },
  State_121739_Desc = {
    Text = "Meningkatkan batas maksimum Aliemus semua Pembangun sebesar 50%. Pada akhir setiap putaran, kurangi 10 poin Aliemus dari semua Pembangun dan pulihkan 3% Kesehatan maksimum diri sendiri."
  },
  State_121739_Name = {
    Text = "Aliran Ketakutan"
  },
  State_121740_Desc = {
    Text = "Saat pertarungan dimulai dan setiap akhir ronde, dapatkan 2 lapisan <ResentChainsKeywords:Rantai Kebencian> Sementara."
  },
  State_121740_Name = {
    Text = "Aliran Misterius"
  },
  State_121797_Desc = {
    Text = "Semua kerusakan, pemulihan, dan efek perisai yang diberikan berkurang 10%, maks 2 lapis, tidak dapat dihilangkan. Setelah pemberi terakhir Mabuk Gila mati, semua Mabuk Gila pada target akan dihapus."
  },
  State_121797_Name = {
    Text = "<PVPLostSoulKeyWords:Mabuk>"
  },
  State_121798_Desc = {
    Text = [[
Kerusakan yang diberikan, penyembuhan, dan efek Perisai berkurang sebesar [DescArg1]%, tidak dapat diusir. Maksimal 2 stack.
Dihapus setelah Bunuh <StatusApplier:>.]]
  },
  State_121798_Name = {Text = "Mabuk"},
  State_121799_Name = {
    Text = "Kartu Dukungan Lemuria Bab Empat"
  },
  State_121850_Desc = {
    Text = "Kerusakan tentakel berkurang sebesar 80%"
  },
  State_121850_Name = {
    Text = "Goliath: Dukungan"
  },
  State_121863_Name = {
    Text = "<RippleKeywords:Gema>: Ambil 2 kartu"
  },
  State_121878_Name = {
    Text = "Pemilihan Pertama Cerita Kutukan Terbalik"
  },
  State_122428_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_122428_Name = {Text = "Not Roused"},
  State_122431_Desc = {
    Text = "Mouchette menyebabkan kerusakan yang tidak terblokir, memperoleh 2 lapis <Monster_Fervor:Kegilaan Sementara>."
  },
  State_122431_Name = {
    Text = "Jejak Kabut"
  },
  State_122441_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat dilengkapi, mendapatkan 3 lapisan <PVPReciprocalKeywords:Hitung Mundur>."
  },
  State_122441_Name = {
    Text = "Momen Hitung Mundur"
  },
  State_122442_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat dipasang, dapatkan <Block:[Block:StateArg1]> perisai dan <Energy:[Energy:StateArg1]> Aliemus. Pada akhir ronde, roda ini secara otomatis dilepas dan meningkatkan Aliemus dan perisai yang didapat saat memasang \"Keceriaan di Dalam Kotak\" sebesar [StateArg2]."
  },
  State_122442_Name = {
    Text = "Keceriaan dalam Kotak"
  },
  State_122443_Desc = {
    Text = "Pada awal giliran, jumlah lapisan - 1. Setelah lapisan habis, hilangkan status negatif pada diri sendiri dan dapatkan 100 Aliemus, kemudian dapatkan kembali 3 lapisan Countdown. Mengganti Roda takdir akan menghilangkan status Countdown."
  },
  State_122443_Name = {
    Text = "<PVPFlowerKeywords:Momen Hitung Mundur>"
  },
  State_122596_Desc = {
    Text = "Tidak dapat memainkan kartu, tidak dapat melepaskan Muliakan."
  },
  State_122596_Name = {
    Text = "<Seal1:Sealed>"
  },
  State_122636_Desc = {
    Text = "Kerusakan, penyembuhan, dan perisai dari \"skill\" yang dimainkan pertama kali di setiap ronde meningkat sebesar [StateArg1]% ."
  },
  State_122636_Name = {
    Text = "Peniti Ruby"
  },
  State_122650_Desc = {
    Text = "Membuat <OrangeQuality:Sarung Tangan Sihir> menambahkan kartu ini."
  },
  State_122650_Name = {Text = "Kartu Aneh"},
  State_122654_Name = {
    Text = "Setiap kali ronde dimulai dan setelah aksi berakhir, akan berusaha mereset dek pemain yang kosong, jika tidak kosong maka tidak akan direset.__\"Hanya untuk pengembangan\""
  },
  State_122706_Name = {
    Text = "<CardKeyWord:Berkumpul kembali>"
  },
  State_122707_Desc = {
    Text = "Dianggap sebagai \"Skill\" terakhir yang di-play dalam giliran ini, Arithmetica Cost -2, ditempatkan di bagian atas tumpukan Menggambar kedua."
  },
  State_122707_Name = {
    Text = "<CardKeyWord:Berkumpul kembali>"
  },
  State_123109_Desc = {
    Text = "Unik untuk tim: Saat pertama kali membeli \"Tanda\" di \"D-marka\", atau saat pertama kali membeli barang diskon di \"Sisa Abu\", peluang untuk menghabiskan Segil hitam yang diperlukan menjadi <WeaponEffect_Num:[StateArg1]%> adalah 0, dapat aktif maksimal 1 kali per eksplorasi."
  },
  State_123109_WeaponDesc = {
    Text = "Dalam \"D-marka\", saat pertama kali membeli \"Orison\", atau saat pertama kali membeli barang diskon di \"Sisa Abu\", peluang untuk mengurangi Segil hitam yang diperlukan menjadi <WeaponEffect_Num:[StateArg1]%> adalah 0, dan dapat berlaku maksimum 1 kali per eksplorasi."
  },
  State_123177_Desc = {
    Text = "Bersihkan saat awal giliran. Setelah mencapai 10 lapisan, setelah kartu dimainkan berikutnya, Mouchette segera melakukan aksi, menghapus\"Kegilaan Sementara\"dan menambahkan niat\"Ledakan Manusia\"."
  },
  State_123177_Name = {
    Text = "Kegilaan Sementara"
  },
  State_123178_Desc = {
    Text = "<Guaiwusiwangdikang: Ketahanan> efek penyembuhan HP ditingkatkan menjadi 5 kali. Setiap kali musuh menggunakan 1 kartu, mereka mendapatkan 1 lapisan <Monster_Fervor: Kegilaan Sementara>."
  },
  State_123178_Name = {
    Text = "Moods saat bangun tidur"
  },
  State_123243_Desc = {
    Text = "Saat mengalahkan musuh, hapus semua lapis dan dapatkan Kegilaan dalam jumlah yang sama."
  },
  State_123243_Name = {Text = "Pusaran"},
  State_123246_Desc = {
    Text = "Saat mengalahkan musuh, hapus semua lapis dan dapatkan Kegilaan dalam jumlah yang sama."
  },
  State_123246_Name = {
    Text = "<PVPWaterPowerKeyWords:Pusaran>"
  },
  State_123294_Desc = {
    Text = "Ronde ini telah menarik [DescArg1] kartu melalui \"Pukulan\"."
  },
  State_123294_Name = {
    Text = "Pembantaian"
  },
  State_123507_Desc = {
    Text = "Tim Unik: Setelah eksplorasi dimulai, masukkan 1 kartu\"Hitung Mundur: 5\"ke dalam dek: setelah dimainkan, ambil 1 kartu, dan masukkan\"Hitung Mundur\"berikutnya ke dalam tumpukan kartu buang.\"<DestructionKeywords:Destroy>\".\"Hitung Mundur: 0\": Ambil 3 kartu, dapatkan 3 poin Aritmetika, dan memiliki probabilitas <WeaponEffect_Num:[StateArg1]%> untuk mengocok\"Hitung Mundur: 5\"ke dalam tumpukan kartu buang. Retain.\"<DestructionKeywords:Destroy>\"."
  },
  State_123507_WeaponDesc = {
    Text = "Setelah eksplorasi dimulai, tambahkan 1 kartu\"Hitung Mundur: 5\"ke dalam dek: setelah dimainkan, ambil 1 kartu, dan masukkan kartu\"Hitung Mundur\"selanjutnya ke dalam tumpukan kartu buang.\"<DestructionKeywords:Destroy>\".\"Hitung Mundur: 0\": ambil 3 kartu, dapatkan 3 poin Aritmetika, dan memiliki probabilitas <WeaponEffect_Num:[StateArg1]%> untuk mengocok\"Hitung Mundur: 5\"ke dalam tumpukan kartu buang. Retain.\"<DestructionKeywords:Destroy>\"."
  },
  State_123520_Desc = {
    Text = "Satu-satunya di tim: Setelah melepaskan Geng untuk pertama kalinya dalam satu ronde, ada kemungkinan <WeaponEffect_Num:[StateArg1]%> untuk menarik 1 \"pukulan\" pemakai."
  },
  State_123520_WeaponDesc = {
    Text = "Setiap kali melepaskan Geng untuk pertama kalinya dalam satu ronde, ada kemungkinan <WeaponEffect_Num:[StateArg1]>% untuk menarik 1 kartu \"Serangan\" pemakai."
  },
  State_123521_Desc = {
    Text = "Satu-satunya Tim: Kerusakan dasar dari Exalt dan Pengejaran pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah memainkan kartu \"Pukulan\" dari Awakener mana pun pada ronde ini, kerusakan \"Pukulan\" pemakai meningkat sementara sebesar <WeaponEffect_Num:[StateArg2]%> dari ATK pemakai, dan dapat aktif maksimal 8 kali per ronde."
  },
  State_123521_WeaponDesc = {
    Text = "Kerusakan dasar dari Exalt dan Pengejaran pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah memainkan kartu \"Pukulan\" dari Awakener mana pun pada ronde ini, kerusakan \"Pukulan\" pemakai meningkat sementara sebesar <WeaponEffect_Num:[DescArg2]>, dan dapat aktif maksimal 8 kali per ronde."
  },
  State_123810_Desc = {
    Text = "Ganti niat musuh saat ini dengan \"Tidak bisa bergerak\"."
  },
  State_123810_Name = {
    Text = "<HunmiKeywords:Pingsan>"
  },
  State_123812_Desc = {
    Text = "Pada akhir giliran, konsumsi aritmetika berkurang."
  },
  State_123812_Name = {
    Text = "<PrepareKeywords:prepare>"
  },
  State_123994_Desc = {
    Text = "Tidak dapat melakukan tindakan apa pun."
  },
  State_123994_Name = {
    Text = "Tidur mewah"
  },
  State_124010_Desc = {
    Text = "Saat giliran berikutnya dimulai, dapatkan [Layer] Aritmetika."
  },
  State_124010_Name = {
    Text = "Negara Tertunda Aritmetika"
  },
  State_124024_Desc = {
    Text = "Pada giliran ini, telah dimainkan [Layer] kartu serangan, memicu [DescArg1] kali \"Pertemuan Dramatis\"."
  },
  State_124024_Name = {
    Text = "Pertemuan Dramatis"
  },
  State_124034_Desc = {
    Text = "Semua kerusakan \"Pukulan\" yang diberikan oleh Pembangun meningkat sebesar [StateArg1], berlangsung selama [Layer] putaran."
  },
  State_124034_Name = {
    Text = "Bercahaya☆Putaran Angin"
  },
  State_124037_Desc = {
    Text = "Jumlah serangan Moxia +1, semua Pembangun\"Pukulan\"kerusakan meningkat sebesar [StateArg1], berlangsung selama [Layer] putaran."
  },
  State_124037_Name = {
    Text = "Bercahaya☆Putaran Angin"
  },
  State_124107_Desc = {
    Text = "Setelah mati, \"Benih Bintang\" kebal terhadap semua Kerusakan dan terbangun, Max HP menjadi dua kali lipat dan mendapatkan Max HP setara dengan Sisa Nyawa. Setelah terbangun, hilangkan semua negara negatif."
  },
  State_124107_Name = {Text = "Not Roused"},
  State_124108_Name = {
    Text = "Penghitung Suara di Luar Dunia"
  },
  State_124109_Desc = {
    Text = "<RetaliateIconKeywords:Counter> yang diperoleh sendiri mendapatkan bonus tambahan 5% <PowerIconKeywords:Kekuatan>. Setelah kehilangan [DescArg1] poin hidup dalam satu ronde, tukar posisi dengan \"Penyanyi\""
  },
  State_124109_Name = {
    Text = "Cradle Sekunder"
  },
  State_124111_Desc = {
    Text = "Ketahanan Kematian memulihkan hidup meningkat menjadi 25%. Setiap kali musuh memainkan 1 kartu perintah, sementara waktu <TouquKeywords:Mencuri> [DescArg1] poin <PowerIconKeywords:Kekuatan>."
  },
  State_124111_Name = {
    Text = "Warna yang menyilaukan"
  },
  State_124112_Desc = {
    Text = "Setelah \"Penyanyi\" mati, kebal terhadap semua kerusakan dan terbangun, kesehatan maksimum menjadi dua kali lipat dan mendapatkan kesehatan maksimum yang setara dengan sisa kehidupan."
  },
  State_124112_Name = {Text = "Not Roused"},
  State_124113_Desc = {
    Text = "Pihak lawan tidak akan membuang kartu di tangan pada akhir giliran. Pada akhir giliran, terapkan secara berurutan 2 lapisan <FragileIconKeywords:Rapuh>, <WeaknessIconKeywords:Kelemahan>, <HeavyInjuryKeywords:Cedera Berat>, dan <VulnerabilityIconKeywords:Rentan>."
  },
  State_124113_Name = {
    Text = "Suara di Luar Dunia"
  },
  State_124115_Desc = {
    Text = "<FragileIconKeywords:Fragile>, <HeavyInjuryKeywords:Blighten>, dan <WeaknessIconKeywords:Weakness> yang diberikan diperdalam menjadi 50%. Setelah play [DescArg1] kartu <SlowIconKeywords:Stagnation> lagi, tukar posisi dengan \"Benih Bintang\"."
  },
  State_124115_Name = {
    Text = "Perjalanan Planet"
  },
  State_124121_Name = {
    Text = "Perjalanan Planet Penghitungan"
  },
  State_124122_Name = {
    Text = "Pemantauan Pemain Perjalanan Planet"
  },
  State_124190_Desc = {
    Text = "<RetaliateIconKeywords:Counter> yang diperoleh sendiri menikmati tambahan 5% <PowerIconKeywords:Kekuatan>."
  },
  State_124190_Name = {
    Text = "Cradle Sekunder"
  },
  State_124193_Name = {
    Text = "Pemulihan ketahanan kematian untuk meningkatkan kehidupan menjadi 25%."
  },
  State_124198_Desc = {
    Text = "<FragileIconKeywords:Fragile>, <HeavyInjuryKeywords:Blighten>, dan <WeaknessIconKeywords:Weakness> yang diberikan diperdalam menjadi 50%."
  },
  State_124198_Name = {
    Text = "Perjalanan Planet"
  },
  State_124277_Desc = {
    Text = "Visualisasi nilai tengah dari proses eksekusi."
  },
  State_124277_Name = {
    Text = "Cetak Nilai 2"
  },
  State_124278_Desc = {
    Text = "Visualisasi nilai tengah dari proses eksekusi."
  },
  State_124278_Name = {
    Text = "Cetak Nilai 4"
  },
  State_124279_Desc = {
    Text = "Visualisasi nilai tengah dari proses eksekusi."
  },
  State_124279_Name = {
    Text = "Cetak Nilai 5"
  },
  State_124280_Desc = {
    Text = "Visualisasi nilai tengah dari proses eksekusi."
  },
  State_124280_Name = {
    Text = "Cetak Nilai 1"
  },
  State_124282_Desc = {
    Text = "Visualisasi nilai tengah dari proses eksekusi."
  },
  State_124282_Name = {
    Text = "Cetak Nilai 7"
  },
  State_124283_Desc = {
    Text = "Visualisasi nilai tengah dari proses eksekusi."
  },
  State_124283_Name = {
    Text = "Cetak Nilai 8"
  },
  State_124284_Desc = {
    Text = "Visualisasi nilai tengah dari proses eksekusi."
  },
  State_124284_Name = {
    Text = "Cetak Nilai 9"
  },
  State_124285_Desc = {
    Text = "Visualisasi nilai tengah dari proses eksekusi."
  },
  State_124285_Name = {
    Text = "Cetak Nilai 10"
  },
  State_124286_Desc = {
    Text = "Visualisasi nilai tengah dari proses eksekusi."
  },
  State_124286_Name = {
    Text = "Cetak Nilai 6"
  },
  State_124287_Desc = {
    Text = "Visualisasi nilai tengah dari proses eksekusi."
  },
  State_124287_Name = {
    Text = "Cetak Nilai 3"
  },
  State_124736_Desc = {
    Text = "Verifikasi apakah parameter 3 pada antarmuka BEAttachPostAction telah difilter atau memicu pemicu yang sesuai dengan benar."
  },
  State_124736_Name = {
    Text = "Pemantauan Pengujian 1"
  },
  State_124747_Desc = {
    Text = "Verifikasi apakah parameter 3 pada antarmuka BEAttachPostAction telah difilter atau memicu pemicu yang sesuai dengan benar."
  },
  State_124747_Name = {
    Text = "Pemantauan Pengujian 2"
  },
  State_124748_Desc = {
    Text = "Saat musuh memainkan kartu <BurningKeywords:Terbakar>, membuat dirinya mendapatkan 1 lapisan <MonsterExFlameKeywords:Ledakan Api>, tetapi sementara mengurangi [DescArg1] <PowerIconKeywords:Kekuatan>."
  },
  State_124748_Name = {
    Text = "Nyala Tak Padam"
  },
  State_124752_Desc = {
    Text = "Verifikasi apakah parameter 3 pada antarmuka BEAttachPostAction telah difilter atau memicu pemicu yang sesuai dengan benar."
  },
  State_124752_Name = {
    Text = "Pemantauan Pengujian 3"
  },
  State_124753_Desc = {
    Text = "Verifikasi apakah parameter 3 pada antarmuka BEAttachPostAction telah difilter atau memicu pemicu yang sesuai dengan benar."
  },
  State_124753_Name = {
    Text = "Pemantauan Pengujian 4"
  },
  State_124754_Desc = {
    Text = "Verifikasi apakah parameter 3 pada antarmuka BEAttachPostAction telah difilter atau memicu pemicu yang sesuai dengan benar."
  },
  State_124754_Name = {
    Text = "Pemantauan Pengujian 5"
  },
  State_124765_Desc = {
    Text = "Crit. Rate meningkat sebesar [Layer]%."
  },
  State_124765_Name = {Text = "Crit. Rate"},
  State_124766_Desc = {
    Text = "Crit. Rate meningkat sebesar [Layer]% dalam pertempuran ini."
  },
  State_124766_Name = {Text = "Crit. Rate"},
  State_124766_WeaponDesc = {
    Text = "Crit. Rate meningkat sebesar [Layer]% dalam pertempuran ini."
  },
  State_124767_Desc = {
    Text = "Crit. DMG meningkat sebesar [Layer]%."
  },
  State_124767_Name = {Text = "Crit. DMG"},
  State_124811_Desc = {
    Text = "Verifikasi apakah parameter 3 pada antarmuka BEAttachPostAction telah difilter atau memicu pemicu yang sesuai dengan benar."
  },
  State_124811_Name = {
    Text = "Pemantauan Pengujian 8"
  },
  State_124812_Desc = {
    Text = "Verifikasi apakah parameter 3 pada antarmuka BEAttachPostAction telah difilter atau memicu pemicu yang sesuai dengan benar."
  },
  State_124812_Name = {
    Text = "Pemantauan Pengujian 7"
  },
  State_124813_Desc = {
    Text = "Verifikasi apakah parameter 3 pada antarmuka BEAttachPostAction telah difilter atau memicu pemicu yang sesuai dengan benar."
  },
  State_124813_Name = {
    Text = "Pemantauan Pengujian 6"
  },
  State_124826_Desc = {
    Text = "Verifikasi apakah parameter 3 pada antarmuka BEAttachPostAction telah difilter atau memicu pemicu yang sesuai dengan benar."
  },
  State_124826_Name = {
    Text = "Pemantauan Pengujian 9"
  },
  State_124843_Desc = {
    Text = "Verifikasi pemantauan pemicu BSTAfterAttachPostAction dan BSTAfterDoActiveDamage.AttachPostAction"
  },
  State_124843_Name = {
    Text = "Pemantauan Pengujian 9"
  },
  State_124886_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:Setelah memainkan kartu keterampilan pemakai, gambar [StateArg1] kartu, prioritaskan menarik kartu dari Awakener lainnya, berlaku maksimal 1 kali per giliran."
  },
  State_124886_Name = {
    Text = "Roda Benang Takdir"
  },
  State_124887_Desc = {
    Text = "Jumlah Kerusakan \"Tekstil\" Awakener ini meningkat sebesar [Layer]."
  },
  State_124887_Name = {Text = "Tekstil"},
  State_124888_Desc = {
    Text = "Setiap kali Kartu di-play, berubah menjadi \"Skill\" acak yang ada di tangan musuh, dan membuat Arithmetica Cost-nya -2."
  },
  State_124888_Name = {
    Text = "<CardKeyWord:Ramalan>"
  },
  State_124890_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setelah \"Exalt\", membuat\"Keterampilan\"yang dimainkan di bawah [StateArg1] efektif 2 kali."
  },
  State_124890_Name = {
    Text = "Jaringan Penenunan Abadi"
  },
  State_124892_Name = {
    Text = "<CardKeyWord:Ramalan>"
  },
  State_124916_Desc = {
    Text = "Menghilangkan semua lapis di akhir giliran dan memberikan [DescArg1] Kerusakan Murni, tidak dapat dihilangkan."
  },
  State_124916_Name = {
    Text = "Pertanda Takdir"
  },
  State_124917_Desc = {
    Text = "Pada akhir ronde, hapus semua lapisan dan berikan Kerusakan Murni, tidak dapat dihilangkan."
  },
  State_124917_Name = {
    Text = "<PVPDestinedDeathKeyWords:Pertanda Takdir>"
  },
  State_124992_Desc = {
    Text = "[DescArg1] Kartu \"Skill\" berikutnya dimainkan 2 kali."
  },
  State_124992_Name = {
    Text = "Tembakan Ganda"
  },
  State_124993_Desc = {
    Text = "Kerusakan aktif fatal yang diberikan dan diterima diubah menjadi pemberian <PVPDestinedDeathKeyWords:Pertanda Takdir> dalam jumlah setara, tidak dapat dihilangkan."
  },
  State_124993_Name = {
    Text = "Moira, Atas Kuasaku"
  },
  State_124997_Desc = {
    Text = "Active DMG fatal yang diberikan dan diterima diubah menjadi pemberian <PVPDestinedDeathKeyWords:Pertanda Takdir> dalam jumlah yang setara. Tidak dapat diusir."
  },
  State_124997_Name = {
    Text = "<PVPEternalDimensionKeyWords:Moira, Atas Kuasaku>"
  },
  State_125002_Name = {
    Text = "Negara@Pemantauan Nilai Perisai Setelah Fase Buang Kartu Pemain Umum"
  },
  State_125003_Name = {
    Text = "Nilai Perisai"
  },
  State_125004_Name = {
    Text = "Negara@Umum menerapkan jumlah Perisai pemain"
  },
  State_125472_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setelah \"Exalt\", berikan [StateArg1] tumpukan <PVPLostSoulKeyWords:Mabuk> kepada musuh dengan <HPAndShieldMax:HP dan Perisai tertinggi>."
  },
  State_125472_Name = {
    Text = "Umpan Melati"
  },
  State_125486_Desc = {
    Text = "<PVPWeaponKeywords:Roda Takdir>: Setelah \"Fury Burst\" rekan lain, mengurangi konsumsi daya komputasi semua \"Skill\" pemilik peralatan di tangan sebesar [StateArg1]."
  },
  State_125486_Name = {
    Text = "Sia-sia mengerutkan alis"
  },
  State_125925_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_125925_Name = {Text = "Not Roused"},
  State_125926_Name = {
    Text = "Negara@Monster Tawil Pemantauan Niat Pergantian Pemain"
  },
  State_125927_Desc = {
    Text = "Setelah memainkan [DescArg1] Kartu perintah, ganti niat menjadi\"Sayap Keenam\"."
  },
  State_125927_Name = {
    Text = "Sayap Keempat"
  },
  State_125928_Desc = {
    Text = "Setelah memainkan Kartu perintah, segel Aliemus Muliakan dari Pembangun yang sesuai dan semua Kartu perintah selama 2 ronde."
  },
  State_125928_Name = {
    Text = "Sayap yang Menerobos Waktu"
  },
  State_125929_Desc = {
    Text = "Setelah menerima [DescArg1] poin kerusakan dalam satu ronde, mendapatkan 70 lapisan sementara <ReinforceColour:Diperkuat> dan 1 lapisan <ResentChainsKeywords:Rantai Kebencian>."
  },
  State_125929_Name = {
    Text = "Kehadiran yang tidak ada"
  },
  State_125933_Desc = {
    Text = "Setelah memainkan [DescArg1] Kartu perintah, ganti niat menjadi\"Sayap Keempat\"."
  },
  State_125933_Name = {
    Text = "Sayap Kembar"
  },
  State_125934_Desc = {
    Text = "Saat mengeluarkan Arithmetica, Energi-s yang diperoleh berkurang 50%. Setelah Tawil menyebabkan kerusakan yang tidak terhalang, masukkan 1 kartu \"<DerivativeCardKeywords_131:Paradox Reinkarnasi yang Sejati>\" ke tangan."
  },
  State_125934_Name = {
    Text = "Melalui Pintu Kunci Perak"
  },
  State_125935_Name = {Text = "Diam"},
  State_125935_WeaponDesc = {
    Text = "Mengakibatkan Kelemahan pada diri sendiri selama 1 ronde saat ditarik. Setelah digunakan, semua musuh akan mengalami Kelemahan selama 1 ronde. Tidak dapat dijual."
  },
  State_125937_Desc = {
    Text = "Setelah memainkan Kartu perintah, segel Aliemus Muliakan dari Pembangun yang sesuai dan semua Kartu perintah selama 2 ronde."
  },
  State_125937_Name = {
    Text = "Sayap yang Menerobos Waktu"
  },
  State_125964_Desc = {
    Text = "Saat mengonsumsi daya komputasi, energi Kunci Perak yang diperoleh berkurang 50%. Setelah Tavi memberikan damage yang tidak diblokir, masukkan 1 kartu \"<DerivativeCardKeywords_131:Sejati · Paradoks Reinkarnasi>\" ke tangan."
  },
  State_125964_Name = {
    Text = "Melalui Pintu Kunci Perak"
  },
  State_126010_Desc = {
    Text = "Tim Unik: Peningkatan Racun tetap dan Efek Racun yang diberikan oleh pemakai sebesar <WeaponEffect_Num:[StateArg1]%>, pemulihan otomatis <EmbryoFusionIconKeywords:Fusi Embrio> di alam Caro meningkat sebesar <WeaponEffect_Num:[StateArg2]%>. Setiap kali pemakai pertama kali memicu \"Resonansi\" dalam setiap putaran, Pembangun lainnya mendapatkan <WeaponEffect_Num:[StateArg3]> poin Aliemus."
  },
  State_126010_WeaponDesc = {
    Text = "Pemakai menyebabkan racun tetap dan efek racun yang dipicu meningkat <WeaponEffect_Num:[StateArg1]%>, pemulihan otomatis di realm darah dan daging untuk <EmbryoFusionIconKeywords:Embryo Fusion> meningkat <WeaponEffect_Num:[StateArg2]%.> Pemakai mendapatkan <WeaponEffect_Num:[StateArg3]> poin aliemus ketika pertama kali memicu \"resonansi\" setiap putaran."
  },
  State_126463_Name = {
    Text = "Negara@Monster Liz Pemantauan Kerusakan Cahaya yang menggoda"
  },
  State_126464_Desc = {
    Text = "Maksimal 10 lapisan, setiap lapisan membuat Liz meningkatkan kerusakan yang diberikan sebesar [DescArg1] poin."
  },
  State_126464_Name = {
    Text = "<GreenWord:Chispa Hijau>"
  },
  State_126465_Name = {
    Text = "Pemantauan Niat Monster Liz"
  },
  State_126466_Desc = {
    Text = "Pihak lawan tidak akan membuang kartu di tangan pada akhir giliran. Saat niat beralih ke Nyala Api Hijau, jika memiliki setidaknya 6 lapisan <MonsterLizVerdantSpark:Chispa Hijau>, habiskan 6 lapisan untuk meningkatkan niat menjadi\"Nyala Hijau Kematian\"yang menyebabkan <Damage:[Damage:DescArg1]> kerusakan sebanyak [AttackTimes:DescArg2] kali; jika memiliki setidaknya 3 lapisan, habiskan 3 lapisan untuk meningkatkan niat menjadi\"Flamme Hijau Terkotori\"yang menyebabkan <Damage:[Damage:DescArg3]> kerusakan sebanyak [AttackTimes:DescArg4] kali."
  },
  State_126466_Name = {
    Text = "Nyala hijau abadi"
  },
  State_126467_Desc = {
    Text = "Orang ini yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan HP dan bertarung dalam bentuk aslinya, serta memberikan kemampuan untuk menghapus status negatif untuk \"Tari Kehancuran\"."
  },
  State_126467_Name = {Text = "Not Roused"},
  State_126468_Name = {
    Text = "Negara@Manajemen Gambar Zamrud Monster Liz"
  },
  State_126469_Desc = {
    Text = "Setiap kehilangan [DescArg1] poin hidup, dapatkan [DescArg2] lapisan <MonsterLizVerdantSpark:Chispa Hijau>."
  },
  State_126469_Name = {
    Text = "Gambar Zamrud"
  },
  State_126470_Name = {
    Text = "Negara@Hitungan Petunjuk Monster Liz"
  },
  State_126479_Desc = {
    Text = "Maksimal 10 lapisan, setiap lapisan membuat Liz meningkatkan kerusakan yang diberikan."
  },
  State_126479_Name = {
    Text = "<GreenWord:Chispa Hijau>"
  },
  State_126540_Desc = {
    Text = "Xu di bawah [Layer] kali memicu\"Resonansi\", efek\"Resonansi\"dilipatgandakan."
  },
  State_126540_Name = {
    Text = "Sumpah Cinta di Bawah Kabut Malam"
  },
  State_126568_Desc = {
    Text = "Setiap kali Awakener memberikan kerusakan aktif, perintahkan 1 Tentakel untuk menyerang target dan menyebabkan [Layer]% kerusakan tentakel."
  },
  State_126568_Name = {
    Text = "Laut Mengamuk"
  },
  State_126569_Desc = {
    Text = "Setiap kali awakener menyebabkan kerusakan aktif, memerintahkan 1 serangan tentakel yang menargetkan menghasilkan 50% kerusakan tentakel."
  },
  State_126569_Name = {
    Text = "Laut Mengamuk"
  },
  State_126643_Desc = {
    Text = "Negara ini MaxLayer=1. Sumber Awakener: [DescArg1]"
  },
  State_126643_Name = {
    Text = "Batas Tingkat 1"
  },
  State_126644_Desc = {
    Text = [[
Setelah diperoleh, hapus dan tambahkan kembali status demonstrasi [Layer] lapisan. 
 Jumlah maksimum lapisan status demonstrasi adalah 1 lapisan.]]
  },
  State_126644_Name = {
    Text = "Melewati jumlah tumpukan maksimum"
  },
  State_126645_Desc = {
    Text = "Kerusakan Dasar yang diberikan oleh Ramona meningkat sebesar [DescArg1]%"
  },
  State_126645_Name = {
    Text = "Pengembangan Kepribadian"
  },
  State_126651_Desc = {
    Text = "Pendengar setelah melepaskan pengejaran telah terpenuhi [Layer] kali."
  },
  State_126651_Name = {Text = "Penghitung"},
  State_126652_Desc = {
    Text = "Setelah didapat, perintahkan musuh di barisan depan untuk menambahkan tindakan tertunda, mainkan niat mereka saat ini."
  },
  State_126652_Name = {
    Text = "Perintahkan monster untuk mengejar"
  },
  State_126653_Desc = {
    Text = "Setelah diperoleh, buat Awakener dengan posisi 1 untuk menambahkan aksi setelah, play kartu pukulannya."
  },
  State_126653_Name = {
    Text = "Perintahkan Awakener untuk mengejar"
  },
  State_126654_Desc = {
    Text = "Ketika pemantauan penunjukan dipicu, cetak 1 kali penghitungan."
  },
  State_126654_Name = {
    Text = "Pemantauan Penunjukan"
  },
  State_126655_Desc = {
    Text = "Setelah diperoleh, perintahkan Penjaga untuk menambahkan tindakan setelah, mainkan keterampilan @Keterampilan Utama@Suara Dalam Benak."
  },
  State_126655_Name = {
    Text = "Perintahkan Penjaga untuk mengejar"
  },
  State_126677_Desc = {
    Text = "Pada giliran ini, [Layer] kartu \"Pedang Pemberontak\" akan berlaku 2 kali."
  },
  State_126677_Name = {
    Text = "Nyanyian Paus Abadi"
  },
  State_126678_WeaponDesc = {
    Text = "Jumlah semua kerusakan Whale Leap +1."
  },
  State_126714_Desc = {
    Text = "Aigis yang berikutnya [Layer] kartu \"Pertahanan\" akan berlaku 3 kali."
  },
  State_126714_Name = {
    Text = "Air Mata yang Membeku"
  },
  State_126714_WeaponDesc = {
    Text = "Jumlah semua kerusakan Whale Leap +1."
  },
  State_126715_WeaponDesc = {
    Text = "Jumlah semua kerusakan Whale Leap +1."
  },
  State_126776_Desc = {
    Text = "Setiap memiliki 1 lapisan, racun tetap yang diterima meningkat sebesar 5%, kerusakan yang ditimbulkan berkurang sebesar [DescArg1]%, maksimum [DescArg2] lapisan."
  },
  State_126776_Name = {
    Text = "<WitherKeywords:Mabuk>"
  },
  State_126783_Name = {
    Text = "Sementara ditinggalkan"
  },
  State_126784_Desc = {
    Text = "Racun tetap yang diterima meningkat sebesar [DescArg1]%, kerusakan yang ditimbulkan berkurang sebesar [DescArg2]%, maksimum [DescArg3] lapisan."
  },
  State_126784_Name = {Text = "Mabuk"},
  State_126785_Desc = {
    Text = "Jika Pembangun lain telah mengumpulkan X Kartu perintah yang dimainkan, memicu efek selanjutnya setelah dimainkan. Setelah memainkan Kartu perintah sendiri atau di akhir putaran, reset penghitung Resonansi sendiri."
  },
  State_126785_Name = {
    Text = "<ResonanceKeywords:ResonansiX>"
  },
  State_126789_Desc = {
    Text = "Terapkan 2 lapisan <WitherKeywords:Mabuk> pada semua musuh."
  },
  State_126789_Name = {
    Text = "<WitherKeywords1:Janji>"
  },
  State_126790_Desc = {
    Text = "Hapus semua <WitherKeywords:Mabuk> musuh, setiap kali 1 lapisan dihapus menyebabkan <FixedDamage:Kerusakan Murni> sebesar [DescArg1]% dari Max HP target dan memicu 40% Racun."
  },
  State_126790_Name = {
    Text = "<WitherKeywords2:Merebut Jiwa>"
  },
  State_126803_Desc = {
    Text = "Kartu perintah [DescArg1] yang dimainkan berikutnya akan dikirim ke masa depan 3 ronde ke depan."
  },
  State_126803_Name = {
    Text = "Roda Pemintal Takdir"
  },
  State_126893_Name = {
    Text = "Negara@nasib Ultra Murni Identitas"
  },
  State_126895_Desc = {
    Text = "Final DMG kerusakan yang ditimbulkan kartu ini, peningkatan Kekuatan dan Kerusakan Tentakel tetap, Racun tetap, Counter tetap meningkat sebesar [DescArg1]%, efek Perisai tetap, pemulihan HP tetap, STR▼ yang ditimbulkan meningkat sebesar [DescArg2]%. Kartu yang memiliki \"Mercusuar Singularity\" tidak dapat lagi disalin ke dalam \"Ruang Ultra\"."
  },
  State_126895_Name = {
    Text = "<SingularityKeywords:Mercusuar Singularity [DescArg2]>"
  },
  State_126896_Name = {
    Text = "Negara@Cahaya Transenden Kartu mengurangi tumpukan Arithmetica Harmony"
  },
  State_126900_Name = {
    Text = "Negara@Inisialisasi Pekerjaan Ultra Nasib 2"
  },
  State_126901_Name = {
    Text = "Negara@nasib Inisialisasi Pekerjaan Ultra 1"
  },
  State_126903_Name = {
    Text = "Negara@Ruang Ultra Jarak Jauh Tanda"
  },
  State_126927_Desc = {
    Text = "Satu-satunya Tim: Peningkatan Racun tetap dan Efek Racun yang diberikan oleh pemakai sebesar <WeaponEffect_Num:[StateArg1]%>. Setiap kali pemakai pertama kali memicu \"Resonansi\" dalam setiap putaran, mereka mendapatkan <WeaponEffect_Num:[StateArg2]> poin Aliemus."
  },
  State_126927_WeaponDesc = {
    Text = "Peningkatan Racun tetap yang diberikan oleh pemakai dan pemicu efek Racun sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah pemakai memicu \"Resonansi\" untuk pertama kalinya setiap putaran, mereka mendapatkan <WeaponEffect_Num:[StateArg2]> poin Aliemus."
  },
  State_126990_Name = {
    Text = "<IntoxicationColour:Racun>"
  },
  State_127108_Desc = {
    Text = "Terapkan 5 lapisan <WitherKeywords:Mabuk> pada semua musuh."
  },
  State_127108_Name = {
    Text = "<WitherKeywords3:Janji>"
  },
  State_127109_Desc = {
    Text = "Menghapus semua <WitherKeywords:Mabuk> musuh, setiap menghapus 1 lapisan mengumpulkan 20% CON dari Crimson Furnace, menyebabkan <FixedDamage:Kerusakan Murni> sebesar [DescArg1]% dari Max HP target dan memicu 40% Racun."
  },
  State_127109_Name = {
    Text = "<WitherKeywords4:Merebut Jiwa>"
  },
  State_127176_Desc = {
    Text = "Setiap memiliki 1 lapisan, racun tetap yang diterima meningkat sebesar 5%, kerusakan yang ditimbulkan berkurang sebesar [DescArg1]%, maksimum [DescArg2] lapisan."
  },
  State_127176_Name = {
    Text = "<WitherKeywords0:Mabuk>"
  },
  State_127264_Desc = {
    Text = "Saat memainkan kartu ini, \"Sang Pengamat Waktu\"mendapatkan 1 lapisan <MonsterTimeBeacon:Loop>. Jika membuang kartu ini, \"Sang Pengamat Waktu\"kehilangan 1 lapisan <MonsterTimeBeacon:Loop>."
  },
  State_127264_Name = {
    Text = "<MonsterSightUnbound:Pandangan melampaui>"
  },
  State_127266_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_127266_Name = {Text = "Not Roused"},
  State_127267_Desc = {
    Text = "Setelah akhir ronde, dapatkan 1 lapisan <MonsterTimeBeacon:Loop>."
  },
  State_127267_Name = {
    Text = "Inversi Entropi"
  },
  State_127271_Desc = {
    Text = "Setelah melepaskan Geng, diri sendiri mendapatkan 1 lapisan <MonsterTimeBeacon:Loop>."
  },
  State_127271_Name = {
    Text = "Tawanan mobius"
  },
  State_127272_Desc = {
    Text = "Batas maksimal 3 lapis. Ketika \"Sang Pengamat Waktu\"melepaskan niat dan memiliki 3 lapis <MonsterTimeBeacon:Loop>, aktifkan efek <MonsterTimeBeacon:Loop>, kosongkan <MonsterTimeBeacon:Loop> dan hapus status negatif."
  },
  State_127272_Name = {
    Text = "<WhiteWord:Loop>"
  },
  State_127275_Desc = {
    Text = "Setiap memiliki 1 lapisan, racun tetap yang diterima meningkat sebesar 5%, kerusakan yang ditimbulkan berkurang sebesar [DescArg1]%, maksimum [DescArg2] lapisan."
  },
  State_127275_Name = {
    Text = "<WitherKeywords:Mabuk>"
  },
  State_127276_Desc = {
    Text = "Saat memainkan kartu ini, \"Sang Pengamat Waktu\"mendapatkan 1 lapisan <MonsterTimeBeacon:Loop>. Jika membuang kartu ini, \"Sang Pengamat Waktu\"kehilangan 1 lapisan <MonsterTimeBeacon:Loop>."
  },
  State_127276_Name = {
    Text = "<MonsterSightUnbound:Pandangan melampaui>"
  },
  State_127312_Desc = {
    Text = "Ketika Pengembangan Kepribadian Awakener mencapai +12, akan mengaktifkan \"Aturan Akhir\", setelah diaktifkan dapat memperoleh beberapa efek unik."
  },
  State_127312_Name = {
    Text = "<UltraPotencyKeywords:Hukum Akhir>"
  },
  State_127705_Desc = {
    Text = "Kartu telah dimanipulasi! Setelah dimainkan, menerima [Layer] poin kerusakan dan membuat stacks <CardKeyWord:Sabotase Tersembunyi> berkurang setengah."
  },
  State_127705_Name = {
    Text = "<CardKeyWord:Merusak dalam Diam>"
  },
  State_127705_WeaponDesc = {
    Text = "Kartu yang dimainkan menerima [StateArg1] kerusakan."
  },
  State_127708_Desc = {
    Text = "Setelah musuh memainkan kartu non-kartu perintah, semua sekutu mendapatkan [DescArg1] lapisan <PowerIconKeywords:Kekuatan>. Abu sisa lama menjadi tidak berlaku setelah pecah."
  },
  State_127708_Name = {
    Text = "Benang Kekacauan"
  },
  State_127709_Name = {
    Text = "Negara Pemain Benang Hitam"
  },
  State_127710_Name = {
    Text = "Serat Hitam Terpicu"
  },
  State_128026_Name = {
    Text = "Status pemain Benang Putih"
  },
  State_128027_Desc = {
    Text = "Setelah musuh memainkan kartu perintah, semua pihak yang bersahabat mendapatkan [DescArg1] lapisan sementara <ReinforcePVEKeywords:Diperkuat>. Abu sisa lama menjadi tidak berlaku setelah dihancurkan."
  },
  State_128027_Name = {
    Text = "Benang Keteraturan"
  },
  State_128028_Desc = {
    Text = "Kartu telah dimanipulasi! Setelah di-play, menerima <FixedDamage:Kerusakan Murni> dan mengurangi stacks <BrokenCard:Sabotase Tersembunyi> menjadi setengahnya."
  },
  State_128028_Name = {
    Text = "<CardKeyWord:Merusak dalam Diam>"
  },
  State_128028_WeaponDesc = {
    Text = "Kartu yang dimainkan menerima [StateArg1] kerusakan."
  },
  State_128029_Name = {
    Text = "Benang Putih Terpicu"
  },
  State_128067_Name = {
    Text = "Negara@Pelayan Dingin Spider Pemantauan Abu Sisa"
  },
  State_128069_Name = {
    Text = "Negara@Laba-laba Dingin Pelayan Entwined Deteksi Hit"
  },
  State_128071_Name = {
    Text = "Negara@Pelayan Laba-laba Dingin posisi awal memerlukan tanda pemanggilan"
  },
  State_128073_Desc = {
    Text = "Setiap kali akhir aksi, akan mendapatkan [DescArg1] lapisan <ParcloseIconKeywords:Penghalang> dan [DescArg2] lapisan <Chapter5_Monster_Fervor1:Kegilaan>."
  },
  State_128073_Name = {
    Text = "Buaian Sang Ibu Penenun"
  },
  State_128082_Desc = {
    Text = "Setelah digunakan, Hameln memperoleh 3 poin Aliemus."
  },
  State_128082_Name = {
    Text = "<XushiBKeywords:Akumulasi Nada>"
  },
  State_128086_Desc = {
    Text = "Setelah musuh memainkan kartu perintah, diri sendiri mendapatkan [DescArg1] lapisan <Chapter5_Monster_Fervor1:Kegilaan>, setelah memecahkan\"Abu sisa lama\"bertukar posisi dengan rekan di barisan belakang."
  },
  State_128086_Name = {
    Text = "Putaran Takdir"
  },
  State_128087_Name = {
    Text = "Negara@Jaring Dingin Pelayan Putih dari Reinkarnasi Tanda Pemicu"
  },
  State_128089_Name = {
    Text = "Reinkarnasi Putih terpicu"
  },
  State_128216_Name = {
    Text = "Negara pemain Roda Putih"
  },
  State_128245_Desc = {
    Text = "Kosongkan setelah giliran dimulai, setelah mencapai 10 lapisan, setelah memainkan kartu berikutnya segera bertindak, menghapus <Chapter5_Monster_Fervor2:Kegilaan> dan mengubah niat menjadi menerapkan <FragileIconKeywords:Rapuh> dan secara acak menambahkan <BrokenCard:Merusak secara diam-diam>\"Serat yang Hancur\"."
  },
  State_128245_Name = {
    Text = "Kegilaan Sementara"
  },
  State_128246_Name = {
    Text = "Negara Pemain Putaran Hitam"
  },
  State_128247_Desc = {
    Text = "Kebangkitan setelah mati, imun terhadap kerusakan dan memiliki 100% HP. Mengubah niat menjadi:\"Kegilaan yang Ditakdirkan\": Setiap akhir aksi, dapatkan [DescArg1] poin <PowerIconKeywords:Kekuatan> dan [DescArg2] lapisan <Chapter5_Monster_Fervor2:Kegilaan>."
  },
  State_128247_Name = {
    Text = "Kelahiran Kembali dari Kepompong"
  },
  State_128248_Desc = {
    Text = "Kosongkan setelah giliran dimulai, setelah mencapai 10 lapisan, setelah memainkan kartu berikutnya segera bertindak, menghapus <Chapter5_Monster_Fervor1:Kegilaan> dan mengubah niat menjadi menerapkan <WeaknessIconKeywords:Kelemahan> dan menyegel secara acak kartu perintah\"Jaring Pembatasan\"."
  },
  State_128248_Name = {
    Text = "Kegilaan Sementara"
  },
  State_128250_Name = {
    Text = "Pemicu Kembali Hitam"
  },
  State_128251_Desc = {
    Text = "Setelah musuh memainkan kartu non-perintah, dapatkan [DescArg1] lapisan <Chapter5_Monster_Fervor2:Kegilaan>, setelah memecahkan\"Abu sisa lama\", tukar posisi dengan rekan di belakang."
  },
  State_128251_Name = {
    Text = "Putaran Jurang"
  },
  State_128253_Desc = {
    Text = "Kebangkitan setelah mati, imun terhadap kerusakan dan memiliki 100% HP. Mengubah niat menjadi:\"Kegilaan yang Ditakdirkan\": Setelah setiap aksi selesai, akan mendapatkan [DescArg1] lapisan <ParcloseIconKeywords:Penghalang> dan [DescArg2] lapisan <Chapter5_Monster_Fervor1:Kegilaan>."
  },
  State_128253_Name = {
    Text = "Kelahiran Kembali dari Kepompong"
  },
  State_128257_Desc = {
    Text = "Setiap akhir aksi, dapatkan [DescArg1] poin <PowerIconKeywords:Kekuatan> dan [DescArg2] lapisan <Chapter5_Monster_Fervor2:Kegilaan>."
  },
  State_128257_Name = {
    Text = "Bisikan Sang Ibu Penenun"
  },
  State_128643_Name = {
    Text = "Negara@Jumlah gejala yang dimainkan pemain di ronde ini"
  },
  State_128644_Desc = {
    Text = "Kosongkan pada awal giliran. Setelah mencapai 10 lapisan, setelah memainkan kartu berikutnya, segera bertindak, menghapus <Chapter5_Monster_Fervor3:Kegilaan> dan secara acak beralih niat."
  },
  State_128644_Name = {
    Text = "Kegilaan Sementara"
  },
  State_128645_Desc = {
    Text = "Niat akan dipilih secara acak dari empat jenis niat, tetapi tidak akan terulang. Setelah melepaskan Aliemus Muliakan, segera ganti niat. Setelah memainkan Kartu perintah, dapatkan 1 lapisan <Chapter5_Monster_Fervor3:Kegilaan>."
  },
  State_128645_Name = {
    Text = "Keselarasan Seribu Wajah"
  },
  State_128646_Name = {
    Text = "Negara@Kekacauan nasib kehilangan Serangan Kuat deteksi bermain kartu"
  },
  State_128648_Desc = {
    Text = "Sampai awal ronde berikutnya, setiap kali memainkan 1 kartu perintah, dapatkan <PowerIconKeywords:Kekuatan> sementara sebesar [DescArg1]."
  },
  State_128648_Name = {
    Text = "Kepompong Kemurkaan"
  },
  State_128692_Desc = {
    Text = "Setelah menerima kerusakan aktif atau kerusakan tentakel, menghapus \"Bara Api Purba\" dalam jumlah setara dan kehilangan 300% nyawa dari jumlah yang dihapus, saat menerima kerusakan lain menghapus setengahnya. Tumpukan \"Bara Api Purba\" direset setiap giliran."
  },
  State_128692_Name = {
    Text = "<AshesPastKeyWord:Abu sisa lama>"
  },
  State_128695_Name = {
    Text = "Negara@Niat Nasib yang Tersesat"
  },
  State_129297_Desc = {
    Text = "Pada awal [Layer] pertempuran, atur nyawa semua musuh menjadi 1."
  },
  State_129297_Name = {
    Text = "Bantuan N kecil"
  },
  State_129569_Name = {
    Text = "Negara@Tanda Pemicu Teater Kesukacitaan Nasib yang Kacau"
  },
  State_129570_Name = {
    Text = "Negara@Nasib yang Tersesat Takdir Bisikan Penanda Pemicu"
  },
  State_129571_Name = {
    Text = "Negara@nasib yang Tersesat Tanpa Akhir Ilusi Pemicu Tanda"
  },
  State_129612_Desc = {
    Text = "Niat akan dipilih secara acak dari empat jenis niat, tetapi tidak akan terulang. Setelah melepaskan Aliemus Muliakan, segera ganti niat. Setelah memainkan Kartu perintah, dapatkan 1 lapisan <Chapter5_Monster_Fervor3:Kegilaan>."
  },
  State_129612_Name = {
    Text = "Keselarasan Seribu Wajah"
  },
  State_129625_Desc = {
    Text = "Intensi akan dipilih secara acak dari empat jenis intensi, tetapi tidak akan berulang. Intensi langsung berganti setelah melepaskan ledakan Fury. Mendapatkan 1 tumpukan <Chapter5_Monster_Fervor3:Fanatik> setelah memainkan kartu perintah. Mendapatkan 1 tumpukan \"Jalan Kekacauan\" setiap kali berganti intensi."
  },
  State_129625_Name = {
    Text = "Keselarasan Seribu Wajah"
  },
  State_129643_Desc = {
    Text = "Mendapatkan 1 tumpukan setiap kali berganti intensi. Saat memiliki 10 tumpukan \"Jalan Kekacauan\", intensi berubah menjadi \"Pesta Kegilaan\" yang tidak dapat diganti dan memberikan damage besar serta pelemahan."
  },
  State_129643_Name = {
    Text = "Jalan Takdir yang Kacau"
  },
  State_129644_Name = {
    Text = "Kunci Niat Fusi Terdistorsi"
  },
  State_129650_Desc = {
    Text = "Tim Unik: Jika Pemakai adalah Awakener \"Ramona: Timeworn\", Affiniti yang diperoleh Awakener lain dari eksplorasi level meningkat sebesar <WeaponEffect_Num:[StateArg1]%>, namun diri sendiri tidak mendapatkan Affiniti."
  },
  State_129650_WeaponDesc = {
    Text = "Jika pemakai adalah Awakener \"Ramona: Timeworn\", saat menyelesaikan tingkat, affiniti yang diperoleh Awakener lain meningkat <WeaponEffect_Num:[StateArg1]%>, tetapi dirinya sendiri tidak mendapatkan affiniti."
  },
  State_129761_Desc = {
    Text = "Ubah antarmuka nilai kembali kekuatan pertumbuhan pemain di dalam permainan, setiap 1 lapisan meningkatkan 1%."
  },
  State_129761_Name = {
    Text = "Koreksi Intensitas Pertumbuhan Dalam Pertandingan"
  },
  State_129845_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_129845_Name = {Text = "Not Roused"},
  State_129846_Name = {
    Text = "Hitungan Getaran Benang Putus"
  },
  State_129848_Desc = {
    Text = "Setiap kali [DescArg1] kartu meninggalkan Fissura Dimensi, berikan [DescArg2] lapisan <BrokenCard:Merusak secara diam-diam>."
  },
  State_129848_Name = {
    Text = "Pembukaan Panggung Boneka"
  },
  State_129849_Desc = {
    Text = "Buat salinan kartu perintah pertama yang dimainkan oleh musuh setiap ronde dan masukkan ke dalam Fissura Dimensi. Ketika kartu masuk ke dalam Fissura Dimensi, berikan <DepleteIconKeywords:Lelah> padanya. Setiap kali Posse pertama kali dilepaskan, kartu paling kiri akan diambil dan diletakkan di atas tumpukan Menggambar."
  },
  State_129849_Name = {
    Text = "Memetik Benang Takdir"
  },
  State_129850_Desc = {
    Text = "Setiap Kartu perintah di Fissura Dimensi mengurangi Maximum Hand Size pemain sebanyak 1. Jika sudah penuh, saat Kartu dimainkan berikutnya, \"Jaring Abadi\" segera melakukan Aksi, setelah Aksi, Fissura Dimensi dikosongkan, dan niat diubah menjadi \"Keindahan Diatas Takdir\"."
  },
  State_129850_Name = {
    Text = "Getaran Benang Putus"
  },
  State_129854_Desc = {
    Text = "Setiap Kartu perintah di Fissura Dimensi mengurangi Maximum Hand Size pemain sebanyak 1. Jika sudah penuh, saat Kartu dimainkan berikutnya, \"Jaring Abadi\" segera melakukan Aksi, setelah Aksi mengosongkan Fissura Dimensi, mengubah niat menjadi \"Moira, Atas Kuasaku\"."
  },
  State_129854_Name = {
    Text = "Getaran Benang Putus"
  },
  State_129864_Desc = {
    Text = "Setiap kali memainkan kartu, hapus 1 lapisan \"kantuk\". Di awal putaran, pulihkan hingga 12 lapisan \"kantuk\"."
  },
  State_129864_Name = {Text = "Marah"},
  State_129865_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_129865_Name = {Text = "Not Roused"},
  State_129872_Desc = {
    Text = "Variabel sementara."
  },
  State_129872_Name = {
    Text = "Penghitung1"
  },
  State_129873_Desc = {
    Text = "Mendapatkan status penghitung lapisan [Layer] _Penghitung1_."
  },
  State_129873_Name = {
    Text = "Pengujian Pembungkusan 1"
  },
  State_129874_Desc = {
    Text = "Variabel sementara."
  },
  State_129874_Name = {
    Text = "Amplifier 1"
  },
  State_130358_Desc = {
    Text = "Kartu perintah yang dimainkan berikutnya akan berlaku tambahan 2 kali."
  },
  State_130358_Name = {
    Text = "Wayang Pecut"
  },
  State_130387_Desc = {
    Text = "Setelah \"Boneka Tali\" digunakan, setiap kali kartu perintah pertama yang dimainkan dalam putaran berikutnya akan berlaku tambahan 2 kali. Jika dalam Pertarungan Pemimpin, semua Awakener mendapatkan 50 poin Aliemus dan 1000 poin Energi-s Kunci."
  },
  State_130387_Name = {
    Text = "Pemakaman Takdir"
  },
  State_130388_Name = {
    Text = "<RetainIconKeywords:Retain>: Mendapatkan [DescArg1] Energi-s"
  },
  State_130389_Desc = {
    Text = "Setelah play, semua Awakener mendapatkan [DescArg1] poin Aliemus"
  },
  State_130389_Name = {
    Text = "Setelah play, semua Awakener mendapatkan [DescArg1] poin Aliemus"
  },
  State_130390_Desc = {
    Text = "Arithmetica Limit dan Maximum Hand Size meningkat 1."
  },
  State_130390_Name = {
    Text = "Pengetahuan berlebih"
  },
  State_130391_Desc = {
    Text = "Setiap kali memainkan 1 Kartu gejala, konsumsi aritmetika dari \"Boneka Pita\" berkurang 1."
  },
  State_130391_Name = {Text = "Gema Kotor"},
  State_130490_Desc = {
    Text = "Kerusakan, perisai, penyembuhan, kekuatan, drain, kerusakan tentakel, racun tetap, dan counter tetap yang dihasilkan oleh kartu ini meningkat, dihitung secara independen 1+[Layer]%."
  },
  State_130490_Name = {
    Text = "Mercusuar Singularity α"
  },
  State_130498_Desc = {
    Text = "Kartu perintah yang dimainkan berikutnya akan berlaku tambahan 2 kali."
  },
  State_130498_Name = {
    Text = "Pemakaman Takdir"
  },
  State_130500_Desc = {
    Text = "Dalam Pertarungan Pemimpin, Ketahanan terhadap kematian +100%. Setelah memicu \"Ketahanan terhadap kematian\", pada ronde berikutnya \"Boneka Berjalan\" tidak lagi memaksa untuk memainkan kartu perintah, melainkan memilih satu kartu perintah dari tangan."
  },
  State_130500_Name = {
    Text = "Tatapan Martir"
  },
  State_130501_Desc = {
    Text = "Kartu perintah berikutnya memiliki biaya aritmetika menjadi 0."
  },
  State_130501_WeaponDesc = {
    Text = "Mengubah aritmetika kartu sebelum bermain"
  },
  State_130512_Desc = {
    Text = "Kartu perintah yang dimainkan berikutnya akan berlaku tambahan 2 kali dan konsumsi aritmetika berkurang 2 poin."
  },
  State_130512_Name = {
    Text = "Wayang Pecut"
  },
  State_130517_Desc = {
    Text = "<PVPWeaponKeywords:Roda Takdir>: Saat dilengkapi dan di awal giliran, secara acak memicu salah satu efek berikut: Mendapatkan <Energy:[Energy:StateArg1]> Kegilaan dan <PVPSlowKeywords:Melambat> diri sendiri; Mendapatkan <Energy:[Energy:StateArg3]> Kegilaan; Mendapatkan <Energy:[Energy:StateArg4]> dan [StateArg5] <PVPDerivativeCardKeywords_17:\"Inspirasi\">."
  },
  State_130517_Name = {
    Text = "Kebijaksanaan Taruhan Besar"
  },
  State_131046_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Exalt\"setelah memberikan diri sendiri <Block:[Block:StateArg1]> perisai dan <DelayKeywords:Latensi>: <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_131046_Name = {
    Text = "Surga yang Jauh"
  },
  State_131047_Desc = {
    Text = "Dalam ronde ini, penggunaan Geng sebanyak [Layer] kali akan berlaku dua kali."
  },
  State_131047_Name = {
    Text = "Perintah Kunci Ganda"
  },
  State_131048_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setelah pertama kali play \"Skill\" setiap ronde, berikan <Damage:[Damage:StateArg1]> Kerusakan kepada musuh dengan <HPAndShieldMin:HP dan Perisai terendah>."
  },
  State_131048_Name = {
    Text = "Kegilaan yang Terpenjara"
  },
  State_131055_Desc = {
    Text = "Jumlah kartu yang diambil setiap ronde berkurang -1. Semua Pembangun meningkatkan perisai dan pemulihan hidup sebesar 20%."
  },
  State_131055_Name = {
    Text = "Rapi rambut"
  },
  State_131056_Desc = {
    Text = "Setelah kehilangan hidup, ubah jumlah Aliemus Tertunda menjadi Perisai."
  },
  State_131056_Name = {
    Text = "Perisai Pusaran"
  },
  State_131058_Desc = {
    Text = "Semua Awakener mendapatkan peningkatan dasar Aliemus sebesar 10 poin. Setelah melepaskan Exalt, mendapatkan 1 poin Arithmetica, setiap Awakener hanya dapat memicu 1 kali per ronde."
  },
  State_131058_Name = {
    Text = "Menggosok pipi"
  },
  State_131059_Name = {
    Text = "Tanda Peningkatan Keterampilan Mosk"
  },
  State_131061_Desc = {
    Text = "Batas maksimal Energi-s dan konsumsi Geng meningkat sebesar +350. Efek Geng pertama kali berlaku 2 kali per ronde."
  },
  State_131061_Name = {
    Text = "Memberi makanan ringan"
  },
  State_131064_Desc = {
    Text = "Setelah melepaskan Muliakan, mendapatkan 1 poin Aritmetika, setiap Pembangun hanya dapat memicu 1 kali per ronde."
  },
  State_131064_Name = {
    Text = "Menggosok pipi"
  },
  State_131069_Desc = {
    Text = "Semua perisai dan pemulihan hidup yang dihasilkan oleh semua Pembangun meningkat sebesar 20%."
  },
  State_131069_Name = {
    Text = "Rapi rambut"
  },
  State_131073_Desc = {
    Text = "Tim Unik: Saat pertempuran dimulai, memperoleh Aliemus yang setara dengan <WeaponEffect_Num:[StateArg1]%> dari Aliemus dasar. Kerusakan akhir Exalt pemakai meningkat, persentasenya adalah <WeaponEffect_Num:[StateArg2]%> dari Aliemus dasar. Saat beralih ke sikap \"Ombak Bergelora\", mendapatkan Penguasaan Alam Sementara yang setara dengan <WeaponEffect_Num:[StateArg3]%> dari Penguasaan Alam saat ini, dengan cooldown 3 ronde."
  },
  State_131073_WeaponDesc = {
    Text = "Pada awal pertempuran, dapatkan [DescArg1] poin Aliemus. Kerusakan akhir dari Exalt pemakai meningkat sebesar [DescArg2]%. Saat berpindah ke sikap \"Ombak Bergelora\", dapatkan [DescArg3] poin Penguasaan Alam Sementara, dengan cooldown 3 ronde(sisa saat ini [DescArg4] ronde)."
  },
  State_131078_Desc = {
    Text = "Setiap putaran, efek kunci pertama berlaku 2 kali."
  },
  State_131078_Name = {
    Text = "Memberi makanan ringan"
  },
  State_131118_Desc = {
    Text = "Setiap kali menerima kerusakan atau kehilangan nyawa, tidak dapat melebihi 3% dari nyawa maksimum."
  },
  State_131118_Name = {
    Text = "Kepompong Seribu Benang"
  },
  State_131123_Desc = {
    Text = "Kosongkan pada awal giliran. Setelah mencapai 10 lapisan, setelah memainkan kartu berikutnya, segera bertindak dan beralih ke niat berikutnya, menghapus <Chapter5_Monster_Fervor4:Kegilaan>."
  },
  State_131123_Name = {
    Text = "Kegilaan Sementara"
  },
  State_131127_Desc = {
    Text = "Sikap yang terikat oleh nasib. Setiap kali musuh memainkan 1 kartu \"perintah\", diri sendiri mendapatkan 1 lapisan \"Kegilaan Sementara\"."
  },
  State_131127_Name = {
    Text = "Kontrak Ikatan Sumpah"
  },
  State_131134_Desc = {
    Text = "Setelah kematian, Nephrea mendapatkan [DescArg1] lapisan Kegilaan Sementara, tetapi kehilangan 3% HP maksimal."
  },
  State_131134_Name = {
    Text = "Gerbang Jurang"
  },
  State_131186_Desc = {
    Text = "Setelah dimainkan, berlaku 1 kali tambahan, tetapi menerima [DescArg1] poin kerusakan."
  },
  State_131186_Name = {
    Text = "<ExclamationPointColour:Nasib yang Hancur>"
  },
  State_131188_Desc = {
    Text = "\"Skill\" yang dimainkan masuk ke \"Fissura Dimensi\", dan menambahkan \"Nasib yang Hancur\" ke semua skill dengan nama yang sama, lalu dihapus setelah keluar dari Fissura Dimensi. Ketika Fissura Dimensi penuh, \"Jaring Pengkhianatan\" Nephrea akan mengosongkan Fissura Dimensi setelah melakukan aksi, dan mengubah niat berikutnya menjadi ledakan kegilaan yang kuat."
  },
  State_131188_Name = {
    Text = "Fissura Dimensi"
  },
  State_131191_Name = {
    Text = "Gangguan Kognitif"
  },
  State_131242_Desc = {
    Text = "Kerusakan, perisai, penyembuhan, kekuatan, drain, kerusakan tentakel, racun tetap, dan counter tetap yang dihasilkan oleh kartu ini meningkat, dihitung secara independen 1+[Layer]%."
  },
  State_131242_Name = {
    Text = "Mercusuar Singularity β"
  },
  State_131258_Desc = {
    Text = "Memutar benang roda pemintal, mengganggu takdir yang salah. Setelah melepaskan perintah kunci atau memainkan kartu \"Serpihan Takdir\", hapus 1 tumpukan. Setelah semua tumpukan dihapus, Arachne melancarkan serangan susulan \"Benang Takdir Kembali ke Tempatnya\", menyebabkan kerusakan besar. Setelah dilepaskan 3 kali, akan menghancurkan \"Kepompong Seribu Benang\" musuh sepenuhnya!"
  },
  State_131258_Name = {
    Text = "Gangguan Jaring Takdir"
  },
  State_131261_Name = {
    Text = "Panggung Kehancuran"
  },
  State_131351_Desc = {
    Text = "Pembangun lainnya melepaskan Exalt setelah menghabiskan 1 lapisan, Mosk melepaskan\"Proyektil Arus！\"untuk melakukan Pengejaran."
  },
  State_131351_Name = {
    Text = "Pusaran Memuat"
  },
  State_131439_Desc = {
    Text = "Kartu perintah berikutnya yang kamu mainkan akan berlaku tambahan 2 kali dan konsumsi aritmetika menjadi 0."
  },
  State_131439_Name = {
    Text = "Wayang Pecut"
  },
  State_131637_Desc = {
    Text = "Setelah mati, segera memanggil satu \"Kawanan Laba-laba Jurang\" atau \"Kawanan Laba-laba Dingin\" secara acak, menurunkan \"Efek Kawanan\" mereka sebesar 1 tumpukan."
  },
  State_131637_Name = {
    Text = "Efek Kluster"
  },
  State_131638_Desc = {
    Text = "Setelah mati, segera memanggil satu \"Induk Pecah Bayangan\" atau \"Induk Benang Jeratan\" secara acak, menurunkan \"Efek Kawanan\" mereka sebesar 1 tumpukan."
  },
  State_131638_Name = {
    Text = "Efek Kluster"
  },
  State_131645_Desc = {
    Text = "Tim Unik: Saat beralih ke postur\"Ombak Bergelora\", dapatkan Penguasaan Alam Sementara sebesar <WeaponEffect_Num:[StateArg1]%> yang setara dengan Realm Mastery saat ini, cooldown 3 ronde."
  },
  State_131645_WeaponDesc = {
    Text = "Beralih ke posisi\"Ombak Bergelora\"mendapatkan [DescArg2] poin Penguasaan Alam Sementara, cooldown 3 ronde (sisa [DescArg1] ronde saat ini)."
  },
  State_131657_Desc = {
    Text = "Pembangun lainnya melepaskan Exalt setelah menghabiskan 1 lapisan, Mosk melepaskan\"Proyektil Arus！\"untuk melakukan Pengejaran."
  },
  State_131657_Name = {
    Text = "<WhirlpoolKeywords:Pusaran Memuat>"
  },
  State_131660_Desc = {
    Text = "Setiap lapis meningkatkan kebutuhan Aliemus untuk melepaskan Exalt sebesar 1 poin."
  },
  State_131660_Name = {
    Text = "Koreksi Nilai Tetap Aliemus Lelah"
  },
  State_131675_Desc = {
    Text = "Kartu ini memiliki probabilitas [StateArg1]% untuk berlaku tambahan 1 kali saat dimainkan berikutnya."
  },
  State_131675_Name = {
    Text = "<CardKeyWord:Taruhan Besar>"
  },
  State_131684_Desc = {
    Text = "Selanjutnya [Layer] kali\"Meriam Serangan Putaran！\"akan berlaku 2 kali."
  },
  State_131684_Name = {
    Text = "Mosk! Besar! Boom! Ledakan"
  },
  State_131749_Desc = {
    Text = "Tim Unik: Setelah eksplorasi dimulai, masukkan 1 kartu \"Kebijaksanaan Taruhan Besar\" ke dalam tumpukan menggambar. \"Kebijaksanaan Taruhan Besar\": Menghabiskan 1 Aritmetika. Acak semua kartu perintah di tangan ke dalam tumpukan menggambar, kartu perintah yang dimasukkan memiliki probabilitas <WeaponEffect_Num:[StateArg1]%> untuk berlaku tambahan 1 kali saat dimainkan berikutnya, dan setiap kartu perintah yang dimasukkan akan memberikan 2 poin Aliemus kepada semua Awakener. <RetainIconKeywords:Simpan>. <DepleteIconKeywords:Lelah>. <GuyouKeywords:Innate>."
  },
  State_131749_WeaponDesc = {
    Text = "Setelah eksplorasi dimulai, masukkan 1 kartu \"Kebijaksanaan Taruhan Besar\" ke dalam tumpukan menggambar. \"Kebijaksanaan Taruhan Besar\": Lelah 1 aritmetika. Acak semua kartu perintah di tangan Anda ke dalam tumpukan menggambar, kartu perintah yang diacak memiliki probabilitas <WeaponEffect_Num:[StateArg1]%> untuk berlaku tambahan 1 kali saat dimainkan berikutnya, dan setiap kartu perintah yang diacak akan memberikan 2 poin Aliemus kepada semua Awakener. <RetainIconKeywords:Simpan>. <DepleteIconKeywords:Lelah>. <GuyouKeywords:Innate>."
  },
  State_131769_Name = {
    Text = "Negara@Pembiakan Caro Inisialisasi Pekerjaan 1"
  },
  State_131779_Desc = {
    Text = "Setelah digunakan [Layer] kali, baru akan masuk ke Discard Pile dan mengatur ulang jumlahnya, tetapi \"Orison\" hanya berlaku saat pertama kali digunakan."
  },
  State_131779_Name = {
    Text = "Dapat digunakan [Layer] kali"
  },
  State_131789_Desc = {
    Text = "Alternatif. Tambahkan 1 kartu dengan tid adalah [Layer] ke tangan."
  },
  State_131789_Name = {
    Text = "Tambahkan Kartu yang Ditentukan"
  },
  State_131807_Name = {
    Text = "Negara@PembiakanCaroMurniIdentitas"
  },
  State_131824_Name = {
    Text = "Negara@Monster Tawil Pemantauan Niat Pergantian Pemain"
  },
  State_131846_Desc = {
    Text = "Setelah mati, segera memanggil satu \"Kawanan Laba-laba Jurang\" atau \"Kawanan Laba-laba Dingin\" secara acak, menurunkan \"Efek Kawanan\" mereka sebesar 1 tumpukan."
  },
  State_131846_Name = {
    Text = "Efek Kluster"
  },
  State_131908_Desc = {
    Text = "Membagi rata HP, perisai, dan Fury target, tetapi tidak menghasilkan statistik pertempuran."
  },
  State_131908_Name = {
    Text = "Pesta Kebusukan Lompatan"
  },
  State_131909_Desc = {
    Text = "Memiliki negara ini, maka dapat menggunakan Exalt."
  },
  State_131909_Name = {
    Text = "Segel Permanen"
  },
  State_132366_Desc = {
    Text = "Melakukan serangan lanjutan setelah Awakened lain menggunakan kartu serangan"
  },
  State_132366_Name = {Text = "Pengejaran"},
  State_132465_Desc = {
    Text = "Damage, perisai, pemulihan, kekuatan, pelemahan, damage tentakel, racun tetap, dan serangan balik tetap yang dihasilkan Awakened Body ini meningkat, dikalikan independen 1+[Layer]%."
  },
  State_132465_Name = {
    Text = "Penguatan Telan α"
  },
  State_132469_Desc = {
    Text = "Damage, perisai, pemulihan, kekuatan, pelemahan, damage tentakel, racun tetap, dan serangan balik tetap yang dihasilkan Awakened Body ini meningkat, dikalikan independen 1+[Layer]%."
  },
  State_132469_Name = {
    Text = "Penguatan Telan β"
  },
  State_132539_Desc = {
    Text = "Ciptaan Uji Koleksi"
  },
  State_132539_Name = {
    Text = "Ciptaan Uji Koleksi"
  },
  State_132539_WeaponDesc = {Text = "Uji"},
  State_132560_WeaponDesc = {
    Text = "Setiap kali Api Hijau memberikan [Damage:StateArg2] kerusakan, dapatkan satu kartu yang menghabiskan [Lelah]."
  },
  State_132564_WeaponDesc = {
    Text = "Setiap kali Api Hijau memberikan [Damage:StateArg2] kerusakan, dapatkan satu kartu yang menghabiskan [Lelah]."
  },
  State_132565_WeaponDesc = {
    Text = "Setiap kali Api Hijau memberikan [Damage:StateArg2] kerusakan, dapatkan satu kartu yang menghabiskan [Lelah]."
  },
  State_132598_Desc = {
    Text = "Saat memberikan kerusakan tentakel pada giliran ini, memberikan racun tambahan sebesar [Layer]% dari nilai kerusakan."
  },
  State_132598_Name = {
    Text = "Obsesi kelam"
  },
  State_132609_Desc = {
    Text = "Ketika Pemahat memberikan perisai, tingkatkan [StateArg1] kerusakan tentakel."
  },
  State_132609_Name = {
    Text = "Kerajaan Lupa"
  },
  State_132609_WeaponDesc = {
    Text = "Ketika Pemahat memberikan perisai, tingkatkan [StateArg1] kerusakan tentakel."
  },
  State_132669_Desc = {
    Text = "Damage, perisai, pemulihan, kekuatan, pelemahan, damage tentakel, racun tetap, dan serangan balik tetap yang dihasilkan kartu Awakened Body ini meningkat, dikalikan independen 1+[Layer]%."
  },
  State_132669_Name = {
    Text = "Hyperdimensi Takdir α"
  },
  State_132840_Name = {
    Text = "Bonus efek kepribadian Kartu Perintah \"24\" berlipat ganda. Setelah melepaskan Exalt, efek bonus kepribadian berlipat ganda tidak berlaku pada giliran ini"
  },
  State_132891_Desc = {
    Text = "<PVPWeaponKeywords:Roda Takdir>: Saat dipasang, dapatkan [StateArg1] <StrongEffectKeywords:Kuat>, setelah Fury Burst rekan lain, memberikan <PVPOneMeetingKeywords:Ichigo Ichie> kepadanya."
  },
  State_132891_Name = {
    Text = "Lamunan di Bawah Bunga Sakura"
  },
  State_132892_Desc = {
    Text = "·Saat diperoleh, hapus status \"Sekali Seumur Hidup\" dari rekan lain, dapatkan efek Amplification setara dengan rekan yang memakai \"Misteri di Bawah Bunga Sakura\", maksimal 3 tumpukan.\n·Karakter yang memakai \"Misteri di Bawah Bunga Sakura\" tidak dapat memperoleh \"Sekali Seumur Hidup\"."
  },
  State_132892_Name = {
    Text = "Ichigo Ichie"
  },
  State_133294_Name = {
    Text = "Undangan ke Istana Raja"
  },
  State_133353_Desc = {
    Text = "<PVPWeaponKeywords:Roda Takdir>: Setelah dipasang, deskripsi \"Serangan\",\"Skill\",\"Ledakan Kegilaan\" pemakainya tidak dapat diidentifikasi, tetapi setiap kerusakan, perisai, pemulihan meningkat secara acak sebesar [StateArg1]%~[StateArg2]%."
  },
  State_133353_Name = {
    Text = "Dongeng dalam Lumpur"
  },
  State_133354_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Retain setelah Roda takdir ini mati. Saat Pemakai mati dan setelah [Layer] ronde berikutnya berakhir dalam status mati, teman satu tim lainnya mendapatkan <Heal:[Heal:StateArg1]> <PVPFeatheredSeedsKeyWords:Benih Bulu> dan HP."
  },
  State_133354_Name = {
    Text = "Semoga Dunia Menjadi Harum"
  },
  State_133369_Desc = {
    Text = "[DescArg1] kartu perintah non-Tavi berikutnya yang dimainkan akan aktif 2 kali."
  },
  State_133369_Name = {
    Text = "Melalui Pintu Kunci Perak"
  },
  State_133372_Desc = {
    Text = "Jika saat ini berada dalam giliran hiperdimensi, memicu efek Lompatan Singularitas. \"Anihilasi Singularitas\" juga dapat membuat Lompatan Singularitas berikutnya di giliran ini pasti aktif."
  },
  State_133372_Name = {
    Text = "<SingularityKeywords:Lompatan Singularitas>"
  },
  State_133391_Desc = {
    Text = "Jika jumlah tumpukan status ini lebih besar atau sama dengan HP target, hapus semua Penghakiman Takdir dan langsung membunuh target. Penghakiman Takdir tetap yang diberikan mendapat bonus penguatan damage."
  },
  State_133391_Name = {
    Text = "<CutKeywords:Penghakiman Takdir>"
  },
  State_133395_Desc = {
    Text = "[Layer] kartu perintah berikutnya yang dimainkan akan memicu \"Jelajah Dimensi\"."
  },
  State_133395_Name = {
    Text = "Jelajah Dimensi"
  },
  State_133717_Desc = {
    Text = "Pemilik saat ini adalah [Layer], semua kartu saat ini dan yang akan datang akan mendapatkan atribut yang sesuai (saat ini: Segel Kartu)."
  },
  State_133717_Name = {
    Text = "Penyebaran Atribut Kartu"
  },
  State_133774_Desc = {
    Text = "Setiap 1 tumpukan meningkatkan kerusakan yang ditimbulkan kartu ini, peningkatan Kekuatan dan Kerusakan Tentakel tetap, Racun tetap, Final DMG Counter tetap sebesar 2%; Final DMG efek Perisai tetap, pemulihan HP tetap, STR▼ meningkat sebesar 1%. Kartu yang memiliki Mercusuar Singularity tidak dapat memicu \"Penjelajahan Dimensi\"."
  },
  State_133774_Name = {
    Text = "<SingularityKeywords1:Mercusuar Singularity>"
  },
  State_133775_Desc = {
    Text = "Setiap 1 tumpukan meningkatkan kerusakan yang ditimbulkan semua kartu Awakener, peningkatan Kekuatan dan Kerusakan Tentakel tetap, Racun tetap, Final DMG Counter tetap sebesar 2%; Final DMG efek Perisai tetap, pemulihan HP tetap, STR▼ meningkat sebesar 1%."
  },
  State_133775_Name = {
    Text = "<SingularityKeywords2:Prisma Singularitas>"
  },
  State_133961_Desc = {
    Text = "Tim Unik: Setelah eksplorasi dimulai, hasilkan 1 kartu \"Surat Musim Semi\" dan masukkan ke dalam dek: Arithmetica Cost 1, mendapatkan <WeaponEffect_Num:[StateArg1]> poin Keyflare, setelah di-play berubah permanen menjadi \"Sakura Mekar Penuh\": Arithmetica Cost 1, mendapatkan <WeaponEffect_Num:[StateArg2]> poin Keyflare, setelah di-play berubah permanen menjadi \"Hanafubuki\": Arithmetica Cost 1, mendapatkan <WeaponEffect_Num:[StateArg3]> poin Keyflare, setelah di-play berubah permanen menjadi \"Sekali Seumur Hidup\": Arithmetica Cost 1, pilih 1 dari 3 Posse acak yang telah dibuka untuk segera dilepaskan dan berlaku 2 kali, setelah di-play berubah permanen menjadi \"Surat Musim Semi\". Semua kartu ini memiliki \"Retain\"."
  },
  State_133961_WeaponDesc = {
    Text = "Setelah eksplorasi dimulai, buat satu kartu \"Surat Musim Semi\" dan masukkan ke dek: Konsumsi daya komputasi 1, dapatkan <WeaponEffect_Num:[StateArg1]> poin energi Kunci Perak, setelah dimainkan berubah permanen menjadi \"Sakura Mekar Penuh\": Konsumsi daya komputasi 1, dapatkan <WeaponEffect_Num:[StateArg2]> poin energi Kunci Perak, setelah dimainkan berubah permanen menjadi \"Hujan Kelopak Sakura\": Konsumsi daya komputasi 1, dapatkan <WeaponEffect_Num:[StateArg3]> poin energi Kunci Perak, setelah dimainkan berubah permanen menjadi \"Ichigo Ichie\": Konsumsi daya komputasi 1, pilih 1 dari 3 Perintah Kunci acak yang telah dibuka dan langsung aktifkan serta berlaku 2 kali, setelah dimainkan berubah permanen menjadi \"Surat Musim Semi\". Semua kartu ini memiliki \"Simpan\"."
  },
  State_133994_Desc = {
    Text = "Final DMG kerusakan yang ditimbulkan oleh semua Kartu perintah Awakener, peningkatan Kekuatan dan Kerusakan Tentakel tetap, Racun tetap, Counter tetap meningkat sebesar [DescArg1]%, efek Perisai tetap, pemulihan HP tetap, STR▼ yang ditimbulkan meningkat sebesar [DescArg2]%."
  },
  State_133994_Name = {
    Text = "Prisma Singularitas"
  },
  State_133998_Desc = {
    Text = "Kerusakan, perisai, perubahan Kekuatan kartu ini meningkat [DescArg2]%, efek akhir kerusakan tentakel, pemulihan HP, racun tetap, serangan balik tetap meningkat [DescArg1]%, dihapus saat akhir giliran atau setelah dimainkan."
  },
  State_133998_Name = {
    Text = "<TempPowerKeywords1:Penguatan Sementara [DescArg1]>"
  },
  State_133999_Desc = {
    Text = "Setiap 1 tumpukan meningkatkan kerusakan yang ditimbulkan kartu ini, peningkatan Kekuatan dan Kerusakan Tentakel tetap, Racun tetap, Final DMG Counter tetap sebesar 2%; Final DMG efek Perisai tetap, pemulihan HP tetap, STR▼ meningkat sebesar 1%, dihapus setelah giliran berakhir atau setelah di-play."
  },
  State_133999_Name = {
    Text = "<TempPowerKeywords:Penguatan Sementara>"
  },
  State_134100_Desc = {
    Text = "Saat menerima kerusakan mematikan dalam pertempuran ini, bangkit kembali, memulihkan [Layer] poin HP dan memberikan [StateArg1] poin Fury serta [DescArg1] poin kerusakan tentakel sementara kepada semua Awakened, tidak dapat dihilangkan."
  },
  State_134100_Name = {
    Text = "Burung Abadi dari Surga"
  },
  State_134191_Desc = {
    Text = "Unik Tim: Setelah eksplorasi dimulai, memasukkan 1 kartu \"Waktu Istirahat Pribadi\" ke tumpukan kartu tarik. \"Waktu Istirahat Pribadi\": Konsumsi 1 daya komputasi. Kerusakan kritis sementara +<WeaponEffect_Num:[StateArg1]%>. <RetainIconKeywords:Pertahankan>. <DepleteIconKeywords:Konsumsi>."
  },
  State_134191_WeaponDesc = {
    Text = "Setelah eksplorasi dimulai, memasukkan 1 kartu \"Waktu Istirahat Pribadi\" ke tumpukan kartu tarik. \"Waktu Istirahat Pribadi\": Konsumsi 1 daya komputasi. Kerusakan kritis sementara +<WeaponEffect_Num:[StateArg1]%>. <RetainIconKeywords:Pertahankan>. <DepleteIconKeywords:Konsumsi>."
  },
  State_134195_Desc = {
    Text = "Lapisan racun tetap, serangan balik tetap, dan Penghakiman Takdir tetap yang dihasilkan kartu ini meningkat, dikalikan independen 1+[Layer]%."
  },
  State_134195_Name = {
    Text = "Kekuatan Tiga Fase α1"
  },
  State_134196_Desc = {
    Text = "Lapisan racun tetap, serangan balik tetap, dan Penghakiman Takdir tetap yang dihasilkan oleh kartu perintah Awakened Body ini meningkat, dikalikan independen 1+[StateArg1]%."
  },
  State_134196_Name = {
    Text = "Kekuatan Tiga Fase β3"
  },
  State_134197_Desc = {
    Text = "Lapisan racun tetap, serangan balik tetap, dan Penghakiman Takdir tetap yang dihasilkan kartu ini meningkat, dikalikan independen 1+[StateArg1]%."
  },
  State_134197_Name = {
    Text = "Kekuatan Tiga Fase β1"
  },
  State_134198_Desc = {
    Text = "Lapisan racun tetap, serangan balik tetap, dan Penghakiman Takdir tetap yang dihasilkan oleh kartu perintah Awakened Body ini meningkat, dikalikan independen 1+[Layer]%."
  },
  State_134198_Name = {
    Text = "Kekuatan Tiga Fase α3"
  },
  State_134199_Desc = {
    Text = "Lapisan racun tetap, serangan balik tetap, dan Penghakiman Takdir tetap yang dihasilkan oleh Ledakan Fury Awakened Body ini meningkat, dikalikan independen 1+[StateArg1]%."
  },
  State_134199_Name = {
    Text = "Kekuatan Tiga Fase β2"
  },
  State_134200_Desc = {
    Text = "Lapisan racun tetap, serangan balik tetap, dan Penghakiman Takdir tetap yang dihasilkan oleh Ledakan Fury Awakened Body ini meningkat, dikalikan independen 1+[Layer]%."
  },
  State_134200_Name = {
    Text = "Kekuatan Tiga Fase α2"
  },
  State_134227_Desc = {
    Text = "Serat yang ditenun Arachne dari takdir. Maksimal [DescArg1] lapisan, dapat dikonsumsi oleh Exalt untuk melepaskan pengejaran \"Serat Tanpa Akhir\",\"Tenun Takdir\" akan diwariskan ke pertempuran berikutnya."
  },
  State_134227_Name = {
    Text = "<SilkKeywords:Pemintal>"
  },
  State_134231_Desc = {
    Text = "Unik Tim: Perisai yang dihasilkan pemakainya meningkat <WeaponEffect_Num:[StateArg1]%>, saat pemakai melakukan \"Serangan Lanjutan\" + <WeaponEffect_Num:[StateArg2]%> penguatan sementara, maksimal aktif 5 kali per giliran. Setiap kali \"Jelajah Dimensi\" terpicu, pemakai mendapatkan <WeaponEffect_Num:[StateArg3]> poin Fury."
  },
  State_134231_WeaponDesc = {
    Text = "Perisai yang dihasilkan pemakainya meningkat <WeaponEffect_Num:[StateArg1]%>, saat pemakai melakukan \"Serangan Lanjutan\" + <WeaponEffect_Num:[StateArg2]%> penguatan sementara, maksimal aktif 5 kali per giliran. Setiap kali \"Jelajah Dimensi\" terpicu, pemakai mendapatkan <WeaponEffect_Num:[StateArg3]> poin Fury."
  },
  State_134237_Desc = {
    Text = "Serat yang ditenun Arachne dari takdir, maksimal [DescArg1] lapisan, dapat dikonsumsi oleh ledakan kegilaan untuk melepaskan pengejaran \"<DerivativeCardKeywords_144:Benang Tanpa Akhir>\". \"Tenun Takdir\" akan diwariskan ke pertarungan berikutnya."
  },
  State_134237_Name = {Text = "Pemintal"},
  State_134240_Desc = {
    Text = "Selanjutnya [Layer] kali \"Rajutan Kekal\" menghasilkan tambahan \"Benang Pemandu\" yang dimasukkan ke dalam Menggambar dan Discard Pile."
  },
  State_134240_Name = {
    Text = "Jaring Pengikat Takdir"
  },
  State_134261_Desc = {
    Text = "[Layer] kali kerusakan berikutnya yang diberikan menjadi dua kali lipat."
  },
  State_134261_Name = {
    Text = "Waktu Istirahat Siang Pribadi"
  },
  State_134262_Desc = {
    Text = "<PVPWeaponKeywords:Roda Takdir>: Setelah \"Fury Burst\", damage berikutnya yang diberikan oleh diri sendiri menjadi dua kali lipat."
  },
  State_134262_Name = {
    Text = "Waktu Istirahat Siang Pribadi"
  },
  State_134285_Desc = {
    Text = "Jika jumlah tumpukan status ini lebih besar atau sama dengan HP target, hapus semua Penghakiman Takdir dan langsung membunuh target. Penghakiman Takdir tetap yang diberikan mendapat bonus penguatan damage."
  },
  State_134285_Name = {
    Text = "Penghakiman Takdir"
  },
  State_134313_Desc = {
    Text = "Unik Tim: Perisai yang dihasilkan pemakainya meningkat <WeaponEffect_Num:[StateArg1]%>, saat pemakai melakukan \"Serangan Lanjutan\" + <WeaponEffect_Num:[StateArg2]%> penguatan sementara, maksimal aktif 5 kali per giliran."
  },
  State_134313_WeaponDesc = {
    Text = "Perisai yang dihasilkan pemakainya meningkat <WeaponEffect_Num:[StateArg1]%>, saat pemakai melakukan \"Serangan Lanjutan\" + <WeaponEffect_Num:[StateArg2]%> penguatan sementara, maksimal aktif 5 kali per giliran."
  },
  State_134384_Desc = {
    Text = "[Layer] kartu perintah berikutnya yang dimainkan akan memicu \"Jelajah Dimensi\"."
  },
  State_134384_Name = {
    Text = "Jelajah Dimensi"
  },
  State_134389_Desc = {
    Text = "Final DMG kerusakan yang ditimbulkan kartu ini, peningkatan Kekuatan dan Kerusakan Tentakel tetap, Racun tetap, Counter tetap meningkat sebesar [DescArg1]%, efek Perisai tetap, pemulihan HP tetap, STR▼ yang ditimbulkan meningkat sebesar [DescArg2]%. Kartu yang memiliki \"Mercusuar Singularity\" tidak dapat lagi disalin ke dalam \"Ruang Ultra\"."
  },
  State_134389_Name = {
    Text = "<SingularityKeywords:Mercusuar Singularity [DescArg2]>"
  },
  State_134391_Desc = {
    Text = "Memicu efek ini setelah memainkan kartu perintah pertama setiap giliran. Setelah memainkan kartu perintah, salinan asli sementaranya ditempatkan ke ruang hiperdimensi. Efek ini tidak dapat diaktifkan selama giliran hiperdimensi."
  },
  State_134391_Name = {
    Text = "<SingularityKeywords3:Jelajah Dimensi>"
  },
  State_135232_Name = {
    Text = "<AwakerCard_24Lost:<SingularityKeywords:Lompatan Singularitas>: Selama sisa giliran ini, setelah Awakened lain memainkan kartu perintah, konsumsi 1 tumpukan <SilkKeywords:Tenun Takdir> untuk melancarkan serangan lanjutan \"<DerivativeCardKeywords_137:Benang Tanpa Akhir>\">"
  },
  State_135233_Name = {
    Text = "<SingularityKeywords:Lompatan Singularitas>: Selama sisa giliran ini, setelah Awakened lain memainkan kartu perintah, konsumsi 1 tumpukan <SilkKeywords:Tenun Takdir> untuk melancarkan serangan lanjutan \"<DerivativeCardKeywords_137:Benang Tanpa Akhir>\""
  },
  State_135919_Name = {
    Text = "<AwakerCard_24Lost:<SingularityKeywords:Lompatan Singularitas>: Selama sisa giliran ini, setelah Awakened lain memainkan kartu perintah, konsumsi 1 tumpukan <SilkKeywords:Tenun Takdir> untuk melancarkan serangan lanjutan \"<DerivativeCardKeywords_137:Benang Tanpa Akhir>\">"
  },
  State_135920_Name = {
    Text = "<SingularityKeywords:Lompatan Singularitas>: Selama sisa giliran ini, setelah Awakened lain memainkan kartu perintah, konsumsi 1 tumpukan <SilkKeywords:Tenun Takdir> untuk melancarkan serangan lanjutan \"<DerivativeCardKeywords_137:Benang Tanpa Akhir>\""
  },
  State_135921_Desc = {
    Text = "Kerusakan yang ditimbulkan oleh Bangun meningkat sebesar 25%."
  },
  State_135921_Name = {
    Text = "<CardKeyWord:Hardikan, Balas Dendam>"
  },
  State_138824_Desc = {
    Text = "Kehidupan yang bersinar memuji kebebasan, memainkan lagu kemenangan, dapat dikonsumsi oleh Exalt Aliemus Saya untuk memperkuat efeknya. Status ini dapat ditumpuk hingga 4 lapisan dan akan dipertahankan setelah pertempuran berakhir."
  },
  State_138824_Name = {
    Text = "<KaiHuajishu1:Benih Bulu>"
  },
  State_139039_Desc = {
    Text = "Efek akhir dari Kerusakan, Perisai tetap, pemulihan HP tetap, Strength tetap, STR▼, Kerusakan tentakel ditingkatkan, Racun tetap, Counter tetap yang diberikan oleh Exalt berikutnya dari Tubuh Terjaga ini pada ronde ini meningkat sebesar [Layer]%."
  },
  State_139039_Name = {
    Text = "<BreedingKeywords2:Festival Pembiakan>"
  },
  State_139687_Desc = {
    Text = "Kehidupan yang bersinar memuji kebebasan, memainkan lagu kemenangan, dapat dikonsumsi oleh Exalt Aliemus Saya untuk memperkuat efeknya. Status ini dapat ditumpuk hingga 4 lapisan dan akan dipertahankan setelah pertempuran berakhir."
  },
  State_139687_Name = {
    Text = "<KaiHuajishu:Benih Bulu>"
  },
  State_139688_Desc = {
    Text = "Tim Unik: Arithmetica Limit +1, efek sejenis tidak dapat ditumpuk. Setiap 10 poin Aliemus Dasar yang dimiliki Pemakai, efek <Corrosion:Corrosion> tetap yang diberikan meningkat sebesar <WeaponEffect_Num:[StateArg1]%>, dan Embryo Fusion yang diberikan meningkat sebesar <WeaponEffect_Num:[Float:StateArg2]%>."
  },
  State_139688_WeaponDesc = {
    Text = "Arithmetica Limit +1, efek sejenis tidak dapat ditumpuk. Setiap 10 poin Aliemus Dasar yang dimiliki Pemakai, efek <Corrosion:Corrosion> tetap yang diberikan meningkat sebesar <WeaponEffect_Num:[StateArg1]%>, dan Embryo Fusion yang diberikan meningkat sebesar <WeaponEffect_Num:[Float:StateArg2]%>."
  },
  State_139689_Desc = {
    Text = "Tim Unik: Setelah menggunakan \"Crimson Furnace\", Pemakai mendapatkan Aliemus sebesar <WeaponEffect_Num:[StateArg1]%> dari Aliemus Dasar, dengan cooldown 3 giliran."
  },
  State_139689_WeaponDesc = {
    Text = "Setelah menggunakan \"Crimson Furnace\", pemakai memperoleh Aliemus sebesar <WeaponEffect_Num:[StateArg1]%> dari Aliemus Dasar, cooldown 3 ronde."
  },
  State_139977_Desc = {
    Text = "Jika mengeluarkan \"Serangan\" pada giliran ini, maka \"Serangan\"+ [DescArg1]% penetrasi kerusakan; jika tidak, di akhir giliran +[Layer] Pelindung."
  },
  State_139977_Name = {
    Text = "Bintang Beast"
  },
  State_140063_Desc = {
    Text = "Ini adalah \"surat utang\" yang dibuat dengan meminjam daya komputasi dari giliran berikutnya, akan mengurangi [Layer] daya komputasi setelah giliran berikutnya dimulai, tidak dapat dihilangkan."
  },
  State_140063_Name = {
    Text = "Surat Utang"
  },
  State_140068_Desc = {
    Text = "[DescArg1] \"Skill\" berikutnya mengonsumsi daya komputasi - [StateArg1]."
  },
  State_140068_Name = {Text = "Pencerahan"},
  State_140135_Desc = {
    Text = "Setiap 1 tumpukan yang dimiliki, Efek akhir dari Kerusakan, Perisai tetap, pemulihan HP tetap, Strength tetap, STR▼, Kerusakan tentakel ditingkatkan, Racun tetap, Counter tetap yang diberikan oleh Exalt berikutnya dari Tubuh Terjaga ini pada ronde ini meningkat sebesar 1%."
  },
  State_140135_Name = {
    Text = "<BreedingKeywords2:Festival Pembiakan>"
  },
  State_140186_WeaponDesc = {
    Text = "Jumlah semua kerusakan Whale Leap +1."
  },
  State_140454_Desc = {
    Text = "Unik Tim: Setiap 1% drop Tinta Hitam dari pemilik, Roda Nasib, dan Perjanjian Rahasia, pulihkan <WeaponEffect_Num:[StateArg1]%> HP maks setelah pertempuran berakhir. Efek pemulihan berkurang 30% di akhir setiap giliran, dihitung secara independen untuk setiap instance. Setelah menggunakan \"Persepsi\" di \"Reruntuhan Abu\", refresh \"Reruntuhan Abu\" kali ini tidak memerlukan konsumsi Tinta Hitam."
  },
  State_140454_WeaponDesc = {
    Text = "Unik Tim: Setelah pertempuran selesai, pulihkan <WeaponEffect_Num:[DescArg2]%> nyawa maksimum([DescArg1]), setiap akhir giliran efek pemulihan ini berkurang 30%. Setelah mengaktifkan \"Induksi\" di \"Reruntuhan Abu\", penyegaran \"Reruntuhan Abu\" kali ini tidak memerlukan konsumsi Segel Hitam."
  },
  State_140456_WeaponDesc = {
    Text = "Setelah digunakan, secara permanen hapus."
  },
  State_140458_Desc = {
    Text = "<PVPWeaponKeywords:Roda Takdir>:Saat dilengkapi dan setelah Awakened mana pun melepaskan \"Ledakan Kegilaan\", diri sendiri mendapatkan perisai <Block:[Block:StateArg1]>."
  },
  State_140458_Name = {
    Text = "Kepada Bintang-Bintang"
  },
  State_140489_Desc = {
    Text = "Mendapatkan HP maksimum sejumlah yang sama, jumlah lapis tidak akan melebihi HP maksimum awal Awakened."
  },
  State_140489_Name = {Text = "Benih Bulu"},
  State_140490_Desc = {
    Text = "Mendapatkan HP maksimum sejumlah yang sama, jumlah lapis tidak akan melebihi HP maksimum awal Awakened tersebut [DescArg1]."
  },
  State_140490_Name = {Text = "Benih Bulu"},
  State_140495_Desc = {
    Text = "Arithmetica yang dikonsumsi oleh \"Skill\" berikutnya - [Layer] ."
  },
  State_140495_Name = {
    Text = "Penulisan Ulang"
  },
  State_140517_Desc = {
    Text = "Konsumsi Arithmetica \"Skill\" berikutnya - [DescArg1] ."
  },
  State_140517_Name = {
    Text = "Penulisan Ulang"
  },
  State_140547_Desc = {
    Text = "Efek ini paling banyak meningkatkan Fusi Embrio+ sebesar 100, tidak terpengaruh oleh bonus peningkatan Fusi Embrio."
  },
  State_140547_Name = {
    Text = "Penggandaan Fusi Embrio"
  },
  State_140645_Desc = {
    Text = "Efek tunggu"
  },
  State_140645_Name = {
    Text = "Efek tunggu"
  },
  State_140647_Name = {
    Text = "Pemantauan Disonansi Kognitif Dimainkan"
  },
  State_140648_Name = {
    Text = "Hitungan Disonansi Kognitif Pemain"
  },
  State_140650_Desc = {
    Text = "3 kali pertama setiap giliran saat memainkan kartu perintah dengan \"Kekacauan Kognitif\", Saya memperoleh [Layer] poin Kegilaan."
  },
  State_140650_Name = {
    Text = "Modifikasi Kognisi"
  },
  State_140651_Desc = {
    Text = "Efek tunggu"
  },
  State_140651_Name = {
    Text = "Efek tunggu"
  },
  State_140653_Desc = {
    Text = "Arithmetica Cost kartu ini memiliki kemungkinan 10% -2, 25% -1, 30% tidak berubah, 25% +1, 10% +2. Status ini dihapus setelah dimainkan atau dibuang."
  },
  State_140653_Name = {
    Text = "<ExclamationPointColour:Disonansi Kognitif>"
  },
  State_140654_Desc = {
    Text = "Efek tunggu"
  },
  State_140654_Name = {
    Text = "Efek tunggu"
  },
  State_140655_Desc = {
    Text = "Kartu ini tertutup oleh Pelarutan sehingga teksnya tidak dapat dilihat, Arithmetica Cost memiliki kemungkinan 10% -2, 25% -1, 30% tidak berubah, 25% +1, 10% +2. Status ini dihapus setelah dimainkan atau dibuang."
  },
  State_140655_Name = {
    Text = "<ErosionColorInkKeywords:Kekacauan Kognitif>"
  },
  State_140656_Desc = {
    Text = "Arithmetica Cost kartu ini memiliki kemungkinan 10% -2, 25% -1, 30% tidak berubah, 25% +1, 10% +2. Status ini dihapus setelah dimainkan atau dibuang."
  },
  State_140656_Name = {
    Text = "<ColorInkKeywords:Disonansi Kognitif>"
  },
  State_140657_Desc = {
    Text = "Kartu ini tertutup oleh Pelarutan sehingga teksnya tidak dapat dilihat, Arithmetica Cost memiliki kemungkinan 10% -2, 25% -1, 30% tidak berubah, 25% +1, 10% +2. Status ini dihapus setelah dimainkan atau dibuang."
  },
  State_140657_Name = {
    Text = "<ExclamationPointColour:Kekacauan Kognitif>"
  },
  State_140658_Name = {
    Text = "Pemain Memiliki Pemantauan Disonansi Kognitif"
  },
  State_140659_Desc = {
    Text = "Efek tunggu"
  },
  State_140659_Name = {
    Text = "Efek tunggu"
  },
  State_140662_Desc = {
    Text = "Di awal setiap giliran, secara acak menerapkan \"Kekacauan Kognitif\" pada 2 kartu perintah yang belum memiliki \"Kekacauan Kognitif\"."
  },
  State_140662_Name = {
    Text = "Pemulihan Kehidupan"
  },
  State_140672_Desc = {
    Text = "Sebelum ronde ini berakhir, setiap kerusakan, penyembuhan, dan perisai yang diberikan akan berkurang secara acak sebesar 15%~35%, tidak dapat dihalau."
  },
  State_140672_Name = {
    Text = "<PVPCognitiveDissonanceKeyWords:Kekacauan Kognitif>"
  },
  State_140673_Desc = {
    Text = "Sebelum ronde ini berakhir, setiap kerusakan, penyembuhan, dan perisai yang diberikan akan berkurang secara acak sebesar 15%~35%, tidak dapat dihalau."
  },
  State_140673_Name = {
    Text = "Kekacauan Kognitif"
  },
  State_140683_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat dipakai, dapatkan [StateArg1] <MaxHPKeywords:Max HP>, di akhir giliran pulihkan <Heal:[Heal:DescArg1]> HP, HP Recovery meningkat seiring menurunnya HP pemakai, maksimal meningkat [StateArg3]%."
  },
  State_140683_Name = {
    Text = "Berkelana di Negeri Ajaib"
  },
  State_140724_Name = {Text = "Makan"},
  State_140726_Desc = {
    Text = "Efek akhir dari kerusakan, kekuatan, kerusakan tentakel, racun tetap, serangan balik tetap, perisai, pemulihan nyawa, penurunan kekuatan yang disebabkan oleh kartu ini berkurang sebesar [DescArg1]%."
  },
  State_140726_Name = {
    Text = "<AdaptKeywords1:Adaptasi [DescArg1]>"
  },
  State_140727_Desc = {
    Text = "Saat Kelaparan mencapai 5 lapisan, setelah giliran berakhir, habiskan semua Kelaparan, alihkan niat ke Serangan Kuat dan dapatkan [DescArg1] poin Strength."
  },
  State_140727_Name = {Text = "Kelaparan"},
  State_140728_Desc = {
    Text = "Setiap awal giliran mendapatkan 1 lapisan kelaparan, saat menyebabkan Kerusakan yang tidak terblokir, dapatkan Perisai sebesar 2% dari Max HP ([DescArg1]) poin, batas maksimal lapisan Adaptasi meningkat menjadi 75."
  },
  State_140728_Name = {
    Text = "Melindungi Makanan"
  },
  State_140730_Desc = {
    Text = "Setelah memainkan Kartu perintah, berikan 10 lapisan <AdaptKeywords:Adaptasi> pada kartu milik Tubuh Terjaga yang bersangkutan di semua tempat, dan hapus 5 lapisan <AdaptKeywords:Adaptasi> dari kartu milik Tubuh Terjaga lainnya. Setiap lapisan <AdaptKeywords:Adaptasi> mengurangi efek akhir dari Kerusakan, Kekuatan, Kerusakan tentakel, Racun tetap, Counter tetap, Perisai, pemulihan HP, dan STR▼ yang disebabkan oleh kartu sebesar 1%, maksimal ditumpuk hingga [DescArg1] lapisan."
  },
  State_140730_Name = {Text = "Mimetisme"},
  State_140838_Desc = {
    Text = "Kerusakan yang ditimbulkan ronde ini berkurang [Layer]%."
  },
  State_140838_Name = {
    Text = "Tembok Mimpi Buruk Penutup Matahari"
  },
  State_140839_Desc = {
    Text = "Ronde ini semua Awakener Final DMG meningkat [Layer]%."
  },
  State_140839_Name = {
    Text = "Berburu Bersama"
  },
  State_140856_Desc = {
    Text = "Awakener tidak dapat beraksi, pada akhir ronde hapus 1 lapis Gangguan Kesadaran, setelah semua dihapus 1 kali Exalt berikutnya yang dilepaskan oleh Awakener tersebut dianggap sebagai Over-Exaltation, jika sudah melepaskan Over-Exaltation maka mengembalikan 100% Aliemus Dasar."
  },
  State_140856_Name = {
    Text = "<Yishiganshe:Interferensi Kesadaran>"
  },
  State_140860_Desc = {
    Text = "Awakener tidak dapat beraksi, pada akhir ronde hapus 1 lapis Gangguan Kesadaran, setelah semua dihapus 1 kali Exalt berikutnya yang dilepaskan oleh Awakener tersebut dianggap sebagai Over-Exaltation, jika sudah melepaskan Over-Exaltation maka mengembalikan 100% Aliemus Dasar."
  },
  State_140860_Name = {
    Text = "<Yishiganshe:Interferensi Kesadaran>"
  },
  State_140861_Desc = {
    Text = "1 kali Exalt berikutnya dianggap sebagai Over-Exaltation, jika sudah melepaskan Over-Exaltation maka mengembalikan 100% Aliemus Dasar."
  },
  State_140861_Name = {
    Text = "Berkelana di Negeri Ajaib"
  },
  State_140873_Desc = {
    Text = "Setiap 1 lapisan mengurangi efek akhir dari Kerusakan, Kekuatan, Kerusakan tentakel, Racun tetap, Counter tetap, Perisai, pemulihan HP, dan STR▼ yang disebabkan oleh kartu ini sebesar 1%, maksimal [DescArg1] lapisan."
  },
  State_140873_Name = {
    Text = "<AdaptKeywords:Adaptasi>"
  },
  State_140877_Name = {
    Text = "Berlaku tambahan [DescArg1] kali"
  },
  State_141468_Desc = {
    Text = "Saat Lapar mencapai 5 tumpukan, setelah giliran berakhir, semua Lapar akan dikonsumsi, niat beralih ke Serangan Kuat dan mendapatkan Kekuatan."
  },
  State_141468_Name = {
    Text = "<HungerKeywords:Lapar>"
  },
  State_141504_Desc = {
    Text = "Maksimal menumpuk hingga 3, setelah mencapai batas, \"Necrotic Gala\" berikutnya dapat mengonsumsinya dan meningkatkan efeknya. Sisa-sisa akan dibawa ke pertempuran berikutnya."
  },
  State_141504_Name = {Text = "Reruntuhan"},
  State_141950_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat dipasang dan akhir giliran, <PVPDiscoveryKeyWords:Menemukan> [StateArg1] \"Skill\" yang dilampiri <PVPVoidKeywords:Void> dan memasukkannya ke tangan."
  },
  State_141950_Name = {
    Text = "Jatuh ke Atas"
  },
  State_141988_Desc = {
    Text = "Kerusakan, Perisai, penyembuhan yang diberikan oleh kartu ini, serta Kekuatan, Drain, Kerusakan tentakel, Racun, Counter, Penghakiman Takdir, Racun tetap, Counter tetap, Penghakiman Takdir tetap yang diterapkan, Efek meningkat sebesar [Layer]%."
  },
  State_141988_Name = {
    Text = "Kartu ini Berwarna-warni"
  },
  State_141989_Desc = {
    Text = "Membuat Kartu secara acak."
  },
  State_141989_Name = {
    Text = "<CardKeyWord:Temuan>"
  },
  State_141991_Desc = {
    Text = "Kerusakan, Perisai, penyembuhan yang diberikan oleh Exalt Awakener ini, serta Kekuatan, Drain, Kerusakan tentakel, Racun, Counter, Penghakiman Takdir, Racun tetap, Counter tetap, Penghakiman Takdir tetap yang diterapkan, Efek meningkat sebesar [Layer]%."
  },
  State_141991_Name = {
    Text = "Exalt Berwarna-warni"
  },
  State_141992_Desc = {
    Text = "Kerusakan, Perisai, penyembuhan yang diberikan oleh kartu Awakener ini, serta Kekuatan, Drain, Kerusakan tentakel, Racun, Counter, Penghakiman Takdir, Racun tetap, Counter tetap, Penghakiman Takdir tetap yang diterapkan, Efek meningkat sebesar [Layer]%."
  },
  State_141992_Name = {
    Text = "Kartu ini Berwarna-warni"
  },
  State_141993_Desc = {
    Text = "Kerusakan, Perisai, penyembuhan yang diberikan oleh Kartu perintah Awakener ini, serta Kekuatan, Drain, Kerusakan tentakel, Racun, Counter, Penghakiman Takdir, Racun tetap, Counter tetap, Penghakiman Takdir tetap yang diterapkan, Efek meningkat sebesar [Layer]%."
  },
  State_141993_Name = {
    Text = "Kartu perintah Berwarna-warni"
  },
  State_141994_Desc = {
    Text = "Setelah play kartu, setelah melepaskan Exalt menyebabkan Kerusakan, mendapatkan Perisai, penyembuhan, menerapkan Strength, Drain, Kerusakan tentakel, Racun, Counter, Penghakiman Takdir, Racun tetap, Counter tetap, Penghakiman Takdir tetap."
  },
  State_141994_Name = {
    Text = "Perintah Pemicu Warna-warni"
  },
  State_142018_Desc = {
    Text = "Saat giliran dimulai, dapat 1 lapisan <Guaiwucanhai: Puing-puing>"
  },
  State_142018_Name = {
    Text = "Undangan ke Istana Raja"
  },
  State_142057_Desc = {
    Text = "Setelah menggunakan Posse, beralih niat sendiri, setelah pertarungan dimulai Tingkat Muatan Kunci Perak semua Awakener meningkat 25%."
  },
  State_142057_Name = {
    Text = "Pencerahan Sebab Akibat"
  },
  State_142058_Desc = {
    Text = "Kerusakan Dasar, Racun, dan Counter yang ditimbulkan berkurang [DescArg1]%"
  },
  State_142058_Name = {
    Text = "Sayap Kotor"
  },
  State_142060_Desc = {
    Text = "Setiap kali musuh menggunakan Kartu perintah, diri sendiri mendapatkan 1 tumpukan Kegilaan Sementara. Saat Kegilaan Sementara mencapai 10 tumpukan, setelah Kartu perintah berikutnya di-play, diri sendiri langsung beraksi dan menghapus semua Kegilaan Sementara."
  },
  State_142060_Name = {
    Text = "Echo Jurang"
  },
  State_142062_Desc = {
    Text = "Setiap kali efek awal 0246 bersifat acak"
  },
  State_142062_Name = {Text = "Niat Acak"},
  State_142063_Desc = {
    Text = "Dalam giliran sendiri, Kerusakan yang diterima berkurang [DescArg1]%."
  },
  State_142063_Name = {Text = "Sayap Suci"},
  State_142065_Desc = {
    Text = "Dihapus saat giliran dimulai. Saat mencapai 10 tumpukan, setelah Kartu perintah berikutnya di-play, diri sendiri langsung beraksi dan menghapus semua Kegilaan Sementara."
  },
  State_142065_Name = {
    Text = "Kegilaan Sementara"
  },
  State_142066_Desc = {
    Text = "Efek <WeaknessIconKeywords:kelemahan>, <FragileIconKeywords:rapuh>, dan <HeavyInjuryKeywords:luka berat> yang diberikan ditingkatkan menjadi 50%."
  },
  State_142066_Name = {
    Text = "Ilham Esensial"
  },
  State_142067_Desc = {
    Text = "Kerusakan Kekuatan, Counter, dan tentakel yang ditimbulkan berkurang [DescArg1]%"
  },
  State_142067_Name = {
    Text = "Sayap Terkutuk"
  },
  State_142072_Desc = {
    Text = "Setiap kali menerima kerusakan atau kehilangan HP, tidak dapat melebihi 5% dari Max HP."
  },
  State_142072_Name = {
    Text = "Ambang Batas Tahan Sakit"
  },
  State_142091_Desc = {
    Text = "Hitungan Pelipatan Enam Sayap"
  },
  State_142091_Name = {
    Text = "Hitungan Pelipatan Enam Sayap"
  },
  State_142092_Desc = {
    Text = "Tingkat Muatan Kunci Perak semua Awakener meningkat 25%."
  },
  State_142092_Name = {
    Text = "Pencerahan Sebab Akibat"
  },
  State_142093_Desc = {
    Text = "Progres konsumsi Pelipatan Enam Sayap: [DescArg1], Nilai cedera yang dibutuhkan saat ini: [DescArg2]."
  },
  State_142093_Name = {
    Text = "Pelipatan Enam Sayap"
  },
  State_142095_Desc = {
    Text = "Penanda Pelipatan Enam Sayap"
  },
  State_142095_Name = {
    Text = "Penanda Pelipatan Enam Sayap"
  },
  State_142166_Desc = {
    Text = "Efek spesifik lihat logika pukulan umum.__\"Khusus pengembangan\""
  },
  State_142213_Name = {
    Text = "Turunkan batas Aritmetika"
  },
  State_142215_Desc = {
    Text = "Jika pada awal giliran berikutnya masih dalam kondisi mati, maka akan bangkit kembali dan mendapatkan Perisai sebesar [StateArg1], tidak dapat diusir."
  },
  State_142215_Name = {
    Text = "Obsesi Abadi"
  },
  State_142228_Desc = {
    Text = "Kartu ini diciptakan oleh Roda takdir \"Jatuh ke Atas\"."
  },
  State_142228_Name = {
    Text = "Jatuh ke Atas"
  },
  State_142229_Desc = {
    Text = "Tim Unik: Setelah eksplorasi dimulai, tambahkan 1 kartu \"Berkelana di Negeri Ajaib\" ke dalam dek. \"Berkelana di Negeri Ajaib\": Konsumsi 2 poin Arithmetica, buat Pemakai mendapatkan <WeaponEffect_Num:[StateArg1]> poin Aliemus dan 3 lapis <Yishiganshe:\"Gangguan Kesadaran\">. <RetainIconKeywords:Retain>. <DepleteIconKeywords:Konsumsi>."
  },
  State_142229_Name = {
    Text = "Berkelana di Negeri Ajaib"
  },
  State_142229_WeaponDesc = {
    Text = "Setelah eksplorasi dimulai, tambahkan 1 kartu \"Berkelana di Negeri Ajaib\" ke dalam dek. \"Berkelana di Negeri Ajaib\": Konsumsi 2 poin Arithmetica, buat Pemakai mendapatkan <WeaponEffect_Num:[StateArg1]> poin Aliemus dan 3 lapis <Yishiganshe:\"Gangguan Kesadaran\">. <RetainIconKeywords:Retain>. <DepleteIconKeywords:Konsumsi>."
  },
  State_142452_Desc = {
    Text = "Efek STR▼ yang diterima berkurang 50%."
  },
  State_142452_Name = {
    Text = "Keberadaan Abadi"
  },
  State_142663_Desc = {
    Text = "Pada awal giliran berikutnya, dapatkan <DelayKeywords:Latensi>: [Layer] Aliemus."
  },
  State_142663_Name = {
    Text = "Latensi Aliemus Tertunda"
  },
  State_142688_Desc = {
    Text = "Roda takdir yang dipasang pada target menjadi tidak aktif, tidak dapat diusir."
  },
  State_142688_Name = {
    Text = "Entwined Super"
  },
  State_142692_Desc = {
    Text = "Sedang muncul ide-ide kecil yang baru."
  },
  State_142692_Name = {
    Text = "Ide Cemerlang"
  },
  State_142715_Desc = {
    Text = "Kerusakan \"skill\" ini meningkat sebesar [DescArg1]%, setiap 1 poin Arithmetica yang dibutuhkan skill ini menambah [StateArg1]%."
  },
  State_142715_Name = {
    Text = "Kematian berwarna amber"
  },
  State_142887_Desc = {
    Text = "Jika pada giliran ini menerima \"Paralysis\" kembali, semua \"Pukulan\" miliknya berubah menjadi \"Ilusi\", tidak dapat diusir, berlangsung hingga akhir giliran."
  },
  State_142887_Name = {
    Text = "Agak Mati Rasa"
  },
  State_142954_Desc = {
    Text = "Arithmetica Limit minimal adalah 0, pada awal setiap giliran jika kurang dari 10 akan bertambah 1. Setelah mencapai 10, mendapatkan Arithmetica Limit tambahan akan dikonversi menjadi menarik kartu dalam jumlah yang sama."
  },
  State_142954_Name = {
    Text = "Arithmetica Limit"
  },
  State_143002_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Belum dikonfigurasi"
  },
  State_143002_Name = {
    Text = "Satogua SR (teks sementara)"
  },
  State_143004_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Belum dikonfigurasi"
  },
  State_143004_Name = {
    Text = "Senjata Khusus Satogua (Teks Sementara)"
  },
  State_143005_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Belum dikonfigurasi"
  },
  State_143005_Name = {
    Text = "Lantigos SR (teks sementara)"
  },
  State_143006_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Belum dikonfigurasi"
  },
  State_143006_Name = {
    Text = "Senjata Khusus Firaun Hitam (Teks Sementara)"
  },
  State_143007_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat dipasang dan saat awal giliran, memberikan [StateArg1] <PVPCompassKeywords:Kompas Sesat> kepada musuh secara acak."
  },
  State_143007_Name = {
    Text = "Kompas Penunjuk Jalan Sesat"
  },
  State_143008_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Belum dikonfigurasi"
  },
  State_143008_Name = {
    Text = "Senjata Khusus Burung Shatak (Teks Sementara)"
  },
  State_143009_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Belum dikonfigurasi"
  },
  State_143009_Name = {
    Text = "Senjata Khusus Afrgomon (Teks Sementara)"
  },
  State_143010_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Maximum Hand Size+ [StateArg1], saat pemakai atau sekutu mati, Kartu mereka tidak lagi diubah menjadi <PVPDerivativeCardKeywords_2:\"Ilusi\">, melainkan diubah menjadi <PVPDerivativeCardKeywords_30:\"Rampas-Gaunt\">."
  },
  State_143010_Name = {
    Text = "Sangkar Tahanan Hidup"
  },
  State_143011_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Belum dikonfigurasi"
  },
  State_143011_Name = {
    Text = "Burung Nasar SR (Teks Sementara)"
  },
  State_143012_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Belum dikonfigurasi"
  },
  State_143012_Name = {
    Text = "Burung Shatack SR (teks sementara)"
  },
  State_143013_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Belum dikonfigurasi"
  },
  State_143013_Name = {
    Text = "Genesis Ogier SR (Teks Sementara)"
  },
  State_143014_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Sebelum \"Exalt\" kehilangan 25% HP saat ini; Setelah \"Exalt\" memberikan [StateArg1] Kerusakan kepada semua musuh dan Menyerap HP sejumlah yang sama."
  },
  State_143014_Name = {
    Text = "Muslihat Manis"
  },
  State_143016_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Belum dikonfigurasi"
  },
  State_143016_Name = {
    Text = "Firaun Hitam SR (teks sementara)"
  },
  State_143017_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Belum dikonfigurasi"
  },
  State_143017_Name = {
    Text = "Senjata Khusus Lantigos (Teks Sementara)"
  },
  State_143018_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Belum dikonfigurasi"
  },
  State_143018_Name = {
    Text = "Genesis Tulu SR (teks sementara)"
  },
  State_143019_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setelah \"Exalt\", berikan [StateArg1] tumpukan <PVPBless:Berkat> kepada semua musuh."
  },
  State_143019_Name = {
    Text = "Kebenaran yang Menyenangkan"
  },
  State_143020_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Belum dikonfigurasi"
  },
  State_143020_Name = {
    Text = "Senjata Khusus Genesis Ogier (Teks Sementara)"
  },
  State_143022_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Belum dikonfigurasi"
  },
  State_143022_Name = {
    Text = "Senjata Khusus Burung Bangkai (Teks Sementara)"
  },
  State_143023_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Belum dikonfigurasi"
  },
  State_143023_Name = {
    Text = "Aphgormon SR (teks sementara)"
  },
  State_143326_Desc = {
    Text = "Keyflare Regen meningkat [DescArg1]."
  },
  State_143326_Name = {
    Text = "Pencerahan Sebab Akibat"
  },
  State_143331_Desc = {
    Text = "Sebelum ronde berikutnya berakhir, menanggung setengah Kerusakan untuk <StatusApplier:>, status ini Tim Unik per tim, efek dihapus ketika salah satu dari kedua pihak yang terikat mati, tidak dapat diusir."
  },
  State_143331_Name = {
    Text = "Menanggung Kerusakan"
  },
  State_143333_Desc = {
    Text = "Sebelum ronde berikutnya dimulai, <StatusApplier:> menanggung setengah Kerusakan untuknya, status ini Tim Unik per tim, efek dihapus ketika salah satu dari kedua pihak yang terikat mati, tidak dapat diusir."
  },
  State_143333_Name = {
    Text = "Kerusakan Dialihkan"
  },
  State_143336_Desc = {
    Text = "Memberikan Berlaku tambahan 1 kali kepada \"Budak-Gaunt\". Saat mem-play \"Budak-Gaunt\", konsumsi 1 tumpukan, batas maksimal 9 tumpukan, tidak dihapus saat pertempuran berakhir."
  },
  State_143336_Name = {
    Text = "<BattueKeywords:Pemburuan>"
  },
  State_143340_Desc = {
    Text = "Memberikan Berlaku tambahan 1 kali kepada \"Budak-Gaunt\". Saat mem-play \"Budak-Gaunt\", konsumsi 1 tumpukan, batas maksimal 9 tumpukan, tidak dihapus saat pertempuran berakhir."
  },
  State_143340_Name = {
    Text = "<BattueKeywords:Pemburuan>"
  },
  State_143386_Desc = {
    Text = "Menanggung setengah Kerusakan untuk <StatusApplier:>, tidak dapat diusir."
  },
  State_143386_Name = {
    Text = "Menanggung Kerusakan"
  },
  State_143387_Desc = {
    Text = "<StatusApplier:> menanggung setengah Kerusakan untuknya, tidak dapat diusir."
  },
  State_143387_Name = {
    Text = "Kerusakan Dialihkan"
  },
  State_143406_Name = {
    Text = "Kartu ini berlaku tambahan [DescArg1] kali"
  },
  State_143408_Desc = {
    Text = "Saat diserang oleh Awakener musuh, dikonversikan menjadi [Layer] Aliemus penyerang."
  },
  State_143408_Name = {
    Text = "Kompas Penunjuk Jalan Sesat"
  },
  State_143409_Desc = {
    Text = "Saat diserang oleh Awakener musuh, konversikan stacks dalam jumlah yang sama menjadi Aliemus penyerang."
  },
  State_143409_Name = {
    Text = "<CardKeyWord:Kompas Penunjuk Jalan Sesat>"
  },
  State_143419_Desc = {
    Text = "Kartu ini berasal dari <PVPDerivativeCardKeywords_31:\"Harta Karun Aurita\">."
  },
  State_143419_Name = {
    Text = "Harta Karun Aurita"
  },
  State_143426_Desc = {
    Text = "Setelah ronde dimulai, kurangi [Layer] Arithmetica, tidak dapat diusir."
  },
  State_143426_Name = {
    Text = "Pengurangan Arithmetica Tertunda"
  },
  State_143441_Desc = {
    Text = "Tubuh Terjaga yang dipilih pada putaran operasi ke-[StateArg1]."
  },
  State_143441_Name = {
    Text = "Tanda Uji 1"
  },
  State_143442_Desc = {
    Text = "Tubuh Terjaga yang dipilih pada putaran operasi ke-[StateArg1]."
  },
  State_143442_Name = {
    Text = "Tanda Uji 2"
  },
  State_143444_Desc = {
    Text = "Tubuh Terjaga yang dipilih pada putaran operasi ke-[StateArg1]."
  },
  State_143444_Name = {
    Text = "Tanda Uji 4"
  },
  State_143445_Desc = {
    Text = "Tubuh Terjaga yang dipilih pada putaran operasi ke-[StateArg1]."
  },
  State_143445_Name = {
    Text = "Tanda Uji 3"
  },
  State_143499_Name = {
    Text = "Imun Active DMG__\"Hanya untuk pengembangan\""
  },
  State_143500_Name = {
    Text = "Imun Kerusakan Murni__\"Hanya untuk pengembangan\""
  },
  State_143541_Desc = {
    Text = "Kerusakan yang ditimbulkan semua musuh pada giliran ini berkurang [DescArg1]%, dapatkan [DescArg2] poin Strength."
  },
  State_143541_Name = {Text = "Penjaga"},
  State_143542_Desc = {
    Text = "Temporary Final DMG +[DescArg1]%, dan menimbulkan Corrosion sebesar [DescArg2]% Max HP kepada semua musuh."
  },
  State_143542_Name = {Text = "Berburu"},
  State_143548_Desc = {
    Text = "Memberikan Perisai dan menambahkan Negara, monster, cabang 1."
  },
  State_143548_Name = {
    Text = "Perisai Monster Cabang 1"
  },
  State_143549_Desc = {
    Text = "Memberikan Perisai dan menambahkan Negara, Awakener, cabang 2."
  },
  State_143549_Name = {
    Text = "Perisai Karakter Cabang 2"
  },
  State_143550_Desc = {
    Text = "Memberikan Perisai dan menambahkan Negara, Awakener, cabang 1."
  },
  State_143550_Name = {
    Text = "Perisai Karakter Cabang 1"
  },
  State_143551_Desc = {
    Text = "Memberikan Perisai dan menambahkan Negara, monster, cabang 2."
  },
  State_143551_Name = {
    Text = "Perisai Monster Cabang 2"
  },
  State_143552_Desc = {
    Text = "Memberikan Perisai dan menambahkan Negara, pemain, cabang 1."
  },
  State_143552_Name = {
    Text = "Perisai Pemain Cabang 1"
  },
  State_143553_Desc = {
    Text = "Memberikan Perisai dan menambahkan Negara, pemain, cabang 2."
  },
  State_143553_Name = {
    Text = "Perisai Pemain Cabang 2"
  },
  State_143573_Desc = {
    Text = "Budak-Gaunt adalah kartu buff Pontos yang mencakup \"Serbu-Gaunt\" \"Kacaukan-Gaunt\" \"Habisi-Gaunt\", terdiri dari 3 jenis. Saat membuat \"Budak-Gaunt\" permanen, jika \"Budak-Gaunt\" melebihi 6 kartu, \"Budak-Gaunt\" permanen secara acak akan ditingkatkan menjadi \"Gaunt, Bersatu\" dengan Arithmetica Cost +1 namun Berlaku tambahan 1 kali, \"Gaunt, Bersatu\" dianggap sebagai 2 kartu \"Budak-Gaunt\" dalam deck. Jika semua \"Budak-Gaunt\" telah ditingkatkan, masukkan 1 \"Intuisi Tinggi\" dengan <DestructionKeywords:Destroy> ke tangan."
  },
  State_143573_Name = {
    Text = "Budak-Gaunt"
  },
  State_143578_Desc = {
    Text = "Dalam giliran ini, setiap kali menerima Active DMG, masukkan [Layer] kartu <PVPDerivativeCardKeywords_30:\"Mimpi Buruk Terkurung\"> ke dalam Hand."
  },
  State_143578_Name = {
    Text = "Ritual Tuan"
  },
  State_143595_Desc = {
    Text = "Kartu ini telah ditambahkan <PrepareKeywords:Prepare> [StateArg1]."
  },
  State_143595_Name = {
    Text = "Tarian Angsa Hitam"
  },
  State_143597_Desc = {
    Text = "Tim Unik: Efek STR▼ yang diberikan Pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Saat beralih ke sikap \"Ombak Bergelora\", Kerusakan Kritis Sementara meningkat, peningkatannya setara dengan <WeaponEffect_Num:[StateArg1]%> dari Crit. DMG dasar diri sendiri, cooldown 3 ronde."
  },
  State_143597_WeaponDesc = {
    Text = "Efek STR▼ yang diberikan Pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah beralih ke sikap \"Ombak Bergelora\", Kerusakan Kritis Sementara meningkat sebesar <WeaponEffect_Num:[DescArg1]%>, cooldown 3 ronde."
  },
  State_143598_Desc = {
    Text = "Tim Unik: Efek STR▼ yang diberikan Pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>, setiap membunuh 1 musuh membuat Aliemus yang dipulihkan secara tetap di akhir ronde eksplorasi sesi ini meningkat 2 poin, maksimal ditumpuk sebanyak <WeaponEffect_Num:[StateArg2]> kali. Setelah beralih ke sikap \"Ombak Bergelora\", Kerusakan Kritis Sementara meningkat, peningkatannya setara dengan <WeaponEffect_Num:[StateArg1]%> dari Crit. DMG dasar diri sendiri, cooldown 3 ronde."
  },
  State_143598_WeaponDesc = {
    Text = "Efek STR▼ yang diberikan Pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>, setiap membunuh 1 musuh membuat Aliemus yang dipulihkan secara tetap di akhir ronde eksplorasi sesi ini meningkat 2 poin, maksimal ditumpuk sebanyak <WeaponEffect_Num:[StateArg2]> kali. Setelah beralih ke sikap \"Ombak Bergelora\", Kerusakan Kritis Sementara meningkat sebesar <WeaponEffect_Num:[DescArg1]%>, cooldown 3 ronde."
  },
  State_143683_Desc = {
    Text = "Pengejaran Awakener ini di-Sealed dan tidak dapat digunakan, Sealed akan berakhir setelah [Layer] ronde."
  },
  State_143683_Name = {
    Text = "<Seal1:Pengejaran Sealed>"
  },
  State_144381_Desc = {
    Text = "Tidak dapat melakukan Aksi, tersisa [DescArg1] giliran."
  },
  State_144381_Name = {
    Text = "<Yishiganshe:Interferensi Kesadaran>"
  },
  State_144441_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat anggota tim mati, diri sendiri mendapatkan <Energy:[Energy:StateArg1]> Aliemus. Saat anggota tim bangkit kembali, mereka mendapatkan <Energy:[Energy:StateArg2]> Aliemus. Efek perolehan Aliemus hanya berlaku saat Aliemus target belum penuh, berlaku selama [Layer] kali lagi, setelah habis Roda takdir ini akan Destroy."
  },
  State_144441_Name = {
    Text = "Sinkronisasi Jiwa"
  },
  State_144494_Desc = {
    Text = "Terdapat 7 jenis Efek, meliputi: Draw 8 kartu, dapatkan 6 poin Arithmetica, dapatkan Keyflare, semua Awakener mendapatkan Aliemus tetap, dapatkan kekuatan, sementara menurunkan kekuatan semua musuh, sementara meningkatkan DMG Amplification."
  },
  State_144494_Name = {
    Text = "<Blessing:Hadiah>"
  },
  State_144508_Desc = {
    Text = [[
"Bayaran" terdiri dari 3 jenis, yaitu "Kesempatan Terlewatkan", "Kata-kata Indah Yang Menipu", dan "Kejahatan Terselubung".
"Kesempatan Terlewatkan": Mendapatkan Efek "Hadiah" setelah 2 ronde.
"Kata-kata Indah Yang Menipu": Efek "Hadiah" berkurang 50%.
"Kejahatan Terselubung": Memberikan diri sendiri 1 jenis Efek acak yang berbeda: Weakness 2 ronde, Fragile 2 ronde, Blighten 2 ronde, Racun setara 1% dari Max HP diri sendiri, 2 stacks Void, 2 kartu acak di tangan mendapat 1 stacks Stagnation, menghasilkan 2 Kartu gejala Sementara (tidak diwariskan lintas pertempuran) dan dimasukkan ke bagian atas Menggambar.]]
  },
  State_144508_Name = {
    Text = "<BlessingNegativeEffect:Bayaran>"
  },
  State_144519_Desc = {
    Text = "Variabel proses uji, disegarkan setelah ronde dimulai atau setelah Kartu di-play. Saat ini memiliki [Layer] Jiwa Realm."
  },
  State_144519_Name = {
    Text = "Jiwa Realm Chaos Baru"
  },
  State_145228_Name = {
    Text = "<WormGrowth:Santap Kenyang>"
  },
  State_145229_Desc = {
    Text = "Kamu juga bagian dari Berkah ini~. Dapat dikonsumsi oleh Exalt Caraboo untuk mendapatkan buff, Negara ini maksimal menumpuk hingga 5 stacks. Tidak dihapus setelah pertempuran berakhir"
  },
  State_145229_Name = {
    Text = "<SacrificialMark:Persembahan>"
  },
  State_145436_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Kerusakan \"Pukulan\" ditingkatkan [DescArg1]%, setiap \"Pukulan\" Kerusakan tambahan ditingkatkan [StateArg2]%, maksimal ditingkatkan hingga [StateArg3]%."
  },
  State_145436_Name = {
    Text = "Kerangka Hasrat Abadi"
  },
  State_145437_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat dipasang mendapatkan [StateArg2] tumpukan <EnergyStorageKeywords:Charge>, Kerusakan \"Pukulan\" ditingkatkan [StateArg1]% dan diubah menjadi <PVPPunctureDamagewords:Pierce DMG>."
  },
  State_145437_Name = {
    Text = "Kematian Cetus"
  },
  State_145456_Desc = {
    Text = "Saat memilih target akan mengabaikan Taunt, Sembunyi-sembunyi, dan Kunci. Jika beberapa target memiliki kondisi yang sama, prioritaskan memilih Awakener yang berada di posisi paling depan."
  },
  State_145456_Name = {
    Text = "HP dan Perisai Terendah"
  },
  State_145457_Desc = {
    Text = "Saat memilih target akan mengabaikan Taunt, Sembunyi-sembunyi, dan Kunci. Jika beberapa target memiliki kondisi yang sama, prioritaskan memilih Awakener yang berada di posisi paling depan."
  },
  State_145457_Name = {
    Text = "HP dan Perisai Tertinggi"
  },
  State_145495_Desc = {
    Text = "Kartu ini dimainkan oleh Tembakan Ganda."
  },
  State_145495_Name = {
    Text = "<CardKeyWord:Tembakan Ganda>"
  },
  State_145554_Desc = {
    Text = "Unik Tim: Setelah eksplorasi dimulai, tambahkan 1 kartu <Falltospace1[StateArg3]:「Menginjakkan Kaki di Dunia」> ke dalam dek. 「Menginjakkan Kaki di Dunia」: Mengonsumsi 0 daya komputasi. Memberikan <WeaponEffect_Num:[StateArg1]%> serangan pemakai serta <WeaponEffect_Num:[Float:StateArg4]%> HP maksimum sebagai kerusakan <Corrosion:erosi> tetap kepada semua musuh, membuat kartu perintah Awakened lain di setiap posisi mendapatkan efek <ErosionColorInkKeywords:kekacauan kognitif> dan mengocok 1 kartu <Falltospace2[StateArg3]:「Jatuh ke Atas」> ke dalam tumpukan kartu. <RetainIconKeywords:Pertahankan>. <DepleteIconKeywords:Konsumsi>."
  },
  State_145554_Name = {
    Text = "Jatuh ke Atas"
  },
  State_145554_WeaponDesc = {
    Text = "Setelah eksplorasi dimulai, tambahkan 1 kartu<Falltospace1[StateArg3]:\"Menginjakkan Kaki di Dunia\"> ke dalam dek. \"Menginjakkan Kaki di Dunia\": Menggunakan 0 Arithmetica. Memberikan <WeaponEffect_Num:[StateArg1]%> ATK pemakai dan <WeaponEffect_Num:[Float:StateArg4]%> Max HP sebagai <Corrosion:Corrosion> tetap kepada semua musuh, membuat Kartu perintah Tubuh Terjaga lainnya di setiap lokasi mendapatkan <ErosionColorInkKeywords:Kekacauan Kognisi> dan Shuffle 1 kartu<Falltospace2[StateArg3]:\"Jatuh ke Atas\"> ke Menggambar. <RetainIconKeywords:Retain>. <DepleteIconKeywords:Lelah>"
  },
  State_145572_Desc = {
    Text = "Setiap Mulai ronde, semua Awakener lainnya memberikan <Damage:[Damage:Layer]> Pierce DMG."
  },
  State_145572_Name = {
    Text = "Badai Pelahap Cetus"
  },
  State_145590_Desc = {
    Text = "Saat Kartu yang sama dengan kepemilikan yang sama dimasukkan ke tangan akan memicu Efek Fusi dan mengonsumsi Kartu tersebut."
  },
  State_145590_Name = {
    Text = "<CardKeyWord:Fusi>"
  },
  State_145592_Desc = {
    Text = "Mengunci satu musuh, menjadikannya sebagai target serangan prioritas, saat memilih target tunggal hanya dapat memilih target yang dikunci, mengabaikan Taunt dan sembunyi."
  },
  State_145592_Name = {
    Text = "<CardKeyWord:Kunci>"
  },
  State_145619_Name = {Text = "Blighten"},
  State_145620_Name = {Text = "Void"},
  State_145621_Desc = {
    Text = "Efek \"Hadiah\" berkurang 50%."
  },
  State_145621_Name = {
    Text = "<Bleesing_Exaggerate:Kata-kata Indah Yang Menipu>"
  },
  State_145622_Name = {Text = "Stagnation"},
  State_145623_Desc = {
    Text = "Memberikan diri sendiri 1 jenis Efek acak yang berbeda: Weakness 2 ronde, Fragile 2 ronde, Blighten 2 ronde, memberikan Racun setara 1% dari Max HP, 2 stacks Void, 2 kartu acak di tangan mendapat 1 stacks Stagnation, menghasilkan 2 Kartu gejala Sementara (tidak diwariskan lintas pertempuran) dan dimasukkan ke bagian atas Menggambar."
  },
  State_145623_Name = {
    Text = "<Bleesing_Negative:Kejahatan Terselubung>"
  },
  State_145624_Name = {Text = "Weakness"},
  State_145625_Name = {
    Text = "2 \"Kartu gejala\" Sementara yang sama"
  },
  State_145626_Name = {Text = "Fragile"},
  State_145627_Name = {Text = "Racun"},
  State_145628_Desc = {
    Text = "Setelah 2 ronde, dapatkan efek \"Hadiah\"."
  },
  State_145628_Name = {
    Text = "<Bleesing_Delay:Kesempatan Terlewat>"
  },
  State_145631_Desc = {
    Text = "Kerusakan \"Pukulan\" ditingkatkan [StateArg1]% dan diubah menjadi <PVPPunctureDamagewords:Pierce DMG>."
  },
  State_145631_Name = {
    Text = "Kematian Cetus"
  },
  State_145632_Desc = {
    Text = "Kartu ini berasal dari Roda takdir \"Waktu Keberuntungan\"."
  },
  State_145632_Name = {
    Text = "Waktu Keberuntungan"
  },
  State_145638_Desc = {
    Text = "Arithmetica Cost kartu ini meningkat sebesar [Layer]."
  },
  State_145638_Name = {
    Text = "Penghormatan Kejam"
  },
  State_145642_Desc = {
    Text = "Setelah 2 ronde, semua Awakener mendapatkan [StateArg1] Aliemus sebanyak [Layer] kali."
  },
  State_145642_Name = {
    Text = "Aliemus Tertunda"
  },
  State_145644_Desc = {
    Text = "Setelah 2 ronde, dapatkan <Posse:[StateArg1]> Keyflare sebanyak [Layer] kali."
  },
  State_145644_Name = {
    Text = "Keyflare Latensi"
  },
  State_145645_Desc = {
    Text = "Setelah 2 ronde, kurangi sementara [StateArg1] poin <ExhaustionIconKeywords:Kekuatan> semua musuh sebanyak [Layer] kali"
  },
  State_145645_Name = {
    Text = "Penurunan Tertunda"
  },
  State_145646_Desc = {
    Text = "Setelah 2 ronde, dapatkan [StateArg1] Arithmetica sebanyak [Layer] kali."
  },
  State_145646_Name = {
    Text = "Negara Tertunda Aritmetika"
  },
  State_145647_Desc = {
    Text = "Setelah 2 ronde, dapatkan [StateArg1] poin <PowerIconKeywords:Kekuatan> sebanyak [Layer] kali."
  },
  State_145647_Name = {
    Text = "Kekuatan Latensi"
  },
  State_145648_Desc = {
    Text = "Setelah 2 ronde, Draw [StateArg1] kartu sebanyak [Layer] kali."
  },
  State_145648_Name = {
    Text = "Tirage tertunda"
  },
  State_145649_Desc = {
    Text = "Setelah 2 ronde, DMG Amplification sementara [StateArg1]% sebanyak [Layer] kali."
  },
  State_145649_Name = {
    Text = "Latensi DMG Amplification Sementara"
  },
  State_145652_Desc = {
    Text = "Biaya konsumsi kartu ini -[Layer]."
  },
  State_145652_Name = {
    Text = "Kebebasan yang Menyiksa"
  },
  State_145654_Desc = {
    Text = "Uji. Setelah di-play, atau setelah meninggalkan Hand, Destroy."
  },
  State_145654_Name = {
    Text = "Uji. Sejenak"
  },
  State_145660_Desc = {
    Text = [=[
Kami
1.<AllyPosAwaker1Name:> [DescArg1]
2.<AllyPosAwaker2Name:> [DescArg2]
3.<AllyPosAwaker3Name:> [DescArg3]
4.<AllyPosAwaker4Name:> [DescArg4]
Musuh
1.<EnemyPosAwaker1Name:> [DescArg5]
2.<EnemyPosAwaker2Name:> [DescArg6]
3.<EnemyPosAwaker3Name:> [DescArg7]
4.<EnemyPosAwaker4Name:> [DescArg8]]=]
  },
  State_145660_Name = {
    Text = "Perubahan HP Setelah Penelusuran Balik"
  },
  State_145693_Desc = {
    Text = "Setelah ronde berakhir, konsumsi aritmetika -[Layer], Efek ini juga akan terpicu setelah dibuang."
  },
  State_145693_Name = {
    Text = "<PrepareKeypvewordscolour:Persiapan[Layer]>"
  },
  State_145693_WeaponDesc = {
    Text = "Kartu tidak akan masuk ke tumpukan kartu buang selama fase pembuangan, melainkan tetap berada di tangan."
  },
  State_145694_Name = {
    Text = "Bersimbiosis dengan Rawa Hitam"
  },
  State_145698_Desc = {
    Text = "Prioritas menyerang <StatusApplier:> yang terkunci, saat memilih target tunggal hanya dapat memilih target yang terkunci, mengabaikan Taunt dan sembunyi."
  },
  State_145698_Name = {Text = "Kunci"},
  State_145699_Desc = {
    Text = "·Prioritas menyerang <StatusApplier:> yang terkunci, saat memilih target tunggal hanya dapat memilih target yang terkunci, mengabaikan Taunt dan sembunyi.\n·Setelah diri sendiri mati, <StatusApplier:> mendapatkan \"<PVPDerivativeCardKeywords_32:Ayo Bertarung!>\"."
  },
  State_145699_Name = {Text = "Kunci"},
  State_145709_Desc = {
    Text = "Setiap stacks meningkatkan batas HP sebesar 10% CON Caraboo, \"Kepuasan\" maksimal ditumpuk hingga 50 stacks. Jika saat mendapatkan Negara ini sudah mencapai batas, setiap 1 stacks yang melebihi batas akan diganti dengan memulihkan HP sebesar 3 kali lipat jumlah yang setara. Setiap Pertarungan non-Pemimpin maksimal mendapatkan 10 stacks \"Kepuasan\". Tidak dihapus saat pertarungan berakhir."
  },
  State_145709_Name = {
    Text = "<WormGrowth:Santap Kenyang>"
  },
  State_145710_Desc = {
    Text = "Kamu juga bagian dari Berkah ini~. Dapat dikonsumsi oleh Exalt Caraboo untuk mendapatkan buff, Negara ini maksimal menumpuk hingga 5 stacks. Tidak dihapus setelah pertempuran berakhir"
  },
  State_145710_Name = {
    Text = "<SacrificialMark:Persembahan>"
  },
  State_145901_Desc = {
    Text = [=[
Pihak kami
1.<AllyPosAwaker1Name:> [DescArg1]
2.<AllyPosAwaker2Name:> [DescArg2]
3.<AllyPosAwaker3Name:> [DescArg3]
4.<AllyPosAwaker4Name:> [DescArg4]]=]
  },
  State_145901_Name = {
    Text = "Perubahan HP Setelah Penelusuran Balik"
  },
  State_146041_Desc = {
    Text = "Tubuh Terjaga ini merasa terlepas dari keramaian dunia.\n·Tidak dapat melakukan Aksi apapun sebelum giliran berakhir, mengurangi 99% Kerusakan, jika target tidak memiliki Resistance maka target akan mendapatkan Resistance.\n·Saat efek berakhir, memberikan <Damage:[Layer]> Kerusakan Murni kepada semua sekutu.\n·Jika target memiliki Resistance saat efek diberikan, Tipu Daya langsung berakhir dan Kerusakan terhadap target berlipat ganda."
  },
  State_146041_Name = {Text = "Tipu Daya"},
  State_146043_Desc = {
    Text = "Saat giliran berikutnya dimulai, kurangi [Layer] Aliemus."
  },
  State_146043_Name = {
    Text = "Pengurangan Aliemus Tertunda"
  },
  State_146058_Desc = {
    Text = "Variabel proses uji, disegarkan setelah ronde dimulai atau setelah Kartu di-play. Saat ini seharusnya memiliki efek serangan [Layer]%."
  },
  State_146058_Name = {
    Text = "Efek Serangan Posse"
  },
  State_146059_Desc = {
    Text = "Variabel proses uji, disegarkan setelah ronde dimulai atau setelah Kartu di-play. Saat ini seharusnya memiliki efek pertahanan [Layer]%."
  },
  State_146059_Name = {
    Text = "Efek Pertahanan Posse"
  },
  State_146079_Desc = {
    Text = "Setelah Kartu ini meninggalkan hand, akan kembali ke tangan."
  },
  State_146079_Name = {
    Text = "<Recycle:Kembali ke Tangan>"
  },
  State_146085_Desc = {
    Text = "Ubah Arithmetica Kartu Sebelum Dimainkan Pada Giliran Ini"
  },
  State_146085_Name = {
    Text = "Ubah Arithmetica Kartu Sebelum Dimainkan Pada Giliran Ini"
  },
  State_146085_WeaponDesc = {
    Text = "Mengubah aritmetika kartu sebelum bermain"
  },
  State_146086_Desc = {
    Text = "Ubah Arithmetica Kartu Sebelum Dimainkan Pada Giliran Ini"
  },
  State_146086_Name = {
    Text = "Ubah Arithmetica Kartu Sebelum Dimainkan Pada Giliran Ini"
  },
  State_146086_WeaponDesc = {
    Text = "Mengubah aritmetika kartu sebelum bermain"
  },
  State_146117_Desc = {
    Text = "Dapat dikonsumsi oleh \"<DerivativeCardKeywords_157:Tulang Pedang>\" untuk mendapatkan buff. Status ini maksimal dapat ditumpuk hingga 15 tumpukan."
  },
  State_146117_Name = {
    Text = "<Shimieluotanhuodong2:Niat Bertarung>"
  },
  State_146129_Desc = {
    Text = "Final DMG semua Awakener +[Layer]%."
  },
  State_146129_Name = {
    Text = "Amukan Leviathan"
  },
  State_146147_Desc = {
    Text = "Dapat dikonsumsi oleh \"<DerivativeCardKeywords_157:Tulang Pedang>\" untuk mendapatkan buff. Status ini maksimal dapat ditumpuk hingga 15 tumpukan."
  },
  State_146147_Name = {
    Text = "<Shimieluotanhuodong1:Niat Bertarung>"
  },
  State_146154_Desc = {
    Text = "Membuat Awakener ini merasa baik, \"Skill\"-nya akan diubah menjadi \"Berkat?\", setelah diubah mengonsumsi jumlah layer yang sama."
  },
  State_146154_Name = {
    Text = "<PVPBlessColour:Berkat>"
  },
  State_146155_Desc = {
    Text = "Tubuh Terjaga ini merasa baik-baik saja.\n·Selanjutnya akan ada [Layer] Kartu \"Skill\" yang diubah menjadi \"Berkat?\", setelah diubah mengonsumsi stacks dalam jumlah yang sama."
  },
  State_146155_Name = {Text = "Berkat"},
  State_146155_WeaponDesc = {Text = "Tidak"},
  State_146202_Desc = {
    Text = "Membuat Awakener ini merasa terlepas dari keramaian dunia.\n·Tidak dapat melakukan Aksi apapun sebelum ronde berakhir, mengurangi 99% Kerusakan, jika target tidak memiliki Resistance maka target akan mendapatkan Resistance.\n·Saat Efek berakhir, memberikan Kerusakan Murni sejumlah layer yang sama kepada semua sekutu.\n·Jika saat diberikan target memiliki Resistance, maka Buai segera berakhir dan Kerusakan terhadap target berlipat ganda."
  },
  State_146202_Name = {
    Text = "<CardKeyWord:Buai>"
  },
  State_146352_Desc = {
    Text = "Setiap menerima 1 kali Kerusakan, tumpuk [StateArg1] stacks <Shimieluotanhuodong1:Niat Bertarung>"
  },
  State_146352_Name = {
    Text = "Amarah Penentang"
  },
  State_146363_Desc = {
    Text = "Saat ronde berikutnya dimulai, hapus [Layer] HP. Saat kehilangan HP, kurangi jumlah layer status ini sebesar yang sama."
  },
  State_146363_Name = {
    Text = "Yang Mana Bukan Tipuan"
  },
  State_146383_Desc = {
    Text = "Setelah menambahkan status, setelah memainkan kartu, segarkan dan cetak Tingkat Muatan Kunci Perak setiap Awakener."
  },
  State_146383_Name = {
    Text = "Pintu Masuk Efisiensi"
  },
  State_146384_Desc = {
    Text = "Nilai P1 [StateArg1], Nilai P2 [StateArg2], Nilai P3 [StateArg3], Nilai P4 [StateArg4]."
  },
  State_146384_Name = {
    Text = "Nilai Efisiensi"
  },
  State_146385_Desc = {
    Text = "Setelah menambahkan status, setelah memainkan kartu, segarkan dan cetak Tingkat Muatan Kunci Perak setiap Awakener."
  },
  State_146385_Name = {
    Text = "Pintu Masuk Tingkat"
  },
  State_146386_Desc = {
    Text = "Nilai P1 [StateArg1], Nilai P2 [StateArg2], Nilai P3 [StateArg3], Nilai P4 [StateArg4]."
  },
  State_146386_Name = {
    Text = "Nilai Tingkat"
  },
  State_146446_Desc = {
    Text = "DEF Tubuh Terjaga, P1: [StateArg1], P2: [StateArg2], P3: [StateArg3], P4: [StateArg4]."
  },
  State_146446_Name = {
    Text = "Daftar Atribut Pertahanan"
  },
  State_146448_Desc = {
    Text = "ATK Tubuh Terjaga, P1: Kekuatan[StateArg1] Intensitas[StateArg2], P2: Kekuatan[StateArg3] Intensitas[StateArg4], P3: Kekuatan[StateArg5] Intensitas[StateArg6], P4: Kekuatan[StateArg7] Intensitas[StateArg8]."
  },
  State_146448_Name = {
    Text = "Daftar Atribut Serangan"
  },
  State_146452_Desc = {
    Text = "Tim Unik: Crit. DMG \"Pukulan\" Pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Di akhir giliran, Crit. DMG Exalt berikutnya dari Pemakai meningkat, persentase peningkatan sama dengan <WeaponEffect_Num:[StateArg2]%> dari Aliemus Dasar-nya, dapat ditumpuk hingga 5 kali."
  },
  State_146452_WeaponDesc = {
    Text = "Crit. DMG \"Pukulan\" Pemakai meningkat <WeaponEffect_Num:[StateArg1]%>. Pada akhir giliran, Crit. DMG Exalt berikutnya dari Pemakai meningkat <WeaponEffect_Num:[DescArg1]%>, maksimal ditumpuk 5 kali (saat ini menikmati [DescArg2]%)."
  },
  State_146456_Desc = {
    Text = "Tim Unik: Crit. DMG \"Pukulan\" Pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>."
  },
  State_146456_WeaponDesc = {
    Text = "Crit. DMG \"Pukulan\" Pemakai meningkat <WeaponEffect_Num:[StateArg1]%>."
  },
  State_146534_Desc = {
    Text = "Setelah Tingkat dimulai, tambahkan wadah setiap mekanisme Chaos Awal kepada Penjaga."
  },
  State_146534_Name = {
    Text = "Inisialisasi Chaos Awal"
  },
  State_146535_Desc = {
    Text = "Wadah atribut."
  },
  State_146535_Name = {
    Text = "Penanda Chaos Awal"
  },
  State_146536_Desc = {
    Text = "Wadah mekanisme."
  },
  State_146536_Name = {
    Text = "Mekanisme Chaos Primordial"
  },
  State_146644_Desc = {
    Text = "Rouse mendapatkan Prepare 1, saat pertama kali di-play dalam satu ronde, secara otomatis melepaskan Posse yang dibawa."
  },
  State_146644_Name = {
    Text = "Gema Arkais"
  },
  State_146645_Desc = {
    Text = "Realm Chaos Baru secara otomatis melepaskan Posse yang dibawa saat pertama kali Rouse di-play dalam satu ronde. Saat ini tersedia."
  },
  State_146645_Name = {
    Text = "Penanda Tersedia"
  },
  State_146646_Desc = {
    Text = "Batas atas Keyflare dasar diubah menjadi 2000. Aturan mendapatkan Keyflare diganti menjadi: saat Awakener pertama kali play Kartu perintah dalam satu ronde, mendapatkan Keyflare sebesar 3 kali Keyflare Regen + 100."
  },
  State_146646_Name = {
    Text = "Aturan Keyflare Chaos Baru"
  },
  State_146651_Desc = {
    Text = "Meningkatkan atribut ATK Awakener ini sebesar [Layer]%."
  },
  State_146651_Name = {
    Text = "Chaos·Serangan"
  },
  State_146652_Desc = {
    Text = "Hanya 1 kali setelah pertempuran dimulai, mengubah efisiensi Keyflare Regen setiap Awakener menjadi nilai rata-rata Tingkat Muatan Kunci Perak."
  },
  State_146652_Name = {
    Text = "Keseimbangan Primordial"
  },
  State_146653_Desc = {
    Text = "Meningkatkan atribut DEF Tubuh Terjaga ini sebesar [Layer]%."
  },
  State_146653_Name = {
    Text = "Chaos·Pertahanan"
  },
  State_146663_Desc = {
    Text = "\"Pukulan\" dari [Layer] Lotan: Cetarchon berikutnya berlaku tambahan 1 kali."
  },
  State_146663_Name = {
    Text = "Badai Pelahap Cetus"
  },
  State_147058_Name = {
    Text = "Aksesori 36 Kamar"
  },
  State_147079_Desc = {
    Text = "Kartu ini tidak dapat dibuang, tidak dapat berubah."
  },
  State_147079_Name = {
    Text = "<RetainIconKeywordsColour:Retain Paksa>"
  },
  State_147545_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Belum dikonfigurasi"
  },
  State_147545_Name = {
    Text = "Bintang Senja·Tinkter SR (Teks Sementara)"
  },
  State_147546_Name = {
    Text = "Tidak Digunakan"
  },
  State_147546_WeaponDesc = {
    Text = "Suara di Luar Dunia"
  },
  State_147584_Desc = {
    Text = "Efek <DerivativeCardKeywords_152:\"Anugerah Peri\"> <Blessing:Anugerah> dari kartu berikutnya yang di-play meningkat 50%"
  },
  State_147737_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat dipasang, mendapatkan [StateArg1] <MaxHPKeywords:Max HP>. Saat giliran dimulai, menimbulkan <Damage:[Damage:StateArg2]> kerusakan <PVPBleedingKeywords:Bleed> kepada semua musuh,"
  },
  State_147737_Name = {
    Text = "Dari kegelapan ke kegelapan"
  },
  State_147764_Name = {
    Text = "Negara@Hitungan Pilihan Salah Aktivitas Caraboo"
  },
  State_147765_Desc = {
    Text = "Saat ronde berikutnya dimulai, kehilangan 2 poin Arithmetica dan menarik 2 kartu lebih sedikit."
  },
  State_147765_Name = {
    Text = "Cokelat <Italic:Pistoles de Marie>"
  },
  State_147768_Desc = {
    Text = "Saat ronde berikutnya dimulai, dapatkan [DescArg1] Intuisi Tinggi."
  },
  State_147768_Name = {
    Text = "Koin Emas <Italic:Pistoles de Marie>"
  },
  State_147769_Desc = {
    Text = "\"Santap Kenyang\" dalam pertempuran ini saat ini telah ditumpuk sebanyak [Layer] lapisan."
  },
  State_147769_Name = {
    Text = "Batas Tumpukan"
  },
  State_147772_Name = {
    Text = "Negara@Aktivitas Caraboo menambahkan batas Keyflare sementara"
  },
  State_147773_Name = {
    Text = "Negara@Aktivitas Caraboo menambahkan batas Keyflare sementara"
  },
  State_147774_Name = {
    Text = "Negara@Aktivitas Caraboo menambahkan batas Keyflare sementara_Chaos biasa"
  },
  State_147797_Desc = {
    Text = "Kemungkinan mendapatkan atau kehilangan Aliemus, <PowerIconKeywords:Kekuatan>, HP, Keyflare, dan Arithmetica serta draw kartu."
  },
  State_147797_Name = {
    Text = "Cokelat <Italic:Pistoles de Marie>"
  },
  State_147800_Desc = {
    Text = "Saat ronde berikutnya dimulai, kehilangan 2 poin Arithmetica dan menarik 2 kartu lebih sedikit."
  },
  State_147800_Name = {
    Text = "Cokelat <Italic:Pistoles de Marie>"
  },
  State_147869_Name = {
    Text = "Ambil [Layer] kartu"
  },
  State_147870_Name = {
    Text = "Menyebabkan semua musuh mengalami [Layer] putaran Kelemahan"
  },
  State_147871_Name = {
    Text = "Mendapatkan [Energy:DescArg1] poin Aliemus"
  },
  State_147872_Name = {
    Text = "Menyebabkan semua musuh menerima [Layer] putaran rentan"
  },
  State_147873_Name = {
    Text = "Mendapatkan [Layer] Aritmetika"
  },
  State_147874_Name = {
    Text = "Mendapatkan [Block:DescArg1] Perisai"
  },
  State_147962_Desc = {
    Text = "Setelah ini, saat pemain mem-play \"<DerivativeCardKeywords_158:Kambing Hitam>\" hanya mengusir 50% stacks <MonsterSinMarkKeywords:Tanda Dosa>, dan setiap kali mem-play 1 Kartu perintah \"Anak Suci · Malam Putih\" mendapatkan 1 stacks <MonsterSinMarkKeywords:Tanda Dosa>."
  },
  State_147962_Name = {
    Text = "Jalan dunia yang murni."
  },
  State_147967_Desc = {
    Text = "「Putra Suci·Malam Putih」 menambahkan [DescArg1]% <BleedingIconKeywords:Bleed> pada kerusakan yang ditimbulkan."
  },
  State_147967_Name = {Text = "Tanda dosa"},
  State_147968_Desc = {
    Text = "Batas 3 lapisan. Saat beralih ke niat serangan, kerusakan yang ditimbulkan oleh 「Putra Suci·Malam Putih」 meningkat 25% dan mengonsumsi 1 lapisan."
  },
  State_147968_Name = {
    Text = "Penyelamatan dari penderitaan"
  },
  State_147969_Desc = {
    Text = "Saat 「Putra Suci·Malam Putih」 berada dalam niat \"Hati Suci\", setiap 1 Kartu perintah yang dimainkan mengumpulkan 2 lapisan <MonsterPolluxFever:Kegilaan>."
  },
  State_147969_Name = {
    Text = "Perjanjian Baru Wahyu Ilahi"
  },
  State_147971_Desc = {
    Text = "Awakener ini belum Awaken… saat akan dikalahkan akan memulihkan HP dan mendapatkan 1 stacks <InvincibleUntilRoused:Pemadatan Inti Perak>, setelah Awaken hapus <InvincibleUntilRoused:Pemadatan Inti Perak> dan mulai bertarung dalam wujud sejatinya."
  },
  State_147971_Name = {Text = "Not Roused"},
  State_147972_Desc = {
    Text = "Setiap lapisan menambahkan 1% <BleedingIconKeywords:Bleed> pada kerusakan yang ditimbulkan oleh 「Putra Suci·Malam Putih」."
  },
  State_147972_Name = {
    Text = "<MonsterSinMarkKeywords:Tanda Dosa>"
  },
  State_147974_Desc = {
    Text = "Dihapus setelah ronde dimulai. Setelah mencapai 10 lapisan, segera bertindak setelah kartu berikutnya dimainkan, menghapus Kegilaan dan mengalihkan niat ke \"Hati Suci\"."
  },
  State_147974_Name = {
    Text = "Kegilaan Sementara"
  },
  State_147975_Desc = {
    Text = "Saat pertarungan dimulai, masukkan satu \"<DerivativeCardKeywords_158:Kambing Hitam>\" ke dalam Hand. Setelah ronde berakhir, dapatkan 5 lapisan <MonsterSinMarkKeywords:Tanda Dosa>."
  },
  State_147975_Name = {
    Text = "Utusan Ilahi Pembawa Lentera"
  },
  State_147993_Desc = {
    Text = "Batas 3 lapisan. Saat beralih ke niat serangan, kerusakan yang ditimbulkan oleh 「Putra Suci·Malam Putih」 meningkat 25% dan mengonsumsi 1 lapisan."
  },
  State_147993_Name = {
    Text = "Penyelamatan dari penderitaan"
  },
  State_148020_Desc = {
    Text = "Imun terhadap semua kerusakan dan tidak dapat kehilangan HP, dihapus setelah Awaken."
  },
  State_148020_Name = {
    Text = "Pemadatan Inti Perak"
  },
  State_148021_Name = {
    Text = "Negara@Penanda penghapusan Imun Kebangkitan monster umum sebelum Awaken"
  },
  State_148073_Name = {
    Text = "Tarik 1 kartu"
  },
  State_148074_Desc = {
    Text = "Kartu tidak akan masuk ke tumpukan kartu buang selama fase pembuangan, melainkan tetap berada di tangan."
  },
  State_148074_Name = {
    Text = "<RetainIconKeywords:Simpan>"
  },
  State_148074_WeaponDesc = {
    Text = "Kartu tidak akan masuk ke tumpukan kartu buang selama fase pembuangan, melainkan tetap berada di tangan."
  },
  State_148076_Name = {
    Text = "Pemantau kartu yang dimainkan di Jalan Dunia Bersih"
  },
  State_148116_Desc = {
    Text = "Setelah 1 ronde, draw [StateArg1] kartu sebanyak [Layer] kali."
  },
  State_148116_Name = {
    Text = "Tirage tertunda 1"
  },
  State_148381_Desc = {
    Text = "Hingga ronde berakhir, kerusakan yang ditimbulkan sendiri menambahkan 100% <BleedingIconKeywords:Bleed>."
  },
  State_148381_Name = {
    Text = "Rancor Terikat"
  },
  State_148383_Desc = {
    Text = "Batas maksimal 3 stacks. Jika memiliki 3 stacks \"Kebencian\", saat niat berikutnya beralih ke \"Rantai Darah\", niat akan beralih menjadi \"Bola Rantai Berdarah\" dan menghapus \"Kebencian\"."
  },
  State_148383_Name = {
    Text = "\"Kebencian\""
  },
  State_148385_Desc = {
    Text = "Setiap kali musuh memainkan Kartu perintah, dapatkan 2 lapisan <MonsterB05EXFever:Kegilaan Sementara>."
  },
  State_148385_Name = {
    Text = "bentuk tidak teratur"
  },
  State_148386_Desc = {
    Text = "Tidak dapat memperoleh Perisai hingga ronde berakhir."
  },
  State_148386_Name = {
    Text = "Rantai Pengikat"
  },
  State_148387_Desc = {
    Text = "Awakener ini belum Awaken… saat akan dikalahkan akan memulihkan HP dan mendapatkan 1 stacks <InvincibleUntilRoused:Pemadatan Inti Perak>, setelah Awaken hapus <InvincibleUntilRoused:Pemadatan Inti Perak> dan mulai bertarung dalam wujud sejatinya."
  },
  State_148387_Name = {Text = "Not Roused"},
  State_148391_Desc = {
    Text = "Hingga ronde berakhir, kerusakan yang ditimbulkan sendiri menambahkan 100% <BleedingIconKeywords:Bleed>."
  },
  State_148391_Name = {
    Text = "Rantai Pengikat"
  },
  State_148392_Desc = {
    Text = "Dihapus setelah ronde dimulai. Setelah mencapai 10 lapisan, segera bertindak setelah kartu berikutnya dimainkan, menghapus Kegilaan dan mengalihkan niat ke \"Rantai Darah\"."
  },
  State_148392_Name = {
    Text = "Kegilaan Sementara"
  },
  State_148394_Desc = {
    Text = "Saat giliran dimulai, dapatkan 1 stack <ResentChainsKeywords:Rantai Kebencian>. Saat niat beralih ke \"Bola Rantai Berdarah\", hingga akhir giliran musuh, Imun terhadap semua kerusakan dan efek kehilangan HP."
  },
  State_148394_Name = {
    Text = "Deklarasi Soul Reaper"
  },
  State_148395_Desc = {
    Text = "Imun terhadap semua kerusakan (termasuk Pierce DMG) dan tidak dapat kehilangan HP, dihapus setelah giliran musuh berakhir."
  },
  State_148395_Name = {
    Text = "Deklarasi Soul Reaper-Bola Rantai Berdarah"
  },
  State_148421_Desc = {
    Text = "Setelah 1 ronde, kurangi sementara [StateArg1] poin <ExhaustionIconKeywords:Kekuatan> semua musuh sebanyak [Layer] kali"
  },
  State_148421_Name = {
    Text = "Latensi Drain1"
  },
  State_148422_Desc = {
    Text = "Setelah 1 ronde, sementara DMG Amplification [StateArg1]% sebanyak [Layer] kali."
  },
  State_148422_Name = {
    Text = "Latensi Sementara DMG Amplification 1"
  },
  State_148423_Desc = {
    Text = "Setelah 1 ronde, dapatkan <Posse:[StateArg1]> Keyflare sebanyak [Layer] kali."
  },
  State_148423_Name = {
    Text = "Latensi Keyflare1"
  },
  State_148426_Desc = {
    Text = "Setelah 1 ronde, dapatkan [StateArg1] Arithmetica sebanyak [Layer] kali."
  },
  State_148426_Name = {
    Text = "Negara Tertunda Aritmetika"
  },
  State_148427_Desc = {
    Text = "Setelah 1 ronde, semua Awakener mendapatkan [StateArg1] Aliemus sebanyak [Layer] kali."
  },
  State_148427_Name = {
    Text = "Latensi Aliemus1"
  },
  State_148428_Desc = {
    Text = "Setelah 1 ronde, dapatkan [StateArg1] poin <PowerIconKeywords:Kekuatan> sebanyak [Layer] kali."
  },
  State_148428_Name = {
    Text = "Latensi Kekuatan1"
  },
  State_148511_Desc = {
    Text = "Tim Unik: Setelah eksplorasi dimulai, tambahkan 1 kartu <Backupbody[StateArg3]:\"Sinkronisasi Jiwa\"> ke dalam dek. \"Sinkronisasi Jiwa\": Arithmetica Cost 0, setelah di-play mendapatkan 1 poin Arithmetica. <RetainIconKeywords:Retain>: Mengumpulkan pemulihan HP tetap sebesar <WeaponEffect_Num:[StateArg1]%> CON Pemakai dan <WeaponEffect_Num:[StateArg2]> poin Aliemus tetap dalam kartu ini. Jika kartu ini tidak di-Destroy, dapat Imun kematian satu kali dan melepaskan semua pemulihan HP dan Aliemus yang terkumpul, kemudian <DestructionKeywords:Destroy> kartu ini."
  },
  State_148511_Name = {
    Text = "Sinkronisasi Jiwa"
  },
  State_148511_WeaponDesc = {
    Text = "Setelah eksplorasi dimulai, tambahkan 1 kartu <Backupbody[StateArg3]:\"Sinkronisasi Jiwa\"> ke dalam dek. \"Sinkronisasi Jiwa\": Arithmetica Cost 0, setelah di-play mendapatkan 1 poin Arithmetica. <RetainIconKeywords:Retain>: Mengumpulkan pemulihan HP tetap sebesar <WeaponEffect_Num:[StateArg1]%> CON Pemakai dan <WeaponEffect_Num:[StateArg2]> poin Aliemus tetap dalam kartu ini. Jika kartu ini tidak di-Destroy, dapat Imun kematian satu kali dan melepaskan semua pemulihan HP dan Aliemus yang terkumpul, kemudian <DestructionKeywords:Destroy> kartu ini."
  },
  State_148513_Desc = {
    Text = "Pihak lawan tidak akan membuang kartu di tangan pada akhir giliran. Pada akhir giliran, terapkan secara berurutan 2 lapisan <FragileIconKeywords:Rapuh>, <WeaknessIconKeywords:Kelemahan>, <HeavyInjuryKeywords:Cedera Berat>, dan <VulnerabilityIconKeywords:Rentan>."
  },
  State_148513_Name = {
    Text = "Suara di Luar Dunia"
  },
  State_148520_Desc = {
    Text = "Tidak dapat memperoleh Perisai hingga ronde berakhir."
  },
  State_148520_Name = {
    Text = "Rancor Terikat"
  },
  State_148522_Desc = {
    Text = "Tim Unik: Perisai dan kekuatan yang diberikan oleh \"Exalt\" Pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>."
  },
  State_148524_Desc = {
    Text = "Tim Unik: Perisai dan kekuatan yang diberikan oleh \"Exalt\" Pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Perisai yang diberikan oleh \"Pertahanan\" Pemakai meningkat sebesar <WeaponEffect_Num:[StateArg2]%>. Setelah Pemakai memainkan \"Pertahanan\", dapatkan kekuatan sebesar <WeaponEffect_Num:[StateArg3]%> dari ATK Pemakai."
  },
  State_148540_Desc = {
    Text = "Latensi[Layer]: Arithmetica Cost dari [StateArg1] Kartu perintah dengan Arithmetica tertinggi milik <AwakerName:[DescArg1]> berkurang [StateArg2]."
  },
  State_148540_Name = {
    Text = "Cermin Penglihatan - Latensi[Layer]"
  },
  State_148541_Name = {
    Text = "Hapus efek \"Stagnation\" dari Kartu Awakener pilihan di tangan"
  },
  State_148544_Desc = {
    Text = "Latensi[Layer]: Setiap 1 poin Aliemus yang dikonsumsi saat Exalt berikutnya oleh <AwakerName:[DescArg1]> memberikan [StateArg1] poin Keyflare."
  },
  State_148544_Name = {
    Text = "Kunci Iblis - Latensi[Layer]"
  },
  State_148547_Desc = {
    Text = "Exalt berikutnya dari <AwakerName:[DescArg1]> dianggap sebagai Over-Exaltation, jika sudah merupakan Over-Exaltation maka mengembalikan 100% Aliemus Dasar."
  },
  State_148547_Name = {
    Text = "Mahkota Abadi"
  },
  State_148548_Desc = {
    Text = "Retain: Semua Awakener mendapatkan 5 poin Aliemus."
  },
  State_148548_Name = {
    Text = "Meraup Bayangan Terbalik"
  },
  State_148549_Name = {
    Text = "Memicu semua efek \"Prepare\" yang ada di tangan"
  },
  State_148553_Desc = {
    Text = "Latensi[Layer]: [Layer] Kartu perintah berikutnya yang di-play oleh <AwakerName:[DescArg1]> mendapatkan Perisai sebesar [StateArg2]% dari HP yang telah hilang."
  },
  State_148553_Name = {
    Text = "Buah Godaan - Latensi[Layer]"
  },
  State_148554_Desc = {
    Text = "Kartu perintah <AwakerName:[DescArg1]> memberikan kerusakan dengan tambahan [Layer]% Bleed."
  },
  State_148554_Name = {
    Text = "Mata Pemusnah"
  },
  State_148556_Desc = {
    Text = "Saat berada di tangan, semua Awakener menambahkan Bleed 10% saat memberikan Active DMG."
  },
  State_148556_Name = {
    Text = "Mimpi Buruk Tiba Tepat Waktu"
  },
  State_148557_Desc = {
    Text = "[Layer] Kartu perintah berikutnya yang di-play oleh <AwakerName:[DescArg1]> mendapatkan Perisai sebesar [StateArg1]% dari HP yang telah hilang."
  },
  State_148557_Name = {
    Text = "Buah Godaan"
  },
  State_148559_Desc = {
    Text = "Setiap 1 poin Aliemus yang dikonsumsi saat Exalt berikutnya oleh <AwakerName:[DescArg1]> memberikan [Layer] poin Keyflare."
  },
  State_148559_Name = {
    Text = "Kunci Iblis"
  },
  State_148561_Desc = {
    Text = "Saat kartu ini di-play, secara acak memicu satu dari tiga efek negatif berikut: Efek berkurang 50%/Latensi 2 putaran baru berlaku/Secara acak mendapatkan 1 efek negatif."
  },
  State_148561_Name = {
    Text = "<ExclamationPointColour:Keinginan yang Terdistorsi>"
  },
  State_148562_Name = {
    Text = "Awakener yang dipilih mendapatkan 10 poin Aliemus"
  },
  State_148563_Desc = {
    Text = "Latensi[Layer]: Perisai dan pemulihan HP yang didapatkan dari Exalt berikutnya oleh <AwakerName:[DescArg1]> meningkat [StateArg1]%."
  },
  State_148563_Name = {
    Text = "Bulu Keadilan - Latensi[Layer]"
  },
  State_148566_Desc = {
    Text = "Exalt berikutnya dari <AwakerName:[DescArg1]> memberikan kerusakan dengan tambahan [Layer]% Penghakiman Takdir."
  },
  State_148566_Name = {
    Text = "Benang Takdir"
  },
  State_148569_Desc = {
    Text = "Perisai dan pemulihan HP yang didapatkan dari Exalt berikutnya oleh <AwakerName:[DescArg1]> meningkat [Layer]%."
  },
  State_148569_Name = {
    Text = "Bulu Keadilan"
  },
  State_148571_Desc = {
    Text = "Latensi[Layer] : Kartu perintah <AwakerName:[DescArg1]> memberikan kerusakan dengan tambahan [StateArg1]% Bleed."
  },
  State_148571_Name = {
    Text = "Mata Pemusnah - Latensi[Layer]"
  },
  State_148574_Desc = {
    Text = "Latensi[Layer] : Exalt berikutnya dari <AwakerName:[DescArg1]> memberikan kerusakan dengan tambahan [StateArg1]% Penghakiman Takdir."
  },
  State_148574_Name = {
    Text = "Benang Takdir - Latensi[Layer]"
  },
  State_148575_Name = {
    Text = "Awakener yang dipilih mendapatkan 20 poin Aliemus"
  },
  State_149089_Name = {
    Text = "Negara@Penanda Aliemus Menelan Kecil Anjing Lentera"
  },
  State_149092_Desc = {
    Text = "Menelan <Energy:[Energy:DescArg2]> poin Aliemus milik \"<AwakerName:[DescArg1]>\", dikembalikan setelah mati."
  },
  State_149092_Name = {Text = "Menelan"},
  State_149094_Desc = {
    Text = "Tim Unik: Perisai Dasar yang dihasilkan dari Exalt Pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah Pemakai play Kartu perintah yang menyebabkan <WeaknessIconKeywords:Weakness>, Perisai Dasar yang dihasilkan oleh Kartu perintah Pemakai berikutnya meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Saat menggunakan \"Crimson Furnace\", Draw satu kartu skill dengan Arithmetica Cost tertinggi milik Pemakai, <EmbryoFusionIconKeywords:Embryo Fusion> +<WeaponEffect_Num: [StateArg1]>, cooldown 3 ronde."
  },
  State_149094_WeaponDesc = {
    Text = "Perisai Dasar yang dihasilkan dari Exalt Pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah Pemakai play Kartu perintah yang menyebabkan <WeaknessIconKeywords:Weakness>, Perisai Dasar yang dihasilkan oleh Kartu perintah Pemakai berikutnya meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Saat menggunakan \"Crimson Furnace\", Draw satu kartu skill dengan Arithmetica Cost tertinggi milik Pemakai, <EmbryoFusionIconKeywords:Embryo Fusion> +<WeaponEffect_Num: [StateArg1]>, cooldown 3 ronde."
  },
  State_149122_Desc = {
    Text = "Setelah mati, segera Memanggil satu \"Kawanan Hati\" atau \"Kawanan Skul\" secara acak, menurunkan \"Efek Kluster\"-nya sebesar 1 stacks."
  },
  State_149122_Name = {
    Text = "Efek Kluster"
  },
  State_149123_Desc = {
    Text = "Kerusakan yang diterima dari Exalt berkurang 50%."
  },
  State_149123_Name = {
    Text = "Transformasi Sumbu·Lebur"
  },
  State_149124_Desc = {
    Text = "Kerusakan yang diterima dari Kartu perintah berkurang 50%."
  },
  State_149124_Name = {
    Text = "Transformasi Sumbu·Bayangan"
  },
  State_149125_Desc = {
    Text = "Mem-Freeze Kartu perintah milik \"<AwakerName:[DescArg1]>\", setelah mati, Freeze pada Awakener tersebut dilepaskan."
  },
  State_149125_Name = {Text = "Menelan"},
  State_149126_Desc = {
    Text = "Setelah mati, segera Memanggil satu \"Kawanan Skul\" secara acak, menurunkan \"Efek Kluster\"-nya sebesar 1 stacks."
  },
  State_149126_Name = {
    Text = "Efek Kluster"
  },
  State_149128_Name = {
    Text = "Negara@Penanda Kartu Freeze Kecil Anjing Lentera Es"
  },
  State_149140_Desc = {
    Text = "Akan meningkatkan kemampuan musuh. Kehilangan satu lapisan setiap kali menerima kerusakan."
  },
  State_149140_Name = {
    Text = "Sumpah Darah"
  },
  State_149143_Desc = {
    Text = "Setelah fase Menggambar berakhir, untuk setiap [DescArg1] Kartu perintah <SlowIconKeywords:Stagnation> yang ada di tangan musuh, dapatkan [DescArg2] stack <BloodOath_New:Sumpah Darah>. Setelah diri sendiri memberikan kerusakan yang tidak diblokir, secara acak berikan [DescArg4] stack <SlowIconKeywords:Stagnation> pada [DescArg3] Kartu perintah di Hand atau Menggambar yang belum terkena <SlowIconKeywords:Stagnation>."
  },
  State_149143_Name = {
    Text = "Sumpah Darah Membeku"
  },
  State_149162_Desc = {
    Text = "Saat menimbulkan kerusakan yang tidak diblokir, hapus Ketahanan"
  },
  State_149162_Name = {
    Text = "Sihir Timur Jauh"
  },
  State_149163_Desc = {
    Text = "Max HP berkurang sejumlah stack yang sama, dibelah dua setelah pertempuran berakhir."
  },
  State_149163_Name = {
    Text = "<BoneHitKeywords:Scathe>"
  },
  State_149164_Desc = {
    Text = "Saat menimbulkan kerusakan, berikan Scathe"
  },
  State_149164_Name = {
    Text = "Embun Beku Menusuk"
  },
  State_149167_Desc = {
    Text = "Max HP berkurang [Layer], dibelah dua setelah pertempuran berakhir."
  },
  State_149167_Name = {
    Text = "<BoneHitKeywords:Scathe>"
  },
  State_149169_Desc = {
    Text = "Setiap stacks meningkatkan batas HP sebesar 15% CON Caraboo, \"Kepuasan\" maksimal ditumpuk hingga 50 stacks. Jika saat mendapatkan Negara ini sudah mencapai batas, setiap 1 stacks yang melebihi batas akan diganti dengan memulihkan HP sebesar 3 kali lipat jumlah yang setara. Setiap Pertarungan non-Pemimpin maksimal mendapatkan 10 stacks \"Kepuasan\". Tidak dihapus saat pertarungan berakhir."
  },
  State_149169_Name = {
    Text = "<WormGrowth:Santap Kenyang>"
  },
  State_149172_Desc = {
    Text = "Tim Unik: Setelah Pemakai play Kartu perintah yang menyebabkan <WeaknessIconKeywords:Weakness>, Perisai Dasar yang dihasilkan oleh Kartu perintah Pemakai berikutnya meningkat sebesar <WeaponEffect_Num:[StateArg1]%>."
  },
  State_149172_WeaponDesc = {
    Text = "Setelah Pemakai play Kartu perintah yang menyebabkan <WeaknessIconKeywords:Weakness>, Perisai Dasar yang dihasilkan oleh Kartu perintah Pemakai berikutnya meningkat sebesar <WeaponEffect_Num:[StateArg1]%>."
  },
  State_149187_Desc = {
    Text = "Uji｜Memantau setelah menerima Fixed DMG, setelah Fixed DMG menyebabkan Bunuh, dan mencetak nilai pemicu, pihak terkait."
  },
  State_149187_Name = {
    Text = "Uji Fixed DMG"
  },
  State_149188_Desc = {
    Text = "Uji｜Setelah Fixed DMG menyebabkan Bunuh, nilai pemicu 1, kerusakan aktual Bunuh:[Layer]"
  },
  State_149188_Name = {
    Text = "Uji Nilai Pemicu Bunuh Fixed DMG 2"
  },
  State_149189_Desc = {
    Text = "Uji｜Setelah Fixed DMG menyebabkan Bunuh, pihak terkait 2, sumber yang menyebabkan Bunuh:[Layer]"
  },
  State_149189_Name = {
    Text = "Uji Pihak Terkait Bunuh Fixed DMG 2"
  },
  State_149190_Desc = {
    Text = "Uji｜Setelah Fixed DMG menyebabkan Bunuh, nilai pemicu 1, kerusakan overflow Bunuh:[Layer]"
  },
  State_149190_Name = {
    Text = "Uji Nilai Pemicu Bunuh Fixed DMG 3"
  },
  State_149191_Desc = {
    Text = "Uji｜Setelah menerima Fixed DMG, nilai pemicu 1, total kerusakan:[Layer]"
  },
  State_149191_Name = {
    Text = "Uji Nilai Pemicu Fixed DMG 1"
  },
  State_149192_Desc = {
    Text = "Uji｜Setelah Fixed DMG menyebabkan Bunuh, pihak terkait 1, yang dibunuh:[Layer]"
  },
  State_149192_Name = {
    Text = "Uji Pihak Terkait Bunuh Fixed DMG 1"
  },
  State_149193_Desc = {
    Text = "Uji｜Setelah menerima Fixed DMG, pihak terkait 2, yang terkena serangan:[Layer]"
  },
  State_149193_Name = {
    Text = "Uji Pihak Terkait Fixed DMG 2"
  },
  State_149194_Desc = {
    Text = "Uji｜Setelah menerima Fixed DMG, nilai pemicu 1, total kerusakan:[Layer]"
  },
  State_149194_Name = {
    Text = "Uji Nilai Pemicu Fixed DMG 2"
  },
  State_149195_Desc = {
    Text = "Uji｜Setelah Fixed DMG menyebabkan Bunuh, nilai pemicu 1, total kerusakan Bunuh:[Layer]"
  },
  State_149195_Name = {
    Text = "Uji Nilai Pemicu Bunuh Fixed DMG 1"
  },
  State_149196_Desc = {
    Text = "Uji｜Setelah menerima Fixed DMG, pihak terkait 1, sumber kerusakan:[Layer]"
  },
  State_149196_Name = {
    Text = "Uji Pihak Terkait Fixed DMG 1"
  },
  State_149227_Desc = {
    Text = "Perisai tidak akan hilang di akhir ronde. Saat memiliki Perisai, Peningkatan Kerusakan Ledakan Kegilaan yang diterima sebesar 50%, dan kerusakan dari Kartu perintah yang diterima berkurang 50%."
  },
  State_149227_Name = {
    Text = "Sembunyi di Balik Tirai Salju"
  },
  State_149228_Desc = {
    Text = "Saat menimbulkan kerusakan, berikan Bleed"
  },
  State_149228_Name = {
    Text = "Tembus Darah"
  },
  State_149229_Desc = {
    Text = "Saat memasuki lapangan, kehilangan 25% Max HP, dikonversi menjadi \"Perisai Es\" sebesar [DescArg1]% dari nilai yang hilang."
  },
  State_149229_Name = {
    Text = "Konversi Perisai Es"
  },
  State_149230_Desc = {
    Text = "Kerusakan Kartu perintah yang diterima meningkat 50%, kerusakan Ledakan Kegilaan yang diterima berkurang 50%."
  },
  State_149230_Name = {
    Text = "Status@Peningkatan/Pengurangan Kerusakan Jubah Gelap"
  },
  State_149232_Desc = {
    Text = "Perisai tidak akan hilang di akhir ronde. Saat memiliki Perisai, kerusakan dari Kartu perintah yang diterima meningkat 50%, dan kerusakan Ledakan Kegilaan yang diterima berkurang 50%."
  },
  State_149232_Name = {
    Text = "Sembunyi di Balik Bayangan Gelap"
  },
  State_149233_Desc = {
    Text = "Peningkatan Kerusakan Ledakan Kegilaan yang diterima sebesar 50%, kerusakan Kartu perintah yang diterima berkurang 50%."
  },
  State_149233_Name = {
    Text = "Status@Peningkatan/Pengurangan Kerusakan Mantel Bersalju"
  },
  State_149234_Desc = {
    Text = "Saat memasuki pertarungan, kehilangan 25% Max HP, dikonversi menjadi \"Perisai Kutukan\" sebesar [DescArg1]% dari nilai yang hilang."
  },
  State_149234_Name = {
    Text = "Konversi Perisai Kutukan"
  },
  State_149235_Desc = {
    Text = "Saat menimbulkan kerusakan yang tidak diblokir, hapus Ketahanan"
  },
  State_149235_Name = {
    Text = "Sihir Lentera"
  },
  State_149250_Desc = {
    Text = "Kerusakan Kartu perintah yang diterima +50%"
  },
  State_149250_Name = {
    Text = "Kerusakan Kartu perintah yang diterima +50%"
  },
  State_149251_Desc = {
    Text = "Kerusakan Kartu perintah yang diterima -50%"
  },
  State_149251_Name = {
    Text = "Kerusakan Kartu perintah yang diterima -50%"
  },
  State_149252_Desc = {
    Text = "Kerusakan Exalt yang diterima -50%"
  },
  State_149252_Name = {
    Text = "Kerusakan Exalt yang diterima -50%"
  },
  State_149253_Desc = {
    Text = "Kerusakan Exalt yang diterima +50%"
  },
  State_149253_Name = {
    Text = "Kerusakan Exalt yang diterima +50%"
  },
  State_149265_Desc = {
    Text = "Setelah mati, segera Memanggil satu \"Wendigo\" acak, menurunkan \"Efek Kluster\"-nya sebesar 1 layer."
  },
  State_149265_Name = {
    Text = "Efek Kluster"
  },
  State_149268_Desc = {
    Text = "Saat kehilangan semua Perisai, dapatkan 75 lapisan Fortress sementara dan hapus 1 lapisan \"Tenggelam dalam Badai Salju\", ganti niat menjadi serangan kuat yang akan memberikan <BoneHitKeywords:Scathe>."
  },
  State_149268_Name = {
    Text = "Tenggelam dalam Badai Salju"
  },
  State_149269_Desc = {
    Text = "Saat kehilangan semua Perisai, dapatkan 75 lapisan Fortress sementara dan hapus 1 lapisan \"Tenggelam dalam Bayangan\", ganti niat menjadi serangan kuat yang akan merampas Aliemus."
  },
  State_149269_Name = {
    Text = "Tenggelam dalam Bayangan"
  },
  State_149270_Desc = {
    Text = "Setelah mati, segera Memanggil satu \"Wendigo\" acak, menurunkan \"Efek Kluster\"-nya sebesar 1 layer."
  },
  State_149270_Name = {
    Text = "Efek Kluster"
  },
  State_149308_Name = {
    Text = "Negara@Catatan Stack Stagnation Pendoa Lentera"
  },
  State_149391_Desc = {
    Text = "Awakener ini belum Awaken… saat akan dikalahkan akan memulihkan HP dan mendapatkan 1 stacks <InvincibleUntilRoused:Pemadatan Inti Perak>, setelah Awaken hapus <InvincibleUntilRoused:Pemadatan Inti Perak> dan mulai bertarung dalam wujud sejatinya."
  },
  State_149391_Name = {Text = "Not Roused"},
  State_149398_Desc = {
    Text = "Saat niat \"Snow White Sang Peri\" beralih ke \"Kutukan Bersalju\", konsumsi 1 tumpukan dan ubah niat menjadi \"Berkah Keajaiban\"."
  },
  State_149398_Name = {
    Text = "Santap Kenyang"
  },
  State_149399_Desc = {
    Text = "Setelah \"Snow White Sang Peri\" menggunakan \"Dongeng Indah Luar Biasa\", [DescArg1] niat berikutnya semuanya menjadi \"Kutukan Bersalju\". Setiap giliran, Shuffle [DescArg2] kartu <SlowIconKeywords:Stagnation> acak dengan [DescArg3] tumpukan <Blessing:Berkah> ke dalam dek."
  },
  State_149399_Name = {
    Text = "Buah Manis Nan Menggoda"
  },
  State_149418_Desc = {
    Text = "Tidak dapat Kritikal, tidak dianggap sebagai Kerusakan Dasar, dan tidak dipengaruhi oleh bonus seperti Final DMG."
  },
  State_149418_Name = {
    Text = "<RealDamage:Kerusakan Tetap>"
  },
  State_149419_Name = {
    Text = "<Rune_6:Besi Pertahanan>"
  },
  State_149420_Name = {
    Text = "<Rune_3:Tangan Ajaib>"
  },
  State_149421_Name = {
    Text = "<Rune_15:Ledakan>"
  },
  State_149422_Name = {
    Text = "<Rune_4:Perhitungan>"
  },
  State_149423_Name = {
    Text = "<Rune_11:Kepemimpinan>"
  },
  State_149424_Name = {
    Text = "<Rune_12: Haus Darah>"
  },
  State_149425_Name = {
    Text = "<Rune_1:Rentan>"
  },
  State_149426_Name = {
    Text = "<Rune_14:Kekuatan Brutal>"
  },
  State_149427_Name = {
    Text = "<Rune_2:Kelemahan>"
  },
  State_149428_Name = {
    Text = "<Rune_9:Duri>"
  },
  State_149429_Name = {
    Text = "<Rune_10:Racun>"
  },
  State_149430_Name = {
    Text = "<Rune_18:Kelelahan>"
  },
  State_149576_Desc = {
    Text = "Saat niat \"Snow White Sang Peri\" beralih ke \"Kutukan Bersalju\", konsumsi 1 tumpukan dan ubah niat menjadi \"Berkah Keajaiban\"."
  },
  State_149576_Name = {
    Text = "Santap Kenyang"
  },
  State_149618_Desc = {
    Text = [[
Setelah 2 ronde, picu efek berikut:
Dapatkan [DescArg1] poin Arithmetica. 
Dapatkan [DescArg2] poin Kekuatan. 
Dapatkan [DescArg3] poin Keyflare. 
Dapatkan [DescArg5] poin Aliemus. 
Draw [DescArg6] kartu.
Dapatkan [DescArg7] poin sementara DMG Amplification.
Buat semua musuh sementara mengurangi [DescArg4] poin Kekuatan.]]
  },
  State_149618_Name = {
    Text = "Kesempatan Terlewat 2"
  },
  State_149619_Desc = {
    Text = [[
Setelah 1 ronde, picu efek berikut:
Dapatkan [DescArg1] poin Arithmetica. 
Dapatkan [DescArg2] poin Kekuatan. 
Dapatkan [DescArg3] poin Keyflare. 
Dapatkan [DescArg5] poin Aliemus. 
Draw [DescArg6] kartu.
Dapatkan [DescArg7] poin sementara DMG Amplification.
Buat semua musuh sementara mengurangi [DescArg4] poin Kekuatan.]]
  },
  State_149619_Name = {
    Text = "Kesempatan Terlewat 1"
  },
  State_149628_Desc = {
    Text = "Jika sebelum akhir giliran musuh memiliki setidaknya 1000 poin Keyflare, Devour 1000 Keyflare."
  },
  State_149628_Name = {
    Text = "Persembahan Keyflare"
  },
  State_149629_Desc = {
    Text = "Jika sebelum akhir giliran Awakener dengan Aliemus tertinggi memiliki setidaknya 100 poin Aliemus, Devour 50 poin Aliemus-nya."
  },
  State_149629_Name = {
    Text = "Persembahan Aliemus"
  },
  State_149630_Desc = {
    Text = "Jika sebelum akhir giliran musuh memiliki setidaknya 1000 poin Keyflare, Devour 1000 Keyflare."
  },
  State_149630_Name = {
    Text = "Persembahan Keyflare"
  },
  State_149631_Desc = {
    Text = "Jika sebelum akhir giliran musuh memiliki setidaknya 3 poin Arithmetica, Devour 3 poin Arithmetica."
  },
  State_149631_Name = {
    Text = "Persembahan Arithmetica"
  },
  State_149632_Desc = {
    Text = "Jika sebelum akhir giliran musuh memiliki setidaknya 3 poin Arithmetica, Devour 3 poin Arithmetica."
  },
  State_149632_Name = {
    Text = "Persembahan Arithmetica"
  },
  State_149633_Desc = {
    Text = "Jika sebelum fase buang kartu musuh masih memiliki setidaknya 4 Kartu perintah di Hand, Devour 2 Kartu perintah secara acak."
  },
  State_149633_Name = {
    Text = "Persembahan Kartu"
  },
  State_149634_Desc = {
    Text = "Jika sebelum fase buang kartu musuh masih memiliki setidaknya 4 Kartu perintah di Hand, Devour 2 Kartu perintah secara acak."
  },
  State_149634_Name = {
    Text = "Persembahan Kartu"
  },
  State_149635_Desc = {
    Text = "Jika sebelum akhir giliran Awakener dengan Aliemus tertinggi memiliki setidaknya 100 poin Aliemus, Devour 50 poin Aliemus-nya."
  },
  State_149635_Name = {
    Text = "Persembahan Aliemus"
  },
  State_149652_Desc = {
    Text = "Tidak dapat Kritikal, tidak dianggap sebagai kerusakan yang diberikan oleh Awakener yang bersangkutan."
  },
  State_149652_Name = {
    Text = "<FixedDamage:Kerusakan Murni>"
  },
  State_149660_Desc = {
    Text = "Kerusakan, Perisai, dan perubahan kekuatan yang disebabkan oleh kartu ini meningkat sebesar [DescArg2]%, efek akhir dari Kerusakan tentakel, pemulihan HP, Racun tetap, dan Counter tetap meningkat sebesar [DescArg1]%, dihapus setelah di-play."
  },
  State_149660_Name = {
    Text = "Memperkuat [DescArg1]"
  },
  State_149664_Desc = {
    Text = "Setiap 1 lapisan meningkatkan kerusakan yang disebabkan kartu ini, Peningkatan Kerusakan tentakel dan kekuatan tetap, Racun tetap, efek akhir Counter tetap sebesar 2%; efek akhir Perisai tetap, pemulihan HP tetap, dan STR▼ meningkat sebesar 1%, dihapus setelah di-play."
  },
  State_149664_Name = {Text = "Memperkuat"},
  State_149719_Name = {
    Text = "Imun Kerusakan Murni PVP__\"Hanya untuk pengembangan\""
  },
  State_149736_Desc = {
    Text = "[Layer] Kartu perintah <AwakerName:[DescArg1]> berikutnya meningkatkan Perisai Dasar sebesar [StateArg1]%."
  },
  State_149736_Name = {
    Text = "Muslihat Manis"
  },
  State_149744_Desc = {
    Text = "[Layer] Berkah berikutnya yang di-play tidak akan memicu efek negatif"
  },
  State_149744_Name = {
    Text = "Perlindungan Peri"
  },
  State_149772_Desc = {
    Text = "Setiap kali menerima Active DMG, buat semua Awakener kehilangan 3 Aliemus, maksimal berlaku 5 kali per ronde. Setelah Pecahkan Perisai, hapus status \"Perisai Kutukan\"."
  },
  State_149772_Name = {
    Text = "Perisai Kutukan"
  },
  State_149773_Desc = {
    Text = "Setiap kali menerima Active DMG, berikan 1 stacks Stagnation sementara pada kartu acak di Hand, maksimal berlaku 5 kali per ronde. Setelah Pecahkan Perisai, hapus status \"Perisai Es\"."
  },
  State_149773_Name = {Text = "Perisai es"},
  State_149782_Desc = {
    Text = "Konsumsi: Setelah Draw di ronde berikutnya, Shuffle 1 \"Buah Segala Perubahan\" ke dalam Menggambar."
  },
  State_149782_Name = {
    Text = "Buah Segala Perubahan"
  },
  State_149787_Desc = {
    Text = "Setiap 1 lapisan yang dimiliki, Final DMG Kartu perintah Sumpah Palsu·Ogier meningkat [DescArg2]%, jumlah draw kartu saat awal ronde -1, Crit. DMG meningkat [DescArg3]%, batas [DescArg1] lapisan, tidak dihapus saat pertempuran berakhir."
  },
  State_149787_Name = {
    Text = "<KuangNu:Arus Tersembunyi>"
  },
  State_149788_Desc = {
    Text = "Saat play \"Skill\" Sumpah Kegelapan·Ogier, konsumsi 1 stacks untuk Draw 1 kartu \"Pertahanan\", dapatkan Retain sebelum di-play berikutnya, batas [DescArg1] stacks, tidak dihapus saat pertempuran berakhir."
  },
  State_149788_Name = {
    Text = "<ShuZui:Dosa Sendiri>"
  },
  State_149789_Desc = {
    Text = "Setiap 1 lapisan yang dimiliki, Final DMG Kartu perintah Sumpah Palsu·Ogier meningkat 33%, jumlah draw kartu saat awal ronde -1, batas [DescArg1] lapisan, tidak dihapus saat pertempuran berakhir."
  },
  State_149789_Name = {
    Text = "<KuangNu:Arus Tersembunyi>"
  },
  State_149790_Desc = {
    Text = "Setiap 1 lapisan yang dimiliki, Final DMG Kartu perintah Sumpah Palsu·Ogier meningkat [DescArg2]%, jumlah draw kartu saat awal ronde -1, batas [DescArg1] lapisan, tidak dihapus saat pertempuran berakhir."
  },
  State_149790_Name = {
    Text = "<KuangNu:Arus Tersembunyi>"
  },
  State_149791_Desc = {
    Text = "Saat play \"Skill\" Sumpah Kegelapan·Ogier, konsumsi 1 stacks untuk Draw 1 kartu \"Pertahanan\", dapatkan Retain sebelum di-play berikutnya, batas [DescArg1] stacks, tidak dihapus saat pertempuran berakhir."
  },
  State_149791_Name = {
    Text = "<ShuZui:Dosa Sendiri>"
  },
  State_149814_Desc = {
    Text = "DMG Amplification Sementara +[Layer]%."
  },
  State_149814_Name = {
    Text = "DMG Amplification Sementara"
  },
  State_149819_Desc = {
    Text = "Kekebalan terhadap semua kerusakan"
  },
  State_149819_Name = {Text = "Imun"},
  State_149892_Desc = {
    Text = "[Layer] Kartu perintah <AwakerName:[DescArg1]> berikutnya meningkatkan Perisai Dasar sebesar [StateArg1]%."
  },
  State_149892_Name = {
    Text = "Kebenaran Yang Senyap"
  },
  State_149913_Name = {
    Text = "Negara@Efek Khusus Harta Cacing Makrofag_Tinct Rusak"
  },
  State_149914_Name = {
    Text = "Negara@Efek Khusus Harta Cacing Makrofag_William Rusak"
  },
  State_149915_Name = {
    Text = "Negara@Efek Khusus Harta Cacing Makrofag_William"
  },
  State_149916_Name = {
    Text = "Negara@Efek Khusus Harta Cacing Makrofag_Castor Rusak"
  },
  State_149917_Name = {
    Text = "Negara@Efek Khusus Harta Cacing Makrofag_Rantai Darah Helot Rusak"
  },
  State_149918_Name = {
    Text = "Negara@Tes Awal Giliran Cacing Makrofag"
  },
  State_149919_Name = {
    Text = "Negara@Efek Khusus Harta Cacing Makrofag_Tinct"
  },
  State_149920_Name = {
    Text = "Negara@Efek Khusus Harta Cacing Makrofag_Arachne"
  },
  State_149921_Name = {
    Text = "Negara@Efek Khusus Harta Cacing Makrofag_Arachne Rusak"
  },
  State_149922_Name = {
    Text = "Negara@Efek Khusus Harta Cacing Makrofag_Castor"
  },
  State_149923_Name = {
    Text = "Negara@Efek Khusus Harta Cacing Makrofag_Rantai Darah Helot"
  },
  State_149930_Desc = {
    Text = "Setiap 1 stacks yang dimiliki, Final DMG Kartu perintah Sumpah Kegelapan·Ogier meningkat 50%, jumlah Draw saat ronde dimulai -1, batas [DescArg1] stacks, tidak dihapus saat pertempuran berakhir."
  },
  State_149930_Name = {
    Text = "<KuangNu2:Arus Tersembunyi>"
  },
  State_149931_Desc = {
    Text = "Terdapat 7 jenis Efek, meliputi: mendapatkan STR, Draw, mendapatkan Arithmetica, mendapatkan Keyflare, peningkatan DMG Amplification Sementara, semua Awakener mendapatkan Aliemus, sementara menurunkan STR semua musuh."
  },
  State_149931_Name = {
    Text = "<Blessing:Hadiah>"
  },
  State_149933_Name = {
    Text = "Negara@Gelembung Persembahan Monster Caraboo"
  },
  State_149934_Name = {
    Text = "Negara@Gelembung Persembahan Monster Caraboo"
  },
  State_149939_Desc = {
    Text = "Tidak dapat memperoleh Perisai hingga ronde berakhir."
  },
  State_149939_Name = {
    Text = "Rantai Pengikat"
  },
  State_19507_Desc = {
    Text = "Kerusakan serangan aktif dan lapisan pendarahan yang diterima sebelum ronde berikutnya dimulai meningkat sebesar 25%, dan saat diterapkan akan saling meniadakan dengan Diperkuat."
  },
  State_19507_Name = {
    Text = "<PVPVulnerabilityIconColour:Rentan>"
  },
  State_19508_Desc = {
    Text = "Pada akhir ronde, buang kartu ini."
  },
  State_19508_Name = {
    Text = "<PVPVoidKeyColour:Ilusi>"
  },
  State_19509_Desc = {
    Text = "Ubah sementara kekuatan aritmetika kartu.__\"仅开发用\""
  },
  State_19509_Name = {
    Text = "Permanen mengubah kekuatan aritmetika kartu__\"仅开发用\""
  },
  State_19511_Desc = {
    Text = "Setelah kematian, ganti kartu tangan dengan Ilusi__\"Hanya untuk pengembangan\""
  },
  State_19511_Name = {
    Text = "Pengganti Ilusi Kartu Tangan Kematian__\"Hanya untuk pengembangan\""
  },
  State_19513_Name = {
    Text = "Terapkan Pertarungan Kematian__\"Hanya untuk pengembangan\""
  },
  State_19516_Name = {
    Text = "Ubah sementara kekuatan aritmetika kartu__\"仅开发用\""
  },
  State_19517_Desc = {
    Text = "Setiap kehilangan 2% HP, mendapatkan 1 poin Aliemus__\"Hanya untuk pengembangan\""
  },
  State_19517_Name = {
    Text = "Menerima Kerusakan mendapatkan Aliemus__\"Hanya untuk pengembangan\""
  },
  State_19519_Desc = {
    Text = "Setelah menggunakan \"Pukulan\", konsumsi semua lapisan, setiap lapisan meningkatkan kerusakan yang dihasilkan oleh \"Pukulan\" ini sebesar 50%, maksimal dapat terakumulasi hingga 5 lapisan.(Saat ini meningkatkan sebesar [DescArg1]%)"
  },
  State_19519_Name = {Text = "Charge"},
  State_19521_Desc = {
    Text = "Setiap lapisan meningkatkan semua kerusakan yang diberikan dalam pertempuran ini sebesar 1 poin, tidak dapat dibuang."
  },
  State_19521_Name = {
    Text = "<PowerColourKeywords:Kekuatan>"
  },
  State_19522_Name = {
    Text = "Ubah sementara kekuatan aritmetika kartu__\"仅开发用\""
  },
  State_19523_Name = {
    Text = "Permanen mengubah kekuatan aritmetika kartu__\"仅开发用\""
  },
  State_19524_Desc = {
    Text = "Sebelum ronde berikutnya dimulai, setiap kali menerima serangan, berikan [Layer] poin Kerusakan Murni kepada penyerang."
  },
  State_19524_Name = {Text = "Counter"},
  State_19525_Desc = {
    Text = "Hapus perisai Awakener sebelum ronde dimulai__\"Hanya untuk pengembangan\""
  },
  State_19525_Name = {
    Text = "Hapus Perisai Karakter sebelum giliran dimulai__\"Hanya untuk pengembangan\""
  },
  State_19527_Desc = {
    Text = "Setiap stack menambah Arithmetica Cost \"Skill\" pada giliran ini sebesar +1, maksimal 3 stack, setelah di-play jika jumlah stack lebih dari 1 maka stack berkurang 1."
  },
  State_19527_Name = {
    Text = "<SlowColour:Melambatkan>"
  },
  State_19528_Desc = {
    Text = "Kartu dengan efek yang kuat."
  },
  State_19528_Name = {
    Text = "<SilverKeyColour:Geng>"
  },
  State_19529_Desc = {
    Text = "Dapat di-play sebanyak [Layer] kali, setiap kali kartu lain di-play, Arithmetica Cost kartu ini berkurang -1 untuk play berikutnya."
  },
  State_19529_Name = {
    Text = "<CardKeyWord:Fatamorgana [Layer]>"
  },
  State_19530_Desc = {
    Text = "·Diutamakan diserang oleh lawan, dan lawan hanya dapat memilih Pembangun yang mengalihkan ketika memilih target tunggal\n·Menghapus penyamaran diri sendiri dan pengalihan dari teman lainnya saat mendapatkan pengalihan, sekaligus menghilangkan penyamaran musuh."
  },
  State_19530_Name = {
    Text = "<TauntColour:Menyindir>"
  },
  State_19532_Desc = {
    Text = "Kerusakan yang diberikan sebelum akhir ronde ini berkurang sebesar [DescArg1]%, saat diterapkan akan saling meniadakan dengan Memperkuat."
  },
  State_19532_Name = {Text = "Weakness"},
  State_19533_Desc = {
    Text = "Kerusakan yang diberikan sebelum akhir ronde ini berkurang 50%, dan saat diterapkan akan saling meniadakan dengan Memperkuat."
  },
  State_19533_Name = {
    Text = "<WeaknessColour:Kelemahan>"
  },
  State_19534_Desc = {
    Text = "Kerusakan serangan aktif dan jumlah tumpukan pendarahan yang diterima sebelum giliran berikutnya meningkat sebesar [DescArg1]%, dan saat diterapkan akan saling meniadakan dengan Diperkuat."
  },
  State_19534_Name = {Text = "Vulnerable"},
  State_19535_Desc = {
    Text = "·Diutamakan diserang oleh lawan, dan lawan hanya dapat memilih Pembangun yang mengalihkan ketika memilih target tunggal\n·Menghapus penyamaran diri sendiri dan pengalihan dari teman lainnya saat mendapatkan pengalihan, sekaligus menghilangkan penyamaran musuh."
  },
  State_19535_Name = {Text = "Taunt"},
  State_19536_Desc = {
    Text = "Pada akhir ronde, dapatkan 10 poin Aliemus__\"Hanya untuk pengembangan\""
  },
  State_19536_Name = {
    Text = "Mendapatkan pemicu Aliemus saat akhir ronde__\"Hanya untuk pengembangan\""
  },
  State_19537_Desc = {
    Text = "Kerusakan yang diberikan sebelum akhir ronde ini meningkat sebesar [DescArg1]%, dan saat diterapkan akan saling meniadakan dengan Kelemahan."
  },
  State_19537_Name = {Text = "Memperkuat"},
  State_19538_Desc = {
    Text = "·Dapatkan 1 lapisan pada awal putaran ke-8 dan ke-9\n·Setiap lapisan Deathmatch mengurangi Perisai dan pemulihan HP yang diterima sebesar 50% serta mengurangi jumlah tumpukan maksimal Penghalang sebanyak 1\n·Deathmatch tidak dapat dihilangkan dan juga berlaku untuk Awakener yang mati."
  },
  State_19538_Name = {Text = "Deathmatch"},
  State_19540_Name = {
    Text = "Arithmetica Limit"
  },
  State_19541_Desc = {
    Text = "Tidak dapat melakukan tindakan apa pun hingga giliran berakhir."
  },
  State_19541_Name = {Text = "Fainted"},
  State_19544_Desc = {
    Text = "Setelah menggunakan \"Pukulan\", semua lapisan akan terpakai. Setiap lapisan yang digunakan meningkatkan kerusakan yang diberikan oleh \"Pukulan\" sebesar 50%, maksimum dapat terakumulasi hingga 5 lapisan."
  },
  State_19544_Name = {
    Text = "<EnergyStorageColour:Muatan>"
  },
  State_19545_Name = {
    Text = "Kartu ini dianggap sebagai 「Pukulan」"
  },
  State_19546_Desc = {
    Text = "Mengubah aritmetika kartu sebelum bermain.__\"仅开发用\""
  },
  State_19546_Name = {
    Text = "Mengubah aritmetika kartu sebelum bermain__\"仅开发用\""
  },
  State_19547_Desc = {
    Text = "Menyebabkan [Layer] Kerusakan Murni pada akhir ronde, permanen."
  },
  State_19547_Name = {Text = "Racun"},
  State_19549_Desc = {
    Text = "Kerusakan serangan aktif yang diterima sebelum ronde berikutnya dimulai berkurang sebesar 50%, dan saat diterapkan akan saling meniadakan dengan rentan."
  },
  State_19549_Name = {
    Text = "<ReinforceColour:Diperkuat>"
  },
  State_19552_Desc = {
    Text = "Saat ini memiliki [Layer] poin Perisai, Perisai tidak akan melebihi Kesehatan maksimum, berlangsung selama 1 ronde."
  },
  State_19552_Name = {Text = "Perisai"},
  State_19553_Desc = {
    Text = "Dapatkan Serangan Terakhir setelah fase menggambar kartu__\"Hanya untuk pengembangan\""
  },
  State_19553_Name = {
    Text = "Pemicu Serangan Terakhir__\"Hanya untuk pengembangan\""
  },
  State_19554_Name = {
    Text = "Keadaan kosong__\"Hanya untuk pengembangan\""
  },
  State_19555_Desc = {
    Text = "·Arithmetica Cost \"Skill\" pada giliran ini +[Layer], maksimal 3 stack.\n·Setelah men-play \"Skill\", jika jumlah stack lebih dari 1, stack berkurang 1."
  },
  State_19555_Name = {Text = "Stagnation"},
  State_19556_Desc = {
    Text = "Pada akhir giliran, konsumsi kekuatan kartu ini -[Layer]."
  },
  State_19556_Name = {
    Text = "<PrepareKeywords:Pendahuluan [Layer] >"
  },
  State_19557_Desc = {
    Text = "Kerusakan serangan aktif yang diterima sebelum ronde berikutnya dimulai berkurang sebesar [DescArg1]%, dan saat diterapkan akan saling meniadakan dengan rentan."
  },
  State_19557_Name = {Text = "Fortress"},
  State_19558_Name = {
    Text = "Pemicu penambahan kartu Kebangkitan dek__\"Hanya untuk pengembangan\""
  },
  State_19560_Desc = {
    Text = "Sebelum ronde berakhir, Aliemus tidak dapat menggunakan Muliakan."
  },
  State_19560_Name = {Text = "Sealed"},
  State_19561_Name = {
    Text = "Dapat digunakan 3 kali"
  },
  State_19990_Desc = {
    Text = "Pada awal giliran berikutnya, dapatkan [Layer] Aliemus."
  },
  State_19990_Name = {
    Text = "Aliemus Tertunda"
  },
  State_19992_Desc = {
    Text = "Tidak dapat melakukan tindakan apa pun sebelum giliran berakhir. Saat terkena kerusakan Pingsan, target akan memperoleh resistensi. Saat memiliki resistensi dan kembali terkena kerusakan Pingsan, efek Pingsan akan dibatalkan dan kerusakan akan dilipatgandakan. Status ini tidak dapat dihilangkan."
  },
  State_19992_Name = {
    Text = "<ComaColour:Pingsan>"
  },
  State_19995_Desc = {
    Text = "Menyebabkan Kerusakan Murni sebesar jumlah lapisan pada akhir ronde, berlangsung selamanya."
  },
  State_19995_Name = {
    Text = "<IntoxicationColour:Racun>"
  },
  State_19996_Desc = {
    Text = "Kerusakan yang diberikan sebelum akhir ronde ini meningkat sebesar 25%, dan saat diterapkan akan saling meniadakan dengan Kelemahan."
  },
  State_19996_Name = {
    Text = "<StrengthenColour:Memperkuat>"
  },
  State_19998_Desc = {
    Text = "Sebelum ronde berikutnya dimulai, setiap kali menerima serangan, berikan Kerusakan Murni sejumlah lapisan yang sama kepada penyerang."
  },
  State_19998_Name = {
    Text = "<RetaliateColour:Counter>"
  },
  State_20012_Desc = {
    Text = "Setiap poin sisa Aritmetika membuatmu mengambil 1 kartu di awal giliran berikutnya; setiap kartu sisa di tangan memberikanmu 1 Aritmetika di awal giliran berikutnya."
  },
  State_20012_Name = {
    Text = "Alienasi Awal: Fragment"
  },
  State_20012_WeaponDesc = {
    Text = "Setiap poin sisa Aritmetika membuatmu mengambil 1 kartu di awal giliran berikutnya; setiap kartu sisa di tangan memberikanmu 1 Aritmetika di awal giliran berikutnya."
  },
  State_20013_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Alam Mahir> meningkatkan sebesar 100. Kartu pertama yang dimainkan setiap ronde akan dikembalikan ke tangan. Saat ronde Ultra dimulai, batas kartu tangan untuk ronde tersebut +5 dan salin kartu di tanganmu."
  },
  State_20013_Name = {
    Text = "Negara@Pendulum waktu"
  },
  State_20014_Name = {
    Text = "Pendulum Waktu \"Tersesat\""
  },
  State_20016_Name = {
    Text = "Relik Sarung Tangan Sihir"
  },
  State_20017_Desc = {
    Text = "Efek lompatan berikutnya pasti akan terpicu."
  },
  State_20017_Name = {Text = "Leap"},
  State_20021_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Alam Mahir> meningkatkan sebesar 100. Kartu pertama yang dimainkan setiap ronde akan dikembalikan ke tangan. Saat ronde Ultra dimulai, batas kartu tangan untuk ronde tersebut +5 dan salin kartu di tanganmu."
  },
  State_20021_Name = {
    Text = "Negara@Pendulum waktu"
  },
  State_20023_Desc = {
    Text = "Setelah pertempuran dimulai, masukkan dua kartu pengisian Aliemus ke dalam dek."
  },
  State_20023_Name = {
    Text = "Kekacauan Hybrid"
  },
  State_20023_WeaponDesc = {
    Text = "Setelah pertempuran dimulai, masukkan dua kartu pengisian Aliemus ke dalam dek."
  },
  State_20024_Desc = {
    Text = "Setiap kali melepaskan Aliemus Muliakan, dapatkan satu kartu \"Infeksi Racun\" yang dapat memberikan [Arg1] poin Racun. Pada akhir ronde, jika terdapat setiap 3 kartu \"Infeksi Racun\" di tangan, mereka dapat digabungkan menjadi satu kartu \"Serangan Racun\" yang memicu Racun."
  },
  State_20024_Name = {
    Text = "Negara@Relik Alien Tipe Khusus"
  },
  State_20026_Desc = {
    Text = "Kartu tidak akan masuk ke tumpukan kartu buang saat fase buang kartu, tetapi tetap di tangan dan memicu efek selanjutnya."
  },
  State_20026_Name = {
    Text = "<RetainIconKeywords:Simpan>"
  },
  State_20026_WeaponDesc = {
    Text = "Setelah digunakan, kartu tidak akan masuk ke tumpukan kartu buang dan tidak dapat digunakan kembali selama pertempuran ini."
  },
  State_20028_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Kecakapan Alam> meningkatkan 100. Setiap memainkan 1 kartu, Fusi Embrio +10, ketika Hidup di bawah 25%, meningkat menjadi 20, paling banyak berlaku 10 kali per ronde."
  },
  State_20028_Name = {
    Text = "Negara@Invasi Pendulum Waktu"
  },
  State_20029_Desc = {
    Text = "Setiap kali melepaskan Aliemus Muliakan, dapatkan satu kartu \"Infeksi Racun\" yang dapat memberikan [Arg1] poin Racun. Pada akhir ronde, jika terdapat setiap 3 kartu \"Infeksi Racun\" di tangan, mereka dapat digabungkan menjadi satu kartu \"Serangan Racun\" yang memicu Racun."
  },
  State_20029_Name = {
    Text = "Negara@Relik Alien Tipe Khusus"
  },
  State_20035_Name = {
    Text = "Negara@Pendulum waktu belum tidur"
  },
  State_20038_Name = {
    Text = "Kekacauan Symbiote"
  },
  State_20038_WeaponDesc = {
    Text = "Ketika tim terdiri dari Kekacauan dan profesi lainnya, semua Pembangun mendapatkan 20 Aliemus pada awal giliran."
  },
  State_20039_Desc = {
    Text = "Jika kartu masih berada di tangan saat fase pembuangan, kartu akan menjadi lelah dan tidak akan muncul lagi dalam pertempuran ini."
  },
  State_20039_Name = {
    Text = "<NothingnessIconKeywords:Ilusi>"
  },
  State_20039_WeaponDesc = {
    Text = "Setelah digunakan, kartu tidak akan masuk ke tumpukan kartu buang dan tidak dapat digunakan kembali selama pertempuran ini."
  },
  State_20040_Name = {
    Text = "Negara@Pendulum waktu belum tidur: hitungan"
  },
  State_20041_Desc = {
    Text = "Pada awal giliran, dapatkan 1 Aritmetika untuk setiap 1 musuh dan tarik 1 kartu. Saat membunuh musuh dengan Kerusakan aktif, sebabkan Berdarah pada musuh lainnya sebesar dua kali lipat dari kerusakan berlebih."
  },
  State_20041_Name = {
    Text = "Lagu Kaum yang Terasing"
  },
  State_20042_Desc = {
    Text = "Kerusakan terhadap musuh dalam kondisi negara meningkat sebesar 25%, setelah membunuh musuh, pembunuh mendapatkan 20 Aliemus."
  },
  State_20044_Desc = {
    Text = "Meningkatkan Efek Kelemahan sebesar 10%. Setiap 3 putaran, tambahkan 1 lapis Kelemahan pada semua musuh."
  },
  State_20045_Desc = {
    Text = "Setelah ronde berikutnya dimulai, pilih 3 kartu dari dek dan tambahkan ke tangan."
  },
  State_20045_Name = {
    Text = "Pendulum waktu terbang"
  },
  State_20306_Name = {
    Text = "Relik Sarung Tangan Sihir"
  },
  State_20419_Desc = {
    Text = "Setiap kali memberikan 1 Kerusakan, target akan diberi [Arg1] lapisan Racun. Jika jumlah pemicu dalam Pertempuran ini mencapai 25 kali, segera picu Racun pada seluruh musuh."
  },
  State_20425_Desc = {
    Text = "Pada awal giliran, dapatkan [Layer] poin <PowerIconKeywords:Kekuatan> sementara dan Perisai."
  },
  State_20425_Name = {
    Text = "Pemburu haus darah"
  },
  State_20600_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Daya komputasi yang dikonsumsi oleh [StateArg2]\"Keterampilan\" pertama setiap ronde - [StateArg1]."
  },
  State_20600_Name = {Text = "Pencerahan"},
  State_20601_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Kerusakan \"Serangan\" meningkat [StateArg1]%. Setiap kali menerima serangan, dapatkan [StateArg2] lapisan <EnergyStorageKeywords:Muatan>."
  },
  State_20601_Name = {Text = "Gula"},
  State_20602_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: \"Pukulan\"dapat memilih target dan memberikan [StateArg1] lapisan <PVPSlowKeywords:perlambatan>, efeknya berlipat ganda saat dipicu pada target pertama setiap putaran."
  },
  State_20602_Name = {
    Text = "Tangan yang Dilupakan"
  },
  State_20603_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Exalt\" memberikan <Energy:[Energy:StateArg1]> Aliemus kepada diri sendiri."
  },
  State_20603_Name = {
    Text = "Restitusi Tubuh Terdistorsi"
  },
  State_20604_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: \"Pukulan\"memulihkan <Heal:[Heal:StateArg1]> Hidup sendiri."
  },
  State_20604_Name = {Text = "Hisapan"},
  State_20605_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat dilengkapi<ComaKeywords:Pingsan>diri sendiri. Sebelum \"Exalt\" menghilangkan semua status negatif dari sekutu."
  },
  State_20605_Name = {
    Text = "Tongkat mulia"
  },
  State_20606_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: \"Pukulan\"memberikan <Energy:[Energy:StateArg1]> Aliemus kepada diri sendiri."
  },
  State_20606_Name = {Text = "Kegilaan"},
  State_20607_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: \"Pukulan\" Menyerang musuh dengan <HPAndShieldMax:HP dan Perisai tertinggi>, dan memberikan tambahan <PVPBleedingKeywords:Bleed> sebesar [StateArg1]% dari Kerusakan."
  },
  State_20607_Name = {
    Text = "Terpotong dan Terluka"
  },
  State_20608_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Keterampilan\" dan pada akhir ronde, unit ini mendapatkan <Energy:[Energy:StateArg1]> Aliemus."
  },
  State_20608_Name = {Text = "Bisikan"},
  State_20609_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Karena kehilangan hidup, jumlah Aliemus yang diperoleh menjadi dua kali lipat."
  },
  State_20609_Name = {
    Text = "Mimpi Sang Samudra"
  },
  State_20610_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Kerusakan ditingkatkan \"Pukulan\" [DescArg1]%, setelah \"Exalt\" buat Strength diri sendiri <PVPPowerIconKeywords:Strength>+ [StateArg2] dan Kerusakan ditingkatkan \"Pukulan\" tambahan [StateArg3]%, maksimum 100%."
  },
  State_20610_Name = {
    Text = "Binatang Ruh"
  },
  State_20611_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: \"Keterampilan\"dan pada akhir ronde, pulihkan hidup teman dengan kehilangan hidup terbanyak sebesar <Heal:[Heal:StateArg1]>."
  },
  State_20611_Name = {Text = "Harapan"},
  State_20612_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat giliran berakhir, berikan <Energy:[Energy:StateArg1]> Aliemus kepada sekutu dengan Aliemus paling rendah dan pulihkan <Heal:[Heal:StateArg2]> Hidup kepada sekutu yang kehilangan Hidup terbanyak."
  },
  State_20612_Name = {
    Text = "Kasih Sayangnya"
  },
  State_20613_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Pada akhir ronde, sekutu lainnya mendapatkan <Block:[Block:StateArg1]> perisai."
  },
  State_20613_Name = {
    Text = "Negri Tak Berada"
  },
  State_20614_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Pada akhir ronde, dapatkan [StateArg1] <PVPRetaliateIconKeywords:Counter> sementara."
  },
  State_20614_Name = {
    Text = "Inti Yang Hancur"
  },
  State_20615_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:Setiap giliran \"Serangan\" pertama memberikan tambahan kerusakan [StateArg1], <PVPMethysisKeywords:Racun>."
  },
  State_20615_Name = {
    Text = "Ikatan Kutukan Pahit"
  },
  State_20616_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Pada akhir giliran, mendapatkan <Energy:[Energy:StateArg1]> Aliemus."
  },
  State_20616_Name = {
    Text = "Mata Air Acushnet"
  },
  State_20617_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat putaran berakhir, dapatkan <Block:[Block:StateArg1]> perisai."
  },
  State_20617_Name = {Text = "Terasing"},
  State_20618_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Sebelum \"Exalt\", kedua belah pihak membuang semua kartu tangan dan menarik jumlah kartu yang dibuang +1 kartu."
  },
  State_20618_Name = {
    Text = "Pertunjukan Sulap Riang"
  },
  State_20619_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat dipasang, mendapatkan <Energy:[Energy:StateArg1]> Aliemus. Saat sekutu Awakener melepaskan \"Exalt\", mendapatkan <DelayKeywords:Latensi>: <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_20619_Name = {
    Text = "Himne Penguasa"
  },
  State_20620_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: batas tangan + [StateArg2]. pada akhir giliran, mendapatkan salinan acak dari [StateArg1] Kartu \"Keterampilan\" dalam tangan."
  },
  State_20620_Name = {
    Text = "Moment Pertemuan"
  },
  State_20621_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Sebelum \"Exalt\"<StrengthenKeywords:Memperkuat> dan <ReinforceKeywords:Diperkuat> diri sendiri."
  },
  State_20621_Name = {
    Text = "Anugerah Lewat Penderitaan"
  },
  State_20622_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Pada akhir giliran, diri sendiri mendapatkan <Energy:[Energy:StateArg1]> Aliemus, konsumsi semua Arithmetica yang tersisa, setiap 1 Arithmetica yang dikonsumsi meningkatkan Aliemus yang didapat sebesar [StateArg3]."
  },
  State_20622_Name = {
    Text = "Lahir Dalam Bayangan"
  },
  State_20623_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setelah \"Exalt\", tarik [StateArg1] kartu."
  },
  State_20623_Name = {
    Text = "Kebangkitan"
  },
  State_20624_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:「Exalt」tarik [StateArg1]「Keterampilan」, masukkan salinan [StateArg2] ke dalam tangan."
  },
  State_20624_Name = {
    Text = "Waktu Keberuntungan"
  },
  State_20625_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Exalt\"<DelayKeywords:Latensi>: Balas semua sekutu <Heal:[Heal:StateArg1]> HP."
  },
  State_20625_Name = {
    Text = "Kisah Si Rakus"
  },
  State_20626_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Kerusakan \"pukulan\" meningkat sebesar [StateArg1]%, dan memberikan diri sendiri <ReinforceKeywords:Diperkuat>."
  },
  State_20626_Name = {
    Text = "Keinginan Tak Terhentikan"
  },
  State_20627_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Pada akhir ronde, pulihkan <Heal:[Heal:StateArg1]> HP untuk semua sekutu."
  },
  State_20627_Name = {Text = "Berkat"},
  State_20628_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setelah \"Exalt\" memberikan <Energy:[Energy:StateArg1]> Aliemus kepada sekutu lainnya, Aliemus yang melimpah dari efek ini akan dikembalikan setengah kepada pemakai."
  },
  State_20628_Name = {Text = "Kewajiban"},
  State_20629_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Exalt\" kerusakan, pemulihan, dan efek perisai meningkat [StateArg1]%."
  },
  State_20629_Name = {
    Text = "Setangkai Mawar"
  },
  State_20630_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Pada akhir ronde, dapatkan <Block:[Block:StateArg1]> perisai dan <Energy:[Energy:StateArg2]> aliemus."
  },
  State_20630_Name = {
    Text = "Senandung Musim DIngin"
  },
  State_20631_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Serangan\"<PVPVulnerabilityIconKeywords:Rentan> target. Saat dilengkapi dan pada akhir giliran mendapatkan [StateArg1] lapisan<EnergyStorageKeywords:Pengisian>."
  },
  State_20631_Name = {
    Text = "Titik Kritis"
  },
  State_20632_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Batas kartu tangan +[StateArg1]."
  },
  State_20632_Name = {
    Text = "Pusaran Memori"
  },
  State_20633_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setiap giliran setelah pertama kali menerima serangan aktif musuh, berikan [StateArg1] kerusakan padanya, <PVPEntanglementKeywords:Entwined>."
  },
  State_20633_Name = {
    Text = "Keturunan Yang Putih"
  },
  State_20634_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Kerusakan, pemulihan, dan perisai dari \"Serangan\", \"Keterampilan\", dan \"Muliakan\" meningkat [DescArg1]%, <PVPGrowthKeywords:Berkembang> [StateArg2]%."
  },
  State_20634_Name = {Text = "Senja"},
  State_20635_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: \"Aliemus Muliakan\"memberikan semua sekutu <StrengthenKeywords:Memperkuat> sebelumnya."
  },
  State_20635_Name = {
    Text = "Kekuatan dari yang saleh"
  },
  State_20636_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:Di akhir giliran, dapatkan satu <PVPDerivativeCardKeywords_2:「Ilusi」>，setiap kali memiliki dua <PVPDerivativeCardKeywords_2:「Ilusi」> di tangan, gabungkan mereka menjadi satu <PVPDerivativeCardKeywords_12:「Harapan Kecil」>."
  },
  State_20636_Name = {Text = "Pematangan"},
  State_20637_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>：Di akhir putaran, masukkan [StateArg1] kartu <PVPDerivativeCardKeywords_11:\"Pertukaran Tidak Sama\"> ke dalam tumpukan menggambar."
  },
  State_20637_Name = {
    Text = "Rekam Jejak Tubuh"
  },
  State_20639_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Pada akhir giliran, Pemakai memberikan [StateArg1] Kerusakan kepada musuh dengan <HPAndShieldMax:HP dan Perisai tertinggi>, <PVPMethysisKeywords:Racun>."
  },
  State_20639_Name = {
    Text = "Berkah Dari Yang Membusuk"
  },
  State_20640_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat dipasang dan di awal giliran, memberikan <Damage:[Damage:StateArg1]> kerusakan <PVPBleedingKeywords:Berdarah> kepada semua musuh. Untuk setiap kartu di tangan target, kerusakan <PVPBleedingKeywords:Berdarah> bertambah +[StateArg2]."
  },
  State_20640_Name = {
    Text = "Jamuan Berdarah"
  },
  State_20641_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setelah kematian, berikan [StateArg1] lapisan <PVPProtectiveKeywords:Penghalang> kepada sekutu lainnya."
  },
  State_20641_Name = {
    Text = "Penyebab Kematian"
  },
  State_20642_Desc = {
    Text = "<PVPHoldingKeywords:Memegang>: Setiap kali kamu memainkan kartu, kartu ini berubah menjadi \"Roda takdir\" lain secara acak, dan mengurangi Arithmetica Cost-nya sebesar 1."
  },
  State_20642_Name = {
    Text = "Kelahiran jiwa"
  },
  State_20643_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setelah \"Exalt\" mendapatkan [StateArg1] Arithmetica, <DelayKeywords:Latensi>: mengurangi [StateArg2] Arithmetica."
  },
  State_20643_Name = {
    Text = "Sindrom Amnesia"
  },
  State_20644_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat dipasang menyebabkan [StateArg2] kerusakan pada diri sendiri dan <PVPEntanglementKeywords:Terjerat>. Setiap ada 1 sekutu yang gugur, <StrongEffectKeywords:Amplification> + [StateArg1]."
  },
  State_20644_Name = {
    Text = "Relik Langka"
  },
  State_20645_Name = {
    Text = "Bekal Pengelana"
  },
  State_20646_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Pukulan\" kerusakan ditingkatkan sebesar [StateArg1]%, dan \"Exalt\" memulihkan <Heal:[Heal:StateArg2]> HP kepada diri sendiri."
  },
  State_20646_Name = {
    Text = "Senandung Tidur Senyap"
  },
  State_20647_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: 「Exalt」menempatkan [StateArg1] kartu <PVPDerivativeCardKeywords_11:「Pertukaran Tidak Setara」> di tangan."
  },
  State_20647_Name = {
    Text = "Di Balik Hujan Lebat"
  },
  State_20648_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Pada awal ronde, dapatkan <PVPWonderfulEffectKeywords:Efek Menakjubkan> positif. Saat musuh menggunakan \"Geng\" untuk pertama kalinya setiap ronde, [StateArg1] kartu \"Pemandangan Gemerlap\" akan dimasukkan ke tangan."
  },
  State_20648_Name = {
    Text = "Perjamuan Sunyi"
  },
  State_20649_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Exalt\" menempatkan kartu \"Keterampilan\" yang dimainkan terakhir pada putaran sebelumnya ke dalam tangan, dan mengurangi Arithmetica Cost-nya sebesar 1. Jika efek serupa dipicu berkali-kali, maka akan ditelusuri ke belakang."
  },
  State_20649_Name = {
    Text = "Mengulang Waktu"
  },
  State_20650_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat dilengkapi, <ComaKeywords:Pingsan> diri sendiri. Sebelum \"Exalt\", menghilangkan semua Negara positif seluruh musuh."
  },
  State_20650_Name = {Text = "Delirium"},
  State_20651_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Pada akhir ronde, tarik [StateArg1] kartu."
  },
  State_20651_Name = {
    Text = "Keserakahan"
  },
  State_20652_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setelah \"Exalt\", menyebabkan seluruh musuh [StateArg1] kerusakan, <DisarmKeywords:Kelumpuhan>."
  },
  State_20652_Name = {Text = "Hukuman"},
  State_20653_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: \"Pukulan\"dapat memilih target dan mengurangi <Energy:[Energy:StateArg1]> Aliemus dari target."
  },
  State_20653_Name = {
    Text = "Tenggelam dalam Hasrat"
  },
  State_20654_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Pada awal ronde, <PVPSeriousInjuryKeywords:Blighten> diri sendiri dan mendapatkan <Damage:[Damage:StateArg1]> lapis <PVPCorrosionKeywords:Tanda Dosa>. Pada akhir ronde, <ReinforceKeywords:Fortress> diri sendiri."
  },
  State_20654_Name = {
    Text = "Perintah Sang Ratu"
  },
  State_20655_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:Kerusakan \"Serangan\" meningkat [StateArg1]%，\"Serangan\" bisa memilih target."
  },
  State_20655_Name = {Text = "Kebaikan"},
  State_20656_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>：Kerusakan, pemulihan, dan efek perisai yang dihasilkan oleh \"Keterampilan\" meningkat [StateArg1]%, jika tidak ada <PVPProtectiveKeywords:Penghalang> setelah menggunakan \"Keterampilan\" maka memperoleh 1 lapisan."
  },
  State_20656_Name = {
    Text = "Syair Terakhir"
  },
  State_20657_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setiap putaran, ketika lawan memainkan kartu \"Keterampilan\" ke-[StateArg1], tempatkan salinan kartu tersebut dengan pengurangan konsumsi aritmetika sebesar [StateArg2] di tanganmu."
  },
  State_20657_Name = {Text = "Ilham"},
  State_20658_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: \"Serangan\"Setiap serangan terhadap satu target memberikan [StateArg1] Aritmetika."
  },
  State_20658_Name = {
    Text = "Senandung Dari Yang Terbelenggu"
  },
  State_20659_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setelah mati, di awal giliran berikutnya <PVPResurrectionKeywords:hidup kembali> diri sendiri dan mendapatkan <Heal:[Heal:StateArg1]> hidup serta <Block:[Block:StateArg2]> perisai, kemudian menghancurkan \"Roda takdir\" ini."
  },
  State_20659_Name = {Text = "Vitalitas"},
  State_20660_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Exalt\" memberikan semua sekutu <Block:[Block:StateArg1]> perisai."
  },
  State_20660_Name = {
    Text = "Penghalang hati"
  },
  State_20661_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Exalt\" menyebabkan <Damage:[Damage:StateArg1]> kerusakan <PVPBleedingKeywords:Berdarah> kepada semua musuh."
  },
  State_20661_Name = {
    Text = "Jalan Yang Terlupakan"
  },
  State_20662_Desc = {
    Text = "<PVPWeaponKeywords:Roda Takdir>: Saat giliran berakhir, setiap poin <PVPCapKeywords:batas atas daya komputasi> memberikan [StateArg1] <PVPBleedingKeywords:perdarahan> kepada musuh dengan <HPAndShieldMin:HP dan perisai terendah>, dengan total kerusakan <PVPBleedingKeywords:perdarahan> sebesar <Damage:[Damage:DescArg1]>."
  },
  State_20662_Name = {
    Text = "Bersembunyi dalam kegelapan malam"
  },
  State_20663_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Exalt\" sebelum menghilangkan Negara negatif sendiri, dan mendapatkan [StateArg1] lapisan <EnergyStorageKeywords:Muatan>."
  },
  State_20663_Name = {
    Text = "Belenggu Terbuka"
  },
  State_20664_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Keterampilan\" memberikan diri sendiri <ReinforceKeywords:Diperkuat>."
  },
  State_20664_Name = {
    Text = "Sumpah Ksatria"
  },
  State_20665_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Jika tidak ada negara negatif yang dapat dibuang saat mencoba membuang negara negatif, pulihkan <Heal:[Heal:StateArg1]> hidup. Pada akhir giliran, <DelayKeywords:Tunda>: Buang negara negatif pada diri sendiri."
  },
  State_20665_Name = {
    Text = "Arungan Takdir"
  },
  State_20666_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setelah \"Exalt\" membuat sekutu dengan <HPAndShieldMin:HP dan Perisai terendah> mendapatkan [StateArg1] tumpukan <PVPProtectiveKeywords:Barrier>."
  },
  State_20666_Name = {
    Text = "Kepada sahabat tercinta"
  },
  State_20667_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Kerusakan \"Keterampilan\" pertama pemegang yang dikeluarkan setiap giliran meningkat sebesar [StateArg1]%."
  },
  State_20667_Name = {
    Text = "Pedang Sang Raksasa"
  },
  State_20668_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: saat Pembangun kita mati, menyebabkan kerusakan <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:Berdarah> pada semua musuh. Saat penggunanya mati, memberikan kerusakan tambahan <Damage:[Damage:StateArg2]> <PVPBleedingKeywords:Berdarah>."
  },
  State_20668_Name = {
    Text = "Matinya Ny. Coral"
  },
  State_20669_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:Saat dipasang dan pada awal giliran, jika tidak memiliki <PVPProtectiveKeywords:Penghalang> mendapatkan [StateArg1] lapisan <PVPProtectiveKeywords:Penghalang>, jika tidak, kurangi 1 konsumsi aritmetika dari 1 kartu \"Keterampilan\" dengan konsumsi aritmetika tertinggi di tangan."
  },
  State_20669_Name = {
    Text = "Prasasti Kitab Suci"
  },
  State_20670_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Pukulan\" menyebabkan <PVPSeriousInjuryKeywords:luka parah>, kerusakan meningkat [StateArg1]%, tetapi membuat pemain kehilangan setengah dari Hidup sebesar Kerusakan."
  },
  State_20670_Name = {Text = "Sirip Duka"},
  State_20671_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Exalt\" memulihkan diri sendiri <Heal:[Heal:StateArg1]> HP."
  },
  State_20671_Name = {
    Text = "Kebangkitan Abadi"
  },
  State_20672_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>：Pada akhir giliran, mengurangi aritmetika konsumsi tertinggi dari satu kartu di tangan -[StateArg1]。<PrepareKeywords:Persiapan>。"
  },
  State_20672_Name = {
    Text = "Fokuskan Roh"
  },
  State_20673_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Exalt\" memberikan diri sendiri <Block:[Block:StateArg1]> perisai, dan sekutu lainnya mendapatkan <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_20673_Name = {
    Text = "Unsur Tidak Terduga"
  },
  State_20696_Name = {
    Text = "Negara@Raksasa yang Ditakuti"
  },
  State_20723_Desc = {
    Text = "Kerusakan kartu serangan meningkat sebesar [Layer]."
  },
  State_20723_Name = {
    Text = "Peningkatan Kerusakan Tetap Kartu Pukulan__\"仅开发用\""
  },
  State_20724_Desc = {
    Text = "Kerusakan kartu serangan berkurang sebesar [Layer]."
  },
  State_20724_Name = {
    Text = "Pengurangan kerusakan tetap kartu pukulan"
  },
  State_20749_Desc = {
    Text = "Jumlah Pelacakan Umum.__\"Khusus pengembangan\""
  },
  State_20758_Desc = {
    Text = "Pada awal ronde berikutnya, tarik [Layer] kartu."
  },
  State_20758_Name = {
    Text = "Penarikan kartu tertunda"
  },
  State_20766_Desc = {
    Text = "Efek spesifik lihat logika pukulan umum.__\"Khusus pengembangan\""
  },
  State_20802_Desc = {
    Text = "Kartu ini tidak dapat dikeluarkan.__\"Hanya untuk pengembangan\""
  },
  State_20802_Name = {
    Text = "Tidak bisa dimainkan__\"Hanya untuk pengembangan\""
  },
  State_20803_Desc = {
    Text = "Kartu ini -1 Lelah Aritmetika. Setelah menggunakan Kartu lain, kartu ini akan berubah menjadi Kartu Roda Takdir acak lainnya."
  },
  State_20803_Name = {
    Text = "<CardKeyWord:Kelahiran jiwa>"
  },
  State_20805_Desc = {
    Text = "Kartu tidak akan masuk ke tumpukan kartu buang selama fase pembuangan, melainkan tetap berada di tangan."
  },
  State_20805_Name = {
    Text = "<RetainIconKeywords:Simpan>"
  },
  State_20806_Desc = {
    Text = "Setelah dimainkan, kartu tidak akan masuk ke Tumpukan kartu buang, melainkan dihapus dari dek."
  },
  State_20806_Name = {
    Text = "<DepleteIconKeywords:Lelah>"
  },
  State_20820_Desc = {
    Text = "Pada awal ronde berikutnya, bangkit kembali dan dapatkan [Layer] Hidup serta [Layer] Perisai."
  },
  State_20820_Name = {
    Text = "Penghidupan Kembali Tertunda"
  },
  State_20851_Name = {Text = "Grant Card"},
  State_20981_Desc = {
    Text = "\"Bangun\"sudah terbangun, kerusakan yang dihasilkan akan meningkat secara signifikan."
  },
  State_20981_Name = {
    Text = "Uvhash Bangun!"
  },
  State_20981_WeaponDesc = {
    Text = "Pada ronde berikutnya, dapatkan perisai sejumlah kehilangan hidup dari ronde sebelumnya."
  },
  State_20982_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_20982_Name = {Text = "Not Roused"},
  State_20988_Desc = {
    Text = "Aliemus awal +80. Setiap putaran mendapatkan 20 poin Aliemus."
  },
  State_20988_Name = {
    Text = "Narsis·Pertemuan Pertama"
  },
  State_20989_Desc = {
    Text = "Aliemus awal +80. Setiap putaran mendapatkan 2 Aritmetika dan 20 Aliemus."
  },
  State_20989_Name = {
    Text = "Tulu · Pertemuan Pertama"
  },
  State_21306_Desc = {
    Text = "Setiap ronde mengatur ulang kombo"
  },
  State_21306_Name = {
    Text = "Combo direset"
  },
  State_21307_Desc = {
    Text = "Setiap lapisan menambah jumlah serangan sebanyak 1. Saat menerima kerusakan, kehilangan 1 lapisan (minimum 1 lapisan). Pada akhir giliran, semua lapisan hilang."
  },
  State_21307_Name = {Text = "Combo"},
  State_21342_Desc = {
    Text = "Pada awal ronde berikutnya, dapatkan [Layer] Sembuh."
  },
  State_21342_Name = {
    Text = "Penyembuhan tertunda"
  },
  State_21345_Desc = {
    Text = "Sebelum Ritual Penurunan Dewa dimulai, setelah mati akan bangkit kembali, menghilangkan kondisi negatif, kebal terhadap kerusakan dan memulihkan 30% HP. Setelah Ritual Penurunan Dewa dimulai, setelah mati akan bangkit sepenuhnya, menghilangkan kondisi negatif dan Obsesi Ritual, serta memanggil dua Clan."
  },
  State_21345_Name = {
    Text = "Kecanduan Ritual"
  },
  State_21358_Desc = {
    Text = "Pemain ini tidak memiliki batas kartu tangan.__\"Khusus pengembangan\""
  },
  State_21381_Name = {
    Text = "Jumlah penggunaan segel"
  },
  State_21385_Desc = {
    Text = "Setiap kehilangan 1 poin Hidup akan mengurangi 1 lapisan. Ketika jumlah lapisan berkurang menjadi 0, Niat akan berubah menjadi Muliakan dengan Kerusakan tinggi dan Efek petrifikasi akan dihilangkan."
  },
  State_21385_Name = {
    Text = "Kegilaan Darah"
  },
  State_21450_Desc = {
    Text = "Saat giliran berikutnya dimulai, hilangkan status negatif yang ada pada diri sendiri."
  },
  State_21450_Name = {
    Text = "Penundaan Pemurnian"
  },
  State_21488_Desc = {
    Text = "Efek spesifik lihat logika pukulan umum.__\"Khusus pengembangan\""
  },
  State_21492_Desc = {
    Text = "Kerusakan akan meningkat sebesar 50% saat kritis."
  },
  State_21492_Name = {
    Text = "<CardKeyWord:Kritikal>"
  },
  State_21546_Desc = {
    Text = "Pada awal ronde berikutnya, dapatkan [Layer] Perisai."
  },
  State_21546_Name = {
    Text = "Perisai Latensi"
  },
  State_21547_Desc = {
    Text = "Pada awal ronde, pertahankan setengah dari perisai."
  },
  State_21547_Name = {Text = "Ketahanan"},
  State_21548_Desc = {
    Text = "Pada awal giliran berikutnya, dapatkan Memperkuat."
  },
  State_21548_Name = {
    Text = "Penguatan tertunda"
  },
  State_21580_Desc = {
    Text = "Pemburu Tengkorak sedang melacak jejak gerakanmu. Setiap kali kamu menarik 1 kartu, Pemburu Tengkorak mendapatkan [StateArg1] Kekuatan sementara."
  },
  State_21580_Name = {Text = "Melacak"},
  State_21587_Name = {
    Text = "Pada giliran ini, telah ditemukan Pembangun Bangun acak baru"
  },
  State_21590_Name = {
    Text = "Mencoba mencari jumlah Pembangun baru yang di-Bangun"
  },
  State_21601_Name = {
    Text = "Pembangun baru ditemukan"
  },
  State_21616_Desc = {
    Text = "Setelah menggunakan Muliakan, segel semua Pembangun selama satu putaran."
  },
  State_21616_Name = {
    Text = "Jejak Penjelajah"
  },
  State_21671_Name = {
    Text = "Menyebabkan kerusakan area__\"Hanya untuk pengembangan\""
  },
  State_21688_Name = {
    Text = "Dapat digunakan 1 kali"
  },
  State_21689_Name = {
    Text = "Dapat digunakan 2 kali"
  },
  State_21720_Desc = {
    Text = "Menyebabkan efek yang sama pada Pembangun di belakang target, jika tidak ada Pembangun di belakangnya, hanya memberikan efek pada target."
  },
  State_21720_Name = {
    Text = "<CardKeyWord:Menembus>"
  },
  State_21726_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setelah pemegang peralatan memainkan \"Keterampilan\" pertama mereka setiap putaran, salin satu dengan pengurangan konsumsi aritmetika - [StateArg1] ke dalam tumpukan menggambar."
  },
  State_21726_Name = {Text = "Fouetté"},
  State_21744_Name = {
    Text = "Mencoba mencari jumlah Pembangun baru yang di-Bangun"
  },
  State_21745_Name = {
    Text = "Pembangun baru ditemukan"
  },
  State_21746_Name = {
    Text = "Pada giliran ini, telah ditemukan Pembangun Bangun acak baru"
  },
  State_21747_Desc = {
    Text = "Ada [Layer] Pembangun Bangun sedang diburu, setiap kali Pembangun Bangun yang diburu menggunakan satu Kartu, \"Pemburu Kepala Ganas\"akan menambahkan 1 lapis Tanda Perburuan."
  },
  State_21747_Name = {
    Text = "Ritual Perburuan"
  },
  State_21751_Desc = {
    Text = "Tarik setengah dari jumlah lapisan Tanda Berburu ([DescArg1]), jumlah lapisan Tanda Berburu \"Pemburu Tengkorak Brutal\"+1."
  },
  State_21751_Name = {
    Text = "<CardKeyWord:Diburu>"
  },
  State_21754_Desc = {
    Text = "Setelah kematian, hilangkan semua kekuatan sementara dari \"Pemburu Tengkorak Liar\" dan kurangi setengah jumlah lapisan \"Tanda Perburuan\"."
  },
  State_21754_Name = {
    Text = "Penyejukan singkat"
  },
  State_21765_Desc = {
    Text = "· Dapat memberikan satu Pembangun sekutu dengan ‘Roda takdir’, sehingga menghasilkan efek ‘Roda takdir’.\n· Saat Pembangun diberikan ‘Roda takdir’ lagi, Roda takdir yang lama akan dihancurkan dan yang baru akan dipertahankan.\n· Setelah Pembangun meninggal, ‘Roda takdir’ yang dipasang akan dihancurkan.\n· Jika ‘Roda takdir’ dipasang pada Pembangun yang sudah meninggal, maka Roda takdir itu akan dihancurkan dan sekaligus mendapatkan satu Ilusi dan mengembalikan konsumsi aritmetika."
  },
  State_21765_Name = {
    Text = "<PVPWeaponKeywords:Roda takdir>"
  },
  State_21785_Name = {
    Text = "Pertempuran teriakan"
  },
  State_21787_Name = {
    Text = "Tambahkan teriakan pertempuran"
  },
  State_21826_Name = {
    Text = "Raja Anak-anak berteriak di awal"
  },
  State_21829_Name = {
    Text = "Deathrattle Effect"
  },
  State_21838_Name = {
    Text = "Pengenalan Awal"
  },
  State_21843_Name = {
    Text = "Tambahkan status di awal"
  },
  State_21895_Name = {
    Text = "Panggilan Pembuka"
  },
  State_21905_Desc = {
    Text = "\"Serangan\"memperoleh 2 poin Aritmetika, membuang 1 kartu secara acak; \"Pertahanan\"menarik 2 kartu, kehilangan 1 poin Aritmetika."
  },
  State_21928_Name = {Text = "Petunjuk"},
  State_22054_Name = {
    Text = "Panggilan Pembuka"
  },
  State_22055_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_22055_Name = {Text = "Not Roused"},
  State_22067_Desc = {
    Text = "Setelah ronde berakhir, 1 Tentakel akan melakukan Serangan sebanyak [Layer] kali."
  },
  State_22067_Name = {
    Text = "Pertemuan Tentakel"
  },
  State_22074_Desc = {
    Text = "Bertahan hidup hingga giliran ketujuh mengubah Niat menjadi Tatapan, pada giliran kedelapan dan seterusnya mengubah Niat menjadi Pencemaran."
  },
  State_22134_Desc = {
    Text = "Pierce DMG akan sekaligus merusak HP, Perisai, dan Barrier target."
  },
  State_22134_Name = {
    Text = "<CardKeyWord:Pierce DMG>"
  },
  State_22157_Desc = {
    Text = "Ketika hidup berada di bawah 50% ([StateArg1]), akan terbelah menjadi \"Arus\" dan \"Pasang\" dengan jumlah hidup yang sama."
  },
  State_22157_Name = {Text = "Terbelah"},
  State_22204_Desc = {
    Text = "Setelah putaran dimulai, dapatkan [Layer]% Crit. Rate sementara dan Crit. DMG sementara."
  },
  State_22204_Name = {
    Text = "Suara lembut bertahap meningkat"
  },
  State_22204_WeaponDesc = {
    Text = "Jika tidak kehilangan hidup hingga awal giliran berikutnya, Crit. Rate giliran berikutnya +[StateArg1]%."
  },
  State_22210_Desc = {
    Text = "Lelah Aritmetika + 100, dan tidak dapat menggunakan pukulan, tidak dapat memperoleh Aliemus."
  },
  State_22210_Name = {
    Text = "Super Lambat"
  },
  State_22238_Name = {
    Text = "Pertarungan Kematian Pemain__\"Hanya untuk pengembangan\""
  },
  State_22239_Name = {
    Text = "Menerapkan Pertarungan Kematian Pemain__\"Hanya untuk pengembangan\""
  },
  State_22249_Desc = {
    Text = "Setelah giliran berikutnya dimulai, kurangi pengambilan sebanyak [Layer] kartu."
  },
  State_22249_Name = {
    Text = "Pertukaran Tidak Setara"
  },
  State_22300_Desc = {
    Text = "Kartu pukulan ini tidak dapat dimainkan."
  },
  State_22300_Name = {
    Text = "Kartu Pukulan menyerah tidak dapat dimainkan"
  },
  State_22303_Desc = {
    Text = "Setiap kali menerima kerusakan, berikan satu lapisan sementara \"Lambat\" pada kartu acak di tangan, dan setelah perisai terpecahkan, hilangkan status \"Perisai es\"."
  },
  State_22303_Name = {Text = "Perisai es"},
  State_22324_Desc = {
    Text = "Setiap ada 1 lapisan, serangan bertambah 1 segmen dalam putaran ini."
  },
  State_22324_Name = {
    Text = "Gema Gelombang Amarah"
  },
  State_22325_Desc = {
    Text = "Setelah setiap serangan diterima, dapatkan [StateArg1] poin Kekuatan sementara."
  },
  State_22325_Name = {
    Text = "Sang Gergaji"
  },
  State_22326_Desc = {
    Text = "Kamu terkunci! Setelah dimainkan, Penjaga Pelaut mendapatkan 1 tingkat Kegilaan sementara, dan Tanda gemuruh dari kartu perintah ini dihapus."
  },
  State_22326_Name = {
    Text = "<CardKeyWord:Tanda gemuruh>"
  },
  State_22328_Desc = {
    Text = "Setiap kali menggunakan kartu perintah dengan \"Tanda gemuruh\", jumlah serangan pada ronde ini bertambah +1."
  },
  State_22328_Name = {
    Text = "Gema Gelombang Amarah"
  },
  State_22334_Desc = {
    Text = "Setiap kali memainkan 1 kartu \"Serangan\", letakkan [StateArg1] kartu \"Luka\" di atas tumpukan kartu Menggambar."
  },
  State_22334_Name = {Text = "Luka"},
  State_22404_Desc = {
    Text = "Perisai yang dihasilkan dalam pertempuran ini meningkat sebesar [Layer] poin."
  },
  State_22404_Name = {Text = "Alert"},
  State_22405_Desc = {
    Text = "Perisai yang dihasilkan dalam pertempuran ini meningkat."
  },
  State_22405_Name = {
    Text = "<PVPAlertKeywords:Waspada>"
  },
  State_22702_Desc = {
    Text = "Kartu pertama yang dimainkan setiap ronde akan memicu efek tambahan."
  },
  State_22702_Name = {
    Text = "<CardKeyWord:Serangan Mendadak>"
  },
  State_22706_Name = {
    Text = "Tanda Serangan"
  },
  State_22707_Desc = {
    Text = "Setelah memainkan kartu setiap ronde, beri tanda status Ambush kepada pemain__\"Hanya untuk pengembangan\""
  },
  State_22707_Name = {
    Text = "Pemicu Serangan Mendadak__\"Hanya untuk pengembangan\""
  },
  State_22721_Name = {
    Text = "Pendulum Waktu \"Tersesat\""
  },
  State_23405_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mendapatkan kekuatan yang setara dengan jumlah lapisan counter saat ini, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_23405_Name = {Text = "Not Roused"},
  State_23406_Desc = {
    Text = "\"Penghuni Kedalaman\"akan memperoleh [StateArg1] lapisan Counter setiap akhir ronde."
  },
  State_23406_Name = {
    Text = "Caecus Bangun!"
  },
  State_23512_Name = {
    Text = "Berikan Seribu bayangan"
  },
  State_23514_Name = {
    Text = "Berikan Seribu bayangan"
  },
  State_23515_Name = {
    Text = "Berikan Seribu bayangan"
  },
  State_23516_Name = {
    Text = "Berikan Seribu bayangan"
  },
  State_23517_Name = {
    Text = "Memberikan pemain BUFF"
  },
  State_23518_Desc = {
    Text = "Menyebabkan rentan selama 2 putaran / menambah 1 kali serangan / menyebabkan pengurangan kekuatan."
  },
  State_23518_Name = {
    Text = "<CardKeyWord:Niat pilihan>"
  },
  State_23519_Name = {Text = "Niat 2b"},
  State_23520_Name = {Text = "Niat 2c"},
  State_23521_Name = {
    Text = "Ketika dibuang, habiskan, kurangi semua Awakener [StateArg1] Aliemus, dan masukkan 5 kartu \"Gejala\" ke dalam tumpukan Menggambar pemain."
  },
  State_23522_Name = {
    Text = "Saat dibuang, Habiskan, kurangi semua Awakener [StateArg1] Aliemus"
  },
  State_23524_Name = {Text = "Niat 3a"},
  State_23525_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_23525_Name = {Text = "Not Roused"},
  State_23526_Name = {Text = "Niat 2a"},
  State_23527_Name = {Text = "Niat 3c"},
  State_23528_Name = {Text = "Niat 3b"},
  State_23529_Desc = {
    Text = "Meningkatkan Kekuatan / Menyebabkan Kerusakan Tambahan / Mendapatkan Perisai"
  },
  State_23529_Name = {
    Text = "<CardKeyWord:Niat pilihan>"
  },
  State_23530_Desc = {
    Text = "Saat menggunakan\"Seribu bayangan\"diperlukan dua pilihan niat. Jika dibuang, semua Pembangun kehilangan 20 Aliemus, dan 5 kartu\"Gejala\"dicampur ke dalam tumpukan gambar pemain."
  },
  State_23530_Name = {
    Text = "Narsis Bangun!"
  },
  State_23531_Name = {
    Text = "Berikan Seribu bayangan"
  },
  State_23532_Name = {
    Text = "Berikan Seribu bayangan"
  },
  State_23533_Desc = {
    Text = "Cuci Kartu gejala / Terapkan berdarah / Turunkan kegilaan"
  },
  State_23533_Name = {
    Text = "<CardKeyWord:Niat pilihan>"
  },
  State_23534_Name = {Text = "Niat 1a"},
  State_23535_Name = {Text = "Niat 1c"},
  State_23536_Name = {Text = "Niat 1b"},
  State_23612_Desc = {
    Text = "Setiap kehilangan 1 poin Hidup akan mengurangi 1 lapisan. Ketika jumlah lapisan berkurang menjadi 0, Niat akan berubah menjadi Muliakan dengan Kerusakan tinggi dan Efek petrifikasi akan dihilangkan."
  },
  State_23612_Name = {
    Text = "Kegilaan Darah·Akhir"
  },
  State_23687_Name = {
    Text = "Pendulum Waktu \"Gelombang\""
  },
  State_23726_Desc = {
    Text = "Sebelum giliran berikutnya, akan mencegah kematian Pembangun sebanyak 1 kali, maksimal 1 lapis."
  },
  State_23726_Name = {Text = "Ketahanan"},
  State_23732_Desc = {
    Text = "Hingga sebelum giliran berikutnya dimulai, setiap menerima 1 kali Active DMG, mendapatkan [Layer] tumpukan <PainWord:Bertahan>."
  },
  State_23732_Name = {
    Text = "Rawa terlarang"
  },
  State_23736_Name = {
    Text = "Jumlah kartu yang ditarik dalam putaran ini"
  },
  State_23737_Name = {
    Text = "Rekam Jumlah Menggambar"
  },
  State_23741_Name = {
    Text = "Terapkan catatan menggambar"
  },
  State_23744_Desc = {
    Text = "Jika tidak ada \"Mayat\" di arena, panggil 1 \"Mayat\" pada awal giliran. Setiap pemanggilan akan meningkatkan Hidup."
  },
  State_23744_Name = {
    Text = "Pemanggilan Mayat"
  },
  State_23747_Name = {
    Text = "Memperkuat Nyawa"
  },
  State_23748_Name = {
    Text = "Jumlah Pemanggilan"
  },
  State_23769_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_23769_Name = {Text = "Not Roused"},
  State_23771_Desc = {
    Text = "\"Ahli Ilmu Gaib\"sudah bangun, hati-hati dengan \"Fatamorgana\" yang menciptakan duplikat. Setelah bangun, setiap kali lawan memainkan 1 Kartu, Casiah mendapatkan 1 lapisan \"Fatamorgana\"."
  },
  State_23771_Name = {
    Text = "Kasya Bangun!"
  },
  State_23771_WeaponDesc = {
    Text = "Pada ronde berikutnya, dapatkan perisai sejumlah kehilangan hidup dari ronde sebelumnya."
  },
  State_23782_Desc = {
    Text = "Setelah mendapatkan 10 lapisan Fatamorgana, kosongkan jumlah lapisan \"Fatamorgana\"dan memanggil 1 replika di depan, dengan maksimal 2 replika. Saat dipanggil, replika akan membawa 3 lapisan <ParcloseIconKeywords:Penghalang>."
  },
  State_23782_Name = {
    Text = "Fatamorgana"
  },
  State_23786_Name = {
    Text = "Negara@Pembangun Casiah mengambil benda dari jarak jauh"
  },
  State_23787_Name = {
    Text = "Negara@Pembangun Casiah@Mengambil benda dari jarak jauh@Pengurangan Menggambar"
  },
  State_23788_Desc = {
    Text = "Pada awal ronde ke-3, tambahkan 1 kartu \"Gema Masa Lalu—Buang semua kartu di tangan, kembalikan hidup dan perisai saat ini ke kondisi pada akhir ronde sebelumnya. Tahan, lelah.\"ke tangan."
  },
  State_23791_Name = {
    Text = "Pesan Pembuka"
  },
  State_23823_Name = {Text = "Bom 1"},
  State_23825_Name = {
    Text = "Negara@Pembangun Casiah@Hilang"
  },
  State_23827_Desc = {
    Text = "Setelah digunakan, kehilangan [DescArg1] poin Kesehatan maksimum. Sang Grand Magician mendapatkan 1 tingkat \"Sangat Puas\" di ronde ini."
  },
  State_23827_Name = {
    Text = "<CardCheerKeywords:Minum>"
  },
  State_23828_Desc = {
    Text = "Sang Grand Magician saat ini sangat menikmati pertunjukannya. Setiap ada 1 lapisan \"Sangat Puas\", efek keterampilannya akan melemah dan mengalami pengurangan kekuatan sebesar [DescArg1], hingga maksimal 5 lapisan."
  },
  State_23828_Name = {
    Text = "puas dengan diri sendiri"
  },
  State_23871_Desc = {
    Text = "Menambah Kesehatan Maksimum tidak akan menambah Hidup saat ini secara bersamaan. Mengurangi Kesehatan Maksimum akan menghilangkan kelebihan Hidup saat ini jika ada, dan Kesehatan Maksimum paling sedikit adalah 1, tidak direset setelah kematian."
  },
  State_23871_Name = {
    Text = "<MaxHPColour:Kesehatan maksimum>"
  },
  State_23934_Name = {
    Text = "Negara@Mendengarkan Kartu Keterampilan Telekinesis"
  },
  State_23935_Name = {
    Text = "Negara@Pembangun Casiah@Efek Pengambilan Benda dari Jarak Jauh"
  },
  State_2393_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_2393_Name = {Text = "Not Roused"},
  State_2394_Name = {
    Text = "Peningkatan Kekuatan Merah Menyala untuk Mencerahkan"
  },
  State_2395_Name = {
    Text = "Aksesori Pesta dari Kekjauhan"
  },
  State_2395_WeaponDesc = {
    Text = "\"Pertahanan\"meningkatkan Perisai sebesar 30%. Jika penurunan Segil Hitam pemakai lebih dari 15%, \"Pertahanan\"akan meningkatkan Perisai tambahan sebesar 30%."
  },
  State_2396_Desc = {
    Text = "Crit. DMG meningkat sebesar 20%. Serangan terhadap musuh dengan perisai selalu menghasilkan kritis."
  },
  State_2398_Desc = {
    Text = "Saat menerima kerusakan, peroleh [Layer] perisai. Setiap kali menerima kerusakan, perisai akan terus bertambah dan pulih pada akhir ronde."
  },
  State_2398_Name = {
    Text = "Barier dimensi"
  },
  State_2398_WeaponDesc = {
    Text = "Kerusakan aktif yang diterima meningkat sebesar [Layer]. Setiap kali menerima kerusakan, luka pelarutan akan bertambah luas, dan sembuh pada awal giliran."
  },
  State_2399_Desc = {
    Text = "Setelah menyebabkan pemulihan hidup, semua Pembangun mendapatkan 3 poin Aliemus. Setiap kali ke-5 menyebabkan pemulihan hidup, kerusakan Muliakan dalam pertempuran ini meningkat sebesar [Arg1]."
  },
  State_2400_Desc = {
    Text = "Batas maksimal tentakel bertambah 1. Saat hidup di bawah 50%, kerusakan tentakel meningkat sebesar [StateArg1]."
  },
  State_2400_Name = {
    Text = "Tribut Masa Lalu dari Relik"
  },
  State_2400_WeaponDesc = {
    Text = "Batas maksimal tentakel bertambah 1. Saat hidup di bawah 50%, kerusakan tentakel meningkat sebesar [StateArg1]."
  },
  State_2401_Desc = {
    Text = "Pada awal ronde, tambahkan kartu dari bagian atas tumpukan kartu buang ke tangan."
  },
  State_2402_Desc = {
    Text = "Pada awal ronde, untuk setiap 1 kartu di Ultra Space, dapatkan [Arg1] Kekuatan sementara selama ronde ini."
  },
  State_2403_Desc = {
    Text = "Perisai yang diberikan dalam pertempuran ini meningkat sebesar [Layer] poin."
  },
  State_2403_Name = {Text = "Alert"},
  State_2403_WeaponDesc = {
    Text = "Perisai yang diberikan dalam pertempuran ini meningkat sebesar [Layer] poin."
  },
  State_2404_Desc = {
    Text = "Menghapus 1 Kartu Gejala saat diambil. Tingkat Orison Keberuntungan meningkat sebesar 50%."
  },
  State_2405_Desc = {
    Text = "Ubah sementara kekuatan aritmetika kartu"
  },
  State_2405_Name = {
    Text = "Ubah sementara kekuatan aritmetika kartu"
  },
  State_2405_WeaponDesc = {
    Text = "Ubah sementara kekuatan aritmetika kartu"
  },
  State_2406_Desc = {
    Text = "Ketika poin Aritmetika terakhir habis, dapatkan 2 Aritmetika. Maksimal dipicu 2 kali per ronde."
  },
  State_2407_Name = {
    Text = "Nilai observasi"
  },
  State_2408_Name = {
    Text = "Peluit Pelaut"
  },
  State_2409_Desc = {
    Text = "Setiap kali memainkan 1 kartu [Serangan] dalam ronde ini, Lelah Aritmetika -1."
  },
  State_2409_Name = {
    Text = "Pedang Pemberontak"
  },
  State_2409_WeaponDesc = {
    Text = "Setiap kali memainkan 1 kartu [Serangan] dalam ronde ini, Lelah Aritmetika -1."
  },
  State_2410_Desc = {
    Text = "Tidak bisa bergerak selama 1 ronde. Musuh yang pernah dipetrifikasi tidak dapat diberi Efek petrifikasi lagi."
  },
  State_2410_Name = {
    Text = "<PetrifactionIconKeywords: Petrifikasi>"
  },
  State_2410_WeaponDesc = {
    Text = "Membuat monster pusing selama satu putaran."
  },
  State_2411_Desc = {
    Text = "Pada akhir ronde, tim kami akan menerima [Layer] lapisan Berdarah."
  },
  State_2411_Name = {
    Text = "Lampu Darah"
  },
  State_2411_WeaponDesc = {
    Text = "Pada akhir ronde, tim kami akan menerima [Layer] lapisan Berdarah."
  },
  State_2412_Desc = {
    Text = "Kerusakan yang diberikan pada giliran berikutnya akan dilipatgandakan."
  },
  State_2412_Name = {
    Text = "Keluar dari Kebuntuan"
  },
  State_2412_WeaponDesc = {
    Text = "Kerusakan yang diberikan pada giliran berikutnya akan dilipatgandakan."
  },
  State_2413_Desc = {
    Text = "Pengurangan Aliemus yang diperoleh dari serangan dan pertahanan sebesar [Layer]%."
  },
  State_2413_Name = {Text = "Void"},
  State_2413_WeaponDesc = {
    Text = "Serangan dan pertahanan meningkatkan Aliemus sebesar [StateArg1]%."
  },
  State_2415_Desc = {
    Text = "Jika menerima kerusakan pada ronde sebelumnya, dapatkan kekebalan selama 1 ronde di awal ronde."
  },
  State_2415_Name = {Text = "Adaptasi"},
  State_2415_WeaponDesc = {
    Text = "Jika menerima kerusakan pada ronde sebelumnya, dapatkan kekebalan selama 1 ronde di awal ronde."
  },
  State_2416_Desc = {
    Text = "Monster yang dipanggil memiliki hidup dan kerusakan dua kali lipat."
  },
  State_2416_Name = {
    Text = "\"Dunia Patung Lilin\""
  },
  State_2416_WeaponDesc = {
    Text = "Monster yang dipanggil memiliki hidup dan kerusakan dua kali lipat."
  },
  State_24174_Desc = {
    Text = "Pembangun ini tidak akan lagi memiliki Hidup di bawah 1 akibat Kerusakan."
  },
  State_24174_Name = {
    Text = "Kebal terhadap kematian"
  },
  State_2418_Desc = {
    Text = "[Muliakan] memberikan 30 Aliemus kepada diri sendiri."
  },
  State_2418_Name = {
    Text = "Jilbab Dewa Alienasi"
  },
  State_2418_WeaponDesc = {
    Text = "[Muliakan] memberikan 30 Aliemus kepada diri sendiri."
  },
  State_2419_Name = {
    Text = "Relik Cermin Putih"
  },
  State_2420_Desc = {
    Text = "Dalam putaran ini, setiap 1 kartu [Pertahanan] yang dimainkan mengurangi konsumsi aritmetika sebesar -1."
  },
  State_2420_Name = {
    Text = "Mata Hati yang Tajam"
  },
  State_2420_WeaponDesc = {
    Text = "Dalam putaran ini, setiap 1 kartu [Pertahanan] yang dimainkan mengurangi konsumsi aritmetika sebesar -1."
  },
  State_24210_Desc = {
    Text = "Pada giliran ini, target serangan Tentakel Raja Dewa berubah menjadi semua musuh."
  },
  State_24210_Name = {
    Text = "Ranah Dewa: Anggota Tangan - Geng"
  },
  State_24211_Desc = {
    Text = "·Setelah ronde berakhir, berikan [DescArg4] kali kerusakan sebesar [DescArg2] poin kepada musuh di barisan depan. Jika musuh terbunuh, kerusakan tersebut meningkat sebesar [DescArg3] poin, hingga maksimal 5 kali (saat ini [DescArg6] kali).\n·Setiap kali Pembangun menggunakan Aliemus Muliakan, serangan tambahan diluncurkan 1 kali dalam ronde ini.\n·Setelah Penjaga menggunakan Geng, ubah target serangan yang diluncurkan dalam ronde ini menjadi semua musuh. Jika dalam pertempuran bos, kerusakan yang diberikan oleh \"Ranah dewa Tangan\" juga akan meningkat sebesar [DescArg5] poin."
  },
  State_24211_Name = {
    Text = "Ranah Dewa: Anggota Tangan"
  },
  State_24213_Name = {
    Text = "Jika kartu ini berada di tangan, dapatkan 150 poin Energi-s saat giliran berakhir."
  },
  State_24214_Desc = {
    Text = "·Setelah ronde berakhir, menyebabkan [DescArg2] kerusakan kepada musuh di barisan depan."
  },
  State_24214_Name = {
    Text = "Ranah Dewa: Anggota Tangan"
  },
  State_24215_Desc = {
    Text = "·Setelah ronde berakhir, berikan [DescArg2] poin kerusakan kepada musuh di barisan depan. Jika musuh terbunuh, kerusakan tersebut meningkat sebesar [DescArg3] poin, dengan peningkatan maksimal hingga 5 kali (saat ini [DescArg4] kali)."
  },
  State_24215_Name = {
    Text = "Ranah Dewa: Anggota Tangan"
  },
  State_24217_Name = {
    Text = "Menghilangkan status <VulnerabilityIconKeywords:Rentan>, <WeaknessIconKeywords:Kelemahan>, dan <FragileIconKeywords:Rapuh> pada diri sendiri."
  },
  State_24220_Name = {
    Text = "Mendapatkan [DescArg1] poin Perisai"
  },
  State_24222_Desc = {
    Text = "·Setelah ronde berakhir, berikan [DescArg4] kali [DescArg2] poin kerusakan kepada musuh di barisan depan. Jika musuh terbunuh, kerusakan tersebut meningkat sebesar [DescArg3] poin, dengan peningkatan maksimal hingga 5 kali (saat ini [DescArg5] kali).\n·Setiap kali Awakener menggunakan Exalt, lakukan 1 Serangan tambahan di ronde ini.\n·Setiap kali Penjaga menggunakan Posse, ubah target serangan yang dilakukan di ronde ini menjadi semua musuh."
  },
  State_24222_Name = {
    Text = "Ranah Dewa: Anggota Tangan"
  },
  State_24223_Desc = {
    Text = "·Setelah ronde berakhir, berikan [DescArg2] poin kerusakan kepada musuh di barisan depan. Jika musuh terbunuh, kerusakan tersebut meningkat sebesar [DescArg3] poin, dengan peningkatan maksimal hingga 5 kali (saat ini [DescArg4] kali).\n·Setiap kali Penjaga menggunakan Geng, ubah target serangan yang dilakukan pada ronde ini menjadi semua musuh."
  },
  State_24223_Name = {
    Text = "Ranah Dewa: Anggota Tangan"
  },
  State_24224_Desc = {
    Text = "·Setelah ronde berakhir, berikan [DescArg4] kali [DescArg2] poin kerusakan kepada musuh di barisan depan. Jika musuh terbunuh, kerusakan tersebut meningkat sebesar [DescArg3] poin, dengan peningkatan maksimal hingga 5 kali (saat ini [DescArg5] kali).\n·Setiap kali Awakener menggunakan Exalt, lakukan 1 Serangan tambahan di ronde ini."
  },
  State_24224_Name = {
    Text = "Ranah Dewa: Anggota Tangan"
  },
  State_24226_Desc = {
    Text = "·Setelah ronde berakhir, berikan [DescArg4] kali kerusakan sebesar [DescArg2] poin kepada musuh di barisan depan. Jika musuh terbunuh, kerusakan tersebut meningkat sebesar [DescArg3] poin, hingga maksimal 5 kali (saat ini [DescArg6] kali).\n·Setiap kali Pembangun menggunakan Aliemus Muliakan, serangan tambahan diluncurkan 1 kali dalam ronde ini.\n·Dalam pertempuran bos, setiap kali Penjaga menggunakan Geng, kerusakan \"Ranah dewa\" meningkat sebesar [DescArg5] poin."
  },
  State_24226_Name = {
    Text = "Ranah Dewa: Anggota Tangan"
  },
  State_24227_Desc = {
    Text = "·Setelah ronde berakhir, musuh di barisan depan akan menerima [DescArg2] kerusakan. Jika musuh terbunuh, kerusakan ini meningkat sebesar [DescArg3], hingga maksimal 5 kali (saat ini [DescArg5]).\n·Setelah Penjaga menggunakan Kunci Perintah, serangan yang diluncurkan pada ronde ini akan menargetkan semua musuh. Jika dalam pertempuran bos, kerusakan yang diberikan oleh \"Ranah dewa\" juga akan meningkat sebesar [DescArg4]."
  },
  State_24227_Name = {
    Text = "Ranah Dewa: Anggota Tangan"
  },
  State_2422_Desc = {
    Text = "Setelah digunakan, mendapatkan [StateArg1] poin Perisai."
  },
  State_2422_Name = {
    Text = "<Rune_6:Besi Pertahanan>"
  },
  State_24245_Desc = {
    Text = "Pada akhir ronde, pulihkan semua keturunan \"Hidra\". Setiap kali ada keturunan yang mati, turunkan 1 lapisan. Jika lapisan menjadi 0, \"Hidra\" akan berubah bentuk untuk pertempuran terakhir."
  },
  State_24245_Name = {
    Text = "Penguasa Ribuan Ular"
  },
  State_24247_Desc = {
    Text = "Kerusakan yang diterima berkurang sebesar 90%. Jika pada awal giliran tidak ada lapisan \"Pengendali Ular Sejuta\", hilangkan status ini."
  },
  State_24247_Name = {
    Text = "Hambatan Berbentuk Ular"
  },
  State_2425_Desc = {
    Text = "Setelah digunakan akan lelah. Jika merupakan kartu perintah, kerusakan dan perlindungannya akan meningkat 2 kali lipat."
  },
  State_2425_Name = {
    Text = "<CardKeyWord:Melarutkan>"
  },
  State_2426_Desc = {
    Text = "Kartu pertama yang kamu mainkan setiap ronde memiliki 1 efek tambahan, tetapi setiap ronde hanya dapat memainkan maksimal 4 kartu."
  },
  State_2427_Name = {
    Text = "Negara@Kunci Perak: Penghitungan Jantung Darah"
  },
  State_2428_Desc = {
    Text = "Jumlah <ParcloseIconKeywords:Penghalang> dari Bunga Kegelapan bertambah sebanyak [Layer] lapisan."
  },
  State_2428_Name = {
    Text = "Penghalang Kebencian"
  },
  State_2428_WeaponDesc = {
    Text = "Jumlah Penghalang Bunga Jahat bertambah [Layer] lapis."
  },
  State_24292_Name = {
    Text = "Pindah baris belakang ke depan"
  },
  State_24293_Name = {
    Text = "Baris depan mundur"
  },
  State_2429_Desc = {
    Text = "Semua kerusakan yang ditimbulkan berkurang sebesar [Layer]%."
  },
  State_2429_Name = {
    Text = "Penurunan Kerusakan Sementara"
  },
  State_2429_WeaponDesc = {
    Text = "Semua kerusakan yang ditimbulkan berkurang sebesar [Layer]%."
  },
  State_2430_Desc = {
    Text = "Pada saat pertempuran dimulai, semua sekutu mendapatkan 3 lapisan [Lapisan Zirah Lilin]. Pada akhir ronde, tim kami akan menerima [Arg1] lapisan berdarah."
  },
  State_2430_Name = {
    Text = "\"Tuan Lilin\""
  },
  State_2430_WeaponDesc = {
    Text = "Pada saat pertempuran dimulai, semua sekutu mendapatkan 3 lapisan [Lapisan Zirah Lilin]. Pada akhir ronde, tim kami akan menerima [Arg1] lapisan berdarah."
  },
  State_2431_Desc = {
    Text = "Satu-satunya Tim: Perisai dan pemulihan hidup yang diberikan oleh pemakai meningkat, jumlah peningkatannya adalah <WeaponEffect_Num:[StateArg1]%> dari konstitusi pemakai. Serangan balik yang diberikan oleh pemakai meningkat sebesar <WeaponEffect_Num:[StateArg3]%>, dan ketika melakukan \"Pertahanan\", akan memperoleh <RetaliateIconKeywords:Counter> sebesar <WeaponEffect_Num:[StateArg4]%> dari kekuatan pertahanan pemakai. Setelah pertempuran dimulai, mendapatkan <PowerIconKeywords:Kekuatan> sebesar <WeaponEffect_Num:[StateArg2]%> dari konstitusi pemakai. Jika alam saat ini adalah \"Aequor\", secara tambahan mendapatkan kerusakan tentakel dalam jumlah yang sama."
  },
  State_2431_WeaponDesc = {
    Text = "Pengguna peralatan meningkatkan perisai dan pemulihan hidup sebesar <WeaponEffect_Num:[DescArg1]> poin, serangan balik yang diberikan oleh pengguna peralatan meningkat sebesar <WeaponEffect_Num:[StateArg3]%>, saat melakukan \"Pertahanan\", juga akan memperoleh <WeaponEffect_Num:[Counterattack:DescArg3]> lapisan <RetaliateIconKeywords:Counter>. Setelah pertempuran dimulai, peroleh <WeaponEffect_Num:[Power:DescArg2]> poin <PowerIconKeywords:Kekuatan>. Jika alam saat ini adalah \"Aequor\", tambahan kerusakan tentakel dalam jumlah yang sama juga akan diperoleh."
  },
  State_2432_Desc = {
    Text = "Active DMG dan Kerusakan tentakel yang diterima meningkat 50%, saat giliran berakhir hapus 1 stack."
  },
  State_2432_Name = {
    Text = "<VulnerabilityIconKeywords: Rentan>"
  },
  State_2432_WeaponDesc = {
    Text = "Semua kerusakan yang diterima meningkat sebesar 50%."
  },
  State_2433_Desc = {
    Text = "Pada akhir setiap ronde, dapatkan [Layer] poin Kekuatan."
  },
  State_2433_Name = {Text = "marah"},
  State_2434_Name = {
    Text = "Aksesori 36 Kamar"
  },
  State_2434_WeaponDesc = {
    Text = "Saat mendapatkan Kartu pemilik peralatan, Aritmetikanya akan berubah secara acak antara 0-3."
  },
  State_2435_Desc = {Text = "Acara19_2"},
  State_2435_Name = {Text = "Acara19_2"},
  State_2435_WeaponDesc = {Text = "Acara19_2"},
  State_2436_Desc = {
    Text = "Kekuatan dan Perisai yang diperoleh berkurang sebesar 50%, berlangsung selama [Layer] putaran."
  },
  State_2436_Name = {
    Text = "Kutukan Sementara"
  },
  State_2436_WeaponDesc = {
    Text = "Sebelum giliran berakhir, kebal terhadap pemberian Negara positif pada diri sendiri."
  },
  State_2438_Desc = {
    Text = "Negara@Relik Silver Differential Counter"
  },
  State_2438_Name = {
    Text = "Negara@Relik Silver Differential Counter"
  },
  State_2438_WeaponDesc = {
    Text = "Negara@Relik Silver Differential Counter"
  },
  State_2440_Name = {
    Text = "Tarik 1 kartu"
  },
  State_2441_Name = {
    Text = "Mendapatkan 1 poin Aritmetika"
  },
  State_2442_Name = {
    Text = "Terapkan 1 lapis <VulnerabilityIconKeywords:Rentan> pada semua musuh"
  },
  State_2443_Name = {
    Text = "Terapkan 1 lapisan <WeaknessIconKeywords:Kelemahan> pada semua musuh"
  },
  State_2444_Name = {
    Text = "Mendapatkan <Energy:[DescArg1]> poin Aliemus"
  },
  State_2445_Name = {
    Text = "Pembangun lainnya memperoleh <Energy:[DescArg1]> poin Aliemus"
  },
  State_2446_Name = {
    Text = "Tambahkan 1 kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam tumpukan kartu Menggambar"
  },
  State_2447_Desc = {
    Text = "Satu-satunya di tim: Tingkat kritis dan kerusakan kritis kartu perintah pemakai, perisai yang dihasilkan oleh kartu perintah, pemulihan hidup, aliemus, dan kekuatan meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Jika alam saat ini adalah \"Ultra\", setelah melepaskan \"Pelenyapan\", mendapatkan <WeaponEffect_Num:[StateArg2]> energi-s. Setelah memasuki putaran Ultra, geng berikutnya pada putaran ini dilepaskan 2 kali."
  },
  State_2447_WeaponDesc = {
    Text = "Pengguna kartu perintah meningkatkan tingkat kritis dan kerusakan kritis, perisai yang dihasilkan oleh kartu perintah, pemulihan hidup, aliemus, dan kekuatan sebesar <WeaponEffect_Num:[StateArg1]%>. Jika alam saat ini adalah \"Ultra\", setelah melepaskan \"Penghancuran\", mendapatkan <WeaponEffect_Num:[StateArg2]> energi-s. Setelah memasuki putaran Ultra, geng berikutnya pada putaran ini dilepaskan 2 kali."
  },
  State_2448_Desc = {
    Text = "Kartu tidak akan masuk ke tumpukan kartu buang selama fase pembuangan, melainkan tetap berada di tangan."
  },
  State_2448_Name = {
    Text = "<CardKeyWord:Simpan>"
  },
  State_2449_Desc = {
    Text = "Setelah menerima kerusakan aktual, peroleh [Layer] perisai."
  },
  State_2449_Name = {Text = "buffer"},
  State_2449_WeaponDesc = {
    Text = "Setelah menerima kerusakan aktual, peroleh [Layer] perisai."
  },
  State_2450_Desc = {
    Text = "\"Serangan\"pasti akan menghasilkan kritis. Kerusakan kritis meningkat sebesar 50%."
  },
  State_2451_Desc = {
    Text = "Pada akhir ronde, sekutu lainnya mendapatkan [Layer] Kekuatan."
  },
  State_2451_Name = {
    Text = "\"Api Pencerahan\""
  },
  State_2452_Desc = {
    Text = "Setelah digunakan, mendapatkan [StateArg1] poin Kekuatan."
  },
  State_2452_Name = {
    Text = "<Rune_14_High:Kekuatan Tinggi>"
  },
  State_2453_Name = {
    Text = "Aksesori Ritual Fotosintesis"
  },
  State_2453_WeaponDesc = {
    Text = "Setelah pertempuran dimulai, semua kartu yang dimiliki oleh pemain tetap dipertahankan."
  },
  State_2454_Desc = {
    Text = "Setelah dimainkan, kartu tidak akan masuk ke Tumpukan kartu buang, melainkan dihapus dari dek."
  },
  State_2454_Name = {
    Text = "<DepleteIconKeywords:Lelah>"
  },
  State_2454_WeaponDesc = {
    Text = "Setelah digunakan, kartu tidak akan masuk ke tumpukan kartu buang dan tidak dapat digunakan kembali selama pertempuran ini."
  },
  State_24556_Name = {
    Text = "Negara@Besar Magician Houdini@Penonton Beruntung menambahkan sorakan"
  },
  State_2455_Name = {
    Text = "Negara@Penari api biru Mencerahkan7"
  },
  State_24560_Desc = {
    Text = "Setiap kali menggunakan Geng, Crit. Rate sementara dan Crit. DMG sementara Ramona-loop meningkat sebesar +25%."
  },
  State_24560_Name = {
    Text = "Bepergian di klein"
  },
  State_24562_Desc = {
    Text = "Setelah ronde berakhir, dapatkan 1 lapisan Negentropy."
  },
  State_24562_Name = {
    Text = "Berjalan di penrose"
  },
  State_24564_Desc = {
    Text = "Setiap kali memiliki 3 lapis Negentropy, menggunakan Kartu perintah Ramona-loop akan menghabiskan semua Negentropy dan memicu efek tambahan loop. Negentropy dapat ditumpuk hingga maksimal 3 lapis."
  },
  State_24564_Name = {Text = "Negentropy"},
  State_2456_Name = {
    Text = "Negara@Penari Api Biru Mencerahkan15"
  },
  State_2457_Name = {
    Text = "Tarik 1 kartu"
  },
  State_24584_Name = {
    Text = "Negara@N dari avatar@bisikan1 beralih status"
  },
  State_2458_Name = {
    Text = "Negara@Aksesoris Efek Penghitungan Pelukan Merah"
  },
  State_24593_Desc = {
    Text = "Ketika jumlah lapisan adalah 0, ubah niat menjadi \"Pemanggilan Hitam\", pada akhir ronde akan berkurang 1 lapisan, maksimal memiliki 4 lapisan."
  },
  State_24593_Name = {Text = "Chaos"},
  State_24595_Desc = {
    Text = "Setelah kematian, segera kurangi 1 lapisan \"Kekacauan\" pada \"N\"."
  },
  State_24595_Name = {Text = "Dispersi"},
  State_24596_Desc = {
    Text = "Saat memanggil \"N\", setiap ada 1 lapisan \"Kegelapan\", akan memanggil 1 duplikat."
  },
  State_24596_Name = {Text = "kegelapan"},
  State_2460_Desc = {
    Text = "Satu-satunya di tim: Kerusakan dasar yang diberikan oleh pemakai, <IntoxicationIconKeywords:Racun> dan <RetaliateIconKeywords:Counter> meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Crit. Rate dan Crit. DMG meningkat sebesar <WeaponEffect_Num:[StateArg2]%>."
  },
  State_2460_WeaponDesc = {
    Text = "Pengguna meningkatkan kerusakan dasar, <IntoxicationIconKeywords:Racun> dan <RetaliateIconKeywords:Counter> sebesar <WeaponEffect_Num:[StateArg1]%>. Crit. Rate dan Crit. DMG meningkat sebesar <WeaponEffect_Num:[StateArg2]%>."
  },
  State_2461_Desc = {
    Text = "Ketika menerima kerusakan fatal dalam pertempuran ini, bangkit kembali, pulihkan [Layer] poin hidup dan berikan [StateArg1] poin aliemus kepada semua pembangun. Efek ini tidak dapat dihilangkan."
  },
  State_2461_Name = {
    Text = "Burung Abadi dari Surga"
  },
  State_2463_Desc = {
    Text = "Pada saat pertempuran dimulai, Fusi Embrio +20%. Untuk setiap Pembangun dengan Aliemus penuh, Fusi Embrio tambahan +20%."
  },
  State_24640_Desc = {
    Text = "Setelah pertempuran dimulai, Embryo Fusion +[Blood:DescArg1], setiap kali Ketahanan terpicu, Embryo Fusion +[Blood:DescArg1]. Sorel setiap kali memberikan Kerusakan, meningkatkan Kerusakan yang diberikan pada putaran ini sebesar 4% dari ATK."
  },
  State_24640_Name = {
    Text = "Permata mahkota"
  },
  State_2464_Desc = {
    Text = "Kartu Aritmetika Ditingkatkan"
  },
  State_2464_Name = {
    Text = "Penambahan Aritmetika Kartu Permanen"
  },
  State_2464_WeaponDesc = {
    Text = "Kartu Aritmetika Ditingkatkan"
  },
  State_24654_Desc = {
    Text = "Setelah Dafdale membunuh musuh dengan cara apa pun, Crit. Rate tim akan meningkat secara permanen sebesar 5% dalam level ini, hingga dapat ditumpuk maksimal 5 kali. (Saat ini ditumpuk [DescArg1] kali)"
  },
  State_24654_Name = {
    Text = "Kabut keserakahan"
  },
  State_2466_Desc = {
    Text = "Hingga giliran berikutnya dimulai, setiap menerima 1 kali serangan, tentakel akan melakukan Counter terhadap penyerang 1 kali, Kerusakan sementara tentakel +[Layer]."
  },
  State_2466_Name = {
    Text = "Garis Keturunan"
  },
  State_24678_Name = {
    Text = "Negara@N dari avatar@Bisikan2 beralih status"
  },
  State_24679_Name = {
    Text = "Negara@N dari Avatar3@Bisikan6 pergantian status"
  },
  State_2467_Desc = {
    Text = "Negara@Prolog: Analisis Penyerangan"
  },
  State_2467_Name = {
    Text = "Negara@Prolog: Analisis Penyerangan"
  },
  State_2467_WeaponDesc = {
    Text = "Negara@Prolog: Analisis Penyerangan"
  },
  State_24680_Name = {
    Text = "Negara@N dari klon 2@bisikan 1 beralih status"
  },
  State_24681_Name = {
    Text = "Negara@N dari avatar@bisikan6 beralih status"
  },
  State_24682_Name = {
    Text = "Negara@N dari avatar3@bisikan3 beralih status"
  },
  State_24683_Name = {
    Text = "Negara@N dari Klon2@Bisikan2 Perubahan Negara"
  },
  State_24684_Name = {
    Text = "Negara@N dari avatar@bisikan4 beralih status"
  },
  State_24685_Name = {
    Text = "Negara@N dari avatar@bisikan5 beralih status"
  },
  State_24686_Name = {
    Text = "Negara@N dari Avatar3@Bisikan5 Perubahan Negara"
  },
  State_24687_Name = {
    Text = "Negara@N dari avatar3@bisikan2 beralih status"
  },
  State_24688_Name = {
    Text = "Negara@N dari Klon2@Bisikan6 Perubahan Status"
  },
  State_24689_Name = {
    Text = "Negara@N dari Avatar 3@Bisikan 4 beralih status"
  },
  State_24690_Name = {
    Text = "Negara@N dari Avatar3@Bisikan1 Perubahan Status"
  },
  State_24691_Name = {
    Text = "Negara@N dari Kloning2@Bisikan4 Pergantian Negara"
  },
  State_24692_Name = {
    Text = "Negara@N dari duplikat 2@ bergumam 3 beralih status"
  },
  State_24693_Name = {
    Text = "Negara@N dari avatar@bisikan3 beralih status"
  },
  State_24694_Name = {
    Text = "Negara@N dari Kloning2@Bisikan5 Perubahan Negara"
  },
  State_2470_Desc = {
    Text = "Mengambilnya akan secara permanen mengurangi [Arg1] poin Waspada, dan kerusakan aktif yang diberikan mendapatkan tambahan 1 kali bonus Kekuatan."
  },
  State_24719_Desc = {
    Text = "\"@2\"telah muncul dengan postur pembebasan, hidupnya menjadi 3 kali lipat dari semula."
  },
  State_24719_Name = {
    Text = "Pemulihan Nasib"
  },
  State_24719_WeaponDesc = {
    Text = "Pada ronde berikutnya, dapatkan perisai sejumlah kehilangan hidup dari ronde sebelumnya."
  },
  State_2471_Desc = {
    Text = "Pada awal ronde, tim kami berkurang 1 Waspada."
  },
  State_2471_Name = {Text = "Korosi"},
  State_2471_WeaponDesc = {
    Text = "Pada awal ronde, tim kami berkurang 1 Waspada."
  },
  State_24720_Desc = {
    Text = "Kekuatan dari keberadaan yang tidak diketahui masih tersembunyi di bawah kolam hitam, sebelum dikalahkan akan sepenuhnya bangkit, mengembalikan kehidupan dan memulai pertempuran dengan gaya pembebasan."
  },
  State_24720_Name = {
    Text = "bersembunyi"
  },
  State_2472_Desc = {
    Text = "Menyebabkan kerusakan pada perisai dan hidup secara bersamaan, dan tidak dapat dikebalikan."
  },
  State_2472_Name = {
    Text = "<PunctureDamagewords:Kerusakan Tembus>"
  },
  State_2472_WeaponDesc = {
    Text = "Kerusakan tembus mengabaikan perisai, pengurangan kerusakan, dan blokade target, langsung menyebabkan kerusakan."
  },
  State_24730_Desc = {
    Text = "Menambahkan ruang Ultra sementara dengan batas maksimal 10. Saat memasuki ronde Ultra berikutnya, kartu di dalam ruang Ultra sementara akan dipindahkan ke tangan, lalu ruang Ultra sementara akan dihapus."
  },
  State_24730_Name = {
    Text = "<CardKeyWord:Ruang Ultra Sementara>"
  },
  State_24737_Desc = {
    Text = "Pada awal giliran, menyebabkan berdarah pada lawan, setiap 1 lapisan takdir akan menyebabkan [StateArg1] titik berdarah."
  },
  State_24737_Name = {Text = "nasib"},
  State_24738_Desc = {
    Text = "Setiap 1 lapisan Takdir yang aktif akan menyebabkan [StateArg1] titik Berdarah, setiap kali memainkan 1 Kartu akan mengurangi 1 lapisan Takdir."
  },
  State_24738_Name = {Text = "nasib"},
  State_24739_Name = {Text = "nasib"},
  State_2473_Desc = {
    Text = "[Pertahanan] Kehilangan 1 Tentakel, pulihkan [StateArg1] Hidup. [Serangan] Kehilangan [StateArg2] Hidup, hasilkan 1 Tentakel."
  },
  State_2473_Name = {
    Text = "Relik Pencipta Kehidupan Abadi Caro"
  },
  State_2473_WeaponDesc = {
    Text = "[Pertahanan] Kehilangan 1 Tentakel, pulihkan [StateArg1] Hidup. [Serangan] Kehilangan [StateArg2] Hidup, hasilkan 1 Tentakel."
  },
  State_2474_Desc = {
    Text = "Meningkatkan [Layer]% Daya Serang."
  },
  State_2474_Name = {
    Text = "Persentase Daya Serang Umum Meningkat"
  },
  State_2474_WeaponDesc = {
    Text = "Meningkatkan [Layer]% Daya Serang."
  },
  State_2475_Desc = {
    Text = "Tim Unik: Kerusakan aktif yang diberikan oleh pemakai meningkat sebesar <WeaponEffect_Num:[StateArg3]%> dari ATK pemakai. Setiap kali memainkan atau membuang 1 kartu perintah pemakai, menyebabkan <WeaponEffect_Num:[StateArg1]%> <IntoxicationIconKeywords:Racun> yang setara dengan ATK pemakai pada musuh acak. Setelah akhir Ultra Round, ada kemungkinan <WeaponEffect_Num:[StateArg2]%> untuk memicu 100% racun pada semua musuh."
  },
  State_2475_WeaponDesc = {
    Text = "Peningkatan kerusakan aktif yang diberikan oleh pemakai sebesar <WeaponEffect_Num:[DescArg2]> poin. Setiap kali memainkan atau membuang 1 kartu perintah pemakai, berikan <WeaponEffect_Num:[DescArg1]> lapisan <IntoxicationIconKeywords:Racun> pada musuh secara acak. Setelah putaran ultra berakhir, ada kemungkinan <WeaponEffect_Num:[StateArg2]%> untuk memicu efek racun pada semua musuh [DescArg3]%."
  },
  State_2476_Name = {
    Text = "Negara@Genesis Mencerahkan 1"
  },
  State_2478_Desc = {
    Text = "Perisai yang diberikan oleh Nautilus menjadi dua kali lipat."
  },
  State_2478_Name = {
    Text = "Ahli pemeliharaan"
  },
  State_2478_WeaponDesc = {
    Text = "Perisai yang diberikan oleh Nautilus menjadi dua kali lipat."
  },
  State_2479_Desc = {
    Text = "Api Hijau setiap kali memberikan kerusakan, jumlah lapisan +1"
  },
  State_2479_Name = {
    Text = "Penghitungan Bayangan Giok"
  },
  State_2479_WeaponDesc = {
    Text = "Api Hijau setiap kali memberikan kerusakan, jumlah lapisan +1"
  },
  State_2480_Desc = {
    Text = "Mendapatkan [StateArg1] Counter saat memulihkan Hidup. Setiap kali Abyss Dweller memainkan 1 kartu, pulihkan 1 Hidup."
  },
  State_2480_Name = {
    Text = "Tubuh yang Bermetamorfosis"
  },
  State_2481_Desc = {
    Text = "Negara@Prolog Reset Deck0_2_3_1"
  },
  State_2481_Name = {
    Text = "Negara@Prolog Reset Deck0_2_3_1"
  },
  State_2481_WeaponDesc = {
    Text = "Negara@Prolog Reset Deck0_2_3_1"
  },
  State_2482_Desc = {
    Text = "Memanggil 1 segitiga pelarutan dengan jumlah hidup yang sama saat hidup di bawah 50%."
  },
  State_2482_Name = {Text = "Memanggil"},
  State_2482_WeaponDesc = {
    Text = "Memanggil 1 segitiga pelarutan dengan jumlah hidup yang sama saat hidup di bawah 50%."
  },
  State_2486_Desc = {
    Text = "Pada awal giliran, setiap ada 1 musuh, dapatkan 1 poin aritmetika. Ketika membuat kerusakan langsung dan membunuh musuh, berikan efek berdarah yang setara dengan kerusakan berlebih itu kepada musuh lainnya."
  },
  State_24879_Desc = {
    Text = "Seribu tahun berlalu, sepuluh ribu tahun berlalu, mereka menanti dalam kegelapan abadi di reruntuhan. Segera setelah kematian, kurangi 1 lapisan \"Kekacauan\" pada \"N\", dan berikan [DescArg1] poin Perisai serta [DescArg2] poin Kekuatan kepada \"N\"."
  },
  State_24879_Name = {
    Text = "Klon Ilusif"
  },
  State_2488_Desc = {
    Text = "Setiap kali kamu memainkan kartu \"Buff\"/\"Gejala\"/\"Negara\", Pembangun dengan Aliemus terendah mendapatkan 10 Aliemus."
  },
  State_2489_Desc = {
    Text = "Meningkatkan Crit. Rate sebesar 10%. Setelah serangan kritis pertama setiap ronde, Crit. Rate akan meningkat tambahan 20%, dan setelah serangan kritis ketiga dalam satu ronde, Crit. DMG akan meningkat tambahan 50%."
  },
  State_2490_Desc = {
    Text = "Setiap lapisan menambah jumlah serangan sebanyak 1. Saat menerima kerusakan, kehilangan satu lapisan, dan pada akhir giliran, kehilangan semua lapisan."
  },
  State_2490_Name = {Text = "Doa"},
  State_2491_Desc = {
    Text = "Mendapatkan perisai sebesar jumlah pemulihan hidup."
  },
  State_2491_Name = {
    Text = "Penguatan Sementara"
  },
  State_2492_Desc = {
    Text = "Kebal terhadap kerusakan aktif pertama setiap ronde."
  },
  State_2492_Name = {Text = "Teguh"},
  State_2492_WeaponDesc = {
    Text = "Kebal terhadap kerusakan aktif pertama setiap ronde."
  },
  State_2493_Desc = {
    Text = "Kerusakan aktif yang dihasilkan berkurang sebesar [Layer] poin."
  },
  State_2493_Name = {Text = "STR▼"},
  State_2494_Desc = {
    Text = "Negara@Pendahuluan_Aliemus0_1_4_1"
  },
  State_2494_Name = {
    Text = "Negara@Pendahuluan_Aliemus0_1_4_1"
  },
  State_2494_WeaponDesc = {
    Text = "Negara@Pendahuluan_Aliemus0_1_4_1"
  },
  State_2495_Desc = {
    Text = "Negara@Prolog_Aliemus0_1_4_2"
  },
  State_2495_Name = {
    Text = "Negara@Prolog_Aliemus0_1_4_2"
  },
  State_2495_WeaponDesc = {
    Text = "Negara@Prolog_Aliemus0_1_4_2"
  },
  State_24968_Desc = {
    Text = "Setelah pertempuran dimulai, Embryo Fusion +[Blood:DescArg2]. Setiap kali Ketahanan terpicu, Embryo Fusion +[Blood:DescArg2]. Sorel setiap kali memberikan Kerusakan, meningkatkan Kerusakan yang diberikan sendiri dalam putaran ini sebesar [DescArg1] poin."
  },
  State_24968_Name = {
    Text = "Permata mahkota"
  },
  State_2496_Desc = {
    Text = "Pada awal giliran, pulihkan [Arg1] Hidup. Jika Hidup di bawah 50%, pemulihan Hidup menjadi [Arg2]."
  },
  State_2496_Name = {
    Text = "Darah Anugerah"
  },
  State_24976_Desc = {
    Text = "\"Pelayan Bulan Cembung\"sudah bangun, hati-hati dengan bahaya yang dibawa oleh masakan spesial!"
  },
  State_24976_Name = {
    Text = "Karen Bangun!"
  },
  State_24976_WeaponDesc = {
    Text = "Pada ronde berikutnya, dapatkan perisai sejumlah kehilangan hidup dari ronde sebelumnya."
  },
  State_24977_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_24977_Name = {Text = "Not Roused"},
  State_2497_Desc = {
    Text = "Lily akan meniru kartu perintah pertama yang dimainkan pemain di setiap ronde. Jika kartu Pukulan, jumlah serangan Lily bertambah +1. Jika kartu Pertahanan, Lily mendapatkan perisai sebesar 10% HP. Jika kartu perintah lainnya, Lily juga tidak tahu apa yang terjadi dan akan terlebih dahulu melepaskan satu Pustula di sini."
  },
  State_2497_Name = {
    Text = "Lily Bangun!"
  },
  State_2497_WeaponDesc = {
    Text = "Pada ronde berikutnya, dapatkan perisai sejumlah kehilangan hidup dari ronde sebelumnya."
  },
  State_2498_Name = {
    Text = "Aksesori Kutukan Kelinci"
  },
  State_2498_WeaponDesc = {
    Text = "Peningkatan 6% untuk perisai dan pemulihan hidup yang diberikan oleh pemakai. Jika penguasaan alam pemakai lebih dari 50, perisai dan pemulihan hidup akan mendapatkan peningkatan tambahan sebesar 6%."
  },
  State_2499_Name = {
    Text = "Kutukan Stagnasi"
  },
  State_2500_Desc = {
    Text = "Setiap kali memberikan kerusakan aktual, tambahkan Racun."
  },
  State_2500_Name = {Text = "Racun"},
  State_2501_Desc = {
    Text = "Satu-satunya Tim: Meningkatkan batas atas Hidup tim sebesar 10%. Sembuh dan Perisai yang diberikan oleh pemegang peralatan meningkat sebesar <WeaponEffect_Num:[StateArg3]%>. Setelah menggunakan \"Serangan\" dari pemegang peralatan, pulihkan <WeaponEffect_Num:[StateArg1]%> dari Hidup yang hilang. Setelah menggunakan \"Pertahanan\" dari pemegang peralatan, dapatkan Perisai sebesar <WeaponEffect_Num:[StateArg2]%> dari Hidup saat ini. Efek ini paling banyak dipicu sekali per ronde masing-masing."
  },
  State_2501_Name = {
    Text = "Kelahiran jiwa"
  },
  State_2501_WeaponDesc = {
    Text = "Batas maksimum HP tim meningkat sebesar 10%. Sembuh dan perisai yang diberikan oleh pemilik peralatan meningkat sebesar <WeaponEffect_Num:[StateArg3]%>. Setelah menggunakan \"Serangan\" dari pemilik peralatan, pulihkan [StateArg1]%(<WeaponEffect_Num:[Heal:DescArg1]>) dari HP yang hilang. Setelah menggunakan \"Pertahanan\" dari pemilik peralatan, dapatkan perisai sebesar [StateArg1]%(<WeaponEffect_Num:[Block:DescArg2]>) dari HP saat ini. Efek ini paling banyak dipicu masing-masing 1 kali per ronde."
  },
  State_2502_Desc = {
    Text = "Active DMG dan Kerusakan tentakel yang ditimbulkan berkurang 50 %."
  },
  State_2502_Name = {
    Text = "Kelemahan Pemadaman"
  },
  State_2502_WeaponDesc = {
    Text = "Semua kerusakan yang ditimbulkan berkurang sebesar 50%."
  },
  State_2503_Desc = {
    Text = "Satu-satunya Tim: Kerusakan dasar yang diberikan oleh kartu pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Di awal ronde, ada kemungkinan sebesar <WeaponEffect_Num:[StateArg2]%> untuk menghasilkan satu kartu acak milik pemakai ke tangan, dengan tambahan Lelah. Jika alam saat ini adalah \"Caro\", saat menggunakan \"Embrio\" pada pemakai, tingkat kritis dari kartu serangan berikutnya pemakai di ronde ini akan meningkat sebesar <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_2503_WeaponDesc = {
    Text = "Kerusakan dasar yang diberikan oleh kartu pemilik peralatan meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Di awal ronde, ada kemungkinan sebesar <WeaponEffect_Num:[StateArg2]%> untuk menghasilkan satu kartu acak milik pemilik peralatan ke tangan, dengan tambahan konsumsi. Jika alam saat ini adalah \"Caro\", saat menggunakan \"Embrio\" pada pemilik peralatan, tingkat kritis dari kartu serangan berikutnya pemilik peralatan di ronde ini akan meningkat sebesar <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_2504_Desc = {
    Text = "\"Serangan\"memperoleh 2 poin Aritmetika, membuang 1 kartu secara acak; \"Pertahanan\"menarik 2 kartu, kehilangan 1 poin Aritmetika."
  },
  State_25056_Desc = {
    Text = "Setiap kali kehabisan aritmetika, Karen mendapatkan [Layer] poin kekuatan sementara."
  },
  State_25056_Name = {
    Text = "Kenyang dan puas"
  },
  State_25057_Desc = {
    Text = "Setiap kali Lelah Aritmetika, Karen mendapatkan [StateArg1] poin Kekuatan sementara, dan 1 lapisan akan dihilangkan pada akhir ronde."
  },
  State_25057_Name = {
    Text = "Kenyang dan puas"
  },
  State_2505_Name = {
    Text = "Hiasan Pujian April"
  },
  State_2505_WeaponDesc = {
    Text = "Setelah pertempuran dimulai, jika pekerjaan pemilik peralatan adalah Ultra, Daya Serang meningkat sebesar 25%."
  },
  State_2507_Desc = {
    Text = "Meningkatkan Kesehatan Maksimum sebesar 100% saat diambil, kehilangan [Arg1] poin Hidup saat giliran dimulai."
  },
  State_2509_Name = {
    Text = "Negara@Penguasaan Alam Universal"
  },
  State_2511_Desc = {
    Text = "Negara@Pengajaran Kunci Prolog"
  },
  State_2511_Name = {
    Text = "Negara@Pengajaran Kunci Prolog"
  },
  State_2511_WeaponDesc = {
    Text = "Negara@Prolog Atur Ulang Deck0_1_2_2"
  },
  State_2512_Desc = {
    Text = "Ketika memainkan 1 Kartu dengan Lelah Aritmetika sebesar 3 atau lebih, tarik 1 Kartu dan dapatkan 1 poin Aritmetika."
  },
  State_2514_Desc = {
    Text = "Perisai yang dihasilkan dalam pertempuran ini berkurang sebesar [Layer] poin."
  },
  State_2514_Name = {
    Text = "Kewaspadaan berkurang"
  },
  State_2514_WeaponDesc = {
    Text = "Perisai yang dihasilkan dalam pertempuran ini berkurang sebesar [Layer] poin."
  },
  State_2515_Desc = {
    Text = "[Serangan] Memberikan [StateArg1] lapisan Racun kepada semua musuh."
  },
  State_2515_Name = {
    Text = "Relik Neurotoksin"
  },
  State_25163_Desc = {
    Text = "Dia seperti kabut, sulit untuk ditangkap."
  },
  State_25163_Name = {
    Text = "Bayangan Masa Lalu"
  },
  State_25165_Desc = {
    Text = "Efek tambahan unik dari Kartu Perintah Ramona-loop, diaktifkan saat memiliki 3 lapis Negentropy. Loop akan diwariskan ke pertempuran berikutnya."
  },
  State_25165_Name = {
    Text = "<TimeBeacon:Loop>"
  },
  State_25166_Desc = {
    Text = "Setiap kali memiliki 3 lapis Negentropy, menggunakan Kartu perintah Ramona-loop akan menghabiskan semua Negentropy dan memicu efek tambahan loop. Negentropy dapat ditumpuk hingga maksimal 3 lapis."
  },
  State_25166_Name = {
    Text = "<TimeBeacon2:Negentropy>"
  },
  State_2516_Desc = {
    Text = "Tidak dapat dikeluarkan."
  },
  State_2516_Name = {
    Text = "Tidak bisa dimainkan"
  },
  State_2516_WeaponDesc = {
    Text = "Kartu tidak dapat dimainkan."
  },
  State_25179_Name = {
    Text = "Pengadilan Aliemus"
  },
  State_2517_Desc = {
    Text = "Setelah tim kami melepaskan Muliakan, kekuatan sendiri hilang dalam giliran itu. Sekali per giliran."
  },
  State_2517_Name = {
    Text = "Takut akan Aliemus"
  },
  State_25181_Name = {
    Text = "Efek Penyimpanan Reinkarnasi"
  },
  State_2518_Desc = {
    Text = "Negara@Prolog Reset Deck0_1_1_3"
  },
  State_2518_Name = {
    Text = "Negara@Prolog Reset Deck0_1_1_3"
  },
  State_2518_WeaponDesc = {
    Text = "Negara@Prolog Reset Deck0_1_1_3"
  },
  State_25194_Desc = {
    Text = "Setelah kematian, \"N\"memperoleh [DescArg1] poin Perisai dan [DescArg2] poin Kekuatan permanen."
  },
  State_2519_Desc = {
    Text = "Negara@Prolog Reset Deck0_1_1_3"
  },
  State_2519_Name = {
    Text = "Negara@Prolog Reset Deck0_1_1_3"
  },
  State_2519_WeaponDesc = {
    Text = "Negara@Prolog Reset Deck0_1_1_3"
  },
  State_25204_Name = {
    Text = "Negara@N dari duplikat 2@Penentuan Niat"
  },
  State_25205_Name = {
    Text = "Negara@N dari 3 duplikat@Penilaian Niat"
  },
  State_25206_Name = {
    Text = "Negara@N@Menambahkan penilaian duplikat N"
  },
  State_25207_Name = {
    Text = "Negara@N dari avatar@Penilaian Niat"
  },
  State_2520_Desc = {
    Text = "Negara@Prolog Reset Deck0_1_1_2"
  },
  State_2520_Name = {
    Text = "Negara@Prolog Reset Deck0_1_1_2"
  },
  State_2520_WeaponDesc = {
    Text = "Negara@Prolog Reset Deck0_1_1_2"
  },
  State_2522_Desc = {
    Text = "Helot sudah bangun, intensitas serangan dan keinginan akan ditingkatkan."
  },
  State_2522_Name = {
    Text = "Helot Bangun"
  },
  State_2523_Desc = {
    Text = "Pada awal ronde ganjil, dapatkan [Arg1] Kekuatan dalam ronde ini. Pada awal ronde genap, dapatkan [Arg2] Waspada dalam ronde ini."
  },
  State_2524_Desc = {
    Text = "Pada awal pertempuran, dapatkan 1 Kekuatan."
  },
  State_2524_Name = {
    Text = "Nama baik terkenal jauh"
  },
  State_2525_Desc = {
    Text = "Jumlah serangan -1, mendapatkan [Layer] poin Kekuatan"
  },
  State_2525_Name = {Text = "Nafsu"},
  State_2527_Name = {
    Text = "Bonus Kekuatan Merah Delima"
  },
  State_2528_Desc = {
    Text = "Ketika memainkan 1 Kartu dengan Lelah Aritmetika sebenarnya sebesar 3, tarik 1 Kartu dan dapatkan 2 Aritmetika."
  },
  State_2529_Desc = {
    Text = "Crit. DMG meningkat sebesar [Layer]% dalam putaran ini."
  },
  State_2529_Name = {
    Text = "Crit. DMG Sementara"
  },
  State_2529_WeaponDesc = {
    Text = "Crit. DMG meningkat sebesar [Layer]% dalam putaran ini."
  },
  State_2531_Desc = {
    Text = "Setiap kali Api Hijau memberikan [Damage:StateArg2] kerusakan, dapatkan satu kartu yang menghabiskan [Lelah]."
  },
  State_2531_Name = {
    Text = "Gambar Zamrud"
  },
  State_2531_WeaponDesc = {
    Text = "Setiap kali Api Hijau memberikan [Damage:StateArg2] kerusakan, dapatkan satu kartu yang menghabiskan [Lelah]."
  },
  State_2532_Name = {
    Text = "Aksesoris Detak Merah Tua"
  },
  State_2534_Desc = {
    Text = "Negara@Prolog Reset Deck0_1_3_3"
  },
  State_2534_Name = {
    Text = "Negara@Prolog Reset Deck0_1_3_3"
  },
  State_2534_WeaponDesc = {
    Text = "Negara@Prolog Reset Deck0_1_3_3"
  },
  State_2535_Desc = {
    Text = "Negara@Prolog Reset Deck0_1_3_2"
  },
  State_2535_Name = {
    Text = "Negara@Prolog Reset Deck0_1_3_2"
  },
  State_2535_WeaponDesc = {
    Text = "Negara@Prolog Reset Deck0_1_3_2"
  },
  State_2536_Name = {
    Text = "Negara@Crit. DMG ditingkatkan sementara"
  },
  State_2537_Desc = {
    Text = "Ketika Ilusi Pedang memberikan perisai, mendapatkan [StateArg2] poin waspada sementara."
  },
  State_2537_Name = {
    Text = "Wawasan Luar Biasa di Medan Perang"
  },
  State_2537_WeaponDesc = {
    Text = "Ketika Ilusi Pedang memberikan perisai, mendapatkan [StateArg2] poin waspada sementara."
  },
  State_2538_Desc = {
    Text = "Setelah digunakan, mendapatkan [StateArg1] lapisan Counter, memberikan <FixedDamage:Kerusakan Murni> sebesar [StateArg2]% dari Counter kepada semua musuh."
  },
  State_2538_Name = {
    Text = "<Rune_9_High:Duri Tinggi>"
  },
  State_25391_Desc = {
    Text = "Di dalam tim, sudah ada satu Pembangun yang terpilih sebagai \"Penonton Beruntung\", semua Kartu dari Pembangun tersebut memiliki efek \"Tepuk Tangan\"."
  },
  State_25391_Name = {
    Text = "Penonton Beruntung"
  },
  State_25392_Desc = {
    Text = "Setelah digunakan, kehilangan 2% dari Kesehatan maksimum, Sang Grand Magician mendapatkan 1 tingkat \"Sangat Puas\" di ronde ini."
  },
  State_25392_Name = {
    Text = "<CardCheerKeywords:Minum>"
  },
  State_25401_Desc = {
    Text = "Kartu ini akan meningkatkan batas maksimum kartu di tangan sebesar +1 saat berada di tangan."
  },
  State_25401_Name = {
    Text = "Abai batas kartu tangan"
  },
  State_25403_Desc = {
    Text = "Kerusakan tentakel berkurang sebesar 50%, dan setiap kali memberikan kerusakan tentakel, mendapatkan [Layer] poin perisai."
  },
  State_25403_Name = {
    Text = "Lautan Tenang"
  },
  State_25405_Desc = {
    Text = "Kartu ini akan selalu berada di tangan dalam situasi apa pun."
  },
  State_25405_Name = {
    Text = "Menyimpan secara permanen"
  },
  State_25406_Desc = {
    Text = "Tidak dapat mengganti bentuk Tentakel lagi dalam ronde ini"
  },
  State_25406_Name = {
    Text = "Aequor Kegilaan·Terbatas"
  },
  State_25407_Desc = {
    Text = "Kerusakan tentakel meningkat sebesar 25%, jumlah tentakel berkurang 1 pada akhir giliran."
  },
  State_25407_Name = {
    Text = "Kegilaan Aequor"
  },
  State_25415_Desc = {
    Text = "Setelah menggunakan Geng, dapatkan [Layer] poin energi kunci."
  },
  State_25415_Name = {
    Text = "Kekacauan Kunci Sementara dengan Energi Penuh"
  },
  State_25417_Name = {Text = "Bom 3"},
  State_25418_Name = {Text = "Bom 2"},
  State_2542_Name = {
    Text = "Relik Tanpa Nama Menghitung Anggota Badan"
  },
  State_2543_Name = {
    Text = "Negara@Level2_14 Pertempuran 8 gelembung 1"
  },
  State_2544_Desc = {
    Text = "Negara@Pendahuluan Musuh Pasif"
  },
  State_2544_Name = {
    Text = "Negara@Pendahuluan Musuh Pasif"
  },
  State_2544_WeaponDesc = {
    Text = "Negara@Pendahuluan Musuh Pasif"
  },
  State_2545_Desc = {
    Text = "Pada saat pertempuran dimulai, Fusi Embrio +20%. Untuk setiap Pembangun dengan Aliemus penuh, Fusi Embrio tambahan +20%."
  },
  State_2547_Desc = {
    Text = "Pada awal ronde, tambahkan kartu \"Trisula\" dengan [Arg1] Kekuatan yang diperoleh selama ronde ini ke tangan. Setelah melepaskan Muliakan, tingkatkan semua Kekuatan \"Trisula\" di tangan sebesar [Arg2]."
  },
  State_2548_Desc = {
    Text = "Kebal terhadap satu kali kematian. Setelah diaktifkan, pulihkan 50 Hidup dan nonaktifkan Relik ini secara permanen."
  },
  State_2548_Name = {
    Text = "Relik Pengganti Boneka"
  },
  State_2548_WeaponDesc = {
    Text = "Kebal terhadap satu kali kematian. Setelah diaktifkan, pulihkan 50 Hidup dan nonaktifkan Relik ini secara permanen."
  },
  State_2549_Desc = {
    Text = "Mengurangi kerusakan aktif dan kerusakan tentakel yang dihasilkan."
  },
  State_2549_Name = {
    Text = "<ExhaustionIconKeywords: Kekuatan Berkurang>"
  },
  State_2549_WeaponDesc = {
    Text = "Setiap tingkat kelelahan mengurangi kerusakan yang ditimbulkan dan kerusakan tentakel sebesar 1 poin."
  },
  State_2550_Desc = {
    Text = "Mengakibatkan rapuh pada diri sendiri selama 1 putaran saat ditarik. Setelah digunakan, semua musuh menjadi rentan selama 1 putaran. Tidak dapat dijual."
  },
  State_2550_Name = {
    Text = "Negara Kutukan Runtuh"
  },
  State_2550_WeaponDesc = {
    Text = "Mengakibatkan rapuh pada diri sendiri selama 1 putaran saat ditarik. Setelah digunakan, semua musuh menjadi rentan selama 1 putaran. Tidak dapat dijual."
  },
  State_2552_Desc = {
    Text = "Kartu tidak akan masuk ke tumpukan kartu buang selama fase pembuangan, melainkan tetap berada di tangan."
  },
  State_2552_Name = {
    Text = "<RetainIconKeywords:Simpan>"
  },
  State_2552_WeaponDesc = {
    Text = "Kartu tidak akan masuk ke tumpukan kartu buang selama fase pembuangan, melainkan tetap berada di tangan."
  },
  State_2553_Desc = {
    Text = "Pada awal giliran, dapatkan satu poin Aritmetika."
  },
  State_2553_Name = {
    Text = "Relik Alkana Aritmetika"
  },
  State_2553_WeaponDesc = {
    Text = "Pada awal giliran, dapatkan satu poin Aritmetika."
  },
  State_2554_Name = {
    Text = "Koran Pagi Putney"
  },
  State_2556_Desc = {
    Text = "Setelah darah berkurang, perisai diperoleh yang setara dengan [Layer]% dari nilai pengurangan."
  },
  State_2556_Name = {
    Text = "Perisai Darah"
  },
  State_2556_WeaponDesc = {
    Text = "Setelah darah berkurang, dapatkan Perisai yang setara dengan [Layer]% dari nilai pengurangan."
  },
  State_2557_Desc = {
    Text = "Pada awal giliran berikutnya, dapatkan [Layer] poin Perisai."
  },
  State_2557_Name = {
    Text = "Perisai Penderitaan dan Kesenangan"
  },
  State_2558_Desc = {
    Text = "Ketika Hidup berada di bawah 50%([StateArg1]), akan terbelah menjadi 2 \"Tubuh yang terlulur\" tipe interferensi dengan jumlah Hidup yang sama."
  },
  State_2558_Name = {Text = "Terbelah"},
  State_2558_WeaponDesc = {
    Text = "Ketika Hidup berada di bawah 50%([StateArg1]), akan terbelah menjadi 2 \"Tubuh yang terlulur Tipe II\" dengan jumlah Hidup yang sama."
  },
  State_2559_Desc = {
    Text = "Setiap kali menerima serangan, kehilangan [Layer] poin Kekuatan sementara."
  },
  State_2559_Name = {
    Text = "Bayaran Impuls"
  },
  State_2560_Desc = {
    Text = "Setelah putaran berikutnya dimulai, dapatkan [Layer] Perisai."
  },
  State_2560_Name = {
    Text = "Penciptaan tertutup"
  },
  State_2560_WeaponDesc = {
    Text = "Setelah putaran berikutnya dimulai, dapatkan [Layer] Perisai."
  },
  State_2561_Desc = {
    Text = "Talenta Melankolis"
  },
  State_2561_Name = {
    Text = "Talenta Melankolis"
  },
  State_2561_WeaponDesc = {
    Text = "Talenta Melankolis"
  },
  State_2562_Name = {
    Text = "Negara@BabTiga_Resonansi1_Tanda"
  },
  State_2563_Desc = {
    Text = "Setiap kali kartu ke-10 dimainkan, tingkatkan kerusakan tentakel sebesar 2 dan buat semua tentakel melakukan serangan sekali."
  },
  State_2563_Name = {
    Text = "Relik Trisula"
  },
  State_2563_WeaponDesc = {
    Text = "Setiap kali kartu ke-10 dimainkan, tingkatkan kerusakan tentakel sebesar 2 dan buat semua tentakel melakukan serangan sekali."
  },
  State_2564_Desc = {
    Text = "Semua perisai yang diperoleh berkurang sebesar [DescArg1]%."
  },
  State_2564_Name = {
    Text = "<FragileColour:Rapuh>"
  },
  State_2564_WeaponDesc = {
    Text = "Semua Perisai yang diperoleh berkurang sebesar 33%."
  },
  State_2565_Name = {
    Text = "Aksesori Pelukan Merah Tua"
  },
  State_2565_WeaponDesc = {
    Text = "Pengguna peralatan mendapatkan 20 poin Energi-s saat memberikan Kerusakan. Jika memberikan Crit. DMG, akan mendapatkan 50 poin Energi-s. Maksimal terpicu 3 kali per ronde."
  },
  State_2566_Desc = {
    Text = "Setelah menerima 3 kali serangan dalam satu giliran, dapatkan 1 stacks <MadnessColour:Kegilaan> Sementara."
  },
  State_2566_Name = {
    Text = "\"Manis dan Pedih\""
  },
  State_2567_Desc = {
    Text = "Telah menerima Kerusakan sebanyak [Layer] kali, setelah mencapai 3 kali \"Setan Manis\" mendapatkan 1 stacks <MadnessColour:Kegilaan> dalam giliran ini."
  },
  State_2567_Name = {
    Text = "Jumlah \"Manis dan Pedih\""
  },
  State_2567_WeaponDesc = {
    Text = "Telah menerima [Layer] kerusakan, setelah mencapai 3 kali \"Iblis Manis\"memperoleh 1 tingkat kegilaan dalam ronde ini."
  },
  State_2569_Desc = {
    Text = "Efek bonus rekomendasi Alam meningkat menjadi 50%, dan penguasaan Alam Anda meningkat sebesar 100 di awal level."
  },
  State_2569_Name = {
    Text = "Negara@Kunci Perak: Pemisahan Kesesuaian"
  },
  State_2570_Desc = {
    Text = "Setelah bermain, tarik [StateArg1] kartu."
  },
  State_2570_Name = {
    Text = "<Rune_3:Tangan Ajaib>"
  },
  State_2571_Desc = {
    Text = "Untuk setiap [Kekacauan] Pembangun dalam tim, Kesehatan maksimum (belum selesai), Pertahanan, dan Serangan seluruh tim meningkat sebesar 50%."
  },
  State_2571_Name = {
    Text = "Bonus Kekacauan"
  },
  State_2571_WeaponDesc = {
    Text = "Untuk setiap [Kekacauan] Pembangun dalam tim, Kesehatan maksimum (belum selesai), Pertahanan, dan Serangan seluruh tim meningkat sebesar 50%."
  },
  State_2572_Desc = {
    Text = "Setelah digunakan, Fusi Embrio meningkat +[StateArg1]."
  },
  State_2572_Name = {
    Text = "<Rune_12: Haus Darah>"
  },
  State_2573_Desc = {
    Text = "Memiliki 5 lapisan [Sumbu Api]. Setelah memainkan kartu, jumlah lapisan berkurang 1. Ketika jumlah lapisan menjadi 0, terjadi ledakan diri, menyebabkan kerusakan sebesar Daya Serang * 2.5."
  },
  State_2573_Name = {Text = "Bom ledak"},
  State_2573_WeaponDesc = {
    Text = "Memiliki 5 lapisan [Sumbu Api]. Setelah memainkan kartu, jumlah lapisan berkurang 1. Ketika jumlah lapisan menjadi 0, terjadi ledakan diri, menyebabkan kerusakan sebesar Daya Serang * 2.5."
  },
  State_2574_Desc = {
    Text = "Crit. DMG +50%. Jika tidak melakukan serangan di suatu ronde, serangan pada ronde berikutnya pasti akan menjadi kritis."
  },
  State_2574_Name = {
    Text = "Negara@Kunci Perak Mimpi: Rondo"
  },
  State_2575_Desc = {
    Text = "Tim Unik: Saat pertempuran dimulai, setiap Relik yang dimiliki akan meningkatkan Crit. Rate kartu perintah pemakai sebesar [StateArg1]%. Setelah pemakai melepaskan Exalt, lempar dadu 4 sisi, pemakai mendapatkan Aliemus sebanyak <WeaponEffect_Num:[StateArg2]> kali jumlah dadu yang dilempar dan Crit. DMG Sementara, jika hasil dadu 4 atau lebih, Pembangun lainnya juga mendapatkan setengahnya."
  },
  State_2575_WeaponDesc = {
    Text = "Pada awal pertempuran, setiap memiliki satu Relik akan meningkatkan Crit. Rate kartu perintah pemakai sebesar [StateArg1]%. Setelah pemakai melepaskan Exalt, lempar dadu 4 sisi, pemakai mendapatkan Aliemus sebesar <WeaponEffect_Num:[StateArg2]> kali angka dadu yang dilempar dan Crit. DMG Sementara, jika dadu menunjukkan 4 atau lebih, Pembangun lainnya juga mendapatkan setengahnya."
  },
  State_2576_Desc = {
    Text = "Setiap kali sebuah Kartu memasuki ruang Ultra, kurangi Lelah Aritmetikanya sebesar -1."
  },
  State_2579_Desc = {
    Text = "Jumlah Active DMG yang ditimbulkan pada giliran ini meningkat [Layer]."
  },
  State_2579_Name = {
    Text = "<MadnessColour:Kegilaan Sementara>"
  },
  State_2580_Desc = {
    Text = "Setiap kali kartu Witch of the Hunt memasuki atau meninggalkan Ruang Ultra, dapatkan 1 Aritmetika."
  },
  State_2580_Name = {
    Text = "Proyeksi Dimensi"
  },
  State_2581_Desc = {
    Text = "Semua Pembangun meningkatkan isi ulang kunci perak sebesar 30. Setelah melepaskan Geng, cuci 3 kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam dek kartumu."
  },
  State_2581_Name = {
    Text = "Negara@Pendulum waktu wawasan"
  },
  State_2582_Desc = {
    Text = "Kerusakan, perisai, dan sembuh yang dilakukan oleh pengguna meningkat [StateArg1]%。（Sementara）"
  },
  State_2582_Name = {
    Text = "Negara@Prototipe Laser Cannon Aliemus"
  },
  State_2583_Desc = {
    Text = "Setiap kali menerima kerusakan aktif, tambahkan satu lapisan hitungan ke tim kami."
  },
  State_2583_Name = {
    Text = "Negara@Penghitungan Kerusakan Pemenggalan Pedang Balas Dendam"
  },
  State_2583_WeaponDesc = {
    Text = "Setiap kali menerima kerusakan aktif, tambahkan satu lapisan hitungan ke tim kami."
  },
  State_2584_Desc = {
    Text = "Setiap kali dek direset, dapatkan [Arg1] Kekuatan."
  },
  State_2586_Desc = {
    Text = "Semua perisai yang diperoleh berkurang sebesar 25%, dan 1 lapisan akan dihilangkan pada akhir giliran."
  },
  State_2586_Name = {
    Text = "<FragileIconKeywords: Rapuh>"
  },
  State_2586_WeaponDesc = {
    Text = "Semua Perisai yang diperoleh berkurang sebesar 25%."
  },
  State_2587_Desc = {
    Text = "Kerusakan luka menjadi dua kali lipat. Setiap kali memberikan kerusakan nyata, akan memperoleh [Layer] poin perisai."
  },
  State_2587_Name = {
    Text = "Gigi Pemakan Langit"
  },
  State_2587_WeaponDesc = {
    Text = "Kerusakan luka menjadi dua kali lipat. Setiap kali memberikan kerusakan nyata, akan memperoleh [Layer] poin perisai."
  },
  State_2588_Desc = {
    Text = "Setelah ronde berakhir, menerima [Layer] poin <FixedDamage:Kerusakan Murni> dan menghapus negara ini. Saat memulihkan HP, hapus stacks Bleed sebanyak dua kali jumlah HP yang dipulihkan."
  },
  State_2588_Name = {
    Text = "Permanen<BleedingColour: Berdarah>"
  },
  State_2588_WeaponDesc = {
    Text = "Setelah giliran berakhir, menerima [Layer] kerusakan dan negara ini akan dihapus, setiap sembuh dapat mengurangi setengah dari lapisan."
  },
  State_2589_Name = {
    Text = "Aksesori Kembar Hitam yang Terdistorsi"
  },
  State_2589_WeaponDesc = {
    Text = "Setelah ronde ganjil dimulai, tambahkan satu kartu \"Serangan\" pemakai dengan efek Ilusi dan Lelah ke tangan."
  },
  State_2590_Desc = {
    Text = "Mendapatkan 10 Segil Hitam saat bergerak"
  },
  State_2590_Name = {
    Text = "Relik Tas Tak Terbatas"
  },
  State_2590_WeaponDesc = {
    Text = "Mendapatkan 10 Segil Hitam saat bergerak"
  },
  State_2592_Desc = {
    Text = "Setiap kehilangan 1 poin hidup, hilangkan 1 lapisan. Saat jumlah lapisan menjadi 0, dapatkan perisai sebesar [DescArg1]."
  },
  State_2592_Name = {
    Text = "Hambatan Dimensi"
  },
  State_2593_Name = {
    Text = "Negara@Pujian Darah Kirmizi dan Pasir"
  },
  State_2594_Desc = {
    Text = "Mendapatkan perisai dari kerusakan aktual"
  },
  State_2594_Name = {
    Text = "Gigi Pemakan Langit"
  },
  State_2594_WeaponDesc = {
    Text = "Mendapatkan perisai dari kerusakan aktual"
  },
  State_2595_Desc = {
    Text = "Setiap kali memberikan 1 Kerusakan, dapatkan [StateArg2] Kekuatan sementara."
  },
  State_2595_Name = {
    Text = "Pedang Ratu Sang Pemahaman Terbuka"
  },
  State_2597_Desc = {
    Text = "Setelah ronde dimulai, dapatkan [Layer] poin Perisai."
  },
  State_2597_Name = {
    Text = "Perisai Latensi"
  },
  State_2597_WeaponDesc = {
    Text = "Setelah ronde dimulai, dapatkan [Layer] poin Perisai."
  },
  State_2600_Desc = {
    Text = "Setiap kali kamu kehilangan Hidup, Pembangun dengan Aliemus terendah mendapatkan 10 Aliemus. Setiap kali kamu kehilangan Hidup sebanyak 5 kali, dapatkan 1 lapis Penghalang."
  },
  State_2600_Name = {
    Text = "Pendulum Waktu \"Analisis\""
  },
  State_2601_Desc = {
    Text = "Pada giliran genap, kerusakan yang diterima berkurang sebesar 50%, dan kerusakan meningkat sebesar 33%."
  },
  State_2601_Name = {
    Text = "Berpindah-pindah"
  },
  State_2601_WeaponDesc = {
    Text = "Pada giliran genap, kerusakan yang diterima berkurang sebesar 50%, dan kerusakan meningkat sebesar 33%."
  },
  State_2602_Desc = {
    Text = "Kamu telah terkunci! Setelah digunakan, Eternal Fanatic mendapatkan [StateArg1] poin Kekuatan sementara, dan tanda Deep Dive dari perintah ini dihapus."
  },
  State_2602_Name = {
    Text = "<CardKeyWord:Tanda Penyelaman Dalam>"
  },
  State_2602_WeaponDesc = {
    Text = "Setelah kartu dimainkan, Penyelam Dalam Elite mendapatkan [StateArg1] poin Kekuatan sementara."
  },
  State_2603_Desc = {
    Text = "Jika terdapat \"Embrio\"di tangan, lelahkan semua \"Embrio\", setiap 1 lembar Embrio akan memicu Efek lanjutan sebanyak 1 kali."
  },
  State_2603_Name = {
    Text = "<UnlimitedDevouredIconKeywords:Tak Terbatas Melahap>"
  },
  State_2604_Desc = {
    Text = "Crit. Rate meningkat sebesar [Layer]% dalam ronde ini."
  },
  State_2604_Name = {
    Text = "Crit. Rate Sementara"
  },
  State_2604_WeaponDesc = {
    Text = "Crit. Rate meningkat sebesar [Layer]% dalam ronde ini."
  },
  State_2605_Desc = {
    Text = "Ketika hidup berada di bawah 95% ([StateArg1]), akan membelah menjadi 2 \"Latihan\" dengan jumlah hidup yang sama."
  },
  State_2605_Name = {Text = "Terbelah"},
  State_2605_WeaponDesc = {
    Text = "Ketika Hidup di bawah 30%([StateArg1]), akan terbelah menjadi 3 \"Patung lilin Tubuh yang terlulur Tipe II\" dengan jumlah Hidup yang sama."
  },
  State_2606_Desc = {
    Text = "Ketika hidup berada di bawah 90% ([StateArg1]), akan terbelah menjadi 2 \"Latihan\" dengan jumlah hidup yang sama."
  },
  State_2606_Name = {Text = "Terbelah"},
  State_2606_WeaponDesc = {
    Text = "Ketika Hidup di bawah 30%([StateArg1]), akan terbelah menjadi 3 \"Patung lilin Tubuh yang terlulur Tipe II\" dengan jumlah Hidup yang sama."
  },
  State_2607_Desc = {
    Text = "Pada akhir pertempuran, pulihkan 5 Hidup."
  },
  State_2607_Name = {
    Text = "Pelayan Bulan Cembung Mencerahkan 3"
  },
  State_2607_WeaponDesc = {
    Text = "Pada akhir pertempuran, pulihkan 5 Hidup."
  },
  State_2609_Desc = {
    Text = "Ketika hidup berada di bawah 30% ([StateArg1]), akan terbelah menjadi 2 \"Latihan\" dengan jumlah hidup yang sama."
  },
  State_2609_Name = {Text = "Terbelah"},
  State_2609_WeaponDesc = {
    Text = "Ketika Hidup di bawah 30%([StateArg1]), akan terbelah menjadi 3 \"Patung lilin Tubuh yang terlulur Tipe II\" dengan jumlah Hidup yang sama."
  },
  State_2610_Desc = {
    Text = "Ketika Hidup berada di bawah 70% ([StateArg1]), akan membelah menjadi 2 \"Latihan\" dengan jumlah Hidup yang sama."
  },
  State_2610_Name = {Text = "Terbelah"},
  State_2610_WeaponDesc = {
    Text = "Ketika Hidup di bawah 30%([StateArg1]), akan terbelah menjadi 3 \"Patung lilin Tubuh yang terlulur Tipe II\" dengan jumlah Hidup yang sama."
  },
  State_2611_Desc = {
    Text = "Ketika hidup berada di bawah 50% ([StateArg1]), akan terbelah menjadi 2 \"Latihan\" dengan jumlah hidup yang sama."
  },
  State_2611_Name = {Text = "Terbelah"},
  State_2611_WeaponDesc = {
    Text = "Ketika Hidup di bawah 30%([StateArg1]), akan terbelah menjadi 3 \"Patung lilin Tubuh yang terlulur Tipe II\" dengan jumlah Hidup yang sama."
  },
  State_2612_Desc = {
    Text = "Imitasi Penjelajah Kuno"
  },
  State_2612_Name = {
    Text = "Imitasi Penjelajah Kuno"
  },
  State_2612_WeaponDesc = {
    Text = "Imitasi Penjelajah Kuno"
  },
  State_2614_Desc = {
    Text = "Hanya satu di tim: Setelah memainkan kartu perintah pemilik peralatan, ada kemungkinan sebesar <WeaponEffect_Num:[StateArg1]%> untuk mengembalikannya dari tumpukan kartu buang ke tangan pemain. Efek ini hanya berlaku sekali per putaran."
  },
  State_2614_WeaponDesc = {
    Text = "Setelah kartu perintah pemain dikeluarkan, ada kemungkinan sebesar <WeaponEffect_Num:[StateArg1]%> untuk mengembalikannya dari tumpukan kartu buang ke dalam tangan. Efek ini hanya berlaku satu kali per putaran."
  },
  State_2617_Desc = {
    Text = "Pada awal ronde berikutnya, tarik [DescArg1] kartu tambahan."
  },
  State_2617_Name = {
    Text = "Gejala: Keseruan"
  },
  State_2619_Desc = {
    Text = "Kerusakan aktif yang ditimbulkan dalam pertempuran ini berkurang sebesar [Layer] poin."
  },
  State_2619_Name = {Text = "STR▼"},
  State_2619_WeaponDesc = {
    Text = "Kerusakan yang ditimbulkan dalam pertempuran ini berkurang sebesar [Layer] poin."
  },
  State_2620_Desc = {
    Text = "Relik Karat Pisau Gladius"
  },
  State_2620_Name = {
    Text = "Pisau Bedah Berkarat"
  },
  State_2623_Desc = {
    Text = "Pada awal giliran, dapatkan 1 Aritmetika."
  },
  State_2624_Desc = {
    Text = "Setelah digunakan, semua musuh kehilangan [StateArg1] poin Kekuatan sementara."
  },
  State_2624_Name = {
    Text = "<Rune_18:Kelelahan>"
  },
  State_2625_Desc = {
    Text = "Efek lompatanmu terpicu dua kali. Saat memasuki ronde Ultra, semua musuh mendapatkan 5 poin Kekuatan sementara."
  },
  State_2625_Name = {
    Text = "Relik Mimpi Buruk Jiwa Lampu"
  },
  State_2626_Desc = {
    Text = "Batas maksimum tentakel berkurang 1. Pada akhir ronde, semua tentakel akan melakukan serangan tambahan sebanyak 1 kali."
  },
  State_2627_Name = {
    Text = "Mendapatkan [StateArg1] energi kunci"
  },
  State_2627_WeaponDesc = {
    Text = "Kartu yang dipilih di node \"Patung Lilin yang Belum Selesai\" mendapatkan Energi Kunci."
  },
  State_2628_Desc = {
    Text = "Kartu yang disalin di \"Patung Lilin yang Belum Selesai\" mendapatkan Efek Orison."
  },
  State_2628_Name = {
    Text = "Negara@Bab Dua_Resonansi3"
  },
  State_2628_WeaponDesc = {
    Text = "Pada node \"Patung Lilin yang Belum Selesai\", kartu yang disalin mendapatkan efek Orison."
  },
  State_2629_Desc = {
    Text = "Ditemukan peningkatan jangkauan Kartu yang dapat disalin di \"Patung Lilin yang Belum Selesai\"."
  },
  State_2629_Name = {
    Text = "Negara@Bab Dua_Resonansi2"
  },
  State_2629_WeaponDesc = {
    Text = "Pada node \"Patung Lilin yang Belum Selesai\", kartu yang disalin beserta versi aslinya mendapatkan efek \"Bawaan\"."
  },
  State_2630_Desc = {
    Text = "Kartu yang disalin dari \"Patung Lilin yang Belum Selesai\" dan kartu aslinya mendapatkan \"Efek Penyimpanan\"."
  },
  State_2630_Name = {
    Text = "Negara@Bab_Dua_Resonansi4"
  },
  State_2630_WeaponDesc = {
    Text = "Pada node \"Patung Lilin yang Belum Selesai\", kartu yang disalin dan versi aslinya mendapatkan efek \"Tahan\"."
  },
  State_2631_Desc = {
    Text = "Di \"Patung Lilin yang Belum Selesai\", salin satu Kartu lagi"
  },
  State_2631_Name = {
    Text = "Negara@Bab_Dua_Resonansi6"
  },
  State_2631_WeaponDesc = {
    Text = "Di node \"Patung Lilin yang Belum Selesai\", salin satu Kartu lagi"
  },
  State_2633_Desc = {
    Text = "Setiap menerima 1 kali Active DMG, memasukkan 1 kartu [Nyala Api Hijau] ke tangan dan membuatnya mendapatkan \"Konsumsi\", berlangsung selama [Layer] giliran."
  },
  State_2633_Name = {
    Text = "Cahaya yang menggoda"
  },
  State_2633_WeaponDesc = {
    Text = "Sebelum giliran berikutnya, setiap kali diserang, tambahkan satu kartu Lelah [Api Hijau] ke tangan."
  },
  State_2634_Desc = {
    Text = "Menerima [StateArg1] kerusakan saat memainkan kartu dan menghilangkan 1 lapisan. Saat jumlah lapisan menjadi 0, menetas satu \"Benda Laut\" yang lebih lemah. Jika status parasit masih ada saat giliran berakhir, menetas satu \"Benda Laut\" dengan hidup yang meningkat sesuai dengan jumlah lapisan."
  },
  State_2634_Name = {
    Text = "Parasitized"
  },
  State_2635_Desc = {
    Text = "Negara@Prolog Analisis penyerangan Identifikasi"
  },
  State_2635_Name = {
    Text = "Negara@Prolog Analisis penyerangan Identifikasi"
  },
  State_2635_WeaponDesc = {
    Text = "Negara@Prolog Analisis penyerangan Identifikasi"
  },
  State_2636_Name = {
    Text = "Negara@Bab 4 Resonansi@Berlaku pada giliran berikutnya jumlah kartu yang diambil 1"
  },
  State_2637_Desc = {
    Text = "Pada awal giliran, dapatkan [StateArg1] Aritmetika."
  },
  State_2637_Name = {
    Text = "Penyuntik Aktif Relik"
  },
  State_2637_WeaponDesc = {
    Text = "Pada awal giliran, dapatkan [StateArg1] Aritmetika."
  },
  State_2639_Desc = {
    Text = "Ada kemungkinan mempertahankan 1 poin Hidup saat menerima Kerusakan fatal dalam Pertempuran. Setelah terpicu, kemungkinannya berkurang setengah selama Penyelidikan ini, dan Ketahanan kematian yang diperoleh berkurang setengah."
  },
  State_2639_Name = {
    Text = "<DeathResistanceIconKeywords: Ketahanan Kematian>"
  },
  State_2640_Name = {
    Text = "Efek umum berlaku satu kali"
  },
  State_2645_Desc = {
    Text = "Status@Pendahuluan Musuh Pasif 1"
  },
  State_2645_Name = {
    Text = "Status@Pendahuluan Musuh Pasif 1"
  },
  State_2645_WeaponDesc = {
    Text = "Status@Pendahuluan Musuh Pasif 1"
  },
  State_2646_Desc = {
    Text = "Negara@Pendahuluan Musuh Pasif 2"
  },
  State_2646_Name = {
    Text = "Negara@Pendahuluan Musuh Pasif 2"
  },
  State_2646_WeaponDesc = {
    Text = "Negara@Pendahuluan Musuh Pasif 2"
  },
  State_2647_Desc = {
    Text = "Negara@Prolog Musuh Pasif 3"
  },
  State_2647_Name = {
    Text = "Negara@Prolog Musuh Pasif 3"
  },
  State_2647_WeaponDesc = {
    Text = "Negara@Prolog Musuh Pasif 3"
  },
  State_2648_Desc = {
    Text = "Negara@Pendahuluan Musuh Pasif 4"
  },
  State_2648_Name = {
    Text = "Negara@Pendahuluan Musuh Pasif 4"
  },
  State_2648_WeaponDesc = {
    Text = "Negara@Pendahuluan Musuh Pasif 4"
  },
  State_2649_Desc = {
    Text = "Negara@Pendahuluan Musuh Pasif 5"
  },
  State_2649_Name = {
    Text = "Negara@Pendahuluan Musuh Pasif 5"
  },
  State_2649_WeaponDesc = {
    Text = "Negara@Pendahuluan Musuh Pasif 5"
  },
  State_2650_Desc = {
    Text = "Negara@Pendahuluan Musuh Pasif 6"
  },
  State_2650_Name = {
    Text = "Negara@Pendahuluan Musuh Pasif 6"
  },
  State_2650_WeaponDesc = {
    Text = "Negara@Pendahuluan Musuh Pasif 6"
  },
  State_2651_Desc = {
    Text = "Negara@Prolog Musuh Pasif 7"
  },
  State_2651_Name = {
    Text = "Negara@Prolog Musuh Pasif 7"
  },
  State_2651_WeaponDesc = {
    Text = "Negara@Prolog Musuh Pasif 7"
  },
  State_2652_Desc = {
    Text = "Negara@Pendahuluan Musuh Pasif 8"
  },
  State_2652_Name = {
    Text = "Negara@Pendahuluan Musuh Pasif 8"
  },
  State_2652_WeaponDesc = {
    Text = "Negara@Pendahuluan Musuh Pasif 8"
  },
  State_2653_Desc = {
    Text = "Negara@Pendahuluan Musuh Pasif 9"
  },
  State_2653_Name = {
    Text = "Negara@Pendahuluan Musuh Pasif 9"
  },
  State_2653_WeaponDesc = {
    Text = "Negara@Pendahuluan Musuh Pasif 9"
  },
  State_2655_Desc = {
    Text = "Saat memberikan kerusakan yang tidak terblokir, pulihkan jumlah hidup yang sama. Kerusakan akan dihapus saat diberikan."
  },
  State_2655_Name = {Text = "Vampirisme"},
  State_2656_Desc = {
    Text = "Pada giliran berikutnya, aku akan segera pergi!!!!!!"
  },
  State_2656_Name = {Text = "Keluar"},
  State_2660_Desc = {
    Text = "Pada awal pertempuran, dapatkan kekuatan, tetapi kerusakan yang diterima setiap kali meningkat sebesar 5."
  },
  State_2660_Name = {
    Text = "Punggung ke air"
  },
  State_2661_Desc = {
    Text = "Pada saat pertempuran dimulai, semua musuh kehilangan [Arg1] poin Kekuatan."
  },
  State_2662_Name = {
    Text = "Negara@Bab_Tiga_Test_Negara"
  },
  State_2663_Desc = {
    Text = "Mengakibatkan Kelemahan pada diri sendiri selama 1 ronde saat ditarik. Setelah digunakan, semua musuh akan mengalami Kelemahan selama 1 ronde. Tidak dapat dijual."
  },
  State_2663_Name = {
    Text = "Negara Kutukan Melemah"
  },
  State_2663_WeaponDesc = {
    Text = "Mengakibatkan Kelemahan pada diri sendiri selama 1 ronde saat ditarik. Setelah digunakan, semua musuh akan mengalami Kelemahan selama 1 ronde. Tidak dapat dijual."
  },
  State_2666_Name = {
    Text = "Crit. Rate Belati Roda Kehidupan"
  },
  State_2667_Desc = {
    Text = "Kerusakan kartu serangan meningkat sebesar [Layer]%."
  },
  State_2667_Name = {
    Text = "Kerusakan kartu pukulan meningkat"
  },
  State_2667_WeaponDesc = {
    Text = "Kerusakan kartu serangan meningkat sebesar [Layer]%."
  },
  State_2668_Desc = {
    Text = "Meningkatkan [Layer]% Daya Serang."
  },
  State_2668_Name = {
    Text = "Peningkatan persentase Daya Serang permanen universal"
  },
  State_2668_WeaponDesc = {
    Text = "Meningkatkan [Layer]% Daya Serang."
  },
  State_2669_Desc = {
    Text = "Crit. DMG meningkat sebesar [Layer]% dalam pertempuran ini."
  },
  State_2669_Name = {Text = "Crit. DMG"},
  State_2670_Desc = {
    Text = "Ketika kamu menyebabkan Kelemahan, dapatkan [Arg1] poin Perisai; ketika menyebabkan Rentan, dapatkan [Arg2] poin Kekuatan. Jika kedua Efek ini terpicu dalam 1 putaran, dapatkan tambahan [Arg1] poin Perisai dan [Arg2] poin Kekuatan."
  },
  State_2670_Name = {
    Text = "Bingkai Gambar Berat"
  },
  State_2671_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_2671_Name = {Text = "Not Roused"},
  State_2672_Desc = {
    Text = "Di awal setiap ronde, tim kami diberi lapisan [Borgol]."
  },
  State_2672_Name = {Text = "Pembatasan"},
  State_2672_WeaponDesc = {
    Text = "Di awal setiap ronde, tim kami diberi lapisan [Borgol]."
  },
  State_2674_Desc = {
    Text = "Crit. Rate meningkat sebesar [Layer]% dalam ronde ini."
  },
  State_2674_Name = {
    Text = "Crit. Rate Sementara"
  },
  State_2676_Name = {
    Text = "Aksesoris Detak Merah Tua"
  },
  State_2676_WeaponDesc = {
    Text = "Setelah melepaskan Geng, pemakai mendapatkan 15% Crit. Rate sementara. Jika Crit. DMG pemakai saat ini lebih dari 80%, pemakai mendapatkan tambahan 15% Crit. Rate sementara."
  },
  State_2677_Desc = {
    Text = "Kerusakan yang diterima dari 3 serangan pertama setiap ronde oleh serangan aktif/tentakel berkurang sebesar 75%."
  },
  State_2677_Name = {
    Text = "\"Tubuh Abadi\""
  },
  State_2677_WeaponDesc = {
    Text = "Kerusakan yang diterima dari 3 serangan pertama setiap ronde oleh serangan aktif/tentakel berkurang sebesar 75%."
  },
  State_2679_Name = {
    Text = "Negara@BabTiga_Resonansi7_Tanda"
  },
  State_2680_Desc = {
    Text = "Crit. Rate meningkat 20%. Jika HP di bawah 25% saat giliran dimulai, pasti akan menghasilkan kritis pada giliran ini."
  },
  State_2681_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_2681_Name = {Text = "Not Roused"},
  State_2682_Desc = {
    Text = "Perisai dan sembuh meningkat 50%."
  },
  State_2682_Name = {
    Text = "Penjaga Taman yang Terasing"
  },
  State_2682_WeaponDesc = {
    Text = "Perisai dan sembuh meningkat 50%."
  },
  State_2683_Desc = {
    Text = "Menggambar kartu lapisan negara."
  },
  State_2683_Name = {Text = "Draw"},
  State_2684_Desc = {
    Text = "Tim Unik: Serangan \"Pukulan\" dari pemakai memiliki peluang sebesar <WeaponEffect_Num:[StateArg1]%> untuk mendapatkan 1 Aritmetika dan memicu 10% <IntoxicationIconKeywords:Racun> pada semua musuh. Jika alam saat ini adalah \"Aequor\", saat efek ini dipicu, 1 Tentakel akan menyerang 1 kali. Efek ini hanya berlaku sekali per ronde."
  },
  State_2684_WeaponDesc = {
    Text = "Pemakai \"Serangan\" memiliki peluang sebesar <WeaponEffect_Num:[StateArg1]%> untuk mendapatkan 1 Aritmetika dan memicu [DescArg1]% <IntoxicationIconKeywords:Racun> pada semua musuh. Jika Alam saat ini adalah \"Aequor\", saat efek ini dipicu, 1 Tentakel akan menyerang 1 kali. Efek ini dapat dipicu maksimal 1 kali per ronde."
  },
  State_2685_Desc = {
    Text = "Kekebalan terhadap Kelemahan, Rapuh, dan Rentan. Hapus 1 lapisan pada akhir giliran."
  },
  State_2685_Name = {
    Text = "<BlessingIconKeywords: Berkah>"
  },
  State_2685_WeaponDesc = {
    Text = "Kebal terhadap negara negatif yang diberikan pada diri sendiri dalam ronde ini."
  },
  State_2686_Desc = {
    Text = "Kartu sementara yang diberikan selama pertempuran."
  },
  State_2686_Name = {
    Text = "<CardKeyWord:Kartu negara>"
  },
  State_2687_Desc = {
    Text = "Crit. Rate meningkat sebesar 100% dalam ronde ini."
  },
  State_2687_Name = {
    Text = "Sementara terjamin meledak"
  },
  State_2687_WeaponDesc = {
    Text = "Crit. Rate meningkat sebesar 100% dalam ronde ini."
  },
  State_2688_Desc = {
    Text = "Setelah memainkan kartu ke-3 setiap ronde, tempatkan 1 \"Inspirasi\" ke Tumpukan kartu buang. Setelah memainkan kartu ke-6 setiap ronde, ambil 1 \"Inspirasi\" dari Tumpukan kartu buang dan masukkan ke tangan."
  },
  State_2689_Desc = {
    Text = "Pada awal ronde, tarik 2 kartu. Kapasitas slot Ultra meningkat sebesar 2."
  },
  State_2689_Name = {
    Text = "Topi Relik dari Ahli Tipu Daya"
  },
  State_2689_WeaponDesc = {
    Text = "Pada awal ronde, tarik 2 kartu. Kapasitas slot Ultra meningkat sebesar 2."
  },
  State_2690_Desc = {
    Text = "Ketika Ksatria Kebajikan memainkan Kartu, ia mendapatkan [StateArg1] poin Kekuatan."
  },
  State_2690_Name = {
    Text = "Jiwa Ksatria"
  },
  State_2691_Desc = {
    Text = "Satu-satunya Tim: Setelah pemakai melepaskan Aliemus Muliakan, mereka mendapatkan <WeaponEffect_Num:[StateArg1]> poin Aliemus dan <WeaponEffect_Num:[StateArg2]> poin Energi-s. Efek ini diulang satu kali untuk setiap 4 Kartu di tangan. Jika Alam saat ini adalah \"Ultra\", setelah Kartu pemakai memasuki Ruang Ultra, mereka mendapatkan Kekuatan sementara sebesar <WeaponEffect_Num:[StateArg3]%> dari Daya Serang pemakai. Efek ini dapat dipicu maksimal 2 kali per ronde."
  },
  State_2691_WeaponDesc = {
    Text = "Setelah pemain menggunakan Muliakan, mereka mendapatkan <WeaponEffect_Num:[StateArg1]> poin Aliemus dan <WeaponEffect_Num:[StateArg2]> poin Energi-s, efek ini diulang 1 kali untuk setiap 4 kartu di tangan. Jika Alam saat ini adalah \"Ultra\", ketika kartu pemain memasuki ruang Ultra, mereka mendapatkan <WeaponEffect_Num:[Power:DescArg1]> poin Kekuatan sementara, dengan batas maksimum 2 kali per ronde."
  },
  State_2693_Desc = {
    Text = "Negara@Pendahuluan_Aliemus_0_1_2_Efek"
  },
  State_2693_Name = {
    Text = "Negara@Pendahuluan_Aliemus_0_1_2_Efek"
  },
  State_2693_WeaponDesc = {
    Text = "Negara@Pendahuluan_Aliemus_0_1_2_Efek"
  },
  State_2694_Desc = {
    Text = "Setiap konsumsi 1 Segil hitam, semua Pembangun mendapatkan 1 Aliemus."
  },
  State_2694_Name = {
    Text = "Negara Relik Terbalik Bunga"
  },
  State_2694_WeaponDesc = {
    Text = "Setiap konsumsi 1 Segil hitam, semua Pembangun mendapatkan 1 Aliemus."
  },
  State_2695_Desc = {
    Text = "Setiap kali kartu Pembangun memasuki ruang Ultra, berikan 15 Aliemus kepada Pembangun yang sesuai."
  },
  State_2696_Desc = {
    Text = "Negara@Prolog_Aliemus0_1_2_berlaku"
  },
  State_2696_Name = {
    Text = "Negara@Prolog_Aliemus0_1_2_berlaku"
  },
  State_2696_WeaponDesc = {
    Text = "Negara@Prolog_Aliemus0_1_2_berlaku"
  },
  State_2698_Name = {
    Text = "Pada awal turn berikutnya, Aritmetika +1"
  },
  State_2699_Name = {
    Text = "Pada awal turn berikutnya, Aritmetika +2"
  },
  State_2701_Desc = {
    Text = "Ketika Aequor Lady memperoleh perisai, tingkatkan [StateArg1] kerusakan tentakel sementara."
  },
  State_2701_Name = {
    Text = "Dibuat menjadi ada"
  },
  State_2701_WeaponDesc = {
    Text = "Ketika Aequor Lady memperoleh perisai, tingkatkan [StateArg1] kerusakan tentakel sementara."
  },
  State_2702_Desc = {
    Text = "Mendapatkan 100% Ketahanan Kematian saat memungut. Setelah Ketahanan Kematian terpicu, pulihkan [Arg1] poin Hidup di awal setiap putaran selama pertempuran ini."
  },
  State_2702_Name = {
    Text = "Pernapasan Buatan"
  },
  State_2703_Desc = {
    Text = "Salinan sementara dari kartu Pembangun pertama yang dimainkan setiap ronde akan masuk ke dalam Celah Dimensi, dan dapat digunakan untuk melindungi diri di saat-saat berbahaya!"
  },
  State_2703_Name = {
    Text = "Fissura Dimensi"
  },
  State_2705_Name = {
    Text = "Pembalasan Untukmu"
  },
  State_2706_Desc = {
    Text = "Pengujian petrifikasi bertahap"
  },
  State_2706_Name = {
    Text = "Pengujian petrifikasi bertahap"
  },
  State_2706_WeaponDesc = {
    Text = "Pengujian petrifikasi bertahap"
  },
  State_2707_Desc = {
    Text = "Dalam ronde ini, Tentakel melakukan Serangan terhadap semua musuh."
  },
  State_2707_Name = {
    Text = "Serangan Penuh Tentakel"
  },
  State_2707_WeaponDesc = {
    Text = "Dalam ronde ini, Tentakel melakukan Serangan terhadap semua musuh."
  },
  State_2708_Desc = {
    Text = "Batas maksimal tentakel bertambah 1. Saat hidup di bawah 50%, kerusakan tentakel meningkat sebesar [StateArg1]."
  },
  State_2708_Name = {
    Text = "Persembahan dari Masa Lalu yang Menyimpang"
  },
  State_2708_WeaponDesc = {
    Text = "Batas maksimal tentakel bertambah 1. Saat hidup di bawah 50%, kerusakan tentakel meningkat sebesar [StateArg1]."
  },
  State_2709_Desc = {
    Text = "Relik Karat Pisau Gladius Penghitung"
  },
  State_2710_Desc = {Text = "Cap"},
  State_2710_Name = {Text = "Cap"},
  State_2710_WeaponDesc = {Text = "Cap"},
  State_2711_Desc = {
    Text = "Ubah sementara kekuatan aritmetika kartu"
  },
  State_2711_Name = {
    Text = "Ubah sementara kekuatan aritmetika kartu"
  },
  State_2711_WeaponDesc = {
    Text = "Ubah sementara kekuatan aritmetika kartu"
  },
  State_2712_Desc = {
    Text = "Meningkatkan perisai yang dihasilkan."
  },
  State_2712_Name = {
    Text = "<AlertIconKeywords: Waspada>"
  },
  State_2712_WeaponDesc = {
    Text = "Perisai yang diperoleh meningkat."
  },
  State_2713_Desc = {
    Text = "Pedang Raksasa Balas Dendam akan memperoleh Kekuatan setiap putaran."
  },
  State_2713_Name = {
    Text = "Bilah Balas Dendam Bangun"
  },
  State_2713_WeaponDesc = {
    Text = "Pada ronde berikutnya, dapatkan perisai sejumlah kehilangan hidup dari ronde sebelumnya."
  },
  State_2715_Desc = {
    Text = "Perisai yang diperoleh dalam level ini meningkat sebesar [Layer] poin."
  },
  State_2715_Name = {
    Text = "Kewaspadaan Permanen"
  },
  State_2715_WeaponDesc = {
    Text = "Perisai yang diperoleh dalam level ini meningkat sebesar [Layer] poin."
  },
  State_2718_Desc = {
    Text = "Satu-satunya di tim: Pada akhir ronde, pemegang peralatan mendapatkan <WeaponEffect_Num:[StateArg1]> poin Aliemus, serta memperoleh Energi-s yang setara dengan isi ulang kunci perak dari pemegang peralatan."
  },
  State_2718_WeaponDesc = {
    Text = "Pada akhir ronde, pemegang peralatan mendapatkan <WeaponEffect_Num:[StateArg1]> poin Aliemus, serta memperoleh Energi-s yang setara dengan isi ulang kunci perak pemegang."
  },
  State_2720_Desc = {
    Text = "Saat menyebabkan kerusakan nyata, kurangi 10 Aliemus dari Pembangun dengan Aliemus tertinggi."
  },
  State_2720_Name = {Text = "Void"},
  State_2720_WeaponDesc = {
    Text = "Saat menyebabkan kerusakan nyata, kurangi 10 Aliemus dari Pembangun dengan Aliemus tertinggi."
  },
  State_2721_Name = {
    Text = "Negara@Tingkat2_9_Pertempuran5_Gelembung1"
  },
  State_2722_Desc = {
    Text = "Setelah digunakan, masukkan [StateArg1] kartu \"Inspirasi\" ke dalam tumpukan undian. \"Inspirasi\": Dapatkan 1 Aritmetika, menggambar 1 kartu, simpan, lelah."
  },
  State_2722_Name = {
    Text = "<Rune_17_High:Inspirasi Tinggi>"
  },
  State_2723_Desc = {
    Text = "Setelah digunakan, semua musuh menjadi rentan selama [StateArg1] putaran."
  },
  State_2723_Name = {
    Text = "<Rune_1_High:Rentan tingkat lanjut>"
  },
  State_2724_Desc = {
    Text = "Jumlah Serangan meningkat 1."
  },
  State_2724_Name = {
    Text = "Inti Mimpi: Serangan Balik"
  },
  State_2726_Desc = {
    Text = "Setelah digunakan, semua musuh akan menerima [StateArg1] lapisan Racun, menyebabkan semua musuh memicu [StateArg2]% Racun."
  },
  State_2726_Name = {
    Text = "<Rune_10_High:Toksin Tinggi>"
  },
  State_2727_Desc = {
    Text = "Saat akan mati, pulihkan 1 Hidup dan hapus status ini."
  },
  State_2727_Name = {Text = "Racine"},
  State_2727_WeaponDesc = {
    Text = "Saat akan mati, pulihkan 1 Hidup dan hapus status ini."
  },
  State_2728_Desc = {
    Text = "Pada awal ronde, untuk setiap sekutu lainnya, dapatkan 1 lapisan <ParcloseIconKeywords:Penghalang>."
  },
  State_2728_Name = {
    Text = "Barier Tautan"
  },
  State_2728_WeaponDesc = {
    Text = "Pada awal giliran, untuk setiap sekutu lainnya, dapatkan perisai sebesar [Layer]% dari kesehatan maksimum."
  },
  State_2729_Desc = {
    Text = "Saat terpicu, tarik satu kartu yang sesuai dengan Bangun."
  },
  State_2729_Name = {
    Text = "Alienasi Ruang Deflektor Menggambar"
  },
  State_2729_WeaponDesc = {
    Text = "Saat terpicu, tarik satu kartu yang sesuai dengan Bangun."
  },
  State_2730_Desc = {
    Text = "Setelah kematian dirinya sendiri, Hydra kehilangan 1 tingkat \"Negara Pengendali Ular\"."
  },
  State_2730_Name = {Text = "Familier"},
  State_2732_Desc = {
    Text = "Negara@Pendahuluan Aliemus Inisialisasi 0_2_3"
  },
  State_2732_Name = {
    Text = "Negara@Pendahuluan Aliemus Inisialisasi 0_2_3"
  },
  State_2732_WeaponDesc = {
    Text = "Negara@Pendahuluan Aliemus Inisialisasi 0_2_3"
  },
  State_2734_Name = {
    Text = "Jumlah kartu yang diambil pada awal giliran berikutnya +1"
  },
  State_2735_Desc = {
    Text = "Jika memainkan kartu ini memicu \"Dimension Shuttle\" atau saat ini berada dalam ronde Ultra, memicu efek selanjutnya."
  },
  State_2735_Name = {
    Text = "<TransitionIconKeywords:Lompatan>"
  },
  State_2735_WeaponDesc = {
    Text = "Jika saat ini berada di ronde Ultra, efek Lompatan dapat dipicu."
  },
  State_2737_Desc = {
    Text = "Ketika dek tim kami direset, dapatkan [Layer] kekuatan."
  },
  State_2737_Name = {
    Text = "Selalu membeku"
  },
  State_2738_Name = {
    Text = "Efek Kelemahan Ditingkatkan"
  },
  State_2740_Desc = {
    Text = "Di tempat \"Patung lilin yang belum selesai\", Kartu yang disalin dan Kartu aslinya mengurangi Lelah Aritmetika sebesar 1, serta mendapatkan satu Kartu gejala."
  },
  State_2740_Name = {
    Text = "Negara@BabDua_Resonansi5_2"
  },
  State_2740_WeaponDesc = {
    Text = "Pada node \"Patung lilin yang belum selesai\", kartu yang disalin dan versi aslinya mengurangi lelah aritmetika sebesar 1."
  },
  State_2741_Desc = {
    Text = "Di tempat \"Patung lilin yang belum selesai\", Kartu yang disalin dan Kartu aslinya mengurangi Lelah Aritmetika sebesar 1, serta mendapatkan satu Kartu gejala."
  },
  State_2741_Name = {
    Text = "Negara@BabDua_Resonansi5_1"
  },
  State_2741_WeaponDesc = {
    Text = "Pada node \"Patung lilin yang belum selesai\", kartu yang disalin dan versi aslinya mengurangi lelah aritmetika sebesar 1."
  },
  State_2742_Desc = {
    Text = "Setiap Ticktock memberikan 1 Kerusakan, mendapatkan [StateArg2] Kekuatan sementara. Setiap kali memperoleh Perisai, mendapatkan [StateArg3] Waspada sementara."
  },
  State_2742_Name = {
    Text = "Penyesuaian Parameter"
  },
  State_2744_Desc = {
    Text = "Setiap kali kartu Pembangun memasuki ruang Ultra, berikan 15 Aliemus."
  },
  State_2744_Name = {
    Text = "Relik Lompatan"
  },
  State_2744_WeaponDesc = {
    Text = "Setiap kali kartu Pembangun memasuki ruang Ultra, berikan 15 Aliemus."
  },
  State_2746_Desc = {
    Text = "Jumlah serangan +1, kehilangan [Layer] poin Kekuatan"
  },
  State_2746_Name = {Text = "Gelisah"},
  State_2747_Desc = {
    Text = "Setelah digunakan, Pembangun lain mendapatkan [StateArg1] Aliemus."
  },
  State_2747_Name = {
    Text = "<Rune_16:Pengkatalis>"
  },
  State_2748_Desc = {
    Text = "Negara@Upacara Lentera"
  },
  State_2748_Name = {
    Text = "Negara@Upacara Lentera"
  },
  State_2748_WeaponDesc = {
    Text = "Negara@Upacara Lentera"
  },
  State_2749_Desc = {
    Text = "Setelah menyebabkan kerusakan tentakel dalam ronde ini, berikan [Layer] lapisan racun kepada target."
  },
  State_2749_Name = {Text = "Arus dalam"},
  State_2750_Desc = {
    Text = "Ikutlah bersamaku tenggelam ke dalam lautan·········"
  },
  State_2750_Name = {
    Text = "Nymphaea Bangun"
  },
  State_2752_Desc = {
    Text = "Ketika teratai tidur memberikan kerusakan, dapatkan [StateArg2] Aliemus."
  },
  State_2752_Name = {
    Text = "Kesedihan tenggelam"
  },
  State_2752_WeaponDesc = {
    Text = "Ketika teratai tidur memberikan kerusakan, dapatkan [StateArg2] Aliemus."
  },
  State_2753_Desc = {
    Text = "Pada awal giliran, jika nyawa lebih dari [Arg1], kehilangan [Arg1] poin hidup, dan dalam giliran tersebut mendapatkan [Arg2] poin kekuatan dan [Arg3] poin waspada."
  },
  State_2754_Name = {
    Text = "Negara@Kartu pukulan sementara meningkatkan Crit. Rate"
  },
  State_2757_Desc = {
    Text = "Pada awal ronde berikutnya, dapatkan [DescArg1] poin Aritmetika tambahan."
  },
  State_2757_Name = {
    Text = "Gejala: Penuh curiga"
  },
  State_2758_Desc = {
    Text = "Efek pemulihan hidupmu meningkat sebesar [Arg1] poin, dan kelebihan dari pemulihan hidup akan diubah menjadi perisai dalam jumlah yang sama."
  },
  State_2758_Name = {
    Text = "Spesimen kupu-kupu"
  },
  State_2760_Desc = {
    Text = "Setiap kali seorang Pembangun melakukan 1 kali Melahap, Pembangun lainnya mendapatkan 10 Aliemus."
  },
  State_2762_Desc = {
    Text = "Setelah digunakan, efek tambahan berlaku sebanyak [StateArg1] kali, mendapatkan [StateArg2] poin Segil hitam, Lelah, bawaan."
  },
  State_2762_Name = {
    Text = "<Rune_7_High:Gema Tinggi>"
  },
  State_2762_WeaponDesc = {
    Text = "Setelah digunakan, efek tambahan berlaku sebanyak [StateArg1] kali, Lelah."
  },
  State_2763_Desc = {
    Text = "Setiap kali Tidur Rex menghabiskan 1 aritmetika, tingkat kerusakan tentakel [StateArg1] meningkat."
  },
  State_2763_Name = {
    Text = "Kemuliaan Abadi"
  },
  State_2763_WeaponDesc = {
    Text = "Setiap kali Tidur Rex menghabiskan 1 aritmetika, tingkat kerusakan tentakel [StateArg1] meningkat."
  },
  State_2764_Desc = {
    Text = "Saat menyebabkan kerusakan yang tidak terblokir, tambahkan [StateArg1] lapisan berdarah."
  },
  State_2764_Name = {
    Text = "Pembluedaran jahat"
  },
  State_2765_Name = {
    Text = "Negara@George@Sembuh saat mati"
  },
  State_2767_Name = {
    Text = "Negara @Segil hitam dan efisiensi Isi ulang kunci perak"
  },
  State_2769_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_2769_Name = {Text = "Not Roused"},
  State_2771_Desc = {
    Text = "Kekuatan Monster"
  },
  State_2771_Name = {
    Text = "Kekuatan Monster"
  },
  State_2772_Name = {
    Text = "Negara@Level2_5Pertempuran3Gelembung1"
  },
  State_2773_Desc = {
    Text = "Pada awal pertempuran, tambahkan 1 kartu \"Momen Indah - Ganti semua kartu Pembangun di tangan dengan \"Pukulan\", sampai akhir ronde. Simpan, Lelah.\" ke tangan."
  },
  State_2775_Desc = {
    Text = "Jumlah pengundian kembali"
  },
  State_2775_Name = {
    Text = "Pengembalian Jumlah Menggambar"
  },
  State_2776_Name = {
    Text = "Mata Batu Terhenti: Kutukan Memperkuat"
  },
  State_2777_Name = {
    Text = "Negara@Bab_Tiga_Kosong"
  },
  State_2778_Desc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1] poin perisai. Setelah menggunakan \"Pertahanan\" sebanyak 7 kali dalam pertempuran ini, segera dapatkan tambahan [Arg2] poin perisai."
  },
  State_2778_Name = {
    Text = "Koran Pagi Putney"
  },
  State_2779_Desc = {
    Text = "Ketika Hidup berada di bawah 50%([StateArg1]), akan terpecah menjadi 3 \"Tubuh yang terlulur\" dengan jumlah Hidup yang sama."
  },
  State_2779_Name = {Text = "Terbelah"},
  State_2779_WeaponDesc = {
    Text = "Ketika Hidup berada di bawah 50%([StateArg1]), akan terbelah menjadi 2 \"Tubuh yang terlulur Tipe II\" dengan jumlah Hidup yang sama."
  },
  State_2780_Desc = {
    Text = "Setelah digunakan, mendapatkan [StateArg1] poin Aritmetika."
  },
  State_2780_Name = {
    Text = "<Rune_4:Perhitungan>"
  },
  State_2781_Desc = {
    Text = "Setiap kali memainkan [Layer] kartu, jika tidak memiliki Penghalang, tambahkan satu lapisan <ParcloseIconKeywords:Penghalang>."
  },
  State_2781_Name = {
    Text = "Barier Berdaya"
  },
  State_2781_WeaponDesc = {
    Text = "Setiap kali tim kami memainkan [Layer] kartu, monster akan memperbarui satu lapisan Penghalang."
  },
  State_2784_Desc = {
    Text = "Bahkan jika bukan giliran Ultra, efek Lompatan dapat dipicu sekali per putaran. Kapasitas ruang Ultra meningkat sebesar 2."
  },
  State_2785_Desc = {
    Text = "Tim Unik: Setelah Pemakai memainkan kartu, Pemakai mendapatkan 1 poin Aliemus. Saat pertempuran dimulai, dapatkan <PowerIconKeywords:Strength> sebesar <WeaponEffect_Num:[StateArg1]%> dari ATK Pemakai, jika Realm saat ini adalah \"Aequor\", tambahan dapatkan <WeaponEffect_Num:[StateArg2]%> Kerusakan tentakel <CardKeyWord:>, pada awal setiap ronde berikutnya, dapatkan <PowerIconKeywords:Strength> sebesar <WeaponEffect_Num:[StateArg3]%> dari ATK Pemakai, jika Realm saat ini adalah \"Aequor\", tambahan dapatkan <WeaponEffect_Num:[StateArg4]%> <CardKeyWord:Kerusakan tentakel>."
  },
  State_2785_WeaponDesc = {
    Text = "Setelah pemain menggunakan kartu, pemain mendapatkan 1 poin Aliemus. Saat pertempuran dimulai, dapatkan <WeaponEffect_Num:[Power:DescArg1]> poin <PowerIconKeywords:Kekuatan>. Jika alam saat ini adalah \"Aequor\", dapatkan tambahan <WeaponEffect_Num:[DescArg2]> poin <CardKeyWord:Kerusakan tentakel>, dan pada setiap awal ronde berikutnya, dapatkan <WeaponEffect_Num:[Power:DescArg3]> poin <PowerIconKeywords:Kekuatan>. Jika alam saat ini adalah \"Aequor\", dapatkan tambahan <WeaponEffect_Num:[DescArg4]> poin <CardKeyWord:Kerusakan tentakel>."
  },
  State_2786_Name = {
    Text = "Relik Berlumuran Darah Menghitung Kerikil"
  },
  State_2787_Desc = {
    Text = "Pulihkan hidup, masukkan 1 kartu [Ilusi Akhir] ke dalam Tumpukan kartu buang. Permanen, hancurkan."
  },
  State_2787_Name = {
    Text = "<CardKeyWord:Pengusutan Kebenaran>"
  },
  State_2787_WeaponDesc = {
    Text = "Pulihkan hidup, masukkan 1 kartu [Ilusi Akhir] ke dalam Tumpukan kartu buang. Permanen, hancurkan."
  },
  State_2788_Desc = {
    Text = "Pada awal ronde, tarik [StateArg1] kartu."
  },
  State_2788_Name = {
    Text = "Lentera Harapan Nabi Relik 1"
  },
  State_2788_WeaponDesc = {
    Text = "Pada awal ronde, tarik [StateArg1] kartu."
  },
  State_2789_Desc = {
    Text = "Kartu ini telah diutak-atik oleh Jenkin! Setelah di-play, menerima [Layer] poin <FixedDamage:Kerusakan Murni>."
  },
  State_2789_Name = {
    Text = "<CardKeyWord:Menerima [Layer] kerusakan setelah digunakan>"
  },
  State_2789_WeaponDesc = {
    Text = "Kartu yang dimainkan menerima [StateArg1] kerusakan."
  },
  State_2790_Desc = {
    Text = "Pada akhir ronde, kamu dapat memilih untuk menyimpan [StateArg1] kartu di tangan."
  },
  State_2790_Name = {
    Text = "Lentera Harapan Nabi Relik 2"
  },
  State_2790_WeaponDesc = {
    Text = "Pada akhir ronde, kamu dapat memilih untuk menyimpan [StateArg1] kartu di tangan."
  },
  State_2792_Desc = {
    Text = "Pada awal Pertempuran, semua sekutu mendapatkan 3 lapisan [Kulit Lilin]. Pada awal giliran, masukkan satu kartu Kejang ke dalam tumpukan Menggambar tim kami."
  },
  State_2792_Name = {
    Text = "\"Wanita Lilin\""
  },
  State_2792_WeaponDesc = {
    Text = "Pada awal Pertempuran, semua sekutu mendapatkan 3 lapisan [Kulit Lilin]. Pada awal giliran, masukkan satu kartu Kejang ke dalam tumpukan Menggambar tim kami."
  },
  State_2793_Desc = {
    Text = "Negara@Mata Batu Perjuangan Sebelum Kematian"
  },
  State_2793_Name = {
    Text = "Negara@Mata Batu Perjuangan Sebelum Kematian"
  },
  State_2793_WeaponDesc = {
    Text = "Negara@Mata Batu Perjuangan Sebelum Kematian"
  },
  State_2796_Desc = {
    Text = "Setiap kali kamu kehilangan hidup, tambahkan [Arg1] lapisan Racun ke semua musuh. Setiap ronde meningkatkan nilai Racun sebesar [Arg2] poin."
  },
  State_2797_Desc = {
    Text = "Pada awal ronde, tambahkan satu \"Payung Matahari\" dengan [Arg1] Waspada yang diperoleh dalam ronde ini ke tangan. Setelah memainkan 6 kartu, tingkatkan semua \"Payung Matahari\" di tangan sebesar [Arg2] Waspada."
  },
  State_2798_Desc = {
    Text = "Ketika Imam Kasih memberikan Perisai, kurangi Lelah Aritmetika sebesar -1 pada satu kartu tangan acak hingga kartu tersebut dimainkan."
  },
  State_2798_Name = {
    Text = "Kasih sayang ayah"
  },
  State_2798_WeaponDesc = {
    Text = "Ketika Imam Kasih memberikan Perisai, kurangi Lelah Aritmetika sebesar -1 pada satu kartu tangan acak hingga kartu tersebut dimainkan."
  },
  State_2799_Desc = {
    Text = "Saat Rembulan Laut menimbulkan Active DMG, [StateArg1] tentakel menyerang target tersebut."
  },
  State_2799_Name = {
    Text = "Pembiakan diri"
  },
  State_2799_WeaponDesc = {
    Text = "Ketika Haiyue menyebabkan kerusakan, [StateArg1] tentakel akan melakukan serangan terhadap target tersebut."
  },
  State_2800_Desc = {
    Text = "Kerusakan, perisai, dan sembuh yang dilakukan oleh pengguna meningkat [StateArg1]%。（Sementara）"
  },
  State_2800_Name = {
    Text = "Negara@Prototipe Pisau Kecil Kerusakan Ledakan"
  },
  State_2801_Desc = {
    Text = "Meningkatkan jumlah lapisan Pelarutan saat menerima Kerusakan aktual"
  },
  State_2801_Name = {
    Text = "Meningkatkan jumlah lapisan Pelarutan Mendalam saat menerima Kerusakan."
  },
  State_2801_WeaponDesc = {
    Text = "Meningkatkan jumlah lapisan Pelarutan saat menerima Kerusakan aktual"
  },
  State_2802_Desc = {
    Text = "Di awal ronde, tambahkan Kekuatan sementara."
  },
  State_2802_Name = {
    Text = "Tambahkan kekuatan sementara"
  },
  State_2804_Desc = {
    Text = "Kerusakan, perisai, dan sembuh yang dilakukan oleh pengguna meningkat [StateArg1]%。（Sementara）"
  },
  State_2804_Name = {
    Text = "Negara@Kerusakan Meriam Laser Prototipe"
  },
  State_2805_Desc = {
    Text = "Pada akhir ronde, sekutu lainnya mendapatkan Kekuatan."
  },
  State_2805_Name = {
    Text = "\"Api Pencerahan\""
  },
  State_2807_Desc = {
    Text = "Pada awal ronde, tambahkan satu \"Payung Matahari\" dengan [Arg1] Waspada yang diperoleh dalam ronde ini ke tangan. Setelah memainkan 6 kartu, tingkatkan semua \"Payung Matahari\" di tangan sebesar [Arg2] Waspada."
  },
  State_2808_Desc = {
    Text = "Pada akhir ronde, hasilkan 1 Fusi Embrio. Jika memiliki Embrio di tangan, pulihkan 15 Hidup."
  },
  State_2808_Name = {
    Text = "Anomalous Hemostat"
  },
  State_2808_WeaponDesc = {
    Text = "Pada akhir ronde, hasilkan 1 Fusi Embrio. Jika memiliki Embrio di tangan, pulihkan 15 Hidup."
  },
  State_2809_Desc = {
    Text = "Kehilangan permanen [Arg1] Kekuatan saat diambil. Setiap kali memberikan Kerusakan, pulihkan [Arg2] poin Hidup, maksimal dipicu 6 kali per putaran."
  },
  State_2809_Name = {
    Text = "Ciuman Lamprey"
  },
  State_2810_Desc = {
    Text = "Pada akhir ronde, pulihkan [Layer]% dari Kesehatan maksimum."
  },
  State_2810_Name = {
    Text = "Pemulihan Diri"
  },
  State_2810_WeaponDesc = {
    Text = "Pada akhir giliran monster, pulihkan [Layer] % maksimum Hidup."
  },
  State_2811_Desc = {
    Text = "Saat mendapatkan Kartu Gejala, peroleh [Arg1] poin Kekuatan. Untuk setiap 1 Orison terkutuk atau Relik terkutuk yang kamu miliki, Crit. Rate dan Crit. DMG meningkat sebesar 10%."
  },
  State_2812_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_2812_Name = {Text = "Not Roused"},
  State_2813_Desc = {
    Text = "Kehilangan Aritmetika saat giliran dimulai"
  },
  State_2813_Name = {
    Text = "Kesalahan perhitungan!"
  },
  State_2814_Desc = {
    Text = "Orison yang diperoleh saat kemenangan pertempuran berubah menjadi kutukan orison yang kuat dan berbahaya."
  },
  State_2817_Desc = {
    Text = "Setiap lapisan mengurangi kerusakan yang diterima sebesar [StateArg1], dan setiap kali terkena serangan kritis, jumlah lapisan berkurang 1."
  },
  State_2817_Name = {
    Text = "Baju besi lilin"
  },
  State_2817_WeaponDesc = {
    Text = "Kekebalan terhadap negara abnormal, dihilangkan setelah menerima serangan kritis."
  },
  State_2818_Desc = {
    Text = "Terpecah menjadi Pelarutan Segitiga Kecil dan Pelarutan Segitiga Kecil B."
  },
  State_2818_Name = {Text = "Terbelah"},
  State_2818_WeaponDesc = {
    Text = "Terpecah menjadi Pelarutan Segitiga Kecil dan Pelarutan Segitiga Kecil B."
  },
  State_2820_Desc = {
    Text = "Setelah digunakan, dapatkan [StateArg1] poin Kekuatan sementara. Kartu Orison ini juga dapat menikmati peningkatan Kekuatan."
  },
  State_2820_Name = {
    Text = "<Rune_15:Ledakan>"
  },
  State_2821_Name = {
    Text = "Kekebalan Sementara terhadap Rentan"
  },
  State_2823_Desc = {
    Text = "Tim Unik: Pada saat pertarungan Mulai, berikan 2 tumpukan <VulnerabilityIconKeywords:Vulnerable> kepada musuh baris depan. Pada saat giliran Mulai, musuh yang berada dalam Negara Vulnerable kehilangan Temporary <PowerIconKeywords:Strength> sebesar <WeaponEffect_Num:[StateArg1]%> ATK Pemakai. Jika Realm saat ini adalah \"Caro\", Setelah Pemakai Lepaskan \"Exalt\", Embryo Fusion +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2823_WeaponDesc = {
    Text = "Saat pertempuran dimulai, berikan 2 tumpukan <VulnerabilityIconKeywords:Vulnerable> pada musuh di barisan depan. Saat giliran dimulai, musuh yang berada dalam status Vulnerable kehilangan <WeaponEffect_Num:[Power:DescArg1]> poin Temporary <PowerIconKeywords:Strength>. Jika Realm saat ini adalah \"Caro\", setelah Pemakai melepaskan \"Exalt\", Embryo Fusion +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2825_Desc = {
    Text = "Batas Maksimal Slot Kartu Monster Ultra"
  },
  State_2825_Name = {
    Text = "Batas Maksimal Slot Kartu Monster Ultra"
  },
  State_2825_WeaponDesc = {
    Text = "Batas Maksimal Slot Kartu Monster Ultra"
  },
  State_2826_Desc = {
    Text = "Ketika 2 kali berturut-turut memainkan Kartu dengan Lelah Aritmetika lebih rendah daripada kartu sebelumnya, Pembangun dengan Aliemus terendah saat ini mendapatkan 50 Aliemus."
  },
  State_2826_Name = {
    Text = "Relik Arkana Penciptaan"
  },
  State_2827_Desc = {
    Text = "Jumlah serangan dan peningkatan kerusakan."
  },
  State_2827_Name = {
    Text = "<CardKeyWord:Peningkatan>"
  },
  State_2829_Desc = {
    Text = "Ketika menyebabkan kerusakan nyata, dapatkan [Layer] poin kekuatan."
  },
  State_2829_Name = {
    Text = "\"Kepribadian Kacau\""
  },
  State_2830_Desc = {
    Text = "Untuk setiap [Aequor] Pembangun di tim, Kesehatan maksimum (belum selesai), Pertahanan, dan Serangan seluruh tim meningkat sebesar 50%."
  },
  State_2830_Name = {
    Text = "Aequor Bonus"
  },
  State_2830_WeaponDesc = {
    Text = "Untuk setiap [Aequor] Pembangun di tim, Kesehatan maksimum (belum selesai), Pertahanan, dan Serangan seluruh tim meningkat sebesar 50%."
  },
  State_2832_Desc = {
    Text = "Kerusakan, perisai, dan sembuh yang dilakukan oleh pengguna meningkat [StateArg1]%。（Sementara）"
  },
  State_2832_Name = {
    Text = "Negara@Prototipe Laser Meriam Kematian"
  },
  State_2833_Desc = {
    Text = "Pada awal giliran, tarik 1 kartu. Setiap kali kamu menarik 1 kartu, ubah secara acak Lelah Aritmetikanya (0-4)."
  },
  State_2835_Desc = {
    Text = "Setiap kali melakukan 1 kali melahap, curi [Arg1] kekuatan sementara dari semua musuh."
  },
  State_2836_Name = {
    Text = "Negara@Kutukan Buta Patuh"
  },
  State_2837_Name = {
    Text = "Negara@Kutukan Buta Patuh"
  },
  State_2838_Name = {
    Text = "Negara@Kutukan Buta Patuh"
  },
  State_2840_Desc = {
    Text = "Setelah ronde berakhir, menerima [Layer] poin <FixedDamage:Kerusakan Murni> dan menghapus [DescArg1]% stacks. Saat memulihkan HP, hapus stacks Bleed sebanyak dua kali jumlah HP yang dipulihkan."
  },
  State_2840_Name = {
    Text = "<BleedingColour: Berdarah>"
  },
  State_2840_WeaponDesc = {
    Text = "Setelah giliran berakhir, menerima [Layer] kerusakan dan negara ini akan dihapus, setiap sembuh dapat mengurangi setengah dari lapisan."
  },
  State_2842_Desc = {
    Text = "Setelah digunakan, mendapatkan [StateArg1] lapisan Counter, memberikan <FixedDamage:Kerusakan Murni> sebesar [StateArg2]% dari Counter kepada semua musuh."
  },
  State_2842_Name = {
    Text = "<Rune_9:Duri>"
  },
  State_2843_Desc = {
    Text = "Setiap kali tim kami memainkan 1 kartu, dapatkan [StateArg1] lapisan Perisai. Berlangsung selama 1 ronde."
  },
  State_2843_Name = {
    Text = "Bulu terbang di mana-mana"
  },
  State_2843_WeaponDesc = {
    Text = "Setiap kali tim kami memainkan 1 kartu, dapatkan [StateArg1] lapisan Perisai. Berlangsung selama 1 ronde."
  },
  State_2844_Desc = {
    Text = "Pada setiap pertempuran, saat kehilangan hidup untuk pertama kalinya, dapatkan 1 lapisan penghalang yang memberikan kekebalan terhadap satu kali kerusakan."
  },
  State_2845_Name = {
    Text = "Aksesori Tanah Pemakaman Bisikan"
  },
  State_2845_WeaponDesc = {
    Text = "Pada awal level, Ketahanan terhadap kematian meningkat sebesar 25%. Setelah Ketahanan terhadap kematian terpicu, pemakai mendapatkan 50 Aliemus."
  },
  State_2846_Desc = {
    Text = "Kebal terhadap satu kali kematian. Setelah diaktifkan, pulihkan [Arg1] Hidup dan nonaktifkan Relik ini secara permanen."
  },
  State_2846_Name = {
    Text = "Boneka Pengganti"
  },
  State_2847_Desc = {
    Text = "Setiap kali Pembangun menggunakan satu Kartu, tambahkan 1 lapis Tanda Perburuan, dan tarik jumlah Kartu sebanyak setengah dari lapis Tanda Perburuan."
  },
  State_2847_Name = {
    Text = "Ritual Perburuan"
  },
  State_2849_Desc = {
    Text = "Setiap kali kamu kehilangan Hidup, dapatkan [Arg1] poin Kekuatan, hingga bertumpuk 10 kali. Saat jumlah tumpukan penuh, pulihkan 25% dari Hidup yang hilang."
  },
  State_2849_Name = {
    Text = "Kehormatan Tertinggi"
  },
  State_2853_Desc = {
    Text = "Relik Kursi Istirahat Abadi"
  },
  State_2854_Desc = {
    Text = "Setelah kematian, tidak memberikan Aliemus kepada Pembangun."
  },
  State_2854_Name = {Text = "egois"},
  State_2854_WeaponDesc = {
    Text = "Setelah kematian, tidak memberikan Aliemus kepada Pembangun."
  },
  State_2855_Desc = {
    Text = "Kerusakan kartu serangan meningkat sebesar [StateArg1]%, berlangsung selama [Layer] putaran."
  },
  State_2855_Name = {
    Text = "Melewati kebuntuan·Strike"
  },
  State_2855_WeaponDesc = {
    Text = "Pada giliran ini, kerusakan kartu seranganmu meningkat sebesar [Layer]%."
  },
  State_2856_Desc = {
    Text = "Hanya satu di tim: Perisai yang diberikan oleh pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]％>, dan saat memberikan perisai, semua anggota tim mendapatkan <WeaponEffect_Num:[StateArg3]％> tingkat kritis sementara dan <WeaponEffect_Num:[StateArg4]％> energi-s dari isi ulang kunci perak pemakai. Efek ini paling banyak berlaku 2 kali per ronde. Jika alam saat ini adalah \"Aequor\", setiap kali ada 1 tentakel yang menyerang, pemakai mendapatkan 1 poin Aliemus, paling banyak mendapatkan <WeaponEffect_Num:[StateArg2]> poin per ronde."
  },
  State_2856_WeaponDesc = {
    Text = "Peningkatan perisai yang diberikan oleh pemakai sebesar <WeaponEffect_Num:[StateArg1]％>, dan ketika memberikan perisai, seluruh anggota tim mendapatkan <WeaponEffect_Num:[StateArg3]％> tingkat kritis sementara dan <WeaponEffect_Num:[StateArg4]％> energi-s dari isi ulang kunci perak milik pemakai. Efek ini paling banyak berlaku 2 kali per ronde. Jika alam saat ini adalah \"Aequor\", setiap kali ada 1 tentakel yang menyerang, pemakai mendapatkan 1 poin aliemus, paling banyak mendapatkan <WeaponEffect_Num:[StateArg2]> poin per ronde."
  },
  State_2857_Desc = {
    Text = "Pada awal setiap ronde, semua Pembangun mendapatkan 10 Aliemus. Kesehatan maksimum berkurang sebesar 50%."
  },
  State_2858_Name = {
    Text = "Mendapatkan dua lapis Penghalang tambahan saat digunakan"
  },
  State_2859_Desc = {
    Text = "Setelah pertempuran dimulai, kartu ini tetap berada di tangan."
  },
  State_2859_Name = {
    Text = "<CardKeyWord:Innate>"
  },
  State_2860_Desc = {
    Text = "Mengurangi 10% kesehatan maksimum saat ditarik. Setelah digunakan, meningkatkan Crit. DMG semua Pembangun sebesar 100% dalam ronde ini. Tidak dapat dijual."
  },
  State_2860_Name = {
    Text = "Negara Kutukan Pelarutan"
  },
  State_2860_WeaponDesc = {
    Text = "Mengurangi 10% kesehatan maksimum saat ditarik. Setelah digunakan, meningkatkan Crit. DMG semua Pembangun sebesar 100% dalam ronde ini. Tidak dapat dijual."
  },
  State_2861_Name = {
    Text = "(Sisa:[Layer])"
  },
  State_2862_Desc = {
    Text = "Pada akhir ronde, menerima kerusakan Racun tambahan satu kali"
  },
  State_2862_Name = {
    Text = "Kelemahan konstitusional"
  },
  State_2863_Desc = {
    Text = "Jumlah Tingkat Evolusi"
  },
  State_2863_Name = {
    Text = "Jumlah Tingkat Evolusi"
  },
  State_2863_WeaponDesc = {
    Text = "Jumlah Tingkat Evolusi"
  },
  State_2864_Desc = {
    Text = "\"24\" sudah bangun, gunakan \"tolong aku\" terakhir untuk menemukan kesempatan!"
  },
  State_2864_Name = {
    Text = "\"24\"Bangun!"
  },
  State_2864_WeaponDesc = {
    Text = "Pada ronde berikutnya, dapatkan perisai sejumlah kehilangan hidup dari ronde sebelumnya."
  },
  State_2866_Desc = {
    Text = "Tim Unik: Hand Limit +2, pada akhir ronde, dapatkan Keyflare yang setara dengan <WeaponEffect_Num:[StateArg1]%> Keyflare Regen pemakai. Setiap kali melepaskan Posse, semua Tubuh Terjaga mendapatkan <WeaponEffect_Num:[StateArg2]> poin Aliemus, jika Realm saat ini adalah \"Caro\", juga akan meningkatkan Embryo Fusion sebesar <WeaponEffect_Num:+[Blood:StateArg3]> ."
  },
  State_2866_WeaponDesc = {
    Text = "Maximum Hand Size +2, pada akhir ronde mendapatkan <WeaponEffect_Num:[DescArg1]> poin Keyflare. Setiap kali melepaskan Posse, semua Awakener mendapatkan <WeaponEffect_Num:[StateArg2]> poin Aliemus, jika Realm saat ini adalah \"Caro\", juga akan membuat Embryo Fusion <WeaponEffect_Num:+[Blood:StateArg3]> ."
  },
  State_2868_Desc = {
    Text = "Pada akhir ronde, untuk setiap 1 Kartu yang belum dimainkan di tangan, berikan 2 Aliemus kepada semua Pembangun."
  },
  State_2871_Desc = {
    Text = "Memanggil 1 segitiga pelarutan dengan jumlah hidup yang sama ketika hidup di bawah 50% ([StateArg1])"
  },
  State_2871_Name = {Text = "Memanggil"},
  State_2871_WeaponDesc = {
    Text = "Memanggil 1 segitiga pelarutan dengan jumlah hidup yang sama ketika hidup di bawah 50% ([StateArg1])"
  },
  State_2874_Desc = {
    Text = "Pembangun sedang diamati oleh Pemburu Tengkorak, menggunakan Kartunya dapat menarik 2 kartu tambahan."
  },
  State_2875_Desc = {
    Text = "Setelah digunakan, Fusi Embrio meningkat +[StateArg1]."
  },
  State_2875_Name = {
    Text = "<Rune_12_High:Darah Tinggi>"
  },
  State_2875_WeaponDesc = {
    Text = "Setelah dimainkan, Embryo Fusion+ [Blood:StateArg1]."
  },
  State_2876_Desc = {
    Text = "Setelah pertempuran, dapatkan tambahan 50 segil hitam dan 1 kartu gejala."
  },
  State_2877_Desc = {
    Text = "Nyonya Merah mendapatkan [StateArg2] Kekuatan sementara setiap kali dia menyebabkan 1 Kerusakan."
  },
  State_2877_Name = {
    Text = "Tuan yang diistimewakan"
  },
  State_2878_Desc = {
    Text = "Jumlah serangan meningkat 1, tetapi kerusakan berkurang sebesar 25%."
  },
  State_2878_Name = {Text = "Kegilaan"},
  State_2878_WeaponDesc = {
    Text = "Jumlah serangan meningkat 1, tetapi kerusakan berkurang sebesar 25%."
  },
  State_2879_Name = {
    Text = "Slime Manis"
  },
  State_2879_WeaponDesc = {
    Text = "Setelah menggunakan \"pembantaian\", jika dalam posisi lautan tenang pada giliran ini, efek perisai dan sembuh dari pemakai pada giliran ini meningkat 30%."
  },
  State_2880_Name = {
    Text = "Negara@Utusan Laut Mencerahkan7"
  },
  State_2881_Desc = {
    Text = "Setiap kali 1 kartu \"Sakramen\" diubah menjadi \"Kegilaan\", kerusakan dasar yang diberikan oleh Miryam dalam pertempuran ini meningkat sebesar 15%."
  },
  State_2881_Name = {
    Text = "Ilusi berantakan"
  },
  State_2883_Desc = {
    Text = "Tim Unik: Setelah Pemakai memberikan Active DMG, ada peluang <WeaponEffect_Num:[StateArg1]%> untuk Draw 1 Kartu perintah milik Pemakai dan menurunkan Arithmetica Cost-nya sebesar 1. Efek ini hanya berlaku 1 kali per ronde."
  },
  State_2883_WeaponDesc = {
    Text = "Setelah Pemakai memberikan Active DMG, ada peluang <WeaponEffect_Num:[StateArg1]%> untuk Draw 1 Kartu perintah milik Pemakai dan menurunkan Arithmetica Cost-nya sebesar 1. Efek ini hanya berlaku 1 kali per ronde."
  },
  State_2884_Name = {
    Text = "Kerusakan yang ditimbulkan adalah <PunctureDamagewords:Kerusakan Tembus>. Mengurangi Lelah sebesar 1 pada 1 kartu dengan Aritmetika tertinggi di tangan."
  },
  State_2885_Name = {
    Text = "Negara@Setelah putaran dimulai, tambahkan 2 kartu yang ditarik menjadi Menggambar"
  },
  State_2887_Desc = {
    Text = "Satu-satunya di tim: Setelah pemakai melepaskan Muliakan, Crit. DMG mereka meningkat sebesar <WeaponEffect_Num:[StateArg1]%> di ronde ini, dan semua Kartu dari para pemakai memiliki peluang sebesar <WeaponEffect_Num:[StateArg2]%> untuk mengurangi Lelah Aritmetika sebesar 1 poin di ronde ini."
  },
  State_2887_WeaponDesc = {
    Text = "Setelah pemegang melepaskan Aliemus Muliakan, Crit. DMG mereka meningkat sebesar <WeaponEffect_Num:[StateArg1]%> di ronde ini, dan semua kartu dari setiap pemegang memiliki peluang sebesar <WeaponEffect_Num:[StateArg2]%> untuk mengurangi konsumsi aritmetika sebesar 1 poin di ronde ini."
  },
  State_2888_Desc = {
    Text = "Jika terdapat \"Embrio\"di tangan, lelah 1 kartu dan aktifkan efek berikutnya."
  },
  State_2888_Name = {
    Text = "<DevouredIconKeywords:Melahap>"
  },
  State_2888_WeaponDesc = {
    Text = "Menghabiskan embrio di tangan lelah, memicu efek melahap yang kuat."
  },
  State_2889_Name = {
    Text = "Pilih satu Pembangun untuk mendapatkan <Energy:[DescArg1]> poin Aliemus."
  },
  State_2890_Desc = {
    Text = "Pada awal pertempuran, tim kami mendapat 1 lapisan rapuh."
  },
  State_2890_Name = {
    Text = "Penetrasi Baju Besi"
  },
  State_2890_WeaponDesc = {
    Text = "Pada awal pertempuran, tim kami mendapat 1 lapisan rapuh."
  },
  State_2891_Name = {
    Text = "Peningkatan Pemulihan Pembukaan Aliemus"
  },
  State_2892_Desc = {
    Text = "Pada akhir ronde, pulihkan [Layer] poin Hidup."
  },
  State_2892_Name = {
    Text = "Pemulihan Hidup Tertunda"
  },
  State_2892_WeaponDesc = {
    Text = "Hingga akhir ronde, setiap kali membunuh, pulihkan [Layer] poin Hidup."
  },
  State_2897_Desc = {
    Text = "Saat Genesis Kedatangan dilepaskan, kekuatan sementara musuh berkurang."
  },
  State_2897_Name = {
    Text = "Takut akan Aliemus"
  },
  State_2899_Desc = {
    Text = "Jika jumlah kartu tangan lawan lebih besar atau sama dengan 4, saat menerima kerusakan, dapatkan [StateArg1] poin perisai."
  },
  State_2899_Name = {
    Text = "Bentuk Ular"
  },
  State_2900_Desc = {
    Text = "Kerusakan yang diberikan dalam pertempuran ini meningkat sebesar [Layer] poin."
  },
  State_2900_Name = {Text = "Kekuatan"},
  State_2900_WeaponDesc = {
    Text = "Kerusakan yang diberikan dalam pertempuran ini meningkat sebesar [Layer] poin."
  },
  State_2901_Desc = {
    Text = "[Muliakan] memberikan 20 poin Aliemus pada diri sendiri."
  },
  State_2901_Name = {
    Text = "Relik Sang Pencipta Tanpa Nama"
  },
  State_2901_WeaponDesc = {
    Text = "[Muliakan] memberikan 20 poin Aliemus pada diri sendiri."
  },
  State_2902_Desc = {
    Text = "Otak dalam toples mengembalikan dua kali lipat Hidup."
  },
  State_2902_Name = {
    Text = "Sensibilitas terputus"
  },
  State_2902_WeaponDesc = {
    Text = "Otak dalam toples mengembalikan dua kali lipat Hidup."
  },
  State_2903_Desc = {
    Text = "Kerusakan, perisai, dan sembuh yang dilakukan oleh pengguna meningkat [StateArg1]%。（Sementara）"
  },
  State_2903_Name = {
    Text = "Negara@Prototipe Pisau Kritis"
  },
  State_2904_Desc = {
    Text = "Setelah menerima kerusakan aktual, peroleh 10 Perisai."
  },
  State_2904_Name = {Text = "buffer"},
  State_2904_WeaponDesc = {
    Text = "Setelah menerima kerusakan aktual, peroleh 10 Perisai."
  },
  State_2905_Desc = {
    Text = "Satu-satunya di tim: Perisai yang dihasilkan oleh \"Muliakan\" dari pemakai meningkat sebesar <WeaponEffect_Num:[StateArg2]%>. Setelah pemakai melepaskan \"Muliakan\", mereka mendapatkan jumlah lapisan sementara <PowerIconKeywords:Kekuatan> yang setara dengan <WeaponEffect_Num:[StateArg1]%> dari daya pertahanan pemakai. Jika tim kami berada dalam kondisi <FragileIconKeywords:Rapuh>, efeknya dilipatgandakan."
  },
  State_2905_WeaponDesc = {
    Text = "Perisai yang diciptakan oleh pemakai \"Muliakan\" meningkat sebesar <WeaponEffect_Num:[StateArg2]%>. Setelah pemakai melepaskan \"Muliakan\", mereka mendapatkan [Power:DescArg1] poin <PowerIconKeywords:Kekuatan> sementara. Jika tim kita berada dalam keadaan <FragileIconKeywords:Rapuh>, efeknya dilipatgandakan."
  },
  State_2906_Desc = {
    Text = "Setelah memberikan kerusakan nyata, kekuatan tim kami akan berkurang sementara sebesar [Layer] poin."
  },
  State_2906_Name = {
    Text = "Kelumpuhan listrik"
  },
  State_2909_Desc = {
    Text = "Memiliki [Layer] poin Aliemus. Jika Aliemus lebih dari atau sama dengan 5, Niat berubah menjadi \"Pesta dengan yang mati bengkok\", setelah Aliemus berkurang akan kembali normal."
  },
  State_2909_Name = {
    Text = "Negara@monster24 Hitung Pesta dengan yang mati bengkok"
  },
  State_2909_WeaponDesc = {
    Text = "Memiliki [Layer] poin Aliemus. Jika Aliemus lebih dari atau sama dengan 5, Niat berubah menjadi \"Pesta dengan yang mati bengkok\", setelah Aliemus berkurang akan kembali normal."
  },
  State_2910_Desc = {
    Text = "Satu-satunya Tim: Saat eksplorasi dimulai, tambahkan satu kartu \"Inspirasi\" dan \"Pukulan\" pemilik ke dek. Kerusakan dasar \"Pukulan\" pemilik meningkat sebesar <WeaponEffect_Num:[StateArg1]%>, setelah digunakan ada kemungkinan <WeaponEffect_Num:[StateArg2]%> untuk menarik 1 kartu. Efek ini hanya dapat dipicu maksimal 1 kali per ronde. Jika alam saat ini adalah \"Ultra\" dan berada di ronde Ultra, \"Pukulan\" akan menempatkan satu kartu \"Inspirasi\" ke tangan, efek ini hanya dapat dipicu maksimal 1 kali dalam ronde tersebut."
  },
  State_2910_WeaponDesc = {
    Text = "Saat eksplorasi dimulai, tambahkan satu kartu \"Inspirasi\" dan \"Serangan\" pemakai ke dalam dek. Kerusakan dasar \"Serangan\" pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>, dan setelah digunakan, ada kemungkinan <WeaponEffect_Num:[StateArg2]%> untuk menarik 1 kartu. Efek ini dapat dipicu maksimal 1 kali per ronde. Jika alam saat ini adalah \"Ultra\" dan berada di ronde Ultra, \"Serangan\" akan menempatkan 1 kartu \"Inspirasi\" ke tangan, dengan batas maksimal 1 kali per ronde."
  },
  State_2911_Desc = {
    Text = "Negara@Dunia Khayalan Putih Murni Ubah Penghitungan"
  },
  State_2911_Name = {
    Text = "Negara@Dunia Khayalan Putih Murni Penghitung"
  },
  State_2911_WeaponDesc = {
    Text = "Negara@Dunia Khayalan Putih Murni Ubah Penghitungan"
  },
  State_2912_Desc = {
    Text = "Kamu terkunci! Setelah menyerang, Pengawal Pelaut mendapatkan [StateArg1] poin Kekuatan sementara, dan tanda penyelaman dalam dari instruksi ini dihapus."
  },
  State_2912_Name = {
    Text = "<CardKeyWord:Tanda Penyelaman Dalam>"
  },
  State_2912_WeaponDesc = {
    Text = "Setelah kartu dimainkan, Pengawal Pribadi Penyelam Dalam mendapatkan [StateArg1] poin Kekuatan sementara."
  },
  State_2913_Desc = {
    Text = "Pada awal pertempuran, rapuh selama 3 ronde."
  },
  State_2913_Name = {
    Text = "Relik Cakar Ganjil 2"
  },
  State_2913_WeaponDesc = {
    Text = "Pada awal pertempuran, rapuh selama 3 ronde."
  },
  State_2914_Desc = {
    Text = "Ketika Hidup di bawah 50%, Niat berubah menjadi Memanggil [Pelarutan Segitiga Tengah] dengan jumlah Hidup yang sama."
  },
  State_2914_Name = {Text = "Fisi"},
  State_2914_WeaponDesc = {
    Text = "Ketika Hidup di bawah 50%, Niat berubah menjadi Memanggil [Pelarutan Segitiga Tengah] dengan jumlah Hidup yang sama."
  },
  State_2915_Desc = {
    Text = "Meningkatkan jumlah kerusakan \"Rantai kebencian\" sebanyak +[Layer] kali."
  },
  State_2915_Name = {Text = "Kebencian"},
  State_2915_WeaponDesc = {
    Text = "Meningkatkan jumlah kerusakan \"Rantai kebencian\" sebanyak +[Layer] kali."
  },
  State_2917_Desc = {
    Text = "Pada akhir ronde, untuk setiap 1 kartu tangan yang tersisa, dapatkan 1 Aritmetika di awal ronde berikutnya."
  },
  State_2917_Name = {
    Text = "Negara@Kunci Perak: Kalkulasi"
  },
  State_2918_Desc = {
    Text = "Kerusakan yang diterima berkurang sebesar 99%. Setelah menerima kerusakan aktif, 1 lapisan akan dihilangkan. Pada awal giliran, jumlah lapisan akan dipulihkan menjadi 3."
  },
  State_2918_Name = {
    Text = "\"Tubuh Abadi\""
  },
  State_2918_WeaponDesc = {
    Text = "Kerusakan yang diterima berkurang sebesar 99%. Setelah menerima kerusakan aktif, 1 lapisan akan dihilangkan. Pada awal giliran, jumlah lapisan akan dipulihkan menjadi 3."
  },
  State_2919_Desc = {
    Text = "Negara@Jade Api Zamrud Pemetaan Awal"
  },
  State_2919_Name = {
    Text = "Negara@Jade Api Zamrud Pemetaan Awal"
  },
  State_2919_WeaponDesc = {
    Text = "Negara@Jade Api Zamrud Pemetaan Awal"
  },
  State_2922_Desc = {
    Text = "Setiap Lelah 1 poin Aritmetika, berikan 2 poin Aliemus kepada Pembangun yang sesuai."
  },
  State_2923_Desc = {
    Text = "Pada akhir ronde, Kekuatan meningkat sebesar [Layer]."
  },
  State_2923_Name = {
    Text = "Ritual Penurunan Dewa"
  },
  State_2923_WeaponDesc = {
    Text = "Pada akhir setiap ronde, dapatkan [Layer] poin Kekuatan."
  },
  State_2925_Desc = {
    Text = "Api Hijau setiap kali memberikan kerusakan, jumlah lapisan +1"
  },
  State_2925_Name = {
    Text = "Penghitungan Bayangan Giok"
  },
  State_2925_WeaponDesc = {
    Text = "Api Hijau setiap kali memberikan kerusakan, jumlah lapisan +1"
  },
  State_2927_Name = {
    Text = "Negara@Kutukan Delirium Perubahan"
  },
  State_2929_Desc = {
    Text = "Tim Unik: Setiap kali Pemakai menimbulkan 1 kali Kerusakan, ada kemungkinan <WeaponEffect_Num:[StateArg3]%> membuat Pemakai mendapatkan 2% Kerusakan Kritis Sementara. Setelah Pemakai melepaskan Exalt, menimbulkan 3 kali Active DMG setara <WeaponEffect_Num:[StateArg1]%> ATK Pemakai kepada musuh acak. Jika Realm saat ini adalah \"Caro\", setiap kali Pemakai Devour satu Embryo, maka Embryo Fusion +<WeaponEffect_Num:[Blood:StateArg2]> ."
  },
  State_2929_WeaponDesc = {
    Text = "Setiap kali Pemakai menimbulkan 1 kali Kerusakan, ada kemungkinan <WeaponEffect_Num:[StateArg3]%> membuat Pemakai mendapatkan 2% Kerusakan Kritis Sementara. Setelah Pemakai melepaskan Exalt, menimbulkan 3 kali [DescArg1] poin Active DMG kepada musuh acak. Jika Realm saat ini adalah \"Caro\", setiap kali Pemakai Devour satu Embryo, maka Embryo Fusion +<WeaponEffect_Num:[Blood:StateArg2]> ."
  },
  State_2930_Name = {
    Text = "Negara@George@Mendapatkan Kekuatan Saat Mati"
  },
  State_2931_Desc = {
    Text = "Setiap kali melakukan 1 kali melahap, curi 4 Kekuatan sementara dari semua musuh."
  },
  State_2931_Name = {
    Text = "Alien Silk Agate"
  },
  State_2933_Name = {
    Text = "Aksesori Kembar Terdistorsi Putih"
  },
  State_2933_WeaponDesc = {
    Text = "Setelah ronde genap dimulai, tambahkan satu kartu \"Pertahanan\" pemakai dengan efek Ilusi dan Lelah ke tangan."
  },
  State_2934_Desc = {
    Text = "Active DMG dan Kerusakan tentakel yang diterima meningkat [DescArg1] %."
  },
  State_2934_Name = {
    Text = "<VulnerabilityColour: Rentan>"
  },
  State_2934_WeaponDesc = {
    Text = "Semua kerusakan yang diterima meningkat sebesar 50%."
  },
  State_2937_Desc = {
    Text = "Setiap kali mendapatkan Perisai pada kesempatan ke-3, secara bersamaan mendapatkan Counter dalam jumlah yang sama."
  },
  State_2938_Desc = {
    Text = "Pada awal ronde, tarik 1 kartu. Pada akhir ronde, pemain dapat memilih untuk menyimpan 1 kartu di tangan."
  },
  State_2939_Name = {
    Text = "Imun terhadap kerapuhan"
  },
  State_2940_Desc = {
    Text = "Efek regenerasi meningkat."
  },
  State_2940_Name = {
    Text = "Menanggung Darah Penyimpangan yang Semakin Kuat"
  },
  State_2941_Desc = {
    Text = "Setelah digunakan, semua musuh akan menerima [StateArg1] lapisan Racun, menyebabkan semua musuh memicu [StateArg2]% Racun."
  },
  State_2941_Name = {
    Text = "<Rune_10:Racun>"
  },
  State_2942_Desc = {
    Text = "Pada akhir ronde, pulihkan [Layer]% hidup untuk sekutu lainnya dan hapus kerusakan berkelanjutan."
  },
  State_2942_Name = {
    Text = "Bantuan medis di medan perang"
  },
  State_2946_Desc = {
    Text = "Kegilaan combo memberikan perisai dalam jumlah yang sangat besar."
  },
  State_2946_Name = {
    Text = "\"Benteng Diam\""
  },
  State_2946_WeaponDesc = {
    Text = "Kegilaan combo memberikan perisai dalam jumlah yang sangat besar."
  },
  State_2947_Name = {Text = "Larutan 2"},
  State_2948_Desc = {
    Text = "Mengubah aritmetika kartu sebelum bermain"
  },
  State_2948_Name = {
    Text = "Mengubah aritmetika kartu sebelum bermain"
  },
  State_2948_WeaponDesc = {
    Text = "Mengubah aritmetika kartu sebelum bermain"
  },
  State_2949_Name = {
    Text = "Pertempuran Roda Takdir: Abaikan Orison"
  },
  State_2951_Desc = {
    Text = "Relik Kursi Istirahat Abadi"
  },
  State_2951_Name = {
    Text = "Sarung Tangan Pembungkam"
  },
  State_2952_Desc = {
    Text = "Setelah giliran berakhir, pulihkan [Layer] poin Hidup. Saat kehilangan 5 poin Hidup, hapus 1 lapisan."
  },
  State_2952_Name = {
    Text = "Kekuatan Regenerasi"
  },
  State_2954_Name = {
    Text = "Negara@2-8 Monster24@Tolong aku"
  },
  State_2955_Desc = {
    Text = "Semua musuh kehilangan Hidup. Permanen, hancur."
  },
  State_2955_Name = {
    Text = "<CardKeyWord:Ilusi Akhir>"
  },
  State_2955_WeaponDesc = {
    Text = "Semua musuh kehilangan Hidup. Permanen, hancur."
  },
  State_2956_Desc = {
    Text = "Setiap kali menerima kerusakan, semua Pembangun mendapatkan [StateArg1] poin Aliemus."
  },
  State_2956_Name = {
    Text = "Sinar Fantasi"
  },
  State_2956_WeaponDesc = {
    Text = "Setiap kali menerima kerusakan, semua Pembangun mendapatkan [StateArg1] poin Aliemus."
  },
  State_2957_Desc = {
    Text = "Setelah kematian, memanggil [Pelarutan Segitiga] dengan 1/3 dari nilai hidup sendiri di tempat."
  },
  State_2957_Name = {Text = "Pelarutan"},
  State_2957_WeaponDesc = {
    Text = "Setelah kematian, memanggil [Pelarutan Segitiga] dengan 1/3 dari nilai hidup sendiri di tempat."
  },
  State_2960_Desc = {
    Text = "Pada giliran genap, ketika Aritmetika kamu adalah 0, dapatkan 2 Aritmetika."
  },
  State_2960_Name = {
    Text = "Puzzle tua yang terasing"
  },
  State_2960_WeaponDesc = {
    Text = "Pada giliran genap, ketika Aritmetika kamu adalah 0, dapatkan 2 Aritmetika."
  },
  State_2961_Desc = {
    Text = "Tim Unik: Peningkatan <IntoxicationIconKeywords:Racun> yang diberikan oleh pemakai sebesar <WeaponEffect_Num:[StateArg1]%, sebelum pemakai melepaskan Exalt, pertama-tama mengenakan Racun yang setara dengan ATK pemakai sebesar <WeaponEffect_Num:[StateArg2]>. Setelah menggunakan Posse, pemakai mendapatkan <WeaponEffect_Num:[StateArg3]> poin Aliemus."
  },
  State_2961_WeaponDesc = {
    Text = "Peningkatan <IntoxicationIconKeywords:Racun> yang diberikan oleh pemakai sebesar <WeaponEffect_Num:[StateArg1]%, sebelum pemakai melepaskan Exalt, pertama-tama mengenakan <WeaponEffect_Num:[Poison:DescArg1]> lapisan Racun pada semua musuh. Setelah menggunakan Posse, pemakai mendapatkan <WeaponEffect_Num:[StateArg3]> poin Aliemus."
  },
  State_2962_Desc = {
    Text = "Setelah digunakan, semua musuh akan mengalami Kelemahan selama [StateArg1] putaran."
  },
  State_2962_Name = {
    Text = "<Rune_2:Kelemahan>"
  },
  State_2965_Name = {
    Text = "Negara@Cembung Bulan Pelayan Mencerahkan7"
  },
  State_2967_Desc = {
    Text = "Saat menggunakan Kartu gejala, Negara Pandya akan berubah antara \"Gelisah\" dan \"Nafsu\". Gelisah: Jumlah Active DMG yang ditimbulkan +1, Kekuatan berkurang. Nafsu: Jumlah Active DMG yang ditimbulkan -1, Kekuatan bertambah."
  },
  State_2967_Name = {
    Text = "Pandia bangun!"
  },
  State_2967_WeaponDesc = {
    Text = "Pada ronde berikutnya, dapatkan perisai sejumlah kehilangan hidup dari ronde sebelumnya."
  },
  State_2968_Name = {
    Text = "Negara@Tingkat2_14Pertempuran8Gelembung4"
  },
  State_2969_Name = {
    Text = "Negara@Level2_14Pertempuran8Gelembung5"
  },
  State_2970_Desc = {
    Text = "Keturunan Primal"
  },
  State_2970_Name = {
    Text = "Keturunan Primal"
  },
  State_2970_WeaponDesc = {
    Text = "Keturunan Primal"
  },
  State_2971_Desc = {
    Text = "Negara@Prolog kehilangan setengah darah"
  },
  State_2971_Name = {
    Text = "Negara@Prolog kehilangan setengah darah"
  },
  State_2971_WeaponDesc = {
    Text = "Negara@Prolog kehilangan setengah darah"
  },
  State_2972_Name = {
    Text = "Negara@Level2_14_Pertempuran8_Gelembung2"
  },
  State_2973_Name = {
    Text = "Negara@Level2_14Pertempuran8Gelembung3"
  },
  State_2975_Desc = {
    Text = "Efek dari 5 lompatan pertama dalam setiap pertempuran akan berlaku tambahan 1 kali."
  },
  State_2976_Desc = {
    Text = "Pada akhir ronde, jika perisaimu adalah 0 atau kelipatan 10, dapatkan [Arg1] poin perisai. Jika hidupmu adalah kelipatan 10, dapatkan [Arg2] poin kekuatan."
  },
  State_2976_Name = {
    Text = "Sinyal Darurat"
  },
  State_2977_Desc = {
    Text = "Pada giliran ganjil, jika jumlah kartu di tanganmu adalah 0, tarik 2 kartu."
  },
  State_2977_Name = {
    Text = "Puzzle tua yang terasing"
  },
  State_2977_WeaponDesc = {
    Text = "Pada giliran ganjil, jika jumlah kartu di tanganmu adalah 0, tarik 2 kartu."
  },
  State_2978_Desc = {
    Text = "Setiap kali menerima 1 poin Kerusakan, jumlah lapisan berkurang 1. Setelah jumlah lapisan menjadi 0, beralih ke Mode Pertahanan."
  },
  State_2978_Name = {
    Text = "Penghitungan Kartu"
  },
  State_2978_WeaponDesc = {
    Text = "Setiap kali menerima 1 poin Kerusakan, jumlah lapisan berkurang 1. Setelah jumlah lapisan menjadi 0, beralih ke Mode Pertahanan."
  },
  State_2979_Desc = {
    Text = "Satu-satunya di tim: Peningkatan kerusakan racun dan perisai yang diberikan oleh pemakai sebesar <WeaponEffect_Num:[StateArg3]%>. Tingkat kritis dan kerusakan kritis \"Pukulan\" pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>, dan memperoleh perisai sebesar <WeaponEffect_Num:[StateArg2]%> dari kesehatan maksimum, efek perisai paling banyak aktif sekali per ronde."
  },
  State_2979_Name = {
    Text = "Anugerah Lewat Penderitaan"
  },
  State_2979_WeaponDesc = {
    Text = "Pengguna peralatan meningkatkan efek racun dan perisai sebesar <WeaponEffect_Num:[StateArg3]%>. Tingkat kritis dan kerusakan kritis dari serangan \"Pukulan\" pengguna peralatan meningkat sebesar <WeaponEffect_Num:[StateArg1]%>, serta memperoleh perisai sebesar [StateArg2]%([DescArg1]) dari kesehatan maksimum. Efek perisai paling banyak aktif sekali per putaran."
  },
  State_2983_Desc = {
    Text = "Jika kartu masih berada di tangan saat fase pembuangan, kartu akan menjadi lelah dan tidak akan muncul lagi dalam pertempuran ini."
  },
  State_2983_Name = {
    Text = "<NothingnessIconKeywords:Ilusi>"
  },
  State_2983_WeaponDesc = {
    Text = "Jika kartu masih berada di tangan saat fase pembuangan, kartu tersebut tidak akan masuk ke tumpukan kartu buang, melainkan tidak dapat digunakan kembali dalam pertempuran ini."
  },
  State_2985_Desc = {
    Text = "Hingga akhir ronde, setiap kali memberikan kerusakan, pada akhir ronde pulihkan [Layer] poin hidup."
  },
  State_2985_Name = {
    Text = "Berlian kasar"
  },
  State_2985_WeaponDesc = {
    Text = "Hingga akhir ronde, setiap kali memberikan kerusakan, pulihkan [Layer] poin hidup."
  },
  State_2987_Desc = {Text = "Acara19_1"},
  State_2987_Name = {Text = "Acara19_1"},
  State_2987_WeaponDesc = {Text = "Acara19_1"},
  State_2988_Desc = {
    Text = "Ketika melahap embrio, kembalikan dari tumpukan kartu buang ke tumpukan kartu tangan, dan aritmetika menjadi 0."
  },
  State_2988_Name = {
    Text = "Malefic Offspring"
  },
  State_2988_WeaponDesc = {
    Text = "Ketika melahap embrio, kembalikan dari tumpukan kartu buang ke tumpukan kartu tangan, dan aritmetika menjadi 0."
  },
  State_2989_Desc = {
    Text = "Setelah mengeluarkan kartu Pembangun, salinan sementara dari kartu tersebut dengan biaya dikurangi 1 akan dicampurkan ke dalam dek."
  },
  State_2990_Desc = {
    Text = "Setelah digunakan, semua musuh kehilangan [StateArg1] poin Kekuatan sementara."
  },
  State_2990_Name = {
    Text = "<Rune_18_High:Keletihan Tinggi>"
  },
  State_2992_Desc = {
    Text = "Setelah menggambar \"Kekosongan\", kurangi 50% Aliemus yang diperoleh oleh semua Pembangun dalam ronde ini."
  },
  State_2992_Name = {Text = "Void"},
  State_2992_WeaponDesc = {
    Text = "Setelah menggambar \"Kekosongan\", kurangi 50% Aliemus yang diperoleh oleh semua Pembangun dalam ronde ini."
  },
  State_2993_Name = {
    Text = "Relik Ular Sisa: Hitung"
  },
  State_2994_Desc = {
    Text = "Ketika tentakel penuh, kerusakan tentakel meningkat sebesar [StateArg1]."
  },
  State_2994_Name = {
    Text = "Kekuatan Penjagaan"
  },
  State_2994_WeaponDesc = {
    Text = "Ketika tentakel penuh, kerusakan tentakel meningkat sebesar [StateArg1]."
  },
  State_2996_Desc = {
    Text = "Setelah digunakan, 1 tentakel akan melakukan serangan sebanyak [StateArg1] kali."
  },
  State_2996_Name = {
    Text = "<Rune_11:Kepemimpinan>"
  },
  State_2997_Desc = {
    Text = "Setelah memberikan kerusakan ketiga kalinya per ronde, dapatkan [Arg1] poin perisai. Setelah memberikan kerusakan keenam kalinya per ronde, dapatkan [Arg2] poin kekuatan."
  },
  State_2997_Name = {
    Text = "Pintu Darurat"
  },
  State_3001_Desc = {
    Text = "Mendapatkan 2 poin Aliemus saat terkena Serangan."
  },
  State_3002_Desc = {
    Text = "Kerusakan, perisai, dan sembuh yang dilakukan oleh pengguna meningkat [StateArg1]%。（Sementara）"
  },
  State_3002_Name = {
    Text = "Negara@Prototipe Laser Keberuntungan"
  },
  State_3003_Desc = {
    Text = "Setelah dimainkan, kartu tidak akan masuk ke Tumpukan kartu buang, melainkan dihapus dari dek."
  },
  State_3003_Name = {
    Text = "<DepleteIconKeywords:Lelah>"
  },
  State_3003_WeaponDesc = {
    Text = "Setelah digunakan, kartu tidak akan masuk ke tumpukan kartu buang dan tidak dapat digunakan kembali selama pertempuran ini."
  },
  State_3004_Desc = {
    Text = "[Layer] Kebal terhadap negara racun yang diberikan dalam satu putaran."
  },
  State_3004_Name = {
    Text = "Kekebalan terhadap racun"
  },
  State_3008_Desc = {
    Text = "Di awal setiap putaran, tambahkan 1 lapisan lambat pada kartu yang tersisa di tangan lawan. Untuk kartu yang menghabiskan lebih dari 5 aritmetika, ubah menjadi batu."
  },
  State_3008_Name = {
    Text = "Aigis Bangun!"
  },
  State_3008_WeaponDesc = {
    Text = "Pada ronde berikutnya, dapatkan perisai sejumlah kehilangan hidup dari ronde sebelumnya."
  },
  State_3011_Desc = {
    Text = "Satu-satunya di tim: Tingkat kritis dan kerusakan kritis dari \"Muliakan\" si pemakai meningkat sebesar <WeaponEffect_Num:[StateArg2]%>. Setelah pemakai melepaskan \"Muliakan\", mereka akan memperoleh <PowerIconKeywords:Kekuatan> sebesar <WeaponEffect_Num:[StateArg1]%> dari konstitusi pemakai. Jika efek <CardKeyWord:Melahap> dipicu selama \"Muliakan\" ini, pemakai akan mendapatkan tambahan 1 kali <PowerIconKeywords:Kekuatan>."
  },
  State_3011_WeaponDesc = {
    Text = "Pengguna peralatan mendapatkan peningkatan tingkat kritis dan kerusakan kritis untuk \"Muliakan\" sebesar <WeaponEffect_Num:[StateArg2]%>. Setelah pengguna peralatan melepaskan \"Muliakan\", mereka memperoleh <WeaponEffect_Num:[Power:DescArg1]> poin Kekuatan. Jika serangan Muliakan ini memicu efek <CardKeyWord:Melahap>, pengguna akan mendapatkan tambahan 1 kali <PowerIconKeywords:Kekuatan>."
  },
  State_3012_Desc = {
    Text = "Negara kosong yang tidak berguna"
  },
  State_3012_Name = {
    Text = "Negara kosong yang tidak berguna"
  },
  State_3012_WeaponDesc = {
    Text = "Negara kosong yang tidak berguna"
  },
  State_3013_Desc = {
    Text = "Ketika haus darah pasien meningkatkan Fusi Embrio, mendapatkan [StateArg1] poin Kekuatan."
  },
  State_3013_Name = {Text = "Haus darah"},
  State_3014_Desc = {
    Text = "Jika jumlah kartu tangan lawan lebih besar atau sama dengan 4, saat menerima kerusakan, dapatkan [StateArg1] poin perisai."
  },
  State_3014_Name = {
    Text = "Bentuk Ular"
  },
  State_3015_Desc = {
    Text = "Negara@Baju Zirah Berlilin Tim Kami"
  },
  State_3015_Name = {
    Text = "Negara@Baju Zirah Berlilin Tim Kami"
  },
  State_3015_WeaponDesc = {
    Text = "Negara@Baju Zirah Berlilin Tim Kami"
  },
  State_3016_Desc = {
    Text = "Monster yang dipanggil memiliki hidup dua kali lipat."
  },
  State_3016_Name = {
    Text = "\"Rasa Bersalah dalam Arus Deras\""
  },
  State_3016_WeaponDesc = {
    Text = "Monster yang dipanggil memiliki hidup dua kali lipat."
  },
  State_3017_Name = {
    Text = "Negara@Kutukan Delirium"
  },
  State_3018_Desc = {
    Text = "\"Anjing Dimensi\"setiap kehilangan 1 poin Hidup menghilangkan 1 lapisan. Ketika jumlah lapisan menjadi 0, mendapatkan [StateArg1] Perisai dan kembali memperoleh [StateArg2] lapisan Penghalang Dimensi."
  },
  State_3018_Name = {
    Text = "Hambatan Dimensi"
  },
  State_3019_Desc = {
    Text = "Setiap konsumsi 10 Segil Hitam mengembalikan 1% Hidup."
  },
  State_3019_Name = {
    Text = "Negara Akar Terbalik Relik"
  },
  State_3019_WeaponDesc = {
    Text = "Setiap konsumsi 10 Segil Hitam mengembalikan 1% Hidup."
  },
  State_3020_Desc = {
    Text = "Jika menerima kerusakan pada ronde sebelumnya, dapatkan kekebalan selama 1 ronde di awal ronde."
  },
  State_3020_Name = {Text = "Adaptasi"},
  State_3020_WeaponDesc = {
    Text = "Jika menerima kerusakan pada ronde sebelumnya, dapatkan kekebalan selama 1 ronde di awal ronde."
  },
  State_3021_Desc = {
    Text = "Pada awal giliran, dapatkan 1 Aritmetika."
  },
  State_3021_Name = {
    Text = "Negara@Aritmetika-2"
  },
  State_3023_Desc = {
    Text = "Setiap kali menerima Active DMG pada giliran ini, berikan [Layer] poin <FixedDamage:Kerusakan Murni> kepada sumber kerusakan."
  },
  State_3023_Name = {
    Text = "Counter Sementara"
  },
  State_3023_WeaponDesc = {
    Text = "Setiap kali menerima Active DMG, berikan [Layer] poin <FixedDamage:Kerusakan Murni> kepada penyerang."
  },
  State_3024_Desc = {
    Text = "Kerusakan, perisai, dan sembuh yang dilakukan oleh pengguna meningkat [StateArg1]%。（Sementara）"
  },
  State_3024_Name = {
    Text = "Negara@Prototipe Pisau Kecil Mati Menahan"
  },
  State_3025_Desc = {
    Text = "Setiap kali memainkan 1 kartu, Crit. Rate pada ronde ini meningkat sebesar 10%."
  },
  State_3026_Desc = {
    Text = "Setelah pertempuran dimulai, akan menyalin sementara [StateArg1] Kartu ke dalam tumpukan gambar, Kartu asli dan Kartu cermin semuanya mendapatkan Menjaga."
  },
  State_3026_Name = {
    Text = "<Rune_8_High:Cermin Tinggi>"
  },
  State_3026_WeaponDesc = {
    Text = "Setelah pertempuran dimulai, [StateArg1] salinan sementara akan dimasukkan ke dalam tumpukan kartu menggambar."
  },
  State_3027_Desc = {
    Text = "Setelah pertempuran, dapatkan tambahan 50 segil hitam dan 1 kartu gejala."
  },
  State_3028_Name = {
    Text = "Negara@Setelah putaran dimulai, Aritmetika bertambah 2"
  },
  State_3029_Desc = {
    Text = "Setiap kali menerima 1 poin Kerusakan, jumlah lapisan berkurang 1. Setelah jumlah lapisan menjadi 0, beralih ke Mode Pertahanan."
  },
  State_3029_Name = {
    Text = "Penghitungan Kartu"
  },
  State_3029_WeaponDesc = {
    Text = "Setiap kali menerima 1 poin Kerusakan, jumlah lapisan berkurang 1. Setelah jumlah lapisan menjadi 0, beralih ke Mode Pertahanan."
  },
  State_3033_Desc = {
    Text = "Setiap kali kamu memainkan 10 kartu, kamu akan mendapatkan 1 lapis Penghalang yang menahan segala Kerusakan. Jika kamu sudah memiliki Penghalang, maka pulihkan [Arg1] poin Hidup."
  },
  State_3034_Desc = {
    Text = "Satu-satunya di tim: Setiap kali memainkan 1 Kartu pemilik peralatan, dapatkan <WeaponEffect_Num:[StateArg1]> Energi-s. Efek ini paling banyak berlaku 3 kali dalam satu ronde."
  },
  State_3034_WeaponDesc = {
    Text = "Setiap kali memainkan 1 Kartu pemilik peralatan, dapatkan <WeaponEffect_Num:[StateArg1]> Energi-s. Efek ini paling banyak berlaku 3 kali dalam satu ronde."
  },
  State_3035_Desc = {
    Text = "Setelah digunakan, 1 tentakel akan melakukan serangan sebanyak [StateArg1] kali."
  },
  State_3035_Name = {
    Text = "<Rune_11_High:Penguasaan Tinggi>"
  },
  State_3035_WeaponDesc = {
    Text = "Setelah digunakan, 1 Tentakel melakukan Serangan terhadap semua musuh sebanyak [StateArg1] kali."
  },
  State_30364_Desc = {
    Text = "Kartu ini akan meningkatkan batas maksimum kartu di tangan sebesar +1 saat berada di tangan."
  },
  State_30364_Name = {
    Text = "Abai batas kartu tangan"
  },
  State_30369_Desc = {
    Text = "Batas kartu tangan dalam ronde ini +[Layer]."
  },
  State_30369_Name = {
    Text = "Maximum Hand Size"
  },
  State_3036_Desc = {
    Text = "Efek Rapuh dan Kelemahan berubah dari 33% menjadi 50%."
  },
  State_3036_Name = {
    Text = "\"Gelombang Kehancuran\""
  },
  State_3036_WeaponDesc = {
    Text = "Efek Rapuh dan Kelemahan berubah dari 33% menjadi 50%."
  },
  State_3038_Desc = {
    Text = "Satu-satunya di tim: Setelah melepaskan Geng, pemakai mendapatkan <WeaponEffect_Num:[StateArg1]> Aliemus."
  },
  State_3038_WeaponDesc = {
    Text = "Setelah melepaskan Geng, pemakai mendapatkan <WeaponEffect_Num:[StateArg1]> Aliemus."
  },
  State_3040_Desc = {
    Text = "Pada awal setiap putaran, berikan [Layer] lapisan [Bounded] kepada tim kami."
  },
  State_3040_Name = {Text = "Pembatasan"},
  State_3040_WeaponDesc = {
    Text = "Pada awal setiap putaran, berikan [Layer] lapisan [Bounded] kepada tim kami."
  },
  State_3041_Desc = {
    Text = "Tetap berada di dek selamanya."
  },
  State_3041_Name = {
    Text = "<CardKeyWord:Kartu gejala>"
  },
  State_3042_Desc = {
    Text = "Setiap kali memberikan kerusakan, dapatkan [Arg1] kekuatan dalam ronde ini, hingga 3 kali tumpukan. Saat jumlah tumpukan mencapai maksimum, efeknya berlipat ganda."
  },
  State_3043_Desc = {
    Text = "Pada giliran genap, kerusakan yang diterima berkurang sebesar 50%, dan kerusakan meningkat sebesar 33%."
  },
  State_3043_Name = {
    Text = "Berpindah-pindah"
  },
  State_3043_WeaponDesc = {
    Text = "Pada giliran genap, kerusakan yang diterima berkurang sebesar 50%, dan kerusakan meningkat sebesar 33%."
  },
  State_3045_Desc = {
    Text = "Setelah melepaskan Muliakan, Pembangun yang sesuai mendapatkan 20 Aliemus."
  },
  State_3045_Name = {
    Text = "Cadar Dewa Tanpa Nama"
  },
  State_3046_Desc = {
    Text = "Tim Unik: Setiap kali seorang musuh mati, dapatkan [StateArg1] segil hitam. Setelah pemakai membunuh musuh, Crit. DMG pemakai di level ini meningkat permanen sebesar <WeaponEffect_Num:[StateArg2]%>, maksimum tumpukan 5 lapis. Setiap kali pemakai memicu efek Leap, kerusakan akhir yang diberikan oleh pemakai pada ronde ini meningkat sebesar <WeaponEffect_Num:[StateArg3]%>, maksimum tumpukan 3 lapis."
  },
  State_3046_WeaponDesc = {
    Text = "Setiap kali seorang musuh mati, dapatkan [StateArg1] segil hitam. Setelah pemakai membunuh musuh, Crit. DMG pemakai di level ini meningkat secara permanen sebesar <WeaponEffect_Num:[StateArg2]%, maksimum tumpukan 5 lapis. Setiap kali pemakai memicu efek lompatan, kerusakan akhir yang diberikan oleh pemakai pada ronde ini meningkat sebesar <WeaponEffect_Num:[StateArg3]%, maksimum tumpukan 3 lapis."
  },
  State_3047_Desc = {
    Text = "Pada awal giliran, dapatkan [Arg1] Perisai, dan setiap 1 giliran berlalu, nilai Perisai ini akan meningkat sebesar [Arg2]."
  },
  State_3047_Name = {
    Text = "Tangan Pelindung"
  },
  State_3048_Desc = {
    Text = "Semangat bertarung Lotan tidak pernah berhenti. Di akhir setiap ronde, Lotan menghilangkan 3 lapis Kelemahan dan Rentan Negara."
  },
  State_3048_Name = {
    Text = "Lotan Bangun"
  },
  State_3049_Desc = {
    Text = "Meningkatkan jumlah kerusakan dari serangan berikutnya George sebanyak 1."
  },
  State_3049_Name = {Text = "Kesal"},
  State_3049_WeaponDesc = {
    Text = "Meningkatkan jumlah kerusakan dari serangan berikutnya George sebanyak 1."
  },
  State_3050_Desc = {
    Text = "Pada awal pertempuran, masukkan 1 kartu [Kejang] ke dalam tumpukan menggambar."
  },
  State_3050_Name = {
    Text = "Kegelisahan"
  },
  State_3050_WeaponDesc = {
    Text = "Pada awal pertempuran, masukkan 1 kartu [Kejang] ke dalam tumpukan menggambar."
  },
  State_3051_Desc = {
    Text = "Ketika memberikan kerusakan yang tidak terblokir, masukkan satu kartu \"Tangisan\" ke dalam tumpukan menggambar."
  },
  State_3051_Name = {
    Text = "Hasrat membara"
  },
  State_3051_WeaponDesc = {
    Text = "Ketika menyebabkan kerusakan aktual, masukkan satu kartu Tangisan ke dalam tumpukan menggambar."
  },
  State_3054_Name = {
    Text = "Negara@Kutukan Kejutan"
  },
  State_3055_Desc = {
    Text = "Pada awal pertempuran, tim kami mendapat 1 lapisan rapuh."
  },
  State_3055_Name = {Text = "Penetrasi"},
  State_3055_WeaponDesc = {
    Text = "Pada awal pertempuran, tim kami mendapat 1 lapisan rapuh."
  },
  State_3056_Desc = {
    Text = "Pada akhir ronde, hilangkan 1 tingkat Kelemahan dan Rentan."
  },
  State_3056_Name = {Text = "Intimidasi"},
  State_3058_Desc = {
    Text = "Setiap ada 1 Tentakel, dapatkan [Arg1] Perisai pada akhir ronde."
  },
  State_3058_Name = {
    Text = "Anggota Tubuh Tanpa Nama"
  },
  State_3060_Desc = {
    Text = "Pada awal ronde berikutnya, dapatkan [Layer] poin Perisai."
  },
  State_3060_Name = {
    Text = "Rekonstruksi psiko"
  },
  State_3060_WeaponDesc = {
    Text = "Pada awal ronde berikutnya, tarik [Layer] kartu."
  },
  State_3063_Desc = {
    Text = "Setiap kali menyebabkan kerusakan aktual, tambahkan [Layer] racun."
  },
  State_3063_Name = {Text = "Racun"},
  State_3064_Desc = {
    Text = "Menerima kerusakan sebanyak jumlah lapisan yang sama sebelum memainkan kartu. Efek ini akan hilang setelah giliran berakhir."
  },
  State_3064_Name = {Text = "Pembatasan"},
  State_3064_WeaponDesc = {
    Text = "Menerima kerusakan sebanyak jumlah lapisan yang sama sebelum memainkan kartu. Efek ini akan hilang setelah giliran berakhir."
  },
  State_3065_Name = {
    Text = "Negara@Relik Masa Lalu 2"
  },
  State_3068_Desc = {
    Text = "Setelah giliran berakhir, menerima [Layer] poin <FixedDamage:Kerusakan Murni>."
  },
  State_3068_Name = {
    Text = "<IntoxicationColour:Racun>"
  },
  State_3068_WeaponDesc = {
    Text = "Setelah giliran berakhir, menerima [Layer] poin <FixedDamage:Kerusakan Murni>."
  },
  State_3069_Name = {
    Text = "Aksesori Mekanik \"Deus Ex Machina\""
  },
  State_3069_WeaponDesc = {
    Text = "Pada putaran pertama setiap Pertempuran, dapatkan 1 poin Aritmetika tambahan."
  },
  State_3070_Desc = {
    Text = "Satu-satunya di tim: Serangan \"pukulan\" dari pemakai membuat musuh target kehilangan <PowerIconKeywords:Kekuatan> sementara sebesar <WeaponEffect_Num:[StateArg1]%> dari Daya Serang pemakai. Efek ini dapat dipicu maksimal 3 kali dalam satu putaran."
  },
  State_3070_WeaponDesc = {
    Text = "Pengguna \"Serangan\" sementara mengurangi <WeaponEffect_Num:[Power:DescArg1]> poin <PowerIconKeywords:Kekuatan> pada musuh target. Efek ini dapat dipicu maksimal 3 kali dalam satu ronde."
  },
  State_3071_Desc = {
    Text = "Satu-satunya di tim: Setelah menggunakan \"Pertahanan\" pemain, dapatkan <WeaponEffect_Num:[StateArg1]%> dari <PowerIconKeywords:Kekuatan> sementara yang setara dengan daya serang pemain."
  },
  State_3071_WeaponDesc = {
    Text = "Setelah menggunakan \"Pertahanan\", dapatkan <WeaponEffect_Num:[Power:DescArg1]> poin sementara <PowerIconKeywords:Kekuatan>."
  },
  State_3072_Desc = {
    Text = "Satu-satunya di tim: Setelah pemakai peralatan membunuh musuh, mereka mendapatkan <WeaponEffect_Num:[StateArg1]> Aliemus, serta meningkatkan 1% Crit. DMG. Efek ini berlaku untuk seluruh durasi eksplorasi."
  },
  State_3072_WeaponDesc = {
    Text = "Setelah pembunuh musuh, peroleh <WeaponEffect_Num:[StateArg1]> Aliemus, dapatkan 1% Crit. DMG, berlaku untuk seluruh eksplorasi."
  },
  State_3073_Desc = {
    Text = "Satu-satunya di tim: Setelah pemakai melepaskan Aliemus Muliakan, Crit. Rate semua sekutu meningkat sebesar <WeaponEffect_Num:[StateArg1]%> dalam putaran ini."
  },
  State_3073_WeaponDesc = {
    Text = "Setelah pemakai melepaskan Muliakan, Crit. Rate semua sekutu meningkat sebesar <WeaponEffect_Num:[StateArg1]%> di babak ini."
  },
  State_3074_Desc = {
    Text = "Satu-satunya tim: Setelah memainkan kartu gejala, pemakai mendapatkan <WeaponEffect_Num:[StateArg1]> poin aliemus. Efek ini dapat dipicu maksimal 2 kali dalam satu putaran. Setelah pemakai memainkan 1 kartu perintah, ia mendapatkan 1 poin aliemus."
  },
  State_3074_WeaponDesc = {
    Text = "Setelah memainkan satu Kartu Gejala, pemakai mendapatkan <WeaponEffect_Num:[StateArg1]> poin Aliemus. Efek ini dapat dipicu maksimal 2 kali dalam satu ronde. Setelah pemakai memainkan 1 Kartu Perintah, ia mendapatkan 1 poin Aliemus."
  },
  State_3075_Desc = {
    Text = "Satu-satunya di tim: Setelah pemakai melepaskan Aliemus Muliakan, mereka akan memperoleh perisai yang setara dengan <WeaponEffect_Num:[StateArg1]%> dari kekuatan pertahanan pemakai."
  },
  State_3075_Name = {
    Text = "Penghalang hati"
  },
  State_3075_WeaponDesc = {
    Text = "Setelah pelepasan Aliemus Muliakan oleh pemakai, mereka mendapatkan <WeaponEffect_Num:[Block:DescArg1]> poin Perisai."
  },
  State_3076_Desc = {
    Text = "Tim Unik: Setelah Pemakai memberikan Active DMG, Crit. Rate-nya meningkat sebesar <WeaponEffect_Num:[StateArg1]%>, setelah memberikan Kritikal, Crit. Rate yang diperoleh dari efek ini akan dikosongkan."
  },
  State_3076_WeaponDesc = {
    Text = "Setelah Pemakai memberikan Active DMG, Crit. Rate-nya meningkat sebesar <WeaponEffect_Num:[StateArg1]%>, setelah memberikan Kritikal, Crit. Rate yang diperoleh dari efek ini akan dikosongkan."
  },
  State_3078_Desc = {
    Text = "Kerusakan yang ditimbulkan dalam ronde ini pasti akan menjadi kritikal."
  },
  State_3078_Name = {
    Text = "Sementara terjamin meledak"
  },
  State_3078_WeaponDesc = {
    Text = "Crit. Rate meningkat sebesar 100% dalam ronde ini."
  },
  State_3082_Desc = {
    Text = "Setelah melepaskan Muliakan, tempatkan satu Kartu acak Pembangun yang sesuai ke tangan. Kartu tersebut mendapatkan Lelah dan Ilusi."
  },
  State_3082_Name = {
    Text = "Kasus Dokter"
  },
  State_3084_Desc = {
    Text = "Setelah dimainkan, tambahkan [StateArg1] salinan kartu ke <DimensionalSpaceIconKeywords:Ultra> sementara."
  },
  State_3084_Name = {
    Text = "<Rune_13_High:Lompatan Tinggi>"
  },
  State_3084_WeaponDesc = {
    Text = "Setelah digunakan akan lelah, namun akan memasukkan [StateArg1] salinan sementara asli ke dalam ruang ultra."
  },
  State_3087_Desc = {
    Text = "Kerusakan kartu serangan meningkat sebesar [Layer]%."
  },
  State_3087_Name = {
    Text = "Kerusakan kartu serangan meningkat sementara"
  },
  State_3087_WeaponDesc = {
    Text = "Kerusakan kartu serangan meningkat sebesar [Layer]%."
  },
  State_3088_Desc = {
    Text = "Kerusakan aktif yang diterima meningkat sebesar [Layer]. Setiap kali menerima kerusakan, luka pelarutan akan bertambah luas, dan akan pulih pada awal giliran."
  },
  State_3088_Name = {
    Text = "Pelarutan Dalam"
  },
  State_3088_WeaponDesc = {
    Text = "Kerusakan aktif yang diterima meningkat sebesar [Layer]. Setiap kali menerima kerusakan, luka pelarutan akan bertambah luas, dan sembuh pada awal giliran."
  },
  State_3092_Name = {
    Text = "Jika ini adalah pertarungan bos, semua Pembangun mendapatkan 30 Aliemus dan menghilangkan keadaan segel"
  },
  State_3093_Name = {
    Text = "Negara@Peniruan Ahli Sihir Pertunjukan"
  },
  State_3094_Desc = {
    Text = "Mengakibatkan rapuh pada diri sendiri selama 1 putaran saat ditarik. Setelah digunakan, semua musuh menjadi rentan selama 1 putaran. Tidak dapat dijual."
  },
  State_3094_Name = {
    Text = "Negara Kutukan Runtuh"
  },
  State_3094_WeaponDesc = {
    Text = "Mengakibatkan rapuh pada diri sendiri selama 1 putaran saat ditarik. Setelah digunakan, semua musuh menjadi rentan selama 1 putaran. Tidak dapat dijual."
  },
  State_3095_Desc = {
    Text = "Kerusakan yang diberikan dalam level ini meningkat sebesar [Layer] poin."
  },
  State_3095_Name = {
    Text = "Permanent STR"
  },
  State_3095_WeaponDesc = {
    Text = "Kerusakan yang diberikan dalam level ini meningkat sebesar [Layer] poin."
  },
  State_3096_Desc = {
    Text = "Masih ada jalan panjang untuk meyakinkan Lotan."
  },
  State_3096_Name = {
    Text = "Lotan Bangun"
  },
  State_3098_Desc = {
    Text = "Setelah mengambil, pilih satu Kartu untuk membuat konsumsi Lelah Aritmetikanya berubah secara permanen menjadi 1."
  },
  State_3099_Desc = {
    Text = "Setelah melepaskan Muliakan, dapatkan [Arg1] Kekuatan dalam ronde ini."
  },
  State_3100_Desc = {
    Text = "Pada setiap awal ronde, Ketahanan terhadap kematian meningkat 10%. Saat Ketahanan terhadap kematian berada di atas 100%, dapatkan tambahan 30 poin Penguasaan Alam."
  },
  State_3104_Desc = {
    Text = "Dalam ronde ini, setiap kali menerima 1 kerusakan aktif, jumlah serangan \"Manis Jahat\" bertambah +1."
  },
  State_3104_Name = {
    Text = "Pembagian Rasa Sakit"
  },
  State_3104_WeaponDesc = {
    Text = "Dalam ronde ini, setiap kali menerima 1 kerusakan aktif, jumlah serangan \"Manis Jahat\" bertambah +1."
  },
  State_3106_Desc = {
    Text = "Ketika hidup berada di bawah 50% ([StateArg1]), akan terbelah menjadi 2 \"Latihan\" dengan jumlah hidup yang sama."
  },
  State_3106_Name = {Text = "Terbelah"},
  State_3106_WeaponDesc = {
    Text = "Ketika Hidup berada di bawah 50% ([StateArg1]), akan membelah menjadi 3 \"Tubuh yang terlulur Patung lilin Tipe II\" dengan jumlah Hidup yang sama."
  },
  State_3108_Name = {
    Text = "Aksesori Kitab Puisi Melingkar"
  },
  State_3108_WeaponDesc = {
    Text = "Setelah ronde genap dimulai, dapatkan 1 poin Aritmetika."
  },
  State_3109_Name = {
    Text = "Negara@Bab 4 Resonansi@Aritmetika -1"
  },
  State_3109_WeaponDesc = {
    Text = "\"Naive Reciprocity\" Mengurangi Konsumsi Aritmetika sebesar 1"
  },
  State_3110_Name = {
    Text = "Negara@Bab 4 Resonansi@Aritmetika -1"
  },
  State_3110_WeaponDesc = {
    Text = "\"Naive Reciprocity\" Mengurangi Konsumsi Aritmetika sebesar 1"
  },
  State_3111_Desc = {
    Text = "Pada awal ronde berikutnya, ubah sisa Perisai menjadi 2x Hidup."
  },
  State_3111_Name = {
    Text = "Bunga Abadi"
  },
  State_3112_Desc = {
    Text = "Tim Unik: Peningkatan Racun yang diberikan oleh pemakai sebesar <WeaponEffect_Num:[StateArg3]%. Setelah pemakai melepaskan Aliemus Exalt, mereka memulihkan Hidup sebesar <WeaponEffect_Num:[StateArg1]%> dari CON pemakai, dan setiap 1 poin Arithmetica yang tersisa akan memulihkan tambahan Hidup sebesar <WeaponEffect_Num:[StateArg2]%> dari CON pemakai."
  },
  State_3112_Name = {
    Text = "Perjamuan Sunyi"
  },
  State_3112_WeaponDesc = {
    Text = "Peningkatan Racun yang diberikan oleh pemakai sebesar <WeaponEffect_Num:[StateArg3]%>. Setelah pemakai melepaskan Muliakan, pulihkan <WeaponEffect_Num:[Heal:DescArg1]> HP, dan setiap sisa 1 poin Arithmetica, pulihkan tambahan <WeaponEffect_Num:[Heal:DescArg2]> HP."
  },
  State_3113_Desc = {
    Text = "Negara@Pendahuluan_Aliemus0_1_4"
  },
  State_3113_Name = {
    Text = "Negara@Pendahuluan_Aliemus0_1_4"
  },
  State_3113_WeaponDesc = {
    Text = "Negara@Pendahuluan_Aliemus0_1_4"
  },
  State_3114_Desc = {
    Text = "Negara@Prolog_Aliemus0_1_2"
  },
  State_3114_Name = {
    Text = "Negara@Prolog_Aliemus0_1_2"
  },
  State_3114_WeaponDesc = {
    Text = "Negara@Prolog_Aliemus0_1_2"
  },
  State_3115_Desc = {
    Text = "Negara@Prolog_Aliemus0_1_2"
  },
  State_3115_Name = {
    Text = "Negara@Prolog_Aliemus0_1_2"
  },
  State_3115_WeaponDesc = {
    Text = "Negara@Prolog_Aliemus0_1_2"
  },
  State_3116_Name = {
    Text = "Negara@Prolog_Aliemus0_1_1"
  },
  State_3117_Desc = {
    Text = "Satu-satunya di tim: Kerusakan dasar \"Pukulan\" dan \"Aliemus Muliakan\" milik pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah pemakai melancarkan \"Pukulan\", pemakai mendapatkan 5% tingkat kritis sementara, maksimal 3 kali per ronde. Ketika mencapai 3 kali, pemakai mendapatkan 15% kerusakan kritis sementara."
  },
  State_3117_WeaponDesc = {
    Text = "Pengguna senjata mendapatkan peningkatan kerusakan dasar untuk \"Pukulan\" dan \"Muliakan\" sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah pengguna senjata melepaskan \"Pukulan\", mereka mendapatkan 5% tingkat kritis sementara, hingga maksimal 3 kali per ronde. Ketika mencapai 3 kali, mereka mendapatkan 15% kerusakan kritis sementara."
  },
  State_3118_Desc = {
    Text = "Pada awal giliran, pulihkan [Layer]% dari Hidup yang hilang."
  },
  State_3118_Name = {
    Text = "Lindungan Layar Pemandu"
  },
  State_3120_Desc = {
    Text = "[Pertahanan] mendapatkan [Arg1] lapisan Counter."
  },
  State_3121_Desc = {
    Text = "Jika niat musuh bukan untuk menyerang, setelah menyebabkan kerusakan aktif atau kerusakan tentakel, tambahkan efek berdarah yang setara dengan setengah lapisan kerusakan."
  },
  State_3123_Desc = {
    Text = "Tim Unik: Peningkatan <RetaliateIconKeywords: Counter> yang diberikan oleh pemakai sebesar <WeaponEffect_Num:[StateArg3]%>. Setiap kali menerima 1 Serangan, dapatkan <WeaponEffect_Num:[StateArg1]%> <PowerIconKeywords:Kekuatan> sementara yang setara dengan ATK pemakai. Setelah pemakai menggunakan Aliemus Exalt, mereka akan mendapatkan <WeaponEffect_Num:[StateArg2]%> <RetaliateIconKeywords: Counter> yang setara dengan ATK pemakai."
  },
  State_3123_WeaponDesc = {
    Text = "Peningkatan Counter yang diberikan oleh pemakai sebesar <WeaponEffect_Num:[StateArg3]%. Setiap kali menerima 1 Serangan, pemakai mendapatkan <WeaponEffect_Num:[Power:DescArg1]> poin sementara <PowerIconKeywords:Kekuatan>. Setelah pemakai menggunakan Muliakan, mereka mendapatkan <WeaponEffect_Num:[Counterattack:DescArg2]> poin Counter."
  },
  State_3124_Desc = {
    Text = "Detektif keberuntungan mendapatkan dua kali lipat Segil hitam."
  },
  State_3124_Name = {
    Text = "Keberuntungan luar biasa"
  },
  State_3124_WeaponDesc = {
    Text = "Detektif keberuntungan mendapatkan dua kali lipat Segil hitam."
  },
  State_3127_Name = {
    Text = "Negara@Level2_10Pertempuran3Gelembung1"
  },
  State_3128_Desc = {
    Text = "Semua perisai dan pemulihan hidup yang dihasilkan oleh semua Pembangun meningkat [StateArg1]%."
  },
  State_3128_Name = {Text = "bercabang"},
  State_3129_Desc = {
    Text = "Setiap kali menerima Active DMG sebelum giliran berikutnya dimulai, secara tambahan memicu Counter dan Counter tentakel sebanyak [Layer] kali, menimbulkan 50% kerusakan."
  },
  State_3129_Name = {
    Text = "Sisik pelindung"
  },
  State_3130_Desc = {
    Text = "Kerusakan yang diberikan dalam ronde ini meningkat sebesar [Layer] poin."
  },
  State_3130_Name = {
    Text = "Temporary STR"
  },
  State_3130_WeaponDesc = {
    Text = "Kerusakan yang diberikan dalam ronde ini meningkat sebesar [Layer] poin."
  },
  State_3135_Desc = {
    Text = "Setiap memiliki 1 lapisan, jumlah kerusakan aktif yang dihasilkan +1."
  },
  State_3135_Name = {
    Text = "<MadnessIconKeywords:Gila>"
  },
  State_3136_Name = {Text = "Aliemus"},
  State_3137_Desc = {
    Text = "Pada awal pertempuran, dapatkan 1 Tentakel. Kerusakan Tentakel meningkat secara permanen sebesar [Arg1]."
  },
  State_3138_Name = {
    Text = "Aksesoris Paradoks Dua Hukum"
  },
  State_3138_WeaponDesc = {
    Text = "Setelah pemakai menggunakan Muliakan, sekutu akan memperoleh <RetaliateIconKeywords:Counter> berdasarkan 100% dari Pertahanan pemakai. Dan meningkatkan <RetaliateIconKeywords:Counter> saat ini sebesar 10%."
  },
  State_3139_Desc = {
    Text = "Setelah memasuki ronde Ultra, negara kelemahan dan rapuh pada diri sendiri akan dihilangkan, dan semua musuh akan menjadi lemah dan rentan selama 2 ronde."
  },
  State_3140_Desc = {
    Text = "Pada awal pertempuran, masukkan \"Fatamorgana\" ke dalam ruang Ultra hingga jumlah kartu di ruang Ultra-mu mencapai 4."
  },
  State_3143_Desc = {
    Text = "Ketika menyebabkan kerusakan nyata, tim kami kehilangan [Layer] kekuatan sementara."
  },
  State_3143_Name = {Text = "Kelumpuhan"},
  State_3144_Name = {
    Text = "Jumlah lapisan \"Racun\" dan \"Berdarah\" di tim kami berkurang menjadi setengah."
  },
  State_3145_Desc = {
    Text = "Dalam putaran [Layer], kartu tidak dapat digunakan."
  },
  State_3145_Name = {
    Text = "Tidak bisa memainkan kartu"
  },
  State_3146_Desc = {
    Text = "Ketika Utusan Laut memainkan 1 kartu, hasilkan [StateArg1] Tentakel sementara yang dapat mengabaikan batas maksimal Tentakel."
  },
  State_3146_Name = {
    Text = "Kekuatan Pengganti"
  },
  State_3146_WeaponDesc = {
    Text = "Ketika Utusan Laut memainkan 1 kartu, hasilkan [StateArg1] Tentakel sementara yang dapat mengabaikan batas maksimal Tentakel."
  },
  State_3149_Desc = {
    Text = "Saat giliran berikutnya dimulai, Active DMG dan Kerusakan tentakel yang diterima meningkat 50 %."
  },
  State_3149_Name = {
    Text = "Penundaan Kerentanan"
  },
  State_3149_WeaponDesc = {
    Text = "Semua kerusakan yang diterima meningkat sebesar 50%."
  },
  State_3150_Desc = {
    Text = "Setelah menerima 3 kali serangan dalam satu giliran, dapatkan 1 stacks <MadnessColour:Kegilaan> Sementara."
  },
  State_3150_Name = {
    Text = "\"Manis dan Pedih\""
  },
  State_3151_Desc = {
    Text = "Mendapatkan [Arg1] poin Kekuatan secara permanen saat diambil."
  },
  State_3152_Name = {
    Text = "Negara@Aksesori Re-Derivasi"
  },
  State_3152_WeaponDesc = {
    Text = "Setelah giliran pemakai berakhir, dapatkan 3 poin Aliemus. Jika pemulihan Aliemus pemakai lebih dari 10, dapatkan tambahan 2 poin Aliemus."
  },
  State_3153_Name = {
    Text = "Negara@Kutukan Delirium Pemulihan"
  },
  State_3154_Name = {Text = "Crit. Rate"},
  State_3155_Desc = {
    Text = "Setiap putaran pulihkan 10% dari Hidup yang hilang."
  },
  State_3155_Name = {
    Text = "Pelayanan Kesehatan"
  },
  State_3155_WeaponDesc = {
    Text = "Setiap putaran pulihkan 10% dari Hidup yang hilang."
  },
  State_3156_Desc = {
    Text = "Kerusakan pertama yang diterima setiap ronde menjadi 5 kali lipat."
  },
  State_3156_Name = {
    Text = "Kacau panik"
  },
  State_3160_Desc = {
    Text = "Pada awal ronde, tambahkan satu \"Payung Matahari\" dengan [Arg1] Waspada yang diperoleh dalam ronde ini ke tangan. Setelah memainkan 6 kartu, tingkatkan semua \"Payung Matahari\" di tangan sebesar [Arg2] Waspada."
  },
  State_3161_Desc = {
    Text = "Jumlah kartu yang diambil lawan berkurang [Layer], tetapi semua kartu tetap disimpan."
  },
  State_3161_WeaponDesc = {
    Text = "Jumlah kartu yang kami gambar berkurang sebesar [Layer], dan semua kartu memperoleh status tetap."
  },
  State_3163_Desc = {
    Text = "Setelah memicu Ketahanan, pulihkan [Layer] poin Hidup."
  },
  State_3163_Name = {
    Text = "Buaian Para Bintang"
  },
  State_3163_WeaponDesc = {
    Text = "Setelah memicu Ketahanan, pulihkan [Layer] poin Hidup."
  },
  State_3164_Name = {
    Text = "Rantai Kebencian: Penghitungan"
  },
  State_3165_Name = {
    Text = "Penyusup Agama 3"
  },
  State_3166_Name = {
    Text = "Pertempuran ini telah dipicu"
  },
  State_3168_Desc = {
    Text = "Pada awal giliran, tambahkan jumlah serangan untuk semua monster."
  },
  State_3168_Name = {
    Text = "Negara@Pisau Balas Dendam Kerusakan Pemenggalan"
  },
  State_3168_WeaponDesc = {
    Text = "Pada awal giliran, tambahkan jumlah serangan untuk semua monster."
  },
  State_3170_Desc = {
    Text = "Membayar harga untuk menerapkan impuls"
  },
  State_3170_Name = {
    Text = "Membayar harga untuk menerapkan impuls"
  },
  State_3170_WeaponDesc = {
    Text = "Membayar harga untuk menerapkan impuls"
  },
  State_3171_Name = {
    Text = "Negara@Level2_1Pertempuran3Gelembung1"
  },
  State_3172_Desc = {
    Text = "Setiap kali memberikan kerusakan, dapatkan [StateArg1] poin kekuatan sementara, hingga bertumpuk sebanyak [StateArg2] kali. Saat jumlah tumpukan mencapai maksimum, efeknya menjadi dua kali lipat."
  },
  State_3172_Name = {
    Text = "Relik Berlumuran Darah: Kerikil"
  },
  State_3174_Desc = {
    Text = "Batas maksimum Hidup berkurang 30%."
  },
  State_3174_Name = {
    Text = "Relik Sekstan 2"
  },
  State_3174_WeaponDesc = {
    Text = "Batas maksimum Hidup berkurang 30%."
  },
  State_3175_Desc = {
    Text = "Pada awal setiap ronde, semua Pembangun mendapatkan 10 Aliemus."
  },
  State_3175_Name = {
    Text = "Relik Sextant 1"
  },
  State_3175_WeaponDesc = {
    Text = "Pada awal setiap ronde, semua Pembangun mendapatkan 10 Aliemus."
  },
  State_3176_Desc = {
    Text = "Prolog Reset Deck 0_1_1_1"
  },
  State_3176_Name = {
    Text = "Pendahuluan Reset Deck 0_1_1_1_2"
  },
  State_3176_WeaponDesc = {
    Text = "Prolog Reset Deck 0_1_1_1"
  },
  State_3177_Desc = {
    Text = "Ketika \"Kewaspadaan\"mencapai 3 lapis, mundur dan memanggil sebuah \"Patung Lilin\". Lapisan akan dikosongkan pada awal ronde."
  },
  State_3177_Name = {Text = "Waspada"},
  State_3177_WeaponDesc = {
    Text = "Ketika \"Kewaspadaan\"mencapai 3 lapis, mundur dan memanggil sebuah \"Patung Lilin\". Lapisan akan dikosongkan pada awal ronde."
  },
  State_3178_Desc = {
    Text = "Meningkatkan konsumsi aritmetika kartu."
  },
  State_3178_Name = {
    Text = "<SlowIconKeywords: Pelambatan>"
  },
  State_3178_WeaponDesc = {
    Text = "Setiap lapisan kelambatan meningkatkan kelelahan aritmetika kartu sebesar 1 poin."
  },
  State_3179_Desc = {
    Text = "Pada awal pertempuran, dapatkan 20 Perisai. Jika memiliki Perisai di awal setiap ronde, efek kuat Perisai dan Sembuh meningkat sebesar 50% selama ronde tersebut."
  },
  State_3179_Name = {
    Text = "Penjaga Taman yang Terasing"
  },
  State_3179_WeaponDesc = {
    Text = "Pada awal pertempuran, dapatkan 20 Perisai. Jika memiliki Perisai di awal setiap ronde, efek kuat Perisai dan Sembuh meningkat sebesar 50% selama ronde tersebut."
  },
  State_3180_Desc = {
    Text = "Meningkatkan Crit. Rate sebesar 25%. Setelah menyebabkan pemulihan Hidup, ada kemungkinan untuk menyebabkan pemulihan Hidup tambahan sebanyak 1 kali, dengan probabilitas sama dengan Crit. Rate dari penyebab pemulihan."
  },
  State_3180_Name = {
    Text = "Negara@Kunci Perak: Kritis Sembuh"
  },
  State_3181_Name = {Text = "Crit. Rate"},
  State_3183_Desc = {
    Text = "Crit. DMG meningkat sebesar [Layer]% dalam putaran ini."
  },
  State_3183_Name = {
    Text = "Crit. DMG Sementara"
  },
  State_3185_Desc = {
    Text = "Meningkatkan tekanan tambahan saat bergerak"
  },
  State_3185_Name = {
    Text = "Relik Tas Tanpa Dasar 2"
  },
  State_3185_WeaponDesc = {
    Text = "Meningkatkan tekanan tambahan saat bergerak"
  },
  State_3189_Name = {
    Text = "Kekuatan Monster Tertunda"
  },
  State_3190_Name = {
    Text = "Kunci Relik"
  },
  State_3193_Desc = {
    Text = "Setelah putaran berikutnya dimulai, dapatkan [Layer] Perisai."
  },
  State_3193_Name = {
    Text = "Seni yang Hilang"
  },
  State_3193_WeaponDesc = {
    Text = "Setelah putaran berikutnya dimulai, dapatkan [Layer] Perisai."
  },
  State_3196_Desc = {
    Text = "Setelah digunakan, mendapatkan [StateArg1] poin Aritmetika."
  },
  State_3196_Name = {
    Text = "<Rune_4_High:Perhitungan Tingkat Lanjut>"
  },
  State_3196_WeaponDesc = {
    Text = "Setelah digunakan, mendapatkan [StateArg1] poin Aritmetika."
  },
  State_3197_Desc = {
    Text = "\"Pukulan\"memulihkan [Arg1] poin Hidup, dan mengurangi setengah dari lapisan Berdarah dan Racun pada diri sendiri."
  },
  State_3197_Name = {
    Text = "Klem Penghenti Darah"
  },
  State_3200_Desc = {
    Text = "Satu-satunya di tim: Kerusakan dasar dan perisai yang diberikan oleh pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Saat eksplorasi dimulai, tambahkan satu kartu \"Serangan\" dan \"Pertahanan\" milik pemakai ke dalam dek. Setelah pemakai menggunakan kartu \"Pertahanan\", tingkatkan tingkat kritis dan kerusakan kritis kartu \"Serangan\" berikutnya milik pemakai sebesar 15%. Setelah pemakai menggunakan kartu \"Serangan\", tingkatkan perisai kartu \"Pertahanan\" berikutnya milik pemakai sebesar 15%, dapat ditumpuk hingga 3 kali."
  },
  State_3200_WeaponDesc = {
    Text = "Kerusakan dasar dan perisai yang diberikan oleh pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Saat eksplorasi dimulai, tambahkan satu kartu \"Serangan\" dan \"Pertahanan\" milik pemakai ke dalam dek. Setelah pemakai menggunakan kartu \"Pertahanan\", tingkatkan tingkat kritis dan kerusakan kritis kartu \"Serangan\" berikutnya pemakai sebesar 15%. Setelah pemakai menggunakan kartu \"Serangan\", tingkatkan perisai kartu \"Pertahanan\" berikutnya pemakai sebesar 15%. Efek ini dapat ditumpuk hingga 3 kali."
  },
  State_3201_Name = {
    Text = "Rantai kebencian"
  },
  State_3203_Desc = {
    Text = "Tim Unik: Perisai yang ditimbulkan Pemakai meningkat <WeaponEffect_Num:[StateArg3]%>. \"Pertahanan\" Pemakai menimbulkan <IntoxicationIconKeywords:Racun> sebesar <WeaponEffect_Num:[StateArg1]%> DEF Pemakai kepada musuh dengan HP tertinggi. Jika Realm saat ini adalah \"Caro\", saat menerapkan <IntoxicationIconKeywords:Racun>, <EmbryoFusionIconKeywords:Embryo Fusion> + <WeaponEffect_Num:[Blood:StateArg2]>, efek ini maksimal terpicu 3 kali per giliran."
  },
  State_3203_WeaponDesc = {
    Text = "Perisai yang ditimbulkan Pemakai meningkat <WeaponEffect_Num:[StateArg3]%>. \"Pertahanan\" Pemakai menimbulkan <WeaponEffect_Num:[Poison:DescArg1]> tumpukan <IntoxicationIconKeywords:Racun> kepada musuh dengan HP tertinggi. Jika Realm saat ini adalah \"Caro\", saat menerapkan <IntoxicationIconKeywords:Racun>, <EmbryoFusionIconKeywords:Embryo Fusion> +<WeaponEffect_Num:[Blood:StateArg2]>, efek ini maksimal terpicu 3 kali per giliran."
  },
  State_3204_Desc = {
    Text = "Saat menyebabkan kerusakan nyata, masukkan [StateArg1] kartu \"Luka\" ke tumpukan menggambar."
  },
  State_3204_Name = {Text = "Sayatan"},
  State_3204_WeaponDesc = {
    Text = "Mengakibatkan Kelemahan pada diri sendiri selama 1 ronde saat ditarik. Setelah digunakan, semua musuh akan mengalami Kelemahan selama 1 ronde. Tidak dapat dijual."
  },
  State_3206_Desc = {
    Text = "Setiap kali memainkan 1 kartu, Crit. Rate meningkat sebesar [StateArg1]% untuk putaran ini, hingga [StateArg2] kali. Ketika jumlah lapisan mencapai maksimum, efeknya berlipat ganda."
  },
  State_3206_Name = {
    Text = "Relik Memphis Ritual Mirror"
  },
  State_3206_WeaponDesc = {
    Text = "Setiap kali memainkan 1 kartu, Crit. Rate meningkat sebesar [StateArg1]% untuk putaran ini, hingga [StateArg2] kali. Ketika jumlah lapisan mencapai maksimum, efeknya berlipat ganda."
  },
  State_3207_Desc = {
    Text = "Setiap kehilangan 1 poin hidup, hilangkan 1 lapisan. Saat jumlah lapisan menjadi 0, dapatkan perisai sebesar [DescArg1]."
  },
  State_3207_Name = {
    Text = "Hambatan Dimensi"
  },
  State_3208_Desc = {
    Text = "Membatu, tidak dapat bergerak, efek akan hilang setelah giliran berakhir."
  },
  State_3208_Name = {
    Text = "<PetrifactionColour: Petrifikasi>"
  },
  State_3209_Name = {
    Text = "Aksesori Penyedot Kehidupan"
  },
  State_3209_WeaponDesc = {
    Text = "Setelah pertempuran dimulai, jika pekerjaan pemilik peralatan adalah Caro, Daya Serang meningkat sebesar 25%."
  },
  State_3210_Name = {
    Text = "Negara@Pembalasan Pedang Raksasa Mencerahkan1"
  },
  State_3211_Desc = {
    Text = "Batas kartu tangan meningkat sebesar 2, pada akhir ronde tidak perlu membuang kartu tangan lagi. Setiap kali kehilangan hidup, secara acak buang 2 kartu tangan."
  },
  State_3212_Desc = {
    Text = "Active DMG dan Kerusakan tentakel yang diberikan berkurang 25%, saat giliran berakhir hapus 1 stack."
  },
  State_3212_Name = {
    Text = "<WeaknessIconKeywords: Kelemahan>"
  },
  State_3212_WeaponDesc = {
    Text = "Semua kerusakan yang ditimbulkan berkurang sebesar 25%."
  },
  State_3213_Desc = {
    Text = "Perisai dan efek sembuh meningkat [Layer] %"
  },
  State_3213_Name = {
    Text = "Perisai sementara dan penyembuhan kuat"
  },
  State_3213_WeaponDesc = {
    Text = "Perisai dan efek sembuh meningkat [Layer] %"
  },
  State_3215_Name = {
    Text = "Pendulum Waktu \"Tersembunyi\""
  },
  State_3216_Desc = {
    Text = "Setelah pertempuran, dapatkan tambahan 100 segil hitam, tetapi hanya 1 kartu gejala."
  },
  State_3216_Name = {
    Text = "Relik Cincin Keberuntungan"
  },
  State_3216_WeaponDesc = {
    Text = "Setelah pertempuran, dapatkan tambahan 100 segil hitam, tetapi hanya 1 kartu gejala."
  },
  State_3220_Desc = {
    Text = "Setelah melepaskan Muliakan, tarik 1 kartu. Jika Hidup berada di bawah 25%, tarik 1 kartu tambahan."
  },
  State_3223_Desc = {
    Text = "Meningkatkan Efek Kelemahan sebesar 10%. Setiap 3 putaran, tambahkan 1 lapis Kelemahan pada semua musuh."
  },
  State_3224_Name = {
    Text = "Relik Arkana Mencatat Aritmetika"
  },
  State_3225_Name = {
    Text = "Pemenggalan"
  },
  State_3226_Desc = {
    Text = "Setelah digunakan, kartu tidak akan masuk ke tumpukan kartu buang dan tidak dapat digunakan kembali selama pertempuran ini."
  },
  State_3226_Name = {Text = "Lelah"},
  State_3226_WeaponDesc = {
    Text = "Setelah digunakan, kartu tidak akan masuk ke tumpukan kartu buang dan tidak dapat digunakan kembali selama pertempuran ini."
  },
  State_3227_Desc = {
    Text = "Harga semua Relik berkurang sebesar 50%."
  },
  State_3227_Name = {
    Text = "Medali Perdagangan Relik"
  },
  State_3227_WeaponDesc = {
    Text = "Harga semua Relik berkurang sebesar 50%."
  },
  State_3228_Desc = {
    Text = "Pada awal ronde, Pembangun dengan Aliemus terendah mendapatkan 25 Aliemus."
  },
  State_3228_Name = {
    Text = "Relik Arkana Aliemus"
  },
  State_3228_WeaponDesc = {
    Text = "Pada awal ronde, Pembangun dengan Aliemus terendah mendapatkan 25 Aliemus."
  },
  State_3229_Desc = {
    Text = "Prolog Reset Deck 0_1_1_1"
  },
  State_3229_Name = {
    Text = "Prolog Reset Deck 0_1_1_1"
  },
  State_3229_WeaponDesc = {
    Text = "Prolog Reset Deck 0_1_1_1"
  },
  State_3230_Name = {
    Text = "Negara@Umum Tertunda Aritmetika"
  },
  State_3232_Desc = {
    Text = "Negara@Monster Ultra Slot Pemicu"
  },
  State_3232_Name = {
    Text = "Negara@Monster Ultra Slot Pemicu"
  },
  State_3232_WeaponDesc = {
    Text = "Negara@Monster Ultra Slot Pemicu"
  },
  State_3234_Desc = {
    Text = "Pada awal pertempuran, dapatkan 3 Kekuatan, tetapi Kerusakan yang diterima setiap kali meningkat sebesar 5."
  },
  State_3234_Name = {
    Text = "Punggung ke air"
  },
  State_3235_Desc = {
    Text = "Pada awal pertempuran, dapatkan [Layer] kekuatan, tetapi kerusakan yang diterima setiap kali meningkat sebesar 5."
  },
  State_3235_Name = {
    Text = "Punggung ke air"
  },
  State_3236_Desc = {
    Text = "Setelah digunakan, Pembangun lain mendapatkan [StateArg1] Aliemus."
  },
  State_3236_Name = {
    Text = "<Rune_16_High:Memicu Tinggi>"
  },
  State_3237_Desc = {
    Text = "Setiap 3 putaran, dapatkan 3 Tentakel. Tentakel ini mengabaikan batas maksimum Tentakel dan akan dihapus pada akhir putaran."
  },
  State_3238_Desc = {
    Text = "Pada saat pertempuran dimulai, berikan status peningkatan kerusakan yang diterima oleh monster."
  },
  State_3238_Name = {
    Text = "Pada saat pertempuran dimulai, berikan status peningkatan kerusakan yang diterima oleh monster."
  },
  State_3238_WeaponDesc = {
    Text = "Pada saat pertempuran dimulai, berikan status peningkatan kerusakan yang diterima oleh monster."
  },
  State_3239_Desc = {
    Text = "Meningkatkan [Layer] poin Serangan."
  },
  State_3239_Name = {
    Text = "Daya Serang Umum Ditingkatkan"
  },
  State_3239_WeaponDesc = {
    Text = "Meningkatkan [Layer] poin Serangan."
  },
  State_3242_Name = {
    Text = "Tempatkan 2 kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam tumpukan Menggambar"
  },
  State_3243_Desc = {
    Text = "Kartu Aritmetika Ditingkatkan"
  },
  State_3243_Name = {
    Text = "Kartu Aritmetika Ditingkatkan"
  },
  State_3243_WeaponDesc = {
    Text = "Kartu Aritmetika Ditingkatkan"
  },
  State_3244_Desc = {
    Text = "Monster yang dipanggil memiliki hidup dua kali lipat."
  },
  State_3244_Name = {
    Text = "\"Rasa Bersalah dalam Arus Deras\""
  },
  State_3244_WeaponDesc = {
    Text = "Monster yang dipanggil memiliki hidup dua kali lipat."
  },
  State_3245_Desc = {
    Text = "Pada saat pertempuran dimulai, Crit. Rate tim kami turun 30%, dan Crit. DMG meningkat sebesar 30%."
  },
  State_3245_Name = {Text = "Inhibisi"},
  State_3245_WeaponDesc = {
    Text = "Pada saat pertempuran dimulai, Crit. Rate tim kami turun 30%, dan Crit. DMG meningkat sebesar 30%."
  },
  State_3246_Desc = {
    Text = "Pada awal pertempuran, hidup musuh biasa meningkat 30%, setelah kemenangan pertempuran memberikan tambahan 25 segil hitam."
  },
  State_3246_Name = {
    Text = "Relik Bendera Perang yang Hancur"
  },
  State_3246_WeaponDesc = {
    Text = "Pada awal pertempuran, hidup musuh biasa meningkat 30%, setelah kemenangan pertempuran memberikan tambahan 25 segil hitam."
  },
  State_3247_Desc = {
    Text = "[Muliakan] Mengurangi lelah aritmetika semua kartu di tangan sebesar -1."
  },
  State_3247_Name = {
    Text = "Cahaya Peradaban Terasing"
  },
  State_3247_WeaponDesc = {
    Text = "[Muliakan] Mengurangi lelah aritmetika semua kartu di tangan sebesar -1."
  },
  State_3249_Desc = {
    Text = "Teman lain mendapatkan 1 stacks <MadnessColour:Kegilaan>, dilepaskan setelah diri sendiri mati."
  },
  State_3249_Name = {
    Text = "Ketidaktenangan"
  },
  State_3249_WeaponDesc = {
    Text = "Sekutu lainnya mendapatkan 1 tingkat Kegilaan, setelah kematian diri sendiri akan dihilangkan."
  },
  State_3250_Desc = {
    Text = "Tetap tersimpan di dalam dek setelah pertempuran berakhir, tetapi akan dihapus secara permanen setelah dimainkan atau dikonsumsi."
  },
  State_3250_Name = {
    Text = "<DestructionKeywords:memusnahkan>"
  },
  State_3250_WeaponDesc = {
    Text = "Setelah digunakan, secara permanen hapus."
  },
  State_3251_Desc = {
    Text = "Saat menerima Active DMG atau Kerusakan tentakel, Imun terhadap kerusakan dan kurangi 1 lapisan, dihapus saat giliran dimulai."
  },
  State_3251_Name = {
    Text = "<ParcloseColour: Penghalang Sementara>"
  },
  State_3252_Desc = {
    Text = "Ketika Bunga Lumpur memberikan Perisai, Kesehatan maksimum meningkat sebesar [StateArg2]."
  },
  State_3252_Name = {
    Text = "Pengumpulan lendir"
  },
  State_3252_WeaponDesc = {
    Text = "Ketika Bunga Lumpur memberikan Perisai, Kesehatan maksimum meningkat sebesar [StateArg2]."
  },
  State_3253_Desc = {
    Text = "Mendapatkan [StateArg1] poin Waspada sementara."
  },
  State_3253_Name = {
    Text = "<CardKeyWord:Senjata Mekanik-Perisai>"
  },
  State_3253_WeaponDesc = {
    Text = "Mendapatkan [StateArg1] poin Waspada Sementara"
  },
  State_3255_Name = {Text = "Counter"},
  State_3256_Name = {
    Text = "Negara@Kutukan Euforia"
  },
  State_3259_Desc = {
    Text = "Jumlah Active DMG yang ditimbulkan meningkat [Layer]."
  },
  State_3259_Name = {
    Text = "<MadnessColour:Kegilaan>"
  },
  State_3260_Desc = {
    Text = "Ketika ruang ultra mencapai batas maksimal, dapatkan satu putaran ekstra. Pada putaran ini, tidak ada kartu yang diambil (Menggambar), melainkan kartu ruang ultra akan dimasukkan ke dalam tangan."
  },
  State_3260_Name = {
    Text = "<DimensionalSpaceIconKeywords:Ultra>"
  },
  State_3260_WeaponDesc = {
    Text = "Ketika ruang Ultra mencapai batas maksimum, dapatkan satu putaran Ultra tambahan dan tambahkan semua kartu ruang Ultra ke tangan."
  },
  State_3261_Desc = {
    Text = "Kerusakan monster yang dipanggilnya menjadi dua kali lipat."
  },
  State_3261_Name = {
    Text = "\"Patung lilin\""
  },
  State_3261_WeaponDesc = {
    Text = "Kerusakan monster yang dipanggilnya menjadi dua kali lipat."
  },
  State_3262_Desc = {
    Text = "Negara@Lapisan Berlilin Tim Kami"
  },
  State_3262_Name = {
    Text = "Negara@Lapisan Berlilin Tim Kami"
  },
  State_3262_WeaponDesc = {
    Text = "Negara@Lapisan Berlilin Tim Kami"
  },
  State_3263_Name = {
    Text = "Negara@Cangkang Nautilus Balasan"
  },
  State_3264_Name = {
    Text = "Pasti Kritis"
  },
  State_3265_Name = {
    Text = "Buang dan hapus"
  },
  State_3266_Desc = {
    Text = "Lonjakan penguatan di Kota mimpi mati"
  },
  State_3266_Name = {
    Text = "Negara@Ibu Kota Mimpi Mati: Memperkuat Lompatan"
  },
  State_3267_Desc = {
    Text = "Pada awal pertempuran, dapatkan 5 lapisan [Waxy Armor]."
  },
  State_3267_Name = {
    Text = "\"Tuan Lilin\""
  },
  State_3267_WeaponDesc = {
    Text = "Pada awal pertempuran, dapatkan 5 lapisan [Waxy Armor]."
  },
  State_3268_Desc = {
    Text = "Pada awal giliran, tarik 1 kartu. Setiap kali kamu menarik 1 kartu, ubah secara acak Lelah Aritmetikanya (0-4)."
  },
  State_3268_Name = {
    Text = "Kaleidoskop Relik"
  },
  State_3268_WeaponDesc = {
    Text = "Pada awal giliran, tarik 1 kartu. Setiap kali kamu menarik 1 kartu, ubah secara acak Lelah Aritmetikanya (0-4)."
  },
  State_3269_Desc = {
    Text = "Setelah mendapatkan perisai kedua di setiap ronde, dapatkan [Arg1] lapisan Counter. Setelah mendapatkan perisai keempat di setiap ronde, berikan 1 kali kerusakan Counter kepada semua musuh."
  },
  State_3269_Name = {
    Text = "Bicara Jujur"
  },
  State_3270_Name = {
    Text = "Negara@Bab Dua Resonansi Salinan"
  },
  State_3271_Desc = {
    Text = "[Serangan] Memberikan [Arg1] lapisan Racun kepada semua musuh."
  },
  State_3272_Desc = {
    Text = "Saat memberikan kerusakan yang tidak terblokir, pulihkan 3 kali lipat dari nilai kerusakan aktual sebagai hidup. Kerusakan akan dihilangkan saat diberikan."
  },
  State_3272_Name = {Text = "Vampirisme"},
  State_3273_Desc = {
    Text = "Tim Unik: Setelah memainkan kartu pemakai, dapatkan Perisai yang setara dengan <WeaponEffect_Num:[StateArg1]%> dari DEF pemakai. Setiap ada 1 tentakel, akan meningkatkan perisai sebesar <WeaponEffect_Num:[StateArg2]%> dari DEF pemakai. Efek ini hanya berlaku 1 kali per ronde."
  },
  State_3273_Name = {
    Text = "Matinya Ny. Coral"
  },
  State_3273_WeaponDesc = {
    Text = "Setelah memainkan kartu pemain, dapatkan <WeaponEffect_Num:[Block:DescArg1]> perisai, setiap ada 1 tentakel akan meningkatkan perisai sebesar <WeaponEffect_Num:[DescArg2]>. Efek ini hanya berlaku 1 kali per ronde."
  },
  State_3274_Desc = {
    Text = "Setiap kali menerima kerusakan aktif, tambahkan satu lapisan hitungan ke tim kami."
  },
  State_3274_Name = {
    Text = "Negara@Penghitungan kerusakan pemenggalan pada tim kami oleh Blade of Revenge"
  },
  State_3274_WeaponDesc = {
    Text = "Setiap kali menerima kerusakan aktif, tambahkan satu lapisan hitungan ke tim kami."
  },
  State_3277_Desc = {
    Text = "Setelah digunakan, Pembangun yang dimiliki mendapatkan [StateArg1] poin Aliemus."
  },
  State_3277_Name = {
    Text = "<Rune_5:Amukan>"
  },
  State_3280_Name = {
    Text = "Pedang Takdir"
  },
  State_3281_Desc = {
    Text = "Meningkatkan kerusakan aktif yang dihasilkan."
  },
  State_3281_Name = {
    Text = "<PowerIconKeywords: Kekuatan>"
  },
  State_3281_WeaponDesc = {
    Text = "Kerusakan yang dihasilkan meningkat."
  },
  State_3282_Desc = {
    Text = "Jumlah serangan dan peningkatan kerusakan."
  },
  State_3282_Name = {
    Text = "<CardKeyWord:Peningkatan>"
  },
  State_3282_WeaponDesc = {
    Text = "Menambahkan satu kali kerusakan"
  },
  State_3283_Desc = {
    Text = "Pada awal setiap ronde, pulihkan [StateArg1] Hidup. Jika Hidup di bawah 50%, pemulihan Hidup berubah menjadi [StateArg2]."
  },
  State_3283_Name = {
    Text = "Relik Frankincense"
  },
  State_3283_WeaponDesc = {
    Text = "Pada awal setiap ronde, pulihkan [StateArg1] Hidup. Jika Hidup di bawah 50%, pemulihan Hidup berubah menjadi [StateArg2]."
  },
  State_3287_Desc = {
    Text = "Pada awal pertempuran, masukkan 2 kartu \"Inspirasi\" ke dalam dek kartumu. Setiap kali berhasil melewati 1 pertempuran akan meningkatkan Relik ini, hingga maksimal 3 kali."
  },
  State_3288_Desc = {
    Text = "Negara@Kosong"
  },
  State_3288_Name = {
    Text = "Negara@Kosong"
  },
  State_3288_WeaponDesc = {
    Text = "Negara@Kosong"
  },
  State_3289_Desc = {
    Text = "Setiap menerima 1 poin Kerusakan, jumlah lapisan berkurang 1. Setelah jumlah lapisan menjadi 0, Niat akan diganti dengan Bunga Abadi, dan kelompok Keterampilan yang cenderung ke arah Pertahanan akan digunakan."
  },
  State_3289_Name = {
    Text = "Bunga Abadi"
  },
  State_3289_WeaponDesc = {
    Text = "Setiap kali menerima 1 poin Kerusakan, jumlah lapisan berkurang 1. Setelah jumlah lapisan menjadi 0, beralih ke Mode Pertahanan."
  },
  State_3290_Desc = {
    Text = "Makhluk aneh yang dulunya adalah \"Miryam\" terjebak dalam keputusasaan dan paranoia yang ekstrem. Hancurkan ilusi terakhirnya, dan akhiri kegilaan yang telah berlangsung selama ribuan tahun ini."
  },
  State_3290_Name = {Text = "Obsession"},
  State_3291_Desc = {
    Text = "Ketika menyebabkan kerusakan nyata, tim kami kehilangan 3 kekuatan sementara."
  },
  State_3291_Name = {Text = "Kelumpuhan"},
  State_3292_Desc = {
    Text = "Ketika Muliakan dilepaskan, setiap kali musuh akan memberikan 1 Kerusakan, berikan [Arg1] lapisan Racun kepada mereka."
  },
  State_3293_Desc = {
    Text = "Kerusakan yang ditimbulkan dalam level ini berkurang sebesar [Layer] poin."
  },
  State_3293_Name = {Text = "STR▼"},
  State_3293_WeaponDesc = {
    Text = "Kerusakan yang ditimbulkan dalam level ini dan kerusakan tentakel berkurang sebesar [Layer] poin."
  },
  State_3294_Name = {
    Text = "Negara@Kutukan Skeptis"
  },
  State_3296_Desc = {
    Text = "Saat dibuang atau dimainkan, kartu ini akan dihapus."
  },
  State_3296_Name = {
    Text = "Saat dibuang atau dimainkan, hapus kartu ini."
  },
  State_3296_WeaponDesc = {
    Text = "Mengakibatkan Kelemahan pada diri sendiri selama 1 ronde saat ditarik. Setelah digunakan, semua musuh akan mengalami Kelemahan selama 1 ronde. Tidak dapat dijual."
  },
  State_3297_Desc = {
    Text = "Negara@Ratu Duri Terang_Bentuk"
  },
  State_3297_Name = {
    Text = "Negara@Ratu Duri Terang_Bentuk"
  },
  State_3297_WeaponDesc = {
    Text = "Negara@Ratu Duri Terang_Bentuk"
  },
  State_3298_Desc = {
    Text = "Efek lompatan berikutnya pasti akan terpicu dalam ronde ini."
  },
  State_3298_Name = {
    Text = "Lompatan akan selalu terpicu"
  },
  State_3298_WeaponDesc = {
    Text = "Efek lompatan dalam ronde ini tidak memerlukan kondisi."
  },
  State_3301_Name = {
    Text = "Hitung Anggur Bintang"
  },
  State_3302_Desc = {
    Text = "Menerapkan Pembekuan Selamanya"
  },
  State_3302_Name = {
    Text = "Menerapkan Pembekuan Selamanya"
  },
  State_3302_WeaponDesc = {
    Text = "Menerapkan Pembekuan Selamanya"
  },
  State_3304_Desc = {
    Text = "Setiap putaran, Bangun yang sesuai dengan kartu perintah terakhir akan muncul. Pada akhir putaran, dapatkan 15 Aliemus. Jika memiliki \"Patung Ibu\", berikan 5 Aliemus kepada Pembangun lainnya."
  },
  State_3305_Desc = {
    Text = "Setelah digunakan, masukkan [StateArg1] kartu \"Inspirasi\" ke dalam tumpukan undian. \"Inspirasi\": Dapatkan 1 Aritmetika, menggambar 1 kartu, simpan, lelah."
  },
  State_3305_Name = {
    Text = "<Rune_17:Inspirasi>"
  },
  State_3307_Name = {
    Text = "(Sisa:[Layer])"
  },
  State_3308_Desc = {
    Text = "Pada awal ronde, jika jumlah kartu tangan yang tersisa dari ronde sebelumnya lebih dari 2, dapatkan 2 Aritmetika."
  },
  State_3309_Desc = {
    Text = "Kerusakan, perisai, dan sembuh yang dilakukan oleh pengguna meningkat [StateArg1]%。（Sementara）"
  },
  State_3309_Name = {
    Text = "Negara@Prototipe Pedang Panjang Resistansi Mati"
  },
  State_3310_Desc = {
    Text = "Ketika Migran memberikan Perisai, mereka mendapatkan [Energy:StateArg2] Aliemus."
  },
  State_3310_Name = {Text = "Tertutup"},
  State_3310_WeaponDesc = {
    Text = "Ketika Migran memberikan Perisai, mereka mendapatkan [Energy:StateArg2] Aliemus."
  },
  State_3312_Desc = {
    Text = "Setiap kali kamu memulihkan Hidup, dapatkan [Arg1] poin Counter. Jika nilai Hidup lebih dari 75%, dapatkan tambahan [Arg2] poin Counter."
  },
  State_3313_Desc = {
    Text = "Pada awal ronde, tambahkan [Arg1] poin Kekuatan untuk ronde ini. Setiap kali memainkan 1 Kartu, kurangi [Arg2] poin Kekuatan untuk ronde ini."
  },
  State_3314_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_3314_Name = {Text = "Not Roused"},
  State_3315_Desc = {
    Text = "Setelah memainkan Kartu pertama di setiap ronde, ubah 2 Kartu acak di tangan menjadi salinan versi aslinya, dan kembalikan saat ronde berakhir."
  },
  State_3315_Name = {
    Text = "Relik Menggoda Angin Lonceng"
  },
  State_3316_Desc = {
    Text = "Perisai akan tetap ada pada akhir ronde."
  },
  State_3316_Name = {
    Text = "Pelindung Dinding"
  },
  State_3316_WeaponDesc = {
    Text = "Perisai akan tetap ada pada akhir ronde."
  },
  State_3317_Desc = {
    Text = "Kehilangan semua Perisai saat akhir ronde"
  },
  State_3317_Name = {
    Text = "Belenggu: Ayah kandung"
  },
  State_3318_Name = {
    Text = "Negara@Haus darah Pelukan Melahap"
  },
  State_3323_Desc = {
    Text = "Kerusakan, perisai, dan sembuh yang dilakukan oleh pengguna meningkat [StateArg1]%。（Sementara）"
  },
  State_3323_Name = {
    Text = "Negara@Prototipe Pedang Panjang Aliemus"
  },
  State_3324_Desc = {
    Text = "Crit. DMG meningkat sebesar [Layer]% dalam putaran ini."
  },
  State_3324_Name = {
    Text = "Crit. DMG Sementara"
  },
  State_3324_WeaponDesc = {
    Text = "Crit. DMG meningkat sebesar [Layer]% dalam putaran ini."
  },
  State_3325_Desc = {
    Text = "Setiap kali dek diatur ulang, tambahkan 2 kartu \"Trisula\" yang memperoleh [Arg1] poin Kekuatan dalam ronde ini dan 1 kartu \"Payung Matahari\" yang memperoleh [Arg2] poin Waspada dalam ronde ini ke tangan."
  },
  State_3326_Desc = {
    Text = "Kebal terhadap kerusakan aktif pertama setiap ronde."
  },
  State_3326_Name = {Text = "Teguh"},
  State_3326_WeaponDesc = {
    Text = "Kebal terhadap kerusakan aktif pertama setiap ronde."
  },
  State_3327_Desc = {
    Text = "Nilai Hidup monster sebelum mati."
  },
  State_3327_Name = {
    Text = "HP monster sebelum mati"
  },
  State_3327_WeaponDesc = {
    Text = "Nilai Hidup monster sebelum mati."
  },
  State_3328_Desc = {
    Text = "Saat menerima kerusakan fatal dalam pertempuran ini, bangkit kembali sekali dan pulihkan [Layer] poin hidup. Efek ini tidak dapat dihilangkan."
  },
  State_3328_Name = {
    Text = "Burung Abadi dari Surga"
  },
  State_3329_Desc = {
    Text = "Setiap kali kamu memainkan 5 kartu, dapatkan salinan kartu paling kiri di tanganmu, tetapi dengan tambahan Ilusi dan Lelah."
  },
  State_3330_Desc = {
    Text = "Lelah aritmetika kartu bertambah sebesar [Layer] poin. Efek negatif ini akan dihapus setelah kartu dimainkan."
  },
  State_3330_Name = {
    Text = "<SlowColour: Lambat [Layer]>"
  },
  State_3330_WeaponDesc = {
    Text = "Lelah aritmetika kartu bertambah [Layer] poin."
  },
  State_3332_Desc = {
    Text = "Saat menerima Active DMG atau Kerusakan tentakel, Imun terhadap kerusakan dan kurangi 1 stack."
  },
  State_3332_Name = {
    Text = "<ParcloseColour: Penghalang>"
  },
  State_3335_Desc = {
    Text = "Pada awal pertempuran, terapkan 1 lapis Rentan pada semua musuh. \"Kutukan Beku\"meningkatkan efek Rentan yang diterima musuh sebesar 25% secara tambahan."
  },
  State_3335_Name = {
    Text = "Mata Batu Mencerahkan 6"
  },
  State_3336_Name = {
    Text = "Negara@George@Sembuh saat mati"
  },
  State_3337_Name = {
    Text = "Ritual Merah"
  },
  State_3339_Desc = {
    Text = "Meningkatkan [Layer] poin Serangan."
  },
  State_3339_Name = {
    Text = "Daya Serang sementara meningkat"
  },
  State_3339_WeaponDesc = {
    Text = "Meningkatkan [Layer] poin Serangan."
  },
  State_3340_Desc = {
    Text = "Setelah melepaskan Muliakan, kerusakan Muliakan dalam pertempuran ini meningkat sebesar [Arg1], dapat ditumpuk hingga 5 kali. Saat tumpukan penuh, Pembangun yang melepaskan Muliakan ini mendapatkan 100 Aliemus."
  },
  State_3341_Desc = {
    Text = "Negara@Prolog Reset Deck0_1_2_1"
  },
  State_3341_Name = {
    Text = "Negara@Prolog Reset Deck0_1_2_1"
  },
  State_3341_WeaponDesc = {
    Text = "Negara@Prolog Reset Deck0_1_2_1"
  },
  State_3342_Desc = {
    Text = "Negara@Prolog Atur Ulang Deck0_1_2_2"
  },
  State_3342_Name = {
    Text = "Negara@Prolog Atur Ulang Deck0_1_2_2"
  },
  State_3342_WeaponDesc = {
    Text = "Negara@Prolog Atur Ulang Deck0_1_2_2"
  },
  State_3343_Desc = {
    Text = "Negara@Prolog Atur Ulang Deck0_1_2_3"
  },
  State_3343_Name = {
    Text = "Negara@Prolog Atur Ulang Deck0_1_2_3"
  },
  State_3343_WeaponDesc = {
    Text = "Negara@Prolog Atur Ulang Deck0_1_2_3"
  },
  State_3344_Desc = {
    Text = "Negara@Pendahuluan Reset Deck0_1_2_4"
  },
  State_3344_Name = {
    Text = "Negara@Pendahuluan Reset Deck0_1_2_4"
  },
  State_3344_WeaponDesc = {
    Text = "Negara@Pendahuluan Reset Deck0_1_2_4"
  },
  State_3345_Desc = {
    Text = "Negara@Prolog Atur Ulang Deck0_1_2_5"
  },
  State_3345_Name = {
    Text = "Negara@Prolog Atur Ulang Deck0_1_2_5"
  },
  State_3345_WeaponDesc = {
    Text = "Negara@Prolog Atur Ulang Deck0_1_2_5"
  },
  State_3346_Desc = {
    Text = "Negara@Prolog Atur Ulang Deck0_1_2_5"
  },
  State_3346_Name = {
    Text = "Negara@Prolog Atur Ulang Deck0_1_2_5"
  },
  State_3346_WeaponDesc = {
    Text = "Negara@Prolog Reset Deck0_1_2_6"
  },
  State_3347_Desc = {
    Text = "Negara@Prolog Atur Ulang Deck0_1_2_5"
  },
  State_3347_Name = {
    Text = "Negara@Prolog Atur Ulang Deck0_1_2_5"
  },
  State_3347_WeaponDesc = {
    Text = "Negara@Prolog Reset Deck0_1_2_7"
  },
  State_3348_Desc = {
    Text = "Setelah bermain, tarik [StateArg1] kartu."
  },
  State_3348_Name = {
    Text = "<Rune_3_High:Keahlian Tinggi>"
  },
  State_3348_WeaponDesc = {
    Text = "Setelah bermain, tarik [StateArg1] kartu."
  },
  State_3350_Desc = {
    Text = "Setelah melepaskan Muliakan, kehilangan 10% dari Hidup saat ini, dan mencuri [Arg1] poin Kekuatan dari semua musuh dalam ronde ini."
  },
  State_3351_Name = {
    Text = "Negara@Setelah ditambahkan ke dek"
  },
  State_3352_Name = {
    Text = "Relik Rahasia Kosmograf 1"
  },
  State_3354_Name = {
    Text = "Relik Rahasia Bintang 2"
  },
  State_3356_Name = {
    Text = "Akhir giliran: Keracunan Sesak Nafas"
  },
  State_3357_Desc = {
    Text = "Pada awal ronde berikutnya, kerusakan tentakel +[Layer]."
  },
  State_3357_Name = {
    Text = "Kerusakan Tentakel Tertunda"
  },
  State_3358_Desc = {
    Text = "Setelah ronde berikutnya dimulai, dapatkan [Layer] poin Perisai."
  },
  State_3358_Name = {
    Text = "Seni yang Hilang - Perisai"
  },
  State_3359_Desc = {
    Text = "Setiap kartu ketiga yang kamu keluarkan akan berlaku sebanyak 2 kali."
  },
  State_3359_Name = {
    Text = "Anggur Bintang Relik"
  },
  State_3359_WeaponDesc = {
    Text = "Setiap kartu ketiga yang kamu keluarkan akan berlaku sebanyak 2 kali."
  },
  State_3360_Desc = {
    Text = "Negara@Pendahuluan_Reset_Deck0_1_4_1"
  },
  State_3360_Name = {
    Text = "Negara@Pendahuluan_Reset_Deck0_1_4_1"
  },
  State_3360_WeaponDesc = {
    Text = "Negara@Pendahuluan_Reset_Deck0_1_4_1"
  },
  State_3362_Desc = {
    Text = "Negara@Pendahuluan_Reset_Deck0_1_4_1"
  },
  State_3362_Name = {
    Text = "Negara@Pendahuluan_Reset_Deck0_1_4_1"
  },
  State_3362_WeaponDesc = {
    Text = "Negara@Pendahuluan_Reset_Deck0_1_4_1"
  },
  State_3364_Desc = {
    Text = "Saat mengambil, pilih 1 kartu dan berikan 2 efek peningkatan dari pilihan tiga.（Catatan: Mirip dengan Seribu bayangan menghias kartu）"
  },
  State_3365_Desc = {
    Text = "Negara@Pendahuluan_Reset_Deck0_1_4_1"
  },
  State_3365_Name = {
    Text = "Negara@Pendahuluan_Reset_Deck0_1_4_1"
  },
  State_3365_WeaponDesc = {
    Text = "Negara@Pendahuluan_Reset_Deck0_1_4_1"
  },
  State_3366_Desc = {
    Text = "Negara@Pendahuluan_Reset_Deck0_1_4_1"
  },
  State_3366_Name = {
    Text = "Negara@Pendahuluan_Reset_Deck0_1_4_1"
  },
  State_3366_WeaponDesc = {
    Text = "Negara@Pendahuluan_Reset_Deck0_1_4_1"
  },
  State_3368_Desc = {
    Text = "Jika Lelah Aritmetika sebelum fase pembuangan kartu lebih besar dari 5, maka berubah menjadi batu."
  },
  State_3368_Name = {Text = "Petrify"},
  State_3368_WeaponDesc = {
    Text = "Sebelum fase pembuangan, ubah kartu di tangan menjadi batu."
  },
  State_3369_Desc = {
    Text = "Semua efek melahap milikmu berubah menjadi melahap tanpa batas."
  },
  State_3369_Name = {
    Text = "Infinite Devour"
  },
  State_3369_WeaponDesc = {
    Text = "Semua efek melahap milikmu berubah menjadi melahap tanpa batas."
  },
  State_3370_Desc = {
    Text = "Perisai dalam level ini berkurang sebesar [Layer] poin."
  },
  State_3370_Name = {
    Text = "Penurunan Waspada Permanen"
  },
  State_3370_WeaponDesc = {
    Text = "Perisai dalam level ini berkurang sebesar [Layer] poin."
  },
  State_3372_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_3372_Name = {Text = "Not Roused"},
  State_3373_Desc = {
    Text = "Saat menyebabkan kerusakan nyata, masukkan [StateArg1] kartu \"Luka\" ke tumpukan menggambar."
  },
  State_3373_Name = {Text = "Tercekik"},
  State_3373_WeaponDesc = {
    Text = "Mengakibatkan Kelemahan pada diri sendiri selama 1 ronde saat ditarik. Setelah digunakan, semua musuh akan mengalami Kelemahan selama 1 ronde. Tidak dapat dijual."
  },
  State_3374_Desc = {
    Text = "Setelah ronde berakhir, dapatkan lapisan Kekuatan dalam jumlah yang sama."
  },
  State_3374_Name = {Text = "marah"},
  State_3376_Desc = {
    Text = "Kerusakan yang ditimbulkan oleh Aliemus Muliakan dalam pertempuran ini meningkat sebesar [Layer] poin."
  },
  State_3376_Name = {
    Text = "Kerusakan Muliakan Ditingkatkan"
  },
  State_3378_Desc = {
    Text = "Setelah melepaskan Muliakan, kartu berikutnya yang dimainkan akan memiliki efek 2 kali."
  },
  State_3378_Name = {
    Text = "Negara@Kunci Perak Mimpi: Meledak"
  },
  State_3379_Desc = {
    Text = "Ketika hidup di bawah 50%, Pemecah Rantai akan menjadi gila."
  },
  State_3379_Name = {
    Text = "Momen Pembalasan"
  },
  State_3379_WeaponDesc = {
    Text = "Ketika hidup di bawah 50%, Pemecah Rantai akan menjadi gila."
  },
  State_3380_Desc = {
    Text = "Pada awal pertempuran, masukkan 1 kartu [Membingungkan] ke dalam tumpukan menggambar."
  },
  State_3380_Name = {Text = "Hypnotise"},
  State_3380_WeaponDesc = {
    Text = "Pada awal pertempuran, masukkan 1 kartu [Membingungkan] ke dalam tumpukan menggambar."
  },
  State_3381_Name = {
    Text = "Inisialisasi Pekerjaan Ultra"
  },
  State_3382_Desc = {
    Text = "Menerima sebuah misi. Setelah menyelesaikan misi, terima hadiah. [Acara Misi]"
  },
  State_3383_Name = {
    Text = "Inisialisasi Pekerjaan Ultra"
  },
  State_3385_Desc = {
    Text = "Kerusakan aktif dan kerusakan tentakel yang diterima berkurang sebesar 33%."
  },
  State_3385_Name = {
    Text = "Pertahanan Cermin"
  },
  State_3385_WeaponDesc = {
    Text = "Kerusakan aktif dan kerusakan tentakel yang diterima berkurang sebesar 33%."
  },
  State_3386_Desc = {
    Text = "Kerusakan, perisai, dan sembuh yang dilakukan oleh pengguna meningkat [StateArg1]%。（Sementara）"
  },
  State_3386_Name = {
    Text = "Negara@Pedang Panjang Uji Coba Kritis"
  },
  State_3387_Name = {
    Text = "Negara@Level2_3Pertempuran3Gelembung1"
  },
  State_3388_Desc = {
    Text = "Setelah digunakan, mendapatkan [StateArg1] poin Kekuatan."
  },
  State_3388_Name = {
    Text = "<Rune_14:Kekuatan Brutal>"
  },
  State_3389_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_3389_Name = {Text = "Not Roused"},
  State_3390_Desc = {
    Text = "Pada awal pertempuran, semua musuh akan mengalami kelemahan dan rentan selama 1 putaran."
  },
  State_3392_Desc = {
    Text = "Mendapatkan [Arg1] Kekuatan saat diambil. Setiap kali ada \"Embrio\" yang digabungkan, dapatkan tambahan [Arg2] poin Kekuatan dalam ronde ini."
  },
  State_3393_Desc = {
    Text = "Pada awal giliran, Fusi Embrio +30%. Semua Efek Melahap milikmu berubah menjadi Melahap Tanpa Batas."
  },
  State_3394_Name = {
    Text = "Tempatkan 1 kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam tumpukan Menggambar"
  },
  State_3395_Desc = {
    Text = "Satu-satunya di tim: Kerusakan dasar \"Serangan\" pemakai peralatan meningkat 25%, Perisai dasar \"Pertahanan\" pemakai peralatan meningkat 25%. Saat melakukan \"Serangan\" pemakai peralatan, mendapatkan <WeaponEffect_Num:[StateArg1]%> kekuatan sementara <PowerIconKeywords:Kekuatan>, saat melakukan \"Pertahanan\" pemakai peralatan, mendapatkan <WeaponEffect_Num:[StateArg2]%> kewaspadaan sementara <AlertIconKeywords:Waspada>. Jika alam saat ini adalah \"Ultra\", pada saat memasuki ronde Ultra, mendapatkan satu kali kekuatan sementara <PowerIconKeywords:Kekuatan> dan kewaspadaan sementara <AlertIconKeywords:Waspada>."
  },
  State_3395_WeaponDesc = {
    Text = "Kerusakan dasar \"Serangan\" pemakai meningkat sebesar 25%, dan perisai dasar \"Pertahanan\" pemakai meningkat sebesar 25%. Saat menggunakan \"Serangan\" pemakai, dapatkan <WeaponEffect_Num:[Power:DescArg1]> poin sementara <PowerIconKeywords:Kekuatan>, dan saat menggunakan \"Pertahanan\" pemakai, dapatkan <WeaponEffect_Num:[DescArg2]> poin sementara <AlertIconKeywords:Waspada>. Jika alam saat ini adalah \"Ultra\", saat memasuki ronde Ultra, dapatkan sekali <PowerIconKeywords:Kekuatan> sementara dan <AlertIconKeywords:Waspada> sementara."
  },
  State_3397_Desc = {
    Text = "Setiap kali kartu ke-10 dimainkan, tingkatkan [Arg1] kerusakan tentakel, dan buat semua tentakel menyerang 1 kali."
  },
  State_3400_Desc = {
    Text = "Batas maksimum Hidup musuh elit dan musuh bos berkurang sebesar 20%."
  },
  State_3401_Desc = {
    Text = "Setelah digunakan, efek tambahan berlaku sebanyak [StateArg1] kali, mendapatkan [StateArg2] poin Segil hitam, Lelah, bawaan."
  },
  State_3401_Name = {
    Text = "<Rune_7:Gema>"
  },
  State_3402_Desc = {
    Text = "\"Cangkul besi\"Kerusakan serangan berat Lu Sen meningkat sebesar [Layer]%."
  },
  State_3402_Name = {
    Text = "Kerusakan Serangan Berat Ditingkatkan"
  },
  State_3402_WeaponDesc = {
    Text = "Kerusakan serangan berat Cangkul Besi Luosen meningkat sebesar [Layer]%"
  },
  State_3403_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_3403_Name = {Text = "Not Roused"},
  State_3405_Name = {
    Text = "Semua musuh sementara kehilangan [Power:StateArg1] poin <PowerIconKeywords:Kekuatan>, dan perisai serta <PowerIconKeywords:Kekuatan> yang diperoleh dalam 1 putaran berkurang sebesar 50%."
  },
  State_3406_Name = {
    Text = "Mendapatkan [StateArg1] poin <PowerIconKeywords:Kekuatan>"
  },
  State_3407_Name = {
    Text = "Pilih 1 Kartu dari tumpukan menggambar dan tambahkan ke tangan, serta kurangi konsumsi aritmetika sebesar 1."
  },
  State_3408_Name = {
    Text = "Dapatkan <Posse:[DescArg1]> poin Energi-kunci perak. Dalam pertempuran ini, kerusakan dasar dari \"Pemenggalan\" dan \"Seribu bayangan\" meningkat sebesar 10%"
  },
  State_3409_Name = {
    Text = "Pilih satu Pembangun untuk mendapatkan <Energy:[DescArg1]> poin Aliemus."
  },
  State_3410_Name = {
    Text = "Kartu ini meningkatkan Crit. Rate dan Crit. DMG sebesar 50%, serta memberikan kerusakan tembus."
  },
  State_3411_Name = {
    Text = "Kekebalan diri <FragileIconKeywords:Rapuh>, <WeaknessIconKeywords:Kelemahan>, <VulnerabilityIconKeywords:Rentan> selama 1 ronde. Mendapatkan <Block:[Block:StateArg1]> poin Perisai."
  },
  State_3412_Desc = {
    Text = "Kekebalan terhadap negara negatif, berkurang 1 lapisan setelah giliran berakhir atau terkena kritikal."
  },
  State_3412_Name = {
    Text = "lapisan lilin"
  },
  State_3412_WeaponDesc = {
    Text = "Setiap lapisan mengurangi kerusakan yang diterima sebesar 10%, dan setiap kali terkena serangan kritis, lapisan berkurang 1."
  },
  State_3415_Desc = {
    Text = "Saat mengambil, pilih 1 dari 3 Orison Korupsi untuk diperoleh. Orison Korupsi lebih kuat daripada orison biasa, tetapi membutuhkan Kartu lelah saat digunakan."
  },
  State_3415_Name = {
    Text = "Relik Giok Hijau Penciptaan"
  },
  State_3415_WeaponDesc = {
    Text = "Saat mengambil, pilih 1 dari 3 Orison Korupsi untuk diperoleh. Orison Korupsi lebih kuat daripada orison biasa, tetapi membutuhkan Kartu lelah saat digunakan."
  },
  State_3416_Desc = {
    Text = "Tim Unik: Setelah pertempuran dimulai, dapatkan Counter sebesar <WeaponEffect_Num:[StateArg1]%> DEF Pemakai. Setelah memicu <DeathResistanceIconKeywords: Ketahanan>, dapatkan maksimal total 2 tumpukan \"bercabang\": Perisai dan pemulihan HP yang ditimbulkan seluruh rekan meningkat <WeaponEffect_Num:[StateArg2]%>, hapus 1 tumpukan pada akhir giliran, jika Realm saat ini adalah \"Caro\", setelah memicu <DeathResistanceIconKeywords: Ketahanan>, Embryo Fusion <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_3416_WeaponDesc = {
    Text = "Setelah pertempuran dimulai, dapatkan <WeaponEffect_Num:[Counterattack:DescArg1]> tumpukan Counter. Setelah memicu <DeathResistanceIconKeywords: Ketahanan>, dapatkan maksimal total 2 tumpukan \"bercabang\": Perisai dan pemulihan HP yang ditimbulkan seluruh rekan meningkat <WeaponEffect_Num:[StateArg2]%>, hapus 1 tumpukan pada akhir giliran, jika Realm saat ini adalah \"Caro\", setelah memicu <DeathResistanceIconKeywords: Ketahanan>, Embryo Fusion <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_3418_Desc = {
    Text = "Setelah ronde berakhir, kehilangan Kekuatan sementara"
  },
  State_3418_Name = {
    Text = "Penurunan Tertunda"
  },
  State_3419_Desc = {
    Text = "Saat mengambil, tampilkan 3 kartu dengan Orison tingkat lanjut atau terkutuk, pilih satu dan berikan Orison yang sesuai."
  },
  State_3420_Desc = {
    Text = "Setiap tindakan menyebabkan Berdarah, Sembuh dapat mengurangi setengah lapisan Berdarah."
  },
  State_3420_Name = {
    Text = "Cipratan darah"
  },
  State_3420_WeaponDesc = {
    Text = "Setiap tindakan menyebabkan Berdarah, Sembuh dapat mengurangi setengah lapisan Berdarah."
  },
  State_3421_Desc = {
    Text = "Pada awal ronde, tambahkan kartu \"Trisula\" dengan [Arg1] Kekuatan yang diperoleh selama ronde ini ke tangan. Setelah melepaskan Muliakan, tingkatkan semua Kekuatan \"Trisula\" di tangan sebesar [Arg2]."
  },
  State_3422_Name = {
    Text = "Negara@Aksesoris Wahyu Murni"
  },
  State_3422_WeaponDesc = {
    Text = "Setelah melepaskan Geng, pulihkan [DescArg1] Hidup. Jika level isi ulang Kunci perak pemakai lebih dari 20, pulihkan tambahan [DescArg1] Hidup. Efek sejenis tidak dapat diaktifkan kembali."
  },
  State_3423_Desc = {
    Text = "Penguasaan Alam 100, menyebabkan kerusakan ditambah dengan kerusakan tentakel sementara."
  },
  State_3423_Name = {
    Text = "Pendulum Waktu \"Mimpi Buruk\""
  },
  State_3424_Desc = {
    Text = "Pada awal ronde, jika jumlah kartu yang dimainkan pada ronde sebelumnya lebih dari 3, tarik 2 kartu."
  },
  State_3425_Desc = {
    Text = "Ketika hidup di bawah 50%([StateArg1]), ubah niat menjadi \"Melewati kebuntuan\": Hapus negara rapuh, kelemahan, dan racun, berikan 99 lapis kelemahan dan rapuh kepada tim kami."
  },
  State_3425_Name = {
    Text = "Momen Pembalasan"
  },
  State_3425_WeaponDesc = {
    Text = "Ketika hidup di bawah 50%([StateArg1]), ubah niat menjadi \"Melewati kebuntuan\": Hapus negara rapuh, kelemahan, dan racun, berikan 99 lapis kelemahan dan rapuh kepada tim kami."
  },
  State_3429_Desc = {
    Text = "Setiap tindakan memberikan efek Berdarah, Sembuh dapat menghilangkan efek Berdarah."
  },
  State_3429_Name = {
    Text = "Severe Injury"
  },
  State_3429_WeaponDesc = {
    Text = "Setiap tindakan memberikan efek Berdarah, Sembuh dapat menghilangkan efek Berdarah."
  },
  State_3430_Desc = {
    Text = "Setelah melepaskan Muliakan, dapatkan [Arg1] poin Counter. Jika ini adalah pemicu ke-6 dalam Pertempuran ini, maka Counter-mu akan berlipat ganda."
  },
  State_3431_Name = {
    Text = "Kekebalan terhadap racun"
  },
  State_3432_Desc = {
    Text = "Ketika dibuang, itu akan lelah"
  },
  State_3432_Name = {
    Text = "Biaya Buang Kartu"
  },
  State_3432_WeaponDesc = {
    Text = "Mengakibatkan Kelemahan pada diri sendiri selama 1 ronde saat ditarik. Setelah digunakan, semua musuh akan mengalami Kelemahan selama 1 ronde. Tidak dapat dijual."
  },
  State_3434_Name = {
    Text = "Negara@Umum menyebabkan koreksi Rentan"
  },
  State_3436_Desc = {
    Text = "Ada [Layer] Pembangun yang sedang diburu."
  },
  State_3436_Name = {Text = "Diburu"},
  State_3437_Desc = {
    Text = "Negara@Monster Whale Leap Fatamorgana Planet Anak Pertama_Binatang Kekacauan"
  },
  State_3437_Name = {
    Text = "Negara@Monster Whale Leap Fatamorgana Planet Anak Pertama_Binatang Kekacauan"
  },
  State_3437_WeaponDesc = {
    Text = "Negara@Monster Whale Leap Fatamorgana Planet Anak Pertama_Binatang Kekacauan"
  },
  State_3438_Desc = {
    Text = "Mendapatkan [StateArg1] poin Kekuatan sementara."
  },
  State_3438_Name = {
    Text = "<CardKeyWord:Mekanik Bersenjatakan Pedang>"
  },
  State_3439_Desc = {
    Text = "Pada akhir ronde, Tulu mendapatkan 5 poin Aliemus."
  },
  State_3439_Name = {
    Text = "Bintang-bintang kembali ke tempatnya"
  },
  State_3440_Name = {
    Text = "Pemandu Emas"
  },
  State_3441_Desc = {
    Text = "Pada giliran ganjil, jika kartu di tanganmu berjumlah 0, tarik 2 kartu; pada giliran genap, jika Aritmetika-mu adalah 0, dapatkan 2 Aritmetika."
  },
  State_3441_Name = {
    Text = "Puzzle tua yang terasing"
  },
  State_3441_WeaponDesc = {
    Text = "Pada giliran ganjil, jika kartu di tanganmu berjumlah 0, tarik 2 kartu; pada giliran genap, jika Aritmetika-mu adalah 0, dapatkan 2 Aritmetika."
  },
  State_3442_Desc = {
    Text = "Kehilangan permanen [Arg1] Kekuatan saat diambil. Setiap kali memberikan Kerusakan, pulihkan [Arg2] poin Hidup, maksimal dipicu 6 kali per putaran."
  },
  State_3442_Name = {
    Text = "Ciuman Lamprey"
  },
  State_3444_Desc = {
    Text = "Pada awal ronde, tarik 1 kartu."
  },
  State_3445_Desc = {
    Text = "Meningkatkan pertahanan sebesar [Layer]%."
  },
  State_3445_Name = {
    Text = "Persentase Pertahanan Umum Meningkat"
  },
  State_3445_WeaponDesc = {
    Text = "Meningkatkan pertahanan sebesar [Layer]%."
  },
  State_3446_Desc = {
    Text = "Memiliki 5 lapisan [Sumbu Api]. Setelah memainkan kartu, jumlah lapisan berkurang 1. Ketika jumlah lapisan menjadi 0, terjadi ledakan diri, menyebabkan kerusakan sebesar Daya Serang * 2.5."
  },
  State_3446_Name = {Text = "Bom ledak"},
  State_3446_WeaponDesc = {
    Text = "Memiliki 5 lapisan [Sumbu Api]. Setelah memainkan kartu, jumlah lapisan berkurang 1. Ketika jumlah lapisan menjadi 0, terjadi ledakan diri, menyebabkan kerusakan sebesar Daya Serang * 2.5."
  },
  State_3447_Desc = {
    Text = "Memiliki 5 lapisan [Sumbu Api]. Setelah memainkan kartu, jumlah lapisan berkurang 1. Ketika jumlah lapisan menjadi 0, terjadi ledakan diri, menyebabkan kerusakan sebesar Daya Serang * 2.5."
  },
  State_3447_Name = {Text = "Bom ledak"},
  State_3447_WeaponDesc = {
    Text = "Memiliki 5 lapisan [Sumbu Api]. Setelah memainkan kartu, jumlah lapisan berkurang 1. Ketika jumlah lapisan menjadi 0, terjadi ledakan diri, menyebabkan kerusakan sebesar Daya Serang * 2.5."
  },
  State_3448_Desc = {
    Text = "Setelah setiap putaran berakhir, aktifkan semua Tentakel"
  },
  State_3448_Name = {
    Text = "Aktivasi Otomatis Tentakel"
  },
  State_3448_WeaponDesc = {
    Text = "Setelah setiap putaran berakhir, aktifkan semua Tentakel"
  },
  State_3449_Desc = {
    Text = "Negara@Prolog_Aliemus0_1_1 aktif"
  },
  State_3449_Name = {
    Text = "Negara@Prolog_Aliemus0_1_1 aktif"
  },
  State_3449_WeaponDesc = {
    Text = "Negara@Prolog_Aliemus0_1_1 aktif"
  },
  State_3450_Desc = {
    Text = "Saat menerima Active DMG atau Kerusakan tentakel, Imun terhadap kerusakan dan hapus 1 stack."
  },
  State_3450_Name = {
    Text = "<ParcloseIconKeywords: Penghalang>"
  },
  State_3450_WeaponDesc = {
    Text = "Kerusakan yang diterima berkurang 99%, setelah menerima kerusakan kurangi 1 stack."
  },
  State_3451_Desc = {
    Text = "Saat mati, semua Pembangun mendapatkan 10 Aliemus."
  },
  State_3451_Name = {
    Text = "Serpihan Perak Sepanjang Hidup"
  },
  State_3451_WeaponDesc = {
    Text = "Saat mati, semua Pembangun mendapatkan 10 Aliemus."
  },
  State_3452_Desc = {
    Text = "Setiap kali memainkan kartu, terima [StateArg1] kerusakan dan hilangkan 1 lapisan. Jika masih ada pada akhir ronde, menetas sebuah \"Benda Laut\", setiap lapisan hidup meningkat sebesar 10%."
  },
  State_3452_Name = {
    Text = "Erosi Jurang"
  },
  State_3453_Name = {
    Text = "Status@Pengganda Kekuatan Pisau Dendam"
  },
  State_3455_Desc = {
    Text = "Negara@Pendahuluan_Aliemus_Inisialisasi_0_2_3_Efek"
  },
  State_3455_Name = {
    Text = "Negara@Pendahuluan_Aliemus_Inisialisasi_0_2_3_Efek"
  },
  State_3455_WeaponDesc = {
    Text = "Negara@Pendahuluan_Aliemus_Inisialisasi_0_2_3_Efek"
  },
  State_3456_Desc = {
    Text = "[Pertahanan] mendapatkan [StateArg1] lapisan Counter."
  },
  State_3456_Name = {
    Text = "Relik Duri Nettle"
  },
  State_3457_Name = {
    Text = "Imun terhadap kerentanan"
  },
  State_3458_Desc = {
    Text = "Setelah menggunakan [Serangan] dan [Pertahanan], Pembangun yang sesuai mendapatkan 35 Aliemus. Namun, konsumsi Aritmetika mereka bertambah +1."
  },
  State_3459_Desc = {
    Text = "Kerusakan yang ditimbulkan oleh Aliemus Muliakan dalam pertempuran ini meningkat sebesar [Layer] poin."
  },
  State_3459_Name = {
    Text = "Kerusakan Muliakan Ditingkatkan"
  },
  State_3461_Desc = {
    Text = "Setiap kerusakan ke-5 yang kamu sebabkan pasti akan menjadi kritikal."
  },
  State_3462_Name = {
    Text = "Negara@Pengganda Kekuatan Pedang Balas Dendam 3"
  },
  State_3463_Name = {
    Text = "Negara@Kekuatan Pedang Raksasa Pembalasan Pengganda 2"
  },
  State_3464_Desc = {
    Text = "Batas maksimum tentakel bertambah 1. Ketika hidup di bawah 50%, kerusakan tentakel meningkat sebesar [Arg1]."
  },
  State_3465_Desc = {
    Text = "Kartu ini akan dibawa keluar dari pertempuran dan berlaku selama tahap."
  },
  State_3465_Name = {
    Text = "<CardKeyWord:Abadi>"
  },
  State_3465_WeaponDesc = {
    Text = "Kartu ini dapat dibawa keluar dari pertempuran dan tetap berlaku di dalam level."
  },
  State_3466_Desc = {
    Text = "Saat mengambil, pilih satu Pembangun untuk dibangunkan, konsumsi Aritmetika kartu bangunnya akan berkurang 1 secara permanen."
  },
  State_34671_Desc = {
    Text = "Setelah digunakan, kembali ke deck."
  },
  State_34671_Name = {
    Text = "<CardKeyWord:Kembali>"
  },
  State_34685_Name = {
    Text = "Bom Pemain 2"
  },
  State_34689_Desc = {
    Text = "Setiap kehilangan 1 poin hidup, dapatkan 1 lapisan <PainWord:Bertahan>, hingga maksimum 100% dari kesehatan maksimum. Bertahan akan diwariskan ke pertempuran berikutnya."
  },
  State_34689_Name = {
    Text = "<CardKeyWord:Bertahan>"
  },
  State_3468_Desc = {
    Text = "Negara@Kekuatan Barang Cacat"
  },
  State_3468_Name = {
    Text = "Negara@Kekuatan Barang Cacat"
  },
  State_3468_WeaponDesc = {
    Text = "Negara@Kekuatan Barang Cacat"
  },
  State_34691_Desc = {
    Text = "Setiap kehilangan 1 poin Hidup, dapatkan 1 lapisan <PainWord:Bertahan>. Batas maksimal adalah [DescArg1] lapisan. Bertahan akan dibawa ke pertempuran berikutnya."
  },
  State_34691_Name = {
    Text = "<CardKeyWord:Bertahan>"
  },
  State_34696_Desc = {
    Text = "Kartu ini akan selalu berada di tangan dalam situasi apa pun dan meningkatkan batas jumlah kartu tangan +1."
  },
  State_34696_Name = {
    Text = "Pertahankan secara permanen dan abaikan batas tangan"
  },
  State_3469_Desc = {
    Text = "Active DMG dan Kerusakan tentakel yang ditimbulkan berkurang [DescArg1] %."
  },
  State_3469_Name = {
    Text = "<WeaknessColour:Kelemahan>"
  },
  State_3469_WeaponDesc = {
    Text = "Semua kerusakan yang ditimbulkan berkurang sebesar [DescArg1]%."
  },
  State_3470_Desc = {
    Text = "Menerapkan deteksi petrifikasi bertahap"
  },
  State_3470_Name = {
    Text = "Menerapkan deteksi petrifikasi bertahap"
  },
  State_3470_WeaponDesc = {
    Text = "Menerapkan deteksi petrifikasi bertahap"
  },
  State_3471_Desc = {
    Text = "Setiap kartu ke-[StateArg1] yang kamu mainkan akan berlaku 2 kali."
  },
  State_3471_Name = {
    Text = "Hitung Anggur Bintang"
  },
  State_3471_WeaponDesc = {
    Text = "Setiap kartu ke-[StateArg1] yang kamu mainkan akan berlaku 2 kali."
  },
  State_3473_Desc = {
    Text = "Ketika hidup di bawah 50%, \"Gembala Pelita\"akan memohon \"Manifestasi Ilahi\", menyerap semua pengikutnya lalu menjadi gila."
  },
  State_3473_Name = {
    Text = "Cap Lidi Terbakar"
  },
  State_3473_WeaponDesc = {
    Text = "Ketika hidup di bawah 50%, \"Gembala Pelita\"akan memohon \"Manifestasi Ilahi\", menyerap semua pengikutnya lalu menjadi gila."
  },
  State_3475_Desc = {
    Text = "[Serangan] dan [Pertahanan] Lelah Aritmetika +1."
  },
  State_3475_Name = {
    Text = "Relik Kutukan Prasasti"
  },
  State_3475_WeaponDesc = {
    Text = "[Serangan] dan [Pertahanan] Lelah Aritmetika +1."
  },
  State_3476_Desc = {
    Text = "Setiap kali kamu kehilangan Hidup, Fusi Embrio +10%. Jika Hidup di bawah 50%, Efeknya menjadi dua kali lipat."
  },
  State_3477_Desc = {
    Text = "Saat diserang, pulihkan [Layer] %maksimum Hidup. Jika menerima kerusakan melebihi 15% dari kesehatan maksimum, akan mengalami pusing dan negara ini akan dihilangkan."
  },
  State_3477_Name = {
    Text = "Kekacauan Hitam"
  },
  State_3478_Name = {
    Text = "Negara@Aksesori Standar Perjanjian"
  },
  State_3479_Desc = {
    Text = "Setiap konsumsi 1 Segil hitam, semua Pembangun mendapatkan 1 Aliemus."
  },
  State_3479_Name = {
    Text = "Bunga Kebangkitan Relik"
  },
  State_3479_WeaponDesc = {
    Text = "Setiap konsumsi 1 Segil hitam, semua Pembangun mendapatkan 1 Aliemus."
  },
  State_3480_Desc = {
    Text = "Hingga akhir ronde, nilai hidup tidak akan turun menjadi 0."
  },
  State_3480_Name = {
    Text = "Berlian kasar tidak mati"
  },
  State_3480_WeaponDesc = {
    Text = "Hingga akhir ronde, nilai hidup tidak akan turun menjadi 0."
  },
  State_3481_Desc = {
    Text = "Pada awal level, tingkat Ketahanan dan Orison keberuntunganmu akan dilipatgandakan."
  },
  State_3481_Name = {
    Text = "Negara@Kunci Perak: Dua Kali Keberuntungan"
  },
  State_3482_Desc = {
    Text = "Meningkatkan efek rentan sebesar 25%. Setiap 3 putaran, tambahkan 1 lapis rentan pada semua musuh."
  },
  State_3483_Desc = {
    Text = "Setiap tindakan memberikan efek Berdarah, Sembuh dapat menghilangkan efek Berdarah."
  },
  State_3483_Name = {
    Text = "Severe Injury"
  },
  State_3483_WeaponDesc = {
    Text = "Setiap tindakan memberikan efek Berdarah, Sembuh dapat menghilangkan efek Berdarah."
  },
  State_3484_Desc = {
    Text = "Mendapatkan Kekuatan saat menyebabkan Kerusakan nyata."
  },
  State_3484_Name = {
    Text = "\"Kepribadian Kacau\""
  },
  State_3485_Desc = {
    Text = "Negara@Upacara Lentera Berlaku"
  },
  State_3485_Name = {
    Text = "Negara@Upacara Lentera Berlaku"
  },
  State_3485_WeaponDesc = {
    Text = "Negara@Upacara Lentera Berlaku"
  },
  State_3486_Name = {
    Text = "Pedang Takdir"
  },
  State_3488_Desc = {
    Text = "Menerima [StateArg1] kerusakan saat memainkan kartu dan menghilangkan 1 lapisan. Saat jumlah lapisan menjadi 0, menetas satu \"Benda Laut\" yang lebih lemah. Jika status parasit masih ada saat giliran berakhir, menetas satu \"Benda Laut\" dengan hidup yang meningkat sesuai dengan jumlah lapisan."
  },
  State_3488_Name = {
    Text = "Terinfestasi berkali-kali"
  },
  State_3489_Name = {
    Text = "Pada akhir ronde, jika berada di tangan atau <DimensionalSpaceIconKeywords:Ultra>, tingkatkan menjadi \"Korupsi Api Hijau\""
  },
  State_3489_WeaponDesc = {
    Text = "Jika berada di tangan atau ruang Ultra pada akhir ronde, akan mendapatkan Memperkuat."
  },
  State_3490_Desc = {
    Text = "Menerima [StateArg1] kerusakan saat memainkan kartu dan menghilangkan 1 lapisan. Saat jumlah lapisan menjadi 0, menetas satu \"Benda Laut\" yang lebih lemah. Jika status parasit masih ada saat giliran berakhir, menetas satu \"Benda Laut\" dengan hidup yang meningkat sesuai dengan jumlah lapisan."
  },
  State_3490_Name = {
    Text = "Diparasitkan Kembali"
  },
  State_3492_Desc = {
    Text = "Setiap putaran genap mengurangi Kekuatan tim kami sebesar [Layer]."
  },
  State_3492_Name = {
    Text = "Mengurangi Gaya"
  },
  State_3495_Desc = {
    Text = "Setiap tindakan memberikan tambahan [Layer] Berdarah"
  },
  State_3495_Name = {
    Text = "Severe Injury"
  },
  State_3495_WeaponDesc = {
    Text = "Setiap tindakan memberikan tambahan [Layer] Berdarah, Sembuh dapat menghilangkan efek Berdarah."
  },
  State_34964_Desc = {
    Text = "Setelah ronde dimulai, dapatkan 10% dari kesehatan maksimum <PainWord:Bertahan>."
  },
  State_34964_Name = {
    Text = "Jangan pernah lupa"
  },
  State_3496_Name = {
    Text = "Pada akhir ronde, jika berada di tangan atau <DimensionalSpaceIconKeywords:Ultra Space>, tingkatkan menjadi \"Deadly Green Flame\""
  },
  State_3496_WeaponDesc = {
    Text = "Jika berada di tangan atau ruang Ultra pada akhir ronde, akan mendapatkan Memperkuat."
  },
  State_3497_Desc = {
    Text = "Ketika tim terdiri dari Pembangun dengan berbagai profesi, Hidup tim dan semua Serangan serta Pertahanan Pembangun meningkat sebesar 200%"
  },
  State_3497_Name = {
    Text = "Bonus campuran"
  },
  State_3497_WeaponDesc = {
    Text = "Ketika tim terdiri dari Pembangun dengan berbagai profesi, Hidup tim dan semua Serangan serta Pertahanan Pembangun meningkat sebesar 200%"
  },
  State_3499_Desc = {
    Text = "Satu-satunya di tim: Peningkatan Aliemus yang dihasilkan oleh pemakai sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah pemakai melepaskan Muliakan, mereka memperoleh <WeaponEffect_Num:[StateArg2]> poin Energi-s."
  },
  State_3499_WeaponDesc = {
    Text = "Peningkatan Aliemus pada pemakai sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah pemakai melepaskan Muliakan, mereka memperoleh <WeaponEffect_Num:[StateArg2]> poin Energi-s."
  },
  State_3502_Desc = {
    Text = "Kerusakan, perisai, dan sembuh yang dilakukan oleh pengguna meningkat [StateArg1]%。（Sementara）"
  },
  State_3502_Name = {
    Text = "Negara@Prototipe Pisau Kecil Aliemus"
  },
  State_3504_Desc = {
    Text = "Pada awal setiap ronde, tarik [StateArg1] kartu."
  },
  State_3504_Name = {
    Text = "Kompas Penuntun Relik"
  },
  State_3504_WeaponDesc = {
    Text = "Pada awal setiap ronde, tarik [StateArg1] kartu."
  },
  State_3507_Name = {
    Text = "Aksesori dengan Bentuk Organik"
  },
  State_3507_WeaponDesc = {
    Text = "Setelah pemakai menggunakan Muliakan, efek Kuat dari Perisai dan Sembuh mereka akan dilipatgandakan dalam ronde ini."
  },
  State_3508_Name = {
    Text = "Ornamen Gadis Kepompong"
  },
  State_3508_WeaponDesc = {
    Text = "Setelah pertempuran dimulai, jika pemilik peralatan memiliki profesi Kekacauan, Daya Serang meningkat sebesar 25%."
  },
  State_3510_Desc = {
    Text = "Perisai yang diciptakan oleh Pembangun meningkat sebesar [Layer] poin."
  },
  State_3510_Name = {
    Text = "<AlertColour: Waspada>"
  },
  State_3511_Desc = {
    Text = "Kerusakan, perisai, dan sembuh yang dilakukan oleh pengguna meningkat [StateArg1]%。（Sementara）"
  },
  State_3511_Name = {
    Text = "Negara@Pedang Panjang Uji Keberuntungan"
  },
  State_35120_Desc = {
    Text = "Setiap menerima 1 kali Active DMG, memberikan [StateArg1] tumpukan Racun kepada sumber kerusakan, berlangsung selama [Layer] giliran."
  },
  State_35120_Name = {
    Text = "Bunga Abadi di Tengah Lumpur"
  },
  State_3512_Name = {
    Text = "Kerentanan Imun Sementara"
  },
  State_3514_Desc = {
    Text = "Saat giliran berakhir, menerima <FixedDamage:Kerusakan Murni> sebesar jumlah stacks yang setara dan menghapus negara ini."
  },
  State_3514_Name = {
    Text = "<BleedingIconKeywords: Berdarah>"
  },
  State_3514_WeaponDesc = {
    Text = "Menerima kerusakan saat giliran dimulai."
  },
  State_35158_Name = {
    Text = "Pendulum Waktu \"Terpesona\""
  },
  State_3515_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_3515_Name = {Text = "Not Roused"},
  State_35161_Name = {
    Text = "Pendulum Waktu \"Akumulasi\""
  },
  State_3516_Name = {
    Text = "Negara@Kutukan Kepatahan"
  },
  State_3518_Desc = {
    Text = "Setiap kali Penyihir memainkan 1 Kartu, ia mendapatkan [StateArg2] Kekuatan sementara."
  },
  State_3518_Name = {
    Text = "Pembukaan pertunjukan"
  },
  State_3519_Desc = {
    Text = "Bahkan jika bukan giliran Ultra, efek Lompatan dapat dipicu sekali setiap putaran."
  },
  State_3519_Name = {
    Text = "Pengganggu Ruang"
  },
  State_3519_WeaponDesc = {
    Text = "Bahkan jika bukan giliran Ultra, efek Lompatan dapat dipicu sekali setiap putaran."
  },
  State_3520_Desc = {
    Text = "Pada awal pertempuran, pilih satu Pembangun dan berikan 50 Aliemus kepadanya."
  },
  State_35228_Name = {
    Text = "Pendulum Waktu \"Akumulasi\""
  },
  State_3522_Name = {
    Text = "Relik Trisula: Penghitungan"
  },
  State_35238_Desc = {
    Text = "Tim unik: Perisai dan Racun yang disebabkan oleh pemilik meningkat <WeaponEffect_Num:[StateArg1]%>. Setiap kali Ketahanan diaktifkan, semua Pembangun mendapatkan <WeaponEffect_Num:[StateArg2]%> tingkat Crit. Rate dan Crit. DMG sementara."
  },
  State_35238_WeaponDesc = {
    Text = "Peningkatan perisai dan racun yang diberikan oleh pemakai sebesar <WeaponEffect_Num:[StateArg1]%>. Setiap kali ketahanan kematian terpicu, semua pembangun mendapatkan <WeaponEffect_Num:[StateArg2]%> Crit. Rate dan Crit. DMG sementara."
  },
  State_3523_Desc = {
    Text = "Setelah digunakan, semua musuh akan mengalami Kelemahan selama [StateArg1] putaran."
  },
  State_3523_Name = {
    Text = "<Rune_1_High:Kelemahan Tingkat Lanjut>"
  },
  State_3524_Desc = {
    Text = "Kerusakan yang diterima bertambah sebesar [Layer] poin."
  },
  State_3524_Name = {
    Text = "Luka Pelarutan"
  },
  State_3524_WeaponDesc = {
    Text = "Kerusakan yang diterima bertambah sebesar [Layer] poin."
  },
  State_3525_Desc = {
    Text = "Setiap kali tim kami memainkan 1 Kartu, berikan 2 lapis [Borgol] padanya."
  },
  State_3525_Name = {
    Text = "\"Pasokan Khusus Timur\""
  },
  State_3525_WeaponDesc = {
    Text = "Setiap kali tim kami memainkan 1 Kartu, berikan 2 lapis [Borgol] padanya."
  },
  State_35264_Desc = {
    Text = "Setiap kali memainkan 1 kartu dalam ronde ini, \"Ahli Ilusi\"memperoleh 1 lapisan Fatamorgana."
  },
  State_35264_Name = {
    Text = "Rekam Jejak Bayangan"
  },
  State_35277_Name = {
    Text = "Pertahanan Sihir Casiah"
  },
  State_3527_Desc = {
    Text = "Setiap kali kartu perintah pertama dimainkan dalam satu ronde, Pembangun yang sesuai akan memperoleh 15 Aliemus pada akhir ronde. Jika memiliki \"Dedikasi Roh\" secara bersamaan, berikan 5 Aliemus kepada Pembangun lainnya."
  },
  State_3528_Desc = {
    Text = "Kerusakan, perisai, dan sembuh yang dilakukan oleh pengguna meningkat [StateArg1]%。（Sementara）"
  },
  State_3528_Name = {
    Text = "Negara@Prototipe Laser Cannon Alam"
  },
  State_3529_Desc = {
    Text = "Kebal terhadap semua kerusakan. Efek ini akan dihilangkan setelah giliran dimulai."
  },
  State_3529_Name = {
    Text = "Kekebalan terhadap kerusakan"
  },
  State_3530_Desc = {
    Text = "Negara@Detektif Keberuntungan Semua-dalam Tanda 8"
  },
  State_3530_Name = {
    Text = "Negara@Detektif Keberuntungan Semua-dalam Tanda 8"
  },
  State_3530_WeaponDesc = {
    Text = "Negara@Detektif Keberuntungan Semua-dalam Tanda 8"
  },
  State_3531_Desc = {
    Text = "Satu-satunya Tim: Saat pertempuran dimulai, pemilik peralatan mendapatkan <WeaponEffect_Num:[StateArg1]> Aliemus. Setiap kali Pembangun lain melepaskan Muliakan, pemilik peralatan mendapatkan <WeaponEffect_Num:[StateArg2]> Aliemus. Jika alam saat ini adalah \"Aequor\", setelah pemilik peralatan melepaskan Muliakan, ia mendapatkan kerusakan tentakel yang setara dengan <WeaponEffect_Num:[StateArg3]%> dari daya serang."
  },
  State_3531_WeaponDesc = {
    Text = "Pada awal pertempuran, pemilik peralatan mendapatkan <WeaponEffect_Num:[StateArg1]> Aliemus. Setiap kali Pembangun lain melepaskan Muliakan, pemilik peralatan mendapatkan <WeaponEffect_Num:[StateArg2]> Aliemus. Jika alam saat ini adalah \"Aequor\", setelah pemilik peralatan melepaskan Muliakan, kerusakan tentakel meningkat sebesar <WeaponEffect_Num:+[DescArg1]>."
  },
  State_3532_Desc = {
    Text = "Pada awal giliran, dapatkan [StateArg1] Aritmetika."
  },
  State_3532_Name = {
    Text = "Relik Lilin Hitam 1"
  },
  State_3533_Desc = {
    Text = "Pasti muncul di kartu awal."
  },
  State_3533_Name = {
    Text = "<GuyouKeywords:Inherent>"
  },
  State_3533_WeaponDesc = {
    Text = "Setelah pertempuran dimulai, kartu ini tetap berada di tangan."
  },
  State_3535_Desc = {
    Text = "Lelah aritmetika kartu bertambah sebesar [Layer] poin. Efek negatif ini akan dihilangkan setelah giliran berakhir atau setelah kartu dimainkan."
  },
  State_3535_Name = {
    Text = "<SlowColour:Perlambatan Sementara [Layer]>"
  },
  State_3535_WeaponDesc = {
    Text = "Lelah aritmetika kartu bertambah [Layer] poin."
  },
  State_3536_Name = {
    Text = "Pertarungan bos dapat digunakan sebanyak 3 kali"
  },
  State_3537_Desc = {
    Text = "Mendapatkan \"Hadiah Polos\" memungkinkan melakukan satu kali Orison."
  },
  State_3537_Name = {
    Text = "Negara@Bab_Satu_Resonansi4"
  },
  State_3537_WeaponDesc = {
    Text = "Mendapatkan \"Hadiah Polos\" memungkinkan melakukan satu kali Orison."
  },
  State_3538_Desc = {
    Text = "Menggunakan \"Hadiah Polos\" untuk membalas meningkatkan Aliemus."
  },
  State_3538_Name = {
    Text = "Negara@Bab Satu_Resonansi1"
  },
  State_3538_WeaponDesc = {
    Text = "Menggunakan \"Hadiah Polos\" untuk membalas meningkatkan Aliemus."
  },
  State_3539_Desc = {
    Text = "\"Naive Reciprocity\" Mengurangi Konsumsi Aritmetika sebesar 1"
  },
  State_3539_Name = {
    Text = "Negara@Bab_Satu_Resonansi3"
  },
  State_3539_WeaponDesc = {
    Text = "\"Naive Reciprocity\" Mengurangi Konsumsi Aritmetika sebesar 1"
  },
  State_3540_Desc = {
    Text = "\"Hadiah Naif\" dapat menentukan target"
  },
  State_3540_Name = {
    Text = "Negara@Bab_Satu_Resonansi2"
  },
  State_3540_WeaponDesc = {
    Text = "\"Hadiah Naif\" dapat menentukan target"
  },
  State_3541_Desc = {
    Text = "Khum terjebak dalam jebakan yang kalian pasang."
  },
  State_3541_Name = {
    Text = "Terjebak dalam jebakan"
  },
  State_3542_Desc = {
    Text = "Pada awal pertempuran, untuk setiap 1 Orison di dalam dek, dapatkan [Arg1] poin Kekuatan, dan untuk setiap 1 Relik, pulihkan [Arg2] poin Hidup."
  },
  State_3542_Name = {
    Text = "☆Medali Asosiasi Dagang☆"
  },
  State_3545_Name = {
    Text = "Perlawanan Warna yang Menyilaukan"
  },
  State_3545_WeaponDesc = {
    Text = "Setiap kali memainkan 1 kartu, dapatkan [StateArg1]% Ketahanan. Saat mendapatkan Ketahanan, pulihkan [StateArg2] Hidup."
  },
  State_3546_Desc = {
    Text = "Setiap kali tim kami memainkan 1 Kartu, berikan [Layer] lapisan [Bounded]."
  },
  State_3546_Name = {
    Text = "\"Pasokan Khusus Timur\""
  },
  State_3546_WeaponDesc = {
    Text = "Setiap kali tim kami memainkan 1 Kartu, berikan [Layer] lapisan [Bounded]."
  },
  State_3547_Desc = {
    Text = "Setiap kali tim kami memainkan 1 Kartu, berikan [Layer] lapisan [Bounded]."
  },
  State_3547_Name = {
    Text = "\"Pasokan Khusus Timur\""
  },
  State_3547_WeaponDesc = {
    Text = "Setiap kali tim kami memainkan 1 Kartu, berikan [Layer] lapisan [Bounded]."
  },
  State_3548_Desc = {
    Text = "Mengakibatkan Kelemahan pada diri sendiri selama 1 ronde saat ditarik. Setelah digunakan, semua musuh akan mengalami Kelemahan selama 1 ronde. Tidak dapat dijual."
  },
  State_3548_Name = {
    Text = "Negara Kutukan Melemah"
  },
  State_3548_WeaponDesc = {
    Text = "Mengakibatkan Kelemahan pada diri sendiri selama 1 ronde saat ditarik. Setelah digunakan, semua musuh akan mengalami Kelemahan selama 1 ronde. Tidak dapat dijual."
  },
  State_3549_Name = {
    Text = "Negara Aksesori Steppenwolf"
  },
  State_3549_WeaponDesc = {
    Text = "Kerusakan dasar yang diberikan oleh pemakai meningkat sebesar 10%. Jika kuat kerusakan pemakai lebih dari 20%, kerusakan dasar akan meningkat tambahan sebesar 10%."
  },
  State_35503_Name = {
    Text = "Pendulum Waktu \"Menjalar\""
  },
  State_3551_Desc = {
    Text = "Pada awal ronde, jika jumlah kartu tangan yang tersisa dari ronde sebelumnya melebihi [StateArg1] lembar, dapatkan [StateArg2] poin Aritmetika."
  },
  State_3551_Name = {
    Text = "Relik Mesin Diferensial Perak Putih"
  },
  State_3551_WeaponDesc = {
    Text = "Pada awal ronde, jika jumlah kartu tangan yang tersisa dari ronde sebelumnya melebihi [StateArg1] lembar, dapatkan [StateArg2] poin Aritmetika."
  },
  State_35539_Desc = {
    Text = "Kerusakan yang diterima menjadi dua kali lipat, berlangsung selama [Layer] putaran."
  },
  State_35539_Name = {
    Text = "Jejak Penjelajah"
  },
  State_3553_Desc = {
    Text = "Meningkatkan Crit. Rate sebesar 25%. Setelah menyebabkan pemulihan Hidup, ada kemungkinan untuk menyebabkan pemulihan Hidup tambahan sebanyak 1 kali, dengan probabilitas sama dengan Crit. Rate dari penyebab pemulihan."
  },
  State_3553_Name = {
    Text = "Negara@Kunci Perak: Kritis Sembuh"
  },
  State_3554_Desc = {
    Text = "Perisai dan efek sembuh meningkat [Layer] %"
  },
  State_3554_Name = {
    Text = "Perisai dan Sembuh Kuat"
  },
  State_3554_WeaponDesc = {
    Text = "Perisai dan efek sembuh meningkat [Layer] %"
  },
  State_3555_Desc = {
    Text = "Mendapatkan 100% Ketahanan Kematian saat memungut. Setelah Ketahanan Kematian terpicu, pulihkan [Arg1] poin Hidup di awal setiap putaran selama pertempuran ini."
  },
  State_3555_Name = {
    Text = "Pernapasan Buatan"
  },
  State_3556_Desc = {
    Text = "Saat memungut relik ini, pilih satu kartu dan tambahkan satu salinannya ke dalam dek."
  },
  State_3558_Desc = {
    Text = "Pada awal ronde, jika Segil hitam lebih dari 10, Lelah 10 Segil hitam, kerusakan yang diberikan di ronde tersebut akan dilipatgandakan."
  },
  State_3559_Desc = {
    Text = "Saat memberikan kerusakan yang tidak terblokir, tambahkan 1 lapis Rapuh."
  },
  State_3559_Name = {Text = "Cakar"},
  State_3559_WeaponDesc = {
    Text = "Saat menyebabkan kerusakan nyata, masukkan [StateArg1] kartu \"Luka\" ke tumpukan menggambar."
  },
  State_3561_Name = {
    Text = "Negara@Kunci Perak: Hitungan Serangan Kacau"
  },
  State_3562_Desc = {
    Text = "Setelah kematian, kekuatan sekutu lainnya meningkat sebesar [Layer]."
  },
  State_3562_Name = {
    Text = "bahasa mati"
  },
  State_35635_Name = {
    Text = "Negara@Pembangun Casiah diizinkan untuk mengaktifkan kemampuan mengambil benda dari jarak jauh."
  },
  State_35636_Name = {
    Text = "Negara@Pembangun Casiah menambahkan kemampuan mengambil benda dari jarak jauh"
  },
  State_3563_Desc = {
    Text = "Saat menyebabkan kerusakan yang tidak terblokir, masukkan [StateArg1] kartu \"Luka\" ke tumpukan menggambar."
  },
  State_3563_Name = {
    Text = "Bilah tajam"
  },
  State_3563_WeaponDesc = {
    Text = "Saat menyebabkan kerusakan nyata, masukkan [StateArg1] kartu \"Luka\" ke tumpukan menggambar."
  },
  State_35645_Desc = {
    Text = "Jumlah pengambilan kartu dalam ronde ini berkurang sebesar [Layer]."
  },
  State_35645_Name = {
    Text = "Menggambar Dikurangi"
  },
  State_35646_Desc = {
    Text = "Jumlah pengambilan kartu dalam ronde ini berkurang sebesar [Layer]."
  },
  State_35646_Name = {
    Text = "Menggambar Dikurangi"
  },
  State_3564_Desc = {
    Text = "Setelah digunakan, dapatkan [StateArg1] poin Kekuatan sementara. Kartu Orison ini juga dapat menikmati peningkatan Kekuatan."
  },
  State_3564_Name = {
    Text = "<Rune_15_High:Ledakan Tinggi>"
  },
  State_3565_Desc = {
    Text = "Ketika Pemahat memberikan perisai, tingkatkan [StateArg1] kerusakan tentakel."
  },
  State_3565_Name = {
    Text = "Kerajaan Lupa"
  },
  State_3565_WeaponDesc = {
    Text = "Ketika Pemahat memberikan perisai, tingkatkan [StateArg1] kerusakan tentakel."
  },
  State_3566_Desc = {
    Text = "Pada awal giliran, dapatkan 3 Kekuatan sementara. [Muliakan] akan melipatgandakan Kekuatan sementara ini, hingga dapat ditumpuk sebanyak 2 kali."
  },
  State_3566_Name = {
    Text = "Relik Kulit Ular Monster"
  },
  State_3567_Desc = {
    Text = "Kerusakan, perisai, dan sembuh yang dilakukan oleh pengguna meningkat [StateArg1]%。（Sementara）"
  },
  State_3567_Name = {
    Text = "Negara@Uji Coba Meriam Laser Kritis"
  },
  State_35684_Desc = {
    Text = "Setelah tim kami melepaskan Muliakan, kekuatan sendiri hilang dalam giliran itu. Sekali per giliran."
  },
  State_35684_Name = {
    Text = "Takut akan Aliemus"
  },
  State_35685_Desc = {
    Text = "Saat Genesis Kedatangan dilepaskan, kekuatan sementara musuh berkurang."
  },
  State_35685_Name = {
    Text = "Takut akan Aliemus"
  },
  State_3568_Desc = {
    Text = "Ketika Ramona memberikan kerusakan, dia memperoleh [StateArg1] aritmetika."
  },
  State_3568_Name = {
    Text = "Filsafat Pertama"
  },
  State_3568_WeaponDesc = {
    Text = "Ketika Ramona memberikan kerusakan, dia memperoleh [StateArg1] aritmetika."
  },
  State_3570_Name = {
    Text = "Pada awal giliran berikutnya, jumlah kartu yang diambil +2"
  },
  State_3571_Name = {
    Text = "Sementara Kekebalan terhadap Kelemahan"
  },
  State_3572_Desc = {
    Text = "Kerusakan monster yang dipanggilnya menjadi dua kali lipat."
  },
  State_3572_Name = {Text = "Komandan"},
  State_3572_WeaponDesc = {
    Text = "Kerusakan monster yang dipanggilnya menjadi dua kali lipat."
  },
  State_3573_Desc = {
    Text = "Kerusakan pertama yang diterima setiap giliran menjadi 5 kali lipat."
  },
  State_3573_Name = {
    Text = "Kepercayaan diri"
  },
  State_3573_WeaponDesc = {
    Text = "Kerusakan pertama yang diterima di setiap ronde menjadi dua kali lipat."
  },
  State_3574_Desc = {
    Text = "Setiap kali kartu Pembangun yang sama dimainkan secara berurutan, Pembangun tersebut mendapatkan 10 Aliemus."
  },
  State_35768_Name = {
    Text = "Mendapatkan 300 poin Energi-s"
  },
  State_35769_Name = {
    Text = "Mendapatkan 1 poin Aritmetika"
  },
  State_35770_Name = {
    Text = "Menghilangkan status <IntoxicationIconKeywords:Racun>, penyegelan, dan <SlowIconKeywords:Lambat> pada diri sendiri"
  },
  State_35771_Name = {
    Text = "Mendapatkan perisai sebesar [DescArg1]% (<Block:[DescArg2]>) dari kesehatan maksimum"
  },
  State_35772_Name = {
    Text = "Pertarungan bos dapat digunakan tambahan sebanyak [StateArg1] kali"
  },
  State_35774_Desc = {
    Text = "Panggil bantuan Celeste sekali sebelum kematian, pulihkan semua Hidup, Aliemus, dan Energi-s."
  },
  State_35774_Name = {
    Text = "Tabir Utopian"
  },
  State_3577_Name = {
    Text = "Peningkatan Pemulihan Aliemus Otomatis"
  },
  State_35809_Desc = {
    Text = "Kerusakan yang ditimbulkan berkurang sebesar [StateArg1]%, berlangsung selama [Layer] putaran."
  },
  State_35809_Name = {
    Text = "Pewaris Tipuan"
  },
  State_35809_WeaponDesc = {
    Text = "Negara@Aequor Teh Merah dan Kue"
  },
  State_3580_Desc = {
    Text = "[Layer] Kerusakan yang ditimbulkan oleh tentakel dalam ronde adalah kerusakan tembus."
  },
  State_3580_Name = {
    Text = "Tentakel Penusuk"
  },
  State_35811_Desc = {
    Text = "Saat menerima Active DMG atau kerusakan tentakel, dapatkan <SacrificeKeyWord:Pengorbanan> senilai setengah dari kerusakan tersebut, berlangsung selama [Layer] ronde."
  },
  State_35811_Name = {
    Text = "Pewaris Tipuan"
  },
  State_35819_Desc = {
    Text = "Pada akhir ronde, Murphy mendapatkan 5 poin Aliemus. Setelah melepaskan Geng, hilangkan 2% dari Kesehatan maksimum <SacrificeKeyWord:Pengorbanan>."
  },
  State_35819_Name = {
    Text = "Teh hitam dan kue"
  },
  State_3581_Desc = {
    Text = "Negara@Nyonya Merah Roda Nafsu Kekuasaan Hitungan"
  },
  State_3581_Name = {
    Text = "Negara@Nyonya Merah Roda Nafsu Kekuasaan Hitungan"
  },
  State_3582_Desc = {
    Text = "Bahkan jika tidak dalam ronde Ultra, efek Lompatan dapat dipicu sekali per ronde. Saat terpicu, tarik satu kartu Pembangun yang sesuai dengan Bangun."
  },
  State_3582_Name = {
    Text = "Peralatan Pembelokan Ruang Terasing"
  },
  State_3582_WeaponDesc = {
    Text = "Bahkan jika tidak dalam ronde Ultra, efek Lompatan dapat dipicu sekali per ronde. Saat terpicu, tarik satu kartu Pembangun yang sesuai dengan Bangun."
  },
  State_3584_Desc = {
    Text = "Kerusakan, perisai, dan sembuh yang dilakukan oleh pengguna meningkat [StateArg1]%。（Sementara）"
  },
  State_3584_Name = {
    Text = "Negara@Prototipe Pisau Kecil Alam"
  },
  State_35858_Desc = {
    Text = "Pada akhir ronde, Murphy mendapatkan 5 poin Aliemus. Setelah melepaskan Geng, Murphy mendapatkan kerusakan tentakel sebesar 3% dari Daya Serang Murphy."
  },
  State_35858_Name = {
    Text = "Teh hitam dan kue"
  },
  State_3585_Desc = {
    Text = "Ketika hidup di bawah 50% ([StateArg1]), \"Pendeta Pelita\"akan memohon \"Manifestasi Ilahi\", menyerap semua pengikut sebelum menjadi gila."
  },
  State_3585_Name = {
    Text = "Cap Lidi Terbakar"
  },
  State_3585_WeaponDesc = {
    Text = "Ketika hidup di bawah 50% ([StateArg1]), \"Pendeta Pelita\"akan memohon \"Manifestasi Ilahi\", menyerap semua pengikut sebelum menjadi gila."
  },
  State_3588_Name = {
    Text = "Relik Arkana Aritmetika"
  },
  State_3589_Desc = {
    Text = "Saat menerima Active DMG atau Kerusakan tentakel, Imun terhadap kerusakan dan kurangi 1 stack."
  },
  State_3589_Name = {
    Text = "<ParcloseColour: Penghalang>"
  },
  State_3591_Desc = {
    Text = "Tim Unik: <RetaliateIconKeywords:Counter> yang ditimbulkan Pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. \"Pertahanan\" mendapatkan Counter sementara setara dengan <WeaponEffect_Num:[StateArg2]%> DEF Pemakai, dalam Pertarungan Pemimpin, diganti menjadi mendapatkan Counter sementara 3 kali lipat. Setelah Ketahanan terpicu, memicu [StateArg3]% <RetaliateIconKeywords:Counter> terhadap semua musuh."
  },
  State_3591_Name = {
    Text = "Bersembunyi dalam kegelapan malam"
  },
  State_3591_WeaponDesc = {
    Text = "<RetaliateIconKeywords:Counter> yang ditimbulkan Pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah men-play \"Pertahanan\", mendapatkan <WeaponEffect_Num:[Counterattack:DescArg1]> tumpukan Counter sementara, dalam Pertarungan Pemimpin, diganti menjadi mendapatkan Counter sementara 3 kali lipat. Setelah Ketahanan terpicu, memicu [StateArg3]% <RetaliateIconKeywords:Counter> terhadap semua musuh."
  },
  State_3592_Desc = {
    Text = "Meningkatkan kerusakan yang dihasilkan oleh tentakel."
  },
  State_3592_Name = {
    Text = "<TentacleInjurieIconKeywords:Kerusakan tentakel>"
  },
  State_3592_WeaponDesc = {
    Text = "Meningkatkan jumlah kerusakan yang dihasilkan oleh tentakel."
  },
  State_3593_Desc = {
    Text = "Tim Unik: <IntoxicationIconKeywords:Racun> yang diberikan Pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. \"Pukulan\" memberikan <IntoxicationIconKeywords:Racun> kepada musuh target sebesar <WeaponEffect_Num:[StateArg2]%> dari ATK. Efek ini maksimal berlaku 3 kali per ronde."
  },
  State_3593_WeaponDesc = {
    Text = "Pengguna peralatan meningkatkan <IntoxicationIconKeywords:Racun> sebesar <WeaponEffect_Num:[StateArg1]%>. \"Pukulan\"memberikan <WeaponEffect_Num:[Poison:DescArg1]> lapisan <IntoxicationIconKeywords:Racun> pada musuh target. Efek ini paling banyak aktif 3 kali per putaran."
  },
  State_3596_Name = {
    Text = "Sisa Inti Perak"
  },
  State_35970_Desc = {
    Text = "Setelah kematian, pemain akan diberikan <VulnerabilityIconKeywords:Rentan> selama 1 putaran."
  },
  State_35970_Name = {
    Text = "Kematian dini"
  },
  State_35971_Desc = {
    Text = "Saat muncul, dapatkan perisai setara dengan 50% dari kesehatan maksimum."
  },
  State_35971_Name = {
    Text = "cangkang telur"
  },
  State_3597_Name = {
    Text = "Sisa Inti Perak"
  },
  State_3598_Name = {
    Text = "Sisa Inti Perak"
  },
  State_3599_Desc = {
    Text = "Ketika memainkan 1 Kartu dengan Lelah Aritmetika aktual sebesar 4 atau lebih, Lelah Aritmetika kartu lain di tangan berkurang 1."
  },
  State_36006_Desc = {
    Text = "Setelah kematian, \"Anak Mimpi\"akan muncul di tempat asal."
  },
  State_36006_Name = {
    Text = "menerima kerusakan"
  },
  State_3600_Name = {
    Text = "Sisa Inti Perak"
  },
  State_36013_Desc = {
    Text = "Negara ini juga dianggap sebagai <SacrificeKeyWord:Pengorbanan>, pada awal giliran berikutnya dapatkan [Layer] lapisan status <SacrificeKeyWord:Pengorbanan>."
  },
  State_36013_Name = {
    Text = "<BlueKeyWord:Pengorbanan Tertunda>"
  },
  State_36014_Desc = {
    Text = "Pada akhir ronde, menerima [Layer] kerusakan dan mengurangi 50% jumlah lapisan <SacrificeKeyWord:Pengorbanan>."
  },
  State_36014_Name = {
    Text = "<BlueKeyWord:Pengorbanan>"
  },
  State_3601_Name = {
    Text = "Negara@Kunci Perak Mimpi: Hitungan Roda Tari"
  },
  State_36022_Desc = {
    Text = "Ketika menerima kerusakan dari sumber selain <SacrificeKeyWord:Pengorbanan>, dapatkan 50% dari kerusakan tersebut sebagai <SacrificeKeyWord:Pengorbanan>."
  },
  State_36022_Name = {
    Text = "Mengunjungi"
  },
  State_36023_Desc = {
    Text = "Setelah kematian, jika ada sekutu lain, akan menghasilkan \"Anak Air\"."
  },
  State_36023_Name = {
    Text = "menerima kerusakan"
  },
  State_36024_Desc = {
    Text = "Setelah kematian, jika ada sekutu lain, akan menghasilkan \"Anak Mimpi\"."
  },
  State_36024_Name = {
    Text = "menerima kerusakan"
  },
  State_3603_Name = {
    Text = "Dalam pertarungan bos, dapat digunakan sebanyak 2 kali dan setelah digunakan pertama kali akan kembali ke tangan"
  },
  State_3604_Desc = {
    Text = "Ketika tim terdiri dari Pembangun dengan berbagai profesi, Hidup tim dan semua Serangan serta Pertahanan Pembangun meningkat sebesar 200%"
  },
  State_3604_Name = {
    Text = "Negara@Gabungan Bonus"
  },
  State_3604_WeaponDesc = {
    Text = "Ketika tim terdiri dari Pembangun dengan berbagai profesi, Hidup tim dan semua Serangan serta Pertahanan Pembangun meningkat sebesar 200%"
  },
  State_3607_Desc = {
    Text = "Setelah digunakan, Pembangun akan memperoleh peningkatan kemampuan khusus selama pertempuran ini. Menggunakan Gnosis Membangkitkan berkali-kali tidak akan menumpuk efeknya."
  },
  State_3607_Name = {
    Text = "<ExaltIconKeywords:Gnosis Membangkitkan>"
  },
  State_3607_WeaponDesc = {
    Text = "Setelah Membangkitkan digunakan, Pembangun akan mendapatkan peningkatan kemampuan khusus selama pertempuran ini. Namun, penggunaan Membangkitkan secara berulang tidak akan menumpuk efeknya."
  },
  State_3608_Name = {
    Text = "Semua sekutu mendapatkan [StateArg1] poin Aliemus."
  },
  State_36092_Desc = {
    Text = "Setelah kematian, jika ada sekutu lain, \"Anak Air\"akan muncul di tempat asal."
  },
  State_36092_Name = {
    Text = "menerima kerusakan"
  },
  State_36093_Desc = {
    Text = "Setiap kehilangan 1 poin Hidup akan mengurangi 1 lapisan. Ketika jumlah lapisan menjadi 0, setelah giliran monster berakhir, akan Memanggil 1 \"Anak Air\" dan mendapatkan kembali [DescArg1] lapisan \"Inang Air\", dengan maksimal 4 \"Anak Air\" yang dapat ada."
  },
  State_36093_Name = {Text = "Tuan Air"},
  State_36094_Desc = {
    Text = "Setiap kehilangan 1 poin hidup mengurangi 1 lapisan. Ketika jumlah lapisan menjadi 0, memanggil 1 \"Anak Ruh Sadar\"dan mendapatkan kembali [DescArg1] lapisan \"Induk Sanga\", maksimal ada 4."
  },
  State_36094_Name = {
    Text = "Hospes Kesadaran Spiritual"
  },
  State_3609_Name = {
    Text = "Dalam pertempuran pimpinan, dapat digunakan 2 kali dan setelah penggunaan pertama kembali ke tangan, kartu yang diambil ulang dalam giliran ini mengurangi konsumsi aritmetika 1"
  },
  State_36111_Desc = {
    Text = "Setelah kematian, tambahkan 1 kartu \"Sanga\" ke tangan pemain."
  },
  State_36111_Name = {
    Text = "Sanga parasit"
  },
  State_3611_Desc = {
    Text = "Negara@Pendahuluan Musuh Pasif12"
  },
  State_3611_Name = {
    Text = "Negara@Pendahuluan Musuh Pasif12"
  },
  State_3611_WeaponDesc = {
    Text = "Negara@Pendahuluan Musuh Pasif12"
  },
  State_36124_Desc = {
    Text = "Setelah ronde berakhir, menerima [Layer] poin kerusakan dan mengurangi 50% lapisan \"Pengorbanan\"."
  },
  State_36124_Name = {
    Text = "<BlueKeyWord:Pengorbanan>"
  },
  State_3612_Desc = {
    Text = "Negara@Prolog Musuh Pasif 13"
  },
  State_3612_Name = {
    Text = "Negara@Prolog Musuh Pasif 13"
  },
  State_3612_WeaponDesc = {
    Text = "Negara@Prolog Musuh Pasif 13"
  },
  State_36136_Name = {
    Text = "Saat di tangan, setiap 1 Kartu lain yang di-play, menerima [StateArg1] poin <FixedDamage:Kerusakan Murni>."
  },
  State_3613_Desc = {
    Text = "Negara@Pendahuluan Monster Pasif 10"
  },
  State_3613_Name = {
    Text = "Negara@Pendahuluan Monster Pasif 10"
  },
  State_3613_WeaponDesc = {
    Text = "Negara@Pendahuluan Monster Pasif 10"
  },
  State_3614_Desc = {
    Text = "Negara@Prolog Musuh Pasif 11"
  },
  State_3614_Name = {
    Text = "Negara@Prolog Musuh Pasif 11"
  },
  State_3614_WeaponDesc = {
    Text = "Negara@Prolog Musuh Pasif 11"
  },
  State_36152_Desc = {
    Text = "Pada akhir ronde, menerima kerusakan sebanyak jumlah lapisan yang sama, lalu menghapus 50% lapisan <SacrificeKeyWord:Pengorbanan>. Pengorbanan akan diwariskan ke pertempuran berikutnya."
  },
  State_36152_Name = {
    Text = "<SacrificeKeyWord:Pengorbanan>"
  },
  State_3615_Desc = {
    Text = "Negara@Prolog Musuh Pasif 16"
  },
  State_3615_Name = {
    Text = "Negara@Prolog Musuh Pasif 16"
  },
  State_3615_WeaponDesc = {
    Text = "Negara@Prolog Musuh Pasif 16"
  },
  State_3616_Desc = {
    Text = "Negara@Prolog Musuh Pasif 14"
  },
  State_3616_Name = {
    Text = "Negara@Prolog Musuh Pasif 14"
  },
  State_3616_WeaponDesc = {
    Text = "Negara@Prolog Musuh Pasif 14"
  },
  State_36173_Name = {
    Text = "Pertarungan bos dapat digunakan sebanyak [DescArg1] kali"
  },
  State_36174_Name = {
    Text = "(Tersisa [Layer] kali)"
  },
  State_3617_Desc = {
    Text = "Negara@Prolog Musuh Pasif 15"
  },
  State_3617_Name = {
    Text = "Negara@Prolog Musuh Pasif 15"
  },
  State_3617_WeaponDesc = {
    Text = "Negara@Prolog Musuh Pasif 15"
  },
  State_36182_Name = {
    Text = "Mendapatkan perisai sebesar [DescArg1]% (<Block:[DescArg2]>) dari kesehatan maksimum dan memulihkan jumlah hidup yang sama. Perisai meningkat sesuai dengan kesehatan yang hilang."
  },
  State_3618_Desc = {
    Text = "Mendapatkan perisai saat menerima kerusakan."
  },
  State_3618_Name = {Text = "buffer"},
  State_3618_WeaponDesc = {
    Text = "Mendapatkan perisai saat menerima kerusakan."
  },
  State_36196_Desc = {
    Text = "Kerusakan \"Pukulan\" Lotan meningkat sebesar 30%."
  },
  State_36196_Name = {
    Text = "Pedang terlepas"
  },
  State_3619_Desc = {
    Text = "Negara@Penari Api Biru menyerang Pertahanan"
  },
  State_3619_Name = {
    Text = "Negara@Penari Api Biru menyerang Pertahanan"
  },
  State_3619_WeaponDesc = {
    Text = "Negara@Penari Api Biru menyerang Pertahanan"
  },
  State_3620_Desc = {
    Text = "Setiap kali mendapatkan Kartu Gejala, tingkatkan Kesehatan maksimum sebesar [Arg1] poin."
  },
  State_3621_Desc = {
    Text = "Setiap kali Pengikut Asli memainkan 1 kartu, tarik [StateArg1] kartu, dan picu 5% Racun pada semua musuh."
  },
  State_3621_Name = {
    Text = "Obsesi kelam"
  },
  State_3621_WeaponDesc = {
    Text = "Setiap kali Penganut Awal memainkan 1 kartu, tarik [StateArg1] kartu."
  },
  State_3622_Desc = {
    Text = "Memperkuat efek keterampilan \"Pemburu Kepala yang Mengamuk\" dan \"Yang Mati\". Setiap awal ronde, mendapatkan [StateArg1] poin kekuatan sementara. Setiap lapisan \"Tanda Perburuan\" meningkatkan [StateArg1] poin lagi."
  },
  State_3622_Name = {
    Text = "Tanda Buruan"
  },
  State_36242_Desc = {
    Text = "Setelah pertempuran dimulai, dapatkan [StateArg1] poin perisai. Setelah kehilangan hidup, \"Anak Suci\"akan bangun dari tidur nyenyak dan mulai menangis."
  },
  State_36242_Name = {
    Text = "Deep Slumber"
  },
  State_3624_Desc = {
    Text = "Negara@Pengurangan kekuatan analisis penyerangan"
  },
  State_3624_Name = {
    Text = "Negara@Pengurangan kekuatan analisis penyerangan"
  },
  State_3625_Desc = {
    Text = "Ketika kamu memiliki perisai, kerusakan yang diberikan meningkat sebesar [Arg1]. Jika perisaimu lebih tinggi daripada hidup saat ini, kerusakan yang diberikan akan meningkat tambahan sebesar [Arg2]."
  },
  State_36263_Desc = {
    Text = "Tidak lagi menerima kerusakan, bersiap untuk melepaskan \"Benih Kelahiran\"."
  },
  State_36263_Name = {Text = "Imun"},
  State_3628_Name = {
    Text = "Negara@Setelah digunakan, pertahanan akan hancur"
  },
  State_3629_Name = {
    Text = "Ambil 2 kartu"
  },
  State_3630_Name = {
    Text = "Menambahkan 2 lapis <VulnerabilityIconKeywords:Rentan> kepada semua musuh"
  },
  State_36315_Desc = {
    Text = "Pada akhir ronde, dapatkan [Layer] poin Kekuatan."
  },
  State_36315_Name = {Text = "Monen"},
  State_3631_Name = {
    Text = "Mendapatkan 2 poin Aritmetika"
  },
  State_3632_Name = {
    Text = "Mendapatkan <Energy:[DescArg1]> poin Aliemus"
  },
  State_36332_Desc = {
    Text = "Di awal setiap ronde, pilih untuk mendapatkan 1 lapisan kekuatan Ibu Dewa atau gunakan Lelah kekuatan Ibu Dewa untuk mendapatkan bantuan Murphy sebanyak 1 kali."
  },
  State_36332_Name = {
    Text = "Kekuatan Ibu Suci"
  },
  State_36334_Desc = {
    Text = "Dapatkan 1 Tentakel di akhir setiap ronde."
  },
  State_36334_Name = {
    Text = "Panggilan Spiral"
  },
  State_3633_Name = {
    Text = "Terapkan 2 lapisan <WeaknessIconKeywords:Kelemahan> pada semua musuh"
  },
  State_36346_Desc = {
    Text = "Ketika Hidup berkurang menjadi 0, ubah Hidup menjadi 1 poin, tidak lagi menerima Kerusakan, bersiap untuk melepaskan \"Benih Kelahiran Kembali\"."
  },
  State_36346_Name = {
    Text = "Benih Kelahiran"
  },
  State_3634_Name = {
    Text = "Tambahkan 2 kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam tumpukan kartu Menggambar"
  },
  State_3635_Name = {
    Text = "Pembangun lainnya memperoleh <Energy:[DescArg1]> poin Aliemus"
  },
  State_36360_Desc = {
    Text = "Setelah ronde dimulai, ada [DescArg1]% kemungkinan mendapatkan 1 lapisan Pengumpulan Tentakel. Jika melebihi 100%, beberapa lapisan dapat diperoleh."
  },
  State_36360_Name = {
    Text = "Garis kembali"
  },
  State_36361_Desc = {
    Text = "Saat muncul, sekutu lainnya mendapatkan [Layer] poin Kekuatan."
  },
  State_36361_Name = {
    Text = "Penurunan Ilahi"
  },
  State_3636_Desc = {
    Text = "Negara@Relik Menggoda Angin Berbunyi Aktif"
  },
  State_3636_Name = {
    Text = "Negara@Relik Menggoda Angin Berbunyi Aktif"
  },
  State_3637_Desc = {
    Text = "Ketika hidupmu di bawah 25% dan belum mati, segera pulihkan [Arg1] poin hidup. Setelah dipicu 3 kali, efek ini akan hilang secara permanen."
  },
  State_3637_Name = {
    Text = "☆Makanan Darurat☆"
  },
  State_3638_Desc = {
    Text = "Saat menerima Active DMG atau Kerusakan tentakel, Imun terhadap kerusakan dan kurangi 1 stack."
  },
  State_3638_Name = {
    Text = "<ParcloseColour: Penghalang>"
  },
  State_3638_WeaponDesc = {
    Text = "Kerusakan yang diterima berkurang 99%, setiap menerima 1 kali kerusakan kurangi 1 stack."
  },
  State_3639_Desc = {
    Text = "Ketika Ramona memberikan kerusakan, dia memperoleh [StateArg1] aritmetika."
  },
  State_3639_Name = {
    Text = "Filsafat Ketiga"
  },
  State_3639_WeaponDesc = {
    Text = "Ketika Ramona memberikan kerusakan, dia memperoleh [StateArg1] aritmetika."
  },
  State_3641_Desc = {
    Text = "Di \"Patung Lilin yang Belum Selesai\", pilih satu kartu untuk mengurangi Aritmetika sebesar 1."
  },
  State_3641_Name = {
    Text = "Negara@Bab_Dua_Resonansi_Efek_Dasar"
  },
  State_3641_WeaponDesc = {
    Text = "Pada node \"Patung Lilin yang Belum Selesai\", tingkat Kartu salinan +1"
  },
  State_3642_Desc = {
    Text = "Setiap kali kamu kehilangan Hidup, dapatkan [Arg1] lapisan Counter. Jika ini adalah pemicu ketiga dalam satu ronde, berikan 1 kali Kerusakan Counter kepada semua musuh."
  },
  State_3642_Name = {
    Text = "Jam Saku Orang Lama"
  },
  State_3646_Desc = {
    Text = "Nyawa tidak dapat berkurang di bawah 1. Saat menerima kerusakan fatal, niat akan diganti dengan [Melewati kebuntuan]. [Melewati kebuntuan]: Pulihkan kesehatan maksimum sebesar 100%, kekuatan menjadi dua kali lipat, dan memperkuat keterampilan berikutnya."
  },
  State_3646_Name = {
    Text = "Keluar dari Kebuntuan"
  },
  State_3647_Name = {
    Text = "Relik Arkana Catatan Hitungan"
  },
  State_3648_Desc = {
    Text = "Satu-satunya di tim: Efek pemulihan hidup pengguna meningkat sebesar <WeaponEffect_Num:[StateArg2]%>. Di awal giliran, dapatkan <PowerIconKeywords:Kekuatan> dan Perisai sementara yang setara dengan <WeaponEffect_Num:[StateArg1]%> dari hidup yang hilang pada giliran sebelumnya."
  },
  State_3648_WeaponDesc = {
    Text = "Pemulihan efek hidup pemakai meningkat sebesar <WeaponEffect_Num:[StateArg2]%>. Di awal giliran, dapatkan sementara <PowerIconKeywords:Kekuatan> dan Perisai yang setara dengan <WeaponEffect_Num:[StateArg1]%> dari hidup yang hilang pada giliran sebelumnya."
  },
  State_3649_Desc = {
    Text = "Untuk setiap [Ultra] Pembangun di tim, Kesehatan maksimum (belum selesai), Pertahanan, dan Serangan seluruh tim meningkat sebesar 50%."
  },
  State_3649_Name = {
    Text = "Ultra Bonus"
  },
  State_3649_WeaponDesc = {
    Text = "Untuk setiap [Ultra] Pembangun di tim, Kesehatan maksimum (belum selesai), Pertahanan, dan Serangan seluruh tim meningkat sebesar 50%."
  },
  State_3651_Desc = {
    Text = "Mengubah aritmetika kartu sebelum bermain"
  },
  State_3651_Name = {
    Text = "Mengubah aritmetika kartu sebelum bermain"
  },
  State_3651_WeaponDesc = {
    Text = "Mengubah aritmetika kartu sebelum bermain"
  },
  State_3652_Desc = {
    Text = "Pada awal ronde, jika jumlah kartu yang dimainkan pada ronde sebelumnya melebihi [StateArg1], tarik [StateArg2] kartu."
  },
  State_3652_Name = {
    Text = "Relik Sarung Tangan Sihir"
  },
  State_3652_WeaponDesc = {
    Text = "Pada awal ronde, jika jumlah kartu yang dimainkan pada ronde sebelumnya melebihi [StateArg1], tarik [StateArg2] kartu."
  },
  State_3653_Name = {
    Text = "Relik Spanduk Perang Rusak 2"
  },
  State_3654_Desc = {
    Text = "Setelah ronde dimulai, dapatkan [Layer]% Crit. Rate sementara."
  },
  State_3654_Name = {
    Text = "Suara lembut bertahap meningkat"
  },
  State_3654_WeaponDesc = {
    Text = "Jika tidak kehilangan hidup hingga awal giliran berikutnya, Crit. Rate giliran berikutnya +[StateArg1]%."
  },
  State_3656_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_3656_Name = {Text = "Not Roused"},
  State_3658_Desc = {
    Text = "Saat memainkan kartu terakhir di tangan, tarik 2 kartu. Setiap ronde dapat dipicu maksimal 2 kali."
  },
  State_3659_Name = {
    Text = "Negara@Crit. Rate Crit. DMG meningkat"
  },
  State_36613_Name = {
    Text = "Negara@Aksesori Mekanik Penghitung Penurunan"
  },
  State_3661_Desc = {
    Text = "Meningkatkan jumlah lapisan Pelarutan saat menerima Kerusakan aktual"
  },
  State_3661_Name = {
    Text = "Meningkatkan jumlah lapisan Pelarutan Mendalam saat menerima Kerusakan."
  },
  State_3661_WeaponDesc = {
    Text = "Meningkatkan jumlah lapisan Pelarutan saat menerima Kerusakan aktual"
  },
  State_3662_Desc = {
    Text = "Crit. DMG meningkat sebesar [Layer]% dalam pertempuran ini."
  },
  State_3662_Name = {Text = "Crit. DMG"},
  State_3662_WeaponDesc = {
    Text = "Crit. DMG meningkat sebesar [Layer]% dalam pertempuran ini."
  },
  State_36631_Desc = {
    Text = "Setiap kali melepaskan Aliemus Muliakan, tambahkan 1 lapis \"Mengandung\". Setiap lapis \"Mengandung\"memberikan [StateArg1] poin Kekuatan, dengan batas maksimal 5 lapis."
  },
  State_36631_Name = {
    Text = "Penyandang Hamil Palsu"
  },
  State_36635_Desc = {
    Text = "Setiap kali melepaskan Aliemus Muliakan, tambahkan 1 lapis \"Mengandung\". Setiap lapis \"Mengandung\"memberikan [StateArg1] poin Kekuatan, dengan batas maksimal 5 lapis."
  },
  State_36635_Name = {
    Text = "Penurunan Akhir Lemuria"
  },
  State_36636_Desc = {
    Text = "Ketika mencapai 5 lapisan, \"Kemuliaan Lemuria!\" akan dilepaskan, menyebabkan kerusakan besar dan memanggil keluarga ras."
  },
  State_36636_Name = {Text = "Birth"},
  State_36637_Desc = {
    Text = "Ketika mencapai 5 lapisan, \"Untuk Lemuria!\"akan dilepaskan, menyebabkan kerusakan besar dan memanggil makhluk suci."
  },
  State_36637_Name = {Text = "Birth"},
  State_3663_Desc = {
    Text = "Setelah memainkan Kartu untuk pertama kalinya setiap ronde, tempatkan satu \"Pukulan\" dari Pembangun yang sesuai ke dalam tangan."
  },
  State_3664_Desc = {
    Text = "Setelah digunakan, mendapatkan 5 poin Aliemus."
  },
  State_3664_Name = {
    Text = "Penghormatan"
  },
  State_3664_WeaponDesc = {
    Text = "Setelah digunakan, mendapatkan 5 poin Aliemus."
  },
  State_3665_Desc = {
    Text = "Setelah fusi embrio mencapai batas maksimum, letakkan satu kartu \"Embrio\" ke dalam tangan."
  },
  State_3665_Name = {
    Text = "<EmbryoFusionIconKeywords:Fusi Embrio>"
  },
  State_3666_Desc = {
    Text = "Crit. Rate meningkat sebesar [Layer]%."
  },
  State_3666_Name = {Text = "Crit. Rate"},
  State_3666_WeaponDesc = {
    Text = "Crit. Rate meningkat sebesar [Layer]%."
  },
  State_36670_Name = {
    Text = "Negara@Aksesoris Re-evolusi Penghitungan"
  },
  State_36670_WeaponDesc = {
    Text = "Setelah giliran pemakai berakhir, dapatkan 3 poin Aliemus. Jika pemulihan Aliemus pemakai lebih dari 10, dapatkan tambahan 2 poin Aliemus."
  },
  State_3667_Desc = {
    Text = "Tim Unik: Counter yang diberikan oleh pemakai meningkat sebesar <WeaponEffect_Num:[StateArg4]%. Setelah pemakai memainkan kartu, mereka mendapatkan Counter yang setara dengan DEF pemakai <WeaponEffect_Num:[StateArg1]%, maksimum 2 kali per ronde. Jika pemakai memasuki Ruang Ultra, mereka juga akan mendapatkan <WeaponEffect_Num:[StateArg2]> poin Aliemus. Setelah melepaskan Exalt, semua musuh kehilangan Kekuatan sementara sebesar <WeaponEffect_Num:[StateArg3]%> dari DEF pemakai."
  },
  State_3667_WeaponDesc = {
    Text = "Peningkatan <RetaliateIconKeywords:Counter> yang diberikan oleh pemakai sebesar <WeaponEffect_Num:[StateArg4]%. Setelah pemakai memainkan Kartu, mereka mendapatkan <WeaponEffect_Num:[Counterattack:DescArg1]> poin <RetaliateIconKeywords:Counter>, dapat dipicu maksimal 2 kali per ronde, jika pemakai memasuki Ruang Ultra, mereka juga akan mendapatkan <WeaponEffect_Num:[StateArg2]> poin Aliemus. Setelah melepaskan Exalt, semua musuh sementara mengurangi <WeaponEffect_Num:[Power:DescArg2]> poin Kekuatan."
  },
  State_3668_Desc = {
    Text = "Negara@Penjaga Taman Alienasi"
  },
  State_3668_Name = {
    Text = "Negara@Penjaga Taman Alienasi"
  },
  State_3668_WeaponDesc = {
    Text = "Negara@Penjaga Taman Alienasi"
  },
  State_3669_Desc = {
    Text = "Kebal terhadap Kelemahan, Rapuh, dan Rentan selama [Layer] giliran."
  },
  State_3669_Name = {
    Text = "<BlessingColour: Berkah>"
  },
  State_3669_WeaponDesc = {
    Text = "[Layer] Kebal terhadap negara negatif yang diberikan dalam satu putaran."
  },
  State_36710_Name = {
    Text = "Tarian Bulan Cembung"
  },
  State_3673_Desc = {
    Text = "Saat mengambil, pilih 2 kartu untuk dihapus dan dapatkan [StateArg1] Kekuatan."
  },
  State_3673_Name = {
    Text = "Relik Hitam Api Berdebu"
  },
  State_3674_Desc = {
    Text = "Pada akhir ronde, kurangi 10 Aliemus dari semua Pembangun."
  },
  State_3674_Name = {Text = "Punah"},
  State_3674_WeaponDesc = {
    Text = "Pada akhir ronde, kurangi 10 Aliemus dari semua Pembangun."
  },
  State_3675_Name = {
    Text = "Ambil jumlah kartu yang dibuang + 1 kartu"
  },
  State_3676_Desc = {
    Text = "Selama giliran lawan, kerusakan yang diterima berkurang sebesar [Layer]%."
  },
  State_3676_Name = {Text = "Waspada"},
  State_3676_WeaponDesc = {
    Text = "Saat giliran tim kami, monster mendapatkan [Layer]% pengurangan damage."
  },
  State_3677_Desc = {
    Text = "Meningkatkan pertahanan sebesar [Layer]%."
  },
  State_3677_Name = {
    Text = "Peningkatan persentase pertahanan sementara"
  },
  State_3677_WeaponDesc = {
    Text = "Meningkatkan pertahanan sebesar [Layer]%."
  },
  State_36781_Desc = {
    Text = "Ketika kekuatan berkurang, hanya akan mengurangi 50% dari jumlah lapisan kekuatan."
  },
  State_36781_Name = {
    Text = "Keinginan Daging yang haus"
  },
  State_3678_Name = {
    Text = "Negara@Acara Relik1"
  },
  State_36797_Desc = {
    Text = "Dalam ronde ini, kerusakan tentakel berkurang sebesar [Layer] poin."
  },
  State_36797_Name = {
    Text = "Kerusakan tentakel berkurang"
  },
  State_3679_Name = {
    Text = "Negara@Acara_Relik2"
  },
  State_3680_Desc = {
    Text = "Setiap kali memberikan 1 Kerusakan, target akan diberi [Arg1] lapisan Racun. Jika jumlah pemicu dalam Pertempuran ini mencapai 25 kali, segera picu Racun pada seluruh musuh."
  },
  State_3681_Desc = {
    Text = "Saat menimbulkan kerusakan yang tidak diblokir, memberikan [DescArg1] tumpukan <BrokenCard:Sabotase Tersembunyi> pada 2 \"Kartu perintah\" acak."
  },
  State_3681_Name = {
    Text = "Jenkin Bangun!"
  },
  State_3681_WeaponDesc = {
    Text = "Pada ronde berikutnya, dapatkan perisai sejumlah kehilangan hidup dari ronde sebelumnya."
  },
  State_3682_Desc = {
    Text = "Setiap penurunan 10% Hidup, semua Pembangun mendapatkan 10 Aliemus. Setelah mati, tambahkan Kerusakan Tentakel."
  },
  State_3682_Name = {
    Text = "Inti Perak yang Terkubur Dalam"
  },
  State_3682_WeaponDesc = {
    Text = "Setiap penurunan 10% Hidup, semua Pembangun mendapatkan 10 Aliemus. Setelah mati, tambahkan Kerusakan Tentakel."
  },
  State_3683_Desc = {
    Text = "Tim Satu-satunya: Kartu perintah yang dipasang menghasilkan peningkatan penyembuhan <WeaponEffect_Num:[StateArg2]%>. Sebelum penyaji melepaskan\"Muliakan\", Pembangun lain mendapatkan <WeaponEffect_Num:[StateArg1]> poin Aliemus. Jika tim kita berada dalam status <VulnerabilityIconKeywords:Rentan>, efeknya berlipat ganda."
  },
  State_3683_WeaponDesc = {
    Text = "Peningkatan penyembuhan yang diberikan oleh Kartu perintah pemakai sebesar <WeaponEffect_Num:[StateArg2]%. Sebelum pemakai melepaskan Aliemus Burst, Awakener lainnya mendapatkan <WeaponEffect_Num:[StateArg1]> poin Aliemus. Jika tim kita berada dalam status <VulnerabilityIconKeywords:Vulnerable>, efek ini akan berlipat ganda."
  },
  State_3684_Desc = {
    Text = "Setiap menerima 1 poin Kerusakan, jumlah lapisan berkurang 1. Setelah jumlah lapisan menjadi 0, Niat akan diganti dengan Bunga Abadi, dan kelompok Keterampilan yang cenderung ke arah Pertahanan akan digunakan."
  },
  State_3684_Name = {
    Text = "Bunga Abadi"
  },
  State_3684_WeaponDesc = {
    Text = "Setiap kali menerima 1 poin Kerusakan, jumlah lapisan berkurang 1. Setelah jumlah lapisan menjadi 0, beralih ke Mode Pertahanan."
  },
  State_3685_Desc = {
    Text = "Kehilangan 1 Aritmetika saat diambil, tarik 1 kartu."
  },
  State_3685_Name = {
    Text = "Kehilangan arah"
  },
  State_3685_WeaponDesc = {
    Text = "Kehilangan 1 Aritmetika saat diambil, tarik 1 kartu."
  },
  State_3686_Desc = {
    Text = "Kehilangan 1 Aritmetika saat diambil, tarik 1 kartu."
  },
  State_3686_Name = {
    Text = "Segel Dimensi"
  },
  State_3686_WeaponDesc = {
    Text = "Kehilangan 1 Aritmetika saat diambil, tarik 1 kartu."
  },
  State_36884_Desc = {
    Text = "Sumpah terakhir dalam pertempuran ini tidak lagi dapat memperoleh perisai melalui pemicu aktif Ketahanan terhadap kematian."
  },
  State_36884_Name = {
    Text = "Sumpah Terakhir"
  },
  State_3688_Desc = {
    Text = "Ketika memainkan 2 kartu berturut-turut dengan konsumsi aritmetika lebih tinggi daripada kartu sebelumnya, dapatkan 2 aritmetika."
  },
  State_3688_Name = {
    Text = "Relik Arkana: Catatan"
  },
  State_3688_WeaponDesc = {
    Text = "Ketika memainkan 2 kartu berturut-turut dengan konsumsi aritmetika lebih tinggi daripada kartu sebelumnya, dapatkan 2 aritmetika."
  },
  State_3689_Desc = {
    Text = "Pada awal giliran, penguasaan alam meningkat sebesar 30. Ketika tidak berada dalam negara negatif, peningkatan penguasaan alam menjadi 100."
  },
  State_3692_Desc = {
    Text = "Kartu misterius dengan seribu bentuk. Pilihlah yang paling kamu butuhkan!"
  },
  State_3692_Name = {
    Text = "<CardKeyWord:Seribu bayangan>"
  },
  State_3692_WeaponDesc = {
    Text = "Kartu misterius dengan seribu bentuk. Pilihlah yang paling kamu butuhkan!"
  },
  State_3693_Desc = {
    Text = "Meningkatkan Crit. Rate sebesar 25%. Setelah menyebabkan pemulihan Hidup, ada kemungkinan untuk menyebabkan pemulihan Hidup tambahan sebanyak 1 kali, dengan probabilitas sama dengan Crit. Rate dari penyebab pemulihan."
  },
  State_3693_Name = {
    Text = "Negara@Kunci Perak: Kritis Sembuh"
  },
  State_3696_Desc = {
    Text = "Setiap kali memberikan 1 Kerusakan, dapatkan [Arg1] poin Waspada di babak ini. Pada awal babak, untuk setiap 3 poin Perisai yang tersisa, dapatkan 1 poin Kekuatan di babak ini."
  },
  State_3696_Name = {
    Text = "Pendulum Waktu \"Tersembunyi\""
  },
  State_3697_Desc = {
    Text = "Pada awal giliran, tarik 1 kartu. Saat memainkan 2 kartu berturut-turut dengan aritmetika yang sama seperti kartu sebelumnya, tarik 1 kartu tambahan."
  },
  State_3698_Desc = {
    Text = "Setelah dimainkan, tambahkan [StateArg1] salinan kartu ke <DimensionalSpaceIconKeywords:Ultra> sementara."
  },
  State_3698_Name = {
    Text = "<Rune_13:Teleportasi>"
  },
  State_3699_Name = {
    Text = "Sisa Inti Perak"
  },
  State_3700_Desc = {
    Text = "Meningkatkan [Layer]% Daya Serang."
  },
  State_3700_Name = {
    Text = "Persentase Daya Serang Sementara Meningkat"
  },
  State_3700_WeaponDesc = {
    Text = "Meningkatkan [Layer]% Daya Serang."
  },
  State_3702_Desc = {
    Text = "Negara@Umum mengubah Kesehatan maksimum"
  },
  State_3702_Name = {
    Text = "Negara@Umum mengubah Kesehatan maksimum"
  },
  State_3702_WeaponDesc = {
    Text = "Negara@Umum mengubah Kesehatan maksimum"
  },
  State_3703_Name = {
    Text = "Negara@Bab 4 Resonansi@Berlaku pada giliran berikutnya jumlah kartu yang diambil 2"
  },
  State_3704_Desc = {
    Text = "Penguasaan Alam meningkat sebesar 30. Saat memungut, pilih satu Relik dan gantikan dengan Relik acak."
  },
  State_3705_Name = {
    Text = "Mencerahkan Laut Bulan 3"
  },
  State_3707_Desc = {
    Text = "Setelah pertempuran dimulai, akan menyalin sementara [StateArg1] Kartu ke dalam tumpukan gambar, Kartu asli dan Kartu cermin semuanya mendapatkan Menjaga."
  },
  State_3707_Name = {
    Text = "<Rune_8:Cermin>"
  },
  State_3708_Desc = {
    Text = "Pada akhir ronde genap, setiap kartu tangan yang tersisa akan memberikan Anda 1 Aritmetika di awal ronde berikutnya."
  },
  State_3708_Name = {
    Text = "Relik Prelude 2"
  },
  State_3708_WeaponDesc = {
    Text = "Pada akhir ronde genap, setiap kartu tangan yang tersisa akan memberikan Anda 1 Aritmetika di awal ronde berikutnya."
  },
  State_3709_Desc = {
    Text = "Pada akhir ronde ganjil, setiap poin Aritmetika yang tersisa akan membuatmu mengambil 1 kartu di awal ronde berikutnya."
  },
  State_3709_Name = {
    Text = "Relik Prelude 1"
  },
  State_3709_WeaponDesc = {
    Text = "Pada akhir ronde ganjil, setiap poin Aritmetika yang tersisa akan membuatmu mengambil 1 kartu di awal ronde berikutnya."
  },
  State_3711_Desc = {
    Text = "Setiap tindakan menyebabkan [Layer] Berdarah"
  },
  State_3711_Name = {
    Text = "Cipratan darah"
  },
  State_3711_WeaponDesc = {
    Text = "Setiap tindakan menyebabkan [Layer] Berdarah, Sembuh dapat mengurangi setengah lapisan Berdarah."
  },
  State_3712_Desc = {
    Text = "Setelah memainkan kartu, kartu tersebut akan lelah, kartu perintah menghasilkan 3 kali kerusakan dan perlindungan, berlangsung selama 1 putaran."
  },
  State_3712_Name = {Text = "dissolusi"},
  State_3714_Desc = {
    Text = "Setelah digunakan, mendapatkan [StateArg1] poin Perisai."
  },
  State_3714_Name = {
    Text = "<Rune_6:Besi Pertahanan>"
  },
  State_3716_Desc = {
    Text = "Crit. Rate meningkat sebesar [Layer]% dalam pertempuran ini."
  },
  State_3716_Name = {Text = "Crit. Rate"},
  State_3719_Desc = {
    Text = "Saat menerima Active DMG, buat sumber kerusakan tentakel melakukan Counter, berlangsung selama [Layer] giliran."
  },
  State_3719_Name = {
    Text = "Garis Keturunan"
  },
  State_3720_Desc = {
    Text = "Meningkatkan [Layer] poin Pertahanan."
  },
  State_3720_Name = {
    Text = "Pertahanan umum meningkat"
  },
  State_3720_WeaponDesc = {
    Text = "Meningkatkan [Layer] poin Pertahanan."
  },
  State_3721_Desc = {
    Text = "Setelah dimainkan, kartu tidak akan masuk ke Tumpukan kartu buang, melainkan dihapus dari dek."
  },
  State_3721_Name = {Text = "Lelah"},
  State_3721_WeaponDesc = {
    Text = "Setelah digunakan, kartu tidak akan masuk ke tumpukan kartu buang dan tidak dapat digunakan kembali selama pertempuran ini."
  },
  State_3722_Desc = {
    Text = "Setiap kali memberikan kerusakan, secara sementara meningkatkan [StateArg1] kerusakan tentakel, hingga bertumpuk maksimal 5 kali. Saat jumlah tumpukan mencapai maksimum, 1 tentakel akan terbentuk."
  },
  State_3722_Name = {
    Text = "Tongkat Pendeta Penciptaan"
  },
  State_3722_WeaponDesc = {
    Text = "Setiap kali memberikan kerusakan, secara sementara meningkatkan [StateArg1] kerusakan tentakel, hingga bertumpuk maksimal 5 kali. Saat jumlah tumpukan mencapai maksimum, 1 tentakel akan terbentuk."
  },
  State_3723_Name = {
    Text = "Relik Cermin Hitam"
  },
  State_3724_Desc = {
    Text = "Kehilangan semua Relik lain saat diambil, secara acak mendapatkan 2 Relik emas."
  },
  State_3726_Name = {
    Text = "Belitan Mayat"
  },
  State_3728_Desc = {
    Text = "Pada awal pertempuran, dapatkan satu [Serangan]."
  },
  State_3728_Name = {
    Text = "Ikan Paus Meloncat Mencerahkan 1"
  },
  State_3728_WeaponDesc = {
    Text = "Pada awal pertempuran, dapatkan satu [Serangan]."
  },
  State_3730_Desc = {
    Text = "Negara@Monster Manis Jahat Ilusi Tragedi warna madu"
  },
  State_3730_Name = {
    Text = "Negara@Monster Manis Jahat Ilusi Tragedi warna madu"
  },
  State_3730_WeaponDesc = {
    Text = "Negara@Monster Manis Jahat Ilusi Tragedi warna madu"
  },
  State_3731_Desc = {
    Text = "Setiap kali tim kami berbelanja di toko, dalam pertempuran berikutnya, setiap putaran akan menarik 1 kartu tambahan dan mendapatkan 1 poin aritmetika."
  },
  State_3732_Desc = {
    Text = "Setiap 3 putaran, dapatkan 3 Tentakel sementara. Tentakel ini mengabaikan batas maksimum Tentakel."
  },
  State_3732_Name = {
    Text = "Relik Anggota Tanpa Nama"
  },
  State_3732_WeaponDesc = {
    Text = "Setiap 3 putaran, dapatkan 3 Tentakel sementara. Tentakel ini mengabaikan batas maksimum Tentakel."
  },
  State_3733_Desc = {
    Text = "Pada akhir ronde ganjil, sisa Aritmetika diubah menjadi kartu tambahan untuk Menggambar di ronde berikutnya; pada akhir ronde genap, sisa kartu di tangan diubah menjadi Aritmetika tambahan untuk ronde berikutnya."
  },
  State_3735_Name = {
    Text = "Jumlah lapisan \"Racun\" di tim kami berkurang menjadi setengah."
  },
  State_3738_Desc = {
    Text = "Pada akhir ronde, Fusi Embrio +15%, jika terdapat \"Embrio\" di tangan, pulihkan [Arg1] Hidup."
  },
  State_3738_Name = {
    Text = "Surat Diagnosis Wabah"
  },
  State_3739_Name = {
    Text = "Efek Bentuk Organik untuk Aksesori"
  },
  State_3739_WeaponDesc = {
    Text = "Setelah pemakai menggunakan Muliakan, efek Kuat dari Perisai dan Sembuh mereka akan dilipatgandakan dalam ronde ini."
  },
  State_3740_Name = {
    Text = "Negara@Penghitungan Kritikal Manis Jahat"
  },
  State_3741_Desc = {
    Text = "Pada awal ronde ke-3, tambahkan 1 kartu \"Gema Masa Lalu—Buang semua kartu di tangan, kembalikan hidup dan perisai saat ini ke kondisi pada akhir ronde sebelumnya. Tahan, lelah.\"ke tangan."
  },
  State_3742_Desc = {
    Text = "Setelah digunakan, semua musuh menjadi rentan selama [StateArg1] putaran."
  },
  State_3742_Name = {
    Text = "<Rune_1:Rentan>"
  },
  State_3743_Desc = {
    Text = "Setiap kartu ke-6 yang kamu mainkan akan berlaku 2 kali."
  },
  State_3743_Name = {
    Text = "Anggur Bintang Relik"
  },
  State_3744_Name = {
    Text = "Relik Memphis Ritual Mirror Count"
  },
  State_3747_Name = {
    Text = "Pilih 1 Kartu dari tumpukan Menggambar dan tambahkan ke tangan."
  },
  State_3748_Name = {
    Text = "Meningkatkan Crit. Rate sebesar [DescArg1]%, dan Crit. DMG sebesar [DescArg2]%"
  },
  State_3750_Name = {
    Text = "Kritikal sementara +[DescArg1]%. Dalam pertempuran ini, kerusakan dasar dari \"pemenggalan\" dan \"seribu bayangan\" meningkat 5%"
  },
  State_3751_Name = {
    Text = "Mendapatkan [StateArg1] poin <PowerIconKeywords:Kekuatan>"
  },
  State_3752_Name = {
    Text = "Mendapatkan <Posse:[DescArg1]> poin Energi-s. Mendapatkan <Block:[Block:StateArg1]> poin Perisai."
  },
  State_3753_Desc = {
    Text = "Kartu tidak akan masuk ke tumpukan kartu buang selama fase pembuangan, melainkan tetap berada di tangan."
  },
  State_3753_Name = {
    Text = "<RetainIconKeywords:Simpan>"
  },
  State_3753_WeaponDesc = {
    Text = "Kartu tidak akan masuk ke tumpukan kartu buang selama fase pembuangan, melainkan tetap berada di tangan."
  },
  State_3754_Desc = {
    Text = "Saat memberikan kerusakan aktif, tingkatkan kerusakan tentakel sebesar [Arg1] dalam ronde ini, dapat ditumpuk hingga 3 kali. Saat jumlah tumpukan mencapai maksimum, hasilkan 1 tentakel, dan akan dihilangkan setelah ronde berakhir."
  },
  State_3755_Desc = {
    Text = "Tim Satu-satunya: Penyaji meningkatkan perisai yang dihasilkan sebanyak <WeaponEffect_Num:[StateArg1]%>, pemulihan kehidupan meningkat sebanyak <WeaponEffect_Num:[StateArg1]%>. Pada akhir putaran ganjil, tingkat kritis penyaji + <WeaponEffect_Num:[StateArg2]%>, mendapatkan <WeaponEffect_Num:[StateArg3]> poin Aliemus; pada akhir putaran genap, kerusakan kritis penyaji + <WeaponEffect_Num:[StateArg2]%>, mendapatkan <WeaponEffect_Num:[StateArg4]> Energi-s. Jika alam saat ini adalah\"Caro\", maka batas pengumpulan Dapur merah meningkat <WeaponEffect_Num:[StateArg5]%>."
  },
  State_3755_WeaponDesc = {
    Text = "Perisai yang dihasilkan oleh pengguna meningkat <WeaponEffect_Num:[StateArg1]%>, pemulihan hidup meningkat <WeaponEffect_Num:[StateArg1]%>. Pada akhir putaran ganjil, tingkat kritis pengguna +<WeaponEffect_Num:[StateArg2]%>, mendapatkan <WeaponEffect_Num:[StateArg3]> poin aliemus; pada akhir putaran genap, kerusakan kritis pengguna +<WeaponEffect_Num:[StateArg2]%>, mendapatkan <WeaponEffect_Num:[StateArg4]> energi-s kunci perak. Jika alam saat ini adalah \"Caro\", maka batas akumulasi Dapur merah meningkat <WeaponEffect_Num:[StateArg5]%>."
  },
  State_3757_Desc = {
    Text = "Setiap kali tim kami memainkan 1 kartu, dapatkan [StateArg1] lapisan Perisai. Berlangsung selama 1 ronde."
  },
  State_3757_Name = {
    Text = "Bulu terbang di mana-mana"
  },
  State_3757_WeaponDesc = {
    Text = "Setiap kali tim kami memainkan 1 kartu, dapatkan [StateArg1] lapisan Perisai. Berlangsung selama 1 ronde."
  },
  State_3759_Name = {
    Text = "Senjata Mekanis 1"
  },
  State_3760_Desc = {
    Text = "Jika memiliki setidaknya [StateArg1] Segil hitam, [Muliakan] kehilangan [StateArg1] Segil hitam, rentan dan melemahkan semua musuh selama 1 putaran."
  },
  State_3760_Name = {
    Text = "Relik Burung Upacara Malapetaka"
  },
  State_3760_WeaponDesc = {
    Text = "Jika memiliki setidaknya [StateArg1] Segil hitam, [Muliakan] kehilangan [StateArg1] Segil hitam, rentan dan melemahkan semua musuh selama 1 putaran."
  },
  State_3761_Desc = {
    Text = "Setiap kali tim kami menarik 1 kartu Tertatih, dapatkan [Layer] poin Kekuatan."
  },
  State_3761_Name = {
    Text = "Ceremoni Lentera"
  },
  State_3761_WeaponDesc = {
    Text = "Setiap kali tim kami menarik 1 kartu Tertatih, dapatkan [Layer] poin Kekuatan."
  },
  State_3763_Desc = {
    Text = "Setiap kali Penyusup memberikan 1 kerusakan, Crit. DMG di babak ini meningkat sebesar [StateArg3]%."
  },
  State_3763_Name = {
    Text = "Lorong dilipat"
  },
  State_3763_WeaponDesc = {
    Text = "Setiap kali Penyusup memberikan 1 kerusakan, Crit. DMG di babak ini meningkat sebesar [StateArg3]%."
  },
  State_3764_Name = {
    Text = "Senjata Mekanik 2"
  },
  State_3766_Name = {
    Text = "Tambahkan pengganda Kekuatan Merah"
  },
  State_3767_Desc = {
    Text = "Pada awal giliran, berikan [Arg1] kerusakan kepada satu musuh acak. Setelah mengeluarkan \"Serangan\" sebanyak 7 kali dalam pertempuran ini, kerusakan yang diberikan akan berubah menjadi [Arg2]."
  },
  State_3767_Name = {
    Text = "Puzzle Usang"
  },
  State_3768_Desc = {
    Text = "Kerusakan aktif yang diterima pasti akan menjadi kritis, dan efek ini akan dihilangkan setelah giliran berakhir."
  },
  State_3768_Name = {Text = "Falter"},
  State_3768_WeaponDesc = {
    Text = "Kerusakan aktif yang diterima pasti akan menjadi kritis, dan efek ini akan dihilangkan setelah giliran berakhir."
  },
  State_3770_Name = {
    Text = "Relik Arkana Penciptaan"
  },
  State_3771_Desc = {
    Text = "Pada awal pertempuran, dapatkan 3 poin Aritmetika."
  },
  State_3772_Desc = {
    Text = "Setiap kali Pedang Balas Dendam memberikan 1 Kerusakan, tingkatkan Kekuatan sementara yang setara dengan Kerusakan tentakel saat ini."
  },
  State_3772_Name = {
    Text = "Balas Dendam yang Disiapkan"
  },
  State_3773_Desc = {
    Text = "Saat giliran berakhir, menerima <FixedDamage:Kerusakan Murni> sebesar jumlah stacks yang setara."
  },
  State_3773_Name = {
    Text = "<IntoxicationIconKeywords:Racun>"
  },
  State_3773_WeaponDesc = {
    Text = "Menerima kerusakan saat giliran dimulai."
  },
  State_3774_Desc = {
    Text = "Setiap kali melepaskan Aliemus Muliakan, dapatkan satu kartu \"Infeksi Racun\" yang dapat memberikan [Arg1] poin Racun. Pada akhir ronde, jika terdapat setiap 3 kartu \"Infeksi Racun\" di tangan, mereka dapat digabungkan menjadi satu kartu \"Serangan Racun\" yang memicu Racun."
  },
  State_3776_Desc = {
    Text = "Setiap kali menerima kerusakan aktif, tambahkan satu lapisan \"Kewaspadaan\". Saat \"Kewaspadaan\" mencapai 3 lapisan, mundur."
  },
  State_3776_Name = {
    Text = "Boneka penakut"
  },
  State_3776_WeaponDesc = {
    Text = "Setiap kali menerima kerusakan aktif, tambahkan satu lapisan \"Kewaspadaan\". Saat \"Kewaspadaan\" mencapai 3 lapisan, mundur."
  },
  State_3777_Desc = {
    Text = "Setelah digunakan, Pembangun yang dimiliki mendapatkan [StateArg1] poin Aliemus."
  },
  State_3777_Name = {
    Text = "<Rune_5_High:Kegilaan Tinggi>"
  },
  State_3777_WeaponDesc = {
    Text = "Setelah digunakan, Pembangun yang dimiliki mendapatkan [StateArg1] poin Aliemus."
  },
  State_3778_Desc = {
    Text = "Kerusakan terhadap musuh dalam kondisi negara meningkat sebesar 25%, setelah membunuh musuh, pembunuh mendapatkan 20 Aliemus."
  },
  State_3779_Desc = {
    Text = "Mengurangi batas Tentakel sebanyak 2. Pada akhir ronde, semua Tentakel akan melakukan Serangan 1 kali tambahan."
  },
  State_3779_Name = {
    Text = "Relik Penderitaan Suci"
  },
  State_3779_WeaponDesc = {
    Text = "Mengurangi batas Tentakel sebanyak 2. Pada akhir ronde, semua Tentakel akan melakukan Serangan 1 kali tambahan."
  },
  State_3781_Desc = {
    Text = "Pada awal ronde, terapkan \"Kutukan Beku\" pada 2 kartu teratas dari tumpukan kartu."
  },
  State_3781_Name = {
    Text = "\"Mata Kutukan Jurang\""
  },
  State_3781_WeaponDesc = {
    Text = "Pada awal ronde, terapkan \"Kutukan Beku\" pada 2 kartu teratas dari tumpukan kartu."
  },
  State_3782_Desc = {
    Text = "Satu-satunya di tim: Saat eksplorasi dimulai, tambahkan satu kartu \"Pertahanan\" pemakai ke dalam dek. Perisai \"Pertahanan\" pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3782_WeaponDesc = {
    Text = "Saat eksplorasi dimulai, tambahkan satu kartu \"Pertahanan\" pemakai ke dalam dek. Perisai \"Pertahanan\" pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3783_Desc = {
    Text = "Satu-satunya Tim: Kerusakan dasar Muliakan meningkat sebesar <WeaponEffect_Num:[StateArg1]%>, Perisai dan pemulihan Hidup meningkat sebesar <WeaponEffect_Num:[StateArg2]%>."
  },
  State_3783_WeaponDesc = {
    Text = "Peningkatan kerusakan dasar Muliakan sebesar <WeaponEffect_Num:[StateArg1]%>, dan peningkatan pemulihan perisai dan hidup sebesar <WeaponEffect_Num:[StateArg2]%>."
  },
  State_3784_Desc = {
    Text = "Satu-satunya di tim: Kerusakan dasar Kartu Perintah pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>, Perisai dan pemulihan Hidup meningkat sebesar <WeaponEffect_Num:[StateArg2]%>."
  },
  State_3784_WeaponDesc = {
    Text = "Kerusakan dasar Kartu perintah pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>, dan peningkatan Perisai serta pemulihan Hidup sebesar <WeaponEffect_Num:[StateArg2]%>."
  },
  State_3786_Desc = {
    Text = "Kamu terkunci! Setelah memukul, semua monster mendapatkan [StateArg1] poin Kekuatan sementara, dan tanda Deep Dive dari instruksi ini akan dihapus."
  },
  State_3786_Name = {
    Text = "<CardKeyWord:Tanda Penyelaman Dalam>"
  },
  State_3786_WeaponDesc = {
    Text = "Setelah kartu dimainkan, Penyelam Dalam memperoleh [StateArg1] poin Kekuatan sementara."
  },
  State_3787_Desc = {
    Text = "Satu-satunya Tim: Setelah pemakai melepaskan Muliakan, semua sekutu mendapatkan <WeaponEffect_Num:[StateArg1]> Aliemus."
  },
  State_3787_WeaponDesc = {
    Text = "Setelah pemakai melepaskan Muliakan, semua sekutu mendapatkan <WeaponEffect_Num:[StateArg1]> Aliemus."
  },
  State_3788_Desc = {
    Text = "Satu-satunya Tim: Saat eksplorasi dimulai, tambahkan satu \"Serangan\" pemakai ke dalam dek, kerusakan dasar \"Serangan\" pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3788_WeaponDesc = {
    Text = "Saat eksplorasi dimulai, tambahkan satu kartu \"Serangan\" pemakai ke dalam dek, kerusakan dasar \"Serangan\" pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3790_Desc = {
    Text = "Negara@Jumlah Zat Tidak Pasti"
  },
  State_3790_Name = {
    Text = "Negara@Jumlah Zat Tidak Pasti"
  },
  State_3790_WeaponDesc = {
    Text = "Negara@Jumlah Zat Tidak Pasti"
  },
  State_3791_Desc = {
    Text = "Setiap kali memberikan kerusakan, dapatkan [Arg1] poin perisai, dapat ditumpuk hingga 5 kali per ronde. Saat jumlah tumpukan mencapai maksimum, kartu \"Inspirasi\" akan dimasukkan ke tangan."
  },
  State_3792_Desc = {
    Text = "Tidak lagi terpengaruh oleh petrifikasi."
  },
  State_3792_Name = {
    Text = "Ketahanan terhadap petrifikasi"
  },
  State_3792_WeaponDesc = {
    Text = "Tidak lagi terkena efek petrifikasi, namun menerima tiga kali lipat kerusakan."
  },
  State_3793_Desc = {
    Text = "Crit. DMG dalam level ini meningkat sebesar [Layer]%."
  },
  State_3793_Name = {
    Text = "Kerusakan Kritikal Permanen"
  },
  State_3793_WeaponDesc = {
    Text = "Crit. DMG dalam level ini meningkat sebesar [Layer]%."
  },
  State_3794_Desc = {
    Text = "Kerusakan, perisai, dan sembuh yang dilakukan oleh pengguna meningkat [StateArg1]%。（Sementara）"
  },
  State_3794_Name = {
    Text = "Negara@Pedang Panjang Uji Coba Kerusakan Ledakan"
  },
  State_3796_Desc = {
    Text = "Setiap penurunan 20% Hidup, semua Pembangun mendapatkan 10 Aliemus. Setelah kematian, tambahkan Kerusakan tentakel."
  },
  State_3796_Name = {
    Text = "Partikel Perak Terpisah"
  },
  State_3796_WeaponDesc = {
    Text = "Setiap penurunan 20% Hidup, semua Pembangun mendapatkan 10 Aliemus. Setelah kematian, tambahkan Kerusakan tentakel."
  },
  State_3797_Desc = {
    Text = "Setiap kali menerima kerusakan, dapatkan [StateArg1] poin kekuatan sementara, yang akan dihilangkan pada awal giliran."
  },
  State_3797_Name = {
    Text = "Kemarahan Gerombolan Tikus!"
  },
  State_37980_Desc = {
    Text = "Dalam pertempuran ini, penguasaan alam meningkat sebesar [Layer]."
  },
  State_37980_Name = {
    Text = "Realm Mastery"
  },
  State_3798_Desc = {
    Text = "Setelah menyebabkan kerusakan, akan memulihkan hidup."
  },
  State_3798_Name = {
    Text = "Bilah Vampir"
  },
  State_3798_WeaponDesc = {
    Text = "Setelah menyebabkan kerusakan, akan memulihkan hidup."
  },
  State_3799_Desc = {
    Text = "Untuk setiap [Caro] Pembangun di tim, Kesehatan maksimum (belum selesai), Pertahanan, dan Serangan seluruh tim meningkat sebesar 50%."
  },
  State_3799_Name = {Text = "Bonus Caro"},
  State_3799_WeaponDesc = {
    Text = "Untuk setiap [Caro] Pembangun di tim, Kesehatan maksimum (belum selesai), Pertahanan, dan Serangan seluruh tim meningkat sebesar 50%."
  },
  State_3800_Desc = {
    Text = "Menyebabkan kerusakan kepada semua musuh. <CardKeyWord:Kekuatan> memberikan efek berkali lipat pada kerusakan ini."
  },
  State_3800_Name = {
    Text = "<CardKeyWord:Kekuatan pedang besar>"
  },
  State_3801_Desc = {
    Text = "Saat menyebabkan kerusakan yang tidak terblokir, tambahkan [StateArg1] lapisan berdarah."
  },
  State_3801_Name = {
    Text = "Mengeluarkan darah"
  },
  State_3802_Desc = {
    Text = "Saat berada di tangan, setiap kali menggunakan 1 Kartu Perintah, kartu tersebut akan berubah menjadi salinannya dengan Aritmetika 0."
  },
  State_3802_Name = {
    Text = "<CardKeyWord:Anak yang Suci>"
  },
  State_3802_WeaponDesc = {
    Text = "Saat berada di tangan, setiap kali menggunakan 1 kartu, kartu tersebut berubah menjadi salinannya dengan Aritmetika bernilai 0."
  },
  State_3803_Desc = {
    Text = "Pada awal pertempuran, semua kartu kamu yang saat ini memiliki konsumsi aritmetika sebesar 1 akan meningkatkan kerusakan, perisai, dan sembuh sebesar [Arg1] poin selama pertempuran ini."
  },
  State_3804_Desc = {
    Text = "Penghitungan Trisula Asing"
  },
  State_3804_Name = {
    Text = "Penghitungan Trisula Asing"
  },
  State_3804_WeaponDesc = {
    Text = "Penghitungan Trisula Asing"
  },
  State_3807_Name = {
    Text = "Mimpi Aksesori untuk Menjadi Obat"
  },
  State_3807_WeaponDesc = {
    Text = "Setelah pertempuran dimulai, satu set kartu pemain akan dicampurkan ke dalam tumpukan menggambar secara tambahan."
  },
  State_3808_Desc = {
    Text = "Negara@Umum mengubah Hidup saat ini"
  },
  State_3808_Name = {
    Text = "Negara@Umum mengubah Hidup saat ini"
  },
  State_3808_WeaponDesc = {
    Text = "Negara@Umum mengubah Hidup saat ini"
  },
  State_3810_Desc = {
    Text = "Setelah kematian, kekuatan sekutu lainnya meningkat."
  },
  State_3810_Name = {
    Text = "bahasa mati"
  },
  State_3811_Desc = {
    Text = "Negara@Pendahuluan_Reset_Deck0_1_4_1"
  },
  State_3811_Name = {
    Text = "Negara@Pendahuluan_Reset_Deck0_1_4_1"
  },
  State_3811_WeaponDesc = {
    Text = "Negara@Pendahuluan_Reset_Deck0_1_4_1"
  },
  State_3813_Name = {
    Text = "Imun terhadap kelemahan"
  },
  State_3815_Desc = {
    Text = "Pada akhir ronde, semua Awakener kehilangan [Layer] poin Aliemus."
  },
  State_3815_Name = {
    Text = "<EnergyColour:Kekosongan>"
  },
  State_3815_WeaponDesc = {
    Text = "Mendapatkan penurunan Aliemus sebesar [Layer]%."
  },
  State_3817_Desc = {
    Text = "Pada awal ronde, sebabkan [DescArg1] poin kelelahan pada lawan."
  },
  State_3817_Name = {Text = "Dispersi"},
  State_3817_WeaponDesc = {
    Text = "Pada awal ronde, tim kami mendapatkan [DescArg1*Layer*0.01] tingkat kelelahan."
  },
  State_3818_Name = {
    Text = "Negara@Mencerahkan1"
  },
  State_3819_Name = {
    Text = "Pemecah Rantai Mencerahkan 1"
  },
  State_3819_WeaponDesc = {
    Text = "Imitasi Penjelajah Kuno"
  },
  State_3821_Desc = {
    Text = "Pada awal ronde, dapatkan perisai sebesar setengah dari hidup yang hilang di ronde sebelumnya."
  },
  State_3821_Name = {
    Text = "Penderitaan dan Kesenangan"
  },
  State_3821_WeaponDesc = {
    Text = "Pada ronde berikutnya, dapatkan perisai sejumlah kehilangan hidup dari ronde sebelumnya."
  },
  State_3824_Desc = {
    Text = [[
Tim Unik: Kerusakan dasar Muliakan pemakai meningkat sebesar [StateArg1]%. Saat eksplorasi dimulai, pemakai memasuki status kepribadian Sarjana. Setelah pemakai melepaskan Muliakan, mereka beralih antara kepribadian Sarjana dan Badut. 
Kepribadian Sarjana: Di akhir giliran, pemakai mendapatkan <WeaponEffect_Num:[StateArg2]> poin Aliemus. 
Kepribadian Badut: Di akhir giliran, Crit. Rate dan Crit. DMG pemakai <WeaponEffect_Num:+[StateArg3]%.]]
  },
  State_3824_WeaponDesc = {
    Text = [[
Peningkatan kerusakan dasar Muliakan pemakai sebesar [StateArg1]%. Saat eksplorasi dimulai, pemakai memasuki status kepribadian Sarjana. Setelah pemakai melepaskan Muliakan, mereka akan beralih antara kepribadian Sarjana dan Badut. 
Kepribadian Sarjana: Di akhir giliran, pemakai mendapatkan <WeaponEffect_Num:[StateArg2]> poin Aliemus. 
Kepribadian Badut: Di akhir giliran, Crit. Rate dan Crit. DMG pemakai meningkat sebesar <WeaponEffect_Num:+[StateArg3]%. .]]
  },
  State_3825_Desc = {
    Text = "Saat menerima Active DMG, berikan <FixedDamage:Kerusakan Murni> kepada sumber kerusakan sebesar jumlah stacks yang setara."
  },
  State_3825_Name = {
    Text = "<RetaliateIconKeywords: Counter>"
  },
  State_3825_WeaponDesc = {
    Text = "Setiap kali menerima Active DMG, berikan <FixedDamage:Kerusakan Murni> kepada penyerang."
  },
  State_3826_Name = {
    Text = "Negara@Kunci Perak: Hitungan ledakan"
  },
  State_3827_Desc = {
    Text = "Satu-satunya di tim: Pemulihan Hidup pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah melepaskan Muliakan, pada awal giliran berikutnya pulihkan <WeaponEffect_Num:[StateArg2]%> dari Hidup yang hilang."
  },
  State_3827_WeaponDesc = {
    Text = "Pemulihan hidup pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah melepaskan Muliakan, pada giliran berikutnya di awal giliran, pulihkan <WeaponEffect_Num:[DescArg1]%> dari total hidup yang telah hilang."
  },
  State_3830_Name = {
    Text = "Berlaku tambahan 1 kali"
  },
  State_3831_Name = {
    Text = "Relik Balik Akar"
  },
  State_3834_Desc = {
    Text = "Efek Racun yang disebabkan oleh Laba-laba Labirin menjadi dua kali lipat."
  },
  State_3834_Name = {
    Text = "Perjalanan yang tersesat"
  },
  State_3835_Desc = {
    Text = "Crit. DMG meningkat sebesar [Layer]% dalam putaran ini."
  },
  State_3835_Name = {
    Text = "Crit. DMG Sementara"
  },
  State_3835_WeaponDesc = {
    Text = "Crit. DMG meningkat sebesar [Layer]% dalam putaran ini."
  },
  State_3836_Desc = {Text = "Tes123"},
  State_3836_Name = {Text = "Tes123"},
  State_3837_Desc = {
    Text = "Tim Unik: Aliemus yang diberikan Pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>, Racun yang diberikan meningkat sebesar <WeaponEffect_Num:[StateArg2]%>. Setelah Pemakai memberikan Active DMG, Kerusakan Kritis Sementara semua Awakener meningkat dengan nilai setara <WeaponEffect_Num:[StateArg3]%> dari Crit. DMG dasar Pemakai, maksimal berlaku 1 kali per ronde. Jika Realm saat ini adalah \"Aequor\", saat pertempuran dimulai, Batasan Tentakel dan Tentacle Count +1."
  },
  State_3837_WeaponDesc = {
    Text = "Aliemus yang diberikan Pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>, Racun yang diberikan meningkat sebesar <WeaponEffect_Num:[StateArg2]%>. Setelah Pemakai memberikan Active DMG, Kerusakan Kritis Sementara semua Awakener +<WeaponEffect_Num:[DescArg1]%>, maksimal berlaku 1 kali per ronde. Jika Realm saat ini adalah \"Aequor\", saat pertempuran dimulai, Batasan Tentakel dan Tentacle Count +1."
  },
  State_3839_Desc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1] Kekuatan untuk setiap 1 Kartu gejala di dek. Semua Kartu gejala Anda mendapatkan Ilusi."
  },
  State_3840_Desc = {
    Text = "Setiap kali nilai hidup berkurang, dapatkan [StateArg1] Waspada."
  },
  State_3840_Name = {Text = "Waspada"},
  State_3842_Desc = {
    Text = "Active DMG dan Kerusakan tentakel yang ditimbulkan berkurang [DescArg1] %."
  },
  State_3842_Name = {Text = "Weakness"},
  State_3842_WeaponDesc = {
    Text = "Semua kerusakan yang ditimbulkan berkurang sebesar [DescArg1]%."
  },
  State_3843_Desc = {
    Text = "Setiap tindakan memberikan tambahan [Layer] Berdarah"
  },
  State_3843_Name = {
    Text = "Severe Injury"
  },
  State_3843_WeaponDesc = {
    Text = "Setiap tindakan memberikan tambahan [Layer] Berdarah, Sembuh dapat menghilangkan efek Berdarah."
  },
  State_3844_Desc = {
    Text = "Jumlah semua kerusakan Whale Leap +1."
  },
  State_3844_Name = {
    Text = "Penggila Perang"
  },
  State_3844_WeaponDesc = {
    Text = "Jumlah semua kerusakan Whale Leap +1."
  },
  State_3845_Desc = {
    Text = "Kekuatan aritmetika kartu berkurang"
  },
  State_3845_Name = {
    Text = "Kekuatan aritmetika kartu berkurang"
  },
  State_3845_WeaponDesc = {
    Text = "Kekuatan aritmetika kartu berkurang"
  },
  State_3846_Name = {
    Text = "Relik Giok Hijau Penciptaan"
  },
  State_3848_Desc = {
    Text = "Dalam pertempuran ini, satu Muliakan dari Pembangun acak telah disegel dan tidak dapat digunakan."
  },
  State_3848_Name = {Text = "Sealed"},
  State_3850_Desc = {
    Text = "Setiap kali memainkan kartu ke-[StateArg1], tingkatkan [StateArg2] kerusakan tentakel, dan buat semua serangan tentakel menyerang satu kali."
  },
  State_3850_Name = {
    Text = "Trisula Alienasi"
  },
  State_3850_WeaponDesc = {
    Text = "Setiap kali memainkan kartu ke-[StateArg1], tingkatkan [StateArg2] kerusakan tentakel, dan buat semua serangan tentakel menyerang satu kali."
  },
  State_3851_Name = {
    Text = "Aksesori Teater Kucing"
  },
  State_3851_WeaponDesc = {
    Text = "Semua kerusakan yang ditimbulkan meningkat, dengan nilai peningkatan sama dengan 10% dari kesehatan maksimum pemakai."
  },
  State_3852_Desc = {
    Text = "Kerusakan gigitan bertambah sebanyak [Layer]."
  },
  State_3852_Name = {
    Text = "Gigitan Meningkat"
  },
  State_3852_WeaponDesc = {
    Text = "Kerusakan gigitan bertambah sebanyak [Layer]."
  },
  State_3853_Desc = {
    Text = "Pada awal ronde, berubah secara acak menjadi salinan dari salah satu kartu perintah di tumpukan menggambar, konsumsi lelah aritmetikanya tetap 3, dan kembali ke bentuk semula pada akhir ronde."
  },
  State_3853_Name = {
    Text = "<CardKeyWord:Delirium>"
  },
  State_3853_WeaponDesc = {
    Text = "Kartu tidak akan masuk ke tumpukan kartu buang selama fase pembuangan, melainkan tetap berada di tangan."
  },
  State_3854_Desc = {
    Text = "Ambil 2 kartu, namun ini juga akan menarik perhatian Pemburu Tengkorak."
  },
  State_3854_Name = {
    Text = "<CardKeyWord:Diburu>"
  },
  State_3855_Name = {Text = "Kekuatan"},
  State_3856_Desc = {
    Text = "Negara@Pendahuluan_Reset_Deck0_1_3_1"
  },
  State_3856_Name = {
    Text = "Negara@Pendahuluan_Reset_Deck0_1_3_1"
  },
  State_3856_WeaponDesc = {
    Text = "Negara@Pendahuluan_Reset_Deck0_1_3_1"
  },
  State_3859_Desc = {
    Text = "Nafas Kemakmuran memberikan dua kali lipat Aliemus."
  },
  State_3859_Name = {Text = "Ibu"},
  State_3859_WeaponDesc = {
    Text = "Nafas Kemakmuran memberikan dua kali lipat Aliemus."
  },
  State_3860_Desc = {
    Text = "Kerusakan, perisai, dan sembuh yang dilakukan oleh pengguna meningkat [StateArg1]%。（Sementara）"
  },
  State_3860_Name = {
    Text = "Negara@Prototipe Pisau Kecil Keberuntungan"
  },
  State_3862_Name = {
    Text = "Negara@Level2_15Pertempuran4Gelembung1"
  },
  State_3863_Desc = {
    Text = "Setelah melepaskan 3 kali Muliakan, Lelah Aritmetika dari semua kartu di tangan berkurang sebesar 1."
  },
  State_3866_Desc = {
    Text = "Dalam ronde ini, batas kartu tangan +[Layer]."
  },
  State_3866_Name = {
    Text = "Batas kartu tangan ditingkatkan"
  },
  State_3867_Name = {
    Text = "Penghitung Profesi Ultra"
  },
  State_3868_Desc = {
    Text = "Perisai yang diberikan dalam ronde ini meningkat sebesar [Layer] poin."
  },
  State_3868_Name = {
    Text = "Kewaspadaan Sementara"
  },
  State_3868_WeaponDesc = {
    Text = "Perisai yang diberikan dalam ronde ini meningkat sebesar [Layer] poin."
  },
  State_3872_Desc = {
    Text = "Menerima kerusakan akan membatalkan kekuatan sementara."
  },
  State_3872_Name = {Text = "Falter"},
  State_38730_Desc = {
    Text = "Setelah ronde dimulai, ada [DescArg1]% kemungkinan mendapatkan 1 lapisan Pengumpulan Tentakel. Jika melebihi 100%, beberapa lapisan dapat diperoleh."
  },
  State_38730_Name = {
    Text = "Garis kembali"
  },
  State_38735_Desc = {
    Text = "Active DMG yang ditimbulkan berkurang [StateArg1]%, jumlah serangan berlipat ganda, berlangsung selama [Layer] giliran."
  },
  State_38735_Name = {Text = "Delirium"},
  State_38738_Desc = {
    Text = "Maksimal 10 lapisan, dapat diwariskan ke pertempuran berikutnya."
  },
  State_38738_Name = {Text = "Dreamlure"},
  State_3873_Desc = {
    Text = "Dalam pertempuran ini, penguasaan alam meningkat sebesar [Layer] poin."
  },
  State_3873_Name = {
    Text = "Realm Mastery"
  },
  State_3874_Name = {
    Text = "Negara@Kartu Angin Pemulihan"
  },
  State_3876_Desc = {
    Text = "Setiap putaran genap mengurangi Kekuatan tim kami."
  },
  State_3876_Name = {
    Text = "\"Lubang Mimpi Kematian\""
  },
  State_3878_Desc = {
    Text = "Setiap kehilangan 2 poin Hidup, dapatkan [Layer] poin Perisai di awal giliran berikutnya."
  },
  State_3878_Name = {
    Text = "Penderitaan dan Kesenangan"
  },
  State_3878_WeaponDesc = {
    Text = "Pada ronde berikutnya, dapatkan perisai sejumlah kehilangan hidup dari ronde sebelumnya."
  },
  State_3879_Desc = {
    Text = "Mengambilnya akan meningkatkan Kesehatan maksimum sebesar [Arg1] poin. Jika Hidup saat diambil berada di bawah 25%, peningkatan Kesehatan maksimum menjadi [Arg2] poin."
  },
  State_3881_Desc = {
    Text = "Negara@Monster George memakan patung lilin kecil"
  },
  State_3881_Name = {
    Text = "Negara@Monster George memakan patung lilin kecil"
  },
  State_3881_WeaponDesc = {
    Text = "Negara@Monster George memakan patung lilin kecil"
  },
  State_3882_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_3882_Name = {Text = "Not Roused"},
  State_3883_Desc = {
    Text = "Crit. Rate dalam level ini meningkat sebesar [Layer]%."
  },
  State_3883_Name = {
    Text = "Tingkat Kritikal Permanen"
  },
  State_3883_WeaponDesc = {
    Text = "Crit. Rate dalam level ini meningkat sebesar [Layer]%."
  },
  State_3884_Desc = {
    Text = "Setiap putaran menghasilkan tambahan 1 Fusi Embrio. Semua Efek Melahap milikmu berubah menjadi Melahap Tanpa Batas."
  },
  State_3884_Name = {
    Text = "Pusar Berdenyut Relik"
  },
  State_3884_WeaponDesc = {
    Text = "Setiap putaran menghasilkan tambahan 1 Fusi Embrio. Semua Efek Melahap milikmu berubah menjadi Melahap Tanpa Batas."
  },
  State_3888_Desc = {
    Text = "Tidak dapat melepaskan Muliakan, hapus 1 lapisan Aliemus saat giliran berakhir."
  },
  State_3888_Name = {
    Text = "<CardKeyWord:Segel>"
  },
  State_3888_WeaponDesc = {
    Text = "Semua Pembangun tidak dapat menggunakan Muliakan."
  },
  State_3890_Name = {
    Text = "Mengambil +[DescArg1] kartu buangan"
  },
  State_3893_Desc = {
    Text = "Mendapatkan [Arg1] poin perisai saat memberikan kerusakan. Saat memulihkan hidup, mendapatkan [Arg2] poin kekuatan sementara."
  },
  State_3893_Name = {Text = "Rumah Kita"},
  State_3894_Desc = {
    Text = "Sebelum fase pembuangan, ubah kartu di tangan menjadi batu."
  },
  State_3894_Name = {Text = "Petrify"},
  State_3894_WeaponDesc = {
    Text = "Sebelum fase pembuangan, ubah kartu di tangan menjadi batu."
  },
  State_3895_Desc = {
    Text = "Crit. Rate meningkat sebesar [Layer]% dalam ronde ini."
  },
  State_3895_Name = {
    Text = "Crit. Rate Sementara"
  },
  State_3895_WeaponDesc = {
    Text = "Crit. Rate meningkat sebesar [Layer]% dalam ronde ini."
  },
  State_3898_Desc = {
    Text = "Pada awal ronde berikutnya, dapatkan [Layer] poin Perisai."
  },
  State_3898_Name = {
    Text = "Perisai Penderitaan dan Kesenangan"
  },
  State_3900_Name = {
    Text = "Kartu disegel, tidak dapat dimainkan. Segel terbuka saat dibuang."
  },
  State_3901_Name = {
    Text = "Relik Pendeta: Penghitungan Tongkat"
  },
  State_3902_Desc = {
    Text = "Kerusakan aktif yang dihasilkan dalam ronde ini berkurang sebesar [Layer] poin."
  },
  State_3902_Name = {Text = "STR▼"},
  State_3902_WeaponDesc = {
    Text = "Kerusakan yang diberikan dalam ronde ini berkurang sebesar [Layer] poin."
  },
  State_3904_Desc = {
    Text = "Setiap kehilangan 1 poin Hidup, hilangkan 1 lapisan. Ketika jumlah lapisan menjadi 0, dapatkan [StateArg1] Perisai, dan kembalikan [StateArg2] lapisan Penghalang Darah."
  },
  State_3904_Name = {
    Text = "Bangun - Penghalang Darah"
  },
  State_3905_Desc = {
    Text = "Setiap kali menerima Active DMG, berikan [Layer] poin <FixedDamage:Kerusakan Murni> kepada sumber kerusakan."
  },
  State_3905_Name = {Text = "Counter"},
  State_3905_WeaponDesc = {
    Text = "Setiap kali menerima Active DMG, berikan [Layer] poin <FixedDamage:Kerusakan Murni> kepada penyerang."
  },
  State_3906_Name = {
    Text = "Sisa Inti Perak"
  },
  State_3907_Name = {
    Text = "Sisa Inti Perak"
  },
  State_3908_Desc = {
    Text = "Ketika Otak dalam Toples memberikan penyembuhan, tarik [Arg2] kartu."
  },
  State_3908_Name = {
    Text = "Dua Sifat Kehidupan dan Ilusi"
  },
  State_3908_WeaponDesc = {
    Text = "Ketika Otak dalam Toples memberikan penyembuhan, tarik [Arg2] kartu."
  },
  State_3909_Name = {
    Text = "Sisa Inti Perak"
  },
  State_3910_Name = {
    Text = "Sisa Inti Perak"
  },
  State_3911_Name = {
    Text = "Sisa Inti Perak"
  },
  State_3912_Name = {
    Text = "Sisa Inti Perak"
  },
  State_3913_Desc = {
    Text = "Tim Unik: Perisai yang dihasilkan oleh pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Di awal putaran, pertahankan <WeaponEffect_Num:[StateArg2]%> dari sisa perisai, perisai yang dipertahankan tidak boleh melebihi <WeaponEffect_Num:[StateArg3]%> dari Max HP."
  },
  State_3913_WeaponDesc = {
    Text = "Perisai yang diberikan oleh pemakai meningkat <WeaponEffect_Num:[StateArg1]%>. Di awal giliran, Pertahankan <WeaponEffect_Num:[StateArg2]%> sisa perisai, perisai yang dipertahankan maksimum <WeaponEffect_Num:[StateArg3]%> perisai maksimum HP."
  },
  State_3914_Desc = {
    Text = "Setelah melepaskan Muliakan kedua kalinya per ronde, semua Pembangun mendapatkan 10 poin Aliemus. Setelah melepaskan Muliakan ketiga kalinya per ronde, semua Pembangun mengalami reset pendinginan Aliemus dan mendapatkan 10 poin Aliemus."
  },
  State_3915_Name = {
    Text = "Sisa Inti Perak"
  },
  State_3916_Name = {
    Text = "Sisa Inti Perak"
  },
  State_3917_Desc = {
    Text = "Tambahkan kekuatan sementara pada ronde berikutnya"
  },
  State_3917_Name = {Text = "Charge"},
  State_3918_Desc = {
    Text = "Pada awal setiap ronde, dapatkan status kerusakan pertama yang diterima menjadi dua kali lipat."
  },
  State_3918_Name = {
    Text = "Kepercayaan diri"
  },
  State_3918_WeaponDesc = {
    Text = "Pada awal setiap ronde, dapatkan status kerusakan pertama yang diterima menjadi dua kali lipat."
  },
  State_3921_Desc = {
    Text = "Kartu pada ronde ini tidak akan masuk ke tumpukan kartu buang selama fase pembuangan, melainkan tetap berada di tangan."
  },
  State_3921_Name = {
    Text = "<RetainIconKeywords:Simpan>"
  },
  State_3921_WeaponDesc = {
    Text = "Kartu tidak akan masuk ke tumpukan kartu buang selama fase pembuangan, melainkan tetap berada di tangan."
  },
  State_3923_Desc = {
    Text = "Kekuatan aritmetika kartu berkurang"
  },
  State_3923_Name = {
    Text = "Penurunan Aritmetika Kartu Permanen"
  },
  State_3923_WeaponDesc = {
    Text = "Kekuatan aritmetika kartu berkurang"
  },
  State_3925_Name = {
    Text = "Negara@Bab 4 Resonansi@Awal giliran tim kami, Aritmetika 2"
  },
  State_3926_Desc = {
    Text = "\"Pesta Gila Mayat Terdistorsi\"menambahkan [Layer] kerusakan."
  },
  State_3926_Name = {Text = "Distortion"},
  State_3926_WeaponDesc = {
    Text = "Menambahkan kerusakan \"Gelisah\"."
  },
  State_3927_Desc = {
    Text = "Setelah mengambil \"Kekosongan\", kurangi [Layer]% dari semua Aliemus yang diperoleh Pembangun dalam ronde ini."
  },
  State_3927_Name = {Text = "Void"},
  State_3927_WeaponDesc = {
    Text = "Setelah mengambil \"Kekosongan\", kurangi [Layer]% dari semua Aliemus yang diperoleh Pembangun dalam ronde ini."
  },
  State_3928_Desc = {
    Text = "Ketika Sweet Devil memberikan Kerusakan, dapatkan [StateArg2] Counter."
  },
  State_3928_Name = {
    Text = "Memberi dan Menerima"
  },
  State_3929_Desc = {
    Text = "Kekuatan dan Perisai yang diperoleh berkurang sebesar 50%, dan 1 lapisan akan dihilangkan saat giliran berakhir."
  },
  State_3929_Name = {
    Text = "<CardKeyWord:Kutukan>"
  },
  State_3929_WeaponDesc = {
    Text = "Kebal terhadap Negara positif yang diberikan pada diri sendiri dalam ronde ini"
  },
  State_3930_Name = {
    Text = "Negara@Bab 4 Resonansi@Awal giliran tim kami, Aritmetika 1"
  },
  State_3931_Name = {
    Text = "Negara@Pujian Darah Kirmizi dan Pasir"
  },
  State_3932_Desc = {
    Text = "Membuat kartu tetap tersimpan, setiap lapisan Kutukan Stagnasi meningkatkan biaya kartu sebesar 1 poin. Setelah dimainkan, Kutukan Stagnasi akan dihilangkan."
  },
  State_3932_Name = {
    Text = "Kutukan Pembekuan([Layer])"
  },
  State_3932_WeaponDesc = {
    Text = "Membuat kartu tetap tersimpan, setiap lapisan Kutukan Stagnasi meningkatkan biaya kartu sebesar 1 poin. Setelah dimainkan, Kutukan Stagnasi akan dihilangkan."
  },
  State_3933_Desc = {
    Text = "Meningkatkan [Layer] poin Pertahanan."
  },
  State_3933_Name = {
    Text = "Pertahanan sementara meningkat"
  },
  State_3933_WeaponDesc = {
    Text = "Meningkatkan [Layer] poin Pertahanan."
  },
  State_3934_Desc = {
    Text = "Semua perisai yang diperoleh berkurang sebesar 50%."
  },
  State_3934_Name = {
    Text = "Kerapuhan Kepunahan"
  },
  State_3934_WeaponDesc = {
    Text = "Semua perisai yang diperoleh berkurang sebesar 50%."
  },
  State_3935_Desc = {
    Text = "Setiap kali tim kami menggunakan satu kartu tangan, kami memperoleh satu lapisan \"Observasi\". Saat mencapai sepuluh lapisan, karakter ini akan mengalami pusing."
  },
  State_3935_Name = {Text = "Observasi"},
  State_3936_Desc = {
    Text = "Kerusakan, perisai, dan sembuh yang dilakukan oleh pengguna meningkat [StateArg1]%。（Sementara）"
  },
  State_3936_Name = {
    Text = "Negara@Pedang Panjang Percobaan Alam"
  },
  State_3937_Desc = {
    Text = "Ketika Ratu Duri memberikan Counter, ia memperoleh setengah dari nilai Counter tersebut sebagai Perisai."
  },
  State_3937_Name = {
    Text = "Dinding Mayat"
  },
  State_3938_Name = {
    Text = "Membuat patung lilin"
  },
  State_3941_Desc = {
    Text = "Ketika melahap embrio, kembalikan ke tumpukan kartu dari tumpukan kartu buang."
  },
  State_3941_Name = {
    Text = "Angin Putih Pucat"
  },
  State_3941_WeaponDesc = {
    Text = "Ketika melahap embrio, kembalikan ke tumpukan kartu dari tumpukan kartu buang."
  },
  State_3942_Name = {
    Text = "Aksesoris Garis Kembali"
  },
  State_3942_WeaponDesc = {
    Text = "Setelah pertempuran dimulai, jika pemilik peralatan memiliki profesi Aequor, Daya Serang meningkat sebesar 25%."
  },
  State_3943_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_3943_Name = {Text = "Not Roused"},
  State_3944_Desc = {
    Text = "Setelah ronde berakhir, semua Pembangun mendapatkan 5 Aliemus. Untuk setiap 1 poin Aritmetika yang tersisa, semua Pembangun akan mendapatkan tambahan 3 Aliemus."
  },
  State_3945_Desc = {
    Text = "Harga semua Relik berkurang sebesar 50%."
  },
  State_39547_Desc = {
    Text = "Setelah pertempuran berakhir, tambahan mendapatkan 5 Segil hitam, efek ini terpengaruh oleh peningkatan jatuhnya Segil hitam. Wanda memainkan Kartu dan mendapatkan 1 lapisan Impian menarik, efek ini dapat memicu hingga 2 kali setiap giliran. Saat ini masih tersisa [DescArg1] kali."
  },
  State_39547_Name = {
    Text = "Venus dan bulu"
  },
  State_40483_Name = {
    Text = "Lance Tenggelam yang Pecah"
  },
  State_40484_Desc = {
    Text = "Ketika efek lompatan keterampilan Wanda terpicu, jika ada 5 lapisan, lelahkan 5 lapisan dan dapatkan efek tambahan. Batas maksimum Mimpi adalah 10 lapisan, yang akan diwariskan ke pertempuran berikutnya."
  },
  State_40484_Name = {
    Text = "<PurpleKeyWord:Mimpi Pengantar>"
  },
  State_41337_Desc = {
    Text = "Pada akhir ronde, pulihkan [Layer] poin Hidup."
  },
  State_41337_Name = {
    Text = "Kemenangan Mawar-Pemulihan"
  },
  State_41340_Desc = {
    Text = "Hanya Tim: Perisai dan Counter yang diberikan oleh pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setiap kali menerima Serangan, ada kemungkinan sebesar <WeaponEffect_Num:[StateArg2]%> bahwa semua Pembangun akan mendapatkan 1 poin Aliemus."
  },
  State_41340_WeaponDesc = {
    Text = "Peningkatan Perisai dan Counter yang diberikan oleh pemakai sebesar <WeaponEffect_Num:[StateArg1]%>. Setiap kali menerima Serangan, ada kemungkinan sebesar <WeaponEffect_Num:[StateArg2]%> bahwa semua Pembangun akan mendapatkan 1 poin Aliemus."
  },
  State_41342_Name = {
    Text = "Efek Perubahan__\"Hanya untuk pengembangan\""
  },
  State_41344_Name = {
    Text = "Efek Perubahan"
  },
  State_41360_Desc = {
    Text = "Lelah 5 lapisan<DreamGuide:Impian>, Wanda memperoleh <Energy:[StateArg1]> poin Aliemus, dan mendapatkan sementara<RetaliateIconKeywords:Counter> setara dengan [StateArg2]% <RetaliateIconKeywords:Counter> permanen."
  },
  State_41360_Name = {
    Text = "Serangan Balasan Tidur Nyenyak"
  },
  State_41361_Desc = {
    Text = "Mengonsumsi 10 tumpukan <DreamGuide:Dreamlure>, membuat semua musuh memasuki status \"Delirium\" selama 1 giliran: Active DMG yang ditimbulkan berkurang [StateArg3]%, jumlah serangan berlipat ganda."
  },
  State_41361_Name = {
    Text = "Gema Bisikan"
  },
  State_43818_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_43818_Name = {Text = "Not Roused"},
  State_44398_Desc = {
    Text = "Setelah memainkan Kartu pertama di setiap putaran, tempatkan satu \"Pertahanan\" dari Pembangun ke tangan."
  },
  State_44484_Name = {
    Text = "Dapat digunakan 3 kali dalam pertarungan bos"
  },
  State_44485_Name = {
    Text = "(Sisa:[Layer])"
  },
  State_44491_Name = {
    Text = "Nonaktifkan efek__\"Hanya untuk pengembangan\""
  },
  State_44562_Name = {
    Text = "Nonaktifkan efek"
  },
  State_44575_Desc = {
    Text = "Perisai yang tersisa di ronde ini tidak akan dihapus, dan akan dipertahankan hingga ronde berikutnya."
  },
  State_44575_Name = {
    Text = "Perisai dipertahankan"
  },
  State_44653_Desc = {
    Text = "Pada awal setiap ronde, semua Pembangun mendapatkan 20 Aliemus. Saat diambil, Kesehatan maksimum berkurang sebesar 50%."
  },
  State_44665_Desc = {
    Text = "Pada giliran ini, tingkat kritis \"Serangan\" meningkat sebesar [Layer]%."
  },
  State_44665_Name = {
    Text = "Crit. Rate Serangan"
  },
  State_44667_Desc = {
    Text = "\"Serangan\"memberikan [DescArg1] poin Aritmetika. Jika postur saat ini adalah \"Marah\", Aritmetika tidak akan bertambah, melainkan 1 Tentakel akan menyerang sebanyak [DescArg2] kali."
  },
  State_44667_Name = {
    Text = "Kekuasaan Sang Raksasa"
  },
  State_44671_Desc = {
    Text = "Pada awal setiap putaran, semua Pembangun mendapatkan 25 Aliemus. Saat diambil, Kesehatan maksimum menjadi 3 kali lipat."
  },
  State_44672_Name = {
    Text = "Diberkati·Kesadaran Kumpulan Serangga"
  },
  State_44711_Desc = {
    Text = "Batas Relik +5, jumlah pembaruan di [D-marka] +1. Setelah Pertempuran berakhir, dapatkan 125 Segil hitam, saat mengambil bisa memilih untuk menghapus hingga 6 Kartu gejala."
  },
  State_44713_Desc = {
    Text = "Setelah pertempuran, dapatkan tambahan 100 segil hitam dan 2 kartu gejala."
  },
  State_44730_Desc = {
    Text = "Pada awal ronde, kumpulkan <Heal:[Heal:StateArg1]> poin pemulihan Tungku Dapur Merah."
  },
  State_44730_Name = {
    Text = "Persembahan penyelamatan"
  },
  State_44731_Desc = {
    Text = "Dengan penderitaan, mengatasi penderitaan. Menghabiskan semua sisa jumlah pemulihan dari Dapur merah, setiap 1 poin yang dihabiskan meningkatkan kerusakan sebesar 3 poin, jika itu adalah pertempuran bos, maka diubah menjadi setiap 1 poin yang dihabiskan meningkatkan kerusakan sebesar 9 poin. Setiap 1% HP maksimum dari Dapur merah yang dihabiskan meningkatkan [DescArg1]% kerusakan akhir."
  },
  State_44731_Name = {
    Text = "Pembersihan"
  },
  State_44732_Desc = {
    Text = "Dengan darah, memberikan pertolongan. Setelah menyebabkan kerusakan, kehilangan 10% dari kehidupan saat ini, mengumpulkan jumlah pemulihan Dapur merah yang sebanding dengan jumlah kehidupan yang hilang."
  },
  State_44732_Name = {Text = "Dedikasi"},
  State_44739_Desc = {
    Text = "Kehilangan permanen [Arg1] Kekuatan saat diambil. Setiap kali memberikan Kerusakan, pulihkan [Arg2] poin Hidup, maksimal dipicu 6 kali per putaran."
  },
  State_44739_Name = {
    Text = "Rasa Bersalah·Ciuman Lamprey"
  },
  State_44740_Name = {
    Text = "Diberkati · Ciuman Belut Tujuh Insang"
  },
  State_44741_Desc = {
    Text = "Kehilangan permanen [Arg1] Kekuatan saat diambil. Setiap kali memberikan Kerusakan, pulihkan [Arg2] poin Hidup, maksimal dipicu 6 kali per putaran."
  },
  State_44741_Name = {
    Text = "Rasa Bersalah·Ciuman Lamprey"
  },
  State_44742_Desc = {
    Text = "Kehilangan permanen [Arg1] Kekuatan saat diambil. Setiap kali memberikan Kerusakan, pulihkan [Arg2] poin Hidup, maksimal dipicu 6 kali per putaran."
  },
  State_44742_Name = {
    Text = "Diberkati · Ciuman Belut Tujuh Insang"
  },
  State_44743_WeaponDesc = {
    Text = "Pada awal pertempuran, rapuh selama 3 ronde."
  },
  State_44744_WeaponDesc = {
    Text = "Pada awal pertempuran, rapuh selama 3 ronde."
  },
  State_44750_Desc = {
    Text = "Pada awal giliran, dapatkan [StateArg1] Aritmetika."
  },
  State_44750_Name = {
    Text = "Relik Lilin Hitam 1"
  },
  State_44751_Desc = {
    Text = "Pada awal giliran, dapatkan [StateArg1] Aritmetika."
  },
  State_44751_Name = {
    Text = "Relik Lilin Hitam 1"
  },
  State_44752_Desc = {
    Text = "Setiap kali \"Sophia\"kehilangan 1 poin hidup, jumlah lapisan akan berkurang 1. Setelah jumlah lapisan menjadi 0, niat akan diganti dengan \"Balas Dendam\"dan mendapatkan [StateArg2] perisai. Pada pemicu pertama, semua lapisan akan dipulihkan."
  },
  State_44752_Name = {
    Text = "Dorongan yang Terkubur"
  },
  State_44762_Desc = {
    Text = "Ketika memainkan \"Pertahanan\", masukkan 1 kartu Luka ke dalam tumpukan Menggambar."
  },
  State_44762_Name = {
    Text = "Mencabik-cabik"
  },
  State_44763_Desc = {
    Text = "Semua atribut Crit. DMG Pembangun berkurang menjadi setengah."
  },
  State_44763_Name = {
    Text = "<PurpleKeyWord: Blind>"
  },
  State_44764_Desc = {
    Text = "Setelah memainkan \"Serangan\", masukkan 1 kartu luka ke tumpukan menggambar."
  },
  State_44764_Name = {Text = "Luka"},
  State_44807_Desc = {
    Text = "Ketika akan dikalahkan untuk pertama kalinya, pulihkan hidup dan ubah niat menjadi \"Putusan di Cermin\", lalu memperkuat diri sendiri. Ketika akan dikalahkan untuk kedua kalinya, pulihkan hidup dan ubah niat menjadi \"Gigitan Kegilaan\", menyebabkan kerusakan tunggal yang sangat besar."
  },
  State_44807_Name = {
    Text = "Pembantaian Terkubur"
  },
  State_44819_Desc = {
    Text = "Jika tidak ada <ParcloseIconKeywords:Penghalang>, maka dapatkan 1 lapisan <ParcloseIconKeywords:Penghalang> sementara. Jika tidak, dapatkan tambahan 10% Crit. Rate dan Crit. DMG."
  },
  State_44819_Name = {
    Text = "<CardKeyWord:Perlindungan Ayah Suci>"
  },
  State_44828_Desc = {
    Text = "Tim Unik: Saat giliran berakhir, Pemakai mendapatkan [StateArg1] poin Aliemus. Saat menerima Active DMG dan Kerusakan tentakel, pada awal giliran berikutnya mendapatkan Perisai sebesar <WeaponEffect_Num:[StateArg2]%> dari kerusakan tersebut. Jika Realm saat ini adalah Caro, tidak lagi mendapatkan Perisai Latensi, melainkan mengakumulasi pemulihan sebesar <WeaponEffect_Num:[StateArg2]%> dari kerusakan ke Crimson Furnace."
  },
  State_44828_WeaponDesc = {
    Text = "Saat giliran berakhir, Pemakai mendapatkan <WeaponEffect_Num:[StateArg1]> poin Aliemus. Saat menerima Active DMG atau kerusakan tentakel, di awal giliran berikutnya mendapatkan Perisai senilai <WeaponEffect_Num:[Float:StateArg2]%> dari kerusakan. Jika Realm saat ini adalah Caro, tidak lagi mendapatkan Perisai Latensi, melainkan mengumpulkan pemulihan senilai <WeaponEffect_Num:[Float:StateArg2]%> dari kerusakan ke Crimson Furnace."
  },
  State_44889_Name = {
    Text = "Negara@Anjing Berwajah Manusia BOSS@Cermin Akhir 1"
  },
  State_44890_Name = {
    Text = "Negara@Anjing Berwajah Manusia BOSS@Cermin Akhir Zaman"
  },
  State_44891_Name = {
    Text = "Negara@Anjing Berwajah Manusia BOSS@Cermin Akhir 3"
  },
  State_44903_Desc = {
    Text = "Setelah menerima Active DMG atau Kerusakan tentakel, [StateArg1]% kerusakan akan dikonversi menjadi pemulihan Crimson Furnace, berlangsung selama [Layer] giliran."
  },
  State_44903_Name = {
    Text = "Berkah Pencipta"
  },
  State_44909_Name = {Text = "Lelah"},
  State_45018_Desc = {
    Text = "Sebelum ronde berakhir, tidak dapat menggunakan \"Pukulan\"."
  },
  State_45018_Name = {Text = "Kelumpuhan"},
  State_45025_Desc = {
    Text = "Efek spesifik lihat logika pukulan umum.__\"Khusus pengembangan\""
  },
  State_45029_Desc = {
    Text = "Efek spesifik lihat logika pukulan umum.__\"Khusus pengembangan\""
  },
  State_45032_Desc = {
    Text = "Pada akhir ronde berikutnya, terima [Layer] kerusakan."
  },
  State_45032_Name = {Text = "Bleed"},
  State_45039_Desc = {
    Text = "Hingga giliran berikutnya dimulai, setiap kali menerima Active DMG atau Kerusakan tentakel, dapatkan Perisai sebesar [Layer]% kerusakan saat giliran berikutnya dimulai."
  },
  State_45039_Name = {
    Text = "Keajaiban Fajar"
  },
  State_45040_Desc = {
    Text = "Hingga giliran berikutnya dimulai, setiap kali menerima Active DMG atau Kerusakan tentakel, kumpulkan pemulihan sebesar [Layer]% kerusakan ke Crimson Furnace."
  },
  State_45040_Name = {
    Text = "Keajaiban Fajar"
  },
  State_45049_Desc = {
    Text = "Menangkal kehilangan HP akibat serangan aktif berikutnya, dapat ditumpuk maksimal 3 layer, setiap layer Deathmatch akan mengurangi jumlah layer yang dapat ditumpuk pada Barrier sebesar -1, Barrier yang sudah diperoleh tidak akan berkurang karena pengurangan jumlah layer yang dapat ditumpuk."
  },
  State_45049_Name = {Text = "Penghalang"},
  State_45050_Desc = {
    Text = "Menangkal kehilangan HP akibat serangan aktif berikutnya, dapat ditumpuk maksimal 3 layer, setiap layer Deathmatch akan mengurangi jumlah layer yang dapat ditumpuk pada Barrier sebesar -1, Barrier yang sudah diperoleh tidak akan berkurang karena pengurangan jumlah layer yang dapat ditumpuk."
  },
  State_45050_Name = {
    Text = "<ReinforceColour:Penghalang>"
  },
  State_45064_Name = {
    Text = "Penghitung Perjamuan Sunyi__\"Hanya untuk pengembangan\""
  },
  State_45069_Desc = {
    Text = "Efek spesifik lihat logika pukulan umum.__\"Khusus pengembangan\""
  },
  State_45072_Name = {
    Text = "Penghitungan Suci"
  },
  State_45073_Desc = {
    Text = "Kekuatan aritmetika kartu berkurang"
  },
  State_45076_Desc = {
    Text = "Saat diterapkan, disepestakan perisai dan pemulihan yang tertunda dari target, sebelum akhir putaran, pemulihan dan efek perisai berkurang 50%."
  },
  State_45076_Name = {Text = "Blighten"},
  State_45137_Desc = {
    Text = "Setelah menggunakan Muliakan, segel semua Pembangun selama satu putaran, dan dapatkan status Rentan selama satu putaran."
  },
  State_45137_Name = {
    Text = "Dosa Asal · Rangka Jalan"
  },
  State_45139_Desc = {
    Text = "Setelah menggunakan Muliakan, secara acak menghilangkan 1 jenis Negara negatif."
  },
  State_45139_Name = {
    Text = "Diberkati·Tulang Jalan"
  },
  State_45148_Desc = {
    Text = "Semua atribut Crit. DMG Pembangun berkurang menjadi setengah."
  },
  State_45148_Name = {
    Text = "<PurpleKeyWord: Blind>"
  },
  State_45166_Desc = {
    Text = "Roda takdir yang dilengkapi akan menjadi tidak aktif sebelum ronde berakhir."
  },
  State_45166_Name = {Text = "Entwined"},
  State_45206_Desc = {
    Text = "Dengan iman, penebusan. Menghabiskan semua sisa jumlah pemulihan dari Dapur merah, mendapatkan 150% jumlah yang dihabiskan sebagai perisai, perisai ini tidak terpengaruh oleh peningkatan atau pengurangan perisai, tetapi mengabaikan batas perisai."
  },
  State_45206_Name = {Text = "Penebusan"},
  State_45248_Name = {
    Text = "Penghitung__\"Hanya untuk pengembangan\""
  },
  State_45328_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Exalt\" memberikan diri sendiri<TauntKeywords:Taunt>dan <Block:[Block:StateArg1]> Perisai."
  },
  State_45328_Name = {Text = "Sihir 35mm"},
  State_45329_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: \"Serangan\" dapat memilih target, sebelum \"Serangan\", <PVPRepelKeywords:Repel> semua status positif yang dapat dihilangkan dari target ke belakang Pembangun-nya."
  },
  State_45329_Name = {
    Text = "Panggilan Aequor"
  },
  State_45331_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat dilengkapi dan setelah \"Serangan\",\"Keterampilan\" non-turunan dari pemakai di tangan akan berubah secara berurutan menjadi \"Keterampilan\" lainnya milik pemakai tersebut[ShowIfState:, <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]."
  },
  State_45331_Name = {
    Text = "Bunga dan Puisi dari Masa Lalu"
  },
  State_45332_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setiap kali menerima kerusakan aktif, memberikan <Energy:[Energy:StateArg1]> Aliemus kepada sekutu lainnya."
  },
  State_45332_Name = {
    Text = "Pandangan Isarau"
  },
  State_45333_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Batas kartu tangan +[StateArg1],\"Exalt\" memberikan diri sendiri <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_45333_Name = {
    Text = "Ciuman Perpisahan yang Membara"
  },
  State_45334_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: \"Keterampilan\"mengubah \"Serangan\"berikutnya di babak ini menjadi target acak dan menyerang [StateArg1] target acak tambahan."
  },
  State_45334_Name = {
    Text = "Pria dalam cermin"
  },
  State_45345_Desc = {
    Text = "Digunakan untuk mencatat berapa kali Keterampilan Fase 1 telah digunakan"
  },
  State_45345_Name = {
    Text = "Tanda kesuburan 1"
  },
  State_45346_Desc = {
    Text = "Digunakan untuk mencatat berapa kali Keterampilan Fase 2 Reproduksi telah digunakan"
  },
  State_45346_Name = {
    Text = "Tanda Kesuburan 2"
  },
  State_45354_Desc = {
    Text = "Kartu ini tidak dapat dikeluarkan.__\"Hanya untuk pengembangan\""
  },
  State_45354_Name = {
    Text = "Tidak bisa dimainkan__\"Hanya untuk pengembangan\""
  },
  State_45356_Desc = {
    Text = "Pada akhir ronde, berubah menjadi kartu \"Keterampilan\" terakhir yang kamu mainkan, mengurangi konsumsi Aritmetika sebesar 2, setelah dimainkan \"Wajah Sejati Abu-abu\" dikocok kembali ke dalam dek."
  },
  State_45356_Name = {
    Text = "<CardKeyWord:Wajah Sejati Abu-Abu>"
  },
  State_45364_Desc = {
    Text = "Pada awal giliran berikutnya, Pembangun ini mendapatkan [Layer] buah kartu \"Pukulan\"."
  },
  State_45364_Name = {
    Text = "Tunda serangan"
  },
  State_45385_Desc = {
    Text = "Semua kerusakan yang ditimbulkan dalam pertempuran ini berkurang sebesar [Layer] poin, tidak dapat dihilangkan. Di antaranya terdapat [DescArg1] lapisan pengurangan kekuatan sementara yang akan dihapus setelah ronde berakhir."
  },
  State_45385_Name = {Text = "STR▼"},
  State_45387_Desc = {
    Text = "Semua kerusakan yang diberikan dalam pertempuran ini meningkat sebesar [Layer] poin, tidak dapat dihilangkan. Di antaranya terdapat [DescArg1] lapisan kekuatan sementara yang akan dihapus setelah ronde berakhir."
  },
  State_45387_Name = {Text = "Kekuatan"},
  State_45397_Desc = {
    Text = "Pada awal giliran, ubah 1 lapisan Penghalang menjadi Kekuatan."
  },
  State_45397_Name = {
    Text = "Mawar Yang Berjaya"
  },
  State_45403_Desc = {
    Text = "Pada awal ronde berikutnya, dapatkan [Layer] tingkat Muatan."
  },
  State_45403_Name = {
    Text = "Muatan Tertunda"
  },
  State_45407_Desc = {
    Text = "Mendapatkan Aliemus dan penurunan Aliemus tertunda sebesar 50%, serta segera menghilangkan semua Aliemus tertunda."
  },
  State_45407_Name = {Text = "Void"},
  State_45656_Desc = {
    Text = "Pohon Ibu bangkit kembali untuk ketiga kalinya, mengaktifkan Keterampilan 2: Fertilitas"
  },
  State_45658_Desc = {
    Text = "Pohon ibu dihidupkan kembali untuk pertama kalinya, memulai Keterampilan pembiakan."
  },
  State_45661_Desc = {
    Text = "Ketika Hidup berkurang hingga 0, ubah Hidup menjadi 1 poin, tidak menerima Kerusakan lagi, bersiap untuk melepaskan \"Fusi Ganda\"."
  },
  State_45661_Name = {
    Text = "Fusi Berganda"
  },
  State_45715_Desc = {
    Text = "Mendapatkan kekuatan sementara yang setara dengan [StateArg1]% kerusakan tentakel."
  },
  State_45715_Name = {
    Text = "pencurian kekuasaan"
  },
  State_45716_Desc = {
    Text = "Mendapatkan kekuatan sementara yang setara dengan [StateArg1]% kerusakan tentakel. Goliath mendapatkan 25% Crit. Rate sementara."
  },
  State_45716_Name = {
    Text = "pencurian kekuasaan"
  },
  State_45717_Desc = {
    Text = "Meningkatkan kerusakan dasar \"Kekuatan pedang besar\" dan \"Kerusakan pemenggalan\" sebesar 25% dalam pertempuran ini. Goliath memperoleh <Energy:[Energy:StateArg2]> poin Aliemus."
  },
  State_45717_Name = {
    Text = "bersembunyi"
  },
  State_45718_Desc = {
    Text = "Meningkatkan kerusakan dasar \"Kekuatan pedang besar\" dan \"Kerusakan pemenggalan\" sebesar 25% dalam pertempuran ini."
  },
  State_45718_Name = {
    Text = "bersembunyi"
  },
  State_46057_Name = {
    Text = "Arithmetica"
  },
  State_46079_Desc = {
    Text = "Dalam ronde ini, setiap kali target menerima kerusakan aktif, pulihkan [Layer] hidup teman yang kehilangan hidup paling banyak."
  },
  State_46079_Name = {
    Text = "Petunjuk Darah Suci"
  },
  State_46119_Desc = {
    Text = "Saat diserang lagi, tambahkan Jalinan kepada penyerang."
  },
  State_46119_Name = {
    Text = "Jebakan Labirin"
  },
  State_46124_Desc = {
    Text = "Tidak dapat melakukan tindakan apa pun hingga giliran berakhir."
  },
  State_46124_Name = {Text = "Petrify"},
  State_46138_Desc = {
    Text = "Berubah menjadi \"Keterampilan\" terakhir yang dimainkan oleh lawan, dan kurangi biayanya sebesar 1."
  },
  State_46138_Name = {
    Text = "<CardKeyWord:Mimikri Bintang>"
  },
  State_46139_Desc = {
    Text = "Setiap kali diserang secara aktif, diri sendiri mendapatkan [Layer] lapisan Charge dan menyebabkan [Layer] lapisan Stagnation kepada penyerang."
  },
  State_46139_Name = {
    Text = "Anomali Gravitasi"
  },
  State_46155_Desc = {
    Text = "Setelah menggunakan \"Keterampilan\", mendapatkan [StateArg1] lapisan muatan dan jumlah lapisan - 1. Pada akhir giliran, mengonsumsi semua lapisan, setiap lapisan memulihkan [StateArg2] Hidup."
  },
  State_46155_Name = {
    Text = "Darah penyimpangan"
  },
  State_46243_Name = {
    Text = "Penghitung Ilham__\"Hanya untuk pengembangan\""
  },
  State_46255_Desc = {
    Text = "Efek spesifik lihat logika pukulan umum.__\"Khusus pengembangan\""
  },
  State_46256_Desc = {
    Text = "Efek spesifik lihat logika pukulan umum.__\"Khusus pengembangan\""
  },
  State_46322_Desc = {
    Text = "Pada awal giliran, dapatkan 30 Fusi Embrio."
  },
  State_46322_Name = {
    Text = "Uvhash Demo"
  },
  State_46323_Desc = {
    Text = "Setelah ronde Ultra dimulai, dapatkan 100 poin Aliemus. Setelah ronde dimulai, dapatkan 7 poin Kekuatan."
  },
  State_46323_Name = {
    Text = "Liz mencoba bermain"
  },
  State_46324_Desc = {
    Text = "Setiap ronde mendapatkan 1 \"Inspirasi\"."
  },
  State_46324_Name = {
    Text = "Jenkin mencoba bermain"
  },
  State_46329_Desc = {
    Text = "Setelah pertempuran dimulai, dapatkan 600 poin Energi-s, Lotan mendapatkan 50 poin Aliemus. Setelah Lotan melepaskan Muliakan, dapatkan tambahan 44 poin Aliemus."
  },
  State_46329_Name = {
    Text = "Bonus Uji Coba"
  },
  State_46330_Desc = {
    Text = "Pada awal giliran, dapatkan 30 Fusi Embrio, 10 poin Aliemus, [DescArg1] poin Kekuatan, dan tambahkan 3 kartu \"Pukulan\" ke dalam tumpukan Menggambar."
  },
  State_46330_Name = {
    Text = "Uji Coba Helot"
  },
  State_46333_Name = {
    Text = "Uji Coba Leigh"
  },
  State_46334_Desc = {
    Text = "Setelah ronde ke-4 dimulai, dapatkan 100 poin Aliemus."
  },
  State_46334_Name = {Text = "Faros Demo"},
  State_46336_Desc = {
    Text = "Pada awal giliran, dapatkan 30 Fusi Embrio dan 10 poin Aliemus."
  },
  State_46336_Name = {
    Text = "Agrippa Trial"
  },
  State_46337_Desc = {
    Text = "Pada awal ronde, dapatkan 10 poin Aliemus."
  },
  State_46337_Name = {
    Text = "Caecus Demo"
  },
  State_46338_Desc = {
    Text = "Pada awal giliran, dapatkan 30 Fusi Embrio dan 10 poin Aliemus."
  },
  State_46338_Name = {
    Text = "Pingsan Demo"
  },
  State_46427_Desc = {
    Text = "Efek spesifik lihat logika pukulan umum.__\"Khusus pengembangan\""
  },
  State_46428_Desc = {
    Text = "Efek spesifik lihat logika pukulan umum.__\"Khusus pengembangan\""
  },
  State_46429_Desc = {
    Text = "Efek spesifik lihat logika pukulan umum.__\"Khusus pengembangan\""
  },
  State_46441_Desc = {
    Text = "Kebal terhadap semua kerusakan non-Pierce DMG. Efek ini akan dihilangkan setelah giliran dimulai."
  },
  State_46441_Name = {
    Text = "Kekebalan terhadap kerusakan"
  },
  State_46442_Name = {
    Text = "Kartu dilarang mengubah jenis target pukulan"
  },
  State_46500_Desc = {
    Text = "Efek spesifik lihat logika pukulan umum.__\"Khusus pengembangan\""
  },
  State_46505_Desc = {
    Text = "Dalam ronde ini, setiap kali menerima Active DMG, dapatkan [Layer] Aliemus."
  },
  State_46505_Name = {
    Text = "Konversi Penderitaan"
  },
  State_46508_Desc = {
    Text = "Mendapatkan resistensi saat terkena pingsan. Saat memiliki resistensi dan terkena kerusakan pingsan lagi, efek pingsan akan dibatalkan dan kerusakan akan dilipatgandakan. Status ini tidak dapat dihilangkan."
  },
  State_46508_Name = {Text = "Resistance"},
  State_46511_Desc = {
    Text = "Kerusakan \"Sosok Berlapis\" Awakener ini meningkat sebesar [Layer]."
  },
  State_46511_Name = {
    Text = "Sosok Berlapis"
  },
  State_46512_Desc = {
    Text = "Sebelum giliran berakhir, Pembangun yang memainkan kartu menerima [Layer] kerusakan."
  },
  State_46512_Name = {
    Text = "Blokir Kartu"
  },
  State_46513_Desc = {
    Text = "Perkuat puisi berikutnya, membuatnya mendapatkan efek tambahan, tidak dapat dihapus."
  },
  State_46513_Name = {
    Text = "Torehan Duka"
  },
  State_46536_Desc = {
    Text = "Jika status parameter1 adalah 0, maka menggambar kartu, jika tidak, hanya kata-kata melayang"
  },
  State_46536_Name = {Text = "Draw"},
  State_46538_Desc = {
    Text = "Pada awal eksplorasi, dapatkan [StateArg1] poin Aliemus."
  },
  State_46538_Name = {
    Text = "Madness Omen"
  },
  State_47072_Desc = {
    Text = "Crit. Rate kartu serangan putaran ini +[Layer]%."
  },
  State_47072_Name = {
    Text = "Serangan Kritis"
  },
  State_47089_Name = {
    Text = "Efek Pengujian__\"Hanya untuk pengembangan\""
  },
  State_47096_Desc = {
    Text = "Setiap kali menggunakan 1 kartu \"Inspirasi\", Narsis mendapatkan [StateArg1] poin Aliemus dan [StateArg2] poin Kekuatan. Setiap putaran dapat dipicu maksimal 5 kali. (Saat ini tersisa [DescArg1] kali.)"
  },
  State_47096_Name = {
    Text = "Sedimentasi Protoplasma"
  },
  State_47189_Name = {
    Text = "Beralih ke Kepribadian Manik. Caro·Depresif: <EmbryoFusionIconKeywords:Embryo Fusion> +[Blood:StateArg5], kumpulkan [StateArg6] poin pemulihan Crimson Furnace"
  },
  State_47192_Name = {
    Text = "Kepribadian Depresi: Juga akan membuat Pembangun lain mendapatkan [DescArg1] kali lipat Aliemus. Kepribadian Manik: Mendapatkan tambahan [DescArg2] kali lipat Aliemus"
  },
  State_47199_Name = {
    Text = "Beralih ke kepribadian depresi. Caro·Manik: Kerusakan mendapat [DescArg1] kali bonus <PowerIconKeywords:Kekuatan> dan memberikan 200% kerusakan <BleedingIconKeywords:Berdarah> pada target, serta mendapatkan [StateArg7] poin <PowerIconKeywords:Kekuatan>"
  },
  State_47204_Name = {
    Text = "Beralih ke kepribadian manik. Kekacauan·Depresi: Dapatkan <Posse:[StateArg1]> poin Energi-s, Geng berikutnya akan berlaku 2 kali."
  },
  State_47206_Name = {
    Text = "Beralih ke Kehidupan Manik. Aequor·Emosi Depresi: <WeaknessIconKeywords:Kelemahan> dan <VulnerabilityIconKeywords:Rentan> target selama 2 giliran, menghasilkan 1 Tentakel, <TentacleInjurieIconKeywords:Kerusakan tentakel> + [TentaclePower:StateArg3]"
  },
  State_47209_Name = {
    Text = "Beralih ke Personalitas depresif. Ultra·Mania: Mendapatkan <RetaliateIconKeywords:Counter> sebesar 15% dari kerusakan yang ditimbulkan, lalu menimbulkan <FixedDamage:Kerusakan Murni> setara kepada musuh lainnya. Setiap 1 kartu \"Ilham\" yang di-play pada giliran ini, meningkatkan kerusakan tersebut sebesar [StateArg9] poin dalam giliran ini, maksimal [StateArg10] poin."
  },
  State_47211_Name = {
    Text = "Kepribadian Depresi: Mengurangi konsumsi aritmetika sebesar 1 poin pada [DescArg1] kartu dengan aritmetika tertinggi di tangan dan mendapatkan <RetainIconKeywords:Simpan> sementara. Kepribadian Manik: Menyebabkan kerusakan tambahan sebanyak [DescArg2] kali"
  },
  State_47212_Name = {
    Text = "Membuat \"24\"beralih antara kepribadian depresi dan manik, serta memicu Efek tambahan berdasarkan Alam dan kepribadian saat ini."
  },
  State_47216_Name = {
    Text = "Beralih ke kepribadian depresi. Aequor·Manik: Kerusakan ini mendapatkan tambahan [StateArg4]% <TentacleInjurieIconKeywords:Kerusakan tentakel>, dan memberikan 30% kerusakan kepada semua musuh dengan <IntoxicationIconKeywords:Racun>."
  },
  State_47217_Name = {
    Text = "Beralih ke kepribadian depresi. Kekacauan·Manik: Menyebabkan 3 kali kerusakan, meningkatkan semua kerusakan yang disebabkan oleh \"24\" sebesar [StateArg2] poin."
  },
  State_47218_Name = {
    Text = "Beralih ke kepribadian manik. Ultra·Depresi: Tambahkan 2 kartu \"Inspirasi\"ke tangan, dan kurangi sementara [Power:StateArg8] poin <PowerIconKeywords:Kekuatan> pada target."
  },
  State_47222_Name = {
    Text = "Kepribadian Depresi: Mengurangi konsumsi aritmetika sebesar 1 poin pada [DescArg1] kartu dengan aritmetika tertinggi di tangan, dan mendapatkan <RetainIconKeywords:Simpan> sementara. <AwakerCard_24Lost:Kepribadian Manik: Menyebabkan tambahan [DescArg2] kali kerusakan>"
  },
  State_47224_Name = {
    Text = "Kepribadian Depresi: Juga akan membuat Pembangun lain mendapatkan [DescArg1] kali lipat Aliemus. <AwakerCard_24Lost:Kepribadian Manik: Mendapatkan tambahan [DescArg2] kali lipat Aliemus>"
  },
  State_47228_Name = {
    Text = "<AwakerCard_24Lost:Kepribadian Depresi: Juga akan membuat Pembangun lain mendapatkan [DescArg1] kali lipat Aliemus.> Kepribadian Manik: Mendapatkan tambahan [DescArg2] kali lipat Aliemus"
  },
  State_47229_Name = {
    Text = "<AwakerCard_24Lost:Kepribadian Depresi: Mengurangi konsumsi aritmetika sebesar 1 poin pada [DescArg1] kartu dengan aritmetika tertinggi di tangan, dan mendapatkan <RetainIconKeywords:Simpan> sementara.> Kepribadian Manik: Menyebabkan kerusakan tambahan sebanyak [DescArg2] kali"
  },
  State_47451_Name = {
    Text = "Efek roda takdir Ryker Posse dinonaktifkan"
  },
  State_47485_Name = {
    Text = "Kepribadian Depresi: Mengurangi konsumsi aritmetika sebesar 2 poin pada [DescArg1] kartu dengan aritmetika tertinggi di tangan dan mendapatkan <RetainIconKeywords:Simpan> sementara. Kepribadian Manik: Memberikan kerusakan tambahan sebanyak [DescArg2] kali"
  },
  State_47486_Name = {
    Text = "Kepribadian Depresi: Mengurangi konsumsi aritmetika sebesar 2 poin pada [DescArg1] kartu dengan aritmetika tertinggi di tangan, dan mendapatkan <RetainIconKeywords:Simpan> sementara. <AwakerCard_24Lost:Kepribadian Manik: Menyebabkan kerusakan tambahan sebanyak [DescArg2] kali>"
  },
  State_47488_Name = {
    Text = "Kepribadian Depresi: Mendapatkan tambahan <Energy: [DescArg1]> poin Aliemus. Kepribadian Manik: Mendapatkan tambahan [DescArg2] kali Perisai"
  },
  State_47489_Name = {
    Text = "<AwakerCard_24Lost:Kepribadian Depresi: Mengurangi konsumsi aritmetika sebesar 2 poin pada [DescArg1] kartu dengan aritmetika tertinggi di tangan, dan mendapatkan <RetainIconKeywords:Simpan> sementara.> Kepribadian Manik: Memberikan kerusakan tambahan sebanyak [DescArg2] kali"
  },
  State_47492_Name = {
    Text = "Kepribadian Depresi: Mendapatkan tambahan <Energy: [DescArg1]> poin Aliemus. <AwakerCard_24Lost:Kepribadian Manik: Menyebabkan [DescArg2] kali Kerusakan tambahan>"
  },
  State_47493_Name = {
    Text = "Kepribadian Depresi: Mendapatkan tambahan <Energy: [DescArg1]> poin Aliemus. Kepribadian Manik: Menyebabkan [DescArg2] kali kerusakan tambahan"
  },
  State_47494_Name = {
    Text = "Kepribadian Depresi: Juga akan membuat Pembangun lain mendapatkan [DescArg1] kali lipat Aliemus, <WeaknessIconKeywords:Kelemahan> semua musuh selama [DescArg3] putaran. Kepribadian Manik: Mendapatkan tambahan [DescArg2] kali lipat Aliemus, <VulnerabilityIconKeywords:Rentan> semua musuh selama [DescArg3] putaran"
  },
  State_47495_Name = {
    Text = "Kepribadian Depresi: Juga akan membuat Pembangun lain mendapatkan [DescArg1] kali lipat Aliemus, <WeaknessIconKeywords:Kelemahan> semua musuh selama [DescArg3] putaran. <AwakerCard_24Lost:Kepribadian Manik: Mendapatkan tambahan [DescArg2] kali lipat Aliemus, Rentan semua musuh selama [DescArg3] putaran>"
  },
  State_47496_Name = {
    Text = "<AwakerCard_24Lost:Kepribadian Depresi: Juga akan membuat Pembangun lain mendapatkan [DescArg1] kali lipat Aliemus, Kelemahan semua musuh selama [DescArg3] putaran.> Kepribadian Manik: Mendapatkan tambahan [DescArg2] kali lipat Aliemus, <VulnerabilityIconKeywords:Rentan> semua musuh selama [DescArg3] putaran"
  },
  State_47498_Name = {
    Text = "<AwakerCard_24Lost:Kepribadian Depresi: Mendapatkan tambahan [DescArg1] poin Aliemus.> Kepribadian Manik: Menyebabkan tambahan [DescArg2] kali Kerusakan"
  },
  State_47499_Name = {
    Text = "<AwakerCard_24Lost:Kepribadian Depresi: Mendapatkan tambahan [DescArg1] poin Aliemus.> Kepribadian Manik: Mendapatkan tambahan [DescArg2] kali Perisai"
  },
  State_47500_Name = {
    Text = "Kepribadian Depresi: Mendapatkan tambahan <Energy: [DescArg1] > poin Aliemus. <AwakerCard_24Lost:Kepribadian Manik: Mendapatkan tambahan [DescArg2] kali Perisai>"
  },
  State_47517_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Pada akhir ronde, buang [StateArg1] kartu dari Pembangun lainnya, jika berhasil membuang kartu maka tarik [StateArg2] kartu."
  },
  State_47517_Name = {
    Text = "Tekad Ikan Kod Perak"
  },
  State_47518_Name = {
    Text = "Penghitung Tekad Ikan Kod Perak__\"Hanya untuk pengembangan\""
  },
  State_47528_Desc = {
    Text = "Pada giliran ini,\"Serangan\"+ [DescArg1]% kerusakan <PVPPenetrateKeywords:penetrasi>."
  },
  State_47528_Name = {
    Text = "Sisa Kekuatan"
  },
  State_47530_Desc = {
    Text = "Diperlakukan sebagai \"Keterampilan\" terakhir yang dimainkan pada ronde ini."
  },
  State_47530_Name = {
    Text = "<CardKeyWord:Simulasi Deduksi>"
  },
  State_47557_Desc = {
    Text = [[
Tim Unik: Setelah eksplorasi dimulai, Pemakai memasuki negara kepribadian Manusia Ikan Perak. Setelah Pemakai melepaskan Exalt, akan beralih antara kepribadian Manusia Ikan Perak dan kepribadian Kucing.
Kepribadian Manusia Ikan Perak: Setelah Pemakai memberikan Active DMG, dapatkan <WeaponEffect_Num:[StateArg1]> Keyflare. Kepribadian Kucing: Setelah Pemakai memberikan Active DMG, Kerusakan Kritis Sementara Pemakai <WeaponEffect_Num:+[StateArg2]%>. Kedua efek ini berbagi kesempatan maksimal 5 kali pemicu per ronde.]]
  },
  State_47557_WeaponDesc = {
    Text = [[
Setelah eksplorasi dimulai, Pemakai memasuki negara kepribadian Manusia Ikan Perak. Setelah Pemakai melepaskan Exalt, akan beralih antara kepribadian Manusia Ikan Perak dan kepribadian Kucing.
Kepribadian Manusia Ikan Perak: Setelah Pemakai memberikan Active DMG, dapatkan <WeaponEffect_Num:[StateArg1]> Keyflare. Kepribadian Kucing: Setelah Pemakai memberikan Active DMG, Kerusakan Kritis Sementara Pemakai <WeaponEffect_Num:+[StateArg2]%>. Kedua efek ini berbagi kesempatan maksimal 5 kali pemicu per ronde.]]
  },
  State_47822_Desc = {
    Text = "Jika pada giliran berikutnya menerima \"Paralysis\" kembali, semua \"Pukulan\" miliknya berubah menjadi \"Ilusi\", tidak dapat diusir, berlangsung hingga akhir giliran berikutnya."
  },
  State_47822_Name = {
    Text = "Agak Mati Rasa"
  },
  State_47825_Desc = {
    Text = "Akan memicu efek keterampilan sesuai pada awal giliran."
  },
  State_47825_Name = {
    Text = "<CardKeyWord:Penundaan>"
  },
  State_47826_Desc = {
    Text = "·Kerusakan berlipat ganda saat target dalam kondisi \"Paralysis\", jika tidak, \"Pukulan\" miliknya tidak dapat digunakan pada giliran ini.\n·Berada dalam kondisi \"Paralysis\" selama 2 giliran berturut-turut, semua \"Pukulan\" miliknya berubah menjadi \"Ilusi\"."
  },
  State_47826_Name = {
    Text = "<WeaknessColour:Kelumpuhan>"
  },
  State_47827_Desc = {
    Text = "Setiap lapisan mengurangi semua kerusakan yang diberikan dalam pertempuran ini sebesar 1 poin, tidak dapat dibuang."
  },
  State_47827_Name = {
    Text = "<WeaknessColour:Pengurangan kekuatan>"
  },
  State_47828_Desc = {
    Text = "· Saat diterapkan, menyebabkan kerusakan sebesar jumlah lapisan yang sama. Jika target dalam keadaan \"Terjerat\", kerusakan dilipatgandakan; jika tidak, roda takdir yang dilengkapi oleh target akan menjadi tidak aktif hingga akhir giliran."
  },
  State_47828_Name = {
    Text = "<WeaknessColour:Jalinan>"
  },
  State_47830_Desc = {
    Text = "Saat diterapkan, disepestakan perisai dan pemulihan yang tertunda dari target, sebelum akhir putaran, pemulihan dan efek perisai berkurang 50%."
  },
  State_47830_Name = {
    Text = "<PVPVulnerabilityIconColour:Kerusakan Serius>"
  },
  State_47831_Desc = {
    Text = "Tidak dapat melakukan tindakan apa pun sebelum giliran berakhir. Saat terkena kerusakan Pingsan, target akan memperoleh resistensi. Saat memiliki resistensi dan kembali terkena kerusakan Pingsan, efek Pingsan akan dibatalkan dan kerusakan akan dilipatgandakan. Status ini tidak dapat dihilangkan."
  },
  State_47831_Name = {
    Text = "<ComaColour:Petrifikasi>"
  },
  State_47832_Desc = {
    Text = "Termasuk tikus terinfeksi, tikus bermuatan listrik, dan tikus dengan demensia."
  },
  State_47832_Name = {
    Text = "<CardKeyWord:Tikus Card>"
  },
  State_47833_Desc = {
    Text = "Termasuk saputangan merpati putih, kotak sulap terbalik, dan mikrofon telepati."
  },
  State_47833_Name = {
    Text = "<CardKeyWord:Sihir Menakjubkan>"
  },
  State_47841_Desc = {
    Text = "Dalam pertempuran ini, penggunaan Geng sebanyak [Layer] kali akan berlaku 2 kali."
  },
  State_47841_Name = {
    Text = "Perintah Kunci Ganda"
  },
  State_47842_Desc = {
    Text = "Mendapatkan Aliemus dan penurunan Aliemus tertunda sebesar 50%, serta segera menghilangkan semua Aliemus tertunda."
  },
  State_47842_Name = {
    Text = "<PVPEmptinessColour:Kekosongan>"
  },
  State_47843_Desc = {
    Text = "Membangunkan Pembangun dari keadaan mati dan menempatkan seluruh set kartunya ke dalam tumpukan menggambar."
  },
  State_47843_Name = {
    Text = "<PVPResurrectionColour:Kebangkitan>"
  },
  State_47844_Desc = {
    Text = "Menghasilkan efek yang membingungkan secara acak."
  },
  State_47844_Name = {
    Text = "<PVPWonderfulEffectKeywords:Efek Menakjubkan>"
  },
  State_47845_Desc = {
    Text = "Efek akan dihasilkan saat kartu berada di tangan."
  },
  State_47845_Name = {
    Text = "<CardKeyWord:Memiliki>"
  },
  State_47873_Desc = {
    Text = "Pada akhir ronde berikutnya, berikan kerusakan sebesar jumlah lapisan."
  },
  State_47873_Name = {
    Text = "<PVPVulnerabilityIconColour:Berdarah>"
  },
  State_47887_Name = {
    Text = "Mendapatkan efek yang berbeda berdasarkan alam tim saat ini"
  },
  State_47888_Name = {
    Text = "Caro:\"24\" Setiap mengonsumsi 1 poin Arithmetica <EmbryoFusionIconKeywords:Embryo Fusion> +[Blood:DescArg1], mendapatkan [StateArg3] poin <PowerIconKeywords:Kekuatan>, Exalt \"24\" mendapatkan bonus tambahan 300% Kekuatan"
  },
  State_47889_Name = {
    Text = "Aequor: Kerusakan yang ditimbulkan oleh \"24\" mendapat bonus [StateArg2]% <TentacleInjurieIconKeywords:Kerusakan tentakel>, dan menyebabkan <IntoxicationIconKeywords:Racun> sebesar 10% dari Kerusakan. Exalt \"24\" dapat memicu <IntoxicationIconKeywords:Racun> sebesar [StateArg6]% pada musuh"
  },
  State_47892_Name = {
    Text = "Chaos: Crit. Rate dan Crit. DMG \"24\"+[StateArg4]%. Setiap kali menggunakan Posse, Final DMG Exalt \"24\" meningkat sebesar [StateArg1]%"
  },
  State_47894_Name = {
    Text = "Ultra: Kerusakan yang ditimbulkan oleh \"24\"mendapatkan bonus [StateArg5]% <RetaliateIconKeywords:Counter>. Pada akhir ronde, masukkan 1 kartu \"Inspirasi\"ke tumpukan kartu buang, batas kartu tangan +2."
  },
  State_48009_Desc = {
    Text = "Efek tambahan [StateArg1] kali saat pertama kali digunakan di setiap ronde."
  },
  State_48009_Name = {
    Text = "<Rune_19:Paduan>"
  },
  State_48010_Desc = {
    Text = "Ensemble Mark"
  },
  State_48010_Name = {
    Text = "Ensemble Mark"
  },
  State_48011_Desc = {
    Text = "Efek tambahan [StateArg1] kali saat pertama kali digunakan di setiap ronde."
  },
  State_48011_Name = {
    Text = "<Rune_19_High:Resonansi Tinggi>"
  },
  State_48011_WeaponDesc = {
    Text = "Setelah digunakan, efek tambahan berlaku sebanyak [StateArg1] kali, Lelah."
  },
  State_48012_Desc = {
    Text = "Membuat kartu yang telah di-Orison berlaku 2 kali saat pertama kali dimainkan di setiap ronde."
  },
  State_48012_Name = {
    Text = "<CardKeyWord:Orison: Ensemble>"
  },
  State_48013_Desc = {
    Text = "Membuat kartu Orison yang dikeluarkan pertama kali setiap ronde berlaku 3 kali."
  },
  State_48013_Name = {
    Text = "<CardKeyWord:Orison: Ensemble Tingkat Lanjut>"
  },
  State_48019_Name = {
    Text = "<CardKeyWord:Simulasi Deduksi>"
  },
  State_48020_Name = {
    Text = "<CardKeyWord:Kelahiran jiwa>"
  },
  State_48021_Name = {
    Text = "<CardKeyWord:Wajah Sejati Abu-Abu>"
  },
  State_48078_Name = {
    Text = "<CardKeyWord:Mimikri Bintang>"
  },
  State_48099_Desc = {
    Text = "Pada akhir ronde, \"24\" memperoleh [DescArg1] poin Aliemus. Setiap kali \"24\" melepaskan Muliakan, efek ini meningkatkan perolehan Aliemus sebesar 1."
  },
  State_48099_Name = {
    Text = "Penelitian Perilaku Pavlov"
  },
  State_48099_WeaponDesc = {
    Text = "Setelah giliran pemakai berakhir, dapatkan 3 poin Aliemus. Jika pemulihan Aliemus pemakai lebih dari 10, dapatkan tambahan 2 poin Aliemus."
  },
  State_48100_Name = {
    Text = "Negara@24 Pavlov Perilaku Penelitian Hitungan"
  },
  State_48100_WeaponDesc = {
    Text = "Setelah giliran pemakai berakhir, dapatkan 3 poin Aliemus. Jika pemulihan Aliemus pemakai lebih dari 10, dapatkan tambahan 2 poin Aliemus."
  },
  State_48107_Desc = {
    Text = "Kerusakan \"Keterampilan\" pertama milik pemakainya yang dimainkan setiap ronde meningkat [StateArg1]%."
  },
  State_48107_Name = {
    Text = "Pedang Sang Raksasa"
  },
  State_48108_Desc = {
    Text = "Pengguna setiap putaran pertama memainkan \"Keterampilan\", akan menggambar satu salinan biaya aritmetika - [StateArg1] ke tumpukan menggambar."
  },
  State_48108_Name = {Text = "Fouetté"},
  State_48110_Desc = {
    Text = "\"Keterampilan\"mengubah \"Serangan\"berikutnya di ronde ini menjadi target acak dan menyerang [StateArg1] target acak tambahan."
  },
  State_48110_Name = {
    Text = "Pria dalam cermin"
  },
  State_48140_Desc = {
    Text = "Saat eksplorasi dimulai,\"24\" memasuki Personalitas depresif.\n<School_1:Chaos·Depresif>:Dapatkan <Posse:[StateArg1]> poin Keyflare, Posse berikutnya berlaku 2 kali.\n<School_1:Chaos·Manik>:Memberikan kerusakan 3 kali, meningkatkan semua Kerusakan yang diberikan oleh \"24\" sebesar [StateArg2] poin.\n<School_2:Aequor·Depresif>:<WeaknessIconKeywords:Weakness> dan <VulnerabilityIconKeywords:Vulnerable> target selama 2 ronde, menghasilkan 1 Tentacle, <TentacleInjurieIconKeywords:Kerusakan tentakel>+ [StateArg3].\n<School_2:Aequor·Manik>:Kerusakan ini mendapat bonus [StateArg4]% <TentacleInjurieIconKeywords:Kerusakan tentakel>, dan memberikan <IntoxicationIconKeywords:Racun> sebesar 30% dari kerusakan yang diberikan kepada semua musuh.\n<School_3:Caro·Depresif>:<EmbryoFusionIconKeywords:Embryo Fusion> +[Blood:StateArg5], mengumpulkan [StateArg6] poin pemulihan Crimson Furnace.\n<School_3:Caro·Manik>:Kerusakan mendapat bonus <PowerIconKeywords:Kekuatan> 6 kali lipat dan memberikan <BleedingIconKeywords:Bleed> sebesar 200% dari kerusakan yang diberikan kepada target, dapatkan [StateArg7] poin <PowerIconKeywords:Kekuatan>.\n<School_4:Ultra·Depresif>:Tambahkan 2 kartu \"Ilham\" ke tangan, turunkan <PowerIconKeywords:Kekuatan> target secara sementara sebesar [StateArg8] poin.\n<School_4:Ultra·Manik>:Dapatkan <RetaliateIconKeywords:Counter> sebesar 15% dari kerusakan yang diberikan, lalu berikan <FixedDamage:Kerusakan Murni> setara kepada musuh lainnya. Setiap 1 kartu \"Ilham\" yang dimainkan pada ronde ini, tingkatkan kerusakan tersebut sebesar [StateArg9] poin dalam ronde ini, maksimal [StateArg10] poin."
  },
  State_48140_Name = {
    Text = "Alam dan Efek Kepribadian"
  },
  State_48141_Desc = {
    Text = [[
<School_1:Chaos>: Crit. Rate dan Crit. DMG "24"+[StateArg4]%. Setiap kali menggunakan Posse, Final DMG Exalt "24" meningkat sebesar [StateArg1]%.
<School_2:Aequor>: Kerusakan yang ditimbulkan oleh "24" mendapatkan bonus [StateArg2]% <TentacleInjurieIconKeywords:Kerusakan tentakel>, dan menyebabkan <IntoxicationIconKeywords:Racun> sebesar 10% dari kerusakan. Exalt "24" dapat memicu <IntoxicationIconKeywords:Racun> pada musuh sebesar 50%.
<School_3:Caro>: Setiap kali "24" menghabiskan 1 poin Arithmetica <EmbryoFusionIconKeywords:Embryo Fusion> +[Blood:DescArg1], mendapatkan [StateArg3] poin <PowerIconKeywords:Kekuatan>. Exalt "24" mendapatkan bonus tambahan 300% Kekuatan
<School_4:Ultra>: Kerusakan yang ditimbulkan oleh "24" mendapatkan bonus [StateArg5]% <RetaliateIconKeywords:Counter>. Pada akhir ronde, Shuffle 1 kartu "Ilham" ke Discard Pile, Hand Limit +2.]]
  },
  State_48141_Name = {Text = "Efek Alam"},
  State_48149_Name = {
    Text = "Efek khusus kartu tidak dapat dimainkan__\"Hanya untuk pengembangan\""
  },
  State_48176_Desc = {
    Text = "Dalam sesi percobaan ini, setiap putaran mendapatkan 1 poin Aritmetika, \"24\"setiap kali Lelah 1 poin Aritmetika, mendapatkan 30 poin Energi-s."
  },
  State_48176_Name = {
    Text = "\"24\"Uji Coba"
  },
  State_48198_Desc = {
    Text = "Dalam sesi percobaan ini, kamu akan mendapatkan 1 kartu \"Inspirasi\" setiap putaran."
  },
  State_48198_Name = {
    Text = "\"24\"Uji Coba"
  },
  State_48199_Desc = {
    Text = "Dalam sesi percobaan ini, kamu akan mendapatkan 1 poin Aritmetika setiap putaran."
  },
  State_48199_Name = {
    Text = "\"24\"Uji Coba"
  },
  State_48589_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya dengan kekuatan dua kali lipat."
  },
  State_48589_Name = {Text = "Not Roused"},
  State_48607_Name = {
    Text = "Kekuatan aritmetika asli kartu umum berkurang__\"仅开发用\""
  },
  State_48822_Desc = {
    Text = "Pada awal ronde mekanisme Alam Caro, peningkatan Fusi Embrio yang diperoleh bertambah sebesar 50%."
  },
  State_48822_Name = {
    Text = "Hidup abadi"
  },
  State_48923_Desc = {
    Text = "Bayangan \"24\" sudah Bangun, gunakan \"Tolong aku\" terakhir untuk menemukan kesempatan!"
  },
  State_48923_Name = {
    Text = "Bayangan \"24\"Bangun!"
  },
  State_48923_WeaponDesc = {
    Text = "Pada ronde berikutnya, dapatkan perisai sejumlah kehilangan hidup dari ronde sebelumnya."
  },
  State_49063_Desc = {
    Text = "Kerusakan \"Pukulan\" Lotan meningkat sebesar 30%."
  },
  State_49063_Name = {
    Text = "Semangat Perang yang Tinggi"
  },
  State_49109_Desc = {
    Text = "Kartu yang diperoleh tetap ada, dan jika berada di tangan saat akhir ronde, dapatkan 1 salinan asli dari kartu perintah ini dengan status lelah."
  },
  State_49109_Name = {
    Text = "<Rune_20_High:Inkubasi>"
  },
  State_49109_WeaponDesc = {
    Text = "Setelah digunakan, efek tambahan berlaku sebanyak [StateArg1] kali, Lelah."
  },
  State_49148_Desc = {
    Text = "Setelah kematian, berikan 1 Kartu dengan Lelah Aritmetika tidak sama dengan 0 tambahan \"Distorsi 1\". Distorsi: Negara Kartu, tetap tersisa setelah Pertempuran berakhir. Setiap lapisan mengurangi Lelah Aritmetika sebesar 1, tetapi setelah dimainkan, setiap lapisan akan menambahkan 1 Distorsi acak ke tangan (mengabaikan batas Kartu tangan), dan menghapus semua Distorsi."
  },
  State_49148_Name = {
    Text = "Feto Berubah Bentuk"
  },
  State_49149_Desc = {
    Text = "Setiap lapisan mengurangi konsumsi aritmetika kartu sebesar 1. Setelah dimainkan, untuk setiap lapisan distorsi, tambahkan satu kartu distorsi acak ke tangan, dan hapus negara ini. Negara ini akan tetap ada setelah pertempuran berakhir."
  },
  State_49149_Name = {
    Text = "<ExclamationPointColour:Distorsi [Layer]>"
  },
  State_49149_WeaponDesc = {
    Text = "Setelah digunakan, secara permanen hapus."
  },
  State_49207_Name = {
    Text = "Dapatkan 100 Energi Kunci"
  },
  State_49225_Desc = {
    Text = "Setelah ronde berakhir, 1 Tentakel akan melakukan Serangan sebanyak [Layer] kali."
  },
  State_49225_Name = {
    Text = "<CardKeyWord:Tentakel Berkumpul>"
  },
  State_49226_Desc = {
    Text = "Pada akhir giliran, untuk setiap 1 kartu di tangan, kenakan para musuh 3% racun, dan dapatkan 3 poin aliemus."
  },
  State_49226_Name = {
    Text = "Lilin redup"
  },
  State_49260_Desc = {
    Text = "Pada akhir ronde, pulihkan Hidup sebesar 7,5% dari Konstitusi."
  },
  State_49260_Name = {
    Text = "Rasa Sakit yang Tidak Diterima"
  },
  State_49270_Desc = {
    Text = "Kerusakan kartu serangan meningkat sebesar [Layer]%."
  },
  State_49270_Name = {
    Text = "Kerusakan kartu pukulan meningkat"
  },
  State_49270_WeaponDesc = {
    Text = "Kerusakan kartu serangan meningkat sebesar [Layer]%."
  },
  State_49278_Desc = {
    Text = "Pada akhir ronde, pulihkan hidup sebesar 5% dari hidup yang telah hilang. Jika hidup di bawah 50%([StateArg1]), akan mendapatkan [StateArg2] Kekuatan."
  },
  State_49278_Name = {
    Text = "Altar Merah Muda"
  },
  State_49430_Desc = {
    Text = "Kerusakan yang diterima berkurang, setiap lapisan mengurangi 1%. Setelah sekutu lain meninggal, negara ini akan dihapus."
  },
  State_49430_Name = {
    Text = "<AberrationColour:Menyembunyikan>"
  },
  State_49500_Desc = {
    Text = "Setiap lapisan menambah jumlah serangan sebanyak 1. Saat menerima kerusakan, kehilangan satu lapisan, dan pada akhir giliran, kehilangan semua lapisan."
  },
  State_49500_Name = {Text = "Doa"},
  State_49524_Desc = {
    Text = "Pada akhir ronde, pulihkan hidup sebesar 5% dari total hidup yang telah hilang. Setiap kali pemain menarik 1 Kartu negara atau Kartu gejala, semua \"Nubia\"memperoleh [StateArg1] poin Kekuatan sementara."
  },
  State_49524_Name = {
    Text = "Injil Berdarah"
  },
  State_49526_Desc = {
    Text = "Setelah kematian, segera pulihkan ke [StateArg2] poin Hidup dan kebal terhadap Kerusakan selama 1 putaran, serta menyesuaikan Niat menjadi \"Penyebaran Kotoran\"."
  },
  State_49526_Name = {Text = "Menabur"},
  State_49542_Desc = {
    Text = "Satu-satunya Tim: Setelah pertempuran dimulai, peroleh kekuatan sebesar <WeaponEffect_Num:[StateArg1]%> dari daya serang pemegang perlengkapan. Jika alam saat ini adalah \"Aequor\", juga akan meningkatkan kerusakan tentakel sebesar <WeaponEffect_Num:[StateArg2]%> dari daya serang pemegang perlengkapan."
  },
  State_49542_WeaponDesc = {
    Text = "Setelah pertempuran dimulai, dapatkan <WeaponEffect_Num:[Power:DescArg1]> poin kekuatan. Jika alam saat ini adalah \"Aequor\", juga akan mendapatkan <WeaponEffect_Num:[DescArg2]> poin kerusakan tentakel."
  },
  State_49546_Desc = {
    Text = "Selalu muncul bersama dengan 2 pengawal elit. Setelah kematiannya, mereka juga akan mati."
  },
  State_49546_Name = {Text = "Formasi"},
  State_49547_Desc = {
    Text = "Setelah kematian, berikan [StateArg1] poin Kekuatan kepada Komandan Alan, dan Perisai sebesar 50% dari Kesehatan maksimum."
  },
  State_49547_Name = {Text = "kesetiaan"},
  State_49558_Desc = {
    Text = "Setiap putaran meningkatkan Kekuatan sebesar [StateArg1] poin."
  },
  State_49558_Name = {Text = "Doa Pasir"},
  State_49582_Desc = {
    Text = "Perisai yang tersisa di setiap ronde dalam pertempuran ini tidak akan dihapus dan akan tetap ada."
  },
  State_49582_Name = {
    Text = "Perisai selalu dipertahankan"
  },
  State_49583_Desc = {
    Text = "Pada akhir giliran, dapatkan [StateArg1] poin perisai, dengan tambahan waspada"
  },
  State_49583_Name = {
    Text = "Perisai Aran"
  },
  State_49595_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_49595_Name = {Text = "Not Roused"},
  State_49596_Desc = {
    Text = "\"Pisau Khayalan\"sudah bangun, dia akan mendapatkan lebih banyak perisai dan kekuatan."
  },
  State_49596_Name = {
    Text = "Alva Bangun!"
  },
  State_49596_WeaponDesc = {
    Text = "Pada ronde berikutnya, dapatkan perisai sejumlah kehilangan hidup dari ronde sebelumnya."
  },
  State_49597_Name = {
    Text = "Sudah lumpuh pada giliran ini__\"Hanya untuk pengembangan\""
  },
  State_49600_Desc = {
    Text = "Kelemahan semua musuh selama 2 putaran."
  },
  State_49600_Name = {
    Text = "Darah Ketakutan"
  },
  State_49601_Desc = {
    Text = "Rentan semua musuh selama 2 putaran."
  },
  State_49601_Name = {
    Text = "Darah busuk"
  },
  State_49602_Desc = {
    Text = "Rentan semua musuh selama 1 putaran."
  },
  State_49602_Name = {
    Text = "Darah busuk"
  },
  State_49603_Desc = {
    Text = "Embryo Fusion +[Blood:DescArg1]."
  },
  State_49603_Name = {
    Text = "Darah Reproduksi"
  },
  State_49604_Desc = {
    Text = "Embryo Fusion +[Blood:DescArg1]."
  },
  State_49604_Name = {
    Text = "Darah Reproduksi"
  },
  State_49605_Desc = {
    Text = "Lemahkan semua musuh selama 1 putaran."
  },
  State_49605_Name = {
    Text = "Darah Ketakutan"
  },
  State_49623_Desc = {
    Text = "Pemulihan hidup yang diterima berkurang sebesar [DescArg1]%. Saat giliran berakhir, 1 lapisan akan dihilangkan."
  },
  State_49623_Name = {
    Text = "<BaseDamageColour:Kerusakan Serius>"
  },
  State_49623_WeaponDesc = {
    Text = "Semua kerusakan yang ditimbulkan berkurang sebesar [DescArg1]%."
  },
  State_49627_Desc = {
    Text = "Memulai dengan 2 lapisan <ParcloseIconKeywords:Penghalang>. Saat mati, semua \"Nubia\" mendapatkan [StateArg1] poin Kekuatan."
  },
  State_49627_Name = {
    Text = "Darah mengalir deras"
  },
  State_49628_Desc = {
    Text = "Saat mati, semua \"Nubia\"memperoleh [StateArg1] poin Kekuatan."
  },
  State_49628_Name = {
    Text = "Tautan Darah"
  },
  State_49638_Desc = {
    Text = "Mengidentifikasi apakah itu adalah negara monster seri kambing hitam"
  },
  State_49833_Desc = {
    Text = "Pada akhir ronde, terapkan status \"Kebutaan\" selama 1 ronde pada semua musuh. Jika perisai diri sendiri dihancurkan, batalkan status \"Kebutaan\"."
  },
  State_49833_Name = {
    Text = "Dinding Pasir dan Debu"
  },
  State_49844_Desc = {
    Text = "Satu-satunya Tim: Setelah giliran berakhir, dapatkan <WeaponEffect_Num:[StateArg1]> poin Energi-s. Setelah memicu Ketahanan, dapatkan <WeaponEffect_Num:[StateArg2]> poin Energi-s. Setelah menggunakan Gnosis darurat, batas Aritmetika meningkat 3, dan jumlah kartu yang ditarik per giliran meningkat 3."
  },
  State_49844_WeaponDesc = {
    Text = "Setelah ronde berakhir, dapatkan <WeaponEffect_Num:[StateArg1]> poin Energi-s. Setelah memicu Ketahanan, dapatkan <WeaponEffect_Num:[StateArg2]> poin Energi-s. Setelah menggunakan Gnosis darurat, batas Aritmetika meningkat 3, dan jumlah kartu yang ditarik per ronde meningkat 3."
  },
  State_49877_Desc = {
    Text = "Mengurangi konsumsi aritmetika kartu. Setelah dimainkan, untuk setiap 1 lapisan distorsi, tambahkan satu kartu distorsi acak ke tangan dan hapus negara ini. Negara ini akan tetap ada setelah pertempuran berakhir."
  },
  State_49877_Name = {
    Text = "<AberrationKeywords:Penyimpangan>"
  },
  State_49877_WeaponDesc = {
    Text = "Setiap lapisan kelambatan meningkatkan kelelahan aritmetika kartu sebesar 1 poin."
  },
  State_49954_Desc = {
    Text = "Semua atribut Crit. DMG Pembangun berkurang menjadi setengah."
  },
  State_49954_Name = {
    Text = "<BlindingKeywords: Kebutaan>"
  },
  State_49954_WeaponDesc = {
    Text = "Setiap lapisan kelambatan meningkatkan kelelahan aritmetika kartu sebesar 1 poin."
  },
  State_49957_Desc = {
    Text = "Saat menerima Active DMG, Sealed Exalt dan semua Kartu milik Awakener yang menyerang selama 1 giliran, hapus 1 stack <ResentChainsKeywords:Rantai Kebencian>. Dihapus saat giliran berakhir."
  },
  State_49957_Name = {
    Text = "<ResentChainsKeywords: Rantai Kebencian>"
  },
  State_49957_WeaponDesc = {
    Text = "Setiap lapisan kelambatan meningkatkan kelelahan aritmetika kartu sebesar 1 poin."
  },
  State_49958_Desc = {
    Text = "Saat menerima Active DMG dan kerusakan tentakel, Sealed Exalt dan semua Kartu yang menyerang Awakener selama 1 giliran, hapus 1 stacks <ResentChainsKeywords:Rantai Kebencian>."
  },
  State_49958_Name = {
    Text = "<ResentChainsKeywords1:Rantai Kebencian>"
  },
  State_49959_Desc = {
    Text = "Di awal setiap ronde, dapatkan 1 lapisan <ResentChainsKeywords:Rantai Kebencian>."
  },
  State_49959_Name = {
    Text = "Kunci Multidimensi"
  },
  State_50010_Desc = {
    Text = "Pemulihan Hidup yang diterima berkurang sebesar 25%. Saat giliran berakhir, 1 lapis akan dihilangkan."
  },
  State_50010_Name = {
    Text = "<HeavyInjuryKeywords:Luka Berat>"
  },
  State_50021_Desc = {
    Text = "Tim Unik: Setelah Pemakai melepaskan Exalt, mendapatkan <PowerIconKeywords:Kekuatan> setara <WeaponEffect_Num:[StateArg1]%> ATK Pemakai. Jika Realm saat ini adalah \"Caro\", setelah melepaskan Exalt, Embryo Fusion <WeaponEffect_Num:+[Blood:StateArg2]> ."
  },
  State_50021_WeaponDesc = {
    Text = "Setelah Pemakai melepaskan Exalt, mendapatkan <WeaponEffect_Num:[Power:DescArg1]> poin <PowerIconKeywords:Kekuatan>. Jika Realm saat ini adalah \"Caro\", setelah melepaskan Exalt, Embryo Fusion <WeaponEffect_Num:+[Blood:StateArg2]> ."
  },
  State_50302_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Tahan 1 kali kematian dan hancurkan \"Roda takdir\" ini, dapatkan [StateArg1] lapisan <PVPProtectiveKeywords:Penghalang>. Jika menjadi satu-satunya sekutu yang masih hidup saat efek berlaku, dapatkan [StateArg2]\"Kunci Perintah\" acak di awal giliran berikutnya."
  },
  State_50302_Name = {
    Text = "Senja dan Fajar"
  },
  State_50323_Desc = {
    Text = "Sebelum ronde berikutnya dimulai, dapatkan [Layer] Geng acak."
  },
  State_50323_Name = {
    Text = "Geng Tertunda"
  },
  State_50333_Desc = {
    Text = "Pada akhir ronde, semua Awakener kehilangan Aliemus."
  },
  State_50333_Name = {
    Text = "<EmptinessKeywords: Kekosongan>"
  },
  State_50333_WeaponDesc = {
    Text = "Setiap lapisan kelambatan meningkatkan kelelahan aritmetika kartu sebesar 1 poin."
  },
  State_50352_Name = {Text = "Thais Demo"},
  State_50353_Name = {Text = "Thais Demo"},
  State_50358_Desc = {
    Text = "Kerusakan yang diterima berkurang, setiap lapisan mengurangi 1%. Setelah sekutu lain meninggal, negara ini akan dihapus."
  },
  State_50358_Name = {
    Text = "<ConcealmentKeywords:Menyembunyikan>"
  },
  State_50375_Desc = {
    Text = "Efek ini termasuk: diri sendiri mendapatkan 10 poin Aliemus, sekutu lainnya mendapatkan 5 poin Aliemus, memberikan 1 lapis Rentan kepada semua musuh, memberikan 1 lapis Kelemahan kepada semua musuh, menarik 1 kartu, mendapatkan 200 poin Energi-s."
  },
  State_50375_Name = {
    Text = "<MysterybuffKeywords:Efek Positif Ajaib>"
  },
  State_50389_Desc = {
    Text = "Pada awal ronde, tempatkan satu kartu \"Dadu Keberuntungan Ryker\" di tangan."
  },
  State_50389_Name = {
    Text = "Dukungan Ryker"
  },
  State_50390_Desc = {
    Text = "Pada awal giliran, dapatkan [StateArg1] poin Kekuatan."
  },
  State_50390_Name = {
    Text = "Wawasan pertempuran"
  },
  State_50491_Name = {
    Text = "Pendulum Waktu \"Seimbang\""
  },
  State_50735_Desc = {
    Text = "Ketika kekalahan pertama kali akan datang, pulihkan hidup dan ubah niat menjadi \"Robekan Duka\", menyebabkan kerusakan tunggal yang sangat besar."
  },
  State_50735_Name = {
    Text = "Ketegaran yang Tidak Berguna"
  },
  State_50854_Desc = {
    Text = "Pada awal pertempuran, dapatkan [StateArg1] poin <RetaliateIconKeywords:Counter>. Setelah giliran berakhir, dapatkan [StateArg2] poin perisai, dan setiap giliran perisai ini meningkat sebesar [StateArg3]."
  },
  State_50854_Name = {
    Text = "Kulit Pohon yang Kuat"
  },
  State_50861_Desc = {
    Text = "Tidak lagi menerima kerusakan, bersiap untuk melepaskan \"Ibu dari Ribuan Anak\"."
  },
  State_50861_Name = {Text = "Derived"},
  State_50862_Desc = {
    Text = "Tidak lagi menerima kerusakan, bersiap untuk melepaskan \"Pembiakan\"."
  },
  State_50862_Name = {Text = "penetasan"},
  State_50863_Desc = {
    Text = "Tidak lagi menerima kerusakan, bersiap untuk melepaskan \"Wild Tree Sap\"."
  },
  State_50863_Name = {Text = "Imun"},
  State_50864_Desc = {
    Text = "Tidak lagi menerima kerusakan, bersiap untuk melepaskan \"getah pohon\"."
  },
  State_50864_Name = {Text = "Imun"},
  State_50891_Desc = {
    Text = "Tidak lagi menerima kerusakan, bersiap untuk melepaskan \"Fusi Ganda\"."
  },
  State_50891_Name = {Text = "Devour"},
  State_51016_Desc = {
    Text = "Efek Racun yang diterima menjadi 1000%."
  },
  State_51016_Name = {
    Text = "Kayu kering dan busuk"
  },
  State_51017_Desc = {
    Text = "Efek racun yang diterima menjadi 500%."
  },
  State_51017_Name = {
    Text = "Kayu kering dan busuk"
  },
  State_51607_Desc = {
    Text = "Kebal terhadap semua kerusakan. Efek ini akan dihilangkan setelah giliran dimulai."
  },
  State_51607_Name = {
    Text = "Kekebalan terhadap kerusakan"
  },
  State_51695_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_51695_Name = {Text = "Not Roused"},
  State_51696_Desc = {
    Text = "\"Utusan Laut\"sudah Bangun, dia memiliki kemampuan yang lebih kuat untuk melawan Muliakan."
  },
  State_51696_Name = {
    Text = "Miryam Bangun!"
  },
  State_51696_WeaponDesc = {
    Text = "Pada ronde berikutnya, dapatkan perisai sejumlah kehilangan hidup dari ronde sebelumnya."
  },
  State_51739_Desc = {
    Text = "Pada akhir ronde, dapatkan 1 \"Fatamorgana Ranah Dewa\" secara acak, tidak dapat dihilangkan."
  },
  State_51739_Name = {
    Text = "Akhir dari Iman"
  },
  State_51740_Desc = {
    Text = "Pada awal pertempuran, letakkan 1 kartu \"Kegaguman Buta\" ke dalam tangan."
  },
  State_51740_Name = {
    Text = "Kesetiaan Tidak Lekas Padam"
  },
  State_51741_Desc = {
    Text = "Pada awal ronde, dapatkan [Layer] poin Perisai, tidak dapat dihilangkan."
  },
  State_51741_Name = {
    Text = "Tetap setia pada diri sendiri"
  },
  State_51742_Desc = {
    Text = "Pada awal ronde, dapatkan [Layer] poin kerusakan tentakel dan kekuatan, tidak dapat dihilangkan."
  },
  State_51742_Name = {
    Text = "Menyerahkan diri pada Wahyu"
  },
  State_51743_Desc = {
    Text = "Pada giliran ini, setiap serangan Tentakel akan mendapatkan efek berikut berdasarkan postur Tentakel: Arus Tinggi: semua Awakener mendapatkan <Energy:[Energy:StateArg1]> poin Aliemus; Lautan Tenang: menyebabkan [StateArg2] poin <IntoxicationIconKeywords:Racun> pada semua musuh; Ombak Bergelora: <TentacleInjurieIconKeywords:Kerusakan tentakel> sementara +[StateArg3]."
  },
  State_51743_Name = {
    Text = "Doa Ibu Dewi"
  },
  State_51745_Desc = {
    Text = "Ketika Utusan Laut memainkan 1 kartu, hasilkan [StateArg1] Tentakel sementara yang dapat mengabaikan batas maksimal Tentakel."
  },
  State_51745_Name = {
    Text = "Kekuatan Pengganti"
  },
  State_51745_WeaponDesc = {
    Text = "Ketika Utusan Laut memainkan 1 kartu, hasilkan [StateArg1] Tentakel sementara yang dapat mengabaikan batas maksimal Tentakel."
  },
  State_51811_Name = {
    Text = "Efek Penyembuhan Layar Pemandu__\"Hanya untuk pengembangan\""
  },
  State_51813_Desc = {
    Text = "Setelah ronde berakhir, konsumsi aritmetika -[Layer], Efek ini juga akan terpicu setelah dibuang."
  },
  State_51813_Name = {
    Text = "<PrepareKeypvewordscolour:Persiapan[Layer]>"
  },
  State_51820_Desc = {
    Text = "\"Menghasilkan\"memperoleh efek tambahan: Saat mencapai 5 lapisan, segera memanggil 1 \"Anak Air\", maksimal terdapat 2 \"Anak Air\"."
  },
  State_51820_Name = {
    Text = "Miryam Bangun"
  },
  State_51822_Desc = {
    Text = "Setiap kali melepaskan Aliemus Muliakan, tambahkan 1 lapis \"Mengandung\". Setiap lapis \"Mengandung\"memberikan [StateArg1] poin Kekuatan, dengan batas maksimal 5 lapis."
  },
  State_51822_Name = {
    Text = "Penurunan Akhir Lemuria"
  },
  State_52068_Desc = {
    Text = "Ubah hingga maksimal 3 kartu \"Sakramen\" di tangan menjadi \"Kegigihan\", dan dapatkan Efek tambahan pada berbagai tahap berdasarkan jumlah yang diubah."
  },
  State_52068_Name = {
    Text = "<CardKeyWord:Upacara>"
  },
  State_52087_Desc = {
    Text = "\"Burung Surga Abadi\"setelah [Layer] putaran, baru dapat diberikan negara kebangkitan kembali."
  },
  State_52087_Name = {
    Text = "Waktu pendinginan pemulihan hidup"
  },
  State_52116_Desc = {
    Text = "Sebelum ronde berakhir, Pembangun yang menggunakan ledakan Aliemus menerima [Layer] kerusakan."
  },
  State_52116_Name = {Text = "Exalt Lock"},
  State_52369_Desc = {
    Text = "Setelah memainkan [DescArg1] kartu gejala, dapatkan kartu dukungan Tulu \"Kekuasaan\": Menyebabkan kerusakan besar dan membuat target pingsan selama 1 putaran."
  },
  State_52369_Name = {
    Text = "Ranah dewa pasti akan kembali"
  },
  State_53115_Desc = {
    Text = "Efek \"Ritual\" yang dipicu oleh Miryam pada giliran ini meningkat sebesar 50%."
  },
  State_53115_Name = {
    Text = "Doa pada Jurang"
  },
  State_53144_Desc = {
    Text = "Pada awal setiap giliran, dapatkan <Block:[Block:StateArg1]> poin Perisai."
  },
  State_53144_Name = {
    Text = "<CardKeyWord:Bertahan Diri>"
  },
  State_53145_Desc = {
    Text = "Pada awal setiap giliran <PowerIconKeywords:Kekuatan> dan <TentacleInjurieIconKeywords:Kerusakan Tentakel> +[StateArg2]."
  },
  State_53145_Name = {
    Text = "<CardKeyWord: Dedikasi kepada Wahyu>"
  },
  State_53673_Desc = {
    Text = "Jumlah maksimal kartu yang bisa diperoleh dari pembelahan kelenjar adalah 10."
  },
  State_53673_Name = {
    Text = "Batasan Pembelahan Kelenjar"
  },
  State_53674_Desc = {
    Text = "Batas kartu tangan +2. Pada awal giliran, Miryam mendapatkan 20 poin Aliemus."
  },
  State_53674_Name = {
    Text = "Miryam Playtest"
  },
  State_53755_Desc = {
    Text = "Semua <PowerIconKeywords:Kekuatan>, <RetaliateIconKeywords:Counter>, dan <IntoxicationIconKeywords:Racun> yang diberikan oleh Pembangun meningkat sebesar [DescArg1]%. <PowerIconKeywords:Kekuatan> yang diberikan oleh \"Babak Kemewahan\"juga meningkat."
  },
  State_53755_Name = {
    Text = "Puisi misterius·Takut"
  },
  State_53756_Desc = {
    Text = "Semua Pembangun meningkatkan Aliemus sebesar [DescArg1]%. Aritmetika dan Kartu perintah pada akhir ronde dapat disimpan hingga ronde berikutnya. \"Fenomena Fragmen\"meningkatkan Aliemus."
  },
  State_53756_Name = {
    Text = "Puisi Gaib·Sukacita"
  },
  State_53758_Desc = {
    Text = "Semua kerusakan akhir yang ditimbulkan oleh Pembangun meningkat sebesar [DescArg1]%, dan peningkatan Tingkat Kritis serta Kerusakan Kritis dari \"Babak Kemewahan\"juga ditingkatkan."
  },
  State_53758_Name = {
    Text = "Sajak Liar·Kemarahan"
  },
  State_53759_Desc = {
    Text = "Semua Pembangun memberikan efek penurunan <PowerIconKeywords:Kekuatan> sebesar [DescArg1]%, meningkatkan perisai dan pemulihan hidup, serta meningkatkan efek pemulihan dari \"Babak Kemegahan\"."
  },
  State_53759_Name = {
    Text = "Kitab Ratapan·Ratapan"
  },
  State_53772_Name = {
    Text = "Aksesoris Paradoks Dua Hukum"
  },
  State_53772_WeaponDesc = {
    Text = "Setelah pemakai menggunakan Muliakan, sekutu akan memperoleh <RetaliateIconKeywords:Counter> berdasarkan 100% dari Pertahanan pemakai. Dan meningkatkan <RetaliateIconKeywords:Counter> saat ini sebesar 10%."
  },
  State_53870_Name = {
    Text = "Aksesori 36 Kamar"
  },
  State_53870_WeaponDesc = {
    Text = "Saat mendapatkan Kartu pemilik peralatan, Aritmetikanya akan berubah secara acak antara 0-3."
  },
  State_53981_Name = {
    Text = "Mimpi Aksesori Menjadi Obat Segil Hitam: Koreksi"
  },
  State_53981_WeaponDesc = {
    Text = "Setelah pertempuran dimulai, satu set kartu pemain akan dicampurkan ke dalam tumpukan menggambar secara tambahan."
  },
  State_54002_Name = {
    Text = "Negara@Aksesori Mimpi Pengobatan Tanda Filter"
  },
  State_54002_WeaponDesc = {
    Text = "Setelah pemakai menggunakan Muliakan, sekutu akan memperoleh <RetaliateIconKeywords:Counter> berdasarkan 100% dari Pertahanan pemakai. Dan meningkatkan <RetaliateIconKeywords:Counter> saat ini sebesar 10%."
  },
  State_54011_Name = {
    Text = "Negara@Aksesori Mimpi Pengobatan Salinan 1 Tersedia"
  },
  State_54011_WeaponDesc = {
    Text = "Setelah pemakai menggunakan Muliakan, sekutu akan memperoleh <RetaliateIconKeywords:Counter> berdasarkan 100% dari Pertahanan pemakai. Dan meningkatkan <RetaliateIconKeywords:Counter> saat ini sebesar 10%."
  },
  State_54012_Name = {
    Text = "Negara@Aksesori Mimpi Pengobatan Duplikat 2 Tersedia"
  },
  State_54012_WeaponDesc = {
    Text = "Setelah pemakai menggunakan Muliakan, sekutu akan memperoleh <RetaliateIconKeywords:Counter> berdasarkan 100% dari Pertahanan pemakai. Dan meningkatkan <RetaliateIconKeywords:Counter> saat ini sebesar 10%."
  },
  State_54013_Desc = {
    Text = "Dalam ronde ini, penguasaan Alam meningkat sebesar [Layer] poin."
  },
  State_54013_Name = {
    Text = "Penguasaan Alam Sementara"
  },
  State_54014_Desc = {
    Text = "Penguasaan Alam meningkat sebesar [Layer] poin."
  },
  State_54014_Name = {
    Text = "Realm Mastery"
  },
  State_54043_WeaponDesc = {
    Text = "Setelah pemakai menggunakan Muliakan, efek Kuat dari Perisai dan Sembuh mereka akan dilipatgandakan dalam ronde ini."
  },
  State_54044_Desc = {
    Text = "Memberikan Kerusakan dua kali lipat dan mendapatkan tambahan Keyflare sebesar 600% setara dengan Keyflare Regen Ramona melingkar, namun <DepleteIconKeywords:habis> setelah dimainkan."
  },
  State_54044_Name = {
    Text = "Pujian Masa Depan"
  },
  State_54045_Desc = {
    Text = "Mendapatkan 3 poin Aritmetika."
  },
  State_54045_Name = {
    Text = "Taman Siklus Abadi"
  },
  State_54046_Desc = {
    Text = "Pada awal ronde, pulihkan [StateArg1] poin hidup selama [Layer] ronde."
  },
  State_54046_Name = {
    Text = "Rasionalitas, Kebenaran dan Kenyataan"
  },
  State_54071_Desc = {
    Text = "Jumlah Active DMG yang ditimbulkan Ogier +1, berlangsung selama [Layer] giliran."
  },
  State_54071_Name = {
    Text = "Tujuh Seni, Delapan Kebajikan"
  },
  State_54121_Desc = {
    Text = "Dalam pertempuran ini, kerusakan dasar yang diberikan oleh \"Binatang kekacauan\" meningkat sebesar [Layer]%."
  },
  State_54121_Name = {
    Text = "Hewan Buas Penghancur"
  },
  State_54138_Desc = {
    Text = "Kartu perintah yang dikeluarkan oleh Sorel pada [Layer] berlaku sebanyak 2 kali."
  },
  State_54138_Name = {
    Text = "Roda Ambisi"
  },
  State_54384_Desc = {
    Text = "Meningkatkan <IntoxicationIconKeywords:Racun> yang dihasilkan oleh Nymphaea sebesar 50%, berlangsung selama [Layer] putaran."
  },
  State_54384_Name = {
    Text = "Lintasan Ego"
  },
  State_54416_Desc = {
    Text = "Membuka Awakener yang dapat mengumpulkan dua kali Aliemus. Ketika Aliemus mencapai dua kali Aliemus dasar, kamu dapat melepaskan Over-Exaltation. Setelah melepaskan Exalt, sisa Aliemus berkurang setengah."
  },
  State_54416_Name = {
    Text = "<OverLimitUtlSkillKeywords:Pemuliaan berlebihan>"
  },
  State_54416_WeaponDesc = {
    Text = "Menghabiskan embrio di tangan lelah, memicu efek melahap yang kuat."
  },
  State_54561_Desc = {
    Text = "Satu-satunya Tim: Nilai kerusakan yang diberikan oleh pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%> dari daya serang pemakai. Jika alam saat ini adalah \"Caro\", setiap kali pemakai memicu efek melahap, nilai kerusakan yang diberikan oleh pemakai akan meningkat tambahan sebesar 3% dari daya serang pemakai."
  },
  State_54561_WeaponDesc = {
    Text = "Kerusakan yang diberikan oleh pemakai meningkat sebesar [DescArg1] poin. Jika alam saat ini adalah \"Caro\", setiap kali pemakai memicu efek melahap, kerusakan yang diberikan oleh pemakai akan meningkat tambahan sebesar [DescArg2] poin."
  },
  State_54568_Name = {
    Text = "Hingga akhir"
  },
  State_54597_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setelah Pembangun musuh mati, dapatkan [StateArg1] <StrongEffectKeywords:Amplifikasi>, tempatkan \"Keterampilan\" dengan konsumsi aritmetika tertinggi yang disertai<PVPVoidKeywords:Nihil>ke tanganmu."
  },
  State_54597_Name = {
    Text = "Tatapan Seribu Kasih"
  },
  State_54704_Desc = {
    Text = "\"24\"kartu perintah berikutnya berlaku sebanyak 3 kali."
  },
  State_54704_Name = {
    Text = "Belitan Mayat"
  },
  State_54798_Desc = {
    Text = "Semua Pembangun memberikan efek perisai, pemulihan hidup, dan pengurangan Kekuatan yang meningkat sebesar [StateArg1]%. Efek pemulihan dari Fenhua Chapter juga ditingkatkan."
  },
  State_54798_Name = {
    Text = "\"Kesedihan\""
  },
  State_54799_Desc = {
    Text = "Semua Pembangun memberikan efek Counter, Racun, dan perolehan Kekuatan yang meningkat sebesar [StateArg1]%. Kekuatan dari Bab Kemewahan juga meningkat."
  },
  State_54799_Name = {Text = "\"Takut\""},
  State_54800_Desc = {
    Text = "Semua kerusakan akhir yang ditimbulkan oleh Pembangun meningkat sebesar [StateArg1]%, dan Crit. Rate serta Crit. DMG dari Fenhua Chapter juga meningkat."
  },
  State_54800_Name = {
    Text = "\"Kemarahan\""
  },
  State_55108_Desc = {
    Text = "Pada awal giliran, tingkatkan \"Api Hijau\" atau \"Api Hijau yang Terkorupsi\" di tangan menjadi \"Api Hijau Kematian\", berlangsung selama [Layer] giliran."
  },
  State_55108_Name = {
    Text = "Tanda Kematian Tiba"
  },
  State_55108_WeaponDesc = {
    Text = "Pada awal giliran, jika berada di tangan atau ruang Ultra akan mendapatkan Memperkuat"
  },
  State_55113_Desc = {
    Text = "Setelah Horla memainkan kartu Mazmur pertamanya setiap ronde, dia mendapatkan 10 Aliemus."
  },
  State_55113_Name = {
    Text = "Pertemuan Kembali Bunga dan Puisi"
  },
  State_55465_Name = {
    Text = "Menghabiskan [Layer] lapisan metafora \"Kemarahan\", memberikan kerusakan tambahan sebanyak [DescArg1] kali"
  },
  State_55466_Name = {
    Text = "Mengonsumsi [Layer] lapisan metafora \"Kesedihan\", pulihkan <Heal:[Heal:DescArg1]> poin hidup"
  },
  State_55467_Name = {
    Text = "Menghabiskan [Layer] lapisan metafora \"Takut\", mendapatkan tambahan [Power:DescArg1] poin <PowerIconKeywords:Kekuatan>"
  },
  State_55469_Name = {
    Text = "Lelah [Layer] lapisan metafora \"Senang\", mendapatkan tambahan <Energy:[Energy:DescArg1]> poin Aliemus"
  },
  State_55470_Name = {
    Text = "Pemenggalan"
  },
  State_55485_Desc = {
    Text = "[Layer] kartu berikutnya yang dimainkan Cassia mendapatkan Kekuatan sebesar 10% dari serangan dirinya."
  },
  State_55485_Name = {
    Text = "Tertawa lepas"
  },
  State_55486_Name = {
    Text = "Ibu Kota Mimpi Mati Pemuliaan Berlebihan Bebas dari Konsumsi Lelah Mimpi"
  },
  State_55487_Desc = {
    Text = "\"Pukulan\"Erica memberikan 2 kali kerusakan tambahan, \"Pertahanan\"memberikan 2 perisai tambahan, berlangsung selama [Layer] putaran."
  },
  State_55487_Name = {
    Text = "Perhitungan ganda"
  },
  State_55489_Name = {
    Text = "Lompatan Ruang-Waktu"
  },
  State_55806_Name = {
    Text = "<PoetryKeywords:Persembahan>: Memberikan efek negatif <PVPWonderfulEffectKeywords:Efek Menakjubkan> kepada semua musuh, atau memberikan efek positif <PVPWonderfulEffectKeywords:Efek Menakjubkan> kepada semua sekutu, atau menarik 1 kartu dan mendapatkan 1 Aritmetika. Persembahan terakhir berlaku 2 kali"
  },
  State_55807_Name = {
    Text = "Tarik 1 kartu, dapatkan 1 Aritmetika"
  },
  State_55808_Name = {
    Text = "<PoetryKeywords:Persembahan>:Memberikan efek positif <PVPWonderfulEffectKeywords:Efek Menakjubkan> kepada semua sekutu, atau tarik 1 kartu dan dapatkan 1 Aritmetika. Persembahan terakhir berlaku 2 kali"
  },
  State_55809_Name = {
    Text = "Memberikan efek negatif <PVPWonderfulEffectKeywords:Efek Menakjubkan> kepada semua musuh"
  },
  State_55811_Desc = {
    Text = "Pilih salah satu opsi yang tercantum untuk diterapkan."
  },
  State_55811_Name = {
    Text = "<ComaColour: Pilihan>"
  },
  State_55813_Name = {
    Text = "<PoetryKeywords:Persembahan>:Memberikan efek negatif <PVPWonderfulEffectKeywords:Efek Menakjubkan> kepada semua musuh, atau menarik 1 kartu dan mendapatkan 1 Aritmetika. Persembahan terakhir berlaku 2 kali"
  },
  State_55814_Name = {
    Text = "<PoetryKeywords:Persembahan>:Memberikan efek negatif <PVPWonderfulEffectKeywords:Efek Ajaib> kepada semua musuh atau memberikan efek positif <PVPWonderfulEffectKeywords:Efek Ajaib> kepada semua sekutu. Persembahan terakhir berlaku 2 kali"
  },
  State_55816_Name = {
    Text = "Memberikan efek positif <PVPWonderfulEffectKeywords:Efek Menakjubkan> kepada semua sekutu"
  },
  State_55824_Desc = {
    Text = "Pilih salah satu opsi dari daftar untuk diaktifkan. Setelah dipilih, hapus opsi tersebut. Jika masih ada opsi tersisa, kartu ini akan dimasukkan ke tangan lawan."
  },
  State_55824_Name = {
    Text = "<ComaColour:Persembahan>"
  },
  State_55836_Desc = {
    Text = "Pada akhir ronde, konsumsi aritmetika kartu perintah Horla di tangan -1."
  },
  State_55836_Name = {
    Text = "Tinta Menjadi Puisi"
  },
  State_55839_Desc = {
    Text = "Kehilangan semua Relik lain saat diambil, secara acak mendapatkan 2 Relik emas."
  },
  State_55866_Desc = {
    Text = "Satu-satunya tim: Saat pertempuran dimulai, tarik 1 Kartu perintah pemilik peralatan, dan ada peluang sebesar <WeaponEffect_Num:[StateArg1]%> untuk mengurangi Lelah Aritmetika sebesar 1. Setiap kali Ketahanan terpicu, efek ini akan diulang sekali."
  },
  State_55866_WeaponDesc = {
    Text = "Pada saat pertempuran dimulai, tarik 1 Kartu perintah pemilik peralatan, dan ada peluang sebesar <WeaponEffect_Num:[StateArg1]%> untuk mengurangi Lelah Aritmetika sebesar 1. Setiap kali Ketahanan terpicu, efek ini akan terpicu kembali sebanyak 1 kali."
  },
  State_55992_Desc = {
    Text = "Ketika aritmetika tidak mencukupi, kartu akan dikenai lelah dan tanda."
  },
  State_55992_Name = {Text = "Abu sisa"},
  State_55993_Name = {Text = "Tanda abu"},
  State_56018_Desc = {
    Text = "Dalam pertempuran ini, kesehatan maksimum meningkat sebesar [Layer]%."
  },
  State_56018_Name = {
    Text = "Berkah muzus - Nasib"
  },
  State_56020_Desc = {
    Text = "Dalam pertempuran ini, kerusakan meningkat sebesar [Layer]%."
  },
  State_56020_Name = {
    Text = "Berkah muzus-Kekuatan"
  },
  State_56030_Desc = {
    Text = "Dalam putaran ini, Perisai dan penyembuhan yang dihasilkan oleh Pembangun meningkat sebesar [Layer]%."
  },
  State_56030_Name = {Text = "Salju"},
  State_56031_Desc = {
    Text = "Setiap kali memberikan 1 kerusakan dalam ronde ini, Crit. Rate sementara meningkat sebesar [Layer]%."
  },
  State_56031_Name = {Text = "Kupu-Kupu"},
  State_56034_Desc = {
    Text = [[
Setiap "metafor"maksimal 3 lapis. Metafor yang berbeda akan meningkatkan efek yang berbeda dari puisi: 
<D06CardKeyWordnu:Puisi khayalan>: Mengonsumsi semua metafor "marah", setiap lapis metafor memberikan tambahan 2 kali kerusakan. 
<D06CardKeyWordai:Puisi ratapan>: Mengonsumsi semua metafor "sedih", setiap lapis metafor memberikan tambahan pemulihan hidup. 
<D06CardKeyWordxi:Puisi gaib>: Mengonsumsi semua metafor "gembira", setiap lapis metafor memberikan tambahan 10 poin aliemus. 
<D06CardKeyWordju:Puisi misterius>: Mengonsumsi semua metafor "takut", setiap lapis metafor memberikan tambahan <PowerIconKeywords:kekuatan>.]]
  },
  State_56034_Name = {Text = "Metaphor"},
  State_56208_Desc = {
    Text = [[
Ratapan Hujan: Balas <Heal:[DescArg1]> poin HP.
Senandung Angin: Dapatkan [DescArg2] poin <PowerIconKeywords:Strength>.
Himne Sang Bunga: Semua Tubuh Terjaga mendapatkan [DescArg3] poin Aliemus.
Himne Rembulan: Tingkat Kritis Sementara meningkat [DescArg4]%.]]
  },
  State_56208_Name = {
    Text = "Halaman Puisi"
  },
  State_56330_Desc = {
    Text = "Mendapatkan [DescArg1] poin perisai, jika dalam giliran ini telah melepaskan 3 kali Muliakan, kartu ini akan berfungsi tambahan 1 kali."
  },
  State_56330_Name = {
    Text = "Imageri Lanjutan"
  },
  State_56331_Desc = {
    Text = "Pilih 1 Kartu Perintah dari Tumpukan Kartu Menggambar dan Tumpukan Kartu Buang untuk dimasukkan ke tangan, dan kurangi Lelah Aritmetika sebesar 2."
  },
  State_56331_Name = {
    Text = "Imageri Lanjutan"
  },
  State_56332_Desc = {
    Text = "Mendapatkan [DescArg1] poin sementara <PowerIconKeywords:Kekuatan>. Setelah digunakan, untuk setiap 1 kerusakan yang diberikan dalam ronde ini, Crit. Rate sementara meningkat +3%."
  },
  State_56332_Name = {
    Text = "Imageri Lanjutan"
  },
  State_56333_Desc = {
    Text = "Pulihkan 10% dari Hidup yang hilang. Jika Hidup saat ini di bawah 25%, kartu ini akan berlaku tambahan 1 kali."
  },
  State_56333_Name = {
    Text = "Imageri Lanjutan"
  },
  State_56334_Desc = {
    Text = "Geng berikutnya akan aktif sebanyak 2 kali."
  },
  State_56334_Name = {
    Text = "Imageri Lanjutan"
  },
  State_56335_Desc = {
    Text = "Menimbulkan <FixedDamage:Kerusakan Murni> sebesar 150% dari Max HP sendiri, kerusakan ini mendapat bonus <PowerIconKeywords:STR> sebesar 10 kali lipat."
  },
  State_56335_Name = {
    Text = "Imageri Lanjutan"
  },
  State_56336_Desc = {
    Text = "Ambil 5 kartu."
  },
  State_56336_Name = {
    Text = "Imageri Lanjutan"
  },
  State_56337_Desc = {
    Text = "Mendapatkan [DescArg1] poin sementara <AlertIconKeywords:Waspada>. Setelah digunakan, perisai dan penyembuhan yang diberikan pada giliran ini meningkat sebesar [DescArg2]%."
  },
  State_56337_Name = {
    Text = "Imageri Lanjutan"
  },
  State_56338_Desc = {
    Text = "Mendapatkan 3 poin Aritmetika."
  },
  State_56338_Name = {
    Text = "Imageri Lanjutan"
  },
  State_56339_Desc = {
    Text = "Menghilangkan 1 Negara negatif secara acak. Kartu ini berlaku tambahan 3 kali, Lelah."
  },
  State_56339_Name = {
    Text = "Imageri Lanjutan"
  },
  State_56340_Desc = {
    Text = "Terapkan <VulnerabilityIconKeywords:Rentan> selama 3 ronde pada semua musuh. Setiap kali ada musuh yang mati, pindahkan kartu ini dari dek ke tangan."
  },
  State_56340_Name = {
    Text = "Imageri Lanjutan"
  },
  State_56341_Desc = {
    Text = "Penguasaan Alam +25, Penguasaan Alam Sementara +125."
  },
  State_56341_Name = {
    Text = "Imageri Lanjutan"
  },
  State_56342_Desc = {
    Text = "Semua Pembangun mendapatkan 15 poin Aliemus."
  },
  State_56342_Name = {
    Text = "Imageri Lanjutan"
  },
  State_56343_Desc = {
    Text = "Terapkan <WeaknessIconKeywords:Kelemahan> selama 3 ronde pada semua musuh, letakkan 1 salinan kartu ini ke Tumpukan kartu buang, tambahkan <DepleteIconKeywords:Lelah>, <NothingnessIconKeywords:Ilusi>."
  },
  State_56343_Name = {
    Text = "Imageri Lanjutan"
  },
  State_56372_Desc = {
    Text = "Menghapus 1 Negara negatif terakhir yang diperoleh pemain saat kematian."
  },
  State_56372_Name = {
    Text = "Bunga dan Puisi"
  },
  State_56400_Desc = {
    Text = "Setelah \"Serangan\",\"Keterampilan\" milik sendiri di tangan akan berubah secara berurutan menjadi \"Keterampilan\" lainnya [ShowIfState:， <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]."
  },
  State_56400_Name = {
    Text = "Bunga dan Puisi dari Masa Lalu"
  },
  State_56402_Desc = {
    Text = [[
Memiliki metafora<D06CardKeyWordnu:"Kemarahan"> [DescArg2] lapisan: "Puisi gila"akan memberikan kerusakan tambahan saat terpicu lompatan.
Memiliki metafora<D06CardKeyWordai:"Kesedihan"> [DescArg3] lapisan: "Puisi duka"akan memulihkan hidup tambahan saat terpicu lompatan.
Memiliki metafora<D06CardKeyWordxi:"Kebahagiaan"> [DescArg1] lapisan: "Puisi gaib"akan memberikan aliemus tambahan kepada Pembangun saat terpicu lompatan.
Memiliki metafora<D06CardKeyWordju:"Ketakutan"> [DescArg4] lapisan: "Puisi misterius"akan memberikan kekuatan tambahan saat terpicu lompatan.]]
  },
  State_56402_Name = {Text = "Metaphor"},
  State_57166_Desc = {
    Text = "Kerusakan yang ditimbulkan oleh Bangun meningkat sebesar 25%."
  },
  State_57170_Desc = {
    Text = "Batas kartu tangan +2, pada akhir ronde pilih 1 kartu tangan untuk disimpan dan kurangi Lelah aritmetikanya -1, berlangsung selama 3 ronde."
  },
  State_57170_Name = {
    Text = "Cahaya penuntun"
  },
  State_57316_Desc = {
    Text = "Pada awal setiap ronde, ubah 1 \"Embryo\" menjadi \"Anak Kudus\". Jika tidak ada \"Embryo\", <EmbryoFusionIconKeywords:Embryo Fusion> +[Blood:DescArg1], tidak dipengaruhi oleh efek peningkatan Embryo Fusion. Berlangsung selama [Layer] ronde."
  },
  State_57316_Name = {
    Text = "Warisan Suci Abadi"
  },
  State_57317_Desc = {
    Text = "Saat roda takdir ini ada dalam dek kartu, kamu akan dapat melihat perubahan yang akan terjadi pada keterampilan di tanganmu."
  },
  State_57317_Name = {
    Text = "<PVPFlowerKeywords:Bunga dan Puisi dari Masa Lalu>"
  },
  State_57324_Desc = {
    Text = "Jika Pembangun ini memicu \"Bunga dan Puisi Masa Lalu\", kartu ini akan berubah menjadi <CardKeyWord:<SkillName1:>>."
  },
  State_57324_Name = {
    Text = "Bunga dan Puisi dari Masa Lalu"
  },
  State_57325_Desc = {
    Text = "Jika Pembangun ini memicu \"Bunga dan Puisi Masa Lalu\", kartu ini akan berubah menjadi <CardKeyWord:<SkillName2:>>."
  },
  State_57325_Name = {
    Text = "Bunga dan Puisi dari Masa Lalu"
  },
  State_57326_Desc = {
    Text = "Jika Pembangun ini memicu \"Bunga dan Puisi Masa Lalu\", kartu ini akan berubah menjadi <CardKeyWord:<SkillName3:>>."
  },
  State_57326_Name = {
    Text = "Bunga dan Puisi dari Masa Lalu"
  },
  State_57335_Name = {
    Text = "Kerusakan kartu ini mendapatkan tambahan bonus sebesar [DescArg1] kali Kekuatan."
  },
  State_57356_Name = {
    Text = "Negara@Counter Perhitungan"
  },
  State_57368_Name = {
    Text = "Negara@Counter Balasan"
  },
  State_57413_Name = {
    Text = "Setiap poin perisai meningkatkan kerusakan kartu ini sebesar [DescArg1] poin."
  },
  State_57417_Desc = {
    Text = "Setiap kali Ketahanan dipicu, akan memberikan <FixedDamage:Kerusakan Murni> sebesar 100% dari Counter. Selama pertempuran ini, setiap kali Ketahanan dipicu, <FixedDamage:Kerusakan Murni> akan meningkat sebesar 25%."
  },
  State_57417_Name = {
    Text = "Cradle of Love"
  },
  State_57566_Name = {
    Text = "Keluar dari Kebuntuan"
  },
  State_57587_Desc = {
    Text = "Saat menggunakan \"Pemisahan Kelenjar\", tarik 1 kartu, tersisa [Layer] kali."
  },
  State_57587_Name = {
    Text = "Ubur-ubur, berkumpul!"
  },
  State_57665_Name = {
    Text = "Perlindungan Dewi"
  },
  State_57728_Desc = {
    Text = "Jumlah serangan Uvhash meningkat 1"
  },
  State_57728_Name = {
    Text = "Hadiah Blood Surge"
  },
  State_57751_Desc = {
    Text = "Hanya satu di tim: Perisai yang diciptakan oleh pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah melepaskan Geng, semua Pembangun mendapatkan <WeaponEffect_Num:[StateArg2]%> tingkat kritis dan kerusakan kritis sementara, tetapi dengan tambahan pengorbanan sebesar 3% dari kesehatan maksimum. Jika alam saat ini adalah \"Aequor\", setelah melepaskan Geng, kerusakan tentakel juga akan meningkat sebesar <WeaponEffect_Num:[StateArg3]%> dari daya serang pemakai."
  },
  State_57751_WeaponDesc = {
    Text = "Peningkatan perisai yang diberikan oleh pemakai sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah melepaskan Geng, semua Pembangun mendapatkan <WeaponEffect_Num:[StateArg2]%> tingkat kritis dan kerusakan kritis sementara, tetapi menerima [DescArg1] poin Pengorbanan. Jika alam saat ini adalah \"Aequor\", setelah melepaskan Geng, kerusakan tentakel juga akan meningkat sebesar [DescArg2] poin."
  },
  State_57753_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat dilengkapi, mendapatkan [StateArg1] lapisan<PVPSleepKeywords:Tidur Halus>."
  },
  State_57753_Name = {
    Text = "Tertidur di Bawah Glatsir"
  },
  State_57766_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setelah \"Exalt\" pertama setiap giliran, sementara<StrongEffectKeywords:Amplifikasi> +[StateArg1]."
  },
  State_57766_Name = {
    Text = "Tongkat Penggembala"
  },
  State_57767_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:Pada akhir giliran, dikurangkan <Energy:[Energy:StateArg1]> lelah yang diubah menjadi <PVPDerivativeCardKeywords_12:\"Harapan Kecil\">，jika gagal mengubah maka peroleh <Energy:[Energy:StateArg2]> lelah."
  },
  State_57767_Name = {
    Text = "Penampilan yang Tak Pernah Berhenti"
  },
  State_57768_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Kerusakan \"Keterampilan\" meningkat [StateArg1]%. Setelah \"Exalt\" memulihkan [StateArg2]% dari HP yang hilang pada diri sendiri."
  },
  State_57768_Name = {
    Text = "Sampai gunung salju mencair"
  },
  State_57769_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>：Setelah memainkan kartu keterampilan pemilik, gambar 1 kartu keterampilan pemilik, berlaku maksimal 1 kali per giliran。"
  },
  State_57769_Name = {
    Text = "Pintu Kebenaran"
  },
  State_57770_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Efek Kerusakan, penyembuhan, dan Perisai yang ditimbulkan \"Skill\" ditingkatkan [StateArg1]~[StateArg2]% (saat ini [Layer] %), <PhantomKeywords:Fatamorgana>."
  },
  State_57770_Name = {
    Text = "Roulette Nasib"
  },
  State_57814_Name = {
    Text = "Ketika tanda ini ada, itu menunjukkan bahwa Roda Takdir sedang diganti. Beberapa logika akan memerlukan pengenalan tanda ini.__\"Hanya untuk pengembangan\""
  },
  State_57817_Desc = {
    Text = "Tidak dapat bertindak, jumlah lapisan - 1 pada akhir giliran. Setelah lapisan habis, <StrongEffectKeywords:Kekuatan> +5. Tidak dapat dihilangkan, mengganti Roda takdir akan kehilangan Negara tidur nyenyak."
  },
  State_57817_Name = {
    Text = "Tidur mewah"
  },
  State_57854_Desc = {
    Text = "Pada awal ronde, dapatkan [StateArg1] poin perisai dan [StateArg2] poin kerusakan tentakel, hasilkan 2 tentakel sementara yang bertahan selama [Layer] ronde."
  },
  State_57854_Name = {
    Text = "Sumpah Bebas"
  },
  State_57854_WeaponDesc = {
    Text = "Negara@Aequor Teh Merah dan Kue"
  },
  State_57864_Name = {
    Text = "Bonus Peningkatan Kekuatan__\"Hanya untuk pengembangan\""
  },
  State_57942_Desc = {
    Text = "Tingkat fusi saat ini [Layer]%. Ketika tingkat fusi mencapai 100%, musuh akan dipaksa masuk ke fase berikutnya dan melepaskan keterampilan transisi fase yang lebih kuat."
  },
  State_57942_Name = {
    Text = "Tingkat Fusi"
  },
  State_57952_Desc = {
    Text = "Ketika kekuatan berkurang, hanya akan mengurangi 50% dari jumlah lapisan kekuatan."
  },
  State_57952_Name = {
    Text = "Selam Dalam"
  },
  State_57953_Desc = {
    Text = "Pada akhir ronde, hasilkan 1 Tentakel. Setelah Bangun, hapus status ini."
  },
  State_57953_Name = {Text = "Tidur"},
  State_57955_Desc = {
    Text = "Kerusakan yang diberikan Helot meningkat sebesar [StateArg1]% selama [Layer] putaran."
  },
  State_57955_Name = {
    Text = "Melewati kebuntuan·Kerusakan"
  },
  State_57968_Desc = {
    Text = "Mendapat pengaruh dari Juliette, setiap akhir ronde tingkat fusi kembar meningkat sebesar 10%, dan 1 kartu \"Distorsi\"akan dimasukkan ke dalam tumpukan menggambar."
  },
  State_57968_Name = {
    Text = "\"Nyanyian Juliette\""
  },
  State_57970_Name = {
    Text = "Perlindungan Dewi"
  },
  State_57976_Desc = {
    Text = "\"Anak Kegelapan\" setelah melakukan fusi paksa, memberikan <FixedDamage:Kerusakan Murni> kepada \"Awal dari Kelupaan\" sebesar 3 kali lipat dari nilai hidup saat ini."
  },
  State_57976_Name = {
    Text = "Pengorbanan"
  },
  State_58051_Desc = {
    Text = "Crit. DMG +[Layer]%."
  },
  State_58051_Name = {Text = "Crit. DMG"},
  State_58052_Desc = {
    Text = "Setiap kali 1 poin Segil hitam digunakan dalam eksplorasi, meningkatkan kerusakan dasar \"Semua-dalam\" sebesar 0,5%.（Telah meningkat [DescArg1]%）"
  },
  State_58052_Name = {
    Text = "Tanpa risiko kerugian"
  },
  State_58061_Name = {
    Text = "Menemukan uang dan tidak mengambilnya"
  },
  State_58063_Desc = {
    Text = "Kerusakan yang diberikan oleh Bangun meningkat sebesar 25%, berlangsung selama [Layer] putaran."
  },
  State_58063_Name = {
    Text = "Pandangan yang Melampaui Masa"
  },
  State_58144_Desc = {
    Text = "Crit. Rate dalam level ini meningkat sebesar [Layer]%."
  },
  State_58144_Name = {
    Text = "Tingkat Kritikal Permanen"
  },
  State_58144_WeaponDesc = {
    Text = "Crit. Rate dalam level ini meningkat sebesar [Layer]%."
  },
  State_58259_Desc = {
    Text = "Satu-satunya di tim: Crit. Rate pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah pemakai membunuh musuh, mereka mendapatkan <WeaponEffect_Num:[StateArg2]> poin segil hitam, dapat dipicu maksimal 3 kali dalam eksplorasi. Setelah dipicu 3 kali, Crit. Rate pemakai akan meningkat secara permanen sebesar <WeaponEffect_Num:[StateArg3]%> selama eksplorasi ini."
  },
  State_58259_WeaponDesc = {
    Text = "Crit. Rate pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah pemakai membunuh musuh, mereka mendapatkan <WeaponEffect_Num:[DescArg2]> poin segil hitam, dapat dipicu maksimal 3 kali selama eksplorasi ([DescArg1]/3). Setelah memicu 3 kali, Crit. Rate pemakai akan meningkat secara permanen sebesar <WeaponEffect_Num:[StateArg3]%> selama eksplorasi ini."
  },
  State_58297_Desc = {
    Text = [[
Ryker mendapatkan [DescArg3] Segil hitam setiap kali membunuh musuh, berlaku maksimal 5 kali per eksplorasi.([DescArg1]/5)
 Dengan mendapatkan 50/125/250 Segil hitam melalui pertempuran, batas Relik meningkat 1, dan saat pertempuran berakhir, pilih satu "Warisan Kekacauan" untuk ditambahkan ke daftar Relik.(Telah mendapatkan [DescArg2] poin Segil hitam)]]
  },
  State_58297_Name = {
    Text = "Pemenang mengambil semuanya"
  },
  State_58447_Desc = {
    Text = [[
Termasuk tiga relik berikut: 
"Mantel Keberuntungan": Meningkatkan tingkat kritis semua Pembangun sebesar 10%. Hasil acak dari semua Ryker dan dadu tidak akan menghasilkan nilai minimum. 
<TentacleInjurieIconKeywords:Peningkatan>: Tingkat kritis ditingkatkan menjadi 15%, hasil maksimum acak dinaikkan sebesar 1. 
"Dadu Alternatif": Setiap kali Geng dilepaskan, tambahkan 1 kartu "<C05_yansheng1:Dadu Alternatif>" ke tangan. 
<TentacleInjurieIconKeywords:Peningkatan>: Diubah menjadi menambahkan 1 kartu "<C05_yansheng2:Dadu Alternatif Bersinar>" ke tangan. 
"Kancing Mulut Lebar": Di awal giliran dan ketika efek acak Ryker atau dadu diaktifkan, dapatkan 50 energi-s dan 2% kerusakan kritis, hingga maksimal 30% kerusakan kritis. 
<TentacleInjurieIconKeywords:Peningkatan>: Diubah menjadi mendapatkan 100 energi-s dan 4% kerusakan kritis, hingga maksimal 50% kerusakan kritis.]]
  },
  State_58447_Name = {
    Text = "<CardKeyWord:Warisan Kekacauan>"
  },
  State_58490_Desc = {
    Text = "Ketika semua rasa kantuk dihilangkan, semua Pembangun dan Kartu akan disegel, serta \"Niat Sang Penguasa Tidur\" akan diubah menjadi \"Kekuatan Kerajaan\"."
  },
  State_58490_Name = {Text = "Kantuk"},
  State_58491_Desc = {
    Text = "Setiap kali memainkan kartu, hapus 1 lapisan \"kantuk\". Di awal putaran, pulihkan hingga 12 lapisan \"kantuk\"."
  },
  State_58491_Name = {Text = "Marah"},
  State_58492_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_58492_Name = {Text = "Not Roused"},
  State_58493_Desc = {
    Text = "Setiap kali memainkan kartu, hapus 1 lapisan \"kantuk\". Di awal putaran, pulihkan hingga 12 lapisan \"kantuk\"."
  },
  State_58493_Name = {Text = "Marah"},
  State_58947_Desc = {
    Text = "Crit. Rate dalam level ini meningkat sebesar [Layer]%."
  },
  State_59078_Name = {
    Text = ",dapat digunakan 1 kali"
  },
  State_59079_Name = {
    Text = ",dapat digunakan 2 kali"
  },
  State_59080_Name = {
    Text = ",dapat digunakan 3 kali"
  },
  State_59117_Desc = {
    Text = "Crit. DMG +[Layer]%."
  },
  State_59117_Name = {Text = "Crit. DMG"},
  State_59160_Desc = {
    Text = "Semua efek kerusakan, penyembuhan, dan perisai yang ditimbulkan meningkat sebesar 10%, tidak dapat diusir."
  },
  State_59160_Name = {
    Text = "<CardKeyWord:Kuat>"
  },
  State_59161_Desc = {
    Text = "Efek kerusakan, penyembuhan, dan perisai meningkat sebesar [DescArg1]%, tidak dapat diusir."
  },
  State_59161_Name = {
    Text = "Amplification"
  },
  State_59169_Desc = {
    Text = "Konsumsi aritmetika dasar kartu ini tidak akan melebihi batas aritmetika.__\"仅开发用\""
  },
  State_59169_Name = {
    Text = "Keseimbangan__\"仅开发用\""
  },
  State_59173_Name = {
    Text = "Ketika tanda ini ada, itu menunjukkan bahwa serangan ganda sedang berlangsung dan tidak akan memicu serangan ganda lagi.__\"Hanya untuk pengembangan\""
  },
  State_59208_Desc = {
    Text = "Semua efek kerusakan, penyembuhan, dan perisai yang ditimbulkan berkurang sebesar 10%, tidak dapat diusir."
  },
  State_59208_Name = {
    Text = "<WeaknessColour:Kuat>"
  },
  State_59209_Desc = {
    Text = "Efek kerusakan, penyembuhan, dan perisai berkurang sebesar [DescArg1]%, tidak dapat diusir."
  },
  State_59209_Name = {
    Text = "Amplification▼"
  },
  State_59423_Desc = {
    Text = [[
Ryker mendapatkan 5 Segil hitam setiap kali membunuh musuh, setiap 1% penurunan Segil hitam Ryker akan meningkatkan jumlah yang diperoleh sebesar 1%, berlaku maksimal 5 kali per eksplorasi. 
 Dengan mendapatkan 50/125/250 Segil hitam melalui pertempuran, batas Relik meningkat 1, dan saat pertempuran berakhir, pilih satu "Warisan Kekacauan" untuk ditambahkan ke daftar Relik.]]
  },
  State_59423_Name = {
    Text = "Pemenang mengambil semuanya"
  },
  State_59424_Desc = {
    Text = "Setiap kali 1 poin Segil hitam digunakan dalam eksplorasi, meningkatkan kerusakan dasar \"Semua-dalam\" sebesar 0,5%."
  },
  State_59424_Name = {
    Text = "Tanpa risiko kerugian"
  },
  State_59439_Desc = {
    Text = "Status ini menggunakan zona rentan, berpura-pura menjadi zona multiplikasi independen.__\"Hanya untuk pengembangan\""
  },
  State_59439_Name = {
    Text = "Jika memiliki status tertentu, kerusakan yang diterima menjadi dua kali lipat__\"Hanya untuk pengembangan\""
  },
  State_59519_Name = {
    Text = "Pilih 1 Kartu Perintah dari tumpukan Menggambar atau Tumpukan Kartu Buang untuk dimasukkan ke tangan, ubah Lelah Aritmetikanya menjadi 0."
  },
  State_59520_Desc = {
    Text = "Setelah dimainkan, tarik 2 kartu dan kurangi konsumsi Aritmetika mereka sebesar konsumsi Aritmetika aktual kartu Orison. Hanya berlaku 1 kali per pertempuran."
  },
  State_59520_Name = {
    Text = "<WhiteQuality:Prinsip Intelektual>"
  },
  State_59521_Name = {
    Text = "Kehilangan 10% dari Hidup saat ini ([DescArg1])"
  },
  State_59522_Desc = {
    Text = "Setelah digunakan, buang semua kartu selain Pembangun ini dan dapatkan 5 Kartu acak non-Pembangun. Hanya berlaku 1 kali per pertempuran."
  },
  State_59522_Name = {
    Text = "<WhiteQuality:Prinsip Kegembiraan>"
  },
  State_59525_Name = {
    Text = "Kartu perintah yang sesuai dengan Pembangun mendapatkan 50 poin Aliemus."
  },
  State_59526_Desc = {
    Text = "Setelah digunakan, dapatkan 3 salinan asli dengan <RetainIconKeywords:Pertahankan>dan<DepleteIconKeywords:Konsumsi>, hanya berlaku 1 kali per pertempuran."
  },
  State_59526_Name = {
    Text = "<WhiteQuality:Prinsip Pemuliaan>"
  },
  State_59534_Name = {
    Text = "Ketika tanda ini ada, kartu ini dilarang untuk memicu Fatamorgana.__\"Hanya untuk pengembangan\""
  },
  State_59560_Name = {
    Text = "Pilih satu Kartu yang telah menerima tiga Orison utama untuk ditambahkan ke tangan."
  },
  State_59671_Desc = {
    Text = "Kerusakan akhir semua Pembangun dalam ronde ini meningkat sebesar 15%."
  },
  State_59671_Name = {
    Text = "Jam Tangan Hiperseni"
  },
  State_59673_Name = {
    Text = "Kotak Musik Kecil"
  },
  State_59678_Desc = {
    Text = "Kehilangan semua Relik lain saat diambil, secara acak mendapatkan 2 Relik emas."
  },
  State_59878_Desc = {
    Text = "Pada akhir ronde, kurangi 1 lapisan tambahan \"Kekacauan\" dan dapatkan [StateArg1] <PowerIconKeywords:Kekuatan>. Kesehatan duplikat \"N\" yang dipanggil selanjutnya meningkat 200%, setelah mati tidak lagi mengurangi lapisan \"Kekacauan\" pada \"N\" dan tidak mendapatkan <PowerIconKeywords:Kekuatan>."
  },
  State_59878_Name = {
    Text = "Kekacauan Kedatangan"
  },
  State_59991_Name = {
    Text = "，kartu ini saat dimainkan paling banyak menggunakan 5 lapisan<EnergyStorageKeywords:Muatan>"
  },
  State_59993_Name = {
    Text = "Mengembalikan 10% dari Hidup yang hilang ([DescArg1])"
  },
  State_60000_Desc = {
    Text = "Setiap kali menerima Active DMG, mendapatkan 1 stacks <MadnessIconKeywords:Kegilaan> Sementara."
  },
  State_60000_Name = {
    Text = "Pengumpulan Kemarahan"
  },
  State_60028_Desc = {
    Text = "Pada awal giliran pemain, secara acak ubah konsumsi aritmetika dari satu kartu di tangan menjadi 3 untuk putaran ini. Setelah mati, efek ini akan hilang dan mengurangi konsumsi aritmetika semua kartu pembunuh sebesar 1 untuk putaran ini."
  },
  State_60028_Name = {
    Text = "Kandang Delirium"
  },
  State_60044_Name = {
    Text = "Setelah menggunakan [Layer] kali, akan terkonsumsi"
  },
  State_60083_Desc = {
    Text = "Kerusakan yang diterima pada giliran ini berkurang [Layer] %."
  },
  State_60083_Name = {
    Text = "<ReinforceColour:Diperkuat>"
  },
  State_60083_WeaponDesc = {
    Text = "Semua kerusakan yang ditimbulkan berkurang sebesar [DescArg1]%."
  },
  State_60085_Desc = {
    Text = "Pada saat pertempuran dimulai dan awal putaran, dapatkan Diperkuat sementara. Semakin tinggi Hidup pemain, semakin banyak lapisan yang diperoleh, maksimal 50 lapisan."
  },
  State_60085_Name = {
    Text = "Pupasi Akhir"
  },
  State_60085_WeaponDesc = {
    Text = "Semua kerusakan yang ditimbulkan berkurang sebesar [DescArg1]%."
  },
  State_60086_Desc = {
    Text = "Pada saat pertempuran dimulai dan pergantian ronde dimulai, dapatkan Diperkuat sementara. Semakin tinggi Hidup pemain, semakin banyak lapisan yang diperoleh, maksimal 25 lapis."
  },
  State_60086_Name = {Text = "Pupasi"},
  State_60086_WeaponDesc = {
    Text = "Semua kerusakan yang ditimbulkan berkurang sebesar [DescArg1]%."
  },
  State_60087_Desc = {
    Text = "Efek luka berat yang ditimbulkan berubah menjadi pengurangan [Layer]% pemulihan hidup."
  },
  State_60087_Name = {
    Text = "<Rune_14_High:Serangan Berat>"
  },
  State_60087_WeaponDesc = {
    Text = "Semua kerusakan yang ditimbulkan berkurang sebesar [DescArg1]%."
  },
  State_60088_Desc = {
    Text = "Setiap stack mengurangi semua kerusakan yang diterima sebesar 1%."
  },
  State_60088_Name = {
    Text = "<ReinforcePVEKeywords:Diperkuat>"
  },
  State_60088_WeaponDesc = {
    Text = "Semua Perisai yang diperoleh berkurang sebesar 25%."
  },
  State_60089_Desc = {
    Text = "Semua kerusakan yang diterima berkurang [Layer] %."
  },
  State_60089_Name = {
    Text = "<ReinforceColour:Diperkuat>"
  },
  State_60089_WeaponDesc = {
    Text = "Semua kerusakan yang ditimbulkan berkurang sebesar [DescArg1]%."
  },
  State_60106_Desc = {
    Text = "Setelah awal giliran, satu kartu tangan acak memiliki perubahan konsumsi aritmetika menjadi 3, dan akan dipulihkan di akhir giliran."
  },
  State_60106_Name = {
    Text = "Kandang Delirium"
  },
  State_60112_Desc = {
    Text = "Dalam ronde ini, setiap kali memainkan satu Kartu perintah, semua Pembangun mendapatkan 1 poin Aliemus."
  },
  State_60112_Name = {Text = "Konserto"},
  State_60115_Desc = {
    Text = "Setelah melepaskan Muliakan pada ronde ini, kurangi tingkat fusi kembar sebesar 3%."
  },
  State_60115_Name = {Text = "Requiem"},
  State_60118_Desc = {
    Text = "Kerusakan, Racun, dan Counter yang diberikan pada ronde ini meningkat sebesar [Layer]%."
  },
  State_60118_Name = {Text = "Rapsodi"},
  State_60128_Desc = {
    Text = "Mengubah aritmetika kartu sebelum bermain"
  },
  State_60128_WeaponDesc = {
    Text = "Mengubah aritmetika kartu sebelum bermain"
  },
  State_60129_Desc = {
    Text = "Kamu mengeluarkan [Layer] sebanyak dua kartu perintah non-derivatif dengan konsumsi aritmetika-2."
  },
  State_60129_Name = {Text = "Downbeat"},
  State_60130_Desc = {
    Text = "Kau mengeluarkan [Layer] kartu instruksi non-derivatif yang ke-[Layer] menghasilkan konsumsi kekuatan aritmetika +2, berlaku 2 kali."
  },
  State_60130_Name = {Text = "Nota naik"},
  State_60148_Desc = {
    Text = "Pada akhir ronde, dapatkan efek berbeda berdasarkan negara: Lepas - Dapatkan 1 lapisan sementara <MadnessIconKeywords:Kegilaan>. Tampung - Dapatkan 50 lapisan sementara <ReinforcePVEKeywords:Diperkuat>."
  },
  State_60148_Name = {
    Text = "Penyesuaian Parameter"
  },
  State_60150_Desc = {
    Text = "Setiap kali mendeteksi pemain melepaskan Geng, segera beralih antara dua mode: Lepas dan Tarik. Saat beralih ke Lepas, langsung dapatkan [StateArg1] poin Kekuatan sementara. Saat beralih ke Tarik, langsung dapatkan [StateArg2] poin Perisai."
  },
  State_60150_Name = {
    Text = "Penginderaan Fungsi"
  },
  State_60151_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_60151_Name = {Text = "Not Roused"},
  State_60154_Desc = {
    Text = "Saat ini dalam mode - Konvergensi. Persenjataan mekanis akan memperoleh perisai dan waspada, serta niat akan lebih fokus pada pertahanan."
  },
  State_60154_Name = {
    Text = "Mechanical Armament - Gather"
  },
  State_60155_Desc = {
    Text = "Saat ini dalam mode - Lepas. Persenjataan mekanis akan mendapatkan Kekuatan, dan Niatnya akan berfokus pada Serangan."
  },
  State_60155_Name = {
    Text = "Senjata Mesin - Tempatkan"
  },
  State_60167_Desc = {
    Text = "Mengubah aritmetika kartu sebelum bermain"
  },
  State_60167_WeaponDesc = {
    Text = "Mengubah aritmetika kartu sebelum bermain"
  },
  State_60184_Desc = {
    Text = "Setiap kali kartu dimainkan, \"Kembar Kontradiksi\" akan mengubah niatnya."
  },
  State_60184_Name = {
    Text = "kontradiksi"
  },
  State_60187_Desc = {
    Text = "Kelemahan, rapuh, dan negara luka berat yang diterima pemain semuanya adalah 50%."
  },
  State_60187_Name = {
    Text = "Akhir adalah awal"
  },
  State_60201_Name = {
    Text = "Kekuatan Monster Tertunda"
  },
  State_60263_Desc = {
    Text = "Efek rapuh yang ditimbulkan berubah menjadi mengurangi [Layer]% untuk mendapatkan Perisai."
  },
  State_60263_Name = {
    Text = "<Rune_14_High:Rapuh Mendalam>"
  },
  State_60264_Desc = {
    Text = "Efek berdarah yang ditimbulkan akan otomatis dihilangkan sebesar 50% saat akhir ronde."
  },
  State_60264_Name = {
    Text = "<Rune_14_High: Hemolisis>"
  },
  State_60265_Desc = {
    Text = "Efek Berdarah akan otomatis hilang sebesar 50% saat akhir ronde."
  },
  State_60265_Name = {
    Text = "<BleedingColour: Hemolisis>"
  },
  State_60279_Name = {
    Text = "Kartu ini akan lelah di akhir giliran"
  },
  State_60284_Desc = {
    Text = "Pada saat pertempuran dimulai dan awal ronde, dapatkan Diperkuat sementara. Semakin rendah Hidup pemain, semakin banyak lapisan yang diperoleh, maksimal 50 lapis."
  },
  State_60284_Name = {
    Text = "Formasi Pedang Tidak Terkalahkan"
  },
  State_60284_WeaponDesc = {
    Text = "Semua kerusakan yang ditimbulkan berkurang sebesar [DescArg1]%."
  },
  State_60297_Desc = {
    Text = "\"@2\"muncul dengan postur pembebasan, hidupnya menjadi 3 kali lipat dari semula. Setiap putaran, ia akan mengajukan pertanyaan kepada Penjaga dan menaruh satu kartu \"Jawaban Tawil\" ke tangan."
  },
  State_60297_Name = {
    Text = "Pertanyaan Kebenaran"
  },
  State_60297_WeaponDesc = {
    Text = "Pada ronde berikutnya, dapatkan perisai sejumlah kehilangan hidup dari ronde sebelumnya."
  },
  State_60298_Desc = {
    Text = "Kekuatan dari keberadaan yang tidak diketahui masih tersembunyi di bawah kolam hitam, sebelum dikalahkan akan sepenuhnya bangkit, mengembalikan kehidupan dan memulai pertempuran dengan gaya pembebasan."
  },
  State_60298_Name = {
    Text = "bersembunyi"
  },
  State_60312_Desc = {
    Text = "Setiap putaran, saat menerima kerusakan sebesar 10% dari total hidup, dapatkan [Layer] lapisan sementara \"Diperkuat\"."
  },
  State_60312_Name = {
    Text = "Perisai Kabut Pelarutan"
  },
  State_60315_Desc = {
    Text = "Setelah melepaskan Muliakan pada ronde ini, pulihkan 5% dari Hidup yang hilang ([DescArg1])."
  },
  State_60315_Name = {Text = "Requiem"},
  State_60336_Name = {
    Text = "Setelah digunakan, dapatkan 1 Aritmetika dan tarik 1 kartu, namun kartu ini akan Lelah."
  },
  State_60339_Name = {
    Text = "Setelah dimainkan pada ronde ini, dapatkan 1 poin Aritmetika dan tarik 1 kartu, namun kartu ini akan menjadi Lelah"
  },
  State_60367_Desc = {
    Text = "Pada awal giliran pemain, secara acak ubah konsumsi aritmetika dari satu kartu di tangan menjadi 3 untuk putaran ini. Setelah mati, efek ini akan hilang dan mengurangi konsumsi aritmetika semua kartu pembunuh sebesar 1 untuk putaran ini."
  },
  State_60367_Name = {
    Text = "Kandang Delirium"
  },
  State_60386_Desc = {
    Text = "Efek termasuk: Berdarah yang menyebabkan 150% kerusakan, racun yang menyebabkan 75% kerusakan, memberikan 1 lapis kelemahan, memberikan 1 lapis rentan, sementara mengurangi [DescArg1] poin kekuatan."
  },
  State_60386_Name = {
    Text = "<MysterydebuffKeywords:Efek Negatif Ajaib>"
  },
  State_60404_Desc = {
    Text = "Setiap menerima 1 kerusakan, mendapatkan 2 lapisan Diperkuat sementara."
  },
  State_60404_Name = {
    Text = "Perubahan Akhir"
  },
  State_60408_Desc = {
    Text = "Setiap kali hidup berkurang hingga 33% (kurang [DescArg1] poin), tidak akan menerima kerusakan lagi di babak ini, dan melepaskan \"Gigitan Topeng Hantu\"."
  },
  State_60408_Name = {
    Text = "Gigitan Topeng Hantu"
  },
  State_60409_Desc = {
    Text = "Setiap kali nyawa berkurang hingga 66% (kurang [DescArg1] poin), tidak akan menerima kerusakan lagi di babak ini, dan melepaskan \"Transformasi Akhir\"."
  },
  State_60409_Name = {
    Text = "Cermin Akhir"
  },
  State_60429_Name = {
    Text = "Negara@Pembangun Hameln@Nada Asli"
  },
  State_60430_Desc = {
    Text = "Ketika memainkan kartu dengan konsumsi aritmetika aktual yang sesuai dengan tampilan niat, kartu tersebut akan terkonsumsi dan semua musuh kehilangan [DescArg1] Kekuatan sementara."
  },
  State_60430_Name = {
    Text = "Perintah Nota Ritmis"
  },
  State_60431_Name = {
    Text = "Negara@Pembangun Hameln@Suara Naik"
  },
  State_60432_Name = {
    Text = "Negara@Pembangun Hameln@Pralude Jiwa"
  },
  State_60433_Name = {
    Text = "Negara@Pembangun Hameln@Suara Turun"
  },
  State_60434_Name = {
    Text = "Negara@Pembangun Hameln@Kisah Kenangan Berputar"
  },
  State_60435_Name = {
    Text = "Negara@Pembangun Hameln@Jiwa Prelude Count"
  },
  State_60436_Desc = {
    Text = "Saat menyebabkan kerusakan yang tidak terblokir, masukkan [StateArg1] kartu \"Luka\" ke tumpukan menggambar."
  },
  State_60436_Name = {
    Text = "Prélude Jiwa"
  },
  State_60438_Name = {
    Text = "Negara@Pembangun Hameln@Pemantau Suara Naik"
  },
  State_60439_Name = {
    Text = "Negara@Pembangun Hameln@Pemantau Suara Turun"
  },
  State_60440_Name = {
    Text = "Negara@Pembangun Hameln@Jiwa Pendahuluan Mendengarkan"
  },
  State_60441_Name = {
    Text = "Negara@Pembangun Hameln@Mendengarkan Rhapsody of Reminiscence"
  },
  State_60442_Name = {
    Text = "Negara@Pembangun Hameln@Suara Awal Pemantauan"
  },
  State_60486_Desc = {
    Text = "Pada saat pertempuran dimulai, semua Pembangun Aliemus berkurang setengahnya."
  },
  State_60486_Name = {
    Text = "Penyerapan Dewi Ibu"
  },
  State_60487_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, meningkatkan kesehatan maksimum sebesar 200%, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_60487_Name = {Text = "Not Roused"},
  State_60490_Desc = {
    Text = "Setelah kematian, semua Pembangun mendapatkan 30 poin Aliemus."
  },
  State_60490_Name = {
    Text = "Keinginan untuk Hidup"
  },
  State_60491_Desc = {
    Text = "Semua Aliemus yang dihasilkan oleh Pembangun berkurang sebesar 50%."
  },
  State_60491_Name = {
    Text = "Ritual Pohon Ibu"
  },
  State_60493_Desc = {
    Text = "Setiap kali Hidup berkurang sebanyak [Layer] poin, Memanggil satu Pembangun. Jika jumlah Pembangun di lapangan sudah mencapai 2, maka tingkatkan Kesehatan maksimum semua Pembangun sebesar 50%."
  },
  State_60493_Name = {
    Text = "Ibu penyayang"
  },
  State_60500_Desc = {
    Text = "Saat ini, jika ada Pembangun yang terbangun, diri sendiri mendapatkan 50 lapisan \"Menyembunyikan\"."
  },
  State_60500_Name = {
    Text = "Tersembunyi di hutan"
  },
  State_60511_Desc = {
    Text = "Pasti muncul di kartu awal."
  },
  State_60511_Name = {
    Text = "<GuyouKeywords:Inherent>"
  },
  State_60511_WeaponDesc = {
    Text = "Setelah digunakan, kartu tidak akan masuk ke tumpukan kartu buang dan tidak dapat digunakan kembali selama pertempuran ini."
  },
  State_60522_Desc = {
    Text = "Efek rapuh dan luka berat ditingkatkan menjadi 50%."
  },
  State_60522_Name = {Text = "Kehancuran"},
  State_60523_Desc = {
    Text = "Setiap lapisan menambah jumlah serangan sebanyak 1. Saat menerima kerusakan, kehilangan satu lapisan, dan pada akhir giliran, kehilangan semua lapisan."
  },
  State_60523_Name = {Text = "Doa"},
  State_60524_Desc = {
    Text = "Pada saat pertempuran dimulai dan awal ronde, dapatkan [Layer] lapisan Diperkuat, maksimal 50 lapisan."
  },
  State_60524_Name = {
    Text = "Sanctifikasi"
  },
  State_60524_WeaponDesc = {
    Text = "Semua kerusakan yang ditimbulkan berkurang sebesar [DescArg1]%."
  },
  State_60527_Desc = {
    Text = "Setelah digunakan, akan lelah, tetapi akan mengurangi Kekuatan sementara musuh."
  },
  State_60527_Name = {
    Text = "<CardKeyWord:Melodi Surga>"
  },
  State_60543_Desc = {
    Text = "Pada akhir ronde, dapatkan 10 lapisan \"Sumpah Darah\", dan 1 lapisan \"Sumpah Darah\" akan hilang setelah menerima kerusakan."
  },
  State_60543_Name = {
    Text = "Nyala dari sumbu"
  },
  State_60554_Name = {
    Text = "<HuihuanbKeywords:Musik Lingkar>"
  },
  State_60558_Name = {
    Text = "<HuihuanbKeywords:Musik Lingkar>"
  },
  State_60562_Desc = {
    Text = "Setelah digunakan, efek berlaku 2 kali, diubah menjadi \"Lagu Akumulasi\""
  },
  State_60562_Name = {
    Text = "<HuihuanaKeywords:Melodi Lingkaran Kembali>"
  },
  State_60564_Desc = {
    Text = "Ketika akan dikalahkan untuk pertama kalinya, pulihkan hidup dan ubah niat menjadi \"Evolusi Akhir\", mendapatkan kekuatan dan diperkuat. Ketika akan dikalahkan untuk kedua kalinya, pulihkan hidup dan ubah niat menjadi \"Gigitan Topeng Iblis\", menyebabkan kerusakan tunggal yang sangat besar."
  },
  State_60564_Name = {
    Text = "Setan Bayangan"
  },
  State_60567_Desc = {
    Text = "Setelah digunakan, Hameln memperoleh 3 poin Aliemus."
  },
  State_60567_Name = {
    Text = "<XushiAKeywords:Akumulasi Nada>"
  },
  State_60568_Name = {
    Text = "<XushiAKeywords:Akumulasi Nada>"
  },
  State_60569_Name = {
    Text = "<XushiBKeywords:Akumulasi Nada>"
  },
  State_60570_Desc = {
    Text = "Setelah digunakan, Hameln memperoleh 3 poin Aliemus."
  },
  State_60570_Name = {
    Text = "<XushiBKeywords:Akumulasi Nada>"
  },
  State_60571_Name = {
    Text = "<HuihuanaKeywords:Melodi Lingkaran Kembali>"
  },
  State_60576_Desc = {
    Text = "Pada awal giliran pemain, secara acak ubah konsumsi aritmetika dari satu kartu di tangan menjadi 3 untuk putaran ini. Setelah mati, efek ini akan hilang dan mengurangi konsumsi aritmetika semua kartu pembunuh sebesar 1 untuk putaran ini."
  },
  State_60576_Name = {
    Text = "Kandang Delirium"
  },
  State_60578_Desc = {
    Text = "Saat menerima kerusakan fatal, akan memulihkan 50% hidup, kebal terhadap kerusakan selama 1 putaran, dan niat berubah menjadi \"Pecah dari kepompong\"."
  },
  State_60578_Name = {
    Text = "Keluar dari Kokon"
  },
  State_60592_Desc = {
    Text = "Tim Unik: Saat eksplorasi dimulai, Shuffle 1 kartu \"Silver Key Dawn\" ke dalam Menggambar dan tambahkan <DestructionKeywords:Destroy>. Setelah melepaskan Posse, Crit. DMG Pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Saat Pemakai memberikan Active DMG, dapatkan Keyflare senilai <WeaponEffect_Num:[StateArg2]%> dari Keyflare Regen Pemakai dan <WeaponEffect_Num:[StateArg3]%> Tingkat Kritis Sementara, maksimal berlaku 5 kali per ronde."
  },
  State_60592_WeaponDesc = {
    Text = "Saat eksplorasi dimulai, Shuffle 1 kartu \"Silver Key Dawn\" ke dalam Menggambar dan tambahkan <DestructionKeywords:Destroy>. Setelah melepaskan Posse, Crit. DMG Pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Saat Pemakai memberikan Active DMG, dapatkan <WeaponEffect_Num:[DescArg1]> poin Keyflare dan <WeaponEffect_Num:[StateArg3]%> Tingkat Kritis Sementara, maksimal berlaku 5 kali per ronde."
  },
  State_60594_Desc = {
    Text = "Satu-satunya Tim: Setelah giliran berakhir, pemakai mendapatkan 5 poin Aliemus. Setelah pemakai melepaskan Muliakan, Crit. Rate, Crit. DMG, perisai, dan pemulihan hidup dari Kartu perintah pemakai yang dimainkan pada giliran ini meningkat sebesar <WeaponEffect_Num:[StateArg1]%>."
  },
  State_60594_WeaponDesc = {
    Text = "Setelah ronde berakhir, pemakai mendapatkan 5 poin Aliemus. Setelah pemakai melepaskan Muliakan, kartu perintah pemakai yang dimainkan pada ronde ini meningkatkan Crit. Rate, Crit. DMG, perisai, dan pemulihan hidup sebesar <WeaponEffect_Num:[StateArg1]%>."
  },
  State_60898_Desc = {
    Text = "Saat menerima Active DMG dan kerusakan tentakel, Sealed Exalt dan semua Kartu yang menyerang Awakener selama 1 giliran, hapus 1 stacks <ResentChainsKeywords:Rantai Kebencian>."
  },
  State_60898_Name = {
    Text = "<ResentChainsKeywords1:Rantai Kebencian>"
  },
  State_60925_Desc = {
    Text = "Pada akhir ronde, pulihkan 5% dari hidup yang hilang. Setiap kali pemain mengambil 1 kartu gejala atau kartu negara, semua sekutu mendapatkan [Layer] poin kekuatan."
  },
  State_60925_Name = {
    Text = "Lentera Darah"
  },
  State_60926_Desc = {
    Text = "Jika Hidup saat ini di bawah 50% pada akhir ronde, maka dapatkan [Layer] poin Kekuatan dan [StateArg1] lapisan Penghalang."
  },
  State_60926_Name = {
    Text = "Altar Suci Lentera"
  },
  State_60953_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Sebelum \"Exalt\", menyebabkan seluruh musuh [StateArg1] lapisan <PVPSlowKeywords:Melambat>."
  },
  State_60953_Name = {
    Text = "Rekuiem Abadi"
  },
  State_60962_Desc = {
    Text = "Dalam pertempuran ini, kesehatan maksimum meningkat sebesar [Layer]%."
  },
  State_60962_Name = {
    Text = "Peningkatan Hidup"
  },
  State_60964_Desc = {
    Text = "Dalam pertempuran ini, kerusakan meningkat sebesar [Layer]%."
  },
  State_60964_Name = {
    Text = "Kerusakan ditingkatkan"
  },
  State_61038_Name = {
    Text = "Hameln Demo"
  },
  State_61050_Desc = {
    Text = "Memicu efek \"Melodi\" atau memainkan \"Simfoni Keharmonisan\", Hameln mendapatkan 1% Crit. Rate dan Crit. DMG(saat ini telah diperoleh [DescArg1]%). Efek ini setiap dipicu 10 kali, meningkatkan jumlah kerusakan dari \"Prélude Jiwa\" dan \"Nada Primal\" sebesar 1, hingga maksimum 3 kali."
  },
  State_61050_Name = {
    Text = "Rêverie bawah bulan"
  },
  State_61051_Desc = {
    Text = "Setelah memicu efek \"Melodi\" atau memainkan \"Simfoni Keharmonisan\", Hameln mendapatkan 1% Crit. Rate dan Crit. DMG. Efek ini akan meningkatkan jumlah kerusakan \"Prélude Jiwa\" dan \"Nada Primal\" sebanyak 1 kali setiap 10 kali pemicu, hingga maksimum 3 kali."
  },
  State_61051_Name = {
    Text = "Rêverie bawah bulan"
  },
  State_61056_Desc = {
    Text = "Putaran pertama mendapatkan 100 poin Kekuatan sementara."
  },
  State_61056_Name = {Text = "Fury"},
  State_61084_Desc = {
    Text = "Jumlah kartu yang dimainkan di [Layer] pada giliran ini: Jika pengeluaran aritmetika lebih besar dari atau sama dengan 3, dapatkan 2 poin aritmetika, jika tidak, ambil 2 kartu."
  },
  State_61084_Name = {
    Text = "Simfoni Keempat"
  },
  State_61085_Desc = {
    Text = "Lelah Aritmetika - 2, setelah dimainkan berlaku 2 kali, diubah menjadi \"Musik Bertenaga\""
  },
  State_61085_Name = {
    Text = "<HuihuanbKeywords:Musik Lingkar>"
  },
  State_61089_Desc = {
    Text = "Kartu perintah selanjutnya yang dikeluarkan akan berlaku 2 kali."
  },
  State_61089_Name = {
    Text = "Tongkat Konduktor Orkestra"
  },
  State_61145_Name = {
    Text = "<BleedingColour: Berdarah>"
  },
  State_61174_Desc = {
    Text = "Tidak dapat memperoleh perisai."
  },
  State_61174_Name = {
    Text = "Pengiriman sisa-sisa"
  },
  State_61180_Desc = {
    Text = "Kerusakan dasar Helot-catena meningkat sebesar [DescArg1]% dalam pertempuran ini."
  },
  State_61180_Name = {
    Text = "Bilah Balas Dendam"
  },
  State_61185_Desc = {
    Text = "Akan meningkatkan kemampuan musuh. Kehilangan satu lapisan setiap kali menerima kerusakan."
  },
  State_61185_Name = {
    Text = "Sumpah Darah"
  },
  State_62213_Desc = {
    Text = "Efek Weakness yang ditimbulkan berubah menjadi mengurangi Active DMG dan Kerusakan tentakel yang ditimbulkan sebesar [Layer]%."
  },
  State_62213_Name = {
    Text = "<Rune_14_High:Perlemahan>"
  },
  State_62309_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat dipasang, dapatkan [StateArg1] <StrongEffectKeywords:Kuat>. Setiap kali kehilangan hidup, jika hidup saat ini di bawah [StateArg2]%, dapatkan <ReinforceKeywords:Diperkuat> dan <StrengthenKeywords:Memperkuat>."
  },
  State_62309_Name = {
    Text = "Tenggelam dalam Merah Abadi"
  },
  State_62317_Desc = {
    Text = "Kebal terhadap semua kerusakan. Efek ini akan dihilangkan setelah giliran dimulai."
  },
  State_62317_Name = {
    Text = "Kebal sepenuhnya terhadap kerusakan"
  },
  State_62336_Desc = {
    Text = "Setiap kali 3 kartu dimainkan (tersisa [Layer] kartu), tarik 1 kartu dan secara acak bekukan 1 Kartu perintah di tangan."
  },
  State_62336_Name = {
    Text = "Kehangatan Musim Dingin"
  },
  State_62337_Desc = {
    Text = "Setiap kali memainkan 3 kartu (tersisa [Layer] kartu), tarik 1 kartu dan secara acak bekukan 1 Kartu perintah di tangan."
  },
  State_62337_Name = {
    Text = "Kehangatan Musim Dingin"
  },
  State_62338_Desc = {
    Text = "Kartu ini tidak dapat dimainkan, tidak akan dibuang saat akhir ronde, dan memberikan 5 poin Aliemus kepada Pembangun yang dimiliki. Setelah Pembangun yang dimiliki melepaskan Muliakan, pembekuan akan dihilangkan."
  },
  State_62338_Name = {
    Text = "<CardKeyWord:Beku>"
  },
  State_65332_Desc = {
    Text = "Setelah kematian, semua Pembangun mendapatkan 30 poin Aliemus."
  },
  State_65332_Name = {Text = "Peleburan"},
  State_65342_Desc = {
    Text = "Setelah dikalahkan, akan hidup kembali, meningkatkan 100% Kesehatan maksimum secara tambahan dan melepaskan \"Frostbone Chill\"."
  },
  State_65342_Name = {Text = "Hening"},
  State_65346_Desc = {
    Text = "Setelah kematian, bekukan 2 Kartu Perintah di tumpukan kartu tangan."
  },
  State_65346_Name = {Text = "Frostfall"},
  State_65358_Desc = {
    Text = "Tim Satu-satunya: Penyaji meningkatkan kerusakan dasar yang dihasilkan sebanyak <WeaponEffect_Num:[StateArg1]%>. Sebelum penyaji melepaskan Muliakan, batas tangan sementara +1, menarik 1 kartu perintah yang dipasang. Jika alam saat ini adalah\"Caro\", ketika penyaji memicu melahap, kerusakan kritis sementara akan meningkat <WeaponEffect_Num:[StateArg1]%>, berlaku maksimal 1 kali per putaran"
  },
  State_65358_WeaponDesc = {
    Text = "Kerusakan dasar yang diberikan oleh pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Sebelum pemakai melepaskan Aliemus Muliakan, batas kartu sementara +1, dan tarik 1 Kartu perintah pemakai. Jika Alam saat ini adalah \"Caro\", kerusakan kritis sementara pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%> ketika Melahap dipicu, dengan maksimum 1 kali per ronde."
  },
  State_65360_Desc = {
    Text = "Satu-satunya di tim: Kerusakan dasar yang diberikan oleh pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Saat pertempuran dimulai, pemakai mendapatkan 25 lapisan \"Es Salju\", setelah pemakai memainkan kartu, mereka mendapatkan 2 poin Aliemus dan kehilangan 1 lapisan. Setelah \"Es Salju\" sepenuhnya dihilangkan, pemakai mendapatkan <WeaponEffect_Num:[StateArg2]%> tingkat kritis."
  },
  State_65360_WeaponDesc = {
    Text = "Kerusakan dasar yang diberikan oleh pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Saat pertempuran dimulai, pemakai mendapatkan 25 lapis \"Es Salju\". Setelah pemakai memainkan kartu, mereka mendapatkan 2 poin Aliemus dan kehilangan 1 lapis. Setelah \"Es Salju\" sepenuhnya dihilangkan, pemakai mendapatkan <WeaponEffect_Num:[StateArg2]%> tingkat kritis (saat ini tersisa [DescArg1] lapis Es Salju)."
  },
  State_65362_Desc = {
    Text = "Setelah menerima [StateArg1] kali kerusakan aktif secara kumulatif (tersisa [Layer] kali), 1 kartu perintah di tangan akan membeku secara acak."
  },
  State_65362_Name = {
    Text = "Pengembalian Frost"
  },
  State_65463_Name = {
    Text = "Mendapatkan 5 poin Segil Hitam"
  },
  State_65490_Desc = {
    Text = "Pada akhir ronde, dapatkan [StateArg1] lapisan Perisai Es dan [StateArg2] poin Kekuatan."
  },
  State_65490_Name = {Text = "Nol Mutlak"},
  State_65497_Name = {
    Text = "Helot-catena Demo"
  },
  State_65553_Desc = {
    Text = "Pada akhir ronde, dapatkan Kekuatan berdasarkan jumlah kartu yang tersisa di tangan, setiap kartu memberikan [Layer] poin."
  },
  State_65553_Name = {Text = "Bilah Es"},
  State_65557_Desc = {
    Text = "Setelah menerima kerusakan fatal, akan memulihkan semua kehidupan, niat dialihkan menjadi\"Kehadiran ruang yang sejati\", mendapatkan 80 lapisan penguatan sementara dan menghapus status negatif dan status positif pemain. Pada akhir putaran, akan menghapus 20 lapisan penguatan."
  },
  State_65557_Name = {
    Text = "Kekacauan Abadi"
  },
  State_65558_Desc = {
    Text = "Setelah menerima kerusakan fatal, niat dialihkan menjadi \"Kehadiran ruang\" dan mendapatkan 80 lapisan penguatan sementara, memulihkan semua kehidupan, dapat diaktifkan [DescArg1] kali. Setelah jumlah aktivasi habis, setelah menerima kerusakan fatal akan menyisakan 1 poin kehidupan, mengubah niat menjadi \"Mata dunia yang tak terhingga\". Pada akhir putaran, akan menghapus 20 lapisan penguatan."
  },
  State_65558_Name = {
    Text = "Debu bintang"
  },
  State_65559_Desc = {
    Text = "Setelah semua meninggal, Tuo Huwa Bo akan muncul kembali."
  },
  State_65559_Name = {
    Text = "Serpihan Kuno"
  },
  State_65564_Name = {
    Text = [[

<D05EX_Relic:Para anggota tim ekspedisi semakin mencurigai Helot, kamu harus membuat keputusan sebelum musuh mendekat untuk menenangkan tim yang kacau>]]
  },
  State_65565_Name = {
    Text = [[

<D05EX_Relic:Abaikan kecurigaan anggota tim, terus maju>]]
  },
  State_65566_Name = {
    Text = [[

<D05EX_Relic:Menjelaskan situasi kepada anggota tim penelitian>]]
  },
  State_65567_Name = {
    Text = [[

<D05EX_Relic:Mengikat Helot untuk melindungi anggota lebih lanjut>]]
  },
  State_65568_Name = {
    Text = [[

<D05EX_Relic:Mengikat Helot, dan menggunakan kekuatan Pembangun untuk sepenuhnya melindungi anggota tim>]]
  },
  State_65585_Desc = {
    Text = "Setelah kartu ini dimainkan, kembali ke tangan, orison tidak aktif hingga akhir ronde."
  },
  State_65585_Name = {
    Text = "<CardKeyWord:Gema>"
  },
  State_66305_Desc = {
    Text = "Saat akhir ronde, dapatkan 1 lapisan <ResentChainsKeywords:Rantai Kebencian> Sementara."
  },
  State_66305_Name = {
    Text = "Kunci dari Zaman Kuno hingga Saat Ini"
  },
  State_66306_Desc = {
    Text = "Saat menerima Active DMG dan kerusakan tentakel, Sealed Exalt dan semua Kartu yang menyerang Awakener selama 1 giliran, hapus 1 stacks <ResentChainsKeywords:Rantai Kebencian>."
  },
  State_66306_Name = {
    Text = "<ResentChainsKeywords1:Rantai Kebencian>"
  },
  State_66308_Desc = {
    Text = "Setelah menerima kerusakan fatal, nyawa akan terkunci pada 1."
  },
  State_66308_Name = {
    Text = "Kekacauan Abadi"
  },
  State_66311_Desc = {
    Text = "Memori para Pembangun muncul dari tepi pikiranmu, tertanam dan tumbuh di dalam otakmu. Tidak peduli berapa kali kau memutuskan mereka, tidak peduli berapa kali Pelarutan menenggelamkan mereka, mereka tak pernah benar-benar pergi."
  },
  State_66311_Name = {
    Text = "Memori yang Pecah"
  },
  State_66313_Desc = {
    Text = "Setiap kali memainkan 1 Kartu perintah, buang 1 Kartu dengan konsumsi Aritmetika terendah dari Pembangun ini."
  },
  State_66313_Name = {
    Text = "Tekanan Kehendak Tertinggi"
  },
  State_66314_Desc = {
    Text = "Kebal terhadap semua kerusakan."
  },
  State_66314_Name = {
    Text = "Kebal sepenuhnya terhadap kerusakan"
  },
  State_66317_Desc = {
    Text = "Memori para Pembangun muncul dari tepi pikiranmu, tertanam dan tumbuh di dalam otakmu. Tidak peduli berapa kali kau memutuskan mereka, tidak peduli berapa kali Pelarutan menenggelamkan mereka, mereka tak pernah benar-benar pergi. Pada awal setiap giliran, pulihkan 1 poin Arithmetica Limit dan 2 Maximum Hand Size."
  },
  State_66317_Name = {
    Text = "Fragmen Memori"
  },
  State_66325_Desc = {
    Text = "Memori para Pembangun muncul dari tepi pikiranmu, tertanam dan tumbuh di dalam otakmu. Tidak peduli berapa kali kau memutuskan mereka, tidak peduli berapa kali Pelarutan menenggelamkan mereka, mereka tak pernah benar-benar pergi. Pada awal setiap giliran, pulihkan 1 poin Arithmetica Limit dan 2 Maximum Hand Size."
  },
  State_66325_Name = {
    Text = "Fragmen Memori"
  },
  State_66358_Desc = {
    Text = "Saat Ketahanan dipicu untuk pertama kalinya selama eksplorasi, letakkan satu \"<DerivativeCardKeywords_39:Gema Masa Lalu>\" ke dalam tangan."
  },
  State_66358_Name = {
    Text = "Kehadiran yang tidak ada"
  },
  State_66359_Desc = {
    Text = "Menghasilkan sejumlah opsi secara acak untuk dipilih."
  },
  State_66359_Name = {
    Text = "<FaxianKeywords:Menemukan>"
  },
  State_66360_Desc = {
    Text = "Crit. Rate meningkat sebesar [Layer]% dalam pertempuran ini."
  },
  State_66360_Name = {Text = "Crit. Rate"},
  State_66362_Desc = {
    Text = "Crit. DMG meningkat sebesar [Layer]% dalam pertempuran ini."
  },
  State_66362_Name = {Text = "Crit. DMG"},
  State_66409_Name = {
    Text = "Hakim Pengganti"
  },
  State_66410_Desc = {
    Text = "Selama [DescArg1] detik, kartu perintah Tawil yang dimainkan akan berlaku 2 kali."
  },
  State_66410_Name = {
    Text = "Pusat Kekacauan"
  },
  State_66414_Desc = {
    Text = "Saat berada di tangan, jika kartu teratas dari tumpukan menggambar adalah kartu perintah, maka itu menjadi salinannya."
  },
  State_66414_Name = {
    Text = "Menguasai Prinsip Semua Hal"
  },
  State_66454_Desc = {
    Text = "Konsumsi aritmetika kartu keterampilan berkurang sebanyak \"Menyembunyikan\" tingkat, dapat ditumpuk hingga maksimal 5 lapis. Setelah menerima kerusakan atau menggunakan keterampilan, 1 lapis akan dihilangkan."
  },
  State_66454_Name = {
    Text = "Menyembunyikan"
  },
  State_66456_Desc = {
    Text = "Konsumsi aritmetika kartu keterampilan berkurang sebanyak \"Menyembunyikan\" tingkat, dapat ditumpuk hingga maksimal 5 lapis. Setelah menerima kerusakan atau menggunakan keterampilan, 1 lapis akan dihilangkan."
  },
  State_66456_Name = {
    Text = "<YinniColour:Menyembunyikan>"
  },
  State_66465_Desc = {
    Text = "Setelah menggunakan Muliakan, menerima kerusakan sesuai dengan jumlah lapisan yang terkait."
  },
  State_66465_Name = {
    Text = "<PVPfengsuoColour:Ledakan Penyegelan>"
  },
  State_66522_Desc = {
    Text = "Setiap kartu ke-8 yang kamu mainkan akan berlaku 2 kali."
  },
  State_66522_Name = {
    Text = "Ramuan Astral"
  },
  State_66553_Desc = {
    Text = "Setelah mengeluarkan \"Serangan\" dan \"Pertahanan\", Pembangun yang sesuai mendapatkan 35 Aliemus. Namun, konsumsi Aritmetika mereka meningkat +1."
  },
  State_66553_Name = {
    Text = "Raut Yang Retak"
  },
  State_66554_Desc = {
    Text = "Saat diambil, letakkan 1 kartu <DerivativeCardKeywords_1:\"Gema Bayangan Terlupakan\"> ke tangan."
  },
  State_66554_Name = {
    Text = "Peralatan Komunikasi"
  },
  State_66555_Desc = {
    Text = "Meningkatkan aritmetika maksimal sebesar 1."
  },
  State_66555_Name = {
    Text = "Injeksi Vitalitas"
  },
  State_66556_Desc = {
    Text = "Setiap kali kartu Pembangun yang sama dimainkan secara berurutan, Pembangun tersebut mendapatkan 8 Aliemus."
  },
  State_66556_Name = {Text = "Kronometer"},
  State_66557_Desc = {
    Text = "Setiap kali kamu kehilangan Hidup, dapatkan [DescArg1] poin <PowerIconKeywords:Kekuatan>, hingga 10 kali bertumpuk dalam setiap Pertempuran. Saat tumpukan penuh, pulihkan 25% dari Hidup yang telah hilang."
  },
  State_66557_Name = {
    Text = "Kehormatan Tertinggi"
  },
  State_66558_Desc = {
    Text = "Setiap 3 ronde, tambahkan 1 lapisan <WeaknessIconKeywords:Kelemahan> pada semua musuh. Setelah memberikan kerusakan kepada musuh dengan status <WeaknessIconKeywords:Kelemahan>, dapatkan [DescArg1] poin <PowerIconKeywords:Kekuatan> sementara, dan efek ini dapat dipicu maksimal 3 kali per ronde."
  },
  State_66558_Name = {Text = "Anak Jahat"},
  State_66559_Desc = {
    Text = "Ketika memainkan 1 Kartu dengan Lelah Aritmetika sebesar 3 atau lebih, tarik 1 Kartu dan dapatkan 1 poin Aritmetika."
  },
  State_66559_Name = {
    Text = "Keindahan dalam Kehilangan"
  },
  State_66560_Desc = {
    Text = "\"Serangan\"mendapatkan 2 poin Aritmetika, buang 1 kartu secara acak; \"Pertahanan\"menarik 2 kartu, kehilangan 1 poin Aritmetika. Maksimal dipicu 3 kali per ronde."
  },
  State_66560_Name = {
    Text = "Rekaman Membahagiakan"
  },
  State_66561_Desc = {
    Text = "Setiap 3 ronde, tambahkan 1 lapisan <VulnerabilityIconKeywords:Rentan> pada semua musuh. Setelah memberikan kerusakan kepada musuh dengan status <VulnerabilityIconKeywords:Rentan>, buat mereka kehilangan [DescArg1] poin <PowerIconKeywords:Kekuatan> sementara, efek ini dapat terpicu maksimal 3 kali per ronde."
  },
  State_66561_Name = {
    Text = "Ritual Mata Air"
  },
  State_66562_Desc = {
    Text = "Setiap 4 ronde, kerusakan yang diterima semua musuh di ronde ini akan dilipatgandakan, tetapi setelah melepaskan Muliakan di ronde tersebut, segel semua Pembangun selama 1 ronde."
  },
  State_66562_Name = {
    Text = "Jejak Penjelajah"
  },
  State_66563_Desc = {
    Text = "Pada awal ronde, jika jumlah kartu yang dimainkan pada ronde sebelumnya lebih dari 3, tarik 2 kartu."
  },
  State_66563_Name = {
    Text = "Dompet Baru"
  },
  State_66564_Desc = {
    Text = "Saat diambil, dapatkan 3 poin Aritmetika."
  },
  State_66564_Name = {
    Text = "Cermin jam saku"
  },
  State_66565_Desc = {
    Text = "Saat diambil, semua musuh akan diberikan 1 ronde <WeaknessIconKeywords:Kelemahan> dan <VulnerabilityIconKeywords:Rentan>."
  },
  State_66565_Name = {
    Text = "Pakaian Pengikat Berubah Warna"
  },
  State_66566_Desc = {
    Text = "Pada setiap awal ronde, <DeathResistanceIconKeywords:Ketahanan> meningkat 10% (setiap kali Ketahanan terpicu dalam level ini, jumlah Ketahanan yang diperoleh berkurang setengahnya). <DeathResistanceIconKeywords:Ketahanan> berada di atas 100%, <ProficientInRealmsIconKeywords:Penguasaan Alam> meningkat 100."
  },
  State_66566_Name = {
    Text = "Air Mata Siren"
  },
  State_66703_Desc = {
    Text = "Satu-satunya tim: Batas maksimum akumulasi Kunci perak meningkat sebesar 100%. Ukuran Tangan Maksimum +2, tidak dapat digabungkan dengan batas ukuran tangan yang diberikan oleh Roda takdir lainnya. Isi ulang Kunci perak pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah pemakai memainkan kartu, Crit. Rate dan Crit. DMG dari Kartu perintah pemakai, serta Perisai, Aliemus, dan Kekuatan yang dihasilkan meningkat sebesar <WeaponEffect_Num:[StateArg2]%>, dapat ditumpuk hingga 5 lapisan."
  },
  State_66703_WeaponDesc = {
    Text = "Batas maksimal akumulasi Kunci perak meningkat 100%. Batas ukuran tangan +2, tidak dapat ditumpuk dengan batas ukuran tangan yang diberikan oleh Roda takdir lainnya. Isi ulang Kunci perak pemakai meningkat sebesar <WeaponEffect_Num:[DescArg2]>. Setelah pemakai memainkan kartu, Crit. Rate dan Crit. DMG kartu perintah pemakai pada ronde ini, perisai yang dihasilkan, Aliemus, dan Kekuatan meningkat sebesar <WeaponEffect_Num:[StateArg2]%>, dapat ditumpuk hingga 5 lapisan (saat ini [DescArg1] lapisan)."
  },
  State_66722_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat dipasang dan pada awal giliran, jika tidak memiliki <PVPProtectiveKeywords:Penghalang> dapatkan [StateArg1] lapisan <PVPProtectiveKeywords:Penghalang>, jika tidak, dapatkan <StrengthenKeywords:Memperkuat>."
  },
  State_66722_Name = {
    Text = "Roda Niskala"
  },
  State_66872_Desc = {
    Text = "Kerusakan, perisai, dan pemulihan hidup Tawil sementara meningkat sebesar [StateArg1]%, berlangsung selama [Layer] putaran."
  },
  State_66872_Name = {
    Text = "Cahaya Miliaran yang Tak Terbatas"
  },
  State_66884_Desc = {
    Text = "Pada akhir ronde, konsumsi aritmetika berkurang, Efek ini juga akan terpicu saat dibuang."
  },
  State_66884_Name = {
    Text = "<PrepareKeypvewords:Persiapan1>"
  },
  State_66888_Desc = {
    Text = "Unik tim: Setelah melepaskan geng, dapatkan <PowerIconKeywords:Kekuatan> serangan <WeaponEffect_Num:[StateArg1]%> dan perisai pertahanan <WeaponEffect_Num:[StateArg2]%. Setelah menggunakan tubuh setiap jiwa, di akhir giliran, semua pembangun mendapatkan <WeaponEffect_Num:[StateArg3]> poin aliemus."
  },
  State_66888_Name = {
    Text = "Jantung Perak"
  },
  State_66888_WeaponDesc = {
    Text = "Setelah melepaskan Geng, dapatkan <WeaponEffect_Num:[Power:DescArg1]> poin <PowerIconKeywords:Kekuatan> dan <WeaponEffect_Num:[Block:DescArg2]> poin Perisai. Setelah menggunakan Gnosis darurat, pada akhir giliran semua Pembangun mendapatkan <WeaponEffect_Num:[StateArg3]> poin Aliemus."
  },
  State_66893_Desc = {
    Text = "Satu-satunya Tim: Setelah pertempuran dimulai, dapatkan energi-s yang setara dengan <WeaponEffect_Num:[StateArg1]%> dari isi ulang kunci perak. Setelah menggunakan Geng untuk pertama kalinya dalam setiap pertempuran, efek ini akan diulang sekali lagi."
  },
  State_66893_WeaponDesc = {
    Text = "Setelah pertempuran dimulai, dapatkan <WeaponEffect_Num:[DescArg1]> poin Energi-s. Setelah menggunakan Geng untuk pertama kalinya dalam setiap pertempuran, Efek ini akan diulang sekali."
  },
  State_66896_WeaponDesc = {
    Text = "Mengubah aritmetika kartu sebelum bermain"
  },
  State_66900_Desc = {
    Text = "Kerusakan, penyembuhan dan perisai kartu ini meningkat sebesar [StateArg1]%"
  },
  State_66900_Name = {
    Text = "Jantung Perak"
  },
  State_66901_Desc = {
    Text = "Efek kerusakan, penyembuhan, dan perisai meningkat sebesar [DescArg1]%, berlangsung selama 1 ronde"
  },
  State_66901_Name = {
    Text = "Sementara Efek Kuat"
  },
  State_66902_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setelah kematian Awakener sekutu lainnya, dapatkan <Block:[Block:StateArg1]> perisai, tempatkan kartu \"Keterampilan\" dengan konsumsi aritmetika terendah ke dalam tanganmu."
  },
  State_66902_Name = {
    Text = "Jantung Perak"
  },
  State_66971_Desc = {
    Text = "Ketika hidup berkurang menjadi 0, ubah hidup menjadi 1 poin dan tidak akan menerima kerusakan lagi."
  },
  State_66971_Name = {
    Text = "Dunia terputus"
  },
  State_67234_Desc = {
    Text = "Pada akhir ronde, memanggil satu \"Otak dalam toples cabang\", berlangsung selama [Layer] ronde."
  },
  State_67234_Name = {Text = "Pemisahan"},
  State_67235_Desc = {
    Text = "Mengembalikan semua nyawa saat mati, batas maksimum hidup +100%, melepaskan \"Wabah Jiwa\"."
  },
  State_67235_Name = {Text = "Not Roused"},
  State_67237_Desc = {
    Text = "Ketika mencapai lapisan 10, niat berubah menjadi \"Akhir Ilusi\": Ubah batas hidup lawan menjadi 1."
  },
  State_67237_Name = {Text = "Akhir"},
  State_67238_Desc = {
    Text = "Pada akhir ronde, dapatkan 1 lapisan \"Akhir\". Setelah menerima kerusakan mematikan, negara ini akan dihilangkan dan kebal terhadap kerusakan selama 1 ronde, pulihkan 15% hidup dan dapatkan 10 lapisan \"Akhir\"."
  },
  State_67238_Name = {Text = "Wabah Jiwa"},
  State_67240_Desc = {
    Text = "\"Sang Pengetahuan\"memperoleh 25 lapisan sementara <ReinforcePVEKeywords:Diperkuat> dan [Power:StateArg1] poin sementara <PowerIconKeywords:Kekuatan>, menghapus negara ini."
  },
  State_67240_Name = {
    Text = "<TuiyanColour:Analisis>"
  },
  State_67241_Desc = {
    Text = "Mengembalikan semua Hidup saat mati, batas maksimum Hidup +100%, melepaskan \"Kesungguhan Ksatria\"."
  },
  State_67241_Name = {Text = "Not Roused"},
  State_67242_Desc = {
    Text = "Mengembalikan semua Hidup saat mati, batas maksimum Hidup +100%, melepaskan \"Roh Daging@1 menit\"."
  },
  State_67242_Name = {Text = "Not Roused"},
  State_67243_Desc = {
    Text = "Pada akhir ronde, memanggil satu \"Otak dalam toples sub-unit\". Ketika sub-unit Otak dalam toples memicu \"Pemisahan Intelek\", curi tambahan 5% Kekuatan pemain."
  },
  State_67243_Name = {
    Text = "jiwa dan daging@1 poin"
  },
  State_67245_Desc = {
    Text = "Pada akhir ronde, dapatkan [StateArg1] poin <PowerIconKeywords:Kekuatan>."
  },
  State_67245_Name = {
    Text = "Jiwa Ksatria"
  },
  State_67246_Desc = {
    Text = "Setiap kali perisai dihancurkan untuk pertama kalinya dalam satu ronde, kehilangan 25% dari kesehatan maksimum, mendapatkan [Power:DescArg1] poin <PowerIconKeywords:Kekuatan Sementara> dan [Layer] lapisan Diperkuat Sementara. Pada awal ronde berikutnya, peroleh kembali <Block:[Block:DescArg2]> lapisan Perisai, setiap kali \"Keyakinan Ksatria\" dipicu, dapatkan tambahan 1 lapisan Perisai."
  },
  State_67246_Name = {
    Text = "Kesetiaan Ksatria"
  },
  State_67247_Desc = {
    Text = "Setiap akhir ronde akan muncul musuh baru, dengan maksimal 2 musuh ada secara bersamaan. Setelah musuh mati, \"Otak yang Membusuk\"kehilangan 5% Kesehatan Maksimum."
  },
  State_67247_Name = {
    Text = "Pintu Jurang"
  },
  State_67252_Desc = {
    Text = "Saat menerima kerusakan fatal, pindah ke barisan belakang dan menyisakan 1 poin hidup. Setelah itu, tidak dapat menerima kerusakan lagi, <PowerIconKeywords:Kekuatan> meningkat [DescArg1]. Ledakan diri tidak akan memicu efek ini."
  },
  State_67252_Name = {
    Text = "Pemisahan Esensi"
  },
  State_67253_Desc = {
    Text = "Setelah memainkan [Layer] kartu, hasilkan 1 \"Otak dalam toples\" di depan, dengan maksimal 3 entitas yang ada secara bersamaan."
  },
  State_67253_Name = {
    Text = "Otak Dalam Tabung"
  },
  State_67255_Desc = {
    Text = "Mengembalikan semua Hidup saat mati, batas maksimum Hidup +100%, lepaskan \"Filsafat Pertama\"."
  },
  State_67255_Name = {Text = "Not Roused"},
  State_67256_Desc = {
    Text = "Setelah fase menggambar, secara acak tunjukkan tiga kartu perintah dari kartu di tangan, pilih satu untuk diberikan \"Orison\", dan buang kartu lainnya."
  },
  State_67256_Name = {
    Text = "Filsafat Pertama"
  },
  State_67257_Desc = {
    Text = "Setelah Geng pertama kali dilepaskan setiap putaran, semua Pembangun mendapatkan 10 Aliemus, tetapi Lelah pelepasan Geng meningkat secara permanen sebesar 10%."
  },
  State_67257_Name = {
    Text = "Tautan yang Berangsur Pecah"
  },
  State_67258_Desc = {
    Text = "Pada awal pertempuran, dapatkan <Block:[Block:DescArg1]> lapisan perisai. Pada akhir ronde, perisai tidak akan hilang."
  },
  State_67258_Name = {
    Text = "Kesetiaan Ksatria"
  },
  State_67347_Desc = {
    Text = "Saat berada di tangan, jika kartu di bagian atas tumpukan menggambar adalah kartu perintah, maka menjadi salinan dengan konsumsi aritmetika -1."
  },
  State_67347_Name = {
    Text = "Menguasai Prinsip Semua Hal"
  },
  State_67353_Desc = {
    Text = "Setelah kematian, \"Otak yang Membusuk\"kehilangan 5% dari Kesehatan maksimum."
  },
  State_67353_Name = {Text = "Meltdown"},
  State_67358_Desc = {
    Text = "Setiap kali pemain kehilangan 1 poin Aritmetika, langsung dapatkan <Block:[Block:StateArg1]> poin Perisai dan 3 lapis Diperkuat sementara."
  },
  State_67358_Name = {
    Text = "Barier tak tentu"
  },
  State_67414_Desc = {
    Text = "Mata yang tak tertahankan untuk dipandang langsung. Aura yang tak terlawankan. Segala fragmen tetaplah hanya fragmen. Sekarang, hadapilah akhir yang pasti menuju kehancuran..."
  },
  State_67414_Name = {
    Text = "Hadapi ribuan Genesis"
  },
  State_67418_Desc = {
    Text = "Setelah digunakan, buang semua kartu selain Pembangun ini dan dapatkan 5 Kartu acak non-Pembangun. Hanya berlaku 1 kali per pertempuran."
  },
  State_67418_Name = {
    Text = "<WhiteQuality:Prinsip Kesenangan Tingkat Lanjut>"
  },
  State_67419_Desc = {
    Text = "Setelah digunakan, dapatkan 3 salinan asli dengan <RetainIconKeywords:Pertahankan>dan<DepleteIconKeywords:Konsumsi>dan kurangi konsumsi Aritmetika mereka sebesar 1, hanya berlaku 1 kali per pertempuran."
  },
  State_67419_Name = {
    Text = "<WhiteQuality: Teori Pemuliaan Tingkat Lanjut>"
  },
  State_67420_Desc = {
    Text = "Setelah dimainkan, tarik 4 kartu dan kurangi konsumsi Aritmetika mereka sebesar konsumsi Aritmetika aktual kartu Orison. Hanya berlaku 1 kali per pertempuran."
  },
  State_67420_Name = {
    Text = "<WhiteQuality:Prinsip Intelektual Tingkat Tinggi>"
  },
  State_67598_Desc = {
    Text = "Setelah melepaskan Aliemus Muliakan, tempatkan satu kartu acak Pembangun ke dalam tangan. Kartu tersebut mendapatkan <DepleteIconKeywords:Lelah> dan <NothingnessIconKeywords:Ilusi>. Setelah pertempuran berakhir, pulihkan [DescArg1] poin hidup."
  },
  State_67598_Name = {
    Text = "Kasus Dokter"
  },
  State_67599_Desc = {
    Text = "Setelah kartu perintah yang bukan \"Serangan\" atau \"Pertahanan\" dimainkan, Pembangun yang sesuai mendapatkan 15 Aliemus. Maksimal dipicu 5 kali per ronde. Saat pertama kali dipicu dalam satu ronde, kartu yang dimainkan akan dikembalikan ke tangan."
  },
  State_67599_Name = {
    Text = "Pendulum waktu·Proyektil"
  },
  State_67600_Desc = {
    Text = "Meningkatkan aritmetika maksimum sebesar 4, dan setiap kali dek kartu direset, tambahkan 4 kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam tumpukan menggambar."
  },
  State_67600_Name = {
    Text = "Diberkati·Lilin Hitam"
  },
  State_67602_Name = {
    Text = "Tidak Digunakan"
  },
  State_67603_Desc = {
    Text = "Kerusakan terhadap musuh dalam kondisi negara meningkat sebesar 20%, setelah membunuh musuh, pembunuh mendapatkan 20 Aliemus."
  },
  State_67603_Name = {
    Text = "Tongkat Hierophant"
  },
  State_67604_Desc = {
    Text = "Setiap kali memainkan kartu perintah yang berbeda dari Pembangun sebelumnya, Pembangun tersebut mendapatkan 3 poin Aliemus dan mengumpulkan 1 lapisan \"Aktivitas\". Saat mengumpulkan 10 lapisan, semua \"Aktivitas\" akan dihapus, dan satu kartu perintah acak dengan pengurangan konsumsi Aritmetika sebesar 1 dari setiap Pembangun akan dimasukkan ke tangan, serta memiliki atribut \"Lelah\". Efek ini hanya dapat diaktifkan maksimal 1 kali per ronde."
  },
  State_67604_Name = {
    Text = "Pendulum waktu·Evolusi"
  },
  State_67605_Desc = {
    Text = "Ketika kamu memiliki perisai, relik ini memberikan [DescArg1] poin sementara <PowerIconKeywords:Kekuatan>. Jika perisaimu lebih tinggi daripada hidup saat ini, secara tambahan memberikan [DescArg2] poin sementara <PowerIconKeywords:Kekuatan>."
  },
  State_67605_Name = {
    Text = "Kipas Burung Merpati"
  },
  State_67606_Desc = {
    Text = "Pada awal ronde, dapatkan 1 Aritmetika untuk setiap 1 musuh. Saat membunuh musuh dengan kerusakan aktif, berikan <BleedingIconKeywords:Berdarah> kepada musuh lainnya yang setara dengan kerusakan berlebih."
  },
  State_67606_Name = {
    Text = "Nyanyian Massa"
  },
  State_67607_Desc = {
    Text = "Setelah melepaskan Muliakan sebanyak 5 kali, Pembangun yang melepaskan Muliakan akan mendapatkan 100 Aliemus."
  },
  State_67607_Name = {
    Text = "Kecil Kain Pembungkus"
  },
  State_67608_Name = {
    Text = "Tidak Digunakan"
  },
  State_67609_Desc = {
    Text = "Setelah melepaskan Aliemus Muliakan, kehilangan 8% dari Hidup saat ini, mencuri [DescArg1] poin sementara <PowerIconKeywords:Kekuatan> dari semua musuh. Jika hanya ada 1 musuh, mencuri tambahan [DescArg2] poin sementara <PowerIconKeywords:Kekuatan>."
  },
  State_67609_Name = {
    Text = "Burung Ritual Malapetaka"
  },
  State_67611_Desc = {
    Text = "Setiap 2 putaran, kerusakan yang diterima oleh semua musuh menjadi dua kali lipat. Dalam putaran ini, setiap kali melepaskan 1 Muliakan, secara acak menghilangkan 1 jenis Negara negatif."
  },
  State_67611_Name = {
    Text = "Diberkati·Tulang Jalan"
  },
  State_67612_Desc = {
    Text = "Semua kerusakan kritis yang disebabkan oleh \"pukulan\" meningkat sebesar 20%. Saat diambil, tambahkan 1 kartu <DerivativeCardKeywords_40:\"Momen Indah\"> ke tangan."
  },
  State_67612_Name = {
    Text = "Momen Indah β"
  },
  State_67614_Desc = {
    Text = "Pada awal setiap ronde, semua Pembangun mendapatkan 25 Aliemus. Saat diambil, Kesehatan maksimum menjadi 1,5 kali lipat."
  },
  State_67614_Name = {
    Text = "Diberkati·Manifestasi Mimpi Buruk β"
  },
  State_67615_Desc = {
    Text = "Setiap kartu perintah ke-6 yang dimainkan akan dikembalikan ke tangan dari tumpukan kartu buang."
  },
  State_67615_Name = {
    Text = "Dalam Rembulan"
  },
  State_67616_Name = {
    Text = "Tidak Digunakan"
  },
  State_67618_Desc = {
    Text = "Pada awal setiap putaran, semua Pembangun mendapatkan 25 Aliemus. Saat diambil, Kesehatan maksimum menjadi 1,5 kali lipat."
  },
  State_67619_Desc = {
    Text = "Batas kartu tangan meningkat 5. Saat memungut, isi ulang kartu tangan hingga batas maksimal. Di awal giliran, tarik 1 kartu tambahan; di akhir giliran, buang semua Kartu gejala dan Kartu negara di tangan, dan simpan kartu lainnya."
  },
  State_67619_Name = {
    Text = "Diberkati·Pencatatan Kesadaran β"
  },
  State_67620_Desc = {
    Text = "Setelah memainkan kartu ke-3 setiap ronde, tempatkan 1 <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam tumpukan kartu buang. Setelah memainkan kartu ke-6 setiap ronde, ambil 1 <DerivativeCardKeywords_4:\"Inspirasi\"> dari tumpukan kartu buang dan masukkan ke dalam tangan."
  },
  State_67620_Name = {
    Text = "Peradaban Cahaya"
  },
  State_67621_Desc = {
    Text = "Setelah melepaskan Muliakan, dapatkan [DescArg1] poin kekuatan sementara, dan curi dari semua musuh [DescArg1] poin kekuatan sementara <PowerIconKeywords:Kekuatan>, jika hanya ada 1 musuh, curi tambahan [DescArg2] poin kekuatan sementara <PowerIconKeywords:Kekuatan>."
  },
  State_67621_Name = {
    Text = "Burung Ritual Kutukan · Terberkati"
  },
  State_67622_Desc = {
    Text = "Ketika poin Aritmetika terakhir habis, dapatkan 2 Aritmetika. Maksimal dipicu 2 kali per ronde."
  },
  State_67622_Name = {
    Text = "Mesin Perbedaan Perak-Putih"
  },
  State_67623_Desc = {
    Text = "Setelah diambil, dapatkan [DescArg1] <PowerIconKeywords:Kekuatan> secara permanen. Setiap kali memberikan kerusakan, pulihkan [DescArg2] poin hidup, maksimal dipicu 6 kali per putaran."
  },
  State_67623_Name = {
    Text = "Diberkati · Ciuman Belut Tujuh Insang"
  },
  State_67624_Name = {
    Text = "Tidak Digunakan"
  },
  State_67625_Desc = {
    Text = "Setelah kartu perintah pertama kali dimainkan dalam setiap ronde masuk ke tumpukan kartu buang, salinan sementara dari kartu tersebut dengan pengurangan konsumsi aritmetika sebesar 1 akan dicuci ke dalam tumpukan menggambar."
  },
  State_67625_Name = {
    Text = "Kotak Musik Yang Bisu"
  },
  State_67626_Desc = {
    Text = "Meningkatkan Aritmetika maksimal sebesar 1. Saat memainkan Kartu dengan Lelah lebih tinggi daripada Kartu sebelumnya sebanyak 2 kali berturut-turut, dapatkan 1 Aritmetika."
  },
  State_67626_Name = {
    Text = "Kumpulan Kitab"
  },
  State_67628_Name = {
    Text = "Tidak Digunakan"
  },
  State_67630_Name = {
    Text = "Tidak Digunakan"
  },
  State_67631_Desc = {
    Text = "Meningkatkan aritmetika maksimal sebesar 2. Setiap kali dek kartu direset, tambahkan 1 kartu <DerivativeCardKeywords_9:\"Tertatih\"> ke tumpukan menggambar."
  },
  State_67631_Name = {
    Text = "Lilin Hitam"
  },
  State_67632_Name = {
    Text = "Tidak Digunakan"
  },
  State_67634_Desc = {
    Text = "Pada akhir ronde, untuk setiap 1 Kartu yang belum dimainkan di tangan, berikan 2 Aliemus kepada semua Pembangun."
  },
  State_67634_Name = {
    Text = "Skala yang Miring"
  },
  State_67635_Desc = {
    Text = "Saat mengambil, semua yang terbangun mendapatkan 50 poin Aliemus, masukkan 2 kartu<DerivativeCardKeywords_1:\"Echos Bayangan\"> ke dalam tumpukan gambar."
  },
  State_67635_Name = {
    Text = "Peralatan Komunikasi +β"
  },
  State_67636_Desc = {
    Text = "Crit. DMG meningkat sebesar 15%. Serangan terhadap musuh dengan perisai selalu menghasilkan Crit. DMG."
  },
  State_67636_Name = {
    Text = "Prinsip-Prinsip Estetik"
  },
  State_67637_Desc = {
    Text = "Di awal putaran, ambil 2 kartu, dan mendapatkan 2 poin Aritmetika. Setiap kali kamu mengambil 1 kartu Kartu perintah atau Gnosis, secara acak mengubah biaya Aritmetikanya. （0-4）"
  },
  State_67637_Name = {Text = "Topi ajaib"},
  State_67638_Desc = {
    Text = "Kerusakan terhadap musuh dalam kondisi negara meningkat sebesar 50%, setelah membunuh musuh, pembunuh mendapatkan 100 Aliemus."
  },
  State_67638_Name = {
    Text = "Tongkat Pendeta+"
  },
  State_67639_Desc = {
    Text = "Crit. Rate meningkat sebesar 50%, Crit. DMG meningkat sebesar 100%."
  },
  State_67639_Name = {
    Text = "Diberkati·Cakar Aneh"
  },
  State_67640_Desc = {
    Text = "Crit. Rate dan Crit. DMG meningkat 100%. Setiap kali memberikan 1 Kerusakan/Kerusakan tentakel, pada giliran ini: Crit. Rate dan Crit. DMG semua Awakener berkurang 10%, hingga maksimal 50%. Racun dan Counter yang diberikan meningkat 10%, hingga maksimal 50%."
  },
  State_67640_Name = {
    Text = "Pendulum waktu·Shift Surge"
  },
  State_67641_Desc = {
    Text = "Setelah melepaskan Aliemus Muliakan, dapatkan [DescArg1] poin sementara <PowerIconKeywords:Kekuatan>."
  },
  State_67641_Name = {Text = "Kunci Besi"},
  State_67643_Desc = {
    Text = "Mendapatkan [DescArg1] poin perisai saat memberikan kerusakan aktif. Saat memulihkan hidup, mendapatkan [DescArg2] poin <PowerIconKeywords:Kekuatan> sementara."
  },
  State_67643_Name = {Text = "Rumah Kita"},
  State_67645_Desc = {
    Text = "Meningkatkan Crit. Rate sebesar 10%. Setelah serangan kritis pertama setiap ronde, Crit. Rate akan meningkat tambahan 20%, dan setelah serangan kritis ketiga dalam satu ronde, Crit. DMG akan meningkat tambahan 50%."
  },
  State_67645_Name = {
    Text = "Perayaan Berkat"
  },
  State_67646_Desc = {
    Text = "Pada akhir ronde ganjil, jika ada Aritmetika tersisa, tarik 2 kartu tambahan di ronde berikutnya; pada akhir ronde genap, jika ada kartu tangan tersisa, dapatkan 2 Aritmetika tambahan di ronde berikutnya."
  },
  State_67646_Name = {
    Text = "Piringan Surya"
  },
  State_67647_Desc = {
    Text = "Setiap kartu perintah ke-5 yang kamu keluarkan akan berlaku 2 kali, setelah digunakan kembali ke tangan."
  },
  State_67647_Name = {
    Text = "Starry Wine+"
  },
  State_67649_Desc = {
    Text = "Menyembunyikan niat monster. Setiap putaran, dapatkan 1 poin Aritmetika dan tarik 1 kartu."
  },
  State_67649_Name = {
    Text = "Lonceng Penjebak"
  },
  State_67650_Desc = {
    Text = "\"Serangan\" dan \"Pertahanan\" mendapatkan tambahan 50 poin Energi-s. Setiap kali kamu memainkan 1 Kartu dengan Lelah Aritmetika sebesar 2 atau lebih, tarik 1 Kartu dengan Lelah Aritmetika sebesar 1 dan ubah Lelah Aritmetikanya menjadi 0. Efek ini dapat bekerja maksimal 3 kali per ronde."
  },
  State_67650_Name = {
    Text = "Pendulum waktu·Kembar"
  },
  State_67651_Desc = {
    Text = "Saat mengambil, penguasaan alam tim menjadi 150% dari nilai aslinya. Setelah memainkan kartu perintah ke-5 setiap putaran, semua Pembangun mendapatkan 20 Aliemus."
  },
  State_67651_Name = {
    Text = "Pendulum waktu·Tidak suci"
  },
  State_67653_Desc = {
    Text = "Setelah melepaskan Muliakan sebanyak 2 kali per ronde, semua Pembangun mendapatkan 8 poin Aliemus, dan setelah melepaskan sebanyak 3 kali, semua Pembangun mendapatkan tambahan 8 poin Aliemus lagi."
  },
  State_67653_Name = {
    Text = "Darah Terbuang"
  },
  State_67654_Name = {
    Text = "Berlaku tambahan [DescArg1] kali"
  },
  State_67656_Desc = {
    Text = "Crit. Rate meningkat 50%, <FragileIconKeywords:Rapuh> diri sendiri selama 3 putaran."
  },
  State_67656_Name = {Text = "Cakar Aneh"},
  State_67657_Desc = {
    Text = "Pada awal giliran, tarik 1 kartu. Ketika secara berturut-turut 2 kali memainkan kartu dengan aritmetika yang sama seperti kartu sebelumnya, tarik 1 kartu tambahan. Efek ini dapat berlaku maksimal 3 kali per giliran."
  },
  State_67657_Name = {
    Text = "Perangkat Gnosis"
  },
  State_67658_Desc = {
    Text = "Ketika memainkan 1 Kartu dengan Lelah sebesar 3, tarik 1 Kartu dan dapatkan 2 Aritmetika; ketika memainkan 1 Kartu dengan Lelah sebesar 4 atau lebih, Lelah dari Kartu lain di tangan berkurang 1."
  },
  State_67658_Name = {
    Text = "Pendulum waktu·Mata"
  },
  State_67659_Desc = {
    Text = "Pada awal ronde, dapatkan 2 Aritmetika untuk setiap 1 musuh. Saat membunuh musuh dengan Kerusakan aktif, berikan kerusakan berlebih dua kali lipat kepada musuh lainnya <BleedingIconKeywords:Berdarah>."
  },
  State_67659_Name = {
    Text = "Lagu Kerumunan+"
  },
  State_67660_Desc = {
    Text = "Setiap ketiga kalinya \"Serangan\" dilancarkan, berikan [DescArg1] kerusakan kepada semua musuh, dan Pembangun yang sesuai mendapatkan 15 Aliemus."
  },
  State_67660_Name = {
    Text = "Pisau Bedah Berkarat"
  },
  State_67661_Desc = {
    Text = "Setiap kali Lelah Aritmetika, tarik 1 kartu, setiap ronde efek ini dapat diaktifkan hingga 5 kali. Setiap kali dek kartu diatur ulang, dapatkan 2 Aritmetika."
  },
  State_67661_Name = {
    Text = "Pendulum waktu·Insomnia"
  },
  State_67662_Desc = {
    Text = "Setiap kali kamu memainkan kartu non-Bangun, Pembangun dengan Aliemus terendah mendapatkan 10 Aliemus."
  },
  State_67662_Name = {
    Text = "Koleksi Stampel Asing"
  },
  State_67665_Desc = {
    Text = "Maksimum Aritmetika meningkat 2. Setelah memainkan \"Serangan\" atau \"Pertahanan\", Pembangun yang sesuai mendapatkan 5 Aliemus. Setelah melepaskan Muliakan, dapatkan 1 \"Serangan\" dengan konsumsi Lelah Ilusi dari Pembangun yang sesuai. Setelah melepaskan Geng, dapatkan secara acak 1 \"Pertahanan\" dengan konsumsi Lelah Ilusi."
  },
  State_67665_Name = {
    Text = "Pendulum waktu·Bulu"
  },
  State_67666_Desc = {
    Text = "Setiap kali memberikan kerusakan, dapatkan [DescArg1] poin <PowerIconKeywords:Kekuatan> sementara, hingga 3 kali tumpukan. Ketika jumlah tumpukan mencapai maksimum, efeknya berlipat ganda."
  },
  State_67666_Name = {
    Text = "Kerawang Akik"
  },
  State_67667_Desc = {
    Text = "Setelah ronde berakhir, semua Pembangun mendapatkan 5 Aliemus. Untuk setiap 1 poin Aritmetika yang tersisa, semua Pembangun akan mendapatkan tambahan 3 Aliemus."
  },
  State_67667_Name = {
    Text = "Baterai Prototip"
  },
  State_67668_Desc = {
    Text = "Kerusakan kritis meningkat sebesar 15%. \"Serangan\"tingkat kritis meningkat sebesar 40%."
  },
  State_67668_Name = {
    Text = "Paruh Gagak Putih"
  },
  State_67669_Name = {
    Text = "Tidak Digunakan"
  },
  State_67670_Desc = {
    Text = "Setelah melepaskan Muliakan, tarik 1 kartu. Jika Hidup berada di bawah 25%, tarik 1 kartu tambahan."
  },
  State_67670_Name = {
    Text = "Roda Ilmu Pengetahuan"
  },
  State_67671_Desc = {
    Text = "Setiap kali memberikan 1 kerusakan aktif, pulihkan [DescArg1] hidup, dan tambahkan [DescArg2] lapisan <BleedingIconKeywords:Berdarah> pada target kerusakan."
  },
  State_67671_Name = {
    Text = "Diberkati·Kesadaran Kumpulan Serangga"
  },
  State_67672_Desc = {
    Text = "Efek <WeaknessIconKeywords:Kelemahan> meningkat sebesar 8%, efek <VulnerabilityIconKeywords:Rentan> meningkat sebesar 25%. Saat memberikan <WeaknessIconKeywords:Kelemahan> atau <VulnerabilityIconKeywords:Rentan>, mencuri sementara [DescArg1] poin <PowerIconKeywords:Kekuatan> dari target."
  },
  State_67672_Name = {
    Text = "Foto pudar+"
  },
  State_67673_Desc = {
    Text = "Pada awal ronde, tarik 1 kartu."
  },
  State_67673_Name = {
    Text = "Kompas Utara Yang Benar"
  },
  State_67674_Desc = {
    Text = "Setiap kali memainkan 1 Kartu perintah, dapatkan [DescArg2]% <DeathResistanceIconKeywords:Ketahanan> (setiap kali Ketahanan dipicu dalam level ini, jumlah Ketahanan yang diperoleh berkurang setengahnya). Jika <DeathResistanceIconKeywords:Ketahanan> Anda mencapai 100% atau lebih, ganti dengan mendapatkan [DescArg1] poin <PowerIconKeywords:Kekuatan> sementara."
  },
  State_67674_Name = {
    Text = "Taring Ular"
  },
  State_67675_Desc = {
    Text = "Jika ada Aritmetika tersisa di akhir ronde, tarik 2 kartu tambahan pada ronde berikutnya; jika ada kartu tersisa di tangan, dapatkan 2 Aritmetika tambahan pada ronde berikutnya."
  },
  State_67675_Name = {
    Text = "Matahari dan Bulan Loop+"
  },
  State_67677_Desc = {
    Text = "Ketika kamu menyebabkan <WeaknessIconKeywords:Kelemahan>, dapatkan [DescArg1] poin Perisai; ketika menyebabkan <VulnerabilityIconKeywords:Rentan>, dapatkan [DescArg2] poin <PowerIconKeywords:Kekuatan> sementara. Jika kedua Efek ini terpicu dalam 1 putaran, dapatkan tambahan [DescArg1] poin Perisai dan [DescArg2] poin <PowerIconKeywords:Kekuatan> sementara."
  },
  State_67677_Name = {
    Text = "Bingkai Gambar Berat"
  },
  State_67703_Desc = {
    Text = "Pada awal ronde, jika jumlah kartu tangan yang tersisa dari ronde sebelumnya lebih dari 3, dapatkan 2 Aritmetika."
  },
  State_67703_Name = {
    Text = "Lencana Mythag"
  },
  State_67704_Desc = {
    Text = "Setelah melepaskan Muliakan, Pembangun yang sesuai mendapatkan 10 Aliemus dan memperoleh perisai sebesar [DescArg1]."
  },
  State_67704_Name = {
    Text = "Cadar Dewa Tanpa Nama"
  },
  State_67796_Name = {
    Text = "<TongxiaoKeywords:Memahami segala hal>: Setelah digunakan, kembalikan dan dapatkan <Energy:[StateArg1]> poin Aliemus"
  },
  State_67841_WeaponDesc = {
    Text = "Mengubah aritmetika kartu sebelum bermain"
  },
  State_67844_Desc = {
    Text = "Setelah menerima kerusakan fatal, pulihkan semua nyawa, dapat dipicu sebanyak @1 kali, saat ini sudah dipicu [DescArg1] kali."
  },
  State_67844_Name = {
    Text = "Kekacauan Abadi"
  },
  State_67866_Name = {
    Text = "<BleedingColour: Berdarah>"
  },
  State_68298_Desc = {
    Text = "Setelah menerima kerusakan fatal, niat dialihkan menjadi\"Kehadiran ruang\"dan mendapatkan 80 lapisan penguatan sementara, memulihkan semua kehidupan, dapat diaktifkan [DescArg1] kali. Pada akhir putaran, akan menghapus 20 lapisan penguatan."
  },
  State_68298_Name = {
    Text = "Debu bintang"
  },
  State_68554_Desc = {
    Text = "Setelah menerima kerusakan fatal, pulihkan semua hidup. Setelah semua musuh lainnya mati, hapus status ini. Dapat dipicu @1 kali, saat ini sudah dipicu [DescArg1] kali."
  },
  State_68554_Name = {
    Text = "Serpihan Kekacauan Abadi"
  },
  State_68621_Desc = {
    Text = "Saat pertarungan dimulai dan setiap akhir ronde, dapatkan 2 lapisan <ResentChainsKeywords:Rantai Kebencian> Sementara."
  },
  State_68621_Name = {
    Text = "Aliran Misterius"
  },
  State_68622_Desc = {
    Text = "Efek kekuatan yang diberikan oleh Pembangun berkurang sebesar 75%. Setiap kali kehilangan hidup, mendapatkan [DescArg1] poin Perisai dan 1 lapisan Diperkuat sementara."
  },
  State_68622_Name = {
    Text = "Aliran Kepercayaan Jahat"
  },
  State_68623_Desc = {
    Text = "Setiap kali memainkan 1 Kartu perintah, buang 1 Kartu dengan konsumsi Aritmetika terendah dari Pembangun ini."
  },
  State_68623_Name = {
    Text = "Aliran Kegilaan"
  },
  State_68624_Desc = {
    Text = "Pada akhir giliran, pulihkan 10% dari kesehatan yang hilang, hilangkan kondisi negatif diri sendiri dan kondisi positif pemain"
  },
  State_68624_Name = {
    Text = "Arus Kehadiran"
  },
  State_68626_Desc = {
    Text = "Meningkatkan Aliemus dasar semua Pembangun sebesar 50%. Pada akhir setiap putaran, kurangi 10 poin Aliemus dari semua Pembangun dan pulihkan 3% Kesehatan maksimum diri sendiri."
  },
  State_68626_Name = {
    Text = "Aliran Ketakutan"
  },
  State_68627_Desc = {
    Text = "Pada saat pertempuran dimulai, dapatkan 15 lapisan \"Penghalang Sementara\". Pada akhir ronde, dapatkan 15 lapisan \"Penghalang Sementara\", dan tambahkan \"Pembubaran Sementara\" pada 10 kartu acak."
  },
  State_68627_Name = {
    Text = "Arus Menyegarkan"
  },
  State_68632_Desc = {
    Text = "Konsumsi aritmetika semua kartu instruksi meningkat 1. Setiap 3 giliran, pada akhir giliran, menempatkan 1 kartu “Batu yang perlahan mengeras” ke tangan"
  },
  State_68632_Name = {
    Text = "Aliran Ratapan"
  },
  State_68635_Name = {
    Text = "\"Inti Perak Murni· Ketakutan\""
  },
  State_68637_Desc = {
    Text = "Saat kehilangan hidup, kurangi jumlah lapisan yang sesuai. Saat jumlah lapisan menjadi 0, berikan pemain 2 lapis penghalang sementara, berikan diri sendiri [DescArg1] lapis perisai dan [DescArg2] lapis diperkuat sementara, serta dapatkan kembali [DescArg3] lapis penghalang dimensi."
  },
  State_68637_Name = {
    Text = "Hambatan Dimensi"
  },
  State_68638_Name = {
    Text = "\"Inti Perak Murni· Kepercayaan Sesat\""
  },
  State_68646_Desc = {
    Text = "Kerusakan dasar dan nilai Perisai meningkat 200%, tetapi akan Lelah setelah digunakan."
  },
  State_68646_Name = {
    Text = "<RedQuality1:SementaraLarut>"
  },
  State_68647_Name = {
    Text = "\"Inti Suara Murni·Kegilaan\""
  },
  State_68680_Desc = {
    Text = "Hapus Serpihan Kuno"
  },
  State_68680_Name = {
    Text = "Hapus Serpihan Kuno"
  },
  State_68704_Desc = {
    Text = "Jarak kedatangan Tuo Huwa Bo yang sebenarnya masih [DescArg1] putaran lagi..."
  },
  State_68704_Name = {Text = "Kedatangan"},
  State_68829_Desc = {
    Text = "Saat menerima Active DMG atau Kerusakan tentakel, Imun terhadap kerusakan dan kurangi 1 lapisan, dihapus saat giliran dimulai."
  },
  State_68829_Name = {
    Text = "<ParcloseColour: Penghalang Sementara>"
  },
  State_68829_WeaponDesc = {
    Text = "Kerusakan yang diterima berkurang 99%, setiap menerima 1 kali kerusakan kurangi 1 stack."
  },
  State_70026_Desc = {
    Text = "Kartu ini memiliki \"Penahanan\", setelah dimainkan tingkat kritis sementara semua Pembangun meningkat sebesar [StateArg1]% dan \"Dominasi Abadi\" dihapus. Jika alam saat ini adalah Aequor, setelah \"Dominasi Abadi\" dihapus, dapatkan 1 poin Aritmetika."
  },
  State_70026_Name = {
    Text = "<OrangeQuality:Penguasa Abadi>"
  },
  State_70031_Desc = {
    Text = "Satu-satunya Tim: Saat pertempuran dimulai, berikan efek \"Dominasi Abadi\" pada semua kartu perintah di tumpukan menggambar yang memiliki konsumsi aritmetika lebih besar atau sama dengan 3 kepada pemegangnya: Kartu ini memiliki \"Tahan\", setelah dimainkan tingkat kritis sementara semua Pembangun meningkat sebesar <WeaponEffect_Num:[StateArg1]%> dan \"Dominasi Abadi\" akan dihapus. Jika alam saat ini adalah Aequor, setelah \"Dominasi Abadi\" dihapus, dapatkan 1 poin aritmetika."
  },
  State_70031_WeaponDesc = {
    Text = "Pada awal pertempuran, berikan efek \"Dominasi Abadi\"kepada semua kartu perintah di tumpukan menggambar yang memiliki konsumsi aritmetika lebih besar atau sama dengan 3: Kartu ini memiliki \"Tahan\", setelah dimainkan tingkat kritis sementara semua Pembangun meningkat sebesar <WeaponEffect_Num:[StateArg1]%> dan \"Dominasi Abadi\"akan dihapus. Jika alam saat ini adalah Aequor, setelah \"Dominasi Abadi\"dihapus, dapatkan 1 poin aritmetika."
  },
  State_70182_Desc = {
    Text = "Semua perisai yang diperoleh berkurang sebesar [DescArg1]%."
  },
  State_70182_Name = {
    Text = "<FragileColour:Rapuh>"
  },
  State_70182_WeaponDesc = {
    Text = "Semua Perisai yang diperoleh berkurang sebesar 33%."
  },
  State_70277_Desc = {
    Text = "Setelah menerima Active DMG atau Kerusakan tentakel, [StateArg1]% kerusakan akan dikonversi menjadi pemulihan Crimson Furnace, berlangsung selama [Layer] giliran."
  },
  State_70277_Name = {
    Text = "Upacara penciptaan"
  },
  State_70287_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:Pada akhir giliran, meningkatkan kerusakan, penyembuhan, dan perisai yang dihasilkan oleh semua \"Keterampilan\" pemegang di tangan sebesar [StateArg1]%."
  },
  State_70287_Name = {
    Text = "Takhta Batu Biru"
  },
  State_70288_Desc = {
    Text = "Kerusakan, penyembuhan, dan perisai yang dihasilkan oleh kartu ini meningkat sebesar [DescArg1]%."
  },
  State_70288_Name = {
    Text = "Takhta Batu Biru"
  },
  State_70313_Desc = {
    Text = "Di pertarungan bos, pada awal giliran dan setelah \"Boneka Meleleh\" melepaskan Aliemus Muliakan, dapatkan 1 lapisan \"<Zhongmowuqiling:Akhir>\". \"Akhir\" dapat memiliki hingga 10 lapisan, dan ketika mencapai 10 lapisan, letakkan 1 kartu \"Ilusi Akhir\" ke tangan."
  },
  State_70313_Name = {
    Text = "Jalur Pemusnahan"
  },
  State_70318_Desc = {
    Text = "Berikan [StateArg1] giliran <VulnerabilityIconKeywords:Vulnerable> kepada semua musuh, dapatkan status \"Keseruan\" selama 1 giliran: DMG Amplification +[StateArg2]%."
  },
  State_70318_Name = {Text = "Keseruan"},
  State_70322_Desc = {
    Text = "Saat memiliki 10 lapisan Akhir, tempatkan 1 kartu \"Ilusi Akhir\" di tangan."
  },
  State_70322_Name = {Text = "Akhir"},
  State_70330_Desc = {
    Text = "Mendapatkan status \"Keseruan\" selama 1 giliran: DMG Amplification +[Arg2]%."
  },
  State_70330_Name = {Text = "Keseruan"},
  State_70346_Desc = {
    Text = "Terapkan [StateArg1] putaran <WeaknessIconKeywords:Kelemahan> pada semua musuh, dan kurangi [Exhaustion:StateArg3] poin <PowerIconKeywords:Kekuatan> mereka di putaran ini."
  },
  State_70346_Name = {Text = "kutukan"},
  State_70347_Desc = {
    Text = "Mengurangi [Exhaustion:StateArg3] poin <PowerIconKeywords:Kekuatan> untuk semua musuh di ronde ini."
  },
  State_70347_Name = {Text = "kutukan"},
  State_70374_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setiap giliran, saat pemakai menerima Serangan [StateArg1] kali pertama, memberikan <PVPEmptinessKeywords:Void> kepada penyerang."
  },
  State_70374_Name = {
    Text = "Boneka Kehampaan"
  },
  State_70379_Desc = {
    Text = "Memberikan <PVPEmptinessKeywords:Void> kepada penyerang. Menghapus status ini setelah menerima serangan."
  },
  State_70379_Name = {
    Text = "Counter Void"
  },
  State_70443_Desc = {
    Text = "Saat memiliki 10 lapisan Akhir, tempatkan 1 kartu \"Ilusi Akhir\" di tangan."
  },
  State_70443_Name = {Text = "Akhir"},
  State_70539_Name = {Text = "Wabah Jiwa"},
  State_70589_Desc = {
    Text = "Ketika memainkan 2 kartu berturut-turut dengan konsumsi aritmetika lebih rendah daripada kartu sebelumnya, berikan 40/80 Racun kepada semua musuh. Setiap ronde, efek ini dapat dipicu maksimal 5 kali."
  },
  State_70590_Desc = {
    Text = "Setelah menggunakan embrio untuk pertama kalinya di setiap putaran, kerusakan aktif di putaran ini akan menyebabkan 15/30% kerusakan dalam bentuk berdarah."
  },
  State_70593_Desc = {
    Text = "Setelah memainkan kartu perintah non-turunan, masukkan 1/2 salinan sementara dari kartu ini dengan pengurangan lelah aritmetika sebesar 2 ke dalam tumpukan menggambar, cooldown 3 ronde."
  },
  State_70594_Desc = {
    Text = "Pada akhir ronde, jika berada dalam postur Gelombang Pasang, dapatkan 32/64 Kerusakan Tentakel, dengan cooldown 3 ronde."
  },
  State_70595_Desc = {
    Text = "Pada awal pertempuran, semua musuh akan diberi 1280 Racun. Efeknya berlipat ganda dalam pertarungan bos."
  },
  State_70598_Desc = {
    Text = "Setiap kali sebuah Kartu memasuki ruang Ultra, jika pemilik Kartu ini berbeda dengan pemilik Kartu lain di ruang Ultra, maka tambahkan 1/2 Inspirasi ke tangan."
  },
  State_70600_Desc = {
    Text = "Pada akhir ronde, pulihkan 32 poin Hidup."
  },
  State_70600_Name = {
    Text = "Darah Anugerah"
  },
  State_70602_Desc = {
    Text = "Setelah Bangkit Kunci Perak, menarik 4 kartu."
  },
  State_70603_Desc = {
    Text = "Setelah menggunakan Kunci perak untuk Bangkit kunci perak, semua Pembangun mendapatkan 10 Aliemus."
  },
  State_70605_Desc = {
    Text = "Setelah Bangkit Kunci Perak, memperoleh 32 Kekuatan."
  },
  State_70607_Desc = {
    Text = "Ketika 2 kali berturut-turut memainkan kartu dengan konsumsi aritmetika lebih tinggi dari kartu sebelumnya, dapatkan 24/48 Counter, maksimal dipicu 5 kali per ronde."
  },
  State_70609_Desc = {
    Text = "Setelah Bangkit Kunci Perak, memperoleh 96 Perisai."
  },
  State_70609_Name = {
    Text = "Spesimen kupu-kupu"
  },
  State_70611_Desc = {
    Text = "Setelah menggunakan Bangkit kunci perak, kerusakan dasar yang diberikan oleh semua Pembangun meningkat sebesar 25%/50%."
  },
  State_70614_Name = {
    Text = "Rahang Laser+"
  },
  State_70617_Desc = {
    Text = "Kerusakan yang diberikan dalam lima serangan pertama setiap ronde meningkat sebesar 15%/30%."
  },
  State_70618_Desc = {
    Text = "Pada awal ronde, tarik 1 kartu."
  },
  State_70619_Desc = {
    Text = "\"Pukulan\"menyebabkan Racun sebesar 10%/20% dari Kerusakan, setiap putaran paling banyak menyebabkan 320/640 poin."
  },
  State_70620_Desc = {
    Text = "Saat diserang oleh musuh, musuh akan menerima 1 kali <FixedDamage:Kerusakan Murni> sebesar 25%/50% dari Max HP tim kita. Kerusakan ini mendapatkan Counter Buff sebesar 100%/200%. Setiap musuh paling banyak dapat memicu efek ini 1 kali per ronde."
  },
  State_70620_Name = {
    Text = "Pisau Ritual yang Terlupakan"
  },
  State_70621_Desc = {
    Text = "Setelah Bangkit Kunci Perak, memperoleh 192 Perisai."
  },
  State_70621_Name = {
    Text = "Spesimen Kupu-kupu+"
  },
  State_70623_Desc = {
    Text = "Pada awal setiap ronde, semua Pembangun mendapatkan 10 Aliemus."
  },
  State_70624_Desc = {
    Text = "Setelah menggunakan Bangkit kunci perak, semua Pembangun mendapatkan 20 Aliemus."
  },
  State_70628_Desc = {
    Text = "Pada awal ronde, tarik 2 kartu."
  },
  State_70629_Desc = {
    Text = "Pada kali pertama melahap di setiap putaran, Pembangun lain mendapatkan 10/20 Aliemus."
  },
  State_70635_Desc = {
    Text = "Setelah Bangkit Kunci Perak, memperoleh 416 Counter."
  },
  State_70636_Desc = {
    Text = "Mendapatkan 10%/20% dari jumlah kehilangan hidup sebagai Dapur Merah saat kehilangan kehidupan."
  },
  State_70637_Desc = {
    Text = "Pada awal pertempuran, batas Tentakel +1/2, dapatkan 1/2 Tentakel."
  },
  State_70641_Desc = {
    Text = "Penghancuran mendapatkan 160/320 Perisai, dengan 3 putaran cooldown."
  },
  State_70641_Name = {
    Text = "Jam Tangan Hiperseni"
  },
  State_70643_Desc = {
    Text = "Pada awal giliran, dapatkan 1 Aritmetika."
  },
  State_70644_Desc = {
    Text = "Setelah melepaskan Muliakan, dapatkan 16/32 Kekuatan sementara."
  },
  State_70645_Desc = {
    Text = "Pada awal giliran, dapatkan 2 Aritmetika."
  },
  State_70646_Name = {
    Text = "Pisau Ritual yang Terlupakan+"
  },
  State_70647_Desc = {
    Text = "Semua kerusakan dasar yang ditimbulkan oleh Pembangun meningkat sebesar 30%."
  },
  State_70648_Desc = {
    Text = "Pada awal pertempuran, terapkan 640 Racun kepada semua musuh, efeknya berlipat ganda dalam pertarungan bos."
  },
  State_70656_Desc = {
    Text = "\"Pukulan\"memberikan kerusakan tambahan sebesar 1/2 kali 60% daya serang Pembangun, dan dapat dipicu hingga 3 kali per ronde."
  },
  State_70657_Desc = {
    Text = "Mendapatkan 32 Kekuatan saat pertempuran dimulai."
  },
  State_70660_Desc = {
    Text = "Mendapatkan 64 Kekuatan saat pertempuran dimulai."
  },
  State_70661_Desc = {
    Text = "Pada akhir ronde, pulihkan 64 poin Hidup."
  },
  State_70661_Name = {
    Text = "Darah Anugerah+"
  },
  State_70662_Desc = {
    Text = "Setelah Bangkit Kunci Perak, memperoleh 2 Aritmetika."
  },
  State_70664_Desc = {
    Text = "Setelah Bangkit Kunci Perak, memperoleh 16 Kekuatan."
  },
  State_70666_Desc = {
    Text = "Setelah pertempuran dimulai, dapatkan 100/200 penguasaan alam. Kerusakan dasar Racun yang diberikan oleh semua Pembangun dan Racun yang diberikan oleh Relik meningkat sebesar 10%/20%."
  },
  State_70667_Desc = {
    Text = "Setelah Bangkit Kunci Perak, memperoleh 4 Aritmetika."
  },
  State_70670_Desc = {
    Text = "Pada awal Pertempuran, dapatkan 320 Counter, Efek dalam pertempuran bos dilipatgandakan."
  },
  State_70671_Desc = {
    Text = "Setelah memasuki ronde Ultra, Kartu perintah non-turunan pertama yang dimainkan akan memiliki efek tambahan sebanyak 1/2 kali."
  },
  State_70678_Desc = {
    Text = "Pada awal Pertempuran, dapatkan 640 Counter, efek dalam pertempuran bos dilipatgandakan."
  },
  State_70681_Desc = {
    Text = "Semua kerusakan dasar yang diberikan oleh Pembangun meningkat sebesar 60%."
  },
  State_70682_Desc = {
    Text = "Ketika jumlah kartu di tangan kurang dari atau sama dengan 2, tarik 1/2 kartu. Setiap putaran, kemampuan ini dapat dipicu maksimal 2 kali."
  },
  State_70683_Desc = {
    Text = "Anihilasi membuat Pembangun dengan Aliemus terendah mendapatkan 50/100 Aliemus, cooldown 3 ronde."
  },
  State_70684_Desc = {
    Text = "Pada awal ronde, jika hidup di bawah 25%, dapatkan 72/144 kekuatan sementara."
  },
  State_70685_Desc = {
    Text = "Setelah Bangkit Kunci Perak, berikan 416 racun kepada semua musuh."
  },
  State_70686_Desc = {
    Text = "Setelah melepaskan Exalt, membuat semua musuh menerima 1 kali <FixedDamage:Kerusakan Murni> sebesar 15%/30% dari Max HP pihak kita, dan memicu Racun 10%/20%."
  },
  State_70687_Name = {
    Text = "Arloji Saku Transenden+"
  },
  State_70689_Desc = {
    Text = "Setelah Bangkit Kunci Perak, berikan 832 racun kepada semua musuh."
  },
  State_70690_Desc = {
    Text = "Setelah pertempuran dimulai, dapatkan 100/200 penguasaan alam. Semua serangan dasar Pembangun dan Counter yang diberikan oleh Relik meningkat sebesar 10%/20%."
  },
  State_70691_Desc = {
    Text = "Setiap kali memberikan kerusakan, dapatkan 4/8 kekuatan sementara. Maksimal terpicu 15 kali per ronde."
  },
  State_70693_Desc = {
    Text = "Jumlah perolehan otomatis Fusi Embrio meningkat sebesar 100%/200%."
  },
  State_70694_Desc = {
    Text = "Setelah Bangkit Kunci Perak, menarik 2 kartu."
  },
  State_70695_Desc = {
    Text = "Pada awal setiap putaran, semua Pembangun mendapatkan 5 Aliemus."
  },
  State_70696_Desc = {
    Text = "Setelah Bangkit Kunci Perak, memperoleh 208 Counter."
  },
  State_70698_Desc = {
    Text = "Pertahanan memperoleh 200/400 Counter sementara, maksimal terpicu 3 kali per ronde."
  },
  State_70804_Name = {
    Text = "Batas Waktu Hidup atau Mati"
  },
  State_70805_Desc = {
    Text = "Setelah pertempuran dimulai, terapkan 1/2 tingkat Kelemahan pada semua musuh, efeknya berlipat ganda pada bos. Kerusakan dasar yang diberikan oleh semua Pembangun meningkat sebesar 15%/30%."
  },
  State_70806_Name = {
    Text = "Tangan Pelindung+"
  },
  State_70808_Desc = {
    Text = "Menggunakan posisi Laut Tenang untuk memberikan 64/128 kelelahan kepada semua musuh, dengan waktu cooldown 3 ronde."
  },
  State_70809_Desc = {
    Text = "Pada awal ronde, jika darah di bawah 25%, dapatkan perisai sebesar 100/200."
  },
  State_70809_Name = {
    Text = "Tangan Pelindung"
  },
  State_70810_Desc = {
    Text = "Menggunakan postur Gelombang Amarah untuk segera memicu semua Tentakel melakukan Serangan terhadap musuh 1/2 kali, dengan waktu pendinginan selama 3 putaran."
  },
  State_70812_Desc = {
    Text = "Setelah pertempuran dimulai, semua musuh menerima 1/2 tingkat rentan, efek terhadap bos dilipatgandakan. Kerusakan dasar yang diberikan oleh semua Pembangun meningkat sebesar 15%/30%."
  },
  State_70832_Desc = {
    Text = "Satu-satunya Tim: Saat pertempuran dimulai, pemakai mendapatkan Aliemus sebesar <WeaponEffect_Num:[StateArg1]%> dari pemulihan Aliemus pemakai. Setelah pemakai melepaskan Muliakan untuk pertama kalinya dalam setiap pertempuran, efek ini diulang sekali."
  },
  State_70832_WeaponDesc = {
    Text = "Pada awal Pertempuran, pemakai mendapatkan Aliemus yang setara dengan <WeaponEffect_Num:[StateArg1]%> dari pengisian ulang Aliemus pemakai (<WeaponEffect_Num:[DescArg1]>). Setelah pemakai melepaskan Muliakan untuk pertama kalinya dalam setiap Pertempuran, Efek ini diulang sekali."
  },
  State_70835_Desc = {
    Text = "Satu-satunya di tim: Peningkatan Aliemus, Racun, dan pemulihan Hidup yang diberikan oleh pemakai sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah pemakai melepaskan Muliakan, mereka akan memperoleh Aliemus sebesar <WeaponEffect_Num:[StateArg2]%> dari Lelah Aliemus kali ini."
  },
  State_70835_WeaponDesc = {
    Text = "Pengguna yang dilengkapi meningkatkan Aliemus, Racun, dan pemulihan Hidup sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah pengguna yang dilengkapi melepaskan Muliakan, mereka mendapatkan Aliemus yang setara dengan <WeaponEffect_Num:[StateArg2]%> dari Lelah Aliemus tersebut."
  },
  State_70989_Desc = {
    Text = "Setelah melepaskan 4 kali Muliakan dalam satu ronde, dapatkan 3/6 Aritmetika, dengan 3 ronde waktu pendinginan."
  },
  State_71001_Desc = {
    Text = "Setelah memainkan 4 Kartu perintah yang berasal dari Pembangun berbeda dalam satu ronde, semua Pembangun mendapatkan 20/40 Aliemus, dengan cooldown 3 ronde."
  },
  State_71153_Desc = {
    Text = "Pada awal giliran, Caecus mendapatkan 15 Aliemus. Ketika Caecus mendapatkan Perisai, ia memulihkan 50% dari jumlah Perisai sebagai Hidup."
  },
  State_71154_Desc = {
    Text = "Pada awal ronde, Aigis mendapatkan 15 Aliemus. Ketika Aigis memberikan kerusakan kepada musuh yang memiliki status Rentan, dia juga akan mencuri 10 Kekuatan sementara dari musuh tersebut, dengan batas maksimal 5 kali per ronde."
  },
  State_71155_Desc = {
    Text = "Pada awal giliran, Leigh mendapatkan 15 Aliemus. Setiap kali kehilangan Hidup, dia memperoleh 8 poin Kekuatan, hingga maksimal 10 kali per Pertempuran. Setelah bertumpuk 10 kali, konsumsi Aritmetika untuk \"Penderitaan dan Kesenangan\" menjadi 1, dan jumlah Kerusakan meningkat sebanyak 1."
  },
  State_71156_Desc = {
    Text = "Pada awal ronde, Agrippa mendapatkan 15 Aliemus. \"Pemberian yang Tidak Sabar\"juga akan mengurangi Lelah Aritmetika Agrippa sebesar 1 dalam ronde ini, dan efek ini hanya dapat diaktifkan sekali per ronde."
  },
  State_71157_Desc = {
    Text = "Pada awal ronde, Sanga mendapatkan 15 Aliemus. Pada awal pertempuran, semua Kartu perintah Sanga diberikan status Disimpan, Dipersiapkan 1, dan mendapatkan 24 poin Perisai."
  },
  State_71157_Name = {
    Text = "Dimensi·Sanga"
  },
  State_71158_Desc = {
    Text = "Pada awal giliran, Doll mendapatkan 15 poin Aliemus. Setelah pertarungan dimulai, ubah konsumsi aritmetika dari \"Timbal balik\" Doll menjadi 0, lalu setelah itu extra ambil 2 kartu di putaran berikutnya."
  },
  State_71159_Desc = {
    Text = "Pada awal giliran, Faros mendapatkan 15 Aliemus. Setiap kali memberikan 1 Kerusakan Tentakel, tingkat Racun yang diberikan Faros dalam pertempuran ini meningkat sebesar 1%, dengan maksimum 100%."
  },
  State_71160_Desc = {
    Text = "Pada awal ronde, \"24\"memperoleh 15 Aliemus. Pada awal ronde, jika \"24\"berada dalam \"Kepribadian Depresi\", maka akan memperoleh tambahan 25 Aliemus; jika berada dalam \"Kepribadian Manik\", maka tingkat kritis sementara dan kerusakan kritis sementara \"24\"akan meningkat sebesar 35%."
  },
  State_71161_Desc = {
    Text = "Pada awal giliran, Pingsan mendapatkan 15 Aliemus. Setiap kali Ketahanan terpicu, itu akan meningkatkan Perisai, Counter, dan pemulihan Hidup yang diberikan oleh Pingsan dalam eksplorasi ini sebesar 20%, hingga maksimal 5 kali."
  },
  State_71162_Desc = {
    Text = "Pada awal ronde, Goliath mendapatkan 15 Aliemus. Jika Goliath memberikan 3 kali Kerusakan dalam 1 ronde, Kerusakan yang diberikan Goliath dalam Pertempuran ini akan mendapatkan tambahan 1 kali Kekuatan, dengan cooldown 3 ronde."
  },
  State_71163_Desc = {
    Text = "Pada awal giliran, Helot-catena mendapatkan 15 Aliemus. Kerusakan aktif Helot-catena memberikan tambahan 20% Berdarah, dan setelah membunuh musuh, itu akan menyebabkan Berdarah pada musuh lainnya yang setara dengan kerusakan berlebih."
  },
  State_71164_Desc = {
    Text = "Pada awal ronde, Aurita mendapatkan 15 Aliemus. Jumlah kerusakan \"Pemisahan Kelenjar\" meningkat 1 kali. Setelah memainkan \"Pertahanan\" Aurita, letakkan 1 kartu \"Pemisahan Kelenjar\" ke tangan."
  },
  State_71166_Desc = {
    Text = "Pada awal giliran, Lily mendapatkan 15 Aliemus. Batas maksimal Bertahan Lily meningkat sebesar 100%. Saat melepaskan \"Bunga di atas lendir\" atau \"Serangan untuk melindungi\", pulihkan hidup sebesar 8% dari jumlah lapisan \"Bertahan\"."
  },
  State_71167_Desc = {
    Text = "Pada awal ronde, Lotan mendapatkan 15 Aliemus. Setelah menggunakan \"Pertahanan\" pertama Lotan di setiap ronde, tambahkan 2 kartu \"Pedang Pemberontak\" dengan Lelah dan Ilusi tambahan ke tangan."
  },
  State_71168_Desc = {
    Text = "Pada awal ronde, Pandia mendapatkan 15 Aliemus. Pada awal ronde, Pandia mendapatkan 64 poin Counter. Setiap 4 poin Counter non-sementara meningkatkan kerusakan yang ditimbulkan oleh kartu perintah \"Pandia\" sebesar 1."
  },
  State_71169_Desc = {
    Text = "Pada awal ronde, Helot memperoleh 15 Aliemus. Setiap kali 1 kartu dibuang, \"Helot\"akan memperoleh 5 Aliemus."
  },
  State_71170_Desc = {
    Text = "Pada awal ronde, Tawil mendapatkan 15 Aliemus. Jika dalam satu ronde dimainkan 6 Kartu perintah Tawil, tempatkan 1 \"Kunci Perak Cahaya Fajar\" di tangan, dengan cooldown 3 ronde."
  },
  State_71171_Desc = {
    Text = "Pada awal ronde, Miryam mendapatkan 15 Aliemus dan menaruh 1 kartu \"Ritual Suci\" ke dalam tangan."
  },
  State_71172_Desc = {
    Text = "Pada awal giliran, Boneka·Aliemus mendapatkan 15 Aliemus. Setelah Boneka Aliemus melepaskan Muliakan, setiap 20 poin Aliemus yang dilelahkan, Pembangun lainnya akan mendapatkan 1 poin Aliemus."
  },
  State_71173_Desc = {
    Text = "Pada awal giliran, Salvador mendapatkan 15 poin Aliemus. Setiap kali mengumpulkan Dapur Merah, ia juga akan mendapatkan 5% dari jumlah yang terkumpul sebagai Kekuatan. \"Serangan\" dan \"Akhir penderitaan\" Salvador menikmati penambahan Kekuatan 1 kali ekstra."
  },
  State_71175_Desc = {
    Text = "Pada awal ronde, Nodila mendapatkan 15 Aliemus. Setelah melepaskan \"Muliakan\" Nodila, ia akan memperoleh Counter setara dengan 50% Perisai saat ini, dan dapat dipicu maksimal 1 kali per ronde."
  },
  State_71177_Desc = {
    Text = "Pada awal giliran, Liz mendapatkan 15 Aliemus. Kartu yang dibuang oleh \"Tarian kehancuran\"akan berlaku tambahan 1 kali, dengan cooldown selama 3 giliran."
  },
  State_71178_Desc = {
    Text = "Pada awal giliran, Ramona mendapatkan 15 Aliemus. Setiap kali Kartu perintah ketiga Ramona dimainkan, kartu perintah tersebut berlaku tambahan satu kali."
  },
  State_71179_Desc = {
    Text = "Di awal giliran, Uvhash mendapat 15 Aliemus. Pengeluaran Aliemus Uvhash berkurang 10 poin, setiap kali melepaskan Muliakan, pengeluaran Aliemus berkurang tambahan 5 poin, dan dapat melepaskan Muliakan sebanyak 2 kali per giliran."
  },
  State_71180_Desc = {
    Text = "Pada awal ronde, Alva mendapatkan 15 Aliemus. Jika Alva memainkan 2 kartu \"Pertahanan\" pada ronde sebelumnya, letakkan kartu \"Mata Pisau Intuisi\" yang ter-Lelah ke tangan; jika memainkan 2 kartu \"Serangan\", letakkan 1 kartu \"Postur Siaga\" yang ter-Lelah ke tangan."
  },
  State_71181_Desc = {
    Text = "Pada awal giliran, Sorel mendapatkan 15 Aliemus. Setiap kali Sorel memberikan 1 Kerusakan, Fusi Embrio meningkat sebesar 10, dengan maksimal 10 kali per giliran. Setelah efek ini berlaku 10 kali, Crit. DMG Sorel di pertempuran ini meningkat sebesar 20%."
  },
  State_71182_Desc = {
    Text = "Pada awal giliran, Hameln mendapatkan 15 Aliemus. Konsumsi Aritmetika \"Prelude Jiwa\" berkurang 1, dan jumlah kerusakan dasar meningkat sebanyak 1."
  },
  State_71183_Desc = {
    Text = "Di awal giliran, Thais mendapat 15 Aliemus. Thais mendapatkan 1 “Anak Suci” dan 72 poin kekuatan sementara setelah mengeluarkan 2 kartu perintah dalam 1 giliran, dengan cooldown 3 giliran."
  },
  State_71187_Desc = {
    Text = "Pada awal giliran, Celeste mendapatkan 15 Aliemus. Sebelum giliran berakhir, setiap 1 Kartu perintah Celeste di tangan akan membuat 1 Tentakel menyerang musuh dan memulihkan 8 poin Hidup."
  },
  State_71188_Desc = {
    Text = "Pada awal giliran, Murphy mendapatkan 15 Aliemus. \"Serangan\" dan \"Pertahanan\" Murphy dapat mengubah 25% dari \"Pengorbanan\" menjadi kerusakan tentakel sementara, tetapi efek ini hanya berlaku sekali per giliran."
  },
  State_71189_Desc = {
    Text = "Pada awal giliran, Nymphaea mendapatkan 15 Aliemus. Setelah memainkan \"Serangan\" Nymphaea, keracunan yang ditimbulkan oleh \"Nymphaea\" dalam pertempuran ini meningkat sebesar 20%. Setelah memainkan \"Pertahanan\" Nymphaea, semua musuh akan terkena efek Racun sebesar 50%. Setiap efek ini hanya dapat diaktifkan sekali per giliran."
  },
  State_71190_Desc = {
    Text = "Di awal giliran, Ogier mendapatkan 15 Kekuatan. Setiap kali orang pertama kali memainkan \"Senjata Tusuk\" atau \"Serangan\" milik Ogier dalam satu giliran, meningkatkan Perisai dan Kekuatan yang dihasilkan oleh Ogier di giliran ini sebesar 50%."
  },
  State_71191_Desc = {
    Text = "Pada awal giliran, Ryker mendapatkan 15 Aliemus. Hasil dadu pertama setiap giliran selalu 6."
  },
  State_71192_Desc = {
    Text = "Pada awal giliran, Ramona-loop mendapatkan 15 Aliemus. Saat \"Loop\"dipicu untuk pertama kalinya setiap giliran, dapatkan 500 poin Energi-s dan 1 lapisan \"Negentropy\"."
  },
  State_71193_Desc = {
    Text = "Pada awal giliran, Tulu mendapatkan 15 Aliemus. Konsumsi Lelah Tulu berkurang sebesar 10 poin, dan setelah melepaskan Muliakan, 2 Tentakel sementara akan segera terbentuk."
  },
  State_71194_Desc = {
    Text = "Pada awal ronde, Karen mendapatkan 15 Aliemus. Mengeluarkan \"Diam Menunggu\" akan mengembalikan dua kali lipat Aritmetika yang Lelah, dengan cooldown 3 ronde."
  },
  State_71271_Desc = {
    Text = "Pada awal giliran, Horla mendapatkan 15 Aliemus. Saat pertarungan dimulai, semua metafora emosi akan mendapatkan 1 lapisan masing-masing. Efek \"metafora\" meningkat 50%."
  },
  State_71272_Desc = {
    Text = "Pada awal giliran, Jenkin mendapatkan 15 Aliemus, kerusakan akhir +5%. Pertumbuhan dasar kerusakan dan kerusakan yang diberikan oleh \"Brown Bergerak\" meningkat sebesar 200%."
  },
  State_71273_Desc = {
    Text = "Pada awal ronde, Narsis mendapatkan 15 Aliemus dan 1 \"Inspirasi\". Setiap kali \"Pasang Surut Heterogen\" dimainkan, kekuatan yang diperolehnya akan meningkat secara permanen sebesar 25% dalam eksplorasi ini, dengan maksimum hingga 300%."
  },
  State_71274_Desc = {
    Text = "Pada awal giliran, Tinct mendapatkan 15 Aliemus. Setelah Kartu perintah Tinct memicu Lompatan, kartu tersebut akan dikembalikan ke tangan, dan efek ini dapat bekerja hingga 3 kali per giliran."
  },
  State_71275_Desc = {
    Text = "Pada awal ronde, Wanda mendapatkan 15 Aliemus dan memperoleh 1 lapisan \"Pengaruh Mimpi\". Jika saat ini adalah ronde Ultra, tambahkan 1 kartu sementara \"Rantai Jarum Tulang Belakang\" dan \"Penjaga yang Tersesat\" ke tangan."
  },
  State_71276_Desc = {
    Text = "Pada awal ronde, Erica mendapatkan 15 Aliemus. Setelah Erica memainkan 3 Kartu perintah dalam 1 ronde, ia mendapatkan 1 \"Inspirasi\" dan meningkatkan bonus Kekuatan serta Waspada untuk \"Ledakan Elektromagnetik\" sebesar dua kali lipat selama pertempuran ini."
  },
  State_71277_Desc = {
    Text = "Pada awal ronde, Casiah mendapatkan 15 Aliemus. Setiap kali mengambil 1 kartu, Casiah mendapatkan 1 Aliemus. Saat Casiah melepaskan Muliakan, semua musuh kehilangan 32 Kekuatan."
  },
  State_71278_Desc = {
    Text = "Pada awal ronde, Kerang mendapatkan 15 Aliemus. Setiap kali Pembangun lain melepaskan Muliakan, Kerang akan mendapatkan 5 Aliemus dan mengurangi konsumsi Aritmetika dari kartu \"Rekonstruksi psiko\" di tangan sebesar 1."
  },
  State_71279_Desc = {
    Text = "DMG Amplification +[StateArg1]%, Berkelanjutan selama [Layer] giliran."
  },
  State_71279_Name = {Text = "Keseruan"},
  State_71503_Name = {
    Text = "\"Bentuk Akhir\": Tarik 3 kartu tambahan, dapatkan 3 poin Aritmetika, aktifkan [DescArg1]% <IntoxicationIconKeywords:Racun> pada semua musuh, batas maksimum Aliemus \"Boneka·Dor\" meningkat sebesar 50 poin, hingga maksimal 3 kali."
  },
  State_71581_Name = {
    Text = "Soulforge Aptitude"
  },
  State_71589_Name = {
    Text = "Memicu 1 Tentakel untuk melakukan Serangan terhadap musuh dan memulihkan 8."
  },
  State_71605_Name = {
    Text = "Mendapatkan [StateArg1] poin Perisai"
  },
  State_71650_Desc = {
    Text = "Setelah mati, bangkit kembali dan memanggil berbagai jumlah dua. Namun, setelah bangkit, ia tidak mendapatkan penguatan dan imunitas. Masih dapat berlaku hingga [Layer] kali."
  },
  State_71650_Name = {
    Text = "Beast of Myriad Dimensions"
  },
  State_71651_Desc = {
    Text = "Setiap kali kehilangan hidup, kehilangan [StateArg1] poin kekuatan sementara. Masih bisa aktif sebanyak [Layer] kali, jumlah pengaktifan direset setiap putaran."
  },
  State_71651_Name = {
    Text = "Topi Gentleman"
  },
  State_71707_Desc = {
    Text = "Setiap menerima 1 kali Active DMG, memulihkan [StateArg1] poin HP, berlangsung selama [Layer] giliran."
  },
  State_71707_Name = {
    Text = "Caecus·Support"
  },
  State_71708_Desc = {
    Text = "Pada akhir ronde, untuk setiap 1 Kartu di tangan, semua Pembangun mendapatkan [DescArg1] poin Aliemus."
  },
  State_71708_Name = {
    Text = "Kasya·Dukungan"
  },
  State_71709_Desc = {
    Text = "Pada akhir ronde, dapatkan 35 poin Aliemus, berlangsung selama [Layer] ronde."
  },
  State_71709_Name = {
    Text = "Kerang·Dukungan"
  },
  State_71711_Desc = {
    Text = "Kerusakan yang diberikan oleh Bangun meningkat sebesar 25%, berlangsung selama [Layer] putaran."
  },
  State_71711_Name = {
    Text = "Jenkin·Support"
  },
  State_71712_Desc = {
    Text = "Saat menimbulkan Active DMG, 1 tentakel menyerang 1 kali, berlangsung selama [Layer] giliran."
  },
  State_71712_Name = {
    Text = "Aurita·Support"
  },
  State_71712_WeaponDesc = {
    Text = "Ketika Haiyue menyebabkan kerusakan, [StateArg1] tentakel akan melakukan serangan terhadap target tersebut."
  },
  State_71713_Desc = {
    Text = "Setiap kali melakukan \"Melahap\", akan menarik 2 kartu \"Pukulan\" dan mengurangi konsumsi Aritmetika mereka sebesar 1, berlangsung selama [Layer] putaran."
  },
  State_71713_Name = {
    Text = "Helot·Support"
  },
  State_71740_Desc = {
    Text = "Pada awal ronde berikutnya, dapatkan [Layer] poin Perisai."
  },
  State_71740_Name = {
    Text = "Leigh Dukungan Perisai"
  },
  State_71741_Desc = {
    Text = "Pada awal ronde berikutnya, dapatkan perisai yang setara dengan jumlah hidup yang hilang di ronde ini, bertahan selama [Layer] ronde."
  },
  State_71741_Name = {
    Text = "Leigh·Support"
  },
  State_71741_WeaponDesc = {
    Text = "Pada ronde berikutnya, dapatkan perisai sejumlah kehilangan hidup dari ronde sebelumnya."
  },
  State_71742_Desc = {
    Text = "Kerusakan kartu serangan meningkat sebesar [Layer]％."
  },
  State_71742_Name = {
    Text = "Helot·Support"
  },
  State_71742_WeaponDesc = {
    Text = "Pada giliran ini, kerusakan kartu seranganmu meningkat sebesar [Layer]%."
  },
  State_71837_Desc = {
    Text = "Pada awal giliran berikutnya, dapatkan status Rentan."
  },
  State_71837_Name = {
    Text = "Penundaan Kerentanan"
  },
  State_71839_Desc = {
    Text = "Menggunakan \"Bangun\", dapatkan [Layer] poin Aritmetika. Jika Alam saat ini adalah \"Aequor\", hasilkan tambahan [Layer] Tentakel sementara."
  },
  State_71839_Name = {
    Text = "Perlindungan Bintang"
  },
  State_71856_Desc = {
    Text = "Setiap kali kehilangan hidup, kehilangan [StateArg1] poin kekuatan sementara. Masih bisa aktif sebanyak [Layer] kali, jumlah pengaktifan direset setiap putaran."
  },
  State_71856_Name = {
    Text = "Topi Gentleman"
  },
  State_72016_Name = {
    Text = "Penguasaan Daging & Darah"
  },
  State_72018_WeaponDesc = {
    Text = "Setiap kali menerima 1 Kerusakan, semua Pembangun mendapatkan 1 poin Aliemus."
  },
  State_72033_Name = {Text = "Tentacle"},
  State_72036_Name = {
    Text = "Inisialisasi Profesi Kekacauan"
  },
  State_72079_Name = {
    Text = "Ombak Bergelora"
  },
  State_72102_Desc = {
    Text = "Pengalaman bermain klasik dari \"Forget Before the Night\"."
  },
  State_72102_Name = {
    Text = "Bab Lupakan"
  },
  State_72137_Name = {
    Text = "Aritmetika penuh"
  },
  State_72206_Name = {
    Text = "Kemajuan Penelitian \"[DescArg1] / 15\""
  },
  State_72208_Name = {
    Text = "Kemajuan Penelitian\"[DescArg1] / 2\""
  },
  State_72212_Name = {
    Text = "Kemajuan Penelitian \"[DescArg1] / 10\""
  },
  State_72213_Name = {
    Text = "Kemajuan Penelitian \"[DescArg1] / 30\""
  },
  State_72220_Name = {
    Text = "Kemajuan Penelitian \"[DescArg1] / 5\""
  },
  State_73518_Desc = {
    Text = "Kerusakan yang diberikan meningkat sebesar 100%, setelah kehilangan hidup, status ini akan hilang, tetapi mendapatkan perisai sebesar 50% dari kesehatan maksimum."
  },
  State_73518_Name = {
    Text = "\"Pembunuh Bayaran\""
  },
  State_73520_Desc = {
    Text = "Saat mati, pertahankan 1 poin Hidup dan kebal terhadap semua Kerusakan, mengubah Niat menjadi \"Pemutusan Tautan\"."
  },
  State_73520_Name = {
    Text = "\"Penghubung\""
  },
  State_73533_Desc = {
    Text = "Setelah giliran pemain berakhir, kartu tidak dibuang lagi. Saat pertempuran dimulai, ubah batas maksimum kartu pemain menjadi 8."
  },
  State_73533_Name = {
    Text = "Rasa Sarang"
  },
  State_73535_Desc = {
    Text = "Di dalam giliran sendiri, kerusakan yang diterima berkurang 75%. Saat kekuatan dikurangi, hanya akan mengurangi 50% lapisan kekuatan."
  },
  State_73535_Name = {
    Text = "Perlindungan Diri"
  },
  State_73566_Desc = {
    Text = "Setiap kali kamu memainkan 1 kartu non-kartu perintah, dapatkan [Power:StateArg1] poin <PowerIconKeywords:Kekuatan> dan <Block:[Block:StateArg2]> poin perisai."
  },
  State_73566_Name = {
    Text = "Komunikator"
  },
  State_73567_Desc = {
    Text = "Setiap kali kamu memainkan 1 kartu non-kartu perintah, dapatkan [Power:StateArg1] poin <PowerIconKeywords:Kekuatan> dan <Block:[Block:StateArg2]> poin perisai."
  },
  State_73567_Name = {
    Text = "Komunikator"
  },
  State_73570_Desc = {
    Text = "Setiap kali kamu memainkan 1 kartu non-kartu perintah, dapatkan [Power:StateArg1] poin <PowerIconKeywords:Kekuatan> dan <Block:[Block:StateArg2]> poin perisai."
  },
  State_73570_Name = {
    Text = "Komunikator"
  },
  State_73573_Desc = {
    Text = "Setiap kali kamu memainkan 1 kartu non-kartu perintah, dapatkan [Power:StateArg1] poin <PowerIconKeywords:Kekuatan> dan <Block:[Block:StateArg2]> poin perisai."
  },
  State_73573_Name = {
    Text = "Komunikator"
  },
  State_73649_Desc = {
    Text = "Kerusakan tim meningkat secara kuat sebesar [Layer]％."
  },
  State_73649_Name = {
    Text = "Boneka Kehampaan"
  },
  State_73655_Name = {
    Text = "Identitas Bentuk Organik"
  },
  State_73664_Name = {
    Text = "Efek Bentuk Organik untuk Aksesori"
  },
  State_73664_WeaponDesc = {
    Text = "Setelah pemakai menggunakan Muliakan, efek Kuat dari Perisai dan Sembuh mereka akan dilipatgandakan dalam ronde ini."
  },
  State_74012_Desc = {
    Text = "Menyebabkan [StateArg1]% dari Max HP semua musuh sebagai <FixedDamage:Kerusakan Murni>(minimum [DescArg1]). Setelah digunakan, keterampilan spesifik \"Melt · Boneka\" akan berubah menjadi \"Bentuk Akhir\"."
  },
  State_74012_Name = {
    Text = "Akhir Ilusi"
  },
  State_74013_Desc = {
    Text = "Menyebabkan [StateArg1]% dari Max HP semua musuh sebagai <FixedDamage:Kerusakan Murni>, dan kerusakan tersebut tidak akan kurang dari 500% dari Max HP pengguna. Setelah digunakan, keterampilan spesifik \"Melt · Boneka\" akan berubah menjadi \"Bentuk Akhir\"."
  },
  State_74013_Name = {
    Text = "Akhir Ilusi"
  },
  State_74014_Desc = {
    Text = "Menyebabkan [StateArg1]% dari Max HP semua musuh sebagai <FixedDamage:Kerusakan Murni>(kerusakan ini tidak akan kurang dari 500% dari Max HP pengguna), memulihkan 30% dari nyawa yang hilang, dan setelah digunakan, keterampilan spesifik \"Melt · Boneka\" berubah menjadi \"Bentuk Akhir\"."
  },
  State_74014_Name = {
    Text = "Akhir Ilusi"
  },
  State_74015_Desc = {
    Text = "Menyebabkan [StateArg1]% dari Max HP semua musuh sebagai <FixedDamage:Kerusakan Murni>(minimum [DescArg1]), memulihkan <Heal:[Heal:DescArg2]> poin HP, dan setelah digunakan, keterampilan tertentu \"Melt · Boneka\" berubah menjadi \"Bentuk Akhir\"."
  },
  State_74015_Name = {
    Text = "Akhir Ilusi"
  },
  State_74019_Desc = {
    Text = "Semua kerusakan dasar, Counter, dan Racun yang diberikan oleh Pembangun meningkat sebesar [Layer]％."
  },
  State_74019_Name = {
    Text = "Infeksi Kegilaan"
  },
  State_74142_Desc = {
    Text = "Setelah eksplorasi dimulai, stamina, Serangan, dan Pertahanan meningkat sebesar [StateArg1]%"
  },
  State_74142_Name = {
    Text = "Soulforge Aptitude"
  },
  State_74219_Name = {
    Text = "Setelah digunakan, kembalikan ke tangan."
  },
  State_74273_Desc = {
    Text = "Ketika Helot-catena memberikan kerusakan aktif, tambahkan [StateArg1]% berdarah, berlangsung selama [Layer] putaran."
  },
  State_74273_Name = {
    Text = "Rantai Pengikat"
  },
  State_74771_Desc = {
    Text = "Jumlah Aliemus yang diperlukan untuk melepaskan 1 kali Muliakan."
  },
  State_74771_Name = {
    Text = "Batas Aliemus"
  },
  State_74788_Desc = {
    Text = "\n·Ada paradoks: Pada awal eksplorasi, 75% Ketahanan terhadap kematian dikonversi menjadi bonus kesehatan maksimum, hingga maksimum 300% Ketahanan terhadap kematian, meningkatkan maksimum 10% kesehatan. Setiap kali Ketahanan terhadap kematian dipicu, satu kartu \"Silver Key Gleam\" ditambahkan ke tangan. \n·Luka tanpa dasar: Dalam Pertarungan Pemimpin, setiap kali jumlah pemulihan kesehatan yang diterima tim mencapai 100% dari batas kesehatan, efek pemulihan kesehatan yang diterima berikutnya berkurang 25%, tetapi meningkatkan total Ketahanan terhadap kematian saat ini sebesar 25%, maksimal dipicu 3 kali. \n·Lensa Prismatis: Pada awal putaran, jika Counter melebihi 750% dari kesehatan maksimum, jumlah yang melebihi akan dikurangi setengah, dan Counter permanen dapat ditumpuk hingga maksimum 2250% dari kesehatan maksimum; jika musuh diracuni melebihi 1000% dari kesehatan maksimum, jumlah yang melebihi akan dikurangi setengah, dan racun dapat ditumpuk hingga maksimum 3000% dari kesehatan maksimum. Awakener yang diperoleh berdasarkan jumlah penguatan kerusakan yang didapat dari Counter berkurang 70%, tetapi semua racun dan Counter yang dihasilkan meningkat 10%. Pada awal giliran musuh, setiap kali satu Gnosis diaktifkan, dapatkan 25% Counter sementara dari Counter permanen saat ini, dan memicu 25% racun pada semua musuh. \n·Kerucut Cahaya Nasib: Jumlah putaran monster biasa yang melepaskan \"Tatapan\" menjadi 6 putaran. Semua pertempuran memiliki batas 15 putaran, tetapi pada awal 15 putaran, satu kartu \"Garis Batas Cahaya\" ditambahkan ke tangan: mengisi Energi Kunci Perak dan Aliemus semua Awakener hingga nilai maksimum."
  },
  State_74788_Name = {
    Text = "(Sementara tidak digunakan)"
  },
  State_74791_Desc = {
    Text = "\n·Arithmetica Harmony: Saat kartu yang dimainkan dalam satu giliran mencapai 10 Kartu perintah, setiap 1 Kartu perintah yang dimainkan mendapatkan 1 stack \"Arithmetica Harmony\". \"Arithmetica Harmony\" membuat setiap Kartu perintah yang dimainkan dalam giliran ini menambah Arithmetica Cost +1, setiap poin Arithmetica tambahan yang dihabiskan dikonversi menjadi Keyflare sebesar 100% Keyflare Regen Awakener, dapat ditumpuk. Setelah mengaktifkan Ruang Ultra, reset efek Arithmetica Harmony.\n·Aritmetika penuh: Setelah memainkan Kartu, hapus efek pengurangan Arithmetica Cost dalam giliran ini. Saat Arithmetica saat ini dalam pertempuran melebihi 12, setiap poin Arithmetica yang melebihi batas secara otomatis dikonversi menjadi Keyflare sebesar 300% rata-rata Keyflare Regen tim.\n·Aliemus Harmony: Efek peningkatan persentase Aliemus berkurang setengah. Setiap kali Awakener melepaskan Exalt, Aliemus Dasar-nya +10. Di akhir giliran, setiap 1 Awakener yang tidak melepaskan Exalt, dapatkan Keyflare sebesar 200% rata-rata Keyflare Regen tim."
  },
  State_74791_Name = {
    Text = "Energi Kunci Harmonis"
  },
  State_74809_Name = {
    Text = "\"Bentuk Akhir\": Tarik 3 kartu tambahan, dapatkan 3 poin Aritmetika, aktifkan [DescArg1]% <IntoxicationIconKeywords:Racun> pada semua musuh, batas maksimum Aliemus \"Boneka·Dor\" meningkat sebesar 50 poin, hingga maksimal 3 kali."
  },
  State_74826_Name = {
    Text = "Secara acak menimbulkan [DescArg1] poin <FixedDamage:Kerusakan Murni> sebanyak [DescArg2] kali (kerusakan ini mendapat bonus STR sebesar 1 kali lipat)"
  },
  State_74827_Name = {
    Text = "Pada giliran ini, semua Pembangun mendapatkan peningkatan [DescArg1]% untuk kritis dan Crit. DMG."
  },
  State_74828_Name = {
    Text = "Menyebabkan [DescArg1] poin Racun pada semua musuh"
  },
  State_74829_Name = {
    Text = "Menimbulkan <FixedDamage:Kerusakan Murni> kepada semua musuh sebesar [DescArg1]% dari HP yang telah hilang"
  },
  State_74830_Name = {
    Text = "Mendapatkan [DescArg1] poin Kekuatan"
  },
  State_74831_Name = {
    Text = "Semua Pembangun mendapatkan [DescArg1] poin Aliemus."
  },
  State_74847_Desc = {
    Text = "Satu-satunya di tim: Kerusakan dasar yang ditimbulkan oleh kartu perintah pertama yang digunakan oleh pemilik setiap ronde meningkat sebesar <WeaponEffect_Num:[StateArg1]%. Jika pemilik memasuki ruang ultra, pemilik mendapatkan <WeaponEffect_Num:[StateArg2]> poin Aliemus."
  },
  State_74847_WeaponDesc = {
    Text = "Kerusakan dasar yang diberikan oleh kartu perintah pertama yang digunakan oleh pemegang setiap putaran meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Jika pemegang memasuki ruang ultra, pemegang akan mendapatkan <WeaponEffect_Num:[StateArg2]> poin aliemus."
  },
  State_74879_Name = {
    Text = "Mendapatkan [DescArg1] poin Aritmetika"
  },
  State_74881_Name = {
    Text = "Pilih satu Pembangun untuk mendapatkan [DescArg1] poin Aliemus."
  },
  State_74882_Name = {
    Text = "Mendapatkan [DescArg1] poin Penguasaan Alam"
  },
  State_74883_Name = {
    Text = "Kartu perintah yang dimainkan berikutnya [DescArg1] memberikan tambahan [DescArg2] poin energi kunci."
  },
  State_74884_Name = {
    Text = "Efek Racun, Counter, dan Berdarah di babak ini meningkat sebesar [DescArg1]%"
  },
  State_74885_Name = {
    Text = "Semua Pembangun mendapatkan [DescArg1] poin Aliemus."
  },
  State_74887_Name = {
    Text = "Mendapatkan [DescArg1] poin Perisai"
  },
  State_74888_Name = {
    Text = "Mendapatkan [DescArg1] poin Ketahanan"
  },
  State_74889_Name = {
    Text = "Mendapatkan [DescArg1] lapisan Counter"
  },
  State_74890_Name = {
    Text = "Mencuri [DescArg1] poin Kekuatan sementara dari semua musuh"
  },
  State_74891_Name = {
    Text = "Secara acak menimbulkan [DescArg1] poin <FixedDamage:Kerusakan Murni> sebanyak [DescArg2] kali (kerusakan ini mendapat bonus STR sebesar 1 kali lipat)"
  },
  State_74910_Desc = {
    Text = "Tim Unik: Jika Pemakai adalah Awakener \"Ramona\", Affiniti yang diperoleh dari eksplorasi level meningkat sebesar <WeaponEffect_Num:[StateArg1]%>."
  },
  State_74910_WeaponDesc = {
    Text = "Jika pemakai adalah Pembangun \"Ramona\", Affiniti yang diperoleh saat menyelesaikan level meningkat sebesar <WeaponEffect_Num:[StateArg1]%>."
  },
  State_74932_Desc = {
    Text = "Menggunakan kartu \"Serangan\", kartu \"Pertahanan\", dan kartu \"Keterampilan\" akan meningkatkan efek yang sesuai dalam \"Perjanjian Tabu\"."
  },
  State_74932_Name = {
    Text = "Perdagangan Terlarang"
  },
  State_74947_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat giliran dimulai, tambahkan [StateArg1] stacks Action Lock pada musuh dengan <HPAndShieldMin:HP dan Perisai terendah>. Setelah Pemakai melakukan Bunuh, efek ini langsung dipicu sekali."
  },
  State_74947_Name = {
    Text = "Topi Lebar Penyihir"
  },
  State_74948_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setelah \"Exalt\", membuat musuh dengan Aliemus tertinggi kehilangan [StateArg1] Aliemus dan mendapatkan<PVPEmptinessKeywords:Void>."
  },
  State_74948_Name = {
    Text = "Pendulum Hipnotik"
  },
  State_76236_Desc = {
    Text = "\n·Keyflare Rouse: Saat Keyflare penuh, dapat memilih tambahan \"Keyflare Rouse\" untuk menempatkan kartu Rouse Gnosis dari Awakener yang ditentukan ke tangan dan membuatnya mendapatkan \"Retain\", berlaku untuk pertempuran ini. \"Keyflare Rouse\" hanya dapat dipicu 1 kali per ronde, dengan cooldown terpisah dari \"Posse\".\n·Keyflare Overload: Saat menggunakan \"Keyflare Rouse\", setiap Awakener yang telah membuka kunci Rouse Gnosis akan mengurangi tambahan 1000 poin Keyflare, efek ini dapat membuat Keyflare menjadi negatif.\n·Tanda Arsip: Setiap 1 Posse yang dimiliki Penjaga meningkatkan \"Kedalaman penelitian objek\" dan \"Kedalaman Penelitian Spiritual\" sebesar 1%, maksimal 50%. Efek semua Roda takdir R diubah menjadi meningkatkan kemungkinan munculnya Relic Gambar Dimensi milik pemakai sebesar 100%."
  },
  State_76236_Name = {
    Text = "Cahaya Perak Bercahaya"
  },
  State_76277_Desc = {
    Text = "Tim Satu-satunya: Setelah pertarungan bos dimulai, menghabiskan maksimal 50 Segil hitam, setiap 1 poin Segil hitam yang dihabiskan mendapatkan <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords:Ketahanan>. Dalam bab Bintang, efeknya berubah menjadi \"Meningkatkan kemungkinan munculnya Relik memangsa dimensi penyaji sebanyak 100%\"."
  },
  State_76277_WeaponDesc = {
    Text = "Setelah pertarungan pemimpin dimulai, konsumsi maksimal 50 Segil hitam, setiap kali mengkonsumsi 1 poin Segil hitam mendapatkan <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords: Ketahanan>. Dalam babak bintang, efeknya berubah menjadi \"meningkatkan kemungkinan munculnya Relik citra dimensi pengguna sebesar 100%.\""
  },
  State_76278_Desc = {
    Text = "Satu-satunya Tim: Setiap melewati kotak baru, pulihkan <WeaponEffect_Num:[StateArg1]%> dari darah yang hilang. Setelah menggunakan Gnosis Darurat, tingkat kritis dan kerusakan kritis semua Pembangun meningkat sebesar 100%. Dalam Bab Bintang, efek diubah menjadi \"Kemungkinan munculnya Relik Dimensi pemakai meningkat sebesar 100%\"."
  },
  State_76278_WeaponDesc = {
    Text = "Setiap kali melewati kotak baru, pulihkan [StateArg1]% dari darah yang hilang ([DescArg1]). Setelah menggunakan Gnosis Darurat, tingkat kritis dan kerusakan kritis semua Pembangun meningkat sebesar 100%. Dalam bab Stars, efek diubah menjadi \"Kemungkinan munculnya Relik Dimensi pemakai meningkat sebesar 100%\"."
  },
  State_76279_Desc = {
    Text = "Unik untuk tim: harga untuk membangkitkan tubuh pemanggilan dalam tanda sembunyi berkurang <WeaponEffect_Num:[StateArg1]> poin tanda hitam. Kebangkitan kesadaran penggarap mendapatkan inheren. Dalam episode Bintang, efeknya berubah menjadi \"meningkatkan kemungkinan terciptanya objek citra dimensi milik penggarap sebesar 100%\"."
  },
  State_76279_WeaponDesc = {
    Text = "Harga Pembangun yang terbangun dalam D-marka berkurang sebesar <WeaponEffect_Num:[StateArg1]> Segil hitam. Gnosis pemakai memperoleh Membangkitkan secara inheren. Dalam bab Bintang, efek diubah menjadi \"Meningkatkan kemungkinan munculnya Relik Dimensi pemakai sebesar 100%\"."
  },
  State_76280_Desc = {
    Text = "Efek Unik Tim: Jumlah pemulihan di tempat istirahat meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah memilih untuk memulihkan hidup, tambahkan 2 kartu \"Inspirasi\" ke dalam dek. Dalam bab Bintang, efek berubah menjadi \"Meningkatkan kemungkinan munculnya Relik Dimensi pemakai sebesar 100%\"."
  },
  State_76280_WeaponDesc = {
    Text = "Jumlah pemulihan di tempat istirahat meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah memilih pemulihan hidup, tambahkan 2 kartu \"Inspirasi\" ke dalam dek. Dalam babak Bintang, efek berubah menjadi \"Kemungkinan munculnya relik dimensi dari pemakai meningkat sebesar 100%\"."
  },
  State_76281_Desc = {
    Text = "Satu-satunya Tim: Setelah pertempuran berakhir, Pembangun dengan Aliemus terendah mendapatkan <WeaponEffect_Num:[StateArg1]> poin Aliemus. Dalam bab Bintang, efek diubah menjadi \"Meningkatkan kemungkinan munculnya Relik Dimensi pemakai sebesar 100%\"."
  },
  State_76281_WeaponDesc = {
    Text = "Setelah pertempuran berakhir, Pembangun dengan Aliemus terendah mendapatkan <WeaponEffect_Num:[Energy:StateArg1]> poin Aliemus. Dalam babak Bintang, efek diubah menjadi \"Meningkatkan kemungkinan munculnya Relik Dimensi pemakai sebesar 100%\"."
  },
  State_76282_Desc = {
    Text = "Unik untuk tim: jumlah penyegaran znak +1, harga penyegaran berkurang <WeaponEffect_Num:[StateArg1]> poin tanda hitam. Dalam episode Bintang, efeknya berubah menjadi \"meningkatkan kemungkinan terciptanya objek citra dimensi milik penggarap sebesar 100%\"."
  },
  State_76282_WeaponDesc = {
    Text = "Jumlah reset D-marka +1, harga reset berkurang <WeaponEffect_Num:[StateArg1]> poin segil hitam. Dalam bagian bintang, efeknya berubah menjadi \"Meningkatkan kemungkinan kemunculan dimensi gambar relik dari pemakai sebesar 100%\"."
  },
  State_76283_Desc = {
    Text = "Satu-satunya di tim: Slot D-marka berubah menjadi 3, salah satunya adalah Relik terkutuk. Setelah membeli Relik terkutuk, dapatkan <WeaponEffect_Num:[StateArg1]> Segil hitam. Dalam bab Bintang, efeknya berubah menjadi \"Kemungkinan munculnya proyeksi Dimensi pemakai meningkat sebesar 100%\"."
  },
  State_76283_WeaponDesc = {
    Text = "Jumlah slot Relik D-marka berubah menjadi 3, salah satunya adalah Relik terkutuk. Setelah membeli Relik terkutuk, pemain akan mendapatkan <WeaponEffect_Num:[StateArg1]> Segil hitam. Dalam bab Bintang, efeknya berubah menjadi \"Meningkatkan kemungkinan munculnya Relik bayangan Dimensi pengguna sebesar 100%\"."
  },
  State_76284_Desc = {
    Text = "Satu-satunya Tim: Setelah level dimulai, semua Pembangun mendapatkan <WeaponEffect_Num:[StateArg1]> poin Aliemus. Setelah pertarungan bos dimulai, tarik 2 kartu. Dalam babak Bintang, efeknya berubah menjadi \"Meningkatkan kemungkinan munculnya Relik Dimensi pemakai sebesar 100%\"."
  },
  State_76284_WeaponDesc = {
    Text = "Setelah level dimulai, semua Pembangun mendapatkan <WeaponEffect_Num:[Energy:StateArg1]> poin Aliemus. Setelah pertempuran bos dimulai, tarik 2 kartu. Dalam babak Bintang, efeknya berubah menjadi \"Meningkatkan kemungkinan munculnya Relik Dimensi pemakai sebesar 100%\"."
  },
  State_76285_Desc = {
    Text = "Satu-satunya Tim: Setelah tahap dimulai, dapatkan <WeaponEffect_Num:[StateArg1]> Energi-s. Setelah pertarungan bos dimulai, dapatkan 2 poin Aritmetika. Dalam bab Bintang, efek diubah menjadi \"Meningkatkan kemungkinan munculnya Relik Dimensi pemilik peralatan sebesar 100%\"."
  },
  State_76285_WeaponDesc = {
    Text = "Setelah level dimulai, dapatkan <WeaponEffect_Num:[StateArg1]> poin Energi-s. Setelah pertarungan bos dimulai, dapatkan 2 poin Aritmetika. Dalam bab Bintang, efek diubah menjadi \"Meningkatkan kemungkinan munculnya Relik Dimensi pemilik peralatan sebesar 100%\"."
  },
  State_76286_Desc = {
    Text = "Unik untuk tim: tempat istirahat menyediakan satu opsi tambahan: hapus hingga 3 kartu gejala, dan dapatkan <WeaponEffect_Num:[StateArg1]> poin tanda hitam. Dalam episode Bintang, efeknya berubah menjadi \"meningkatkan kemungkinan terciptanya objek citra dimensi milik penggarap sebesar 100%\"."
  },
  State_76286_WeaponDesc = {
    Text = "Tempat peristirahatan memberikan pilihan tambahan: menghilangkan hingga 3 gejala, memperoleh <WeaponEffect_Num:[StateArg1]> poin segil hitam. Dalam bab bintang, efeknya diubah menjadi \"meningkatkan kemungkinan penciptaan bayangan dimensi pemakai sebesar 100%.\""
  },
  State_76287_Desc = {
    Text = "Satu-satunya di tim: Setelah pertempuran normal selesai, jumlah Orison yang dapat dipilih berubah menjadi 4. Orison pada Kartu pemakai memiliki peluang <WeaponEffect_Num:[StateArg1]%> untuk ditingkatkan menjadi Orison tingkat lanjut. Dalam bab Bintang, efeknya berubah menjadi \"Meningkatkan kemungkinan munculnya Relik dimensi pemakai sebesar 100%.\""
  },
  State_76287_WeaponDesc = {
    Text = "Setelah pertempuran biasa selesai, jumlah Orison yang dapat dipilih menjadi 4. Orison pada Kartu pemakai memiliki peluang <WeaponEffect_Num:[StateArg1]%> untuk ditingkatkan menjadi Orison tingkat lanjut. Dalam bab Bintang, efek diubah menjadi \"Meningkatkan kemungkinan munculnya Relik Dimensi pemakai sebesar 100%\"."
  },
  State_76288_Desc = {
    Text = "Satu-satunya Tim: Setelah pertempuran berakhir, dapatkan <WeaponEffect_Num:[StateArg1]> poin Energi-s. Dalam bab Bintang, efeknya diubah menjadi \"Kemungkinan munculnya Relik dimensi pemilik peralatan meningkat sebesar 100%\"."
  },
  State_76288_WeaponDesc = {
    Text = "Setelah pertempuran berakhir, dapatkan <WeaponEffect_Num:[StateArg1]> poin Energi-s. Dalam bab Bintang, efek diubah menjadi \"Meningkatkan kemungkinan munculnya Relik dimensi pemakai sebesar 100%\"."
  },
  State_76289_Desc = {
    Text = "Unik untuk tim: saat eksplorasi, visibilitas +1, setelah visibilitas peta terbuka sepenuhnya, dapatkan <WeaponEffect_Num:[StateArg1]> poin tanda hitam. Saat pertempuran bos dimulai, <WeaknessIconKeywords:Kelemahan> dan <VulnerabilityIconKeywords:Rentan> semua musuh selama 1 giliran. Dalam episode Bintang, efeknya berubah menjadi \"meningkatkan kemungkinan terciptanya objek citra dimensi milik penggarap sebesar 100%\"."
  },
  State_76289_WeaponDesc = {
    Text = "Penglihatan bertambah +1 saat menjelajah, setelah penglihatan peta terbuka sepenuhnya, dapatkan <WeaponEffect_Num:[StateArg1]> Segil hitam. Saat pertarungan bos dimulai, semua musuh akan mengalami <WeaknessIconKeywords:Kelemahan> dan <VulnerabilityIconKeywords:Rentan> selama 1 putaran. Dalam bab Bintang, efek diubah menjadi \"Kemungkinan munculnya Relik dimensi pemakai meningkat sebesar 100%\"."
  },
  State_76290_Desc = {
    Text = "Satu-satunya Tim: Setelah pertempuran normal berakhir, kamu dapat memilih untuk menyerah dari Orison, batas hidup meningkat <WeaponEffect_Num:[StateArg1]%>. Efek ini dapat bekerja maksimal 2 kali. Dalam babak Stellar, efeknya berubah menjadi \"Kemungkinan munculnya relik dimensi pemakai akan meningkat sebesar 100%\"."
  },
  State_76290_WeaponDesc = {
    Text = "Setelah pertempuran normal berakhir, kamu dapat memilih untuk menolak Orison, batas hidup akan meningkat sebesar <WeaponEffect_Num:[DescArg1]>. Efek ini paling banyak berlaku 2 kali. Dalam bab Bintang, efeknya berubah menjadi \"Meningkatkan kemungkinan munculnya relik dimensi pemakai sebesar 100%\"."
  },
  State_76291_Desc = {
    Text = "Unik untuk tim: setelah level dimulai, dapatkan <WeaponEffect_Num:[StateArg1]> poin tanda hitam. Batas objek +2. Dalam episode Bintang, efeknya berubah menjadi \"meningkatkan kemungkinan terciptanya objek citra dimensi milik penggarap sebesar 100%\"."
  },
  State_76291_WeaponDesc = {
    Text = "Setelah mulai tahap, memperoleh <WeaponEffect_Num:[StateArg1]> poin Segil hitam. Batas Relik +2. Dalam bagian bintang, efeknya diubah menjadi \"Menambah kemungkinan terbentuknya gambar dimensi dari pemakai sebanyak 100%.\""
  },
  State_76292_Desc = {
    Text = "Unik untuk tim: dapat menjual kartu gejala di tempat menjual tanda hitam, setelah menjual kartu gejala, dapatkan <WeaponEffect_Num:[StateArg1]> poin tanda hitam. Dalam episode Bintang, efeknya berubah menjadi \"meningkatkan kemungkinan terciptanya objek citra dimensi milik penggarap sebesar 100%\"."
  },
  State_76292_WeaponDesc = {
    Text = "Di tempat penjualan kartu D-marka, diizinkan untuk menjual kartu gejala. Setelah menjual kartu gejala, akan mendapatkan <WeaponEffect_Num:[StateArg1]> segil hitam. Dalam bab Bintang, efeknya berubah menjadi \"Meningkatkan kemungkinan munculnya relik dimensi pemakai sebesar 100%\"."
  },
  State_76321_Name = {
    Text = "Lensa Prismatis"
  },
  State_76323_Name = {
    Text = "Aliemus Harmony"
  },
  State_76324_Name = {
    Text = "Arithmetica Harmony"
  },
  State_76325_Desc = {
    Text = "Setelah menggunakan [DescArg1] Kartu perintah, masuk ke dalam Negara \"Penyesuaian Aritmetika\"."
  },
  State_76325_Name = {
    Text = "Arithmetica Harmony"
  },
  State_76326_Name = {
    Text = "Ada paradoks"
  },
  State_76328_Name = {
    Text = "Kerucut Cahaya Nasib"
  },
  State_76337_Name = {
    Text = "Luka tanpa dasar"
  },
  State_76338_Desc = {
    Text = "Perawatan yang diterima pemain berkurang [Layer]％."
  },
  State_76338_Name = {
    Text = "Luka tanpa dasar"
  },
  State_76430_Name = {
    Text = "Dimensi·Lily"
  },
  State_76433_Name = {
    Text = "Arithmetica Harmony"
  },
  State_76434_Desc = {
    Text = "Setiap kali Kartu perintah digunakan, jika Aritmetika tambahan dikonsumsi karena penyesuaian Aritmetika, secara ekstra mendapatkan 100% Energi-s dari Isi ulang kunci perak Pembangun, dapat ditumpuk."
  },
  State_76434_Name = {
    Text = "Arithmetica Harmony"
  },
  State_76435_Name = {
    Text = "Lensa Prismatis"
  },
  State_76528_Name = {
    Text = "Kartu ini dianggap sebagai \"Pukulan\""
  },
  State_76529_Desc = {
    Text = "Saat mengambil, pilih satu kartu Pembangun untuk mengurangi konsumsi Aritmetika sebesar 1, setelah dimainkan tarik 1 kartu, dan anggap itu sebagai \"Pukulan\"."
  },
  State_76533_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>：Saat dipasang dan pada akhir giliran, memberikan [StateArg1] kartu acak kepada lawan dengan [StateArg2] lapisan <PVPAcheKeywords:Kesakitan Tersembunyi>。"
  },
  State_76533_Name = {
    Text = "Duka Terselubung"
  },
  State_76553_Desc = {
    Text = "Kartu ini mengonsumsi -[StateArg1] Aritmetika."
  },
  State_76553_Name = {
    Text = "Tatapan Seribu Kasih"
  },
  State_77686_Name = {
    Text = "Bentuk Semi-Mesin"
  },
  State_77688_Desc = {
    Text = "Pada awal ronde kelima atau saat akan mati, kebal terhadap kematian dan menyesuaikan Niat menjadi \"Peningkatan Mekanis\"."
  },
  State_77688_Name = {
    Text = "Daging lemah"
  },
  State_77690_Desc = {
    Text = "Setelah beralih ke \"Bentuk Semi-Mekanik\", untuk setiap 1 lapisan Akhir, dapatkan tambahan 10% Kesehatan Maksimum. Dalam \"Bentuk Semi-Mekanik\",\"Pelelehan·Boneka\" akan melepaskan keterampilan yang lebih mengancam seiring dengan peningkatan jumlah lapisan \"Akhir\"."
  },
  State_77690_Name = {Text = "Akhir"},
  State_77692_Desc = {
    Text = "Pada akhir ronde, memanggil 2 monster Pelarutan, maksimal 2 dapat ada secara bersamaan. Setelah monster Pelarutan yang dipanggil mati, \"Boneka·Pelarutan\"kehilangan 5% dari kesehatan maksimum."
  },
  State_77692_Name = {
    Text = "Pintu Jurang"
  },
  State_77693_Desc = {
    Text = "Setelah kematian, \"Boneka·Dor\"kehilangan 5% dari Kesehatan maksimum."
  },
  State_77693_Name = {Text = "Meltdown"},
  State_78102_Desc = {
    Text = "Kerusakan yang dihasilkan berkurang sebesar 15%, kerusakan yang diterima meningkat sebesar 30%, dan efek ini berlangsung hingga pertempuran berakhir."
  },
  State_78102_Name = {
    Text = "Paralisis Overclock"
  },
  State_78694_Desc = {
    Text = "Pada awal Pertempuran, mendapatkan [Arg1] poin Kekuatan. Pada awal giliran, untuk setiap [Arg2] poin Kekuatan Permanen, dapatkan [Arg3] poin Kekuatan Sementara, maksimal mendapatkan [Arg4] poin Kekuatan Sementara, dan pada akhir giliran kehilangan setengah dari Perisai yang didapat dari Kekuatan Sementara oleh Relik ini."
  },
  State_78696_Desc = {
    Text = "Setelah menggunakan \"Bangkit kunci perak\" untuk Bangun, pilih [Arg1] \"Keterampilan\" yang sesuai dari Pembangun untuk dikonsumsi, dan cuci salinan tambahan sebanyak [Arg2] ke dalam tumpukan Menggambar."
  },
  State_78697_Desc = {
    Text = "Pada awal giliran, dikenakan [Arg2] lapisan Racun, di ruang Ultra setiap satu tempat kosong mendapatkan [Arg1] poin Kekuatan."
  },
  State_78698_Desc = {
    Text = "Batas atas Aritmetika -[Arg1]. Setiap kali memainkan 1 kartu dengan Lelah Aritmetika lebih dari atau sama dengan [Arg2], dapatkan 1 poin Aritmetika, setiap ronde paling banyak dipicu [Arg3] kali."
  },
  State_78699_Desc = {
    Text = "Setelah menggambar kartu, tarik [Arg1] kartu tambahan, tetapi pilih [Arg2] kartu di tangan untuk dibuang."
  },
  State_78700_Desc = {
    Text = "Kerusakan dasar semua Pembangun meningkat sebesar [Arg1]%, setiap kali mengatur ulang dek kartu akan memberikan tambahan peningkatan sebesar [Arg2]%, tetapi 1 kartu \"Tertatih\" akan dimasukkan ke tangan. Nilai peningkatan maksimal adalah [Arg3]%."
  },
  State_78701_Desc = {
    Text = "Pada awal ronde, jika terdapat lebih dari [Arg1] Tentakel permanen, kehilangan [Arg2] Tentakel dan mendapatkan [Arg3] Tentakel sementara; jika tidak, mendapatkan [Arg4] Tentakel sementara."
  },
  State_78702_Desc = {
    Text = "Setelah bangkit kunci perak, tambahan lelah [Arg1] poin energi-s, membuat konsumsi aritmetika kartu membangkitkan gnosis menjadi 0, dan setelah dimainkan memberikan pembangun yang sesuai tambahan [Arg2] poin aliemus."
  },
  State_78703_Desc = {
    Text = "Pada saat pertempuran dimulai, semua musuh akan menerima [Arg1] poin Racun. Sebelum giliran dimulai, [Arg2]% Racun pada musuh akan dihilangkan dan [Arg3]% dari jumlah yang dihilangkan akan diterapkan sebagai Berdarah."
  },
  State_78710_Desc = {
    Text = "Setiap kali memainkan kartu perintah meningkatkan kerusakan akhir yang diberikan oleh Pembangun yang sesuai dalam putaran itu sebesar [Arg1]%, tetapi mengurangi [Arg2] poin Aliemus. Setiap putaran dapat dipicu maksimal [Arg3] kali."
  },
  State_78712_Desc = {
    Text = "Pada awal ronde, Fusi Embrio meningkat +[Arg1], Embrio kamu akan dibuang pada akhir ronde."
  },
  State_78713_Desc = {
    Text = "Pada awal ronde, dapatkan [Arg1] poin Counter. Setelah melepaskan Muliakan sebanyak [Arg2] kali dalam satu ronde, hapus [Arg3]% Counter permanen milik sendiri, dapatkan Counter sementara sebesar [Arg4]% dari jumlah yang dihapus, dengan cooldown selama [Arg5] ronde."
  },
  State_78781_Desc = {
    Text = "Sementara mengurangi kekuatan target, dapatkan kekuatan sementara sebanding."
  },
  State_78781_Name = {
    Text = "<TouquKeywords: Mencuri>"
  },
  State_79405_Desc = {
    Text = "Setelah memainkan, “Kenangan Jelas” meningkat 1, ketika mencapai 10 akan menguncinya selama 1 giliran dan mendapatkan 3 kartu “Inspirasi”, pada awal giliran berikutnya direset menjadi 5."
  },
  State_79405_Name = {
    Text = "Masa Lalu yang Sebenarnya"
  },
  State_79406_Desc = {
    Text = "Setelah memainkan, “Kenangan Jelas” berkurang 1, ketika mencapai 0 akan menguncinya selama 1 giliran dan memberikan semua Pembangun 30 poin Aliemus, pada awal giliran berikutnya direset menjadi 5."
  },
  State_79406_Name = {
    Text = "Mimpi yang Mewah"
  },
  State_80052_Desc = {Text = "Uji"},
  State_80052_Name = {Text = "Tes123"},
  State_80052_WeaponDesc = {Text = "Uji"},
  State_80161_Desc = {
    Text = "Tim Satu-satunya: Peningkatan kerusakan dasar yang dihasilkan oleh ledakan kegilaan pengguna <WeaponEffect_Num:[StateArg1]%>, peningkatan pengisian kunci perak <WeaponEffect_Num:[StateArg2]%>. Setelah memasuki putaran ultra, semua Pembangun mendapatkan <WeaponEffect_Num:[StateArg4]> poin kegilaan. Setelah melepaskan \"Annihilation\", pengguna mendapatkan <WeaponEffect_Num:[StateArg3]> poin kegilaan."
  },
  State_80161_WeaponDesc = {
    Text = "Kerusakan dasar yang diakibatkan oleh pemilik meningkatkan <WeaponEffect_Num:[StateArg1]%>, pengisian kunci perak meningkat <WeaponEffect_Num:[DescArg1]>. Setelah memasuki putaran ultra, semua pembangun mendapatkan <WeaponEffect_Num:[StateArg4]> poin aliemus. Setelah melepas \"Pemusnahan\", pemilik mendapatkan <WeaponEffect_Num:[StateArg3]> poin aliemus."
  },
  State_80174_Desc = {
    Text = "Unik untuk tim: Peningkatan isi ulang kunci perak pemakai sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah pertarungan pertama dimulai, berikan 1 lapisan kelemahan dan rentan kepada semua musuh."
  },
  State_80174_WeaponDesc = {
    Text = "Peningkatan isi ulang kunci perak pemakai sebesar <WeaponEffect_Num:[DescArg1]>. Setelah pertarungan pertama dimulai, berikan 1 lapisan kelemahan dan rentan kepada semua musuh."
  },
  State_80207_Desc = {
    Text = "·Jika memainkan kartu ini memicu \"Dimension Shuttle\", memicu efek lanjutan.\n·Ketika mengambil kartu dari ruang ultra, konsumsi aritmetika berkurang -1."
  },
  State_80207_Name = {
    Text = "<WormholeKeywords:Jarak Jauh>"
  },
  State_80328_Desc = {
    Text = "Perasaannya, kognisi, dan semua hal lainnya, terhubung selamanya dengan Ikrar Sarang. Maksimum tumpukan 15 lapisan. \"Empati\" dapat diubah oleh Penuh Kegilaan Clementine menjadi efek negatif."
  },
  State_80328_Name = {Text = "Empati"},
  State_80331_Desc = {
    Text = "Di bawah Corrosion kawanan, kelemahanmu terekspos sepenuhnya. Active DMG dan kerusakan tentakel yang diterima pada giliran ini meningkat [DescArg1]%."
  },
  State_80331_Name = {
    Text = "<D13Colour:Trauma mental>"
  },
  State_80332_Desc = {
    Text = "Perasaannya, kognisi, dan semua hal lainnya, terhubung selamanya dengan Ikrar Sarang, maksimum tumpukan 10 lapisan. \"Empati\" dapat diubah oleh Penuh Kegilaan Clementine menjadi efek negatif melalui \"Terapi Rekonstruksi Hidup\"."
  },
  State_80332_Name = {Text = "Empati"},
  State_80335_Desc = {
    Text = "Di bawah Corrosion kawanan, kelemahanmu terekspos sepenuhnya. Active DMG dan kerusakan tentakel yang diterima pada giliran ini meningkat [DescArg1]%."
  },
  State_80335_Name = {
    Text = "<D13Colour:Trauma mental>"
  },
  State_80336_Desc = {
    Text = "Di bawah Corrosion kawanan, ketakutanmu tidak bisa bersembunyi. Active DMG dan kerusakan tentakel yang ditimbulkan pada giliran ini berkurang [DescArg1]%."
  },
  State_80336_Name = {
    Text = "<D13Colour:Ketakutan yang melekat>"
  },
  State_80338_Desc = {
    Text = "Di bawah Corrosion kawanan, ketakutanmu tidak bisa bersembunyi. Active DMG dan kerusakan tentakel yang ditimbulkan pada giliran ini berkurang [DescArg1]%."
  },
  State_80338_Name = {
    Text = "<D13Colour:Ketakutan yang melekat>"
  },
  State_80575_Desc = {
    Text = "Setelah menerima kerusakan aktif atau kerusakan tentakel, lepaskan jumlah yang sama dari \"Abu Kuno\" dan kehilangan 300% dari jumlah yang dilepas. Ketika menerima kerusakan lainnya, lepaskan setengahnya. Lapisan \"Abu Kuno\" direset setiap giliran."
  },
  State_80575_Name = {
    Text = "Abu sisa lama"
  },
  State_80644_Name = {
    Text = "Negara@Cahaya Transenden"
  },
  State_80773_Desc = {
    Text = "Saat menerima efek STR▼, hanya akan mengurangi 50% stacks STR. Dalam giliran sendiri, kerusakan non-Active DMG dan tentakel yang diterima meningkat 100%."
  },
  State_80773_Name = {
    Text = "Antibodi ekstradimensi"
  },
  State_80774_Desc = {
    Text = "Setelah menerima kerusakan aktif atau kerusakan tentakel, hilangkan sejumlah yang setara \"Kekayuan Lama\" dan kehilangan 300% dari jumlah yang dihilangkan dari kesehatan, menghilangkan setengah saat mendapat kerusakan lainnya. Lapisan \"Kekayuan Lama\" reset setiap giliran. Setelah \"Kekayuan Lama\" seluruhnya dihilangkan, dapatkan 50 lapisan \"Diperkuat\"."
  },
  State_80774_Name = {
    Text = "Abu sisa lama"
  },
  State_80777_Desc = {
    Text = "Pada awal Pertempuran, kurangi Crit. Rate semua Pembangun sebesar 10%. Setelah mati, rekan lainnya mendapatkan [DescArg1] poin Kekuatan dan [DescArg2] lapisan \"Jejak Lama\"."
  },
  State_80777_Name = {
    Text = "Empati Sarang Lebah - Warisan"
  },
  State_80778_Desc = {
    Text = "Setelah mati, teman lain mendapatkan 1 stacks <MadnessIconKeywords:Kegilaan> Sementara."
  },
  State_80778_Name = {
    Text = "Hive Empati: Fusion"
  },
  State_80782_Desc = {
    Text = "Selama pertempuran ini, semua Pembangun memiliki Crit. Rate yang menurun [Layer]％."
  },
  State_80782_Name = {
    Text = "Tingkat Kritikal Dikurangi"
  },
  State_80783_Desc = {
    Text = "Saat giliran berakhir, dapatkan 1 stacks <MadnessIconKeywords:Kegilaan>."
  },
  State_80783_Name = {
    Text = "Ikatan Keluarga"
  },
  State_80784_Desc = {
    Text = "Saat kehidupan turun di bawah 50%, panggil seorang \"Pengubah Awal\" di belakang, hanya dapat diaktifkan 1 kali per pertarungan."
  },
  State_80784_Name = {
    Text = "Empati Sarang: Fisi"
  },
  State_80785_Desc = {
    Text = "Saat Strength diturunkan, hanya akan menurunkan 50% stacks Strength. Setiap kali pemain melepaskan Exalt, dapatkan 1 stacks Temporary <MadnessIconKeywords:Kegilaan>."
  },
  State_80785_Name = {
    Text = "Empati Sarang Lebah: Dimensi Lain"
  },
  State_80788_Desc = {
    Text = "Saat Strength diturunkan, hanya akan menurunkan 25% stacks Strength. Setiap kali pemain melepaskan Exalt, dapatkan 1 stacks Temporary <MadnessIconKeywords:Kegilaan>."
  },
  State_80788_Name = {
    Text = "Empati Sarang Lebah: Dimensi Lain"
  },
  State_80789_Desc = {
    Text = "Active DMG dan kerusakan tentakel yang diterima meningkat 100%, berlangsung selama 1 giliran."
  },
  State_80789_Name = {
    Text = "bersembunyi"
  },
  State_80790_Desc = {
    Text = "Setelah metamorfosis, setiap lapisan energi hampa kosmis akan membuatnya menjadi sempurna..."
  },
  State_80790_Name = {
    Text = "Energi Kosmik"
  },
  State_80792_Desc = {
    Text = "Setiap kali pemain melepaskan Exalt, dapatkan 1 stacks <MadnessIconKeywords:Kegilaan> Sementara."
  },
  State_80792_Name = {
    Text = "Empati Sarang Lebah: Dimensi Lain"
  },
  State_80794_Desc = {
    Text = "Kartu tidak dapat dimainkan, dan tetap di tangan saat ronde berakhir."
  },
  State_80794_Name = {
    Text = "<Boundkeywords:Terikat>"
  },
  State_80807_Desc = {
    Text = "Ketika putaran kelima dimulai atau akan mati, hapus semua musuh lainnya, ganti niat menjadi \"Momen Metamorfosis\"."
  },
  State_80807_Name = {
    Text = "Moment Metamorfosis"
  },
  State_80809_Desc = {
    Text = "Saat giliran berakhir, kartu ilusi yang ada di tangan akan dibuang."
  },
  State_80809_Name = {
    Text = "<PVPVoidKeyColour:Ilusi>"
  },
  State_80810_Desc = {
    Text = "Setelah menerima kerusakan aktif atau kerusakan tentakel, lepaskan jumlah yang sama dari \"Abu Kuno\" dan kehilangan 300% dari jumlah yang dilepas. Ketika menerima kerusakan lainnya, lepaskan setengahnya. Lapisan \"Abu Kuno\" direset setiap giliran."
  },
  State_80810_Name = {
    Text = "Abu sisa lama"
  },
  State_80827_Desc = {
    Text = "Setiap kali mengeluarkan 15 kartu, mengganti niat saat ini dengan \"Tendangan Trauma\"(tersisa [Layer] kartu)."
  },
  State_80827_Name = {
    Text = "Hukuman Marah"
  },
  State_81022_WeaponDesc = {
    Text = "Setiap kali menerima 1 Kerusakan, semua Pembangun mendapatkan 1 poin Aliemus."
  },
  State_81027_Desc = {
    Text = "Pemilik kartu ini adalah \"Bangsa Serangga\", pengeluaran aritmetika -1, setelah dimainkan akan \"habis\"."
  },
  State_81027_Name = {
    Text = "Ritual Hidup"
  },
  State_81054_Desc = {
    Text = "Di bawah Corrosion kawanan, ketakutanmu tidak dapat bersembunyi. Setiap 1 stack mengurangi Active DMG dan Kerusakan tentakel yang diberikan pada giliran ini sebesar 3％, maksimal 15 stack."
  },
  State_81054_Name = {
    Text = "<D13AFKeyWordQ1:Ketakutan yang melekat>"
  },
  State_81055_Desc = {
    Text = "Di bawah Corrosion kawanan, ketakutanmu tidak dapat bersembunyi. Setiap 1 stack meningkatkan Active DMG dan Kerusakan tentakel yang diterima pada giliran ini sebesar 3％, maksimal 10 stack."
  },
  State_81055_Name = {
    Text = "<D13AFKeyWord2:Trauma mental>"
  },
  State_81056_Desc = {
    Text = "Di bawah Corrosion kawanan, ketakutanmu tidak dapat bersembunyi. Setiap 1 stack meningkatkan Active DMG dan Kerusakan tentakel yang diterima pada giliran ini sebesar 3％, maksimal 15 stack."
  },
  State_81056_Name = {
    Text = "<D13AFKeyWordQ2:Trauma mental>"
  },
  State_81057_Desc = {
    Text = "Di bawah Corrosion kawanan, ketakutanmu tidak dapat bersembunyi. Setiap 1 stack mengurangi Active DMG dan Kerusakan tentakel yang diberikan pada giliran ini sebesar 3％, maksimal 10 stack."
  },
  State_81057_Name = {
    Text = "<D13AFKeyWord1:Ketakutan yang melekat>"
  },
  State_81058_Desc = {
    Text = "Perasaannya, kognisi, dan semua hal lainnya, terhubung selamanya dengan Ikrar Sarang. \"Empati\" dapat diubah oleh Penuh Kegilaan Clementine menjadi efek negatif melalui \"Terapi Rekonstruksi Hidup\", maksimum tumpukan 15 lapisan."
  },
  State_81058_Name = {
    Text = "<AnalysisKeywords3:Empati>"
  },
  State_81059_Desc = {
    Text = "Perasaannya, kognisi, dan semua hal lainnya, terhubung selamanya dengan Ikrar Sarang. \"Empati\" dapat diubah oleh Penuh Kegilaan Clementine menjadi efek negatif melalui \"Terapi Rekonstruksi Hidup\", maksimum tumpukan 10 lapisan."
  },
  State_81059_Name = {
    Text = "<AnalysisKeywords0:Empati>"
  },
  State_81073_Desc = {
    Text = "Setelah menerima kerusakan fatal, segera memulihkan semua hidup dan mendapatkan penguatan sementara 80%, memanggil \"Pemain Awal\" di belakang, dapat memicu 2 kali."
  },
  State_81073_Name = {
    Text = "Empati Sarang: Fisi"
  },
  State_81278_Desc = {
    Text = "Setelah Geng pertama kali dilepaskan setiap putaran, semua Pembangun mendapatkan 10 Aliemus, tetapi Lelah pelepasan Geng meningkat secara permanen sebesar 10%."
  },
  State_81278_Name = {
    Text = "Inhibisi Kunci Perak"
  },
  State_81312_Desc = {
    Text = "Setelah menerima kerusakan fatal, mengembalikan semua kehidupan dan mendapatkan 50 lapisan penguatan sementara. Masih dapat memicu [Layer] kali."
  },
  State_81312_Name = {
    Text = "Reinkarnasi Kosmik"
  },
  State_81331_Desc = {
    Text = "Saat giliran dimulai, pilih 1 Pembangun, segel semua kartunya dan Muliakan selama 3 giliran."
  },
  State_81331_Name = {
    Text = "Penahanan Kesadaran"
  },
  State_81340_Desc = {
    Text = "Kartu ini disegel tidak dapat dimainkan, segel akan terlepas setelah [Layer] putaran."
  },
  State_81340_Name = {
    Text = "<Seal1:Penyegelan Kartu>"
  },
  State_81341_Desc = {
    Text = "Tubuh kebangkitan ini Aliemus Muliakan disegel tidak dapat digunakan, segel akan terlepas setelah [Layer] putaran."
  },
  State_81341_Name = {
    Text = "<Seal1:Selo Aliemus>"
  },
  State_81354_Desc = {
    Text = "Setelah dimainkan menerima kerusakan [DescArg1] poin, jika tidak dimainkan pada akhir giliran akan dikonsumsi."
  },
  State_81354_Name = {
    Text = "<BurningKeywords:Menjaga api>"
  },
  State_81356_Desc = {
    Text = "Memanfaatkan kartu untuk terbakar, setelah dimainkan menerima kerusakan [DescArg1] poin, jika kartu masih di tangan saat ronde berakhir, akan dikonsumsi."
  },
  State_81356_Name = {
    Text = "<BurningKeywords:Menjaga api>"
  },
  State_81356_WeaponDesc = {
    Text = "Setiap lapisan kelambatan meningkatkan kelelahan aritmetika kartu sebesar 1 poin."
  },
  State_83587_Desc = {
    Text = "Dapat meningkatkan efek saat memilih \"Berangkat berlayar\", maksimum 10 lapis."
  },
  State_83587_Name = {
    Text = "\"Mengatur Layarnya\""
  },
  State_83589_Desc = {
    Text = "Dapat meningkatkan efek saat memilih \"Berlabuh sejenak\", maksimum 10 lapis."
  },
  State_83589_Name = {
    Text = "Melempar Anker"
  },
  State_83593_Desc = {
    Text = "Kerusakan akhir yang disebabkan oleh semua tubuh bangun dalam ronde ini meningkat"
  },
  State_83593_Name = {Text = "Final DMG"},
  State_83596_Desc = {
    Text = "Batas kartu +1. Di awal giliran, jika dek tidak memiliki \"Pilihan Navigator\", letakkan itu ke tanganmu. Setiap kali pemimpin kehilangan 10% Kesehatan maksimum, dapatkan 1 lapisan \"Melaut\"; setiap kali dirimu kehilangan 10% Kesehatan maksimum, dapatkan 1 lapisan \"Mendekat\"."
  },
  State_83596_Name = {
    Text = "Petunjuk Erasmo - \"Mengangkat layar\""
  },
  State_83607_Desc = {
    Text = "Identifikasi kerugian kumulatif sepuluh persen dari nyawa kepala"
  },
  State_83607_Name = {
    Text = "Negara@indikator kehilangan 10% kesehatan bos terakumulasi"
  },
  State_83609_Desc = {
    Text = "Indikator kehilangan 10% kesehatan pemain terakumulasi"
  },
  State_83609_Name = {
    Text = "Negara@indikator kehilangan 10% kesehatan pemain terakumulasi"
  },
  State_83614_Desc = {
    Text = "Nilai darah 10% pemain"
  },
  State_83614_Name = {
    Text = "Negara@10% nilai darah pemain"
  },
  State_83615_Desc = {
    Text = "Setelah kehilangan [Layer] poin kehidupan, dapatkan 1 lapisan \"Melayani\"."
  },
  State_83615_Name = {
    Text = "\"Progres \"Melayang\"\""
  },
  State_83616_Desc = {
    Text = "Setelah kehilangan [Layer] poin kehidupan, dapatkan 1 lapisan \"Berlabuh\"."
  },
  State_83616_Name = {
    Text = "\"Progres \"Berlabuh\"\""
  },
  State_83617_Desc = {
    Text = "Kepala 10% dari nilai darah"
  },
  State_83617_Name = {
    Text = "Negara@10% nilai darah bos"
  },
  State_83618_Desc = {
    Text = "Saat pengujian, kesehatan saat ini adalah [Layer] poin"
  },
  State_83618_Name = {
    Text = "Hitungan hidup musuh saat ini"
  },
  State_83619_Desc = {
    Text = "Saat pengujian, kesehatan maksimum adalah [Layer] poin"
  },
  State_83619_Name = {
    Text = "Hitungan kesehatan maksimum musuh"
  },
  State_83620_Desc = {
    Text = "Nilai parameter 4 saat ini dikalikan 100 menjadi [Layer] poin."
  },
  State_83620_Name = {
    Text = "Parameter Print"
  },
  State_83621_Desc = {
    Text = "Kepala sepuluh persen dari nilai kerugian darah yang dihitung di tengah"
  },
  State_83621_Name = {
    Text = "Negara@perhitungan kehilangan nilai darah 10% bos"
  },
  State_83622_Desc = {
    Text = "Perhitungan kehilangan nilai darah 10% pemain"
  },
  State_83622_Name = {
    Text = "Negara@perhitungan kehilangan nilai darah 10% pemain"
  },
  State_83627_Desc = {
    Text = "Setelah kehilangan [DescArg1] poin kehidupan, dapatkan 1 lapisan \"Melayani\""
  },
  State_83627_Name = {
    Text = "\"Progres \"Melayang\"\""
  },
  State_83805_Name = {
    Text = "Gelombang Sisa"
  },
  State_83807_Name = {
    Text = "Tenggelam di Laut Jauh"
  },
  State_83808_Desc = {
    Text = "Kartu ini memicu efek \"Sisa\" saat dibuang."
  },
  State_83808_Name = {
    Text = "<RippleKeywords:Gema>"
  },
  State_83811_Desc = {
    Text = "Menanggung tambahan [Layer]% kerusakan tentakel."
  },
  State_83812_Desc = {
    Text = "Menanggung tambahan [Layer]% kerusakan tentakel."
  },
  State_83814_Desc = {
    Text = "Kepala 10% dari nilai darah"
  },
  State_83814_Name = {
    Text = "Kepala sepuluh persen dari nilai darah"
  },
  State_84140_Desc = {
    Text = "Pertempuran ini telah menghabiskan [Layer] kartu \"Pembelahan Kelenjar\" melalui \"Lautan Riuh\"."
  },
  State_84140_Name = {
    Text = "Samudera yang Ramai"
  },
  State_84184_Name = {
    Text = "Keterampilan ini menikmati tambahan kekuatan [Layer]%"
  },
  State_84255_Desc = {
    Text = "Tim unik: Pada awal Pertempuran, dapatkan Perisai yang setara dengan <WeaponEffect_Num:[StateArg1]%> dari Pertahanan pengguna sejata. Setelah Ketahanan dipicu, pada awal giliran berikutnya efek tersebut dipicu lagi."
  },
  State_84255_Name = {
    Text = "Navigator di Lautan"
  },
  State_84255_WeaponDesc = {
    Text = "Saat pertempuran dimulai, dapatkan <WeaponEffect_Num:[Block:DescArg1]> poin perisai. Setelah memicu ketahanan, efek ini akan diaktifkan kembali pada awal putaran berikutnya."
  },
  State_84257_Desc = {
    Text = "Tim Unik: Peningkatan Perisai yang dihasilkan oleh Muliakan pemakai sebesar <WeaponEffect_Num:[StateArg1]%>, setelah melepaskan Muliakan, semua Awakener mendapatkan peningkatan Crit. DMG Sementara sebesar <WeaponEffect_Num:[StateArg2]%>, dan setiap 1 Tentacle akan meningkatkan 1%. Setelah Ketahanan dipicu untuk pertama kali dalam eksplorasi, pada awal giliran berikutnya pulihkan <WeaponEffect_Num:[StateArg3]%> dari Max HP."
  },
  State_84257_WeaponDesc = {
    Text = "Peningkatan perisai yang dihasilkan oleh Exalt pemakai sebesar <WeaponEffect_Num:[StateArg1]%>, setelah melepaskan Exalt, semua Awakener mendapatkan peningkatan Crit. DMG Sementara sebesar <WeaponEffect_Num:[StateArg2]%,> setiap 1 Tentacle meningkatkan sebesar 1%. Setiap kali Ketahanan terpicu untuk pertama kalinya dalam eksplorasi, pada awal giliran berikutnya pulihkan <WeaponEffect_Num:[StateArg3]%> dari Max HP."
  },
  State_84272_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: pada akhir giliran, memulihkan nyawa teman yang kehilangan nyawa terbanyak <Heal:[Heal:StateArg1]>."
  },
  State_84272_Name = {
    Text = "Navigator di Lautan"
  },
  State_84273_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>：Saat dipasang dan pada awal giliran, jika tidak memiliki <PVPProtectiveKeywords:Penghalang> mendapatkan [StateArg1] lapisan <PVPProtectiveKeywords:Penghalang>, jika tidak, mendapatkan <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_84273_Name = {
    Text = "Navigator Dari Nyala APi"
  },
  State_84364_Desc = {
    Text = "Crit. DMG +[Layer]%."
  },
  State_84364_Name = {Text = "Crit. DMG"},
  State_84368_Desc = {
    Text = "Masih tersisa [Layer] putaran pendinginan."
  },
  State_84368_Name = {
    Text = "Tenggelam di Laut Jauh"
  },
  State_84375_Desc = {
    Text = "Pada awal giliran, mendapatkan [Layer] poin perisai."
  },
  State_84375_Name = {
    Text = "Navigator di Lautan"
  },
  State_84376_Desc = {
    Text = "Pada awal giliran, sembuh [Layer] poin hidup."
  },
  State_84376_Name = {
    Text = "Navigator Dari Nyala APi"
  },
  State_84399_Desc = {
    Text = "Setiap akhir putaran, kerusakan yang diterima meningkat sebesar 5%, dan mendapatkan 2 lapis penghalang."
  },
  State_84399_Name = {
    Text = "Tenggelam di Laut Jauh"
  },
  State_84400_Desc = {
    Text = "Saat putaran berikutnya dimulai, setiap lapisan penghalang akan bertransformasi menjadi 1 lapisan <ReinforcePVEKeywords:Diperkuat>."
  },
  State_84400_Name = {
    Text = "\"Navigator\""
  },
  State_84402_Desc = {
    Text = "Semua kerusakan yang diterima meningkat [Layer]%."
  },
  State_84402_Name = {
    Text = "Kekuatan Overdraw"
  },
  State_89340_Desc = {
    Text = "Menanggung tambahan [Layer]% kerusakan tentakel."
  },
  State_89340_Name = {
    Text = "Tentakel rentan"
  },
  State_89422_Desc = {
    Text = "Semua Pembangun menghasilkan Aliemus meningkat 100%, dapat melepas Muliakan 2 kali setiap giliran."
  },
  State_89422_Name = {
    Text = "\"Hati yang Tak Terbendung\""
  },
  State_89447_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Batas kartu tangan + [StateArg2]. Setelah「Exalt」dapatkan [StateArg1] aritmetika."
  },
  State_89447_Name = {
    Text = "Kebebasan yang Menyiksa"
  },
  State_89448_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Pada akhir giliran memberikan sekutu dengan HP dan perisai terendah [StateArg1] lembar<PVPDerivativeCardKeywords_16:「Bulu Hitam」>."
  },
  State_89448_Name = {
    Text = "Sehelai Bulu"
  },
  State_89554_Name = {
    Text = "Kerucut Cahaya Nasib"
  },
  State_89555_Desc = {
    Text = "Tim Unik: Setelah Pemakai melepaskan Exalt, Kerusakan Dasar Exalt meningkat sebesar <WeaponEffect_Num:[StateArg1]%>, Peningkatan Perisai dan pemulihan HP meningkat sebesar <WeaponEffect_Num:[StateArg2]%>, maksimal ditumpuk 5 kali. Affiniti yang diperoleh Pemakai dari eksplorasi meningkat sebesar <WeaponEffect_Num:[StateArg3]%>."
  },
  State_89555_WeaponDesc = {
    Text = "Setelah pemakai melepaskan Exalt, kerusakan dasar Exalt meningkat sebesar <WeaponEffect_Num:[StateArg1]%, peningkatan Perisai dan pemulihan HP sebesar <WeaponEffect_Num:[StateArg2]%, dapat ditumpuk hingga 5 kali. Setelah menyelesaikan eksplorasi, tingkat Affiniti yang diperoleh pemakai meningkat sebesar <WeaponEffect_Num:[StateArg3]%."
  },
  State_89557_Name = {
    Text = "Lensa Prismatis"
  },
  State_89559_Desc = {
    Text = "\n·Ada paradoks: Saat eksplorasi dimulai, 75% Ketahanan dikonversi menjadi bonus Max HP, maksimal mengonversi 300% Ketahanan, maksimal meningkatkan 10% Max HP. Setiap kali Ketahanan dipicu, tambahkan 1 kartu \"Silver Key Gleam\" ke tangan.\n·Luka tanpa dasar: Dalam Pertarungan Pemimpin, setiap kali jumlah HP yang dipulihkan pihak kami mencapai 100% batas HP, efek pemulihan HP yang diterima selanjutnya berkurang 25%, tetapi total Ketahanan saat ini meningkat 25%, maksimal dipicu 3 kali.\n·Lensa Prismatis: Pada awal giliran, jika Counter melebihi 2000% batas HP, stacks bagian yang melebihi dikurangi setengah, dan Counter permanen maksimal ditumpuk hingga 6000% batas HP; jika Racun musuh melebihi 3000% batas HP, stacks bagian yang melebihi dikurangi setengah, dan Racun maksimal ditumpuk hingga 9000% batas HP. Bonus Kerusakan yang diperoleh Awakener berdasarkan Counter berkurang 70%, tetapi semua Racun dan Counter yang ditimbulkan meningkat 10%. Setiap Awakener yang di-Awaken: Setelah akhir giliran, dapatkan Counter sementara sebesar 25% dari Counter permanen saat ini, dan pada akhir giliran musuh, picu tambahan 25% Racun pada semua musuh.\n·Kerucut Cahaya Nasib: Jumlah giliran monster biasa melepaskan \"Tatapan\" menjadi 6 giliran. Pada awal giliran ke-15, masukkan 1 kartu \"Garis Batas Cahaya\" ke tangan: Isi Keyflare dan Aliemus semua Awakener hingga nilai maksimum."
  },
  State_89559_Name = {
    Text = "Distorsi Ruang Waktu"
  },
  State_89567_Desc = {
    Text = "Kartu ini mengonsumsi -[StateArg1] Aritmetika."
  },
  State_89567_Name = {
    Text = "Kelahiran Ulang di Tanah yang Musnah"
  },
  State_89568_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>：setelah pemakainya mati, semua \"Keterampilan\" dengan Lelah Aritmetika -[StateArg1] akan dicampur ke dalam tumpukan Menggambar, dan kepemilikannya akan beralih ke teman dengan Hidup tersisa tertinggi."
  },
  State_89568_Name = {
    Text = "Kelahiran Ulang di Tanah yang Musnah"
  },
  State_89571_Name = {
    Text = "\"Teater yang Terbakar\""
  },
  State_89572_Desc = {
    Text = "Pada awal giliran, secara acak tambahkan [DescArg1] kartu di tumpukan lawan dengan <BurningKeywords: terbakar>, dan dapatkan [DescArg2] poin kekuatan sementara. Setiap 2 giliran, jumlah kartu yang terbakar yang ditambahkan meningkat 1, kekuatan sementara yang diperoleh meningkat [DescArg3] poin."
  },
  State_89572_Name = {
    Text = "\"Teater yang Terbakar\""
  },
  State_89626_Desc = {
    Text = "Setelah bangkit kunci perak, letakkan 1 kartu \"Cahaya Kunci Perak\" di tangan. Setelah semua kebangkitan pembangun selesai, temukan 1 kartu pembangun secara acak di awal setiap putaran."
  },
  State_89631_Desc = {
    Text = "Lompatan tambahan [Layer] kali"
  },
  State_89634_Desc = {
    Text = "Membangkitkan Gnosis 4"
  },
  State_89634_Name = {
    Text = "Membangkitkan Gnosis 4"
  },
  State_89637_Desc = {
    Text = "Kartu perintah pertama setiap putaran akan aktif tambahan 1 kali. Saat menghilang, 1 tentakel akan muncul. Setelah beralih ke posisi \"Guntur\", efek lompatan dari 2 kartu perintah di putaran ini pasti akan diaktifkan dan memasuki ruang ultra, cooldown 3 putaran."
  },
  State_89640_Desc = {
    Text = "Kepakaran alam meningkat 200 poin. Saat menggunakan Dapur merah, meningkatkan kerusakan tentakel sebesar 15% setiap kali habis. Setiap serangan tentakel, kumpulkan [Arg3] poin Dapur merah."
  },
  State_89642_Desc = {
    Text = "Batas kartu +2, setelah melepaskan Muliakan, kerusakan akhir sementara meningkat 10%. Setelah kartu memasuki ruang Ultra, ubah 1 \"Embrio\" di tangan menjadi \"Anak Suci\". Setiap kali menghasilkan 1 \"Embrio\", biaya aritmetika dari satu kartu acak di ruang Ultra berkurang 1."
  },
  State_89669_Desc = {
    Text = "Kunci perak Bangkit 4"
  },
  State_89669_Name = {
    Text = "Kunci perak Bangkit 4"
  },
  State_89759_Desc = {
    Text = "Setelah melepaskan Geng, Ramona mendapat 50% Crit. Rate sementara."
  },
  State_89759_Name = {
    Text = "Ikatan Berharga"
  },
  State_90023_Name = {
    Text = "Status yang digunakan untuk pengaturan tabel konstan telah dibuang untuk sementara."
  },
  State_90059_Desc = {
    Text = "Saat menerima kerusakan aktif atau tentakel dalam ronde ini, hapus Erosi dalam jumlah yang sama dan kehilangan [DescArg1]% hidup dari jumlah yang dihapus, saat menerima kerusakan lainnya hanya akan menghapus 50% jumlah kerusakan dari Erosi."
  },
  State_90059_Name = {Text = "Corrosion"},
  State_90094_Name = {
    Text = "Helaian Bulu Onyx"
  },
  State_90218_Desc = {
    Text = "Keberanian unik tim: batas atas kartu +2, efek serupa tidak bisa bertumpuk. Pengguna meningkatkan perisai dan kerusakan dasar yang dihasilkan <WeaponEffect_Num:[StateArg1]%>, setelah memasuki putaran ultra akan mendapatkan <WeaponEffect_Num:[StateArg2]> poin Aliemus. Setelah melepaskan\"Penghapusan\"semua Pembangun sementara mendapatkan kerusakan kritis +<WeaponEffect_Num:[StateArg3]%>, cooldown 3 putaran."
  },
  State_90218_WeaponDesc = {
    Text = "Batas kartu di tangan +2, efek sejenis tidak dapat ditumpuk. Kerusakan dasar dan perisai yang ditimbulkan oleh pemakai meningkat <WeaponEffect_Num:[StateArg1]%>, setelah memasuki giliran ultra, memperoleh <WeaponEffect_Num:[StateArg2]> poin Aliemus. Setelah melepaskan\"Penghapusan\", semua Pembangun mendapatkan kerusakan kritis sementara +<WeaponEffect_Num:[StateArg3]%>, cooldown 3 giliran."
  },
  State_90221_Desc = {
    Text = "Tim Unik: Perisai yang dihasilkan oleh pembawa meningkat <WeaponEffect_Num:[StateArg1]%>, mendapatkan perisai berdasarkan  <WeaponEffect_Num:[StateArg2]%> dari pertahanan pembawa pada akhir putaran, dan kekuatan pertahanan meningkat 2％ setiap putaran."
  },
  State_90221_Name = {
    Text = "Sehelai Bulu"
  },
  State_90221_WeaponDesc = {
    Text = "Perisai yang diberikan oleh pemakainya meningkat <WeaponEffect_Num:[StateArg1]%>, pada akhir putaran dapatkan <WeaponEffect_Num:[Block:DescArg1]> poin perisai."
  },
  State_90294_Desc = {
    Text = "Saat menerima kerusakan aktif atau tentakel dalam ronde ini, hapus Erosi dalam jumlah yang sama dan kehilangan [DescArg1]% hidup dari jumlah yang dihapus, saat menerima kerusakan lainnya hanya akan menghapus 50% jumlah kerusakan dari Erosi."
  },
  State_90294_Name = {
    Text = "<Corrosion:Korosi>"
  },
  State_90591_Name = {
    Text = "Letakkan [Layer] \"Inspirasi\" di tangan"
  },
  State_90594_Name = {
    Text = "Dengan [Layer] bersiaga sementara"
  },
  State_90599_Name = {
    Text = "Memberikan semua Pembangun yang terbangun [Layer] poin kemarahan"
  },
  State_90600_Name = {
    Text = "Mendapatkan [Layer] poin Energi-s"
  },
  State_90601_Name = {
    Text = "(Sisa [DescArg1] kali<harmonyKeyWord:\"Harmoni\">)"
  },
  State_90603_Name = {
    Text = "Mendapatkan [Layer] poin kekuatan sementara"
  },
  State_90604_Name = {
    Text = "Restorasi [Layer] poin hidup, meningkat sesuai dengan poin hidup yang hilang"
  },
  State_90696_Desc = {
    Text = "Sebelum dimainkan, temukan 1 rasa \"Bumbu\" dan masukkan ke dalamnya untuk memicu efeknya, menambah 1 kali penggabungan dalam pertarungan melawan pemimpin."
  },
  State_90696_Name = {
    Text = "<harmonyKeyWord:penyelarasan>"
  },
  State_91106_Desc = {
    Text = "Setiap lapisan Kegilaan menyebabkan kerusakan aktif dan kerusakan tentakel yang menyertakan 10% kerusakan setara dengan <BleedingIconKeywords: keluar berdarah>."
  },
  State_91106_Name = {Text = "Kegilaan"},
  State_91165_Name = {
    Text = "Telur Pucat"
  },
  State_91235_Desc = {
    Text = "Saat kehilangan HP, kurangi stacks dalam jumlah yang sama. Saat stacks luka mencapai 0, semua Awakener mendapatkan 10 Aliemus, reset stacks luka."
  },
  State_91235_Name = {Text = "Cedera"},
  State_91236_Name = {
    Text = "Acara Roma mengaplikasikan penghitung kehidupan pemimpin"
  },
  State_91329_Desc = {
    Text = "Kartu ini mengonsumsi -[StateArg1] Aritmetika."
  },
  State_91329_Name = {
    Text = "Kelezatan yang Mengerikan"
  },
  State_91521_Desc = {
    Text = "<PVPWeaponKeywords:Roda Takdir>: Saat giliran berakhir, masukkan [StateArg1] <PVPDerivativeCardKeywords_17:「Inspirasi」> ke tangan."
  },
  State_91521_Name = {
    Text = "Pelatihan Intensif Rekan"
  },
  State_91522_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Saat dipasang dan di akhir giliran, pemakai menyebabkan <Damage:[Damage:StateArg1]> kerusakan pada musuh di barisan belakang."
  },
  State_91522_Name = {
    Text = "Hari Pembukaan Sekolah"
  },
  State_91676_Desc = {
    Text = "Efek spesifik lihat logika pukulan umum.__\"Khusus pengembangan\""
  },
  State_91706_Desc = {
    Text = "Memperoleh jumlah lapisan dengan nilai yang sama dari aritmetika pada awal ronde berikutnya."
  },
  State_91706_Name = {
    Text = "<CardKeyWord:Pertahankan Aritmetika>"
  },
  State_91717_Desc = {
    Text = "Maksimal menumpuk hingga 3, setelah mencapai batas, \"Necrotic Gala\" berikutnya dapat mengonsumsinya dan meningkatkan efeknya. Sisa-sisa akan dibawa ke pertempuran berikutnya."
  },
  State_91717_Name = {Text = "Reruntuhan"},
  State_91759_Desc = {
    Text = "Bulu Hitam dapat meningkatkan kemampuan \"Anak Suci·Bulu Hitam\"."
  },
  State_91759_Name = {
    Text = "Helaian Bulu Onyx"
  },
  State_91761_Desc = {
    Text = "50% dari perisai yang belum dihancurkan oleh‘Putra Suci·Bulu Hitam’akan dipertahankan hingga putaran berikutnya, setelah putaran berakhir, akan mendapatkan 1 lapisan<Guaiwuheiyu:Bulu Hitam>."
  },
  State_91761_Name = {
    Text = "Keinginan Terbang Tinggi"
  },
  State_91797_Desc = {
    Text = "Setelah kartu ini dimainkan dan setelah dibuang, berikan perisai dengan jumlah lapisan yang sama kepada musuh di barisan depan."
  },
  State_91797_Name = {
    Text = "<PVPredKeyword:Kesakitan Tersembunyi>"
  },
  State_91799_Desc = {
    Text = "Setelah kartu ini dimainkan, berikan [Layer] perisai kepada musuh di barisan depan."
  },
  State_91799_Name = {
    Text = "<PVPredKeyword:Kesakitan Tersembunyi [Layer] >"
  },
  State_91809_Desc = {
    Text = "Biaya konsumsi kartu ini -[Layer]."
  },
  State_91809_Name = {
    Text = "Fokuskan Roh"
  },
  State_91819_Desc = {
    Text = "Mendapatkan perubahan yang sesuai berdasarkan jumlah ronde pertempuran saat ini."
  },
  State_91819_Name = {
    Text = "<CardKeyWord:Berkembang>"
  },
  State_91827_Desc = {
    Text = "‘Serangan’ dapat memilih target, sebelum ‘serangan’ semua status positif target akan dipindahkan ke belakang bangun."
  },
  State_91827_Name = {
    Text = "<CardKeyWord:Panggilan Aequor>"
  },
  State_94410_Name = {
    Text = "Setiap kali ronde dimulai dan setelah aksi berakhir, akan berusaha mereset dek pemain yang kosong, jika tidak kosong maka tidak akan direset.__\"Hanya untuk pengembangan\""
  },
  State_94411_Name = {
    Text = "Setiap kali ronde dimulai dan setelah aksi berakhir, akan berusaha mereset dek pemain yang kosong, jika tidak kosong maka tidak akan direset.__\"Hanya untuk pengembangan\""
  },
  State_94426_Name = {
    Text = "Perisai Pasif__\"Khusus pengembangan\""
  },
  State_94540_Desc = {
    Text = "Jika tidak ada Pembangun lain di belakang target, maka hilangkan status di depan target."
  },
  State_94540_Name = {
    Text = "<CardKeyWord:Repel Status Positif>"
  },
  State_94600_Desc = {
    Text = "Setelah menerima kerusakan fatal, menghapus 1 lapisan dan mengembalikan 5% kesehatan maksimum, setiap kali efek diaktifkan, jumlah pemulihan meningkat 1% untuk putaran ini."
  },
  State_94600_Name = {Text = "Ketahanan"},
  State_94603_Name = {
    Text = "Tanda Zombi"
  },
  State_94608_Name = {
    Text = "Jumlah pemicu Ketahanan terhadap kematian"
  },
  State_94623_Desc = {
    Text = "Setiap lapisan Kegilaan menyebabkan kerusakan aktif dan kerusakan tentakel yang menyertakan 10% kerusakan setara dengan <BleedingIconKeywords: keluar berdarah>."
  },
  State_94623_Name = {
    Text = "<Kuangre:Aliemus>"
  },
  State_94657_Desc = {
    Text = "Ketika membunuh atau memicu efek kebangkitan musuh, aktifkan efek yang sesuai"
  },
  State_94657_Name = {
    Text = "<KillKeywords:Kalahkan>"
  },
  State_94692_Desc = {
    Text = "Setelah menerima kerusakan fatal, menghapus 1 lapisan dan mengembalikan 5% kesehatan maksimum, setiap kali efek diaktifkan, jumlah pemulihan meningkat 1% untuk putaran ini."
  },
  State_94692_Name = {
    Text = "<Guaiwusiwangdikang: Ketahanan terhadap Kematian>"
  },
  State_94693_Desc = {
    Text = "Saat giliran dimulai, jika ada sekutu lain, kehilangan [DescArg1] poin kehidupan, menambah 1 lapisan <Guaiwusiwangdikang: Ketahanan terhadap Kematian> dan [DescArg2] poin <PowerIconKeywords: Kekuatan> pada sekutu dengan kehidupan tertinggi."
  },
  State_94693_Name = {
    Text = "Konsumsi bangkai"
  },
  State_94708_Desc = {
    Text = "Saat giliran dimulai, jika ada sekutu lain, kehilangan [DescArg1] poin kehidupan, menambah 1 lapisan <Guaiwusiwangdikang: Ketahanan terhadap Kematian> dan [DescArg2] poin <Duren: Racun Pedang>."
  },
  State_94708_Name = {
    Text = "Makan bersama di laut dalam"
  },
  State_94730_Desc = {
    Text = "Saat mengakibatkan kerusakan aktif yang tidak diblokir, menambahkan [Layer] poin<IntoxicationIconKeywords: Racun>."
  },
  State_94730_Name = {
    Text = "Pedang Beracun"
  },
  State_94993_Desc = {
    Text = "Mengatur ulang jumlah\"Gelombang Mengamuk\"setiap putaran."
  },
  State_94993_Name = {
    Text = "Reset jumlah gelombang menghancurkan"
  },
  State_94994_Desc = {
    Text = "Setiap lapisan menambah 1 serangan, kehilangan 1 lapisan saat menerima Crit. DMG, minimal 1 lapisan, dan kehilangan semua lapisan di akhir putaran."
  },
  State_94994_Name = {
    Text = "Jumlah gelombang menghancurkan"
  },
  State_94995_Desc = {
    Text = "Setiap kali terkena Crit. DMG, dapatkan 3% <Baojidikang:ketahanan kritis sementara>. Setiap kali menyebabkan kerusakan, akan menambahkan \"Tanda Selam Dalam\" pada satu kartu acak."
  },
  State_94995_Name = {
    Text = "Upacara Pengorbanan Laut Dalam"
  },
  State_94996_Desc = {
    Text = "Mendapatkan kekuatan sementara dalam jumlah yang sama saat diserang."
  },
  State_94996_Name = {Text = "Fury"},
  State_94997_Desc = {
    Text = "Setiap kali terkena Crit. DMG, dapatkan 5% <Baojidikang:ketahanan kritis sementara>. Setiap kali menyebabkan kerusakan, akan menambahkan \"Tanda Selam Dalam\" pada satu kartu acak."
  },
  State_94997_Name = {
    Text = "Upacara Pengorbanan Laut Dalam"
  },
  State_94998_Desc = {
    Text = "Ketika <Guaiwusiwangdikang: Ketahanan> dipicu, terapkan <SlowIconKeywords: Penundaan> pada satu kartu acak di tumpukan menarik atau tangan."
  },
  State_94998_Name = {
    Text = "Incarnasi Desperasi"
  },
  State_94999_Desc = {
    Text = "Mengatur ulang jumlah\"Gelombang Raksasa\"setiap putaran."
  },
  State_94999_Name = {
    Text = "Reset Jumlah Gelombang yang Menggigit Langit"
  },
  State_95000_Desc = {
    Text = "Imunitas terhadap negara negatif."
  },
  State_95000_Name = {
    Text = "Imunitas terhadap kondisi negatif"
  },
  State_95001_Desc = {
    Text = "Setiap lapisan menambah 1 serangan, kehilangan 1 lapisan saat menerima Crit. DMG, minimal 1 lapisan, dan kehilangan semua lapisan di akhir putaran."
  },
  State_95001_Name = {
    Text = "Jumlah Gelombang yang Menggigit Langit"
  },
  State_95002_Desc = {
    Text = "Peluang kritis yang diterima dalam ronde ini berkurang [Layer]%."
  },
  State_95002_Name = {
    Text = "Ketahanan kritis sementara"
  },
  State_95002_WeaponDesc = {
    Text = "Peluang kritis yang diterima dalam ronde ini berkurang [Layer]%."
  },
  State_95035_Desc = {
    Text = "Saat mengakibatkan kerusakan aktif yang tidak diblokir, setiap 1 lapisan menambahkan 1 poin<IntoxicationIconKeywords: Racun>."
  },
  State_95035_Name = {
    Text = "<Duren: Baling Beracun>"
  },
  State_95038_Desc = {
    Text = "Mendapatkan kekuatan sementara dalam jumlah yang sama saat diserang."
  },
  State_95038_Name = {
    Text = "<Kuangbao: Keterpurukan>"
  },
  State_95040_Desc = {
    Text = "Catatan telah kehilangan hidup"
  },
  State_95040_Name = {
    Text = "Catatan telah kehilangan hidup"
  },
  State_95932_Name = {
    Text = "Menyerap Zombie menunggu"
  },
  State_95937_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Exalt\" tarik [StateArg1] kartu, prioritaskan menarik kartu \"Keterampilan\" milik sendiri, dan konsumsi aritmetika - [StateArg2]."
  },
  State_95937_Name = {
    Text = "Kelezatan yang Mengerikan"
  },
  State_95938_Desc = {
    Text = "Setiap kali menghapus satu kartu, lapisan kepuasan +1, maksimum 10 lapisan"
  },
  State_95938_Name = {Text = "Kenyang"},
  State_95943_Desc = {
    Text = "Kerusakan yang dihasilkan sementara berkurang 30%."
  },
  State_95943_Name = {
    Text = "Interferensi positif"
  },
  State_95944_Desc = {
    Text = "Keberanian unik tim: pengguna meningkatkan kerusakan dasar yang dihasilkan <WeaponEffect_Num:[StateArg1]%>, setiap kali melakukan satu pembunuhan akan meningkatkan tingkat kritis pengguna dalam eksplorasi ini sebesar 2% dan kerusakan dasar yang dihasilkan oleh Muliakan meningkat <WeaponEffect_Num:[StateArg2]%>, maksimal bertumpuk 10 kali. Jika alam saat ini adalah\"Caro\", saat\"Embrio\"digunakan langsung pada pengguna, akan mendapatkan tambahan <WeaponEffect_Num:[StateArg4]> poin Aliemus, cooldown 3 putaran."
  },
  State_95944_WeaponDesc = {
    Text = "Meningkatkan kerusakan dasar yang dihasilkan oleh pemegang sebesar <WeaponEffect_Num:[StateArg1]>. Setiap kali membunuh, meningkatkan tingkat kritis pemegang sebesar 2% dalam eksplorasi ini, dan meningkatkan kerusakan dasar dari ledakan kegilaan sebesar <WeaponEffect_Num:[StateArg2]%>, maksimum dapat ditumpuk 10 kali. Jika dimensi saat ini adalah \"Caro\", saat menggunakan \"embrio\" langsung pada pemegang, akan mendapatkan tambahan <WeaponEffect_Num:[StateArg4]> poin kegilaan, cooldown 3 putaran."
  },
  State_95948_Name = {
    Text = "Menyerap Zombie"
  },
  State_95949_Desc = {
    Text = "Setelah menyerang, membuat Dulzaim kehilangan setengah<Guaiwucanhai:fragmen>."
  },
  State_95949_Name = {
    Text = "Cadangan serangan mendadak"
  },
  State_95953_Desc = {
    Text = "Efek penyembuhan hidup dari ketahanan terhadap kematian ditingkatkan 5 kali."
  },
  State_95953_Name = {
    Text = "Kain Penutup Mimpi"
  },
  State_95954_Name = {
    Text = "Menyerap Zombie versi bangu"
  },
  State_95960_Desc = {
    Text = "Jumlah reruntuhan akan meningkatkan efek\"Pengambilan reruntuhan\"."
  },
  State_95960_Name = {Text = "Reruntuhan"},
  State_95962_Name = {
    Text = "Jumlah Pembunuhan__\"Hanya untuk pengembangan\""
  },
  State_95964_Desc = {
    Text = "Keberanian unik tim: pengguna meningkatkan kerusakan dasar yang dihasilkan <WeaponEffect_Num:[StateArg1]%>. Jika alam saat ini adalah\"Caro\", saat pengguna membunuh musuh akan mengumpulkan Dapur merah seratus serangan pengguna <WeaponEffect_Num:[StateArg2]%>."
  },
  State_95964_WeaponDesc = {
    Text = "Meningkatkan kerusakan dasar yang dihasilkan oleh pemegang sebesar <WeaponEffect_Num:[StateArg1]%>. Jika dimensi saat ini adalah \"Caro\", saat pemegang membunuh musuh, mengumpulkan <WeaponEffect_Num:[DescArg1]> poin dapur merah."
  },
  State_95966_Desc = {
    Text = "Saat awal giliran berikutnya, tarik [Layer] kartu dari kartu pembangun tersebut."
  },
  State_95966_Name = {
    Text = "Penghormatan Kejam"
  },
  State_95967_Desc = {
    Text = "Jumlah reruntuhan akan meningkatkan efek\"Pengambilan reruntuhan\"."
  },
  State_95967_Name = {
    Text = "<Guaiwucanhai: Sisa>"
  },
  State_95968_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>：Saat dipasang mendapatkan [StateArg1] <StrongEffectKeywords:Kuat>。Kerusakan yang melimpah saat membunuh musuh akan diteruskan ke Pembangun di belakang."
  },
  State_95968_Name = {
    Text = "Kecupan Ketenteraman"
  },
  State_96167_Desc = {
    Text = "Tidak dapat dihilangkan, setelah Pembangun dibunuh, sekutu lainnya mendapatkan [StateArg1] <StrongEffectKeywords:Kuat>."
  },
  State_96167_Name = {
    Text = "Abu Api Bintang Hitam"
  },
  State_96183_Desc = {
    Text = "Saat giliran berakhir, jika tidak ada sekutu lain di lapangan, ubah niat menjadi bunuh diri"
  },
  State_96183_Name = {
    Text = "Pembunuhan Diri Ghoul"
  },
  State_96193_Name = {
    Text = "Etika sebelum makan"
  },
  State_96330_Desc = {
    Text = "Setiap kehilangan 1% kesehatan, kartu perintah Duresein meningkatkan kerusakan dasar, perisai, dan kegilaan sebesar 1%."
  },
  State_96330_Name = {
    Text = "Bisikan Hantu"
  },
  State_96352_Name = {
    Text = "Penghitungan kanibal yang pertama"
  },
  State_96354_Name = {
    Text = "Kesehatan maksimum awal"
  },
  State_96355_Desc = {
    Text = "Mendapatkan pengurangan peluang kritis [Layer] %."
  },
  State_96355_Name = {
    Text = "Crit. Resistance"
  },
  State_96355_WeaponDesc = {
    Text = "Peluang kritis yang diterima dalam pertarungan ini berkurang [Layer]%."
  },
  State_96356_Desc = {
    Text = "Setiap kehilangan [DescArg1] poin hidup, mendapatkan [DescArg2] lapisan<ReinforcePVEKeywords:Diperkuat>, maksimal [DescArg3] lapisan. Setelah memicu \"<Guaiwusiwangdikang:Ketahanan>\", maksimum hidup diri sendiri meningkatkan [DescArg4] %."
  },
  State_96356_Name = {
    Text = "Perlindungan Ilaine"
  },
  State_96357_Desc = {
    Text = "Setelah ronde berakhir, dapatkan lapisan Kekuatan dalam jumlah yang sama."
  },
  State_96357_Name = {
    Text = "<Fennu: Kemarahan>"
  },
  State_96358_Desc = {
    Text = "Mendapatkan pengurangan peluang kritis [Layer] %."
  },
  State_96358_Name = {
    Text = "<Baojidikang: Resistansi serangan kritis>"
  },
  State_96412_Name = {
    Text = "Mendengarkan Tian-Tia"
  },
  State_96416_Desc = {
    Text = "Mendapatkan pengurangan peluang kritis [Layer] %."
  },
  State_96416_Name = {
    Text = "Crit. Resistance"
  },
  State_96603_Name = {
    Text = "Jika tidak dimainkan pada giliran ini, terpicu 1 kali efek \"harmoni\" di awal giliran berikutnya"
  },
  State_96610_Name = {
    Text = "Resistensi kematian pertama"
  },
  State_96613_Name = {
    Text = "Gelombang besar mendengarkan"
  },
  State_96650_Desc = {
    Text = "Setiap lapisan meningkatkan Crit. Rate semua Awakener sebesar [DescArg1]%."
  },
  State_96650_Name = {
    Text = "<ExclamationPointColour:Api Kegelapan>"
  },
  State_96719_Desc = {
    Text = "Saat memainkan kartu <BurningKeywords:Terbakar> di ronde ini, menghabiskan 1 lapisan <Heat:Api Kegelapan> untuk mengaktifkannya 2 kali, dan kosongkan <Heat:Api Kegelapan> setelah ronde berakhir."
  },
  State_96719_Name = {
    Text = "Api Ledakan Tanpa Akhir"
  },
  State_96731_Desc = {
    Text = "Saat memainkan kartu <BurningKeywords:Terbakar> di ronde ini, menghabiskan 1 lapisan <Heat:Api Kegelapan> untuk mengaktifkannya 2 kali, dan kosongkan <Heat:Api Kegelapan> setelah ronde berakhir."
  },
  State_96731_Name = {
    Text = "<Overload:Api Ledakan Tanpa Akhir>"
  },
  State_96732_Desc = {
    Text = "Setiap lapisan meningkatkan Crit. Rate semua Awakener sebesar [DescArg1]%."
  },
  State_96732_Name = {
    Text = "<Heat:Api Kegelapan>"
  },
  State_96740_Desc = {
    Text = "Kerusakan serangan aktif yang diterima dan lapisan pendarahan meningkat sebesar 50%, dihilangkan saat menerima kerusakan atau pada awal giliran."
  },
  State_96740_Name = {
    Text = "<CardKeyWord:Celah>"
  },
  State_96741_Desc = {
    Text = "Setelah dimainkan, jika sisa Arithmetica lebih besar dari [StateArg1], konsumsi tambahan [StateArg1] Arithmetica untuk memicu efek lanjutan.__\"仅开发用\""
  },
  State_96741_Name = {
    Text = "<CardKeyWord:Aritmetika berlebihan>__\"仅开发用\""
  },
  State_96742_Name = {
    Text = "Tanda Pemicu Kelebihan Beban Arithmetika__\"仅开发用\""
  },
  State_96743_Desc = {
    Text = "Setelah dimainkan, jika sisa Aritmetika lebih besar dari Aritmetika yang dibutuhkan untuk kelebihan beban, konsumsi tambahan Aritmetika untuk memicu efek lanjutan."
  },
  State_96743_Name = {
    Text = "<CardKeyWord:Aritmetika berlebihan>"
  },
  State_96744_Desc = {
    Text = "Kerusakan serangan aktif yang diterima dan lapisan pendarahan meningkat sebesar 50%, dihilangkan saat menerima kerusakan atau pada awal giliran."
  },
  State_96744_Name = {Text = "Falter"},
  State_96774_Desc = {
    Text = "Setiap kali menerima Crit. DMG, dapatkan 3% pertahanan kritis sementara."
  },
  State_96774_Name = {
    Text = "Roh Penghuni Laut Dalam"
  },
  State_96780_Desc = {
    Text = "Kartu mendapatkan ditahan, tetapi akan menghapus kontaminasi setelah dimainkan atau dibuang dan memanggil 1 \"Gumpalan Laut Dalam\", maksimal 2. Jika tidak ada ruang untuk memanggil, akan langsung membuat Boneka Gelombang Busuk mendapatkan [DescArg1] poin kekuatan dan [DescArg2] poin kehidupan."
  },
  State_96780_Name = {
    Text = "<Kuangluan:Kegilaan Pelaut>"
  },
  State_96783_Desc = {
    Text = "Setiap giliran tambahkan \"<Kuangluan:Kegilaan Pelaut>\" pada 2 kartu."
  },
  State_96783_Name = {
    Text = "Ritual Pelaut"
  },
  State_96784_Desc = {
    Text = "Dapat mengurangi serangan Sosok Pasang Kebusukan, maksimal 5 lapisan."
  },
  State_96784_Name = {Text = "Kaos"},
  State_96808_Desc = {
    Text = "Setiap kehilangan [DescArg1] hidup, mendapatkan 15 lapisan \" <ReinforcePVEKeywords:Diperkuat>\", dengan batas 75 lapisan, setelah dihancurkan kosongkan dan dapatkan 1 lapisan \" <Chaos:Kekacauan>\". Jika tidak pernah menggunakan \"Daging Tulang Rekonstruksi\", saat menerima kerusakan fatal, niat akan beralih ke \"Daging Tulang Rekonstruksi\" dan menjadi kebal terhadap semua kerusakan."
  },
  State_96808_Name = {
    Text = "\"Golem Chimaera\""
  },
  State_96809_Name = {
    Text = "Penghitungan boneka yang terpasang"
  },
  State_96810_Desc = {
    Text = "Kerusakan yang dihasilkan menurun sebesar 25%."
  },
  State_96810_Name = {
    Text = "Kain Penutup Mimpi"
  },
  State_96813_Name = {
    Text = "Tanda Restrukturisasi"
  },
  State_97114_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>:\"Serangan\" mendapatkan [StateArg1] daya komputasi，kerusakan \"Keterampilan\" meningkat [StateArg2]%."
  },
  State_97114_Name = {
    Text = "Matahari yang Mendekat"
  },
  State_97118_Name = {
    Text = "Pukulan boneka yang terpasang"
  },
  State_97119_Desc = {
    Text = "Kartu mendapatkan ditahan, tetapi akan menghapus kontaminasi setelah dimainkan atau dibuang dan memanggil 1 \"Gumpalan Laut Dalam\", maksimal 2. Jika tidak ada ruang untuk memanggil, akan langsung membuat Boneka Gelombang Busuk mendapatkan [DescArg1] poin kekuatan dan [DescArg2] poin kehidupan."
  },
  State_97119_Name = {
    Text = "<Kuangluan:Kegilaan Pelaut>"
  },
  State_97120_Desc = {
    Text = "Dilindungi oleh lingkaran sihir, semua kerusakan yang ditimbulkan oleh musuh berkurang 25%."
  },
  State_97120_Name = {
    Text = "Kain Penutup Mimpi"
  },
  State_97131_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setiap 1 Arithmetica yang dikonsumsi \"Skill\", Kerusakan ditingkatkan [StateArg1]%. Setelah melakukan Bunuh, Kerusakan yang ditimbulkan \"Exalt\" ditingkatkan [StateArg2]%, bonus saat ini [DescArg1]%."
  },
  State_97131_Name = {
    Text = "Kematian berwarna amber"
  },
  State_97134_Desc = {
    Text = "Kerusakan akhir yang dihasilkan meningkat sebesar 50%."
  },
  State_97134_Name = {
    Text = "Nyanyian Selene"
  },
  State_97135_Desc = {
    Text = "Kerusakan akhir yang dihasilkan meningkat sebesar 25%."
  },
  State_97135_Name = {
    Text = "Bisikan Selene"
  },
  State_97136_Desc = {
    Text = "Kerusakan akhir yang dihasilkan meningkat sebesar 100%."
  },
  State_97136_Name = {
    Text = "Lagu Keras Selene"
  },
  State_97137_Desc = {
    Text = "Buang kemudian kembali ke tangan."
  },
  State_97137_Name = {
    Text = "Buang kemudian kembali ke tangan"
  },
  State_97137_WeaponDesc = {
    Text = "Mengakibatkan Kelemahan pada diri sendiri selama 1 ronde saat ditarik. Setelah digunakan, semua musuh akan mengalami Kelemahan selama 1 ronde. Tidak dapat dijual."
  },
  State_97219_Desc = {
    Text = "[Layer] kartu berikutnya yang dimainkan Wanda aktif 1 kali tambahan."
  },
  State_97219_Name = {Text = "Ratu Duri"},
  State_97251_Desc = {
    Text = "·Tidak akan menjadi target prioritas untuk serangan musuh, dan musuh tidak dapat memilih tubuh bangun menyelinap saat memilih target individu.\n·Ketika mendapatkan menyelinap, hilangkan pengalihan diri sendiri dan menyelinap dari teman lain. Jika tidak ada teman lain atau musuh mendapatkan pengalihan, hilangkan menyelinap."
  },
  State_97251_Name = {
    Text = "Sembunyi-sembunyi"
  },
  State_97252_Desc = {
    Text = "·Tidak akan menjadi target prioritas untuk serangan musuh, dan musuh tidak dapat memilih tubuh bangun menyelinap saat memilih target individu.\n·Ketika mendapatkan menyelinap, hilangkan pengalihan diri sendiri dan menyelinap dari teman lain. Jika tidak ada teman lain atau musuh mendapatkan pengalihan, hilangkan menyelinap."
  },
  State_97252_Name = {
    Text = "<PVPSneakKeywords:Pengendapan>"
  },
  State_97339_Name = {
    Text = "Piala juara Mythag"
  },
  State_97742_Desc = {
    Text = "Setiap kali menerima Active DMG, berikan [Layer] poin <FixedDamage:Kerusakan Murni> kepada sumber kerusakan."
  },
  State_97742_Name = {Text = "Counter"},
  State_97743_Desc = {
    Text = "Kerusakan aktif yang dihasilkan meningkat sebesar [Layer] poin."
  },
  State_97743_Name = {
    Text = "<PowerColourKeywords:Kekuatan>"
  },
  State_97744_Desc = {
    Text = "Semua kerusakan yang diterima berkurang [Layer] %."
  },
  State_97744_Name = {
    Text = "<ReinforceColour:Diperkuat>"
  },
  State_97744_WeaponDesc = {
    Text = "Semua kerusakan yang ditimbulkan berkurang sebesar [DescArg1]%."
  },
  State_97938_Desc = {
    Text = "Kerusakan akhir meningkat [DescArg1]%."
  },
  State_97938_Name = {
    Text = "Piala juara Mythag"
  },
  State_97939_Desc = {
    Text = "Kerusakan akhir yang dihasilkan meningkat sebesar 50%."
  },
  State_97939_Name = {
    Text = "Piala juara Mythag"
  },
  State_97941_Desc = {
    Text = "Kerusakan dasar meningkat 100%."
  },
  State_97941_Name = {
    Text = "Piala juara Mythag"
  },
  State_97942_Desc = {
    Text = "Saat melepaskan muliakan mendapatkan 35 poin aliemus."
  },
  State_97942_Name = {
    Text = "Piala juara Mythag"
  },
  State_97943_Name = {
    Text = "Aritmetika mempertahankan penghitungan"
  },
  State_98055_Desc = {
    Text = "Pada akhir ronde, hasilkan 1 Tentakel. Setelah Bangun, hapus status ini."
  },
  State_98055_Name = {Text = "Tidur"},
  State_98060_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_98060_Name = {Text = "Not Roused"},
  State_98068_Desc = {
    Text = "Memiliki 10 lapisan\"Api Terbakar\"mendapatkan 2 poin aritmetika dan meng-upgrade semua\"Kilohertz\"menjadi\"Gigahertz\"."
  },
  State_98068_Name = {
    Text = "<BaoyanKeywords:Ledakan Api>"
  },
  State_98139_Desc = {
    Text = "Setelah giliran lawan dimulai, secara acak <BurningKeywords: terbakar> 1 kartu tangan."
  },
  State_98139_Name = {
    Text = "Api neraka menyala kembali"
  },
  State_98140_Desc = {
    Text = "Setelah mengumpulkan 10 lapisan <MonsterExFlameKeywords:Api Ledakan>, ganti niat menjadi\"Gelombang Terang Tera\"yang memiliki kerusakan sangat tinggi!"
  },
  State_98140_Name = {
    Text = "<BurningColor:Api Pembakar>"
  },
  State_98147_Desc = {
    Text = "Saat musuh memainkan kartu <BurningKeywords:Terbakar>, membuat dirinya mendapatkan 1 lapisan <MonsterExFlameKeywords:Ledakan Api>, tetapi sementara mengurangi [DescArg1] <PowerIconKeywords:Kekuatan>."
  },
  State_98147_Name = {
    Text = "Nyala Tak Padam"
  },
  State_98148_Desc = {
    Text = "Sosok yang belum terbangun ini... akan terbangun saat hampir jatuh, membuang semua kartu sisa dan memberikan <BurningKeywords:Membakar>, mengembalikan hidupnya dan bertarung dalam bentuk aslinya."
  },
  State_98148_Name = {Text = "Not Roused"},
  State_98302_Desc = {
    Text = "Unik tim: Kerusakan dasar pengguna meningkat sebesar <WeaponEffect_Num:[StateArg1]%>, dan efek perolehan kekuatan meningkat sebesar <WeaponEffect_Num:[StateArg2]%>. Setelah memainkan kartu perintah pengguna, dapatkan kekuatan sementara sebesar <WeaponEffect_Num:[StateArg3]%> dari atk pengguna, maksimal 5 kali per giliran."
  },
  State_98302_WeaponDesc = {
    Text = "Kerusakan dasar yang ditimbulkan oleh pemakai meningkat <WeaponEffect_Num:[StateArg1]%>, kekuatan yang dihasilkan meningkat <WeaponEffect_Num:[StateArg2]%>. Setelah memainkan kartu perintah pemakai, dapatkan <WeaponEffect_Num:[Power:DescArg1]> poin kekuatan sementara, maksimal dapat terpicu 5 kali per putaran (saat ini sudah terpicu [DescArg2]/5 kali)."
  },
  State_98323_Desc = {
    Text = "Kartu akan kembali ke tangan setelah dibuang."
  },
  State_98323_Name = {
    Text = "Kembali ke tangan setelah dibuang"
  },
  State_98341_Desc = {
    Text = "Dapat dicampurkan dengan warna dasar lainnya untuk menjadi warna baru."
  },
  State_98341_Name = {
    Text = "<Yellow:Warna Asli·Kuning>"
  },
  State_98344_Desc = {
    Text = "Dapat dicampurkan dengan warna dasar lainnya untuk menjadi warna baru."
  },
  State_98344_Name = {
    Text = "<Red:Warna Asli·Merah>"
  },
  State_98345_Desc = {
    Text = "Dapat dicampurkan dengan warna dasar lainnya untuk menjadi warna baru."
  },
  State_98345_Name = {
    Text = "<Blue:Warna Asli·Biru>"
  },
  State_98366_Desc = {
    Text = "Saat ronde dimulai, jika Energi-s lebih besar dari [Arg1], maka konsumsi [Arg1] poin Energi-s untuk memasukkan 1 kartu<DerivativeCardKeywords_115:\"Inspirasi Tingkat Tinggi\"> ke dalam tangan."
  },
  State_98435_Desc = {
    Text = "Dihasilkan dari perpaduan warna merah dan biru, setiap kali menyebabkan 1 kerusakan aktif, mendapatkan <Block: [DescArg1]> poin perisai."
  },
  State_98435_Name = {
    Text = "<PurpleKeyWord:Kejadian·Ungu>"
  },
  State_98436_Desc = {
    Text = "Dihasilkan dari perpaduan warna merah dan kuning, setelah melepaskan ledakan kegilaan, mendapatkan <Energy:15> poin kegilaan untuk tubuh yang terjaga."
  },
  State_98436_Name = {
    Text = "<ExclamationPointColour:Aneka Keganjilan·Oranye>"
  },
  State_98437_Desc = {
    Text = "Meningkatkan kerusakan akhir sebesar 10%."
  },
  State_98437_Name = {
    Text = "<Red:Warna Asli·Merah>"
  },
  State_98438_Desc = {
    Text = "Dihasilkan dari perpaduan warna kuning dan biru, setelah melakukan\"Pertahanan\", memulihkan <Heal:[DescArg1]> poin kehidupan."
  },
  State_98438_Name = {
    Text = "<GreenWord:Aneka Keganjilan·Hijau>"
  },
  State_98439_Desc = {
    Text = "Dihasilkan dari perpaduan warna kuning dan biru, setelah melakukan\"Pertahanan\", memulihkan <Heal:[DescArg1]> poin kehidupan."
  },
  State_98439_Name = {
    Text = "<GreenWord:Aneka Keganjilan·Hijau>"
  },
  State_98440_Desc = {
    Text = "Dihasilkan dari perpaduan warna merah dan biru, setiap kali menyebabkan 1 kerusakan aktif, mendapatkan <Block: [DescArg1]> poin perisai."
  },
  State_98440_Name = {
    Text = "<PurpleKeyWord:Kejadian·Ungu>"
  },
  State_98441_Desc = {
    Text = "Dihasilkan dari perpaduan warna merah dan kuning, setelah melepaskan ledakan kegilaan, mendapatkan <Energy:15> poin kegilaan untuk tubuh yang terjaga."
  },
  State_98441_Name = {
    Text = "<ExclamationPointColour:Aneka Keganjilan·Oranye>"
  },
  State_98444_Desc = {
    Text = "Hanya untuk tim: Kerusakan dasar yang dihasilkan oleh pemakai meningkat <WeaponEffect_Num:[StateArg1]%>. Setelah memainkan 5 Kartu perintah pemakai, pemakai mendapatkan <WeaponEffect_Num:[StateArg2]%> tingkat kritis sementara. Efek ini hanya bisa terpicu 1 kali per giliran."
  },
  State_98444_WeaponDesc = {
    Text = "Kerusakan dasar yang ditimbulkan oleh pemakai meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah memainkan 5 kartu perintah pemakai, pemakai mendapatkan <WeaponEffect_Num:[StateArg2]%> crit. rate sementara, efek ini hanya bisa terpicu 1 kali per putaran (saat ini telah dimainkan [DescArg1]/5 kartu)."
  },
  State_98466_Name = {
    Text = "<HuoyanKeywords1:Api Hidup1>"
  },
  State_98468_Name = {
    Text = "<HuoyanKeywords3:Api Hidup3>"
  },
  State_98470_Name = {
    Text = "<HuoyanKeywords2:Api Hidup2>"
  },
  State_98474_Desc = {
    Text = "Dapat mencampur dan memadukan warna dasar lainnya yang terdiri dari merah, kuning, dan biru."
  },
  State_98474_Name = {
    Text = "Warna dasar"
  },
  State_98484_Name = {
    Text = "Kesedihan tenggelam"
  },
  State_98485_Desc = {
    Text = "Perisai dan Fury yang dihasilkan kartu ini meningkat [DescArg2]%, damage akhir dan Kekuatan meningkat [DescArg1]%, mendapatkan \"Pertahankan\". Setelah dimainkan, konsumsi semua \"Nyala Hidup\" dan salurkan 1 lapis \"Nyala Hidup\" ke 1 kartu perintah Catigula lain di tangan."
  },
  State_98485_Name = {
    Text = "<HuoyanKeywords2:Api Hidup2>"
  },
  State_98486_Desc = {
    Text = "Perisai dan Fury yang dihasilkan kartu ini meningkat [DescArg2]%, damage akhir dan Kekuatan meningkat [DescArg1]%, mendapatkan \"Pertahankan\". Setelah dimainkan, konsumsi semua \"Nyala Hidup\" dan salurkan 1 lapis \"Nyala Hidup\" ke 1 kartu perintah Catigula lain di tangan."
  },
  State_98486_Name = {
    Text = "<HuoyanKeywords3:Api Hidup3>"
  },
  State_98487_Desc = {
    Text = "Perisai dan Fury yang dihasilkan kartu ini meningkat [DescArg2]%, damage akhir dan Kekuatan meningkat [DescArg1]%, mendapatkan \"Pertahankan\". Setelah dimainkan, konsumsi semua \"Nyala Hidup\" dan salurkan 1 lapis \"Nyala Hidup\" ke 1 kartu perintah Catigula lain di tangan."
  },
  State_98487_Name = {
    Text = "<HuoyanKeywords1:Api Hidup1>"
  },
  State_98488_Desc = {
    Text = "Setiap lapisan \"Api Hidup\" meningkatkan kerusakan akhir, pelindung, Aliemus, dan kekuatan yang disebabkan kartu sebesar 30%, hingga maksimum 3 lapisan. Kartu yang memiliki \"Api Hidup\" mendapatkan \"Bertahan\", setelah dikeluarkan menghabiskan semua \"Api Hidup\" dan mentransfer 1 lapisan \"Api Hidup\" ke 1 kartu perintah Katygura lainnya di tangan."
  },
  State_98488_Name = {
    Text = "<HuoyanKeywords:Api Hidup>"
  },
  State_98492_Desc = {
    Text = "Setelah eksplorasi dimulai, stamina, Serangan, dan Pertahanan meningkat sebesar [StateArg1]%"
  },
  State_98492_Name = {
    Text = "Soulforge Aptitude"
  },
  State_98495_Desc = {
    Text = "Setelah eksplorasi dimulai, stamina, Serangan, dan Pertahanan meningkat sebesar [StateArg1]%"
  },
  State_98495_Name = {
    Text = "Soulforge Aptitude"
  },
  State_98507_Desc = {
    Text = "Setelah eksplorasi dimulai, stamina, Serangan, dan Pertahanan meningkat sebesar [StateArg1]%"
  },
  State_98507_Name = {
    Text = "Soulforge Aptitude"
  },
  State_98511_Name = {
    Text = "Mendapatkan kartu turunannya"
  },
  State_98551_Desc = {
    Text = "Saat pertarungan dimulai, penguasaan Alam +[Arg1]. Pada awal giliran ganjil menarik 1 kartu, pada awal giliran genap mendapatkan 1 poin aritmetika."
  },
  State_98553_Desc = {
    Text = "Setiap kali satu \"embrio\" dihasilkan, dapatkan [Arg1] dapur merah, maksimal 3 kali per putaran."
  },
  State_98555_Desc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1]% kuat. Setelah menerapkan racun untuk pertama kalinya di setiap putaran, gambar [Arg2] kartu."
  },
  State_98556_Desc = {
    Text = "Efek dasar dari pemulihan hidup dan perisai yang disebabkan oleh semua pembangun meningkat [Arg1]%."
  },
  State_98557_Desc = {
    Text = "Setiap kali satu \"embrio\" dihasilkan, dapatkan [Arg1] dapur merah, maksimal 3 kali per putaran."
  },
  State_98559_Desc = {
    Text = "Setiap menggambar atau membuang satu kartu, dapatkan [Arg1] kekuatan sementara, maksimal dapatkan [Arg2] kekuatan sementara."
  },
  State_98560_Desc = {
    Text = "Kerusakan dasar yang disebabkan oleh semua pembangun meningkat [Arg1]%. Sebelum merilis muliakan, tingkatkan kerusakan dasar yang disebabkan oleh pembangun tersebut sementara [Arg2]%."
  },
  State_98561_Desc = {
    Text = "Saat giliran dimulai jika hidup di bawah 50%, sementara kuat efek kerusakan +[Arg1]%. Jika hidup di bawah 25%, menarik tambahan [Arg2] kartu dan mendapatkan [Arg2] aritmetika."
  },
  State_98562_Desc = {
    Text = "Setelah menyebabkan kerusakan aktif atau kerusakan tentakel, tingkatkan kerusakan tentakel yang diterima oleh target pada turn itu sebesar [Arg1]%, maksimal berlaku 20 kali per putaran."
  },
  State_98563_Desc = {
    Text = "Saat pertarungan dimulai, mendapatkan [Arg1] poin kekuatan. Setiap kali memainkan kartu \"Lelah\", mendapatkan [Arg2] kekuatan sementara, maksimal aktif [Arg3] kali."
  },
  State_98564_Desc = {
    Text = "\"Aliemus Muliakan\"mendapatkan [Arg1] energi-s, dapat diaktifkan maksimal 3 kali per giliran."
  },
  State_98565_Desc = {
    Text = "Setiap kali satu kartu memasuki ruang ultra, gambar [Arg1] kartu perintah pemilik kartu tersebut dari gambar, jika tidak dapat digambar, dapatkan aritmetika yang setara. Berlaku maksimal 2 kali per putaran."
  },
  State_98567_Desc = {
    Text = "Sampai akhir giliran, setiap kartu perintah di tangan memberikan pemilik pembangun [Arg1] poin Aliemus."
  },
  State_98568_Desc = {
    Text = "Pada awal pertempuran, dapatkan kerusakan kuat +[Arg1]%. Setelah menyebabkan kerusakan aktif, terapkan [Arg2] racun ke semua musuh, dengan maksimal tambahan lima kali per putaran."
  },
  State_98569_Desc = {
    Text = "Setiap pertama kali \"Geng\" dalam satu ronde menerapkan [Arg1] lapisan racun pada semua musuh dan dapatkan [Arg2] lapisan counter."
  },
  State_98571_Desc = {
    Text = "Setelah menggunakan Bangkit kunci perak, memulihkan [Arg1] hidup dan mendapatkan [Arg2] energi-s."
  },
  State_98571_Name = {
    Text = "payung perjalanan"
  },
  State_98572_Desc = {
    Text = "Setelah setiap kali kedua kalinya \"Geng\" dilepaskan dalam satu ronde, dapatkan [Arg1] energi kunci perak, semua pembangun mendapatkan [Arg2] aliemus."
  },
  State_98575_Desc = {
    Text = "Pada awal pertempuran, dapatkan kerusakan kuat +[Arg1]%. Setelah menyebabkan kerusakan aktif, terapkan [Arg2] racun ke semua musuh, dengan maksimal tambahan lima kali per putaran."
  },
  State_98576_Desc = {
    Text = "Saat pertarungan dimulai, mengenai semua musuh memberikan [Arg1] lapisan kelemahan dan rentan. Efek ini juga akan aktif setelah Annihilation, tetapi memiliki cooldown 3 giliran."
  },
  State_98577_Desc = {
    Text = "Kerusakan dasar yang disebabkan oleh semua pembangun meningkat [Arg1]%. Sebelum merilis muliakan, tingkatkan kerusakan dasar yang disebabkan oleh pembangun tersebut sementara [Arg2]%."
  },
  State_98579_Desc = {
    Text = "Saat giliran dimulai jika hidup di bawah 50%, sementara kuat efek kerusakan +[Arg1]%. Jika hidup di bawah 25%, menarik tambahan [Arg2] kartu dan mendapatkan [Arg2] aritmetika."
  },
  State_98581_Desc = {
    Text = "Setiap kartu perintah pada pembangun pertama kali per putaran, dapatkan [Arg1] energi kunci perak."
  },
  State_98582_Desc = {
    Text = "Setelah melepaskan \"Muliakan\" sebanyak 5 kali, kartu perintah non-turunan berikutnya [Arg1] akan berlaku tambahan 1 kali."
  },
  State_98583_Desc = {
    Text = "Setiap kartu perintah pada pembangun pertama kali per putaran, dapatkan [Arg1] energi kunci perak."
  },
  State_98586_Desc = {
    Text = "Saat giliran dimulai, semua pembangun yang kekurangan Aliemus untuk mengaktifkan Aliemus Muliakan mendapatkan [Arg1] poin Aliemus."
  },
  State_98587_Desc = {
    Text = "Setiap menggambar atau membuang satu kartu, dapatkan [Arg1] kekuatan sementara, maksimal dapatkan [Arg2] kekuatan sementara."
  },
  State_98588_Desc = {
    Text = "Sampai akhir giliran, setiap kartu perintah di tangan memberikan pemilik pembangun [Arg1] poin Aliemus."
  },
  State_98589_Desc = {
    Text = "Saat pertarungan dimulai, semua musuh kehilangan sementara [Arg1] poin kekuatan. Menggunakan \"Dapur Merah\"juga akan memicu efek ini, tetapi memiliki cooldown 3 giliran."
  },
  State_98590_Desc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1]% kuat. Setelah menerapkan racun untuk pertama kalinya di setiap putaran, gambar [Arg2] kartu."
  },
  State_98591_Desc = {
    Text = "Setiap pertama kali \"Geng\" dalam satu ronde menerapkan [Arg1] lapisan racun pada semua musuh dan dapatkan [Arg2] lapisan counter."
  },
  State_98596_Desc = {
    Text = "Mengembalikan energi kunci perak [Arg1]% yang habis setelah setiap pertama kali \"Geng\" dalam satu ronde."
  },
  State_98597_Desc = {
    Text = "Setelah menggunakan Bangkit kunci perak, memulihkan [Arg1] hidup dan mendapatkan [Arg2] energi-s."
  },
  State_98597_Name = {
    Text = "payung perjalanan+"
  },
  State_98598_Desc = {
    Text = "Saat pertarungan dimulai, mendapatkan [Arg1] poin kekuatan. Setiap kali memainkan kartu \"Lelah\", mendapatkan [Arg2] kekuatan sementara, maksimal aktif [Arg3] kali."
  },
  State_98600_Desc = {
    Text = "Saat pertarungan dimulai, semua musuh kehilangan sementara [Arg1] poin kekuatan. Menggunakan \"Dapur Merah\"juga akan memicu efek ini, tetapi memiliki cooldown 3 giliran."
  },
  State_98602_Desc = {
    Text = "Saat pertarungan dimulai, mendapatkan [Arg1]% kuat efek kerusakan. Pada setiap giliran, untuk pertama kalinya mendapatkan Counter, arahan mendapatkan 1/2 aritmetika."
  },
  State_98603_Desc = {
    Text = "Saat pertempuran dimulai, dapatkan DMG Amplification +[Arg1]%. Setelah menerima kerusakan aktif atau Kerusakan tentakel, dapatkan [Arg2] Counter, maksimal dipicu 3 kali per ronde."
  },
  State_98604_Desc = {
    Text = "Saat pertempuran dimulai, dapatkan DMG Amplification +[Arg1]%. Setelah menerima kerusakan aktif atau Kerusakan tentakel, dapatkan [Arg2] Counter, maksimal dipicu 3 kali per ronde."
  },
  State_98606_Desc = {
    Text = "Setiap kali satu kartu memasuki ruang ultra, gambar [Arg1] kartu perintah pemilik kartu tersebut dari gambar, jika tidak dapat digambar, dapatkan aritmetika yang setara. Berlaku maksimal 2 kali per putaran."
  },
  State_98607_Desc = {
    Text = "Setiap pertama kali \"Geng\" dalam satu ronde semua tentakel menyerang musuh [Arg1] kali, menimbulkan 50% kerusakan."
  },
  State_98608_Desc = {
    Text = "Saat pertarungan dimulai, mendapatkan [Arg1]% kuat efek kerusakan, setiap kali memainkan satu kartu perintah milik pembangun yang berbeda mendapatkan tambahan 15/30% kuat efek kerusakan sementara."
  },
  State_98610_Desc = {
    Text = "Setelah menggunakan Bangkit kunci perak, 2/4 kartu dengan aritmetika tertinggi di tangan mendapatkan efek menjaga dan siap main sampai dimainkan berikutnya, serta mendapatkan 100/200 energi-s."
  },
  State_98611_Desc = {
    Text = "Saat pertarungan dimulai, penguasaan Alam +[Arg1]. Pada awal giliran ganjil menarik 1 kartu, pada awal giliran genap mendapatkan 1 poin aritmetika."
  },
  State_98612_Desc = {
    Text = "Setiap pertama kali \"Geng\" dalam satu ronde membuat sementara kerusakan kuat +[Arg1]%, semakin rendah hidup, semakin kuat efeknya."
  },
  State_98613_Desc = {
    Text = "Saat pertarungan dimulai, mendapatkan [Arg1]% kuat efek kerusakan, setiap kali memainkan satu kartu perintah milik pembangun yang berbeda mendapatkan tambahan 15/30% kuat efek kerusakan sementara."
  },
  State_98614_Desc = {
    Text = "Setelah melepaskan \"Muliakan\" sebanyak 5 kali, kartu perintah non-turunan berikutnya [Arg1] akan berlaku tambahan 1 kali."
  },
  State_98615_Desc = {
    Text = "Mengembalikan energi kunci perak [Arg1]% yang habis setelah setiap pertama kali \"Geng\" dalam satu ronde."
  },
  State_98616_Desc = {
    Text = "Efek dasar dari pemulihan hidup dan perisai yang disebabkan oleh semua pembangun meningkat [Arg1]%."
  },
  State_98617_Desc = {
    Text = "Setelah menyebabkan kerusakan aktif atau kerusakan tentakel, tingkatkan kerusakan tentakel yang diterima oleh target pada turn itu sebesar [Arg1]%, maksimal berlaku 20 kali per putaran."
  },
  State_98619_Desc = {
    Text = "Saat giliran berakhir, jika energi-s penuh, gunakan [Arg1] poin energi-s untuk menempatkan satu kartu \"Kunci Perak Cahaya Lembut\"ke tangan."
  },
  State_98621_Desc = {
    Text = "Saat giliran berakhir, jika energi-s penuh, gunakan [Arg1] poin energi-s untuk menempatkan satu kartu \"Kunci Perak Cahaya Fajar\"ke tangan."
  },
  State_98623_Desc = {
    Text = "Saat giliran dimulai, semua pembangun yang kekurangan Aliemus untuk mengaktifkan Aliemus Muliakan mendapatkan [Arg1] poin Aliemus."
  },
  State_98624_Desc = {
    Text = "Saat pertarungan dimulai dan setelah Ketahanan terpicu, mendapatkan [Arg1] poin energi-s."
  },
  State_98625_Desc = {
    Text = "Saat pertarungan dimulai, mengenai semua musuh memberikan [Arg1] lapisan kelemahan dan rentan. Efek ini juga akan aktif setelah Annihilation, tetapi memiliki cooldown 3 giliran."
  },
  State_98626_Desc = {
    Text = "Setiap pertama kali \"Geng\" dalam satu ronde membuat sementara kerusakan kuat +[Arg1]%, semakin rendah hidup, semakin kuat efeknya."
  },
  State_98627_Desc = {
    Text = "\"Aliemus Muliakan\"mendapatkan [Arg1] energi-s, dapat diaktifkan maksimal 3 kali per giliran."
  },
  State_98628_Desc = {
    Text = "Setiap pertama kali \"Geng\" dalam satu ronde semua tentakel menyerang musuh [Arg1] kali, menimbulkan 50% kerusakan."
  },
  State_98629_Desc = {
    Text = "Setelah setiap kali kedua kalinya \"Geng\" dilepaskan dalam satu ronde, dapatkan [Arg1] energi kunci perak, semua pembangun mendapatkan [Arg2] aliemus."
  },
  State_98630_Desc = {
    Text = "Saat pertarungan dimulai dan setelah Ketahanan terpicu, mendapatkan [Arg1] poin energi-s."
  },
  State_98632_Desc = {
    Text = "Saat pertarungan dimulai, mendapatkan [Arg1]% kuat efek kerusakan. Pada setiap giliran, untuk pertama kalinya mendapatkan Counter, arahan mendapatkan 1/2 aritmetika."
  },
  State_98686_Desc = {
    Text = "Kartu perintah non-derivatif sebanyak [Layer] buah akan memiliki efek tambahan 1 kali."
  },
  State_98686_Name = {
    Text = "Kartu perintah non-derivatif menembak dua kali"
  },
  State_98739_Desc = {
    Text = "Saat niat diubah menjadi Putaran Pucat, tambah jumlah serangan sesuai jumlah lapisan negara, dan hapus negara pada akhir giliran. Saat mencapai 3 lapisan, niat langsung diubah jadi Putaran Pucat."
  },
  State_98739_Name = {
    Text = "Ciuman Wanita Laba-laba"
  },
  State_98742_Desc = {
    Text = "Peningkatan racun diterapkan sebesar 100%, setiap akhir putaran dapatkan perisai <Block:[Block:DescArg1]>."
  },
  State_98742_Name = {
    Text = "Perjalanan yang tersesat"
  },
  State_98743_Desc = {
    Text = "Setelah menerima [DescArg1] poin kerusakan dalam satu giliran, mendapatkan 75 lapisan diperkuat sementara, niat diubah menjadi \"Hadiah Tak Sabar\"dan efek batu menjadi normal, mendapatkan 1 lapisan \"Ciuman Ratu Laba-laba\"."
  },
  State_98743_Name = {
    Text = "Pemberontak"
  },
  State_98752_Desc = {
    Text = "Membakar kartu, setelah dimainkan akan menerima kerusakan 5% dari kesehatan maksimum, jika masih di tangan pada akhir giliran maka akan lelah."
  },
  State_98752_Name = {
    Text = "<BurningKeywords2:Membakar>"
  },
  State_98752_WeaponDesc = {
    Text = "Setiap lapisan kelambatan meningkatkan kelelahan aritmetika kartu sebesar 1 poin."
  },
  State_98887_Name = {
    Text = "Lampu penyelamat"
  },
  State_98889_Desc = {
    Text = "Setiap kali kartu perintah yang memiliki <DepleteIconKeywords:Lelah> dimainkan untuk pertama kalinya di setiap putaran, masukkan ke dalam tumpukan buangan."
  },
  State_98889_Name = {
    Text = "Lampu penyelamat"
  },
  State_98912_Desc = {
    Text = "Setiap lapisan mengurangi perisai dan pemulihan hp semua awak yang ada sebesar 10%."
  },
  State_98912_Name = {
    Text = "<LostWay:Tersesat>"
  },
  State_98913_Desc = {
    Text = "Setiap lapisan mengurangi perisai dan pemulihan hp semua awak yang ada sebesar 10%."
  },
  State_98913_Name = {Text = "Tersesat"},
  State_99007_Desc = {
    Text = "Setelah dimainkan, kartu tidak akan masuk ke Tumpukan kartu buang, melainkan dihapus dari dek."
  },
  State_99007_Name = {
    Text = "<DepleteIconKeywords:Lelah>"
  },
  State_99007_WeaponDesc = {
    Text = "Setelah digunakan, kartu tidak akan masuk ke tumpukan kartu buang dan tidak dapat digunakan kembali selama pertempuran ini."
  },
  State_99053_Desc = {
    Text = "<PVPWeaponKeywords:Roda takdir>: Setiap sekutu lain, saat pertama kali melakukan \"aliemus ledakan\" setiap ronde, tarik [StateArg1] kartu."
  },
  State_99053_Name = {
    Text = "Kuas yang Mendambakan"
  },
  State_99055_Desc = {
    Text = "<PVPWeaponKeywords:Roda Takdir>: Setelah \"Fury Burst\", secara acak memasukkan [StateArg1] \"Skill\" pemilik peralatan ke tangan dan mengubah konsumsi daya komputasinya menjadi 0."
  },
  State_99055_Name = {
    Text = "Paradoks Realisme"
  },
  State_99056_Desc = {
    Text = "Unik dalam tim: Setelah melepaskan geng, tingkat kritis pemakai sementara meningkat <WeaponEffect_Num:[StateArg1]>."
  },
  State_99056_WeaponDesc = {
    Text = "Setelah melepaskan geng, tingkat kritis pemakai sementara meningkat <WeaponEffect_Num:[StateArg1]%>."
  },
  State_99134_Desc = {
    Text = "\"Sang Pelukis\"Pewarna yang digunakan untuk melukis, dapat memperkuat efek keterampilan, maks 10 lapisan."
  },
  State_99134_Name = {
    Text = "Pewarnaan Fatamorgana"
  },
  State_99237_Name = {
    Text = "Negara Aksesori Terbang ke Surga"
  },
  State_99237_WeaponDesc = {
    Text = "Kerusakan dasar yang diberikan oleh pemakai meningkat sebesar 10%. Jika kuat kerusakan pemakai lebih dari 20%, kerusakan dasar akan meningkat tambahan sebesar 10%."
  },
  State_99238_Name = {
    Text = "Negara Aksesori Bahan Humus"
  },
  State_99238_WeaponDesc = {
    Text = "Kerusakan dasar yang diberikan oleh pemakai meningkat sebesar 10%. Jika kuat kerusakan pemakai lebih dari 20%, kerusakan dasar akan meningkat tambahan sebesar 10%."
  },
  State_99239_Name = {
    Text = "Negara Aksesori Styx"
  },
  State_99239_WeaponDesc = {
    Text = "Kerusakan dasar yang diberikan oleh pemakai meningkat sebesar 10%. Jika kuat kerusakan pemakai lebih dari 20%, kerusakan dasar akan meningkat tambahan sebesar 10%."
  },
  State_99258_Desc = {
    Text = "Unik untuk grup: setelah melepaskan Geng kedua di setiap giliran, ada <WeaponEffect_Num:[StateArg1]%> kemungkinan untuk menggambar 1 kartu perintah pemakai. Setelah memainkan kartu perintah pemakai ketiga di setiap giliran, dapatkan <WeaponEffect_Num:[StateArg2]> poin Energi-s."
  },
  State_99258_WeaponDesc = {
    Text = "Setelah melepaskan Geng kedua di setiap giliran, ada <WeaponEffect_Num:[StateArg1]%> kemungkinan untuk menggambar 1 kartu perintah pemakai. Setelah memainkan kartu perintah pemakai ketiga di setiap giliran, dapatkan <WeaponEffect_Num:[StateArg2]> poin Energi-s."
  },
  State_99294_Desc = {
    Text = "Semua Pembangun meningkatkan Aliemus sebesar [DescArg1]%. Aritmetika dan Kartu perintah pada akhir ronde dapat disimpan hingga ronde berikutnya. Aliemus dari babak kemewahan meningkat."
  },
  State_99294_Name = {Text = "\"Gembira\""},
  State_99295_Desc = {
    Text = "Semua Aliemus yang dihasilkan oleh Pembangun meningkat sebesar [StateArg1]%. Aritmetika dan Kartu perintah pada akhir ronde dapat disimpan hingga ronde berikutnya. Aliemus dalam babak kemegahan juga meningkat."
  },
  State_99295_Name = {Text = "\"Gembira\""},
  State_99336_Desc = {
    Text = "\"Sang Pelukis\"Pewarna yang digunakan untuk melukis, dapat memperkuat efek keterampilan, maks 10 lapisan."
  },
  State_99336_Name = {
    Text = "<DecayDye:Pewarna Dunia Ilusi>"
  },
  State_99533_Name = {
    Text = "Ornamen Gadis Kepompong"
  },
  State_99533_WeaponDesc = {
    Text = "Setelah pertempuran dimulai, jika pemilik peralatan memiliki profesi Kekacauan, Daya Serang meningkat sebesar 25%."
  },
  State_99534_Name = {
    Text = "Slime Manis"
  },
  State_99534_WeaponDesc = {
    Text = "Peningkatan 6% untuk perisai dan pemulihan hidup yang diberikan oleh pemakai. Jika penguasaan alam pemakai lebih dari 50, perisai dan pemulihan hidup akan mendapatkan peningkatan tambahan sebesar 6%."
  },
  State_99640_Desc = {
    Text = "Jika memiliki 10 lapis Kreasi saat ini, Pikeman akan mendapatkan 1 lapis \"Khyanak\" dan membuat semua Pembangun mendapatkan 15 poin Aliemus setelah melepaskan ledakan Aliemus dengan menggunakan semua Kreasi. Batas maksimum Kreasi adalah 10 lapis, dapat diwarisi ke pertempuran berikutnya."
  },
  State_99640_Name = {
    Text = "Kreativitas"
  },
  State_99723_Desc = {
    Text = "Tim eksklusif: Efek perolehan aliemus dan str yang diberikan oleh pemegang gear ini meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah melepaskan exalt, meningkatkan final dmg, perisai, dan regenerasi hp dari exalt berikutnya dari awakener lain dalam giliran ini sebesar <WeaponEffect_Num:[StateArg2]%>. Jika exalt kali ini memicu \"devour\", pemegang gear ini mendapatkan <WeaponEffect_Num:[StateArg3]> poin aliemus."
  },
  State_99723_WeaponDesc = {
    Text = "Aliemus dan Kekuatan yang dilakukan oleh pembawa peralatan meningkat sebesar <WeaponEffect_Num:[StateArg1]%>. Setelah merilis Muliakan, kerusakan akhir Aliemus, Perisai, dan pemulihan Hidup selanjutnya dari Pembangun lain dalam giliran ini meningkat sebesar <WeaponEffect_Num:[StateArg2]%>, jika \"Melahap\" dipicu selama Muliakan, pembawa peralatan mendapatkan poin Aliemus sebesar <WeaponEffect_Num:[StateArg3]>."
  }
})
return Text_State
