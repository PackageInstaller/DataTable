__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_SdkErrorCode = readonly({
  SdkErrorCode_67975_Content = {
    Text = "ファイルの読み書き異常。ゲームを再起動するか、クライアント修復を試みてください。"
  },
  SdkErrorCode_67988_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_67989_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_67990_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_67991_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_67992_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_67993_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_67994_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68020_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68022_Content = {
    Text = "ファイルダウンロード異常。デバイスの残り容量を確認してください。"
  },
  SdkErrorCode_68023_Content = {
    Text = "ネットワーク不良。ネットワークを確認し、再試行してください。"
  },
  SdkErrorCode_68024_Content = {
    Text = "ネットワーク未接続。ネットワークを確認し、再試行してください。"
  },
  SdkErrorCode_68027_Content = {
    Text = "ネットワーク未接続。ネットワークを確認し、再試行してください。"
  },
  SdkErrorCode_68033_Content = {
    Text = "ファイルの読み書き異常。ゲームを再起動してください。"
  },
  SdkErrorCode_68035_Content = {
    Text = "ファイルの読み書き異常。ゲームを再起動してください。"
  },
  SdkErrorCode_68037_Content = {
    Text = "ゲームが短時間に複数回acquireインターフェースを呼び出すと、確率により無効なejoy_tokenのうちの1つ（16個のトークンが互いに上書きされる）を取得する可能性があり、それを使ってゲームサーバーにログインすると401エラーが発生します。"
  },
  SdkErrorCode_68058_Content = {
    Text = "ファイルの読み書き異常。ゲームを再起動するか、アプリ権限を確認してください。"
  },
  SdkErrorCode_68060_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68061_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68062_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68063_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68064_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68065_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68066_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68067_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68068_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68069_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68071_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68072_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68073_Content = {
    Text = "ファイルの読み書き異常。ゲームを再起動してください。"
  },
  SdkErrorCode_68077_Content = {
    Text = "キャッシュ読み込み異常。ゲームを再起動してください。"
  },
  SdkErrorCode_68078_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68082_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68100_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68109_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68110_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68111_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68112_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68113_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68114_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68115_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68116_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68118_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68119_Content = {
    Text = "ファイルの読み書き異常。ゲームを再起動してください。"
  },
  SdkErrorCode_68120_Content = {
    Text = "ファイルの読み書き異常。ゲームを再起動してください。"
  },
  SdkErrorCode_68121_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68133_Content = {
    Text = "ネットワーク不良。ネットワークを確認し、ゲームを再起動してください。"
  },
  SdkErrorCode_68153_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68158_Content = {
    Text = "ネットワークが混雑しています。後ほど再試行してください。"
  },
  SdkErrorCode_68159_Content = {
    Text = "ファイルダウンロード異常。デバイスの残り容量を確認してください。"
  },
  SdkErrorCode_68170_Content = {
    Text = "ネットワークが混雑しています。後ほど再試行してください。"
  },
  SdkErrorCode_68173_Content = {
    Text = "ネットワークが混雑しています。後ほど再試行してください。"
  },
  SdkErrorCode_68174_Content = {
    Text = "ネットワークが混雑しています。後ほど再試行してください。"
  },
  SdkErrorCode_68175_Content = {
    Text = "ネットワークが混雑しています。後ほど再試行してください。"
  },
  SdkErrorCode_68176_Content = {
    Text = "ネットワーク未接続。ネットワークを確認してください。"
  },
  SdkErrorCode_68189_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68190_Content = {
    Text = "ネットワーク接続異常。ゲームを再起動するか、ネットワークを確認してください。"
  },
  SdkErrorCode_68199_Content = {
    Text = "ネットワークが切断されました。ネットワークを確認してください。"
  },
  SdkErrorCode_68201_Content = {
    Text = "ネットワークが切断されました。ネットワークを確認してください。"
  },
  SdkErrorCode_68202_Content = {
    Text = "ネットワーク異常。ネットワークを確認してください。"
  },
  SdkErrorCode_68205_Content = {
    Text = "ネットワークが切断されました。ネットワークを確認してください。"
  },
  SdkErrorCode_68207_Content = {
    Text = "ネットワークが切断されました。ネットワークを確認してください。"
  },
  SdkErrorCode_68210_Content = {
    Text = "ネットワーク異常。ネットワークを確認してください。"
  },
  SdkErrorCode_68235_Content = {
    Text = "ネットワーク不良。ネットワークを確認し、再試行してください。"
  },
  SdkErrorCode_68236_Content = {
    Text = "ネットワーク未接続。ネットワークを確認し、再試行してください。"
  },
  SdkErrorCode_68241_Content = {
    Text = "ネットワーク不良。ネットワークを確認し、再試行してください。"
  },
  SdkErrorCode_68245_Content = {
    Text = "ネットワーク接続異常。ネットワークを確認し、再試行してください。"
  },
  SdkErrorCode_68246_Content = {
    Text = "ネットワーク不良。ネットワークを確認し、再試行してください。"
  },
  SdkErrorCode_68248_Content = {
    Text = "ネットワークが混雑しています。後ほど再試行してください。"
  },
  SdkErrorCode_68250_Content = {
    Text = "ファイルダウンロード異常。デバイスの残り容量を確認してください。"
  },
  SdkErrorCode_68252_Content = {
    Text = "ファイルダウンロード異常。ゲームを再起動するか、クライアントを修復してください。"
  },
  SdkErrorCode_68261_Content = {
    Text = "ファイルの読み書き異常。ゲームを再起動してください。"
  },
  SdkErrorCode_68268_Content = {
    Text = "ネットワーク不良。ネットワークを確認し、ゲームを再起動してください。"
  },
  SdkErrorCode_68269_Content = {
    Text = "ネットワーク不良。ネットワークを確認し、ゲームを再起動してください。"
  },
  SdkErrorCode_68278_Content = {
    Text = "ファイルの読み書き異常。ゲームを再起動するか、クライアント修復を試みてください。"
  }
})
return Text_SdkErrorCode
