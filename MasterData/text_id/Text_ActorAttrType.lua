__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ActorAttrType = readonly({
  ActorAttrType_121209_AttributeDesc = {
    Text = "Level Pengetahuan Terlarang sama dengan level Penjaga Rahasia, menentukan efek dari 3 jenis kedalaman penelitian berikut. Jika level rata-rata Awakened dalam formasi lebih besar atau sama dengan level Penjaga Rahasia, maka Level Pengetahuan Terlarang mengambil nilai rata-rata dari level rata-rata Awakened dalam formasi dan level Penjaga Rahasia.\nKedalaman Penelitian Organisme Hidup: <Blue:{s1}>\n·Menentukan kekuatan efek konversi setiap 100 poin atribut Konstitusi Awakened menjadi HP tim.\nKedalaman Penelitian Fenomena Fisik: <Blue:{s2}>\n·Menentukan kekuatan efek Kekuatan, Damage Tentakel, Perisai, Pemulihan HP, dan Pengurangan Kekuatan yang disebabkan oleh Ciptaan, Prasasti, dan Perintah Kunci.\nKedalaman Penelitian Persepsi Spiritual: <Blue:{s3}>\n·Menentukan kekuatan efek Racun Tetap, Serangan Balik Tetap, Damage Tetap, dan Pendarahan Tetap yang disebabkan oleh Ciptaan, Prasasti, dan Perintah Kunci.\n"
  },
  ActorAttrType_121209_Text = {
    Text = "Level Pengetahuan Terlarang"
  },
  ActorAttrType_18103_Text = {
    Text = "Perisai Karakter"
  },
  ActorAttrType_18104_Text = {
    Text = "Koreksi Persentase Kerusakan Kartu Pukulan"
  },
  ActorAttrType_18105_AttributeUpText = {
    Text = "Crit. DMG+{s1}"
  },
  ActorAttrType_18105_Text = {Text = "Crit. DMG"},
  ActorAttrType_18106_Text = {
    Text = "Perisai ditingkatkan"
  },
  ActorAttrType_18107_AttributeUpText = {Text = "ATK+{s1}"},
  ActorAttrType_18107_Text = {Text = "ATK"},
  ActorAttrType_18108_Text = {Text = "CON"},
  ActorAttrType_18109_Text = {
    Text = "Penyesuaian Persentase Kerusakan Kartu"
  },
  ActorAttrType_18110_Text = {
    Text = "Penyesuaian Persentase Kerapuhan"
  },
  ActorAttrType_18111_Text = {
    Text = "Penyesuaian Persentase Perisai yang Diterima"
  },
  ActorAttrType_18112_AttributeUpText = {Text = "DEF+{s1}"},
  ActorAttrType_18112_Text = {
    Text = "DEF ditingkatkan"
  },
  ActorAttrType_18113_AttributeDesc = {
    Text = "Efisiensi Pembangun dalam mengisi ulang Aliemus"
  },
  ActorAttrType_18113_Text = {
    Text = "Aliemus Awal"
  },
  ActorAttrType_18114_AttributeDesc = {
    Text = [[
Semakin tinggi konstitusi, semakin tinggi kesehatan maksimum Pembangun. 
 Semakin tinggi level penyelidikan Penjaga, semakin kuat pengaruh konstitusi terhadap kesehatan maksimum Pembangun.]]
  },
  ActorAttrType_18114_AttributeUpText = {Text = "CON+{s1}"},
  ActorAttrType_18114_Text = {Text = "CON"},
  ActorAttrType_18115_AttributeDesc = {
    Text = "Setelah Pembangun melepaskan Genesis dan Kedatangan, nilai Aliemus akan dikembalikan."
  },
  ActorAttrType_18115_AttributeUpText = {
    Text = "Aliemus Lelah Berkurang +{s1}"
  },
  ActorAttrType_18115_Text = {
    Text = "Pengurangan Konsumsi Aliemus"
  },
  ActorAttrType_18116_AttributeDesc = {
    Text = [[
Semakin tinggi konstitusi, semakin tinggi kesehatan maksimum Pembangun. 
 Semakin tinggi level penyelidikan Penjaga, semakin kuat pengaruh konstitusi terhadap kesehatan maksimum Pembangun.]]
  },
  ActorAttrType_18116_AttributeUpText = {Text = "CON+{s1}"},
  ActorAttrType_18116_Text = {
    Text = "Peningkatan Konstitusi"
  },
  ActorAttrType_18117_Text = {
    Text = "Kerusakan tentakel"
  },
  ActorAttrType_18118_Text = {
    Text = "Ultra Slots"
  },
  ActorAttrType_18119_Text = {
    Text = "Perbaikan Persentase Kerusakan Diterima"
  },
  ActorAttrType_18120_AttributeDesc = {
    Text = "Aliemus maksimum yang dapat dikumpulkan oleh Pembangun dan Aliemus yang dikonsumsi saat melepaskan Exalt sama dengan Aliemus Dasar."
  },
  ActorAttrType_18120_AttributeUpText = {
    Text = "Batas Aliemus +{s1}"
  },
  ActorAttrType_18120_Text = {
    Text = "Aliemus Dasar"
  },
  ActorAttrType_18121_AttributeDesc = {
    Text = "Tingkat Keterampilan 2"
  },
  ActorAttrType_18121_AttributeUpText = {
    Text = "Keterampilan 2 level +{s1}"
  },
  ActorAttrType_18121_Text = {
    Text = "Tingkat Keterampilan 2"
  },
  ActorAttrType_18122_AttributeDesc = {
    Text = "Tingkat Pertahanan"
  },
  ActorAttrType_18122_AttributeUpText = {
    Text = "Pertahanan +{s1}"
  },
  ActorAttrType_18122_Text = {
    Text = "Tingkat Pertahanan"
  },
  ActorAttrType_18123_Text = {
    Text = "Penyesuaian nilai tetap jumlah kerusakan"
  },
  ActorAttrType_18124_Text = {
    Text = "Menyebabkan modifikasi nilai tetap perisai"
  },
  ActorAttrType_18125_Text = {
    Text = "Pembenaran Nilai Perisai Tetap"
  },
  ActorAttrType_18126_AttributeDesc = {
    Text = "Penguasaan Alam tim sama dengan jumlah Penguasaan Alam dari semua Pembangun dalam tim. Penguasaan Alam dapat meningkatkan efek bakat Alam tim. Jika tim saat ini adalah \"Aequor Murni/Caro Murni/Ultra Murni\", efek Penguasaan Alam akan berlipat ganda.\n·<Blue:Chaos> Setiap 1 poin Penguasaan Alam di tim dengan Alam ini, setelah melepaskan Posse, semua Pembangun akan mendapatkan tambahan <Blue:0.05> poin Aliemus.\n·<Blue:Aequor> Setiap 1 poin Penguasaan Alam di tim dengan Alam ini, setelah melepaskan Exalt, ada <Blue:0.25％> kemungkinan mendapatkan 1 lapisan Pertemuan Tentakel tambahan(kemungkinan di atas 100% dapat memperoleh beberapa lapisan), saat beralih ke \"Lautan Tenang\", perisai yang didapat meningkat <Blue:0.01％> dari Max HP, dan kerusakan tentakel yang dipicu oleh serangan aktif dalam \"Ombak Bergelora\" meningkat <Blue:0.02%>.\n·<Blue:Caro> Setiap 1 poin Penguasaan Alam di tim dengan Alam ini, setiap kali memicu Devour untuk pertama kalinya setiap putaran, akan mendapatkan tambahan perisai sebesar <Blue:0.01%> dari Max HP dan <Blue:0.005%> dari Kekuatan Sementara(meningkat seiring dengan kehilangan HP, maksimal meningkat 100%).\n·<Blue:Ultra> Setiap 1 poin Penguasaan Alam di tim dengan Alam ini, pada awal ronde ada <Blue:0.125%> kemungkinan mendapatkan 1 kartu \"Ilham\"(kemungkinan di atas 100% dapat memperoleh beberapa kartu)."
  },
  ActorAttrType_18126_AttributeUpText = {
    Text = "Penguasaan Alam +{s1}"
  },
  ActorAttrType_18126_Text = {
    Text = "Realm Mastery"
  },
  ActorAttrType_18127_Text = {Text = "HP"},
  ActorAttrType_18128_AttributeUpText = {Text = "ATK+{s1}"},
  ActorAttrType_18128_Text = {
    Text = "ATK ditingkatkan"
  },
  ActorAttrType_18129_AttributeDesc = {
    Text = "Semakin tinggi bonus kerusakan dasar, semakin tinggi kerusakan yang ditimbulkan oleh Bangun."
  },
  ActorAttrType_18129_AttributeUpText = {
    Text = "Kerusakan Dasar +{s1}"
  },
  ActorAttrType_18129_Text = {
    Text = "Kerusakan Dasar"
  },
  ActorAttrType_18130_Text = {Text = "Tingkat"},
  ActorAttrType_18131_AttributeDesc = {
    Text = "Pada akhir ronde, nilai Aliemus yang dipulihkan secara otomatis oleh Pembangun (dalam mode Topik, nilai Aliemus dipulihkan setelah setiap tindakan Pembangun)."
  },
  ActorAttrType_18131_AttributeUpText = {
    Text = "Aliemus otomatis balas +{s1}"
  },
  ActorAttrType_18131_Text = {
    Text = "Aliemus Balasan Otomatis"
  },
  ActorAttrType_18132_Text = {
    Text = "Enlighten Level"
  },
  ActorAttrType_18133_Text = {
    Text = "Pengaturan Persentase Menerima Aliemus"
  },
  ActorAttrType_18134_Text = {
    Text = "Batas Fusi Embrio"
  },
  ActorAttrType_18135_Text = {
    Text = "Karakter saat ini Aliemus"
  },
  ActorAttrType_18136_Text = {
    Text = "Pembenaran Nilai Tetap Kerusakan yang Diterima"
  },
  ActorAttrType_18137_AttributeDesc = {
    Text = "Ketika Pembangun memberikan Perisai dan Efek pemulihan, tingkatkan proporsi nilai Perisai dan nilai pemulihan."
  },
  ActorAttrType_18137_AttributeUpText = {
    Text = "Perisai dan sembuh kuat +{s1}"
  },
  ActorAttrType_18137_Text = {
    Text = "Perisai dan Sembuh Kuat"
  },
  ActorAttrType_18138_Text = {
    Text = "Sembuh ditingkatkan"
  },
  ActorAttrType_18139_AttributeDesc = {
    Text = "Saat play Kartu perintah atau Rouse, setiap 1 Arithmetica yang dikonsumsi menghasilkan {s1} poin Keyflare. Seiring peningkatan atribut ini, tambahan Keyflare yang diperoleh akan berangsur-angsur berkurang."
  },
  ActorAttrType_18139_AttributeUpText = {
    Text = "Isi ulang kunci perak+{s1}"
  },
  ActorAttrType_18139_Text = {
    Text = "Tingkat Muatan Kunci Perak"
  },
  ActorAttrType_18140_Text = {
    Text = "Jumlah Ketahanan"
  },
  ActorAttrType_18141_AttributeDesc = {
    Text = "Tingkat Pukulan"
  },
  ActorAttrType_18141_AttributeUpText = {
    Text = "Tingkat Pukulan+{s1}"
  },
  ActorAttrType_18141_Text = {
    Text = "Tingkat Pukulan"
  },
  ActorAttrType_18142_AttributeDesc = {
    Text = "Persentase meningkatkan \"Kerusakan Dasar\" yang diberikan oleh semua \"Pembangun\", lapisan \"Racun Nilai Tetap\" dan \"Counter Nilai Tetap\" yang diterapkan, serta \"Kerusakan Tentakel Awal\" dari Alam laut dalam."
  },
  ActorAttrType_18142_AttributeUpText = {
    Text = "Kerusakan Kuat +{s1}"
  },
  ActorAttrType_18142_Text = {
    Text = "DMG Amplification"
  },
  ActorAttrType_18143_Text = {
    Text = "Penyesuaian Persentase Kerusakan Muliakan"
  },
  ActorAttrType_18144_AttributeDesc = {
    Text = "Ketika Pembangun menyebabkan kerusakan aktif, peluang untuk menahan serangan kritis"
  },
  ActorAttrType_18144_AttributeUpText = {
    Text = "Resistensi Kritis +{s1}"
  },
  ActorAttrType_18144_Text = {
    Text = "Crit. Resistance"
  },
  ActorAttrType_18145_AttributeDesc = {
    Text = "Level Kedatangan Genesis"
  },
  ActorAttrType_18145_AttributeUpText = {
    Text = "Genesis Kedatangan Level +{s1}"
  },
  ActorAttrType_18145_Text = {
    Text = "Level Kedatangan Genesis"
  },
  ActorAttrType_18146_Text = {
    Text = "Pembenaran Nilai Tetap Penyembuhan"
  },
  ActorAttrType_18147_AttributeUpText = {
    Text = "Tingkat Orison Keberuntungan+{s1}"
  },
  ActorAttrType_18147_Text = {
    Text = "Tingkat Orison Beruntung"
  },
  ActorAttrType_18148_Text = {
    Text = "Menyebabkan penyesuaian nilai sembuh tetap"
  },
  ActorAttrType_18149_Text = {
    Text = "Peningkatan Konstitusi"
  },
  ActorAttrType_18150_Text = {
    Text = "Penyesuaian Persentase Kelemahan"
  },
  ActorAttrType_18151_AttributeDesc = {
    Text = [[
Ketahanan kematian tim sama dengan jumlah ketahanan kematian dari Awakener dalam tim. 
 Saat menerima kerusakan fatal dalam Pertempuran, ada kemungkinan untuk mempertahankan 1 poin HP, setelah terpicu, pada putaran berikutnya akan mendapatkan tambahan 2 poin Arithmetica dan menarik 2 kartu, ketahanan kematian yang diperoleh saat ini dan seterusnya berkurang setengah, berlangsung hingga akhir Penyelidikan.]]
  },
  ActorAttrType_18151_AttributeUpText = {
    Text = "Ketahanan+{s1}"
  },
  ActorAttrType_18151_Text = {Text = "Ketahanan"},
  ActorAttrType_18152_Text = {
    Text = "Menyebabkan Koreksi Persentase Aliemus"
  },
  ActorAttrType_18154_Text = {
    Text = "Batasan Tentakel"
  },
  ActorAttrType_18155_AttributeDesc = {
    Text = "Persentase meningkatkan drop Segil hitam musuh setelah kemenangan pertempuran."
  },
  ActorAttrType_18155_AttributeUpText = {
    Text = "Segil hitam jatuh + {s1}"
  },
  ActorAttrType_18155_Text = {
    Text = "Sigil Yield"
  },
  ActorAttrType_18156_Text = {
    Text = "Menerima Koreksi Nilai Tetap Aliemus"
  },
  ActorAttrType_18157_Text = {
    Text = "Hidden Intentions"
  },
  ActorAttrType_18158_Text = {
    Text = "Penyesuaian Nilai Tetap Kerusakan"
  },
  ActorAttrType_18159_AttributeUpText = {
    Text = "Crit. Rate+{s1}"
  },
  ActorAttrType_18159_Text = {Text = "Crit. Rate"},
  ActorAttrType_18160_AttributeDesc = {
    Text = "Tingkat Keterampilan 1"
  },
  ActorAttrType_18160_AttributeUpText = {
    Text = "Keterampilan 1 level +{s1}"
  },
  ActorAttrType_18160_Text = {
    Text = "Tingkat Keterampilan 1"
  },
  ActorAttrType_18161_Text = {Text = "Tingkat"},
  ActorAttrType_18162_Text = {
    Text = "Kerusakan ditingkatkan"
  },
  ActorAttrType_18163_Text = {
    Text = "Tentacle Count"
  },
  ActorAttrType_18164_Text = {
    Text = "Pemodifikasi Persentase Sembuh Diterima"
  },
  ActorAttrType_18165_Text = {
    Text = "Max Arithmetica"
  },
  ActorAttrType_18166_Text = {
    Text = "Penyesuaian Persentase Rentan"
  },
  ActorAttrType_18167_AttributeUpText = {Text = "DEF+{s1}"},
  ActorAttrType_18167_Text = {Text = "DEF"},
  ActorAttrType_18168_AttributeDesc = {
    Text = "Tingkat Membangkitkan Gnosis"
  },
  ActorAttrType_18168_AttributeUpText = {
    Text = "Level Membangkitkan + {s1}"
  },
  ActorAttrType_18168_Text = {
    Text = "Tingkat Membangkitkan Gnosis"
  },
  ActorAttrType_21322_Text = {
    Text = "Keyflare Regen"
  },
  ActorAttrType_22207_AttributeDesc = {
    Text = "Setiap kali melepaskan Muliakan, kamu akan memperoleh {s1} poin Aliemus. Seiring dengan peningkatan atribut ini, efek bonus tambahan akan berkurang secara bertahap."
  },
  ActorAttrType_22207_AttributeUpText = {
    Text = "Aliemus pengisian ulang level +{s1}"
  },
  ActorAttrType_22207_Text = {
    Text = "Tingkat Recharge Aliemus"
  },
  ActorAttrType_22214_Text = {
    Text = "Pengisian Aliemus"
  }
})
return Text_ActorAttrType
