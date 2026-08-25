__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_SdkErrorCode = readonly({
  SdkErrorCode_67975_Content = {
    Text = "Errore di lettura/scrittura file. Prova a riavviare il gioco o a riparare il client."
  },
  SdkErrorCode_67988_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_67989_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_67990_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_67991_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_67992_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_67993_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_67994_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68020_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68022_Content = {
    Text = "Errore di download file. Controlla lo spazio di archiviazione disponibile sul tuo dispositivo."
  },
  SdkErrorCode_68023_Content = {
    Text = "Connessione di rete scarsa. Controlla la tua rete e riprova."
  },
  SdkErrorCode_68024_Content = {
    Text = "Nessuna connessione di rete. Controlla la tua rete e riprova."
  },
  SdkErrorCode_68027_Content = {
    Text = "Nessuna connessione di rete. Controlla la tua rete e riprova."
  },
  SdkErrorCode_68033_Content = {
    Text = "Errore di lettura/scrittura file. Prova a riavviare il gioco."
  },
  SdkErrorCode_68035_Content = {
    Text = "Errore di lettura/scrittura file. Prova a riavviare il gioco."
  },
  SdkErrorCode_68037_Content = {
    Text = "Se il gioco richiama l'interfaccia di acquisizione più volte in un breve periodo, esiste la possibilità di ricevere un ejoy_token non valido (16 token potrebbero sovrascriversi a vicenda). Utilizzare un tale token per accedere al server di gioco causerà un errore 401."
  },
  SdkErrorCode_68058_Content = {
    Text = "Errore di lettura/scrittura file. Prova a riavviare il gioco o a controllare i permessi dell'app."
  },
  SdkErrorCode_68060_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68061_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68062_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68063_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68064_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68065_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68066_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68067_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68068_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68069_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68071_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68072_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68073_Content = {
    Text = "Errore di lettura/scrittura file. Prova a riavviare il gioco."
  },
  SdkErrorCode_68077_Content = {
    Text = "Errore di lettura della cache. Prova a riavviare il gioco."
  },
  SdkErrorCode_68078_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68082_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68100_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68109_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68110_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68111_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68112_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68113_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68114_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68115_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68116_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68118_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68119_Content = {
    Text = "Errore di lettura/scrittura file. Prova a riavviare il gioco."
  },
  SdkErrorCode_68120_Content = {
    Text = "Errore di lettura/scrittura file. Prova a riavviare il gioco."
  },
  SdkErrorCode_68121_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68133_Content = {
    Text = "Connessione di rete scarsa. Controlla la tua rete o riavvia il gioco e riprova."
  },
  SdkErrorCode_68153_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68158_Content = {
    Text = "Rete occupata. Riprova più tardi."
  },
  SdkErrorCode_68159_Content = {
    Text = "Errore di download file. Controlla lo spazio di archiviazione disponibile sul tuo dispositivo."
  },
  SdkErrorCode_68170_Content = {
    Text = "Rete occupata. Riprova più tardi."
  },
  SdkErrorCode_68173_Content = {
    Text = "Rete occupata. Riprova più tardi."
  },
  SdkErrorCode_68174_Content = {
    Text = "Rete occupata. Riprova più tardi."
  },
  SdkErrorCode_68175_Content = {
    Text = "Rete occupata. Riprova più tardi."
  },
  SdkErrorCode_68176_Content = {
    Text = "Nessuna connessione di rete. Controlla la tua connessione."
  },
  SdkErrorCode_68189_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68190_Content = {
    Text = "Errore di connessione di rete. Prova a riavviare il gioco o a controllare la tua rete."
  },
  SdkErrorCode_68199_Content = {
    Text = "Connessione interrotta. Controlla la tua connessione."
  },
  SdkErrorCode_68201_Content = {
    Text = "Connessione interrotta. Controlla la tua connessione."
  },
  SdkErrorCode_68202_Content = {
    Text = "Errore di rete. Controlla la tua connessione."
  },
  SdkErrorCode_68205_Content = {
    Text = "Connessione interrotta. Controlla la tua connessione."
  },
  SdkErrorCode_68207_Content = {
    Text = "Connessione di rete interrotta. Controlla la tua rete."
  },
  SdkErrorCode_68210_Content = {
    Text = "Errore di rete. Controlla la tua connessione."
  },
  SdkErrorCode_68235_Content = {
    Text = "Connessione di rete scarsa. Controlla la tua rete e riprova."
  },
  SdkErrorCode_68236_Content = {
    Text = "Nessuna connessione di rete. Controlla la tua rete e riprova."
  },
  SdkErrorCode_68241_Content = {
    Text = "Connessione di rete scarsa. Controlla la tua rete e riprova."
  },
  SdkErrorCode_68245_Content = {
    Text = "Errore di connessione di rete. Controlla la tua connessione e riprova."
  },
  SdkErrorCode_68246_Content = {
    Text = "Connessione di rete scarsa. Controlla la tua rete e riprova."
  },
  SdkErrorCode_68248_Content = {
    Text = "Rete occupata. Riprova più tardi."
  },
  SdkErrorCode_68250_Content = {
    Text = "Errore di download file. Controlla lo spazio di archiviazione disponibile sul tuo dispositivo."
  },
  SdkErrorCode_68252_Content = {
    Text = "Errore di download file. Riavvia il gioco o ripara il client."
  },
  SdkErrorCode_68261_Content = {
    Text = "Errore di lettura/scrittura file. Prova a riavviare il gioco."
  },
  SdkErrorCode_68268_Content = {
    Text = "Connessione di rete scarsa. Controlla la tua rete o riavvia il gioco e riprova."
  },
  SdkErrorCode_68269_Content = {
    Text = "Connessione di rete scarsa. Controlla la tua rete o riavvia il gioco e riprova."
  },
  SdkErrorCode_68278_Content = {
    Text = "Errore di lettura/scrittura file. Prova a riavviare il gioco o a riparare il client."
  }
})
return Text_SdkErrorCode
