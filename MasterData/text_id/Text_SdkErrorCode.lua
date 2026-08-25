__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_SdkErrorCode = readonly({
  SdkErrorCode_67975_Content = {
    Text = "Terjadi kesalahan dalam membaca atau menulis file, silakan coba restart game atau perbaiki klien."
  },
  SdkErrorCode_67988_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_67989_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_67990_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_67991_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_67992_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_67993_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_67994_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68020_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68022_Content = {
    Text = "Unduhan file gagal, silakan periksa ruang tersisa pada perangkat Anda."
  },
  SdkErrorCode_68023_Content = {
    Text = "Jaringan tidak stabil, silakan periksa jaringan Anda dan coba lagi."
  },
  SdkErrorCode_68024_Content = {
    Text = "Tidak ada tautan internet, silakan periksa jaringan dan coba lagi"
  },
  SdkErrorCode_68027_Content = {
    Text = "Tidak ada tautan internet, silakan periksa jaringan dan coba lagi"
  },
  SdkErrorCode_68033_Content = {
    Text = "Terjadi kesalahan saat membaca atau menulis file, silakan coba restart game."
  },
  SdkErrorCode_68035_Content = {
    Text = "Terjadi kesalahan saat membaca atau menulis file, silakan coba restart game."
  },
  SdkErrorCode_68037_Content = {
    Text = "Dalam waktu singkat, game memanggil antarmuka acquire beberapa kali, ada kemungkinan mendapatkan ejoy_token yang tidak valid (16 token akan saling menimpa). Menggunakan token ini untuk login ke server game akan menghasilkan error 401."
  },
  SdkErrorCode_68058_Content = {
    Text = "Terjadi kesalahan dalam membaca atau menulis file, silakan coba restart game atau periksa izin aplikasi."
  },
  SdkErrorCode_68060_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68061_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68062_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68063_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68064_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68065_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68066_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68067_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68068_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68069_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68071_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68072_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68073_Content = {
    Text = "Terjadi kesalahan saat membaca atau menulis file, silakan coba restart game."
  },
  SdkErrorCode_68077_Content = {
    Text = "Terjadi kesalahan dalam membaca cache, silakan coba restart game."
  },
  SdkErrorCode_68078_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68082_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68100_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68109_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68110_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68111_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68112_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68113_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68114_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68115_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68116_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68118_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68119_Content = {
    Text = "Terjadi kesalahan saat membaca atau menulis file, silakan coba restart game."
  },
  SdkErrorCode_68120_Content = {
    Text = "Terjadi kesalahan saat membaca atau menulis file, silakan coba restart game."
  },
  SdkErrorCode_68121_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68133_Content = {
    Text = "Jaringan tidak stabil, silakan periksa jaringan atau coba lagi setelah memulai ulang game."
  },
  SdkErrorCode_68153_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68158_Content = {
    Text = "Jaringan sedang sibuk, silakan coba lagi nanti."
  },
  SdkErrorCode_68159_Content = {
    Text = "Unduhan file gagal, silakan periksa ruang tersisa pada perangkat Anda."
  },
  SdkErrorCode_68170_Content = {
    Text = "Jaringan sedang sibuk, silakan coba lagi nanti."
  },
  SdkErrorCode_68173_Content = {
    Text = "Jaringan sedang sibuk, silakan coba lagi nanti."
  },
  SdkErrorCode_68174_Content = {
    Text = "Jaringan sedang sibuk, silakan coba lagi nanti."
  },
  SdkErrorCode_68175_Content = {
    Text = "Jaringan sedang sibuk, silakan coba lagi nanti."
  },
  SdkErrorCode_68176_Content = {
    Text = "Tidak ada tautan internet, silakan periksa jaringan"
  },
  SdkErrorCode_68189_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68190_Content = {
    Text = "Koneksi jaringan tidak stabil, silakan coba restart permainan atau periksa jaringan"
  },
  SdkErrorCode_68199_Content = {
    Text = "Koneksi terputus, silakan periksa jaringan."
  },
  SdkErrorCode_68201_Content = {
    Text = "Koneksi terputus, silakan periksa jaringan."
  },
  SdkErrorCode_68202_Content = {
    Text = "Jaringan tidak normal, silakan periksa jaringan."
  },
  SdkErrorCode_68205_Content = {
    Text = "Koneksi terputus, silakan periksa jaringan."
  },
  SdkErrorCode_68207_Content = {
    Text = "Tautan jaringan terputus, silakan periksa jaringan"
  },
  SdkErrorCode_68210_Content = {
    Text = "Jaringan tidak normal, silakan periksa jaringan."
  },
  SdkErrorCode_68235_Content = {
    Text = "Jaringan tidak stabil, silakan periksa jaringan Anda dan coba lagi."
  },
  SdkErrorCode_68236_Content = {
    Text = "Tidak ada tautan internet, silakan periksa jaringan dan coba lagi"
  },
  SdkErrorCode_68241_Content = {
    Text = "Jaringan tidak stabil, silakan periksa jaringan Anda dan coba lagi."
  },
  SdkErrorCode_68245_Content = {
    Text = "Koneksi jaringan tidak normal, silakan periksa jaringan dan coba lagi"
  },
  SdkErrorCode_68246_Content = {
    Text = "Jaringan tidak stabil, silakan periksa jaringan Anda dan coba lagi."
  },
  SdkErrorCode_68248_Content = {
    Text = "Jaringan sedang sibuk, silakan coba lagi nanti."
  },
  SdkErrorCode_68250_Content = {
    Text = "Unduhan file gagal, silakan periksa ruang tersisa pada perangkat Anda."
  },
  SdkErrorCode_68252_Content = {
    Text = "Unduhan file mengalami masalah, silakan restart game atau perbaiki klien."
  },
  SdkErrorCode_68261_Content = {
    Text = "Terjadi kesalahan saat membaca atau menulis file, silakan coba restart game."
  },
  SdkErrorCode_68268_Content = {
    Text = "Jaringan tidak stabil, silakan periksa jaringan atau coba lagi setelah memulai ulang game."
  },
  SdkErrorCode_68269_Content = {
    Text = "Jaringan tidak stabil, silakan periksa jaringan atau coba lagi setelah memulai ulang game."
  },
  SdkErrorCode_68278_Content = {
    Text = "Terjadi kesalahan dalam membaca atau menulis file, silakan coba restart game atau perbaiki klien."
  }
})
return Text_SdkErrorCode
