__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_RelicConfig = readonly({
  RelicConfig_100300_BattleDesc = {
    Text = "Memperoleh 1 lapisan \"<MindWall:Penghalang Pikiran>\" setelah pertarungan dimulai, dan mengubahnya menjadi \"<BarrierCrash:Penghancur Penghalang>\" setelah 3 giliran."
  },
  RelicConfig_100300_Desc = {
    Text = "Memperoleh 1 lapisan \"<MindWall:Penghalang Pikiran>\" setelah pertarungan dimulai, dan mengubahnya menjadi \"<BarrierCrash:Penghancur Penghalang>\" setelah 3 giliran."
  },
  RelicConfig_100300_Name = {
    Text = "Analisis jiwa"
  },
  RelicConfig_100300_StoryDesc = {
    Text = "Perhatikan hatimu dengan seksama, jangan membuat pilihan yang salah."
  },
  RelicConfig_100399_BattleDesc = {
    Text = "Setelah efek <DevouredIconKeywords:Melahap> dipicu, Pembangun lain mendapatkan [Arg1] poin Aliemus, hanya dapat terjadi sekali per putaran."
  },
  RelicConfig_100399_Desc = {
    Text = "Setelah efek <DevouredIconKeywords:Melahap> dipicu, Pembangun lain mendapatkan [Arg1] poin Aliemus, hanya dapat terjadi sekali per putaran."
  },
  RelicConfig_100399_Name = {
    Text = "<OrangeQuality:Mimpi Emas Ciptaan+>"
  },
  RelicConfig_100399_StoryDesc = {
    Text = "Hari metamorfosis adalah hari kematianmu."
  },
  RelicConfig_100400_BattleDesc = {
    Text = "Pada akhir ronde, pulihkan [Heal:Arg1] Hidup."
  },
  RelicConfig_100400_Desc = {
    Text = "Pada akhir ronde, pulihkan [Heal:Arg1] Hidup."
  },
  RelicConfig_100400_Name = {
    Text = "<OrangeQuality:Darah Anugerah Ciptaan+>"
  },
  RelicConfig_100400_StoryDesc = {
    Text = "Rasanya manis dan lembut, dengan aroma mawar yang khas."
  },
  RelicConfig_100401_BattleDesc = {
    Text = "Mendapatkan [Arg1]% dari jumlah kehilangan hidup sebagai Dapur Merah saat kehilangan kehidupan."
  },
  RelicConfig_100401_Desc = {
    Text = "Mendapatkan [Arg1]% dari jumlah kehilangan hidup sebagai Dapur Merah saat kehilangan kehidupan."
  },
  RelicConfig_100401_Name = {
    Text = "<OrangeQuality:Gergaji Baja Berkarat Ciptaan+>"
  },
  RelicConfig_100401_StoryDesc = {
    Text = "Dokter anatomi seumur hidup tidak pernah melihat wanita cantik, hanya ada karung tulang, saraf yang meradang karena penyakit, otot, dan jaringan."
  },
  RelicConfig_100402_BattleDesc = {
    Text = "Saat dipungut, memberi semua musuh [Arg1] lapis <VulnerabilityIconKeywords:Rentan>. Meningkatkan Kerusakan dasar yang dihasilkan semua Pembangun sebesar [Arg2]%."
  },
  RelicConfig_100402_Desc = {
    Text = "Saat dipungut, memberi semua musuh [Arg1] lapis <VulnerabilityIconKeywords:Rentan>. Meningkatkan Kerusakan dasar yang dihasilkan semua Pembangun sebesar [Arg2]%."
  },
  RelicConfig_100402_Name = {
    Text = "<WhiteQuality:Persembahan Musim Semi Ciptaan>"
  },
  RelicConfig_100402_StoryDesc = {
    Text = "Di tengah tawa malam, siluet perahu dayung meluncur dengan leluasa di permukaan danau."
  },
  RelicConfig_100404_BattleDesc = {
    Text = "Setelah melepaskan \"Muliakan\", dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_100404_Desc = {
    Text = "Setelah melepaskan \"Muliakan\", dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_100404_Name = {
    Text = "<WhiteQuality:Gembok Berat Ciptaan>"
  },
  RelicConfig_100404_StoryDesc = {
    Text = [[
Gembok yang tebal dan kokoh, tanpa kunci, sepertinya akan sulit dibuka. 
Tentu saja, bagi pencuri ulung, ini bukan masalah besar.]]
  },
  RelicConfig_100405_BattleDesc = {
    Text = "Saat dipungut, memberi semua musuh [Arg1] lapis <WeaknessIconKeywords:Kelemahan>. Meningkatkan Kerusakan dasar yang dihasilkan semua Pembangun sebesar [Arg2]%."
  },
  RelicConfig_100405_Desc = {
    Text = "Saat dipungut, memberi semua musuh [Arg1] lapis <WeaknessIconKeywords:Kelemahan>. Meningkatkan Kerusakan dasar yang dihasilkan semua Pembangun sebesar [Arg2]%."
  },
  RelicConfig_100405_Name = {
    Text = "<WhiteQuality:Anak Nakal Ciptaan>"
  },
  RelicConfig_100405_StoryDesc = {
    Text = "Terlahir dari kejahatan murni, meskipun itu bukanlah keinginannya."
  },
  RelicConfig_100406_BattleDesc = {
    Text = "Setelah efek <DevouredIconKeywords:Melahap> dipicu, Pembangun lain mendapatkan [Arg1] poin Aliemus, hanya dapat terjadi sekali per putaran."
  },
  RelicConfig_100406_Desc = {
    Text = "Setelah efek <DevouredIconKeywords:Melahap> dipicu, Pembangun lain mendapatkan [Arg1] poin Aliemus, hanya dapat terjadi sekali per putaran."
  },
  RelicConfig_100406_Name = {
    Text = "<WhiteQuality:Mimpi Emas Ciptaan>"
  },
  RelicConfig_100406_StoryDesc = {
    Text = "Hari metamorfosis adalah hari kematianmu."
  },
  RelicConfig_100407_BattleDesc = {
    Text = "Setiap kali memberikan kerusakan, dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara. Maksimal terpicu 15 kali per ronde."
  },
  RelicConfig_100407_Desc = {
    Text = "Setiap kali memberikan kerusakan, dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara. Maksimal terpicu 15 kali per ronde."
  },
  RelicConfig_100407_Name = {
    Text = "<WhiteQuality:Akik Berurat Ciptaan>"
  },
  RelicConfig_100407_StoryDesc = {
    Text = "Seharusnya hanya pola akik biasa. Mungkin."
  },
  RelicConfig_100408_BattleDesc = {
    Text = "Setelah melepaskan \"Muliakan\", dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_100408_Desc = {
    Text = "Setelah melepaskan \"Muliakan\", dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_100408_Name = {
    Text = "<OrangeQuality:Gembok Berat Ciptaan+>"
  },
  RelicConfig_100408_StoryDesc = {
    Text = [[
Gembok yang tebal dan kokoh, tanpa kunci, sepertinya akan sulit dibuka. 
Tentu saja, bagi pencuri ulung, ini bukan masalah besar.]]
  },
  RelicConfig_100409_BattleDesc = {
    Text = "Saat dipungut, memberi semua musuh [Arg1] lapis <WeaknessIconKeywords:Kelemahan>. Meningkatkan Kerusakan dasar yang dihasilkan semua Pembangun sebesar [Arg2]%."
  },
  RelicConfig_100409_Desc = {
    Text = "Saat dipungut, memberi semua musuh [Arg1] lapis <WeaknessIconKeywords:Kelemahan>. Meningkatkan Kerusakan dasar yang dihasilkan semua Pembangun sebesar [Arg2]%."
  },
  RelicConfig_100409_Name = {
    Text = "<OrangeQuality:Anak Nakal Ciptaan+>"
  },
  RelicConfig_100409_StoryDesc = {
    Text = "Terlahir dari kejahatan murni, meskipun itu bukanlah keinginannya."
  },
  RelicConfig_100410_BattleDesc = {
    Text = "Setiap kali memberikan kerusakan, dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara. Maksimal terpicu 15 kali per ronde."
  },
  RelicConfig_100410_Desc = {
    Text = "Setiap kali memberikan kerusakan, dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara. Maksimal terpicu 15 kali per ronde."
  },
  RelicConfig_100410_Name = {
    Text = "<OrangeQuality:Akik Berurat Ciptaan+>"
  },
  RelicConfig_100410_StoryDesc = {
    Text = "Seharusnya hanya pola akik biasa. Mungkin."
  },
  RelicConfig_100411_BattleDesc = {
    Text = "Saat dipungut, memberi semua musuh [Arg1] lapis <VulnerabilityIconKeywords:Rentan>. Meningkatkan Kerusakan dasar yang dihasilkan semua Pembangun sebesar [Arg2]%."
  },
  RelicConfig_100411_Desc = {
    Text = "Saat dipungut, memberi semua musuh [Arg1] lapis <VulnerabilityIconKeywords:Rentan>. Meningkatkan Kerusakan dasar yang dihasilkan semua Pembangun sebesar [Arg2]%."
  },
  RelicConfig_100411_Name = {
    Text = "<OrangeQuality:Persembahan Musim Semi Ciptaan+>"
  },
  RelicConfig_100411_StoryDesc = {
    Text = "Di tengah tawa malam, siluet perahu dayung meluncur dengan leluasa di permukaan danau."
  },
  RelicConfig_100412_BattleDesc = {
    Text = "Pada akhir ronde, pulihkan [Heal:Arg1] Hidup."
  },
  RelicConfig_100412_Desc = {
    Text = "Pada akhir ronde, pulihkan [Heal:Arg1] Hidup."
  },
  RelicConfig_100412_Name = {
    Text = "<WhiteQuality:Darah Anugerah Ciptaan>"
  },
  RelicConfig_100412_StoryDesc = {
    Text = "Rasanya manis dan lembut, dengan aroma mawar yang khas."
  },
  RelicConfig_100413_BattleDesc = {
    Text = "Mendapatkan [Arg1]% dari jumlah kehilangan hidup sebagai Dapur Merah saat kehilangan kehidupan."
  },
  RelicConfig_100413_Desc = {
    Text = "Mendapatkan [Arg1]% dari jumlah kehilangan hidup sebagai Dapur Merah saat kehilangan kehidupan."
  },
  RelicConfig_100413_Name = {
    Text = "<WhiteQuality:Gergaji Baja Berkarat Ciptaan>"
  },
  RelicConfig_100413_StoryDesc = {
    Text = "Dokter anatomi seumur hidup tidak pernah melihat wanita cantik, hanya ada karung tulang, saraf yang meradang karena penyakit, otot, dan jaringan."
  },
  RelicConfig_100539_BattleDesc = {
    Text = "Setelah pertama kali menggunakan \"Embrio\" secara langsung setiap ronde, serangan aktif dalam ronde ini akan menyebabkan [Arg1]% kerusakan tambahan dalam jumlah yang sama dengan <BleedingIconKeywords:Berdarah>."
  },
  RelicConfig_100539_Desc = {
    Text = "Setelah pertama kali menggunakan \"Embrio\" secara langsung setiap ronde, serangan aktif dalam ronde ini akan menyebabkan [Arg1]% kerusakan tambahan dalam jumlah yang sama dengan <BleedingIconKeywords:Berdarah>."
  },
  RelicConfig_100539_Name = {
    Text = "<WhiteQuality:Batu Kali Berdarah Ciptaan>"
  },
  RelicConfig_100539_StoryDesc = {
    Text = "Satu, dua, tiga, empat, lima."
  },
  RelicConfig_100540_BattleDesc = {
    Text = "Setelah pertama kali menggunakan \"Embrio\" secara langsung setiap ronde, serangan aktif dalam ronde ini akan menyebabkan [Arg1]% kerusakan tambahan dalam jumlah yang sama dengan <BleedingIconKeywords:Berdarah>."
  },
  RelicConfig_100540_Desc = {
    Text = "Setelah pertama kali menggunakan \"Embrio\" secara langsung setiap ronde, serangan aktif dalam ronde ini akan menyebabkan [Arg1]% kerusakan tambahan dalam jumlah yang sama dengan <BleedingIconKeywords:Berdarah>."
  },
  RelicConfig_100540_Name = {
    Text = "<OrangeQuality:Batu Kali Berdarah Ciptaan+>"
  },
  RelicConfig_100540_StoryDesc = {
    Text = "Satu, dua, tiga, empat, lima."
  },
  RelicConfig_116382_BattleDesc = {
    Text = "Sekumpulan kunci yang berkarat. Dapat digunakan untuk membuka kunci pintu."
  },
  RelicConfig_116382_Desc = {
    Text = "Sekumpulan kunci yang berkarat. Dapat digunakan untuk membuka kunci pintu."
  },
  RelicConfig_116382_Name = {
    Text = "Kunci berkarat"
  },
  RelicConfig_116383_BattleDesc = {
    Text = "Sekumpulan kunci yang berkarat. Dapat digunakan untuk membuka kunci pintu."
  },
  RelicConfig_116383_Desc = {
    Text = "Sekumpulan kunci yang berkarat. Dapat digunakan untuk membuka kunci pintu."
  },
  RelicConfig_116383_Name = {
    Text = "Kunci berkarat"
  },
  RelicConfig_116384_BattleDesc = {
    Text = "Sekumpulan kunci yang berkarat. Dapat digunakan untuk membuka kunci pintu."
  },
  RelicConfig_116384_Desc = {
    Text = "Sekumpulan kunci yang berkarat. Dapat digunakan untuk membuka kunci pintu."
  },
  RelicConfig_116384_Name = {
    Text = "Kunci berkarat"
  },
  RelicConfig_119371_BattleDesc = {
    Text = [[
Batas hand +1.
Di awal giliran, jika semua ritual belum selesai, dapatkan 10% max hp <SacrificeKeyWord: Pengorbanan>. Letakkan 1 kartu"<DerivativeCardKeywords_119: penghormatan kepada Dewa>"ke dalam tanganmu, maksimal 1 kartu.]]
  },
  RelicConfig_119371_Desc = {
    Text = [[
Batas hand +1.
Di awal giliran, jika semua ritual belum selesai, dapatkan 10% max hp <SacrificeKeyWord: Pengorbanan>. Letakkan 1 kartu"<DerivativeCardKeywords_119: penghormatan kepada Dewa>"ke dalam tanganmu, maksimal 1 kartu.]]
  },
  RelicConfig_119371_Name = {
    Text = "Teko tembaga"
  },
  RelicConfig_119371_StoryDesc = {
    Text = "\"Saya telah membuat dupa ini dengan meniru kerajinan Lemuria, semoga ini dapat membantu Anda tidur nyenyak setiap malam. Myriam meninggalkan.\""
  },
  RelicConfig_120372_BattleDesc = {
    Text = "Batas kartu di tangan +[Arg1]. Pada awal giliran, masukkan [Arg2] kartu \"<PVPDerivativeCardKeywords_11:Pertukaran Tidak Setara>\" ke dalam tangan."
  },
  RelicConfig_120372_Desc = {
    Text = "Batas kartu di tangan +[Arg1]. Pada awal giliran, masukkan [Arg2] kartu \"<PVPDerivativeCardKeywords_11:Pertukaran Tidak Setara>\" ke dalam tangan."
  },
  RelicConfig_120372_Name = {
    Text = "<OrangeQuality:kaleidoskop>"
  },
  RelicConfig_120373_BattleDesc = {
    Text = "Setelah dimainkan,  [Arg1] kartu\"<PVPWeaponKeywords: Roda Takdir>\"mengonsumsi arithmetica -5/-3/-1/+1, lukis 1 kartu."
  },
  RelicConfig_120373_Desc = {
    Text = "Setelah dimainkan,  [Arg1] kartu\"<PVPWeaponKeywords: Roda Takdir>\"mengonsumsi arithmetica -5/-3/-1/+1, lukis 1 kartu."
  },
  RelicConfig_120373_Name = {
    Text = "<OrangeQuality:lencana mythag>"
  },
  RelicConfig_121214_BattleDesc = {
    Text = "Kekebalan terhadap kerusakan"
  },
  RelicConfig_121214_Desc = {
    Text = "Kekebalan terhadap kerusakan"
  },
  RelicConfig_121214_Name = {
    Text = "Uji penciptaan tak terkalahkan"
  },
  RelicConfig_121689_BattleDesc = {
    Text = "Kerusakan akhir yang dihasilkan meningkat sebesar 250%, setiap kali memberikan 1 poin kerusakan mengurangi sebesar 50%, dan meningkatkan perisai yang diberikan sebesar 10%, maksimal dipicu 5 kali, direset setelah awal setiap ronde."
  },
  RelicConfig_121689_Desc = {
    Text = "Kerusakan akhir yang dihasilkan meningkat sebesar 250%, setiap kali memberikan 1 poin kerusakan mengurangi sebesar 50%, dan meningkatkan perisai yang diberikan sebesar 10%, maksimal dipicu 5 kali, direset setelah awal setiap ronde."
  },
  RelicConfig_121689_Name = {
    Text = "<OrangeQuality:\"Kembali Perak Murni· Kedatangan\">"
  },
  RelicConfig_121690_BattleDesc = {
    Text = "Pertempuran dimulai, pilih 3 kartu untuk mendapatkan \"<RippleKeywords: Riak>: Ambil 1 kartu, dapatkan [Arg3] poin sementara <PowerIconKeywords: Kekuatan>\".Pada awal giliran, ambil 2 kartu yang disertai <RippleKeywords: Riak>, semua efek <RippleKeywords: Riak> akan diaktifkan tambahan sekali. Setelah mengaktifkan 10 kali <RippleKeywords: Riak>, tambahkan 1 kartu <DerivativeCardKeywords_1: Gema Bayangan Terlupakan> ke tangan."
  },
  RelicConfig_121690_Desc = {
    Text = "Pertempuran dimulai, pilih 3 kartu untuk mendapatkan \"<RippleKeywords: Riak>: Ambil 1 kartu, dapatkan [Arg3] poin sementara <PowerIconKeywords: Kekuatan>\".Pada awal giliran, ambil 2 kartu yang disertai <RippleKeywords: Riak>, semua efek <RippleKeywords: Riak> akan diaktifkan tambahan sekali. Setelah mengaktifkan 10 kali <RippleKeywords: Riak>, tambahkan 1 kartu <DerivativeCardKeywords_1: Gema Bayangan Terlupakan> ke tangan."
  },
  RelicConfig_121690_Name = {
    Text = "<OrangeQuality:\"Inti Perak Murni· Kegilaan\">"
  },
  RelicConfig_121691_BattleDesc = {
    Text = "Semua Awakener meningkatkan Final DMG Exalt sebesar 100%, setiap kali Awakener melepaskan Exalt, mendapatkan Energi-s Keyflare sebesar 500% dari Aliemus dasar mereka, Aliemus dasar semua Awakener berkurang 20 poin, maksimum dapat berkurang hingga 5 kali."
  },
  RelicConfig_121691_Desc = {
    Text = "Semua Awakener meningkatkan Final DMG Exalt sebesar 100%, setiap kali Awakener melepaskan Exalt, mendapatkan Energi-s Keyflare sebesar 500% dari Aliemus dasar mereka, Aliemus dasar semua Awakener berkurang 20 poin, maksimum dapat berkurang hingga 5 kali."
  },
  RelicConfig_121691_Name = {
    Text = "<OrangeQuality:\"Inti Perak· Ketakutan\">"
  },
  RelicConfig_121692_BattleDesc = {
    Text = "Semua Pembangun memberikan peningkatan <RetaliateIconKeywords:Counter>, <IntoxicationIconKeywords:Racun>, Perisai, dan pemulihan hidup sebesar 50%. Pada akhir giliran, dapatkan <RetaliateIconKeywords:Counter> sementara sebesar 500% dari Perisai saat ini."
  },
  RelicConfig_121692_Desc = {
    Text = "Semua Pembangun memberikan peningkatan <RetaliateIconKeywords:Counter>, <IntoxicationIconKeywords:Racun>, Perisai, dan pemulihan hidup sebesar 50%. Pada akhir giliran, dapatkan <RetaliateIconKeywords:Counter> sementara sebesar 500% dari Perisai saat ini."
  },
  RelicConfig_121692_Name = {
    Text = "<OrangeQuality:\"Perjalanan Kembali Perak Murni· Kepercayaan Sesat\">"
  },
  RelicConfig_121693_BattleDesc = {
    Text = "Batas kartu tangan +5. Saat giliran dimulai, tarik 2 kartu dan dapatkan 2 poin Aritmetika. Setiap kali dek kartu direset, dapatkan [Arg3] poin <PowerIconKeywords:Kekuatan> dan [Arg4] poin sementara <AlertIconKeywords:Alert>, menghasilkan setiap kartu perintah non-derivatif dari Pembangun tertinggi dengan Aliemus 1 dan masukkan ke dalam tumpukan menggambar, mengurangi biaya aritmetika mereka sebesar 1 poin."
  },
  RelicConfig_121693_Desc = {
    Text = "Batas kartu tangan +5. Saat giliran dimulai, tarik 2 kartu dan dapatkan 2 poin Aritmetika. Setiap kali dek kartu direset, dapatkan [Arg3] poin <PowerIconKeywords:Kekuatan> dan [Arg4] poin sementara <AlertIconKeywords:Alert>, menghasilkan setiap kartu perintah non-derivatif dari Pembangun tertinggi dengan Aliemus 1 dan masukkan ke dalam tumpukan menggambar, mengurangi biaya aritmetika mereka sebesar 1 poin."
  },
  RelicConfig_121693_Name = {
    Text = "<OrangeQuality:\"Perjalanan Perak Murni· Menggigit Dingin\">"
  },
  RelicConfig_121694_BattleDesc = {
    Text = "Setiap Pembangun mendapatkan 25 poin Aliemus pada penggunaan pertama kartu \"Kartu Perintah\" setiap ronde dan menempatkan 1 kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam tangan. Setelah melepaskan \"Muliakan\" sebanyak 4 kali, lepaskan semua status <Seal:tersegel> dari Pembangun dan berikan 50 poin Aliemus kepada semua Pembangun."
  },
  RelicConfig_121694_Desc = {
    Text = "Setiap Pembangun mendapatkan 25 poin Aliemus pada penggunaan pertama kartu \"Kartu Perintah\" setiap ronde dan menempatkan 1 kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam tangan. Setelah melepaskan \"Muliakan\" sebanyak 4 kali, lepaskan semua status <Seal:tersegel> dari Pembangun dan berikan 50 poin Aliemus kepada semua Pembangun."
  },
  RelicConfig_121694_Name = {
    Text = "<OrangeQuality:\"Inti Perak· Misterius\">"
  },
  RelicConfig_121695_BattleDesc = {
    Text = "Saat pertempuran dimulai, dapatkan [Arg4] poin <PowerIconKeywords:Kekuatan>, batas penyimpanan Energi-s Kunci Perak +100%. Setiap poin konsumsi aritmetika meningkatkan Energi-s yang diperoleh sebesar 100%, setelah menggunakan bangkit kunci perak atau melepaskan Geng, dapatkan <PowerIconKeywords:Kekuatan> sementara sebesar 20% dari <PowerIconKeywords:Kekuatan> saat ini dan semua Pembangun memperoleh 20 poin Aliemus."
  },
  RelicConfig_121695_Desc = {
    Text = "Saat pertempuran dimulai, dapatkan [Arg4] poin <PowerIconKeywords:Kekuatan>, batas penyimpanan Energi-s Kunci Perak +100%. Setiap poin konsumsi aritmetika meningkatkan Energi-s yang diperoleh sebesar 100%, setelah menggunakan bangkit kunci perak atau melepaskan Geng, dapatkan <PowerIconKeywords:Kekuatan> sementara sebesar 20% dari <PowerIconKeywords:Kekuatan> saat ini dan semua Pembangun memperoleh 20 poin Aliemus."
  },
  RelicConfig_121695_Name = {
    Text = "<OrangeQuality:\"Jalan Kembali Perak Murni· Tangisan Sedih\">"
  },
  RelicConfig_122625_BattleDesc = {
    Text = "Setelah pertarungan dimulai, masukkan [Arg1] kartu\"<PVPDerivativeCardKeywords_25:Teh Hitam Sylvia>\" ke dalam tangan."
  },
  RelicConfig_122625_Desc = {
    Text = "Setelah pertarungan dimulai, masukkan [Arg1] kartu\"<PVPDerivativeCardKeywords_25:Teh Hitam Sylvia>\" ke dalam tangan."
  },
  RelicConfig_122625_Name = {
    Text = "<OrangeQuality:Teh Hitam Ceylon>"
  },
  RelicConfig_122626_BattleDesc = {
    Text = "Masukkan [Arg1] kartu \"<PVPDerivativeCardKeywords_14:Imitasi Realita>\" ke dalam tumpukan menggambar setiap putaran, pemiliknya adalah Awakener acak."
  },
  RelicConfig_122626_Desc = {
    Text = "Masukkan [Arg1] kartu \"<PVPDerivativeCardKeywords_14:Imitasi Realita>\" ke dalam tumpukan menggambar setiap putaran, pemiliknya adalah Awakener acak."
  },
  RelicConfig_122626_Name = {
    Text = "<OrangeQuality:Sarung Tangan Sihir>"
  },
  RelicConfig_122627_BattleDesc = {
    Text = "Kerusakan, penyembuhan, dan perisai dari \"Keterampilan\" yang dimainkan pertama di setiap ronde meningkat sebesar [Arg1]% ."
  },
  RelicConfig_122627_Desc = {
    Text = "Kerusakan, penyembuhan, dan perisai dari \"Keterampilan\" yang dimainkan pertama di setiap ronde meningkat sebesar [Arg1]% ."
  },
  RelicConfig_122627_Name = {
    Text = "<OrangeQuality:Ruby Brooch>"
  },
  RelicConfig_122628_BattleDesc = {
    Text = "Setelah akhir ronde, mendapatkan tambahan <Energy:[Arg1]> Aliemus."
  },
  RelicConfig_122628_Desc = {
    Text = "Setelah akhir ronde, mendapatkan tambahan <Energy:[Arg1]> Aliemus."
  },
  RelicConfig_122628_Name = {
    Text = "<OrangeQuality:Manifestasi Mimpi Buruk>"
  },
  RelicConfig_122629_BattleDesc = {
    Text = "Akan ada kartu Pembangun ganda di tumpukan kartu. Setelah memainkan kartu, jika jumlah kartu di tangan pertama kali kurang dari [Arg1] di ronde ini, tarik [Arg2] kartu."
  },
  RelicConfig_122629_Desc = {
    Text = "Akan ada kartu Pembangun ganda di tumpukan kartu. Setelah memainkan kartu, jika jumlah kartu di tangan pertama kali kurang dari [Arg1] di ronde ini, tarik [Arg2] kartu."
  },
  RelicConfig_122629_Name = {
    Text = "<OrangeQuality:Rekaman Kebahagiaan>"
  },
  RelicConfig_122630_BattleDesc = {
    Text = "Batas kartu di tangan +[Arg1]. Di setiap putaran, masukkan [Arg2] kartu \"<PVPDerivativeCardKeywords_13:Funus Aeternum>\" ke dalam tumpukan menggambar."
  },
  RelicConfig_122630_Desc = {
    Text = "Batas kartu di tangan +[Arg1]. Di setiap putaran, masukkan [Arg2] kartu \"<PVPDerivativeCardKeywords_13:Funus Aeternum>\" ke dalam tumpukan menggambar."
  },
  RelicConfig_122630_Name = {
    Text = "<OrangeQuality:Pisau Ritual yang Terlupakan>"
  },
  RelicConfig_122768_BattleDesc = {
    Text = [[
Pada awal giliran, tarik [Arg1] kartu "Pukulan" dengan konsumsi Aritmetika -1. Setelah melepaskan Muliakan, hasilkan [Arg2] kartu "Pukulan" yang terkait dengan Pembangun yang memiliki <DepleteIconKeywords:Lelah>, <PrepareKeypvewords:Persiapan 1> dan <RetainIconKeywords:Retain>.
Dalam 1 giliran, setiap kali memainkan [Arg3] kartu "Pukulan", dapatkan [Arg4] poin sementara <PowerIconKeywords:Kekuatan>; setelah memainkan [Arg5] kartu "Pukulan", tarik [Arg6] kartu dan dapatkan [Arg7] poin Aritmetika; setelah memainkan [Arg8] kartu "Pukulan", semua Pembangun mendapatkan [Arg9] poin Aliemus.]]
  },
  RelicConfig_122768_Desc = {
    Text = [[
Pada awal giliran, tarik [Arg1] kartu "Pukulan" dengan konsumsi Aritmetika -1. Setelah melepaskan Muliakan, hasilkan [Arg2] kartu "Pukulan" yang terkait dengan Pembangun yang memiliki <DepleteIconKeywords:Lelah>, <PrepareKeypvewords:Persiapan 1> dan <RetainIconKeywords:Retain>.
Dalam 1 giliran, setiap kali memainkan [Arg3] kartu "Pukulan", dapatkan [Arg4] poin sementara <PowerIconKeywords:Kekuatan>; setelah memainkan [Arg5] kartu "Pukulan", tarik [Arg6] kartu dan dapatkan [Arg7] poin Aritmetika; setelah memainkan [Arg8] kartu "Pukulan", semua Pembangun mendapatkan [Arg9] poin Aliemus.]]
  },
  RelicConfig_122768_Name = {
    Text = "Gema Dunia Lain"
  },
  RelicConfig_122768_StoryDesc = {
    Text = "Gema yang tercampur dalam kabut dunia lain, menuju distorsi, kegilaan, dan kenyataan yang tak terbantahkan."
  },
  RelicConfig_123724_BattleDesc = {
    Text = "Pada awal giliran, Mouchette mendapatkan [Arg1] poin aliemus, menghasilkan 1 kartu sementara \"Pukulan\" Mouchette dengan konsumsi Aritmetika 0. Setiap kali memicu \"Pertemuan Dramatis\", meningkatkan efek peningkatan kerusakan dasar dan kerusakan pukulan dari \"Bersinar☆Tornado\" dalam pertarungan ini sebesar [Arg2]%."
  },
  RelicConfig_123724_Desc = {
    Text = "Pada awal giliran, Mouchette mendapatkan [Arg1] poin aliemus, menghasilkan 1 kartu sementara \"Pukulan\" Mouchette dengan konsumsi Aritmetika 0. Setiap kali memicu \"Pertemuan Dramatis\", meningkatkan efek peningkatan kerusakan dasar dan kerusakan pukulan dari \"Bersinar☆Tornado\" dalam pertarungan ini sebesar [Arg2]%."
  },
  RelicConfig_123724_Name = {
    Text = "<OrangeQuality:Dimensi·Moysha>"
  },
  RelicConfig_125488_BattleDesc = {
    Text = "Setiap kali Pembangun memainkan Kartu perintah pertama dalam satu ronde, mereka mendapatkan [Arg1] poin Aliemus. Setelah memainkan 4 Kartu perintah yang berasal dari Pembangun berbeda dalam satu ronde, berikan [Arg2]% dari kesehatan maksimum tim kita sebagai <IntoxicationIconKeywords:Racun> kepada semua musuh."
  },
  RelicConfig_125488_Desc = {
    Text = "Setiap kali Pembangun memainkan Kartu perintah pertama dalam satu ronde, mereka mendapatkan [Arg1] poin Aliemus. Setelah memainkan 4 Kartu perintah yang berasal dari Pembangun berbeda dalam satu ronde, berikan [Arg2]% dari kesehatan maksimum tim kita sebagai <IntoxicationIconKeywords:Racun> kepada semua musuh."
  },
  RelicConfig_125488_Name = {
    Text = "Gaya Nyonya"
  },
  RelicConfig_125489_BattleDesc = {
    Text = "Pada awal ronde, Xu mendapatkan [Arg1] Aliemus dan menerapkan 1 lapisan <WitherKeywords:Mabuk> pada semua musuh. Kartu perintah Xu yang dimainkan pertama kali setiap ronde pasti memicu efek\"Resonansi\"."
  },
  RelicConfig_125489_Desc = {
    Text = "Pada awal ronde, Xu mendapatkan [Arg1] Aliemus dan menerapkan 1 lapisan <WitherKeywords:Mabuk> pada semua musuh. Kartu perintah Xu yang dimainkan pertama kali setiap ronde pasti memicu efek\"Resonansi\"."
  },
  RelicConfig_125489_Name = {
    Text = "<OrangeQuality:Dimensi·Xu>"
  },
  RelicConfig_126673_BattleDesc = {
    Text = "Batas kartu tangan +3. Catat 3 kartu perintah non-turunan yang dimainkan di awal setiap putaran, dan pada awal putaran setelah 3 putaran, kurangi biaya Aritmetika-nya sebesar -1 dan tambahkan salinan dengan <DepleteIconKeywords:Lelah> ke tangan."
  },
  RelicConfig_126673_Desc = {
    Text = "Batas kartu tangan +3. Catat 3 kartu perintah non-turunan yang dimainkan di awal setiap putaran, dan pada awal putaran setelah 3 putaran, kurangi biaya Aritmetika-nya sebesar -1 dan tambahkan salinan dengan <DepleteIconKeywords:Lelah> ke tangan."
  },
  RelicConfig_126673_Name = {
    Text = "Roda Pemintal Takdir"
  },
  RelicConfig_126673_StoryDesc = {
    Text = "Takdir berputar, tiada henti sepanjang masa."
  },
  RelicConfig_129304_BattleDesc = {
    Text = [[
<OrangeQuality:Emas Harmoni>:"Arithmetica Harmony"membawa efek peningkatan aritmetika maksimum sebesar 1 poin, setiap memiliki 1% DMG Amplification akan meningkatkan efek Kedalaman Penelitian Spiritual sebesar 1%.
<OrangeQuality:Hadiah Dimensi>: Saat eksplorasi dimulai, secara acak dapatkan 1 Relik Gambar Dimensi, batas Hand meningkat 2.
<OrangeQuality:Diberkati Ritual>: Hadiah dari mengalahkan pemimpin tahap pertama dan kedua diubah menjadi 1 dari 3 Relik Diberkati secara acak.
<RedQuality:Kelelahan Perjalanan Jauh>: Efek pemulihan HP semua berkurang 50%, saat memilih"Tulang Luntur"ke"Penguburan"diubah menjadi pemulihan 25% dari Max HP.
<RedQuality:Tanda Stun>: Pada awal pertempuran, semua Awakener kehilangan 50% Aliemus dan Energi-s saat ini.
<RedQuality:Lorong Malam Abadi>: Saat eksplorasi dimulai, batas dasar Aliemus dan Energi-s semua Awakener meningkat 50%.]]
  },
  RelicConfig_129304_Desc = {
    Text = [[
<OrangeQuality:Emas Harmoni>:"Arithmetica Harmony"membawa efek peningkatan aritmetika maksimum sebesar 1 poin, setiap memiliki 1% DMG Amplification akan meningkatkan efek Kedalaman Penelitian Spiritual sebesar 1%.
<OrangeQuality:Hadiah Dimensi>: Saat eksplorasi dimulai, secara acak dapatkan 1 Relik Gambar Dimensi, batas Hand meningkat 2.
<OrangeQuality:Diberkati Ritual>: Hadiah dari mengalahkan pemimpin tahap pertama dan kedua diubah menjadi 1 dari 3 Relik Diberkati secara acak.
<RedQuality:Kelelahan Perjalanan Jauh>: Efek pemulihan HP semua berkurang 50%, saat memilih"Tulang Luntur"ke"Penguburan"diubah menjadi pemulihan 25% dari Max HP.
<RedQuality:Tanda Stun>: Pada awal pertempuran, semua Awakener kehilangan 50% Aliemus dan Energi-s saat ini.
<RedQuality:Lorong Malam Abadi>: Saat eksplorasi dimulai, batas dasar Aliemus dan Energi-s semua Awakener meningkat 50%.]]
  },
  RelicConfig_129304_Name = {
    Text = "<OrangeQuality: Kamera Kaos Kecil\"N\">"
  },
  RelicConfig_129304_StoryDesc = {
    Text = "Astaga! Kamera benar-benar rusak! Eh? Kenapa masih bisa berfungsi? Tunggu! Apa saja batasan ini?!"
  },
  RelicConfig_129305_BattleDesc = {
    Text = [[
<OrangeQuality:Emas Harmoni>:"Arithmetica Harmony"memiliki efek peningkatan aritmetika maksimum sebesar 1 poin, setiap 1% DMG Amplification akan meningkatkan efek Kedalaman Penelitian Spiritual sebesar 1%.
<RedQuality:Kelelahan Perjalanan Jauh>:Efek pemulihan HP semua berkurang sebesar 50% selama pertempuran, saat memilih"Tulang Luntur"untuk"Pemakaman"berubah menjadi memulihkan 25% Max HP.]]
  },
  RelicConfig_129305_Desc = {
    Text = [[
<OrangeQuality:Emas Harmoni>:"Arithmetica Harmony"memiliki efek peningkatan aritmetika maksimum sebesar 1 poin, setiap 1% DMG Amplification akan meningkatkan efek Kedalaman Penelitian Spiritual sebesar 1%.
<RedQuality:Kelelahan Perjalanan Jauh>:Efek pemulihan HP semua berkurang sebesar 50% selama pertempuran, saat memilih"Tulang Luntur"untuk"Pemakaman"berubah menjadi memulihkan 25% Max HP.]]
  },
  RelicConfig_129305_Name = {
    Text = "<OrangeQuality: Kamera Lengkap Kecil\"N\">"
  },
  RelicConfig_129305_StoryDesc = {
    Text = "Jangan lihat lagi, ini adalah kamera! Baru dari pabrik, harga adil, tidak membedakan usia atau status."
  },
  RelicConfig_129306_BattleDesc = {
    Text = [[
<OrangeQuality:Emas Harmoni>:"Arithmetica Harmony"membawa efek peningkatan aritmetika maksimum sebesar 1 poin, setiap memiliki 1% DMG Amplification akan meningkatkan efek Kedalaman Penelitian Spiritual sebesar 1%.
<OrangeQuality:Hadiah Dimensi>:Pada awal eksplorasi, dapatkan secara acak 1 Relik Gambar Dimensi, batas Maximum Hand Size meningkat 1. 
<RedQuality:Kelelahan Perjalanan Jauh>:Efek pemulihan HP semua berkurang 50%, saat memilih"Tulang Luntur"untuk"Penguburan"diubah menjadi pemulihan 25% dari Max HP. 
<RedQuality:Tanda Stun>:Pada awal pertempuran, semua Awakener kehilangan 50% Aliemus dan Keyflare saat ini.]]
  },
  RelicConfig_129306_Desc = {
    Text = [[
<OrangeQuality:Emas Harmoni>:"Arithmetica Harmony"membawa efek peningkatan aritmetika maksimum sebesar 1 poin, setiap memiliki 1% DMG Amplification akan meningkatkan efek Kedalaman Penelitian Spiritual sebesar 1%.
<OrangeQuality:Hadiah Dimensi>:Pada awal eksplorasi, dapatkan secara acak 1 Relik Gambar Dimensi, batas Maximum Hand Size meningkat 1. 
<RedQuality:Kelelahan Perjalanan Jauh>:Efek pemulihan HP semua berkurang 50%, saat memilih"Tulang Luntur"untuk"Penguburan"diubah menjadi pemulihan 25% dari Max HP. 
<RedQuality:Tanda Stun>:Pada awal pertempuran, semua Awakener kehilangan 50% Aliemus dan Keyflare saat ini.]]
  },
  RelicConfig_129306_Name = {
    Text = "<OrangeQuality:Kamera Usang Kecil\"N\">"
  },
  RelicConfig_129306_StoryDesc = {
    Text = "Selesai! Kamera telah rusak! Biarkan saya perbaiki sebentar... Sudah menyala! Tapi kenapa rasanya aneh..."
  },
  RelicConfig_131079_BattleDesc = {
    Text = "Pada awal giliran, Mosk mendapatkan [Arg1] Aliemus. Setiap kali pertama kali memainkan \"Charge\" atau \"Memuat\" dalam satu giliran, efeknya berlaku 2 kali."
  },
  RelicConfig_131079_Desc = {
    Text = "Pada awal giliran, Mosk mendapatkan [Arg1] Aliemus. Setiap kali pertama kali memainkan \"Charge\" atau \"Memuat\" dalam satu giliran, efeknya berlaku 2 kali."
  },
  RelicConfig_131079_Name = {
    Text = "<OrangeQuality:Gambar Dimensi·Mosk>"
  },
  RelicConfig_131080_BattleDesc = {
    Text = "Pada awal 3 putaran, terpicu 1 kali \"Dilema Berang-berang\".Pada awal putaran ke-5, hapus semua efek negatif dari \"Dilema Berang-berang\" dan dapatkan \"<DerivativeCardKeywords_135:Dampak Dua Dunia!>\"."
  },
  RelicConfig_131080_Desc = {
    Text = "Pada awal 3 putaran, terpicu 1 kali \"Dilema Berang-berang\".Pada awal putaran ke-5, hapus semua efek negatif dari \"Dilema Berang-berang\" dan dapatkan \"<DerivativeCardKeywords_135:Dampak Dua Dunia!>\"."
  },
  RelicConfig_131080_Name = {
    Text = "Bola arang kecil yang Kedua"
  },
  RelicConfig_131080_StoryDesc = {
    Text = [[
Nona Mosk berkata dengan tegas bahwa ini adalah Relic. 
"Orang jahat, gigit dia!"]]
  },
  RelicConfig_131178_BattleDesc = {
    Text = "Saat pertempuran dimulai, masukkan satu kartu \"<DerivativeCardKeywords_134:Kebenaran Terlarang>\" ke dalam dek. Jumlah kartu yang ditarik per giliran +[Arg1]. Setelah memainkan kartu perintah, tambahkan <ErosionColorInkKeywords:Kekacauan Kognitif> pada masing-masing [Arg2] kartu perintah acak di tangan, dek tarik, dan tumpukan buangan yang belum memiliki <ErosionColorInkKeywords:Kekacauan Kognitif>."
  },
  RelicConfig_131178_Desc = {
    Text = "Saat pertempuran dimulai, masukkan satu kartu \"<DerivativeCardKeywords_134:Kebenaran Terlarang>\" ke dalam dek. Jumlah kartu yang ditarik per giliran +[Arg1]. Setelah memainkan kartu perintah, tambahkan <ErosionColorInkKeywords:Kekacauan Kognitif> pada masing-masing [Arg2] kartu perintah acak di tangan, dek tarik, dan tumpukan buangan yang belum memiliki <ErosionColorInkKeywords:Kekacauan Kognitif>."
  },
  RelicConfig_131178_Name = {
    Text = "Catatan Aogya"
  },
  RelicConfig_131178_StoryDesc = {
    Text = "Catatan berisi tujuh puluh bilangan prima Mason."
  },
  RelicConfig_132540_BattleDesc = {
    Text = "Kekebalan terhadap kerusakan"
  },
  RelicConfig_132540_Name = {
    Text = "Ciptaan Uji Koleksi"
  },
  RelicConfig_13740_BattleDesc = {
    Text = "Crit. Rate meningkat sebesar 15%. Jika Hidup di bawah 25% ([Arg1]) pada awal giliran, Crit. Rate akan meningkat tambahan sebesar 30% dalam giliran tersebut."
  },
  RelicConfig_13740_Desc = {
    Text = "Crit. Rate meningkat sebesar 15%. Jika Hidup berada di bawah 25% saat giliran dimulai, Crit. Rate akan meningkat tambahan sebesar 30% dalam giliran itu."
  },
  RelicConfig_13740_Name = {
    Text = "<OrangeQuality:Alat Observasi Bintang Rahasia>"
  },
  RelicConfig_13740_StoryDesc = {
    Text = "Misteri alam semesta."
  },
  RelicConfig_13741_BattleDesc = {
    Text = "Crit. DMG meningkat sebesar 15%. Serangan terhadap musuh dengan perisai selalu menghasilkan Crit. DMG."
  },
  RelicConfig_13741_Desc = {
    Text = "Crit. DMG meningkat sebesar 15%. Serangan terhadap musuh dengan perisai selalu menghasilkan Crit. DMG."
  },
  RelicConfig_13741_Name = {
    Text = "<WhiteQuality:Prinsip Estetika>"
  },
  RelicConfig_13741_StoryDesc = {
    Text = "Pembuat patung lilin: Pembantu dokter, pelanggan pengusaha pemakaman, dan pemberi makan serangga kuburan."
  },
  RelicConfig_13742_BattleDesc = {
    Text = "Crit. DMG +50%. Setiap serangan ketiga yang dilakukan pasti akan menghasilkan kritis."
  },
  RelicConfig_13742_Desc = {
    Text = "Crit. DMG +50%. Setiap serangan ketiga yang dilakukan pasti akan menghasilkan kritis."
  },
  RelicConfig_13742_Name = {
    Text = "<OrangeQuality:Pendulum waktu \"Meditasi\">"
  },
  RelicConfig_13743_BattleDesc = {
    Text = "Pada awal ronde, Pembangun dengan Aliemus terendah mendapatkan 15 Aliemus. Ketika memainkan Kartu dengan Lelah Aritmetika lebih rendah daripada Kartu sebelumnya secara berturut-turut selama 2 kali, Pembangun dengan Aliemus terendah mendapatkan 15 Aliemus."
  },
  RelicConfig_13743_Desc = {
    Text = "Pada awal ronde, Pembangun dengan Aliemus terendah mendapatkan 15 Aliemus. Ketika memainkan Kartu dengan Lelah Aritmetika lebih rendah daripada Kartu sebelumnya secara berturut-turut selama 2 kali, Pembangun dengan Aliemus terendah mendapatkan 15 Aliemus."
  },
  RelicConfig_13743_Name = {
    Text = "<OrangeQuality:Relik Arkana>"
  },
  RelicConfig_13743_StoryDesc = {
    Text = "Akhir dari takdir."
  },
  RelicConfig_13744_BattleDesc = {
    Text = "Setelah ronde dimulai, Pembangun dengan Aliemus terendah mendapatkan 15 Aliemus."
  },
  RelicConfig_13744_Desc = {
    Text = "Setelah ronde dimulai, Pembangun dengan Aliemus terendah mendapatkan 15 Aliemus."
  },
  RelicConfig_13744_Name = {
    Text = "<WhiteQuality:Kancing Lengan Kayu Manis>"
  },
  RelicConfig_13744_StoryDesc = {
    Text = [[
Kancing manset perak dengan ukiran daun laurel. 
 Dibuat dengan sangat halus, berkilauan, dan pernah menjadi simbol persahabatan dua anak.]]
  },
  RelicConfig_13745_BattleDesc = {
    Text = "Efek bonus yang direkomendasikan di Alam meningkat menjadi 50%, dan tingkat Orison keberuntunganmu akan berlipat ganda saat awal tahap."
  },
  RelicConfig_13745_Desc = {
    Text = "Efek bonus yang direkomendasikan di Alam meningkat menjadi 50%, dan tingkat Orison keberuntunganmu akan berlipat ganda saat awal tahap."
  },
  RelicConfig_13745_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Tidur Nyenyak\">"
  },
  RelicConfig_13747_BattleDesc = {
    Text = "Kebal terhadap 1 kali kematian, setelah diaktifkan segera pulihkan 10% Hidup, setelah diaktifkan 3 kali akan permanen tidak aktif."
  },
  RelicConfig_13747_Desc = {
    Text = "Kebal terhadap 1 kali kematian, setelah diaktifkan segera pulihkan 10% Hidup, setelah diaktifkan 3 kali akan permanen tidak aktif."
  },
  RelicConfig_13747_Name = {
    Text = "<WhiteQuality:☆Makanan darurat☆>"
  },
  RelicConfig_13747_StoryDesc = {
    Text = "Kalau benar-benar terpaksa, sebaiknya jangan makan ini."
  },
  RelicConfig_13748_BattleDesc = {
    Text = "Pada saat pertempuran dimulai, semua kartu kamu yang memiliki konsumsi aritmetika sebesar 1 akan meningkatkan kerusakan sebesar [Arg1] poin dan perisai sebesar [Arg2] poin selama pertempuran ini."
  },
  RelicConfig_13748_Desc = {
    Text = "Pada saat pertempuran dimulai, semua kartu kamu yang memiliki konsumsi aritmetika sebesar 1 akan meningkatkan kerusakan sebesar [Arg1] poin dan perisai sebesar [Arg2] poin selama pertempuran ini."
  },
  RelicConfig_13748_Name = {
    Text = "<OrangeQuality: Maria yang Lugu>"
  },
  RelicConfig_13748_StoryDesc = {
    Text = "Logika itu seperti koktail, jika terlalu banyak diminum, manfaatnya akan hilang."
  },
  RelicConfig_13749_BattleDesc = {
    Text = "Setiap 4 ronde, kerusakan aktif dan tentakel yang diterima semua musuh di ronde ini akan dilipatgandakan, tetapi setelah melepaskan Muliakan di ronde tersebut, segel semua Pembangun selama 1 ronde."
  },
  RelicConfig_13749_Desc = {
    Text = "Setiap 4 ronde, kerusakan aktif dan tentakel yang diterima semua musuh di ronde ini akan dilipatgandakan, tetapi setelah melepaskan Muliakan di ronde tersebut, segel semua Pembangun selama 1 ronde."
  },
  RelicConfig_13749_Name = {
    Text = "<RedQuality:Rangka Perjalanan>"
  },
  RelicConfig_13749_StoryDesc = {
    Text = [[
Sebagian dari yang suci. 
 Meskipun terpisah dari tubuh utama, jejaknya telah menyebar ke seluruh penjuru dunia.]]
  },
  RelicConfig_13750_BattleDesc = {
    Text = "Pada akhir ronde, jika tidak ada perisai, dapatkan 1 lapisan <ParcloseIconKeywords:Penghalang> yang memberikan kekebalan terhadap satu kali kerusakan. Efek ini hanya berlaku sekali per pertempuran."
  },
  RelicConfig_13750_Desc = {
    Text = "Pada akhir ronde, jika tidak ada perisai, dapatkan 1 lapisan <ParcloseIconKeywords:Penghalang> yang memberikan kekebalan terhadap satu kali kerusakan. Efek ini hanya berlaku sekali per pertempuran."
  },
  RelicConfig_13750_Name = {
    Text = "<WhiteQuality:☆Tablet Pereda Nyeri☆>"
  },
  RelicConfig_13750_StoryDesc = {
    Text = "Efeknya tidak selalu bertahan lama."
  },
  RelicConfig_13751_BattleDesc = {
    Text = "Crit. Rate meningkat 25%, kerusakan pertama yang diberikan setiap putaran akan dilipatgandakan."
  },
  RelicConfig_13751_Desc = {
    Text = "Crit. Rate meningkat 25%, kerusakan pertama yang diberikan setiap putaran akan dilipatgandakan."
  },
  RelicConfig_13751_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Mendalam\">"
  },
  RelicConfig_13752_BattleDesc = {
    Text = "Pada awal giliran, pulihkan [Arg1] Hidup. Jika Hidup di bawah 50%, pemulihan Hidup menjadi [Arg2]."
  },
  RelicConfig_13752_Desc = {
    Text = "Pada awal giliran, pulihkan [Arg1] Hidup. Jika Hidup di bawah 50%, pemulihan Hidup menjadi [Arg2]."
  },
  RelicConfig_13752_Name = {
    Text = "<WhiteQuality: Darah Pemberian>"
  },
  RelicConfig_13752_StoryDesc = {
    Text = "Rasanya manis dan lembut, dengan aroma mawar yang khas."
  },
  RelicConfig_13753_BattleDesc = {
    Text = "Ini adalah Relik tanpa Efek."
  },
  RelicConfig_13753_Desc = {
    Text = "Ini adalah Relik tanpa Efek."
  },
  RelicConfig_13753_Name = {
    Text = "Misi Uji Ciptaan"
  },
  RelicConfig_13753_StoryDesc = {
    Text = "Relik yang memerlukan konten tambahan"
  },
  RelicConfig_13754_BattleDesc = {
    Text = "Setiap kerusakan ke-5 yang kamu sebabkan pasti akan menjadi kritikal."
  },
  RelicConfig_13754_Desc = {
    Text = "Setiap kerusakan ke-5 yang kamu sebabkan pasti akan menjadi kritikal."
  },
  RelicConfig_13754_Name = {
    Text = "<WhiteQuality:Alat Koreksi Penglihatan>"
  },
  RelicConfig_13754_StoryDesc = {
    Text = "Ada yang pernah melihat melalui itu dan menemukan kebenaran."
  },
  RelicConfig_13755_BattleDesc = {
    Text = "Pada awal ronde, untuk setiap 1 kartu <DimensionalSpaceIconKeywords:Ultra>, dapatkan [Arg1] poin sementara <PowerIconKeywords:Kekuatan>. Jika ronde ini adalah ronde Ultra, dapatkan tambahan [Arg2] poin sementara <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13755_Desc = {
    Text = "Pada awal ronde, untuk setiap 1 kartu <DimensionalSpaceIconKeywords:Ultra>, dapatkan [Arg1] poin sementara <PowerIconKeywords:Kekuatan>. Jika ronde ini adalah ronde Ultra, dapatkan tambahan [Arg2] poin sementara <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13755_Name = {
    Text = "<WhiteQuality:Prisma Segitiga>"
  },
  RelicConfig_13755_StoryDesc = {
    Text = "\"Cahaya terdiri dari tujuh warna.\""
  },
  RelicConfig_13756_BattleDesc = {
    Text = "Kehilangan semua Relik lain saat diambil, secara acak mendapatkan 2 Relik emas."
  },
  RelicConfig_13756_Desc = {
    Text = "Kehilangan semua Relik lain saat diambil, secara acak mendapatkan 2 Relik emas."
  },
  RelicConfig_13756_Name = {
    Text = "<RedQuality:☆Pandangan Terbalik☆>"
  },
  RelicConfig_13756_StoryDesc = {
    Text = [[
Di era yang aneh, bunga adalah penonton pertama bagi manusia.
Jangan bergerak, mereka lebih menyukai objek pameran yang tenang.]]
  },
  RelicConfig_13757_BattleDesc = {
    Text = "Setiap kartu perintah ke-8 yang kamu mainkan akan berlaku 2 kali."
  },
  RelicConfig_13757_Desc = {
    Text = "Setiap kartu perintah ke-8 yang kamu mainkan akan berlaku 2 kali."
  },
  RelicConfig_13757_Name = {
    Text = "<OrangeQuality:Anggur Bintang>"
  },
  RelicConfig_13757_StoryDesc = {
    Text = "Melangkah di antara bintang-bintang."
  },
  RelicConfig_13758_BattleDesc = {
    Text = "Setelah diambil, Kesehatan maksimum meningkat sebesar [Arg1] poin, dan saat menerima Serangan, Aliemus meningkat sebesar 2 poin."
  },
  RelicConfig_13758_Desc = {
    Text = "Setelah diambil, Kesehatan maksimum meningkat sebesar [Arg1] poin, dan saat menerima Serangan, Aliemus meningkat sebesar 2 poin."
  },
  RelicConfig_13758_Name = {
    Text = "<WhiteQuality: Tinta Manis>"
  },
  RelicConfig_13758_StoryDesc = {
    Text = "Ada yang mengatakan ini darah iblis, namun, hei, coba dulu!"
  },
  RelicConfig_13759_BattleDesc = {
    Text = "Ketika melepaskan Muliakan, untuk setiap 1 Kerusakan yang akan diberikan oleh musuh, berikan [Arg1] lapisan <IntoxicationIconKeywords:Racun>"
  },
  RelicConfig_13759_Desc = {
    Text = "Ketika melepaskan Muliakan, untuk setiap 1 Kerusakan yang akan diberikan oleh musuh, berikan [Arg1] lapisan <IntoxicationIconKeywords:Racun>"
  },
  RelicConfig_13759_Name = {
    Text = "<WhiteQuality:☆Rahang Laser☆>"
  },
  RelicConfig_13759_StoryDesc = {
    Text = [[
Tulang yang dipajang di ruang pameran pribadi seorang kolektor. 
 Kolektor tersebut terpesona oleh cahaya fluoresen yang indah, menikmatinya siang dan malam, hingga akhirnya mengering dan mati, menjadi serupa dengan tulang itu sendiri.]]
  },
  RelicConfig_13760_BattleDesc = {
    Text = "Meningkatkan Aritmetika maksimal sebesar 1. Saat memainkan Kartu dengan Lelah lebih tinggi daripada Kartu sebelumnya sebanyak 2 kali berturut-turut, dapatkan 1 Aritmetika."
  },
  RelicConfig_13760_Desc = {
    Text = "Meningkatkan Aritmetika maksimal sebesar 1. Saat memainkan Kartu dengan Lelah lebih tinggi daripada Kartu sebelumnya sebanyak 2 kali berturut-turut, dapatkan 1 Aritmetika."
  },
  RelicConfig_13760_Name = {
    Text = "<OrangeQuality:Catatan Arkana>"
  },
  RelicConfig_13760_StoryDesc = {
    Text = "Arah takdir."
  },
  RelicConfig_13761_BattleDesc = {
    Text = "Pada awal ronde, jika jumlah kartu tangan yang tersisa dari ronde sebelumnya lebih dari 3, dapatkan 2 Aritmetika."
  },
  RelicConfig_13761_Desc = {
    Text = "Pada awal ronde, jika jumlah kartu tangan yang tersisa dari ronde sebelumnya lebih dari 3, dapatkan 2 Aritmetika."
  },
  RelicConfig_13761_Name = {
    Text = "<WhiteQuality:Emblem Mythag>"
  },
  RelicConfig_13761_StoryDesc = {
    Text = "Lencana yang didistribusikan oleh Universitas Mythag kepada para Penyelidik. Ini tidak hanya melambangkan identitas pemakainya, tetapi juga merupakan alat yang dapat digunakan untuk komunikasi jarak jauh."
  },
  RelicConfig_13762_BattleDesc = {
    Text = "Ketika menggunakan \"Pertahanan\", dapatkan [Arg1] poin <RetaliateIconKeywords:Counter>."
  },
  RelicConfig_13762_Desc = {
    Text = "Ketika menggunakan \"Pertahanan\", dapatkan [Arg1] poin <RetaliateIconKeywords:Counter>."
  },
  RelicConfig_13762_Name = {
    Text = "Rompi Urtiga Berduri Terasing"
  },
  RelicConfig_13762_StoryDesc = {
    Text = "Tidak bisa membedakan cairan yang menempel."
  },
  RelicConfig_13763_BattleDesc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1] poin perisai. Jika memiliki perisai pada awal giliran, efek kuat perisai dan sembuh meningkat +50% selama giliran itu."
  },
  RelicConfig_13763_Desc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1] poin perisai. Jika memiliki perisai pada awal giliran, efek kuat perisai dan sembuh meningkat +50% selama giliran itu."
  },
  RelicConfig_13763_Name = {
    Text = "Penjaga Taman yang Terasing"
  },
  RelicConfig_13764_BattleDesc = {
    Text = "Mendapatkan secara permanen [Arg1] poin <PowerIconKeywords:Kekuatan> saat diambil."
  },
  RelicConfig_13764_Desc = {
    Text = "Mendapatkan secara permanen [Arg1] poin <PowerIconKeywords:Kekuatan> saat diambil."
  },
  RelicConfig_13764_Name = {
    Text = "<WhiteQuality:Peniti Ruby>"
  },
  RelicConfig_13764_StoryDesc = {
    Text = "Tampak samar-samar warna merah segar menyeruak keluar."
  },
  RelicConfig_13766_BattleDesc = {
    Text = "Saat mengambil, pilih 1 kartu dan berikan 2 efek peningkatan dari pilihan tiga.（Catatan: Mirip dengan Seribu bayangan menghias kartu）"
  },
  RelicConfig_13766_Desc = {
    Text = "Saat mengambil, pilih 1 kartu dan berikan 2 efek peningkatan dari pilihan tiga.（Catatan: Mirip dengan Seribu bayangan menghias kartu）"
  },
  RelicConfig_13766_Name = {
    Text = "<OrangeQuality:☆Mesin Tik Master☆>"
  },
  RelicConfig_13766_StoryDesc = {
    Text = "Ada rumor bahwa karya abadi yang sesungguhnya ditulis oleh mesin tik."
  },
  RelicConfig_13767_BattleDesc = {
    Text = "Mendapatkan 1 Orison tingkat lanjut acak dari 3 pilihan saat memungut, dan memberikannya kepada Kartu yang sesuai."
  },
  RelicConfig_13767_Desc = {
    Text = "Mendapatkan 1 Orison tingkat lanjut acak dari 3 pilihan saat memungut, dan memberikannya kepada Kartu yang sesuai."
  },
  RelicConfig_13767_Name = {
    Text = "<WhiteQuality: Papirus Rhind>"
  },
  RelicConfig_13767_StoryDesc = {
    Text = "Berikut adalah pertanyaannya: 10 biksu membagi 6 roti, berapa banyak yang didapat masing-masing?"
  },
  RelicConfig_13768_BattleDesc = {
    Text = "Maksimum Aritmetika meningkat 2. Setelah memainkan \"Serangan\" atau \"Pertahanan\", Pembangun yang sesuai mendapatkan 5 Aliemus. Setelah melepaskan Muliakan, dapatkan 1 \"Serangan\" dengan konsumsi Lelah Ilusi dari Pembangun yang sesuai. Setelah melepaskan Geng, dapatkan secara acak 1 \"Pertahanan\" dengan konsumsi Lelah Ilusi."
  },
  RelicConfig_13768_Desc = {
    Text = "Maksimum Aritmetika meningkat 2. Setelah memainkan \"Serangan\" atau \"Pertahanan\", Pembangun yang sesuai mendapatkan 5 Aliemus. Setelah melepaskan Muliakan, dapatkan 1 \"Serangan\" dengan konsumsi Lelah Ilusi dari Pembangun yang sesuai. Setelah melepaskan Geng, dapatkan secara acak 1 \"Pertahanan\" dengan konsumsi Lelah Ilusi."
  },
  RelicConfig_13768_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Sayap\">"
  },
  RelicConfig_13769_BattleDesc = {
    Text = "Pada awal ronde, <EmbryoFusionIconKeywords:Fusi Embrio>+30. Semua efek <DevouredIconKeywords:Melahap> milikmu berubah menjadi <UnlimitedDevouredIconKeywords:Melahap Tanpa Batas>."
  },
  RelicConfig_13769_Desc = {
    Text = "Pada awal ronde, <EmbryoFusionIconKeywords:Fusi Embrio>+30. Semua efek <DevouredIconKeywords:Melahap> milikmu berubah menjadi <UnlimitedDevouredIconKeywords:Melahap Tanpa Batas>."
  },
  RelicConfig_13769_Name = {
    Text = "<RedQuality:Umbilical Cord yang Berdenyut>"
  },
  RelicConfig_13769_StoryDesc = {
    Text = "Jalinan di leher."
  },
  RelicConfig_13770_BattleDesc = {
    Text = "Pada awal ronde, dapatkan [Arg1] Perisai, dan setiap 1 ronde berlalu, nilai Perisai tersebut akan meningkat sebesar [Arg2]."
  },
  RelicConfig_13770_Desc = {
    Text = "Pada awal ronde, dapatkan [Arg1] Perisai, dan setiap 1 ronde berlalu, nilai Perisai tersebut akan meningkat sebesar [Arg2]."
  },
  RelicConfig_13770_Name = {
    Text = "<WhiteQuality:Tangan Penjaga>"
  },
  RelicConfig_13770_StoryDesc = {
    Text = "Tangan yang berdoa, tinju yang kokoh."
  },
  RelicConfig_13771_BattleDesc = {
    Text = "Semua Pembangun meningkatkan isi ulang kunci perak sebesar 30. Setelah melepaskan Geng, cuci 3 kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam dek kartumu."
  },
  RelicConfig_13771_Desc = {
    Text = "Semua Pembangun meningkatkan isi ulang kunci perak sebesar 30. Setelah melepaskan Geng, cuci 3 kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam dek kartumu."
  },
  RelicConfig_13771_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Tidur Dangkal\">"
  },
  RelicConfig_13772_BattleDesc = {
    Text = "Setelah pertempuran, dapatkan tambahan 75 segil hitam dan 1 kartu gejala."
  },
  RelicConfig_13772_Desc = {
    Text = "Setelah pertempuran, dapatkan tambahan 75 segil hitam dan 1 kartu gejala."
  },
  RelicConfig_13772_Name = {
    Text = "<RedQuality:Prasasti Giok Hijau>"
  },
  RelicConfig_13772_StoryDesc = {
    Text = "Cetakan ini akan tetap abadi selama ribuan tahun."
  },
  RelicConfig_13773_BattleDesc = {
    Text = "Setiap kali memberikan 1 kerusakan aktif, [Arg1] lapisan <BleedingIconKeywords:Berdarah> diberikan pada diri sendiri, dan [Arg2] lapisan <BleedingIconKeywords:Berdarah> diberikan pada target kerusakan. Setiap kali membunuh 1 musuh, hilangkan status <BleedingIconKeywords:Berdarah> pada diri sendiri."
  },
  RelicConfig_13773_Desc = {
    Text = "Setiap kali memberikan 1 kerusakan aktif, [Arg1] lapisan <BleedingIconKeywords:Berdarah> diberikan pada diri sendiri, dan [Arg2] lapisan <BleedingIconKeywords:Berdarah> diberikan pada target kerusakan. Setiap kali membunuh 1 musuh, hilangkan status <BleedingIconKeywords:Berdarah> dari diri sendiri."
  },
  RelicConfig_13773_Name = {
    Text = "<RedQuality:Kesadaran Kumpulan Serangga>"
  },
  RelicConfig_13773_StoryDesc = {
    Text = "Jalinan, simbiosis, berkelompok; ketakutan, yang tidak diketahui, kontrol."
  },
  RelicConfig_13774_BattleDesc = {
    Text = "Ketika memainkan 1 Kartu dengan Lelah sebesar 3, tarik 1 Kartu dan dapatkan 2 Aritmetika; ketika memainkan 1 Kartu dengan Lelah sebesar 4 atau lebih, Lelah dari Kartu lain di tangan berkurang 1."
  },
  RelicConfig_13774_Desc = {
    Text = "Ketika memainkan 1 Kartu dengan Lelah sebesar 3, tarik 1 Kartu dan dapatkan 2 Aritmetika; ketika memainkan 1 Kartu dengan Lelah sebesar 4 atau lebih, Lelah dari Kartu lain di tangan berkurang 1."
  },
  RelicConfig_13774_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"mata\">"
  },
  RelicConfig_13775_BattleDesc = {
    Text = "Saat mengambil, pilih satu Kartu perintah untuk memberikannya \"Inheren\", \"Tetap\" dan \"Setelah dimainkan, tarik 1 kartu\"."
  },
  RelicConfig_13775_Desc = {
    Text = "Saat mengambil, pilih satu Kartu perintah untuk memberikannya \"Inheren\", \"Tetap\" dan \"Setelah dimainkan, tarik 1 kartu\"."
  },
  RelicConfig_13775_Name = {
    Text = "<WhiteQuality:Folder>"
  },
  RelicConfig_13775_StoryDesc = {
    Text = "Ssst, ini adalah transaksi rahasia antara kau dan aku."
  },
  RelicConfig_13776_BattleDesc = {
    Text = "Setelah pertempuran dimulai, dapatkan 1 Tentakel."
  },
  RelicConfig_13776_Desc = {
    Text = "Setelah pertempuran dimulai, dapatkan 1 Tentakel."
  },
  RelicConfig_13776_Name = {
    Text = "<WhiteQuality:Kerang Kuning Kecil>"
  },
  RelicConfig_13776_StoryDesc = {
    Text = "Siput kecil berwarna kuning ini memiliki garis keturunan bangsawan, dengan Sumber yang sempurna dan tanpa cela."
  },
  RelicConfig_13777_BattleDesc = {
    Text = "Pada akhir ronde ganjil, jika ada Aritmetika tersisa, tarik 2 kartu tambahan di ronde berikutnya; pada akhir ronde genap, jika ada kartu tangan tersisa, dapatkan 2 Aritmetika tambahan di ronde berikutnya."
  },
  RelicConfig_13777_Desc = {
    Text = "Pada akhir ronde ganjil, jika ada Aritmetika tersisa, tarik 2 kartu tambahan di ronde berikutnya; pada akhir ronde genap, jika ada kartu tangan tersisa, dapatkan 2 Aritmetika tambahan di ronde berikutnya."
  },
  RelicConfig_13777_Name = {
    Text = "<OrangeQuality:Roda Matahari dan Bulan>"
  },
  RelicConfig_13777_StoryDesc = {
    Text = "Tebak, apakah itu hitam atau putih?"
  },
  RelicConfig_13778_BattleDesc = {
    Text = "Batas maksimum tentakel bertambah 1. Ketika nyawa di bawah 50%, <TentacleInjurieIconKeywords:Kerusakan tentakel> meningkat sebesar [Arg1]."
  },
  RelicConfig_13778_Desc = {
    Text = "Batas maksimal tentakel meningkat 1. Ketika hidup di bawah 50%, <TentacleInjurieIconKeywords:Kerusakan tentakel> meningkat [Arg1]."
  },
  RelicConfig_13778_Name = {
    Text = "<OrangeQuality:Lagu Lautan>"
  },
  RelicConfig_13778_StoryDesc = {
    Text = "Dikatakan bahwa hewan yang tidak dapat dimakan, seperti kerang anyaman, menyerap sekitar 80% nutrisi dari lautan."
  },
  RelicConfig_13779_BattleDesc = {
    Text = "Pada awal ronde, tarik 1 kartu. Pada akhir ronde, pemain dapat memilih untuk menyimpan 1 kartu di tangan."
  },
  RelicConfig_13779_Desc = {
    Text = "Pada awal ronde, tarik 1 kartu. Pada akhir ronde, pemain dapat memilih untuk menyimpan 1 kartu di tangan."
  },
  RelicConfig_13779_Name = {
    Text = "<OrangeQuality: Lampu Harapan Nabi>"
  },
  RelicConfig_13779_StoryDesc = {
    Text = "Menjawab keinginanmu."
  },
  RelicConfig_13780_BattleDesc = {
    Text = "Setiap kali melepaskan Aliemus Muliakan, dapatkan 1 kartu <DerivativeCardKeywords_7:\"Infeksi Beracun\">. Jika memiliki 3 kartu <DerivativeCardKeywords_7:\"Infeksi Beracun\"> di tangan, maka akan digabungkan menjadi satu kartu <DerivativeCardKeywords_8:\"Serangan Beracun\"> yang memicu <IntoxicationIconKeywords:Racun>."
  },
  RelicConfig_13780_Desc = {
    Text = "Setiap kali melepaskan Aliemus Muliakan, dapatkan 1 kartu <DerivativeCardKeywords_7:\"Infeksi Beracun\">. Jika memiliki 3 kartu <DerivativeCardKeywords_7:\"Infeksi Beracun\"> di tangan, maka akan digabungkan menjadi satu kartu <DerivativeCardKeywords_8:\"Serangan Beracun\"> yang memicu <IntoxicationIconKeywords:Racun>."
  },
  RelicConfig_13780_Name = {
    Text = "<OrangeQuality:Lidah Asing>"
  },
  RelicConfig_13780_StoryDesc = {
    Text = "Dia bukan iblis, tetapi Dia memang menyampaikan bisikan dari luar dunia manusia."
  },
  RelicConfig_13781_BattleDesc = {
    Text = "Setiap Lelah 1 Segil hitam, semua Pembangun mendapatkan 1 poin Aliemus."
  },
  RelicConfig_13781_Desc = {
    Text = "Setiap Lelah 1 Segil hitam, semua Pembangun mendapatkan 1 poin Aliemus."
  },
  RelicConfig_13781_Name = {
    Text = "Bunga Terbalik"
  },
  RelicConfig_13782_BattleDesc = {
    Text = "Kekebalan terhadap kerusakan"
  },
  RelicConfig_13782_Desc = {
    Text = "Kekebalan terhadap kerusakan"
  },
  RelicConfig_13782_Name = {Text = "Relik Uji"},
  RelicConfig_13783_BattleDesc = {
    Text = "Setelah memainkan kartu ke-3 setiap ronde, tempatkan 1 <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam tumpukan kartu buang. Setelah memainkan kartu ke-6 setiap ronde, ambil 1 <DerivativeCardKeywords_4:\"Inspirasi\"> dari tumpukan kartu buang dan masukkan ke dalam tangan."
  },
  RelicConfig_13783_Desc = {
    Text = "Setelah memainkan kartu ke-3 setiap ronde, tempatkan 1 <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam tumpukan kartu buang. Setelah memainkan kartu ke-6 setiap ronde, ambil 1 <DerivativeCardKeywords_4:\"Inspirasi\"> dari tumpukan kartu buang dan masukkan ke dalam tangan."
  },
  RelicConfig_13783_Name = {
    Text = "<WhiteQuality:Cahaya Peradaban>"
  },
  RelicConfig_13783_StoryDesc = {
    Text = "Meteor yang membelah kegelapan malam."
  },
  RelicConfig_13784_BattleDesc = {
    Text = "Pada awal ronde, dapatkan 1 Aritmetika untuk setiap 1 musuh. Saat membunuh musuh dengan kerusakan aktif, berikan <BleedingIconKeywords:Berdarah> kepada musuh lainnya yang setara dengan kerusakan berlebih."
  },
  RelicConfig_13784_Desc = {
    Text = "Pada awal ronde, dapatkan 1 Aritmetika untuk setiap 1 musuh. Saat membunuh musuh dengan kerusakan aktif, berikan <BleedingIconKeywords:Berdarah> kepada musuh lainnya yang setara dengan kerusakan berlebih."
  },
  RelicConfig_13784_Name = {
    Text = "<OrangeQuality: Lagu Kaum Plebeian>"
  },
  RelicConfig_13784_StoryDesc = {
    Text = "Dirancang khusus untuk menyiksa telingamu."
  },
  RelicConfig_13785_BattleDesc = {
    Text = "Pada akhir ronde, <EmbryoFusionIconKeywords:Fusi Embrio> +15, jika kartu tangan berisi <DerivativeCardKeywords_2:「Embrio」>, pulihkan [Arg1] Hidup."
  },
  RelicConfig_13785_Desc = {
    Text = "Pada akhir ronde, <EmbryoFusionIconKeywords:Fusi Embrio> +15, jika kartu tangan berisi <DerivativeCardKeywords_2:「Embrio」>, pulihkan [Arg1] Hidup."
  },
  RelicConfig_13785_Name = {
    Text = "<WhiteQuality:Catatan Diagnosis Wabah>"
  },
  RelicConfig_13785_StoryDesc = {
    Text = "Wabah —— manifestasi kebetulan dari kegelisahan alam yang tidak disadari."
  },
  RelicConfig_13786_BattleDesc = {
    Text = "Setelah melepaskan ledakan kegilaan, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_13786_Desc = {
    Text = "Setelah melepaskan ledakan kegilaan, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_13786_Name = {
    Text = "<WhiteQuality:Kunci Berat>"
  },
  RelicConfig_13786_StoryDesc = {
    Text = [[
Gembok yang tebal dan kokoh, tanpa kunci, sepertinya akan sulit dibuka. 
Tentu saja, bagi pencuri ulung, ini bukan masalah besar.]]
  },
  RelicConfig_13787_BattleDesc = {
    Text = "Saat putaran dimulai, berikan [Arg1] poin <FixedDamage:Kerusakan Murni> kepada satu musuh secara acak. Setelah play \"Pukulan\" sebanyak 7 kali dalam pertarungan ini, nilai kerusakan berubah menjadi [Arg2], setelah play \"Pukulan\" sebanyak 21 kali, segera berikan [Arg3] poin <FixedDamage:Kerusakan Murni> kepada semua musuh."
  },
  RelicConfig_13787_Desc = {
    Text = "Saat putaran dimulai, berikan [Arg1] poin <FixedDamage:Kerusakan Murni> kepada satu musuh secara acak. Setelah play \"Pukulan\" sebanyak 7 kali dalam pertarungan ini, nilai kerusakan berubah menjadi [Arg2], setelah play \"Pukulan\" sebanyak 21 kali, segera berikan [Arg3] poin <FixedDamage:Kerusakan Murni> kepada semua musuh."
  },
  RelicConfig_13787_Name = {
    Text = "<OrangeQuality:Teka-teki Tua>"
  },
  RelicConfig_13787_StoryDesc = {
    Text = "Karya seni yang dulunya tertanam dalam bingkai berat, sejak hari dipamerkan telah kehilangan sebagian."
  },
  RelicConfig_13788_BattleDesc = {
    Text = "Mengurangi batas Tentakel sebanyak 2. Pada akhir ronde, semua Tentakel akan melakukan Serangan 1 kali tambahan."
  },
  RelicConfig_13788_Desc = {
    Text = "Mengurangi batas Tentakel sebanyak 2. Pada akhir ronde, semua Tentakel akan melakukan Serangan 1 kali tambahan."
  },
  RelicConfig_13788_Name = {
    Text = "<RedQuality:Pergelangan Suci Penderitaan>"
  },
  RelicConfig_13788_StoryDesc = {
    Text = "Rasakan penderitaan."
  },
  RelicConfig_13789_BattleDesc = {
    Text = "Setiap kali dek direset, dapatkan [Arg1] <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13789_Desc = {
    Text = "Setiap kali dek direset, dapatkan [Arg1] <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13789_Name = {
    Text = "<WhiteQuality:Pipa Tangis>"
  },
  RelicConfig_13789_StoryDesc = {
    Text = "Apakah ini produk dari kebencian, atau hasil dari balas dendam?"
  },
  RelicConfig_13790_BattleDesc = {
    Text = "Setiap kali peta bergerak, kamu akan mendapatkan 10 Segil Hitam, namun tekanan Roh akibat pergerakan peta akan meningkat sebesar 10 poin."
  },
  RelicConfig_13790_Desc = {
    Text = "Setiap kali peta bergerak, kamu akan mendapatkan 10 Segil Hitam, namun tekanan Roh akibat pergerakan peta akan meningkat sebesar 10 poin."
  },
  RelicConfig_13790_Name = {
    Text = "Tas Tanpa Dasar"
  },
  RelicConfig_13791_BattleDesc = {
    Text = "Saat mengambil Relik ini, pilih satu Kartu Perintah dan tambahkan satu salinannya ke dalam dek."
  },
  RelicConfig_13791_Desc = {
    Text = "Saat mengambil Relik ini, pilih satu Kartu Perintah dan tambahkan satu salinannya ke dalam dek."
  },
  RelicConfig_13791_Name = {
    Text = "<WhiteQuality:Kilasan Api>"
  },
  RelicConfig_13791_StoryDesc = {
    Text = "Cahaya yang goyah, harapan yang samar."
  },
  RelicConfig_13792_BattleDesc = {
    Text = "Setiap kali kamu kehilangan hidup, <EmbryoFusionIconKeywords:Fusi Embrio>+10. Jika hidup di bawah 50%, efeknya akan berlipat ganda."
  },
  RelicConfig_13792_Desc = {
    Text = "Setiap kali kamu kehilangan hidup, <EmbryoFusionIconKeywords:Fusi Embrio>+10. Jika hidup di bawah 50%, efeknya akan berlipat ganda."
  },
  RelicConfig_13792_Name = {
    Text = "<WhiteQuality:Gergaji Baja Berkarat>"
  },
  RelicConfig_13792_StoryDesc = {
    Text = "Dokter anatomi seumur hidup tidak pernah melihat wanita cantik, hanya ada karung tulang, saraf yang meradang karena penyakit, otot, dan jaringan."
  },
  RelicConfig_13793_BattleDesc = {
    Text = "Saat mengambil, jatuhnya Segil hitam untuk tim menjadi 150% dari nilai asal. Setelah memulihkan kehidupan, semua yang terbangun mendapatkan 3 poin Aliemus; setelah kehilangan kehidupan, dapatkan [Arg1] poin<PowerIconKeywords:Kekuatan> dan kerusakan tentakel, hingga maksimum 5 kali per putaran."
  },
  RelicConfig_13793_Desc = {
    Text = "Saat mengambil, jatuhnya Segil hitam untuk tim menjadi 150% dari nilai asal. Setelah memulihkan kehidupan, semua yang terbangun mendapatkan 3 poin Aliemus; setelah kehilangan kehidupan, dapatkan [Arg1] poin<PowerIconKeywords:Kekuatan> dan kerusakan tentakel, hingga maksimum 5 kali per putaran."
  },
  RelicConfig_13793_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Bulan\">"
  },
  RelicConfig_13794_BattleDesc = {
    Text = "Setelah ronde berakhir, semua Pembangun mendapatkan 5 Aliemus. Untuk setiap 1 poin Aritmetika yang tersisa, semua Pembangun akan mendapatkan tambahan 3 Aliemus."
  },
  RelicConfig_13794_Desc = {
    Text = "Setelah ronde berakhir, semua Pembangun mendapatkan 5 Aliemus. Untuk setiap 1 poin Aritmetika yang tersisa, semua Pembangun akan mendapatkan tambahan 3 Aliemus."
  },
  RelicConfig_13794_Name = {
    Text = "<OrangeQuality: Prototipe Baterai>"
  },
  RelicConfig_13794_StoryDesc = {
    Text = "Harapan yang dapat dibawa kemana saja."
  },
  RelicConfig_13795_BattleDesc = {
    Text = "Meningkatkan aritmetika maksimal sebesar 1."
  },
  RelicConfig_13795_Desc = {
    Text = "Meningkatkan aritmetika maksimal sebesar 1."
  },
  RelicConfig_13795_Name = {
    Text = "<WhiteQuality:Penyuntik aktif>"
  },
  RelicConfig_13795_StoryDesc = {
    Text = "Kejang juga merupakan salah satu bentuk aktivitas."
  },
  RelicConfig_13796_BattleDesc = {
    Text = "Pada akhir pertempuran, jika sisa hidup kurang dari 50%, tingkatkan menjadi sebuah relik perak."
  },
  RelicConfig_13796_Desc = {
    Text = "Pada akhir pertempuran, jika sisa hidup kurang dari 50%, tingkatkan menjadi sebuah relik perak."
  },
  RelicConfig_13796_Name = {
    Text = "Buku catatan yang usang 2"
  },
  RelicConfig_13796_StoryDesc = {
    Text = [[
Sebuah buku harian tua yang halamannya penuh dengan sisipan, sekilas terlihat setidaknya berisi peta Elworth, catatan eksperimen, dan surat-surat dengan D-marka. 
 Catatan di bagian awal tertulis rapi dan teratur, namun semakin ke belakang menjadi semakin berantakan.]]
  },
  RelicConfig_13797_BattleDesc = {
    Text = "Setelah menggunakan 3 kartu serangan, tingkatkan menjadi sebuah Relik emas."
  },
  RelicConfig_13797_Desc = {
    Text = "Setelah menggunakan 3 kartu serangan, tingkatkan menjadi sebuah Relik emas."
  },
  RelicConfig_13797_Name = {
    Text = "Buku catatan yang lusuh 1"
  },
  RelicConfig_13797_StoryDesc = {
    Text = [[
Sebuah buku harian tua yang halamannya penuh dengan sisipan, sekilas terlihat setidaknya berisi peta Elworth, catatan eksperimen, dan surat-surat dengan D-marka. 
 Catatan di bagian awal tertulis rapi dan teratur, namun semakin ke belakang menjadi semakin berantakan.]]
  },
  RelicConfig_13798_BattleDesc = {
    Text = "Pada awal pertempuran, semua kartu gejala milikmu mendapatkan <NothingnessIconKeywords:Ilusi>, dan untuk setiap 1 kartu gejala dalam dek, kamu mendapatkan [Arg1] <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13798_Desc = {
    Text = "Pada awal pertempuran, semua kartu gejala milikmu mendapatkan <NothingnessIconKeywords:Ilusi>, dan untuk setiap 1 kartu gejala dalam dek, kamu mendapatkan [Arg1] <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13798_Name = {
    Text = "<WhiteQuality:Ramuan Rohani Harvard>"
  },
  RelicConfig_13798_StoryDesc = {
    Text = [[
Obat dengan komposisi yang tidak jelas. 
 Konon, pemain biola terkenal bernama Eric sangat menggemarinya.]]
  },
  RelicConfig_13799_BattleDesc = {
    Text = "Pada awal ronde pertama pertempuran, tambahkan <DerivativeCardKeywords_1:\"Resonansi Bayangan Terlupakan\"> ke tangan; pada ronde ke-2, tambahkan <DerivativeCardKeywords_41:\"Resonansi Kunci Perak\"> ke tangan; pada ronde ke-3, tambahkan <DerivativeCardKeywords_39:\"Gema Masa Lalu\"> ke tangan."
  },
  RelicConfig_13799_Desc = {
    Text = "Pada awal ronde pertama pertempuran, tambahkan <DerivativeCardKeywords_1:\"Resonansi Bayangan Terlupakan\"> ke tangan; pada ronde ke-2, tambahkan <DerivativeCardKeywords_41:\"Resonansi Kunci Perak\"> ke tangan; pada ronde ke-3, tambahkan <DerivativeCardKeywords_39:\"Gema Masa Lalu\"> ke tangan."
  },
  RelicConfig_13799_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Bintang-bintang\">"
  },
  RelicConfig_13800_BattleDesc = {
    Text = "Pada awal ronde, tambahkan 1 kartu <DerivativeCardKeywords_6:\"Payung Matahari\"> ke tangan, setelah memainkan 6 kartu, tingkatkan semua <DerivativeCardKeywords_6:\"Payung Matahari\"><AlertIconKeywords:Waspada> di tangan sebesar [Arg2]."
  },
  RelicConfig_13800_Desc = {
    Text = "Pada awal ronde, tambahkan 1 kartu <DerivativeCardKeywords_6:\"Payung Matahari\"> ke tangan, setelah memainkan 6 kartu, tingkatkan semua <DerivativeCardKeywords_6:\"Payung Matahari\"><AlertIconKeywords:Waspada> di tangan sebesar [Arg2]."
  },
  RelicConfig_13800_Name = {
    Text = "<WhiteQuality:Payung Perjalanan>"
  },
  RelicConfig_13800_StoryDesc = {
    Text = "Mekar di tanah tanpa cahaya."
  },
  RelicConfig_13801_BattleDesc = {
    Text = "Seluruh kehidupan musuh di dalam pertarungan reguler meningkat 30%, dan pada saat kemenangan bertarung mendapatkan tambahan 25 segil hitam."
  },
  RelicConfig_13801_Desc = {
    Text = "Seluruh kehidupan musuh di dalam pertarungan reguler meningkat 30%, dan pada saat kemenangan bertarung mendapatkan tambahan 25 segil hitam."
  },
  RelicConfig_13801_Name = {
    Text = "Bendera Perang yang Rusak"
  },
  RelicConfig_13802_BattleDesc = {
    Text = "Mengambilnya akan meningkatkan Kesehatan maksimum sebesar [Arg1] poin. Jika Hidup saat diambil berada di bawah 25%, peningkatan Kesehatan maksimum menjadi [Arg2] poin."
  },
  RelicConfig_13802_Desc = {
    Text = "Mengambilnya akan meningkatkan Kesehatan maksimum sebesar [Arg1] poin. Jika Hidup saat diambil berada di bawah 25%, peningkatan Kesehatan maksimum menjadi [Arg2] poin."
  },
  RelicConfig_13802_Name = {
    Text = "<WhiteQuality: Teh Hitam Ceylon>"
  },
  RelicConfig_13802_StoryDesc = {
    Text = "Makan sehat dimulai dari kamu dan aku."
  },
  RelicConfig_13803_BattleDesc = {
    Text = "Setiap 3 putaran, dapatkan 3 Tentakel sementara."
  },
  RelicConfig_13803_Desc = {
    Text = "Setiap 3 putaran, dapatkan 3 Tentakel sementara."
  },
  RelicConfig_13803_Name = {
    Text = "<WhiteQuality:Topi Selam>"
  },
  RelicConfig_13803_StoryDesc = {
    Text = "Impian adalah lautan bintang!"
  },
  RelicConfig_13804_BattleDesc = {
    Text = "Pada akhir ronde, dapatkan [Arg1] poin perisai. Jika perisaimu adalah 0 atau kelipatan 3, dapatkan [Arg2] poin <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13804_Desc = {
    Text = "Pada akhir ronde, dapatkan [Arg1] poin perisai. Jika perisaimu adalah 0 atau kelipatan 3, dapatkan [Arg2] poin <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13804_Name = {
    Text = "<OrangeQuality:Sinyal Darurat>"
  },
  RelicConfig_13804_StoryDesc = {
    Text = "Dia tidak menunggu hingga bantuan tiba."
  },
  RelicConfig_13806_BattleDesc = {
    Text = "Saat mendapatkan kartu gejala, peroleh [Arg1] poin sementara <PowerIconKeywords:Kekuatan>. Untuk setiap 1 Relik terkutuk yang kamu miliki, Crit. Rate dan Crit. DMG meningkat sebesar 10%."
  },
  RelicConfig_13806_Desc = {
    Text = "Saat mendapatkan kartu gejala, peroleh [Arg1] poin sementara <PowerIconKeywords:Kekuatan>. Untuk setiap 1 Relik terkutuk yang kamu miliki, Crit. Rate dan Crit. DMG meningkat sebesar 10%."
  },
  RelicConfig_13806_Name = {
    Text = "<OrangeQuality:Komunikasi Jurang>"
  },
  RelicConfig_13806_StoryDesc = {
    Text = [[
Di daerah pinggiran yang sunyi dan tak berpenghuni, bel telepon berbunyi di dalam bilik telepon yang kesepian. 
 "Gelap... desis... tanpa batas... desis-desis... kegelapan..."]]
  },
  RelicConfig_13807_BattleDesc = {
    Text = "Pada awal pertempuran <EmbryoFusionIconKeywords:Fusi Embrio> +50. Untuk setiap Awakener dengan setidaknya 50 poin Aliemus, efek tambahan diaktifkan 1 kali"
  },
  RelicConfig_13807_Desc = {
    Text = "Pada awal pertempuran <EmbryoFusionIconKeywords:Fusi Embrio> +50. Untuk setiap Awakener dengan setidaknya 50 poin Aliemus, efek tambahan diaktifkan 1 kali."
  },
  RelicConfig_13807_Name = {
    Text = "<WhiteQuality:Sayang tersayang>"
  },
  RelicConfig_13807_StoryDesc = {
    Text = "Tukang kayu membuat boneka kayu yang sangat hidup untuk istrinya. Boneka itu akan menggantikan anak mereka, yang sedang tertidur di dalam perutnya."
  },
  RelicConfig_13808_BattleDesc = {
    Text = "Setelah melepaskan ledakan kegilaan, masukkan sebuah kartu acak yang berkaitan dengan Pembangun ke tangan, kartu ini mendapatkan <DepleteIconKeywords:Lelah> dan <NothingnessIconKeywords:Ilusi>. Setelah pertempuran berakhir, pulihkan [Arg1] poin hidup."
  },
  RelicConfig_13808_Desc = {
    Text = "Setelah melepaskan ledakan kegilaan, masukkan sebuah kartu acak yang berkaitan dengan Pembangun ke tangan, kartu ini mendapatkan <DepleteIconKeywords:Lelah> dan <NothingnessIconKeywords:Ilusi>. Setelah pertempuran berakhir, pulihkan [Arg1] poin hidup."
  },
  RelicConfig_13808_Name = {
    Text = "<WhiteQuality:Tas Dokter>"
  },
  RelicConfig_13808_StoryDesc = {
    Text = [[
Koper tangan yang melambangkan identitas seorang Dokter, sangat berat.
Orang yang membukanya belum tentu adalah Dokter sungguhan.]]
  },
  RelicConfig_13809_BattleDesc = {
    Text = "Harga semua Relik berkurang sebesar 20."
  },
  RelicConfig_13809_Desc = {
    Text = "Harga semua Relik berkurang sebesar 20."
  },
  RelicConfig_13809_Name = {
    Text = "<WhiteQuality:Licik dan Cepat>"
  },
  RelicConfig_13809_StoryDesc = {
    Text = "Bukan hanya pedagang yang pandai bicara, tetapi juga orang-orang yang taat beragama."
  },
  RelicConfig_13811_BattleDesc = {
    Text = "Setiap setelah play \"Pukulan\" ke-3, berikan [Arg1] poin <FixedDamage:Kerusakan Murni> kepada semua musuh, Awakener yang bersangkutan mendapatkan 15 Aliemus."
  },
  RelicConfig_13811_Desc = {
    Text = "Setiap setelah play \"Pukulan\" ke-3, berikan [Arg1] poin <FixedDamage:Kerusakan Murni> kepada semua musuh, Awakener yang bersangkutan mendapatkan 15 Aliemus."
  },
  RelicConfig_13811_Name = {
    Text = "<WhiteQuality:Belati Willow Berkarat>"
  },
  RelicConfig_13811_StoryDesc = {
    Text = "Tidak cocok untuk memotong makhluk hidup."
  },
  RelicConfig_13812_BattleDesc = {
    Text = "Meningkatkan Kesehatan Maksimum sebesar 100% saat diambil, kehilangan [Arg1] poin Hidup saat giliran dimulai."
  },
  RelicConfig_13812_Desc = {
    Text = "Meningkatkan Kesehatan Maksimum sebesar 100% saat diambil, kehilangan [Arg1] poin Hidup saat giliran dimulai."
  },
  RelicConfig_13812_Name = {
    Text = "<RedQuality:☆Caro Abadi☆>"
  },
  RelicConfig_13812_StoryDesc = {
    Text = "\"Makhluk laut terbiasa memutuskan lengan mereka untuk bertahan hidup.\""
  },
  RelicConfig_13813_BattleDesc = {
    Text = "Setelah pertempuran dimulai, nyawa saat ini dari musuh elit dan musuh bos berkurang sebesar 20%."
  },
  RelicConfig_13813_Desc = {
    Text = "Setelah pertempuran dimulai, nyawa saat ini dari musuh elit dan musuh bos berkurang sebesar 20%."
  },
  RelicConfig_13813_Name = {
    Text = "<WhiteQuality:☆Jangkar Lama☆>"
  },
  RelicConfig_13813_StoryDesc = {
    Text = "Cepat pulanglah, pelaut tua."
  },
  RelicConfig_13814_BattleDesc = {
    Text = "Pada akhir ronde, untuk setiap 1 Kartu yang belum dimainkan di tangan, berikan 2 Aliemus kepada semua Pembangun."
  },
  RelicConfig_13814_Desc = {
    Text = "Pada akhir ronde, untuk setiap 1 Kartu yang belum dimainkan di tangan, berikan 2 Aliemus kepada semua Pembangun."
  },
  RelicConfig_13814_Name = {
    Text = "<WhiteQuality:Timbangan yang Tidak Seimbang>"
  },
  RelicConfig_13814_StoryDesc = {
    Text = "Tidak lagi menjadi simbol keadilan."
  },
  RelicConfig_13815_BattleDesc = {
    Text = "Setelah mengambil, pilih satu Kartu untuk membuat konsumsi Lelah Aritmetikanya berubah secara permanen menjadi 1."
  },
  RelicConfig_13815_Desc = {
    Text = "Setelah mengambil, pilih satu Kartu untuk membuat konsumsi Lelah Aritmetikanya berubah secara permanen menjadi 1."
  },
  RelicConfig_13815_Name = {
    Text = "<WhiteQuality:☆Mata Buatan Halus☆>"
  },
  RelicConfig_13815_StoryDesc = {
    Text = "Sebuah bola mata yang tidak lagi murni."
  },
  RelicConfig_13816_BattleDesc = {
    Text = "Pada awal pertempuran, semua musuh mendapatkan [Arg1] poin <RetaliateIconKeywords:Counter>. Setiap kali kerusakan diberikan, Pembangun dengan Aliemus terendah mendapatkan 6 poin Aliemus."
  },
  RelicConfig_13816_Desc = {
    Text = "Pada awal pertempuran, semua musuh mendapatkan [Arg1] poin <RetaliateIconKeywords:Counter>. Setiap kali kerusakan diberikan, Pembangun dengan Aliemus terendah mendapatkan 6 poin Aliemus."
  },
  RelicConfig_13816_Name = {
    Text = "<RedQuality:☆Lonceng Ratapan☆>"
  },
  RelicConfig_13816_StoryDesc = {
    Text = [[
Ting, ting, anak menangis;
Ting, ting, anak berteriak.
Ting, ting, anak meratap;
Ting, ting, ia lapar, kau tahu.]]
  },
  RelicConfig_13817_BattleDesc = {
    Text = "Setelah menggunakan 6 Kartu perintah, <TentacleInjurieIconKeywords:Kerusakan tentakel> +[Arg1]."
  },
  RelicConfig_13817_Desc = {
    Text = "Setelah menggunakan 6 Kartu perintah, <TentacleInjurieIconKeywords:Kerusakan tentakel> +[Arg1]."
  },
  RelicConfig_13817_Name = {
    Text = "<WhiteQuality:Belatung Pecah Kepala>"
  },
  RelicConfig_13817_StoryDesc = {
    Text = "Selama otak kita masih menjadi misteri, maka tidak ada yang perlu terkejut jika di dalamnya penuh dengan tentakel."
  },
  RelicConfig_13818_BattleDesc = {
    Text = "Meningkatkan Crit. Rate sebesar 50%, tetapi <FragileIconKeywords:Rapuh> diri sendiri selama 3 putaran di awal pertempuran."
  },
  RelicConfig_13818_Desc = {
    Text = "Meningkatkan Crit. Rate sebesar 50%, tetapi <FragileIconKeywords:Rapuh> diri sendiri selama 3 putaran di awal pertempuran."
  },
  RelicConfig_13818_Name = {
    Text = "<RedQuality:Cakar Aneh>"
  },
  RelicConfig_13818_StoryDesc = {
    Text = "Spesies yang sulit dikenali."
  },
  RelicConfig_13819_BattleDesc = {
    Text = "Ketika memainkan 1 Kartu dengan Lelah Aritmetika sebesar 3 atau lebih, tarik 1 Kartu dan dapatkan 1 poin Aritmetika."
  },
  RelicConfig_13819_Desc = {
    Text = "Ketika memainkan 1 Kartu dengan Lelah Aritmetika sebesar 3 atau lebih, tarik 1 Kartu dan dapatkan 1 poin Aritmetika."
  },
  RelicConfig_13819_Name = {
    Text = "<OrangeQuality:☆Kecantikan yang Hilang☆>"
  },
  RelicConfig_13819_StoryDesc = {
    Text = "Tidak ada yang mengingat keindahannya lagi."
  },
  RelicConfig_13820_BattleDesc = {
    Text = "Setiap kali mendapatkan Kartu Gejala, tingkatkan Kesehatan maksimum sebesar [Arg1] poin."
  },
  RelicConfig_13820_Desc = {
    Text = "Setiap kali mendapatkan Kartu Gejala, tingkatkan Kesehatan maksimum sebesar [Arg1] poin."
  },
  RelicConfig_13820_Name = {
    Text = "<WhiteQuality:☆Bahan Rempah Susu☆>"
  },
  RelicConfig_13820_StoryDesc = {
    Text = "\"Aroma manis yang menggoda.\""
  },
  RelicConfig_13821_BattleDesc = {
    Text = "Setelah melepaskan Muliakan, tarik 1 kartu. Jika Hidup berada di bawah 25%, tarik 1 kartu tambahan."
  },
  RelicConfig_13821_Desc = {
    Text = "Setelah melepaskan Muliakan, tarik 1 kartu. Jika Hidup berada di bawah 25%, tarik 1 kartu tambahan."
  },
  RelicConfig_13821_Name = {
    Text = "<OrangeQuality:Roda Membaca untuk Pengetahuan>"
  },
  RelicConfig_13821_StoryDesc = {
    Text = "Harap perhatikan keselamatan saat membaca."
  },
  RelicConfig_13822_BattleDesc = {
    Text = "Setiap kali memberikan kerusakan aktif per ronde, tingkatkan [Arg1] poin <TentacleInjurieIconKeywords:kerusakan tentakel> sementara, hingga maksimal 3 kali tumpukan. Saat jumlah tumpukan penuh, hasilkan 1 tentakel sementara yang mengabaikan batas maksimal tentakel."
  },
  RelicConfig_13822_Desc = {
    Text = "Setiap kali memberikan kerusakan aktif per ronde, tingkatkan [Arg1] poin <TentacleInjurieIconKeywords:Kerusakan tentakel> sementara, hingga maksimal 3 kali tumpukan. Saat jumlah tumpukan penuh, hasilkan 1 tentakel sementara yang mengabaikan batas maksimal tentakel."
  },
  RelicConfig_13822_Name = {
    Text = "<OrangeQuality:Kegembiraan Luo Yan>"
  },
  RelicConfig_13822_StoryDesc = {
    Text = "Tuan Pemimpin Tidur Panjang, menantimu dalam mimpi."
  },
  RelicConfig_13823_BattleDesc = {
    Text = "Setiap kartu perintah ke-[Arg1] yang kamu gunakan akan berlaku 2 kali, setelah digunakan kembali ke tangan."
  },
  RelicConfig_13823_Desc = {
    Text = "Setiap kartu perintah ke-[Arg1] yang kamu gunakan akan berlaku 2 kali, setelah digunakan kembali ke tangan."
  },
  RelicConfig_13823_Name = {
    Text = "<OrangeQuality:Anggur Bintang+>"
  },
  RelicConfig_13823_StoryDesc = {
    Text = "Melangkah di antara bintang-bintang."
  },
  RelicConfig_13824_BattleDesc = {
    Text = "Pada setiap awal ronde, <DeathResistanceIconKeywords:Ketahanan> meningkat 10% (setiap kali Ketahanan dipicu dalam level ini, jumlah Ketahanan yang diperoleh berkurang setengahnya). <DeathResistanceIconKeywords:Ketahanan> berada di atas 100%, <ProficientInRealmsIconKeywords:Penguasaan Alam> meningkat 100."
  },
  RelicConfig_13824_Desc = {
    Text = "Pada setiap awal ronde, <DeathResistanceIconKeywords:Ketahanan> meningkat 10% (setiap kali Ketahanan dipicu dalam level ini, jumlah Ketahanan yang diperoleh berkurang setengahnya). <DeathResistanceIconKeywords:Ketahanan> berada di atas 100%, <ProficientInRealmsIconKeywords:Penguasaan Alam> meningkat 100."
  },
  RelicConfig_13824_Name = {
    Text = "<WhiteQuality:Air Mata Putri Duyung>"
  },
  RelicConfig_13824_StoryDesc = {
    Text = "Jangan masukkannya ke dalam air."
  },
  RelicConfig_13825_BattleDesc = {
    Text = "Setiap Lelah 10 Segil hitam, pulihkan [Arg1] poin Hidup."
  },
  RelicConfig_13825_Desc = {
    Text = "Setiap Lelah 10 Segil hitam, pulihkan 1% Hidup."
  },
  RelicConfig_13825_Name = {
    Text = "Akar Terbalik"
  },
  RelicConfig_13826_BattleDesc = {
    Text = "Setiap kali kamu memainkan kartu \"Buff\"/\"Gejala\"/\"Negara\", Pembangun dengan Aliemus terendah mendapatkan 10 Aliemus."
  },
  RelicConfig_13826_Desc = {
    Text = "Setiap kali kamu memainkan kartu \"Buff\"/\"Gejala\"/\"Negara\", Pembangun dengan Aliemus terendah mendapatkan 10 Aliemus."
  },
  RelicConfig_13826_Name = {
    Text = "<WhiteQuality:Album Perangko Asing>"
  },
  RelicConfig_13826_StoryDesc = {
    Text = "Kerinduan yang terukur."
  },
  RelicConfig_13827_BattleDesc = {
    Text = "Setelah mengambil, dapatkan 75 Segil hitam. Pilih 1 Relik dan ubah menjadi 1 Relik terkutuk secara acak."
  },
  RelicConfig_13827_Desc = {
    Text = "Setelah mengambil, dapatkan 75 Segil hitam. Pilih 1 Relik dan ubah menjadi 1 Relik terkutuk secara acak."
  },
  RelicConfig_13827_Name = {
    Text = "<RedQuality:Prasasti Kutukan>"
  },
  RelicConfig_13827_StoryDesc = {
    Text = "Saat dielus, terdengar panggilan dari Aequor."
  },
  RelicConfig_13828_BattleDesc = {
    Text = "Setelah kartu perintah pertama kali dimainkan dalam setiap ronde masuk ke tumpukan kartu buang, salinan sementara dari kartu tersebut dengan pengurangan konsumsi aritmetika sebesar 1 akan dicuci ke dalam tumpukan menggambar."
  },
  RelicConfig_13828_Desc = {
    Text = "Setelah kartu perintah pertama kali dimainkan dalam setiap ronde masuk ke tumpukan kartu buang, salinan sementara dari kartu tersebut dengan pengurangan konsumsi aritmetika sebesar 1 akan dicuci ke dalam tumpukan menggambar."
  },
  RelicConfig_13828_Name = {
    Text = "<WhiteQuality:Pemutar Suara yang Hilang>"
  },
  RelicConfig_13828_StoryDesc = {
    Text = "Suaranya menghilang tertiup angin."
  },
  RelicConfig_13829_BattleDesc = {
    Text = "Sekumpulan kunci yang berkarat. Dapat digunakan untuk membuka kunci pintu."
  },
  RelicConfig_13829_Desc = {
    Text = "Sekumpulan kunci yang berkarat. Dapat digunakan untuk membuka kunci pintu."
  },
  RelicConfig_13829_Name = {
    Text = "Kunci berkarat"
  },
  RelicConfig_13830_BattleDesc = {
    Text = "Saat menyebabkan pemulihan hidup, juga akan memperoleh [Arg1] poin perisai. Setelah ronde ke-3 dimulai, memperoleh [Arg2] poin <AlertIconKeywords:Waspada>."
  },
  RelicConfig_13830_Desc = {
    Text = "Saat menyebabkan pemulihan hidup, juga akan memperoleh [Arg1] poin perisai. Setelah ronde ke-3 dimulai, memperoleh [Arg2] poin <AlertIconKeywords:Waspada>."
  },
  RelicConfig_13830_Name = {
    Text = "<WhiteQuality:Spesimen kupu-kupu>"
  },
  RelicConfig_13830_StoryDesc = {
    Text = "Hingga saat ini, dia juga sangat dicintai oleh seseorang."
  },
  RelicConfig_13831_BattleDesc = {
    Text = "Setiap kali kartu perintah memasuki <DimensionalSpaceIconKeywords:Ultra Space>, berikan 15 Aliemus kepada Pembangun yang sesuai."
  },
  RelicConfig_13831_Desc = {
    Text = "Setiap kali kartu perintah memasuki <DimensionalSpaceIconKeywords:Ultra Space>, berikan 15 Aliemus kepada Pembangun yang sesuai."
  },
  RelicConfig_13831_Name = {
    Text = "<WhiteQuality:Cacing Waktu>"
  },
  RelicConfig_13831_StoryDesc = {
    Text = [[
Sebuah jam saku yang secara bersamaan berada di toko jam dan museum serangga. 
 Setelah dimulainya tahun Hongji, jam tersebut dimasukkan ke dalam koleksi universitas.]]
  },
  RelicConfig_13832_BattleDesc = {
    Text = "Setelah memasuki ronde Ultra, hilangkan status <WeaknessIconKeywords:Kelemahan> dan <FragileIconKeywords:Rapuh> pada diri sendiri, dan <WeaknessIconKeywords:Kelemahan> serta <VulnerabilityIconKeywords:Rentan> semua musuh selama 3 ronde. Pada ronde ini, kerusakan akhir semua Awakener meningkat sebesar 15%."
  },
  RelicConfig_13832_Desc = {
    Text = "Setelah memasuki ronde Ultra, hilangkan status <WeaknessIconKeywords:Kelemahan> dan <FragileIconKeywords:Rapuh> pada diri sendiri, dan <WeaknessIconKeywords:Kelemahan> serta <VulnerabilityIconKeywords:Rentan> pada semua musuh selama 3 ronde. Pada ronde ini, semua Awakener mendapatkan peningkatan kerusakan akhir sebesar 15%."
  },
  RelicConfig_13832_Name = {
    Text = "<WhiteQuality:Jam Saku Superstring>"
  },
  RelicConfig_13832_StoryDesc = {
    Text = "\"Ah, jam saku berhenti.\""
  },
  RelicConfig_13833_BattleDesc = {
    Text = "Setiap kali memberikan 1 Kerusakan, tambahkan [Arg1] lapisan <IntoxicationIconKeywords:Racun> pada target. Jika jumlah pemicu dalam Pertempuran ini mencapai 25 kali, segera aktifkan <IntoxicationIconKeywords:Racun> untuk semua musuh."
  },
  RelicConfig_13833_Desc = {
    Text = "Setiap kali memberikan 1 Kerusakan, tambahkan [Arg1] lapisan <IntoxicationIconKeywords:Racun> pada target. Jika jumlah pemicu dalam Pertempuran ini mencapai 25 kali, segera aktifkan <IntoxicationIconKeywords:Racun> untuk semua musuh."
  },
  RelicConfig_13833_Name = {
    Text = "<OrangeQuality:☆Mesin Jahit Berdebu☆>"
  },
  RelicConfig_13833_StoryDesc = {
    Text = "Seorang ibu yang penuh kasih, menjahit luka di hati."
  },
  RelicConfig_13834_BattleDesc = {
    Text = "Setiap kali ke-5 memperoleh <Perisai>, juga memperoleh <RetaliateIconKeywords:Counter>, nilai Counter sama dengan [Arg1]% dari Perisai yang diperoleh."
  },
  RelicConfig_13834_Desc = {
    Text = "Setiap kali ke-5 memperoleh <Perisai>, juga memperoleh <RetaliateIconKeywords:Counter>, nilai Counter sama dengan [Arg1]% dari Perisai yang diperoleh."
  },
  RelicConfig_13834_Name = {
    Text = "<OrangeQuality: Bab Pendahuluan>"
  },
  RelicConfig_13834_StoryDesc = {
    Text = "\"Manusia begitu bodoh, hanya karena sesuatu yang kuno, mereka akan percaya secara membabi buta.\""
  },
  RelicConfig_13835_BattleDesc = {
    Text = "Pada awal ronde, tarik 1 kartu."
  },
  RelicConfig_13835_Desc = {
    Text = "Pada awal ronde, tarik 1 kartu."
  },
  RelicConfig_13835_Name = {
    Text = "<WhiteQuality: Kompas Terarah>"
  },
  RelicConfig_13835_StoryDesc = {
    Text = "Yang ditunjukkan bukan arah, melainkan medan magnet."
  },
  RelicConfig_13836_BattleDesc = {
    Text = "Pada awal pertempuran, secara acak tempatkan <DerivativeCardKeywords_3:\"Kejang\"> dan <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam <DimensionalSpaceIconKeywords:ruang ultra> hingga mencapai batas maksimum. Setelah memasuki ronde ultra, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13836_Desc = {
    Text = "Pada awal pertempuran, secara acak tempatkan <DerivativeCardKeywords_3:\"Kejang\"> dan <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam <DimensionalSpaceIconKeywords:ruang ultra> hingga mencapai batas maksimum. Setelah memasuki ronde ultra, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13836_Name = {
    Text = "<RedQuality:Alat Alfonso>"
  },
  RelicConfig_13836_StoryDesc = {
    Text = "Berbeda dengan takdir yang selalu berubah, bintang-bintang memiliki aturan pergerakan mereka sendiri."
  },
  RelicConfig_13837_BattleDesc = {
    Text = "Mendapatkan 100% <DeathResistanceIconKeywords:Ketahanan> saat diambil (setiap kali Ketahanan dipicu dalam level ini, jumlah Ketahanan yang diperoleh berkurang setengahnya). Setelah memicu <DeathResistanceIconKeywords:Ketahanan>, pada setiap awal ronde Pertempuran, pulihkan [Arg1] poin Hidup."
  },
  RelicConfig_13837_Desc = {
    Text = "Mendapatkan 100% <DeathResistanceIconKeywords:Ketahanan> saat diambil (setiap kali Ketahanan dipicu dalam level ini, jumlah Ketahanan yang diperoleh berkurang setengahnya). Setelah memicu <DeathResistanceIconKeywords:Ketahanan>, pada setiap awal ronde Pertempuran, pulihkan [Arg1] poin Hidup."
  },
  RelicConfig_13837_Name = {
    Text = "<WhiteQuality:Resusitasi>"
  },
  RelicConfig_13837_StoryDesc = {
    Text = "Barang penting bagi para penjelajah. Jika terlalu bergantung padanya, itu akan menjadi bagian dari dirimu."
  },
  RelicConfig_13838_BattleDesc = {
    Text = "Ini adalah Relik tanpa Efek 2"
  },
  RelicConfig_13838_Desc = {
    Text = "Ini adalah Relik tanpa Efek 2"
  },
  RelicConfig_13838_Name = {
    Text = "Misi Uji Ciptaan 2"
  },
  RelicConfig_13838_StoryDesc = {
    Text = "Relik yang memerlukan konten tambahan"
  },
  RelicConfig_13839_BattleDesc = {
    Text = "Saat memainkan kartu terakhir di tangan, tarik 2 kartu. Setiap ronde dapat dipicu maksimal 2 kali."
  },
  RelicConfig_13839_Desc = {
    Text = "Saat memainkan kartu terakhir di tangan, tarik 2 kartu. Setiap ronde dapat dipicu maksimal 2 kali."
  },
  RelicConfig_13839_Name = {
    Text = "<WhiteQuality:☆Sarung Tangan Sihir☆>"
  },
  RelicConfig_13839_StoryDesc = {
    Text = "\"Jangan takut, ini hanya sulap.\""
  },
  RelicConfig_13840_BattleDesc = {
    Text = "Setiap 3 ronde, tambahkan 1 lapisan <WeaknessIconKeywords:Kelemahan> pada semua musuh. Setelah memberikan kerusakan kepada musuh dengan status <WeaknessIconKeywords:Kelemahan>, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan> sementara. Efek ini dapat terpicu maksimal 3 kali per ronde."
  },
  RelicConfig_13840_Desc = {
    Text = "Setiap 3 ronde, tambahkan 1 lapisan <WeaknessIconKeywords:Kelemahan> pada semua musuh. Setelah memberikan kerusakan kepada musuh dengan status <WeaknessIconKeywords:Kelemahan>, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan> sementara. Efek ini dapat terpicu maksimal 3 kali per ronde."
  },
  RelicConfig_13840_Name = {
    Text = "<WhiteQuality:Anak Jahat>"
  },
  RelicConfig_13840_StoryDesc = {
    Text = "Terlahir dari kejahatan murni, meskipun itu bukanlah keinginannya."
  },
  RelicConfig_13841_BattleDesc = {
    Text = "Semua kerusakan kritis dari \"pukulan\" meningkat sebesar 20%. Saat pertempuran dimulai, tambahkan 1 kartu <DerivativeCardKeywords_40:\"Momen Indah\"> ke tangan."
  },
  RelicConfig_13841_Desc = {
    Text = "Semua kerusakan kritis dari \"pukulan\" meningkat sebesar 20%. Saat pertempuran dimulai, tambahkan 1 kartu <DerivativeCardKeywords_40:\"Momen Indah\"> ke tangan."
  },
  RelicConfig_13841_Name = {
    Text = "<WhiteQuality:Momen Indah>"
  },
  RelicConfig_13841_StoryDesc = {
    Text = "Menyimpan keindahan sesaat untuk selamanya."
  },
  RelicConfig_13842_BattleDesc = {
    Text = "Kebal terhadap satu kerusakan fatal yang tidak memicu ketahanan kematian, pulihkan [Arg1] hidup, dan nonaktifkan relik ini secara permanen."
  },
  RelicConfig_13842_Desc = {
    Text = "Kebal terhadap satu kerusakan fatal yang tidak memicu ketahanan kematian, pulihkan [Arg1] hidup, dan nonaktifkan relik ini secara permanen."
  },
  RelicConfig_13842_Name = {
    Text = "<OrangeQuality:Boneka Ganda>"
  },
  RelicConfig_13842_StoryDesc = {
    Text = "Hi hi hi, hi hi hi. Apakah ini hutangmu padaku?"
  },
  RelicConfig_13844_BattleDesc = {
    Text = "Ketika kamu menyebabkan <WeaknessIconKeywords:Kelemahan>, dapatkan [Arg1] poin Perisai; ketika menyebabkan <VulnerabilityIconKeywords:Rentan>, dapatkan [Arg2] poin sementara <PowerIconKeywords:Kekuatan>. Jika kedua Efek ini terpicu dalam 1 putaran, dapatkan tambahan [Arg1] poin Perisai dan [Arg2] poin sementara <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13844_Desc = {
    Text = "Ketika kamu menyebabkan <WeaknessIconKeywords:Kelemahan>, dapatkan [Arg1] poin Perisai; ketika menyebabkan <VulnerabilityIconKeywords:Rentan>, dapatkan [Arg2] poin sementara <PowerIconKeywords:Kekuatan>. Jika kedua efek ini terpicu dalam 1 putaran, dapatkan tambahan [Arg1] poin Perisai dan [Arg2] poin sementara <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13844_Name = {
    Text = "<OrangeQuality:Bingkai Berat>"
  },
  RelicConfig_13844_StoryDesc = {
    Text = "Karya terakhir seorang seniman yang mengalami gangguan roh, konon dapat melihat wajahnya yang penuh ketakutan di dalamnya."
  },
  RelicConfig_13845_BattleDesc = {
    Text = "Ketika poin Aritmetika terakhir habis, dapatkan 2 Aritmetika. Maksimal dipicu 2 kali per ronde."
  },
  RelicConfig_13845_Desc = {
    Text = "Ketika poin Aritmetika terakhir habis, dapatkan 2 Aritmetika. Maksimal dipicu 2 kali per ronde."
  },
  RelicConfig_13845_Name = {
    Text = "<OrangeQuality:☆Mesin Diferensial Perak Putih☆>"
  },
  RelicConfig_13845_StoryDesc = {
    Text = "\"Itu mengubah sejarah.\""
  },
  RelicConfig_13846_BattleDesc = {
    Text = "Setiap kali kamu kehilangan Hidup, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan>, hingga 10 kali tumpukan dalam setiap Pertempuran. Saat tumpukan mencapai maksimum, pulihkan 25% dari Hidup yang telah hilang."
  },
  RelicConfig_13846_Desc = {
    Text = "Setiap kali kamu kehilangan Hidup, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan>, hingga 10 kali tumpukan dalam setiap Pertempuran. Saat tumpukan mencapai maksimum, pulihkan 25% dari Hidup yang telah hilang."
  },
  RelicConfig_13846_Name = {
    Text = "<OrangeQuality:Kehormatan Tertinggi>"
  },
  RelicConfig_13846_StoryDesc = {
    Text = [[
Kucing hitam berbulu pendek yang anggun dan misterius, dikatakan di suatu negara padang pasir yang jauh dianggap sebagai manifestasi dari Dewa. Namun, nama Dewa tersebut kini tak seorang pun yang mengetahuinya. 
Dibanggakan, dihormati, dilupakan, mungkin itulah takdir para Dewa.]]
  },
  RelicConfig_13847_BattleDesc = {
    Text = "Kerusakan terhadap musuh dalam kondisi negara meningkat sebesar 20%, setelah membunuh musuh, pembunuh mendapatkan 20 Aliemus."
  },
  RelicConfig_13847_Desc = {
    Text = "Kerusakan terhadap musuh dalam kondisi negara meningkat sebesar 20%, setelah membunuh musuh, pembunuh mendapatkan 20 Aliemus."
  },
  RelicConfig_13847_Name = {
    Text = "<OrangeQuality:Tongkat Pendeta>"
  },
  RelicConfig_13847_StoryDesc = {
    Text = "Ketakwaan yang tidak diperbolehkan."
  },
  RelicConfig_13848_BattleDesc = {
    Text = "Saat mengambil, penguasaan alam tim menjadi 150% dari nilai aslinya. Setelah memainkan kartu perintah ke-5 setiap putaran, semua Pembangun mendapatkan 20 Aliemus."
  },
  RelicConfig_13848_Desc = {
    Text = "Saat mengambil, penguasaan alam tim menjadi 150% dari nilai aslinya. Setelah memainkan kartu perintah ke-5 setiap putaran, semua Pembangun mendapatkan 20 Aliemus."
  },
  RelicConfig_13848_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Tidak Suci\">"
  },
  RelicConfig_13849_BattleDesc = {
    Text = "Setelah memberikan kerusakan ketiga kalinya per ronde, dapatkan [Arg1] poin perisai. Setelah memberikan kerusakan keenam kalinya per ronde, dapatkan [Arg2] poin <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13849_Desc = {
    Text = "Setelah memberikan kerusakan ketiga kalinya per ronde, dapatkan [Arg1] poin perisai. Setelah memberikan kerusakan keenam kalinya per ronde, dapatkan [Arg2] poin <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13849_Name = {
    Text = "<WhiteQuality:Keluar Darurat>"
  },
  RelicConfig_13849_StoryDesc = {
    Text = "Tampaknya, dia juga tidak berhasil keluar."
  },
  RelicConfig_13851_BattleDesc = {
    Text = "Setiap melakukan 1 kali <DevouredIconKeywords:Melahap>, mencuri [Arg1] poin <PowerIconKeywords:Kekuatan> sementara dari semua musuh."
  },
  RelicConfig_13851_Desc = {
    Text = "Setiap melakukan 1 kali <DevouredIconKeywords:Melahap>, mencuri [Arg1] poin <PowerIconKeywords:Kekuatan> sementara dari semua musuh."
  },
  RelicConfig_13851_Name = {
    Text = "<OrangeQuality:Tangan Kosong yang Cerdik>"
  },
  RelicConfig_13851_StoryDesc = {
    Text = "Alat yang sempurna untuk membunuh, merampok, dan menggaruk gatal."
  },
  RelicConfig_13852_BattleDesc = {
    Text = "Saat mengambil, pilih satu Pembangun untuk dibangunkan, konsumsi Aritmetika kartu bangunnya akan berkurang 1 secara permanen."
  },
  RelicConfig_13852_Desc = {
    Text = "Saat mengambil, pilih satu Pembangun untuk dibangunkan, konsumsi Aritmetika kartu bangunnya akan berkurang 1 secara permanen."
  },
  RelicConfig_13852_Name = {
    Text = "<WhiteQuality:Easter Egg Time>"
  },
  RelicConfig_13852_StoryDesc = {
    Text = "Nikmati kebahagiaan, namun tidak bisa dimakan."
  },
  RelicConfig_13853_BattleDesc = {
    Text = "Setiap kali memberikan Kerusakan, dapatkan [Arg1] poin <RetaliateIconKeywords:Counter> sementara, maksimal terpicu 5 kali per ronde. Saat pemicuan ke-5, tempatkan satu kartu <DerivativeCardKeywords_4:「Inspirasi」> ke dalam tumpukan Menggambar."
  },
  RelicConfig_13853_Desc = {
    Text = "Setiap kali memberikan Kerusakan, dapatkan [Arg1] poin <RetaliateIconKeywords:Counter> sementara, maksimal terpicu 5 kali per ronde. Saat pemicuan ke-5, tempatkan satu kartu <DerivativeCardKeywords_4:「Inspirasi」> ke dalam tumpukan Menggambar."
  },
  RelicConfig_13853_Name = {
    Text = "<WhiteQuality:Pisau Ritual yang Terlupakan>"
  },
  RelicConfig_13853_StoryDesc = {
    Text = "Belati dengan mata pisaunya yang melengkung, sering digunakan dalam ritual pengorbanan."
  },
  RelicConfig_13854_BattleDesc = {
    Text = "Di awal putaran, ambil 2 kartu, dan mendapatkan 2 poin Aritmetika. Setiap kali kamu mengambil 1 kartu Kartu perintah atau Gnosis, secara acak mengubah biaya Aritmetikanya. （0-4）"
  },
  RelicConfig_13854_Desc = {
    Text = "Di awal putaran, ambil 2 kartu, dan mendapatkan 2 poin Aritmetika. Setiap kali kamu mengambil 1 kartu Kartu perintah atau Gnosis, secara acak mengubah biaya Aritmetikanya. （0-4）"
  },
  RelicConfig_13854_Name = {
    Text = "<RedQuality:Topi ajaib>"
  },
  RelicConfig_13854_StoryDesc = {
    Text = [[
Selamat datang di sirkus dunia ajaib Nyonya Casiah! Hati-hati, jangan sembarangan menyentuh alat sihir ya. Jika tidak sengaja digigit, itu bisa menjadi masalah. 
 Lagipula, terakhir kali ia merasakan darah, akibatnya sangat horor. 

 Topi tinggi berkedip seolah-olah siap untuk keluar dari kepompong.]]
  },
  RelicConfig_13855_BattleDesc = {
    Text = "Saat putaran dimulai dan setiap kali HP Recovery dalam satu putaran, dapatkan [Arg1] poin <RetaliateIconKeywords:Counter>, maksimal 3 kali Counter per putaran. Saat mencapai batas, picu 100% <RetaliateIconKeywords:Counter> kepada semua musuh."
  },
  RelicConfig_13855_Desc = {
    Text = "Saat putaran dimulai dan setiap kali HP Recovery dalam satu putaran, dapatkan [Arg1] poin <RetaliateIconKeywords:Counter>, maksimal 3 kali Counter per putaran. Saat mencapai batas, picu 100% <RetaliateIconKeywords:Counter> kepada semua musuh."
  },
  RelicConfig_13855_Name = {
    Text = "<OrangeQuality:Kotak Musik Kecil>"
  },
  RelicConfig_13855_StoryDesc = {
    Text = [[
Di kediaman Dexter terdapat banyak koleksi. Sebelum jatuh dan rusak, kotak musik kecil pernah menjadi mainan favorit Nona Kecil Dexter.
Waktu berlalu, ketika Nona Dexter menemukannya kembali, meski gir-nya sudah kendur dan musiknya sumbang, ia masih terus berputar tanpa henti.]]
  },
  RelicConfig_13856_BattleDesc = {
    Text = "Kerusakan kritis meningkat sebesar 15%. \"Serangan\"tingkat kritis meningkat sebesar 40%."
  },
  RelicConfig_13856_Desc = {
    Text = "Kerusakan kritis meningkat sebesar 15%. \"Serangan\"tingkat kritis meningkat sebesar 40%."
  },
  RelicConfig_13856_Name = {
    Text = "<WhiteQuality:Paruh Gagak Putih>"
  },
  RelicConfig_13856_StoryDesc = {
    Text = "Di hadapannya, tidak ada rahasia."
  },
  RelicConfig_13857_BattleDesc = {
    Text = "Setelah melepaskan Muliakan, dapatkan [Arg1] poin <RetaliateIconKeywords:Counter>. Jika ini adalah pemicu ke-6 dalam Pertempuran ini, maka <RetaliateIconKeywords:Counter>-mu akan dilipatgandakan."
  },
  RelicConfig_13857_Desc = {
    Text = "Setelah melepaskan Muliakan, dapatkan [Arg1] poin <RetaliateIconKeywords:Counter>. Jika ini adalah pemicu ke-6 dalam Pertempuran ini, maka <RetaliateIconKeywords:Counter>-mu akan dilipatgandakan."
  },
  RelicConfig_13857_Name = {
    Text = "<OrangeQuality:☆Sextant☆>"
  },
  RelicConfig_13857_StoryDesc = {
    Text = "Yang membimbingmu hanyalah jalan yang salah."
  },
  RelicConfig_13858_BattleDesc = {
    Text = "Setiap ronde menarik 1 kartu tambahan dan mendapatkan 1 poin Aritmetika."
  },
  RelicConfig_13858_Desc = {
    Text = "Setiap ronde menarik 1 kartu tambahan dan mendapatkan 1 poin Aritmetika."
  },
  RelicConfig_13858_Name = {
    Text = "<OrangeQuality:☆Kenangan Indah☆>"
  },
  RelicConfig_13858_StoryDesc = {
    Text = "Ada yang tetap tinggal di musim panas itu selamanya."
  },
  RelicConfig_13859_BattleDesc = {
    Text = "Pada awal ronde, tarik 1 kartu. Pada awal pertempuran, masukkan 1 kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam dek kartumu. Setiap kali berhasil melewati 1 pertempuran akan meningkatkan jumlah <DerivativeCardKeywords_4:\"Inspirasi\"> yang dimasukkan sebanyak 1, hingga maksimal 3 kali."
  },
  RelicConfig_13859_Desc = {
    Text = "Pada awal ronde, tarik 1 kartu. Pada awal pertempuran, masukkan 1 kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam dek kartumu. Setiap kali berhasil melewati 1 pertempuran akan meningkatkan jumlah <DerivativeCardKeywords_4:\"Inspirasi\"> yang dimasukkan sebanyak 1, hingga maksimal 3 kali."
  },
  RelicConfig_13859_Name = {
    Text = "<OrangeQuality:Cermin Plasno>"
  },
  RelicConfig_13859_StoryDesc = {
    Text = "Permainan cahaya dan bayangan."
  },
  RelicConfig_13860_BattleDesc = {
    Text = "Setiap kali kartu Pembangun yang sama dimainkan secara berurutan, Pembangun tersebut mendapatkan 8 Aliemus."
  },
  RelicConfig_13860_Desc = {
    Text = "Setiap kali kartu Pembangun yang sama dimainkan secara berurutan, Pembangun tersebut mendapatkan 8 Aliemus."
  },
  RelicConfig_13860_Name = {
    Text = "<WhiteQuality:Timer Presisi>"
  },
  RelicConfig_13860_StoryDesc = {
    Text = "Salah satu penemuan paling kejam dalam sejarah umat manusia."
  },
  RelicConfig_13861_BattleDesc = {
    Text = "Saat mengambil, pilih satu kartu Pembangun untuk mengurangi konsumsi aritmetikanya sebesar 1, dan anggap kartu tersebut sebagai \"Serangan\"."
  },
  RelicConfig_13861_Desc = {
    Text = "Saat mengambil, pilih satu kartu Pembangun untuk mengurangi konsumsi aritmetikanya sebesar 1, dan anggap kartu tersebut sebagai \"Serangan\"."
  },
  RelicConfig_13861_Name = {
    Text = "<OrangeQuality:Kesalahan Acak>"
  },
  RelicConfig_13861_StoryDesc = {
    Text = "Tertawalah sepuasnya!"
  },
  RelicConfig_13862_BattleDesc = {
    Text = "Setelah diambil, kehilangan permanen [Arg1] <PowerIconKeywords:Kekuatan>. Setiap kali memberikan kerusakan, pulihkan [Arg2] poin hidup, maksimal 6 kali per ronde."
  },
  RelicConfig_13862_Desc = {
    Text = "Setelah diambil, kehilangan permanen [Arg1] <PowerIconKeywords:Kekuatan>. Setiap kali memberikan kerusakan, pulihkan [Arg2] poin hidup, maksimal 6 kali per ronde."
  },
  RelicConfig_13862_Name = {
    Text = "<RedQuality:Ciuman Laut Tujuh Insang>"
  },
  RelicConfig_13862_StoryDesc = {
    Text = "Mau ciuman yang dalam? Yang bisa mengakhiri hidupmu."
  },
  RelicConfig_13863_BattleDesc = {
    Text = "Pada ronde pertama setiap Pertempuran, dapatkan 3 poin Aritmetika."
  },
  RelicConfig_13863_Desc = {
    Text = "Pada ronde pertama setiap Pertempuran, dapatkan 3 poin Aritmetika."
  },
  RelicConfig_13863_Name = {
    Text = "<WhiteQuality:Cermin jam saku>"
  },
  RelicConfig_13863_StoryDesc = {
    Text = "Memori membeku di waktu yang telah berlalu, terkubur dalam kegelapan."
  },
  RelicConfig_13864_BattleDesc = {
    Text = "Setelah memainkan Kartu perintah untuk pertama kalinya setiap putaran, masukkan satu \"Pukulan\" dari Pembangun yang sesuai ke tangan, berikan <NothingnessIconKeywords:Ilusi> dan <DepleteIconKeywords:Lelah>."
  },
  RelicConfig_13864_Desc = {
    Text = "Setelah memainkan Kartu perintah untuk pertama kalinya setiap putaran, masukkan satu \"Pukulan\" dari Pembangun yang sesuai ke tangan, berikan <NothingnessIconKeywords:Ilusi> dan <DepleteIconKeywords:Lelah>."
  },
  RelicConfig_13864_Name = {
    Text = "<WhiteQuality:Poros Baru>"
  },
  RelicConfig_13864_StoryDesc = {
    Text = "Dari desa menuju kota, dari bencana menuju kebangkitan."
  },
  RelicConfig_13865_BattleDesc = {
    Text = "Setelah memainkan Kartu perintah untuk pertama kalinya di setiap ronde, tambahkan satu \"Pertahanan\" dari Pembangun yang sesuai ke tangan dan berikan <NothingnessIconKeywords:Ilusi> serta <DepleteIconKeywords:Lelah>."
  },
  RelicConfig_13865_Desc = {
    Text = "Setelah memainkan Kartu perintah untuk pertama kalinya di setiap ronde, tambahkan satu \"Pertahanan\" dari Pembangun yang sesuai ke tangan dan berikan <NothingnessIconKeywords:Ilusi> serta <DepleteIconKeywords:Lelah>."
  },
  RelicConfig_13865_Name = {
    Text = "<WhiteQuality:Prelude Keheningan>"
  },
  RelicConfig_13865_StoryDesc = {
    Text = [[
Biola terkenal milik violinis ternama Eric Eckschtein.
Saat ini, biola tersebut tidak dapat dimainkan lagi.]]
  },
  RelicConfig_13866_BattleDesc = {
    Text = "Setiap 3 ronde, tambahkan 1 lapisan <VulnerabilityIconKeywords:Vulnerable> pada semua musuh. Setelah memberikan kerusakan kepada musuh dengan status <VulnerabilityIconKeywords:Vulnerable>, buat mereka kehilangan [Arg1] poin sementara <PowerIconKeywords:Kekuatan>, efek ini dapat terpicu maksimal 3 kali per ronde."
  },
  RelicConfig_13866_Desc = {
    Text = "Setiap 3 ronde, tambahkan 1 lapisan <VulnerabilityIconKeywords:Rentan> pada semua musuh. Setelah memberikan kerusakan kepada musuh dengan status <VulnerabilityIconKeywords:Rentan>, buat mereka kehilangan [Arg1] poin <PowerIconKeywords:Kekuatan> sementara, efek ini dapat terpicu maksimal 3 kali per ronde."
  },
  RelicConfig_13866_Name = {
    Text = "<WhiteQuality:Perayaan Musim Semi>"
  },
  RelicConfig_13866_StoryDesc = {
    Text = "Di tengah tawa malam, siluet perahu dayung meluncur dengan leluasa di permukaan danau."
  },
  RelicConfig_13867_BattleDesc = {
    Text = "Batas kartu tangan meningkat 3, tetapi jumlah kartu yang diambil setiap putaran berkurang 1. Buang semua Kartu Gejala dan Kartu Negara di tangan saat akhir putaran, simpan kartu lainnya."
  },
  RelicConfig_13867_Desc = {
    Text = "Batas kartu tangan meningkat 3, tetapi jumlah kartu yang diambil setiap putaran berkurang 1. Buang semua Kartu Gejala dan Kartu Negara di tangan saat akhir putaran, simpan kartu lainnya."
  },
  RelicConfig_13867_Name = {
    Text = "<RedQuality:UkiranKesadaran>"
  },
  RelicConfig_13867_StoryDesc = {
    Text = "Suku kuno percaya bahwa dengan mengukir simbol-simbol khusus pada tengkorak orang mati, jiwa mereka dapat tinggal dan memberikan pendampingan abadi."
  },
  RelicConfig_13868_BattleDesc = {
    Text = "Setelah melepaskan 4 kali Muliakan, Lelah Aritmetika dari semua kartu di tangan berkurang sebesar 1."
  },
  RelicConfig_13868_Desc = {
    Text = "Setelah melepaskan 4 kali Muliakan, Lelah Aritmetika dari semua kartu di tangan berkurang sebesar 1."
  },
  RelicConfig_13868_Name = {
    Text = "<WhiteQuality:☆Peta Pelarian☆>"
  },
  RelicConfig_13868_StoryDesc = {
    Text = "\"Setelah naik ke kapal, silakan temukan pintu keluar darurat terdekat dari kabin Anda terlebih dahulu.\""
  },
  RelicConfig_13869_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Kemahiran Alam> meningkat sebesar 100. Setiap memberikan 1 kali kerusakan aktif, kerusakan tentakel sementara + [Arg1]. Setiap memberikan 1 kali kerusakan tentakel, mendapatkan [Arg2] poin perisai. Maksimal berlaku 6 kali per putaran."
  },
  RelicConfig_13869_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Kemahiran Alam> meningkat sebesar 100. Setiap memberikan 1 kali kerusakan aktif, kerusakan tentakel sementara + [Arg1]. Setiap memberikan 1 kali kerusakan tentakel, mendapatkan [Arg2] poin perisai. Maksimal berlaku 6 kali per putaran."
  },
  RelicConfig_13869_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Mimpi Buruk\">"
  },
  RelicConfig_13870_BattleDesc = {
    Text = "Setiap Lelah 1 poin Aritmetika, berikan 2 poin Aliemus kepada Pembangun yang sesuai."
  },
  RelicConfig_13870_Desc = {
    Text = "Setiap Lelah 1 poin Aritmetika, berikan 2 poin Aliemus kepada Pembangun yang sesuai."
  },
  RelicConfig_13870_Name = {
    Text = "<WhiteQuality:Pita Gesper Berwarna Perak>"
  },
  RelicConfig_13870_StoryDesc = {
    Text = [[
Pita yang pernah berada di lokasi kejadian telah disobek oleh kekuatan eksternal menjadi dua bagian. 
 Salah satu bagiannya pernah jatuh dari ketinggian dan mendarat di telapak tangan seorang gadis.]]
  },
  RelicConfig_13871_BattleDesc = {
    Text = "Pada awal setiap ronde, semua Pembangun mendapatkan 10 Aliemus. Saat diambil, Kesehatan maksimum berkurang sebesar 30%."
  },
  RelicConfig_13871_Desc = {
    Text = "Pada awal setiap ronde, semua Pembangun mendapatkan 10 Aliemus. Saat diambil, Kesehatan maksimum berkurang sebesar 30%."
  },
  RelicConfig_13871_Name = {
    Text = "<RedQuality:IlusiMimpiBuruk>"
  },
  RelicConfig_13871_StoryDesc = {
    Text = "Hati-hati, tidur yang berlebihan bisa melahap segalanya tanpa kamu sadari."
  },
  RelicConfig_13873_BattleDesc = {
    Text = "Setelah memainkan “<ExaltIconKeywords:Gnosis Membangkitkan>”, hapus semua perisai musuh."
  },
  RelicConfig_13873_Desc = {
    Text = "Setelah memainkan “<ExaltIconKeywords:Gnosis Membangkitkan>”, hapus semua perisai musuh."
  },
  RelicConfig_13873_Name = {
    Text = "Permukaan cermin hitam"
  },
  RelicConfig_13874_BattleDesc = {
    Text = "Pada ronde ganjil, saat jumlah kartu tersisa di tangan adalah 0, tarik 2 kartu; pada ronde genap, saat Aritmetika tersisa adalah 0, dapatkan 2 poin Aritmetika."
  },
  RelicConfig_13874_Desc = {
    Text = "Pada ronde ganjil, saat jumlah kartu tersisa di tangan adalah 0, tarik 2 kartu; pada ronde genap, saat Aritmetika tersisa adalah 0, dapatkan 2 poin Aritmetika."
  },
  RelicConfig_13874_Name = {
    Text = "Panduan Emas Terasing"
  },
  RelicConfig_13875_BattleDesc = {
    Text = "Setelah mengeluarkan \"Serangan\" dan \"Pertahanan\", Pembangun yang sesuai mendapatkan 35 Aliemus. Namun, konsumsi Aritmetika mereka meningkat +1."
  },
  RelicConfig_13875_Desc = {
    Text = "Setelah mengeluarkan \"Serangan\" dan \"Pertahanan\", Pembangun yang sesuai mendapatkan 35 Aliemus. Namun, konsumsi Aritmetika mereka meningkat +1."
  },
  RelicConfig_13875_Name = {
    Text = "<RedQuality:Wajah Terluka>"
  },
  RelicConfig_13875_StoryDesc = {
    Text = "Wajah siapa, penuh dengan rasa takut, terperangkap dalam aliran waktu."
  },
  RelicConfig_13877_BattleDesc = {
    Text = "Setelah mendapatkan Perisai ke-2 setiap putaran, dapatkan [Arg1] tumpukan <RetaliateIconKeywords:Counter>. Setelah mendapatkan Perisai ke-4 setiap putaran, picu 100% <RetaliateIconKeywords:Counter> kepada semua musuh."
  },
  RelicConfig_13877_Desc = {
    Text = "Setelah mendapatkan Perisai ke-2 setiap putaran, dapatkan [Arg1] tumpukan <RetaliateIconKeywords:Counter>. Setelah mendapatkan Perisai ke-4 setiap putaran, picu 100% <RetaliateIconKeywords:Counter> kepada semua musuh."
  },
  RelicConfig_13877_Name = {
    Text = "<WhiteQuality:Tanpa Rahasia>"
  },
  RelicConfig_13877_StoryDesc = {
    Text = "Ini menyampaikan tak terhitung banyaknya rahasia yang diucapkan secara aktif maupun pasif."
  },
  RelicConfig_13878_BattleDesc = {
    Text = "Setiap kartu perintah ke-6 yang dimainkan akan dikembalikan ke tangan dari tumpukan kartu buang."
  },
  RelicConfig_13878_Desc = {
    Text = "Setiap kartu perintah ke-6 yang dimainkan akan dikembalikan ke tangan dari tumpukan kartu buang."
  },
  RelicConfig_13878_Name = {
    Text = "<OrangeQuality:Di bawah cahaya senja>"
  },
  RelicConfig_13878_StoryDesc = {
    Text = "Ayo berfoto bersama! Rasakan sensasi rasa sakit yang nyata."
  },
  RelicConfig_13879_BattleDesc = {
    Text = "Setelah melepaskan Muliakan sebanyak 5 kali, Pembangun yang melepaskan Muliakan akan mendapatkan 100 Aliemus."
  },
  RelicConfig_13879_Desc = {
    Text = "Setelah melepaskan Muliakan sebanyak 5 kali, Pembangun yang melepaskan Muliakan akan mendapatkan 100 Aliemus."
  },
  RelicConfig_13879_Name = {
    Text = "<OrangeQuality:Kain Pembungkus Kecil>"
  },
  RelicConfig_13879_StoryDesc = {
    Text = "Membawa harapan, berkah, dan cinta."
  },
  RelicConfig_13880_BattleDesc = {
    Text = "Mendapatkan [Arg1] poin Perisai saat memberikan Kerusakan aktif. Saat memulihkan Hidup, mendapatkan [Arg2] poin <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_13880_Desc = {
    Text = "Mendapatkan [Arg1] poin Perisai saat memberikan Kerusakan aktif. Saat memulihkan Hidup, mendapatkan [Arg2] poin <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_13880_Name = {
    Text = "<OrangeQuality:Rumah Kami>"
  },
  RelicConfig_13880_StoryDesc = {
    Text = "Mereka bersama sebelumnya, dan mereka akan selalu bersama di masa depan. Mereka adalah keluarga yang penuh kasih sayang."
  },
  RelicConfig_13881_BattleDesc = {
    Text = "Pada awal ronde ganjil, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan> sementara. Pada awal ronde genap, dapatkan [Arg2] poin <AlertIconKeywords:Waspada> sementara."
  },
  RelicConfig_13881_Desc = {
    Text = "Pada awal ronde ganjil, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan> sementara. Pada awal ronde genap, dapatkan [Arg2] poin <AlertIconKeywords:Waspada> sementara."
  },
  RelicConfig_13881_Name = {
    Text = "<WhiteQuality:Boneka Kembar>"
  },
  RelicConfig_13881_StoryDesc = {
    Text = "Kembar adalah hadiah dari zaman lama, sebuah alegori yang ditinggalkan untuk masa depan."
  },
  RelicConfig_13882_BattleDesc = {
    Text = "Setiap kali memainkan Kartu perintah pertama dalam satu ronde, Pembangun yang sesuai akan mendapatkan 20 Aliemus pada akhir ronde. Jika memiliki Relik \"Dedikasi Roh\" secara bersamaan, Pembangun lainnya juga akan mendapatkan 5 Aliemus."
  },
  RelicConfig_13882_Desc = {
    Text = "Setiap kali memainkan Kartu perintah pertama dalam satu ronde, Pembangun yang sesuai akan mendapatkan 20 Aliemus pada akhir ronde. Jika memiliki Relik \"Dedikasi Roh\" secara bersamaan, Pembangun lainnya juga akan mendapatkan 5 Aliemus."
  },
  RelicConfig_13882_Name = {
    Text = "<WhiteQuality:Patung Ibu>"
  },
  RelicConfig_13882_StoryDesc = {
    Text = "\"Untukmu, apa pun bisa kuberikan, tolong, lepaskan dia.\""
  },
  RelicConfig_13883_BattleDesc = {
    Text = "Setiap kali seorang Pembangun melakukan 1 kali <DevouredIconKeywords:Melahap>, Pembangun lainnya mendapatkan 10 Aliemus."
  },
  RelicConfig_13883_Desc = {
    Text = "Setiap kali seorang Pembangun melakukan 1 kali <DevouredIconKeywords:Melahap>, Pembangun lainnya mendapatkan 10 Aliemus."
  },
  RelicConfig_13883_Name = {
    Text = "<OrangeQuality:Golden Slumber>"
  },
  RelicConfig_13883_StoryDesc = {
    Text = "Hari metamorfosis adalah hari kematianmu."
  },
  RelicConfig_13884_BattleDesc = {
    Text = "\"Pukulan\"memberikan [Arg1] lapisan <IntoxicationIconKeywords:Racun> kepada semua musuh."
  },
  RelicConfig_13884_Desc = {
    Text = "\"Pukulan\"memberikan [Arg1] lapisan <IntoxicationIconKeywords:Racun> kepada semua musuh."
  },
  RelicConfig_13884_Name = {
    Text = "<WhiteQuality:Neurotoksin>"
  },
  RelicConfig_13884_StoryDesc = {
    Text = "Ekstraksi, pemurnian."
  },
  RelicConfig_13885_BattleDesc = {
    Text = "Pada awal pertempuran, letakkan 1 kartu <DerivativeCardKeywords_1:\"Gema Bayangan Terlupakan\"> ke tangan. Jika ini adalah pertempuran bos, dapatkan tambahan 1 kartu <DerivativeCardKeywords_1:\"Gema Bayangan Terlupakan\">."
  },
  RelicConfig_13885_Desc = {
    Text = "Pada awal pertempuran, letakkan 1 kartu <DerivativeCardKeywords_1:\"Gema Bayangan Terlupakan\"> ke tangan. Jika ini adalah pertempuran bos, dapatkan tambahan 1 kartu <DerivativeCardKeywords_1:\"Gema Bayangan Terlupakan\">."
  },
  RelicConfig_13885_Name = {
    Text = "<WhiteQuality:Perangkat Komunikasi>"
  },
  RelicConfig_13885_StoryDesc = {
    Text = "Menantikan atau takut akan saat lonceng itu berbunyi dengan suara yang nyaring."
  },
  RelicConfig_13886_BattleDesc = {
    Text = "Setiap kali dek direset, tambahkan 2 kartu <DerivativeCardKeywords_5:\"Trisula\"> dan 1 kartu <DerivativeCardKeywords_6:\"Payung\"> ke tangan."
  },
  RelicConfig_13886_Desc = {
    Text = "Setiap kali dek direset, tambahkan 2 kartu <DerivativeCardKeywords_5:\"Trisula\"> dan 1 kartu <DerivativeCardKeywords_6:\"Payung\"> ke tangan."
  },
  RelicConfig_13886_Name = {
    Text = "<WhiteQuality:☆Tas Wanita Sopan☆>"
  },
  RelicConfig_13886_StoryDesc = {
    Text = "Seharusnya berisi kehalusan, bukan kematian."
  },
  RelicConfig_13887_BattleDesc = {
    Text = "Pada awal ronde, tambahkan 1 kartu <DerivativeCardKeywords_5:\"Trisula\"> ke tangan. Setelah melepaskan Aliemus Muliakan, tingkatkan semua <DerivativeCardKeywords_5:\"Trisula\"><PowerIconKeywords:Kekuatan> di tangan sebesar [Arg2]."
  },
  RelicConfig_13887_Desc = {
    Text = "Pada awal ronde, tambahkan 1 kartu <DerivativeCardKeywords_5:\"Trisula\"> ke tangan. Setelah melepaskan Aliemus Muliakan, tingkatkan semua <DerivativeCardKeywords_5:\"Trisula\"><PowerIconKeywords:Kekuatan> di tangan sebesar [Arg2]."
  },
  RelicConfig_13887_Name = {
    Text = "<WhiteQuality:Trisula>"
  },
  RelicConfig_13887_StoryDesc = {
    Text = "Bagaimana pun dilihat, tampak sangat biasa."
  },
  RelicConfig_13888_BattleDesc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1] poin perisai. Setelah menggunakan \"Pertahanan\" sebanyak 7 kali dalam pertempuran ini, segera dapatkan [Arg2] poin perisai. Setelah menggunakan \"Pertahanan\" sebanyak 21 kali dalam pertempuran ini, dapatkan 1 lapisan penghalang sementara."
  },
  RelicConfig_13888_Desc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1] poin perisai. Setelah menggunakan \"Pertahanan\" sebanyak 7 kali dalam pertempuran ini, segera dapatkan [Arg2] poin perisai. Setelah menggunakan \"Pertahanan\" sebanyak 21 kali dalam pertempuran ini, dapatkan 1 lapisan penghalang sementara."
  },
  RelicConfig_13888_Name = {
    Text = "<WhiteQuality:Putney Morning Post>"
  },
  RelicConfig_13888_StoryDesc = {
    Text = "Teman toilet paling praktis dan andal untuk Anda."
  },
  RelicConfig_13889_BattleDesc = {
    Text = "Setelah memasuki ronde Ultra, dapatkan 3 poin Aritmetika."
  },
  RelicConfig_13889_Desc = {
    Text = "Setelah memasuki ronde Ultra, dapatkan 3 poin Aritmetika."
  },
  RelicConfig_13889_Name = {
    Text = "<WhiteQuality:Pasir Cahaya redup>"
  },
  RelicConfig_13889_StoryDesc = {
    Text = "Satu unit waktu yang dapat diukur."
  },
  RelicConfig_13890_BattleDesc = {
    Text = "Pada awal pertempuran, terapkan <WeaknessIconKeywords:Kelemahan> dan <VulnerabilityIconKeywords:Rentan> selama 1 ronde pada semua musuh. Jika ini adalah pertarungan bos, tambahkan 2 ronde <WeaknessIconKeywords:Kelemahan> dan <VulnerabilityIconKeywords:Rentan>."
  },
  RelicConfig_13890_Desc = {
    Text = "Pada awal pertempuran, terapkan <WeaknessIconKeywords:Kelemahan> dan <VulnerabilityIconKeywords:Rentan> selama 1 ronde pada semua musuh. Jika ini adalah pertarungan bos, tambahkan 2 ronde <WeaknessIconKeywords:Kelemahan> dan <VulnerabilityIconKeywords:Rentan>."
  },
  RelicConfig_13890_Name = {
    Text = "<WhiteQuality:Seragam Restraint yang Berubah Warna>"
  },
  RelicConfig_13890_StoryDesc = {
    Text = "Bukan hanya waktu yang dapat mengubah warna kain, ketakutan dan penderitaan pun bisa."
  },
  RelicConfig_13891_BattleDesc = {
    Text = "Jika kartu perintah pertama yang dimainkan di setiap ronde memicu efek lompatan, tarik 1 kartu; jika tidak, dapatkan 1 poin aritmetika. Jika ini adalah ronde Ultra, kedua efek tersebut berlaku secara bersamaan."
  },
  RelicConfig_13891_Desc = {
    Text = "Jika kartu perintah pertama yang dimainkan di setiap ronde memicu efek lompatan, tarik 1 kartu; jika tidak, dapatkan 1 poin aritmetika. Jika ini adalah ronde Ultra, kedua efek tersebut berlaku secara bersamaan."
  },
  RelicConfig_13891_Name = {
    Text = "<OrangeQuality:Perangkat Lompatan>"
  },
  RelicConfig_13891_StoryDesc = {
    Text = "Mencerminkan bayangan yang terdistorsi."
  },
  RelicConfig_13892_BattleDesc = {
    Text = "Menerima sebuah misi. Setelah menyelesaikan misi, terima hadiah. [Acara Misi]"
  },
  RelicConfig_13892_Desc = {
    Text = "Menerima sebuah misi. Setelah menyelesaikan misi, terima hadiah. [Acara Misi]"
  },
  RelicConfig_13892_Name = {
    Text = "<WhiteQuality:Buku Harian Usang>"
  },
  RelicConfig_13892_StoryDesc = {
    Text = [[
Sebuah buku harian tua yang halamannya penuh dengan sisipan, sekilas terlihat setidaknya berisi peta Elworth, catatan eksperimen, dan surat-surat dengan D-marka. 
 Catatan di bagian awal tertulis rapi dan teratur, namun semakin ke belakang menjadi semakin berantakan.]]
  },
  RelicConfig_13893_BattleDesc = {
    Text = "Setiap kali ke-4 mendapatkan nilai Perisai, pulihkan sejumlah 50% dari nilai Perisai tersebut sebagai Hidup."
  },
  RelicConfig_13893_Desc = {
    Text = "Setiap kali ke-4 mendapatkan nilai Perisai, pulihkan sejumlah 50% dari nilai Perisai tersebut sebagai Hidup."
  },
  RelicConfig_13893_Name = {
    Text = "<WhiteQuality: Peluit Pelaut>"
  },
  RelicConfig_13893_StoryDesc = {
    Text = "Selain putri duyung, peluit juga bisa memanggil badai, sepatu bot yang bau, dan pelaut tua yang tidak mandi selama seratus hari."
  },
  RelicConfig_13894_BattleDesc = {
    Text = "Jika jumlah kartu yang dimainkan pada ronde sebelumnya kurang dari atau sama dengan 4, kartu pertama yang dimainkan pada ronde ini akan berlaku sebanyak 2 kali."
  },
  RelicConfig_13894_Desc = {
    Text = "Jika jumlah kartu yang dimainkan pada ronde sebelumnya kurang dari atau sama dengan 4, kartu pertama yang dimainkan pada ronde ini akan berlaku sebanyak 2 kali."
  },
  RelicConfig_13894_Name = {
    Text = "<OrangeQuality:☆Lampu Jiwa Mimpi Buruk☆>"
  },
  RelicConfig_13894_StoryDesc = {
    Text = "Menghadirkan mimpi khayalan."
  },
  RelicConfig_13895_BattleDesc = {
    Text = "Setiap kali kamu kehilangan Hidup, Pembangun dengan Aliemus terendah mendapatkan 10 Aliemus. Setiap kali kamu kehilangan Hidup sebanyak 5 kali, pulihkan 20% dari Hidup yang telah hilang."
  },
  RelicConfig_13895_Desc = {
    Text = "Setiap kali kamu kehilangan Hidup, Pembangun dengan Aliemus terendah mendapatkan 10 Aliemus. Setiap kali kamu kehilangan Hidup sebanyak 5 kali, pulihkan 20% dari Hidup yang telah hilang."
  },
  RelicConfig_13895_Name = {
    Text = "<OrangeQuality:Pendulum waktu \"Analisis\">"
  },
  RelicConfig_13896_BattleDesc = {
    Text = "Meningkatkan aritmetika maksimal sebesar 2. Setiap kali dek kartu direset, tambahkan 1 kartu <DerivativeCardKeywords_9:\"Tertatih\"> ke tumpukan menggambar."
  },
  RelicConfig_13896_Desc = {
    Text = "Meningkatkan aritmetika maksimal sebesar 2. Setiap kali dek kartu direset, tambahkan 1 kartu <DerivativeCardKeywords_9:\"Tertatih\"> ke tumpukan menggambar."
  },
  RelicConfig_13896_Name = {
    Text = "<RedQuality:Lilin hitam>"
  },
  RelicConfig_13896_StoryDesc = {
    Text = "Terbakar dalam kesadaran, jatuh ke dalam kehampaan."
  },
  RelicConfig_13897_BattleDesc = {
    Text = "\"<ExaltIconKeywords:Membangkitkan jiwa>\"dipertahankan hingga akhir putaran."
  },
  RelicConfig_13897_Desc = {
    Text = "\"<ExaltIconKeywords:Membangkitkan jiwa>\"dipertahankan hingga akhir putaran."
  },
  RelicConfig_13897_Name = {
    Text = "Permukaan cermin putih"
  },
  RelicConfig_13898_BattleDesc = {
    Text = "Setiap ada 1 Pembangun yang sudah Bangun, akan meningkatkan <ProficientInRealmsIconKeywords:Penguasaan Alam> sebesar 35. Setelah memainkan \"<ExaltIconKeywords:Membangkitkan>\", secara acak dapatkan 2 Kartu perintah dari Pembangun tersebut dan tambahkan status \"Lelah\"."
  },
  RelicConfig_13898_Desc = {
    Text = "Setiap ada 1 Pembangun yang sudah Bangun, akan meningkatkan <ProficientInRealmsIconKeywords:Penguasaan Alam> sebesar 35. Setelah memainkan \"<ExaltIconKeywords:Membangkitkan>\", secara acak dapatkan 2 Kartu perintah dari Pembangun tersebut dan tambahkan status \"Lelah\"."
  },
  RelicConfig_13898_Name = {
    Text = "<OrangeQuality:Wahyu-Nya>"
  },
  RelicConfig_13898_StoryDesc = {
    Text = "Dia berkata, \"Jangan takut.\""
  },
  RelicConfig_13899_BattleDesc = {
    Text = "Pada awal ronde, <ProficientInRealmsIconKeywords:Penguasaan Alam> meningkat sebesar 50. Saat tidak berada dalam kondisi negatif, peningkatan <ProficientInRealmsIconKeywords:Penguasaan Alam> menjadi 150."
  },
  RelicConfig_13899_Desc = {
    Text = "Pada awal ronde, <ProficientInRealmsIconKeywords:Penguasaan Alam> meningkat sebesar 50. Saat tidak berada dalam kondisi negatif, peningkatan <ProficientInRealmsIconKeywords:Penguasaan Alam> menjadi 150."
  },
  RelicConfig_13899_Name = {
    Text = "<WhiteQuality:☆\"Menuju Kebebasan\"☆>"
  },
  RelicConfig_13899_StoryDesc = {
    Text = "Segenggam Perak yang membawa sedikit rasa nostalgia."
  },
  RelicConfig_13900_BattleDesc = {
    Text = "Setelah menggunakan\"Muliakan\", konsumsi aritmetika semua kartu tangan -1."
  },
  RelicConfig_13900_Desc = {
    Text = "Setelah menggunakan\"Muliakan\", konsumsi aritmetika semua kartu tangan -1."
  },
  RelicConfig_13900_Name = {
    Text = "Cahaya Peradaban Terasing"
  },
  RelicConfig_13901_BattleDesc = {
    Text = "Setiap kali memainkan 1 Kartu perintah, dapatkan [Arg2]% <DeathResistanceIconKeywords:Ketahanan> (setiap kali Ketahanan dipicu dalam level ini, jumlah Ketahanan yang diperoleh berkurang setengahnya). Jika <DeathResistanceIconKeywords:Ketahanan> Anda mencapai 100% atau lebih, ubah menjadi mendapatkan [Arg1] poin <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_13901_Desc = {
    Text = "Setiap kali memainkan 1 Kartu perintah, dapatkan [Arg2]% <DeathResistanceIconKeywords:Ketahanan> (setiap kali Ketahanan dipicu dalam level ini, jumlah Ketahanan yang diperoleh berkurang setengahnya). Jika <DeathResistanceIconKeywords:Ketahanan> Anda mencapai 100% atau lebih, ubah menjadi mendapatkan [Arg1] poin <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_13901_Name = {
    Text = "<OrangeQuality: Sisa Kulit Ular Aneh>"
  },
  RelicConfig_13901_StoryDesc = {
    Text = "Dilahirkan kembali dari pembebasan diri."
  },
  RelicConfig_13902_BattleDesc = {
    Text = "Setelah putaran dimulai, dapatkan [Arg2] poin Perisai. Setelah putaran berakhir, berikan <FixedDamage:Kerusakan Murni> kepada musuh acak sebesar [Arg1]% dari nilai Perisai saat ini, efek kerusakan pada Pertarungan Pemimpin berlipat ganda."
  },
  RelicConfig_13902_Desc = {
    Text = "Setelah putaran dimulai, dapatkan [Arg2] poin Perisai. Setelah putaran berakhir, berikan <FixedDamage:Kerusakan Murni> kepada musuh acak sebesar [Arg1]% dari nilai Perisai saat ini, efek kerusakan pada Pertarungan Pemimpin berlipat ganda."
  },
  RelicConfig_13902_Name = {
    Text = "<WhiteQuality:Panduan Emas>"
  },
  RelicConfig_13902_StoryDesc = {
    Text = "Ketika kamu kehilangan arah, bukalah itu, tapi berhati-hatilah — koronanya tidak boleh terkena cahaya matahari."
  },
  RelicConfig_13904_BattleDesc = {
    Text = "Menyembunyikan niat monster. Setiap putaran, dapatkan 1 poin Aritmetika dan tarik 1 kartu."
  },
  RelicConfig_13904_Desc = {
    Text = "Menyembunyikan niat monster. Setiap putaran, dapatkan 1 poin Aritmetika dan tarik 1 kartu."
  },
  RelicConfig_13904_Name = {
    Text = "<RedQuality:Rayuan Angin Lonceng>"
  },
  RelicConfig_13904_StoryDesc = {
    Text = "Ting ting, ting ting."
  },
  RelicConfig_13905_BattleDesc = {
    Text = "Setelah pertempuran dimulai, dapatkan [Arg2] lapisan <RetaliateIconKeywords:Counter>, memainkan \"Pertahanan\" mendapatkan [Arg1] lapisan <RetaliateIconKeywords:Counter>."
  },
  RelicConfig_13905_Desc = {
    Text = "Setelah pertempuran dimulai, dapatkan [Arg2] lapisan <RetaliateIconKeywords:Counter>, memainkan \"Pertahanan\" mendapatkan [Arg1] lapisan <RetaliateIconKeywords:Counter>."
  },
  RelicConfig_13905_Name = {
    Text = "<WhiteQuality:Rompi Urtiga>"
  },
  RelicConfig_13905_StoryDesc = {
    Text = "Tidak bisa membedakan cairan yang menempel."
  },
  RelicConfig_13906_BattleDesc = {
    Text = "Ini adalah Relik pengganti mingguan tanpa Efek 4"
  },
  RelicConfig_13906_Desc = {
    Text = "Ini adalah Relik pengganti mingguan tanpa Efek 4"
  },
  RelicConfig_13906_Name = {
    Text = "Tantangan Harian Mingguan Relik 4"
  },
  RelicConfig_13907_BattleDesc = {
    Text = "Pada awal ronde, jika jumlah kartu yang dimainkan pada ronde sebelumnya lebih dari 3, tarik 2 kartu."
  },
  RelicConfig_13907_Desc = {
    Text = "Pada awal ronde, jika jumlah kartu yang dimainkan pada ronde sebelumnya lebih dari 3, tarik 2 kartu."
  },
  RelicConfig_13907_Name = {
    Text = "<WhiteQuality:Dompet Baru yang Bersih>"
  },
  RelicConfig_13907_StoryDesc = {
    Text = [[
Dompet kulit dengan lambang Universitas Mythag tercetak di atasnya. 
 Saat ini, dompet itu kosong, tidak ada apa pun di dalamnya.]]
  },
  RelicConfig_13908_BattleDesc = {
    Text = "Setelah menggunakan \"Muliakan\", Pembangun yang dimiliki mendapatkan [Arg1] poin Aliemus."
  },
  RelicConfig_13908_Desc = {
    Text = "Setelah menggunakan \"Muliakan\", Pembangun yang dimiliki mendapatkan [Arg1] poin Aliemus."
  },
  RelicConfig_13908_Name = {
    Text = "Jilbab Dewa yang Tak Bernama dan Terasing"
  },
  RelicConfig_13909_BattleDesc = {
    Text = "Setelah melepaskan Aliemus Muliakan, kehilangan 8% dari Hidup saat ini, mencuri [Arg1] poin sementara <PowerIconKeywords:Kekuatan> dari semua musuh. Jika hanya ada 1 musuh, mencuri tambahan [Arg2] poin sementara <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13909_Desc = {
    Text = "Setelah melepaskan Aliemus Muliakan, kehilangan 8% dari Hidup saat ini, mencuri [Arg1] poin sementara <PowerIconKeywords:Kekuatan> dari semua musuh. Jika hanya ada 1 musuh, mencuri tambahan [Arg2] poin sementara <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13909_Name = {
    Text = "<RedQuality:Burung Upacara Kutukan>"
  },
  RelicConfig_13909_StoryDesc = {
    Text = "Mayat yang kering mengeluarkan suara berdering."
  },
  RelicConfig_13910_BattleDesc = {
    Text = "Setelah melepaskan Muliakan, Pembangun yang sesuai mendapatkan 10 Aliemus dan memperoleh Perisai sebesar [Arg1] poin."
  },
  RelicConfig_13910_Desc = {
    Text = "Setelah melepaskan Muliakan, Pembangun yang sesuai mendapatkan 10 Aliemus dan memperoleh Perisai sebesar [Arg1] poin."
  },
  RelicConfig_13910_Name = {
    Text = "<OrangeQuality:Jilbab Dewa Tanpa Nama>"
  },
  RelicConfig_13910_StoryDesc = {
    Text = "Jangan menatap dewa secara langsung."
  },
  RelicConfig_13911_BattleDesc = {
    Text = "Setiap putaran, mainkan Pembangun yang sesuai dengan kartu perintah terakhir. Pada akhir putaran, dapatkan 20 Aliemus. Jika memiliki Relik \"Patung Ibu\" secara bersamaan, berikan 5 Aliemus kepada Pembangun lainnya."
  },
  RelicConfig_13911_Desc = {
    Text = "Setiap putaran, mainkan Pembangun yang sesuai dengan kartu perintah terakhir. Pada akhir putaran, dapatkan 20 Aliemus. Jika memiliki Relik \"Patung Ibu\" secara bersamaan, berikan 5 Aliemus kepada Pembangun lainnya."
  },
  RelicConfig_13911_Name = {
    Text = "<WhiteQuality:Dedikasi Roh>"
  },
  RelicConfig_13911_StoryDesc = {
    Text = "\"Untukmu, apa saja bisa kuberikan, tolong ampuni aku.\""
  },
  RelicConfig_13912_BattleDesc = {
    Text = "Pada akhir ronde, untuk setiap 1 kartu tangan yang tersisa, dapatkan 1 Aritmetika di awal ronde berikutnya."
  },
  RelicConfig_13912_Desc = {
    Text = "Pada akhir ronde, untuk setiap 1 kartu tangan yang tersisa, dapatkan 1 Aritmetika di awal ronde berikutnya."
  },
  RelicConfig_13912_Name = {
    Text = "<OrangeQuality:Pendulum waktu \"Interpretasi\">"
  },
  RelicConfig_13913_BattleDesc = {
    Text = "Pada awal ronde jika Hidup lebih dari [Arg1], kehilangan [Arg1] poin Hidup, dan dalam ronde tersebut mendapatkan [Arg2] poin <PowerIconKeywords:Kekuatan> serta [Arg3] poin <AlertIconKeywords:Waspada>."
  },
  RelicConfig_13913_Desc = {
    Text = "Pada awal ronde jika Hidup lebih dari [Arg1], kehilangan [Arg1] poin Hidup, dan dalam ronde tersebut mendapatkan [Arg2] poin <PowerIconKeywords:Kekuatan> serta [Arg3] poin <AlertIconKeywords:Waspada>."
  },
  RelicConfig_13913_Name = {
    Text = "<RedQuality:Anggota Bantuan>"
  },
  RelicConfig_13913_StoryDesc = {
    Text = [[
Sebagian dari kesakralan.
Meskipun terpisah dari tubuh, kehangatan di atasnya masih dapat dirasakan.]]
  },
  RelicConfig_13914_BattleDesc = {
    Text = "\"Serangan\"mendapatkan 2 poin Aritmetika, buang 1 kartu secara acak; \"Pertahanan\"menarik 2 kartu, kehilangan 1 poin Aritmetika. Maksimal dipicu 3 kali per ronde."
  },
  RelicConfig_13914_Desc = {
    Text = "\"Serangan\"mendapatkan 2 poin Aritmetika, buang 1 kartu secara acak; \"Pertahanan\"menarik 2 kartu, kehilangan 1 poin Aritmetika. Maksimal dipicu 3 kali per ronde."
  },
  RelicConfig_13914_Name = {
    Text = "<RedQuality:Rekaman Kebahagiaan>"
  },
  RelicConfig_13914_StoryDesc = {
    Text = [[
Rekaman penampilan terakhir dari pemain biola terkenal. 
 Sejak saat itu, ia dapat membawa api.]]
  },
  RelicConfig_13915_BattleDesc = {
    Text = "Efek bonus rekomendasi Alam meningkat menjadi 50%, saat level dimulai <ProficientInRealmsIconKeywords:Penguasaan Alam> kamu akan berlipat ganda."
  },
  RelicConfig_13915_Desc = {
    Text = "Efek bonus rekomendasi Alam meningkat menjadi 50%, saat level dimulai <ProficientInRealmsIconKeywords:Penguasaan Alam> kamu akan berlipat ganda."
  },
  RelicConfig_13915_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Mimpi\">"
  },
  RelicConfig_13916_BattleDesc = {
    Text = "Setelah melepaskan Muliakan, kartu perintah berikutnya yang dimainkan akan memiliki efek 2 kali."
  },
  RelicConfig_13916_Desc = {
    Text = "Setelah melepaskan Muliakan, kartu perintah berikutnya yang dimainkan akan memiliki efek 2 kali."
  },
  RelicConfig_13916_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Menyelam\">"
  },
  RelicConfig_13917_BattleDesc = {
    Text = "Jika niat musuh adalah untuk menyerang, setelah menyebabkan kerusakan, <PowerIconKeywords:Kekuatan> akan berkurang sementara sebesar [Arg1] poin. Jika tidak, efek <BleedingIconKeywords:Berdarah> yang setara dengan 25% kerusakan akan diberikan. Efek ini dapat dipicu maksimal 6 kali per putaran."
  },
  RelicConfig_13917_Desc = {
    Text = "Jika niat musuh adalah untuk menyerang, setelah menyebabkan kerusakan, <PowerIconKeywords:Kekuatan> akan berkurang sementara sebesar [Arg1] poin. Jika tidak, efek <BleedingIconKeywords:Berdarah> yang setara dengan 25% kerusakan akan diberikan. Efek ini dapat dipicu maksimal 6 kali per putaran."
  },
  RelicConfig_13917_Name = {
    Text = "<WhiteQuality:Jantung Alien>"
  },
  RelicConfig_13917_StoryDesc = {
    Text = "Dua \"jantung\" yang saling berdekatan dan bergantung satu sama lain."
  },
  RelicConfig_13918_BattleDesc = {
    Text = "Setiap kali memberikan kerusakan, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan> sementara, hingga 3 tumpukan. Saat jumlah tumpukan mencapai maksimum, efeknya menjadi dua kali lipat."
  },
  RelicConfig_13918_Desc = {
    Text = "Setiap kali memberikan kerusakan, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan> sementara, hingga 3 tumpukan. Saat jumlah tumpukan mencapai maksimum, efeknya menjadi dua kali lipat."
  },
  RelicConfig_13918_Name = {
    Text = "<WhiteQuality:Agate Berlilit>"
  },
  RelicConfig_13918_StoryDesc = {
    Text = "Seharusnya hanya pola akik biasa. Mungkin."
  },
  RelicConfig_13919_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Kecakapan Alam> meningkatkan sebesar 50. Saat memungut, pilih satu Relik dan ganti dengan Relik acak."
  },
  RelicConfig_13919_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Kecakapan Alam> meningkatkan sebesar 50. Saat memungut, pilih satu Relik dan ganti dengan Relik acak."
  },
  RelicConfig_13919_Name = {
    Text = "<WhiteQuality:Kaleidoskop>"
  },
  RelicConfig_13919_StoryDesc = {
    Text = "Apa yang dipikirkan dan dilihat hanyalah ilusi."
  },
  RelicConfig_13920_BattleDesc = {
    Text = "Meningkatkan efek Kelemahan sebesar 5%. Saat menerapkan <WeaknessIconKeywords:Kelemahan>, sementara mencuri [Arg1] poin <PowerIconKeywords:Kekuatan> dari target."
  },
  RelicConfig_13920_Desc = {
    Text = "Meningkatkan efek Kelemahan sebesar 5%. Saat menerapkan <WeaknessIconKeywords:Kelemahan>, sementara mencuri [Arg1] poin <PowerIconKeywords:Kekuatan> dari target."
  },
  RelicConfig_13920_Name = {
    Text = "<WhiteQuality:Foto Pudar>"
  },
  RelicConfig_13920_StoryDesc = {
    Text = "Foto yang kabur membawa memori yang samar, atau mungkin — justru karena kekurangan dalam memori, yang menyebabkan warna pada foto memudar."
  },
  RelicConfig_13921_BattleDesc = {
    Text = "Saat mengambil, pilih 2 Kartu perintah untuk dihapus, dan dapatkan [Arg1] <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13921_Desc = {
    Text = "Saat mengambil, pilih 2 Kartu perintah untuk dihapus, dan dapatkan [Arg1] <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13921_Name = {
    Text = "<RedQuality:Abu Api Bintang Hitam>"
  },
  RelicConfig_13921_StoryDesc = {
    Text = "Api belum padam."
  },
  RelicConfig_13922_BattleDesc = {
    Text = "Setelah melepaskan Muliakan sebanyak 2 kali per ronde, semua Pembangun mendapatkan 8 poin Aliemus, dan setelah melepaskan sebanyak 3 kali, semua Pembangun mendapatkan tambahan 8 poin Aliemus lagi."
  },
  RelicConfig_13922_Desc = {
    Text = "Setelah melepaskan Muliakan sebanyak 2 kali per ronde, semua Pembangun mendapatkan 8 poin Aliemus, dan setelah melepaskan sebanyak 3 kali, semua Pembangun mendapatkan tambahan 8 poin Aliemus lagi."
  },
  RelicConfig_13922_Name = {
    Text = "<OrangeQuality: Darah Sang Terlupakan>"
  },
  RelicConfig_13922_StoryDesc = {
    Text = "Semakin mencair."
  },
  RelicConfig_13923_BattleDesc = {
    Text = "Setiap kali memberikan 1 Kerusakan, dapatkan [Arg1] poin Perisai. Pada awal giliran, untuk setiap 3 poin Perisai tersisa, dapatkan 1 poin <PowerIconKeywords:Kekuatan> sementara dan Kerusakan tentakel."
  },
  RelicConfig_13923_Desc = {
    Text = "Setiap kali memberikan 1 Kerusakan, dapatkan [Arg1] poin Perisai. Pada awal giliran, untuk setiap 3 poin Perisai tersisa, dapatkan 1 poin <PowerIconKeywords:Kekuatan> sementara dan Kerusakan tentakel."
  },
  RelicConfig_13923_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Rahasia\">"
  },
  RelicConfig_13924_BattleDesc = {
    Text = "Setiap kali efek <TransitionIconKeywords:Lompatan> dipicu, curi [Arg1] poin <PowerIconKeywords:Kekuatan> sementara dari semua musuh. Jika hanya ada 1 musuh, curi tambahan [Arg2] poin <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_13924_Desc = {
    Text = "Setiap kali efek <TransitionIconKeywords:Lompatan> dipicu, curi [Arg1] poin <PowerIconKeywords:Kekuatan> sementara dari semua musuh. Jika hanya ada 1 musuh, curi tambahan [Arg2] poin <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_13924_Name = {
    Text = "<OrangeQuality:Pengubah Ruang>"
  },
  RelicConfig_13924_StoryDesc = {
    Text = "Melompat ke kehampaan."
  },
  RelicConfig_13925_BattleDesc = {
    Text = "Pada awal giliran, tarik 1 kartu. Ketika secara berturut-turut 2 kali memainkan kartu dengan aritmetika yang sama seperti kartu sebelumnya, tarik 1 kartu tambahan. Efek ini dapat berlaku maksimal 3 kali per giliran."
  },
  RelicConfig_13925_Desc = {
    Text = "Pada awal giliran, tarik 1 kartu. Ketika secara berturut-turut 2 kali memainkan kartu dengan aritmetika yang sama seperti kartu sebelumnya, tarik 1 kartu tambahan. Efek ini dapat berlaku maksimal 3 kali per giliran."
  },
  RelicConfig_13925_Name = {
    Text = "<OrangeQuality:Ritual Rahasia Gnosis>"
  },
  RelicConfig_13925_StoryDesc = {
    Text = "Mengetahui segalanya dan memiliki kemampuan tanpa batas."
  },
  RelicConfig_13926_BattleDesc = {
    Text = "Pada awal pertempuran, untuk setiap 1 Orison di dalam dek, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan>, dan untuk setiap 1 Relik, pulihkan [Arg2] poin hidup."
  },
  RelicConfig_13926_Desc = {
    Text = "Pada awal pertempuran, untuk setiap 1 Orison di dalam dek, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan>, dan untuk setiap 1 Relik, pulihkan [Arg2] poin hidup."
  },
  RelicConfig_13926_Name = {
    Text = "<OrangeQuality:☆Medali Kamar Dagang☆>"
  },
  RelicConfig_13926_StoryDesc = {
    Text = "\"Kenakanlah, maka kamu akan menjadi salah satu anggota Kamar Dagang Londinium.\""
  },
  RelicConfig_13927_BattleDesc = {
    Text = "Hapus 1 Kartu Gejala saat mengambil. Tingkatkan 1 Orison acak menjadi Orison Tingkat Lanjut."
  },
  RelicConfig_13927_Desc = {
    Text = "Hapus 1 Kartu Gejala saat mengambil. Tingkatkan 1 Orison acak menjadi Orison Tingkat Lanjut."
  },
  RelicConfig_13927_Name = {
    Text = "<WhiteQuality:Kaki Kelinci Keberuntungan>"
  },
  RelicConfig_13927_StoryDesc = {
    Text = "Bagi kelinci, itu tidak begitu beruntung."
  },
  RelicConfig_13928_BattleDesc = {
    Text = "Crit. Rate meningkat sebesar 15%. Setiap memainkan 1 kartu, Crit. Rate sementara meningkat sebesar 5%."
  },
  RelicConfig_13928_Desc = {
    Text = "Crit. Rate meningkat sebesar 15%. Setiap memainkan 1 kartu, Crit. Rate sementara meningkat sebesar 5%."
  },
  RelicConfig_13928_Name = {
    Text = "<OrangeQuality: Cermin Ritual Memphis>"
  },
  RelicConfig_13928_StoryDesc = {
    Text = "\"Apa yang kamu lihat di dalamnya?\""
  },
  RelicConfig_13929_BattleDesc = {
    Text = "Setiap kali kamu kehilangan HP, dapatkan [Arg1] tumpukan <RetaliateIconKeywords:Counter>. Jika ini adalah pemicu ke-3 dalam satu putaran, picu 100% <RetaliateIconKeywords:Counter> kepada semua musuh."
  },
  RelicConfig_13929_Desc = {
    Text = "Setiap kali kamu kehilangan HP, dapatkan [Arg1] tumpukan <RetaliateIconKeywords:Counter>. Jika ini adalah pemicu ke-3 dalam satu putaran, picu 100% <RetaliateIconKeywords:Counter> kepada semua musuh."
  },
  RelicConfig_13929_Name = {
    Text = "<WhiteQuality:Jam Saku Mendiang>"
  },
  RelicConfig_13929_StoryDesc = {
    Text = "Membawa rasa kerinduan dan kesedihan, melangkah maju menuju hal yang tidak diketahui."
  },
  RelicConfig_13930_BattleDesc = {
    Text = "Pada akhir ronde, untuk setiap 1 kartu di tangan, berikan [Arg1] tingkat <IntoxicationIconKeywords:Racun> kepada semua musuh."
  },
  RelicConfig_13930_Desc = {
    Text = "Pada akhir ronde, untuk setiap 1 kartu di tangan, berikan [Arg1] tingkat <IntoxicationIconKeywords:Racun> kepada semua musuh."
  },
  RelicConfig_13930_Name = {
    Text = "<WhiteQuality:Salep Mencurigakan>"
  },
  RelicConfig_13930_StoryDesc = {
    Text = "Semacam salep luka buatan sendiri, mohon jangan digunakan tanpa panduan dokter."
  },
  RelicConfig_13931_BattleDesc = {
    Text = "Mendapatkan [Arg1] <PowerIconKeywords:Kekuatan> saat diambil. Setiap kali ada <DerivativeCardKeywords_2:\"Embrio\"> yang digabungkan, mendapatkan [Arg2] poin <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_13931_Desc = {
    Text = "Mendapatkan [Arg1] <PowerIconKeywords:Kekuatan> saat diambil. Setiap kali ada <DerivativeCardKeywords_2:\"Embrio\"> yang digabungkan, mendapatkan [Arg2] poin <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_13931_Name = {
    Text = "<WhiteQuality:Kerikil Berdarah>"
  },
  RelicConfig_13931_StoryDesc = {
    Text = "Satu, dua, tiga, empat, lima."
  },
  RelicConfig_13932_BattleDesc = {
    Text = "Setiap ketiga kalinya menggunakan \"Pertahanan\", dapatkan [Arg1] poin Perisai, dan Pembangun yang sesuai mendapatkan 15 Aliemus."
  },
  RelicConfig_13932_Desc = {
    Text = "Setiap ketiga kalinya menggunakan \"Pertahanan\", dapatkan [Arg1] poin Perisai, dan Pembangun yang sesuai mendapatkan 15 Aliemus."
  },
  RelicConfig_13932_Name = {
    Text = "<WhiteQuality:Sarung Tangan Keheningan>"
  },
  RelicConfig_13932_StoryDesc = {
    Text = "Mereka pernah ternoda oleh darah, air mata, dan jamur."
  },
  RelicConfig_13933_BattleDesc = {
    Text = "Ini adalah Relik pengganti mingguan tanpa Efek 6"
  },
  RelicConfig_13933_Desc = {
    Text = "Ini adalah Relik pengganti mingguan tanpa Efek 6"
  },
  RelicConfig_13933_Name = {
    Text = "Tantangan Harian Mingguan Relik 6"
  },
  RelicConfig_13934_BattleDesc = {
    Text = "Ini adalah Relik penggantian mingguan tanpa Efek 5."
  },
  RelicConfig_13934_Desc = {
    Text = "Ini adalah Relik penggantian mingguan tanpa Efek 5."
  },
  RelicConfig_13934_Name = {
    Text = "Tantangan Harian Mingguan Relik 5"
  },
  RelicConfig_13935_BattleDesc = {
    Text = "Meningkatkan Crit. Rate sebesar 10%. Setelah serangan kritis pertama setiap ronde, Crit. Rate akan meningkat tambahan 20%, dan setelah serangan kritis ketiga dalam satu ronde, Crit. DMG akan meningkat tambahan 50%."
  },
  RelicConfig_13935_Desc = {
    Text = "Meningkatkan Crit. Rate sebesar 10%. Setelah serangan kritis pertama setiap ronde, Crit. Rate akan meningkat tambahan 20%, dan setelah serangan kritis ketiga dalam satu ronde, Crit. DMG akan meningkat tambahan 50%."
  },
  RelicConfig_13935_Name = {
    Text = "<WhiteQuality:UcapanFestival>"
  },
  RelicConfig_13935_StoryDesc = {
    Text = "Seharusnya memberikan berkah kepada mereka yang saling mencintai."
  },
  RelicConfig_13936_BattleDesc = {
    Text = "Ini adalah Relik pengganti mingguan tanpa Efek 3"
  },
  RelicConfig_13936_Desc = {
    Text = "Ini adalah Relik pengganti mingguan tanpa Efek 3"
  },
  RelicConfig_13936_Name = {
    Text = "Tantangan Harian Mingguan Relik 3"
  },
  RelicConfig_13937_BattleDesc = {
    Text = "Ini adalah Relik pengganti mingguan tanpa Efek 2"
  },
  RelicConfig_13937_Desc = {
    Text = "Ini adalah Relik pengganti mingguan tanpa Efek 2"
  },
  RelicConfig_13937_Name = {
    Text = "Tantangan Harian Mingguan Relik 2"
  },
  RelicConfig_13938_BattleDesc = {
    Text = "Ini adalah Relik pengganti mingguan tanpa Efek 1"
  },
  RelicConfig_13938_Desc = {
    Text = "Ini adalah Relik pengganti mingguan tanpa Efek 1"
  },
  RelicConfig_13938_Name = {
    Text = "Tantangan Harian Mingguan Relik 1"
  },
  RelicConfig_13939_BattleDesc = {
    Text = "Pada awal ronde ke-3, tingkat kritis pertempuran ini meningkat sebesar +15%, dan 1 kartu <DerivativeCardKeywords_39:\"Gema Masa Lalu\"> ditambahkan ke tangan."
  },
  RelicConfig_13939_Desc = {
    Text = "Pada awal ronde ke-3, tingkat kritis pertempuran ini meningkat sebesar +15%, dan 1 kartu <DerivativeCardKeywords_39:\"Gema Masa Lalu\"> ditambahkan ke tangan."
  },
  RelicConfig_13939_Name = {
    Text = "<OrangeQuality:Persembahan dari Masa Lalu>"
  },
  RelicConfig_13939_StoryDesc = {
    Text = "Pernah menjadi sesuatu yang dipersembahkan."
  },
  RelicConfig_13940_BattleDesc = {
    Text = "Ketika kamu memiliki perisai, relik ini memberikan [Arg1] poin sementara <PowerIconKeywords:Kekuatan>. Jika perisaimu lebih tinggi daripada hidup saat ini, secara tambahan memberikan [Arg2] poin sementara <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13940_Desc = {
    Text = "Ketika kamu memiliki perisai, relik ini memberikan [Arg1] poin sementara <PowerIconKeywords:Kekuatan>. Jika perisaimu lebih tinggi daripada hidup saat ini, secara tambahan memberikan [Arg2] poin sementara <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_13940_Name = {
    Text = "<WhiteQuality:Kipas Bulu Merpati>"
  },
  RelicConfig_13940_StoryDesc = {
    Text = "Halus, mahal, namun kurang praktis."
  },
  RelicConfig_13941_BattleDesc = {
    Text = "\"Pukulan\"memulihkan [Arg1] poin hidup, mengurangi [Arg1] lapisan <IntoxicationIconKeywords:Racun>."
  },
  RelicConfig_13941_Desc = {
    Text = "\"Pukulan\"memulihkan [Arg1] poin hidup, mengurangi [Arg1] lapisan <IntoxicationIconKeywords:Racun>."
  },
  RelicConfig_13941_Name = {
    Text = "<WhiteQuality:Pencatu Darah>"
  },
  RelicConfig_13941_StoryDesc = {
    Text = "\"Cepat, cepat berikan itu padaku!\""
  },
  RelicConfig_13942_BattleDesc = {
    Text = "Untuk setiap 1 Tentakel, dapatkan [Arg1] poin Perisai di akhir ronde. Jika Tentakel berada dalam posisi Laut Tenang, Efek ini memberikan tambahan 50% Perisai."
  },
  RelicConfig_13942_Desc = {
    Text = "Untuk setiap 1 Tentakel, dapatkan [Arg1] poin Perisai di akhir ronde. Jika Tentakel berada dalam posisi Laut Tenang, Efek ini memberikan tambahan 50% Perisai."
  },
  RelicConfig_13942_Name = {
    Text = "<WhiteQuality:Anggota Tubuh Tanpa Nama>"
  },
  RelicConfig_13942_StoryDesc = {
    Text = "Hati-hati, bisa melukai tangan."
  },
  RelicConfig_139929_BattleDesc = {
    Text = "Saya mendapatkan [Arg1] Kegilaan saat giliran dimulai. Setiap 100 poin Kegilaan yang dikonsumsi saat Ledakan Kegilaan Saya, membuat 1 \"Skill\" yang dihasilkan secara acak berlaku tambahan 1 kali."
  },
  RelicConfig_139929_Desc = {
    Text = "Saya mendapatkan [Arg1] Kegilaan saat giliran dimulai. Setiap 100 poin Kegilaan yang dikonsumsi saat Ledakan Kegilaan Saya, membuat 1 \"Skill\" yang dihasilkan secara acak berlaku tambahan 1 kali."
  },
  RelicConfig_139929_Name = {
    Text = "<OrangeQuality:Citra Dimensi·Saya>"
  },
  RelicConfig_140276_BattleDesc = {
    Text = [[
<OrangeQuality:Punggung ke Dinding>:Saat giliran dimulai, setiap 1% HP maksimum yang hilang, damage akhir sementara meningkat 5%, jika Resistansi Kematian terpicu di giliran sebelumnya, efek ini berlipat ganda. 
<RedQuality:Tertinggi>:HP maksimum semua musuh meningkat 300%.]]
  },
  RelicConfig_140276_Desc = {
    Text = [[
<OrangeQuality:Punggung ke Dinding>:Saat giliran dimulai, setiap 1% HP maksimum yang hilang, damage akhir sementara meningkat 5%, jika Resistansi Kematian terpicu di giliran sebelumnya, efek ini berlipat ganda. 
<RedQuality:Tertinggi>:HP maksimum semua musuh meningkat 300%.]]
  },
  RelicConfig_140276_Name = {
    Text = "<RedQuality:Pendulum Dimensi-Pertarungan Mati>"
  },
  RelicConfig_140277_BattleDesc = {
    Text = [[
<OrangeQuality:Proliferasi>: Setiap ronde, saat setiap Awakener pertama kali memainkan "Skill", hasilkan 2 salinan asli sementaranya. Saat memainkan kartu perintah dengan konsumsi daya komputasi 0 atau 1, semua Awakener mendapatkan 5 poin Fury.
<RedQuality:Benteng>: Saat memainkan kartu dengan konsumsi daya komputasi asli lebih dari atau sama dengan 3, semua musuh mendapatkan perisai sebesar 20% HP maksimum.]]
  },
  RelicConfig_140277_Desc = {
    Text = [[
<OrangeQuality:Proliferasi>: Setiap ronde, saat setiap Awakener pertama kali memainkan "Skill", hasilkan 2 salinan asli sementaranya. Saat memainkan kartu perintah dengan konsumsi daya komputasi 0 atau 1, semua Awakener mendapatkan 5 poin Fury.
<RedQuality:Benteng>: Saat memainkan kartu dengan konsumsi daya komputasi asli lebih dari atau sama dengan 3, semua musuh mendapatkan perisai sebesar 20% HP maksimum.]]
  },
  RelicConfig_140277_Name = {
    Text = "<RedQuality:Pendulum Dimensi-Waspada>"
  },
  RelicConfig_140278_BattleDesc = {
    Text = [[
<OrangeQuality:Regenerasi>:Efek perisai dan pemulihan yang diperoleh meningkat 25%. Saat memulihkan HP atau mendapatkan perisai, setiap 1% HP maksimum yang dipulihkan atau diperoleh sebagai perisai, dapatkan 10% penguatan damage sementara.
<RedQuality:Bisikan>:Setiap giliran mendapatkan efek pengurangan kekuatan setara 10% HP maksimum.]]
  },
  RelicConfig_140278_Desc = {
    Text = [[
<OrangeQuality:Regenerasi>:Efek perisai dan pemulihan yang diperoleh meningkat 25%. Saat memulihkan HP atau mendapatkan perisai, setiap 1% HP maksimum yang dipulihkan atau diperoleh sebagai perisai, dapatkan 10% penguatan damage sementara.
<RedQuality:Bisikan>:Setiap giliran mendapatkan efek pengurangan kekuatan setara 10% HP maksimum.]]
  },
  RelicConfig_140278_Name = {
    Text = "<RedQuality:Pendulum Dimensi-Intimidasi>"
  },
  RelicConfig_140279_BattleDesc = {
    Text = [[
<OrangeQuality:Fajar>:Kegilaan dasar semua Awakened berkurang 30 poin. Damage akhir Ledakan Kegilaan pertama yang dilepaskan setiap giliran meningkat 200%, perisai dan pemulihan HP meningkat 100%. Setelah melepaskan 5 kali Ledakan Kegilaan, pilih 1 Awakened untuk dibangkitkan, dan segarkan efek amplifikasi Ledakan Kegilaan.
<RedQuality:Kelelahan>:Energi Kunci Perak dasar meningkat 200%]]
  },
  RelicConfig_140279_Desc = {
    Text = [[
<OrangeQuality:Fajar>:Kegilaan dasar semua Awakened berkurang 30 poin. Damage akhir Ledakan Kegilaan pertama yang dilepaskan setiap giliran meningkat 200%, perisai dan pemulihan HP meningkat 100%. Setelah melepaskan 5 kali Ledakan Kegilaan, pilih 1 Awakened untuk dibangkitkan, dan segarkan efek amplifikasi Ledakan Kegilaan.
<RedQuality:Kelelahan>:Energi Kunci Perak dasar meningkat 200%]]
  },
  RelicConfig_140279_Name = {
    Text = "<RedQuality:Pendulum Dimensi-Kutukan Gaib>"
  },
  RelicConfig_140280_BattleDesc = {
    Text = [[
<OrangeQuality:Kebangkitan>: Setiap ronde setelah pertama kali melepaskan Fury Burst, reset cooldown Fury Burst Awakener tersebut dan berikan 50 Fury, hasilkan salinan sementara semua "Skill" dengan konsumsi daya komputasi 0 miliknya.
<RedQuality:Segel>: Setiap ronde setelah pertama kali melepaskan Fury Burst, segel Awakener lainnya.]]
  },
  RelicConfig_140280_Desc = {
    Text = [[
<OrangeQuality:Kebangkitan>: Setiap ronde setelah pertama kali melepaskan Fury Burst, reset cooldown Fury Burst Awakener tersebut dan berikan 50 Fury, hasilkan salinan sementara semua "Skill" dengan konsumsi daya komputasi 0 miliknya.
<RedQuality:Segel>: Setiap ronde setelah pertama kali melepaskan Fury Burst, segel Awakener lainnya.]]
  },
  RelicConfig_140280_Name = {
    Text = "<RedQuality:Pendulum Dimensi-Duel>"
  },
  RelicConfig_140281_BattleDesc = {
    Text = [[
<OrangeQuality:Gema>:Setelah giliran dimulai, tarik 3 kartu perintah dengan daya komputasi tertinggi dari tumpukan tarik, kartu perintah pertama yang dimainkan setiap giliran berlaku 2 kali.
<RedQuality:Pusing>:Setelah memainkan kartu perintah, buang semua kartu perintah lain yang konsumsi daya komputasinya tidak lebih rendah darinya.]]
  },
  RelicConfig_140281_Desc = {
    Text = [[
<OrangeQuality:Gema>:Setelah giliran dimulai, tarik 3 kartu perintah dengan daya komputasi tertinggi dari tumpukan tarik, kartu perintah pertama yang dimainkan setiap giliran berlaku 2 kali.
<RedQuality:Pusing>:Setelah memainkan kartu perintah, buang semua kartu perintah lain yang konsumsi daya komputasinya tidak lebih rendah darinya.]]
  },
  RelicConfig_140281_Name = {
    Text = "<RedQuality:Pendulum Dimensi-Kekacauan>"
  },
  RelicConfig_140282_BattleDesc = {
    Text = [[
<OrangeQuality:Daya Agung>: <PowerIconKeywords:Kekuatan> yang dihasilkan semua Awakener meningkat 50%, setiap kali memberikan 1 serangan damage mendapatkan [Arg2] poin <PowerIconKeywords:Kekuatan> sementara.
<RedQuality:Tak Berwujud>: Saat pertarungan dimulai, semua musuh mendapatkan 50 lapis <ParcloseIconKeywords:Penghalang>.]]
  },
  RelicConfig_140282_Desc = {
    Text = [[
<OrangeQuality:Daya Agung>: <PowerIconKeywords:Kekuatan> yang dihasilkan semua Awakener meningkat 50%, setiap kali memberikan 1 serangan damage mendapatkan [Arg2] poin <PowerIconKeywords:Kekuatan> sementara.
<RedQuality:Tak Berwujud>: Saat pertarungan dimulai, semua musuh mendapatkan 50 lapis <ParcloseIconKeywords:Penghalang>.]]
  },
  RelicConfig_140282_Name = {
    Text = "<RedQuality:Pendulum Dimensi-Sembunyi>"
  },
  RelicConfig_140840_BattleDesc = {
    Text = "Maximum Hand Size +1. Saat pertempuran dimulai, hasilkan 1 kartu \"<DerivativeCardKeywords_148:驭魇>\" dan masukkan ke tangan. Saat memainkan \"Serangan Dasar\" Awakener, Arithmetica Cost \"<DerivativeCardKeywords_148:驭魇>\" -1, menyebabkan [Arg1] poin Corrosion kepada semua musuh. Saat memainkan \"Pertahanan Dasar\" Awakener, dapatkan [Arg2] poin Strength, Final DMG dan Strength saat berikutnya memainkan \"<DerivativeCardKeywords_148:驭魇>\" meningkat [Arg3]%."
  },
  RelicConfig_140840_Desc = {
    Text = "Maximum Hand Size +1. Saat pertempuran dimulai, hasilkan 1 kartu \"<DerivativeCardKeywords_148:驭魇>\" dan masukkan ke tangan. Saat memainkan \"Serangan Dasar\" Awakener, Arithmetica Cost \"<DerivativeCardKeywords_148:驭魇>\" -1, menyebabkan [Arg1] poin Corrosion kepada semua musuh. Saat memainkan \"Pertahanan Dasar\" Awakener, dapatkan [Arg2] poin Strength, Final DMG dan Strength saat berikutnya memainkan \"<DerivativeCardKeywords_148:驭魇>\" meningkat [Arg3]%."
  },
  RelicConfig_140840_Name = {
    Text = "Perjuangan yang Sia-sia"
  },
  RelicConfig_140840_StoryDesc = {
    Text = [[
Si sia-sia Ketakutan akan perubahan, Ketakutan akan hal-hal yang lepas dari kendali, dan di tempat paling dalam, ia merasakan histeria Ketakutan akan kehilangan.
 Ia berulang kali meniup Siulan, ingin mengendalikan segalanya melalui Siulan itu, namun ia tidak berhasil mempertahankan apa pun.]]
  },
  RelicConfig_143665_BattleDesc = {
    Text = "Saat ronde Mulai, Pontos mendapatkan [Arg1] Aliemus. Setelah diambil, saat pertarungan berikutnya Mulai, hasilkan 3 \"Budak-Gaunt\" permanen. Saat play \"Budak-Gaunt\", Pontos mendapatkan 3 Aliemus."
  },
  RelicConfig_143665_Desc = {
    Text = "Saat ronde Mulai, Pontos mendapatkan [Arg1] Aliemus. Setelah diambil, saat pertarungan berikutnya Mulai, hasilkan 3 \"Budak-Gaunt\" permanen. Saat play \"Budak-Gaunt\", Pontos mendapatkan 3 Aliemus."
  },
  RelicConfig_143665_Name = {
    Text = "<OrangeQuality:Gambar Dimensi·Pontos>"
  },
  RelicConfig_145438_BattleDesc = {
    Text = "Saat giliran dimulai, Lotan: Cetarchon mendapatkan [Arg1] poin Aliemus, \"Pembelah Dunia\" menyebabkan \"Bilah Neraka\" Pengejaran dilepaskan saat giliran berikutnya dimulai: menimbulkan kerusakan sebesar 400% ATK Lotan: Cetarchon kepada semua musuh, kerusakan ini menikmati bonus kerusakan yang diperoleh \"Pembelah Dunia\" melalui \"Bilah Besar: Whalefall\" kali ini, dianggap sebagai \"Pukulan\"."
  },
  RelicConfig_145438_Desc = {
    Text = "Saat giliran dimulai, Lotan: Cetarchon mendapatkan [Arg1] poin Aliemus, \"Pembelah Dunia\" menyebabkan \"Bilah Neraka\" Pengejaran dilepaskan saat giliran berikutnya dimulai: menimbulkan kerusakan sebesar 400% ATK Lotan: Cetarchon kepada semua musuh, kerusakan ini menikmati bonus kerusakan yang diperoleh \"Pembelah Dunia\" melalui \"Bilah Besar: Whalefall\" kali ini, dianggap sebagai \"Pukulan\"."
  },
  RelicConfig_145438_Name = {
    Text = "<OrangeQuality:Gambar Dimensi·Lotan: Cetarchon>"
  },
  RelicConfig_146128_BattleDesc = {
    Text = "Hand Limit +1. Saat Mulai pertarungan atau setelah play \"<DerivativeCardKeywords_157:Tulang Pedang>\", masukkan 1 kartu \"<DerivativeCardKeywords_155:Tulang Gila>\" ke Hand, Shuffle 1 kartu \"<DerivativeCardKeywords_156:Tulang Luka>\" ke Menggambar. Jika dalam satu giliran play \"<DerivativeCardKeywords_155:Tulang Gila>\" dan \"<DerivativeCardKeywords_156:Tulang Luka>\" secara bersamaan, gabungkan kedua kartu tersebut menjadi \"<DerivativeCardKeywords_157:Tulang Pedang>\" dan masukkan ke Hand."
  },
  RelicConfig_146128_Desc = {
    Text = "Hand Limit +1. Saat Mulai pertarungan atau setelah play \"<DerivativeCardKeywords_157:Tulang Pedang>\", masukkan 1 kartu \"<DerivativeCardKeywords_155:Tulang Gila>\" ke Hand, Shuffle 1 kartu \"<DerivativeCardKeywords_156:Tulang Luka>\" ke Menggambar. Jika dalam satu giliran play \"<DerivativeCardKeywords_155:Tulang Gila>\" dan \"<DerivativeCardKeywords_156:Tulang Luka>\" secara bersamaan, gabungkan kedua kartu tersebut menjadi \"<DerivativeCardKeywords_157:Tulang Pedang>\" dan masukkan ke Hand."
  },
  RelicConfig_146128_Name = {
    Text = "Zirah Belulang Paus"
  },
  RelicConfig_146128_StoryDesc = {
    Text = "Tulang belulang Leviathan melindungi mereka yang dipilih-Nya, tak terkalahkan, tak mati, tak binasa."
  },
  RelicConfig_147547_BattleDesc = {
    Text = "Pada awal giliran, Casiah mendapatkan [Arg1] Aliemus. Setiap kali mengambil 1 kartu, Casiah mendapatkan [Arg2] poin Aliemus. Saat Casiah melepaskan Muliakan, semua musuh kehilangan [Arg3] poin Kekuatan."
  },
  RelicConfig_147547_Desc = {
    Text = "Pada awal giliran, Casiah mendapatkan [Arg1] Aliemus. Setiap kali mengambil 1 kartu, Casiah mendapatkan [Arg2] poin Aliemus. Saat Casiah melepaskan Muliakan, semua musuh kehilangan [Arg3] poin Kekuatan."
  },
  RelicConfig_147547_Name = {
    Text = "<OrangeQuality:Dimensi·Casiah>"
  },
  RelicConfig_147665_BattleDesc = {
    Text = "Arithmetica Limit dan jumlah Draw per giliran +1. Saat giliran dimulai, <FaxianKeywords:Temuan> 3 \"<Caroboo_Tips:Cokelat <Italic:Pistoles de Marie>>\" dan pilih salah satu. Hanya 1 yang asli: memilih yang asli akan mendapatkan Efek positifnya dan mengusir 1 jenis Negara negatif acak pada diri sendiri; memilih yang palsu akan menanggung Efek negatifnya dan membuat pilihan asli pada <FaxianKeywords:Temuan> berikutnya +1 dengan Efek berlipat ganda, direset setelah memilih yang asli."
  },
  RelicConfig_147665_Desc = {
    Text = "Arithmetica Limit dan jumlah Draw per giliran +1. Saat giliran dimulai, <FaxianKeywords:Temuan> 3 \"<Caroboo_Tips:Cokelat <Italic:Pistoles de Marie>>\" dan pilih salah satu. Hanya 1 yang asli: memilih yang asli akan mendapatkan Efek positifnya dan mengusir 1 jenis Negara negatif acak pada diri sendiri; memilih yang palsu akan menanggung Efek negatifnya dan membuat pilihan asli pada <FaxianKeywords:Temuan> berikutnya +1 dengan Efek berlipat ganda, direset setelah memilih yang asli."
  },
  RelicConfig_147665_Name = {
    Text = "Cokelat <Italic:Pistoles de Marie>"
  },
  RelicConfig_147665_StoryDesc = {
    Text = "Manis dan berharga… benarkah?"
  },
  RelicConfig_148525_BattleDesc = {
    Text = "Saat putaran dimulai, Ogier Bersumpah mendapatkan [Arg1] poin Aliemus, \"Arus Tersembunyi\" tidak lagi mengurangi jumlah Draw."
  },
  RelicConfig_148525_Desc = {
    Text = "Saat putaran dimulai, Ogier Bersumpah mendapatkan [Arg1] poin Aliemus, \"Arus Tersembunyi\" tidak lagi mengurangi jumlah Draw."
  },
  RelicConfig_148525_Name = {
    Text = "<OrangeQuality:Gambar Dimensi·Sumpah Negatif·Ogier>"
  },
  RelicConfig_149665_BattleDesc = {
    Text = [[
Lingkungan saat ini dianggap sebagai "Padang Es".
Hiperborea: Setelah fase Draw, berikan 1 lapis <SlowIconKeywords:Stagnation>, <RetainIconKeywords:Retain> pada 2 Kartu perintah yang belum di-Freeze dengan Arithmetica tertinggi di tangan. Ketika Kartu perintah mana pun memiliki setidaknya 3 lapis <SlowIconKeywords:Stagnation>, hapus <SlowIconKeywords:Stagnation> dan <RetainIconKeywords:Retain> yang diberikan dalam pertarungan ini, lalu "Freeze" kartu tersebut dan tambahkan 25 lapis <TempPowerKeywords2:Memperkuat>.]]
  },
  RelicConfig_149665_Desc = {
    Text = [[
Lingkungan saat ini dianggap sebagai "Padang Es".
Hiperborea: Setelah fase Draw, berikan 1 lapis <SlowIconKeywords:Stagnation>, <RetainIconKeywords:Retain> pada 2 Kartu perintah yang belum di-Freeze dengan Arithmetica tertinggi di tangan. Ketika Kartu perintah mana pun memiliki setidaknya 3 lapis <SlowIconKeywords:Stagnation>, hapus <SlowIconKeywords:Stagnation> dan <RetainIconKeywords:Retain> yang diberikan dalam pertarungan ini, lalu "Freeze" kartu tersebut dan tambahkan 25 lapis <TempPowerKeywords2:Memperkuat>.]]
  },
  RelicConfig_149665_Name = {
    Text = "<OrangeQuality:Inti Kristal Padang Es>"
  },
  RelicConfig_149665_StoryDesc = {
    Text = [[
Ia bukan pembawa dingin.
Ia hanya mengingatkan bumi, bahwa musim dingin tak pernah pergi.]]
  },
  RelicConfig_20164_BattleDesc = {
    Text = "Setiap kali memberikan 1 Kerusakan, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan> sementara, hingga maksimal 5 lapis. Saat lapisan mencapai batas maksimal, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_20164_Desc = {
    Text = "Setiap kali memberikan 1 Kerusakan, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan> sementara, hingga maksimal 5 lapis. Saat lapisan mencapai batas maksimal, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_20164_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Belum Tidur\">"
  },
  RelicConfig_20165_BattleDesc = {
    Text = "Membangunkan semua Pembangun saat diambil. Setelah memainkan <ExaltIconKeywords:Membangkitkan>, secara acak dapatkan 2 Kartu perintah dari Pembangun tersebut dan tambahkan status \"Lelah\" dan \"Ilusi\"."
  },
  RelicConfig_20165_Desc = {
    Text = "Membangunkan semua Pembangun saat diambil. Setelah memainkan <ExaltIconKeywords:Membangkitkan>, secara acak dapatkan 2 Kartu perintah dari Pembangun tersebut dan tambahkan status \"Lelah\" dan \"Ilusi\"."
  },
  RelicConfig_20165_Name = {
    Text = "<OrangeQuality:Wahyu-Nya+>"
  },
  RelicConfig_20165_StoryDesc = {
    Text = "Dia berkata, \"Jangan takut.\""
  },
  RelicConfig_20166_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Alam Mahir> meningkatkan sebesar 100. Kartu pertama yang dimainkan setiap ronde akan dikembalikan ke tangan. Saat ronde Ultra dimulai, batas kartu tangan untuk ronde tersebut +5 dan salin kartu di tanganmu."
  },
  RelicConfig_20166_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Alam Mahir> meningkatkan sebesar 100. Kartu pertama yang dimainkan setiap ronde akan diambil kembali dari Tumpukan kartu buang ke tangan. Saat ronde Ultra dimulai, batas kartu tangan +5 dan salin kartu di tanganmu, kartu yang disalin ditambahkan <NothingnessIconKeywords:Void> dan <DepleteIconKeywords:Lelah>."
  },
  RelicConfig_20166_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Pencuri Mimpi\">"
  },
  RelicConfig_20167_BattleDesc = {
    Text = "Jika ada Aritmetika tersisa di akhir ronde, tarik 2 kartu tambahan pada ronde berikutnya; jika ada kartu tersisa di tangan, dapatkan 2 Aritmetika tambahan pada ronde berikutnya."
  },
  RelicConfig_20167_Desc = {
    Text = "Jika ada Aritmetika tersisa di akhir ronde, tarik 2 kartu tambahan pada ronde berikutnya; jika ada kartu tersisa di tangan, dapatkan 2 Aritmetika tambahan pada ronde berikutnya."
  },
  RelicConfig_20167_Name = {
    Text = "<OrangeQuality:Roda Matahari dan Bulan+>"
  },
  RelicConfig_20167_StoryDesc = {
    Text = "Tebak, apakah itu hitam atau putih?"
  },
  RelicConfig_20168_BattleDesc = {
    Text = "Batas Tentakel +2. Setelah melepaskan Muliakan, Kerusakan Tentakel +[Arg1]. Jika Muliakan dilepaskan 3 kali dalam satu ronde, semua Tentakel akan terpicu sekali."
  },
  RelicConfig_20168_Desc = {
    Text = "Batas Tentakel +2. Setelah melepaskan Muliakan, Kerusakan Tentakel +[Arg1]. Jika Muliakan dilepaskan 3 kali dalam satu ronde, semua Tentakel akan terpicu sekali."
  },
  RelicConfig_20168_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Tidur Dangkal\">"
  },
  RelicConfig_20169_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Kecakapan Alam> meningkat sebesar 100. Setiap memainkan 1 kartu <EmbryoFusionIconKeywords:Fusi Embrio> +10, ketika Hidup di bawah 25% meningkat menjadi 20, setiap putaran paling banyak berlaku 10 kali."
  },
  RelicConfig_20169_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Kecakapan Alam> meningkat sebesar 100. Setiap memainkan 1 kartu <EmbryoFusionIconKeywords:Fusi Embrio> +10, ketika Hidup di bawah 25% meningkat menjadi 20, setiap putaran paling banyak berlaku 10 kali."
  },
  RelicConfig_20169_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Mengalir\">"
  },
  RelicConfig_20170_BattleDesc = {
    Text = "Pada awal pertempuran, semua Pembangun mendapatkan 50 poin Aliemus. Tempatkan 2 kartu <DerivativeCardKeywords_1:\"Gema Bayangan Terlupakan\"> di tangan."
  },
  RelicConfig_20170_Desc = {
    Text = "Pada awal pertempuran, semua Pembangun mendapatkan 50 poin Aliemus. Tempatkan 2 kartu <DerivativeCardKeywords_1:\"Gema Bayangan Terlupakan\"> di tangan."
  },
  RelicConfig_20170_Name = {
    Text = "<OrangeQuality:Perangkat Komunikasi+>"
  },
  RelicConfig_20170_StoryDesc = {
    Text = "Menantikan atau takut akan saat lonceng itu berbunyi dengan suara yang nyaring."
  },
  RelicConfig_20171_BattleDesc = {
    Text = "Mendapatkan 1 Relik perak. 1 Relik emas. dan 1 Relik terkutuk secara acak saat diambil."
  },
  RelicConfig_20171_Desc = {
    Text = "Mendapatkan 1 Relik perak. 1 Relik emas. dan 1 Relik terkutuk secara acak saat diambil."
  },
  RelicConfig_20171_Name = {
    Text = "<OrangeQuality:Penayangan Terbalik+>"
  },
  RelicConfig_20171_StoryDesc = {
    Text = [[
Di era yang aneh, bunga adalah penonton pertama bagi manusia.
Jangan bergerak, mereka lebih menyukai objek pameran yang tenang.]]
  },
  RelicConfig_20172_BattleDesc = {
    Text = "Ketika jumlah Kartu perintah yang dimainkan dalam satu ronde mencapai 3, dapatkan 1 Kartu <DerivativeCardKeywords_4:\"Inspirasi\">. Saat mencapai 6, dapatkan 1 Kartu <DerivativeCardKeywords_4:\"Inspirasi\"> lagi. Ketika mencapai 10, pada awal ronde berikutnya, dapat memilih 2 kartu dari dek untuk dimasukkan ke dalam tangan."
  },
  RelicConfig_20172_Desc = {
    Text = "Ketika jumlah Kartu perintah yang dimainkan dalam satu ronde mencapai 3, dapatkan 1 Kartu <DerivativeCardKeywords_4:\"Inspirasi\">. Saat mencapai 6, dapatkan 1 Kartu <DerivativeCardKeywords_4:\"Inspirasi\"> lagi. Ketika mencapai 10, pada awal ronde berikutnya, dapat memilih 2 kartu dari dek untuk dimasukkan ke dalam tangan."
  },
  RelicConfig_20172_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Gema\">"
  },
  RelicConfig_20173_BattleDesc = {
    Text = "Kerusakan terhadap musuh dalam kondisi negara meningkat sebesar 50%, setelah membunuh musuh, pembunuh mendapatkan 100 Aliemus."
  },
  RelicConfig_20173_Desc = {
    Text = "Kerusakan terhadap musuh dalam kondisi negara meningkat sebesar 50%, setelah membunuh musuh, pembunuh mendapatkan 100 Aliemus."
  },
  RelicConfig_20173_Name = {
    Text = "<OrangeQuality:Tongkat Pendeta+>"
  },
  RelicConfig_20173_StoryDesc = {
    Text = "Ketakwaan yang tidak diperbolehkan."
  },
  RelicConfig_20174_BattleDesc = {
    Text = "Setelah diambil, DMG Amplification tim berubah menjadi 150% dari nilai aslinya. Setelah putaran dimulai, berikan [Arg1] poin <FixedDamage:Kerusakan Murni> kepada musuh acak, setiap 1 kali Posse digunakan dalam pertarungan ini, kerusakan +[Arg2], Peningkatan Kerusakan ini mendapat bonus DMG Amplification tim."
  },
  RelicConfig_20174_Desc = {
    Text = "Setelah diambil, DMG Amplification tim berubah menjadi 150% dari nilai aslinya. Setelah putaran dimulai, berikan [Arg1] poin <FixedDamage:Kerusakan Murni> kepada musuh acak, setiap 1 kali Posse digunakan dalam pertarungan ini, kerusakan +[Arg2], Peningkatan Kerusakan ini mendapat bonus DMG Amplification tim."
  },
  RelicConfig_20174_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Hilang\">"
  },
  RelicConfig_20175_BattleDesc = {
    Text = "Meningkatkan efek <WeaknessIconKeywords:Kelemahan> sebesar 8%, dan efek <VulnerabilityIconKeywords:Rentan> sebesar 25%. Saat memberikan <WeaknessIconKeywords:Kelemahan> atau <VulnerabilityIconKeywords:Rentan>, mencuri sementara [Arg1] poin <PowerIconKeywords:Kekuatan> dari target."
  },
  RelicConfig_20175_Desc = {
    Text = "Meningkatkan efek <WeaknessIconKeywords:Kelemahan> sebesar 8%, dan efek <VulnerabilityIconKeywords:Rentan> sebesar 25%. Saat memberikan <WeaknessIconKeywords:Kelemahan> atau <VulnerabilityIconKeywords:Rentan>, mencuri sementara [Arg1] poin <PowerIconKeywords:Kekuatan> dari target."
  },
  RelicConfig_20175_Name = {
    Text = "<OrangeQuality:Foto Pudar+>"
  },
  RelicConfig_20175_StoryDesc = {
    Text = "Foto yang kabur membawa memori yang samar, atau mungkin — justru karena kekurangan dalam memori, yang menyebabkan warna pada foto memudar."
  },
  RelicConfig_20176_BattleDesc = {
    Text = "Pada awal ronde, dapatkan 2 Aritmetika untuk setiap 1 musuh. Saat membunuh musuh dengan Kerusakan aktif, berikan kerusakan berlebih dua kali lipat kepada musuh lainnya <BleedingIconKeywords:Berdarah>."
  },
  RelicConfig_20176_Desc = {
    Text = "Pada awal ronde, dapatkan 2 Aritmetika untuk setiap 1 musuh. Saat membunuh musuh dengan Kerusakan aktif, berikan kerusakan berlebih dua kali lipat kepada musuh lainnya <BleedingIconKeywords:Berdarah>."
  },
  RelicConfig_20176_Name = {
    Text = "<OrangeQuality: Lagu Kaum Plebeian +>"
  },
  RelicConfig_20176_StoryDesc = {
    Text = "Dirancang khusus untuk menyiksa telingamu."
  },
  RelicConfig_20177_BattleDesc = {
    Text = "Setelah diambil, Ketahanan meningkat dua kali lipat. Setelah memberikan kerusakan, akan memberikan efek <BleedingIconKeywords:Bleed> yang setara dengan 50% dari kerusakan pada target. Setiap kali Ketahanan dipicu, semua musuh akan langsung terkena 1 efek perdarahan."
  },
  RelicConfig_20177_Desc = {
    Text = "Setelah diambil, Ketahanan berlipat ganda. Setelah memberikan kerusakan, juga akan memberikan efek <BleedingIconKeywords:Berdarah> yang setara dengan 50% dari kerusakan pada target. Setiap kali Ketahanan dipicu, semua musuh akan langsung terkena efek pendarahan 1 kali."
  },
  RelicConfig_20177_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Kebangkitan\">"
  },
  RelicConfig_20178_BattleDesc = {
    Text = "Setiap kali memberikan 1 Kerusakan aktif, dapatkan 3 poin Aliemus dan berikan [Arg1] lapisan <IntoxicationIconKeywords:Racun> pada target. Jika jumlah pemicu dalam Pertempuran ini mencapai 25 kali, segera picu <IntoxicationIconKeywords:Racun> pada semua musuh."
  },
  RelicConfig_20178_Desc = {
    Text = "Setiap kali memberikan 1 Kerusakan aktif, dapatkan 3 poin Aliemus dan berikan [Arg1] lapisan <IntoxicationIconKeywords:Racun> pada target. Jika jumlah pemicu dalam Pertempuran ini mencapai 25 kali, segera picu <IntoxicationIconKeywords:Racun> pada semua musuh."
  },
  RelicConfig_20178_Name = {
    Text = "<OrangeQuality:Mesin Jahit Berdebu+>"
  },
  RelicConfig_20178_StoryDesc = {
    Text = "Seorang ibu yang penuh kasih, menjahit luka di hati."
  },
  RelicConfig_21906_BattleDesc = {
    Text = "\"Serangan\"memperoleh 3 poin Aritmetika, membuang 1 kartu secara acak; \"Pertahanan\"menarik 3 kartu, kehilangan 1 poin Aritmetika."
  },
  RelicConfig_21906_Desc = {
    Text = "\"Serangan\"memperoleh 3 poin Aritmetika, membuang 1 kartu secara acak; \"Pertahanan\"menarik 3 kartu, kehilangan 1 poin Aritmetika."
  },
  RelicConfig_21906_Name = {
    Text = "<RedQuality:Rekaman Bahagia+>"
  },
  RelicConfig_21906_StoryDesc = {
    Text = [[
Rekaman penampilan terakhir dari pemain biola terkenal. 
 Sejak saat itu, ia dapat membawa api.]]
  },
  RelicConfig_23688_BattleDesc = {
    Text = "Setiap kali memicu 1 kali Melahap, dapatkan 30 poin <EmbryoFusionIconKeywords:Fusi Embrio> dan [Arg1] poin <PowerIconKeywords:Kekuatan>. Jika memicu untuk kedua kalinya dalam 1 ronde, dapatkan 1 poin Aritmetika, menarik 1 kartu. Jika memicu untuk ketiga kalinya dalam 1 ronde, dapatkan 2 poin Aritmetika, menarik 2 kartu."
  },
  RelicConfig_23688_Desc = {
    Text = "Setiap kali memicu 1 kali Melahap, dapatkan 30 poin <EmbryoFusionIconKeywords:Fusi Embrio> dan [Arg1] poin <PowerIconKeywords:Kekuatan>. Jika memicu untuk kedua kalinya dalam 1 ronde, dapatkan 1 poin Aritmetika, ambil 1 kartu, jika memicu untuk ketiga kalinya dalam 1 ronde, dapatkan 2 poin Aritmetika, ambil 2 kartu."
  },
  RelicConfig_23688_Name = {
    Text = "<OrangeQuality:Pendulum waktu \"Kembali Memakan\">"
  },
  RelicConfig_23689_BattleDesc = {
    Text = "Setelah mengambil, semua Awakener mendapatkan 30 poin Aliemus. Setiap kali melepaskan Exalt, jumlahnya bertambah 1 poin. Setelah melepaskan Posse, dapatkan [Arg1] poin Kewaspadaan Sementara, [Arg2] poin Sementara<PowerIconKeywords:Kekuatan>, dan semua Awakener mendapatkan 6 poin Aliemus, menghabiskan semua hitungan, setiap poin hitungan berlaku tambahan 1 kali."
  },
  RelicConfig_23689_Desc = {
    Text = "Setelah diambil, semua Awakener mendapatkan 30 poin Aliemus. Setiap kali melepaskan Exalt, hitungan bertambah 1 poin. Setelah melepaskan Posse, dapatkan [Arg1] poin Kewaspadaan Sementara, [Arg2] poin Sementara<PowerIconKeywords:Kekuatan> dan semua Awakener mendapatkan 6 poin Aliemus, menghabiskan semua hitungan, setiap poin hitungan berlaku tambahan 1 kali."
  },
  RelicConfig_23689_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Muatan\">"
  },
  RelicConfig_23690_BattleDesc = {
    Text = "Setiap tambahan 1 poin Arithmetica atau 1 kartu tambahan yang ditarik, mencuri [Arg1] poin <PowerIconKeywords:Kekuatan> dari semua musuh, mendapatkan 4% Crit. Rate Sementara, efek Elite atau Pertarungan Pemimpin menjadi dua kali lipat. Setelah ronde Ultra dimulai, dapatkan [Arg2] poin <PowerIconKeywords:Kekuatan>, Crit. DMG +15%."
  },
  RelicConfig_23690_Desc = {
    Text = "Setiap 1 poin Arithmetica tambahan yang didapat atau 1 kartu tambahan yang ditarik, mencuri [Arg1] poin <PowerIconKeywords:Kekuatan> dari semua musuh, mendapatkan 4% Crit. Rate Sementara, efek Elite atau Pertarungan Pemimpin menjadi dua kali lipat. Setelah dimulainya ronde Ultra, dapatkan [Arg2] poin <PowerIconKeywords:Kekuatan>, Crit. DMG +15%."
  },
  RelicConfig_23690_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Retakan\">"
  },
  RelicConfig_23691_BattleDesc = {
    Text = "Setiap memberikan 5 kali Kerusakan, pulihkan [Arg1] poin Hidup. Setiap kehilangan 1 poin Hidup, Kerusakan Tentakel +[Arg2]. Jika kehilangan Hidup lebih dari [Arg3] poin, aktifkan semua Tentakel sekali."
  },
  RelicConfig_23691_Desc = {
    Text = "Setiap kali memberikan 5 kerusakan, pulihkan [Arg1] poin hidup. Setiap kehilangan 1 kali hidup, kerusakan tentakel +[Arg2]. Jika kehilangan hidup melebihi 10% dari kesehatan maksimum, semua tentakel akan terpicu 1 kali."
  },
  RelicConfig_23691_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Pasang\">"
  },
  RelicConfig_35135_BattleDesc = {
    Text = "Setiap kali memberikan 1 Kerusakan, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan> sementara dan [Arg2] poin Kerusakan sementara tentakel, maksimal terpicu 12 kali per ronde. Jika dalam 1 ronde memberikan 4 kali kerusakan, terapkan 1 lapisan Vulnerable pada semua musuh dan dapatkan [Arg3] poin Perisai. Jika memberikan 8 kali kerusakan, terapkan 1 lapisan Weakness pada semua musuh dan pulihkan [Arg3] poin HP."
  },
  RelicConfig_35135_Desc = {
    Text = "Setiap kali memberikan 1 Kerusakan, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan> sementara dan [Arg2] poin Kerusakan sementara tentakel, maksimal terpicu 12 kali per ronde. Jika dalam 1 ronde memberikan 4 kali Kerusakan, terapkan 1 lapisan Vulnerable pada semua musuh dan dapatkan [Arg3] poin Perisai. Jika memberikan 8 kali Kerusakan, terapkan 1 lapisan Weakness pada semua musuh dan pulihkan [Arg3] poin HP."
  },
  RelicConfig_35135_Name = {
    Text = "<OrangeQuality:Pendulum waktu \"Terkagum\">"
  },
  RelicConfig_35136_BattleDesc = {
    Text = "Kerusakan dari \"Serangan\" dan perisai yang diperoleh dari \"Pertahanan\" meningkat sebesar 30%. Jika dalam 1 putaran terdapat 4 kartu atau lebih \"Serangan\" dan \"Pertahanan\" yang dimainkan, pada awal putaran berikutnya, tarik 2 kartu dan dapatkan 1 poin Aritmetika."
  },
  RelicConfig_35136_Desc = {
    Text = "Kerusakan dari \"Serangan\" dan perisai yang diperoleh dari \"Pertahanan\" meningkat sebesar 30%. Jika dalam 1 putaran terdapat 4 kartu atau lebih \"Serangan\" dan \"Pertahanan\" yang dimainkan, pada awal putaran berikutnya, tarik 2 kartu dan dapatkan 1 poin Aritmetika."
  },
  RelicConfig_35136_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Kegigihan\">"
  },
  RelicConfig_35137_BattleDesc = {
    Text = "Setiap kali memainkan 1 kartu, mendapatkan [Arg1] poin sementara <PowerIconKeywords:Kekuatan> dan memulihkan [Arg2] poin HP, setelah menyebabkan kerusakan aktif, hilangkan [Arg2] poin <PowerIconKeywords:Kekuatan> yang didapat dari Relik ini. Setiap kali Awakener membunuh satu musuh, mendapatkan 30 poin Aliemus."
  },
  RelicConfig_35137_Desc = {
    Text = "Setiap kali memainkan 1 kartu, mendapatkan [Arg1] poin sementara <PowerIconKeywords:Kekuatan> dan memulihkan [Arg2] poin HP, setelah menyebabkan kerusakan aktif, hapus [Arg2] poin <PowerIconKeywords:Kekuatan> yang diperoleh dari Relik tersebut. Awakener mendapatkan 30 poin Aliemus setiap kali membunuh satu musuh."
  },
  RelicConfig_35137_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Akumulasi\">"
  },
  RelicConfig_35138_BattleDesc = {
    Text = "Setelah melepaskan Aliemus Muliakan, berikan [Arg1] titik Racun kepada musuh acak. Setiap kali menggunakan 1 Kartu perintah, dapatkan [Arg2] titik Counter sementara. Pada akhir setiap 4 putaran, berikan Kerusakan kepada semua musuh sebesar total lapisan Racun musuh dan lapisan Counter diri sendiri."
  },
  RelicConfig_35138_Desc = {
    Text = "Setelah melepaskan Aliemus Muliakan, berikan [Arg1] titik Racun kepada musuh acak. Setiap kali menggunakan 1 Kartu perintah, dapatkan [Arg2] titik Counter sementara. Pada akhir setiap 4 putaran, berikan Kerusakan kepada semua musuh sebesar total lapisan Racun musuh dan lapisan Counter diri sendiri."
  },
  RelicConfig_35138_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Menyebar\">"
  },
  RelicConfig_35139_BattleDesc = {
    Text = "Setelah mengambil, efek serangan tim meningkat 30%. Setiap serangan ke-4 pasti menjadi kritis, dan Crit. DMG meningkat 50%. Jika serangan itu membunuh, dapatkan 5 poin Segil hitam."
  },
  RelicConfig_35139_Desc = {
    Text = "Setelah mengambil, efek serangan tim meningkat 30%. Setiap serangan ke-4 pasti menjadi kritis, dan Crit. DMG meningkat 50%. Jika serangan itu membunuh, dapatkan 5 poin Segil hitam."
  },
  RelicConfig_35139_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Akhir\">"
  },
  RelicConfig_36823_BattleDesc = {
    Text = "Setelah melepaskan Muliakan, tarik 1 Kartu. Untuk setiap Kartu yang dibuang, semua Pembangun mendapatkan 3 poin Aliemus, maksimal 15 poin per putaran."
  },
  RelicConfig_36823_Desc = {
    Text = "Setelah melepaskan Muliakan, tarik 1 Kartu. Untuk setiap Kartu yang dibuang, semua Pembangun mendapatkan 3 poin Aliemus, maksimal 15 poin per putaran."
  },
  RelicConfig_36823_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Pergi-pulang\">"
  },
  RelicConfig_36824_BattleDesc = {
    Text = "Setiap kali Lelah Aritmetika, tarik 1 kartu, setiap ronde efek ini dapat diaktifkan hingga 5 kali. Setiap kali dek kartu diatur ulang, dapatkan 2 Aritmetika."
  },
  RelicConfig_36824_Desc = {
    Text = "Setiap kali Lelah Aritmetika, tarik 1 kartu, setiap ronde efek ini dapat diaktifkan hingga 5 kali. Setiap kali dek kartu diatur ulang, dapatkan 2 Aritmetika."
  },
  RelicConfig_36824_Name = {
    Text = "<OrangeQuality:Pendulum waktu \"Tidak Tidur\">"
  },
  RelicConfig_39302_BattleDesc = {
    Text = "Setiap kali memberikan 4 Kerusakan, masukkan 1 kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam tumpukan Menggambar, maksimal 3 kali per ronde. Setelah melepaskan Muliakan, mainkan dan gunakan semua kartu <DerivativeCardKeywords_4:\"Inspirasi\"> di tumpukan kartu hingga Lelah."
  },
  RelicConfig_39302_Desc = {
    Text = "Setiap kali memberikan 4 Kerusakan, masukkan 1 kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam tumpukan Menggambar, maksimal 3 kali per ronde. Setelah melepaskan Muliakan, mainkan dan gunakan semua kartu <DerivativeCardKeywords_4:\"Inspirasi\"> di tumpukan kartu hingga Lelah."
  },
  RelicConfig_39302_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Mimpi Misterius\">"
  },
  RelicConfig_39303_BattleDesc = {
    Text = "Ketika batas aritmetika saat ini adalah ganjil, dianggap memiliki tambahan [Arg2] poin Kewaspadaan Sementara. Ketika batas aritmetika saat ini adalah genap, dianggap memiliki tambahan [Arg1] poin sementara <PowerIconKeywords:Kekuatan> dan [Arg3] poin sementara kerusakan tentakel. Untuk setiap 1 Relik emas yang dimiliki, efek relik ini meningkat sebesar 50%, dan untuk setiap 1 Relik terkutuk yang dimiliki, meningkat sebesar 80%."
  },
  RelicConfig_39303_Desc = {
    Text = "Ketika batas aritmetika saat ini ganjil, dianggap memiliki tambahan [Arg2] poin Kewaspadaan Sementara. Ketika batas aritmetika saat ini genap, dianggap memiliki tambahan [Arg1] poin sementara <PowerIconKeywords:Kekuatan> dan [Arg3] poin Kerusakan sementara Tentacle. Untuk setiap 1 Relik emas yang dimiliki, efek relik ini meningkat sebesar 50%, dan untuk setiap 1 Relik terkutuk yang dimiliki, meningkat sebesar 80%."
  },
  RelicConfig_39303_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Mimpi Terkejut\">"
  },
  RelicConfig_44192_BattleDesc = {
    Text = "Pada awal setiap ronde, semua Pembangun mendapatkan 20 Aliemus. Saat diambil, Kesehatan maksimum berkurang sebesar 50%."
  },
  RelicConfig_44192_Desc = {
    Text = "Pada awal setiap ronde, semua Pembangun mendapatkan 20 Aliemus. Saat diambil, Kesehatan maksimum berkurang sebesar 50%."
  },
  RelicConfig_44192_Name = {
    Text = "<RedQuality: Rasa Bersalah·Ilusi Mimpi Buruk>"
  },
  RelicConfig_44192_StoryDesc = {
    Text = "Tidur yang berlebihan adalah keinginan, yang akan melahap segalanya tanpa kau sadari."
  },
  RelicConfig_44300_BattleDesc = {
    Text = "Pada awal setiap putaran, semua Pembangun mendapatkan 25 Aliemus. Saat diambil, Kesehatan maksimum menjadi 3 kali lipat."
  },
  RelicConfig_44300_Desc = {
    Text = "Pada awal setiap putaran, semua Pembangun mendapatkan 25 Aliemus. Saat diambil, Kesehatan maksimum menjadi 3 kali lipat."
  },
  RelicConfig_44300_Name = {
    Text = "<OrangeQuality:Terberkati·Manifestasi Mimpi Buruk>"
  },
  RelicConfig_44300_StoryDesc = {
    Text = "Tak perlu takut, tak perlu ragu. Ini hanyalah mimpi sesaat, cahaya Sang Pencipta masih menyinari dirimu."
  },
  RelicConfig_44592_BattleDesc = {
    Text = "Setelah pertempuran, dapatkan 100 segil hitam dan 2 kartu gejala."
  },
  RelicConfig_44592_Desc = {
    Text = "Setelah pertempuran, dapatkan 100 segil hitam dan 2 kartu gejala."
  },
  RelicConfig_44592_Name = {
    Text = "<RedQuality:Rasa Bersalah·Jade Print>"
  },
  RelicConfig_44592_StoryDesc = {
    Text = "Dosa kuno terukir di sini."
  },
  RelicConfig_44593_BattleDesc = {
    Text = "Saat diambil, berubah menjadi 1 Relik acak selain dirinya sendiri dan mendapatkan 75 Segil hitam."
  },
  RelicConfig_44593_Desc = {
    Text = "Saat diambil, berubah menjadi 1 Relik acak selain dirinya sendiri dan mendapatkan 75 Segil hitam."
  },
  RelicConfig_44593_Name = {
    Text = "<RedQuality: Batu Nisan Kutukan Dosa>"
  },
  RelicConfig_44593_StoryDesc = {
    Text = "Dengar, ada seseorang yang memanggil dari dalam."
  },
  RelicConfig_44594_BattleDesc = {
    Text = "Setiap 2 putaran, kerusakan aktif dan tentakel yang diterima oleh semua musuh menjadi dua kali lipat, tetapi dalam putaran tersebut, setiap kali melepaskan 1 Muliakan, segel semua Pembangun selama 1 putaran, dan diri sendiri menjadi rentan."
  },
  RelicConfig_44594_Desc = {
    Text = "Setiap 2 putaran, kerusakan aktif dan tentakel yang diterima oleh semua musuh menjadi dua kali lipat, tetapi dalam putaran tersebut, setiap kali melepaskan 1 Muliakan, segel semua Pembangun selama 1 putaran, dan diri sendiri menjadi rentan."
  },
  RelicConfig_44594_Name = {
    Text = "<RedQuality:Rasa Bersalah·Sisa-sisa Jalan>"
  },
  RelicConfig_44594_StoryDesc = {
    Text = [[
Sebagian dari kesucian.
Setelah terpisah dari tubuh, itu telah tercemar oleh dosa.]]
  },
  RelicConfig_44597_BattleDesc = {
    Text = "Setiap kali memberikan 1 kerusakan aktif, [Arg1] lapisan <BleedingIconKeywords:Berdarah> diberikan pada diri sendiri, dan [Arg2] lapisan <BleedingIconKeywords:Berdarah> diberikan pada target kerusakan."
  },
  RelicConfig_44597_Desc = {
    Text = "Setiap kali memberikan 1 kerusakan aktif, [Arg1] lapisan <BleedingIconKeywords:Berdarah> diberikan pada diri sendiri, dan [Arg2] lapisan <BleedingIconKeywords:Berdarah> diberikan pada target kerusakan."
  },
  RelicConfig_44597_Name = {
    Text = "<RedQuality: Rasa Bersalah · Kesadaran Kumpulan Serangga>"
  },
  RelicConfig_44597_StoryDesc = {
    Text = "Jalinan, simbiosis, berkelompok; ketakutan, yang tidak diketahui, kontrol."
  },
  RelicConfig_44598_BattleDesc = {
    Text = "Setelah melepaskan Aliemus Muliakan, kehilangan 12% dari Hidup saat ini, mencuri [Arg1] poin sementara <PowerIconKeywords:Kekuatan> dari semua musuh. Jika hanya ada 1 musuh, mencuri tambahan [Arg2] poin sementara <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_44598_Desc = {
    Text = "Setelah melepaskan Aliemus Muliakan, kehilangan 12% dari Hidup saat ini, mencuri [Arg1] poin sementara <PowerIconKeywords:Kekuatan> dari semua musuh. Jika hanya ada 1 musuh, mencuri tambahan [Arg2] poin sementara <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_44598_Name = {
    Text = "<RedQuality:Burung Ritual · Nasib Buruk>"
  },
  RelicConfig_44598_StoryDesc = {
    Text = "Makhluk malang yang tewas akibat keserakahan, mengeluarkan jeritan menyayat hati dari dada yang kering."
  },
  RelicConfig_44603_BattleDesc = {
    Text = "Batas kartu tangan meningkat 5, saat pertempuran dimulai menggambar 6 kartu. Saat akhir ronde, buang semua kartu gejala dan kartu negara di tangan, simpan kartu lainnya, tetapi jumlah kartu yang ditarik setiap ronde berkurang 2."
  },
  RelicConfig_44603_Desc = {
    Text = "Batas kartu tangan meningkat 5, saat pertempuran dimulai menggambar 6 kartu. Saat akhir ronde, buang semua kartu gejala dan kartu negara di tangan, simpan kartu lainnya, tetapi jumlah kartu yang ditarik setiap ronde berkurang 2."
  },
  RelicConfig_44603_Name = {
    Text = "<RedQuality:Kesalahan·Pengukiran Kesadaran>"
  },
  RelicConfig_44603_StoryDesc = {
    Text = "Orang yang serakah menjadikan orang lain sebagai objek, meraih kenikmatan dirinya dari penderitaan orang lain."
  },
  RelicConfig_44608_BattleDesc = {
    Text = "Setelah diambil, kehilangan permanen [Arg1] <PowerIconKeywords:Kekuatan>. Setiap kali memberikan kerusakan, pulihkan [Arg2] poin hidup, maksimal 6 kali per ronde."
  },
  RelicConfig_44608_Desc = {
    Text = "Setelah diambil, kehilangan permanen [Arg1] <PowerIconKeywords:Kekuatan>. Setiap kali memberikan kerusakan, pulihkan [Arg2] poin hidup, maksimal 6 kali per ronde."
  },
  RelicConfig_44608_Name = {
    Text = "<RedQuality:Rasa Bersalah·Ciuman Lamprey>"
  },
  RelicConfig_44608_StoryDesc = {
    Text = "Ciumannya akan membuatmu tenggelam — tentu saja, yang tenggelam mungkin juga dirimu sendiri."
  },
  RelicConfig_44609_BattleDesc = {
    Text = "Meningkatkan aritmetika maksimum sebesar 3. Setiap kali dek kartu direset, tambahkan 2 kartu <DerivativeCardKeywords_9:\"Pincang\"> ke tumpukan menggambar."
  },
  RelicConfig_44609_Desc = {
    Text = "Meningkatkan aritmetika maksimum sebesar 3. Setiap kali dek kartu direset, tambahkan 2 kartu <DerivativeCardKeywords_9:\"Pincang\"> ke tumpukan menggambar."
  },
  RelicConfig_44609_Name = {
    Text = "<RedQuality:Rasa Bersalah·Lilin hitam>"
  },
  RelicConfig_44609_StoryDesc = {
    Text = "Membakar akal sehat, jatuh ke dalam kegilaan."
  },
  RelicConfig_44610_BattleDesc = {
    Text = "Crit. Rate dan Crit. DMG meningkat sebesar 50%. Pada setiap awal giliran, <FragileIconKeywords:Rapuh> diri sendiri selama 1 giliran."
  },
  RelicConfig_44610_Desc = {
    Text = "Crit. Rate dan Crit. DMG meningkat sebesar 50%. Pada setiap awal giliran, <FragileIconKeywords:Rapuh> diri sendiri selama 1 giliran."
  },
  RelicConfig_44610_Name = {
    Text = "<RedQuality:Rasa Bersalah·Cakar Aneh>"
  },
  RelicConfig_44610_StoryDesc = {
    Text = "Cakar tangan yang terdistorsi oleh Keinginan."
  },
  RelicConfig_44654_BattleDesc = {
    Text = "Meningkatkan aritmetika maksimum sebesar 4, dan setiap kali dek kartu direset, tambahkan 4 kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam tumpukan menggambar."
  },
  RelicConfig_44654_Desc = {
    Text = "Meningkatkan aritmetika maksimum sebesar 4, dan setiap kali dek kartu direset, tambahkan 4 kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam tumpukan menggambar."
  },
  RelicConfig_44654_Name = {
    Text = "<OrangeQuality:Terberkati·Lilin hitam>"
  },
  RelicConfig_44654_StoryDesc = {
    Text = "Membakar keinginan, mendapatkan penebusan."
  },
  RelicConfig_44656_BattleDesc = {
    Text = "Batas maksimum Relik +[Arg1], jumlah pembaruan di \"D-marka\"+1. Setelah Pertempuran berakhir, dapatkan 125 Segil hitam, saat mengambil bisa memilih untuk menghapus hingga 6 Kartu gejala."
  },
  RelicConfig_44656_Desc = {
    Text = "Batas maksimum Relik +[Arg1], jumlah pembaruan di \"D-marka\"+1. Setelah Pertempuran berakhir, dapatkan 125 Segil hitam, saat mengambil bisa memilih untuk menghapus hingga 6 Kartu gejala."
  },
  RelicConfig_44656_Name = {
    Text = "<OrangeQuality: Diberkati · Tiruan Giok>"
  },
  RelicConfig_44656_StoryDesc = {
    Text = "Penebusan dari Sang Pencipta menghapus rasa sakit."
  },
  RelicConfig_44658_BattleDesc = {
    Text = "Setelah melepaskan Muliakan, dapatkan [Arg1] poin kekuatan sementara, dan curi dari semua musuh [Arg1] poin kekuatan sementara <PowerIconKeywords:Kekuatan>, jika hanya ada 1 musuh, curi tambahan [Arg2] poin kekuatan sementara <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_44658_Desc = {
    Text = "Setelah melepaskan Muliakan, dapatkan [Arg1] poin kekuatan sementara, dan curi dari semua musuh [Arg1] poin kekuatan sementara <PowerIconKeywords:Kekuatan>, jika hanya ada 1 musuh, curi tambahan [Arg2] poin kekuatan sementara <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_44658_Name = {
    Text = "<OrangeQuality:Terberkati·Burung Ritual Nasib Buruk>"
  },
  RelicConfig_44658_StoryDesc = {
    Text = "Cahaya pengampunan menyelimuti sisa-sisa keserakahan, burung yang telah mati akhirnya dapat menyanyikan lagu terakhirnya."
  },
  RelicConfig_44659_BattleDesc = {
    Text = "Setiap kali memberikan 1 kerusakan aktif, pulihkan [Arg1] Hidup, dan berikan [Arg2] lapisan <BleedingIconKeywords:Berdarah> pada target kerusakan."
  },
  RelicConfig_44659_Desc = {
    Text = "Setiap kali memberikan 1 kerusakan aktif, pulihkan [Arg1] Hidup, dan berikan [Arg2] lapisan <BleedingIconKeywords:Berdarah> pada target kerusakan."
  },
  RelicConfig_44659_Name = {
    Text = "<OrangeQuality: Diberkati · Kesadaran Kumpulan Serangga>"
  },
  RelicConfig_44659_StoryDesc = {
    Text = "Jalinan, simbiosis, berkelompok; bersatu, koeksistensi, perlindungan."
  },
  RelicConfig_44660_BattleDesc = {
    Text = "Batas kartu tangan meningkat 5, isi ulang kartu tangan hingga batas saat pertempuran dimulai. Saat giliran dimulai, tarik 1 kartu tambahan, dan buang semua Kartu gejala dan Kartu negara di tangan saat giliran berakhir, simpan kartu lainnya."
  },
  RelicConfig_44660_Desc = {
    Text = "Batas kartu tangan meningkat 5, isi ulang kartu tangan hingga batas saat pertempuran dimulai. Saat giliran dimulai, tarik 1 kartu tambahan, dan buang semua Kartu gejala dan Kartu negara di tangan saat giliran berakhir, simpan kartu lainnya."
  },
  RelicConfig_44660_Name = {
    Text = "<OrangeQuality: Diberkati·Ukiran Kesadaran>"
  },
  RelicConfig_44660_StoryDesc = {
    Text = "Orang yang serakah mengukir kesalahan mereka di dalam hati dan sepenuhnya menebus dosa-dosa masa lalunya."
  },
  RelicConfig_44662_BattleDesc = {
    Text = "Setiap 2 putaran, kerusakan aktif dan tentakel yang diterima oleh semua musuh menjadi dua kali lipat. Dalam putaran ini, setiap kali melepaskan 1 Muliakan, secara acak menghilangkan 1 jenis status negatif."
  },
  RelicConfig_44662_Desc = {
    Text = "Setiap 2 putaran, kerusakan aktif dan tentakel yang diterima oleh semua musuh menjadi dua kali lipat. Dalam putaran ini, setiap kali melepaskan 1 Muliakan, secara acak menghilangkan 1 jenis status negatif."
  },
  RelicConfig_44662_Name = {
    Text = "<OrangeQuality:Terberkati·Rangka Penyelamatan>"
  },
  RelicConfig_44662_StoryDesc = {
    Text = [[
Sebagian dari yang suci. 
 Meskipun terpisah dari tubuh utama, jejaknya telah menyebar ke seluruh penjuru dunia.]]
  },
  RelicConfig_44663_BattleDesc = {
    Text = "Crit. Rate meningkat sebesar 50%, Crit. DMG meningkat sebesar 100%."
  },
  RelicConfig_44663_Desc = {
    Text = "Crit. Rate meningkat sebesar 50%, Crit. DMG meningkat sebesar 100%."
  },
  RelicConfig_44663_Name = {
    Text = "<OrangeQuality:Terberkati·Cakar Aneh>"
  },
  RelicConfig_44663_StoryDesc = {
    Text = "Semua keinginan telah dilepaskan."
  },
  RelicConfig_44664_BattleDesc = {
    Text = "Setelah diambil, dapatkan secara permanen [Arg1] <PowerIconKeywords:Kekuatan>. Setiap kali memberikan kerusakan, pulihkan [Arg2] poin hidup, maksimal 6 kali per putaran."
  },
  RelicConfig_44664_Desc = {
    Text = "Setelah diambil, dapatkan secara permanen [Arg1] <PowerIconKeywords:Kekuatan>. Setiap kali memberikan kerusakan, pulihkan [Arg2] poin hidup, maksimal 6 kali per putaran."
  },
  RelicConfig_44664_Name = {
    Text = "<OrangeQuality:Terberkati·Ciuman Lamprey>"
  },
  RelicConfig_44664_StoryDesc = {
    Text = "Tolak ciuman yang tenggelam ini, pelukan Bapa lebih hangat daripada segala kegelapan."
  },
  RelicConfig_47444_BattleDesc = {
    Text = "\"Serangan\" dan \"Pertahanan\" mendapatkan tambahan 50 poin Energi-s. Setiap kali kamu memainkan 1 Kartu dengan Lelah Aritmetika sebesar 2 atau lebih, tarik 1 Kartu dengan Lelah Aritmetika sebesar 1 dan ubah Lelah Aritmetikanya menjadi 0. Efek ini dapat bekerja maksimal 3 kali per ronde."
  },
  RelicConfig_47444_Desc = {
    Text = "\"Serangan\" dan \"Pertahanan\" mendapatkan tambahan 50 poin Energi-s. Setiap kali kamu memainkan 1 Kartu dengan Lelah Aritmetika sebesar 2 atau lebih, tarik 1 Kartu dengan Lelah Aritmetika sebesar 1 dan ubah Lelah Aritmetikanya menjadi 0. Efek ini dapat bekerja maksimal 3 kali per ronde."
  },
  RelicConfig_47444_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Kembar\">"
  },
  RelicConfig_50338_BattleDesc = {
    Text = "Pada awal pertempuran, semua kartu <ExaltIconKeywords:Membangkitkan> dari Pembangun akan dikocok ke dalam dek. Setelah ronde ke-6 dimulai, Thais akan memberikan dukungan pertempuran setiap ronde."
  },
  RelicConfig_50338_Desc = {
    Text = "Pada awal pertempuran, semua kartu <ExaltIconKeywords:Membangkitkan> dari Pembangun akan dikocok ke dalam dek. Setelah ronde ke-6 dimulai, Thais akan memberikan dukungan pertempuran setiap ronde."
  },
  RelicConfig_50338_Name = {
    Text = "<OrangeQuality:Pendulum waktu \"Tersesat dalam Cinta\">"
  },
  RelicConfig_50338_StoryDesc = {
    Text = "Dia berkata, \"Jangan takut.\""
  },
  RelicConfig_50385_BattleDesc = {
    Text = "Setelah mengambil, pilih satu Kartu untuk membuat konsumsi Lelah Aritmetikanya berubah secara permanen menjadi 1."
  },
  RelicConfig_50385_Desc = {
    Text = "Setelah mengambil, pilih satu Kartu untuk membuat konsumsi Lelah Aritmetikanya berubah secara permanen menjadi 1."
  },
  RelicConfig_50385_Name = {
    Text = "<WhiteQuality:☆Murid yang Kehabisan☆>"
  },
  RelicConfig_50385_StoryDesc = {
    Text = "Kehilangan air yang paling berharga di gurun, pupil matanya telah mengering."
  },
  RelicConfig_50487_BattleDesc = {
    Text = "Pada awal ronde pertama Pertempuran, tambahkan <DerivativeCardKeywords_46:\"Prion\"> ke tangan; pada ronde ke-3, tambahkan <DerivativeCardKeywords_49:\"Serangan kerakusan\"> ke tangan; setelah memicu Ketahanan, tambahkan <DerivativeCardKeywords_52:\"Kepompong kebangkitan\"> ke tangan."
  },
  RelicConfig_50487_Desc = {
    Text = "Pada awal ronde pertama Pertempuran, tambahkan <DerivativeCardKeywords_46:\"Prion\"> ke tangan; pada ronde ke-3, tambahkan <DerivativeCardKeywords_49:\"Serangan kerakusan\"> ke tangan; setelah memicu Ketahanan, tambahkan <DerivativeCardKeywords_52:\"Kepompong kebangkitan\"> ke tangan."
  },
  RelicConfig_50487_Name = {
    Text = "<OrangeQuality: Pendulum waktu \"Berkat\">"
  },
  RelicConfig_50488_BattleDesc = {
    Text = "Pada akhir ronde: Pembangun dengan Aliemus terendah mendapatkan 35 poin Aliemus. Jika sisa Hidup ≥ 50％, mendapatkan [Arg1] poin <PowerIconKeywords:Kekuatan>. Jika sisa Hidup < 50％, pulihkan [Arg2] poin Hidup."
  },
  RelicConfig_50488_Desc = {
    Text = "Pada akhir ronde: Pembangun dengan Aliemus terendah mendapatkan 35 poin Aliemus. Jika Hidup saat ini tidak kurang dari 50%, dapatkan [Arg1] poin <PowerIconKeywords:Kekuatan>. Jika Hidup saat ini kurang dari 50%, pulihkan [Arg2] poin Hidup."
  },
  RelicConfig_50488_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Seimbang\">"
  },
  RelicConfig_50489_BattleDesc = {
    Text = "Crit. Rate, Crit. DMG meningkat 100%. Setiap kali memberikan 1 Kerusakan, Crit. Rate dan Crit. DMG semua Pembangun berkurang 10%, hingga maksimal 50%. Setiap kali memberikan 1 Kerusakan, Racun dan Counter yang diberikan pada giliran ini meningkat 10%, hingga maksimal 50%."
  },
  RelicConfig_50489_Desc = {
    Text = "Crit. Rate dan Crit. DMG meningkat 100%. Setiap kali memberikan 1 Kerusakan/Kerusakan tentakel, pada giliran ini: Crit. Rate dan Crit. DMG semua Awakener berkurang 10%, hingga maksimal 50%. Racun dan Counter yang diberikan meningkat 10%, hingga maksimal 50%."
  },
  RelicConfig_50489_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Pindah dan Meluap\">"
  },
  RelicConfig_51686_BattleDesc = {
    Text = "Setiap kali memainkan kartu perintah yang berbeda dari Pembangun sebelumnya, Pembangun tersebut mendapatkan 3 poin Aliemus dan mengumpulkan 1 lapisan \"Aktivitas\". Saat mengumpulkan 10 lapisan, semua \"Aktivitas\" akan dihapus, dan satu kartu perintah acak dengan pengurangan konsumsi Aritmetika sebesar 1 dari setiap Pembangun akan dimasukkan ke tangan, serta memiliki atribut \"Lelah\". Efek ini hanya dapat diaktifkan maksimal 1 kali per ronde."
  },
  RelicConfig_51686_Desc = {
    Text = "Setiap kali memainkan kartu perintah yang berbeda dari Pembangun sebelumnya, Pembangun tersebut mendapatkan 3 poin Aliemus dan mengumpulkan 1 lapisan \"Aktivitas\". Saat mengumpulkan 10 lapisan, semua \"Aktivitas\" akan dihapus, dan satu kartu perintah acak dengan pengurangan konsumsi Aritmetika sebesar 1 dari setiap Pembangun akan dimasukkan ke tangan, serta memiliki atribut \"Lelah\". Efek ini hanya dapat diaktifkan maksimal 1 kali per ronde."
  },
  RelicConfig_51686_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Evolusi\">"
  },
  RelicConfig_51687_BattleDesc = {
    Text = "Setelah memainkan kartu perintah selain \"Serangan\"dan \"Pertahanan\", jika kartu ini bukan kartu turunan, Pembangun yang sesuai mendapatkan 15 poin Aliemus. Maksimal dipicu 5 kali per ronde. Saat pertama kali dipicu dalam satu ronde, kartu yang dimainkan akan dikembalikan ke tangan."
  },
  RelicConfig_51687_Desc = {
    Text = "Setelah memainkan kartu perintah selain \"Serangan\" dan \"Pertahanan\", jika kartu ini bukan kartu turunan, Pembangun yang sesuai mendapatkan 15 poin Aliemus. Maksimal dipicu 5 kali per ronde. Saat pertama kali dipicu dalam satu ronde, kartu yang dimainkan akan dikembalikan ke tangan."
  },
  RelicConfig_51687_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Proyeksi\">"
  },
  RelicConfig_51688_BattleDesc = {
    Text = "Saat mengambil, tambahkan \"Simpan\" pada semua kartu perintah. Pada akhir giliran, jika jumlah kartu di tangan lebih dari atau sama dengan 5, secara acak 3 kartu biaya aritmetika berkurang 1, jika tidak, gambar 3 kartu."
  },
  RelicConfig_51688_Desc = {
    Text = "Saat mengambil, tambahkan \"Simpan\" pada semua kartu perintah. Pada akhir giliran, jika jumlah kartu di tangan lebih dari atau sama dengan 5, secara acak 3 kartu biaya aritmetika berkurang 1, jika tidak, gambar 3 kartu."
  },
  RelicConfig_51688_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Tempat Tidur Hangat\">"
  },
  RelicConfig_51689_BattleDesc = {
    Text = "Pada awal pertempuran, masukkan 3 kartu gejala acak ke dalam dek. Pada awal giliran, tarik 1 kartu. Setiap kali memainkan 1 kartu gejala, dapatkan 2 poin aritmetika. Setiap kali membuang 1 kartu gejala, semua Pembangun mendapatkan 5 poin Aliemus, dengan maksimum akumulasi 5 kali per giliran."
  },
  RelicConfig_51689_Desc = {
    Text = "Pada awal pertempuran, masukkan 3 kartu gejala acak ke dalam dek. Pada awal giliran, tarik 1 kartu. Setiap kali memainkan 1 kartu gejala, dapatkan 2 poin aritmetika. Setiap kali membuang 1 kartu gejala, semua Pembangun mendapatkan 5 poin Aliemus, dengan maksimum akumulasi 5 kali per giliran."
  },
  RelicConfig_51689_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Wabah\">"
  },
  RelicConfig_55847_BattleDesc = {
    Text = "Set Standar Pertempuran Simulasi 7 Relik"
  },
  RelicConfig_55847_Desc = {
    Text = "Set Standar Pertempuran Simulasi 7 Relik"
  },
  RelicConfig_55847_Name = {
    Text = "<RedQuality:☆Relik☆>"
  },
  RelicConfig_55847_StoryDesc = {
    Text = [[
Di era yang aneh, bunga adalah penonton pertama bagi manusia.
Jangan bergerak, mereka lebih menyukai objek pameran yang tenang.]]
  },
  RelicConfig_55874_BattleDesc = {
    Text = "Setelah pertempuran selesai, dapatkan [Arg1] lapisan \"Pena dan Tinta\", saat \"Pena dan Tinta\" mencapai 2 lapisan akan menjadi lelah, secara acak letakkan 1 kartu \"Gambaran\" ke dalam dek."
  },
  RelicConfig_55874_Desc = {
    Text = "Setelah pertempuran selesai, dapatkan [Arg1] lapisan \"Pena dan Tinta\", saat \"Pena dan Tinta\" mencapai 2 lapisan akan menjadi lelah, secara acak letakkan 1 kartu \"Gambaran\" ke dalam dek."
  },
  RelicConfig_55874_Name = {
    Text = "<OrangeQuality:Horla's Pen and Ink>"
  },
  RelicConfig_55874_StoryDesc = {
    Text = "Dosa kuno terukir di sini."
  },
  RelicConfig_56355_BattleDesc = {
    Text = "Batas kartu tangan +2, saat giliran dimulai, tarik 1 kartu. Setelah Pertempuran berakhir, dapatkan [Arg1] tingkat \"Tinta\", setelah \"Tinta\" mencapai 2 tingkat akan Lelah, pilih untuk menempatkan 1 kartu \"Gambaran\" ke dalam dek."
  },
  RelicConfig_56355_Desc = {
    Text = "Batas kartu tangan +2, saat giliran dimulai, tarik 1 kartu. Setelah Pertempuran berakhir, dapatkan [Arg1] tingkat \"Tinta\", setelah \"Tinta\" mencapai 2 tingkat akan Lelah, pilih untuk menempatkan 1 kartu \"Gambaran\" ke dalam dek."
  },
  RelicConfig_56355_Name = {
    Text = "<OrangeQuality:Horla's Pen and Ink>"
  },
  RelicConfig_56355_StoryDesc = {
    Text = "Dosa kuno terukir di sini."
  },
  RelicConfig_56356_BattleDesc = {
    Text = "Setelah pertempuran berakhir, dapatkan [Arg1] lapisan \"Pena dan Tinta\". \"Pena dan Tinta\" akan terkonsumsi saat mencapai 2 lapisan, pilih untuk menempatkan 1 kartu \"Imaji\" ke dalam dek."
  },
  RelicConfig_56356_Desc = {
    Text = "Setelah pertempuran berakhir, dapatkan [Arg1] lapisan \"Pena dan Tinta\". \"Pena dan Tinta\" akan terkonsumsi saat mencapai 2 lapisan, pilih untuk menempatkan 1 kartu \"Imaji\" ke dalam dek."
  },
  RelicConfig_56356_Name = {
    Text = "<OrangeQuality:Horla's Pen and Ink>"
  },
  RelicConfig_56356_StoryDesc = {
    Text = "Dosa kuno terukir di sini."
  },
  RelicConfig_57667_BattleDesc = {
    Text = "Awalnya memiliki 2 lapisan Kekuatan Ibu Suci, setelah putaran ketiga, pada awal setiap putaran dapat memilih untuk menggunakan Kekuatan Ibu Suci untuk mendapatkan efek yang berbeda atau memulihkan Kekuatan Ibu Suci. Jika menerima kerusakan fatal, akan bangkit kembali dan menghabiskan semua Kekuatan Ibu Suci, setiap lapisan memulihkan 10% HP, hanya dapat berlaku 1 kali."
  },
  RelicConfig_57667_Desc = {
    Text = "Awalnya memiliki 2 lapisan Kekuatan Ibu Suci, setelah putaran ketiga, setiap awal putaran dapat memilih untuk menggunakan Kekuatan Ibu Suci untuk mendapatkan efek berbeda atau memulihkan Kekuatan Ibu Suci. Jika menerima kerusakan fatal, maka akan bangkit kembali dan menghabiskan semua Kekuatan Ibu Suci, memulihkan 10% HP per lapisan, hanya dapat berlaku 1 kali."
  },
  RelicConfig_57667_Name = {
    Text = "<OrangeQuality: Perlindungan Sang Ibu Ilahi>"
  },
  RelicConfig_57732_BattleDesc = {
    Text = "Meningkatkan Crit. Rate semua Pembangun sebesar 15%. Meningkatkan hasil akhir efek acak Ryker dan Dadu sebesar 1."
  },
  RelicConfig_57732_Desc = {
    Text = "Meningkatkan Crit. Rate semua Pembangun sebesar 15%. Meningkatkan hasil akhir efek acak Ryker dan Dadu sebesar 1."
  },
  RelicConfig_57732_Name = {
    Text = "<OrangeQuality: Mantel Angin Keberuntungan Kualitas Tinggi>"
  },
  RelicConfig_57732_StoryDesc = {
    Text = "Ia akan mendirikan penghalang tebal, menghalangi angin, hujan, dan nasib buruk di luar."
  },
  RelicConfig_57733_BattleDesc = {
    Text = "Pada awal ronde dan ketika efek acak Ryker atau dadu dipicu, dapatkan 100 Energi-s dan 4% Crit. DMG, hingga maksimal 50% Crit. DMG, yang akan dihapus saat Pertempuran berakhir."
  },
  RelicConfig_57733_Desc = {
    Text = "Pada awal ronde dan ketika efek acak Ryker atau dadu dipicu, dapatkan 100 Energi-s dan 4% Crit. DMG, hingga maksimal 50% Crit. DMG, yang akan dihapus saat Pertempuran berakhir."
  },
  RelicConfig_57733_Name = {
    Text = "<OrangeQuality:Tombol Mulut Besar yang Elegan>"
  },
  RelicConfig_57733_StoryDesc = {
    Text = [[
Kancing Mulut Besar menyukai segala hal yang bulat, seperti bulan, keping, dan bola mata segar.
Akan memuntahkan kabut hitam saat bulan purnama, penyebabnya tidak diketahui.]]
  },
  RelicConfig_57734_BattleDesc = {
    Text = "Setiap kali Geng dilepaskan, letakkan 1 \"Dadu Sisi Bercahaya\" di tangan."
  },
  RelicConfig_57734_Desc = {
    Text = "Setiap kali Geng dilepaskan, letakkan 1 \"Dadu Sisi Bercahaya\" di tangan."
  },
  RelicConfig_57734_Name = {
    Text = "<OrangeQuality:Dadu Bercahaya>"
  },
  RelicConfig_57734_StoryDesc = {
    Text = [[
Yang berkilau bukan hanya penampilannya, tetapi juga hati yang tangguh dan pantang menyerah.
Tatap ia lebih dari lima detik, dan kamu akan mengundang @2.]]
  },
  RelicConfig_57735_BattleDesc = {
    Text = "Pada awal ronde dan ketika efek acak Ryker atau dadu terpicu, dapatkan 50 Energi-s dan 2% Crit. DMG, hingga maksimal 30% Crit. DMG. Efek ini akan dihilangkan saat Pertempuran berakhir."
  },
  RelicConfig_57735_Desc = {
    Text = "Pada awal ronde dan ketika efek acak Ryker atau dadu terpicu, dapatkan 50 Energi-s dan 2% Crit. DMG, hingga maksimal 30% Crit. DMG. Efek ini akan dihilangkan saat Pertempuran berakhir."
  },
  RelicConfig_57735_Name = {
    Text = "<OrangeQuality:Tombol Mulut Besar>"
  },
  RelicConfig_57735_StoryDesc = {
    Text = [[
Kancing Mulut Besar menyukai segala hal yang bulat, seperti bulan, keping, dan bola mata segar.
Akan memuntahkan kabut hitam saat bulan purnama, penyebabnya tidak diketahui.]]
  },
  RelicConfig_57736_BattleDesc = {
    Text = "Setiap kali Geng dilepaskan, letakkan 1 \"Dadu Pianfang\" di tangan."
  },
  RelicConfig_57736_Desc = {
    Text = "Setiap kali Geng dilepaskan, letakkan 1 \"Dadu Pianfang\" di tangan."
  },
  RelicConfig_57736_Name = {
    Text = "<OrangeQuality:Dadu Aneh>"
  },
  RelicConfig_57736_StoryDesc = {
    Text = [[
Yang berkilau bukan hanya penampilannya, tetapi juga hati yang tangguh dan pantang menyerah.
Tatap ia lebih dari lima detik, dan kamu akan mengundang @2.]]
  },
  RelicConfig_57737_BattleDesc = {
    Text = "Meningkatkan Crit. Rate semua Pembangun sebesar 10%. Efek acak dari semua Ryker dan dadu tidak akan menampilkan nilai minimum."
  },
  RelicConfig_57737_Desc = {
    Text = "Meningkatkan Crit. Rate semua Pembangun sebesar 10%. Efek acak dari semua Ryker dan dadu tidak akan menampilkan nilai minimum."
  },
  RelicConfig_57737_Name = {
    Text = "<OrangeQuality:Jas Keberuntungan>"
  },
  RelicConfig_57737_StoryDesc = {
    Text = "Ia akan mendirikan penghalang tebal, menghalangi angin, hujan, dan nasib buruk di luar."
  },
  RelicConfig_57791_BattleDesc = {
    Text = "Batas maksimum Relik +1. Selama lima ronde pertama setelah Pertempuran dimulai, pada awal setiap ronde akan diperoleh satu Relik, yaitu \"Broche Ruby, Kalsedon Berlilit, Sinyal Darurat, Burung Ritual Malapetaka, Pendulum Waktu·Tertarik\"."
  },
  RelicConfig_57791_Desc = {
    Text = "Batas maksimum Relik +1. Selama lima ronde pertama setelah Pertempuran dimulai, pada awal setiap ronde akan diperoleh satu Relik, yaitu \"Broche Ruby, Kalsedon Berlilit, Sinyal Darurat, Burung Ritual Malapetaka, Pendulum Waktu·Tertarik\"."
  },
  RelicConfig_57791_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Harta Karun Kapal Tenggelam\">"
  },
  RelicConfig_57791_StoryDesc = {
    Text = "Dikatakan bahwa Lemuria jatuh di perairan ini. Siapa yang bisa menahan diri untuk tidak menyelidiki rahasia harta karun kapal yang tenggelam?"
  },
  RelicConfig_57792_BattleDesc = {
    Text = "Batas maksimal Relik +1. Selama lima ronde pertama setelah Pertempuran dimulai, pada awal setiap ronde akan diperoleh satu Relik, dari antara \"Trisula, Penjepit Prangko Asing, Catatan Arkana, Pahatan Kesadaran, Pendulum waktu·Akumulasi\"."
  },
  RelicConfig_57792_Desc = {
    Text = "Batas maksimal Relik +1. Selama lima ronde pertama setelah Pertempuran dimulai, pada awal setiap ronde akan diperoleh satu Relik, dari antara \"Trisula, Penjepit Prangko Asing, Catatan Arkana, Pahatan Kesadaran, Pendulum waktu·Akumulasi\"."
  },
  RelicConfig_57792_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Harta Karun Kapal Tenggelam\">"
  },
  RelicConfig_57792_StoryDesc = {
    Text = "Dikatakan bahwa Lemuria jatuh di perairan ini. Siapa yang bisa menahan diri untuk tidak menyelidiki rahasia harta karun kapal yang tenggelam?"
  },
  RelicConfig_57793_BattleDesc = {
    Text = "Batas maksimum Relik +1. Selama lima ronde pertama setelah Pertempuran dimulai, pada awal setiap ronde, akan diperoleh satu Relik, di antaranya terdapat \"Rahang Laser, Salep Mencurigakan, Mesin Jahit Berdebu, Lidah Alien, Pendulum Waktu·Pergeseran\"."
  },
  RelicConfig_57793_Desc = {
    Text = "Batas maksimum Relik +1. Selama lima ronde pertama setelah Pertempuran dimulai, pada awal setiap ronde, akan diperoleh satu Relik, di antaranya terdapat \"Rahang Laser, Salep Mencurigakan, Mesin Jahit Berdebu, Lidah Alien, Pendulum Waktu·Pergeseran\"."
  },
  RelicConfig_57793_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Harta Karun Kapal Tenggelam\">"
  },
  RelicConfig_57793_StoryDesc = {
    Text = "Dikatakan bahwa Lemuria jatuh di perairan ini. Siapa yang bisa menahan diri untuk tidak menyelidiki rahasia harta karun kapal yang tenggelam?"
  },
  RelicConfig_57794_BattleDesc = {
    Text = "Batas maksimum Relik +1. Selama lima ronde pertama setelah Pertempuran dimulai, pada awal setiap ronde akan diperoleh satu Relik, dari \"Rompi Urtika, Jam Saku Mendiang, Fragmen Prajurit Terdahulu, Anggota Bantuan, Pendulum Waktu·Menyebar\"."
  },
  RelicConfig_57794_Desc = {
    Text = "Batas maksimum Relik +1. Selama lima ronde pertama setelah Pertempuran dimulai, pada awal setiap ronde akan diperoleh satu Relik, dari \"Rompi Urtika, Jam Saku Mendiang, Fragmen Prajurit Terdahulu, Anggota Bantuan, Pendulum Waktu·Menyebar\"."
  },
  RelicConfig_57794_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Harta Karun Kapal Tenggelam\">"
  },
  RelicConfig_57794_StoryDesc = {
    Text = "Dikatakan bahwa Lemuria jatuh di perairan ini. Siapa yang bisa menahan diri untuk tidak menyelidiki rahasia harta karun kapal yang tenggelam?"
  },
  RelicConfig_57795_BattleDesc = {
    Text = "Batas maksimum Relik +1. Selama lima ronde pertama setelah Pertempuran dimulai, pada awal setiap ronde akan diperoleh sebuah Relik, dari \"Lancet Karat, Klem Hemostatik, Puzzle Tua, Kesadaran Kawanan, Pendulum Waktu·Kembar\"."
  },
  RelicConfig_57795_Desc = {
    Text = "Batas maksimum Relik +1. Selama lima ronde pertama setelah Pertempuran dimulai, pada awal setiap ronde akan diperoleh sebuah Relik, dari \"Lancet Karat, Klem Hemostatik, Puzzle Tua, Kesadaran Kawanan, Pendulum Waktu·Kembar\"."
  },
  RelicConfig_57795_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Harta Karun Kapal Tenggelam\">"
  },
  RelicConfig_57795_StoryDesc = {
    Text = "Dikatakan bahwa Lemuria jatuh di perairan ini. Siapa yang bisa menahan diri untuk tidak menyelidiki rahasia harta karun kapal yang tenggelam?"
  },
  RelicConfig_57796_BattleDesc = {
    Text = "Batas maksimum Relik +1. Selama lima ronde pertama setelah Pertempuran dimulai, pada awal setiap ronde akan diperoleh satu Relik, di antaranya terdapat \"Timer Presisi, Manset Daun Laurel, Jilbab Dewa Tanpa Nama, Manifestasi Mimpi Buruk, Pendulum Waktu·Keseimbangan\"."
  },
  RelicConfig_57796_Desc = {
    Text = "Batas maksimum Relik +1. Selama lima ronde pertama setelah Pertempuran dimulai, pada awal setiap ronde akan diperoleh satu Relik, di antaranya terdapat \"Timer Presisi, Manset Daun Laurel, Jilbab Dewa Tanpa Nama, Manifestasi Mimpi Buruk, Pendulum Waktu·Keseimbangan\"."
  },
  RelicConfig_57796_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Harta Karun Kapal Tenggelam\">"
  },
  RelicConfig_57796_StoryDesc = {
    Text = "Dikatakan bahwa Lemuria jatuh di perairan ini. Siapa yang bisa menahan diri untuk tidak menyelidiki rahasia harta karun kapal yang tenggelam?"
  },
  RelicConfig_57797_BattleDesc = {
    Text = "Batas maksimum Relik +1. Selama lima ronde pertama setelah pertempuran dimulai, pada awal setiap ronde akan diperoleh satu Relik, yaitu \"Dompet Baru, Emblem Mythag, Anggur Bintang, Ciuman Hito, Pendulum Waktu·Mata\"."
  },
  RelicConfig_57797_Desc = {
    Text = "Batas maksimum Relik +1. Selama lima ronde pertama setelah pertempuran dimulai, pada awal setiap ronde akan diperoleh satu Relik, yaitu \"Dompet Baru, Emblem Mythag, Anggur Bintang, Ciuman Hito, Pendulum Waktu·Mata\"."
  },
  RelicConfig_57797_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Harta Karun Kapal Tenggelam\">"
  },
  RelicConfig_57797_StoryDesc = {
    Text = "Dikatakan bahwa Lemuria jatuh di perairan ini. Siapa yang bisa menahan diri untuk tidak menyelidiki rahasia harta karun kapal yang tenggelam?"
  },
  RelicConfig_58872_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangunkan semua pembangun. Selama 5 ronde berikutnya, pada awal setiap ronde, kamu akan memperoleh sebuah relik, yaitu \"Lancet Karat, Poros Baru, Rumah Kita, Cakar Aneh, Pendulum Waktu·Tertarik\"."
  },
  RelicConfig_58872_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangunkan semua pembangun. Selama 5 ronde berikutnya, pada awal setiap ronde, kamu akan memperoleh sebuah relik, yaitu \"Lancet Karat, Poros Baru, Rumah Kita, Cakar Aneh, Pendulum Waktu·Tertarik\"."
  },
  RelicConfig_58872_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Harta Karun α\">"
  },
  RelicConfig_58873_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Selama 5 ronde berikutnya, pada awal setiap ronde akan diperoleh sebuah relik, yaitu \"Tinta Manis, Pemutar Suara Mati, Anggur Bintang, Topi Ajaib, Pendulum Waktu·Pergeseran Gelombang\"."
  },
  RelicConfig_58873_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Selama 5 ronde berikutnya, pada awal setiap ronde akan diperoleh sebuah relik, yaitu \"Tinta Manis, Pemutar Suara Mati, Anggur Bintang, Topi Ajaib, Pendulum Waktu·Pergeseran Gelombang\"."
  },
  RelicConfig_58873_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Harta Karun β\">"
  },
  RelicConfig_59118_BattleDesc = {
    Text = "Setelah ronde dimulai, dapatkan 1 \"Dadu Keberuntungan Ryker\", angka dadu yang dilempar +1. Saat ronde dimulai dan setiap kali setelah melempar dadu, semua Pembangun mendapatkan 4% Kerusakan Kritis, hingga maksimal 100%."
  },
  RelicConfig_59118_Desc = {
    Text = "Setelah ronde dimulai, dapatkan 1 \"Dadu Keberuntungan Ryker\", angka dadu yang dilempar +1. Saat ronde dimulai dan setiap kali setelah melempar dadu, semua Pembangun mendapatkan 4% Kerusakan Kritis, hingga maksimal 100%."
  },
  RelicConfig_59118_Name = {
    Text = "<OrangeQuality:Pendulum waktu \"Kekacauan Pemberian\">"
  },
  RelicConfig_59118_StoryDesc = {
    Text = "Dosa kuno terukir di sini."
  },
  RelicConfig_59687_BattleDesc = {
    Text = "Set Standar Pertempuran Simulasi 7 Relik"
  },
  RelicConfig_59687_Desc = {
    Text = "Set Standar Pertempuran Simulasi 7 Relik"
  },
  RelicConfig_59687_Name = {
    Text = "<RedQuality:☆Relik☆>"
  },
  RelicConfig_59687_StoryDesc = {
    Text = [[
Di era yang aneh, bunga adalah penonton pertama bagi manusia.
Jangan bergerak, mereka lebih menyukai objek pameran yang tenang.]]
  },
  RelicConfig_60723_BattleDesc = {
    Text = "Meningkatkan Aritmetika maksimal sebesar 1, menarik 1 kartu tambahan di awal putaran, dan mendapatkan 1 kartu \"Simfoni Harmoni\". Jika Aritmetika dari 3 Kartu Perintah yang dimainkan secara berturut-turut sama, semua Pembangun mendapatkan 20 poin Aliemus. Hitungan akan direset di awal putaran dan setelah efek dipicu."
  },
  RelicConfig_60723_Desc = {
    Text = "Meningkatkan Aritmetika maksimal sebesar 1, menarik 1 kartu tambahan di awal putaran, dan mendapatkan 1 kartu \"Simfoni Harmoni\". Jika Aritmetika dari 3 Kartu Perintah yang dimainkan secara berturut-turut sama, semua Pembangun mendapatkan 20 poin Aliemus. Hitungan akan direset di awal putaran dan setelah efek dipicu."
  },
  RelicConfig_60723_Name = {
    Text = "<OrangeQuality: Tongkat Komando Orkestra>"
  },
  RelicConfig_60723_StoryDesc = {
    Text = [[
Tongkat konduktor yang ramping, namun memiliki kekuatan lebih besar daripada linggis. 
Mengarahkan notasi, mengarahkan jiwa, mengarahkan takdir.]]
  },
  RelicConfig_60724_BattleDesc = {
    Text = "Pada awal pertempuran, pemain akan memperoleh orison \"Rentan\"dan orison \"Ledakan\"serta orison tingkat lanjutnya. Pilih orison pada kartu."
  },
  RelicConfig_60724_Desc = {
    Text = "Pada awal pertempuran, pemain akan memperoleh orison \"Rentan\"dan orison \"Ledakan\"serta orison tingkat lanjutnya. Pilih orison pada kartu."
  },
  RelicConfig_60724_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Pesan Kepala Sekolah\">"
  },
  RelicConfig_60724_StoryDesc = {
    Text = [[
Pesan dari pendiri Mythag terngiang di telinga Anda. 
Semoga Kunci Perak membimbing jalan ke depan, Penjaga Mythag.]]
  },
  RelicConfig_60725_BattleDesc = {
    Text = "Pada awal pertempuran, akan memperoleh \"Orison Aliemus\" dan \"Orison Katalis\" serta orison tingkat lanjut mereka. Pilih orison pada kartu."
  },
  RelicConfig_60725_Desc = {
    Text = "Pada awal pertempuran, akan memperoleh \"Orison Aliemus\" dan \"Orison Katalis\" serta orison tingkat lanjut mereka. Pilih orison pada kartu."
  },
  RelicConfig_60725_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Pesan Kepala Sekolah\">"
  },
  RelicConfig_60725_StoryDesc = {
    Text = [[
Pesan dari pendiri Mythag terngiang di telinga Anda. 
Semoga Kunci Perak membimbing jalan ke depan, Penjaga Mythag.]]
  },
  RelicConfig_60726_BattleDesc = {
    Text = "Pada awal pertempuran, pemain akan memperoleh orison \"Kelemahan\", orison \"Perhitungan\", serta orison tingkat lanjutnya. Pilih orison untuk ditempatkan pada kartu."
  },
  RelicConfig_60726_Desc = {
    Text = "Pada awal pertempuran, pemain akan memperoleh orison \"Kelemahan\", orison \"Perhitungan\", serta orison tingkat lanjutnya. Pilih orison untuk ditempatkan pada kartu."
  },
  RelicConfig_60726_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Pesan Kepala Sekolah\">"
  },
  RelicConfig_60726_StoryDesc = {
    Text = [[
Pesan dari pendiri Mythag terngiang di telinga Anda. 
Semoga Kunci Perak membimbing jalan ke depan, Penjaga Mythag.]]
  },
  RelicConfig_60727_BattleDesc = {
    Text = "Pada awal pertempuran, pemain akan memperoleh orison \"Benteng Besi\" dan orison \"Tangan Ajaib\" serta orison tingkat lanjut mereka. Pilih orison untuk ditempatkan pada kartu."
  },
  RelicConfig_60727_Desc = {
    Text = "Pada awal pertempuran, pemain akan memperoleh orison \"Benteng Besi\" dan orison \"Tangan Ajaib\" serta orison tingkat lanjut mereka. Pilih orison untuk ditempatkan pada kartu."
  },
  RelicConfig_60727_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Pesan Kepala Sekolah\">"
  },
  RelicConfig_60727_StoryDesc = {
    Text = [[
Pesan dari pendiri Mythag terngiang di telinga Anda. 
Semoga Kunci Perak membimbing jalan ke depan, Penjaga Mythag.]]
  },
  RelicConfig_60728_BattleDesc = {
    Text = "Pada awal pertempuran, kamu akan memperoleh orison \"Mengandung\"dan orison \"Gema\"serta orison tingkat lanjut mereka. Pilih orison untuk ditempatkan di kartu."
  },
  RelicConfig_60728_Desc = {
    Text = "Pada awal pertempuran, kamu akan memperoleh orison \"Mengandung\"dan orison \"Gema\"serta orison tingkat lanjut mereka. Pilih orison untuk ditempatkan di kartu."
  },
  RelicConfig_60728_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Pesan Kepala Sekolah\">"
  },
  RelicConfig_60728_StoryDesc = {
    Text = [[
Pesan dari pendiri Mythag terngiang di telinga Anda. 
Semoga Kunci Perak membimbing jalan ke depan, Penjaga Mythag.]]
  },
  RelicConfig_60729_BattleDesc = {
    Text = "Pada awal pertempuran, kamu akan memperoleh orison \"Tangan Ajaib\" dan orison \"Inspirasi\" serta orison tingkat lanjut mereka. Pilih orison untuk ditempatkan di kartu."
  },
  RelicConfig_60729_Desc = {
    Text = "Pada awal pertempuran, kamu akan memperoleh orison \"Tangan Ajaib\" dan orison \"Inspirasi\" serta orison tingkat lanjut mereka. Pilih orison untuk ditempatkan di kartu."
  },
  RelicConfig_60729_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Pesan Kepala Sekolah\">"
  },
  RelicConfig_60729_StoryDesc = {
    Text = [[
Pesan dari pendiri Mythag terngiang di telinga Anda. 
Semoga Kunci Perak membimbing jalan ke depan, Penjaga Mythag.]]
  },
  RelicConfig_60730_BattleDesc = {
    Text = "Pada awal pertempuran, kamu akan memperoleh orison \"Kekuatan Brutal\" dan orison \"Kelelahan\" serta orison tingkat lanjut mereka. Pilih orison untuk ditempatkan di kartu."
  },
  RelicConfig_60730_Desc = {
    Text = "Pada awal pertempuran, kamu akan memperoleh orison \"Kekuatan Brutal\" dan orison \"Kelelahan\" serta orison tingkat lanjut mereka. Pilih orison untuk ditempatkan di kartu."
  },
  RelicConfig_60730_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Pesan Kepala Sekolah\">"
  },
  RelicConfig_60730_StoryDesc = {
    Text = [[
Pesan dari pendiri Mythag terngiang di telinga Anda. 
Semoga Kunci Perak membimbing jalan ke depan, Penjaga Mythag.]]
  },
  RelicConfig_60731_BattleDesc = {
    Text = "Pada awal pertempuran, kamu akan memperoleh 2 \"Ensemble\" Orison serta Orison tingkat lanjutnya, pilih Orison pada Kartu."
  },
  RelicConfig_60731_Desc = {
    Text = "Pada awal pertempuran, kamu akan memperoleh 2 \"Ensemble\" Orison serta Orison tingkat lanjutnya, pilih Orison pada Kartu."
  },
  RelicConfig_60731_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Pesan Kepala Sekolah\">"
  },
  RelicConfig_60731_StoryDesc = {
    Text = [[
Pesan dari pendiri Mythag terngiang di telinga Anda. 
Semoga Kunci Perak membimbing jalan ke depan, Penjaga Mythag.]]
  },
  RelicConfig_60732_BattleDesc = {
    Text = "Pada awal pertempuran, kamu akan memperoleh orison \"Perhitungan\" dan orison \"Cermin\" serta orison tingkat lanjut mereka. Pilih orison pada kartu."
  },
  RelicConfig_60732_Desc = {
    Text = "Pada awal pertempuran, kamu akan memperoleh orison \"Perhitungan\" dan orison \"Cermin\" serta orison tingkat lanjut mereka. Pilih orison pada kartu."
  },
  RelicConfig_60732_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Pesan Kepala Sekolah\">"
  },
  RelicConfig_60732_StoryDesc = {
    Text = [[
Pesan dari pendiri Mythag terngiang di telinga Anda. 
Semoga Kunci Perak membimbing jalan ke depan, Penjaga Mythag.]]
  },
  RelicConfig_65376_BattleDesc = {
    Text = "Dimulai dengan [Arg1] anggota tim penelitian. Saat Pertempuran dimulai, masukkan 5 kartu <DerivativeCardKeywords_73:Kecurigaan> ke dalam tumpukan kartu."
  },
  RelicConfig_65376_Desc = {
    Text = "Dimulai dengan [Arg1] anggota tim penelitian. Saat Pertempuran dimulai, masukkan 5 kartu <DerivativeCardKeywords_73:Kecurigaan> ke dalam tumpukan kartu."
  },
  RelicConfig_65376_Name = {
    Text = "<OrangeQuality:Ekspedisi Ilmiah>"
  },
  RelicConfig_65376_StoryDesc = {
    Text = [[
Pesan dari pendiri Mythag terngiang di telinga Anda. 
Semoga Kunci Perak membimbing jalan ke depan, Penjaga Mythag.]]
  },
  RelicConfig_65406_BattleDesc = {
    Text = [[
Pada awal ronde, dapatkan [Arg1] kartu <DerivativeCardKeywords_71:"Cahaya Kemanusiaan yang Bercahaya">.
<D05EX_Relic:Semua usaha Anda tidak sia-sia. Anda hampir berhasil menyelamatkan seluruh tim penelitian, dan orang-orang yang selamat sangat berterima kasih kepada Anda.>]]
  },
  RelicConfig_65406_Desc = {
    Text = [[
Pada awal ronde, dapatkan [Arg1] kartu <DerivativeCardKeywords_71:"Cahaya Kemanusiaan yang Bercahaya">.
<D05EX_Relic:Semua usaha Anda tidak sia-sia. Anda hampir berhasil menyelamatkan seluruh tim penelitian, dan orang-orang yang selamat sangat berterima kasih kepada Anda.>]]
  },
  RelicConfig_65406_Name = {
    Text = "<OrangeQuality:Medali Penyelamat·Platinum>"
  },
  RelicConfig_65406_StoryDesc = {
    Text = "Semua usahamu sangat berharga. Kamu hampir berhasil menyelamatkan seluruh tim ekspedisi, dan orang-orang yang selamat sangat berterima kasih kepadamu."
  },
  RelicConfig_65407_BattleDesc = {
    Text = [[
Pada awal ronde, dapatkan [Arg1] kartu <DerivativeCardKeywords_72:"Cahaya Kemanusiaan yang Gemerlap">. 
 <D05EX_Relic:Kamu telah menciptakan keajaiban yang luar biasa. Semua orang selamat setelah bencana. Kamu adalah pahlawan besar di hati orang-orang. Legenda tentangmu mungkin akan tersebar di sekitar Gunung Salju.>]]
  },
  RelicConfig_65407_Desc = {
    Text = [[
Pada awal ronde, dapatkan [Arg1] kartu <DerivativeCardKeywords_72:"Cahaya Kemanusiaan yang Gemerlap">. 
 <D05EX_Relic:Kamu telah menciptakan keajaiban yang luar biasa. Semua orang selamat setelah bencana. Kamu adalah pahlawan besar di hati orang-orang. Legenda tentangmu mungkin akan tersebar di sekitar Gunung Salju.>]]
  },
  RelicConfig_65407_Name = {
    Text = "<OrangeQuality:Medali Penyelamat·Berlian>"
  },
  RelicConfig_65407_StoryDesc = {
    Text = "Kamu telah menciptakan keajaiban yang luar biasa. Semua orang selamat setelah bencana, dan kamu adalah pahlawan besar di hati masyarakat. Legenda tentangmu mungkin akan beredar di sekitar Gunung Salju."
  },
  RelicConfig_65408_BattleDesc = {
    Text = [[
Pada awal ronde, dapatkan [Arg1] kartu <DerivativeCardKeywords_68:"Cahaya Kemanusiaan yang Pudar">. 
 <D05EX_Relic:Untuk keluar dari gunung salju, kamu memilih strategi prioritas efisiensi dan mengamati orang-orang mati satu per satu. Pandangan para penyintas terhadapmu lebih dipenuhi oleh rasa takut daripada rasa terima kasih.>]]
  },
  RelicConfig_65408_Desc = {
    Text = [[
Pada awal ronde, dapatkan [Arg1] kartu <DerivativeCardKeywords_68:"Cahaya Kemanusiaan yang Pudar">. 
 <D05EX_Relic:Untuk keluar dari gunung salju, kamu memilih strategi prioritas efisiensi dan mengamati orang-orang mati satu per satu. Pandangan para penyintas terhadapmu lebih dipenuhi oleh rasa takut daripada rasa terima kasih.>]]
  },
  RelicConfig_65408_Name = {
    Text = "<OrangeQuality:Medali Penyelamat·Perunggu>"
  },
  RelicConfig_65408_StoryDesc = {
    Text = "Untuk keluar dari Gunung Salju, kamu memilih strategi prioritas efisiensi dan menyaksikan orang-orang mati satu per satu. Pandangan para penyintas terhadapmu lebih dipenuhi oleh rasa takut daripada rasa terima kasih."
  },
  RelicConfig_65409_BattleDesc = {
    Text = [[
Di awal ronde, dapatkan [Arg1] kartu <DerivativeCardKeywords_69:"Cahaya Kemanusiaan yang Redup">.
<D05EX_Relic:Mungkin kamu sudah berusaha keras, meskipun separuh dari mereka meninggal. Setidaknya kamu menyelamatkan separuh lainnya, karena pengorbanan memang tak terhindarkan.>]]
  },
  RelicConfig_65409_Desc = {
    Text = [[
Di awal ronde, dapatkan [Arg1] kartu <DerivativeCardKeywords_69:"Cahaya Kemanusiaan yang Redup">.
<D05EX_Relic:Mungkin kamu sudah berusaha keras, meskipun separuh dari mereka meninggal. Setidaknya kamu menyelamatkan separuh lainnya, karena pengorbanan memang tak terhindarkan.>]]
  },
  RelicConfig_65409_Name = {
    Text = "<OrangeQuality:Medali Penyelamat·Perak>"
  },
  RelicConfig_65409_StoryDesc = {
    Text = "Mungkin kamu sudah berusaha keras. Meskipun separuh dari mereka meninggal, setidaknya kamu berhasil menyelamatkan separuh lainnya. Lagipula, pengorbanan memang tak terhindarkan."
  },
  RelicConfig_65410_BattleDesc = {
    Text = [[
Pada awal giliran, dapatkan [Arg1] kartu <DerivativeCardKeywords_70:"Cahaya Kemanusiaan">. 
 <D05EX_Relic:Kamu telah menyelamatkan sebagian besar orang, mengubah takdir tragis mereka. Kamu sudah berusaha semaksimal mungkin, bukan?>]]
  },
  RelicConfig_65410_Desc = {
    Text = [[
Pada awal giliran, dapatkan [Arg1] kartu <DerivativeCardKeywords_70:"Cahaya Kemanusiaan">. 
 <D05EX_Relic:Kamu telah menyelamatkan sebagian besar orang, mengubah takdir tragis mereka. Kamu sudah berusaha semaksimal mungkin, bukan?>]]
  },
  RelicConfig_65410_Name = {
    Text = "<OrangeQuality:Medali Penyelamat·Emas>"
  },
  RelicConfig_65410_StoryDesc = {
    Text = "Kamu telah menyelamatkan sebagian besar orang, mengubah takdir tragis mereka. Kamu sudah melakukan yang terbaik, bukan?"
  },
  RelicConfig_65456_BattleDesc = {
    Text = [[
Pada awal pertempuran, shuffle 3 kartu gejala acak, dapatkan [Arg1] poin Kekuatan saat memainkan kartu gejala. 
<D05EX_Relic:Dengan bantuanmu, tidak ada yang selamat dari Tim Penelitian, dan kamu dengan acuh tak acuh mencari keuntungan maksimal untuk dirimu sendiri, tetapi apakah semua ini benar-benar sepadan?>]]
  },
  RelicConfig_65456_Desc = {
    Text = [[
Pada awal pertempuran, shuffle 3 kartu gejala acak, dapatkan [Arg1] poin Kekuatan saat memainkan kartu gejala. 
<D05EX_Relic:Dengan bantuanmu, tidak ada yang selamat dari Tim Penelitian, dan kamu dengan acuh tak acuh mencari keuntungan maksimal untuk dirimu sendiri, tetapi apakah semua ini benar-benar sepadan?>]]
  },
  RelicConfig_65456_Name = {
    Text = "<OrangeQuality:Lambang Penyendiri>"
  },
  RelicConfig_65456_StoryDesc = {
    Text = "Berkat bantuanmu, tidak ada anggota tim penelitian yang selamat. Kamu berhasil mendapatkan keuntungan terbesar untuk dirimu sendiri, tetapi apakah semua ini benar-benar sepadan?"
  },
  RelicConfig_65569_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Selama 5 putaran berikutnya, setiap awal putaran akan memperoleh sebuah relik, termasuk \"Peralatan Komunikasi, Pesta Musim Semi, Tongkat Pendeta, Burung Ritual Malapetaka, Pendulum Waktu·Proyeksi\"."
  },
  RelicConfig_65569_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Selama 5 putaran berikutnya, setiap awal putaran akan memperoleh sebuah relik, termasuk \"Peralatan Komunikasi, Pesta Musim Semi, Tongkat Pendeta, Burung Ritual Malapetaka, Pendulum Waktu·Proyeksi\"."
  },
  RelicConfig_65569_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Harta Karun δ\">"
  },
  RelicConfig_65570_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Selama 5 putaran berikutnya, setiap awal putaran akan mendapatkan sebuah relik: \"Emblem Mythag, Koper Dokter, Baterai Prototipe, Ukiran Kesadaran, Pendulum Waktu·Evolusi\"."
  },
  RelicConfig_65570_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Selama 5 putaran berikutnya, setiap awal putaran akan mendapatkan sebuah relik: \"Emblem Mythag, Koper Dokter, Baterai Prototipe, Ukiran Kesadaran, Pendulum Waktu·Evolusi\"."
  },
  RelicConfig_65570_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Harta Karun γ\">"
  },
  RelicConfig_66515_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangunkan semua pembangun. Selama 5 putaran berikutnya, pada awal setiap putaran, akan memperoleh sebuah relik, yaitu \"Koran Pagi Putney, Prinsip Estetika, Lagu Kaum Rakyat, Wajah Cacat, Pendulum Waktu·Pergi Pulang\"."
  },
  RelicConfig_66515_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangunkan semua pembangun. Selama 5 putaran berikutnya, pada awal setiap putaran, akan memperoleh sebuah relik, yaitu \"Koran Pagi Putney, Prinsip Estetika, Lagu Kaum Rakyat, Wajah Cacat, Pendulum Waktu·Pergi Pulang\"."
  },
  RelicConfig_66515_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Harta Karun ε\">"
  },
  RelicConfig_66518_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran ganjil, temukan sebuah relik, total lima kali penemuan."
  },
  RelicConfig_66518_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran ganjil, temukan sebuah relik, total lima kali penemuan."
  },
  RelicConfig_66518_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Doa β\">"
  },
  RelicConfig_66519_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran ganjil, temukan sebuah relik, total lima kali penemuan."
  },
  RelicConfig_66519_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran ganjil, temukan sebuah relik, total lima kali penemuan."
  },
  RelicConfig_66519_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Doa α\">"
  },
  RelicConfig_67690_BattleDesc = {
    Text = "Pada awal setiap putaran, semua Pembangun mendapatkan 25 Aliemus. Saat diambil, Kesehatan maksimum menjadi 1,5 kali lipat."
  },
  RelicConfig_67690_Desc = {
    Text = "Pada awal setiap putaran, semua Pembangun mendapatkan 25 Aliemus. Saat diambil, Kesehatan maksimum menjadi 1,5 kali lipat."
  },
  RelicConfig_67690_Name = {
    Text = "<OrangeQuality:Terberkati·Manifestasi Mimpi Buruk β>"
  },
  RelicConfig_67690_StoryDesc = {
    Text = "Tak perlu takut, tak perlu ragu. Ini hanyalah mimpi sesaat, cahaya Sang Pencipta masih menyinari dirimu."
  },
  RelicConfig_67788_BattleDesc = {
    Text = "Saat diambil, dapatkan 3 poin Aritmetika."
  },
  RelicConfig_67788_Desc = {
    Text = "Saat diambil, dapatkan 3 poin Aritmetika."
  },
  RelicConfig_67788_Name = {
    Text = "<WhiteQuality:Cermin jam saku>"
  },
  RelicConfig_67788_StoryDesc = {
    Text = "Memori membeku di waktu yang telah berlalu, terkubur dalam kegelapan."
  },
  RelicConfig_67789_BattleDesc = {
    Text = "Saat diambil, letakkan 1 kartu <DerivativeCardKeywords_1:\"Gema Bayangan Terlupakan\"> ke tangan."
  },
  RelicConfig_67789_Desc = {
    Text = "Saat diambil, letakkan 1 kartu <DerivativeCardKeywords_1:\"Gema Bayangan Terlupakan\"> ke tangan."
  },
  RelicConfig_67789_Name = {
    Text = "<WhiteQuality:Perangkat Komunikasi>"
  },
  RelicConfig_67789_StoryDesc = {
    Text = "Menantikan atau takut akan saat lonceng itu berbunyi dengan suara yang nyaring."
  },
  RelicConfig_67790_BattleDesc = {
    Text = "Semua kerusakan kritis yang disebabkan oleh \"pukulan\" meningkat sebesar 20%. Saat diambil, tambahkan 1 kartu <DerivativeCardKeywords_40:\"Momen Indah\"> ke tangan."
  },
  RelicConfig_67790_Desc = {
    Text = "Semua kerusakan kritis yang disebabkan oleh \"pukulan\" meningkat sebesar 20%. Saat diambil, tambahkan 1 kartu <DerivativeCardKeywords_40:\"Momen Indah\"> ke tangan."
  },
  RelicConfig_67790_Name = {
    Text = "<WhiteQuality:Momen Indah>"
  },
  RelicConfig_67790_StoryDesc = {
    Text = "Menyimpan keindahan sesaat untuk selamanya."
  },
  RelicConfig_67791_BattleDesc = {
    Text = "Saat diambil, semua musuh akan diberikan 1 ronde <WeaknessIconKeywords:Kelemahan> dan <VulnerabilityIconKeywords:Rentan>."
  },
  RelicConfig_67791_Desc = {
    Text = "Saat diambil, semua musuh akan diberikan 1 ronde <WeaknessIconKeywords:Kelemahan> dan <VulnerabilityIconKeywords:Rentan>."
  },
  RelicConfig_67791_Name = {
    Text = "<WhiteQuality:Seragam Restraint yang Berubah Warna>"
  },
  RelicConfig_67791_StoryDesc = {
    Text = "Bukan hanya waktu yang dapat mengubah warna kain, ketakutan dan penderitaan pun bisa."
  },
  RelicConfig_67793_BattleDesc = {
    Text = "Pada awal pertempuran, semua Pembangun mendapatkan 50 poin Aliemus. Tempatkan 2 kartu <DerivativeCardKeywords_1:\"Gema Bayangan Terlupakan\"> di tangan."
  },
  RelicConfig_67793_Desc = {
    Text = "Saat diambil, semua Pembangun mendapatkan 50 poin Aliemus, dan 2 kartu <DerivativeCardKeywords_1:\"Gema Bayangan Terlupakan\"> dimasukkan ke tangan."
  },
  RelicConfig_67793_Name = {
    Text = "<OrangeQuality:Perangkat Komunikasi+β>"
  },
  RelicConfig_67793_StoryDesc = {
    Text = "Menantikan atau takut akan saat lonceng itu berbunyi dengan suara yang nyaring."
  },
  RelicConfig_67794_BattleDesc = {
    Text = "Batas kartu tangan meningkat 5, isi ulang kartu tangan hingga batas saat pertempuran dimulai. Saat giliran dimulai, tarik 1 kartu tambahan, dan buang semua Kartu gejala dan Kartu negara di tangan saat giliran berakhir, simpan kartu lainnya."
  },
  RelicConfig_67794_Desc = {
    Text = "Batas kartu tangan meningkat 5, isi ulang kartu tangan hingga batas saat pertempuran dimulai. Saat giliran dimulai, tarik 1 kartu tambahan, dan buang semua Kartu gejala dan Kartu negara di tangan saat giliran berakhir, simpan kartu lainnya."
  },
  RelicConfig_67794_Name = {
    Text = "<OrangeQuality:Terberkati·Pengukiran Kesadaran β>"
  },
  RelicConfig_67794_StoryDesc = {
    Text = "Orang yang serakah mengukir kesalahan mereka di dalam hati dan sepenuhnya menebus dosa-dosa masa lalunya."
  },
  RelicConfig_67818_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran, temukan secara acak satu \"relik\" atau \"dukungan\", total ditemukan lima kali."
  },
  RelicConfig_67818_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran, temukan secara acak satu \"relik\" atau \"dukungan\", total ditemukan lima kali."
  },
  RelicConfig_67818_Name = {
    Text = "<OrangeQuality:\"Pintu Sepuluh Ribu Duniaε\">"
  },
  RelicConfig_67819_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran, temukan secara acak satu \"relik\" atau \"dukungan\", total ditemukan lima kali."
  },
  RelicConfig_67819_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran, temukan secara acak satu \"relik\" atau \"dukungan\", total ditemukan lima kali."
  },
  RelicConfig_67819_Name = {
    Text = "<OrangeQuality:\"Pintu ζ\">"
  },
  RelicConfig_67820_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran, temukan secara acak satu \"relik\" atau \"dukungan\", total ditemukan lima kali."
  },
  RelicConfig_67820_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran, temukan secara acak satu \"relik\" atau \"dukungan\", total ditemukan lima kali."
  },
  RelicConfig_67820_Name = {
    Text = "<OrangeQuality:\"Pintu θ\">"
  },
  RelicConfig_67821_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran, temukan secara acak satu \"relik\" atau \"dukungan\", total ditemukan lima kali."
  },
  RelicConfig_67821_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran, temukan secara acak satu \"relik\" atau \"dukungan\", total ditemukan lima kali."
  },
  RelicConfig_67821_Name = {
    Text = "<OrangeQuality:\"Pintu γ\">"
  },
  RelicConfig_67822_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran, temukan secara acak satu \"relik\" atau \"dukungan\", total ditemukan lima kali."
  },
  RelicConfig_67822_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran, temukan secara acak satu \"relik\" atau \"dukungan\", total ditemukan lima kali."
  },
  RelicConfig_67822_Name = {
    Text = "<OrangeQuality:\"Pintu Myriade Duniaα\">"
  },
  RelicConfig_67823_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran, temukan secara acak satu \"relik\" atau \"dukungan\", total ditemukan lima kali."
  },
  RelicConfig_67823_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran, temukan secara acak satu \"relik\" atau \"dukungan\", total ditemukan lima kali."
  },
  RelicConfig_67823_Name = {
    Text = "<OrangeQuality:\"Pintuη\">"
  },
  RelicConfig_67824_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran, temukan secara acak satu \"relik\" atau \"dukungan\", total ditemukan lima kali."
  },
  RelicConfig_67824_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran, temukan secara acak satu \"relik\" atau \"dukungan\", total ditemukan lima kali."
  },
  RelicConfig_67824_Name = {
    Text = "<OrangeQuality:\"Pintuδ\">"
  },
  RelicConfig_67825_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran, temukan secara acak satu \"relik\" atau \"dukungan\", total ditemukan lima kali."
  },
  RelicConfig_67825_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran, temukan secara acak satu \"relik\" atau \"dukungan\", total ditemukan lima kali."
  },
  RelicConfig_67825_Name = {
    Text = "<OrangeQuality:\"Pintu Sepuluh Ribu Duniaβ\">"
  },
  RelicConfig_67826_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran, temukan secara acak satu \"relik\" atau \"dukungan\", total ditemukan lima kali."
  },
  RelicConfig_67826_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran, temukan secara acak satu \"relik\" atau \"dukungan\", total ditemukan lima kali."
  },
  RelicConfig_67826_Name = {
    Text = "<OrangeQuality:\"Pintuι\">"
  },
  RelicConfig_68651_BattleDesc = {
    Text = "Pada awal pertempuran, bangunkan semua Pembangun, letakkan <DerivativeCardKeywords_84:\"Kilauan Kenangan - Patung Lilin Tak Selesai\"> ke dalam tangan, salin semua Kartu dari tumpukan menggambar. Setiap ronde, gambar 5 Kartu tambahan dan dapatkan 5 poin Aritmetika. Setelah memainkan \"Serangan\" atau \"Pertahanan\", dapatkan [Arg1] poin Perisai."
  },
  RelicConfig_68651_Desc = {
    Text = "Pada awal pertempuran, bangunkan semua Pembangun, letakkan <DerivativeCardKeywords_84:\"Kilauan Kenangan - Patung Lilin Tak Selesai\"> ke dalam tangan, salin semua Kartu dari tumpukan menggambar. Setiap ronde, gambar 5 Kartu tambahan dan dapatkan 5 poin Aritmetika. Setelah memainkan \"Serangan\" atau \"Pertahanan\", dapatkan [Arg1] poin Perisai."
  },
  RelicConfig_68651_Name = {
    Text = "<OrangeQuality:\"Inti Perak Murni· Ketakutan\">"
  },
  RelicConfig_68652_BattleDesc = {
    Text = "Saat pertempuran dimulai, bangkitkan semua Pembangun, tempatkan<DerivativeCardKeywords_85:\"Kenangan Cahaya-Hati yang menyimpang\"> ke dalam tangan. Pada awal giliran, dapat memilih Kartu mana saja untuk dibuang, gambar jumlah yang sama. Pada giliran ganjil, mendapatkan [Arg1] poin Kekuatan sementara, menempatkan\"<DerivativeCardKeywords_97:Niat Tak Terhinggaβ\"> ke dalam tangan. Pada giliran genap, mendapatkan [Arg2] poin Menjaga sementara, menempatkan<DerivativeCardKeywords_98:\"Bersembunyiβ\"> ke dalam tangan"
  },
  RelicConfig_68652_Desc = {
    Text = "Saat pertempuran dimulai, bangkitkan semua Pembangun, tempatkan<DerivativeCardKeywords_85:\"Kenangan Cahaya-Hati yang menyimpang\"> ke dalam tangan. Pada awal giliran, dapat memilih Kartu mana saja untuk dibuang, gambar jumlah yang sama. Pada giliran ganjil, mendapatkan [Arg1] poin Kekuatan sementara, menempatkan\"<DerivativeCardKeywords_97:Niat Tak Terhinggaβ\"> ke dalam tangan. Pada giliran genap, mendapatkan [Arg2] poin Menjaga sementara, menempatkan<DerivativeCardKeywords_98:\"Bersembunyiβ\"> ke dalam tangan"
  },
  RelicConfig_68652_Name = {
    Text = "<OrangeQuality:\"Inti Perak Murni· Menggigit Dingin\">"
  },
  RelicConfig_68653_BattleDesc = {
    Text = "Saat pertempuran dimulai, bangkitkan semua Pembangun, tempatkan<DerivativeCardKeywords_83:\"Kenangan Cahaya-Hadiah yang polos\"> ke dalam tangan. Semua Pembangun dapat melepaskan 1 kali Aliemus tambahan setiap giliran, setelah melepaskan Aliemus, mengurangi kekuatan musuh sebanyak [Arg2] poin. Pada awal giliran, semua Pembangun mendapatkan [Arg1] poin Aliemus"
  },
  RelicConfig_68653_Desc = {
    Text = "Saat pertempuran dimulai, bangkitkan semua Pembangun, tempatkan<DerivativeCardKeywords_83:\"Kenangan Cahaya-Hadiah yang polos\"> ke dalam tangan. Semua Pembangun dapat melepaskan 1 kali Aliemus tambahan setiap giliran, setelah melepaskan Aliemus, mengurangi kekuatan musuh sebanyak [Arg2] poin. Pada awal giliran, semua Pembangun mendapatkan [Arg1] poin Aliemus"
  },
  RelicConfig_68653_Name = {
    Text = "<OrangeQuality:\"Inti Perak Murni· Tangisan Sedih\">"
  },
  RelicConfig_68654_BattleDesc = {
    Text = "Pada awal pertempuran, bangunkan semua Pembangun, letakkan <DerivativeCardKeywords_88:\"Kilauan Kenangan - Tirai Utopia\"> ke dalam tangan, batas kartu tim +2, batas penyimpanan Energi-s +100%. Setelah melepaskan Geng, tingkat kritis dan kerusakan kritis semua Pembangun sementara meningkat sebesar [Arg1]%, dapatkan Perisai sebesar 20% dari Kesehatan maksimum, dan menggambar kartu hingga mencapai batas kartu."
  },
  RelicConfig_68654_Desc = {
    Text = "Pada awal pertempuran, bangunkan semua Pembangun, letakkan <DerivativeCardKeywords_88:\"Kilauan Kenangan - Tirai Utopia\"> ke dalam tangan, batas kartu tim +2, batas penyimpanan Energi-s +100%. Setelah melepaskan Geng, tingkat kritis dan kerusakan kritis semua Pembangun sementara meningkat sebesar [Arg1]%, dapatkan Perisai sebesar 20% dari Kesehatan maksimum, dan menggambar kartu hingga mencapai batas kartu."
  },
  RelicConfig_68654_Name = {
    Text = "<OrangeQuality:\"Inti Perak Murni· Kegilaan\">"
  },
  RelicConfig_68655_BattleDesc = {
    Text = "Pada awal pertempuran, bangunkan semua Pembangun dan tempatkan <DerivativeCardKeywords_89:\"Kilauan Kenangan - Inti Kemakmuran\"> di tangan. Saat ronde berakhir, simpan sisa Aritmetika dan tidak membuang kartu di tangan lagi. Setiap kali memberikan 1 Kerusakan aktif, dapatkan [Arg1] Kekuatan sementara dan [Arg2] Perisai."
  },
  RelicConfig_68655_Desc = {
    Text = "Pada awal pertempuran, bangunkan semua Pembangun dan tempatkan <DerivativeCardKeywords_89:\"Kilauan Kenangan - Inti Kemakmuran\"> di tangan. Saat ronde berakhir, simpan sisa Aritmetika dan tidak membuang kartu di tangan lagi. Setiap kali memberikan 1 Kerusakan aktif, dapatkan [Arg1] Kekuatan sementara dan [Arg2] Perisai."
  },
  RelicConfig_68655_Name = {
    Text = "<OrangeQuality:\"Inti Perak Murni· Kedatangan\">"
  },
  RelicConfig_68656_BattleDesc = {
    Text = "Pada awal pertempuran, bangunkan semua Pembangun, letakkan <DerivativeCardKeywords_86:\"Cahaya Kenangan - Madu Manis\"> di tangan, kerusakan kritis semua Pembangun menjadi 1,5 kali lipat. Pada akhir ronde, jika Pembangun tidak melepaskan Muliakan, mereka mendapatkan [Arg1] poin Aliemus. Jika jumlah Kartu yang dimainkan kurang dari [Arg2], undi 2 Kartu di ronde berikutnya dan dapatkan 2 poin Aritmetika."
  },
  RelicConfig_68656_Desc = {
    Text = "Pada awal pertempuran, bangunkan semua Pembangun, letakkan <DerivativeCardKeywords_86:\"Cahaya Kenangan - Madu Manis\"> di tangan, kerusakan kritis semua Pembangun menjadi 1,5 kali lipat. Pada akhir ronde, jika Pembangun tidak melepaskan Muliakan, mereka mendapatkan [Arg1] poin Aliemus. Jika jumlah Kartu yang dimainkan kurang dari [Arg2], undi 2 Kartu di ronde berikutnya dan dapatkan 2 poin Aritmetika."
  },
  RelicConfig_68656_Name = {
    Text = "<OrangeQuality:\"Inti Perak Murni· Misterius\">"
  },
  RelicConfig_68657_BattleDesc = {
    Text = "Saat pertarungan dimulai, Awaken semua Awakener, masukkan <DerivativeCardKeywords_87:\"Kenangan Cahaya Redup - Hakim Pengganti\"> ke tangan, DMG Amplification tim berlipat ganda. Efek Weakness yang diberikan pemain meningkat dari 25% menjadi 50%, setiap akhir putaran dapatkan Perisai sebesar [Arg1]% dari Max HP dan berikan <FixedDamage:Kerusakan Murni> kepada semua musuh sebesar [Arg2] kali nilai Perisai sendiri."
  },
  RelicConfig_68657_Desc = {
    Text = "Saat pertarungan dimulai, Awaken semua Awakener, masukkan <DerivativeCardKeywords_87:\"Kenangan Cahaya Redup - Hakim Pengganti\"> ke tangan, DMG Amplification tim berlipat ganda. Efek Weakness yang diberikan pemain meningkat dari 25% menjadi 50%, setiap akhir putaran dapatkan Perisai sebesar [Arg1]% dari Max HP dan berikan <FixedDamage:Kerusakan Murni> kepada semua musuh sebesar [Arg2] kali nilai Perisai sendiri."
  },
  RelicConfig_68657_Name = {
    Text = "<OrangeQuality:\"Inti Perak Murni· Iman Jahat\">"
  },
  RelicConfig_68886_BattleDesc = {
    Text = "Kerusakan, penyembuhan, dan perisai yang disebabkan Tawil meningkat 50%. Di awal pertempuran, Tawil menerima 120 poin Aliemus."
  },
  RelicConfig_68886_Desc = {
    Text = "Kerusakan, perisai, dan pemulihan hidup Tawil meningkat sebesar 50%. Saat pertempuran dimulai, Tawil mendapatkan 120 poin Aliemus."
  },
  RelicConfig_68886_Name = {
    Text = "<OrangeQuality:\"Mata Segalanya\">"
  },
  RelicConfig_68886_StoryDesc = {
    Text = "Keluar dari Pintu, Dia melangkah di jalan yang satu-satunya benar."
  },
  RelicConfig_69319_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran ganjil, temukan sebuah relik, total lima kali penemuan."
  },
  RelicConfig_69319_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran ganjil, temukan sebuah relik, total lima kali penemuan."
  },
  RelicConfig_69319_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Doa ε\">"
  },
  RelicConfig_69320_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran ganjil, temukan sebuah relik, total lima kali penemuan."
  },
  RelicConfig_69320_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran ganjil, temukan sebuah relik, total lima kali penemuan."
  },
  RelicConfig_69320_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Doa γ\">"
  },
  RelicConfig_69321_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran ganjil, temukan sebuah relik, total lima kali penemuan."
  },
  RelicConfig_69321_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua pembangun. Pada awal giliran ganjil, temukan sebuah relik, total lima kali penemuan."
  },
  RelicConfig_69321_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Doaδ\">"
  },
  RelicConfig_70042_BattleDesc = {
    Text = "Pada awal giliran, kumpulkan 1 poin \"Energi Sumber Jurang\", pilih \"Tidur Nyenyak\" atau \"Bangun\". Tidur Nyenyak: Kumpulkan tambahan 1 poin \"Energi Sumber Jurang\". Bangun: Lelah 1/5/10 poin \"Energi Sumber Jurang\", dapatkan bantuan dari Tulu. Semakin banyak \"Energi Sumber Jurang\" yang dilelahkan, semakin kuat efek bantuan dari Tulu."
  },
  RelicConfig_70042_Desc = {
    Text = "Pada awal giliran, kumpulkan 1 poin \"Energi Sumber Jurang\", pilih \"Tidur Nyenyak\" atau \"Bangun\". Tidur Nyenyak: Kumpulkan tambahan 1 poin \"Energi Sumber Jurang\". Bangun: Lelah 1/5/10 poin \"Energi Sumber Jurang\", dapatkan bantuan dari Tulu. Semakin banyak \"Energi Sumber Jurang\" yang dilelahkan, semakin kuat efek bantuan dari Tulu."
  },
  RelicConfig_70042_Name = {
    Text = "<OrangeQuality: Kekuasaan Raja Dewa>"
  },
  RelicConfig_70084_BattleDesc = {
    Text = "Pada saat pertempuran dimulai, masukkan semua \"Membangkitkan\" dari pembangun ke dalam tumpukan menggambar."
  },
  RelicConfig_70084_Desc = {
    Text = "Pada saat pertempuran dimulai, masukkan semua \"Membangkitkan\" dari pembangun ke dalam tumpukan menggambar."
  },
  RelicConfig_70084_Name = {
    Text = "<OrangeQuality:Gnosis Membangkitkan>"
  },
  RelicConfig_70700_BattleDesc = {
    Text = "Semua kerusakan dasar yang diberikan oleh Bangun meningkat sebesar [Arg1]%."
  },
  RelicConfig_70700_Desc = {
    Text = "Semua kerusakan dasar yang diberikan oleh Bangun meningkat sebesar [Arg1]%."
  },
  RelicConfig_70700_Name = {
    Text = "<WhiteQuality:Pipa Tangis>"
  },
  RelicConfig_70700_StoryDesc = {
    Text = "Apakah ini produk dari kebencian, atau hasil dari balas dendam?"
  },
  RelicConfig_70701_BattleDesc = {
    Text = "Pada awal ronde, semua Pembangun mendapatkan [Arg1] Aliemus."
  },
  RelicConfig_70701_Desc = {
    Text = "Pada awal ronde, semua Pembangun mendapatkan [Arg1] Aliemus."
  },
  RelicConfig_70701_Name = {
    Text = "<WhiteQuality: Prototipe Baterai>"
  },
  RelicConfig_70701_StoryDesc = {
    Text = "Harapan yang dapat dibawa kemana saja."
  },
  RelicConfig_70702_BattleDesc = {
    Text = "Setelah melepaskan \"Muliakan\", dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_70702_Desc = {
    Text = "Setelah melepaskan \"Muliakan\", dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_70702_Name = {
    Text = "<OrangeQuality:Kunci Berat+>"
  },
  RelicConfig_70702_StoryDesc = {
    Text = [[
Gembok yang tebal dan kokoh, tanpa kunci, sepertinya akan sulit dibuka. 
Tentu saja, bagi pencuri ulung, ini bukan masalah besar.]]
  },
  RelicConfig_70703_BattleDesc = {
    Text = "\"Pukulan\"memberikan kerusakan tambahan sebesar [Arg1]% daya serang Pembangun, dan dapat dipicu hingga 3 kali per ronde."
  },
  RelicConfig_70703_Desc = {
    Text = "\"Pukulan\"memberikan kerusakan tambahan sebesar [Arg1]% daya serang Pembangun, dan dapat dipicu hingga 3 kali per ronde."
  },
  RelicConfig_70703_Name = {
    Text = "<WhiteQuality:Belati Willow Berkarat>"
  },
  RelicConfig_70703_StoryDesc = {
    Text = "Tidak cocok untuk memotong makhluk hidup."
  },
  RelicConfig_70704_BattleDesc = {
    Text = "Setelah menggunakan Bangkit kunci perak, terapkan [Arg1] <IntoxicationIconKeywords:Racun> kepada semua musuh dan dapatkan [Arg2] Energi-s."
  },
  RelicConfig_70704_Desc = {
    Text = "Setelah menggunakan Bangkit kunci perak, terapkan [Arg1] <IntoxicationIconKeywords:Racun> kepada semua musuh dan dapatkan [Arg2] Energi-s."
  },
  RelicConfig_70704_Name = {
    Text = "<OrangeQuality:Salep Mencurigakan+>"
  },
  RelicConfig_70704_StoryDesc = {
    Text = "Semacam salep luka buatan sendiri, mohon jangan digunakan tanpa panduan dokter."
  },
  RelicConfig_70705_BattleDesc = {
    Text = "\"Pukulan\"memberikan [Arg1]% dari <IntoxicationIconKeywords:Racun>, menyebabkan hingga [Arg2] kerusakan setiap putaran."
  },
  RelicConfig_70705_Desc = {
    Text = "\"Pukulan\"memberikan [Arg1]% dari <IntoxicationIconKeywords:Racun>, menyebabkan hingga [Arg2] kerusakan setiap putaran."
  },
  RelicConfig_70705_Name = {
    Text = "<OrangeQuality: Lidah Asing+>"
  },
  RelicConfig_70705_StoryDesc = {
    Text = "Dia bukan iblis, tetapi Dia memang menyampaikan bisikan dari luar dunia manusia."
  },
  RelicConfig_70706_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:Fusi Embrio> Peningkatan perolehan otomatis sebesar [Arg1]%."
  },
  RelicConfig_70706_Desc = {
    Text = "<EmbryoFusionIconKeywords:Fusi Embrio> Peningkatan perolehan otomatis sebesar [Arg1]%."
  },
  RelicConfig_70706_Name = {
    Text = "<WhiteQuality:Catatan Diagnosis Wabah>"
  },
  RelicConfig_70706_StoryDesc = {
    Text = "Wabah —— manifestasi kebetulan dari kegelisahan alam yang tidak disadari."
  },
  RelicConfig_70707_BattleDesc = {
    Text = "Setelah Bangkit Kunci Perak, semua Pembangun memperoleh [Arg1] Aliemus dan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_70707_Desc = {
    Text = "Setelah Bangkit Kunci Perak, semua Pembangun memperoleh [Arg1] Aliemus dan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_70707_Name = {
    Text = "<OrangeQuality:Kancing Lengan Kayu Manis+>"
  },
  RelicConfig_70707_StoryDesc = {
    Text = [[
Kancing manset perak dengan ukiran daun laurel. 
 Dibuat dengan sangat halus, berkilauan, dan pernah menjadi simbol persahabatan dua anak.]]
  },
  RelicConfig_70708_BattleDesc = {
    Text = "Setelah pertempuran dimulai, dapatkan [Arg1] <ProficientInRealmsIconKeywords:Penguasaan Alam>. Semua Pembangun memberikan <IntoxicationIconKeywords:Racun> dan Relik memberikan <IntoxicationIconKeywords:Racun> meningkat sebesar [Arg2]%."
  },
  RelicConfig_70708_Desc = {
    Text = "Setelah pertempuran dimulai, dapatkan [Arg1] <ProficientInRealmsIconKeywords:Penguasaan Alam>. Semua Pembangun memberikan <IntoxicationIconKeywords:Racun> dan Relik memberikan <IntoxicationIconKeywords:Racun> meningkat sebesar [Arg2]%."
  },
  RelicConfig_70708_Name = {
    Text = "<OrangeQuality:Mesin Jahit Berdebu+>"
  },
  RelicConfig_70708_StoryDesc = {
    Text = "Seorang ibu yang penuh kasih, menjahit luka di hati."
  },
  RelicConfig_70709_BattleDesc = {
    Text = "Setelah memasuki ronde Ultra, Kartu perintah non-turunan pertama yang dimainkan akan memiliki efek tambahan sebanyak [Arg1] kali."
  },
  RelicConfig_70709_Desc = {
    Text = "Setelah memasuki ronde Ultra, Kartu perintah non-turunan pertama yang dimainkan akan memiliki efek tambahan sebanyak [Arg1] kali."
  },
  RelicConfig_70709_Name = {
    Text = "<WhiteQuality:Pasir Cahaya redup>"
  },
  RelicConfig_70709_StoryDesc = {
    Text = "Satu unit waktu yang dapat diukur."
  },
  RelicConfig_70711_BattleDesc = {
    Text = "Setelah menggunakan Bangkit kunci perak, dapatkan [Arg1] <RetaliateIconKeywords:Counter> dan [Arg2] Energi-s."
  },
  RelicConfig_70711_Desc = {
    Text = "Setelah menggunakan Bangkit kunci perak, dapatkan [Arg1] <RetaliateIconKeywords:Counter> dan [Arg2] Energi-s."
  },
  RelicConfig_70711_Name = {
    Text = "<OrangeQuality: Pra-bab +>"
  },
  RelicConfig_70711_StoryDesc = {
    Text = "\"Manusia begitu bodoh, hanya karena sesuatu yang kuno, mereka akan percaya secara membabi buta.\""
  },
  RelicConfig_70712_BattleDesc = {
    Text = "Setelah menggunakan Bangkit kunci perak, dapatkan [Arg1] <PowerIconKeywords:Kekuatan> dan [Arg2] Energi-s."
  },
  RelicConfig_70712_Desc = {
    Text = "Setelah menggunakan Bangkit kunci perak, dapatkan [Arg1] <PowerIconKeywords:Kekuatan> dan [Arg2] Energi-s."
  },
  RelicConfig_70712_Name = {
    Text = "<WhiteQuality: Rumah Kita>"
  },
  RelicConfig_70712_StoryDesc = {
    Text = "Mereka bersama sebelumnya, dan mereka akan selalu bersama di masa depan. Mereka adalah keluarga yang penuh kasih sayang."
  },
  RelicConfig_70713_BattleDesc = {
    Text = "Mendapatkan [Arg1]% dari jumlah kehilangan hidup sebagai Dapur Merah saat kehilangan kehidupan."
  },
  RelicConfig_70713_Desc = {
    Text = "Mendapatkan [Arg1]% dari jumlah kehilangan hidup sebagai Dapur Merah saat kehilangan kehidupan."
  },
  RelicConfig_70713_Name = {
    Text = "<WhiteQuality:Gergaji Baja Berkarat>"
  },
  RelicConfig_70713_StoryDesc = {
    Text = "Dokter anatomi seumur hidup tidak pernah melihat wanita cantik, hanya ada karung tulang, saraf yang meradang karena penyakit, otot, dan jaringan."
  },
  RelicConfig_70714_BattleDesc = {
    Text = "Setelah pertempuran dimulai, dapatkan [Arg1] <ProficientInRealmsIconKeywords:Alam Profesional>. Semua Pembangun yang dihidupkan memberikan <RetaliateIconKeywords:Counter> dan Relik yang dibuat meningkatkan <RetaliateIconKeywords:Counter> sebesar [Arg2]%."
  },
  RelicConfig_70714_Desc = {
    Text = "Setelah pertempuran dimulai, dapatkan [Arg1] <ProficientInRealmsIconKeywords:Alam Profesional>. Semua Pembangun yang dihidupkan memberikan <RetaliateIconKeywords:Counter> dan Relik yang dibuat meningkatkan <RetaliateIconKeywords:Counter> sebesar [Arg2]%."
  },
  RelicConfig_70714_Name = {
    Text = "<WhiteQuality:Tanpa Rahasia>"
  },
  RelicConfig_70714_StoryDesc = {
    Text = "Ini menyampaikan tak terhitung banyaknya rahasia yang diucapkan secara aktif maupun pasif."
  },
  RelicConfig_70715_BattleDesc = {
    Text = "Setelah Bangkit Kunci Perak, menarik [Arg1] kartu dan mendapatkan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_70715_Desc = {
    Text = "Setelah Bangkit Kunci Perak, menarik [Arg1] kartu dan mendapatkan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_70715_Name = {
    Text = "<OrangeQuality:Dompet Baru+>"
  },
  RelicConfig_70715_StoryDesc = {
    Text = [[
Dompet kulit dengan lambang Universitas Mythag tercetak di atasnya. 
 Saat ini, dompet itu kosong, tidak ada apa pun di dalamnya.]]
  },
  RelicConfig_70717_BattleDesc = {
    Text = "Pada awal ronde, tarik [Arg1] kartu."
  },
  RelicConfig_70717_Desc = {
    Text = "Pada awal ronde, tarik [Arg1] kartu."
  },
  RelicConfig_70717_Name = {
    Text = "<OrangeQuality: Kompas Terarah +>"
  },
  RelicConfig_70717_StoryDesc = {
    Text = "Yang ditunjukkan bukan arah, melainkan medan magnet."
  },
  RelicConfig_70718_BattleDesc = {
    Text = "Setelah menggunakan \"Exalt\", buat semua musuh menerima [Arg1] poin <FixedDamage:Kerusakan Murni>, dan picu [Arg2]% <IntoxicationIconKeywords:Racun>."
  },
  RelicConfig_70718_Desc = {
    Text = "Setelah menggunakan \"Exalt\", buat semua musuh menerima 1 kali <FixedDamage:Kerusakan Murni> sebesar [Arg2]% dari Max HP pihak kita, dan picu [Arg2]% <IntoxicationIconKeywords:Racun>."
  },
  RelicConfig_70718_Name = {
    Text = "<WhiteQuality:Rahang Laser>"
  },
  RelicConfig_70718_StoryDesc = {
    Text = [[
Tulang yang dipajang di ruang pameran pribadi seorang kolektor. 
 Kolektor tersebut terpesona oleh cahaya fluoresen yang indah, menikmatinya siang dan malam, hingga akhirnya mengering dan mati, menjadi serupa dengan tulang itu sendiri.]]
  },
  RelicConfig_70719_BattleDesc = {
    Text = "Pada awal ronde, semua Pembangun mendapatkan [Arg1] Aliemus."
  },
  RelicConfig_70719_Desc = {
    Text = "Pada awal ronde, semua Pembangun mendapatkan [Arg1] Aliemus."
  },
  RelicConfig_70719_Name = {
    Text = "<OrangeQuality:Prototype Battery+>"
  },
  RelicConfig_70719_StoryDesc = {
    Text = "Harapan yang dapat dibawa kemana saja."
  },
  RelicConfig_70720_BattleDesc = {
    Text = "Pada awal giliran, jika Hidup di bawah 25%, dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_70720_Desc = {
    Text = "Pada awal giliran, jika Hidup di bawah 25%, dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_70720_Name = {
    Text = "<WhiteQuality:Kehormatan Tertinggi>"
  },
  RelicConfig_70720_StoryDesc = {
    Text = [[
Kucing hitam berbulu pendek yang anggun dan misterius, dikatakan di suatu negara padang pasir yang jauh dianggap sebagai manifestasi dari Dewa. Namun, nama Dewa tersebut kini tak seorang pun yang mengetahuinya. 
Dibanggakan, dihormati, dilupakan, mungkin itulah takdir para Dewa.]]
  },
  RelicConfig_70721_BattleDesc = {
    Text = "Setelah melepaskan \"Muliakan\" sebanyak 4 kali dalam satu putaran, dapatkan [Arg1] Aritmetika, dengan cooldown 3 putaran."
  },
  RelicConfig_70721_Desc = {
    Text = "Setelah melepaskan \"Muliakan\" sebanyak 4 kali dalam satu putaran, dapatkan [Arg1] Aritmetika, dengan cooldown 3 putaran."
  },
  RelicConfig_70721_Name = {
    Text = "<WhiteQuality:Mesin Diferensial Perak>"
  },
  RelicConfig_70721_StoryDesc = {
    Text = "\"Itu mengubah sejarah.\""
  },
  RelicConfig_70722_BattleDesc = {
    Text = "Setelah menggunakan Bangkit kunci perak, dapatkan [Arg1] <PowerIconKeywords:Kekuatan> dan [Arg2] Energi-s."
  },
  RelicConfig_70722_Desc = {
    Text = "Setelah menggunakan Bangkit kunci perak, dapatkan [Arg1] <PowerIconKeywords:Kekuatan> dan [Arg2] Energi-s."
  },
  RelicConfig_70722_Name = {
    Text = "<OrangeQuality:Rumah Kami+>"
  },
  RelicConfig_70722_StoryDesc = {
    Text = "Mereka bersama sebelumnya, dan mereka akan selalu bersama di masa depan. Mereka adalah keluarga yang penuh kasih sayang."
  },
  RelicConfig_70723_BattleDesc = {
    Text = "Ketika memainkan 2 Kartu berturut-turut dengan Lelah Aritmetika lebih tinggi dari kartu sebelumnya, dapatkan [Arg1] <RetaliateIconKeywords:Counter>, maksimal terpicu 3 kali per ronde."
  },
  RelicConfig_70723_Desc = {
    Text = "Ketika memainkan 2 Kartu berturut-turut dengan Lelah Aritmetika lebih tinggi dari kartu sebelumnya, dapatkan [Arg1] <RetaliateIconKeywords:Counter>, maksimal terpicu 3 kali per ronde."
  },
  RelicConfig_70723_Name = {
    Text = "<OrangeQuality:Catatan Arkana+>"
  },
  RelicConfig_70723_StoryDesc = {
    Text = "Arah takdir."
  },
  RelicConfig_70724_BattleDesc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1] <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_70724_Desc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1] <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_70724_Name = {
    Text = "<OrangeQuality:Ruby Brooch+>"
  },
  RelicConfig_70724_StoryDesc = {
    Text = "Tampak samar-samar warna merah segar menyeruak keluar."
  },
  RelicConfig_70725_BattleDesc = {
    Text = "Setelah pertempuran dimulai, tambahkan [Arg1] lapisan <WeaknessIconKeywords:Kelemahan> pada semua musuh. Efek pada bos menjadi dua kali lipat. Kerusakan dasar yang diberikan oleh semua Pembangun meningkat sebesar [Arg2]%."
  },
  RelicConfig_70725_Desc = {
    Text = "Setelah pertempuran dimulai, tambahkan [Arg1] lapisan <WeaknessIconKeywords:Kelemahan> pada semua musuh. Efek pada bos menjadi dua kali lipat. Kerusakan dasar yang diberikan oleh semua Pembangun meningkat sebesar [Arg2]%."
  },
  RelicConfig_70725_Name = {
    Text = "<OrangeQuality:Anak Jahat+>"
  },
  RelicConfig_70725_StoryDesc = {
    Text = "Terlahir dari kejahatan murni, meskipun itu bukanlah keinginannya."
  },
  RelicConfig_70726_BattleDesc = {
    Text = "Penghancuran mendapatkan [Arg1] Perisai, cooldown 3 putaran."
  },
  RelicConfig_70726_Desc = {
    Text = "Penghancuran mendapatkan [Arg1] Perisai, cooldown 3 putaran."
  },
  RelicConfig_70726_Name = {
    Text = "<WhiteQuality:Jam Saku Superstring>"
  },
  RelicConfig_70726_StoryDesc = {
    Text = "\"Ah, jam saku berhenti.\""
  },
  RelicConfig_70727_BattleDesc = {
    Text = "Pada akhir ronde, pulihkan [Heal:Arg1] Hidup."
  },
  RelicConfig_70727_Desc = {
    Text = "Pada akhir ronde, pulihkan [Heal:Arg1] Hidup."
  },
  RelicConfig_70727_Name = {
    Text = "<OrangeQuality: Darah Anugerah+>"
  },
  RelicConfig_70727_StoryDesc = {
    Text = "Rasanya manis dan lembut, dengan aroma mawar yang khas."
  },
  RelicConfig_70728_BattleDesc = {
    Text = "Menggunakan postur Laut Tenang untuk membuat semua musuh kehilangan [Arg1] poin <ExhaustionIconKeywords:Kekuatan> sementara. Cooldown 3 ronde."
  },
  RelicConfig_70728_Desc = {
    Text = "Menggunakan postur Laut Tenang untuk membuat semua musuh kehilangan [Arg1] poin <ExhaustionIconKeywords:Kekuatan> sementara. Cooldown 3 ronde."
  },
  RelicConfig_70728_Name = {
    Text = "<OrangeQuality:Anggota Tubuh Tanpa Nama+>"
  },
  RelicConfig_70728_StoryDesc = {
    Text = "Hati-hati, bisa melukai tangan."
  },
  RelicConfig_70730_BattleDesc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1] <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_70730_Desc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1] <PowerIconKeywords:Kekuatan>."
  },
  RelicConfig_70730_Name = {
    Text = "<WhiteQuality:Peniti Ruby>"
  },
  RelicConfig_70730_StoryDesc = {
    Text = "Tampak samar-samar warna merah segar menyeruak keluar."
  },
  RelicConfig_70731_BattleDesc = {
    Text = "Saat menerima serangan musuh, buat musuh menerima [Arg1] poin <FixedDamage:Kerusakan Murni>, kerusakan ini mendapat bonus [Arg2]% <RetaliateIconKeywords:Counter>, maksimal dipicu 1 kali per musuh per putaran."
  },
  RelicConfig_70731_Desc = {
    Text = "Saat menerima serangan musuh, buat musuh menerima <FixedDamage:Kerusakan Murni> sebesar [Arg3]% dari Max HP pihak kita, kerusakan ini mendapat bonus [Arg2]% <RetaliateIconKeywords:Counter>, maksimal dipicu 1 kali per musuh per putaran."
  },
  RelicConfig_70731_Name = {
    Text = "<OrangeQuality: Pisau Ritual yang Terlupakan+>"
  },
  RelicConfig_70731_StoryDesc = {
    Text = "Belati dengan mata pisaunya yang melengkung, sering digunakan dalam ritual pengorbanan."
  },
  RelicConfig_70732_BattleDesc = {
    Text = "Setelah memasuki ronde Ultra, Kartu perintah non-turunan pertama yang dimainkan akan memiliki efek tambahan sebanyak [Arg1] kali."
  },
  RelicConfig_70732_Desc = {
    Text = "Setelah memasuki ronde Ultra, Kartu perintah non-turunan pertama yang dimainkan akan memiliki efek tambahan sebanyak [Arg1] kali."
  },
  RelicConfig_70732_Name = {
    Text = "<OrangeQuality: Cahaya redup Pasir Waktu+>"
  },
  RelicConfig_70732_StoryDesc = {
    Text = "Satu unit waktu yang dapat diukur."
  },
  RelicConfig_70733_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:Fusi Embrio> Peningkatan perolehan otomatis sebesar [Arg1]%."
  },
  RelicConfig_70733_Desc = {
    Text = "<EmbryoFusionIconKeywords:Fusi Embrio> Peningkatan perolehan otomatis sebesar [Arg1]%."
  },
  RelicConfig_70733_Name = {
    Text = "<OrangeQuality:Catatan Diagnosis Wabah+>"
  },
  RelicConfig_70733_StoryDesc = {
    Text = "Wabah —— manifestasi kebetulan dari kegelisahan alam yang tidak disadari."
  },
  RelicConfig_70734_BattleDesc = {
    Text = "Setelah menggunakan Kunci perak untuk Bangkit kunci perak, kerusakan dasar yang diberikan oleh semua Pembangun meningkat sebesar [Arg1]% dan mendapatkan [Arg2] Energi-s."
  },
  RelicConfig_70734_Desc = {
    Text = "Setelah menggunakan Kunci perak untuk Bangkit kunci perak, kerusakan dasar yang diberikan oleh semua Pembangun meningkat sebesar [Arg1]% dan mendapatkan [Arg2] Energi-s."
  },
  RelicConfig_70734_Name = {
    Text = "<WhiteQuality:Alat Astrologi Rahasia>"
  },
  RelicConfig_70734_StoryDesc = {
    Text = "Misteri alam semesta."
  },
  RelicConfig_70735_BattleDesc = {
    Text = "Ketika memainkan 2 kartu berturut-turut dengan konsumsi aritmetika lebih rendah dari kartu sebelumnya, berikan [Arg1] <IntoxicationIconKeywords:Racun> kepada semua musuh, maksimal dipicu 3 kali per ronde."
  },
  RelicConfig_70735_Desc = {
    Text = "Ketika memainkan 2 kartu berturut-turut dengan konsumsi aritmetika lebih rendah dari kartu sebelumnya, berikan [Arg1] <IntoxicationIconKeywords:Racun> kepada semua musuh, maksimal dipicu 3 kali per ronde."
  },
  RelicConfig_70735_Name = {
    Text = "<OrangeQuality:Relik Arkhana+>"
  },
  RelicConfig_70735_StoryDesc = {
    Text = "Akhir dari takdir."
  },
  RelicConfig_70736_BattleDesc = {
    Text = "Menggunakan postur Laut Tenang untuk membuat semua musuh kehilangan [Arg1] poin <ExhaustionIconKeywords:Kekuatan> sementara. Cooldown 3 ronde."
  },
  RelicConfig_70736_Desc = {
    Text = "Menggunakan postur Laut Tenang untuk membuat semua musuh kehilangan [Arg1] poin <ExhaustionIconKeywords:Kekuatan> sementara. Cooldown 3 ronde."
  },
  RelicConfig_70736_Name = {
    Text = "<WhiteQuality:Anggota Tubuh Tanpa Nama>"
  },
  RelicConfig_70736_StoryDesc = {
    Text = "Hati-hati, bisa melukai tangan."
  },
  RelicConfig_70737_BattleDesc = {
    Text = "Setelah memainkan kartu, jika jumlah kartu di tangan kurang dari atau sama dengan [Arg1], tarik [Arg2] kartu. Setiap ronde dapat dipicu paling banyak [Arg3] kali."
  },
  RelicConfig_70737_Desc = {
    Text = "Setelah memainkan kartu, jika jumlah kartu di tangan kurang dari atau sama dengan [Arg1], tarik [Arg2] kartu. Setiap ronde dapat dipicu paling banyak [Arg3] kali."
  },
  RelicConfig_70737_Name = {
    Text = "<WhiteQuality:Sarung Tangan Sihir>"
  },
  RelicConfig_70737_StoryDesc = {
    Text = "\"Jangan takut, ini hanya sulap.\""
  },
  RelicConfig_70738_BattleDesc = {
    Text = "Pada akhir ronde, pulihkan [Heal:Arg1] Hidup."
  },
  RelicConfig_70738_Desc = {
    Text = "Pada akhir ronde, pulihkan [Heal:Arg1] Hidup."
  },
  RelicConfig_70738_Name = {
    Text = "<WhiteQuality: Darah Pemberian>"
  },
  RelicConfig_70738_StoryDesc = {
    Text = "Rasanya manis dan lembut, dengan aroma mawar yang khas."
  },
  RelicConfig_70739_BattleDesc = {
    Text = "Setelah Bangkit Kunci Perak, memperoleh [Arg1] Perisai dan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_70739_Desc = {
    Text = "Setelah Bangkit Kunci Perak, memperoleh [Arg1] Perisai dan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_70739_Name = {
    Text = "<WhiteQuality:Spesimen kupu-kupu>"
  },
  RelicConfig_70739_StoryDesc = {
    Text = "Hingga saat ini, dia juga sangat dicintai oleh seseorang."
  },
  RelicConfig_70740_BattleDesc = {
    Text = "Setelah menggunakan Kunci perak untuk Bangkit kunci perak, kerusakan dasar yang diberikan oleh semua Pembangun meningkat sebesar [Arg1]% dan mendapatkan [Arg2] Energi-s."
  },
  RelicConfig_70740_Desc = {
    Text = "Setelah menggunakan Kunci perak untuk Bangkit kunci perak, kerusakan dasar yang diberikan oleh semua Pembangun meningkat sebesar [Arg1]% dan mendapatkan [Arg2] Energi-s."
  },
  RelicConfig_70740_Name = {
    Text = "<OrangeQuality:Kitab Rahasia Astrologi+>"
  },
  RelicConfig_70740_StoryDesc = {
    Text = "Misteri alam semesta."
  },
  RelicConfig_70741_BattleDesc = {
    Text = "Maksimal aritmetika meningkat sebesar [Arg1]."
  },
  RelicConfig_70741_Desc = {
    Text = "Maksimal aritmetika meningkat sebesar [Arg1]."
  },
  RelicConfig_70741_Name = {
    Text = "<OrangeQuality:Penyuntik aktif+>"
  },
  RelicConfig_70741_StoryDesc = {
    Text = "Kejang juga merupakan salah satu bentuk aktivitas."
  },
  RelicConfig_70742_BattleDesc = {
    Text = "Pada awal pertempuran, batas Tentakel +[Arg1], dapatkan [Arg2] Tentakel."
  },
  RelicConfig_70742_Desc = {
    Text = "Pada awal pertempuran, batas Tentakel +[Arg1], dapatkan [Arg2] Tentakel."
  },
  RelicConfig_70742_Name = {
    Text = "<WhiteQuality: Nyanyian Laut>"
  },
  RelicConfig_70742_StoryDesc = {
    Text = "Dikatakan bahwa hewan yang tidak dapat dimakan, seperti kerang anyaman, menyerap sekitar 80% nutrisi dari lautan."
  },
  RelicConfig_70743_BattleDesc = {
    Text = "Setiap kali <DevouredIconKeywords:Melahap> pertama dalam satu ronde, Pembangun lainnya mendapatkan [Arg1] Aliemus."
  },
  RelicConfig_70743_Desc = {
    Text = "Setiap kali <DevouredIconKeywords:Melahap> pertama dalam satu ronde, Pembangun lainnya mendapatkan [Arg1] Aliemus."
  },
  RelicConfig_70743_Name = {
    Text = "<WhiteQuality:Golden Slumber>"
  },
  RelicConfig_70743_StoryDesc = {
    Text = "Hari metamorfosis adalah hari kematianmu."
  },
  RelicConfig_70744_BattleDesc = {
    Text = "Setelah memainkan kartu perintah non-turunan, kurangi konsumsi aritmetika sebesar 2 dan masukkan [Arg1] salinan sementara kartu ini ke dalam tumpukan menggambar, dengan cooldown 3 ronde."
  },
  RelicConfig_70744_Desc = {
    Text = "Setelah memainkan kartu perintah non-turunan, kurangi konsumsi aritmetika sebesar 2 dan masukkan [Arg1] salinan sementara kartu ini ke dalam tumpukan menggambar, dengan cooldown 3 ronde."
  },
  RelicConfig_70744_Name = {
    Text = "<OrangeQuality:Mesin Nyanyi Bisu+>"
  },
  RelicConfig_70744_StoryDesc = {
    Text = "Suaranya menghilang tertiup angin."
  },
  RelicConfig_70745_BattleDesc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1] <RetaliateIconKeywords:Counter>, efek dalam pertempuran bos dilipatgandakan."
  },
  RelicConfig_70745_Desc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1] <RetaliateIconKeywords:Counter>, efek dalam pertempuran bos dilipatgandakan."
  },
  RelicConfig_70745_Name = {
    Text = "<OrangeQuality:Rompi Urtiga+>"
  },
  RelicConfig_70745_StoryDesc = {
    Text = "Tidak bisa membedakan cairan yang menempel."
  },
  RelicConfig_70746_BattleDesc = {
    Text = "Pada awal giliran, jika Hidup di bawah 25%, dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_70746_Desc = {
    Text = "Pada awal giliran, jika Hidup di bawah 25%, dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_70746_Name = {
    Text = "<OrangeQuality:Kehormatan Tertinggi+>"
  },
  RelicConfig_70746_StoryDesc = {
    Text = [[
Kucing hitam berbulu pendek yang anggun dan misterius, dikatakan di suatu negara padang pasir yang jauh dianggap sebagai manifestasi dari Dewa. Namun, nama Dewa tersebut kini tak seorang pun yang mengetahuinya. 
Dibanggakan, dihormati, dilupakan, mungkin itulah takdir para Dewa.]]
  },
  RelicConfig_70747_BattleDesc = {
    Text = "Setelah memainkan kartu, jika jumlah kartu di tangan kurang dari atau sama dengan [Arg1], tarik [Arg2] kartu. Setiap ronde dapat dipicu paling banyak [Arg3] kali."
  },
  RelicConfig_70747_Desc = {
    Text = "Setelah memainkan kartu, jika jumlah kartu di tangan kurang dari atau sama dengan [Arg1], tarik [Arg2] kartu. Setiap ronde dapat dipicu paling banyak [Arg3] kali."
  },
  RelicConfig_70747_Name = {
    Text = "<OrangeQuality:Sarung Tangan Sihir+>"
  },
  RelicConfig_70747_StoryDesc = {
    Text = "\"Jangan takut, ini hanya sulap.\""
  },
  RelicConfig_70748_BattleDesc = {
    Text = "Setelah Bangkit Kunci Perak, memperoleh [Arg1] Perisai dan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_70748_Desc = {
    Text = "Setelah Bangkit Kunci Perak, memperoleh [Arg1] Perisai dan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_70748_Name = {
    Text = "<OrangeQuality:Spesimen kupu-kupu+>"
  },
  RelicConfig_70748_StoryDesc = {
    Text = "Hingga saat ini, dia juga sangat dicintai oleh seseorang."
  },
  RelicConfig_70749_BattleDesc = {
    Text = "Setiap kali sebuah kartu memasuki ruang ultra, jika pemilik kartu ini berbeda dari pemilik kartu lain di ruang ultra tersebut, maka tempatkan [Arg1] kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam tangan."
  },
  RelicConfig_70749_Desc = {
    Text = "Setiap kali sebuah kartu memasuki ruang ultra, jika pemilik kartu ini berbeda dari pemilik kartu lain di ruang ultra tersebut, maka tempatkan [Arg1] kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam tangan."
  },
  RelicConfig_70749_Name = {
    Text = "<OrangeQuality:Alat Alfonso+>"
  },
  RelicConfig_70749_StoryDesc = {
    Text = "Berbeda dengan takdir yang selalu berubah, bintang-bintang memiliki aturan pergerakan mereka sendiri."
  },
  RelicConfig_70750_BattleDesc = {
    Text = "Ketika memainkan 2 Kartu berturut-turut dengan Lelah Aritmetika lebih tinggi dari kartu sebelumnya, dapatkan [Arg1] <RetaliateIconKeywords:Counter>, maksimal terpicu 3 kali per ronde."
  },
  RelicConfig_70750_Desc = {
    Text = "Ketika memainkan 2 Kartu berturut-turut dengan Lelah Aritmetika lebih tinggi dari kartu sebelumnya, dapatkan [Arg1] <RetaliateIconKeywords:Counter>, maksimal terpicu 3 kali per ronde."
  },
  RelicConfig_70750_Name = {
    Text = "<WhiteQuality:Catatan Arkana>"
  },
  RelicConfig_70750_StoryDesc = {
    Text = "Arah takdir."
  },
  RelicConfig_70751_BattleDesc = {
    Text = "Setelah Bangkit Kunci Perak, memperoleh [Arg1] Aritmetika dan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_70751_Desc = {
    Text = "Setelah Bangkit Kunci Perak, memperoleh [Arg1] Aritmetika dan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_70751_Name = {
    Text = "<WhiteQuality:Emblem Mythag>"
  },
  RelicConfig_70751_StoryDesc = {
    Text = "Lencana yang didistribusikan oleh Universitas Mythag kepada para Penyelidik. Ini tidak hanya melambangkan identitas pemakainya, tetapi juga merupakan alat yang dapat digunakan untuk komunikasi jarak jauh."
  },
  RelicConfig_70752_BattleDesc = {
    Text = "Setelah menggunakan Bangkit kunci perak, dapatkan [Arg1] <RetaliateIconKeywords:Counter> dan [Arg2] Energi-s."
  },
  RelicConfig_70752_Desc = {
    Text = "Setelah menggunakan Bangkit kunci perak, dapatkan [Arg1] <RetaliateIconKeywords:Counter> dan [Arg2] Energi-s."
  },
  RelicConfig_70752_Name = {
    Text = "<WhiteQuality: Bab Pendahuluan>"
  },
  RelicConfig_70752_StoryDesc = {
    Text = "\"Manusia begitu bodoh, hanya karena sesuatu yang kuno, mereka akan percaya secara membabi buta.\""
  },
  RelicConfig_70753_BattleDesc = {
    Text = "Setelah pertempuran dimulai, tambahkan [Arg1] lapisan <VulnerabilityIconKeywords:Rentan> pada semua musuh. Efeknya berlipat ganda dalam pertarungan bos. Kerusakan dasar yang diberikan oleh semua Pembangun meningkat sebesar [Arg2]%."
  },
  RelicConfig_70753_Desc = {
    Text = "Setelah pertempuran dimulai, tambahkan [Arg1] lapisan <VulnerabilityIconKeywords:Rentan> pada semua musuh. Efeknya berlipat ganda dalam pertarungan bos. Kerusakan dasar yang diberikan oleh semua Pembangun meningkat sebesar [Arg2]%."
  },
  RelicConfig_70753_Name = {
    Text = "<OrangeQuality:Upacara Musim Semi+>"
  },
  RelicConfig_70753_StoryDesc = {
    Text = "Di tengah tawa malam, siluet perahu dayung meluncur dengan leluasa di permukaan danau."
  },
  RelicConfig_70754_BattleDesc = {
    Text = "Setelah pertama kali menggunakan \"Embrio\" secara langsung setiap ronde, serangan aktif dalam ronde ini akan menyebabkan [Arg1]% kerusakan tambahan dalam jumlah yang sama dengan <BleedingIconKeywords:Berdarah>."
  },
  RelicConfig_70754_Desc = {
    Text = "Setelah pertama kali menggunakan \"Embrio\" secara langsung setiap ronde, serangan aktif dalam ronde ini akan menyebabkan [Arg1]% kerusakan tambahan dalam jumlah yang sama dengan <BleedingIconKeywords:Berdarah>."
  },
  RelicConfig_70754_Name = {
    Text = "<WhiteQuality:Kerikil Berdarah>"
  },
  RelicConfig_70754_StoryDesc = {
    Text = "Satu, dua, tiga, empat, lima."
  },
  RelicConfig_70755_BattleDesc = {
    Text = "Setiap kali memberikan kerusakan, dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara. Maksimal terpicu 15 kali per ronde."
  },
  RelicConfig_70755_Desc = {
    Text = "Setiap kali memberikan kerusakan, dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara. Maksimal terpicu 15 kali per ronde."
  },
  RelicConfig_70755_Name = {
    Text = "<OrangeQuality:Agat Berlilitan+>"
  },
  RelicConfig_70755_StoryDesc = {
    Text = "Seharusnya hanya pola akik biasa. Mungkin."
  },
  RelicConfig_70756_BattleDesc = {
    Text = "Setelah Bangkit Kunci Perak, memperoleh [Arg1] Aritmetika dan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_70756_Desc = {
    Text = "Setelah Bangkit Kunci Perak, memperoleh [Arg1] Aritmetika dan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_70756_Name = {
    Text = "<OrangeQuality:Emblem Mythag+>"
  },
  RelicConfig_70756_StoryDesc = {
    Text = "Lencana yang didistribusikan oleh Universitas Mythag kepada para Penyelidik. Ini tidak hanya melambangkan identitas pemakainya, tetapi juga merupakan alat yang dapat digunakan untuk komunikasi jarak jauh."
  },
  RelicConfig_70757_BattleDesc = {
    Text = "Menggunakan postur Gelombang Amarah segera memicu semua Tentakel untuk melakukan Serangan terhadap musuh sebanyak [Arg1] kali, dengan waktu cooldown 3 ronde."
  },
  RelicConfig_70757_Desc = {
    Text = "Menggunakan postur Gelombang Amarah segera memicu semua Tentakel untuk melakukan Serangan terhadap musuh sebanyak [Arg1] kali, dengan waktu cooldown 3 ronde."
  },
  RelicConfig_70757_Name = {
    Text = "<WhiteQuality:Screw Oblivion's Joy>"
  },
  RelicConfig_70757_StoryDesc = {
    Text = "Tuan Pemimpin Tidur Panjang, menantimu dalam mimpi."
  },
  RelicConfig_70758_BattleDesc = {
    Text = "Ketika memainkan 2 kartu berturut-turut dengan konsumsi aritmetika lebih rendah dari kartu sebelumnya, berikan [Arg1] <IntoxicationIconKeywords:Racun> kepada semua musuh, maksimal dipicu 3 kali per ronde."
  },
  RelicConfig_70758_Desc = {
    Text = "Ketika memainkan 2 kartu berturut-turut dengan konsumsi aritmetika lebih rendah dari kartu sebelumnya, berikan [Arg1] <IntoxicationIconKeywords:Racun> kepada semua musuh, maksimal dipicu 3 kali per ronde."
  },
  RelicConfig_70758_Name = {
    Text = "<WhiteQuality:Relik Arkana>"
  },
  RelicConfig_70758_StoryDesc = {
    Text = "Akhir dari takdir."
  },
  RelicConfig_70759_BattleDesc = {
    Text = "Setelah pertempuran dimulai, tambahkan [Arg1] lapisan <WeaknessIconKeywords:Kelemahan> pada semua musuh. Efek pada bos menjadi dua kali lipat. Kerusakan dasar yang diberikan oleh semua Pembangun meningkat sebesar [Arg2]%."
  },
  RelicConfig_70759_Desc = {
    Text = "Setelah pertempuran dimulai, tambahkan [Arg1] lapisan <WeaknessIconKeywords:Kelemahan> pada semua musuh. Efek pada bos menjadi dua kali lipat. Kerusakan dasar yang diberikan oleh semua Pembangun meningkat sebesar [Arg2]%."
  },
  RelicConfig_70759_Name = {
    Text = "<WhiteQuality:Anak Jahat>"
  },
  RelicConfig_70759_StoryDesc = {
    Text = "Terlahir dari kejahatan murni, meskipun itu bukanlah keinginannya."
  },
  RelicConfig_70760_BattleDesc = {
    Text = "Pada awal pertempuran, terapkan [Arg1] <IntoxicationIconKeywords:Racun> kepada semua musuh, efeknya berlipat ganda dalam pertempuran bos."
  },
  RelicConfig_70760_Desc = {
    Text = "Pada awal pertempuran, terapkan [Arg1] <IntoxicationIconKeywords:Racun> kepada semua musuh, efeknya berlipat ganda dalam pertempuran bos."
  },
  RelicConfig_70760_Name = {
    Text = "<WhiteQuality:Neurotoksin>"
  },
  RelicConfig_70760_StoryDesc = {
    Text = "Ekstraksi, pemurnian."
  },
  RelicConfig_70761_BattleDesc = {
    Text = "Setelah pertempuran dimulai, tambahkan [Arg1] lapisan <VulnerabilityIconKeywords:Rentan> pada semua musuh. Efeknya berlipat ganda dalam pertarungan bos. Kerusakan dasar yang diberikan oleh semua Pembangun meningkat sebesar [Arg2]%."
  },
  RelicConfig_70761_Desc = {
    Text = "Setelah pertempuran dimulai, tambahkan [Arg1] lapisan <VulnerabilityIconKeywords:Rentan> pada semua musuh. Efeknya berlipat ganda dalam pertarungan bos. Kerusakan dasar yang diberikan oleh semua Pembangun meningkat sebesar [Arg2]%."
  },
  RelicConfig_70761_Name = {
    Text = "<WhiteQuality:Perayaan Musim Semi>"
  },
  RelicConfig_70761_StoryDesc = {
    Text = "Di tengah tawa malam, siluet perahu dayung meluncur dengan leluasa di permukaan danau."
  },
  RelicConfig_70762_BattleDesc = {
    Text = "Setelah melepaskan \"Muliakan\" sebanyak 4 kali dalam satu putaran, dapatkan [Arg1] Aritmetika, dengan cooldown 3 putaran."
  },
  RelicConfig_70762_Desc = {
    Text = "Setelah melepaskan \"Muliakan\" sebanyak 4 kali dalam satu putaran, dapatkan [Arg1] Aritmetika, dengan cooldown 3 putaran."
  },
  RelicConfig_70762_Name = {
    Text = "<OrangeQuality:Mesin Diferensial Perak Putih+>"
  },
  RelicConfig_70762_StoryDesc = {
    Text = "\"Itu mengubah sejarah.\""
  },
  RelicConfig_70763_BattleDesc = {
    Text = "Setelah melepaskan \"Muliakan\", dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_70763_Desc = {
    Text = "Setelah melepaskan \"Muliakan\", dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara."
  },
  RelicConfig_70763_Name = {
    Text = "<WhiteQuality:Kunci Berat>"
  },
  RelicConfig_70763_StoryDesc = {
    Text = [[
Gembok yang tebal dan kokoh, tanpa kunci, sepertinya akan sulit dibuka. 
Tentu saja, bagi pencuri ulung, ini bukan masalah besar.]]
  },
  RelicConfig_70764_BattleDesc = {
    Text = "Saat menerima serangan musuh, buat musuh menerima [Arg1] poin <FixedDamage:Kerusakan Murni>, kerusakan ini mendapat bonus [Arg2]% <RetaliateIconKeywords:Counter>, maksimal dipicu 1 kali per musuh per putaran."
  },
  RelicConfig_70764_Desc = {
    Text = "Saat menerima serangan musuh, buat musuh menerima <FixedDamage:Kerusakan Murni> sebesar [Arg3]% dari Max HP pihak kita, kerusakan ini mendapat bonus [Arg2]% <RetaliateIconKeywords:Counter>, maksimal dipicu 1 kali per musuh per putaran."
  },
  RelicConfig_70764_Name = {
    Text = "<WhiteQuality:Pisau Ritual yang Terlupakan>"
  },
  RelicConfig_70764_StoryDesc = {
    Text = "Belati dengan mata pisaunya yang melengkung, sering digunakan dalam ritual pengorbanan."
  },
  RelicConfig_70765_BattleDesc = {
    Text = "Setiap kali memberikan kerusakan, dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara. Maksimal terpicu 15 kali per ronde."
  },
  RelicConfig_70765_Desc = {
    Text = "Setiap kali memberikan kerusakan, dapatkan [Arg1] <PowerIconKeywords:Kekuatan> sementara. Maksimal terpicu 15 kali per ronde."
  },
  RelicConfig_70765_Name = {
    Text = "<WhiteQuality:Agate Berlilit>"
  },
  RelicConfig_70765_StoryDesc = {
    Text = "Seharusnya hanya pola akik biasa. Mungkin."
  },
  RelicConfig_70766_BattleDesc = {
    Text = "Pada awal giliran, jika Hidup di bawah 25%, dapatkan [Arg1] Perisai."
  },
  RelicConfig_70766_Desc = {
    Text = "Pada awal giliran, jika Hidup di bawah 25%, dapatkan [Arg1] Perisai."
  },
  RelicConfig_70766_Name = {
    Text = "<WhiteQuality:Tangan Penjaga>"
  },
  RelicConfig_70766_StoryDesc = {
    Text = "Tangan yang berdoa, tinju yang kokoh."
  },
  RelicConfig_70767_BattleDesc = {
    Text = "Pemusnah membuat Pembangun dengan Aliemus terendah mendapatkan [Arg1] Aliemus, cooldown 3 ronde."
  },
  RelicConfig_70767_Desc = {
    Text = "Pemusnah membuat Pembangun dengan Aliemus terendah mendapatkan [Arg1] Aliemus, cooldown 3 ronde."
  },
  RelicConfig_70767_Name = {
    Text = "<WhiteQuality:Cacing Waktu>"
  },
  RelicConfig_70767_StoryDesc = {
    Text = [[
Sebuah jam saku yang secara bersamaan berada di toko jam dan museum serangga. 
 Setelah dimulainya tahun Hongji, jam tersebut dimasukkan ke dalam koleksi universitas.]]
  },
  RelicConfig_70768_BattleDesc = {
    Text = "Setelah pertempuran dimulai, dapatkan [Arg1] <ProficientInRealmsIconKeywords:Alam Profesional>. Semua Pembangun yang dihidupkan memberikan <RetaliateIconKeywords:Counter> dan Relik yang dibuat meningkatkan <RetaliateIconKeywords:Counter> sebesar [Arg2]%."
  },
  RelicConfig_70768_Desc = {
    Text = "Setelah pertempuran dimulai, dapatkan [Arg1] <ProficientInRealmsIconKeywords:Alam Profesional>. Semua Pembangun yang dihidupkan memberikan <RetaliateIconKeywords:Counter> dan Relik yang dibuat meningkatkan <RetaliateIconKeywords:Counter> sebesar [Arg2]%."
  },
  RelicConfig_70768_Name = {
    Text = "<OrangeQuality:Mengetahui tanpa batas+>"
  },
  RelicConfig_70768_StoryDesc = {
    Text = "Ini menyampaikan tak terhitung banyaknya rahasia yang diucapkan secara aktif maupun pasif."
  },
  RelicConfig_70769_BattleDesc = {
    Text = "Setelah pertama kali menggunakan \"Embrio\" secara langsung setiap ronde, serangan aktif dalam ronde ini akan menyebabkan [Arg1]% kerusakan tambahan dalam jumlah yang sama dengan <BleedingIconKeywords:Berdarah>."
  },
  RelicConfig_70769_Desc = {
    Text = "Setelah pertama kali menggunakan \"Embrio\" secara langsung setiap ronde, serangan aktif dalam ronde ini akan menyebabkan [Arg1]% kerusakan tambahan dalam jumlah yang sama dengan <BleedingIconKeywords:Berdarah>."
  },
  RelicConfig_70769_Name = {
    Text = "<OrangeQuality:Kerikil Berdarah+>"
  },
  RelicConfig_70769_StoryDesc = {
    Text = "Satu, dua, tiga, empat, lima."
  },
  RelicConfig_70770_BattleDesc = {
    Text = "Pada awal ronde, tarik [Arg1] kartu."
  },
  RelicConfig_70770_Desc = {
    Text = "Pada awal ronde, tarik [Arg1] kartu."
  },
  RelicConfig_70770_Name = {
    Text = "<WhiteQuality: Kompas Terarah>"
  },
  RelicConfig_70770_StoryDesc = {
    Text = "Yang ditunjukkan bukan arah, melainkan medan magnet."
  },
  RelicConfig_70771_BattleDesc = {
    Text = "\"Serangan\"memberikan kerusakan tambahan sebesar 2 kali [Arg1]% daya serang Pembangun, dan dapat dipicu hingga 3 kali per putaran."
  },
  RelicConfig_70771_Desc = {
    Text = "\"Serangan\"memberikan kerusakan tambahan sebesar 2 kali [Arg1]% daya serang Pembangun, dan dapat dipicu hingga 3 kali per putaran."
  },
  RelicConfig_70771_Name = {
    Text = "<OrangeQuality:Pedang Willow Berkarat+>"
  },
  RelicConfig_70771_StoryDesc = {
    Text = "Tidak cocok untuk memotong makhluk hidup."
  },
  RelicConfig_70772_BattleDesc = {
    Text = "Setelah Bangkit Kunci Perak, menarik [Arg1] kartu dan mendapatkan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_70772_Desc = {
    Text = "Setelah Bangkit Kunci Perak, menarik [Arg1] kartu dan mendapatkan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_70772_Name = {
    Text = "<WhiteQuality:Dompet Baru yang Bersih>"
  },
  RelicConfig_70772_StoryDesc = {
    Text = [[
Dompet kulit dengan lambang Universitas Mythag tercetak di atasnya. 
 Saat ini, dompet itu kosong, tidak ada apa pun di dalamnya.]]
  },
  RelicConfig_70774_BattleDesc = {
    Text = "Kerusakan yang diberikan dalam lima serangan pertama setiap ronde meningkat sebesar [Arg1]%."
  },
  RelicConfig_70774_Desc = {
    Text = "Kerusakan yang diberikan dalam lima serangan pertama setiap ronde meningkat sebesar [Arg1]%."
  },
  RelicConfig_70774_Name = {
    Text = "<WhiteQuality:Alat Koreksi Penglihatan>"
  },
  RelicConfig_70774_StoryDesc = {
    Text = "Ada yang pernah melihat melalui itu dan menemukan kebenaran."
  },
  RelicConfig_70776_BattleDesc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1] <RetaliateIconKeywords:Counter>, efek dalam pertempuran bos dilipatgandakan."
  },
  RelicConfig_70776_Desc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1] <RetaliateIconKeywords:Counter>, efek dalam pertempuran bos dilipatgandakan."
  },
  RelicConfig_70776_Name = {
    Text = "<WhiteQuality:Rompi Urtiga>"
  },
  RelicConfig_70776_StoryDesc = {
    Text = "Tidak bisa membedakan cairan yang menempel."
  },
  RelicConfig_70777_BattleDesc = {
    Text = "Setelah memainkan 4 Kartu perintah yang berasal dari Pembangun berbeda dalam satu ronde, semua Pembangun mendapatkan [Arg1] Aliemus, dengan cooldown 3 ronde."
  },
  RelicConfig_70777_Desc = {
    Text = "Setelah memainkan 4 Kartu perintah yang berasal dari Pembangun berbeda dalam satu ronde, semua Pembangun mendapatkan [Arg1] Aliemus, dengan cooldown 3 ronde."
  },
  RelicConfig_70777_Name = {
    Text = "<WhiteQuality:Jilbab Dewa Tanpa Nama>"
  },
  RelicConfig_70777_StoryDesc = {
    Text = "Jangan menatap dewa secara langsung."
  },
  RelicConfig_70778_BattleDesc = {
    Text = "Pada awal pertempuran, terapkan [Arg1] <IntoxicationIconKeywords:Racun> kepada semua musuh, efeknya berlipat ganda dalam pertempuran bos."
  },
  RelicConfig_70778_Desc = {
    Text = "Pada awal pertempuran, terapkan [Arg1] <IntoxicationIconKeywords:Racun> kepada semua musuh, efeknya berlipat ganda dalam pertempuran bos."
  },
  RelicConfig_70778_Name = {
    Text = "<OrangeQuality:Neurotoksin+>"
  },
  RelicConfig_70778_StoryDesc = {
    Text = "Ekstraksi, pemurnian."
  },
  RelicConfig_70779_BattleDesc = {
    Text = "Setelah menggunakan Bangkit kunci perak, terapkan [Arg1] <IntoxicationIconKeywords:Racun> kepada semua musuh dan dapatkan [Arg2] Energi-s."
  },
  RelicConfig_70779_Desc = {
    Text = "Setelah menggunakan Bangkit kunci perak, terapkan [Arg1] <IntoxicationIconKeywords:Racun> kepada semua musuh dan dapatkan [Arg2] Energi-s."
  },
  RelicConfig_70779_Name = {
    Text = "<WhiteQuality:Salep Mencurigakan>"
  },
  RelicConfig_70779_StoryDesc = {
    Text = "Semacam salep luka buatan sendiri, mohon jangan digunakan tanpa panduan dokter."
  },
  RelicConfig_70780_BattleDesc = {
    Text = "\"Pukulan\"memberikan [Arg1]% dari <IntoxicationIconKeywords:Racun>, menyebabkan hingga [Arg2] kerusakan setiap putaran."
  },
  RelicConfig_70780_Desc = {
    Text = "\"Pukulan\"memberikan [Arg1]% dari <IntoxicationIconKeywords:Racun>, menyebabkan hingga [Arg2] kerusakan setiap putaran."
  },
  RelicConfig_70780_Name = {
    Text = "<WhiteQuality:Lidah Asing>"
  },
  RelicConfig_70780_StoryDesc = {
    Text = "Dia bukan iblis, tetapi Dia memang menyampaikan bisikan dari luar dunia manusia."
  },
  RelicConfig_70781_BattleDesc = {
    Text = "Pada awal giliran, jika Hidup di bawah 25%, dapatkan [Arg1] Perisai."
  },
  RelicConfig_70781_Desc = {
    Text = "Pada awal giliran, jika Hidup di bawah 25%, dapatkan [Arg1] Perisai."
  },
  RelicConfig_70781_Name = {
    Text = "<OrangeQuality:Tangan Penjaga+>"
  },
  RelicConfig_70781_StoryDesc = {
    Text = "Tangan yang berdoa, tinju yang kokoh."
  },
  RelicConfig_70782_BattleDesc = {
    Text = "Mendapatkan [Arg1]% dari jumlah kehilangan hidup sebagai Dapur Merah saat kehilangan kehidupan."
  },
  RelicConfig_70782_Desc = {
    Text = "Mendapatkan [Arg1]% dari jumlah kehilangan hidup sebagai Dapur Merah saat kehilangan kehidupan."
  },
  RelicConfig_70782_Name = {
    Text = "<OrangeQuality: Gergaji Baja Berkarat +>"
  },
  RelicConfig_70782_StoryDesc = {
    Text = "Dokter anatomi seumur hidup tidak pernah melihat wanita cantik, hanya ada karung tulang, saraf yang meradang karena penyakit, otot, dan jaringan."
  },
  RelicConfig_70783_BattleDesc = {
    Text = "Kerusakan yang diberikan dalam lima serangan pertama setiap ronde meningkat sebesar [Arg1]%."
  },
  RelicConfig_70783_Desc = {
    Text = "Kerusakan yang diberikan dalam lima serangan pertama setiap ronde meningkat sebesar [Arg1]%."
  },
  RelicConfig_70783_Name = {
    Text = "<OrangeQuality:Alat Koreksi Penglihatan+>"
  },
  RelicConfig_70783_StoryDesc = {
    Text = "Ada yang pernah melihat melalui itu dan menemukan kebenaran."
  },
  RelicConfig_70784_BattleDesc = {
    Text = "Setiap kali sebuah kartu memasuki ruang ultra, jika pemilik kartu ini berbeda dari pemilik kartu lain di ruang ultra tersebut, maka tempatkan [Arg1] kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam tangan."
  },
  RelicConfig_70784_Desc = {
    Text = "Setiap kali sebuah kartu memasuki ruang ultra, jika pemilik kartu ini berbeda dari pemilik kartu lain di ruang ultra tersebut, maka tempatkan [Arg1] kartu <DerivativeCardKeywords_4:\"Inspirasi\"> ke dalam tangan."
  },
  RelicConfig_70784_Name = {
    Text = "<WhiteQuality:Alat Alfonso>"
  },
  RelicConfig_70784_StoryDesc = {
    Text = "Berbeda dengan takdir yang selalu berubah, bintang-bintang memiliki aturan pergerakan mereka sendiri."
  },
  RelicConfig_70785_BattleDesc = {
    Text = "Setelah memainkan 4 Kartu perintah yang berasal dari Pembangun berbeda dalam satu ronde, semua Pembangun mendapatkan [Arg1] Aliemus, dengan cooldown 3 ronde."
  },
  RelicConfig_70785_Desc = {
    Text = "Setelah memainkan 4 Kartu perintah yang berasal dari Pembangun berbeda dalam satu ronde, semua Pembangun mendapatkan [Arg1] Aliemus, dengan cooldown 3 ronde."
  },
  RelicConfig_70785_Name = {
    Text = "<OrangeQuality:Jilbab Dewa Tanpa Nama+>"
  },
  RelicConfig_70785_StoryDesc = {
    Text = "Jangan menatap dewa secara langsung."
  },
  RelicConfig_70786_BattleDesc = {
    Text = "Pada akhir ronde, jika berada dalam posisi Surge, dapatkan [Arg1] <TentacleInjurieIconKeywords:Kerusakan tentakel>, cooldown 3 ronde."
  },
  RelicConfig_70786_Desc = {
    Text = "Pada akhir ronde, jika berada dalam posisi Surge, dapatkan [Arg1] <TentacleInjurieIconKeywords:Kerusakan tentakel>, cooldown 3 ronde."
  },
  RelicConfig_70786_Name = {
    Text = "<WhiteQuality:Belatung Pecah Kepala>"
  },
  RelicConfig_70786_StoryDesc = {
    Text = "Selama otak kita masih menjadi misteri, maka tidak ada yang perlu terkejut jika di dalamnya penuh dengan tentakel."
  },
  RelicConfig_70787_BattleDesc = {
    Text = "Semua kerusakan dasar yang diberikan oleh Bangun meningkat sebesar [Arg1]%."
  },
  RelicConfig_70787_Desc = {
    Text = "Semua kerusakan dasar yang diberikan oleh Bangun meningkat sebesar [Arg1]%."
  },
  RelicConfig_70787_Name = {
    Text = "<OrangeQuality:Pipa Tangisan+>"
  },
  RelicConfig_70787_StoryDesc = {
    Text = "Apakah ini produk dari kebencian, atau hasil dari balas dendam?"
  },
  RelicConfig_70788_BattleDesc = {
    Text = "Setelah Bangkit Kunci Perak, semua Pembangun memperoleh [Arg1] Aliemus dan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_70788_Desc = {
    Text = "Setelah Bangkit Kunci Perak, semua Pembangun memperoleh [Arg1] Aliemus dan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_70788_Name = {
    Text = "<WhiteQuality:Kancing Lengan Kayu Manis>"
  },
  RelicConfig_70788_StoryDesc = {
    Text = [[
Kancing manset perak dengan ukiran daun laurel. 
 Dibuat dengan sangat halus, berkilauan, dan pernah menjadi simbol persahabatan dua anak.]]
  },
  RelicConfig_70789_BattleDesc = {
    Text = "Setelah pertempuran dimulai, dapatkan [Arg1] <ProficientInRealmsIconKeywords:Penguasaan Alam>. Semua Pembangun memberikan <IntoxicationIconKeywords:Racun> dan Relik memberikan <IntoxicationIconKeywords:Racun> meningkat sebesar [Arg2]%."
  },
  RelicConfig_70789_Desc = {
    Text = "Setelah pertempuran dimulai, dapatkan [Arg1] <ProficientInRealmsIconKeywords:Penguasaan Alam>. Semua Pembangun memberikan <IntoxicationIconKeywords:Racun> dan Relik memberikan <IntoxicationIconKeywords:Racun> meningkat sebesar [Arg2]%."
  },
  RelicConfig_70789_Name = {
    Text = "<WhiteQuality:Mesin Jahit Berdebu>"
  },
  RelicConfig_70789_StoryDesc = {
    Text = "Seorang ibu yang penuh kasih, menjahit luka di hati."
  },
  RelicConfig_70790_BattleDesc = {
    Text = "Pemusnah membuat Pembangun dengan Aliemus terendah mendapatkan [Arg1] Aliemus, cooldown 3 ronde."
  },
  RelicConfig_70790_Desc = {
    Text = "Pemusnah membuat Pembangun dengan Aliemus terendah mendapatkan [Arg1] Aliemus, cooldown 3 ronde."
  },
  RelicConfig_70790_Name = {
    Text = "<OrangeQuality:Cacing Waktu+>"
  },
  RelicConfig_70790_StoryDesc = {
    Text = [[
Sebuah jam saku yang secara bersamaan berada di toko jam dan museum serangga. 
 Setelah dimulainya tahun Hongji, jam tersebut dimasukkan ke dalam koleksi universitas.]]
  },
  RelicConfig_70791_BattleDesc = {
    Text = "Pada awal pertempuran, batas Tentakel +[Arg1], dapatkan [Arg2] Tentakel."
  },
  RelicConfig_70791_Desc = {
    Text = "Pada awal pertempuran, batas Tentakel +[Arg1], dapatkan [Arg2] Tentakel."
  },
  RelicConfig_70791_Name = {
    Text = "<OrangeQuality:Lagu Lautan+>"
  },
  RelicConfig_70791_StoryDesc = {
    Text = "Dikatakan bahwa hewan yang tidak dapat dimakan, seperti kerang anyaman, menyerap sekitar 80% nutrisi dari lautan."
  },
  RelicConfig_70792_BattleDesc = {
    Text = "Pada akhir ronde, jika berada dalam posisi Surge, dapatkan [Arg1] <TentacleInjurieIconKeywords:Kerusakan tentakel>, cooldown 3 ronde."
  },
  RelicConfig_70792_Desc = {
    Text = "Pada akhir ronde, jika berada dalam posisi Surge, dapatkan [Arg1] <TentacleInjurieIconKeywords:Kerusakan tentakel>, cooldown 3 ronde."
  },
  RelicConfig_70792_Name = {
    Text = "<OrangeQuality:Belut Kepala Retak+>"
  },
  RelicConfig_70792_StoryDesc = {
    Text = "Selama otak kita masih menjadi misteri, maka tidak ada yang perlu terkejut jika di dalamnya penuh dengan tentakel."
  },
  RelicConfig_70793_BattleDesc = {
    Text = "Setiap kali <DevouredIconKeywords:Melahap> pertama dalam satu ronde, Pembangun lainnya mendapatkan [Arg1] Aliemus."
  },
  RelicConfig_70793_Desc = {
    Text = "Setiap kali <DevouredIconKeywords:Melahap> pertama dalam satu ronde, Pembangun lainnya mendapatkan [Arg1] Aliemus."
  },
  RelicConfig_70793_Name = {
    Text = "<OrangeQuality:Golden Slumber+>"
  },
  RelicConfig_70793_StoryDesc = {
    Text = "Hari metamorfosis adalah hari kematianmu."
  },
  RelicConfig_70794_BattleDesc = {
    Text = "Penghancuran mendapatkan [Arg1] Perisai, cooldown 3 putaran."
  },
  RelicConfig_70794_Desc = {
    Text = "Penghancuran mendapatkan [Arg1] Perisai, cooldown 3 putaran."
  },
  RelicConfig_70794_Name = {
    Text = "<OrangeQuality:Jam Saku Superstring+>"
  },
  RelicConfig_70794_StoryDesc = {
    Text = "\"Ah, jam saku berhenti.\""
  },
  RelicConfig_70795_BattleDesc = {
    Text = "Setelah memainkan kartu perintah non-turunan, kurangi konsumsi aritmetika sebesar 2 dan masukkan [Arg1] salinan sementara kartu ini ke dalam tumpukan menggambar, dengan cooldown 3 ronde."
  },
  RelicConfig_70795_Desc = {
    Text = "Setelah memainkan kartu perintah non-turunan, kurangi konsumsi aritmetika sebesar 2 dan masukkan [Arg1] salinan sementara kartu ini ke dalam tumpukan menggambar, dengan cooldown 3 ronde."
  },
  RelicConfig_70795_Name = {
    Text = "<WhiteQuality:Pemutar Suara yang Hilang>"
  },
  RelicConfig_70795_StoryDesc = {
    Text = "Suaranya menghilang tertiup angin."
  },
  RelicConfig_70796_BattleDesc = {
    Text = "Setelah menggunakan \"Exalt\", buat semua musuh menerima [Arg1] poin <FixedDamage:Kerusakan Murni>, dan picu [Arg2]% <IntoxicationIconKeywords:Racun>."
  },
  RelicConfig_70796_Desc = {
    Text = "Setelah menggunakan \"Exalt\", buat semua musuh menerima 1 kali <FixedDamage:Kerusakan Murni> sebesar [Arg2]% dari Max HP pihak kita, dan picu [Arg2]% <IntoxicationIconKeywords:Racun>."
  },
  RelicConfig_70796_Name = {
    Text = "<OrangeQuality:Rahang Laser+>"
  },
  RelicConfig_70796_StoryDesc = {
    Text = [[
Tulang yang dipajang di ruang pameran pribadi seorang kolektor. 
 Kolektor tersebut terpesona oleh cahaya fluoresen yang indah, menikmatinya siang dan malam, hingga akhirnya mengering dan mati, menjadi serupa dengan tulang itu sendiri.]]
  },
  RelicConfig_70797_BattleDesc = {
    Text = "Maksimal aritmetika meningkat sebesar [Arg1]."
  },
  RelicConfig_70797_Desc = {
    Text = "Maksimal aritmetika meningkat sebesar [Arg1]."
  },
  RelicConfig_70797_Name = {
    Text = "<WhiteQuality:Penyuntik aktif>"
  },
  RelicConfig_70797_StoryDesc = {
    Text = "Kejang juga merupakan salah satu bentuk aktivitas."
  },
  RelicConfig_70798_BattleDesc = {
    Text = "Menggunakan postur Gelombang Amarah segera memicu semua Tentakel untuk melakukan Serangan terhadap musuh sebanyak [Arg1] kali, dengan waktu cooldown 3 ronde."
  },
  RelicConfig_70798_Desc = {
    Text = "Menggunakan postur Gelombang Amarah segera memicu semua Tentakel untuk melakukan Serangan terhadap musuh sebanyak [Arg1] kali, dengan waktu cooldown 3 ronde."
  },
  RelicConfig_70798_Name = {
    Text = "<OrangeQuality:Kesenangan Luo Yan+>"
  },
  RelicConfig_70798_StoryDesc = {
    Text = "Tuan Pemimpin Tidur Panjang, menantimu dalam mimpi."
  },
  RelicConfig_70799_BattleDesc = {
    Text = "Pertahanan mendapatkan [Arg1] sementara <RetaliateIconKeywords:Counter>, maksimal terpicu 3 kali per putaran."
  },
  RelicConfig_70799_Desc = {
    Text = "Pertahanan mendapatkan [Arg1] sementara <RetaliateIconKeywords:Counter>, maksimal terpicu 3 kali per putaran."
  },
  RelicConfig_70799_Name = {
    Text = "<OrangeQuality:Jam Saku Mendiang+>"
  },
  RelicConfig_70799_StoryDesc = {
    Text = "Membawa rasa kerinduan dan kesedihan, melangkah maju menuju hal yang tidak diketahui."
  },
  RelicConfig_70800_BattleDesc = {
    Text = "Pertahanan mendapatkan [Arg1] sementara <RetaliateIconKeywords:Counter>, maksimal terpicu 3 kali per putaran."
  },
  RelicConfig_70800_Desc = {
    Text = "Pertahanan mendapatkan [Arg1] sementara <RetaliateIconKeywords:Counter>, maksimal terpicu 3 kali per putaran."
  },
  RelicConfig_70800_Name = {
    Text = "<WhiteQuality:Jam Saku Mendiang>"
  },
  RelicConfig_70800_StoryDesc = {
    Text = "Membawa rasa kerinduan dan kesedihan, melangkah maju menuju hal yang tidak diketahui."
  },
  RelicConfig_70986_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua Pembangun. Pada awal giliran ganjil, pilih 1 dari 2 Relik untuk diperoleh, berlangsung selama 5 giliran ganjil."
  },
  RelicConfig_70986_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua Pembangun. Pada awal giliran ganjil, pilih 1 dari 2 Relik untuk diperoleh, berlangsung selama 5 giliran ganjil."
  },
  RelicConfig_70986_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Doa η\">"
  },
  RelicConfig_70987_BattleDesc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua Pembangun. Pada awal giliran ganjil, pilih 1 dari 2 Relik untuk diperoleh, berlangsung selama 5 giliran ganjil."
  },
  RelicConfig_70987_Desc = {
    Text = "Pada awal pertempuran, batas aritmetika +1, bangun semua Pembangun. Pada awal giliran ganjil, pilih 1 dari 2 Relik untuk diperoleh, berlangsung selama 5 giliran ganjil."
  },
  RelicConfig_70987_Name = {
    Text = "<OrangeQuality:Pendulum waktu\"Doa ζ\">"
  },
  RelicConfig_71195_BattleDesc = {
    Text = "Pada awal ronde, Ramona-loop mendapatkan [Arg1] Aliemus. Saat \"Loop\" pertama kali terpicu setiap ronde, dapatkan [Arg2] poin Energi-s dan [Arg3] lapisan \"Negentropy\"."
  },
  RelicConfig_71195_Desc = {
    Text = "Pada awal ronde, Ramona-loop mendapatkan [Arg1] Aliemus. Saat \"Loop\" pertama kali terpicu setiap ronde, dapatkan [Arg2] poin Energi-s dan [Arg3] lapisan \"Negentropy\"."
  },
  RelicConfig_71195_Name = {
    Text = "<OrangeQuality:Dimensi·Ramona-loop>"
  },
  RelicConfig_71196_BattleDesc = {
    Text = "Pada awal ronde, Lotan memperoleh [Arg1] Aliemus. Setelah menggunakan kartu \"Pertahanan\" pertama Lotan di setiap ronde, tambahkan [Arg2] kartu \"Pedang Pemberontak\" dengan Lelah dan Ilusi ke tangan."
  },
  RelicConfig_71196_Desc = {
    Text = "Pada awal ronde, Lotan memperoleh [Arg1] Aliemus. Setelah menggunakan kartu \"Pertahanan\" pertama Lotan di setiap ronde, tambahkan [Arg2] kartu \"Pedang Pemberontak\" dengan Lelah dan Ilusi ke tangan."
  },
  RelicConfig_71196_Name = {
    Text = "<OrangeQuality:Dimensi·Lotan>"
  },
  RelicConfig_71197_BattleDesc = {
    Text = "Pada awal giliran, Ramona mendapatkan [Arg1] Aliemus. Setiap kali Kartu perintah Ramona yang ke-[Arg2] dimainkan, kartu perintah tersebut akan berlaku tambahan 1 kali dan mendapatkan [Arg3] Energi-s."
  },
  RelicConfig_71197_Desc = {
    Text = "Pada awal giliran, Ramona mendapatkan [Arg1] Aliemus. Setiap kali Kartu perintah Ramona yang ke-[Arg2] dimainkan, kartu perintah tersebut akan berlaku tambahan 1 kali dan mendapatkan [Arg3] Energi-s."
  },
  RelicConfig_71197_Name = {
    Text = "<OrangeQuality:Dimensi·Ramona>"
  },
  RelicConfig_71230_BattleDesc = {
    Text = "Saat giliran dimulai, Leigh mendapatkan [Arg1] Aliemus. Setiap kali kehilangan HP, dapatkan [Arg2] poin Strength, maksimal ditumpuk [Arg3] kali per pertempuran. Setelah ditumpuk [Arg3] kali, Arithmetica Cost dasar \"Penderitaan dan Kesenangan\" berkurang 2, jumlah Kerusakan meningkat 1."
  },
  RelicConfig_71230_Desc = {
    Text = "Saat giliran dimulai, Leigh mendapatkan [Arg1] Aliemus. Setiap kali kehilangan HP, dapatkan [Arg2] poin Strength, maksimal ditumpuk [Arg3] kali per pertempuran. Setelah ditumpuk [Arg3] kali, Arithmetica Cost dasar \"Penderitaan dan Kesenangan\" berkurang 2, jumlah Kerusakan meningkat 1."
  },
  RelicConfig_71230_Name = {
    Text = "<OrangeQuality:Dimensi·Leigh>"
  },
  RelicConfig_71231_BattleDesc = {
    Text = "Pada awal giliran, Aurita mendapatkan [Arg1] poin Aliemus. Jumlah kerusakan \"Pecahan kelenjar\" meningkat [Arg2], setelah memainkan \"Pertahanan\" Aurita, tempatkan 1 kartu \"Pecahan kelenjar\" ke tangan."
  },
  RelicConfig_71231_Desc = {
    Text = "Pada awal giliran, Aurita mendapatkan [Arg1] poin Aliemus. Jumlah kerusakan \"Pecahan kelenjar\" meningkat [Arg2], setelah memainkan \"Pertahanan\" Aurita, tempatkan 1 kartu \"Pecahan kelenjar\" ke tangan."
  },
  RelicConfig_71231_Name = {
    Text = "<OrangeQuality:Dimensi·Aurita>"
  },
  RelicConfig_71232_BattleDesc = {
    Text = "Pada awal ronde, Tinct mendapatkan [Arg1] Aliemus. Setelah Kartu perintah Tinct memicu Lompatan, kartu tersebut akan dikembalikan ke tangan dan mengurangi Lelah Aritmetika sebelum dimainkan sebesar -1. Efek ini paling banyak berlaku [Arg2] kali per ronde."
  },
  RelicConfig_71232_Desc = {
    Text = "Pada awal ronde, Tinct mendapatkan [Arg1] Aliemus. Setelah Kartu perintah Tinct memicu Lompatan, kartu tersebut akan dikembalikan ke tangan dan mengurangi Lelah Aritmetika sebelum dimainkan sebesar -1. Efek ini paling banyak berlaku [Arg2] kali per ronde."
  },
  RelicConfig_71232_Name = {
    Text = "<OrangeQuality:Dimensi·Tinct>"
  },
  RelicConfig_71233_BattleDesc = {
    Text = "Pada awal ronde, Nautila mendapatkan [Arg1] Aliemus. Setelah melepaskan \"Muliakan\" Nautila, ia akan mendapatkan Counter setara dengan [Arg2]% dari Perisai saat ini dan Perisai Tertunda, yang dapat dipicu maksimal 1 kali per ronde."
  },
  RelicConfig_71233_Desc = {
    Text = "Pada awal ronde, Nautila mendapatkan [Arg1] Aliemus. Setelah melepaskan \"Aliemus Muliakan\" Nautila, ia akan mendapatkan Counter setara dengan [Arg2]% dari Perisai saat ini dan Perisai Tertunda, yang dapat dipicu maksimal 1 kali per ronde."
  },
  RelicConfig_71233_Name = {
    Text = "<OrangeQuality:Dimensi·Nautila>"
  },
  RelicConfig_71234_BattleDesc = {
    Text = "Pada awal giliran, Boneka·Aliemus mendapatkan [Arg1] Aliemus. Setelah Boneka·Aliemus melepaskan Muliakan, untuk setiap [Arg2] poin Aliemus yang Lelah, Pembangun lainnya mendapatkan 1 poin Aliemus."
  },
  RelicConfig_71234_Desc = {
    Text = "Pada awal giliran, Boneka·Aliemus mendapatkan [Arg1] Aliemus. Setelah Boneka·Aliemus melepaskan Aliemus Muliakan, untuk setiap [Arg2] poin Aliemus yang dikonsumsi, Pembangun lainnya mendapatkan 1 poin Aliemus."
  },
  RelicConfig_71234_Name = {
    Text = "<OrangeQuality:Dimensi·Meleleh·Boneka>"
  },
  RelicConfig_71235_BattleDesc = {
    Text = "Pada awal giliran, Helot mendapatkan [Arg1] Aliemus. Setiap kali 1 kartu dibuang, Helot mendapatkan [Arg2] Aliemus."
  },
  RelicConfig_71235_Desc = {
    Text = "Pada awal giliran, Helot mendapatkan [Arg1] Aliemus. Setiap kali 1 kartu dibuang, Helot mendapatkan [Arg2] Aliemus."
  },
  RelicConfig_71235_Name = {
    Text = "<OrangeQuality:Dimensi·Helot>"
  },
  RelicConfig_71236_BattleDesc = {
    Text = "Pada awal ronde, Narsis mendapatkan [Arg1] Aliemus dan 1 kartu \"Inspirasi\". Peningkatan \"Kekuatan\" dari \"Pasang Surut Heterogen\" meningkat sebesar [Arg2]%, setiap kali digunakan dalam eksplorasi ini akan meningkatkan secara permanen tambahan [Arg3]%, dengan peningkatan maksimum sebesar [Arg4]%."
  },
  RelicConfig_71236_Desc = {
    Text = "Pada awal ronde, Narsis mendapatkan [Arg1] Aliemus dan 1 kartu \"Inspirasi\". Peningkatan \"Kekuatan\" dari \"Pasang Surut Heterogen\" meningkat sebesar [Arg2]%, setiap kali digunakan dalam eksplorasi ini akan meningkatkan secara permanen tambahan [Arg3]%, dengan peningkatan maksimum sebesar [Arg4]%."
  },
  RelicConfig_71236_Name = {
    Text = "<OrangeQuality:Dimensi·Narsis>"
  },
  RelicConfig_71237_BattleDesc = {
    Text = "Pada awal giliran, Wanda mendapatkan [Arg1] jumlah aliamus dan [Arg2] lapisan \"Mimpi Pembuat\". Jika pada giliran ultra akan dapatkan tambahan 1 kartu sementara \"Jahitan Duri\" dan \"Penjaga Tersesat\" dan membuat kartu perintah Wanda berikutnya efektif 2 kali."
  },
  RelicConfig_71237_Desc = {
    Text = "Pada awal giliran, Wanda mendapatkan [Arg1] jumlah aliamus dan [Arg2] lapisan \"Mimpi Pembuat\". Jika pada giliran ultra akan dapatkan tambahan 1 kartu sementara \"Jahitan Duri\" dan \"Penjaga Tersesat\" dan membuat kartu perintah Wanda berikutnya efektif 2 kali."
  },
  RelicConfig_71237_Name = {
    Text = "<OrangeQuality:Dimensi·Wanda>"
  },
  RelicConfig_71238_BattleDesc = {
    Text = "Pada awal ronde, Agrippa mendapatkan [Arg1] Aliemus. \"Sedekah yang Tidak Sabar\"juga akan mengurangi Lelah Aritmetika Agrippa dalam ronde ini sebesar [Arg2], dan efek ini hanya dapat aktif sekali per ronde."
  },
  RelicConfig_71238_Desc = {
    Text = "Pada awal ronde, Agrippa mendapatkan [Arg1] Aliemus. \"Sedekah yang Tidak Sabar\"juga akan mengurangi Lelah Aritmetika Agrippa dalam ronde ini sebesar [Arg2], dan efek ini hanya dapat aktif sekali per ronde."
  },
  RelicConfig_71238_Name = {
    Text = "<OrangeQuality:Dimensi·Agrippa>"
  },
  RelicConfig_71239_BattleDesc = {
    Text = "Pada awal ronde, \"24\"memperoleh [Arg1] Aliemus. Pada awal ronde, jika \"24\"berada dalam \"Kepribadian Depresi\", maka akan memperoleh tambahan [Arg2] Aliemus; jika berada dalam \"Kepribadian Manik\", maka tingkat kritis sementara dan kerusakan kritis sementara \"24\"akan meningkat sebesar [Arg2]%."
  },
  RelicConfig_71239_Desc = {
    Text = "Pada awal ronde, \"24\"memperoleh [Arg1] Aliemus. Pada awal ronde, jika \"24\"berada dalam \"Kepribadian Depresi\", maka akan memperoleh tambahan [Arg2] Aliemus; jika berada dalam \"Kepribadian Manik\", maka tingkat kritis sementara dan kerusakan kritis sementara \"24\"akan meningkat sebesar [Arg2]%."
  },
  RelicConfig_71239_Name = {
    Text = "<OrangeQuality:Dimensi Citra·\"24\">"
  },
  RelicConfig_71240_BattleDesc = {
    Text = "Pada awal giliran, Liz mendapatkan [Arg1] Aliemus. Efek dari kartu yang dibuang oleh \"Tarian kehancuran\"akan berlaku tambahan 1 kali, dengan cooldown selama 3 giliran."
  },
  RelicConfig_71240_Desc = {
    Text = "Pada awal giliran, Liz mendapatkan [Arg1] Aliemus. Efek dari kartu yang dibuang oleh \"Tarian kehancuran\"akan berlaku tambahan 1 kali, dengan cooldown selama 3 giliran."
  },
  RelicConfig_71240_Name = {
    Text = "<OrangeQuality:Dimensi·Liz>"
  },
  RelicConfig_71241_BattleDesc = {
    Text = "Pada awal giliran, Helot-catena mendapatkan [Arg1] Aliemus. Kerusakan aktif Helot-catena memberikan tambahan [Arg2]% Berdarah. Setelah membunuh musuh, Helot-catena menyebabkan Berdarah pada musuh lainnya sebesar kerusakan berlebih."
  },
  RelicConfig_71241_Desc = {
    Text = "Pada awal giliran, Helot-catena mendapatkan [Arg1] Aliemus. Kerusakan aktif Helot-catena memberikan tambahan [Arg2]% Berdarah. Setelah membunuh musuh, Helot-catena menyebabkan Berdarah pada musuh lainnya sebesar kerusakan berlebih."
  },
  RelicConfig_71241_Name = {
    Text = "<OrangeQuality:Dimensi·Helot-catena>"
  },
  RelicConfig_71242_BattleDesc = {
    Text = "Pada awal ronde, Celeste mendapatkan [Arg1] Aliemus. Sebelum ronde berakhir, setiap 1 Kartu perintah Celeste di tangan akan membuat 1 Tentakel menyerang musuh dan memulihkan [Heal:Arg2] poin Hidup."
  },
  RelicConfig_71242_Desc = {
    Text = "Pada awal ronde, Celeste mendapatkan [Arg1] Aliemus. Sebelum ronde berakhir, setiap 1 Kartu perintah Celeste di tangan akan membuat 1 Tentakel menyerang musuh dan memulihkan [Heal:Arg2] poin Hidup."
  },
  RelicConfig_71242_Name = {
    Text = "<OrangeQuality:Dimensi·Celeste>"
  },
  RelicConfig_71243_BattleDesc = {
    Text = "Pada awal giliran, Casiah mendapatkan [Arg1] Aliemus. Setiap kali mengambil 1 kartu, Casiah mendapatkan [Arg2] poin Aliemus. Saat Casiah melepaskan Muliakan, semua musuh kehilangan [Arg3] poin Kekuatan."
  },
  RelicConfig_71243_Desc = {
    Text = "Pada awal giliran, Casiah mendapatkan [Arg1] Aliemus. Setiap kali mengambil 1 kartu, Casiah mendapatkan [Arg2] poin Aliemus. Saat Casiah melepaskan Muliakan, semua musuh kehilangan [Arg3] poin Kekuatan."
  },
  RelicConfig_71243_Name = {
    Text = "<OrangeQuality:Dimensi·Casiah>"
  },
  RelicConfig_71244_BattleDesc = {
    Text = "Pada awal giliran, Sorel mendapatkan [Arg1] Aliemus. Setiap kali Sorel memberikan 1 Kerusakan, Fusi Embrio +[Arg2], dan efek ini dapat diaktifkan hingga [Arg3] kali per giliran. Setelah diaktifkan sebanyak 10 kali, Kerusakan akhir Sorel dalam pertempuran ini + [Arg4]%."
  },
  RelicConfig_71244_Desc = {
    Text = "Pada awal giliran, Sorel mendapatkan [Arg1] Aliemus. Setiap kali Sorel memberikan 1 Kerusakan, Fusi Embrio +[Arg2], dan efek ini dapat diaktifkan hingga [Arg3] kali per giliran. Setelah diaktifkan sebanyak 10 kali, Kerusakan akhir Sorel dalam pertempuran ini + [Arg4]%."
  },
  RelicConfig_71244_Name = {
    Text = "<OrangeQuality:Dimensi·Sorel>"
  },
  RelicConfig_71245_BattleDesc = {
    Text = "Di awal giliran, Ogier mendapatkan [Arg1] Kekuatan. Setiap kali orang pertama kali memainkan \"Senjata Tusuk\" atau \"Serangan\" milik Ogier dalam satu giliran, meningkatkan Perisai dan Kekuatan yang dihasilkan oleh Ogier di giliran ini sebesar [Arg2]%."
  },
  RelicConfig_71245_Desc = {
    Text = "Di awal giliran, Ogier mendapatkan [Arg1] Kekuatan. Setiap kali orang pertama kali memainkan \"Senjata Tusuk\" atau \"Serangan\" milik Ogier dalam satu giliran, meningkatkan Perisai dan Kekuatan yang dihasilkan oleh Ogier di giliran ini sebesar [Arg2]%."
  },
  RelicConfig_71245_Name = {
    Text = "<OrangeQuality:Dimensi·Ogier>"
  },
  RelicConfig_71246_BattleDesc = {
    Text = "Pada awal ronde, Alva mendapatkan [Arg1] Aliemus. Jika Alva memainkan kartu \"Pertahanan\" ke-[Arg2] dalam 1 ronde, letakkan kartu \"Mata Pisau Intuisi\" yang ter-Lelah ke tangan; jika memainkan kartu \"Pukulan\" ke-[Arg3], letakkan 1 kartu \"Postur Siaga\" yang ter-Lelah ke tangan."
  },
  RelicConfig_71246_Desc = {
    Text = "Pada awal ronde, Alva mendapatkan [Arg1] Aliemus. Jika Alva memainkan kartu \"Pertahanan\" ke-[Arg2] dalam 1 ronde, letakkan kartu \"Mata Pisau Intuisi\" yang ter-Lelah ke tangan; jika memainkan kartu \"Pukulan\" ke-[Arg3], letakkan 1 kartu \"Postur Siaga\" yang ter-Lelah ke tangan."
  },
  RelicConfig_71246_Name = {
    Text = "<OrangeQuality:Dimensi·Alva>"
  },
  RelicConfig_71247_BattleDesc = {
    Text = "Pada awal ronde, Jenkin mendapatkan [Arg1] Aliemus, kerusakan akhir + [Arg2]%. Pertumbuhan dasar kerusakan dan peningkatan kerusakan dari \"Brown Bergerak\" meningkat sebesar [Arg3]%."
  },
  RelicConfig_71247_Desc = {
    Text = "Pada awal ronde, Jenkin mendapatkan [Arg1] Aliemus, kerusakan akhir + [Arg2]%. Pertumbuhan dasar kerusakan dan peningkatan kerusakan dari \"Brown Bergerak\" meningkat sebesar [Arg3]%."
  },
  RelicConfig_71247_Name = {
    Text = "<OrangeQuality:Dimensi·Jenkin>"
  },
  RelicConfig_71248_BattleDesc = {
    Text = "Pada awal giliran, Doll mendapatkan [Arg1] poin Aliemus. Setelah pertarungan dimulai, ubah konsumsi aritmetika dari \"Timbal balik\" Doll menjadi 0, lalu setelah itu extra ambil [Arg2] kartu di putaran berikutnya."
  },
  RelicConfig_71248_Desc = {
    Text = "Pada awal giliran, Doll mendapatkan [Arg1] poin Aliemus. Setelah pertarungan dimulai, ubah konsumsi aritmetika dari \"Timbal balik\" Doll menjadi 0, lalu setelah itu extra ambil [Arg2] kartu di putaran berikutnya."
  },
  RelicConfig_71248_Name = {
    Text = "<OrangeQuality:Dimensi·Boneka>"
  },
  RelicConfig_71249_BattleDesc = {
    Text = "Pada awal giliran, Ryker mendapatkan [Arg1] Aliemus. Hasil dadu pertama setiap giliran selalu nilai maksimum."
  },
  RelicConfig_71249_Desc = {
    Text = "Pada awal giliran, Ryker mendapatkan [Arg1] Aliemus. Hasil dadu pertama setiap giliran selalu nilai maksimum."
  },
  RelicConfig_71249_Name = {
    Text = "<OrangeQuality:Dimensi·Ryker>"
  },
  RelicConfig_71250_BattleDesc = {
    Text = "Pada awal ronde, Miryam mendapatkan [Arg1] Aliemus dan menaruh 1 kartu \"Sakramen\" ke dalam tangan."
  },
  RelicConfig_71250_Desc = {
    Text = "Pada awal ronde, Miryam mendapatkan [Arg1] Aliemus dan menaruh 1 kartu \"Sakramen\" ke dalam tangan."
  },
  RelicConfig_71250_Name = {
    Text = "<OrangeQuality:Dimensi·Miryam>"
  },
  RelicConfig_71251_BattleDesc = {
    Text = "Pada awal ronde, Kerang memperoleh [Arg1] Aliemus. Setiap kali Pembangun lain melepaskan Muliakan, Kerang akan memperoleh [Arg2] poin Aliemus dan mengurangi Lelah Aritmetika dari kartu \"Rekonstruksi psiko\" di tangan sebesar [Arg3]."
  },
  RelicConfig_71251_Desc = {
    Text = "Pada awal ronde, Kerang memperoleh [Arg1] Aliemus. Setiap kali Pembangun lain melepaskan Muliakan, Kerang akan memperoleh [Arg2] poin Aliemus dan mengurangi Lelah Aritmetika dari kartu \"Rekonstruksi psiko\" di tangan sebesar [Arg3]."
  },
  RelicConfig_71251_Name = {
    Text = "<OrangeQuality:Dimensi·Kerang>"
  },
  RelicConfig_71252_BattleDesc = {
    Text = "Pada awal ronde, Tulu mendapatkan [Arg1] Aliemus. Aliemus dasar Tulu berkurang sebesar [Arg2] poin, dan setelah melepaskan Muliakan, segera menghasilkan [Arg3] Tentakel sementara."
  },
  RelicConfig_71252_Desc = {
    Text = "Pada awal ronde, Tulu mendapatkan [Arg1] Aliemus. Aliemus dasar Tulu berkurang sebesar [Arg2] poin, dan setelah melepaskan Muliakan, segera menghasilkan [Arg3] Tentakel sementara."
  },
  RelicConfig_71252_Name = {
    Text = "<OrangeQuality:Dimensi·Tulu>"
  },
  RelicConfig_71253_BattleDesc = {
    Text = "Pada awal giliran, Pingsan mendapatkan [Arg1] Aliemus. Perisai, Counter, dan pemulihan Hidup yang diberikan oleh Pingsan meningkat sebesar [Arg2]%. Setiap kali Ketahanan terpicu, Efek ini meningkat sebesar [Arg3]% dalam eksplorasi ini, hingga maksimal [Arg4] kali."
  },
  RelicConfig_71253_Desc = {
    Text = "Pada awal giliran, Pingsan mendapatkan [Arg1] Aliemus. Perisai, Counter, dan pemulihan Hidup yang diberikan oleh Pingsan meningkat sebesar [Arg2]%. Setiap kali Ketahanan terpicu, Efek ini meningkat sebesar [Arg3]% dalam eksplorasi ini, hingga maksimal [Arg4] kali."
  },
  RelicConfig_71253_Name = {
    Text = "<OrangeQuality:Dimensi·Pingsan>"
  },
  RelicConfig_71254_BattleDesc = {
    Text = "Pada awal ronde, Tawil mendapatkan [Arg1] Aliemus. Jika dalam satu ronde dimainkan [Arg2] Kartu perintah Tawil, tempatkan 1 kartu <DerivativeCardKeywords_67:「Kunci Perak Cahaya Fajar」> di tangan, dengan cooldown [Arg3] ronde."
  },
  RelicConfig_71254_Desc = {
    Text = "Pada awal ronde, Tawil mendapatkan [Arg1] Aliemus. Jika dalam satu ronde dimainkan [Arg2] Kartu perintah Tawil, tempatkan 1 kartu <DerivativeCardKeywords_67:「Kunci Perak Cahaya Fajar」> di tangan, dengan cooldown [Arg3] ronde."
  },
  RelicConfig_71254_Name = {
    Text = "<OrangeQuality:Dimensi·Tawil>"
  },
  RelicConfig_71255_BattleDesc = {
    Text = "Saat giliran dimulai, Hameln mendapatkan [Arg1] Aliemus. Arithmetica Cost dasar \"Prélude Jiwa\" berkurang [Arg2], jumlah Kerusakan dasar meningkat [Arg3]."
  },
  RelicConfig_71255_Desc = {
    Text = "Saat giliran dimulai, Hameln mendapatkan [Arg1] Aliemus. Arithmetica Cost dasar \"Prélude Jiwa\" berkurang [Arg2], jumlah Kerusakan dasar meningkat [Arg3]."
  },
  RelicConfig_71255_Name = {
    Text = "<OrangeQuality:Dimensi·Hameln>"
  },
  RelicConfig_71256_BattleDesc = {
    Text = "Pada awal ronde, Horla mendapatkan [Arg1] Aliemus. Pada awal pertempuran, dapatkan [Arg2] lapisan metafora dari semua emosi, efek \"Metafora\" meningkat sebesar 50%."
  },
  RelicConfig_71256_Desc = {
    Text = "Pada awal ronde, Horla mendapatkan [Arg1] Aliemus. Pada awal pertempuran, dapatkan [Arg2] lapisan metafora dari semua emosi, efek \"Metafora\" meningkat sebesar 50%."
  },
  RelicConfig_71256_Name = {
    Text = "<OrangeQuality:Dimensi·Horla>"
  },
  RelicConfig_71257_BattleDesc = {
    Text = "Pada awal ronde, Murphy mendapatkan [Arg1] Aliemus. \"Serangan\"dan \"Pertahanan\"Murphy dapat mengubah [Arg2]% \"Pengorbanan\"menjadi kerusakan tentakel sementara, tetapi efek ini hanya berlaku sekali per ronde."
  },
  RelicConfig_71257_Desc = {
    Text = "Pada awal ronde, Murphy mendapatkan [Arg1] Aliemus. \"Serangan\"dan \"Pertahanan\"Murphy dapat mengubah [Arg2]% \"Pengorbanan\"menjadi kerusakan tentakel sementara, tetapi efek ini hanya berlaku sekali per ronde."
  },
  RelicConfig_71257_Name = {
    Text = "<OrangeQuality:Dimensi·Murphy>"
  },
  RelicConfig_71258_BattleDesc = {
    Text = "Di awal giliran, Uvhash mendapat [Arg1] Aliemus. Aliemus dasar Uvhash berkurang [Arg2] poin, setiap kali melepaskan Muliakan, pengurangan tambahan 5 poin, dan dapat melepaskan Muliakan sebanyak [Arg3] kali per giliran."
  },
  RelicConfig_71258_Desc = {
    Text = "Di awal giliran, Uvhash mendapat [Arg1] Aliemus. Aliemus dasar Uvhash berkurang [Arg2] poin, setiap kali melepaskan Muliakan, pengurangan tambahan 5 poin, dan dapat melepaskan Muliakan sebanyak [Arg3] kali per giliran."
  },
  RelicConfig_71258_Name = {
    Text = "<OrangeQuality:Dimensi·Uvhash>"
  },
  RelicConfig_71259_BattleDesc = {
    Text = "Pada awal ronde, Aigis mendapatkan [Arg1] Aliemus. Saat Aigis memberikan kerusakan kepada musuh yang memiliki status rentan, dia juga akan mencuri [Arg2] poin kekuatan sementara dari musuh tersebut, dan efek ini paling banyak dapat diaktifkan [Arg3] kali per ronde."
  },
  RelicConfig_71259_Desc = {
    Text = "Pada awal ronde, Aigis mendapatkan [Arg1] Aliemus. Saat Aigis memberikan kerusakan kepada musuh yang memiliki status rentan, dia juga akan mencuri [Arg2] poin kekuatan sementara dari musuh tersebut, dan efek ini paling banyak dapat diaktifkan [Arg3] kali per ronde."
  },
  RelicConfig_71259_Name = {
    Text = "<OrangeQuality:Dimensi·Aigis>"
  },
  RelicConfig_71260_BattleDesc = {
    Text = "Pada awal ronde, Thais mendapatkan [Arg1] Aliemus. Setelah Thais memainkan [Arg2] Kartu perintah dalam 1 ronde, ia mendapatkan satu \"Anak Suci\" dan [Arg3] poin Kekuatan sementara, dengan cooldown selama [Arg4] ronde."
  },
  RelicConfig_71260_Desc = {
    Text = "Pada awal ronde, Thais mendapatkan [Arg1] Aliemus. Setelah Thais memainkan [Arg2] Kartu perintah dalam 1 ronde, ia mendapatkan satu \"Anak Suci\" dan [Arg3] poin Kekuatan sementara, dengan cooldown selama [Arg4] ronde."
  },
  RelicConfig_71260_Name = {
    Text = "<OrangeQuality:Dimensi·Pikman>"
  },
  RelicConfig_71261_BattleDesc = {
    Text = "Pada awal giliran, Faros mendapatkan [Arg1] Aliemus. Setiap kali memberikan 2 kali Kerusakan Tentakel, tingkatkan Racun dan Perisai yang diberikan oleh Faros dalam Pertempuran ini sebesar [Arg2]%, hingga maksimum 50%."
  },
  RelicConfig_71261_Desc = {
    Text = "Pada awal giliran, Faros mendapatkan [Arg1] Aliemus. Setiap kali memberikan 2 kali Kerusakan Tentakel, tingkatkan Racun dan Perisai yang diberikan oleh Faros dalam Pertempuran ini sebesar [Arg2]%, hingga maksimum 50%."
  },
  RelicConfig_71261_Name = {
    Text = "<OrangeQuality:Dimensi·Faros>"
  },
  RelicConfig_71262_BattleDesc = {
    Text = "Pada awal giliran, Pandia mendapatkan [Arg1] Aliemus. Setelah Pandia melepaskan Muliakan, dia mendapatkan Counter permanen yang setara dengan [Arg2]% Counter sementara."
  },
  RelicConfig_71262_Desc = {
    Text = "Pada awal giliran, Pandia mendapatkan [Arg1] Aliemus. Setelah Pandia melepaskan Muliakan, dia mendapatkan Counter permanen yang setara dengan [Arg2]% Counter sementara."
  },
  RelicConfig_71262_Name = {
    Text = "<OrangeQuality:Dimensi·Pandia>"
  },
  RelicConfig_71263_BattleDesc = {
    Text = "Pada awal giliran, Lily mendapatkan [Arg1] Aliemus. Batas maksimal Bertahan Lily meningkat sebesar 100%. Saat melepaskan \"Bunga Abadi di Tengah Lumpur\" atau \"Serangan Untuk Melindungi\", pulihkan HP sebesar 8% dari jumlah lapisan \"Bertahan\"."
  },
  RelicConfig_71263_Desc = {
    Text = "Pada awal giliran, Lily mendapatkan [Arg1] Aliemus. Batas maksimal Bertahan Lily meningkat sebesar 100%. Saat melepaskan \"Bunga Abadi di Tengah Lumpur\" atau \"Serangan Untuk Melindungi\", pulihkan HP sebesar 8% dari jumlah lapisan \"Bertahan\"."
  },
  RelicConfig_71263_Name = {
    Text = "<OrangeQuality:Dimensi·Lily>"
  },
  RelicConfig_71264_BattleDesc = {
    Text = "Pada awal ronde, Karen mendapatkan [Arg1] Aliemus. Memainkan \"Diam Menunggu\" akan mengembalikan dua kali lipat Aritmetika yang Lelah, dengan cooldown selama [Arg2] ronde."
  },
  RelicConfig_71264_Desc = {
    Text = "Pada awal ronde, Karen mendapatkan [Arg1] Aliemus. Memainkan \"Diam Menunggu\" akan mengembalikan dua kali lipat Aritmetika yang Lelah, dengan cooldown selama [Arg2] ronde."
  },
  RelicConfig_71264_Name = {
    Text = "<OrangeQuality:Dimensi·Karen>"
  },
  RelicConfig_71265_BattleDesc = {
    Text = "Pada awal giliran, Salvador mendapatkan [Arg1] poin Aliemus. Setiap kali mengumpulkan Dapur Merah, ia juga akan mendapatkan [Arg2]% dari jumlah yang terkumpul sebagai Kekuatan. \"Serangan\" dan \"Akhir penderitaan\" Salvador menikmati penambahan [Arg3] kali ekstra Kekuatan."
  },
  RelicConfig_71265_Desc = {
    Text = "Pada awal giliran, Salvador mendapatkan [Arg1] poin Aliemus. Setiap kali mengumpulkan Dapur Merah, ia juga akan mendapatkan [Arg2]% dari jumlah yang terkumpul sebagai Kekuatan. \"Serangan\" dan \"Akhir penderitaan\" Salvador menikmati penambahan [Arg3] kali ekstra Kekuatan."
  },
  RelicConfig_71265_Name = {
    Text = "<OrangeQuality:Dimensi·Salvador>"
  },
  RelicConfig_71266_BattleDesc = {
    Text = "Pada awal giliran, Caecus mendapatkan [Arg1] Aliemus. Saat Caecus mendapatkan Perisai, ia memulihkan [Arg2]% dari jumlah Perisai sebagai Hidup."
  },
  RelicConfig_71266_Desc = {
    Text = "Pada awal giliran, Caecus mendapatkan [Arg1] Aliemus. Saat Caecus mendapatkan Perisai, ia memulihkan [Arg2]% dari jumlah Perisai sebagai Hidup."
  },
  RelicConfig_71266_Name = {
    Text = "<OrangeQuality:Dimensi·Caecus>"
  },
  RelicConfig_71267_BattleDesc = {
    Text = "Pada awal giliran, Nymphaea mendapatkan [Arg1] Aliemus. Setelah memainkan \"Serangan\" Nymphaea, Racun yang diberikan oleh \"Nymphaea\" dalam pertempuran ini meningkat sebesar [Arg2]%. Setelah memainkan \"Pertahanan\" Nymphaea, semua musuh akan terkena [Arg3]% Racun. Setiap efek hanya dapat diaktifkan sekali per giliran."
  },
  RelicConfig_71267_Desc = {
    Text = "Pada awal giliran, Nymphaea mendapatkan [Arg1] Aliemus. Setelah memainkan \"Serangan\" Nymphaea, Racun yang diberikan oleh \"Nymphaea\" dalam pertempuran ini meningkat sebesar [Arg2]%. Setelah memainkan \"Pertahanan\" Nymphaea, semua musuh akan terkena [Arg3]% Racun. Setiap efek hanya dapat diaktifkan sekali per giliran."
  },
  RelicConfig_71267_Name = {
    Text = "<OrangeQuality:Dimensi·Nymphaea>"
  },
  RelicConfig_71268_BattleDesc = {
    Text = "Pada awal ronde, Erica mendapatkan [Arg1] Aliemus. Setelah Erica memainkan [Arg2] Kartu perintah dalam 1 ronde, dia mendapatkan 2 poin Aritmetika dan meningkatkan bonus Kekuatan serta Waspada untuk \"Ledakan Elektromagnetik\" sebesar dua kali lipat selama pertempuran ini."
  },
  RelicConfig_71268_Desc = {
    Text = "Pada awal ronde, Erica mendapatkan [Arg1] Aliemus. Setelah Erica memainkan [Arg2] Kartu perintah dalam 1 ronde, dia mendapatkan 2 poin Aritmetika dan meningkatkan bonus Kekuatan serta Waspada untuk \"Ledakan Elektromagnetik\" sebesar dua kali lipat selama pertempuran ini."
  },
  RelicConfig_71268_Name = {
    Text = "<OrangeQuality:Dimensi·Erica>"
  },
  RelicConfig_71269_BattleDesc = {
    Text = "Pada awal ronde, Goliath mendapatkan [Arg1] Aliemus. Jika Goliath memberikan kerusakan sebanyak [Arg2] kali dalam 1 ronde, kerusakan yang diberikan oleh Goliath di pertempuran ini akan mendapatkan tambahan 1 kali kekuatan, dengan cooldown selama 3 ronde."
  },
  RelicConfig_71269_Desc = {
    Text = "Pada awal ronde, Goliath mendapatkan [Arg1] Aliemus. Jika Goliath memberikan kerusakan sebanyak [Arg2] kali dalam 1 ronde, kerusakan yang diberikan oleh Goliath di pertempuran ini akan mendapatkan tambahan 1 kali kekuatan, dengan cooldown selama 3 ronde."
  },
  RelicConfig_71269_Name = {
    Text = "<OrangeQuality:Dimensi·Goliath>"
  },
  RelicConfig_71270_BattleDesc = {
    Text = "Pada awal ronde, Sanga mendapatkan [Arg1] Aliemus. Pada awal pertempuran, semua Kartu perintah Sanga diberikan status tersimpan, siap 1, dan mendapatkan [Arg2] poin Perisai."
  },
  RelicConfig_71270_Desc = {
    Text = "Pada awal ronde, Sanga mendapatkan [Arg1] Aliemus. Pada awal pertempuran, semua Kartu perintah Sanga diberikan status tersimpan, siap 1, dan mendapatkan [Arg2] poin Perisai."
  },
  RelicConfig_71270_Name = {
    Text = "<OrangeQuality:Dimensi·Sanga>"
  },
  RelicConfig_71662_BattleDesc = {
    Text = "Pada awal ronde genap, tambahkan 1 kartu <DerivativeCardKeywords_105:\"Perak Tak Berujung\"> ke tangan."
  },
  RelicConfig_71662_Desc = {
    Text = "Pada awal ronde genap, tambahkan 1 kartu <DerivativeCardKeywords_105:\"Perak Tak Berujung\"> ke tangan."
  },
  RelicConfig_71662_Name = {
    Text = "<OrangeQuality:Harta Karun Kucing>"
  },
  RelicConfig_72226_BattleDesc = {
    Text = "Batas tangan +1. Pada awal giliran jika saat ini tidak melakukan penelitian, pilih satu penelitian yang belum dilakukan, setelah menyelesaikan penelitian, dapatkan hasil penelitian yang sesuai dari Melted·Boneka. Setelah menyelesaikan 3 penelitian, letakkan \"Akhir Ilusi\" ke tangan, artefak ini tidak aktif."
  },
  RelicConfig_72226_Desc = {
    Text = "Batas tangan +1. Pada awal giliran jika saat ini tidak melakukan penelitian, pilih satu penelitian yang belum dilakukan, setelah menyelesaikan penelitian, dapatkan hasil penelitian yang sesuai dari Melted·Boneka. Setelah menyelesaikan 3 penelitian, letakkan \"Akhir Ilusi\" ke tangan, artefak ini tidak aktif."
  },
  RelicConfig_72226_Name = {
    Text = "Manuskrip Penelitian Akhir Zaman"
  },
  RelicConfig_74832_BattleDesc = {
    Text = "Batas tangan +1. Pada awal giliran, dapatkan 1 kartu “Perdagangan Terlarang” yang disesuaikan, setelah memainkan kartu “Perdagangan Terlarang” dapat diaktifkan lagi di giliran berikutnya. Saat memegang “Perdagangan Terlarang”, memainkan jenis kartu instruksi yang berbeda akan meningkatkan efek yang sesuai."
  },
  RelicConfig_74832_Desc = {
    Text = "Batas tangan +1. Pada awal giliran, dapatkan 1 kartu “Perdagangan Terlarang” yang disesuaikan, setelah memainkan kartu “Perdagangan Terlarang” dapat diaktifkan lagi di giliran berikutnya. Saat memegang “Perdagangan Terlarang”, memainkan jenis kartu instruksi yang berbeda akan meningkatkan efek yang sesuai."
  },
  RelicConfig_74832_Name = {
    Text = "Undangan Berwajah Seribu"
  },
  RelicConfig_74832_StoryDesc = {
    Text = "Tulisan di surat terus berubah, selalu menjadi hasrat yang tidak bisa ditolak."
  },
  RelicConfig_78664_BattleDesc = {
    Text = "Setelah memainkan 4 Kartu Perintah yang berasal dari Pembangun berbeda dalam satu putaran, tingkatkan kerusakan akhir yang diberikan oleh semua Pembangun di putaran ini sebesar [Arg1]%, dan kehilangan [Arg2] poin Aliemus. Efek ini hanya dapat diaktifkan sekali per putaran."
  },
  RelicConfig_78664_Desc = {
    Text = "Setelah memainkan 4 Kartu Perintah yang berasal dari Pembangun berbeda dalam satu putaran, tingkatkan kerusakan akhir yang diberikan oleh semua Pembangun di putaran ini sebesar [Arg1]%, dan kehilangan [Arg2] poin Aliemus. Efek ini hanya dapat diaktifkan sekali per putaran."
  },
  RelicConfig_78664_Name = {
    Text = "<RedQuality:Cakar Aneh>"
  },
  RelicConfig_78664_StoryDesc = {
    Text = "Spesies yang sulit dikenali."
  },
  RelicConfig_78665_BattleDesc = {
    Text = "Pada awal ronde, kurangi pengambilan sebanyak [Arg1] kartu. Setiap kali memainkan 1 kartu dengan konsumsi Lelah aktual lebih besar atau sama dengan [Arg2], dapatkan 1 poin Aritmetika, setiap ronde maksimal dipicu [Arg3] kali."
  },
  RelicConfig_78665_Desc = {
    Text = "Pada awal ronde, kurangi pengambilan sebanyak [Arg1] kartu. Setiap kali memainkan 1 kartu dengan konsumsi Lelah aktual lebih besar atau sama dengan [Arg2], dapatkan 1 poin Aritmetika, setiap ronde maksimal dipicu [Arg3] kali."
  },
  RelicConfig_78665_Name = {
    Text = "<RedQuality:Lonceng Ratapan>"
  },
  RelicConfig_78665_StoryDesc = {
    Text = [[
Ting, ting, anak menangis;
Ting, ting, anak berteriak.
Ting, ting, anak meratap;
Ting, ting, ia lapar, kau tahu.]]
  },
  RelicConfig_78666_BattleDesc = {
    Text = "Pada awal ronde, dapatkan [Arg1] poin Counter. Setelah melepaskan Muliakan sebanyak [Arg2] kali dalam satu ronde, hapus [Arg3]% Counter permanen milik sendiri, dapatkan Counter sementara sebesar [Arg4]% dari jumlah yang dihapus, dengan cooldown selama [Arg5] ronde."
  },
  RelicConfig_78666_Desc = {
    Text = "Pada awal ronde, dapatkan [Arg1] poin Counter. Setelah melepaskan Muliakan sebanyak [Arg2] kali dalam satu ronde, hapus [Arg3]% Counter permanen milik sendiri, dapatkan Counter sementara sebesar [Arg4]% dari jumlah yang dihapus, dengan cooldown selama [Arg5] ronde."
  },
  RelicConfig_78666_Name = {
    Text = "<RedQuality:Rangka Perjalanan>"
  },
  RelicConfig_78666_StoryDesc = {
    Text = [[
Sebagian dari yang suci. 
 Meskipun terpisah dari tubuh utama, jejaknya telah menyebar ke seluruh penjuru dunia.]]
  },
  RelicConfig_78667_BattleDesc = {
    Text = "Setelah fase menggambar kartu, tarik [Arg1] kartu tambahan dan pilih [Arg2] kartu di tangan untuk dibuang."
  },
  RelicConfig_78667_Desc = {
    Text = "Setelah fase menggambar kartu, tarik [Arg1] kartu tambahan dan pilih [Arg2] kartu di tangan untuk dibuang."
  },
  RelicConfig_78667_Name = {
    Text = "<RedQuality:Topi ajaib>"
  },
  RelicConfig_78667_StoryDesc = {
    Text = [[
Selamat datang di sirkus negeri ajaib Nyonya Casiah! Hati-hati, jangan sembarangan menyentuh alat sihir ya. Jika tidak sengaja tergigit, itu bisa menjadi masalah. 
Bagaimanapun, akibatnya sangat horor ketika ia merasakan darah terakhir kali. 

Topi tinggi berkedip, seolah-olah siap untuk keluar dari kepompong kapan saja.]]
  },
  RelicConfig_78668_BattleDesc = {
    Text = "Setelah menggunakan Keyflare Rouse, pilih [Arg1] Kartu Perintah Tidak Turunan dari Tubuh Terjaga yang sesuai untuk dikonsumsi, lalu tempatkan [Arg2] Salinan Primitif yang dikonsumsi secara tambahan masing-masing ke dalam Menggambar, Hand, dan Discard Pile."
  },
  RelicConfig_78668_Desc = {
    Text = "Setelah menggunakan Keyflare Rouse, pilih [Arg1] Kartu Perintah Tidak Turunan dari Tubuh Terjaga yang sesuai untuk dikonsumsi, lalu tempatkan [Arg2] Salinan Primitif yang dikonsumsi secara tambahan masing-masing ke dalam Menggambar, Hand, dan Discard Pile."
  },
  RelicConfig_78668_Name = {
    Text = "<RedQuality:Prasasti Giok Hijau>"
  },
  RelicConfig_78668_StoryDesc = {
    Text = "Cetakan ini akan tetap abadi selama ribuan tahun."
  },
  RelicConfig_78669_BattleDesc = {
    Text = "Pada awal Pertempuran, mendapatkan [Arg1] poin Kekuatan. Pada awal giliran, untuk setiap [Arg2] poin Kekuatan Permanen, dapatkan [Arg3] poin Kekuatan Sementara, maksimal dapatkan [Arg4] poin Kekuatan Sementara, dan pada akhir giliran, kehilangan setengah dari Perisai yang didapat dari Kekuatan Sementara yang diberikan oleh Relik ini."
  },
  RelicConfig_78669_Desc = {
    Text = "Pada awal Pertempuran, mendapatkan [Arg1] poin Kekuatan. Pada awal giliran, untuk setiap [Arg2] poin Kekuatan Permanen, mendapatkan [Arg3] poin Kekuatan Sementara, maksimal mendapatkan [Arg4] poin Kekuatan Sementara, dan pada akhir giliran kehilangan setengah dari Perisai yang didapat dari Kekuatan Sementara oleh Relik ini."
  },
  RelicConfig_78669_Name = {
    Text = "<RedQuality:Burung Upacara Kutukan>"
  },
  RelicConfig_78669_StoryDesc = {
    Text = "Mayat yang kering mengeluarkan suara berdering."
  },
  RelicConfig_78670_BattleDesc = {
    Text = "Kerusakan dasar semua Pembangun meningkat sebesar [Arg1]%, setiap kali mengatur ulang dek kartu akan memberikan tambahan peningkatan sebesar [Arg2]%, tetapi 1 kartu \"Tertatih\" akan dimasukkan ke tangan. Nilai peningkatan maksimal adalah [Arg3]%."
  },
  RelicConfig_78670_Desc = {
    Text = "Kerusakan dasar semua Pembangun meningkat sebesar [Arg1]%, setiap kali mengatur ulang dek kartu akan memberikan tambahan peningkatan sebesar [Arg2]%, tetapi 1 kartu \"Tertatih\" akan dimasukkan ke tangan. Nilai peningkatan maksimal adalah [Arg3]%."
  },
  RelicConfig_78670_Name = {
    Text = "<RedQuality:Lilin hitam>"
  },
  RelicConfig_78670_StoryDesc = {
    Text = "Terbakar dalam kesadaran, jatuh ke dalam kehampaan."
  },
  RelicConfig_78671_BattleDesc = {
    Text = "Pada awal ronde, Fusi Embrio+ [Arg1],\"Embrio\" milikmu akan dibuang pada akhir ronde."
  },
  RelicConfig_78671_Desc = {
    Text = "Pada awal ronde, Fusi Embrio+ [Arg1],\"Embrio\" milikmu akan dibuang pada akhir ronde."
  },
  RelicConfig_78671_Name = {
    Text = "<RedQuality:Umbilical Cord yang Berdenyut>"
  },
  RelicConfig_78671_StoryDesc = {
    Text = "Jalinan di leher."
  },
  RelicConfig_78672_BattleDesc = {
    Text = "Pada awal giliran, terkena [Arg2] lapisan Racun, di ruang Ultra setiap satu tempat kosong mendapatkan [Arg1] poin Kekuatan."
  },
  RelicConfig_78672_Desc = {
    Text = "Pada awal giliran, terkena [Arg2] lapisan Racun, di ruang Ultra setiap satu tempat kosong mendapatkan [Arg1] poin Kekuatan."
  },
  RelicConfig_78672_Name = {
    Text = "<RedQuality:Kesadaran Kumpulan Serangga>"
  },
  RelicConfig_78672_StoryDesc = {
    Text = "Jalinan, simbiosis, berkelompok; ketakutan, yang tidak diketahui, kontrol."
  },
  RelicConfig_78673_BattleDesc = {
    Text = "Setelah bangkit kunci perak, tambahan lelah [Arg1] poin energi-s, membuat konsumsi aritmetika kartu membangkitkan gnosis menjadi 0, dan setelah dimainkan memberikan pembangun yang sesuai tambahan [Arg2] poin aliemus."
  },
  RelicConfig_78673_Desc = {
    Text = "Setelah bangkit kunci perak, tambahan lelah [Arg1] poin energi-s, membuat konsumsi aritmetika kartu membangkitkan gnosis menjadi 0, dan setelah dimainkan memberikan pembangun yang sesuai tambahan [Arg2] poin aliemus."
  },
  RelicConfig_78673_Name = {
    Text = "<RedQuality:UkiranKesadaran>"
  },
  RelicConfig_78673_StoryDesc = {
    Text = "Suku kuno percaya bahwa dengan mengukir simbol-simbol khusus pada tengkorak orang mati, jiwa mereka dapat tinggal dan memberikan pendampingan abadi."
  },
  RelicConfig_78674_BattleDesc = {
    Text = "Pada awal pertempuran, semua musuh menerima [Arg1] poin Racun. Pada awal giliran, hilangkan [Arg2]% Racun dari musuh dan berikan [Arg3]% dari jumlah yang dihilangkan sebagai Berdarah."
  },
  RelicConfig_78674_Desc = {
    Text = "Pada awal pertempuran, semua musuh menerima [Arg1] poin Racun. Pada awal giliran, hilangkan [Arg2]% Racun dari musuh dan berikan [Arg3]% dari jumlah yang dihilangkan sebagai Berdarah."
  },
  RelicConfig_78674_Name = {
    Text = "<RedQuality:Anggota Bantuan>"
  },
  RelicConfig_78674_StoryDesc = {
    Text = [[
Sebagian dari kesakralan.
Meskipun terpisah dari tubuh, kehangatan di atasnya masih dapat dirasakan.]]
  },
  RelicConfig_78675_BattleDesc = {
    Text = "Pada awal ronde, jika terdapat lebih dari [Arg1] Tentakel permanen, kehilangan [Arg2] Tentakel permanen untuk mendapatkan [Arg3] Tentakel sementara. Jika tidak, dapatkan [Arg4] Tentakel permanen."
  },
  RelicConfig_78675_Desc = {
    Text = "Pada awal ronde, jika terdapat lebih dari [Arg1] Tentakel permanen, kehilangan [Arg2] Tentakel permanen untuk mendapatkan [Arg3] Tentakel sementara. Jika tidak, dapatkan [Arg4] Tentakel permanen."
  },
  RelicConfig_78675_Name = {
    Text = "<RedQuality:Pergelangan Suci Penderitaan>"
  },
  RelicConfig_78675_StoryDesc = {
    Text = "Rasakan penderitaan."
  },
  RelicConfig_79408_BattleDesc = {
    Text = "Batas atas kartu di tangan + 2, jumlah menggambar +2, \"Kenangan Jelas\" dimulai dari 5 lapisan, memainkan kartu dengan tanda akan mengubah \"Kenangan Jelas.\" Jika \"Kenangan Jelas\" kurang dari 5, setiap 1 poin yang lebih rendah meningkatkan kerusakan akhir sebesar 10%, perisai dan pemulihan hidup turun 5%; jika \"Kenangan Jelas\" lebih dari 5, setiap 1 poin yang lebih tinggi meningkatkan perisai dan pemulihan hidup sebesar 5%, kerusakan akhir -10%."
  },
  RelicConfig_79408_Desc = {
    Text = "Batas atas kartu di tangan + 2, jumlah menggambar +2, \"Kenangan Jelas\" dimulai dari 5 lapisan, memainkan kartu dengan tanda akan mengubah \"Kenangan Jelas.\" Jika \"Kenangan Jelas\" kurang dari 5, setiap 1 poin yang lebih rendah meningkatkan kerusakan akhir sebesar 10%, perisai dan pemulihan hidup turun 5%; jika \"Kenangan Jelas\" lebih dari 5, setiap 1 poin yang lebih tinggi meningkatkan perisai dan pemulihan hidup sebesar 5%, kerusakan akhir -10%."
  },
  RelicConfig_79408_Name = {
    Text = "\"Memori\" dan \"Mimpi\""
  },
  RelicConfig_79408_StoryDesc = {
    Text = [[
"Ayo, dengarkan aku."
 "Biarkan aku menggabungkan ingatanmu dan mimpimu."
 "Menjadi kue yang sangat lezat."]]
  },
  RelicConfig_80340_BattleDesc = {
    Text = "Saat giliran dimulai, Clementine mendapatkan [Arg1] Aliemus. Semua Kartu perintah Clementine meningkatkan jumlah efek pada kerusakan, perisai, penyembuhan, mendapatkan Aliemus, dan mendapatkan energi-s kunci perak sebanyak 1."
  },
  RelicConfig_80340_Desc = {
    Text = "Saat giliran dimulai, Clementine mendapatkan [Arg1] Aliemus. Semua Kartu perintah Clementine meningkatkan jumlah efek pada kerusakan, perisai, penyembuhan, mendapatkan Aliemus, dan mendapatkan energi-s kunci perak sebanyak 1."
  },
  RelicConfig_80340_Name = {
    Text = "<OrangeQuality:Gambar Dimensi·Klementin>"
  },
  RelicConfig_83509_BattleDesc = {
    Text = "Saat eksplorasi dimulai, batas pencipta meningkat +1, Pembangun di Ranah \"Aequor\" mendapatkan \"Citra Dimensi\" mereka. Setiap memiliki 1 Pembangun di Ranah \"Aequor\" dalam tim, batas pencipta meningkat +1."
  },
  RelicConfig_83509_Desc = {
    Text = "Saat eksplorasi dimulai, batas pencipta meningkat +1, Pembangun di Ranah \"Aequor\" mendapatkan \"Citra Dimensi\" mereka. Setiap memiliki 1 Pembangun di Ranah \"Aequor\" dalam tim, batas pencipta meningkat +1."
  },
  RelicConfig_83509_Name = {
    Text = "<OrangeQuality:\"Roda Sinyal Laut Dalam\">"
  },
  RelicConfig_83509_StoryDesc = {
    Text = "Yang tertidur di lautan jurang mulai menunjukkan otoritas yang terlupakan kepada dunia."
  },
  RelicConfig_83510_BattleDesc = {
    Text = "Saat eksplorasi dimulai, batas pencipta meningkat +1, Pembangun di Ranah \"Caro\" mendapatkan \"Citra Dimensi\" mereka. Setiap memiliki 1 Pembangun di Ranah \"Caro\" dalam tim, batas pencipta meningkat +1."
  },
  RelicConfig_83510_Desc = {
    Text = "Saat eksplorasi dimulai, batas pencipta meningkat +1, Pembangun di Ranah \"Caro\" mendapatkan \"Citra Dimensi\" mereka. Setiap memiliki 1 Pembangun di Ranah \"Caro\" dalam tim, batas pencipta meningkat +1."
  },
  RelicConfig_83510_Name = {
    Text = "<OrangeQuality:\"Roda Caro\">"
  },
  RelicConfig_83510_StoryDesc = {
    Text = "Dari yang tidak berdaya, telah terbangkitkan."
  },
  RelicConfig_83511_BattleDesc = {
    Text = "Saat eksplorasi dimulai, batas pencipta meningkat +1, Pembangun di Ranah \"Ultra\" mendapatkan \"Citra Dimensi\" mereka. Setiap memiliki 1 Pembangun di Ranah \"Ultra\" dalam tim, batas pencipta meningkat +1."
  },
  RelicConfig_83511_Desc = {
    Text = "Saat eksplorasi dimulai, batas pencipta meningkat +1, Pembangun di Ranah \"Ultra\" mendapatkan \"Citra Dimensi\" mereka. Setiap memiliki 1 Pembangun di Ranah \"Ultra\" dalam tim, batas pencipta meningkat +1."
  },
  RelicConfig_83511_Name = {
    Text = "<OrangeQuality:\"Roda Ultra\">"
  },
  RelicConfig_83511_StoryDesc = {
    Text = "Dimensi tanpa akhir bertumpuk, saat ini ‘aku’ sudah lengkap tanpa batas."
  },
  RelicConfig_83512_BattleDesc = {
    Text = "Saat eksplorasi dimulai, batas pencipta meningkat +1, Pembangun di Ranah \"Kekacauan\" mendapatkan \"Citra Dimensi\" mereka. Setiap memiliki 1 Pembangun di Ranah \"Kekacauan\" dalam tim, batas pencipta meningkat +1."
  },
  RelicConfig_83512_Desc = {
    Text = "Saat eksplorasi dimulai, batas pencipta meningkat +1, Pembangun di Ranah \"Kekacauan\" mendapatkan \"Citra Dimensi\" mereka. Setiap memiliki 1 Pembangun di Ranah \"Kekacauan\" dalam tim, batas pencipta meningkat +1."
  },
  RelicConfig_83512_Name = {
    Text = "<OrangeQuality:\"Roda Kekacauan\">"
  },
  RelicConfig_83512_StoryDesc = {
    Text = "Kekacauan tak berbentuk, kekacauan tak berwujud, kekacauan telah menyatu dengan segala sesuatu di dunia ini."
  },
  RelicConfig_83606_BattleDesc = {
    Text = [[
Batas kartu tertahan +1. Jika tidak memiliki "Keputusan Navigator" pada awal giliran, masukkan ke dalam tangan.
Setiap kali pemimpin kehilangan 10% dari kesehatan maksimum awalnya, dapatkan 1 lapisan "Layar Berkibar", batas 10 lapisan, "Layar Berkibar" dapat meningkatkan efek "Menerjang Ombak".
Setiap kali diri kehilangan 10% dari kesehatan maksimum awalnya, dapatkan 1 lapisan "Tambatan", batas 10 lapisan, "Tambatan" dapat meningkatkan efek "Menambat Istirahat".]]
  },
  RelicConfig_83606_Desc = {
    Text = [[
Batas kartu tertahan +1. Jika tidak memiliki "Keputusan Navigator" pada awal giliran, masukkan ke dalam tangan.
Setiap kali pemimpin kehilangan 10% dari kesehatan maksimum awalnya, dapatkan 1 lapisan "Layar Berkibar", batas 10 lapisan, "Layar Berkibar" dapat meningkatkan efek "Menerjang Ombak".
Setiap kali diri kehilangan 10% dari kesehatan maksimum awalnya, dapatkan 1 lapisan "Tambatan", batas 10 lapisan, "Tambatan" dapat meningkatkan efek "Menambat Istirahat".]]
  },
  RelicConfig_83606_Name = {
    Text = "Panduan Erasmus"
  },
  RelicConfig_83606_StoryDesc = {
    Text = "Cahaya kilat akan menunjukkan arah untuk maju."
  },
  RelicConfig_84112_BattleDesc = {
    Text = "Pada awal ronde, Agrippa mendapatkan [Arg1] Aliemus. \"Sedekah yang Tidak Sabar\"juga akan mengurangi Lelah Aritmetika Agrippa dalam ronde ini sebesar [Arg2], dan efek ini hanya dapat aktif sekali per ronde."
  },
  RelicConfig_84112_Desc = {
    Text = "Pada awal ronde, Agrippa mendapatkan [Arg1] Aliemus. \"Sedekah yang Tidak Sabar\"juga akan mengurangi Lelah Aritmetika Agrippa dalam ronde ini sebesar [Arg2], dan efek ini hanya dapat aktif sekali per ronde."
  },
  RelicConfig_84112_Name = {
    Text = "<OrangeQuality:Dimensi·Agrippa>"
  },
  RelicConfig_84113_BattleDesc = {
    Text = "Saat giliran dimulai, Caraboo mendapatkan [Arg1] Aliemus. Setiap kali Caraboo <FaxianKeywords:Temuan> <DerivativeCardKeywords_152:\"Berkat\">, muncul 1 pilihan tambahan, Exalt menyebabkan <Corrosion:Corrosion> dengan jumlah kerusakan yang setara."
  },
  RelicConfig_84113_Desc = {
    Text = "Saat giliran dimulai, Caraboo mendapatkan [Arg1] Aliemus. Setiap kali Caraboo <FaxianKeywords:Temuan> <DerivativeCardKeywords_152:\"Berkat\">, muncul 1 pilihan tambahan, Exalt menyebabkan <Corrosion:Corrosion> dengan jumlah kerusakan yang setara."
  },
  RelicConfig_84113_Name = {
    Text = "<OrangeQuality:Gambar Dimensi·Caraboo>"
  },
  RelicConfig_84114_BattleDesc = {
    Text = "Pada awal ronde, Pikman mendapatkan [Arg1] Aliemus. Setiap mendapatkan 1 lapis \"Kreativitas\", secara acak mengurangi 1 konsumsi daya komputasi kartu tangan pada ronde ini sebesar 1. Saat Pikman mengonsumsi \"Kreativitas\", semua Awakener tambahan mendapatkan [Arg2] poin Aliemus."
  },
  RelicConfig_84114_Desc = {
    Text = "Pada awal ronde, Pikman mendapatkan [Arg1] Aliemus. Setiap mendapatkan 1 lapis \"Kreativitas\", secara acak mengurangi 1 konsumsi daya komputasi kartu tangan pada ronde ini sebesar 1. Saat Pikman mengonsumsi \"Kreativitas\", semua Awakener tambahan mendapatkan [Arg2] poin Aliemus."
  },
  RelicConfig_84114_Name = {
    Text = "<OrangeQuality:Dimensi·Pikman>"
  },
  RelicConfig_84116_BattleDesc = {
    Text = "Pada awal ronde, Erica mendapatkan [Arg1] Aliemus. Setelah Erica memainkan [Arg2] Kartu perintah dalam 1 ronde, dia mendapatkan 2 poin Aritmetika dan meningkatkan bonus Kekuatan serta Waspada untuk \"Ledakan Elektromagnetik\" sebesar dua kali lipat selama pertempuran ini."
  },
  RelicConfig_84116_Desc = {
    Text = "Pada awal ronde, Erica mendapatkan [Arg1] Aliemus. Setelah Erica memainkan [Arg2] Kartu perintah dalam 1 ronde, dia mendapatkan 2 poin Aritmetika dan meningkatkan bonus Kekuatan serta Waspada untuk \"Ledakan Elektromagnetik\" sebesar dua kali lipat selama pertempuran ini."
  },
  RelicConfig_84116_Name = {
    Text = "<OrangeQuality:Dimensi·Erica>"
  },
  RelicConfig_84117_BattleDesc = {
    Text = "Pada awal ronde, Sanga·Murphy mendapatkan [Arg1] Aliemus.\"Waltz Spiral\" setiap pelepasan ke-3 akan aktif 3 kali."
  },
  RelicConfig_84117_Desc = {
    Text = "Pada awal ronde, Sanga·Murphy mendapatkan [Arg1] Aliemus.\"Waltz Spiral\" setiap pelepasan ke-3 akan aktif 3 kali."
  },
  RelicConfig_84117_Name = {
    Text = "<OrangeQuality:Dimensi·Sanga·Murphy>"
  },
  RelicConfig_84118_BattleDesc = {
    Text = "Pada awal giliran, Casiah mendapatkan [Arg1] Aliemus. Setiap kali mengambil 1 kartu, Casiah mendapatkan [Arg2] poin Aliemus. Saat Casiah melepaskan Muliakan, semua musuh kehilangan [Arg3] poin Kekuatan."
  },
  RelicConfig_84118_Desc = {
    Text = "Pada awal giliran, Casiah mendapatkan [Arg1] Aliemus. Setiap kali mengambil 1 kartu, Casiah mendapatkan [Arg2] poin Aliemus. Saat Casiah melepaskan Muliakan, semua musuh kehilangan [Arg3] poin Kekuatan."
  },
  RelicConfig_84118_Name = {
    Text = "<OrangeQuality:Dimensi·Casiah>"
  },
  RelicConfig_84119_BattleDesc = {
    Text = "Pada awal ronde, Murphy mendapatkan [Arg1] Aliemus. \"Serangan\"dan \"Pertahanan\"Murphy dapat mengubah [Arg2]% \"Pengorbanan\"menjadi kerusakan tentakel sementara, tetapi efek ini hanya berlaku sekali per ronde."
  },
  RelicConfig_84119_Desc = {
    Text = "Pada awal ronde, Murphy mendapatkan [Arg1] Aliemus. \"Serangan\"dan \"Pertahanan\"Murphy dapat mengubah [Arg2]% \"Pengorbanan\"menjadi kerusakan tentakel sementara, tetapi efek ini hanya berlaku sekali per ronde."
  },
  RelicConfig_84119_Name = {
    Text = "<OrangeQuality:Dimensi·Murphy>"
  },
  RelicConfig_84121_BattleDesc = {
    Text = "Pada awal ronde, Arachne mendapatkan [Arg1] Kegilaan. \"Pukulan\" dan \"Pertahanan\" segera memicu 1 kali \"Benang Tanpa Akhir\", masing-masing berlaku maksimal 1 kali per putaran."
  },
  RelicConfig_84121_Desc = {
    Text = "Pada awal ronde, Arachne mendapatkan [Arg1] Kegilaan. \"Pukulan\" dan \"Pertahanan\" segera memicu 1 kali \"Benang Tanpa Akhir\", masing-masing berlaku maksimal 1 kali per putaran."
  },
  RelicConfig_84121_Name = {
    Text = "<OrangeQuality:Gambar Dimensi·Arachne>"
  },
  RelicConfig_84122_BattleDesc = {
    Text = "Pada awal ronde, Tulu mendapatkan [Arg1] Aliemus. Konsumsi Lelah Aliemus Tulu berkurang sebesar [Arg2] poin, dan setelah melepaskan Muliakan, segera menghasilkan [Arg3] Tentakel sementara."
  },
  RelicConfig_84122_Desc = {
    Text = "Pada awal ronde, Tulu mendapatkan [Arg1] Aliemus. Konsumsi Lelah Aliemus Tulu berkurang sebesar [Arg2] poin, dan setelah melepaskan Muliakan, segera menghasilkan [Arg3] Tentakel sementara."
  },
  RelicConfig_84122_Name = {
    Text = "<OrangeQuality:Dimensi·Tulu>"
  },
  RelicConfig_84123_BattleDesc = {
    Text = "Pada awal ronde, Pollux mendapatkan [Arg1] Aliemus. Pada awal pertempuran, dapatkan 1 \"Hati Suci\". Saat \"Hati Suci\" dikonsumsi karena dimainkan ke-3 kalinya, memberikan Rentan pada semua musuh dan memberikan 2 kali Kerusakan."
  },
  RelicConfig_84123_Desc = {
    Text = "Pada awal ronde, Pollux mendapatkan [Arg1] Aliemus. Pada awal pertempuran, dapatkan 1 \"Hati Suci\". Saat \"Hati Suci\" dikonsumsi karena dimainkan ke-3 kalinya, memberikan Rentan pada semua musuh dan memberikan 2 kali Kerusakan."
  },
  RelicConfig_84123_Name = {
    Text = "<OrangeQuality:Dimensi·Pollux>"
  },
  RelicConfig_84124_BattleDesc = {
    Text = "Pada awal giliran, Hameln mendapatkan [Arg1] Aliemus. Konsumsi Aritmetika \"Prelude Jiwa\" berkurang sebesar [Arg2], dan jumlah kerusakan dasar meningkat sebesar [Arg3]."
  },
  RelicConfig_84124_Desc = {
    Text = "Pada awal giliran, Hameln mendapatkan [Arg1] Aliemus. Konsumsi Aritmetika \"Prelude Jiwa\" berkurang sebesar [Arg2], dan jumlah kerusakan dasar meningkat sebesar [Arg3]."
  },
  RelicConfig_84124_Name = {
    Text = "<OrangeQuality:Dimensi·Hameln>"
  },
  RelicConfig_84125_BattleDesc = {
    Text = "Pada awal giliran, Catigula mendapatkan [Arg1] poin Aliemus. Setelah mengonsumsi total 10 lapisan \"Api Hidup\", segera tarik 1 Kartu perintah Catigula dan berikan 3 lapisan \"Api Hidup\" padanya, ronde ini tidak lagi mengakumulasi lapisan."
  },
  RelicConfig_84125_Desc = {
    Text = "Pada awal giliran, Catigula mendapatkan [Arg1] poin Aliemus. Setelah mengonsumsi total 10 lapisan \"Api Hidup\", segera tarik 1 Kartu perintah Catigula dan berikan 3 lapisan \"Api Hidup\" padanya, ronde ini tidak lagi mengakumulasi lapisan."
  },
  RelicConfig_84125_Name = {
    Text = "<OrangeQuality:Dimensi·Catigula>"
  },
  RelicConfig_84126_BattleDesc = {
    Text = "Pada awal putaran, Kastor mendapatkan [Arg1] Aliemus. Saat pertempuran dimulai, tempatkan 2 \"Bulu Hitam\" ke dalam tangan. Setelah memainkan \"Bulu Hitam\" pertama kali setiap putaran, dapatkan [Arg2] poin kekuatan sementara."
  },
  RelicConfig_84126_Desc = {
    Text = "Pada awal putaran, Kastor mendapatkan [Arg1] Aliemus. Saat pertempuran dimulai, tempatkan 2 \"Bulu Hitam\" ke dalam tangan. Setelah memainkan \"Bulu Hitam\" pertama kali setiap putaran, dapatkan [Arg2] poin kekuatan sementara."
  },
  RelicConfig_84126_Name = {
    Text = "<OrangeQuality:Dimensi Bayangan·Castor>"
  },
  RelicConfig_84127_BattleDesc = {
    Text = "Pada awal giliran, Querpensanta mendapatkan [Arg1] aliemus, dan mendapatkan 1 tentakel sementara. Setiap kali memicu ketahanan, Querpensanta mendapatkan [Arg2] poin aliemus, dan satu kartu Aritmetika dikonsumsi menjadi 0 dan meletakkan \"Petir Hukuman\" yang dikonsumsi ke dalam tangan."
  },
  RelicConfig_84127_Desc = {
    Text = "Pada awal giliran, Querpensanta mendapatkan [Arg1] aliemus, dan mendapatkan 1 tentakel sementara. Setiap kali memicu ketahanan, Querpensanta mendapatkan [Arg2] poin aliemus, dan satu kartu Aritmetika dikonsumsi menjadi 0 dan meletakkan \"Petir Hukuman\" yang dikonsumsi ke dalam tangan."
  },
  RelicConfig_84127_Name = {
    Text = "<OrangeQuality:Dimensi Bayangan·Koper Sanga>"
  },
  RelicConfig_89252_BattleDesc = {
    Text = [[
Batas Aritmetika meningkat 1, jumlah gambar kartu per giliran meningkat 1. Saat Pertempuran dimulai, dapatkan [Arg1] tingkat "Bilik Takdir".
Setiap tingkat "Bilik Takdir" mengurangi Alismus yang dihasilkan oleh semua Pembangun sebesar [Arg2]%, setiap kali melepaskan Muliakan, kurangi 1 tingkat "Bilik Takdir". Setelah semua "Bilik Takdir" dihapus, semua Pembangun mendapatkan [Arg3] poin Alismus dan mendapatkan "Hati Tak Tergoyahkan": Alismus yang dihasilkan oleh semua Pembangun meningkat sebesar [Arg4]%, setiap giliran dapat melepaskan Muliakan dua kali.]]
  },
  RelicConfig_89252_Desc = {
    Text = [[
Batas Aritmetika meningkat 1, jumlah gambar kartu per giliran meningkat 1. Saat Pertempuran dimulai, dapatkan [Arg1] tingkat "Bilik Takdir".
Setiap tingkat "Bilik Takdir" mengurangi Alismus yang dihasilkan oleh semua Pembangun sebesar [Arg2]%, setiap kali melepaskan Muliakan, kurangi 1 tingkat "Bilik Takdir". Setelah semua "Bilik Takdir" dihapus, semua Pembangun mendapatkan [Arg3] poin Alismus dan mendapatkan "Hati Tak Tergoyahkan": Alismus yang dihasilkan oleh semua Pembangun meningkat sebesar [Arg4]%, setiap giliran dapat melepaskan Muliakan dua kali.]]
  },
  RelicConfig_89252_Name = {
    Text = "Bulu yang terkutuk"
  },
  RelicConfig_89252_StoryDesc = {
    Text = "Kini, bulu ini tidak bisa lagi terbang di langit."
  },
  RelicConfig_89645_BattleDesc = {
    Text = [[
Batas kartu +2, setelah melepaskan Muliakan, kerusakan akhir sementara meningkat 10%. 
Setelah kartu memasuki ruang Ultra, ubah 1 "Embrio" di tangan menjadi "Anak Suci".
Setiap kali menghasilkan 1 "Embrio", biaya aritmetika dari satu kartu acak di ruang Ultra berkurang 1.]]
  },
  RelicConfig_89645_Desc = {
    Text = [[
Batas kartu +2, setelah melepaskan Muliakan, kerusakan akhir sementara meningkat 10%. 
Setelah kartu memasuki ruang Ultra, ubah 1 "Embrio" di tangan menjadi "Anak Suci".
Setiap kali menghasilkan 1 "Embrio", biaya aritmetika dari satu kartu acak di ruang Ultra berkurang 1.]]
  },
  RelicConfig_89645_Name = {
    Text = "Formulasi Darah Busuk Superstring"
  },
  RelicConfig_89646_BattleDesc = {
    Text = "Saat giliran dimulai, dapatkan 250 poin energi-s.\nSetelah menggunakan bangkit kunci perak, masukkan 1 kartu <DerivativeCardKeywords_129:「Kilau Kunci Perak」> ke tangan.\nSetiap awal giliran, temukan 1 dukungan Pembangun."
  },
  RelicConfig_89646_Desc = {
    Text = "Saat giliran dimulai, dapatkan 250 poin energi-s.\nSetelah menggunakan bangkit kunci perak, masukkan 1 kartu <DerivativeCardKeywords_129:「Kilau Kunci Perak」> ke tangan.\nSetiap awal giliran, temukan 1 dukungan Pembangun."
  },
  RelicConfig_89646_Name = {
    Text = "Formulasi yang terintegrasi"
  },
  RelicConfig_89647_BattleDesc = {
    Text = [[
Kartu perintah pertama setiap giliran berlaku tambahan 1 kali.
Ketika lenyap, hasilkan 1 tentakel.
Setelah beralih tentakel menjadi sikap "Ombak Marah", efek pengalihan kartu perintah berikutnya pada giliran ini pasti akan terpicu dan menempatkan 2 salinan aslinya ke dalam ruang Ultra, waktu cooldown 3 giliran.]]
  },
  RelicConfig_89647_Desc = {
    Text = [[
Kartu perintah pertama setiap giliran berlaku tambahan 1 kali.
Ketika lenyap, hasilkan 1 tentakel.
Setelah beralih tentakel menjadi sikap "Ombak Marah", efek pengalihan kartu perintah berikutnya pada giliran ini pasti akan terpicu dan menempatkan 2 salinan aslinya ke dalam ruang Ultra, waktu cooldown 3 giliran.]]
  },
  RelicConfig_89647_Name = {
    Text = "Formulasi Lautan Superstring"
  },
  RelicConfig_89648_BattleDesc = {
    Text = [[
Penguasaan Alam meningkat 200 poin.
Saat memanfaatkan Dapur merah, tingkatkan kerusakan tentakel sebesar 15% dari jumlah yang dimanfaatkan.
Setiap kali menyerang dengan tentakel, akumulasi [Arg3] poin Dapur merah.]]
  },
  RelicConfig_89648_Desc = {
    Text = [[
Penguasaan Alam meningkat 200 poin.
Saat memanfaatkan Dapur merah, tingkatkan kerusakan tentakel sebesar 15% dari jumlah yang dimanfaatkan.
Setiap kali menyerang dengan tentakel, akumulasi [Arg3] poin Dapur merah.]]
  },
  RelicConfig_89648_Name = {
    Text = "Racikan laut darah yang busuk"
  },
  RelicConfig_91096_BattleDesc = {
    Text = [[
Saat ronde dimulai, kedua belah pihak mendapatkan satu lapisan <Kuangre:Kegilaan>, setiap lapisan <Kuangre:Kegilaan> menyebabkan serangan aktif dan kerusakan tentakel memperoleh 10% kerusakan yang setara dengan <BleedingIconKeywords:Berdarah>.
Setiap 20% kerusakan yang menyebabkan kesehatan pemimpin akan membuat semua Pembangun mendapatkan 10 Aliemus.
Saat pertempuran dimulai, masukkan <DerivativeCardKeywords_108:"Dorongan Keturunan"> dan <DerivativeCardKeywords_109:"Perlindungan Keturunan"> ke dalam tumpukan gambar.]]
  },
  RelicConfig_91096_Desc = {
    Text = [[
Saat ronde dimulai, kedua belah pihak mendapatkan satu lapisan <Kuangre:Kegilaan>, setiap lapisan <Kuangre:Kegilaan> menyebabkan serangan aktif dan kerusakan tentakel memperoleh 10% kerusakan yang setara dengan <BleedingIconKeywords:Berdarah>.
Setiap 20% kerusakan yang menyebabkan kesehatan pemimpin akan membuat semua Pembangun mendapatkan 10 Aliemus.
Saat pertempuran dimulai, masukkan <DerivativeCardKeywords_108:"Dorongan Keturunan"> dan <DerivativeCardKeywords_109:"Perlindungan Keturunan"> ke dalam tumpukan gambar.]]
  },
  RelicConfig_91096_Name = {
    Text = "Telur Pucat"
  },
  RelicConfig_91096_StoryDesc = {
    Text = [[
Guncangan saat anak yang pucat akan lahir.
Hati-hati, mereka akan segera datang.]]
  },
  RelicConfig_94695_BattleDesc = {
    Text = "Setelah Awakener dibunuh, sekutu lainnya mendapatkan [Arg1] <StrongEffectKeywords:Amplifikasi>, efek ini hanya dapat dipicu sekali oleh setiap Awakener."
  },
  RelicConfig_94695_Desc = {
    Text = "Setelah Awakener dibunuh, sekutu lainnya mendapatkan [Arg1] <StrongEffectKeywords:Amplifikasi>, efek ini hanya dapat dipicu sekali oleh setiap Awakener."
  },
  RelicConfig_94695_Name = {
    Text = "<OrangeQuality: Bara Hitam yang Terbakar>"
  },
  RelicConfig_94696_BattleDesc = {
    Text = "Setelah pertempuran dimulai, masukkan [Arg1] kartu \"<PVPDerivativeCardKeywords_21:Pelukan yang Menggerogoti Tulang>\" ke tangan."
  },
  RelicConfig_94696_Desc = {
    Text = "Setelah pertempuran dimulai, masukkan [Arg1] kartu \"<PVPDerivativeCardKeywords_21:Pelukan yang Menggerogoti Tulang>\" ke tangan."
  },
  RelicConfig_94696_Name = {
    Text = "<OrangeQuality: Penyuntik Aktif>"
  },
  RelicConfig_94697_BattleDesc = {
    Text = "Saat giliran berakhir, buang semua kartu di tangan dan ambil jumlah kartu yang sama."
  },
  RelicConfig_94697_Desc = {
    Text = "Saat giliran berakhir, buang semua kartu di tangan dan ambil jumlah kartu yang sama."
  },
  RelicConfig_94697_Name = {
    Text = "<OrangeQuality: Kuncup yang Mengetuk>"
  },
  RelicConfig_94698_BattleDesc = {
    Text = "Setelah pertempuran dimulai, tempatkan [Arg1] kartu \"<PVPDerivativeCardKeywords_22:Serangan Mendadak>\" dan \"<PVPDerivativeCardKeywords_23:Suara dalam Pikiran>\" di tumpukan menggambar."
  },
  RelicConfig_94698_Desc = {
    Text = "Setelah pertempuran dimulai, tempatkan [Arg1] kartu \"<PVPDerivativeCardKeywords_22:Serangan Mendadak>\" dan \"<PVPDerivativeCardKeywords_23:Suara dalam Pikiran>\" di tumpukan menggambar."
  },
  RelicConfig_94698_Name = {
    Text = "<OrangeQuality: Perangkat Alfonso>"
  },
  RelicConfig_95975_BattleDesc = {
    Text = [[
Batas kartu di tangan +1.
Jika tidak ada <DerivativeCardKeywords_111:"Jiwa Melahap"> pada awal giliran, letakkan ke dalam tangan. Jika"Kenyang"mencapai 10, ubah menjadi <DerivativeCardKeywords_112:"Memori Resonansi">.]]
  },
  RelicConfig_95975_Desc = {
    Text = [[
Batas maksimum tangan +1.
Jika pada awal giliran tidak ada "Roh Melahap", tempatkan itu di tanganmu. Jika "Pemenuhan" mencapai 10, maka akan diubah menjadi "Resonansi Memori".]]
  },
  RelicConfig_95975_Name = {
    Text = "Cawan Tulang"
  },
  RelicConfig_95975_StoryDesc = {
    Text = "\"Bulan Darah muncul tinggi, dan semua mayat mengangkat gelas untuk minum bersama.\""
  },
  RelicConfig_95976_BattleDesc = {
    Text = "Pada awal giliran, Dullesain mendapatkan [Arg1] Aliemus dan [Arg2] poin Kekuatan. Ketika Dullesain memakan \"Sisa\", ia mendapatkan kekuatan sementara sebesar 20% dari kekuatan permanen."
  },
  RelicConfig_95976_Desc = {
    Text = "Pada awal giliran, Dullesain mendapatkan [Arg1] Aliemus dan [Arg2] poin Kekuatan. Ketika Dullesain memakan \"Sisa\", ia mendapatkan kekuatan sementara sebesar 20% dari kekuatan permanen."
  },
  RelicConfig_95976_Name = {
    Text = "<OrangeQuality: Dimensi gambar·Durexain>"
  },
  RelicConfig_96652_BattleDesc = {
    Text = "Saat giliran dimulai, buat 1 Kartu perintah di tangan mendapatkan \"<BurningKeywords2:Terbakar>\" dan kumpulkan 1 lapisan \"<Heat:Api Kegelapan>\". Setelah \"<Heat:Api Kegelapan>\" mencapai 3 lapisan, masukkan 1 kartu \"<Overload:Ledakan Api Tanpa Akhir>\" ke tangan."
  },
  RelicConfig_96652_Desc = {
    Text = "Saat giliran dimulai, buat 1 Kartu perintah di tangan mendapatkan \"<BurningKeywords2:Terbakar>\" dan kumpulkan 1 lapisan \"<Heat:Api Kegelapan>\". Setelah \"<Heat:Api Kegelapan>\" mencapai 3 lapisan, masukkan 1 kartu \"<Overload:Ledakan Api Tanpa Akhir>\" ke tangan."
  },
  RelicConfig_96652_Name = {
    Text = "Nyala Gelap"
  },
  RelicConfig_96652_StoryDesc = {
    Text = "Api hitam akan mengekspresikan niatnya, membakar segalanya hingga habis."
  },
  RelicConfig_97344_BattleDesc = {
    Text = "Ketika kehilangan kartu terakhir, menarik 2 kartu dan mendapatkan [Arg1] poin energi-s kunci perak. Setiap kali dek kartu diatur ulang, kerusakan tentakel meningkat [Arg2] poin."
  },
  RelicConfig_97344_Desc = {
    Text = "Ketika kehilangan kartu terakhir, menarik 2 kartu dan mendapatkan [Arg1] poin energi-s kunci perak. Setiap kali dek kartu diatur ulang, kerusakan tentakel meningkat [Arg2] poin."
  },
  RelicConfig_97344_Name = {
    Text = "Piala juara Mythag"
  },
  RelicConfig_97344_StoryDesc = {
    Text = "Hari ini, kita akan melupakan rasa takut, melupakan kesedihan, hanya menikmati pesta."
  },
  RelicConfig_97345_BattleDesc = {
    Text = "Setiap kali 3 kartu perintah dikeluarkan, dapatkan 1 poin aritmetika dan menarik 1 kartu. Setiap kali menyebabkan kerusakan aktif, meningkatkan kerusakan akhir sementara sebesar 2%, maksimum 50%."
  },
  RelicConfig_97345_Desc = {
    Text = "Setiap kali 3 kartu perintah dikeluarkan, dapatkan 1 poin aritmetika dan menarik 1 kartu. Setiap kali menyebabkan kerusakan aktif, meningkatkan kerusakan akhir sementara sebesar 2%, maksimum 50%."
  },
  RelicConfig_97345_Name = {
    Text = "Piala juara Mythag"
  },
  RelicConfig_97345_StoryDesc = {
    Text = "Hari ini, kita akan melupakan rasa takut, melupakan kesedihan, hanya menikmati pesta."
  },
  RelicConfig_97346_BattleDesc = {
    Text = "Tingkat kritis semua pembangun meningkat 30%, di awal putaran ganjil, semua musuh kehilangan 25% dari hidup mereka saat ini. Ketika proporsi hidup pemakai lebih rendah dari musuh, meningkatkan kerusakan akhir yang diberikan sebesar 50%; ketika proporsi hidup pemakai lebih tinggi dari musuh, setelah melepaskan muliakan, mendapatkan 35 poin aliemus."
  },
  RelicConfig_97346_Desc = {
    Text = "Tingkat kritis semua pembangun meningkat 30%, di awal putaran ganjil, semua musuh kehilangan 25% dari hidup mereka saat ini. Ketika proporsi hidup pemakai lebih rendah dari musuh, meningkatkan kerusakan akhir yang diberikan sebesar 50%; ketika proporsi hidup pemakai lebih tinggi dari musuh, setelah melepaskan muliakan, mendapatkan 35 poin aliemus."
  },
  RelicConfig_97346_Name = {
    Text = "Piala juara Mythag"
  },
  RelicConfig_97346_StoryDesc = {
    Text = "Hari ini, kita akan melupakan rasa takut, melupakan kesedihan, hanya menikmati pesta."
  },
  RelicConfig_97347_BattleDesc = {
    Text = "Aritmetika maksimum meningkat 2 poin, sisa aritmetika dapat disimpan ke giliran berikutnya. Jika menyimpan lebih dari 2 poin aritmetika, di awal giliran berikutnya semua pembangun mendapatkan 20 poin aliemus; jika menyimpan lebih dari 4 poin aritmetika, meningkatkan kerusakan dasar sebesar 100% pada giliran berikutnya."
  },
  RelicConfig_97347_Desc = {
    Text = "Aritmetika maksimum meningkat 2 poin, sisa aritmetika dapat disimpan ke giliran berikutnya. Jika menyimpan lebih dari 2 poin aritmetika, di awal giliran berikutnya semua pembangun mendapatkan 20 poin aliemus; jika menyimpan lebih dari 4 poin aritmetika, meningkatkan kerusakan dasar sebesar 100% pada giliran berikutnya."
  },
  RelicConfig_97347_Name = {
    Text = "Piala juara Mythag"
  },
  RelicConfig_97347_StoryDesc = {
    Text = "Hari ini, kita akan melupakan rasa takut, melupakan kesedihan, hanya menikmati pesta."
  },
  RelicConfig_98274_BattleDesc = {
    Text = [[
Batas kartu di tangan +1, dapatkan "<DerivativeCardKeywords_116:Palet>" saat pertempuran dimulai.
Dapatkan 1 "<PrimaryColor:Warna Primer>" saat giliran dimulai dan secara acak memberikan "<ColorInkKeywords:Disonansi Kognitif>" pada 2 kartu perintah. Setelah memainkan kartu "<ColorInkKeywords:Disonansi Kognitif>", dapatkan 1 "<PrimaryColor:Warna Primer>" secara berurutan.
 "<PrimaryColor:Warna Primer>" yang dimainkan akan dicatat pada "<DerivativeCardKeywords_116:Palet>". Jika terdapat 2 jenis "<DerivativeCardKeywords_116:Warna Primer>" yang berbeda pada "<PrimaryColor:Palet>", akan memberikan efek buff berkelanjutan.
Jika terdapat 3 jenis "<PrimaryColor:Warna Primer>" yang berbeda pada Palet, segera kurangi 5% HP maksimum semua musuh, dan kosongkan "<DerivativeCardKeywords_116:Palet>".]]
  },
  RelicConfig_98274_Desc = {
    Text = [[
Batas kartu di tangan +1, dapatkan "<DerivativeCardKeywords_116:Palet>" saat pertempuran dimulai.
Dapatkan 1 "<PrimaryColor:Warna Primer>" saat giliran dimulai dan secara acak memberikan "<ColorInkKeywords:Disonansi Kognitif>" pada 2 kartu perintah. Setelah memainkan kartu "<ColorInkKeywords:Disonansi Kognitif>", dapatkan 1 "<PrimaryColor:Warna Primer>" secara berurutan.
 "<PrimaryColor:Warna Primer>" yang dimainkan akan dicatat pada "<DerivativeCardKeywords_116:Palet>". Jika terdapat 2 jenis "<DerivativeCardKeywords_116:Warna Primer>" yang berbeda pada "<PrimaryColor:Palet>", akan memberikan efek buff berkelanjutan.
Jika terdapat 3 jenis "<PrimaryColor:Warna Primer>" yang berbeda pada Palet, segera kurangi 5% HP maksimum semua musuh, dan kosongkan "<DerivativeCardKeywords_116:Palet>".]]
  },
  RelicConfig_98274_Name = {
    Text = "Palet anomali"
  },
  RelicConfig_98274_StoryDesc = {
    Text = "Dalam fenomena aneh, kita akan menyaksikan kelahiran \"Seni\"."
  },
  RelicConfig_98367_BattleDesc = {
    Text = "Efek dasar dari pemulihan hidup dan perisai yang disebabkan oleh semua pembangun meningkat [Arg1]%."
  },
  RelicConfig_98367_Desc = {
    Text = "Efek dasar dari pemulihan hidup dan perisai yang disebabkan oleh semua pembangun meningkat [Arg1]%."
  },
  RelicConfig_98367_Name = {
    Text = "<WhiteQuality:Sisa Kulit Ular Aneh>"
  },
  RelicConfig_98367_StoryDesc = {
    Text = "Dilahirkan kembali dari pembebasan diri."
  },
  RelicConfig_98368_BattleDesc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1]% kerusakan kuat. Setiap kali memainkan kartu perintah pembangun berbeda, dapatkan tambahan [Arg1]% kerusakan kuat sementara."
  },
  RelicConfig_98368_Desc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1]% kerusakan kuat. Setiap kali memainkan kartu perintah pembangun berbeda, dapatkan tambahan [Arg1]% kerusakan kuat sementara."
  },
  RelicConfig_98368_Name = {
    Text = "<OrangeQuality:Kaleidoskop+>"
  },
  RelicConfig_98368_StoryDesc = {
    Text = "Apa yang dipikirkan dan dilihat hanyalah ilusi."
  },
  RelicConfig_98369_BattleDesc = {
    Text = "Setelah menggunakan Bangkit kunci perak, [Arg1] kartu dengan aritmetika tertinggi di tangan mendapatkan efek menjaga dan siap main sampai dimainkan berikutnya, serta mendapatkan [Arg2] energi-s."
  },
  RelicConfig_98369_Desc = {
    Text = "Setelah menggunakan Bangkit kunci perak, [Arg1] kartu dengan aritmetika tertinggi di tangan mendapatkan efek menjaga dan siap main sampai dimainkan berikutnya, serta mendapatkan [Arg2] energi-s."
  },
  RelicConfig_98369_Name = {
    Text = "<WhiteQuality:Album Perangko Asing>"
  },
  RelicConfig_98369_StoryDesc = {
    Text = "Kerinduan yang terukur."
  },
  RelicConfig_98370_BattleDesc = {
    Text = "Saat pertarungan dimulai, mengenai semua musuh memberikan [Arg1] lapisan kelemahan dan rentan. Efek ini juga akan aktif setelah Annihilation, tetapi memiliki cooldown 3 giliran."
  },
  RelicConfig_98370_Desc = {
    Text = "Setelah pertempuran dimulai, menyebabkan [Arg1] lapisan <WeaknessIconKeywords:weakness> dan <VulnerabilityIconKeywords:vulnerable> kepada semua musuh. Efek ini juga akan dipicu setelah \"pembantaian\", tetapi memiliki cooldown 3 putaran."
  },
  RelicConfig_98370_Name = {
    Text = "<WhiteQuality:Instrumen Distorsi Ruang>"
  },
  RelicConfig_98370_StoryDesc = {
    Text = "Melompat ke kehampaan."
  },
  RelicConfig_98371_BattleDesc = {
    Text = "Sampai akhir giliran, setiap kartu perintah di tangan memberikan pemilik pembangun [Arg1] poin Aliemus."
  },
  RelicConfig_98371_Desc = {
    Text = "Sampai akhir giliran, setiap kartu perintah di tangan memberikan pemilik pembangun [Arg1] poin Aliemus."
  },
  RelicConfig_98371_Name = {
    Text = "<WhiteQuality:Timbangan yang Tidak Seimbang>"
  },
  RelicConfig_98371_StoryDesc = {
    Text = "Tidak lagi menjadi simbol keadilan."
  },
  RelicConfig_98372_BattleDesc = {
    Text = "Jika Energi-s penuh saat akhir ronde, keluarkan [Arg1] poin Energi-s untuk menempatkan satu kartu <DerivativeCardKeywords_129:\"Kilau Kunci Perak\"> ke tangan."
  },
  RelicConfig_98372_Desc = {
    Text = "Jika Energi-s penuh saat akhir ronde, keluarkan [Arg1] poin Energi-s untuk menempatkan satu kartu <DerivativeCardKeywords_129:\"Kilau Kunci Perak\"> ke tangan."
  },
  RelicConfig_98372_Name = {
    Text = "<WhiteQuality:Di Dalam Cahaya Senja>"
  },
  RelicConfig_98372_StoryDesc = {
    Text = "Ayo berfoto bersama! Rasakan sensasi rasa sakit yang nyata."
  },
  RelicConfig_98373_BattleDesc = {
    Text = "Lepaskan \"exalt\" untuk mendapatkan [Arg1] energi kunci perak."
  },
  RelicConfig_98373_Desc = {
    Text = "Lepaskan \"exalt\" untuk mendapatkan [Arg1] energi kunci perak."
  },
  RelicConfig_98373_Name = {
    Text = "<OrangeQuality:Momen Indah+>"
  },
  RelicConfig_98373_StoryDesc = {
    Text = "Menyimpan keindahan sesaat untuk selamanya."
  },
  RelicConfig_98374_BattleDesc = {
    Text = "Setiap pertama kali \"Geng\" dalam satu ronde menerapkan [Arg1] lapisan racun pada semua musuh dan dapatkan [Arg2] lapisan counter."
  },
  RelicConfig_98374_Desc = {
    Text = "Setelah posse pertama setiap giliran, aplikasikan [Arg1] stack dari <IntoxicationIconKeywords:racun> ke semua musuh, dan dapatkan [Arg2] stack dari <RetaliateIconKeywords:counter>."
  },
  RelicConfig_98374_Name = {
    Text = "<OrangeQuality:Lampu Permohonan Nabi+>"
  },
  RelicConfig_98374_StoryDesc = {
    Text = "Menjawab keinginanmu."
  },
  RelicConfig_98375_BattleDesc = {
    Text = "Jika Energi-s penuh saat akhir ronde, habiskan [Arg1] poin Energi-s untuk memasukkan satu kartu <DerivativeCardKeywords_67:\"Cahaya Kunci Perak\"> ke tangan."
  },
  RelicConfig_98375_Desc = {
    Text = "Jika Energi-s penuh saat akhir ronde, habiskan [Arg1] poin Energi-s untuk memasukkan satu kartu <DerivativeCardKeywords_67:\"Cahaya Kunci Perak\"> ke tangan."
  },
  RelicConfig_98375_Name = {
    Text = "<OrangeQuality:Dalam Cahaya Senja+>"
  },
  RelicConfig_98375_StoryDesc = {
    Text = "Ayo berfoto bersama! Rasakan sensasi rasa sakit yang nyata."
  },
  RelicConfig_98376_BattleDesc = {
    Text = "Efek dasar dari pemulihan hidup dan perisai yang disebabkan oleh semua pembangun meningkat [Arg1]%."
  },
  RelicConfig_98376_Desc = {
    Text = "Efek dasar dari pemulihan hidup dan perisai yang disebabkan oleh semua pembangun meningkat [Arg1]%."
  },
  RelicConfig_98376_Name = {
    Text = "<OrangeQuality:Sisa Kulit Ular Aneh+>"
  },
  RelicConfig_98376_StoryDesc = {
    Text = "Dilahirkan kembali dari pembebasan diri."
  },
  RelicConfig_98377_BattleDesc = {
    Text = "Setiap kali satu kartu memasuki ruang ultra, gambar [Arg1] kartu perintah pemilik kartu tersebut dari gambar, jika tidak dapat digambar, dapatkan aritmetika yang setara. Berlaku maksimal 2 kali per putaran."
  },
  RelicConfig_98377_Desc = {
    Text = "Setiap kali satu kartu memasuki ruang ultra, gambar [Arg1] kartu perintah pemilik kartu tersebut dari gambar, jika tidak dapat digambar, dapatkan aritmetika yang setara. Berlaku maksimal 2 kali per putaran."
  },
  RelicConfig_98377_Name = {
    Text = "<WhiteQuality:Prisma Segitiga>"
  },
  RelicConfig_98377_StoryDesc = {
    Text = "\"Cahaya terdiri dari tujuh warna.\""
  },
  RelicConfig_98378_BattleDesc = {
    Text = "Saat pertarungan dimulai, mendapatkan [Arg1]% kuat efek kerusakan. Setelah menerima kerusakan, mendapatkan [Arg2] poin Counter, maksimal aktif 3 kali per giliran."
  },
  RelicConfig_98378_Desc = {
    Text = "Pertempuran dimulai mendapatkan [Arg1]% amplifikasi kerusakan. Setelah menerima kerusakan, mendapatkan [Arg2]<RetaliateIconKeywords:counter>，maksimal dapat dipicu 3 kali per putaran."
  },
  RelicConfig_98378_Name = {
    Text = "<OrangeQuality:Pintu Keluar Aman+>"
  },
  RelicConfig_98378_StoryDesc = {
    Text = "Tampaknya, dia juga tidak berhasil keluar."
  },
  RelicConfig_98379_BattleDesc = {
    Text = "Setelah menyebabkan kerusakan aktif atau kerusakan tentakel, tingkatkan kerusakan tentakel yang diterima oleh target pada turn itu sebesar [Arg1]%, maksimal berlaku 20 kali per putaran."
  },
  RelicConfig_98379_Desc = {
    Text = "Setelah menyebabkan kerusakan aktif atau kerusakan tentakel, tingkatkan kerusakan tentakel yang diterima oleh target pada turn itu sebesar [Arg1]%, maksimal berlaku 20 kali per putaran."
  },
  RelicConfig_98379_Name = {
    Text = "<WhiteQuality:Topi Selam>"
  },
  RelicConfig_98379_StoryDesc = {
    Text = "Impian adalah lautan bintang!"
  },
  RelicConfig_98380_BattleDesc = {
    Text = "Saat pertarungan dimulai dan setelah Ketahanan terpicu, mendapatkan [Arg1] poin energi-s."
  },
  RelicConfig_98380_Desc = {
    Text = "Saat pertarungan dimulai dan setelah Ketahanan terpicu, mendapatkan [Arg1] poin energi-s."
  },
  RelicConfig_98380_Name = {
    Text = "<WhiteQuality:Persembahan Masa Lalu>"
  },
  RelicConfig_98380_StoryDesc = {
    Text = "Pernah menjadi sesuatu yang dipersembahkan."
  },
  RelicConfig_98381_BattleDesc = {
    Text = "Setelah Bangkit Kunci Perak, balas [Heal:Arg1] HP dan mendapatkan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_98381_Desc = {
    Text = "Setelah Bangkit Kunci Perak, balas [Heal:Arg1] HP dan mendapatkan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_98381_Name = {
    Text = "<WhiteQuality:Payung Perjalanan>"
  },
  RelicConfig_98381_StoryDesc = {
    Text = "Mekar di tanah tanpa cahaya."
  },
  RelicConfig_98382_BattleDesc = {
    Text = "Setelah pertempuran dimulai, dapatkan [Arg1] <ProficientInRealmsIconKeywords:realm mastery>. Di awal putaran ganjil, ambil [Arg2] kartu, di awal putaran genap, dapatkan [Arg2] poin arithmetica."
  },
  RelicConfig_98382_Desc = {
    Text = "Setelah pertempuran dimulai, dapatkan [Arg1] <ProficientInRealmsIconKeywords:realm mastery>. Di awal putaran ganjil, ambil [Arg2] kartu, di awal putaran genap, dapatkan [Arg2] poin arithmetica."
  },
  RelicConfig_98382_Name = {
    Text = "<OrangeQuality:Roda Matahari dan Bulan+>"
  },
  RelicConfig_98382_StoryDesc = {
    Text = "Tebak, apakah itu hitam atau putih?"
  },
  RelicConfig_98383_BattleDesc = {
    Text = "Setiap pertama kali \"Geng\" dalam satu ronde semua tentakel menyerang musuh [Arg1] kali, menimbulkan 50% kerusakan."
  },
  RelicConfig_98383_Desc = {
    Text = "Setiap pertama kali \"Geng\" dalam satu ronde semua tentakel menyerang musuh [Arg1] kali, menimbulkan 50% kerusakan."
  },
  RelicConfig_98383_Name = {
    Text = "<OrangeQuality:Kerang Kecil+>"
  },
  RelicConfig_98383_StoryDesc = {
    Text = "Siput kecil berwarna kuning ini memiliki garis keturunan bangsawan, dengan Sumber yang sempurna dan tanpa cela."
  },
  RelicConfig_98384_BattleDesc = {
    Text = "Kerusakan dasar yang disebabkan oleh semua pembangun meningkat [Arg1]%. Sebelum merilis muliakan, tingkatkan kerusakan dasar yang disebabkan oleh pembangun tersebut sementara [Arg2]%."
  },
  RelicConfig_98384_Desc = {
    Text = "Kerusakan dasar yang disebabkan oleh semua pembangun meningkat [Arg1]%. Sebelum merilis muliakan, tingkatkan kerusakan dasar yang disebabkan oleh pembangun tersebut sementara [Arg2]%."
  },
  RelicConfig_98384_Name = {
    Text = "<WhiteQuality:Darah yang Terlupakan>"
  },
  RelicConfig_98384_StoryDesc = {
    Text = "Semakin mencair."
  },
  RelicConfig_98385_BattleDesc = {
    Text = "Setiap pertama kali \"Geng\" dalam satu ronde menerapkan [Arg1] lapisan racun pada semua musuh dan dapatkan [Arg2] lapisan counter."
  },
  RelicConfig_98385_Desc = {
    Text = "Setelah posse pertama setiap giliran, aplikasikan [Arg1] stack dari <IntoxicationIconKeywords:racun> ke semua musuh, dan dapatkan [Arg2] stack dari <RetaliateIconKeywords:counter>."
  },
  RelicConfig_98385_Name = {
    Text = "<WhiteQuality:Lampion Doa Peramal>"
  },
  RelicConfig_98385_StoryDesc = {
    Text = "Menjawab keinginanmu."
  },
  RelicConfig_98386_BattleDesc = {
    Text = "Pada awal ronde, jika Hidup berada di bawah 50%, efek kerusakan sementara meningkat sebesar +[Arg1]%. Jika Hidup berada di bawah 25%, tarik [Arg2] kartu tambahan dan dapatkan [Arg2] Aritmetika."
  },
  RelicConfig_98386_Desc = {
    Text = "Pada awal ronde, jika Hidup berada di bawah 50%, efek kerusakan sementara meningkat sebesar +[Arg1]%. Jika Hidup berada di bawah 25%, tarik [Arg2] kartu tambahan dan dapatkan [Arg2] Aritmetika."
  },
  RelicConfig_98386_Name = {
    Text = "<WhiteQuality:Tas Dokter>"
  },
  RelicConfig_98386_StoryDesc = {
    Text = [[
Koper tangan yang melambangkan identitas seorang Dokter, sangat berat.
Orang yang membukanya belum tentu adalah Dokter sungguhan.]]
  },
  RelicConfig_98387_BattleDesc = {
    Text = "Saat pertarungan dimulai, mengenai semua musuh memberikan [Arg1] lapisan kelemahan dan rentan. Efek ini juga akan aktif setelah Annihilation, tetapi memiliki cooldown 3 giliran."
  },
  RelicConfig_98387_Desc = {
    Text = "Setelah pertempuran dimulai, menyebabkan [Arg1] lapisan <WeaknessIconKeywords:weakness> dan <VulnerabilityIconKeywords:vulnerable> kepada semua musuh. Efek ini juga akan dipicu setelah \"pembantaian\", tetapi memiliki cooldown 3 putaran."
  },
  RelicConfig_98387_Name = {
    Text = "<OrangeQuality:Pengukur Pembelokan Ruang+>"
  },
  RelicConfig_98387_StoryDesc = {
    Text = "Melompat ke kehampaan."
  },
  RelicConfig_98388_BattleDesc = {
    Text = "Saat pertarungan dimulai dan setelah Ketahanan terpicu, mendapatkan [Arg1] poin energi-s."
  },
  RelicConfig_98388_Desc = {
    Text = "Saat pertarungan dimulai dan setelah Ketahanan terpicu, mendapatkan [Arg1] poin energi-s."
  },
  RelicConfig_98388_Name = {
    Text = "<OrangeQuality:Hadiah dari Masa Lalu+>"
  },
  RelicConfig_98388_StoryDesc = {
    Text = "Pernah menjadi sesuatu yang dipersembahkan."
  },
  RelicConfig_98389_BattleDesc = {
    Text = "Setelah pertempuran dimulai, dapatkan [Arg1] <ProficientInRealmsIconKeywords:realm mastery>. Di awal putaran ganjil, ambil [Arg2] kartu, di awal putaran genap, dapatkan [Arg2] poin arithmetica."
  },
  RelicConfig_98389_Desc = {
    Text = "Setelah pertempuran dimulai, dapatkan [Arg1] <ProficientInRealmsIconKeywords:realm mastery>. Di awal putaran ganjil, ambil [Arg2] kartu, di awal putaran genap, dapatkan [Arg2] poin arithmetica."
  },
  RelicConfig_98389_Name = {
    Text = "<WhiteQuality:Putaran Bulan dan Matahari>"
  },
  RelicConfig_98389_StoryDesc = {
    Text = "Tebak, apakah itu hitam atau putih?"
  },
  RelicConfig_98390_BattleDesc = {
    Text = "Setiap menggambar atau membuang satu kartu, dapatkan [Arg1] kekuatan sementara, maksimal berlaku 15 kali per putaran."
  },
  RelicConfig_98390_Desc = {
    Text = "Setiap kali Anda menggambar atau membuang kartu, dapatkan [Arg1] kekuatan <PowerIconKeywords:temporary>, dapat dipicu maksimal 15 kali per giliran."
  },
  RelicConfig_98390_Name = {
    Text = "<WhiteQuality:Prelude Keheningan>"
  },
  RelicConfig_98390_StoryDesc = {
    Text = [[
Biola terkenal milik violinis ternama Eric Eckschtein.
Saat ini, biola tersebut tidak dapat dimainkan lagi.]]
  },
  RelicConfig_98391_BattleDesc = {
    Text = "Setiap pertama kali \"Geng\" dalam satu ronde membuat sementara kerusakan kuat +[Arg2]%, semakin rendah hidup, semakin kuat efeknya."
  },
  RelicConfig_98391_Desc = {
    Text = "Setiap pertama kali \"Geng\" dalam satu ronde membuat sementara kerusakan kuat +[Arg1]%, semakin rendah hidup, semakin kuat efeknya."
  },
  RelicConfig_98391_Name = {
    Text = "<WhiteQuality:Ramuan Rohani Harvard>"
  },
  RelicConfig_98391_StoryDesc = {
    Text = [[
Obat dengan komposisi yang tidak jelas. 
 Konon, pemain biola terkenal bernama Eric sangat menggemarinya.]]
  },
  RelicConfig_98392_BattleDesc = {
    Text = "Setiap pertama kali \"Geng\" dalam satu ronde membuat sementara kerusakan kuat +[Arg2]%, semakin rendah hidup, semakin kuat efeknya."
  },
  RelicConfig_98392_Desc = {
    Text = "Setiap pertama kali \"Geng\" dalam satu ronde membuat sementara kerusakan kuat +[Arg1]%, semakin rendah hidup, semakin kuat efeknya."
  },
  RelicConfig_98392_Name = {
    Text = "<OrangeQuality:Obat Harford+>"
  },
  RelicConfig_98392_StoryDesc = {
    Text = [[
Obat dengan komposisi yang tidak jelas. 
 Konon, pemain biola terkenal bernama Eric sangat menggemarinya.]]
  },
  RelicConfig_98393_BattleDesc = {
    Text = "Setiap kartu perintah pada pembangun pertama kali per putaran, dapatkan [Arg1] energi kunci perak."
  },
  RelicConfig_98393_Desc = {
    Text = "Setiap kartu perintah pada pembangun pertama kali per putaran, dapatkan [Arg1] energi kunci perak."
  },
  RelicConfig_98393_Name = {
    Text = "<WhiteQuality:Licik dan Cepat>"
  },
  RelicConfig_98393_StoryDesc = {
    Text = "Bukan hanya pedagang yang pandai bicara, tetapi juga orang-orang yang taat beragama."
  },
  RelicConfig_98394_BattleDesc = {
    Text = "Mengembalikan energi kunci perak [Arg1]% yang habis setelah setiap pertama kali \"Geng\" dalam satu ronde."
  },
  RelicConfig_98394_Desc = {
    Text = "Mengembalikan energi kunci perak [Arg1]% yang habis setelah setiap pertama kali \"Geng\" dalam satu ronde."
  },
  RelicConfig_98394_Name = {
    Text = "<WhiteQuality:Kaki Kelinci Keberuntungan>"
  },
  RelicConfig_98394_StoryDesc = {
    Text = "Bagi kelinci, itu tidak begitu beruntung."
  },
  RelicConfig_98395_BattleDesc = {
    Text = "Saat pertarungan dimulai, mendapatkan [Arg1]% kuat efek kerusakan. Setelah melakukan serangan aktif, mengenai semua musuh memberikan [Arg2] poin racun, maksimal aktif 5 kali per giliran."
  },
  RelicConfig_98395_Desc = {
    Text = "Pertempuran dimulai mendapatkan [Arg1]% amplifikasi kerusakan. Setelah menyebabkan kerusakan aktif, semua musuh akan terkena [Arg2]<IntoxicationIconKeywords:racun>，maksimal dapat dipicu 5 kali per putaran."
  },
  RelicConfig_98395_Name = {
    Text = "<OrangeQuality:Tongkat Pendeta+>"
  },
  RelicConfig_98395_StoryDesc = {
    Text = "Ketakwaan yang tidak diperbolehkan."
  },
  RelicConfig_98396_BattleDesc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1]% kerusakan kuat. Setiap kali memainkan kartu perintah pembangun berbeda, dapatkan tambahan [Arg1]% kerusakan kuat sementara."
  },
  RelicConfig_98396_Desc = {
    Text = "Pada awal pertempuran, dapatkan [Arg1]% kerusakan kuat. Setiap kali memainkan kartu perintah pembangun berbeda, dapatkan tambahan [Arg1]% kerusakan kuat sementara."
  },
  RelicConfig_98396_Name = {
    Text = "<WhiteQuality:Kaleidoskop>"
  },
  RelicConfig_98396_StoryDesc = {
    Text = "Apa yang dipikirkan dan dilihat hanyalah ilusi."
  },
  RelicConfig_98397_BattleDesc = {
    Text = "Setelah setiap kali kedua kalinya \"Geng\" dilepaskan dalam satu ronde, dapatkan [Arg1] energi kunci perak, semua pembangun mendapatkan [Arg2] aliemus."
  },
  RelicConfig_98397_Desc = {
    Text = "Setelah setiap kali kedua kalinya \"Geng\" dilepaskan dalam satu ronde, dapatkan [Arg1] energi kunci perak, semua pembangun mendapatkan [Arg2] aliemus."
  },
  RelicConfig_98397_Name = {
    Text = "<OrangeQuality:Penjaga Waktu Presisi+>"
  },
  RelicConfig_98397_StoryDesc = {
    Text = "Salah satu penemuan paling kejam dalam sejarah umat manusia."
  },
  RelicConfig_98398_BattleDesc = {
    Text = "Pertempuran dimulai membuat semua musuh kehilangan [Arg1] sementara<ExhaustionIconKeywords:kuatan>. Menggunakan \"Tungku merah darah\" juga akan memicu efek ini, tetapi memiliki waktu cooldown 3 putaran."
  },
  RelicConfig_98398_Desc = {
    Text = "Pertempuran dimulai membuat semua musuh kehilangan [Arg1] sementara<ExhaustionIconKeywords:kuatan>. Menggunakan \"Tungku merah darah\" juga akan memicu efek ini, tetapi memiliki waktu cooldown 3 putaran."
  },
  RelicConfig_98398_Name = {
    Text = "<OrangeQuality:Tangan Ahli kosong+>"
  },
  RelicConfig_98398_StoryDesc = {
    Text = "Alat yang sempurna untuk membunuh, merampok, dan menggaruk gatal."
  },
  RelicConfig_98399_BattleDesc = {
    Text = "Setelah setiap kali kedua kalinya \"Geng\" dilepaskan dalam satu ronde, dapatkan [Arg1] energi kunci perak, semua pembangun mendapatkan [Arg2] aliemus."
  },
  RelicConfig_98399_Desc = {
    Text = "Setelah setiap kali kedua kalinya \"Geng\" dilepaskan dalam satu ronde, dapatkan [Arg1] energi kunci perak, semua pembangun mendapatkan [Arg2] aliemus."
  },
  RelicConfig_98399_Name = {
    Text = "<WhiteQuality:Timer Presisi>"
  },
  RelicConfig_98399_StoryDesc = {
    Text = "Salah satu penemuan paling kejam dalam sejarah umat manusia."
  },
  RelicConfig_98400_BattleDesc = {
    Text = "Setiap menggambar atau membuang satu kartu, dapatkan [Arg1] kekuatan sementara, maksimal berlaku 15 kali per putaran."
  },
  RelicConfig_98400_Desc = {
    Text = "Setiap kali Anda menggambar atau membuang kartu, dapatkan [Arg1] kekuatan <PowerIconKeywords:temporary>, dapat dipicu maksimal 15 kali per giliran."
  },
  RelicConfig_98400_Name = {
    Text = "<OrangeQuality:Prelude Sunyi+>"
  },
  RelicConfig_98400_StoryDesc = {
    Text = [[
Biola terkenal milik violinis ternama Eric Eckschtein.
Saat ini, biola tersebut tidak dapat dimainkan lagi.]]
  },
  RelicConfig_98401_BattleDesc = {
    Text = "Saat pertarungan dimulai, mendapatkan [Arg1]% kuat efek kerusakan. Pada setiap giliran, untuk pertama kalinya mendapatkan Counter, mendapatkan [Arg2] aritmetika."
  },
  RelicConfig_98401_Desc = {
    Text = "Saat pertempuran dimulai, dapatkan [Arg1]% amplifikasi kerusakan, setelah pertama kali mendapatkan <RetaliateIconKeywords:counter> setiap giliran, dapatkan [Arg2] arithmetica."
  },
  RelicConfig_98401_Name = {
    Text = "<OrangeQuality:Berita Pagi Putney+>"
  },
  RelicConfig_98401_StoryDesc = {
    Text = "Teman toilet paling praktis dan andal untuk Anda."
  },
  RelicConfig_98402_BattleDesc = {
    Text = "Setelah menyebabkan kerusakan aktif atau kerusakan tentakel, tingkatkan kerusakan tentakel yang diterima oleh target pada turn itu sebesar [Arg1]%, maksimal berlaku 20 kali per putaran."
  },
  RelicConfig_98402_Desc = {
    Text = "Setelah menyebabkan kerusakan aktif atau kerusakan tentakel, tingkatkan kerusakan tentakel yang diterima oleh target pada turn itu sebesar [Arg1]%, maksimal berlaku 20 kali per putaran."
  },
  RelicConfig_98402_Name = {
    Text = "<OrangeQuality:Helm Selam+>"
  },
  RelicConfig_98402_StoryDesc = {
    Text = "Impian adalah lautan bintang!"
  },
  RelicConfig_98403_BattleDesc = {
    Text = "Saat pertarungan dimulai, mendapatkan [Arg1] poin kekuatan. Setiap kali memainkan kartu dengan efek \"Lelah\", mendapatkan [Arg2] kekuatan sementara, maksimal aktif 10 kali per giliran."
  },
  RelicConfig_98403_Desc = {
    Text = "Pertempuran dimulai mendapatkan [Arg1]<PowerIconKeywords:kuatan>. Setiap kali memainkan kartu yang memiliki \"Lelah\" akan mendapatkan [Arg2] sementara<PowerIconKeywords:kuatan>，maksimal dapat dipicu 10 kali per putaran."
  },
  RelicConfig_98403_Name = {
    Text = "<OrangeQuality:Kotak Musik Kecil+>"
  },
  RelicConfig_98403_StoryDesc = {
    Text = [[
Di kediaman Dexter terdapat banyak koleksi. Sebelum jatuh dan rusak, kotak musik kecil pernah menjadi mainan favorit Nona Kecil Dexter.
Waktu berlalu, ketika Nona Dexter menemukannya kembali, meski gir-nya sudah kendur dan musiknya sumbang, ia masih terus berputar tanpa henti.]]
  },
  RelicConfig_98404_BattleDesc = {
    Text = "Lepaskan \"exalt\" untuk mendapatkan [Arg1] energi kunci perak."
  },
  RelicConfig_98404_Desc = {
    Text = "Lepaskan \"exalt\" untuk mendapatkan [Arg1] energi kunci perak."
  },
  RelicConfig_98404_Name = {
    Text = "<WhiteQuality:Momen Indah>"
  },
  RelicConfig_98404_StoryDesc = {
    Text = "Menyimpan keindahan sesaat untuk selamanya."
  },
  RelicConfig_98405_BattleDesc = {
    Text = "Setiap kartu perintah pada pembangun pertama kali per putaran, dapatkan [Arg1] energi kunci perak."
  },
  RelicConfig_98405_Desc = {
    Text = "Setiap kartu perintah pada pembangun pertama kali per putaran, dapatkan [Arg1] energi kunci perak."
  },
  RelicConfig_98405_Name = {
    Text = "<OrangeQuality:Berbicara Lancar+>"
  },
  RelicConfig_98405_StoryDesc = {
    Text = "Bukan hanya pedagang yang pandai bicara, tetapi juga orang-orang yang taat beragama."
  },
  RelicConfig_98406_BattleDesc = {
    Text = "Setiap kali satu \"embrio\" dihasilkan, dapatkan [Arg1] dapur merah, maksimal 3 kali per putaran."
  },
  RelicConfig_98406_Desc = {
    Text = "Setiap kali satu \"embrio\" dihasilkan, dapatkan [Arg1] dapur merah, maksimal 3 kali per putaran."
  },
  RelicConfig_98406_Name = {
    Text = "<OrangeQuality:Sayangku+>"
  },
  RelicConfig_98406_StoryDesc = {
    Text = "Tukang kayu membuat boneka kayu yang sangat hidup untuk istrinya. Boneka itu akan menggantikan anak mereka, yang sedang tertidur di dalam perutnya."
  },
  RelicConfig_98407_BattleDesc = {
    Text = "Mengembalikan energi kunci perak [Arg1]% yang habis setelah setiap pertama kali \"Geng\" dalam satu ronde."
  },
  RelicConfig_98407_Desc = {
    Text = "Mengembalikan energi kunci perak [Arg1]% yang habis setelah setiap pertama kali \"Geng\" dalam satu ronde."
  },
  RelicConfig_98407_Name = {
    Text = "<OrangeQuality:Kaki Kelinci Beruntung+>"
  },
  RelicConfig_98407_StoryDesc = {
    Text = "Bagi kelinci, itu tidak begitu beruntung."
  },
  RelicConfig_98408_BattleDesc = {
    Text = "Saat giliran dimulai, semua pembangun yang kekurangan Aliemus untuk mengaktifkan Aliemus Muliakan mendapatkan [Arg1] poin Aliemus."
  },
  RelicConfig_98408_Desc = {
    Text = "Saat giliran dimulai, semua pembangun yang kekurangan Aliemus untuk mengaktifkan Aliemus Muliakan mendapatkan [Arg1] poin Aliemus."
  },
  RelicConfig_98408_Name = {
    Text = "<WhiteQuality:Easter Egg Time>"
  },
  RelicConfig_98408_StoryDesc = {
    Text = "Nikmati kebahagiaan, namun tidak bisa dimakan."
  },
  RelicConfig_98409_BattleDesc = {
    Text = "Pertempuran dimulai membuat semua musuh kehilangan [Arg1] sementara<ExhaustionIconKeywords:kuatan>. Menggunakan \"Tungku merah darah\" juga akan memicu efek ini, tetapi memiliki waktu cooldown 3 putaran."
  },
  RelicConfig_98409_Desc = {
    Text = "Pertempuran dimulai membuat semua musuh kehilangan [Arg1] sementara<ExhaustionIconKeywords:kuatan>. Menggunakan \"Tungku merah darah\" juga akan memicu efek ini, tetapi memiliki waktu cooldown 3 putaran."
  },
  RelicConfig_98409_Name = {
    Text = "<WhiteQuality:Keahlian Tangan Kosong>"
  },
  RelicConfig_98409_StoryDesc = {
    Text = "Alat yang sempurna untuk membunuh, merampok, dan menggaruk gatal."
  },
  RelicConfig_98410_BattleDesc = {
    Text = "Setiap kali satu \"embrio\" dihasilkan, dapatkan [Arg1] dapur merah, maksimal 3 kali per putaran."
  },
  RelicConfig_98410_Desc = {
    Text = "Setiap kali satu \"embrio\" dihasilkan, dapatkan [Arg1] dapur merah, maksimal 3 kali per putaran."
  },
  RelicConfig_98410_Name = {
    Text = "<WhiteQuality:Sayang tersayang>"
  },
  RelicConfig_98410_StoryDesc = {
    Text = "Tukang kayu membuat boneka kayu yang sangat hidup untuk istrinya. Boneka itu akan menggantikan anak mereka, yang sedang tertidur di dalam perutnya."
  },
  RelicConfig_98411_BattleDesc = {
    Text = "Saat ronde dimulai, jika Energi-s lebih besar dari [Arg1], maka konsumsi [Arg1] poin Energi-s untuk memasukkan 1 kartu<DerivativeCardKeywords_115:\"Inspirasi Tingkat Tinggi\"> ke dalam tangan."
  },
  RelicConfig_98411_Desc = {
    Text = "Saat ronde dimulai, jika Energi-s lebih besar dari [Arg1], maka konsumsi [Arg1] poin Energi-s untuk memasukkan 1 kartu<DerivativeCardKeywords_115:\"Inspirasi Tingkat Tinggi\"> ke dalam tangan."
  },
  RelicConfig_98411_Name = {
    Text = "<RedQuality:IlusiMimpiBuruk>"
  },
  RelicConfig_98411_StoryDesc = {
    Text = "Hati-hati, tidur yang berlebihan bisa melahap segalanya tanpa kamu sadari."
  },
  RelicConfig_98412_BattleDesc = {
    Text = "Setiap melepaskan 5 kali \"exalt\", [Arg1] Kartu Perintah non-derived berpengaruh satu kali ekstra."
  },
  RelicConfig_98412_Desc = {
    Text = "Setiap melepaskan 5 kali \"exalt\", [Arg1] Kartu Perintah non-derived berpengaruh satu kali ekstra."
  },
  RelicConfig_98412_Name = {
    Text = "<OrangeQuality:Anggur Bintang+>"
  },
  RelicConfig_98412_StoryDesc = {
    Text = "Melangkah di antara bintang-bintang."
  },
  RelicConfig_98413_BattleDesc = {
    Text = "Saat pertarungan dimulai, mendapatkan [Arg1]% kuat efek kerusakan. Setelah menerima kerusakan, mendapatkan [Arg2] poin Counter, maksimal aktif 3 kali per giliran."
  },
  RelicConfig_98413_Desc = {
    Text = "Pertempuran dimulai mendapatkan [Arg1]% amplifikasi kerusakan. Setelah menerima kerusakan, mendapatkan [Arg2]<RetaliateIconKeywords:counter>，maksimal dapat dipicu 3 kali per putaran."
  },
  RelicConfig_98413_Name = {
    Text = "<WhiteQuality:Keluar Darurat>"
  },
  RelicConfig_98413_StoryDesc = {
    Text = "Tampaknya, dia juga tidak berhasil keluar."
  },
  RelicConfig_98414_BattleDesc = {
    Text = "Kerusakan dasar yang disebabkan oleh semua pembangun meningkat [Arg1]%. Sebelum merilis muliakan, tingkatkan kerusakan dasar yang disebabkan oleh pembangun tersebut sementara [Arg2]%."
  },
  RelicConfig_98414_Desc = {
    Text = "Kerusakan dasar yang disebabkan oleh semua pembangun meningkat [Arg1]%. Sebelum merilis muliakan, tingkatkan kerusakan dasar yang disebabkan oleh pembangun tersebut sementara [Arg2]%."
  },
  RelicConfig_98414_Name = {
    Text = "<OrangeQuality:Darah yang Terlupakan+>"
  },
  RelicConfig_98414_StoryDesc = {
    Text = "Semakin mencair."
  },
  RelicConfig_98415_BattleDesc = {
    Text = "Setelah Bangkit Kunci Perak, balas [Heal:Arg1] HP dan mendapatkan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_98415_Desc = {
    Text = "Setelah Bangkit Kunci Perak, balas [Heal:Arg1] HP dan mendapatkan [Arg2] Energi-s Kunci Perak."
  },
  RelicConfig_98415_Name = {
    Text = "<OrangeQuality:Payung Perjalanan+>"
  },
  RelicConfig_98415_StoryDesc = {
    Text = "Mekar di tanah tanpa cahaya."
  },
  RelicConfig_98416_BattleDesc = {
    Text = "Saat pertarungan dimulai, mendapatkan [Arg1]% kuat efek kerusakan. Pada setiap giliran, untuk pertama kalinya mendapatkan Counter, mendapatkan [Arg2] aritmetika."
  },
  RelicConfig_98416_Desc = {
    Text = "Saat pertempuran dimulai, dapatkan [Arg1]% amplifikasi kerusakan, setelah pertama kali mendapatkan <RetaliateIconKeywords:counter> setiap giliran, dapatkan [Arg2] arithmetica."
  },
  RelicConfig_98416_Name = {
    Text = "<WhiteQuality:Putney Morning Post>"
  },
  RelicConfig_98416_StoryDesc = {
    Text = "Teman toilet paling praktis dan andal untuk Anda."
  },
  RelicConfig_98417_BattleDesc = {
    Text = "Saat giliran dimulai, semua pembangun yang kekurangan Aliemus untuk mengaktifkan Aliemus Muliakan mendapatkan [Arg1] poin Aliemus."
  },
  RelicConfig_98417_Desc = {
    Text = "Saat giliran dimulai, semua pembangun yang kekurangan Aliemus untuk mengaktifkan Aliemus Muliakan mendapatkan [Arg1] poin Aliemus."
  },
  RelicConfig_98417_Name = {
    Text = "<OrangeQuality:Waktu telur Paskah+>"
  },
  RelicConfig_98417_StoryDesc = {
    Text = "Nikmati kebahagiaan, namun tidak bisa dimakan."
  },
  RelicConfig_98418_BattleDesc = {
    Text = "Saat pertarungan dimulai, mendapatkan [Arg1]% kuat efek kerusakan. Pada setiap giliran, untuk pertama kalinya menerapkan racun, menarik [Arg2] kartu."
  },
  RelicConfig_98418_Desc = {
    Text = "Pertempuran dimulai mendapatkan [Arg1]% amplifikasi kerusakan. Setiap kali menerapkan<IntoxicationIconKeywords:racun> untuk pertama kali dalam putaran, ambil [Arg2] kartu."
  },
  RelicConfig_98418_Name = {
    Text = "<OrangeQuality:Skrip Kertas Rein+>"
  },
  RelicConfig_98418_StoryDesc = {
    Text = "Berikut adalah pertanyaannya: 10 biksu membagi 6 roti, berapa banyak yang didapat masing-masing?"
  },
  RelicConfig_98419_BattleDesc = {
    Text = "Setiap melepaskan 5 kali \"exalt\", [Arg1] Kartu Perintah non-derived berpengaruh satu kali ekstra."
  },
  RelicConfig_98419_Desc = {
    Text = "Setiap melepaskan 5 kali \"exalt\", [Arg1] Kartu Perintah non-derived berpengaruh satu kali ekstra."
  },
  RelicConfig_98419_Name = {
    Text = "<WhiteQuality:Anggur Bintang>"
  },
  RelicConfig_98419_StoryDesc = {
    Text = "Melangkah di antara bintang-bintang."
  },
  RelicConfig_98420_BattleDesc = {
    Text = "Setiap kali satu kartu memasuki ruang ultra, gambar [Arg1] kartu perintah pemilik kartu tersebut dari gambar, jika tidak dapat digambar, dapatkan aritmetika yang setara. Berlaku maksimal 2 kali per putaran."
  },
  RelicConfig_98420_Desc = {
    Text = "Setiap kali satu kartu memasuki ruang ultra, gambar [Arg1] kartu perintah pemilik kartu tersebut dari gambar, jika tidak dapat digambar, dapatkan aritmetika yang setara. Berlaku maksimal 2 kali per putaran."
  },
  RelicConfig_98420_Name = {
    Text = "<OrangeQuality:Prisma+>"
  },
  RelicConfig_98420_StoryDesc = {
    Text = "\"Cahaya terdiri dari tujuh warna.\""
  },
  RelicConfig_98421_BattleDesc = {
    Text = "Setelah menggunakan Bangkit kunci perak, [Arg1] kartu dengan aritmetika tertinggi di tangan mendapatkan efek menjaga dan siap main sampai dimainkan berikutnya, serta mendapatkan [Arg2] energi-s."
  },
  RelicConfig_98421_Desc = {
    Text = "Setelah menggunakan Bangkit kunci perak, [Arg1] kartu dengan aritmetika tertinggi di tangan mendapatkan efek menjaga dan siap main sampai dimainkan berikutnya, serta mendapatkan [Arg2] energi-s."
  },
  RelicConfig_98421_Name = {
    Text = "<OrangeQuality:Album Prank Stempel+>"
  },
  RelicConfig_98421_StoryDesc = {
    Text = "Kerinduan yang terukur."
  },
  RelicConfig_98422_BattleDesc = {
    Text = "Sampai akhir giliran, setiap kartu perintah di tangan memberikan pemilik pembangun [Arg1] poin Aliemus."
  },
  RelicConfig_98422_Desc = {
    Text = "Sampai akhir giliran, setiap kartu perintah di tangan memberikan pemilik pembangun [Arg1] poin Aliemus."
  },
  RelicConfig_98422_Name = {
    Text = "<OrangeQuality:Seimbangnya Timbangan+>"
  },
  RelicConfig_98422_StoryDesc = {
    Text = "Tidak lagi menjadi simbol keadilan."
  },
  RelicConfig_98423_BattleDesc = {
    Text = "Saat pertarungan dimulai, mendapatkan [Arg1]% kuat efek kerusakan. Setelah melakukan serangan aktif, mengenai semua musuh memberikan [Arg2] poin racun, maksimal aktif 5 kali per giliran."
  },
  RelicConfig_98423_Desc = {
    Text = "Pertempuran dimulai mendapatkan [Arg1]% amplifikasi kerusakan. Setelah menyebabkan kerusakan aktif, semua musuh akan terkena [Arg2]<IntoxicationIconKeywords:racun>，maksimal dapat dipicu 5 kali per putaran."
  },
  RelicConfig_98423_Name = {
    Text = "<WhiteQuality:Tongkat Pendeta>"
  },
  RelicConfig_98423_StoryDesc = {
    Text = "Ketakwaan yang tidak diperbolehkan."
  },
  RelicConfig_98424_BattleDesc = {
    Text = "Saat pertarungan dimulai, mendapatkan [Arg1]% kuat efek kerusakan. Pada setiap giliran, untuk pertama kalinya menerapkan racun, menarik [Arg2] kartu."
  },
  RelicConfig_98424_Desc = {
    Text = "Pertempuran dimulai mendapatkan [Arg1]% amplifikasi kerusakan. Setiap kali menerapkan<IntoxicationIconKeywords:racun> untuk pertama kali dalam putaran, ambil [Arg2] kartu."
  },
  RelicConfig_98424_Name = {
    Text = "<WhiteQuality: Papirus Rhind>"
  },
  RelicConfig_98424_StoryDesc = {
    Text = "Berikut adalah pertanyaannya: 10 biksu membagi 6 roti, berapa banyak yang didapat masing-masing?"
  },
  RelicConfig_98425_BattleDesc = {
    Text = "Saat pertarungan dimulai, mendapatkan [Arg1] poin kekuatan. Setiap kali memainkan kartu dengan efek \"Lelah\", mendapatkan [Arg2] kekuatan sementara, maksimal aktif 10 kali per giliran."
  },
  RelicConfig_98425_Desc = {
    Text = "Pertempuran dimulai mendapatkan [Arg1]<PowerIconKeywords:kuatan>. Setiap kali memainkan kartu yang memiliki \"Lelah\" akan mendapatkan [Arg2] sementara<PowerIconKeywords:kuatan>，maksimal dapat dipicu 10 kali per putaran."
  },
  RelicConfig_98425_Name = {
    Text = "<WhiteQuality:Kotak Musik Kecil>"
  },
  RelicConfig_98425_StoryDesc = {
    Text = [[
Di kediaman Dexter terdapat banyak koleksi. Sebelum jatuh dan rusak, kotak musik kecil pernah menjadi mainan favorit Nona Kecil Dexter.
Waktu berlalu, ketika Nona Dexter menemukannya kembali, meski gir-nya sudah kendur dan musiknya sumbang, ia masih terus berputar tanpa henti.]]
  },
  RelicConfig_98426_BattleDesc = {
    Text = "Setiap pertama kali \"Geng\" dalam satu ronde semua tentakel menyerang musuh [Arg1] kali, menimbulkan 50% kerusakan."
  },
  RelicConfig_98426_Desc = {
    Text = "Setiap pertama kali \"Geng\" dalam satu ronde semua tentakel menyerang musuh [Arg1] kali, menimbulkan 50% kerusakan."
  },
  RelicConfig_98426_Name = {
    Text = "<WhiteQuality:Kerang Kuning Kecil>"
  },
  RelicConfig_98426_StoryDesc = {
    Text = "Siput kecil berwarna kuning ini memiliki garis keturunan bangsawan, dengan Sumber yang sempurna dan tanpa cela."
  },
  RelicConfig_98427_BattleDesc = {
    Text = "Pada awal ronde, jika Hidup berada di bawah 50%, efek kerusakan sementara meningkat sebesar +[Arg1]%. Jika Hidup berada di bawah 25%, tarik [Arg2] kartu tambahan dan dapatkan [Arg2] Aritmetika."
  },
  RelicConfig_98427_Desc = {
    Text = "Pada awal ronde, jika Hidup berada di bawah 50%, efek kerusakan sementara meningkat sebesar +[Arg1]%. Jika Hidup berada di bawah 25%, tarik [Arg2] kartu tambahan dan dapatkan [Arg2] Aritmetika."
  },
  RelicConfig_98427_Name = {
    Text = "<OrangeQuality:Kotak Pertolongan Dokter+>"
  },
  RelicConfig_98427_StoryDesc = {
    Text = [[
Koper tangan yang melambangkan identitas seorang Dokter, sangat berat.
Orang yang membukanya belum tentu adalah Dokter sungguhan.]]
  },
  RelicConfig_98891_BattleDesc = {
    Text = "Saat pertempuran dimulai, dapatkan 5 lapisan \"<LostWay:Tersesat>\"，berkurang 1 lapis setelah memainkan 3 kartu perintah.\nKetika semua \"<LostWay:Tersesat>\" dihilangkan, semua awakener mendapat 100 poin aliemus, pulih [Arg1] poin hp setelah memainkan 3 kartu perintah, menerapkan 1% dari max hp musuh di barisan depan sebagai <Corrosion:korosi>."
  },
  RelicConfig_98891_Desc = {
    Text = "Saat pertempuran dimulai, dapatkan 5 lapisan \"<LostWay:Tersesat>\"，berkurang 1 lapis setelah memainkan 3 kartu perintah.\nKetika semua \"<LostWay:Tersesat>\" dihilangkan, semua awakener mendapat 100 poin aliemus, pulih [Arg1] poin hp setelah memainkan 3 kartu perintah, menerapkan 1% dari max hp musuh di barisan depan sebagai <Corrosion:korosi>."
  },
  RelicConfig_98891_Name = {
    Text = "Lampu penyelamat"
  },
  RelicConfig_98891_StoryDesc = {
    Text = "Meskipun mengalami kegelapan, lampu penyelamat akan bersinar kembali dalam kematian."
  }
})
return Text_RelicConfig
