__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Activity = readonly({
  Activity_100432_ActivityName = {
    Text = "Serangga Hipnotis"
  },
  Activity_100432_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Serangga Hipnotis\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Clementine untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_100433_ActivityName = {
    Text = "Uskup Pengasih"
  },
  Activity_100433_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Uskup Pengasih\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Salvador untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_116469_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_116470_ActivityName = {
    Text = "Malam Tanpa Akhir Siang Abadi"
  },
  Activity_116470_ActivityPlot = {
    Text = "Mereka bertemu di ujung takdir, jam yang bergetar kembali sudah terlambat terlalu lama, hanya hati yang penuh penyesalan yang bersumpah akan menerangi semua kotoran dalam kegelapan."
  },
  Activity_116470_ActivityStageEndContent = {
    Text = "Kegiatan telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Ritual Berkat\""
  },
  Activity_116470_ActivityTips = {
    Text = "<Title:Deskripsi Kegiatan>\n1. Selama periode kegiatan, Penjaga dapat mengumpulkan mata uang kegiatan \"Menggabungkan Darah Penderitaan\" dan \"Hadiah Prestasi\" melalui cara bermain terbatas, yaitu \"Menggabungkan Darah Penderitaan\", serta \"Pengakuan Dosa\", \"Pengakuan Dosa\", dan \"Kesetiaan Persembahan\", yang dapat digunakan untuk membeli barang di \"Upacara Berkat\", termasuk Roda takdir eksklusif acara \"Anak Suci\", Inti Lumen, Inti murni, dll. \n2. Selama periode kegiatan, \"Lanskap mimpi: Di luar cakrawala·bawah\" dapat dibuka secara gratis dalam waktu terbatas, dan menyelesaikan prestasi acara akan mendapatkan avatar eksklusif acara \"Atas nama Kunci Perak: Pollux\"!\n\n<Title:Waktu Kegiatan>\n1. 20 Oktober 9:00 - 3 November 9:00 (GMT+8), semua cara bermain kegiatan dapat diikuti. \n2. 3 November 9:00 - 10 November 9:00 (GMT+8), hanya dapat mengikuti \"Upacara Berkat\" dan Hadiah Prestasi. \n\n<Title:Menggabungkan Darah Penderitaan>\n1. \"Menggabungkan Darah Penderitaan\" terdiri dari 7 tingkat, yang akan dibuka secara otomatis 1 per hari. \n2. Setiap tantangan akan menghabiskan \"Menophin\"× 120, dan berhasil menyelesaikan tantangan akan mendapatkan mata uang kegiatan. \n3. Setelah menyelesaikan tingkat, fungsi \"Reproduksi\" untuk tingkat tersebut akan dibuka. Harap diperhatikan: saat menggunakan fungsi \"Reproduksi\", tidak akan mendapatkan tingkat afinitas. \n4. Dapat menggunakan bantuan alumni untuk membantu Anda melewati tingkat dengan lebih mudah. \n\n<Title:Pusaran Kenangan>\n· Setelah kegiatan dimulai, setiap jam secara otomatis mendapatkan 60 \"Pengakuan Dosa\", maksimum dapat disimpan hingga 25 jam. \n\n<Title:Upacara Berkat>\n1. \"Upacara Berkat\" memiliki tiga toko, dengan waktu pembukaan sebagai berikut: \n·\"Mencuci tubuh\": Dibuka pada 20 Oktober pukul 9. \n·\"Pengakuan Dosa Jiwa\": Dibuka pada 21 Oktober pukul 9. \n·\"Ekstraksi dosa\": Dibuka pada 22 Oktober pukul 9. \n2. Setiap pertukaran akan menghabiskan 750 \"Pengakuan Dosa\"/\"Pengakuan Dosa\"/\"Kesetiaan Persembahan\", dan secara acak akan mendapatkan lima hadiah barang dari ruang gambar. \n3. Hadiah barang di setiap ruang gambar dibagi menjadi dua jenis: \"Barang Spesial\" dan \"Barang Umum\", saat reset dapat mengatur ulang jumlah sisa hadiah barang spesial ke batas atas, dengan aturan sebagai berikut: \n(1)Reset 2 kali pertama: Ketika \"Barang Spesial\" tidak ada sisa, Penjaga dapat memilih untuk mereset, setelah mereset akan mengatur ulang jumlah sisa \"Barang Spesial\" dan \"Barang Umum\" ke batas atas; juga dapat memilih untuk terus bertukar, ketika \"Barang Umum\" juga tidak ada sisa, harus mereset untuk dapat melanjutkan pertukaran. \n(2)Reset mulai dari yang ke-3: Ketika \"Barang Umum\" tidak ada sisa, baru dapat melakukan reset, reset akan mengatur ulang jumlah sisa \"Barang Umum\" ke batas atas, \"Barang Spesial\" tidak akan direset lagi. \n\n<Title:Bonus Kegiatan>\n1. Penjaga yang memiliki Awakeners atau Roda takdir tertentu (tidak perlu diatur) dapat membuat mata uang \"Pengakuan Dosa\", \"Pengakuan Dosa\", dan \"Kesetiaan Persembahan\" dalam tugas tingkat \"Menggabungkan Darah Penderitaan\" mendapatkan tambahan drop, dengan tambahan sebagai berikut: \n·Awakener \"Pollux\": Mencerahkan 0/1/2/3 dan lebih, tambahan 20%/30%/40%/50%. \n·Roda takdir SSR \"Distorsi Ksatria\": Posisi Tumpuk 0/1/2/3 dan lebih, tambahan 20%/30%/40%/50%. \n·Roda takdir SR \"Anak Suci\": Posisi Tumpuk 0/1/2/3 dan lebih, tambahan 20%/30%/40%/50%. \n2. Bonus \"Kegiatan\" dari Awakener atau Roda takdir yang berbeda akan dihitung secara bertumpuk. \n3. Khususnya, hadiah tantangan pertama di tingkat Kegilaan tidak akan dipengaruhi oleh bonus \"Kegiatan\". \n\n<Title:Lanskap Mimpi>\n1. Selama periode kegiatan, \"Lanskap mimpi: Di luar cakrawala·bawah\" dapat dibuka secara gratis. \n2. Setelah kegiatan berakhir, kemajuan penyelidikan \"Lanskap mimpi: Di luar cakrawala·bawah\" akan disimpan, dan menyelesaikan kejadian penyelidikan yang belum selesai selama periode kegiatan juga dapat mendapatkan hadiah penyelidikan yang sama dengan periode kegiatan. Jika selama periode kegiatan \"Lanskap mimpi: Di luar cakrawala·bawah\" tidak dibuka, setelah kegiatan berakhir masih dapat menghabiskan \"Titik awal realitas\"×7 untuk membukanya. \n3. Baik selama periode kegiatan atau tidak, setelah menyelesaikan \"Lanskap mimpi: Di luar cakrawala·bawah\" dapat memperoleh \"Posse: Hati Suci yang Menangis Darah\"."
  },
  Activity_116470_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_116765_ActivityName = {
    Text = "Perjalanan Pengukiran"
  },
  Activity_116765_ActivityTips = {
    Text = [[
Aturan Event:
1. Setelah Penjaga Rahasia menyelesaikan misi Chronicle yang ditentukan, hadiah dapat diklaim di "Keberangkatan yang Terukir".
2. Setelah membuka "Chronicle Lanjutan", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
3. Pembelian "Chronicle Lanjutan" kali ini memiliki batas waktu, setelah lewat batas waktu tidak dapat dibeli lagi. Penjaga Rahasia diharapkan membeli sebelum 3 November pukul 9:00.
4. Perhatian: "Chronicle Lanjutan" yang dibuka dalam event ini hanya berlaku di event ini. Penjaga Rahasia diharapkan membelanjakan secara bijak.]]
  },
  Activity_116765_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_116818_ActivityName = {
    Text = "Pertempuran Ulang Primordial"
  },
  Activity_116818_ActivityPlot = {
    Text = "\"Bintang-Bintang\"adalah mata-Nya, menggantikan-Nya untuk memandang, atau lebih tepatnya mengawasi segala sesuatu di dunia.\nKau mengira telah lolos dari pandangan-Nya, tetapi kenyataannya — kau masih berada dalam mimpi-Nya.\n\"Tertangkap kau —\"\nDi saat menangkapmu, bintang-bintang menghela napas puas."
  },
  Activity_116818_ActivityStageEndContent = {
    Text = "Acara telah berakhir"
  },
  Activity_116818_ActivityTips = {
    Text = "<Title: Pertempuran Ulang Primordial>\n·\"Pertempuran Ulang Primordial\"berisi 7 level tantangan langsung melawan Tatapan Primordial yang tidak dapat diulang. Dua hari pertama aktivitas membuka 1 level, hari ketiga membuka 3 level, dan dua hari berikutnya masing-masing membuka 1 level per hari.\n·Setiap kali berhasil mengalahkan Tatapan Primordial Bintang yang sesuai, kamu akan mendapatkan hadiah yang sesuai.\n·Setiap jenis Tatapan Primordial Bintang memiliki banyak duplikat. Setiap kali jenis Tatapan Primordial Bintang tertentu berhasil dikalahkan oleh Penjaga Rahasia mana pun, \"Jumlah Tersisa\" dari jenis tersebut akan berkurang 1. Ketika jenis Tatapan Primordial Bintang tersebut telah dimusnahkan, level yang sesuai akan ditutup dan tidak dapat ditantang lagi.\n·Setiap level menyediakan Artefak yang berbeda, yang akan memberikan bonus kuat untukmu.\n·Semua level harus memilih bantuan tempur. Selama seluruh aktivitas, setiap Penjaga Rahasia yang saling mengikuti hanya dapat memberikan bantuan tempur untukmu satu kali. Karena menggunakan bantuan tempur, hadiah Tingkat Sinkronisasi aktual akan meningkat 50% dari hadiah dasar.\n·Setiap hari, setiap Awakened, Roda Takdir, dan Kunci Perintah hanya dapat bertarung 1 kali.\n·Selama periode aktivitas, Catatan Ekspedisi\"Aria Bintang-Bintang\"dapat dibuka secara gratis tanpa syarat prasyarat! Setelah aktivitas gameplay\"Pertempuran Ulang Primordial\"berakhir, kamu harus menyelesaikan\"Operasi Investigasi - Bab Bintang - Bab Keempat\"terlebih dahulu untuk membuka Catatan Ekspedisi\"Aria Bintang-Bintang\".\n\n<Title: Kompensasi Level>\n·Dalam\"Pertempuran Ulang Primordial\"terdapat mekanisme kompensasi level, agar para Penjaga Rahasia dapat bertarung bersama!\nAturan kompensasi level sebagai berikut:\n  ·Dalam tim investigasi, Awakened yang levelnya kurang dari level 60 akan dikompensasi hingga level 60 dalam tantangan ini.\n  ·Dalam tim investigasi, Awakened yang level skill-nya kurang dari level 5 akan dikompensasi hingga level 5 dalam tantangan ini.\n  ·Dalam tim investigasi, Awakened yang level\"Pertanda Kegilaan\"kurang dari level 6 akan dikompensasi hingga level 6 dalam tantangan ini.\n  ·Dalam tim investigasi, Awakened yang level\"Adaptasi Pembentukan Roh\"kurang dari level 5 akan dikompensasi hingga level 5 dalam tantangan ini.\n  ·Jika level Penjaga Rahasia kurang dari level 60, akan dikompensasi hingga level 60 dalam tantangan ini.\n\n<Title:Catatan Ekspedisi>\n·Selama periode aktivitas,\"Catatan Ekspedisi: Aria Bintang-Bintang\"dapat dibuka secara gratis tanpa syarat prasyarat!\n·Setelah aktivitas berakhir, progres investigasi\"Catatan Ekspedisi: Aria Bintang-Bintang\"akan disimpan. Menyelesaikan peristiwa investigasi yang belum selesai selama periode aktivitas juga akan memberikan hadiah investigasi yang sama seperti selama aktivitas. Jika\"Catatan Ekspedisi: Aria Bintang-Bintang\"belum dibuka selama periode aktivitas, setelah aktivitas berakhir kamu harus menyelesaikan\"Operasi Investigasi - Bab Bintang - Bab Keempat\"dan menggunakan\"Titik Awal Realitas\"×7 untuk membuka Catatan Ekspedisi\"Aria Bintang-Bintang\".\n·Baik selama maupun di luar periode aktivitas, setelah menyelesaikan\"Catatan Ekspedisi: Aria Bintang-Bintang\"kamu akan mendapatkan\"Kunci Perintah: Harapan Reuni\"."
  },
  Activity_116818_BannerText = {
    Text = "Aktivitas Spesial Dibuka Terbatas!"
  },
  Activity_117836_ActivityName = {
    Text = "Nyonya Merah"
  },
  Activity_117836_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Nyonya Merah\" berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Soreil untuk mencoba level yang ditentukan tanpa batas.\n·Saat mencoba level aktivitas, formasi Awakened dalam tim tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan level, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_117837_ActivityName = {
    Text = "Wanita Aequor"
  },
  Activity_117837_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Deep Sea Lady\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Murphy untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_117838_ActivityName = {
    Text = "Putra Suci·Sayap Hitam"
  },
  Activity_117838_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Putra Suci·Sayap Hitam\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Castor untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_117839_ActivityName = {
    Text = "Kunci Gerbang"
  },
  Activity_117839_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Kunci Gerbang\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Tavi untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_119662_ActivityName = {
    Text = "Bunga dari Lumpur"
  },
  Activity_119662_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Bunga dari Lumpur\" berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Lily untuk mencoba level yang ditentukan tanpa batas.\n·Saat mencoba level aktivitas, formasi Awakened dalam tim tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan level, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_119663_ActivityName = {
    Text = "Napas Kemakmuran"
  },
  Activity_119663_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Napas Kemakmuran\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Taiyi Si untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_119693_ActivityName = {
    Text = "Atas Nama Kunci Perak"
  },
  Activity_119693_ActivityPlot = {
    Text = "Setelah menyelesaikan misi, pilih 1 dari Kebangkitan limited berikut untuk dibangkitkan!"
  },
  Activity_119693_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama periode event, setelah setiap Penjaga Rahasia menggunakan total 200 kali Perintah Kunci, dapat memilih 1 dari 8 Kebangkitan SSR limited untuk dibangkitkan, termasuk Meltdown·Dor, Clementine, Coppersaint, Castor, Dulcesein, Catigula, Pickman, dan Pollux.\n·Jika Penjaga Rahasia memilih Kebangkitan yang sudah dibangkitkan, saat memperoleh Kebangkitan SSR yang sama untuk ke-2~16 kali, setiap kali akan dikonversi menjadi 1 Pecahan Kebangkitan terkait dan\"Endapan Asal\"× 50; mulai perolehan ke-17 dan seterusnya, Kebangkitan SSR limited akan dikonversi menjadi\"Pecahan Inti Roh Murni\"× 2,\"Pecahan Inti Roh\"× 6, dan\"Endapan Asal\"× 250."
  },
  Activity_119693_BannerText = {
    Text = "Klaim Kebangkitan Limited Gratis"
  },
  Activity_119694_ActivityName = {
    Text = "Bimbingan Bintang Fajar"
  },
  Activity_119694_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Setelah Penjaga Rahasia menyelesaikan misi Catatan Perjalanan yang ditentukan, hadiah dapat diklaim di\"Bimbingan Bintang Fajar\".\n·Setelah membuka\"Catatan Perjalanan Lanjutan\", hadiah tambahan dapat diklaim setelah menyelesaikan misi.\n·Pembelian\"Catatan Perjalanan Lanjutan\"kali ini memiliki batas waktu, setelah lewat tidak dapat dibeli lagi. Penjaga Rahasia diharapkan mempertimbangkan pembelian sebelum 26 Januari pukul 9:00 (GMT+8).\n·Perhatian:\"Catatan Perjalanan Lanjutan\"yang dibuka dalam event ini hanya berlaku di event ini. Penjaga Rahasia diharapkan membelanjakan secara bijak."
  },
  Activity_119694_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_119857_ActivityName = {
    Text = "Tuan yang Tertidur"
  },
  Activity_119857_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Tuan yang Tertidur\" berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Thulu untuk mencoba level yang ditentukan tanpa batas.\n·Saat mencoba level aktivitas, formasi Awakened dalam tim tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan level, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_120495_ActivityName = {
    Text = "Persembahan Kenangan Perjalanan·Bab Bintang IV"
  },
  Activity_120495_ActivityPlot = {
    Text = "Sebuah memori tersegel dan diarsipkan, sebuah perjalanan tercatat dalam masa lalu. Saat mengenang, jangan lupa persembahkan penghormatan yang tulus."
  },
  Activity_120496_ActivityName = {
    Text = "Chronicle Reinkarnasi"
  },
  Activity_120496_ActivityTips = {
    Text = [[
Aturan Aktivitas:
1. Setelah Penjaga Rahasia menyelesaikan misi Chronicle yang ditentukan, hadiah dapat diklaim di "Chronicle Reinkarnasi".
2. "Chronicle Reinkarnasi" dibuka secara permanen.
3. Setelah membuka "Chronicle Premium", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
4. Harap diperhatikan: "Chronicle Premium" yang dibuka dalam aktivitas ini hanya berlaku untuk aktivitas ini. Penjaga Rahasia diharapkan untuk berbelanja secara bijak.]]
  },
  Activity_120954_ActivityName = {
    Text = "Aria Bintang-Bintang"
  },
  Activity_122195_ActivityName = {
    Text = "Upacara Pembakaran Kabut"
  },
  Activity_122195_ActivityPlot = {
    Text = [[
Cahaya fajar sedang menghilangkan penderitaan para yang beriman, bintang-bintang menjadi perahu, mengantar saudara-saudari menuju kerajaan yang tinggi. 
 Domba yang tersesat menari dan bernyanyi di pintu, lilin bintang menghiasi istana abadi. 
 Namun kabut di balik pintu telah datang sesuai panggilan, kabut itu menipu dan memperdaya, hanya untuk memuaskan selera distorsi dirinya. 
 Kabut itu karena itu mengunci "fajar", memutuskan jalan untuk mencoba pembebasan. 
 Dia akan berada di sini, menyaksikan akhir dunia sekali lagi.]]
  },
  Activity_122195_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Kedai Moxha\""
  },
  Activity_122195_ActivityTips = {
    Text = "<Title:Deskripsi Acara>\n1, Selama periode acara, Penjaga dapat mengumpulkan mata uang acara \"Pandangan Kabut\", \"Mimpi Kabut\", \"Sumber Kabut\" melalui gameplay terbatas \"Hilangnya Diri\" dan \"Hadiah Prestasi\". \"Pandangan Kabut\", \"Mimpi Kabut\", \"Sumber Kabut\" dapat digunakan untuk membeli barang di \"Gubuk Mouchette\", termasuk Roda Takdir SR terbatas acara \"Lampu Terang Rasionalitas\", Inti Lumen, Inti Murni, dan lainnya. \n2, Selama periode acara, \"Koneksi Multidimensi: Baptisan Perak dan Darah\" dapat dibuka secara gratis, dan menyelesaikan prestasi acara juga akan memberikan avatar terbatas acara \"Atas nama Kunci Perak: Mouchette\"!\n\n<Title: Waktu Acara>\n1, 29 Desember 9:00 - 12 Januari 9:00 (GMT+8), semua gameplay acara dapat diikuti. \n2, 12 Januari 9:00 - 19 Januari 9:00 (GMT+8), hanya dapat berpartisipasi di \"Gubuk Mouchette\" dan Hadiah Prestasi. \n\n<Title:Hilangnya Diri>\n1, \"Hilangnya Diri\" terdiri dari 7 tingkat, yang akan dibuka secara otomatis satu per hari. \n2, Setiap tantangan akan menghabiskan \"Menophin\" × 120, dan berhasil menyelesaikan tantangan akan mendapatkan mata uang acara. \n3, Setelah menyelesaikan tingkat, fungsi \"Reproduksi\" untuk tingkat tersebut akan terbuka. Harap diperhatikan: saat menggunakan fungsi \"Reproduksi\", tidak akan mendapatkan Affiniti. \n4, Anda dapat menggunakan bantuan alumni untuk membantu Anda menyelesaikan tingkat dengan lebih mudah. \n\n<Title:Gubuk Mouchette>\n\"Gubuk Mouchette\" memiliki tiga toko, dengan waktu pembukaan sebagai berikut: \n· \"Ruang Bahan\": Dibuka pada 29 Desember 9:00. \n· \"Ruang Masuk Mimpi\": Dibuka pada 30 Desember 9:00. \n· \"Ruang Pemuliaan\": Dibuka pada 31 Desember 9:00. \nDi dalam toko, Anda dapat memilih barang untuk dibeli langsung. \n\n<Title:Bonus Acara>\n1, Penjaga yang memiliki Awakener atau Roda Takdir tertentu (tidak perlu diatur) dapat memberikan bonus tambahan pada mata uang \"Pandangan Kabut\", \"Mimpi Kabut\", \"Sumber Kabut\" dalam tugas tingkat \"Hilangnya Diri\". Bonus spesifik adalah sebagai berikut: \n· Awakener \"Mouchette\": Pencerahan 0/1/2/3 dan lebih, bonus 20%/30%/40%/50%. \n· Roda Takdir SSR \"Pembantaian Hingga Ujung Dunia\": Posisi Tumpuk 0/1/2/3 dan lebih, bonus 20%/30%/40%/50%. \n· Roda Takdir SR \"Lampu Terang Rasionalitas\": Posisi Tumpuk 0/1/2/3 dan lebih, bonus 20%/30%/40%/50%. \n2, Bonus \"Bonus Acara\" dari Awakener atau Roda Takdir yang berbeda dihitung dengan cara yang dapat ditumpuk. \n3, Secara khusus, hadiah tantangan pertama tingkat Kegilaan tidak akan terpengaruh oleh \"Bonus Acara\". \n\n<Title: Koneksi Multidimensi>\n1, Selama periode acara, \"Koneksi Multidimensi: Baptisan Perak dan Darah\" dapat dibuka secara gratis. \n2, Setelah acara berakhir, progres investigasi \"Koneksi Multidimensi: Baptisan Perak dan Darah\" akan disimpan, dan menyelesaikan kejadian investigasi yang belum selesai selama periode acara juga akan memberikan hadiah investigasi yang sama dengan periode acara. Jika \"Koneksi Multidimensi: Baptisan Perak dan Darah\" tidak dibuka selama periode acara, setelah acara berakhir, Anda masih dapat menghabiskan \"Titik awal realitas\" ×3 untuk membukanya. \n3, Terlepas dari apakah selama periode acara atau tidak, setelah menyelesaikan \"Koneksi Multidimensi: Baptisan Perak dan Darah\", Anda dapat memperoleh \"Posse: Dari Kabut\"."
  },
  Activity_122195_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_122196_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_122520_ActivityName = {
    Text = "Hantu Hujan·Rekaman Ulang"
  },
  Activity_122520_ActivityPlot = {
    Text = [[
Di malam hujan yang kabur dan lembab itu, ada pertemuan yang ditakdirkan yang menunggu Anda.
Anda mengingat namanya, mengenali penampilannya, suara lembut dan elegannya selalu membuat Anda merasa tenang.
Hanya saja Anda lupa, hanya dewa dan setan yang senang memuaskan keinginan manusia.
Coba tebak, dia termasuk yang mana?]]
  },
  Activity_122520_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Gudang Penyihir\""
  },
  Activity_122520_ActivityTips = {
    Text = "<Title:Deskripsi Kegiatan>\n1. Selama periode kegiatan, Penjaga dapat mengumpulkan mata uang acara melalui gameplay terbatas \"Toko Kecil Penyihir\" dan \"Hadiah Prestasi\". Mata uang acara dapat ditukarkan di \"Gudang Penyihir\" untuk mendapatkan hadiah item, termasuk SR Roda takdir eksklusif acara \"Topi Lebar Penyihir\", Batu filsuf, Inti murni, Inti Lumen, dan lainnya. \n2. Selama periode kegiatan, \"Rekam Jejak Satuan Tugas: Bayang-bayang Kota Hujan\" akan dibuka gratis, menyelesaikan prestasi acara juga akan memberikan avatar eksklusif acara \"Atas nama Kunci Perak: Narsis\"!\n\n<Title: Waktu Kegiatan>\n1. 12 Januari 9:00 - 26 Januari 9:00 (GMT+8), semua konten acara dapat diikuti. \n2. 26 Januari 9:00 - 2 Februari 9:00 (GMT+8), hanya \"Gudang Penyihir\" dan \"Hadiah Prestasi\" yang akan tetap tersedia, konten lainnya sudah berakhir dan tidak dapat diikuti. \n\n<Title: Toko Kecil Penyihir>\n1. \"Toko Kecil Penyihir\" terdiri dari 5 tingkat, satu tingkat akan dibuka secara otomatis setiap 2 hari. \n2. Setiap tantangan akan menghabiskan \"Menophin\"× 120, keberhasilan tantangan akan memberikan mata uang acara. \n3. Setelah menyelesaikan tingkat, fungsi \"Reproduksi\" dari tingkat tersebut akan dibuka. Harap dicatat: saat menggunakan fungsi \"Reproduksi\", tidak akan mendapatkan afiniti. \n4. Anda dapat menggunakan bantuan alumni untuk membantu Anda menyelesaikan tingkat dengan lebih mudah. \n\n<Title: Bonus Kegiatan>\n1. Penjaga yang memiliki Awakeners atau Roda takdir tertentu (tidak perlu digunakan dalam tim) dapat memberikan bonus tambahan pada item \"Tulang Kepala Binatang Pucat\", \"Tulang Kepala Hewan Bayangan\", dan \"Tulang Kepala Binatang Merah Marun\" yang diperoleh dari tugas tingkat \"Toko Kecil Penyihir\" (termasuk reproduksi), rincian bonus sebagai berikut: \n· Awakener \"Narsis\": Mencerahkan 0/1/2/3 dan lebih, bonus 20%/30%/40%/50% \n· SSR Roda takdir \"Relik Langka\": Posisi Tumpuk 0/1/2/3 dan lebih, bonus 20%/30%/40%/50% \n· SR Roda takdir \"Topi Lebar Penyihir\": Posisi Tumpuk 0/1/2/3 dan lebih, bonus 20%/30%/40%/50% \n2. Bonus \"Kegiatan\" dari Awakeners atau Roda takdir yang berbeda akan dihitung dengan cara yang terakumulasi. \n3. Khususnya, hadiah tantangan pertama untuk tingkat Kegilaan tidak akan terpengaruh oleh bonus \"Kegiatan\". \n\n<Title: Gudang Penyihir>\n1. \"Gudang Penyihir\" terdiri dari tiga, waktu pembukaan sebagai berikut: \n·\"Barang Kualitas Baik untuk Meredakan Kekhawatiran\": 12 Januari 9:00 - 2 Februari 9:00. \n·\"Harta Karun Indah\": 14 Januari 9:00 - 2 Februari 9:00. \n·\"Koleksi Barang Langka\": 16 Januari 9:00 - 2 Februari 9:00. \n2. Setiap pertukaran akan menghabiskan 750 \"Tulang Kepala Binatang Pucat\"/\"Tulang Kepala Hewan Bayangan\"/\"Tulang Kepala Binatang Merah Marun\", secara acak mendapatkan lima hadiah item dari gudang. \n3. Setiap hadiah item dari gudang dibagi menjadi dua jenis yaitu \"Item Spesial\" dan \"Item Umum\", saat reset dapat mengatur ulang jumlah sisa hadiah item yang ditentukan ke batas maksimum, aturan spesifik sebagai berikut: \n(1)Reset 2 kali pertama: Ketika \"Item Spesial\" tidak memiliki sisa jumlah, Penjaga dapat memilih untuk mereset, setelah reset, jumlah sisa \"Item Spesial\" dan \"Item Umum\" akan diatur ulang ke batas maksimum; Penjaga juga dapat memilih untuk terus bertukar, ketika \"Item Umum\" juga tidak memiliki sisa jumlah, harus melakukan reset untuk dapat melanjutkan pertukaran. \n(2)Reset mulai dari 3 kali: Hanya dapat melakukan reset ketika \"Item Umum\" tidak memiliki sisa jumlah, reset akan mengatur ulang jumlah sisa \"Item Umum\" ke batas maksimum, \"Item Spesial\" tidak akan direset lagi. \n\n<Title: Rekam Jejak Satuan Tugas>\n1. Selama periode kegiatan, \"Rekam Jejak Satuan Tugas: Bayang-bayang Kota Hujan\" akan dibuka gratis. \n2. Setelah acara berakhir, kemajuan penyelidikan \"Rekam Jejak Satuan Tugas: Bayang-bayang Kota Hujan\" akan disimpan, jika \"Rekam Jejak Satuan Tugas: Bayang-bayang Kota Hujan\" tidak dibuka selama periode acara, setelah acara berakhir masih dapat menghabiskan \"Titik awal realitas\"×7 untuk membuka kunci. \n3. Baik selama periode acara maupun tidak, setelah menyelesaikan \"Rekam Jejak Satuan Tugas: Bayang-bayang Kota Hujan\", Anda akan mendapatkan \"Posse: Penampilan Sejati Kabut Abu-abu\"."
  },
  Activity_122520_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_122521_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_122803_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_122803_ActivityPlot = {
    Text = [[
Setelah membeli, "Moxia" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, Membuka Ledakan Transenden>]]
  },
  Activity_122804_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_122804_ActivityPlot = {
    Text = "Setelah membeli, \"Mocha\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_122827_ActivityName = {
    Text = "Anugerah Pembiakan"
  },
  Activity_122827_ActivityTips = {
    Text = "<Title:Pengantar>\n·Selama event berlangsung, Penjaga Rahasia dapat mengklaim hadiah yang sesuai di \"Anugerah Pembiakan\" setelah menyelesaikan target yang ditentukan."
  },
  Activity_122827_BannerText = {
    Text = "Dapatkan Ilusi Pakaian gratis!"
  },
  Activity_123150_ActivityName = {
    Text = "Penyihir Pemburu Tengkorak"
  },
  Activity_123150_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Penyihir Pemburu Tengkorak\" berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Daphodel untuk mencoba level yang ditentukan tanpa batas.\n·Saat mencoba level aktivitas, formasi Awakened dalam tim tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan level, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_123151_ActivityName = {
    Text = "Penguasa Tulang Belulang"
  },
  Activity_123151_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Penguasa Tulang Belulang\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Dulcesein untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_123152_ActivityName = {
    Text = "Rasul Lautan"
  },
  Activity_123152_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Rasul Lautan\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Miriam untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_123322_ActivityName = {
    Text = "Chronicle Embun Perak"
  },
  Activity_123322_ActivityTips = {
    Text = [[
<Title:Aturan Event>
1. Setelah Penjaga Rahasia menyelesaikan misi Chronicle yang ditentukan, hadiah dapat diklaim di "Chronicle Embun Perak".
2. "Chronicle Embun Perak" akan berakhir pada 12 Januari pukul 9:00 (GMT+8).
3. Setelah membuka "Chronicle Lanjutan", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
4. Perhatian: "Chronicle Lanjutan" yang dibuka dalam event ini hanya berlaku di event ini. Penjaga Rahasia diharapkan membelanjakan secara bijak.]]
  },
  Activity_123322_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_123323_ActivityName = {
    Text = "Tarian Domba Emas"
  },
  Activity_123323_ActivityTips = {
    Text = [[
<Title:Aturan Event>
1. Setelah Penjaga Rahasia menyelesaikan misi Chronicle yang ditentukan, hadiah dapat diklaim di "Tarian Domba Emas".
2. "Tarian Domba Emas" akan berakhir pada 26 Januari pukul 9:00 (GMT+8).
3. Setelah membuka "Chronicle Lanjutan", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
4. Perhatian: "Chronicle Lanjutan" yang dibuka dalam event ini hanya berlaku di event ini. Penjaga Rahasia diharapkan membelanjakan secara bijak.]]
  },
  Activity_123323_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_124049_ActivityName = {Text = "Otak Busuk"},
  Activity_124049_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Otak Busuk\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup\"Meltdown·Dor\"untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_124050_ActivityName = {
    Text = "Rasul Lautan"
  },
  Activity_124050_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Rasul Lautan\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Miriam untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_124051_ActivityName = {
    Text = "Pengorbanan Jurang·Reprise"
  },
  Activity_124051_ActivityPlot = {
    Text = [[
Di atas bayangan Aequor, mimpi sang Raja memudar, dan kerajaan dewa telah mengalami pembusukan. 
Dia datang dari ilusi hari-hari lampau, melangkah ke reruntuhan masa depan yang runtuh. 
Dia bertanya kepada Jurang, namun Jurang tetap bungkam. 
Dia memberikan persembahan kepada Jurang, dan yang menjawabnya hanyalah dirinya sendiri.]]
  },
  Activity_124051_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Tanggapan dari Jurang yang Dalam\""
  },
  Activity_124051_ActivityTips = {
    Text = "<Title:Ikhtisar Aktivitas>\n1, Selama periode aktivitas, Penjaga dapat mengumpulkan mata uang acara melalui gameplay terbatas \"Kelahiran Ranah Dewa\", \"Perintah Raja\", dan \"Hadiah Prestasi\". Mata uang acara dapat digunakan untuk persembahan dalam \"Respons dari Abyss\" untuk mendapatkan hadiah item, termasuk roda takdir SR eksklusif acara \"Panggilan Aequor\", Batu filsuf, Inti murni, Inti Lumen, dan lainnya.\n2, Selama periode aktivitas, \"Lanskap mimpi: Profanasi\" akan dibuka gratis, dan menyelesaikan prestasi acara juga akan mendapatkan avatar eksklusif acara \"Atas nama Kunci Perak: Miryam\"!\n\n<Title: Waktu Aktivitas>\n1, 9 Maret 9:00 - 23 Maret 9:00 (GMT+8), semua konten acara dapat diikuti.\n2, 23 Maret 9:00 - 30 Maret 9:00 (GMT+8), hanya \"Respons dari Abyss\" dan \"Hadiah Prestasi\" yang akan tetap tersedia, konten lainnya telah berakhir dan tidak dapat diikuti.\n\n<Title: Kelahiran Ranah Dewa>\n1, \"Kelahiran Ranah Dewa\" terdiri dari 5 tingkat, yang dibuka secara otomatis setiap 2 hari.\n2, Setiap tantangan akan menghabiskan \"Menophin\"× 120, dan keberhasilan tantangan akan mendapatkan mata uang acara.\n3, Setelah menyelesaikan tingkat, fitur \"Reproduksi\" dari tingkat tersebut akan terbuka. Harap dicatat: saat menggunakan fitur \"Reproduksi\", tidak akan mendapatkan affiniti.\n4, Dapat menggunakan bantuan alumni dan \"Resonansi: Ritual Ombak\" untuk membantu menyelesaikan tingkat dengan lebih mudah.\n\n<Title: Bonus Pemujaan>\n1, Penjaga yang memiliki tubuh bangkit tertentu atau roda takdir (tidak perlu diturunkan) dapat membuat \"Kelahiran Ranah Dewa\" tingkat tugas hadiah \"Air mata pengorbanan\".\"Darah pengorbanan\", dan \"Sum-sum pengorbanan\" mendapatkan bonus drop tambahan (termasuk reproduksi), detail bonus sebagai berikut:\n· Tubuh bangkit \"Miryam\": Mencerahkan 0/1/2/3 dan seterusnya, bonus 20%/30%/40%/50%\n· Roda takdir SSR \"Kekuatan dari yang saleh\": Posisi Tumpuk 0/1/2/3 dan seterusnya, bonus 20%/30%/40%/50%\n· Roda takdir SR \"Panggilan Aequor\": Posisi Tumpuk 0/1/2/3 dan seterusnya, bonus 20%/30%/40%/50%\n2, Bonus \"Pemujaan\" dari tubuh bangkit atau roda takdir yang berbeda dihitung secara akumulatif.\n3, Khususnya, hadiah tantangan pertama untuk tingkat kegilaan tidak akan terpengaruh oleh bonus \"Pemujaan\".\n\n<Title: Resonansi: Ritual Ombak>\n1, Penjaga dapat memperoleh \"Hati yang Beriman\" dengan menyelesaikan prestasi acara.\n2, Menghabiskan \"Hati yang Beriman\", mengaktifkan \"Resonansi: Ritual Ombak\", dapat memperoleh bonus berikut:\n(1)Membuat Penjaga menjadi lebih kuat dalam gameplay acara \"Kelahiran Ranah Dewa\", tantangan menjadi lebih mudah.\n(2)Meningkatkan mata uang acara yang diperoleh setelah menyelesaikan tantangan \"Kelahiran Ranah Dewa\".\n(3)Mengaktifkan gameplay acara \"Perintah Raja\".\n\n<Title: Perintah Raja>\n· Setelah mengaktifkan resonansi \"Ujian Pengorbanan\", secara otomatis mendapatkan 60 \"Air mata pengorbanan\" setiap jam, maksimum dapat disimpan selama 25 jam.\n\n<Title: Respons dari Abyss>\n1, \"Respons dari Abyss\" memiliki tiga altar, waktu pembukaan sebagai berikut:\n· \"Altar Air Mata Bercahaya\": 9 Maret 9:00 ~ 30 Maret 9:00.\n· \"Altar Darah Gorila\": 11 Maret 9:00 ~ 30 Maret 9:00.\n· \"Altar Jiwa\": 13 Maret 9:00 ~ 30 Maret 9:00.\n2, Setiap persembahan akan menghabiskan \"Air mata pengorbanan\"/\"Darah pengorbanan\"/\"Sum-sum pengorbanan\"× 750, dan secara acak mendapatkan lima hadiah item dari altar.\n3, Hadiah item dari setiap altar dibagi menjadi dua jenis: \"Item Spesial\" dan \"Item Umum\", saat direset dapat mengatur ulang jumlah sisa hadiah item tertentu ke batas maksimum, aturan spesifik sebagai berikut:\n(1)Tiga reset pertama: ketika \"Item Spesial\" tidak memiliki sisa jumlah, Penjaga dapat memilih untuk mereset, setelah reset akan mengatur ulang jumlah sisa \"Item Spesial\" dan \"Item Umum\" ke batas maksimum; juga dapat memilih untuk melanjutkan persembahan, ketika \"Item Umum\" juga tidak memiliki sisa jumlah, harus melakukan reset untuk melanjutkan persembahan.\n(2)Reset mulai ke-4: hanya dapat dilakukan reset setelah \"Item Umum\" tidak memiliki sisa jumlah, reset akan mengatur ulang jumlah sisa \"Item Umum\" ke batas maksimum, \"Item Spesial\" tidak akan direset lagi.\n\n<Title: Lanskap mimpi>\n1, Selama periode aktivitas \"Lanskap mimpi: Profanasi\" akan dibuka gratis.\n2, Setelah aktivitas berakhir, progres investigasi \"Lanskap mimpi: Profanasi\" akan disimpan, jika selama periode aktivitas tidak membuka \"Lanskap mimpi: Profanasi\", setelah aktivitas berakhir masih dapat menghabiskan \"Titik awal realitas\"×7 untuk membuka.\n3, Baik selama periode aktivitas atau tidak, setelah menyelesaikan \"Lanskap mimpi: Profanasi\" dapat memperoleh \"Posse: Festival Ombak\".\n\n<Title: Kompensasi Replikasi>\n1, Penjaga yang telah membuka \"Lanskap mimpi: Profanasi\" sebelumnya, akan mendapatkan kompensasi \"Air mata pengorbanan\"×700 saat membuka kembali selama periode aktivitas replikasi ini.\n2, Penjaga yang telah memperoleh avatar eksklusif acara \"Atas nama Kunci Perak: Miryam\" sebelumnya, saat memperoleh kembali akan secara otomatis diubah menjadi \"Undangan dari Yang Tidak Berbentuk\"×1.\n3, Penjaga yang telah memperoleh bahan aktivasi resonansi \"Hati yang Beriman\" sebelumnya, setiap kali mendapatkan 1 tambahan \"Hati yang Beriman\" akan secara otomatis diubah menjadi \"Rose Scrip\"×5000.\n"
  },
  Activity_124051_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_124052_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_124053_ActivityName = {Text = "Ratu Duri"},
  Activity_124053_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Ratu Duri\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Wanda untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_124800_ActivityName = {Text = "Giliranku"},
  Activity_124801_ActivityName = {
    Text = "Pembalikan Fase"
  },
  Activity_124801_ActivityPlot = {
    Text = [[
"Aku akan membuat semua orang bermain Traphase!"
Seorang pendatang dari ruang waktu lain secara tidak sengaja memasuki ruang Traphase, mengubahnya menjadi sesuatu yang sangat berbeda dari sebelumnya.
Untuk membalikkan ruang ini kembali, Penjaga dari berbagai ruang waktu harus menentukan seorang pemenang terkuat untuk menantang pendatang ini.]]
  },
  Activity_124801_ActivityTips = {
    Text = "<Title: Deskripsi Kegiatan>\n1. Selama periode kegiatan, Penjaga dapat menyelesaikan pencapaian dalam \"Traphase\" untuk menerima \"Hadiah Prestasi\" dan mendapatkan \"Buah Ekork Ajaib\".\n2. \"Buah Ekork Ajaib\" dapat ditukar dengan hadiah yang kaya di \"Hadiah Giliran\", termasuk avatar terbatas acara \"Giliranku: Kartu Myriad\", 10 ekspresi terbatas acara, serta hadiah seperti \"Pecahan Mimpi\" dan \"Mimpi Sisa Bintang\".\n3. Selama periode kegiatan, \"Koneksi Multidimensi: Giliran Balik\" akan dibuka secara gratis!\n4. Penjaga yang telah menyelesaikan \"Koneksi Multidimensi: Giliran Balik: Tamu dari Dunia Lain\" selama periode kegiatan, latar belakang pertempuran \"Traphase\" akan diganti sementara menjadi \"Giliran Balik: Ruang Kesadaran\".\n\n<Title: Hadiah Prestasi>\n1. \"Hadiah Prestasi\" mencakup \"Ujian Rahasia\".\"Ujian Kehormatan\".\"Ujian Ambang\", Penjaga dapat memperoleh \"Buah Ekork Ajaib\" dengan menyelesaikan target pencapaian.\n2. Dalam pencapaian \"Ujian Rahasia\"\n· Setiap mengalahkan 3 Awakeners lawan, Penjaga akan mendapatkan \"Buah Ekork Ajaib\"× 10, maksimal dapat diselesaikan 50 kali.\n· Setiap melepaskan 6 kali Exalt, Penjaga akan mendapatkan \"Buah Ekork Ajaib\"× 10, maksimal dapat diselesaikan 50 kali.\n· Setiap memainkan 20 kartu, Penjaga akan mendapatkan \"Buah Ekork Ajaib\"× 10, maksimal dapat diselesaikan 50 kali.\n3. \"Awakener\".\"Roda takdir\".\"Posse\" yang dibuka sementara akan dihitung dalam \"Hadiah Prestasi\". Pertandingan Persahabatan dan pertarungan sandi tidak akan dihitung dalam \"Hadiah Prestasi\".\n\n<Title: Hadiah Giliran>\n1. Penjaga dapat mengumpulkan \"Buah Ekork Ajaib\" untuk menerima hadiah yang sesuai, mengumpulkan \"Buah Ekork Ajaib\"× 3600 akan mendapatkan semua hadiah inti, mengumpulkan \"Buah Ekork Ajaib\"× 6000 akan mendapatkan semua hadiah!\n2. Setelah menyelesaikan \"Giliran Balik: Tamu dari Dunia Lain\", kunci hadiah mengumpulkan 100-900 \"Buah Ekork Ajaib\", setelah menyelesaikan \"Giliran Balik: Momen Pembalikan Segalanya\", kunci hadiah mengumpulkan 1000-6000 \"Buah Ekork Ajaib\".\n\n<Title: Koneksi Multidimensi>\n1. Selama periode kegiatan, \"Koneksi Multidimensi: Giliran Balik\" akan dibuka secara gratis.\n2. Setelah kegiatan berakhir, kemajuan penyelidikan di \"Koneksi Multidimensi: Giliran Balik\" akan tetap, jika \"Koneksi Multidimensi: Giliran Balik\" tidak dibuka selama periode kegiatan, setelah kegiatan berakhir tetap dapat menghabiskan \"Titik awal realitas\"×3 untuk membuka kunci.\n3. Baik selama periode kegiatan atau tidak, setelah menyelesaikan \"Koneksi Multidimensi: Giliran Balik\", Penjaga akan mendapatkan \"Posse: Pintu taverna\".\n\n<Title: Waktu Kegiatan>\nKegiatan ini hanya akan dibuka dari 16 Maret 9:00 hingga 30 Maret 9:00 (GMT+8), setelah 30 Maret 9:00 (GMT+8) kegiatan akan berakhir, mohon diingat untuk mengambil hadiah di \"Hadiah Giliran\""
  },
  Activity_124801_BannerText = {
    Text = "Aktivitas Spesial Dibuka Terbatas!"
  },
  Activity_124801_UnlockConditionExplanation = {
    Text = "Setelah menyelesaikan \"Operasi\"3-2·Normal, akan terbuka."
  },
  Activity_124834_ActivityName = {
    Text = "Atas Nama Kabut"
  },
  Activity_124834_ActivityPlot = {
    Text = "Malam Sebelum Lupa × Urutan Kabut\nUndangan Spesial Kolaborasi\n\n\"Moxia, tim investigasi… oh bukan, sekarang sudah bukan pelopor tim investigasi lagi. Kalau begitu, izinkan aku memperkenalkan diriku lagi — namaku Moxia, hanya seorang gadis yang imut~\""
  },
  Activity_124834_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event \"Atas Nama Kabut\", setelah menyelesaikan Bab 1 Aksi Investigasi \"Rahasia Distrik Timur\", kamu bisa mendapatkan Awakened Body SSR limited baru \"Moxia\" secara gratis!\n·Saat mendapatkan Awakened Body SSR yang sama untuk ke-2 hingga ke-16 kalinya, setiap kali akan dikonversi menjadi 1 Fragmen Awakened Body yang sesuai dan \"Endapan Akar\" × 50; mulai perolehan ke-17 dan seterusnya, Awakened Body SSR limited akan dikonversi menjadi \"Fragmen Inti Roh Murni\" × 2, \"Fragmen Inti Roh\" × 6, dan \"Endapan Akar\" × 250."
  },
  Activity_124834_BannerText = {
    Text = "Klaim Kebangkitan Limited Gratis"
  },
  Activity_124981_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_124982_ActivityName = {
    Text = "Pasien Terbelah·Chaos"
  },
  Activity_124982_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara \"Pasien Skizofren·Kaos\" berlangsung, Penjaga dapat menggunakan susunan tim preset sistem yang mencakup \"24\", untuk menikmati tingkat yang ditentukan tanpa batas.\n·Saat menikmati tingkat acara, Awakener dalam susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Acara>\n·Setelah berhasil menyelesaikan tantangan tingkat untuk pertama kalinya, hadiah percobaan dapat diambil di antarmuka acara."
  },
  Activity_124983_ActivityName = {
    Text = "Pasien Terbelah·Daging Darah"
  },
  Activity_124983_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara \"Pasien skizofren · Caro\" berlangsung, Penjaga dapat menggunakan susunan tim preset sistem yang mencakup \"24\", untuk menikmati tingkat yang ditentukan tanpa batas.\n·Saat menikmati tingkat acara, Awakener dalam susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Acara>\n·Setelah berhasil menyelesaikan tantangan tingkat untuk pertama kalinya, hadiah percobaan dapat diambil di antarmuka acara."
  },
  Activity_124984_ActivityName = {
    Text = "Puisi Tanpa Nama"
  },
  Activity_124984_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Puisi Tanpa Nama\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Aurla untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_124985_ActivityName = {
    Text = "Pasien Terbelah·Laut Dalam"
  },
  Activity_124985_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara \"Pasien Skizofren·Laut Dalam\" berlangsung, Penjaga dapat menggunakan susunan tim preset sistem yang mencakup \"24\", untuk menikmati tingkat yang ditentukan tanpa batas.\n·Saat menikmati tingkat acara, Awakener dalam susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Acara>\n·Setelah berhasil menyelesaikan tantangan tingkat untuk pertama kalinya, hadiah percobaan dapat diambil di antarmuka acara."
  },
  Activity_124986_ActivityName = {
    Text = "Pasien Terbelah·Hyperdimensi"
  },
  Activity_124986_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara \"Pasien Skizofren·Ultra\" berlangsung, Penjaga dapat menggunakan susunan tim preset sistem yang mencakup \"24\", untuk menikmati tingkat yang ditentukan tanpa batas.\n·Saat menikmati tingkat acara, Awakener dalam susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Acara>\n·Setelah berhasil menyelesaikan tantangan tingkat untuk pertama kalinya, hadiah percobaan dapat diambil di antarmuka acara."
  },
  Activity_124987_ActivityName = {
    Text = "Penyembuhan Multi·Replika"
  },
  Activity_124987_ActivityPlot = {
    Text = [[
Hysteria, juga dikenal sebagai Histeria, gejala kejiwaan.
Di zaman kalian, itu memiliki arti yang sama dengan kematian.

Untungnya, para ilmuwan dan penyelidik di Universitas mythag juga sudah gila: mereka bertekad untuk mengatasi masalah ini]]
  },
  Activity_124987_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Analisis Kepribadian\""
  },
  Activity_124987_ActivityTips = {
    Text = "<Title:Deskripsi Aktivitas>\n1, Selama periode aktivitas, Penjaga dapat mengumpulkan mata uang acara \"Puzzle Memori\" melalui gameplay terbatas \"Kode Memori\".\"Penyimpanan Tepi\", dan \"Hadiah Prestasi\". \"Puzzle Memori\" dapat digunakan untuk membeli barang di \"Analisis Kepribadian\", termasuk Roda Takdir SR terbatas acara \"Tekad Ikan Kod Perak\".Inti Lumen, Inti Murni, dan lainnya. \n2, Selama periode aktivitas, \"Rekam Jejak: Fisi Damai\" dapat dibuka secara gratis untuk waktu terbatas, dan menyelesaikan prestasi acara juga akan mendapatkan avatar terbatas acara \"Atas nama Kunci Perak: \"24\"\"!\n\n<Title:Waktu Aktivitas>\n1, 23 Februari 9:00 - 9 Maret 9:00 (GMT+8), semua gameplay acara dapat diikuti. \n2, 9 Maret 9:00 - 16 Maret 9:00 (GMT+8), hanya dapat mengikuti \"Analisis Kepribadian\" dan Hadiah Prestasi.\n\n<Title:Kode Memori>\n1, \"Kode Memori\" terdiri dari 5 level, yang otomatis dibuka setiap 2 hari. \n2, Setiap tantangan akan menghabiskan \"Menophin\"× 120, dan keberhasilan tantangan akan mendapatkan mata uang acara. \n3, Setelah menyelesaikan level, fitur \"Reproduksi\" untuk level tersebut akan dibuka. Harap diperhatikan: saat menggunakan fitur \"Reproduksi\", tidak akan mendapatkan tingkat afinitas. \n4, Anda dapat menggunakan bantuan alumni dan \"Resonansi: Sindrom Pemisahan\" untuk membantu Anda menyelesaikan level dengan lebih mudah.\n\n<Title:Bonus Rasional>\n1, Penjaga yang memiliki Pembangun atau Roda Takdir tertentu (tidak perlu diturunkan) dapat memberikan bonus tambahan pada \"Puzzle Memori\" yang diperoleh dari tugas level \"Kode Memori\", bonus spesifik adalah sebagai berikut: \n· Pembangun \"24\": Pencerahan 0/1/2/3 dan lebih, bonus 20%/30%/40%/50%. \n· Roda Takdir SSR \"Restitusi Tubuh Terdistorsi\": Posisi Tumpuk 0/1/2/3 dan lebih, bonus 20%/30%/40%/50%. \n· Roda Takdir SR \"Tekad Ikan Kod Perak\": Posisi Tumpuk 0/1/2/3 dan lebih, bonus 20%/30%/40%/50%. \n2, Bonus \"Rasional\" dari Pembangun atau Roda Takdir yang berbeda dihitung secara kumulatif. \n3, Secara khusus, hadiah tantangan pertama untuk kesulitan kegilaan tidak akan dipengaruhi oleh bonus \"Rasional\". \n\n<Title:Resonansi: Sindrom Pemisahan>\n1, Penjaga dapat memperoleh \"Hati yang Terbelah\" dengan menyelesaikan prestasi acara. \n2, Menghabiskan \"Hati yang Terbelah\" untuk mengaktifkan \"Resonansi: Sindrom Pemisahan\", dapat memperoleh bonus berikut: \n(1) Membuat Penjaga lebih kuat dalam gameplay acara \"Kode Memori\" dan \"Rekam Jejak: Fisi Damai\", tantangan menjadi lebih mudah. \n(2) Meningkatkan hadiah yang diperoleh setelah menyelesaikan tantangan \"Kode Memori\". \n(3) Mengaktifkan gameplay acara \"Penyimpanan Tepi\".\n\n<Title:Penyimpanan Tepi>\n1, Setelah mengaktifkan resonansi \"Diagnosis: Skizofrenia\", secara otomatis mendapatkan \"Puzzle Memori α\"× 60 setiap jam, maksimum dapat disimpan selama 25 jam. \n2, Setelah mengaktifkan resonansi \"Kesadaran Bersama\", secara otomatis mendapatkan \"Puzzle Memori β\"× 30 setiap jam, maksimum dapat disimpan selama 25 jam. \n\n<Title:Rekam Jejak>\n1, Selama periode aktivitas, \"Rekam Jejak: Fisi Damai\" dapat dibuka secara gratis. \n2, Setelah aktivitas berakhir, kemajuan investigasi \"Rekam Jejak: Fisi Damai\" akan disimpan, menyelesaikan kejadian investigasi yang belum selesai selama periode aktivitas juga akan mendapatkan hadiah investigasi yang sama dengan periode aktivitas. Jika selama periode aktivitas \"Rekam Jejak: Fisi Damai\" belum dibuka, setelah aktivitas berakhir, masih dapat menghabiskan \"Titik Awal Realitas\"×7 untuk membuka kunci. \n3, Baik selama periode aktivitas atau tidak, setelah menyelesaikan \"Rekam Jejak: Fisi Damai\", Anda dapat memperoleh \"Posse: Semua Tentang \"Dia\"\".\n\n<Title:Kompenasi Replikasi>\n1, Penjaga yang sebelumnya sudah membuka \"Rekam Jejak: Fisi Damai\", akan mendapatkan kompensasi \"Puzzle Memori α\"×700 saat membuka kembali selama periode aktivitas replikasi ini. \n2, Penjaga yang sebelumnya sudah mendapatkan avatar terbatas acara \"Atas nama Kunci Perak: \"24\"\", saat mendapatkan kembali secara otomatis akan diubah menjadi \"Undangan dari Yang Tidak Berbentuk\"×1. \n3, Penjaga yang sebelumnya sudah memperoleh bahan aktivasi resonansi \"Hati yang Terbelah\", setiap mendapatkan 1 \"Hati yang Terbelah\" tambahan akan secara otomatis diubah menjadi \"Rose Scrip\"×5000. \n"
  },
  Activity_124987_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_124988_ActivityName = {
    Text = "Pencabut Jiwa"
  },
  Activity_124988_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Pencabut Jiwa\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Rantai Darah·Shilo untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_125364_ActivityName = {
    Text = "Berita Lama Hai Cheng"
  },
  Activity_125364_ActivityPlot = {
    Text = [[
Kekuasaan, cinta, kemewahan, di atas altar yang dipenuhi mayat di dalam rumah besar, keberadaan kuno perlahan membuka mata. 
 Ah, tetapi ini bukanlah cerita yang menakutkan, Dia "mencintai"mu, Dia akan selalu "melindungi"mu... Dia akan menyerahkan semua yang "terbaik" kepada mu.]]
  },
  Activity_125364_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Rumah Terabaikan\""
  },
  Activity_125364_ActivityTips = {
    Text = "<Title:Ringkasan Aktivitas>\nSelama periode aktivitas, Penjaga dapat mengumpulkan mata uang acara \"Permen pir\" melalui mode terbatas \"Xuan Nü Tanpa Wajah\" dan \"Hadiah Prestasi\". \"Permen pir\" dapat ditukarkan di \"Rumah Terabaikan\" untuk hadiah, termasuk Roda takdir SR eksklusif acara \"Umpan Melati\", Inti Lumen, Inti murni, Fragmentasi Batu Bijaksana, Kristal Mimik, dan lainnya. \n\n<Title:Xuan Nü Tanpa Wajah>\n1,\"Xuan Nü Tanpa Wajah\" terdiri dari 9 level bahan yang dapat langsung bertarung tanpa eksplorasi, dibuka satu per hari. \n2, Setiap tantangan akan menghabiskan \"Menophin\"× 120, dan keberhasilan tantangan akan memberikan bahan pelatihan dan mata uang acara. \n3, Setelah menyelesaikan level, fitur \"Reproduksi\" untuk level tersebut akan dibuka. Harap diperhatikan: ketika menggunakan fitur \"Reproduksi\", tidak akan mendapatkan afiniti. \n4, Dapat menggunakan bantuan alumni untuk membantu Anda menyelesaikan level dengan lebih mudah. \n\n<Title:Bonus Aktivitas>\n1, Penjaga yang memiliki Awakeners atau Roda takdir tertentu (tidak perlu diatur) dapat memberikan bonus tambahan pada jumlah \"Permen pir\" yang diperoleh dari tugas level \"Xuan Nü Tanpa Wajah\" (termasuk Reproduksi), rincian bonus sebagai berikut: \n·Awakener \"Xu\": Mencerahkan 0/1/2/3 dan lebih, bonus 20%/30%/40%/50% \n·Roda takdir SSR \"Sia-sia mengerutkan alis\": Posisi Tumpuk 0/1/2/3 dan lebih, bonus 20%/30%/40%/50% \n·Roda takdir SR \"Umpan Melati\": Posisi Tumpuk 0/1/2/3 dan lebih, bonus 20%/30%/40%/50% \n2, Bonus \"aktivitas\" dari Awakener atau Roda takdir yang berbeda dihitung secara akumulatif. \n3, Secara khusus, hadiah tantangan pertama untuk tingkat kegilaan tidak akan terpengaruh oleh bonus di atas. \n\n<Title:Rumah Terabaikan>\n1, Setiap kali \"Memberi Nafkah\" akan menghabiskan 750 \"Permen pir\", secara acak mendapatkan lima hadiah barang dari \"Rumah Terabaikan\". \n2, Hadiah barang dari \"Rumah Terabaikan\" dibagi menjadi dua jenis: \"Item Spesial\" dan \"Item Umum\", saat reset dapat mengatur ulang jumlah sisa hadiah item spesial ke batas maksimum, aturan spesifik sebagai berikut: \n(1)Reset 5 kali pertama: Ketika \"Item Spesial\" tidak ada sisa, Penjaga dapat memilih untuk mereset, setelah reset jumlah sisa \"Item Spesial\" dan \"Item Umum\" akan diatur ulang ke batas maksimum; dapat juga memilih untuk terus bertukar, ketika \"Item Umum\" juga tidak ada sisa, harus melakukan reset untuk melanjutkan pertukaran. \n(2)Reset ke-6 dan seterusnya: Ketika \"Item Umum\" tidak ada sisa, baru dapat melakukan reset, reset akan mengatur ulang jumlah sisa \"Item Umum\" ke batas maksimum, \"Item Spesial\" tidak akan direset lagi. \n\n<Title:Menyelam>\n1, Selama periode aktivitas, \"Ngobrol Malam di Bawah Kipas\" dapat dibuka secara gratis. \n2, Setelah aktivitas berakhir, kemajuan penyelidikan \"Ngobrol Malam di Bawah Kipas\" akan tetap ada, dan menyelesaikan kejadian penyelidikan yang belum selesai selama periode aktivitas juga dapat memperoleh hadiah penyelidikan yang sama seperti selama periode aktivitas. Jika \"Ngobrol Malam di Bawah Kipas\" tidak dibuka selama periode aktivitas, setelah aktivitas berakhir tetap dapat menghabiskan \"Titik awal realitas\"×3 untuk membukanya. \n3, Baik selama atau setelah periode aktivitas, setelah menyelesaikan \"Menyelam: Ngobrol Malam di Bawah Kipas\" dapat memperoleh \"Posse: Kisah Rumah Tua\". \n\n<Title:Waktu Aktivitas>\n1, 26 Januari 9:00 - 9 Februari 9:00 (GMT+8), semua konten dalam ringkasan aktivitas dapat diikuti. \n2, 9 Februari 9:00 - 16 Februari 9:00 (GMT+8), hanya \"Rumah Terabaikan\" dan \"Hadiah Prestasi\" yang dipertahankan, konten lainnya telah berakhir dan tidak dapat diikuti. \n3, Setelah 16 Februari 9:00 (GMT+8), \"Permen pir\" yang belum ditukarkan akan dikumpulkan dengan rasio setiap satu ditukar menjadi \"Rose Scrip\"× 40, harap Penjaga perhatikan untuk memeriksa email."
  },
  Activity_125364_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_125366_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_125366_ActivityPlot = {
    Text = [[
Setelah membeli, "Xu" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, Membuka Ledakan Transenden>]]
  },
  Activity_125367_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_125368_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_125368_ActivityPlot = {
    Text = "Setelah membeli, \"Xu\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_126275_ActivityName = {
    Text = "Penenun yang Terikat"
  },
  Activity_126275_ActivityPlot = {
    Text = "Roda pintal berputar perlahan, tak pernah berhenti sejak zaman purba. Menarilah mengikuti benang, wahai Penenun Agung. Takdir adalah panggung yang tak bisa kau tinggalkan.\nHakim. Penebus. Tuan. Tahanan…\nSaat melangkah ke panggung ini, peran yang menjadi milikmu, sudah lama tak bisa dipilih."
  },
  Activity_126275_ActivityStageEndContent = {
    Text = "Event telah berakhir, saat ini hanya dapat mengikuti\"Toko Suvenir Teater\""
  },
  Activity_126275_ActivityTips = {
    Text = "<Title:Deskripsi Kegiatan>\nSelama periode kegiatan, Penjaga dapat mengumpulkan mata uang kegiatan \"Tiket kursi beludru\" melalui gameplay terbatas \"Panggung Boneka\" dan \"Hadiah Prestasi\". \"Tiket kursi beludru\" dapat ditukar dengan hadiah di \"Toko Hadiah Teater\", termasuk Roda takdir SR terbatas kegiatan \"Roda Benang Takdir\", Inti Kosong, Inti murni, Fragmentasi Batu Bijaksana, Kristal Mimik, dan lainnya.\n\n<Title:Panggung Boneka>\n1, \"Panggung Boneka\" terdiri dari 5 level bahan yang dapat dilawan langsung tanpa eksplorasi, satu level dibuka setiap 2 hari.\n2, Setiap tantangan akan menghabiskan \"Menophin\" × 120, dan keberhasilan tantangan akan mendapatkan bahan pengembangan dan mata uang kegiatan.\n3, Setelah menyelesaikan level, fungsi \"Reproduksi\" untuk level tersebut akan dibuka. Harap dicatat: saat menggunakan fungsi \"Reproduksi\", tidak dapat memperoleh Affiniti.\n4, Dapat menggunakan bantuan alumni untuk membantu Anda menyelesaikan tantangan dengan lebih mudah.\n\n<Title:Tambahan Kegiatan>\n1, Penjaga yang memiliki Awakener atau Roda takdir tertentu (tidak perlu di lapangan) dapat membuat hadiah tugas level \"Panggung Boneka\" mendapatkan tambahan jatuh ekstra untuk \"Tiket kursi beludru\" (termasuk Reproduksi), rincian tambahan sebagai berikut:\n· Awakener \"Arachne\": Mencerahkan 0/1/2/3 dan lebih, tambahan 20%/30%/40%/50%\n· Roda takdir SSR \"Jaringan Penenunan Abadi\": Posisi Tumpuk 0/1/2/3 dan lebih, tambahan 20%/30%/40%/50%\n· Roda takdir SR \"Roda Benang Takdir\": Posisi Tumpuk 0/1/2/3 dan lebih, tambahan 20%/30%/40%/50%\n2, \"Tambahan aktivitas\" untuk Awakener atau Roda takdir yang berbeda dihitung dengan cara penumpukan.\n3, Khususnya, hadiah tantangan pertama di tingkat Kegilaan tidak akan terpengaruh oleh tambahan di atas.\n\n<Title: Toko Hadiah Teater>\n1, Setiap \"Penukaran Hadiah\" akan menghabiskan 750 \"Tiket kursi beludru\", mendapatkan secara acak lima hadiah dari \"Toko Hadiah Teater\".\n2, Hadiah dari \"Toko Hadiah Teater\" dibagi menjadi dua jenis: \"Item Spesial\" dan \"Item Umum\", saat reset dapat mengatur ulang jumlah sisa hadiah item spesial ke batas maksimum, aturan spesifik sebagai berikut:\n(1) Lima reset pertama: Ketika \"Item Spesial\" tidak ada jumlah sisa, Penjaga dapat memilih untuk mereset, setelah reset akan mengatur ulang jumlah sisa \"Item Spesial\" dan \"Item Umum\" ke batas maksimum; juga dapat memilih untuk melanjutkan pertukaran, ketika \"Item Umum\" juga tidak ada jumlah sisa, harus melakukan reset untuk melanjutkan pertukaran.\n(2) Reset keenam dan seterusnya: Hanya dapat mereset setelah \"Item Umum\" tidak ada jumlah sisa, reset akan mengatur ulang jumlah sisa \"Item Umum\" ke batas maksimum, \"Item Spesial\" tidak akan direset lagi.\n\n<Title:Waktu Kegiatan>\n1, 20 April 9:00 - 18 Mei 9:00 (GMT+8), semua konten dalam deskripsi kegiatan dapat diikuti.\n2, 18 Mei 9:00 - 25 Mei 9:00 (GMT+8), hanya \"Toko Hadiah Teater\" dan \"Hadiah Prestasi\" yang dipertahankan, konten lainnya telah berakhir dan tidak dapat diikuti.\n3, Setelah 25 Mei 9:00 (GMT+8), \"Tiket kursi beludru\" yang belum ditukar akan ditarik kembali dengan rasio setiap penukaran \"Rose Scrip\" × 40, harap Penjaga perhatikan untuk memeriksa email."
  },
  Activity_126275_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_126365_ActivityName = {
    Text = "Chronicle Benang Takdir"
  },
  Activity_126365_ActivityTips = {
    Text = [[
Aturan Aktivitas:
1. Setelah Penjaga Rahasia menyelesaikan misi Chronicle yang ditentukan, hadiah dapat diklaim di "Chronicle Benang Takdir".
2. "Chronicle Benang Takdir" dibuka secara permanen.
3. Setelah membuka "Chronicle Premium", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
4. Harap diperhatikan: "Chronicle Premium" yang dibuka dalam aktivitas ini hanya berlaku untuk aktivitas ini. Penjaga Rahasia diharapkan untuk berbelanja secara bijak.]]
  },
  Activity_126366_ActivityName = {
    Text = "Persembahan Kenangan Perjalanan·Bab Bintang V"
  },
  Activity_126366_ActivityPlot = {
    Text = "Sebuah memori tersegel dan diarsipkan, sebuah perjalanan tercatat dalam masa lalu. Saat mengenang, jangan lupa persembahkan penghormatan yang tulus."
  },
  Activity_126492_ActivityName = {
    Text = "Antologi Negeri Kuno"
  },
  Activity_126492_ActivityTips = {
    Text = "<Title: Antologi Negeri Kuno>\n·Perjalanan terbatas waktu ini mencakup 8 paket hadiah, di mana paket pertama dapat diklaim secara gratis, paket ke-2 hingga ke-8 harus membeli \"Antologi Negeri Kuno\" terlebih dahulu sebelum dapat diklaim.\n·Setelah membeli \"Antologi Negeri Kuno\", hadiah paket ke-2 dapat langsung diklaim; paket selanjutnya perlu menunggu waktu tertentu sebelum dapat diklaim.\n·Membeli \"Antologi Negeri Kuno\" sebelum 26 Januari 9:00 akan mendapatkan hadiah tambahan: Avatar eksklusif \"Wujud Sejati dalam Kipas\", \"Undangan Sang Tak Terlihat\" ×10! Pembelian setelah 26 Januari 9:00 tidak akan lagi mendapatkan hadiah eksklusif terbatas waktu.\n· Setelah pembelian, durasi perjalanan terbatas waktu ini akan menjadi permanen, dan aktivitas akan ditutup keesokan harinya setelah semua paket hadiah diklaim.\n·\"Antologi Negeri Kuno\" memiliki batas waktu pembelian, setelah lewat tidak dapat dibeli lagi. Mohon Penjaga Rahasia membeli sebelum 23 Februari 9:00 sesuai pertimbangan."
  },
  Activity_126492_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_127173_ActivityName = {Text = "Pelukis"},
  Activity_127173_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara\"Pelukis\"berlangsung, Keeper dapat menggunakan tim preset sistem yang menyertakan Pickman untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage acara, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Acara>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman acara."
  },
  Activity_129488_ActivityName = {
    Text = "Kereta Kegembiraan Berkecepatan Tinggi"
  },
  Activity_129488_ActivityPlot = {
    Text = "Di atas kereta, suara geraman kesal terus terdengar dari kabin mewah.\n\"Salvador, gerbong ketiga butuh bantuan!\"\n\"Wanda, kirim musuh yang kau kendalikan ke bagian belakang kereta, mereka mengejar!\"\n\"Lake! Berhenti menggoda! Cepat kemari dan usir makhluk di luar jendelaku!\"\nKau yang sedang kewalahan di kompartemen mewah, sama sekali tidak menyadari bahwa sosok mungil telah diam-diam menyelinap ke sakumu.\n\"Hihihi, memang begini baru seru.\"\n\"Rekaman yang bagus~ Nah, selanjutnya — saatnya asisten kecil 'N' beraksi~\""
  },
  Activity_129488_ActivityTips = {
    Text = "<Title:Pengantar Aktivitas>\n1. Selama periode aktivitas, Penjaga Rahasia dapat memperoleh hadiah terbatas yang melimpah melalui\"Jalur Kereta\". Setelah aktivitas berakhir, hadiah di\"Jalur Kereta\"tidak dapat diklaim lagi. Harap klaim hadiah terbatas tepat waktu.\n2. Selama periode aktivitas, berpartisipasi dalam\"Keberangkatan Kereta\"akan mendapatkan kompensasi level, dengan aturan sebagai berikut:\n  ·Dalam tim investigasi, Awakened yang levelnya kurang dari level 60 akan dikompensasi hingga level 60 dalam tantangan ini.\n  ·Dalam tim investigasi, Awakened yang level skill-nya kurang dari level 5 akan dikompensasi hingga level 5 dalam tantangan ini.\n  ·Dalam tim investigasi, Awakened yang level\"Pertanda Kegilaan\"kurang dari level 6 akan dikompensasi hingga level 6 dalam tantangan ini.\n  ·Dalam tim investigasi, Awakened yang level\"Adaptasi Pembentukan Roh\"kurang dari level 5 akan dikompensasi hingga level 5 dalam tantangan ini.\n  ·Jika level Penjaga Rahasia kurang dari level 60, akan dikompensasi hingga level 60 dalam tantangan ini.\n\n<Title:Catatan Ekspedisi>\n1. Selama periode aktivitas,\"Catatan Ekspedisi: Kereta Menuju Festival Doa Tahun Baru\"akan dibuka secara gratis.\n2. Setelah aktivitas berakhir, progres investigasi\"Catatan Ekspedisi: Kereta Menuju Festival Doa Tahun Baru\"akan disimpan. Jika\"Catatan Ekspedisi: Kereta Menuju Festival Doa Tahun Baru\"belum dibuka selama periode aktivitas, setelah aktivitas berakhir masih dapat dibuka dengan menggunakan\"Titik Awal Realitas\"×7.\n3. Baik selama maupun di luar periode aktivitas, setelah menyelesaikan\"Catatan Ekspedisi: Kereta Menuju Festival Doa Tahun Baru\"kamu akan mendapatkan\"Kunci Perintah: Kembang Api Akhir Tahun\".\n\n<Title:Kereta Kegembiraan Berkecepatan Tinggi>\n1.\"Kereta Kegembiraan Berkecepatan Tinggi\"adalah mode tantangan berkelanjutan yang menggunakan aturan\"Bab Bintang\". Penjaga Rahasia akan menghadapi tantangan berkelanjutan melawan berbagai bos akhir dari operasi investigasi dalam pertemuan acak yang beragam!\n2. Batas kepemilikan Artefak dalam gameplay dapat ditingkatkan hingga maksimal 36 buah.\n3. Selama tantangan, kamu dapat memiliki dan memperkuat 3 efek\"Resonansi\"yang kuat dari operasi investigasi secara bersamaan.\n4. Setiap 1 kali penggunaan Entitas Gnosis Darurat akan mengurangi 20%\"Poin VIP\"yang diperoleh dari tantangan tersebut.\n5. Mendukung keluar di tengah jalan dan menyimpan progres, tetapi status tim tidak akan diperbarui sesuai perubahan pengembangan eksternal. Progres disimpan paling lama hingga 7 hari setelah tantangan terakhir. Jika tidak melanjutkan tantangan selama periode penyimpanan, tantangan dianggap ditinggalkan dan progres tidak lagi disimpan.\n\n<Title:Daftar VIP>\n1. Selama periode aktivitas, catatan di\"Daftar VIP\"akan disimpan. Setelah aktivitas berakhir, catatan akan di-reset mengikuti siklus aktivitas Akademi.\n2.\"Daftar VIP\"mencatat Penjaga Rahasia dengan performa tantangan yang luar biasa. Penjaga Rahasia yang menantang 1 kali selama setiap periode aktivitas Akademi dan berhasil memperoleh\"Poin VIP\"dapat masuk ke\"Daftar VIP\".\n3. Peringkat\"Daftar VIP\"didasarkan pada\"Poin VIP\"tertinggi yang diperoleh dalam satu tantangan dan\"Jumlah Giliran\"paling sedikit yang digunakan. Kamu dapat menantang ulang untuk meningkatkan peringkat.\n\n<Title:Waktu Aktivitas>\n1. 9 Februari 9:00 - 9 Maret 9:00 (GMT+8), semua konten aktivitas dapat diikuti.\n2. Setelah 9 Maret 9:00 (GMT+8), aktivitas akan diarsipkan ke\"Koridor Memori\", dan hadiah di\"Jalur Kereta\"tidak dapat diklaim lagi."
  },
  Activity_129488_BannerText = {
    Text = "Event mode permainan spesial baru dibuka!"
  },
  Activity_129508_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_129509_ActivityName = {
    Text = "Cahaya Awal Tahun"
  },
  Activity_129509_ActivityTips = {
    Text = [[
Aturan Event:
1, Setelah login setiap hari, Penjaga Rahasia dapat mengklaim hadiah harian di "Cahaya Awal Tahun".
2, Hadiah akan dibuka secara berurutan berdasarkan total login kumulatif Penjaga Rahasia. Hadiah check-in harian akan direset pada pukul 9(GMT+8).]]
  },
  Activity_129509_BannerText = {
    Text = "Check-in untuk mendapatkan Silver Core dan banyak hadiah"
  },
  Activity_129705_ActivityName = {
    Text = "Penguasa Ledakan Api"
  },
  Activity_129705_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Penguasa Ledakan Api\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Caligula untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_129706_ActivityName = {
    Text = "Uskup Pengasih"
  },
  Activity_129706_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Uskup Pengasih\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Salvador untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_130174_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_130175_ActivityName = {
    Text = "Kelahiran Kembali yang Terbalik"
  },
  Activity_130175_ActivityPlot = {
    Text = [[
Dunia ini sungguh terlalu sepi, dunia ini sungguh terlalu tandus, dengarkanlah, saksikanlah.
Daging yang merintih menunggu dalam keheningan yang panjang, menunggu bunga dandelion mekar di padang pasir.
Kemudian ia akan dipenuhi oleh cinta yang bersinar gemilang, dan terlahir kembali sekali lagi.]]
  },
  Activity_130175_ActivityStageEndContent = {
    Text = "Aktivitas telah berakhir, saat ini hanya dapat berpartisipasi di \"Kebun Dandelion\""
  },
  Activity_130175_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1, Selama aktivitas berlangsung, Penjaga dapat mengumpulkan mata uang aktivitas \"Sisik Putih Murni\"\"Sisik Merah\"\"Sisik Bercahaya\" melalui gameplay terbatas waktu \"Catatan Ruang Gelap\" dan \"Hadiah Prestasi\", serta menukarkan barang di \"Kebun Dandelion\", termasuk Roda takdir SR terbatas aktivitas \"Dongeng Ternoda\", Inti Lumen, Inti murni, dan lainnya.\n2, Selama aktivitas berlangsung,\"Tautan Multidimensi: Benih Cinta Yang Terlupakan\" dapat dibuka secara gratis untuk waktu terbatas, dan menyelesaikan pencapaian aktivitas juga dapat memperoleh avatar terbatas aktivitas \"Atas nama Kunci Perak: Saya\"!\n\n<Title:Waktu Aktivitas>\n1,30 Mei 9:00 - 24 Agustus 9:00(GMT+8), semua Aktivitas Gameplay dapat diikuti.\n2,24 Agustus 9:00 - 31 Agustus 9:00(GMT+8), hanya dapat mengikuti \"Kebun Dandelion\" dan Hadiah Prestasi.\n\n<Title:Catatan Ruang Gelap>\n1,\"Catatan Ruang Gelap\" berisi 7 Tingkat, setiap hari akan otomatis membuka 1 Tingkat.\n2, Setiap tantangan akan menghabiskan \"Menophin\" × 120, keberhasilan tantangan akan mendapatkan mata uang aktivitas.\n3, Setelah Menyelesaikan tahap, fitur \"Reproduksi\" untuk Tingkat tersebut akan terbuka. Harap diperhatikan: saat menggunakan fitur \"Reproduksi\", Affiniti tidak dapat diperoleh.\n4, Kamu dapat menggunakan Bantuan Bertarung dari asosiasi alumni untuk membantu melewati Tingkat dengan lebih mudah.\n\n<Title: Kebun Dandelion>\n1,\"Kebun Dandelion\" memiliki tiga toko, waktu pembukaan sebagai berikut:\n·\"Kebun Pembibitan\": Dibuka pada 30 Mei pukul 9.\n·\"Kebun Pertumbuhan\": Dibuka pada 31 Mei pukul 9.\n·\"Kebun Mekar\": Dibuka pada 1 Juni pukul 9.\n2, Setiap penukaran akan menghabiskan \"Sisik Putih Murni\"/\"Sisik Merah\"/\"Sisik Bercahaya\" × 750, dan secara acak mendapatkan lima hadiah item dari \"Kebun Dandelion\".\n3, Hadiah item setiap \"Kebun Dandelion\" dibagi menjadi dua jenis yaitu \"Item Spesial\" dan \"Item Umum\", saat reset dapat mengembalikan jumlah sisa hadiah Item Spesial ke batas maksimum, aturan spesifiknya adalah:\n(1) 2 reset pertama: Ketika \"Item Spesial\" tidak memiliki sisa jumlah, Penjaga dapat memilih untuk mereset, setelah reset jumlah sisa \"Item Spesial\" dan \"Item Umum\" akan dikembalikan ke batas maksimum; juga dapat memilih untuk melanjutkan penukaran, ketika \"Item Umum\" juga tidak memiliki sisa jumlah, harus melakukan reset untuk dapat melanjutkan penukaran.\n(2) Mulai reset ke-3: Reset hanya dapat dilakukan setelah \"Item Umum\" tidak memiliki sisa jumlah, reset akan mengembalikan jumlah sisa \"Item Umum\" ke batas maksimum,\"Item Spesial\" tidak akan direset lagi.\n\n<Title:Bonus Aktivitas>\n1, Penjaga yang memiliki Tubuh Terjaga atau Roda takdir tertentu(tidak perlu dipasang) dapat memperoleh bonus tambahan pada perolehan tiga jenis mata uang aktivitas dalam hadiah misi Tingkat \"Catatan Ruang Gelap\":\n·Tubuh Terjaga \"Saya\": Mencerahkan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda takdir SSR \"Morfogenesis Aromatik\": Posisi Tumpuk 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda takdir SR \"Dongeng Ternoda\": Posisi Tumpuk 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n2, Beberapa \"Bonus Aktivitas\" dapat ditumpuk dan dihitung bersama.\n3, Perhatikan, hadiah tantangan pertama kali Menyelesaikan tahap di Kegilaan tidak akan terpengaruh oleh \"Bonus Aktivitas\".\n\n<Title:Tautan Multidimensi>\n1, Selama aktivitas berlangsung,\"Tautan Multidimensi: Benih Cinta Yang Terlupakan\" dapat dibuka secara gratis.\n2, Setelah aktivitas berakhir, progres investigasi akan Retain, Investigasi kejadian yang belum selesai selama aktivitas tetap dapat diselesaikan setelah aktivitas berakhir dan mendapatkan hadiah yang sesuai. Jika belum terbuka selama aktivitas, setelah aktivitas berakhir masih dapat menghabiskan \"Titik awal realitas\" × 3 untuk membuka.\n3, Baik selama aktivitas maupun tidak, Menyelesaikan tahap \"Tautan Multidimensi: Benih Cinta Yang Terlupakan\" dapat memperoleh \"Posse: Demi Dunia Baru\"."
  },
  Activity_130175_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_130176_ActivityName = {
    Text = "Kelopak Cinta Mekar"
  },
  Activity_130176_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama periode aktivitas \"Kelopak Cinta Mekar\", Keeper dapat menggunakan tim preset sistem yang berisi Saya untuk mencoba stage yang ditentukan tanpa batas.\n·Saat mencoba stage aktivitas, Awakened Body dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_130376_ActivityName = {
    Text = "Teks sementara"
  },
  Activity_130376_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Teks Sementara\" berlangsung, Penjaga dapat menggunakan tim preset sistem yang berisi Bintang Senja·Tinkter untuk mengalami Tingkat yang ditentukan tanpa batas.\n·Saat mengalami Tingkat aktivitas, Awakener dalam Susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali mencapai tantangan Tingkat, dapat mengambil hadiah percobaan di antarmuka aktivitas."
  },
  Activity_130403_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_130403_ActivityPlot = {
    Text = [[
Setelah membeli, "Asal Augir" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, Membuka Ledakan Transenden>]]
  },
  Activity_130404_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_130404_ActivityPlot = {
    Text = [[
Setelah membeli, "Tsathoggua" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, Membuka Ledakan Transenden>]]
  },
  Activity_130406_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_130406_ActivityPlot = {
    Text = "Setelah membeli, \"Tsathoggua\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_130407_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_130407_ActivityPlot = {
    Text = "Setelah membeli, \"Ogier Asal\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_130408_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_130408_ActivityPlot = {
    Text = "Setelah membeli, \"Saya\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_130409_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_130409_ActivityPlot = {
    Text = [[
Setelah membeli, "Saya" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, Membuka Ledakan Transenden>]]
  },
  Activity_130921_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_130922_ActivityName = {Text = "Vortex"},
  Activity_130922_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara\"Pusaran\"berlangsung, Keeper dapat menggunakan tim preset sistem yang menyertakan Moss untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage acara, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Acara>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman acara."
  },
  Activity_130923_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_130923_ActivityPlot = {
    Text = [[
Setelah membeli, "Moss" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, Membuka Ledakan Transenden>]]
  },
  Activity_130924_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_130924_ActivityPlot = {
    Text = "Setelah membeli, \"Moss\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_130925_ActivityName = {
    Text = "Panggilan Meruskus"
  },
  Activity_130925_ActivityPlot = {
    Text = [[
Di kedalaman lautan, pusaran sedang menelan segalanya. 
Demon di bawah Muskus membuka mulut raksasanya, dengan setara mengundang semua makhluk yang mendekat. 
Ia berputar hari demi hari, mengaung berulang kali, memanggil orang yang ditakdirkan yang akan datang. 
Ayo, ayo, "Rumput Air" akan melilitmu, "Karang" akan menemanimu, di dasar laut yang gelap, kau ditakdirkan untuk menari dengan bencana. 
Dan bencana, juga akan menjawab permohonan terakhirmu. 
Selamat datang di rumah, orang yang ditakdirkan tanpa pilihan.]]
  },
  Activity_130925_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Gudang Mosk\""
  },
  Activity_130925_ActivityTips = {
    Text = "<Title:Deskripsi Kegiatan>\n1, Selama periode kegiatan, Penjaga dapat mengumpulkan mata uang acara \"Kerang Laut Nomor Satu\", \"Kerang Laut Nomor Dua\", dan \"Kerang Laut Nomor Tiga\" melalui gameplay terbatas \"Mosk dan Laut\" dan \"Hadiah Prestasi\". \"Kerang Laut Nomor Satu\", \"Kerang Laut Nomor Dua\", dan \"Kerang Laut Nomor Tiga\" dapat digunakan untuk membeli barang di \"Gudang Mosk\", termasuk SR Kunci Perak terbatas acara \"Kegilaan yang Terpenjara\", Inti Lumen, Inti Murni, dan lain-lain. \n2, Selama periode kegiatan, \"Yang berkelana: Kecanduan\" dapat dibuka secara gratis dalam waktu terbatas, dan menyelesaikan pencapaian acara juga akan memberikan avatar terbatas acara \"Atas nama Kunci Perak: Mosk\"!\n\n<Title: Waktu Kegiatan>\n1, 9 Maret 9:00 - 6 April 9:00 (GMT+8), semua gameplay acara dapat diikuti. \n2, 6 April 9:00 - 13 April 9:00 (GMT+8), hanya dapat mengikuti \"Gudang Mosk\" dan Hadiah Prestasi. \n\n<Title: Mosk dan Laut>\n1, \"Mosk dan Laut\" terdiri dari 7 tingkat, yang dibuka otomatis 1 tingkat setiap hari. \n2, Setiap tantangan akan menghabiskan \"Menophin\" × 120, dan berhasil menantang akan mendapatkan mata uang acara. \n3, Setelah menyelesaikan tingkat, fungsi \"Reproduksi\" untuk tingkat tersebut akan terbuka. Harap diperhatikan: saat menggunakan fungsi \"Reproduksi\", tidak akan mendapatkan Affiniti. \n4, Anda dapat menggunakan bantuan dari alumni untuk membantu Anda menyelesaikan tantangan dengan lebih mudah. \n\n<Title: Gudang Mosk>\n1, \"Gudang Mosk\" memiliki tiga toko, dengan waktu pembukaan sebagai berikut: \n· \"Peti Harta Karun Satu\": dibuka pada 9 Maret pukul 9. \n· \"Peti Harta Karun Dua\": dibuka pada 10 Maret pukul 9. \n· \"Peti Harta Karun Tiga\": dibuka pada 11 Maret pukul 9. \n2, Setiap pertukaran akan menghabiskan \"Kerang Laut Nomor Satu\"/\"Kerang Laut Nomor Dua\"/\"Kerang Laut Nomor Tiga\" × 750, secara acak mendapatkan lima hadiah barang dari \"Gudang Mosk\". \n3, Setiap hadiah barang dari \"Gudang Mosk\" dibagi menjadi dua jenis: \"Item Spesial\" dan \"Item Umum\", saat reset dapat mengatur ulang jumlah sisa hadiah item spesial ke batas maksimum, aturan spesifiknya adalah: \n(1) Reset dua kali pertama: ketika \"Item Spesial\" tidak memiliki jumlah sisa, Penjaga dapat memilih untuk mereset, setelah reset akan mengatur ulang jumlah sisa \"Item Spesial\" dan \"Item Umum\" ke batas maksimum; juga dapat memilih untuk terus bertukar, ketika \"Item Umum\" juga tidak memiliki jumlah sisa, harus melakukan reset untuk dapat terus bertukar. \n(2) Reset mulai dari ketiga: ketika \"Item Umum\" tidak memiliki jumlah sisa baru dapat melakukan reset, reset akan mengatur ulang jumlah sisa \"Item Umum\" ke batas maksimum, \"Item Spesial\" tidak akan direset lagi. \n\n<Title: Tambahan Kegiatan>\n1, Penjaga yang memiliki Awakener atau Kunci Perak tertentu (tidak memerlukan penempatan) dapat membuat hadiah tugas tingkat \"Gudang Mosk\" dalam \"Kerang Laut Nomor Satu\", \"Kerang Laut Nomor Dua\", \"Kerang Laut Nomor Tiga\" mendapatkan tambahan jatuh, tambahan spesifik sebagai berikut: \n· Awakener \"Mosk\": Mencerahkan 0/1/2/3 dan lebih, tambahan 20%/30%/40%/50%. \n· Kunci Perak SSR \"Surga yang Jauh\": Posisi Tumpuk 0/1/2/3 dan lebih, tambahan 20%/30%/40%/50%. \n· Kunci Perak SR \"Kegilaan yang Terpenjara\": Posisi Tumpuk 0/1/2/3 dan lebih, tambahan 20%/30%/40%/50%. \n2, \"Tambahan Kegiatan\" dari Awakener atau Kunci Perak yang berbeda dihitung dengan cara yang terakumulasi. \n3, Khususnya, hadiah tantangan pertama tingkat kesulitan Kegilaan tidak akan terpengaruh oleh \"Tambahan Kegiatan\". \n\n<Title: Yang Berkelana>\n1, Selama periode kegiatan, \"Yang berkelana: Kecanduan\" dapat dibuka secara gratis. \n2, Setelah kegiatan berakhir, kemajuan penyelidikan \"Yang berkelana: Kecanduan\" akan disimpan, menyelesaikan kejadian penyelidikan yang belum selesai selama periode kegiatan juga dapat mendapatkan hadiah penyelidikan yang sama dengan periode kegiatan. Jika \"Yang berkelana: Kecanduan\" tidak dibuka selama periode kegiatan, setelah kegiatan berakhir masih dapat menghabiskan \"Titik awal realitas\" ×3 untuk membukanya. \n3, Baik selama atau tidak selama periode kegiatan, setelah menyelesaikan \"Yang berkelana: Kecanduan\" dapat memperoleh \"Posse: Kesucian yang Tenggelam\"."
  },
  Activity_130925_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_131090_ActivityName = {
    Text = "Perjamuan yang Membara · Rerun"
  },
  Activity_131090_ActivityPlot = {
    Text = [[
Isarau, Kota di Danau, dikatakan sebagai Rumah Wanda. 
 Kali ini kamu akan melewati gerbang Mimpi, mencapai kelompok menara kuno yang dipenuhi dengan lidah lonceng...]]
  },
  Activity_131090_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Peti harta Wanda\""
  },
  Activity_131090_ActivityTips = {
    Text = "<Title:Deskripsi Kegiatan>\n1,Selama periode kegiatan, Penjaga dapat mengumpulkan mata uang kegiatan \"Os Tibia asli\", \"Amónito Daun Bundar\", \"Reruntuhan Spiral\" melalui gameplay terbatas \"Pesta Api\" dan \"Hadiah Prestasi\". Mata uang kegiatan dapat digunakan untuk membeli barang di \"Peti harta wanda\", termasuk SR Roda takdir terbatas kegiatan \"Pandangan Isarau\", Inti Lumen, Inti murni, dan lainnya.\n2,Selama periode kegiatan, \"Yang berkelana: Pesta Api\" dapat dibuka secara gratis untuk waktu terbatas, dan menyelesaikan pencapaian kegiatan juga akan memberikan avatar terbatas kegiatan \"Atas nama Kunci Perak: Wanda\"!\n\n<Title:Waktu Kegiatan>\n1,23 Maret 9:00 - 20 April 9:00 (GMT+8), semua gameplay kegiatan dapat diikuti.\n2,20 April 9:00 - 27 April 9:00 (GMT+8), hanya dapat berpartisipasi dalam \"Peti harta wanda\" dan Hadiah Prestasi.\n\n<Title:Kota di Danau>\n1,Kota di Danau memiliki 7 tingkat, satu tingkat akan dibuka secara otomatis setiap hari.\n2,Setiap tantangan akan menghabiskan \"Menophin\" × 120, dan jika tantangan berhasil, akan mendapatkan mata uang kegiatan.\n3,Setelah menyelesaikan tingkat, fitur \"Reproduksi\" untuk tingkat tersebut akan dibuka. Harap diperhatikan: saat menggunakan fitur \"Reproduksi\", tidak akan mendapatkan Affiniti.\n4,Anda dapat menggunakan bantuan Alumni dan \"Resonansi: Perintah Rahasia\" untuk membantu Anda menyelesaikan tingkat dengan lebih mudah.\n\n<Title:Bonus Khusus>\n1,Penjaga yang memiliki tubuh pengaktifan tertentu atau Roda takdir (tidak perlu disertakan) dapat memberikan bonus tambahan pada mata uang kegiatan yang diperoleh dari misi tingkat \"Kota di Danau\", dengan bonus sebagai berikut:\n·Tubuh pengaktifan \"Wanda\": Mencerahkan 0/1/2/3 dan seterusnya, bonus 20%/30%/40%/50%.\n·SSR Roda takdir \"Perintah Sang Ratu\": Posisi Tumpuk 0/1/2/3 dan seterusnya, bonus 20%/30%/40%/50%.\n·SR Roda takdir \"Pandangan Isarau\": Posisi Tumpuk 0/1/2/3 dan seterusnya, bonus 20%/30%/40%/50%.\n2,\"Bonus Khusus\" dari tubuh pengaktifan atau Roda takdir yang berbeda dihitung dengan cara yang dapat ditumpuk.\n3,Secara khusus, hadiah tantangan pertama untuk tingkat Kegilaan tidak akan terpengaruh oleh \"Bonus Khusus\".\n\n<Title:Resonansi: Perintah Rahasia>\n1,Penjaga dapat memperoleh \"Hati Kesenangan\" dengan menyelesaikan pencapaian kegiatan.\n2,Menghabiskan \"Hati Kesenangan\", mengaktifkan \"Resonansi: Perintah Rahasia\", dapat membuat Penjaga menjadi lebih kuat di \"Kota di Danau\", tantangan menjadi lebih mudah; juga dapat membuat Penjaga mendapatkan mata uang kegiatan tambahan saat menyelesaikan tingkat.\n\n<Title:Yang Berkelana>\n1,Selama periode kegiatan, \"Pesta Api\" dapat dibuka secara gratis.\n2,Setelah kegiatan berakhir, kemajuan investigasi \"Pesta Api\" akan dipertahankan, dan menyelesaikan kejadian investigasi yang belum diselesaikan selama periode kegiatan juga dapat memperoleh hadiah investigasi yang sama dengan periode kegiatan. Jika \"Pesta Api\" tidak dibuka selama periode kegiatan, setelah kegiatan berakhir, Anda masih dapat menghabiskan \"Titik awal realitas\" ×3 untuk membuka kuncinya.\n3,Baik selama periode kegiatan atau tidak, setelah menyelesaikan \"Pesta Api\", Anda dapat memperoleh \"Posse: Pesta Kebusukan\".\n\n<Title:Kompenasi Replikasi>\n1,Penjaga yang telah membuka \"Yang berkelana: Pesta Api\" sebelumnya, saat membuka kembali selama periode kegiatan replikasi ini akan mendapatkan kompensasi \"Os Tibia asli\" ×300.\n2,Penjaga yang sebelumnya telah memperoleh avatar terbatas kegiatan \"Atas nama Kunci Perak: Wanda\", saat memperoleh ulang akan otomatis diubah menjadi \"Undangan dari Yang Tidak Berbentuk\" × 1.\n3,Penjaga yang sebelumnya telah memperoleh bahan aktivasi resonansi \"Hati Kesenangan\", setiap kali memperoleh 1 \"Hati Kesenangan\" yang berlebih akan otomatis diubah menjadi \"Rose Scrip\" ×5000.\n"
  },
  Activity_131090_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_131091_ActivityName = {Text = "Pesta Api"},
  Activity_131370_ActivityName = {
    Text = "Pemenang Beruntung"
  },
  Activity_131370_ActivityTips = {
    Text = [[
<Title:Aturan Aktivitas>
1, Setelah Penjaga Rahasia menyelesaikan misi perjalanan yang ditentukan, hadiah dapat diklaim di "Pemenang Beruntung".
2,"Pemenang Beruntung" akan berakhir pada 6 April 9:00.
3, Setelah membuka "Perjalanan Premium", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
4, Perhatian:"Perjalanan Premium" yang dibuka dalam aktivitas ini hanya berlaku di aktivitas ini. Mohon Penjaga Rahasia berbelanja secara bijak.]]
  },
  Activity_131370_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_131849_ActivityName = {
    Text = "Kenangan Abadi"
  },
  Activity_131849_ActivityTips = {
    Text = "<Title: Kenangan Abadi>\n·Kronik terbatas waktu ini berisi 8 paket, di mana paket pertama dapat diklaim secara gratis langsung, paket ke-2 hingga ke-8 memerlukan pembelian \"Kenangan Abadi\" sebelum dapat diklaim.\n·Setelah membeli \"Kenangan Abadi\", paket ke-2 dapat langsung diklaim; paket selanjutnya perlu menunggu waktu tertentu sebelum dapat diklaim.\n·Membeli \"Kenangan Abadi\" sebelum 30 Mei pukul 9:00 akan memberikan hadiah tambahan: Avatar eksklusif \"Berburu dengan Gembira\", \"Undangan Sang Tak Terlihat\" ×10! Pembelian setelah 30 Mei pukul 9:00 tidak lagi memberikan hadiah eksklusif terbatas waktu.\n·Pembelian \"Kenangan Abadi\" memiliki batas waktu, tidak dapat dibeli lagi setelah melewati batas waktu. Harap Keeper mempertimbangkan untuk membeli sebelum 29 Juni pukul 9:00."
  },
  Activity_131849_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_132331_ActivityName = {
    Text = "Nyonya Merah"
  },
  Activity_132331_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara\"Red Lady\"berlangsung, Keeper dapat menggunakan tim preset sistem yang menyertakan\"Soreil\"untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage acara, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Acara>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman acara."
  },
  Activity_132332_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_132333_ActivityName = {
    Text = "Pemulihan Raja Dewa"
  },
  Activity_132333_ActivityPlot = {
    Text = [[
Dalam doa yang penuh dahaga tanpa akhir, Dia sejenak tersadar dari tidur panjang-Nya, melemparkan satu tatapan sejati ke dunia yang membosankan ini.
Dalam kehidupan abadi, tatapan itu begitu singkat.]]
  },
  Activity_132333_ActivityStageEndContent = {
    Text = "Event telah berakhir, saat ini hanya dapat mengikuti\"Jurang Kesadaran\""
  },
  Activity_132333_ActivityTips = {
    Text = "<Title:Pengantar Event>\n1. Selama event berlangsung, Penjaga Rahasia dapat mengumpulkan mata uang event\"Pikiran Lesu\",\"Pikiran Sedih\",\"Pikiran Gembira\"melalui gameplay terbatas\"Tatapan Laut Dalam\"dan\"Hadiah Pencapaian\". Mata uang event dapat digunakan untuk membeli barang di\"Jurang Kesadaran\", termasuk Roda Takdir SR edisi terbatas event\"Takhta Batu Biru\", Inti Lumen, Inti Tanpa Noda, Serpihan Batu Bijak, Kristal Mimesis, dll.\n2. Selama event berlangsung, selesaikan pencapaian event untuk mendapatkan avatar edisi terbatas event\"Atas Nama Kunci Perak: Thulu\", Roda Takdir SR edisi terbatas event\"Takhta Batu Biru\", Inti Perak, dan banyak mata uang event!\n\n<Title:Waktu Event>\n1. 6 April 9:00 - 4 Mei 9:00 (GMT+8), semua gameplay event dapat diikuti.\n2. 4 Mei 9:00 - 11 Mei 9:00 (GMT+8), hanya dapat mengikuti\"Jurang Kesadaran\"dan Hadiah Pencapaian.\n\n<Title:Tatapan Laut Dalam>\n1.\"Tatapan Laut Dalam\"memiliki 5 level, 1 level terbuka otomatis setiap 2 hari.\n2. Setiap tantangan akan mengonsumsi\"Psychopeptide\"× 120, tantangan berhasil akan mendapatkan mata uang event.\n3. Setelah menyelesaikan level, fungsi\"Pemutaran Ulang\"level tersebut akan terbuka. Perhatian: Saat menggunakan fungsi\"Pemutaran Ulang\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Kamu dapat menggunakan bantuan tempur Asosiasi Alumni untuk membantumu menyelesaikan level dengan lebih mudah.\n\n<Title:Bonus Pikiran>\n1. Penjaga Rahasia yang memiliki Awakened atau Roda Takdir tertentu (tidak perlu diturunkan) dapat memperoleh bonus drop tambahan untuk mata uang event dari hadiah misi level\"Tatapan Laut Dalam\", detail bonus sebagai berikut:\n·Awakened\"Thulu\": Kebangkitan Roh 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda Takdir SSR\"Kidung Raja Dewa\": Superposisi 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda Takdir SR\"Takhta Batu Biru\": Superposisi 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n2.\"Bonus Pikiran\"dari Awakened atau Roda Takdir yang berbeda dihitung secara kumulatif. \n3. Khususnya, hadiah tantangan penyelesaian pertama tingkat kesulitan Gila tidak akan terpengaruh oleh\"Bonus Pikiran\".\n\n<Title: Jurang Kesadaran>\n1.\"Jurang Kesadaran\"hanya dibuka selama 6 April 9:00 - 11 Mei 9:00 (GMT+8).\n2. Setelah 11 Mei 9:00 (GMT+8), sisa\"Pikiran Lesu\",\"Pikiran Sedih\",\"Pikiran Gembira\"yang belum ditukarkan akan dikembalikan dengan rasio setiap unit ditukar menjadi\"Kupon Emas Mawar\"× 40. Penjaga Rahasia harap periksa surat.\n\n<Title:Penyelaman Kesadaran>\n1. Selama event berlangsung,\"Penyelaman Kesadaran: Hari Penobatan\"dapat dibuka secara gratis.\n2. Setelah event berakhir, progres investigasi\"Penyelaman Kesadaran: Hari Penobatan\"akan disimpan. Menyelesaikan event investigasi yang belum selesai selama event juga dapat memperoleh hadiah investigasi yang sama seperti saat event. Jika\"Penyelaman Kesadaran: Hari Penobatan\"tidak dibuka selama event, setelah event berakhir masih dapat dibuka dengan mengonsumsi\"Titik Awal Realitas\"×3.\n3. Baik selama maupun di luar periode event, setelah menyelesaikan\"Penyelaman Kesadaran: Hari Penobatan\"kamu dapat memperoleh\"Perintah Kunci: Perlindungan Bintang-Bintang\".\n\n<Title:Kompensasi Rerun>\n1. Penjaga Rahasia yang sebelumnya sudah membuka\"Penyelaman Kesadaran: Hari Penobatan\", saat membuka kembali selama event rerun ini akan mendapatkan kompensasi\"Pikiran Lesu\"×300.\n2. Penjaga Rahasia yang sebelumnya sudah mendapatkan avatar edisi terbatas event\"Atas Nama Kunci Perak: Thulu\", saat mendapatkannya kembali akan otomatis dikonversi menjadi\"Undangan Sang Tak Berwujud\"×1."
  },
  Activity_132333_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_132334_ActivityName = {
    Text = "Tuan yang Tertidur"
  },
  Activity_132334_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara\"Tuan yang Tertidur\"berlangsung, Keeper dapat menggunakan tim preset sistem yang menyertakan\"Thulu\"untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage acara, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Acara>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman acara."
  },
  Activity_132688_ActivityName = {
    Text = "Migrasi Komunikasi"
  },
  Activity_132688_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n 1, Setelah Penjaga menyelesaikan tugas aktivitas yang ditentukan, dapat diambil \"Inti Lumen\", avatar terbatas aktivitas \"Winkle·Terminal Besar\",\"Erica·Terminal Portabel\" dan \"Koleksi Perangko: Penjaga\", serta hadiah terbatas aktivitas lainnya seperti ilusi pakaian bintang 1 baru \"Nautila·Gema Ulir\",\"Helot·Saat Memutuskan\", dan lainnya! \n 2, Aktivitas ini dibuka secara permanen. Setelah menyelesaikan semua tugas dalam aktivitas dan mengambil semua hadiah, aktivitas ini akan berakhir dan tidak ditampilkan lagi setelah pukul 9:00(GMT+8) hari berikutnya.\n 3, Jika sebelumnya tugas \"Login menggunakan perangkat PC\" atau \"Login menggunakan perangkat mobile\" telah diselesaikan melalui fitur hadiah login, maka di sini tidak akan dihitung sebagai penyelesaian ulang."
  },
  Activity_132908_ActivityName = {
    Text = "Teks sementara"
  },
  Activity_132908_ActivityTips = {
    Text = [[
Aturan Aktivitas:
1, Setelah Penjaga Rahasia menyelesaikan misi perjalanan yang ditentukan, hadiah dapat diklaim di "Teks Sementara".
2, Setelah membuka "Perjalanan Premium", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
3,"Perjalanan Premium" kali ini memiliki batas waktu pembelian, setelah lewat tidak dapat dibeli lagi. Mohon Penjaga Rahasia membeli sebelum 20 Mei 9:00 sesuai pertimbangan.
6, Perhatian:"Perjalanan Premium" yang dibuka dalam aktivitas ini hanya berlaku di aktivitas ini. Mohon Penjaga Rahasia berbelanja secara bijak.]]
  },
  Activity_132908_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_132934_ActivityName = {
    Text = "Pemakaman Gelsemium"
  },
  Activity_132934_ActivityTips = {
    Text = "<Title:Pengantar>\n·Selama event berlangsung, Penjaga Rahasia dapat mengklaim hadiah yang sesuai di \"Pemakaman Gelsemium\" setelah menyelesaikan target yang ditentukan."
  },
  Activity_132934_BannerText = {
    Text = "Dapatkan Ilusi Pakaian gratis!"
  },
  Activity_133271_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_133272_ActivityName = {
    Text = "Penaklukan Agung · Rerun"
  },
  Activity_133272_ActivityPlot = {
    Text = [[
Sebuah era agung mungkin pada akhirnya akan lenyap, tetapi kehendak para pejuang agung tidak akan pernah padam.
Batu nisan tak mampu mengubur mereka, belenggu tak mampu menjinakkan mereka.
Ketika perjalanan baru muncul, daging panggang lezat melambai di ujung jalan penaklukan, para pejuang menyerbu maju, meraih piala kemenangan yang mulia itu.
Mari kita nyanyikan pujian untuk keberanian yang tak pernah padam ini, untuk kekaisaran suci ini!
Roma! Roma!]]
  },
  Activity_133272_ActivityStageEndContent = {
    Text = "Event telah berakhir, saat ini hanya dapat mengikuti\"Persembahan Upeti\""
  },
  Activity_133272_ActivityTips = {
    Text = "<Title:Pengenalan Event>\n1. Selama event berlangsung, Keeper dapat mengumpulkan mata uang event \"Daging Panggang Leo Lezat\" melalui mode terbatas \"Perburuan Suci\". \"Daging Panggang Leo Lezat\" dapat digunakan untuk membeli barang di \"Persembahan Upeti\", termasuk Inti Lumen, Inti Murni, dll.\n2. Selama event berlangsung, \"Visi Mimpi Lain: Penaklukan Dapur\" dapat dibuka secara gratis untuk waktu terbatas.\n\n<Title:Waktu Event>\n1. 4 Mei 9:00 - 18 Mei 9:00 (GMT+8), semua mode event dapat diikuti.\n2. 18 Mei 9:00 - 25 Mei 9:00 (GMT+8), hanya dapat mengikuti \"Persembahan Upeti\" dan Hadiah Pencapaian.\n\n<Title:Perburuan Suci>\n1. \"Perburuan Suci\" berisi 5 level, 1 level terbuka otomatis setiap 2 hari.\n2. Setiap tantangan akan mengonsumsi \"Psychopeptide\" × 120, tantangan berhasil akan memberikan mata uang event.\n3. Setelah menyelesaikan level, fungsi \"Replay\" level tersebut akan terbuka. Perhatian: Saat menggunakan fungsi \"Replay\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Kamu dapat menggunakan bantuan tempur Alumni untuk membantumu menyelesaikan level dengan lebih mudah.\n\n<Title: Persembahan Upeti>\nDi toko \"Persembahan Upeti\", kamu dapat menggunakan mata uang event \"Daging Panggang Leo Lezat\" untuk memilih dan langsung membeli barang.\n\n<Title:Visi Mimpi Lain>\n1. Selama event berlangsung, \"Visi Mimpi Lain: Penaklukan Dapur\" dapat dibuka secara gratis.\n2. Setelah event berakhir, progres investigasi \"Visi Mimpi Lain: Penaklukan Dapur\" akan disimpan. Menyelesaikan event investigasi yang belum selesai selama event juga akan memberikan hadiah investigasi yang sama seperti saat event berlangsung. Jika \"Visi Mimpi Lain: Penaklukan Dapur\" belum dibuka selama event, setelah event berakhir masih dapat dibuka dengan mengonsumsi \"Titik Awal Realitas\" ×7.\n3. Baik selama maupun di luar periode event, menyelesaikan \"Visi Mimpi Lain: Penaklukan Dapur\" akan memberikan \"Perintah Kunci: Tekad Berburu\"."
  },
  Activity_133272_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_133301_ActivityName = {
    Text = "Aroma Teh Fontaine"
  },
  Activity_133301_ActivityTips = {
    Text = [[
<Title:Aturan Acara>
1. Setelah Penjaga Rahasia menyelesaikan tugas Catatan Perjalanan yang ditentukan, hadiah dapat diambil di "Cita Rasa Teh Fontaine".
2. "Cita Rasa Teh Fontaine" akan berakhir pada 18 Mei pukul 09:00.
3. Setelah membuka kunci "Catatan Perjalanan Lanjutan", hadiah tambahan dapat diambil setelah menyelesaikan tugas.
4. Harap diperhatikan: "Catatan Perjalanan Lanjutan" yang dibuka dalam acara ini hanya berlaku selama acara berlangsung. Mohon Penjaga Rahasia bijak dalam berbelanja.]]
  },
  Activity_133301_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_134393_ActivityName = {
    Text = "Kepada Bintang-Bintang"
  },
  Activity_134393_ActivityPlot = {
    Text = "Login setiap hari untuk mengklaim Roda Takdir SSR edisi peringatan terbatas \"Kepada Bintang-Bintang\", total bisa diklaim 16 buah!"
  },
  Activity_134393_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama periode aktivitas, Keeper dapat mengklaim Roda Takdir SSR edisi peringatan terbatas \"Kepada Bintang-Bintang\" setiap hari setelah login di \"Kepada Bintang-Bintang\", dengan total 16 kali klaim.\n·Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Keeper. Hadiah login harian akan di-refresh pada pukul 9:00 (GMT+8)."
  },
  Activity_134393_BannerText = {
    Text = "Klaim Fate Wheel SSR Terbatas Gratis"
  },
  Activity_138582_ActivityName = {
    Text = "Pesta Teh Sakura"
  },
  Activity_138582_ActivityTips = {
    Text = [[
<Title:Aturan Event>
1. Setelah Penjaga Rahasia menyelesaikan misi perjalanan yang ditentukan, hadiah dapat diklaim di "Pesta Teh Sakura".
2. "Pesta Teh Sakura" akan berakhir pada 15 Juni pukul 09:00.
3. Setelah membuka "Perjalanan Premium", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
4. Harap diperhatikan: "Perjalanan Premium" yang dibuka dalam event ini hanya berlaku untuk event ini. Harap Penjaga Rahasia berbelanja secara bijak.]]
  },
  Activity_138582_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_139116_ActivityName = {
    Text = "Perjumpaan Bak Mimpi"
  },
  Activity_139116_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Setelah menyelesaikan misi Kronik yang ditentukan, Keeper dapat mengklaim hadiah di \"Perjumpaan Bak Mimpi\".\n·Setelah membuka \"Kronik Lanjutan\", Keeper dapat mengklaim hadiah tambahan setelah menyelesaikan misi.\n·Pembelian \"Kronik Lanjutan\" kali ini memiliki batas waktu, tidak dapat dibeli lagi setelah melewati batas waktu. Harap Keeper mempertimbangkan untuk membeli sebelum 29 Juni pukul 9:00 (GMT+8).\n·Perhatian: \"Kronik Lanjutan\" yang dibuka dalam aktivitas ini hanya berlaku untuk aktivitas ini. Harap Keeper membelanjakan secara bijak."
  },
  Activity_139116_BannerText = {
    Text = "Klaim Tubuh Kebangkitan Edisi Terbatas Baru secara gratis!"
  },
  Activity_139117_ActivityName = {
    Text = "Hadiah Mimpi Semu"
  },
  Activity_139117_ActivityTips = {
    Text = "<Title:Pengantar>\n·Selama periode event, Penjaga Rahasia dapat mengklaim hadiah yang sesuai di \"Hadiah Mimpi Semu\" setelah menyelesaikan tujuan yang ditentukan."
  },
  Activity_139117_BannerText = {
    Text = "Klaim Sisa Mimpi Bintang secara gratis!"
  },
  Activity_139591_ActivityName = {
    Text = "\"Balas Budi\" Kucing"
  },
  Activity_139591_ActivityPlot = {
    Text = "\"Pemberitahuan darurat, seluruh guru dan siswa harap segera menghentikan pekerjaan yang sedang dilakukan dan membantu menangkap subjek eksperimen yang melarikan diri.\"\n\"Diulang sekali lagi, seluruh guru dan siswa harap segera menghentikan pekerjaan yang sedang dilakukan dan membantu menangkap yang melarikan... Sial! Kucing-kucing ini sudah masuk!\"\nSaat kamu mendengar suara panik dari pengeras suara, seluruh kampus sudah dibanjiri bulu hitam, semua orang sibuk menangkap para penjahat kecil yang kabur dari laboratorium.\nSepertinya untuk membalas dendam Festival Qisui, kucing-kucing hitam ini perlahan dan teratur bergerak menuju asramamu.\nTapi yah… mengingat banyaknya Voucher Emas dan Inti Perak yang mereka bawa, sulit untuk mengatakan apakah mereka datang untuk balas dendam atau \"balas budi\".\nPerhatian, jangan menangkap berlebihan ya."
  },
  Activity_139591_ActivityStageEndContent = {
    Text = "Acara telah berakhir"
  },
  Activity_139591_ActivityTips = {
    Text = "<Title: \"Balas Budi\" Kucing>\n·\"Balas Budi\" Kucing berisi 7 stage tantangan langsung yang tidak dapat diulang, aktivitas membuka 1 stage per hari.\n·Setiap kali berhasil mengalahkan \"Kucing Hitam Dimensi\" yang sesuai, progres misi akan terakumulasi, dan Keeper dapat mengklaim hadiah terkait di \"Catatan Penangkapan Kucing Hitam\".\n·Setiap jenis \"Kucing Hitam Dimensi\" memiliki banyak klon, selama periode aktivitas Keeper dapat berpartisipasi dalam tantangan tanpa batas, tantangan mendukung pertarungan otomatis.\n·Setiap stage menyediakan artefak yang berbeda, yang akan memberikan bonus kuat untukmu.\n·Semua stage harus memilih bantuan tempur, sepanjang aktivitas, setiap Keeper yang saling mengikuti hanya dapat memberikan bantuan tempur untukmu satu kali.\n\n<Title: Kompensasi Level>\n·Dalam \"Balas Budi\" Kucing terdapat mekanisme kompensasi level, agar para Keeper dapat bertarung bersama!\nAturan kompensasi level sebagai berikut:\n  ·Dalam tim investigasi, Awakened Body yang levelnya di bawah 60 akan dikompensasi hingga level 60 dalam tantangan ini.\n  ·Dalam tim investigasi, Awakened Body yang level skillnya di bawah 5 akan dikompensasi hingga level 5 dalam tantangan ini.\n  ·Dalam tim investigasi, Awakened Body yang level \"Pertanda Kegilaan\"-nya di bawah 6 akan dikompensasi hingga level 6 dalam tantangan ini.\n  ·Dalam tim investigasi, Awakened Body yang level \"Adaptasi Roh Cetak\"-nya di bawah 5 akan dikompensasi hingga level 5 dalam tantangan ini.\n  ·Jika level Keeper di bawah 60, akan dikompensasi hingga level 60 dalam tantangan ini.\n\n<Title:Catatan Penangkapan Kucing Hitam>\n·Selama periode aktivitas, setelah Keeper mengalahkan \"Kucing Hitam Dimensi\" yang sesuai, progres misi terkait akan terakumulasi, dan hadiah dapat diklaim di \"Catatan Penangkapan Kucing Hitam\", yang terbagi menjadi \"Catatan Penangkapan Pribadi\" dan \"Catatan Penangkapan Kampus\". \"Catatan Penangkapan Pribadi\" adalah misi pribadi Keeper. \"Catatan Penangkapan Kampus\" adalah misi seluruh Keeper di kampus.\n\n<Title:Peringkat Penangkapan>\n·Selama periode aktivitas, Keeper dapat melihat \"Peringkat Jumlah Penangkapan\" dan \"Peringkat Jumlah Bantuan\" di \"Peringkat Penangkapan\".\n\n<Title:Waktu Aktivitas>\n· Sebelum 15 Juni pukul 9:00 (GMT+8), Keeper dapat memasuki halaman aktivitas untuk berpartisipasi. Setelah waktu tersebut, Keeper baru tidak dapat lagi bergabung dalam tantangan. Jika aktivitas belum berakhir, Keeper yang sudah berpartisipasi dapat melanjutkan tantangan.\n·Jika \"Total Penangkapan\" tercapai sebelum 15 Juni pukul 9:00 (GMT+8), maka aktivitas akan berakhir pada 29 Juni pukul 9:00 (GMT+8). Jika \"Total Penangkapan\" tidak tercapai sebelum 15 Juni pukul 9:00 (GMT+8), maka aktivitas akan berakhir 14 hari setelah \"Total Penangkapan\" tercapai."
  },
  Activity_139591_BannerText = {
    Text = "Aktivitas Spesial Dibuka Terbatas!"
  },
  Activity_139922_ActivityName = {
    Text = "Serangga Hipnotis"
  },
  Activity_139922_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Serangga Hipnotis\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Clementine untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_139923_ActivityName = {
    Text = "Simfoni Tak Berbentuk"
  },
  Activity_139923_ActivityPlot = {
    Text = [[
Simfoni adalah seni merajut, lintasan berbagai instrumen terjalin menjadi peta yang saling bersilangan.
Dalam jaring rajutannya, setiap not akan menjalankan perannya masing-masing.
Dengarkanlah, sebuah simfoni yang luar biasa segera dimulai.]]
  },
  Activity_139923_ActivityStageEndContent = {
    Text = "Event telah berakhir, saat ini hanya \"Istana Tidur Lelap\" yang dapat diikuti"
  },
  Activity_139923_ActivityTips = {
    Text = "<Title:Pengantar Event>\n1. Selama periode event, Penjaga Rahasia dapat mengumpulkan mata uang event \"Lembaran Nyaring\" melalui mode terbatas \"Suara Gemuruh\" dan \"Hadiah Pencapaian\". \"Lembaran Nyaring\" dapat ditukarkan dengan hadiah berlimpah di \"Istana Tidur Lelap\", termasuk Roda Takdir SR edisi terbatas event \"Pertunjukan Tanpa Henti\", \"Inti Tanpa Noda\", \"Inti Lumen\", \"Serpihan Batu Bijak\", \"Kristal Mimesis\", dan lainnya.\n2. Selama periode event, menyelesaikan misi \"Hadiah Pencapaian\" akan memberikan avatar edisi terbatas event \"Atas Nama Kunci Perak: Hamelin\", Roda Takdir SR edisi terbatas event \"Pertunjukan Tanpa Henti\", Inti Perak, dan sejumlah besar mata uang event \"Lembaran Nyaring\".\n\n<Title:Waktu Event>\n1. 15 Juni 9:00 - 13 Juli 9:00 (GMT+8), semua konten event dapat diikuti.\n2. 13 Juli 9:00 - 20 Juli 9:00 (GMT+8), hanya \"Istana Tidur Lelap\" dan \"Hadiah Pencapaian\" yang tersedia, konten lainnya telah berakhir dan tidak dapat diikuti.\n\n<Title: Suara Gemuruh>\n1. \"Suara Gemuruh\" berisi 9 level, dengan 1 level terbuka secara otomatis setiap hari.\n2. Setiap tantangan akan mengonsumsi \"Spiritpeptida\" × 120. Menantang level yang berbeda selain mendapatkan drop material yang berbeda, juga akan memberikan mata uang event \"Lembaran Nyaring\".\n3. Level event kali ini adalah level material pertarungan langsung, setelah diselesaikan dapat diulang! Setiap \"Pengulangan\" mengonsumsi \"Spiritpeptida\" × 120.\n4. Harap diperhatikan: Saat menggunakan fitur \"Pengulangan\", Tingkat Sinkronisasi tidak dapat diperoleh.\n\n<Title: Bonus Lembaran>\n1. Penjaga Rahasia yang memiliki Tubuh Kebangkitan atau Roda Takdir tertentu (tidak harus ditempatkan di tim) dapat memperoleh bonus drop tambahan untuk \"Lembaran Nyaring\" dari hadiah misi level \"Suara Gemuruh\" (termasuk pengulangan), detail bonus sebagai berikut:\n·Tubuh Kebangkitan \"Hamelin\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Requiem Abadi\": Tumpukan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Pertunjukan Tanpa Henti\": Tumpukan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Lembaran\" dari Tubuh Kebangkitan atau Roda Takdir yang berbeda dihitung secara kumulatif.\n3. Khususnya, hadiah tantangan penyelesaian pertama tingkat kesulitan Gila tidak akan terpengaruh oleh \"Bonus Lembaran\".\n\n<Title: Istana Tidur Lelap>\n1. \"Istana Tidur Lelap\" hanya dibuka selama 15 Juni 9:00 - 13 Juli 9:00 (GMT+8).\n2. Setelah 20 Juli 9:00 (GMT+8), sisa \"Lembaran Nyaring\" yang belum ditukarkan akan dikembalikan dengan rasio setiap unit ditukar menjadi \"Kupon Emas Mawar\" × 40, harap Penjaga Rahasia memperhatikan surat masuk."
  },
  Activity_139923_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_139924_ActivityName = {
    Text = "Pemain Abadi"
  },
  Activity_139924_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Pemain Abadi\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Hamelin untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_139925_ActivityName = {
    Text = "Wanita Aequor"
  },
  Activity_139925_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Deep Sea Lady\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Murphy untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_140080_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_140081_ActivityName = {
    Text = "Penguasa Ledakan Api"
  },
  Activity_140081_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Penguasa Ledakan Api\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Caligula untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_140082_ActivityName = {
    Text = "Ribu Cahaya Terang yang Jatuh·klon"
  },
  Activity_140082_ActivityPlot = {
    Text = [[
Mereka menyanyikan lagu yang tak pernah terlupakan, menyambut sang Tuan yang tak pernah padam.
Dia akan turun dari langit tertinggi membawa ribuan cahaya gemilang, menceritakan kemuliaan yang abadi.
Saat Dia tiba, cahaya amber menyelimuti dunia.
Ini adalah pemakaman yang Dia persembahkan untuk dunia.]]
  },
  Activity_140082_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat mengikuti \"Markas Tersembunyi\""
  },
  Activity_140082_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1, Selama aktivitas berlangsung, Penjaga dapat mengumpulkan mata uang aktivitas \"Cap Kekayaan\",\"Segel Kematian\",\"Perang\" Cap \"\" melalui gameplay terbatas waktu \"Buruan Abu\",\"Pesta Tanpa Konflik\", dan \"Hadiah Pencapaian\".\"Cap Kekayaan\",\"Segel Kematian\",\"Perang\" Cap \"\" dapat digunakan untuk membeli barang di \"Basis Tersembunyi\", termasuk Roda takdir SR terbatas aktivitas \"Matahari yang Mendekat\", Inti Lumen, Inti murni, dan lainnya.\n2, Selama aktivitas berlangsung,\"Siang Abadi\" dapat dibuka secara gratis untuk waktu terbatas, dan menyelesaikan pencapaian aktivitas juga akan memberikan avatar terbatas aktivitas \"Atas nama Kunci Perak: Katyugula\"!\n\n<Title:Waktu Aktivitas>\n1,7 September 9:00 - 5 Oktober 9:00(GMT+8), semua gameplay aktivitas dapat diikuti.\n2,5 Oktober 9:00 - 12 Oktober 9:00(GMT+8), hanya dapat mengikuti \"Basis Tersembunyi\" dan Hadiah Pencapaian.\n\n<Title:Buruan Abu>\n1,\"Buruan Abu\" terdiri dari 7 tingkat, setiap 1 hari akan otomatis membuka 1 tingkat.\n2, Setiap tantangan akan menghabiskan \"Menophin\" × 120, dan keberhasilan tantangan akan memberikan mata uang aktivitas.\n3, Setelah menyelesaikan tahap, fitur \"Reenact\" pada tingkat tersebut akan terbuka. Harap diperhatikan: saat menggunakan fitur \"Reenact\", Affiniti tidak dapat diperoleh.\n4, Kamu dapat menggunakan Bantuan Bertarung dari asosiasi alumni untuk membantu melewati tingkat dengan lebih mudah.\n\n<Title: Basis Tersembunyi>\n\"Basis Tersembunyi\" memiliki tiga toko, waktu pembukaan sebagai berikut:\n·\"Koleksi Harta Karun\": Dibuka pada 7 September pukul 9.\n·\"Ruang Komisi Rahasia\": Dibuka pada 8 September pukul 9.\n·\"Kampung Perang\": Dibuka pada 9 September pukul 9.\nDi dalam toko, kamu dapat memilih barang untuk dibeli langsung.\n\n<Title:Bonus Aktivitas>\n1, Penjaga yang memiliki Tubuh Terjaga atau Roda takdir tertentu(tidak perlu diturunkan ke lapangan) dapat memperoleh bonus drop tambahan untuk \"Cap Kekayaan\",\"Segel Kematian\",\"Perang\" Cap \"\" dalam hadiah misi tingkat \"Buruan Abu\", detail bonus sebagai berikut:\n·Tubuh Terjaga \"Katyugula\": Mencerahkan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda takdir SSR \"Kematian berwarna amber\": Posisi Tumpuk 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda takdir SR \"Matahari yang Mendekat\": Posisi Tumpuk 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n2,\"Bonus Aktivitas\" dari Tubuh Terjaga atau Roda takdir yang berbeda dihitung secara kumulatif.\n3, Secara khusus, hadiah tantangan pertama kali pada Kegilaan tidak akan terpengaruh oleh \"Bonus Aktivitas\".\n\n<Title: Pesta Tanpa Konflik>\n1, Setiap jam secara otomatis mendapatkan 60 \"Cap Kekayaan\", maksimal tersimpan selama 25 jam.\n\n<Title:Yang berkelana>\n1, Selama aktivitas berlangsung,\"Siang Abadi\" dapat dibuka secara gratis.\n2, Setelah aktivitas berakhir, progres investigasi \"Siang Abadi\" akan Retain, dan menyelesaikan Investigasi kejadian yang belum selesai selama aktivitas juga dapat memperoleh hadiah investigasi yang sama seperti saat aktivitas berlangsung. Jika \"Siang Abadi\" tidak dibuka selama aktivitas, setelah aktivitas berakhir masih dapat dibuka dengan menghabiskan \"Titik awal realitas\" ×3.\n3, Baik selama aktivitas maupun tidak, setelah Menyelesaikan tahap \"Yang berkelana: Siang Abadi\" dapat memperoleh \"Posse: Matahari yang Tidak Terbenam\"."
  },
  Activity_140082_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_140188_ActivityName = {
    Text = "Sumber Kasih Sayang"
  },
  Activity_140188_ActivityTips = {
    Text = "<Title:Pengantar>\n·Selama periode event, setelah Penjaga Rahasia mengekstraksi sejumlah Source Liquid yang ditentukan secara kumulatif di \"Ekstraksi Source Liquid\", hadiah terkait dapat diklaim di \"Aliran Kasih Sayang\".\n·Harap diperhatikan, Source Liquid yang diberikan secara gratis di \"Ekstraksi Source Liquid\" tidak akan dihitung ke dalam jumlah kumulatif ekstraksi Source Liquid dalam event."
  },
  Activity_140188_BannerText = {
    Text = "Aktivitas Spesial Dibuka Terbatas!"
  },
  Activity_140462_ActivityName = {
    Text = "Pembukaan Seribu Suara"
  },
  Activity_140462_ActivityTips = {
    Text = "<Title:Pengantar>\n·Selama periode event, Penjaga Rahasia dapat mengklaim hadiah terkait di \"Prelude of All Sounds\" setelah menyelesaikan tujuan yang ditentukan."
  },
  Activity_140462_BannerText = {
    Text = "Dapatkan Ilusi Pakaian gratis!"
  },
  Activity_140760_ActivityName = {
    Text = "Putra Suci·Malam Putih"
  },
  Activity_140760_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara\"Putra Suci·Malam Putih\"berlangsung, Keeper dapat menggunakan tim preset sistem yang menyertakan Pollux untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage acara, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Acara>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman acara."
  },
  Activity_140761_ActivityName = {
    Text = "Cahaya Dingin"
  },
  Activity_140761_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Cahaya Dingin\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Corpusant untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_140762_ActivityName = {
    Text = "Makhluk Mengerikan dalam Kabut"
  },
  Activity_140762_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara\"Makhluk Mengerikan dalam Kabut\"berlangsung, Keeper dapat menggunakan tim preset sistem yang menyertakan Mosha untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage acara, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Acara>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman acara."
  },
  Activity_140763_ActivityName = {
    Text = "Puisi Tanpa Nama"
  },
  Activity_140763_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Puisi Tanpa Nama\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Aurla untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_140764_ActivityName = {
    Text = "Penguasa Tulang Belulang"
  },
  Activity_140764_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Penguasa Tulang Belulang\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Dulcesein untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_141306_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_141306_ActivityPlot = {
    Text = "Setelah dibeli, \"Pontos\" dapat mengaktifkan <BlueQuality:Mencerahkan 3>"
  },
  Activity_141307_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_141307_ActivityPlot = {
    Text = [[
Setelah dibeli, "Pontos" dapat mengaktifkan
<BlueQuality:Pengembangan Kepribadian +4, membuka Ledakan Melampaui Batas>]]
  },
  Activity_141308_ActivityName = {
    Text = "Sumber Kedalaman Jurang"
  },
  Activity_141308_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Sumber Kedalaman Jurang\" berlangsung, Penjaga dapat menggunakan tim preset sistem yang berisi Pontos untuk mengalami tingkat yang ditentukan tanpa batas.\n·Saat mengalami tingkat aktivitas, Tubuh Terjaga dalam Susunan tim tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali berhasil menyelesaikan tantangan tingkat, dapat mengambil hadiah percobaan di antarmuka aktivitas."
  },
  Activity_141460_ActivityName = {
    Text = "Putra Suci·Sayap Hitam"
  },
  Activity_141460_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Putra Suci·Sayap Hitam\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Castor untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_141462_ActivityName = {
    Text = "Tuan yang Tertidur"
  },
  Activity_141462_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Tuan yang Tertidur\" berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Thulu untuk mencoba level yang ditentukan tanpa batas.\n·Saat mencoba level aktivitas, formasi Awakened dalam tim tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan level, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_141464_ActivityName = {
    Text = "Seribu Kipas Xuan Nü"
  },
  Activity_141464_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara\"Seribu Kipas Xuan Nü\"berlangsung, Keeper dapat menggunakan tim preset sistem yang menyertakan Xu untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage acara, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Acara>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman acara."
  },
  Activity_141466_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_141467_ActivityName = {
    Text = "Tahanan Cermin·klon"
  },
  Activity_141467_ActivityPlot = {
    Text = [[
Burung terbang, mengapa kaki mu terikat dengan belenggu yang putus?
Burung terbang, mengapa kamu bernyanyi sendirian di langit tinggi?
Bebaskan diri dari duri, larikan diri dari sangkar, kamu terbang melewati gurun yang luas, namun suara nyanyian sedihmu tak pernah berhenti. Siapa sebenarnya yang menjadi sahabat setia yang kamu cari? Di mana sebenarnya rumah yang kamu cari?]]
  },
  Activity_141467_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Keinginan Pengetahuan\""
  },
  Activity_141467_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1, Selama aktivitas berlangsung, Penjaga dapat mengumpulkan mata uang aktivitas \"Buku Kebijaksanaan Umum\",\"Buku Matematika\",\"Buku Sastra\" melalui gameplay terbatas waktu \"Terbang Melewati Langit Biru\",\"Perjalanan Impian\", dan \"Hadiah Pencapaian\".\"Buku Kebijaksanaan Umum\",\"Buku Matematika\",\"Buku Sastra\" dapat digunakan untuk membeli barang di \"Keinginan untuk mengetahui\", termasuk Roda takdir SR terbatas aktivitas \"Sehelai Bulu\", Inti Lumen, Inti murni, dan lainnya.\n2, Selama aktivitas berlangsung,\"Lanskap mimpi: Di luar cakrawala·Atas\" dapat dibuka secara gratis untuk waktu terbatas, dan dengan menyelesaikan pencapaian aktivitas kamu juga bisa mendapatkan avatar terbatas aktivitas \"Atas nama Kunci Perak: Castor\"!\n\n<Title:Waktu Aktivitas>\n1,5 Oktober 9:00 - 2 November 9:00(GMT+8), semua gameplay aktivitas dapat diikuti.\n2,2 November 9:00 - 9 November 9:00(GMT+8), hanya dapat mengikuti \"Keinginan untuk mengetahui\" dan Hadiah Pencapaian.\n\n<Title:Terbang Melewati Langit Biru>\n1,\"Terbang Melewati Langit Biru\" berisi 7 tingkat, setiap 1 hari akan terbuka 1 tingkat secara otomatis.\n2, Setiap tantangan akan menghabiskan \"Menophin\" × 120, dan jika berhasil akan mendapatkan mata uang aktivitas.\n3, Setelah menyelesaikan tahap, fitur \"Reproduksi\" pada tingkat tersebut akan terbuka. Harap diperhatikan: saat menggunakan fitur \"Reproduksi\", kamu tidak dapat memperoleh Affiniti.\n4, Kamu dapat menggunakan Bantuan Bertarung dari asosiasi alumni untuk membantu kamu menyelesaikan tahap dengan lebih mudah.\n\n<Title: Keinginan untuk mengetahui>\n\"Keinginan untuk mengetahui\" memiliki tiga toko, dengan waktu pembukaan sebagai berikut:\n·\"Mata Kuliah Pilihan Umum\": Dibuka pukul 9 tanggal 5 Oktober.\n·\"Mata Pelajaran Pilihan Sains\": Dibuka pukul 9 tanggal 6 Oktober.\n·\"Mata Kuliah Pilihan Sastra\": Dibuka pukul 9 tanggal 7 Oktober.\nDi dalam toko kamu dapat memilih barang dan langsung membelinya.\n\n<Title:Bonus Aktivitas>\n1, Penjaga yang memiliki Tubuh Terjaga atau Roda takdir tertentu(tidak perlu dipasang) dapat memperoleh bonus drop tambahan untuk \"Buku Kebijaksanaan Umum\",\"Buku Matematika\",\"Buku Sastra\" dalam hadiah misi tingkat \"Terbang Melewati Langit Biru\", detail bonus sebagai berikut:\n·Tubuh Terjaga \"Castor\": Mencerahkan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda takdir SSR \"Kebebasan yang Menyiksa\": Posisi Tumpuk 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda takdir SR \"Sehelai Bulu\": Posisi Tumpuk 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n2,\"Bonus Aktivitas\" dari berbagai Tubuh Terjaga atau Roda takdir dihitung secara kumulatif.\n3, Khususnya, hadiah tantangan pertama kali pada Kegilaan tidak akan terpengaruh oleh \"Bonus Aktivitas\".\n\n<Title: Perjalanan Impian>\n1, Setiap jam secara otomatis mendapatkan 60 \"Buku Kebijaksanaan Umum\", maksimal tersimpan selama 25 jam.\n\n<Title:Lanskap mimpi>\n1, Selama aktivitas berlangsung,\"Lanskap mimpi: Di luar cakrawala·Atas\" dapat dibuka secara gratis.\n2, Setelah aktivitas berakhir, progres investigasi \"Lanskap mimpi: Di luar cakrawala·Atas\" akan Retain, dan setelah menyelesaikan Investigasi kejadian yang belum selesai selama aktivitas juga dapat memperoleh hadiah investigasi yang sama seperti saat aktivitas berlangsung. Jika \"Lanskap mimpi: Di luar cakrawala·Atas\" belum dibuka selama aktivitas, setelah aktivitas berakhir masih dapat menghabiskan \"Titik awal realitas\" ×7 untuk membukanya.\n3, Baik selama aktivitas maupun tidak, setelah menyelesaikan tahap \"Lanskap mimpi: Di luar cakrawala·Atas\" kamu dapat memperoleh \"Posse: Nasib yang Tersesat\"."
  },
  Activity_141467_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_141509_ActivityName = {
    Text = "Catatan Perjalanan Negeri Rahasia"
  },
  Activity_141509_ActivityTips = {
    Text = [[
<Title:Aturan Aktivitas>
1, Setelah Penjaga menyelesaikan misi perjalanan yang ditentukan, dapat mengambil hadiah di "Catatan Perjalanan Negeri Rahasia".
2,"Catatan Perjalanan Negeri Rahasia" akan berakhir pada 27 Juli pukul 09:00.
3, Setelah membuka "Perjalanan Tingkat Lanjut", menyelesaikan misi dapat mengambil hadiah tambahan.
4, Harap diperhatikan:"Perjalanan Tingkat Lanjut" yang dibuka dalam aktivitas ini hanya berlaku dalam aktivitas ini. Harap Penjaga mempertimbangkan dengan bijak dalam berbelanja.]]
  },
  Activity_141509_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_141533_ActivityName = {
    Text = "Epoyans Abadi"
  },
  Activity_141533_ActivityPlot = {
    Text = [[
Mari kita tertawa keras, mari kita berpesta sepanjang malam.
Biarkan cakar kita menembus tenggorokan musuh, biarkan waktu yang biasa berkarat di kedalaman jurang.
Kita tidak akan pernah lagi tertangkap oleh usia tua, kebiasaan, dan kesepian.
Ini adalah Epoyanis, kita selalu bahagia, kita selalu bersama.
Kita tidak akan pernah berpisah.]]
  },
  Activity_141533_ActivityStageEndContent = {
    Text = "Aktivitas telah berakhir, saat ini hanya dapat mengikuti \"Ladang Berburu Tanpa Batas\""
  },
  Activity_141533_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1, Selama aktivitas berlangsung, Penjaga dapat mengumpulkan mata uang aktivitas \"Mangsa\" Segar \",\" Mangsa \" Besar\",\"Mangsa\" Kuno \" melalui gameplay terbatas\" Perburuan dari Ketinggian \" dan\" Hadiah Prestasi \", serta menukarkannya di\" Ladang Berburu Tanpa Batas \" untuk mendapatkan barang, termasuk Roda Takdir SR terbatas aktivitas\" Kompas Penunjuk Jalan Sesat \", Inti Lumen, Inti murni, dan lainnya.\n2, Selama aktivitas berlangsung,\" Yang berkelana: Epoyans Abadi \" dapat dibuka secara gratis untuk waktu terbatas, menyelesaikan pencapaian aktivitas juga dapat memperoleh avatar terbatas aktivitas\" Atas nama Kunci Perak: Pontos \"!\n\n<Title:Waktu Aktivitas>\n1,29 Juni 9:00 - 27 Juli 9:00(GMT+8), semua gameplay aktivitas dapat diikuti.\n2,27 Juli 9:00 - 3 Agustus 9:00(GMT+8), hanya dapat mengikuti\" Ladang Berburu Tanpa Batas \" dan Hadiah Prestasi.\n\n<Title:Perburuan dari Ketinggian>\n1,\" Perburuan dari Ketinggian \" berisi 7 tingkat, setiap hari akan otomatis membuka 1 tingkat.\n2, Setiap tantangan akan menghabiskan\" Menophin \" × 120, tantangan yang berhasil akan mendapatkan mata uang aktivitas.\n3, Setelah menyelesaikan tahap, fitur\" Reproduksi \" pada tingkat tersebut akan terbuka. Harap diperhatikan: saat menggunakan fitur\" Reproduksi \", Affiniti tidak dapat diperoleh.\n4, Kamu dapat menggunakan Bantuan Bertarung alumni untuk membantu menyelesaikan tahap dengan lebih mudah.\n\n<Title: Ladang Berburu Tanpa Batas>\n\" Ladang Berburu Tanpa Batas \" memiliki tiga toko, waktu pembukaan sebagai berikut:\n·\" Anak Panah Busur Besi \": Dibuka pukul 9 tanggal 29 Juni.\n·\" Senjata Api \": Dibuka pukul 9 tanggal 30 Juni.\n·\" Sihir \": Dibuka pukul 9 tanggal 1 Juli.\nDi dalam toko dapat memilih barang untuk dibeli langsung.\n\n<Title:Bonus Aktivitas>\n1, Penjaga yang memiliki Tubuh Terjaga atau Roda Takdir tertentu(tidak perlu dipasang dalam tim) dapat memperoleh bonus drop tambahan untuk tiga jenis mata uang aktivitas dalam hadiah misi tingkat\" Perburuan dari Ketinggian \":\n·Tubuh Terjaga\" Pontos \": Mencerahkan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda Takdir SSR\" Sangkar Tahanan Hidup \": Posisi Tumpuk 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda Takdir SR\" Kompas Penunjuk Jalan Sesat \": Posisi Tumpuk 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n2,\" Bonus Aktivitas \" dari Tubuh Terjaga atau Roda Takdir yang berbeda dihitung secara kumulatif.\n3, Khusus, hadiah tantangan penyelesaian pertama Kegilaan tidak akan terpengaruh oleh\" Bonus Aktivitas \".\n\n<Title:Yang berkelana>\n1, Selama aktivitas berlangsung,\" Yang berkelana: Epoyans Abadi \" dapat dibuka secara gratis.\n2, Setelah aktivitas berakhir, progres investigasi akan disimpan, kejadian investigasi yang belum selesai selama aktivitas dapat diselesaikan setelah aktivitas dan tetap mendapatkan hadiah yang sesuai. Jika belum dibuka selama periode aktivitas, setelah aktivitas berakhir masih dapat menghabiskan\" Titik awal realitas \" × 3 untuk membukanya.\n3, Terlepas dari apakah dalam periode aktivitas atau tidak, setelah menyelesaikan tahap\" Yang berkelana: Epoyans Abadi \" dapat memperoleh\" Posse: Orang Kosong \"."
  },
  Activity_141533_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_141534_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_141535_ActivityName = {
    Text = "Musim panas abadi di bawah sinar matahari hitam·klon"
  },
  Activity_141535_ActivityPlot = {
    Text = [[
Musim panas, pantai, sinar matahari, dan banyak wajah yang akrab.
Di bawah sinar Matahari Hitam, lupakan segalanya, tenggelam dalam mimpi indah yang memenuhi semua fantasi ini.]]
  },
  Activity_141535_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1, Selama aktivitas berlangsung,\"Lanskap mimpi: Selamat tinggal, Neverland\" dapat dibuka secara gratis untuk waktu terbatas!\n2, Selama aktivitas berlangsung, login kumulatif 7 hari dapat memperoleh \"Inti Lumen\" ×10 di \"Perayaan Tshessa\", dan pada hari ke-7 dapat memperoleh avatar pertarungan terbatas tambahan \"Bola Voli 'Jenderal Besar'\".\n\n<Title:Waktu Aktivitas>\n1,6 Juli 9:00 - 20 Juli 9:00(GMT+8), semua aktivitas dapat diikuti.\n\n<Title:Lanskap mimpi>\n1, Selama aktivitas berlangsung,\"Lanskap mimpi: Selamat tinggal, Neverland\" dapat dibuka secara gratis.\n2, Setelah aktivitas berakhir, progres investigasi \"Lanskap mimpi: Selamat tinggal, Neverland\" akan disimpan, menyelesaikan kejadian investigasi yang belum selesai selama aktivitas juga dapat memperoleh hadiah investigasi yang sama seperti saat aktivitas berlangsung. Jika \"Lanskap mimpi: Selamat tinggal, Neverland\" belum dibuka selama periode aktivitas, setelah aktivitas berakhir masih dapat menghabiskan \"Titik awal realitas\" ×7 untuk membukanya.\n3, Terlepas dari apakah dalam periode aktivitas atau tidak, setelah menyelesaikan tahap \"Lanskap mimpi: Selamat tinggal, Neverland\" dapat memperoleh \"Posse: Kenangan Musim Panas yang Terabadikan\"."
  },
  Activity_141535_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_141536_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_142866_ActivityName = {
    Text = "Ibu Dewa Keturunan Laut"
  },
  Activity_142866_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara\"Ibu Dewa Keturunan Laut\"berlangsung, Keeper dapat menggunakan tim preset sistem yang menyertakan Delusion·Murphy untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage acara, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Acara>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman acara."
  },
  Activity_142867_ActivityName = {
    Text = "Penyihir Pemburu Tengkorak"
  },
  Activity_142867_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Penyihir Pemburu Tengkorak\" berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Daphodel untuk mencoba level yang ditentukan tanpa batas.\n·Saat mencoba level aktivitas, formasi Awakened dalam tim tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan level, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_143933_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_144359_ActivityName = {
    Text = "Mengintip Segala Fenomena"
  },
  Activity_144359_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n1、Setelah Penjaga menyelesaikan misi perjalanan yang ditentukan, hadiah dapat diambil di \"Mengintip Segala Fenomena\".\n2、\"Mengintip Segala Fenomena\" akan berakhir pada 24 Agustus 9:00.\n3、Setelah membuka \"Perjalanan Tingkat Lanjut\", hadiah tambahan dapat diambil setelah menyelesaikan misi.\n4、Harap diperhatikan: \"Perjalanan Tingkat Lanjut\" yang dibuka dalam aktivitas ini hanya berlaku untuk aktivitas ini. Harap Penjaga mempertimbangkan dengan bijak sebelum berbelanja."
  },
  Activity_144359_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_145382_ActivityName = {Text = "Paus Jatuh"},
  Activity_145382_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Paus Jatuh\" berlangsung, Penjaga dapat menggunakan tim preset sistem yang menyertakan Lotan: Cetarchon untuk mengalami tingkat yang ditentukan tanpa batas.\n·Saat mengalami tingkat aktivitas, Awakener dalam susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Aktivitas>\n·Setelah berhasil menyelesaikan tantangan tingkat untuk pertama kalinya, hadiah percobaan dapat diklaim di antarmuka aktivitas."
  },
  Activity_145383_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_145383_ActivityPlot = {
    Text = "Setelah dibeli, \"Lotan: Cetarchon\" dapat mengaktifkan <BlueQuality:Mencerahkan 3>"
  },
  Activity_145384_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_145384_ActivityPlot = {
    Text = [[
Setelah dibeli, "Lotan: Cetarchon" dapat mengaktifkan
<BlueQuality:Pengembangan Kepribadian +4, membuka Ledakan Melampaui Batas>]]
  },
  Activity_145458_ActivityName = {
    Text = "Permainan Leviathan"
  },
  Activity_145458_ActivityPlot = {
    Text = "Pahlawan yang serakah menginginkan takhta keabadian, ibu yang putus asa menginginkan anaknya hidup kembali, penyihir gila menginginkan pengetahuan terlarang — mereka berlutut di hadapan-Nya, memohon dengan kata-kata yang telah Dia dengar selama ribuan tahun.\nDia menganugerahkan segalanya kepada mereka, lalu menyaksikan mereka kehilangan segalanya. Dia telah menyaksikan empat ribu pertarungan yang mengerikan, namun tidak pernah merasa puas.\nKali ini, pintu Koloseum terbuka lebar untukmu. Marilah, ceritakan kepada-Nya, apa yang kamu rindukan.\nCeritakan kepada-Nya, apa bedanya dirimu dengan keempat ribu jiwa yang telah binasa itu."
  },
  Activity_145458_ActivityStageEndContent = {
    Text = "Aktivitas telah berakhir, saat ini hanya dapat berpartisipasi di \"Teks Sementara\""
  },
  Activity_145458_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\nSelama aktivitas berlangsung, Penjaga dapat mengumpulkan mata uang aktivitas \"Persembahan Berdarah\" melalui gameplay terbatas \"Pertarungan Nafsu Darah\" dan \"Hadiah Prestasi\". \"Persembahan Berdarah\" dapat ditukarkan dengan hadiah di \"Altar Pengorbanan Arena\", termasuk Roda takdir SR terbatas aktivitas \"Kerangka Hasrat Abadi\", Inti Lumen, Inti murni, Fragmentasi Batu Bijaksana, Kristal Mimik, dan lainnya.\n\n<Title:Pertarungan Nafsu Darah>\n1、\"Pertarungan Nafsu Darah\" berisi 5 tingkat, setiap 2 hari akan terbuka otomatis 1 tingkat.\n2、Setiap tantangan akan menghabiskan \"Menophin\" × 120, keberhasilan tantangan akan mendapatkan mata uang aktivitas \"Persembahan Berdarah\".\n3、Setelah menyelesaikan tingkat, fungsi \"Reproduksi\" pada tingkat tersebut akan terbuka. Harap diperhatikan: saat menggunakan fungsi \"Reproduksi\", Affiniti tidak dapat diperoleh.\n4、Kamu dapat menggunakan Bantuan Tempur Asosiasi Alumni untuk membantu melewati tingkat dengan lebih mudah.\n\n<Title:Bonus Aktivitas>\n1、Penjaga yang memiliki Tubuh Terjaga atau Roda takdir tertentu (tidak perlu diturunkan ke lapangan) dapat memperoleh bonus drop tambahan untuk \"Persembahan Berdarah\" dalam hadiah misi tingkat \"Pertarungan Nafsu Darah\" (termasuk Reproduksi), detail bonus sebagai berikut:\n·Tubuh Terjaga \"Lotan: Cetarchon\": Mencerahkan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda takdir SSR \"Kematian Cetus\": Posisi Tumpuk 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda takdir SR \"Kerangka Hasrat Abadi\": Posisi Tumpuk 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2、\"Bonus Aktivitas\" dari Tubuh Terjaga atau Roda takdir yang berbeda dihitung secara kumulatif.\n3、Khusus, hadiah tantangan pertama kali di tingkat Kegilaan tidak akan terpengaruh oleh bonus di atas.\n\n<Title:Yang berkelana>\n1、Selama aktivitas berlangsung, \"Yang berkelana: Hingga Cetus Runtuh\" dapat dibuka secara gratis.\n2、Setelah aktivitas berakhir, progres investigasi \"Yang berkelana: Hingga Cetus Runtuh\" akan tetap tersimpan. Menyelesaikan investigasi kejadian yang belum selesai selama aktivitas juga dapat memperoleh hadiah investigasi yang sama seperti saat aktivitas berlangsung. Jika \"Yang berkelana: Hingga Cetus Runtuh\" tidak dibuka selama aktivitas, setelah aktivitas berakhir masih dapat dibuka dengan menghabiskan \"Titik awal realitas\" ×3.\n3、Baik selama aktivitas maupun tidak, setelah menyelesaikan tahap \"Yang berkelana: Hingga Cetus Runtuh\" dapat memperoleh \"Posse: Badai Pelahap Cetus\".\n\n<Title:Waktu Aktivitas>\n1、27 Juli 9:00 - 24 Agustus 9:00 (GMT+8), semua konten dalam pengenalan aktivitas dapat diikuti.\n2、24 Agustus 9:00 - 31 Agustus 9:00 (GMT+8), hanya \"Altar Pengorbanan Arena\" dan \"Hadiah Prestasi\" yang tersisa, konten lainnya telah berakhir dan tidak dapat diikuti.\n3、Setelah 31 Agustus 9:00 (GMT+8), \"Persembahan Berdarah\" yang tersisa dan belum ditukarkan akan dikumpulkan kembali dengan rasio penukaran \"Rose Scrip\" × 40 per item. Harap Penjaga memperhatikan kotak masuk email."
  },
  Activity_145458_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_145459_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_145465_ActivityName = {
    Text = "Jika segalanya berjalan seperti biasa·klon"
  },
  Activity_145465_ActivityPlot = {
    Text = [[
Kamu pernah membayangkan, jika bencana tidak pernah datang, seperti apa kehidupan semua orang.
Kekuatanmu untuk menyelamatkan dunia tidak lagi berguna, setiap hari harus sibuk dengan kehidupan kampus biasa dan mengumpulkan nilai yang menyedihkan. Di lapangan tidak ada lagi bayangan latihan perang, menggantikannya adalah tenda-tenda kegiatan klub dan suara riuh orang yang mengundang dan bercanda; ketika bel pulang berbunyi, murid-murid yang lapar segera memenuhi kantin...
Apa yang akan kamu lihat ketika membuka pintu orang-orang yang kamu pedulikan?]]
  },
  Activity_145465_ActivityStageEndContent = {
    Text = "[Jika semuanya berjalan normal] kegiatan telah berakhir, saat ini hanya bisa berpartisipasi dalam\"Gedung Kantor OSIS\""
  },
  Activity_145465_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1、Selama aktivitas berlangsung, Penjaga dapat mengumpulkan mata uang aktivitas \"Cangkang oleh-oleh pantai\" melalui gameplay terbatas \"Hal baru di bawah sinar matahari\". \"Cangkang oleh-oleh pantai\" dapat digunakan untuk membeli barang di \"Gedung Kantor Badan Eksekutif Mahasiswa\", termasuk Inti Lumen, Inti murni, Fragmentasi Batu Bijaksana, dan lainnya.\n2、Selama aktivitas berlangsung, \"Lanskap mimpi: Selamat tinggal, Neverland\" dapat dibuka secara gratis untuk waktu terbatas!\n\n<Title:Waktu Aktivitas>\n1、3 Agustus 9:00 - 17 Agustus 9:00 (GMT+8), semua gameplay aktivitas dapat diikuti.\n2、17 Agustus 9:00 - 24 Agustus 9:00 (GMT+8), hanya \"Gedung Kantor Badan Eksekutif Mahasiswa\" dan Hadiah Prestasi yang dapat diikuti.\n\n<Title:Hal baru di bawah sinar matahari>\n1、\"Hal baru di bawah sinar matahari\" berisi 5 tingkat, setiap 2 hari akan terbuka otomatis 1 tingkat.\n2、Setiap tantangan akan menghabiskan \"Menophin\" × 120, keberhasilan tantangan akan mendapatkan mata uang aktivitas.\n3、Setelah menyelesaikan tingkat, fungsi \"Reproduksi\" pada tingkat tersebut akan terbuka. Harap diperhatikan: saat menggunakan fungsi \"Reproduksi\", Affiniti tidak dapat diperoleh.\n4、Kamu dapat menggunakan Bantuan Tempur Asosiasi Alumni untuk membantu melewati tingkat dengan lebih mudah.\n\n<Title: Gedung Kantor Badan Eksekutif Mahasiswa>\n\"Gedung Kantor Badan Eksekutif Mahasiswa\" memiliki satu toko, dibuka pada 3 Agustus pukul 9:00.\nDi dalam toko, kamu dapat memilih barang dan langsung membelinya.\n\n<Title:Lanskap mimpi>\n1、Selama aktivitas berlangsung, \"Lanskap mimpi: Selamat tinggal, Neverland\" dapat dibuka secara gratis.\n2、Setelah aktivitas berakhir, progres investigasi \"Lanskap mimpi: Selamat tinggal, Neverland\" akan tetap tersimpan. Menyelesaikan investigasi kejadian yang belum selesai selama aktivitas juga dapat memperoleh hadiah investigasi yang sama seperti saat aktivitas berlangsung. Jika \"Lanskap mimpi: Selamat tinggal, Neverland\" tidak dibuka selama aktivitas, setelah aktivitas berakhir masih dapat dibuka dengan menghabiskan \"Titik awal realitas\" ×7.\n3、Baik selama aktivitas maupun tidak, setelah menyelesaikan tahap \"Lanskap mimpi: Selamat tinggal, Neverland\" dapat memperoleh \"Posse: Mimpi Indah Sejenak\"."
  },
  Activity_145465_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_145466_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_145717_ActivityName = {
    Text = "Bulan Sabit dan Salju Dalam"
  },
  Activity_145717_ActivityPlot = {
    Text = "Tujuh kali sembahyang, tiga kali sumpah, selama kau mendaki batas antara langit dan salju dengan iman yang tulus kepada peri putih suci itu, ia akan mengabulkan semua, semua keinginanmu.\nSetiap orang memiliki tujuan yang berbeda, di balik setiap tujuan terdapat kebohongan yang berbeda pula.\nGalilah mereka, tampakkanlah mereka — sebelum tunduk pada penampilan yang sempurna tanpa cacat.\nJangan tenggelam bersamanya ke dalam hamparan salju yang dalam ini."
  },
  Activity_145717_ActivityStageEndContent = {
    Text = "Aktivitas Telah berakhir, saat ini hanya dapat mengikuti \"Ritual Peri\""
  },
  Activity_145717_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1、Selama aktivitas berlangsung, Penjaga dapat mengumpulkan mata uang aktivitas \"Apel Merah\" \"Apel Emas\" \"Apel Gula\" melalui gameplay terbatas waktu \"Harta Umapati\" dan \"Hadiah Pencapaian\", serta menukarkan barang di \"Ritual Peri\", termasuk Roda takdir SR terbatas aktivitas \"Kebenaran Yang Senyap\", Inti Lumen, Inti murni, dan lainnya.\n2、Menyelesaikan pencapaian aktivitas selama periode aktivitas juga akan mendapatkan avatar terbatas aktivitas \"Atas nama Kunci Perak: Caraboo\"!\n\n<Title:Waktu Aktivitas>\n1、8 Agustus 24 9:00 - 21 September 9:00 (GMT+8), semua Aktivitas Gameplay dapat diikuti.\n2、21 September 9:00 - 28 September 9:00 (GMT+8), hanya dapat mengikuti \"Ritual Peri\" dan Hadiah Pencapaian.\n\n<Title:Harta Umapati>\n1、\"Harta Umapati\" berisi 7 Tingkat, setiap hari akan membuka 1 Tingkat secara otomatis.\n2、Setiap tantangan akan menghabiskan \"Menophin\" × 120, keberhasilan tantangan akan mendapatkan mata uang aktivitas.\n3、Setelah Menyelesaikan tahap, fitur \"Reproduksi\" pada tingkat tersebut akan terbuka. Harap diperhatikan: saat menggunakan fitur \"Reproduksi\", Affiniti tidak dapat diperoleh.\n4、Kamu dapat menggunakan Bantuan Tempur Asosiasi Alumni untuk membantu melewati tahap dengan lebih mudah.\n\n<Title: Ritual Peri>\n1、\"Ritual Peri\" memiliki tiga toko, waktu pembukaan sebagai berikut:\n·\"Berkah Salju Tipis\": Dibuka pukul 9 tanggal 24 Agustus.\n·\"Berkah Embun Beku\": Dibuka pukul 9 tanggal 25 Agustus.\n·\"Berkah Putih Murni\": Dibuka pukul 9 tanggal 26 Agustus.\n2、Setiap \"Menerima Berkah\" akan menghabiskan \"Apel Merah\"/\"Apel Emas\"/\"Apel Gula\" × 750, dan secara acak mendapatkan lima hadiah item dari \"Ritual Peri\".\n3、Hadiah item setiap \"Ritual Peri\" dibagi menjadi dua jenis yaitu \"Item Spesial\" dan \"Item Umum\". Saat reset, sisa jumlah Item Spesial dapat direset ke batas maksimum, aturan spesifiknya adalah:\n（1）2 reset pertama: Ketika \"Item Spesial\" tidak memiliki sisa jumlah, Penjaga dapat memilih untuk mereset, setelah reset sisa jumlah \"Item Spesial\" dan \"Item Umum\" akan direset ke batas maksimum; juga dapat memilih untuk melanjutkan penukaran, ketika \"Item Umum\" juga tidak memiliki sisa jumlah, harus melakukan reset untuk dapat melanjutkan penukaran.\n（2）Mulai reset ke-3: Reset hanya dapat dilakukan setelah \"Item Umum\" tidak memiliki sisa jumlah, reset akan mereset sisa jumlah \"Item Umum\" ke batas maksimum, \"Item Spesial\" tidak akan direset lagi.\n\n<Title:Bonus Aktivitas>\n1、Penjaga yang memiliki Awakener atau Roda takdir tertentu (tidak perlu diturunkan ke lapangan) dapat memperoleh bonus tambahan pada perolehan tiga jenis mata uang aktivitas dalam hadiah misi Tingkat \"Harta Umapati\":\n·Awakener \"Caraboo\": Mencerahkan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda takdir SSR \"Muslihat Manis\": Posisi Tumpuk 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda takdir SR \"Kebenaran Yang Senyap\": Posisi Tumpuk 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n2、Beberapa \"Bonus Aktivitas\" dapat ditumpuk dan dihitung bersama.\n3、Perhatikan, hadiah tantangan pertama kali pada Kegilaan tidak akan terpengaruh oleh \"Bonus Aktivitas\"."
  },
  Activity_145717_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_146540_ActivityName = {
    Text = "Persembahan Kenangan Perjalanan·Bab Bintang VI"
  },
  Activity_146540_ActivityPlot = {
    Text = "Sebuah memori tersegel dan diarsipkan, sebuah perjalanan tercatat dalam masa lalu. Saat mengenang, jangan lupa persembahkan penghormatan yang tulus."
  },
  Activity_146541_ActivityName = {
    Text = "Perjalanan Utara Terjauh"
  },
  Activity_146541_ActivityTips = {
    Text = "Aturan Aktivitas:\n1、Setelah Penjaga menyelesaikan misi perjalanan yang ditentukan, dapat mengambil hadiah di \"Perjalanan Utara Terjauh\".\n2、\"Perjalanan Utara Terjauh\" dibuka secara permanen.\n3、Setelah membuka \"Perjalanan Tingkat Lanjut\", menyelesaikan misi dapat mengambil hadiah tambahan.\n4、Harap diperhatikan: \"Perjalanan Tingkat Lanjut\" yang dibuka dalam aktivitas ini hanya berlaku dalam aktivitas ini. Mohon Penjaga bijak dalam berbelanja."
  },
  Activity_146799_ActivityName = {
    Text = "Teks sementara"
  },
  Activity_146799_ActivityPlot = {
    Text = "Teks sementara"
  },
  Activity_146799_ActivityStageEndContent = {
    Text = "Teks sementara"
  },
  Activity_146799_ActivityTips = {
    Text = "Teks sementara"
  },
  Activity_146799_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_147423_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_147423_ActivityPlot = {
    Text = "Setelah dibeli, \"Bintang Senja·Tinkter\" dapat mengaktifkan <BlueQuality:Mencerahkan 3>"
  },
  Activity_147424_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_147424_ActivityPlot = {
    Text = "Setelah dibeli, \"Bintang Senja·Tinkter\" dapat mengaktifkan\n<BlueQuality:Pendalaman Kepribadian +4, membuka Over-Exaltation>"
  },
  Activity_147425_ActivityName = {
    Text = "Teks sementara"
  },
  Activity_147425_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Teks Sementara\" berlangsung, Penjaga dapat menggunakan tim preset sistem yang berisi Bintang Senja·Tinkter untuk mengalami Tingkat yang ditentukan tanpa batas.\n·Saat mengalami Tingkat aktivitas, Awakener dalam Susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali mencapai tantangan Tingkat, dapat mengambil hadiah percobaan di antarmuka aktivitas."
  },
  Activity_147426_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_148119_ActivityName = {
    Text = "Waktu luang"
  },
  Activity_148119_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n1、Setelah Penjaga menyelesaikan misi perjalanan yang ditentukan, dapat mengambil hadiah di \"Waktu Luang\".\n2、\"Waktu Luang\" akan berakhir pada 21 September pukul 9:00.\n3、Setelah membuka \"Perjalanan Tingkat Lanjut\", menyelesaikan misi dapat mengambil hadiah tambahan.\n4、Harap diperhatikan: \"Perjalanan Tingkat Lanjut\" yang dibuka dalam aktivitas ini hanya berlaku dalam aktivitas ini. Mohon Penjaga bijak dalam berbelanja."
  },
  Activity_148119_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_148889_ActivityName = {
    Text = "Genesis Ogier"
  },
  Activity_148889_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Asal Mula Augir\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Asal Mula Augir untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_15788_ActivityName = {
    Text = "Estetika Alkimia"
  },
  Activity_15788_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Estetika Alkimia"berlangsung, setelah Keeper menyelesaikan"Pencarian Kupon Emas", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali setiap hari.
2. Jumlah kesempatan hadiah ganda yang belum digunakan pada hari itu akan direset pada pukul 9 keesokan harinya (GMT+8). Keeper, jangan lupa untuk menggunakannya tepat waktu ya~]]
  },
  Activity_15791_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_15791_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event "Ledakan Gnosis", setelah Keeper menyelesaikan "Pemurnian Ramuan", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali per hari.
2. Jumlah hadiah ganda yang tidak digunakan pada hari itu akan direset pada pukul 9 pagi (GMT+8) keesokan harinya. Keeper, jangan lupa untuk menggunakannya tepat waktu~]]
  },
  Activity_15793_ActivityName = {
    Text = "Bayang-bayang Kota Hujan"
  },
  Activity_15793_ActivityPlot = {
    Text = [[
Setiap malam yang diguyur hujan, selalu ditemani kekecewaan dan kesunyian.
Ada yang kehilangan cinta, ada yang kehilangan harga diri.
Dan ada pula yang kehilangan kepalanya sendiri.]]
  },
  Activity_15793_ActivityTips = {
    Text = "<Title:Syarat Partisipasi>\n·Dapat berpartisipasi setelah menyelesaikan \"Operasi Investigasi\" 2-9·Normal.\n<Title:Peristiwa Investigasi>\n·Selama periode event, setiap hari akan dirilis satu peristiwa investigasi baru di \"Bayangan Kota Hujan\". Keeper dapat membuka dan melakukan investigasi tanpa menggunakan sumber daya. Setelah menyelesaikan peristiwa investigasi, kamu bisa mendapatkan hadiah investigasi seperti Inti Murni, Lencana Investigasi, dan EXP Keeper.\n·Setelah event berakhir, progres investigasi \"Bayangan Kota Hujan\" akan disimpan. Keeper dapat menggunakan Mutiara Korosi di Catatan Ekspedisi untuk membuka investigasi yang belum terbuka. Menyelesaikan peristiwa investigasi yang belum selesai selama periode event juga akan memberikan hadiah investigasi yang sama seperti saat event berlangsung.<Title:Hadiah Terbatas>\n·Selama periode event, hadiah terbatas akan tersedia. Setelah Keeper menyelesaikan mode Normal \"Bayangan Kota Hujan\" dan menyelesaikan peristiwa investigasi \"Bayangan Kota Hujan\", kamu bisa mendapatkan hadiah Inti Murni, Batu Bijak, dan Inti Perak! Hadiah terbatas hanya tersedia selama periode event. Setelah event berakhir, hadiah tidak dapat diselesaikan atau diklaim."
  },
  Activity_15793_UnlockConditionExplanation = {
    Text = "Setelah menyelesaikan \"Operasi\"2-9·Normal, akan terbuka."
  },
  Activity_15797_ActivityName = {
    Text = "Tuan yang Tertidur"
  },
  Activity_15797_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Tuan yang Tertidur\" berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Thulu untuk mencoba level yang ditentukan tanpa batas.\n·Saat mencoba level aktivitas, formasi Awakened dalam tim tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan level, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_15805_ActivityName = {
    Text = "Perjalanan ke Kota Kabut"
  },
  Activity_15805_ActivityTips = {
    Text = [[
Aturan Event:
1. Setelah Penjaga Rahasia menyelesaikan misi Chronicle yang ditentukan, hadiah dapat diklaim di "Chronicle Kota Kabut".
2. "Chronicle Kota Kabut" dibuka secara permanen.
3. Setelah membuka "Chronicle Lanjutan", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
4. Perhatian: "Chronicle Lanjutan" yang dibuka dalam event ini hanya berlaku di event ini. Penjaga Rahasia diharapkan membelanjakan secara bijak.]]
  },
  Activity_15809_ActivityName = {
    Text = "Tunas Bintang (Kedaluwarsa)"
  },
  Activity_15809_ActivityTips = {
    Text = [[
Aturan Event:
Setelah Keeper menyelesaikan misi yang ditentukan, hadiah dapat diklaim di"Tunas Bintang".]]
  },
  Activity_15818_ActivityName = {
    Text = "Sang Pemahat (Kedaluwarsa)"
  },
  Activity_15818_ActivityTips = {
    Text = [[
Aturan Event:
Setelah Keeper menyelesaikan misi yang ditentukan, hadiah dapat diklaim di"Sang Pemahat".]]
  },
  Activity_15821_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_15821_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_15825_ActivityName = {
    Text = "Puisi Tanpa Nama (Kedaluwarsa)"
  },
  Activity_15825_ActivityTips = {
    Text = [[
Aturan Event:
Setelah Keeper menyelesaikan misi yang ditentukan, hadiah dapat diklaim di"Puisi Tanpa Nama".]]
  },
  Activity_15828_ActivityName = {
    Text = "Upacara Penerimaan"
  },
  Activity_15828_ActivityTips = {
    Text = [[
Aturan Event:
1. Ketika level investigasi Penjaga Rahasia mencapai 5/15/25/35/45/55, hadiah dapat diklaim di "Upacara Penerimaan".
2. Pengalaman Penjaga Rahasia dapat diperoleh melalui stage investigasi dan latihan intermisi.]]
  },
  Activity_20344_ActivityName = {
    Text = "Perjumpaan Tanpa Cahaya"
  },
  Activity_20344_ActivityTips = {
    Text = [[
Aturan Aktivitas:
1. Setelah Penjaga Rahasia menyelesaikan misi Chronicle yang ditentukan, hadiah dapat diklaim di "Perjumpaan Tanpa Cahaya".
2. "Perjumpaan Tanpa Cahaya" dibuka secara permanen.]]
  },
  Activity_20683_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_20683_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event "Deduksi Sublimasi", setelah Keeper menyelesaikan "Bayangan Dimensi", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali per hari.
2. Jumlah hadiah ganda yang tidak digunakan pada hari itu akan direset pada pukul 9 pagi (GMT+8) keesokan harinya. Keeper, jangan lupa untuk menggunakannya tepat waktu~]]
  },
  Activity_20684_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_20684_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif"berlangsung, setelah Keeper menyelesaikan"Schwarzschild Throat", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali setiap hari.
2. Jumlah kesempatan hadiah ganda yang belum digunakan pada hari itu akan direset pada pukul 9 keesokan harinya (GMT+8). Keeper, jangan lupa untuk menggunakannya tepat waktu ya~]]
  },
  Activity_20685_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_20685_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event "Deduksi Sublimasi", setelah Keeper menyelesaikan "Bayangan Organik", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali per hari.
2. Jumlah hadiah ganda yang tidak digunakan pada hari itu akan direset pada pukul 9 pagi (GMT+8) keesokan harinya. Keeper, jangan lupa untuk menggunakannya tepat waktu~]]
  },
  Activity_20686_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_20686_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif"berlangsung, setelah Keeper menyelesaikan"Reruntuhan Pohnpei", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali setiap hari.
2. Jumlah kesempatan hadiah ganda yang belum digunakan pada hari itu akan direset pada pukul 9 keesokan harinya (GMT+8). Keeper, jangan lupa untuk menggunakannya tepat waktu ya~]]
  },
  Activity_20687_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_20687_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif"berlangsung, setelah Keeper menyelesaikan"Chaos Cluster", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali setiap hari.
2. Jumlah kesempatan hadiah ganda yang belum digunakan pada hari itu akan direset pada pukul 9 keesokan harinya (GMT+8). Keeper, jangan lupa untuk menggunakannya tepat waktu ya~]]
  },
  Activity_20688_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_20688_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif"berlangsung, setelah Keeper menyelesaikan"Sarang Cacing", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali setiap hari.
2. Jumlah kesempatan hadiah ganda yang belum digunakan pada hari itu akan direset pada pukul 9 keesokan harinya (GMT+8). Keeper, jangan lupa untuk menggunakannya tepat waktu ya~]]
  },
  Activity_20689_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_20689_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event "Deduksi Sublimasi", setelah Keeper menyelesaikan "Bayangan Kedalaman Laut", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali per hari.
2. Jumlah hadiah ganda yang tidak digunakan pada hari itu akan direset pada pukul 9 pagi (GMT+8) keesokan harinya. Keeper, jangan lupa untuk menggunakannya tepat waktu~]]
  },
  Activity_20690_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_20690_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event "Deduksi Sublimasi", setelah Keeper menyelesaikan "Bayangan Keruh", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali per hari.
2. Jumlah hadiah ganda yang tidak digunakan pada hari itu akan direset pada pukul 9 pagi (GMT+8) keesokan harinya. Keeper, jangan lupa untuk menggunakannya tepat waktu~]]
  },
  Activity_20691_ActivityName = {
    Text = "Penyihir Pemburu Tengkorak"
  },
  Activity_20691_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Penyihir Pemburu Tengkorak\" berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Daphodel untuk mencoba level yang ditentukan tanpa batas.\n·Saat mencoba level aktivitas, formasi Awakened dalam tim tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan level, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_21502_ActivityName = {
    Text = "Rasul Lautan"
  },
  Activity_21502_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Rasul Lautan\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Miriam untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_21781_ActivityName = {
    Text = "Pilihan Studi"
  },
  Activity_21781_ActivityPlot = {
    Text = "Selesaikan misi untuk memilih entitas Kebangkitan tertentu dari \"Studi Realm\" atau Roda Takdir tertentu dari \"Fase Rotasi\"!"
  },
  Activity_21781_ActivityTips = {
    Text = [[
Aturan Event:
1. Akumulasi 50 kali Kebangkitan, akumulasi login 3 hari, akumulasi login 7 hari, dapat memperoleh hadiah "Taman Esensi". "Taman Esensi" dapat digunakan di "Sumber Daya: Barang Konsumsi", setelah digunakan dapat memilih 1 entitas Kebangkitan tertentu dari "Studi Realm" untuk dibangkitkan.
2. Akumulasi 300 kali Kebangkitan, akumulasi 1000 kali Kebangkitan, akumulasi login 30 hari, dapat memperoleh hadiah "Buku Rotasi". "Buku Rotasi" dapat digunakan di "Sumber Daya: Barang Konsumsi", setelah digunakan dapat memilih 1 Roda Takdir tertentu dari "Fase Rotasi" untuk diperoleh.]]
  },
  Activity_22367_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_22367_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Ledakan Gnosis", Keeper yang menyelidiki atau memutar ulang"Pemurnian Ramuan"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23671_ActivityName = {
    Text = "Penyelaman & Catur"
  },
  Activity_23671_ActivityPlot = {
    Text = "Selama event berlangsung, EXP Keeper yang diperoleh melalui\"Penyelaman Mimpi\"dan\"Catur Fase\"akan digandakan, dengan batas harian ditingkatkan menjadi 480 poin."
  },
  Activity_23671_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Penyelaman & Catur"berlangsung, EXP Keeper yang diperoleh melalui"Penyelaman Mimpi"dan"Catur Fase"akan digandakan, dengan batas harian ditingkatkan menjadi 480 poin. Jika Riset Inti juga telah dibuka, EXP Keeper yang diperoleh melalui jalur tersebut akan digandakan lagi, dengan batas harian tetap 480 poin.
2. EXP Keeper ganda yang belum digunakan pada hari itu akan direset pada pukul 9 keesokan harinya (GMT+8). Keeper, jangan lupa untuk menghabiskannya tepat waktu ya~]]
  },
  Activity_23693_ActivityName = {
    Text = "Keturunan Yang Putih"
  },
  Activity_23693_ActivityPlot = {
    Text = "Konon di bawah tanah Londinium, terdapat sebuah pintu yang satu-satunya.\nPintu itu menuju ke tempat Sang Tuan Pucat…"
  },
  Activity_23693_ActivityTips = {
    Text = "<Title:Syarat Partisipasi>\n·Dapat diikuti setelah menyelesaikan mode Normal Penyelaman Kesadaran \"Keinginan Ksatria\". \n<Title:Peristiwa Investigasi>\n·Selama periode event, setiap hari akan dirilis satu peristiwa investigasi baru di \"Keturunan Pucat\". Keeper tidak perlu menggunakan sumber daya untuk membuka investigasi. Setelah menyelesaikan peristiwa investigasi, kamu bisa mendapatkan hadiah investigasi seperti Inti Murni, Lencana Investigasi, dan EXP Keeper.\n·Setelah event berakhir, progres investigasi \"Keturunan Pucat\" akan disimpan. Keeper dapat menggunakan Mutiara Erosi di Penyelaman Kesadaran untuk membuka investigasi yang belum terbuka. Menyelesaikan peristiwa investigasi yang belum selesai selama event juga akan memberikan hadiah investigasi yang sama seperti saat event berlangsung.<Title:Hadiah Terbatas>\n·Selama periode event, hadiah terbatas akan tersedia. Setelah Keeper menyelesaikan mode Normal \"Keturunan Pucat\" dan menyelesaikan peristiwa investigasi \"Keturunan Pucat\", kamu bisa mendapatkan hadiah Gesper Hitam Pekat dan Silver Core! Hadiah terbatas hanya tersedia selama periode event. Setelah event berakhir, hadiah tidak dapat diselesaikan atau diklaim."
  },
  Activity_23693_UnlockConditionExplanation = {
    Text = "Terbuka setelah menyelesaikan Penyelaman Kesadaran \"Keinginan Ksatria\""
  },
  Activity_23723_ActivityName = {
    Text = "Badai Akan Datang"
  },
  Activity_23723_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event berlangsung, Bab 5 Operasi Investigasi ditutup sementara. Kunci "Obsesi Abadi" untuk sementara dapat diperoleh dengan menyelesaikan Bab 4 Operasi Investigasi.
2. Setelah event berakhir, Bab 5 Operasi Investigasi akan dibuka kembali. Kunci "Obsesi Abadi" tetap memerlukan penyelesaian Bab 5 Operasi Investigasi.
3. Selain itu, hadiah pencapaian Bab 5, hadiah pencapaian stage, hadiah eksplorasi, dan hadiah penyelesaian yang telah diraih sebelumnya akan tetap dipertahankan. Saat dibuka kembali (rencana saat ini tanggal 27 Desember), progres terkait yang telah diselesaikan akan dipindahkan dan dipertahankan semaksimal mungkin, tidak perlu menyelesaikan ulang.]]
  },
  Activity_23870_ActivityName = {
    Text = "Deduksi Fase"
  },
  Activity_23870_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama periode event, selesaikan misi event untuk mendapatkan hadiah.
2. Setelah event berakhir, hadiah event yang belum diklaim tidak dapat diklaim lagi. Jangan lupa untuk mengklaimnya tepat waktu~]]
  },
  Activity_23936_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23936_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Kedalaman Laut"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23937_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23937_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Kluster Chaos"akan mendapatkan bonus material 50% tambahan (tidak termasuk EXP Keeper dan Kupon Emas Rosea), tanpa batas jumlah per hari.]]
  },
  Activity_23938_ActivityName = {
    Text = "Penyelaman & Catur"
  },
  Activity_23938_ActivityPlot = {
    Text = "Selama event berlangsung, EXP Keeper yang diperoleh melalui\"Penyelaman Mimpi\"dan\"Catur Fase\"akan digandakan, dengan batas harian ditingkatkan menjadi 480 poin."
  },
  Activity_23938_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Penyelaman & Catur"berlangsung, EXP Keeper yang diperoleh melalui"Penyelaman Mimpi"dan"Catur Fase"akan digandakan, dengan batas harian ditingkatkan menjadi 480 poin. Jika Riset Inti juga telah dibuka, EXP Keeper yang diperoleh melalui jalur tersebut akan digandakan lagi, dengan batas harian tetap 480 poin.
2. EXP Keeper ganda yang belum digunakan pada hari itu akan direset pada pukul 9 keesokan harinya (GMT+8). Keeper, jangan lupa untuk menghabiskannya tepat waktu ya~]]
  },
  Activity_23939_ActivityName = {
    Text = "Penyelaman & Catur"
  },
  Activity_23939_ActivityPlot = {
    Text = "Selama event berlangsung, EXP Keeper yang diperoleh melalui\"Penyelaman Mimpi\"dan\"Catur Fase\"akan digandakan, dengan batas harian ditingkatkan menjadi 480 poin."
  },
  Activity_23939_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Penyelaman & Catur"berlangsung, EXP Keeper yang diperoleh melalui"Penyelaman Mimpi"dan"Catur Fase"akan digandakan, dengan batas harian ditingkatkan menjadi 480 poin. Jika Riset Inti juga telah dibuka, EXP Keeper yang diperoleh melalui jalur tersebut akan digandakan lagi, dengan batas harian tetap 480 poin.
2. EXP Keeper ganda yang belum digunakan pada hari itu akan direset pada pukul 9 keesokan harinya (GMT+8). Keeper, jangan lupa untuk menghabiskannya tepat waktu ya~]]
  },
  Activity_23940_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_23940_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event "Ledakan Gnosis", setelah Keeper menyelesaikan "Pemurnian Ramuan", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali per hari.
2. Jumlah hadiah ganda yang tidak digunakan pada hari itu akan direset pada pukul 9 pagi (GMT+8) keesokan harinya. Keeper, jangan lupa untuk menggunakannya tepat waktu~]]
  },
  Activity_23941_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23941_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Schwarzschild Throat"akan mendapatkan bonus material 50% tambahan (tidak termasuk EXP Keeper dan Kupon Emas Rosea), tanpa batas jumlah per hari.]]
  },
  Activity_23942_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23942_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif"berlangsung, setelah Keeper menyelesaikan"Sarang Cacing", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali setiap hari.
2. Jumlah kesempatan hadiah ganda yang belum digunakan pada hari itu akan direset pada pukul 9 keesokan harinya (GMT+8). Keeper, jangan lupa untuk menggunakannya tepat waktu ya~]]
  },
  Activity_23943_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23943_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Dimensi"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23944_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23944_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Organik"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23945_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23945_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event "Deduksi Sublimasi", setelah Keeper menyelesaikan "Bayangan Keruh", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali per hari.
2. Jumlah hadiah ganda yang tidak digunakan pada hari itu akan direset pada pukul 9 pagi (GMT+8) keesokan harinya. Keeper, jangan lupa untuk menggunakannya tepat waktu~]]
  },
  Activity_23946_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23946_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Dimensi"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23947_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23947_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Reruntuhan Ponape"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23948_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23948_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Kluster Chaos"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23949_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23949_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Keruh"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23950_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23950_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Kedalaman Laut"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23951_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23951_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Kluster Chaos"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23953_ActivityName = {
    Text = "Penyelaman & Catur"
  },
  Activity_23953_ActivityPlot = {
    Text = "Selama event berlangsung, EXP Keeper yang diperoleh melalui\"Penyelaman Mimpi\"dan\"Catur Fase\"akan digandakan, dengan batas harian ditingkatkan menjadi 480 poin."
  },
  Activity_23953_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Penyelaman & Catur"berlangsung, EXP Keeper yang diperoleh melalui"Penyelaman Mimpi"dan"Catur Fase"akan digandakan, dengan batas harian ditingkatkan menjadi 480 poin. Jika Riset Inti juga telah dibuka, EXP Keeper yang diperoleh melalui jalur tersebut akan digandakan lagi, dengan batas harian tetap 480 poin.
2. EXP Keeper ganda yang belum digunakan pada hari itu akan direset pada pukul 9 keesokan harinya (GMT+8). Keeper, jangan lupa untuk menghabiskannya tepat waktu ya~]]
  },
  Activity_23954_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23954_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Kluster Chaos"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23955_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23955_ActivityTips = {
    Text = [[
Aturan acara:
1. Selama acara "Skena Mendidik", Penjaga yang melakukan investigasi atau Reproduksi di "Residu Laut Dalam" akan mendapatkan bonus material tambahan sebesar 50% (tidak termasuk Pengalaman penjaga dan Rose Scrip), tanpa batas per hari.]]
  },
  Activity_23956_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23956_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Reruntuhan Ponape"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23957_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_23957_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Ledakan Gnosis", Keeper yang menyelidiki atau memutar ulang"Pemurnian Ramuan"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23958_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23958_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Organik"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23959_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23959_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Schwarzschild Throat"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23960_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23960_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Reruntuhan Ponape"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23961_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23961_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Kluster Chaos"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23962_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_23962_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Ledakan Gnosis", Keeper yang menyelidiki atau memutar ulang"Pemurnian Ramuan"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23963_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23963_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Kedalaman Laut"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23964_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23964_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Dimensi"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23965_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23965_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Kluster Chaos"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23966_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23966_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Dimensi"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23967_ActivityName = {
    Text = "Penyelaman & Catur"
  },
  Activity_23967_ActivityPlot = {
    Text = "Selama event berlangsung, EXP Keeper yang diperoleh melalui\"Penyelaman Mimpi\"dan\"Catur Fase\"akan digandakan, dengan batas harian ditingkatkan menjadi 480 poin."
  },
  Activity_23967_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Penyelaman & Catur"berlangsung, EXP Keeper yang diperoleh melalui"Penyelaman Mimpi"dan"Catur Fase"akan digandakan, dengan batas harian ditingkatkan menjadi 480 poin. Jika Riset Inti juga telah dibuka, EXP Keeper yang diperoleh melalui jalur tersebut akan digandakan lagi, dengan batas harian tetap 480 poin.
2. EXP Keeper ganda yang belum digunakan pada hari itu akan direset pada pukul 9 keesokan harinya (GMT+8). Keeper, jangan lupa untuk menghabiskannya tepat waktu ya~]]
  },
  Activity_23968_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_23968_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Ledakan Gnosis", Keeper yang menyelidiki atau memutar ulang"Pemurnian Ramuan"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23969_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23969_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Schwarzschild Throat"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23970_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23970_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Kedalaman Laut"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23971_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23971_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Dimensi"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23972_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23972_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Sarang Cacing"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23973_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23973_ActivityTips = {
    Text = [[
Aturan acara:
1. Selama acara "Skena Mendidik", Penjaga yang melakukan investigasi atau Reproduksi di "Sisa keruh" akan mendapatkan bonus material tambahan sebesar 50% (tidak termasuk Pengalaman penjaga dan Rose Scrip), tanpa batas per hari.]]
  },
  Activity_23974_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_23974_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Ledakan Gnosis", Keeper yang menyelidiki atau memutar ulang"Pemurnian Ramuan"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23975_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23975_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event "Deduksi Sublimasi", setelah Keeper menyelesaikan "Bayangan Organik", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali per hari.
2. Jumlah hadiah ganda yang tidak digunakan pada hari itu akan direset pada pukul 9 pagi (GMT+8) keesokan harinya. Keeper, jangan lupa untuk menggunakannya tepat waktu~]]
  },
  Activity_23976_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23976_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Kedalaman Laut"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23977_ActivityName = {
    Text = "Estetika Alkimia"
  },
  Activity_23977_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Estetika Alkimia", Keeper yang menyelidiki atau memutar ulang"Pencarian Kupon Emas"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23978_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_23978_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Ledakan Gnosis", Keeper yang menyelidiki atau memutar ulang"Pemurnian Ramuan"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23979_ActivityName = {
    Text = "Estetika Alkimia"
  },
  Activity_23979_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Estetika Alkimia"berlangsung, setelah Keeper menyelesaikan"Pencarian Kupon Emas", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali setiap hari.
2. Jumlah kesempatan hadiah ganda yang belum digunakan pada hari itu akan direset pada pukul 9 keesokan harinya (GMT+8). Keeper, jangan lupa untuk menggunakannya tepat waktu ya~]]
  },
  Activity_23980_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23980_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif"berlangsung, setelah Keeper menyelesaikan"Chaos Cluster", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali setiap hari.
2. Jumlah kesempatan hadiah ganda yang belum digunakan pada hari itu akan direset pada pukul 9 keesokan harinya (GMT+8). Keeper, jangan lupa untuk menggunakannya tepat waktu ya~]]
  },
  Activity_23981_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23981_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Dimensi"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23982_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23982_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Sarang Cacing"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23983_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23983_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event "Deduksi Sublimasi", setelah Keeper menyelesaikan "Bayangan Dimensi", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali per hari.
2. Jumlah hadiah ganda yang tidak digunakan pada hari itu akan direset pada pukul 9 pagi (GMT+8) keesokan harinya. Keeper, jangan lupa untuk menggunakannya tepat waktu~]]
  },
  Activity_23984_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23984_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Sarang Cacing"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23985_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_23985_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Ledakan Gnosis", Keeper yang menyelidiki atau memutar ulang"Pemurnian Ramuan"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23986_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23986_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Keruh"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23987_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_23987_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Ledakan Gnosis", Keeper yang menyelidiki atau memutar ulang"Pemurnian Ramuan"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23988_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23988_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Keruh"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23989_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23989_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Sarang Cacing"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23990_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23990_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Schwarzschild Throat"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23991_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23991_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Sarang Cacing"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23992_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23992_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Kedalaman Laut"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23993_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23993_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Organik"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23994_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23994_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Kluster Chaos"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23995_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23995_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Schwarzschild Throat"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23996_ActivityName = {
    Text = "Penyelaman & Catur"
  },
  Activity_23996_ActivityPlot = {
    Text = "Selama event berlangsung, EXP Keeper yang diperoleh melalui\"Penyelaman Mimpi\"dan\"Catur Fase\"akan digandakan, dengan batas harian ditingkatkan menjadi 480 poin."
  },
  Activity_23996_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Penyelaman & Catur"berlangsung, EXP Keeper yang diperoleh melalui"Penyelaman Mimpi"dan"Catur Fase"akan digandakan, dengan batas harian ditingkatkan menjadi 480 poin. Jika Riset Inti juga telah dibuka, EXP Keeper yang diperoleh melalui jalur tersebut akan digandakan lagi, dengan batas harian tetap 480 poin.
2. EXP Keeper ganda yang belum digunakan pada hari itu akan direset pada pukul 9 keesokan harinya (GMT+8). Keeper, jangan lupa untuk menghabiskannya tepat waktu ya~]]
  },
  Activity_23997_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23997_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Reruntuhan Ponape"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_23998_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_23998_ActivityTips = {
    Text = [[
Aturan acara:
1. Selama acara "Skena Mendidik", Penjaga yang melakukan investigasi atau Reproduksi di "Residu organik" akan mendapatkan bonus material tambahan sebesar 50% (tidak termasuk Pengalaman penjaga dan Rose Scrip), tanpa batas per hari.]]
  },
  Activity_23999_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_23999_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Schwarzschild Throat"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24000_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24000_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Kedalaman Laut"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24001_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24001_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Kluster Chaos"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24002_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24002_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Organik"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24003_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24003_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Sarang Cacing"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24004_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24004_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Dimensi"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24005_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24005_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Schwarzschild Throat"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24006_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24006_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Reruntuhan Ponape"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24007_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24007_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif"berlangsung, setelah Keeper menyelesaikan"Reruntuhan Pohnpei", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali setiap hari.
2. Jumlah kesempatan hadiah ganda yang belum digunakan pada hari itu akan direset pada pukul 9 keesokan harinya (GMT+8). Keeper, jangan lupa untuk menggunakannya tepat waktu ya~]]
  },
  Activity_24009_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24009_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Organik"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24010_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24010_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Keruh"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24011_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_24011_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Ledakan Gnosis", Keeper yang menyelidiki atau memutar ulang"Pemurnian Ramuan"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24012_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24012_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Organik"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24013_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24013_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Schwarzschild Throat"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24014_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24014_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Keruh"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24015_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_24015_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Ledakan Gnosis", Keeper yang menyelidiki atau memutar ulang"Pemurnian Ramuan"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24016_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24016_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Kedalaman Laut"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24017_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24017_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Schwarzschild Throat"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24018_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24018_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Keruh"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24019_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24019_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event "Deduksi Sublimasi", setelah Keeper menyelesaikan "Bayangan Kedalaman Laut", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali per hari.
2. Jumlah hadiah ganda yang tidak digunakan pada hari itu akan direset pada pukul 9 pagi (GMT+8) keesokan harinya. Keeper, jangan lupa untuk menggunakannya tepat waktu~]]
  },
  Activity_24020_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_24020_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Ledakan Gnosis", Keeper yang menyelidiki atau memutar ulang"Pemurnian Ramuan"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24021_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24021_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Reruntuhan Ponape"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24022_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_24022_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Ledakan Gnosis", Keeper yang menyelidiki atau memutar ulang"Pemurnian Ramuan"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24023_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24023_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif"berlangsung, setelah Keeper menyelesaikan"Schwarzschild Throat", sebagian hadiah material akan digandakan, dapat dinikmati 3 kali setiap hari.
2. Jumlah kesempatan hadiah ganda yang belum digunakan pada hari itu akan direset pada pukul 9 keesokan harinya (GMT+8). Keeper, jangan lupa untuk menggunakannya tepat waktu ya~]]
  },
  Activity_24025_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24025_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Reruntuhan Ponape"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24026_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24026_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Sarang Cacing"akan mendapatkan bonus material 50% tambahan (tidak termasuk EXP Keeper dan Kupon Emas Rosea), tanpa batas jumlah per hari.]]
  },
  Activity_24027_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24027_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Sarang Cacing"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24028_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24028_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Organik"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24029_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24029_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Schwarzschild Throat"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24030_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24030_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Keruh"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24031_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_24031_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Ledakan Gnosis", Keeper yang menyelidiki atau memutar ulang"Pemurnian Ramuan"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24032_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24032_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Kedalaman Laut"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24033_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24033_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Organik"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24034_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24034_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Reruntuhan Ponape"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24035_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24035_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Sarang Cacing"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24036_ActivityName = {
    Text = "Penyelaman & Catur"
  },
  Activity_24036_ActivityPlot = {
    Text = "Selama event berlangsung, EXP Keeper yang diperoleh melalui\"Penyelaman Mimpi\"dan\"Catur Fase\"akan digandakan, dengan batas harian ditingkatkan menjadi 480 poin."
  },
  Activity_24036_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Penyelaman & Catur"berlangsung, EXP Keeper yang diperoleh melalui"Penyelaman Mimpi"dan"Catur Fase"akan digandakan, dengan batas harian ditingkatkan menjadi 480 poin. Jika Riset Inti juga telah dibuka, EXP Keeper yang diperoleh melalui jalur tersebut akan digandakan lagi, dengan batas harian tetap 480 poin.
2. EXP Keeper ganda yang belum digunakan pada hari itu akan direset pada pukul 9 keesokan harinya (GMT+8). Keeper, jangan lupa untuk menghabiskannya tepat waktu ya~]]
  },
  Activity_24037_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24037_ActivityTips = {
    Text = [[
Aturan acara:
1. Selama acara "Skena Mendidik", Penjaga yang melakukan investigasi atau Reproduksi di "Residu Dimensi" akan mendapatkan bonus material tambahan sebesar 50% (tidak termasuk Pengalaman penjaga dan Rose Scrip), tanpa batas per hari.]]
  },
  Activity_24038_ActivityName = {
    Text = "Penyelaman & Catur"
  },
  Activity_24038_ActivityPlot = {
    Text = "Selama event berlangsung, EXP Keeper yang diperoleh melalui\"Penyelaman Mimpi\"dan\"Catur Fase\"akan digandakan, dengan batas harian ditingkatkan menjadi 480 poin."
  },
  Activity_24038_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Penyelaman & Catur"berlangsung, EXP Keeper yang diperoleh melalui"Penyelaman Mimpi"dan"Catur Fase"akan digandakan, dengan batas harian ditingkatkan menjadi 480 poin. Jika Riset Inti juga telah dibuka, EXP Keeper yang diperoleh melalui jalur tersebut akan digandakan lagi, dengan batas harian tetap 480 poin.
2. EXP Keeper ganda yang belum digunakan pada hari itu akan direset pada pukul 9 keesokan harinya (GMT+8). Keeper, jangan lupa untuk menghabiskannya tepat waktu ya~]]
  },
  Activity_24039_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24039_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Sarang Cacing"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24040_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_24040_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Ledakan Gnosis", Keeper yang menyelidiki atau memutar ulang"Pemurnian Ramuan"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24041_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_24041_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Ledakan Gnosis"berlangsung, Keeper yang menyelidiki atau merekonstruksi di"Pemurnian Preparat"akan mendapatkan tambahan 50% hadiah Preparat Gnosis, tanpa batas jumlah per hari.]]
  },
  Activity_24042_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24042_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Dimensi"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24043_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_24043_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Ledakan Gnosis", Keeper yang menyelidiki atau memutar ulang"Pemurnian Ramuan"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24044_ActivityName = {
    Text = "Estetika Alkimia"
  },
  Activity_24044_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Estetika Alkimia", Keeper yang menyelidiki atau memutar ulang"Pencarian Kupon Emas"akan mendapatkan bonus 50% tambahan berupa Kupon Emas Rosea, tanpa batas jumlah per hari.]]
  },
  Activity_24045_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24045_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Kluster Chaos"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24046_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_24046_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Ledakan Gnosis", Keeper yang menyelidiki atau memutar ulang"Pemurnian Ramuan"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24047_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24047_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Reruntuhan Ponape"akan mendapatkan bonus material 50% tambahan (tidak termasuk EXP Keeper dan Kupon Emas Rosea), tanpa batas jumlah per hari.]]
  },
  Activity_24049_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24049_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Organik"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24050_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24050_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Reruntuhan Ponape"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24051_ActivityName = {
    Text = "Latihan Intensif"
  },
  Activity_24051_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Latihan Intensif", Keeper yang menyelidiki atau memutar ulang"Kluster Chaos"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24052_ActivityName = {
    Text = "Ledakan Gnosis"
  },
  Activity_24052_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Ledakan Gnosis", Keeper yang menyelidiki atau memutar ulang"Pemurnian Ramuan"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24053_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24053_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Keruh"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24054_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24054_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Keruh"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24055_ActivityName = {
    Text = "Deduksi Sublimasi"
  },
  Activity_24055_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Deduksi Peningkatan", Keeper yang menyelidiki atau memutar ulang"Bayangan Dimensi"akan mendapatkan bonus hadiah 50% tambahan (tidak termasuk EXP Keeper), tanpa batas jumlah per hari.]]
  },
  Activity_24194_ActivityName = {
    Text = "Nyonya Merah"
  },
  Activity_24194_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Nyonya Merah\" berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Soreil untuk mencoba level yang ditentukan tanpa batas.\n·Saat mencoba level aktivitas, formasi Awakened dalam tim tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan level, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_24195_ActivityName = {
    Text = "Bunga dari Lumpur"
  },
  Activity_24195_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Bunga dari Lumpur\" berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Lily untuk mencoba level yang ditentukan tanpa batas.\n·Saat mencoba level aktivitas, formasi Awakened dalam tim tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan level, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_24992_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_24992_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_25011_ActivityName = {
    Text = "Selangkah Lagi"
  },
  Activity_25011_ActivityPlot = {
    Text = "Kamu melangkah maju satu langkah, memasuki ruang dan waktu yang lain."
  },
  Activity_25011_ActivityTips = {
    Text = "<Title:Syarat Partisipasi>\n·Dapat diikuti setelah menyelesaikan mode Normal Penyelaman Kesadaran \"Keinginan Ksatria\". \n<Title:Peristiwa Investigasi>\n·Selama periode event, setiap hari akan dirilis satu peristiwa investigasi baru di \"Selangkah Lagi\". Keeper tidak perlu menggunakan sumber daya untuk membuka investigasi. Setelah menyelesaikan peristiwa investigasi, kamu bisa mendapatkan hadiah investigasi seperti Inti Murni, Lencana Investigasi, dan EXP Keeper.\n·Setelah event berakhir, progres investigasi \"Selangkah Lagi\" akan disimpan. Keeper dapat menggunakan Mutiara Erosi di Penyelaman Kesadaran untuk membuka investigasi yang belum terbuka. Menyelesaikan peristiwa investigasi yang belum selesai selama event juga akan memberikan hadiah investigasi yang sama seperti saat event berlangsung.<Title:Hadiah Terbatas>\n·Selama periode event, hadiah terbatas akan tersedia. Setelah Keeper menyelesaikan mode Normal \"Selangkah Lagi\" dan menyelesaikan peristiwa investigasi \"Selangkah Lagi\", kamu bisa mendapatkan hadiah Permen Keberuntungan dan Silver Core! Hadiah terbatas hanya tersedia selama periode event. Setelah event berakhir, hadiah tidak dapat diselesaikan atau diklaim."
  },
  Activity_25011_UnlockConditionExplanation = {
    Text = "Terbuka setelah menyelesaikan Penyelaman Kesadaran \"Keinginan Ksatria\""
  },
  Activity_25012_ActivityName = {
    Text = "Pujian Mawar"
  },
  Activity_25012_ActivityPlot = {
    Text = "Para hadirin sekalian.\nMalam yang tenang dan damai telah membuka tirainya, siapkanlah minuman terbaik di tangan Anda.\nIni adalah kisah yang panjang, dengarkanlah kami menceritakannya perlahan…"
  },
  Activity_25012_ActivityTips = {
    Text = "<Title:Syarat Partisipasi>\n·Dapat berpartisipasi setelah menyelesaikan \"Operasi Investigasi\" 2-9·Normal.\n<Title:Event Investigasi>\n·Selama periode aktivitas, setiap hari akan merilis satu event investigasi baru di \"Pujian Rosea\". Keeper tidak perlu mengonsumsi sumber daya untuk membuka dan melakukan investigasi. Setelah menyelesaikan event investigasi, dapat memperoleh hadiah investigasi seperti Inti Murni, Lencana Investigasi, dan EXP Keeper.\n·Setelah aktivitas berakhir, progres investigasi \"Pujian Rosea\" akan dipertahankan. Keeper dapat mengonsumsi Mutiara Erosi di Catatan Ekspedisi untuk membuka investigasi yang belum terbuka. Setelah menyelesaikan event investigasi yang belum selesai selama periode aktivitas, juga dapat memperoleh hadiah investigasi yang sama seperti saat periode aktivitas.<Title:Hadiah Terbatas>\n·Selama periode aktivitas akan tersedia hadiah terbatas. Setelah Keeper menyelesaikan mode Normal \"Pujian Rosea\" dan menyelesaikan event investigasi \"Pujian Rosea\", dapat memperoleh hadiah Inti Murni, Batu Bijak, dan Silver Core! Hadiah terbatas hanya dibuka selama periode aktivitas, setelah aktivitas berakhir tidak dapat diselesaikan dan diklaim."
  },
  Activity_25012_UnlockConditionExplanation = {
    Text = "Setelah menyelesaikan \"Operasi\"2-9·Normal, akan terbuka."
  },
  Activity_34754_ActivityName = {
    Text = "Magis cerita"
  },
  Activity_34754_ActivityTips = {
    Text = "<Title:Syarat Partisipasi>\n·Selesaikan \"Operasi\"2-9·Normal untuk berpartisipasi.\n<Title:Acara Penyelidikan>\n·Selama acara berlangsung, setiap hari akan ada acara penyelidikan baru di \"Cerita Ajaib\". Penjaga tidak perlu menghabiskan inventaris untuk membuka kunci dan melakukan penyelidikan. Setelah menyelesaikan acara penyelidikan, Penjaga dapat memperoleh inti murni, lencana penyelidikan, dan pengalaman penjaga sebagai hadiah penyelidikan.\n·Setelah acara berakhir, kemajuan penyelidikan di \"Cerita Ajaib\"akan tetap tersimpan. Penjaga dapat menggunakan D-permata di catatan misi khusus untuk membuka kunci penyelidikan yang belum dibuka. Menyelesaikan acara penyelidikan yang belum selesai selama acara juga akan memberikan hadiah penyelidikan yang sama seperti selama acara.<Title:Hadiah Terbatas Waktu>\n·Selama acara berlangsung, hadiah terbatas waktu akan diluncurkan. Penjaga yang menyelesaikan mode Normal \"Cerita Ajaib\"dan menyelesaikan acara penyelidikan \"Cerita Ajaib\"dapat memperoleh inti murni, batu filsuf, dan hadiah perak! Hadiah terbatas waktu hanya tersedia selama acara, dan setelah acara berakhir, hadiah tidak dapat diselesaikan atau diklaim."
  },
  Activity_34755_ActivityName = {
    Text = "Magis cerita"
  },
  Activity_34755_ActivityTips = {
    Text = "<Title:Deskripsi Aktivitas>\n·Selama periode aktivitas, mode \"Misteri Naskah\" dibuka terbatas, dan \"Rekam Jejak: Magis Cerita\" dapat dibuka secara gratis!\n\n<Title:Misteri Naskah>\n·\"Misteri Naskah\"terdiri dari 9 tingkat kesulitan, dengan rentang level yang direkomendasikan antara 30~70, membuka tingkat kesulitan yang lebih tinggi setelah menyelesaikan tingkat kesulitan yang lebih rendah.\n·Setiap tantangan membutuhkan konsumsi Menophin ×60, setelah menyelesaikan setiap tantangan, Anda dapat memperoleh mata uang aktivitas \"Inspirasi yang Melayang\". Semakin tinggi tingkat kesulitan, semakin banyak \"Inspirasi yang Melayang\"yang didapat!\n·\"Inspirasi yang Melayang\"dapat ditukarkan di \"Toko Naskah Sihir\"untuk banyak bahan pelatihan Awakener, dan juga dapat ditukarkan untuk SR Roda Takdir terbatas aktivitas \"Sihir 35mm\", roda ini mungkin akan dirilis kembali atau ditambahkan ke Awakener permanen di masa depan.\n·Setiap kali tantangan, musuh, kejadian, dan peta selain pemimpin mungkin mengalami perubahan tertentu, serta lebih banyak Relic yang mungkin muncul dalam tingkat!\n·Di \"Misteri Naskah\", Anda dapat menggunakan bantuan Alumni.\n\n<Title:Resonansi dan Prestasi>\n·Menggunakan \"Hatinya Penampilan\", aktifkan \"Resonansi: Kode Sutradara\", dapat membuat Penjaga menjadi lebih kuat dalam \"Misteri Naskah\", sehingga tantangan menjadi lebih mudah.\n·Penjaga dapat memperoleh \"Hatinya Penampilan\"melalui pencapaian aktivitas, selain itu melalui pencapaian aktivitas juga dapat memperoleh avatar terbatas aktivitas \"Atas nama Kunci Perak: Lily\"!\n\n<Title:Rekam Jejak>\n·Selama periode aktivitas, setiap hari akan diluncurkan satu kejadian investigasi baru dari \"Magis Cerita\", Penjaga tidak perlu menghabiskan sumber daya untuk membuka investigasi, setelah menyelesaikan kejadian investigasi dapat memperoleh Inti Murni, Lencana Penyelidikan, dan Pengalaman Penjaga sebagai hadiah investigasi.\n·Setelah aktivitas berakhir, kemajuan investigasi \"Magis Cerita\"akan dipertahankan, Penjaga dapat menghabiskan D-permata untuk membuka investigasi yang belum terkunci di Rekam Jejak, menyelesaikan kejadian investigasi yang belum selesai selama periode aktivitas juga dapat memperoleh hadiah investigasi yang sama seperti selama periode aktivitas.\n·Selama periode aktivitas, akan diluncurkan hadiah pencapaian terbatas, Penjaga yang menyelesaikan mode normal \"Magis Cerita\"dan menyelesaikan kejadian investigasi \"Magis Cerita\"dapat mengambil hadiah Perak di pencapaian aktivitas! Hadiah pencapaian hanya dibuka selama periode aktivitas, setelah aktivitas berakhir, tidak dapat diselesaikan atau diambil.\n"
  },
  Activity_34764_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34765_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34766_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34767_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34768_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34769_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34770_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34771_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34772_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34773_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34774_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34775_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34776_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34777_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34778_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34779_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34780_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34781_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34782_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34783_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34784_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34785_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34786_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34787_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34788_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34789_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34790_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34791_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34792_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34793_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34794_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34795_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34796_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34797_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34798_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34799_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34800_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34801_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34802_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34803_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34804_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34805_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34806_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34807_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34808_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34809_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34810_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34811_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34812_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34813_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34814_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34815_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34816_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34817_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34818_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34819_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34820_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34821_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34822_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34823_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34824_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34825_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34826_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34827_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_34828_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_35844_ActivityName = {
    Text = "Wanita Aequor"
  },
  Activity_35844_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Deep Sea Lady\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Murphy untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_35983_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_35983_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_36841_ActivityName = {
    Text = "Semua Seperti Biasa"
  },
  Activity_36841_ActivityPlot = {
    Text = "Ini adalah hari yang sederhana dan menyenangkan bagi Oreta, ini adalah setiap harinya."
  },
  Activity_36841_ActivityTips = {
    Text = "<Title:Syarat Partisipasi>\n·Dapat diikuti setelah menyelesaikan mode Normal Penyelaman Kesadaran \"Keinginan Ksatria\". \n<Title:Peristiwa Investigasi>\n·Selama periode event, Keeper tidak perlu menggunakan sumber daya untuk membuka investigasi. Setelah menyelesaikan peristiwa investigasi, kamu bisa mendapatkan hadiah investigasi seperti Inti Murni, Lencana Investigasi, dan EXP Keeper.\n·Setelah event berakhir, progres investigasi \"Semua Seperti Biasa\" akan disimpan. Keeper dapat menggunakan Mutiara Erosi di Penyelaman Kesadaran untuk membuka investigasi yang belum terbuka. Menyelesaikan peristiwa investigasi yang belum selesai selama event juga akan memberikan hadiah investigasi yang sama seperti saat event berlangsung.<Title:Hadiah Terbatas>\n·Selama periode event, hadiah terbatas akan tersedia. Setelah Keeper menyelesaikan mode Normal \"Semua Seperti Biasa\" dan menyelesaikan peristiwa investigasi \"Semua Seperti Biasa\", kamu bisa mendapatkan hadiah Gesper Hitam Pekat dan Silver Core! Hadiah terbatas hanya tersedia selama periode event. Setelah event berakhir, hadiah tidak dapat diselesaikan atau diklaim."
  },
  Activity_36841_UnlockConditionExplanation = {
    Text = "Terbuka setelah menyelesaikan Penyelaman Kesadaran \"Keinginan Ksatria\""
  },
  Activity_36885_ActivityName = {Text = "Pesta Api"},
  Activity_36886_ActivityName = {Text = "Ratu Duri"},
  Activity_36886_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Ratu Duri\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Wanda untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_38716_ActivityName = {
    Text = "Investigasi Dimulai Ulang"
  },
  Activity_38716_ActivityTips = {
    Text = "<Title:Pengantar Aktivitas>\n·Penjaga Rahasia dapat langsung mengklaim hadiah\"Suplai Restart\"di\"Hadiah Kembali ke Sekolah\".\n·Menyelesaikan misi latihan yang ditentukan memungkinkan kamu mengklaim hadiah di aktivitas\"Investigasi Dimulai Ulang\".\n·Menyelesaikan semua misi latihan juga memberikan hadiah tambahan."
  },
  Activity_38717_ActivityName = {
    Text = "Kembali ke Sekolah"
  },
  Activity_38717_ActivityTips = {
    Text = "<Title:Pengantar Aktivitas>\n·Penjaga Rahasia dapat mengklaim hadiah check-in harian di\"Kembali ke Sekolah\"setelah login setiap hari.\n·Hadiah akan dibuka secara berurutan berdasarkan total hari login Penjaga Rahasia. Hadiah check-in harian akan di-refresh pada pukul 9:00 (GMT+8)."
  },
  Activity_38805_ActivityName = {Text = "Pesta Api"},
  Activity_38805_ActivityPlot = {
    Text = [[
Isarau, Kota di Danau, dikatakan sebagai Rumah Wanda. 
 Kali ini kamu akan melewati gerbang Mimpi, mencapai kelompok menara kuno yang dipenuhi dengan lidah lonceng...]]
  },
  Activity_38805_ActivityTips = {
    Text = "<Title:Deskripsi Aktivitas>\n·Selama periode aktivitas, gameplay\"Pesta Api\"dibuka secara terbatas, dan\"Yang berkelana: Pesta Api\"dapat dibuka secara gratis!\n\n<Title:Kota di Danau>\n·\"Kota di Danau\"memiliki 7 tingkat, satu tingkat dibuka setiap 2 hari! Musuh dan kejadian di setiap tingkat dapat berubah secara acak.\n·Harap diperhatikan, jenis, jumlah, dan proporsi campuran bahan yang diberikan sebagai hadiah di setiap tingkat dapat bervariasi. Tingkat yang dibuka lebih awal memiliki jenis yang lebih sederhana, sementara tingkat yang dibuka lebih lambat memiliki jenis yang lebih kaya tetapi totalnya akan lebih banyak. Silakan pilih metode strategi sesuai kebutuhan Anda!\n·Setiap tingkat terdiri dari 7 tingkat kesulitan, dengan rentang level yang direkomendasikan adalah 15~65, semua tingkat kesulitan sudah dibuka secara default.\n·Setiap tantangan memerlukan konsumsi Menophin ×120, semakin tinggi kesulitannya, semakin banyak hadiah yang didapat, silakan pilih tingkat kesulitan yang sesuai untuk tantangan Anda.\n·Bahan hadiah dari tingkat dapat ditukarkan di toko\"Peti harta wanda\"untuk mendapatkan banyak bahan pengembangan Awakeners, serta avatar terbatas acara\"Atas nama Kunci Perak: Wanda\".\n·Anda dapat menggunakan bantuan alumni dan\"Resonansi: Perintah Rahasia\"untuk membantu Anda melewati tingkat dengan lebih mudah..\n\n<Title:Resonansi dan Prestasi>\n·Menggunakan\"Hati Kesenangan\"untuk mengaktifkan\"Resonansi: Perintah Rahasia\"akan membuat Penjaga menjadi lebih kuat di\"Kota di Danau\"dan tantangan menjadi lebih mudah; juga dapat memberikan Penjaga mata uang acara tambahan saat menyelesaikan tantangan.\n·Penjaga dapat memperoleh\"Hati Kesenangan\"dengan menyelesaikan prestasi acara, atau menukarnya di toko\"Peti harta wanda\".\n\n<Title:Yang berkelana>\n·Selama periode acara,\"Pesta Api\"dapat dibuka secara gratis. Setiap hari akan ada satu kejadian investigasi baru di\"Pesta Api\",menyelesaikan kejadian investigasi akan mendapatkan Inti murni, Lencana penyelidikan, dan Pengalaman penjaga sebagai hadiah penyelidikan.\n·Setelah acara berakhir, progres investigasi\"Pesta Api\"akan dipertahankan, menyelesaikan kejadian investigasi yang belum selesai selama periode acara juga akan mendapatkan hadiah penyelidikan yang sama dengan periode acara. Jika\"Pesta Api\"belum dibuka selama periode acara, setelah acara berakhir, Anda masih dapat menghabiskan\"Titik awal realitas\"×3 untuk membukanya.\n·Selama periode acara, akan ada hadiah prestasi terbatas, Penjaga dapat menerima hadiah Perak setelah menyelesaikan kejadian investigasi\"Pesta Api\"! Hadiah prestasi hanya dibuka selama periode acara, setelah acara berakhir tidak dapat diselesaikan dan diterima.\n"
  },
  Activity_41378_ActivityName = {
    Text = "Pelatihan Kesiapsiagaan Bencana"
  },
  Activity_41378_ActivityTips = {
    Text = [[
Aturan Aktivitas:
1. Setelah Penjaga Rahasia menyelesaikan misi yang ditentukan, hadiah dapat diklaim di "Latihan Khusus Bencana".
2. "Latihan Khusus Bencana" dibuka secara permanen.
3. Setelah membuka "Chronicle Premium", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
4. Harap diperhatikan: "Chronicle Premium" yang dibuka dalam aktivitas ini hanya berlaku untuk aktivitas ini. Penjaga Rahasia diharapkan untuk berbelanja secara bijak.]]
  },
  Activity_43569_ActivityName = {
    Text = "Pelayaran Jauh"
  },
  Activity_43569_ActivityTips = {
    Text = [[
Aturan Event:
1. Setelah Penjaga Rahasia menyelesaikan misi Chronicle yang ditentukan, hadiah dapat diklaim di "Chronicle Samudera".
2. "Chronicle Samudera" dibuka secara permanen.
3. Setelah membuka "Chronicle Lanjutan", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
4. Perhatian: "Chronicle Lanjutan" yang dibuka dalam event ini hanya berlaku di event ini. Penjaga Rahasia diharapkan membelanjakan secara bijak.]]
  },
  Activity_43570_ActivityName = {
    Text = "Perjalanan ke Kota Salju"
  },
  Activity_43570_ActivityTips = {
    Text = [[
Aturan Event:
1. Setelah Penjaga Rahasia menyelesaikan misi Chronicle yang ditentukan, hadiah dapat diklaim di "Chronicle Kota Salju".
2. "Chronicle Kota Salju" dibuka secara permanen.
3. Setelah membuka "Chronicle Lanjutan", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
4. Perhatian: "Chronicle Lanjutan" yang dibuka dalam event ini hanya berlaku di event ini. Penjaga Rahasia diharapkan membelanjakan secara bijak.]]
  },
  Activity_43572_ActivityName = {
    Text = "Estetika Alkimia"
  },
  Activity_43572_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Estetika Alkimia", Keeper yang menyelidiki atau memutar ulang"Pencarian Kupon Emas"akan mendapatkan bonus hadiah 100% tambahan (tidak termasuk EXP Keeper), terbatas 6 kali per hari.]]
  },
  Activity_43573_ActivityName = {
    Text = "Estetika Alkimia"
  },
  Activity_43573_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Estetika Alkimia", Keeper yang menyelidiki atau memutar ulang"Pencarian Kupon Emas"akan mendapatkan bonus 50% tambahan berupa Kupon Emas Rosea.]]
  },
  Activity_43574_ActivityName = {
    Text = "Estetika Alkimia"
  },
  Activity_43574_ActivityTips = {
    Text = [[
Aturan Event:
1. Selama event"Estetika Alkimia", Keeper yang menyelidiki atau memutar ulang"Pencarian Kupon Emas"akan mendapatkan bonus 50% tambahan berupa Kupon Emas Rosea.]]
  },
  Activity_44273_ActivityName = {
    Text = "Penggembala Jiwa"
  },
  Activity_44273_ActivityPlot = {
    Text = [[
Dia telah menderita untuk kalian, menanggung penderitaan kalian.
Karena Caro yang dia korbankan, kalian menerima penyembuhan;
karena Hidup yang dia berikan, kalian menerima pengampunan.]]
  },
  Activity_44273_ActivityTips = {
    Text = "<Title:Deskripsi Aktivitas>\n1. Selama periode aktivitas, Penjaga dapat mengumpulkan mata uang aktivitas \"Kupon Penjualan Amal\" melalui gameplay terbatas \"Jalan Gereja\", \"Kebaikan Warga\", dan \"Hadiah Prestasi\". \"Kupon Penjualan Amal\" dapat ditukar di \"Lokasi Bazar Amal Gereja\" untuk mendapatkan barang acak, termasuk SR Roda Takdir terbatas acara \"Pria dalam Cermin\", Inti Murni, Inti Lumen, dan lain-lain. \n2. Menyelesaikan \"Rekam Jejak Satuan Tugas: Warna Darah\" akan memberikan Kunci Baru \"Keajaiban Fajar\". Selama periode aktivitas, \"Rekam Jejak Satuan Tugas: Warna Darah\" dapat dibuka secara gratis dengan waktu terbatas, dan menyelesaikan prestasi aktivitas juga akan memberikan avatar terbatas acara \"Atas nama Kunci Perak: Salvador\"! \n\n<Title:Jalan Gereja>\n1. \"Jalan Gereja\" terdiri dari 5 tingkat, Penjaga dapat membuka satu per satu dengan menyelesaikan tingkat 2/4/6/7/9 dari \"Rekam Jejak Satuan Tugas: Warna Darah\". \n2. Setiap tingkat memiliki 7 tingkat kesulitan, dengan rekomendasi level 15~65, semua tingkat kesulitan secara default terbuka. Musuh dan peristiwa di setiap tingkat dapat berubah secara acak. \n3. Dapat menggunakan bantuan alumni dan \"Resonansi: Persimpangan Jiwa\" untuk membantu Anda menyelesaikan tingkat dengan lebih mudah. \n4. Setiap tantangan membutuhkan konsumsi 120 Menophin, semakin tinggi kesulitan, semakin banyak \"Kupon Penjualan Amal\" yang didapatkan. Selain itu, Penjaga dapat memilih tantangan ganda, mengkonsumsi 240 Menophin, untuk mendapatkan dua kali lipat \"Kupon Penjualan Amal\" dan Pengalaman Penjaga. \n\n<Title:Bonus Cahaya>\n1. Di bawah pengaruh \"Cahaya Jiwa\", Awakener \"Salvador\", SSR Roda Takdir \"Prasasti Kitab Suci\", dan SR Roda Takdir \"Pria dalam Cermin\" dapat memberikan tambahan jatuh \"Kupon Penjualan Amal\" dalam hadiah tugas tingkat \"Jalan Gereja\", dengan bonus sebagai berikut: \n(1) Cara Pertama: Penjaga memiliki Awakener atau Roda Takdir tertentu (tidak perlu diturunkan) \n· Awakener \"Salvador\": Mencerahkan 0/1/2/3 dan di atas, bonus 30%/40%/50%/60%. \n· SSR Roda Takdir \"Prasasti Kitab Suci\": Posisi Tumpuk 0/1/2/3 dan di atas, bonus 30%/40%/50%/60%. \n· SR Roda Takdir \"Pria dalam Cermin\": Posisi Tumpuk 0/1/2/3 dan di atas, bonus 15%/20%/25%/30%. \n(2) Cara Kedua: Menggunakan Awakener atau Roda Takdir tertentu sebagai bantuan \n· Awakener \"Salvador\": bonus 10%. \n· SSR Roda Takdir \"Prasasti Kitab Suci\": bonus 10%. \n· SR Roda Takdir \"Pria dalam Cermin\": bonus 5%. \n2. Untuk Awakener atau Roda Takdir yang sama, \"Bonus Cahaya\" dari kedua cara akan berlaku dengan cara yang memberikan bonus lebih tinggi, tidak dapat digabungkan. \n3. \"Bonus Cahaya\" dari Awakener atau Roda Takdir yang berbeda akan dihitung dengan cara yang dapat digabungkan, sesuai dengan aturan di atas, Penjaga dapat memperoleh maksimum 150% \"Bonus Cahaya\"! \n\n<Title:Resonansi: Persimpangan Jiwa>\n1. Penjaga dapat memperoleh \"Hati Penitensi\" dengan menyelesaikan prestasi aktivitas. \n2. Mengkonsumsi \"Hati Penitensi\" untuk mengaktifkan \"Resonansi: Persimpangan Jiwa\", dapat memperoleh bonus berikut: \n(1) Membuat Penjaga lebih kuat dalam gameplay aktivitas \"Jalan Gereja\" dan \"Rekam Jejak Satuan Tugas: Warna Darah\", membuat tantangan lebih mudah. \n(2) Meningkatkan tingkat afinitas yang diperoleh setelah menyelesaikan tantangan \"Jalan Gereja\". \n(3) Mengaktifkan gameplay aktivitas \"Kebaikan Warga\". \n\n<Title:Kebaikan Warga>\n1. Setelah mengaktifkan resonansi \"Cara Mudah\", secara otomatis mendapatkan 60 \"Kupon Penjualan Amal\" setiap jam, maksimum penyimpanan 25 jam. \n2. Setelah mengaktifkan resonansi \"Penebusan, Penebusan\", secara otomatis mendapatkan tambahan 1800 Rose Scrip setiap jam. \n\n<Title: Lokasi Bazar Amal Gereja>\n1. Penjaga dapat menggunakan \"Kupon Penjualan Amal\" untuk secara acak menukar barang di toko \"Lokasi Bazar Amal Gereja\", SR Roda Takdir terbatas acara \"Pria dalam Cermin\", Inti Lumen, dan Inti Murni menunggu Anda~ \n2. Terdapat tiga toko di lokasi Bazar Amal Gereja, dengan waktu pembukaan sebagai berikut: \n· Toko \"Toko Kecil Nyonya Grey\": Dibuka awal. \n· Toko \"Yohanes Besar dan Bazar Ajaib\": Dibuka pada hari ke-4 aktivitas. \n· Toko \"Promo Spesial Smith\": Dibuka pada hari ke-7 aktivitas. \n3. Barang di setiap toko berbeda, Penjaga dapat memilih barang sesuai kebutuhan untuk ditukar. \n4. Setiap toko mencakup barang khusus dan barang biasa, setiap kali menukar akan mengkonsumsi 600 \"Kupon Penjualan Amal\", secara acak mendapatkan lima barang dari toko. \n5. Ketika semua barang khusus di toko telah ditukar, Penjaga dapat meminta toko untuk menambah barang atau memilih untuk melanjutkan penukaran. Ketika semua barang di toko telah ditukar, Penjaga perlu memilih untuk menambah barang sebelum dapat melanjutkan penukaran. \n6. Untuk dua kali pertama penambahan barang di setiap toko, jumlah sisa semua barang di toko akan diisi kembali hingga batas maksimum, mulai dari penambahan barang ketiga, barang khusus tidak akan diisi kembali, hanya barang biasa yang akan diisi kembali. Setelah penambahan barang, jumlah sisa barang yang belum ditukarkan sebelumnya tidak akan disimpan, harap Penjaga pikirkan dengan cermat sebelum memilih untuk menambah barang~ \n\n<Title:Rekam Jejak Satuan Tugas>\n1. Selama periode aktivitas, Rekam Jejak Satuan Tugas \"Warna Darah\" dapat dibuka secara gratis. Setiap 2 hari akan diluncurkan kasus penyelidikan baru \"Warna Darah\", menyelesaikan kasus penyelidikan dapat memperoleh Kunci \"Keajaiban Fajar\", Inti Murni, Lencana Penyelidikan, dan Pengalaman Penjaga, serta hadiah penyelidikan lainnya. \n2. Setelah aktivitas berakhir, kemajuan penyelidikan \"Warna Darah\" akan disimpan, menyelesaikan kasus penyelidikan yang belum selesai selama periode aktivitas juga dapat memperoleh hadiah penyelidikan yang sama seperti selama periode aktivitas. Jika \"Warna Darah\" tidak dibuka selama periode aktivitas, setelah aktivitas berakhir, masih dapat mengkonsumsi \"Titik Awal Realitas\" ×7 untuk membuka. \n3. Selama periode aktivitas, akan diluncurkan hadiah prestasi terbatas waktu, setelah Penjaga menyelesaikan semua kasus penyelidikan \"Warna Darah\", dapat mengklaim avatar \"Atas nama Kunci Perak: Salvador\" di prestasi aktivitas! Hadiah prestasi hanya dibuka selama periode aktivitas, setelah aktivitas berakhir tidak dapat diselesaikan atau diklaim. \n\n"
  },
  Activity_44626_ActivityName = {
    Text = "Penggembala Jiwa"
  },
  Activity_44705_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_44705_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_44706_ActivityName = {
    Text = "Uskup Pengasih"
  },
  Activity_44706_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Uskup Pengasih\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Salvador untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_44716_ActivityName = {
    Text = "Tuan yang Tertidur"
  },
  Activity_44716_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Tuan yang Tertidur\" berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Thulu untuk mencoba level yang ditentukan tanpa batas.\n·Saat mencoba level aktivitas, formasi Awakened dalam tim tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan level, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_45664_ActivityName = {
    Text = "Kejatuhan Sang Raksasa"
  },
  Activity_45664_ActivityPlot = {
    Text = [[
Lautan tak berujung, terik matahari, pahlawan Filistin yang diasingkan dan satu-satunya pengikutnya.
Ini adalah kisah tentang "Pencarian".]]
  },
  Activity_45664_ActivityTips = {
    Text = "<Title:Syarat Partisipasi>\n·Dapat diikuti setelah menyelesaikan mode Normal Penyelaman Kesadaran \"Keinginan Ksatria\". \n<Title:Peristiwa Investigasi>\n·Selama periode event, Keeper tidak perlu menggunakan sumber daya untuk membuka investigasi. Setelah menyelesaikan peristiwa investigasi, kamu bisa mendapatkan hadiah investigasi seperti Inti Murni, Lencana Investigasi, dan EXP Keeper.\n·Setelah event berakhir, status pembukaan dan progres investigasi \"Kejatuhan Sang Raksasa\" akan disimpan. Menyelesaikan peristiwa investigasi yang belum selesai selama event juga akan memberikan hadiah investigasi yang sama seperti saat event berlangsung; jika belum dibuka selama event, maka setelah event berakhir dapat dibuka dengan menggunakan Titik Awal Realitas ×3.<Title:Hadiah Terbatas>\n·Selama periode event, hadiah terbatas akan tersedia. Setelah Keeper menyelesaikan mode Normal \"Kejatuhan Sang Raksasa\" dan menyelesaikan peristiwa investigasi \"Kejatuhan Sang Raksasa\", kamu bisa mendapatkan hadiah Kristal Dimensi dan Silver Core! Hadiah terbatas hanya tersedia selama periode event. Setelah event berakhir, hadiah tidak dapat diselesaikan atau diklaim."
  },
  Activity_45664_UnlockConditionExplanation = {
    Text = "Terbuka setelah menyelesaikan Penyelaman Kesadaran \"Keinginan Ksatria\""
  },
  Activity_46167_ActivityName = {
    Text = "Pasien Terbelah·Chaos"
  },
  Activity_46167_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara \"Pasien Skizofren·Kaos\" berlangsung, Penjaga dapat menggunakan susunan tim preset sistem yang mencakup \"24\", untuk menikmati tingkat yang ditentukan tanpa batas.\n·Saat menikmati tingkat acara, Awakener dalam susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Acara>\n·Setelah berhasil menyelesaikan tantangan tingkat untuk pertama kalinya, hadiah percobaan dapat diambil di antarmuka acara."
  },
  Activity_46168_ActivityName = {
    Text = "Penyihir Pemburu Tengkorak"
  },
  Activity_46168_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Penyihir Pemburu Tengkorak\" berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Daphodel untuk mencoba level yang ditentukan tanpa batas.\n·Saat mencoba level aktivitas, formasi Awakened dalam tim tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan level, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_46609_ActivityName = {
    Text = "Pemulihan Berganda"
  },
  Activity_46609_ActivityPlot = {
    Text = [[
Hysteria, juga dikenal sebagai Histeria, gejala kejiwaan.
Di zaman kalian, itu memiliki arti yang sama dengan kematian.

Untungnya, para ilmuwan dan penyelidik di Universitas mythag juga sudah gila: mereka bertekad untuk mengatasi masalah ini]]
  },
  Activity_46609_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Analisis Kepribadian\""
  },
  Activity_46609_ActivityTips = {
    Text = "<Title:Deskripsi Acara>\n1, Selama periode acara, Penjaga dapat mengumpulkan mata uang acara \"Puzzle Memori\" melalui gameplay terbatas \"Kode Memori\", \"Penyimpanan Tepi\", dan \"Hadiah Prestasi\". \"Puzzle Memori\" dapat digunakan untuk membeli barang di \"Analisis Kepribadian\", termasuk Roda Takdir SR terbatas acara \"Tekad Ikan Kod Perak\", Inti Lumen, Inti Murni, Batu Filsuf, dan bahan pelatihan yang melimpah. \n2, Menyelesaikan \"Rekam Jejak Satuan Tugas: Fisi Damai\" dapat memperoleh Kunci baru \"Semua Tentang 'Dia'\". Selama periode acara, \"Rekam Jejak Satuan Tugas: Fisi Damai\" dapat dibuka secara gratis untuk waktu terbatas, dan menyelesaikan prestasi acara juga akan memberikan avatar terbatas acara \"Atas nama Kunci Perak:\"24\"\"!\n\n<Title:Waktu Acara>\n1, 27 April 9:00 - 18 Mei 9:00 (GMT+8), semua gameplay acara dapat diikuti, \"Rekam Jejak Satuan Tugas: Fisi Damai\" dapat dibuka gratis untuk waktu terbatas. \n2, 18 Mei 9:00 - 25 Mei 9:00 (GMT+8), hanya dapat mengikuti \"Analisis Kepribadian\" dan Hadiah Prestasi, \"Rekam Jejak Satuan Tugas: Fisi Damai\" perlu mengonsumsi Titik Awal Realitas×7 untuk dibuka. \n\n<Title:Kode Memori>\n1, \"Kode Memori\" terdiri dari 5 tingkat, Penjaga dapat membuka satu per satu dengan menyelesaikan tingkat 2/4/6/8/10 dari \"Rekam Jejak Satuan Tugas: Fisi Damai\". \n2, Setiap tingkat memiliki 7 kesulitan, tingkat rekomendasi adalah 15~65, semua kesulitan secara default sudah terbuka. Musuh dan kejadian di setiap tingkat dapat berubah secara acak. \n3, Dapat menggunakan bantuan Alumni dan \"Resonansi: Sindrom Pemisahan\" untuk membantu Anda melewati tingkat dengan lebih mudah. \n4, Setiap tantangan membutuhkan 120 Menophin, semakin tinggi kesulitan, semakin banyak \"Puzzle Memori\" yang didapat saat menyelesaikan, selain itu Penjaga dapat memilih tantangan ganda, menghabiskan 240 Menophin, mendapatkan dua kali \"Puzzle Memori\" dan pengalaman Penjaga. \n\n<Title:Bonus Rasional>\n1, Penjaga yang memiliki Awakener atau Roda Takdir tertentu (tidak perlu di lapangan) dapat membuat \"Puzzle Memori\" dalam imbalan tugas tingkat \"Kode Memori\" mendapatkan bonus jatuh tambahan, rincian bonus adalah sebagai berikut: \n· Awakener \"24\": Mencerahkan 0/1/2/3 dan di atas, bonus 15%/20%/25%/30%. \n· Awakener \"Daffodil\": Mencerahkan 0/1/2/3 dan di atas, bonus 15%/20%/25%/30%. \n· Roda Takdir SSR \"Restitusi Tubuh Terdistorsi\": Posisi Tumpuk 0/1/2/3 dan di atas, bonus 15%/20%/25%/30%. \n· Roda Takdir SSR \"Relik Langka\": Posisi Tumpuk 0/1/2/3 dan di atas, bonus 15%/20%/25%/30%. \n· Roda Takdir SR \"Tekad Ikan Kod Perak\": Posisi Tumpuk 0/1/2/3 dan di atas, bonus 15%/20%/25%/30%. \n2, \"Bonus Rasional\" dari Awakener atau Roda Takdir yang berbeda dihitung secara akumulatif. \n\n<Title:Resonansi: Sindrom Pemisahan>\n1, Penjaga dapat memperoleh \"Hati yang terbelah\" dengan menyelesaikan prestasi acara. \n2, Menghabiskan \"Hati yang terbelah\", mengaktifkan \"Resonansi: Sindrom Pemisahan\", dapat memperoleh bonus berikut: \n(1) Membuat Penjaga lebih kuat dalam gameplay acara \"Kode Memori\" dan \"Rekam Jejak Satuan Tugas: Fisi Damai\", tantangan menjadi lebih mudah. \n(2) Meningkatkan imbalan yang diperoleh setelah menyelesaikan tantangan \"Kode Memori\". \n(3) Mengaktifkan gameplay acara \"Penyimpanan Tepi\". \n\n<Title:Penyimpanan Tepi>\n· Setelah mengaktifkan resonansi \"Diagnosis: Skizofrenia\", secara otomatis mendapatkan 60 \"Puzzle Memori α\" setiap jam, maksimum dapat disimpan selama 25 jam. \n\n<Title:Rekam Jejak Satuan Tugas>\n1, Selama periode acara, \"Rekam Jejak Satuan Tugas: Fisi Damai\" dapat dibuka gratis. Setiap 2 hari akan diluncurkan kejadian investigasi baru \"Fisi Damai\", setelah menyelesaikan kejadian investigasi dapat memperoleh Kunci \"Semua Tentang 'Dia'\", Inti Murni, Lencana Penyelidikan, dan pengalaman Penjaga serta imbalan investigasi lainnya. \n2, Setelah acara berakhir, progres investigasi \"Rekam Jejak Satuan Tugas: Fisi Damai\" akan disimpan, menyelesaikan kejadian investigasi yang belum diselesaikan selama periode acara juga dapat memperoleh imbalan investigasi yang sama dengan periode acara. Jika selama periode acara \"Rekam Jejak Satuan Tugas: Fisi Damai\" tidak dibuka, setelah acara berakhir masih dapat menghabiskan \"Titik Awal Realitas\"×7 untuk membukanya. \n3, Selama periode acara, akan diluncurkan hadiah prestasi terbatas waktu, setelah Penjaga menyelesaikan semua kejadian investigasi \"Rekam Jejak Satuan Tugas: Fisi Damai\", dapat mengambil avatar \"Atas nama Kunci Perak:\"24\"\" di prestasi acara! Hadiah prestasi hanya dibuka selama periode acara, setelah acara berakhir tidak dapat diselesaikan dan diambil. \n\n\n"
  },
  Activity_46609_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_47534_ActivityName = {Text = "Fisi Damai"},
  Activity_48136_ActivityName = {
    Text = "Pasien Terbelah·Laut Dalam"
  },
  Activity_48136_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara \"Pasien Skizofren·Laut Dalam\" berlangsung, Penjaga dapat menggunakan susunan tim preset sistem yang mencakup \"24\", untuk menikmati tingkat yang ditentukan tanpa batas.\n·Saat menikmati tingkat acara, Awakener dalam susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Acara>\n·Setelah berhasil menyelesaikan tantangan tingkat untuk pertama kalinya, hadiah percobaan dapat diambil di antarmuka acara."
  },
  Activity_48137_ActivityName = {
    Text = "Pasien Terbelah·Daging Darah"
  },
  Activity_48137_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara \"Pasien skizofren · Caro\" berlangsung, Penjaga dapat menggunakan susunan tim preset sistem yang mencakup \"24\", untuk menikmati tingkat yang ditentukan tanpa batas.\n·Saat menikmati tingkat acara, Awakener dalam susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Acara>\n·Setelah berhasil menyelesaikan tantangan tingkat untuk pertama kalinya, hadiah percobaan dapat diambil di antarmuka acara."
  },
  Activity_48138_ActivityName = {
    Text = "Pasien Terbelah·Hyperdimensi"
  },
  Activity_48138_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara \"Pasien Skizofren·Ultra\" berlangsung, Penjaga dapat menggunakan susunan tim preset sistem yang mencakup \"24\", untuk menikmati tingkat yang ditentukan tanpa batas.\n·Saat menikmati tingkat acara, Awakener dalam susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Acara>\n·Setelah berhasil menyelesaikan tantangan tingkat untuk pertama kalinya, hadiah percobaan dapat diambil di antarmuka acara."
  },
  Activity_48719_ActivityName = {
    Text = "Gelombang Laut Nafsu"
  },
  Activity_48719_ActivityPlot = {
    Text = "Mimpi adalah pengungkapan keinginan bawah sadar. Mereka yang mengembara dalam mimpi pada akhirnya akan ditangkap oleh lautan keinginan, menjadi pelayan nafsu, kecuali..."
  },
  Activity_48719_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Pertumbuhan Nafsu\""
  },
  Activity_48719_ActivityTips = {
    Text = "<Title:Ringkasan Aktivitas>\n1, Selama periode kegiatan, Penjaga dapat mengumpulkan mata uang kegiatan \"Benih ibu\" melalui gameplay terbatas \"Hasrat kacau\" dan \"Hadiah Prestasi\". \"Benih ibu\" dapat ditukarkan dalam \"Nafsu yang terlarang\" untuk mendapatkan hadiah, termasuk Inti Lumen, Inti murni, dan bahan pengembangan yang melimpah. \n2, Selama periode kegiatan, Penjaga hanya perlu menyelesaikan \"Operasi\" 2-9·Normal untuk dapat berpartisipasi dalam \"Frenesi Pembiakan\", dan tidak perlu memenuhi persyaratan tingkat afinitas Awakener untuk membuka \"Insiden Frenesi Pembiakan\". Selain itu, jumlah \"Titik awal realitas\" yang digunakan juga hanya perlu 1! \n3, Kedatangan kekuatan misterius tampaknya membantu Anda membangun hubungan yang lebih dalam dengan Awakener, selama periode kegiatan, tingkat afinitas yang didapat melalui semua cara akan menjadi dua kali lipat! \n\n<Title:Waktu Kegiatan>\n1, 18 Mei pukul 9:00 - 3 Juni pukul 9:00 (GMT+8), semua konten dalam ringkasan kegiatan dapat diikuti. \n2, 3 Juni pukul 9:00 - 10 Juni pukul 9:00 (GMT+8), hanya \"Nafsu yang terlarang\" dan \"Hadiah Prestasi\" yang tetap ada, konten lainnya telah berakhir dan tidak dapat diikuti. \n\n<Title:Hasrat kacau>\n1, \"Hasrat kacau\" terdiri dari 10 level bahan yang dapat diakses langsung tanpa eksplorasi, satu level dibuka setiap hari. \n2, Dalam level-level bahan ini, Anda akan langsung membangkitkan semua Awakener dan mendapatkan Relic yang sudah ditentukan, selain itu setelah 6 putaran, Anda akan mendapatkan bantuan dari Thais sekali. \n3, Setiap tantangan akan menghabiskan 60 poin Menophin, setelah menyelesaikan level bahan dalam kegiatan ini, Anda dapat mendukung reproduksi. \n4, Anda dapat menggunakan bantuan alumni untuk membantu Anda menyelesaikan dengan lebih mudah. \n\n<Title:Bonus Serakah>\n1, Penjaga yang memiliki Awakener atau Roda takdir tertentu (tidak perlu dalam formasi) dapat memberikan tambahan hasil jatuh \"Benih ibu\" dalam tugas level \"Hasrat kacau\" (termasuk reproduksi), rincian bonus adalah sebagai berikut: \n· Awakener \"Thais\": Mencerahkan 0/1/2/3 dan lebih, bonus 20%/30%/40%/50% \n· Roda takdir SSR \"Kasih Sayangnya\": Posisi Tumpuk 0/1/2/3 dan lebih, bonus 20%/30%/40%/50% \n· Roda takdir SR \"Ciuman Perpisahan yang Membara\": Posisi Tumpuk 0/1/2/3 dan lebih, bonus 20%/30%/40%/50% \n2, Bonus Serakah dari berbagai Awakener atau Roda takdir dihitung dengan cara yang dapat ditumpuk. \n\n<Title:Frenesi Pembiakan>\n1, Setelah menyelesaikan \"Operasi\" 7-3·Normal, konten penyelidikan khusus yang baru \"Frenesi Pembiakan\" dibuka! \n2, Dengan kedatangan kegiatan \"Gelombang Laut Nafsu\", para Awakener terpengaruh oleh kekuatan misterius dan jatuh ke dalam kondisi \"Frenesi Pembiakan\"… Harap berhati-hati, para Penjaga! \n3, Ketika tingkat afinitas Awakener mencapai level 10, Anda dapat membuka \"Insiden Frenesi Pembiakan\" untuk Awakener tersebut, dengan menghabiskan \"Titik awal realitas\" ×7 untuk membuka, setelah menyelesaikannya, Anda dapat memperoleh \"Inti murni\" ×1! \n4, Selama periode kegiatan \"Gelombang Laut Nafsu\" (sebelum 3 Juni pukul 9:00), syarat partisipasi dilonggarkan menjadi menyelesaikan \"Operasi\" 2-9·Normal, dan Awakener tidak perlu memenuhi persyaratan tingkat afinitas untuk membuka \"Insiden Frenesi Pembiakan\", selain itu jumlah \"Titik awal realitas\" yang digunakan juga hanya perlu 1! \n\n<Title:Tingkat Afinitas Dua Kali Lipat>\n1, Kedatangan kekuatan misterius tampaknya membantu Anda membangun hubungan yang lebih dalam dengan Awakener, selama periode kegiatan, tingkat afinitas yang didapat melalui semua cara akan menjadi dua kali lipat! \n2, Hadiah dari bonus tingkat afinitas lainnya akan dihitung dengan cara perkalian, seperti menggunakan bantuan bonus tingkat afinitas. \n<Title:Hadiah Prestasi>\n1, Menyelesaikan semua tugas dapat memperoleh hadiah: Perak ×800, banyak \"Benih ibu\", Roda takdir SR terbatas kegiatan \"Ciuman Perpisahan yang Membara\" ×16, dan avatar terbatas kegiatan \"Atas nama Kunci Perak: Thais\". \n2, Terdapat 16 tugas: Menyelesaikan setiap level \"Hasrat kacau\" 1 kali, melakukan reproduksi kumulatif 10/20/30/40/50 kali dalam \"Hasrat kacau\", dan menyelesaikan semua prestasi kegiatan. \n\n\n\n"
  },
  Activity_48719_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_48825_ActivityName = {
    Text = "Hadiah dari Kucing Sekolah"
  },
  Activity_48825_ActivityPlot = {
    Text = "Penjaga Rahasia dapat memilih 1 dari Kebangkitan limited berikut untuk dibangkitkan!"
  },
  Activity_48825_ActivityTips = {
    Text = "<Title:Pengantar>\nJika bukan karena pengawasan penuh semangat dari kalian semua, Mythag mungkin akan selamanya terkubur dalam malam yang panjang. Kini, kami telah menepati janji, melewati berbagai rintangan, dan tiba di momen peringatan setengah tahun. Untuk itu, Kucing sekolah akan mempersembahkan hadiah istimewa untukmu, sebagai ungkapan terima kasih atas kebersamaan kalian selama ini.\n\n<Title:Aturan Acara>\n·Selama acara berlangsung, setiap Penjaga dapat memilih 1 dari 8 Awakener SSR Terbatas untuk di-Awaken, termasuk Tulu, Daffodil, Sorel, Lily, Murphy, Wanda, Salvador,\"24\".\n·Ketika Penjaga memilih Awakener yang sudah di-Awaken, akan dikonversi menjadi Serpihan Awakener yang sesuai ×1 dan Sedimen akar ×50; jika Enlighten Level Awakener yang sesuai sudah penuh, akan dikonversi menjadi \"Fragmen gnosis\" × 1 dan \"Sedimen akar\" × 150."
  },
  Activity_48825_BannerText = {
    Text = "Klaim Kebangkitan Limited Gratis"
  },
  Activity_48826_ActivityName = {
    Text = "Senja dan Fajar"
  },
  Activity_48826_ActivityPlot = {
    Text = "Login harian untuk mengklaim Roda Takdir SSR Peringatan Limited\"Malam Kutub & Fajar\", total dapat diklaim 16 buah!"
  },
  Activity_48826_ActivityTips = {
    Text = "<Title:Deskripsi>\nIni adalah puisi yang dipersembahkan untuk para pemain, tentang cita-cita, tentang keyakinan, tentang waktu yang kita lalui bersama. Semoga hati yang tulus tak pernah berhenti berdetak, semoga Kunci Perak menuntun langkah ke depan.\n\n<Title:Aturan Event>\n·Selama periode event, setelah login setiap hari, Penjaga Rahasia dapat mengklaim Roda Takdir SSR Peringatan Limited\"Malam Kutub & Fajar\"di\"Malam Kutub & Fajar\", total dapat diklaim 16 kali.\n·Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia. Hadiah login harian akan direset pada pukul 9 (GMT+8)."
  },
  Activity_48826_BannerText = {
    Text = "Klaim Fate Wheel SSR Terbatas Gratis"
  },
  Activity_48827_ActivityName = {
    Text = "Silver Core dalam Topi"
  },
  Activity_48827_ActivityPlot = {
    Text = "Menurut statistik yang belum lengkap, selama setengah tahun ini, topi Kucing Sekolah telah ditepuk oleh para siswa ribuan kali, banyak Silver Core kecil yang tidak mencolok jatuh ke tanah namun tidak ada yang mengambilnya. Petugas kebersihan sekolah sangat terganggu oleh hal ini. Kini sekolah telah mengumpulkan Silver Core tersebut, membersihkannya sepenuhnya, dan menyimpannya di bagian barang hilang. Pemiliknya dipersilakan segera datang untuk mengklaimnya."
  },
  Activity_48827_ActivityTips = {
    Text = "<Title:Deskripsi>\nMenurut statistik yang belum lengkap, selama setengah tahun ini, topi Kucing Sekolah telah ditepuk oleh para siswa ribuan kali, banyak Silver Core kecil yang tidak mencolok jatuh ke tanah namun tidak ada yang mengambilnya. Petugas kebersihan sekolah sangat terganggu oleh hal ini. Kini sekolah telah mengumpulkan Silver Core tersebut, membersihkannya sepenuhnya, dan menyimpannya di bagian barang hilang. Pemiliknya dipersilakan datang untuk mengklaimnya.\n\n<Title:Aturan Event>\n·Selama periode event, setelah login setiap hari, Penjaga Rahasia dapat mengklaim\"Silver Core\"×1000 di\"Silver Core dalam Topi\", maksimal 5 kali.\n·Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia. Hadiah login harian akan direset pada pukul 9 (GMT+8)."
  },
  Activity_48827_BannerText = {
    Text = "Check-in untuk Klaim Silver Core Berlimpah"
  },
  Activity_48849_ActivityName = {
    Text = "Rasul Lautan"
  },
  Activity_48849_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Rasul Lautan\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Miriam untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_48850_ActivityName = {
    Text = "Napas Kemakmuran"
  },
  Activity_48850_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Napas Kemakmuran\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Taiyi Si untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_48851_ActivityName = {
    Text = "Wanita Aequor"
  },
  Activity_48851_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Deep Sea Lady\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Murphy untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_48852_ActivityName = {Text = "Ratu Duri"},
  Activity_48852_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Ratu Duri\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Wanda untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_48853_ActivityName = {
    Text = "Puisi Tanpa Nama"
  },
  Activity_48853_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Puisi Tanpa Nama\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Aurla untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_48854_ActivityName = {
    Text = "Detektif Beruntung"
  },
  Activity_48854_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Detektif Beruntung\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Lake untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_48855_ActivityName = {
    Text = "Bunga dari Lumpur"
  },
  Activity_48855_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Bunga dari Lumpur\" berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Lily untuk mencoba level yang ditentukan tanpa batas.\n·Saat mencoba level aktivitas, formasi Awakened dalam tim tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan level, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_48856_ActivityName = {
    Text = "Nyonya Merah"
  },
  Activity_48856_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Nyonya Merah\" berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Soreil untuk mencoba level yang ditentukan tanpa batas.\n·Saat mencoba level aktivitas, formasi Awakened dalam tim tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan level, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_49249_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_49249_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_49405_ActivityName = {
    Text = "Promo Pembukaan Acara Pengakuan Cinta"
  },
  Activity_49406_ActivityName = {
    Text = "Aktivitas penggandaan afinitas"
  },
  Activity_51127_ActivityName = {
    Text = "Cerita sihir·copy cahaya"
  },
  Activity_51127_ActivityPlot = {
    Text = [[
Tugas yang diberikan oleh Boneka tidak pernah sederhana. 
Meskipun dia beberapa kali mengingatkan semua orang "untuk bersenang-senang", bagaimana mungkin Penjaga tidak merasa cemas saat pertama kalinya membawa sekelompok Pembangun keluar? 
Namun, ingatlah "untuk bersenang-senang" ya.]]
  },
  Activity_51127_ActivityStageEndContent = {
    Text = "Event telah berakhir, saat ini hanya dapat mengikuti \"Toko Naskah Sihir\""
  },
  Activity_51127_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1. Rerun gameplay aktivitas \"Sihir Cerita\" dibuka untuk waktu terbatas. Keeper dapat kembali mendapatkan Roda Takdir edisi aktivitas terbatas \"Sihir 35mm\" dan avatar edisi aktivitas terbatas \"Atas Nama Kunci Perak: Lily\" melalui \"Toko Naskah Sihir\" dan \"Hadiah Pencapaian\"!\n2. Selama periode aktivitas, \"Catatan Misi Khusus: Sihir Cerita\" akan dibuka secara gratis untuk waktu terbatas.\n\n<Title:Waktu Aktivitas>\n1. 3 Juni pukul 9:00 - 17 Juni pukul 9:00 (GMT+8), semua konten dalam pengenalan aktivitas dapat diikuti.\n2. 17 Juni pukul 9:00 - 24 Juni pukul 9:00 (GMT+8), hanya \"Toko Naskah Sihir\" dan \"Hadiah Pencapaian\" yang tersedia, konten lainnya sudah berakhir dan tidak dapat diikuti.\n\n<Title:Misteri Naskah>\n1. \"Misteri Naskah\" berisi 9 stage material, 1 stage dibuka otomatis setiap hari. Setelah dibuka, stage Catatan Misi Khusus prasyarat harus diselesaikan terlebih dahulu sebelum dapat ditantang.\n2. Setiap tantangan akan mengonsumsi 60 poin Spiritein, tantangan berhasil akan memberikan mata uang aktivitas \"Inspirasi Melayang\" dan material pengembangan; stage material aktivitas kali ini mendukung Replay setelah diselesaikan.\n3. Keeper dapat menggunakan bantuan tempur Alumni dan \"Resonansi: Kode Sutradara\" untuk membantumu menyelesaikan stage dengan lebih mudah.\n\n<Title:Bonus Inspirasi>\n1. Keeper yang memiliki Awakened Body atau Roda Takdir tertentu (tidak harus ditempatkan di tim) dapat memperoleh bonus drop tambahan untuk \"Inspirasi Melayang\" dari hadiah misi stage \"Misteri Naskah\" (termasuk Replay), bonus spesifik sebagai berikut:\n·Awakened Body \"Lily\": Awakening 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Melampaui Rasa Sakit\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Sihir 35mm\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Inspirasi\" dari Awakened Body atau Roda Takdir yang berbeda dihitung secara kumulatif.\n\n<Title:Resonansi: Kode Sutradara>\n1. Keeper dapat memperoleh \"Hati Pementasan\" dengan menyelesaikan pencapaian aktivitas.\n2. Mengonsumsi \"Hati Pementasan\" untuk mengaktifkan \"Resonansi: Kode Sutradara\" dapat membuat Keeper menjadi lebih kuat dalam gameplay aktivitas \"Misteri Naskah\" dan \"Catatan Misi Khusus: Sihir Cerita\", serta meningkatkan \"Inspirasi Melayang\" dan hadiah Sync Rate yang diperoleh setelah menyelesaikan tantangan \"Misteri Naskah\".\n\n<Title:Hadiah Pencapaian>\n1. Menyelesaikan misi pencapaian dapat memberikan avatar edisi aktivitas terbatas \"Atas Nama Kunci Perak: Lily\", mata uang aktivitas \"Inspirasi Melayang\", Inti Perak.\n2. Berisi 25 misi: Selesaikan setiap stage \"Misteri Naskah\" 1 kali, selesaikan \"Misteri Naskah\" 1/2 kali menggunakan tim dari setiap Domain, selesaikan setiap event investigasi \"Catatan Misi Khusus: Sihir Cerita\" 1 kali, selesaikan semua pencapaian aktivitas.\n\n<Title:Catatan Misi Khusus>\n1. Selama periode aktivitas, \"Catatan Misi Khusus: Sihir Cerita\" dapat dibuka secara gratis.\n2. Dalam \"Catatan Misi Khusus: Sihir Cerita\", Keeper akan menggunakan formasi khusus yang berisi preset cerita \"Lily\" untuk menantang.\n\n<Title:Kompensasi Rerun>\n1. Keeper yang sebelumnya sudah membuka \"Catatan Misi Khusus: Sihir Cerita\" akan menerima kompensasi \"Inspirasi Melayang\" ×1000 saat membuka kembali selama periode rerun aktivitas ini.\nKeeper yang sebelumnya sudah mendapatkan avatar edisi aktivitas terbatas \"Atas Nama Kunci Perak: Lily\", saat mendapatkannya kembali akan otomatis dikonversi menjadi \"Inspirasi Melayang\" ×3000.\nKeeper yang sebelumnya sudah mendapatkan material aktivasi resonansi \"Hati Pementasan\", setiap 1 \"Hati Pementasan\" berlebih yang didapat akan otomatis dikonversi menjadi \"Voucher Emas Mawar\" ×5000.\n"
  },
  Activity_51127_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_51611_ActivityName = {
    Text = "Magis cerita"
  },
  Activity_51611_ActivityTips = {
    Text = "<Title:Syarat Partisipasi>\n·Selesaikan \"Operasi\"2-9·Normal untuk berpartisipasi.\n<Title:Acara Penyelidikan>\n·Selama acara berlangsung, setiap hari akan ada acara penyelidikan baru di \"Cerita Ajaib\". Penjaga tidak perlu menghabiskan inventaris untuk membuka kunci dan melakukan penyelidikan. Setelah menyelesaikan acara penyelidikan, Penjaga dapat memperoleh inti murni, lencana penyelidikan, dan pengalaman penjaga sebagai hadiah penyelidikan.\n·Setelah acara berakhir, kemajuan penyelidikan di \"Cerita Ajaib\"akan tetap tersimpan. Penjaga dapat menggunakan D-permata di catatan misi khusus untuk membuka kunci penyelidikan yang belum dibuka. Menyelesaikan acara penyelidikan yang belum selesai selama acara juga akan memberikan hadiah penyelidikan yang sama seperti selama acara.<Title:Hadiah Terbatas Waktu>\n·Selama acara berlangsung, hadiah terbatas waktu akan diluncurkan. Penjaga yang menyelesaikan mode Normal \"Cerita Ajaib\"dan menyelesaikan acara penyelidikan \"Cerita Ajaib\"dapat memperoleh inti murni, batu filsuf, dan hadiah perak! Hadiah terbatas waktu hanya tersedia selama acara, dan setelah acara berakhir, hadiah tidak dapat diselesaikan atau diklaim."
  },
  Activity_51888_ActivityName = {Text = "Profanasi"},
  Activity_51905_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_51905_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_52040_ActivityName = {
    Text = "Pengorbanan jurang"
  },
  Activity_52040_ActivityPlot = {
    Text = [[
Di atas bayangan Aequor, mimpi sang Raja memudar, dan kerajaan dewa telah mengalami pembusukan. 
Dia datang dari ilusi hari-hari lampau, melangkah ke reruntuhan masa depan yang runtuh. 
Dia bertanya kepada Jurang, namun Jurang tetap bungkam. 
Dia memberikan persembahan kepada Jurang, dan yang menjawabnya hanyalah dirinya sendiri.]]
  },
  Activity_52040_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Tanggapan dari Jurang yang Dalam\""
  },
  Activity_52040_ActivityTips = {
    Text = "<Title:Deskripsi Aktivitas>\n1, Selama periode aktivitas, Penjaga dapat mengumpulkan mata uang aktivitas melalui gameplay terbatas \"Kelahiran Ranah Dewa\".\"Perintah Raja\", dan \"Hadiah Prestasi\". Mata uang aktivitas dapat digunakan dalam \"Respons dari Abyss\" untuk mempersembahkan demi mendapatkan hadiah item, termasuk Roda takdir SR terbatas acara \"Panggilan Aequor\".Batu filsuf, Inti murni, Inti Lumen, dan lainnya. \n2, Selama periode aktivitas, \"Lanskap mimpi: Profanasi\" akan dibuka secara gratis. \n\n<Title:Waktu Aktivitas>\n1, 17 Juni 9:00 - 1 Juli 9:00 (GMT+8), semua konten aktivitas dapat diikuti. \n2, 1 Juli 9:00 - 8 Juli 9:00 (GMT+8), hanya \"Respons dari Abyss\" dan \"Hadiah Prestasi\" yang akan tetap tersedia, konten lainnya telah berakhir dan tidak dapat diikuti. \n\n<Title: Kelahiran Ranah Dewa>\n1, \"Kelahiran Ranah Dewa\" terdiri dari 5 tingkat, yang akan dibuka secara otomatis setiap 2 hari. \n2, Setiap tantangan akan menghabiskan \"Menophin\"× 120, dan sukses dalam tantangan akan mendapatkan mata uang aktivitas \"Air mata pengorbanan\".\"Darah pengorbanan\", dan \"Sum-sum pengorbanan\". Pada tantangan ganda, akan memerlukan 240 Menophin, imbalan tugas tingkat juga akan berlipat ganda, tetapi imbalan afinitas tetap sama. \n3, Setelah tingkat \"Hadiah Prestasi\" mencapai 100%, fungsi \"Reproduksi\" untuk tingkat yang telah diselesaikan akan dibuka. Setiap \"Reproduksi\" akan menghabiskan \"Menophin\"× 120. Harap dicatat: saat menggunakan fungsi \"Reproduksi\", tidak akan mendapatkan afinitas. \n4, Dapat menggunakan bantuan alumni dan \"Resonansi: Ritual Ombak\" untuk membantu Anda lebih mudah menyelesaikan tingkat. \n\n<Title:Bonus Pemujaan>\n1, Penjaga yang memiliki tubuh bangkit tertentu atau roda takdir (tidak perlu diturunkan) dapat memberikan tambahan jatuh untuk \"Air mata pengorbanan\", \"Darah pengorbanan\", dan \"Sum-sum pengorbanan\" dalam imbalan tugas tingkat \"Kelahiran Ranah Dewa\" (termasuk Reproduksi), rincian tambahannya adalah sebagai berikut: \n·Tubuh bangkit \"Miryam\": Mencerahkan 0/1/2/3 dan lebih, tambahan 20%/30%/40%/50% \n·Roda takdir SSR \"Kekuatan dari yang saleh\": Posisi Tumpuk 0/1/2/3 dan lebih, tambahan 20%/30%/40%/50% \n·Roda takdir SR \"Panggilan Aequor\": Posisi Tumpuk 0/1/2/3 dan lebih, tambahan 20%/30%/40%/50% \n2, Bonus Pemujaan dari tubuh bangkit atau roda takdir yang berbeda akan dihitung dengan cara yang terakumulasi. \n\n<Title:Resonansi: Ritual Ombak>\n1, Penjaga dapat memperoleh \"Hati yang Beriman\" dengan menyelesaikan prestasi aktivitas. \n2, Menghabiskan \"Hati yang Beriman\", mengaktifkan \"Resonansi: Ritual Ombak\", dapat memperoleh tambahan berikut: \n(1) Membuat Penjaga lebih kuat dalam gameplay aktivitas \"Kelahiran Ranah Dewa\", tantangan menjadi lebih mudah. \n(2) Meningkatkan mata uang aktivitas yang diperoleh setelah menyelesaikan tantangan \"Kelahiran Ranah Dewa\". \n(3) Mengaktifkan gameplay aktivitas \"Perintah Raja\". \n\n<Title: Perintah Raja>\n· Setelah mengaktifkan Resonansi \"Ujian Pengorbanan\", secara otomatis mendapatkan 60 \"Air mata pengorbanan\" setiap jam, maksimum simpan 25 jam. \n\n<Title:Respons dari Abyss>\n1, \"Respons dari Abyss\" memiliki tiga altar, waktu pembukaannya adalah sebagai berikut: \n·\"Altar Air Mata Bercahaya\": Dibuka pada 17 Juni 9:00. \n·\"Altar Darah Gorila\": Dibuka pada 19 Juni 9:00. \n·\"Altar Jiwa\": Dibuka pada 21 Juni 9:00. \n2, Setiap kali mempersembahkan korban akan menghabiskan 500 \"Air mata pengorbanan\"/\"Darah pengorbanan\"/\"Sum-sum pengorbanan\", dan secara acak mendapatkan lima hadiah item dari altar. \n3, Hadiah item dari setiap altar dibagi menjadi dua jenis, yaitu \"Anugerah dari Ranah Dewa\" dan \"Hadiah Biasa\", saat reset dapat mengatur ulang jumlah sisa hadiah item tertentu ke batas maksimum, aturan spesifik adalah: \n(1) Dua reset pertama: Ketika \"Anugerah dari Ranah Dewa\" tidak memiliki jumlah sisa, Penjaga dapat memilih untuk mereset, setelah reset akan mengatur ulang jumlah sisa \"Anugerah dari Ranah Dewa\" dan \"Hadiah Biasa\" ke batas maksimum; juga dapat memilih untuk melanjutkan mempersembahkan korban, ketika \"Hadiah Biasa\" juga tidak memiliki jumlah sisa, harus melakukan reset untuk melanjutkan mempersembahkan korban. \n(2) Reset mulai dari yang ketiga: Setelah \"Hadiah Biasa\" tidak memiliki jumlah sisa baru dapat dilakukan reset, reset akan mengatur ulang jumlah sisa dari \"Hadiah Biasa\" ke batas maksimum, \"Anugerah dari Ranah Dewa\" tidak akan direset. \n\n<Title:Lanskap mimpi>\n1, \"Lanskap mimpi\" adalah jenis penyelidikan baru, dibandingkan dengan bentuk narasi alur cerita biasa, \"Lanskap mimpi\" akan lebih menekankan pada penyampaian teks, dengan konten teks yang lebih banyak. \n2, Dalam \"Lanskap mimpi: Profanasi\", Anda akan melalui tautan dengan jiwa Miryam, membaca langsung ingatannya, sehingga menyaksikan: Miryam yang masih anak-anak mengalami penderitaan Lemuria langkah demi langkah, bingung dalam keyakinan, berjuang dalam keyakinan, akhirnya berjalan di jalan menjadi penyelamat dan penghancur... \n3, Selama periode aktivitas \"Lanskap mimpi: Profanasi\" akan dibuka secara gratis. Setiap dua hari akan diluncurkan peristiwa baru, setelah menyelesaikan \"Lanskap mimpi: Profanasi\", Anda dapat memperoleh Perak, Roda takdir SR terbatas acara \"Panggilan Aequor\" dalam hadiah prestasi, hadiah prestasi hanya dibuka selama periode aktivitas, setelah aktivitas berakhir tidak dapat diselesaikan dan diterima. \n4, Setelah aktivitas berakhir, kemajuan penyelidikan \"Lanskap mimpi: Profanasi\" akan disimpan, jika \"Lanskap mimpi: Profanasi\" tidak dibuka selama periode aktivitas, setelah aktivitas berakhir masih dapat menghabiskan \"Titik awal realitas\"×7 untuk membuka kunci. \n5, Baik selama periode aktivitas maupun tidak, setelah menyelesaikan \"Lanskap mimpi: Profanasi\" dapat memperoleh \"Posse: Festival Ombak\". \n\n\n\n"
  },
  Activity_52040_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_53727_ActivityName = {
    Text = "Hari Kembali ke Sekolah"
  },
  Activity_53727_ActivityTips = {
    Text = "<Title:Pengantar Aktivitas>\n·Misi\"Hari Kembali ke Sekolah\"dibagi menjadi 4 grup, masing-masing dibuka pada hari ke-1, 2, 3, dan 4 setelah aktivitas dimulai.\n·Penjaga Rahasia dapat memperoleh\"Undangan Kembali ke Sekolah\"dengan menyelesaikan misi\"Hari Kembali ke Sekolah\".\n·Gunakan\"Undangan Kembali ke Sekolah\"untuk menukarkan hadiah menarik di\"Toko Kembali ke Sekolah\"."
  },
  Activity_53728_ActivityName = {
    Text = "Bantuan Perjalanan Baru"
  },
  Activity_53728_ActivityTips = {
    Text = "<Title:Pengantar Aktivitas>\n·Selama periode aktivitas\"Bantuan Perjalanan Baru\", setelah Penjaga Rahasia menyelesaikan\"Pemurnian Reagen\"\"Bayangan Keruh\"\"Bayangan Kedalaman Laut\"\"Bayangan Organik\"\"Bayangan Dimensi\"\"Kluster Kekacauan\"\"Reruntuhan Pohnpei\"\"Sarang Cacing\"\"Tenggorokan Schwarzschild\", hadiah\"Kupon Emas Mawar\"dan material akan digandakan, dengan total 6 kali per hari.\n·Jumlah hadiah ganda yang tidak digunakan pada hari itu akan dihapus pada pukul 9:00 (GMT+8) keesokan harinya. Jangan lupa untuk menggunakannya tepat waktu, Penjaga Rahasia~"
  },
  Activity_53729_ActivityName = {
    Text = "Kembali ke Sekolah"
  },
  Activity_53729_ActivityTips = {
    Text = "<Title:Pengantar Aktivitas>\n·Penjaga Rahasia dapat mengklaim hadiah check-in harian di\"Kembali ke Sekolah\"setelah login setiap hari.\n·Hadiah akan dibuka secara berurutan berdasarkan total hari login Penjaga Rahasia. Hadiah check-in harian akan di-refresh pada pukul 9:00 (GMT+8)."
  },
  Activity_53829_ActivityName = {
    Text = "Dengan buku mawar"
  },
  Activity_53829_ActivityPlot = {
    Text = "Berlian emas yang mewah, kilauan mutiara yang menyilaukan…\nHiasan kemewahan yang tak terhitung telah memberinya khayalan layaknya seorang permaisuri.\nKini, ia bertekad mempertahankan khayalan itu untuk selamanya."
  },
  Activity_53829_ActivityStageEndContent = {
    Text = "Event telah berakhir, saat ini hanya dapat mengikuti \"Perayaan Emas Merah\""
  },
  Activity_53829_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1. Selama periode aktivitas, Keeper dapat mengumpulkan mata uang aktivitas \"Kipas Bulu Burung Roh\" melalui gameplay terbatas \"Kenangan Rosea\" dan \"Hadiah Pencapaian\". \"Kipas Bulu Burung Roh\" dapat ditukarkan dengan hadiah melimpah di \"Festival Emas Merah\", termasuk Roda Takdir SR eksklusif aktivitas \"Mata Sejuta Kasih\", \"Inti Murni\", \"Inti Lumen\", \"Serpihan Batu Bijak\", \"Kristal Mimesis\", dll.\n2. Selama periode aktivitas, menyelesaikan misi \"Hadiah Pencapaian\" dapat memperoleh avatar eksklusif aktivitas \"Atas Nama Silver Key: Soleil\", Roda Takdir SR eksklusif aktivitas \"Mata Sejuta Kasih\", Silver Core, dan banyak mata uang aktivitas \"Kipas Bulu Burung Roh\".\n3. Selama periode aktivitas, \"Catatan Ekspedisi: Pujian Rosea\" akan dibuka secara gratis.\n\n<Title:Waktu Aktivitas>\n1. 1 Juli 9:00 - 15 Juli 9:00 (GMT+8), semua konten aktivitas dapat diikuti.\n2. 15 Juli 9:00 - 22 Juli 9:00 (GMT+8), hanya \"Festival Emas Merah\" dan \"Hadiah Pencapaian\" yang dipertahankan, konten lainnya telah berakhir dan tidak dapat diikuti.\n\n<Title: Kenangan Rosea>\n1. \"Kenangan Rosea\" berisi 9 stage, setiap hari otomatis membuka 1 stage.\n2. Setiap tantangan akan mengonsumsi \"Endorfin\" × 120, menantang stage yang berbeda selain memperoleh drop material yang berbeda, juga akan memperoleh mata uang aktivitas \"Kipas Bulu Burung Roh\".\n3. Stage aktivitas kali ini adalah stage material pertarungan langsung, setelah diselesaikan dapat di-replay! Setiap \"Replay\" mengonsumsi \"Endorfin\" × 120.\n4. Perhatian: Saat menggunakan fitur \"Replay\", Tingkat Sinkronisasi tidak dapat diperoleh.\n\n<Title: Bonus Kipas Bulu>\n1. Keeper yang memiliki Awakened atau Roda Takdir tertentu (tidak harus ditempatkan di tim) dapat membuat \"Kipas Bulu Burung Roh\" dari hadiah misi stage \"Kenangan Rosea\" mendapatkan bonus drop tambahan (termasuk replay), detail bonus sebagai berikut:\n·Awakened \"Soleil\": Awakening 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Atas Nama Rosea\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Mata Sejuta Kasih\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Kipas Bulu\" dari Awakened atau Roda Takdir yang berbeda dihitung secara akumulatif.\n\n<Title:Catatan Ekspedisi>\n1. Selama periode aktivitas, Keeper yang sebelumnya telah membuka \"Catatan Ekspedisi: Pujian Rosea\" akan memperoleh kompensasi \"Kipas Bulu Burung Roh\" × 600 saat membuka ulang.\n2. Di \"Catatan Ekspedisi: Pujian Rosea\", Keeper akan menggunakan formasi khusus yang berisi preset cerita \"Soleil\" untuk menantang."
  },
  Activity_53829_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_54375_ActivityName = {
    Text = "Pujian Mawar"
  },
  Activity_54375_ActivityPlot = {
    Text = "Para hadirin sekalian.\nMalam yang tenang dan damai telah membuka tirainya, siapkanlah minuman terbaik di tangan Anda.\nIni adalah kisah yang panjang, dengarkanlah kami menceritakannya perlahan…"
  },
  Activity_54375_ActivityTips = {
    Text = "<Title:Syarat Partisipasi>\n·Dapat berpartisipasi setelah menyelesaikan \"Operasi Investigasi\" 2-9·Normal.\n<Title:Event Investigasi>\n·Selama periode aktivitas, setiap hari akan merilis satu event investigasi baru di \"Pujian Rosea\". Keeper tidak perlu mengonsumsi sumber daya untuk membuka dan melakukan investigasi. Setelah menyelesaikan event investigasi, dapat memperoleh hadiah investigasi seperti Inti Murni, Lencana Investigasi, dan EXP Keeper.\n·Setelah aktivitas berakhir, progres investigasi \"Pujian Rosea\" akan dipertahankan. Keeper dapat mengonsumsi Mutiara Erosi di Catatan Ekspedisi untuk membuka investigasi yang belum terbuka. Setelah menyelesaikan event investigasi yang belum selesai selama periode aktivitas, juga dapat memperoleh hadiah investigasi yang sama seperti saat periode aktivitas.<Title:Hadiah Terbatas>\n·Selama periode aktivitas akan tersedia hadiah terbatas. Setelah Keeper menyelesaikan mode Normal \"Pujian Rosea\" dan menyelesaikan event investigasi \"Pujian Rosea\", dapat memperoleh hadiah Inti Murni, Batu Bijak, dan Silver Core! Hadiah terbatas hanya dibuka selama periode aktivitas, setelah aktivitas berakhir tidak dapat diselesaikan dan diklaim."
  },
  Activity_54402_ActivityName = {
    Text = "Pasien Terbelah·Chaos"
  },
  Activity_54402_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara \"Pasien Skizofren·Kaos\" berlangsung, Penjaga dapat menggunakan susunan tim preset sistem yang mencakup \"24\", untuk menikmati tingkat yang ditentukan tanpa batas.\n·Saat menikmati tingkat acara, Awakener dalam susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Acara>\n·Setelah berhasil menyelesaikan tantangan tingkat untuk pertama kalinya, hadiah percobaan dapat diambil di antarmuka acara."
  },
  Activity_54403_ActivityName = {
    Text = "Kunci Gerbang"
  },
  Activity_54403_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Kunci Gerbang\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Tavi untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_54404_ActivityName = {
    Text = "Uskup Pengasih"
  },
  Activity_54404_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Uskup Pengasih\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Salvador untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_54405_ActivityName = {
    Text = "Pasien Terbelah·Hyperdimensi"
  },
  Activity_54405_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara \"Pasien Skizofren·Ultra\" berlangsung, Penjaga dapat menggunakan susunan tim preset sistem yang mencakup \"24\", untuk menikmati tingkat yang ditentukan tanpa batas.\n·Saat menikmati tingkat acara, Awakener dalam susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Acara>\n·Setelah berhasil menyelesaikan tantangan tingkat untuk pertama kalinya, hadiah percobaan dapat diambil di antarmuka acara."
  },
  Activity_54406_ActivityName = {
    Text = "Rasul Lautan"
  },
  Activity_54406_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Rasul Lautan\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Miriam untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_54407_ActivityName = {
    Text = "Pemain Abadi"
  },
  Activity_54407_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Pemain Abadi\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Hamelin untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_54408_ActivityName = {
    Text = "Pencabut Jiwa"
  },
  Activity_54408_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Pencabut Jiwa\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Rantai Darah·Shilo untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_54409_ActivityName = {
    Text = "Pasien Terbelah·Laut Dalam"
  },
  Activity_54409_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara \"Pasien Skizofren·Laut Dalam\" berlangsung, Penjaga dapat menggunakan susunan tim preset sistem yang mencakup \"24\", untuk menikmati tingkat yang ditentukan tanpa batas.\n·Saat menikmati tingkat acara, Awakener dalam susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Acara>\n·Setelah berhasil menyelesaikan tantangan tingkat untuk pertama kalinya, hadiah percobaan dapat diambil di antarmuka acara."
  },
  Activity_54410_ActivityName = {
    Text = "Pasien Terbelah·Daging Darah"
  },
  Activity_54410_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara \"Pasien skizofren · Caro\" berlangsung, Penjaga dapat menggunakan susunan tim preset sistem yang mencakup \"24\", untuk menikmati tingkat yang ditentukan tanpa batas.\n·Saat menikmati tingkat acara, Awakener dalam susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Acara>\n·Setelah berhasil menyelesaikan tantangan tingkat untuk pertama kalinya, hadiah percobaan dapat diambil di antarmuka acara."
  },
  Activity_54411_ActivityName = {Text = "Otak Busuk"},
  Activity_54411_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Otak Busuk\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup\"Meltdown·Dor\"untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_54521_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_54521_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_54522_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_54522_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_54523_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_54523_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_54524_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_54524_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_54525_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_54525_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_54526_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_54526_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_54527_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_54527_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_54596_ActivityName = {
    Text = "Anugerah Pengetahuan"
  },
  Activity_54596_ActivityTips = {
    Text = [[
<Title:Pengantar Event>
1, Setelah Keeper menyelesaikan misi event yang ditentukan, dapat mengklaim "Taman Protyle","Buku Rotasi","Prototipe Visio","Master Siklus","Inti Retrospeksi Jiwa","Inti Retrospeksi Takdir", serta Awakened dan Roda Takdir terbatas "Bab Kelupaan", Awakened dan Roda Takdir terbatas "Bab Bintang", dan hadiah berlimpah lainnya. Selain itu, ada juga hadiah eksklusif berupa bingkai avatar terbatas event "Matriks Perak Putih" dan percepatan EXP Keeper!
2, Event ini dibuka secara permanen. Setelah menyelesaikan semua misi dan mengklaim semua hadiah, event akan berakhir dan tidak lagi ditampilkan setelah pukul 9:00(GMT+8) keesokan harinya.

<Title:Pujian Tertinggi>
1, Menyelesaikan misi event yang ditentukan akan memberikan efek "Pujian Tertinggi", yang mempercepat perolehan EXP Keeper, hingga maksimal 100%. Jika beberapa efek "Pujian Tertinggi" aktif bersamaan, efek percepatan tertinggi yang akan berlaku.
2, Saat membuka atau mendapatkan efek "Pujian Tertinggi" yang lebih tinggi, EXP Keeper tambahan akan langsung diberikan berdasarkan rasio percepatan dan total EXP Keeper yang dapat dipercepat saat ini.
3, Setelah membuka "Pujian Tertinggi", setiap kali Keeper memperoleh EXP Keeper, EXP Keeper tambahan sesuai rasio percepatan juga akan diperoleh.
4, Harap diperhatikan, EXP Keeper tambahan dari "Pujian Tertinggi" tidak akan dihitung ke dalam total EXP Keeper yang dapat dipercepat.
5, Total EXP Keeper yang dapat dipercepat saat ini: {s1}.
6, Total EXP Keeper tambahan yang telah diperoleh dari percepatan: {s2}({s3}%).]]
  },
  Activity_55110_ActivityName = {
    Text = "Sebelum musim semi memudar"
  },
  Activity_55110_ActivityPlot = {
    Text = [[
Tawa para gadis bergema, menggaung di taman yang belum dijilat api.
Berdirilah sejenak demi masa lalu yang indah ini, wahai sahabatku.
Dengarkanlah musim semi yang belum layu, berbisik menceritakan kisah masa lampau.]]
  },
  Activity_55110_ActivityStageEndContent = {
    Text = "Aktivitas telah berakhir, saat ini hanya dapat berpartisipasi di \"Rumah Bunga Colette\""
  },
  Activity_55110_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1. Selama periode aktivitas, Keeper dapat mengumpulkan tiga jenis \"Puisi\" melalui gameplay terbatas \"Kenangan Taman\", \"Ciuman Muse\", dan \"Hadiah Pencapaian\". \"Puisi\" dapat digunakan untuk penukaran di \"Rumah Bunga Colette\" untuk memperoleh hadiah item, termasuk Roda Takdir SR eksklusif aktivitas \"Bunga dan Puisi Masa Lalu\", \"Inti Murni\", \"Inti Lumen\", \"Serpihan Batu Bijak\", \"Kristal Mimesis\", dll.\n2. Selama periode aktivitas, \"Catatan Ekspedisi: Kediaman Mawar\" akan dibuka secara gratis.\n\n<Title:Waktu Aktivitas>\n1. 15 Juli 9:00 - 29 Juli 9:00 (GMT+8), semua konten aktivitas dapat diikuti.\n2. 29 Juli 9:00 - 5 Agustus 9:00 (GMT+8), hanya \"Rumah Bunga Colette\" dan \"Hadiah Pencapaian\" yang dipertahankan, konten lainnya telah berakhir dan tidak dapat diikuti.\n\n<Title: Kenangan Taman>\n1. \"Kenangan Taman\" berisi 5 stage, setiap 2 hari otomatis membuka 1 stage.\n2. Setiap tantangan akan mengonsumsi \"Endorfin\" × 120, tantangan berhasil akan memperoleh mata uang aktivitas \"Puisi Sendu\", \"Puisi Penyesalan\", dan \"Puisi Kegembiraan\".\n3. Setelah stage diselesaikan, fitur \"Replay\" stage tersebut akan terbuka. Perhatian: Saat menggunakan fitur \"Replay\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Dapat menggunakan bantuan Alumni dan \"Resonansi: Elegi Taman\" untuk membantumu menyelesaikan stage dengan lebih mudah.\n5. Hari ke-2 setelah stage terbuka, tingkat kesulitan Insanity stage tersebut akan terbuka. Menyelesaikan first clear tingkat kesulitan Insanity dapat memperoleh hadiah mata uang aktivitas yang melimpah.\n6. Perhatian: Tantangan tingkat kesulitan Insanity tidak mengonsumsi Endorfin, tidak dapat di-replay, dan setelah first clear, tantangan ulang tidak akan memperoleh hadiah mata uang aktivitas lagi.\n\n<Title: Bonus Puisi>\n1. Keeper yang memiliki Awakened atau Roda Takdir tertentu (tidak harus ditempatkan di tim) dapat membuat \"Puisi Sendu\", \"Puisi Penyesalan\", dan \"Puisi Kegembiraan\" dari hadiah misi stage \"Kenangan Taman\" mendapatkan bonus drop tambahan (termasuk replay), detail bonus sebagai berikut:\n·Awakened \"Aurla\": Awakening 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Akhir Baris Surat Puisi\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Bunga dan Puisi Masa Lalu\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Puisi\" dari Awakened atau Roda Takdir yang berbeda dihitung secara akumulatif.\n3. Khususnya, hadiah tantangan first clear tingkat kesulitan Insanity tidak akan terpengaruh oleh \"Bonus Puisi\".\n\n<Title:Resonansi: Elegi Taman>\n1. Keeper dapat memperoleh \"Hati Abu\" dengan menyelesaikan pencapaian aktivitas.\n2. Mengonsumsi \"Hati Abu\" untuk mengaktifkan \"Resonansi: Elegi Taman\" dapat memperoleh bonus berikut:\n(1) Membuat Keeper menjadi lebih kuat di gameplay aktivitas \"Kenangan Taman\", tantangan menjadi lebih mudah.\n(2) Meningkatkan mata uang aktivitas yang diperoleh setelah menyelesaikan tantangan \"Kenangan Taman\".\n(3) Mengaktifkan gameplay aktivitas \"Ciuman Muse\".\n\n<Title: Ciuman Muse>\n·Setelah mengaktifkan resonansi \"Segala Sesuatu Tumbuh\", otomatis memperoleh 60 \"Puisi Sendu\" per jam, maksimal menyimpan 25 jam.\n·Setelah mengaktifkan resonansi \"Tukar Puisi dengan Bunga\", \"Ciuman Muse\" dapat memperoleh tambahan 60 \"Puisi Penyesalan\" per jam.\n\n<Title: Rumah Bunga Colette>\n1. \"Rumah Bunga Colette\" memiliki tiga petak bunga, waktu pembukaan sebagai berikut:\n·\"Petak Iris\": Dibuka 15 Juli pukul 9:00.\n·\"Petak Bellflower\": Dibuka 17 Juli pukul 9:00.\n·\"Petak Rosea\": Dibuka 19 Juli pukul 9:00.\n2. Setiap penukaran akan mengonsumsi 1000 \"Puisi Sendu\"/\"Puisi Penyesalan\"/\"Puisi Kegembiraan\", memperoleh secara acak lima hadiah item dari petak bunga.\n3. Hadiah item setiap petak bunga dibagi menjadi \"Item Spesial\" dan \"Item Biasa\", saat reset dapat mengatur ulang jumlah sisa hadiah item spesial ke batas maksimal, aturan spesifik sebagai berikut:\n(1) 2 kali reset pertama: Setelah \"Item Spesial\" tidak memiliki sisa jumlah, Keeper dapat memilih untuk reset, setelah reset jumlah sisa \"Item Spesial\" dan \"Item Biasa\" akan diatur ulang ke batas maksimal; juga dapat memilih untuk terus menukar, setelah \"Item Biasa\" juga tidak memiliki sisa jumlah, harus melakukan reset untuk dapat melanjutkan penukaran.\n(2) Mulai reset ke-3: Reset hanya dapat dilakukan setelah \"Item Biasa\" tidak memiliki sisa jumlah, reset akan mengatur ulang jumlah sisa \"Item Biasa\" ke batas maksimal, \"Item Spesial\" tidak lagi di-reset.\n4. Setelah 5 Agustus 9:00 (GMT+8), \"Puisi\" yang tersisa dan belum ditukarkan akan dikembalikan dengan rasio setiap 200 ditukar menjadi \"Voucher Emas Rosea × 5000\", harap Keeper memperhatikan email.\n\n<Title: Catatan Ekspedisi>\n1. Selama periode aktivitas, \"Catatan Ekspedisi: Kediaman Mawar\" akan dibuka secara gratis. Setiap 2 hari akan merilis event baru, setelah menyelesaikan \"Catatan Ekspedisi: Kediaman Mawar\" dapat memperoleh hadiah seperti Silver Core, Roda Takdir SR eksklusif aktivitas \"Bunga dan Puisi Masa Lalu\", dll. di Hadiah Pencapaian. Hadiah Pencapaian hanya dibuka selama periode aktivitas, setelah aktivitas berakhir tidak dapat diselesaikan dan diklaim.\n2. Setelah aktivitas berakhir, progres investigasi \"Catatan Ekspedisi: Kediaman Mawar\" akan dipertahankan. Jika selama periode aktivitas belum membuka \"Catatan Ekspedisi: Kediaman Mawar\", setelah aktivitas berakhir masih dapat mengonsumsi \"Titik Awal Realitas\" × 7 untuk membukanya.\n3. Baik selama maupun di luar periode aktivitas, setelah menyelesaikan \"Catatan Ekspedisi: Kediaman Mawar\" dapat memperoleh \"Perintah Kunci: Puisi Persembahan Musim Semi\"."
  },
  Activity_55110_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_55457_ActivityName = {Text = "Fisi Damai"},
  Activity_56427_ActivityName = {
    Text = "Gembala Jiwa·Reprise"
  },
  Activity_56427_ActivityPlot = {
    Text = [[
Dia telah menderita untuk kalian, menanggung penderitaan kalian.
Karena Caro yang dia korbankan, kalian menerima penyembuhan;
karena Hidup yang dia berikan, kalian menerima pengampunan.]]
  },
  Activity_56427_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Bazar Amal Gereja\""
  },
  Activity_56427_ActivityTips = {
    Text = "<Title:Pengenalan Event>\n1. Selama event berlangsung, Penjaga Rahasia dapat mengumpulkan mata uang event \"Kupon Bazaar\" melalui mode terbatas waktu \"Jalan Menuju Katedral\", \"Kebaikan Warga\", dan \"Hadiah Pencapaian\". \"Kupon Bazaar\" dapat ditukarkan dengan barang acak di \"Bazaar Amal Katedral\", termasuk Roda Takdir SR edisi terbatas event \"Orang di Cermin\", Inti Murni, Inti Lumen, dan lainnya.\n2. Selama event berlangsung, \"Catatan Misi Khusus: Warna Darah\" akan dibuka secara gratis. Selesaikan pencapaian event untuk mendapatkan avatar edisi terbatas event \"Atas Nama Kunci Perak: Salvador\"!\n\n<Title:Waktu Event>\n1. 26 Agustus 9:00 - 9 September 9:00 (GMT+8), semua konten event dapat diikuti.\n2. 9 September 9:00 - 16 September 9:00 (GMT+8), hanya \"Bazaar Amal Katedral\" dan \"Hadiah Pencapaian\" yang tersedia, konten lainnya sudah berakhir dan tidak dapat diikuti.\n\n<Title:Jalan Menuju Katedral>\n1. \"Jalan Menuju Katedral\" terdiri dari 5 stage, setiap 2 hari otomatis membuka 1 stage.\n2. Setiap tantangan akan mengonsumsi \"Spiritpeptida\" × 120, tantangan berhasil akan memberikan mata uang event \"Kupon Bazaar\".\n3. Setelah stage diselesaikan, fungsi \"Pemutaran Ulang\" stage tersebut akan terbuka. Perhatian: Saat menggunakan fungsi \"Pemutaran Ulang\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Kamu dapat menggunakan bantuan Asosiasi Alumni dan \"Resonansi: Persimpangan Jiwa\" untuk membantumu menyelesaikan stage dengan lebih mudah.\n\n<Title:Bonus Cahaya>\n1. Di bawah pengaruh \"Cahaya Jiwa\", Penjaga Rahasia yang memiliki Awakener atau Roda Takdir tertentu (tidak harus diturunkan) dapat memperoleh bonus drop tambahan untuk \"Kupon Bazaar\" dari hadiah misi stage \"Jalan Menuju Katedral\" (termasuk pemutaran ulang). Detail bonus sebagai berikut:\n·Awakener \"Salvador\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda Takdir SSR \"Loh Sabda Ilahi\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda Takdir SR \"Orang di Cermin\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n2. \"Bonus Cahaya\" dari Awakener atau Roda Takdir yang berbeda dihitung secara kumulatif.\n3. Khususnya, hadiah tantangan pertama kali tingkat kesulitan Gila tidak akan terpengaruh oleh \"Bonus Cahaya\".\n\n<Title:Resonansi: Persimpangan Jiwa>\n1. Penjaga Rahasia dapat memperoleh \"Hati Pengakuan\" dengan menyelesaikan pencapaian event. \n2. Konsumsi \"Hati Pengakuan\" untuk mengaktifkan \"Resonansi: Persimpangan Jiwa\", yang dapat memberikan bonus berikut:\n(1) Membuat Penjaga Rahasia menjadi lebih kuat di mode event \"Jalan Menuju Katedral\" dan \"Catatan Misi Khusus: Warna Darah\", sehingga tantangan lebih mudah.\n(2) Meningkatkan Tingkat Sinkronisasi yang diperoleh setelah menyelesaikan tantangan \"Jalan Menuju Katedral\".\n(3) Mengaktifkan mode event \"Kebaikan Warga\".\n\n<Title:Kebaikan Warga>\n1. Setelah mengaktifkan resonansi \"Cara yang Mudah\", secara otomatis mendapatkan 60 \"Kupon Bazaar\" per jam, maksimal menyimpan 25 jam.\n2. Setelah mengaktifkan resonansi \"Penebusan, Penebusan\", secara otomatis mendapatkan tambahan 1800 Voucher Emas Mawar per jam.\n\n<Title: Bazaar Amal Katedral>\n1. \"Bazaar Amal Katedral\" memiliki tiga toko, waktu pembukaan sebagai berikut:\n·\"Toko Kecil Nyonya Grey\": Dibuka 26 Agustus pukul 9:00.\n·\"Bazaar Ajaib John Besar\": Dibuka 29 Agustus pukul 9:00.\n·\"Obral Smith\": Dibuka 1 September pukul 9:00.\n2. Setiap penukaran akan mengonsumsi 1000 \"Kupon Bazaar\", dan secara acak mendapatkan lima hadiah barang dari toko.\n3. Hadiah barang setiap toko dibagi menjadi \"Barang Spesial\" dan \"Barang Biasa\". Saat reset, jumlah sisa hadiah Barang Spesial akan direset ke batas maksimal. Aturan spesifiknya:\n(1) 2 reset pertama: Setelah \"Barang Spesial\" habis, Penjaga Rahasia dapat memilih untuk reset, yang akan mereset jumlah sisa \"Barang Spesial\" dan \"Barang Biasa\" ke batas maksimal; atau dapat memilih untuk terus menukar, dan setelah \"Barang Biasa\" juga habis, harus melakukan reset untuk melanjutkan penukaran.\n(2) Mulai reset ke-3: Reset hanya dapat dilakukan setelah \"Barang Biasa\" habis. Reset akan mereset jumlah sisa \"Barang Biasa\" ke batas maksimal, \"Barang Spesial\" tidak lagi direset.\n4. Setelah 16 September 9:00 (GMT+8), sisa \"Kupon Bazaar\" yang belum ditukarkan akan dikembalikan dengan rasio setiap 200 unit ditukar menjadi \"Voucher Emas Mawar × 5000\". Penjaga Rahasia harap periksa surat masuk.\n\n<Title: Catatan Misi Khusus>\n1. Selama event berlangsung, \"Catatan Misi Khusus: Warna Darah\" akan dibuka secara gratis.\n2. Setelah event berakhir, progres investigasi \"Catatan Misi Khusus: Warna Darah\" akan disimpan. Jika \"Catatan Misi Khusus: Warna Darah\" tidak dibuka selama event, setelah event berakhir masih dapat dibuka dengan mengonsumsi \"Titik Awal Realitas\" × 7.\n3. Baik selama maupun di luar periode event, menyelesaikan \"Catatan Misi Khusus: Warna Darah\" akan memberikan \"Perintah Kunci: Turunnya Mukjizat\".\n\n<Title:Kompensasi Rerun>\n1. Penjaga Rahasia yang sebelumnya sudah membuka \"Catatan Misi Khusus: Warna Darah\" akan menerima kompensasi \"Kupon Bazaar\" × 700 saat membuka kembali selama event rerun ini.\n2. Penjaga Rahasia yang sebelumnya sudah mendapatkan avatar edisi terbatas event \"Atas Nama Kunci Perak: Salvador\", saat mendapatkannya kembali akan otomatis dikonversi menjadi \"Kupon Bazaar\" × 2000.\n3. Penjaga Rahasia yang sebelumnya sudah mendapatkan material aktivasi resonansi \"Hati Pengakuan\", setiap 1 \"Hati Pengakuan\" berlebih yang diperoleh akan otomatis dikonversi menjadi \"Voucher Emas Mawar\" × 5000.\n"
  },
  Activity_56427_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_56428_ActivityName = {
    Text = "Pengorbanan Jurang·Reprise"
  },
  Activity_56428_ActivityPlot = {
    Text = [[
Di atas bayangan Aequor, mimpi sang Raja memudar, dan kerajaan dewa telah mengalami pembusukan. 
Dia datang dari ilusi hari-hari lampau, melangkah ke reruntuhan masa depan yang runtuh. 
Dia bertanya kepada Jurang, namun Jurang tetap bungkam. 
Dia memberikan persembahan kepada Jurang, dan yang menjawabnya hanyalah dirinya sendiri.]]
  },
  Activity_56428_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Tanggapan dari Jurang yang Dalam\""
  },
  Activity_56428_ActivityTips = {
    Text = "<Title:Pengenalan Event>\n1. Selama event berlangsung, Penjaga Rahasia dapat mengumpulkan mata uang event melalui mode terbatas waktu \"Turunnya Kerajaan Dewa\", \"Titah Sang Raja\", dan \"Hadiah Pencapaian\". Mata uang event dapat digunakan untuk persembahan di \"Jawaban dari Jurang\" guna memperoleh hadiah item, termasuk Roda Takdir SR edisi terbatas event \"Panggilan Laut Dalam\", Batu Bijak, Inti Murni, Inti Lumen, dll.\n2. Selama event berlangsung, \"Pandangan Mimpi Aneh: Penistaan\" akan dibuka secara gratis. Menyelesaikan pencapaian event juga bisa mendapatkan avatar edisi terbatas event \"Atas Nama Kunci Perak: Miriam\"!\n\n<Title:Waktu Event>\n1. 4 November 9:00 - 18 November 9:00 (GMT+8), semua konten event dapat diikuti.\n2. 18 November 9:00 - 25 November 9:00 (GMT+8), hanya \"Jawaban dari Jurang\" dan \"Hadiah Pencapaian\" yang dipertahankan, konten lainnya telah berakhir dan tidak dapat diikuti.\n\n<Title: Turunnya Kerajaan Dewa>\n1. \"Turunnya Kerajaan Dewa\" memiliki 5 stage, setiap 2 hari otomatis membuka 1 stage.\n2. Setiap tantangan akan mengonsumsi \"Psikofepton\" × 120, tantangan berhasil akan memperoleh mata uang event.\n3. Setelah stage diselesaikan, fitur \"Pengulangan\" stage tersebut akan terbuka. Perhatian: Saat menggunakan fitur \"Pengulangan\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Kamu dapat menggunakan bantuan Asosiasi Alumni dan \"Resonansi: Ritual Jurang Laut\" untuk membantumu menyelesaikan stage dengan lebih mudah.\n\n<Title: Bonus Persembahan>\n1. Penjaga Rahasia yang memiliki Awakened atau Roda Takdir tertentu (tidak harus diturunkan) dapat memperoleh bonus drop tambahan untuk \"Air Mata Pendeta\", \"Darah Pendeta\", dan \"Sumsum Pendeta\" dari hadiah misi stage \"Turunnya Kerajaan Dewa\" (termasuk Pengulangan). Bonus spesifik sebagai berikut:\n·Awakened \"Miriam\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Kekuatan Saleh\": Tumpukan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Panggilan Laut Dalam\": Tumpukan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Persembahan\" dari Awakened atau Roda Takdir yang berbeda dihitung secara kumulatif.\n3. Khususnya, hadiah tantangan pertama kali tingkat kesulitan Gila tidak akan terpengaruh oleh \"Bonus Persembahan\".\n\n<Title:Resonansi: Ritual Jurang Laut>\n1. Penjaga Rahasia dapat memperoleh \"Hati Keimanan\" dengan menyelesaikan pencapaian event.\n2. Mengonsumsi \"Hati Keimanan\" untuk mengaktifkan \"Resonansi: Ritual Jurang Laut\" dapat memperoleh bonus berikut:\n(1) Membuat Penjaga Rahasia menjadi lebih kuat di mode event \"Turunnya Kerajaan Dewa\", tantangan menjadi lebih mudah.\n(2) Meningkatkan mata uang event yang diperoleh setelah menyelesaikan tantangan \"Turunnya Kerajaan Dewa\".\n(3) Mengaktifkan mode event \"Titah Sang Raja\".\n\n<Title: Titah Sang Raja>\n·Setelah mengaktifkan Resonansi \"Ujian Persembahan\", setiap jam otomatis memperoleh 60 \"Air Mata Pendeta\", maksimal menyimpan 25 jam.\n\n<Title: Jawaban dari Jurang>\n1. \"Jawaban dari Jurang\" memiliki tiga altar, waktu pembukaan sebagai berikut:\n·\"Altar Air Mata Berkilau\": 4 November 9:00 ~ 25 November 9:00.\n·\"Altar Darah Merah\": 6 November 9:00 ~ 25 November 9:00.\n·\"Altar Sumsum Roh\": 8 November 9:00 ~ 25 November 9:00.\n2. Setiap persembahan akan mengonsumsi 1000 \"Air Mata Pendeta\"/\"Darah Pendeta\"/\"Sumsum Pendeta\", memperoleh secara acak lima hadiah item dari altar.\n3. Hadiah item setiap altar dibagi menjadi \"Item Spesial\" dan \"Item Biasa\". Saat reset, jumlah sisa hadiah item tertentu dapat direset ke batas maksimal. Aturan spesifik sebagai berikut:\n(1) 2 kali reset pertama: Setelah \"Item Spesial\" tidak memiliki jumlah tersisa, Penjaga Rahasia dapat memilih untuk reset, setelah reset jumlah sisa \"Item Spesial\" dan \"Item Biasa\" akan direset ke batas maksimal; atau dapat memilih untuk terus mempersembahkan, setelah \"Item Biasa\" juga tidak memiliki jumlah tersisa, harus melakukan reset untuk melanjutkan persembahan.\n(2) Mulai reset ke-3: Reset hanya dapat dilakukan setelah \"Item Biasa\" tidak memiliki jumlah tersisa, reset akan mereset jumlah sisa \"Item Biasa\" ke batas maksimal, \"Item Spesial\" tidak lagi direset.\n\n<Title: Pandangan Mimpi Aneh>\n1. Selama event berlangsung, \"Pandangan Mimpi Aneh: Penistaan\" akan dibuka secara gratis.\n2. Setelah event berakhir, progres investigasi \"Pandangan Mimpi Aneh: Penistaan\" akan dipertahankan. Jika selama event \"Pandangan Mimpi Aneh: Penistaan\" belum dibuka, setelah event berakhir masih dapat mengonsumsi \"Titik Awal Realitas\" × 7 untuk membukanya.\n3. Baik selama event maupun tidak, setelah menyelesaikan \"Pandangan Mimpi Aneh: Penistaan\" dapat memperoleh \"Perintah Kunci: Ritual Laut\".\n\n<Title:Kompensasi Rerun>\n1. Penjaga Rahasia yang sebelumnya sudah membuka \"Pandangan Mimpi Aneh: Penistaan\", saat membuka kembali selama event rerun ini akan memperoleh kompensasi \"Air Mata Pendeta\" × 700.\n2. Penjaga Rahasia yang sebelumnya sudah memperoleh avatar edisi terbatas event \"Atas Nama Kunci Perak: Miriam\", saat memperoleh kembali akan otomatis dikonversi menjadi \"Air Mata Pendeta\" × 2000.\n3. Penjaga Rahasia yang sebelumnya sudah memperoleh material aktivasi Resonansi \"Hati Keimanan\", setiap memperoleh 1 \"Hati Keimanan\" berlebih akan otomatis dikonversi menjadi \"Kupon Emas Mawar\" × 5000.\n"
  },
  Activity_56428_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_56429_ActivityName = {
    Text = "Setengah langkah jarak"
  },
  Activity_56429_ActivityPlot = {
    Text = [[
Dia selalu berada di depan orang-orang. 
Satu langkah, dua langkah, jejak kakinya memimpin langkah-langkah manusia. 
Namun, orang sering lupa bahwa jarak antara jenius dan orang gila hanyalah setengah langkah.]]
  },
  Activity_56429_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Pengajaran Sang Guru\""
  },
  Activity_56429_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\nSelama periode aktivitas, Penjaga Rahasia dapat mengumpulkan mata uang aktivitas \"Komponen Boneka\" melalui mode terbatas \"Gerbang Kehampaan\" dan \"Hadiah Pencapaian\". \"Komponen Boneka\" dapat ditukarkan dengan hadiah di \"Ajaran Sang Guru\", termasuk Roda Takdir SR terbatas aktivitas \"Tongkat Penggembala\", Inti Lumen, Inti Murni, Serpihan Batu Bijak, Kristal Mimesis, dan lainnya.\n\n<Title:Gerbang Kehampaan>\n1. \"Gerbang Kehampaan\" terdiri dari 9 stage material pertarungan langsung tanpa eksplorasi, 1 stage dibuka setiap hari.\n2. Setiap tantangan akan mengonsumsi \"Psychoffein\" × 120. Tantangan yang berhasil akan memberikan material pengembangan dan mata uang aktivitas.\n3. Setelah menyelesaikan stage, fungsi \"Tayangan Ulang\" untuk stage tersebut akan terbuka. Perhatian: Saat menggunakan fungsi \"Tayangan Ulang\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Anda dapat menggunakan bantuan Asosiasi Alumni untuk membantu menyelesaikan stage dengan lebih mudah.\n\n<Title:Bonus Komponen Boneka>\n1. Penjaga Rahasia yang memiliki Awakened atau Roda Takdir tertentu (tidak perlu ditempatkan di tim) dapat memperoleh bonus drop tambahan untuk \"Komponen Boneka\" dari hadiah misi stage \"Gerbang Kehampaan\" (termasuk Tayangan Ulang). Detail bonus sebagai berikut:\n·Awakened \"Meltdown·Doll\": Kebangkitan Roh 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Boneka yang Jatuh ke Kehampaan\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Tongkat Penggembala\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Komponen Boneka\" dari Awakened atau Roda Takdir yang berbeda dihitung secara kumulatif.\n3. Khususnya, hadiah tantangan penyelesaian pertama tingkat kesulitan Gila tidak terpengaruh oleh bonus di atas.\n\n<Title: Ajaran Sang Guru>\n1. Setiap \"Tukar Komponen\" akan mengonsumsi 750 \"Komponen Boneka\", dan secara acak memberikan lima hadiah item dari \"Ajaran Sang Guru\".\n2. Hadiah item \"Ajaran Sang Guru\" dibagi menjadi \"Item Spesial\" dan \"Item Biasa\". Saat direset, jumlah sisa hadiah item spesial akan dikembalikan ke batas maksimal. Aturan spesifiknya sebagai berikut:\n(1) 5 reset pertama: Setelah \"Item Spesial\" habis, Penjaga Rahasia dapat memilih untuk mereset. Setelah reset, jumlah sisa \"Item Spesial\" dan \"Item Biasa\" akan dikembalikan ke batas maksimal; atau dapat memilih untuk terus menukar. Setelah \"Item Biasa\" juga habis, reset harus dilakukan untuk melanjutkan penukaran.\n(2) Mulai reset ke-6 dan seterusnya: Reset hanya dapat dilakukan setelah \"Item Biasa\" habis. Reset akan mengembalikan jumlah sisa \"Item Biasa\" ke batas maksimal, \"Item Spesial\" tidak lagi direset.\n\n<Title:Waktu Aktivitas>\n1. 17 Februari 9:00 - 3 Maret 9:00 (GMT+8), semua konten dalam pengenalan aktivitas dapat diikuti.\n2. 3 Maret 9:00 - 10 Maret 9:00 (GMT+8), hanya \"Ajaran Sang Guru\" dan \"Hadiah Pencapaian\" yang tersedia, konten lainnya telah berakhir dan tidak dapat diikuti.\n3. Setelah 10 Maret 9:00 (GMT+8), \"Komponen Boneka\" yang tersisa dan belum ditukarkan akan dikembalikan dengan rasio setiap unit ditukar menjadi \"Voucher Emas Mawar\" × 40. Harap Penjaga Rahasia periksa kotak surat."
  },
  Activity_56429_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_56430_ActivityName = {
    Text = "Simfoni Tak Berbentuk"
  },
  Activity_56430_ActivityPlot = {
    Text = [[
Simfoni adalah seni merajut, lintasan berbagai instrumen terjalin menjadi peta yang saling bersilangan.
Dalam jaring rajutannya, setiap not akan menjalankan perannya masing-masing.
Dengarkanlah, sebuah simfoni yang luar biasa segera dimulai.]]
  },
  Activity_56430_ActivityStageEndContent = {
    Text = "Event telah berakhir, saat ini hanya \"Istana Tidur Lelap\" yang dapat diikuti"
  },
  Activity_56430_ActivityTips = {
    Text = "<Title:Pengenalan Event>\n1. Selama event berlangsung, Penjaga Rahasia dapat mengumpulkan mata uang event \"Lembaran Nada Tinggi\" melalui mode terbatas waktu \"Suara Gemuruh\" dan \"Hadiah Pencapaian\". \"Lembaran Nada Tinggi\" dapat ditukarkan dengan hadiah berlimpah di \"Istana Tidur Lelap\", termasuk Roda Takdir SR edisi terbatas event \"Pertunjukan Tanpa Henti\", \"Inti Murni\", \"Inti Lumen\", \"Serpihan Batu Bijak\", \"Kristal Mimesis\", dan lainnya.\n2. Selama event berlangsung, menyelesaikan misi \"Hadiah Pencapaian\" dapat memberikan avatar edisi terbatas event \"Atas Nama Kunci Perak: Hamelin\", Roda Takdir SR edisi terbatas event \"Pertunjukan Tanpa Henti\", Inti Perak, dan mata uang event \"Lembaran Nada Tinggi\" dalam jumlah besar.\n\n<Title:Waktu Event>\n1. 9 September 9:00 - 23 September 9:00 (GMT+8), semua konten event dapat diikuti.\n2. 23 September 9:00 - 30 September 9:00 (GMT+8), hanya \"Istana Tidur Lelap\" dan \"Hadiah Pencapaian\" yang tersedia, konten lainnya sudah berakhir dan tidak dapat diikuti.\n\n<Title: Suara Gemuruh>\n1. \"Suara Gemuruh\" terdiri dari 9 stage, setiap hari otomatis membuka 1 stage.\n2. Setiap tantangan akan mengonsumsi \"Spiritpeptida\" × 120. Menantang stage yang berbeda selain mendapatkan drop material yang berbeda, juga akan memberikan mata uang event \"Lembaran Nada Tinggi\".\n3. Stage event kali ini adalah stage material pertarungan langsung, setelah diselesaikan dapat diputar ulang! Setiap \"Pemutaran Ulang\" mengonsumsi \"Spiritpeptida\" × 120.\n4. Perhatian: Saat menggunakan fungsi \"Pemutaran Ulang\", Tingkat Sinkronisasi tidak dapat diperoleh.\n\n<Title: Bonus Lembaran>\n1. Penjaga Rahasia yang memiliki Awakener atau Roda Takdir tertentu (tidak harus diturunkan) dapat memperoleh bonus drop tambahan untuk \"Lembaran Nada Tinggi\" dari hadiah misi stage \"Suara Gemuruh\" (termasuk pemutaran ulang). Detail bonus sebagai berikut:\n·Awakener \"Hamelin\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Requiem Abadi\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Pertunjukan Tanpa Henti\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Lembaran\" dari Awakener atau Roda Takdir yang berbeda dihitung secara kumulatif.\n3. Khususnya, hadiah tantangan pertama kali tingkat kesulitan Gila tidak akan terpengaruh oleh \"Bonus Lembaran\".\n\n<Title: Istana Tidur Lelap>\n1. \"Istana Tidur Lelap\" hanya dibuka selama 9 September 9:00 - 30 September 9:00 (GMT+8).\n2. Setelah 30 September 9:00 (GMT+8), sisa \"Lembaran Nada Tinggi\" yang belum ditukarkan akan dikembalikan dengan rasio setiap unit ditukar menjadi \"Voucher Emas Mawar\" × 40. Penjaga Rahasia harap periksa surat masuk."
  },
  Activity_56430_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_56431_ActivityName = {
    Text = "Bintang-Bintang di Posisi Tegak"
  },
  Activity_56431_ActivityPlot = {
    Text = [[
Saat bintang-bintang mencapai posisi sempurna telah tiba, gerakan janin di dada berdentum bagai genderang.
Mimpi buruk malam gelap yang menyiksanya selama bertahun-tahun, berakhir seiring datangnya akhir yang membuat air mata para pengikut mengalir deras.
Dari @1kegelapan@2-Nya, @3 yang agung turun ke dunia.]]
  },
  Activity_56431_ActivityStageEndContent = {
    Text = "Aktivitas telah berakhir, saat ini hanya \"Penetasan Suci\" yang dapat diikuti"
  },
  Activity_56431_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1. Selama periode aktivitas, Keeper dapat mengumpulkan tiga jenis \"Embrio\" melalui gameplay terbatas \"Rahim Kegelapan\" dan \"Hadiah Pencapaian\". \"Embrio\" dapat ditukarkan dengan hadiah item di \"Penetasan Suci\", termasuk Roda Takdir SR eksklusif aktivitas \"Tidur di Bawah Gletser\", \"Inti Murni\", \"Inti Lumen\", \"Serpihan Batu Bijak\", \"Kristal Mimesis\", dll.\n2. Selama periode aktivitas, menyelesaikan misi \"Hadiah Pencapaian\" dapat memperoleh avatar eksklusif aktivitas \"Atas Nama Silver Key: Goliah\", Roda Takdir SR eksklusif aktivitas \"Tidur di Bawah Gletser\", dan banyak \"Embrio\".\n\n<Title:Waktu Aktivitas>\n1. 29 Juli 9:00 - 12 Agustus 9:00 (GMT+8), semua konten aktivitas dapat diikuti.\n2. 12 Agustus 9:00 - 19 Agustus 9:00 (GMT+8), hanya \"Penetasan Suci\" dan \"Hadiah Pencapaian\" yang dipertahankan, konten lainnya telah berakhir dan tidak dapat diikuti.\n\n<Title: Rahim Kegelapan>\n1. \"Rahim Kegelapan\" berisi 7 stage, setiap hari otomatis membuka 1 stage.\n2. Setiap tantangan akan mengonsumsi \"Endorfin\" × 120, tantangan berhasil akan memperoleh mata uang aktivitas \"Embrio Tanpa Kesadaran\", \"Embrio Tanpa Hasrat\", dan \"Embrio Tanpa Kepuasan\".\n3. Setelah stage diselesaikan, fitur \"Replay\" stage tersebut akan terbuka. Perhatian: Saat menggunakan fitur \"Replay\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Dapat menggunakan bantuan Alumni untuk membantumu menyelesaikan stage dengan lebih mudah.\n5. Setelah menyelesaikan stage di tingkat kesulitan mana pun, tingkat kesulitan Insanity stage tersebut akan terbuka. Menyelesaikan first clear tingkat kesulitan Insanity dapat memperoleh hadiah mata uang aktivitas yang melimpah.\n6. Perhatian: Tantangan tingkat kesulitan Insanity tidak mengonsumsi Endorfin, tidak dapat di-replay, dan setelah first clear, tantangan ulang tidak akan memperoleh hadiah mata uang aktivitas lagi.\n\n<Title: Bonus Embrio>\n1. Keeper yang memiliki Awakened atau Roda Takdir tertentu (tidak harus ditempatkan di tim) dapat membuat \"Embrio Tanpa Kesadaran\", \"Embrio Tanpa Hasrat\", dan \"Embrio Tanpa Kepuasan\" dari hadiah misi stage \"Rahim Kegelapan\" mendapatkan bonus drop tambahan (termasuk replay), detail bonus sebagai berikut:\n·Awakened \"Murphy\": Awakening 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Kelahiran Tersembunyi\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Tidur di Bawah Gletser\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Embrio\" dari Awakened atau Roda Takdir yang berbeda dihitung secara akumulatif.\n3. Khususnya, hadiah tantangan first clear tingkat kesulitan Insanity tidak akan terpengaruh oleh \"Bonus Embrio\".\n\n<Title: Penetasan Suci>\n1. \"Penetasan Suci\" hanya dibuka selama 29 Juli 9:00 - 19 Agustus 9:00 (GMT+8).\n2. Setelah 19 Agustus 9:00 (GMT+8), \"Embrio\" yang tersisa dan belum ditukarkan akan dikembalikan dengan rasio setiap embrio ditukar menjadi \"Voucher Emas Rosea\" × 40, harap Keeper memperhatikan email."
  },
  Activity_56431_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_56432_ActivityName = {
    Text = "Saat Gunung Salju Mencair"
  },
  Activity_56432_ActivityPlot = {
    Text = [[
Salju dan es Elvorth tak pernah mencair sepanjang tahun, seperti halnya dendamnya.
Saat tangan masa depan dan masa lalu saling bertaut, sang pejuang akan mengangkat pedangnya tinggi-tinggi, melancarkan serangan balas dendam terhadap takdir.
Saat ia menghadapi gelombang hitam, kaulah panjinya.]]
  },
  Activity_56432_ActivityStageEndContent = {
    Text = "Aktivitas telah berakhir, saat ini hanya dapat berpartisipasi di \"Mulut Raksasa Pegunungan\""
  },
  Activity_56432_ActivityTips = {
    Text = "<Title:Pengenalan Event>\n1. Selama event berlangsung, Penjaga Rahasia dapat mengumpulkan tiga jenis \"Kuncup Bunga\" melalui mode terbatas waktu \"Ambisi Sang Binatang\" dan \"Hadiah Pencapaian\". \"Kuncup Bunga\" dapat digunakan untuk menukar hadiah item di \"Mulut Raksasa Pegunungan\", termasuk Roda Takdir SR edisi terbatas event \"Menunggu Gunung Salju Mencair\", \"Inti Murni\", \"Inti Lumen\", \"Serpihan Batu Bijak\", \"Kristal Mimikri\", dll.\n2. Selama event berlangsung, \"Catatan Ekspedisi: Pendatang Kembali Elworth\" akan dibuka secara gratis.\n\n<Title:Waktu Event>\n1. 7 Oktober 9:00 - 21 Oktober 9:00 (GMT+8), semua konten event dapat diikuti.\n2. 21 Oktober 9:00 - 28 Oktober 9:00 (GMT+8), hanya \"Mulut Raksasa Pegunungan\" dan \"Hadiah Pencapaian\" yang dipertahankan, konten lainnya telah berakhir dan tidak dapat diikuti.\n\n<Title: Ambisi Sang Binatang>\n1. \"Ambisi Sang Binatang\" memiliki 5 stage, setiap 2 hari otomatis membuka 1 stage.\n2. Setiap tantangan akan mengonsumsi \"Psikofepton\" × 120, tantangan berhasil akan memperoleh mata uang event \"Kuncup Beku\", \"Kuncup Embun Perak\", dan \"Kuncup Sinar Matahari\".\n3. Setelah stage diselesaikan, fitur \"Pengulangan\" stage tersebut akan terbuka. Perhatian: Saat menggunakan fitur \"Pengulangan\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Kamu dapat menggunakan bantuan Asosiasi Alumni dan \"Resonansi: Menelan Pegunungan\" untuk membantumu menyelesaikan stage dengan lebih mudah.\n5. Pada hari ke-2 setelah stage terbuka, tingkat kesulitan Gila untuk stage tersebut akan terbuka. Menyelesaikan tantangan pertama kali tingkat kesulitan Gila dapat memperoleh hadiah mata uang event yang melimpah.\n6. Perhatian: Tantangan tingkat kesulitan Gila tidak mengonsumsi Psikofepton, tidak dapat diulang, dan tantangan berulang setelah penyelesaian pertama tidak akan memperoleh hadiah mata uang event lagi.\n\n<Title: Bonus Kuncup Bunga>\n1. Penjaga Rahasia yang memiliki Awakened atau Roda Takdir tertentu (tidak harus diturunkan) dapat memperoleh bonus drop tambahan untuk \"Kuncup Beku\", \"Kuncup Embun Perak\", dan \"Kuncup Sinar Matahari\" dari hadiah misi stage \"Ambisi Sang Binatang\" (termasuk Pengulangan). Bonus spesifik sebagai berikut:\n·Awakened \"Rantai Darah·Shilo\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Tenggelam dalam Merah Tua\": Tumpukan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Menunggu Gunung Salju Mencair\": Tumpukan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Kuncup Bunga\" dari Awakened atau Roda Takdir yang berbeda dihitung secara kumulatif.\n3. Khususnya, hadiah tantangan pertama kali tingkat kesulitan Gila tidak akan terpengaruh oleh \"Bonus Kuncup Bunga\".\n\n<Title:Resonansi: Menelan Pegunungan>\n1. Penjaga Rahasia dapat memperoleh \"Hati Penelan\" dengan menyelesaikan pencapaian event.\n2. Mengonsumsi \"Hati Penelan\" untuk mengaktifkan \"Resonansi: Menelan Pegunungan\" dapat membuat Penjaga Rahasia menjadi lebih kuat di mode event \"Ambisi Sang Binatang\", tantangan menjadi lebih mudah.\n\n<Title: Mulut Raksasa Pegunungan>\n1. \"Mulut Raksasa Pegunungan\" memiliki tiga toko penukaran, waktu pembukaan sebagai berikut:\n·\"Ambisi Menelan\": Dibuka 7 Oktober pukul 9:00.\n·\"Semangat Balas Dendam\": Dibuka 9 Oktober pukul 9:00.\n·\"Harapan Kelahiran Kembali\": Dibuka 11 Oktober pukul 9:00.\n2. Setiap penukaran akan mengonsumsi 1000 \"Kuncup Beku\"/\"Kuncup Embun Perak\"/\"Kuncup Sinar Matahari\", memperoleh secara acak lima hadiah item dari toko penukaran.\n3. Hadiah item setiap toko penukaran dibagi menjadi \"Item Spesial\" dan \"Item Biasa\". Saat reset, jumlah sisa hadiah item spesial dapat direset ke batas maksimal. Aturan spesifik sebagai berikut:\n(1) 2 kali reset pertama: Setelah \"Item Spesial\" tidak memiliki jumlah tersisa, Penjaga Rahasia dapat memilih untuk reset, setelah reset jumlah sisa \"Item Spesial\" dan \"Item Biasa\" akan direset ke batas maksimal; atau dapat memilih untuk terus menukar, setelah \"Item Biasa\" juga tidak memiliki jumlah tersisa, harus melakukan reset untuk melanjutkan penukaran.\n(2) Mulai reset ke-3: Reset hanya dapat dilakukan setelah \"Item Biasa\" tidak memiliki jumlah tersisa, reset akan mereset jumlah sisa \"Item Biasa\" ke batas maksimal, \"Item Spesial\" tidak lagi direset.\n4. Setelah 28 Oktober 9:00 (GMT+8), sisa \"Kuncup Bunga\" yang belum ditukar akan dikembalikan dengan rasio setiap penukaran menjadi \"Kupon Emas Mawar\" × 40. Penjaga Rahasia harap periksa surat masuk.\n\n<Title: Catatan Ekspedisi>\n1. Selama event berlangsung, \"Catatan Ekspedisi: Pendatang Kembali Elworth\" akan dibuka secara gratis. Setiap 2 hari akan merilis event baru. Setelah menyelesaikan \"Catatan Ekspedisi: Pendatang Kembali Elworth\", kamu dapat memperoleh hadiah seperti Inti Perak, Roda Takdir SR edisi terbatas event \"Menunggu Gunung Salju Mencair\", dll. dari Hadiah Pencapaian. Hadiah Pencapaian hanya dibuka selama event, setelah event berakhir tidak dapat diselesaikan dan diklaim.\n2. Setelah event berakhir, progres investigasi \"Catatan Ekspedisi: Pendatang Kembali Elworth\" akan dipertahankan. Jika selama event \"Catatan Ekspedisi: Pendatang Kembali Elworth\" belum dibuka, setelah event berakhir masih dapat mengonsumsi \"Titik Awal Realitas\" × 7 untuk membukanya.\n3. Baik selama event maupun tidak, setelah menyelesaikan \"Catatan Ekspedisi: Pendatang Kembali Elworth\" dapat memperoleh \"Perintah Kunci: Kesadaran Pegunungan\"."
  },
  Activity_56432_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_56433_ActivityName = {
    Text = "Buku Panduan Detektif"
  },
  Activity_56433_ActivityPlot = {
    Text = [[
Sebuah buku panduan yang tampak biasa saja.
Mencatat pemikiran dan pengalaman kerja selama bertahun-tahun dari seorang detektif terkenal.
Berharap dapat memberikan sedikit inspirasi bagi para pemuda yang bercita-cita menjadi detektif.]]
  },
  Activity_56433_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Klub Keberuntungan\""
  },
  Activity_56433_ActivityTips = {
    Text = "<Title:Pengenalan Event>\n1. Selama event berlangsung, Penjaga Rahasia dapat mengumpulkan mata uang event \"Chip Kemenangan\" melalui mode terbatas waktu \"Legenda Malam Bulan\" dan \"Hadiah Pencapaian\". \"Chip Kemenangan\" dapat ditukarkan dengan hadiah berlimpah di \"Klub Keberuntungan\", termasuk Roda Takdir SR edisi terbatas event \"Roulette Takdir\", \"Inti Murni\", \"Inti Lumen\", \"Serpihan Batu Bijak\", \"Kristal Mimesis\", dan lainnya.\n2. Selama event berlangsung, menyelesaikan misi \"Hadiah Pencapaian\" dapat memberikan avatar edisi terbatas event \"Atas Nama Kunci Perak: Lake\", Roda Takdir SR edisi terbatas event \"Roulette Takdir\", Inti Perak, dan mata uang event \"Chip Kemenangan\" dalam jumlah besar.\n3. Selama event berlangsung, \"Catatan Misi Khusus: Selamat Berburu!\" akan dibuka secara gratis.\n\n<Title:Waktu Event>\n1. 12 Agustus 9:00 - 26 Agustus 9:00 (GMT+8), semua konten event dapat diikuti.\n2. 26 Agustus 9:00 - 2 September 9:00 (GMT+8), hanya \"Klub Keberuntungan\" dan \"Hadiah Pencapaian\" yang tersedia, konten lainnya sudah berakhir dan tidak dapat diikuti.\n\n<Title: Legenda Malam Bulan>\n1. \"Legenda Malam Bulan\" terdiri dari 9 stage, setiap hari otomatis membuka 1 stage.\n2. Setiap tantangan akan mengonsumsi \"Spiritpeptida\" × 120. Menantang stage yang berbeda selain mendapatkan drop material yang berbeda, juga akan memberikan mata uang event \"Chip Kemenangan\".\n3. Stage event kali ini adalah stage material pertarungan langsung, setelah diselesaikan dapat diputar ulang! Setiap \"Pemutaran Ulang\" mengonsumsi \"Spiritpeptida\" × 120.\n4. Perhatian: Saat menggunakan fungsi \"Pemutaran Ulang\", Tingkat Sinkronisasi tidak dapat diperoleh.\n\n<Title: Bonus Chip>\n1. Penjaga Rahasia yang memiliki Awakener atau Roda Takdir tertentu (tidak harus diturunkan) dapat memperoleh bonus drop tambahan untuk \"Chip Kemenangan\" dari hadiah misi stage \"Legenda Malam Bulan\" (termasuk pemutaran ulang). Detail bonus sebagai berikut:\n·Awakener \"Lake\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Waktu Keberuntungan\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Roulette Takdir\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Chip\" dari Awakener atau Roda Takdir yang berbeda dihitung secara kumulatif.\n3. Khususnya, hadiah tantangan pertama kali tingkat kesulitan Gila tidak akan terpengaruh oleh \"Bonus Chip\".\n\n<Title: Klub Keberuntungan>\n1. \"Klub Keberuntungan\" hanya dibuka selama 12 Agustus 9:00 - 2 September 9:00 (GMT+8).\n2. Setelah 2 September 9:00 (GMT+8), sisa \"Chip Kemenangan\" yang belum ditukarkan akan dikembalikan dengan rasio setiap unit ditukar menjadi \"Voucher Emas Mawar\" × 40. Penjaga Rahasia harap periksa surat masuk.\n\n<Title:Catatan Misi Khusus>\n1. Di \"Catatan Misi Khusus: Selamat Berburu!\", Penjaga Rahasia akan menggunakan formasi khusus yang berisi preset cerita \"Lake\" untuk menantang.\n2. Menyelesaikan \"Catatan Misi Khusus: Selamat Berburu!\" akan memberikan Perintah Kunci baru \"Perintah Kunci: Suara Tembakan\"."
  },
  Activity_56433_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_56434_ActivityName = {
    Text = "Pintu Seribu Fenomena"
  },
  Activity_56434_ActivityPlot = {
    Text = [[
Tidak ada yang tahu tahun-tenaranya dia di depan pintu.
Dia tidak berniat terlibat dalam dunia mana pun, tidak boleh terjerat dalam kontinuitas ruang dan waktu, tidak boleh diganggu oleh apapun yang mengganggu ketentraman pintu paling ekstrem.
Sampai saat ketika dia bertemu tatapanmu]]
  },
  Activity_56434_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Echo\""
  },
  Activity_56434_ActivityTips = {
    Text = "<Title:Pengantar Event>\n1. Selama event berlangsung, Penjaga Rahasia dapat mengumpulkan mata uang event \"Jarum Akhir\" melalui gameplay terbatas \"Ujian Akhir\" dan \"Hadiah Pencapaian\". \"Jarum Akhir\" dapat ditukarkan dengan hadiah berlimpah di \"Gema\", termasuk Roda Takdir SR edisi terbatas event \"Gerbang Kebenaran\", \"Inti Murni\", \"Inti Lumen\", \"Serpihan Batu Bijak\", \"Kristal Mimesis\", dll.\n2. Selama event berlangsung, menyelesaikan misi \"Hadiah Pencapaian\" dapat memperoleh avatar edisi terbatas event \"Atas Nama Kunci Perak: Tavi\", Roda Takdir SR edisi terbatas event \"Gerbang Kebenaran\", Silver Core, dan sejumlah besar mata uang event \"Jarum Akhir\".\n\n<Title:Waktu Event>\n1. 18 November 9:00 - 2 Desember 9:00 (GMT+8), semua konten event dapat diikuti.\n2. 2 Desember 9:00 - 9 Desember 9:00 (GMT+8), hanya \"Gema\" dan \"Hadiah Pencapaian\" yang tersedia, konten lainnya sudah berakhir dan tidak dapat diikuti.\n\n<Title: Ujian Akhir>\n1. \"Ujian Akhir\" berisi 9 stage, 1 stage dibuka otomatis setiap hari.\n2. Setiap tantangan akan mengonsumsi \"Psychube\" × 120. Menantang stage yang berbeda selain mendapatkan drop material yang berbeda, juga akan mendapatkan mata uang event \"Jarum Akhir\".\n3. Stage event kali ini adalah stage material pertarungan langsung. Setelah diselesaikan, dapat ditayangkan ulang! Setiap \"Tayangan Ulang\" mengonsumsi \"Psychube\" × 120.\n4. Perhatian: Saat menggunakan fitur \"Tayangan Ulang\", Tingkat Sinkronisasi tidak dapat diperoleh.\n\n<Title: Bonus Jarum Akhir>\n1. Penjaga Rahasia yang memiliki Awakened atau Roda Takdir tertentu (tidak harus diturunkan) dapat memperoleh bonus drop tambahan untuk \"Jarum Akhir\" dari hadiah misi stage \"Ujian Akhir\" (termasuk Tayangan Ulang). Detail bonus sebagai berikut:\n·Awakened \"Tavi\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Roda Tersembunyi\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Gerbang Kebenaran\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Jarum Akhir\" dari Awakened atau Roda Takdir yang berbeda dihitung secara kumulatif.\n3. Khususnya, hadiah tantangan pertama kali tingkat kesulitan Gila tidak akan terpengaruh oleh \"Bonus Jarum Akhir\".\n\n<Title: Gema>\n1. \"Gema\" hanya dibuka selama 18 November 9:00 - 9 Desember 9:00 (GMT+8).\n2. Setelah 9 Desember 9:00 (GMT+8), sisa \"Jarum Akhir\" yang belum ditukarkan akan dikumpulkan kembali dengan rasio setiap 1 buah ditukar menjadi \"Voucher Emas Mawar\" × 40. Penjaga Rahasia harap periksa email."
  },
  Activity_56434_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_56435_ActivityName = {
    Text = "Penyembuhan Multi·Replika"
  },
  Activity_56435_ActivityPlot = {
    Text = [[
Hysteria, juga dikenal sebagai Histeria, gejala kejiwaan.
Di zaman kalian, itu memiliki arti yang sama dengan kematian.

Untungnya, para ilmuwan dan penyelidik di Universitas mythag juga sudah gila: mereka bertekad untuk mengatasi masalah ini]]
  },
  Activity_56435_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Analisis Kepribadian\""
  },
  Activity_56435_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1, Selama aktivitas berlangsung, Penjaga dapat mengumpulkan mata uang aktivitas \"Puzzle Kenangan\" melalui gameplay terbatas waktu \"Kode Memori\",\"Penyimpanan Tepi\", dan \"Hadiah Pencapaian\".\"Puzzle Kenangan\" dapat digunakan untuk membeli barang di \"Analisis Kepribadian\", termasuk Roda Takdir SR terbatas aktivitas \"Tekad Sang Kod Perak\", Inti Lumen, Inti murni, dan lainnya.\n2, Selama aktivitas berlangsung,\"Rekam Jejak Satuan Tugas: Fisi Damai\" dapat dibuka secara gratis untuk waktu terbatas. Menyelesaikan pencapaian aktivitas juga dapat memperoleh avatar terbatas aktivitas \"Atas nama Kunci Perak:\" 24 \"\"!\n\n<Title:Waktu Aktivitas>\n1,21 Oktober 9:00 - 4 November 9:00(GMT+8), semua gameplay aktivitas dapat diikuti.\n2,4 November 9:00 - 11 November 9:00(GMT+8), hanya dapat mengikuti \"Analisis Kepribadian\" dan Hadiah Pencapaian.\n\n<Title:Kode Memori>\n1,\"Kode Memori\" berisi 5 tingkat, setiap 2 hari akan otomatis membuka 1 tingkat.\n2, Setiap tantangan akan menghabiskan \"Menophin\" × 120, keberhasilan tantangan akan mendapatkan mata uang aktivitas.\n3, Setelah menyelesaikan tingkat, fungsi \"Reproduksi\" pada tingkat tersebut akan terbuka. Harap diperhatikan: saat menggunakan fungsi \"Reproduksi\", Affiniti tidak dapat diperoleh.\n4, Kamu dapat menggunakan Bantuan Tempur Asosiasi Alumni dan \"Resonansi: Sindrom Disosiatif\" untuk membantu kamu melewati tingkat dengan lebih mudah.\n\n<Title:Bonus Rasional>\n1, Jika Penjaga memiliki Tubuh Terjaga atau Roda Takdir tertentu(tidak perlu dipasang), maka \"Puzzle Kenangan\" dalam hadiah misi tingkat \"Kode Memori\" akan mendapatkan bonus drop tambahan, detail bonus sebagai berikut:\n·Tubuh Terjaga \"24\": Mencerahkan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda Takdir SSR \"Restitusi Tubuh Terdistorsi\": Posisi Tumpuk 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda Takdir SR \"Tekad Sang Kod Perak\": Posisi Tumpuk 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n2,\"Bonus Rasional\" dari Tubuh Terjaga atau Roda Takdir yang berbeda dihitung secara kumulatif.\n3, Khusus, hadiah tantangan pertama kali pada tingkat Kegilaan tidak akan terpengaruh oleh \"Bonus Rasional\".\n\n<Title:Resonansi: Sindrom Disosiatif>\n1, Penjaga dapat memperoleh \"Hati yang terbelah\" dengan menyelesaikan pencapaian aktivitas.\n2, Gunakan \"Hati yang terbelah\" untuk mengaktifkan \"Resonansi: Sindrom Disosiatif\", dan dapatkan bonus berikut:\n(1)Membuat Penjaga menjadi lebih kuat dalam gameplay aktivitas \"Kode Memori\" dan \"Rekam Jejak Satuan Tugas: Fisi Damai\", sehingga tantangan menjadi lebih mudah.\n(2)Meningkatkan hadiah yang diperoleh setelah menyelesaikan tantangan \"Kode Memori\".\n(3)Mengaktifkan gameplay aktivitas \"Penyimpanan Tepi\".\n\n<Title: Penyimpanan Tepi>\n1, Setelah mengaktifkan Resonansi \"Diagnosis: Skizofrenia\", setiap jam secara otomatis mendapatkan 60 \"Puzzle Memori α\", maksimal tersimpan selama 25 jam.\n2, Setelah mengaktifkan Resonansi \"Kesadaran Bersama\", setiap jam secara otomatis mendapatkan 30 \"Puzzle Memori β\", maksimal tersimpan selama 25 jam.\n\n<Title:Rekam Jejak Satuan Tugas>\n1, Selama aktivitas berlangsung,\"Rekam Jejak Satuan Tugas: Fisi Damai\" dapat dibuka secara gratis.\n2, Setelah aktivitas berakhir, progres investigasi \"Rekam Jejak Satuan Tugas: Fisi Damai\" akan dipertahankan. Menyelesaikan peristiwa investigasi yang belum selesai selama aktivitas juga dapat memperoleh hadiah investigasi yang sama seperti selama aktivitas. Jika \"Rekam Jejak Satuan Tugas: Fisi Damai\" belum dibuka selama aktivitas, setelah aktivitas berakhir masih dapat dibuka dengan menggunakan \"Titik awal realitas\" × 7.\n3, Baik selama aktivitas maupun tidak, setelah menyelesaikan \"Rekam Jejak Satuan Tugas: Fisi Damai\" dapat memperoleh \"Posse: Semua Tentang\" Dia \"\".\n\n<Title:Kompensasi Rerun>\n1, Penjaga yang sebelumnya telah membuka \"Rekam Jejak Satuan Tugas: Fisi Damai\", saat membuka kembali selama aktivitas rerun ini akan mendapatkan kompensasi \"Puzzle Memori α\" × 700.\n2, Penjaga yang sebelumnya telah mendapatkan avatar terbatas aktivitas \"Atas nama Kunci Perak:\" 24 \"\", saat mendapatkannya kembali akan otomatis dikonversi menjadi \"Puzzle Memori α\" × 2000.\n3, Penjaga yang sebelumnya telah mendapatkan material aktivasi resonansi \"Hati yang terbelah\", setiap 1 \"Hati yang terbelah\" berlebih yang diperoleh akan otomatis dikonversi menjadi \"Rose Scrip\" × 5000."
  },
  Activity_56435_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_56436_ActivityName = {
    Text = "Perjamuan yang Membara · Rerun"
  },
  Activity_56436_ActivityPlot = {
    Text = [[
Isarau, Kota di Danau, dikatakan sebagai Rumah Wanda. 
 Kali ini kamu akan melewati gerbang Mimpi, mencapai kelompok menara kuno yang dipenuhi dengan lidah lonceng...]]
  },
  Activity_56436_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Peti harta Wanda\""
  },
  Activity_56436_ActivityTips = {
    Text = "<Title:Pengenalan Event>\n1. Selama event berlangsung, Penjaga Rahasia dapat mengumpulkan mata uang event \"Tibia Asli\", \"Ammonit Daun Bulat\", dan \"Reruntuhan Spiral\" melalui mode terbatas waktu \"Perjamuan yang Membara\" dan \"Hadiah Pencapaian\". Mata uang event dapat digunakan untuk membeli barang di \"Peti Harta Langka Wanda\", termasuk Roda Takdir SR edisi terbatas event \"Tatapan Isarau\", Inti Lumen, Inti Murni, dan lainnya.\n2. Selama event berlangsung, \"Penyelaman Kesadaran: Perjamuan yang Membara\" dapat dibuka secara gratis untuk waktu terbatas. Selesaikan pencapaian event untuk mendapatkan avatar edisi terbatas event \"Atas Nama Kunci Perak: Wanda\"!\n\n<Title:Waktu Event>\n1. 23 September 9:00 - 7 Oktober 9:00 (GMT+8), semua mode event dapat diikuti.\n2. 7 Oktober 9:00 - 14 Oktober 9:00 (GMT+8), hanya \"Peti Harta Langka Wanda\" dan Hadiah Pencapaian yang dapat diikuti.\n\n<Title:Kota di Dalam Danau>\n1. \"Kota di Dalam Danau\" memiliki 7 stage, setiap hari otomatis membuka 1 stage.\n2. Setiap tantangan akan mengonsumsi \"Spiritpeptida\" × 120, tantangan berhasil akan memberikan mata uang event.\n3. Setelah stage diselesaikan, fungsi \"Pemutaran Ulang\" stage tersebut akan terbuka. Perhatian: Saat menggunakan fungsi \"Pemutaran Ulang\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Kamu dapat menggunakan bantuan Asosiasi Alumni dan \"Resonansi: Perintah Rahasia Perwakilan\" untuk membantumu menyelesaikan stage dengan lebih mudah.\n\n<Title:Bonus Harta Langka>\n1. Penjaga Rahasia yang memiliki Awakener atau Roda Takdir tertentu (tidak harus diturunkan) dapat memperoleh bonus drop tambahan untuk mata uang event dari hadiah misi stage \"Kota di Dalam Danau\". Detail bonus sebagai berikut:\n·Awakener \"Wanda\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda Takdir SSR \"Dekrit Sang Ratu\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda Takdir SR \"Tatapan Isarau\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n2. \"Bonus Harta Langka\" dari Awakener atau Roda Takdir yang berbeda dihitung secara kumulatif. \n3. Khususnya, hadiah tantangan pertama kali tingkat kesulitan Gila tidak akan terpengaruh oleh \"Bonus Harta Langka\".\n\n<Title:Resonansi: Perintah Rahasia Perwakilan>\n1. Penjaga Rahasia dapat memperoleh \"Hati Kesenangan\" dengan menyelesaikan pencapaian event.\n2. Konsumsi \"Hati Kesenangan\" untuk mengaktifkan \"Resonansi: Perintah Rahasia Perwakilan\", yang dapat membuat Penjaga Rahasia menjadi lebih kuat di \"Kota di Dalam Danau\" sehingga tantangan lebih mudah; juga dapat memberikan mata uang event tambahan saat menyelesaikan stage.\n\n<Title:Penyelaman Kesadaran>\n1. Selama event berlangsung, \"Perjamuan yang Membara\" dapat dibuka secara gratis.\n2. Setelah event berakhir, progres investigasi \"Perjamuan yang Membara\" akan disimpan. Menyelesaikan event investigasi yang belum selesai selama event tetap dapat memberikan hadiah investigasi yang sama seperti saat event berlangsung. Jika \"Perjamuan yang Membara\" tidak dibuka selama event, setelah event berakhir masih dapat dibuka dengan mengonsumsi \"Titik Awal Realitas\" × 3.\n3. Baik selama maupun di luar periode event, menyelesaikan \"Perjamuan yang Membara\" akan memberikan \"Perintah Kunci: Perjamuan Busuk\".\n\n<Title:Kompensasi Rerun>\n1. Penjaga Rahasia yang sebelumnya sudah membuka \"Penyelaman Kesadaran: Perjamuan yang Membara\" akan menerima kompensasi \"Tibia Asli\" × 300 saat membuka kembali selama event rerun ini.\n2. Penjaga Rahasia yang sebelumnya sudah mendapatkan avatar edisi terbatas event \"Atas Nama Kunci Perak: Wanda\", saat mendapatkannya kembali akan otomatis dikonversi menjadi \"Tibia Asli\" × 2000.\n3. Penjaga Rahasia yang sebelumnya sudah mendapatkan material aktivasi resonansi \"Hati Kesenangan\", setiap 1 \"Hati Kesenangan\" berlebih yang diperoleh akan otomatis dikonversi menjadi \"Voucher Emas Mawar\" × 5000.\n"
  },
  Activity_56436_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_56477_ActivityName = {Text = "Profanasi"},
  Activity_56478_ActivityName = {
    Text = "Selamat berburu!"
  },
  Activity_56479_ActivityName = {
    Text = "Penggembala Jiwa"
  },
  Activity_56480_ActivityName = {Text = "Pesta Api"},
  Activity_56481_ActivityName = {
    Text = "Pendatang Kembali Elworth"
  },
  Activity_56482_ActivityName = {Text = "Fisi Damai"},
  Activity_59841_ActivityName = {
    Text = "Paket Pertumbuhan Super Hemat (Tidak Digunakan Lagi)"
  },
  Activity_59841_ActivityPlot = {
    Text = [[
Setelah membeli, "Daphodel" dapat bertumbuh hingga
<BlueQuality:Lv50>, <BlueQuality:Semua Skill Lv4>]]
  },
  Activity_59842_ActivityName = {
    Text = "Paket Pertumbuhan Super Hemat (Tidak Digunakan Lagi)"
  },
  Activity_59842_ActivityPlot = {
    Text = [[
Setelah membeli, "Wanda" dapat bertumbuh hingga
<BlueQuality:Lv50>, <BlueQuality:Semua Skill Lv4>]]
  },
  Activity_59843_ActivityName = {
    Text = "Paket Pertumbuhan Super Hemat (Tidak Digunakan Lagi)"
  },
  Activity_59843_ActivityPlot = {
    Text = [[
Setelah membeli, "Tulu" dapat bertumbuh hingga
<BlueQuality:Lv50>, <BlueQuality:Semua Skill Lv4>]]
  },
  Activity_59844_ActivityName = {
    Text = "Paket Pertumbuhan Super Hemat (Tidak Digunakan Lagi)"
  },
  Activity_59844_ActivityPlot = {
    Text = [[
Setelah membeli, "Thais" dapat berkembang hingga
<BlueQuality:Lv50>, <BlueQuality:Semua Skill Lv4>]]
  },
  Activity_59845_ActivityName = {
    Text = "Paket Pertumbuhan Super Hemat (Tidak Digunakan Lagi)"
  },
  Activity_59845_ActivityPlot = {
    Text = [[
Setelah membeli, "Miriam" dapat berkembang hingga
<BlueQuality:Lv50>, <BlueQuality:Semua Skill Lv4>]]
  },
  Activity_59846_ActivityName = {
    Text = "Paket Pertumbuhan Super Hemat (Tidak Digunakan Lagi)"
  },
  Activity_59846_ActivityPlot = {
    Text = [[
Setelah membeli, "Hamelin" dapat berkembang hingga
<BlueQuality:Lv50>, <BlueQuality:Semua Skill Lv4>]]
  },
  Activity_59847_ActivityName = {
    Text = "Persembahan Kenangan Perjalanan VIII"
  },
  Activity_59847_ActivityPlot = {
    Text = "Sebuah memori tersegel dan diarsipkan, sebuah perjalanan tercatat dalam masa lalu. Saat mengenang, jangan lupa persembahkan penghormatan yang tulus."
  },
  Activity_59848_ActivityName = {
    Text = "Persembahan Kenangan Perjalanan III"
  },
  Activity_59848_ActivityPlot = {
    Text = "Sebuah memori tersegel dan diarsipkan, sebuah perjalanan tercatat dalam masa lalu. Saat mengenang, jangan lupa persembahkan penghormatan yang tulus."
  },
  Activity_59849_ActivityName = {
    Text = "Paket Pertumbuhan Super Hemat (Tidak Digunakan Lagi)"
  },
  Activity_59849_ActivityPlot = {
    Text = "Setelah membeli, \"Blood Chain·Shilo\" dapat berkembang hingga\n<BlueQuality:Lv50>, <BlueQuality:Semua Skill Lv4>"
  },
  Activity_59850_ActivityName = {
    Text = "Persembahan Kenangan Perjalanan I"
  },
  Activity_59850_ActivityPlot = {
    Text = "Sebuah memori tersegel dan diarsipkan, sebuah perjalanan tercatat dalam masa lalu. Saat mengenang, jangan lupa persembahkan penghormatan yang tulus."
  },
  Activity_59851_ActivityName = {
    Text = "Persembahan Kenangan Perjalanan·Prolog"
  },
  Activity_59851_ActivityPlot = {
    Text = "Sebuah memori tersegel dan diarsipkan, sebuah perjalanan tercatat dalam masa lalu. Saat mengenang, jangan lupa persembahkan penghormatan yang tulus."
  },
  Activity_59852_ActivityName = {
    Text = "Persembahan Kenangan Perjalanan VII"
  },
  Activity_59852_ActivityPlot = {
    Text = "Sebuah memori tersegel dan diarsipkan, sebuah perjalanan tercatat dalam masa lalu. Saat mengenang, jangan lupa persembahkan penghormatan yang tulus."
  },
  Activity_59853_ActivityName = {
    Text = "Persembahan Kenangan Perjalanan VI"
  },
  Activity_59853_ActivityPlot = {
    Text = "Sebuah memori tersegel dan diarsipkan, sebuah perjalanan tercatat dalam masa lalu. Saat mengenang, jangan lupa persembahkan penghormatan yang tulus."
  },
  Activity_59854_ActivityName = {
    Text = "Persembahan Kenangan Perjalanan V"
  },
  Activity_59854_ActivityPlot = {
    Text = "Sebuah memori tersegel dan diarsipkan, sebuah perjalanan tercatat dalam masa lalu. Saat mengenang, jangan lupa persembahkan penghormatan yang tulus."
  },
  Activity_59855_ActivityName = {
    Text = "Persembahan Kenangan Perjalanan IV"
  },
  Activity_59855_ActivityPlot = {
    Text = "Sebuah memori tersegel dan diarsipkan, sebuah perjalanan tercatat dalam masa lalu. Saat mengenang, jangan lupa persembahkan penghormatan yang tulus."
  },
  Activity_59856_ActivityName = {
    Text = "Paket Pertumbuhan Super Hemat (Tidak Digunakan Lagi)"
  },
  Activity_59856_ActivityPlot = {
    Text = [[
Setelah membeli, "Murphy" dapat bertumbuh hingga
<BlueQuality:Lv50>, <BlueQuality:Semua Skill Lv4>]]
  },
  Activity_59857_ActivityName = {
    Text = "Paket Pertumbuhan Super Hemat (Tidak Digunakan Lagi)"
  },
  Activity_59857_ActivityPlot = {
    Text = [[
Setelah membeli, "Lake" dapat berkembang hingga
<BlueQuality:Lv50>, <BlueQuality:Semua Skill Lv4>]]
  },
  Activity_59858_ActivityName = {
    Text = "Persembahan Kenangan Perjalanan II"
  },
  Activity_59858_ActivityPlot = {
    Text = "Sebuah memori tersegel dan diarsipkan, sebuah perjalanan tercatat dalam masa lalu. Saat mengenang, jangan lupa persembahkan penghormatan yang tulus."
  },
  Activity_59859_ActivityName = {
    Text = "Paket Pertumbuhan Super Hemat (Tidak Digunakan Lagi)"
  },
  Activity_59859_ActivityPlot = {
    Text = [[
Setelah membeli, "Sorrel" dapat bertumbuh hingga
<BlueQuality:Lv50>, <BlueQuality:Semua Skill Lv4>]]
  },
  Activity_59860_ActivityName = {
    Text = "Paket Pertumbuhan Super Hemat (Tidak Digunakan Lagi)"
  },
  Activity_59860_ActivityPlot = {
    Text = [[
Setelah membeli, "Aurla" dapat berkembang hingga
<BlueQuality:Lv50>, <BlueQuality:Semua Skill Lv4>]]
  },
  Activity_59861_ActivityName = {
    Text = "Paket Pertumbuhan Super Hemat (Tidak Digunakan Lagi)"
  },
  Activity_59861_ActivityPlot = {
    Text = [[
Setelah membeli, "Salvador" dapat berkembang hingga
<BlueQuality:Lv50>, <BlueQuality:Semua Skill Lv4>]]
  },
  Activity_59862_ActivityName = {
    Text = "Paket Pertumbuhan Super Hemat (Tidak Digunakan Lagi)"
  },
  Activity_59862_ActivityPlot = {
    Text = [[
Setelah membeli, "Tavi" dapat berkembang hingga
<BlueQuality:Lv50>, <BlueQuality:Semua Skill Lv4>]]
  },
  Activity_59863_ActivityName = {
    Text = "Paket Pertumbuhan Super Hemat (Tidak Digunakan Lagi)"
  },
  Activity_59863_ActivityPlot = {
    Text = [[
Setelah membeli, "Lily" dapat bertumbuh hingga
<BlueQuality:Lv50>, <BlueQuality:Semua Skill Lv4>]]
  },
  Activity_59864_ActivityName = {
    Text = "Paket Pertumbuhan Super Hemat (Tidak Digunakan Lagi)"
  },
  Activity_59864_ActivityPlot = {
    Text = [[
Setelah dibeli,"" 24 "" dapat tumbuh menjadi
<BlueQuality:Lv50>, <BlueQuality:Semua Skill Lv4>]]
  },
  Activity_59865_ActivityName = {
    Text = "Paket Pertumbuhan Super Hemat (Tidak Digunakan Lagi)"
  },
  Activity_59865_ActivityPlot = {
    Text = "Setelah membeli, \"Origin·Dor\" dapat berkembang hingga\n<BlueQuality:Lv50>, <BlueQuality:Semua Skill Lv4>"
  },
  Activity_61156_ActivityName = {
    Text = "Perjalanan Akhir"
  },
  Activity_61156_ActivityTips = {
    Text = [[
Aturan Event:
1. Setelah Penjaga Rahasia menyelesaikan misi Chronicle yang ditentukan, hadiah dapat diklaim di "Chronicle Akhir Zaman".
2. "Chronicle Akhir Zaman" dibuka secara permanen.
3. Setelah membuka "Chronicle Lanjutan", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
4. Perhatian: "Chronicle Lanjutan" yang dibuka dalam event ini hanya berlaku di event ini. Penjaga Rahasia diharapkan membelanjakan secara bijak.]]
  },
  Activity_61369_ActivityName = {
    Text = "Irama Progresif"
  },
  Activity_61369_ActivityPlot = {
    Text = "Penjaga Rahasia dapat memilih salah satu dari Roda Takdir limited berikut untuk dibangkitkan!"
  },
  Activity_61369_ActivityTips = {
    Text = "<Title:Pengantar>\nBlack Pool penuh misteri, Fate Wheel berputar tanpa henti. Di bawah alunan melodi Hamelin, melodi tak terbatas berpadu, menyatu menjadi Fate Wheel dari perjalanan yang telah kamu tempuh. Semoga bantuan mereka menemanimu hingga tanda istirahat sonata terakhir.\n\n<Title:Aturan Event>\n·Selama event berlangsung, cukup login satu hari untuk memilih dan membangkitkan salah satu dari 12 Fate Wheel edisi terbatas berikut:\"Kidung Sang Raja Dewa\",\"Koleksi Paling Berharga\",\"Atas Nama Mawar\",\"Melampaui Rasa Sakit\",\"Kelahiran Tersembunyi\",\"Perintah Sang Ratu\",\"Prasasti Sabda Ilahi\",\"Tubuh Cacat Memakan Balik\",\"Kekuatan Agung nan Khusyuk\",\"Akhir Bait Puisi\",\"Asuhan Penuh Belas Kasih\",\"Waktu Keberuntungan\"."
  },
  Activity_61369_BannerText = {
    Text = "Klaim Roda Takdir Limited Gratis"
  },
  Activity_61370_ActivityName = {
    Text = "Jantung Perak"
  },
  Activity_61370_ActivityPlot = {
    Text = "Login harian untuk mengklaim Fate Wheel SSR edisi peringatan terbatas\"Hati Perak Murni\", total dapat diklaim 16 buah!"
  },
  Activity_61370_ActivityTips = {
    Text = "<Title:Pengantar>\nTak peduli bagaimana dunia runtuh, selama setiap orang menjaga hati perak murni yang paling awal dan jernih, cerita akan terus berputar kembali, dan kehidupan baru akan terlahir kembali di tanah yang tandus.\n\n<Title:Aturan Event>\n·Selama event berlangsung, Keeper dapat mengklaim Fate Wheel SSR edisi peringatan terbatas\"Hati Perak Murni\"setiap hari setelah login di\"Hati Perak Murni\", total dapat diklaim 16 kali.\n·Hadiah akan dibuka secara berurutan berdasarkan login kumulatif Keeper, hadiah login harian akan direset pada pukul 9:00 (GMT+8)."
  },
  Activity_61370_BannerText = {
    Text = "Klaim Fate Wheel SSR Terbatas Gratis"
  },
  Activity_61371_ActivityName = {
    Text = "Harapan Enam Sayap Mekar Sempurna"
  },
  Activity_61371_ActivityPlot = {
    Text = "Di tengah gejolak Black Pool, Silver Core dari dimensi tak terbatas berjatuhan di tepi Black Pool melalui celah dimensi. Tavi mengumpulkannya dengan penuh perhatian dan meletakkannya di sudut Black Pool. Meskipun Silver Core ini tidak dapat menghentikan penyebaran Erosi, kerinduan dan perasaan yang tersimpan di dalamnya akan selalu bersinar cemerlang."
  },
  Activity_61371_ActivityTips = {
    Text = "<Title:Pengantar>\nDi tengah gejolak Black Pool, Silver Core dari dimensi tak terbatas berjatuhan di tepi Black Pool melalui celah dimensi. Tavi mengumpulkannya dengan penuh perhatian dan meletakkannya di sudut Black Pool. Meskipun Silver Core ini tidak dapat menghentikan penyebaran Erosi, kerinduan dan perasaan yang tersimpan di dalamnya akan selalu bersinar cemerlang.\n\n<Title:Aturan Event>\n·Selama event berlangsung, Keeper dapat mengklaim\"Silver Core\"× 1000 setiap hari setelah login, maksimal 6 kali.\n·Selama event berlangsung, jika Keeper login kumulatif selama 7 hari, dapat langsung mengklaim Awakened Form edisi terbatas periode ini\"Tavi\"!\n·Hadiah akan dibuka secara berurutan berdasarkan login kumulatif Keeper, hadiah login harian akan direset pada pukul 9:00 (GMT+8)."
  },
  Activity_61371_BannerText = {
    Text = "Check-in untuk Klaim Silver Core Berlimpah"
  },
  Activity_61482_ActivityName = {
    Text = "Persembahan Peringatan Kenaikan V"
  },
  Activity_61482_ActivityPlot = {
    Text = [[
Jalan panjang membentang, melebur kegelapan.
Cahaya Kunci Perak akan menuntun kita.]]
  },
  Activity_61483_ActivityName = {
    Text = "Persembahan Peringatan Kenaikan IV"
  },
  Activity_61483_ActivityPlot = {
    Text = [[
Jalan panjang membentang, melebur kegelapan.
Cahaya Kunci Perak akan menuntun kita.]]
  },
  Activity_61484_ActivityName = {
    Text = "Hadiah Peringatan Promosi VII"
  },
  Activity_61484_ActivityPlot = {
    Text = [[
Jalan panjang membentang, melebur kegelapan.
Cahaya Kunci Perak akan menuntun kita.]]
  },
  Activity_61485_ActivityName = {
    Text = "Persembahan Peringatan Kenaikan VI"
  },
  Activity_61485_ActivityPlot = {
    Text = [[
Jalan panjang membentang, melebur kegelapan.
Cahaya Kunci Perak akan menuntun kita.]]
  },
  Activity_61486_ActivityName = {
    Text = "Persembahan Peringatan Kenaikan I"
  },
  Activity_61486_ActivityPlot = {
    Text = [[
Jalan panjang membentang, melebur kegelapan.
Cahaya Kunci Perak akan menuntun kita.]]
  },
  Activity_61487_ActivityName = {
    Text = "Persembahan Peringatan Kenaikan III"
  },
  Activity_61487_ActivityPlot = {
    Text = [[
Jalan panjang membentang, melebur kegelapan.
Cahaya Kunci Perak akan menuntun kita.]]
  },
  Activity_61488_ActivityName = {
    Text = "Persembahan Peringatan Kenaikan II"
  },
  Activity_61488_ActivityPlot = {
    Text = [[
Jalan panjang membentang, melebur kegelapan.
Cahaya Kunci Perak akan menuntun kita.]]
  },
  Activity_61489_ActivityName = {
    Text = "Hadiah Peringatan Promosi VIII"
  },
  Activity_61489_ActivityPlot = {
    Text = [[
Jalan panjang membentang, melebur kegelapan.
Cahaya Kunci Perak akan menuntun kita.]]
  },
  Activity_61517_ActivityName = {
    Text = "Kotak Suplai Investigasi"
  },
  Activity_61517_ActivityPlot = {
    Text = "Suplai investigasi yang disediakan oleh Kantor Akademik Mesagoz. Dimurnikan oleh Alistair dari benda-benda terapung di Black Pool."
  },
  Activity_61546_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61546_ActivityPlot = {
    Text = [[
Setelah dibeli, "Tulu" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61547_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61547_ActivityPlot = {
    Text = "Setelah membeli, \"Aurla\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61548_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61548_ActivityPlot = {
    Text = "Setelah membeli, \"Pharos\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61549_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61549_ActivityPlot = {
    Text = [[
Setelah membeli, "Elva" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, Membuka Ledakan Transenden>]]
  },
  Activity_61550_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61550_ActivityPlot = {
    Text = [[
Setelah dibeli, "Jenkin" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61551_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61551_ActivityPlot = {
    Text = [[
Setelah membeli, "Pandea" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, Membuka Ledakan Transenden>]]
  },
  Activity_61552_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61552_ActivityPlot = {
    Text = "Setelah membeli, \"Celeste\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61553_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61553_ActivityPlot = {
    Text = "Setelah dibeli,\"\" 24 \"\" dapat mengaktifkan <BlueQuality:Mencerahkan 3>"
  },
  Activity_61554_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61554_ActivityPlot = {
    Text = "Setelah membeli, \"Feint\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61555_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61555_ActivityPlot = {
    Text = [[
Setelah dibeli, "Tincture" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61556_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61556_ActivityPlot = {
    Text = "Setelah membeli, \"Cassia\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61557_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61557_ActivityPlot = {
    Text = "Setelah membeli, \"Salvador\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61558_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61558_ActivityPlot = {
    Text = [[
Setelah membeli, "Salvador" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61559_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61559_ActivityPlot = {
    Text = "Setelah membeli, \"Taiyi Si\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61560_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61560_ActivityPlot = {
    Text = [[
Setelah membeli, "Lily" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61561_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61561_ActivityPlot = {
    Text = "Setelah membeli, \"Goliath\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61562_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61562_ActivityPlot = {
    Text = "Setelah membeli, \"Lily\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61563_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61563_ActivityPlot = {
    Text = "Setelah membeli, \"Shan\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61564_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61564_ActivityPlot = {
    Text = "Setelah membeli, \"Daffodil\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61565_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61565_ActivityPlot = {
    Text = [[
Setelah dibeli, "Nodira" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61566_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61566_ActivityPlot = {
    Text = "Setelah membeli, \"Galen\" dapat mengaktifkan <BlueQuality:Kebangkitan 3>"
  },
  Activity_61567_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61567_ActivityPlot = {
    Text = "Setelah membeli, \"Elva\" dapat mengaktifkan <BlueQuality:Kebangkitan 3>"
  },
  Activity_61568_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61568_ActivityPlot = {
    Text = "Setelah membeli, \"Rhea\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61569_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61569_ActivityPlot = {
    Text = "Setelah membeli, \"Tulu\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61570_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61570_ActivityPlot = {
    Text = "Setelah membeli, \"Ceyx\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61571_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61571_ActivityPlot = {
    Text = [[
Setelah dibeli, "Winkel" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61572_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61572_ActivityPlot = {
    Text = [[
Setelah membeli, "Wanda" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61573_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61573_ActivityPlot = {
    Text = [[
Setelah dibeli, "Golya" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61574_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61574_ActivityPlot = {
    Text = "Setelah membeli, \"Lake\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61575_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61575_ActivityPlot = {
    Text = "Setelah membeli, \"Nymphia\" dapat mengaktifkan <BlueQuality:Kebangkitan 3>"
  },
  Activity_61576_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61576_ActivityPlot = {
    Text = [[
Setelah dibeli, "Kekesi" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61577_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61577_ActivityPlot = {
    Text = "Setelah membeli, \"Miriam\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61578_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61578_ActivityPlot = {
    Text = [[
Setelah membeli, "Lake" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61579_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61579_ActivityPlot = {
    Text = [[
Setelah dibeli, "Shan" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61580_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61580_ActivityPlot = {
    Text = "Setelah membeli, \"Tincture\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61581_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61581_ActivityPlot = {
    Text = [[
Setelah dibeli, "Rhea" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61582_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61582_ActivityPlot = {
    Text = "Setelah membeli, \"Liz\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61583_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61583_ActivityPlot = {
    Text = [[
Setelah dibeli, "Shilo" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61584_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61584_ActivityPlot = {
    Text = [[
Setelah dibeli, "Cassia" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61585_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61585_ActivityPlot = {
    Text = [[
Setelah dibeli, "Falos" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61586_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61586_ActivityPlot = {
    Text = [[
Setelah dibeli, "Agrippa" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61587_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61587_ActivityPlot = {
    Text = "Setelah membeli, \"Nodira\" dapat mengaktifkan <BlueQuality:Kebangkitan 3>"
  },
  Activity_61588_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61588_ActivityPlot = {
    Text = [[
Setelah dibeli, "Daffodil" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61589_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61589_ActivityPlot = {
    Text = "Setelah membeli, \"Hamelin\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61590_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61590_ActivityPlot = {
    Text = [[
Setelah dibeli, "Liz" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61591_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61591_ActivityPlot = {
    Text = [[
Setelah membeli, "Miriam" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61592_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61592_ActivityPlot = {
    Text = "Setelah membeli, \"Wanda\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61593_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61593_ActivityPlot = {
    Text = [[
Setelah dibeli, "Galen" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61594_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61594_ActivityPlot = {
    Text = "Setelah membeli, \"Yuhashi\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61595_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61595_ActivityPlot = {
    Text = [[
Setelah membeli, "Taiyi Si" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61596_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61596_ActivityPlot = {
    Text = [[
Setelah dibeli, "Yuuhashi" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61597_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61597_ActivityPlot = {
    Text = [[
Setelah membeli, "Hamelin" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61598_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61598_ActivityPlot = {
    Text = "Setelah membeli, \"Murphy\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61599_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61599_ActivityPlot = {
    Text = "Setelah membeli, \"Sorel\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61600_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61600_ActivityPlot = {
    Text = [[
Setelah dibeli, "Soleil" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61601_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61601_ActivityPlot = {
    Text = "Setelah membeli, \"Shilo\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61602_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61602_ActivityPlot = {
    Text = [[
Setelah membeli, "Orlah" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61603_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61603_ActivityPlot = {
    Text = "Setelah membeli, \"Tavi\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61604_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61604_ActivityPlot = {
    Text = [[
Setelah dibeli,"" 24 "" dapat mengaktifkan
<BlueQuality:Pengembangan Kepribadian +4, Buka Kunci Ledakan Melampaui Batas>]]
  },
  Activity_61605_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61605_ActivityPlot = {
    Text = "Setelah membeli, \"Agrippa\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61606_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61606_ActivityPlot = {
    Text = "Setelah membeli, \"Pandea\" dapat mengaktifkan <BlueQuality:Kebangkitan 3>"
  },
  Activity_61607_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61607_ActivityPlot = {
    Text = "Setelah membeli, \"Blood Chain·Shilo\" dapat mengaktifkan\n<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>"
  },
  Activity_61608_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61608_ActivityPlot = {
    Text = "Setelah membeli, \"Jenkin\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61609_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61609_ActivityPlot = {
    Text = [[
Setelah membeli, "Nymphia" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, Membuka Ledakan Transenden>]]
  },
  Activity_61610_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61610_ActivityPlot = {
    Text = "Setelah membeli, \"Winkel\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61611_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61611_ActivityPlot = {
    Text = [[
Setelah dibeli, "Feint" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61612_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61612_ActivityPlot = {
    Text = [[
Setelah membeli, "Murphy" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61613_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61613_ActivityPlot = {
    Text = [[
Setelah membeli, "Tavi" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_61614_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_61614_ActivityPlot = {
    Text = "Setelah membeli, \"Rantai Darah · Shilo\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_61615_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_61615_ActivityPlot = {
    Text = [[
Setelah dibeli, "Celeste" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_65387_ActivityName = {
    Text = "Permintaan Maaf Kucing Sekolah"
  },
  Activity_65387_ActivityPlot = {
    Text = "Baru-baru ini, karena celah dalam langkah perlindungan pihak sekolah, gangguan Erosi berupa <Del:\"Teks Sementara, Titik Merah\"> yang menyerang kampus semakin sering terjadi, menyebabkan banyak ketidaknyamanan bagi para siswa. Oleh karena itu, kantor administrasi sekolah secara khusus mendirikan beberapa titik suplai untuk membagikan perlengkapan kepada para siswa sebagai kompensasi. (Mengingat tanggung jawab atas kesalahan pengelolaan fasilitas, pengangkutan perlengkapan suplai kali ini sepenuhnya ditanggung oleh kucing sekolah.)"
  },
  Activity_65387_ActivityTips = {
    Text = "<Title:Pengantar>\nBaru-baru ini, karena celah dalam langkah perlindungan pihak sekolah, gangguan Erosi berupa <Del:\"Teks Sementara, Titik Merah\"> yang menyerang kampus semakin sering terjadi, menyebabkan banyak ketidaknyamanan bagi para siswa. Oleh karena itu, kantor administrasi sekolah secara khusus mendirikan beberapa titik suplai untuk membagikan perlengkapan kepada para siswa sebagai kompensasi. (Mengingat tanggung jawab atas kesalahan pengelolaan fasilitas, pengangkutan perlengkapan suplai kali ini sepenuhnya ditanggung oleh kucing sekolah.)\n\n<Title:Aturan Event>\n·Selama event berlangsung, Keeper dapat mengklaim\"Silver Core\"× 500 setiap hari setelah login di\"Permintaan Maaf Kucing Sekolah\", maksimal 5 kali.\n·Hadiah akan dibuka secara berurutan berdasarkan login kumulatif Keeper, hadiah login harian akan direset pada pukul 9:00 (GMT+8)."
  },
  Activity_65387_BannerText = {
    Text = "Check-in untuk Klaim Silver Core"
  },
  Activity_65502_ActivityName = {
    Text = "Melodi Progresif·Duet"
  },
  Activity_65502_ActivityPlot = {
    Text = "Penjaga Rahasia dapat memilih salah satu dari Roda Takdir limited berikut untuk dibangkitkan!"
  },
  Activity_65502_ActivityTips = {
    Text = "<Title:Pengantar>\nBlack Pool penuh misteri, Fate Wheel berputar tanpa henti. Di bawah alunan melodi Hamelin, melodi tak terbatas berpadu, menyatu menjadi Fate Wheel dari perjalanan yang telah kamu tempuh. Semoga bantuan mereka menemanimu hingga tanda istirahat sonata terakhir.\n\n<Title:Aturan Event>\n·Selama event berlangsung, cukup login satu hari untuk memilih dan membangkitkan salah satu dari 12 Fate Wheel edisi terbatas berikut:\"Kidung Sang Raja Dewa\",\"Koleksi Paling Berharga\",\"Atas Nama Mawar\",\"Melampaui Rasa Sakit\",\"Kelahiran Tersembunyi\",\"Perintah Sang Ratu\",\"Prasasti Sabda Ilahi\",\"Tubuh Cacat Memakan Balik\",\"Kekuatan Agung nan Khusyuk\",\"Akhir Bait Puisi\",\"Asuhan Penuh Belas Kasih\",\"Waktu Keberuntungan\"."
  },
  Activity_65502_BannerText = {
    Text = "Klaim Roda Takdir Limited Gratis"
  },
  Activity_65521_ActivityName = {
    Text = "Kotak Suplai Investigasi"
  },
  Activity_65521_ActivityPlot = {
    Text = "Suplai investigasi yang disediakan oleh Kantor Akademik Mesagoz. Dimurnikan oleh Alistair dari benda-benda terapung di Black Pool."
  },
  Activity_65949_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65949_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65950_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65950_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65951_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65951_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65952_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65952_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65953_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65953_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65954_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65954_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65955_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65955_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65956_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65956_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65957_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65957_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65958_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65958_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65959_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65959_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65960_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65960_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65961_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65961_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65962_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65962_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65963_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65963_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65964_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65964_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65965_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65965_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65966_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65966_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65967_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65967_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65968_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65968_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65969_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65969_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65970_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65970_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65971_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65971_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65972_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65972_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65973_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65973_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65974_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65974_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65975_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65975_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65976_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65976_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65977_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65977_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65978_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65978_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65979_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65979_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65980_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65980_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65981_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65981_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65982_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65982_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65983_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65983_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65984_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65984_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65985_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65985_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65986_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65986_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65987_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65987_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65988_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65988_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65989_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65989_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65990_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65990_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65991_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65991_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65992_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65992_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65993_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65993_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65994_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65994_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65995_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65995_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65996_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65996_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65997_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65997_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65998_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65998_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_65999_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_65999_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_66000_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_66000_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_66001_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_66001_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_66002_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_66002_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_66003_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_66003_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_66004_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_66004_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_66005_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_66005_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_66006_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_66006_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_66007_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_66007_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_66008_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_66008_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_66009_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_66009_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_66010_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_66010_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_66011_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_66011_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_66012_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_66012_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_66013_ActivityName = {
    Text = "Hadiah Akademi"
  },
  Activity_66013_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mengklaim hadiah check-in harian di "Hadiah Akademi" setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).]]
  },
  Activity_66375_ActivityName = {
    Text = "Pertarungan Penentuan: Bayangan Asal"
  },
  Activity_66375_ActivityPlot = {
    Text = [[
Tatapannya melintasi ribuan dimensi, yang menatapnya adalah ribuan sosok perak. 
Mereka kecil, rapuh. Mereka berjuang untuk diingat, hingga mati tak berhenti]]
  },
  Activity_66375_ActivityStageEndContent = {
    Text = "Kegiatan telah selesai, kamu dapat melanjutkan penyelidikan."
  },
  Activity_66375_ActivityTips = {
    Text = "<Title: Perang Bersama Asli>\n·\"Perang Bersama Asli\" mencakup 7 level yang tidak dapat diulang, langsung menantang pandangan asli, dibuka pada hari pertama acara untuk 3 level pertama, kemudian satu level dibuka setiap 3 hari.\n·Setiap kali menantang dan mengalahkan pandangan asli yang sesuai, kamu akan mendapatkan imbalan yang sesuai.\n·Setiap jenis pandangan asli memiliki banyak klon, setiap kali salah satu jenis pandangan asli ditantang dan dikalahkan oleh Penjaga, jumlah \"Sisa Dunia\" untuk jenis pandangan asli tersebut akan berkurang 1, dan setelah semua klon dari jenis pandangan asli tersebut dihancurkan, level yang bersangkutan akan ditutup dan tidak dapat ditantang lagi.\n·Semua level dipengaruhi oleh \"Arus hitam Bencana·Akhir\", tetapi setiap level akan menyediakan Relik \"Inti Perak\" yang berbeda, yang akan memberikan tambahan kekuatan yang besar. Selain itu, setiap level juga akan menyediakan Relik \"Mata Semua Tahu\", yang akan membuat Tawil mendapatkan 120 Aliemus saat pertempuran dimulai, semua kerusakan yang dihasilkan Tawil, perisai, dan efek pemulihan hidup meningkat 50%.\n·Semua level harus memilih bantuan, selama acara, setiap Penjaga yang saling mengikuti hanya dapat memberikan bantuan satu kali untuk kamu. Karena menggunakan bantuan, imbalan rata-rata akan meningkat 50% di atas imbalan dasar.\n·Penjaga perlu menyelesaikan setidaknya Operasi 2-9 untuk dapat berpartisipasi dalam acara ini.\n\n<Title: Operasi: Bab Akhir>\n·Setiap tubuh dari pandangan asli masih harus dikalahkan oleh kamu sendiri dalam Operasi 9-5 hingga 9-11. Level khusus ini tidak memiliki pencapaian, tidak memiliki jumlah bintang, juga tidak memiliki bantuan Relik \"Mata Semua Tahu\", dan tidak dapat menggunakan bantuan, dan lebih sulit.\n·Setelah acara \"Perang Bersama Asli\" berakhir, level berikutnya dari \"Operasi: Bab Akhir\" akan dibuka. Bersama Penjaga lainnya, setelah menghancurkan semua klon dari berbagai pandangan asli, kamu dapat membuka lebih awal level yang sesuai dalam Operasi 9-5 hingga 9-11."
  },
  Activity_66375_BannerText = {
    Text = "Aktivitas Spesial Dibuka Terbatas!"
  },
  Activity_66908_ActivityName = {
    Text = "Napas Kemakmuran"
  },
  Activity_66908_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Napas Kemakmuran\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Taiyi Si untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_67077_ActivityName = {
    Text = "Persembahan Kenangan Perjalanan IX"
  },
  Activity_67077_ActivityPlot = {
    Text = "Sebuah memori tersegel dan diarsipkan, sebuah perjalanan tercatat dalam masa lalu. Saat mengenang, jangan lupa persembahkan penghormatan yang tulus."
  },
  Activity_67718_ActivityName = {
    Text = "Sebelum Layu di Musim Semi·Reprise"
  },
  Activity_67718_ActivityPlot = {
    Text = [[
Tawa para gadis bergema, menggaung di taman yang belum dijilat api.
Berdirilah sejenak demi masa lalu yang indah ini, wahai sahabatku.
Dengarkanlah musim semi yang belum layu, berbisik menceritakan kisah masa lampau.]]
  },
  Activity_67718_ActivityStageEndContent = {
    Text = "Aktivitas telah berakhir, saat ini hanya dapat berpartisipasi di \"Rumah Bunga Colette\""
  },
  Activity_67718_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1, Selama aktivitas berlangsung, Penjaga dapat mengumpulkan tiga jenis \"Puisi\" melalui gameplay terbatas waktu \"Kebun Kenangan\",\"Ciuman Muse\", dan \"Hadiah Pencapaian\".\"Puisi\" dapat ditukarkan di \"Rumah Bunga Colette\" untuk mendapatkan hadiah item, termasuk Roda takdir SR terbatas aktivitas \"Kenangan Masa Lalu\",\"Inti murni\",\"Inti Lumen\",\"Fragmentasi Batu Bijaksana\",\"Kristal Mimik\", dan lainnya.\n2, Selama aktivitas berlangsung,\"Rekam Jejak Satuan Tugas: Tempat Tinggal Mawar\" akan dibuka secara gratis.\n\n<Title:Waktu Aktivitas>\n1,10 Agustus 9:00 - 7 September 9:00(GMT+8), semua konten aktivitas dapat diikuti.\n2,7 September 9:00 - 14 September 9:00(GMT+8), hanya \"Rumah Bunga Colette\" dan \"Hadiah Pencapaian\" yang dipertahankan, konten lainnya telah berakhir dan tidak dapat diikuti.\n\n<Title: Kebun Kenangan>\n1,\"Kebun Kenangan\" berisi 5 tingkat, setiap 2 hari akan terbuka 1 tingkat secara otomatis.\n2, Setiap tantangan akan menghabiskan \"Menophin\" × 120, dan jika berhasil akan mendapatkan mata uang aktivitas \"puisi penuh kecemasan\",\"Puisi Penyesalan\", dan \"Puisi Bahagia\".\n3, Setelah menyelesaikan tahap, fitur \"Reproduksi\" pada tingkat tersebut akan terbuka. Harap diperhatikan: saat menggunakan fitur \"Reproduksi\", kamu tidak dapat memperoleh Affiniti.\n4, Kamu dapat menggunakan Bantuan Bertarung dari asosiasi alumni dan \"Resonansi: Elegi Taman\" untuk membantu kamu menyelesaikan tahap dengan lebih mudah.\n5, Pada hari ke-2 setelah tingkat terbuka, Kegilaan pada tingkat tersebut akan terbuka. Menyelesaikan pertama kali pada Kegilaan dapat memperoleh hadiah mata uang aktivitas yang melimpah.\n6, Harap diperhatikan: tantangan Kegilaan tidak menghabiskan Menophin, tidak dapat direproduksi, dan setelah menyelesaikan pertama kali, tantangan berulang tidak akan mendapatkan hadiah mata uang aktivitas lagi.\n\n<Title: Bonus Puisi>\n1, Penjaga yang memiliki Tubuh Terjaga atau Roda takdir tertentu(tidak perlu dipasang) dapat memperoleh bonus drop tambahan untuk \"puisi penuh kecemasan\",\"Puisi Penyesalan\", dan \"Puisi Bahagia\" dalam hadiah misi tingkat \"Kebun Kenangan\"(termasuk Reproduksi), detail bonus sebagai berikut:\n·Tubuh Terjaga \"Horla\": Mencerahkan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda takdir SSR \"Syair Terakhir\": Posisi Tumpuk 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda takdir SR \"Kenangan Masa Lalu\": Posisi Tumpuk 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2,\"Bonus Puisi\" dari berbagai Tubuh Terjaga atau Roda takdir dihitung secara kumulatif.\n3, Khususnya, hadiah tantangan pertama kali pada Kegilaan tidak akan terpengaruh oleh \"Bonus Puisi\".\n\n<Title:Resonansi: Elegi Taman>\n1, Penjaga dapat memperoleh \"Hati Abu\" dengan menyelesaikan pencapaian aktivitas.\n2, Dengan menghabiskan \"Hati Abu\", aktifkan \"Resonansi: Elegi Taman\", kamu dapat memperoleh bonus berikut:\n(1) Membuat Penjaga menjadi lebih kuat dalam gameplay aktivitas \"Kebun Kenangan\", sehingga tantangan menjadi lebih mudah.\n(2) Meningkatkan mata uang aktivitas yang diperoleh setelah menyelesaikan tantangan \"Kebun Kenangan\".\n(3) Mengaktifkan gameplay aktivitas \"Ciuman Muse\".\n\n<Title: Ciuman Muse>\n·Setelah mengaktifkan Resonansi \"Segalanya tumbuh\", setiap jam secara otomatis mendapatkan \"puisi penuh kecemasan\" × 60, maksimal tersimpan selama 25 jam.\n·Setelah mengaktifkan Resonansi \"Mengganti puisi dengan bunga\",\"Ciuman Muse\" setiap jam dapat memperoleh tambahan \"Puisi Penyesalan\" × 60.\n\n<Title: Rumah Bunga Colette>\n1,\"Rumah Bunga Colette\" memiliki tiga kebun bunga, dengan waktu pembukaan sebagai berikut:\n·\"Kebun Bunga Iris\": Dibuka pukul 9 tanggal 10 Agustus.\n·\"Kebun Bunga Platycodon\": Dibuka pukul 9 tanggal 12 Agustus.\n·\"Kebun Bunga Mawar\": Dibuka pukul 9 tanggal 14 Agustus.\n2, Setiap penukaran akan menghabiskan \"puisi penuh kecemasan\"/\"Puisi Penyesalan\"/\"Puisi Bahagia\" × 750, dan secara acak mendapatkan lima hadiah item dari kebun bunga.\n3, Hadiah item setiap kebun bunga dibagi menjadi dua jenis:\"Item Spesial\" dan \"Item Umum\". Saat reset, jumlah tersisa hadiah Item Spesial dapat direset ke batas maksimum, aturan spesifiknya adalah:\n(1) 2 reset pertama: Ketika \"Item Spesial\" tidak memiliki jumlah tersisa, Penjaga dapat memilih untuk mereset, setelah reset jumlah tersisa \"Item Spesial\" dan \"Item Umum\" akan direset ke batas maksimum; atau dapat memilih untuk melanjutkan penukaran, ketika \"Item Umum\" juga tidak memiliki jumlah tersisa, harus melakukan reset untuk dapat melanjutkan penukaran.\n(2) Mulai reset ke-3: Reset hanya dapat dilakukan ketika \"Item Umum\" tidak memiliki jumlah tersisa, reset akan mereset jumlah tersisa \"Item Umum\" ke batas maksimum,\"Item Spesial\" tidak akan direset lagi.\n4, Setelah 14 September 9:00(GMT+8),\"Puisi\" yang tersisa dan belum ditukarkan akan dikumpulkan kembali dengan rasio setiap penukaran mendapatkan Rose Scrip × 40, harap Penjaga memperhatikan untuk memeriksa email.\n\n<Title: Rekam Jejak Satuan Tugas>\n1, Selama aktivitas berlangsung,\"Rekam Jejak Satuan Tugas: Tempat Tinggal Mawar\" akan dibuka secara gratis. Setiap 2 hari akan ada kejadian baru, setelah menyelesaikan tahap \"Rekam Jejak Satuan Tugas: Tempat Tinggal Mawar\" kamu dapat memperoleh hadiah Perak, Roda takdir SR terbatas aktivitas \"Kenangan Masa Lalu\", dan lainnya di Hadiah Pencapaian. Hadiah Pencapaian hanya dibuka selama aktivitas berlangsung, setelah aktivitas berakhir tidak dapat diselesaikan dan diklaim.\n2, Setelah aktivitas berakhir, progres investigasi \"Rekam Jejak Satuan Tugas: Tempat Tinggal Mawar\" akan Retain. Jika \"Rekam Jejak Satuan Tugas: Tempat Tinggal Mawar\" belum dibuka selama aktivitas, setelah aktivitas berakhir masih dapat menghabiskan \"Titik awal realitas\" ×7 untuk membukanya.\n3, Baik selama aktivitas maupun tidak, setelah menyelesaikan tahap \"Rekam Jejak Satuan Tugas: Tempat Tinggal Mawar\" kamu dapat memperoleh \"Posse: Syair Musim Semi\"."
  },
  Activity_67718_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_67719_ActivityName = {
    Text = "Promo Pembukaan Acara Pengakuan Cinta"
  },
  Activity_67721_ActivityName = {
    Text = "Sebelum Layu di Musim Semi·Reprise"
  },
  Activity_67721_ActivityPlot = {
    Text = [[
Tawa para gadis bergema, menggaung di taman yang belum dijilat api.
Berdirilah sejenak demi masa lalu yang indah ini, wahai sahabatku.
Dengarkanlah musim semi yang belum layu, berbisik menceritakan kisah masa lampau.]]
  },
  Activity_67721_ActivityStageEndContent = {
    Text = "Aktivitas telah berakhir, saat ini hanya dapat berpartisipasi di \"Rumah Bunga Colette\""
  },
  Activity_67721_ActivityTips = {
    Text = "<Title:Pengantar Aktivitas>\n1. Selama aktivitas berlangsung, Penjaga dapat mengumpulkan tiga jenis \"Puisi\" melalui gameplay terbatasi waktu \"Kebun Kenangan\", \"Ciuman Muse\", dan \"Hadiah Prestasi\". \"Puisi\" dapat digunakan di \"Rumah Bunga Colette\" untuk ditukarkan demi mendapatkan hadiah item, termasuk SR limited aktivitas Roda Takdir \"Bunga dan Puisi dari Masa Lalu\", \"Inti Murni\", \"Inti Lumen\", \"Fragmentasi Batu Bijaksana\", \"Kristal Mimik\", dan lain-lain.\n2. Selama periode aktivitas, \"Rekam Jejak Satuan Tugas: Tempat Tinggal Mawar\" akan tersedia secara gratis.\n\n<Title:Waktu Aktivitas>\n1. 25 Agustus 9:00 - 8 September 9:00 (GMT+8), semua konten aktivitas dapat diikuti.\n2. 8 September 9:00 - 15 September 9:00 (GMT+8), \"Rumah Bunga Colette\" dan \"Hadiah Prestasi\" saja yang tersisa, konten lainnya telah selesai dan tidak dapat diikuti.\n\n<Title:Kebun Kenangan>\n1. \"Kebun Kenangan\" terdiri dari 5 Tingkat, satu tingkat akan terbuka setiap 2 hari secara otomatis.\n2. Setiap kali tantangan akan menghabiskan \"Menophin\" ×120. Jika tantangan berhasil, akan mendapatkan mata uang aktivitas \"puisi penuh kecemasan\", \"Puisi Penyesalan\" dan \"Puisi Bahagia\".\n3. Setelah menyelesaikan tingkat, fitur \"Reproduksi\" tingkat tersebut akan terbuka. Harap diperhatikan: saat menggunakan fitur \"Reproduksi\", Anda tidak akan mendapatkan Affiniti.\n4. Anda dapat menggunakan bantuan teman alumni dan \"Resonansi: Elegi Taman\" untuk membantu Anda menyelesaikan tahap dengan lebih mudah.\n\n<Title:Bonus Puisi>\n1. Penjaga yang memiliki Awakener atau Roda Takdir tertentu (tidak perlu ikut serta dalam pertempuran) dapat meningkatkan bonus drop \"puisi penuh kecemasan\", \"Puisi Penyesalan\", dan \"Puisi Bahagia\" dalam hasil misi tingkat \"Kebun Kenangan\" (termasuk pada Reproduksi). Rincian bonus sebagai berikut:\n·Awakener \"Horla\": Mencerahkan 0/1/2/3 atau lebih, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Syair Terakhir\": Posisi Tumpuk 0/1/2/3 atau lebih, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Bunga dan Puisi dari Masa Lalu\": Posisi Tumpuk 0/1/2/3 atau lebih, bonus 20%/30%/40%/50%\n2. Bonus Puisi yang berasal dari Awakener atau Roda Takdir yang berbeda dihitung dengan cara ditumpuk.\n3. Khususnya, hadiah tantangan pertama pada Kegilaan tidak akan terpengaruh oleh Bonus Puisi.\n\n<Title:Resonansi: Elegi Taman>\n1. Penjaga dapat memperoleh \"Hati Abu\" dengan menyelesaikan prestasi aktivitas.\n2. Dengan menghabiskan \"Hati Abu\" untuk mengaktifkan \"Resonansi: Elegi Taman\", Anda dapat memperoleh bonus berikut:\n(1) Membuat Penjaga menjadi lebih kuat di gameplay aktivitas \"Kebun Kenangan\", sehingga tantangan menjadi lebih mudah.\n(2) Meningkatkan jumlah mata uang aktivitas yang diperoleh setelah menyelesaikan tantangan \"Kebun Kenangan\".\n(3) Mengaktifkan gameplay aktivitas \"Ciuman Muse\".\n\n<Title:Ciuman Muse>\n·Dengan mengaktifkan Resonansi \"Segalanya tumbuh\", setiap jam secara otomatis mendapatkan 60 \"puisi penuh kecemasan\", dengan maksimum penyimpanan hingga 25 jam.\n·Dengan mengaktifkan Resonansi \"Mengganti puisi dengan bunga\", \"Ciuman Muse\" setiap jam dapat menghasilkan tambahan 60 \"Puisi Penyesalan\".\n\n<Title:Rumah Bunga Colette>\n1. \"Rumah Bunga Colette\" memiliki tiga ladang bunga, waktu pembukaan sebagai berikut:\n·\"Ladang Bunga Iris\": Dibuka pada 25 Agustus pukul 9.\n·\"Ladang Bunga Bell\": Dibuka pada 27 Agustus pukul 9.\n·\"Ladang Bunga Mawar\": Dibuka pada 29 Agustus pukul 9.\n2. Setiap kali penukaran akan menghabiskan 750 \"puisi penuh kecemasan\"/\"Puisi Penyesalan\"/\"Puisi Bahagia\", secara acak mendapatkan lima item hadiah di ladang bunga.\n3. Hadiah item dari tiap ladang bunga dibagi menjadi \"Item Spesial\" dan \"Item Umum\". Ketika direset, jumlah sisa item spesial dapat direset ke batas maksimum sesuai dengan aturan berikut:\n(1) Dua reset pertama: Jika \"Item Spesial\" tidak memiliki sisa jumlah, Penjaga dapat memilih reset. Setelah reset, \"Item Spesial\" dan \"Item Umum\" akan kembali ke jumlah maksimum; juga masih bisa lanjut menukar, jika \"Item Umum\" juga habis, reset harus dilakukan untuk melanjutkan penukaran.\n(2) Dari reset ketiga dan seterusnya: Reset hanya dilakukan ketika \"Item Umum\" habis, reset akan mengembalikan jumlah \"Item Umum\" ke batas maksimum, \"Item Spesial\" tidak direset lagi.\n4. Setelah 15 September pukul 9:00 (GMT+8), semua \"Puisi\" yang tersisa tanpa ditukar akan dikembalikan dengan rasio setiap 40 \"Rose Scrip\". Mohon Penjaga untuk memeriksa email Anda.\n\n<Title:Rekam Jejak Satuan Tugas>\n1. Selama aktivitas berlangsung, \"Rekam Jejak Satuan Tugas: Tempat Tinggal Mawar\" akan tersedia secara gratis. Setiap dua hari akan muncul kejadian baru. Penyelesaian \"Rekam Jejak Satuan Tugas: Tempat Tinggal Mawar\" dapat memberikan hadiah seperti Perak, Roda Takdir SR aktivitas limited \"Bunga dan Puisi dari Masa Lalu\", dan lainnya di Hadiah Prestasi. Hadiah Prestasi hanya tersedia selama aktivitas berlangsung, dan tidak dapat diselesaikan atau diambil setelah aktivitas berakhir.\n2. Setelah aktivitas berakhir, progres penyelidikan di \"Rekam Jejak Satuan Tugas: Tempat Tinggal Mawar\" akan Retain. Jika tidak membuka \"Rekam Jejak Satuan Tugas: Tempat Tinggal Mawar\" selama aktivitas berlangsung, dapat tetap membuka dengan menghabiskan \"Titik awal realitas\" ×7 setelah aktivitas berakhir.\n3. Apapun situasinya, setelah menyelesaikan \"Rekam Jejak Satuan Tugas: Tempat Tinggal Mawar\" Anda tetap dapat memperoleh \"Posse: Persembahan Musim Semi\"."
  },
  Activity_67721_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_67723_ActivityName = {
    Text = "Promo Pembukaan Acara Pengakuan Cinta"
  },
  Activity_67725_ActivityName = {
    Text = "Aktivitas penggandaan afinitas"
  },
  Activity_67726_ActivityName = {
    Text = "Gembala Jiwa·Reprise"
  },
  Activity_67726_ActivityPlot = {
    Text = [[
Dia telah menderita untuk kalian, menanggung penderitaan kalian.
Karena Caro yang dia korbankan, kalian menerima penyembuhan;
karena Hidup yang dia berikan, kalian menerima pengampunan.]]
  },
  Activity_67726_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Bazar Amal Gereja\""
  },
  Activity_67726_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1. Selama periode aktivitas, Penjaga dapat mengumpulkan mata uang aktivitas \"Kupon Penjualan Amal\" melalui gameplay terbatas waktu yaitu \"Jalan Gereja\", \"Kebaikan Warga\", dan \"Hadiah Prestasi\". \"Kupon Penjualan Amal\" dapat ditukar dengan barang acak di \"Lokasi Bazar Amal Gereja\", termasuk SR terbatas aktivitas Roda Takdir\"Pria dalam cermin\", Inti murni, Inti Lumen, dan lainnya.\n2. Selama periode aktivitas akan ada pembukaan gratis untuk \"Rekam Jejak Satuan Tugas: Warna darah\". Selesaikan prestasi aktivitas untuk mendapatkan avatar terbatas aktivitas \"Atas nama Kunci Perak: Salvador\"！\n\n<Title:Waktu Aktivitas>\n1. 24 Maret 9:00 - 7 April 9:00 (GMT+8), semua konten aktivitas tersedia untuk diikuti.\n2. 7 April 9:00 - 14 April 9:00 (GMT+8), hanya \"Lokasi Bazar Amal Gereja\" dan \"Hadiah Prestasi\" yang akan tetap tersedia, konten lainnya telah berakhir dan tidak dapat diikuti.\n\n<Title:Jalan Gereja>\n1. \"Jalan Gereja\" terdiri dari 5 Tingkat, setiap 2 hari satu tingkat akan terbuka secara otomatis.\n2. Setiap tantangan akan menghabiskan \"Menophin\"×120, berhasil tantangan akan mendapatkan mata uang aktivitas \"Kupon Penjualan Amal\".\n3. Setelah menyelesaikan tingkat, fitur \"Reproduksi\" tingkat tersebut akan terbuka. Perhatian: saat menggunakan fitur \"Reproduksi\", Affiniti tidak akan diperoleh.\n4. Bisa menggunakan bantuan teman alumni dan \"Resonansi: Persimpangan Jiwa\" untuk membantu kamu menyelesaikan tingkat dengan lebih mudah.\n\n<Title:Tambahan Cahaya>\n1. Dalam pengaruh \"Cahaya Jiwa\", Penjaga yang memiliki Awakener atau Roda takdir tertentu (tidak perlu digunakan dalam tim) dapat meningkatkan jumlah tambahan drop \"Kupon Penjualan Amal\" dalam reward tugas tingkat \"Jalan Gereja\" (termasuk Reproduksi), rincian tambahannya adalah:\n· Awakener \"Salvador\": Mencerahkan0/1/2/3 ke atas, tambahan 20%/30%/40%/50%.\n· SSR Roda Takdir \"Prasasti Kitab Suci\": Posisi Tumpuk0/1/2/3 ke atas, tambahan 20%/30%/40%/50%.\n· SR Roda Takdir \"Pria dalam cermin\": Posisi Tumpuk0/1/2/3 ke atas, tambahan 20%/30%/40%/50%.\n2. Tambahan \"Cahaya\" dari Awakener atau Roda takdir yang berbeda dihitung secara akumulatif.\n3. Secara khusus, reward tantangan pertama dari tingkat dengan Kegilaan tidak akan terpengaruh oleh \"Tambahan Cahaya\".\n\n<Title:Resonansi: Persimpangan Jiwa>\n1. Penjaga dapat memperoleh \"Hati Penitensi\" dengan menyelesaikan prestasi aktivitas.\n2. Menggunakan \"Hati Penitensi\" untuk mengaktifkan \"Resonansi: Persimpangan Jiwa\" memberikan tambahan berikut:\n(1) Membuat Penjaga menjadi lebih kuat dalam aktivitas gameplay \"Jalan Gereja\" dan \"Rekam Jejak Satuan Tugas: Warna darah\", tantangan menjadi lebih mudah.\n(2) Meningkatkan Affiniti yang diperoleh setelah menyelesaikan tantangan \"Jalan Gereja\".\n(3) Mengaktifkan gameplay aktivitas \"Kebaikan Warga\".\n\n<Title:Kebaikan Warga>\n1. Setelah mengaktifkan Resonansi \"cara mudah\", mendapatkan 60 \"Kupon Penjualan Amal\" setiap jam secara otomatis, maksimal menyimpan 25 jam.\n2. Setelah mengaktifkan Resonansi \"Penebusan, Penebusan\", setiap jam otomatis mendapatkan tambahan 1800 Rose Scrip.\n\n<Title:Lokasi Bazar Amal Gereja>\n1. \"Lokasi Bazar Amal Gereja\" memiliki tiga toko, waktu pembukaannya adalah sebagai berikut:\n· \"Toko Kecil Nyonya Grey\": Mulai 24 Maret pukul 9.\n· \"Yohanes Besar dan Bazar Ajaibnya\": Mulai 27 Maret pukul 9.\n· \"Promo Spesial Smith\": Mulai 30 Maret pukul 9.\n2. Setiap kali bertukar akan menghabiskan 750 \"Kupon Penjualan Amal\", secara acak mendapatkan lima barang hadiah dari toko.\n3. Barang dalam toko dibagi menjadi \"Item Spesial\" dan \"Item Umum\", reset dapat membuat jumlah sisa item spesial kembali ke batas maksimal, aturan spesifik adalah:\n(1) Reset pertama dan kedua: Ketika \"Item Spesial\" tidak tersisa, Penjaga dapat memilih reset, setelah reset jumlah sisa \"Item Spesial\" dan \"Item Umum\" kembali ke batas maksimal; juga dapat melanjutkan pertukaran, ketika \"Item Umum\" juga habis tidak ada sisa, harus reset untuk melanjutkan pertukaran.\n(2) Dari reset ke-3: Ketika \"Item Umum\" tidak tersisa, baru dapat melakukan reset, reset akan mengembalikan jumlah sisa \"Item Umum\" ke batas maksimal, sementara \"Item Spesial\" tidak akan direset.\n4. Setelah 14 April pukul 9:00 (GMT+8), sisa \"Kupon Penjualan Amal\" yang belum ditukarkan akan dikonversi menjadi \"Rose Scrip\"×40 untuk setiap satu kupon, mohon Penjaga memperhatikan untuk memeriksa pesan.\n\n<Title:Rekam Jejak Satuan Tugas>\n1. Selama periode aktivitas, \"Rekam Jejak Satuan Tugas: Warna darah\" akan terbuka secara gratis.\n2. Setelah aktivitas berakhir, kemajuan investigasi \"Rekam Jejak Satuan Tugas: Warna darah\" akan Retain, jika belum dibuka selama aktivitas, tetap bisa dibuka dengan menghabiskan \"Titik awal realitas\"×7 setelah aktivitas.\n3. Baik selama atau setelah aktivitas, menyelesaikan tahap \"Rekam Jejak Satuan Tugas: Warna darah\" akan mendapatkan \"Posse: Keajaiban Fajar\".\n\n<Title:Replikasi Kompensasi>\n1. Penjaga yang sebelumnya telah membuka \"Rekam Jejak Satuan Tugas: Warna darah\", selama periode aktivitas replikasi, jika membukanya kembali akan mendapatkan kompensasi \"Kupon Penjualan Amal\"×700.\n2. Penjaga yang sebelumnya telah mendapatkan avatar terbatas aktivitas \"Atas nama Kunci Perak: Salvador\", jika mendapatkannya lagi secara otomatis akan dikonversi menjadi \"Undangan dari Yang Tidak Berbentuk\"×1.\n3. Penjaga yang sebelumnya telah mendapatkan bahan aktivasi resonansi \"Hati Penitensi\", jika mendapatkan 1 \"Hati Penitensi\" yang berlebih akan otomatis dikonversi menjadi \"Rose Scrip\"×5000.\n"
  },
  Activity_67726_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_67727_ActivityName = {
    Text = "Gelombang Keinginan·Reprise"
  },
  Activity_67727_ActivityPlot = {
    Text = "Mimpi adalah pengungkapan keinginan bawah sadar. Mereka yang mengembara dalam mimpi pada akhirnya akan ditangkap oleh lautan keinginan, menjadi pelayan nafsu, kecuali..."
  },
  Activity_67727_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Pertumbuhan Nafsu\""
  },
  Activity_67727_ActivityTips = {
    Text = "<Title:Pengantar Event>\n1. Selama event berlangsung, Penjaga Rahasia dapat mengumpulkan mata uang event \"Inti Benih Berlimpah\" melalui gameplay terbatas \"Nafsu Kacau\" dan \"Hadiah Pencapaian\". \"Inti Benih Berlimpah\" dapat ditukarkan dengan hadiah di \"Tumbuhnya Dosa Nafsu\", termasuk Roda Takdir SR edisi terbatas event \"Ciuman Perpisahan yang Membara\", Inti Lumen, Inti Murni, Serpihan Batu Bijak, Kristal Mimesis, dll.\n2. Selama event berlangsung, persyaratan partisipasi \"Demam Reproduksi\" dilonggarkan menjadi cukup menyelesaikan \"Operasi Investigasi\" 2-9·Normal, dan tidak perlu memenuhi persyaratan Tingkat Sinkronisasi Awakened untuk membuka \"Peristiwa Demam Reproduksi\". Selain itu, jumlah \"Titik Awal Realitas\" yang dibutuhkan juga berkurang menjadi hanya 1!\n3. Kedatangan kekuatan misterius tampaknya membantu kamu membangun hubungan yang lebih dalam dengan Awakened. Selama event berlangsung, Tingkat Sinkronisasi yang diperoleh melalui semua cara akan digandakan!\n\n<Title:Nafsu Kacau>\n1. \"Nafsu Kacau\" berisi 10 stage material pertarungan langsung tanpa eksplorasi, 1 stage dibuka setiap hari.\n2. Di stage material ini, kamu akan langsung membangkitkan semua Awakened dan mendapatkan Construct yang telah ditentukan. Selain itu, setelah 6 ronde, kamu akan menerima 1 kali bantuan dari Tethys.\n3. Setiap tantangan akan mengonsumsi \"Psychube\" × 120. Tantangan yang berhasil akan mendapatkan material pengembangan dan mata uang event.\n4. Setelah stage diselesaikan, fitur \"Tayangan Ulang\" untuk stage tersebut akan terbuka. Perhatian: Saat menggunakan fitur \"Tayangan Ulang\", Tingkat Sinkronisasi tidak dapat diperoleh.\n5. Kamu dapat menggunakan bantuan Alumni untuk membantumu menyelesaikan stage dengan lebih mudah.\n\n<Title:Bonus Nafsu Kuat>\n1. Penjaga Rahasia yang memiliki Awakened atau Roda Takdir tertentu (tidak harus diturunkan) dapat memperoleh bonus drop tambahan untuk \"Inti Benih Berlimpah\" dari hadiah misi stage \"Nafsu Kacau\" (termasuk Tayangan Ulang). Detail bonus sebagai berikut:\n·Awakened \"Tethys\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Pengasuhan Penuh Belas Kasih\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Ciuman Perpisahan yang Membara\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Nafsu Kuat\" dari Awakened atau Roda Takdir yang berbeda dihitung secara kumulatif. \n3. Khususnya, hadiah tantangan pertama kali tingkat kesulitan Gila tidak akan terpengaruh oleh bonus di atas.\n\n<Title: Tumbuhnya Dosa Nafsu>\n1. Setiap \"Tukar Benih\" akan mengonsumsi 1000 \"Inti Benih Berlimpah\" dan secara acak mendapatkan lima hadiah item dari \"Tumbuhnya Dosa Nafsu\".\n3. Hadiah item \"Tumbuhnya Dosa Nafsu\" terbagi menjadi \"Item Spesial\" dan \"Item Biasa\". Saat reset, jumlah sisa hadiah Item Spesial akan dikembalikan ke batas maksimal. Aturan spesifiknya sebagai berikut:\n(1) 4 kali reset pertama: Setelah \"Item Spesial\" tidak memiliki sisa jumlah, Penjaga Rahasia dapat memilih untuk reset. Setelah reset, jumlah sisa \"Item Spesial\" dan \"Item Biasa\" akan dikembalikan ke batas maksimal; atau dapat memilih untuk terus menukar. Setelah \"Item Biasa\" juga tidak memiliki sisa jumlah, reset harus dilakukan untuk melanjutkan penukaran.\n(2) Reset ke-5 dan seterusnya: Reset hanya dapat dilakukan setelah \"Item Biasa\" tidak memiliki sisa jumlah. Reset akan mengembalikan jumlah sisa \"Item Biasa\" ke batas maksimal, \"Item Spesial\" tidak lagi di-reset.\n\n<Title:Waktu Event>\n1. 16 Desember 9:00 - 30 Desember 9:00 (GMT+8), semua konten dalam pengantar event dapat diikuti.\n2. 30 Desember 9:00 - 6 Januari 9:00 (GMT+8), hanya \"Tumbuhnya Dosa Nafsu\" dan \"Hadiah Pencapaian\" yang tersedia, konten lainnya sudah berakhir dan tidak dapat diikuti.\n3. Setelah 6 Januari 9:00 (GMT+8), sisa \"Inti Benih Berlimpah\" yang belum ditukarkan akan dikumpulkan kembali dengan rasio setiap 1 buah ditukar menjadi \"Voucher Emas Mawar\" × 40. Penjaga Rahasia harap periksa email."
  },
  Activity_67727_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_67728_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_67729_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_67731_ActivityName = {
    Text = "Perjamuan yang Membara · Rerun"
  },
  Activity_67731_ActivityPlot = {
    Text = [[
Isarau, Kota di Danau, dikatakan sebagai Rumah Wanda. 
 Kali ini kamu akan melewati gerbang Mimpi, mencapai kelompok menara kuno yang dipenuhi dengan lidah lonceng...]]
  },
  Activity_67731_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Peti harta Wanda\""
  },
  Activity_67731_ActivityTips = {
    Text = "<Title:Pengenalan Event>\n1. Selama event berlangsung, Penjaga Rahasia dapat mengumpulkan mata uang event \"Tibia Asli\", \"Ammonit Daun Bulat\", dan \"Reruntuhan Spiral\" melalui mode terbatas waktu \"Perjamuan yang Membara\" dan \"Hadiah Pencapaian\". Mata uang event dapat digunakan untuk membeli barang di \"Peti Harta Langka Wanda\", termasuk Roda Takdir SR edisi terbatas event \"Tatapan Isarau\", Inti Lumen, Inti Murni, dan lainnya.\n2. Selama event berlangsung, \"Penyelaman Kesadaran: Perjamuan yang Membara\" dapat dibuka secara gratis untuk waktu terbatas. Selesaikan pencapaian event untuk mendapatkan avatar edisi terbatas event \"Atas Nama Kunci Perak: Wanda\"!\n\n<Title:Waktu Event>\n1. 23 September 9:00 - 7 Oktober 9:00 (GMT+8), semua mode event dapat diikuti.\n2. 7 Oktober 9:00 - 14 Oktober 9:00 (GMT+8), hanya \"Peti Harta Langka Wanda\" dan Hadiah Pencapaian yang dapat diikuti.\n\n<Title:Kota di Dalam Danau>\n1. \"Kota di Dalam Danau\" memiliki 7 stage, setiap hari otomatis membuka 1 stage.\n2. Setiap tantangan akan mengonsumsi \"Spiritpeptida\" × 120, tantangan berhasil akan memberikan mata uang event.\n3. Setelah stage diselesaikan, fungsi \"Pemutaran Ulang\" stage tersebut akan terbuka. Perhatian: Saat menggunakan fungsi \"Pemutaran Ulang\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Kamu dapat menggunakan bantuan Asosiasi Alumni dan \"Resonansi: Perintah Rahasia Perwakilan\" untuk membantumu menyelesaikan stage dengan lebih mudah.\n\n<Title:Bonus Harta Langka>\n1. Penjaga Rahasia yang memiliki Awakener atau Roda Takdir tertentu (tidak harus diturunkan) dapat memperoleh bonus drop tambahan untuk mata uang event dari hadiah misi stage \"Kota di Dalam Danau\". Detail bonus sebagai berikut:\n·Awakener \"Wanda\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda Takdir SSR \"Dekrit Sang Ratu\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda Takdir SR \"Tatapan Isarau\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n2. \"Bonus Harta Langka\" dari Awakener atau Roda Takdir yang berbeda dihitung secara kumulatif. \n3. Khususnya, hadiah tantangan pertama kali tingkat kesulitan Gila tidak akan terpengaruh oleh \"Bonus Harta Langka\".\n\n<Title:Resonansi: Perintah Rahasia Perwakilan>\n1. Penjaga Rahasia dapat memperoleh \"Hati Kesenangan\" dengan menyelesaikan pencapaian event.\n2. Konsumsi \"Hati Kesenangan\" untuk mengaktifkan \"Resonansi: Perintah Rahasia Perwakilan\", yang dapat membuat Penjaga Rahasia menjadi lebih kuat di \"Kota di Dalam Danau\" sehingga tantangan lebih mudah; juga dapat memberikan mata uang event tambahan saat menyelesaikan stage.\n\n<Title:Penyelaman Kesadaran>\n1. Selama event berlangsung, \"Perjamuan yang Membara\" dapat dibuka secara gratis.\n2. Setelah event berakhir, progres investigasi \"Perjamuan yang Membara\" akan disimpan. Menyelesaikan event investigasi yang belum selesai selama event tetap dapat memberikan hadiah investigasi yang sama seperti saat event berlangsung. Jika \"Perjamuan yang Membara\" tidak dibuka selama event, setelah event berakhir masih dapat dibuka dengan mengonsumsi \"Titik Awal Realitas\" × 3.\n3. Baik selama maupun di luar periode event, menyelesaikan \"Perjamuan yang Membara\" akan memberikan \"Perintah Kunci: Perjamuan Busuk\".\n\n<Title:Kompensasi Rerun>\n1. Penjaga Rahasia yang sebelumnya sudah membuka \"Penyelaman Kesadaran: Perjamuan yang Membara\" akan menerima kompensasi \"Tibia Asli\" × 300 saat membuka kembali selama event rerun ini.\n2. Penjaga Rahasia yang sebelumnya sudah mendapatkan avatar edisi terbatas event \"Atas Nama Kunci Perak: Wanda\", saat mendapatkannya kembali akan otomatis dikonversi menjadi \"Tibia Asli\" × 2000.\n3. Penjaga Rahasia yang sebelumnya sudah mendapatkan material aktivasi resonansi \"Hati Kesenangan\", setiap 1 \"Hati Kesenangan\" berlebih yang diperoleh akan otomatis dikonversi menjadi \"Voucher Emas Mawar\" × 5000.\n"
  },
  Activity_67731_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_67732_ActivityName = {
    Text = "Buku Detektif Terkenal · Replika"
  },
  Activity_67732_ActivityPlot = {
    Text = [[
Sebuah buku panduan yang tampak biasa saja.
Mencatat pemikiran dan pengalaman kerja selama bertahun-tahun dari seorang detektif terkenal.
Berharap dapat memberikan sedikit inspirasi bagi para pemuda yang bercita-cita menjadi detektif.]]
  },
  Activity_67732_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Klub Keberuntungan\""
  },
  Activity_67732_ActivityTips = {
    Text = "<Title:Pengenalan Event>\n1. Selama event berlangsung, Penjaga Rahasia dapat mengumpulkan mata uang event \"Chip Kemenangan\" melalui mode terbatas waktu \"Legenda Malam Bulan\" dan \"Hadiah Pencapaian\". \"Chip Kemenangan\" dapat ditukarkan dengan hadiah berlimpah di \"Klub Keberuntungan\", termasuk Roda Takdir SR edisi terbatas event \"Roulette Takdir\", \"Inti Murni\", \"Inti Lumen\", \"Serpihan Batu Bijak\", \"Kristal Mimesis\", dan lainnya.\n2. Selama event berlangsung, menyelesaikan misi \"Hadiah Pencapaian\" dapat memberikan avatar edisi terbatas event \"Atas Nama Kunci Perak: Lake\", Roda Takdir SR edisi terbatas event \"Roulette Takdir\", Inti Perak, dan mata uang event \"Chip Kemenangan\" dalam jumlah besar.\n3. Selama event berlangsung, \"Catatan Misi Khusus: Selamat Berburu!\" akan dibuka secara gratis.\n\n<Title:Waktu Event>\n1. 12 Agustus 9:00 - 26 Agustus 9:00 (GMT+8), semua konten event dapat diikuti.\n2. 26 Agustus 9:00 - 2 September 9:00 (GMT+8), hanya \"Klub Keberuntungan\" dan \"Hadiah Pencapaian\" yang tersedia, konten lainnya sudah berakhir dan tidak dapat diikuti.\n\n<Title: Legenda Malam Bulan>\n1. \"Legenda Malam Bulan\" terdiri dari 9 stage, setiap hari otomatis membuka 1 stage.\n2. Setiap tantangan akan mengonsumsi \"Spiritpeptida\" × 120. Menantang stage yang berbeda selain mendapatkan drop material yang berbeda, juga akan memberikan mata uang event \"Chip Kemenangan\".\n3. Stage event kali ini adalah stage material pertarungan langsung, setelah diselesaikan dapat diputar ulang! Setiap \"Pemutaran Ulang\" mengonsumsi \"Spiritpeptida\" × 120.\n4. Perhatian: Saat menggunakan fungsi \"Pemutaran Ulang\", Tingkat Sinkronisasi tidak dapat diperoleh.\n\n<Title: Bonus Chip>\n1. Penjaga Rahasia yang memiliki Awakener atau Roda Takdir tertentu (tidak harus diturunkan) dapat memperoleh bonus drop tambahan untuk \"Chip Kemenangan\" dari hadiah misi stage \"Legenda Malam Bulan\" (termasuk pemutaran ulang). Detail bonus sebagai berikut:\n·Awakener \"Lake\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Waktu Keberuntungan\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Roulette Takdir\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Chip\" dari Awakener atau Roda Takdir yang berbeda dihitung secara kumulatif.\n3. Khususnya, hadiah tantangan pertama kali tingkat kesulitan Gila tidak akan terpengaruh oleh \"Bonus Chip\".\n\n<Title: Klub Keberuntungan>\n1. \"Klub Keberuntungan\" hanya dibuka selama 12 Agustus 9:00 - 2 September 9:00 (GMT+8).\n2. Setelah 2 September 9:00 (GMT+8), sisa \"Chip Kemenangan\" yang belum ditukarkan akan dikembalikan dengan rasio setiap unit ditukar menjadi \"Voucher Emas Mawar\" × 40. Penjaga Rahasia harap periksa surat masuk.\n\n<Title:Catatan Misi Khusus>\n1. Di \"Catatan Misi Khusus: Selamat Berburu!\", Penjaga Rahasia akan menggunakan formasi khusus yang berisi preset cerita \"Lake\" untuk menantang.\n2. Menyelesaikan \"Catatan Misi Khusus: Selamat Berburu!\" akan memberikan Perintah Kunci baru \"Perintah Kunci: Suara Tembakan\"."
  },
  Activity_67732_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_67733_ActivityName = {
    Text = "Pengorbanan Jurang·Reprise"
  },
  Activity_67733_ActivityPlot = {
    Text = [[
Di atas bayangan Aequor, mimpi sang Raja memudar, dan kerajaan dewa telah mengalami pembusukan. 
Dia datang dari ilusi hari-hari lampau, melangkah ke reruntuhan masa depan yang runtuh. 
Dia bertanya kepada Jurang, namun Jurang tetap bungkam. 
Dia memberikan persembahan kepada Jurang, dan yang menjawabnya hanyalah dirinya sendiri.]]
  },
  Activity_67733_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Tanggapan dari Jurang yang Dalam\""
  },
  Activity_67733_ActivityTips = {
    Text = "<Title:Pengenalan Acara>\n1. Selama acara berlangsung, Penjaga Rahasia dapat mengumpulkan mata uang acara melalui mode waktu terbatas \"Kelahiran Kerajaan Ilahi\", \"Titah Sang Raja\", dan \"Hadiah Pencapaian\". Mata uang acara dapat digunakan di \"Jawaban dari Jurang\" untuk persembahan guna mendapatkan hadiah item, termasuk Roda Takdir SR edisi terbatas acara \"Panggilan Laut Dalam\", Batu Bijak, Inti Murni, Inti Lumen, dan lainnya.\n2. Selama acara berlangsung, \"Pandangan Mimpi Asing: Penistaan\" akan dibuka secara gratis. Selesaikan pencapaian acara untuk mendapatkan avatar edisi terbatas acara \"Atas Nama Kunci Perak: Miriam\"!\n\n<Title:Waktu Acara>\n1. 28 Juli 9:00 - 18 Agustus 9:00 (GMT+8), semua konten acara dapat diikuti.\n2. 18 Agustus 9:00 - 25 Agustus 9:00 (GMT+8), hanya \"Jawaban dari Jurang\" dan \"Hadiah Pencapaian\" yang dipertahankan, konten lainnya telah berakhir dan tidak dapat diikuti.\n\n<Title: Kelahiran Kerajaan Ilahi>\n1. \"Kelahiran Kerajaan Ilahi\" terdiri dari 5 stage, 1 stage terbuka otomatis setiap 2 hari.\n2. Setiap tantangan akan mengonsumsi \"Psypeptide\" × 120, tantangan berhasil akan mendapatkan mata uang acara.\n3. Setelah stage diselesaikan, fitur \"Replay\" stage tersebut akan terbuka. Perhatian: Saat menggunakan fitur \"Replay\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Kamu dapat menggunakan bantuan Alumni dan \"Resonansi: Ritual Jurang Laut\" untuk membantumu menyelesaikan stage dengan lebih mudah.\n\n<Title: Bonus Persembahan>\n1. Penjaga Rahasia yang memiliki Awakened atau Roda Takdir tertentu (tidak harus diturunkan) dapat memperoleh bonus drop tambahan untuk \"Air Mata Pendeta\", \"Darah Pendeta\", dan \"Sumsum Pendeta\" dari hadiah misi stage \"Kelahiran Kerajaan Ilahi\" (termasuk Replay). Detail bonus sebagai berikut:\n·Awakened \"Miriam\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Kekuatan Saleh\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Panggilan Laut Dalam\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Persembahan\" dari Awakened atau Roda Takdir yang berbeda dihitung secara kumulatif. \n3. Khususnya, hadiah penyelesaian pertama tingkat kesulitan Gila tidak akan terpengaruh oleh \"Bonus Persembahan\".\n\n<Title:Resonansi: Ritual Jurang Laut>\n1. Penjaga Rahasia dapat memperoleh \"Hati Keimanan\" dengan menyelesaikan pencapaian acara. \n2. Konsumsi \"Hati Keimanan\" untuk mengaktifkan \"Resonansi: Ritual Jurang Laut\" dan mendapatkan bonus berikut:\n(1) Membuat Penjaga Rahasia menjadi lebih kuat dalam mode acara \"Kelahiran Kerajaan Ilahi\", tantangan menjadi lebih mudah.\n(2) Meningkatkan mata uang acara yang diperoleh setelah menyelesaikan tantangan \"Kelahiran Kerajaan Ilahi\".\n(3) Mengaktifkan mode acara \"Titah Sang Raja\".\n\n<Title: Titah Sang Raja>\n·Setelah mengaktifkan resonansi \"Ujian Persembahan\", secara otomatis mendapatkan 60 \"Air Mata Pendeta\" setiap jam, maksimal penyimpanan 25 jam.\n\n<Title: Jawaban dari Jurang>\n1. \"Jawaban dari Jurang\" memiliki tiga altar, waktu pembukaan sebagai berikut:\n·\"Altar Air Mata Berkilau\": 28 Juli 9:00 ~25 Agustus 9:00.\n·\"Altar Darah Merah\": 30 Juli 9:00 ~ 25 Agustus 9:00.\n·\"Altar Sumsum Roh\": 1 Agustus 9:00 ~ 25 Agustus 9:00.\n2. Setiap persembahan akan mengonsumsi 1000 \"Air Mata Pendeta\"/\"Darah Pendeta\"/\"Sumsum Pendeta\", dan secara acak mendapatkan lima hadiah item dari altar.\n3. Hadiah item setiap altar terbagi menjadi \"Item Spesial\" dan \"Item Biasa\". Saat reset, jumlah sisa hadiah item tertentu dapat direset ke batas maksimal. Aturan spesifiknya sebagai berikut:\n(1) 3 kali reset pertama: Setelah \"Item Spesial\" tidak memiliki jumlah tersisa, Penjaga Rahasia dapat memilih untuk reset. Setelah reset, jumlah sisa \"Item Spesial\" dan \"Item Biasa\" akan direset ke batas maksimal; atau dapat memilih untuk terus mempersembahkan. Setelah \"Item Biasa\" juga tidak memiliki jumlah tersisa, reset harus dilakukan untuk melanjutkan persembahan.\n(2) Reset ke-4 dan seterusnya: Reset hanya dapat dilakukan setelah \"Item Biasa\" tidak memiliki jumlah tersisa. Reset akan mereset jumlah sisa \"Item Biasa\" ke batas maksimal, \"Item Spesial\" tidak lagi direset.\n\n<Title: Pandangan Mimpi Asing>\n1. Selama acara berlangsung, \"Pandangan Mimpi Asing: Penistaan\" akan dibuka secara gratis.\n2. Setelah acara berakhir, progres investigasi \"Pandangan Mimpi Asing: Penistaan\" akan disimpan. Jika \"Pandangan Mimpi Asing: Penistaan\" tidak dibuka selama acara, setelah acara berakhir kamu tetap dapat mengonsumsi \"Titik Awal Realitas\" ×7 untuk membukanya.\n3. Baik selama maupun di luar periode acara, setelah menyelesaikan \"Pandangan Mimpi Asing: Penistaan\", kamu dapat memperoleh \"Perintah Kunci: Ritual Laut\".\n\n<Title:Kompensasi Rerun>\n1. Penjaga Rahasia yang sebelumnya sudah membuka \"Pandangan Mimpi Asing: Penistaan\" akan mendapatkan kompensasi \"Air Mata Pendeta\" ×700 saat membuka kembali selama acara rerun ini.\n2. Penjaga Rahasia yang sebelumnya sudah mendapatkan avatar edisi terbatas acara \"Atas Nama Kunci Perak: Miriam\", saat mendapatkannya kembali akan otomatis dikonversi menjadi \"Undangan Sang Tak Terlihat\" ×1.\n3. Penjaga Rahasia yang sebelumnya sudah mendapatkan material aktivasi resonansi \"Hati Keimanan\", setiap 1 \"Hati Keimanan\" berlebih yang diperoleh akan otomatis dikonversi menjadi \"Kupon Emas Mawar\" ×5000.\n"
  },
  Activity_67733_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_67734_ActivityName = {
    Text = "Simfoni Tak Terlihat·Rerun"
  },
  Activity_67734_ActivityPlot = {
    Text = [[
Simfoni adalah seni merajut, lintasan berbagai instrumen terjalin menjadi peta yang saling bersilangan.
Dalam jaring rajutannya, setiap not akan menjalankan perannya masing-masing.
Dengarkanlah, sebuah simfoni yang luar biasa segera dimulai.]]
  },
  Activity_67734_ActivityStageEndContent = {
    Text = "Event telah berakhir, saat ini hanya \"Istana Tidur Lelap\" yang dapat diikuti"
  },
  Activity_67734_ActivityTips = {
    Text = "<Title:Pengenalan Event>\n1. Selama event berlangsung, Penjaga Rahasia dapat mengumpulkan mata uang event \"Lembaran Nada Tinggi\" melalui mode terbatas waktu \"Suara Gemuruh\" dan \"Hadiah Pencapaian\". \"Lembaran Nada Tinggi\" dapat ditukarkan dengan hadiah berlimpah di \"Istana Tidur Lelap\", termasuk Roda Takdir SR edisi terbatas event \"Pertunjukan Tanpa Henti\", \"Inti Murni\", \"Inti Lumen\", \"Serpihan Batu Bijak\", \"Kristal Mimesis\", dan lainnya.\n2. Selama event berlangsung, menyelesaikan misi \"Hadiah Pencapaian\" dapat memberikan avatar edisi terbatas event \"Atas Nama Kunci Perak: Hamelin\", Roda Takdir SR edisi terbatas event \"Pertunjukan Tanpa Henti\", Inti Perak, dan mata uang event \"Lembaran Nada Tinggi\" dalam jumlah besar.\n\n<Title:Waktu Event>\n1. 9 September 9:00 - 23 September 9:00 (GMT+8), semua konten event dapat diikuti.\n2. 23 September 9:00 - 30 September 9:00 (GMT+8), hanya \"Istana Tidur Lelap\" dan \"Hadiah Pencapaian\" yang tersedia, konten lainnya sudah berakhir dan tidak dapat diikuti.\n\n<Title: Suara Gemuruh>\n1. \"Suara Gemuruh\" terdiri dari 9 stage, setiap hari otomatis membuka 1 stage.\n2. Setiap tantangan akan mengonsumsi \"Spiritpeptida\" × 120. Menantang stage yang berbeda selain mendapatkan drop material yang berbeda, juga akan memberikan mata uang event \"Lembaran Nada Tinggi\".\n3. Stage event kali ini adalah stage material pertarungan langsung, setelah diselesaikan dapat diputar ulang! Setiap \"Pemutaran Ulang\" mengonsumsi \"Spiritpeptida\" × 120.\n4. Perhatian: Saat menggunakan fungsi \"Pemutaran Ulang\", Tingkat Sinkronisasi tidak dapat diperoleh.\n\n<Title: Bonus Lembaran>\n1. Penjaga Rahasia yang memiliki Awakener atau Roda Takdir tertentu (tidak harus diturunkan) dapat memperoleh bonus drop tambahan untuk \"Lembaran Nada Tinggi\" dari hadiah misi stage \"Suara Gemuruh\" (termasuk pemutaran ulang). Detail bonus sebagai berikut:\n·Awakener \"Hamelin\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Requiem Abadi\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Pertunjukan Tanpa Henti\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Lembaran\" dari Awakener atau Roda Takdir yang berbeda dihitung secara kumulatif.\n3. Khususnya, hadiah tantangan pertama kali tingkat kesulitan Gila tidak akan terpengaruh oleh \"Bonus Lembaran\".\n\n<Title: Istana Tidur Lelap>\n1. \"Istana Tidur Lelap\" hanya dibuka selama 9 September 9:00 - 30 September 9:00 (GMT+8).\n2. Setelah 30 September 9:00 (GMT+8), sisa \"Lembaran Nada Tinggi\" yang belum ditukarkan akan dikembalikan dengan rasio setiap unit ditukar menjadi \"Voucher Emas Mawar\" × 40. Penjaga Rahasia harap periksa surat masuk."
  },
  Activity_67734_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_67735_ActivityName = {
    Text = "Gelombang Keinginan·Reprise"
  },
  Activity_67735_ActivityPlot = {
    Text = "Mimpi adalah pengungkapan keinginan bawah sadar. Mereka yang mengembara dalam mimpi pada akhirnya akan ditangkap oleh lautan keinginan, menjadi pelayan nafsu, kecuali..."
  },
  Activity_67735_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Pertumbuhan Nafsu\""
  },
  Activity_67735_ActivityTips = {
    Text = "<Title:Ikhtisar Aktivitas>\n1, Selama periode aktivitas, Penjaga dapat mengumpulkan mata uang aktivitas\"Benih ibu\"melalui cara terbatas\"Hasrat kacau\"dan\"Hadiah Prestasi\",\"Benih ibu\"dapat ditukar dengan hadiah di\"Nafsu yang terlarang semakin berkembang\", termasuk SR Roda takdir terbatas\"Ciuman Perpisahan yang Membara\".Inti Lumen.Inti murni.Fragmentasi Batu Bijaksana.Kristal Mimik, dan lainnya.\n2, Selama periode aktivitas, syarat partisipasi\"Frenesi Pembiakan\"diperlonggar hingga menyelesaikan\"Operasi\"1-2·Umum, dan tidak perlu memenuhi syarat afiniti Awakeners untuk membuka\"Kejadian Frenesi Pembiakan\", selain itu, jumlah\"Titik awal realitas\"yang dibutuhkan juga berubah menjadi hanya 1 saja!\n3, Kedatangan kekuatan misterius tampaknya membantu Anda membangun hubungan yang lebih dalam dengan Awakeners, semua cara untuk mendapatkan afiniti selama periode aktivitas akan berlipat ganda!\n\n<Title:Hasrat kacau>\n1,\"Hasrat kacau\"terdiri dari 10 level bahan yang tidak memerlukan eksplorasi dan langsung bertarung, dibuka 1 setiap hari.\n2, Di level bahan ini, Anda akan langsung membangunkan semua Awakeners dan mendapatkan Relic yang sudah ditentukan, selain itu setelah 6 putaran, Anda akan mendapat bantuan dari Thais sekali.\n3, Setiap tantangan akan menghabiskan\"Menophin\"× 120 , dan keberhasilan tantangan akan mendapatkan bahan pelatihan dan mata uang aktivitas.\n4, Setelah menyelesaikan level, fungsi\"Reproduksi\"level tersebut akan dibuka. Harap dicatat: saat menggunakan fungsi\"Reproduksi\", tidak dapat memperoleh afiniti.\n5, Anda dapat menggunakan bantuan alumni untuk membantu Anda menyelesaikan level dengan lebih mudah.\n\n<Title:Bonus Serakah>\n1, Penjaga yang memiliki Awakeners atau Roda takdir tertentu (tidak perlu diikutsertakan) dapat membuat\"Benih ibu\"dalam tugas level\"Hasrat kacau\"mendapatkan tambahan hasil jatuh (termasuk Reproduksi), rincian tambahan sebagai berikut:\n·Awakener\"Thais\": Mencerahkan 0/1/2/3 dan lebih, bonus 20%/30%/40%/50%\n·Roda takdir SSR\"Kasih Sayangnya\": Posisi Tumpuk 0/1/2/3 dan lebih, bonus 20%/30%/40%/50%\n·Roda takdir SR\"Ciuman Perpisahan yang Membara\": Posisi Tumpuk 0/1/2/3 dan lebih, bonus 20%/30%/40%/50%\n2, Bonus Serakah dari Awakeners atau Roda takdir yang berbeda dihitung secara kumulatif. \n3, Secara khusus, hadiah tantangan penyelesaian pertama untuk tingkat kegilaan tidak akan terpengaruh oleh tambahan di atas.\n\n<Title:Nafsu yang terlarang semakin berkembang>\n1, Setiap\"Pertukaran Inti Benih\"akan menghabiskan 750\"Benih ibu\", secara acak mendapatkan lima hadiah barang dalam\"Nafsu yang terlarang semakin berkembang\".\n3, Hadiah barang\"Nafsu yang terlarang semakin berkembang\"dibagi menjadi dua jenis\"Item Spesial\"dan\"Item Umum\", saat reset dapat mengatur ulang jumlah sisa hadiah item spesial ke batas maksimal, aturan spesifik adalah:\n(1) Reset 4 kali pertama: Ketika\"Item Spesial\"tidak ada sisa, Penjaga dapat memilih untuk mereset, setelah direset akan mengatur ulang jumlah sisa\"Item Spesial\"dan\"Item Umum\"ke batas maksimal; juga dapat memilih untuk terus bertukar, ketika\"Item Umum\"juga tidak ada sisa, harus melakukan reset untuk dapat melanjutkan pertukaran.\n(2) Reset ke-5 dan seterusnya: Ketika\"Item Umum\"tidak ada sisa, baru dapat melakukan reset, reset akan mengatur ulang jumlah sisa\"Item Umum\"ke batas maksimal,\"Item Spesial\"tidak akan direset lagi.\n\n<Title:Waktu Aktivitas>\n1, 15 Desember pukul 9:00 - 29 Desember pukul 9:00 (GMT+8), semua konten dalam ikhtisar aktivitas dapat diikuti.\n2, 29 Desember pukul 9:00 - 5 Januari pukul 9:00 (GMT+8), hanya\"Nafsu yang terlarang semakin berkembang\"dan\"Hadiah Prestasi\"yang dipertahankan, konten lainnya telah berakhir dan tidak dapat diikuti.\n3, Setelah 5 Januari pukul 9:00 (GMT+8),\"Benih ibu\"yang tersisa dan belum ditukar akan ditarik kembali sesuai dengan setiap\"Rose Scrip\"× 40, harap Penjaga memperhatikan untuk memeriksa email."
  },
  Activity_67735_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_67736_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_67737_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_67738_ActivityName = {
    Text = "Aktivitas penggandaan afinitas"
  },
  Activity_67739_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_67741_ActivityName = {
    Text = "Cerita Ajaib·Pengulangan"
  },
  Activity_67741_ActivityPlot = {
    Text = [[
Tugas yang diberikan oleh Boneka tidak pernah sederhana. 
Meskipun dia beberapa kali mengingatkan semua orang "untuk bersenang-senang", bagaimana mungkin Penjaga tidak merasa cemas saat pertama kalinya membawa sekelompok Pembangun keluar? 
Namun, ingatlah "untuk bersenang-senang" ya.]]
  },
  Activity_67741_ActivityStageEndContent = {
    Text = "Event telah berakhir, saat ini hanya dapat mengikuti \"Toko Naskah Sihir\""
  },
  Activity_67741_ActivityTips = {
    Text = "<Title:Pengantar Event>\n1. Rerun event gameplay \"Sihir Cerita\" dibuka dalam waktu terbatas. Penjaga Rahasia dapat memperoleh kembali Roda Takdir edisi terbatas event \"Sihir 35mm\" dan avatar edisi terbatas event \"Atas Nama Kunci Perak: Lily\" melalui \"Toko Naskah Sihir\" dan \"Hadiah Pencapaian\"!\n2. Selama event berlangsung, \"Catatan Ekspedisi: Sihir Cerita\" akan dibuka secara gratis dalam waktu terbatas.\n\n<Title:Misteri Naskah>\n1. \"Misteri Naskah\" berisi 9 stage material, 1 stage dibuka otomatis setiap hari.\n2. Setiap tantangan akan mengonsumsi \"Psychube\" × 120. Tantangan yang berhasil akan mendapatkan mata uang event.\n3. Setelah stage diselesaikan, fitur \"Tayangan Ulang\" untuk stage tersebut akan terbuka. Perhatian: Saat menggunakan fitur \"Tayangan Ulang\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Kamu dapat menggunakan bantuan Alumni dan \"Resonansi: Kode Sutradara\" untuk membantumu menyelesaikan stage dengan lebih mudah.\n\n<Title:Bonus Inspirasi>\n1. Penjaga Rahasia yang memiliki Awakened atau Roda Takdir tertentu (tidak harus diturunkan) dapat memperoleh bonus drop tambahan untuk \"Inspirasi Melayang\" dari hadiah misi stage \"Misteri Naskah\" (termasuk Tayangan Ulang). Detail bonus sebagai berikut:\n·Awakened \"Lily\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Melampaui Rasa Sakit\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Sihir 35mm\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Inspirasi\" dari Awakened atau Roda Takdir yang berbeda dihitung secara kumulatif. \n3. Khususnya, hadiah tantangan pertama kali tingkat kesulitan Gila tidak akan terpengaruh oleh bonus di atas.\n\n<Title:Resonansi: Kode Sutradara>\n1. Penjaga Rahasia dapat memperoleh \"Hati Pentas\" dengan menyelesaikan pencapaian event. \n2. Mengonsumsi \"Hati Pentas\" untuk mengaktifkan \"Resonansi: Kode Sutradara\" dapat membuat Penjaga Rahasia menjadi lebih kuat dalam gameplay event \"Misteri Naskah\" dan \"Catatan Ekspedisi: Sihir Cerita\".\n\n<Title:Kompensasi Rerun>\n1. Penjaga Rahasia yang sebelumnya sudah membuka \"Catatan Ekspedisi: Sihir Cerita\" akan mendapatkan kompensasi \"Inspirasi Melayang\" ×700 saat membuka kembali selama periode rerun event ini.\nPenjaga Rahasia yang sebelumnya sudah mendapatkan avatar edisi terbatas event \"Atas Nama Kunci Perak: Lily\" akan otomatis dikonversi menjadi \"Inspirasi Melayang\" ×2000 saat mendapatkannya kembali.\nPenjaga Rahasia yang sebelumnya sudah mendapatkan material aktivasi resonansi \"Hati Pentas\", setiap 1 \"Hati Pentas\" berlebih yang diperoleh akan otomatis dikonversi menjadi \"Voucher Emas Mawar\" ×5000.\n\n<Title:Waktu Event>\n1. 13 Januari 9:00 - 27 Januari 9:00 (GMT+8), semua konten dalam pengantar event dapat diikuti.\n2. 27 Januari 9:00 - 3 Februari 9:00 (GMT+8), hanya \"Toko Naskah Sihir\" dan \"Hadiah Pencapaian\" yang tersedia, konten lainnya sudah berakhir dan tidak dapat diikuti.\n3. Setelah 3 Februari 9:00 (GMT+8), sisa \"Inspirasi Melayang\" yang belum ditukarkan akan dikumpulkan kembali dengan rasio setiap 1 buah ditukar menjadi \"Voucher Emas Mawar\" × 40. Penjaga Rahasia harap periksa email."
  },
  Activity_67741_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_67742_ActivityName = {
    Text = "Buku Mawar · Rerun"
  },
  Activity_67742_ActivityPlot = {
    Text = "Berlian emas yang mewah, kilauan mutiara yang menyilaukan…\nHiasan kemewahan yang tak terhitung telah memberinya khayalan layaknya seorang permaisuri.\nKini, ia bertekad mempertahankan khayalan itu untuk selamanya."
  },
  Activity_67742_ActivityStageEndContent = {
    Text = "Event telah berakhir, saat ini hanya dapat mengikuti \"Perayaan Emas Merah\""
  },
  Activity_67742_ActivityTips = {
    Text = "<Title:Pengantar Event>\n1. Selama event berlangsung, Penjaga Rahasia dapat mengumpulkan mata uang event \"Kipas Bulu Burung Roh\" melalui gameplay terbatas \"Kenangan Mawar\" dan \"Hadiah Pencapaian\". \"Kipas Bulu Burung Roh\" dapat ditukarkan dengan hadiah berlimpah di \"Perayaan Emas Merah\", termasuk Roda Takdir SR edisi terbatas event \"Mata Sejuta Berkah\", \"Inti Murni\", \"Inti Lumen\", \"Serpihan Batu Bijak\", \"Kristal Mimesis\", dll.\n2. Selama event berlangsung, menyelesaikan misi \"Hadiah Pencapaian\" dapat memperoleh avatar edisi terbatas event \"Atas Nama Kunci Perak: Soleil\", Roda Takdir SR edisi terbatas event \"Mata Sejuta Berkah\", Silver Core, dan sejumlah besar mata uang event \"Kipas Bulu Burung Roh\".\n3. Selama event berlangsung, \"Catatan Ekspedisi: Pujian Mawar\" akan dibuka secara gratis.\n\n<Title: Kenangan Mawar>\n1. \"Kenangan Mawar\" berisi 9 stage, 1 stage dibuka otomatis setiap hari.\n2. Setiap tantangan akan mengonsumsi \"Psychube\" × 120. Menantang stage yang berbeda selain mendapatkan drop material yang berbeda, juga akan mendapatkan mata uang event \"Kipas Bulu Burung Roh\".\n3. Setelah stage diselesaikan, fitur \"Tayangan Ulang\" untuk stage tersebut akan terbuka. Perhatian: Saat menggunakan fitur \"Tayangan Ulang\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Kamu dapat menggunakan bantuan Alumni untuk membantumu menyelesaikan stage dengan lebih mudah.\n\n<Title: Bonus Kipas Bulu>\n1. Penjaga Rahasia yang memiliki Awakened atau Roda Takdir tertentu (tidak harus diturunkan) dapat memperoleh bonus drop tambahan untuk \"Kipas Bulu Burung Roh\" dari hadiah misi stage \"Kenangan Mawar\" (termasuk Tayangan Ulang). Detail bonus sebagai berikut:\n·Awakened \"Soleil\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Atas Nama Mawar\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Mata Sejuta Berkah\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Kipas Bulu\" dari Awakened atau Roda Takdir yang berbeda dihitung secara kumulatif. \n3. Khususnya, hadiah tantangan pertama kali tingkat kesulitan Gila tidak akan terpengaruh oleh bonus di atas.\n\n<Title:Kompensasi Rerun>\n1. Selama event berlangsung, Penjaga Rahasia yang sebelumnya sudah membuka \"Catatan Ekspedisi: Pujian Mawar\" akan mendapatkan kompensasi \"Kipas Bulu Burung Roh\" ×700 saat membuka kembali.\nPenjaga Rahasia yang sebelumnya sudah mendapatkan avatar edisi terbatas event \"Atas Nama Kunci Perak: Soleil\" akan otomatis dikonversi menjadi \"Kipas Bulu Burung Roh\" ×2000 saat mendapatkannya kembali.\n\n<Title:Waktu Event>\n1. 27 Januari 9:00 - 10 Februari 9:00 (GMT+8), semua konten event dapat diikuti.\n2. 10 Februari 9:00 - 17 Februari 9:00 (GMT+8), hanya \"Perayaan Emas Merah\" dan \"Hadiah Pencapaian\" yang tersedia, konten lainnya sudah berakhir dan tidak dapat diikuti.\n3. Setelah 17 Februari 9:00 (GMT+8), sisa \"Kipas Bulu Burung Roh\" yang belum ditukarkan akan dikumpulkan kembali dengan rasio setiap 1 buah ditukar menjadi \"Voucher Emas Mawar\" × 40. Penjaga Rahasia harap periksa email."
  },
  Activity_67742_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_67743_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_67744_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_67744_ActivityPlot = {
    Text = "Para hadirin sekalian.\nMalam yang tenang dan damai telah membuka tirainya, siapkanlah minuman terbaik di tangan Anda.\nIni adalah kisah yang panjang, dengarkanlah kami menceritakannya perlahan…"
  },
  Activity_67745_ActivityName = {
    Text = "Gunung Salju Mencair · Revisi"
  },
  Activity_67745_ActivityPlot = {
    Text = [[
Salju dan es Elvorth tak pernah mencair sepanjang tahun, seperti halnya dendamnya.
Saat tangan masa depan dan masa lalu saling bertaut, sang pejuang akan mengangkat pedangnya tinggi-tinggi, melancarkan serangan balas dendam terhadap takdir.
Saat ia menghadapi gelombang hitam, kaulah panjinya.]]
  },
  Activity_67745_ActivityStageEndContent = {
    Text = "Aktivitas telah berakhir, saat ini hanya dapat berpartisipasi di \"Mulut Raksasa Pegunungan\""
  },
  Activity_67745_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1, Selama aktivitas berlangsung, Penjaga dapat mengumpulkan tiga jenis \"Bunga\" melalui gameplay terbatas \"Ambisi Binatang\" dan \"Hadiah Prestasi\".\"Bunga\" dapat ditukarkan di \"Mulut Raksasa Pegunungan\" untuk mendapatkan hadiah item, termasuk Roda Takdir SR terbatas aktivitas \"Sampai Salju Meleleh\",\"Inti murni\",\"Inti Lumen\",\"Fragmentasi Batu Bijaksana\",\"Kristal Mimik\", dan lainnya.\n2, Selama aktivitas berlangsung,\"Rekam Jejak Satuan Tugas: Pengembalian Elworth\" akan dibuka secara gratis.\n\n<Title:Waktu Aktivitas>\n1,13 Juli 9:00 - 10 Agustus 9:00(GMT+8), semua konten aktivitas dapat diikuti.\n2,10 Agustus 9:00 - 17 Agustus 9:00(GMT+8), hanya \"Mulut Raksasa Pegunungan\" dan \"Hadiah Prestasi\" yang tersedia, konten lainnya telah berakhir dan tidak dapat diikuti.\n\n<Title: Ambisi Binatang>\n1,\"Ambisi Binatang\" berisi 5 tingkat, setiap 2 hari akan otomatis membuka 1 tingkat.\n2, Setiap tantangan akan menghabiskan \"Menophin\" × 120, tantangan yang berhasil akan mendapatkan mata uang aktivitas \"Bunga Beku\",\"Bunga Muda Berembun Perak\", dan \"Bunga Matahari Kecil\".\n3, Setelah menyelesaikan tahap, fitur \"Reproduksi\" pada tingkat tersebut akan terbuka. Harap diperhatikan: saat menggunakan fitur \"Reproduksi\", Affiniti tidak dapat diperoleh.\n4, Kamu dapat menggunakan Bantuan Bertarung alumni dan \"Resonansi: Devour gunung\" untuk membantu menyelesaikan tahap dengan lebih mudah.\n5, Harap diperhatikan: tantangan Kegilaan tidak menghabiskan Menophin, tidak dapat direproduksi, dan tantangan berulang setelah penyelesaian pertama tidak akan memberikan hadiah mata uang aktivitas lagi.\n\n<Title: Bonus Bunga>\n1, Penjaga yang memiliki Tubuh Terjaga atau Roda Takdir tertentu(tidak perlu dipasang dalam tim) dapat memperoleh bonus drop tambahan untuk \"Bunga Beku\",\"Bunga Muda Berembun Perak\", dan \"Bunga Matahari Kecil\" dalam hadiah misi tingkat \"Ambisi Binatang\"(termasuk Reproduksi), detail bonus sebagai berikut:\n·Tubuh Terjaga \"Helot: Catena\": Mencerahkan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Tenggelam dalam Merah Abadi\": Posisi Tumpuk 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Sampai Salju Meleleh\": Posisi Tumpuk 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2,\"Bonus Bunga\" dari Tubuh Terjaga atau Roda Takdir yang berbeda dihitung secara kumulatif.\n3, Khusus, hadiah tantangan penyelesaian pertama Kegilaan tidak akan terpengaruh oleh \"Bonus Bunga\".\n\n<Title:Resonansi: Devour gunung>\n1, Penjaga dapat memperoleh \"Hati Pemakan\" dengan menyelesaikan pencapaian aktivitas.\n2, Dengan menghabiskan \"Hati Pemakan\", aktifkan \"Resonansi: Devour gunung\" untuk membuat Penjaga menjadi lebih kuat dalam gameplay aktivitas \"Ambisi Binatang\", sehingga tantangan menjadi lebih mudah.\n\n<Title: Mulut Raksasa Pegunungan>\n1,\"Mulut Raksasa Pegunungan\" memiliki tiga toko penukaran, waktu pembukaan sebagai berikut:\n·\"Ambisi yang melahap\": Dibuka pukul 9 tanggal 13 Juli.\n·\"Tekad untuk balas dendam\": Dibuka pukul 9 tanggal 15 Juli.\n·\"Harapan Kelahiran Kembali\": Dibuka pukul 9 tanggal 17 Juli.\n2, Setiap penukaran akan menghabiskan \"Bunga Beku\"/\"Bunga Muda Berembun Perak\"/\"Bunga Matahari Kecil\" × 750, dan secara acak mendapatkan lima hadiah item dari toko penukaran.\n3, Hadiah item setiap toko penukaran dibagi menjadi \"Item Spesial\" dan \"Item Umum\", saat reset dapat mengatur ulang jumlah tersisa hadiah Item Spesial ke batas maksimum, aturan spesifiknya adalah:\n(1) 2 reset pertama: Ketika \"Item Spesial\" tidak memiliki sisa, Penjaga dapat memilih untuk mereset, setelah reset jumlah tersisa \"Item Spesial\" dan \"Item Umum\" akan diatur ulang ke batas maksimum; atau dapat memilih untuk melanjutkan penukaran, ketika \"Item Umum\" juga tidak memiliki sisa, harus melakukan reset untuk melanjutkan penukaran.\n(2) Mulai reset ke-3: Reset hanya dapat dilakukan ketika \"Item Umum\" tidak memiliki sisa, reset akan mengatur ulang jumlah tersisa \"Item Umum\" ke batas maksimum,\"Item Spesial\" tidak akan direset lagi.\n4, Setelah 17 Agustus 9:00(GMT+8),\"Bunga\" yang tersisa dan belum ditukarkan akan dikumpulkan kembali dengan rasio setiap buah ditukar Rose Scrip × 40, harap Penjaga memperhatikan email yang masuk.\n\n<Title: Rekam Jejak Satuan Tugas>\n1, Selama aktivitas berlangsung,\"Rekam Jejak Satuan Tugas: Pengembalian Elworth\" akan dibuka secara gratis. Setelah menyelesaikan tahap \"Rekam Jejak Satuan Tugas: Pengembalian Elworth\" dapat memperoleh \"Perak\", Roda Takdir SR terbatas aktivitas \"Sampai Salju Meleleh\", dan hadiah lainnya di Hadiah Prestasi. Hadiah Prestasi hanya dibuka selama periode aktivitas, setelah aktivitas berakhir tidak dapat diselesaikan dan diambil.\n2, Setelah aktivitas berakhir, progres investigasi \"Rekam Jejak Satuan Tugas: Pengembalian Elworth\" akan disimpan. Jika \"Rekam Jejak Satuan Tugas: Pengembalian Elworth\" belum terbuka selama periode aktivitas, setelah aktivitas berakhir masih dapat menghabiskan \"Titik awal realitas\" ×7 untuk membukanya.\n3, Terlepas dari apakah dalam periode aktivitas atau tidak, setelah menyelesaikan tahap \"Rekam Jejak Satuan Tugas: Pengembalian Elworth\" dapat memperoleh \"Posse: Tekad Sang Gunung\"."
  },
  Activity_67745_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_67746_ActivityName = {
    Text = "Pintu Segala Hal·Replika"
  },
  Activity_67746_ActivityPlot = {
    Text = [[
Tidak ada yang tahu tahun-tenaranya dia di depan pintu.
Dia tidak berniat terlibat dalam dunia mana pun, tidak boleh terjerat dalam kontinuitas ruang dan waktu, tidak boleh diganggu oleh apapun yang mengganggu ketentraman pintu paling ekstrem.
Sampai saat ketika dia bertemu tatapanmu]]
  },
  Activity_67746_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Echo\""
  },
  Activity_67746_ActivityTips = {
    Text = "<Title:Deskripsi Acara>\n1. Selama periode acara, Penjaga dapat mengumpulkan mata uang acara \"Poin Akhir\" melalui gameplay terbatas \"Uji Akhir\" dan \"Hadiah Prestasi\". \"Poin Akhir\" dapat ditukarkan dengan hadiah menarik di \"Echo\", termasuk SR Roda Takdir eksklusif acara \"Pintu Kebenaran\", \"Inti Murni\", \"Inti Lumen\", \"Fragmentasi Batu Bijaksana\", \"Kristal Mimik\", dan lainnya.\n2. Selama periode acara, menyelesaikan tugas \"Hadiah Prestasi\" akan memberikan avatar eksklusif acara \"Atas nama Kunci Perak: Tawil\", SR Roda Takdir eksklusif acara \"Pintu Kebenaran\", Perak, dan banyak mata uang acara \"Poin Akhir\".\n\n<Title: Waktu Acara>\n1. 3 November 9:00 - 17 November 9:00 (GMT+8), semua konten acara dapat diikuti.\n2. 17 November 9:00 - 24 November 9:00 (GMT+8), hanya \"Echo\" dan \"Hadiah Prestasi\" yang akan tersedia, konten lainnya telah berakhir dan tidak dapat diikuti.\n\n<Title: Uji Akhir>\n1. \"Uji Akhir\" terdiri dari 9 tingkat, satu tingkat akan terbuka secara otomatis setiap hari.\n2. Setiap tantangan akan menghabiskan \"Menophin\"× 120, tantangan di tingkat yang berbeda selain mendapatkan material yang berbeda juga akan memberikan mata uang acara \"Poin Akhir\".\n3. Tingkat acara kali ini adalah tingkat material pertempuran langsung, setelah menyelesaikan dapat direproduksi! Setiap kali \"Reproduksi\" akan menghabiskan \"Menophin\"× 120.\n4. Harap diperhatikan: saat menggunakan fungsi \"Reproduksi\", tidak akan mendapatkan tingkat afinitas.\n\n<Title: Bonus Poin Akhir>\n1. Penjaga yang memiliki Awakener atau Roda Takdir tertentu (tidak harus ditempatkan) dapat memberikan bonus tambahan pada \"Poin Akhir\" dalam hadiah tugas tingkat \"Uji Akhir\" (termasuk reproduksi), rincian bonus sebagai berikut:\n· Awakener \"Tawil\": Mencerahkan 0/1/2/3 dan lebih, bonus 20%/30%/40%/50%\n· SSR Roda Takdir \"Roda Niskala\": Posisi Tumpuk 0/1/2/3 dan lebih, bonus 20%/30%/40%/50%\n· SR Roda Takdir \"Pintu Kebenaran\": Posisi Tumpuk 0/1/2/3 dan lebih, bonus 20%/30%/40%/50%\n2. Bonus \"Poin Akhir\" dari Awakener atau Roda Takdir yang berbeda dihitung secara terakumulasi.\n3. Khususnya, hadiah tantangan pertama di tingkat kegilaan tidak akan terpengaruh oleh bonus \"Poin Akhir\".\n\n<Title: Echo>\n1. \"Echo\" hanya akan dibuka dari 3 November 9:00 - 24 November 9:00 (GMT+8).\n2. Setelah 24 November 9:00 (GMT+8), sisa \"Poin Akhir\" yang belum ditukarkan akan dikumpulkan dengan rasio setiap \"Poin Akhir\" ditukar menjadi \"Rose Scrip\"× 40, harap Penjaga memperhatikan untuk memeriksa email."
  },
  Activity_67746_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_67746_UnlockConditionExplanation = {
    Text = "Setelah menyelesaikan \"Operasi\"2-9·Normal, akan terbuka."
  },
  Activity_67748_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_67749_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_68349_ActivityName = {
    Text = "Melampaui Bintang-Bintang · Pre-Order Terbatas Waktu"
  },
  Activity_68349_ActivityTips = {
    Text = "<Title: Melampaui Bintang·Pra-Pembelian Terbatas Waktu>\n·Aktivitas pra-pembelian terbatas waktu ini mencakup 8 paket hadiah, di mana paket pertama dapat diklaim secara gratis, paket ke-2 hingga ke-8 harus membeli \"Melampaui Bintang·Pra-Pembelian Terbatas Waktu\" terlebih dahulu sebelum dapat diklaim.\n·Setelah membeli \"Melampaui Bintang·Pra-Pembelian Terbatas Waktu\", hadiah paket ke-2 dapat langsung diklaim; paket selanjutnya perlu menunggu waktu tertentu sebelum dapat diklaim.\n·\"Melampaui Bintang·Pra-Pembelian Terbatas Waktu\" memiliki batas waktu pembelian, setelah lewat tidak dapat dibeli lagi. Mohon Penjaga Rahasia membeli sesuai pertimbangan."
  },
  Activity_68374_ActivityName = {
    Text = "Kotak Hadiah Festival Winterpass"
  },
  Activity_68374_ActivityPlot = {
    Text = "Kotak hadiah yang disediakan oleh Mesagoz pada perayaan Festival Winterpass. Badai dan salju tak mampu menghancurkan tekad Mesagoz melawan erosi. Dalam cahaya api perayaan, jiwa-jiwa yang saling mendukung akan melindungi semua pendatang yang tak menyerah pada takdir."
  },
  Activity_68375_ActivityName = {
    Text = "Kotak Hadiah Spesial Anniversary"
  },
  Activity_68375_ActivityPlot = {
    Text = "Di bawah rekonstruksi Silver Core Technology, tatapan-Nya berubah wujud dan menemanimu di sisimu. Setiap momen sepanjang tahun yang lalu, Dia selalu bersamamu."
  },
  Activity_68404_ActivityName = {
    Text = "Teks sementara"
  },
  Activity_68404_ActivityPlot = {
    Text = "Teks sementara"
  },
  Activity_68404_ActivityStageEndContent = {
    Text = "Aktivitas telah berakhir, saat ini hanya dapat berpartisipasi di \"Teks Sementara\""
  },
  Activity_68404_ActivityTips = {
    Text = [[
<Title:Ringkasan Acara>
Teks Sementara]]
  },
  Activity_68404_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_68405_ActivityName = {
    Text = "Pemulihan Raja Dewa"
  },
  Activity_68405_ActivityPlot = {
    Text = [[
Dalam doa yang penuh dahaga tanpa akhir, Dia sejenak tersadar dari tidur panjang-Nya, melemparkan satu tatapan sejati ke dunia yang membosankan ini.
Dalam kehidupan abadi, tatapan itu begitu singkat.]]
  },
  Activity_68405_ActivityStageEndContent = {
    Text = "Event telah berakhir, saat ini hanya dapat mengikuti\"Jurang Kesadaran\""
  },
  Activity_68405_ActivityTips = {
    Text = "<Title:Pengantar Event>\n1. Selama event berlangsung, Penjaga Rahasia dapat mengumpulkan mata uang event \"Pikiran Lesu\", \"Pikiran Sedih\", \"Pikiran Gembira\" melalui gameplay terbatas \"Tatapan Laut Dalam\" dan \"Hadiah Pencapaian\". Mata uang event dapat digunakan untuk membeli barang di \"Jurang Kesadaran\", termasuk Roda Takdir SR edisi terbatas event \"Takhta Batu Biru\", Inti Lumen, Inti Murni, Serpihan Batu Bijak, Kristal Mimesis, dll.\n2. Selama event berlangsung, menyelesaikan pencapaian event juga dapat memperoleh avatar edisi terbatas event \"Atas Nama Kunci Perak: Tooth\", Roda Takdir SR edisi terbatas event \"Takhta Batu Biru\", Silver Core, dan sejumlah besar mata uang event!\n\n<Title:Waktu Event>\n1. 30 Desember 9:00 - 13 Januari 9:00 (GMT+8), semua gameplay event dapat diikuti.\n2. 13 Januari 9:00 - 20 Januari 9:00 (GMT+8), hanya dapat mengikuti \"Jurang Kesadaran\" dan Hadiah Pencapaian.\n\n<Title:Tatapan Laut Dalam>\n1. \"Tatapan Laut Dalam\" memiliki 5 stage, 1 stage dibuka otomatis setiap 2 hari.\n2. Setiap tantangan akan mengonsumsi \"Psychube\" × 120. Tantangan yang berhasil akan mendapatkan mata uang event.\n3. Setelah stage diselesaikan, fitur \"Tayangan Ulang\" untuk stage tersebut akan terbuka. Perhatian: Saat menggunakan fitur \"Tayangan Ulang\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Kamu dapat menggunakan bantuan Alumni untuk membantumu menyelesaikan stage dengan lebih mudah.\n\n<Title:Bonus Pikiran>\n1. Penjaga Rahasia yang memiliki Awakened atau Roda Takdir tertentu (tidak harus diturunkan) dapat memperoleh bonus drop tambahan untuk mata uang event dari hadiah misi stage \"Tatapan Laut Dalam\". Detail bonus sebagai berikut:\n·Awakened \"Tooth\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda Takdir SSR \"Kidung Raja Dewa\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda Takdir SR \"Takhta Batu Biru\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n2. \"Bonus Pikiran\" dari Awakened atau Roda Takdir yang berbeda dihitung secara kumulatif. \n3. Khususnya, hadiah tantangan pertama kali tingkat kesulitan Gila tidak akan terpengaruh oleh \"Bonus Pikiran\".\n\n<Title: Jurang Kesadaran>\n1. \"Jurang Kesadaran\" hanya dibuka selama 30 Desember 9:00 - 20 Januari 9:00 (GMT+8).\n2. Setelah 20 Januari 9:00 (GMT+8), sisa \"Pikiran Lesu\", \"Pikiran Sedih\", \"Pikiran Gembira\" yang belum ditukarkan akan dikumpulkan kembali dengan rasio setiap 1 buah ditukar menjadi \"Voucher Emas Mawar\" × 40. Penjaga Rahasia harap periksa email."
  },
  Activity_68405_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_68406_ActivityName = {
    Text = "Terpendam dalam memori"
  },
  Activity_68406_ActivityPlot = {
    Text = [[
Orang-orang mengubur keinginan mereka jauh di dalam memori, mengenakan topeng ilusi untuk menyesuaikan diri dengan dunia.
Dengarlah, jeritan dari yang tertutup oleh daging dan darah, sedang bergema di kabut memori.
Kosongkan pikiran, buanglah daging dan darah, sambutlah dirimu yang sejati.]]
  },
  Activity_68406_ActivityStageEndContent = {
    Text = "Acara telah selesai, saat ini hanya dapat berpartisipasi dalam \"Ruang Diagnostik Saraf\""
  },
  Activity_68406_ActivityTips = {
    Text = "<Title:Ringkasan Kegiatan>\nSelama periode kegiatan, Penjaga dapat mengumpulkan mata uang acara melalui permainan terbatas \"Kesembuhan Ketakutan\" dan \"Hadiah Prestasi\". Mata uang acara dapat ditukarkan di \"Ruang terapi saraf\" untuk mendapatkan hadiah item, termasuk SR roda takdir terbatas acara \"Pendulum Hipnotik\", Batu filsuf, Inti murni, Inti Lumen, dan lainnya. \n\n<Title: Waktu Kegiatan>\n1. 7 April 9:00 - 21 April 9:00 (GMT+8), semua konten acara dapat diikuti. \n2. 21 April 9:00 - 28 April 9:00 (GMT+8), hanya \"Ruang terapi saraf\" dan \"Hadiah Prestasi\" yang akan tetap tersedia, konten lainnya telah berakhir dan tidak dapat diikuti. \n\n<Title: Kesembuhan Ketakutan>\n1. \"Kesembuhan Ketakutan\" terdiri dari 5 tingkat, satu tingkat akan dibuka secara otomatis setiap 2 hari. \n2. Setiap tantangan akan menghabiskan \"Menophin\" × 120, dan keberhasilan tantangan akan memberikan mata uang acara. \n3. Setelah menyelesaikan tingkat, fungsi \"Reproduksi\" untuk tingkat tersebut akan dibuka. Harap dicatat: saat menggunakan fungsi \"Reproduksi\", tidak akan ada penambahan afinitas. \n4. Anda dapat menggunakan bantuan alumni untuk membantu Anda menyelesaikan tingkat dengan lebih mudah. \n\n<Title: Bonus Kegiatan>\n1. Penjaga yang memiliki Awakener atau roda takdir tertentu (tidak perlu diatur) dapat membuat hadiah tugas \"Kesembuhan Ketakutan\" dalam \"Laporan Diagnostik\" mendapatkan bonus tambahan (termasuk Reproduksi), rincian bonus sebagai berikut: \n· Awakener \"Clementine\": Mencerahkan 0/1/2/3 dan lebih, bonus 20%/30%/40%/50% \n· SSR roda takdir \"Duka Terselubung\": Posisi Tumpuk 0/1/2/3 dan lebih, bonus 20%/30%/40%/50% \n· SR roda takdir \"Pendulum Hipnotik\": Posisi Tumpuk 0/1/2/3 dan lebih, bonus 20%/30%/40%/50% \n2. \"Bonus Kegiatan\" dari Awakener atau roda takdir yang berbeda dihitung secara akumulatif. \n3. Secara khusus, hadiah tantangan pertama untuk tingkat kegilaan tidak akan terpengaruh oleh \"Bonus Kegiatan\". \n\n<Title: Ruang Terapi Saraf>\n1. Setiap kali \"Kirim Laporan\" akan menghabiskan 1000 \"Laporan Diagnostik\", secara acak mendapatkan lima hadiah item di \"Ruang terapi saraf\". \n2. Hadiah item di \"Ruang terapi saraf\" dibagi menjadi dua jenis: \"Item Spesial\" dan \"Item Umum\", saat reset dapat mengatur ulang jumlah sisa hadiah item spesial ke batas maksimum, aturan detailnya adalah: \n(1) 5 kali reset pertama: ketika \"Item Spesial\" tidak memiliki jumlah sisa, Penjaga dapat memilih untuk mereset, setelah reset jumlah sisa \"Item Spesial\" dan \"Item Umum\" akan diatur ulang ke batas maksimum; juga dapat memilih untuk terus menukar, ketika \"Item Umum\" juga tidak memiliki jumlah sisa, harus melakukan reset untuk dapat melanjutkan pertukaran. \n(2) Reset ke-6 dan seterusnya: hanya dapat melakukan reset setelah \"Item Umum\" tidak memiliki jumlah sisa, reset akan mengatur ulang jumlah sisa \"Item Umum\" ke batas maksimum, \"Item Spesial\" tidak akan direset lagi. \n3. Setelah 28 April 9:00 (GMT+8), sisa \"Laporan Diagnostik\" yang belum ditukarkan akan dikembalikan sesuai dengan rasio setiap penukaran \"Rose Scrip\" × 40, harap Penjaga memperhatikan untuk memeriksa email."
  },
  Activity_68406_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_68407_ActivityName = {
    Text = "Teks sementara"
  },
  Activity_68407_ActivityPlot = {
    Text = "Teks sementara"
  },
  Activity_68407_ActivityStageEndContent = {
    Text = "Aktivitas telah berakhir, saat ini hanya dapat berpartisipasi di \"Teks Sementara\""
  },
  Activity_68407_ActivityTips = {
    Text = [[
<Title:Ringkasan Acara>
Teks Sementara]]
  },
  Activity_68407_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_68409_ActivityName = {
    Text = "Teks sementara"
  },
  Activity_68409_ActivityPlot = {
    Text = "Teks sementara"
  },
  Activity_68409_ActivityStageEndContent = {
    Text = "Aktivitas telah berakhir, saat ini hanya dapat berpartisipasi di \"Teks Sementara\""
  },
  Activity_68409_ActivityTips = {
    Text = [[
<Title:Ringkasan Acara>
Teks Sementara]]
  },
  Activity_68409_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_68410_ActivityName = {
    Text = "Bayang-bayang Kota Hujan"
  },
  Activity_68410_ActivityPlot = {
    Text = [[
Di malam hujan yang kabur dan lembab itu, ada pertemuan yang ditakdirkan yang menunggu Anda.
Anda mengingat namanya, mengenali penampilannya, suara lembut dan elegannya selalu membuat Anda merasa tenang.
Hanya saja Anda lupa, hanya dewa dan setan yang senang memuaskan keinginan manusia.
Coba tebak, dia termasuk yang mana?]]
  },
  Activity_68410_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Gudang Penyihir\""
  },
  Activity_68410_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1. Selama periode aktivitas, Penjaga Rahasia dapat mengumpulkan mata uang aktivitas melalui mode terbatas \"Toko Penyihir\" dan \"Hadiah Pencapaian\". Mata uang aktivitas dapat digunakan untuk menukar hadiah item di \"Gudang Harta Penyihir\", termasuk Roda Takdir SR terbatas aktivitas \"Topi Lebar Penyihir\", Batu Bijak, Inti Murni, Inti Lumen, dan lainnya.\n2. Selama periode aktivitas, \"Catatan Misi Khusus: Bayangan Kota Hujan\" akan dibuka secara gratis. Menyelesaikan pencapaian aktivitas juga akan memberikan avatar terbatas aktivitas \"Atas Nama Kunci Perak: Daphodel\"!\n\n<Title:Waktu Aktivitas>\n1. 24 Februari 9:00 - 10 Maret 9:00 (GMT+8), semua konten aktivitas dapat diikuti.\n2. 10 Maret 9:00 - 17 Maret 9:00 (GMT+8), hanya \"Gudang Harta Penyihir\" dan \"Hadiah Pencapaian\" yang tersedia, konten lainnya telah berakhir dan tidak dapat diikuti.\n\n<Title: Toko Penyihir>\n1. \"Toko Penyihir\" terdiri dari 5 stage, 1 stage dibuka secara otomatis setiap 2 hari.\n2. Setiap tantangan akan mengonsumsi \"Psychoffein\" × 120. Tantangan yang berhasil akan memberikan mata uang aktivitas.\n3. Setelah menyelesaikan stage, fungsi \"Tayangan Ulang\" untuk stage tersebut akan terbuka. Perhatian: Saat menggunakan fungsi \"Tayangan Ulang\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Anda dapat menggunakan bantuan Asosiasi Alumni untuk membantu menyelesaikan stage dengan lebih mudah.\n\n<Title: Bonus Aktivitas>\n1. Penjaga Rahasia yang memiliki Awakened atau Roda Takdir tertentu (tidak perlu ditempatkan di tim) dapat memperoleh bonus drop tambahan untuk \"Tengkorak Binatang Pucat\", \"Tengkorak Binatang Bayangan\", dan \"Tengkorak Binatang Merah Tua\" dari hadiah misi stage \"Toko Penyihir\" (termasuk Tayangan Ulang). Detail bonus sebagai berikut:\n·Awakened \"Daphodel\": Kebangkitan Roh 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Koleksi Paling Berharga\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Topi Lebar Penyihir\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Aktivitas\" dari Awakened atau Roda Takdir yang berbeda dihitung secara kumulatif.\n3. Khususnya, hadiah tantangan penyelesaian pertama tingkat kesulitan Gila tidak terpengaruh oleh \"Bonus Aktivitas\".\n\n<Title: Gudang Harta Penyihir>\n1. \"Gudang Harta Penyihir\" memiliki tiga bagian, dengan waktu pembukaan sebagai berikut:\n·\"Obat Penenang Terbaik\": 24 Februari 9:00 ~ 17 Maret 9:00.\n·\"Harta Karun Megah\": 26 Februari 9:00 ~ 17 Maret 9:00.\n·\"Barang Langka Koleksi\": 28 Februari 9:00 ~ 17 Maret 9:00.\n2. Setiap penukaran akan mengonsumsi 750 \"Tengkorak Binatang Pucat\"/\"Tengkorak Binatang Bayangan\"/\"Tengkorak Binatang Merah Tua\", dan secara acak memberikan lima hadiah item dari gudang harta.\n3. Hadiah item setiap gudang harta dibagi menjadi \"Item Spesial\" dan \"Item Biasa\". Saat direset, jumlah sisa hadiah item tertentu akan dikembalikan ke batas maksimal. Aturan spesifiknya sebagai berikut:\n(1) 2 reset pertama: Setelah \"Item Spesial\" habis, Penjaga Rahasia dapat memilih untuk mereset. Setelah reset, jumlah sisa \"Item Spesial\" dan \"Item Biasa\" akan dikembalikan ke batas maksimal; atau dapat memilih untuk terus menukar. Setelah \"Item Biasa\" juga habis, reset harus dilakukan untuk melanjutkan penukaran.\n(2) Mulai reset ke-3: Reset hanya dapat dilakukan setelah \"Item Biasa\" habis. Reset akan mengembalikan jumlah sisa \"Item Biasa\" ke batas maksimal, \"Item Spesial\" tidak lagi direset.\n\n<Title: Catatan Misi Khusus>\n1. Selama periode aktivitas, \"Catatan Misi Khusus: Bayangan Kota Hujan\" akan dibuka secara gratis.\n2. Setelah aktivitas berakhir, progres investigasi \"Catatan Misi Khusus: Bayangan Kota Hujan\" akan disimpan. Jika \"Catatan Misi Khusus: Bayangan Kota Hujan\" belum dibuka selama periode aktivitas, setelah aktivitas berakhir masih dapat dibuka dengan menggunakan \"Titik Awal Realitas\" ×7.\n3. Baik selama maupun di luar periode aktivitas, menyelesaikan \"Catatan Misi Khusus: Bayangan Kota Hujan\" akan memberikan \"Perintah Kunci: Wajah Asli Kabut Abu-abu\"."
  },
  Activity_68410_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_68411_ActivityName = {
    Text = "Teks sementara"
  },
  Activity_68411_ActivityPlot = {
    Text = "Teks sementara"
  },
  Activity_68411_ActivityStageEndContent = {
    Text = "Aktivitas telah berakhir, saat ini hanya dapat berpartisipasi di \"Teks Sementara\""
  },
  Activity_68411_ActivityTips = {
    Text = [[
<Title:Ringkasan Acara>
Teks Sementara]]
  },
  Activity_68411_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_70438_ActivityName = {
    Text = "Uma Nya Nya Rate"
  },
  Activity_70438_ActivityPlot = {
    Text = [[
Festival Qi Sui semakin dekat, semua orang memperhatikan persiapan perayaan, tanpa menyadari bahwa bercak hitam di sudut sedang bergerak diam-diam. Tahanan kecil itu berubah menjadi cairan dan melarikan diri dari penjara.
Saat celah dimensi berkedip, gumpalan bulu hitam mulai terbelah... lautan kucing hitam sedang melahap seluruh kampus!
Kamu awalnya ingin mengabaikan acara ini, menyerahkan kejadian aneh ini kepada bagian urusan sekolah untuk ditangani.
Namun, karena mereka menjatuhkan inti perak dan kupon emas, kamu mengubah pikiranmu.]]
  },
  Activity_70438_ActivityTips = {
    Text = "<Title:Ringkasan Aktivitas>\nAktivitas permainan \"Hukum Kucing Usath\"dibuka untuk waktu terbatas! Selama periode aktivitas, Penjaga dapat memukul kucing sekolah melalui \"Kucing Berlarian\", dan bisa mendapatkan banyak Perak dan Rose Scrip!\n\n<Title:Waktu Aktivitas>\n24 Januari 9:00 - 5 Februari 9:00 (GMT+8), selama periode aktivitas, setiap hari dapat berpartisipasi dalam tingkat \"Kucing Berlarian\"yang dibuka pada hari itu, konten tingkat yang telah berakhir tidak dapat diikuti lagi.\n\n<Title:Kucing Berlarian>\n1.Terdapat 12 tingkat dalam \"Kucing Berlarian\", setiap hari dibuka tingkat yang berbeda, konten tingkat yang telah berakhir tidak dapat diikuti lagi.\n2.Setiap tantangan tidak menghabiskan \"Menophin\", setelah menyelesaikan 1 tingkat, dapat memperoleh \"Inti murni\".\"Perak\".\"Rose Scrip\".\n3.Tingkat kali ini tidak dapat menggunakan bantuan alumni.\n4.Dalam tingkat hari itu, setiap Awakener hanya dapat bertarung 1 kali.\n5.Tingkat setiap hari harus menggunakan Realm yang ditentukan untuk tantangan.\n·24 Januari: Realm Chaos\n·25 Januari: Realm Aequor\n·26 Januari: Realm Caro\n·27 Januari: Realm Ultra\n·28 Januari: Tanpa batas\n·29 Januari: Tanpa batas\n·30 Januari: Realm Chaos dan Realm Aequor\n·31 Januari: Realm Caro dan Realm Ultra\n·1 Februari: Realm Chaos dan Realm Caro\n·2 Februari: Realm Aequor dan Realm Ultra\n·3 Februari: Realm Chaos dan Realm Ultra\n·4 Februari: Realm Caro dan Realm Aequor"
  },
  Activity_70438_BannerText = {
    Text = "Aktivitas Spesial Dibuka Terbatas!"
  },
  Activity_71095_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_71095_ActivityTips = {
    Text = "<Title:Syarat Partisipasi>\n·Selesaikan \"Operasi\"2-9·Normal untuk berpartisipasi.\n<Title:Acara Penyelidikan>\n·Selama acara berlangsung, setiap hari akan ada acara penyelidikan baru di \"Cerita Ajaib\". Penjaga tidak perlu menghabiskan inventaris untuk membuka kunci dan melakukan penyelidikan. Setelah menyelesaikan acara penyelidikan, Penjaga dapat memperoleh inti murni, lencana penyelidikan, dan pengalaman penjaga sebagai hadiah penyelidikan.\n·Setelah acara berakhir, kemajuan penyelidikan di \"Cerita Ajaib\"akan tetap tersimpan. Penjaga dapat menggunakan D-permata di catatan misi khusus untuk membuka kunci penyelidikan yang belum dibuka. Menyelesaikan acara penyelidikan yang belum selesai selama acara juga akan memberikan hadiah penyelidikan yang sama seperti selama acara.<Title:Hadiah Terbatas Waktu>\n·Selama acara berlangsung, hadiah terbatas waktu akan diluncurkan. Penjaga yang menyelesaikan mode Normal \"Cerita Ajaib\"dan menyelesaikan acara penyelidikan \"Cerita Ajaib\"dapat memperoleh inti murni, batu filsuf, dan hadiah perak! Hadiah terbatas waktu hanya tersedia selama acara, dan setelah acara berakhir, hadiah tidak dapat diselesaikan atau diklaim."
  },
  Activity_71097_ActivityName = {
    Text = "Teks sementara"
  },
  Activity_71097_ActivityPlot = {
    Text = "Teks sementara"
  },
  Activity_71097_ActivityStageEndContent = {
    Text = "Aktivitas telah berakhir, saat ini hanya dapat berpartisipasi di \"Teks Sementara\""
  },
  Activity_71097_ActivityTips = {
    Text = [[
<Title:Ringkasan Acara>
Teks Sementara]]
  },
  Activity_71097_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_71098_ActivityName = {
    Text = "Selangkah Lagi·Rerun"
  },
  Activity_71098_ActivityPlot = {
    Text = [[
Dia selalu berada di depan orang-orang. 
Satu langkah, dua langkah, jejak kakinya memimpin langkah-langkah manusia. 
Namun, orang sering lupa bahwa jarak antara jenius dan orang gila hanyalah setengah langkah.]]
  },
  Activity_71098_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Pengajaran Sang Guru\""
  },
  Activity_71098_ActivityTips = {
    Text = "<Title:Deskripsi Kegiatan>\nSelama periode kegiatan, Penjaga dapat mengumpulkan mata uang acara \"Bagian Boneka\" melalui permainan terbatas \"Pintu Ilusi\" dan \"Hadiah Prestasi\". \"Bagian Boneka\" dapat ditukarkan untuk hadiah di \"Ajaran Guru\", termasuk Roda takdir SR terbatas acara \"Tongkat Penggembala\", Inti Lumen, Inti Murni, Fragmentasi Batu Bijaksana, Kristal Mimik, dan lainnya. \n\n<Title:Pintu Ilusi>\n1. \"Pintu Ilusi\" terdiri dari 9 level bahan yang dapat dilawan langsung tanpa eksplorasi, satu level dibuka setiap hari. \n2. Setiap tantangan akan menghabiskan \"Menophin\" × 120, dan keberhasilan tantangan akan memberikan bahan pelatihan dan mata uang acara. \n3. Setelah menyelesaikan level, fitur \"Reproduksi\" untuk level tersebut akan dibuka. Harap diperhatikan: menggunakan fitur \"Reproduksi\" tidak akan mendapatkan Affiniti. \n4. Anda dapat menggunakan bantuan alumni untuk membantu Anda menyelesaikan level dengan lebih mudah. \n\n<Title:Bonus Bagian Boneka>\n1. Penjaga yang memiliki Awakener atau Roda takdir tertentu (tidak perlu dalam tim) dapat membuat \"Bagian Boneka\" dalam hadiah tugas level \"Pintu Ilusi\" mendapatkan bonus jatuh tambahan (termasuk Reproduksi), rincian bonusnya sebagai berikut: \n· Awakener \"Meltdown·Doll\": Mencerahkan 0/1/2/3 dan di atas, bonus 20%/30%/40%/50% \n· Roda takdir SSR \"Boneka Kehampaan\": Posisi Tumpuk 0/1/2/3 dan di atas, bonus 20%/30%/40%/50% \n· Roda takdir SR \"Tongkat Penggembala\": Posisi Tumpuk 0/1/2/3 dan di atas, bonus 20%/30%/40%/50% \n2. Bonus \"Bagian Boneka\" dari Awakener atau Roda takdir yang berbeda dihitung dengan cara bertumpuk. \n3. Secara khusus, hadiah tantangan pertama pada tingkat Kegilaan tidak akan terpengaruh oleh bonus di atas. \n\n<Title:Ajaran Guru>\n1. Setiap \"Tukar Bagian\" akan menghabiskan 750 \"Bagian Boneka\", secara acak mendapatkan lima hadiah dari \"Ajaran Guru\". \n2. Hadiah dari \"Ajaran Guru\" dibagi menjadi dua jenis: \"Item Spesial\" dan \"Item Umum\", saat reset dapat mengatur ulang jumlah sisa hadiah item spesial ke batas maksimum, aturan spesifiknya adalah: \n(1)5 kali reset pertama: ketika \"Item Spesial\" tidak memiliki sisa, Penjaga dapat memilih untuk mereset, setelah reset, jumlah sisa \"Item Spesial\" dan \"Item Umum\" akan diatur ulang ke batas maksimum; juga bisa memilih untuk terus bertukar, ketika \"Item Umum\" juga tidak memiliki sisa, harus mereset untuk dapat terus bertukar. \n(2)Reset ke-6 dan seterusnya: ketika \"Item Umum\" tidak memiliki sisa baru dapat mereset, reset akan mengatur ulang jumlah sisa \"Item Umum\" ke batas maksimum, \"Item Spesial\" tidak akan direset lagi. \n\n<Title:Waktu Kegiatan>\n1. 16 Juni 9:00 - 30 Juni 9:00 (GMT+8), semua konten dalam deskripsi kegiatan dapat diikuti. \n2. 30 Juni 9:00 - 7 Juli 9:00 (GMT+8), hanya \"Ajaran Guru\" dan \"Hadiah Prestasi\" yang akan dipertahankan, konten lainnya telah berakhir dan tidak dapat diikuti. \n3. Setelah 7 Juli 9:00 (GMT+8), \"Bagian Boneka\" yang belum ditukarkan akan dikumpulkan dengan rasio setiap 1 ditukar menjadi \"Rose Scrip\" × 40, harap Penjaga memperhatikan untuk memeriksa email."
  },
  Activity_71098_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_71100_ActivityName = {
    Text = "Pemulihan Raja Dewa"
  },
  Activity_71100_ActivityPlot = {
    Text = [[
Dalam doa yang penuh dahaga tanpa akhir, Dia sejenak tersadar dari tidur panjang-Nya, melemparkan satu tatapan sejati ke dunia yang membosankan ini.
Dalam kehidupan abadi, tatapan itu begitu singkat.]]
  },
  Activity_71100_ActivityStageEndContent = {
    Text = "Event telah berakhir, saat ini hanya dapat mengikuti\"Jurang Kesadaran\""
  },
  Activity_71100_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1, Selama periode aktivitas, Penjaga Rahasia dapat mengumpulkan mata uang aktivitas \"Pikiran Lesu\",\"Pikiran Sedih\", dan \"Pikiran Gembira\" melalui mode terbatas waktu \"Tatapan Laut Dalam\" dan \"Hadiah Pencapaian\". Mata uang aktivitas dapat digunakan untuk membeli barang di \"Jurang Kesadaran\", termasuk Roda Takdir SR edisi terbatas \"Takhta Batu Biru\", Inti Lumen, Inti Murni, Serpihan Batu Bijak, Kristal Mimesis, dan lainnya.\n2, Selama periode aktivitas, menyelesaikan pencapaian aktivitas juga dapat memperoleh avatar edisi terbatas \"Atas Nama Kunci Perak: Ceyx\", Roda Takdir SR edisi terbatas \"Takhta Batu Biru\", Inti Perak, dan sejumlah besar mata uang aktivitas!\n\n<Title:Waktu Aktivitas>\n1,30 Desember 9:00 - 13 Januari 9:00(GMT+8), semua mode aktivitas dapat diikuti.\n2,13 Januari 9:00 - 20 Januari 9:00(GMT+8), hanya dapat mengikuti \"Jurang Kesadaran\" dan Hadiah Pencapaian.\n\n<Title:Tatapan Laut Dalam>\n1,\"Tatapan Laut Dalam\" memiliki 5 stage, setiap 2 hari otomatis membuka 1 stage.\n2, Setiap tantangan akan mengonsumsi \"Endorfin Spiritual\" × 120, tantangan berhasil akan memperoleh mata uang aktivitas.\n3, Setelah stage diselesaikan, fitur \"Pemutaran Ulang\" stage tersebut akan terbuka. Perhatian: Saat menggunakan fitur \"Pemutaran Ulang\", tidak dapat memperoleh Tingkat Sinkronisasi.\n4, Dapat menggunakan bantuan Asosiasi Alumni untuk membantumu menyelesaikan stage dengan lebih mudah.\n\n<Title:Bonus Pikiran>\n1, Penjaga Rahasia yang memiliki Awakened atau Roda Takdir tertentu(tidak harus diturunkan) dapat memperoleh bonus drop tambahan untuk mata uang aktivitas dari hadiah misi stage \"Tatapan Laut Dalam\", detail bonus sebagai berikut:\n·Awakened \"Thulu\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda Takdir SSR \"Kidung Raja Dewa\": Tumpukan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda Takdir SR \"Takhta Batu Biru\": Tumpukan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n2,\"Bonus Pikiran\" dari Awakened atau Roda Takdir yang berbeda dihitung secara kumulatif.\n3, Khususnya, hadiah tantangan pertama kali tingkat kesulitan Gila tidak akan terpengaruh oleh \"Bonus Pikiran\".\n\n<Title: Jurang Kesadaran>\n1,\"Jurang Kesadaran\" hanya dibuka selama 30 Desember 9:00 - 20 Januari 9:00(GMT+8).\n2, Setelah 20 Januari 9:00(GMT+8), sisa \"Pikiran Lesu\",\"Pikiran Sedih\",\"Pikiran Gembira\" yang belum ditukarkan akan dikembalikan dengan rasio setiap unit ditukar menjadi \"Kupon Emas Mawar\" × 40, mohon Penjaga Rahasia periksa surat."
  },
  Activity_71100_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_71101_ActivityName = {
    Text = "Teks sementara"
  },
  Activity_71101_ActivityPlot = {
    Text = "Teks sementara"
  },
  Activity_71101_ActivityStageEndContent = {
    Text = "Aktivitas telah berakhir, saat ini hanya dapat berpartisipasi di \"Teks Sementara\""
  },
  Activity_71101_ActivityTips = {
    Text = [[
<Title:Ringkasan Acara>
Teks Sementara]]
  },
  Activity_71101_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_71102_ActivityName = {
    Text = "Cerita Ajaib·Pengulangan"
  },
  Activity_71102_ActivityPlot = {
    Text = [[
Tugas yang diberikan oleh Boneka tidak pernah sederhana. 
Meskipun dia beberapa kali mengingatkan semua orang "untuk bersenang-senang", bagaimana mungkin Penjaga tidak merasa cemas saat pertama kalinya membawa sekelompok Pembangun keluar? 
Namun, ingatlah "untuk bersenang-senang" ya.]]
  },
  Activity_71102_ActivityStageEndContent = {
    Text = "Event telah berakhir, saat ini hanya dapat mengikuti \"Toko Naskah Sihir\""
  },
  Activity_71102_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1. Rerun gameplay aktivitas \"Sihir Cerita\" dibuka untuk waktu terbatas. Keeper dapat kembali mendapatkan Roda Takdir edisi aktivitas terbatas \"Sihir 35mm\" dan avatar edisi aktivitas terbatas \"Atas Nama Kunci Perak: Lily\" melalui \"Toko Naskah Sihir\" dan \"Hadiah Pencapaian\"!\n2. Selama periode aktivitas, \"Catatan Misi Khusus: Sihir Cerita\" akan dibuka secara gratis untuk waktu terbatas.\n\n<Title:Waktu Aktivitas>\n1. 3 Juni pukul 9:00 - 17 Juni pukul 9:00 (GMT+8), semua konten dalam pengenalan aktivitas dapat diikuti.\n2. 17 Juni pukul 9:00 - 24 Juni pukul 9:00 (GMT+8), hanya \"Toko Naskah Sihir\" dan \"Hadiah Pencapaian\" yang tersedia, konten lainnya sudah berakhir dan tidak dapat diikuti.\n\n<Title:Misteri Naskah>\n1. \"Misteri Naskah\" berisi 9 stage material, 1 stage dibuka otomatis setiap hari. Setelah dibuka, stage Catatan Misi Khusus prasyarat harus diselesaikan terlebih dahulu sebelum dapat ditantang.\n2. Setiap tantangan akan mengonsumsi 60 poin Spiritein, tantangan berhasil akan memberikan mata uang aktivitas \"Inspirasi Melayang\" dan material pengembangan; stage material aktivitas kali ini mendukung Replay setelah diselesaikan.\n3. Keeper dapat menggunakan bantuan tempur Alumni dan \"Resonansi: Kode Sutradara\" untuk membantumu menyelesaikan stage dengan lebih mudah.\n\n<Title:Bonus Inspirasi>\n1. Keeper yang memiliki Awakened Body atau Roda Takdir tertentu (tidak harus ditempatkan di tim) dapat memperoleh bonus drop tambahan untuk \"Inspirasi Melayang\" dari hadiah misi stage \"Misteri Naskah\" (termasuk Replay), bonus spesifik sebagai berikut:\n·Awakened Body \"Lily\": Awakening 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Melampaui Rasa Sakit\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Sihir 35mm\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Inspirasi\" dari Awakened Body atau Roda Takdir yang berbeda dihitung secara kumulatif.\n\n<Title:Resonansi: Kode Sutradara>\n1. Keeper dapat memperoleh \"Hati Pementasan\" dengan menyelesaikan pencapaian aktivitas.\n2. Mengonsumsi \"Hati Pementasan\" untuk mengaktifkan \"Resonansi: Kode Sutradara\" dapat membuat Keeper menjadi lebih kuat dalam gameplay aktivitas \"Misteri Naskah\" dan \"Catatan Misi Khusus: Sihir Cerita\", serta meningkatkan \"Inspirasi Melayang\" dan hadiah Sync Rate yang diperoleh setelah menyelesaikan tantangan \"Misteri Naskah\".\n\n<Title:Hadiah Pencapaian>\n1. Menyelesaikan misi pencapaian dapat memberikan avatar edisi aktivitas terbatas \"Atas Nama Kunci Perak: Lily\", mata uang aktivitas \"Inspirasi Melayang\", Inti Perak.\n2. Berisi 25 misi: Selesaikan setiap stage \"Misteri Naskah\" 1 kali, selesaikan \"Misteri Naskah\" 1/2 kali menggunakan tim dari setiap Domain, selesaikan setiap event investigasi \"Catatan Misi Khusus: Sihir Cerita\" 1 kali, selesaikan semua pencapaian aktivitas.\n\n<Title:Catatan Misi Khusus>\n1. Selama periode aktivitas, \"Catatan Misi Khusus: Sihir Cerita\" dapat dibuka secara gratis.\n2. Dalam \"Catatan Misi Khusus: Sihir Cerita\", Keeper akan menggunakan formasi khusus yang berisi preset cerita \"Lily\" untuk menantang.\n\n<Title:Kompensasi Rerun>\n1. Keeper yang sebelumnya sudah membuka \"Catatan Misi Khusus: Sihir Cerita\" akan menerima kompensasi \"Inspirasi Melayang\" ×1000 saat membuka kembali selama periode rerun aktivitas ini.\nKeeper yang sebelumnya sudah mendapatkan avatar edisi aktivitas terbatas \"Atas Nama Kunci Perak: Lily\", saat mendapatkannya kembali akan otomatis dikonversi menjadi \"Inspirasi Melayang\" ×3000.\nKeeper yang sebelumnya sudah mendapatkan material aktivasi resonansi \"Hati Pementasan\", setiap 1 \"Hati Pementasan\" berlebih yang didapat akan otomatis dikonversi menjadi \"Voucher Emas Mawar\" ×5000.\n"
  },
  Activity_71102_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_71325_ActivityName = {
    Text = "Puisi Tanpa Nama"
  },
  Activity_71325_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Puisi Tanpa Nama\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Aurla untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_71329_ActivityName = {
    Text = "Bunga dari Lumpur"
  },
  Activity_71329_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Bunga dari Lumpur\" berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Lily untuk mencoba level yang ditentukan tanpa batas.\n·Saat mencoba level aktivitas, formasi Awakened dalam tim tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan level, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_71743_ActivityName = {
    Text = "Penyihir Pemburu Tengkorak"
  },
  Activity_71743_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Penyihir Pemburu Tengkorak\" berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Daphodel untuk mencoba level yang ditentukan tanpa batas.\n·Saat mencoba level aktivitas, formasi Awakened dalam tim tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan level, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_71744_ActivityName = {
    Text = "Uskup Pengasih"
  },
  Activity_71744_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Uskup Pengasih\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Salvador untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_71745_ActivityName = {
    Text = "Nyonya Merah"
  },
  Activity_71745_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Nyonya Merah\" berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Soreil untuk mencoba level yang ditentukan tanpa batas.\n·Saat mencoba level aktivitas, formasi Awakened dalam tim tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan level, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_71746_ActivityName = {
    Text = "Wanita Aequor"
  },
  Activity_71746_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Deep Sea Lady\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Murphy untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_71747_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_71956_ActivityName = {
    Text = "Hadiah Peringatan Promosi X"
  },
  Activity_71956_ActivityPlot = {
    Text = [[
Jalan panjang membentang, melebur kegelapan.
Cahaya Kunci Perak akan menuntun kita.]]
  },
  Activity_71957_ActivityName = {
    Text = "Hadiah Peringatan Promosi IX"
  },
  Activity_71957_ActivityPlot = {
    Text = [[
Jalan panjang membentang, melebur kegelapan.
Cahaya Kunci Perak akan menuntun kita.]]
  },
  Activity_71982_ActivityName = {
    Text = "Hadiah Resonansi Jiwa"
  },
  Activity_71982_ActivityPlot = {
    Text = "Kamu tiba di ruang kepala sekolah, namun mendapati ruangan itu kosong. Sepertinya surat itu hanyalah sebuah lelucon.\nSaat kamu hendak pergi, sudut matamu menangkap sebuah kotak hadiah yang indah, beserta pesan yang tertempel di atasnya — Untuk kekasihku tercinta."
  },
  Activity_71983_ActivityName = {
    Text = "Hadiah Melihat Takdir"
  },
  Activity_71983_ActivityPlot = {
    Text = "Suara berderak terdengar dari dalam ruangan yang sunyi. Saat kamu mendekat untuk memeriksa, jendela yang terbuka menunjukkan bahwa \"tamu tak diundang\" telah pergi.\nSinar matahari yang hangat menyinari kotak hadiah yang muncul di atas meja, tulisan tangan yang anggun berkilau keperakan — Semoga takdir senantiasa berpihak padamu."
  },
  Activity_72101_ActivityName = {
    Text = "Pembalikan Fase"
  },
  Activity_72101_ActivityPlot = {
    Text = [[
"Aku akan membuat semua orang bermain Traphase!"
Seorang pendatang dari ruang waktu lain secara tidak sengaja memasuki ruang Traphase, mengubahnya menjadi sesuatu yang sangat berbeda dari sebelumnya.
Untuk membalikkan ruang ini kembali, Penjaga dari berbagai ruang waktu harus menentukan seorang pemenang terkuat untuk menantang pendatang ini.]]
  },
  Activity_72101_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1. Selama periode aktivitas, Penjaga Rahasia dapat menyelesaikan pencapaian di \"Hadiah Pencapaian\" dengan berpartisipasi dalam \"Duel Fase\", dan mengklaim \"Biji Ek Ajaib\".\n2. \"Biji Ek Ajaib\" dapat digunakan untuk mengklaim hadiah berlimpah di \"Hadiah Giliran Istimewa\", termasuk avatar terbatas aktivitas \"Giliran Balik: Kartu Visi Semesta\", 10 ekspresi terbatas aktivitas, serta \"Sisa Mimpi Retak\", \"Sisa Mimpi Bintang\", dan lainnya.\n3. Selama periode aktivitas, \"Koneksi Multidimensi: Giliran Balik\" akan dibuka secara gratis!\n4. Selama periode aktivitas, Penjaga Rahasia yang telah menyelesaikan \"Koneksi Multidimensi: Giliran Balik: Tamu dari Dunia Lain\", latar belakang pertarungan \"Duel Fase\" akan diganti sementara menjadi \"Giliran Balik: Ruang Kesadaran\".\n\n<Title: Hadiah Pencapaian>\n1. \"Hadiah Pencapaian\" mencakup pencapaian kemenangan \"Awakened\", pencapaian kemenangan \"Roda Takdir\", pencapaian kemenangan \"Perintah Kunci\", dan pencapaian jumlah kartu yang dimainkan. Penjaga Rahasia dapat mengklaim \"Biji Ek Ajaib\" dengan menyelesaikan pencapaian.\n2. Setiap 25 kartu yang dimainkan menggunakan \"Awakened\" dari kelas berbeda di \"Duel Fase\" akan memberikan 30 \"Biji Ek Ajaib\". Pencapaian \"Memainkan Kartu\" setiap kelas dapat diselesaikan hingga 80 kali.\n3. Pencapaian \"Awakened\": Setiap \"Awakened\" yang menyelesaikan 1/3/6/10 kemenangan di \"Duel Fase\" akan mendapatkan 10 \"Biji Ek Ajaib\".\n4. Pencapaian \"Roda Takdir\": Setiap \"Roda Takdir\" yang menyelesaikan 1/3/6 kemenangan di \"Duel Fase\" akan mendapatkan 10 \"Biji Ek Ajaib\".\n5. Pencapaian \"Perintah Kunci\": Setiap \"Perintah Kunci\" yang menyelesaikan 1/3/6 kemenangan di \"Duel Fase\" akan mendapatkan 10 \"Biji Ek Ajaib\".\n6. \"Awakened\", \"Roda Takdir\", dan \"Perintah Kunci\" yang dibuka sementara melalui Tugas Inti akan tetap menghitung kemenangan dan kartu yang dimainkan secara normal, tetapi hadiah pencapaian kemenangan hanya dapat diklaim setelah memperoleh \"Awakened\", \"Roda Takdir\", atau \"Perintah Kunci\" yang sesuai.\n\n<Title: Hadiah Giliran Istimewa>\n1. Penjaga Rahasia dapat mengklaim hadiah yang sesuai dengan mengumpulkan \"Biji Ek Ajaib\". Mengumpulkan 2500 \"Biji Ek Ajaib\" akan memberikan semua hadiah inti, dan mengumpulkan 5000 \"Biji Ek Ajaib\" akan memberikan semua hadiah!\n2. Setelah menyelesaikan \"Giliran Balik: Tamu dari Dunia Lain\", hadiah akumulasi 100-900 \"Biji Ek Ajaib\" akan terbuka. Setelah menyelesaikan \"Giliran Balik: Momen Pembalikan Semesta\", hadiah akumulasi 1000-5000 \"Biji Ek Ajaib\" akan terbuka.\n\n<Title: Koneksi Multidimensi>\n1. Selama periode aktivitas, \"Koneksi Multidimensi: Giliran Balik\" akan dibuka secara gratis.\n2. Selama periode aktivitas, \"Giliran Balik: Absolut Kehendak\" memerlukan akumulasi 1000 \"Biji Ek Ajaib\" untuk dibuka.\n3. Setelah aktivitas berakhir, progres investigasi \"Koneksi Multidimensi: Giliran Balik\" akan disimpan. Jika \"Koneksi Multidimensi: Giliran Balik\" belum dibuka selama periode aktivitas, setelah aktivitas berakhir masih dapat dibuka dengan menggunakan \"Titik Awal Realitas\" ×3.\n3. Baik selama maupun di luar periode aktivitas, menyelesaikan \"Koneksi Multidimensi: Giliran Balik\" akan memberikan \"Perintah Kunci: Gerbang Taverna\".\n\n<Title:Waktu Aktivitas>\nAktivitas ini hanya dibuka pada 18 Maret 9:00 - 1 April 9:00 (GMT+8). Aktivitas berakhir setelah 1 April 9:00 (GMT+8). Harap para Penjaga Rahasia ingat untuk mengklaim hadiah di \"Hadiah Giliran Istimewa\"!"
  },
  Activity_72101_BannerText = {
    Text = "Aktivitas Spesial Dibuka Terbatas!"
  },
  Activity_72101_UnlockConditionExplanation = {
    Text = "Setelah menyelesaikan \"Operasi\"3-2·Normal, akan terbuka."
  },
  Activity_73680_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_73680_ActivityPlot = {
    Text = "Setelah membeli, \"Meltdown·Dor\" dapat mengaktifkan\n<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>"
  },
  Activity_73681_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_73681_ActivityPlot = {
    Text = "Setelah membeli, \"Meltdown · Dor\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_73879_ActivityName = {
    Text = "Formasi Bintang Selaras·Replika"
  },
  Activity_73879_ActivityPlot = {
    Text = [[
Saat bintang-bintang mencapai posisi sempurna telah tiba, gerakan janin di dada berdentum bagai genderang.
Mimpi buruk malam gelap yang menyiksanya selama bertahun-tahun, berakhir seiring datangnya akhir yang membuat air mata para pengikut mengalir deras.
Dari @1kegelapan@2-Nya, @3 yang agung turun ke dunia.]]
  },
  Activity_73879_ActivityStageEndContent = {
    Text = "Aktivitas telah berakhir, saat ini hanya \"Penetasan Suci\" yang dapat diikuti"
  },
  Activity_73879_ActivityTips = {
    Text = "<Title:Pengenalan Aktivitas>\n1. Selama periode aktivitas, Penjaga Rahasia dapat mengumpulkan tiga jenis \"Embrio\" melalui mode terbatas \"Rahim Kegelapan\" dan \"Hadiah Pencapaian\". \"Embrio\" dapat ditukarkan dengan hadiah item di \"Penetasan Suci\", termasuk Roda Takdir SR terbatas aktivitas \"Tidur di Bawah Gletser\", \"Inti Murni\", \"Inti Lumen\", \"Serpihan Batu Bijak\", \"Kristal Mimesis\", dan lainnya.\n2. Selama periode aktivitas, menyelesaikan tugas \"Hadiah Pencapaian\" akan memberikan avatar terbatas aktivitas \"Atas Nama Kunci Perak: Murphy\", Roda Takdir SR terbatas aktivitas \"Tidur di Bawah Gletser\", dan sejumlah besar \"Embrio\".\n\n<Title:Waktu Aktivitas>\n1. 10 Maret 9:00 - 24 Maret 9:00 (GMT+8), semua konten aktivitas dapat diikuti.\n2. 24 Maret 9:00 - 31 Maret 9:00 (GMT+8), hanya \"Penetasan Suci\" dan \"Hadiah Pencapaian\" yang tersedia, konten lainnya telah berakhir dan tidak dapat diikuti.\n\n<Title: Rahim Kegelapan>\n1. \"Rahim Kegelapan\" terdiri dari 7 stage, 1 stage dibuka secara otomatis setiap hari.\n2. Setiap tantangan akan mengonsumsi \"Psychoffein\" × 120. Tantangan yang berhasil akan memberikan mata uang aktivitas \"Embrio Tanpa Kesadaran\", \"Embrio Tanpa Hasrat\", dan \"Embrio Tanpa Keserakahan\".\n3. Setelah menyelesaikan stage, fungsi \"Tayangan Ulang\" untuk stage tersebut akan terbuka. Perhatian: Saat menggunakan fungsi \"Tayangan Ulang\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Anda dapat menggunakan bantuan Asosiasi Alumni untuk membantu menyelesaikan stage dengan lebih mudah.\n5. Setelah menyelesaikan stage pada tingkat kesulitan apa pun, tingkat kesulitan Gila untuk stage tersebut akan terbuka. Menyelesaikan tingkat kesulitan Gila untuk pertama kali akan memberikan hadiah mata uang aktivitas yang melimpah.\n6. Perhatian: Tantangan tingkat kesulitan Gila tidak mengonsumsi Psychoffein, tidak dapat ditayangkan ulang, dan setelah penyelesaian pertama, tantangan ulang tidak akan memberikan hadiah mata uang aktivitas lagi.\n\n<Title: Bonus Embrio>\n1. Penjaga Rahasia yang memiliki Awakened atau Roda Takdir tertentu (tidak perlu ditempatkan di tim) dapat memperoleh bonus drop tambahan untuk \"Embrio Tanpa Kesadaran\", \"Embrio Tanpa Hasrat\", dan \"Embrio Tanpa Keserakahan\" dari hadiah misi stage \"Rahim Kegelapan\" (termasuk Tayangan Ulang). Detail bonus sebagai berikut:\n·Awakened \"Murphy\": Kebangkitan Roh 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Kelahiran Tersembunyi\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Tidur di Bawah Gletser\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Embrio\" dari Awakened atau Roda Takdir yang berbeda dihitung secara kumulatif.\n3. Khususnya, hadiah tantangan penyelesaian pertama tingkat kesulitan Gila tidak terpengaruh oleh \"Bonus Embrio\".\n\n<Title: Penetasan Suci>\n1. \"Penetasan Suci\" hanya dibuka pada 10 Maret 9:00 - 31 Maret 9:00 (GMT+8).\n2. Setelah 31 Maret 9:00 (GMT+8), \"Embrio\" yang tersisa dan belum ditukarkan akan dikembalikan dengan rasio setiap unit ditukar menjadi \"Voucher Emas Mawar\" × 40. Harap Penjaga Rahasia periksa kotak surat."
  },
  Activity_73879_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_74213_ActivityName = {
    Text = "Persembahan Kenangan Perjalanan·Bab Bintang I"
  },
  Activity_74213_ActivityPlot = {
    Text = "Sebuah memori tersegel dan diarsipkan, sebuah perjalanan tercatat dalam masa lalu. Saat mengenang, jangan lupa persembahkan penghormatan yang tulus."
  },
  Activity_74340_ActivityName = {Text = "Giliranku"},
  Activity_74364_ActivityName = {
    Text = "Buku Detektif Terkenal · Replika"
  },
  Activity_74364_ActivityPlot = {
    Text = [[
Sebuah buku panduan yang tampak biasa saja.
Mencatat pemikiran dan pengalaman kerja selama bertahun-tahun dari seorang detektif terkenal.
Berharap dapat memberikan sedikit inspirasi bagi para pemuda yang bercita-cita menjadi detektif.]]
  },
  Activity_74364_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Klub Keberuntungan\""
  },
  Activity_74364_ActivityTips = {
    Text = "<Title:Ikhtisar Aktivitas>\n1. Selama periode aktivitas, Penjaga dapat mengumpulkan mata uang aktivitas \"Chip Penentu\" melalui permainan terbatas \"Cerita di Bawah Sinar Bulan\" dan \"Hadiah Prestasi\". \"Chip Penentu\" dapat ditukarkan di \"Klub Keberuntungan\" untuk hadiah yang melimpah, termasuk Roda Takdir eksklusif acara \"Roulette Nasib\", \"Inti Murni\", \"Inti Lumen\", \"Fragmentasi Batu Bijaksana\", \"Kristal Mimik\", dan lainnya.\n2. Selama periode aktivitas, menyelesaikan tugas \"Hadiah Prestasi\" dapat memperoleh avatar eksklusif acara \"Atas nama Kunci Perak: Ryker\", Roda Takdir eksklusif acara \"Roulette Nasib\", Perak, dan banyak mata uang aktivitas \"Chip Penentu\".\n3. Selama periode aktivitas, \"Rekam Jejak Satuan Tugas: Selamat Berburu!\" akan dibuka secara gratis.\n\n<Title: Waktu Aktivitas>\n1. 22 September 9:00 - 6 Oktober 9:00 (GMT+8), semua konten aktivitas dapat diikuti.\n2. 6 Oktober 9:00 - 13 Oktober 9:00 (GMT+8), hanya \"Klub Keberuntungan\" dan \"Hadiah Prestasi\" yang tersedia, konten lainnya sudah berakhir dan tidak dapat diikuti.\n\n<Title: Cerita di Bawah Sinar Bulan>\n1. \"Cerita di Bawah Sinar Bulan\" terdiri dari 9 tingkat, satu tingkat akan dibuka secara otomatis setiap hari.\n2. Setiap tantangan akan menghabiskan \"Menophin\" × 120, tantangan di tingkat yang berbeda selain mendapatkan jatuhan bahan yang berbeda, juga akan mendapatkan mata uang aktivitas \"Chip Penentu\".\n3. Tingkat aktivitas kali ini adalah tingkat bahan pertempuran langsung, setelah menyelesaikan dapat direproduksi! Setiap kali \"Reproduksi\" menghabiskan \"Menophin\" × 120.\n4. Harap diperhatikan: saat menggunakan fungsi \"Reproduksi\", tidak dapat memperoleh tingkat afinitas.\n\n<Title: Penambahan Chip>\n1. Penjaga yang memiliki awakener tertentu atau Roda Takdir (tidak harus dalam lineup) dapat membuat \"Chip Penentu\" dalam hadiah tugas tingkat \"Cerita di Bawah Sinar Bulan\" mendapatkan tambahan jatuhan (termasuk reproduksi), rincian tambahan adalah sebagai berikut:\n· Awakener \"Ryker\": Mencerahkan 0/1/2/3 dan lebih, tambahan 20%/30%/40%/50%\n· Roda Takdir SSR \"Waktu Keberuntungan\": Posisi Tumpuk 0/1/2/3 dan lebih, tambahan 20%/30%/40%/50%\n· Roda Takdir SR \"Roulette Nasib\": Posisi Tumpuk 0/1/2/3 dan lebih, tambahan 20%/30%/40%/50%\n2. \"Penambahan Chip\" dari awakener atau Roda Takdir yang berbeda akan dihitung secara kumulatif.\n3. Khususnya, hadiah tantangan pertama di tingkat kegilaan tidak akan terpengaruh oleh \"Penambahan Chip\".\n\n<Title: Klub Keberuntungan>\n1. \"Klub Keberuntungan\" hanya dibuka dari 22 September 9:00 - 13 Oktober 9:00 (GMT+8).\n2. Setelah 13 Oktober 9:00 (GMT+8), \"Chip Penentu\" yang belum ditukarkan akan ditarik kembali dengan rasio setiap penukaran \"Rose Scrip\" × 40, harap Penjaga memperhatikan untuk memeriksa email.\n\n<Title: Rekam Jejak Satuan Tugas>\n1. Selama periode aktivitas, \"Rekam Jejak Satuan Tugas: Selamat Berburu!\" akan dibuka secara gratis.\n2. Setelah aktivitas berakhir, kemajuan penyelidikan \"Rekam Jejak Satuan Tugas: Selamat Berburu!\" akan disimpan, jika \"Rekam Jejak Satuan Tugas: Selamat Berburu!\" tidak terbuka selama periode aktivitas, setelah aktivitas berakhir masih dapat menggunakan \"Titik Awal Realitas\" × 7 untuk membuka kuncinya.\n3. Baik selama atau setelah periode aktivitas, setelah menyelesaikan \"Rekam Jejak Satuan Tugas: Selamat Berburu!\" dapat memperoleh \"Posse: Raungan Senjata\".\n\n<Title: Kompensasi Replikasi>\n1. Penjaga yang telah membuka \"Rekam Jejak Satuan Tugas: Selamat Berburu!\" sebelumnya, akan mendapatkan kompensasi \"Chip Penentu\" × 700 saat membuka kembali selama periode aktivitas replikasi kali ini.\n2. Penjaga yang sebelumnya telah mendapatkan avatar eksklusif acara \"Atas nama Kunci Perak: Ryker\", saat mendapatkan ulang akan secara otomatis ditukar menjadi \"Undangan dari Yang Tidak Berbentuk\" × 1.\n"
  },
  Activity_74364_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_74365_ActivityName = {
    Text = "Selamat berburu!"
  },
  Activity_76217_ActivityName = {
    Text = "Perjalanan ke Abad Lain"
  },
  Activity_76217_ActivityTips = {
    Text = [[
Aturan Aktivitas:
1. Setelah Penjaga Rahasia menyelesaikan misi Chronicle yang ditentukan, hadiah dapat diklaim di "Chronicle Dunia Lain".
2. "Chronicle Dunia Lain" dibuka secara permanen.
3. Setelah membuka "Chronicle Premium", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
4. Harap diperhatikan: "Chronicle Premium" yang dibuka dalam aktivitas ini hanya berlaku untuk aktivitas ini. Penjaga Rahasia diharapkan untuk berbelanja secara bijak.]]
  },
  Activity_76218_ActivityName = {
    Text = "Kronik Kedatangan"
  },
  Activity_76218_ActivityTips = {
    Text = [[
Aturan Aktivitas:
1. Setelah Penjaga Rahasia menyelesaikan misi Chronicle yang ditentukan, hadiah dapat diklaim di "Chronicle Kedatangan".
2. "Chronicle Kedatangan" dibuka secara permanen.
3. Setelah membuka "Chronicle Premium", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
4. Harap diperhatikan: "Chronicle Premium" yang dibuka dalam aktivitas ini hanya berlaku untuk aktivitas ini. Penjaga Rahasia diharapkan untuk berbelanja secara bijak.]]
  },
  Activity_77970_ActivityName = {
    Text = "Putra Suci·Malam Putih"
  },
  Activity_77970_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara\"Putra Suci·Malam Putih\"berlangsung, Keeper dapat menggunakan tim preset sistem yang menyertakan Pollux untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage acara, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Acara>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman acara."
  },
  Activity_77972_ActivityName = {
    Text = "Serangga Hipnotis"
  },
  Activity_77972_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Serangga Hipnotis\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Clementine untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_77974_ActivityName = {
    Text = "Cahaya Dingin"
  },
  Activity_77974_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Cahaya Dingin\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Corpusant untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_77977_ActivityName = {
    Text = "Snow White Sang Peri"
  },
  Activity_77977_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Snow White Sang Peri\" berlangsung, Penjaga dapat menggunakan tim preset sistem yang berisi Caraboo untuk mengalami Tingkat yang ditentukan tanpa batas.\n·Saat mengalami Tingkat aktivitas, Awakener dalam Susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali mencapai tantangan Tingkat, dapat mengambil hadiah percobaan di antarmuka aktivitas."
  },
  Activity_77979_ActivityName = {
    Text = "Penguasa Ledakan Api"
  },
  Activity_77979_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Penguasa Ledakan Api\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Caligula untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_77980_ActivityName = {Text = "Arachne"},
  Activity_77980_ActivityTips = {
    Text = "<Title:Aturan Acara>\n· Selama periode acara \"Jaringan Abadi\" dibuka, Penjaga dapat menggunakan susunan tim sistem yang mencakup Arachne untuk merasakan tingkat yang ditentukan tanpa batas.\n· Saat merasakan tingkat acara, tidak dapat mengubah Awakener dalam susunan tim.\n<Title:Hadiah Acara>\n· Setelah pertama kali menyelesaikan tantangan tingkat, dapat mengambil hadiah percobaan di antarmuka acara."
  },
  Activity_77984_ActivityName = {Text = "Pelukis"},
  Activity_77984_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara\"Pelukis\"berlangsung, Keeper dapat menggunakan tim preset sistem yang menyertakan Pickman untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage acara, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Acara>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman acara."
  },
  Activity_78501_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_78501_ActivityPlot = {
    Text = [[
Setelah membeli, "Firaun Hitam" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, Membuka Ledakan Transenden>]]
  },
  Activity_78502_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_78502_ActivityPlot = {
    Text = [[
Setelah membeli, "Arachne" dapat mengaktifkan 
<BlueQuality:Pengembangan Kepribadian +4, membuka kunci Over-Exaltation>]]
  },
  Activity_78503_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_78503_ActivityPlot = {
    Text = "Setelah membeli, \"Corposant\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_78505_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_78505_ActivityPlot = {
    Text = [[
Setelah membeli, "Clementine" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_78506_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_78506_ActivityPlot = {
    Text = "Setelah membeli, \"Firaun Hitam\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_78507_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_78507_ActivityPlot = {
    Text = "Setelah membeli, \"Vulture\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_78508_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_78508_ActivityPlot = {
    Text = "Setelah membeli, \"Abhoth\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_78509_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_78509_ActivityPlot = {
    Text = "Setelah membeli, \"Pollux\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_78511_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_78511_ActivityPlot = {
    Text = [[
Setelah membeli, "Karab" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, Membuka Ledakan Transenden>]]
  },
  Activity_78513_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_78513_ActivityPlot = {
    Text = "Setelah membeli, \"Arachne\" dapat mengaktifkan<BlueQuality:Mencerahkan 3>"
  },
  Activity_78514_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_78514_ActivityPlot = {
    Text = "Setelah membeli, \"Pickman\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_78515_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_78515_ActivityPlot = {
    Text = [[
Setelah membeli, "Pickman" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_78516_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_78516_ActivityPlot = {
    Text = "Setelah membeli, \"Clementine\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_78517_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_78517_ActivityPlot = {
    Text = [[
Setelah membeli, "Corposant" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_78518_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_78518_ActivityPlot = {
    Text = [[
Setelah membeli, "Vulture" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, Membuka Ledakan Transenden>]]
  },
  Activity_78519_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_78519_ActivityPlot = {
    Text = [[
Setelah membeli, "Burung Shantak" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, Membuka Ledakan Transenden>]]
  },
  Activity_78521_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_78521_ActivityPlot = {
    Text = [[
Setelah membeli, "Pollux" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_78523_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_78523_ActivityPlot = {
    Text = [[
Setelah membeli, "Yafgomon" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, Membuka Ledakan Transenden>]]
  },
  Activity_78524_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_78524_ActivityPlot = {
    Text = [[
Setelah membeli, "Rantigos" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, Membuka Ledakan Transenden>]]
  },
  Activity_78525_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_78525_ActivityPlot = {
    Text = [[
Setelah membeli, "Castor" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_78526_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_78526_ActivityPlot = {
    Text = "Setelah membeli, \"Catigula\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_78531_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_78531_ActivityPlot = {
    Text = "Setelah membeli, \"Shantak\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_78532_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_78532_ActivityPlot = {
    Text = "Setelah membeli, \"Karab\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_78533_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_78533_ActivityPlot = {
    Text = "Setelah membeli, \"Castor\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_78534_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_78534_ActivityPlot = {
    Text = "Setelah membeli, \"Lanthigos\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_78536_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_78536_ActivityPlot = {
    Text = [[
Setelah membeli, "Catigula" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_78651_ActivityName = {Text = "Fisi Damai"},
  Activity_78652_ActivityName = {
    Text = "Penyembuhan Multi·Replika"
  },
  Activity_78652_ActivityPlot = {
    Text = [[
Hysteria, juga dikenal sebagai Histeria, gejala kejiwaan.
Di zaman kalian, itu memiliki arti yang sama dengan kematian.

Untungnya, para ilmuwan dan penyelidik di Universitas mythag juga sudah gila: mereka bertekad untuk mengatasi masalah ini]]
  },
  Activity_78652_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Analisis Kepribadian\""
  },
  Activity_78652_ActivityTips = {
    Text = "<Title:Ringkasan Aktivitas>\n1.Selama periode aktivitas, Penjaga dapat mengumpulkan mata uang aktivitas \"Puzzle Memori\" melalui gameplay terbatas \"Kode Memori\".\"Penyimpanan Tepi\", dan \"Hadiah Prestasi\". \"Puzzle Memori\" dapat digunakan untuk membeli barang di \"Analisis Kepribadian\", termasuk Roda takdir SR terbatas acara \"Tekad Ikan Kod Perak\".Inti Lumen, Inti Murni, dan lainnya.\n2.Selama periode aktivitas, \"Rekam Jejak Satuan Tugas: Fisi Damai\" dapat dibuka secara gratis untuk waktu terbatas, dan menyelesaikan prestasi aktivitas juga dapat memperoleh avatar terbatas acara \"Atas nama Kunci Perak:\"24\"\"!\n\n<Title:Waktu Aktivitas>\n1.21 April 9:00 - 5 Mei 9:00 (GMT+8), semua gameplay aktivitas dapat diikuti.\n2.5 Mei 9:00 - 12 Mei 9:00 (GMT+8), hanya dapat mengikuti \"Analisis Kepribadian\" dan Hadiah Prestasi.\n\n<Title:Kode Memori>\n1.\"Kode Memori\" terdiri dari 5 tingkat, satu tingkat akan dibuka otomatis setiap 2 hari.\n2.Setiap tantangan akan menghabiskan \"Menophin\"× 120, dan keberhasilan tantangan akan memberikan mata uang aktivitas.\n3.Setelah menyelesaikan tingkat, fungsionalitas \"Reproduksi\" untuk tingkat tersebut akan dibuka. Harap diperhatikan: saat menggunakan fungsi \"Reproduksi\", tidak akan mendapatkan tingkat afinitas.\n4.Anda dapat menggunakan bantuan alumni dan \"Resonansi: Sindrom Pemisahan\" untuk membantu Anda melewati tingkat dengan lebih mudah.\n\n<Title:Bonus Rasional>\n1.Penjaga yang memiliki Pembangun atau Roda takdir tertentu (tidak perlu diatur) dapat membuat \"Puzzle Memori\" dalam imbalan tugas tingkat \"Kode Memori\" mendapatkan bonus jatuh tambahan, rincian bonus sebagai berikut:\n·Pembangun \"24\": Mencerahkan 0/1/2/3 dan seterusnya, bonus 20%/30%/40%/50%.\n·Roda takdir SSR \"Restitusi Tubuh Terdistorsi\": Posisi Tumpuk 0/1/2/3 dan seterusnya, bonus 20%/30%/40%/50%.\n·Roda takdir SR \"Tekad Ikan Kod Perak\": Posisi Tumpuk 0/1/2/3 dan seterusnya, bonus 20%/30%/40%/50%.\n2.Bonus \"Rasional\" dari Pembangun atau Roda takdir yang berbeda dihitung dengan cara penumpukan.\n3.Secara khusus, hadiah tantangan pertama untuk tingkat kesulitan kegilaan tidak akan terpengaruh oleh bonus \"Rasional\".\n\n<Title:Resonansi: Sindrom Pemisahan>\n1.Penjaga dapat memperoleh \"Hati yang terbelah\" dengan menyelesaikan prestasi aktivitas.\n2.Menghabiskan \"Hati yang terbelah\", mengaktifkan \"Resonansi: Sindrom Pemisahan\", dapat memperoleh bonus berikut:\n(1)Membuat Penjaga lebih kuat dalam gameplay aktivitas \"Kode Memori\" dan \"Rekam Jejak Satuan Tugas: Fisi Damai\", tantangan menjadi lebih mudah.\n(2)Meningkatkan hadiah yang diperoleh setelah menyelesaikan tantangan \"Kode Memori\".\n(3)Mengaktifkan gameplay aktivitas \"Penyimpanan Tepi\".\n\n<Title:Penyimpanan Tepi>\n1.Setelah mengaktifkan resonansi \"Diagnosis: Skizofrenia\", setiap jam secara otomatis memperoleh 60 \"Puzzle Memori α\", maksimum dapat disimpan selama 25 jam.\n2.Setelah mengaktifkan resonansi \"Kesadaran Bersama\", setiap jam secara otomatis memperoleh 30 \"Puzzle Memori β\", maksimum dapat disimpan selama 25 jam.\n\n<Title:Rekam Jejak Satuan Tugas>\n1.Selama periode aktivitas, \"Rekam Jejak Satuan Tugas: Fisi Damai\" dapat dibuka secara gratis.\n2.Setelah aktivitas berakhir, kemajuan investigasi \"Rekam Jejak Satuan Tugas: Fisi Damai\" akan disimpan, menyelesaikan kejadian investigasi yang belum selesai selama periode aktivitas juga dapat memperoleh hadiah investigasi yang sama dengan periode aktivitas. Jika \"Rekam Jejak Satuan Tugas: Fisi Damai\" tidak dibuka selama periode aktivitas, setelah aktivitas berakhir masih dapat menghabiskan \"Titik awal realitas\"×7 untuk membuka kunci.\n3.Baik selama periode aktivitas atau tidak, setelah menyelesaikan \"Rekam Jejak Satuan Tugas: Fisi Damai\", dapat memperoleh \"Posse: Semua Tentang \"Dia\"\".\n\n<Title:Kompenasi Replikasi>\n1.Penjaga yang sebelumnya telah membuka \"Rekam Jejak Satuan Tugas: Fisi Damai\", saat membuka kembali selama periode aktivitas replikasi ini akan mendapatkan kompensasi \"Puzzle Memori α\"×700.\n2.Penjaga yang sebelumnya telah memperoleh avatar terbatas aktivitas \"Atas nama Kunci Perak:\"24\"\", saat memperoleh ulang akan secara otomatis ditukar menjadi \"Undangan dari Yang Tidak Berbentuk\"×1.\n3.Penjaga yang sebelumnya telah memperoleh bahan aktivasi resonansi \"Hati yang terbelah\", setiap kali mendapatkan 1 \"Hati yang terbelah\" tambahan akan secara otomatis ditukar menjadi \"Rose Scrip\"×5000.\n"
  },
  Activity_78652_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_78722_ActivityName = {
    Text = "Nyanyian Serangga Gelombang Gelap·Pemesanan Terbatas Waktu"
  },
  Activity_78722_ActivityTips = {
    Text = "<Title: Dengung Serangga Arus Gelap·Pra-Pembelian Terbatas Waktu>\n·Aktivitas pra-pembelian terbatas waktu ini mencakup 8 paket hadiah, di mana paket pertama dapat diklaim secara gratis, paket ke-2 hingga ke-8 harus membeli \"Dengung Serangga Arus Gelap·Pra-Pembelian Terbatas Waktu\" terlebih dahulu sebelum dapat diklaim.\n·Setelah membeli \"Dengung Serangga Arus Gelap·Pra-Pembelian Terbatas Waktu\", hadiah paket ke-2 dapat langsung diklaim; paket selanjutnya perlu menunggu waktu tertentu sebelum dapat diklaim.\n·\"Dengung Serangga Arus Gelap·Pra-Pembelian Terbatas Waktu\" memiliki batas waktu pembelian, setelah lewat tidak dapat dibeli lagi. Mohon Penjaga Rahasia membeli sebelum 7 April 9:00 sesuai pertimbangan."
  },
  Activity_78751_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_78751_ActivityPlot = {
    Text = "Setelah membeli, \"Tuan Tidur Asal\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_78752_ActivityName = {
    Text = "Teks sementara"
  },
  Activity_78752_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas \"Teks Sementara\" berlangsung, Penjaga dapat menggunakan tim preset sistem yang berisi Bintang Senja·Tinkter untuk mengalami Tingkat yang ditentukan tanpa batas.\n·Saat mengalami Tingkat aktivitas, Awakener dalam Susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali mencapai tantangan Tingkat, dapat mengambil hadiah percobaan di antarmuka aktivitas."
  },
  Activity_78753_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_78753_ActivityPlot = {
    Text = [[
Setelah membeli, "Asal Tuan Tertidur" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, Membuka Ledakan Transenden>]]
  },
  Activity_78776_ActivityName = {
    Text = "Ibu Dewa Keturunan Laut"
  },
  Activity_78776_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara\"Ibu Dewa Keturunan Laut\"berlangsung, Keeper dapat menggunakan tim preset sistem yang menyertakan Delusion·Murphy untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage acara, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Acara>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman acara."
  },
  Activity_78777_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_78777_ActivityPlot = {
    Text = "Setelah membeli, \"Delusional · Murphy\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_78778_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_78778_ActivityPlot = {
    Text = "Setelah membeli, \"Delusi·Murphy\" dapat mengaktifkan\n<BlueQuality:Pendalaman Persona +4, Membuka Ledakan Transenden>"
  },
  Activity_78790_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_78791_ActivityName = {
    Text = "Gunung Salju Mencair · Revisi"
  },
  Activity_78791_ActivityPlot = {
    Text = [[
Salju dan es Elvorth tak pernah mencair sepanjang tahun, seperti halnya dendamnya.
Saat tangan masa depan dan masa lalu saling bertaut, sang pejuang akan mengangkat pedangnya tinggi-tinggi, melancarkan serangan balas dendam terhadap takdir.
Saat ia menghadapi gelombang hitam, kaulah panjinya.]]
  },
  Activity_78791_ActivityStageEndContent = {
    Text = "Aktivitas telah berakhir, saat ini hanya dapat berpartisipasi di \"Mulut Raksasa Pegunungan\""
  },
  Activity_78791_ActivityTips = {
    Text = "<Title:Ringkasan Aktivitas>\n1. Selama periode aktivitas, Penjaga dapat mengumpulkan tiga jenis \"Bunga\" melalui gameplay terbatas \"Ambisi Binatang\" dan \"Hadiah Prestasi\". \"Bunga\" dapat ditukarkan di \"Mulut Raksasa Pegunungan\" untuk mendapatkan hadiah item, termasuk SR Roda takdir terbatas aktivitas \"Sampai gunung salju mencair\", \"Inti murni\", \"Inti Lumen\", \"Fragmentasi Batu Bijaksana\", \"Kristal Mimik\", dan lain-lain. \n2. Selama periode aktivitas, \"Rekam Jejak Satuan Tugas: Pengembalian Elworth\" akan dibuka secara gratis. \n\n<Title: Waktu Aktivitas>\n1. 19 Mei 9:00 - 2 Juni 9:00 (GMT+8), semua konten aktivitas dapat diikuti. \n2. 2 Juni 9:00 - 9 Juni 9:00 (GMT+8), hanya \"Mulut Raksasa Pegunungan\" dan \"Hadiah Prestasi\" yang tersedia, konten lainnya telah berakhir dan tidak dapat diikuti. \n\n<Title: Ambisi Binatang>\n1. \"Ambisi Binatang\" terdiri dari 5 level, satu level akan dibuka secara otomatis setiap 2 hari. \n2. Setiap tantangan akan menghabiskan \"Menophin\" × 120, dan keberhasilan tantangan akan memberikan mata uang aktivitas \"Bunga Beku\", \"Bunga Muda Berembun Perak\", dan \"Bunga Matahari Kecil\". \n3. Setelah menyelesaikan level, fitur \"Reproduksi\" untuk level tersebut akan dibuka. Harap dicatat: menggunakan fitur \"Reproduksi\" tidak akan memberikan afiniti. \n4. Anda dapat menggunakan bantuan alumni dan \"Resonansi: Devour Gunung\" untuk membantu Anda menyelesaikan level dengan lebih mudah. \n5. Pada hari kedua setelah level dibuka, tingkat kesulitan kegilaan untuk level tersebut akan dibuka. Menyelesaikan tantangan tingkat kesulitan kegilaan untuk pertama kalinya akan memberikan hadiah mata uang aktivitas yang melimpah. \n6. Harap dicatat: tantangan tingkat kesulitan kegilaan tidak menghabiskan Menophin, tidak dapat direproduksi, dan setelah menyelesaikan untuk pertama kalinya, tantangan ulang tidak akan memberikan hadiah mata uang aktivitas lagi. \n\n<Title: Bonus Bunga>\n1. Penjaga yang memiliki Awakener atau Roda takdir tertentu (tidak perlu diatur) dapat membuat hadiah tugas level \"Ambisi Binatang\" berupa \"Bunga Beku\", \"Bunga Muda Berembun Perak\", dan \"Bunga Matahari Kecil\" mendapatkan bonus jatuh tambahan (termasuk reproduksi), rincian bonus adalah sebagai berikut: \n· Awakener \"Rantai Darah: Helot\": Pencerahan 0/1/2/3 dan lebih, bonus 20%/30%/40%/50% \n· Roda takdir SSR \"Tenggelam dalam Merah Abadi\": Posisi Tumpuk 0/1/2/3 dan lebih, bonus 20%/30%/40%/50% \n· Roda takdir SR \"Sampai gunung salju mencair\": Posisi Tumpuk 0/1/2/3 dan lebih, bonus 20%/30%/40%/50% \n2. Bonus \"Bunga\" dari Awakener atau Roda takdir yang berbeda dihitung secara akumulatif. \n3. Khusus, hadiah tantangan untuk menyelesaikan tingkat kesulitan kegilaan untuk pertama kalinya tidak akan dipengaruhi oleh \"Bonus Bunga\". \n\n<Title: Resonansi: Devour Gunung>\n1. Penjaga dapat memperoleh \"Hati Pemakan\" dengan menyelesaikan pencapaian aktivitas. \n2. Menghabiskan \"Hati Pemakan\", mengaktifkan \"Resonansi: Devour Gunung\", akan membuat Penjaga lebih kuat dalam gameplay aktivitas \"Ambisi Binatang\", tantangan menjadi lebih mudah. \n\n<Title: Mulut Raksasa Pegunungan>\n1. \"Mulut Raksasa Pegunungan\" memiliki tiga toko tukar, waktu pembukaannya adalah sebagai berikut: \n· \"Ambisi yang melahap\": Dibuka pada 19 Mei pukul 9:00. \n· \"Niat untuk balas dendam\": Dibuka pada 21 Mei pukul 9:00. \n· \"Harapan Kelahiran Kembali\": Dibuka pada 23 Mei pukul 9:00. \n2. Setiap pertukaran akan menghabiskan 750 \"Bunga Beku\"/\"Bunga Muda Berembun Perak\"/\"Bunga Matahari Kecil\", secara acak mendapatkan lima hadiah item dari toko tukar. \n3. Hadiah item dari setiap toko tukar dibagi menjadi dua jenis: \"Item Spesial\" dan \"Item Umum\", saat reset, jumlah sisa hadiah item spesial dapat direset ke batas maksimum, aturan spesifik adalah: \n(1) Dua reset pertama: Ketika \"Item Spesial\" tidak memiliki sisa, Penjaga dapat memilih untuk mereset, setelah reset, jumlah sisa \"Item Spesial\" dan \"Item Umum\" akan direset ke batas maksimum; juga dapat memilih untuk terus bertukar, ketika \"Item Umum\" juga tidak memiliki sisa, harus melakukan reset untuk melanjutkan pertukaran. \n(2) Reset mulai dari yang ketiga: Hanya dapat melakukan reset ketika \"Item Umum\" tidak memiliki sisa, reset akan mengatur ulang jumlah sisa \"Item Umum\" ke batas maksimum, \"Item Spesial\" tidak akan direset lagi. \n4. Setelah 9 Juni pukul 9:00 (GMT+8), \"Bunga\" yang belum ditukarkan akan dihitung kembali dengan rasio 40 \"Rose Scrip\" per item, harap Penjaga memperhatikan email. \n\n<Title: Rekam Jejak Satuan Tugas>\n1. Selama periode aktivitas, \"Rekam Jejak Satuan Tugas: Pengembalian Elworth\" akan dibuka secara gratis. Setelah menyelesaikan \"Rekam Jejak Satuan Tugas: Pengembalian Elworth\", Anda dapat memperoleh hadiah Roda takdir terbatas aktivitas SR \"Sampai gunung salju mencair\" dalam Hadiah Prestasi, hadiah prestasi hanya dibuka selama periode aktivitas, setelah aktivitas berakhir tidak dapat diselesaikan dan diambil. \n2. Setelah aktivitas berakhir, kemajuan penyelidikan \"Rekam Jejak Satuan Tugas: Pengembalian Elworth\" akan disimpan, jika \"Rekam Jejak Satuan Tugas: Pengembalian Elworth\" tidak dibuka selama periode aktivitas, setelah aktivitas berakhir masih dapat menghabiskan \"Titik awal realitas\" ×7 untuk membuka kuncinya. \n3. Terlepas dari apakah selama periode aktivitas, setelah menyelesaikan \"Rekam Jejak Satuan Tugas: Pengembalian Elworth\", Anda akan mendapatkan \"Posse: Tekad Sang Gunung\"."
  },
  Activity_78791_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_79851_ActivityName = {
    Text = "Cahaya Perak Memulai Perjalanan·Bonus Awal"
  },
  Activity_79851_ActivityPlot = {
    Text = [[
Cahaya perak memberikan berkat tulus untuk perjalanan setiap Keeper baru. Semoga Kunci Perak menuntun jalan ke depan.
*Setelah dibeli, dapat digunakan di"Material-Barang Konsumsi".]]
  },
  Activity_80163_ActivityName = {
    Text = "Pasien Terbelah·Hyperdimensi"
  },
  Activity_80163_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara \"Pasien Skizofren·Ultra\" berlangsung, Penjaga dapat menggunakan susunan tim preset sistem yang mencakup \"24\", untuk menikmati tingkat yang ditentukan tanpa batas.\n·Saat menikmati tingkat acara, Awakener dalam susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Acara>\n·Setelah berhasil menyelesaikan tantangan tingkat untuk pertama kalinya, hadiah percobaan dapat diambil di antarmuka acara."
  },
  Activity_80164_ActivityName = {
    Text = "Pasien Terbelah·Daging Darah"
  },
  Activity_80164_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara \"Pasien skizofren · Caro\" berlangsung, Penjaga dapat menggunakan susunan tim preset sistem yang mencakup \"24\", untuk menikmati tingkat yang ditentukan tanpa batas.\n·Saat menikmati tingkat acara, Awakener dalam susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Acara>\n·Setelah berhasil menyelesaikan tantangan tingkat untuk pertama kalinya, hadiah percobaan dapat diambil di antarmuka acara."
  },
  Activity_80165_ActivityName = {
    Text = "Pasien Terbelah·Laut Dalam"
  },
  Activity_80165_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara \"Pasien Skizofren·Laut Dalam\" berlangsung, Penjaga dapat menggunakan susunan tim preset sistem yang mencakup \"24\", untuk menikmati tingkat yang ditentukan tanpa batas.\n·Saat menikmati tingkat acara, Awakener dalam susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Acara>\n·Setelah berhasil menyelesaikan tantangan tingkat untuk pertama kalinya, hadiah percobaan dapat diambil di antarmuka acara."
  },
  Activity_80166_ActivityName = {
    Text = "Pasien Terbelah·Chaos"
  },
  Activity_80166_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara \"Pasien Skizofren·Kaos\" berlangsung, Penjaga dapat menggunakan susunan tim preset sistem yang mencakup \"24\", untuk menikmati tingkat yang ditentukan tanpa batas.\n·Saat menikmati tingkat acara, Awakener dalam susunan tim tidak dapat disesuaikan.\n<Title:Hadiah Acara>\n·Setelah berhasil menyelesaikan tantangan tingkat untuk pertama kalinya, hadiah percobaan dapat diambil di antarmuka acara."
  },
  Activity_80167_ActivityName = {
    Text = "Pencabut Jiwa"
  },
  Activity_80167_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Pencabut Jiwa\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Rantai Darah·Shilo untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_80311_ActivityName = {
    Text = "Persembahan Kenangan Perjalanan·Bab Bintang II"
  },
  Activity_80311_ActivityPlot = {
    Text = "Sebuah memori tersegel dan diarsipkan, sebuah perjalanan tercatat dalam masa lalu. Saat mengenang, jangan lupa persembahkan penghormatan yang tulus."
  },
  Activity_80312_ActivityName = {
    Text = "Perjalanan Penyembuhan"
  },
  Activity_80312_ActivityTips = {
    Text = [[
Aturan Aktivitas:
1. Setelah Penjaga Rahasia menyelesaikan misi Chronicle yang ditentukan, hadiah dapat diklaim di "Chronicle Pemulihan".
2. "Chronicle Pemulihan" dibuka secara permanen.
3. Setelah membuka "Chronicle Premium", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
4. Harap diperhatikan: "Chronicle Premium" yang dibuka dalam aktivitas ini hanya berlaku untuk aktivitas ini. Penjaga Rahasia diharapkan untuk berbelanja secara bijak.]]
  },
  Activity_81019_ActivityName = {
    Text = "Perjalanan Ajaib Pembersihan"
  },
  Activity_81019_ActivityPlot = {
    Text = [[
Siapakah yang berkelana di Kadath yang penuh ilusi, membersihkan sampah untuk tuan rumah? 
Ini Karen~ Ini Karen! 
Membersihkan pelarutan~ Mimpi ventilasi~ Dimensi disinfeksi~ Membersihkan semuanya~
Bagaimanapun dalam hal pembersihan, Karen saya adalah yang ahli!
Apakah tuan ingin mencoba! Karen akan mengajarkan seni pembersihan kepada tuan tanpa reservasi!]]
  },
  Activity_81019_ActivityTips = {
    Text = "<Title:กิจกรรมภาพรวม>\n1. ในช่วงกิจกรรม Penjaga bisa berpartisipasi dalam \"Progres Pembersihan\" dan memperoleh \"Alat Kebersihan\".\n2. Setelah \"Alat Kebersihan\" terkumpul mencapai jumlah tertentu, bisa menerima hadiah berharga dari \"Tunjangan Penghilang Debu\", termasuk avatar eksklusif acara \"Master Pembersih\", Perak, Inti murni, dan pecahan batu bijak.\n\n<Title:Progres Pembersihan>\n1. \"Progres Pembersihan\" terdiri dari beberapa jenis tugas pembersihan yang berbeda, Penjaga bisa mendapatkan \"Alat Kebersihan\" dengan menyelesaikan tugas pembersihan ini, dan ada hadiah tambahan setelah menyelesaikan semua jenis tugas pembersihan setiap hari!\n2. Selama acara, setiap tugas pembersihan jenis pertama yang selesai akan memutarkan cerita rahasia.\n3. \"Progres Pembersihan\" akan segar reset setiap hari pukul 9:00 (GMT+8) selama acara.\n\n<Title:Tunjangan Penghilang Debu>\n1. Penjaga mengumpulkan \"Alat Kebersihan\" untuk menerima hadiah sesuai, setiap 1000 \"Alat Kebersihan\" dapat menerima hadiah inventaris yang cukup besar, dan setelah mencapai 10000 \"Alat Kebersihan\" dapat memperoleh avatar eksklusif \"Master Pembersih\".\n\n<Title:Hadiah Karen>\nSelama acara, bisa menerima hadiah yang disiapkan oleh Karen untuk Penjaga dengan melakukan check-in di \"Hadiah Karen\"!\n\n<Title:Waktu Acara>\nAcara ini hanya dibuka dari 28 April 9:00 hingga 12 Mei 9:00 (GMT+8), acara berakhir setelah 12 Mei 9:00 (GMT+8), harap Penjaga ingat untuk mengklaim hadiah dari \"Tunjangan Penghilang Debu\"!"
  },
  Activity_81019_BannerText = {
    Text = "Aktivitas Spesial Dibuka Terbatas!"
  },
  Activity_81178_ActivityName = {
    Text = "Dalam hujan lebat, bergoyang"
  },
  Activity_81178_ActivityPlot = {
    Text = [[
Hujan deras curah deras dari langit kelabu, menghantam permukaan laut dengan suara gaduh.
Guntur yang kejam menggempurkan semau yang menandakan kedatangan ketakutan tak terhingga di bawah permukaan laut.
Nautilus yang megah bergoyang lemah seperti bayi yang baru belajar berjalan, terombang-ambing dalam gelombang yang menghantam.
Tak satu pun yang tahu takdirnya, seperti ketika laut yang tidak bisa ditentukan menunjukkan kemarahannya, orang-orang baru menyadari betapa kecilnya mereka.]]
  },
  Activity_81178_ActivityStageEndContent = {
    Text = "Aktivitas telah berakhir, saat ini hanya bisa berpartisipasi dalam \"Harta Karun Kru\""
  },
  Activity_81178_ActivityTips = {
    Text = "<Title:Ikhtisar Kegiatan>\nSelama periode kegiatan, Penjaga dapat mengumpulkan mata uang kegiatan \"Bendera Sinyal\" melalui permainan terbatas \"Terdampar di Laut Mendalam\" dan \"Hadiah Prestasi\", \"Bendera Sinyal\" dapat ditukarkan di \"Harta Karun Kru\" untuk mendapatkan hadiah, termasuk SR Roda takdir eksklusif kegiatan \"Navigator di Lautan\", Inti Lumen, Inti murni, Fragmentasi Batu Bijaksana, Kristal Mimik, dan lainnya.\n\n<Title:Terdampar di Laut Mendalam>\n1, \"Terdampar di Laut Mendalam\" terdiri dari 9 level bahan yang dapat langsung bertarung tanpa eksplorasi, dibuka satu setiap hari.\n2, Setiap tantangan akan mengkonsumsi \"Menophin\" × 120, keberhasilan tantangan akan memberikan bahan pelatihan dan mata uang kegiatan.\n3, Setelah menyelesaikan level, fitur \"Reproduksi\" untuk level tersebut akan dibuka. Harap dicatat: saat menggunakan fitur \"Reproduksi\", tidak dapat memperoleh Affiniti.\n4, Dapat menggunakan bantuan alumni untuk membantu Anda menyelesaikan level dengan lebih mudah.\n\n<Title:Bonus Bendera Sinyal>\n1, Penjaga yang memiliki Awakeners atau Roda takdir tertentu (tidak perlu dalam formasi) dapat membuat \"Bendera Sinyal\" dalam imbalan tugas level \"Terdampar di Laut Mendalam\" mendapatkan bonus jatuh tambahan (termasuk Reproduksi), rincian bonus adalah sebagai berikut:\n·Awakener \"Corposant\": Mencerahkan 0/1/2/3 dan di atas, bonus 20%/30%/40%/50%\n·SSR Roda takdir \"Navigator Dari Nyala APi\": Posisi Tumpuk 0/1/2/3 dan di atas, bonus 20%/30%/40%/50%\n·SR Roda takdir \"Navigator di Lautan\": Posisi Tumpuk 0/1/2/3 dan di atas, bonus 20%/30%/40%/50%\n2, Bonus \"Bendera Sinyal\" dari berbagai Awakeners atau Roda takdir dihitung dengan cara yang terakumulasi.\n3, Khususnya, hadiah tantangan pertama untuk tingkat Kegilaan tidak akan terpengaruh oleh bonus di atas.\n\n<Title:Harta Karun Kru>\n1, Setiap kali \"Menyerahkan Bendera\" akan mengkonsumsi 750 \"Bendera Sinyal\", secara acak mendapatkan lima hadiah dari \"Harta Karun Kru\".\n2, Hadiah item dari \"Harta Karun Kru\" dibagi menjadi dua jenis, yaitu \"Item Spesial\" dan \"Item Umum\", saat reset dapat mengatur ulang jumlah sisa hadiah item spesial ke batas maksimum, aturan spesifik adalah:\n(1) Lima reset pertama: Ketika \"Item Spesial\" tidak memiliki sisa, Penjaga dapat memilih untuk mereset, setelah reset jumlah sisa \"Item Spesial\" dan \"Item Umum\" akan direset ke maksimum; juga dapat memilih untuk terus bertukar, ketika \"Item Umum\" juga tidak memiliki sisa, harus melakukan reset untuk melanjutkan pertukaran.\n(2) Reset ke-6 dan seterusnya: Ketika \"Item Umum\" tidak memiliki sisa, baru dapat mereset, reset akan mengatur ulang jumlah sisa \"Item Umum\" ke maksimum, \"Item Spesial\" tidak akan direset lagi.\n\n<Title:Waktu Kegiatan>\n1, 5 Mei 9:00 - 19 Mei 9:00 (GMT+8), semua konten dalam ikhtisar kegiatan dapat diikuti.\n2, 19 Mei 9:00 - 26 Mei 9:00 (GMT+8), hanya \"Harta Karun Kru\" dan \"Hadiah Prestasi\" yang dipertahankan, konten lainnya telah selesai dan tidak dapat diikuti.\n3, Setelah 26 Mei 9:00 (GMT+8), \"Bendera Sinyal\" yang tersisa yang belum ditukarkan akan dikumpulkan sesuai dengan proporsi setiap 1 ditukar dengan \"Rose Scrip\" × 40, harap Penjaga memperhatikan untuk memeriksa email."
  },
  Activity_81178_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_81179_ActivityName = {
    Text = "Pemanduan terakhir"
  },
  Activity_81771_ActivityName = {
    Text = "Bayangan yang mengintip Ranah dewa"
  },
  Activity_81771_ActivityPlot = {
    Text = [[
Tak seorang pun melihat cahaya suci dari ranah dewa, tetapi dari kebenaran yang secara kebetulan terungkap, orang-orang dapat merasakan bayangan ranah dewa.
Ia ada di sana, selalu ada di sana, dan tak terhitung orang yang saleh akan membuatnya benar-benar turun.
Apa pun dosa berat yang harus dibayar.]]
  },
  Activity_81771_ActivityStageEndContent = {
    Text = "Acara telah berakhir"
  },
  Activity_81771_ActivityTips = {
    Text = "<Title: Arus Laut yang Berubah>\n· \"Arus Laut yang Berubah\" terdiri dari 7 tingkat, 3 tingkat pertama dibuka pada hari pertama acara, dan setiap 3 hari akan membuka 1 tingkat. Setiap tingkat memiliki hadiah yang berbeda-beda!\n· Setiap jenis \"Arus Laut yang Berubah\" memiliki banyak kelompok, setiap kali kelompok dari jenis tertentu berhasil ditantang oleh penjaga mana pun, jumlah kelompok dari jenis \"Arus Laut yang Berubah\" tersebut akan berkurang 1. Ketika semua kelompok dari jenis Arus Laut yang Berubah tersebut dihancurkan, tingkat yang sesuai akan ditutup dan tidak dapat ditantang lagi.\n· Setiap penjaga dapat mengusir kelompok \"Arus Laut yang Berubah\" hingga 20 kali per hari, jumlah ini akan direset setiap hari pada pukul 9:00 (GMT+8) selama acara berlangsung.\n· Setiap tingkat akan menyediakan berbagai relik yang akan memberikan peningkatan yang kuat untukmu.\n· Semua tingkat harus memilih bantuan, selama acara, setiap penjaga yang saling mengikuti hanya dapat memberikan bantuan sekali untukmu.\n· Penjaga perlu menyelesaikan setidaknya 2-9 operasi penyelidikan untuk dapat berpartisipasi dalam acara ini.\n\n<Title: Kompensasi Tingkat>\n· Dalam \"Melihat bayangan dari Negara Dewa: Arus Laut yang Berubah\" terdapat mekanisme kompensasi tingkat, agar para penjaga dapat bersama-sama menahan invasi!\nAturan kompensasi tingkat adalah sebagai berikut:\n · Dalam tim penyelidikan, awak yang tingkatnya kurang dari 60 akan dikompensasi hingga tingkat 60 dalam tantangan ini.\n· Dalam tim penyelidikan, awak yang tingkat keterampilannya kurang dari 5 akan dikompensasi hingga tingkat 5 dalam tantangan ini.\n· Dalam tim penyelidikan, awak yang \"Kegilaan\" kurang dari 6 akan dikompensasi hingga tingkat 6 dalam tantangan ini.\n· Dalam tim penyelidikan, awak yang \"Soulforge Aptitude\" kurang dari 5 akan dikompensasi hingga tingkat 5 dalam tantangan ini.\n · Jika tingkat penjaga kurang dari 60, dalam tantangan ini akan dikompensasi hingga 60.\n\n<Title: Tugas Terbatas>\n· Selama acara, jika berhasil mengusir 30 kali Arus Laut yang Berubah, tugas terbatas akan selesai, dan kamu akan mendapatkan \"Kupon Menggambar Pakaian Hantu (Tahap 1)\" ×1!\n· Dari 26 Mei 9:00 hingga 9 Juni 9:00 (GMT+8), kamu dapat menggunakan \"Kupon Menggambar Pakaian Hantu (Tahap 1)\" di \"Toko: Pemesanan Pakaian Fantasi\" untuk menukarkan pakaian fantasi sederhana.\n· Untuk lebih banyak cara mendapatkan \"Kupon Menggambar Pakaian Hantu (Tahap 1)\", silakan lihat di komunitas dan pengumuman."
  },
  Activity_81771_BannerText = {
    Text = "Aktivitas Spesial Dibuka Terbatas!"
  },
  Activity_83305_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83306_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83307_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83308_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83309_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83310_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83311_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83312_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83313_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83314_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83315_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83316_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83317_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83318_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83319_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83320_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83321_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83322_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83323_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83324_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83325_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83326_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83327_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83328_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83329_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83330_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83331_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83332_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83333_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83334_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83335_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83336_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83337_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_83338_ActivityName = {
    Text = "Jurang Korosi"
  },
  Activity_84175_ActivityName = {
    Text = "Perjalanan Hukum Kebangkitan"
  },
  Activity_84175_ActivityTips = {
    Text = "Aturan Aktivitas:\n1. Setelah Penjaga Rahasia menyelesaikan misi perjalanan yang ditentukan, hadiah dapat diklaim di\"Perjalanan Pemulihan\".\n2·Misi dibagi menjadi beberapa grup, satu grup dibuka setiap hari setelah aktivitas dimulai.\n3. Setelah membuka\"Perjalanan Pemulihan\", hadiah tambahan dapat diklaim setelah menyelesaikan misi.\n4. Harap diperhatikan: \"Perjalanan Pemulihan\"yang dibuka dalam aktivitas ini hanya berlaku untuk aktivitas ini. Penjaga Rahasia disarankan untuk berbelanja secara bijak."
  },
  Activity_84176_ActivityName = {
    Text = "Perjalanan Waktu"
  },
  Activity_84176_ActivityTips = {
    Text = "Aturan Aktivitas:\n1. Setelah Penjaga Rahasia menyelesaikan misi perjalanan yang ditentukan, hadiah dapat diklaim di\"Perjalanan Belenggu Waktu\".\n2·Misi dibagi menjadi beberapa grup, satu grup dibuka setiap hari setelah aktivitas dimulai.\n3. Setelah membuka\"Perjalanan Belenggu Waktu\", hadiah tambahan dapat diklaim setelah menyelesaikan misi.\n4. Harap diperhatikan: \"Perjalanan Belenggu Waktu\"yang dibuka dalam aktivitas ini hanya berlaku untuk aktivitas ini. Penjaga Rahasia disarankan untuk berbelanja secara bijak."
  },
  Activity_89008_ActivityName = {
    Text = "Pengikut Dimensi yang Berputar"
  },
  Activity_89008_ActivityPlot = {
    Text = "Dia telah melintasi dimensi yang tak terhitung, dunia yang tak terhitung, mengalami harapan dan keputusasaan yang tak terhitung, tetapi dia tidak akan berhenti melangkah. Karena, dia tahu dengan jelas tujuannya — tempat di mana kamu berada."
  },
  Activity_89008_ActivityTips = {
    Text = "<Title:Pengantar>\n1. Selama event berlangsung, Keeper dapat mengklaim hadiah check-in harian di\"Pengikut Dimensi yang Berputar\"setiap hari setelah login.\n2. Hadiah akan dibuka secara berurutan berdasarkan login kumulatif Keeper, hadiah check-in harian akan direset pada pukul 9:00 (GMT+8).\n\n<Title:Misi Terbatas Waktu>\n·Selama event berlangsung, login kumulatif 7 hari untuk menyelesaikan misi terbatas waktu dan mendapatkan\"Voucher Desain Illusory Outfit Sederhana (Periode Satu)\"×1!\n·Pada periode 26 Mei 9:00 - 9 Juni 9:00 (GMT+8), dapat menggunakan\"Voucher Desain Illusory Outfit Sederhana (Periode Satu)\"di\"Toko: Pemesanan Illusory Outfit\"untuk menukarkan Illusory Outfit sederhana.\n·Cara lain untuk mendapatkan\"Voucher Desain Illusory Outfit Sederhana (Periode Satu)\"dapat dilihat di komunitas dan pengumuman."
  },
  Activity_89008_BannerText = {
    Text = "Check-in untuk Klaim Pristine Core Berlimpah"
  },
  Activity_89576_ActivityName = {
    Text = "Semoga Harapan Bertunas Kembali"
  },
  Activity_89576_ActivityPlot = {
    Text = "Login harian untuk mengklaim Fate Wheel SSR edisi peringatan terbatas\"Terlahir Kembali dari Tanah Musnah\", total dapat diklaim 16 buah!"
  },
  Activity_89576_ActivityTips = {
    Text = "<Title:Pengantar>\nDunia sedang runtuh. Di dunia seperti ini, keputusasaan adalah hal biasa, penderitaan adalah hal biasa. Aku harus terbiasa. Tapi… masih ada kehangatan yang bersembunyi di hatiku, menunggu untuk meledak keluar.\n\n<Title:Aturan Event>\n·Selama event berlangsung, Keeper dapat mengklaim Fate Wheel SSR edisi peringatan terbatas\"Terlahir Kembali dari Tanah Musnah\"setiap hari setelah login di\"Semoga Harapan Bertunas Kembali\", total dapat diklaim 16 kali.\n·Hadiah akan dibuka secara berurutan berdasarkan login kumulatif Keeper, hadiah login harian akan direset pada pukul 9:00 (GMT+8)."
  },
  Activity_89576_BannerText = {
    Text = "Klaim Fate Wheel SSR Terbatas Gratis"
  },
  Activity_89729_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_89730_ActivityName = {
    Text = "Tahanan Cermin"
  },
  Activity_89730_ActivityPlot = {
    Text = [[
Burung terbang, mengapa kaki mu terikat dengan belenggu yang putus?
Burung terbang, mengapa kamu bernyanyi sendirian di langit tinggi?
Bebaskan diri dari duri, larikan diri dari sangkar, kamu terbang melewati gurun yang luas, namun suara nyanyian sedihmu tak pernah berhenti. Siapa sebenarnya yang menjadi sahabat setia yang kamu cari? Di mana sebenarnya rumah yang kamu cari?]]
  },
  Activity_89730_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat berpartisipasi dalam \"Keinginan Pengetahuan\""
  },
  Activity_89730_ActivityTips = {
    Text = "<Title:Deskripsi Kegiatan>\n1. Selama periode kegiatan, Penjaga dapat mengumpulkan mata uang acara \"Buku Kebijaksanaan Umum\", \"Buku Matematika\", \"Buku Sastra\" melalui gameplay terbatas \"Melompati Langit Biru\", \"Perjalanan Impian\", dan \"Hadiah Prestasi\". \"Buku Kebijaksanaan Umum\", \"Buku Matematika\", \"Buku Sastra\" dapat digunakan untuk membeli barang di \"Keinginan untuk mengetahui\", termasuk SR Roda Takdir terbatas acara \"Sehelai Bulu\", Inti Lumen, Inti Murni, dan lain-lain. \n2. Selama periode kegiatan, \"Lanskap mimpi: Di luar cakrawala·Atas\" dapat dibuka secara gratis untuk waktu terbatas, dan menyelesaikan pencapaian acara juga dapat memperoleh avatar terbatas acara \"Atas nama Kunci Perak: Castor\"! \n\n<Title:Waktu Kegiatan>\n1. 2 Juni 9:00 - 16 Juni 9:00 (GMT+8), semua gameplay acara dapat diikuti. \n2. 16 Juni 9:00 - 23 Juni 9:00 (GMT+8), hanya dapat berpartisipasi dalam \"Keinginan untuk mengetahui\" dan Hadiah Prestasi. \n\n<Title:Melompati Langit Biru>\n1. \"Melompati Langit Biru\" terdiri dari 7 tingkat, satu tingkat akan dibuka secara otomatis setiap hari. \n2. Setiap tantangan akan menghabiskan \"Menophin\" × 120, dan menyelesaikan tantangan akan mendapatkan mata uang acara. \n3. Setelah menyelesaikan tingkat, fungsi \"Reproduksi\" untuk tingkat tersebut akan dibuka. Harap diperhatikan: saat menggunakan fungsi \"Reproduksi\", tidak akan mendapatkan Affiniti. \n4. Dapat menggunakan bantuan alumni untuk membantu Anda melewati tingkat dengan lebih mudah. \n\n<Title:Keinginan untuk Mengetahui>\n\"Keinginan untuk mengetahui\" memiliki tiga toko, waktu pembukaan sebagai berikut: \n· \"Mata Kuliah Pilihan Umum\": Dibuka pada 2 Juni pukul 9:00. \n· \"Mata Pelajaran Pilihan Sains\": Dibuka pada 4 Juni pukul 9:00. \n· \"Mata Kuliah Pilihan Sastra\": Dibuka pada 6 Juni pukul 9:00. \nDi dalam toko, Anda dapat memilih barang dan langsung membelinya. \n\n<Title:Bonus Kegiatan>\n1. Penjaga yang memiliki Awakener atau Roda Takdir tertentu (tidak perlu diatur) dapat memberikan bonus tambahan pada hadiah tugas di tingkat \"Melompati Langit Biru\" berupa \"Buku Kebijaksanaan Umum\", \"Buku Matematika\", \"Buku Sastra\", rincian bonus sebagai berikut: \n· Awakener \"Castor\": Mencerahkan 0/1/2/3 dan seterusnya, bonus 20%/30%/40%/50%. \n· SSR Roda Takdir \"Kebebasan yang Menyiksa\": Posisi Tumpuk 0/1/2/3 dan seterusnya, bonus 20%/30%/40%/50%. \n· SR Roda Takdir \"Sehelai Bulu\": Posisi Tumpuk 0/1/2/3 dan seterusnya, bonus 20%/30%/40%/50%. \n2. Bonus \"Kegiatan\" dari Awakener atau Roda Takdir yang berbeda akan dihitung secara akumulatif. \n3. Khususnya, hadiah tantangan pertama kali pada tingkat kegilaan tidak akan dipengaruhi oleh \"bonus kegiatan\". \n\n<Title:Perjalanan Impian>\n1. Setiap jam secara otomatis memperoleh 60 \"Buku Kebijaksanaan Umum\", maksimum dapat disimpan selama 25 jam. \n\n<Title:Lanskap Mimpi>\n1. Selama periode kegiatan, \"Lanskap mimpi: Di luar cakrawala·Atas\" dapat dibuka secara gratis. \n2. Setelah kegiatan berakhir, kemajuan investigasi \"Lanskap mimpi: Di luar cakrawala·Atas\" akan dipertahankan, dan menyelesaikan kejadian investigasi yang belum selesai selama periode kegiatan juga dapat memperoleh hadiah investigasi yang sama dengan periode kegiatan. Jika \"Lanskap mimpi: Di luar cakrawala·Atas\" tidak dibuka selama periode kegiatan, setelah kegiatan berakhir tetap dapat menggunakan \"Titik awal realitas\" × 7 untuk membuka kuncinya. \n3. Baik selama periode kegiatan maupun tidak, setelah menyelesaikan \"Lanskap mimpi: Di luar cakrawala·Atas\" dapat memperoleh \"Posse: Nasib yang Tersesat\"."
  },
  Activity_89730_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_89899_ActivityName = {
    Text = "Pembuatan Ilusi Pakaian"
  },
  Activity_89899_ActivityTips = {
    Text = [[
<Title:Pengantar Event>
1, Selama event berlangsung, Penjaga Rahasia dapat menggunakan "Monokel Ilusi" untuk melakukan penarikan. Jumlah "Monokel Ilusi" yang dibutuhkan akan bertambah setiap kali penarikan.
2, Ilusi Pakaian Silver Pivot berpeluang didapatkan mulai dari penarikan ke-5. Menyelesaikan 10 kali penarikan dijamin mendapatkan Ilusi Pakaian Silver Pivot periode tersebut.
3, Setelah event berakhir, sisa "Monokel Ilusi" akan otomatis dikonversi menjadi Source Fluid.]]
  },
  Activity_89899_BannerText = {
    Text = "Event undian dibuka dalam waktu terbatas!"
  },
  Activity_90052_ActivityName = {Text = "Otak Busuk"},
  Activity_90052_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Otak Busuk\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup\"Meltdown·Dor\"untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_90493_ActivityName = {
    Text = "Pelatihan Pertempuran"
  },
  Activity_90493_ActivityTips = {
    Text = [[
Aturan Event:
1. Penjaga Rahasia dapat mempelajari dan berlatih konten pertarungan terkait di level yang sesuai.
2. Saat Penjaga Rahasia menyelesaikan level tutorial praktis yang sesuai, hadiah dapat diklaim di "Tutorial Praktis".]]
  },
  Activity_90861_ActivityName = {
    Text = "Takdir Konjugasi"
  },
  Activity_90861_ActivityTips = {
    Text = "<Title: Jalan Takdir Konjugat>\n·Perjalanan terbatas waktu ini mencakup 8 paket hadiah, di mana paket pertama dapat diklaim secara gratis, paket ke-2 hingga ke-8 harus membeli \"Jalan Takdir Konjugat\" terlebih dahulu sebelum dapat diklaim.\n·Setelah membeli \"Jalan Takdir Konjugat\", hadiah paket ke-2 dapat langsung diklaim; paket selanjutnya perlu menunggu waktu tertentu sebelum dapat diklaim.\n·Membeli \"Jalan Takdir Konjugat\" sebelum 20 April 9:00 akan mendapatkan hadiah tambahan: Avatar eksklusif \"Penenun Takdir\", \"Undangan Sang Tak Terlihat\" ×10! Pembelian setelah 20 April 9:00 tidak akan lagi mendapatkan hadiah eksklusif terbatas waktu.\n· Setelah pembelian, durasi perjalanan terbatas waktu ini akan menjadi permanen, dan aktivitas akan ditutup keesokan harinya setelah semua paket hadiah diklaim.\n·\"Jalan Takdir Konjugat\" memiliki batas waktu pembelian, setelah lewat tidak dapat dibeli lagi. Mohon Penjaga Rahasia membeli sebelum 18 Mei 9:00 sesuai pertimbangan."
  },
  Activity_90861_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_90862_ActivityName = {
    Text = "Teks sementara"
  },
  Activity_90862_ActivityTips = {
    Text = "<Title: Teks Sementara>\n·Aktivitas pra-pembelian terbatas waktu ini mencakup 8 paket hadiah, di mana paket pertama dapat diklaim secara gratis, paket ke-2 hingga ke-8 harus membeli \"Teks Sementara\" terlebih dahulu sebelum dapat diklaim.\n·Setelah membeli \"Teks Sementara\", hadiah paket ke-2 dapat langsung diklaim; paket selanjutnya perlu menunggu waktu tertentu sebelum dapat diklaim.\n·\"Teks Sementara\" memiliki batas waktu pembelian, setelah lewat tidak dapat dibeli lagi. Mohon Penjaga Rahasia membeli sebelum 7 April 9:00 sesuai pertimbangan."
  },
  Activity_90862_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_90863_ActivityName = {
    Text = "Kreasi Seribu Harapan"
  },
  Activity_90863_ActivityTips = {
    Text = "<Title: Kreasi Seribu Harapan>\n·Perjalanan Terbatas kali ini berisi 8 paket hadiah, di mana paket pertama dapat langsung diambil secara gratis, paket ke-2 hingga ke-8 memerlukan pembelian \"Kreasi Seribu Harapan\" sebelum dapat diambil.\n·Setelah membeli \"Kreasi Seribu Harapan\", hadiah paket ke-2 dapat langsung diambil; paket-paket berikutnya perlu menunggu waktu tertentu sebelum dapat diambil.\n·Membeli \"Kreasi Seribu Harapan\" sebelum 24 Agustus 9:00 juga akan mendapatkan hadiah tambahan: avatar eksklusif \"Tipu Daya Berlangsung\", \"Undangan dari Yang Tidak Berbentuk\" ×10! Pembelian setelah 24 Agustus 9:00 tidak akan lagi mendapatkan hadiah eksklusif terbatas waktu.\n·Pembelian \"Kreasi Seribu Harapan\" memiliki batas waktu, setelah lewat batas tidak dapat dibeli lagi. Harap Penjaga mempertimbangkan pembelian sebelum 21 September 9:00. Setelah pembelian, waktu berakhir Perjalanan Terbatas kali ini akan diperpanjang hingga 28 September 9:00, memberikan waktu yang lebih cukup bagi para Penjaga untuk mengambil hadiah!"
  },
  Activity_90863_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_90864_ActivityName = {
    Text = "Nyanyian Penggoda Tengkorak·Perjalanan Terbatas"
  },
  Activity_90864_ActivityTips = {
    Text = "<Title: Elegi Ruang Tengkorak·Perjalanan Terbatas Waktu>\n·Perjalanan terbatas waktu ini mencakup 8 paket hadiah, di mana paket pertama dapat diklaim secara gratis, paket ke-2 hingga ke-8 harus membeli \"Elegi Ruang Tengkorak·Perjalanan Terbatas Waktu\" terlebih dahulu sebelum dapat diklaim.\n·Setelah membeli \"Elegi Ruang Tengkorak·Perjalanan Terbatas Waktu\", hadiah paket ke-2 dapat langsung diklaim; paket selanjutnya perlu menunggu waktu tertentu sebelum dapat diklaim.\n·Membeli \"Elegi Ruang Tengkorak·Perjalanan Terbatas Waktu\" sebelum 21 Juli 9:00 akan mendapatkan hadiah tambahan: Avatar eksklusif \"Tatapan Lapar Malam Abadi\", \"Undangan Sang Tak Terlihat\" ×10! Pembelian setelah 21 Juli 9:00 tidak akan lagi mendapatkan hadiah eksklusif terbatas waktu.\n·\"Elegi Ruang Tengkorak·Perjalanan Terbatas Waktu\" memiliki batas waktu pembelian, setelah lewat tidak dapat dibeli lagi. Mohon Penjaga Rahasia membeli sebelum 18 Agustus 9:00 sesuai pertimbangan."
  },
  Activity_90865_ActivityName = {
    Text = "Gerakan Janin Lautan Dalam·Perjalanan Terbatas"
  },
  Activity_90865_ActivityTips = {
    Text = "<Title: Denyut Laut Dalam·Perjalanan Terbatas Waktu>\n·Perjalanan terbatas waktu ini mencakup 8 paket hadiah, di mana paket pertama dapat diklaim secara gratis, paket ke-2 hingga ke-8 harus membeli \"Denyut Laut Dalam·Perjalanan Terbatas Waktu\" terlebih dahulu sebelum dapat diklaim.\n·Setelah membeli \"Denyut Laut Dalam·Perjalanan Terbatas Waktu\", hadiah paket ke-2 dapat langsung diklaim; paket selanjutnya perlu menunggu waktu tertentu sebelum dapat diklaim.\n·Membeli \"Denyut Laut Dalam·Perjalanan Terbatas Waktu\" sebelum 17 November 9:00 akan mendapatkan hadiah tambahan: Avatar eksklusif \"Elegi Laut Dalam\", \"Undangan Sang Tak Terlihat\" ×10! Pembelian setelah 17 November 9:00 tidak akan lagi mendapatkan hadiah eksklusif terbatas waktu.\n·\"Denyut Laut Dalam·Perjalanan Terbatas Waktu\" memiliki batas waktu pembelian, setelah lewat tidak dapat dibeli lagi. Mohon Penjaga Rahasia membeli sebelum 15 Desember 9:00 sesuai pertimbangan."
  },
  Activity_91026_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_91027_ActivityName = {
    Text = "Penaklukan Agung"
  },
  Activity_91027_ActivityPlot = {
    Text = [[
Sebuah era agung mungkin pada akhirnya akan lenyap, tetapi kehendak para pejuang agung tidak akan pernah padam.
Batu nisan tak mampu mengubur mereka, belenggu tak mampu menjinakkan mereka.
Ketika perjalanan baru muncul, daging panggang lezat melambai di ujung jalan penaklukan, para pejuang menyerbu maju, meraih piala kemenangan yang mulia itu.
Mari kita nyanyikan pujian untuk keberanian yang tak pernah padam ini, untuk kekaisaran suci ini!
Roma! Roma!]]
  },
  Activity_91027_ActivityStageEndContent = {
    Text = "Event telah berakhir, saat ini hanya dapat mengikuti\"Persembahan Upeti\""
  },
  Activity_91027_ActivityTips = {
    Text = "<Title:Pengenalan Acara>\n1. Selama acara berlangsung, Penjaga Rahasia dapat mengumpulkan mata uang acara \"Daging Panggang Leo Lezat\" melalui mode waktu terbatas \"Perburuan Suci\". \"Daging Panggang Leo Lezat\" dapat digunakan di \"Persembahan Upeti\" untuk membeli barang, termasuk Inti Lumen, Inti Murni, dan lainnya.\n2. Selama acara berlangsung, \"Pandangan Mimpi Asing: Penaklukan Dapur\" dapat dibuka secara gratis untuk waktu terbatas.\n\n<Title:Waktu Acara>\n1. 30 Juni 9:00 - 21 Juli 9:00 (GMT+8), semua mode acara dapat diikuti.\n2. 21 Juli 9:00 - 28 Juli 9:00 (GMT+8), hanya dapat mengikuti \"Persembahan Upeti\" dan Hadiah Pencapaian.\n\n<Title:Perburuan Suci>\n1. \"Perburuan Suci\" terdiri dari 5 stage, 1 stage terbuka otomatis setiap 2 hari.\n2. Setiap tantangan akan mengonsumsi \"Psypeptide\" × 120, tantangan berhasil akan mendapatkan mata uang acara.\n3. Setelah stage diselesaikan, fitur \"Replay\" stage tersebut akan terbuka. Perhatian: Saat menggunakan fitur \"Replay\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Kamu dapat menggunakan bantuan Alumni untuk membantumu melewati stage dengan lebih mudah.\n\n<Title: Persembahan Upeti>\nDi toko \"Persembahan Upeti\", kamu dapat menggunakan mata uang acara \"Daging Panggang Leo Lezat\" untuk memilih dan langsung membeli barang.\n\n<Title:Pandangan Mimpi Asing>\n1. Selama acara berlangsung, \"Pandangan Mimpi Asing: Penaklukan Dapur\" dapat dibuka secara gratis.\n2. Setelah acara berakhir, progres investigasi \"Pandangan Mimpi Asing: Penaklukan Dapur\" akan disimpan. Setelah menyelesaikan event investigasi yang belum selesai selama acara, kamu juga dapat memperoleh hadiah investigasi yang sama seperti saat acara berlangsung. Jika \"Pandangan Mimpi Asing: Penaklukan Dapur\" tidak dibuka selama acara, setelah acara berakhir kamu tetap dapat mengonsumsi \"Titik Awal Realitas\" ×7 untuk membukanya.\n3. Baik selama maupun di luar periode acara, setelah menyelesaikan \"Pandangan Mimpi Asing: Penaklukan Dapur\", kamu dapat memperoleh \"Perintah Kunci: Tekad Berburu\"."
  },
  Activity_91027_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_91112_ActivityName = {
    Text = "Makhluk Mengerikan dalam Kabut"
  },
  Activity_91112_ActivityTips = {
    Text = "<Title:Aturan Acara>\n·Selama acara\"Makhluk Mengerikan dalam Kabut\"berlangsung, Keeper dapat menggunakan tim preset sistem yang menyertakan Mosha untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage acara, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Acara>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman acara."
  },
  Activity_91355_ActivityName = {
    Text = "Persembahan Kenangan Perjalanan·Bab Bintang III"
  },
  Activity_91355_ActivityPlot = {
    Text = "Sebuah memori tersegel dan diarsipkan, sebuah perjalanan tercatat dalam masa lalu. Saat mengenang, jangan lupa persembahkan penghormatan yang tulus."
  },
  Activity_91356_ActivityName = {
    Text = "Perjalanan ke Kota Mati"
  },
  Activity_91356_ActivityTips = {
    Text = [[
Aturan Aktivitas:
1. Setelah Penjaga Rahasia menyelesaikan misi Chronicle yang ditentukan, hadiah dapat diklaim di "Chronicle Kota Mati".
2. "Chronicle Kota Mati" dibuka secara permanen.
3. Setelah membuka "Chronicle Premium", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
4. Harap diperhatikan: "Chronicle Premium" yang dibuka dalam aktivitas ini hanya berlaku untuk aktivitas ini. Penjaga Rahasia diharapkan untuk berbelanja secara bijak.]]
  },
  Activity_91719_ActivityName = {
    Text = "Kupon Penukaran Kostum Periode 2"
  },
  Activity_91719_ActivityPlot = {
    Text = "Kupon Penukaran Kostum Periode 2"
  },
  Activity_91719_ActivityTips = {
    Text = [[
<Title:Pengenalan Acara>
1. Selama acara berlangsung, Penjaga Rahasia dapat memperoleh Kupon Desain Pakaian Ilusi Sederhana melalui acara lainnya]]
  },
  Activity_91728_ActivityName = {
    Text = "Rasul Lautan"
  },
  Activity_91728_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Rasul Lautan\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Miriam untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_94858_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_94859_ActivityName = {
    Text = "Perjalanan Musim Panas"
  },
  Activity_94859_ActivityTips = {
    Text = [[
Aturan Event:
1. Setelah Penjaga Rahasia menyelesaikan misi Chronicle yang ditentukan, hadiah dapat diklaim di "Chronicle Musim Panas".
2. Setelah membuka "Chronicle Lanjutan", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
3. Pembelian "Chronicle Lanjutan" kali ini memiliki batas waktu, setelah lewat batas waktu tidak dapat dibeli lagi. Penjaga Rahasia diharapkan membeli sebelum 6 Oktober pukul 9:00.
4. Perhatian: "Chronicle Lanjutan" yang dibuka dalam event ini hanya berlaku di event ini. Penjaga Rahasia diharapkan membelanjakan secara bijak.]]
  },
  Activity_94859_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_94860_ActivityName = {
    Text = "Musim panas abadi di bawah sinar matahari hitam"
  },
  Activity_94860_ActivityPlot = {
    Text = [[
Musim panas, pantai, sinar matahari, dan banyak wajah yang akrab.
Di bawah sinar Matahari Hitam, lupakan segalanya, tenggelam dalam mimpi indah yang memenuhi semua fantasi ini.]]
  },
  Activity_94860_ActivityTips = {
    Text = "<Title:Deskripsi Acara>\n1. Selama periode acara, \"Lanskap mimpi: Selamat tinggal, Neverland\" dapat dibuka gratis untuk waktu terbatas!\n2. Selama periode acara, total login 7 hari dapat memperoleh \"Inti Lumen\"×10 di \"Perayaan Tshessa\", dan pada hari ke-7 dapat memperoleh avatar pertempuran terbatas \"Bola Voli \"Jenderal\"\" sebagai tambahan.\n\n<Title:Waktu Acara>\n1. 1 September 9:00 - 6 Oktober 9:00 (GMT+8), semua acara dapat diikuti.\n\n<Title:Lanskap mimpi>\n1. Selama periode acara, \"Lanskap mimpi: Selamat tinggal, Neverland\" dapat dibuka gratis.\n2. Setelah acara berakhir, kemajuan investigasi untuk \"Lanskap mimpi: Selamat tinggal, Neverland\" akan tetap ada, dan menyelesaikan kejadian investigasi yang belum selesai selama periode acara juga akan mendapatkan hadiah investigasi yang sama seperti selama periode acara. Jika tidak membuka \"Lanskap mimpi: Selamat tinggal, Neverland\" selama periode acara, setelah acara berakhir masih dapat menghabiskan \"Titik awal realitas\"×7 untuk membukanya.\n3. Baik selama maupun setelah periode acara, setelah menyelesaikan \"Lanskap mimpi: Selamat tinggal, Neverland\", Anda dapat memperoleh \"Posse: Kenangan Musim Panas yang Terabadikan\"."
  },
  Activity_94860_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_95190_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_95191_ActivityName = {
    Text = "Ribu Cahaya Terang yang Jatuh"
  },
  Activity_95191_ActivityPlot = {
    Text = [[
Mereka menyanyikan lagu yang tak pernah terlupakan, menyambut sang Tuan yang tak pernah padam.
Dia akan turun dari langit tertinggi membawa ribuan cahaya gemilang, menceritakan kemuliaan yang abadi.
Saat Dia tiba, cahaya amber menyelimuti dunia.
Ini adalah pemakaman yang Dia persembahkan untuk dunia.]]
  },
  Activity_95191_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat mengikuti \"Markas Tersembunyi\""
  },
  Activity_95191_ActivityTips = {
    Text = "<Title:Pengenalan Acara>\n1. Selama acara berlangsung, Penjaga Rahasia dapat mengumpulkan mata uang acara \"Segel Kekayaan\", \"Segel Kematian\", dan \"Segel Perang\" melalui mode waktu terbatas \"Perburuan Kebinasaan\", \"Perjamuan Tanpa Kekacauan\", dan \"Hadiah Pencapaian\". \"Segel Kekayaan\", \"Segel Kematian\", dan \"Segel Perang\" dapat digunakan untuk membeli barang di \"Markas Tersembunyi\", termasuk Roda Takdir SR edisi terbatas acara \"Matahari yang Mendekat\", Inti Lumen, Inti Murni, dan lainnya.\n2. Selama acara berlangsung, \"Siang Abadi\" dapat dibuka secara gratis untuk waktu terbatas. Selesaikan pencapaian acara untuk mendapatkan avatar edisi terbatas acara \"Atas Nama Kunci Perak: Katigula\"!\n\n<Title:Waktu Acara>\n1. 18 Agustus 9:00 - 1 September 9:00 (GMT+8), semua mode acara dapat diikuti.\n2. 1 September 9:00 - 8 September 9:00 (GMT+8), hanya dapat mengikuti \"Markas Tersembunyi\" dan Hadiah Pencapaian.\n\n<Title:Perburuan Kebinasaan>\n1. \"Perburuan Kebinasaan\" terdiri dari 7 stage, 1 stage terbuka otomatis setiap 1 hari.\n2. Setiap tantangan akan mengonsumsi \"Psypeptide\" × 120, tantangan berhasil akan mendapatkan mata uang acara.\n3. Setelah stage diselesaikan, fitur \"Replay\" stage tersebut akan terbuka. Perhatian: Saat menggunakan fitur \"Replay\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Kamu dapat menggunakan bantuan Alumni untuk membantumu melewati stage dengan lebih mudah.\n\n<Title: Markas Tersembunyi>\n\"Markas Tersembunyi\" memiliki tiga toko, waktu pembukaan sebagai berikut:\n·\"Gudang Koleksi\": Dibuka pada 18 Agustus pukul 9:00.\n·\"Ruang Rahasia Komisi\": Dibuka pada 20 Agustus pukul 9:00.\n·\"Tenda Pertempuran\": Dibuka pada 22 Agustus pukul 9:00.\nDi dalam toko, kamu dapat memilih barang untuk langsung dibeli.\n\n<Title:Bonus Acara>\n1. Penjaga Rahasia yang memiliki Awakened atau Roda Takdir tertentu (tidak harus diturunkan) dapat memperoleh bonus drop tambahan untuk \"Segel Kekayaan\", \"Segel Kematian\", dan \"Segel Perang\" dari hadiah misi stage \"Perburuan Kebinasaan\". Detail bonus sebagai berikut:\n·Awakened \"Katigula\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda Takdir SSR \"Kematian Amber\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n·Roda Takdir SR \"Matahari yang Mendekat\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%.\n2. \"Bonus Acara\" dari Awakened atau Roda Takdir yang berbeda dihitung secara kumulatif. \n3. Khususnya, hadiah penyelesaian pertama tingkat kesulitan Gila tidak akan terpengaruh oleh \"Bonus Acara\".\n\n<Title: Perjamuan Tanpa Kekacauan>\n1. Secara otomatis mendapatkan 60 \"Segel Kekayaan\" setiap jam, maksimal penyimpanan 25 jam.\n\n<Title:Penyelaman Kesadaran>\n1. Selama acara berlangsung, \"Siang Abadi\" dapat dibuka secara gratis.\n2. Setelah acara berakhir, progres investigasi \"Siang Abadi\" akan disimpan. Setelah menyelesaikan event investigasi yang belum selesai selama acara, kamu juga dapat memperoleh hadiah investigasi yang sama seperti saat acara berlangsung. Jika \"Siang Abadi\" tidak dibuka selama acara, setelah acara berakhir kamu tetap dapat mengonsumsi \"Titik Awal Realitas\" ×3 untuk membukanya.\n3. Baik selama maupun di luar periode acara, setelah menyelesaikan \"Penyelaman Kesadaran: Siang Abadi\", kamu dapat memperoleh \"Perintah Kunci: Matahari yang Tak Terbenam\"."
  },
  Activity_95191_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_95492_ActivityName = {
    Text = "Anugerah Sang Raja"
  },
  Activity_95492_ActivityPlot = {
    Text = "Dia adalah raja yang dermawan, baik hati, dan penuh belas kasihan, yang memimpin sebuah kerajaan kematian. Selamat datang, orang asing yang belum mati, aroma harum dan semerbakmu telah menarik perhatiannya. Terimalah anugerah ini, pintu kastil ini akan selalu terbuka untukmu."
  },
  Activity_95492_ActivityTips = {
    Text = [[
<Title:Pengantar>
1. Selama periode aktivitas, Penjaga Rahasia dapat mengklaim hadiah check-in harian di"Anugerah Sang Raja"setelah login setiap hari.
2. Hadiah akan dibuka secara berurutan berdasarkan total hari login Penjaga Rahasia. Hadiah check-in harian akan di-refresh pada pukul 9:00 (GMT+8).
]]
  },
  Activity_95492_BannerText = {
    Text = "Check-in untuk Klaim Pristine Core Berlimpah"
  },
  Activity_95977_ActivityName = {
    Text = "Estetika Nekrotik"
  },
  Activity_95977_ActivityPlot = {
    Text = [[
Kematian, jauh dari akhir kehidupan.
Jangan takut akan kematian, tamu yang terhormat.
Di pesta ritual yang meriah, kamu akan bersama sang tuan yang lembut, menyaksikan estetika para arwah.]]
  },
  Activity_95977_ActivityStageEndContent = {
    Text = "Acara telah berakhir, saat ini hanya dapat mengikuti \"Restoran Mansion\""
  },
  Activity_95977_ActivityTips = {
    Text = "<Title:Pengenalan Acara>\nSelama acara berlangsung, Penjaga Rahasia dapat mengumpulkan mata uang acara melalui mode waktu terbatas \"Perjamuan Pemakan Roh\" dan \"Hadiah Pencapaian\". Mata uang acara dapat digunakan di \"Restoran Mansion\" untuk ditukarkan guna mendapatkan hadiah item, termasuk Roda Takdir SR edisi terbatas acara \"Hidangan Mewah\", Batu Bijak, Inti Murni, Inti Lumen, dan lainnya.\n\n<Title:Waktu Acara>\n1. 21 Juli 9:00 - 4 Agustus 9:00 (GMT+8), semua konten acara dapat diikuti.\n2. 4 Agustus 9:00 - 11 Agustus 9:00 (GMT+8), hanya \"Restoran Mansion\" dan \"Hadiah Pencapaian\" yang dipertahankan, konten lainnya telah berakhir dan tidak dapat diikuti.\n\n<Title: Perjamuan Pemakan Roh>\n1. \"Perjamuan Pemakan Roh\" terdiri dari 5 stage, 1 stage terbuka otomatis setiap 2 hari.\n2. Setiap tantangan akan mengonsumsi \"Psypeptide\" × 120, tantangan berhasil akan mendapatkan mata uang acara.\n3. Setelah stage diselesaikan, fitur \"Replay\" stage tersebut akan terbuka. Perhatian: Saat menggunakan fitur \"Replay\", Tingkat Sinkronisasi tidak dapat diperoleh.\n4. Kamu dapat menggunakan bantuan Alumni untuk membantumu menyelesaikan stage dengan lebih mudah.\n\n<Title: Bonus Acara>\n1. Penjaga Rahasia yang memiliki Awakened atau Roda Takdir tertentu (tidak harus diturunkan) dapat memperoleh bonus drop tambahan untuk \"Tulang Tangan Busuk\" dari hadiah misi stage \"Perjamuan Pemakan Roh\" (termasuk Replay). Detail bonus sebagai berikut:\n·Awakened \"Dulcesein\": Kebangkitan 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SSR \"Ciuman Peristirahatan\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n·Roda Takdir SR \"Hidangan Mewah\": Superimpose 0/1/2/3 ke atas, bonus 20%/30%/40%/50%\n2. \"Bonus Acara\" dari Awakened atau Roda Takdir yang berbeda dihitung secara kumulatif. \n3. Khususnya, hadiah penyelesaian pertama tingkat kesulitan Gila tidak akan terpengaruh oleh \"Bonus Acara\".\n\n<Title:  Restoran Mansion>\n1. Setiap \"Kirim Laporan\" akan mengonsumsi 750 \"Tulang Tangan Busuk\", dan secara acak mendapatkan lima hadiah item dari \"Restoran Mansion\".\n2. Hadiah item \"Restoran Mansion\" terbagi menjadi \"Item Spesial\" dan \"Item Biasa\". Saat reset, jumlah sisa hadiah item spesial dapat direset ke batas maksimal. Aturan spesifiknya sebagai berikut:\n(1) 5 kali reset pertama: Setelah \"Item Spesial\" tidak memiliki jumlah tersisa, Penjaga Rahasia dapat memilih untuk reset. Setelah reset, jumlah sisa \"Item Spesial\" dan \"Item Biasa\" akan direset ke batas maksimal; atau dapat memilih untuk terus menukar. Setelah \"Item Biasa\" juga tidak memiliki jumlah tersisa, reset harus dilakukan untuk melanjutkan penukaran.\n(2) Reset ke-6 dan seterusnya: Reset hanya dapat dilakukan setelah \"Item Biasa\" tidak memiliki jumlah tersisa. Reset akan mereset jumlah sisa \"Item Biasa\" ke batas maksimal, \"Item Spesial\" tidak lagi direset.\n3. Setelah 11 Agustus 9:00 (GMT+8), sisa \"Tulang Tangan Busuk\" yang belum ditukarkan akan dikumpulkan kembali dengan rasio setiap unit ditukar menjadi \"Kupon Emas Mawar\" × 40. Penjaga Rahasia harap periksa email."
  },
  Activity_95977_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_95978_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti I"
  },
  Activity_95978_ActivityPlot = {
    Text = "Setelah membeli, \"Dulcesein\" dapat mengaktifkan <BlueQuality:Kebangkitan Roh 3>"
  },
  Activity_95979_ActivityName = {
    Text = "Penguasa Tulang Belulang"
  },
  Activity_95979_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Penguasa Tulang Belulang\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Dulcesein untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_95980_ActivityName = {
    Text = "Kotak Hadiah Kristalisasi Inti Roh II"
  },
  Activity_95980_ActivityPlot = {
    Text = [[
Setelah membeli, "Dulcein" dapat mengaktifkan
<BlueQuality:Pendalaman Persona +4, membuka Ledakan Batas>]]
  },
  Activity_96174_ActivityName = {
    Text = "Detektif Beruntung"
  },
  Activity_96174_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Detektif Beruntung\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Lake untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_96617_ActivityName = {
    Text = "Merah Maple Berulang"
  },
  Activity_96617_ActivityTips = {
    Text = [[
<Title:Aturan Aktivitas>
1, Setelah Penjaga Rahasia menyelesaikan misi perjalanan yang ditentukan, hadiah dapat diklaim di "Merah Maple Berulang".
2,"Merah Maple Berulang" akan berakhir pada 23 Maret 9:00(GMT+8).
3, Setelah membuka "Perjalanan Premium", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
4, Perhatian:"Perjalanan Premium" yang dibuka dalam aktivitas ini hanya berlaku di aktivitas ini. Mohon Penjaga Rahasia berbelanja secara bijak.]]
  },
  Activity_96617_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_96838_ActivityName = {
    Text = "Teks sementara"
  },
  Activity_96838_ActivityPlot = {
    Text = [[
Sebuah ledakan warna, sebuah kekacauan bentuk.
Lukisan yang hampir normal, dicorat-coret dengan sentuhan darah
di bawah pisau palet, roh-roh mati bergeletar dan berbisik di sisi gelap kanvas.
Seni yang paling nyata dan sempurna tersembunyi di balik kegilaan dan absurditas,
hanya melalui kegilaan yang merobek tampilan luar kita dapat melihat bagian dalam dunia.]]
  },
  Activity_96838_ActivityStageEndContent = {
    Text = "Kegiatan telah berakhir, saat ini hanya dapat berpartisipasi dalam\"Studio Lukisan Pikman\""
  },
  Activity_96838_ActivityTips = {
    Text = "<Title:Deskripsi Kegiatan>\n1. Selama periode kegiatan, Penjaga dapat mengumpulkan mata uang kegiatan \"Pewarnaan Nyata\", \"Pewarnaan Mimpi\", dan \"Dampak Kegilaan\" melalui gameplay terbatas \"Teks Sementara\" dan \"Hadiah Prestasi\". \"Pewarnaan Nyata\", \"Pewarnaan Mimpi\", dan \"Dampak Kegilaan\" dapat digunakan untuk membeli barang di \"Studio Pikman\", termasuk Roda takdir SR eksklusif kegiatan \"Kuas yang Mendambakan\", Inti Lumen, Inti Murni, dan lainnya. \n2. Selama periode kegiatan, \"Yang berkelana: Gambaran Dunia Cacat\" dapat dibuka secara gratis untuk waktu terbatas, menyelesaikan pencapaian kegiatan juga akan memberikan avatar eksklusif kegiatan \"Atas nama Kunci Perak: Pikman\"!\n\n<Title:Waktu Kegiatan>\n1. 9 September 9:00 - 22 September 9:00 (GMT+8), semua gameplay kegiatan dapat diikuti. \n2. 22 September 9:00 - 29 September 9:00 (GMT+8), hanya dapat mengikuti \"Studio Pikman\" dan Hadiah Prestasi. \n\n<Title:Teks Sementara>\n1. \"Teks Sementara\" terdiri dari 7 tingkat, satu tingkat akan dibuka secara otomatis setiap hari. \n2. Setiap tantangan akan menghabiskan \"Menophin\" × 120, berhasil menyelesaikan tantangan akan mendapatkan mata uang kegiatan. \n3. Setelah menyelesaikan tingkat, fitur \"Reproduksi\" untuk tingkat tersebut akan dibuka. Harap dicatat: saat menggunakan fitur \"Reproduksi\", tidak akan mendapatkan Affiniti. \n4. Dapat menggunakan bantuan alumni untuk membantu Anda menyelesaikan tingkat dengan lebih mudah. \n\n<Title:Studio Pikman>\n1. \"Studio Pikman\" memiliki tiga toko, waktu pembukaannya adalah sebagai berikut: \n· \"Ruang Lukis Nyata\": Dibuka pada 9 September pukul 9. \n· \"Ruang Lukis Mimpi\": Dibuka pada 10 September pukul 9. \n· \"Studio Kegilaan\": Dibuka pada 12 September pukul 9. \n2. Setiap pertukaran akan menghabiskan 750 \"Pewarnaan Nyata\"/\"Pewarnaan Mimpi\"/\"Dampak Kegilaan\", secara acak mendapatkan lima hadiah barang di studio. \n3. Hadiah barang di setiap studio dibagi menjadi dua jenis: \"Item Spesial\" dan \"Item Umum\", saat reset dapat mengatur ulang jumlah sisa hadiah item spesial ke batas maksimum, aturan spesifik adalah: \n(1)Reset 2 kali pertama: Ketika \"Item Spesial\" tidak memiliki jumlah sisa, Penjaga dapat memilih untuk mereset, setelah reset \"Item Spesial\" dan \"Item Umum\" akan direset ke batas maksimum; dapat juga memilih untuk terus bertukar, ketika \"Item Umum\" juga tidak memiliki jumlah sisa, harus melakukan reset untuk melanjutkan pertukaran. \n(2)Mulai reset ke-3: Hanya dapat melakukan reset setelah \"Item Umum\" tidak memiliki jumlah sisa, reset akan mengatur ulang jumlah sisa \"Item Umum\" ke batas maksimum, \"Item Spesial\" tidak akan direset lagi. \n\n<Title:Bonus Kegiatan>\n1. Penjaga yang memiliki Awakener atau Roda takdir tertentu (tidak perlu diturunkan) dapat membuat \"Teks Sementara\" mendapatkan bonus tambahan dari mata uang \"Pewarnaan Nyata\", \"Pewarnaan Mimpi\", \"Dampak Kegilaan\" dalam imbalan tugas, bonus spesifik adalah sebagai berikut: \n· Awakener \"Pikman\": Mencerahkan 0/1/2/3 dan di atas, bonus 20%/30%/40%/50%. \n· Roda takdir SSR \"Paradoks Realisme\": Posisi Tumpuk 0/1/2/3 dan di atas, bonus 20%/30%/40%/50%. \n· Roda takdir SR \"Kuas yang Mendambakan\": Posisi Tumpuk 0/1/2/3 dan di atas, bonus 20%/30%/40%/50%. \n2. \"Bonus Kegiatan\" dari Awakener atau Roda takdir yang berbeda akan dihitung secara akumulatif. \n3. Khususnya, hadiah tantangan pertama untuk tingkat kesulitan kegilaan tidak akan terpengaruh oleh \"Bonus Kegiatan\". \n\n<Title:Yang Berkelana>\n1. Selama periode kegiatan, \"Yang berkelana: Gambaran Dunia Cacat\" dapat dibuka secara gratis. \n2. Setelah kegiatan berakhir, kemajuan investigasi \"Yang berkelana: Gambaran Dunia Cacat\" akan disimpan, menyelesaikan kejadian investigasi yang belum selesai selama periode kegiatan juga dapat memperoleh hadiah investigasi yang sama dengan periode kegiatan. Jika \"Yang berkelana: Gambaran Dunia Cacat\" tidak dibuka selama periode kegiatan, setelah kegiatan berakhir masih dapat menghabiskan \"Titik awal realitas\" ×3 untuk membuka kunci. \n3. Baik selama periode kegiatan atau tidak, setelah menyelesaikan \"Yang berkelana: Gambaran Dunia Cacat\" dapat memperoleh \"Posse: Warna Dunia Ilusi\"."
  },
  Activity_96838_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_96839_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_97190_ActivityName = {
    Text = "Perjalanan Penguburan Mayat"
  },
  Activity_97190_ActivityTips = {
    Text = [[
Aturan Event:
1. Setelah Penjaga Rahasia menyelesaikan misi Chronicle yang ditentukan, hadiah dapat diklaim di "Chronicle Pemakaman Tulang".
2. Setelah membuka "Chronicle Lanjutan", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
3. Pembelian "Chronicle Lanjutan" kali ini memiliki batas waktu, setelah lewat batas waktu tidak dapat dibeli lagi. Penjaga Rahasia diharapkan membeli sebelum 18 Agustus pukul 9:00.
4. Perhatian: "Chronicle Lanjutan" yang dibuka dalam event ini hanya berlaku di event ini. Penjaga Rahasia diharapkan membelanjakan secara bijak.]]
  },
  Activity_97190_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_97297_ActivityName = {Text = "Ratu Duri"},
  Activity_97297_ActivityTips = {
    Text = "<Title:Aturan Event>\n·Selama event\"Ratu Duri\"berlangsung, Keeper dapat menggunakan tim preset sistem yang mencakup Wanda untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage event, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Event>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman event."
  },
  Activity_97672_ActivityName = {
    Text = "Upacara Kelahiran Dewa"
  },
  Activity_97672_ActivityPlot = {
    Text = [[
Tidak perlu lagi menangisi masa lalu dari pengorbanan yang megah ini.
Hadirkan darah dan tulang, hadirkan jiwa dan daging, hadirkan kebebasan, hadirkan kehidupan.
Dia ditakdirkan untuk memiliki kehormatan yang tinggi, dia ditakdirkan untuk merasakan kepedihan yang tanpa tempat. Dia adalah anak Dewa, dia adalah ibu Dewa.
Dia telah dengan senang hati menerima takdirnya yang menakutkan dan menjijikkan.]]
  },
  Activity_97672_ActivityStageEndContent = {
    Text = "Kegiatan telah berakhir, saat ini hanya bisa berpartisipasi dalam \"Kelahiran Tujuh Hari\""
  },
  Activity_97672_ActivityTips = {
    Text = "<Title:Ringkasan Aktivitas>\n1, Selama periode aktivitas, Penjaga dapat mengumpulkan mata uang aktivitas \"Aroma Penenang\".\"Aroma Pengusir Mimpi Buruk\".\"Aroma Penangkap Mimpi\" melalui gameplay terbatas \"Hari Ketujuh Penciptaan\" dan \"Hadiah Prestasi\". \"Aroma Penenang\".\"Aroma Pengusir Mimpi Buruk\".\"Aroma Penangkap Mimpi\" dapat digunakan untuk membeli barang di \"Kamar Tidur Ibu Dewa\", termasuk Roda takdir terbatas SR \"Racun Cincin Biru\".Inti Lumen, Inti murni, dan lainnya. \n2, Menyelesaikan prestasi aktivitas selama periode aktivitas juga akan mendapatkan avatar terbatas aktivitas \"Atas nama Kunci Perak: Delirium·Murphy\"!\n\n<Title:Waktu Aktivitas>\n1, 24 November pukul 9:00 - 15 Desember pukul 9:00 (GMT+8), semua gameplay aktivitas dapat diikuti. \n2, 15 Desember pukul 9:00 - 22 Desember pukul 9:00 (GMT+8), hanya dapat berpartisipasi di \"Kamar Tidur Ibu Dewa\" dan hadiah prestasi. \n\n<Title:Hari Ketujuh Penciptaan>\n1, \"Hari Ketujuh Penciptaan\" terdiri dari 7 tingkat, satu tingkat akan dibuka secara otomatis setiap hari. \n2, Setiap tantangan akan mengonsumsi \"Menophin\"× 120, dan keberhasilan tantangan akan mendapatkan mata uang aktivitas. \n3, Setelah menyelesaikan tingkat, fungsi \"Reproduksi\" untuk tingkat tersebut akan dibuka. Harap dicatat: saat menggunakan fungsi \"Reproduksi\", tidak akan mendapatkan Affiniti. \n4, Anda dapat menggunakan bantuan alumni untuk membantu Anda menyelesaikan tingkat dengan lebih mudah. \n\n<Title:Pesta Penghujatan>\n· Setelah aktivitas dimulai, secara otomatis mendapatkan 60 \"Aroma Penenang\" setiap jam, maksimum dapat disimpan selama 25 jam. \n\n<Title:Kamar Tidur Ibu Dewa>\n1, \"Kamar Tidur Ibu Dewa\" memiliki tiga toko, dengan waktu pembukaan sebagai berikut: \n·\"Mimpi Manis yang Berbeda\": Dibuka pada 24 November pukul 9:00. \n·\"Kelahiran Dewa Mimpi Dalam\": Dibuka pada 25 November pukul 9:00. \n·\"Kabus Malam Tanpa Harapan\": Dibuka pada 26 November pukul 9:00. \n2, Setiap persembahan akan mengonsumsi 750 \"Aroma Penenang\"/\"Aroma Pengusir Mimpi Buruk\"/\"Aroma Penangkap Mimpi\", secara acak mendapatkan lima hadiah barang di dalam kamar. \n3, Hadiah barang di setiap kamar dibagi menjadi dua jenis: \"Item Spesial\" dan \"Item Umum\", saat reset dapat mengatur ulang jumlah sisa hadiah item spesial ke batas maksimum, aturan detailnya adalah: \n(1)Reset 2 kali pertama: Ketika \"Item Spesial\" tidak memiliki jumlah sisa, Penjaga dapat memilih untuk mereset, setelah reset akan mengatur ulang jumlah sisa \"Item Spesial\" dan \"Item Umum\" ke batas maksimum; juga dapat memilih untuk terus mempersembahkan, ketika \"Item Umum\" juga tidak memiliki jumlah sisa, harus melakukan reset untuk melanjutkan persembahan. \n(2)Mulai reset ketiga: Hanya dapat melakukan reset setelah \"Item Umum\" tidak memiliki jumlah sisa, reset akan mengatur ulang jumlah sisa \"Item Umum\" ke batas maksimum, \"Item Spesial\" tidak akan direset lagi. \n\n<Title:Bonus Aktivitas>\n1, Penjaga yang memiliki Awakener atau Roda takdir tertentu (tidak perlu diatur) dapat memberikan bonus tambahan pada hadiah \"Aroma Penenang\".\"Aroma Pengusir Mimpi Buruk\".\"Aroma Penangkap Mimpi\" dalam misi tingkat \"Hari Ketujuh Penciptaan\", bonus spesifik adalah sebagai berikut: \n· Awakener \"Delirium·Murphy\": Mencerahkan 0/1/2/3 dan seterusnya, bonus 20%/30%/40%/50%. \n· Roda takdir SSR \"Istirahat dalam Kegelapan\": Posisi Tumpuk 0/1/2/3 dan seterusnya, bonus 20%/30%/40%/50%. \n· Roda takdir SR \"Racun Cincin Biru\": Posisi Tumpuk 0/1/2/3 dan seterusnya, bonus 20%/30%/40%/50%. \n2, Bonus \"aktivitas\" dari Awakener atau Roda takdir yang berbeda dihitung secara tumpang tindih. \n3, Secara khusus, hadiah tantangan pertama pada tingkat Kegilaan tidak akan terpengaruh oleh \"bonus aktivitas\"."
  },
  Activity_97672_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_97853_ActivityName = {
    Text = "Jika segalanya berjalan seperti biasa"
  },
  Activity_97853_ActivityPlot = {
    Text = [[
Kamu pernah membayangkan, jika bencana tidak pernah datang, seperti apa kehidupan semua orang.
Kekuatanmu untuk menyelamatkan dunia tidak lagi berguna, setiap hari harus sibuk dengan kehidupan kampus biasa dan mengumpulkan nilai yang menyedihkan. Di lapangan tidak ada lagi bayangan latihan perang, menggantikannya adalah tenda-tenda kegiatan klub dan suara riuh orang yang mengundang dan bercanda; ketika bel pulang berbunyi, murid-murid yang lapar segera memenuhi kantin...
Apa yang akan kamu lihat ketika membuka pintu orang-orang yang kamu pedulikan?]]
  },
  Activity_97853_ActivityStageEndContent = {
    Text = "[Jika semuanya berjalan normal] kegiatan telah berakhir, saat ini hanya bisa berpartisipasi dalam[Gedung Kantor OSIS]"
  },
  Activity_97853_ActivityTips = {
    Text = "<Title:Ikhtisar Acara>\n1. Selama periode acara, Penjaga dapat mengumpulkan mata uang acara \"Cangkang oleh-oleh pantai\" melalui gameplay terbatas \"Hal baru di bawah sinar matahari\", \"Cangkang oleh-oleh pantai\" dapat digunakan untuk membeli barang di \"Gedung Kantor Badan Eksekutif Mahasiswa\", termasuk Inti Lumen, Inti murni, Fragmentasi Batu Bijaksana, dan lain-lain.\n2. Selama periode acara, \"Lanskap mimpi: Selamat tinggal, Neverland\" dapat dibuka secara gratis untuk waktu terbatas!\n\n<Title:Waktu Acara>\n1. 6 Oktober 9:00 - 20 Oktober 9:00 (GMT+8), semua gameplay acara dapat diikuti.\n2. 20 Oktober 9:00 - 27 Oktober 9:00 (GMT+8), hanya \"Gedung Kantor Badan Eksekutif Mahasiswa\" dan hadiah prestasi yang dapat diikuti.\n\n<Title:Hal baru di bawah sinar matahari>\n1. \"Hal baru di bawah sinar matahari\" terdiri dari 5 tingkat, satu tingkat akan dibuka secara otomatis setiap 2 hari.\n2. Setiap tantangan akan menghabiskan \"Menophin\" × 120, dan keberhasilan tantangan akan memberikan mata uang acara.\n3. Setelah menyelesaikan tingkat, fungsi \"Reproduksi\" untuk tingkat tersebut akan dibuka. Harap diperhatikan: saat menggunakan fungsi \"Reproduksi\", tidak dapat memperoleh Affiniti.\n4. Anda dapat menggunakan bantuan alumni untuk membantu Anda menyelesaikan tingkat dengan lebih mudah.\n\n<Title:Bonus Acara>\n1. Membuka \"Perjalanan Tingkat Lanjut\" di \"Jurnal Liburan\", Anda dapat memperoleh tambahan 100% \"Cangkang oleh-oleh pantai\" dari hadiah tingkat \"Hal baru di bawah sinar matahari\" (termasuk Reproduksi).\n2. Khususnya, hadiah tantangan pertama tingkat Kegilaan tidak akan dipengaruhi oleh \"Bonus Acara\".\n\n<Title:Gedung Kantor Badan Eksekutif Mahasiswa>\n\"Gedung Kantor Badan Eksekutif Mahasiswa\" memiliki satu toko, dibuka pada 6 Oktober pukul 9:00.\nDi dalam toko, Anda dapat memilih barang untuk dibeli secara langsung.\n\n<Title:Lanskap mimpi>\n1. Selama periode acara, \"Lanskap mimpi: Selamat tinggal, Neverland\" dapat dibuka secara gratis.\n2. Setelah acara berakhir, kemajuan investigasi \"Lanskap mimpi: Selamat tinggal, Neverland\" akan tetap, dan menyelesaikan kejadian investigasi yang belum selesai selama periode acara juga dapat memperoleh hadiah investigasi yang sama dengan periode acara. Jika \"Lanskap mimpi: Selamat tinggal, Neverland\" tidak dibuka selama periode acara, setelah acara berakhir, Anda masih dapat menghabiskan \"Titik awal realitas\" ×7 untuk membukanya.\n3. Baik selama periode acara atau tidak, setelah menyelesaikan \"Lanskap mimpi: Selamat tinggal, Neverland\", Anda dapat memperoleh \"Posse: Mimpi Indah Sejenak\"."
  },
  Activity_97853_BannerText = {
    Text = "Aktivitas permainan dibuka untuk waktu terbatas!"
  },
  Activity_97854_ActivityName = {
    Text = "Buka Kunci Stage Cabang Gratis"
  },
  Activity_97950_ActivityName = {
    Text = "Catatan Pemetaan"
  },
  Activity_97950_ActivityPromotionalText1 = {
    Text = "Meningkatkan 100% hadiah mata uang event di stage \"Hal Baru di Bawah Sinar Matahari\""
  },
  Activity_97950_ActivityTips = {
    Text = [[
Aturan Event:
1. Setelah Penjaga Rahasia menyelesaikan misi Chronicle yang ditentukan, hadiah dapat diklaim di "Chronicle Liburan".
2. Setelah membuka "Chronicle Lanjutan", hadiah tambahan dapat diklaim setelah menyelesaikan misi.
3. Setelah membuka "Chronicle Lanjutan", kamu bisa mendapatkan tambahan 100% drop "Kerang Khas Pantai" di hadiah stage "Hal Baru di Bawah Sinar Matahari" (termasuk pengulangan).
4. Khususnya, hadiah tantangan pertama kali tingkat kesulitan Gila tidak akan terpengaruh oleh "Bonus Event".
5. Pembelian "Chronicle Lanjutan" kali ini memiliki batas waktu, setelah lewat batas waktu tidak dapat dibeli lagi. Penjaga Rahasia diharapkan membeli sebelum 20 Oktober pukul 9:00.
6. Perhatian: "Chronicle Lanjutan" yang dibuka dalam event ini hanya berlaku di event ini. Penjaga Rahasia diharapkan membelanjakan secara bijak.]]
  },
  Activity_97950_BannerText = {
    Text = "Event Catatan Perjalanan Spesial Dibuka untuk Waktu Terbatas!"
  },
  Activity_97995_ActivityName = {
    Text = "Beri Permen atau Kena Jahil!"
  },
  Activity_97995_ActivityTips = {
    Text = "<Title:Pengantar>\nApi lilin yang misterius, pesta malam yang meriah, penyihir kecil pemburu permen, tampil megah dikelilingi hantu-hantu!\n \"Ini perampokan! Toffee, cokelat, permen susu, permen jeli buah... uhuk uhuk! Pokoknya semua permen — masukkan semuanya untukku!\"\n \"Kamu bilang permen kapas susah dimasukkan? Uuu... berikan padaku, akan kuhabiskan sekarang juga!\".\n\n<Title:Aturan Event>\n1, Selama event berlangsung, Penjaga Rahasia dapat menggunakan \"Permen Labu Rasa Aneh\" untuk menarik Ilusi Pakaian bintang 4 baru Murphy \"Perampokan Permen\".\n2, Penarikan pertama gratis! Setiap \"Permen Labu Rasa Aneh\" dapat dibeli dengan \"Source Fluid\" ×60. Penarikan ke-2 hingga ke-10 masing-masing membutuhkan \"Permen Labu Rasa Aneh\" ×1/2/2/3/5/5/5/5/5.\n3, Mulai penarikan ke-5 berpeluang mendapatkan Ilusi Pakaian bintang 4, maksimal 10 kali penarikan dijamin mendapatkan Ilusi Pakaian bintang 4 periode tersebut.\n4, Setelah event berakhir, sisa \"Permen Labu Rasa Aneh\" akan dikembalikan melalui surat dan dikembalikan dengan harga asli."
  },
  Activity_97995_BannerText = {
    Text = "Penarikan Ilusi Pakaian dibuka dalam waktu terbatas!"
  },
  Activity_98445_ActivityName = {
    Text = "Pemain Abadi"
  },
  Activity_98445_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Pemain Abadi\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Hamelin untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_98446_ActivityName = {
    Text = "Cahaya Dingin"
  },
  Activity_98446_ActivityTips = {
    Text = "<Title:Aturan Aktivitas>\n·Selama aktivitas\"Cahaya Dingin\"berlangsung, Penjaga Rahasia dapat menggunakan tim preset sistem yang mencakup Corpusant untuk memainkan stage yang ditentukan tanpa batas.\n·Saat memainkan stage aktivitas, Awakened dalam formasi tidak dapat diubah.\n<Title:Hadiah Aktivitas>\n·Setelah pertama kali menyelesaikan tantangan stage, hadiah uji coba dapat diklaim di halaman aktivitas."
  },
  Activity_99296_ActivityName = {
    Text = "Kita akhirnya akan bertemu kembali"
  },
  Activity_99296_ActivityPlot = {
    Text = "Login harian untuk mengklaim Roda Takdir SSR Peringatan Limited\"Kau dan Aku Pasti Bertemu Kembali\", total dapat diklaim 16 buah!"
  },
  Activity_99296_ActivityTips = {
    Text = "<Title:Deskripsi>\nIni adalah puisi yang dipersembahkan untuk para pemain, tentang cita-cita, tentang keyakinan, tentang waktu yang kita lalui bersama. Semoga hati yang tulus tak pernah berhenti berdetak, semoga Kunci Perak menuntun langkah ke depan.\n\n<Title:Aturan Event>\n·Selama periode event, setelah login setiap hari, Penjaga Rahasia dapat mengklaim Roda Takdir SSR Peringatan Limited\"Kau dan Aku Pasti Bertemu Kembali\"di\"Kau dan Aku Pasti Bertemu Kembali\", total dapat diklaim 16 kali.\n·Hadiah akan dibuka secara berurutan berdasarkan akumulasi login Penjaga Rahasia. Hadiah login harian akan direset pada pukul 9 (GMT+8)."
  },
  Activity_99296_BannerText = {
    Text = "Klaim Fate Wheel SSR Terbatas Gratis"
  }
})
return Text_Activity
