__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_SdkErrorCode = readonly({
  SdkErrorCode_67975_Content = {
    Text = "Datei Lese-/Schreibfehler. Bitte versuchen Sie, das Spiel neu zu starten oder den Client zu reparieren."
  },
  SdkErrorCode_67988_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_67989_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_67990_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_67991_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_67992_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_67993_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_67994_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68020_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68022_Content = {
    Text = "Datei-Download-Fehler, bitte überprüfen Sie den verfügbaren Speicherplatz auf dem Gerät"
  },
  SdkErrorCode_68023_Content = {
    Text = "Schlechte Netzwerkverbindung. Bitte überprüfe dein Netzwerk und versuche es erneut."
  },
  SdkErrorCode_68024_Content = {
    Text = "Keine Netzwerkverbindung, bitte überprüfen Sie die Netzwerkverbindung und versuchen Sie es erneut"
  },
  SdkErrorCode_68027_Content = {
    Text = "Keine Netzwerkverbindung, bitte überprüfen Sie die Netzwerkverbindung und versuchen Sie es erneut"
  },
  SdkErrorCode_68033_Content = {
    Text = "Datei Lese-/Schreibfehler. Bitte versuchen Sie, das Spiel neu zu starten."
  },
  SdkErrorCode_68035_Content = {
    Text = "Datei Lese-/Schreibfehler. Bitte versuchen Sie, das Spiel neu zu starten."
  },
  SdkErrorCode_68037_Content = {
    Text = "Wenn das Spiel die Erwerbsschnittstelle innerhalb kurzer Zeit mehrfach aufruft, besteht eine gewisse Wahrscheinlichkeit, eines der ungültigen ejoy_tokens zu erhalten (die 16 Tokens überschreiben sich gegenseitig). Der Versuch, sich mit solch einem Token am Spieleserver anzumelden, führt zu einem 401-Fehler."
  },
  SdkErrorCode_68058_Content = {
    Text = "Datei Lese-/Schreibfehler. Bitte versuchen Sie, das Spiel neu zu starten oder die Anwendungsberechtigungen zu überprüfen."
  },
  SdkErrorCode_68060_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68061_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68062_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68063_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68064_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68065_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68066_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68067_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68068_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68069_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68071_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68072_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68073_Content = {
    Text = "Datei Lese-/Schreibfehler. Bitte versuchen Sie, das Spiel neu zu starten."
  },
  SdkErrorCode_68077_Content = {
    Text = "Cache-Lese-Fehler. Bitte versuche, das Spiel neu zu starten."
  },
  SdkErrorCode_68078_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68082_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68100_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68109_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68110_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68111_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68112_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68113_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68114_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68115_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68116_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68118_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68119_Content = {
    Text = "Datei Lese-/Schreibfehler. Bitte versuchen Sie, das Spiel neu zu starten."
  },
  SdkErrorCode_68120_Content = {
    Text = "Datei Lese-/Schreibfehler. Bitte versuchen Sie, das Spiel neu zu starten."
  },
  SdkErrorCode_68121_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68133_Content = {
    Text = "Netzwerkverbindung schlecht, bitte überprüfen Sie die Netzwerkverbindung oder starten Sie das Spiel neu und versuchen Sie es erneut"
  },
  SdkErrorCode_68153_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68158_Content = {
    Text = "Netzwerk beschäftigt. Bitte versuche es später erneut."
  },
  SdkErrorCode_68159_Content = {
    Text = "Datei-Download-Fehler, bitte überprüfen Sie den verfügbaren Speicherplatz auf dem Gerät"
  },
  SdkErrorCode_68170_Content = {
    Text = "Netzwerk beschäftigt. Bitte versuche es später erneut."
  },
  SdkErrorCode_68173_Content = {
    Text = "Netzwerk beschäftigt. Bitte versuche es später erneut."
  },
  SdkErrorCode_68174_Content = {
    Text = "Netzwerk beschäftigt. Bitte versuche es später erneut."
  },
  SdkErrorCode_68175_Content = {
    Text = "Netzwerk beschäftigt. Bitte versuche es später erneut."
  },
  SdkErrorCode_68176_Content = {
    Text = "Keine Netzwerkverbindung. Bitte überprüfen Sie Ihr Netzwerk."
  },
  SdkErrorCode_68189_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68190_Content = {
    Text = "Netzwerkverbindung fehlerhaft, bitte Spiel neu starten oder Netzwerk überprüfen"
  },
  SdkErrorCode_68199_Content = {
    Text = "Netzwerkverbindung unterbrochen, bitte überprüfen Sie die Netzwerkverbindung"
  },
  SdkErrorCode_68201_Content = {
    Text = "Netzwerkverbindung unterbrochen, bitte überprüfen Sie die Netzwerkverbindung"
  },
  SdkErrorCode_68202_Content = {
    Text = "Netzwerkfehler. Bitte überprüfe dein Netzwerk."
  },
  SdkErrorCode_68205_Content = {
    Text = "Netzwerkverbindung unterbrochen, bitte überprüfen Sie die Netzwerkverbindung"
  },
  SdkErrorCode_68207_Content = {
    Text = "Netzwerkverbindung unterbrochen. Bitte überprüfe dein Netzwerk."
  },
  SdkErrorCode_68210_Content = {
    Text = "Netzwerkfehler. Bitte überprüfe dein Netzwerk."
  },
  SdkErrorCode_68235_Content = {
    Text = "Schlechte Netzwerkverbindung. Bitte überprüfe dein Netzwerk und versuche es erneut."
  },
  SdkErrorCode_68236_Content = {
    Text = "Keine Netzwerkverbindung, bitte überprüfen Sie die Netzwerkverbindung und versuchen Sie es erneut"
  },
  SdkErrorCode_68241_Content = {
    Text = "Schlechte Netzwerkverbindung. Bitte überprüfe dein Netzwerk und versuche es erneut."
  },
  SdkErrorCode_68245_Content = {
    Text = "Netzwerkverbindungsfehler. Bitte überprüfe deine Netzwerkverbindung und versuche es erneut."
  },
  SdkErrorCode_68246_Content = {
    Text = "Schlechte Netzwerkverbindung. Bitte überprüfe dein Netzwerk und versuche es erneut."
  },
  SdkErrorCode_68248_Content = {
    Text = "Netzwerk beschäftigt. Bitte versuche es später erneut."
  },
  SdkErrorCode_68250_Content = {
    Text = "Datei-Download-Fehler, bitte überprüfen Sie den verfügbaren Speicherplatz auf dem Gerät"
  },
  SdkErrorCode_68252_Content = {
    Text = "Dateidownloadfehler. Bitte starten Sie das Spiel neu oder reparieren Sie den Client."
  },
  SdkErrorCode_68261_Content = {
    Text = "Datei Lese-/Schreibfehler. Bitte versuchen Sie, das Spiel neu zu starten."
  },
  SdkErrorCode_68268_Content = {
    Text = "Netzwerkverbindung schlecht, bitte überprüfen Sie die Netzwerkverbindung oder starten Sie das Spiel neu und versuchen Sie es erneut"
  },
  SdkErrorCode_68269_Content = {
    Text = "Netzwerkverbindung schlecht, bitte überprüfen Sie die Netzwerkverbindung oder starten Sie das Spiel neu und versuchen Sie es erneut"
  },
  SdkErrorCode_68278_Content = {
    Text = "Datei Lese-/Schreibfehler. Bitte versuchen Sie, das Spiel neu zu starten oder den Client zu reparieren."
  }
})
return Text_SdkErrorCode
