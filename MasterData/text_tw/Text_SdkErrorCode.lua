__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_SdkErrorCode = readonly({
  SdkErrorCode_67975_Content = {
    Text = "文件讀寫異常，請嘗試重啟遊戲或修復用戶端"
  },
  SdkErrorCode_67988_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_67989_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_67990_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_67991_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_67992_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_67993_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_67994_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68020_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68022_Content = {
    Text = "文件下載異常，請檢查設備剩餘空間"
  },
  SdkErrorCode_68023_Content = {
    Text = "網路不佳，請檢查網路並重試"
  },
  SdkErrorCode_68024_Content = {
    Text = "無網路連接，請檢查網路並重試"
  },
  SdkErrorCode_68027_Content = {
    Text = "無網路連接，請檢查網路並重試"
  },
  SdkErrorCode_68033_Content = {
    Text = "文件讀寫異常，請嘗試重啟遊戲"
  },
  SdkErrorCode_68035_Content = {
    Text = "文件讀寫異常，請嘗試重啟遊戲"
  },
  SdkErrorCode_68037_Content = {
    Text = "遊戲短時間內調用多次acquire接口，一定機率可能拿到其中一個失效的ejoy_token（16個token會互相覆蓋），用來登錄遊戲服就會報401"
  },
  SdkErrorCode_68058_Content = {
    Text = "文件讀寫異常，請嘗試重啟遊戲或檢查應用權限"
  },
  SdkErrorCode_68060_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68061_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68062_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68063_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68064_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68065_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68066_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68067_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68068_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68069_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68071_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68072_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68073_Content = {
    Text = "文件讀寫異常，請嘗試重啟遊戲"
  },
  SdkErrorCode_68077_Content = {
    Text = "緩存讀取異常，請嘗試重啟遊戲"
  },
  SdkErrorCode_68078_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68082_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68100_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68109_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68110_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68111_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68112_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68113_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68114_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68115_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68116_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68118_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68119_Content = {
    Text = "文件讀寫異常，請嘗試重啟遊戲"
  },
  SdkErrorCode_68120_Content = {
    Text = "文件讀寫異常，請嘗試重啟遊戲"
  },
  SdkErrorCode_68121_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68133_Content = {
    Text = "網路不佳，請檢查網路或重啟遊戲後嘗試"
  },
  SdkErrorCode_68153_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68158_Content = {
    Text = "網路繁忙，請稍後重試"
  },
  SdkErrorCode_68159_Content = {
    Text = "文件下載異常，請檢查設備剩餘空間"
  },
  SdkErrorCode_68170_Content = {
    Text = "網路繁忙，請稍後重試"
  },
  SdkErrorCode_68173_Content = {
    Text = "網路繁忙，請稍後重試"
  },
  SdkErrorCode_68174_Content = {
    Text = "網路繁忙，請稍後重試"
  },
  SdkErrorCode_68175_Content = {
    Text = "網路繁忙，請稍後重試"
  },
  SdkErrorCode_68176_Content = {
    Text = "沒有網路連接，請檢查網路"
  },
  SdkErrorCode_68189_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68190_Content = {
    Text = "網路連接異常，請嘗試重啟遊戲或檢查網路"
  },
  SdkErrorCode_68199_Content = {
    Text = "網路中斷，請檢查網路"
  },
  SdkErrorCode_68201_Content = {
    Text = "網路中斷，請檢查網路"
  },
  SdkErrorCode_68202_Content = {
    Text = "網路異常，請檢查網路"
  },
  SdkErrorCode_68205_Content = {
    Text = "網路中斷，請檢查網路"
  },
  SdkErrorCode_68207_Content = {
    Text = "網路連接中斷，請檢查網路"
  },
  SdkErrorCode_68210_Content = {
    Text = "網路異常，請檢查網路"
  },
  SdkErrorCode_68235_Content = {
    Text = "網路不佳，請檢查網路並重試"
  },
  SdkErrorCode_68236_Content = {
    Text = "無網路連接，請檢查網路並重試"
  },
  SdkErrorCode_68241_Content = {
    Text = "網路不佳，請檢查網路並重試"
  },
  SdkErrorCode_68245_Content = {
    Text = "網路連線異常，請檢查網路並重試"
  },
  SdkErrorCode_68246_Content = {
    Text = "網路不佳，請檢查網路並重試"
  },
  SdkErrorCode_68248_Content = {
    Text = "網路繁忙，請稍後重試"
  },
  SdkErrorCode_68250_Content = {
    Text = "文件下載異常，請檢查設備剩餘空間"
  },
  SdkErrorCode_68252_Content = {
    Text = "文件下載異常，請重啟遊戲或修復用戶端"
  },
  SdkErrorCode_68261_Content = {
    Text = "文件讀寫異常，請嘗試重啟遊戲"
  },
  SdkErrorCode_68268_Content = {
    Text = "網路不佳，請檢查網路或重啟遊戲後嘗試"
  },
  SdkErrorCode_68269_Content = {
    Text = "網路不佳，請檢查網路或重啟遊戲後嘗試"
  },
  SdkErrorCode_68278_Content = {
    Text = "文件讀寫異常，請嘗試重啟遊戲或修復用戶端"
  }
})
return Text_SdkErrorCode
