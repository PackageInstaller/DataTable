__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_SdkErrorCode = readonly({
  SdkErrorCode_67975_Content = {
    Text = "Erreur de lecture/écriture de fichier. Veuillez essayer de redémarrer le jeu ou de réparer le client."
  },
  SdkErrorCode_67988_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_67989_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_67990_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_67991_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_67992_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_67993_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_67994_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68020_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68022_Content = {
    Text = "Erreur lors du téléchargement du fichier, veuillez vérifier l'espace de stockage disponible sur votre appareil"
  },
  SdkErrorCode_68023_Content = {
    Text = "Mauvaise connexion réseau. Veuillez vérifier votre réseau et essayer à nouveau."
  },
  SdkErrorCode_68024_Content = {
    Text = "Aucune connexion réseau, veuillez vérifier votre connexion et réessayer"
  },
  SdkErrorCode_68027_Content = {
    Text = "Aucune connexion réseau, veuillez vérifier votre connexion et réessayer"
  },
  SdkErrorCode_68033_Content = {
    Text = "Erreur de lecture/écriture de fichier. Veuillez essayer de redémarrer le jeu."
  },
  SdkErrorCode_68035_Content = {
    Text = "Erreur de lecture/écriture de fichier. Veuillez essayer de redémarrer le jeu."
  },
  SdkErrorCode_68037_Content = {
    Text = "Si le jeu appelle l'interface d'acquisition plusieurs fois dans un court laps de temps, il y a une certaine probabilité d'obtenir l'un des ejoy_tokens invalides (les 16 jetons s'écraseront les uns sur les autres). Essayer de se connecter au serveur de jeu avec un tel jeton entraînera une erreur 401."
  },
  SdkErrorCode_68058_Content = {
    Text = "Erreur de lecture/écriture de fichier. Veuillez essayer de redémarrer le jeu ou de vérifier les autorisations de l'application."
  },
  SdkErrorCode_68060_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68061_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68062_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68063_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68064_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68065_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68066_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68067_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68068_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68069_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68071_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68072_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68073_Content = {
    Text = "Erreur de lecture/écriture de fichier. Veuillez essayer de redémarrer le jeu."
  },
  SdkErrorCode_68077_Content = {
    Text = "Erreur de lecture du cache. Veuillez redémarrer le jeu."
  },
  SdkErrorCode_68078_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68082_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68100_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68109_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68110_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68111_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68112_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68113_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68114_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68115_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68116_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68118_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68119_Content = {
    Text = "Erreur de lecture/écriture de fichier. Veuillez essayer de redémarrer le jeu."
  },
  SdkErrorCode_68120_Content = {
    Text = "Erreur de lecture/écriture de fichier. Veuillez essayer de redémarrer le jeu."
  },
  SdkErrorCode_68121_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68133_Content = {
    Text = "Réseau instable, veuillez vérifier la connexion réseau ou redémarrer le jeu et réessayer"
  },
  SdkErrorCode_68153_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68158_Content = {
    Text = "Réseau occupé. Veuillez réessayer plus tard."
  },
  SdkErrorCode_68159_Content = {
    Text = "Erreur lors du téléchargement du fichier, veuillez vérifier l'espace de stockage disponible sur votre appareil"
  },
  SdkErrorCode_68170_Content = {
    Text = "Réseau occupé. Veuillez réessayer plus tard."
  },
  SdkErrorCode_68173_Content = {
    Text = "Réseau occupé. Veuillez réessayer plus tard."
  },
  SdkErrorCode_68174_Content = {
    Text = "Réseau occupé. Veuillez réessayer plus tard."
  },
  SdkErrorCode_68175_Content = {
    Text = "Réseau occupé. Veuillez réessayer plus tard."
  },
  SdkErrorCode_68176_Content = {
    Text = "Pas de connexion réseau. Veuillez vérifier votre réseau."
  },
  SdkErrorCode_68189_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68190_Content = {
    Text = "Connexion réseau anormale, veuillez essayer de redémarrer le jeu ou vérifier le réseau"
  },
  SdkErrorCode_68199_Content = {
    Text = "Connexion interrompue, veuillez vérifier votre connexion réseau"
  },
  SdkErrorCode_68201_Content = {
    Text = "Connexion interrompue, veuillez vérifier votre connexion réseau"
  },
  SdkErrorCode_68202_Content = {
    Text = "Erreur de réseau. Veuillez vérifier votre réseau."
  },
  SdkErrorCode_68205_Content = {
    Text = "Connexion interrompue, veuillez vérifier votre connexion réseau"
  },
  SdkErrorCode_68207_Content = {
    Text = "Connexion réseau interrompue. Veuillez vérifier votre réseau."
  },
  SdkErrorCode_68210_Content = {
    Text = "Erreur de réseau. Veuillez vérifier votre réseau."
  },
  SdkErrorCode_68235_Content = {
    Text = "Mauvaise connexion réseau. Veuillez vérifier votre réseau et essayer à nouveau."
  },
  SdkErrorCode_68236_Content = {
    Text = "Aucune connexion réseau, veuillez vérifier votre connexion et réessayer"
  },
  SdkErrorCode_68241_Content = {
    Text = "Mauvaise connexion réseau. Veuillez vérifier votre réseau et essayer à nouveau."
  },
  SdkErrorCode_68245_Content = {
    Text = "Erreur de connexion réseau. Veuillez vérifier votre réseau et réessayer."
  },
  SdkErrorCode_68246_Content = {
    Text = "Mauvaise connexion réseau. Veuillez vérifier votre réseau et essayer à nouveau."
  },
  SdkErrorCode_68248_Content = {
    Text = "Réseau occupé. Veuillez réessayer plus tard."
  },
  SdkErrorCode_68250_Content = {
    Text = "Erreur lors du téléchargement du fichier, veuillez vérifier l'espace de stockage disponible sur votre appareil"
  },
  SdkErrorCode_68252_Content = {
    Text = "Erreur de téléchargement du fichier. Veuillez redémarrer le jeu ou réparer le client."
  },
  SdkErrorCode_68261_Content = {
    Text = "Erreur de lecture/écriture de fichier. Veuillez essayer de redémarrer le jeu."
  },
  SdkErrorCode_68268_Content = {
    Text = "Réseau instable, veuillez vérifier la connexion réseau ou redémarrer le jeu et réessayer"
  },
  SdkErrorCode_68269_Content = {
    Text = "Réseau instable, veuillez vérifier la connexion réseau ou redémarrer le jeu et réessayer"
  },
  SdkErrorCode_68278_Content = {
    Text = "Erreur de lecture/écriture de fichier. Veuillez essayer de redémarrer le jeu ou de réparer le client."
  }
})
return Text_SdkErrorCode
