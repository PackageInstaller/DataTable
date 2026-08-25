__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_SdkErrorCode = readonly({
  SdkErrorCode_67975_Content = {
    Text = "Dosya okuma/yazma hatası. Lütfen oyunu yeniden başlatmayı veya istemciyi onarmayı deneyin."
  },
  SdkErrorCode_67988_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_67989_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_67990_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_67991_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_67992_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_67993_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_67994_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68020_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68022_Content = {
    Text = "Dosya indirme hatası. Lütfen cihazınızdaki kullanılabilir depolama alanını kontrol edin."
  },
  SdkErrorCode_68023_Content = {
    Text = "Zayıf ağ bağlantısı. Lütfen ağınızı kontrol edip yeniden deneyin."
  },
  SdkErrorCode_68024_Content = {
    Text = "Ağ bağlantısı yok. Lütfen ağınızı kontrol edip yeniden deneyin."
  },
  SdkErrorCode_68027_Content = {
    Text = "Ağ bağlantısı yok. Lütfen ağınızı kontrol edip yeniden deneyin."
  },
  SdkErrorCode_68033_Content = {
    Text = "Dosya okuma/yazma hatası. Lütfen oyunu yeniden başlatmayı deneyin."
  },
  SdkErrorCode_68035_Content = {
    Text = "Dosya okuma/yazma hatası. Lütfen oyunu yeniden başlatmayı deneyin."
  },
  SdkErrorCode_68037_Content = {
    Text = "Oyun, kısa bir süre içinde edinim arayüzünü birden fazla kez çağırırsa, geçersiz bir ejoy_token alma olasılığı vardır (16 jeton birbirinin üzerine yazabilir). Böyle bir jetonla oyun sunucusuna giriş yapmak 401 hatasıyla sonuçlanacaktır."
  },
  SdkErrorCode_68058_Content = {
    Text = "Dosya okuma/yazma hatası. Lütfen oyunu yeniden başlatmayı veya uygulama izinlerini kontrol etmeyi deneyin."
  },
  SdkErrorCode_68060_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68061_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68062_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68063_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68064_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68065_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68066_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68067_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68068_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68069_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68071_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68072_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68073_Content = {
    Text = "Dosya okuma/yazma hatası. Lütfen oyunu yeniden başlatmayı deneyin."
  },
  SdkErrorCode_68077_Content = {
    Text = "Önbellek okuma hatası. Lütfen oyunu yeniden başlatmayı deneyin."
  },
  SdkErrorCode_68078_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68082_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68100_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68109_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68110_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68111_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68112_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68113_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68114_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68115_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68116_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68118_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68119_Content = {
    Text = "Dosya okuma/yazma hatası. Lütfen oyunu yeniden başlatmayı deneyin."
  },
  SdkErrorCode_68120_Content = {
    Text = "Dosya okuma/yazma hatası. Lütfen oyunu yeniden başlatmayı deneyin."
  },
  SdkErrorCode_68121_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68133_Content = {
    Text = "Zayıf ağ bağlantısı. Lütfen ağınızı kontrol edin veya oyunu yeniden başlatıp tekrar deneyin."
  },
  SdkErrorCode_68153_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68158_Content = {
    Text = "Ağ meşgul. Lütfen daha sonra tekrar deneyin."
  },
  SdkErrorCode_68159_Content = {
    Text = "Dosya indirme hatası. Lütfen cihazınızdaki kullanılabilir depolama alanını kontrol edin."
  },
  SdkErrorCode_68170_Content = {
    Text = "Ağ meşgul. Lütfen daha sonra tekrar deneyin."
  },
  SdkErrorCode_68173_Content = {
    Text = "Ağ meşgul. Lütfen daha sonra tekrar deneyin."
  },
  SdkErrorCode_68174_Content = {
    Text = "Ağ meşgul. Lütfen daha sonra tekrar deneyin."
  },
  SdkErrorCode_68175_Content = {
    Text = "Ağ meşgul. Lütfen daha sonra tekrar deneyin."
  },
  SdkErrorCode_68176_Content = {
    Text = "Ağ bağlantısı yok. Lütfen ağınızı kontrol edin."
  },
  SdkErrorCode_68189_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68190_Content = {
    Text = "Ağ bağlantı hatası. Lütfen oyunu yeniden başlatmayı veya ağınızı kontrol etmeyi deneyin."
  },
  SdkErrorCode_68199_Content = {
    Text = "Ağ kesildi. Lütfen ağınızı kontrol edin."
  },
  SdkErrorCode_68201_Content = {
    Text = "Ağ kesildi. Lütfen ağınızı kontrol edin."
  },
  SdkErrorCode_68202_Content = {
    Text = "Ağ hatası. Lütfen ağınızı kontrol edin."
  },
  SdkErrorCode_68205_Content = {
    Text = "Ağ kesildi. Lütfen ağınızı kontrol edin."
  },
  SdkErrorCode_68207_Content = {
    Text = "Ağ bağlantısı kesildi. Lütfen ağınızı kontrol edin."
  },
  SdkErrorCode_68210_Content = {
    Text = "Ağ hatası. Lütfen ağınızı kontrol edin."
  },
  SdkErrorCode_68235_Content = {
    Text = "Zayıf ağ bağlantısı. Lütfen ağınızı kontrol edip yeniden deneyin."
  },
  SdkErrorCode_68236_Content = {
    Text = "Ağ bağlantısı yok. Lütfen ağınızı kontrol edip yeniden deneyin."
  },
  SdkErrorCode_68241_Content = {
    Text = "Zayıf ağ bağlantısı. Lütfen ağınızı kontrol edip yeniden deneyin."
  },
  SdkErrorCode_68245_Content = {
    Text = "Ağ bağlantı hatası. Lütfen ağınızı kontrol edin ve tekrar deneyin."
  },
  SdkErrorCode_68246_Content = {
    Text = "Zayıf ağ bağlantısı. Lütfen ağınızı kontrol edip yeniden deneyin."
  },
  SdkErrorCode_68248_Content = {
    Text = "Ağ meşgul. Lütfen daha sonra tekrar deneyin."
  },
  SdkErrorCode_68250_Content = {
    Text = "Dosya indirme hatası. Lütfen cihazınızdaki kullanılabilir depolama alanını kontrol edin."
  },
  SdkErrorCode_68252_Content = {
    Text = "Dosya indirme hatası. Lütfen oyunu yeniden başlatın veya istemciyi onarın."
  },
  SdkErrorCode_68261_Content = {
    Text = "Dosya okuma/yazma hatası. Lütfen oyunu yeniden başlatmayı deneyin."
  },
  SdkErrorCode_68268_Content = {
    Text = "Zayıf ağ bağlantısı. Lütfen ağınızı kontrol edin veya oyunu yeniden başlatıp tekrar deneyin."
  },
  SdkErrorCode_68269_Content = {
    Text = "Zayıf ağ bağlantısı. Lütfen ağınızı kontrol edin veya oyunu yeniden başlatıp tekrar deneyin."
  },
  SdkErrorCode_68278_Content = {
    Text = "Dosya okuma/yazma hatası. Lütfen oyunu yeniden başlatmayı veya istemciyi onarmayı deneyin."
  }
})
return Text_SdkErrorCode
