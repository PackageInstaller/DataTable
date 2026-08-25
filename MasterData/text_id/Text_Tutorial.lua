__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Tutorial = readonly({
  Tutorial_120371_Desc_1 = {
    Text = "Dapat kembali ke putaran yang telah dilalui dalam pertempuran, dapat kembali ke salah satu dari 25 putaran sebelum pertempuran."
  },
  Tutorial_120371_Title_1 = {
    Text = "Pembalikan Waktu"
  },
  Tutorial_124999_Desc_1 = {
    Text = "Di <TutorialHighlight:Traphase-Mode Pilihan Roda>, klik \"Mulai Pencocokan\" di pojok kanan bawah antarmuka untuk masuk ke pencocokan, tanpa perlu pra-grupp tim."
  },
  Tutorial_124999_Desc_2 = {
    Text = "Sebelum pertarungan, sistem akan secara acak memilih satu <TutorialHighlight:Relik>, yang akan berlaku selama pertarungan. Berdasarkan efek Relik di setiap ronde, secara bergiliran pilih Awakener, Roda takdir, dan Posse yang dibutuhkan dari kolam kartu yang terbatas dan bangun susunan tim untuk bertarung dengan lawan."
  },
  Tutorial_124999_Desc_3 = {
    Text = "Dengan mengklik dua Pembangun untuk bertukar posisi, kamu dapat menyesuaikan posisi timmu dalam pertempuran. Posisi diatur dari depan ke belakang dalam urutan 1-4."
  },
  Tutorial_124999_Title_1 = {
    Text = "Susunan tim Pilihan Roda"
  },
  Tutorial_126878_Desc_1 = {
    Text = "Sebagian Pembangun yang mencapai Pengembangan Kepribadian +12 secara otomatis mendapatkan efek \"Hukum Akhir\", efek yang didapat oleh setiap Pembangun berbeda-beda."
  },
  Tutorial_126878_Desc_2 = {
    Text = "Setelah mengaktifkan \"Hukum Terakhir\" dari Awakener, Anda akan menerima pesan komunikasi eksklusif untuk Awakener tersebut. Harap Penjaga ingat untuk memeriksa."
  },
  Tutorial_126878_Title_1 = {
    Text = "Hukum Akhir"
  },
  Tutorial_126878_Title_2 = {
    Text = "Informasi Eksklusif"
  },
  Tutorial_148475_Desc_1 = {
    Text = "Setelah Affiniti Awakener mencapai <TutorialHighlight:Lv20>, kamu dapat memperoleh <TutorialHighlight:<Italic:Scintilla>> eksklusif."
  },
  Tutorial_148475_Desc_2 = {
    Text = "<TutorialHighlight:<Italic:Scintilla>> adalah bukti Perkumpulan Suci antara kamu dan Awakener."
  },
  Tutorial_148475_Desc_3 = {
    Text = "Kini, Kartu perintah Awakener tersebut akan ditampilkan secara istimewa dalam pertempuran, dan dapat diperlihatkan kepada Penjaga lain dalam situasi sosial."
  },
  Tutorial_148475_Title_1 = {
    Text = "Perkumpulan Suci"
  },
  Tutorial_17805_Desc_1 = {
    Text = "Klik musuh untuk melihat semua negaranya. <TutorialHighlight:Peringatan> Negara memerlukan perhatian lebih, karena mewakili mekanisme khusus musuh. Penjaga sering gagal menyelesaikan penyelidikan dengan baik, sebagian besar alasannya adalah karena tidak memperhatikan mekanisme khusus musuh."
  },
  Tutorial_17805_Title_1 = {
    Text = "Negara Musuh"
  },
  Tutorial_17806_Desc_1 = {
    Text = "Setelah mengalahkan musuh, kamu dapat memilih <TutorialHighlight:Orison>, atau menghabiskan <TutorialHighlight:Segil hitam> di <TutorialHighlight:D-marka> untuk membelinya. <TutorialHighlight:Orison> dapat memberikan efek tambahan yang berbeda pada kartu yang ditentukan. Setiap kartu yang ditentukan hanya dapat di-orison-kan maksimal <TutorialHighlight:1> kali. Prioritaskan untuk memberikan orison pada kartu perintah yang lebih sering dimainkan, untuk meningkatkan keuntungan yang diperoleh dari orison."
  },
  Tutorial_17806_Title_1 = {Text = "Orison"},
  Tutorial_17807_Desc_1 = {
    Text = "Memberikan berbagai atribut kepada Pembangun, jika disusun menjadi <TutorialHighlight:Set>, akan ada efek khusus. Terdapat 6 bagian, <TutorialHighlight:Atribut Utama> berbeda di setiap bagian, Tingkat Crit. dan Crit. DMG akan muncul di bagian I, II, III; Tingkat Recharge Aliemus dan Tingkat Muatan Kunci Perak akan muncul di bagian I, IV, V; Realm Mastery dan Sigil Yield akan muncul di bagian II, IV, VI; DMG Amplification dan Ketahanan akan muncul di bagian III, V, VI. Anda dapat merasakan kekuatan Perjanjian dan Set Perjanjian secara intuitif melalui tingkat penyelesaian Perjanjian. Tingkat penyelesaian Perjanjian dapat ditingkatkan melalui peningkatan level dan transkripsi."
  },
  Tutorial_17807_Title_1 = {Text = "Covenant"},
  Tutorial_17808_Desc_1 = {
    Text = "Dalam mode <TutorialHighlight:Terjunan Gaib>, setiap tantangan level akan memasuki peta secara acak. Setelah berhasil menyelesaikan tantangan, poin akan diperoleh berdasarkan tingkat kesulitan level, penguatan Pembangun, dan item penilaian dalam level. Setiap minggu tantangan akan memiliki kreasi awal dan penguatan Pembangun yang berbeda."
  },
  Tutorial_17808_Desc_2 = {
    Text = "Terjunan Gaib biasanya memperbarui musim setiap 28 hari. Dengan menyelesaikan Terjunan Gaib sekali dalam musim, Anda dapat berpartisipasi dalam <TutorialHighlight:Peringkat Musim>. Pada akhir musim, peringkat akan dihitung dan hadiah peringkat akan dikirim melalui kotak surat."
  },
  Tutorial_17808_Desc_3 = {
    Text = "\"Catatan Terjunan\" memiliki beberapa target yang ditetapkan, setelah tercapai dapat memperoleh hadiah yang sesuai. Setiap kali menyelesaikan target \"Catatan Terjunan\" atau memenangkan tantangan terjunan, dapat memperoleh <TutorialHighlight:Pengalaman Terjunan>. Ketika pengalaman terjunan mencapai nilai tertentu, <TutorialHighlight:Level Terjunan> akan meningkat dan dapat memperoleh hadiah yang melimpah. Dapat dilihat melalui \"Catatan Terjunan\" dan \"Level Terjunan\" di pojok kiri bawah antarmuka."
  },
  Tutorial_17808_Title_1 = {
    Text = "Terjunan gaib"
  },
  Tutorial_17809_Desc_1 = {
    Text = "Melalui acara dan D-marka, kamu bisa mendapatkan <TutorialHighlight:Relik>. <TutorialHighlight:Relik> dapat memperkuat kemampuan tempur tim kita. Penjaga yang baik biasanya dapat memilih Relik yang lebih sesuai berdasarkan kebutuhan tim."
  },
  Tutorial_17809_Title_1 = {Text = "Relic"},
  Tutorial_17810_Desc_1 = {
    Text = "Mengusir kabut, jangkauan pandang peta meningkat sebesar <TutorialHighlight:2> petak. Kamu bisa memanfaatkannya untuk merencanakan rute yang lebih baik."
  },
  Tutorial_17810_Title_1 = {
    Text = "proyektor pencari"
  },
  Tutorial_17811_Desc_1 = {
    Text = "Target yang berada dalam kondisi <TutorialHighlight:Racun> akan menerima kerusakan setara dengan jumlah lapisan <TutorialHighlight:Racun> pada akhir giliran. Kerusakan <TutorialHighlight:Racun> <TutorialHighlight:tidak dapat memberikan kritikal>."
  },
  Tutorial_17811_Title_1 = {Text = "Racun"},
  Tutorial_17812_Desc_1 = {
    Text = "Target yang berada dalam kondisi <TutorialHighlight:Rentan> akan menerima kerusakan yang meningkat sebesar 50%, dan secara otomatis menghapus 1 lapisan <TutorialHighlight:Rentan> pada akhir giliran. Manfaatkan kesempatan ketika musuh berada dalam keadaan <TutorialHighlight:Rentan> untuk memberikan lebih banyak kerusakan."
  },
  Tutorial_17812_Title_1 = {Text = "Vulnerable"},
  Tutorial_17813_Desc_1 = {
    Text = "Setelah menyelesaikan level di \"Pelarutan Reruntuhan\",\"Tabu Catatan\", dan \"Keberadaan Transenden\", level tersebut dan level dengan tingkat kesulitan lebih rendah dapat melakukan <TutorialHighlight:Reproduksi>. Melalui <TutorialHighlight:Reproduksi>, hadiah level dapat diperoleh dengan cepat."
  },
  Tutorial_17813_Title_1 = {Text = "Reproduksi"},
  Tutorial_17814_Desc_1 = {
    Text = "<TutorialHighlight:Perisai> dapat menggantikan HP untuk menanggung kerusakan. Pada akhir giliran, <TutorialHighlight:otomatis dihapus> semua perisai, batas perisai setara dengan <TutorialHighlight:Kesehatan maksimum> tim. Usahakan <TutorialHighlight:agar perisai setara dengan total kerusakan semua musuh di babak ini>, untuk meraih kemenangan dalam pertempuran dengan biaya minimal."
  },
  Tutorial_17814_Title_1 = {Text = "Perisai"},
  Tutorial_17815_Desc_1 = {
    Text = "Mendapatkan Tubuh Terjaga yang sama akan mengubahnya menjadi <TutorialHighlight:Serpihan>. Mengonsumsi <TutorialHighlight:Serpihan> untuk meningkatkan Enlighten Level Tubuh Terjaga, yang dapat memberikan kemampuan khusus tambahan pada keterampilan Tubuh Terjaga. Ketika Enlighten Level Tubuh Terjaga sudah penuh, mendapatkan Serpihan yang sesuai akan diubah menjadi <TutorialHighlight:Fragmen Kembali Jiwa>."
  },
  Tutorial_17815_Title_1 = {Text = "Serpihan"},
  Tutorial_17816_Desc_1 = {
    Text = "Arithmetica adalah <TutorialHighlight:dibagikan oleh seluruh tim>, memainkan kartu memerlukan konsumsi <TutorialHighlight:Arithmetica>. Arithmetica akan <TutorialHighlight:secara otomatis pulih ke batas atas> pada awal putaran, dan <TutorialHighlight:secara otomatis dikosongkan> setelah putaran berakhir. Untuk meningkatkan efisiensi penggunaan Arithmetica, silakan <TutorialHighlight:habiskan semua Arithmetica sebelum mengakhiri putaran> sebisa mungkin."
  },
  Tutorial_17816_Title_1 = {
    Text = "Arithmetica"
  },
  Tutorial_17817_Desc_1 = {
    Text = "Mengalahkan musuh dalam <TutorialHighlight:Eksistensi Transendental> dapat memberikan material peningkatan <TutorialHighlight:Keterampilan> tingkat tinggi. Hadiah bisa didapatkan 1 kali per minggu. Berbagai macam material juga bisa disintesis dan ditukar di <TutorialHighlight:Alkimia>."
  },
  Tutorial_17817_Title_1 = {
    Text = "Keberadaan Transenden"
  },
  Tutorial_17818_Desc_1 = {
    Text = "Setelah diperoleh, dapat digunakan di <TutorialHighlight:Inventaris>, mampu meningkatkan level Pembangun dan level Keterampilan secara cepat sesuai dengan nilai yang telah ditentukan."
  },
  Tutorial_17818_Title_1 = {
    Text = "Penguat gnosis"
  },
  Tutorial_17819_Desc_1 = {
    Text = "Ketika Aliemus Bangun mencapai <TutorialHighlight:100>, kamu dapat melepaskan <TutorialHighlight:Muliakan>. Efek Muliakan berbeda untuk setiap Bangun, dan penggunaan yang tepat dapat <TutorialHighlight:mencapai hasil dua kali lipat dengan separuh usaha>."
  },
  Tutorial_17819_Title_1 = {Text = "Exalt"},
  Tutorial_17820_Desc_1 = {
    Text = "Target yang berada dalam kondisi <TutorialHighlight:Rapuh>, perisai yang diperoleh berkurang sebesar 25%, dan secara otomatis menghilangkan 1 lapisan <TutorialHighlight:Rapuh> pada akhir giliran. Jika tim kita berada dalam kondisi <TutorialHighlight:Rapuh>, ingat untuk mencari cara menghilangkan status <TutorialHighlight:Rapuh> sebelum bertahan, atau ubah strategi untuk menyerang habis-habisan di putaran ini."
  },
  Tutorial_17820_Title_1 = {Text = "Fragile"},
  Tutorial_17821_Desc_1 = {
    Text = "Untuk melengkapi Pembangun dengan <TutorialHighlight:Roda takdir>, dapat meningkatkan atribut Pembangun serta memberikan Kemampuan khusus."
  },
  Tutorial_17821_Title_1 = {
    Text = "Roda takdir"
  },
  Tutorial_17822_Desc_1 = {
    Text = [[
Target yang berada dalam kondisi <TutorialHighlight:Berdarah> akan menerima kerusakan setara dengan jumlah lapisan <TutorialHighlight:Berdarah> pada akhir giliran, kemudian <TutorialHighlight:Hapus Status Berdarah>.
 Saat <TutorialHighlight:Memulihkan HP>, hapus lapisan berdarah setara dengan <TutorialHighlight:Jumlah Pemulihan 2 Kali>. Kerusakan berdarah <TutorialHighlight:tidak dapat kritis>.]]
  },
  Tutorial_17822_Title_1 = {Text = "Bleed"},
  Tutorial_17823_Desc_1 = {
    Text = "Kebangkitan kekacauan dapat <TutorialHighlight:melampaui batas alam> membentuk susunan tim dengan Pembangun dari alam lain, dan akan memiliki efek simbiosis yang berbeda. Jika terdapat Kebangkitan kekacauan di tim mana pun, ketahanan terhadap kematian akan meningkat sebesar 100%."
  },
  Tutorial_17823_Desc_2 = {
    Text = "Dibandingkan dengan tim dari alam lain, tim Alam Kekacauan mendapatkan Energi-s lebih cepat, dan saat melepaskan Geng yang kedua, mereka dapat memilih di antara semua Geng, dan Geng yang dipilih akan memicu 2 kali. Oleh karena itu, tim Alam Kekacauan lebih bergantung pada kolaborasi antar Geng, dan memilih Geng yang tepat dapat secara signifikan meningkatkan kekuatan tim Alam Kekacauan!"
  },
  Tutorial_17823_Title_1 = {Text = "Chaos"},
  Tutorial_17824_Desc_1 = {
    Text = "Setiap memiliki 1 poin <TutorialHighlight:Waspada>, setiap kali mendapatkan perisai akan mendapatkan tambahan 1 poin perisai."
  },
  Tutorial_17824_Title_1 = {Text = "Alert"},
  Tutorial_17825_Desc_1 = {
    Text = "Setelah menyelesaikan operasi penyelidikan untuk pertama kalinya, kamu bisa mendapatkan <TutorialHighlight:Bahan Aktivasi Resonansi>, yang dapat digunakan untuk mengaktifkan <TutorialHighlight:Resonansi> yang kuat. Resonansi akan berlaku di semua level dalam bab ini."
  },
  Tutorial_17825_Title_1 = {Text = "Resonansi"},
  Tutorial_17826_Desc_1 = {
    Text = "Ketika tim saya berada dalam kondisi <TutorialHighlight:Aliemus Terkunci>, tidak dapat melepaskan Muliakan. Sebelum musuh segera melakukan <TutorialHighlight:Aliemus Terkunci>, Anda dapat melepaskan Muliakan untuk menghindari membuang Aliemus."
  },
  Tutorial_17826_Title_1 = {
    Text = "Selo Aliemus"
  },
  Tutorial_17827_Desc_1 = {
    Text = "Mengonsumsi <TutorialHighlight: Eliksir gnosis> dapat meningkatkan level Pembangun, setelah peningkatan, atribut akan meningkat. Setelah mencapai batas level, perlu untuk Mendidik terlebih dahulu, setelah Mendidik akan meningkatkan batas level Pembangun."
  },
  Tutorial_17827_Title_1 = {
    Text = "Eliksir gnosis"
  },
  Tutorial_17828_Desc_1 = {
    Text = "<TutorialHighlight:Kekuatan> setiap berkurang 1 poin, setiap kali menyebabkan <TutorialHighlight:Kerusakan Aktif>, akan mengurangi 1 poin kerusakan."
  },
  Tutorial_17828_Title_1 = {Text = "STR▼"},
  Tutorial_17829_Desc_1 = {
    Text = "Sebelum menerima kerusakan setiap kali, kebal terhadap kerusakan dan hapus 1 lapisan <TutorialHighlight:Penghalang>. Semakin tinggi kerusakan tunggal, semakin besar manfaat dari <TutorialHighlight:Penghalang>."
  },
  Tutorial_17829_Title_1 = {Text = "Penghalang"},
  Tutorial_17830_Desc_1 = {
    Text = "Target yang berada dalam kondisi <TutorialHighlight:Kelemahan>, kerusakan yang ditimbulkan berkurang 25%, dan secara otomatis menghapus 1 lapisan <TutorialHighlight:Kelemahan> pada akhir giliran. Jika tim kami berada dalam kondisi <TutorialHighlight:Kelemahan>, ingat untuk mencari cara menghapus status <TutorialHighlight:Kelemahan> sebelum menyerang, atau ubah strategi, fokuskan sepenuhnya pada pertahanan di giliran ini."
  },
  Tutorial_17830_Title_1 = {Text = "Weakness"},
  Tutorial_17831_Desc_1 = {
    Text = "Mengalahkan musuh dalam <TutorialHighlight:Rekam Tabu> dapat memberikan <TutorialHighlight:Covenant> untuk meningkatkan kemampuan Tubuh Terjaga. Setiap kali menyelesaikan satu bab dari alur utama akan membuka level <TutorialHighlight:Rekam Tabu> baru. Covenant juga bisa didapatkan melalui penukaran di toko."
  },
  Tutorial_17831_Title_1 = {Text = "Rekam Tabu"},
  Tutorial_17832_Desc_1 = {
    Text = "Salinan sementara dari kartu perintah <TutorialHighlight:kartu pertama> yang dimainkan oleh tim Ultra setiap ronde akan masuk ke <TutorialHighlight:Ruang Ultra> dan memicu efek lompatan yang kuat. Ketika ruang Ultra mencapai batas maksimum, dapatkan 1 <TutorialHighlight:Ultra Round> tambahan, <TutorialHighlight:Ronde Ultra dapat memicu semua efek lompatan>. Rahasia dasar untuk memainkan tim Ultra dengan baik: Rencanakan dengan cermat kartu pertama yang dimainkan setiap ronde."
  },
  Tutorial_17832_Title_1 = {Text = "Ultra"},
  Tutorial_17833_Desc_1 = {
    Text = "Ketika HP tim kita habis, kita dapat mengaktifkan <TutorialHighlight:Tubuh Gnosis Darurat> untuk memulihkan semua status. Tubuh Gnosis Darurat secara otomatis pulih <TutorialHighlight:1> kali setiap hari, dengan batas maksimum <TutorialHighlight:5> kali. Gunakan Tubuh Gnosis Darurat dengan bijak dalam <TutorialHighlight:Pertempuran Sulit>, jangan sia-siakan secara sembarangan."
  },
  Tutorial_17833_Title_1 = {
    Text = "Tubuh Gnosis Darurat"
  },
  Tutorial_17834_Desc_1 = {
    Text = "Telusuri dengan cermat lokasi yang sedikit bercahaya di peta, pergi ke sana untuk melakukan Penyelidikan mungkin akan ada hasil tak terduga."
  },
  Tutorial_17834_Title_1 = {
    Text = "Titik Ekstraksi"
  },
  Tutorial_17835_Desc_1 = {
    Text = "Mewakili total kerusakan musuh di babak ini. Sebuah pengalaman pertempuran praktis untuk Penjaga: <TutorialHighlight:Usahakan agar perisai setara dengan total kerusakan musuh>."
  },
  Tutorial_17835_Title_1 = {
    Text = "Total kerusakan musuh"
  },
  Tutorial_17837_Desc_1 = {
    Text = "Ketika <TutorialHighlight:Fusi Embrio> tim Caro mencapai batas atas, akan mendapatkan 1 kartu <TutorialHighlight:「Embrio」>. Melepaskan Exalt akan menghabiskan <TutorialHighlight:「Embrio」> untuk memicu efek <TutorialHighlight:Devour> yang kuat. Oleh karena itu, sebisa mungkin lepaskan Exalt saat memiliki <TutorialHighlight:「Embrio」> di tangan, jika tidak, tidak dapat memaksimalkan kekuatan tim Caro."
  },
  Tutorial_17837_Desc_2 = {
    Text = "Setelah setiap pertarungan, 5% dari jumlah pemulihan maksimum akan terakumulasi di Dapur Merah. Jika ada <TutorialHighlight:\"embrio\"> yang belum digunakan, setiap embrio juga akan mengakumulasi 5% dari jumlah pemulihan maksimum di tungku. Dapur Merah dapat digunakan untuk memulihkan kehidupan tim kita, setiap putaran bisa mengubah tungku menjadi kehidupan sekali. Penjaga perlu merencanakan waktu penggunaan Dapur Merah dengan bijak untuk menghasilkan efek yang dapat membalikkan keadaan."
  },
  Tutorial_17837_Title_1 = {Text = "Caro"},
  Tutorial_17838_Desc_1 = {
    Text = "Di Persimpangan, kamu dapat memilih untuk memulihkan 50% dari Hidup tim kita yang telah hilang, atau menetapkan 1 Pembangun untuk di-Bangun. Jika Hidup tim kita rendah, disarankan untuk memilih pemulihan Hidup; jika tidak, disarankan untuk memilih Bangun Pembangun."
  },
  Tutorial_17838_Title_1 = {
    Text = "Titik Kontak"
  },
  Tutorial_17839_Desc_1 = {
    Text = "Tempat untuk mengonsumsi Segil hitam untuk memperkuat tim kita, biasanya menyediakan 1 slot Orison, 1 slot Relik perak, dan 1 slot Relik emas. Jika tidak ada barang yang diperlukan di sini, kamu bisa mengklik <TutorialHighlight:Segarkan> di sudut kanan atas, D-marka akan menyediakan barang baru."
  },
  Tutorial_17839_Title_1 = {Text = "D-marka"},
  Tutorial_17840_Desc_1 = {
    Text = "Memaksa melewati <TutorialHighlight:Ilusi> akan menginfeksi \"Gejala\"."
  },
  Tutorial_17840_Title_1 = {Text = "Ilusi"},
  Tutorial_17841_Desc_1 = {
    Text = "Melalui Kartu perintah, Pembangun dapat memperoleh <TutorialHighlight:Aliemus>. Semakin tinggi level Keterampilan Kartu perintah, semakin banyak Aliemus yang diperoleh."
  },
  Tutorial_17841_Title_1 = {Text = "Aliemus"},
  Tutorial_17842_Desc_1 = {
    Text = "Mengalahkan musuh dan menyelidiki acara bisa mendapatkan <TutorialHighlight:Segil hitam>, atribut <TutorialHighlight:Penurunan Segil Hitam> Pembangun dapat meningkatkan jumlah Segil Hitam yang diperoleh."
  },
  Tutorial_17842_Desc_2 = {
    Text = "Di D-marka, kamu bisa mengonsumsi <TutorialHighlight:Segil hitam> untuk membeli Orison dan Relik, atau menggunakannya untuk membangunkan Pembangun. Sebelum pertarungan terakhir, habiskan semua Segil hitam yang kamu miliki untuk memperkuat tim kita semaksimal mungkin."
  },
  Tutorial_17842_Title_1 = {
    Text = "Segil hitam"
  },
  Tutorial_17843_Desc_1 = {
    Text = "Saat diserang, berikan kerusakan kepada penyerang sesuai dengan jumlah lapisan <TutorialHighlight:Counter>. Kerusakan <TutorialHighlight:Counter> <TutorialHighlight:tidak dapat kritis>."
  },
  Tutorial_17843_Title_1 = {Text = "Counter"},
  Tutorial_17844_Desc_1 = {
    Text = "Setiap memiliki 1 poin <TutorialHighlight:Kekuatan>, setiap kali memberikan kerusakan aktif akan meningkatkan kerusakan tambahan sebesar 1 poin."
  },
  Tutorial_17844_Title_1 = {Text = "Kekuatan"},
  Tutorial_17845_Desc_1 = {
    Text = "Tugas Pembangun menyelesaikan misi penelitian. Setelah selesai, hadiah yang sesuai dapat diperoleh. Semakin tinggi <TutorialHighlight:Total Level> Pembangun yang ditugaskan, semakin kaya hadiahnya, dengan perhitungan maksimal berdasarkan total level 240."
  },
  Tutorial_17845_Title_1 = {Text = "Tugas"},
  Tutorial_17847_Desc_1 = {
    Text = "Saat menerima kerusakan fatal, ada <TutorialHighlight:kemungkinan setara dengan Ketahanan> untuk mengimunisasi kerusakan ini dan mempertahankan 1 poin HP, <TutorialHighlight:Setelah berhasil terpicu, Ketahanan berkurang setengah>. Ketahanan tim setara dengan jumlah Ketahanan semua Awakener, meningkatkan Ketahanan tim akan membantu meningkatkan toleransi kesalahan saat bertempur."
  },
  Tutorial_17847_Title_1 = {Text = "Ketahanan"},
  Tutorial_17848_Desc_1 = {
    Text = "Pada awal pertempuran tim Aequor, 1 <TutorialHighlight:Tentakel> akan muncul. <TutorialHighlight:Tentakel> akan menyerang musuh di barisan depan pada akhir ronde, dan Anda dapat memahami kerusakan dan jumlah serangan tentakel saat ini melalui rumus di bawah ikon tentakel. Beberapa Awakener dapat meningkatkan jumlah tentakel dan kerusakan tentakel, menyebabkan kerusakan besar pada akhir ronde."
  },
  Tutorial_17848_Title_1 = {Text = "Aequor"},
  Tutorial_17850_Desc_1 = {
    Text = "Memainkan kartu memerlukan konsumsi aritmetika, dan pada akhir ronde semua kartu di tangan akan masuk ke <TutorialHighlight:Tumpukan kartu buang>. Merencanakan <TutorialHighlight:urutan bermain kartu> dengan bijak akan menjadi kunci kemenangan dalam pertempuran."
  },
  Tutorial_17850_Title_1 = {Text = "Hand"},
  Tutorial_17851_Desc_1 = {
    Text = "Mewakili tindakan yang akan segera diambil oleh musuh di ronde berikutnya. Menggunakan <TutorialHighlight:Niat> untuk membuat keputusan di ronde ini adalah inti dari gameplay pertempuran."
  },
  Tutorial_17851_Title_1 = {Text = "Niat Musuh"},
  Tutorial_17852_Desc_1 = {
    Text = "<TutorialHighlight:Peningkatan Keterampilan> dapat meningkatkan atribut Pembangun, memperkuat efek kartu perintah. Di layar keterampilan Pembangun, klik level berikutnya untuk melihat pratinjau efektivitas setelah peningkatan."
  },
  Tutorial_17852_Desc_2 = {
    Text = "Pembangun dari berbagai alam membutuhkan <TutorialHighlight:material peningkatan keterampilan> yang berbeda."
  },
  Tutorial_17852_Title_1 = {
    Text = "Memperkuat keterampila"
  },
  Tutorial_20768_Desc_1 = {
    Text = "Ketika Tubuh Terjaga memainkan Kartu perintah atau menggunakan Rouse dengan mengonsumsi Arithmetica, mereka bisa mendapatkan <TutorialHighlight:Keyflare>. Atribut <TutorialHighlight:Keyflare Regen> dari Tubuh Terjaga dapat meningkatkan <TutorialHighlight:Keyflare> yang diperoleh."
  },
  Tutorial_20768_Title_1 = {Text = "Keyflare"},
  Tutorial_20769_Desc_1 = {
    Text = "<TutorialHighlight:Pintu berkarat> akan menghalangi jalur penyelidikan penting. Cobalah untuk mencari sebuah objek yang disebut <TutorialHighlight:Kunci berkarat> di dalam peta, yang dapat digunakan untuk membuka <TutorialHighlight:Pintu berkarat>."
  },
  Tutorial_20769_Title_1 = {
    Text = "Pintu berkarat"
  },
  Tutorial_20770_Desc_1 = {
    Text = "<TutorialHighlight:Kunci berkarat> dapat membuka <TutorialHighlight:Pintu berkarat> yang menghalangi jalanmu."
  },
  Tutorial_20770_Title_1 = {
    Text = "Kunci berkarat"
  },
  Tutorial_20771_Desc_1 = {
    Text = "<TutorialHighlight:Alam Gelap> mencakup serangkaian level dari empat Realm, setelah menyelesaikannya kamu dapat memperoleh hadiah seperti Perak, Eliksir Gnosis, dan jika jumlah bintang yang dikumpulkan mencapai persyaratan tertentu, kamu juga dapat memperoleh hadiah tambahan seperti Perak dan Inti Murni!"
  },
  Tutorial_20771_Desc_2 = {
    Text = "Tingkat Retakan di antara Alam yang berbeda akan menetapkan persyaratan untuk Pembangun dalam tim investigasi, hanya tim yang <TutorialHighlight:memenuhi persyaratan> yang dapat melakukan Penyelidikan."
  },
  Tutorial_20771_Title_1 = {Text = "Alam gelap"},
  Tutorial_20772_Desc_1 = {
    Text = "Ketika Energi-s mencapai <TutorialHighlight:1000>, Anda dapat melepaskan <TutorialHighlight:Posse> yang dibawa. Setiap ronde dapat melepaskan 2 Posse, tetapi pada saat melepaskan Posse kedua, Anda akan memilih 1 dari 3 Posse acak untuk dilepaskan, dan Posse yang dipilih tidak dapat dipilih lagi dalam eksplorasi ini. Saat menyusun tim, pilih Posse yang sesuai untuk tim kita agar proses investigasi menjadi lebih lancar."
  },
  Tutorial_20772_Title_1 = {Text = "Posse"},
  Tutorial_20773_Desc_1 = {
    Text = [[
Menggunakan <TutorialHighlight:Roda takdir> yang sama untuk posisi tumpuk, atau menggunakan <TutorialHighlight:Cetakan Siklus> untuk melakukan posisi tumpuk pada <TutorialHighlight:Roda takdir SSR>, dapat meningkatkan atribut dan kemampuan khusus <TutorialHighlight:Roda takdir>. Ketika ditumpuk 1 hingga 3 kali, efek Roda takdir akan meningkat; ketika ditumpuk 4 hingga 15 kali, atribut Roda takdir akan meningkat. Anda dapat mengklik tombol "Tingkat Berikutnya" di layar tumpukan untuk melihat pratinjau perubahan setelah ditumpuk.
Ketika mendapatkan Roda takdir yang sudah dimiliki melalui kebangkitan dan cara lainnya, sistem akan secara otomatis melakukan posisi tumpuk dengan Roda takdir yang sudah ada, tanpa perlu operasi terpisah dari Penjaga.]]
  },
  Tutorial_20773_Title_1 = {
    Text = "Roda Takdir Bertumpuk"
  },
  Tutorial_22247_Desc_1 = {
    Text = "<TutorialHighlight:Covenant Peningkatan> dapat meningkatkan kekuatan atribut Covenant, hingga level 12. Pemecahan Covenant dapat menghasilkan Buku Sisa yang sesuai, dan pertukaran material dalam sumber daya dapat menghasilkan <TutorialHighlight:Cap Segel Seribu Wajah>. Peningkatan Covenant memerlukan konsumsi <TutorialHighlight:Cap Segel Seribu Wajah>, dan memecahkan Covenant yang sudah ditingkatkan juga akan mengembalikan konsumsi peningkatan <TutorialHighlight:Cap Segel Seribu Wajah>."
  },
  Tutorial_22247_Title_1 = {
    Text = "Peningkatan Perjanjian"
  },
  Tutorial_22248_Desc_1 = {
    Text = "Melalui transkripsi, <TutorialHighlight:Perjanjian> dapat memperoleh atribut dengan jenis dan kekuatan yang acak. Atribut sekunder tidak bergantung pada bagian, dan dapat muncul dalam 8 jenis: Crit. Rate, Crit. DMG, Tingkat Recharge Aliemus, Tingkat Muatan Kunci Perak, Realm Mastery, Sigil Yield, DMG Amplification, dan Ketahanan. Saat transkripsi, jika ingin mempertahankan atribut tertentu, Anda dapat memilih <TutorialHighlight:Kunci>, atribut yang terkunci tidak akan berubah selama transkripsi."
  },
  Tutorial_22248_Title_1 = {
    Text = "Transkripsi Perjanjian"
  },
  Tutorial_23466_Desc_1 = {
    Text = "Seiring dengan peningkatan level Penjaga, <TutorialHighlight: kekuatan Relik dan Orison> juga akan meningkat, dan pengaruh <TutorialHighlight: setiap poin CON terhadap HP tim> juga akan bertambah. Melalui Operasi dan Selingan, kamu bisa mendapatkan banyak Pengalaman penjaga. Setiap kali menghabiskan 1 poin stamina, kamu akan mendapatkan 1 poin Pengalaman penjaga."
  },
  Tutorial_23466_Title_1 = {
    Text = "Level Penjaga"
  },
  Tutorial_47538_Desc_1 = {
    Text = "Efek-d regional terlarang adalah sistem permainan dengan tingkat kesulitan yang tinggi. Penjaga perlu mengatur berbagai tim tantangan dengan fleksibel, untuk mendapatkan sebanyak mungkin Nilai Latihan, sehingga memperoleh lebih banyak hadiah. Tingkat kewaspadaan yang tinggi tidak hanya membuat unit musuh menjadi lebih kuat, tetapi juga akan memiliki berbagai efek merugikan."
  },
  Tutorial_47538_Desc_2 = {
    Text = "Di zona terlarang Efek-d regional terdapat aturan pembatasan yang unik: Pembangun dan Geng yang sama, serta Roda takdir dengan nama yang sama tidak dapat diturunkan kembali. Penjaga dapat memilih tim untuk tantangan kali ini secara fleksibel berdasarkan Relik awal, monster, dan Tingkat yang direkomendasikan, menggunakan strategi perlombaan Tian Ji untuk mendapatkan sebanyak mungkin Nilai Latihan. Pembangun yang diturunkan melalui cara <TutorialHighlight: bantuan> tidak terpengaruh oleh pembatasan ini."
  },
  Tutorial_47538_Title_1 = {
    Text = "Efek-d regional terlarang"
  },
  Tutorial_54390_Desc_1 = {
    Text = "Dalam mode <TutorialHighlight:Traphase>, semua <TutorialHighlight:Negara> yang dimiliki oleh Pembangun musuh dan sekutu di antarmuka pertempuran akan ditampilkan di bawah Hidup dan Aliemus mereka. Klik untuk melihat efek spesifiknya."
  },
  Tutorial_54390_Desc_2 = {
    Text = "Termasuk dalam <TutorialHighlight:Status Positif> sebagai berikut (klik untuk melihat detail): <TauntKeywords:Mengejek>, <PVPPowerIconKeywords:Kekuatan>, <EnergyStorageKeywords:Muatan>, <PVPProtectiveKeywords:Penghalang>, <PVPRetaliateIconKeywords:Counter>, <ReinforceKeywords:Fortress>, <StrengthenKeywords:Memperkuat>."
  },
  Tutorial_54390_Desc_3 = {
    Text = "Termasuk <TutorialHighlight:Status Negatif> berikut (klik untuk melihat detail): <PVPEntanglementKeywords:Terjerat>, <PVPVulnerabilityIconKeywords:Rentan>, <PVPSlowKeywords:Lambat>, <ComaKeywords:Terpetrifikasi>, <DisarmKeywords:Kelumpuhan>, <PVPMethysisKeywords:Racun>, <PVPEmptinessKeywords:Kosong>, <PVPBleedingKeywords:Berdarah>, <PVPSeriousInjuryKeywords:Luka Berat>, <ComaKeywords:Pingsan>."
  },
  Tutorial_54390_Title_1 = {Text = "Negara"},
  Tutorial_54391_Desc_1 = {
    Text = "Dalam mode <TutorialHighlight:Traphase>, beberapa kartu Pembangun akan memiliki efek <TutorialHighlight:Affix> yang berbeda, yang dapat dilihat di sistem <TutorialHighlight:Koleksi> atau dengan menekan lama kartu selama pertempuran. Efek yang termasuk dalam affix adalah (klik untuk melihat detail): <PVPPenetrateKeywords:Pierce>, <PrepareKeywords:Prepare>, <PVPResurrectionKeywords:Kebangkitan>, <PVPHoldingKeywords:In Hand>, <PhantomKeywords:Ilusi>, <PVPRaidKeywords:Ambush>."
  },
  Tutorial_54391_Title_1 = {Text = "Affix"},
  Tutorial_54392_Desc_1 = {
    Text = [[
Dalam beberapa mode khusus akan ada mode <TutorialHighlight:Musim>. Dengan berpartisipasi dalam papan peringkat mode khusus selama musim berlangsung, hadiah akan dihitung berdasarkan peringkat saat musim berakhir.
Seiring dengan kemajuan progres penyelidikan, di masa depan akan ada lebih banyak mode yang berpartisipasi dalam mode <TutorialHighlight:Musim>.]]
  },
  Tutorial_54392_Desc_2 = {
    Text = "Setiap musim akan ada <TutorialHighlight:Misi Musiman>. Selesaikan misi musiman untuk mendapatkan hadiah berlimpah. Misi musiman akan direset saat musim diperbarui."
  },
  Tutorial_54392_Title_1 = {
    Text = "Musim Kompetisi"
  },
  Tutorial_54393_Desc_1 = {
    Text = "Dalam mode <TutorialHighlight:Traphase>, setelah Pembangun kalah, kartu yang dimiliki oleh Pembangun tersebut di tangan akan berubah menjadi <TutorialHighlight:Ilusi>. Melengkapi <TutorialHighlight:Roda takdir> pada Pembangun yang telah kalah juga mendapatkan 1 kartu Ilusi, dan mengembalikan aritmetika yang dikonsumsi. Ilusi juga dapat digabungkan menjadi <TutorialHighlight:Harapan Kecil> melalui efek Roda takdir tertentu."
  },
  Tutorial_54393_Title_1 = {Text = "Ilusi"},
  Tutorial_54394_Desc_1 = {
    Text = "Dalam mode <TutorialHighlight:Traphase>, pada putaran pertama, kedua belah pihak memiliki 3 poin <TutorialHighlight:Arithmetica> dan batas atas, giliran kedua akan mendapatkan 1 kartu <TutorialHighlight:Serangan Terakhir, Serangan Terbaik>. Setelah itu, pada awal setiap putaran, batas aritmetika dan jumlah pemulihan akan meningkat 1 poin hingga mencapai 10 poin. Selain pertumbuhan otomatis, ada juga cara lain untuk meningkatkan atau menurunkan batas aritmetika, setelah batas aritmetika mencapai 10, setiap 1 poin yang melebihi batas akan digantikan dengan menarik 1 kartu."
  },
  Tutorial_54394_Title_1 = {
    Text = "Arithmetica"
  },
  Tutorial_54395_Desc_1 = {
    Text = "Dalam mode <TutorialHighlight:Traphase>, setiap Awakener juga memiliki <TutorialHighlight:Aliemus> dan <TutorialHighlight:Exalt>. Kamu dapat memperoleh Aliemus dengan menggunakan kartu <TutorialHighlight:Pukulan> atau kartu <TutorialHighlight:Keterampilan> tertentu. Aliemus juga akan diperoleh saat menerima kerusakan yang mengurangi HP (setiap kehilangan 2% HP atau jumlah Perisai yang setara memberikan 1 poin Aliemus). Setelah Aliemus mencapai 100, klik Awakener yang sesuai untuk memilih melepaskan Exalt."
  },
  Tutorial_54395_Title_1 = {Text = "Aliemus"},
  Tutorial_54396_Desc_1 = {
    Text = "Dalam mode <TutorialHighlight:Traphase>, selesaikan target yang ditentukan dalam \"Rekaman Pertandingan\" selama pertandingan pencocokan untuk mengklaim hadiah yang sesuai. Hadiah ini adalah hadiah satu kali, tidak direset dengan musim, dan dapat dilihat melalui \"Rekaman Pertandingan\" di pojok kiri bawah antarmuka."
  },
  Tutorial_54396_Title_1 = {
    Text = "Catatan Pertandingan Catur"
  },
  Tutorial_54397_Desc_1 = {
    Text = "Dalam mode <TutorialHighlight:Traphase>, Anda dapat melihat semua informasi tentang Pembangun, Roda Takdir, dan Geng di tab \"Koleksi\" di sisi kiri antarmuka."
  },
  Tutorial_54397_Title_1 = {Text = "Koleksi"},
  Tutorial_54398_Desc_1 = {
    Text = "Dalam mode <TutorialHighlight:Traphase>, setiap Pembangun memiliki 2 kartu <TutorialHighlight:Pukulan> dan 3 kartu <TutorialHighlight:Keterampilan>. Biasanya, kartu keterampilan yang berbeda akan memiliki Lelah Aritmetika yang berbeda."
  },
  Tutorial_54398_Title_1 = {
    Text = "Keterampilan"
  },
  Tutorial_54399_Desc_1 = {
    Text = "Dalam mode <TutorialHighlight:Traphase>, jumlah kartu yang ditarik secara otomatis setiap putaran juga 5 kartu, dan <TutorialHighlight:Maximum Hand Size> default juga 10 kartu. Anda dapat melihat jumlah kartu tangan saat ini dan batas tangan kita di sudut kanan bawah layar pertempuran, dan situasi lawan di sudut kanan atas. Anda dapat mengubah jumlah kartu yang ditarik setiap putaran dan batas tangan dengan cara lain."
  },
  Tutorial_54399_Title_1 = {Text = "Hand"},
  Tutorial_54400_Desc_1 = {
    Text = "Dalam mode <TutorialHighlight:Traphase>, Pembangun yang berbeda memiliki <TutorialHighlight:posisi> yang berbeda, total ada 5. Masing-masing adalah <TutorialHighlight:Pembela>, <TutorialHighlight:perjuangan>, <TutorialHighlight:Luminis>, <TutorialHighlight:Bintang Malang>, <TutorialHighlight:Berkah>. Saat melakukan <TutorialHighlight:Susunan tim>, perlu memilih 4 Pembangun dengan posisi yang berbeda untuk membentuk tim."
  },
  Tutorial_54400_Title_1 = {Text = "Lokasi"},
  Tutorial_54401_Desc_1 = {
    Text = "Dalam mode <TutorialHighlight:Traphase - Mode Prasusunan>, ketuk \"Mulai Pencocokan\" di pojok kanan bawah antarmuka untuk masuk ke antarmuka susunan tim. Kamu juga bisa menyusun tim terlebih dahulu melalui <TutorialHighlight:Prasusunan Tim> di sisi kiri antarmuka."
  },
  Tutorial_54401_Desc_2 = {
    Text = "Susunan tim pra-set mendukung penyimpanan beberapa set. Di pojok kiri atas, kamu juga bisa mengedit nama tim. Setiap tim terdiri dari 4 Pembangun, 4 Roda Takdir, dan 2 Geng."
  },
  Tutorial_54401_Title_1 = {
    Text = "Susunan tim"
  },
  Tutorial_54705_Desc_1 = {
    Text = "Di mode <TutorialHighlight:Traphase>, klik <TutorialHighlight:avatar> kamu, pilih <TutorialHighlight:ekspresi> yang ingin dikirimkan untuk menyampaikan perasaanmu kepada lawan!"
  },
  Tutorial_54705_Title_1 = {Text = "Ekspresi"},
  Tutorial_54706_Desc_1 = {
    Text = "<TutorialHighlight:Traphase> adalah permainan dua pemain, di mana kedua belah pihak menggunakan tim pra-konstruksi masing-masing untuk <TutorialHighlight:pertandingan>, dan saat pencocokan akan mencocokkan lawan yang seimbang secara terdekat."
  },
  Tutorial_54706_Desc_2 = {
    Text = "Dengan bertarung, kamu bisa mendapatkan <TutorialHighlight:Pengalaman Prebuilt> dan <TutorialHighlight:Pengalaman Draft>. Berdasarkan pengalaman yang diperoleh, buka <TutorialHighlight:hadiah satu kali> di <TutorialHighlight:Level Prebuilt> dan <TutorialHighlight:Level Draft>!"
  },
  Tutorial_54706_Desc_3 = {
    Text = "Setiap musim, berdasarkan peringkat poin, kamu akan mendapatkan <TutorialHighlight:Gelar>. Pada akhir musim, peringkat akan dihitung, dan hadiah peringkat akan dikirim melalui kotak surat."
  },
  Tutorial_54706_Title_1 = {
    Text = "Pengantar Permainan"
  },
  Tutorial_74798_Desc_1 = {
    Text = "Lingkungan <TutorialHighlight:Bab Level> yang berbeda akan ada di level yang berbeda, secara signifikan mengubah aturan keseluruhan dan efek Relik. Informasi lebih lanjut dapat dilihat dengan mengklik tab terkait di antarmuka setiap level."
  },
  Tutorial_74798_Title_1 = {
    Text = "Bab Tingkat"
  },
  Tutorial_81370_Desc_1 = {
    Text = "<TutorialHighlight:Retrospeksi Pembangun> dapat mengembalikan berbagai konsumsi pengembangan Pembangun."
  },
  Tutorial_81370_Desc_2 = {
    Text = "<TutorialHighlight:Retrospeksi Pengembangan> akan mereset level Pembangun, Mendidik, Keterampilan, dan Negara yang diperoleh, semua bahan dan tiket yang terbuang akan dikembalikan sepenuhnya."
  },
  Tutorial_81370_Desc_3 = {
    Text = "<TutorialHighlight:Retrospeksi Mencerahkan> akan mereset status Mencerahkan Pembangun, dan mereset batas level yang diperoleh dari Mencerahkan, semua bahan yang terbuang akan dikembalikan sepenuhnya."
  },
  Tutorial_81370_Desc_4 = {
    Text = "<TutorialHighlight:Pengembalian Kolam Hitam> akan menyertakan efek \"Retrospeksi Pengembangan\", dan juga secara tambahan akan mereset Pembangun itu sendiri, mengubahnya menjadi status tidak terkunci."
  },
  Tutorial_81370_Title_1 = {
    Text = "Penyemangat kembali"
  },
  Tutorial_81371_Desc_1 = {
    Text = "<TutorialHighlight:Peningkatan Pembangun> adalah salah satu cara tercepat untuk meningkatkan atribut Pembangun. Menghabiskan <TutorialHighlight:Eliksir Gnosis> dapat meningkatkan level Pembangun."
  },
  Tutorial_81371_Desc_2 = {
    Text = "Setelah penyemangat mencapai batas level, perlu melalui <TutorialHighlight:mendidik> untuk meningkatkan batas level, penyemangat dari alam yang berbeda memerlukan <TutorialHighlight:bahan mendidik> yang berbeda."
  },
  Tutorial_81371_Title_1 = {
    Text = "Peningkatan Bangun"
  },
  Tutorial_81372_Desc_1 = {
    Text = "<TutorialHighlight:Mencerahkan Aktivasi> dapat secara signifikan meningkatkan efek Kartu perintah Pembangun. Tingkat Mencerahkan 7 dapat membuka kunci <TutorialHighlight:Over-Exaltation>, memberikan efek tambahan saat Pembangun melepaskan Aliemus. Tingkat Mencerahkan 11 dan 15 dapat meningkatkan batas tingkat Pembangun sebesar 5 tingkat"
  },
  Tutorial_81372_Title_1 = {
    Text = "Mencerahkan Aktivasi"
  }
})
return Text_Tutorial
