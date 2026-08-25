__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_SdkErrorCode = readonly({
  SdkErrorCode_67975_Content = {
    Text = "File read/write error. Please try restarting the game or repairing the client."
  },
  SdkErrorCode_67988_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_67989_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_67990_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_67991_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_67992_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_67993_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_67994_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68020_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68022_Content = {
    Text = "File download error. Please check the available storage on your device."
  },
  SdkErrorCode_68023_Content = {
    Text = "Poor network connection. Please check your network and try again."
  },
  SdkErrorCode_68024_Content = {
    Text = "No network connection. Please check your network and try again."
  },
  SdkErrorCode_68027_Content = {
    Text = "No network connection. Please check your network and try again."
  },
  SdkErrorCode_68033_Content = {
    Text = "File read/write error. Please try restarting the game."
  },
  SdkErrorCode_68035_Content = {
    Text = "File read/write error. Please try restarting the game."
  },
  SdkErrorCode_68037_Content = {
    Text = "If the game calls the acquire interface multiple times within a short period, there is a chance of receiving an invalid ejoy_token (16 tokens may overwrite each other). Using such a token to log into the game server will result in a 401 error."
  },
  SdkErrorCode_68058_Content = {
    Text = "File read/write error. Please try restarting the game or checking app permissions."
  },
  SdkErrorCode_68060_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68061_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68062_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68063_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68064_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68065_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68066_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68067_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68068_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68069_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68071_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68072_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68073_Content = {
    Text = "File read/write error. Please try restarting the game."
  },
  SdkErrorCode_68077_Content = {
    Text = "Cache read error. Please try restarting the game."
  },
  SdkErrorCode_68078_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68082_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68100_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68109_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68110_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68111_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68112_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68113_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68114_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68115_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68116_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68118_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68119_Content = {
    Text = "File read/write error. Please try restarting the game."
  },
  SdkErrorCode_68120_Content = {
    Text = "File read/write error. Please try restarting the game."
  },
  SdkErrorCode_68121_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68133_Content = {
    Text = "Poor network connection. Please check your network or restart the game and try again."
  },
  SdkErrorCode_68153_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68158_Content = {
    Text = "Network busy. Please try again later."
  },
  SdkErrorCode_68159_Content = {
    Text = "File download error. Please check the available storage on your device."
  },
  SdkErrorCode_68170_Content = {
    Text = "Network busy. Please try again later."
  },
  SdkErrorCode_68173_Content = {
    Text = "Network busy. Please try again later."
  },
  SdkErrorCode_68174_Content = {
    Text = "Network busy. Please try again later."
  },
  SdkErrorCode_68175_Content = {
    Text = "Network busy. Please try again later."
  },
  SdkErrorCode_68176_Content = {
    Text = "No network connection. Please check your network."
  },
  SdkErrorCode_68189_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68190_Content = {
    Text = "Network connection error. Please try restarting the game or checking your network."
  },
  SdkErrorCode_68199_Content = {
    Text = "Network interrupted. Please check your network."
  },
  SdkErrorCode_68201_Content = {
    Text = "Network interrupted. Please check your network."
  },
  SdkErrorCode_68202_Content = {
    Text = "Network error. Please check your network."
  },
  SdkErrorCode_68205_Content = {
    Text = "Network interrupted. Please check your network."
  },
  SdkErrorCode_68207_Content = {
    Text = "Network connection interrupted. Please check your network."
  },
  SdkErrorCode_68210_Content = {
    Text = "Network error. Please check your network."
  },
  SdkErrorCode_68235_Content = {
    Text = "Poor network connection. Please check your network and try again."
  },
  SdkErrorCode_68236_Content = {
    Text = "No network connection. Please check your network and try again."
  },
  SdkErrorCode_68241_Content = {
    Text = "Poor network connection. Please check your network and try again."
  },
  SdkErrorCode_68245_Content = {
    Text = "Network connection error. Please check your network and try again."
  },
  SdkErrorCode_68246_Content = {
    Text = "Poor network connection. Please check your network and try again."
  },
  SdkErrorCode_68248_Content = {
    Text = "Network busy. Please try again later."
  },
  SdkErrorCode_68250_Content = {
    Text = "File download error. Please check the available storage on your device."
  },
  SdkErrorCode_68252_Content = {
    Text = "File download error. Please restart the game or repair the client."
  },
  SdkErrorCode_68261_Content = {
    Text = "File read/write error. Please try restarting the game."
  },
  SdkErrorCode_68268_Content = {
    Text = "Poor network connection. Please check your network or restart the game and try again."
  },
  SdkErrorCode_68269_Content = {
    Text = "Poor network connection. Please check your network or restart the game and try again."
  },
  SdkErrorCode_68278_Content = {
    Text = "File read/write error. Please try restarting the game or repairing the client."
  }
})
return Text_SdkErrorCode
