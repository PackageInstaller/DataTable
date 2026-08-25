__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Setup = readonly({
  Setup_117381_SetupTitle = {
    Text = "Voir l'identification de texte"
  },
  Setup_126062_SetupTitle = {Text = "Contour"},
  Setup_132685_SetupDesc = {
    Text = "Voyez quels chapitres ont été traduits par des humains dans votre langue actuelle !"
  },
  Setup_132685_SetupTitle = {
    Text = "Marquer les chapitres de Scénario officiellement traduits dans le Journal du labyrinthe"
  },
  Setup_134015_SetupTitle = {
    Text = "Changer l'arrière-plan de connexion"
  },
  Setup_148459_SetupDesc = {
    Text = "Lorsque le Taux de synchronisation atteint le niveau 20, cet Éveilleur affiche une apparence de carte spéciale dans les combats «Enquête» ou «Échecs de Phase»."
  },
  Setup_148459_SetupTitle = {
    Text = "Effet «Scintilla»"
  },
  Setup_18433_SetupTitle = {
    Text = "Texte du jeu"
  },
  Setup_18434_SetupTitle = {
    Text = "Anticrénelage"
  },
  Setup_18436_SetupTitle = {
    Text = "Rendre Précis"
  },
  Setup_18438_SetupTitle = {
    Text = "Déplacement rouge-bleu"
  },
  Setup_18439_SetupTitle = {Text = "Projection"},
  Setup_18441_SetupTitle = {
    Text = "Menophin Reconstitué"
  },
  Setup_18443_SetupTitle = {
    Text = "Confirmation d'Utilisation d'Aliemus Élever et Posse"
  },
  Setup_18444_SetupTitle = {
    Text = "Qualité de l'image"
  },
  Setup_18445_SetupTitle = {
    Text = "Profondeur de champ"
  },
  Setup_18448_SetupTitle = {
    Text = "Effets de scène"
  },
  Setup_18449_SetupTitle = {
    Text = "Centre utilisateur"
  },
  Setup_18453_SetupTitle = {Text = "Voix"},
  Setup_18454_SetupTitle = {Text = "Musique"},
  Setup_18455_SetupTitle = {
    Text = "Mission terminée"
  },
  Setup_18456_SetupTitle = {
    Text = "Épanouissement"
  },
  Setup_18458_SetupTitle = {
    Text = "Éclairage en Temps Réel"
  },
  Setup_18459_SetupTitle = {
    Text = "Effets Sonores"
  },
  Setup_18460_SetupTitle = {
    Text = "Accord de l'utilisateur"
  },
  Setup_18461_SetupTitle = {
    Text = "Rogner le flou des bords"
  },
  Setup_18462_SetupTitle = {Text = "Volume"},
  Setup_18463_SetupTitle = {
    Text = "Code de rédemption"
  },
  Setup_18466_SetupTitle = {
    Text = "Qualité des Effets Spéciaux"
  },
  Setup_18469_SetupDesc = {
    Text = "30 FPS est plus économe en énergie, tandis que 60 FPS est plus fluide."
  },
  Setup_18469_SetupTitle = {
    Text = "Fréquence d'image cible"
  },
  Setup_21931_SetupTitle = {
    Text = "Contacter le support"
  },
  Setup_24952_SetupDesc = {
    Text = "Une fois activé, l'interface principale et l'interface d'Opération seront affectées par la détection de gravité."
  },
  Setup_24952_SetupTitle = {Text = "Gyroscope"},
  Setup_54468_SetupTitle = {
    Text = "Paramètres Graphiques"
  },
  Setup_54469_SetupTitle = {
    Text = "Résolution"
  },
  Setup_54664_SetupTitle = {
    Text = "Affichez les Raccourcis"
  },
  Setup_54673_SetupTitle = {
    Text = "Choisissez la carte 8"
  },
  Setup_54674_SetupTitle = {
    Text = "Choisissez la carte 9"
  },
  Setup_54675_SetupTitle = {
    Text = "Choisissez la carte 2"
  },
  Setup_54676_SetupTitle = {
    Text = "Choisissez la Carte 3"
  },
  Setup_54677_SetupTitle = {
    Text = "Libérer le Posse"
  },
  Setup_54678_SetupTitle = {
    Text = "Choisissez la carte 6"
  },
  Setup_54679_SetupTitle = {
    Text = "Choisissez la carte 7"
  },
  Setup_54680_SetupTitle = {
    Text = "Choisissez la Carte 4"
  },
  Setup_54681_SetupTitle = {
    Text = "Choisissez la carte 5"
  },
  Setup_54682_SetupTitle = {Text = "Exalter 1"},
  Setup_54683_SetupTitle = {Text = "Exalter 2"},
  Setup_54684_SetupTitle = {Text = "Exalter 3"},
  Setup_54685_SetupTitle = {Text = "Exalter 4"},
  Setup_54686_SetupTitle = {
    Text = "Voir la pile de tirages"
  },
  Setup_54687_SetupTitle = {
    Text = "Choisissez la carte 20"
  },
  Setup_54688_SetupTitle = {
    Text = "Fin de Tour"
  },
  Setup_54689_SetupTitle = {
    Text = "Choisissez la Carte 1"
  },
  Setup_54690_SetupTitle = {
    Text = "Annuler et paramètres"
  },
  Setup_54691_SetupTitle = {
    Text = "Libérer la capacité du domaine 1"
  },
  Setup_54692_SetupTitle = {
    Text = "Sélectionnez la carte 10"
  },
  Setup_54693_SetupTitle = {
    Text = "Choisissez la carte 11"
  },
  Setup_54694_SetupTitle = {
    Text = "Choisissez la carte 12"
  },
  Setup_54695_SetupTitle = {
    Text = "Sélectionnez la carte 13"
  },
  Setup_54696_SetupTitle = {
    Text = "Choisissez la carte 14"
  },
  Setup_54697_SetupTitle = {
    Text = "Choisissez la carte 15"
  },
  Setup_54698_SetupTitle = {
    Text = "Choisissez la carte 16"
  },
  Setup_54699_SetupTitle = {
    Text = "Choisissez la carte 17"
  },
  Setup_54700_SetupTitle = {
    Text = "Choisissez la carte 18"
  },
  Setup_54701_SetupTitle = {
    Text = "Choisissez la carte 19"
  },
  Setup_55509_SetupTitle = {
    Text = "Quitter le jeu"
  },
  Setup_70541_SetupTitle = {
    Text = "Lorsque l'interface du jeu n'est pas la fenêtre active"
  },
  Setup_72153_SetupTitle = {
    Text = "Libérer la capacité du domaine 2"
  },
  Setup_94404_SetupTitle = {
    Text = "Confirmer la carte jouée"
  },
  Setup_94405_SetupTitle = {
    Text = "Carte précédente"
  },
  Setup_94406_SetupTitle = {
    Text = "Prochaine carte"
  },
  Setup_94566_SetupTitle = {
    Text = "Contexte dynamique de la Bataille"
  }
})
return Text_Setup
