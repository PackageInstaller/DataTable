__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TipsType = readonly({
  TipsType_100001_Desc = {
    Text = ": Redémarrage nécessaire après changement de résolution, confirmer ?"
  },
  TipsType_100001_LeftBtnDesc = {Text = "Annuler"},
  TipsType_100001_RightBtnDesc = {Text = "Confirmer"},
  TipsType_100001_Title = {
    Text = ": Confirmation de changement de résolution"
  },
  TipsType_100002_Desc = {
    Text = "En attente que {s1} accepte une invitation à un rematch"
  },
  TipsType_100002_RightBtnDesc = {Text = "Annuler"},
  TipsType_100002_Title = {
    Text = "Encore une partie"
  },
  TipsType_100003_Desc = {
    Text = "{s1} vous invite à une autre partie"
  },
  TipsType_100003_LeftBtnDesc = {Text = "Refuser"},
  TipsType_100003_RightBtnDesc = {Text = "Accepter"},
  TipsType_100003_Title = {
    Text = "Encore une partie"
  },
  TipsType_100004_Desc = {
    Text = "Déjà le fond du dortoir actuel"
  },
  TipsType_100005_Desc = {
    Text = "Le mode de jeu Traphase n'est pas encore activé"
  },
  TipsType_100006_Desc = {
    Text = "La mécanique de traphase de l'adversaire n'est pas activée"
  },
  TipsType_100007_Desc = {
    Text = "Il faut se suivre mutuellement pour lancer un match amical"
  },
  TipsType_100008_Desc = {
    Text = "L'adversaire est hors ligne"
  },
  TipsType_100009_Desc = {
    Text = "L'adversaire est en exploration"
  },
  TipsType_100010_Desc = {
    Text = "Temps d'attente dépassé pour le match amical"
  },
  TipsType_100011_Desc = {
    Text = "Tu as annulé le match amical"
  },
  TipsType_100012_Desc = {
    Text = "Invitation à un match amical refusée"
  },
  TipsType_100012_LeftBtnDesc = {Text = "Confirmer"},
  TipsType_100012_Title = {
    Text = "Avertissement"
  },
  TipsType_100013_Desc = {
    Text = "L'adversaire est hors ligne"
  },
  TipsType_100014_Desc = {
    Text = "L'adversaire est dans un autre mode de jeu"
  },
  TipsType_100015_Desc = {
    Text = "Invitations trop fréquentes, réessayez dans {s1} secondes"
  },
  TipsType_100016_Desc = {
    Text = "L'adversaire a annulé le match amical"
  },
  TipsType_100016_LeftBtnDesc = {Text = "Confirmer"},
  TipsType_100016_Title = {
    Text = "Avertissement"
  },
  TipsType_100017_Desc = {
    Text = "Ce joueur est en match amical"
  },
  TipsType_100017_LeftBtnDesc = {Text = "Confirmer"},
  TipsType_100017_Title = {
    Text = "Avertissement"
  },
  TipsType_100018_Desc = {
    Text = "Cette équipe contient des cartes à utilisation limitée, il est nécessaire de débloquer le sujet central de cette période pour continuer à les utiliser. J'espère combattre à vos côtés une fois de plus ! \n Souhaitez-vous vous rendre maintenant pour débloquer le sujet central ?"
  },
  TipsType_100018_LeftBtnDesc = {Text = "Annuler"},
  TipsType_100018_RightBtnDesc = {Text = "Confirmer"},
  TipsType_100018_Title = {
    Text = "Sujet central expiré"
  },
  TipsType_10001_Desc = {
    Text = "Opération réussie"
  },
  TipsType_100020_Desc = {
    Text = "Le combat est encore en cours, souhaitez-vous poursuivre le combat précédent ?"
  },
  TipsType_100020_LeftBtnDesc = {Text = "Annuler"},
  TipsType_100020_RightBtnDesc = {Text = "Confirmer"},
  TipsType_100020_Title = {
    Text = "Avertissement"
  },
  TipsType_10002_Desc = {
    Text = "Erreur de configuration"
  },
  TipsType_10003_Desc = {
    Text = "Erreur de données du client"
  },
  TipsType_10004_Desc = {
    Text = "Serveur non démarré"
  },
  TipsType_10005_Desc = {
    Text = "Erreur de données du personnage"
  },
  TipsType_10006_Desc = {
    Text = "Pas de données d'éveillés trouvées"
  },
  TipsType_10007_Desc = {
    Text = "L'éveillé a atteint le niveau maximum"
  },
  TipsType_10008_Desc = {
    Text = "Pas assez de points de projet"
  },
  TipsType_10009_Desc = {
    Text = "Le réveilleur n'a pas atteint le niveau maximal, ne peut pas s'illuminer"
  },
  TipsType_100100_Desc = {
    Text = "Une nouvelle version est disponible. Si la mise à jour ne démarre pas automatiquement, veuillez essayer de redémarrer Steam pour vérifier les mises à jour."
  },
  TipsType_100100_RightBtnDesc = {Text = "Confirmer"},
  TipsType_100100_Title = {
    Text = "Notification de mise à jour"
  },
  TipsType_10010_Desc = {
    Text = "Éveil réussi"
  },
  TipsType_10011_Desc = {
    Text = "Aucun personnage créé"
  },
  TipsType_10012_Desc = {
    Text = "Personnage déjà existant"
  },
  TipsType_10013_Desc = {
    Text = "Nom de personnage en double"
  },
  TipsType_10014_Desc = {
    Text = "Erreur de zone du domaine"
  },
  TipsType_10015_Desc = {
    Text = "Impossible de localiser la zone de domaine"
  },
  TipsType_10016_Desc = {
    Text = "Énergie actuelle trop basse"
  },
  TipsType_10017_Desc = {
    Text = "Déverrouillable de {s1} à {s2}"
  },
  TipsType_10018_Desc = {
    Text = "Après avoir atteint ce domaine pour la deuxième fois, vous pouvez procéder à une investigation rapide"
  },
  TipsType_10019_Desc = {
    Text = "Événement terminé"
  },
  TipsType_10020_Desc = {
    Text = "Erreur de type dans la table de configuration d'événement"
  },
  TipsType_10021_Desc = {
    Text = "L'événement n'existe pas"
  },
  TipsType_10022_Desc = {
    Text = "Insuffisance de signes pour acheter"
  },
  TipsType_10023_Desc = {
    Text = "Cette carte ne peut pas être renforcée"
  },
  TipsType_10024_Desc = {
    Text = "Cette carte a atteint sa limite de renforcement"
  },
  TipsType_10025_Desc = {
    Text = "Le marchand ambulant ne vend pas cet article"
  },
  TipsType_10026_Desc = {
    Text = "Pas de récompense"
  },
  TipsType_10027_Desc = {
    Text = "Récompense reçue"
  },
  TipsType_10028_Desc = {
    Text = "Erreur de données d'événement"
  },
  TipsType_10029_Desc = {
    Text = "Article acheté"
  },
  TipsType_10030_Desc = {
    Text = "Énergie insuffisante pour activer le portail, besoin de {s1} énergie"
  },
  TipsType_10031_Desc = {
    Text = "Événement de dialogue de scénario non trouvé"
  },
  TipsType_10032_Desc = {
    Text = "Nombre insuffisant de cartes de commandement de sélection d'événement"
  },
  TipsType_10033_Desc = {
    Text = "Nombre excessif de cartes de commandement de sélection d'événement"
  },
  TipsType_10034_Desc = {
    Text = "La carte de commandement de sélection d'événement n'existe pas"
  },
  TipsType_10035_Desc = {
    Text = "Pas de données dans le pool d'événements aléatoires"
  },
  TipsType_10036_Desc = {
    Text = "Le marchand ambulant ne vend pas cet article"
  },
  TipsType_10037_Desc = {
    Text = "Nombre de créations de sélection d'événement insuffisant"
  },
  TipsType_10038_Desc = {
    Text = "Nombre de créations de sélection d'événement trop élevé"
  },
  TipsType_10039_Desc = {
    Text = "Création de sélection d'événement inexistante"
  },
  TipsType_10040_Desc = {
    Text = "Nœud d'événement non trouvé"
  },
  TipsType_10041_Desc = {
    Text = "Nombre de rafraîchissements du marchand ambulant épuisé"
  },
  TipsType_10042_Desc = {
    Text = "Le nombre de rafraîchissements pour la carte de commande du combat est épuisé"
  },
  TipsType_10043_Desc = {
    Text = "Le nombre de rafraîchissements pour les reliques du combat est épuisé"
  },
  TipsType_10044_Desc = {
    Text = "La fonction de point de contact est verrouillée"
  },
  TipsType_10045_Desc = {
    Text = "Zone d'événement non correspondante ! Zone actuelle : {s1}, zone configurée : {s2}"
  },
  TipsType_10046_Desc = {
    Text = "Nombre de suppressions de cartes dans la boutique d'événements épuisé"
  },
  TipsType_10047_Desc = {
    Text = "Données de module de sujet non trouvées"
  },
  TipsType_10048_Desc = {
    Text = "Unité soumise, pas besoin de soumettre à nouveau"
  },
  TipsType_10049_Desc = {
    Text = "Les sujets sous l'unité ne sont pas tous terminés, impossible de soumettre"
  },
  TipsType_10050_Desc = {
    Text = "Module de sujet non trouvé"
  },
  TipsType_10051_Desc = {
    Text = "Pas de données de sujet pour le niveau"
  },
  TipsType_10052_Desc = {
    Text = "Pas de sujet correspondant à ce domaine"
  },
  TipsType_10053_Desc = {
    Text = "Crédits insuffisants, impossible de réclamer la récompense"
  },
  TipsType_10054_Desc = {
    Text = "Les conditions de récompense ne sont pas encore remplies"
  },
  TipsType_10055_Desc = {
    Text = "Sous-tâches du projet non trouvées"
  },
  TipsType_10056_Desc = {
    Text = "Sous-tâches du projet terminées"
  },
  TipsType_10057_Desc = {
    Text = "Sous-tâches du projet incomplètes"
  },
  TipsType_10058_Desc = {
    Text = "NPC déclenché"
  },
  TipsType_10059_Desc = {
    Text = "Erreur de données NPC"
  },
  TipsType_10060_Desc = {
    Text = "NPC inexistant"
  },
  TipsType_10061_Desc = {
    Text = "Non trouvé dans le domaine secret"
  },
  TipsType_10062_Desc = {
    Text = "Aucune donnée de résonance trouvée"
  },
  TipsType_10063_Desc = {
    Text = "Résonance au niveau maximum"
  },
  TipsType_10064_Desc = {
    Text = "Aucune donnée de niveau de résonance trouvée"
  },
  TipsType_10065_Desc = {
    Text = "Pas de réinitialisation"
  },
  TipsType_10066_Desc = {
    Text = "Conditions d'activation de résonance non remplies"
  },
  TipsType_10067_Desc = {
    Text = "Particules de résonance insuffisantes"
  },
  TipsType_10068_Desc = {
    Text = "Illuminer complété, impossible d'illuminer à nouveau"
  },
  TipsType_10069_Desc = {
    Text = "Matériel requis pour l'illumination insuffisant"
  },
  TipsType_10070_Desc = {
    Text = "Matériaux insuffisants pour l'amélioration du corps éveillé"
  },
  TipsType_10071_Desc = {
    Text = "Coupons insuffisants pour l'amélioration du corps éveillé"
  },
  TipsType_10072_Desc = {
    Text = "Coupons insuffisants pour l'amélioration du corps éveillé"
  },
  TipsType_10073_Desc = {
    Text = "Aucune compétence de réveilleur"
  },
  TipsType_10074_Desc = {
    Text = "Pas encore de compétences de réveilleur déverrouillées"
  },
  TipsType_10075_Desc = {
    Text = "Pas assez d'«Argent» pour le Réveil."
  },
  TipsType_10076_Desc = {
    Text = "Objets insuffisants"
  },
  TipsType_10077_Desc = {
    Text = "Nombre maximum d'achats atteint aujourd'hui"
  },
  TipsType_10078_Desc = {
    Text = "Objet inutilisable"
  },
  TipsType_10079_Desc = {
    Text = "Erreur de quantité d'objets"
  },
  TipsType_10080_Desc = {
    Text = "Compétence au niveau maximum"
  },
  TipsType_10081_Desc = {
    Text = "Matériaux insuffisants, impossible d'améliorer"
  },
  TipsType_10082_Desc = {
    Text = "Fonds insuffisants, impossible de mettre à niveau"
  },
  TipsType_10083_Desc = {
    Text = "Le taux de connexion du réveilleur a atteint le niveau maximum"
  },
  TipsType_10084_Desc = {
    Text = "Cette entité éveillée manque d'esprit homologue"
  },
  TipsType_10085_Desc = {
    Text = "Aucun ID de personnage configuré pour la route de mise à niveau"
  },
  TipsType_10086_Desc = {
    Text = "Carte exclusive introuvable"
  },
  TipsType_10087_Desc = {
    Text = "Carte exclusive non déverrouillée"
  },
  TipsType_10088_Desc = {
    Text = "UUID de la carte exclusive introuvable"
  },
  TipsType_10089_Desc = {
    Text = "Récompense de chapitre non atteinte"
  },
  TipsType_10090_Desc = {
    Text = "Récompense de chapitre reçue"
  },
  TipsType_10091_Desc = {
    Text = "La ligne de scénario choisie n'est pas débloquée"
  },
  TipsType_10092_Desc = {
    Text = "Le donjon choisi n'est pas débloqué"
  },
  TipsType_10093_Desc = {
    Text = "Zone de donjon non débloquée"
  },
  TipsType_10094_Desc = {
    Text = "Balayage de la ligne de scénario non débloqué"
  },
  TipsType_10095_Desc = {
    Text = "Ligne de scénario de défi de donjon non trouvée"
  },
  TipsType_10096_Desc = {
    Text = "Ligne de scénario de défi de donjon non trouvée"
  },
  TipsType_10097_Desc = {
    Text = "Défi terminé, récompense non disponible"
  },
  TipsType_10098_Desc = {
    Text = "Défi non terminé, récompense non disponible"
  },
  TipsType_10099_Desc = {
    Text = "Construction inexistante"
  },
  TipsType_10100_Desc = {
    Text = "Construction au niveau maximum"
  },
  TipsType_10101_Desc = {
    Text = "Conditions insuffisantes pour améliorer/construire le bâtiment"
  },
  TipsType_10102_Desc = {
    Text = "Construction existante, impossible de reconstruire"
  },
  TipsType_10103_Desc = {
    Text = "Objets nécessaires pour améliorer/construire insuffisants"
  },
  TipsType_10104_Desc = {
    Text = "Position occupée par un éveillé, impossible de s'installer"
  },
  TipsType_10105_Desc = {
    Text = "Pas assez d'objets nécessaires pour la synthèse"
  },
  TipsType_10106_Desc = {
    Text = "Pas assez de monnaie pour composer un objet"
  },
  TipsType_10107_Desc = {
    Text = "Objet de synthèse non déverrouillé"
  },
  TipsType_10108_Desc = {
    Text = "Échec de connexion au serveur, veuillez vérifier le réseau et réessayer"
  },
  TipsType_10109_Desc = {
    Text = "Fonction du campement déjà sélectionnée, impossible de choisir à nouveau"
  },
  TipsType_10110_Desc = {
    Text = "Fonction du campement épuisée"
  },
  TipsType_10111_Desc = {
    Text = "Pas de mise à niveau de la carte exclusive, impossible de changer"
  },
  TipsType_10112_Desc = {
    Text = "Pas de changement de la carte exclusive, impossible de changer"
  },
  TipsType_10113_Desc = {
    Text = "Échec du changement de carte exclusive"
  },
  TipsType_10114_Desc = {
    Text = "Obtenez Éveillé{s1}"
  },
  TipsType_10115_Desc = {
    Text = "Obtention répétée de {s1}, convertie en {s2}{s3}"
  },
  TipsType_10116_Desc = {
    Text = "{s1} jetons dépassent la limite, convertis en {s2}{s3}"
  },
  TipsType_10117_Desc = {
    Text = "Log téléchargé avec succès"
  },
  TipsType_10118_Desc = {
    Text = "Commande non correspondante, en attente de la commande {s1}, entrée {s2}"
  },
  TipsType_10119_Desc = {
    Text = "Perdre carte:{s1}; uid:{s2}"
  },
  TipsType_10120_Desc = {
    Text = "Non libérable"
  },
  TipsType_10121_Desc = {
    Text = "Pas de compétence"
  },
  TipsType_10122_Desc = {
    Text = "Compétence en recharge"
  },
  TipsType_10123_Desc = {
    Text = "Nombre d'utilisations de compétence épuisé"
  },
  TipsType_10124_Desc = {
    Text = "Vérifiez si l'ordre de mise à niveau du bâtiment Tid {s1} est cyclique"
  },
  TipsType_10125_Desc = {
    Text = "Vérifiez si le bâtiment Tid {s1} n'a pas de configuration associée"
  },
  TipsType_10126_Desc = {
    Text = "Construction Tid {s1} le niveau réel devrait être {s2}, configuré à {s3}"
  },
  TipsType_10127_Desc = {
    Text = "Type de bâtiment introuvable"
  },
  TipsType_10128_Desc = {
    Text = "Configuration de bâtiment introuvable ou type de bâtiment manquant"
  },
  TipsType_10129_Desc = {
    Text = "Cette mission de scénario n'est pas encore disponible"
  },
  TipsType_10130_Desc = {
    Text = "Retrait réussi"
  },
  TipsType_10131_Desc = {
    Text = "Augmentation réussie de «Ménophine» × {s1}."
  },
  TipsType_10132_Desc = {
    Text = "Réparation terminée"
  },
  TipsType_10133_Desc = {
    Text = "Le GM n'a pas pu trouver l'objet correspondant au nom de l'objet [\"..arg1..\"]"
  },
  TipsType_10134_Desc = {
    Text = "L'événement [\"..arg1..\"] n'existe pas"
  },
  TipsType_10135_Desc = {
    Text = "Actuel : appuyez sur {s1}"
  },
  TipsType_10136_Desc = {
    Text = "Amélioration de compétence réussie"
  },
  TipsType_10137_Desc = {
    Text = "Génération réussie"
  },
  TipsType_10138_Desc = {
    Text = "Modification de l'heure du serveur réussie"
  },
  TipsType_10139_Desc = {
    Text = "Échec de la modification de l'heure du serveur"
  },
  TipsType_10140_Desc = {
    Text = [[
Nombre total de constructions : 17
Cette version temporaire n'ouvre que certaines constructions]]
  },
  TipsType_10141_Desc = {
    Text = "Conditions de déverrouillage du bâtiment non remplies"
  },
  TipsType_10142_Desc = {
    Text = "Construction : {s1} interface de configuration inexistante {s2}"
  },
  TipsType_10143_Desc = {
    Text = "Cette formule de synthèse n'est pas encore débloquée"
  },
  TipsType_10144_Desc = {
    Text = "Matériaux insuffisants"
  },
  TipsType_10145_Desc = {
    Text = "Synthèse réussie"
  },
  TipsType_10146_Desc = {
    Text = "Amélioration réussie"
  },
  TipsType_10147_Desc = {
    Text = "La barre des monstres est vide, la bataille ne peut pas commencer"
  },
  TipsType_10148_Desc = {
    Text = "Récupération de «Ménophine»"
  },
  TipsType_10149_Desc = {
    Text = "L'ID de personnage saisi est en double, impossible d'entrer dans le combat"
  },
  TipsType_10150_Desc = {
    Text = "L'ID {s1} saisi n'existe pas, impossible d'entrer dans le combat"
  },
  TipsType_10151_Desc = {
    Text = ": Le monstre n'a pas d'action correspondante"
  },
  TipsType_10152_Desc = {
    Text = "Non disponible pour l'instant"
  },
  TipsType_10153_Desc = {
    Text = "Pas de cartes dans le deck actuel"
  },
  TipsType_10154_Desc = {
    Text = "D'autres cartes sont en cours d'utilisation, impossible de jouer"
  },
  TipsType_10155_Desc = {
    Text = "Pas dans la main, impossible à jouer"
  },
  TipsType_10156_Desc = {
    Text = "Cette carte ne peut pas être jouée"
  },
  TipsType_10157_Desc = {
    Text = "Cette carte n'a pas de compétence assignée"
  },
  TipsType_10158_Desc = {
    Text = "Cette carte ne peut pas être jouée"
  },
  TipsType_10159_Desc = {
    Text = "Arethmetica insuffisante"
  },
  TipsType_10160_Desc = {
    Text = "Aucun éveillé correspondant sur le terrain"
  },
  TipsType_10161_Desc = {
    Text = "Nombre restant insuffisant"
  },
  TipsType_10162_Desc = {
    Text = "Utiliser la compétence d'exploration"
  },
  TipsType_10163_Desc = {
    Text = "%d cartes de commandement sélectionnées"
  },
  TipsType_10164_Desc = {
    Text = "Limite de quantité atteinte"
  },
  TipsType_10165_Desc = {
    Text = "Non sélectionné"
  },
  TipsType_10166_Desc = {
    Text = "Cette carte ne peut pas être jouée avec de l'arithmetica"
  },
  TipsType_10167_Desc = {
    Text = "Consommation totale dépassée"
  },
  TipsType_10168_Desc = {
    Text = "Cartes sélectionnées : {s1}"
  },
  TipsType_10169_Desc = {
    Text = "Nombre de tentacules au maximum"
  },
  TipsType_10170_Desc = {
    Text = "Retrait réussi"
  },
  TipsType_10171_Desc = {
    Text = "Renforcement réussi"
  },
  TipsType_10172_Desc = {
    Text = "Changement réussi"
  },
  TipsType_10173_Desc = {
    Text = "Copié dans le presse-papiers"
  },
  TipsType_10174_Desc = {
    Text = "Carte de commandement obtenue avec succès"
  },
  TipsType_10175_Desc = {
    Text = "Retrait épuisé"
  },
  TipsType_10176_Desc = {
    Text = "Le nombre de renforcements a été épuisé"
  },
  TipsType_10177_Desc = {
    Text = "Nombre de changements épuisé"
  },
  TipsType_10178_Desc = {
    Text = "Nombre de copies épuisé"
  },
  TipsType_10179_Desc = {
    Text = "Le nombre de cartes de commandement a atteint la limite"
  },
  TipsType_10180_Desc = {
    Text = "Pas encore de carte de commandement choisie"
  },
  TipsType_10181_Desc = {
    Text = "Boutique non ouverte, restez à l'écoute"
  },
  TipsType_10182_Desc = {Text = "À suivre"},
  TipsType_10183_Desc = {
    Text = "Zone cible trop éloignée, impossible de localiser"
  },
  TipsType_10184_Desc = {
    Text = "Zone cible manquée, impossible de compléter"
  },
  TipsType_10185_Desc = {
    Text = "Sujet non débloqué"
  },
  TipsType_10186_Desc = {
    Text = "Déverrouillez plus d'enquêtes en explorant le domaine"
  },
  TipsType_10187_Desc = {
    Text = "Débloquer plus d'enquêtes après avoir terminé les missions préalables"
  },
  TipsType_10188_Desc = {
    Text = "Soumission réussie, points de projet +{s1}"
  },
  TipsType_10189_Desc = {
    Text = "Pas de sujet à soumettre"
  },
  TipsType_10190_Desc = {
    Text = "Non ouvert pour l'instant, veuillez vérifier l'heure d'ouverture du donjon"
  },
  TipsType_10191_Desc = {
    Text = "Conditions de déverrouillage non remplies"
  },
  TipsType_10192_Desc = {
    Text = "{s1} ne peut pas être vide"
  },
  TipsType_10193_Desc = {
    Text = "{s1} et {s2} ne peuvent pas être vides"
  },
  TipsType_10194_Desc = {
    Text = "Rafraîchissements épuisés, impossible de rafraîchir"
  },
  TipsType_10195_Desc = {
    Text = "Méthode d'obtention non débloquée"
  },
  TipsType_10196_Desc = {
    Text = "Méthode d'obtention non disponible"
  },
  TipsType_10197_Desc = {
    Text = "Choisissez la création à modifier"
  },
  TipsType_10198_Desc = {
    Text = "Retrait réussi"
  },
  TipsType_10199_Desc = {
    Text = "Retrait épuisé"
  },
  TipsType_10200_Desc = {
    Text = "Nombre de changements épuisé"
  },
  TipsType_10201_Desc = {
    Text = "Choisissez la création à retirer"
  },
  TipsType_10202_Desc = {
    Text = "Quantité maximale atteinte"
  },
  TipsType_10203_Desc = {
    Text = "Choisissez au moins {s1} créations"
  },
  TipsType_10204_Desc = {
    Text = "Nombre de changements restant : 0, impossible de changer"
  },
  TipsType_10205_Desc = {
    Text = "Toutes les cartes exclusives sont au niveau maximum"
  },
  TipsType_10206_Desc = {
    Text = "Rejet à 0, impossible de réduire"
  },
  TipsType_10207_Desc = {
    Text = "Non disponible pour l'instant"
  },
  TipsType_10208_Desc = {
    Text = "Pas assez d'Ancre d'Esprit, impossible de renforcer"
  },
  TipsType_10209_Desc = {
    Text = "Nécessite que{s1} atteigne le niveau{s2} pour pouvoir exécuter l'illumination"
  },
  TipsType_10210_Desc = {
    Text = "«{s1}» est insuffisant"
  },
  TipsType_10211_Desc = {
    Text = "Pas encore de «{s1}»"
  },
  TipsType_10212_Desc = {
    Text = "Limite de niveau atteinte"
  },
  TipsType_10213_Desc = {
    Text = "Choisissez d'abord les ressources"
  },
  TipsType_10214_Desc = {
    Text = "«{s1}» est insuffisant"
  },
  TipsType_10215_Desc = {
    Text = "Amélioration réussie"
  },
  TipsType_10216_Desc = {
    Text = "Élixir de gnose augmenté"
  },
  TipsType_10217_Desc = {
    Text = "Limite d'illumination atteinte"
  },
  TipsType_10218_Desc = {
    Text = "Échec de l'amélioration"
  },
  TipsType_10219_Desc = {
    Text = "Objets insuffisants, impossible d'améliorer"
  },
  TipsType_10221_Desc = {
    Text = "Amélioration de compétence réussie"
  },
  TipsType_10222_Desc = {
    Text = "Insuffisance de signes, impossible d'acheter"
  },
  TipsType_10223_Desc = {Text = "Épuisé"},
  TipsType_10224_Desc = {
    Text = "Insuffisance de signes, impossible de retirer la carte de commandement"
  },
  TipsType_10225_Desc = {
    Text = "Retirer {s1} cartes de commandement"
  },
  TipsType_10226_Desc = {
    Text = "Cette direction n'est pas encore ouverte, impossible de renforcer"
  },
  TipsType_10227_Desc = {
    Text = "Cette direction a été renforcée au niveau maximum"
  },
  TipsType_10228_Desc = {
    Text = "Veuillez d'abord choisir la direction dans laquelle vous souhaitez renforcer votre carte exclusive"
  },
  TipsType_10229_Desc = {
    Text = "Pas assez d'Ancre d'Esprit, impossible de renforcer"
  },
  TipsType_10230_Desc = {
    Text = "Pas d'éveillé dans ce domaine, impossible de choisir"
  },
  TipsType_10231_Desc = {
    Text = "Créer une équipe"
  },
  TipsType_10232_Desc = {
    Text = "Nom de l'équipe ne peut dépasser {s1} caractères chinois"
  },
  TipsType_10233_Desc = {
    Text = "Nom de l'équipe ne peut pas être vide"
  },
  TipsType_10234_Desc = {
    Text = "Échange réussi"
  },
  TipsType_10235_Desc = {
    Text = "Plus d'«Argent» restant"
  },
  TipsType_10236_Desc = {Text = "Pas moins"},
  TipsType_10237_Desc = {
    Text = "{s1} pas encore ouvert, restez à l'écoute"
  },
  TipsType_10238_Desc = {
    Text = "Invocation non disponible, restez à l'écoute"
  },
  TipsType_10239_Desc = {
    Text = "Fonction de mini-carte du campus non disponible"
  },
  TipsType_10240_Desc = {
    Text = "Débloqué au niveau de projet {s1}"
  },
  TipsType_10241_Desc = {
    Text = "Pas de cartes éligibles"
  },
  TipsType_10242_Desc = {
    Text = "Toutes les cartes de domaine sont améliorées"
  },
  TipsType_10243_Desc = {
    Text = "Aucune carte de commandement à améliorer"
  },
  TipsType_10244_Desc = {
    Text = "Nouveau point de téléportation découvert ! Destination : {s1}"
  },
  TipsType_10245_Desc = {
    Text = "Objet déjà obtenu, impossible de le récupérer à nouveau"
  },
  TipsType_10246_Desc = {
    Text = "Récupération réussie"
  },
  TipsType_10247_Desc = {
    Text = "Retrait réussi"
  },
  TipsType_10248_Desc = {
    Text = "Ouvrir l'interface du sac à dos"
  },
  TipsType_10249_Desc = {
    Text = "Détection d'une déconnexion anormale lors de votre dernière session. Votre «Ménophine» et les fournitures obtenues ont été retournées. Ouvrez votre inventaire pour vérifier."
  },
  TipsType_10250_Desc = {
    Text = "La version AVG ne propose que quelques bâtiments, ici le nombre total est de 17"
  },
  TipsType_10251_Desc = {
    Text = "La version AVG ne propose que quelques bâtiments, ici le nombre total est de 17"
  },
  TipsType_10252_Desc = {
    Text = "La version AVG ne propose que quelques bâtiments, ici le nombre total est de 17"
  },
  TipsType_10253_Desc = {
    Text = "La version AVG ne propose que quelques bâtiments, ici le nombre total est de 17"
  },
  TipsType_10254_Desc = {
    Text = "La version AVG ne propose que quelques bâtiments, ici le nombre total est de 17"
  },
  TipsType_10255_Desc = {
    Text = "La version AVG ne propose que quelques bâtiments, ici le nombre total est de 17"
  },
  TipsType_10256_Desc = {
    Text = "La version AVG ne propose que quelques bâtiments, ici le nombre total est de 17"
  },
  TipsType_10257_Desc = {
    Text = "La version AVG ne propose que quelques bâtiments, ici le nombre total est de 17"
  },
  TipsType_10258_Desc = {
    Text = "La version AVG ne propose que quelques bâtiments, ici le nombre total est de 17"
  },
  TipsType_10259_Desc = {
    Text = "La version AVG ne propose que quelques bâtiments, ici le nombre total est de 17"
  },
  TipsType_10260_Desc = {
    Text = "La version AVG ne propose que quelques bâtiments, ici le nombre total est de 17"
  },
  TipsType_10261_Desc = {
    Text = "La version AVG ne propose que quelques bâtiments, ici le nombre total est de 17"
  },
  TipsType_10262_Desc = {
    Text = "La version AVG ne propose que quelques bâtiments, ici le nombre total est de 17"
  },
  TipsType_10263_Desc = {
    Text = "La version AVG ne propose que quelques bâtiments, ici le nombre total est de 17"
  },
  TipsType_10264_Desc = {
    Text = "La version AVG ne propose que quelques bâtiments, ici le nombre total est de 17"
  },
  TipsType_10265_Desc = {
    Text = "La version AVG ne propose que quelques bâtiments, ici le nombre total est de 17"
  },
  TipsType_10266_Desc = {
    Text = "La version AVG ne propose que quelques bâtiments, ici le nombre total est de 17"
  },
  TipsType_10267_Desc = {
    Text = "Conditions d'utilisation non remplies"
  },
  TipsType_10268_Desc = {
    Text = "Niveau d'enquête 2 débloqué, enquête rapide activée"
  },
  TipsType_10269_Desc = {
    Text = "Connexion interrompue"
  },
  TipsType_10270_Desc = {
    Text = "La connexion au serveur a été interrompue, tu seras redirigé vers la page de connexion un peu plus tard"
  },
  TipsType_10271_Desc = {Text = "Confirmer"},
  TipsType_10272_Desc = {
    Text = "Serveur non disponible, veuillez réessayer plus tard"
  },
  TipsType_10273_Desc = {
    Text = "Opération réussie"
  },
  TipsType_10274_Desc = {
    Text = "Domaine secret correspondant non trouvé"
  },
  TipsType_10275_Desc = {
    Text = "Événement du domaine secret terminé"
  },
  TipsType_10276_Desc = {
    Text = "Erreur de type de configuration de l'événement du domaine secret"
  },
  TipsType_10277_Desc = {
    Text = "Événement du domaine secret inexistant"
  },
  TipsType_10278_Desc = {
    Text = "Insuffisance de signes, impossible d'acheter"
  },
  TipsType_10279_Desc = {
    Text = "Cette carte ne peut pas être renforcée"
  },
  TipsType_10280_Desc = {
    Text = "Cette carte a atteint sa limite de renforcement"
  },
  TipsType_10281_Desc = {
    Text = "Le marchand ambulant ne vend pas cet article"
  },
  TipsType_10282_Desc = {
    Text = "Pas de récompense"
  },
  TipsType_10283_Desc = {
    Text = "Récompense reçue"
  },
  TipsType_10284_Desc = {
    Text = "Erreur de configuration"
  },
  TipsType_10285_Desc = {
    Text = "Erreur de données d'événement"
  },
  TipsType_10286_Desc = {
    Text = "Article acheté"
  },
  TipsType_10287_Desc = {
    Text = "Données de module de sujet non trouvées"
  },
  TipsType_10288_Desc = {
    Text = "Unité soumise, pas besoin de soumettre à nouveau"
  },
  TipsType_10289_Desc = {
    Text = "Les sujets sous l'unité ne sont pas tous terminés, impossible de soumettre"
  },
  TipsType_10290_Desc = {
    Text = "Projet sans module"
  },
  TipsType_10291_Desc = {
    Text = "Pas de données de sujet pour le niveau"
  },
  TipsType_10292_Desc = {
    Text = "Erreur de données du client"
  },
  TipsType_10293_Desc = {
    Text = "Service non démarré"
  },
  TipsType_10294_Desc = {
    Text = "Erreur de données du personnage"
  },
  TipsType_10295_Desc = {
    Text = "Pas de personnage, création nécessaire"
  },
  TipsType_10296_Desc = {
    Text = "Personnage existant, pas besoin de recréer"
  },
  TipsType_10297_Desc = {
    Text = "Nom de personnage en double"
  },
  TipsType_10298_Desc = {
    Text = "Erreur de domaine"
  },
  TipsType_10299_Desc = {
    Text = "Cette ligne de scénario n'est pas encore débloquée, impossible d'entrer"
  },
  TipsType_10300_Desc = {
    Text = "Ici, vous pouvez consulter les effets de terrain et les informations sur les monstres"
  },
  TipsType_10301_Desc = {
    Text = "Débloqué à {s1} avec {s2} {s3}"
  },
  TipsType_10302_Desc = {
    Text = "Débloqué à {s1} avec {s2} {s3}"
  },
  TipsType_10303_Desc = {
    Text = "Conditions de déverrouillage du bâtiment non remplies"
  },
  TipsType_10304_Desc = {
    Text = "Conditions de mise à niveau du bâtiment non remplies"
  },
  TipsType_10305_Desc = {
    Text = "Matériaux d'amélioration de construction insuffisants"
  },
  TipsType_10306_Desc = {
    Text = "Récompense de mission disponible"
  },
  TipsType_10307_Desc = {
    Text = "(Vie réduite de <Negative:10%%>)"
  },
  TipsType_10308_Desc = {
    Text = "À la fin de chaque tour, gagnez un <BuffTipBlock:bouclier> égal au nombre de couches de protection actuelles. Chaque fois que vous subissez des dégâts, la protection diminue de <BuffTip:1> couche"
  },
  TipsType_10309_Desc = {
    Text = "Protection multiple"
  },
  TipsType_10310_Desc = {
    Text = "Endurance sous le seuil d'alerte, risque d'enquête accru"
  },
  TipsType_10311_Desc = {
    Text = "Endurance sous le seuil d'alerte, risque d'enquête très élevé, voulez-vous entrer de force ?"
  },
  TipsType_10312_Desc = {
    Text = "L'endurance est actuellement trop basse pour entrer dans le domaine"
  },
  TipsType_10313_Desc = {
    Text = "Choisissez une carte exclusive de même niveau pour l'échange"
  },
  TipsType_10314_Desc = {
    Text = "Déverrouillé dans cette direction après avoir atteint le niveau 2 d'illumination du réveilleur"
  },
  TipsType_10315_Desc = {
    Text = "Déverrouillé dans cette direction après avoir atteint le niveau 3 d'illumination du réveilleur"
  },
  TipsType_10316_Desc = {Text = "Actuel"},
  TipsType_10317_Desc = {
    Text = "Tous les éveillés n'ont pas débloqué de compétences, impossible de charger"
  },
  TipsType_10318_Desc = {
    Text = "L'énergie de toutes les compétences de réveilleur est pleine"
  },
  TipsType_10319_Desc = {Text = "Utilisé"},
  TipsType_10320_Desc = {
    Text = "Insuffisance de signes"
  },
  TipsType_10321_Desc = {
    Text = "Insuffisance de signes"
  },
  TipsType_10322_Desc = {
    Text = "Insuffisance de signes"
  },
  TipsType_10323_Desc = {
    Text = "Impossible d'obtenir une création déjà possédée"
  },
  TipsType_10324_Desc = {
    Text = "Pas assez de rafraîchissements"
  },
  TipsType_10325_Desc = {
    Text = "Infligera {s1} points de dégâts à notre équipe"
  },
  TipsType_10326_Desc = {Text = "Attaque"},
  TipsType_10327_Desc = {
    Text = "Ici, un aperçu de la mini-carte du niveau sera affiché, permettant aux joueurs de déployer leur stratégie à l'avance"
  },
  TipsType_10328_Desc = {
    Text = "Tu as mis 10 minutes pour terminer un niveau dans un donjon quotidien, où tu as obtenu une expérience de jeu unique et renforcé tes connaissances de classe grâce à la conception du niveau"
  },
  TipsType_10329_Desc = {
    Text = "Actuellement, le maximum de vie est inférieur à 50 % du maximum"
  },
  TipsType_10330_Desc = {
    Text = ": Énergie pour maintenir l'éveil. Les dégâts réduisent la vie, et la vie à zéro signifie échec de l'enquête"
  },
  TipsType_10331_Desc = {
    Text = "C'est la manifestation de la puissance d'attaque du réveilleur. Plus la puissance est forte, plus les dégâts infligés à l'ennemi en utilisant la carte de commandement sont élevés"
  },
  TipsType_10332_Desc = {
    Text = "La manifestation de la capacité défensive du réveilleur. Plus l’alerte est élevée, plus le bouclier obtenu lors de l'utilisation de la carte de commandement est important"
  },
  TipsType_10333_Desc = {
    Text = "Cliquez n'importe où pour continuer"
  },
  TipsType_10334_Desc = {
    Text = "Enquête de mission non terminée"
  },
  TipsType_10335_Desc = {
    Text = "Évaluation d'enquête"
  },
  TipsType_10336_Desc = {
    Text = "Donner un esprit de révélation à une carte exclusive"
  },
  TipsType_10337_Desc = {
    Text = "Choisissez la direction de renforcement de la carte exclusive"
  },
  TipsType_10338_Desc = {
    Text = "La mini-carte de la ville principale n'est pas encore disponible, restez à l'écoute"
  },
  TipsType_10339_Desc = {
    Text = "{s1}{s2} valeur"
  },
  TipsType_10340_Desc = {
    Text = "Niveau de base du deck {s1} augmenté"
  },
  TipsType_10341_Desc = {
    Text = "<Positive:Affinité：>"
  },
  TipsType_10342_Desc = {
    Text = "Représentation des liens émotionnels avec les éveillés. Plus l'affection augmente, plus tu peux comprendre les éveillés"
  },
  TipsType_10343_Desc = {
    Text = "<Positive:Niveau actuel：>{s1}"
  },
  TipsType_10344_Desc = {
    Text = "<Positive:Deck de base：>"
  },
  TipsType_10345_Desc = {
    Text = "Deck de départ lors de l'entrée dans le donjon de ce domaine"
  },
  TipsType_10346_Desc = {
    Text = "<Positive:Niveau maximum du deck：>{s1} niveau"
  },
  TipsType_10347_Desc = {
    Text = "<Positive:Niveau du deck：>"
  },
  TipsType_10348_Desc = {
    Text = "Ce domaine peut améliorer le deck de base lorsque le nombre spécifié d'entités éveillées atteint le niveau de sympathie requis"
  },
  TipsType_10349_Desc = {
    Text = "<Positive:Contenu de la mise à jour：>"
  },
  TipsType_10350_Desc = {
    Text = "Chaque montée de niveau augmentera la valeur de base d'une carte de commande"
  },
  TipsType_10351_Desc = {
    Text = "Affinité de {s1} augmentée"
  },
  TipsType_10352_Desc = {
    Text = "Le domaine est en sommeil"
  },
  TipsType_10353_Desc = {
    Text = "Le domaine repousse les intrus"
  },
  TipsType_10354_Desc = {
    Text = "Le rejet du domaine augmente"
  },
  TipsType_10355_Desc = {
    Text = "Le niveau de rejet atteint {s1}, le domaine vous observe"
  },
  TipsType_10356_Desc = {
    Text = "Illuminer 1"
  },
  TipsType_10357_Desc = {
    Text = "Maîtriser cette compétence"
  },
  TipsType_10358_Desc = {
    Text = "Nombre maximum de tentacules simultanés"
  },
  TipsType_10359_Desc = {
    Text = "Représentation de la force d'attaque des tentacules. Plus la force des tentacules est élevée, plus les dégâts infligés à l'ennemi sont importants"
  },
  TipsType_10360_Desc = {
    Text = "Pas encore de carte de commandement choisie"
  },
  TipsType_10361_Desc = {
    Text = "Changement réussi"
  },
  TipsType_10362_Desc = {
    Text = "Pas encore de carte de commandement choisie"
  },
  TipsType_10363_Desc = {
    Text = "Copie réussie"
  },
  TipsType_10364_Desc = {
    Text = "{s1} cartes de commandement sélectionnées"
  },
  TipsType_10365_Desc = {
    Text = "Pas encore de carte de commandement choisie"
  },
  TipsType_10366_Desc = {
    Text = "Pas encore de carte de commandement choisie"
  },
  TipsType_10367_Desc = {
    Text = "Amélioration réussie"
  },
  TipsType_10368_Desc = {
    Text = "Interface de sac à dos des créations en développement, restez à l'écoute"
  },
  TipsType_10369_Desc = {
    Text = "Choisissez la création à modifier"
  },
  TipsType_10370_Desc = {
    Text = "Mise à jour, veuillez réinstaller le package"
  },
  TipsType_10371_Desc = {
    Text = "Effet avancé"
  },
  TipsType_10372_Desc = {
    Text = "Informations du domaine secret"
  },
  TipsType_10373_Desc = {
    Text = "Chaque fois que vous utilisez une carte de dégâts, les tentacules infligent {s1} points de dégâts à un ennemi aléatoire"
  },
  TipsType_10374_Desc = {
    Text = "Aucun sujet en attente"
  },
  TipsType_10375_Desc = {
    Text = "Aucun sujet archivé"
  },
  TipsType_10376_Desc = {
    Text = "Enquête incomplète"
  },
  TipsType_10377_Desc = {
    Text = "Pas de retour en arrière"
  },
  TipsType_10378_Desc = {
    Text = "(Les sujets suivants ont été archivés automatiquement)"
  },
  TipsType_10379_Desc = {
    Text = "Sujet terminé"
  },
  TipsType_10380_Desc = {
    Text = "Vous n'avez pas cet objet"
  },
  TipsType_10381_Desc = {
    Text = "Index erroné"
  },
  TipsType_10382_Desc = {
    Text = "Non déverrouillé"
  },
  TipsType_10383_Desc = {
    Text = "Pas de mise à niveau de la carte exclusive"
  },
  TipsType_10384_Desc = {
    Text = "1 emplacement de création débloqué !"
  },
  TipsType_10385_Desc = {
    Text = "Taux de connexion augmenté"
  },
  TipsType_10386_Desc = {
    Text = "Pas d'informations de slot"
  },
  TipsType_10387_Desc = {
    Text = "Fonds insuffisants"
  },
  TipsType_10388_Desc = {
    Text = "Niveau maximum atteint"
  },
  TipsType_10389_Desc = {
    Text = "En développement, restez à l'écoute"
  },
  TipsType_10390_Desc = {
    Text = "Plus de tentatives de mise à niveau manuelle"
  },
  TipsType_10391_Desc = {
    Text = "Utilisable après avoir levé le sceau dans la boutique ou le camp"
  },
  TipsType_10392_Desc = {
    Text = "Cette bataille coûte {s1} de vitalité"
  },
  TipsType_10393_Desc = {
    Text = "L'énergie de l'éveillé est pleine, impossible de continuer à augmenter"
  },
  TipsType_10394_Desc = {
    Text = "Énergie de tous les réveils augmentée"
  },
  TipsType_10395_Desc = {
    Text = "Nécessite l'utilisation de l'« Œil » pour déverrouiller"
  },
  TipsType_10396_Desc = {
    Text = "Impression réussie"
  },
  TipsType_10397_Desc = {
    Text = "Déployé{s1} éveillé, l'équipe portera{s2} la caractéristique du domaine"
  },
  TipsType_10398_Desc = {
    Text = "L'équipe deviendra neutre, sans aucune caractéristique de domaine"
  },
  TipsType_10399_Desc = {
    Text = ": Le système de micro-circulation est validé au chapitre 4"
  },
  TipsType_10400_Desc = {
    Text = "Vous pouvez hériter de jusqu'à {s1} créations, veuillez réduire le nombre de créations sélectionnées"
  },
  TipsType_10401_Desc = {
    Text = "Les créations non cochées ne peuvent pas être héritées"
  },
  TipsType_10405_Desc = {
    Text = "Obtenir {s1}"
  },
  TipsType_10406_Desc = {
    Text = "Nombre maximum de réveils en formation atteint"
  },
  TipsType_10407_Desc = {
    Text = "Cette tour d'or est impossible à défier"
  },
  TipsType_10408_Desc = {
    Text = "Cette tour d'or n'est pas débloquée-complétez le donjon d'enquête spécifié"
  },
  TipsType_10409_Desc = {
    Text = "Choisissez l'éveillé à envoyer"
  },
  TipsType_10410_Desc = {
    Text = "Le réveilleur s'efforce d'accomplir une mission d'envoi, viens la récupérer plus tard"
  },
  TipsType_10411_Desc = {
    Text = "{s1} roses dorées reçues"
  },
  TipsType_10412_Desc = {
    Text = "La récompense temporelle doit s'accumuler avec le temps"
  },
  TipsType_10413_Desc = {
    Text = "«Argent» insuffisant"
  },
  TipsType_10414_Desc = {
    Text = "Pas de tentatives de défi"
  },
  TipsType_10415_Desc = {
    Text = "Défi en cours de recharge"
  },
  TipsType_10416_Desc = {
    Text = "Pas d'adversaire à défier"
  },
  TipsType_10417_Desc = {
    Text = "Choisissez l'éveillé à déployer"
  },
  TipsType_10418_Desc = {
    Text = "Élixir de gnose insuffisant, niveau de progression impossible"
  },
  TipsType_10419_Desc = {
    Text = "Niveau max atteint"
  },
  TipsType_10420_Desc = {
    Text = "L'éveillé n'est pas encore débloqué"
  },
  TipsType_10421_Desc = {
    Text = "Annulation de la collection réussie"
  },
  TipsType_10422_Desc = {
    Text = "Nombre d'achats de défis de la ligne de scénario insuffisant"
  },
  TipsType_10423_Desc = {
    Text = "Étoiles de la ligne de scénario insuffisantes, balayage impossible"
  },
  TipsType_10424_Desc = {
    Text = "Erreur de composition de l'équipe d'enquête"
  },
  TipsType_10425_Desc = {
    Text = "«Argent» insuffisant"
  },
  TipsType_10426_Desc = {
    Text = "Nombre maximum d'achats de bons atteint aujourd'hui"
  },
  TipsType_10427_Desc = {
    Text = "Déverrouillé après avoir terminé le royaume secret avec trois étoiles"
  },
  TipsType_10428_Desc = {
    Text = ": Obtenu {s1} certificats"
  },
  TipsType_10429_Desc = {
    Text = ": Obtenu {s1} tentatives de défi"
  },
  TipsType_10430_Desc = {
    Text = "Terminer Enquête 4-6 Débloqué"
  },
  TipsType_10431_Desc = {
    Text = "Preuve insuffisante"
  },
  TipsType_10432_Desc = {
    Text = "Nombre d'achats par preuve insuffisant"
  },
  TipsType_10433_Desc = {
    Text = "Niveau d'illumination atteint le maximum"
  },
  TipsType_10434_Desc = {
    Text = "«{s1}» est insuffisant"
  },
  TipsType_10435_Desc = {
    Text = "Pas de produit à vendre"
  },
  TipsType_10436_Desc = {
    Text = "Pas de type de magasin"
  },
  TipsType_10437_Desc = {
    Text = "L'article vendu est en rupture de stock"
  },
  TipsType_10438_Desc = {
    Text = "Pas de données de magasin"
  },
  TipsType_10439_Desc = {
    Text = "Pas de tentatives de rafraîchissement"
  },
  TipsType_10440_Desc = {
    Text = "La limite d'achat de «Ménophine» du jour a été atteinte."
  },
  TipsType_10441_Desc = {
    Text = "Fragments de l'éveillé insuffisants"
  },
  TipsType_10442_Desc = {
    Text = "Le point d'illumination a été activé"
  },
  TipsType_10443_Desc = {
    Text = "Le point d'illumination précédent n'est pas activé"
  },
  TipsType_10444_Desc = {
    Text = "Achat réussi de « Ménophine » × {s1}."
  },
  TipsType_10445_Desc = {
    Text = "Limite de « Ménophine » atteinte"
  },
  TipsType_10446_Desc = {
    Text = "Débloqué après avoir terminé Enquête 1-12"
  },
  TipsType_10447_Desc = {
    Text = "Débloqué après avoir terminé le Prologue"
  },
  TipsType_10448_Desc = {
    Text = "Débloqué après avoir terminé le Prologue"
  },
  TipsType_10449_Desc = {
    Text = "Débloqué après avoir terminé Enquête 2-4"
  },
  TipsType_10450_Desc = {
    Text = "Ce niveau de compétence est déjà au maximum"
  },
  TipsType_10451_Desc = {
    Text = "Le rang d'élévation du réveilleur est insuffisant"
  },
  TipsType_10452_Desc = {
    Text = "Matériaux d'amélioration de compétence insuffisants"
  },
  TipsType_10453_Desc = {
    Text = "Débloqué après avoir terminé Enquête 3-15"
  },
  TipsType_10454_Desc = {
    Text = "Débloqué après avoir terminé Enquête 3-7"
  },
  TipsType_10455_Desc = {
    Text = "Conditions d'amélioration de compétence non remplies"
  },
  TipsType_10456_Desc = {
    Text = "Chaque option de recharge de la version de test ne peut être effectuée qu'une seule fois"
  },
  TipsType_10457_Desc = {
    Text = "Ce réveilleur a un temps de recharge d'arrivée de genèse, relâchez-le au prochain tour"
  },
  TipsType_10458_Desc = {
    Text = "Aucune configuration de recharge trouvée"
  },
  TipsType_10459_Desc = {
    Text = "Recharge gratuite déjà effectuée, impossible de recharger à nouveau"
  },
  TipsType_10460_Desc = {
    Text = "Résonance activée, pas besoin de réactiver"
  },
  TipsType_10461_Desc = {
    Text = "Le prix de l'objet {s1} a changé, veuillez vérifier"
  },
  TipsType_10462_Desc = {
    Text = "Rose dorée insuffisante"
  },
  TipsType_10463_Desc = {
    Text = "« Insigne d'exercice » insuffisant"
  },
  TipsType_10464_Desc = {
    Text = "Terminer Enquête 3-4 Débloqué"
  },
  TipsType_10465_Desc = {
    Text = "Terminer Enquête 2-16 Débloqué"
  },
  TipsType_10466_Desc = {
    Text = "Terminer Enquête 3-16 Débloqué"
  },
  TipsType_10467_Desc = {
    Text = "Terminer Enquête 4-12 Débloqué"
  },
  TipsType_10468_Desc = {
    Text = "Terminer Enquête 5-12 Débloqué"
  },
  TipsType_10469_Desc = {
    Text = "Terminer Enquête 6-12 Débloqué"
  },
  TipsType_10470_Desc = {
    Text = "Terminer Enquête 1-7 Débloqué"
  },
  TipsType_10471_Desc = {
    Text = "Équipement réussi"
  },
  TipsType_10472_Desc = {
    Text = "Désinstallation réussie"
  },
  TipsType_10473_Desc = {
    Text = "Niveau max atteint"
  },
  TipsType_10474_Desc = {
    Text = "Rose dorée insuffisante"
  },
  TipsType_10475_Desc = {
    Text = "Choisissez des matériaux"
  },
  TipsType_10476_Desc = {
    Text = "Protégé par un verrou, veuillez d'abord le déverrouiller"
  },
  TipsType_10477_Desc = {
    Text = "Niveau non ouvert"
  },
  TipsType_10478_Desc = {
    Text = "Combat non ouvert à l'extérieur"
  },
  TipsType_10479_Desc = {
    Text = "Pile de défausse vide"
  },
  TipsType_10480_Desc = {
    Text = "Ajustements de la bataille RPG en cours, victoire calculée directement"
  },
  TipsType_10482_Desc = {
    Text = "Roulette du destin verrouillée"
  },
  TipsType_10483_Desc = {
    Text = "Roulette du destin non trouvée"
  },
  TipsType_10484_Desc = {
    Text = "Roulette du destin au niveau maximum"
  },
  TipsType_10485_Desc = {
    Text = "Roulette du destin équipée"
  },
  TipsType_10486_Desc = {
    Text = "Roulette du destin non correspondante"
  },
  TipsType_10487_Desc = {
    Text = "Roulette du destin non verrouillée"
  },
  TipsType_10488_Desc = {
    Text = "Le pacte en cours dans la « composition d'équipe », « assistance » et « proposition de pacte » ne peut être décomposé."
  },
  TipsType_10489_Desc = {
    Text = "En cours de roue du destin dans la \"composition d'équipe\", ne peut être décomposé"
  },
  TipsType_10490_Desc = {
    Text = "Pas assez de points de folie pour libérer l'exaltation"
  },
  TipsType_10491_Desc = {
    Text = "Obtenez d'abord le précédent pack"
  },
  TipsType_10492_Desc = {
    Text = "Le pacte actuel est verrouillé, déverrouillez-le pour être utilisé comme matériaux de consommation"
  },
  TipsType_10493_Desc = {
    Text = "Le cycle actuel est verrouillé, déverrouillez-le pour être utilisé comme matériaux de consommation"
  },
  TipsType_10494_Desc = {
    Text = "Terminer Enquête 1-7 Débloqué"
  },
  TipsType_10495_Desc = {
    Text = "Terminer Enquête 1-13 Débloqué"
  },
  TipsType_10496_Desc = {
    Text = "Le niveau actuel du pacte est au maximum"
  },
  TipsType_10497_Desc = {
    Text = "Magasin réinitialisé"
  },
  TipsType_10498_Desc = {
    Text = "Changement réussi"
  },
  TipsType_10499_Desc = {
    Text = "Collection réussie"
  },
  TipsType_10500_Desc = {
    Text = "Empilement réussi"
  },
  TipsType_10501_Desc = {
    Text = "Défi non débloqué"
  },
  TipsType_10502_Desc = {
    Text = "L'entité éveillée actuelle a déjà été défiée dans d'autres niveaux de {s1}, ne peut pas être utilisée à nouveau"
  },
  TipsType_10503_Desc = {
    Text = "Pas assez de réveils en formation, impossible de défier"
  },
  TipsType_10504_Desc = {
    Text = "Terminer Enquête 3-7 Débloqué"
  },
  TipsType_10505_Desc = {
    Text = "Débloqué en atteignant 3 étoiles au niveau 1"
  },
  TipsType_10506_Desc = {
    Text = "Débloqué en atteignant 3 étoiles au niveau 2"
  },
  TipsType_10507_Desc = {
    Text = "Débloqué en atteignant 3 étoiles au niveau 3"
  },
  TipsType_10508_Desc = {
    Text = "Débloqué en atteignant 3 étoiles au niveau 4"
  },
  TipsType_10509_Desc = {
    Text = "Débloqué en atteignant 3 étoiles au niveau 5"
  },
  TipsType_10510_Desc = {
    Text = "Débloqué en atteignant 3 étoiles au niveau 6"
  },
  TipsType_10511_Desc = {
    Text = "Débloqué en atteignant 3 étoiles au niveau 7"
  },
  TipsType_10512_Desc = {
    Text = "Débloqué en atteignant 3 étoiles au niveau 8"
  },
  TipsType_10513_Desc = {
    Text = "Veuillez choisir le pacte que vous souhaitez renforcer"
  },
  TipsType_10514_Desc = {Text = "Réclamé"},
  TipsType_10515_Desc = {
    Text = "Terminer Enquête 2-14 Débloqué"
  },
  TipsType_10516_Desc = {
    Text = "Terminer Enquête 4-7 Débloqué"
  },
  TipsType_10517_Desc = {
    Text = "Terminer Enquête 4-7 Débloqué"
  },
  TipsType_10518_Desc = {
    Text = "Composition d'équipe sauvegardée"
  },
  TipsType_10519_Desc = {
    Text = "Touchez la zone lumineuse pour vous déplacer"
  },
  TipsType_10520_Desc = {
    Text = "Nom de l'équipe ne peut contenir que des caractères chinois, anglais ou numériques"
  },
  TipsType_10521_Desc = {
    Text = "Nom de l'équipe ne peut dépasser 8 caractères"
  },
  TipsType_10522_Desc = {
    Text = "Pas assez de membres éveillés dans l'équipe, il en faut {s1} pour enquêter"
  },
  TipsType_10523_Desc = {
    Text = "Le réveilleur a participé à d'autres combats dans cette dimension sombre"
  },
  TipsType_10524_Desc = {
    Text = "L'équipe compte déjà deux éveillés de domaines différents, impossible de sélectionner d'autres éveillés de domaines."
  },
  TipsType_10525_Desc = {
    Text = "Sélectionnez un éveillé"
  },
  TipsType_10526_Desc = {
    Text = "Impossible de sélectionner plus d'éveillés"
  },
  TipsType_10527_Desc = {
    Text = "Note d'élevage : Dans la plongée fantomale, les niveaux de réveilleur et de compétence sont réglés à 1"
  },
  TipsType_10528_Desc = {
    Text = "Nom de l'équipe ne peut pas être vide"
  },
  TipsType_10529_Desc = {
    Text = "Il y a un réveilleur épuisé dans l'équipe, ne pouvant plus combattre"
  },
  TipsType_10530_Desc = {
    Text = "Tous les pièces jointes de la boîte aux lettres ont été récupérées"
  },
  TipsType_10531_Desc = {
    Text = "Terminer le prologue pour débloquer"
  },
  TipsType_10532_Desc = {
    Text = "Sac à dos plein, récompenses non récupérées, videz le sac pour continuer"
  },
  TipsType_10533_Desc = {
    Text = "Sac à dos plein, récompenses envoyées par courrier"
  },
  TipsType_10534_Desc = {
    Text = "Le sac à dos est plein, toutes les ressources n'ont pas été récupérées, il faut nettoyer le sac à dos avant de continuer à récupérer"
  },
  TipsType_10535_Desc = {
    Text = "Pas de pièce jointe à récupérer"
  },
  TipsType_10536_Desc = {
    Text = "Échangez d'abord les créations"
  },
  TipsType_10537_Desc = {
    Text = "Débloqué après avoir terminé Enquête 2-4"
  },
  TipsType_10538_Desc = {
    Text = "Débloqué après avoir terminé Enquête 1-12"
  },
  TipsType_10539_Desc = {
    Text = "Débloqué après avoir terminé Enquête 1-12"
  },
  TipsType_10540_Desc = {
    Text = "Débloqué après avoir terminé Enquête 1-12"
  },
  TipsType_10541_Desc = {
    Text = "Débloqué en atteignant 3 étoiles au niveau 9"
  },
  TipsType_10542_Desc = {
    Text = "Débloqué en atteignant 3 étoiles au niveau 10"
  },
  TipsType_10543_Desc = {
    Text = "Débloqué en atteignant 3 étoiles au niveau 11"
  },
  TipsType_10544_Desc = {
    Text = "Débloqué en atteignant 3 étoiles au niveau 12"
  },
  TipsType_10545_Desc = {
    Text = "Débloqué en atteignant 3 étoiles au niveau 13"
  },
  TipsType_10546_Desc = {
    Text = "Débloqué en atteignant 3 étoiles au niveau 14"
  },
  TipsType_10547_Desc = {
    Text = "Cette fonctionnalité sera bientôt supprimée"
  },
  TipsType_10548_Desc = {
    Text = "Débloqué après avoir terminé Enquête 1-7"
  },
  TipsType_10549_Desc = {
    Text = "Limite de créations atteinte, impossible d'en obtenir plus"
  },
  TipsType_10550_Desc = {
    Text = "Lien de {s1} complété, vous pouvez maintenant la commander au combat !"
  },
  TipsType_10551_Desc = {
    Text = "{s1} a un niveau et compétence qui dépassent le niveau fourni par l'amplificateur de gnose, ne peut pas être utilisé"
  },
  TipsType_10552_Desc = {
    Text = "Le niveau du réveilleur et le niveau de compétence ont dépassé le niveau fourni par l'amplificateur de gnose, impossible à utiliser"
  },
  TipsType_10553_Desc = {Text = "À suivre"},
  TipsType_10554_Desc = {
    Text = "Débloqué après avoir passé le niveau précédent"
  },
  TipsType_10555_Desc = {
    Text = "Pas de retour sur le chemin fragile"
  },
  TipsType_10556_Desc = {
    Text = "Non disponible, restez à l'écoute"
  },
  TipsType_10557_Desc = {
    Text = "Vous possédez déjà cette création, impossible de l'obtenir à nouveau"
  },
  TipsType_10558_Desc = {
    Text = "Sur le point de récupérer le contenu du presse-papiers du système et <Positive:[Coller]> , \nConfirmer ?"
  },
  TipsType_10558_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10558_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10558_Title = {
    Text = "Activer la fonction de collage"
  },
  TipsType_10559_Desc = {
    Text = "Matériaux d'édification insuffisants"
  },
  TipsType_10560_Desc = {
    Text = "Déjà en état initial"
  },
  TipsType_10561_Desc = {
    Text = "Rose dorée insuffisante"
  },
  TipsType_10562_Desc = {
    Text = "Non élevé"
  },
  TipsType_10563_Desc = {
    Text = "Réinitialisation de résonance réussie"
  },
  TipsType_10564_Desc = {
    Text = "Niveau d'enquête {s1} atteint, débloqué"
  },
  TipsType_10565_Desc = {
    Text = "La folie scellée ne peut pas être libérée"
  },
  TipsType_1056601_Desc = {
    Text = "Communication de cœur d'argent anormale, veuillez vérifier le réseau et réessayer ({s1})"
  },
  TipsType_10566_Desc = {
    Text = "Communication de cœur d'argent anormale, veuillez réessayer plus tard ({s1})"
  },
  TipsType_10567_Desc = {
    Text = "Échec de l'obtention des informations du serveur ! {s1}"
  },
  TipsType_10568_Desc = {
    Text = "Choisissez d'abord le serveur"
  },
  TipsType_10569_Desc = {
    Text = "Pas encore débloqué"
  },
  TipsType_10570_Desc = {
    Text = "Entrez le compte"
  },
  TipsType_10571_Desc = {
    Text = "Matériaux d'activation de résonance insuffisants"
  },
  TipsType_10572_Desc = {
    Text = "Point de résonance préalable non amélioré"
  },
  TipsType_10573_Desc = {
    Text = "Niveau max atteint"
  },
  TipsType_10574_Desc = {
    Text = "Amélioration réussie"
  },
  TipsType_10575_Desc = {
    Text = "Cette entité éveillée ne peut pas être remplacée"
  },
  TipsType_10576_Desc = {
    Text = "Position indisponible pour le déploiement"
  },
  TipsType_10577_Desc = {
    Text = "Nombre d'éveillés insuffisant, défi impossible"
  },
  TipsType_10578_Desc = {
    Text = "Prochain niveau non débloqué"
  },
  TipsType_10579_Desc = {
    Text = "Dernier niveau atteint"
  },
  TipsType_10580_Desc = {
    Text = "Limite d'XP atteinte, impossible d'ajouter"
  },
  TipsType_10581_Desc = {
    Text = "Emplacement de la roulette du destin plein, impossible d'ajouter"
  },
  TipsType_10582_Desc = {
    Text = "Aucun matériau rapide à insérer"
  },
  TipsType_10583_Desc = {
    Text = "Placez les ressources dans la fente du destin"
  },
  TipsType_10584_Desc = {
    Text = "Pas de roues de destin à équiper"
  },
  TipsType_10585_Desc = {
    Text = "Débloqué après avoir terminé Enquête 2-8"
  },
  TipsType_10586_Desc = {
    Text = "Débloqué après avoir terminé Enquête 2-14"
  },
  TipsType_10587_Desc = {
    Text = "Débloqué après avoir terminé Enquête 3-16"
  },
  TipsType_10588_Desc = {
    Text = "Débloqué après avoir terminé Enquête 4-12"
  },
  TipsType_10589_Desc = {
    Text = "Débloqué après avoir terminé Enquête 5-12"
  },
  TipsType_10590_Desc = {
    Text = "Débloqué après avoir terminé Enquête 6-12"
  },
  TipsType_10591_Desc = {
    Text = "Débloqué après avoir terminé Enquête 2-12"
  },
  TipsType_10592_Desc = {
    Text = "Cet utilisateur est interdit de connexion, veuillez contacter le service client pour toute question"
  },
  TipsType_10593_Desc = {
    Text = "Session expirée, veuillez vous reconnecter"
  },
  TipsType_10594_Desc = {
    Text = "« Ménophine » insuffisante"
  },
  TipsType_10595_Desc = {
    Text = "Voulez-vous activer \"{s1}\" ?"
  },
  TipsType_10595_Title = {
    Text = "Activer talent"
  },
  TipsType_10596_Desc = {
    Text = "Pas encore obtenu cet éveillé"
  },
  TipsType_10597_Desc = {
    Text = "Pas de roues de destin à renforcer"
  },
  TipsType_10598_Desc = {
    Text = "Ce compte est interdit de connexion jusqu'à {s1} pour violation des règles, veuillez contacter le service client pour toute question"
  },
  TipsType_10599_Desc = {
    Text = "Terminer Enquête 2-15 Débloqué"
  },
  TipsType_10600_Desc = {
    Text = "Limite de niveau atteinte, impossible d'ajouter"
  },
  TipsType_10601_Desc = {
    Text = "Débloqué le journal de croissance du Gardien après avoir terminé l'enquête 1-7"
  },
  TipsType_10602_Desc = {
    Text = "Débloqué les missions de maîtrise de domaine après avoir terminé l'enquête 1-7"
  },
  TipsType_10603_Desc = {
    Text = "Matériaux non sélectionnés"
  },
  TipsType_10604_Desc = {
    Text = "Inactivité prolongée, sortie automatique du donjon"
  },
  TipsType_10605_Desc = {
    Text = "Questionnaire terminé, merci pour votre soutien !"
  },
  TipsType_10606_Desc = {
    Text = "Matériaux d'activation insuffisants"
  },
  TipsType_10607_Desc = {
    Text = "Nombre de récompenses hebdomadaires épuisé, aucun gain après le défi. Voulez-vous continuer ?"
  },
  TipsType_10607_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10607_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10607_Title = {
    Text = "Conseil de défi"
  },
  TipsType_10608_Desc = {
    Text = "Maintenance du campus en cours, veuillez patienter"
  },
  TipsType_10609_Desc = {
    Text = ": Invitation réussie de {s1} dans votre dortoir"
  },
  TipsType_10610_Desc = {
    Text = "{s1} est déjà dans votre dortoir"
  },
  TipsType_10611_Desc = {
    Text = "Réseau non Wi-Fi actuel. Voulez-vous utiliser les données mobiles pour continuer le téléchargement ?"
  },
  TipsType_10611_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10611_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10611_Title = {
    Text = "Confirmation de téléchargement"
  },
  TipsType_10612_Desc = {
    Text = "Toutes les cartes ont été marquées"
  },
  TipsType_10613_Desc = {
    Text = "Réseau instable, veuillez patienter"
  },
  TipsType_10614_Desc = {
    Text = "Défi non débloqué"
  },
  TipsType_10615_Desc = {
    Text = "En refroidissement, utilisable au prochain tour"
  },
  TipsType_10616_Desc = {
    Text = "En cours de sélection, libération après choix"
  },
  TipsType_10617_Desc = {
    Text = "À l'état Scellé, impossible de déclencher l'Exaltation."
  },
  TipsType_10618_Desc = {
    Text = "Niveau moyen de l'équipe {s1} inférieur au recommandé {s2}, défi possible. Confirmer ?"
  },
  TipsType_10618_LeftBtnDesc = {
    Text = "Aller améliorer"
  },
  TipsType_10618_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10618_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_10619_Desc = {
    Text = "Niveau d'enquête {s1} requis"
  },
  TipsType_10620_Desc = {
    Text = "La connexion réseau est mauvaise, veuillez vérifier votre connexion Steam ou redémarrer Steam et réessayer"
  },
  TipsType_10621_Desc = {
    Text = "Voulez-vous confirmer l'utilisation de <WeaponEffect_Num:{s1}> comme votre nom ?"
  },
  TipsType_10621_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10621_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10621_Title = {
    Text = "Gravure confirmée"
  },
  TipsType_10622_Desc = {
    Text = "Gravure en cours de recharge, {s1}h{s2}m avant la prochaine gravure"
  },
  TipsType_10623_Desc = {
    Text = "Gravure réussie"
  },
  TipsType_10624_Desc = {
    Text = "Le nom ne peut contenir que des caractères chinois, anglais et des chiffres"
  },
  TipsType_10625_Desc = {
    Text = "Cette carte sera bientôt défaussée"
  },
  TipsType_10626_Desc = {
    Text = "Dans Steam, veuillez activer le paramètre suivant : \n[Paramètres Steam - En jeu - Activer le Steam Overlay]\net redémarrez le jeu pour que cela prenne effet."
  },
  TipsType_10626_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10626_Title = {
    Text = "Avertissement"
  },
  TipsType_10628_Desc = {
    Text = "Le nouveau nom ne peut pas être identique à l'actuel"
  },
  TipsType_10629_Desc = {
    Text = "Entrez {s1}~{s2} caractères"
  },
  TipsType_10630_Desc = {
    Text = "Rejouable après avoir atteint trois étoiles avec {s1}"
  },
  TipsType_10631_Desc = {
    Text = "Votre compte a été déconnecté de force pour violation des règles"
  },
  TipsType_10631_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10631_Title = {
    Text = "Conseil amical"
  },
  TipsType_10632_Desc = {
    Text = "Reconstitution possible aujourd'hui après avoir terminé le défi"
  },
  TipsType_10633_Desc = {
    Text = "Cette décomposition consommera les ressources suivantes, <Blue: La décomposition ne pourra pas être récupérée>, souhaitez-vous confirmer la décomposition ?"
  },
  TipsType_10633_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10633_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10633_Title = {
    Text = "Confirmation de démontage"
  },
  TipsType_10634_Desc = {
    Text = "Jours restants de la carte mensuelle dépassent {s1}, impossible de cumuler"
  },
  TipsType_10635_Desc = {
    Text = "« Élixir de Cœur d'argent » insuffisant. Souhaitez-vous vous rendre à l'extraction de liquide primordial ?"
  },
  TipsType_10635_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10635_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10635_Title = {
    Text = "Monnaie primaire insuffisante"
  },
  TipsType_10636_Desc = {
    Text = "Aucun cycle de vie inactif"
  },
  TipsType_10637_Desc = {
    Text = "Aucun pacte inactif disponible"
  },
  TipsType_10638_Desc = {
    Text = "Aucun emplacement de pacte n'est disponible pour l'équipement, veuillez retirer le pacte et réessayer"
  },
  TipsType_10640_Desc = {
    Text = "Confirmer le retrait de tous les pactes de ce réveilleur ?"
  },
  TipsType_10640_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10640_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10640_Title = {
    Text = "Avertissement"
  },
  TipsType_10641_Desc = {
    Text = ": Redémarrage nécessaire après changement de langue, confirmer ?"
  },
  TipsType_10641_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10641_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10641_Title = {
    Text = ": Confirmation de changement de langue"
  },
  TipsType_10642_Desc = {
    Text = "Niveau du joueur insuffisant"
  },
  TipsType_10643_Desc = {
    Text = "En entrant dans une zone corrodée, les points de vie diminuent de {s1}"
  },
  TipsType_10644_Desc = {
    Text = "Clé sélectionnée"
  },
  TipsType_10645_Desc = {
    Text = "Clé non obtenue"
  },
  TipsType_10646_Desc = {
    Text = "«{s1}» est insuffisant"
  },
  TipsType_10647_Desc = {
    Text = "L'enquête sur l'événement n'a pas encore commencé, {s1}"
  },
  TipsType_10648_Desc = {
    Text = "La fissure de rotation a été mise à jour"
  },
  TipsType_10649_Desc = {
    Text = "Le nombre actuel d'envois atteint sa limite"
  },
  TipsType_10650_Desc = {
    Text = "Aucun personnage SSR débloqué"
  },
  TipsType_10651_Desc = {
    Text = "Un certain nombre doit être atteint avant d'être utilisable"
  },
  TipsType_10652_Desc = {
    Text = "Actuellement, aucun avatar ni expression de combat à obtenir"
  },
  TipsType_10701_Desc = {
    Text = "La roue de la vie actuelle est équipée, veuillez la retirer et réessayer"
  },
  TipsType_10702_Desc = {
    Text = "Lorsque le nombre de piles supplémentaires de l'équipement SSR atteint 12, deux équipements SSR peuvent être équipés en même temps"
  },
  TipsType_10703_Desc = {
    Text = "L'éveillé a déjà équipé le même cycle de vie, impossible de l'équiper à nouveau"
  },
  TipsType_10704_Desc = {
    Text = "Le niveau du pacte secret a atteint la limite"
  },
  TipsType_10705_Desc = {
    Text = "Quantité de matériaux atteinte"
  },
  TipsType_10706_Desc = {
    Text = "Vous pouvez verrouiller jusqu'à deux sous-attributs"
  },
  TipsType_10707_Desc = {
    Text = "Matériaux de transcription insuffisants"
  },
  TipsType_10708_Desc = {
    Text = "Déverrouillé après que le réveilleur ait atteint le grade {s1}"
  },
  TipsType_10709_Desc = {
    Text = "«{s1}» est insuffisant"
  },
  TipsType_10710_Desc = {Text = "Épuisé"},
  TipsType_10711_Desc = {
    Text = "Cet article n'est pas débloqué"
  },
  TipsType_10712_Desc = {
    Text = "Matériaux pleins"
  },
  TipsType_10713_Desc = {
    Text = "Empilement de la roulette du destin atteint la limite"
  },
  TipsType_10714_Desc = {
    Text = "Conditions de l'événement non remplies, impossible de choisir"
  },
  TipsType_10715_Desc = {
    Text = "Installez l'application correspondante avant de partager"
  },
  TipsType_10716_Desc = {
    Text = "Impossible de sélectionner plus de Roues du Destin"
  },
  TipsType_10717_Desc = {
    Text = "Impossible de sélectionner plus de Clés"
  },
  TipsType_10718_Desc = {
    Text = "Activation réussie"
  },
  TipsType_10719_Desc = {
    Text = "Sceau aux mille visages insuffisant. Vous pouvez convertir automatiquement les matériaux dans « Paramètres d'échange »"
  },
  TipsType_10720_Desc = {
    Text = "Passé en vitesse 1x"
  },
  TipsType_10721_Desc = {
    Text = "Passé en vitesse 2x"
  },
  TipsType_10722_Desc = {
    Text = "Entrée du campus encombrée, réessayez plus tard"
  },
  TipsType_10723_Desc = {
    Text = "Sauvegarde réussie"
  },
  TipsType_10724_Desc = {
    Text = "Échec de la sauvegarde, autorisation d'album non activée ou mémoire insuffisante"
  },
  TipsType_10725_Desc = {
    Text = "Matériaux insuffisants"
  },
  TipsType_10726_Desc = {
    Text = "Choisissez une carte"
  },
  TipsType_10727_Desc = {
    Text = "Cette entité éveillée a été désactivée"
  },
  TipsType_10728_Desc = {
    Text = "La genèse forme ne peut pas être envoyée, veuillez choisir à nouveau"
  },
  TipsType_10736_Desc = {
    Text = "« Ménophine » suffisante, aucun complément nécessaire."
  },
  TipsType_10737_Desc = {
    Text = "Nouvelle version du jeu détectée, redémarrez pour mettre à jour et garantir une expérience optimale"
  },
  TipsType_10738_Desc = {
    Text = "Aucun tutoriel à lire"
  },
  TipsType_10739_Desc = {
    Text = "{s1} a déjà été défié dans {s2}, ne peut pas être réutilisé"
  },
  TipsType_10740_Desc = {
    Text = "Niveau d'enquête {s1} inférieur au recommandé {s2}, défi possible. Confirmer ?"
  },
  TipsType_10740_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10740_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10740_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_10741_Desc = {
    Text = "Niveau moyen de l'équipe {s1} et niveau d'enquête du Gardien {s2} inférieurs au recommandé, défi très difficile. Confirmer ?"
  },
  TipsType_10741_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10741_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10741_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_10742_Desc = {
    Text = "Les effets de la même roue de destin dans l'équipe ne peuvent pas se cumuler. Actuellement, <Blue:{s1}> a une roue de destin inactive. Il est recommandé de réajuster l'équipement avant de continuer l'enquête.\nVoulez-vous continuer ?"
  },
  TipsType_10742_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10742_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10742_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_10743_Desc = {
    Text = "Aucune tentative d'assistance restante dans la zone de fusion"
  },
  TipsType_10744_Desc = {
    Text = "Limite de suivi atteinte"
  },
  TipsType_10745_Desc = {
    Text = "Date d'anniversaire incorrecte, impossible de définir"
  },
  TipsType_10746_Desc = {
    Text = "Copié dans le presse-papiers"
  },
  TipsType_10747_Desc = {
    Text = "J'aime réussi"
  },
  TipsType_10748_Desc = {
    Text = "{s1} est déjà un soutien réveillé"
  },
  TipsType_10749_Desc = {
    Text = "L'éveillé d'assistance au combat ne peut pas être vide"
  },
  TipsType_10750_Desc = {
    Text = "Tu as déjà aimé ce Gardien du Secret aujourd'hui"
  },
  TipsType_10751_Desc = {
    Text = "Vous pouvez afficher jusqu'à 4 éveillés"
  },
  TipsType_10752_Desc = {
    Text = "Le domaine ne remplit pas les conditions, impossible de participer"
  },
  TipsType_10753_Desc = {
    Text = "{s1} est déjà en équipe, ne peut pas être sélectionné à nouveau"
  },
  TipsType_10754_Desc = {
    Text = "{s1} est réinitialisé"
  },
  TipsType_10755_Desc = {
    Text = "Déverrouillage réussi"
  },
  TipsType_10756_Desc = {
    Text = "Aucun matériau empilable disponible à insérer"
  },
  TipsType_10757_Desc = {
    Text = "{s1} a déjà été défié dans cette activité aujourd'hui, ne peut pas être utilisé à nouveau"
  },
  TipsType_10758_Desc = {
    Text = "Le domaine de l'équipe ne remplit pas les conditions requises"
  },
  TipsType_10761_Desc = {
    Text = "Le corps éveillé de la genèse ne peut pas se battre en même temps que sa forme normale"
  },
  TipsType_10762_Desc = {
    Text = "Le corps éveillé de la genèse ne peut pas être affiché en même temps que sa forme normale"
  },
  TipsType_10799_Desc = {
    Text = "L'effet de l'ensemble de 6 pièces de la concordance actuelle <Blue:{s1}> n'est pas actif en raison de la restriction <Blue:Équipe Unique>, il est recommandé au Gardien de réajuster la concordance avant de continuer l'enquête. \n Voulez-vous toujours enquêter ?"
  },
  TipsType_10799_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10799_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10799_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_10801_Desc = {
    Text = "Le nombre de plans du pacte secret a atteint la limite"
  },
  TipsType_10802_Desc = {
    Text = "{s1} a déjà été utilisé dans d'autres plans de pacte et ne peut pas être enregistré"
  },
  TipsType_10803_Desc = {
    Text = "Le nom du plan du pacte secret ne peut pas être vide"
  },
  TipsType_10804_Desc = {
    Text = "Caractères illégaux inclus, veuillez réessayer"
  },
  TipsType_10805_Desc = {
    Text = "Enregistré"
  },
  TipsType_10806_Desc = {
    Text = "Le pacte actuel est appliqué dans {s1}"
  },
  TipsType_10807_Desc = {Text = "Équipé"},
  TipsType_10808_Desc = {
    Text = "Déséquipé"
  },
  TipsType_10809_Desc = {
    Text = "Équipe actuelle en combat"
  },
  TipsType_10810_Desc = {
    Text = "Le plan du pacte secret ne peut pas être vide"
  },
  TipsType_10811_Desc = {
    Text = "Ce plan est déjà équipé"
  },
  TipsType_10812_Desc = {Text = "Équipé"},
  TipsType_10813_Desc = {
    Text = "Es-tu sûr que tu veux supprimer le plan [{s1}] ?"
  },
  TipsType_10813_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10813_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10814_Desc = {
    Text = "La formation d'éveillés pour cette enquête ne répond pas aux critères requis"
  },
  TipsType_10815_Desc = {
    Text = "L'entité éveillée actuelle est spécialement conçue pour l'histoire, détails indisponibles"
  },
  TipsType_10816_Desc = {
    Text = "« Certificat d'agent » insuffisant"
  },
  TipsType_10817_Desc = {
    Text = "Aucun enregistrement de règlement, \"Défiez\" et attendez le règlement à 9h00 le lendemain"
  },
  TipsType_10818_Desc = {
    Text = "Délégation d'aujourd'hui terminée, pas de répétition possible"
  },
  TipsType_10821_Desc = {
    Text = "Actuellement, aucun matériel disponible, veuillez revenir plus tard"
  },
  TipsType_10822_Desc = {
    Text = "Événement terminé"
  },
  TipsType_10823_Desc = {
    Text = "Réapprovisionnement des graines spéciales après épuisement"
  },
  TipsType_10824_Desc = {
    Text = "Nombre de réapprovisionnements épuisé, plus de réserves disponibles"
  },
  TipsType_10825_Desc = {
    Text = "«{s1}» est insuffisant"
  },
  TipsType_10826_Desc = {
    Text = "Graines spéciales épuisées, choisissez de semer pour réinitialiser"
  },
  TipsType_10827_Desc = {
    Text = "Graines spéciales réinitialisées"
  },
  TipsType_10828_Desc = {
    Text = "Tous les objets ont été échangés, veuillez choisir de réinitialiser"
  },
  TipsType_10829_Desc = {
    Text = "Réinitialisation réussie"
  },
  TipsType_10830_Desc = {
    Text = "Un membre éveillé ne peut pas participer, enquête impossible"
  },
  TipsType_10831_Desc = {
    Text = "Mandala identique dans l'équipe, impossible d'entrer dans la zone interdite"
  },
  TipsType_10832_Desc = {
    Text = "L'équipe n'a pas équipé de clé, impossible d'enquêter"
  },
  TipsType_10833_Desc = {
    Text = "Un Mandala ne peut pas être équipé, enquête impossible"
  },
  TipsType_10834_Desc = {
    Text = "Ne peut pas équiper de Roue de Destin pour les personnages de soutien"
  },
  TipsType_10835_Desc = {
    Text = "Ne peut pas équiper de Pacte pour les personnages de soutien"
  },
  TipsType_10836_Desc = {
    Text = "Ne peut pas équiper de Roue de Destin pour les personnages de l'histoire"
  },
  TipsType_10837_Desc = {
    Text = "Ne peut pas équiper de Pacte pour les personnages de l'histoire"
  },
  TipsType_10838_Desc = {
    Text = "Nombre maximum d'expressions atteint dans le plan"
  },
  TipsType_10839_Desc = {
    Text = "Expression utilisée, cliquez sur l'expression dans le plan pour la retirer"
  },
  TipsType_10840_Desc = {
    Text = "Envoi d'expressions trop rapide"
  },
  TipsType_10841_Desc = {
    Text = "Le plan d'expressions ne peut pas être vide"
  },
  TipsType_10842_Desc = {
    Text = "Plan d'expressions mis à jour"
  },
  TipsType_10843_Desc = {
    Text = "Cette entrée n'est pas encore débloquée"
  },
  TipsType_10844_Desc = {
    Text = "Pas encore débloqué"
  },
  TipsType_10850_Desc = {
    Text = "Une clé ne peut pas être équipée, enquête impossible"
  },
  TipsType_10901_Desc = {Text = "Paralysie"},
  TipsType_10902_Desc = {
    Text = "Inconscient"
  },
  TipsType_10903_Desc = {
    Text = "Pas encore : {s1}"
  },
  TipsType_10904_Desc = {
    Text = "Après avoir terminé le mode \"normal\" de ce chapitre, débloquer le mode \"souvenir\" pour apprécier l'histoire"
  },
  TipsType_10905_Desc = {
    Text = "Terminez l'opération d'enquête 1-15 · Ordinaire pour déverrouiller l'histoire de \"Souvenir\""
  },
  TipsType_10906_Desc = {
    Text = "\"Point de départ de la réalité\" est insuffisant"
  },
  TipsType_10907_Desc = {Text = "Débloqué"},
  TipsType_10908_Desc = {
    Text = "Le Dégagement de {s1} est au maximum. Les gains supplémentaires seront convertis en <TipsHighlightText:«Fragment de rembobinage d'âme ×2>. Confirmez-vous le Réveil ?"
  },
  TipsType_10908_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10908_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10908_Title = {
    Text = "Confirmation de l'éveil"
  },
  TipsType_10909_Desc = {
    Text = "{s1} a été réveillé. Les gains supplémentaires seront convertis en <TipsHighlightText:Fragment : {s2}*1> et <TipsHighlightText:Sédiment racinaire*50>. Confirmez-vous de réveiller ?"
  },
  TipsType_10909_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10909_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10909_Title = {
    Text = "Confirmation de l'éveil"
  },
  TipsType_10910_Desc = {
    Text = "Voulez-vous confirmer l'éveil de <TipsHighlightText:{s1}> ?"
  },
  TipsType_10910_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10910_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10910_Title = {
    Text = "Confirmation de l'éveil"
  },
  TipsType_10911_Desc = {
    Text = "Espace insuffisant"
  },
  TipsType_10912_Desc = {
    Text = "L'espace ultra n'a pas de carte de commandement, il ne peut pas être utilisé"
  },
  TipsType_10913_Desc = {
    Text = "Impossible de réutiliser ce tour"
  },
  TipsType_10914_Desc = {
    Text = "Voulez-vous confirmer la sélection de <TipsHighlightText:{s1}> ?"
  },
  TipsType_10914_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10914_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10914_Title = {
    Text = "Choisir confirmation"
  },
  TipsType_10915_Desc = {
    Text = "Le déverrouillage des escouades doit s'effectuer dans l'ordre, il est impossible de contourner une escouade non déverrouillée"
  },
  TipsType_10916_Desc = {
    Text = "Souhaitez-vous dépenser <Blue: {s1} × {s2}> pour déverrouiller ?"
  },
  TipsType_10916_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10916_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10916_Title = {
    Text = "Confirmation de déverrouillage"
  },
  TipsType_10917_Desc = {
    Text = "Déverrouillage réussi {s1}"
  },
  TipsType_10918_Desc = {
    Text = "Déverrouillage réussi {s1}, toute l'équipe a été complètement débloquée"
  },
  TipsType_10919_Desc = {
    Text = "Débloqué après avoir terminé [{s1} : {s2}], souhaitez-vous vous y rendre ?"
  },
  TipsType_10919_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10919_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10919_Title = {
    Text = "Non débloqué"
  },
  TipsType_10920_Desc = {
    Text = "Cumulez «Gland magique» × {s1} dans l'événement limité «Inversion de phase» pour déverrouiller. Souhaitez-vous vous rendre dans «Inversion de phase» ?"
  },
  TipsType_10920_LeftBtnDesc = {Text = "Annuler"},
  TipsType_10920_RightBtnDesc = {Text = "Confirmer"},
  TipsType_10920_Title = {
    Text = "Non débloqué"
  },
  TipsType_10921_Desc = {
    Text = "Impossible d'équiper deux Roues du Destin ayant la même statistique principale"
  },
  TipsType_20001_Desc = {
    Text = "Activer la double confirmation"
  },
  TipsType_20001_LeftBtnDesc = {Text = "Confirmer"},
  TipsType_20001_Title = {Text = "Titre"},
  TipsType_20002_Desc = {
    Text = "Pas de confirmation secondaire requise"
  },
  TipsType_20002_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20002_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20002_Title = {Text = "Titre"},
  TipsType_20003_Desc = {
    Text = "Votre compte est connecté sur un autre appareil"
  },
  TipsType_20003_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20003_Title = {
    Text = "Notification de déconnexion"
  },
  TipsType_20004_Desc = {
    Text = "La connexion avec le serveur est perdue, veuillez vous reconnecter"
  },
  TipsType_20004_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20004_Title = {
    Text = "Notification de déconnexion"
  },
  TipsType_20005_Desc = {
    Text = "Échec de synchronisation, réessayer ?"
  },
  TipsType_20005_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20005_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20005_Title = {
    Text = "Échec de synchronisation"
  },
  TipsType_20006_Desc = {
    Text = "Perte de synchronisation, retour à l'écran de connexion sous peu"
  },
  TipsType_20006_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20006_Title = {
    Text = "Échec de synchronisation"
  },
  TipsType_20007_Desc = {
    Text = "Perte de synchronisation, retour à l'écran de connexion sous peu"
  },
  TipsType_20007_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20007_Title = {
    Text = "Échec de synchronisation"
  },
  TipsType_20008_Desc = {
    Text = "Cette enquête consomme <Positive:{s1}> d'énergie. Confirmer la fin ?"
  },
  TipsType_20008_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20008_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20008_Title = {
    Text = "Terminer l'exploration"
  },
  TipsType_20009_Desc = {
    Text = "Le rafraîchissement mettra à jour l'oraison et les reliques, le réveil du réveilleur et le nombre de cartes de commandement à vendre ne seront pas réinitialisés, voulez-vous confirmer ?"
  },
  TipsType_20009_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20009_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20009_Title = {
    Text = "Confirmer le rafraîchissement"
  },
  TipsType_20010_Desc = {
    Text = "Le nombre d'entités éveillées dans ce domaine est insuffisant, continuer à créer une équipe ?"
  },
  TipsType_20010_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20010_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20011_Desc = {
    Text = "Aucun réveilleur sélectionné, la composition d'équipe ne sera pas conservée"
  },
  TipsType_20011_LeftBtnDesc = {
    Text = "Confirmer le départ"
  },
  TipsType_20011_RightBtnDesc = {
    Text = "Continuer la composition d'équipe"
  },
  TipsType_20012_Desc = {
    Text = "Forme éveillée non sélectionnée"
  },
  TipsType_20012_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20013_Desc = {
    Text = "L'équipe a encore des places vacantes, confirmer le départ ?"
  },
  TipsType_20013_LeftBtnDesc = {Text = "Retour"},
  TipsType_20013_RightBtnDesc = {Text = "Partir"},
  TipsType_20014_Desc = {
    Text = "Nombre maximum d'équipes atteint"
  },
  TipsType_20014_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20015_Desc = {
    Text = "Voulez-vous supprimer cette équipe ?"
  },
  TipsType_20015_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20015_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20016_Desc = {
    Text = "Débloqué après avoir terminé {s1}"
  },
  TipsType_20016_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20017_Desc = {
    Text = "Ici, vous pouvez consulter les informations de la carte et des monstres déjà combattus, cette version n'est pas encore développée"
  },
  TipsType_20017_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20018_Desc = {
    Text = "Conditions de déverrouillage non remplies"
  },
  TipsType_20018_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20018_Title = {
    Text = "Exploration rapide"
  },
  TipsType_20019_Desc = {
    Text = "«Cœur d'argent» insuffisant. Souhaitez-vous aller à la boutique pour en acheter ?"
  },
  TipsType_20019_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20019_RightBtnDesc = {Text = "Aller"},
  TipsType_20020_Desc = {
    Text = "Débloquer cette difficulté avancée après avoir terminé {s1}"
  },
  TipsType_20020_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20021_Desc = {
    Text = "Débloqué après avoir terminé le mode normal de {s1}"
  },
  TipsType_20021_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20022_Desc = {
    Text = "«Cœur d'argent» insuffisant. Souhaitez-vous acheter ?"
  },
  TipsType_20022_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20022_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20022_Title = {
    Text = "Noyau d'argent insuffisant"
  },
  TipsType_20023_Desc = {
    Text = "Cette mise à niveau excède de {s1} points d'expérience (non remboursables). Le personnage ne gagnera plus d'expérience après avoir atteint le niveau maximum. Continuer ?"
  },
  TipsType_20023_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20023_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20024_Desc = {
    Text = "L'équipe n'est pas complète, impossible d'entrer dans le donjon"
  },
  TipsType_20024_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20026_Desc = {
    Text = "Voulez-vous confirmer la charge ?"
  },
  TipsType_20026_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20026_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20027_Desc = {
    Text = "Voulez-vous confirmer la restauration de la vie ?"
  },
  TipsType_20027_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20027_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20028_Desc = {
    Text = "Fermer cette interface vous fera renoncer à ramasser [{s1}]. Continuer?"
  },
  TipsType_20028_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20028_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20029_Desc = {
    Text = "Fermer cette interface passera cet événement (la création ne sera pas supprimée), confirmer ?"
  },
  TipsType_20029_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20029_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20030_Desc = {
    Text = "Création décochée ne sera pas portée, abandonner l'héritage ?"
  },
  TipsType_20030_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20030_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20031_Desc = {
    Text = "Souhaites-tu confirmer de quitter le combat ?"
  },
  TipsType_20031_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20031_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20032_Desc = {
    Text = "Niveau actuel verrouillé, débloquer en terminant les niveaux d'enquête ?"
  },
  TipsType_20032_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20032_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20032_Title = {
    Text = "Non débloqué"
  },
  TipsType_20033_Desc = {
    Text = "Tentatives de défi insuffisantes. Dépenser 500 Cœurs d'argent pour réinitialiser ?"
  },
  TipsType_20033_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20033_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20034_Desc = {
    Text = "Le défi actuel est en recharge. Voulez-vous dépenser «Cœur d'argent» × 50 pour le réinitialiser ?"
  },
  TipsType_20034_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20034_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20035_Desc = {
    Text = "Niveau recommandé {s1}, niveau moyen de l'équipe {s2}, enquête difficile, continuer ?"
  },
  TipsType_20035_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20035_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20035_Title = {
    Text = "Puissance de combat insuffisante"
  },
  TipsType_20036_Desc = {
    Text = "Balayage défini à {s1}, mais chaque défi consomme {s2} énergie pour une récompense. Confirmer ?"
  },
  TipsType_20036_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20036_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20036_Title = {
    Text = "Confirmation de défi"
  },
  TipsType_20037_Desc = {
    Text = "Le matériel de renforcement contient des matériaux avancés. Êtes-vous sûr de vouloir renforcer ?"
  },
  TipsType_20037_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20037_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20037_Title = {
    Text = "Confirmation de renforcement"
  },
  TipsType_20038_Desc = {
    Text = "Cet équipement est verrouillé, voulez-vous le déverrouiller ?"
  },
  TipsType_20038_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20038_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20039_Desc = {
    Text = "Confirmer mettra fin à cette enquête, vous ne recevrez pas les récompenses ultérieures. Voulez-vous vraiment terminer l'enquête ?"
  },
  TipsType_20039_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20039_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20039_Title = {
    Text = "Quitter l'enquête"
  },
  TipsType_20040_Desc = {
    Text = "<WeaponEffect_Num:La sortie active de l'enquête consommera {s1} Ménophine.> L'enquête échouera, sans recevoir de récompense d'enquête ultérieure. Souhaitez-vous vraiment terminer l'enquête ?"
  },
  TipsType_20040_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20040_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20040_Title = {
    Text = "Quitter l'enquête"
  },
  TipsType_20041_BottomDesc = {
    Text = "Possession actuelle du permis de compression temporelle : {s1}"
  },
  TipsType_20041_Desc = {
    Text = "Souhaites-tu consommer {s1} permis de compression temporelle pour accélérer ?"
  },
  TipsType_20041_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20041_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20041_Title = {
    Text = "Confirmation d'accélération"
  },
  TipsType_20042_Desc = {
    Text = "Ajustements de la bataille RPG en cours, victoire calculée directement"
  },
  TipsType_20042_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20042_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20043_Desc = {
    Text = "Voulez-vous dépenser {s1} noyaux d'argent pour rafraîchir la mission actuelle ?"
  },
  TipsType_20043_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20043_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20043_Title = {
    Text = "Rafraîchir mission"
  },
  TipsType_20044_BottomDesc = {
    Text = "Épuiser : {s1} autorisation de recherche"
  },
  TipsType_20044_Desc = {
    Text = [[
Voulez-vous effectuer la recherche de {s1} ?
Effet de recherche : {s2}]]
  },
  TipsType_20044_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20044_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20044_Title = {
    Text = "Recherche confirmée"
  },
  TipsType_20045_BottomDesc = {
    Text = "Annuler la recherche sans conserver les progrès réalisés"
  },
  TipsType_20045_Desc = {
    Text = "Voulez-vous annuler la recherche de {s1} ? (Le permis de recherche sera entièrement remboursé)"
  },
  TipsType_20045_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20045_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20045_Title = {
    Text = "Recherche annulée"
  },
  TipsType_20046_Desc = {
    Text = "Voulez-vous dépenser {s1} «Cœur d'argent» pour accélérer ?"
  },
  TipsType_20046_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20046_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20046_Title = {
    Text = "Confirmation d'accélération"
  },
  TipsType_20047_Desc = {
    Text = "Il manque {s1} <Blue:«{s2}»>, voulez-vous dépenser <Blue:«Cœur d'argent»×{s3}> pour acheter ?"
  },
  TipsType_20047_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20047_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20047_Title = {
    Text = "Confirmation d'achat"
  },
  TipsType_20048_Desc = {
    Text = "Il manque {s1} <Blue:«{s2}»>, voulez-vous dépenser <Blue:«Cœur d'argent»×{s3}> pour acheter ?"
  },
  TipsType_20048_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20048_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20048_Title = {
    Text = "Confirmation d'achat"
  },
  TipsType_20049_Desc = {
    Text = "<Blue:«{s1}»> est équipé par <Blue:«{s2}»>, confirmer le changement ?"
  },
  TipsType_20049_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20049_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20049_Title = {
    Text = "Notification de changement"
  },
  TipsType_20050_Desc = {
    Text = "Consomme la roue de la vie déjà empilée, confirmer ?"
  },
  TipsType_20050_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20050_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20050_Title = {
    Text = "Conseil d'empilement"
  },
  TipsType_20051_Desc = {
    Text = "Le niveau d'empilement actuel dépasse la limite, les niveaux excédentaires seront remboursés, confirmer ?"
  },
  TipsType_20051_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20051_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20051_Title = {
    Text = "Conseil d'empilement"
  },
  TipsType_20052_Desc = {
    Text = "Niveau recommandé {s1}, niveau moyen de l'équipe {s2}, enquête difficile, continuer ?"
  },
  TipsType_20052_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20052_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20052_Title = {
    Text = "Puissance de combat insuffisante"
  },
  TipsType_20053_Desc = {
    Text = "Niveau recommandé {s1}, niveau moyen de l'équipe {s2}, enquête très difficile, continuer ?"
  },
  TipsType_20053_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20053_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20053_Title = {
    Text = "Puissance de combat insuffisante"
  },
  TipsType_20054_Desc = {
    Text = "Récompenses de défi toutes réclamées, continuer ne donnera rien. Confirmer ?"
  },
  TipsType_20054_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20054_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20054_Title = {
    Text = "Confirmation de défi"
  },
  TipsType_20055_Desc = {
    Text = "Après la réinitialisation, la progression du niveau actuel sera remise à 0 étoiles, et les relevés de bataille du réveilleur seront complètement effacés. Êtes-vous sûr de vouloir réinitialiser ?"
  },
  TipsType_20055_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20055_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20055_Title = {
    Text = "Confirmation de réinitialisation"
  },
  TipsType_20056_Desc = {
    Text = "Après avoir réussi le défi, les quatre réveilleurs de l'équipe actuelle ne pourront pas participer aux autres niveaux de {s1}, confirmez-vous le défi ?"
  },
  TipsType_20056_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20056_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20056_Title = {
    Text = "Confirmation de défi"
  },
  TipsType_20057_Desc = {
    Text = "La composition de l'équipe ne respecte pas les recommandations du manuel de l'académie, continuer le défi ?"
  },
  TipsType_20057_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20057_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20057_Title = {
    Text = "Confirmation de la composition d'équipe"
  },
  TipsType_20058_Desc = {
    Text = "Le niveau actuel a été réussi, si vous souhaitez le défier à nouveau, vous devez d'abord réinitialiser la progression à 0 étoiles, et les enregistrements de guerre du réveilleur seront également effacés. Confirmez-vous la réinitialisation ?"
  },
  TipsType_20058_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20058_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20058_Title = {
    Text = "Confirmation de réinitialisation"
  },
  TipsType_20059_Desc = {
    Text = "Le nombre de réveilleurs dans l'équipe n'atteint pas quatre, impossible d'entrer en bataille"
  },
  TipsType_20059_Title = {
    Text = "Sauvegarde de la composition d'équipe"
  },
  TipsType_20060_BottomDesc = {
    Text = "Une fois confirmé, il ne sera plus possible de réveiller à nouveau"
  },
  TipsType_20060_Desc = {
    Text = "Voulez-vous sélectionner le résultat de cette invocation (vous obtiendrez tous les éveillés et les roues de destin de cette invocation) ?"
  },
  TipsType_20060_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20060_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20060_Title = {
    Text = "Confirmer le choix"
  },
  TipsType_20061_BottomDesc = {
    Text = "Silvercores actuels : {s1}"
  },
  TipsType_20061_Desc = {
    Text = "Voulez-vous dépenser {s1} «Argent» pour Réveiller à nouveau ?\nRéveiller à nouveau ne conservera pas les résultats de cette invocation"
  },
  TipsType_20061_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20061_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20061_Title = {Text = "Réveil"},
  TipsType_20062_Desc = {
    Text = "Êtes-vous sûr de vouloir supprimer tous les messages lus ?\nLes messages avec pièces jointes non récupérées ne seront pas supprimés"
  },
  TipsType_20062_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20062_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20062_Title = {
    Text = "Supprimer les lus"
  },
  TipsType_20063_Desc = {
    Text = "Confirmer la suppression ?"
  },
  TipsType_20063_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20063_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20063_Title = {
    Text = "Supprimer le courrier actuel"
  },
  TipsType_20064_Desc = {
    Text = "Les lettres supprimées de la boîte de trésors ne peuvent pas être récupérées,\nVoulez-vous supprimer cette lettre ?"
  },
  TipsType_20064_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20064_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20064_Title = {
    Text = "Supprimer les courriers favoris"
  },
  TipsType_20065_Desc = {
    Text = "Confirmer la consommation de <Blue:{s1}> pour synthétiser <Blue:{s2}> ?"
  },
  TipsType_20065_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20065_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20065_Title = {
    Text = "Confirmation de synthèse"
  },
  TipsType_20066_Desc = {
    Text = "Confirmer la décomposition de <Blue:{s1}, obtenir {s2}> ?"
  },
  TipsType_20066_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20066_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20066_Title = {
    Text = "Confirmation de démontage"
  },
  TipsType_20067_Desc = {
    Text = "Confirmer la consommation de <Blue:{s1}> pactes de niveau SSR, réimprimer <Blue:{s2}> <Blue:{s3}> ?"
  },
  TipsType_20067_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20067_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20067_Title = {
    Text = "Confirmation de réimpression"
  },
  TipsType_20068_Desc = {
    Text = "Tous les réveilleurs ont complètement perdu leur capacité à se battre\n\nÔ gardien, que vas-tu choisir ensuite ?"
  },
  TipsType_20068_LeftBtnDesc = {
    Text = "Reprendre le combat"
  },
  TipsType_20068_RightBtnDesc = {
    Text = "Retraite temporaire"
  },
  TipsType_20068_Title = {
    Text = "Échec de l'enquête"
  },
  TipsType_20069_Desc = {
    Text = "Éveillé sélectionné en folie, confirmer le choix ?"
  },
  TipsType_20069_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20069_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20069_Title = {
    Text = "Confirmer le choix"
  },
  TipsType_20070_Desc = {
    Text = "Souhaites-tu confirmer l'utilisation de {s1} ? \n Les réveilleurs dont le niveau et les compétences ont été améliorés ne retourneront pas les ressources d'amélioration"
  },
  TipsType_20070_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20070_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20070_Title = {
    Text = "Confirmation d'amplification"
  },
  TipsType_20071_Desc = {
    Text = "Sous la restriction du niveau d'investigation du gardien, le niveau du réveilleur sera élevé à {s1} niveaux, les ressources d'amélioration manquantes ne seront pas remboursées, voulez-vous confirmer l'élévation ?"
  },
  TipsType_20071_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20071_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20071_Title = {
    Text = "Confirmation d'amplification"
  },
  TipsType_20072_Desc = {
    Text = "Confirmer le saut de toute l'histoire de cette section ?\nNote : Vous pourrez revoir l'histoire en réentrant dans ce niveau"
  },
  TipsType_20072_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20072_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20072_Title = {
    Text = ": Passer la scène"
  },
  TipsType_20073_Desc = {
    Text = "Confirmer la décomposition de {s1}, acquérir {s2} ?\n(L'accord actuel a été renforcé, la décomposition ne rend pas les ressources renforcées.)"
  },
  TipsType_20073_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20073_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20073_Title = {
    Text = "Confirmation de démontage"
  },
  TipsType_20074_Desc = {
    Text = "Confirmer la décomposition de {s1}, obtenir {s2} ?\n(Rareté actuelle de la roue de la vie élevée)"
  },
  TipsType_20074_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20074_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20074_Title = {
    Text = "Confirmation de démontage"
  },
  TipsType_20075_BottomDesc = {
    Text = "Épuiser : {s1} autorisation de recherche"
  },
  TipsType_20075_Desc = {
    Text = "Souhaites-tu lancer la recherche de {s1} ? \n Efficacité de production : {s2} rose dorée / toutes les 6 heures \n      ——>{s3} rose dorée / toutes les 6 heures"
  },
  TipsType_20075_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20075_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20075_Title = {
    Text = "Recherche confirmée"
  },
  TipsType_20076_BottomDesc = {
    Text = "Épuiser : {s1} autorisation de recherche"
  },
  TipsType_20076_Desc = {
    Text = "Souhaites-tu lancer la recherche de {s1} ? \n Efficacité de production : {s2} élixirs de gnose / toutes les 6 heures \n      ——>{s3} élixirs de gnose / toutes les 6 heures"
  },
  TipsType_20076_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20076_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20076_Title = {
    Text = "Recherche confirmée"
  },
  TipsType_20077_BottomDesc = {
    Text = "Épuiser : {s1} autorisation de recherche"
  },
  TipsType_20077_Desc = {
    Text = "Souhaites-tu lancer la recherche de {s1} ? \n Efficacité de production : {s2} traces de pacte / toutes les 6 heures \n      ——>{s3} traces de pacte / toutes les 6 heures"
  },
  TipsType_20077_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20077_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20077_Title = {
    Text = "Recherche confirmée"
  },
  TipsType_20078_Desc = {
    Text = "Confirmer le saut de toute cette partie de l'histoire ?\nNote : Vous pourrez revoir l'histoire en réentrant dans ce niveau"
  },
  TipsType_20078_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20078_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20078_Title = {
    Text = ": Passer la scène"
  },
  TipsType_20079_Desc = {
    Text = "La clé d'argent détecte un danger mortel, activer l'entité spirituelle d'urgence ?\n(La résurrection consommera une entité spirituelle d'urgence, une entité spirituelle d'urgence est obtenue automatiquement chaque jour à 9h, nombre restant actuel : {s1}/{s2})"
  },
  TipsType_20079_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20079_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20079_Title = {
    Text = "Confirmation de résurrection"
  },
  TipsType_20080_Desc = {
    Text = "La clé d'argent détecte un danger mortel, activer l'entité spirituelle d'urgence ?\n(La résurrection consommera une entité spirituelle d'urgence, une entité spirituelle d'urgence est obtenue automatiquement chaque jour à 9h, nombre restant actuel : {s1}/{s2})"
  },
  TipsType_20080_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20080_Title = {
    Text = "Confirmation de résurrection"
  },
  TipsType_20081_Desc = {
    Text = "Échec de l'initialisation du jeu. {s1}"
  },
  TipsType_20081_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20081_Title = {
    Text = "Message d'erreur de connexion"
  },
  TipsType_20082_Desc = {
    Text = "Voulez-vous consommer <Blue:«Argent» × {s1} > pour acheter <Blue: {s2} > niveaux ?"
  },
  TipsType_20082_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20082_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20082_Title = {
    Text = "Augmenter le niveau"
  },
  TipsType_20083_Desc = {
    Text = "Confirmez-vous la consommation de la roue du destin{s1} pour le renforcement ?"
  },
  TipsType_20083_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20083_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20083_Title = {
    Text = "Consommation confirmée"
  },
  TipsType_20084_Desc = {
    Text = "Le niveau moyen de l'équipe est inférieur au niveau recommandé pour cette étape, les attributs des éveillés seront réduits, continuer l'enquête ?"
  },
  TipsType_20084_LeftBtnDesc = {
    Text = "Aller améliorer"
  },
  TipsType_20084_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20084_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20085_Desc = {
    Text = "Confirmer la sortie du jeu"
  },
  TipsType_20085_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20085_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20085_Title = {
    Text = "Quitter le jeu"
  },
  TipsType_20086_Desc = {
    Text = "Maintenance du serveur"
  },
  TipsType_20086_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20086_Title = {
    Text = "Notification de déconnexion"
  },
  TipsType_20087_Desc = {
    Text = "Voulez-vous confirmer la consommation de <TipsHighlightText:{s1} × {s2}> pour débloquer <TipsHighlightText:{s3}> ?"
  },
  TipsType_20087_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20087_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20087_Title = {
    Text = "Confirmation d'activation"
  },
  TipsType_20088_Desc = {
    Text = "Après réception, la «Ménophine» débordera, et la partie dépassant {s1} ne pourra pas être obtenue.\nSouhaitez-vous continuer à la recevoir ?"
  },
  TipsType_20088_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20088_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20088_Title = {
    Text = "Dépassement de menophin"
  },
  TipsType_20089_Desc = {
    Text = "Consomme <Blue:{s1}> roses dorées pour rafraîchir le stock\nNombre de rafraîchissements restants : <Blue:{s2}>\nPlus il y a de rafraîchissements, plus le nombre de roses dorées nécessaires augmente."
  },
  TipsType_20089_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20089_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20089_Title = {
    Text = "Rafraîchir le stock"
  },
  TipsType_20090_Desc = {
    Text = "Nombre maximum de Roues du Destin atteint, vous devez nettoyer des Roues du Destin avant de pouvoir éveiller. Voulez-vous y aller ?\n\n<color=#ADC0CB>*Vous pouvez configurer la décomposition automatique des Roues du Destin de rang SR/R dans « Paramètres »</color>"
  },
  TipsType_20090_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20090_RightBtnDesc = {
    Text = "Aller nettoyer"
  },
  TipsType_20090_Title = {
    Text = ": Indice de nettoyage"
  },
  TipsType_20091_Desc = {
    Text = "Le nombre de pactes secrets a atteint la limite, il faut en nettoyer avant de continuer l'enquête. Voulez-vous y aller ?"
  },
  TipsType_20091_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20091_RightBtnDesc = {
    Text = "Aller nettoyer"
  },
  TipsType_20091_Title = {
    Text = ": Indice de nettoyage"
  },
  TipsType_20092_Desc = {
    Text = "Voulez-vous confirmer le retrait de tout l'équipement de l'éveillé actuel ?"
  },
  TipsType_20092_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20092_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20092_Title = {
    Text = "Confirmation de désinstallation"
  },
  TipsType_20093_Desc = {
    Text = "Confirmez-vous la consommation d'un pacte pour une mise à niveau ?"
  },
  TipsType_20093_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20093_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20093_Title = {
    Text = "Confirmation de mise à niveau"
  },
  TipsType_20094_Desc = {
    Text = "Il y a de bons attributs dans l'attribut secondaire original, ils ne seront pas conservés après remplacement. Confirmer le remplacement ?"
  },
  TipsType_20094_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20094_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20094_Title = {
    Text = "Confirmer le remplacement"
  },
  TipsType_20095_Desc = {
    Text = "Bonnes sous-attributs détectés, continuer ne les sauvegardera pas. Confirmer ?"
  },
  TipsType_20095_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20095_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20095_Title = {
    Text = "Confirmation de la transcription"
  },
  TipsType_20096_Desc = {
    Text = "L'amélioration de cette Concordance dépassera la limite de niveau. Tout excédent remboursera les matériaux de transcription. Confirmer ?"
  },
  TipsType_20096_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20096_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20096_Title = {
    Text = "Confirmation de mise à niveau"
  },
  TipsType_20097_Desc = {
    Text = "Le Dégagement de ce Corps éveillé est déjà complet.\nAprès la sélection, vous obtiendrez uniquement «Fragment de rembobinage d'âme» ×1"
  },
  TipsType_20097_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20097_RightBtnDesc = {
    Text = ": Continuer"
  },
  TipsType_20097_Title = {
    Text = "Confirmer le choix"
  },
  TipsType_20098_Desc = {
    Text = "Cet article peut être acheté avec <Blue:{s1}> certificats de transaction en argent secret"
  },
  TipsType_20098_LeftBtnDesc = {
    Text = "Paiement en espèces"
  },
  TipsType_20098_RightBtnDesc = {
    Text = "Paiement par preuve"
  },
  TipsType_20098_Title = {
    Text = "Choix du mode de règlement"
  },
  TipsType_20099_Desc = {
    Text = "Voulez-vous quitter le jeu ?"
  },
  TipsType_20099_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20099_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20099_Title = {
    Text = "Avertissement"
  },
  TipsType_20100_Desc = {
    Text = "Nouvelle version du jeu détectée, redémarrez pour mettre à jour les ressources"
  },
  TipsType_20100_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20100_Title = {
    Text = "Notification de mise à jour"
  },
  TipsType_20101_Desc = {
    Text = "Cette enquête est terminée, voulez-vous sauter l'histoire lors de la réenquête ?"
  },
  TipsType_20101_LeftBtnDesc = {
    Text = ": Passer la scène"
  },
  TipsType_20101_RightBtnDesc = {
    Text = "Conserver l'intrigue"
  },
  TipsType_20101_Title = {
    Text = "Confirmation du scénario"
  },
  TipsType_20102_Desc = {
    Text = "Êtes-vous sûr de ne plus suivre {s1} ?"
  },
  TipsType_20102_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20102_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20102_Title = {
    Text = "Se désabonner"
  },
  TipsType_20103_Desc = {
    Text = "Pendant l'événement<WeaponEffect_Num:gratuit limité>déverrouillage, déverrouiller ?"
  },
  TipsType_20103_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20103_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20103_Title = {
    Text = "Biens de l'événement"
  },
  TipsType_20105_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est recommandé de terminer les niveaux d'enquête suivants."
  },
  TipsType_20105_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20105_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20105_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20106_Desc = {
    Text = "Consommer <Blue:«Élixir de Cœur d'argent» × {s1} > pour acheter ?"
  },
  TipsType_20106_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20106_RightBtnDesc = {Text = "Acheter"},
  TipsType_20106_Title = {
    Text = "Confirmation d'achat"
  },
  TipsType_20107_Desc = {
    Text = "Êtes-vous sûr de vouloir sélectionner <Blue:{s1}> ?"
  },
  TipsType_20107_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20107_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20107_Title = {
    Text = "Confirmer le choix"
  },
  TipsType_20108_Desc = {
    Text = "Cette superposition consommera un objet rare « maître de boucle »\nSouhaitez-vous continuer ?"
  },
  TipsType_20108_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20108_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20108_Title = {
    Text = "Consommation confirmée"
  },
  TipsType_20109_Desc = {
    Text = "Es-tu sûr de vouloir recommencer cette bataille ?"
  },
  TipsType_20109_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20109_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20109_Title = {
    Text = "Reprendre le combat"
  },
  TipsType_20110_Desc = {
    Text = "Confirmer le choix du {s1} {s2} comme date de naissance ?\nUne fois confirmé, il ne pourra pas être modifié"
  },
  TipsType_20110_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20110_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20110_Title = {
    Text = "Confirmation d'anniversaire"
  },
  TipsType_20111_Desc = {
    Text = "Pour garantir la meilleure expérience scénaristique, il est conseillé de terminer les niveaux d'enquête suivants."
  },
  TipsType_20111_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20111_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20111_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20112_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est recommandé de terminer les niveaux d'enquête suivants."
  },
  TipsType_20112_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20112_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20112_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20113_Desc = {
    Text = "Voulez-vous marquer tout le contenu pédagogique comme lu et recevoir les récompenses ? (Il est conseillé aux nouveaux gardiens de lire attentivement le contenu pédagogique~)"
  },
  TipsType_20113_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20113_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20113_Title = {
    Text = "Lire et confirmer en un clic"
  },
  TipsType_20114_Desc = {
    Text = "Confirmer le choix de <WeaponEffect_Num:{s1}> pour activer le retour ?\nCette action est irréversible, veuillez confirmer avec prudence"
  },
  TipsType_20114_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20114_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20114_Title = {
    Text = "Choix de rétroaction"
  },
  TipsType_201151_Desc = {
    Text = "L'entité éveillée actuelle n'a pas été illuminée, pas besoin de faire une révision d'illumination."
  },
  TipsType_20115_Desc = {
    Text = "L'entité éveillée actuelle n'a pas été développée, pas besoin de régression"
  },
  TipsType_20116_Desc = {
    Text = "<WeaponEffect_Num:{s1}>Rétroaction activée.\nVoulez-vous y aller maintenant ?"
  },
  TipsType_20116_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20116_RightBtnDesc = {Text = "Aller"},
  TipsType_20116_Title = {
    Text = "Activation réussie"
  },
  TipsType_20117_Desc = {
    Text = "La réinitialisation de l'état de montée en niveau, d'ascension, des compétences, des dons et de la profondeur de la conscience du réveilleur va être effectuée, et les coûts correspondants seront remboursés. \nConfirmez-vous le retour en arrière pour <WeaponEffect_Num:{s1}> ?"
  },
  TipsType_20117_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20117_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20117_Title = {
    Text = "Réinitialisation du Développement"
  },
  TipsType_20118_Desc = {
    Text = "Le niveau d'éveil du réveilleur va être réinitialisé et les coûts d'éveil seront restitués.\nConfirmez-vous le retour à l'éveil pour <WeaponEffect_Num:{s1}> ?"
  },
  TipsType_20118_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20118_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20118_Title = {
    Text = "Réinitialisation d'Éveil"
  },
  TipsType_20119_Desc = {
    Text = "La réinitialisation de l'état d'amélioration, d'ascension, des compétences, de dégagement, des talents et d'approfondissement de la gnose du réveilleur va être effectuée, et les coûts correspondants seront remboursés, \n et le réveilleur sera renvoyé à la Genèse. \n Confirmez-vous le retour à la Genèse pour <WeaponEffect_Num:{s1}> ?"
  },
  TipsType_20119_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20119_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20119_Title = {
    Text = "Retour à la Genèse"
  },
  TipsType_20120_Desc = {
    Text = "Éveil spécial non retournable"
  },
  TipsType_20121_Desc = {
    Text = "Réinitialisation de l'état de pile de la roue du destin et retour de toutes les consommations de pile.\nConfirmer la réinitialisation de la pile pour <WeaponEffect_Num:{s1}> ?"
  },
  TipsType_20121_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20121_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20121_Title = {
    Text = "Retour en arrière d'empilement"
  },
  TipsType_20122_Desc = {
    Text = "La position empilée de la roue du destin va être réinitialisée, tous les coûts d'empilement seront restitués, et la roue sera renvoyée à la piscine noire.\nConfirmez-vous le retour à la piscine noire pour <WeaponEffect_Num:{s1}> ?"
  },
  TipsType_20122_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20122_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20122_Title = {
    Text = "Retour à la Genèse"
  },
  TipsType_20123_Desc = {
    Text = "Les réveils, roues de destin et clés de l'équipe ne pourront pas être utilisés dans d'autres zones de fusion après avoir terminé le défi. Confirmer ?"
  },
  TipsType_20123_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20123_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20123_Title = {
    Text = "Confirmation de défi"
  },
  TipsType_20124_Desc = {
    Text = "Après réinitialisation, les éveillés, les roues de destin et les clés de l'équipe d'enquête actuelle pourront être réutilisés, mais les points d'entraînement obtenus dans ce niveau seront déduits (sans affecter l'état des récompenses). Confirmer la réinitialisation ?"
  },
  TipsType_20124_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20124_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20124_Title = {
    Text = "Confirmation de réinitialisation"
  },
  TipsType_20125_Desc = {
    Text = "Niveau d'empilement actuel à 0, pas besoin de régression"
  },
  TipsType_20126_Desc = {
    Text = "Le réveilleur actuel est en cours d'envoi, veuillez le rappeler avant de revenir en arrière ou de retourner"
  },
  TipsType_20127_Desc = {
    Text = "Cycle actuel verrouillé, déverrouillez avant de le rendre"
  },
  TipsType_20128_Desc = {
    Text = "{s1} est terminé, réinitialisation nécessaire pour un nouveau défi, confirmer la réinitialisation ?\n(Après réinitialisation, les éveillés, les roues de destin et les clés de l'équipe d'exploration peuvent être réutilisés, mais les points d'entraînement obtenus seront déduits.)"
  },
  TipsType_20128_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20128_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20128_Title = {
    Text = "Confirmation de réinitialisation"
  },
  TipsType_20129_Desc = {
    Text = "Pour garantir la meilleure expérience scénaristique, il est recommandé de terminer les niveaux d'enquête suivants."
  },
  TipsType_20129_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20129_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20129_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20130_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est recommandé de terminer les niveaux d'enquête suivants."
  },
  TipsType_20130_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20130_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20130_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20131_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est conseillé de terminer les niveaux d'enquête suivants."
  },
  TipsType_20131_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20131_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20131_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20132_Desc = {
    Text = "Si <TipsHighlightText:Fragments de Pacte> sont suffisants, ils seront consommés en premier lors de la vérification.\nS'ils sont insuffisants, <TipsHighlightText:\"{s1}\"> seront automatiquement consommés pour combler la différence."
  },
  TipsType_20132_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20132_RightBtnDesc = {
    Text = "Toujours cocher"
  },
  TipsType_20132_Title = {
    Text = "Complétion automatique"
  },
  TipsType_20133_Desc = {
    Text = "Souhaitez-vous approfondir <TipsHighlightText:\"{s1}\"> avec Gnosis ?"
  },
  TipsType_20133_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20133_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20133_Title = {
    Text = "Avancée Gnostique"
  },
  TipsType_20134_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est conseillé de terminer les enquêtes suivantes."
  },
  TipsType_20134_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20134_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20134_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20137_Desc = {
    Text = "Confirmer la consommation de <Blue:\"{s1}\"×{s2}> pour déverrouiller ce morceau ?"
  },
  TipsType_20137_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20137_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20137_Title = {
    Text = "Confirmation de déverrouillage"
  },
  TipsType_20138_Desc = {
    Text = "Pendant l'événement <Blue:gratuit limité>déverrouillage, déverrouiller ?"
  },
  TipsType_20138_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20138_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20138_Title = {
    Text = "Confirmation de déverrouillage"
  },
  TipsType_20139_Desc = {
    Text = "Êtes-vous sûr de vouloir consommer <Blue:\"{s1}\"×{s3}> pour déverrouiller <Blue:\"{s2}\"?> ?"
  },
  TipsType_20139_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20139_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20139_Title = {
    Text = "Confirmation de déverrouillage"
  },
  TipsType_20140_Desc = {
    Text = "<Blue:\"{s1}\">Vous avez atteint la limite maximale. Réclamer davantage ne vous donnera pas d'objets supplémentaires. Voulez-vous le réclamer ?"
  },
  TipsType_20140_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20140_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20140_Title = {
    Text = "Confirmation de réclamation"
  },
  TipsType_20141_Desc = {
    Text = "Souhaites-tu payer 30% de ta santé max ({s1}) pour sauter le combat et éliminer l'ennemi immédiatement ? \n\n Santé actuelle : {s2}"
  },
  TipsType_20141_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20141_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20141_Title = {
    Text = "Mémoire musculaire"
  },
  TipsType_20142_Desc = {
    Text = "Souhaitez-vous perdre <color=#BB646D> {s1} </color> points de vie pour obtenir {s2} sigils noirs ?"
  },
  TipsType_20142_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20142_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20142_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20145_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20145_Title = {
    Text = "Récompense de connexion"
  },
  TipsType_20151_Desc = {
    Text = "Après réinitialisation, le nombre restant d'« objets spéciaux » sera réinitialisé à la limite, confirmer ?"
  },
  TipsType_20151_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20151_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20151_Title = {
    Text = "Confirmation de réinitialisation"
  },
  TipsType_20152_Desc = {
    Text = "{s1} insuffisant, souhaitez-vous utiliser un bon hors-serre doré *{s2} pour compléter ?"
  },
  TipsType_20152_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20152_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20152_Title = {
    Text = "Confirmation d'activation"
  },
  TipsType_20153_Desc = {
    Text = "Après réinitialisation, le nombre restant d'« objets spéciaux » et d'« objets ordinaires » sera réinitialisé à la limite.\nÀ partir de la {s1}e fois, les « objets spéciaux » ne seront plus réinitialisés.\nConfirmer ?"
  },
  TipsType_20153_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20153_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20153_Title = {
    Text = "Confirmation de réinitialisation"
  },
  TipsType_20154_Desc = {
    Text = "Après réinitialisation, le nombre restant d'« objets spéciaux » et d'« objets ordinaires » sera réinitialisé à la limite.\nÀ partir de la 3e fois, les « objets spéciaux » ne seront plus réinitialisés.\n<Blue:Il reste des « objets ordinaires »>, confirmer ?"
  },
  TipsType_20154_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20154_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20154_Title = {
    Text = "Confirmation de réinitialisation"
  },
  TipsType_20155_Desc = {
    Text = "Les matériaux d'empilement contiennent des roues de vie verrouillées, confirmer l'utilisation pour l'empilement ?"
  },
  TipsType_20155_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20155_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20155_Title = {
    Text = "Confirmation d'empilement"
  },
  TipsType_20156_Desc = {
    Text = "Souhaites-tu confirmer la consommation de <TipsHighlightText:Point de départ réel*1> pour déverrouiller ?\n(Pendant l'événement vague de désir, le nombre de Points de départ réel nécessaires pour déverrouiller passe de {s1} à {s2}.)"
  },
  TipsType_20156_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20156_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20156_Title = {
    Text = "Confirmation de déverrouillage"
  },
  TipsType_20157_Desc = {
    Text = "Souhaites-tu confirmer la consommation de <TipsHighlightText:Point de départ réel*{s1}> pour déverrouiller ?"
  },
  TipsType_20157_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20157_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20157_Title = {
    Text = "Confirmation de déverrouillage"
  },
  TipsType_20158_Desc = {
    Text = "Niveau actuel expiré, pas de récompense après le défi, confirmer la sortie ?"
  },
  TipsType_20158_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20158_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20158_Title = {
    Text = "Confirmation de sortie"
  },
  TipsType_20159_Desc = {
    Text = "<TipsHighlightText:«{s1}»> dépasse la limite de <TipsHighlightText: {s2}> unités, chacune a été convertie en <Blue:«Invitation de l'Incorporel» × 1>"
  },
  TipsType_20159_Title = {
    Text = "Indication de conversion"
  },
  TipsType_20160_Desc = {
    Text = "Vous avez débloqué <TipsHighlightText:«{s1}»>\nLe bonus gratuit de déverrouillage de cet événement vous offrira la compensation suivante :"
  },
  TipsType_20160_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20160_Title = {
    Text = "Notification de compensation"
  },
  TipsType_20161_Desc = {
    Text = "<TipsHighlightText:{s1}> dépasse la limite de <TipsHighlightText:{s2}> unités. Chaque excédent a été converti en <Blue:Rose dorée*5000>"
  },
  TipsType_20161_Title = {
    Text = "Indication de conversion"
  },
  TipsType_20162_Desc = {
    Text = "La réinitialisation de l'état de montée en niveau, d'ascension, des compétences, des dons et de la profondeur de la conscience du réveilleur va être effectuée, et les coûts correspondants seront remboursés. \nConfirmez-vous le retour en arrière pour <WeaponEffect_Num:{s1}> ?"
  },
  TipsType_20162_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20162_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20162_Title = {
    Text = "Réinitialisation du Développement"
  },
  TipsType_20163_Desc = {
    Text = "La réinitialisation de l'état d'illumination du réveilleur va être effectuée et les coûts correspondants seront remboursés. \nConfirmez-vous le retour en arrière pour <WeaponEffect_Num:{s1}> ?"
  },
  TipsType_20163_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20163_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20163_Title = {
    Text = "Réinitialisation d'Éveil"
  },
  TipsType_20164_Desc = {
    Text = "La réinitialisation de l'état d'amélioration, d'ascension, des compétences, des talents, de dégagement et d'avancée gnostique de l'éveilleur va être effectuée, et les coûts correspondants seront remboursés. \n De plus, l'éveilleur sera renvoyé à la Genèse. \n Confirmez-vous le retour à la Genèse pour <WeaponEffect_Num:{s1}> ?"
  },
  TipsType_20164_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20164_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20164_Title = {
    Text = "Retour à la Genèse"
  },
  TipsType_20165_Desc = {
    Text = "<WeaponEffect_Num:{s1}> appartient à un Éveilleur spécial, ne peut que rétrograder le développement de l'amélioration, de l'ascension, des compétences, des talents et de l'Avancée Gnostique, <Red: impossible de rétrograder le Dégagement>, confirmez-vous le choix de <WeaponEffect_Num:{s1}> pour activer le retour ?\nCette action est irréversible, veuillez confirmer avec prudence"
  },
  TipsType_20165_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20165_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20165_Title = {
    Text = "Choix de rétroaction"
  },
  TipsType_20166_Desc = {
    Text = "<Yellow:Réveilleur spécial><Del:« Réveilleur spécial »> ne peut pas subir de révision d'illumination"
  },
  TipsType_20167_Desc = {
    Text = "Cette rétroaction a déjà utilisé la <Révision de développement>, veuillez effectuer la <Révision de développement> lors de la prochaine ouverture de rétroaction."
  },
  TipsType_20168_Desc = {
    Text = "Cette session de rétrospective a déjà utilisé l'<Illuminer Récapitulation>, veuillez effectuer l'<Illuminer Récapitulation> lors de la prochaine session de rétrospective."
  },
  TipsType_20169_BottomDesc = {
    Text = "<Blue:Attention : Une fois la sélection confirmée, il ne sera plus possible de la modifier pour cette période d'activité !>"
  },
  TipsType_20169_Desc = {
    Text = "Êtes-vous sûr de vouloir sélectionner l'éveillé <OrangeQuality:« {s1} »> ainsi que la roue de destin recommandée <OrangeQuality:« {s2} »> comme cibles UP de cet événement ?"
  },
  TipsType_20169_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20169_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20169_Title = {
    Text = "Confirmer le choix"
  },
  TipsType_20170_Desc = {
    Text = "Limite de défis quotidiens atteinte, revenez relever des défis demain !"
  },
  TipsType_20171_Desc = {
    Text = "Maintenant, vous pouvez accéder à la « Plongée fantomale » !"
  },
  TipsType_20173_Desc = {
    Text = "Vous pouvez désormais accéder au « Traphase » !"
  },
  TipsType_20174_Desc = {
    Text = "Vous pouvez désormais partir en « Opération d'investigation · difficulté difficile » !"
  },
  TipsType_20175_Desc = {
    Text = "Maintenant, vous pouvez accéder à l'« Existence Transcendante » !"
  },
  TipsType_20176_Desc = {
    Text = "Maintenant, vous pouvez vous rendre à la « Zone de fusion » !"
  },
  TipsType_20177_Desc = {
    Text = "Vous pouvez maintenant vous diriger vers le « Frenzy de Reproduction » !"
  },
  TipsType_20178_Desc = {
    Text = "Vous pouvez maintenant équiper la « Deuxième roue du destin » !"
  },
  TipsType_20179_Desc = {
    Text = "Maintenant, vous pouvez vous rendre à l'« Essaim du chaos » !"
  },
  TipsType_20180_Desc = {
    Text = "Vous pouvez désormais accéder à la « Compilation de tabous » !"
  },
  TipsType_20181_Desc = {
    Text = "Vous pouvez désormais accéder à l'« Amélioration du pacte secret » !"
  },
  TipsType_20182_Desc = {
    Text = "Maintenant, vous pouvez accéder à la « Transcription du pacte secret » !"
  },
  TipsType_20183_Desc = {
    Text = "Événement actuel terminé"
  },
  TipsType_20184_Desc = {
    Text = "Le «Journal» est déverrouillé !"
  },
  TipsType_20185_Desc = {
    Text = "Confirmer le saut de toute l'histoire de ce passage ?"
  },
  TipsType_20185_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20185_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20185_Title = {
    Text = ": Passer la scène"
  },
  TipsType_20186_Desc = {
    Text = "Les données nécessaires au téléchargement et à l'exécution du jeu vont être téléchargées. \nVoulez-vous continuer ? \n\n* Il est recommandé de télécharger dans un environnement Wi-Fi."
  },
  TipsType_20186_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20186_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20187_Desc = {
    Text = "Téléchargement des ressources terminé"
  },
  TipsType_20187_LeftBtnDesc = {Text = "Confirmer"},
  TipsType_20188_Desc = {
    Text = "Espace de stockage insuffisant, veuillez libérer au moins {s1} d'espace de stockage, faute de quoi des ressources pourraient être perdues pendant l'exécution. Souhaitez-vous poursuivre le téléchargement ?"
  },
  TipsType_20188_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20188_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20189_Desc = {
    Text = "Échec du téléchargement des ressources, voulez-vous réessayer ?"
  },
  TipsType_20189_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20189_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20190_Desc = {
    Text = "<TipsHighlightText:{s1}>dépasse la limite de <TipsHighlightText: {s2} > unités, chacune a été convertie en <Blue:{s3}>"
  },
  TipsType_20190_Title = {
    Text = "Indication de conversion"
  },
  TipsType_20191_Desc = {
    Text = "Vous pouvez maintenant vous rendre à l'« Activité » !"
  },
  TipsType_20192_Desc = {
    Text = "Les données nécessaires pour jouer à la suite du prologue vont être téléchargées. \nTaille des ressources : {s1}\nVoulez-vous continuer ?\n\n* Il est recommandé de télécharger dans un environnement Wi-Fi."
  },
  TipsType_20192_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20192_RightBtnDesc = {
    Text = "Télécharger"
  },
  TipsType_20193_Desc = {
    Text = "Maintenant, vous pouvez accéder aux « Missions » !"
  },
  TipsType_20194_Desc = {
    Text = "Il est désormais possible de se rendre à la « Communication Noyau d'Argent » !"
  },
  TipsType_20195_Desc = {
    Text = "Vous pouvez désormais accéder au «Record de parcours» !"
  },
  TipsType_20196_Desc = {
    Text = "Maintenant, vous pouvez pénétrer dans le « Royaume sombre » !"
  },
  TipsType_20197_Desc = {
    Text = "Nombre maximum de réveils atteint, veuillez aller récupérer la récompense de mission !"
  },
  TipsType_20198_Desc = {
    Text = "Mission non terminée, veuillez revenir après l'avoir accomplie !"
  },
  TipsType_20199_Desc = {
    Text = "Après réclamation, le « Certificat d'agent » dépassera la limite de possession,\net l'excédent ne sera pas obtenu.\nVoulez-vous continuer ?"
  },
  TipsType_20199_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20199_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20199_Title = {
    Text = "Confirmation de réclamation"
  },
  TipsType_20200_Desc = {
    Text = "Confirmer l'utilisation de <Blue:Certificat d'agent*1> pour terminer instantanément la mission quotidienne ?"
  },
  TipsType_20200_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20200_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20200_Title = {
    Text = "Confirmation d'agent"
  },
  TipsType_20201_Desc = {
    Text = "Le pacte suivant est en cours d'équipement, souhaitez-vous procéder au remplacement ?"
  },
  TipsType_20201_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20201_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20201_Title = {
    Text = "Confirmer le remplacement"
  },
  TipsType_20202_Desc = {
    Text = "Es-tu sûr que tu veux supprimer le plan [{s2}] actuellement appliqué à {s1} ?"
  },
  TipsType_20202_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20202_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20202_Title = {
    Text = "Confirmation de suppression"
  },
  TipsType_20203_Desc = {
    Text = "Effet de Mandala identique ne peut pas se cumuler, {s1} est déjà équipé, confirmer l'équipement ?"
  },
  TipsType_20203_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20203_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20203_Title = {
    Text = "Confirmation de l'équipement"
  },
  TipsType_20204_Desc = {
    Text = "Le pacte actuel est utilisé dans {s1}, le décomposer le retirera de ce plan, confirmer ?"
  },
  TipsType_20204_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20204_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20204_Title = {
    Text = "Confirmation de suppression"
  },
  TipsType_20205_Desc = {
    Text = "Le pacte actuel a été utilisé dans la composition {s1}, la décomposition retirera ce pacte, confirmez-vous ?"
  },
  TipsType_20205_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20205_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20205_Title = {
    Text = "Confirmation de suppression"
  },
  TipsType_20206_Desc = {
    Text = "Le cycle actuel a été utilisé dans la composition {s1}, la décomposition supprimera ce cycle de la composition, confirmez-vous ?"
  },
  TipsType_20206_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20206_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20206_Title = {
    Text = "Confirmation de suppression"
  },
  TipsType_20207_Desc = {
    Text = "Plan non sauvegardé, quitter effacera les modifications. Confirmer ?"
  },
  TipsType_20207_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20207_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20207_Title = {
    Text = "Confirmation de sauvegarde"
  },
  TipsType_20208_Desc = {
    Text = "Récompense de mission reçue, allez voir les autres missions !"
  },
  TipsType_20209_Desc = {
    Text = "Mission expirée"
  },
  TipsType_20210_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est recommandé de terminer les niveaux d'enquête suivants."
  },
  TipsType_20210_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20210_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20210_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20211_Desc = {
    Text = "Début dans {s1} jours {s2} heures"
  },
  TipsType_20212_Desc = {
    Text = "Début dans {s1} heures {s2} minutes"
  },
  TipsType_20213_Desc = {
    Text = "<WeaponEffect_Num:{s1}> a déclenché une causalité excessive dans l'escouade, toute rétroaction entraînera l'annulation de la causalité excessive, et sera automatiquement retiré de l'escouade. Confirmer le choix de <WeaponEffect_Num:{s1}> pour activer la rétroaction ?\nCette action est irréversible, veuillez confirmer avec prudence"
  },
  TipsType_20213_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20213_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20213_Title = {
    Text = "Choix de rétroaction"
  },
  TipsType_20214_Desc = {
    Text = "La position empilée de la roue du destin va être réinitialisée, et toutes les consommations de pile seront restituées. \n<WeaponEffect_Num:{s1}> a déjà déclenché une causalité excessive dans l'escouade, elle sera automatiquement retirée de l'escouade après le retour en arrière. \nConfirmez-vous le retour en arrière pour <WeaponEffect_Num:{s1}> ?"
  },
  TipsType_20214_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20214_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20214_Title = {
    Text = "Retour en arrière d'empilement"
  },
  TipsType_20215_Desc = {
    Text = "La position empilée de la roue du destin va être réinitialisée, tous les coûts d'empilement seront restitués, et la roue sera renvoyée à la Genèse. \n<WeaponEffect_Num:{s1}> a déjà déclenché une causalité excédentaire dans l'escouade, elle sera automatiquement retirée de l'escouade après le retour. \nConfirmez-vous le retour à la Genèse pour <WeaponEffect_Num:{s1}> ?"
  },
  TipsType_20215_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20215_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20215_Title = {
    Text = "Retour à la Genèse"
  },
  TipsType_20216_Desc = {
    Text = "Voulez-vous acheter avec <Blue:{s1} × {s2}> ?"
  },
  TipsType_20216_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20216_RightBtnDesc = {Text = "Acheter"},
  TipsType_20216_Title = {
    Text = "Confirmation d'achat"
  },
  TipsType_20217_Desc = {
    Text = "{s1} sera ouvert après {s2}."
  },
  TipsType_20218_Desc = {
    Text = "Les éveillés présélectionnés pour cette enquête ne peuvent pas être remplacés, il est uniquement possible de les remplacer par les éveillés correspondants."
  },
  TipsType_20219_Desc = {
    Text = "Un même éveillé est déjà déployé, impossible de le sélectionner à nouveau."
  },
  TipsType_20220_Desc = {
    Text = "Wi-Fi non détecté, le téléchargement consommera beaucoup de données, voulez-vous confirmer le téléchargement ? \nTaille des ressources : {s1}\nContinuer ?"
  },
  TipsType_20220_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20220_RightBtnDesc = {
    Text = "Télécharger"
  },
  TipsType_20221_Desc = {
    Text = "Téléchargement des ressources terminé"
  },
  TipsType_20221_LeftBtnDesc = {Text = "Confirmer"},
  TipsType_20222_Desc = {
    Text = "Espace de stockage insuffisant, veuillez libérer au moins {s1} d'espace de stockage, faute de quoi des ressources pourraient être perdues pendant l'exécution. Souhaitez-vous poursuivre le téléchargement ?"
  },
  TipsType_20222_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20222_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20223_Desc = {
    Text = "Échec du téléchargement des ressources, voulez-vous réessayer ?"
  },
  TipsType_20223_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20223_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20224_Desc = {
    Text = "Les données nécessaires pour jouer à la suite du prologue vont être téléchargées. \nTaille des ressources : {s1}\nVoulez-vous continuer ?\n\n* Il est recommandé de télécharger dans un environnement Wi-Fi."
  },
  TipsType_20224_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20224_RightBtnDesc = {
    Text = "Télécharger"
  },
  TipsType_20225_Desc = {
    Text = "{s1} est terminé, souhaitez-vous relever un défi supplémentaire ?\nUn défi supplémentaire permet d'obtenir {s2} points d'entraînement"
  },
  TipsType_20225_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20225_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20225_Title = {
    Text = "Défi supplémentaire"
  },
  TipsType_20226_Desc = {
    Text = "Après réinitialisation, les éveillés, les décrets clés et les roues du destin de l'équipe de défi supplémentaire pourront être réutilisés, mais les points d'entraînement supplémentaires obtenus dans ce niveau seront déduits (sans affecter l'état des récompenses). Confirmez-vous la réinitialisation ?"
  },
  TipsType_20226_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20226_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20226_Title = {
    Text = "Confirmation de réinitialisation"
  },
  TipsType_20227_Desc = {
    Text = "Après réinitialisation, les éveilleurs, les décrets clés et les roues du destin de l'équipe d'enquête actuelle pourront être réutilisés, et l'équipe de défi supplémentaire remplacera l'équipe d'enquête actuelle, mais les points d'entraînement obtenus lors de la réussite supplémentaire de ce niveau seront également déduits (sans affecter l'état des récompenses). Confirmer la réinitialisation ?"
  },
  TipsType_20227_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20227_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20227_Title = {
    Text = "Confirmation de réinitialisation"
  },
  TipsType_20228_Desc = {
    Text = "Faites glisser la liste vers le bas pour voir plus d'annonces"
  },
  TipsType_20229_Desc = {
    Text = "<Blue:{s1}> a atteint la limite de niveau d'ascension.\nVoulez-vous continuer à acheter ?\nQuantité restante : {s2}"
  },
  TipsType_20229_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20229_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20229_Title = {
    Text = "Confirmation d'achat"
  },
  TipsType_20230_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est conseillé de terminer les niveaux d'enquête suivants."
  },
  TipsType_20230_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20230_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20230_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20231_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est conseillé de terminer les niveaux d'enquête suivants."
  },
  TipsType_20231_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20231_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20231_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20232_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est recommandé de terminer les niveaux d'enquête suivants."
  },
  TipsType_20232_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20232_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20232_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20233_Desc = {
    Text = "Matériaux insuffisants pour l'actuel, voulez-vous utiliser les matériaux suivants pour compléter ?"
  },
  TipsType_20233_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20233_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20233_Title = {Text = "Confirmer"},
  TipsType_20234_Desc = {
    Text = "Ce niveau ne permet d'équiper que les clés spécifiées et il est impossible de les remplacer."
  },
  TipsType_20235_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est recommandé de terminer les niveaux d'enquête suivants."
  },
  TipsType_20235_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20235_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20235_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20236_Desc = {
    Text = "Pour garantir la meilleure expérience scénaristique, il est conseillé de terminer les enquêtes suivantes."
  },
  TipsType_20236_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20236_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20236_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20237_Desc = {
    Text = "Pour garantir la meilleure expérience scénaristique, il est recommandé de terminer les niveaux d'enquête suivants."
  },
  TipsType_20237_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20237_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20237_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20238_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est conseillé de terminer les enquêtes suivantes."
  },
  TipsType_20238_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20238_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20238_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20239_Desc = {
    Text = "Pour garantir la meilleure expérience scénaristique, il est conseillé de terminer les niveaux d'enquête suivants."
  },
  TipsType_20239_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20239_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20239_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20240_Desc = {
    Text = "Réparation terminée, veuillez redémarrer le jeu"
  },
  TipsType_20240_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20240_Title = {
    Text = "Conseil amical"
  },
  TipsType_20241_Desc = {
    Text = "Il vous faut encore {s1} « <Blue:{s2}> » pour atteindre la limite de niveau d'empilement.\nSouhaitez-vous continuer l'achat ?"
  },
  TipsType_20241_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20241_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20241_Title = {
    Text = "Confirmation d'achat"
  },
  TipsType_20250_Desc = {
    Text = "Pour garantir la meilleure expérience scénaristique, il est conseillé de terminer les niveaux d'enquête suivants."
  },
  TipsType_20250_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20250_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20250_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20251_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est conseillé de terminer les niveaux d'enquête suivants."
  },
  TipsType_20251_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20251_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20251_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20252_Desc = {
    Text = "Pour garantir la meilleure expérience scénaristique, il est conseillé de terminer les niveaux d'enquête suivants."
  },
  TipsType_20252_LeftBtnDesc = {Text = "Quitter"},
  TipsType_20252_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_20252_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20259_Desc = {
    Text = "Réglage de remplacement sauvegardé pour l'insuffisance de « Sceau des Mille Visages »"
  },
  TipsType_20300_Desc = {
    Text = "Un {s1} réveillé déjà localisé, impossible d'utiliser le même type dans l'équipe"
  },
  TipsType_20301_Desc = {
    Text = "Vous pouvez maintenant passer aux \"Tâches Régulières !\""
  },
  TipsType_20351_Desc = {
    Text = "{s1} insuffisant, souhaitez-vous utiliser {s2}{s3} pour échanger contre {s4}{s5} ?"
  },
  TipsType_20351_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20351_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20351_Title = {
    Text = "{s1} insuffisant"
  },
  TipsType_20352_Desc = {
    Text = "Vous allez être lié à l'autre partie. Une fois le lien établi, il ne pourra plus être annulé. Confirmez-vous vouloir poursuivre cette action ?"
  },
  TipsType_20352_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20352_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20352_Title = {
    Text = "Confirmer l'invitation"
  },
  TipsType_20353_Desc = {
    Text = "Le code d'invitation a été copié dans le presse-papiers."
  },
  TipsType_20354_Desc = {
    Text = "Vous êtes déjà l'invitant de l'autre joueur."
  },
  TipsType_20355_Desc = {
    Text = "Vous ne pouvez pas saisir votre propre code d'invitation. Essayez plutôt d'obtenir le code d'invitation d'un autre Gardien du Secret."
  },
  TipsType_20356_Desc = {
    Text = "Rejouer permet de revivre l'introduction narrative et le tutoriel ! \nCependant, lors du rejouage, toutes les récompenses des niveaux sont démonstratives et ne peuvent pas être obtenues réellement. \nConfirmer ?"
  },
  TipsType_20356_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20356_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20356_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_20357_Desc = {
    Text = "Es-tu sûr de ne plus prêter attention à ce gardien {s1} ?"
  },
  TipsType_20357_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20357_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20357_Title = {
    Text = "Se désabonner"
  },
  TipsType_20358_Desc = {
    Text = "Il y a des désabonnements non confirmés, quitter ne sauvegardera aucune opération. Voulez-vous vraiment partir ?"
  },
  TipsType_20358_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20358_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20358_Title = {
    Text = "Confirmation de sortie"
  },
  TipsType_20400_Desc = {
    Text = "<WeaponEffect_Num:«{s1}»> insuffisant, souhaitez-vous aller échanger ?"
  },
  TipsType_20400_LeftBtnDesc = {Text = "Annuler"},
  TipsType_20400_RightBtnDesc = {Text = "Confirmer"},
  TipsType_20400_Title = {
    Text = "Objets de loterie insuffisants"
  },
  TipsType_300001_Desc = {
    Text = "« Éclat initial de l'argent » vous offre une seule chance d'éveil gratuit. Confirmez-vous son utilisation ?"
  },
  TipsType_300001_LeftBtnDesc = {Text = "Annuler"},
  TipsType_300001_RightBtnDesc = {Text = "Confirmer"},
  TipsType_300001_Title = {
    Text = "Confirmation de l'éveil"
  },
  TipsType_300002_Desc = {
    Text = "Voulez-vous confirmer le résultat de cet éveil ? La confirmation entraînera la consommation d'un tirage gratuit de 5 invocations consécutives"
  },
  TipsType_300002_LeftBtnDesc = {Text = "Annuler"},
  TipsType_300002_RightBtnDesc = {Text = "Confirmer"},
  TipsType_300002_Title = {
    Text = "Confirmation de l'éveil"
  },
  TipsType_30001_Desc = {
    Text = "Pas d'icône pour l'alerte latérale"
  },
  TipsType_30003_Desc = {
    Text = "Débloqué {s1}"
  },
  TipsType_30004_Desc = {
    Text = "Mode avancé débloqué pour {s1}"
  },
  TipsType_30005_Desc = {
    Text = "Débloqué (difficile) {s1}"
  },
  TipsType_31000_Desc = {
    Text = "Confirmer l'utilisation de cette date de naissance pour la vérification ? La date de naissance ne pourra plus être modifiée une fois confirmée !"
  },
  TipsType_31000_LeftBtnDesc = {Text = "Annuler"},
  TipsType_31000_RightBtnDesc = {Text = "Confirmer"},
  TipsType_31000_Title = {
    Text = "Vérification d'âge"
  },
  TipsType_31001_Desc = {
    Text = "Ce mois-ci, vous avez déjà effectué une recharge de <Blue:{s1}> yuans. La limite est fixée à <Blue:{s2}> yuans. Veuillez réessayer le mois prochain ou choisir un montant de recharge inférieur."
  },
  TipsType_31002_Desc = {
    Text = "Veuillez d'abord effectuer la vérification d'âge"
  },
  TipsType_31003_Desc = {
    Text = "La clé d'argent détecte un danger mortel, activer l'entité spirituelle d'urgence ?\n(La résurrection consommera une entité spirituelle d'urgence, une entité spirituelle d'urgence est obtenue automatiquement chaque jour à 9h, nombre restant actuel : {s1})\n<Blue:(La première résurrection ne consomme pas d'entité spirituelle d'urgence)>"
  },
  TipsType_31003_LeftBtnDesc = {Text = "Annuler"},
  TipsType_31003_RightBtnDesc = {Text = "Confirmer"},
  TipsType_31003_Title = {
    Text = "Confirmation de résurrection"
  },
  TipsType_31004_Desc = {
    Text = "La clé d'argent détecte un danger mortel, activer l'entité spirituelle d'urgence ?\n(La résurrection consommera une entité spirituelle d'urgence, une entité spirituelle d'urgence est obtenue automatiquement chaque jour à 9h, nombre restant actuel : {s1})\n<Blue:(La première résurrection ne consomme pas d'entité spirituelle d'urgence)>"
  },
  TipsType_31004_RightBtnDesc = {Text = "Confirmer"},
  TipsType_31004_Title = {
    Text = "Confirmation de résurrection"
  },
  TipsType_40001_Desc = {
    Text = "Quand la vie tombe à 0, l'enquête se termine de force"
  },
  TipsType_40001_Title = {Text = "PV"},
  TipsType_40002_Desc = {
    Text = "Le déplacement sur la carte et l'enquête entraîneront une pression mentale, et l'accumulation de pression fera subir des symptômes au Gardien. \n Chaque déplacement d'une case augmente la pression de 10 points. Pour chaque 100 points de pression, un symptôme est obtenu. \n Lorsque la pression atteint 500, chaque déplacement d'une case coûte 10 % des PV."
  },
  TipsType_40002_Title = {Text = "Stress"},
  TipsType_40003_Desc = {
    Text = "Le niveau de mission plus élevé, plus la difficulté de la mission, plus la récompense obtenue par l'envoi sera élevée"
  },
  TipsType_40003_Title = {
    Text = "Niveau de mission"
  },
  TipsType_40004_Desc = {
    Text = "La copie temporaire de la 1ère carte d'instruction jouée chaque tour entre dans l'espace hyperspatial. \n Lorsque l'espace hyperspatial atteint sa limite, gagnez un tour ultra supplémentaire et gardez un bouclier. \n Effet de maîtrise des royaumes : au début du tour, il y a une probabilité d'ajouter 1 carte « perspicacité » à votre main."
  },
  TipsType_40004_Title = {
    Text = "Espace Hyperspatial"
  },
  TipsType_40005_Desc = {
    Text = "Le gardien peut améliorer son niveau à travers des enquêtes, des interludes et d'autres défis. Plus de mécanismes seront progressivement débloqués avec l'augmentation du niveau du gardien"
  },
  TipsType_40005_Title = {Text = "Niveau"},
  TipsType_40006_Desc = {
    Text = "Jouer une carte d'instruction nécessite de consommer de l'arithmetica. À la fin du tour, l'arithmetica restante ne sera pas conservée, et au début du tour, l'arithmetica sera restaurée à son maximum."
  },
  TipsType_40006_Title = {
    Text = "Arithmetica"
  },
  TipsType_40007_Desc = {
    Text = "La clé en argent perçoit une onde d'énergie spéciale, la carte pourrait cacher des ressources précieuses"
  },
  TipsType_40007_Title = {
    Text = "Masquer les ressources"
  },
  TipsType_40008_Desc = {
    Text = "Peut être déclenché lors d'une crise mortelle pendant le combat, coûtant 1 chaque fois, rendant la vie du gardien et la folie du réveilleur à leur maximum, obtenant automatiquement 1 chaque jour à 9 heures"
  },
  TipsType_40008_Title = {
    Text = "Corps de Gnosis d'urgence"
  },
  TipsType_40009_Desc = {
    Text = "Jouer une carte de commande nécessite de consommer de l'arithmétique. À la fin du tour, l'arithmétique restante ne sera pas conservée, le plafond d'arithmétique augmentera de +1 et l'arithmétique sera restaurée à son maximum. Nous sommes maintenant au tour {s1}"
  },
  TipsType_40009_Title = {
    Text = "Arithmetica"
  },
  TipsType_AbyssChallengeResetTips_Desc = {
    Text = "La zone interdite de Fusion de calamités a été réinitialisée. Le défi en cours prendra fin immédiatement."
  },
  TipsType_AbyssChallengeResetTips_RightBtnDesc = {Text = "Confirmer"},
  TipsType_AbyssChallengeResetTips_Title = {
    Text = "Avertissement"
  },
  TipsType_AbyssChallengeRevivalTips_Desc = {
    Text = "La Clé d'argent perçoit une crise fatale. Activer le Corps de Gnosis d'urgence ?\n(La Résurrection consomme 1 Corps de Gnosis d'urgence. Vous en recevez 1 par jour à 9h.)"
  },
  TipsType_AbyssChallengeRevivalTips_LeftBtnDesc = {Text = "Annuler"},
  TipsType_AbyssChallengeRevivalTips_RightBtnDesc = {Text = "Confirmer"},
  TipsType_AbyssChallengeRevivalTips_Title = {
    Text = "Confirmation de résurrection"
  },
  TipsType_AcceptConfirm_Desc = {
    Text = "Voulez-vous accepter l'invitation de <Blue:{s1}> pour <Blue:{s2}> ?"
  },
  TipsType_AcceptConfirm_LeftBtnDesc = {Text = "Refuser"},
  TipsType_AcceptConfirm_RightBtnDesc = {Text = "Accepter"},
  TipsType_AcceptConfirm_Title = {
    Text = "Combat de mot de passe"
  },
  TipsType_ActivitySignRewardTaskNotCompleteTips_Desc = {
    Text = "Effectuez la tâche correspondante pour pouvoir réveiller"
  },
  TipsType_AlreadyIsBackgroundMusicTips_Desc = {
    Text = "Déjà la musique de fond actuelle"
  },
  TipsType_AwakerAutoInsertCoinNotEnoughTips_Desc = {
    Text = "Les «Billets Rose Dorée» sont insuffisants pour utiliser pleinement les «Élixirs de Sagesse» actuellement possédés. Veuillez compléter vos «Billets Rose Dorée» avant de réessayer."
  },
  TipsType_AwakerNotOpenTips_Desc = {
    Text = "L›Éveilleur n›est pas encore disponible. Restez à l›écoute !"
  },
  TipsType_AwakerRandomChestConfirm_Desc = {
    Text = "Confirmer l'utilisation de <Blue:{s1}> pour obtenir 1 Corps éveillé <Blue:aléatoire> ?"
  },
  TipsType_AwakerRandomChestConfirm_LeftBtnDesc = {Text = "Annuler"},
  TipsType_AwakerRandomChestConfirm_RightBtnDesc = {Text = "Confirmer"},
  TipsType_AwakerRandomChestConfirm_Title = {
    Text = "Confirmation d'utilisation"
  },
  TipsType_BattleCreateFail_Desc = {
    Text = "Échec de la création du combat"
  },
  TipsType_BattlePassAllCompleteTips_Desc = {
    Text = "Toutes les Archives actuelles ont été complétées."
  },
  TipsType_BestExperienceTips_Chapter3_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est conseillé de terminer les enquêtes suivantes."
  },
  TipsType_BestExperienceTips_Chapter3_LeftBtnDesc = {Text = "Quitter"},
  TipsType_BestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_BestExperienceTips_Chapter3_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_BestExperienceTips_Chapter7_Desc = {
    Text = "Pour garantir la meilleure expérience scénaristique, il est conseillé de terminer les niveaux d'enquête suivants."
  },
  TipsType_BestExperienceTips_Chapter7_LeftBtnDesc = {Text = "Quitter"},
  TipsType_BestExperienceTips_Chapter7_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_BestExperienceTips_Chapter7_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_BestExperienceTips_Chapter8_Desc = {
    Text = "Pour garantir la meilleure expérience scénaristique, il est recommandé de terminer les niveaux d'enquête suivants."
  },
  TipsType_BestExperienceTips_Chapter8_LeftBtnDesc = {Text = "Quitter"},
  TipsType_BestExperienceTips_Chapter8_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_BestExperienceTips_Chapter8_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_BestExperienceTips_ChapterS2_Desc = {
    Text = "Pour garantir la meilleure expérience scénaristique, il est conseillé de terminer les niveaux d'enquête suivants."
  },
  TipsType_BestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "Quitter"},
  TipsType_BestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_BestExperienceTips_ChapterS2_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_BestExperienceTips_ChapterS3_Desc = {
    Text = "Pour garantir la meilleure expérience scénaristique, il est conseillé de terminer les niveaux d'enquête suivants."
  },
  TipsType_BestExperienceTips_ChapterS3_LeftBtnDesc = {Text = "Quitter"},
  TipsType_BestExperienceTips_ChapterS3_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_BestExperienceTips_ChapterS3_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_BestExperienceTips_ChapterS4_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est conseillé de terminer les enquêtes suivantes."
  },
  TipsType_BestExperienceTips_ChapterS4_LeftBtnDesc = {Text = "Quitter"},
  TipsType_BestExperienceTips_ChapterS4_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_BestExperienceTips_ChapterS4_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_BestExperienceTips_ChapterS5_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est conseillé de terminer les enquêtes suivantes."
  },
  TipsType_BestExperienceTips_ChapterS5_LeftBtnDesc = {Text = "Quitter"},
  TipsType_BestExperienceTips_ChapterS5_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_BestExperienceTips_ChapterS5_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est conseillé de terminer les enquêtes suivantes."
  },
  TipsType_BestExperienceTips_MainStoryS1_6_LeftBtnDesc = {Text = "Quitter"},
  TipsType_BestExperienceTips_MainStoryS1_6_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est conseillé de terminer les enquêtes suivantes."
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_LeftBtnDesc = {Text = "Quitter"},
  TipsType_BestExperienceTips_TwoAnniversarySubStage_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_CancelCollectAwakerTips_Desc = {Text = "Annulé"},
  TipsType_CoinBulkBuyConfirm_Desc = {
    Text = "Souhaitez-vous dépenser «Bon Rose» × {s1} pour effectuer cet achat ?"
  },
  TipsType_CoinBulkBuyConfirm_LeftBtnDesc = {Text = "Annuler"},
  TipsType_CoinBulkBuyConfirm_RightBtnDesc = {Text = "Confirmer"},
  TipsType_CoinBulkBuyConfirm_Title = {
    Text = "Confirmation d'achat"
  },
  TipsType_CollectAwakerTips_Desc = {
    Text = "Collection réussie"
  },
  TipsType_CommonUseBattleHelpLimitTips_Desc = {
    Text = "Le nombre d'assistance au combat courante du Gardien a atteint sa limite, veuillez ajuster la liste d'assistance au combat courante"
  },
  TipsType_DiskIsFullOrViolation_Desc = {
    Text = "Échec du chargement des fichiers. Veuillez vérifier votre espace de stockage."
  },
  TipsType_DiskIsFullOrViolation_RightBtnDesc = {Text = "Confirmer"},
  TipsType_DiskSpaceNotEnough_Desc = {
    Text = "Espace de stockage insuffisant, souhaitez-vous continuer à essayer de télécharger ?"
  },
  TipsType_DiskSpaceNotEnough_LeftBtnDesc = {Text = "Annuler"},
  TipsType_DiskSpaceNotEnough_RightBtnDesc = {Text = "Confirmer"},
  TipsType_DoubleExBPBuyConfirm_Desc = {
    Text = "Souhaites-tu consommer <Blue:«Élixir» × {s1} > pour acheter ?\n <color=#ACBFCA>Cette période propose des sujets spéciaux, avec un prix réduit pour les sujets principaux</color>"
  },
  TipsType_DoubleExBPBuyConfirm_LeftBtnDesc = {Text = "Annuler"},
  TipsType_DoubleExBPBuyConfirm_RightBtnDesc = {Text = "Acheter"},
  TipsType_DoubleExBPBuyConfirm_Title = {
    Text = "Confirmation d'achat"
  },
  TipsType_EnterSix_DigitPasswordTips_Desc = {
    Text = "Veuillez entrer <color=#5EF2FF>valeur de phase</color>"
  },
  TipsType_FilterMaxAwakerCountTips_Desc = {
    Text = "Sélectionnez jusqu'à {s1} Corps éveillés à filtrer"
  },
  TipsType_FollowBackConfirm_Desc = {
    Text = "Êtes-vous sûr de suivre les <color=#5EF2FF>{s1}</color> suiveurs de la page actuelle ?\n\n<color=#96947F>Suivi actuel </color>{s2}<color=#A0A0A0>/{s3}\nImpossible de suivre après avoir atteint la limite</color>"
  },
  TipsType_FollowBackConfirm_LeftBtnDesc = {Text = "Annuler"},
  TipsType_FollowBackConfirm_RightBtnDesc = {Text = "Confirmer"},
  TipsType_FollowBackConfirm_Title = {
    Text = "Confirmation de retour"
  },
  TipsType_FrenziedOmenUpgradeConfirm_Desc = {
    Text = "Cette opération consommera une grande quantité de ressources. Elle est adaptée aux situations où vous souhaitez développer les capacités de l'Éveilleur jusqu'à leurs limites. Confirmer le Renforcement du «Présage de Folie» ?"
  },
  TipsType_FrenziedOmenUpgradeConfirm_LeftBtnDesc = {Text = "Annuler"},
  TipsType_FrenziedOmenUpgradeConfirm_RightBtnDesc = {Text = "Confirmer"},
  TipsType_FrenziedOmenUpgradeConfirm_Title = {
    Text = "Confirmation de renforcement"
  },
  TipsType_GnosticPotentialUpgradeConfirm_Desc = {
    Text = "Cette opération consommera une grande quantité de ressources. Elle est adaptée aux situations où vous souhaitez développer les capacités de l'Éveilleur jusqu'à leurs limites. Confirmer le Renforcement du «Potentiel gnostique» ?"
  },
  TipsType_GnosticPotentialUpgradeConfirm_LeftBtnDesc = {Text = "Annuler"},
  TipsType_GnosticPotentialUpgradeConfirm_RightBtnDesc = {Text = "Confirmer"},
  TipsType_GnosticPotentialUpgradeConfirm_Title = {
    Text = "Confirmation de renforcement"
  },
  TipsType_InCharging_Desc = {
    Text = "Commande en cours de traitement, veuillez ne pas effectuer de paiement multiple. \n Si le paiement est déjà effectué, veuillez patienter pour que le système délivre la récompense. \n Si le paiement n'est pas terminé, veuillez essayer de redémarrer le jeu puis réessayer. \n Si vous avez des questions, veuillez contacter le service client."
  },
  TipsType_InCharging_RightBtnDesc = {Text = "Confirmer"},
  TipsType_InCharging_Title = {
    Text = "Conseil amical"
  },
  TipsType_KeyShortNameDownLoadTips_Desc = {
    Text = "Téléchargement des ressources d'identification de texte en cours, veuillez réessayer plus tard"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_Desc = {
    Text = "Le Dégagement de cet Éveilleur est déjà complet.\nAprès la sélection, vous n'obtiendrez que «Fragment de rembobinage d'âme» ×2"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_LeftBtnDesc = {Text = "Annuler"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_RightBtnDesc = {
    Text = ": Continuer"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_Title = {
    Text = "Confirmer le choix"
  },
  TipsType_MainResetBG_Desc = {
    Text = "Avez-vous besoin de restaurer l'arrière-plan du dortoir <Blue:«écran»> et <Blue:«musique»> par défaut ?"
  },
  TipsType_MainResetBG_LeftBtnDesc = {Text = "Annuler"},
  TipsType_MainResetBG_RightBtnDesc = {Text = "Confirmer"},
  TipsType_MainResetBG_Title = {
    Text = "Rétablir par défaut"
  },
  TipsType_MultiSelectBox_FixItemTips_Desc = {
    Text = "Objet fixe obtenu, ne peut pas être modifié"
  },
  TipsType_MultiSelectBox_SelectTips_Desc = {
    Text = "Veuillez compléter la sélection de tous les articles auto-sélectionnés avant de procéder à l'achat"
  },
  TipsType_OppositeSideCancelMatchTips_Desc = {
    Text = "L'adversaire a annulé le match"
  },
  TipsType_OppositeSideRejectTips_Desc = {
    Text = "L'adversaire a refusé l'invitation de <Blue:{s1}>, veuillez choisir à nouveau le mode"
  },
  TipsType_PVEExceedMaxRoundsTips_Desc = {
    Text = "Le nombre de tours de combat a atteint la limite\n\nÔ unique Gardien du secret\nQuel choix allez-vous faire maintenant ?"
  },
  TipsType_PVEExceedMaxRoundsTips_LeftBtnDesc = {
    Text = "Reprendre le combat"
  },
  TipsType_PVEExceedMaxRoundsTips_RightBtnDesc = {
    Text = "Retraite temporaire"
  },
  TipsType_PVEExceedMaxRoundsTips_Title = {
    Text = "Échec de l'enquête"
  },
  TipsType_PVEReplayErrorTips_Desc = {
    Text = "Erreur lors de l'obtention de la rediffusion du combat, veuillez réessayer plus tard"
  },
  TipsType_PVEReplayMaxRounds_Desc = {
    Text = [[
La lecture a atteint la limite maximale de 25 tours, 
 fin de la lecture.]]
  },
  TipsType_PVEReplayMaxRounds_RightBtnDesc = {Text = "Confirmer"},
  TipsType_PVEReplayMaxRounds_Title = {
    Text = "Confirmer la fin"
  },
  TipsType_PVEReplayNoDataTips_Desc = {
    Text = "Aucun enregistrement de mission d'enquête"
  },
  TipsType_PVEReplayRepeatClickTips_Desc = {
    Text = "Chargement de la relecture du combat, veuillez ne pas répéter l'opération"
  },
  TipsType_PVEReplaySpecialTeamAssignTips_Desc = {
    Text = "La lecture des combats avec des formations spéciales n'est pas encore prise en charge, restez à l'écoute"
  },
  TipsType_PVEReplayTimeoutTips_Desc = {
    Text = "Délai d'attente pour obtenir l'enregistrement du combat dépassé"
  },
  TipsType_PVEReplayUnableOperateTips_Desc = {
    Text = "Impossible d'effectuer des actions pendant la lecture du combat"
  },
  TipsType_PVETeamShareCodeCopyTips_Desc = {
    Text = "Copié dans le presse-papiers"
  },
  TipsType_PVETeamShareCodeError_Desc = {
    Text = "Échec de l'identification correcte de la formation <color=#5EF2FF>Mission d'enquête</color> dans le presse-papiers"
  },
  TipsType_PVETeamShareCodeSaveTips_Desc = {
    Text = "Voulez-vous confirmer la sauvegarde de la configuration d'équipe correspondant au code d'escouade ?\nLes parties non en main de cette configuration seront laissées vides."
  },
  TipsType_PVETeamShareCodeSaveTips_LeftBtnDesc = {Text = "Annuler"},
  TipsType_PVETeamShareCodeSaveTips_RightBtnDesc = {Text = "Confirmer"},
  TipsType_PVETeamShareCodeSaveTips_Title = {
    Text = "Confirmation de sauvegarde"
  },
  TipsType_PVETeamShareCodeSpecialTeamAssignTips_Desc = {
    Text = "Cette équipe contient un éveillé prédéfini, impossible de copier ou d'importer le code d'escouade"
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_Desc = {
    Text = "La partie a atteint la limite de tours. Le joueur en premier n'a pas réussi à mettre Fin à la partie et est déclaré perdant."
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_RightBtnDesc = {Text = "Confirmer"},
  TipsType_PVPExceedMaxRoundsTips_Loser_Title = {
    Text = "Fin du duel"
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_Desc = {
    Text = "La partie a atteint la limite de tours. Le joueur en second a réussi à tenir jusqu'à la Fin de la partie et est déclaré vainqueur."
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_RightBtnDesc = {Text = "Confirmer"},
  TipsType_PVPExceedMaxRoundsTips_Winner_Title = {
    Text = "Fin du duel"
  },
  TipsType_PVPSurrenderConfirm_Desc = {
    Text = "Vous rendez-vous ?"
  },
  TipsType_PVPSurrenderConfirm_LeftBtnDesc = {Text = "Annuler"},
  TipsType_PVPSurrenderConfirm_RightBtnDesc = {Text = "Confirmer"},
  TipsType_PVPSurrenderConfirm_Title = {
    Text = "Confirmer la reddition"
  },
  TipsType_PVPTeamShareCodeError_Desc = {
    Text = "Impossible d'identifier correctement la formation <color=#5EF2FF>Échecs de Phase</color> dans le presse-papiers"
  },
  TipsType_PVP_PasswordBattle_BlockTips_Desc = {
    Text = "Faut-il bloquer ce Gardien du Secret ?"
  },
  TipsType_PVP_PasswordBattle_BlockTips_LeftBtnDesc = {Text = "Refuser"},
  TipsType_PVP_PasswordBattle_BlockTips_RightBtnDesc = {Text = "Accepter"},
  TipsType_PVP_PasswordBattle_BlockTips_Title = {
    Text = "Voulez-vous bloquer"
  },
  TipsType_PVP_PasswordBattle_GameStartedTips_Desc = {
    Text = "Ce combat de mot de passe a commencé"
  },
  TipsType_PVP_PasswordBattle_OthersEnterTips_Desc = {
    Text = "Un nouveau gardien est entré dans ce tour de la bataille cryptographique"
  },
  TipsType_PVP_PasswordBattle_QueueTips_Desc = {
    Text = "Actuellement dans la file d'attente..."
  },
  TipsType_PVP_PasswordBattle_QuitTips_Desc = {
    Text = "Voulez-vous sortir de la bataille de mots de passe ?"
  },
  TipsType_PVP_PasswordBattle_QuitTips_LeftBtnDesc = {Text = "Annuler"},
  TipsType_PVP_PasswordBattle_QuitTips_RightBtnDesc = {Text = "Quitter"},
  TipsType_PVP_PasswordBattle_QuitTips_Title = {
    Text = "Confirmation de sortie"
  },
  TipsType_PVP_PasswordBattle_RejectedTips_Desc = {
    Text = "L'adversaire a refusé de se battre contre vous"
  },
  TipsType_PassportHoistTips1_Desc = {
    Text = "«Ion actif basique»\n·Après déblocage, les «Point de départ réel», «Cœur Immaculé», «Expérience» et «Cœur d'argent» obtenus dans les récompenses cumulées d'«Ion actif basique» de l'«Entraînement quotidien» pendant cette période de Sujet principal seront multipliés par 3. Après l'achat du «Sujet principal», la partie du multiplicateur supplémentaire des récompenses cumulées d'«Ion actif basique» déjà réclamées pendant cette période sera rétroactivement accordée."
  },
  TipsType_PassportHoistTips2_Desc = {
    Text = "«Inversion temporelle»\n·Peut revenir aux tours vécus pendant le combat.\n·Peut retourner à n'importe quel tour parmi les 25 tours précédents du combat.\n·La fonction de retour peut toujours être utilisée pour revenir aux tours précédents après avoir relancé le défi."
  },
  TipsType_PassportHoistTips3_Desc = {
    Text = "«Échecs de Phase»\n·Après déblocage, toutes les cartes de «Échecs de Phase» peuvent être utilisées pendant la durée de ce sujet."
  },
  TipsType_Password_CopiedTips_Desc = {
    Text = "<color=#5EF2FF>La valeur de phase</color> a été copiée dans le presse-papiers"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_Desc = {
    Text = "Voulez-vous dépenser <Blue:«Élixir» × {s1} >pour acheter ?\n\n<size=30><color=#ACBFCA>Lors de la consommation d'«Élixir», l'«Élixir» offert est déduit en priorité.\n(Extrait : {s2}, Offert : {s3})</color></size>"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_LeftBtnDesc = {Text = "Annuler"},
  TipsType_PayMoneyBuyConfirmDescDetail_RightBtnDesc = {Text = "Acheter"},
  TipsType_PayMoneyBuyConfirmDescDetail_Title = {
    Text = "Confirmation d'achat"
  },
  TipsType_PublishEmptyCommentTips_Desc = {
    Text = "Le contenu du commentaire ne peut pas être vide"
  },
  TipsType_PvpCollectionCommentDeleteTips_Desc = {
    Text = "Confirmer la suppression de ce commentaire ?"
  },
  TipsType_PvpCollectionCommentDeleteTips_LeftBtnDesc = {Text = "Annuler"},
  TipsType_PvpCollectionCommentDeleteTips_RightBtnDesc = {Text = "Confirmer"},
  TipsType_PvpCollectionCommentDeleteTips_Title = {
    Text = "Confirmation de suppression"
  },
  TipsType_PvpHideCommentConfirm_Desc = {
    Text = "Confirmer de cacher tous ses commentaires ?"
  },
  TipsType_PvpHideCommentConfirm_LeftBtnDesc = {Text = "Non"},
  TipsType_PvpHideCommentConfirm_RightBtnDesc = {Text = "Oui"},
  TipsType_PvpHideCommentConfirm_Title = {Text = "Cacher"},
  TipsType_PvpMatchingInterruptTips_Desc = {
    Text = "Anomalie réseau détectée, la recherche de match a été interrompue."
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Desc = {
    Text = "Vous êtes encore en combat. Souhaitez-vous reprendre le combat précédent ? \n La saison du «Train du Plaisir effréné» a été mise à jour. Continuer le défi vous permettra d'accomplir les missions de la dernière saison, mais vous ne pourrez pas accéder à la «Liste des VIP»."
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_LeftBtnDesc = {Text = "Annuler"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_RightBtnDesc = {Text = "Confirmer"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Title = {
    Text = "Avertissement"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Desc = {
    Text = "La progression du dernier défi était {s1} - Phase {s2} - Combat {s3}, «Points VIP» obtenus × {s4}\nLa saison a été mise à jour. Continuer le défi vous permettra d'accomplir les missions de la dernière saison, mais vous ne pourrez pas accéder à la «Liste des VIP». Souhaitez-vous continuer le défi ?"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_LeftBtnDesc = {Text = "Annuler"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_RightBtnDesc = {Text = "Confirmer"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Title = {
    Text = "Continuer le défi"
  },
  TipsType_RailWayContinueSaveStage_Desc = {
    Text = "Reprendre la progression : {s1} - Phase {s2} - Combat {s3}.\nPoints VIP gagnés : {s4}.\nContinuer le défi ?"
  },
  TipsType_RailWayContinueSaveStage_LeftBtnDesc = {Text = "Annuler"},
  TipsType_RailWayContinueSaveStage_RightBtnDesc = {Text = "Confirmer"},
  TipsType_RailWayContinueSaveStage_Title = {
    Text = "Continuer le défi"
  },
  TipsType_RailWayHaveSaveStage_Desc = {
    Text = "Vous devez terminer le défi précédemment enregistré avant de pouvoir en commencer un nouveau"
  },
  TipsType_RailWaySaveAndExitInBattleTips_Desc = {
    Text = "Souhaitez-vous confirmer de quitter le défi ?\nLa progression de ce défi sera enregistrée, et vous continuerez à partir de la progression actuelle lors du prochain défi, et cette bataille sera relancée."
  },
  TipsType_RailWaySaveAndExitInBattleTips_LeftBtnDesc = {Text = "Annuler"},
  TipsType_RailWaySaveAndExitInBattleTips_RightBtnDesc = {Text = "Confirmer"},
  TipsType_RailWaySaveAndExitInBattleTips_Title = {
    Text = "Sauvegarder et quitter"
  },
  TipsType_RailWaySaveAndExitTips_Desc = {
    Text = "Voulez-vous confirmer de quitter le défi ?\nLes progrès de ce défi seront sauvegardés et vous continuerez à partir de la progression actuelle lors du prochain défi."
  },
  TipsType_RailWaySaveAndExitTips_LeftBtnDesc = {Text = "Annuler"},
  TipsType_RailWaySaveAndExitTips_RightBtnDesc = {Text = "Confirmer"},
  TipsType_RailWaySaveAndExitTips_Title = {
    Text = "Sauvegarder et quitter"
  },
  TipsType_RailWaySeasonSwitchTips_Desc = {
    Text = "La saison a été mise à jour. Continuer le défi vous permettra d'accomplir les missions de la dernière saison, mais vous ne pourrez pas accéder à la «Liste des VIP»."
  },
  TipsType_ReplayNullTips_Desc = {
    Text = "Les informations de lecture ne peuvent pas être vides"
  },
  TipsType_SchoolConflictTips_Desc = {
    Text = "Conflit de royaume. Veuillez réajuster la composition."
  },
  TipsType_SelectedAwakensAndCardsExceedLimit_Desc = {
    Text = "Le nombre sélectionné a été dépassé"
  },
  TipsType_ServerRankDataLoading_Desc = {
    Text = "Les données de ce classement n'ont pas encore été entièrement chargées. Veuillez rouvrir l'interface ultérieurement."
  },
  TipsType_ServerRankDataLoading_RightBtnDesc = {Text = "Confirmer"},
  TipsType_ServerRankDataLoading_Title = {
    Text = "Initialisation des données du classement du serveur en cours"
  },
  TipsType_ShopBulkBuyConfirm_Desc = {
    Text = "<Blue:{s1}> {s2} seront utilisés pour échanger contre <Blue:{s3}> {s4}. Confirmer l'échange ?"
  },
  TipsType_ShopBulkBuyConfirm_LeftBtnDesc = {Text = "Annuler"},
  TipsType_ShopBulkBuyConfirm_RightBtnDesc = {Text = "Confirmer"},
  TipsType_ShopBulkBuyConfirm_Title = {
    Text = "Confirmation de Rédemption"
  },
  TipsType_SocialRecordHideTips_Desc = {
    Text = "Les archives de combat sont masquées"
  },
  TipsType_SteamOverlayEnabledTips_Desc = {
    Text = "Veuillez activer l'option «Activer l'interface Steam en jeu» dans «Steam - Paramètres - En jeu» ainsi que dans «Propriétés - Général» du jeu, puis redémarrez le jeu et réessayez."
  },
  TipsType_SteamOverlayEnabledTips_LeftBtnDesc = {Text = "Confirmer"},
  TipsType_SteamOverlayEnabledTips_Title = {
    Text = "Conseil amical"
  },
  TipsType_SteamRestartTips_Desc = {
    Text = "Anomalie d'autorisation Steam. Veuillez redémarrer le client Steam et réessayer."
  },
  TipsType_SteamRestartTips_RightBtnDesc = {Text = "Confirmer"},
  TipsType_SteamRestartTips_Title = {
    Text = "Anomalie de connexion"
  },
  TipsType_SubBestExperienceTips_Chapter3_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est conseillé de terminer les enquêtes suivantes."
  },
  TipsType_SubBestExperienceTips_Chapter3_LeftBtnDesc = {Text = "Quitter"},
  TipsType_SubBestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_SubBestExperienceTips_Chapter3_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_SubBestExperienceTips_Chapter5_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est conseillé de terminer les enquêtes suivantes."
  },
  TipsType_SubBestExperienceTips_Chapter5_LeftBtnDesc = {Text = "Quitter"},
  TipsType_SubBestExperienceTips_Chapter5_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_SubBestExperienceTips_Chapter5_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Desc = {
    Text = "Pour garantir la meilleure expérience de scénario, il est conseillé de terminer les enquêtes suivantes."
  },
  TipsType_SubBestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "Quitter"},
  TipsType_SubBestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "Toujours enquêter"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Title = {
    Text = "Confirmation de l'enquête"
  },
  TipsType_SummonFailureTips_Desc = {
    Text = "Le coût des matériaux d'Éveil a changé, veuillez réessayer le Ré-éveil"
  },
  TipsType_SummonPriorityNotEnoughTips_Desc = {
    Text = "Il vous manque {s1} <Blue:«{s2}»>. Consommer <Blue:{s4} × {s3} > à la place ?"
  },
  TipsType_SummonPriorityNotEnoughTips_LeftBtnDesc = {Text = "Annuler"},
  TipsType_SummonPriorityNotEnoughTips_RightBtnDesc = {Text = "Confirmer"},
  TipsType_SummonPriorityNotEnoughTips_Title = {
    Text = "Confirmation de Rédemption"
  },
  TipsType_SummonType_14SelectConfirm_BottomDesc = {
    Text = "<Blue:Attention : Une fois la sélection confirmée, il ne sera plus possible de la modifier pour cette période d'activité !>"
  },
  TipsType_SummonType_14SelectConfirm_Desc = {
    Text = "Êtes-vous sûr de vouloir sélectionner l'éveillé <OrangeQuality:« {s1} », « {s2} », « {s3} », « {s4} »> comme cible UP de cet événement ?"
  },
  TipsType_SummonType_14SelectConfirm_LeftBtnDesc = {Text = "Annuler"},
  TipsType_SummonType_14SelectConfirm_RightBtnDesc = {Text = "Confirmer"},
  TipsType_SummonType_14SelectConfirm_Title = {
    Text = "Confirmer le choix"
  },
  TipsType_SummonType_14SelectLimitTips_BottomDesc = {
    Text = "<Blue:Attention : Une fois la sélection confirmée, il ne sera plus possible de la modifier pour cette période d'activité !>"
  },
  TipsType_SummonType_14SelectLimitTips_Desc = {
    Text = "Limite de quantité atteinte"
  },
  TipsType_SummonType_17IncompleteSelectionTips_Desc = {
    Text = "Veuillez compléter tous les types de sélections avant de réessayer"
  },
  TipsType_SummonType_17SelectConfirm_Desc = {
    Text = "Confirmer la sélection désignée de l'Éveilleur ?\nUne fois confirmée, la sélection de cette période ne pourra plus être modifiée."
  },
  TipsType_SummonType_17SelectConfirm_LeftBtnDesc = {Text = "Annuler"},
  TipsType_SummonType_17SelectConfirm_RightBtnDesc = {Text = "Confirmer"},
  TipsType_SummonType_17SelectConfirm_Title = {
    Text = "Confirmer le choix"
  },
  TipsType_SupportListLatestTips_Desc = {
    Text = "Vous êtes déjà à jour ! Suivez davantage de camarades pour obtenir plus de choix d'Assistance au combat !"
  },
  TipsType_TrinketAutoRefineExitTips_Desc = {
    Text = "Transcription automatique en cours, opération indisponible."
  },
  TipsType_TrinketAutoRefineTips_BottomDesc = {
    Text = "(La transcription automatique s'arrête lorsqu'une statistique déverrouillée atteint 8.)"
  },
  TipsType_TrinketAutoRefineTips_Desc = {
    Text = "Transcrire jusqu'à {s1} fois\nConsommer jusqu'à"
  },
  TipsType_TrinketAutoRefineTips_LeftBtnDesc = {Text = "Annuler"},
  TipsType_TrinketAutoRefineTips_RightBtnDesc = {Text = "Confirmer"},
  TipsType_TrinketAutoRefineTips_Title = {
    Text = "Confirmation de transcription automatique"
  },
  TipsType_TrinketBagFullTips_Desc = {
    Text = "Le sac de Pactes est plein"
  },
  TipsType_TrinketBatchUnbindTips_Desc = {
    Text = "Délier tous les Pactes ?"
  },
  TipsType_TrinketBatchUnbindTips_LeftBtnDesc = {Text = "Annuler"},
  TipsType_TrinketBatchUnbindTips_RightBtnDesc = {Text = "Confirmer"},
  TipsType_TrinketBatchUnbindTips_Title = {
    Text = "Confirmation de déliaison"
  },
  TipsType_TrinketBindSaveTips_Desc = {
    Text = "Des Pactes liés sont présents, impossible de sauvegarder en tant que plan !"
  },
  TipsType_TrinketBindTips_Desc = {
    Text = "Confirmer la combinaison des Pactes suivants ? Les Pactes équipés par d'autres Éveilleurs ou présents dans une équipe/configuration/soutien seront automatiquement retirés."
  },
  TipsType_TrinketBindTips_LeftBtnDesc = {Text = "Annuler"},
  TipsType_TrinketBindTips_RightBtnDesc = {Text = "Confirmer"},
  TipsType_TrinketBindTips_Title = {
    Text = "Confirmation de modification du lien"
  },
  TipsType_TrinketChangeBindTips_Desc = {
    Text = "Confirmer la modification du lien ?"
  },
  TipsType_TrinketChangeBindTips_LeftBtnDesc = {Text = "Annuler"},
  TipsType_TrinketChangeBindTips_RightBtnDesc = {Text = "Confirmer"},
  TipsType_TrinketChangeBindTips_Title = {
    Text = "Confirmation de modification du Lié"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_Desc = {
    Text = "Délier tous les ensembles de Pactes ?\n\n<color=#9BA3A2><size=30>+12 pièces de Pacte seront consommées.</size></color>"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_LeftBtnDesc = {Text = "Annuler"},
  TipsType_TrinketHighLevelBatchUnbindTips_RightBtnDesc = {Text = "Confirmer"},
  TipsType_TrinketHighLevelBatchUnbindTips_Title = {
    Text = "Confirmation de déliaison"
  },
  TipsType_TrinketHighLevelChangeBindTips_Desc = {
    Text = "Confirmer le changement ?\n\n<color=#9BA3A2><size=30>+12 pièces de Pacte seront consommées.</size></color>"
  },
  TipsType_TrinketHighLevelChangeBindTips_LeftBtnDesc = {Text = "Annuler"},
  TipsType_TrinketHighLevelChangeBindTips_RightBtnDesc = {Text = "Confirmer"},
  TipsType_TrinketHighLevelChangeBindTips_Title = {
    Text = "Confirmation de modification du Lié"
  },
  TipsType_TrinketHighLevelUnbindTips_Desc = {
    Text = "Délier cet ensemble de Pactes ?\n\n<color=#9BA3A2><size=30>+12 pièces de Pacte seront consommées.</size></color>"
  },
  TipsType_TrinketHighLevelUnbindTips_LeftBtnDesc = {Text = "Annuler"},
  TipsType_TrinketHighLevelUnbindTips_RightBtnDesc = {Text = "Confirmer"},
  TipsType_TrinketHighLevelUnbindTips_Title = {
    Text = "Confirmation de déliaison"
  },
  TipsType_TrinketUnbindTips_Desc = {
    Text = "Confirmer la déliaison de ce Pacte ?"
  },
  TipsType_TrinketUnbindTips_LeftBtnDesc = {Text = "Annuler"},
  TipsType_TrinketUnbindTips_RightBtnDesc = {Text = "Confirmer"},
  TipsType_TrinketUnbindTips_Title = {
    Text = "Confirmation de déliaison"
  },
  TipsType_TryAgainLaterTips_Desc = {
    Text = "La <color=#5EF2FF>valeur de phase</color> est actuellement en utilisation, veuillez réessayer plus tard"
  },
  TipsType_WaitOppositeSideAccept_Desc = {
    Text = [[
En attente
{s1}
d'accepter l'invitation de <Blue:{s2}>]]
  },
  TipsType_WaitOppositeSideAccept_LeftBtnDesc = {Text = "Annuler"},
  TipsType_WaitOppositeSideAccept_Title = {
    Text = "Combat par mot de passe"
  },
  TipsType_WaitOthersEnter_Desc = {
    Text = [[
Attente d'autres Gardiens pour saisir
<Blue:{s1}>
mot de passe correspondant combat]]
  },
  TipsType_WaitOthersEnter_LeftBtnDesc = {Text = "Annuler"},
  TipsType_WaitOthersEnter_RightBtnDesc = {
    Text = "Copier <color=#5EF2FF>valeur de phase</color>"
  },
  TipsType_WaitOthersEnter_Title = {
    Text = "Combat par mot de passe"
  },
  TipsType_WeaponRandomChestConfirm_Desc = {
    Text = "Confirmer l'utilisation de <Blue:{s1}> pour obtenir 1 Roue du Destin <Blue:aléatoire> ?"
  },
  TipsType_WeaponRandomChestConfirm_LeftBtnDesc = {Text = "Annuler"},
  TipsType_WeaponRandomChestConfirm_RightBtnDesc = {Text = "Confirmer"},
  TipsType_WeaponRandomChestConfirm_Title = {
    Text = "Confirmation d'utilisation"
  },
  TipsType_WeekChallengeSweepTips_Desc = {
    Text = "Nombre de récompenses hebdomadaires épuisé, impossible de reproduire."
  }
})
return Text_TipsType
