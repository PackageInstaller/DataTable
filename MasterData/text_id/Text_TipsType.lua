__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TipsType = readonly({
  TipsType_100001_Desc = {
    Text = "Setelah mengganti resolusi, klien perlu di-restart agar perubahan dapat diterapkan. Apakah Anda yakin?"
  },
  TipsType_100001_LeftBtnDesc = {Text = "Batal"},
  TipsType_100001_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_100001_Title = {
    Text = "Konfirmasi penggantian resolusi"
  },
  TipsType_100002_Desc = {
    Text = "Menunggu {s1} menerima undangan untuk bermain lagi"
  },
  TipsType_100002_RightBtnDesc = {Text = "Batal"},
  TipsType_100002_Title = {
    Text = "Main satu kali lagi"
  },
  TipsType_100003_Desc = {
    Text = "{s1} mengundangmu untuk satu putaran lagi"
  },
  TipsType_100003_LeftBtnDesc = {Text = "Menolak"},
  TipsType_100003_RightBtnDesc = {Text = "Terima"},
  TipsType_100003_Title = {
    Text = "Main satu kali lagi"
  },
  TipsType_100004_Desc = {
    Text = "Sudah menjadi latar belakang asrama saat ini."
  },
  TipsType_100005_Desc = {
    Text = "Mode Traphase belum dibuka"
  },
  TipsType_100006_Desc = {
    Text = "Mode Traphase lawan belum diaktifkan"
  },
  TipsType_100007_Desc = {
    Text = "Kedua belah pihak harus saling mengikuti untuk memulai pertandingan persahabatan."
  },
  TipsType_100008_Desc = {
    Text = "Pihak lain sudah offline."
  },
  TipsType_100009_Desc = {
    Text = "Pihak lain sedang menjelajahi."
  },
  TipsType_100010_Desc = {
    Text = "Waktu tunggu untuk pertandingan persahabatan telah habis"
  },
  TipsType_100011_Desc = {
    Text = "Anda telah membatalkan pertandingan persahabatan."
  },
  TipsType_100012_Desc = {
    Text = "Undangan pertandingan persahabatan telah ditolak"
  },
  TipsType_100012_LeftBtnDesc = {Text = "Konfirmasi"},
  TipsType_100012_Title = {Text = "Petunjuk"},
  TipsType_100013_Desc = {
    Text = "Pihak lain sudah offline."
  },
  TipsType_100014_Desc = {
    Text = "Pihak lain telah memasuki mode permainan lainnya."
  },
  TipsType_100015_Desc = {
    Text = "Undangan terlalu sering, coba lagi dalam {s1} detik"
  },
  TipsType_100016_Desc = {
    Text = "Lawan telah membatalkan pertandingan persahabatan."
  },
  TipsType_100016_LeftBtnDesc = {Text = "Konfirmasi"},
  TipsType_100016_Title = {Text = "Petunjuk"},
  TipsType_100017_Desc = {
    Text = "Pemain ini sedang menjalankan pertandingan persahabatan."
  },
  TipsType_100017_LeftBtnDesc = {Text = "Konfirmasi"},
  TipsType_100017_Title = {Text = "Petunjuk"},
  TipsType_100018_Desc = {
    Text = [[
Susunan ini mengandung kartu yang digunakan terbatas waktu, perlu membuka topik inti saat ini agar dapat terus digunakan, berharap untuk bertempur berdampingan lagi denganmu!
Apakah Anda ingin pergi untuk membuka topik inti?]]
  },
  TipsType_100018_LeftBtnDesc = {Text = "Batal"},
  TipsType_100018_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_100018_Title = {
    Text = "Topik inti telah melewati batas waktu"
  },
  TipsType_10001_Desc = {
    Text = "Operasi berhasil"
  },
  TipsType_100020_Desc = {
    Text = "Masih dalam pertempuran, apakah ingin melanjutkan pertempuran sebelumnya?"
  },
  TipsType_100020_LeftBtnDesc = {Text = "Batal"},
  TipsType_100020_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_100020_Title = {Text = "Petunjuk"},
  TipsType_10002_Desc = {
    Text = "Kesalahan tabel konfigurasi"
  },
  TipsType_10003_Desc = {
    Text = "Data yang dikirim oleh klien salah"
  },
  TipsType_10004_Desc = {
    Text = "Server belum diaktifkan"
  },
  TipsType_10005_Desc = {
    Text = "Data karakter bermasalah"
  },
  TipsType_10006_Desc = {
    Text = "Data Pembangun tidak ditemukan"
  },
  TipsType_10007_Desc = {
    Text = "Pembangun telah mencapai level tertinggi."
  },
  TipsType_10008_Desc = {
    Text = "Tidak cukup poin topik pelajaran"
  },
  TipsType_10009_Desc = {
    Text = "Pembangun belum mencapai level tertinggi, sehingga tidak dapat Mencerahkan."
  },
  TipsType_100100_Desc = {
    Text = "Saat ini terdapat pembaruan versi game. Jika tidak diperbarui secara otomatis, silakan coba mulai ulang Steam lalu periksa pembaruan."
  },
  TipsType_100100_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_100100_Title = {
    Text = "Pemberitahuan Pembaruan"
  },
  TipsType_10010_Desc = {
    Text = "Mencerahkan telah selesai"
  },
  TipsType_10011_Desc = {
    Text = "Saat ini belum ada karakter yang dibuat."
  },
  TipsType_10012_Desc = {
    Text = "Karakter yang sudah ada saat ini"
  },
  TipsType_10013_Desc = {
    Text = "Nama karakter terduplikasi"
  },
  TipsType_10014_Desc = {
    Text = "Kesalahan Area Domain"
  },
  TipsType_10015_Desc = {
    Text = "Tidak dapat menemukan area Domain"
  },
  TipsType_10016_Desc = {
    Text = "Stamina saat ini terlalu rendah"
  },
  TipsType_10017_Desc = {
    Text = "Dapat dibuka dari {s1} hingga {s2}"
  },
  TipsType_10018_Desc = {
    Text = "Setelah tiba di lapisan kedua Domain ini sebanyak 1 kali, kamu dapat melakukan Penyelidikan Cepat."
  },
  TipsType_10019_Desc = {
    Text = "Acara telah selesai"
  },
  TipsType_10020_Desc = {
    Text = "Tipe dalam tabel konfigurasi Acara diisi dengan salah"
  },
  TipsType_10021_Desc = {
    Text = "Acara tidak tersedia"
  },
  TipsType_10022_Desc = {
    Text = "Segil Hitam tidak cukup untuk melakukan pembelian"
  },
  TipsType_10023_Desc = {
    Text = "Kartu ini tidak dapat diperkuat"
  },
  TipsType_10024_Desc = {
    Text = "Kartu ini telah mencapai batas maksimum penguatan"
  },
  TipsType_10025_Desc = {
    Text = "Pedagang tidak menjual barang ini."
  },
  TipsType_10026_Desc = {
    Text = "Tidak ada hadiah tersebut"
  },
  TipsType_10027_Desc = {
    Text = "Hadiah sudah diklaim"
  },
  TipsType_10028_Desc = {
    Text = "Data acara salah"
  },
  TipsType_10029_Desc = {
    Text = "Barang telah dibeli"
  },
  TipsType_10030_Desc = {
    Text = "Energi saat ini tidak cukup untuk mengaktifkan portal. Diperlukan {s1} poin energi untuk mengaktifkannya."
  },
  TipsType_10031_Desc = {
    Text = "Acara dialog tidak ditemukan"
  },
  TipsType_10032_Desc = {
    Text = "Jumlah Kartu Perintah Acara tidak mencukupi"
  },
  TipsType_10033_Desc = {
    Text = "Jumlah Kartu Perintah Acara terlalu banyak"
  },
  TipsType_10034_Desc = {
    Text = "Kartu perintah untuk acara tidak tersedia"
  },
  TipsType_10035_Desc = {
    Text = "Tidak ada data dalam kumpulan Acara acak"
  },
  TipsType_10036_Desc = {
    Text = "Pedagang tidak menjual barang ini."
  },
  TipsType_10037_Desc = {
    Text = "Jumlah Relik Acara tidak mencukupi"
  },
  TipsType_10038_Desc = {
    Text = "Jumlah Relik Acara terlalu banyak"
  },
  TipsType_10039_Desc = {
    Text = "Acara pemilihan Relik tidak tersedia"
  },
  TipsType_10040_Desc = {
    Text = "Node acara ini tidak ditemukan"
  },
  TipsType_10041_Desc = {
    Text = "Jumlah pembaruan pedagang telah habis"
  },
  TipsType_10042_Desc = {
    Text = "Jumlah pembaruan Kartu Perintah dari Pertempuran telah habis"
  },
  TipsType_10043_Desc = {
    Text = "Jumlah refresh drop Pertempuran Relik telah habis"
  },
  TipsType_10044_Desc = {
    Text = "Fungsi Persimpangan terkunci"
  },
  TipsType_10045_Desc = {
    Text = "Area acara tidak cocok! Area saat ini: {s1}, area konfigurasi acara: {s2}"
  },
  TipsType_10046_Desc = {
    Text = "Jumlah penghapusan kartu di toko acara telah habis"
  },
  TipsType_10047_Desc = {
    Text = "Data unit pelajaran tidak ditemukan"
  },
  TipsType_10048_Desc = {
    Text = "Unit telah dikirimkan, tidak perlu mengirimkan ulang."
  },
  TipsType_10049_Desc = {
    Text = "Tugas-tugas di bawah unit belum sepenuhnya selesai, sehingga tidak dapat diserahkan."
  },
  TipsType_10050_Desc = {
    Text = "Modul topik tidak ditemukan"
  },
  TipsType_10051_Desc = {
    Text = "Level tidak memiliki data tantangan"
  },
  TipsType_10052_Desc = {
    Text = "Tidak ada topik yang sesuai untuk Domain ini"
  },
  TipsType_10053_Desc = {
    Text = "Kredit tidak mencukupi, tidak dapat mengklaim hadiah."
  },
  TipsType_10054_Desc = {
    Text = "Hadiah kredit belum mencapai persyaratan untuk diklaim."
  },
  TipsType_10055_Desc = {
    Text = "Tugas belum ditemukan"
  },
  TipsType_10056_Desc = {
    Text = "Tugas sub-pelajaran telah selesai."
  },
  TipsType_10057_Desc = {
    Text = "Sub-tugas dalam tugas utama belum selesai"
  },
  TipsType_10058_Desc = {
    Text = "NPC telah diaktifkan"
  },
  TipsType_10059_Desc = {
    Text = "Data NPC salah"
  },
  TipsType_10060_Desc = {
    Text = "NPC tidak tersedia"
  },
  TipsType_10061_Desc = {
    Text = "Tidak ditemukan di Domain"
  },
  TipsType_10062_Desc = {
    Text = "Data Resonansi tidak ditemukan"
  },
  TipsType_10063_Desc = {
    Text = "Resonansi telah mencapai level maksimum"
  },
  TipsType_10064_Desc = {
    Text = "Data terkait level Resonansi tidak ditemukan"
  },
  TipsType_10065_Desc = {
    Text = "Tidak ada jumlah reset"
  },
  TipsType_10066_Desc = {
    Text = "Kondisi untuk mengaktifkan Resonansi belum terpenuhi"
  },
  TipsType_10067_Desc = {
    Text = "Partikel Resonansi tidak mencukupi"
  },
  TipsType_10068_Desc = {
    Text = "Mencerahkan telah selesai, tidak dapat melakukan Mencerahkan lagi."
  },
  TipsType_10069_Desc = {
    Text = "Bahan yang diperlukan untuk Mencerahkan tidak mencukupi"
  },
  TipsType_10070_Desc = {
    Text = "Bahan yang diperlukan untuk peningkatan Bangun tidak mencukupi"
  },
  TipsType_10071_Desc = {
    Text = "Tidak cukup kupon emas untuk peningkatan Pembangun"
  },
  TipsType_10072_Desc = {
    Text = "Tidak cukup kupon emas untuk peningkatan Pembangun"
  },
  TipsType_10073_Desc = {
    Text = "Tanpa keterampilan Pembangun"
  },
  TipsType_10074_Desc = {
    Text = "Keterampilan pembangun belum dibuka"
  },
  TipsType_10075_Desc = {
    Text = "\"Perak\" yang dibutuhkan untuk Awaken tidak mencukupi"
  },
  TipsType_10076_Desc = {
    Text = "Jumlah item tidak mencukupi"
  },
  TipsType_10077_Desc = {
    Text = "Jumlah pembelian hari ini telah mencapai batas maksimum."
  },
  TipsType_10078_Desc = {
    Text = "Item tidak dapat digunakan"
  },
  TipsType_10079_Desc = {
    Text = "Jumlah penggunaan item tidak valid"
  },
  TipsType_10080_Desc = {
    Text = "Keterampilan telah mencapai level maksimum"
  },
  TipsType_10081_Desc = {
    Text = "Bahan tidak mencukupi, peningkatan tidak dapat dilakukan."
  },
  TipsType_10082_Desc = {
    Text = "Kekurangan mata uang, peningkatan tidak dapat dilakukan."
  },
  TipsType_10083_Desc = {
    Text = "Tingkat Tautan Pembangun telah mencapai level tertinggi"
  },
  TipsType_10084_Desc = {
    Text = "Pembangun tersebut kekurangan Roh yang berasal dari sumber yang sama."
  },
  TipsType_10085_Desc = {
    Text = "Rute peningkatan tidak memiliki konfigurasi ID karakter."
  },
  TipsType_10086_Desc = {
    Text = "Informasi kartu eksklusif yang dimaksud tidak ditemukan"
  },
  TipsType_10087_Desc = {
    Text = "Kartu eksklusif yang ditentukan belum terbuka"
  },
  TipsType_10088_Desc = {
    Text = "UUID kartu eksklusif tidak ditemukan"
  },
  TipsType_10089_Desc = {
    Text = "Hadiah bab belum mencapai jumlah poin yang ditentukan."
  },
  TipsType_10090_Desc = {
    Text = "Hadiah bab telah diklaim"
  },
  TipsType_10091_Desc = {
    Text = "Jalur cerita yang dipilih belum dibuka"
  },
  TipsType_10092_Desc = {
    Text = "Salinan yang dipilih belum dibuka kuncinya"
  },
  TipsType_10093_Desc = {
    Text = "Dungeon area belum terbuka"
  },
  TipsType_10094_Desc = {
    Text = "Garis cerita belum terbuka untuk penyapuan."
  },
  TipsType_10095_Desc = {
    Text = "Tidak ditemukan alur cerita untuk tantangan instance dungeon"
  },
  TipsType_10096_Desc = {
    Text = "Misi alur cerita untuk tantangan dungeon tidak ditemukan"
  },
  TipsType_10097_Desc = {
    Text = "Tantangan misi telah selesai, hadiah tidak dapat diambil lagi."
  },
  TipsType_10098_Desc = {
    Text = "Tantangan misi belum selesai, hadiah tidak dapat diambil."
  },
  TipsType_10099_Desc = {
    Text = "Bangunan tidak tersedia"
  },
  TipsType_10100_Desc = {
    Text = "Bangunan telah mencapai level maksimum."
  },
  TipsType_10101_Desc = {
    Text = "Kondisi untuk meningkatkan/membangun bangunan tidak mencukupi"
  },
  TipsType_10102_Desc = {
    Text = "Bangunan sudah ada dan tidak dapat dibangun lagi."
  },
  TipsType_10103_Desc = {
    Text = "Item yang diperlukan untuk peningkatan/pembangunan tidak cukup"
  },
  TipsType_10104_Desc = {
    Text = "Posisi sudah ada Pembangun, tidak dapat dimasuki."
  },
  TipsType_10105_Desc = {
    Text = "Item yang diperlukan untuk sintesis tidak mencukupi"
  },
  TipsType_10106_Desc = {
    Text = "Tidak cukup mata uang untuk mensintesis item"
  },
  TipsType_10107_Desc = {
    Text = "Item sintesis belum terkunci"
  },
  TipsType_10108_Desc = {
    Text = "Gagal melakukan tautan ke server, silakan periksa jaringan Anda dan coba lagi."
  },
  TipsType_10109_Desc = {
    Text = "Fungsi di area perkemahan telah dipilih dan tidak dapat dipilih kembali."
  },
  TipsType_10110_Desc = {
    Text = "Fungsi perkemahan sudah tidak memiliki jumlah penggunaan tersisa."
  },
  TipsType_10111_Desc = {
    Text = "Kartu eksklusif tidak dapat di-upgrade, sehingga tidak bisa beralih."
  },
  TipsType_10112_Desc = {
    Text = "Kartu eksklusif tidak mengalami perubahan, sehingga tidak dapat beralih."
  },
  TipsType_10113_Desc = {
    Text = "Gagal mengganti kartu eksklusif"
  },
  TipsType_10114_Desc = {
    Text = "Mendapatkan Pembangun{s1}"
  },
  TipsType_10115_Desc = {
    Text = "Mendapatkan {s1} lagi, telah diubah menjadi {s2}{s3}"
  },
  TipsType_10116_Desc = {
    Text = "{s1}Benda melebihi batas maksimum, dan telah diubah menjadi {s2}{s3}"
  },
  TipsType_10117_Desc = {
    Text = "Log berhasil diunggah"
  },
  TipsType_10118_Desc = {
    Text = "Instruksi tidak sesuai, sedang menunggu instruksi {s1}, namun yang dimasukkan adalah {s2}"
  },
  TipsType_10119_Desc = {
    Text = "Kehilangan kartu: {s1}; uid: {s2}"
  },
  TipsType_10120_Desc = {
    Text = "Tidak bisa dilepaskan"
  },
  TipsType_10121_Desc = {
    Text = "Tidak ada keterampilan ini"
  },
  TipsType_10122_Desc = {
    Text = "Keterampilan masih dalam waktu jeda"
  },
  TipsType_10123_Desc = {
    Text = "Jumlah penggunaan Keterampilan habis"
  },
  TipsType_10124_Desc = {
    Text = "Periksa apakah urutan peningkatan bangunan Tid {s1} terkait dengan siklus bangunan."
  },
  TipsType_10125_Desc = {
    Text = "Periksa apakah bangunan Tid {s1} tidak memiliki konfigurasi terkait."
  },
  TipsType_10126_Desc = {
    Text = "Bangunan Tid {s1} seharusnya memiliki level sebenarnya {s2}, yang dikonfigurasi adalah {s3}"
  },
  TipsType_10127_Desc = {
    Text = "Konfigurasi jenis bangunan tidak ditemukan"
  },
  TipsType_10128_Desc = {
    Text = "Konfigurasi bangunan tidak ditemukan, atau tipe bangunan tidak tersedia."
  },
  TipsType_10129_Desc = {
    Text = "Garis cerita untuk misi ini sementara belum dibuka."
  },
  TipsType_10130_Desc = {
    Text = "Penghapusan berhasil"
  },
  TipsType_10131_Desc = {
    Text = "Berhasil menambahkan \"Menophin\" × {s1}"
  },
  TipsType_10132_Desc = {
    Text = "Perbaikan telah selesai"
  },
  TipsType_10133_Desc = {
    Text = "GM menambahkan item berdasarkan nama item [ \"..arg1..\" ] tetapi tidak ditemukan item yang sesuai."
  },
  TipsType_10134_Desc = {
    Text = "Acara [ \"..arg1..\" ] tidak tersedia"
  },
  TipsType_10135_Desc = {
    Text = "Saat ini: Tekan {s1}"
  },
  TipsType_10136_Desc = {
    Text = "Peningkatan Keterampilan Berhasil"
  },
  TipsType_10137_Desc = {
    Text = "Pembuatan berhasil"
  },
  TipsType_10138_Desc = {
    Text = "Mengubah waktu server berhasil"
  },
  TipsType_10139_Desc = {
    Text = "Gagal mengubah waktu server"
  },
  TipsType_10140_Desc = {
    Text = [[
Total jumlah bangunan: 17
Versi sementara ini hanya membuka sebagian bangunan]]
  },
  TipsType_10141_Desc = {
    Text = "Persyaratan untuk membuka bangunan belum terpenuhi"
  },
  TipsType_10142_Desc = {
    Text = "Bangunan: Antarmuka konfigurasi {s1} tidak tersedia {s2}"
  },
  TipsType_10143_Desc = {
    Text = "Rumus sintesis ini belum terbuka"
  },
  TipsType_10144_Desc = {
    Text = "Bahan tidak mencukupi"
  },
  TipsType_10145_Desc = {
    Text = "Sintesis berhasil"
  },
  TipsType_10146_Desc = {
    Text = "Peningkatan berhasil"
  },
  TipsType_10147_Desc = {
    Text = "Bar monster kosong, tidak dapat memasuki pertempuran."
  },
  TipsType_10148_Desc = {
    Text = "\"Menophin\" Balas"
  },
  TipsType_10149_Desc = {
    Text = "ID karakter yang diisi berulang, tidak dapat memasuki Pertempuran"
  },
  TipsType_10150_Desc = {
    Text = "ID yang dimasukkan {s1} tidak ada, tidak dapat memasuki Pertempuran"
  },
  TipsType_10151_Desc = {
    Text = "Monster tidak memiliki gerakan yang sesuai."
  },
  TipsType_10152_Desc = {
    Text = "Sementara belum dibuka"
  },
  TipsType_10153_Desc = {
    Text = "Tidak ada kartu di tumpukan saat ini"
  },
  TipsType_10154_Desc = {
    Text = "Kartu lain sedang aktif, tidak dapat memainkan kartu."
  },
  TipsType_10155_Desc = {
    Text = "Tidak ada di kartu tangan, tidak dapat dimainkan"
  },
  TipsType_10156_Desc = {
    Text = "Kartu ini tidak dapat dimainkan"
  },
  TipsType_10157_Desc = {
    Text = "Kartu ini tidak memiliki keterampilan."
  },
  TipsType_10158_Desc = {
    Text = "Kartu ini tidak dapat dimainkan"
  },
  TipsType_10159_Desc = {
    Text = "Kekuatan hitung tidak cukup"
  },
  TipsType_10160_Desc = {
    Text = "Tidak ada Pembangun yang sesuai di arena"
  },
  TipsType_10161_Desc = {
    Text = "Jumlah tersisa tidak mencukupi"
  },
  TipsType_10162_Desc = {
    Text = "Gunakan Keterampilan Eksplorasi"
  },
  TipsType_10163_Desc = {
    Text = "Telah memilih %d kartu perintah"
  },
  TipsType_10164_Desc = {
    Text = "Batas maksimum telah tercapai"
  },
  TipsType_10165_Desc = {
    Text = "Belum terpilih"
  },
  TipsType_10166_Desc = {
    Text = "Kartu ini tidak dapat dimainkan dengan mengonsumsi Lelah Aritmetika"
  },
  TipsType_10167_Desc = {
    Text = "Total Lelah melebihi"
  },
  TipsType_10168_Desc = {
    Text = "{s1} kartu telah dipilih"
  },
  TipsType_10169_Desc = {
    Text = "Jumlah Tentakel telah mencapai batas maksimum"
  },
  TipsType_10170_Desc = {
    Text = "Penghapusan berhasil"
  },
  TipsType_10171_Desc = {
    Text = "Memperkuat berhasil"
  },
  TipsType_10172_Desc = {
    Text = "Perubahan berhasil"
  },
  TipsType_10173_Desc = {
    Text = "Disalin ke clipboard"
  },
  TipsType_10174_Desc = {
    Text = "Kartu perintah telah berhasil diperoleh"
  },
  TipsType_10175_Desc = {
    Text = "Jumlah penghapusan sudah habis"
  },
  TipsType_10176_Desc = {
    Text = "Jumlah penguatan sudah habis"
  },
  TipsType_10177_Desc = {
    Text = "Jumlah maksimal perubahan telah tercapai"
  },
  TipsType_10178_Desc = {
    Text = "Jumlah maksimum salinan telah habis"
  },
  TipsType_10179_Desc = {
    Text = "Jumlah pemilihan Kartu perintah telah mencapai batas maksimum."
  },
  TipsType_10180_Desc = {
    Text = "Kartu perintah belum dipilih"
  },
  TipsType_10181_Desc = {
    Text = "Toko untuk sementara belum dibuka, mohon ditunggu."
  },
  TipsType_10182_Desc = {
    Text = "Mohon ditunggu dengan sabar"
  },
  TipsType_10183_Desc = {
    Text = "Area tujuan terlalu jauh, tidak dapat menentukan lokasi."
  },
  TipsType_10184_Desc = {
    Text = "Melewatkan area target, tidak dapat menyelesaikan."
  },
  TipsType_10185_Desc = {
    Text = "Topik ini belum terbuka"
  },
  TipsType_10186_Desc = {
    Text = "Jelajahi Domain untuk membuka lebih banyak Penyelidikan"
  },
  TipsType_10187_Desc = {
    Text = "Selesaikan tugas pendahulu untuk membuka lebih banyak Penyelidikan"
  },
  TipsType_10188_Desc = {
    Text = "Pengumpulan berhasil, poin tugas +{s1}"
  },
  TipsType_10189_Desc = {
    Text = "Tidak ada topik yang bisa diajukan"
  },
  TipsType_10190_Desc = {
    Text = "Sementara belum dibuka, harap perhatikan waktu pembukaan instance."
  },
  TipsType_10191_Desc = {
    Text = "Belum mencapai syarat untuk membuka level"
  },
  TipsType_10192_Desc = {
    Text = "{s1} tidak boleh kosong"
  },
  TipsType_10193_Desc = {
    Text = "{s1} dan {s2} tidak boleh kosong"
  },
  TipsType_10194_Desc = {
    Text = "Jumlah pembaruan telah habis, tidak dapat melakukan pembaruan."
  },
  TipsType_10195_Desc = {
    Text = "Cara mendapatkan belum terbuka"
  },
  TipsType_10196_Desc = {
    Text = "Cara mendapatkan tidak tersedia saat ini"
  },
  TipsType_10197_Desc = {
    Text = "Silakan pilih Relik yang ingin diubah."
  },
  TipsType_10198_Desc = {
    Text = "Penghapusan berhasil"
  },
  TipsType_10199_Desc = {
    Text = "Jumlah penghapusan sudah habis"
  },
  TipsType_10200_Desc = {
    Text = "Jumlah maksimal perubahan telah tercapai"
  },
  TipsType_10201_Desc = {
    Text = "Silakan pilih Relik yang ingin dihapus."
  },
  TipsType_10202_Desc = {
    Text = "Jumlah telah mencapai batas maksimum."
  },
  TipsType_10203_Desc = {
    Text = "Silakan pilih setidaknya {s1} Relik"
  },
  TipsType_10204_Desc = {
    Text = "Jumlah pergantian yang tersisa saat ini adalah 0, tidak dapat melakukan pergantian."
  },
  TipsType_10205_Desc = {
    Text = "Semua kartu eksklusif telah mencapai batas level maksimum."
  },
  TipsType_10206_Desc = {
    Text = "Tingkat penolakan saat ini adalah 0, tidak bisa dikurangi lebih lanjut."
  },
  TipsType_10207_Desc = {
    Text = "Sementara belum dibuka"
  },
  TipsType_10208_Desc = {
    Text = "Tautan jiwa tidak cukup, tidak dapat memperkuat"
  },
  TipsType_10209_Desc = {
    Text = "Diperlukan {s1} mencapai level {s2} untuk melaksanakan Mencerahkan"
  },
  TipsType_10210_Desc = {
    Text = "\"{s1}\" tidak cukup"
  },
  TipsType_10211_Desc = {
    Text = "Belum dimiliki \"{s1}\""
  },
  TipsType_10212_Desc = {
    Text = "Batas level maksimum telah tercapai"
  },
  TipsType_10213_Desc = {
    Text = "Silakan pilih materi terlebih dahulu"
  },
  TipsType_10214_Desc = {
    Text = "\"{s1}\" tidak cukup"
  },
  TipsType_10215_Desc = {
    Text = "Peningkatan berhasil"
  },
  TipsType_10216_Desc = {
    Text = "Eliksir Gnosis telah bertambah"
  },
  TipsType_10217_Desc = {
    Text = "Batas maksimum Mencerahkan telah tercapai."
  },
  TipsType_10218_Desc = {
    Text = "Peningkatan gagal"
  },
  TipsType_10219_Desc = {
    Text = "Item tidak cukup, tidak dapat ditingkatkan."
  },
  TipsType_10220_Desc = {
    Text = "Lv. Maksimum"
  },
  TipsType_10221_Desc = {
    Text = "Peningkatan Keterampilan Berhasil"
  },
  TipsType_10222_Desc = {
    Text = "Segil hitam tidak cukup, pembelian tidak dapat dilakukan"
  },
  TipsType_10223_Desc = {
    Text = "Habis terjual"
  },
  TipsType_10224_Desc = {
    Text = "Segil hitam tidak cukup, Kartu perintah tidak dapat dihapus"
  },
  TipsType_10225_Desc = {
    Text = "Hapus {s1} kartu perintah"
  },
  TipsType_10226_Desc = {
    Text = "Arah ini belum dibuka, tidak dapat melakukan Memperkuat"
  },
  TipsType_10227_Desc = {
    Text = "Arah ini telah diperkuat hingga batas maksimum"
  },
  TipsType_10228_Desc = {
    Text = "Silakan pilih terlebih dahulu arah untuk memperkuat kartu eksklusif yang diinginkan."
  },
  TipsType_10229_Desc = {
    Text = "Tautan jiwa tidak cukup, tidak dapat memperkuat"
  },
  TipsType_10230_Desc = {
    Text = "Belum memiliki Pembangun Alam ini, sehingga tidak dapat memilih."
  },
  TipsType_10231_Desc = {
    Text = "Buat sebuah tim"
  },
  TipsType_10232_Desc = {
    Text = "Nama tim tidak boleh lebih dari {s1} karakter Tionghoa"
  },
  TipsType_10233_Desc = {
    Text = "Nama tim tidak boleh kosong"
  },
  TipsType_10234_Desc = {
    Text = "Penukaran berhasil."
  },
  TipsType_10235_Desc = {
    Text = "Tidak ada lagi \"Perak\"."
  },
  TipsType_10236_Desc = {
    Text = "Tidak bisa dikurangi lagi."
  },
  TipsType_10237_Desc = {
    Text = "{s1} belum dibuka, mohon ditunggu."
  },
  TipsType_10238_Desc = {
    Text = "Memanggil belum dibuka, harap ditunggu."
  },
  TipsType_10239_Desc = {
    Text = "Fungsi mini-map kampus untuk sementara belum diaktifkan."
  },
  TipsType_10240_Desc = {
    Text = "Tingkat Topik {s1} terbuka saat"
  },
  TipsType_10241_Desc = {
    Text = "Tidak ada kartu yang memenuhi syarat"
  },
  TipsType_10242_Desc = {
    Text = "Semua Kartu Alam telah ditingkatkan"
  },
  TipsType_10243_Desc = {
    Text = "Tidak ada Kartu Perintah yang dapat ditingkatkan"
  },
  TipsType_10244_Desc = {
    Text = "Menemukan titik teleportasi baru! Bisa pergi ke {s1}."
  },
  TipsType_10245_Desc = {
    Text = "Relik ini sudah diperoleh sebelumnya, tidak dapat diperoleh kembali."
  },
  TipsType_10246_Desc = {
    Text = "Pemulihan berhasil"
  },
  TipsType_10247_Desc = {
    Text = "Penghapusan berhasil"
  },
  TipsType_10248_Desc = {
    Text = "Buka antarmuka ransel"
  },
  TipsType_10249_Desc = {
    Text = "Terdeteksi bahwa Anda terputus secara tidak normal terakhir kali, \"Menophin\" dan perlengkapan yang seharusnya didapat telah dikembalikan, silakan buka tas untuk melihat"
  },
  TipsType_10250_Desc = {
    Text = "Versi AVG hanya menyediakan beberapa bangunan. Total jumlah bangunan di sini adalah 17."
  },
  TipsType_10251_Desc = {
    Text = "Versi AVG hanya menyediakan beberapa bangunan. Total jumlah bangunan di sini adalah 17."
  },
  TipsType_10252_Desc = {
    Text = "Versi AVG hanya menyediakan beberapa bangunan. Total jumlah bangunan di sini adalah 17."
  },
  TipsType_10253_Desc = {
    Text = "Versi AVG hanya menyediakan beberapa bangunan. Total jumlah bangunan di sini adalah 17."
  },
  TipsType_10254_Desc = {
    Text = "Versi AVG hanya menyediakan beberapa bangunan. Total jumlah bangunan di sini adalah 17."
  },
  TipsType_10255_Desc = {
    Text = "Versi AVG hanya menyediakan beberapa bangunan. Total jumlah bangunan di sini adalah 17."
  },
  TipsType_10256_Desc = {
    Text = "Versi AVG hanya menyediakan beberapa bangunan. Total jumlah bangunan di sini adalah 17."
  },
  TipsType_10257_Desc = {
    Text = "Versi AVG hanya menyediakan beberapa bangunan. Total jumlah bangunan di sini adalah 17."
  },
  TipsType_10258_Desc = {
    Text = "Versi AVG hanya menyediakan beberapa bangunan. Total jumlah bangunan di sini adalah 17."
  },
  TipsType_10259_Desc = {
    Text = "Versi AVG hanya menyediakan beberapa bangunan. Total jumlah bangunan di sini adalah 17."
  },
  TipsType_10260_Desc = {
    Text = "Versi AVG hanya menyediakan beberapa bangunan. Total jumlah bangunan di sini adalah 17."
  },
  TipsType_10261_Desc = {
    Text = "Versi AVG hanya menyediakan beberapa bangunan. Total jumlah bangunan di sini adalah 17."
  },
  TipsType_10262_Desc = {
    Text = "Versi AVG hanya menyediakan beberapa bangunan. Total jumlah bangunan di sini adalah 17."
  },
  TipsType_10263_Desc = {
    Text = "Versi AVG hanya menyediakan beberapa bangunan. Total jumlah bangunan di sini adalah 17."
  },
  TipsType_10264_Desc = {
    Text = "Versi AVG hanya menyediakan beberapa bangunan. Total jumlah bangunan di sini adalah 17."
  },
  TipsType_10265_Desc = {
    Text = "Versi AVG hanya menyediakan beberapa bangunan. Total jumlah bangunan di sini adalah 17."
  },
  TipsType_10266_Desc = {
    Text = "Versi AVG hanya menyediakan beberapa bangunan. Total jumlah bangunan di sini adalah 17."
  },
  TipsType_10267_Desc = {
    Text = "Tidak memenuhi persyaratan penggunaan"
  },
  TipsType_10268_Desc = {
    Text = "Penyelidikan Tingkat 2 Membuka Penyelidikan Cepat"
  },
  TipsType_10269_Desc = {
    Text = "Tautan terputus"
  },
  TipsType_10270_Desc = {
    Text = "Tautan server terputus, sebentar lagi akan kembali ke halaman login."
  },
  TipsType_10271_Desc = {Text = "Konfirmasi"},
  TipsType_10272_Desc = {
    Text = "Server belum dibuka, silakan coba lagi nanti."
  },
  TipsType_10273_Desc = {
    Text = "Operasi berhasil"
  },
  TipsType_10274_Desc = {
    Text = "Domain tidak ditemukan"
  },
  TipsType_10275_Desc = {
    Text = "Acara Domain telah selesai"
  },
  TipsType_10276_Desc = {
    Text = "Konfigurasi jenis Acara Domain salah"
  },
  TipsType_10277_Desc = {
    Text = "Acara Domain tidak tersedia"
  },
  TipsType_10278_Desc = {
    Text = "Segil hitam tidak cukup, pembelian tidak dapat dilakukan"
  },
  TipsType_10279_Desc = {
    Text = "Kartu ini tidak dapat diperkuat"
  },
  TipsType_10280_Desc = {
    Text = "Kartu ini telah mencapai batas maksimum penguatan"
  },
  TipsType_10281_Desc = {
    Text = "Pedagang tidak menjual item ini"
  },
  TipsType_10282_Desc = {
    Text = "Tidak ada hadiah tersebut"
  },
  TipsType_10283_Desc = {
    Text = "Hadiah sudah diklaim"
  },
  TipsType_10284_Desc = {
    Text = "Kesalahan tabel konfigurasi"
  },
  TipsType_10285_Desc = {
    Text = "Data acara salah"
  },
  TipsType_10286_Desc = {
    Text = "Barang telah dibeli"
  },
  TipsType_10287_Desc = {
    Text = "Data unit pelajaran tidak ditemukan"
  },
  TipsType_10288_Desc = {
    Text = "Unit telah dikirimkan, tidak perlu mengirimkan ulang."
  },
  TipsType_10289_Desc = {
    Text = "Tugas-tugas di bawah unit belum sepenuhnya selesai, sehingga tidak dapat diserahkan."
  },
  TipsType_10290_Desc = {
    Text = "Tidak ada modul dalam tugas."
  },
  TipsType_10291_Desc = {
    Text = "Tidak ada data tugas untuk level ini"
  },
  TipsType_10292_Desc = {
    Text = "Data yang dikirim oleh klien salah"
  },
  TipsType_10293_Desc = {
    Text = "Layanan belum diaktifkan"
  },
  TipsType_10294_Desc = {
    Text = "Data karakter bermasalah"
  },
  TipsType_10295_Desc = {
    Text = "Tidak ada karakter, perlu dibuat."
  },
  TipsType_10296_Desc = {
    Text = "Karakter sudah ada, tidak perlu dibuat ulang."
  },
  TipsType_10297_Desc = {
    Text = "Nama karakter terduplikasi"
  },
  TipsType_10298_Desc = {
    Text = "Kesalahan Domain"
  },
  TipsType_10299_Desc = {
    Text = "Garis cerita ini belum terbuka, jadi tidak bisa masuk."
  },
  TipsType_10300_Desc = {
    Text = "Di sini Anda dapat melihat efek medan serta informasi monster."
  },
  TipsType_10301_Desc = {
    Text = "{s1} mencapai {s2} untuk membuka {s3}"
  },
  TipsType_10302_Desc = {
    Text = "{s1} mencapai {s2} untuk membuka {s3}"
  },
  TipsType_10303_Desc = {
    Text = "Persyaratan untuk membuka bangunan belum terpenuhi"
  },
  TipsType_10304_Desc = {
    Text = "Persyaratan untuk peningkatan bangunan belum terpenuhi"
  },
  TipsType_10305_Desc = {
    Text = "Bahan peningkatan bangunan tidak mencukupi"
  },
  TipsType_10306_Desc = {
    Text = "Ada hadiah misi yang dapat diklaim."
  },
  TipsType_10307_Desc = {
    Text = "（Hidup akan menurun <Negative:10%%>）"
  },
  TipsType_10308_Desc = {
    Text = "Pada akhir setiap ronde, dapatkan nilai <BuffTipBlock:Perisai> yang setara dengan jumlah lapisan Pelindung saat ini. Setiap kali menerima kerusakan, Pelindung berkurang sebanyak <BuffTip:1> lapisan."
  },
  TipsType_10309_Desc = {
    Text = "Perlindungan Berlapis"
  },
  TipsType_10310_Desc = {
    Text = "Stamina di bawah ambang peringatan, risiko penyelidikan meningkat."
  },
  TipsType_10311_Desc = {
    Text = "Stamina berada di bawah nilai peringatan, risiko Penyelidikan sangat tinggi, apakah Anda memilih untuk masuk secara paksa?"
  },
  TipsType_10312_Desc = {
    Text = "Stamina saat ini terlalu rendah, tidak dapat memasuki Domain."
  },
  TipsType_10313_Desc = {
    Text = "Silakan pilih kartu eksklusif dengan level yang sama untuk melakukan pergantian."
  },
  TipsType_10314_Desc = {
    Text = "Pembangun membuka Pencerahan tingkat 2 setelah membuka arah ini"
  },
  TipsType_10315_Desc = {
    Text = "Pembangun membuka Pencerahan tingkat 3 setelah membuka arah ini"
  },
  TipsType_10316_Desc = {Text = "Saat ini"},
  TipsType_10317_Desc = {
    Text = "Semua Pembangun belum membuka Keterampilan, sehingga tidak dapat diisi daya."
  },
  TipsType_10318_Desc = {
    Text = "Energi semua keterampilan Pembangun telah penuh"
  },
  TipsType_10319_Desc = {
    Text = "Telah digunakan"
  },
  TipsType_10320_Desc = {
    Text = "Segil hitam tidak mencukupi"
  },
  TipsType_10321_Desc = {
    Text = "Segil hitam tidak mencukupi"
  },
  TipsType_10322_Desc = {
    Text = "Segil hitam tidak mencukupi"
  },
  TipsType_10323_Desc = {
    Text = "Tidak dapat memperoleh kembali Relik yang sudah dimiliki."
  },
  TipsType_10324_Desc = {
    Text = "Jumlah refresh tidak mencukupi"
  },
  TipsType_10325_Desc = {
    Text = "Akan menyebabkan {s1} poin kerusakan pada tim kita."
  },
  TipsType_10326_Desc = {Text = "Serangan"},
  TipsType_10327_Desc = {
    Text = "Di sini akan ditampilkan pratinjau mini-map untuk level, pemain dapat melakukan persiapan strategi terlebih dahulu."
  },
  TipsType_10328_Desc = {
    Text = "Kamu menghabiskan 10 menit untuk menyelesaikan salah satu level dalam dungeon harian. Di sini, kamu mendapatkan pengalaman bermain yang unik dan memperkuat pemahaman terhadap aliran melalui desain level."
  },
  TipsType_10329_Desc = {
    Text = "Batas hidup saat ini sudah di bawah 50% dari Kesehatan maksimum, harap perhatikan keselamatan."
  },
  TipsType_10330_Desc = {
    Text = "Energi yang mempertahankan keberadaan Pembangun. Menerima kerusakan akan mengurangi Hidup, dan jika Hidup mencapai nol, itu berarti Penyelidikan gagal."
  },
  TipsType_10331_Desc = {
    Text = "Manifestasi dari kekuatan serangan Pembangun. Semakin besar Kekuatan, semakin tinggi Kerusakan yang diberikan kepada musuh saat menggunakan Kartu Perintah."
  },
  TipsType_10332_Desc = {
    Text = "Manifestasi kemampuan pertahanan Pembangun. Semakin tinggi Waspada, semakin banyak Perisai yang diperoleh saat menggunakan Kartu perintah."
  },
  TipsType_10333_Desc = {
    Text = "Klik di mana saja untuk melanjutkan"
  },
  TipsType_10334_Desc = {
    Text = "Proyek penyelidikan misi belum selesai"
  },
  TipsType_10335_Desc = {
    Text = "Penyelidikan Evaluasi"
  },
  TipsType_10336_Desc = {
    Text = "Berikan 1 Kartu Eksklusif dengan Roh Ilham"
  },
  TipsType_10337_Desc = {
    Text = "Pilih arah untuk memperkuat kartu eksklusif"
  },
  TipsType_10338_Desc = {
    Text = "Peta kecil kota utama belum dibuka, silakan ditunggu."
  },
  TipsType_10339_Desc = {
    Text = "{s1}{s2} Nilai"
  },
  TipsType_10340_Desc = {
    Text = "{s1} Tingkat Kartu Dasar Ditingkatkan"
  },
  TipsType_10341_Desc = {
    Text = "<Positive:Favor:>"
  },
  TipsType_10342_Desc = {
    Text = "Manifestasi dari ikatan emosional dengan Pembangun. Semakin tinggi tingkat keakraban, semakin dalam pemahaman tentang Pembangun."
  },
  TipsType_10343_Desc = {
    Text = "<Positive:Current Level:>{s1}"
  },
  TipsType_10344_Desc = {
    Text = "<Positive:Deck Dasar:>"
  },
  TipsType_10345_Desc = {
    Text = "Deck awal yang dimiliki saat memasuki Alam."
  },
  TipsType_10346_Desc = {
    Text = "<Positive:Deck level tertinggi:>{s1} level"
  },
  TipsType_10347_Desc = {
    Text = "<Positive:Card Level:>"
  },
  TipsType_10348_Desc = {
    Text = "Ketika jumlah Pembangun yang ditentukan di Alam mencapai tingkat keakraban yang ditentukan, dek dasar dapat ditingkatkan."
  },
  TipsType_10349_Desc = {
    Text = "<Positive:Upgrade Content:>"
  },
  TipsType_10350_Desc = {
    Text = "Setiap kali naik level akan meningkatkan nilai dasar dari sebuah Kartu perintah."
  },
  TipsType_10351_Desc = {
    Text = "Kedekatan {s1} meningkat"
  },
  TipsType_10352_Desc = {
    Text = "Kesunyian Domain"
  },
  TipsType_10353_Desc = {
    Text = "Domain menolak penyusup"
  },
  TipsType_10354_Desc = {
    Text = "Tingkat penolakan Domain meningkat"
  },
  TipsType_10355_Desc = {
    Text = "Tingkat penolakan mencapai {s1}, Domain sedang mengamati kamu."
  },
  TipsType_10356_Desc = {
    Text = "Mencerahkan1"
  },
  TipsType_10357_Desc = {
    Text = "Pahami keterampilan ini"
  },
  TipsType_10358_Desc = {
    Text = "Jumlah maksimum Tentakel yang dapat ada secara bersamaan."
  },
  TipsType_10359_Desc = {
    Text = "Manifestasi dari kekuatan serangan Tentakel. Semakin kuat Kekuatan Tentakel, semakin tinggi Kerusakan yang ditimbulkan kepada musuh saat Tentakel diaktifkan."
  },
  TipsType_10360_Desc = {
    Text = "Kartu perintah belum dipilih"
  },
  TipsType_10361_Desc = {
    Text = "Perubahan berhasil"
  },
  TipsType_10362_Desc = {
    Text = "Kartu perintah belum dipilih"
  },
  TipsType_10363_Desc = {
    Text = "Salinan berhasil"
  },
  TipsType_10364_Desc = {
    Text = "{s1} Kartu perintah telah dipilih"
  },
  TipsType_10365_Desc = {
    Text = "Kartu perintah belum dipilih"
  },
  TipsType_10366_Desc = {
    Text = "Kartu perintah belum dipilih"
  },
  TipsType_10367_Desc = {
    Text = "Peningkatan berhasil"
  },
  TipsType_10368_Desc = {
    Text = "Antarmuka Tas Relik sedang dalam pengembangan, harap ditunggu."
  },
  TipsType_10369_Desc = {
    Text = "Silakan pilih Relik yang ingin diubah."
  },
  TipsType_10370_Desc = {
    Text = "Pembaruan versi, silakan unduh ulang paket instalasi."
  },
  TipsType_10371_Desc = {
    Text = "Efek Tingkat Lanjut"
  },
  TipsType_10372_Desc = {
    Text = "Informasi Domain"
  },
  TipsType_10373_Desc = {
    Text = "Setiap kali menggunakan 1 kartu kerusakan, tentakel akan memberikan {s1} poin kerusakan kepada musuh acak."
  },
  TipsType_10374_Desc = {
    Text = "Saat ini tidak ada topik penelitian yang harus diselesaikan."
  },
  TipsType_10375_Desc = {
    Text = "Saat ini tidak ada topik penelitian yang diarsipkan."
  },
  TipsType_10376_Desc = {
    Text = "Penyelidikan ini belum menyelesaikan topik."
  },
  TipsType_10377_Desc = {
    Text = "Tidak dapat dikembalikan"
  },
  TipsType_10378_Desc = {
    Text = "(Berikut ini telah diarsipkan secara otomatis)"
  },
  TipsType_10379_Desc = {
    Text = "Target pelajaran telah selesai"
  },
  TipsType_10380_Desc = {
    Text = "Anda tidak memiliki item ini"
  },
  TipsType_10381_Desc = {
    Text = "Nilai indeks yang salah"
  },
  TipsType_10382_Desc = {
    Text = "Belum terkunci"
  },
  TipsType_10383_Desc = {
    Text = "Peningkatan kartu eksklusif, tanpa batasan jumlah"
  },
  TipsType_10384_Desc = {
    Text = "1 slot penyimpanan Relik telah dibuka!"
  },
  TipsType_10385_Desc = {
    Text = "Tingkat Tautan meningkat"
  },
  TipsType_10386_Desc = {
    Text = "Tidak ada informasi slot"
  },
  TipsType_10387_Desc = {
    Text = "Kekurangan mata uang"
  },
  TipsType_10388_Desc = {
    Text = "Level maksimum telah tercapai"
  },
  TipsType_10389_Desc = {
    Text = "Sedang dalam pengembangan, mohon ditunggu dengan sabar."
  },
  TipsType_10390_Desc = {
    Text = "Tidak ada slot peningkatan manual tersisa."
  },
  TipsType_10391_Desc = {
    Text = "Setelah segel dibuka di toko atau perkemahan, item dapat digunakan."
  },
  TipsType_10392_Desc = {
    Text = "Pertempuran ini mengurangi {s1} stamina."
  },
  TipsType_10393_Desc = {
    Text = "Energi Bangun telah penuh, tidak dapat ditingkatkan lebih lanjut."
  },
  TipsType_10394_Desc = {
    Text = "Energi semua Pembangun telah ditingkatkan sepenuhnya."
  },
  TipsType_10395_Desc = {
    Text = "Perlu menggunakan \"mata\" untuk membuka kunci"
  },
  TipsType_10396_Desc = {
    Text = "Orison berhasil diukir"
  },
  TipsType_10397_Desc = {
    Text = "{s1} Pembangun telah diatur, tim akan membawa karakteristik Alam {s2}."
  },
  TipsType_10398_Desc = {
    Text = "Tim akan menjadi netral dan tidak membawa karakteristik Alam apa pun."
  },
  TipsType_10399_Desc = {
    Text = "Sistem sirkulasi kecil diverifikasi saat bab empat level dibuka."
  },
  TipsType_10400_Desc = {
    Text = "Maksimal mewarisi {s1} Relik, silakan kurangi jumlah Relik yang dipilih terlebih dahulu."
  },
  TipsType_10401_Desc = {
    Text = "Relik yang tidak dicentang tidak dapat diwarisi."
  },
  TipsType_10405_Desc = {
    Text = "Mendapatkan {s1}"
  },
  TipsType_10406_Desc = {
    Text = "Pembangun yang digunakan telah mencapai batas maksimum."
  },
  TipsType_10407_Desc = {
    Text = "Menara Emas ini tidak dapat dihadapi-"
  },
  TipsType_10408_Desc = {
    Text = "Menara Emas ini belum terbuka - Silakan selesaikan salinan Penyelidikan yang ditentukan"
  },
  TipsType_10409_Desc = {
    Text = "Silakan pilih Pembangun yang akan bertanding"
  },
  TipsType_10410_Desc = {
    Text = "Pembangun sedang berusaha menyelesaikan Tugas, datang lagi nanti untuk mengambilnya."
  },
  TipsType_10411_Desc = {
    Text = "{s1} Mawar emas telah diterima"
  },
  TipsType_10412_Desc = {
    Text = "Imbalan waktu memerlukan akumulasi seiring berjalannya waktu."
  },
  TipsType_10413_Desc = {
    Text = "\"Perak\" tidak mencukupi"
  },
  TipsType_10414_Desc = {
    Text = "Tidak ada kesempatan untuk menantang"
  },
  TipsType_10415_Desc = {
    Text = "Tantangan sedang dalam pendinginan"
  },
  TipsType_10416_Desc = {
    Text = "Tidak ada lawan untuk ditantang"
  },
  TipsType_10417_Desc = {
    Text = "Silakan pilih Pembangun yang akan diturunkan"
  },
  TipsType_10418_Desc = {
    Text = "Eliksir Gnosis tidak cukup, tidak dapat melanjutkan peningkatan level."
  },
  TipsType_10419_Desc = {
    Text = "Level saat ini telah mencapai batas maksimal."
  },
  TipsType_10420_Desc = {
    Text = "Pembangun belum terkunci"
  },
  TipsType_10421_Desc = {
    Text = "Pembatalan favorit berhasil"
  },
  TipsType_10422_Desc = {
    Text = "Jumlah pembelian untuk tantangan alur cerita tidak mencukupi."
  },
  TipsType_10423_Desc = {
    Text = "Garis cerita tidak memiliki cukup bintang untuk melakukan penyapuan."
  },
  TipsType_10424_Desc = {
    Text = "Kesalahan penyesuaian tim Alam dalam Penyelidikan"
  },
  TipsType_10425_Desc = {
    Text = "\"Perak\" tidak mencukupi"
  },
  TipsType_10426_Desc = {
    Text = "Jumlah pembelian voucher hari ini telah mencapai batas maksimum."
  },
  TipsType_10427_Desc = {
    Text = "Setelah berhasil melewati Alam Rahasia dengan tiga bintang, fitur akan terbuka."
  },
  TipsType_10428_Desc = {
    Text = "Berhasil mendapatkan {s1} sertifikat"
  },
  TipsType_10429_Desc = {
    Text = "Berhasil mendapatkan {s1} kali tantangan"
  },
  TipsType_10430_Desc = {
    Text = "Selesaikan Penyelidikan 4-6 untuk membuka"
  },
  TipsType_10431_Desc = {
    Text = "Kredensial tidak mencukupi"
  },
  TipsType_10432_Desc = {
    Text = "Jumlah pembelian sertifikat tidak mencukupi"
  },
  TipsType_10433_Desc = {
    Text = "Level Mencerahkan telah mencapai batas maksimal."
  },
  TipsType_10434_Desc = {
    Text = "\"{s1}\" tidak cukup"
  },
  TipsType_10435_Desc = {
    Text = "Barang ini tidak dijual."
  },
  TipsType_10436_Desc = {
    Text = "Tidak ada toko tipe ini"
  },
  TipsType_10437_Desc = {
    Text = "Barang yang dijual sudah habis stoknya."
  },
  TipsType_10438_Desc = {
    Text = "Tidak ada data toko"
  },
  TipsType_10439_Desc = {
    Text = "Tidak ada batas pembaruan"
  },
  TipsType_10440_Desc = {
    Text = "Jumlah pembelian \"Menofin\" hari ini telah mencapai batas maksimum."
  },
  TipsType_10441_Desc = {
    Text = "Fragmen Pembangun tidak cukup"
  },
  TipsType_10442_Desc = {
    Text = "Titik Mencerahkan telah diaktifkan"
  },
  TipsType_10443_Desc = {
    Text = "Titik Mencerahkan Awal belum diaktifkan"
  },
  TipsType_10444_Desc = {
    Text = "Berhasil membeli \"Menofin\" × {s1}"
  },
  TipsType_10445_Desc = {
    Text = "\"Menofin\" telah mencapai batas maksimum."
  },
  TipsType_10446_Desc = {
    Text = "Selesaikan [Penyelidikan 1-12] untuk membuka"
  },
  TipsType_10447_Desc = {
    Text = "Selesaikan Bab Pendahuluan untuk Membuka Kunci"
  },
  TipsType_10448_Desc = {
    Text = "Selesaikan Bab Pendahuluan untuk Membuka Kunci"
  },
  TipsType_10449_Desc = {
    Text = "Selesaikan Penyelidikan 2-4 untuk membuka"
  },
  TipsType_10450_Desc = {
    Text = "Level keterampilan ini telah mencapai batas maksimum."
  },
  TipsType_10451_Desc = {
    Text = "Tingkat Pembangun untuk Mendidik tidak cukup"
  },
  TipsType_10452_Desc = {
    Text = "Bahan peningkatan Keterampilan tidak cukup"
  },
  TipsType_10453_Desc = {
    Text = "Selesaikan Penyelidikan 3-15 untuk membuka"
  },
  TipsType_10454_Desc = {
    Text = "Selesaikan Penyelidikan 3-7 untuk membuka"
  },
  TipsType_10455_Desc = {
    Text = "Peningkatan Keterampilan belum mencapai kondisi yang ditetapkan"
  },
  TipsType_10456_Desc = {
    Text = "Versi uji hanya mengizinkan satu kali operasi isi ulang untuk setiap item pembayaran."
  },
  TipsType_10457_Desc = {
    Text = "Pembangun Genesis Kedatangan sedang dalam pendinginan, lepaskan pada giliran berikutnya."
  },
  TipsType_10458_Desc = {
    Text = "Konfigurasi ini tidak tersedia di tabel konfigurasi isi ulang."
  },
  TipsType_10459_Desc = {
    Text = "Jika sudah melakukan isi ulang gratis, tidak dapat melakukan isi ulang lagi."
  },
  TipsType_10460_Desc = {
    Text = "Resonansi telah diaktifkan, tidak perlu mengaktifkannya lagi."
  },
  TipsType_10461_Desc = {
    Text = "Harga Item {s1} telah berubah, harap periksa kembali."
  },
  TipsType_10462_Desc = {
    Text = "\"Mawar Emas\" tidak cukup"
  },
  TipsType_10463_Desc = {
    Text = "\"Medali Latihan\" tidak mencukupi"
  },
  TipsType_10464_Desc = {
    Text = "Selesaikan [Penyelidikan 3-4] untuk membuka"
  },
  TipsType_10465_Desc = {
    Text = "Selesaikan [Penyelidikan 2-16] untuk membuka"
  },
  TipsType_10466_Desc = {
    Text = "Selesaikan [Penyelidikan 3-16] untuk membuka"
  },
  TipsType_10467_Desc = {
    Text = "Selesaikan Penyelidikan 4-12 untuk membuka"
  },
  TipsType_10468_Desc = {
    Text = "Selesaikan [Penyelidikan 5-12] untuk membuka"
  },
  TipsType_10469_Desc = {
    Text = "Selesaikan [Penyelidikan 6-12] untuk membuka"
  },
  TipsType_10470_Desc = {
    Text = "Selesaikan Penyelidikan 1-7 untuk membuka"
  },
  TipsType_10471_Desc = {
    Text = "Peralatan berhasil dipasang"
  },
  TipsType_10472_Desc = {
    Text = "Pelepasan berhasil"
  },
  TipsType_10473_Desc = {
    Text = "Level maksimum telah tercapai"
  },
  TipsType_10474_Desc = {
    Text = "\"Mawar Emas\" tidak cukup"
  },
  TipsType_10475_Desc = {
    Text = "Silakan pilih material"
  },
  TipsType_10476_Desc = {
    Text = "Sedang dalam keadaan terkunci untuk perlindungan, silakan nonaktifkan status terkunci terlebih dahulu."
  },
  TipsType_10477_Desc = {
    Text = "Level belum tersedia"
  },
  TipsType_10478_Desc = {
    Text = "Di luar pertempuran belum tersedia"
  },
  TipsType_10479_Desc = {
    Text = "Tumpukan kartu buang kosong"
  },
  TipsType_10480_Desc = {
    Text = "Penyesuaian pertempuran RPG sedang berlangsung, saat ini kemenangan langsung dihitung."
  },
  TipsType_10482_Desc = {
    Text = "Roda takdir telah terkunci"
  },
  TipsType_10483_Desc = {
    Text = "Roda takdir tidak ditemukan"
  },
  TipsType_10484_Desc = {
    Text = "Roda takdir telah mencapai tingkatan maksimum."
  },
  TipsType_10485_Desc = {
    Text = "Roda takdir telah dilengkapi"
  },
  TipsType_10486_Desc = {
    Text = "Roda takdir tidak sesuai"
  },
  TipsType_10487_Desc = {
    Text = "Roda takdir belum terkunci"
  },
  TipsType_10488_Desc = {
    Text = "Perjanjian yang sedang berada di \"Susunan tim\", \"Bantuan\", dan \"Rencana Perjanjian\"tidak dapat diuraikan."
  },
  TipsType_10489_Desc = {
    Text = "Roda takdir yang sedang berada dalam \"Susunan tim\"dan\"Bantuan\", tidak dapat diuraikan."
  },
  TipsType_10490_Desc = {
    Text = "Aliemus tidak cukup, tidak dapat melepaskan Muliakan."
  },
  TipsType_10491_Desc = {
    Text = "Silakan klaim paket hadiah sebelumnya terlebih dahulu."
  },
  TipsType_10492_Desc = {
    Text = "Perjanjian saat ini telah terkunci, buka kunci untuk dikonsumsi sebagai Lelah Inventaris"
  },
  TipsType_10493_Desc = {
    Text = "Roda takdir saat ini telah terkunci, buka kunci untuk dikonsumsi sebagai inventaris."
  },
  TipsType_10494_Desc = {
    Text = "Selesaikan Penyelidikan 1-7 untuk membuka"
  },
  TipsType_10495_Desc = {
    Text = "Selesaikan Penyelidikan 1-13 untuk membuka"
  },
  TipsType_10496_Desc = {
    Text = "Level Perjanjian saat ini telah mencapai batas maksimum."
  },
  TipsType_10497_Desc = {
    Text = "Toko telah direset"
  },
  TipsType_10498_Desc = {
    Text = "Penggantian berhasil"
  },
  TipsType_10499_Desc = {
    Text = "Koleksi berhasil disimpan"
  },
  TipsType_10500_Desc = {
    Text = "Tumpukan berhasil"
  },
  TipsType_10501_Desc = {
    Text = "Tantangan saat ini belum terkunci"
  },
  TipsType_10502_Desc = {
    Text = "Pembangun saat ini telah menantang level lain di {s1}, sehingga tidak dapat bertarung lagi."
  },
  TipsType_10503_Desc = {
    Text = "Jumlah Pembangun yang digunakan kurang dari 4, tantangan tidak dapat dilakukan."
  },
  TipsType_10504_Desc = {
    Text = "Selesaikan Penyelidikan 3-7 untuk membuka"
  },
  TipsType_10505_Desc = {
    Text = "Lantai 1 mencapai tiga bintang untuk membuka kunci"
  },
  TipsType_10506_Desc = {
    Text = "Lapisan 2 terbuka setelah mencapai tiga bintang"
  },
  TipsType_10507_Desc = {
    Text = "Lapisan 3 mencapai tiga bintang untuk membuka kunci"
  },
  TipsType_10508_Desc = {
    Text = "Mencapai tiga bintang di Lapisan 4 untuk membuka kunci"
  },
  TipsType_10509_Desc = {
    Text = "Mencapai tiga bintang di Lantai 5 untuk membuka kunci"
  },
  TipsType_10510_Desc = {
    Text = "Lantai 6 mencapai tiga bintang untuk membuka kunci"
  },
  TipsType_10511_Desc = {
    Text = "Mencapai tiga bintang di Lantai 7 untuk membuka kunci"
  },
  TipsType_10512_Desc = {
    Text = "Lapisan 8 mencapai tiga bintang untuk membuka kunci"
  },
  TipsType_10513_Desc = {
    Text = "Silakan pilih perjanjian yang ingin diperkuat"
  },
  TipsType_10514_Desc = {
    Text = "Sudah Diklaim"
  },
  TipsType_10515_Desc = {
    Text = "Selesaikan [Penyelidikan 2-14] untuk membuka"
  },
  TipsType_10516_Desc = {
    Text = "Selesaikan Penyelidikan 4-7 untuk membuka"
  },
  TipsType_10517_Desc = {
    Text = "Selesaikan Penyelidikan 4-7 untuk membuka"
  },
  TipsType_10518_Desc = {
    Text = "Susunan tim telah disimpan"
  },
  TipsType_10519_Desc = {
    Text = "Silakan sentuh area yang menyala untuk bergerak."
  },
  TipsType_10520_Desc = {
    Text = "Nama tim tidak boleh berisi karakter selain Tionghoa, Inggris, dan angka."
  },
  TipsType_10521_Desc = {
    Text = "Nama tim tidak boleh lebih dari 8 karakter"
  },
  TipsType_10522_Desc = {
    Text = "Jumlah Pembangun di tim kurang dari {s1}, tidak dapat melakukan Penyelidikan."
  },
  TipsType_10523_Desc = {
    Text = "Pembangun telah berpartisipasi dalam pertempuran domain lain di lapisan Alam Gelap ini."
  },
  TipsType_10524_Desc = {
    Text = "Tidak dapat memilih Pembangun dari Alam lain karena sudah ada dua Pembangun dari Alam berbeda dalam tim."
  },
  TipsType_10525_Desc = {
    Text = "Silakan pilih satu Pembangun"
  },
  TipsType_10526_Desc = {
    Text = "Tidak dapat memilih lebih banyak Pembangun"
  },
  TipsType_10527_Desc = {
    Text = "Catatan pengembangan: Dalam Terjunan Gaib, level Bangun dan level Keterampilan telah diatur ke level 1."
  },
  TipsType_10528_Desc = {
    Text = "Nama tim tidak boleh kosong"
  },
  TipsType_10529_Desc = {
    Text = "Ada Pembangun di tim yang sudah kelelahan dan tidak dapat berpartisipasi dalam pertempuran lagi."
  },
  TipsType_10530_Desc = {
    Text = "Semua lampiran di dalam email telah berhasil diklaim."
  },
  TipsType_10531_Desc = {
    Text = "Setelah menyelesaikan prolog, akan dibuka."
  },
  TipsType_10532_Desc = {
    Text = "Tas penuh, belum diambil sepenuhnya. Harap bersihkan tas untuk melanjutkan pengambilan."
  },
  TipsType_10533_Desc = {
    Text = "Tas penuh, hadiah akan dikirim ke kotak surat."
  },
  TipsType_10534_Desc = {
    Text = "Tas penuh, inventaris belum sepenuhnya diambil. Perlu membersihkan tas untuk melanjutkan pengambilan."
  },
  TipsType_10535_Desc = {
    Text = "Tidak ada lampiran surat yang bisa diklaim."
  },
  TipsType_10536_Desc = {
    Text = "Silakan tukarkan Relik terlebih dahulu"
  },
  TipsType_10537_Desc = {
    Text = "Selesaikan Penyelidikan 2-4 untuk membuka"
  },
  TipsType_10538_Desc = {
    Text = "Selesaikan [Penyelidikan 1-12] untuk membuka"
  },
  TipsType_10539_Desc = {
    Text = "Selesaikan [Penyelidikan 1-12] untuk membuka"
  },
  TipsType_10540_Desc = {
    Text = "Selesaikan [Penyelidikan 1-12] untuk membuka"
  },
  TipsType_10541_Desc = {
    Text = "Mencapai tiga bintang di Lantai 9 untuk membuka kunci"
  },
  TipsType_10542_Desc = {
    Text = "Lantai 10 mencapai tiga bintang untuk membuka kunci"
  },
  TipsType_10543_Desc = {
    Text = "Lantai 11 mencapai tiga bintang untuk membuka kunci"
  },
  TipsType_10544_Desc = {
    Text = "Lantai 12 mencapai tiga bintang untuk membuka kunci"
  },
  TipsType_10545_Desc = {
    Text = "Lantai 13 mencapai tiga bintang untuk membuka kunci"
  },
  TipsType_10546_Desc = {
    Text = "Mencapai tiga bintang di Lantai 14 untuk membuka kunci"
  },
  TipsType_10547_Desc = {
    Text = "Fitur ini akan segera dihapus."
  },
  TipsType_10548_Desc = {
    Text = "Selesaikan [Penyelidikan 1-7] untuk membuka"
  },
  TipsType_10549_Desc = {
    Text = "Pengumpulan Relik telah mencapai batas maksimum, tidak dapat melanjutkan pengumpulan."
  },
  TipsType_10550_Desc = {
    Text = "{s1} telah menyelesaikan Tautan, sekarang kamu bisa mengarahkannya untuk bertarung!"
  },
  TipsType_10551_Desc = {
    Text = "Level {s1} dan level Keterampilan telah melebihi level yang disediakan oleh Penguat Gnosis, tidak dapat digunakan."
  },
  TipsType_10552_Desc = {
    Text = "Level Pembangun dan level Keterampilan telah melebihi level yang disediakan oleh Penguat Gnosis, tidak dapat digunakan."
  },
  TipsType_10553_Desc = {
    Text = "Mohon ditunggu dengan sabar"
  },
  TipsType_10554_Desc = {
    Text = "Setelah berhasil melewati level sebelumnya, akan terbuka."
  },
  TipsType_10555_Desc = {
    Text = "Di Jalan Rapuh, tidak bisa kembali."
  },
  TipsType_10556_Desc = {
    Text = "Belum dibuka untuk sementara, mohon ditunggu."
  },
  TipsType_10557_Desc = {
    Text = "Relik ini sudah dimiliki, tidak dapat diperoleh kembali."
  },
  TipsType_10558_Desc = {
    Text = [[
Akan segera mendapatkan konten dari clipboard sistem dan melakukan <Positive: [tempel]>, 
 apakah kamu yakin?]]
  },
  TipsType_10558_LeftBtnDesc = {Text = "Batal"},
  TipsType_10558_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10558_Title = {
    Text = "Aktifkan fungsi tempel"
  },
  TipsType_10559_Desc = {
    Text = "Bahan Mendidik tidak cukup"
  },
  TipsType_10560_Desc = {
    Text = "Saat ini sudah dalam Negara awal"
  },
  TipsType_10561_Desc = {
    Text = "\"Mawar Emas\" tidak cukup"
  },
  TipsType_10562_Desc = {
    Text = "Belum Mendidik"
  },
  TipsType_10563_Desc = {
    Text = "Resonansi berhasil direset"
  },
  TipsType_10564_Desc = {
    Text = "Penyelidikan mencapai level {s1} untuk membuka"
  },
  TipsType_10565_Desc = {
    Text = "Aliemus yang disegel tidak dapat dilepaskan"
  },
  TipsType_1056601_Desc = {
    Text = "Komunikasi Perak abnormal, silakan periksa jaringan dan coba lagi ({s1})"
  },
  TipsType_10566_Desc = {
    Text = "Komunikasi Perak abnormal, silakan coba lagi nanti ({s1})"
  },
  TipsType_10567_Desc = {
    Text = "Gagal mendapatkan informasi server! {s1}"
  },
  TipsType_10568_Desc = {
    Text = "Silakan pilih server terlebih dahulu"
  },
  TipsType_10569_Desc = {
    Text = "Belum terkunci"
  },
  TipsType_10570_Desc = {
    Text = "Silakan masukkan nama akun"
  },
  TipsType_10571_Desc = {
    Text = "Bahan aktivasi Resonansi tidak mencukupi"
  },
  TipsType_10572_Desc = {
    Text = "Titik Resonansi Awal belum ditingkatkan"
  },
  TipsType_10573_Desc = {
    Text = "Level maksimum telah tercapai"
  },
  TipsType_10574_Desc = {
    Text = "Peningkatan berhasil"
  },
  TipsType_10575_Desc = {
    Text = "Pembangun ini tidak dapat diganti."
  },
  TipsType_10576_Desc = {
    Text = "Posisi ini tidak dapat digunakan"
  },
  TipsType_10577_Desc = {
    Text = "Jumlah Pembangun tidak mencukupi, tantangan tidak dapat dilakukan."
  },
  TipsType_10578_Desc = {
    Text = "Level berikutnya belum tersedia"
  },
  TipsType_10579_Desc = {
    Text = "Ini sudah menjadi level terakhir."
  },
  TipsType_10580_Desc = {
    Text = "Sudah mencapai batas pengalaman saat ini, tidak dapat menambahkan."
  },
  TipsType_10581_Desc = {
    Text = "Slot Roda Takdir telah penuh, tidak dapat ditambahkan."
  },
  TipsType_10582_Desc = {
    Text = "Saat ini tidak ada materi yang dapat disisipkan dengan cepat."
  },
  TipsType_10583_Desc = {
    Text = "Silakan letakkan bahan ke dalam slot Roda Takdir."
  },
  TipsType_10584_Desc = {
    Text = "Tidak ada Roda Takdir yang dapat dilengkapi."
  },
  TipsType_10585_Desc = {
    Text = "Selesaikan [Penyelidikan 2-8] untuk membuka"
  },
  TipsType_10586_Desc = {
    Text = "Selesaikan Penyelidikan 2-14 untuk membuka"
  },
  TipsType_10587_Desc = {
    Text = "Selesaikan Penyelidikan 3-16 untuk membuka"
  },
  TipsType_10588_Desc = {
    Text = "Selesaikan Penyelidikan 4-12 untuk membuka"
  },
  TipsType_10589_Desc = {
    Text = "Selesaikan [Penyelidikan 5-12] untuk membuka"
  },
  TipsType_10590_Desc = {
    Text = "Selesaikan [Penyelidikan 6-12] untuk membuka"
  },
  TipsType_10591_Desc = {
    Text = "Selesaikan Penyelidikan 2-12 untuk membuka"
  },
  TipsType_10592_Desc = {
    Text = "Pengguna ini telah dilarang masuk. Jika ada pertanyaan, silakan hubungi layanan pelanggan."
  },
  TipsType_10593_Desc = {
    Text = "Sesi login telah kedaluwarsa, silakan masuk kembali."
  },
  TipsType_10594_Desc = {
    Text = "\"Menofin\" saat ini tidak mencukupi"
  },
  TipsType_10595_Desc = {
    Text = "Apakah Anda ingin mengaktifkan \"{s1}\"?"
  },
  TipsType_10595_Title = {
    Text = "Mengaktifkan kemampuan bawaan"
  },
  TipsType_10596_Desc = {
    Text = "Belum memperoleh Pembangun ini"
  },
  TipsType_10597_Desc = {
    Text = "Tidak ada Roda takdir yang bisa diperkuat"
  },
  TipsType_10598_Desc = {
    Text = "Akun ini telah dilarang masuk hingga {s1} karena melanggar peraturan terkait. Jika ada pertanyaan, silakan hubungi layanan pelanggan."
  },
  TipsType_10599_Desc = {
    Text = "Selesaikan [Penyelidikan 2-15] untuk membuka"
  },
  TipsType_10600_Desc = {
    Text = "Telah mencapai batas level maksimum, tidak dapat melanjutkan penambahan."
  },
  TipsType_10601_Desc = {
    Text = "Setelah menyelesaikan Penyelidikan 1-7, buka catatan perkembangan Penjaga."
  },
  TipsType_10602_Desc = {
    Text = "Setelah menyelesaikan Penyelidikan 1-7, misi Penguasaan Alam akan dibuka."
  },
  TipsType_10603_Desc = {
    Text = "Belum memilih materi"
  },
  TipsType_10604_Desc = {
    Text = "Keluar dari instance secara otomatis karena tidak ada operasi untuk waktu yang lama."
  },
  TipsType_10605_Desc = {
    Text = "Kuesioner telah selesai diisi, terima kasih atas dukungan Anda!"
  },
  TipsType_10606_Desc = {
    Text = "Bahan yang diperlukan untuk aktivasi tidak mencukupi"
  },
  TipsType_10607_Desc = {
    Text = "Jumlah pengambilan hadiah minggu ini telah habis. Setelah menyelesaikan tantangan, hadiah tidak akan diberikan lagi. Apakah Anda tetap ingin melanjutkan tantangan?"
  },
  TipsType_10607_LeftBtnDesc = {Text = "Batal"},
  TipsType_10607_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10607_Title = {
    Text = "Petunjuk Tantangan"
  },
  TipsType_10608_Desc = {
    Text = "Kampus sedang dalam pemeliharaan, harap tunggu hingga perbaikan selesai."
  },
  TipsType_10609_Desc = {
    Text = "Berhasil mengundang {s1} ke asrama Anda"
  },
  TipsType_10610_Desc = {
    Text = "{s1} sudah berada di asramamu"
  },
  TipsType_10611_Desc = {
    Text = "Saat ini bukan jaringan WiFi, apakah Anda ingin melanjutkan unduhan menggunakan kuota data?"
  },
  TipsType_10611_LeftBtnDesc = {Text = "Batal"},
  TipsType_10611_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10611_Title = {
    Text = "Konfirmasi Unduhan"
  },
  TipsType_10612_Desc = {
    Text = "Semua Kartu telah di-Orison"
  },
  TipsType_10613_Desc = {
    Text = "Jaringan tidak stabil, harap tunggu"
  },
  TipsType_10614_Desc = {
    Text = "Tantangan saat ini belum dibuka"
  },
  TipsType_10615_Desc = {
    Text = "Sedang dalam pendinginan, hanya dapat digunakan di giliran berikutnya."
  },
  TipsType_10616_Desc = {
    Text = "Dalam proses pemilihan, pilihan harus diselesaikan terlebih dahulu sebelum dapat dilepaskan."
  },
  TipsType_10617_Desc = {
    Text = "Exalt saat ini tidak memenuhi kondisi pelepasan, tidak dapat dilepaskan."
  },
  TipsType_10618_Desc = {
    Text = "Level rata-rata tim saat ini {s1} lebih rendah dari level yang direkomendasikan {s2}. Penyelidikan mungkin menghadapi tantangan yang lebih besar. Apakah Anda yakin ingin melanjutkan?"
  },
  TipsType_10618_LeftBtnDesc = {
    Text = "Menuju Peningkatan"
  },
  TipsType_10618_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10618_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_10619_Desc = {
    Text = "Penyelidikan tingkat {s1} dapat digunakan setelah mencapai tingkat tersebut"
  },
  TipsType_10620_Desc = {
    Text = "Koneksi jaringan buruk, silakan periksa Tautan Steam atau coba lagi setelah me-restart Steam."
  },
  TipsType_10621_Desc = {
    Text = "Apakah Anda yakin ingin menggunakan <WeaponEffect_Num:{s1}> sebagai nama Anda?"
  },
  TipsType_10621_LeftBtnDesc = {Text = "Batal"},
  TipsType_10621_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10621_Title = {
    Text = "Konfirmasi ukiran"
  },
  TipsType_10622_Desc = {
    Text = "Ukiran sedang dalam cooldown, ukiran dapat dilakukan lagi setelah {s1} jam {s2} menit."
  },
  TipsType_10623_Desc = {
    Text = "Ukiran berhasil"
  },
  TipsType_10624_Desc = {
    Text = "Nama hanya boleh berisi karakter Tiongkok, Bahasa Inggris, dan angka."
  },
  TipsType_10625_Desc = {
    Text = "Kartu ini akan segera dibuang."
  },
  TipsType_10626_Desc = {
    Text = [[
Silakan aktifkan opsi berikut di Steam: 
[Pengaturan Steam - Dalam Game - Aktifkan Antarmuka Steam dalam Game]
dan restart game untuk membuatnya berlaku.]]
  },
  TipsType_10626_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10626_Title = {Text = "Petunjuk"},
  TipsType_10628_Desc = {
    Text = "Nama baru tidak boleh sama dengan yang sekarang."
  },
  TipsType_10629_Desc = {
    Text = "Silakan masukkan {s1}~{s2} karakter"
  },
  TipsType_10630_Desc = {
    Text = "{s1}Setelah mencapai tiga bintang, dapat melakukan ulangan"
  },
  TipsType_10631_Desc = {
    Text = "Karena akun Anda telah melanggar peraturan terkait, akun tersebut telah dipaksa keluar dari sistem."
  },
  TipsType_10631_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10631_Title = {
    Text = "Tips yang berguna"
  },
  TipsType_10632_Desc = {
    Text = "Setelah menyelesaikan tantangan, hari ini dapat diulang."
  },
  TipsType_10633_Desc = {
    Text = "Penguraian ini akan melelahkan inventaris berikut, <Blue: Setelah diuraikan tidak dapat dipulihkan>, apakah Anda yakin untuk melanjutkan penguraian?"
  },
  TipsType_10633_LeftBtnDesc = {Text = "Batal"},
  TipsType_10633_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10633_Title = {
    Text = "Konfirmasi Pemecahan"
  },
  TipsType_10634_Desc = {
    Text = "Jumlah hari tersisa untuk kartu bulanan saat ini telah melebihi {s1} hari, tidak dapat diakumulasikan."
  },
  TipsType_10635_Desc = {
    Text = "\"Sumber Cairan\" tidak mencukupi, apakah ingin pergi ke Ekstraksi Sumber Cairan?"
  },
  TipsType_10635_LeftBtnDesc = {Text = "Batal"},
  TipsType_10635_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10635_Title = {
    Text = "Perak utama tidak mencukupi"
  },
  TipsType_10636_Desc = {
    Text = "Saat ini tidak ada Roda Takdir yang tersedia"
  },
  TipsType_10637_Desc = {
    Text = "Saat ini tidak ada Perjanjian yang tersedia."
  },
  TipsType_10638_Desc = {
    Text = "Saat ini tidak ada slot Perjanjian yang dapat dilengkapi, coba lepas Perjanjian terlebih dahulu."
  },
  TipsType_10640_Desc = {
    Text = "Konfirmasi untuk melepas semua Perjanjian dari Pembangun ini?"
  },
  TipsType_10640_LeftBtnDesc = {Text = "Batal"},
  TipsType_10640_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10640_Title = {Text = "Petunjuk"},
  TipsType_10641_Desc = {
    Text = "Setelah mengganti bahasa, klien perlu di-restart agar perubahan dapat diterapkan. Apakah Anda yakin?"
  },
  TipsType_10641_LeftBtnDesc = {Text = "Batal"},
  TipsType_10641_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10641_Title = {
    Text = "Konfirmasi pergantian bahasa"
  },
  TipsType_10642_Desc = {
    Text = "Level pemain tidak mencukupi"
  },
  TipsType_10643_Desc = {
    Text = "Memasuki area yang penuh dengan pelarutan, nilai hidup berkurang {s1} poin."
  },
  TipsType_10644_Desc = {
    Text = "Geng telah dipilih."
  },
  TipsType_10645_Desc = {
    Text = "Geng belum diperoleh"
  },
  TipsType_10646_Desc = {
    Text = "\"{s1}\" tidak cukup"
  },
  TipsType_10647_Desc = {
    Text = "Penyelidikan Acara belum dimulai, {s1}"
  },
  TipsType_10648_Desc = {
    Text = "Retakan rotasi telah diperbarui"
  },
  TipsType_10649_Desc = {
    Text = "Jumlah Tugas yang dapat dikirim telah mencapai batas maksimum."
  },
  TipsType_10650_Desc = {
    Text = "Saat ini tidak ada karakter SSR yang telah dibuka"
  },
  TipsType_10651_Desc = {
    Text = "Jumlah pengumpulan harus mencapai jumlah tertentu untuk dapat digunakan."
  },
  TipsType_10652_Desc = {
    Text = "Saat ini tidak ada avatar dan ekspresi pertarungan yang belum diperoleh."
  },
  TipsType_10701_Desc = {
    Text = "Roda takdir saat ini sudah terpasang, silakan lepas terlebih dahulu dan coba lagi."
  },
  TipsType_10702_Desc = {
    Text = "Ketika slot tambahan SSR Roda takdir yang dilengkapi mencapai 12, dua Roda takdir SSR dapat dilengkapi secara bersamaan."
  },
  TipsType_10703_Desc = {
    Text = "Pembangun telah dilengkapi dengan Roda Takdir yang sama, tidak dapat dilengkapi kembali."
  },
  TipsType_10704_Desc = {
    Text = "Level Perjanjian telah mencapai batas maksimum."
  },
  TipsType_10705_Desc = {
    Text = "Jumlah bahan yang lelah telah mencapai batas maksimum"
  },
  TipsType_10706_Desc = {
    Text = "Maksimal mengunci dua atribut tambahan"
  },
  TipsType_10707_Desc = {
    Text = "Bahan transkripsi tidak mencukupi"
  },
  TipsType_10708_Desc = {
    Text = "Setelah Pembangun Mendidik {s1} tingkat, akan dibuka"
  },
  TipsType_10709_Desc = {
    Text = "\"{s1}\" tidak cukup"
  },
  TipsType_10710_Desc = {
    Text = "Habis terjual"
  },
  TipsType_10711_Desc = {
    Text = "Item ini belum dibuka"
  },
  TipsType_10712_Desc = {
    Text = "Material yang lelah sudah penuh"
  },
  TipsType_10713_Desc = {
    Text = "Posisi tumpang tindih Roda Takdir telah mencapai batas maksimum."
  },
  TipsType_10714_Desc = {
    Text = "Kondisi acara tidak terpenuhi, tidak bisa memilih."
  },
  TipsType_10715_Desc = {
    Text = "Silakan instal aplikasi terkait sebelum melakukan pembagian."
  },
  TipsType_10716_Desc = {
    Text = "Tidak dapat memilih lebih banyak Roda Takdir"
  },
  TipsType_10717_Desc = {
    Text = "Tidak dapat memilih lebih banyak Geng."
  },
  TipsType_10718_Desc = {
    Text = "Aktivasi berhasil"
  },
  TipsType_10719_Desc = {
    Text = "\"Stempel Berwajah Seribu\" tidak cukup, dapat memilih penukaran material di \"Pengaturan Penukaran\""
  },
  TipsType_10720_Desc = {
    Text = "Kecepatan telah diubah menjadi 1x"
  },
  TipsType_10721_Desc = {
    Text = "Kecepatan telah diubah menjadi 2 kali lipat"
  },
  TipsType_10722_Desc = {
    Text = "Pintu masuk kampus sedang macet, silakan coba lagi nanti."
  },
  TipsType_10723_Desc = {
    Text = "Berhasil disimpan"
  },
  TipsType_10724_Desc = {
    Text = "Gagal menyimpan, izin album tidak diaktifkan atau memori tidak mencukupi."
  },
  TipsType_10725_Desc = {
    Text = "Bahan lelah tidak cukup"
  },
  TipsType_10726_Desc = {
    Text = "Silakan pilih Kartu"
  },
  TipsType_10727_Desc = {
    Text = "Pembangun ini telah dinonaktifkan"
  },
  TipsType_10728_Desc = {
    Text = "Bentuk Genesis tidak dapat diberi Tugas, silakan pilih kembali."
  },
  TipsType_10736_Desc = {
    Text = "\"Menofin\" sudah cukup, tidak perlu ditambahkan."
  },
  TipsType_10737_Desc = {
    Text = "Versi game baru terdeteksi. Silakan mulai ulang game untuk memperbarui agar pengalaman bermain tetap normal."
  },
  TipsType_10738_Desc = {
    Text = "Saat ini tidak ada pengajaran yang perlu dibaca."
  },
  TipsType_10739_Desc = {
    Text = "{s1} sudah menyelesaikan tantangan di {s2}, tidak dapat tampil kembali"
  },
  TipsType_10740_Desc = {
    Text = "Level Penyelidikan saat ini {s1} lebih rendah dari level yang direkomendasikan {s2}, Penyelidikan mungkin akan menghadapi tantangan yang lebih besar. Apakah Anda yakin ingin melanjutkan?"
  },
  TipsType_10740_LeftBtnDesc = {Text = "Batal"},
  TipsType_10740_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10740_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_10741_Desc = {
    Text = "Level rata-rata tim saat ini {s1} dan level Penyelidikan Penjaga {s2} berada di bawah level yang direkomendasikan. Penyelidikan akan menghadapi tantangan yang sangat besar. Apakah Anda yakin ingin melanjutkan?"
  },
  TipsType_10741_LeftBtnDesc = {Text = "Batal"},
  TipsType_10741_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10741_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_10742_Desc = {
    Text = [[
Efek Roda Takdir yang sama dalam tim tidak dapat diaktifkan kembali. Saat ini, <Blue:{s1}> terdapat Roda Takdir yang belum aktif. Disarankan kepada Penjaga untuk menyesuaikan kembali perlengkapan Roda Takdir sebelum melanjutkan penyelidikan. 
Apakah tetap ingin melanjutkan penyelidikan?]]
  },
  TipsType_10742_LeftBtnDesc = {Text = "Batal"},
  TipsType_10742_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10742_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_10743_Desc = {
    Text = "Tidak ada sisa kesempatan bantuan di zona terlarang Efek-d regional"
  },
  TipsType_10744_Desc = {
    Text = "Jumlah pengikut telah mencapai batas maksimum."
  },
  TipsType_10745_Desc = {
    Text = "Tanggal ulang tahun salah, tidak dapat diatur"
  },
  TipsType_10746_Desc = {
    Text = "Disalin ke clipboard"
  },
  TipsType_10747_Desc = {
    Text = "Berhasil menyukai"
  },
  TipsType_10748_Desc = {
    Text = "{s1} sudah menjadi Pembangun Bangun"
  },
  TipsType_10749_Desc = {
    Text = "Pembangun Bantuan tidak boleh kosong"
  },
  TipsType_10750_Desc = {
    Text = "Sudah memberikan like kepada Penjaga hari ini."
  },
  TipsType_10751_Desc = {
    Text = "Maksimal dapat menampilkan 4 Pembangun."
  },
  TipsType_10752_Desc = {
    Text = "Alam tidak memenuhi persyaratan, sehingga tidak dapat dimainkan."
  },
  TipsType_10753_Desc = {
    Text = "{s1} sudah digunakan, tidak dapat dipilih kembali"
  },
  TipsType_10754_Desc = {
    Text = "{s1} telah direset"
  },
  TipsType_10755_Desc = {
    Text = "Pembukaan berhasil"
  },
  TipsType_10756_Desc = {
    Text = "Saat ini tidak ada material penumpukan yang dapat dimasukkan."
  },
  TipsType_10757_Desc = {
    Text = "{s1} sudah menyelesaikan tantangan dalam aktivitas hari ini dan tidak dapat berpartisipasi lagi."
  },
  TipsType_10758_Desc = {
    Text = "Area tim tidak memenuhi persyaratan Alam"
  },
  TipsType_10761_Desc = {
    Text = "Genesis tidak dapat bertarung bersamaan dengan bentuk biasa setelah diaktifkan oleh Bangun."
  },
  TipsType_10762_Desc = {
    Text = "Pembangun Genesis tidak dapat ditampilkan bersamaan dengan bentuk normalnya."
  },
  TipsType_10799_Desc = {
    Text = [[
Efek set 6 bagian Perjanjian saat ini <Blue:{s1}> tidak aktif karena batasan <Blue:Tim Unik>. Disarankan kepada Penjaga untuk menyesuaikan kembali Perjanjian sebelum melanjutkan penyelidikan. 
 Apakah tetap ingin melanjutkan penyelidikan?]]
  },
  TipsType_10799_LeftBtnDesc = {Text = "Batal"},
  TipsType_10799_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10799_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_10801_Desc = {
    Text = "Jumlah skema Perjanjian telah mencapai batas maksimum."
  },
  TipsType_10802_Desc = {
    Text = "{s1} sudah digunakan dalam skema Perjanjian lainnya, tidak dapat menyimpan skema ini."
  },
  TipsType_10803_Desc = {
    Text = "Nama Skema Perjanjian tidak boleh kosong"
  },
  TipsType_10804_Desc = {
    Text = "Mengandung karakter ilegal, silakan masukkan kembali."
  },
  TipsType_10805_Desc = {Text = "Tersimpan"},
  TipsType_10806_Desc = {
    Text = "Perjanjian saat ini telah diterapkan di {s1}."
  },
  TipsType_10807_Desc = {Text = "Terkunci"},
  TipsType_10808_Desc = {
    Text = "Telah dilepas"
  },
  TipsType_10809_Desc = {
    Text = "Tim saat ini telah bertempur"
  },
  TipsType_10810_Desc = {
    Text = "Skema Perjanjian tidak boleh kosong"
  },
  TipsType_10811_Desc = {
    Text = "Saat ini, skema ini sudah terpasang."
  },
  TipsType_10812_Desc = {Text = "Terkunci"},
  TipsType_10813_Desc = {
    Text = "Apakah Anda yakin ingin menghapus rencana [{s1}]?"
  },
  TipsType_10813_LeftBtnDesc = {Text = "Batal"},
  TipsType_10813_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10814_Desc = {
    Text = "Penyelidikan ini tidak sesuai dengan persyaratan tim untuk Pembangun yang digunakan."
  },
  TipsType_10815_Desc = {
    Text = "Pembangun saat ini dirancang khusus untuk kebutuhan cerita, detail tidak dapat diperiksa."
  },
  TipsType_10816_Desc = {
    Text = "\"Kredensial Proxy\" tidak mencukupi"
  },
  TipsType_10817_Desc = {
    Text = "Saat ini tidak ada catatan penyelesaian untuk Anda, silakan \"tantang\" terlebih dahulu dan lakukan setelah penyelesaian pada pukul 9:00 keesokan harinya."
  },
  TipsType_10818_Desc = {
    Text = "Agen hari ini telah selesai, tidak dapat diulangi."
  },
  TipsType_10821_Desc = {
    Text = "Saat ini tidak ada inventaris, silakan coba lagi nanti."
  },
  TipsType_10822_Desc = {
    Text = "Acara telah berakhir"
  },
  TipsType_10823_Desc = {
    Text = "Setelah benih khusus terjual habis, Anda dapat meminta toko untuk melakukan restocking."
  },
  TipsType_10824_Desc = {
    Text = "Jumlah pengisian ulang telah habis, tidak ada cadangan barang tersisa."
  },
  TipsType_10825_Desc = {
    Text = "\"{s1}\" tidak cukup"
  },
  TipsType_10826_Desc = {
    Text = "Benih khusus telah habis terjual, Anda dapat memilih untuk menanam ulang guna mereset."
  },
  TipsType_10827_Desc = {
    Text = "Benih khusus telah direset"
  },
  TipsType_10828_Desc = {
    Text = "Semua item telah berhasil dipertukarkan, silakan pilih untuk reset"
  },
  TipsType_10829_Desc = {
    Text = "Reset berhasil"
  },
  TipsType_10830_Desc = {
    Text = "Terdapat Pembangun yang tidak dapat dimainkan di tim, sehingga tidak dapat memasuki Penyelidikan."
  },
  TipsType_10831_Desc = {
    Text = "Terdapat Roda takdir yang sama dalam tim, sehingga tidak dapat memasuki zona terlarang Efek-d regional."
  },
  TipsType_10832_Desc = {
    Text = "Tim tidak dilengkapi dengan Geng, sehingga tidak dapat memasuki Penyelidikan"
  },
  TipsType_10833_Desc = {
    Text = "Terdapat Roda Takdir yang tidak dapat dilengkapi di dalam tim, sehingga tidak dapat memasuki Penyelidikan."
  },
  TipsType_10834_Desc = {
    Text = "Tidak dapat memasang Roda takdir pada Pembangun."
  },
  TipsType_10835_Desc = {
    Text = "Tidak dapat dilengkapi dengan Pembangun untuk membantu pertempuran karena Perjanjian."
  },
  TipsType_10836_Desc = {
    Text = "Tidak dapat memasang Roda takdir pada Pembangun dalam plot yang telah ditentukan."
  },
  TipsType_10837_Desc = {
    Text = "Tidak dapat melengkapi Pembangun dengan Perjanjian untuk alur cerita yang telah ditentukan."
  },
  TipsType_10838_Desc = {
    Text = "Jumlah Ekspresi dalam Skema Ekspresi telah mencapai batas maksimum."
  },
  TipsType_10839_Desc = {
    Text = "Ekspresi telah digunakan. Klik ekspresi di skema ekspresi untuk melepasnya."
  },
  TipsType_10840_Desc = {
    Text = "Ekspresi dikirim terlalu cepat!"
  },
  TipsType_10841_Desc = {
    Text = "Skema Ekspresi tidak boleh kosong"
  },
  TipsType_10842_Desc = {
    Text = "Skema Ekspresi telah diperbarui"
  },
  TipsType_10843_Desc = {
    Text = "Entri ini belum terbuka"
  },
  TipsType_10844_Desc = {
    Text = "Belum terkunci"
  },
  TipsType_10850_Desc = {
    Text = "Terdapat Geng yang tidak dapat dilengkapi di dalam tim, sehingga tidak dapat memasuki Penyelidikan."
  },
  TipsType_10901_Desc = {Text = "Kelumpuhan"},
  TipsType_10902_Desc = {Text = "Fainted"},
  TipsType_10903_Desc = {
    Text = "Belum dimiliki: {s1}"
  },
  TipsType_10904_Desc = {
    Text = "Setelah menyelesaikan mode \"Normal\" di bab ini, buka mode \"Kenangan\" untuk menonton cerita."
  },
  TipsType_10905_Desc = {
    Text = "Selesaikan \"Operasi Penyelidikan\"1-15·Normal untuk membuka \"Kenangan\"dan menonton cerita."
  },
  TipsType_10906_Desc = {
    Text = "\"Titik Awal Realitas\" tidak mencukupi"
  },
  TipsType_10907_Desc = {Text = "Terbuka"},
  TipsType_10908_Desc = {
    Text = "{s1} tingkat Mencerahkan telah penuh, melanjutkan penerimaan akan diubah menjadi <TipsHighlightText:「Fragmen Gnosis」× 2> dan <TipsHighlightText:「Sedimen Akar」× 250>, apakah Anda ingin mengonfirmasi untuk membangunkan?"
  },
  TipsType_10908_LeftBtnDesc = {Text = "Batal"},
  TipsType_10908_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10908_Title = {
    Text = "Konfirmasi Bangun"
  },
  TipsType_10909_Desc = {
    Text = "{s1} telah dibangunkan, melanjutkan penerimaan akan diubah menjadi <TipsHighlightText:「Fragmen·{s2}」× 1> dan <TipsHighlightText:「Sedimen Akar」× 50>, apakah Anda ingin mengonfirmasi untuk membangunkan?"
  },
  TipsType_10909_LeftBtnDesc = {Text = "Batal"},
  TipsType_10909_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10909_Title = {
    Text = "Konfirmasi Bangun"
  },
  TipsType_10910_Desc = {
    Text = "Apakah Anda yakin ingin Bangun<TipsHighlightText:{s1}>?"
  },
  TipsType_10910_LeftBtnDesc = {Text = "Batal"},
  TipsType_10910_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10910_Title = {
    Text = "Konfirmasi Bangun"
  },
  TipsType_10911_Desc = {
    Text = "Ruang tidak mencukupi"
  },
  TipsType_10912_Desc = {
    Text = "Ruang Ultra belum memiliki Kartu Perintah, tidak dapat digunakan."
  },
  TipsType_10913_Desc = {
    Text = "Tidak dapat digunakan kembali pada ronde ini"
  },
  TipsType_10914_Desc = {
    Text = "Apakah Anda yakin memilih<TipsHighlightText:{s1}>?"
  },
  TipsType_10914_LeftBtnDesc = {Text = "Batal"},
  TipsType_10914_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10914_Title = {
    Text = "Konfirmasi Pilihan"
  },
  TipsType_10915_Desc = {
    Text = "Membuka susunan tim harus dilakukan secara berurutan, tidak dapat melewati susunan tim yang belum dibuka."
  },
  TipsType_10916_Desc = {
    Text = "Apakah akan menggunakan <Blue: {s1} × {s2}> untuk membuka kunci?"
  },
  TipsType_10916_LeftBtnDesc = {Text = "Batal"},
  TipsType_10916_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10916_Title = {
    Text = "Konfirmasi Buka Kunci"
  },
  TipsType_10917_Desc = {
    Text = "Berhasil membuka {s1}"
  },
  TipsType_10918_Desc = {
    Text = "Berhasil membuka {s1}, semua anggota tim telah sepenuhnya terbuka."
  },
  TipsType_10919_Desc = {
    Text = "Tersedia setelah menyelesaikan [{s1}：{s2}]，apakah ingin pergi ke [{s1}]?"
  },
  TipsType_10919_LeftBtnDesc = {Text = "Batal"},
  TipsType_10919_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10919_Title = {
    Text = "Belum terkunci"
  },
  TipsType_10920_Desc = {
    Text = "Dalam acara terbatas waktu \"Pembalikan Fase\", kumpulkan \"Biji Ek Ajaib\" × {s1} untuk membuka kunci. Apakah Anda ingin pergi ke \"Pembalikan Fase\"?"
  },
  TipsType_10920_LeftBtnDesc = {Text = "Batal"},
  TipsType_10920_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_10920_Title = {
    Text = "Belum terkunci"
  },
  TipsType_10921_Desc = {
    Text = "Tidak dapat memasang dua Roda takdir dengan atribut utama yang sama secara bersamaa"
  },
  TipsType_20001_Desc = {
    Text = "Dengan konfirmasi dua kali dan tanda centang"
  },
  TipsType_20001_LeftBtnDesc = {Text = "Konfirmasi"},
  TipsType_20001_Title = {Text = "Judul"},
  TipsType_20002_Desc = {
    Text = "Tanpa konfirmasi ulang"
  },
  TipsType_20002_LeftBtnDesc = {Text = "Batal"},
  TipsType_20002_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20002_Title = {Text = "Judul"},
  TipsType_20003_Desc = {
    Text = "Akun Anda telah login dari perangkat lain."
  },
  TipsType_20003_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20003_Title = {
    Text = "Pemberitahuan Kehilangan Koneksi"
  },
  TipsType_20004_Desc = {
    Text = "Tautan dengan server terputus, silakan masuk kembali."
  },
  TipsType_20004_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20004_Title = {
    Text = "Pemberitahuan Kehilangan Koneksi"
  },
  TipsType_20005_Desc = {
    Text = "Sinkronisasi gagal, apakah ingin mencoba lagi?"
  },
  TipsType_20005_LeftBtnDesc = {Text = "Batal"},
  TipsType_20005_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20005_Title = {
    Text = "Sinkronisasi gagal"
  },
  TipsType_20006_Desc = {
    Text = "Kehilangan sinkronisasi, akan kembali ke halaman login setelah beberapa saat."
  },
  TipsType_20006_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20006_Title = {
    Text = "Sinkronisasi gagal"
  },
  TipsType_20007_Desc = {
    Text = "Kehilangan sinkronisasi, akan kembali ke halaman login setelah beberapa saat."
  },
  TipsType_20007_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20007_Title = {
    Text = "Sinkronisasi gagal"
  },
  TipsType_20008_Desc = {
    Text = "Penyelidikan ini melelahkan <Positive:{s1}>, apakah Anda yakin ingin menyelesaikannya?"
  },
  TipsType_20008_LeftBtnDesc = {Text = "Batal"},
  TipsType_20008_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20008_Title = {
    Text = "Mengakhiri penjelajahan"
  },
  TipsType_20009_Desc = {
    Text = "Menyegarkan akan memperbarui Orison dan Relik. Jumlah kali Kebangkitan Pembangun dan penjualan Kartu Perintah tidak akan diatur ulang. Apakah Anda yakin?"
  },
  TipsType_20009_LeftBtnDesc = {Text = "Batal"},
  TipsType_20009_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20009_Title = {
    Text = "Konfirmasi pembaruan"
  },
  TipsType_20010_Desc = {
    Text = "Jumlah Pembangun di Alam ini tidak mencukupi, apakah tetap melanjutkan pembentukan tim?"
  },
  TipsType_20010_LeftBtnDesc = {Text = "Batal"},
  TipsType_20010_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20011_Desc = {
    Text = "Tidak ada Pembangun yang dipilih, Susunan tim tidak akan disimpan."
  },
  TipsType_20011_LeftBtnDesc = {
    Text = "Konfirmasi untuk keluar"
  },
  TipsType_20011_RightBtnDesc = {
    Text = "Lanjutkan susunan tim"
  },
  TipsType_20012_Desc = {
    Text = "Pembangun belum dipilih"
  },
  TipsType_20012_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20013_Desc = {
    Text = "Masih ada slot kosong di tim, apakah kamu yakin ingin memulai perjalanan?"
  },
  TipsType_20013_LeftBtnDesc = {Text = "Kembali"},
  TipsType_20013_RightBtnDesc = {Text = "Berangkat"},
  TipsType_20014_Desc = {
    Text = "Jumlah tim telah mencapai batas maksimum."
  },
  TipsType_20014_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20015_Desc = {
    Text = "Apakah Anda yakin ingin menghapus tim ini?"
  },
  TipsType_20015_LeftBtnDesc = {Text = "Batal"},
  TipsType_20015_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20016_Desc = {
    Text = "{s1} akan terbuka setelah menyelesaikan"
  },
  TipsType_20016_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20017_Desc = {
    Text = "Di sini kamu bisa melihat informasi peta dan informasi monster yang sudah dikalahkan. Versi saat ini belum tersedia."
  },
  TipsType_20017_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20018_Desc = {
    Text = "Belum mencapai syarat untuk membuka level"
  },
  TipsType_20018_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20018_Title = {
    Text = "Eksplorasi Cepat"
  },
  TipsType_20019_Desc = {
    Text = "Perak tidak cukup, apakah ingin pergi ke toko untuk membeli?"
  },
  TipsType_20019_LeftBtnDesc = {Text = "Batal"},
  TipsType_20019_RightBtnDesc = {Text = "Pergi ke"},
  TipsType_20020_Desc = {
    Text = "Setelah menyelesaikan {s1}, tingkat kesulitan lanjutan ini akan terbuka."
  },
  TipsType_20020_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20021_Desc = {
    Text = "{s1}Setelah menyelesaikan mode biasa, pelatihan lanjutan akan terbuka"
  },
  TipsType_20021_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20022_Desc = {
    Text = "Perak tidak cukup, apakah ingin membeli?"
  },
  TipsType_20022_LeftBtnDesc = {Text = "Batal"},
  TipsType_20022_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20022_Title = {
    Text = "Perak tidak mencukupi"
  },
  TipsType_20023_Desc = {
    Text = "Peningkatan ini akan menghasilkan kelebihan {s1} poin pengalaman (tidak dikembalikan), dan setelah karakter mencapai batas level maksimum, tidak akan bisa mendapatkan pengalaman lagi. Apakah Anda ingin melanjutkan?"
  },
  TipsType_20023_LeftBtnDesc = {Text = "Batal"},
  TipsType_20023_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20024_Desc = {
    Text = "Tim belum lengkap, tidak dapat masuk ke dungeon."
  },
  TipsType_20024_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20026_Desc = {
    Text = "Apakah Anda yakin untuk melakukan pengisian ulang?"
  },
  TipsType_20026_LeftBtnDesc = {Text = "Batal"},
  TipsType_20026_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20027_Desc = {
    Text = "Apakah Anda yakin ingin memulihkan hidup?"
  },
  TipsType_20027_LeftBtnDesc = {Text = "Batal"},
  TipsType_20027_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20028_Desc = {
    Text = "Menutup antarmuka ini akan membatalkan pengambilan [{s1}], apakah Anda ingin membatalkannya?"
  },
  TipsType_20028_LeftBtnDesc = {Text = "Batal"},
  TipsType_20028_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20029_Desc = {
    Text = "Menutup antarmuka ini akan melewati acara ini (Relik tidak akan dihapus), apakah Anda yakin?"
  },
  TipsType_20029_LeftBtnDesc = {Text = "Batal"},
  TipsType_20029_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20030_Desc = {
    Text = "Relik yang telah dicentang tidak akan dibawa, apakah Anda ingin menyerah untuk mewarisi?"
  },
  TipsType_20030_LeftBtnDesc = {Text = "Batal"},
  TipsType_20030_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20031_Desc = {
    Text = "Apakah Anda yakin ingin keluar dari pertempuran?"
  },
  TipsType_20031_LeftBtnDesc = {Text = "Batal"},
  TipsType_20031_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20032_Desc = {
    Text = "Level saat ini belum terbuka, apakah ingin pergi menyelesaikan level Penyelidikan untuk membukanya?"
  },
  TipsType_20032_LeftBtnDesc = {Text = "Batal"},
  TipsType_20032_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20032_Title = {
    Text = "Belum terkunci"
  },
  TipsType_20033_Desc = {
    Text = "Jumlah tantangan saat ini tidak mencukupi, apakah ingin mengonsumsi 500 Perak untuk mereset?"
  },
  TipsType_20033_LeftBtnDesc = {Text = "Batal"},
  TipsType_20033_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20034_Desc = {
    Text = "Tantangan saat ini dalam pendinginan, apakah ingin menggunakan 50 Perak untuk mereset?"
  },
  TipsType_20034_LeftBtnDesc = {Text = "Batal"},
  TipsType_20034_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20035_Desc = {
    Text = "Tingkat rekomendasi adalah {s1}, tingkat rata-rata tim saat ini adalah {s2}. Penyelidikan akan menghadapi hambatan. Apakah tetap melanjutkan?"
  },
  TipsType_20035_LeftBtnDesc = {Text = "Batal"},
  TipsType_20035_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20035_Title = {
    Text = "Kekuatan tempur tidak mencukupi"
  },
  TipsType_20036_Desc = {
    Text = "Jumlah sapuan saat ini diatur menjadi {s1}, tetapi menantang dungeon hanya akan mengonsumsi {s2} Lelah untuk mendapatkan 1 hadiah. Apakah Anda yakin ingin menantang?"
  },
  TipsType_20036_LeftBtnDesc = {Text = "Batal"},
  TipsType_20036_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20036_Title = {
    Text = "Konfirmasi Tantangan"
  },
  TipsType_20037_Desc = {
    Text = "Apakah kamu yakin ingin Memperkuat dengan bahan-bahan yang termasuk bahan tingkat lanjut?"
  },
  TipsType_20037_LeftBtnDesc = {Text = "Batal"},
  TipsType_20037_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20037_Title = {
    Text = "Konfirmasi Memperkuat"
  },
  TipsType_20038_Desc = {
    Text = "Peralatan ini sedang dalam keadaan terkunci, apakah ingin membuka kuncinya?"
  },
  TipsType_20038_LeftBtnDesc = {Text = "Batal"},
  TipsType_20038_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20039_Desc = {
    Text = "Setelah dikonfirmasi, penyelidikan ini akan gagal dan Anda tidak akan memperoleh hadiah dari penyelidikan berikutnya. Apakah Anda yakin ingin mengakhiri penyelidikan?"
  },
  TipsType_20039_LeftBtnDesc = {Text = "Batal"},
  TipsType_20039_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20039_Title = {
    Text = "Keluar dari Penyelidikan"
  },
  TipsType_20040_Desc = {
    Text = "<WeaponEffect_Num:Keluar dari penyelidikan secara aktif akan mengonsumsi「Menofin」× {s1}.> Setelah konfirmasi, penyelidikan ini akan gagal, dan hadiah penyelidikan berikutnya tidak dapat diperoleh. Apakah Anda yakin untuk mengakhiri penyelidikan?"
  },
  TipsType_20040_LeftBtnDesc = {Text = "Batal"},
  TipsType_20040_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20040_Title = {
    Text = "Keluar dari Penyelidikan"
  },
  TipsType_20041_BottomDesc = {
    Text = "Izin kompresi waktu yang dimiliki saat ini: {s1}"
  },
  TipsType_20041_Desc = {
    Text = "Apakah akan mengonsumsi {s1} Izin kompresi waktu untuk mempercepat?"
  },
  TipsType_20041_LeftBtnDesc = {Text = "Batal"},
  TipsType_20041_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20041_Title = {
    Text = "Konfirmasi Percepatan"
  },
  TipsType_20042_Desc = {
    Text = "Penyesuaian pertempuran RPG sedang berlangsung, saat ini kemenangan langsung dihitung."
  },
  TipsType_20042_LeftBtnDesc = {Text = "Batal"},
  TipsType_20042_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20043_Desc = {
    Text = "Apakah Anda ingin menghabiskan {s1} Perak untuk menyegarkan misi saat ini?"
  },
  TipsType_20043_LeftBtnDesc = {Text = "Batal"},
  TipsType_20043_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20043_Title = {
    Text = "Pembaruan Tugas"
  },
  TipsType_20044_BottomDesc = {
    Text = "Lelah：{s1} izin penelitia"
  },
  TipsType_20044_Desc = {
    Text = [[
Apakah akan melakukan penelitian {s1}?
Efek penelitian: {s2}]]
  },
  TipsType_20044_LeftBtnDesc = {Text = "Batal"},
  TipsType_20044_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20044_Title = {
    Text = "Penelitian dikonfirmasi"
  },
  TipsType_20045_BottomDesc = {
    Text = "Batalkan penelitian, tidak menyimpan kemajuan yang telah diteliti"
  },
  TipsType_20045_Desc = {
    Text = "Apakah Anda ingin membatalkan penelitian {s1}? (Biaya lisensi penelitian akan dikembalikan sepenuhnya)"
  },
  TipsType_20045_LeftBtnDesc = {Text = "Batal"},
  TipsType_20045_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20045_Title = {
    Text = "Penelitian dibatalkan"
  },
  TipsType_20046_Desc = {
    Text = "Apakah akan menggunakan {s1} \"Perak\" untuk mempercepat?"
  },
  TipsType_20046_LeftBtnDesc = {Text = "Batal"},
  TipsType_20046_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20046_Title = {
    Text = "Konfirmasi Percepatan"
  },
  TipsType_20047_Desc = {
    Text = "Kekurangan {s1} <Blue:\"{s2}\">, apakah akan menggunakan<Blue:\"Perak\" × {s3}>untuk membeli?"
  },
  TipsType_20047_LeftBtnDesc = {Text = "Batal"},
  TipsType_20047_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20047_Title = {
    Text = "Konfirmasi Pembelian"
  },
  TipsType_20048_Desc = {
    Text = "Kekurangan {s1} <Blue:\"{s2}\">, apakah akan menggunakan<Blue:\"Perak\" × {s3}>untuk membeli?"
  },
  TipsType_20048_LeftBtnDesc = {Text = "Batal"},
  TipsType_20048_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20048_Title = {
    Text = "Konfirmasi Pembelian"
  },
  TipsType_20049_Desc = {
    Text = "<Blue:「{s1}」> telah dilengkapi oleh <Blue:「{s2}」>, apakah Anda yakin ingin menggantinya?"
  },
  TipsType_20049_LeftBtnDesc = {Text = "Batal"},
  TipsType_20049_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20049_Title = {Text = "Ganti Tips"},
  TipsType_20050_Desc = {
    Text = "Lelah Roda takdir telah melewati posisi tumpang tindih, apakah Anda yakin?"
  },
  TipsType_20050_LeftBtnDesc = {Text = "Batal"},
  TipsType_20050_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20050_Title = {
    Text = "Petunjuk Tumpang Tindih"
  },
  TipsType_20051_Desc = {
    Text = "Tumpukan saat ini akan melebihi batas level tumpukan Roda Takdir, dan setelah ditumpuk, sejumlah Roda Takdir yang sesuai dengan level kelebihan akan dikembalikan. Apakah Anda yakin?"
  },
  TipsType_20051_LeftBtnDesc = {Text = "Batal"},
  TipsType_20051_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20051_Title = {
    Text = "Petunjuk Tumpang Tindih"
  },
  TipsType_20052_Desc = {
    Text = "Tingkat rekomendasi adalah {s1}, tingkat rata-rata tim saat ini adalah {s2}. Penyelidikan akan menghadapi hambatan besar. Apakah tetap melanjutkan?"
  },
  TipsType_20052_LeftBtnDesc = {Text = "Batal"},
  TipsType_20052_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20052_Title = {
    Text = "Kekuatan tempur tidak mencukupi"
  },
  TipsType_20053_Desc = {
    Text = "Tingkat rekomendasi adalah {s1}, tingkat rata-rata tim saat ini adalah {s2}. Penyelidikan akan menghadapi hambatan besar. Apakah akan tetap dilanjutkan?"
  },
  TipsType_20053_LeftBtnDesc = {Text = "Batal"},
  TipsType_20053_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20053_Title = {
    Text = "Kekuatan tempur tidak mencukupi"
  },
  TipsType_20054_Desc = {
    Text = "Hadiah tantangan saat ini telah diterima sepenuhnya. Melanjutkan tantangan tidak akan memberikan hadiah tambahan. Apakah Anda yakin ingin melanjutkan?"
  },
  TipsType_20054_LeftBtnDesc = {Text = "Batal"},
  TipsType_20054_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20054_Title = {
    Text = "Konfirmasi Tantangan"
  },
  TipsType_20055_Desc = {
    Text = "Setelah direset, kemajuan Lengkap saat ini akan diatur ulang menjadi 0 bintang, dan catatan pertempuran Pembangun akan dihapus secara bersamaan. Apakah Anda yakin untuk mereset?"
  },
  TipsType_20055_LeftBtnDesc = {Text = "Batal"},
  TipsType_20055_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20055_Title = {
    Text = "Konfirmasi Pengaturan Ulang"
  },
  TipsType_20056_Desc = {
    Text = "Setelah tantangan berhasil, keempat Pembangun dalam susunan tim saat ini tidak akan dapat bertarung di level lain dari {s1}. Apakah Anda yakin ingin melanjutkan tantangan?"
  },
  TipsType_20056_LeftBtnDesc = {Text = "Batal"},
  TipsType_20056_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20056_Title = {
    Text = "Konfirmasi Tantangan"
  },
  TipsType_20057_Desc = {
    Text = "Komposisi tim bertentangan dengan rekomendasi dalam buku pedoman akademi. Apakah Anda tetap ingin melanjutkan tantangan?"
  },
  TipsType_20057_LeftBtnDesc = {Text = "Batal"},
  TipsType_20057_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20057_Title = {
    Text = "Susunan tim dikonfirmasi"
  },
  TipsType_20058_Desc = {
    Text = "Tantangan level saat ini telah berhasil diselesaikan. Jika ingin menantang kembali, kemajuan level (Lengkap) perlu diatur ulang menjadi 0 bintang. Catatan pertempuran Pembangun juga akan dihapus secara bersamaan. Apakah Anda yakin untuk mengatur ulang?"
  },
  TipsType_20058_LeftBtnDesc = {Text = "Batal"},
  TipsType_20058_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20058_Title = {
    Text = "Konfirmasi Pengaturan Ulang"
  },
  TipsType_20059_Desc = {
    Text = "Jumlah Pembangun dalam tim saat ini kurang dari empat, tidak dapat memasuki Pertempuran."
  },
  TipsType_20059_Title = {
    Text = "Susunan tim telah disimpan"
  },
  TipsType_20060_BottomDesc = {
    Text = "Setelah mengonfirmasi, tidak dapat membangunkan kembali"
  },
  TipsType_20060_Desc = {
    Text = "Apakah Anda memilih hasil bangun kali ini (Anda akan mendapatkan semua Pembangun dan Roda Takdir dari bangun kali ini)?"
  },
  TipsType_20060_LeftBtnDesc = {Text = "Batal"},
  TipsType_20060_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20060_Title = {
    Text = "Konfirmasi Pilihan"
  },
  TipsType_20061_BottomDesc = {
    Text = "Perak saat ini: {s1}"
  },
  TipsType_20061_Desc = {
    Text = [[
Apakah akan menggunakan {s1} "Perak" untuk Awaken ulang?
Awaken ulang tidak akan menyimpan hasil undian kali ini]]
  },
  TipsType_20061_LeftBtnDesc = {Text = "Batal"},
  TipsType_20061_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20061_Title = {
    Text = "Bangun kembali"
  },
  TipsType_20062_Desc = {
    Text = [[
Apakah Anda yakin ingin menghapus semua surat yang telah dibaca? 
Surat dengan lampiran yang belum diambil tidak akan dihapus.]]
  },
  TipsType_20062_LeftBtnDesc = {Text = "Batal"},
  TipsType_20062_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20062_Title = {
    Text = "Hapus yang telah dibaca"
  },
  TipsType_20063_Desc = {
    Text = "Konfirmasi penghapusan?"
  },
  TipsType_20063_LeftBtnDesc = {Text = "Batal"},
  TipsType_20063_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20063_Title = {
    Text = "Hapus surat saat ini"
  },
  TipsType_20064_Desc = {
    Text = [[
Setelah surat di dalam peti koleksi dihapus, surat tersebut tidak dapat dipulihkan lagi. 
 Apakah Anda yakin ingin menghapus surat ini?]]
  },
  TipsType_20064_LeftBtnDesc = {Text = "Batal"},
  TipsType_20064_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20064_Title = {
    Text = "Hapus surat koleksi berharga"
  },
  TipsType_20065_Desc = {
    Text = "Konfirmasi penggunaan <Blue:{s1}>, untuk mensintesis <Blue:{s2}>?"
  },
  TipsType_20065_LeftBtnDesc = {Text = "Batal"},
  TipsType_20065_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20065_Title = {
    Text = "Konfirmasi Penggabungan"
  },
  TipsType_20066_Desc = {
    Text = "Konfirmasi penguraian <Blue:{s1}, mendapatkan {s2}>?"
  },
  TipsType_20066_LeftBtnDesc = {Text = "Batal"},
  TipsType_20066_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20066_Title = {
    Text = "Konfirmasi Pemecahan"
  },
  TipsType_20067_Desc = {
    Text = "Konfirmasi penggunaan <Blue:{s1}> Perjanjian tingkat SSR, mencetak ulang <Blue:{s2}> buah <Blue:{s3}>?"
  },
  TipsType_20067_LeftBtnDesc = {Text = "Batal"},
  TipsType_20067_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20067_Title = {
    Text = "Konfirmasi Reprint"
  },
  TipsType_20068_Desc = {
    Text = [[
Semua Pembangun sepenuhnya kehilangan kemampuan pertempuran.

Penjaga satu-satunya,
bagaimana kamu akan memilih selanjutnya?]]
  },
  TipsType_20068_LeftBtnDesc = {
    Text = "Mulai ulang pertempuran"
  },
  TipsType_20068_RightBtnDesc = {
    Text = "Mundur untuk sementara"
  },
  TipsType_20068_Title = {
    Text = "Penyelidikan gagal"
  },
  TipsType_20069_Desc = {
    Text = "Aliemus Pembangun saat ini sudah penuh, apakah Anda yakin tetap memilih Pembangun ini?"
  },
  TipsType_20069_LeftBtnDesc = {Text = "Batal"},
  TipsType_20069_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20069_Title = {
    Text = "Konfirmasi Pilihan"
  },
  TipsType_20070_Desc = {
    Text = [[
Apakah Anda yakin ingin menggunakan {s1}?
Pembangun dengan level dan keterampilan yang telah ditingkatkan tidak akan mengembalikan inventaris peningkatan.]]
  },
  TipsType_20070_LeftBtnDesc = {Text = "Batal"},
  TipsType_20070_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20070_Title = {
    Text = "Konfirmasi Peningkatan"
  },
  TipsType_20071_Desc = {
    Text = "Berdasarkan batasan level Penyelidikan Penjaga, level Pembangun akan ditingkatkan ke level {s1}. Inventaris yang kurang untuk peningkatan tidak akan dikembalikan. Apakah Anda yakin ingin meningkatkan?"
  },
  TipsType_20071_LeftBtnDesc = {Text = "Batal"},
  TipsType_20071_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20071_Title = {
    Text = "Konfirmasi Peningkatan"
  },
  TipsType_20072_Desc = {
    Text = [[
Apakah Anda yakin ingin melewati semua alur cerita di bagian ini? 
Catatan: Nanti Anda dapat masuk kembali ke level ini untuk menonton alur cerita.]]
  },
  TipsType_20072_LeftBtnDesc = {Text = "Batal"},
  TipsType_20072_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20072_Title = {
    Text = "Lewati alur cerita"
  },
  TipsType_20073_Desc = {
    Text = [[
Konfirmasi pemecahan{s1}, dapatkah Anda memperoleh{s2}?
(Saat ini perjanjian telah diperkuat, pemecahan tidak mengembalikan bahan yang diperkuat)]]
  },
  TipsType_20073_LeftBtnDesc = {Text = "Batal"},
  TipsType_20073_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20073_Title = {
    Text = "Konfirmasi Pemecahan"
  },
  TipsType_20074_Desc = {
    Text = [[
Konfirmasi penguraian {s1}, dapatkan {s2}?
 (Roda takdir saat ini memiliki kelangkaan yang lebih tinggi)]]
  },
  TipsType_20074_LeftBtnDesc = {Text = "Batal"},
  TipsType_20074_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20074_Title = {
    Text = "Konfirmasi Pemecahan"
  },
  TipsType_20075_BottomDesc = {
    Text = "Lelah：{s1} izin penelitia"
  },
  TipsType_20075_Desc = {
    Text = "Apakah akan memulai penelitian {s1}?\nEfisiensi produksi: {s2} Mawar emas/ setiap 6 jam\n      ——>{s3} Mawar emas/ setiap 6 jam"
  },
  TipsType_20075_LeftBtnDesc = {Text = "Batal"},
  TipsType_20075_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20075_Title = {
    Text = "Penelitian dikonfirmasi"
  },
  TipsType_20076_BottomDesc = {
    Text = "Lelah：{s1} izin penelitia"
  },
  TipsType_20076_Desc = {
    Text = "Apakah akan memulai penelitian {s1}?\nEfisiensi produksi: {s2} Eliksir Gnosis/setiap 6 jam\n      ——>{s3} Eliksir Gnosis/setiap 6 jam"
  },
  TipsType_20076_LeftBtnDesc = {Text = "Batal"},
  TipsType_20076_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20076_Title = {
    Text = "Penelitian dikonfirmasi"
  },
  TipsType_20077_BottomDesc = {
    Text = "Lelah：{s1} izin penelitia"
  },
  TipsType_20077_Desc = {
    Text = "Apakah akan memulai penelitian {s1}?\nEfisiensi produksi: {s2} Perjanjian Rahasia / setiap 6 jam\n      ——>{s3} Perjanjian Rahasia / setiap 6 jam"
  },
  TipsType_20077_LeftBtnDesc = {Text = "Batal"},
  TipsType_20077_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20077_Title = {
    Text = "Penelitian dikonfirmasi"
  },
  TipsType_20078_Desc = {
    Text = [[
Konfirmasi untuk melewati seluruh alur cerita di bagian ini?
Catatan: Nanti Anda dapat memasuki level ini lagi untuk menonton alur cerita.]]
  },
  TipsType_20078_LeftBtnDesc = {Text = "Batal"},
  TipsType_20078_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20078_Title = {
    Text = "Lewati alur cerita"
  },
  TipsType_20079_Desc = {
    Text = [[
Kunci perak merasakan bahaya mematikan, apakah akan mengaktifkan Gnosis darurat?
(Menghidupkan kembali akan melelahkan 1 kali Gnosis darurat, Gnosis darurat diperoleh secara otomatis setiap pukul 9 setiap hari, jumlah sisa saat ini: {s1}/{s2})]]
  },
  TipsType_20079_LeftBtnDesc = {Text = "Batal"},
  TipsType_20079_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20079_Title = {
    Text = "Konfirmasi Kebangkitan"
  },
  TipsType_20080_Desc = {
    Text = [[
Kunci perak merasakan bahaya mematikan, apakah akan mengaktifkan Gnosis darurat?
(Menghidupkan kembali akan melelahkan 1 kali Gnosis darurat, Gnosis darurat diperoleh secara otomatis setiap pukul 9 setiap hari, jumlah sisa saat ini: {s1}/{s2})]]
  },
  TipsType_20080_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20080_Title = {
    Text = "Konfirmasi Kebangkitan"
  },
  TipsType_20081_Desc = {
    Text = "Inisialisasi game gagal. {s1}"
  },
  TipsType_20081_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20081_Title = {
    Text = "Pesan kesalahan masuk"
  },
  TipsType_20082_Desc = {
    Text = "Apakah akan menggunakan<Blue:\"Perak\" × {s1} >untuk membeli<Blue: {s2} >tingkat?"
  },
  TipsType_20082_LeftBtnDesc = {Text = "Batal"},
  TipsType_20082_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20082_Title = {
    Text = "Meningkatkan Level"
  },
  TipsType_20083_Desc = {
    Text = "Roda takdir {s1} yang lelah, apakah kamu yakin untuk memperkuat?"
  },
  TipsType_20083_LeftBtnDesc = {Text = "Batal"},
  TipsType_20083_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20083_Title = {
    Text = "Konfirmasi Konsumsi"
  },
  TipsType_20084_Desc = {
    Text = "Level rata-rata tim lebih rendah dari level rekomendasi tahap, atribut Pembangun yang digunakan akan melemah. Apakah tetap memilih untuk melakukan Penyelidikan?"
  },
  TipsType_20084_LeftBtnDesc = {
    Text = "Menuju Peningkatan"
  },
  TipsType_20084_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20084_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20085_Desc = {
    Text = "Konfirmasi untuk keluar dari permainan"
  },
  TipsType_20085_LeftBtnDesc = {Text = "Batal"},
  TipsType_20085_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20085_Title = {
    Text = "Keluar dari permainan"
  },
  TipsType_20086_Desc = {
    Text = "Server sedang dalam pemeliharaan"
  },
  TipsType_20086_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20086_Title = {
    Text = "Pemberitahuan Kehilangan Koneksi"
  },
  TipsType_20087_Desc = {
    Text = "Apakah Anda yakin ingin mengonsumsi<TipsHighlightText:{s1} × {s2}>, untuk membuka<TipsHighlightText:{s3}>?"
  },
  TipsType_20087_LeftBtnDesc = {Text = "Batal"},
  TipsType_20087_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20087_Title = {
    Text = "Aktifkan Konfirmasi"
  },
  TipsType_20088_Desc = {
    Text = [[
Setelah diklaim, "Menophin" akan meluap, bagian yang melebihi {s1} tidak dapat diperoleh.
Apakah ingin melanjutkan klaim?]]
  },
  TipsType_20088_LeftBtnDesc = {Text = "Batal"},
  TipsType_20088_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20088_Title = {
    Text = "Menofin meluap"
  },
  TipsType_20089_Desc = {
    Text = "Gunakan \"Rose Scrip\" × <Blue: {s1} >untuk Segarkan stok \n Sisa jumlah penyegaran: <Blue:{s2}> \n Semakin banyak penyegaran, semakin banyak \"Rose Scrip\" yang dibutuhkan"
  },
  TipsType_20089_LeftBtnDesc = {Text = "Batal"},
  TipsType_20089_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20089_Title = {
    Text = "Memuat ulang inventaris"
  },
  TipsType_20090_Desc = {
    Text = [[
Jumlah Roda Takdir telah mencapai batas maksimum. Perlu membersihkan Roda Takdir sebelum melakukan Bangun. Apakah ingin melanjutkan?

<color=#ADC0CB>*Pengaturan otomatis untuk dekomposisi Roda Takdir kelas SR/R dapat diatur di "Pengaturan"</color>]]
  },
  TipsType_20090_LeftBtnDesc = {Text = "Batal"},
  TipsType_20090_RightBtnDesc = {
    Text = "Pergi untuk membersihkan"
  },
  TipsType_20090_Title = {
    Text = "Petunjuk Pembersihan"
  },
  TipsType_20091_Desc = {
    Text = "Jumlah Perjanjian telah mencapai batas maksimum. Perlu membersihkan Perjanjian sebelum melakukan Penyelidikan. Apakah ingin melanjutkan?"
  },
  TipsType_20091_LeftBtnDesc = {Text = "Batal"},
  TipsType_20091_RightBtnDesc = {
    Text = "Pergi untuk membersihkan"
  },
  TipsType_20091_Title = {
    Text = "Petunjuk Pembersihan"
  },
  TipsType_20092_Desc = {
    Text = "Apakah Anda yakin ingin melepas semua Roda takdir dari peralatan Pembangun saat ini?"
  },
  TipsType_20092_LeftBtnDesc = {Text = "Batal"},
  TipsType_20092_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20092_Title = {
    Text = "Konfirmasi pelepasan"
  },
  TipsType_20093_Desc = {
    Text = "Perjanjian Lelah telah ditingkatkan, apakah Anda yakin?"
  },
  TipsType_20093_LeftBtnDesc = {Text = "Batal"},
  TipsType_20093_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20093_Title = {
    Text = "Konfirmasi Peningkatan"
  },
  TipsType_20094_Desc = {
    Text = "Apakah Anda yakin ingin mengganti atribut sekunder yang ada? Jika diganti, atribut yang lebih baik tidak akan disimpan."
  },
  TipsType_20094_LeftBtnDesc = {Text = "Batal"},
  TipsType_20094_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20094_Title = {
    Text = "Konfirmasi Penggantian"
  },
  TipsType_20095_Desc = {
    Text = "Di antara atribut sekunder yang saat ini ditranskripsi, terdapat atribut yang lebih baik. Jika Anda melanjutkan transkripsi, perubahan tidak akan disimpan. Apakah Anda yakin ingin melanjutkan?"
  },
  TipsType_20095_LeftBtnDesc = {Text = "Batal"},
  TipsType_20095_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20095_Title = {
    Text = "Konfirmasi Transkripsi"
  },
  TipsType_20096_Desc = {
    Text = "Setelah Perjanjian ditingkatkan, level akan melampaui batas maksimum. Setelah melampaui batas, materi transkripsi akan dikembalikan. Apakah Anda yakin?"
  },
  TipsType_20096_LeftBtnDesc = {Text = "Batal"},
  TipsType_20096_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20096_Title = {
    Text = "Konfirmasi Peningkatan"
  },
  TipsType_20097_Desc = {
    Text = "Mencerahkan Awakener ini sudah penuh\nSetelah dipilih hanya akan mendapatkan \"Fragmen Kembali Jiwa\" × 1"
  },
  TipsType_20097_LeftBtnDesc = {Text = "Batal"},
  TipsType_20097_RightBtnDesc = {Text = "Lanjutkan"},
  TipsType_20097_Title = {
    Text = "Konfirmasi Pilihan"
  },
  TipsType_20098_Desc = {
    Text = "Item ini dapat dibeli menggunakan <Blue:{s1}> kupon transaksi perak rahasia."
  },
  TipsType_20098_LeftBtnDesc = {
    Text = "Pembayaran tunai"
  },
  TipsType_20098_RightBtnDesc = {
    Text = "Pembayaran dengan kredensial"
  },
  TipsType_20098_Title = {
    Text = "Metode pemilihan penyelesaian"
  },
  TipsType_20099_Desc = {
    Text = "Apakah Anda yakin ingin keluar dari permainan?"
  },
  TipsType_20099_LeftBtnDesc = {Text = "Batal"},
  TipsType_20099_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20099_Title = {Text = "Petunjuk"},
  TipsType_20100_Desc = {
    Text = "Versi game baru terdeteksi, silakan restart game untuk memperbarui sumber daya."
  },
  TipsType_20100_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20100_Title = {
    Text = "Pemberitahuan Pembaruan"
  },
  TipsType_20101_Desc = {
    Text = "Penyelidikan telah selesai. Apakah Anda ingin melewati adegan jika melakukan penyelidikan ulang?"
  },
  TipsType_20101_LeftBtnDesc = {
    Text = "Lewati alur cerita"
  },
  TipsType_20101_RightBtnDesc = {
    Text = "Mempertahankan jalan cerita"
  },
  TipsType_20101_Title = {
    Text = "Konfirmasi cerita"
  },
  TipsType_20102_Desc = {
    Text = "Apakah Anda yakin ingin berhenti mengikuti {s1}?"
  },
  TipsType_20102_LeftBtnDesc = {Text = "Batal"},
  TipsType_20102_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20102_Title = {
    Text = "Berhenti mengikuti"
  },
  TipsType_20103_Desc = {
    Text = "Selama acara berlangsung, <WeaponEffect_Num:gratis untuk waktu terbatas> akan dibuka. Apakah Anda ingin membukanya?"
  },
  TipsType_20103_LeftBtnDesc = {Text = "Batal"},
  TipsType_20103_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20103_Title = {
    Text = "Barang Acara"
  },
  TipsType_20105_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20105_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20105_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20105_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20106_Desc = {
    Text = "Apakah akan menggunakan<Blue:\"Perak utama\" × {s1} >untuk membeli?"
  },
  TipsType_20106_LeftBtnDesc = {Text = "Batal"},
  TipsType_20106_RightBtnDesc = {Text = "Membeli"},
  TipsType_20106_Title = {
    Text = "Konfirmasi Pembelian"
  },
  TipsType_20107_Desc = {
    Text = "Apakah kamu yakin ingin memilih <Blue:{s1}>?"
  },
  TipsType_20107_LeftBtnDesc = {Text = "Batal"},
  TipsType_20107_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20107_Title = {
    Text = "Konfirmasi Pilihan"
  },
  TipsType_20108_Desc = {
    Text = [[
Penggabungan ini akan melelahkan item langka "Tuan lingkaran"
Apakah ingin melanjutkan?]]
  },
  TipsType_20108_LeftBtnDesc = {Text = "Batal"},
  TipsType_20108_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20108_Title = {
    Text = "Konfirmasi Konsumsi"
  },
  TipsType_20109_Desc = {
    Text = "Apakah Anda yakin ingin memulai ulang pertempuran ini?"
  },
  TipsType_20109_LeftBtnDesc = {Text = "Batal"},
  TipsType_20109_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20109_Title = {
    Text = "Mulai ulang pertempuran"
  },
  TipsType_20110_Desc = {
    Text = [[
Apakah kamu yakin memilih {s1} bulan {s2} hari sebagai tanggal lahir kamu? 
 Setelah dikonfirmasi, tidak dapat diubah.]]
  },
  TipsType_20110_LeftBtnDesc = {Text = "Batal"},
  TipsType_20110_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20110_Title = {
    Text = "Konfirmasi Tanggal Lahir"
  },
  TipsType_20111_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita yang terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20111_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20111_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20111_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20112_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita yang terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20112_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20112_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20112_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20113_Desc = {
    Text = "Apakah Anda ingin menandai semua konten pengajaran yang telah diperoleh sebagai sudah dibaca dan mengklaim hadiah pengajaran? (Disarankan bagi Penjaga baru untuk membaca konten pengajaran dengan seksama~)"
  },
  TipsType_20113_LeftBtnDesc = {Text = "Batal"},
  TipsType_20113_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20113_Title = {
    Text = "Baca dan konfirmasi dengan satu ketukan"
  },
  TipsType_20114_Desc = {
    Text = [[
Apakah Anda yakin memilih <WeaponEffect_Num:{s1}> untuk mengaktifkan retracing? 
 Operasi ini tidak dapat dibatalkan, harap konfirmasi dengan hati-hati.]]
  },
  TipsType_20114_LeftBtnDesc = {Text = "Batal"},
  TipsType_20114_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20114_Title = {
    Text = "Kembali ke Pilihan"
  },
  TipsType_201151_Desc = {
    Text = "Pembangun saat ini tidak memiliki Mencerahkan, tidak perlu melakukan penelusuran Mencerahkan"
  },
  TipsType_20115_Desc = {
    Text = "Pembangun saat ini belum melalui proses budidaya apa pun, sehingga tidak perlu melakukan pemulihan budidaya."
  },
  TipsType_20116_Desc = {
    Text = [[
<WeaponEffect_Num:{s1}> telah mengaktifkan retracing. 
 Apakah Anda ingin segera pergi untuk melakukan retracing?]]
  },
  TipsType_20116_LeftBtnDesc = {Text = "Batal"},
  TipsType_20116_RightBtnDesc = {Text = "Pergi ke"},
  TipsType_20116_Title = {
    Text = "Aktivasi berhasil"
  },
  TipsType_20117_Desc = {
    Text = [[
Akan mengatur ulang peningkatan, mendidik, keterampilan, bakat, dan negara penguatan Gnosis pembangunan tubuh, dan mengembalikan lelah yang sesuai.
Apakah Anda yakin ingin melakukan pengembangan kembali untuk <WeaponEffect_Num:{s1}>?]]
  },
  TipsType_20117_LeftBtnDesc = {Text = "Batal"},
  TipsType_20117_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20117_Title = {
    Text = "Development Reset"
  },
  TipsType_20118_Desc = {
    Text = [[
Level Mencerahkan Pembangun akan segera direset, dan konsumsi Mencerahkan akan dikembalikan. 
 Apakah Anda yakin untuk melakukan pemulihan Mencerahkan pada <WeaponEffect_Num:{s1}>?]]
  },
  TipsType_20118_LeftBtnDesc = {Text = "Batal"},
  TipsType_20118_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20118_Title = {
    Text = "Enlightenment Reset"
  },
  TipsType_20119_Desc = {
    Text = [[
Akan segera mereset peningkatan, Mendidik, keterampilan, Mencerahkan, bakat, dan negara penguatan Gnosis dari Pembangun, serta mengembalikan konsumsi yang sesuai, 
 dan mengembalikan Pembangun ke Kolam Hitam. 
 Apakah Anda yakin ingin melakukan pengembalian ke Kolam Hitam untuk <WeaponEffect_Num:{s1}>?]]
  },
  TipsType_20119_LeftBtnDesc = {Text = "Batal"},
  TipsType_20119_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20119_Title = {
    Text = "Genesis Return"
  },
  TipsType_20120_Desc = {
    Text = "Pembangun khusus tidak dapat dikembalikan."
  },
  TipsType_20121_Desc = {
    Text = [[
Status tumpukan Roda takdir akan segera direset, dan semua Lelah tumpukan akan dikembalikan. 
 Apakah Anda yakin untuk melakukan pemulihan tumpukan pada <WeaponEffect_Num:{s1}>?]]
  },
  TipsType_20121_LeftBtnDesc = {Text = "Batal"},
  TipsType_20121_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20121_Title = {
    Text = "Pelacakan Tumpang Tindih"
  },
  TipsType_20122_Desc = {
    Text = [[
Roda takdir akan segera diatur ulang ke negara tumpukan, mengembalikan semua lelah tumpukan, dan Roda takdir akan dikembalikan ke Kolam hitam. 
Apakah Anda yakin untuk mengembalikan <WeaponEffect_Num:{s1}> ke Kolam hitam?]]
  },
  TipsType_20122_LeftBtnDesc = {Text = "Batal"},
  TipsType_20122_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20122_Title = {
    Text = "Genesis Return"
  },
  TipsType_20123_Desc = {
    Text = "Setelah menyelesaikan tantangan, Pembangun, Roda takdir, dan Geng di dalam tim tidak dapat digunakan di zona terlarang Efek-d regional lainnya. Apakah Anda yakin?"
  },
  TipsType_20123_LeftBtnDesc = {Text = "Batal"},
  TipsType_20123_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20123_Title = {
    Text = "Konfirmasi Tantangan"
  },
  TipsType_20124_Desc = {
    Text = "Setelah direset, Pembangun, Roda takdir, dan Geng dari tim penyelidikan saat ini dapat kembali digunakan, tetapi nilai pelatihan khusus yang diperoleh dari level ini juga akan dikurangi (tidak mempengaruhi negara hadiah). Apakah Anda yakin untuk mereset?"
  },
  TipsType_20124_LeftBtnDesc = {Text = "Batal"},
  TipsType_20124_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20124_Title = {
    Text = "Konfirmasi Pengaturan Ulang"
  },
  TipsType_20125_Desc = {
    Text = "Level tumpukan Roda Takdir saat ini adalah 0, tidak perlu melakukan penelusuran balik tumpukan."
  },
  TipsType_20126_Desc = {
    Text = "Pembangun saat ini sedang dalam tugas, harap panggil kembali sebelum melakukan penelusuran ulang atau pengembalian."
  },
  TipsType_20127_Desc = {
    Text = "Roda takdir saat ini telah terkunci, harap lepaskan kunci sebelum mengembalikan."
  },
  TipsType_20128_Desc = {
    Text = [[
{s1} telah selesai, perlu direset untuk dapat menantang lagi. Apakah Anda yakin akan mereset?
 (Setelah direset, Pembangun, Roda Takdir, dan Geng dalam tim Penyelidikan dapat digunakan kembali, tetapi nilai pelatihan khusus yang diperoleh dari menyelesaikan level ini juga akan dikurangi.)]]
  },
  TipsType_20128_LeftBtnDesc = {Text = "Batal"},
  TipsType_20128_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20128_Title = {
    Text = "Konfirmasi Pengaturan Ulang"
  },
  TipsType_20129_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita yang terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20129_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20129_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20129_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20130_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita yang terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20130_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20130_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20130_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20131_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita yang terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20131_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20131_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20131_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20132_Desc = {
    Text = [[
Jika dicentang, dan <TipsHighlightText:Sisa Perjanjian> mencukupi, maka akan diprioritaskan untuk Lelah sisa tersebut.
Jika sisa tidak cukup, maka secara otomatis akan Lelah <TipsHighlightText:"{s1}"> untuk melengkapi kekurangan sisa.]]
  },
  TipsType_20132_LeftBtnDesc = {Text = "Batal"},
  TipsType_20132_RightBtnDesc = {
    Text = "Tetap beri tanda centang"
  },
  TipsType_20132_Title = {
    Text = "Pelengkapan otomatis"
  },
  TipsType_20133_Desc = {
    Text = "Apakah Anda ingin mendalami Gnosis untuk <TipsHighlightText:\"{s1}\">?"
  },
  TipsType_20133_LeftBtnDesc = {Text = "Batal"},
  TipsType_20133_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20133_Title = {
    Text = "Gnostic Advance"
  },
  TipsType_20134_Desc = {
    Text = "Untuk memastikan pengalaman cerita terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20134_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20134_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20134_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20137_Desc = {
    Text = "Konfirmasi menggunakan <Blue:「{s1}」×{s2}> untuk membuka trek ini?"
  },
  TipsType_20137_LeftBtnDesc = {Text = "Batal"},
  TipsType_20137_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20137_Title = {
    Text = "Konfirmasi Buka Kunci"
  },
  TipsType_20138_Desc = {
    Text = "Selama periode acara, <Blue:Gratis untuk waktu terbatas> membuka kunci. Apakah Anda ingin membuka kunci?"
  },
  TipsType_20138_LeftBtnDesc = {Text = "Batal"},
  TipsType_20138_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20138_Title = {
    Text = "Konfirmasi Buka Kunci"
  },
  TipsType_20139_Desc = {
    Text = "Konfirmasi penggunaan <Blue:「{s1}」×{s3}>, buka <Blue:「{s2}」>?"
  },
  TipsType_20139_LeftBtnDesc = {Text = "Batal"},
  TipsType_20139_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20139_Title = {
    Text = "Konfirmasi Buka Kunci"
  },
  TipsType_20140_Desc = {
    Text = "<Blue:「{s1}」> Batas maksimal kepemilikan saat ini telah tercapai. Melanjutkan penerimaan akan mengakibatkan item ini tidak diperoleh. Apakah tetap ingin menerimanya?"
  },
  TipsType_20140_LeftBtnDesc = {Text = "Batal"},
  TipsType_20140_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20140_Title = {
    Text = "Konfirmasi Klaim"
  },
  TipsType_20141_Desc = {
    Text = [[
Apakah kamu ingin membayar 30% dari Kesehatan maksimum ({s1})
untuk melewati Pertempuran dan segera mengeliminasi musuh?

Hidup saat ini: {s2}]]
  },
  TipsType_20141_LeftBtnDesc = {Text = "Batal"},
  TipsType_20141_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20141_Title = {
    Text = "memori otot"
  },
  TipsType_20142_Desc = {
    Text = "Apakah Anda memilih kehilangan <color=#BB646D> {s1} </color> poin hidup untuk mendapatkan {s2} segil hitam?"
  },
  TipsType_20142_LeftBtnDesc = {Text = "Batal"},
  TipsType_20142_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20142_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20145_LeftBtnDesc = {Text = "Batal"},
  TipsType_20145_Title = {
    Text = "Hadiah Masuk"
  },
  TipsType_20151_Desc = {
    Text = "Setelah direset, jumlah sisa \"barang spesial\"akan diatur ulang ke batas maksimum. Apakah kamu yakin?"
  },
  TipsType_20151_LeftBtnDesc = {Text = "Batal"},
  TipsType_20151_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20151_Title = {
    Text = "Konfirmasi Pengaturan Ulang"
  },
  TipsType_20152_Desc = {
    Text = "\"{s1}\" tidak cukup, apakah ingin menggunakan \"Mawar Emas\" × {s2} untuk melengkapi?"
  },
  TipsType_20152_LeftBtnDesc = {Text = "Batal"},
  TipsType_20152_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20152_Title = {
    Text = "Konfirmasi Pengaktifan"
  },
  TipsType_20153_Desc = {
    Text = [[
Setelah direset, jumlah sisa "Barang Spesial"dan "Barang Biasa"akan direset ke batas maksimum.
Mulai dari kali ke-{s1} dan seterusnya, "Barang Spesial"tidak akan direset lagi.
Apakah kamu yakin?]]
  },
  TipsType_20153_LeftBtnDesc = {Text = "Batal"},
  TipsType_20153_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20153_Title = {
    Text = "Konfirmasi Pengaturan Ulang"
  },
  TipsType_20154_Desc = {
    Text = [[
Setelah direset, jumlah tersisa dari "item spesial"dan "item biasa"akan direset ke batas maksimal.
Mulai dari reset ketiga dan seterusnya, "item spesial"tidak akan direset lagi.
 <Blue:saat ini masih ada "item biasa">, apakah kamu yakin?]]
  },
  TipsType_20154_LeftBtnDesc = {Text = "Batal"},
  TipsType_20154_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20154_Title = {
    Text = "Konfirmasi Pengaturan Ulang"
  },
  TipsType_20155_Desc = {
    Text = "Apakah kamu yakin ingin menggunakan Roda takdir yang terkunci dalam material tumpukan untuk dikonsumsi?"
  },
  TipsType_20155_LeftBtnDesc = {Text = "Batal"},
  TipsType_20155_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20155_Title = {
    Text = "Konfirmasi Tumpang Tindih"
  },
  TipsType_20156_Desc = {
    Text = "Apakah Anda yakin ingin menggunakan <TipsHighlightText:「Titik Awal Realitas」× 1> untuk membuka?\n(Selama acara Gelombang Keinginan, jumlah 「Titik Awal Realitas」 yang diperlukan untuk membuka berkurang dari {s1} menjadi {s2}.)"
  },
  TipsType_20156_LeftBtnDesc = {Text = "Batal"},
  TipsType_20156_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20156_Title = {
    Text = "Konfirmasi Buka Kunci"
  },
  TipsType_20157_Desc = {
    Text = "Apakah Anda yakin ingin menggunakan <TipsHighlightText:「Titik Awal Realitas」× {s1}> untuk membuka kunci?"
  },
  TipsType_20157_LeftBtnDesc = {Text = "Batal"},
  TipsType_20157_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20157_Title = {
    Text = "Konfirmasi Buka Kunci"
  },
  TipsType_20158_Desc = {
    Text = "Level saat ini telah kedaluwarsa. Setelah menyelesaikan tantangan, Anda tidak akan menerima hadiah. Apakah Anda yakin ingin keluar?"
  },
  TipsType_20158_LeftBtnDesc = {Text = "Batal"},
  TipsType_20158_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20158_Title = {
    Text = "Konfirmasi Keluar"
  },
  TipsType_20159_Desc = {
    Text = "<TipsHighlightText:「{s1}」> Melebihi batas atas <TipsHighlightText: {s2}> buah, masing-masing telah dikonversi menjadi <Blue:「Undangan Tanpa Bentuk」× 1>"
  },
  TipsType_20159_Title = {
    Text = "Petunjuk Transformasi"
  },
  TipsType_20160_Desc = {
    Text = [[
Kamu telah membuka<TipsHighlightText:"{s1}">
Barang dari acara kali ini akan memberikan kompensasi berikut untukmu.]]
  },
  TipsType_20160_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20160_Title = {
    Text = "Pemberitahuan Kompensasi"
  },
  TipsType_20161_Desc = {
    Text = "<TipsHighlightText:「{s1}」> Melebihi batas atas <TipsHighlightText: {s2}> buah, masing-masing telah dikonversi menjadi <Blue:「Mawar Emas」× 5000>"
  },
  TipsType_20161_Title = {
    Text = "Petunjuk Transformasi"
  },
  TipsType_20162_Desc = {
    Text = [[
Akan mengatur ulang peningkatan, mendidik, keterampilan, bakat, dan negara penguatan Gnosis pembangunan tubuh, dan mengembalikan lelah yang sesuai.
Apakah Anda yakin ingin melakukan pengembangan kembali untuk <WeaponEffect_Num:{s1}>?]]
  },
  TipsType_20162_LeftBtnDesc = {Text = "Batal"},
  TipsType_20162_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20162_Title = {
    Text = "Development Reset"
  },
  TipsType_20163_Desc = {
    Text = [[
Segera mengatur ulang status Mencerahkan dari Pembangun, serta mengembalikan konsumsi yang sesuai.
Apakah kamu yakin ingin melakukan pemulihan pembinaan pada <WeaponEffect_Num:{s1}>?]]
  },
  TipsType_20163_LeftBtnDesc = {Text = "Batal"},
  TipsType_20163_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20163_Title = {
    Text = "Enlightenment Reset"
  },
  TipsType_20164_Desc = {
    Text = [[
Akan segera mengatur ulang peningkatan, Mendidik, keterampilan, bakat, Mencerahkan, dan status Gnostic Advance dari Pembangun, serta mengembalikan konsumsi yang sesuai, 
 dan Pembangun akan dikembalikan ke Kolam Hitam. 
 Apakah Anda yakin untuk melakukan pengembalian ke Kolam Hitam untuk <WeaponEffect_Num:{s1}>?]]
  },
  TipsType_20164_LeftBtnDesc = {Text = "Batal"},
  TipsType_20164_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20164_Title = {
    Text = "Genesis Return"
  },
  TipsType_20165_Desc = {
    Text = [[
<WeaponEffect_Num:{s1}> termasuk dalam Pembangun khusus, hanya dapat melakukan pengembalian pelatihan untuk peningkatan, mendidik, keterampilan, bakat, dan Gnostic Advance, <Red:tidak dapat mengembalikan Mencerahkan>, apakah Anda yakin ingin memilih <WeaponEffect_Num:{s1}> untuk mengaktifkan retracing? 
 Operasi ini tidak dapat dibatalkan, harap konfirmasi dengan hati-hati]]
  },
  TipsType_20165_LeftBtnDesc = {Text = "Batal"},
  TipsType_20165_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20165_Title = {
    Text = "Kembali ke Pilihan"
  },
  TipsType_20166_Desc = {
    Text = "Pembangun khusus tidak dapat melakukan pencerahan kembali"
  },
  TipsType_20167_Desc = {
    Text = "Pengembalian kali ini telah menggunakan \"Pengembalian Pengembangan\", silakan lakukan \"Pengembalian Pengembangan\" saat pengembalian berikutnya dibuka."
  },
  TipsType_20168_Desc = {
    Text = "Pengembalian kali ini telah menggunakan \"Pengembalian Pencerahan\", silakan lakukan \"Pengembalian Pencerahan\" saat pengembalian berikutnya dibuka."
  },
  TipsType_20169_BottomDesc = {
    Text = "<Blue:Perhatian: Setelah dipilih, acara ini tidak dapat diubah lagi!>"
  },
  TipsType_20169_Desc = {
    Text = "Apakah anda yakin memilih Pembangun <OrangeQuality:\"{s1}\"> serta roda takdir yang direkomendasikan <OrangeQuality:\"{s2}\">, sebagai peningkatan terarah untuk acara ini?"
  },
  TipsType_20169_LeftBtnDesc = {Text = "Batal"},
  TipsType_20169_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20169_Title = {
    Text = "Konfirmasi Pilihan"
  },
  TipsType_20170_Desc = {
    Text = "Telah mencapai batas tantangan harian, silakan kembali tantangan besok!"
  },
  TipsType_20171_Desc = {
    Text = "Sekarang kau bisa pergi ke \"Terjunan Gaib\"!"
  },
  TipsType_20173_Desc = {
    Text = "Sekarang kau bisa pergi ke \"Traphase\"!"
  },
  TipsType_20174_Desc = {
    Text = "Sekarang kau bisa pergi ke \"Operasi·Keras\"!"
  },
  TipsType_20175_Desc = {
    Text = "Sekarang kau bisa pergi ke \"Kehadiran Transendental\"!"
  },
  TipsType_20176_Desc = {
    Text = "Sekarang kau bisa pergi ke \"Zona Bencana\"!"
  },
  TipsType_20177_Desc = {
    Text = "Sekarang kau bisa pergi ke \"Kegilaan Berlipat\"!"
  },
  TipsType_20178_Desc = {
    Text = "Sekarang Anda bisa menuju ke peralatan\"Roda takdir kedua\"!"
  },
  TipsType_20179_Desc = {
    Text = "Sekarang kau bisa pergi ke \"Kekacauan Berkumpul\"!"
  },
  TipsType_20180_Desc = {
    Text = "Sekarang kau bisa pergi ke \"Pencatatan Tabu\"!"
  },
  TipsType_20181_Desc = {
    Text = "Sekarang kau bisa pergi ke \"Peningkatan Perjanjian\"!"
  },
  TipsType_20182_Desc = {
    Text = "Sekarang kau bisa pergi ke \"Transkripsi Perjanjian\"!"
  },
  TipsType_20183_Desc = {
    Text = "Kegiatan saat ini sudah berakhir"
  },
  TipsType_20184_Desc = {
    Text = "Sekarang kau bisa pergi ke \"Arsip Akademik\"!"
  },
  TipsType_20185_Desc = {
    Text = "Konfirmasi untuk melewati semua plot dari bagian ini?"
  },
  TipsType_20185_LeftBtnDesc = {Text = "Batal"},
  TipsType_20185_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20185_Title = {
    Text = "Lewati alur cerita"
  },
  TipsType_20186_Desc = {
    Text = [[
Mengunduh data yang diperlukan untuk menjalankan permainan.
Apakah Anda ingin melanjutkan?

*Disarankan untuk mengunduh saat dalam lingkungan WiFi.]]
  },
  TipsType_20186_LeftBtnDesc = {Text = "Batal"},
  TipsType_20186_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20187_Desc = {
    Text = "Unduhan sumber daya selesai"
  },
  TipsType_20187_LeftBtnDesc = {Text = "Konfirmasi"},
  TipsType_20188_Desc = {
    Text = "Ruang penyimpanan tidak cukup, perlu menyisakan setidaknya {s1} ruang penyimpanan, jika tidak, dapat menyebabkan kehilangan sumber daya saat menjalankan, apakah ingin melanjutkan untuk mengunduh yang baru?"
  },
  TipsType_20188_LeftBtnDesc = {Text = "Batal"},
  TipsType_20188_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20189_Desc = {
    Text = "Unduhan sumber daya gagal, apakah ingin mencoba lagi?"
  },
  TipsType_20189_LeftBtnDesc = {Text = "Batal"},
  TipsType_20189_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20190_Desc = {
    Text = "<TipsHighlightText:{s1}>Melebihi batas atas<TipsHighlightText: {s2} >buah, masing-masing telah dikonversi menjadi<Blue:{s3}>"
  },
  TipsType_20190_Title = {
    Text = "Petunjuk Transformasi"
  },
  TipsType_20191_Desc = {
    Text = "Sekarang Anda bisa menuju ke\"Acara\"!"
  },
  TipsType_20192_Desc = {
    Text = [[
Mengunduh data yang diperlukan untuk melanjutkan konten prolog.
Ukuran sumber daya: {s1}
Apakah Anda ingin melanjutkan?

*Disarankan untuk mengunduh dalam lingkungan WiFi.]]
  },
  TipsType_20192_LeftBtnDesc = {Text = "Batal"},
  TipsType_20192_RightBtnDesc = {Text = "Unduh"},
  TipsType_20193_Desc = {
    Text = "Sekarang kau bisa pergi ke \"Tugas\"!"
  },
  TipsType_20194_Desc = {
    Text = "Sekarang Anda bisa menuju ke\"Perak komunikasi\"!"
  },
  TipsType_20195_Desc = {
    Text = "Sekarang kau bisa pergi ke \"Catatan Kursus\"!"
  },
  TipsType_20196_Desc = {
    Text = "Sekarang kau bisa pergi ke \"Alam Gelap\"!"
  },
  TipsType_20197_Desc = {
    Text = "Jumlah pemanggilan maksimum telah tercapai, silakan datang untuk mengambil hadiah tugas!"
  },
  TipsType_20198_Desc = {
    Text = "Tugas belum selesai, silakan selesaikan tugas terlebih dahulu dan datang lagi untuk mengklaim!"
  },
  TipsType_20199_Desc = {
    Text = [[
Setelah menerima, jumlah "Kredensial Proxy" akan melebihi batas maksimal kepemilikan. 
 Bagian yang melebihi tidak akan diperoleh. 
 Apakah Anda ingin tetap melanjutkan untuk menerima?]]
  },
  TipsType_20199_LeftBtnDesc = {Text = "Batal"},
  TipsType_20199_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20199_Title = {
    Text = "Konfirmasi Klaim"
  },
  TipsType_20200_Desc = {
    Text = "Mengajukan agen uji coba akan menghabiskan <Blue:「Kredensial Proxy」× 1>\nSetelah mengajukan, uji coba harian akan langsung diselesaikan, apakah Anda yakin?"
  },
  TipsType_20200_LeftBtnDesc = {Text = "Batal"},
  TipsType_20200_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20200_Title = {
    Text = "Konfirmasi Perwakilan"
  },
  TipsType_20201_Desc = {
    Text = "Perjanjian berikut sedang dilengkapi, apakah Anda ingin menggantinya?"
  },
  TipsType_20201_LeftBtnDesc = {Text = "Batal"},
  TipsType_20201_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20201_Title = {
    Text = "Konfirmasi Penggantian"
  },
  TipsType_20202_Desc = {
    Text = "Skema saat ini diterapkan pada {s1}, apakah Anda yakin ingin menghapus skema [{s2}]?"
  },
  TipsType_20202_LeftBtnDesc = {Text = "Batal"},
  TipsType_20202_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20202_Title = {
    Text = "Konfirmasi Penghapusan"
  },
  TipsType_20203_Desc = {
    Text = "Efek Roda takdir yang sama dalam tim tidak dapat diaktifkan kembali. {s1} sudah dilengkapi di tim saat ini. Apakah Anda yakin ingin melanjutkan?"
  },
  TipsType_20203_LeftBtnDesc = {Text = "Batal"},
  TipsType_20203_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20203_Title = {
    Text = "Konfirmasi Peralatan"
  },
  TipsType_20204_Desc = {
    Text = "Perjanjian saat ini telah digunakan di {s1}, setelah diuraikan akan dihapus dari skema tersebut, apakah Anda yakin?"
  },
  TipsType_20204_LeftBtnDesc = {Text = "Batal"},
  TipsType_20204_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20204_Title = {
    Text = "Konfirmasi Penghapusan"
  },
  TipsType_20205_Desc = {
    Text = "Perjanjian saat ini sudah digunakan di susunan tim {s1}. Setelah diuraikan, Perjanjian tersebut akan dilepas. Apakah kamu yakin?"
  },
  TipsType_20205_LeftBtnDesc = {Text = "Batal"},
  TipsType_20205_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20205_Title = {
    Text = "Konfirmasi Penghapusan"
  },
  TipsType_20206_Desc = {
    Text = "Roda takdir saat ini sudah digunakan di susunan tim {s1}. Setelah diuraikan, roda takdir tersebut akan dilepas dari susunan tim. Apakah Anda yakin?"
  },
  TipsType_20206_LeftBtnDesc = {Text = "Batal"},
  TipsType_20206_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20206_Title = {
    Text = "Konfirmasi Penghapusan"
  },
  TipsType_20207_Desc = {
    Text = "Skema saat ini belum disimpan. Keluar akan menghapus semua pengeditan kali ini. Apakah Anda yakin ingin keluar?"
  },
  TipsType_20207_LeftBtnDesc = {Text = "Batal"},
  TipsType_20207_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20207_Title = {
    Text = "Konfirmasi Penyimpanan"
  },
  TipsType_20208_Desc = {
    Text = "Hadiah tugas telah diterima, ayo lihat tugas lainnya!"
  },
  TipsType_20209_Desc = {
    Text = "Tugas telah kedaluwarsa"
  },
  TipsType_20210_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita yang optimal, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20210_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20210_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20210_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20211_Desc = {
    Text = "{s1} hari {s2} jam lagi akan dibuka"
  },
  TipsType_20212_Desc = {
    Text = "{s1} jam {s2} menit lagi akan dibuka"
  },
  TipsType_20213_Desc = {
    Text = [[
<WeaponEffect_Num:{s1}> telah memicu sebab-akibat melebihi batas dalam susunan tim, setiap pengembalian akan menyebabkan sebab-akibat melebihi batas menjadi tidak berlaku, dan akan secara otomatis dicopot dari susunan tim, apakah Anda yakin ingin memilih <WeaponEffect_Num:{s1}> untuk mengaktifkan pengembalian? 
 Operasi ini tidak dapat dibatalkan, harap konfirmasi dengan hati-hati]]
  },
  TipsType_20213_LeftBtnDesc = {Text = "Batal"},
  TipsType_20213_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20213_Title = {
    Text = "Kembali ke Pilihan"
  },
  TipsType_20214_Desc = {
    Text = [[
Segera mengatur ulang status tumpukan Roda takdir, dan mengembalikan semua Lelah tumpukan. 
<WeaponEffect_Num:{s1}> telah memicu sebab-akibat melebihi batas dalam susunan tim, dan setelah ditelusuri, akan secara otomatis dilepas dari susunan tim. 
Apakah Anda yakin ingin melakukan pemulihan tumpukan pada <WeaponEffect_Num:{s1}>?]]
  },
  TipsType_20214_LeftBtnDesc = {Text = "Batal"},
  TipsType_20214_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20214_Title = {
    Text = "Pelacakan Tumpang Tindih"
  },
  TipsType_20215_Desc = {
    Text = [[
Roda takdir akan segera diatur ulang ke status tumpukan, mengembalikan semua Lelah tumpukan, dan Roda takdir akan dikembalikan ke Genesis Return. 
<WeaponEffect_Num:{s1}> telah memicu sebab akibat melebihi batas dalam susunan tim, setelah dikembalikan akan secara otomatis dilepas dari susunan tim. 
Apakah Anda yakin untuk mengembalikan <WeaponEffect_Num:{s1}> ke Genesis Return?]]
  },
  TipsType_20215_LeftBtnDesc = {Text = "Batal"},
  TipsType_20215_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20215_Title = {
    Text = "Genesis Return"
  },
  TipsType_20216_Desc = {
    Text = "Apakah Anda ingin menghabiskan <Blue:「{s1}」× {s2} > untuk membeli?"
  },
  TipsType_20216_LeftBtnDesc = {Text = "Batal"},
  TipsType_20216_RightBtnDesc = {Text = "Membeli"},
  TipsType_20216_Title = {
    Text = "Konfirmasi Pembelian"
  },
  TipsType_20217_Desc = {
    Text = "{s1} akan dibuka setelah {s2}."
  },
  TipsType_20218_Desc = {
    Text = "Pada penyelidikan ini, Pembangun yang dipilih tidak dapat diganti, hanya dapat diganti dengan Pembangun yang sesuai."
  },
  TipsType_20219_Desc = {
    Text = "Pembangun yang sama sudah diturunkan, tidak dapat dipilih kembali."
  },
  TipsType_20220_Desc = {
    Text = [[
Mendeteksi saat ini tidak ada WIFI, pengunduhan akan menghabiskan banyak data, apakah anda yakin ingin mengunduh?
 Ukuran sumber daya: {s1}
 Apakah ingin melanjutkan?]]
  },
  TipsType_20220_LeftBtnDesc = {Text = "Batal"},
  TipsType_20220_RightBtnDesc = {Text = "Unduh"},
  TipsType_20221_Desc = {
    Text = "Unduhan sumber daya selesai"
  },
  TipsType_20221_LeftBtnDesc = {Text = "Konfirmasi"},
  TipsType_20222_Desc = {
    Text = "Ruang penyimpanan tidak cukup, perlu menyisakan setidaknya {s1} ruang penyimpanan, jika tidak, dapat menyebabkan kehilangan sumber daya saat menjalankan, apakah ingin melanjutkan untuk mengunduh yang baru?"
  },
  TipsType_20222_LeftBtnDesc = {Text = "Batal"},
  TipsType_20222_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20223_Desc = {
    Text = "Unduhan sumber daya gagal, apakah ingin mencoba lagi?"
  },
  TipsType_20223_LeftBtnDesc = {Text = "Batal"},
  TipsType_20223_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20224_Desc = {
    Text = [[
Mengunduh data yang diperlukan untuk melanjutkan konten prolog.
Ukuran sumber daya: {s1}
Apakah Anda ingin melanjutkan?

*Disarankan untuk mengunduh dalam lingkungan WiFi.]]
  },
  TipsType_20224_LeftBtnDesc = {Text = "Batal"},
  TipsType_20224_RightBtnDesc = {Text = "Unduh"},
  TipsType_20225_Desc = {
    Text = [[
{s1} sudah selesai, apakah akan melakukan tantangan tambahan?
Tantangan tambahan dapat memperoleh {s2} nilai pengarahan]]
  },
  TipsType_20225_LeftBtnDesc = {Text = "Batal"},
  TipsType_20225_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20225_Title = {
    Text = "Tantangan tambaha"
  },
  TipsType_20226_Desc = {
    Text = "Setelah direset, penyembuh, kunci, dan roda takdir tim tantangan tambahan dapat dimainkan kembali, tetapi nilai pelatihan yang didapat dari penyelesaian tambahan untuk level tersebut juga akan dikurangi (tidak mempengaruhi status hadiah), apakah Anda ingin mengonfirmasi reset?"
  },
  TipsType_20226_LeftBtnDesc = {Text = "Batal"},
  TipsType_20226_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20226_Title = {
    Text = "Konfirmasi Pengaturan Ulang"
  },
  TipsType_20227_Desc = {
    Text = "Setelah direset, Awakener, Posse, dan Roda takdir tim penyelidikan saat ini dapat kembali digunakan, dan tim tantangan tambahan akan menggantikan tim penyelidikan saat ini, tetapi nilai Latihan khusus yang diperoleh dari penyelesaian tambahan untuk level ini juga akan dikurangi (tidak mempengaruhi status hadiah). Apakah Anda yakin untuk mereset?"
  },
  TipsType_20227_LeftBtnDesc = {Text = "Batal"},
  TipsType_20227_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20227_Title = {
    Text = "Konfirmasi Pengaturan Ulang"
  },
  TipsType_20228_Desc = {
    Text = "Gulir ke bawah untuk melihat lebih banyak pengumuman"
  },
  TipsType_20229_Desc = {
    Text = [[
"<Blue:{s1}>" telah mencapai batas level tumpangan
Apakah ingin melanjutkan pembelian?
Jumlah tersisa: {s2}]]
  },
  TipsType_20229_LeftBtnDesc = {Text = "Batal"},
  TipsType_20229_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20229_Title = {
    Text = "Konfirmasi Pembelian"
  },
  TipsType_20230_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita yang terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20230_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20230_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20230_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20231_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita yang terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20231_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20231_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20231_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20232_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita yang terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20232_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20232_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20232_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20233_Desc = {
    Text = "Bahan yang diperlukan saat ini tidak mencukupi, apakah ingin menggunakan bahan berikut untuk melengkapinya?"
  },
  TipsType_20233_LeftBtnDesc = {Text = "Batal"},
  TipsType_20233_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20233_Title = {
    Text = "Lengkapi Konfirmasi"
  },
  TipsType_20234_Desc = {
    Text = "Pada level ini hanya dapat memasang kunci Geng yang telah ditentukan, tidak dapat melakukan penggantian."
  },
  TipsType_20235_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita yang terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20235_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20235_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20235_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20236_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20236_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20236_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20236_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20237_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita yang terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20237_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20237_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20237_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20238_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita yang terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20238_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20238_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20238_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20239_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita yang terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20239_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20239_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20239_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20240_Desc = {
    Text = "Perbaikan telah selesai, silakan restart game"
  },
  TipsType_20240_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20240_Title = {
    Text = "Tips yang berguna"
  },
  TipsType_20241_Desc = {
    Text = [[
Masih butuh {s1} "<Blue:{s2}>" untuk mencapai batas level tumpang tindih
Apakah ingin melanjutkan pembelian?]]
  },
  TipsType_20241_LeftBtnDesc = {Text = "Batal"},
  TipsType_20241_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20241_Title = {
    Text = "Konfirmasi Pembelian"
  },
  TipsType_20250_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita yang terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20250_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20250_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20250_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20251_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita yang terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20251_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20251_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20251_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20252_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_20252_LeftBtnDesc = {Text = "Keluar"},
  TipsType_20252_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_20252_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20259_Desc = {
    Text = "Pengaturan pertukaran saat \"Segel Berwajah Seribu\" tidak mencukupi telah disimpan"
  },
  TipsType_20300_Desc = {
    Text = "Terdapat {s1} Pembangun dengan posisi yang sama, sehingga tidak dapat menggunakan Pembangun dengan posisi yang sama dalam satu tim."
  },
  TipsType_20301_Desc = {
    Text = "Sekarang kau bisa pergi ke \"Tugas Latihan Rutin\"!"
  },
  TipsType_20351_Desc = {
    Text = "{s1} tidak cukup, apakah akan menggunakan {s2}{s3} untuk menukar {s4}{s5}"
  },
  TipsType_20351_LeftBtnDesc = {Text = "Batal"},
  TipsType_20351_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20351_Title = {
    Text = "{s1} tidak cukup"
  },
  TipsType_20352_Desc = {
    Text = "Akan segera terikat dengan pihak lain, setelah terikat tidak dapat dibatalkan, konfirmasi untuk melanjutkan pengikatan?"
  },
  TipsType_20352_LeftBtnDesc = {Text = "Batal"},
  TipsType_20352_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20352_Title = {
    Text = "Konfirmasi undanga"
  },
  TipsType_20353_Desc = {
    Text = "Kode undangan telah disalin ke papan klip."
  },
  TipsType_20354_Desc = {
    Text = "Anda sudah menjadi undangan pihak lain."
  },
  TipsType_20355_Desc = {
    Text = "Tidak bisa memasukkan kode undanganmu sendiri, cobalah mendapatkan kode undangan dari Penjaga lainnya."
  },
  TipsType_20356_Desc = {
    Text = [[
Anda dapat memainkan kembali untuk mengalami kembali alur cerita prolog dan pelatihan! 
Namun saat memulai kembali, semua hadiah konten level adalah demonstrasi dan tidak bisa benar-benar didapatkan. 
Apakah Anda ingin melanjutkan?]]
  },
  TipsType_20356_LeftBtnDesc = {Text = "Batal"},
  TipsType_20356_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20356_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_20357_Desc = {
    Text = "Apakah Anda yakin ingin berhenti mengikuti {s1} Penjaga ini?"
  },
  TipsType_20357_LeftBtnDesc = {Text = "Batal"},
  TipsType_20357_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20357_Title = {
    Text = "Berhenti mengikuti"
  },
  TipsType_20358_Desc = {
    Text = "Ada pembatalan perhatian yang belum dikonfirmasi. Keluar tidak akan menyimpan tindakan apa pun. Apakah Anda yakin ingin keluar?"
  },
  TipsType_20358_LeftBtnDesc = {Text = "Batal"},
  TipsType_20358_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20358_Title = {
    Text = "Konfirmasi Keluar"
  },
  TipsType_20400_Desc = {
    Text = "<WeaponEffect_Num:\"{s1}\"> tidak cukup, apakah ingin pergi menukarkan?"
  },
  TipsType_20400_LeftBtnDesc = {Text = "Batal"},
  TipsType_20400_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_20400_Title = {
    Text = "Jumlah item undian tidak mencukupi"
  },
  TipsType_300001_Desc = {
    Text = "\"Perak Cemerlang\"hanya memiliki satu kesempatan Bangun gratis, apakah Anda yakin ingin menggunakannya?"
  },
  TipsType_300001_LeftBtnDesc = {Text = "Batal"},
  TipsType_300001_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_300001_Title = {
    Text = "Konfirmasi Bangun"
  },
  TipsType_300002_Desc = {
    Text = "Apa Anda yakin ingin mengonfirmasi hasil pembangkitan kali ini? Setelah dikonfirmasi, pembangkitan kali ini akan menghabiskan 5 kesempatan menarik gratis"
  },
  TipsType_300002_LeftBtnDesc = {Text = "Batal"},
  TipsType_300002_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_300002_Title = {
    Text = "Konfirmasi Bangun"
  },
  TipsType_30001_Desc = {
    Text = "Petunjuk di sisi tanpa ikon"
  },
  TipsType_30003_Desc = {
    Text = "{s1} dibuka"
  },
  TipsType_30004_Desc = {
    Text = "{s1} Mode Lanjutan Terbuka"
  },
  TipsType_30005_Desc = {
    Text = "{s1} (Keras) terbuka"
  },
  TipsType_31000_Desc = {
    Text = "Apakah Anda yakin ingin menggunakan sertifikasi tanggal lahir ini? Setelah ditentukan, tanggal lahir tidak dapat diubah lagi!"
  },
  TipsType_31000_LeftBtnDesc = {Text = "Batal"},
  TipsType_31000_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_31000_Title = {
    Text = "Verifikasi umur"
  },
  TipsType_31001_Desc = {
    Text = "Bulan ini telah mengisi ulang <Blue:{s1}> yuan, batas maksimum adalah <Blue:{s2}> yuan, harap isi ulang bulan depan atau coba isi ulang dengan jumlah yang lebih rendah"
  },
  TipsType_31002_Desc = {
    Text = "Silakan selesaikan verifikasi usia terlebih dahulu"
  },
  TipsType_31003_Desc = {
    Text = [[
Kunci perak merasakan bahaya mematikan, apakah akan mengaktifkan Tubuh Gnosis Darurat?
(Kebangkitan akan menghabiskan 1 kali Tubuh Gnosis Darurat, Tubuh Gnosis Darurat diperoleh secara otomatis setiap pukul 9 setiap hari, jumlah sisa saat ini: {s1})
<Blue:(Kebangkitan pertama tidak menghabiskan Tubuh Gnosis Darurat)>]]
  },
  TipsType_31003_LeftBtnDesc = {Text = "Batal"},
  TipsType_31003_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_31003_Title = {
    Text = "Konfirmasi Kebangkitan"
  },
  TipsType_31004_Desc = {
    Text = [[
Kunci perak merasakan bahaya mematikan, apakah akan mengaktifkan Gnosis darurat?
(Menghidupkan kembali akan melelahkan 1 kali Gnosis darurat, Gnosis darurat diperoleh secara otomatis setiap pukul 9 setiap hari, jumlah sisa saat ini: {s1})
<Blue:(Kebangkitan pertama tidak mengonsumsi Gnosis darurat)>]]
  },
  TipsType_31004_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_31004_Title = {
    Text = "Konfirmasi Kebangkitan"
  },
  TipsType_40001_Desc = {
    Text = "Ketika hidup mencapai 0, penyelidikan akan berakhir secara paksa."
  },
  TipsType_40001_Title = {Text = "HP"},
  TipsType_40002_Desc = {
    Text = [[
Pergerakan peta dan kejadian penyelidikan akan menghasilkan tekanan Roh, akumulasi tekanan akan menyebabkan Penjaga mengalami gejala. 
 Setiap kali bergerak satu kotak, tekanan meningkat sebesar 10 poin. Setiap 100 poin tekanan penuh, mendapatkan 1 gejala. 
 Ketika tekanan mencapai 500, setiap kali bergerak satu kotak, mengurangi 10% HP.]]
  },
  TipsType_40002_Title = {Text = "Tekanan"},
  TipsType_40003_Desc = {
    Text = "Semakin tinggi level Tugas, semakin sulit misinya, dan hadiah yang diperoleh dari Tugas juga akan meningkat sesuai."
  },
  TipsType_40003_Title = {
    Text = "Level Tugas"
  },
  TipsType_40004_Desc = {
    Text = [[
Salinan sementara dari Kartu Perintah pertama yang dimainkan setiap ronde akan masuk ke Ruang Ultra. 
Ketika Ruang Ultra mencapai batas maksimum, dapatkan 1 Ronde Ultra tambahan dan pertahankan Perisai. 
Efek Penguasaan Alam: Ada kemungkinan menambahkan 1 "Inspirasi" ke tangan di awal ronde.]]
  },
  TipsType_40004_Title = {
    Text = "Ruang Ultra"
  },
  TipsType_40005_Desc = {
    Text = "Penjaga dapat meningkatkan level mereka melalui tantangan seperti Penyelidikan, Selingan, dan lainnya. Lebih banyak fitur permainan akan dibuka secara bertahap seiring dengan peningkatan level Penjaga."
  },
  TipsType_40005_Title = {Text = "Tingkat"},
  TipsType_40006_Desc = {
    Text = "Mengeluarkan Kartu perintah membutuhkan Lelah Aritmetika. Aritmetika yang tersisa tidak akan dipertahankan saat putaran berakhir, dan pada awal putaran Aritmetika akan pulih ke batas atas."
  },
  TipsType_40006_Title = {
    Text = "Arithmetica"
  },
  TipsType_40007_Desc = {
    Text = "Kunci perak merasakan seberkas energi khusus, mungkin ada inventaris berharga yang tersembunyi di peta..."
  },
  TipsType_40007_Title = {
    Text = "Inventaris Tersembunyi"
  },
  TipsType_40008_Desc = {
    Text = "Saat menghadapi krisis fatal dalam Pertempuran, dapat diaktifkan. Setiap kali diaktifkan, mengonsumsi 1 buah, membuat Hidup dan Aliemus Penjaga pulih ke batas maksimum. Secara otomatis mendapatkan 1 buah setiap hari pukul 9."
  },
  TipsType_40008_Title = {
    Text = "Tubuh Gnosis Darurat"
  },
  TipsType_40009_Desc = {
    Text = "Mengeluarkan Kartu Perintah membutuhkan Lelah Aritmetika. Aritmetika yang tersisa tidak akan dipertahankan saat putaran berakhir, dan pada awal putaran batas atas Aritmetika akan bertambah +1 serta Aritmetika akan pulih ke batas atas. Saat ini adalah putaran ke {s1}."
  },
  TipsType_40009_Title = {
    Text = "Arithmetica"
  },
  TipsType_AbyssChallengeResetTips_Desc = {
    Text = "Zona Terlarang Efek-d regional telah direset, tantangan yang sedang berlangsung akan segera berakhir."
  },
  TipsType_AbyssChallengeResetTips_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_AbyssChallengeResetTips_Title = {Text = "Petunjuk"},
  TipsType_AbyssChallengeRevivalTips_Desc = {
    Text = [[
Kunci Perak mendeteksi ancaman mematikan, apakah ingin mengaktifkan Tubuh Gnosis Darurat?
(Kebangkitan akan mengonsumsi {s1} Tubuh Gnosis Darurat, Tubuh Gnosis Darurat diperoleh otomatis 1 buah setiap hari pukul 9)]]
  },
  TipsType_AbyssChallengeRevivalTips_LeftBtnDesc = {Text = "Batal"},
  TipsType_AbyssChallengeRevivalTips_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_AbyssChallengeRevivalTips_Title = {
    Text = "Konfirmasi Kebangkitan"
  },
  TipsType_AcceptConfirm_Desc = {
    Text = "Apakah Anda menerima undangan <Blue:{s1}> untuk <Blue:{s2}>?"
  },
  TipsType_AcceptConfirm_LeftBtnDesc = {Text = "Menolak"},
  TipsType_AcceptConfirm_RightBtnDesc = {Text = "Terima"},
  TipsType_AcceptConfirm_Title = {
    Text = "Pertempuran Kata Sandi"
  },
  TipsType_ActivitySignRewardTaskNotCompleteTips_Desc = {
    Text = "Selesaikan tugas yang sesuai untuk melakukan bangkit"
  },
  TipsType_AlreadyIsBackgroundMusicTips_Desc = {
    Text = "Sudah menjadi musik latar saat ini"
  },
  TipsType_AwakerAutoInsertCoinNotEnoughTips_Desc = {
    Text = "\"Rose Scrip\" tidak cukup untuk menggunakan \"Eliksir gnosis\" yang dimiliki saat ini secara penuh, coba lagi setelah menambahkan \"Rose Scrip\"."
  },
  TipsType_AwakerNotOpenTips_Desc = {
    Text = "Awakener belum tersedia untuk saat ini, nantikan ya"
  },
  TipsType_AwakerRandomChestConfirm_Desc = {
    Text = "Konfirmasi menggunakan <Blue:{s1}> untuk mendapatkan 1 Tubuh Terjaga <Blue:acak>?"
  },
  TipsType_AwakerRandomChestConfirm_LeftBtnDesc = {Text = "Batal"},
  TipsType_AwakerRandomChestConfirm_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_AwakerRandomChestConfirm_Title = {
    Text = "Konfirmasi Penggunaan"
  },
  TipsType_BattleCreateFail_Desc = {
    Text = "Pembuatan pertempuran gagal"
  },
  TipsType_BattlePassAllCompleteTips_Desc = {
    Text = "Karier Penjaga Rahasia saat ini telah selesai sepenuhnya."
  },
  TipsType_BestExperienceTips_Chapter3_Desc = {
    Text = "Untuk memastikan pengalaman cerita terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_BestExperienceTips_Chapter3_LeftBtnDesc = {Text = "Keluar"},
  TipsType_BestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_BestExperienceTips_Chapter3_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_BestExperienceTips_Chapter7_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita yang terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_BestExperienceTips_Chapter7_LeftBtnDesc = {Text = "Keluar"},
  TipsType_BestExperienceTips_Chapter7_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_BestExperienceTips_Chapter7_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_BestExperienceTips_Chapter8_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita yang terbaik, disarankan untuk menyelesaikan level Penyelidikan berikut."
  },
  TipsType_BestExperienceTips_Chapter8_LeftBtnDesc = {Text = "Keluar"},
  TipsType_BestExperienceTips_Chapter8_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_BestExperienceTips_Chapter8_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_BestExperienceTips_ChapterS2_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_BestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "Keluar"},
  TipsType_BestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_BestExperienceTips_ChapterS2_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_BestExperienceTips_ChapterS3_Desc = {
    Text = "Untuk memastikan pengalaman alur cerita yang terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_BestExperienceTips_ChapterS3_LeftBtnDesc = {Text = "Keluar"},
  TipsType_BestExperienceTips_ChapterS3_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_BestExperienceTips_ChapterS3_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_BestExperienceTips_ChapterS4_Desc = {
    Text = "Untuk memastikan pengalaman cerita terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_BestExperienceTips_ChapterS4_LeftBtnDesc = {Text = "Keluar"},
  TipsType_BestExperienceTips_ChapterS4_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_BestExperienceTips_ChapterS4_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_BestExperienceTips_ChapterS5_Desc = {
    Text = "Untuk memastikan pengalaman cerita terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_BestExperienceTips_ChapterS5_LeftBtnDesc = {Text = "Keluar"},
  TipsType_BestExperienceTips_ChapterS5_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_BestExperienceTips_ChapterS5_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Desc = {
    Text = "Untuk memastikan pengalaman cerita terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_BestExperienceTips_MainStoryS1_6_LeftBtnDesc = {Text = "Keluar"},
  TipsType_BestExperienceTips_MainStoryS1_6_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Desc = {
    Text = "Untuk memastikan pengalaman cerita terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_LeftBtnDesc = {Text = "Keluar"},
  TipsType_BestExperienceTips_TwoAnniversarySubStage_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_CancelCollectAwakerTips_Desc = {
    Text = "Favorit telah dibatalkan"
  },
  TipsType_CoinBulkBuyConfirm_Desc = {
    Text = "Apakah ingin menggunakan \"Kupon Emas Mawar\" × {s1} untuk melakukan pembelian?"
  },
  TipsType_CoinBulkBuyConfirm_LeftBtnDesc = {Text = "Batal"},
  TipsType_CoinBulkBuyConfirm_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_CoinBulkBuyConfirm_Title = {
    Text = "Konfirmasi Pembelian"
  },
  TipsType_CollectAwakerTips_Desc = {
    Text = "Koleksi berhasil disimpan"
  },
  TipsType_CommonUseBattleHelpLimitTips_Desc = {
    Text = "Bantu penjaga yang sering digunakan telah mencapai batas, silakan sesuaikan daftar bantu yang sering digunakan"
  },
  TipsType_DiskIsFullOrViolation_Desc = {
    Text = "Gagal menulis file, silakan periksa apakah ruang penyimpanan perangkat masih mencukupi"
  },
  TipsType_DiskIsFullOrViolation_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_DiskSpaceNotEnough_Desc = {
    Text = "Ruang penyimpanan tidak cukup, apakah ingin melanjutkan mencoba mengunduh?"
  },
  TipsType_DiskSpaceNotEnough_LeftBtnDesc = {Text = "Batal"},
  TipsType_DiskSpaceNotEnough_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_DoubleExBPBuyConfirm_Desc = {
    Text = "Apakah akan menggunakan<Blue:\"Perak utama\"× {s1} > untuk membeli?\n <color=#ACBFCA>Topik khusus kali ini, harga topik inti telah diturunkan</color>"
  },
  TipsType_DoubleExBPBuyConfirm_LeftBtnDesc = {Text = "Batal"},
  TipsType_DoubleExBPBuyConfirm_RightBtnDesc = {Text = "Membeli"},
  TipsType_DoubleExBPBuyConfirm_Title = {
    Text = "Konfirmasi Pembelian"
  },
  TipsType_EnterSix_DigitPasswordTips_Desc = {
    Text = "Masukkan <color=#5EF2FF>nilai fase</color>"
  },
  TipsType_FilterMaxAwakerCountTips_Desc = {
    Text = "Pilih maksimal {s1} Awakener untuk penyaringan"
  },
  TipsType_FollowBackConfirm_Desc = {
    Text = [[
Apakah Anda yakin ingin mengikuti <color=#5EF2FF>{s1}</color> pengikut di halaman saat ini?

<color=#96947F>Saat ini mengikuti </color>{s2}<color=#A0A0A0>/{s3}
Setelah melebihi batas, Anda tidak akan dapat mengikuti lagi</color>]]
  },
  TipsType_FollowBackConfirm_LeftBtnDesc = {Text = "Batal"},
  TipsType_FollowBackConfirm_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_FollowBackConfirm_Title = {
    Text = "Konfirmasi Kembali Mengikuti"
  },
  TipsType_FrenziedOmenUpgradeConfirm_Desc = {
    Text = "Operasi ini akan menghabiskan banyak sumber daya, cocok untuk situasi di mana kamu ingin mengembangkan kemampuan Awakener hingga batas maksimal, konfirmasi Penguatan \"Madness Omen\"?"
  },
  TipsType_FrenziedOmenUpgradeConfirm_LeftBtnDesc = {Text = "Batal"},
  TipsType_FrenziedOmenUpgradeConfirm_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_FrenziedOmenUpgradeConfirm_Title = {
    Text = "Konfirmasi Memperkuat"
  },
  TipsType_GnosticPotentialUpgradeConfirm_Desc = {
    Text = "Operasi ini akan menghabiskan banyak sumber daya, cocok untuk situasi di mana kamu ingin mengembangkan kemampuan Awakener hingga batas maksimal, konfirmasi Penguatan \"Lingge Batin\"?"
  },
  TipsType_GnosticPotentialUpgradeConfirm_LeftBtnDesc = {Text = "Batal"},
  TipsType_GnosticPotentialUpgradeConfirm_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_GnosticPotentialUpgradeConfirm_Title = {
    Text = "Konfirmasi Memperkuat"
  },
  TipsType_InCharging_Desc = {
    Text = [[
Pesanan sedang diproses, harap tidak melakukan pembayaran ulang. 
 Jika pembayaran telah selesai, harap bersabar menunggu sistem memberikan hadiah. 
 Jika pembayaran belum selesai, silakan coba restart game dan coba lagi. 
 Jika ada pertanyaan, silakan hubungi layanan pelanggan.]]
  },
  TipsType_InCharging_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_InCharging_Title = {
    Text = "Tips yang berguna"
  },
  TipsType_KeyShortNameDownLoadTips_Desc = {
    Text = "Sedang mengunduh sumber daya pengenal teks, harap coba lagi nanti"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_Desc = {
    Text = "Tubuh yang harus dibangkitkan sudah penuh\nSetelah memilih, hanya mendapatkan\"Fragmen Gnosis Essensi\"× 2"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_LeftBtnDesc = {Text = "Batal"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_RightBtnDesc = {Text = "Lanjutkan"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_Title = {
    Text = "Konfirmasi Pilihan"
  },
  TipsType_MainResetBG_Desc = {
    Text = "Apakah kamu perlu mengembalikan latar belakang asrama <Blue:\"latar\"> dan <Blue:\"musik\"> ke default?"
  },
  TipsType_MainResetBG_LeftBtnDesc = {Text = "Batal"},
  TipsType_MainResetBG_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_MainResetBG_Title = {
    Text = "Kembalikan ke pengaturan default"
  },
  TipsType_MultiSelectBox_FixItemTips_Desc = {
    Text = "Item yang diperoleh tetap, tidak dapat diubah"
  },
  TipsType_MultiSelectBox_SelectTips_Desc = {
    Text = "Silakan selesaikan semua pemilihan barang pilihan sebelum dapat melakukan pembelian"
  },
  TipsType_OppositeSideCancelMatchTips_Desc = {
    Text = "Pihak lain telah membatalkan pertandingan"
  },
  TipsType_OppositeSideRejectTips_Desc = {
    Text = "Pihak lain telah menolak undangan <Blue:{s1}>, silakan pilih mode lagi"
  },
  TipsType_PVEExceedMaxRoundsTips_Desc = {
    Text = [[
Jumlah ronde pertarungan telah mencapai batas maksimum

Wahai Penjaga satu-satunya
Bagaimana pilihanmu selanjutnya?]]
  },
  TipsType_PVEExceedMaxRoundsTips_LeftBtnDesc = {
    Text = "Mulai ulang pertempuran"
  },
  TipsType_PVEExceedMaxRoundsTips_RightBtnDesc = {
    Text = "Mundur untuk sementara"
  },
  TipsType_PVEExceedMaxRoundsTips_Title = {
    Text = "Penyelidikan gagal"
  },
  TipsType_PVEReplayErrorTips_Desc = {
    Text = "Kesalahan dalam mendapatkan rekaman pertempuran, silakan coba lagi nanti"
  },
  TipsType_PVEReplayMaxRounds_Desc = {
    Text = [[
Replay telah mencapai batas maksimum 25 giliran,
 replay selesai.]]
  },
  TipsType_PVEReplayMaxRounds_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_PVEReplayMaxRounds_Title = {
    Text = "Konfirmasi akhir"
  },
  TipsType_PVEReplayNoDataTips_Desc = {
    Text = "Tidak ada catatan tindakan penyelidika"
  },
  TipsType_PVEReplayRepeatClickTips_Desc = {
    Text = "Sedang memuat ulang pertarungan, mohon jangan ulang tindakan"
  },
  TipsType_PVEReplaySpecialTeamAssignTips_Desc = {
    Text = "Pertarungan replay untuk komposisi khusus belum didukung, harap ditunggu"
  },
  TipsType_PVEReplayTimeoutTips_Desc = {
    Text = "Waktu untuk mendapatkan rekaman pertempuran telah habis"
  },
  TipsType_PVEReplayUnableOperateTips_Desc = {
    Text = "Tidak dapat mengoperasikan saat pemutaran ulang pertarunga"
  },
  TipsType_PVETeamShareCodeCopyTips_Desc = {
    Text = "Disalin ke clipboard"
  },
  TipsType_PVETeamShareCodeError_Desc = {
    Text = "Tidak dapat mengidentifikasi dengan benar bahwa di dalam papan potong ada <color=#5EF2FF>Operasi</color> susunan"
  },
  TipsType_PVETeamShareCodeSaveTips_Desc = {
    Text = [[
Apakah yakin akan menyimpan konfigurasi tim yang sesuai dengan kode komposisi ini?
Bagian yang tidak memiliki konfigurasi tersebut akan dikosongkan.]]
  },
  TipsType_PVETeamShareCodeSaveTips_LeftBtnDesc = {Text = "Batal"},
  TipsType_PVETeamShareCodeSaveTips_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_PVETeamShareCodeSaveTips_Title = {
    Text = "Konfirmasi Penyimpanan"
  },
  TipsType_PVETeamShareCodeSpecialTeamAssignTips_Desc = {
    Text = "Tim ini termasuk wakil yang telah disiapkan, tidak dapat menyalin atau mengimpor kode penyusunan"
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_Desc = {
    Text = "Pertandingan telah mencapai batas ronde, pihak yang bergerak lebih dulu gagal mengakhiri pertandingan, dinyatakan kalah."
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_PVPExceedMaxRoundsTips_Loser_Title = {
    Text = "Pertandingan Selesai"
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_Desc = {
    Text = "Pertandingan telah mencapai batas ronde, pihak yang bergerak belakangan berhasil bertahan hingga Akhir, dinyatakan menang."
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_PVPExceedMaxRoundsTips_Winner_Title = {
    Text = "Pertandingan Selesai"
  },
  TipsType_PVPSurrenderConfirm_Desc = {
    Text = "Apakah Anda menyerah?"
  },
  TipsType_PVPSurrenderConfirm_LeftBtnDesc = {Text = "Batal"},
  TipsType_PVPSurrenderConfirm_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_PVPSurrenderConfirm_Title = {
    Text = "Konfirmasi menyerah"
  },
  TipsType_PVPTeamShareCodeError_Desc = {
    Text = "Tidak dapat mengidentifikasi dengan benar bahwa di dalam papan potong ada <color=#5EF2FF>Traphase</color> susunan"
  },
  TipsType_PVP_PasswordBattle_BlockTips_Desc = {
    Text = "Apakah perlu memblokir Penjaga ini?"
  },
  TipsType_PVP_PasswordBattle_BlockTips_LeftBtnDesc = {Text = "Menolak"},
  TipsType_PVP_PasswordBattle_BlockTips_RightBtnDesc = {Text = "Terima"},
  TipsType_PVP_PasswordBattle_BlockTips_Title = {
    Text = "Apakah akan memblokir"
  },
  TipsType_PVP_PasswordBattle_GameStartedTips_Desc = {
    Text = "Pertarungan kata sandi ini telah dimulai"
  },
  TipsType_PVP_PasswordBattle_OthersEnterTips_Desc = {
    Text = "Ada Penjaga baru yang masuk ke dalam pertarungan sandi ini"
  },
  TipsType_PVP_PasswordBattle_QueueTips_Desc = {
    Text = "Sedang mengantre……"
  },
  TipsType_PVP_PasswordBattle_QuitTips_Desc = {
    Text = "Apakah Anda yakin ingin keluar dari pertarungan sandi ini?"
  },
  TipsType_PVP_PasswordBattle_QuitTips_LeftBtnDesc = {Text = "Batal"},
  TipsType_PVP_PasswordBattle_QuitTips_RightBtnDesc = {Text = "Keluar"},
  TipsType_PVP_PasswordBattle_QuitTips_Title = {
    Text = "Konfirmasi Keluar"
  },
  TipsType_PVP_PasswordBattle_RejectedTips_Desc = {
    Text = "Pihak lain telah menolak pertarungan dengan Anda"
  },
  TipsType_PassportHoistTips1_Desc = {
    Text = "\"Ion Aktif Dasar\"\n·Setelah dibuka, selama periode topik ini berlangsung, \"Titik Awal Realitas\", \"Inti Murni\", \"Pengalaman\", dan \"Perak\" yang diperoleh dari hadiah kumulatif \"Ion Aktif Dasar\" di \"Misi Harian\" akan meningkat hingga 3 kali lipat. Setelah membeli \"Topik Inti\", selisih kelipatan tambahan dari hadiah kumulatif \"Ion Aktif Dasar\" yang sudah diklaim pada periode ini akan dikirimkan secara susulan."
  },
  TipsType_PassportHoistTips2_Desc = {
    Text = "\"Waktu Mundur\"\n·Dapat kembali ke putaran yang sudah dilalui dalam pertempuran.\n·Dapat kembali ke salah satu dari 25 putaran sebelumnya dalam pertempuran.\n·Setelah tantangan kembali, masih bisa menggunakan fungsi mundur untuk kembali ke putaran sebelumnya."
  },
  TipsType_PassportHoistTips3_Desc = {
    Text = "\"Traphase\"\n· Setelah dibuka, selama periode topik saat ini, semua kartu \"Traphase\" dapat digunakan."
  },
  TipsType_Password_CopiedTips_Desc = {
    Text = "<color=#5EF2FF>Nilai fase</color> telah disalin ke papan klip"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_Desc = {
    Text = "Apakah ingin menggunakan<Blue:\"Perak utama\" × {s1} >untuk membeli?\n\n<size=30><color=#ACBFCA>Saat menggunakan \"Perak utama\", \"Perak utama\" bonus akan dikurangi terlebih dahulu.\n(Diekstrak: {s2}, Bonus: {s3})</color></size>"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_LeftBtnDesc = {Text = "Batal"},
  TipsType_PayMoneyBuyConfirmDescDetail_RightBtnDesc = {Text = "Membeli"},
  TipsType_PayMoneyBuyConfirmDescDetail_Title = {
    Text = "Konfirmasi Pembelian"
  },
  TipsType_PublishEmptyCommentTips_Desc = {
    Text = "Konten komentar tidak boleh kosong"
  },
  TipsType_PvpCollectionCommentDeleteTips_Desc = {
    Text = "Konfirmasi penghapusan komentar ini?"
  },
  TipsType_PvpCollectionCommentDeleteTips_LeftBtnDesc = {Text = "Batal"},
  TipsType_PvpCollectionCommentDeleteTips_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_PvpCollectionCommentDeleteTips_Title = {
    Text = "Konfirmasi Penghapusan"
  },
  TipsType_PvpHideCommentConfirm_Desc = {
    Text = "Apakah ingin menyembunyikan semua komentarnya?"
  },
  TipsType_PvpHideCommentConfirm_LeftBtnDesc = {Text = "Tidak"},
  TipsType_PvpHideCommentConfirm_RightBtnDesc = {Text = "Ya"},
  TipsType_PvpHideCommentConfirm_Title = {
    Text = "Menyembunyikan"
  },
  TipsType_PvpMatchingInterruptTips_Desc = {
    Text = "Terdeteksi jaringan tidak normal, pencocokan terputus."
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Desc = {
    Text = [[
Masih dalam pertarungan, apakah ingin melanjutkan pertarungan sebelumnya? 
 Musim "Kereta Kesukacitaan yang Melaju Kencang" telah diperbarui. Melanjutkan tantangan dapat menyelesaikan misi musim terbaru, tetapi tidak dapat memasuki "Daftar Tamu VIP".]]
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_LeftBtnDesc = {Text = "Batal"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Title = {Text = "Petunjuk"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Desc = {
    Text = "Progres tantangan terakhir adalah {s1} - Tahap {s2} - Pertarungan ke-{s3}, telah mendapatkan \"Poin Tamu VIP\" × {s4}\nMusim telah diperbarui. Melanjutkan tantangan dapat menyelesaikan misi musim terbaru, tetapi tidak dapat memasuki \"Daftar Tamu VIP\". Apakah ingin melanjutkan tantangan?"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_LeftBtnDesc = {Text = "Batal"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Title = {
    Text = "Lanjut Tantangan"
  },
  TipsType_RailWayContinueSaveStage_Desc = {
    Text = "Kemajuan tantangan terakhir adalah {s1} - Tahap ke-{s2} - Pertarungan ke-{s3}, telah mendapatkan\"Poin VIP\"× {s4}\nApakah Anda ingin melanjutkan tantangan?"
  },
  TipsType_RailWayContinueSaveStage_LeftBtnDesc = {Text = "Batal"},
  TipsType_RailWayContinueSaveStage_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_RailWayContinueSaveStage_Title = {
    Text = "Lanjut Tantangan"
  },
  TipsType_RailWayHaveSaveStage_Desc = {
    Text = "Perlu mengakhiri tantangan yang disimpan sebelumnya sebelum dapat melakukan tantangan baru"
  },
  TipsType_RailWaySaveAndExitInBattleTips_Desc = {
    Text = [[
Apakah Anda yakin ingin keluar dari tantangan?
Kemajuan tantangan kali ini akan disimpan, dan akan dilanjutkan pada tantangan berikutnya dengan kemajuan saat ini, serta mengulangi pertempuran ini.]]
  },
  TipsType_RailWaySaveAndExitInBattleTips_LeftBtnDesc = {Text = "Batal"},
  TipsType_RailWaySaveAndExitInBattleTips_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_RailWaySaveAndExitInBattleTips_Title = {
    Text = "Simpan dan Keluar"
  },
  TipsType_RailWaySaveAndExitTips_Desc = {
    Text = [[
Apakah Anda yakin ingin keluar dari tantangan?
Kemajuan tantangan kali ini akan disimpan, dan akan dilanjutkan pada tantangan berikutnya dengan kemajuan saat ini.]]
  },
  TipsType_RailWaySaveAndExitTips_LeftBtnDesc = {Text = "Batal"},
  TipsType_RailWaySaveAndExitTips_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_RailWaySaveAndExitTips_Title = {
    Text = "Simpan dan Keluar"
  },
  TipsType_RailWaySeasonSwitchTips_Desc = {
    Text = "Musim telah diperbarui. Melanjutkan tantangan dapat menyelesaikan misi musim terbaru, tetapi tidak dapat memasuki \"Daftar Tamu VIP\"."
  },
  TipsType_ReplayNullTips_Desc = {
    Text = "Informasi replay tidak boleh kosong"
  },
  TipsType_SchoolConflictTips_Desc = {
    Text = "Terdapat konflik Alam pada Pembangun dalam tim, silakan lakukan penyesuaian."
  },
  TipsType_SelectedAwakensAndCardsExceedLimit_Desc = {
    Text = "Melebihi jumlah yang dipilih"
  },
  TipsType_ServerRankDataLoading_Desc = {
    Text = "Data peringkat ini belum selesai dimuat, silakan buka kembali antarmuka nanti."
  },
  TipsType_ServerRankDataLoading_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_ServerRankDataLoading_Title = {
    Text = "Data papan peringkat server sedang diinisialisasi"
  },
  TipsType_ShopBulkBuyConfirm_Desc = {
    Text = "Akan menggunakan <Blue:{s1}> {s2}, menukar <Blue:{s3}> {s4}, apakah kamu yakin ingin melakukan penukaran?"
  },
  TipsType_ShopBulkBuyConfirm_LeftBtnDesc = {Text = "Batal"},
  TipsType_ShopBulkBuyConfirm_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_ShopBulkBuyConfirm_Title = {
    Text = "Konfirmasi Penukaran"
  },
  TipsType_SocialRecordHideTips_Desc = {
    Text = "Catatan pertempuran disembunyikan"
  },
  TipsType_SteamOverlayEnabledTips_Desc = {
    Text = "Harap aktifkan opsi \"Aktifkan Steam Overlay saat dalam game\" di Steam \"Pengaturan-Dalam Game\" dan \"Properti-Umum\" game ini, lalu restart game dan coba lagi."
  },
  TipsType_SteamOverlayEnabledTips_LeftBtnDesc = {Text = "Konfirmasi"},
  TipsType_SteamOverlayEnabledTips_Title = {
    Text = "Tips yang berguna"
  },
  TipsType_SteamRestartTips_Desc = {
    Text = "Otorisasi Steam tidak normal, harap mulai ulang klien Steam lalu coba lagi"
  },
  TipsType_SteamRestartTips_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_SteamRestartTips_Title = {
    Text = "Login Tidak Normal"
  },
  TipsType_SubBestExperienceTips_Chapter3_Desc = {
    Text = "Untuk memastikan pengalaman cerita terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_SubBestExperienceTips_Chapter3_LeftBtnDesc = {Text = "Keluar"},
  TipsType_SubBestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_SubBestExperienceTips_Chapter3_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_SubBestExperienceTips_Chapter5_Desc = {
    Text = "Untuk memastikan pengalaman cerita terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_SubBestExperienceTips_Chapter5_LeftBtnDesc = {Text = "Keluar"},
  TipsType_SubBestExperienceTips_Chapter5_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_SubBestExperienceTips_Chapter5_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Desc = {
    Text = "Untuk memastikan pengalaman cerita terbaik, disarankan untuk menyelesaikan level penyelidikan berikut."
  },
  TipsType_SubBestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "Keluar"},
  TipsType_SubBestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "Tetap ingin melakukan Penyelidikan"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Title = {
    Text = "Konfirmasi Penyelidikan"
  },
  TipsType_SummonFailureTips_Desc = {
    Text = "Informasi material konsumsi pemanggilan telah berubah, silakan lakukan pemanggilan ulang"
  },
  TipsType_SummonPriorityNotEnoughTips_Desc = {
    Text = "Kurang {s1} buah <Blue:\"{s2}\">, apakah ingin menggunakan <Blue:\"{s4}\"×{s3} >sebagai gantinya?"
  },
  TipsType_SummonPriorityNotEnoughTips_LeftBtnDesc = {Text = "Batal"},
  TipsType_SummonPriorityNotEnoughTips_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_SummonPriorityNotEnoughTips_Title = {
    Text = "Konfirmasi Penukaran"
  },
  TipsType_SummonType_14SelectConfirm_BottomDesc = {
    Text = "<Blue:Perhatian: Setelah dipilih, acara ini tidak dapat diubah lagi!>"
  },
  TipsType_SummonType_14SelectConfirm_Desc = {
    Text = "Apakah anda yakin memilih Pembangun<OrangeQuality:\"{s1}\".\"{s2}\".\"{s3}\".\"{s4}\"> sebagai peningkatan terarah untuk acara ini?"
  },
  TipsType_SummonType_14SelectConfirm_LeftBtnDesc = {Text = "Batal"},
  TipsType_SummonType_14SelectConfirm_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_SummonType_14SelectConfirm_Title = {
    Text = "Konfirmasi Pilihan"
  },
  TipsType_SummonType_14SelectLimitTips_BottomDesc = {
    Text = "<Blue:Perhatian: Setelah dipilih, acara ini tidak dapat diubah lagi!>"
  },
  TipsType_SummonType_14SelectLimitTips_Desc = {
    Text = "Jumlah pilihan telah mencapai batas maksimum"
  },
  TipsType_SummonType_17IncompleteSelectionTips_Desc = {
    Text = "Harap selesaikan semua jenis pilihan terlebih dahulu sebelum mencoba"
  },
  TipsType_SummonType_17SelectConfirm_Desc = {
    Text = [[
Konfirmasi penyelesaian pilihan Awakener yang ditentukan periode ini?
Setelah dikonfirmasi, pilihan periode ini tidak dapat diubah lagi.]]
  },
  TipsType_SummonType_17SelectConfirm_LeftBtnDesc = {Text = "Batal"},
  TipsType_SummonType_17SelectConfirm_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_SummonType_17SelectConfirm_Title = {
    Text = "Konfirmasi Pilihan"
  },
  TipsType_SupportListLatestTips_Desc = {
    Text = "Sudah dalam Negara terbaru, segera ikuti lebih banyak teman sekolah untuk mendapatkan lebih banyak pilihan Bantuan Bertarung!"
  },
  TipsType_TrinketAutoRefineExitTips_Desc = {
    Text = "Transkripsi otomatis sedang berlangsung, tidak dapat melakukan operasi."
  },
  TipsType_TrinketAutoRefineTips_BottomDesc = {
    Text = "(Transkripsi otomatis berhenti saat satu atribut yang tidak di-Lock-On mencapai intensitas 8.)"
  },
  TipsType_TrinketAutoRefineTips_Desc = {
    Text = [[
Maks. transkripsi {s1} kali
Maks. konsumsi]]
  },
  TipsType_TrinketAutoRefineTips_LeftBtnDesc = {Text = "Batal"},
  TipsType_TrinketAutoRefineTips_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_TrinketAutoRefineTips_Title = {
    Text = "Konfirmasi Transkripsi Otomatis"
  },
  TipsType_TrinketBagFullTips_Desc = {
    Text = "Tas Covenant sudah penuh"
  },
  TipsType_TrinketBatchUnbindTips_Desc = {
    Text = "Apakah ingin melepas semua Covenant?"
  },
  TipsType_TrinketBatchUnbindTips_LeftBtnDesc = {Text = "Batal"},
  TipsType_TrinketBatchUnbindTips_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_TrinketBatchUnbindTips_Title = {
    Text = "Konfirmasi Pelepasan"
  },
  TipsType_TrinketBindSaveTips_Desc = {
    Text = "Terdapat Covenant yang sedang dikombinasikan, tidak dapat disimpan sebagai skema!"
  },
  TipsType_TrinketBindTips_Desc = {
    Text = "Konfirmasi penggabungan Covenant berikut? Covenant yang sudah dipakai oleh Awakener lain atau ada dalam tim/skema/bantuan akan dilepas secara otomatis."
  },
  TipsType_TrinketBindTips_LeftBtnDesc = {Text = "Batal"},
  TipsType_TrinketBindTips_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_TrinketBindTips_Title = {
    Text = "Konfirmasi Penggabungan"
  },
  TipsType_TrinketChangeBindTips_Desc = {
    Text = "Konfirmasi ubah kombinasi?"
  },
  TipsType_TrinketChangeBindTips_LeftBtnDesc = {Text = "Batal"},
  TipsType_TrinketChangeBindTips_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_TrinketChangeBindTips_Title = {
    Text = "Konfirmasi Ubah Kombinasi"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_Desc = {
    Text = [[
Apakah ingin melepas semua Covenant?

<color=#9BA3A2><size=30>Material yang dipilih mengandung komponen Covenant +12.</size></color>]]
  },
  TipsType_TrinketHighLevelBatchUnbindTips_LeftBtnDesc = {Text = "Batal"},
  TipsType_TrinketHighLevelBatchUnbindTips_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_TrinketHighLevelBatchUnbindTips_Title = {
    Text = "Konfirmasi Pelepasan"
  },
  TipsType_TrinketHighLevelChangeBindTips_Desc = {
    Text = [[
Konfirmasi perubahan kombinasi?

<color=#9BA3A2><size=30>Material yang dipilih mengandung komponen Covenant +12.</size></color>]]
  },
  TipsType_TrinketHighLevelChangeBindTips_LeftBtnDesc = {Text = "Batal"},
  TipsType_TrinketHighLevelChangeBindTips_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_TrinketHighLevelChangeBindTips_Title = {
    Text = "Konfirmasi Ubah Kombinasi"
  },
  TipsType_TrinketHighLevelUnbindTips_Desc = {
    Text = [[
Konfirmasi pelepasan Covenant ini?

<color=#9BA3A2><size=30>Material yang dipilih mengandung komponen Covenant +12.</size></color>]]
  },
  TipsType_TrinketHighLevelUnbindTips_LeftBtnDesc = {Text = "Batal"},
  TipsType_TrinketHighLevelUnbindTips_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_TrinketHighLevelUnbindTips_Title = {
    Text = "Konfirmasi Pelepasan"
  },
  TipsType_TrinketUnbindTips_Desc = {
    Text = "Konfirmasi pelepasan Covenant ini?"
  },
  TipsType_TrinketUnbindTips_LeftBtnDesc = {Text = "Batal"},
  TipsType_TrinketUnbindTips_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_TrinketUnbindTips_Title = {
    Text = "Konfirmasi Pelepasan"
  },
  TipsType_TryAgainLaterTips_Desc = {
    Text = "<color=#5EF2FF>Nilai fase</color> ini sedang digunakan, silakan coba lagi nanti"
  },
  TipsType_WaitOppositeSideAccept_Desc = {
    Text = [[
Sedang menunggu
{s1}
untuk menerima undangan <Blue:{s2}>]]
  },
  TipsType_WaitOppositeSideAccept_LeftBtnDesc = {Text = "Batal"},
  TipsType_WaitOppositeSideAccept_Title = {
    Text = "Pertempuran Kata Sandi"
  },
  TipsType_WaitOthersEnter_Desc = {
    Text = [[
Sedang menunggu penjaga lainnya untuk memasukkan
 <Blue:{s1}>
 mencocokkan pertarungan sandi]]
  },
  TipsType_WaitOthersEnter_LeftBtnDesc = {Text = "Batal"},
  TipsType_WaitOthersEnter_RightBtnDesc = {
    Text = "Salin <color=#5EF2FF>Nilai Fase</color>"
  },
  TipsType_WaitOthersEnter_Title = {
    Text = "Pertempuran Kata Sandi"
  },
  TipsType_WeaponRandomChestConfirm_Desc = {
    Text = "Konfirmasi menggunakan <Blue:{s1}> untuk mendapatkan 1 Roda takdir <Blue:acak>?"
  },
  TipsType_WeaponRandomChestConfirm_LeftBtnDesc = {Text = "Batal"},
  TipsType_WeaponRandomChestConfirm_RightBtnDesc = {Text = "Konfirmasi"},
  TipsType_WeaponRandomChestConfirm_Title = {
    Text = "Konfirmasi Penggunaan"
  },
  TipsType_WeekChallengeSweepTips_Desc = {
    Text = "Jumlah pengambilan hadiah minggu ini telah habis, tidak dapat melakukan reproduksi."
  }
})
return Text_TipsType
